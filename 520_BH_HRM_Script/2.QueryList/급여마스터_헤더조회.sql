SELECT HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
           , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
           , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
           , HRM_COMMON_G.ID_NAME_F(HL.PAY_GRADE_ID) AS PAY_GRADE_NAME
           , PM.DISPLAY_NAME
           , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
           , PM.ORI_JOIN_DATE
           , PM.PAY_DATE
           , PM.RETIRE_DATE
           , T1.PAY_HEADER_ID
           , T1.START_YYYYMM
           , T1.END_YYYYMM
           , T1.PRINT_TYPE
           , T1.PRINT_TYPE_NAME
           , T1.BANK_ID
           , T1.BANK_NAME
           , T1.BANK_ACCOUNTS
           , T1.PAY_TYPE
           , T1.PAY_TYPE_NAME
           , NVL(T1.PAY_GRADE_ID, HL.PAY_GRADE_ID) AS PAY_GRADE_ID
           , HRM_COMMON_G.ID_NAME_F(NVL(T1.PAY_GRADE_ID, HL.PAY_GRADE_ID)) AS PAY_GRADE_NAME           
           , T1.GRADE_STEP
           , NVL(T1.CORP_CAR_YN, 'N') AS CORP_CAR_YN
           , NVL(T1.PAY_PROVIDE_YN, 'N') AS PAY_PROVIDE_YN
           , NVL(T1.BONUS_PROVIDE_YN, 'N') AS BONUS_PROVIDE_YN
           , NVL(T1.HIRE_INSUR_YN, 'N') AS HIRE_INSUR_YN
           , NVL(T1.MED_INSUR_YN, 'N') AS MED_INSUR_YN
           , NVL(T1.PENS_INSUR_YN, 'N') AS PENS_INSUR_YN
           , T1.DESCRIPTION
           , T1.LAST_UPDATE_PERSON
           , PM.PERSON_ID 
        FROM HRM_HISTORY_LINE HL  
          , HRM_PERSON_MASTER PM
          , (-- 급여 마스터 HEADER.
            SELECT PMH.PAY_HEADER_ID
                 , PMH.PERSON_ID
                 , PMH.START_YYYYMM
                 , PMH.END_YYYYMM
                 , PMH.PRINT_TYPE
                 , HRM_COMMON_G.CODE_NAME_F('PRINT_TYPE', PMH.PRINT_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PRINT_TYPE_NAME
                 , PMH.BANK_ID
                 , HRM_COMMON_G.ID_NAME_F(PMH.BANK_ID) AS BANK_NAME
                 , PMH.BANK_ACCOUNTS
                 , PMH.PAY_TYPE
                 , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', PMH.PAY_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PAY_TYPE_NAME
                 , PMH.PAY_GRADE_ID
                 , PMH.GRADE_STEP
                 , PMH.CORP_CAR_YN
                 , PMH.PAY_PROVIDE_YN
                 , PMH.BONUS_PROVIDE_YN
                 , PMH.HIRE_INSUR_YN
                 , PMH.MED_INSUR_YN
                 , PMH.PENS_INSUR_YN
                 , PMH.DESCRIPTION
                 , EAPP_USER_G.USER_NAME_F(PMH.LAST_UPDATED_BY) AS LAST_UPDATE_PERSON
              FROM HRP_PAY_MASTER_HEADER PMH
             WHERE PMH.CORP_ID              = &W_CORP_ID
              AND PMH.PERSON_ID             = NVL(&W_PERSON_ID, PMH.PERSON_ID)
              AND PMH.PAY_TYPE              = NVL(&W_PAY_TYPE, PMH.PAY_TYPE)
              AND PMH.PAY_GRADE_ID          = NVL(&W_PAY_GRADE_ID, PMH.PAY_GRADE_ID)
              AND PMH.SOB_ID                = &W_SOB_ID
              AND PMH.ORG_ID                = &W_ORG_ID  
            )T1
      WHERE HL.PERSON_ID        = PM.PERSON_ID
        AND PM.PERSON_ID        = T1.PERSON_ID(+)
        AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                      FROM HRM_HISTORY_LINE S_HL
                                     WHERE S_HL.CHARGE_DATE            <= &V_END_DATE
                                       AND S_HL.PERSON_ID              = HL.PERSON_ID
                                     GROUP BY S_HL.PERSON_ID
                                   )
        AND PM.CORP_ID          = &W_CORP_ID
        AND PM.PERSON_ID        = NVL(&W_PERSON_ID, PM.PERSON_ID)
        AND HL.DEPT_ID          = NVL(&W_DEPT_ID, HL.DEPT_ID)
        AND HL.PAY_GRADE_ID     = NVL(&W_PAY_GRADE_ID, HL.PAY_GRADE_ID)
        AND PM.ORI_JOIN_DATE    <= &V_END_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= &V_END_DATE)
        AND PM.SOB_ID           = &W_SOB_ID
        AND PM.ORG_ID           = &W_ORG_ID
      ORDER BY HL.DEPT_ID, HL.POST_ID, HL.PERSON_ID
      ;  


;
