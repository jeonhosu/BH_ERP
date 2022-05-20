CREATE OR REPLACE PACKAGE FI_MANAGEMENT_BALANCE_G
AS
-- 보조장부 조회.
  PROCEDURE MANAGEMENT_BALANCE_SELECT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_GL_DATE_FR        IN FI_MANAGEMENT_BALANCE.GL_DATE%TYPE
            , P_GL_DATE_TO        IN FI_MANAGEMENT_BALANCE.GL_DATE%TYPE
            , P_SOB_ID            IN FI_MANAGEMENT_BALANCE.SOB_ID%TYPE
            , P_ACCOUNT_CONTROL_ID  IN FI_MANAGEMENT_BALANCE.ACCOUNT_CONTROL_ID%TYPE
            , P_MANAGEMENT_ID     IN FI_MANAGEMENT_BALANCE.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT_VALUE  IN FI_MANAGEMENT_BALANCE.MANAGEMENT_VALUE%TYPE
            );

-- 일자별 계정별 관리항목별 잔액 관리.
  PROCEDURE MANAGEMENT_BALANCE_SAVE_P
            ( P_GUBUN             IN VARCHAR2
            , P_GL_DATE           IN FI_MANAGEMENT_BALANCE.GL_DATE%TYPE
            , P_SOB_ID            IN FI_MANAGEMENT_BALANCE.SOB_ID%TYPE
            , P_ORG_ID            IN FI_MANAGEMENT_BALANCE.ORG_ID%TYPE
            , P_ACCOUNT_CONTROL_ID  IN FI_MANAGEMENT_BALANCE.ACCOUNT_CONTROL_ID%TYPE
            , P_MANAGEMENT_ID     IN FI_MANAGEMENT_BALANCE.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT_VALUE  IN FI_MANAGEMENT_BALANCE.MANAGEMENT_VALUE%TYPE
            , P_ACCOUNT_DR_CR     IN VARCHAR2
            , P_GL_AMOUNT         IN NUMBER
            , P_CURRENCY_CODE     IN FI_MANAGEMENT_BALANCE.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE     IN FI_MANAGEMENT_BALANCE.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT  IN NUMBER
            , P_ACCOUNT_CODE      IN FI_MANAGEMENT_BALANCE.ACCOUNT_CODE%TYPE
            , P_USER_ID           IN FI_MANAGEMENT_BALANCE.CREATED_BY%TYPE
            );
