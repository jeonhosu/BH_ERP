SELECT PM.PERSON_ID
     , PM.PERSON_NUM
     , PM.NAME
     , DM.DEPT_NAME
     , PC.POST_NAME
     , HRM_COMMON_G.CODE_NAME_F('PRINT_TYPE', PMH.PRINT_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PRINT_TYPE_NAME
     , PMH.BANK_ID
     , HRM_COMMON_G.ID_NAME_F(PMH.BANK_ID) AS BANK_NAME
     , PMH.BANK_ACCOUNTS
     , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', PMH.PAY_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PAY_TYPE_NAME
     , PMH.PAY_PROVIDE_YN
     , PMH.BONUS_PROVIDE_YN
     , PMH.START_YYYYMM
     , PMH.END_YYYYMM
     , PMH.DESCRIPTION
     , EAPP_USER_G.USER_NAME_F(PMH.LAST_UPDATED_BY) AS LAST_UPDATE_PERSON
  FROM HRP_PAY_MASTER_HEADER PMH
    , HRM_PERSON_MASTER PM
    , (-- 시점 인사내역.
        SELECT HL.PERSON_ID
            , HL.DEPT_ID
            , HL.POST_ID
            , HL.JOB_CATEGORY_ID
            , HL.FLOOR_ID    
        FROM HRM_HISTORY_LINE HL  
        WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                        FROM HRM_HISTORY_LINE S_HL
                                       WHERE S_HL.CHARGE_DATE            <= LAST_DAY(TO_DATE(&W_STD_YYYYMM, 'YYYY-MM'))
                                         AND S_HL.PERSON_ID              = HL.PERSON_ID
                                       GROUP BY S_HL.PERSON_ID
                                     )
      ) T1 
    , HRM_DEPT_MASTER DM
    , HRM_POST_CODE_V PC
WHERE PMH.PERSON_ID            = PM.PERSON_ID 
  AND PM.PERSON_ID             = T1.PERSON_ID
  AND T1.DEPT_ID               = DM.DEPT_ID
  AND T1.POST_ID               = PC.POST_ID
  AND PMH.CORP_ID              = &W_CORP_ID
  AND PMH.PERSON_ID             = NVL(&W_PERSON_ID, PMH.PERSON_ID)
  AND PMH.PAY_TYPE              = NVL(&W_PAY_TYPE, PMH.PAY_TYPE)
  AND PMH.PAY_GRADE_ID          = NVL(&W_PAY_GRADE_ID, PMH.PAY_GRADE_ID)
  AND PMH.SOB_ID                = &W_SOB_ID
  AND PMH.ORG_ID                = &W_ORG_ID
  AND PMH.START_YYYYMM          <= &W_STD_YYYYMM
  AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= &W_STD_YYYYMM)
  AND PM.ORI_JOIN_DATE          <= LAST_DAY(TO_DATE(&W_STD_YYYYMM, 'YYYY-MM'))
  AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= TRUNC(TO_DATE(&W_STD_YYYYMM, 'YYYY-MM')))
ORDER BY DM.DEPT_SORT_NUM, DM.DEPT_CODE, PC.SORT_NUM, PC.POST_CODE, PM.PERSON_NUM
;
