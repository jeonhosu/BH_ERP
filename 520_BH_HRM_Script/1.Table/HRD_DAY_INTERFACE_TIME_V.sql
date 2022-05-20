CREATE OR REPLACE VIEW HRD_DAY_INTERFACE_TIME_V AS
SELECT DI.PERSON_ID
     , DI.WORK_DATE
     , DI.WORK_CORP_ID
     , DI.CORP_ID
     , DI.DEPT_ID
     , DI.POST_ID
     , DI.JOB_CATEGORY_ID
     , DI.WORK_TYPE_ID
     , DI.DUTY_ID AS DUTY_ID
     , DI.HOLY_TYPE
     , NVL(I_DM.MODIFY_TIME, DI.OPEN_TIME) AS OPEN_TIME
     , NVL(O_DM.MODIFY_TIME, DI.CLOSE_TIME) AS CLOSE_TIME
     , NVL(I_DM.MODIFY_TIME1, DI.OPEN_TIME1) AS OPEN_TIME1
     , NVL(O_DM.MODIFY_TIME1, DI.CLOSE_TIME1) AS CLOSE_TIME1
     , DI.NEXT_DAY_YN
     , DI.LEAVE_ID
     , DI.LEAVE_TIME_CODE
     , DI.MODIFY_YN
     , DI.MODIFY_IN_YN
     , DI.MODIFY_OUT_YN
     , CASE
         WHEN DI.MODIFY_YN = 'Y' THEN 'Y'
         WHEN DI.MODIFY_IN_YN = 'Y' THEN 'Y'
         WHEN DI.MODIFY_OUT_YN = 'Y' THEN 'Y'
         ELSE 'N'
       END MODIFY_FLAG     
     , DI.SOB_ID
     , DI.ORG_ID     
  FROM HRD_DAY_INTERFACE DI
    , HRD_DAY_MODIFY I_DM 
    , HRD_DAY_MODIFY O_DM
WHERE DI.PERSON_ID              = I_DM.PERSON_ID(+)
  AND DI.WORK_DATE              = I_DM.WORK_DATE(+)
  AND '1'                       = I_DM.IO_FLAG(+)    
  AND DI.PERSON_ID              = O_DM.PERSON_ID(+)
  AND DI.WORK_DATE              = O_DM.WORK_DATE(+)
  AND '2'                       = O_DM.IO_FLAG(+)    