CREATE OR REPLACE PACKAGE HRD_DAY_INTERFACE_G
AS

-- DAY INTERFACE SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_IO_FLAG                           IN HRD_ATTEND_INTERFACE.IO_FLAG%TYPE
						, W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
						, W_DEPT_ID                           IN HRD_DAY_INTERFACE.DEPT_ID%TYPE
						, W_MODIFY_YN                         IN HRD_DAY_INTERFACE.MODIFY_YN%TYPE
						, W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            );

-- DAY INTERFACE MODIFY SELECT
  PROCEDURE DATA_SELECT_MODIFY
            ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_APPROVE_STATUS                    IN HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE
						, W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
						, W_DEPT_ID                           IN HRD_DAY_INTERFACE.DEPT_ID%TYPE
						, W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            );
												
-- DAY INTERFACE LONG TYPE SELECT
  PROCEDURE DATA_SELECT_L
            ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
						, W_DEPT_ID                           IN HRD_DAY_INTERFACE.DEPT_ID%TYPE
						, W_MODIFY_YN                         IN HRD_DAY_INTERFACE.MODIFY_YN%TYPE
						, W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            );

-- DAY INTERFACE HISTORY SELECT
  PROCEDURE DATA_SELECT_H
            ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            );
						
-- DATA INSERT.
  PROCEDURE DATA_INSERT
            ( W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            );

-- DATA UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_PERSON_ID                         IN HRD_DAY_MODIFY.PERSON_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_MODIFY.WORK_DATE%TYPE
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
						, W_IO_FLAG                           IN HRD_DAY_MODIFY.IO_FLAG%TYPE
						, W_DUTY_ID                           IN HRD_WORK_CALENDAR.DUTY_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, P_MODIFY_TIME                       IN HRD_DAY_MODIFY.MODIFY_TIME%TYPE
						, P_MODIFY_TIME1                      IN HRD_DAY_MODIFY.MODIFY_TIME1%TYPE
						, P_MODIFY_ID                         IN HRD_DAY_MODIFY.MODIFY_ID%TYPE
						, P_NEXT_DAY_YN                       IN HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE
						, P_LEAVE_ID                          IN HRD_DAY_INTERFACE.LEAVE_ID%TYPE
						, P_LEAVE_TIME_CODE                   IN HRD_DAY_INTERFACE.LEAVE_TIME_CODE%TYPE
						, P_DESCRIPTION                       IN HRD_DAY_INTERFACE.DESCRIPTION%TYPE						
						, P_IO_TIME                           IN HRD_DAY_INTERFACE.OPEN_TIME%TYPE
						, P_IO_TIME1                          IN HRD_DAY_INTERFACE.OPEN_TIME1%TYPE
						, P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
            , P_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
						, O_DUTY_ID                           OUT HRM_COMMON.COMMON_ID%TYPE
						, O_DUTY_NAME                         OUT HRM_COMMON.CODE_NAME%TYPE
            );

-- DATA DELETE.
  PROCEDURE DATA_DELETE
            ( W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            );

-- DATA UPDATE - STEP APPROVE.
  PROCEDURE DATA_UPDATE_APPROVE
            ( W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
						, P_APPROVE_STATUS                    IN HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE
            , P_CHECK_YN                          IN VARCHAR2
            , P_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , P_APPROVE_FLAG                      IN VARCHAR2
            , P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
            );

-- WORK DATE TIME 정리.
  PROCEDURE WORK_DATE
            ( P_CORP_ID                               IN HRD_DUTY_PERIOD.CORP_ID%TYPE
            , P_PERSON_ID                             IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
            , P_SOB_ID                                IN HRD_DUTY_PERIOD.SOB_ID%TYPE
            , P_ORG_ID                                IN HRD_DUTY_PERIOD.ORG_ID%TYPE
            , P_START_DATE                            IN HRD_DUTY_PERIOD.START_DATE%TYPE
            , P_END_DATE                              IN HRD_DUTY_PERIOD.END_DATE%TYPE
            , O_WORK_START_DATE                       OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
            , O_WORK_END_DATE                         OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
            , O_REAL_START_DATE                       OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
            , O_REAL_END_DATE                         OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
            );

-- PROCEDURE PERIOD TIME.
  PROCEDURE LU_PERIOD_TIME
            ( P_CURSOR1                  OUT TYPES.TCURSOR1
            , W_WORK_DATE                IN HRD_DUTY_PERIOD.START_DATE%TYPE
            , W_PERSON_ID                IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
            , W_CORP_ID                  IN HRD_DUTY_PERIOD.CORP_ID%TYPE
            , W_SOB_ID                   IN HRD_DUTY_PERIOD.SOB_ID%TYPE
            , W_ORG_ID                   IN HRD_DUTY_PERIOD.ORG_ID%TYPE
            , W_WORK_TYPE                IN HRM_COMMON.VALUE1%TYPE
            , W_START_YN                 IN HRM_COMMON.VALUE1%TYPE
            , W_END_YN                   HRM_COMMON.VALUE1%TYPE
            );

-- 현재 RECORD의 상태 리턴.
  PROCEDURE APPROVE_STATUS_R
	         ( W_CORP_ID                             IN HRD_DAY_INTERFACE.CORP_ID%TYPE
					 , W_WORK_DATE                           IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
					 , W_PERSON_ID                           IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
					 , W_SOB_ID                              IN HRD_DAY_INTERFACE.SOB_ID%TYPE
					 , W_ORG_ID                              IN HRD_DAY_INTERFACE.ORG_ID%TYPE
					 , O_STATUS                              OUT HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE
					 );
					 
