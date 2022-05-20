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
      SELECT &W_GL_DATE_FR - 1 AS GL_DATE
           , TO_CHAR(&W_GL_DATE_FR, 'YYYY-MM') AS PERIOD_NAME
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
                 AND CBD.GL_DATE               = TRUNC(&W_GL_DATE_FR, 'YEAR')
                 AND CBD.GL_DATE_SEQ           = 0
                 AND CBD.SOB_ID                = &W_SOB_ID
                 AND SC.SUPP_CUST_CODE         = &W_CUSTOMER_CODE
                 AND CBD.ACCOUNT_CODE          BETWEEN NVL(&W_ACCOUNT_CODE_FR, CBD.ACCOUNT_CODE) AND NVL(&W_ACCOUNT_CODE_TO, CBD.ACCOUNT_CODE)
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
                 AND CBD.SOB_ID               = &W_SOB_ID
                 AND CBD.GL_DATE              BETWEEN TRUNC(&W_GL_DATE_FR, 'YEAR') AND &W_GL_DATE_FR - 1
                 AND CBD.GL_DATE_SEQ           = 1
                 AND CBD.ACCOUNT_BOOK_ID      = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(&W_SOB_ID)
                 AND CBD.ACCOUNT_CODE         BETWEEN NVL(&W_ACCOUNT_CODE_FR, CBD.ACCOUNT_CODE) AND NVL(&W_ACCOUNT_CODE_TO, CBD.ACCOUNT_CODE)
                 AND SC.SUPP_CUST_CODE        = &W_CUSTOMER_CODE
              ) PX1
      WHERE FAC.ACCOUNT_CONTROL_ID            = PX1.ACCOUNT_CONTROL_ID(+)
        AND FAC.ACCOUNT_CODE                  BETWEEN NVL(&W_ACCOUNT_CODE_FR, FAC.ACCOUNT_CODE) AND NVL(&W_ACCOUNT_CODE_TO, FAC.ACCOUNT_CODE)
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
           , SL.SLIP_NUM
        FROM FI_SLIP_LINE SL
          , FI_ACCOUNT_CONTROL AC
          , FI_SLIP_MGMT_VENDOR_V SMV
      WHERE SL.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
        AND SL.SLIP_LINE_ID             = SMV.SLIP_LINE_ID(+)
        AND SL.GL_DATE                  BETWEEN &W_GL_DATE_FR AND &W_GL_DATE_TO
        AND SL.ACCOUNT_CODE             BETWEEN NVL(&W_ACCOUNT_CODE_FR, SL.ACCOUNT_CODE) AND NVL(&W_ACCOUNT_CODE_TO, SL.ACCOUNT_CODE)
        AND SL.SOB_ID                   = &W_SOB_ID
        AND SMV.CUSTOMER_CODE           = &W_CUSTOMER_CODE
      ;
    
    
      SELECT DECODE(PX1.GL_DATE, &W_GL_DATE_FR - 1, TO_DATE(NULL), PX1.GL_DATE) AS GL_DATE
           , PX1.SLIP_NUM
           , PX1.ACCOUNT_CODE
           , PX1.ACCOUNT_DESC
           , CASE
               WHEN GROUPING(PX1.ACCOUNT_CODE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10051', NULL)
               WHEN GROUPING(PX1.GL_DATE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10050', NULL)
               ELSE PX1.REMARK
             END AS REMARK
           , DECODE(GROUPING(PX1.GL_DATE), 1, SUM(PX1.MONTH_DR_AMOUNT), SUM(PX1.DR_AMOUNT)) AS DR_AMOUNT
           , DECODE(GROUPING(PX1.GL_DATE), 1, SUM(PX1.MONTH_CR_AMOUNT), SUM(PX1.CR_AMOUNT)) AS CR_AMOUNT
           , CASE
               WHEN PX1.GL_DATE = &W_GL_DATE_FR - 1 THEN TO_NUMBER(NULL)
               WHEN GROUPING(PX1.ACCOUNT_CODE) = 1 THEN TO_NUMBER(NULL)
               WHEN GROUPING(PX1.GL_DATE) = 1 THEN SUM(PX1.REMAIN_AMOUNT) /*NVL(SUM(CASE
                                                             WHEN AC.ACCOUNT_DR_CR = '1' THEN NVL(PX1.DR_AMOUNT, 0) - NVL(PX1.CR_AMOUNT, 0)
                                                             WHEN AC.ACCOUNT_DR_CR = '2' THEN NVL(PX1.CR_AMOUNT, 0) - NVL(PX1.DR_AMOUNT, 0)
                                                             ELSE 0
                                                           END), 0)*/
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
                 , NVL(SX1.REMAIN_AMOUNT, 0) AS REMAIN_AMT
                 , SX1.REMARK
                 , SX1.CURRENCY_CODE
                 , NVL(SX1.DR_CURRENCY_AMOUNT, 0) AS DR_CURRENCY_AMOUNT
                 , NVL(SX1.CR_CURRENCY_AMOUNT, 0) AS CR_CURRENCY_AMOUNT
                 , NVL(SX1.MONTH_DR_AMOUNT, 0) AS MONTH_DR_AMOUNT
                 , NVL(SX1.MONTH_CR_AMOUNT, 0) AS MONTH_CR_AMOUNT
                 , NVL(SX1.MONTH_DR_CURR_AMOUNT, 0) AS MONTH_DR_CURR_AMOUNT
                 , NVL(SX1.MONTH_CR_CURR_AMOUNT, 0) AS MONTH_CR_CURR_AMOUNT
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
           , PX1.ACCOUNT_DESC
           , PX1.PERIOD_NAME)
           , (PX1.GL_DATE
           , PX1.SLIP_HEADER_ID
           , PX1.SLIP_LINE_ID
           , PX1.SLIP_NUM
           , PX1.REMARK
           , PX1.CURRENCY_CODE))
      ;
