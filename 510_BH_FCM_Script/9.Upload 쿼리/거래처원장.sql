SELECT FSC.SUPP_CUST_ID           AS  SUPP_CUST_ID
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
   AND FCB.PERIOD_NAME        = NVL(&W_PERIOD_NAME, FCB.PERIOD_NAME)
   AND FCB.SOB_ID             = &W_SOB_ID
   AND FCB.CUSTOMER_ID        = NVL(&W_CUSTOMER_ID, FCB.CUSTOMER_ID)
ORDER BY FCB.CUSTOMER_ID   
;
