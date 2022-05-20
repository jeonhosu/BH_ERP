-- 관리직 연장 시간 초기화.
SELECT PM.NAME
     , PM.JOB_CATEGORY_NAME
     , DL.DAY_LEAVE_ID
  FROM HRD_DAY_LEAVE DL
    , HRM_PERSON_MASTER_V1 PM
WHERE DL.PERSON_ID         = PM.PERSON_ID
  AND DL.WORK_DATE   BETWEEN &W_WORK_DATE_FR AND &W_WORK_DATE_TO
  AND DL.WORK_CORP_ID = 25
  AND DL.SOB_ID      = &W_SOB_ID
  AND DL.ORG_ID      = &W_ORG_ID
  AND EXISTS ( SELECT 'X'
                 FROM HRM_JOB_CATEGORY_CODE_V JC
               WHERE JC.JOB_CATEGORY_ID       = DL.JOB_CATEGORY_ID
                 AND JC.JOB_CATEGORY_CODE     = '10'
             )
;

SELECT *
  FROM HRD_DAY_LEAVE_OT DLO
WHERE DLO.OT_TYPE = '14'
  AND DLO.DAY_LEAVE_ID IN ( SELECT DL.DAY_LEAVE_ID
                  FROM HRD_DAY_LEAVE DL
                    , HRM_PERSON_MASTER_V1 PM
                WHERE DL.PERSON_ID         = PM.PERSON_ID
                  AND DL.WORK_DATE   BETWEEN &W_WORK_DATE_FR AND &W_WORK_DATE_TO
                  AND DL.WORK_CORP_ID = 25
                  AND DL.SOB_ID      = &W_SOB_ID
                  AND DL.ORG_ID      = &W_ORG_ID
                  AND EXISTS ( SELECT 'X'
                                 FROM HRM_JOB_CATEGORY_CODE_V JC
                               WHERE JC.JOB_CATEGORY_ID       = DL.JOB_CATEGORY_ID
                                 AND JC.JOB_CATEGORY_CODE     = '10'
                             )
               )
FOR UPDATE               
               ;
/*16
17
12
11
13
15
14*/



SELECT PM.JOB_CATEGORY_NAME
     , PM.NAME
     , DLO.*
  FROM HRD_DAY_LEAVE_OT DLO
    , HRM_PERSON_MASTER_V1 PM
WHERE DLO.PERSON_ID     = PM.PERSON_ID
  AND DLO.OT_TYPE = '16'
  AND DLO.DAY_LEAVE_ID IN ( SELECT DL.DAY_LEAVE_ID
                  FROM HRD_DAY_LEAVE DL
                    , HRM_PERSON_MASTER_V1 PM
                WHERE DL.PERSON_ID         = PM.PERSON_ID
                  AND DL.WORK_DATE   BETWEEN &W_WORK_DATE_FR AND &W_WORK_DATE_TO
                  AND DL.WORK_CORP_ID = 25
                  AND DL.SOB_ID      = &W_SOB_ID
                  AND DL.ORG_ID      = &W_ORG_ID
                  AND EXISTS ( SELECT 'X'
                                 FROM HRM_JOB_CATEGORY_CODE_V JC
                               WHERE JC.JOB_CATEGORY_ID       = DL.JOB_CATEGORY_ID
                                 AND JC.JOB_CATEGORY_CODE     = '10'
                             )
               )
               ;
/*16
17
12
11
13
15
14*/
                        

SELECT /*PM.JOB_CATEGORY_NAME
     , PM.NAME
     , DLO.**/
     DISTINCT DLO.OT_TYPE
  FROM HRD_MONTH_TOTAL_OT DLO
    , HRM_PERSON_MASTER_V1 PM
WHERE DLO.PERSON_ID     = PM.PERSON_ID
--  AND DLO.OT_TYPE = '14'
  AND DLO.MONTH_TOTAL_ID IN ( SELECT MT.MONTH_TOTAL_ID
                  FROM HRD_MONTH_TOTAL MT
                    , HRM_PERSON_MASTER_V1 PM
                WHERE MT.PERSON_ID         = PM.PERSON_ID
                  AND MT.DUTY_TYPE         = 'D2'
                  AND MT.DUTY_YYYYMM       = '2011-04'
                  AND MT.WORK_CORP_ID = 25
                  AND MT.SOB_ID      = &W_SOB_ID
                  AND MT.ORG_ID      = &W_ORG_ID
                  AND EXISTS ( SELECT 'X'
                                 FROM HRM_JOB_CATEGORY_CODE_V JC
                               WHERE JC.JOB_CATEGORY_ID       = MT.JOB_CATEGORY_ID
                                 AND JC.JOB_CATEGORY_CODE     = '10'
                             )
               )
               ;        

SELECT DLO.*
  FROM HRD_MONTH_TOTAL_OT DLO
WHERE DLO.OT_TYPE = '14'
  AND DLO.MONTH_TOTAL_ID IN ( SELECT MT.MONTH_TOTAL_ID
                  FROM HRD_MONTH_TOTAL MT
                    , HRM_PERSON_MASTER_V1 PM
                WHERE MT.PERSON_ID         = PM.PERSON_ID
                  AND MT.DUTY_TYPE         = 'D2'
                  AND MT.DUTY_YYYYMM       = '2011-04'
                  AND MT.WORK_CORP_ID = 25
                  AND MT.SOB_ID      = &W_SOB_ID
                  AND MT.ORG_ID      = &W_ORG_ID
                  AND EXISTS ( SELECT 'X'
                                 FROM HRM_JOB_CATEGORY_CODE_V JC
                               WHERE JC.JOB_CATEGORY_ID       = MT.JOB_CATEGORY_ID
                                 AND JC.JOB_CATEGORY_CODE     = '10'
                             )
               )
FOR UPDATE               
               ;                