END HRD_DAY_INTERFACE_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRD_DAY_INTERFACE_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_DAY_INTERFACE_G
/* DESCRIPTION  : 출퇴근 등록 관리 패키지.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- DAY INTERFACE SELECT
  PROCEDURE DATA_SELECT
	          ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_IO_FLAG                           IN HRD_ATTEND_INTERFACE.IO_FLAG%TYPE
						, W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
						, W_DEPT_ID                           IN HRD_DAY_INTERFACE.DEPT_ID%TYPE
						, W_MODIFY_YN                         IN HRD_DAY_INTERFACE.MODIFY_YN%TYPE
						, W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            )
  AS
	  V_CONNECT_PERSON_ID                               HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

  BEGIN
	  -- 근태권한 설정.
    IF W_CONNECT_LEVEL = 'C' THEN
      V_CONNECT_PERSON_ID := NULL;
    ELSE
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;    
    OPEN P_CURSOR FOR
      SELECT HRM_COMMON_G.CODE_NAME_F('IO_FLAG', W_IO_FLAG, DI.SOB_ID, DI.ORG_ID) AS IO_FLAG_NAME
					 , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
					 , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
					 , HRM_COMMON_G.ID_NAME_F(T1.FLOOR_ID) AS FLOOR_NAME
					 , DI.PERSON_ID
					 , PM.DISPLAY_NAME
					 , DI.DUTY_ID
					 , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
					 , DI.HOLY_TYPE
					 , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
					 , CASE
               WHEN W_IO_FLAG = '2' AND (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y')
                 THEN NVL(O_DM.MODIFY_TIME, N_DI.CLOSE_TIME)
               WHEN W_IO_FLAG = '2' THEN NVL(O_DM.MODIFY_TIME, DI.CLOSE_TIME)
               ELSE NVL(I_DM.MODIFY_TIME, DI.OPEN_TIME)
             END AS MODIFY_TIME
           , CASE
               WHEN W_IO_FLAG = '2' AND (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y')
                 THEN N_DI.CLOSE_TIME1
               WHEN W_IO_FLAG = '2' THEN NVL(O_DM.MODIFY_TIME1, DI.CLOSE_TIME1)
               ELSE NVL(I_DM.MODIFY_TIME1, DI.OPEN_TIME1)
             END AS MODIFY_TIME1
					 , DECODE(W_IO_FLAG, '1', I_DM.MODIFY_ID, O_DM.MODIFY_ID) AS MODIFY_ID
					 , HRM_COMMON_G.ID_NAME_F(DECODE(W_IO_FLAG, '1', I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
					 , DI.NEXT_DAY_YN
					 , DI.LEAVE_ID
					 , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
					 , DI.LEAVE_TIME_CODE
					 , HRM_COMMON_G.CODE_NAME_F('LEAVE_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
					 , DI.DESCRIPTION
					 , DI.MODIFY_YN
					 , DI.MODIFY_IN_YN
					 , DI.MODIFY_OUT_YN
					 , DI.MODIFY_FLAG AS MODIFY_FLAG
					 , DI.TRANS_YN AS TRANS_YN
					 , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID) AS APPROVE_STATUS_NAME
					 , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID) AS APPROVED_PERSON_NAME
					 , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
					 , DI.WORK_DATE
					 , DI.CORP_ID					 
					 , W_IO_FLAG AS IO_FLAG
					 , S_WC.HOLY_TYPE AS PRE_HOLY_TYPE
					 , S_WC.DANGJIK_YN AS PRE_DANGJIK_YN
					 , S_WC.ALL_NIGHT_YN AS PRE_ALL_NIGHT_YN
					 , CASE
							 WHEN W_IO_FLAG = '1' THEN DI.OPEN_TIME
							 ELSE DI.CLOSE_TIME
						 END AS IO_TIME
					 , CASE
							 WHEN W_IO_FLAG = '1' THEN DI.OPEN_TIME1
							 ELSE DI.CLOSE_TIME1
						 END AS IO_TIME1
			FROM HRD_DAY_INTERFACE_V DI 
				, HRM_PERSON_MASTER PM
        , HRM_FLOOR_V HF
				, (-- 시점 인사내역.
						SELECT HL.PERSON_ID
								, HL.DEPT_ID
								, HL.POST_ID
								, HL.JOB_CATEGORY_ID
								, HL.FLOOR_ID    
						FROM HRM_HISTORY_LINE HL  
						WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
																						FROM HRM_HISTORY_LINE S_HL
																					 WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
																					   AND S_HL.PERSON_ID              = HL.PERSON_ID
																					 GROUP BY S_HL.PERSON_ID
																				 )
					) T1 
				, HRD_DAY_MODIFY I_DM
				, HRD_DAY_MODIFY O_DM
				, (-- 전일 근무 정보 조회. 
				    SELECT WC.WORK_DATE + 1 AS WORK_DATE
				         , WC.PERSON_ID
								 , WC.CORP_ID
								 , WC.SOB_ID
								 , WC.ORG_ID
								 , WC.HOLY_TYPE
								 , WC.DANGJIK_YN
								 , WC.ALL_NIGHT_YN
				    FROM HRD_WORK_CALENDAR WC
            WHERE WC.WORK_DATE      = W_WORK_DATE - 1
						  AND WC.PERSON_ID      = NVL(W_PERSON_ID, WC.PERSON_ID)
							AND WC.WORK_CORP_ID   = W_CORP_ID
							AND WC.SOB_ID         = W_SOB_ID
							AND WC.ORG_ID         = W_ORG_ID
					) S_WC						
        , (-- 후일 근무 정보 조회. 
          SELECT DIT.WORK_DATE - 1 AS WORK_DATE
               , DIT.PERSON_ID
               , DIT.CORP_ID
               , DIT.SOB_ID
               , DIT.ORG_ID
               , DIT.OPEN_TIME
               , DIT.CLOSE_TIME
               , DIT.OPEN_TIME1
               , DIT.CLOSE_TIME1
          FROM HRD_DAY_INTERFACE_TIME_V DIT
          WHERE DIT.WORK_DATE     = W_WORK_DATE + 1
            AND DIT.PERSON_ID     = NVL(W_PERSON_ID, DIT.PERSON_ID)
            AND DIT.WORK_CORP_ID  = W_CORP_ID
            AND DIT.SOB_ID        = W_SOB_ID
            AND DIT.ORG_ID        = W_ORG_ID
        ) N_DI            
			WHERE DI.PERSON_ID                          = PM.PERSON_ID
        AND PM.FLOOR_ID                           = HF.FLOOR_ID
				AND DI.WORK_CORP_ID                       = PM.WORK_CORP_ID
				AND DI.SOB_ID                             = PM.SOB_ID
				AND DI.ORG_ID                             = PM.ORG_ID
				AND PM.PERSON_ID                          = T1.PERSON_ID
				AND DI.PERSON_ID                          = I_DM.PERSON_ID(+)
				AND DI.WORK_DATE                          = I_DM.WORK_DATE(+)
				AND '1'                                   = I_DM.IO_FLAG(+)
				AND DI.PERSON_ID                          = O_DM.PERSON_ID(+)
				AND DI.WORK_DATE                          = O_DM.WORK_DATE(+)
				AND '2'                                   = O_DM.IO_FLAG(+)  
				AND DI.WORK_DATE                          = S_WC.WORK_DATE(+)
				AND DI.PERSON_ID                          = S_WC.PERSON_ID(+)
				AND DI.CORP_ID                            = S_WC.CORP_ID(+)
				AND DI.SOB_ID                             = S_WC.SOB_ID(+)
				AND DI.ORG_ID                             = S_WC.ORG_ID(+)
        AND DI.WORK_DATE                          = N_DI.WORK_DATE(+)
        AND DI.PERSON_ID                          = N_DI.PERSON_ID(+)
        AND DI.SOB_ID                             = N_DI.SOB_ID(+)
        AND DI.ORG_ID                             = N_DI.ORG_ID(+)
				AND DI.WORK_DATE                          = W_WORK_DATE
				AND DI.PERSON_ID                          = NVL(W_PERSON_ID, DI.PERSON_ID)
				AND DI.WORK_CORP_ID                       = W_CORP_ID
				AND DI.SOB_ID                             = W_SOB_ID
				AND DI.ORG_ID                             = W_ORG_ID
				AND DI.WORK_TYPE_ID                       = NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
				AND T1.DEPT_ID                            = NVL(W_DEPT_ID, T1.DEPT_ID)
				AND NVL(W_MODIFY_YN, DI.MODIFY_YN)        IN(DI.MODIFY_YN, DI.MODIFY_IN_YN, DI.MODIFY_OUT_YN)
        AND PM.ORI_JOIN_DATE                      <= W_WORK_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_WORK_DATE)
				AND EXISTS (SELECT 'X'
				              FROM HRD_DUTY_MANAGER DM
 										 WHERE DM.CORP_ID                                 = PM.WORK_CORP_ID
										   AND DM.DUTY_CONTROL_ID                         = NVL(T1.FLOOR_ID, PM.FLOOR_ID)
											 AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
											 AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
											 AND DM.START_DATE                              <= W_WORK_DATE
											 AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_WORK_DATE)
											 AND DM.SOB_ID                                  = PM.SOB_ID
											 AND DM.ORG_ID                                  = PM.ORG_ID
									 )
        ORDER BY HF.FLOOR_CODE, PM.PERSON_NUM
        ;
				
  END DATA_SELECT;

-- DAY INTERFACE MODIFY SELECT
  PROCEDURE DATA_SELECT_MODIFY
            ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_APPROVE_STATUS                    IN HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE
						, W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
						, W_DEPT_ID                           IN HRD_DAY_INTERFACE.DEPT_ID%TYPE
						, W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            )
  AS
	  V_CONNECT_PERSON_ID                           HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

  BEGIN
	  -- 근태권한 설정.
    IF W_CONNECT_LEVEL = 'C' THEN
      V_CONNECT_PERSON_ID := NULL;
    ELSE
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;    

    OPEN P_CURSOR FOR
      SELECT HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
					 , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
					 , HRM_COMMON_G.ID_NAME_F(T1.FLOOR_ID) AS FLOOR_NAME
					 , DI.PERSON_ID
					 , PM.DISPLAY_NAME
					 , DI.DUTY_ID
					 , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
					 , DI.HOLY_TYPE
					 , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME					 
           , CASE
							 WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
							 ELSE DI.OPEN_TIME
						 END AS OPEN_TIME
					 , CASE
               WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN N_DI.CLOSE_TIME
							 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
							 ELSE DI.CLOSE_TIME
						 END AS CLOSE_TIME
					 , CASE
							 WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
							 ELSE DI.OPEN_TIME1
						 END AS OPEN_TIME1
					 , CASE
               WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN N_DI.CLOSE_TIME1
							 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
							 ELSE DI.CLOSE_TIME1
						 END AS CLOSE_TIME1
					 , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_ID, NULL) AS I_MODIFY_ID
					 , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_ID, NULL)) AS I_MODIFY_DESC
					 , DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_ID, NULL) AS O_MODIFY_ID
					 , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_ID, NULL)) AS O_MODIFY_DESC
					 , DI.NEXT_DAY_YN
					 , DI.LEAVE_ID
					 , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
					 , DI.LEAVE_TIME_CODE
					 , HRM_COMMON_G.CODE_NAME_F('LEAVE_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
					 , DI.DESCRIPTION
					 , DI.TRANS_YN AS TRANS_YN
					 , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID) AS APPROVE_STATUS_NAME
					 , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID) AS APPROVED_PERSON_NAME
					 , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
					 , DI.WORK_DATE
					 , DI.CORP_ID
					 , 'N' AS CHECK_YN
			FROM HRD_DAY_INTERFACE_V DI 
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
																					 WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
																					   AND S_HL.PERSON_ID              = HL.PERSON_ID
																					 GROUP BY S_HL.PERSON_ID
																				 )
					) T1 
				, HRD_DAY_MODIFY I_DM
				, HRD_DAY_MODIFY O_DM
        , (-- 후일 근무 정보 조회. 
          SELECT DIT.WORK_DATE - 1 AS WORK_DATE
               , DIT.PERSON_ID
               , DIT.CORP_ID
               , DIT.SOB_ID
               , DIT.ORG_ID
               , DIT.OPEN_TIME
               , DIT.CLOSE_TIME
               , DIT.OPEN_TIME1
               , DIT.CLOSE_TIME1
          FROM HRD_DAY_INTERFACE_TIME_V DIT
          WHERE DIT.WORK_DATE     = W_WORK_DATE + 1
            AND DIT.PERSON_ID     = NVL(W_PERSON_ID, DIT.PERSON_ID)
            AND DIT.WORK_CORP_ID  = W_CORP_ID
            AND DIT.SOB_ID        = W_SOB_ID
            AND DIT.ORG_ID        = W_ORG_ID
        ) N_DI    
			WHERE DI.PERSON_ID                          = PM.PERSON_ID
				AND DI.WORK_CORP_ID                       = PM.WORK_CORP_ID
				AND DI.SOB_ID                             = PM.SOB_ID
				AND DI.ORG_ID                             = PM.ORG_ID
				AND PM.PERSON_ID                          = T1.PERSON_ID
				AND DI.PERSON_ID                          = I_DM.PERSON_ID(+)
				AND DI.WORK_DATE                          = I_DM.WORK_DATE(+)
				AND '1'                                   = I_DM.IO_FLAG(+)
				AND DI.PERSON_ID                          = O_DM.PERSON_ID(+)
				AND DI.WORK_DATE                          = O_DM.WORK_DATE(+)
				AND '2'                                   = O_DM.IO_FLAG(+)
        AND DI.WORK_DATE                          = N_DI.WORK_DATE(+)
        AND DI.PERSON_ID                          = N_DI.PERSON_ID(+)
        AND DI.SOB_ID                             = N_DI.SOB_ID(+)
        AND DI.ORG_ID                             = N_DI.ORG_ID(+)
				AND DI.WORK_DATE                          = W_WORK_DATE
				AND DI.PERSON_ID                          = NVL(W_PERSON_ID, DI.PERSON_ID)
				AND DI.WORK_CORP_ID                       = W_CORP_ID
				AND DI.SOB_ID                             = W_SOB_ID
				AND DI.ORG_ID                             = W_ORG_ID
				AND DI.APPROVE_STATUS                     = NVL(W_APPROVE_STATUS, DI.APPROVE_STATUS)
				AND DI.WORK_TYPE_ID                       = NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
				AND T1.DEPT_ID                            = NVL(W_DEPT_ID, T1.DEPT_ID)
				AND DI.MODIFY_FLAG                        = 'Y'
				AND EXISTS (SELECT 'X'
				              FROM HRD_DUTY_MANAGER DM
 										 WHERE DM.CORP_ID                                 = PM.WORK_CORP_ID
										   AND DM.DUTY_CONTROL_ID                         = NVL(T1.FLOOR_ID, PM.WORK_CORP_ID)
											 AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
											 AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
											 AND DM.START_DATE                              <= W_WORK_DATE
											 AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_WORK_DATE)
											 AND DM.SOB_ID                                  = PM.SOB_ID
											 AND DM.ORG_ID                                  = PM.ORG_ID
									 )
        ;
				
	END DATA_SELECT_MODIFY;
	
-- DAY INTERFACE LONG TYPE SELECT
  PROCEDURE DATA_SELECT_L
	          ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
						, W_DEPT_ID                           IN HRD_DAY_INTERFACE.DEPT_ID%TYPE
						, W_MODIFY_YN                         IN HRD_DAY_INTERFACE.MODIFY_YN%TYPE
						, W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            )
  AS
	  V_CONNECT_PERSON_ID                               HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

  BEGIN
	  -- 근태권한 설정.
		IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID
		                           , W_START_DATE => W_WORK_DATE
															 , W_END_DATE => W_WORK_DATE
															 , W_MODULE_CODE => '20'
															 , W_PERSON_ID => W_CONNECT_PERSON_ID
															 , W_SOB_ID => W_SOB_ID
															 , W_ORG_ID => W_ORG_ID) = 'C' THEN
		  V_CONNECT_PERSON_ID := NULL;
		ELSE
		  V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
		END IF;

    OPEN P_CURSOR FOR
      SELECT HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
					 , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
					 , HRM_COMMON_G.ID_NAME_F(T1.FLOOR_ID) AS FLOOR_NAME
					 , DI.PERSON_ID
					 , PM.DISPLAY_NAME
					 , DI.DUTY_ID
					 , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
					 , DI.HOLY_TYPE
					 , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
					 , CASE
							 WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
							 ELSE DI.OPEN_TIME
						 END AS OPEN_TIME
					 , CASE
               WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN N_DI.CLOSE_TIME
							 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
							 ELSE DI.CLOSE_TIME
						 END AS CLOSE_TIME
					 , CASE
							 WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
							 ELSE DI.OPEN_TIME1
						 END AS OPEN_TIME1
					 , CASE
               WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN N_DI.CLOSE_TIME1
							 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
							 ELSE DI.CLOSE_TIME1
						 END AS CLOSE_TIME1
					 , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_ID, NULL) AS I_MODIFY_ID
					 , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_ID, NULL)) AS I_MODIFY_DESC
					 , DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_ID, NULL) AS O_MODIFY_ID
					 , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_ID, NULL)) AS O_MODIFY_DESC
					 , DI.NEXT_DAY_YN
					 , DI.LEAVE_ID
					 , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
					 , DI.LEAVE_TIME_CODE
					 , HRM_COMMON_G.CODE_NAME_F('LEAVE_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
					 , DI.DESCRIPTION
					 , DI.MODIFY_YN
					 , DI.MODIFY_IN_YN
					 , DI.MODIFY_OUT_YN
					 , DI.MODIFY_FLAG AS MODIFY_FLAG
					 , DI.TRANS_YN AS TRANS_YN
					 , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID) AS APPROVE_STATUS_NAME
					 , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID) AS APPROVED_PERSON_NAME
					 , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
					 , DI.WORK_DATE
					 , DI.CORP_ID
					 , 'N' AS CHECK_YN
			FROM HRD_DAY_INTERFACE_V DI 
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
																					 WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
																					   AND S_HL.PERSON_ID              = HL.PERSON_ID
																					 GROUP BY S_HL.PERSON_ID
																				 )
					) T1 
				, HRD_DAY_MODIFY I_DM
				, HRD_DAY_MODIFY O_DM
        , (-- 후일 근무 정보 조회. 
          SELECT DIT.WORK_DATE - 1 AS WORK_DATE
               , DIT.PERSON_ID
               , DIT.CORP_ID
               , DIT.SOB_ID
               , DIT.ORG_ID
               , DIT.OPEN_TIME
               , DIT.CLOSE_TIME
               , DIT.OPEN_TIME1
               , DIT.CLOSE_TIME1
          FROM HRD_DAY_INTERFACE_TIME_V DIT
          WHERE DIT.WORK_DATE     = W_WORK_DATE + 1
            AND DIT.PERSON_ID     = NVL(W_PERSON_ID, DIT.PERSON_ID)
            AND DIT.WORK_CORP_ID  = W_CORP_ID
            AND DIT.SOB_ID        = W_SOB_ID
            AND DIT.ORG_ID        = W_ORG_ID
        ) N_DI
			WHERE DI.PERSON_ID                          = PM.PERSON_ID
				AND DI.WORK_CORP_ID                       = PM.WORK_CORP_ID
				AND DI.SOB_ID                             = PM.SOB_ID
				AND DI.ORG_ID                             = PM.ORG_ID
				AND PM.PERSON_ID                          = T1.PERSON_ID
				AND DI.PERSON_ID                          = I_DM.PERSON_ID(+)
				AND DI.WORK_DATE                          = I_DM.WORK_DATE(+)
				AND '1'                                   = I_DM.IO_FLAG(+)
				AND DI.PERSON_ID                          = O_DM.PERSON_ID(+)
				AND DI.WORK_DATE                          = O_DM.WORK_DATE(+)
				AND '2'                                   = O_DM.IO_FLAG(+)  
        AND DI.WORK_DATE                          = N_DI.WORK_DATE(+)
        AND DI.PERSON_ID                          = N_DI.PERSON_ID(+)
        AND DI.SOB_ID                             = N_DI.SOB_ID(+)
        AND DI.ORG_ID                             = N_DI.ORG_ID(+)
				AND DI.WORK_DATE                          = W_WORK_DATE
				AND DI.PERSON_ID                          = NVL(W_PERSON_ID, DI.PERSON_ID)
				AND DI.WORK_CORP_ID                       = W_CORP_ID
				AND DI.SOB_ID                             = W_SOB_ID
				AND DI.ORG_ID                             = W_ORG_ID
				AND DI.WORK_TYPE_ID                       = NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
				AND T1.DEPT_ID                            = NVL(W_DEPT_ID, T1.DEPT_ID)
				AND NVL(W_MODIFY_YN, DI.MODIFY_YN)        IN(DI.MODIFY_YN, DI.MODIFY_IN_YN, DI.MODIFY_OUT_YN)
				AND EXISTS (SELECT 'X'
				              FROM HRD_DUTY_MANAGER DM
 										 WHERE DM.CORP_ID                                 = PM.WORK_CORP_ID
										   AND DM.DUTY_CONTROL_ID                         = NVL(T1.FLOOR_ID, PM.FLOOR_ID)
											 AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
											 AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
											 AND DM.START_DATE                              <= W_WORK_DATE
											 AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_WORK_DATE)
											 AND DM.SOB_ID                                  = PM.SOB_ID
											 AND DM.ORG_ID                                  = PM.ORG_ID
									 )
        ;
				
  END DATA_SELECT_L;	

-- DAY INTERFACE HISTORY SELECT 
  PROCEDURE DATA_SELECT_H
            ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            )
  AS
	  V_CONNECT_PERSON_ID                               HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

  BEGIN
	  -- 근태권한 설정.
		IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID
		                           , W_START_DATE => W_WORK_DATE
															 , W_END_DATE => W_WORK_DATE
															 , W_MODULE_CODE => '20'
															 , W_PERSON_ID => W_CONNECT_PERSON_ID
															 , W_SOB_ID => W_SOB_ID
															 , W_ORG_ID => W_ORG_ID) = 'C' THEN
		  V_CONNECT_PERSON_ID := NULL;
		ELSE
		  V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
		END IF;

    OPEN P_CURSOR FOR
      SELECT HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
					 , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
					 , CASE
							 WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
							 ELSE DI.OPEN_TIME
						 END AS OPEN_TIME
					 , CASE
               WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN N_DI.CLOSE_TIME
							 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
							 ELSE DI.CLOSE_TIME
						 END AS CLOSE_TIME
					 , CASE
							 WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
							 ELSE DI.OPEN_TIME1
						 END AS OPEN_TIME1
					 , CASE
               WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN N_DI.CLOSE_TIME1
							 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
							 ELSE DI.CLOSE_TIME1
						 END AS CLOSE_TIME1
					 , DI.NEXT_DAY_YN
					 , DI.WORK_DATE
					 , DI.CORP_ID
					 , DI.DUTY_ID
					 , DI.HOLY_TYPE
			FROM HRD_DAY_INTERFACE_V DI 
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
																					 WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
																					   AND S_HL.PERSON_ID              = HL.PERSON_ID
																					 GROUP BY S_HL.PERSON_ID
																				 )
					) T1 
				, HRD_DAY_MODIFY I_DM
				, HRD_DAY_MODIFY O_DM
        , (-- 후일 근무 정보 조회. 
          SELECT DIT.WORK_DATE - 1 AS WORK_DATE
               , DIT.PERSON_ID
               , DIT.CORP_ID
               , DIT.SOB_ID
               , DIT.ORG_ID
               , DIT.OPEN_TIME
               , DIT.CLOSE_TIME
               , DIT.OPEN_TIME1
               , DIT.CLOSE_TIME1
          FROM HRD_DAY_INTERFACE_TIME_V DIT
          WHERE DIT.WORK_DATE     = W_WORK_DATE + 1
            AND DIT.PERSON_ID     = NVL(W_PERSON_ID, DIT.PERSON_ID)
            AND DIT.WORK_CORP_ID  = W_CORP_ID
            AND DIT.SOB_ID        = W_SOB_ID
            AND DIT.ORG_ID        = W_ORG_ID
        ) N_DI
			WHERE DI.PERSON_ID                          = PM.PERSON_ID
				AND DI.WORK_CORP_ID                       = PM.WORK_CORP_ID
				AND DI.SOB_ID                             = PM.SOB_ID
				AND DI.ORG_ID                             = PM.ORG_ID
				AND DI.PERSON_ID                          = I_DM.PERSON_ID(+)
				AND DI.WORK_DATE                          = I_DM.WORK_DATE(+)
				AND '1'                                   = I_DM.IO_FLAG(+)
				AND DI.PERSON_ID                          = O_DM.PERSON_ID(+)
				AND DI.WORK_DATE                          = O_DM.WORK_DATE(+)
				AND '2'                                   = O_DM.IO_FLAG(+)  
        AND DI.WORK_DATE                          = N_DI.WORK_DATE(+)
        AND DI.PERSON_ID                          = N_DI.PERSON_ID(+)
        AND DI.SOB_ID                             = N_DI.SOB_ID(+)
        AND DI.ORG_ID                             = N_DI.ORG_ID(+)
				AND DI.WORK_DATE                          = W_WORK_DATE
				AND DI.PERSON_ID                          = NVL(W_PERSON_ID, DI.PERSON_ID)
				AND DI.WORK_CORP_ID                       = W_CORP_ID
				AND DI.SOB_ID                             = W_SOB_ID
				AND DI.ORG_ID                             = W_ORG_ID
				AND EXISTS (SELECT 'X'
				              FROM HRD_DUTY_MANAGER DM
 										 WHERE DM.CORP_ID                                 = PM.WORK_CORP_ID
										   AND DM.DUTY_CONTROL_ID                         = T1.FLOOR_ID
											 AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
											 AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
											 AND DM.START_DATE                              <= W_WORK_DATE
											 AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_WORK_DATE)
											 AND DM.SOB_ID                                  = PM.SOB_ID
											 AND DM.ORG_ID                                  = PM.ORG_ID
									 )
        ;
	
	END DATA_SELECT_H;
	
-- DATA INSERT.
  PROCEDURE DATA_INSERT
	          ( W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            )
  AS
  BEGIN
		NULL;
			
  END DATA_INSERT;

-- DATA UPDATE.
  PROCEDURE DATA_UPDATE
	          ( W_PERSON_ID                         IN HRD_DAY_MODIFY.PERSON_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_MODIFY.WORK_DATE%TYPE
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
						, W_IO_FLAG                           IN HRD_DAY_MODIFY.IO_FLAG%TYPE
						, W_DUTY_ID                           IN HRD_WORK_CALENDAR.DUTY_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, P_MODIFY_TIME                       IN HRD_DAY_MODIFY.MODIFY_TIME%TYPE
						, P_MODIFY_TIME1                      IN HRD_DAY_MODIFY.MODIFY_TIME1%TYPE
						, P_MODIFY_ID                         IN HRD_DAY_MODIFY.MODIFY_ID%TYPE
						, P_NEXT_DAY_YN                       IN HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE
						, P_LEAVE_ID                          IN HRD_DAY_INTERFACE.LEAVE_ID%TYPE
						, P_LEAVE_TIME_CODE                   IN HRD_DAY_INTERFACE.LEAVE_TIME_CODE%TYPE
						, P_DESCRIPTION                       IN HRD_DAY_INTERFACE.DESCRIPTION%TYPE						
						, P_IO_TIME                           IN HRD_DAY_INTERFACE.OPEN_TIME%TYPE
						, P_IO_TIME1                          IN HRD_DAY_INTERFACE.OPEN_TIME1%TYPE
						, P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
            , P_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
						, O_DUTY_ID                           OUT HRM_COMMON.COMMON_ID%TYPE
						, O_DUTY_NAME                         OUT HRM_COMMON.CODE_NAME%TYPE
            )
  AS
	  V_SYSDATE                                     HRD_DAY_INTERFACE.CREATION_DATE%TYPE;
		V_APPROVE_STATUS                              HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE;
		
		V_A_DUTY_ID                                   HRM_COMMON.COMMON_ID%TYPE;
		V_NA_DUTY_ID                                  HRM_COMMON.COMMON_ID%TYPE;
		V_H_DUTY_ID                                   HRM_COMMON.COMMON_ID%TYPE;
		V_NH_DUTY_ID                                  HRM_COMMON.COMMON_ID%TYPE;
		V_PH_DUTY_ID                                  HRM_COMMON.COMMON_ID%TYPE;
		V_DUTY_ID                                     HRM_COMMON.COMMON_ID%TYPE;
		
		-- 전일 정보.
		V_PRE_HOLY_TYPE                               HRD_WORK_CALENDAR.HOLY_TYPE%TYPE;
		V_PRE_DANGJIK_YN                              HRD_WORK_CALENDAR.DANGJIK_YN%TYPE;
		V_PRE_ALL_NIGHT_YN                            HRD_WORK_CALENDAR.ALL_NIGHT_YN%TYPE;
		
		-- 금일 정보.
		V_HOLY_TYPE                                   HRD_WORK_CALENDAR.HOLY_TYPE%TYPE;
		V_DANGJIK_YN                                  HRD_WORK_CALENDAR.DANGJIK_YN%TYPE;
		V_ALL_NIGHT_YN                                HRD_WORK_CALENDAR.ALL_NIGHT_YN%TYPE;
				
		V_MODIFY_TIME                                 HRD_DAY_MODIFY.MODIFY_TIME%TYPE := NULL;
		V_MODIFY_YN                                   HRD_DAY_INTERFACE.MODIFY_YN%TYPE := 'N';
		V_MODIFY_IO_YN                                HRD_DAY_INTERFACE.MODIFY_IN_YN%TYPE := 'N';
		
	  V_NEXT_DAY_YN                                 HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE;
		
  BEGIN
	  -- 기본값 설정.(근태기본값 : 결근)
		V_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
		
		-- 현재 RECORD STATUS.
		HRD_DAY_INTERFACE_G.APPROVE_STATUS_R( W_CORP_ID => W_CORP_ID
		                                    , W_WORK_DATE => W_WORK_DATE
																				, W_PERSON_ID => W_PERSON_ID
																				, W_SOB_ID => W_SOB_ID
																				, W_ORG_ID => W_ORG_ID
																				, O_STATUS => V_APPROVE_STATUS);
    IF V_APPROVE_STATUS NOT IN('A', 'B') THEN
		  RAISE ERRNUMS.Invalid_Modify;		
		END IF;																				
		BEGIN
		  SELECT MAX(DECODE(DC.ATTEND_FLAG, 'A', DC.DUTY_ID, NULL)) AS ATTEND
					 , MAX(DECODE(DC.ATTEND_FLAG, 'NA', DC.DUTY_ID, NULL)) AS NONATTEND
					 , MAX(DECODE(DC.ATTEND_FLAG, 'H', DC.DUTY_ID, NULL)) AS HOLIDAY
					 , MAX(DECODE(DC.ATTEND_FLAG, 'NH', DC.DUTY_ID, NULL)) AS NONPAYHOLIDAY
					 , MAX(DECODE(DC.ATTEND_FLAG, 'PH', DC.DUTY_ID, NULL)) AS PAYHOLIDAY
				INTO V_A_DUTY_ID, V_NA_DUTY_ID, V_H_DUTY_ID, V_NH_DUTY_ID, V_PH_DUTY_ID
        FROM HRM_DUTY_CODE_V DC
       WHERE DC.ATTEND_FLAG                          IS NOT NULL
         AND DC.SOB_ID                               = W_SOB_ID
         AND DC.ORG_ID                               = W_ORG_ID
			;
		EXCEPTION WHEN OTHERS THEN
		  RAISE ERRNUMS.Duty_Not_Found;
		END;
		
		BEGIN
		-- 전일/금일 근무계획 조회.
			SELECT MAX(DECODE(WC.WORK_DATE, W_WORK_DATE - 1, WC.HOLY_TYPE, NULL)) AS PRE_HOLY_TYPE
					, MAX(DECODE(WC.WORK_DATE, W_WORK_DATE - 1, WC.DANGJIK_YN, NULL)) AS PRE_DANGJIK_YN
					, MAX(DECODE(WC.WORK_DATE, W_WORK_DATE - 1, WC.ALL_NIGHT_YN, NULL)) AS PRE_ALL_NIGHT_YN
					, MAX(DECODE(WC.WORK_DATE, W_WORK_DATE, WC.HOLY_TYPE, NULL)) AS HOLY_TYPE
					, MAX(DECODE(WC.WORK_DATE, W_WORK_DATE, WC.DANGJIK_YN, NULL)) AS DANGJIK_YN
					, MAX(DECODE(WC.WORK_DATE, W_WORK_DATE, WC.ALL_NIGHT_YN, NULL)) AS ALL_NIGHT_YN
			INTO V_PRE_HOLY_TYPE, V_PRE_DANGJIK_YN, V_PRE_ALL_NIGHT_YN
			   , V_HOLY_TYPE, V_DANGJIK_YN, V_ALL_NIGHT_YN
			FROM HRD_WORK_CALENDAR WC
			WHERE WC.WORK_DATE                        IN (W_WORK_DATE - 1, W_WORK_DATE)
				AND WC.WORK_CORP_ID                     = W_CORP_ID
				AND WC.SOB_ID                           = W_SOB_ID
				AND WC.ORG_ID                           = W_ORG_ID
			GROUP BY WC.PERSON_ID
					, WC.CORP_ID
					, WC.SOB_ID
					, WC.ORG_ID	
			;
		EXCEPTION WHEN OTHERS THEN
		  V_PRE_HOLY_TYPE := '2';
			V_PRE_DANGJIK_YN := 'N';
			V_PRE_ALL_NIGHT_YN := 'N';
			V_HOLY_TYPE := '2';
			V_DANGJIK_YN := 'N';
			V_ALL_NIGHT_YN := 'N';
		END;
				
		BEGIN
		-- 저장된 자료 조회.
			SELECT DI.DUTY_ID 
			    , DI.NEXT_DAY_YN
			INTO V_DUTY_ID, V_NEXT_DAY_YN
			FROM HRD_DAY_INTERFACE DI
			WHERE DI.PERSON_ID                        = W_PERSON_ID
				AND DI.WORK_DATE                        = W_WORK_DATE
				AND DI.WORK_CORP_ID                     = W_CORP_ID
				AND DI.SOB_ID                           = W_SOB_ID
				AND DI.ORG_ID                           = W_ORG_ID
			;
		EXCEPTION WHEN OTHERS THEN
		  V_DUTY_ID := V_NA_DUTY_ID;
			V_NEXT_DAY_YN := 'N';
		END;

-----------------------------------------------------------------------------------------
-- 전산 자료 조회. : 수정 시간하고 동일할 경우 출퇴근수정에 INSERT/UPDATE하지 않음.
	  IF W_IO_FLAG = '1' THEN
		  -- 근태코드 설정 **
			SELECT /*CASE
					WHEN WORKDATA_CUR.P_DUTY_CODE IN('00', '11', '53', '40') THEN*/
					CASE
					  WHEN V_HOLY_TYPE IN('0', '1') THEN
							CASE
							  WHEN (V_PRE_ALL_NIGHT_YN = 'Y' OR V_PRE_DANGJIK_YN = 'Y')
							    AND (V_ALL_NIGHT_YN = 'Y' OR V_DANGJIK_YN = 'Y' OR V_HOLY_TYPE = '3') THEN V_PH_DUTY_ID                               -- 전일철야/당직, 금일 철야
							  WHEN P_MODIFY_TIME IS NOT NULL THEN V_PH_DUTY_ID                                                                                                                                              -- 휴일근무
							  ELSE V_H_DUTY_ID                                                                                       -- 휴일
							END
					ELSE                                                                                                  -- 주간/야간
						CASE
							WHEN V_PRE_ALL_NIGHT_YN = 'Y' OR V_PRE_DANGJIK_YN = 'Y' THEN V_A_DUTY_ID       -- 전일철야/전일당직 정상근무
							WHEN (V_PRE_ALL_NIGHT_YN = 'Y' OR V_PRE_DANGJIK_YN = 'Y')
							  AND (V_ALL_NIGHT_YN = 'Y' OR V_DANGJIK_YN = 'Y') THEN V_A_DUTY_ID                             -- 전일철야/당직, 금일 철야
							WHEN P_MODIFY_TIME IS NOT NULL  THEN V_A_DUTY_ID                                       -- 출근기록 있음
							ELSE V_NA_DUTY_ID                                                                                       -- 출근기록 없음
						END
					END
				/*ELSE WORKDATA_CUR.P_DUTY_CODE
				END*/ AS DUTY_ID
				INTO V_DUTY_ID
			FROM DUAL;
					
		  IF P_MODIFY_TIME IS NULL AND P_MODIFY_TIME1 IS NULL AND P_MODIFY_ID IS NULL THEN
			  V_MODIFY_IO_YN := 'N';
				-- 기존자료 삭제.
				DELETE FROM HRD_DAY_MODIFY DM
				WHERE DM.PERSON_ID         = W_PERSON_ID
				  AND DM.WORK_DATE         = W_WORK_DATE
					AND DM.IO_FLAG           = W_IO_FLAG
					;
		  ELSIF NVL(P_IO_TIME, V_SYSDATE) = NVL(P_MODIFY_TIME, V_SYSDATE) 
			    AND NVL(P_IO_TIME1, V_SYSDATE) = NVL(P_MODIFY_TIME1, V_SYSDATE) THEN
			  V_MODIFY_IO_YN := 'N';
			ELSE
			  BEGIN
					-- 출근시간 저장.	
					UPDATE HRD_DAY_MODIFY DM
						SET DM.MODIFY_TIME                      = P_MODIFY_TIME
							, DM.MODIFY_TIME1                     = P_MODIFY_TIME1
							, DM.MODIFY_ID                        = P_MODIFY_ID
							, DM.DESCRIPTION                      = P_DESCRIPTION
							, DM.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(W_SOB_ID)
							, DM.LAST_UPDATED_BY                  = P_USER_ID
					WHERE DM.PERSON_ID                        = W_PERSON_ID
						AND DM.WORK_DATE                        = W_WORK_DATE
						AND DM.IO_FLAG                          = W_IO_FLAG
						;		 
				END;
				IF (SQL%NOTFOUND)THEN
				-- 기존 데이터 없음 --> INSERT.
					INSERT INTO HRD_DAY_MODIFY
					(PERSON_ID, WORK_DATE, IO_FLAG
					, MODIFY_TIME, MODIFY_TIME1, MODIFY_ID
					, DESCRIPTION
					, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY				
					) VALUES
					(W_PERSON_ID, W_WORK_DATE, W_IO_FLAG
					, P_MODIFY_TIME, P_MODIFY_TIME1, P_MODIFY_ID
					, P_DESCRIPTION
					, V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID				
					);
					
					V_MODIFY_IO_YN := 'Y';
				ELSE
				  V_MODIFY_IO_YN := 'Y';
				END IF;
								
			END IF;
      
			UPDATE HRD_DAY_INTERFACE DI
		    SET DI.DUTY_ID                          = V_DUTY_ID
				  , DI.MODIFY_IN_YN                     = V_MODIFY_IO_YN
					, DI.APPROVED_YN                      = DECODE(V_MODIFY_IO_YN, 'Y', 'Y', 'N')
					, DI.APPROVED_DATE                    = DECODE(V_MODIFY_IO_YN, 'Y', V_SYSDATE, NULL)
					, DI.APPROVED_PERSON_ID               = DECODE(V_MODIFY_IO_YN, 'Y', W_CONNECT_PERSON_ID, NULL)
					, DI.APPROVE_STATUS                   = DECODE(V_MODIFY_IO_YN, 'Y', 'B', 'A')
          , DI.CONFIRMED_YN                     = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', 'Y', 'N'), 'N')
          , DI.CONFIRMED_DATE                   = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', V_SYSDATE, NULL), NULL)
          , DI.CONFIRMED_PERSON_ID              = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', W_CONNECT_PERSON_ID, NULL), NULL)          
			WHERE DI.PERSON_ID                        = W_PERSON_ID
				AND DI.WORK_DATE                        = W_WORK_DATE
				AND DI.WORK_CORP_ID                     = W_CORP_ID
				AND DI.SOB_ID                           = W_SOB_ID
				AND DI.ORG_ID                           = W_ORG_ID
				;
				
