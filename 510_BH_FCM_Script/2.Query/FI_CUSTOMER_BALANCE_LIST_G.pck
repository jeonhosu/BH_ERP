CREATE OR REPLACE PACKAGE FI_CUSTOMER_BALANCE_LIST_G IS
--==============================================================================
-- PROJECT      : FLEX ERP
-- MODULE       : FCMF
-- PROGRAM NAME : FI_CUSTOMER_BANK_BALANCE_LIST_G
-- DESCRIPTION  : 거래처별 원장.
--
-- REFERENCE BY :
-- PROGRAM HISTORY
--------------------------------------------------------------------------------
--   DATE       IN CHARGE          DESCRIPTION
--------------------------------------------------------------------------------
-- 23-NOV-2010  SUNG KIL TE        INITIALIZE
-- 08-DEC-2010  SUNG KIL TE        INITIALIZE
--==============================================================================
-- 거래처별 원장 헤더 조회.  
  PROCEDURE SELECT_CUST_BALANCE_HEADER
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_GL_DATE_FR        IN DATE
            , W_GL_DATE_TO        IN DATE
            , W_ACCOUNT_CODE_FR   IN VARCHAR2
            , W_ACCOUNT_CODE_TO   IN VARCHAR2
            , W_CUSTOMER_ID       IN NUMBER
            , W_SOB_ID            IN NUMBER            
            );

-- 거래처별 원장 라인 조회.
  PROCEDURE SELECT_CUST_BALANCE_LINE
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_GL_DATE_FR        IN DATE
            , W_GL_DATE_TO        IN DATE
            , W_ACCOUNT_CODE_FR   IN VARCHAR2
            , W_ACCOUNT_CODE_TO   IN VARCHAR2
            , W_CUSTOMER_CODE     IN VARCHAR2
            , W_SOB_ID            IN NUMBER            
            );
               

  PROCEDURE SELECT_CUST_BAL_HEADER
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_SOB_ID            IN  FI_CUSTOMER_BALANCE.SOB_ID%TYPE
            , W_ORG_ID            IN  FI_CUSTOMER_BALANCE.ORG_ID%TYPE
            , W_GROUP_CODE        IN  FI_COMMON.GROUP_CODE%TYPE
            , W_CUSTOMER_ID       IN  FI_CUSTOMER_BALANCE.CUSTOMER_ID%TYPE
            , W_PERIOD_NAME       IN  FI_CUSTOMER_BALANCE.PERIOD_NAME%TYPE
            );



       PROCEDURE LU_LEDGER( P_CURSOR                                           OUT TYPES.TCURSOR
                          , W_SOB_ID                                           IN  FI_COMMON.SOB_ID%TYPE
                          , W_ORG_ID                                           IN  FI_COMMON.ORG_ID%TYPE
                          );

       PROCEDURE CUSTOMER_BALANCE_HEADER_SELECT( P_CURSOR                      OUT TYPES.TCURSOR
                                               , W_SOB_ID                      IN  FI_CUSTOMER_BALANCE.SOB_ID%TYPE
                                               , W_ORG_ID                      IN  FI_CUSTOMER_BALANCE.ORG_ID%TYPE
                                               , W_GROUP_CODE                  IN  FI_COMMON.GROUP_CODE%TYPE
                                               , W_CUSTOMER_ID                 IN  FI_CUSTOMER_BALANCE.CUSTOMER_ID%TYPE
                                               , W_PERIOD_NAME                 IN  FI_CUSTOMER_BALANCE.PERIOD_NAME%TYPE
                                               );

       --거래처별 원장리스트Detail
       PROCEDURE CUSTOMER_BALANCE_LINE_SELECT( P_CURSOR                        OUT TYPES.TCURSOR
                                             , W_SOB_ID                        IN  FI_CUSTOMER_BALANCE.SOB_ID%TYPE
                                             , W_ORG_ID                        IN  FI_CUSTOMER_BALANCE.ORG_ID%TYPE
                                             , W_GROUP_CODE                    IN  FI_COMMON.GROUP_CODE%TYPE
                                             , W_PERIOD_NAME                   IN  FI_UNLIQUIDATE_LINE.PERIOD_NAME%TYPE
                                             , W_SUPP_CUST_ID                  IN  FI_SUPP_CUST_V.SUPP_CUST_ID%TYPE
                                             );

       --거래처별 원장리스트Detail
       PROCEDURE CUSTOMER_BALANCE_DATE_SELECT( P_CURSOR3                       OUT TYPES.TCURSOR3
                                             , W_SOB_ID                        IN  FI_CUSTOMER_BALANCE.SOB_ID%TYPE
                                             , W_ORG_ID                        IN  FI_CUSTOMER_BALANCE.ORG_ID%TYPE
                                             , W_GROUP_CODE                    IN  FI_COMMON.GROUP_CODE%TYPE
                                             , W_PERIOD_NAME                   IN  FI_UNLIQUIDATE_LINE.PERIOD_NAME%TYPE
                                             , W_FROM_DATE                     IN  FI_UNLIQUIDATE_LINE.GL_DATE%TYPE
                                             , W_TO_DATE                       IN  FI_UNLIQUIDATE_LINE.GL_DATE%TYPE
                                             , W_SUPP_CUST_ID                  IN  FI_SUPP_CUST_V.SUPP_CUST_ID%TYPE
                                             );

END FI_CUSTOMER_BALANCE_LIST_G; 

 
/
CREATE OR REPLACE PACKAGE BODY FI_CUSTOMER_BALANCE_LIST_G IS
--==============================================================================
-- PROJECT      : FLEX ERP
-- MODULE       : FCMF
-- PROGRAM NAME : FI_CUSTOMER_BANK_BALANCE_LIST_G
-- DESCRIPTION  : PACKING BOX DEFINE
--
-- REFERENCE BY :
-- PROGRAM HISTORY
--------------------------------------------------------------------------------
--   DATE       IN CHARGE          DESCRIPTION
--------------------------------------------------------------------------------
-- 23-NOV-2010  SUNG KIL TE        INITIALIZE
-- 08-DEC-2010  SUNG KIL TE        INITIALIZE
--==============================================================================
-- 거래처별 원장 헤더 조회.
  PROCEDURE SELECT_CUST_BALANCE_HEADER
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_GL_DATE_FR        IN DATE
            , W_GL_DATE_TO        IN DATE
            , W_ACCOUNT_CODE_FR   IN VARCHAR2
            , W_ACCOUNT_CODE_TO   IN VARCHAR2
            , W_CUSTOMER_ID       IN NUMBER
            , W_SOB_ID            IN NUMBER            
            )
  AS
  BEGIN
    BEGIN
      -- 이월자료 생성.
      DELETE FROM FI_BALANCE_OVER_GT
      ;

      -- 이월 잔액 산출.
      INSERT INTO FI_BALANCE_OVER_GT
      ( ACCOUNT_CONTROL_ID
      , ACCOUNT_CODE
      , ACCOUNT_DESC
      , CUSTOMER_ID
      , CURRENCY_CODE
      , REMARK
      , REMAIN_AMOUNT
      , REMAIN_CURR_AMOUNT
      )
      SELECT FAC.ACCOUNT_CONTROL_ID
           , FAC.ACCOUNT_CODE
           , FAC.ACCOUNT_DESC
           , PX1.CUSTOMER_ID
           , PX1.CURRENCY_CODE
           , EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10165', NULL) AS REMARK
           , NVL(SUM(PX1.BEFORE_AMOUNT), 0) AS BEFORE_AMOUNT          
           , NVL(SUM(PX1.BEFORE_CURR_AMOUNT), 0) AS BEFORE_CURR_AMOUNT
        FROM FI_ACCOUNT_CONTROL FAC
          , ( SELECT CBD.ACCOUNT_CONTROL_ID
                   , CBD.ACCOUNT_CODE                   
                   , AC.ACCOUNT_DR_CR      -- 잔액 구분.
                   , CBD.CUSTOMER_ID
                   , CBD.CURRENCY_CODE
                   , CASE
                       WHEN AC.ACCOUNT_DR_CR = '1' THEN NVL(CBD.DR_AMOUNT, 0) - NVL(CBD.CR_AMOUNT, 0)
                       WHEN AC.ACCOUNT_DR_CR = '2' THEN NVL(CBD.CR_AMOUNT, 0) - NVL(CBD.DR_AMOUNT, 0)
                     END  AS BEFORE_AMOUNT
                   , CASE
                       WHEN AC.ACCOUNT_DR_CR = '1' THEN NVL(CBD.DR_CURR_AMOUNT, 0) - NVL(CBD.CR_CURR_AMOUNT, 0)
                       WHEN AC.ACCOUNT_DR_CR = '2' THEN NVL(CBD.CR_CURR_AMOUNT, 0) - NVL(CBD.DR_CURR_AMOUNT, 0)
                     END  AS BEFORE_CURR_AMOUNT
                FROM FI_CUSTOMER_BALANCE_DAILY CBD
                  , FI_ACCOUNT_CONTROL AC
               WHERE CBD.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
                 AND CBD.GL_DATE               = TRUNC(W_GL_DATE_FR, 'YEAR')
                 AND CBD.GL_DATE_SEQ           = 0
                 AND CBD.SOB_ID                = W_SOB_ID
                 AND CBD.ACCOUNT_CODE          BETWEEN NVL(W_ACCOUNT_CODE_FR, CBD.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, CBD.ACCOUNT_CODE)
              UNION ALL
              -- 1일 ~ 시작(GL_DATE_FR-1) 전일까지의 잔액금액 계산.
              SELECT CBD.ACCOUNT_CONTROL_ID
                   , CBD.ACCOUNT_CODE
                   , AC.ACCOUNT_DR_CR
                   , CBD.CUSTOMER_ID
                   , CBD.CURRENCY_CODE
                   , CASE
                       WHEN AC.ACCOUNT_DR_CR = '1' THEN NVL(CBD.DR_AMOUNT, 0) - NVL(CBD.CR_AMOUNT, 0)
                       WHEN AC.ACCOUNT_DR_CR = '2' THEN NVL(CBD.CR_AMOUNT, 0) - NVL(CBD.DR_AMOUNT, 0)
                     END AS BEFORE_AMOUNT
                   , CASE
                       WHEN AC.ACCOUNT_DR_CR = '1' THEN NVL(CBD.DR_CURR_AMOUNT, 0) - NVL(CBD.CR_CURR_AMOUNT, 0)
                       WHEN AC.ACCOUNT_DR_CR = '2' THEN NVL(CBD.CR_CURR_AMOUNT, 0) - NVL(CBD.DR_CURR_AMOUNT, 0)
                     END AS BEFORE_CURR_AMOUNT
                FROM FI_CUSTOMER_BALANCE_DAILY CBD
                  , FI_ACCOUNT_CONTROL AC
               WHERE CBD.ACCOUNT_CONTROL_ID   = AC.ACCOUNT_CONTROL_ID
                 AND CBD.SOB_ID               = W_SOB_ID
                 AND CBD.GL_DATE              BETWEEN TRUNC(W_GL_DATE_FR, 'YEAR') AND W_GL_DATE_FR - 1
                 AND CBD.GL_DATE_SEQ          = 1
                 AND CBD.ACCOUNT_BOOK_ID      = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(W_SOB_ID)
                 AND CBD.ACCOUNT_CODE         BETWEEN NVL(W_ACCOUNT_CODE_FR, CBD.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, CBD.ACCOUNT_CODE)
              ) PX1
      WHERE FAC.ACCOUNT_CONTROL_ID            = PX1.ACCOUNT_CONTROL_ID(+)
        AND FAC.ACCOUNT_CODE                  BETWEEN NVL(W_ACCOUNT_CODE_FR, FAC.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, FAC.ACCOUNT_CODE)
      GROUP BY FAC.ACCOUNT_CONTROL_ID
           , FAC.ACCOUNT_CODE
           , FAC.ACCOUNT_DESC
           , PX1.CUSTOMER_ID
           , PX1.CURRENCY_CODE
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    
    
    OPEN P_CURSOR FOR
      SELECT DECODE(GROUPING(SC.SUPP_CUST_CODE), 1, NULL, SC.SUPP_CUST_CODE) AS SUPP_CUST_CODE
           , DECODE(GROUPING(SC.SUPP_CUST_CODE), 1, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL), SC.SUPP_CUST_NAME) AS SUPP_CUST_NAME
           , DECODE(GROUPING(SC.SUPP_CUST_CODE), 1, NULL, SC.TAX_REG_NO) AS TAX_REG_NO
           , NVL(SUM(NVL(SX1.BEFORE_AMOUNT, 0)), 0) AS BEFORE_AMOUNT
           , NVL(SUM(NVL(SX1.DR_AMOUNT, 0)), 0) AS DR_AMOUNT
           , NVL(SUM(NVL(SX1.CR_AMOUNT, 0)), 0) AS CR_AMOUNT
           , NVL(SUM(NVL(SX1.BEFORE_AMOUNT, 0) + NVL(SX1.REMAIN_AMOUNT, 0)), 0) AS REMAIN_AMOUNT
        FROM FI_SUPP_CUST_V SC
          , ( SELECT BOG.ACCOUNT_CODE
                   , BOG.ACCOUNT_DESC
                   , BOG.CUSTOMER_ID
                   , NVL(BOG.REMAIN_AMOUNT, 0) AS BEFORE_AMOUNT       --이월원화 (Before Amount)
                   , NVL(BOG.REMAIN_CURR_AMOUNT, 0) AS BEFORE_CURR_AMOUNT  --이월외화(Before Currency Amount)
                   , 0 AS DR_AMOUNT           --당월차변(This Debit Amount)
                   , 0 AS CR_AMOUNT           --당월차변외화(This Currency Debit Amount)
                   , 0 AS REMAIN_AMOUNT       --잔액금액(원화) Remain Aamount )
                FROM FI_BALANCE_OVER_GT BOG
               WHERE BOG.ACCOUNT_CODE           BETWEEN NVL(W_ACCOUNT_CODE_FR, BOG.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, BOG.ACCOUNT_CODE)
               ---------
               UNION ALL
               ---------
               SELECT CBD.ACCOUNT_CODE
                   , AC.ACCOUNT_DESC
                   , CBD.CUSTOMER_ID
                   , 0 AS BEFORE_AMOUNT       --이월원화 (Before Amount)
                   , 0 AS BEFORE_CURR_AMOUNT  -- 이월 외화
                   , NVL(SUM(DECODE(AC.ACCOUNT_DR_CR, '1', NVL(CBD.DR_AMOUNT, 0), NVL(CBD.CR_AMOUNT, 0))), 0) AS DR_AMOUNT           --당월 증가.
                   , NVL(SUM(DECODE(AC.ACCOUNT_DR_CR, '1', NVL(CBD.CR_AMOUNT, 0), NVL(CBD.DR_AMOUNT, 0))), 0) AS CR_AMOUNT           --당월 감소.
                   , NVL(SUM(CASE
                               WHEN AC.ACCOUNT_DR_CR = '1' THEN NVL(CBD.DR_AMOUNT, 0) - NVL(CBD.CR_AMOUNT, 0)
                               WHEN AC.ACCOUNT_DR_CR = '2' THEN NVL(CBD.CR_AMOUNT, 0) - NVL(CBD.DR_AMOUNT, 0)
                             END), 0) AS  REMAIN_AMOUNT  --잔액금액(외화) Remain Currency Amount)
                FROM FI_CUSTOMER_BALANCE_DAILY CBD
                  , FI_ACCOUNT_CONTROL AC
               WHERE CBD.ACCOUNT_CONTROL_ID     = AC.ACCOUNT_CONTROL_ID
                 AND CBD.GL_DATE                BETWEEN W_GL_DATE_FR   AND W_GL_DATE_TO
                 AND CBD.GL_DATE_SEQ            = 1
                 AND CBD.SOB_ID                 = W_SOB_ID
                 AND CBD.ACCOUNT_CODE           BETWEEN NVL(W_ACCOUNT_CODE_FR, CBD.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, CBD.ACCOUNT_CODE)
              GROUP BY CBD.ACCOUNT_CODE
                   , AC.ACCOUNT_DESC
                   , CBD.CUSTOMER_ID
            ) SX1
      WHERE SC.SUPP_CUST_ID             = SX1.CUSTOMER_ID
        AND SC.SUPP_CUST_ID             = NVL(W_CUSTOMER_ID, SC.SUPP_CUST_ID)
        AND SC.SOB_ID                   = W_SOB_ID
        AND (NVL(SX1.BEFORE_AMOUNT, 0)  <>0
          OR NVL(SX1.DR_AMOUNT, 0)      <> 0
          OR NVL(SX1.CR_AMOUNT, 0)      <> 0
          OR NVL(SX1.REMAIN_AMOUNT, 0)  <> 0)
      GROUP BY ROLLUP((SC.SUPP_CUST_CODE
           , SC.SUPP_CUST_NAME
           , SC.TAX_REG_NO)) 
      ORDER BY SC.SUPP_CUST_CODE
      ;
  END SELECT_CUST_BALANCE_HEADER;

