SELECT *
  FROM FI_DAILY_SUM DS
WHERE DS.GL_DATE        BETWEEN &W_GL_DATE_FR AND &W_GL_DATE_TO
  AND DS.SOB_ID         = 10
;

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
     , &W_GL_DATE_FR -1 AS GL_DATE
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
        SELECT DS.ACCOUNT_CONTROL_ID
             , DS.ACCOUNT_CODE
             , AC.ACCOUNT_DR_CR      -- 잔액 구분.
             , DS.DR_SUM AS DR_AMOUNT
             , DS.CR_SUM AS CR_AMOUNT
          FROM FI_DAILY_SUM DS
            , FI_ACCOUNT_CONTROL AC
         WHERE DS.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
           AND DS.GL_DATE               = TRUNC(&W_GL_DATE_FR, 'MONTH')
           AND DS.GL_DATE_SEQ           = 0
           AND DS.SOB_ID                = &W_SOB_ID
           AND DS.ACCOUNT_CODE          BETWEEN NVL(&W_ACCOUNT_CODE_FR, DS.ACCOUNT_CODE) AND NVL(&W_ACCOUNT_CODE_TO, DS.ACCOUNT_CODE)
        UNION ALL
        -- 1일 ~ 시작(GL_DATE_FR-1) 전일까지의 잔액금액 계산.
        SELECT SL.ACCOUNT_CONTROL_ID
             , SL.ACCOUNT_CODE
             , AC.ACCOUNT_DR_CR
             , DECODE(AC.ACCOUNT_DR_CR, '1', (DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)- DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)), 0) AS DR_AMOUNT
             , DECODE(AC.ACCOUNT_DR_CR, '2', (DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)- DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)), 0) AS CR_AMOUNT
          FROM FI_SLIP_LINE SL
            , FI_ACCOUNT_CONTROL AC
         WHERE SL.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
           AND SL.SOB_ID                = &W_SOB_ID
           AND SL.GL_DATE               BETWEEN TRUNC(&W_GL_DATE_FR, 'MONTH') AND &W_GL_DATE_FR - 1
           AND SL.ACCOUNT_BOOK_ID       = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(&W_SOB_ID)
           AND SL.ACCOUNT_CODE          BETWEEN NVL(&W_ACCOUNT_CODE_FR, SL.ACCOUNT_CODE) AND NVL(&W_ACCOUNT_CODE_TO, SL.ACCOUNT_CODE)
        ) PX1
WHERE FAC.ACCOUNT_CONTROL_ID            = PX1.ACCOUNT_CONTROL_ID(+)
  AND FAC.ACCOUNT_CODE                  BETWEEN NVL(&W_ACCOUNT_CODE_FR, FAC.ACCOUNT_CODE) AND NVL(&W_ACCOUNT_CODE_TO, FAC.ACCOUNT_CODE)
GROUP BY FAC.ACCOUNT_CONTROL_ID
     , FAC.ACCOUNT_CODE
     , FAC.ACCOUNT_DESC
     , FAC.ACCOUNT_DR_CR
;

