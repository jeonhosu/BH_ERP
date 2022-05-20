SELECT HM.PERSON_ID
                 , HM.CORP_ID
                 , HM.SOB_ID
                 , HM.ORG_ID
                 , NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) AS TOTAL_CREATION_NUM
                 , HM.USE_NUM AS USE_NUM
              FROM HRD_HOLIDAY_MANAGEMENT HM
             WHERE HM.CORP_ID               = &W_CORP_ID
               AND HM.PERSON_ID             = NVL(&W_PERSON_ID, HM.PERSON_ID)
               AND HM.HOLIDAY_TYPE          = '1'
               AND HM.DUTY_YEAR             = &W_STD_YEAR
               AND HM.SOB_ID                = &W_SOB_ID
               AND HM.ORG_ID                = &W_ORG_ID