-----------------------------------------------------------------------------------------			
		ELSIF W_IO_FLAG = '2' THEN
		  -- 근태코드 설정 **
		  SELECT /*CASE
					WHEN WORKDATA_CUR.P_DUTY_CODE IN('00', '11', '53', '40') THEN*/
					CASE
					  WHEN V_HOLY_TYPE IN('0', '1') THEN
							CASE
							  WHEN V_PRE_HOLY_TYPE = '3' AND TO_CHAR(P_MODIFY_TIME, 'HH24:MI') >= '09:30' THEN V_PH_DUTY_ID              -- 휴일 : 전일 야간, 금일 09:30 이후 퇴근
							  WHEN V_PRE_HOLY_TYPE = 'N' AND TO_CHAR(P_MODIFY_TIME, 'HH24:MI') >= '08:00' THEN V_PH_DUTY_ID              -- 휴일 : 전일 야간, 금일 09:30 이후 퇴근
							  WHEN V_PRE_ALL_NIGHT_YN = 'Y' AND TO_CHAR(P_MODIFY_TIME, 'HH24:MI') >= '09:30' THEN V_PH_DUTY_ID       -- 휴일 : 전일 철야, 금일 09:30 이후 퇴근
							  WHEN V_PRE_DANGJIK_YN = 'Y' AND TO_CHAR(P_MODIFY_TIME, 'HH24:MI') >= '11:00' THEN V_PH_DUTY_ID           -- 휴일 : 전일 야간, 금일 09:30 이후 퇴근                                                                                                                                          -- 휴일근무
							  ELSE V_H_DUTY_ID                                                                                       -- 휴일
							END
					ELSE V_DUTY_ID
					END
				/*ELSE WORKDATA_CUR.P_DUTY_CODE
				END*/ AS DUTY_ID
				INTO V_DUTY_ID
			FROM DUAL;

