      
      SELECT T1.DEPT_ID
           , T1.DEPT_NAME
           , T1.POST_ID
           , T1.POST_NAME
           , T1.JOB_CATEGORY_ID
           , T1.JOB_CATEGORY_NAME
           , MT.PERSON_ID    
           , T1.DISPLAY_NAME
           , MT.MONTH_TOTAL_ID
           , MT.DUTY_TYPE
           , MT.DUTY_YYYYMM            
           , MT.CORP_ID
           , T1.ORI_JOIN_DATE
           , T1.JOIN_DATE
           , T1.RETIRE_DATE
           , MT.LEAVE_TIME
           , MT.LATE_TIME
           , MT.REST_TIME
           , MT.OVER_TIME
           , MT.HOLIDAY_TIME
           , MT.NIGHT_TIME
           , MT.NIGHT_BONUS_TIME
           , MT.HOLIDAY_IN_COUNT
           , MT.WEEKLY_DED_COUNT
           , MT.CHANGE_DED_COUNT
           , MT.HOLY_0_COUNT
           , MT.MONTH_TOTAL_DAY
           , MT.TOT_ATT_DAY
           , MT.TOT_DED_DAY
           , MT.PAY_DAY
           , MT.DESCRIPTION
           , MT.CLOSED_YN
           , HRM_PERSON_MASTER_G.NAME_F(MT.CLOSED_PERSON_ID) AS CLOSED_PERSON
           , MT.SOB_ID
           , MT.ORG_ID
        FROM HRD_MONTH_TOTAL MT
           , (-- 시점 인사내역.
              SELECT HL.PERSON_ID
                  , PM.NAME
                  , PM.PERSON_NUM
                  , PM.DISPLAY_NAME
                  , HL.DEPT_ID
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
                  , HL.POST_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
                  , HL.JOB_CATEGORY_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                  , HL.FLOOR_ID    
                  , HRM_COMMON_G.ID_NAME_F(HL.FLOOR_ID) AS FLOOR_NAME
                  , PM.WORK_TYPE_ID
                  , PM.CORP_ID
                  , PM.ORI_JOIN_DATE
                  , PM.JOIN_DATE
                  , PM.RETIRE_DATE
                  , PM.SOB_ID
                  , PM.ORG_ID
                FROM HRM_HISTORY_LINE HL  
                  , HRM_PERSON_MASTER PM
              WHERE HL.PERSON_ID        = PM.PERSON_ID
                AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                              FROM HRM_HISTORY_LINE S_HL
                                             WHERE S_HL.CHARGE_DATE            <= V_END_DATE
                                               AND S_HL.PERSON_ID              = HL.PERSON_ID
                                                   GROUP BY S_HL.PERSON_ID
                                                 )
             ) T1
       WHERE MT.PERSON_ID             = T1.PERSON_ID
         AND MT.CORP_ID               = T1.CORP_ID
         AND MT.SOB_ID                = T1.SOB_ID
         AND MT.ORG_ID                = T1.ORG_ID
         AND MT.DUTY_TYPE             = W_DUTY_TYPE
         AND MT.DUTY_YYYYMM           = W_DUTY_YYYYMM
         AND MT.PERSON_ID             = NVL(W_PERSON_ID, MT.PERSON_ID)
         AND MT.CORP_ID               = W_CORP_ID
         AND MT.SOB_ID                = W_SOB_ID
         AND MT.ORG_ID                = W_ORG_ID
         AND T1.DEPT_ID               = NVL(W_DEPT_ID, T1.DEPT_ID)
         AND T1.FLOOR_ID              = NVL(W_FLOOR_ID, T1.FLOOR_ID)
         AND EXISTS (SELECT 'X'
                      FROM HRD_DUTY_MANAGER DM
                      WHERE DM.CORP_ID                                = MT.CORP_ID
                       AND DM.DUTY_CONTROL_ID                         = T1.FLOOR_ID
                       AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, T1.WORK_TYPE_ID)
                       AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                       AND DM.START_DATE                              <= V_END_DATE
                       AND (DM.END_DATE IS NULL OR DM.END_DATE        >= V_END_DATE)
                       AND DM.SOB_ID                                  = MT.SOB_ID
                       AND DM.ORG_ID                                  = MT.ORG_ID
                   )
      ORDER BY T1.DEPT_ID, T1.POST_ID, T1.PERSON_ID
      ;