-- 거래처별 원장 라인 조회.
  PROCEDURE SELECT_CUST_BALANCE_LINE
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_GL_DATE_FR        IN DATE
            , W_GL_DATE_TO        IN DATE
            , W_ACCOUNT_CODE_FR   IN VARCHAR2
            , W_ACCOUNT_CODE_TO   IN VARCHAR2
            , W_CUSTOMER_CODE     IN VARCHAR2
            , W_SOB_ID            IN NUMBER            
            )
  AS
  BEGIN
    BEGIN
      -- 이월자료 생성.
      DELETE FROM FI_BALANCE_OVER_GT
      ;

      -- 이월 잔액 산출.
      INSERT INTO FI_BALANCE_OVER_GT
      ( GL_DATE
      , PERIOD_NAME
      , ACCOUNT_CONTROL_ID
      , ACCOUNT_CODE
      , ACCOUNT_DESC
      , CUSTOMER_ID
      , REMARK
      , DR_GL_AMOUNT
      , CR_GL_AMOUNT
      , REMAIN_AMOUNT
      , IDENTIFICATION
      )
      SELECT W_GL_DATE_FR - 1 AS GL_DATE
           , TO_CHAR(W_GL_DATE_FR, 'YYYY-MM') AS PERIOD_NAME
           , FAC.ACCOUNT_CONTROL_ID
           , FAC.ACCOUNT_CODE
           , FAC.ACCOUNT_DESC
           , PX1.CUSTOMER_ID
           , EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10165', NULL) AS REMARK
           , NVL(SUM(PX1.DR_AMOUNT), 0) AS DR_AMOUNT          
           , NVL(SUM(PX1.CR_AMOUNT), 0) AS CR_AMOUNT
           , NVL(SUM((NVL(PX1.DR_AMOUNT, 0) 
                       * DECODE(FAC.ACCOUNT_DR_CR, '1', 1, -1)) + 
                     (NVL(PX1.CR_AMOUNT, 0) 
                       * DECODE(FAC.ACCOUNT_DR_CR, '2', 1, -1))), 0) AS REMAIN_AMOUNT
           , 'B' AS BEGIN_FLAG
        FROM FI_ACCOUNT_CONTROL FAC
          , (SELECT CBD.ACCOUNT_CONTROL_ID
                   , CBD.ACCOUNT_CODE                   
                   , AC.ACCOUNT_DR_CR      -- 잔액 구분.
                   , CBD.CUSTOMER_ID
                   , CBD.CURRENCY_CODE
                   , NVL(CBD.DR_AMOUNT, 0) AS DR_AMOUNT
                   , NVL(CBD.CR_AMOUNT, 0) AS CR_AMOUNT                   
                FROM FI_CUSTOMER_BALANCE_DAILY CBD
                   , FI_SUPP_CUST_V SC
                   , FI_ACCOUNT_CONTROL AC
               WHERE CBD.CUSTOMER_ID           = SC.SUPP_CUST_ID
                 AND CBD.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID               
                 AND CBD.GL_DATE               = TRUNC(W_GL_DATE_FR, 'YEAR')
                 AND CBD.GL_DATE_SEQ           = 0
                 AND CBD.SOB_ID                = W_SOB_ID
                 AND SC.SUPP_CUST_CODE         = W_CUSTOMER_CODE
                 AND CBD.ACCOUNT_CODE          BETWEEN NVL(W_ACCOUNT_CODE_FR, CBD.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, CBD.ACCOUNT_CODE)
              UNION ALL
              -- 1일 ~ 시작(GL_DATE_FR-1) 전일까지의 잔액금액 계산.
              SELECT CBD.ACCOUNT_CONTROL_ID
                   , CBD.ACCOUNT_CODE
                   , AC.ACCOUNT_DR_CR
                   , CBD.CUSTOMER_ID
                   , CBD.CURRENCY_CODE
                   , NVL(CBD.DR_AMOUNT, 0) AS DR_AMOUNT
                   , NVL(CBD.CR_AMOUNT, 0) AS CR_AMOUNT                   
                FROM FI_CUSTOMER_BALANCE_DAILY CBD
                   , FI_SUPP_CUST_V SC
                   , FI_ACCOUNT_CONTROL AC
               WHERE CBD.CUSTOMER_ID          = SC.SUPP_CUST_ID
                 AND CBD.ACCOUNT_CONTROL_ID   = AC.ACCOUNT_CONTROL_ID      
                 AND CBD.SOB_ID               = W_SOB_ID
                 AND CBD.GL_DATE              BETWEEN TRUNC(W_GL_DATE_FR, 'YEAR') AND W_GL_DATE_FR - 1
                 AND CBD.GL_DATE_SEQ           = 1
                 AND CBD.ACCOUNT_BOOK_ID      = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(W_SOB_ID)
                 AND CBD.ACCOUNT_CODE         BETWEEN NVL(W_ACCOUNT_CODE_FR, CBD.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, CBD.ACCOUNT_CODE)
                 AND SC.SUPP_CUST_CODE        = W_CUSTOMER_CODE
              ) PX1
      WHERE FAC.ACCOUNT_CONTROL_ID            = PX1.ACCOUNT_CONTROL_ID(+)
        AND FAC.ACCOUNT_CODE                  BETWEEN NVL(W_ACCOUNT_CODE_FR, FAC.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, FAC.ACCOUNT_CODE)
      GROUP BY FAC.ACCOUNT_CONTROL_ID
           , FAC.ACCOUNT_CODE
           , FAC.ACCOUNT_DESC
           , PX1.CUSTOMER_ID
      ;
      -- 발생금액 INSERT.
      INSERT INTO FI_BALANCE_OVER_GT
      ( GL_DATE
      , PERIOD_NAME
      , ACCOUNT_CONTROL_ID
      , ACCOUNT_CODE
      , ACCOUNT_DESC
      , CUSTOMER_ID
      , REMARK
      , DR_GL_AMOUNT
      , CR_GL_AMOUNT
      , REMAIN_AMOUNT
      , CURRENCY_CODE
      , DR_CURRENCY_AMOUNT
      , CR_CURRENCY_AMOUNT
      , SOURCE_HEADER_ID
      , SOURCE_LINE_ID      
      , ATTRIBUTE_A 
      )
      SELECT SL.GL_DATE
           , TO_CHAR(SL.GL_DATE, 'YYYY-MM') AS PERIOD_NAME
           , SL.ACCOUNT_CONTROL_ID
           , SL.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , SMV.SUPP_CUST_ID
           , SL.REMARK
           , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) AS DR_AMOUNT
           , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) AS CR_AMOUNT
           , ((NVL(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0), 0) 
               * DECODE(AC.ACCOUNT_DR_CR, '1', 1, -1)) + 
             (NVL(DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0), 0) 
               * DECODE(AC.ACCOUNT_DR_CR, '2', 1, -1))) AS REMAIN_AMOUNT
           , SL.CURRENCY_CODE
           , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_CURRENCY_AMOUNT, 0) AS DR_CURRENCY_AMOUNT
           , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_CURRENCY_AMOUNT, 0) AS DR_CURRENCY_AMOUNT
           , SL.SLIP_HEADER_ID
           , SL.SLIP_LINE_ID
           , SL.GL_NUM
        FROM FI_SLIP_LINE SL
          , FI_ACCOUNT_CONTROL AC
          , FI_SLIP_MGMT_VENDOR_V SMV
      WHERE SL.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
        AND SL.SLIP_LINE_ID             = SMV.SLIP_LINE_ID(+)
        AND SL.GL_DATE                  BETWEEN W_GL_DATE_FR AND W_GL_DATE_TO
        AND SL.ACCOUNT_CODE             BETWEEN NVL(W_ACCOUNT_CODE_FR, SL.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, SL.ACCOUNT_CODE)
        AND SL.SOB_ID                   = W_SOB_ID
        AND SMV.CUSTOMER_CODE           = W_CUSTOMER_CODE
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    
    OPEN P_CURSOR1 FOR
      SELECT DECODE(PX1.GL_DATE, W_GL_DATE_FR - 1, TO_DATE(NULL), PX1.GL_DATE) AS GL_DATE
           , PX1.SLIP_NUM
           , PX1.ACCOUNT_CODE
           , PX1.ACCOUNT_DESC
           , CASE
               WHEN GROUPING(PX1.PERIOD_NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10188', NULL)
               WHEN GROUPING(PX1.GL_DATE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10050', NULL)
               ELSE PX1.REMARK
             END AS REMARK
           , DECODE(GROUPING(PX1.GL_DATE), 1, SUM(PX1.MONTH_DR_AMOUNT), SUM(PX1.DR_AMOUNT)) AS DR_AMOUNT
           , DECODE(GROUPING(PX1.GL_DATE), 1, SUM(PX1.MONTH_CR_AMOUNT), SUM(PX1.CR_AMOUNT)) AS CR_AMOUNT
           , CASE
               WHEN PX1.GL_DATE = W_GL_DATE_FR - 1 THEN TO_NUMBER(NULL)
               WHEN GROUPING(PX1.PERIOD_NAME) = 1 THEN SUM(PX1.S_REMAIN_AMOUNT)
               WHEN GROUPING(PX1.GL_DATE) = 1 THEN 0
               ELSE SUM(PX1.REMAIN_AMOUNT)
             END AS REMAIN_AMOUNT           
           , PX1.CURRENCY_CODE
           , DECODE(GROUPING(PX1.GL_DATE), 1, SUM(PX1.MONTH_DR_CURR_AMOUNT), SUM(PX1.DR_CURRENCY_AMOUNT)) AS DR_CURRENCY_AMOUNT
           , DECODE(GROUPING(PX1.GL_DATE), 1, SUM(PX1.MONTH_CR_CURR_AMOUNT), SUM(PX1.CR_CURRENCY_AMOUNT)) AS CR_CURRENCY_AMOUNT           
           , PX1.SLIP_HEADER_ID
        FROM FI_ACCOUNT_CONTROL AC
          , (SELECT SX1.ACCOUNT_CODE
                 , SX1.ACCOUNT_DESC
                 , SX1.PERIOD_NAME AS PERIOD_NAME
                 , SX1.GL_DATE
                 , SX1.SLIP_NUM
                 , SX1.DR_AMOUNT AS DR_AMOUNT
                 , SX1.CR_AMOUNT AS CR_AMOUNT
                 , CASE
                     WHEN ROW_NUMBER() OVER (PARTITION BY SX1.ACCOUNT_CODE ORDER BY SX1.ACCOUNT_CODE, SX1.GL_DATE)
                       < COUNT(*) OVER (PARTITION BY SX1.ACCOUNT_CODE ORDER BY SX1.ACCOUNT_CODE, SX1.GL_DATE) THEN 0
                     ELSE SUM(SX1.REMAIN_AMOUNT) OVER (PARTITION BY SX1.ACCOUNT_CODE ORDER BY SX1.ACCOUNT_CODE, SX1.GL_DATE, SX1.SLIP_HEADER_ID)
                   END AS REMAIN_AMOUNT
                 , SX1.REMARK
                 , SX1.CURRENCY_CODE
                 , NVL(SX1.DR_CURRENCY_AMOUNT, 0) AS DR_CURRENCY_AMOUNT
                 , NVL(SX1.CR_CURRENCY_AMOUNT, 0) AS CR_CURRENCY_AMOUNT
                 , NVL(SX1.MONTH_DR_AMOUNT, 0) AS MONTH_DR_AMOUNT
                 , NVL(SX1.MONTH_CR_AMOUNT, 0) AS MONTH_CR_AMOUNT
                 , NVL(SX1.MONTH_DR_CURR_AMOUNT, 0) AS MONTH_DR_CURR_AMOUNT
                 , NVL(SX1.MONTH_CR_CURR_AMOUNT, 0) AS MONTH_CR_CURR_AMOUNT
                 , NVL(SX1.REMAIN_AMOUNT, 0) AS S_REMAIN_AMOUNT
                 , SX1.ACCOUNT_CONTROL_ID
                 , SX1.SLIP_HEADER_ID
                 , SX1.SLIP_LINE_ID
              FROM (
                SELECT BO.ACCOUNT_CODE
                     , BO.ACCOUNT_DESC
                     , BO.PERIOD_NAME AS PERIOD_NAME
                     , BO.GL_DATE
                     , BO.ATTRIBUTE_A AS SLIP_NUM
                     , BO.DR_GL_AMOUNT AS DR_AMOUNT
                     , BO.CR_GL_AMOUNT AS CR_AMOUNT
                     , (NVL(BO.DR_GL_AMOUNT, 0) 
                         * DECODE(AC.ACCOUNT_DR_CR, '1', 1, -1)) + 
                       (NVL(BO.CR_GL_AMOUNT, 0) 
                         * DECODE(AC.ACCOUNT_DR_CR, '2', 1, -1)) AS REMAIN_AMOUNT
                     , BO.REMARK
                     , BO.CURRENCY_CODE
                     , BO.DR_CURRENCY_AMOUNT
                     , BO.CR_CURRENCY_AMOUNT
                     , DECODE(BO.IDENTIFICATION, 'B', 0, BO.DR_GL_AMOUNT) AS MONTH_DR_AMOUNT
                     , DECODE(BO.IDENTIFICATION, 'B', 0, BO.CR_GL_AMOUNT) AS MONTH_CR_AMOUNT
                     , DECODE(BO.IDENTIFICATION, 'B', 0, BO.DR_CURRENCY_AMOUNT) AS MONTH_DR_CURR_AMOUNT
                     , DECODE(BO.IDENTIFICATION, 'B', 0, BO.CR_CURRENCY_AMOUNT) AS MONTH_CR_CURR_AMOUNT
                     , BO.SOURCE_HEADER_ID AS SLIP_HEADER_ID
                     , BO.SOURCE_LINE_ID AS SLIP_LINE_ID
                     , BO.ACCOUNT_CONTROL_ID
                  FROM FI_BALANCE_OVER_GT BO
                    , FI_ACCOUNT_CONTROL AC
                    , FI_SUPP_CUST_V SC
                WHERE BO.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
                  AND BO.CUSTOMER_ID              = SC.SUPP_CUST_ID(+)              
                 ) SX1
              WHERE EXISTS( SELECT 'X'
                              FROM FI_BALANCE_OVER_GT BOG
                            WHERE BOG.ACCOUNT_CONTROL_ID  = SX1.ACCOUNT_CONTROL_ID
                              AND BOG.REMAIN_AMOUNT       <> 0
                          )
          ) PX1
      WHERE AC.ACCOUNT_CONTROL_ID       = PX1.ACCOUNT_CONTROL_ID
      GROUP BY ROLLUP ((PX1.ACCOUNT_CODE
           , PX1.ACCOUNT_DESC)
           , (PX1.PERIOD_NAME)
           , (PX1.GL_DATE
           , PX1.SLIP_HEADER_ID
           , PX1.SLIP_LINE_ID
           , PX1.SLIP_NUM
           , PX1.REMARK
           , PX1.CURRENCY_CODE))
      HAVING GROUPING(PX1.ACCOUNT_CODE) <> 1
      ;
      /*SELECT DECODE(PX1.GL_DATE, W_GL_DATE_FR - 1, TO_DATE(NULL), PX1.GL_DATE) AS GL_DATE
           , PX1.SLIP_NUM
           , PX1.ACCOUNT_CODE
           , PX1.ACCOUNT_DESC
           , CASE
               WHEN GROUPING(PX1.ACCOUNT_CODE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10051', NULL)
               WHEN GROUPING(PX1.GL_DATE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10188', NULL)
               ELSE PX1.REMARK
             END AS REMARK
           , SUM(PX1.DR_AMOUNT) AS DR_AMOUNT
           , SUM(PX1.CR_AMOUNT) AS CR_AMOUNT
           , CASE
               WHEN PX1.GL_DATE = W_GL_DATE_FR - 1 THEN TO_NUMBER(NULL)
               WHEN GROUPING(PX1.ACCOUNT_CODE) = 1 THEN TO_NUMBER(NULL)
               WHEN GROUPING(PX1.GL_DATE) = 1 THEN TO_NUMBER(NULL)               
               ELSE SUM(PX1.REMAIN_AMOUNT)
             END AS REMAIN_AMOUNT           
           , PX1.CURRENCY_CODE
           , PX1.DR_CURRENCY_AMOUNT
           , PX1.CR_CURRENCY_AMOUNT
           , PX1.SLIP_HEADER_ID
        FROM (
          SELECT SX1.ACCOUNT_CODE
               , SX1.ACCOUNT_DESC
               , SX1.PERIOD_NAME AS PERIOD_NAME
               , SX1.GL_DATE
               , SX1.SLIP_NUM
               , SX1.DR_AMOUNT AS DR_AMOUNT
               , SX1.CR_AMOUNT AS CR_AMOUNT
               , CASE
                   WHEN ROW_NUMBER() OVER (PARTITION BY SX1.ACCOUNT_CODE ORDER BY SX1.ACCOUNT_CODE, SX1.GL_DATE)
                     < COUNT(*) OVER (PARTITION BY SX1.ACCOUNT_CODE ORDER BY SX1.ACCOUNT_CODE, SX1.GL_DATE) THEN 0
                   ELSE SUM(SX1.REMAIN_AMOUNT) OVER (PARTITION BY SX1.ACCOUNT_CODE ORDER BY SX1.ACCOUNT_CODE, SX1.GL_DATE, SX1.SLIP_HEADER_ID)
                 END AS REMAIN_AMOUNT
               , SX1.REMARK
               , SX1.CURRENCY_CODE
               , SX1.DR_CURRENCY_AMOUNT
               , SX1.CR_CURRENCY_AMOUNT
               , SX1.SLIP_HEADER_ID
               , SX1.SLIP_LINE_ID
            FROM (
              SELECT BO.ACCOUNT_CODE
                   , BO.ACCOUNT_DESC
                   , TO_CHAR(BO.GL_DATE, 'YYYY-MM') AS PERIOD_NAME
                   , BO.GL_DATE
                   , BO.ATTRIBUTE_A AS SLIP_NUM
                   , BO.DR_GL_AMOUNT AS DR_AMOUNT
                   , BO.CR_GL_AMOUNT AS CR_AMOUNT
                   , (NVL(BO.DR_GL_AMOUNT, 0) 
                       * DECODE(AC.ACCOUNT_DR_CR, '1', 1, -1)) + 
                     (NVL(BO.CR_GL_AMOUNT, 0) 
                       * DECODE(AC.ACCOUNT_DR_CR, '2', 1, -1)) AS REMAIN_AMOUNT
                   , BO.REMARK
                   , BO.CURRENCY_CODE
                   , BO.DR_CURRENCY_AMOUNT
                   , BO.CR_CURRENCY_AMOUNT
                   , BO.SOURCE_HEADER_ID AS SLIP_HEADER_ID
                   , BO.SOURCE_LINE_ID AS SLIP_LINE_ID
                   , BO.ACCOUNT_CONTROL_ID
                FROM FI_BALANCE_OVER_GT BO
                  , FI_ACCOUNT_CONTROL AC
                  , FI_SUPP_CUST_V SC
              WHERE BO.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
                AND BO.CUSTOMER_ID              = SC.SUPP_CUST_ID(+)
               ) SX1
            WHERE EXISTS( SELECT 'X'
                            FROM FI_BALANCE_OVER_GT BOG
                          WHERE BOG.ACCOUNT_CONTROL_ID  = SX1.ACCOUNT_CONTROL_ID
                            AND BOG.REMAIN_AMOUNT       <> 0
                        )
        ) PX1
      GROUP BY ROLLUP ((PX1.ACCOUNT_CODE
           , PX1.ACCOUNT_DESC)
           , (PX1.GL_DATE
           , PX1.SLIP_HEADER_ID
           , PX1.SLIP_LINE_ID
           , PX1.SLIP_NUM
           , PX1.REMARK
           , PX1.CURRENCY_CODE
           , PX1.DR_CURRENCY_AMOUNT
           , PX1.CR_CURRENCY_AMOUNT))
      ;*/
  END SELECT_CUST_BALANCE_LINE;


  PROCEDURE SELECT_CUST_BAL_HEADER
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_SOB_ID            IN  FI_CUSTOMER_BALANCE.SOB_ID%TYPE
            , W_ORG_ID            IN  FI_CUSTOMER_BALANCE.ORG_ID%TYPE
            , W_GROUP_CODE        IN  FI_COMMON.GROUP_CODE%TYPE
            , W_CUSTOMER_ID       IN  FI_CUSTOMER_BALANCE.CUSTOMER_ID%TYPE
            , W_PERIOD_NAME       IN  FI_CUSTOMER_BALANCE.PERIOD_NAME%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT FSC.SUPP_CUST_ID          AS  SUPP_CUST_ID
          , FSC.TAX_REG_NO             AS  TAX_REG_NO
          , FSC.SUPP_CUST_NAME         AS  CUSTOMER_NAME
          , FCB.ACCOUNT_CODE           AS  ACCOUNT_CODE
          , FAC.ACCOUNT_DESC           AS  ACCOUNT_DESC
          , FCB.CURRENCY_CODE          AS  CURRENCY_CODE
          , CASE 
              WHEN FAC.ACCOUNT_DR_CR = '1' THEN NVL(FCB.PRE_DR_AMOUNT,0)
              WHEN FAC.ACCOUNT_DR_CR = '2' THEN NVL(PRE_CR_AMOUNT,0)
            END AS BEFORE_AMOUNT
          , CASE 
              WHEN FAC.ACCOUNT_DR_CR = '1' THEN NVL(FCB.PRE_DR_CURR_AMOUNT,0)
              WHEN FAC.ACCOUNT_DR_CR = '2' THEN  NVL(PRE_CR_CURR_AMOUNT,0)
            END AS BEFORE_CURR_AMOUNT
          , CASE 
              WHEN FAC.ACCOUNT_DR_CR = '1' THEN DECODE(NVL(FCB.PRE_DR_CURR_AMOUNT, 0), 0, NULL, FCB.CURRENCY_CODE)
              WHEN FAC.ACCOUNT_DR_CR = '2' THEN DECODE(NVL(FCB.PRE_CR_CURR_AMOUNT, 0), 0, NULL, FCB.CURRENCY_CODE)
            END AS BEFORE_CURRENCY_CODE
          , CASE
              WHEN FAC.ACCOUNT_DR_CR = '1' THEN NVL(FCB.THIS_DR_AMOUNT,0)
              WHEN FAC.ACCOUNT_DR_CR = '2' THEN NVL(FCB.THIS_CR_AMOUNT,0)
            END AS THIS_AMOUNT
          , CASE
              WHEN FAC.ACCOUNT_DR_CR = '1' THEN NVL(FCB.THIS_DR_CURR_AMOUNT,0)
              WHEN FAC.ACCOUNT_DR_CR = '2' THEN NVL(FCB.THIS_CR_CURR_AMOUNT,0)
            END AS THIS_CURR_AMOUNT
          , CASE
              WHEN FAC.ACCOUNT_DR_CR = '1' THEN DECODE(NVL(FCB.THIS_DR_CURR_AMOUNT, 0), 0, NULL, FCB.CURRENCY_CODE)
              WHEN FAC.ACCOUNT_DR_CR = '2' THEN DECODE(NVL(FCB.THIS_CR_CURR_AMOUNT, 0), 0, NULL, FCB.CURRENCY_CODE)
            END AS THIS_CURRENCY_CODE
          , CASE
              WHEN FAC.ACCOUNT_DR_CR = '1' THEN NVL(FCB.THIS_CR_AMOUNT, 0)
              WHEN FAC.ACCOUNT_DR_CR = '2' THEN NVL(THIS_DR_AMOUNT, 0)
            END AS PAY_AMOUNT
          , CASE
              WHEN FAC.ACCOUNT_DR_CR = '1' THEN NVL(FCB.THIS_CR_CURR_AMOUNT, 0)
              WHEN FAC.ACCOUNT_DR_CR = '2' THEN NVL(THIS_DR_CURR_AMOUNT, 0)
            END AS PAY_CURR_AMOUNT
          , CASE
              WHEN FAC.ACCOUNT_DR_CR = '1' THEN DECODE(NVL(FCB.THIS_CR_CURR_AMOUNT, 0), 0, NULL, FCB.CURRENCY_CODE)
              WHEN FAC.ACCOUNT_DR_CR = '2' THEN DECODE(NVL(FCB.THIS_DR_CURR_AMOUNT, 0), 0, NULL, FCB.CURRENCY_CODE)
            END AS PAY_CURRENCY_CODE
          , CASE
              WHEN FAC.ACCOUNT_DR_CR = '1' THEN NVL(FCB.THIS_DR_AMOUNT,0) - NVL(THIS_CR_AMOUNT,0)
              WHEN FAC.ACCOUNT_DR_CR = '2' THEN NVL(FCB.THIS_CR_AMOUNT,0) - NVL(THIS_DR_AMOUNT,0)
            END AS GAP_AMOUNT
          , CASE
              WHEN FAC.ACCOUNT_DR_CR = '1' THEN NVL(FCB.THIS_DR_CURR_AMOUNT,0) - NVL(THIS_CR_CURR_AMOUNT,0)
              WHEN FAC.ACCOUNT_DR_CR = '2' THEN NVL(FCB.THIS_CR_CURR_AMOUNT,0) - NVL(THIS_DR_CURR_AMOUNT,0)
            END AS GAP_CURR_AMOUNT
        FROM FI_CUSTOMER_BALANCE      FCB
           , FI_ACCOUNT_CONTROL       FAC
           , FI_SUPP_CUST_V           FSC
       WHERE FCB.ACCOUNT_CONTROL_ID = FAC.ACCOUNT_CONTROL_ID
         AND FCB.SOB_ID             = FAC.SOB_ID
         AND FCB.CUSTOMER_ID        = FSC.SUPP_CUST_ID   
         AND FCB.SOB_ID             = FSC.SOB_ID
         AND FCB.PERIOD_NAME        = NVL(W_PERIOD_NAME, FCB.PERIOD_NAME)
         AND FCB.SOB_ID             = W_SOB_ID
         AND FCB.CUSTOMER_ID        = NVL(W_CUSTOMER_ID, FCB.CUSTOMER_ID)
      ORDER BY FCB.CUSTOMER_ID
      ;
  
  END SELECT_CUST_BAL_HEADER;
  

       PROCEDURE LU_LEDGER( P_CURSOR                                           OUT TYPES.TCURSOR
                          , W_SOB_ID                                           IN  FI_COMMON.SOB_ID%TYPE
                          , W_ORG_ID                                           IN  FI_COMMON.ORG_ID%TYPE
                          )

       IS

       BEGIN
                 OPEN P_CURSOR FOR
                 SELECT FC.CODE
                      , FC.CODE_NAME
                   FROM FI_COMMON FC
                  WHERE FC.SOB_ID       = W_SOB_ID
                    AND FC.GROUP_CODE   = 'GL_TYPE'
                    AND FC.ENABLED_FLAG = 'Y'
               ORDER BY FC.CODE
                      ;

       END;


  PROCEDURE CUSTOMER_BALANCE_HEADER_SELECT( P_CURSOR                      OUT TYPES.TCURSOR
                                         , W_SOB_ID                      IN  FI_CUSTOMER_BALANCE.SOB_ID%TYPE
                                         , W_ORG_ID                      IN  FI_CUSTOMER_BALANCE.ORG_ID%TYPE
                                         , W_GROUP_CODE                  IN  FI_COMMON.GROUP_CODE%TYPE
                                         , W_CUSTOMER_ID                 IN  FI_CUSTOMER_BALANCE.CUSTOMER_ID%TYPE
                                         , W_PERIOD_NAME                 IN  FI_CUSTOMER_BALANCE.PERIOD_NAME%TYPE
                                         )

  IS

  BEGIN
    OPEN P_CURSOR FOR
      SELECT NVL(FSCV.TAX_REG_NO, FSCV.SUPP_CUST_CODE)  AS  TAX_REG_NO           -- 사업자번호    (Tax Reg. Number)
          , CUSTOMER_NAME          AS  CUSTOMER_NAME        -- 거래선명      (Customer Name )
          , ACCOUNT_CODE           AS  ACCOUNT_CODE         -- 계정코드      (Account COde )
          , ACCOUNT_DESC           AS  ACCOUNT_DESC         -- 계정명        (Account_Desc.)
          , BEFORE_AMOUNT          AS  BEFORE_AMOUNT        -- 이월금액      (Before Amount)
          , BEFORE_CURR_AMOUNT     AS  BEFORE_CURR_AMOUNT   -- 이월금액(외화)(Before Curr. Amount)
          , BEFORE_CURRENCY_CODE   AS  BEFORE_CURRENCY_CODE -- 이월통화(Currency Code)
          , THIS_AMOUNT            AS  THIS_AMOUNT          -- 당월금액(원화)(This Amount)
          , THIS_CURR_AMOUNT       AS  THIS_CURR_AMOUNT     -- 당월금액(외화)(This Curr. Amount)
          , THIS_CURRENCY_CODE     AS  THIS_CURRENCY_CODE   -- 당월통화(Currency Code)
          , PAY_AMOUNT             AS  PAY_AMOUNT           -- 당월반제(원화)(This Amount)
          , PAY_CURR_AMOUNT        AS  PAY_CURR_AMOUNT      -- 당월반제(외화)(This Curr. Amount)
          , PAY_CURRENCY_CODE      AS  PAY_CURRENCY_CODE    -- 당월반제통화(Currency Code)

          , (BEFORE_AMOUNT + CHA_AMOUNT)            AS  REMAIN_AMOUNT        -- 잔액금액(원화)(Remain Amount)
          , (BEFORE_CURR_AMOUNT + CHA_CURR_AMOUNT)  AS  REMAIN_CURR_AMOUNT   -- 잔액금액(외화)(Remain Curr. Amount)
          , CASE WHEN BEFORE_CURRENCY_CODE IS NOT NULL
                 THEN BEFORE_CURRENCY_CODE
                 ELSE THIS_CURRENCY_CODE
            END                                         REMAIN_CURRENCY_CODE  -- 통화(Currency Code)
          , BALANCE.SUPP_CUST_ID AS SUPP_CUST_ID
       FROM
          ( SELECT FSC.SUPP_CUST_ID           AS  SUPP_CUST_ID
                 , FSC.TAX_REG_NO             AS  TAX_REG_NO
                 , FSC.SUPP_CUST_NAME         AS  CUSTOMER_NAME
                 , FCB.ACCOUNT_CODE           AS  ACCOUNT_CODE
                 , FAC.ACCOUNT_DESC           AS  ACCOUNT_DESC
                 , FCB.CURRENCY_CODE          AS  CURRENCY_CODE
                 , DECODE(ACCOUNT_DR_CR, '1', NVL(FCB.PRE_DR_AMOUNT,0),   NVL(PRE_CR_AMOUNT,0))                         AS  BEFORE_AMOUNT
                 , DECODE(ACCOUNT_DR_CR, '1', NVL(FCB.PRE_DR_CURR_AMOUNT,0),  NVL(PRE_CR_CURR_AMOUNT,0))                AS  BEFORE_CURR_AMOUNT
                 , DECODE(ACCOUNT_DR_CR, '1', CASE WHEN FCB.PRE_DR_CURR_AMOUNT <> 0 THEN FCB.CURRENCY_CODE ELSE NULL END,
                                              CASE WHEN FCB.PRE_CR_CURR_AMOUNT <> 0 THEN FCB.CURRENCY_CODE ELSE NULL END)   BEFORE_CURRENCY_CODE

                 , DECODE(ACCOUNT_DR_CR, '1', NVL(FCB.THIS_DR_AMOUNT,0),      NVL(THIS_CR_AMOUNT,0))                    AS  THIS_AMOUNT
                 , DECODE(ACCOUNT_DR_CR, '1', NVL(FCB.THIS_DR_CURR_AMOUNT,0), NVL(THIS_CR_CURR_AMOUNT,0))               AS  THIS_CURR_AMOUNT
                 , DECODE(ACCOUNT_DR_CR, '1', CASE WHEN FCB.THIS_DR_CURR_AMOUNT <> 0 THEN FCB.CURRENCY_CODE ELSE NULL END,
                                              CASE WHEN FCB.THIS_CR_CURR_AMOUNT <> 0 THEN FCB.CURRENCY_CODE ELSE NULL END)  THIS_CURRENCY_CODE

                 , DECODE(ACCOUNT_DR_CR, '1', NVL(FCB.THIS_CR_AMOUNT,0),      NVL(THIS_DR_AMOUNT,0))                    AS  PAY_AMOUNT
                 , DECODE(ACCOUNT_DR_CR, '1', NVL(FCB.THIS_CR_CURR_AMOUNT,0), NVL(THIS_DR_CURR_AMOUNT,0))               AS  PAY_CURR_AMOUNT
                 , DECODE(ACCOUNT_DR_CR, '1', CASE WHEN FCB.THIS_CR_CURR_AMOUNT <> 0 THEN FCB.CURRENCY_CODE ELSE NULL END,
                                              CASE WHEN FCB.THIS_DR_CURR_AMOUNT <> 0 THEN FCB.CURRENCY_CODE ELSE NULL END)  PAY_CURRENCY_CODE

                 , DECODE(ACCOUNT_DR_CR, '1', NVL(FCB.THIS_DR_AMOUNT,0) - NVL(THIS_CR_AMOUNT,0),
                                              NVL(FCB.THIS_CR_AMOUNT,0) - NVL(THIS_DR_AMOUNT,0) )                       AS  CHA_AMOUNT
                 , DECODE(ACCOUNT_DR_CR, '1', NVL(FCB.THIS_DR_CURR_AMOUNT,0) - NVL(THIS_CR_CURR_AMOUNT,0),
                                              NVL(FCB.THIS_CR_CURR_AMOUNT,0) - NVL(THIS_DR_CURR_AMOUNT,0) )             AS  CHA_CURR_AMOUNT
              FROM FI_CUSTOMER_BALANCE      FCB
                 , FI_ACCOUNT_CONTROL       FAC
                 , FI_SUPP_CUST_V           FSC
             WHERE FSC.SUPP_CUST_ID       = FCB.CUSTOMER_ID
               AND FAC.ACCOUNT_CONTROL_ID = FCB.ACCOUNT_CONTROL_ID
               /*AND FCB.ACCOUNT_CODE       IN  (SELECT FAC.ACCOUNT_CODE
                                                 FROM FI_ACCOUNT_CONTROL    FAC
                                                    , FI_COMMON             FC
                                                WHERE FAC.ACCOUNT_GL_ID  =  FC.COMMON_ID
                                                  AND FC.ENABLED_FLAG    = 'Y'
                                                  AND FAC.SOB_ID         =  W_SOB_ID
                                                  AND FC.GROUP_CODE      =  'GL_TYPE'
                                                  AND FC.CODE            =  NVL(W_GROUP_CODE, FC.CODE )
                                              )*/
               AND FCB.SOB_ID             = W_SOB_ID
               AND FSC.SOB_ID             = FCB.SOB_ID
               AND FCB.SOB_ID             = FAC.SOB_ID
               AND FCB.CUSTOMER_ID        = NVL(W_CUSTOMER_ID, FCB.CUSTOMER_ID)
               AND FCB.PERIOD_NAME        = NVL(W_PERIOD_NAME, FCB.PERIOD_NAME)

          ) BALANCE
          , FI_SUPP_CUST_V   FSCV
      WHERE BALANCE.SUPP_CUST_ID = FSCV.SUPP_CUST_ID(+)

      ORDER BY CUSTOMER_NAME
            , TAX_REG_NO
            ;

  END;


       -- 2) 거래처별 잔액리스트 DETAIL
       PROCEDURE CUSTOMER_BALANCE_LINE_SELECT( P_CURSOR                        OUT TYPES.TCURSOR
                                             , W_SOB_ID                        IN  FI_CUSTOMER_BALANCE.SOB_ID%TYPE
                                             , W_ORG_ID                        IN  FI_CUSTOMER_BALANCE.ORG_ID%TYPE
                                             , W_GROUP_CODE                    IN  FI_COMMON.GROUP_CODE%TYPE
                                             , W_PERIOD_NAME                   IN  FI_UNLIQUIDATE_LINE.PERIOD_NAME%TYPE
                                             , W_SUPP_CUST_ID                  IN  FI_SUPP_CUST_V.SUPP_CUST_ID%TYPE
                                             )

       IS

       BEGIN
                 OPEN P_CURSOR FOR
                 SELECT BALANCE.GUBUN                    -- 구분
                      , BALANCE.SORT_DATE
                      , BALANCE.SORT_NUM
                      , BALANCE.SORT_B_DATE
                      , BALANCE.SORT_B_NUM

                      , BALANCE.GL_DATE                  -- 발생회계일자  (Acc. Date)
                      , BALANCE.GL_NUM                   -- 발생회계번호  (Acc. Number)
                      , BALANCE.FA_GL_DATE               -- 반제회계일자  (Pay. Date)
                      , BALANCE.FA_GL_NUM                -- 반제회계번호  (Pay. Number)
                      , BALANCE.TAX_REG_NO               -- 거래선코드 (Customer Number)
                      , BALANCE.BEFORE_AMOUNT            -- 이월금액(원화) ( Before Amount )
                      , BALANCE.BEFORE_CURR_AMOUNT       -- 이월금액(외화) ( Before Curr. Amount )
                      , BALANCE.BEFORE_CURRENCY_CODE     -- 이월통화 ( Curr. Code )
                      , BALANCE.THIS_AMOUNT              -- 당월발생금액(원화) ( This Month Amount )
                      , BALANCE.THIS_CURR_AMOUNT         -- 당월발생금액(외화) ( This Month Curr. Amount )
                      , BALANCE.THIS_CURRENCY_CODE       -- 당월발생통화 ( Curr. Code )
                      , BALANCE.PAY_AMOUNT               -- 반제금액(원화) ( Payment Amount )
                      , BALANCE.PAY_CURR_AMOUNT          -- 반제금액(외화) ( Payment Curr. Amount )
                      , BALANCE.PAY_CURRENCY_CODE        -- 당월반제통화 ( Curr. Code )
                      , BALANCE.REMAIN_AMOUNT            -- 잔액금액(원화) ( Remain Amount )
                      , BALANCE.REMAIN_CURR_AMOUNT       -- 잔액금액(원화) ( Remain Curr. Amount )
                      , BALANCE.REMAIN_CURRENCY_CODE     -- 잔액통화 ( Curr. Code )
                      , BALANCE.SUPP_CUST_ID
                   FROM
                      (
                        -- 전월이월잔액 반제Data
                        SELECT '1'                                                             AS  GUBUN
                             , TO_CHAR(FCBFC.GL_DATE,'YYYYMMDD')                               AS  SORT_DATE
                             , SUBSTR(FCBFC.GL_NUM,4,10)                                       AS  SORT_NUM
                             , '00000000'                                                      AS  SORT_B_DATE
                             , '000000-000'                                                    AS  SORT_B_NUM

                             , FCBFC.GL_DATE                                                   AS  GL_DATE
                             , FCBFC.GL_NUM                                                    AS  GL_NUM
                             , NULL                                                            AS  FA_GL_DATE
                             , NULL                                                            AS  FA_GL_NUM

                             , FCBFC.TAX_REG_NO                                                AS  TAX_REG_NO
                             , FCBFC.SUPP_CUST_ID                                              AS  SUPP_CUST_ID
                             , FCBFC.BEFORE_AMOUNT                                             AS  BEFORE_AMOUNT
                             , FCBFC.BEFORE_CURR_AMOUNT                                        AS  BEFORE_CURR_AMOUNT
                             , FCBFC.CURRENCY_CODE                                             AS  BEFORE_CURRENCY_CODE
                             , 0                                                               AS  THIS_AMOUNT
                             , 0.0000                                                          AS  THIS_CURR_AMOUNT
                             , ''                                                              AS  THIS_CURRENCY_CODE
                             , 0                                                               AS  PAY_AMOUNT
                             , 0.0000                                                          AS  PAY_CURR_AMOUNT
                             , ''                                                              AS  PAY_CURRENCY_CODE
                             , FCBFC.BEFORE_AMOUNT      - NVL(SUM(FUL.GL_AMOUNT), 0)           AS  REMAIN_AMOUNT
                             , FCBFC.BEFORE_CURR_AMOUNT - NVL(SUM(FUL.GL_CURRENCY_AMOUNT), 0)  AS  REMAIN_CURR_AMOUNT
                             , FCBFC.CURRENCY_CODE                                             AS  REMAIN_CURRENCY_CODE
                          FROM
                             ( SELECT FCBF.GL_DATE              AS GL_DATE
                                    , FCBF.SOB_ID               AS SOB_ID
                                    , FCBF.GL_NUM               AS GL_NUM
                                    , FCBF.SLIP_LINE_ID         AS SLIP_LINE_ID
                                    , NVL(FSCV.TAX_REG_NO,FSCV.SUPP_CUST_CODE)         AS TAX_REG_NO
                                    , FSCV.SUPP_CUST_ID                                AS SUPP_CUST_ID

                                    , FCBF.ACCOUNT_CODE         AS ACCOUNT_CODE
                                    , FCBF.CURRENCY_CODE        AS CURRENCY_CODE
                                    , FCBF.REMAIN_AMOUNT        AS BEFORE_AMOUNT
                                    , FCBF.REMAIN_CURR_AMOUNT   AS BEFORE_CURR_AMOUNT
                                 FROM FI_CUSTOMER_BALANCE_FORWARD  FCBF
                                    , FI_SUPP_CUST_V               FSCV
                                WHERE FSCV.SUPP_CUST_ID(+)       = FCBF.CUSTOMER_ID
                                  AND FCBF.PERIOD_NAME           = NVL(W_PERIOD_NAME, FCBF.PERIOD_NAME)
                                  AND FCBF.SOB_ID                = W_SOB_ID
                                 /* AND FCBF.ACCOUNT_CODE            IN (SELECT FAC.ACCOUNT_CODE
                                                                         FROM FI_ACCOUNT_CONTROL    FAC
                                                                            , FI_COMMON             FC
                                                                        WHERE FAC.ACCOUNT_GL_ID  =  FC.COMMON_ID
                                                                          AND FC.ENABLED_FLAG    = 'Y'
                                                                          AND FAC.SOB_ID         =  W_SOB_ID
                                                                          AND FC.GROUP_CODE      = 'GL_TYPE'
                                                                          AND FC.CODE            =  NVL(W_GROUP_CODE, FC.CODE)
                                                                       GROUP BY FAC.ACCOUNT_CODE
                                                                      )*/
                             )                          FCBFC
                             , FI_UNLIQUIDATE_LINE      FUL
                         WHERE FUL.SLIP_LINE_ID(+)   =  FCBFC.SLIP_LINE_ID
                           AND FUL.SOB_ID(+)         =  FCBFC.SOB_ID
                           AND FUL.PERIOD_NAME       =  NVL(W_PERIOD_NAME, FUL.PERIOD_NAME)
                      GROUP BY FCBFC.GL_DATE
                             , FCBFC.GL_NUM
                             , FCBFC.TAX_REG_NO
                             , FCBFC.SUPP_CUST_ID
                             , FCBFC.BEFORE_AMOUNT
                             , FCBFC.BEFORE_CURR_AMOUNT
                             , FCBFC.CURRENCY_CODE
                             , FCBFC.ACCOUNT_CODE

                      UNION ALL

                        -- 이월잔액 당월반제리스트
                        SELECT '1'                                AS  GUBUN
                             , TO_CHAR(FCBF.GL_DATE,'YYYYMMDD')   AS  SORT_DATE
                             , SUBSTR(FCBF.GL_NUM,4,10)           AS  SORT_NUM
                             , TO_CHAR(FUL.GL_DATE,'YYYYMMDD')    AS  SORT_B_DATE
                             , SUBSTR(FUL.GL_NUM,4,10)            AS  SORT_B_NUM
                             , FCBF.GL_DATE                 AS  GL_DATE
                             , FCBF.GL_NUM                  AS  GL_NUM
                             , FUL.GL_DATE                  AS  FA_GL_DATE
                             , FUL.GL_NUM                   AS  FA_GL_NUM

                             , NVL(FSCV.TAX_REG_NO, FSCV.SUPP_CUST_CODE)                     AS  TAX_REG_NO
                             , FSCV.SUPP_CUST_ID                                             AS  SUPP_CUST_ID

                             , 0                            AS  BEFORE_AMOUNT
                             , 0                            AS  BEFORE_CURR_AMOUNT
                             , ''                           AS  BEFORE_CURRENCY_CODE
                             , 0                            AS  THIS_AMOUNT
                             , 0                            AS  THIS_CURR_AMOUNT
                             , ''                           AS  THIS_CURRENCY_CODE
                             , FUL.GL_AMOUNT                AS  PAY_AMOUNT
                             , FUL.GL_CURRENCY_AMOUNT       AS  PAY_CURR_AMOUNT
                             , FUL.CURRENCY_CODE            AS  PAY_CURRENCY_CODE
                             , 0                            AS  REMAIN_AMOUNT
                             , 0                            AS  REMAIN_CURR_AMOUNT
                             , ''                           AS  REMAIN_CURRENCY_CODE
                          FROM FI_CUSTOMER_BALANCE_FORWARD  FCBF
                             , FI_UNLIQUIDATE_LINE          FUL
                             , FI_SUPP_CUST_V               FSCV
                         WHERE FSCV.SUPP_CUST_ID          = FCBF.CUSTOMER_ID
                           AND FUL.SLIP_LINE_ID           = FCBF.SLIP_LINE_ID
                           AND FUL.PERIOD_NAME            = FCBF.PERIOD_NAME
                           AND FCBF.PERIOD_NAME           = NVL(W_PERIOD_NAME, FCBF.PERIOD_NAME)
                           /*AND FCBF.ACCOUNT_CODE            IN (SELECT FAC.ACCOUNT_CODE
                                                                  FROM FI_ACCOUNT_CONTROL    FAC
                                                                     , FI_COMMON             FC
                                                                 WHERE FAC.ACCOUNT_GL_ID  =  FC.COMMON_ID
                                                                   AND FC.ENABLED_FLAG    = 'Y'
                                                                   AND FAC.SOB_ID         =  W_SOB_ID
                                                                   AND FC.GROUP_CODE      = 'GL_TYPE'
                                                                   AND FC.CODE            =  NVL(W_GROUP_CODE, FC.CODE)
                                                                GROUP BY FAC.ACCOUNT_CODE
                                                               )*/

                      UNION ALL

                        --  당월발생DATA
                        SELECT '2'                                AS  GUBUN
                             , TO_CHAR(FUHV.GL_DATE,'YYYYMMDD')   AS  SORT_DATE
                             , SUBSTR(FUHV.GL_NUM,4,10)           AS  SORT_NUM
                             , '00000000'                         AS  SORT_B_DATE
                             , '000000-000'                       AS  SORT_B_NUM

                             , FUHV.GL_DATE                                                  AS  GL_DATE
                             , FUHV.GL_NUM                                                   AS  GL_NUM
                             , NULL                                                          AS  FA_GL_DATE
                             , NULL                                                          AS  FA_GL_NUM

                             , NVL(FSCV.TAX_REG_NO, FSCV.SUPP_CUST_CODE)                     AS  TAX_REG_NO
                             , FSCV.SUPP_CUST_ID                                             AS  SUPP_CUST_ID

                             , 0                                                             AS  BEFORE_AMOUNT
                             , 0                                                             AS  BEFORE_CURR_AMOUNT
                             , ''                                                            AS  BEFORE_CURRENCY_CODE
                             , FUHV.THIS_AMOUNT
                             , FUHV.THIS_CURR_AMOUNT
                             , FUHV.CURRENCY_CODE                                            AS  THIS_CURRENCY_CODE
                             , 0                                                             AS  PAY_AMOUNT
                             , 0                                                             AS  PAY_CURR_AMOUNT
                             , ''                                                            AS  PAY_CURRENCY_CODE
                             , FUHV.THIS_AMOUNT      - NVL(SUM(FUL.GL_AMOUNT), 0)            AS  REMAIN_AMOUNT
                             , FUHV.THIS_CURR_AMOUNT - NVL(SUM(FUL.GL_CURRENCY_AMOUNT), 0)   AS  REMAIN_CURR_AMOUNT
                             , FUHV.CURRENCY_CODE                                            AS  REMAIN_CURRENCY_CODE
                          FROM
                             ( SELECT FUH.SOB_ID             AS SOB_ID
                                    , FUH.GL_DATE            AS GL_DATE
                                    , FUH.GL_NUM             AS GL_NUM
                                    , FUH.PERIOD_NAME        AS PERIOD_NAME
                                    , FUH.SLIP_LINE_ID       AS SLIP_LINE_ID
                                    , FUH.CUSTOMER_ID        AS CUSTOMER_ID
                                    , FUH.GL_AMOUNT          AS THIS_AMOUNT
                                    , FUH.GL_CURRENCY_AMOUNT AS THIS_CURR_AMOUNT
                                    , FUH.CURRENCY_CODE      AS CURRENCY_CODE
                                 FROM FI_UNLIQUIDATE_HEADER  FUH
                                WHERE FUH.PERIOD_NAME      = NVL(W_PERIOD_NAME, FUH.PERIOD_NAME)
                                  AND FUH.SOB_ID           = W_SOB_ID
                                  /*AND FUH.ACCOUNT_CODE       IN (SELECT FAC.ACCOUNT_CODE
                                                                   FROM FI_ACCOUNT_CONTROL    FAC
                                                                      , FI_COMMON             FC
                                                                  WHERE FAC.ACCOUNT_GL_ID  =  FC.COMMON_ID
                                                                    AND FC.ENABLED_FLAG    = 'Y'
                                                                    AND FAC.SOB_ID         =  W_SOB_ID
                                                                    AND FC.GROUP_CODE      = 'GL_TYPE'
                                                                    AND FC.CODE            =  NVL(W_GROUP_CODE, FC.CODE)
                                                                 GROUP BY FAC.ACCOUNT_CODE
                                                                )*/
                             )                         FUHV
                             , FI_UNLIQUIDATE_LINE     FUL
                             , FI_SUPP_CUST_V          FSCV
                         WHERE FUL.SLIP_LINE_ID(+)  =  FUHV.SLIP_LINE_ID
                           AND FUL.PERIOD_NAME(+)   =  FUHV.PERIOD_NAME
                           AND FSCV.SUPP_CUST_ID(+) =  FUHV.CUSTOMER_ID
                           AND FUL.SOB_ID(+)        =  FUHV.SOB_ID
                      GROUP BY FUHV.GL_DATE
                             , FUHV.GL_NUM
                             , FSCV.TAX_REG_NO
                             , FSCV.SUPP_CUST_CODE
                             , FSCV.SUPP_CUST_ID
                             , FUHV.THIS_AMOUNT
                             , FUHV.THIS_CURR_AMOUNT
                             , FUHV.CURRENCY_CODE

                      UNION ALL

                        -- 당월발생 반제리스트
                        SELECT '2'                                AS GUBUN
                             , TO_CHAR(FUHV.GL_DATE,'YYYYMMDD')   AS  SORT_DATE
                             , SUBSTR(FUHV.GL_NUM,4,10)           AS  SORT_NUM
                             , TO_CHAR(FUL.GL_DATE,'YYYYMMDD')    AS  SORT_B_DATE
                             , SUBSTR(FUL.GL_NUM,4,10)            AS  SORT_B_NUM

                             , FUHV.GL_DATE                 AS GL_DATE
                             , FUHV.GL_NUM                  AS GL_NUM
                             , FUL.GL_DATE                  AS FA_GL_DATE
                             , FUL.GL_NUM                   AS FA_GL_NUM

                             , NVL(FSCV.TAX_REG_NO, FSCV.SUPP_CUST_CODE)                     AS  TAX_REG_NO
                             , FSCV.SUPP_CUST_ID                                             AS  SUPP_CUST_ID

                             , 0                            AS BEFORE_AMOUNT
                             , 0                            AS BEFORE_CURR_AMOUNT
                             , NULL                         AS BEFORE_CURRENCY_CODE
                             , 0                            AS THIS_AMOUNT
                             , 0                            AS THIS_CURR_AMOUNT
                             , NULL                         AS THIS_CURRENCY_CODE
                             , FUL.GL_AMOUNT                AS PAY_AMOUNT
                             , FUL.GL_CURRENCY_AMOUNT       AS PAY_CURR_AMOUNT
                             , FUL.CURRENCY_CODE            AS PAY_CURRENCY_CODE
                             , 0                            AS REMAIN_AMOUNT
                             , 0                            AS REMAIN_CURR_AMOUNT
                             , NULL                         AS REMAIN_CURRENCY_CODE
                          FROM
                             ( SELECT FUH.SOB_ID            AS SOB_ID
                                    , FUH.SLIP_LINE_ID      AS SLIP_LINE_ID
                                    , FUH.GL_NUM            AS GL_NUM
                                    , FUH.GL_DATE           AS GL_DATE
                                    , FUH.CUSTOMER_ID       AS CUSTOMER_ID
                                    , FUH.CURRENCY_CODE     AS CURRENCY_CODE
                                    , FUH.PERIOD_NAME       AS PERIOD_NAME
                                 FROM FI_UNLIQUIDATE_HEADER FUH
                                WHERE FUH.PERIOD_NAME     = NVL(W_PERIOD_NAME, FUH.PERIOD_NAME)
                                  AND FUH.SOB_ID          = W_SOB_ID
                                  /*AND FUH.ACCOUNT_CODE      IN (SELECT FAC.ACCOUNT_CODE
                                                                  FROM FI_ACCOUNT_CONTROL    FAC
                                                                     , FI_COMMON             FC
                                                                 WHERE FAC.ACCOUNT_GL_ID  =  FC.COMMON_ID
                                                                   AND FC.ENABLED_FLAG    = 'Y'
                                                                   AND FAC.SOB_ID         =  W_SOB_ID
                                                                   AND FC.GROUP_CODE      = 'GL_TYPE'
                                                                   AND FC.CODE            =  NVL(W_GROUP_CODE, FC.CODE)
                                                                GROUP BY FAC.ACCOUNT_CODE
                                                               )*/
                             )                          FUHV
                             , FI_UNLIQUIDATE_LINE      FUL
                             , FI_SUPP_CUST_V           FSCV
                         WHERE FUL.SLIP_LINE_ID      =  FUHV.SLIP_LINE_ID
                           AND FUL.SOB_ID            =  FUHV.SOB_ID
                           AND FUL.PERIOD_NAME       =  FUHV.PERIOD_NAME
                           AND FSCV.SUPP_CUST_ID     =  FUHV.CUSTOMER_ID


                      UNION ALL

                        -- 잘못반제된 DATA LIST
                        -- 찾아야 됨.....
                        SELECT '3'                                AS  GUBUN
                             , TO_CHAR(FUL.GL_DATE,'YYYYMMDD')    AS  SORT_DATE
                             , '000000-000'                       AS  SORT_NUM
                             , TO_CHAR(FUL.GL_DATE,'YYYYMMDD')    AS  SORT_B_DATE
                             , '000000-000'                       AS  SORT_B_NUM

                             , FUL.GL_DATE                   AS  GL_DATE
                             , ' '                           AS  GL_NUM
                             , FUL.GL_DATE                   AS  FA_GL_DATE
                             , FUL.GL_NUM                    AS  FA_GL_NUM

                             , NVL(FSCV.TAX_REG_NO, FSCV.SUPP_CUST_CODE)                     AS  TAX_REG_NO
                             , FSCV.SUPP_CUST_ID                                             AS  SUPP_CUST_ID

                             , 0                             AS  BEFORE_AMOUNT
                             , 0.0000                        AS  BEFORE_CURR_AMOUNT
                             , ''                            AS  BEFORE_CURRENCY_CODE
                             , 0                             AS  THIS_AMOUNT
                             , 0.0000                        AS  THIS_CURR_AMOUNT
                             , ''                            AS  THIS_CURRENCY_CODE
                             , FUL.GL_AMOUNT                 AS  PAY_AMOUNT
                             , FUL.GL_CURRENCY_AMOUNT        AS  PAY_CURR_AMOUNT
                             , FUL.CURRENCY_CODE
                             , FUL.GL_AMOUNT * -1            AS  REMAIN_AMOUNT
                             , FUL.GL_CURRENCY_AMOUNT * -1   AS  REMAIN_CURR_AMOUNT
                             , FUL.CURRENCY_CODE             AS  REMAIN_CURRENCY_CODE
                          FROM FI_UNLIQUIDATE_LINE           FUL
                             , FI_SLIP_LINE                  FSL
                             , FI_SUPP_CUST_V                FSCV
                         WHERE FSCV.SUPP_CUST_ID(+)      =   FUL.CUSTOMER_ID
                           AND FSL.SLIP_LINE_ID          =   FUL.LIQUIDATE_SLIP_LINE_ID
                           AND FSL.CONFIRM_YN            =   'Y'
                           AND FUL.SOB_ID                =   W_SOB_ID
                           AND (FUL.SLIP_LINE_ID)
                                NOT IN (SELECT FUH.SLIP_LINE_ID
                                          FROM FI_UNLIQUIDATE_HEADER FUH
                                         WHERE FUH.PERIOD_NAME    = NVL(W_PERIOD_NAME, FUH.PERIOD_NAME)
                                           AND FUH.SOB_ID         = W_SOB_ID
                                           /*AND FUH.ACCOUNT_CODE     IN (SELECT FAC.ACCOUNT_CODE
                                                                          FROM FI_ACCOUNT_CONTROL    FAC
                                                                             , FI_COMMON             FC
                                                                         WHERE FAC.ACCOUNT_GL_ID  =  FC.COMMON_ID
                                                                           AND FC.ENABLED_FLAG    = 'Y'
                                                                           AND FAC.SOB_ID         =  W_SOB_ID
                                                                           AND FC.SOB_ID          =  FAC.SOB_ID
                                                                           AND FC.GROUP_CODE      = 'GL_TYPE'
                                                                           AND FC.CODE            =  NVL(W_GROUP_CODE, FC.CODE)
                                                                         GROUP BY FAC.ACCOUNT_CODE
                                                                       )*/
                                        )
                           /*AND FSL.ACCOUNT_CODE IN (SELECT FAC.ACCOUNT_CODE
                                                      FROM FI_ACCOUNT_CONTROL    FAC
                                                         , FI_COMMON             FC
                                                     WHERE FAC.ACCOUNT_GL_ID  =  FC.COMMON_ID
                                                       AND FC.ENABLED_FLAG    = 'Y'
                                                       AND FAC.SOB_ID         =  W_SOB_ID
                                                       AND FC.GROUP_CODE      = 'GL_TYPE'
                                                       AND FC.CODE            =  NVL(W_GROUP_CODE, FC.CODE)
                                                    GROUP BY FAC.ACCOUNT_CODE
                                                   )*/
                           AND FUL.PERIOD_NAME  = NVL(W_PERIOD_NAME, FUL.PERIOD_NAME)

                      ) BALANCE
                  WHERE BALANCE.SUPP_CUST_ID   = NVL(W_SUPP_CUST_ID, BALANCE.SUPP_CUST_ID)
               ORDER BY BALANCE.GUBUN
                      , BALANCE.SORT_DATE
                      , BALANCE.SORT_NUM
                      , BALANCE.SORT_B_DATE
                      , BALANCE.SORT_B_NUM
                      ;

       END;

       --3) 기간별 거래처별 잔액장DETAIL
       PROCEDURE CUSTOMER_BALANCE_DATE_SELECT( P_CURSOR3                       OUT TYPES.TCURSOR3
                                             , W_SOB_ID                        IN  FI_CUSTOMER_BALANCE.SOB_ID%TYPE
                                             , W_ORG_ID                        IN  FI_CUSTOMER_BALANCE.ORG_ID%TYPE
                                             , W_GROUP_CODE                    IN  FI_COMMON.GROUP_CODE%TYPE
                                             , W_PERIOD_NAME                   IN  FI_UNLIQUIDATE_LINE.PERIOD_NAME%TYPE
                                             , W_FROM_DATE                     IN  FI_UNLIQUIDATE_LINE.GL_DATE%TYPE
                                             , W_TO_DATE                       IN  FI_UNLIQUIDATE_LINE.GL_DATE%TYPE
                                             , W_SUPP_CUST_ID                  IN  FI_SUPP_CUST_V.SUPP_CUST_ID%TYPE
                                             )

       IS

       BEGIN
                 OPEN P_CURSOR3 FOR
                 SELECT BALANCE.GUBUN                    -- 구분
                      , BALANCE.GL_DATE                  -- 발생회계일자  (Acc. Date)
                      , BALANCE.GL_NUM                   -- 발생회계번호  (Acc. Number)
                      , BALANCE.FA_GL_DATE               -- 반제회계일자  (Pay. Date)
                      , BALANCE.FA_GL_NUM                -- 반제회계번호  (Pay. Number)
                      , FI_COMMON_G.SUPP_CUST_TAX_NAME_F(W_SOB_ID, BALANCE.TAX_REG_NO)  AS CUSTOMER_NAME
                      , BALANCE.BEFORE_AMOUNT            -- 이월금액(원화) ( Before Amount )
                      , BALANCE.BEFORE_CURR_AMOUNT       -- 이월금액(외화) ( Before Curr. Amount )
                      , BALANCE.BEFORE_CURRENCY_CODE     -- 이월통화 ( Curr. Code )
                      , BALANCE.THIS_AMOUNT              -- 당월발생금액(원화) ( This Month Amount )
                      , BALANCE.THIS_CURR_AMOUNT         -- 당월발생금액(외화) ( This Month Curr. Amount )
                      , BALANCE.THIS_CURRENCY_CODE       -- 당월발생통화 ( Curr. Code )
                      , BALANCE.PAY_AMOUNT               -- 반제금액(원화) ( Payment Amount )
                      , BALANCE.PAY_CURR_AMOUNT          -- 반제금액(외화) ( Payment Curr. Amount )
                      , BALANCE.PAY_CURRENCY_CODE        -- 당월반제통화 ( Curr. Code )
                      , BALANCE.REMAIN_AMOUNT            -- 잔액금액(원화) ( Remain Amount )
                      , BALANCE.REMAIN_CURR_AMOUNT       -- 잔액금액(원화) ( Remain Curr. Amount )
                      , BALANCE.REMAIN_CURRENCY_CODE     -- 잔액통화 ( Curr. Code )

                      , BALANCE.MANAGEMENT1     --관리항목1(Management1)
                      , BALANCE.MANAGEMENT2     --관리항목2(Management2)
                      , BALANCE.REFER1          --참고항목1(Reference1)
                      , BALANCE.REFER2          --참고항목2(Reference2)
                      , BALANCE.REFER3          --참고항목3(Reference3)
                      , BALANCE.REFER4          --참고항목4(Reference4)
                      , BALANCE.REFER5          --참고항목5(Reference5)

                      , BALANCE.SORT_DATE
                      , BALANCE.SORT_NUM
                      , BALANCE.SORT_B_DATE
                      , BALANCE.SORT_B_NUM
                      , BALANCE.SUPP_CUST_ID
                      , BALANCE.SLIP_HEADER_ID           --전표 Header Line ID
                   FROM
                      (
                     -- 전월이월잔액 반제Data
                        SELECT '1'                                                             AS  GUBUN
                             , TO_CHAR(FCBFC.GL_DATE,'YYYYMMDD')                               AS  SORT_DATE
                             , SUBSTR(FCBFC.GL_NUM,4,10)                                       AS  SORT_NUM
                             , '00000000'                                                      AS  SORT_B_DATE
                             , '000000-000'                                                    AS  SORT_B_NUM

                             ,(SELECT SLIP_HEADER_ID  FROM  FI_SLIP_LINE
                                WHERE SLIP_LINE_ID = FCBFC.SLIP_LINE_ID )                      AS  SLIP_HEADER_ID
                             , FCBFC.GL_DATE                                                   AS  GL_DATE
                             , FCBFC.GL_NUM                                                    AS  GL_NUM
                             , NULL                                                            AS  FA_GL_DATE
                             , NULL                                                            AS  FA_GL_NUM

                             , FCBFC.TAX_REG_NO                                                AS  TAX_REG_NO
                             , FCBFC.SUPP_CUST_ID                                              AS  SUPP_CUST_ID
                             , FCBFC.BEFORE_AMOUNT                                             AS  BEFORE_AMOUNT
                             , FCBFC.BEFORE_CURR_AMOUNT                                        AS  BEFORE_CURR_AMOUNT
                             , FCBFC.CURRENCY_CODE                                             AS  BEFORE_CURRENCY_CODE
                             , 0                                                               AS  THIS_AMOUNT
                             , 0.0000                                                          AS  THIS_CURR_AMOUNT
                             , ''                                                              AS  THIS_CURRENCY_CODE
                             , 0                                                               AS  PAY_AMOUNT
                             , 0.0000                                                          AS  PAY_CURR_AMOUNT
                             , ''                                                              AS  PAY_CURRENCY_CODE
                             , FCBFC.BEFORE_AMOUNT      - NVL(FUL.GL_AMOUNT, 0)                AS  REMAIN_AMOUNT
                             , FCBFC.BEFORE_CURR_AMOUNT - NVL(FUL.GL_CURRENCY_AMOUNT, 0)       AS  REMAIN_CURR_AMOUNT
                             , FCBFC.CURRENCY_CODE                                             AS  REMAIN_CURRENCY_CODE

                             , FCBFC.MANAGEMENT1           AS MANAGEMENT1
                             , FCBFC.MANAGEMENT2           AS MANAGEMENT2
                             , FCBFC.REFER1                AS REFER1
                             , FCBFC.REFER2                AS REFER2
                             , FCBFC.REFER3                AS REFER3
                             , FCBFC.REFER4                AS REFER4
                             , FCBFC.REFER5                AS REFER5


                          FROM
                             ( SELECT FCBF.GL_DATE              AS GL_DATE
                                    , FCBF.SOB_ID               AS SOB_ID
                                    , FCBF.GL_NUM               AS GL_NUM
                                    , FCBF.SLIP_LINE_ID         AS SLIP_LINE_ID
                                    , NVL(FSCV.TAX_REG_NO,FSCV.SUPP_CUST_CODE)  AS TAX_REG_NO
                                    , FSCV.SUPP_CUST_ID                         AS SUPP_CUST_ID

                                    , FCBF.ACCOUNT_CODE         AS ACCOUNT_CODE
                                    , FCBF.CURRENCY_CODE        AS CURRENCY_CODE
                                    , FCBF.REMAIN_AMOUNT        AS BEFORE_AMOUNT
                                    , FCBF.REMAIN_CURR_AMOUNT   AS BEFORE_CURR_AMOUNT

                                    , FSL.MANAGEMENT1           AS MANAGEMENT1
                                    , FSL.MANAGEMENT2           AS MANAGEMENT2
                                    , FSL.REFER1                AS REFER1
                                    , FSL.REFER2                AS REFER2
                                    , FSL.REFER3                AS REFER3
                                    , FSL.REFER4                AS REFER4
                                    , FSL.REFER5                AS REFER5

                                 FROM FI_CUSTOMER_BALANCE_FORWARD  FCBF
                                    , FI_SUPP_CUST_V               FSCV
                                    , FI_SLIP_LINE                 FSL
                                WHERE FSCV.SUPP_CUST_ID(+)       = FCBF.CUSTOMER_ID
                                  AND FCBF.PERIOD_NAME           = NVL(W_PERIOD_NAME, FCBF.PERIOD_NAME)
                                  AND FCBF.SOB_ID                = W_SOB_ID
                                  AND FSL.SLIP_LINE_ID           = FCBF.SLIP_LINE_ID
                                  AND FSL.SOB_ID                 = FCBF.SOB_ID
                                  /*AND FCBF.ACCOUNT_CODE            IN (SELECT FAC.ACCOUNT_CODE
                                                                         FROM FI_ACCOUNT_CONTROL    FAC
                                                                            , FI_COMMON             FC
                                                                        WHERE FAC.ACCOUNT_GL_ID  =  FC.COMMON_ID
                                                                          AND FC.ENABLED_FLAG    = 'Y'
                                                                          AND FAC.SOB_ID         =  W_SOB_ID
                                                                          AND FC.GROUP_CODE      = 'GL_TYPE'
                                                                          AND FC.CODE            =  NVL(W_GROUP_CODE, FC.CODE)
                                                                       GROUP BY FAC.ACCOUNT_CODE
                                                                      )*/
                             )                          FCBFC
                             ,(SELECT  FA.SLIP_LINE_ID
                                      ,FA.SOB_ID
                                      ,SUM(NVL(FA.GL_AMOUNT,0))            GL_AMOUNT
                                      ,SUM(NVL(FA.GL_CURRENCY_AMOUNT,0))   GL_CURRENCY_AMOUNT
                                 FROM  FI_UNLIQUIDATE_LINE  FA
                                WHERE  FA.GL_DATE   BETWEEN  W_FROM_DATE  AND  W_TO_DATE
                               GROUP BY FA.SLIP_LINE_ID ,FA.SOB_ID ,FA.PERIOD_NAME
                                )   FUL
                         WHERE FUL.SLIP_LINE_ID(+)   =  FCBFC.SLIP_LINE_ID
                           AND FUL.SOB_ID(+)         =  FCBFC.SOB_ID
--                         AND FUL.PERIOD_NAME       =  NVL(W_PERIOD_NAME, FUL.PERIOD_NAME)

                      UNION ALL

                        -- 이월잔액 당월반제리스트
                        SELECT '1'                                AS  GUBUN
                             , TO_CHAR(FCBF.GL_DATE,'YYYYMMDD')   AS  SORT_DATE
                             , SUBSTR(FCBF.GL_NUM,4,10)           AS  SORT_NUM
                             , TO_CHAR(FUL.GL_DATE,'YYYYMMDD')    AS  SORT_B_DATE
                             , SUBSTR(FUL.GL_NUM,4,10)            AS  SORT_B_NUM

                             ,(SELECT SLIP_HEADER_ID  FROM  FI_SLIP_LINE
                                WHERE SLIP_LINE_ID = FUL.LIQUIDATE_SLIP_LINE_ID)      AS  SLIP_HEADER_ID
                             , FCBF.GL_DATE                 AS  GL_DATE
                             , FCBF.GL_NUM                  AS  GL_NUM
                             , FUL.GL_DATE                  AS  FA_GL_DATE
                             , FUL.GL_NUM                   AS  FA_GL_NUM

                             , NVL(FSCV.TAX_REG_NO, FSCV.SUPP_CUST_CODE)                     AS  TAX_REG_NO
                             , FSCV.SUPP_CUST_ID                                             AS  SUPP_CUST_ID

                             , 0                            AS  BEFORE_AMOUNT
                             , 0                            AS  BEFORE_CURR_AMOUNT
                             , ''                           AS  BEFORE_CURRENCY_CODE
                             , 0                            AS  THIS_AMOUNT
                             , 0                            AS  THIS_CURR_AMOUNT
                             , ''                           AS  THIS_CURRENCY_CODE
                             , FUL.GL_AMOUNT                AS  PAY_AMOUNT
                             , FUL.GL_CURRENCY_AMOUNT       AS  PAY_CURR_AMOUNT
                             , FUL.CURRENCY_CODE            AS  PAY_CURRENCY_CODE
                             , 0                            AS  REMAIN_AMOUNT
                             , 0                            AS  REMAIN_CURR_AMOUNT
                             , ''                           AS  REMAIN_CURRENCY_CODE
                             , ''                AS MANAGEMENT1
                             , ''                AS MANAGEMENT2
                             , ''                AS REFER1
                             , ''                AS REFER2
                             , ''                AS REFER3
                             , ''                AS REFER4
                             , ''                AS REFER5

                          FROM FI_CUSTOMER_BALANCE_FORWARD  FCBF
                             , FI_UNLIQUIDATE_LINE          FUL
                             , FI_SUPP_CUST_V               FSCV
                         WHERE FCBF.PERIOD_NAME           = NVL(W_PERIOD_NAME, FCBF.PERIOD_NAME)
                           AND FSCV.SUPP_CUST_ID          = FCBF.CUSTOMER_ID
                           AND FUL.SLIP_LINE_ID           = FCBF.SLIP_LINE_ID
                           AND FUL.SOB_ID                 = FCBF.SOB_ID
                           AND FCBF.ACCOUNT_CODE            IN (SELECT FAC.ACCOUNT_CODE
                                                                  FROM FI_ACCOUNT_CONTROL    FAC
                                                                     , FI_COMMON             FC
                                                                 WHERE FAC.ACCOUNT_GL_ID  =  FC.COMMON_ID
                                                                   AND FC.ENABLED_FLAG    = 'Y'
                                                                   AND FAC.SOB_ID         =  W_SOB_ID
                                                                   AND FC.GROUP_CODE      = 'GL_TYPE'
                                                                   AND FC.CODE            =  NVL(W_GROUP_CODE, FC.CODE)
                                                                GROUP BY FAC.ACCOUNT_CODE
                                                               )

                      UNION ALL

                        --  당월발생DATA
                        SELECT '2'                                                           AS  GUBUN
                             , TO_CHAR(FUHV.GL_DATE,'YYYYMMDD')   AS  SORT_DATE
                             , SUBSTR(FUHV.GL_NUM,4,10)           AS  SORT_NUM
                             , '00000000'                         AS  SORT_B_DATE
                             , '000000-000'                       AS  SORT_B_NUM

                             , (SELECT SLIP_HEADER_ID  FROM  FI_SLIP_LINE
                                WHERE SLIP_LINE_ID = FUHV.SLIP_LINE_ID)                      AS  SLIP_HEADER_ID
                             , FUHV.GL_DATE                                                  AS  GL_DATE
                             , FUHV.GL_NUM                                                   AS  GL_NUM
                             , NULL                                                          AS  FA_GL_DATE
                             , NULL                                                          AS  FA_GL_NUM

                             , NVL(FSCV.TAX_REG_NO, FSCV.SUPP_CUST_CODE)                     AS  TAX_REG_NO
                             , FSCV.SUPP_CUST_ID                                             AS  SUPP_CUST_ID

                             , 0                                                             AS  BEFORE_AMOUNT
                             , 0                                                             AS  BEFORE_CURR_AMOUNT
                             , ''                                                            AS  BEFORE_CURRENCY_CODE
                             , FUHV.THIS_AMOUNT
                             , FUHV.THIS_CURR_AMOUNT
                             , FUHV.CURRENCY_CODE                                            AS  THIS_CURRENCY_CODE
                             , 0                                                             AS  PAY_AMOUNT
                             , 0                                                             AS  PAY_CURR_AMOUNT
                             , ''                                                            AS  PAY_CURRENCY_CODE
                             , FUHV.THIS_AMOUNT      - NVL(FUL.GL_AMOUNT, 0)                 AS  REMAIN_AMOUNT
                             , FUHV.THIS_CURR_AMOUNT - NVL(FUL.GL_CURRENCY_AMOUNT, 0)        AS  REMAIN_CURR_AMOUNT
                             , FUHV.CURRENCY_CODE                                            AS  REMAIN_CURRENCY_CODE

                             , FUHV.MANAGEMENT1           AS MANAGEMENT1
                             , FUHV.MANAGEMENT2           AS MANAGEMENT2
                             , FUHV.REFER1                AS REFER1
                             , FUHV.REFER2                AS REFER2
                             , FUHV.REFER3                AS REFER3
                             , FUHV.REFER4                AS REFER4
                             , FUHV.REFER5                AS REFER5

                          FROM
                             ( SELECT FUH.SOB_ID             AS SOB_ID
                                    , FUH.GL_DATE            AS GL_DATE
                                    , FUH.GL_NUM             AS GL_NUM
                                    , FUH.PERIOD_NAME        AS PERIOD_NAME
                                    , FUH.SLIP_LINE_ID       AS SLIP_LINE_ID
                                    , FUH.CUSTOMER_ID        AS CUSTOMER_ID
                                    , FUH.GL_AMOUNT          AS THIS_AMOUNT
                                    , FUH.GL_CURRENCY_AMOUNT AS THIS_CURR_AMOUNT
                                    , FUH.CURRENCY_CODE      AS CURRENCY_CODE

                                    , FSL.MANAGEMENT1           AS MANAGEMENT1
                                    , FSL.MANAGEMENT2           AS MANAGEMENT2
                                    , FSL.REFER1                AS REFER1
                                    , FSL.REFER2                AS REFER2
                                    , FSL.REFER3                AS REFER3
                                    , FSL.REFER4                AS REFER4
                                    , FSL.REFER5                AS REFER5

                                 FROM FI_UNLIQUIDATE_HEADER  FUH
                                    , FI_SLIP_LINE           FSL
                                WHERE FUH.GL_DATE   BETWEEN  W_FROM_DATE  AND  W_TO_DATE
                                  AND FUH.SOB_ID           = W_SOB_ID
                                  AND FSL.SLIP_LINE_ID     = FUH.SLIP_LINE_ID
                                  AND FSL.SOB_ID           = FUH.SOB_ID
                                  AND FUH.ACCOUNT_CODE       IN (SELECT FAC.ACCOUNT_CODE
                                                                   FROM FI_ACCOUNT_CONTROL    FAC
                                                                      , FI_COMMON             FC
                                                                  WHERE FAC.ACCOUNT_GL_ID  =  FC.COMMON_ID
                                                                    AND FC.ENABLED_FLAG    = 'Y'
                                                                    AND FAC.SOB_ID         =  W_SOB_ID
                                                                    AND FC.GROUP_CODE      = 'GL_TYPE'
                                                                    AND FC.CODE            =  NVL(W_GROUP_CODE, FC.CODE)
                                                                 GROUP BY FAC.ACCOUNT_CODE
                                                                )
                             )                         FUHV
                            , (SELECT  FA.SLIP_LINE_ID
                                      ,FA.SOB_ID
                                      ,SUM(NVL(FA.GL_AMOUNT,0))            GL_AMOUNT
                                      ,SUM(NVL(FA.GL_CURRENCY_AMOUNT,0))   GL_CURRENCY_AMOUNT
                                 FROM  FI_UNLIQUIDATE_LINE  FA
                                WHERE  FA.GL_DATE   BETWEEN  W_FROM_DATE  AND  W_TO_DATE
                               GROUP BY FA.SLIP_LINE_ID ,FA.SOB_ID
                                )   FUL
                             , FI_SUPP_CUST_V          FSCV
                         WHERE FUL.SLIP_LINE_ID(+)  =  FUHV.SLIP_LINE_ID
                           AND FUL.SOB_ID(+)        =  FUHV.SOB_ID
--                         AND FUL.GL_DATE(+)       =  FUHV.GL_DATE
                           AND FSCV.SOB_ID(+)       =  FUHV.SOB_ID
                           AND FSCV.SUPP_CUST_ID(+) =  FUHV.CUSTOMER_ID

                      UNION ALL

                        -- 당월발생 반제리스트
                        SELECT '2'                                AS GUBUN
                             , TO_CHAR(FUHV.GL_DATE,'YYYYMMDD')   AS  SORT_DATE
                             , SUBSTR(FUHV.GL_NUM,4,10)           AS  SORT_NUM
                             , TO_CHAR(FUL.GL_DATE,'YYYYMMDD')    AS  SORT_B_DATE
                             , SUBSTR(FUL.GL_NUM,4,10)            AS  SORT_B_NUM

                             , (SELECT SLIP_HEADER_ID  FROM  FI_SLIP_LINE
                                WHERE SLIP_LINE_ID = FUL.SLIP_LINE_ID)  AS  SLIP_HEADER_ID
                             , FUHV.GL_DATE                 AS GL_DATE
                             , FUHV.GL_NUM                  AS GL_NUM
                             , FUL.GL_DATE                  AS FA_GL_DATE
                             , FUL.GL_NUM                   AS FA_GL_NUM

                             , NVL(FSCV.TAX_REG_NO, FSCV.SUPP_CUST_CODE)  AS  TAX_REG_NO
                             , FSCV.SUPP_CUST_ID                          AS  SUPP_CUST_ID

                             , 0                            AS BEFORE_AMOUNT
                             , 0                            AS BEFORE_CURR_AMOUNT
                             , NULL                         AS BEFORE_CURRENCY_CODE
                             , 0                            AS THIS_AMOUNT
                             , 0                            AS THIS_CURR_AMOUNT
                             , NULL                         AS THIS_CURRENCY_CODE
                             , FUL.GL_AMOUNT                AS PAY_AMOUNT
                             , FUL.GL_CURRENCY_AMOUNT       AS PAY_CURR_AMOUNT
                             , FUL.CURRENCY_CODE            AS PAY_CURRENCY_CODE
                             , 0                            AS REMAIN_AMOUNT
                             , 0                            AS REMAIN_CURR_AMOUNT
                             , NULL                         AS REMAIN_CURRENCY_CODE
                             , ''                AS MANAGEMENT1
                             , ''                AS MANAGEMENT2
                             , ''                AS REFER1
                             , ''                AS REFER2
                             , ''                AS REFER3
                             , ''                AS REFER4
                             , ''                AS REFER5

                          FROM
                             ( SELECT FUH.SOB_ID            AS SOB_ID
                                    , FUH.SLIP_LINE_ID      AS SLIP_LINE_ID
                                    , FUH.GL_NUM            AS GL_NUM
                                    , FUH.GL_DATE           AS GL_DATE
                                    , FUH.CUSTOMER_ID       AS CUSTOMER_ID
                                    , FUH.CURRENCY_CODE     AS CURRENCY_CODE
                                    , FUH.PERIOD_NAME       AS PERIOD_NAME

                                 FROM FI_UNLIQUIDATE_HEADER FUH
                                WHERE FUH.GL_DATE   BETWEEN W_FROM_DATE  AND  W_TO_DATE
                                  AND FUH.SOB_ID          = W_SOB_ID
                                  AND FUH.ACCOUNT_CODE      IN (SELECT FAC.ACCOUNT_CODE
                                                                  FROM FI_ACCOUNT_CONTROL    FAC
                                                                     , FI_COMMON             FC
                                                                 WHERE FAC.ACCOUNT_GL_ID  =  FC.COMMON_ID
                                                                   AND FC.ENABLED_FLAG    = 'Y'
                                                                   AND FAC.SOB_ID         =  W_SOB_ID
                                                                   AND FC.GROUP_CODE      = 'GL_TYPE'
                                                                   AND FC.CODE            =  NVL(W_GROUP_CODE, FC.CODE)
                                                                GROUP BY FAC.ACCOUNT_CODE
                                                               )
                             )                          FUHV
                             , FI_UNLIQUIDATE_LINE      FUL
                             , FI_SUPP_CUST_V           FSCV
                         WHERE FUL.SLIP_LINE_ID      =  FUHV.SLIP_LINE_ID
                           AND FUL.SOB_ID            =  FUHV.SOB_ID
                           AND FUL.GL_DATE     BETWEEN  W_FROM_DATE  AND  W_TO_DATE
                           AND FSCV.SUPP_CUST_ID     =  FUHV.CUSTOMER_ID
                           AND FSCV.SOB_ID           =  FUHV.SOB_ID

                      UNION ALL

                        -- 잘못반제된 DATA LIST
                        -- 찾아야 됨.....
                       SELECT '3'                                 AS  GUBUN
                             , TO_CHAR(FUL.GL_DATE,'YYYYMMDD')    AS  SORT_DATE
                             , '000000-000'                       AS  SORT_NUM
                             , TO_CHAR(FUL.GL_DATE,'YYYYMMDD')    AS  SORT_B_DATE
                             , '000000-000'                       AS  SORT_B_NUM

                             , FSL.SLIP_HEADER_ID            AS  SLIP_HEADER_ID
                             , FUL.GL_DATE                   AS  GL_DATE
                             , ' '                           AS  GL_NUM
                             , FUL.GL_DATE                   AS  FA_GL_DATE
                             , FUL.GL_NUM                    AS  FA_GL_NUM

                             , NVL(FSCV.TAX_REG_NO, FSCV.SUPP_CUST_CODE)  AS  TAX_REG_NO
                             , FSCV.SUPP_CUST_ID                          AS  SUPP_CUST_ID

                             , 0                             AS  BEFORE_AMOUNT
                             , 0.0000                        AS  BEFORE_CURR_AMOUNT
                             , ''                            AS  BEFORE_CURRENCY_CODE
                             , 0                             AS  THIS_AMOUNT
                             , 0.0000                        AS  THIS_CURR_AMOUNT
                             , ''                            AS  THIS_CURRENCY_CODE
                             , FUL.GL_AMOUNT                 AS  PAY_AMOUNT
                             , FUL.GL_CURRENCY_AMOUNT        AS  PAY_CURR_AMOUNT
                             , FUL.CURRENCY_CODE
                             , FUL.GL_AMOUNT * -1            AS  REMAIN_AMOUNT
                             , FUL.GL_CURRENCY_AMOUNT * -1   AS  REMAIN_CURR_AMOUNT
                             , FUL.CURRENCY_CODE             AS  REMAIN_CURRENCY_CODE

                             , FSL.MANAGEMENT1           AS MANAGEMENT1
                             , FSL.MANAGEMENT2           AS MANAGEMENT2
                             , FSL.REFER1                AS REFER1
                             , FSL.REFER2                AS REFER2
                             , FSL.REFER3                AS REFER3
                             , FSL.REFER4                AS REFER4
                             , FSL.REFER5                AS REFER5

                          FROM FI_UNLIQUIDATE_LINE           FUL
                             , FI_SLIP_LINE                  FSL
                             , FI_SUPP_CUST_V                FSCV
                         WHERE FSCV.SUPP_CUST_ID(+)      =   FUL.CUSTOMER_ID
                           AND FSL.SLIP_LINE_ID          =   FUL.LIQUIDATE_SLIP_LINE_ID
                           AND FSL.CONFIRM_YN            =  'Y'
                           AND FUL.SOB_ID                =   W_SOB_ID
                           AND (FUL.SLIP_LINE_ID)
                                NOT IN (SELECT FUH.SLIP_LINE_ID
                                          FROM FI_UNLIQUIDATE_HEADER FUH
                                         WHERE FUH.PERIOD_NAME    = NVL(W_PERIOD_NAME, FUH.PERIOD_NAME)
                                           AND FUH.SOB_ID         = W_SOB_ID
                                           AND FUH.ACCOUNT_CODE     IN (SELECT FAC.ACCOUNT_CODE
                                                                          FROM FI_ACCOUNT_CONTROL    FAC
                                                                             , FI_COMMON             FC
                                                                         WHERE FAC.ACCOUNT_GL_ID  =  FC.COMMON_ID
                                                                           AND FC.ENABLED_FLAG    = 'Y'
                                                                           AND FAC.SOB_ID         =  W_SOB_ID
                                                                           AND FC.SOB_ID          =  FAC.SOB_ID
                                                                           AND FC.GROUP_CODE      = 'GL_TYPE'
                                                                           AND FC.CODE            =  NVL(W_GROUP_CODE, FC.CODE)
                                                                         GROUP BY FAC.ACCOUNT_CODE
                                                                       )
                                        )
                           AND FSL.ACCOUNT_CODE IN (SELECT FAC.ACCOUNT_CODE
                                                      FROM FI_ACCOUNT_CONTROL    FAC
                                                         , FI_COMMON             FC
                                                     WHERE FAC.ACCOUNT_GL_ID  =  FC.COMMON_ID
                                                       AND FC.ENABLED_FLAG    = 'Y'
                                                       AND FAC.SOB_ID         =  W_SOB_ID
                                                       AND FC.GROUP_CODE      = 'GL_TYPE'
                                                       AND FC.CODE            =  NVL(W_GROUP_CODE, FC.CODE)
                                                    GROUP BY FAC.ACCOUNT_CODE
                                                   )
                           AND FUL.GL_DATE    BETWEEN  W_FROM_DATE  AND  W_TO_DATE

                      ) BALANCE
                  WHERE BALANCE.SUPP_CUST_ID    = NVL(W_SUPP_CUST_ID, BALANCE.SUPP_CUST_ID)
               ORDER BY BALANCE.GUBUN
                      , BALANCE.SORT_DATE
                      , BALANCE.SORT_NUM
                      , BALANCE.SORT_B_DATE
                      , BALANCE.SORT_B_NUM
                      , BALANCE.GL_DATE
                      , BALANCE.GL_NUM
--                    , BALANCE.FA_GL_DATE
--                    , BALANCE.FA_GL_NUM
                      ;

       END;

END FI_CUSTOMER_BALANCE_LIST_G; 
/
