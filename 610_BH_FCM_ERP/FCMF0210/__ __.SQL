      SELECT SL.SLIP_LINE_ID
           , SL.SLIP_LINE_SEQ
           , SL.SLIP_HEADER_ID
           , SL.SOB_ID
           , SL.DEPT_ID
           ,(SELECT DEPT_CODE  FROM  FI_DEPT_MASTER
              WHERE DEPT_ID = SL.DEPT_ID AND SOB_ID = SL.SOB_ID)  DEPT_CODE
           , FI_DEPT_MASTER_G.DEPT_NAME_F(SL.DEPT_ID) AS DEPT_NAME
           , SL.PERSON_ID
           ,(SELECT PM.PERSON_NUM  FROM HRM_PERSON_MASTER
			        WHERE PERSON_ID = SL.PERSON_ID AND SOB_ID = SL.SOB_ID )  PERSON_NUM	
			     , HRM_PERSON_MASTER_G.NAME_F(SL.PERSON_ID) AS PERSON_NAME
           , SL.ACCOUNT_BOOK_ID
           , SL.ACCOUNT_DR_CR
           , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', SL.ACCOUNT_DR_CR, SL.SOB_ID, SL.ORG_ID) AS ACCOUNT_DR_CR_NAME
           , SL.ACCOUNT_CONTROL_ID
           , SL.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , SL.CURRENCY_CODE
           , SL.CURRENCY_CODE AS CURRENCY_DESC
           , SL.EXCHANGE_RATE
           , SL.GL_CURRENCY_AMOUNT
           , SL.GL_AMOUNT
           , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) AS DR_AMOUNT
           , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) AS CR_AMOUNT
           , SL.CUSTOMER_ID
           , SCV.SUPP_CUST_NAME AS CUSTOMER_NAME
           , SCV.TAX_REG_NO
           , SL.BANK_ACCOUNT_ID
           , BAT.BANK_ACCOUNT_NAME
           , BAT.BANK_ACCOUNT_NUM           
           , SL.BUDGET_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(SL.BUDGET_DEPT_ID) AS BUDGET_DEPT_NAME
           , SL.COST_CENTER_ID
           , FI_COMMON_G.COST_CENTER_CODE_F(SL.COST_CENTER_ID) AS COST_CENTER_CODE
           , FI_COMMON_G.COST_CENTER_DESC_F(SL.COST_CENTER_ID) AS COST_CENTER_DESC           
           , SL.MANAGEMENT1                           -- °èÁÂ¹øÈ£ OR CODE °ª.
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'MANAGEMENT1_ID'
                                                          , SL.MANAGEMENT1
                                                          , SL.SOB_ID) AS MANAGEMENT1_DESC
           , SL.MANAGEMENT2
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'MANAGEMENT2_ID'
                                                          , SL.MANAGEMENT2
                                                          , SL.SOB_ID) AS MANAGEMENT2_DESC
           , SL.REFER1
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER1_ID'
                                                          , SL.REFER1
                                                          , SL.SOB_ID) AS REFER1_DESC
           , SL.REFER2
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER2_ID'
                                                          , SL.REFER2
                                                          , SL.SOB_ID) AS REFER2_DESC
           , SL.REFER3
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER3_ID'
                                                          , SL.REFER3
                                                          , SL.SOB_ID) AS REFER3_DESC
           , SL.REFER4
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER4_ID'
                                                          , SL.REFER4
                                                          , SL.SOB_ID) AS REFER4_DESC
           , SL.REFER5
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER5_ID'
                                                          , SL.REFER5
                                                          , SL.SOB_ID) AS REFER5_DESC
           , SL.VOUCH_CODE
           , FI_COMMON_G.CODE_NAME_F('VOUCH_CODE', SL.VOUCH_CODE, SL.SOB_ID, SL.ORG_ID) AS VOUCH_NAME
           , SL.REFER_RATE
           , SL.REFER_AMOUNT
           , SL.REFER_DATE1
           , SL.REFER_DATE2
           , SL.REMARK
           , SL.CLOSED_YN
           , DECODE(ACI.MANAGEMENT1_ID, NULL, 'F', NVL(ACI.MANAGEMENT1_YN, 'N')) AS MANAGEMENT1_YN
           , DECODE(ACI.MANAGEMENT2_ID, NULL, 'F', NVL(ACI.MANAGEMENT2_YN, 'N')) AS MANAGEMENT2_YN
           , DECODE(ACI.REFER1_ID, NULL, 'F', NVL(ACI.REFER1_YN, 'N')) AS REFER1_YN
           , DECODE(ACI.REFER2_ID, NULL, 'F', NVL(ACI.REFER2_YN, 'N')) AS REFER2_YN
           , DECODE(ACI.REFER3_ID, NULL, 'F', NVL(ACI.REFER3_YN, 'N')) AS REFER3_YN
           , DECODE(ACI.REFER4_ID, NULL, 'F', NVL(ACI.REFER4_YN, 'N')) AS REFER4_YN
           , DECODE(ACI.REFER5_ID, NULL, 'F', NVL(ACI.REFER5_YN, 'N')) AS REFER5_YN
           , DECODE(ACI.REFER_RATE_ID, NULL, 'F', NVL(ACI.REFER_RATE_YN, 'N')) AS REFER_RATE_YN
           , DECODE(ACI.REFER_AMOUNT_ID, NULL, 'F', NVL(ACI.REFER_AMOUNT_YN, 'N')) AS REFER_AMOUNT_YN
           , DECODE(ACI.REFER_DATE1_ID, NULL, 'F', NVL(ACI.REFER_DATE1_YN, 'N')) AS REFER_DATE1_YN
           , DECODE(ACI.REFER_DATE2_ID, NULL, 'F', NVL(ACI.REFER_DATE2_YN, 'N')) AS REFER_DATE2_YN
           , NVL(ACI.VOUCH_YN, 'F') AS VOUCH_YN
           , NVL(AC.ACCOUNT_DR_CR, '1') AS CONTROL_ACCOUNT_DR_CR
           , NVL(AC.CUSTOMER_ENABLED_FLAG, 'N') AS CUSTOMER_ENABLED_FLAG
           , NVL(AC.BANK_ACCOUNT_FLAG, 'N') AS BANK_ACCOUNT_FLAG
           , NVL(AC.CURRENCY_ENABLED_FLAG, 'N') AS CURRENCY_ENABLED_FLAG
           , NVL(AC.VAT_ENABLED_FLAG, 'N') AS VAT_ENABLED_FLAG
           , NVL(AC.ACCOUNT_MICH_YN, 'N') AS ACCOUNT_MICH_YN
           , NVL(AC.BUDGET_ENABLED_FLAG, 'N') AS BUDGET_ENABLED_FLAG
           , NVL(AC.BUDGET_CONTROL_FLAG, 'N') AS BUDGET_CONTROL_FLAG
           , NVL(AC.BUDGET_BELONG_FLAG, 'N') AS BUDGET_BELONG_FLAG
           , NVL(AC.COST_CENTER_FLAG, 'N') AS COST_CENTER_FLAG
        FROM FI_SLIP_LINE SL
          , FI_SUPP_CUST_V SCV
          , FI_ACCOUNT_CONTROL AC
          , FI_ACCOUNT_CONTROL_ITEM ACI
          , FI_BANK_ACCOUNT_TLV BAT
       WHERE SL.CUSTOMER_ID             = SCV.SUPP_CUST_ID(+)
         AND SL.ACCOUNT_CONTROL_ID      = AC.ACCOUNT_CONTROL_ID
         AND SL.ACCOUNT_CONTROL_ID      = ACI.ACCOUNT_CONTROL_ID(+)
         AND SL.ACCOUNT_DR_CR           = ACI.ACCOUNT_DR_CR(+)
         AND SL.SOB_ID                  = ACI.SOB_ID(+)
         AND SL.BANK_ACCOUNT_ID         = BAT.BANK_ACCOUNT_ID(+)         
         AND SL.SLIP_HEADER_ID          = W_SLIP_HEADER_ID
         AND SL.SOB_ID                  = W_SOB_ID
      ORDER BY SL.SLIP_LINE_SEQ
      ;