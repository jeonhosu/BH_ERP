CREATE OR REPLACE PACKAGE FI_ACCOUNT_LEDGER_G
IS
--==============================================================================
-- PROJECT      : FLEX ERP
-- MODULE       : FCMF
-- PROGRAM NAME : FI_ACCOUNT_LEDGER_G
-- DESCRIPTION  : 총계정원장 조회.
--
-- REFERENCE BY :
-- PROGRAM HISTORY
--------------------------------------------------------------------------------
--   DATE       IN CHARGE          DESCRIPTION
--------------------------------------------------------------------------------
-- 26-NOV-2010  SUNG KIL TE        INITIALIZE
--==============================================================================
-- 계정별 원장 헤더(일자별 합계)
  PROCEDURE SELECT_LEDGER_SUM_HEADER
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_SOB_ID             IN  FI_DAILY_SUM.SOB_ID%TYPE
            , W_ORG_ID             IN  FI_DAILY_SUM.ORG_ID%TYPE
            , W_GL_DATE_FR         IN  FI_DAILY_SUM.GL_DATE%TYPE
            , W_GL_DATE_TO         IN  FI_DAILY_SUM.GL_DATE%TYPE
            , W_ACCOUNT_CODE_FR    IN  FI_DAILY_SUM.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO    IN  FI_DAILY_SUM.ACCOUNT_CODE%TYPE
            );

-- 계정별 원장 : 일자별 잔액.
  PROCEDURE SELECT_LEDGER_SUM_DAILY
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_SOB_ID             IN  FI_DAILY_SUM.SOB_ID%TYPE
            , W_ORG_ID             IN  FI_DAILY_SUM.ORG_ID%TYPE
            , W_GL_DATE_FR         IN  FI_DAILY_SUM.GL_DATE%TYPE
            , W_GL_DATE_TO         IN  FI_DAILY_SUM.GL_DATE%TYPE
            , W_ACCOUNT_CODE_FR    IN  FI_DAILY_SUM.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO    IN  FI_DAILY_SUM.ACCOUNT_CODE%TYPE
            );

-- 계정별원장 인쇄.
  PROCEDURE SELECT_LEDGER_PRINT
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_SOB_ID             IN  FI_DAILY_SUM.SOB_ID%TYPE
            , W_ORG_ID             IN  FI_DAILY_SUM.ORG_ID%TYPE
            , W_GL_DATE_FR         IN  FI_DAILY_SUM.GL_DATE%TYPE
            , W_GL_DATE_TO         IN  FI_DAILY_SUM.GL_DATE%TYPE
            , W_ACCOUNT_CODE_FR    IN  FI_DAILY_SUM.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO    IN  FI_DAILY_SUM.ACCOUNT_CODE%TYPE
            );



  PROCEDURE BANKING_ACCOUNT_HEADER_SELECT1
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_SOB_ID             IN  FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID             IN  FI_SLIP_LINE.ORG_ID%TYPE
            , W_PERIOD_FROM        IN  FI_SLIP_LINE.GL_DATE%TYPE
            , W_PERIOD_TO          IN  FI_SLIP_LINE.GL_DATE%TYPE
            , W_ACCOUNT_CODE_FROM  IN  FI_SLIP_LINE.ACCOUNT_CODE%TYPE
            );

  PROCEDURE SLIP_LINE_LIST_SELECT1
            ( P_CURSOR                     OUT TYPES.TCURSOR
            , W_SOB_ID                     IN  FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID                     IN  FI_SLIP_LINE.ORG_ID%TYPE
            , W_GL_DATE                    IN  FI_SLIP_LINE.GL_DATE%TYPE
            , W_ACCOUNT_CONTROL_ID         IN  FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE
            );

  PROCEDURE BANKING_ACCOUNT_SUM_SELECT2
            ( P_CURSOR                OUT TYPES.TCURSOR
            , W_SOB_ID                IN  FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID                IN  FI_SLIP_LINE.ORG_ID%TYPE
            , W_PERIOD_FROM           IN  FI_SLIP_LINE.GL_DATE%TYPE
            , W_PERIOD_TO             IN  FI_SLIP_LINE.GL_DATE%TYPE
            , W_ACCOUNT_CODE_FROM     IN  FI_SLIP_LINE.ACCOUNT_CODE%TYPE
            );