---------------------------------------------------------------------------------------------------
SELECT CASE
         WHEN GROUPING(FX1.ACCOUNT_CODE) = 1 THEN NULL
         WHEN GROUPING(FX1.GL_DATE) = 1 THEN NULL
         ELSE FX1.ACCOUNT_CODE
       END AS ACCOUNT_CODE
    , CASE
         WHEN GROUPING(FX1.ACCOUNT_CODE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10051', NULL)
         WHEN GROUPING(FX1.GL_DATE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10179', NULL)
         ELSE FX1.ACCOUNT_DESC
       END AS ACCOUNT_DESC
    , FX1.GL_DATE
    , SUM(FX1.DR_AMOUNT) AS DR_AMOUNT
    , SUM(FX1.CR_AMOUNT) AS CR_AMOUNT
    , CASE
         WHEN GROUPING(FX1.ACCOUNT_CODE) = 1 THEN 0
         WHEN GROUPING(FX1.GL_DATE) = 1 THEN 0
         ELSE SUM(FX1.REMAIN_AMOUNT)
       END AS REMAIN_AMOUNT
    , FX1.ACCOUNT_CONTROL_ID
  FROM (SELECT TX1.ACCOUNT_CODE
            , TX1.ACCOUNT_DESC
            , TX1.GL_DATE
            , TX1.DR_AMOUNT AS DR_AMOUNT
            , TX1.CR_AMOUNT AS CR_AMOUNT
            , SUM(TX1.REMAIN_AMOUNT) OVER (PARTITION BY TX1.ACCOUNT_CODE ORDER BY TX1.ACCOUNT_CODE, TX1.GL_DATE) AS REMAIN_AMOUNT
            , TX1.ACCOUNT_CONTROL_ID
          FROM (
            SELECT BOG.ACCOUNT_CODE
                , BOG.ACCOUNT_DESC
                , BOG.ACCOUNT_DR_CR
                , BOG.GL_DATE
                , BOG.DR_GL_AMOUNT AS DR_AMOUNT
                , BOG.CR_GL_AMOUNT AS CR_AMOUNT
                , BOG.REMAIN_AMOUNT
                , BOG.ACCOUNT_CONTROL_ID
            FROM FI_BALANCE_OVER_GT BOG
            WHERE BOG.ACCOUNT_CODE           BETWEEN NVL(&W_ACCOUNT_CODE_FR, BOG.ACCOUNT_CODE) AND NVL(&W_ACCOUNT_CODE_TO, BOG.ACCOUNT_CODE)
              AND BOG.GL_DATE                BETWEEN &W_GL_DATE_FR - 1 AND &W_GL_DATE_TO
            -------------------------------------------------------------------------------
            UNION ALL
            -------------------------------------------------------------------------------
            SELECT FAC.ACCOUNT_CODE
                 , FAC.ACCOUNT_DESC                                       AS  ACCOUNT_DESC    -- 계정명(Account Name)
                 , FAC.ACCOUNT_DR_CR
                 , SLI.GL_DATE                                            AS  GL_DATE         -- 회계일자(Account Date)
                 , SUM(DECODE(SLI.ACCOUNT_DR_CR, '1', SLI.GL_AMOUNT, 0))  AS  DR_AMOUNT       -- 차변금액(Debit Amount)
                 , SUM(DECODE(SLI.ACCOUNT_DR_CR, '2', SLI.GL_AMOUNT, 0))  AS  CR_AMOUNT       -- 대변금액(Credit Amount)
                 , NVL(SUM(CASE
                             WHEN FAC.ACCOUNT_DR_CR = '1' THEN NVL(DECODE(SLI.ACCOUNT_DR_CR, '1', SLI.GL_AMOUNT, 0), 0) - NVL(DECODE(SLI.ACCOUNT_DR_CR, '2', SLI.GL_AMOUNT, 0), 0)
                             WHEN FAC.ACCOUNT_DR_CR = '2' THEN NVL(DECODE(SLI.ACCOUNT_DR_CR, '2', SLI.GL_AMOUNT, 0), 0) - NVL(DECODE(SLI.ACCOUNT_DR_CR, '1', SLI.GL_AMOUNT, 0), 0)
                             ELSE 0
                           END), 0) AS REMAIN_AMOUNT       -- 잔액금액(Remain Amount)
                 , FAC.ACCOUNT_CONTROL_ID
              FROM FI_SLIP_LINE                  SLI
                 , FI_ACCOUNT_CONTROL            FAC
            WHERE FAC.ACCOUNT_CONTROL_ID     =  SLI.ACCOUNT_CONTROL_ID
              AND FAC.SOB_ID                 =  SLI.SOB_ID
              AND SLI.SOB_ID                 =  &W_SOB_ID
              AND SLI.ACCOUNT_CODE           BETWEEN NVL(&W_ACCOUNT_CODE_FR, SLI.ACCOUNT_CODE) AND NVL(&W_ACCOUNT_CODE_TO, SLI.ACCOUNT_CODE)
              AND SLI.GL_DATE                BETWEEN &W_GL_DATE_FR AND &W_GL_DATE_TO
            GROUP BY FAC.ACCOUNT_CODE
                 , FAC.ACCOUNT_DESC                                       
                 , FAC.ACCOUNT_DR_CR
                 , SLI.GL_DATE                                            
                 , FAC.ACCOUNT_CONTROL_ID  
            ) TX1
        ) FX1
        
GROUP BY ROLLUP((FX1.ACCOUNT_CODE
    , FX1.ACCOUNT_DESC
    , FX1.ACCOUNT_CONTROL_ID)
    , (FX1.GL_DATE))
;   

         
