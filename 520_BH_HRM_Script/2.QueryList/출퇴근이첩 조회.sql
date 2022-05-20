-- 이첩관리.
SELECT WD.WORK_DATE
		 , T1.DEPT_NAME
		 , T1.POST_NAME
		 , HRD_DUTY_MANAGER_G.MANAGER_NAME_F(WD.N_VALUE1) AS DUTY_MANAGER_NAME
		 , T1.NAME AS DUTY_MANAGER_NAME
		 , COUNT(T2.PERSON_ID) AS DAY_INTERFACE_COUNT
		 , COUNT(T3.PERSON_ID) AS DAY_LEAVE_COUNT
		 , SUM(DECODE(T3.CLOSED_YN, 'Y', 1, 0)) AS DAY_LEAVE_CLOSE_COUNT
     , 'N' AS CHECK_YN
		 , WD.N_VALUE1 AS DUTY_MANAGER_ID
  FROM HRD_WORK_DATE WD
     , (-- 시점 인사내역.
        SELECT PM.PERSON_ID
				     , HRM_PERSON_MASTER_G.NAME_F(PM.PERSON_ID) AS NAME
             , PM.CORP_ID
             , PM.SOB_ID
             , PM.ORG_ID
             , PM.WORK_TYPE_ID
             , HL.DEPT_ID
						 , HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
             , HL.POST_ID
						 , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
             , HL.FLOOR_ID
						 , HRM_COMMON_G.ID_NAME_F(HL.FLOOR_ID) AS FLOOR_NAME
          FROM HRM_HISTORY_LINE HL
             , HRM_PERSON_MASTER PM
        WHERE HL.PERSON_ID              = PM.PERSON_ID
          AND HL.CHARGE_DATE            <= &W_END_DATE
          AND HL.HISTORY_LINE_ID        IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                               FROM HRM_HISTORY_LINE S_HL
                                             WHERE S_HL.CHARGE_DATE            <= &W_END_DATE
                                             GROUP BY S_HL.PERSON_ID
                                            )
      ) T1
		, (-- 출퇴근 등록.
		    SELECT PM.CORP_ID
             , PM.SOB_ID
             , PM.ORG_ID
             , PM.WORK_TYPE_ID
             , HL.FLOOR_ID
						 , DI.WORK_DATE
						 , DI.PERSON_ID
						 , DI.TRANS_YN
          FROM HRM_HISTORY_LINE HL
             , HRM_PERSON_MASTER PM
						 , HRD_DAY_INTERFACE DI
        WHERE HL.PERSON_ID              = PM.PERSON_ID
				  AND PM.PERSON_ID              = DI.PERSON_ID
          AND HL.CHARGE_DATE            <= &W_END_DATE
          AND HL.HISTORY_LINE_ID        IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                               FROM HRM_HISTORY_LINE S_HL
                                             WHERE S_HL.CHARGE_DATE            <= &W_END_DATE
                                             GROUP BY S_HL.PERSON_ID
                                            )
          AND DI.WORK_DATE             BETWEEN &W_START_DATE AND &W_END_DATE	
		  ) T2
		, (-- 일근태  자료 조회.
		    SELECT PM.CORP_ID
             , PM.SOB_ID
             , PM.ORG_ID
             , PM.WORK_TYPE_ID
             , HL.FLOOR_ID
						 , DL.WORK_DATE
						 , DL.PERSON_ID
						 , DL.CLOSED_YN
          FROM HRM_HISTORY_LINE HL
             , HRM_PERSON_MASTER PM
						 , HRD_DAY_LEAVE DL
        WHERE HL.PERSON_ID              = PM.PERSON_ID
				  AND PM.PERSON_ID              = DL.PERSON_ID
          AND HL.CHARGE_DATE            <= &W_END_DATE
          AND HL.HISTORY_LINE_ID        IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                               FROM HRM_HISTORY_LINE S_HL
                                             WHERE S_HL.CHARGE_DATE            <= &W_END_DATE
                                             GROUP BY S_HL.PERSON_ID
                                            )
          AND DL.WORK_DATE             BETWEEN &W_START_DATE AND &W_END_DATE	
		  ) T3
WHERE WD.PERSON_ID              = T1.PERSON_ID
  AND WD.CORP_ID                = T1.CORP_ID
	AND WD.SOB_ID                 = T1.SOB_ID
	AND WD.ORG_ID                 = T1.ORG_ID
  AND WD.WORK_DATE              = T2.WORK_DATE(+)
	AND WD.CORP_ID                = T2.CORP_ID(+)
	AND WD.SOB_ID                 = T2.SOB_ID(+)
	AND WD.ORG_ID                 = T2.ORG_ID(+)
	AND WD.N_VALUE2               = T2.FLOOR_ID(+)
	AND WD.N_VALUE3               = DECODE(WD.N_VALUE3, 0, WD.N_VALUE3, T2.WORK_TYPE_ID)
  AND T2.WORK_DATE              = T3.WORK_DATE(+)
	AND T2.PERSON_ID              = T3.PERSON_ID(+)
	AND T2.CORP_ID                = T3.CORP_ID(+)
	AND T2.SOB_ID                 = T3.SOB_ID(+)
	AND T2.ORG_ID                 = T3.ORG_ID(+)
  AND WD.WORK_DATE              BETWEEN &W_START_DATE AND &W_END_DATE
	AND WD.N_VALUE1               = NVL(&W_DUTY_MANAGER_ID, WD.N_VALUE1)
	AND WD.PERSON_ID              = NVL(&W_MANAGER_ID, WD.PERSON_ID)
  AND WD.SESSION_ID             = &W_SESSION_ID
  AND WD.RUN_DATETIME           = &W_RUN_DATETIME
  AND NVL(T2.TRANS_YN, 'A')     = NVL(&W_TRANS_YN, NVL(T2.TRANS_YN, 'A'))
GROUP BY WD.N_VALUE1 
     , WD.WORK_DATE
		 , T1.DEPT_NAME
		 , T1.POST_NAME
		 , T1.FLOOR_NAME
		 , HRD_DUTY_MANAGER_G.MANAGER_NAME_F(WD.N_VALUE1) 
		 , T1.NAME	
ORDER BY WD.WORK_DATE, T1.NAME	
;