END FI_ACCOUNT_LEDGER_G; 

 
/
CREATE OR REPLACE PACKAGE BODY FI_ACCOUNT_LEDGER_G
IS
--==============================================================================
-- PROJECT      : FLEX ERP
-- MODULE       : FCMF
-- PROGRAM NAME : FI_ACCOUNT_LEDGER_G
-- DESCRIPTION  : 총계정원장 조회.
--
-- REFERENCE BY :
-- PROGRAM HISTORY
--------------------------------------------------------------------------------
--   DATE       IN CHARGE          DESCRIPTION
--------------------------------------------------------------------------------
-- 26-NOV-2010  SUNG KIL TE        INITIALIZE
--==============================================================================
-- 계정별 원장 헤더(일자별 합계)
  PROCEDURE SELECT_LEDGER_SUM_HEADER
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_SOB_ID             IN  FI_DAILY_SUM.SOB_ID%TYPE
            , W_ORG_ID             IN  FI_DAILY_SUM.ORG_ID%TYPE
            , W_GL_DATE_FR         IN  FI_DAILY_SUM.GL_DATE%TYPE
            , W_GL_DATE_TO         IN  FI_DAILY_SUM.GL_DATE%TYPE
            , W_ACCOUNT_CODE_FR    IN  FI_DAILY_SUM.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO    IN  FI_DAILY_SUM.ACCOUNT_CODE%TYPE
            )
  AS
  BEGIN
    BEGIN
      -- 이월자료 생성.
      DELETE FROM FI_BALANCE_OVER_GT
      ;

      -- 이월 잔액 산출.
      INSERT INTO FI_BALANCE_OVER_GT
      ( ACCOUNT_CODE
      , ACCOUNT_DESC
      , ACCOUNT_DR_CR
      , GL_DATE
      , REMARK
      , DR_GL_AMOUNT
      , CR_GL_AMOUNT
      , REMAIN_AMOUNT
      , ACCOUNT_CONTROL_ID
      )
      SELECT FAC.ACCOUNT_CODE
           , FAC.ACCOUNT_DESC
           , FAC.ACCOUNT_DR_CR
           , W_GL_DATE_FR - 1 AS GL_DATE
           , EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10165', NULL) AS REMARK
           , NVL(SUM(PX1.DR_AMOUNT), 0) AS DR_AMOUNT
           , NVL(SUM(PX1.CR_AMOUNT), 0) AS CR_AMOUNT
           , NVL(SUM(CASE
                       WHEN FAC.ACCOUNT_DR_CR = '1' THEN NVL(PX1.DR_AMOUNT, 0) - NVL(PX1.CR_AMOUNT, 0)
                       WHEN FAC.ACCOUNT_DR_CR = '2' THEN NVL(PX1.CR_AMOUNT, 0) - NVL(PX1.DR_AMOUNT, 0)
                       ELSE 0
                     END), 0) AS REMAIN_AMOUNT
           , FAC.ACCOUNT_CONTROL_ID
        FROM FI_ACCOUNT_CONTROL FAC
          , ( SELECT 0 AS ACCOUNT_CONTROL_ID
                 , '0' AS ACCOUNT_CODE
                 , '0' AS ACCOUNT_DR_CR
                 , 0 AS DR_AMOUNT
                 , 0 AS CR_AMOUNT
              FROM DUAL
              UNION ALL
              -- 기초금액.
              SELECT DS.ACCOUNT_CONTROL_ID
                   , DS.ACCOUNT_CODE
                   , AC.ACCOUNT_DR_CR      -- 잔액 구분.
                   , DS.DR_SUM AS DR_AMOUNT
                   , DS.CR_SUM AS CR_AMOUNT
                FROM FI_DAILY_SUM DS
                  , FI_ACCOUNT_CONTROL AC
               WHERE DS.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
                 AND DS.GL_DATE               = TRUNC(W_GL_DATE_FR, 'YEAR')
                 AND DS.GL_DATE_SEQ           = 0
                 AND DS.SOB_ID                = W_SOB_ID
                 AND DS.ACCOUNT_CODE          BETWEEN NVL(W_ACCOUNT_CODE_FR, DS.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, DS.ACCOUNT_CODE)
              UNION ALL
              -- 1일 ~ 시작(GL_DATE_FR-1) 전일까지의 잔액금액 계산.
              SELECT DS.ACCOUNT_CONTROL_ID
                   , DS.ACCOUNT_CODE
                   , AC.ACCOUNT_DR_CR
                   , DECODE(AC.ACCOUNT_DR_CR, '1', NVL(DS.DR_SUM, 0) - NVL(DS.CR_SUM, 0)) AS DR_AMOUNT
                   , DECODE(AC.ACCOUNT_DR_CR, '2', NVL(DS.CR_SUM, 0) - NVL(DS.DR_SUM, 0)) AS CR_AMOUNT
                FROM FI_DAILY_SUM DS
                  , FI_ACCOUNT_CONTROL AC
               WHERE DS.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
                 AND DS.SOB_ID                = W_SOB_ID
                 AND DS.GL_DATE_SEQ           = 1
                 AND DS.GL_DATE               BETWEEN TRUNC(W_GL_DATE_FR, 'YEAR') AND W_GL_DATE_FR - 1
                 AND DS.ACCOUNT_CODE          BETWEEN NVL(W_ACCOUNT_CODE_FR, DS.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, DS.ACCOUNT_CODE)
              ) PX1
      WHERE FAC.ACCOUNT_CONTROL_ID            = PX1.ACCOUNT_CONTROL_ID(+)
        AND FAC.ACCOUNT_CODE                  BETWEEN NVL(W_ACCOUNT_CODE_FR, FAC.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, FAC.ACCOUNT_CODE)
        AND FAC.SOB_ID                        = W_SOB_ID
      GROUP BY FAC.ACCOUNT_CONTROL_ID
           , FAC.ACCOUNT_CODE
           , FAC.ACCOUNT_DESC
           , FAC.ACCOUNT_DR_CR
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    
    OPEN P_CURSOR FOR
      SELECT CASE
               WHEN GROUPING(FX1.ACCOUNT_CODE) = 1 THEN NULL
               WHEN GROUPING(FX1.GL_DATE) = 1 THEN NULL
               WHEN W_GL_DATE_FR - 1 = FX1.GL_DATE THEN NULL
               ELSE FX1.ACCOUNT_CODE
             END AS ACCOUNT_CODE
          , CASE
               WHEN GROUPING(FX1.ACCOUNT_CODE) = 1 THEN NULL
               WHEN GROUPING(FX1.GL_DATE) = 1 THEN NULL
               WHEN W_GL_DATE_FR - 1 = FX1.GL_DATE THEN NULL
               ELSE FX1.ACCOUNT_DESC
             END AS ACCOUNT_DESC
          , CASE
               WHEN GROUPING(FX1.ACCOUNT_CODE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10051', NULL)
               WHEN GROUPING(FX1.GL_DATE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10188', NULL)
               WHEN W_GL_DATE_FR - 1 = FX1.GL_DATE THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10165', NULL)
               ELSE NULL
             END AS REMARK
          , DECODE(W_GL_DATE_FR - 1, FX1.GL_DATE, TO_DATE(NULL), FX1.GL_DATE) AS GL_DATE
          , SUM(FX1.DR_AMOUNT) AS DR_AMOUNT
          , SUM(FX1.CR_AMOUNT) AS CR_AMOUNT
          , CASE
               WHEN GROUPING(FX1.ACCOUNT_CODE) = 1 THEN SUM(DECODE(FX1.ACCOUNT_DR_CR, '1', NVL(FX1.DR_AMOUNT, 0) - NVL(FX1.CR_AMOUNT, 0), NVL(FX1.CR_AMOUNT, 0) - NVL(FX1.DR_AMOUNT, 0)))
               WHEN GROUPING(FX1.GL_DATE) = 1 THEN 0
               ELSE SUM(FX1.REMAIN_AMOUNT)
             END AS REMAIN_AMOUNT
          , FX1.ACCOUNT_CONTROL_ID
        FROM (SELECT TX1.ACCOUNT_CODE
                  , TX1.ACCOUNT_DESC
                  , TX1.GL_DATE
                  , TX1.ACCOUNT_DR_CR
                  , TX1.DR_AMOUNT AS DR_AMOUNT
                  , TX1.CR_AMOUNT AS CR_AMOUNT
                  , SUM(TX1.REMAIN_AMOUNT) OVER (PARTITION BY TX1.ACCOUNT_CODE ORDER BY TX1.ACCOUNT_CODE, TX1.GL_DATE) AS REMAIN_AMOUNT
                  , TX1.ACCOUNT_CONTROL_ID
                FROM (SELECT BOG.ACCOUNT_CODE
                          , BOG.ACCOUNT_DESC
                          , BOG.GL_DATE
                          , BOG.ACCOUNT_DR_CR
                          , BOG.DR_GL_AMOUNT AS DR_AMOUNT
                          , BOG.CR_GL_AMOUNT AS CR_AMOUNT
                          , BOG.REMAIN_AMOUNT
                          , BOG.ACCOUNT_CONTROL_ID
                      FROM FI_BALANCE_OVER_GT BOG
                      WHERE BOG.ACCOUNT_CODE           BETWEEN NVL(W_ACCOUNT_CODE_FR, BOG.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, BOG.ACCOUNT_CODE)
                        AND BOG.GL_DATE                = W_GL_DATE_FR - 1
                      UNION ALL 
                      SELECT DS.ACCOUNT_CODE  AS ACCOUNT_CODE     -- 계정코드(ACCOUNT CODE)
                           , FAC.ACCOUNT_DESC AS  ACCOUNT_DESC    -- 계정명(ACCOUNT NAME)
                           , DS.GL_DATE AS  GL_DATE         -- 회계일자(ACCOUNT DATE)
                           , FAC.ACCOUNT_DR_CR
                           , DS.DR_SUM  AS  DR_AMOUNT       -- 차변금액(DEBIT AMOUNT)
                           , DS.CR_SUM  AS  CR_AMOUNT       -- 대변금액(CREDIT AMOUNT)
                           , DECODE(FAC.ACCOUNT_DR_CR, '1', NVL(DS.DR_SUM, 0) - NVL(DS.CR_SUM, 0), NVL(DS.CR_SUM, 0)- NVL(DS.DR_SUM, 0))  AS  REMAIN_AMOUNT   -- 잔액금액(REMAIN AMOUNT)
                           , DS.ACCOUNT_CONTROL_ID AS  ACCOUNT_CONTROL_ID
                        FROM FI_DAILY_SUM DS
                          , FI_ACCOUNT_CONTROL FAC
                       WHERE DS.ACCOUNT_CONTROL_ID      = FAC.ACCOUNT_CONTROL_ID
                         AND DS.SOB_ID                  = FAC.SOB_ID
                         AND DS.SOB_ID                  = W_SOB_ID
                         AND DS.GL_DATE_SEQ             = 1
                         AND DS.ACCOUNT_CODE            BETWEEN NVL(W_ACCOUNT_CODE_FR, DS.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, DS.ACCOUNT_CODE)
                         AND DS.GL_DATE                 BETWEEN W_GL_DATE_FR AND W_GL_DATE_TO
                      ) TX1
              ) FX1
      GROUP BY ROLLUP((FX1.ACCOUNT_CODE
                , FX1.ACCOUNT_DESC
                , FX1.ACCOUNT_CONTROL_ID)
                , (FX1.GL_DATE))
      ;
  END SELECT_LEDGER_SUM_HEADER;

-- 계정별 원장 : 일자별 잔액.
  PROCEDURE SELECT_LEDGER_SUM_DAILY
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_SOB_ID             IN  FI_DAILY_SUM.SOB_ID%TYPE
            , W_ORG_ID             IN  FI_DAILY_SUM.ORG_ID%TYPE
            , W_GL_DATE_FR         IN  FI_DAILY_SUM.GL_DATE%TYPE
            , W_GL_DATE_TO         IN  FI_DAILY_SUM.GL_DATE%TYPE
            , W_ACCOUNT_CODE_FR    IN  FI_DAILY_SUM.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO    IN  FI_DAILY_SUM.ACCOUNT_CODE%TYPE
            )
  AS
  BEGIN
    BEGIN
      -- 이월자료 생성.
      DELETE FROM FI_BALANCE_OVER_GT
      ;

      -- 이월 잔액 산출.
      INSERT INTO FI_BALANCE_OVER_GT
      ( ACCOUNT_CODE
      , ACCOUNT_DESC
      , ACCOUNT_DR_CR
      , GL_DATE
      , REMARK
      , DR_GL_AMOUNT
      , CR_GL_AMOUNT
      , REMAIN_AMOUNT
      , ACCOUNT_CONTROL_ID
      )
      SELECT FAC.ACCOUNT_CODE
           , FAC.ACCOUNT_DESC
           , FAC.ACCOUNT_DR_CR
           , W_GL_DATE_FR - 1 AS GL_DATE
           , EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10165', NULL) AS REMARK
           , NVL(SUM(PX1.DR_AMOUNT), 0) AS DR_AMOUNT
           , NVL(SUM(PX1.CR_AMOUNT), 0) AS CR_AMOUNT
           , NVL(SUM(CASE
                       WHEN FAC.ACCOUNT_DR_CR = '1' THEN NVL(PX1.DR_AMOUNT, 0) - NVL(PX1.CR_AMOUNT, 0)
                       WHEN FAC.ACCOUNT_DR_CR = '2' THEN NVL(PX1.CR_AMOUNT, 0) - NVL(PX1.DR_AMOUNT, 0)
                       ELSE 0
                     END), 0) AS REMAIN_AMOUNT
           , FAC.ACCOUNT_CONTROL_ID
        FROM FI_ACCOUNT_CONTROL FAC
          , ( SELECT 0 AS ACCOUNT_CONTROL_ID
                 , '0' AS ACCOUNT_CODE
                 , '0' AS ACCOUNT_DR_CR
                 , 0 AS DR_AMOUNT
                 , 0 AS CR_AMOUNT
              FROM DUAL
              UNION ALL
              -- 기초금액.
              SELECT DS.ACCOUNT_CONTROL_ID
                   , DS.ACCOUNT_CODE
                   , AC.ACCOUNT_DR_CR      -- 잔액 구분.
                   , DS.DR_SUM AS DR_AMOUNT
                   , DS.CR_SUM AS CR_AMOUNT
                FROM FI_DAILY_SUM DS
                  , FI_ACCOUNT_CONTROL AC
               WHERE DS.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
                 AND DS.GL_DATE               = TRUNC(W_GL_DATE_FR, 'YEAR')
                 AND DS.GL_DATE_SEQ           = 0
                 AND DS.SOB_ID                = W_SOB_ID
                 AND DS.ACCOUNT_CODE          BETWEEN NVL(W_ACCOUNT_CODE_FR, DS.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, DS.ACCOUNT_CODE)
              UNION ALL
              -- 1일 ~ 시작(GL_DATE_FR-1) 전일까지의 잔액금액 계산.
              SELECT DS.ACCOUNT_CONTROL_ID
                   , DS.ACCOUNT_CODE
                   , AC.ACCOUNT_DR_CR
                   , DECODE(AC.ACCOUNT_DR_CR, '1', NVL(DS.DR_SUM, 0) - NVL(DS.CR_SUM, 0)) AS DR_AMOUNT
                   , DECODE(AC.ACCOUNT_DR_CR, '2', NVL(DS.CR_SUM, 0) - NVL(DS.DR_SUM, 0)) AS CR_AMOUNT
                FROM FI_DAILY_SUM DS
                  , FI_ACCOUNT_CONTROL AC
               WHERE DS.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
                 AND DS.SOB_ID                = W_SOB_ID
                 AND DS.GL_DATE_SEQ           = 1
                 AND DS.GL_DATE               BETWEEN TRUNC(W_GL_DATE_FR, 'YEAR') AND W_GL_DATE_FR - 1
                 AND DS.ACCOUNT_CODE          BETWEEN NVL(W_ACCOUNT_CODE_FR, DS.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, DS.ACCOUNT_CODE)
              ) PX1
      WHERE FAC.ACCOUNT_CONTROL_ID            = PX1.ACCOUNT_CONTROL_ID(+)
        AND FAC.ACCOUNT_CODE                  BETWEEN NVL(W_ACCOUNT_CODE_FR, FAC.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, FAC.ACCOUNT_CODE)
        AND FAC.SOB_ID                        = W_SOB_ID
      GROUP BY FAC.ACCOUNT_CONTROL_ID
           , FAC.ACCOUNT_CODE
           , FAC.ACCOUNT_DESC
           , FAC.ACCOUNT_DR_CR
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    
    OPEN P_CURSOR FOR
      SELECT CASE
               WHEN GROUPING(FX1.ACCOUNT_CODE) = 1 THEN NULL
               WHEN GROUPING(FX1.GL_DATE) = 1 THEN NULL
               WHEN W_GL_DATE_FR - 1 = FX1.GL_DATE THEN NULL
               ELSE FX1.ACCOUNT_CODE
             END AS ACCOUNT_CODE
          , CASE
               WHEN GROUPING(FX1.ACCOUNT_CODE) = 1 THEN NULL
               WHEN GROUPING(FX1.GL_DATE) = 1 THEN NULL
               WHEN W_GL_DATE_FR - 1 = FX1.GL_DATE THEN NULL
               ELSE FX1.ACCOUNT_DESC
             END AS ACCOUNT_DESC
          , CASE
               WHEN GROUPING(FX1.ACCOUNT_CODE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10051', NULL)
               WHEN GROUPING(FX1.GL_DATE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10188', NULL)
               WHEN W_GL_DATE_FR - 1 = FX1.GL_DATE THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10165', NULL)
               ELSE NULL
             END AS REMARK
          , DECODE(W_GL_DATE_FR - 1, FX1.GL_DATE, TO_DATE(NULL), FX1.GL_DATE) AS GL_DATE
          , SUM(FX1.DR_AMOUNT) AS DR_AMOUNT
          , SUM(FX1.CR_AMOUNT) AS CR_AMOUNT
          , CASE
               WHEN GROUPING(FX1.ACCOUNT_CODE) = 1 THEN SUM(DECODE(FX1.ACCOUNT_DR_CR, '1', NVL(FX1.DR_AMOUNT, 0) - NVL(FX1.CR_AMOUNT, 0), NVL(FX1.CR_AMOUNT, 0) - NVL(FX1.DR_AMOUNT, 0)))
               WHEN GROUPING(FX1.GL_DATE) = 1 THEN 0
               ELSE SUM(FX1.REMAIN_AMOUNT)
             END AS REMAIN_AMOUNT
          , FX1.ACCOUNT_CONTROL_ID
        FROM (SELECT TX1.ACCOUNT_CODE
                  , TX1.ACCOUNT_DESC
                  , TX1.GL_DATE
                  , TX1.ACCOUNT_DR_CR
                  , TX1.DR_AMOUNT AS DR_AMOUNT
                  , TX1.CR_AMOUNT AS CR_AMOUNT
                  , SUM(TX1.REMAIN_AMOUNT) OVER (PARTITION BY TX1.ACCOUNT_CODE ORDER BY TX1.ACCOUNT_CODE, TX1.GL_DATE) AS REMAIN_AMOUNT
                  , TX1.ACCOUNT_CONTROL_ID
                FROM (SELECT BOG.ACCOUNT_CODE
                          , BOG.ACCOUNT_DESC
                          , BOG.GL_DATE
                          , BOG.ACCOUNT_DR_CR
                          , BOG.DR_GL_AMOUNT AS DR_AMOUNT
                          , BOG.CR_GL_AMOUNT AS CR_AMOUNT
                          , BOG.REMAIN_AMOUNT
                          , BOG.ACCOUNT_CONTROL_ID
                      FROM FI_BALANCE_OVER_GT BOG
                      WHERE BOG.ACCOUNT_CODE           BETWEEN NVL(W_ACCOUNT_CODE_FR, BOG.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, BOG.ACCOUNT_CODE)
                        AND BOG.GL_DATE                = W_GL_DATE_FR - 1
                      UNION ALL 
                      SELECT DS.ACCOUNT_CODE  AS ACCOUNT_CODE     -- 계정코드(ACCOUNT CODE)
                           , FAC.ACCOUNT_DESC AS  ACCOUNT_DESC    -- 계정명(ACCOUNT NAME)
                           , DS.GL_DATE AS  GL_DATE         -- 회계일자(ACCOUNT DATE)
                           , FAC.ACCOUNT_DR_CR
                           , DS.DR_SUM  AS  DR_AMOUNT       -- 차변금액(DEBIT AMOUNT)
                           , DS.CR_SUM  AS  CR_AMOUNT       -- 대변금액(CREDIT AMOUNT)
                           , DECODE(FAC.ACCOUNT_DR_CR, '1', NVL(DS.DR_SUM, 0) - NVL(DS.CR_SUM, 0), NVL(DS.CR_SUM, 0)- NVL(DS.DR_SUM, 0))  AS  REMAIN_AMOUNT   -- 잔액금액(REMAIN AMOUNT)
                           , DS.ACCOUNT_CONTROL_ID AS  ACCOUNT_CONTROL_ID
                        FROM FI_DAILY_SUM DS
                          , FI_ACCOUNT_CONTROL FAC
                       WHERE DS.ACCOUNT_CONTROL_ID      = FAC.ACCOUNT_CONTROL_ID
                         AND DS.SOB_ID                  = FAC.SOB_ID
                         AND DS.SOB_ID                  = W_SOB_ID
                         AND DS.GL_DATE_SEQ             = 1
                         AND DS.ACCOUNT_CODE            BETWEEN NVL(W_ACCOUNT_CODE_FR, DS.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, DS.ACCOUNT_CODE)
                         AND DS.GL_DATE                 BETWEEN W_GL_DATE_FR AND W_GL_DATE_TO
                      ) TX1
              ) FX1
      GROUP BY ROLLUP((FX1.ACCOUNT_CODE
                , FX1.ACCOUNT_DESC
                , FX1.ACCOUNT_CONTROL_ID)
                , (FX1.GL_DATE))
      ;
  END SELECT_LEDGER_SUM_DAILY;

-- 계정별원장 인쇄.
  PROCEDURE SELECT_LEDGER_PRINT
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_SOB_ID             IN  FI_DAILY_SUM.SOB_ID%TYPE
            , W_ORG_ID             IN  FI_DAILY_SUM.ORG_ID%TYPE
            , W_GL_DATE_FR         IN  FI_DAILY_SUM.GL_DATE%TYPE
            , W_GL_DATE_TO         IN  FI_DAILY_SUM.GL_DATE%TYPE
            , W_ACCOUNT_CODE_FR    IN  FI_DAILY_SUM.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO    IN  FI_DAILY_SUM.ACCOUNT_CODE%TYPE
            )
  AS
  BEGIN
    BEGIN
      -- 이월자료 생성.
      DELETE FROM FI_BALANCE_OVER_GT
      ;

      -- 이월 잔액 산출.
      INSERT INTO FI_BALANCE_OVER_GT
      ( ACCOUNT_CODE
      , ACCOUNT_DESC
      , ACCOUNT_DR_CR
      , GL_DATE
      , REMARK
      , DR_GL_AMOUNT
      , CR_GL_AMOUNT
      , REMAIN_AMOUNT
      , ACCOUNT_CONTROL_ID
      )
      SELECT FAC.ACCOUNT_CODE
           , FAC.ACCOUNT_DESC
           , FAC.ACCOUNT_DR_CR
           , W_GL_DATE_FR - 1 AS GL_DATE
           , EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10165', NULL) AS REMARK
           , NVL(SUM(PX1.DR_AMOUNT), 0) AS DR_AMOUNT
           , NVL(SUM(PX1.CR_AMOUNT), 0) AS CR_AMOUNT
           , NVL(SUM(CASE
                       WHEN FAC.ACCOUNT_DR_CR = '1' THEN NVL(PX1.DR_AMOUNT, 0) - NVL(PX1.CR_AMOUNT, 0)
                       WHEN FAC.ACCOUNT_DR_CR = '2' THEN NVL(PX1.CR_AMOUNT, 0) - NVL(PX1.DR_AMOUNT, 0)
                       ELSE 0
                     END), 0) AS REMAIN_AMOUNT
           , FAC.ACCOUNT_CONTROL_ID
        FROM FI_ACCOUNT_CONTROL FAC
          , ( SELECT 0 AS ACCOUNT_CONTROL_ID
                 , '0' AS ACCOUNT_CODE
                 , '0' AS ACCOUNT_DR_CR
                 , 0 AS DR_AMOUNT
                 , 0 AS CR_AMOUNT
              FROM DUAL
              UNION ALL
              -- 기초금액.
              SELECT DS.ACCOUNT_CONTROL_ID
                   , DS.ACCOUNT_CODE
                   , AC.ACCOUNT_DR_CR      -- 잔액 구분.
                   , DS.DR_SUM AS DR_AMOUNT
                   , DS.CR_SUM AS CR_AMOUNT
                FROM FI_DAILY_SUM DS
                  , FI_ACCOUNT_CONTROL AC
               WHERE DS.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
                 AND DS.GL_DATE               = TRUNC(W_GL_DATE_FR, 'YEAR')
                 AND DS.GL_DATE_SEQ           = 0
                 AND DS.SOB_ID                = W_SOB_ID
                 AND DS.ACCOUNT_CODE          BETWEEN NVL(W_ACCOUNT_CODE_FR, DS.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, DS.ACCOUNT_CODE)
              UNION ALL
              -- 1일 ~ 시작(GL_DATE_FR-1) 전일까지의 잔액금액 계산.
              SELECT DS.ACCOUNT_CONTROL_ID
                   , DS.ACCOUNT_CODE
                   , AC.ACCOUNT_DR_CR
                   , DECODE(AC.ACCOUNT_DR_CR, '1', NVL(DS.DR_SUM, 0) - NVL(DS.CR_SUM, 0)) AS DR_AMOUNT
                   , DECODE(AC.ACCOUNT_DR_CR, '2', NVL(DS.CR_SUM, 0) - NVL(DS.DR_SUM, 0)) AS CR_AMOUNT
                FROM FI_DAILY_SUM DS
                  , FI_ACCOUNT_CONTROL AC
               WHERE DS.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
                 AND DS.SOB_ID                = W_SOB_ID
                 AND DS.GL_DATE_SEQ           = 1
                 AND DS.GL_DATE               BETWEEN TRUNC(W_GL_DATE_FR, 'YEAR') AND W_GL_DATE_FR - 1
                 AND DS.ACCOUNT_CODE          BETWEEN NVL(W_ACCOUNT_CODE_FR, DS.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, DS.ACCOUNT_CODE)
              ) PX1
      WHERE FAC.ACCOUNT_CONTROL_ID            = PX1.ACCOUNT_CONTROL_ID(+)
        AND FAC.ACCOUNT_CODE                  BETWEEN NVL(W_ACCOUNT_CODE_FR, FAC.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, FAC.ACCOUNT_CODE)
        AND FAC.SOB_ID                        = W_SOB_ID
      GROUP BY FAC.ACCOUNT_CONTROL_ID
           , FAC.ACCOUNT_CODE
           , FAC.ACCOUNT_DESC
           , FAC.ACCOUNT_DR_CR
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    
    OPEN P_CURSOR FOR
      SELECT SX1.ACCOUNT_CODE
          , SX1.ACCOUNT_DESC
          , SX1.GL_DATE
          , SX1.MANAGEMENT_DESC AS MANAGEMENT_DESC
          , SX1.REMARK
          , SX1.GL_NUM
          , SX1.DR_AMOUNT AS DR_AMOUNT
          , SX1.CR_AMOUNT AS CR_AMOUNT
          , CASE
              WHEN ROW_NUMBER() OVER (PARTITION BY SX1.ACCOUNT_CODE ORDER BY SX1.ACCOUNT_CODE, SX1.GL_DATE)
                   < COUNT(*) OVER (PARTITION BY SX1.ACCOUNT_CODE ORDER BY SX1.ACCOUNT_CODE, SX1.GL_DATE) THEN 0
              ELSE SUM(SX1.REMAIN_AMOUNT) OVER (PARTITION BY SX1.ACCOUNT_CODE ORDER BY SX1.ACCOUNT_CODE, SX1.GL_DATE)
            END AS REMAIN_AMOUNT
        FROM ( SELECT BOG.ACCOUNT_CODE
                    , BOG.ACCOUNT_DESC
                    , BOG.GL_DATE
                    , BOG.REMARK AS MANAGEMENT_DESC
                    , NULL AS REMARK
                    , NULL AS GL_NUM
                    , BOG.DR_GL_AMOUNT AS DR_AMOUNT
                    , BOG.CR_GL_AMOUNT AS CR_AMOUNT
                    , BOG.REMAIN_AMOUNT
                    , BOG.ACCOUNT_CONTROL_ID
                FROM FI_BALANCE_OVER_GT BOG
                WHERE BOG.ACCOUNT_CODE           BETWEEN NVL(W_ACCOUNT_CODE_FR, BOG.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, BOG.ACCOUNT_CODE)
                  AND BOG.GL_DATE                = W_GL_DATE_FR - 1
                -------------------------------------------------------------------------------
                UNION ALL
                -------------------------------------------------------------------------------
                SELECT FAC.ACCOUNT_CODE
                     , FAC.ACCOUNT_DESC                                       AS  ACCOUNT_DESC    -- 계정명(ACCOUNT NAME)
                     , SL.GL_DATE                                             AS  GL_DATE         -- 회계일자(ACCOUNT DATE)
                     , NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                    , 'REFER1_ID'
                                                                    , SL.MANAGEMENT1
                                                                    , SL.SOB_ID), SL.MANAGEMENT1)
                      || DECODE(SL.MANAGEMENT2, NULL, '', ' ')
                      || NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                      , 'REFER2_ID'
                                                                      , SL.MANAGEMENT2
                                                                      , SL.SOB_ID), SL.MANAGEMENT2)
                      || DECODE(SL.REFER1, NULL, '', ' ')
                      || NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                      , 'REFER3_ID'
                                                                      , SL.REFER1
                                                                      , SL.SOB_ID), SL.REFER1)
                      || DECODE(SL.REFER2, NULL, '', ' ')
                      || NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                      , 'REFER4_ID'
                                                                      , SL.REFER2
                                                                      , SL.SOB_ID), SL.REFER2)
                      || DECODE(SL.REFER3, NULL, '', ' ')
                      || NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                      , 'REFER5_ID'
                                                                      , SL.REFER3
                                                                      , SL.SOB_ID), SL.REFER3)
                      || DECODE(SL.REFER4, NULL, '', ' ')
                      || NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                      , 'REFER6_ID'
                                                                      , SL.REFER4
                                                                      , SL.SOB_ID), SL.REFER4)
                      || DECODE(SL.REFER5, NULL, '', ' ')
                      || NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                      , 'REFER7_ID'
                                                                      , SL.REFER5
                                                                      , SL.SOB_ID), SL.REFER5)
                      || DECODE(SL.REFER6, NULL, '', ' ')
                      || NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                      , 'REFER8_ID'
                                                                      , SL.REFER6
                                                                      , SL.SOB_ID), SL.REFER6)
                      || DECODE(SL.REFER7, NULL, '', ' ')
                      || NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                      , 'REFER9_ID'
                                                                      , SL.REFER7
                                                                      , SL.SOB_ID), SL.REFER7)
                      || DECODE(SL.REFER8, NULL, '', ' ')
                      || NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                      , 'REFER10_ID'
                                                                      , SL.REFER8
                                                                      , SL.SOB_ID), SL.REFER8)
                      
                      || DECODE(SL.REFER9, NULL, '', ' ')
                      || NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                      , 'REFER11_ID'
                                                                      , SL.REFER9
                                                                      , SL.SOB_ID), SL.REFER9)
                      || DECODE(SL.REFER10, NULL, '', ' ')
                      || NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                      , 'REFER12_ID'
                                                                      , SL.REFER10
                                                                      , SL.SOB_ID), SL.REFER10)
                      || DECODE(SL.REFER11, NULL, '', ' ')
                      || NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                      , 'REFER13_ID'
                                                                      , SL.REFER11
                                                                      , SL.SOB_ID), SL.REFER11)
                      || DECODE(SL.REFER12, NULL, '', ' ')
                      || NVL(FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                                      , 'REFER14_ID'
                                                                      , SL.REFER12
                                                                      , SL.SOB_ID), SL.REFER12)
                      || DECODE(SL.CURRENCY_CODE, FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(SL.SOB_ID), NULL, ' '
                      || SL.CURRENCY_CODE || TO_CHAR(SL.GL_CURRENCY_AMOUNT, 'FM999,999,999,999,999.9999') || '(' || TO_CHAR(SL.EXCHANGE_RATE, 'FM999,999,999.9999') || ')')
                       AS MANAGEMENT_DESC
                     , SL.REMARK AS REMARK
                     , SL.GL_NUM
                     , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)       AS  DR_AMOUNT       -- 차변금액(DEBIT AMOUNT)
                     , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)       AS  CR_AMOUNT       -- 대변금액(CREDIT AMOUNT)
                     , NVL(CASE
                             WHEN FAC.ACCOUNT_DR_CR = '1' THEN NVL(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0), 0) - NVL(DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0), 0)
                             WHEN FAC.ACCOUNT_DR_CR = '2' THEN NVL(DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0), 0) - NVL(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0), 0)
                             ELSE 0
                           END, 0) AS REMAIN_AMOUNT       -- 잔액금액(REMAIN AMOUNT)
                     , FAC.ACCOUNT_CONTROL_ID
                  FROM FI_SLIP_LINE                  SL
                     , FI_ACCOUNT_CONTROL            FAC
                WHERE FAC.ACCOUNT_CONTROL_ID     =  SL.ACCOUNT_CONTROL_ID
                  AND FAC.SOB_ID                 =  SL.SOB_ID
                  AND SL.SOB_ID                  = W_SOB_ID
                  AND SL.CONFIRM_YN              = 'Y'
                  AND SL.ACCOUNT_BOOK_ID         = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(W_SOB_ID)
                  AND FAC.ACCOUNT_CODE           BETWEEN NVL(W_ACCOUNT_CODE_FR, FAC.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, FAC.ACCOUNT_CODE)
                  AND SL.GL_DATE                 BETWEEN W_GL_DATE_FR AND W_GL_DATE_TO
               ) SX1
      ORDER BY SX1.ACCOUNT_CODE, GL_DATE
      ;
  
  END SELECT_LEDGER_PRINT;
  



  PROCEDURE BANKING_ACCOUNT_HEADER_SELECT1( P_CURSOR             OUT TYPES.TCURSOR
                                         , W_SOB_ID             IN  FI_SLIP_LINE.SOB_ID%TYPE
                                         , W_ORG_ID             IN  FI_SLIP_LINE.ORG_ID%TYPE
                                         , W_PERIOD_FROM        IN  FI_SLIP_LINE.GL_DATE%TYPE
                                         , W_PERIOD_TO          IN  FI_SLIP_LINE.GL_DATE%TYPE
                                         , W_ACCOUNT_CODE_FROM  IN  FI_SLIP_LINE.ACCOUNT_CODE%TYPE
                                         )

  IS

  BEGIN

          OPEN P_CURSOR FOR
          SELECT SLI.ACCOUNT_CODE                                       AS ACCOUNT_CODE     -- 계정코드(ACCOUNT CODE)
               , FAC.ACCOUNT_DESC                                       AS  ACCOUNT_DESC    -- 계정명(ACCOUNT NAME)
               , SLI.GL_DATE                                            AS  GL_DATE         -- 회계일자(ACCOUNT DATE)
               , SUM(DECODE(SLI.ACCOUNT_DR_CR, '1', SLI.GL_AMOUNT, 0))  AS  DR_AMOUNT       -- 차변금액(DEBIT AMOUNT)
               , SUM(DECODE(SLI.ACCOUNT_DR_CR, '2', SLI.GL_AMOUNT, 0))  AS  CR_AMOUNT       -- 대변금액(CREDIT AMOUNT)

               , SUM((DECODE(SLI.ACCOUNT_DR_CR, '1', SLI.GL_AMOUNT, 0)
                   * DECODE(FAC.ACCOUNT_DR_CR, '1', 1,         (-1)))
                   - (DECODE(SLI.ACCOUNT_DR_CR, '2', SLI.GL_AMOUNT, 0)
                   * DECODE(FAC.ACCOUNT_DR_CR, '1', 1,         (-1))))   AS  REMAIN_AMOUNT   -- 잔액금액(REMAIN AMOUNT)
               , SLI.ACCOUNT_CONTROL_ID                                 AS  ACCOUNT_CONTROL_ID
            FROM FI_SLIP_LINE                  SLI
               , FI_ACCOUNT_CONTROL            FAC
           WHERE FAC.ACCOUNT_CONTROL_ID     =  SLI.ACCOUNT_CONTROL_ID
             AND FAC.SOB_ID                 =  SLI.SOB_ID
             AND SLI.SOB_ID                 =  W_SOB_ID
             AND SLI.ACCOUNT_CODE    LIKE      W_ACCOUNT_CODE_FROM || '%'
             AND SLI.GL_DATE         BETWEEN   W_PERIOD_FROM  AND  W_PERIOD_TO
        GROUP BY SLI.ACCOUNT_CONTROL_ID
               , SLI.ACCOUNT_CODE
               , FAC.ACCOUNT_DESC
               , SLI.GL_DATE
               , SLI.ACCOUNT_CONTROL_ID
        ORDER BY SLI.ACCOUNT_CODE
               , SLI.GL_DATE
               ;


  END;


  PROCEDURE SLIP_LINE_LIST_SELECT1( P_CURSOR                     OUT TYPES.TCURSOR
                                 , W_SOB_ID                     IN  FI_SLIP_LINE.SOB_ID%TYPE
                                 , W_ORG_ID                     IN  FI_SLIP_LINE.ORG_ID%TYPE
                                 , W_GL_DATE                    IN  FI_SLIP_LINE.GL_DATE%TYPE
                                 , W_ACCOUNT_CONTROL_ID         IN  FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE
                                 )

  IS

  BEGIN

          OPEN P_CURSOR FOR
          SELECT SLI.GL_DATE                                            AS  GL_DATE         -- 회계일자(ACCOUNT DATE)
               , SLI.ACCOUNT_CODE                                       AS  ACCOUNT_CODE    -- 계정코드(ACCOUNT CODE)
               , FAC.ACCOUNT_DESC                                       AS  ACCOUNT_DESC    -- 계정명(ACCOUNT NAME)
               , DECODE(SLI.ACCOUNT_DR_CR, '1', SLI.GL_AMOUNT, 0)       AS  DR_AMOUNT       -- 차변금액(DEBIT AMOUNT)
               , DECODE(SLI.ACCOUNT_DR_CR, '2', SLI.GL_AMOUNT, 0)       AS  CR_AMOUNT       -- 대변금액(CREDIT AMOUNT)
               , SLI.REMARK                                             AS  REMARK          -- 적요(REMARK)
               , SLI.ACCOUNT_CONTROL_ID                                 AS  ACCOUNT_CONTROL_ID
               , SLI.SLIP_HEADER_ID                                     AS  SLIP_HEADER_ID
            FROM FI_SLIP_LINE                  SLI
               , FI_ACCOUNT_CONTROL            FAC
           WHERE SLI.GL_DATE                =  W_GL_DATE
             AND SLI.ACCOUNT_CONTROL_ID     =  W_ACCOUNT_CONTROL_ID
             AND FAC.ACCOUNT_CONTROL_ID     =  SLI.ACCOUNT_CONTROL_ID
             AND FAC.SOB_ID                 =  SLI.SOB_ID
             AND SLI.SOB_ID                 =  W_SOB_ID
        ORDER BY SLI.SLIP_HEADER_ID
               , SLI.GL_DATE
               ;

  END;

  PROCEDURE BANKING_ACCOUNT_SUM_SELECT2( P_CURSOR                OUT TYPES.TCURSOR
                                      , W_SOB_ID                IN  FI_SLIP_LINE.SOB_ID%TYPE
                                      , W_ORG_ID                IN  FI_SLIP_LINE.ORG_ID%TYPE
                                      , W_PERIOD_FROM           IN  FI_SLIP_LINE.GL_DATE%TYPE
                                      , W_PERIOD_TO             IN  FI_SLIP_LINE.GL_DATE%TYPE
                                      , W_ACCOUNT_CODE_FROM     IN  FI_SLIP_LINE.ACCOUNT_CODE%TYPE
                                      )

  IS

  BEGIN

          OPEN P_CURSOR FOR
          SELECT ROW_NUMBER() OVER (PARTITION BY SLI.ACCOUNT_CODE ORDER BY SLI.GL_DATE) AS ROW_ID --순번(SEQUENCE)
               , DECODE(GROUPING_ID(SLI.ACCOUNT_CODE, FAC.ACCOUNT_DESC, SLI.GL_DATE), 3, '계정합계', 7, '계정총계', SLI.ACCOUNT_CODE) AS ACCOUNT_CODE -- 계정코드 (ACCOUNT CODE)
               , FAC.ACCOUNT_DESC                                       AS  ACCOUNT_DESC    -- 계정명(ACCOUNT NAME)
               , SLI.GL_DATE                                            AS  GL_DATE         -- 회계일자(ACCOUNT DATE)
               , SUM(DECODE(SLI.ACCOUNT_DR_CR, '1', SLI.GL_AMOUNT, 0))  AS  DR_AMOUNT       -- 차변금액(DEBIT AMOUNT)
               , SUM(DECODE(SLI.ACCOUNT_DR_CR, '2', SLI.GL_AMOUNT, 0))  AS  CR_AMOUNT       -- 대변금액(CREDIT AMOUNT)

               , SUM((DECODE(SLI.ACCOUNT_DR_CR, '1', SLI.GL_AMOUNT, 0)
                   * DECODE(FAC.ACCOUNT_DR_CR, '1', 1,         (-1)))
                   - (DECODE(SLI.ACCOUNT_DR_CR, '2', SLI.GL_AMOUNT, 0)
                   * DECODE(FAC.ACCOUNT_DR_CR, '1', 1,         (-1))))   AS  REMAIN_AMOUNT   -- 잔액금액(REMAIN AMOUNT)
            FROM FI_SLIP_LINE                  SLI
               , FI_ACCOUNT_CONTROL            FAC
           WHERE FAC.ACCOUNT_CONTROL_ID     =  SLI.ACCOUNT_CONTROL_ID
             AND FAC.SOB_ID                 =  SLI.SOB_ID
             AND SLI.SOB_ID                 =  W_SOB_ID
             AND SLI.ACCOUNT_CODE    LIKE      NVL(W_ACCOUNT_CODE_FROM, SLI.ACCOUNT_CODE)
             AND SLI.GL_DATE         BETWEEN   W_PERIOD_FROM  AND  W_PERIOD_TO
        GROUP BY ROLLUP( (SLI.ACCOUNT_CODE)
                       , (FAC.ACCOUNT_DESC, SLI.GL_DATE)
                       )
               ;

  END;

END FI_ACCOUNT_LEDGER_G; 
/
