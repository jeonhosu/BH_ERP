CREATE OR REPLACE PACKAGE HRD_DAY_INTERFACE_TRANS_G
AS

-- DAY INTERFACE TRANS LIST SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_MODIFY_YN                         IN HRD_DAY_INTERFACE.MODIFY_YN%TYPE
						, W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
						, W_FLOOR_ID                          IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
						, W_TRANS_YN                          IN HRD_DAY_INTERFACE.TRANS_YN%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            );

-- 비고사항 저장.
  PROCEDURE DATA_UPDATE
            ( W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            , P_NEXT_DAY_YN                       IN HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE
            , P_DESCRIPTION                       IN HRD_DAY_INTERFACE.DESCRIPTION%TYPE
            , P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE              
            );
              
-- DAY INTERFACE TRANS MANAGER SELECT
  PROCEDURE DATA_TRANS_MANAGER
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_END_DATE                          IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_TRANS_YN                          IN HRD_DAY_INTERFACE.TRANS_YN%TYPE
						, W_DUTY_MANAGER_ID                   IN HRD_DUTY_MANAGER.DUTY_MANAGER_ID%TYPE
            , W_MANAGER_ID                        IN HRD_DUTY_MANAGER.MANAGER_ID1%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            );
						
-- DAY INTERFACE TRANS CANCEL
  PROCEDURE DATA_TRANS_CANCEL
            ( W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_DUTY_MANAGER_ID                   IN HRD_DUTY_MANAGER.DUTY_MANAGER_ID%TYPE
						, P_CHECK_YN                          IN HRD_DAY_INTERFACE.TRANS_YN%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            );						
						

-- DAY INTERFACE TRANSFER MAIN.
  PROCEDURE DATA_TRANSFER_MAIN
            ( W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            , W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
            , W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
						, W_CAP_CHECK_YN                      IN VARCHAR2
						, P_USER_ID                           IN HRD_DAY_LEAVE.CREATED_BY%TYPE
            );

-- DAY INTERFACE TRANSFER GO1.
  PROCEDURE DATA_TRANSFER_GO1
            ( W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            , W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
            , W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
						, P_USER_ID                           IN HRD_DAY_LEAVE.CREATED_BY%TYPE
            );						