/*DBMS_OUTPUT.PUT_LINE('P_IO_TIME : ' || TO_CHAR(P_IO_TIME, 'YYYY-MM-DD HH24:MI:SS') 
                     || ', P_IO_TIME1 : ' || TO_CHAR(P_IO_TIME1, 'YYYY-MM-DD HH24:MI:SS') 
										 || ', P_MODIFY_TIME : ' || TO_CHAR(P_MODIFY_TIME, 'YYYY-MM-DD HH24:MI:SS') 
                     || ', P_MODIFY_TIME : ' || TO_CHAR(P_MODIFY_TIME1, 'YYYY-MM-DD HH24:MI:SS'));*/
			IF P_MODIFY_TIME IS NULL AND P_MODIFY_TIME1 IS NULL AND P_MODIFY_ID IS NULL THEN
			  V_MODIFY_IO_YN := 'N';
				-- 기존자료 삭제.
				DELETE FROM HRD_DAY_MODIFY DM
				WHERE DM.PERSON_ID         = W_PERSON_ID
				  AND DM.WORK_DATE         = W_WORK_DATE
					AND DM.IO_FLAG           = W_IO_FLAG
					;					
		  ELSIF NVL(P_IO_TIME, V_SYSDATE) = NVL(P_MODIFY_TIME, V_SYSDATE) 
			    AND NVL(P_IO_TIME1, V_SYSDATE) = NVL(P_MODIFY_TIME1, V_SYSDATE) THEN
			  V_MODIFY_IO_YN := 'N';
				-- 후일 퇴근 적용.
				IF P_NEXT_DAY_YN = 'Y' THEN
				  V_MODIFY_TIME := NULL;
					FOR C1 IN ( SELECT AI.DEVICE_ID
													 , AI.IO_FLAG
													 , AI.PERSON_ID
													 , AI.CARD_NUM
													 , AI.IO_DATETIME
													 , AI.IO_DATE
													 , AI.IO_TIME
													 , AI.CREATED_FLAG
												FROM HRD_ATTEND_INTERFACE AI
											 WHERE AI.PERSON_ID                               = W_PERSON_ID
												 AND AI.IO_DATE                                 = W_WORK_DATE + 1
												 AND AI.IO_FLAG                                 = W_IO_FLAG
											ORDER BY AI.IO_DATETIME
											)
					LOOP 
						IF V_MODIFY_TIME IS NULL THEN
							V_MODIFY_TIME := C1.IO_DATETIME;
						END IF;				
					END LOOP C1;				
					V_MODIFY_YN := 'Y';
				ELSE
					V_MODIFY_YN := 'N';				 
				END IF;
			ELSE
				BEGIN
					-- 퇴근시간 저장.	
					UPDATE HRD_DAY_MODIFY DM
						SET DM.MODIFY_TIME                    = P_MODIFY_TIME
							, DM.MODIFY_TIME1                   = P_MODIFY_TIME1
							, DM.MODIFY_ID                      = P_MODIFY_ID
							, DM.DESCRIPTION                    = P_DESCRIPTION
							, DM.LAST_UPDATE_DATE               = GET_LOCAL_DATE(W_SOB_ID)
							, DM.LAST_UPDATED_BY                = P_USER_ID
					WHERE DM.PERSON_ID                      = W_PERSON_ID
						AND DM.WORK_DATE                      = W_WORK_DATE
						AND DM.IO_FLAG                        = W_IO_FLAG
						;		 
				END;
				IF (SQL%NOTFOUND)THEN
				-- 기존 데이터 없음 --> INSERT.
					INSERT INTO HRD_DAY_MODIFY
					(PERSON_ID, WORK_DATE, IO_FLAG
					, MODIFY_TIME, MODIFY_TIME1, MODIFY_ID
					, DESCRIPTION
					, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY				
					) VALUES
					(W_PERSON_ID, W_WORK_DATE, W_IO_FLAG
					, P_MODIFY_TIME, P_MODIFY_TIME1, P_MODIFY_ID
					, P_DESCRIPTION
					, V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID				
					);
					V_MODIFY_IO_YN := 'Y';
				ELSE
					V_MODIFY_IO_YN := 'Y';
				END IF;
			END IF;
			
			-- 수정 FLAG.
			IF P_LEAVE_ID IS NOT NULL OR P_LEAVE_TIME_CODE IS NOT NULL THEN
			  V_MODIFY_YN := 'Y';
			END IF;
			
			UPDATE HRD_DAY_INTERFACE DI
				SET DI.CLOSE_TIME                       = NVL(DI.CLOSE_TIME, V_MODIFY_TIME)
					, DI.CLOSE_TIME1                      = DECODE(DI.CLOSE_TIME, NULL, DI.CLOSE_TIME1, V_MODIFY_TIME)
					, DI.NEXT_DAY_YN                      = P_NEXT_DAY_YN
					, DI.LEAVE_ID                         = P_LEAVE_ID
					, DI.LEAVE_TIME_CODE                  = P_LEAVE_TIME_CODE
					, DI.MODIFY_YN                        = V_MODIFY_YN
					, DI.MODIFY_OUT_YN                    = V_MODIFY_IO_YN
					, DI.APPROVED_YN                      = DECODE(V_MODIFY_YN, 'Y', 'Y', DECODE(V_MODIFY_IO_YN, 'Y', 'Y', 'N'))
					, DI.APPROVED_DATE                    = DECODE(V_MODIFY_YN, 'Y', V_SYSDATE, DECODE(V_MODIFY_IO_YN, 'Y', V_SYSDATE, NULL))
					, DI.APPROVED_PERSON_ID               = DECODE(V_MODIFY_YN, 'Y', W_CONNECT_PERSON_ID, DECODE(V_MODIFY_IO_YN, 'Y', W_CONNECT_PERSON_ID, NULL))
					, DI.APPROVE_STATUS                   = DECODE(V_MODIFY_YN, 'Y', 'B', DECODE(V_MODIFY_IO_YN, 'Y', 'B', 'A'))
					, DI.DESCRIPTION                      = P_DESCRIPTION
					, DI.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(DI.SOB_ID)
					, DI.LAST_UPDATED_BY                  = P_USER_ID
			WHERE DI.PERSON_ID                        = W_PERSON_ID
				AND DI.WORK_DATE                        = W_WORK_DATE
				AND DI.WORK_CORP_ID                     = W_CORP_ID
				AND DI.SOB_ID                           = W_SOB_ID
				AND DI.ORG_ID                           = W_ORG_ID
				;
		END IF;
	  COMMIT;
		
		-- 변경된 근태ID, 근태명 반환.
		BEGIN
		  SELECT DC.DUTY_ID, DC.DUTY_NAME
			  INTO O_DUTY_ID, O_DUTY_NAME
			FROM HRM_DUTY_CODE_V DC
			WHERE DC.DUTY_ID     = DECODE(V_MODIFY_YN, 'Y', V_DUTY_ID, DECODE(V_MODIFY_IO_YN, 'Y', V_DUTY_ID, W_DUTY_ID))
			;
		EXCEPTION WHEN OTHERS THEN
		  O_DUTY_ID := NULL;
			O_DUTY_NAME := NULL;
		END;

  EXCEPTION 
    WHEN ERRNUMS.Invalid_Modify THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Invalid_Modify_Code, ERRNUMS.Invalid_Modify_DESC);
    WHEN ERRNUMS.Duty_Not_Found THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Duty_Not_Found_Code, ERRNUMS.Duty_Not_Found_Desc);
  END DATA_UPDATE;

