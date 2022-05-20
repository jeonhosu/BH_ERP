SELECT DL.PERSON_ID
     , DL.WORK_DATE
		 , HRM_COMMON_G.CODE_NAME_F('WEEK', TO_CHAR(DL.WORK_DATE, 'D'), DL.SOB_ID, DL.ORG_ID) AS WORK_WEEK
     , T1.FLOOR_NAME
		 , T1.JOB_CATEGORY_NAME		 
     , DL.DUTY_ID
		 , HRM_COMMON_G.ID_NAME_F(DL.DUTY_ID) AS DUTY_NAME
		 , DL.HOLY_TYPE
		 , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DL.HOLY_TYPE, DL.SOB_ID, DL.ORG_ID) AS HOLY_TYPE_NAME
		 , DL.OPEN_TIME
		 , DL.CLOSE_TIME
		 , DL.OPEN_TIME1
		 , DL.CLOSE_TIME1
		 , DL.NEXT_DAY_YN
		 , DL.DANJIK_YN
		 , DL.ALL_NIGHT_YN
		 , DL.LEAVE_TIME
		 , DL.LATE_TIME
     , DL.REST_TIME
		 , DL.OVER_TIME
		 , DL.HOLYDAY_OT_TIME
		 , DL.NIGHT_TIME
		 , DL.NIGHT_BONUS_TIME
		 , DL.HOLIDAY_CHECK
		 , T2.HOLY_TYPE AS PRE_HOLY_TYPE
		 , T2.DANGJIK_YN AS PRE_DANGJIK_YN
     , T2.ALL_NIGHT_YN AS PRE_ALL_NIGHT_YN
		 , DL.CLOSED_YN
		 , DL.CLOSED_PERSON_ID
		 , DL.WORK_TYPE_GROUP
		 , DL.PL_OPEN_TIME
		 , DL.PL_CLOSE_TIME
		 , DL.PL_BEFORE_OT_START
		 , DL.PL_BEFORE_OT_END
		 , DL.PL_AFTER_OT_START
		 , DL.PL_AFTER_OT_END
		 , DL.PL_LUNCH_YN
		 , DL.PL_DINNER_YN
		 , DL.PL_MIDNIGHT_YN
		 , T1.ORI_JOIN_DATE
		 , T1.RETIRE_DATE
		 , T1.PERSON_NUM
  FROM HRD_DAY_LEAVE_V1 DL
		 , (-- ���� �λ系��.
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
						, PM.CORP_ID
						, PM.ORI_JOIN_DATE
						, PM.RETIRE_DATE
						, PM.SOB_ID
						, PM.ORG_ID
          FROM HRM_HISTORY_LINE HL  
				    , HRM_PERSON_MASTER PM
        WHERE HL.PERSON_ID        = PM.PERSON_ID
				  AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                        FROM HRM_HISTORY_LINE S_HL
                                       WHERE S_HL.CHARGE_DATE            <= &W_END_DATE
                                    		 AND S_HL.PERSON_ID              = HL.PERSON_ID
																			 GROUP BY S_HL.PERSON_ID
																		 )
				) T1
		  , (-- ���ϱٹ� ����.
			   SELECT P_WC.WORK_DATE + 1 AS WORK_DATE
				      , P_WC.PERSON_ID
							, P_WC.CORP_ID
							, P_WC.SOB_ID
							, P_WC.ORG_ID
							, P_WC.HOLY_TYPE
							, P_WC.DANGJIK_YN
							, P_WC.ALL_NIGHT_YN
				   FROM HRD_WORK_CALENDAR P_WC
         WHERE P_WC.WORK_DATE        BETWEEN &W_START_DATE - 1 AND &W_END_DATE
				   AND P_WC.PERSON_ID        = NVL(&W_PERSON_ID, P_WC.PERSON_ID)
					 AND P_WC.CORP_ID          = &W_CORP_ID
					 AND P_WC.SOB_ID           = &W_SOB_ID
					 AND P_WC.ORG_ID           = &W_ORG_ID
			  ) T2
WHERE DL.PERSON_ID              = T1.PERSON_ID
  AND DL.CORP_ID                = T1.CORP_ID
	AND DL.SOB_ID                 = T1.SOB_ID
	AND DL.ORG_ID                 = T1.ORG_ID
	AND DL.WORK_DATE              = T2.WORK_DATE(+)
	AND DL.PERSON_ID              = T2.PERSON_ID(+)
  AND DL.CORP_ID                = T2.CORP_ID(+)
	AND DL.SOB_ID                 = T2.SOB_ID(+)
	AND DL.ORG_ID                 = T2.ORG_ID(+)
  AND DL.WORK_DATE              BETWEEN &W_START_DATE AND &W_END_DATE
	AND DL.PERSON_ID              = NVL(&W_PERSON_ID, DL.PERSON_ID)
	AND DL.CORP_ID                = &W_CORP_ID
	AND DL.SOB_ID                 = &W_SOB_ID
	AND DL.ORG_ID                 = &W_ORG_ID
	AND DL.CLOSED_YN              = NVL(&W_CLOSE_YN, DL.CLOSED_YN)
	AND DL.HOLY_TYPE              = NVL(&W_HOLY_TYPE, DL.HOLY_TYPE)
	AND DL.DUTY_ID                = NVL(&W_DUTY_ID, DL.DUTY_ID)
	AND T1.FLOOR_ID               = NVL(&W_FLOOR_ID, T1.FLOOR_ID)
	AND T1.DEPT_ID                = NVL(&W_DEPT_ID, T1.DEPT_ID)
	AND T1.JOB_CATEGORY_ID        = NVL(&W_JOB_CATEGORY_ID, T1.JOB_CATEGORY_ID)
	AND EXISTS ( SELECT 'X'
	               FROM HRD_DAY_INTERFACE_V DI
								WHERE DI.WORK_DATE                        = DL.WORK_DATE
								  AND DI.PERSON_ID                        = DL.PERSON_ID
									AND DI.CORP_ID                          = DL.CORP_ID
									AND DI.SOB_ID                           = DL.SOB_ID
									AND DI.ORG_ID                           = DL.ORG_ID
									AND DI.MODIFY_FLAG                      = NVL(&W_MODIFY_FLAG, DI.MODIFY_FLAG)
							)		
ORDER BY DL.WORK_DATE, DL.HOLY_TYPE	
;