END HRD_DAY_INTERFACE_TRANS_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRD_DAY_INTERFACE_TRANS_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_DAY_INTERFACE_TRANS_G
/* DESCRIPTION  : 출퇴근내역 이첩 / 이첩 취소 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- DAY INTERFACE TRANS LIST SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_MODIFY_YN                         IN HRD_DAY_INTERFACE.MODIFY_YN%TYPE
						, W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
						, W_FLOOR_ID                          IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
						, W_TRANS_YN                          IN HRD_DAY_INTERFACE.TRANS_YN%TYPE
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
               WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, N_DI.CLOSE_TIME)
							 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
							 ELSE DI.CLOSE_TIME
						 END AS CLOSE_TIME
					 , CASE
							 WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
							 ELSE DI.OPEN_TIME1
						 END AS OPEN_TIME1
					 , CASE
              /* WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME1, N_DI.CLOSE_TIME1)*/
							 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
							 ELSE DI.CLOSE_TIME1
						 END AS CLOSE_TIME1
					 , DI.NEXT_DAY_YN
           , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_ID, NULL) AS I_MODIFY_ID
					 , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_ID, NULL)) AS I_MODIFY_DESC
					 , DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_ID, NULL) AS O_MODIFY_ID
					 , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_ID, NULL)) AS O_MODIFY_DESC					 
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
					 , DI.WORK_CORP_ID CORP_ID
			FROM HRD_DAY_INTERFACE_V DI 
				, HRM_PERSON_MASTER PM
        , HRM_FLOOR_V HF
        , HRM_POST_CODE_V PC
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
          FROM HRD_DAY_INTERFACE DIT
          WHERE DIT.WORK_DATE     = W_WORK_DATE + 1
            AND DIT.PERSON_ID     = NVL(W_PERSON_ID, DIT.PERSON_ID)
            AND DIT.WORK_CORP_ID  = W_CORP_ID
            AND DIT.SOB_ID        = W_SOB_ID
            AND DIT.ORG_ID        = W_ORG_ID
        ) N_DI    
			WHERE DI.PERSON_ID                          = PM.PERSON_ID
        AND PM.FLOOR_ID                           = HF.FLOOR_ID
        AND PM.POST_ID                            = PC.POST_ID
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
				AND DI.WORK_CORP_ID                       = W_CORP_ID
				AND DI.SOB_ID                             = W_SOB_ID
				AND DI.ORG_ID                             = W_ORG_ID
        AND DI.PERSON_ID                          = NVL(W_PERSON_ID, DI.PERSON_ID)				
				AND DI.WORK_TYPE_ID                       = NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
				AND T1.FLOOR_ID                           = NVL(W_FLOOR_ID, T1.FLOOR_ID)
				AND NVL(W_MODIFY_YN, DI.MODIFY_YN)        IN(DI.MODIFY_YN, DI.MODIFY_IN_YN, DI.MODIFY_OUT_YN)
				AND DI.TRANS_YN                           = NVL(W_TRANS_YN, DI.TRANS_YN)
        AND PM.JOIN_DATE                          <= W_WORK_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_WORK_DATE)
        AND EXISTS ( SELECT 'X'
                       FROM HRM_PERSON_MASTER HPM
                     WHERE HPM.FLOOR_ID        = T1.FLOOR_ID
                       AND HPM.SOB_ID          = W_SOB_ID
                       AND HPM.ORG_ID          = W_ORG_ID
                       AND HPM.PERSON_ID       = NVL(V_CONNECT_PERSON_ID, HPM.PERSON_ID)
                    )
				/*AND EXISTS (SELECT 'X'
				              FROM HRD_DUTY_MANAGER DM
 										 WHERE DM.CORP_ID                                 = PM.WORK_CORP_ID
										   AND DM.DUTY_CONTROL_ID                         = NVL(T1.FLOOR_ID, PM.FLOOR_ID)
											 AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
											 AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
											 AND DM.START_DATE                              <= W_WORK_DATE
											 AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_WORK_DATE)
											 AND DM.SOB_ID                                  = PM.SOB_ID
											 AND DM.ORG_ID                                  = PM.ORG_ID
									 )*/
        ORDER BY HF.FLOOR_CODE, PM.WORK_TYPE_ID, PC.SORT_NUM, PM.PERSON_NUM
				;
				
  END DATA_SELECT;

-- 비고사항 저장.
  PROCEDURE DATA_UPDATE
            ( W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            , P_NEXT_DAY_YN                       IN HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE
            , P_DESCRIPTION                       IN HRD_DAY_INTERFACE.DESCRIPTION%TYPE
            , P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE              
            )
  AS
  BEGIN
    UPDATE HRD_DAY_INTERFACE DI
      SET DI.NEXT_DAY_YN          = P_NEXT_DAY_YN
        , DI.DESCRIPTION          = P_DESCRIPTION
        , DI.LAST_UPDATE_DATE     = GET_LOCAL_DATE(DI.SOB_ID)
        , DI.LAST_UPDATED_BY      = P_USER_ID
    WHERE DI.PERSON_ID            = W_PERSON_ID
      AND DI.WORK_DATE            = W_WORK_DATE
      AND DI.SOB_ID               = W_SOB_ID
      AND DI.ORG_ID               = W_ORG_ID
    ;
    
  END DATA_UPDATE;
  	
