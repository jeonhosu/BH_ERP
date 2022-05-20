CREATE OR REPLACE PACKAGE FI_AGGREGATE_G
AS

-- 계정 집계.
  PROCEDURE ACCOUNT_AGGREGATE_SET
            ( P_STD_DATE          IN DATE
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_MESSAGE           OUT VARCHAR2
            );

END FI_AGGREGATE_G;
/
CREATE OR REPLACE PACKAGE BODY FI_AGGREGATE_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_AGGREGATE_G
/* Description  : 계정집계.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 계정 집계.
  PROCEDURE ACCOUNT_AGGREGATE_SET
            ( P_STD_DATE          IN DATE
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_PERIOD_NAME                 FI_AGGREGATE.PERIOD_NAME%TYPE;
    V_ACCOUNT_BOOK_ID             FI_AGGREGATE.ACCOUNT_BOOK_ID%TYPE;
    V_CURRENCY_CODE               FI_AGGREGATE.CURRENCY_CODE%TYPE;

  BEGIN
    V_PERIOD_NAME := TO_CHAR(P_STD_DATE, 'YYYY-MM');
    V_ACCOUNT_BOOK_ID := FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(P_SOB_ID);
    V_CURRENCY_CODE   := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID);

    -- 해당월 데이터 삭제.
    BEGIN
      DELETE FROM FI_AGGREGATE FA
      WHERE FA.PERIOD_NAME      = V_PERIOD_NAME
        AND FA.SOB_ID           = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'DELETE ERROR : ' || SUBSTR(SQLERRM, 200);
      RETURN;
    END;

    -- 전월 합계 금액 INSERT.
    BEGIN
      INSERT INTO FI_AGGREGATE FA
      ( PERIOD_NAME
      , SOB_ID
      , ORG_ID
      , ACCOUNT_BOOK_ID
      , ACCOUNT_CONTROL_ID
      , ACCOUNT_CODE
      , CURRENCY_CODE
      , YEAR_DR_AMOUNT
      , YEAR_CR_AMOUNT
      , TOTAL_DR_AMOUNT
      , TOTAL_CR_AMOUNT
      , BASE_YEAR_DR_AMOUNT
      , BASE_YEAR_CR_AMOUNT
      , BASE_TOTAL_DR_AMOUNT
      , BASE_TOTAL_CR_AMOUNT
      , CREATION_DATE
      , CREATED_BY
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY
      )
      SELECT V_PERIOD_NAME
           , FA.SOB_ID
           , FA.ORG_ID
           , FA.ACCOUNT_BOOK_ID
           , FA.ACCOUNT_CONTROL_ID
           , FA.ACCOUNT_CODE
           , FA.CURRENCY_CODE
           , SUM( CASE
                    WHEN TO_CHAR(P_STD_DATE, 'MM') = '01' AND AC.ACCOUNT_FS_TYPE IN('1003', '1004') THEN 0
                    ELSE NVL(FA.PERIOD_DR_AMOUNT, 0) + NVL(FA.YEAR_DR_AMOUNT, 0)
                  END
                ) AS YEAR_DR_AMOUNT    
           , SUM( CASE
                    WHEN TO_CHAR(P_STD_DATE, 'MM') = '01' AND AC.ACCOUNT_FS_TYPE IN('1003', '1004') THEN 0
                    ELSE NVL(FA.PERIOD_CR_AMOUNT, 0) + NVL(FA.YEAR_CR_AMOUNT, 0)
                  END
                ) AS YEAR_CR_AMOUNT
           , SUM(NVL(FA.PERIOD_DR_AMOUNT, 0) + NVL(FA.TOTAL_DR_AMOUNT, 0)) AS TOTAL_DR_AMOUNT
           , SUM(NVL(FA.PERIOD_CR_AMOUNT, 0) + NVL(FA.TOTAL_CR_AMOUNT, 0)) AS TOTAL_CR_AMOUNT
           , SUM( CASE
                    WHEN TO_CHAR(P_STD_DATE, 'MM') = '01' AND AC.ACCOUNT_FS_TYPE IN('1003', '1004') THEN 0
                    ELSE NVL(FA.BASE_PERIOD_DR_AMOUNT, 0) + NVL(FA.BASE_YEAR_DR_AMOUNT, 0)
                  END
                ) AS BASE_YEAR_DR_AMOUNT
           , SUM( CASE
                    WHEN TO_CHAR(P_STD_DATE, 'MM') = '01' AND AC.ACCOUNT_FS_TYPE IN('1003', '1004') THEN 0
                    ELSE NVL(FA.BASE_PERIOD_CR_AMOUNT, 0) + NVL(FA.BASE_YEAR_CR_AMOUNT, 0)
                  END
                ) AS BASE_YEAR_CR_AMOUNT
           , SUM(NVL(FA.BASE_PERIOD_DR_AMOUNT, 0) + NVL(FA.BASE_TOTAL_DR_AMOUNT, 0)) AS BASE_TOTAL_DR_AMOUNT
           , SUM(NVL(FA.BASE_PERIOD_CR_AMOUNT, 0) + NVL(FA.BASE_TOTAL_CR_AMOUNT, 0)) AS BASE_TOTAL_CR_AMOUNT           
           , V_SYSDATE
           , P_USER_ID
           , V_SYSDATE
           , P_USER_ID
        FROM FI_AGGREGATE FA
          , FI_ACCOUNT_CONTROL AC
      WHERE FA.ACCOUNT_CONTROL_ID     = AC.ACCOUNT_CONTROL_ID
        AND FA.PERIOD_NAME            = TO_CHAR(ADD_MONTHS(P_STD_DATE, -1), 'YYYY-MM')
        AND FA.SOB_ID                 = P_SOB_ID
      GROUP BY FA.PERIOD_NAME
           , FA.SOB_ID
           , FA.ORG_ID
           , FA.ACCOUNT_BOOK_ID
           , FA.ACCOUNT_CONTROL_ID
           , FA.ACCOUNT_CODE
           , FA.CURRENCY_CODE
      ;
      /*SELECT V_PERIOD_NAME
           , FA.SOB_ID
           , FA.ORG_ID
           , FA.ACCOUNT_BOOK_ID
           , FA.ACCOUNT_CONTROL_ID
           , FA.ACCOUNT_CODE
           , FA.CURRENCY_CODE           
           , SUM( DECODE(TO_CHAR(P_STD_DATE, 'MM'), '01', NVL(FA.PERIOD_DR_AMOUNT, 0) + NVL(FA.YEAR_DR_AMOUNT, 0))) AS YEAR_DR_AMOUNT    -- 매년도 1월 초기화.
           , SUM(DECODE(TO_CHAR(P_STD_DATE, 'MM'), '01', 0, NVL(FA.PERIOD_CR_AMOUNT, 0) + NVL(FA.YEAR_CR_AMOUNT, 0))) AS YEAR_CR_AMOUNT
           , SUM(NVL(FA.PERIOD_DR_AMOUNT, 0) + NVL(FA.TOTAL_DR_AMOUNT, 0)) AS TOTAL_DR_AMOUNT
           , SUM(NVL(FA.PERIOD_CR_AMOUNT, 0) + NVL(FA.TOTAL_CR_AMOUNT, 0)) AS TOTAL_CR_AMOUNT
           , SUM(DECODE(TO_CHAR(P_STD_DATE, 'MM'), '01', 0, NVL(FA.BASE_PERIOD_DR_AMOUNT, 0) + NVL(FA.BASE_YEAR_DR_AMOUNT, 0))) AS BASE_YEAR_DR_AMOUNT
           , SUM(DECODE(TO_CHAR(P_STD_DATE, 'MM'), '01', 0, NVL(FA.BASE_PERIOD_CR_AMOUNT, 0) + NVL(FA.BASE_YEAR_CR_AMOUNT, 0))) AS BASE_YEAR_CR_AMOUNT
           , SUM(NVL(FA.BASE_PERIOD_DR_AMOUNT, 0) + NVL(FA.BASE_TOTAL_DR_AMOUNT, 0)) AS BASE_TOTAL_DR_AMOUNT
           , SUM(NVL(FA.BASE_PERIOD_CR_AMOUNT, 0) + NVL(FA.BASE_TOTAL_CR_AMOUNT, 0)) AS BASE_TOTAL_CR_AMOUNT*\
           , V_SYSDATE
           , P_USER_ID
           , V_SYSDATE
           , P_USER_ID
        FROM FI_AGGREGATE FA
          , FI_ACCOUNT_CONTROL AC
      WHERE FA.ACCOUNT_CONTROL_ID     = AC.ACCOUNT_CONTROL_ID
        AND FA.PERIOD_NAME            = TO_CHAR(ADD_MONTHS(P_STD_DATE, -1), 'YYYY-MM')
        AND FA.SOB_ID                 = P_SOB_ID
      GROUP BY FA.PERIOD_NAME
           , FA.SOB_ID
           , FA.ORG_ID
           , FA.ACCOUNT_BOOK_ID
           , FA.ACCOUNT_CONTROL_ID
           , FA.ACCOUNT_CODE
           , FA.CURRENCY_CODE
      ;*/
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE :=  'PREVIOUS INSERT ERROR : ' || SUBSTR(SQLERRM, 200);
      RETURN;
    END;

    -- 기본 통화 INSERT.
    FOR C1 IN ( SELECT  SL.ACCOUNT_CONTROL_ID
                      , SL.ACCOUNT_CODE
                      , SL.ACCOUNT_BOOK_ID
                      , V_CURRENCY_CODE AS CURRENCY_CODE
                      , SL.SOB_ID
                      , SUM(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)) AS DR_AMOUNT
                      , SUM(DECODE(SL.ACCOUNT_DR_CR, '1', 0, SL.GL_AMOUNT)) AS CR_AMOUNT
                  FROM  FI_SLIP_LINE SL
                      , FI_SLIP_HEADER SH
                WHERE SL.SLIP_HEADER_ID           = SH.SLIP_HEADER_ID
                  AND SL.GL_DATE                  BETWEEN TRUNC(P_STD_DATE, 'MONTH') AND P_STD_DATE
                  AND SL.ACCOUNT_BOOK_ID          = V_ACCOUNT_BOOK_ID
                  AND SL.SOB_ID                   = P_SOB_ID
                  AND SH.CONFIRM_YN               = 'Y'
                GROUP BY  SL.ACCOUNT_CONTROL_ID
                      , SL.ACCOUNT_CODE
                      , SL.ACCOUNT_BOOK_ID
                      , SL.SOB_ID
              )
    LOOP
      UPDATE FI_AGGREGATE FA
        SET FA.PERIOD_DR_AMOUNT   = NVL(FA.PERIOD_DR_AMOUNT, 0) + NVL(C1.DR_AMOUNT, 0)
          , FA.PERIOD_CR_AMOUNT   = NVL(FA.PERIOD_CR_AMOUNT, 0) + NVL(C1.CR_AMOUNT, 0)
      WHERE FA.PERIOD_NAME        = V_PERIOD_NAME
        AND FA.SOB_ID             = C1.SOB_ID
        AND FA.ACCOUNT_BOOK_ID    = C1.ACCOUNT_BOOK_ID
        AND FA.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
        AND FA.CURRENCY_CODE      = C1.CURRENCY_CODE
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO FI_AGGREGATE FA
        ( PERIOD_NAME
        , SOB_ID
        , ORG_ID
        , ACCOUNT_BOOK_ID
        , ACCOUNT_CONTROL_ID
        , ACCOUNT_CODE
        , CURRENCY_CODE
        , PERIOD_DR_AMOUNT
        , PERIOD_CR_AMOUNT
        , CREATION_DATE
        , CREATED_BY
        , LAST_UPDATE_DATE
        , LAST_UPDATED_BY
        ) VALUES
        ( V_PERIOD_NAME
        , C1.SOB_ID
        , P_ORG_ID
        , C1.ACCOUNT_BOOK_ID
        , C1.ACCOUNT_CONTROL_ID
        , C1.ACCOUNT_CODE
        , C1.CURRENCY_CODE
        , NVL(C1.DR_AMOUNT, 0)
        , NVL(C1.CR_AMOUNT, 0)
        , V_SYSDATE
        , P_USER_ID
        , V_SYSDATE
        , P_USER_ID
        );
      END IF;
    END LOOP C1;

    -- 외화 통화 INSERT.
    FOR C1 IN ( SELECT  SL.ACCOUNT_CONTROL_ID
                      , SL.ACCOUNT_CODE
                      , SL.ACCOUNT_BOOK_ID
                      , SL.CURRENCY_CODE AS CURRENCY_CODE
                      , SL.SOB_ID
                      , SUM(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_CURRENCY_AMOUNT, 0)) AS CURR_DR_AMOUNT
                      , SUM(DECODE(SL.ACCOUNT_DR_CR, '1', 0, SL.GL_CURRENCY_AMOUNT)) AS CURR_CR_AMOUNT
                      , SUM(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)) AS BASE_DR_AMOUNT
                      , SUM(DECODE(SL.ACCOUNT_DR_CR, '1', 0, SL.GL_AMOUNT)) AS BASE_CR_AMOUNT
                  FROM  FI_SLIP_LINE SL
                      , FI_SLIP_HEADER SH
                WHERE SL.SLIP_HEADER_ID           = SH.SLIP_HEADER_ID
                  AND SL.GL_DATE                  BETWEEN TRUNC(P_STD_DATE, 'MONTH') AND P_STD_DATE
                  AND SL.ACCOUNT_BOOK_ID          = V_ACCOUNT_BOOK_ID
                  AND SL.SOB_ID                   = P_SOB_ID
                  AND SL.CURRENCY_CODE            <> V_CURRENCY_CODE
                  AND SH.CONFIRM_YN               = 'Y'
                GROUP BY  SL.ACCOUNT_CONTROL_ID
                      , SL.ACCOUNT_CODE
                      , SL.ACCOUNT_BOOK_ID
                      , SL.CURRENCY_CODE
                      , SL.SOB_ID
              )
    LOOP
      UPDATE FI_AGGREGATE FA
        SET FA.PERIOD_DR_AMOUNT       = NVL(FA.PERIOD_DR_AMOUNT, 0) + NVL(C1.CURR_DR_AMOUNT, 0)
          , FA.PERIOD_CR_AMOUNT       = NVL(FA.PERIOD_CR_AMOUNT, 0) + NVL(C1.CURR_CR_AMOUNT, 0)
          , FA.BASE_PERIOD_DR_AMOUNT  = NVL(FA.BASE_PERIOD_DR_AMOUNT, 0) + NVL(C1.BASE_DR_AMOUNT, 0)
          , FA.BASE_PERIOD_CR_AMOUNT  = NVL(FA.BASE_PERIOD_CR_AMOUNT, 0) + NVL(C1.BASE_CR_AMOUNT, 0)
      WHERE FA.PERIOD_NAME        = V_PERIOD_NAME
        AND FA.SOB_ID             = C1.SOB_ID
        AND FA.ACCOUNT_BOOK_ID    = C1.ACCOUNT_BOOK_ID
        AND FA.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
        AND FA.CURRENCY_CODE      = C1.CURRENCY_CODE
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO FI_AGGREGATE FA
        ( PERIOD_NAME
        , SOB_ID
        , ORG_ID
        , ACCOUNT_BOOK_ID
        , ACCOUNT_CONTROL_ID
        , ACCOUNT_CODE
        , CURRENCY_CODE
        , PERIOD_DR_AMOUNT
        , PERIOD_CR_AMOUNT
        , BASE_PERIOD_DR_AMOUNT
        , BASE_PERIOD_CR_AMOUNT
        , CREATION_DATE
        , CREATED_BY
        , LAST_UPDATE_DATE
        , LAST_UPDATED_BY
        ) VALUES
        ( V_PERIOD_NAME
        , C1.SOB_ID
        , P_ORG_ID
        , C1.ACCOUNT_BOOK_ID
        , C1.ACCOUNT_CONTROL_ID
        , C1.ACCOUNT_CODE
        , C1.CURRENCY_CODE
        , NVL(C1.CURR_DR_AMOUNT, 0)
        , NVL(C1.CURR_CR_AMOUNT, 0)
        , NVL(C1.BASE_DR_AMOUNT, 0)
        , NVL(C1.BASE_CR_AMOUNT, 0)
        , V_SYSDATE
        , P_USER_ID
        , V_SYSDATE
        , P_USER_ID
        );
      END IF;
    END LOOP C1;
    COMMIT;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);  

  END ACCOUNT_AGGREGATE_SET;

END FI_AGGREGATE_G;
/