END FI_MANAGEMENT_BALANCE_G;
/
CREATE OR REPLACE PACKAGE BODY FI_MANAGEMENT_BALANCE_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : FI_MANAGEMENT_BALANCE_G
/* DESCRIPTION  : 보조장 조회(계정별 관리항목별 잔액 관리)
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION      VERSION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE         1.0
/******************************************************************************/
-- 보조장부 조회.
  PROCEDURE MANAGEMENT_BALANCE_SELECT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_GL_DATE_FR        IN FI_MANAGEMENT_BALANCE.GL_DATE%TYPE
            , P_GL_DATE_TO        IN FI_MANAGEMENT_BALANCE.GL_DATE%TYPE
            , P_SOB_ID            IN FI_MANAGEMENT_BALANCE.SOB_ID%TYPE
            , P_ACCOUNT_CONTROL_ID  IN FI_MANAGEMENT_BALANCE.ACCOUNT_CONTROL_ID%TYPE
            , P_MANAGEMENT_ID     IN FI_MANAGEMENT_BALANCE.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT_VALUE  IN FI_MANAGEMENT_BALANCE.MANAGEMENT_VALUE%TYPE
            )
  AS
  BEGIN
     BEGIN
      -- 이월자료 생성.
      DELETE FROM FI_MANAGEMENT_BALANCE_GT
      ;
      
      -- 이월 잔액 산출.
      INSERT INTO FI_MANAGEMENT_BALANCE_GT
      ( GL_DATE
      , SOB_ID
      , ACCOUNT_CONTROL_ID
      , ACCOUNT_CODE
      , MANAGEMENT_ID
      , MANAGEMENT_VALUE      
      , DR_SUM
      , CR_SUM
      , REMAIN_SUM
      , REMARK
      )
      SELECT P_GL_DATE_FR - 1 AS GL_DATE
           , FAC.SOB_ID
           , FAC.ACCOUNT_CONTROL_ID
           , FAC.ACCOUNT_CODE   
           , P_MANAGEMENT_ID AS MANAGEMENT_ID
           , P_MANAGEMENT_VALUE AS MANAGEMENT_VALUE           
           , NVL(SUM(PX1.DR_AMOUNT), 0) AS DR_AMOUNT
           , NVL(SUM(PX1.CR_AMOUNT), 0) AS CR_AMOUNT
           , NVL(SUM(CASE
                       WHEN FAC.ACCOUNT_DR_CR = '1' THEN NVL(PX1.DR_AMOUNT, 0) - NVL(PX1.CR_AMOUNT, 0)
                       WHEN FAC.ACCOUNT_DR_CR = '2' THEN NVL(PX1.CR_AMOUNT, 0) - NVL(PX1.DR_AMOUNT, 0)
                       ELSE 0
                     END), 0) AS REMAIN_AMOUNT
           , EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10165', NULL) AS REMARK
        FROM FI_ACCOUNT_CONTROL FAC
          , ( SELECT AC.ACCOUNT_CONTROL_ID AS ACCOUNT_CONTROL_ID
                   , AC.ACCOUNT_CODE AS ACCOUNT_CODE
                   , AC.ACCOUNT_DR_CR
                   , 0 AS DR_AMOUNT
                   , 0 AS CR_AMOUNT
                FROM FI_ACCOUNT_CONTROL AC
              WHERE AC.ACCOUNT_CONTROL_ID     = P_ACCOUNT_CONTROL_ID
              UNION ALL
              SELECT MB.ACCOUNT_CONTROL_ID
                   , MB.ACCOUNT_CODE
                   , AC.ACCOUNT_DR_CR      -- 잔액 구분.
                   , MB.DR_SUM AS DR_AMOUNT
                   , MB.CR_SUM AS CR_AMOUNT
                FROM FI_MANAGEMENT_BALANCE MB
                  , FI_ACCOUNT_CONTROL AC
               WHERE MB.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
                 AND MB.GL_DATE               = TRUNC(P_GL_DATE_FR, 'YEAR')
                 AND MB.GL_DATE_SEQ           = 0
                 AND MB.SOB_ID                = P_SOB_ID
                 AND MB.ACCOUNT_CONTROL_ID    = P_ACCOUNT_CONTROL_ID
                 AND MB.MANAGEMENT_ID         = P_MANAGEMENT_ID
                 AND MB.MANAGEMENT_VALUE      = P_MANAGEMENT_VALUE
              UNION ALL
              -- 1일 ~ 시작(GL_DATE_FR-1) 전일까지의 잔액금액 계산.
              SELECT MB.ACCOUNT_CONTROL_ID
                   , MB.ACCOUNT_CODE
                   , AC.ACCOUNT_DR_CR      -- 잔액 구분.
                   , DECODE(AC.ACCOUNT_DR_CR, '1', NVL(MB.DR_SUM, 0) - NVL(MB.CR_SUM, 0)) AS DR_AMOUNT
                   , DECODE(AC.ACCOUNT_DR_CR, '2', NVL(MB.CR_SUM, 0) - NVL(MB.DR_SUM, 0)) AS CR_AMOUNT
                FROM FI_MANAGEMENT_BALANCE MB
                  , FI_ACCOUNT_CONTROL AC
               WHERE MB.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
                 AND MB.GL_DATE               BETWEEN TRUNC(P_GL_DATE_FR, 'YEAR') AND P_GL_DATE_FR - 1
                 AND MB.GL_DATE_SEQ           = 1
                 AND MB.SOB_ID                = P_SOB_ID
                 AND MB.ACCOUNT_CONTROL_ID    = P_ACCOUNT_CONTROL_ID
                 AND MB.MANAGEMENT_ID         = P_MANAGEMENT_ID
                 AND MB.MANAGEMENT_VALUE      = P_MANAGEMENT_VALUE
              ) PX1
      WHERE FAC.ACCOUNT_CONTROL_ID            = PX1.ACCOUNT_CONTROL_ID(+)
        AND FAC.ACCOUNT_CONTROL_ID            = P_ACCOUNT_CONTROL_ID
        AND FAC.SOB_ID                        = P_SOB_ID
      GROUP BY FAC.SOB_ID
           , FAC.ACCOUNT_CONTROL_ID
           , FAC.ACCOUNT_CODE
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    
    OPEN P_CURSOR FOR
      SELECT CASE
               WHEN SX1.SORT_NUM = 0 THEN TO_DATE(NULL)
               ELSE SX1.GL_DATE
            END GL_DATE
          , SX1.SOB_ID
          , CASE
              WHEN GROUPING (TO_CHAR(SX1.GL_DATE, 'YYYY-MM')) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10259', NULL)
              WHEN GROUPING (SX1.GL_DATE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10260', NULL)
              ELSE SX1.REMARK
            END AS REMARK
          , SX1.ACCOUNT_CONTROL_ID
          , SX1.MANAGEMENT_ID
          , SX1.MANAGEMENT_VALUE
          , SX1.MANAGEMENT_DESC
          , CASE
              WHEN GROUPING (TO_CHAR(SX1.GL_DATE, 'YYYY-MM')) = 1 THEN SUM(SX1.DR_SUM)
              WHEN GROUPING (SX1.GL_DATE) = 1 THEN SUM(SX1.MONTH_DR_SUM)
              ELSE SUM(SX1.DR_SUM)
            END AS DR_SUM
          , CASE
              WHEN GROUPING (TO_CHAR(SX1.GL_DATE, 'YYYY-MM')) = 1 THEN SUM(SX1.CR_SUM)
              WHEN GROUPING (SX1.GL_DATE) = 1 THEN SUM(SX1.MONTH_CR_SUM)
              ELSE SUM(SX1.CR_SUM)
            END AS CR_SUM
          , CASE
              WHEN ROW_NUMBER() OVER (PARTITION BY SX1.ACCOUNT_CONTROL_ID, SX1.GL_DATE ORDER BY SX1.ACCOUNT_CONTROL_ID, SX1.GL_DATE, SX1.SORT_NUM)
                   < COUNT(*) OVER (PARTITION BY SX1.ACCOUNT_CONTROL_ID, SX1.GL_DATE ORDER BY SX1.ACCOUNT_CONTROL_ID, SX1.GL_DATE, SX1.SORT_NUM) THEN 0
              ELSE SUM(SX1.REMAIN_SUM) OVER (ORDER BY SX1.ACCOUNT_CONTROL_ID, SX1.GL_DATE, SX1.SORT_NUM)
            END AS REMAIN_AMOUNT
          /*, SUM(SX1.DR_SUM) AS DR_SUM
          , SUM(SX1.CR_SUM) AS CR_SUM
          , CASE
              WHEN ROW_NUMBER() OVER (PARTITION BY SX1.ACCOUNT_CONTROL_ID ORDER BY SX1.ACCOUNT_CONTROL_ID, SX1.GL_DATE, SX1.SORT_NUM)
                   < COUNT(*) OVER (PARTITION BY SX1.ACCOUNT_CONTROL_ID ORDER BY SX1.ACCOUNT_CONTROL_ID, SX1.GL_DATE, SX1.SORT_NUM) THEN 0
              ELSE SUM(SX1.REMAIN_SUM) OVER (PARTITION BY SX1.ACCOUNT_CONTROL_ID ORDER BY SX1.ACCOUNT_CONTROL_ID, SX1.GL_DATE, SX1.SORT_NUM)
            END AS REMAIN_AMOUNT*/
          , SX1.GL_NUM
          , SX1.SLIP_HEADER_ID
        FROM ( SELECT MBG.GL_DATE + 1 AS GL_DATE
                    , MBG.SOB_ID
                    , MBG.REMARK
                    , MBG.ACCOUNT_CONTROL_ID
                    , MBG.ACCOUNT_CODE
                    , MBG.MANAGEMENT_ID
                    , TO_CHAR(NULL) AS MANAGEMENT_VALUE --MBG.MANAGEMENT_VALUE
                    , NULL AS MANAGEMENT_DESC
                    , MBG.DR_SUM
                    , MBG.CR_SUM
                    , MBG.REMAIN_SUM
                    , 0 AS MONTH_DR_SUM
                    , 0 AS MONTH_CR_SUM
                    , NULL AS GL_NUM
                    , NULL AS SLIP_HEADER_ID
                    , NULL AS SLIP_LINE_ID
                    , 0 AS SORT_NUM
                FROM FI_MANAGEMENT_BALANCE_GT MBG
                WHERE MBG.ACCOUNT_CONTROL_ID     = P_ACCOUNT_CONTROL_ID
                  AND MBG.GL_DATE                = P_GL_DATE_FR - 1
                  AND MBG.SOB_ID                 = P_SOB_ID
                -------------------------------------------------------------------------------
                UNION ALL
                -------------------------------------------------------------------------------
                SELECT SL.GL_DATE AS  GL_DATE         -- 회계일자(Account Date)
                     , FAC.SOB_ID
                     , SL.REMARK
                     , FAC.ACCOUNT_CONTROL_ID
                     , FAC.ACCOUNT_CODE
                     , SMI.MANAGEMENT_ID
                     , SMI.MANAGEMENT_VALUE
                     , NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                        , SL.ACCOUNT_DR_CR
                                                                        , CASE
                                                                            WHEN SMI.MANAGEMENT_SEQ < 3 THEN 'MANAGEMENT' || TO_CHAR(SMI.MANAGEMENT_SEQ) || '_ID'
                                                                            ELSE 'REFER' || TO_CHAR(SMI.MANAGEMENT_SEQ - 2) || '_ID'
                                                                          END
                                                                        , SMI.MANAGEMENT_VALUE
                                                                        , SL.SOB_ID)
                          , FI_SLIP_PRINT_G.MANAGEMENT_VALUE_F(SL.SLIP_LINE_ID, SMI.MANAGEMENT_SEQ, SMI.MANAGEMENT_VALUE, SL.SOB_ID)) AS MANAGEMENT_DESC
                     , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)       AS  DR_SUM       -- 차변금액(Debit Amount)
                     , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)       AS  CR_SUM       -- 대변금액(Credit Amount)
                     , NVL(CASE
                             WHEN FAC.ACCOUNT_DR_CR = '1' THEN NVL(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0), 0) - NVL(DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0), 0)
                             WHEN FAC.ACCOUNT_DR_CR = '2' THEN NVL(DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0), 0) - NVL(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0), 0)
                             ELSE 0
                           END, 0) AS REMAIN_SUM       -- 잔액금액(Remain Amount)
                     , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)       AS  MONTH_DR_SUM       -- 차변금액(Debit Amount)
                     , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)       AS  MONTH_CR_SUM       -- 대변금액(Credit Amount)
                     , SL.GL_NUM AS GL_NUM
                     , SL.SLIP_HEADER_ID AS SLIP_HEADER_ID
                     , SL.SLIP_LINE_ID                     
                     , 1 AS SORT_NUM
                  FROM FI_SLIP_LINE                  SL
                    , FI_SLIP_MANAGEMENT_ITEM        SMI
                    , FI_MANAGEMENT_CODE_V           MC
                    , FI_ACCOUNT_CONTROL             FAC
                WHERE SL.SLIP_LINE_ID            = SMI.SLIP_LINE_ID
                  AND SMI.MANAGEMENT_ID          = MC.MANAGEMENT_ID
                  AND FAC.ACCOUNT_CONTROL_ID     = SL.ACCOUNT_CONTROL_ID
                  AND SL.SOB_ID                  = P_SOB_ID
                  AND SL.ACCOUNT_CONTROL_ID      = P_ACCOUNT_CONTROL_ID                  
                  AND SL.GL_DATE                 BETWEEN P_GL_DATE_FR AND P_GL_DATE_TO
                  AND SMI.MANAGEMENT_ID          = P_MANAGEMENT_ID
                  AND SMI.MANAGEMENT_VALUE       = P_MANAGEMENT_VALUE
               ) SX1
      GROUP BY ROLLUP((SX1.ACCOUNT_CONTROL_ID
          , TO_CHAR(SX1.GL_DATE, 'YYYY-MM'))
          , (SX1.GL_DATE
          , SX1.SLIP_LINE_ID
          , SX1.SORT_NUM
          , SX1.SOB_ID
          , SX1.REMARK
          , SX1.REMAIN_SUM
          , SX1.MANAGEMENT_ID
          , SX1.MANAGEMENT_VALUE
          , SX1.MANAGEMENT_DESC
          , SX1.GL_NUM
          , SX1.SLIP_HEADER_ID))
      ORDER BY TO_CHAR(SX1.GL_DATE, 'YYYY-MM'), SX1.ACCOUNT_CONTROL_ID, SX1.GL_DATE, SX1.SORT_NUM, SX1.SLIP_LINE_ID
      ;
  END MANAGEMENT_BALANCE_SELECT;
  