-- DAY INTERFACE TRANS MANAGER SELECT
  PROCEDURE DATA_TRANS_MANAGER
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_END_DATE                          IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_TRANS_YN                          IN HRD_DAY_INTERFACE.TRANS_YN%TYPE
						, W_DUTY_MANAGER_ID                   IN HRD_DUTY_MANAGER.DUTY_MANAGER_ID%TYPE
            , W_MANAGER_ID                        IN HRD_DUTY_MANAGER.MANAGER_ID1%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            )
  AS
		D_SYSDATE                                     HRD_DAY_INTERFACE.CREATION_DATE%TYPE;
		N_DAY_COUNT                                   NUMBER := 0;
		    
  BEGIN
		D_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
		-- 임시테이블 삭제.
		BEGIN
			DELETE FROM HRD_WORK_DATE WD
			WHERE WD.RUN_DATETIME                          < (D_SYSDATE- (1 / 24 / 60 * 20))
				AND WD.SOB_ID                                = W_SOB_ID
				AND WD.ORG_ID                                = W_ORG_ID;
		END;
		-- 같은 세션의 자료 삭제.
		BEGIN
			DELETE FROM HRD_WORK_DATE WD
			WHERE WD.SESSION_ID                            = USERENV_G.GET_SESSION_ID_F
			  AND WD.RUN_DATETIME                          = D_SYSDATE
				AND WD.SOB_ID                                = W_SOB_ID
				AND WD.ORG_ID                                = W_ORG_ID;
		END;
		
		-- 월 달력 생성.
		BEGIN
		  N_DAY_COUNT := W_END_DATE - W_START_DATE + 1;
			FOR C1 IN 0 .. N_DAY_COUNT - 1
			LOOP
				INSERT INTO HRD_WORK_DATE
				(SESSION_ID, RUN_DATETIME, WORK_DATE, PERSON_ID, CORP_ID, WORK_WEEK, SOB_ID, ORG_ID
				, N_VALUE1, N_VALUE2, N_VALUE3)
				(SELECT USERENV_G.GET_SESSION_ID_F
						 , D_SYSDATE
						 , W_START_DATE + C1
						 , DM.MANAGER_ID1      -- PERSON_ID
						 , DM.CORP_ID
						 , TO_CHAR(W_START_DATE + C1, 'D')
						 , W_SOB_ID
						 , W_ORG_ID
						 , DM.DUTY_MANAGER_ID
						 , DM.DUTY_CONTROL_ID
						 , DM.WORK_TYPE_ID					 
					FROM HRD_DUTY_MANAGER DM
				 WHERE DM.CORP_ID               = W_CORP_ID
					 AND DM.SOB_ID                = W_SOB_ID
					 AND DM.ORG_ID                = W_ORG_ID
					 AND DM.USABLE                = 'Y'
					 AND DM.START_DATE            <= W_END_DATE
					 AND (DM.END_DATE IS NULL OR DM.END_DATE >= W_START_DATE))
				;
			END LOOP C1;
		END;

    OPEN P_CURSOR FOR
      SELECT WD.WORK_DATE
					 , T1.DEPT_NAME
					 , T1.POST_NAME
					 , HRD_DUTY_MANAGER_G.MANAGER_NAME_F(WD.N_VALUE1) AS DUTY_MANAGER_NAME
					 , T1.NAME AS MANAGER_NAME
					 , COUNT(T2.PERSON_ID) AS DAY_INTERFACE_COUNT
					 , COUNT(T3.PERSON_ID) AS DAY_LEAVE_COUNT
					 , SUM(DECODE(T3.CLOSED_YN, 'Y', 1, 0)) AS DAY_LEAVE_CLOSE_COUNT
					 , 'N' AS CHECK_YN
					 , WD.N_VALUE1 AS DUTY_MANAGER_ID
				FROM HRD_WORK_DATE WD
					 , (-- 시점 인사내역.
							SELECT PM.PERSON_ID
									 , HRM_PERSON_MASTER_G.NAME_F(PM.PERSON_ID) AS NAME
                   , PM.WORK_CORP_ID
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
								AND HL.CHARGE_DATE            <= W_END_DATE
								AND HL.HISTORY_LINE_ID        IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
																										 FROM HRM_HISTORY_LINE S_HL
																									 WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                                                     AND S_HL.PERSON_ID              = HL.PERSON_ID
																									 GROUP BY S_HL.PERSON_ID
																									)
						) T1
					, (-- 출퇴근 등록.
							SELECT PM.WORK_CORP_ID
                   , PM.CORP_ID
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
								AND HL.CHARGE_DATE            <= W_END_DATE
								AND HL.HISTORY_LINE_ID        IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
																										 FROM HRM_HISTORY_LINE S_HL
																									 WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                                                     AND S_HL.PERSON_ID              = HL.PERSON_ID
																									 GROUP BY S_HL.PERSON_ID
																									)
								AND DI.WORK_DATE             BETWEEN W_START_DATE AND W_END_DATE	
                AND PM.JOIN_DATE             <= W_END_DATE
                AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_START_DATE)
						) T2
					, (-- 일근태  자료 조회.
							SELECT PM.WORK_CORP_ID
                   , PM.CORP_ID
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
								AND HL.CHARGE_DATE            <= W_END_DATE
								AND HL.HISTORY_LINE_ID        IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
																										 FROM HRM_HISTORY_LINE S_HL
																									 WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                                                     AND S_HL.PERSON_ID              = HL.PERSON_ID
																									 GROUP BY S_HL.PERSON_ID
																									)
								AND DL.WORK_DATE             BETWEEN W_START_DATE AND W_END_DATE
                AND PM.JOIN_DATE             <= W_END_DATE
                AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_START_DATE)
						) T3
			WHERE WD.PERSON_ID              = T1.PERSON_ID
				AND WD.CORP_ID                = T1.WORK_CORP_ID
				AND WD.SOB_ID                 = T1.SOB_ID
				AND WD.ORG_ID                 = T1.ORG_ID
				AND WD.WORK_DATE              = T2.WORK_DATE(+)
				AND WD.CORP_ID                = T2.WORK_CORP_ID(+)
				AND WD.SOB_ID                 = T2.SOB_ID(+)
				AND WD.ORG_ID                 = T2.ORG_ID(+)
				AND WD.N_VALUE2               = T2.FLOOR_ID(+)
				AND WD.N_VALUE3               = DECODE(WD.N_VALUE3, 0, WD.N_VALUE3, T2.WORK_TYPE_ID)
				AND T2.WORK_DATE              = T3.WORK_DATE(+)
				AND T2.PERSON_ID              = T3.PERSON_ID(+)
				AND T2.WORK_CORP_ID           = T3.WORK_CORP_ID(+)
				AND T2.SOB_ID                 = T3.SOB_ID(+)
				AND T2.ORG_ID                 = T3.ORG_ID(+)
				AND WD.WORK_DATE              BETWEEN W_START_DATE AND W_END_DATE
				AND WD.N_VALUE1               = NVL(W_DUTY_MANAGER_ID, WD.N_VALUE1)
				AND WD.PERSON_ID              = NVL(W_MANAGER_ID, WD.PERSON_ID)
				AND WD.SESSION_ID             = USERENV_G.GET_SESSION_ID_F
				AND WD.RUN_DATETIME           = D_SYSDATE
				AND NVL(T2.TRANS_YN, 'A')     = NVL(W_TRANS_YN, NVL(T2.TRANS_YN, 'A'))
			GROUP BY WD.N_VALUE1 
					 , WD.WORK_DATE
					 , T1.DEPT_NAME
					 , T1.POST_NAME
					 , T1.FLOOR_NAME
					 , HRD_DUTY_MANAGER_G.MANAGER_NAME_F(WD.N_VALUE1) 
					 , T1.NAME	
			ORDER BY WD.WORK_DATE, T1.NAME	
    ;
		
  END DATA_TRANS_MANAGER;	

