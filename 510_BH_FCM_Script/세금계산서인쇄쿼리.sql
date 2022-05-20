SELECT SX1.LINE_TYPE
           , SX1.CUSTOMER_COUNT
           , SX1.VAT_COUNT
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -15, 3), '*', '') AS GL_AMOUNT_5
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -12, 3), '*', '') AS GL_AMOUNT_4
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -9, 3), '*', '') AS GL_AMOUNT_3
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -6, 3), '*', '') AS GL_AMOUNT_2
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -3, 3), '*', '') AS GL_AMOUNT_1
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -15, 3), '*', '') AS VAT_AMOUNT_5
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -12, 3), '*', '') AS VAT_AMOUNT_4
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -9, 3), '*', '') AS VAT_AMOUNT_3
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -6, 3), '*', '') AS VAT_AMOUNT_2
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -3, 3), '*', '') AS VAT_AMOUNT_1
           , SX1.GL_AMOUNT
           , SX1.VAT_AMOUNT
        FROM (SELECT CASE
                         WHEN GROUPING(VM.TAX_ELECTRO_YN) = 1 THEN 'TS'
                         WHEN GROUPING(SC.BUSINESS_TYPE_S) = 1 THEN VM.TAX_ELECTRO_YN || 'S'
                         ELSE VM.TAX_ELECTRO_YN || SC.BUSINESS_TYPE_S 
                       END LINE_TYPE
                   , COUNT(DISTINCT SC.TAX_REG_NO) AS CUSTOMER_COUNT
                   , SUM(VM.VAT_COUNT) AS VAT_COUNT
                   , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                   , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
                FROM FI_VAT_MASTER VM
                  , FI_SUPP_CUST_V SC
              WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID
                AND VM.SOB_ID                   = SC.SOB_ID
                AND VM.VAT_GUBUN                = '1'         -- 매입.
                AND VM.TAX_CODE                 = &W_TAX_CODE
                AND VM.VAT_ISSUE_DATE           BETWEEN &W_ISSUE_DATE_FR AND &W_ISSUE_DATE_TO
                AND VM.SOB_ID                   = &W_SOB_ID
                AND VM.CUSTOMER_ID              = NVL(&W_CUSTOMER_ID, VM.CUSTOMER_ID)
                AND NOT EXISTS 
                      ( SELECT 'X'
                          FROM FI_VAT_TYPE_V VT
                        WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                          AND VT.SOB_ID     = VM.SOB_ID
                          AND VT.VAT_TYPE   IN ('5', '9', '3')  -- 계산서/직수출/신용카드 제외.
                      )
              GROUP BY ROLLUP ((VM.TAX_ELECTRO_YN)
                   , (SC.BUSINESS_TYPE_S))
             ) SX1
      ;
