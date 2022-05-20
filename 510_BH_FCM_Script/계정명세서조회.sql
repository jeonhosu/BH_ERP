SELECT TX1.ACCOUNT_CODE
     , TX1.ACCOUNT_DESC
           , CASE
               WHEN TX1.SLIP_HEADER_ID = 0 THEN TO_DATE(NULL)
               ELSE TX1.GL_DATE
             END AS GL_DATE
           , CASE
               WHEN GROUPING(TX1.PERIOD_NAME) = 1 THEN NULL
               WHEN GROUPING(TX1.GL_DATE) = 1 THEN NULL
               ELSE TX1.PERIOD_NAME
             END AS PERIOD_NAME
           , CASE
               WHEN GROUPING(TX1.PERIOD_NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10051', NULL)
               WHEN GROUPING(TX1.GL_DATE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10050', NULL)
               ELSE TX1.REMARK
             END AS REMARK
           , SUM(TX1.DR_AMOUNT) AS DR_AMOUNT
           , SUM(TX1.CR_AMOUNT) AS CR_AMOUNT
           , CASE
               WHEN TX1.SLIP_HEADER_ID = 0 THEN 0
               WHEN GROUPING(TX1.GL_DATE) = 1 THEN 0
               ELSE SUM(TX1.REMAIN_AMOUNT)
             END AS REMAIN_AMOUNT
           , TX1.SLIP_HEADER_ID
        FROM (SELECT AC.ACCOUNT_CODE
                   , AC.ACCOUNT_DESC
                   , SX1.GL_DATE
                   , SX1.PERIOD_NAME
                   , SX1.SLIP_HEADER_ID
                   , SX1.REMARK
                   , SX1.DR_AMOUNT AS DR_AMOUNT
                   , SX1.CR_AMOUNT AS CR_AMOUNT
                   , CASE
                       WHEN SX1.ACCOUNT_DR_CR = '1' THEN SUM(SX1.DR_AMOUNT - SX1.CR_AMOUNT) OVER (ORDER BY SX1.PERIOD_NAME, GL_DATE, SLIP_HEADER_ID, SX1.REMARK)
                       WHEN SX1.ACCOUNT_DR_CR = '2' THEN SUM(SX1.CR_AMOUNT - SX1.DR_AMOUNT) OVER (ORDER BY SX1.PERIOD_NAME, GL_DATE, SLIP_HEADER_ID, SX1.REMARK)
                     END AS REMAIN_AMOUNT
                FROM FI_ACCOUNT_CONTROL AC
                   , (-- 이월 잔액 산출.
                      SELECT PX1.ACCOUNT_CONTROL_ID
                           , &W_GL_DATE_FR AS GL_DATE
                           , TO_CHAR(&W_GL_DATE_FR ,'YYYY-MM') AS PERIOD_NAME
                           , 0 AS SLIP_HEADER_ID
                           , EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10165', NULL) AS REMARK
                           , NVL(SUM(PX1.DR_AMOUNT), 0) AS DR_AMOUNT
                           , NVL(SUM(PX1.CR_AMOUNT), 0) AS CR_AMOUNT
                           , PX1.ACCOUNT_DR_CR
                        FROM (SELECT 0 AS ACCOUNT_CONTROL_ID
                                   , '1' AS ACCOUNT_DR_CR
                                   , 0 AS DR_AMOUNT
                                   , 0 AS CR_AMOUNT
                                FROM DUAL
                              UNION ALL
                              SELECT AC.ACCOUNT_CONTROL_ID
                                   , AC.ACCOUNT_DR_CR
                                   , DS.DR_SUM AS DR_AMOUNT
                                   , DS.CR_SUM AS CR_AMOUNT
                                FROM FI_DAILY_SUM DS
                                  , FI_ACCOUNT_CONTROL AC
                               WHERE DS.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
                                 AND DS.GL_DATE               = TRUNC(&W_GL_DATE_FR, 'MONTH')
                                 AND DS.GL_DATE_SEQ           = 0
                                 AND DS.SOB_ID                = &W_SOB_ID
                                 AND DS.ACCOUNT_CODE          BETWEEN &W_ACCOUNT_CODE_FR AND &W_ACCOUNT_CODE_TO
                              UNION ALL
                              -- 1일 ~ 시작(GL_DATE_FR-1) 전일까지의 잔액금액 계산.
                              SELECT AC.ACCOUNT_CONTROL_ID
                                   , AC.ACCOUNT_DR_CR
                                   , DECODE(AC.ACCOUNT_DR_CR, '1', (DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)- DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)), 0) AS DR_AMOUNT
                                   , DECODE(AC.ACCOUNT_DR_CR, '2', (DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)- DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)), 0) AS CR_AMOUNT
                                FROM FI_SLIP_LINE SL
                                  , FI_ACCOUNT_CONTROL AC
                               WHERE SL.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
                                 AND SL.SOB_ID                = &W_SOB_ID
                                 AND SL.GL_DATE               BETWEEN TRUNC(&W_GL_DATE_FR, 'MONTH') AND &W_GL_DATE_FR - 1
                                 AND SL.ACCOUNT_BOOK_ID       = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(&W_SOB_ID)
                                 AND SL.ACCOUNT_CODE          BETWEEN &W_ACCOUNT_CODE_FR AND &W_ACCOUNT_CODE_TO
                            ) PX1
                      GROUP BY PX1.ACCOUNT_CONTROL_ID, PX1.ACCOUNT_DR_CR
                      UNION ALL
                      -- 기준일 발생금액.
                      SELECT SL.ACCOUNT_CONTROL_ID
                           , SL.GL_DATE
                           , TO_CHAR(SL.GL_DATE, 'YYYY-MM') AS PERIOD_NAME
                           , SL.SLIP_HEADER_ID
                           , SL.REMARK
                           , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) AS DR_AMOUNT
                           , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) AS CR_AMOUNT
                           , AC.ACCOUNT_DR_CR
                        FROM FI_SLIP_LINE SL
                          , FI_ACCOUNT_CONTROL AC
                       WHERE SL.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
                         AND SL.SOB_ID                = &W_SOB_ID
                         AND SL.GL_DATE               BETWEEN &W_GL_DATE_FR AND &W_GL_DATE_TO
                         AND SL.ACCOUNT_BOOK_ID       = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(&W_SOB_ID)
                         AND SL.ACCOUNT_CODE          BETWEEN &W_ACCOUNT_CODE_FR AND &W_ACCOUNT_CODE_TO
                      ) SX1
                WHERE AC.ACCOUNT_CONTROL_ID   = SX1.ACCOUNT_CONTROL_ID
            ) TX1
      GROUP BY ROLLUP ((TX1.PERIOD_NAME
           , TX1.ACCOUNT_CODE
           , TX1.ACCOUNT_DESC)
           , (TX1.GL_DATE
           , TX1.SLIP_HEADER_ID
           , TX1.REMARK))
      ;
