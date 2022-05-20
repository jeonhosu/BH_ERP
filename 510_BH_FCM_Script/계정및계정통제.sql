SELECT AC.ACCOUNT_DESC
           , AC.ACCOUNT_CODE
           , AC.ACCOUNT_CONTROL_ID
           , AC.ACCOUNT_DR_CR
           , AC.CUSTOMER_ENABLED_FLAG
           , AC.ACCOUNT_ENABLED_FLAG
           , AC.BANK_ACCOUNT_FLAG
           , AC.CURRENCY_ENABLED_FLAG
           , AC.VAT_ENABLED_FLAG
           , AC.ACCOUNT_MICH_YN
           , AC.BUDGET_ENABLED_FLAG
           , AC.BUDGET_CONTROL_FLAG
           , AC.BUDGET_BELONG_FLAG
           , AC.COST_CENTER_FLAG
           , S_ACI.MANAGEMENT1_ID
           , S_ACI.MANAGEMENT1_NAME
           , S_ACI.MANAGEMENT1_YN
           , S_ACI.MANAGEMENT1_LOOKUP_YN
           , S_ACI.MANAGEMENT2_ID
           , S_ACI.MANAGEMENT2_NAME
           , S_ACI.MANAGEMENT2_YN
           , S_ACI.MANAGEMENT2_LOOKUP_YN
           , S_ACI.REFER1_ID
           , S_ACI.REFER1_NAME
           , S_ACI.REFER1_YN
           , S_ACI.REFER1_LOOKUP_YN
           , S_ACI.REFER2_ID
           , S_ACI.REFER2_NAME
           , S_ACI.REFER2_YN
           , S_ACI.REFER2_LOOKUP_YN
           , S_ACI.REFER3_ID
           , S_ACI.REFER3_NAME
           , S_ACI.REFER3_YN
           , S_ACI.REFER3_LOOKUP_YN
           , S_ACI.REFER4_ID
           , S_ACI.REFER4_NAME
           , S_ACI.REFER4_YN
           , S_ACI.REFER4_LOOKUP_YN
           , S_ACI.REFER5_ID
           , S_ACI.REFER5_NAME
           , S_ACI.REFER5_YN
           , S_ACI.REFER5_LOOKUP_YN
           , S_ACI.REFER6_ID
           , S_ACI.REFER6_NAME
           , S_ACI.REFER6_YN
           , S_ACI.REFER6_LOOKUP_YN
           , S_ACI.REFER7_ID
           , S_ACI.REFER7_NAME
           , S_ACI.REFER7_YN
           , S_ACI.REFER7_LOOKUP_YN
           , S_ACI.REFER8_ID
           , S_ACI.REFER8_NAME
           , S_ACI.REFER8_YN
           , S_ACI.REFER8_LOOKUP_YN
           , S_ACI.REFER9_ID
           , S_ACI.REFER9_NAME
           , S_ACI.REFER9_YN
           , S_ACI.REFER9_LOOKUP_YN
           , S_ACI.REFER_RATE_ID
           , S_ACI.REFER_RATE_NAME
           , S_ACI.REFER_RATE_YN
           , S_ACI.REFER_AMOUNT_ID
           , S_ACI.REFER_AMOUNT_NAME
           , S_ACI.REFER_AMOUNT_YN
           , S_ACI.REFER_DATE1_ID
           , S_ACI.REFER_DATE1_NAME
           , S_ACI.REFER_DATE1_YN
           , S_ACI.REFER_DATE2_ID
           , S_ACI.REFER_DATE2_NAME
           , S_ACI.REFER_DATE2_YN
           , S_ACI.VOUCH_ID
           , S_ACI.VOUCH_NAME
           , S_ACI.VOUCH_YN
        FROM FI_ACCOUNT_CONTROL AC
          , (-- 계정통제 사항
            SELECT ACI.MANAGEMENT1_ID
                 , FI_COMMON_G.ID_NAME_F(ACI.MANAGEMENT1_ID) AS MANAGEMENT1_NAME
                 , DECODE(ACI.MANAGEMENT1_ID, NULL, 'F', NVL(ACI.MANAGEMENT1_YN, 'N')) AS MANAGEMENT1_YN
                 , NVL(FI_COMMON_G.ID_VALUE_F(ACI.MANAGEMENT1_ID, DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS MANAGEMENT1_LOOKUP_YN
                 , ACI.MANAGEMENT2_ID
                 , FI_COMMON_G.ID_NAME_F(ACI.MANAGEMENT2_ID) AS MANAGEMENT2_NAME
                 , DECODE(ACI.MANAGEMENT2_ID, NULL, 'F', NVL(ACI.MANAGEMENT2_YN, 'N')) AS MANAGEMENT2_YN
                 , NVL(FI_COMMON_G.ID_VALUE_F(ACI.MANAGEMENT2_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS MANAGEMENT2_LOOKUP_YN
                 , ACI.REFER1_ID
                 , FI_COMMON_G.ID_NAME_F(ACI.REFER1_ID) AS REFER1_NAME
                 , DECODE(ACI.REFER1_ID, NULL, 'F', NVL(ACI.REFER1_YN, 'N')) AS REFER1_YN
                 , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER1_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER1_LOOKUP_YN
                 , ACI.REFER2_ID
                 , FI_COMMON_G.ID_NAME_F(ACI.REFER2_ID) AS REFER2_NAME
                 , DECODE(ACI.REFER2_ID, NULL, 'F', NVL(ACI.REFER2_YN, 'N')) AS REFER2_YN
                 , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER2_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER2_LOOKUP_YN
                 , ACI.REFER3_ID
                 , FI_COMMON_G.ID_NAME_F(ACI.REFER3_ID) AS REFER3_NAME
                 , DECODE(ACI.REFER3_ID, NULL, 'F', NVL(ACI.REFER3_YN, 'N')) AS REFER3_YN
                 , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER3_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER3_LOOKUP_YN
                 , ACI.REFER4_ID
                 , FI_COMMON_G.ID_NAME_F(ACI.REFER4_ID) AS REFER4_NAME
                 , DECODE(ACI.REFER4_ID, NULL, 'F', NVL(ACI.REFER4_YN, 'N')) AS REFER4_YN
                 , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER4_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER4_LOOKUP_YN
                 , ACI.REFER5_ID
                 , FI_COMMON_G.ID_NAME_F(ACI.REFER5_ID) AS REFER5_NAME
                 , DECODE(ACI.REFER5_ID, NULL, 'F', NVL(ACI.REFER5_YN, 'N')) AS REFER5_YN
                 , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER5_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER5_LOOKUP_YN
                 , ACI.REFER6_ID
                 , FI_COMMON_G.ID_NAME_F(ACI.REFER6_ID) AS REFER6_NAME
                 , DECODE(ACI.REFER6_ID, NULL, 'F', NVL(ACI.REFER6_YN, 'N')) AS REFER6_YN
                 , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER6_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER6_LOOKUP_YN
                 , ACI.REFER7_ID
                 , FI_COMMON_G.ID_NAME_F(ACI.REFER7_ID) AS REFER7_NAME
                 , DECODE(ACI.REFER7_ID, NULL, 'F', NVL(ACI.REFER7_YN, 'N')) AS REFER7_YN
                 , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER7_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER7_LOOKUP_YN
                 , ACI.REFER8_ID
                 , FI_COMMON_G.ID_NAME_F(ACI.REFER8_ID) AS REFER8_NAME
                 , DECODE(ACI.REFER8_ID, NULL, 'F', NVL(ACI.REFER8_YN, 'N')) AS REFER8_YN
                 , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER8_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER8_LOOKUP_YN
                 , ACI.REFER9_ID
                 , FI_COMMON_G.ID_NAME_F(ACI.REFER9_ID) AS REFER9_NAME
                 , DECODE(ACI.REFER9_ID, NULL, 'F', NVL(ACI.REFER9_YN, 'N')) AS REFER9_YN
                 , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER9_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER9_LOOKUP_YN
                 , ACI.REFER_RATE_ID
                 , FI_COMMON_G.ID_NAME_F(ACI.REFER_RATE_ID) AS REFER_RATE_NAME
                 , DECODE(ACI.REFER_RATE_ID, NULL, 'F', NVL(ACI.REFER_RATE_YN, 'N')) AS REFER_RATE_YN
                 , ACI.REFER_AMOUNT_ID
                 , FI_COMMON_G.ID_NAME_F(ACI.REFER_AMOUNT_ID) AS REFER_AMOUNT_NAME
                 , DECODE(ACI.REFER_AMOUNT_ID, NULL, 'F', NVL(ACI.REFER_AMOUNT_YN, 'N')) AS REFER_AMOUNT_YN
                 , ACI.REFER_DATE1_ID
                 , FI_COMMON_G.ID_NAME_F(ACI.REFER_DATE1_ID) AS REFER_DATE1_NAME
                 , DECODE(ACI.REFER_DATE1_ID, NULL, 'F', NVL(ACI.REFER_DATE1_YN, 'N')) AS REFER_DATE1_YN
                 , ACI.REFER_DATE2_ID
                 , FI_COMMON_G.ID_NAME_F(ACI.REFER_DATE2_ID) AS REFER_DATE2_NAME
                 , DECODE(ACI.REFER_DATE2_ID, NULL, 'F', NVL(ACI.REFER_DATE2_YN, 'N')) AS REFER_DATE2_YN
                 , ACI.VOUCH_ID
                 , FI_COMMON_G.ID_NAME_F(ACI.VOUCH_ID) AS VOUCH_NAME
                 , NVL(ACI.VOUCH_YN, 'F') AS VOUCH_YN
                 , ACI.ACCOUNT_CONTROL_ID
                 , ACI.ACCOUNT_CODE
                 , ACI.ACCOUNT_DR_CR           
              FROM FI_ACCOUNT_CONTROL_ITEM ACI
             WHERE ACI.SOB_ID                     = &W_SOB_ID
               AND EXISTS ( SELECT 'X'
                              FROM FI_AUTO_JOURNAL_LINE AJL
                             WHERE AJL.ACCOUNT_DR_CR      = ACI.ACCOUNT_DR_CR
                               AND AJL.ACCOUNT_CONTROL_ID = ACI.ACCOUNT_CONTROL_ID
                               AND AJL.SOB_ID             = ACI.SOB_ID
                               AND AJL.JOURNAL_HEADER_ID  = &W_JOURNAL_HEADER_ID
                               AND AJL.ENABLED_FLAG       = DECODE(&W_ENABLED_YN, 'Y', 'Y', AJL.ENABLED_FLAG)
                               AND AJL.EFFECTIVE_DATE_FR  <= NVL(&V_STD_DATE, AJL.EFFECTIVE_DATE_FR)
                               AND (AJL.EFFECTIVE_DATE_TO IS NULL OR AJL.EFFECTIVE_DATE_TO >= NVL(&V_STD_DATE, AJL.EFFECTIVE_DATE_TO))
                          )
            ) S_ACI
       WHERE AC.ACCOUNT_CONTROL_ID      = S_ACI.ACCOUNT_CONTROL_ID(+)
         AND AC.ACCOUNT_SET_ID          = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_SET_F(&W_SOB_ID)
         AND AC.SOB_ID                  = &W_SOB_ID
         AND EXISTS ( SELECT 'X'
                        FROM FI_AUTO_JOURNAL_LINE AJL
                       WHERE AJL.ACCOUNT_CONTROL_ID = AC.ACCOUNT_CONTROL_ID
                         AND AJL.SOB_ID             = AC.SOB_ID
                         AND AJL.JOURNAL_HEADER_ID  = &W_JOURNAL_HEADER_ID
                         AND AJL.ENABLED_FLAG       = DECODE(&W_ENABLED_YN, 'Y', 'Y', AJL.ENABLED_FLAG)
                         AND AJL.EFFECTIVE_DATE_FR  <= NVL(&V_STD_DATE, AJL.EFFECTIVE_DATE_FR)
                         AND (AJL.EFFECTIVE_DATE_TO IS NULL OR AJL.EFFECTIVE_DATE_TO >= NVL(&V_STD_DATE, AJL.EFFECTIVE_DATE_TO))
                    )
         AND AC.ENABLED_FLAG            = DECODE(&W_ENABLED_YN, 'Y', 'Y', AC.ENABLED_FLAG)
         AND AC.EFFECTIVE_DATE_FR       <= NVL(&V_STD_DATE, AC.EFFECTIVE_DATE_FR)
         AND (AC.EFFECTIVE_DATE_TO IS NULL OR AC.EFFECTIVE_DATE_TO >= NVL(&V_STD_DATE, AC.EFFECTIVE_DATE_TO))
;         
