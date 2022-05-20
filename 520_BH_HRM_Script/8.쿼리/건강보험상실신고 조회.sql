-- 1. 삭제 
  DELETE FROM HRA_SALARY_TOTAL ST
    WHERE ST.PERIOD_NAME          = &W_PERIOD_NAME
      AND ST.SOB_ID               = &W_SOB_ID 
      AND ST.ORG_ID               = &W_ORG_ID 
  ;
 
               
-- 2. 대상 산출     
INSERT INTO HRA_SALARY_TOTAL 
( PERIOD_NAME 
, SOB_ID 
, ORG_ID 
, PERSON_ID 
, OPERATING_UNIT_ID 
, DEPT_ID 
, FLOOR_ID 
, POST_ID 
, JOB_CATEGORY_ID 
, EMPLOYE_TYPE 
, LONG_DAY 
, CREATION_DATE 
, CREATED_BY 
, LAST_UPDATE_DATE 
, LAST_UPDATED_BY 
)          
SELECT  &W_PERIOD_NAME
      , &W_SOB_ID 
      , &W_ORG_ID 
      , PM.PERSON_ID 
      , T1.OPERATING_UNIT_ID  
      , T1.DEPT_ID 
      , T1.FLOOR_ID  
      , T1.POST_ID 
      , T1.JOB_CATEGORY_ID  
      , CASE
          WHEN HRM_ADMINISTRATIVE_LEAVE_G.CHECK_ADMINISTRATIVE_LEAVE_F(&V_DATE_END, PM.PERSON_ID, PM.SOB_ID, PM.ORG_ID) = '2' THEN '2'
          ELSE PM.EMPLOYE_TYPE
        END EMPLOYE_TYPE
      , HRM_COMMON_DATE_G.PERIOD_DAY_F(PM.JOIN_DATE, 
                                       CASE
                                         WHEN PM.RETIRE_DATE IS NULL THEN &V_DATE_END 
                                         WHEN &V_DATE_END  <= NVL(PM.RETIRE_DATE, &V_DATE_END) THEN &V_DATE_END 
                                         WHEN PM.RETIRE_DATE IS NOT NULL THEN PM.RETIRE_DATE 
                                         ELSE &V_DATE_END 
                                       END,
                                       1) AS LONG_DAY  
      , SYSDATE
      , -1 AS USER_ID 
      , SYSDATE
      , -2 AS USER_ID 
  FROM HRM_PERSON_MASTER         PM
     , HRM_CORP_MASTER           CM                  
     , (-- 시점 인사내역.
      SELECT HL.PERSON_ID
           , HL.OPERATING_UNIT_ID  
           , HL.DEPT_ID
           , HL.POST_ID
           , HL.PAY_GRADE_ID
           , HL.FLOOR_ID
           , HL.JOB_CATEGORY_ID
        FROM HRM_HISTORY_HEADER HH
           , HRM_HISTORY_LINE   HL 
       WHERE HH.HISTORY_HEADER_ID   = HL.HISTORY_HEADER_ID
         AND HH.CHARGE_SEQ          IN 
              (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                  FROM HRM_HISTORY_HEADER S_HH
                     , HRM_HISTORY_LINE   S_HL
                 WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                   AND S_HH.CHARGE_DATE       <= &V_DATE_END
                   AND S_HL.PERSON_ID         = HL.PERSON_ID
                 GROUP BY S_HL.PERSON_ID
               ) 
      ) T1
 WHERE PM.CORP_ID             =  CM.CORP_ID
   AND PM.PERSON_ID           =  T1.PERSON_ID
   AND PM.SOB_ID              =  &W_SOB_ID
   AND PM.ORG_ID              =  &W_ORG_ID
   AND ((&W_CORP_ID            IS NULL AND 1 = 1)
   OR   (&W_CORP_ID            IS NOT NULL AND PM.CORP_ID = &W_CORP_ID)) 
   AND ((&W_DEPT_ID            IS NULL AND 1 = 1)
   OR   (&W_DEPT_ID            IS NOT NULL AND T1.DEPT_ID = &W_DEPT_ID)) 
   AND ((&W_FLOOR_ID           IS NULL AND 1 = 1)
   OR   (&W_FLOOR_ID           IS NOT NULL AND T1.FLOOR_ID = &W_FLOOR_ID))
   AND PM.JOIN_DATE           <= &V_DATE_END 
   AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= TRUNC(TO_DATE(&W_PERIOD_NAME, 'YYYY-MM')))
   AND ((&W_EMPLOYE_TYPE       IS NULL AND 1 = 1)
   OR   (&W_EMPLOYE_TYPE       != '3' AND 1 = 1)
   OR   (&W_EMPLOYE_TYPE       = '3' AND PM.RETIRE_DATE BETWEEN TRUNC(TO_DATE(&W_PERIOD_NAME, 'YYYY-MM'))
                                                            AND &V_DATE_END))
 --ORDER BY PM.PERSON_NUM
;

SELECT *
  FROM HRA_SALARY_TOTAL
  ;
  
 --HRM_COMMON_DATE_G.PERIOD_MONTH_F(W_RETIRE_DATE_FR, (W_RETIRE_DATE_TO + NVL(V_CHANGE_DAY, 0)), 'CEIL')