-- DATA DELETE.
  PROCEDURE DATA_DELETE
	          ( W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						)
  AS
	BEGIN
	  NULL;
  END DATA_DELETE;


-- DATA UPDATE - STEP APPROVE.
  PROCEDURE DATA_UPDATE_APPROVE
	          ( W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
						, P_APPROVE_STATUS                    IN HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE
            , P_CHECK_YN                          IN VARCHAR2
            , P_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , P_APPROVE_FLAG                      IN VARCHAR2
            , P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
						)
  AS
	  V_APPROVE_STATUS                              HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE := 'N';
	  D_SYSDATE                                     HRD_DAY_INTERFACE.CREATION_DATE%TYPE := NULL;

  BEGIN
    D_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
		IF P_APPROVE_STATUS = 'A' AND P_APPROVE_FLAG = 'OK' THEN
		-- 미승인 --> 1차 승인 : 승인.
			UPDATE HRD_DAY_INTERFACE DI
				SET DI.APPROVED_YN                      = DECODE(P_CHECK_YN, 'Y', 'Y', DI.APPROVED_YN)
					, DI.APPROVED_DATE                    = DECODE(P_CHECK_YN, 'Y', D_SYSDATE, DI.APPROVED_DATE)
					, DI.APPROVED_PERSON_ID               = DECODE(P_CHECK_YN, 'Y', P_CONNECT_PERSON_ID, DI.APPROVED_PERSON_ID)
					, DI.APPROVE_STATUS                   = DECODE(P_CHECK_YN, 'Y', 'B', DI.APPROVE_STATUS)
					, DI.LAST_UPDATE_DATE                 = D_SYSDATE
					, DI.LAST_UPDATED_BY                  = P_USER_ID
			WHERE DI.PERSON_ID                        = W_PERSON_ID
			  AND DI.WORK_DATE                        = W_WORK_DATE
				AND DI.WORK_CORP_ID                     = W_CORP_ID
				AND DI.SOB_ID                           = W_SOB_ID
				AND DI.ORG_ID                           = W_ORG_ID
			;

		ELSIF P_APPROVE_STATUS = 'B' AND P_APPROVE_FLAG = 'CANCEL' THEN
		-- 1차 승인 --> 미승인 : 승인 취소.
		  BEGIN
			-- 현재 상태.
			  SELECT DI.APPROVE_STATUS
				  INTO V_APPROVE_STATUS
				FROM HRD_DAY_INTERFACE DI
				WHERE DI.PERSON_ID                      = W_PERSON_ID
					AND DI.WORK_DATE                      = W_WORK_DATE
					AND DI.WORK_CORP_ID                   = W_CORP_ID
					AND DI.SOB_ID                         = W_SOB_ID
					AND DI.ORG_ID                         = W_ORG_ID
				;
			EXCEPTION WHEN OTHERS THEN
			  V_APPROVE_STATUS := 'N';
			END;
			IF V_APPROVE_STATUS <> 'B' THEN
			-- 1ST 승인단계가 아니면 오류 발생.
				RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', ':=취소'));
				RETURN;
			END IF;

			UPDATE HRD_DAY_INTERFACE DI
				SET DI.APPROVED_YN                      = DECODE(P_CHECK_YN, 'Y', 'N', DI.APPROVED_YN)
					, DI.APPROVED_DATE                    = DECODE(P_CHECK_YN, 'Y', NULL, DI.APPROVED_DATE)
					, DI.APPROVED_PERSON_ID               = DECODE(P_CHECK_YN, 'Y', NULL, DI.APPROVED_PERSON_ID)
					, DI.APPROVE_STATUS                   = DECODE(P_CHECK_YN, 'Y', 'A', DI.APPROVE_STATUS)
					, DI.LAST_UPDATE_DATE                 = D_SYSDATE
					, DI.LAST_UPDATED_BY                  = P_USER_ID
			WHERE DI.PERSON_ID                        = W_PERSON_ID
			  AND DI.WORK_DATE                        = W_WORK_DATE
				AND DI.WORK_CORP_ID                     = W_CORP_ID
				AND DI.SOB_ID                           = W_SOB_ID
				AND DI.ORG_ID                           = W_ORG_ID
			;

		ELSIF P_APPROVE_STATUS = 'B' AND P_APPROVE_FLAG = 'OK' THEN
		-- 1차 승인  --> 인사 승인: 승인.
			UPDATE HRD_DAY_INTERFACE DI
				SET DI.CONFIRMED_YN                     = DECODE(P_CHECK_YN, 'Y', 'Y', DI.CONFIRMED_YN)
					, DI.CONFIRMED_DATE                   = DECODE(P_CHECK_YN, 'Y', D_SYSDATE, DI.CONFIRMED_DATE)
					, DI.CONFIRMED_PERSON_ID              = DECODE(P_CHECK_YN, 'Y', P_CONNECT_PERSON_ID, DI.CONFIRMED_PERSON_ID)
					, DI.APPROVE_STATUS                   = DECODE(P_CHECK_YN, 'Y', 'C', DI.APPROVE_STATUS)
					, DI.LAST_UPDATE_DATE                 = D_SYSDATE
					, DI.LAST_UPDATED_BY                  = P_USER_ID
			WHERE DI.PERSON_ID                        = W_PERSON_ID
			  AND DI.WORK_DATE                        = W_WORK_DATE
				AND DI.WORK_CORP_ID                     = W_CORP_ID
				AND DI.SOB_ID                           = W_SOB_ID
				AND DI.ORG_ID                           = W_ORG_ID
			;

		ELSIF P_APPROVE_STATUS = 'C' AND P_APPROVE_FLAG = 'CANCEL' THEN
		-- 확정 승인 --> 1차 승인 : 승인 취소.
		  BEGIN
			-- 현재 상태.
			  SELECT DI.APPROVE_STATUS
				  INTO V_APPROVE_STATUS
				FROM HRD_DAY_INTERFACE DI
				WHERE DI.PERSON_ID                      = W_PERSON_ID
					AND DI.WORK_DATE                      = W_WORK_DATE
					AND DI.WORK_CORP_ID                   = W_CORP_ID
					AND DI.SOB_ID                         = W_SOB_ID
					AND DI.ORG_ID                         = W_ORG_ID
				;
			EXCEPTION WHEN OTHERS THEN
			  V_APPROVE_STATUS := 'N';
			END;
			IF V_APPROVE_STATUS <> 'C' THEN
			-- 1ST 승인단계가 아니면 오류 발생.
				RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', ':=취소'));
				RETURN;
			END IF;

			UPDATE HRD_DAY_INTERFACE DI
				SET DI.CONFIRMED_YN                     = DECODE(P_CHECK_YN, 'Y', 'N', DI.CONFIRMED_YN)
					, DI.CONFIRMED_DATE                   = DECODE(P_CHECK_YN, 'Y', NULL, DI.CONFIRMED_DATE)
					, DI.CONFIRMED_PERSON_ID              = DECODE(P_CHECK_YN, 'Y', NULL, DI.CONFIRMED_PERSON_ID)
					, DI.APPROVE_STATUS                   = 'B'
					, DI.LAST_UPDATE_DATE                 = D_SYSDATE
					, DI.LAST_UPDATED_BY                  = P_USER_ID
			WHERE DI.PERSON_ID                        = W_PERSON_ID
			  AND DI.WORK_DATE                        = W_WORK_DATE
				AND DI.WORK_CORP_ID                     = W_CORP_ID
				AND DI.SOB_ID                           = W_SOB_ID
				AND DI.ORG_ID                           = W_ORG_ID
			;

		ELSE
		-- 승인단계 선택 안함.
			RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10043', ':=승인상태:=승인상태를 선택후 다시 처리하세요'));
			RETURN;
		END IF;
		COMMIT;

	END DATA_UPDATE_APPROVE;


