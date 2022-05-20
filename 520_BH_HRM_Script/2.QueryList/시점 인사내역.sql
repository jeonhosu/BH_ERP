-- 시점 인사내역.
SELECT PM.PERSON_ID
     , PM.NAME
		 , PM.JOIN_DATE
		 , PM.RETIRE_DATE
		 , PM.DEPT_ID
		 , PM.JOB_CATEGORY_ID
		 , PM.FLOOR_ID
		 
		 , SX1.DEPT_ID
		 , SX1.JOB_CATEGORY_ID
		 , SX1.FLOOR_ID
FROM HRM_PERSON_MASTER PM
  , (-- 시점 인사내역.
		SELECT HL.PERSON_ID
				, HL.DEPT_ID
				, HL.JOB_CATEGORY_ID
				, HL.FLOOR_ID    
		FROM HRM_HISTORY_LINE HL  
		WHERE HL.CHARGE_DATE      <= &W_STD_DATE
		  AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
																		FROM HRM_HISTORY_LINE S_HL
																	 WHERE S_HL.CHARGE_DATE            <= &W_STD_DATE
																	 GROUP BY S_HL.PERSON_ID
																 )																 
    ) SX1
WHERE PM.PERSON_ID              = SX1.PERSON_ID	
  AND PM.JOIN_DATE              <= &W_STD_DATE
	AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= &W_STD_DATE)
;


SELECT PM.PERSON_ID
          , PM.NAME
          , PM.DEPT_NAME
          , PM.POST_NAME
          , PM.JOB_CATEGORY_NAME    
          , &W_STD_DATE AS WORK_DATE
          , 'N' AS DANGJIK_YN
          , 'N' AS ALL_NIGHT_YN
          , TO_DATE(TO_CHAR(&W_STD_DATE + B_OST.START_ADD_DAY, 'YYYY-MM-DD') ||  ' ' || B_OST.START_TIME, 'YYYY-MM-DD HH24:MI') AS BEFORE_OT_START
          , TO_DATE(TO_CHAR(&W_STD_DATE + B_OST.END_ADD_DAY, 'YYYY-MM-DD') ||  ' ' || B_OST.END_TIME, 'YYYY-MM-DD HH24:MI') AS BEFORE_OT_END
          , TO_DATE(TO_CHAR(&W_STD_DATE + A_OST.START_ADD_DAY, 'YYYY-MM-DD') ||  ' ' || A_OST.START_TIME, 'YYYY-MM-DD HH24:MI') AS AFTER_OT_START
          , TO_DATE(TO_CHAR(&W_STD_DATE + A_OST.END_ADD_DAY, 'YYYY-MM-DD') ||  ' ' || A_OST.END_TIME, 'YYYY-MM-DD HH24:MI') AS AFTER_OT_END
          , 'N' AS LUNCH_YN
          , 'N' AS DINNER_YN
          , 'N' AS MIDNIGHT_YN
          , NULL AS DESCRIPTION
          , 0 AS LINE_SEQ
          , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', 'A', PM.SOB_ID, PM.ORG_ID) AS APPROVE_STATUS_NAME
          , 'A' APPROVE_STATUS
          , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE_NAME
          , WC.HOLY_TYPE
          , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.HOLY_TYPE, WC.SOB_ID, WC.ORG_ID) AS HOLY_NAME
          , T1.FLOOR_ID
          , PM.FLOOR_ID          
        FROM HRM_PERSON_MASTER_V1 PM
          , (-- 시점 인사내역.
            SELECT HL.PERSON_ID
                , HL.DEPT_ID
                , HL.JOB_CATEGORY_ID
                , HL.FLOOR_ID    
            FROM HRM_HISTORY_LINE HL  
            WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                            FROM HRM_HISTORY_LINE S_HL
                                           WHERE S_HL.CHARGE_DATE            <= &W_STD_DATE
                                             AND S_HL.PERSON_ID              = HL.PERSON_ID
                                           GROUP BY S_HL.PERSON_ID
                                         )
            ) T1
          , HRD_WORK_CALENDAR WC
          , HRM_WORK_TYPE_V B_WT
          , HRM_OT_STD_TIME_V B_OST
          , HRM_WORK_TYPE_V A_WT
          , HRM_OT_STD_TIME_V A_OST
       WHERE &W_STD_DATE                                = WC.WORK_DATE
         AND PM.PERSON_ID                               = T1.PERSON_ID(+)
         AND PM.PERSON_ID                               = WC.PERSON_ID
         AND PM.CORP_ID                                 = WC.CORP_ID
         AND PM.SOB_ID                                  = WC.SOB_ID
         AND PM.ORG_ID                                  = WC.ORG_ID
         AND WC.WORK_TYPE_ID                            = B_WT.WORK_TYPE_ID
         AND B_WT.WORK_TYPE_GROUP                       = NVL(B_OST.WORK_TYPE, B_WT.WORK_TYPE_GROUP)
         AND WC.HOLY_TYPE                               = B_OST.HOLY_TYPE
         AND 'B'                                        = B_OST.OT_STD_TYPE
         AND WC.WORK_TYPE_ID                            = A_WT.WORK_TYPE_ID
         AND A_WT.WORK_TYPE_GROUP                       = NVL(A_OST.WORK_TYPE, A_WT.WORK_TYPE_GROUP)
         AND WC.HOLY_TYPE                               = A_OST.HOLY_TYPE
         AND 'A'                                        = A_OST.OT_STD_TYPE
         AND PM.CORP_ID                                 = &W_CORP_ID
         AND PM.PERSON_ID                               = NVL(&W_PERSON_ID, PM.PERSON_ID)
         AND PM.WORK_TYPE_ID                            = NVL(&W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
         AND PM.SOB_ID                                  = &W_SOB_ID
         AND PM.ORG_ID                                  = &W_ORG_ID
         AND EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_MANAGER DM
                      WHERE DM.CORP_ID                  = PM.CORP_ID
                        AND DM.DUTY_CONTROL_ID          = NVL(T1.FLOOR_ID, PM.FLOOR_ID)
                        AND DM.WORK_TYPE_ID             = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
                        AND DM.SOB_ID                   = PM.SOB_ID
                        AND DM.ORG_ID                   = PM.ORG_ID
--                        AND DM.DUTY_MANAGER_ID          = &W_DUTY_MANAGER_ID
--                        AND NVL(&V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
                        AND DM.START_DATE               <= &W_STD_DATE
                        AND (DM.END_DATE IS NULL OR DM.END_DATE >= &W_STD_DATE)
                    )
         ;