-- 일자별 계정별 관리항목별 잔액 관리.
  PROCEDURE MANAGEMENT_BALANCE_SAVE_P
            ( P_GUBUN             IN VARCHAR2
            , P_GL_DATE           IN FI_MANAGEMENT_BALANCE.GL_DATE%TYPE
            , P_SOB_ID            IN FI_MANAGEMENT_BALANCE.SOB_ID%TYPE
            , P_ORG_ID            IN FI_MANAGEMENT_BALANCE.ORG_ID%TYPE
            , P_ACCOUNT_CONTROL_ID  IN FI_MANAGEMENT_BALANCE.ACCOUNT_CONTROL_ID%TYPE
            , P_MANAGEMENT_ID     IN FI_MANAGEMENT_BALANCE.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT_VALUE  IN FI_MANAGEMENT_BALANCE.MANAGEMENT_VALUE%TYPE
            , P_ACCOUNT_DR_CR     IN VARCHAR2
            , P_GL_AMOUNT         IN NUMBER
            , P_CURRENCY_CODE     IN FI_MANAGEMENT_BALANCE.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE     IN FI_MANAGEMENT_BALANCE.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT  IN NUMBER
            , P_ACCOUNT_CODE      IN FI_MANAGEMENT_BALANCE.ACCOUNT_CODE%TYPE
            , P_USER_ID           IN FI_MANAGEMENT_BALANCE.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_MANAGEMENT_BALANCE_YN       VARCHAR2(1);
    V_MANAGEMENT_CODE             VARCHAR2(10) := NULL;
    V_DR_SUM                      NUMBER := 0;
    V_CR_SUM                      NUMBER := 0;
    V_DR_CURR_SUM                 NUMBER := 0;
    V_CR_CURR_SUM                 NUMBER := 0;
  BEGIN
    -- 관리항목 잔액관리 여부 조회--
    BEGIN
      SELECT MC.MANAGEMENT_CODE
          , MC.BALANCE_YN
        INTO V_MANAGEMENT_CODE
          , V_MANAGEMENT_BALANCE_YN
        FROM FI_MANAGEMENT_CODE_V MC
      WHERE MC.MANAGEMENT_ID        = P_MANAGEMENT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_MANAGEMENT_BALANCE_YN := 'F';
    END;
    IF V_MANAGEMENT_BALANCE_YN IN('N', 'F') OR P_MANAGEMENT_VALUE IS NULL OR P_MANAGEMENT_ID IS NULL THEN
      RETURN;
    END IF;
    BEGIN    
      IF P_ACCOUNT_DR_CR = '1' THEN
        V_DR_SUM := NVL(P_GL_AMOUNT, 0);
        V_CR_SUM := 0;
        V_DR_CURR_SUM := NVL(P_GL_CURRENCY_AMOUNT, 0);
        V_CR_CURR_SUM := 0;
      ELSIF P_ACCOUNT_DR_CR = '2' THEN
        V_DR_SUM := 0;
        V_CR_SUM := NVL(P_GL_AMOUNT, 0);
        V_DR_CURR_SUM := 0;
        V_CR_CURR_SUM := NVL(P_GL_CURRENCY_AMOUNT, 0);
      END IF;
    
      IF P_GUBUN = 'I' THEN
      -- INSERT.
        UPDATE FI_MANAGEMENT_BALANCE MB
          SET MB.DR_SUM             = NVL(MB.DR_SUM, 0) + NVL(V_DR_SUM, 0)
            , MB.CR_SUM             = NVL(MB.CR_SUM, 0) + NVL(V_CR_SUM, 0)
            , MB.EXCHANGE_RATE      = P_EXCHANGE_RATE
            , MB.DR_CURR_SUM        = NVL(MB.DR_CURR_SUM, 0) + NVL(V_DR_CURR_SUM, 0)
            , MB.CR_CURR_SUM        = NVL(MB.CR_CURR_SUM, 0) + NVL(V_CR_CURR_SUM, 0)
            , MB.LAST_UPDATE_DATE   = V_SYSDATE
            , MB.LAST_UPDATED_BY    = P_USER_ID
        WHERE MB.GL_DATE            = P_GL_DATE
          AND MB.GL_DATE_SEQ        = 1
          AND MB.SOB_ID             = P_SOB_ID
          AND MB.ACCOUNT_CONTROL_ID = P_ACCOUNT_CONTROL_ID
          AND MB.MANAGEMENT_ID      = P_MANAGEMENT_ID
          AND MB.MANAGEMENT_VALUE   = P_MANAGEMENT_VALUE
          AND MB.CURRENCY_CODE      = P_CURRENCY_CODE
        ;
        IF SQL%ROWCOUNT = 0 THEN
          INSERT INTO FI_MANAGEMENT_BALANCE
          ( GL_DATE
          , GL_DATE_SEQ
          , SOB_ID
          , ORG_ID
          , ACCOUNT_CONTROL_ID
          , MANAGEMENT_ID
          , MANAGEMENT_VALUE
          , DR_SUM
          , CR_SUM
          , CURRENCY_CODE
          , EXCHANGE_RATE
          , DR_CURR_SUM
          , CR_CURR_SUM
          , ACCOUNT_CODE
          , MANAGEMENT_CODE
          , CREATION_DATE
          , CREATED_BY
          , LAST_UPDATE_DATE
          , LAST_UPDATED_BY
          ) VALUES
          ( P_GL_DATE
          , 1
          , P_SOB_ID
          , P_ORG_ID
          , P_ACCOUNT_CONTROL_ID
          , P_MANAGEMENT_ID
          , P_MANAGEMENT_VALUE
          , V_DR_SUM
          , V_CR_SUM
          , P_CURRENCY_CODE
          , P_EXCHANGE_RATE
          , V_DR_CURR_SUM
          , V_CR_CURR_SUM
          , P_ACCOUNT_CODE
          , V_MANAGEMENT_CODE
          , V_SYSDATE
          , P_USER_ID
          , V_SYSDATE
          , P_USER_ID
          );
        END IF;
      ELSE
      -- DELETE.
        UPDATE FI_MANAGEMENT_BALANCE MB
          SET MB.DR_SUM             = NVL(MB.DR_SUM, 0) - NVL(V_DR_SUM, 0)
            , MB.CR_SUM             = NVL(MB.CR_SUM, 0) - NVL(V_CR_SUM, 0)
            , MB.DR_CURR_SUM        = NVL(MB.DR_CURR_SUM, 0) - NVL(V_DR_CURR_SUM, 0)
            , MB.CR_CURR_SUM        = NVL(MB.CR_CURR_SUM, 0) - NVL(V_CR_CURR_SUM, 0)
            , MB.LAST_UPDATE_DATE   = V_SYSDATE
            , MB.LAST_UPDATED_BY    = P_USER_ID
        WHERE MB.GL_DATE            = P_GL_DATE
          AND MB.GL_DATE_SEQ        = 1
          AND MB.SOB_ID             = P_SOB_ID
          AND MB.ACCOUNT_CONTROL_ID = P_ACCOUNT_CONTROL_ID
          AND MB.MANAGEMENT_ID      = P_MANAGEMENT_ID
          AND MB.MANAGEMENT_VALUE   = P_MANAGEMENT_VALUE
          AND MB.CURRENCY_CODE      = P_CURRENCY_CODE
        ;
        
        -- 금액이 모두 0 일 경우 삭제.
        DELETE FROM FI_MANAGEMENT_BALANCE MB 
        WHERE MB.GL_DATE_SEQ        = 1
          AND MB.SOB_ID             = P_SOB_ID
          AND (NVL(MB.DR_SUM, 0)    = 0
          AND NVL(MB.CR_SUM, 0)     = 0
          AND NVL(MB.DR_CURR_SUM, 0)  = 0
          AND NVL(MB.CR_CURR_SUM, 0)  = 0)
        ;
      END IF;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Management balance Error : ' || SQLERRM);
    END;
  END MANAGEMENT_BALANCE_SAVE_P;

END FI_MANAGEMENT_BALANCE_G;
/