-- DAY INTERFACE TRANS CANCEL
  PROCEDURE DATA_TRANS_CANCEL
            ( W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_DUTY_MANAGER_ID                   IN HRD_DUTY_MANAGER.DUTY_MANAGER_ID%TYPE
						, P_CHECK_YN                          IN HRD_DAY_INTERFACE.TRANS_YN%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            )
  AS
	  V_DUTY_CONTROL_ID                             HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE;
		V_WORK_TYPE_ID                                HRD_DUTY_MANAGER.WORK_TYPE_ID%TYPE;
		V_MANAGER_ID                                  HRD_DUTY_MANAGER.MANAGER_ID1%TYPE;
		V_RECORD_COUNT                                NUMBER := 0;
		
	BEGIN 
	  IF P_CHECK_YN <> 'Y' THEN		  
		  RETURN;
		END IF;
		
	  -- 근태 관리 단위 조회.
		BEGIN
		  SELECT DM.DUTY_CONTROL_ID, DM.WORK_TYPE_ID, DM.MANAGER_ID1
			  INTO V_DUTY_CONTROL_ID, V_WORK_TYPE_ID, V_MANAGER_ID
			  FROM HRD_DUTY_MANAGER DM
			 WHERE DM.DUTY_MANAGER_ID    = W_DUTY_MANAGER_ID
			 ;
		EXCEPTION WHEN OTHERS THEN
      RAISE ERRNUMS.Data_Not_Found;
			RETURN;
		END;
			
    -- 해당 일자 일근태 마감여부 체크.
		HRD_DAY_LEAVE_G.DATA_CLOSE_YN_COUNT( W_CORP_ID => W_CORP_ID
		                                   , W_WORK_DATE => W_WORK_DATE
																			 , W_PERSON_ID => NULL
																			 , W_SOB_ID => W_SOB_ID
																			 , W_ORG_ID => W_ORG_ID
																			 , W_CONNECT_PERSON_ID => V_MANAGER_ID
																			 , W_CAP_CHECK_YN => 'N'
																			 , W_FLOOR_ID => V_DUTY_CONTROL_ID
																			 , W_WORK_TYPE_ID => V_WORK_TYPE_ID
                                       , W_CLOSE_YN => 'Y'
																			 , O_RECORD_COUNT => V_RECORD_COUNT);
    
		IF V_RECORD_COUNT > 0 THEN
		  RAISE ERRNUMS.Data_Closed;
			RETURN;
		END IF;
		
	  -- 출퇴근 이첩 취소 관리.
		UPDATE HRD_DAY_INTERFACE DI
			 SET DI.TRANS_YN          = 'N'
				 , DI.TRANS_DATE        = NULL
				 , DI.TRANS_PERSON_ID   = NULL
		 WHERE DI.WORK_DATE              = W_WORK_DATE
			 AND DI.WORK_CORP_ID           = W_CORP_ID
			 AND DI.SOB_ID                 = W_SOB_ID
			 AND DI.ORG_ID                 = W_ORG_ID
			 AND EXISTS ( SELECT 'X'
											FROM HRD_DUTY_MANAGER DM
												 , (-- 시점 인사내역.
														SELECT PM.PERSON_ID
																 , PM.WORK_CORP_ID
																 , PM.SOB_ID
																 , PM.ORG_ID
																 , PM.WORK_TYPE_ID
																 , HL.FLOOR_ID
															FROM HRM_HISTORY_LINE HL
																 , HRM_PERSON_MASTER PM
														WHERE HL.PERSON_ID              = PM.PERSON_ID
															AND HL.CHARGE_DATE            <= W_WORK_DATE
															AND HL.HISTORY_LINE_ID        IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
																																	 FROM HRM_HISTORY_LINE S_HL
																																 WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
                                                                   AND S_HL.PERSON_ID              = HL.PERSON_ID
																																 GROUP BY S_HL.PERSON_ID
																																)
													) T1                             
										 WHERE DM.CORP_ID                   = T1.WORK_CORP_ID
											 AND DM.SOB_ID                    = T1.SOB_ID
											 AND DM.ORG_ID                    = T1.ORG_ID
											 AND DM.DUTY_CONTROL_ID           = T1.FLOOR_ID
											 AND DM.WORK_TYPE_ID              = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, T1.WORK_TYPE_ID)
											 AND T1.PERSON_ID                 = DI.PERSON_ID
											 AND T1.WORK_CORP_ID              = DI.WORK_CORP_ID
											 AND T1.SOB_ID                    = DI.SOB_ID
											 AND T1.ORG_ID                    = DI.ORG_ID
											 AND DM.DUTY_MANAGER_ID           = W_DUTY_MANAGER_ID
									)
		;
		-- 일근태 자료 삭제.
		DELETE FROM HRD_DAY_LEAVE DL
		 WHERE DL.WORK_DATE              = W_WORK_DATE
			 AND DL.WORK_CORP_ID           = W_CORP_ID
			 AND DL.SOB_ID                 = W_SOB_ID
			 AND DL.ORG_ID                 = W_ORG_ID
			 AND EXISTS ( SELECT 'X'
											FROM HRD_DUTY_MANAGER DM
												 , (-- 시점 인사내역.
														SELECT PM.PERSON_ID
																 , PM.WORK_CORP_ID
																 , PM.SOB_ID
																 , PM.ORG_ID
																 , PM.WORK_TYPE_ID
																 , HL.FLOOR_ID
															FROM HRM_HISTORY_LINE HL
																 , HRM_PERSON_MASTER PM
														WHERE HL.PERSON_ID              = PM.PERSON_ID
															AND HL.CHARGE_DATE            <= W_WORK_DATE
															AND HL.HISTORY_LINE_ID        IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
																																	 FROM HRM_HISTORY_LINE S_HL
																																 WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
                                                                   AND S_HL.PERSON_ID              = HL.PERSON_ID
																																 GROUP BY S_HL.PERSON_ID
																																)
													) T1														 
										 WHERE DM.CORP_ID                   = T1.WORK_CORP_ID
											 AND DM.SOB_ID                    = T1.SOB_ID
											 AND DM.ORG_ID                    = T1.ORG_ID
											 AND DM.DUTY_CONTROL_ID           = T1.FLOOR_ID
											 AND DM.WORK_TYPE_ID              = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, T1.WORK_TYPE_ID)
											 AND T1.PERSON_ID                 = DL.PERSON_ID
											 AND T1.WORK_CORP_ID              = DL.WORK_CORP_ID
											 AND T1.SOB_ID                    = DL.SOB_ID
											 AND T1.ORG_ID                    = DL.ORG_ID
											 AND DM.DUTY_MANAGER_ID           = W_DUTY_MANAGER_ID
									)
		;		
		COMMIT;
				
	EXCEPTION
	  WHEN ERRNUMS.Data_Not_Found THEN
		  ROLLBACK;
		  RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_Found_Code, ERRNUMS.Data_Not_Found_Desc);	  
		WHEN ERRNUMS.Data_Closed THEN
		  ROLLBACK;
			RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);		
		WHEN OTHERS THEN
	    ROLLBACK;
		  RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
	END DATA_TRANS_CANCEL;
	