-- WORK DATE TIME 정리.
  PROCEDURE WORK_DATE
	          ( P_CORP_ID                               IN HRD_DUTY_PERIOD.CORP_ID%TYPE
						, P_PERSON_ID                             IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
						, P_SOB_ID                                IN HRD_DUTY_PERIOD.SOB_ID%TYPE
						, P_ORG_ID                                IN HRD_DUTY_PERIOD.ORG_ID%TYPE
						, P_START_DATE                            IN HRD_DUTY_PERIOD.START_DATE%TYPE
						, P_END_DATE                              IN HRD_DUTY_PERIOD.END_DATE%TYPE
						, O_WORK_START_DATE                       OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, O_WORK_END_DATE                         OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, O_REAL_START_DATE                       OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, O_REAL_END_DATE                         OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
						)
  AS
	  D_PLAN_START_DATE                                 HRD_WORK_CALENDAR.WORK_DATE%TYPE;
		D_PLAN_END_DATE                                   HRD_WORK_CALENDAR.WORK_DATE%TYPE;
		D_WORK_START_DATE                                 HRD_DUTY_PERIOD.WORK_START_DATE%TYPE := NULL;
		D_REAL_START_DATE                                 HRD_DUTY_PERIOD.REAL_START_DATE%TYPE := NULL;
		D_WORK_END_DATE                                   HRD_DUTY_PERIOD.WORK_END_DATE%TYPE := NULL;
		D_REAL_END_DATE                                   HRD_DUTY_PERIOD.REAL_END_DATE%TYPE := NULL;

	BEGIN

		-- WORK START DATE.
		IF TO_CHAR(P_START_DATE, 'HH24:MI') BETWEEN '00:01' AND '06:00' THEN
		  D_WORK_START_DATE := TRUNC(P_START_DATE) - 1;
		ELSE
  		D_WORK_START_DATE := TRUNC(P_START_DATE);
		END IF;
		-- WORK END DATE.
		IF TO_CHAR(P_END_DATE, 'HH24:MI') BETWEEN '00:01' AND '06:00' THEN
		  D_WORK_END_DATE := TRUNC(P_END_DATE) - 1;
		ELSE
  		D_WORK_END_DATE := TRUNC(P_END_DATE);
		END IF;
