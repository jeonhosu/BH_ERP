-- 001907
      -- 이월자료 생성.
      DELETE FROM FI_BALANCE_OVER_GT
      ;

      -- 이월 잔액 산출.
      INSERT INTO FI_BALANCE_OVER_GT
      ( GL_DATE
      , ACCOUNT_CONTROL_ID
      , ACCOUNT_CODE
      , ACCOUNT_DESC
      , CUSTOMER_ID
      , REMARK
      , DR_GL_AMOUNT
      , CR_GL_AMOUNT
      , REMAIN_AMOUNT
      )
      SELECT &W_GL_DATE_FR - 1 AS GL_DATE
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
                 AND CBD.GL_DATE               = TRUNC(&W_GL_DATE_FR, 'MONTH')
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
               WHERE CBD.CUSTOMER_ID           = SC.SUPP_CUST_ID
                 AND CBD.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID      
                 AND CBD.SOB_ID               = &W_SOB_ID
                 AND CBD.GL_DATE              BETWEEN TRUNC(&W_GL_DATE_FR, 'MONTH') AND &W_GL_DATE_FR - 1
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

SELECT *
  FROM FI_BALANCE_OVER_GT BO
;
    
-- 발생금액.
      INSERT INTO FI_BALANCE_OVER_GT
      ( GL_DATE
      , ACCOUNT_CONTROL_ID
      , ACCOUNT_CODE
      , ACCOUNT_DESC
      , CUSTOMER_ID
      , REMARK
      , DR_GL_AMOUNT
      , CR_GL_AMOUNT
      , REMAIN_AMOUNT
      , SOURCE_HEADER_ID
      , SOURCE_LINE_ID      
      , ATTRIBUTE_A 
      )
      SELECT SL.GL_DATE
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
     /*, CASE
         WHEN PX1.GL_DATE = &W_GL_DATE_FR - 1 THEN TO_CHAR(NULL)
         WHEN GROUPING(PX1.GL_DATE) = 1 THEN TO_CHAR(NULL)
         ELSE PX1.PERIOD_NAME
       END AS PERIOD_NAME
     */, PX1.SLIP_NUM
     , PX1.ACCOUNT_CODE
     , PX1.ACCOUNT_DESC
     , SUM(PX1.DR_AMOUNT) AS DR_AMOUNT
     , SUM(PX1.CR_AMOUNT) AS CR_AMOUNT
     , CASE
         WHEN PX1.GL_DATE = &W_GL_DATE_FR - 1 THEN TO_NUMBER(NULL)
         WHEN GROUPING(PX1.GL_DATE) = 1 THEN TO_NUMBER(NULL)
         WHEN GROUPING(PX1.ACCOUNT_CODE) = 1 THEN TO_NUMBER(NULL)
         ELSE SUM(PX1.REMAIN_AMOUNT)
       END AS REMAIN_AMOUNT
     , CASE
         WHEN GROUPING(PX1.ACCOUNT_CODE) = 1 THEN '총계'
         WHEN GROUPING(PX1.GL_DATE) = 1 THEN '월계'
         ELSE PX1.REMARK
       END AS REMARK
     , PX1.SLIP_HEADER_ID
  FROM (
    SELECT SX1.ACCOUNT_CODE
         , SX1.ACCOUNT_DESC
--         , SX1.PERIOD_NAME AS PERIOD_NAME
         , SX1.GL_DATE
         , SX1.SLIP_NUM
         , SX1.DR_AMOUNT AS DR_AMOUNT
         , SX1.CR_AMOUNT AS CR_AMOUNT
         , SUM(SX1.REMAIN_AMOUNT) OVER (PARTITION BY SX1.ACCOUNT_CODE ORDER BY SX1.ACCOUNT_CODE, SX1.GL_DATE, SX1.SLIP_LINE_ID) AS REMAIN_AMOUNT
         , SX1.REMARK
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
--     , PX1.PERIOD_NAME
     , PX1.ACCOUNT_DESC)
     , (PX1.GL_DATE
     , PX1.SLIP_NUM
     , PX1.REMARK
     , PX1.SLIP_HEADER_ID))
;

