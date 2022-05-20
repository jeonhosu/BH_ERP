SELECT SX1.TAX_REG_NO
     , SX1.CUSTOMER_DESC
     , SX1.VAT_COUNT
     , SX1.GL_AMOUNT
     , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -15, 3), '*', '') AS GL_AMOUNT_5
     , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -12, 3), '*', '') AS GL_AMOUNT_4
     , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -9, 3), '*', '') AS GL_AMOUNT_3
     , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -6, 3), '*', '') AS GL_AMOUNT_2
     , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -3, 3), '*', '') AS GL_AMOUNT_1
     , SX1.VAT_AMOUNT
     , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -15, 3), '*', '') AS VAT_AMOUNT_5
     , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -12, 3), '*', '') AS VAT_AMOUNT_4
     , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -9, 3), '*', '') AS VAT_AMOUNT_3
     , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -6, 3), '*', '') AS VAT_AMOUNT_2
     , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -3, 3), '*', '') AS VAT_AMOUNT_1
  FROM (SELECT SC.TAX_REG_NO
             , SC.SUPP_CUST_NAME AS CUSTOMER_DESC
             , SUM(VM.VAT_COUNT) AS VAT_COUNT
             , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
             , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
          FROM FI_VAT_MASTER VM
            , FI_SUPP_CUST_V SC
        WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID
          AND VM.SOB_ID                   = SC.SOB_ID
          AND VM.VAT_GUBUN                = '1'         -- ∏≈¿‘.
          AND VM.TAX_CODE                 = &W_TAX_CODE
          AND VM.VAT_ISSUE_DATE           BETWEEN &W_ISSUE_DATE_FR AND &W_ISSUE_DATE_TO
          AND VM.SOB_ID                   = &W_SOB_ID
          AND VM.CUSTOMER_ID              = NVL(&W_CUSTOMER_ID, VM.CUSTOMER_ID)
          AND VM.VAT_TYPE                 <> '5'
        GROUP BY SC.SUPP_CUST_NAME
             , SC.SUPP_CUST_CODE
             , SC.TAX_REG_NO
        ORDER BY SUPP_CUST_CODE
       ) SX1
;

