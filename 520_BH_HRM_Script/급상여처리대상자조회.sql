
SELECT PM.PERSON_ID 
     , &W_PAY_YYYYMM
     , &W_WAGE_TYPE
     , PM.CORP_ID
     , HL.DEPT_ID 
     , HL.POST_ID
     , HL.OCPT_ID
     , HL.ABIL_ID
     , HL.JOB_CATEGORY_ID
     , PMH.PAY_TYPE
     , PMH.PAY_GRADE_ID
     , PM.JOIN_ID
     , PM.COST_CENTER_ID
     , PM.DIR_INDIR_TYPE
     , PM.EMPLOYE_TYPE
     , 'N' AS EXCEPT_TYPE
     , &W_SUPPLY_DATE
     , &W_STANDARD_DATE
     , PMH.SOB_ID
     , PMH.ORG_ID
     , get_local_date(PMH.SOB_ID) AS CREATION_DATE
     , &P_USER_ID AS CREATED_BY
     , get_local_date(PMH.SOB_ID) AS LAST_UPDATE_DATE
     , &P_USER_ID AS LAST_UPDATED_BY     
  FROM HRM_HISTORY_LINE HL  
    , HRM_PERSON_MASTER PM
    , HRP_PAY_MASTER_HEADER PMH
WHERE HL.PERSON_ID        = PM.PERSON_ID
  AND PM.PERSON_ID        = PMH.PERSON_ID
  AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                FROM HRM_HISTORY_LINE S_HL
                               WHERE S_HL.CHARGE_DATE            <= &W_END_DATE
                                 AND S_HL.PERSON_ID              = HL.PERSON_ID
                               GROUP BY S_HL.PERSON_ID
                             )
  AND PM.CORP_ID          = &W_CORP_ID
  AND PM.PERSON_ID        = NVL(&W_PERSON_ID, PM.PERSON_ID)
  AND HL.DEPT_ID          = NVL(&W_DEPT_ID, HL.DEPT_ID)
  AND PM.ORI_JOIN_DATE    <= &W_END_DATE
  AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= &W_START_DATE)
  AND PM.SOB_ID           = &W_SOB_ID
  AND PM.ORG_ID           = &W_ORG_ID
ORDER BY HL.DEPT_ID, HL.POST_ID, HL.PERSON_ID
;  