SELECT DECODE(TX1.GL_DATE, &W_GL_DATE_FR - 1, TO_DATE(NULL), TX1.GL_DATE) AS GL_DATE
     , CASE
         WHEN TX1.GL_DATE = &W_GL_DATE_FR - 1 THEN TO_CHAR(NULL)
         WHEN GROUPING(TX1.GL_DATE) = 1 THEN TO_CHAR(NULL)
         ELSE TX1.PERIOD_NAME
       END AS PERIOD_NAME
     , TX1.SLIP_NUM
     , TX1.ACCOUNT_CODE
     , TX1.ACCOUNT_DESC
     , SUM(TX1.DR_AMOUNT) AS DR_AMOUNT
     , SUM(TX1.CR_AMOUNT) AS CR_AMOUNT
     , CASE
         WHEN TX1.GL_DATE = &W_GL_DATE_FR - 1 THEN TO_NUMBER(NULL)
         WHEN GROUPING(TX1.GL_DATE) = 1 THEN TO_NUMBER(NULL)
         WHEN GROUPING(TX1.PERIOD_NAME) = 1 THEN TO_NUMBER(NULL)
         ELSE SUM(TX1.REMAIN_AMOUNT)
       END AS REMAIN_AMOUNT
     , CASE
         WHEN GROUPING(TX1.PERIOD_NAME) = 1 THEN '총계'
         WHEN GROUPING(TX1.GL_DATE) = 1 THEN '월계'
         ELSE TX1.REMARK
       END AS REMARK
     , TX1.SLIP_HEADER_ID
  FROM (
    SELECT SX1.ACCOUNT_CODE
         , SX1.ACCOUNT_DESC
         , TO_CHAR(SX1.GL_DATE, 'YYYY-MM') AS PERIOD_NAME
         , SX1.GL_DATE
         , SX1.SLIP_NUM
         , SX1.DR_AMOUNT AS DR_AMOUNT
         , SX1.CR_AMOUNT AS CR_AMOUNT
         , SUM(SX1.REMAIN_AMOUNT) OVER (PARTITION BY SX1.ACCOUNT_CODE ORDER BY SX1.ACCOUNT_CODE, SX1.GL_DATE, SX1.SLIP_LINE_ID) AS REMAIN_AMOUNT
         , SX1.REMARK
         , SX1.SLIP_HEADER_ID
         , SX1.SLIP_LINE_ID
      FROM (SELECT BOG.ACCOUNT_CODE
                 , BOG.ACCOUNT_DESC
                 , BOG.GL_DATE
                 , 0 AS SLIP_LINE_ID
                 , NULL AS SLIP_NUM
                 , BOG.DR_GL_AMOUNT AS DR_AMOUNT
                 , BOG.CR_GL_AMOUNT AS CR_AMOUNT
                 , (NVL(BOG.DR_GL_AMOUNT, 0) 
                     * DECODE(AC.ACCOUNT_DR_CR, '1', 1, -1)) + 
                   (NVL(BOG.CR_GL_AMOUNT, 0) 
                     * DECODE(AC.ACCOUNT_DR_CR, '2', 1, -1)) AS REMAIN_AMOUNT              
                 , BOG.REMARK
                 , NULL AS ACCOUNT_CONTROL_ID
                 , NULL AS SLIP_HEADER_ID
              FROM FI_BALANCE_OVER_GT BOG
                , FI_ACCOUNT_CONTROL AC
                , FI_SUPP_CUST_V SC
            WHERE BOG.ACCOUNT_CONTROL_ID      = AC.ACCOUNT_CONTROL_ID
              AND BOG.CUSTOMER_ID             = SC.SUPP_CUST_ID
              AND BOG.GL_DATE                 = &W_GL_DATE_FR -1
              AND SC.SUPP_CUST_CODE           = &W_CUSTOMER_CODE
              AND BOG.ACCOUNT_CODE            BETWEEN NVL(&W_ACCOUNT_CODE_FR, BOG.ACCOUNT_CODE) AND NVL(&W_ACCOUNT_CODE_TO, BOG.ACCOUNT_CODE)
            UNION ALL
            SELECT SL.ACCOUNT_CODE
                 , AC.ACCOUNT_DESC
                 , SL.GL_DATE
                 , SL.SLIP_LINE_ID
                 , SL.SLIP_NUM
                 , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) AS DR_AMOUNT
                 , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) AS CR_AMOUNT
                 , (DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) 
                     * DECODE(SL.ACCOUNT_DR_CR, '1', 1, -1)) + 
                   (DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) 
                     * DECODE(SL.ACCOUNT_DR_CR, '2', 1, -1)) AS REMAIN_AMOUNT              
                 , SL.REMARK
                 , SL.ACCOUNT_CONTROL_ID
                 , SL.SLIP_HEADER_ID
              FROM FI_SLIP_LINE SL
                , FI_ACCOUNT_CONTROL AC
                , FI_SLIP_MGMT_VENDOR_V SMV
            WHERE SL.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
              AND SL.SLIP_LINE_ID             = SMV.SLIP_LINE_ID(+)
              AND SL.GL_DATE                  BETWEEN &W_GL_DATE_FR AND &W_GL_DATE_TO
              AND SL.ACCOUNT_CODE             BETWEEN NVL(&W_ACCOUNT_CODE_FR, SL.ACCOUNT_CODE) AND NVL(&W_ACCOUNT_CODE_TO, SL.ACCOUNT_CODE)
              AND SL.SOB_ID                   = &W_SOB_ID
              AND SMV.CUSTOMER_CODE           = &W_CUSTOMER_CODE
            ORDER BY 1, 3
            ) SX1 
      ) TX1
--WHERE TX1.REMAIN_AMOUNT <> 0
GROUP BY ROLLUP ((TX1.PERIOD_NAME
     , TX1.ACCOUNT_CODE
     , TX1.ACCOUNT_DESC)
     , (TX1.GL_DATE
     , TX1.SLIP_NUM
     , TX1.REMARK
     , TX1.SLIP_HEADER_ID))

              
/*GROUP BY ROLLUP((SX1.GL_DATE
     , SX1.SLIP_LINE_ID
     , SX1.SLIP_NUM
     , SX1.ACCOUNT_CODE
     , SX1.ACCOUNT_DESC
     , SX1.REMARK
     , SX1.SLIP_HEADER_ID))    */
;