-- DAY INTERFACE TRANSFER MAIN.
  PROCEDURE DATA_TRANSFER_MAIN
            ( W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            , W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
            , W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
						, W_CAP_CHECK_YN                      IN VARCHAR2
						, P_USER_ID                           IN HRD_DAY_LEAVE.CREATED_BY%TYPE
            )
  AS
	  V_CLOSE_RECORD_COUNT                          NUMBER := 0;
		V_CONNECT_PERSON_ID                           HRM_PERSON_MASTER.PERSON_ID%TYPE := W_CONNECT_PERSON_ID;
		
	BEGIN
	  -- 이첩된 자료수 조회.
	  HRD_DAY_LEAVE_G.DATA_CLOSE_YN_COUNT( W_CORP_ID => W_CORP_ID
		                                   , W_WORK_DATE => W_WORK_DATE
																			 , W_PERSON_ID => W_PERSON_ID
																			 , W_SOB_ID => W_SOB_ID
																			 , W_ORG_ID => W_ORG_ID
																			 , W_CONNECT_PERSON_ID => V_CONNECT_PERSON_ID
																			 , W_CAP_CHECK_YN => 'N'
																			 , W_FLOOR_ID => W_FLOOR_ID
																			 , W_WORK_TYPE_ID => W_WORK_TYPE_ID
																			 , W_CLOSE_YN => 'Y'
																			 , O_RECORD_COUNT => V_CLOSE_RECORD_COUNT);
																			 
    IF V_CLOSE_RECORD_COUNT > 0 THEN
		  RAISE ERRNUMS.Transfer_Completed;
		END IF;		
		
		-- 근태권한 설정.
    IF W_CONNECT_LEVEL = 'C' THEN
      V_CONNECT_PERSON_ID := NULL;
    ELSE
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;		
		
		-- WORK DAY DATA --> TRANSFER DAY LEAV.
		DATA_TRANSFER_GO1( W_CORP_ID => W_CORP_ID
		                 , W_WORK_DATE => W_WORK_DATE
										 , W_WORK_TYPE_ID => W_WORK_TYPE_ID
										 , W_FLOOR_ID => W_FLOOR_ID
										 , W_PERSON_ID => W_PERSON_ID
										 , W_CONNECT_PERSON_ID => V_CONNECT_PERSON_ID
										 , W_SOB_ID => W_SOB_ID
										 , W_ORG_ID => W_ORG_ID
										 , P_USER_ID => P_USER_ID
										 );
				 
	EXCEPTION
	  WHEN ERRNUMS.Data_Closed THEN
		  ROLLBACK;
			RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
	  WHEN ERRNUMS.Transfer_Completed THEN
		  ROLLBACK;
			RAISE_APPLICATION_ERROR(ERRNUMS.Transfer_Completed_Code, ERRNUMS.Transfer_Completed_Desc);
    WHEN OTHERS THEN
		  RAISE_APPLICATION_ERROR(-20001, SQLERRM);
	END DATA_TRANSFER_MAIN;
	