/*DBMS_OUTPUT.put_line('D_WORK_START_DATE : ' || TO_CHAR(D_WORK_START_DATE, 'YYYY-MM-DD HH24:MI') ||
                    ' D_WORK_END_DATE : ' || TO_CHAR(D_WORK_END_DATE, 'YYYY-MM-DD HH24:MI'));*/

/*-- 근무 계획 조회 START --*/
		IF TO_CHAR(P_START_DATE, 'HH24:MI') = '00:00' THEN
	    D_PLAN_START_DATE := P_START_DATE;
		ELSE
		-- 시작 근무계획 조회.
			BEGIN
				SELECT WC.OPEN_TIME
					INTO D_PLAN_START_DATE
				FROM HRD_WORK_CALENDAR WC
				WHERE WC.WORK_DATE                        = D_WORK_START_DATE
					AND WC.PERSON_ID                        = P_PERSON_ID
					AND WC.WORK_CORP_ID                     = P_CORP_ID
					AND WC.SOB_ID                           = P_SOB_ID
					AND WC.ORG_ID                           = P_ORG_ID
				;
			EXCEPTION WHEN OTHERS THEN
				D_PLAN_START_DATE := D_WORK_START_DATE;
			END;

		END IF;

		IF TO_CHAR(P_END_DATE, 'HH24:MI') = '00:00' THEN
	    D_PLAN_END_DATE := P_END_DATE;
		ELSE
		-- 종료 근무계획 조회.
			BEGIN
				SELECT WC.CLOSE_TIME
					INTO D_PLAN_END_DATE
				FROM HRD_WORK_CALENDAR WC
				WHERE WC.WORK_DATE                        = D_WORK_END_DATE
					AND WC.PERSON_ID                        = P_PERSON_ID
					AND WC.WORK_CORP_ID                     = P_CORP_ID
					AND WC.SOB_ID                           = P_SOB_ID
					AND WC.ORG_ID                           = P_ORG_ID
				;
			EXCEPTION WHEN OTHERS THEN
				D_PLAN_END_DATE := D_WORK_END_DATE;
			END;

	  END IF;
