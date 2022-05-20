SELECT  T2.FLOOR_CODE 
      , T2.FLOOR_NAME 
      , PM.NAME
      , PM.PERSON_NUM      
      , W1.HOLY_TYPE_NAME
      , HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, W1.HOLY_TYPE, W1.OPEN_TIME) AS OPEN_TIME
      , HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, W1.HOLY_TYPE, W1.CLOSE_TIME) AS CLOSE_TIME
      
      , ((HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, W1.HOLY_TYPE, W1.CLOSE_TIME) 
           - HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, W1.HOLY_TYPE, W1.OPEN_TIME)) * 24)
        - ( NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F(W1.WORK_DATE, '1', W1.OPEN_TIME, W1.CLOSE_TIME, T1.JOB_CATEGORY_CODE, PM.SOB_ID, PM.ORG_ID), 0)
          + NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F(W1.WORK_DATE, '2', W1.OPEN_TIME, W1.CLOSE_TIME, T1.JOB_CATEGORY_CODE, PM.SOB_ID, PM.ORG_ID), 0)
          + NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F(W1.WORK_DATE, '3', W1.OPEN_TIME, W1.CLOSE_TIME, T1.JOB_CATEGORY_CODE, PM.SOB_ID, PM.ORG_ID), 0)
          + NVL(HRD_DAY_LEAVE_G_SET.FOOD_DED_TIME_F(W1.WORK_DATE, '4', W1.OPEN_TIME, W1.CLOSE_TIME, T1.JOB_CATEGORY_CODE, PM.SOB_ID, PM.ORG_ID), 0)) AS WORK_TIME      
  FROM HRM_PERSON_MASTER  PM 
    ,(-- 시점 인사내역.
       SELECT HL.PERSON_ID
            , HL.POST_ID
            , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
            , HL.JOB_CATEGORY_ID
            , HRM_COMMON_G.GET_CODE_F(HL.JOB_CATEGORY_ID, &W_SOB_ID, &W_ORG_ID) AS JOB_CATEGORY_CODE
            , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
         FROM HRM_HISTORY_LINE        HL
            , HRM_JOB_CATEGORY_CODE_V JC         
        WHERE HL.JOB_CATEGORY_ID    = JC.JOB_CATEGORY_ID
          AND JC.JOB_CATEGORY_CODE  = '20'  -- 생산직 --
          AND HL.HISTORY_LINE_ID    IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                           FROM HRM_HISTORY_LINE      S_HL
                                          WHERE S_HL.PERSON_ID     =  HL.PERSON_ID
                                            AND S_HL.CHARGE_DATE  <=  &W_WORK_DATE_TO
                                         GROUP BY S_HL.PERSON_ID
                                       )
      ) T1
    , (-- 시점 인사내역.
       SELECT PH.PERSON_ID
            , PH.FLOOR_ID
            , PH.SOB_ID
            , PH.ORG_ID
            , HF.FLOOR_CODE
            , HF.FLOOR_NAME
            , HF.SORT_NUM   AS FLOOR_SORT_NUM
         FROM HRD_PERSON_HISTORY    PH
            , HRM_FLOOR_V           HF
        WHERE PH.FLOOR_ID           = HF.FLOOR_ID
          AND PH.FLOOR_ID           = &W_FLOOR_ID
          AND PH.EFFECTIVE_DATE_FR  <=  &W_WORK_DATE_TO
          AND PH.EFFECTIVE_DATE_TO  >=  &W_WORK_DATE_TO
      ) T2
    , ( -- 근태 --
        SELECT  SX1.PERSON_ID
              , SX1.WORK_DATE
              , SX1.DUTY_ID
              , SX1.DUTY_CODE
              , SX1.DUTY_NAME
              , SX1.HOLY_TYPE
              , SX1.HOLY_TYPE_NAME
              , SX1.OPEN_TIME
              , CASE
                  WHEN SX1.OPEN_TIME IS NULL 
                    AND SX1.CLOSE_TIME < TO_DATE(TO_CHAR(SX1.WORK_DATE, 'YYYY-MM-DD') || '09:00', 'YYYY-MM-DD HH24:MI')
                    AND (SX1.PRE_HOLY_TYPE = '3' OR SX1.PRE_ALL_NIGHT_YN = 'Y' OR SX1.PRE_DANGJIK_YN = 'Y') THEN NULL 
                  ELSE SX1.CLOSE_TIME
                END AS CLOSE_TIME    
          FROM ( SELECT DI.PERSON_ID
                      , DI.WORK_DATE
                      , DI.DUTY_ID
                      , HRM_COMMON_G.GET_CODE_F(DI.DUTY_ID, DI.SOB_ID, DI.ORG_ID) AS DUTY_CODE
                      , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                      , DI.HOLY_TYPE
                      , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                      , CASE
                          WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
                          ELSE DI.OPEN_TIME
                        END AS OPEN_TIME
                      , CASE
                          WHEN  CASE
                                  WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                                  ELSE DI.CLOSE_TIME1
                                END IS NOT NULL THEN  CASE
                                                        WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                                                        ELSE DI.CLOSE_TIME1
                                                      END
                          WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, N_DI.CLOSE_TIME)
                          WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                          ELSE DI.CLOSE_TIME
                        END AS CLOSE_TIME              
                      , DI.ALL_NIGHT_YN
                      , DI.DANGJIK_YN
                      , P_DI.HOLY_TYPE AS PRE_HOLY_TYPE
                      , P_DI.ALL_NIGHT_YN AS PRE_ALL_NIGHT_YN
                      , P_DI.DANGJIK_YN AS PRE_DANGJIK_YN
                   FROM HRD_DAY_INTERFACE_V DI
                      , HRM_PERSON_MASTER   PM
                      , HRD_DAY_MODIFY      I_DM
                      , HRD_DAY_MODIFY      O_DM
                      , (-- 전일 근무 정보 조회.
                          SELECT DIT.WORK_DATE + 1 AS WORK_DATE
                               , DIT.PERSON_ID
                               , DIT.HOLY_TYPE
                               , DIT.ALL_NIGHT_YN
                               , DIT.DANGJIK_YN
                          FROM HRD_DAY_INTERFACE_V DIT
                          WHERE DIT.WORK_DATE     BETWEEN &W_WORK_DATE_FR - 1 AND &W_WORK_DATE_TO
                            AND DIT.WORK_CORP_ID  = &W_CORP_ID
                            AND DIT.SOB_ID        = &W_SOB_ID
                            AND DIT.ORG_ID        = &W_ORG_ID
                        ) P_DI
                      , (-- 후일 근무 정보 조회.
                        SELECT DIT.WORK_DATE - 1 AS WORK_DATE
                             , DIT.PERSON_ID
                             , DIT.OPEN_TIME
                             , DIT.CLOSE_TIME
                             , DIT.OPEN_TIME1
                             , DIT.CLOSE_TIME1
                        FROM HRD_DAY_INTERFACE DIT
                        WHERE DIT.WORK_DATE     BETWEEN &W_WORK_DATE_FR AND &W_WORK_DATE_TO + 1
                          AND DIT.WORK_CORP_ID  = &W_CORP_ID
                          AND DIT.SOB_ID        = &W_SOB_ID
                          AND DIT.ORG_ID        = &W_ORG_ID
                      ) N_DI
                   WHERE DI.PERSON_ID               = PM.PERSON_ID
                     AND DI.PERSON_ID               = I_DM.PERSON_ID(+)
                     AND DI.WORK_DATE               = I_DM.WORK_DATE(+)
                     AND '1'                        = I_DM.IO_FLAG(+)
                     AND DI.PERSON_ID               = O_DM.PERSON_ID(+)
                     AND DI.WORK_DATE               = O_DM.WORK_DATE(+)
                     AND '2'                        = O_DM.IO_FLAG(+)
                     AND DI.WORK_DATE               = P_DI.WORK_DATE(+)
                     AND DI.PERSON_ID               = P_DI.PERSON_ID(+)
                     AND DI.WORK_DATE               = N_DI.WORK_DATE(+)
                     AND DI.PERSON_ID               = N_DI.PERSON_ID(+)
                     AND DI.WORK_DATE               BETWEEN &W_WORK_DATE_FR AND &W_WORK_DATE_TO
                     AND DI.WORK_CORP_ID            = &W_CORP_ID
                     AND DI.SOB_ID                  = &W_SOB_ID
                     AND DI.ORG_ID                  = &W_ORG_ID
                     AND PM.JOIN_DATE               <= &W_WORK_DATE_TO
                     AND (PM.RETIRE_DATE            >= &W_WORK_DATE_FR OR PM.RETIRE_DATE IS NULL)
                 ) SX1
      ) W1 
WHERE PM.PERSON_ID                = T1.PERSON_ID 
  AND PM.PERSON_ID                = T2.PERSON_ID
  AND PM.PERSON_ID                = W1.PERSON_ID(+)
  AND PM.JOIN_DATE                <= &W_WORK_DATE_TO
  AND (PM.RETIRE_DATE             >= &W_WORK_DATE_FR OR PM.RETIRE_DATE IS NULL) 
--  AND PM.DEPT_ID NOT IN ('231','236','237','258','259','270','279','332','354') 
/*GROUP BY T2.FLOOR_SORT_NUM
       , T2.FLOOR_CODE 
       , T2.FLOOR_NAME */
ORDER BY T2.FLOOR_SORT_NUM
       , T2.FLOOR_CODE 