-- DAY INTERFACE TRANSFER GO1.
  PROCEDURE DATA_TRANSFER_GO1
            ( W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            , W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
            , W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
						, P_USER_ID                           IN HRD_DAY_LEAVE.CREATED_BY%TYPE
            )
  AS
	  V_SYSDATE                                     DATE := GET_LOCAL_DATE(W_SOB_ID);
		
	BEGIN
	  BEGIN
		  INSERT INTO HRD_DAY_LEAVE 
			( DAY_LEAVE_ID
      , PERSON_ID, WORK_DATE, WORK_CORP_ID, CORP_ID, DEPT_ID, POST_ID, JOB_CATEGORY_ID
			, DUTY_ID, HOLY_TYPE
			, OPEN_TIME, CLOSE_TIME, OPEN_TIME1, CLOSE_TIME1
			, NEXT_DAY_YN, DANGJIK_YN, ALL_NIGHT_YN
			, ATTRIBUTE10
			, SOB_ID, ORG_ID
			, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY			
			)
			SELECT HRD_DAY_LEAVE_S1.NEXTVAL
           , DI.PERSON_ID
					 , DI.WORK_DATE
           , DI.WORK_CORP_ID
					 , DI.CORP_ID
					 , DI.DEPT_ID
					 , DI.POST_ID
					 , DI.JOB_CATEGORY_ID
					 , DI.DUTY_ID AS DUTY_ID
					 , DI.HOLY_TYPE
					 , CASE
							 WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
							 ELSE DI.OPEN_TIME
						 END AS OPEN_TIME
					 , CASE
               WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, N_DI.CLOSE_TIME)
							 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
							 ELSE DI.CLOSE_TIME
						 END AS CLOSE_TIME
					 , CASE
							 WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
							 ELSE DI.OPEN_TIME1
						 END AS OPEN_TIME1
					 , CASE
               /*WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN N_DI.CLOSE_TIME1*/
							 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
							 ELSE DI.CLOSE_TIME1
						 END AS CLOSE_TIME1
					 , DI.NEXT_DAY_YN
					 , NVL(DI.DANGJIK_YN, 'N') AS DANGJIK_YN
					 , NVL(DI.ALL_NIGHT_YN, 'N') AS ALL_NIGHT_YN
					 , DI.WORK_TYPE_GROUP AS WORK_TYPE_GROUP
					 , DI.SOB_ID
					 , DI.ORG_ID
					 , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
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
          FROM HRD_DAY_INTERFACE DIT
          WHERE DIT.WORK_DATE     = W_WORK_DATE + 1
            AND DIT.PERSON_ID     = NVL(W_PERSON_ID, DIT.PERSON_ID)
            AND DIT.WORK_CORP_ID  = W_CORP_ID
            AND DIT.SOB_ID        = W_SOB_ID
            AND DIT.ORG_ID        = W_ORG_ID
        ) N_DI    
			WHERE DI.PERSON_ID                          = PM.PERSON_ID
        AND DI.PERSON_ID                          = T1.PERSON_ID
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
				AND T1.FLOOR_ID                           = NVL(W_FLOOR_ID, T1.FLOOR_ID)
				AND DI.TRANS_YN                           = 'N'
        AND PM.JOIN_DATE                          <= W_WORK_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_WORK_DATE)
				AND EXISTS (SELECT 'X'
											FROM HRD_DUTY_MANAGER DM
											WHERE DM.CORP_ID                                = DI.WORK_CORP_ID
											 AND DM.DUTY_CONTROL_ID                         = T1.FLOOR_ID
											 AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
											 AND (NVL(W_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
											 AND DM.START_DATE                              <= DI.WORK_DATE
											 AND (DM.END_DATE IS NULL OR DM.END_DATE        >= DI.WORK_DATE)
											 AND DM.SOB_ID                                  = DI.SOB_ID
											 AND DM.ORG_ID                                  = DI.ORG_ID
									 )
				;
			
			-- DAY_INTERFACE TABLE에 TRANS_YN 값 변경.
			UPDATE HRD_DAY_INTERFACE DI
				SET DI.TRANS_YN                = 'Y'
					, DI.TRANS_DATE              = V_SYSDATE
					, DI.TRANS_PERSON_ID		     = W_CONNECT_PERSON_ID
			WHERE DI.WORK_DATE               = W_WORK_DATE
			  AND DI.PERSON_ID               = NVL(W_PERSON_ID, DI.PERSON_ID)
			  AND DI.WORK_CORP_ID            = W_CORP_ID
				AND DI.SOB_ID                  = W_SOB_ID
				AND DI.ORG_ID                  = W_ORG_ID
				AND DI.WORK_TYPE_ID            = NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
				AND DI.TRANS_YN                = 'N'
			  AND EXISTS (SELECT 'X'
										FROM HRD_DAY_LEAVE DL
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
									 WHERE DL.PERSON_ID           = PM.PERSON_ID
										 AND DL.SOB_ID              = PM.SOB_ID
										 AND DL.ORG_ID              = PM.ORG_ID
										 AND DL.PERSON_ID           = DI.PERSON_ID
										 AND DL.WORK_DATE           = DI.WORK_DATE
										 AND DL.SOB_ID              = DI.SOB_ID
										 AND DL.ORG_ID              = DI.ORG_ID
										 AND PM.PERSON_ID           = T1.PERSON_ID
										 AND T1.FLOOR_ID            = NVL(W_FLOOR_ID, T1.FLOOR_ID)
										 AND EXISTS (SELECT 'X'
																	FROM HRD_DUTY_MANAGER DM
																	WHERE DM.CORP_ID                                = DL.WORK_CORP_ID
																	 AND DM.DUTY_CONTROL_ID                         = T1.FLOOR_ID
																	 AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
																	 AND (NVL(W_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
																	 AND DM.START_DATE                              <= DL.WORK_DATE
																	 AND (DM.END_DATE IS NULL OR DM.END_DATE        >= DL.WORK_DATE)
																	 AND DM.SOB_ID                                  = DL.SOB_ID
																	 AND DM.ORG_ID                                  = DL.ORG_ID
																 )
									)
			;					
				
		EXCEPTION WHEN OTHERS THEN
		  ROLLBACK;
      RAISE ERRNUMS.Insert_Error;
		END;
		COMMIT;
		
	EXCEPTION	
	  WHEN ERRNUMS.Insert_Error THEN
		  RAISE_APPLICATION_ERROR(-20001, SQLERRM);
		WHEN OTHERS THEN
		  RAISE_APPLICATION_ERROR(-20001, SQLERRM);	
	END DATA_TRANSFER_GO1;	
	
END HRD_DAY_INTERFACE_TRANS_G;
/