/*-- 근무 계획 조회 END --*/

/*DBMS_OUTPUT.put_line('P_START_DATE : ' || TO_CHAR(P_START_DATE, 'YYYY-MM-DD HH24:MI') ||
                    ' D_PLAN_START_DATE : ' || TO_CHAR(D_PLAN_START_DATE, 'YYYY-MM-DD HH24:MI') ||
										'P_END_DATE : ' || TO_CHAR(P_END_DATE, 'YYYY-MM-DD HH24:MI') ||
                    ' D_PLAN_END_DATE : ' || TO_CHAR(D_PLAN_END_DATE, 'YYYY-MM-DD HH24:MI'));*/
    IF P_START_DATE = D_PLAN_START_DATE AND P_END_DATE = D_PLAN_END_DATE THEN
		  D_REAL_START_DATE := NULL;
		ELSIF P_START_DATE = D_PLAN_START_DATE AND P_END_DATE <> D_PLAN_END_DATE THEN
		  D_REAL_START_DATE := P_END_DATE;
			D_REAL_END_DATE := D_PLAN_END_DATE;
		ELSE
		  D_REAL_START_DATE := D_PLAN_START_DATE;
			D_REAL_END_DATE := P_START_DATE;
		END IF;
		/*
		IF P_END_DATE = D_PLAN_END_DATE THEN
		  D_REAL_END_DATE := NULL;
		ELSE
		  D_REAL_START_DATE := P_END_DATE;
			D_REAL_END_DATE := D_PLAN_END_DATE;
		END IF;*/

		-- 일자 반환.
		O_WORK_START_DATE := D_WORK_START_DATE;
		O_WORK_END_DATE := D_WORK_END_DATE;
		O_REAL_START_DATE := D_REAL_START_DATE;
		O_REAL_END_DATE := D_REAL_END_DATE;

	END WORK_DATE;

---------------------------------------------------------------------------------------------------
-- PROCEDURE PERIOD TIME.
  PROCEDURE LU_PERIOD_TIME
						( P_CURSOR1                  OUT TYPES.TCURSOR1
						, W_WORK_DATE                IN HRD_DUTY_PERIOD.START_DATE%TYPE
						, W_PERSON_ID                IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
						, W_CORP_ID                  IN HRD_DUTY_PERIOD.CORP_ID%TYPE
						, W_SOB_ID                   IN HRD_DUTY_PERIOD.SOB_ID%TYPE
						, W_ORG_ID                   IN HRD_DUTY_PERIOD.ORG_ID%TYPE
						, W_WORK_TYPE                IN HRM_COMMON.VALUE1%TYPE
						, W_START_YN                 IN HRM_COMMON.VALUE1%TYPE
						, W_END_YN                   HRM_COMMON.VALUE1%TYPE
						)
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
		  SELECT DPT.PERIOD_TIME
			FROM HRM_DUTY_PERIOD_TIME_V DPT
				, HRD_WORK_CALENDAR WC
			WHERE DPT.HOLY_TYPE                               = WC.HOLY_TYPE
				AND WC.WORK_DATE                                = W_WORK_DATE
				AND WC.PERSON_ID                                = W_PERSON_ID
				AND WC.WORK_CORP_ID                             = W_CORP_ID
				AND WC.SOB_ID                                   = W_SOB_ID
				AND WC.ORG_ID                                   = W_ORG_ID
				AND DPT.START_YN                                = NVL(W_START_YN, DPT.START_YN)
				AND DPT.END_YN                                  = NVL(W_END_YN, DPT.END_YN)
				AND DPT.EFFECTIVE_DATE_FR                       <= W_WORK_DATE
				AND (DPT.EFFECTIVE_DATE_TO IS NULL OR DPT.EFFECTIVE_DATE_TO >= W_WORK_DATE)
			ORDER BY DPT.PERIOD_TIME
      ;

  END LU_PERIOD_TIME;

-- 현재 RECORD의 상태 리턴.
  PROCEDURE APPROVE_STATUS_R
	         ( W_CORP_ID                             IN HRD_DAY_INTERFACE.CORP_ID%TYPE
					 , W_WORK_DATE                           IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
					 , W_PERSON_ID                           IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
					 , W_SOB_ID                              IN HRD_DAY_INTERFACE.SOB_ID%TYPE
					 , W_ORG_ID                              IN HRD_DAY_INTERFACE.ORG_ID%TYPE
					 , O_STATUS                              OUT HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE
					 )
  AS
	  V_APPROVE_STATUS                               HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE := 'N';
		
	BEGIN
	  BEGIN
		-- 현재 상태.
			SELECT DI.APPROVE_STATUS
				INTO V_APPROVE_STATUS
			FROM HRD_DAY_INTERFACE DI
			WHERE DI.PERSON_ID                      = W_PERSON_ID
				AND DI.WORK_DATE                      = W_WORK_DATE
				AND DI.WORK_CORP_ID                   = W_CORP_ID
				AND DI.SOB_ID                         = W_SOB_ID
				AND DI.ORG_ID                         = W_ORG_ID
			;
		EXCEPTION WHEN OTHERS THEN
			V_APPROVE_STATUS := 'N';
		END;
	  O_STATUS := V_APPROVE_STATUS;
		
	END APPROVE_STATUS_R;
	
END HRD_DAY_INTERFACE_G;
/
