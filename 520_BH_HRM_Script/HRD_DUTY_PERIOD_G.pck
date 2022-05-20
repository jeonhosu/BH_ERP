CREATE OR REPLACE PACKAGE HRD_DUTY_PERIOD_G
AS
-- PERIOD SELECT
  PROCEDURE DATA_SELECT
	          ( P_CURSOR                                OUT TYPES.TCURSOR
						, W_CORP_ID                               IN HRD_DUTY_PERIOD.CORP_ID%TYPE
						, W_START_DATE                            IN HRD_DUTY_PERIOD.START_DATE%TYPE
						, W_END_DATE                              IN HRD_DUTY_PERIOD.END_DATE%TYPE
						, W_APPROVE_STATUS                        IN HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE
						, W_SEARCH_TYPE                           IN HRM_COMMON.CODE%TYPE
						, W_DUTY_ID                               IN HRD_DUTY_PERIOD.DUTY_ID%TYPE
						, W_FLOOR_ID                              IN HRM_PERSON_MASTER.FLOOR_ID%TYPE
						, W_PERSON_ID                             IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_SOB_ID                                IN HRD_DUTY_PERIOD.SOB_ID%TYPE
						, W_ORG_ID                                IN HRD_DUTY_PERIOD.ORG_ID%TYPE
						);

-- PERIOD SHORT SELECT
  PROCEDURE DATA_SELECT_S
	          ( P_CURSOR                                OUT TYPES.TCURSOR
						, W_CORP_ID                               IN HRD_DUTY_PERIOD.CORP_ID%TYPE
						, W_WORK_DATE                             IN HRD_DUTY_PERIOD.START_DATE%TYPE
						, W_PERSON_ID                             IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_SOB_ID                                IN HRD_DUTY_PERIOD.SOB_ID%TYPE
						, W_ORG_ID                                IN HRD_DUTY_PERIOD.ORG_ID%TYPE
						);

-- DATA INSERT.
  PROCEDURE DATA_INSERT
	          ( P_CORP_ID                               IN HRD_DUTY_PERIOD.CORP_ID%TYPE
						, P_PERSON_ID                             IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
						, P_DUTY_ID                               IN HRD_DUTY_PERIOD.DUTY_ID%TYPE
						, P_START_DATE                            IN HRD_DUTY_PERIOD.START_DATE%TYPE
						, P_START_TIME                            IN VARCHAR2
						, P_END_DATE                              IN HRD_DUTY_PERIOD.END_DATE%TYPE
						, P_END_TIME                              IN VARCHAR2
						, P_DESCRIPTION                           IN HRD_DUTY_PERIOD.DESCRIPTION%TYPE
						, P_SOB_ID                                IN HRD_DUTY_PERIOD.SOB_ID%TYPE
						, P_ORG_ID                                IN HRD_DUTY_PERIOD.ORG_ID%TYPE
						, P_USER_ID                               IN HRD_DUTY_PERIOD.CREATED_BY%TYPE
						, O_DUTY_PERIOD_ID                        OUT HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE
            , O_APPROVE_STATUS                        OUT VARCHAR2
            , O_APPROVE_STATUS_NAME                   OUT VARCHAR2
						);

-- DATA UPDATE.
  PROCEDURE DATA_UPDATE
	          ( W_DUTY_PERIOD_ID                        IN HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE
						, P_DUTY_ID                               IN HRD_DUTY_PERIOD.DUTY_ID%TYPE
						, P_START_DATE                            IN HRD_DUTY_PERIOD.START_DATE%TYPE
						, P_START_TIME                            IN VARCHAR2
						, P_END_DATE                              IN HRD_DUTY_PERIOD.END_DATE%TYPE
						, P_END_TIME                              IN VARCHAR2
						, P_DESCRIPTION                           IN HRD_DUTY_PERIOD.DESCRIPTION%TYPE
						, P_USER_ID                               IN NUMBER
						);

-- DATA DELETE.
  PROCEDURE DATA_DELETE
	          ( W_DUTY_PERIOD_ID                        IN HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE
						);

-- 고정근태 반려처리를 위한 조회.
  PROCEDURE DUTY_PERIOD_RETURN_SELECT
	          ( P_CURSOR1                               OUT TYPES.TCURSOR1
						, W_CORP_ID                               IN HRD_DUTY_PERIOD.CORP_ID%TYPE
						, W_START_DATE                            IN HRD_DUTY_PERIOD.START_DATE%TYPE
						, W_END_DATE                              IN HRD_DUTY_PERIOD.END_DATE%TYPE
						, W_APPROVE_STATUS                        IN HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE
						, W_DUTY_ID                               IN HRD_DUTY_PERIOD.DUTY_ID%TYPE
						, W_FLOOR_ID                              IN HRM_PERSON_MASTER.FLOOR_ID%TYPE
						, W_PERSON_ID                             IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_SOB_ID                                IN HRD_DUTY_PERIOD.SOB_ID%TYPE
						, W_ORG_ID                                IN HRD_DUTY_PERIOD.ORG_ID%TYPE
						);

-- 고정근태 반려처리.
  PROCEDURE DATA_UPDATE_RETURN_APPROVE
	          ( W_DUTY_PERIOD_ID                        IN HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE
            , P_REJECT_REMARK                         IN HRD_DUTY_PERIOD.REJECT_REMARK%TYPE
            , P_APPROVE_STATUS                        IN HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE
						, P_CHECK_YN                              IN VARCHAR2
						, P_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, P_SOB_ID                                IN HRD_DUTY_PERIOD.SOB_ID%TYPE
						, P_ORG_ID                                IN HRD_DUTY_PERIOD.ORG_ID%TYPE
						, P_USER_ID                               IN HRD_DUTY_PERIOD.CREATED_BY%TYPE
						);
            
-- DATA DELETE-1차 승인된 것두 삭제.
  PROCEDURE DATA_DELETE1
	          ( W_DUTY_PERIOD_ID                        IN HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE
						);

-- DATA UPDATE REQUEST.
  PROCEDURE DATA_UPDATE_REQUEST
            ( W_DUTY_PERIOD_ID                        IN HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE
            , O_APPROVE_STATUS                        OUT VARCHAR2
            , O_APPROVE_STATUS_NAME                   OUT VARCHAR2
            );
                        
-- DATA UPDATE - STEP APPROVE.
  PROCEDURE DATA_UPDATE_APPROVE
	          ( W_DUTY_PERIOD_ID                        IN HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE
            , P_APPROVE_STATUS                        IN HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE
						, P_CHECK_YN                              IN VARCHAR2
						, P_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, P_APPROVE_FLAG                          IN VARCHAR2
						, P_SOB_ID                                IN HRD_DUTY_PERIOD.SOB_ID%TYPE
						, P_ORG_ID                                IN HRD_DUTY_PERIOD.ORG_ID%TYPE
						, P_USER_ID                               IN HRD_DUTY_PERIOD.CREATED_BY%TYPE
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

-- 지각/조퇴/외출/외근 신청 여부 체크.
  FUNCTION ATTEND_FLAG_F
            ( W_DUTY_PERIOD_ID           IN HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE
            ) RETURN VARCHAR2;

-- 반차일 경우 데이터 검증.
  FUNCTION DUTY_21_CHECK_F
	          ( P_PERSON_ID                IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
						, P_DUTY_ID                  IN HRD_DUTY_PERIOD.DUTY_ID%TYPE
						, P_START_DATE               IN HRD_DUTY_PERIOD.START_DATE%TYPE
						, P_START_TIME               IN VARCHAR2
						, P_END_DATE                 IN HRD_DUTY_PERIOD.END_DATE%TYPE
						, P_END_TIME                 IN VARCHAR2
						, P_SOB_ID                   IN HRD_DUTY_PERIOD.SOB_ID%TYPE
						, P_ORG_ID                   IN HRD_DUTY_PERIOD.ORG_ID%TYPE
						) RETURN VARCHAR2;
            
END HRD_DUTY_PERIOD_G; 
/
CREATE OR REPLACE PACKAGE BODY HRD_DUTY_PERIOD_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_DUTY_PERIOD_G
/* DESCRIPTION  : 고정근태 신청/승인 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- PERIOD SELECT
  PROCEDURE DATA_SELECT
	          ( P_CURSOR                                OUT TYPES.TCURSOR
						, W_CORP_ID                               IN HRD_DUTY_PERIOD.CORP_ID%TYPE
						, W_START_DATE                            IN HRD_DUTY_PERIOD.START_DATE%TYPE
						, W_END_DATE                              IN HRD_DUTY_PERIOD.END_DATE%TYPE
						, W_APPROVE_STATUS                        IN HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE
						, W_SEARCH_TYPE                           IN HRM_COMMON.CODE%TYPE
						, W_DUTY_ID                               IN HRD_DUTY_PERIOD.DUTY_ID%TYPE
						, W_FLOOR_ID                              IN HRM_PERSON_MASTER.FLOOR_ID%TYPE
						, W_PERSON_ID                             IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_SOB_ID                                IN HRD_DUTY_PERIOD.SOB_ID%TYPE
						, W_ORG_ID                                IN HRD_DUTY_PERIOD.ORG_ID%TYPE
						)
  AS
	  V_CONNECT_PERSON_ID                               HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
  BEGIN
	  -- 근태권한 설정.
		IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID
		                           , W_START_DATE => W_START_DATE
															 , W_END_DATE => W_END_DATE
															 , W_MODULE_CODE => '20'
															 , W_PERSON_ID => W_CONNECT_PERSON_ID
															 , W_SOB_ID => W_SOB_ID
															 , W_ORG_ID => W_ORG_ID) = 'C' THEN
		  V_CONNECT_PERSON_ID := NULL;
		ELSE
		  V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
		END IF;
		IF W_APPROVE_STATUS IN('A', 'N') THEN
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;
    OPEN P_CURSOR FOR
      SELECT DP.PERSON_ID
					 , PM.NAME
           , HRM_COMMON_G.ID_NAME_F(T1.FLOOR_ID) AS FLOOR_NAME
					 , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
					 , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
					 , DP.CORP_ID
					 , DP.DUTY_ID
					 , HRM_COMMON_G.ID_NAME_F(DP.DUTY_ID) DUTY_NAME
					 , TRUNC(DP.START_DATE) AS START_DATE
					 , TO_CHAR(DP.START_DATE, 'HH24:MI') AS START_TIME
					 , TRUNC(DP.END_DATE) AS END_DATE
					 , TO_CHAR(DP.END_DATE, 'HH24:MI') AS END_TIME
					 , DP.DESCRIPTION
					 , 'N' AS APPROVE_YN
					 , DP.APPROVE_STATUS
					 , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DP.APPROVE_STATUS, DP.SOB_ID, DP.ORG_ID) APPROVE_STATUS_NAME
					 , HRM_PERSON_MASTER_G.NAME_F(DP.APPROVED_PERSON_ID) APPROVERD_PERSON_NAME
					 , HRM_PERSON_MASTER_G.NAME_F(DP.CONFIRMED_PERSON_ID) CONFIRMED_PERSON_NAME
					 , DP.DUTY_PERIOD_ID
					 , PM.PERSON_NUM
					 , WT.WORK_TYPE_GROUP
           , EAPP_USER_G.USER_NAME_F(DP.CREATED_BY) AS REQUEST_PERSON_NAME
           , DP.REJECT_REMARK
			FROM HRD_DUTY_PERIOD DP
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
																					 WHERE S_HL.CHARGE_DATE            <= W_END_DATE
																					   AND S_HL.PERSON_ID              = HL.PERSON_ID
																					 GROUP BY S_HL.PERSON_ID
																				 )
					) T1
				, HRM_WORK_TYPE_V WT
			WHERE DP.PERSON_ID                          = PM.PERSON_ID
				AND DP.SOB_ID                             = PM.SOB_ID
				AND DP.ORG_ID                             = PM.ORG_ID
				AND PM.PERSON_ID                          = T1.PERSON_ID
				AND PM.WORK_TYPE_ID                       = WT.WORK_TYPE_ID
				AND DECODE(W_SEARCH_TYPE, 'R', TRUNC(DP.START_DATE), TRUNC(DP.CREATION_DATE)) <= W_END_DATE
				AND DECODE(W_SEARCH_TYPE, 'R', TRUNC(DP.END_DATE), TRUNC(DP.CREATION_DATE))   >= W_START_DATE
				AND DP.PERSON_ID                          = NVL(W_PERSON_ID, DP.PERSON_ID)
				AND DP.DUTY_ID                            = NVL(W_DUTY_ID, DP.DUTY_ID)
				AND DP.CORP_ID                            = W_CORP_ID
				AND DP.SOB_ID                             = W_SOB_ID
				AND DP.ORG_ID                             = W_ORG_ID
				AND T1.FLOOR_ID                           = NVL(W_FLOOR_ID, T1.FLOOR_ID)
				AND DP.APPROVE_STATUS                     = NVL(W_APPROVE_STATUS, DP.APPROVE_STATUS)
				AND EXISTS (SELECT 'X'
				            FROM HRD_DUTY_MANAGER DM
										WHERE DM.CORP_ID              = DP.CORP_ID
										  AND DM.DUTY_CONTROL_ID      = T1.FLOOR_ID
											AND DM.WORK_TYPE_ID         = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
											AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
											AND DM.SOB_ID               = DP.SOB_ID
											AND DM.ORG_ID               = DP.ORG_ID
									  )
      ;

  END DATA_SELECT;


-- PERIOD SHORT SELECT
  PROCEDURE DATA_SELECT_S
	          ( P_CURSOR                                OUT TYPES.TCURSOR
						, W_CORP_ID                               IN HRD_DUTY_PERIOD.CORP_ID%TYPE
						, W_WORK_DATE                             IN HRD_DUTY_PERIOD.START_DATE%TYPE
						, W_PERSON_ID                             IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_SOB_ID                                IN HRD_DUTY_PERIOD.SOB_ID%TYPE
						, W_ORG_ID                                IN HRD_DUTY_PERIOD.ORG_ID%TYPE
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
      SELECT HRM_COMMON_G.ID_NAME_F(DP.DUTY_ID) DUTY_NAME
					 , DP.DESCRIPTION
					 , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DP.APPROVE_STATUS, DP.SOB_ID, DP.ORG_ID) APPROVE_STATUS_NAME
			FROM HRD_DUTY_PERIOD DP
			  , HRM_PERSON_MASTER PM
			WHERE DP.PERSON_ID                          = PM.PERSON_ID
			  AND DP.CORP_ID                            = PM.CORP_ID
				AND DP.SOB_ID                             = PM.SOB_ID
				AND DP.ORG_ID                             = PM.ORG_ID
			  AND DP.WORK_START_DATE                    <= W_WORK_DATE
				AND DP.WORK_END_DATE                      >= W_WORK_DATE
				AND DP.PERSON_ID                          = W_PERSON_ID
				AND DP.CORP_ID                            = W_CORP_ID
				AND DP.SOB_ID                             = W_SOB_ID
				AND DP.ORG_ID                             = W_ORG_ID
				AND ROWNUM                                <= 1
      ;

	END DATA_SELECT_S;


-- DATA INSERT.
  PROCEDURE DATA_INSERT
            ( P_CORP_ID                               IN HRD_DUTY_PERIOD.CORP_ID%TYPE
            , P_PERSON_ID                             IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
            , P_DUTY_ID                               IN HRD_DUTY_PERIOD.DUTY_ID%TYPE
            , P_START_DATE                            IN HRD_DUTY_PERIOD.START_DATE%TYPE
            , P_START_TIME                            IN VARCHAR2
            , P_END_DATE                              IN HRD_DUTY_PERIOD.END_DATE%TYPE
            , P_END_TIME                              IN VARCHAR2
            , P_DESCRIPTION                           IN HRD_DUTY_PERIOD.DESCRIPTION%TYPE
            , P_SOB_ID                                IN HRD_DUTY_PERIOD.SOB_ID%TYPE
            , P_ORG_ID                                IN HRD_DUTY_PERIOD.ORG_ID%TYPE
            , P_USER_ID                               IN HRD_DUTY_PERIOD.CREATED_BY%TYPE
            , O_DUTY_PERIOD_ID                        OUT HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE
            , O_APPROVE_STATUS                        OUT VARCHAR2
            , O_APPROVE_STATUS_NAME                   OUT VARCHAR2
            )
  AS
    V_RECORD_COUNT                                NUMBER;
	  V_DUTY_PERIOD_ID                              HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE := 0;
	  D_SYSDATE                                     HRD_DUTY_PERIOD.CREATION_DATE%TYPE := NULL;
    D_START_DATE                                  HRD_DUTY_PERIOD.START_DATE%TYPE := NULL;
		D_END_DATE                                    HRD_DUTY_PERIOD.END_DATE%TYPE := NULL;
		D_WORK_START_DATE                             HRD_DUTY_PERIOD.WORK_START_DATE%TYPE := NULL;
		D_REAL_START_DATE                             HRD_DUTY_PERIOD.REAL_START_DATE%TYPE := NULL;
		D_WORK_END_DATE                               HRD_DUTY_PERIOD.WORK_END_DATE%TYPE := NULL;
		D_REAL_END_DATE                               HRD_DUTY_PERIOD.REAL_END_DATE%TYPE := NULL;
    V_DUTY_CODE                                   VARCHAR2(10);
  BEGIN
    D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
    
    -- DUTY CODE.
    V_DUTY_CODE := HRM_COMMON_G.GET_CODE_F(P_DUTY_ID, P_SOB_ID, P_ORG_ID);
    IF V_DUTY_CODE = '21' THEN  -- 반차일 경우 근무계획시간은 안됨.
      IF P_START_TIME = '00:00' OR P_END_TIME = '00:00' THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10275', NULL));
      END IF;    
    END IF;
    
		D_START_DATE := TO_DATE(TO_CHAR(P_START_DATE, 'YYYY-MM-DD') || P_START_TIME, 'YYYY-MM-DD HH24:MI');
		D_END_DATE := TO_DATE(TO_CHAR(P_END_DATE, 'YYYY-MM-DD') || P_END_TIME, 'YYYY-MM-DD HH24:MI');
    -- 근태 기간 범위 Validate Check --
    IF D_END_DATE < D_START_DATE THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10012', NULL));
    END IF;
    
    -- 기존 자료수 체크.
    BEGIN
      SELECT COUNT(DP.PERSON_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRD_DUTY_PERIOD DP
      WHERE TRUNC(DP.START_DATE)  = TRUNC(D_START_DATE)
        AND TRUNC(DP.END_DATE)    = TRUNC(D_END_DATE)
        AND DP.PERSON_ID          = P_PERSON_ID
        AND DP.DUTY_ID            = P_DUTY_ID
        AND DP.CORP_ID            = P_CORP_ID
        AND DP.SOB_ID             = P_SOB_ID
        AND DP.ORG_ID             = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10257', NULL));
      RETURN;
    END IF;
    
		-- 근무시간 정리.
		HRD_DUTY_PERIOD_G.WORK_DATE(P_CORP_ID => P_CORP_ID
		                           , P_PERSON_ID => P_PERSON_ID
															 , P_SOB_ID => P_SOB_ID
															 , P_ORG_ID => P_ORG_ID
		                           , P_START_DATE => D_START_DATE
		                           , P_END_DATE => D_END_DATE
															 , O_WORK_START_DATE => D_WORK_START_DATE
															 , O_WORK_END_DATE => D_WORK_END_DATE
															 , O_REAL_START_DATE => D_REAL_START_DATE
															 , O_REAL_END_DATE => D_REAL_END_DATE
															 );

		-- SEQUENCE ID;
		BEGIN
			SELECT HRD_DUTY_PERIOD_S1.NEXTVAL
				INTO V_DUTY_PERIOD_ID
			FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
		  RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10041', NULL));
		END;

	  INSERT INTO HRD_DUTY_PERIOD
		( DUTY_PERIOD_ID
		, START_DATE, END_DATE
		, PERSON_ID, DUTY_ID, CORP_ID
		, WORK_START_DATE, REAL_START_DATE
		, WORK_END_DATE, REAL_END_DATE
		, DESCRIPTION
		, SOB_ID, ORG_ID
		, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
		) VALUES
		( V_DUTY_PERIOD_ID
		, D_START_DATE, D_END_DATE
		, P_PERSON_ID, P_DUTY_ID, P_CORP_ID
		, D_WORK_START_DATE, D_REAL_START_DATE
		, D_WORK_END_DATE, D_REAL_END_DATE
		, P_DESCRIPTION
		, P_SOB_ID, P_ORG_ID
		, D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
		);
		O_DUTY_PERIOD_ID := V_DUTY_PERIOD_ID;
    BEGIN
      SELECT DP.APPROVE_STATUS
           , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DP.APPROVE_STATUS, DP.SOB_ID, DP.ORG_ID) AS APPROVE_STATUS_NAME
        INTO O_APPROVE_STATUS
          , O_APPROVE_STATUS_NAME
        FROM HRD_DUTY_PERIOD DP
      WHERE DP.DUTY_PERIOD_ID       = V_DUTY_PERIOD_ID
      ;        
    EXCEPTION  
      WHEN OTHERS THEN
        O_APPROVE_STATUS := 'N';      
        O_APPROVE_STATUS_NAME := '승인미요청';
    END;
  END DATA_INSERT;

-- DATA UPDATE.
  PROCEDURE DATA_UPDATE
	          ( W_DUTY_PERIOD_ID                        IN HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE
						, P_DUTY_ID                               IN HRD_DUTY_PERIOD.DUTY_ID%TYPE
						, P_START_DATE                            IN HRD_DUTY_PERIOD.START_DATE%TYPE
						, P_START_TIME                            IN VARCHAR2
						, P_END_DATE                              IN HRD_DUTY_PERIOD.END_DATE%TYPE
						, P_END_TIME                              IN VARCHAR2
						, P_DESCRIPTION                           IN HRD_DUTY_PERIOD.DESCRIPTION%TYPE
						, P_USER_ID                               IN NUMBER
						)
  AS
	  V_APPROVE_STATUS                                  HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE := 'N';
	  D_SYSDATE                                         HRD_DUTY_PERIOD.CREATION_DATE%TYPE := NULL;
    D_START_DATE                                      HRD_DUTY_PERIOD.START_DATE%TYPE := NULL;
		D_END_DATE                                        HRD_DUTY_PERIOD.END_DATE%TYPE := NULL;
		D_WORK_START_DATE                                 HRD_DUTY_PERIOD.WORK_START_DATE%TYPE := NULL;
		D_REAL_START_DATE                                 HRD_DUTY_PERIOD.REAL_START_DATE%TYPE := NULL;
		D_WORK_END_DATE                                   HRD_DUTY_PERIOD.WORK_END_DATE%TYPE := NULL;
		D_REAL_END_DATE                                   HRD_DUTY_PERIOD.REAL_END_DATE%TYPE := NULL;

		V_CORP_ID                                         HRD_DUTY_PERIOD.CORP_ID%TYPE := NULL;
		V_PERSON_ID                                       HRD_DUTY_PERIOD.PERSON_ID%TYPE := NULL;
		V_SOB_ID                                          HRD_DUTY_PERIOD.SOB_ID%TYPE := NULL;
		V_ORG_ID                                          HRD_DUTY_PERIOD.ORG_ID%TYPE := NULL;

  BEGIN
	  BEGIN
		  SELECT DP.CORP_ID, DP.PERSON_ID, DP.SOB_ID, DP.ORG_ID, DP.APPROVE_STATUS
			  INTO V_CORP_ID, V_PERSON_ID, V_SOB_ID, V_ORG_ID, V_APPROVE_STATUS
			FROM HRD_DUTY_PERIOD DP
			WHERE DP.DUTY_PERIOD_ID                  = W_DUTY_PERIOD_ID
			;
		EXCEPTION WHEN OTHERS THEN
		  V_APPROVE_STATUS := 'N';
		END;
		IF V_APPROVE_STATUS NOT IN('A', 'N') THEN
		  RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=Modify(수정)'));
			RETURN;
		END IF;
	  D_START_DATE := TO_DATE(TO_CHAR(P_START_DATE, 'YYYY-MM-DD') || P_START_TIME, 'YYYY-MM-DD HH24:MI');
		D_END_DATE := TO_DATE(TO_CHAR(P_END_DATE, 'YYYY-MM-DD') || P_END_TIME, 'YYYY-MM-DD HH24:MI');
    -- 근태 기간 범위 Validate Check --
    IF D_END_DATE < D_START_DATE THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10012', NULL));
    END IF;
    
		-- 근무시간 정리.
		HRD_DUTY_PERIOD_G.WORK_DATE(P_CORP_ID => V_CORP_ID
		                           , P_PERSON_ID => V_PERSON_ID
															 , P_SOB_ID => V_SOB_ID
															 , P_ORG_ID => V_ORG_ID
		                           , P_START_DATE => D_START_DATE
		                           , P_END_DATE => D_END_DATE
															 , O_WORK_START_DATE => D_WORK_START_DATE
															 , O_WORK_END_DATE => D_WORK_END_DATE
															 , O_REAL_START_DATE => D_REAL_START_DATE
															 , O_REAL_END_DATE => D_REAL_END_DATE
															 );

		UPDATE HRD_DUTY_PERIOD DP
			SET DP.START_DATE                       = D_START_DATE
				, DP.END_DATE                         = D_END_DATE
				, DP.WORK_START_DATE                  = D_WORK_START_DATE
				, DP.REAL_START_DATE                  = D_REAL_START_DATE
				, DP.WORK_END_DATE                    = D_WORK_END_DATE
				, DP.REAL_END_DATE                    = D_REAL_END_DATE
				, DP.DESCRIPTION                      = P_DESCRIPTION
				, DP.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(DP.SOB_ID)
				, DP.LAST_UPDATED_BY                  = P_USER_ID
		WHERE DP.DUTY_PERIOD_ID                   = W_DUTY_PERIOD_ID
		;

  END DATA_UPDATE;

-- DATA DELETE.
  PROCEDURE DATA_DELETE
	          ( W_DUTY_PERIOD_ID                        IN HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE
						)
  AS
    V_APPROVE_STATUS                                  HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE := 'N';

	BEGIN
	  BEGIN
		  SELECT DP.APPROVE_STATUS
			  INTO V_APPROVE_STATUS
			FROM HRD_DUTY_PERIOD DP
			WHERE DP.DUTY_PERIOD_ID                         = W_DUTY_PERIOD_ID
			;
		EXCEPTION WHEN OTHERS THEN
		  V_APPROVE_STATUS := 'N';
		END;
		IF V_APPROVE_STATUS NOT IN('A', 'N') THEN
		  RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10029', '&&VALUE:=Data(해당 자료)'));
		END IF;

		DELETE HRD_DUTY_PERIOD DP
		WHERE DP.DUTY_PERIOD_ID                           = W_DUTY_PERIOD_ID
		;
  END DATA_DELETE;

-- 고정근태 반려처리를 위한 조회.
  PROCEDURE DUTY_PERIOD_RETURN_SELECT
	          ( P_CURSOR1                               OUT TYPES.TCURSOR1
						, W_CORP_ID                               IN HRD_DUTY_PERIOD.CORP_ID%TYPE
						, W_START_DATE                            IN HRD_DUTY_PERIOD.START_DATE%TYPE
						, W_END_DATE                              IN HRD_DUTY_PERIOD.END_DATE%TYPE
						, W_APPROVE_STATUS                        IN HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE
						, W_DUTY_ID                               IN HRD_DUTY_PERIOD.DUTY_ID%TYPE
						, W_FLOOR_ID                              IN HRM_PERSON_MASTER.FLOOR_ID%TYPE
						, W_PERSON_ID                             IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_SOB_ID                                IN HRD_DUTY_PERIOD.SOB_ID%TYPE
						, W_ORG_ID                                IN HRD_DUTY_PERIOD.ORG_ID%TYPE
						)
  AS
    V_CONNECT_PERSON_ID                               HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
  BEGIN
	  -- 근태권한 설정.
		IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID
		                           , W_START_DATE => W_START_DATE
															 , W_END_DATE => W_END_DATE
															 , W_MODULE_CODE => '20'
															 , W_PERSON_ID => W_CONNECT_PERSON_ID
															 , W_SOB_ID => W_SOB_ID
															 , W_ORG_ID => W_ORG_ID) = 'C' THEN
		  V_CONNECT_PERSON_ID := NULL;
		ELSE
		  V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
		END IF;
		IF W_APPROVE_STATUS IN('A', 'N') THEN
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;
    OPEN P_CURSOR1 FOR
      SELECT 'N' AS SELECT_YN
           , DP.REJECT_REMARK
           , DP.PERSON_ID
           , PM.PERSON_NUM
					 , PM.NAME
           , HRM_COMMON_G.ID_NAME_F(DP.DUTY_ID) DUTY_NAME
					 , TRUNC(DP.START_DATE) AS START_DATE
					 , TO_CHAR(DP.START_DATE, 'HH24:MI') AS START_TIME
					 , TRUNC(DP.END_DATE) AS END_DATE
					 , TO_CHAR(DP.END_DATE, 'HH24:MI') AS END_TIME
           , DP.DESCRIPTION
					 , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DP.APPROVE_STATUS, DP.SOB_ID, DP.ORG_ID) APPROVE_STATUS_NAME
					 , HRM_COMMON_G.ID_NAME_F(T1.FLOOR_ID) AS FLOOR_NAME
					 , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
           , DP.DUTY_PERIOD_ID
			FROM HRD_DUTY_PERIOD DP
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
																					 WHERE S_HL.CHARGE_DATE            <= W_END_DATE
																					   AND S_HL.PERSON_ID              = HL.PERSON_ID
																					 GROUP BY S_HL.PERSON_ID
																				 )
					) T1
				, HRM_WORK_TYPE_V WT
			WHERE DP.PERSON_ID                          = PM.PERSON_ID
				AND DP.SOB_ID                             = PM.SOB_ID
				AND DP.ORG_ID                             = PM.ORG_ID
				AND PM.PERSON_ID                          = T1.PERSON_ID
				AND PM.WORK_TYPE_ID                       = WT.WORK_TYPE_ID
				AND TRUNC(DP.START_DATE)                  <= W_END_DATE
				AND TRUNC(DP.END_DATE)                    >= W_START_DATE
				AND DP.PERSON_ID                          = NVL(W_PERSON_ID, DP.PERSON_ID)
				AND DP.DUTY_ID                            = NVL(W_DUTY_ID, DP.DUTY_ID)
				AND DP.CORP_ID                            = W_CORP_ID
				AND DP.SOB_ID                             = W_SOB_ID
				AND DP.ORG_ID                             = W_ORG_ID
				AND T1.FLOOR_ID                           = NVL(W_FLOOR_ID, T1.FLOOR_ID)
				AND DP.APPROVE_STATUS                     = NVL(W_APPROVE_STATUS, DP.APPROVE_STATUS)
				AND EXISTS (SELECT 'X'
				            FROM HRD_DUTY_MANAGER DM
										WHERE DM.CORP_ID              = DP.CORP_ID
										  AND DM.DUTY_CONTROL_ID      = T1.FLOOR_ID
											AND DM.WORK_TYPE_ID         = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
											AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
											AND DM.SOB_ID               = DP.SOB_ID
											AND DM.ORG_ID               = DP.ORG_ID
									  )
      ;
  END DUTY_PERIOD_RETURN_SELECT;

-- 고정근태 반려처리.
  PROCEDURE DATA_UPDATE_RETURN_APPROVE
	          ( W_DUTY_PERIOD_ID                        IN HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE
            , P_REJECT_REMARK                         IN HRD_DUTY_PERIOD.REJECT_REMARK%TYPE
            , P_APPROVE_STATUS                        IN HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE
						, P_CHECK_YN                              IN VARCHAR2
						, P_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, P_SOB_ID                                IN HRD_DUTY_PERIOD.SOB_ID%TYPE
						, P_ORG_ID                                IN HRD_DUTY_PERIOD.ORG_ID%TYPE
						, P_USER_ID                               IN HRD_DUTY_PERIOD.CREATED_BY%TYPE
						)
  AS
    V_APPROVE_STATUS                                  HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE := 'N';
	  D_SYSDATE                                         HRD_DUTY_PERIOD.CREATION_DATE%TYPE := NULL;
		V_CAP_B                                           VARCHAR2(1) := 'N';
    V_CAP_C                                           VARCHAR2(1) := 'N';
    V_DUTY_CODE_TYPE                                  VARCHAR2(10) := NULL;
    V_ATTEND_FLAG                                     VARCHAR2(20) := 'N';
  BEGIN
	  BEGIN
      SELECT HRM_MANAGER_G.USER_CAP_F
                             (PM.CORP_ID
                             , TRUNC(DP.START_DATE)
                             , TRUNC(DP.END_DATE)
                             , '20'
                             , P_CONNECT_PERSON_ID
                             , P_SOB_ID
                             , P_ORG_ID) AS CAP_C
           , HRD_DUTY_MANAGER_G.APPROVER_CAP_F
                             ( NVL(T1.FLOOR_ID, PM.FLOOR_ID)
                             , P_CONNECT_PERSON_ID
                             , P_SOB_ID
                             , P_ORG_ID) AS CAP_B
        INTO V_CAP_C, V_CAP_B
      FROM HRD_DUTY_PERIOD DP
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
                                           WHERE S_HL.CHARGE_DATE            <= ( SELECT TRUNC(DP1.END_DATE) END_DATE
                                                                                    FROM HRD_DUTY_PERIOD DP1
                                                                                  WHERE DP1.DUTY_PERIOD_ID  = W_DUTY_PERIOD_ID
                                                                                 )
                                             AND S_HL.PERSON_ID              = HL.PERSON_ID
                                           GROUP BY S_HL.PERSON_ID
                                         )
          ) T1
      WHERE DP.PERSON_ID                          = PM.PERSON_ID
        AND DP.SOB_ID                             = PM.SOB_ID
        AND DP.ORG_ID                             = PM.ORG_ID
        AND PM.PERSON_ID                          = T1.PERSON_ID
        AND DP.DUTY_PERIOD_ID                     = W_DUTY_PERIOD_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CAP_B := 'N';
      V_CAP_C := 'N';
    END;
    
		IF P_APPROVE_STATUS IN('A', 'B') THEN
		-- 미승인 --> 1차 승인 : 승인.
      IF V_CAP_B <> 'Y' THEN
        RAISE ERRNUMS.Approval_Nothing;
      END IF;
		ELSIF P_APPROVE_STATUS IN('B', 'C') THEN
		-- 1차 승인  --> 인사 승인: 승인.
      IF V_CAP_C <> 'C' THEN
        RAISE ERRNUMS.Approval_Nothing;
      END IF;
		ELSE
		-- 승인단계 선택 안함.
			RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10043', '&&VALUE:=승인상태&&TEXT:=승인상태를 선택후 다시 처리하세요'));
			RETURN;
		END IF;
    -- 근태 반려사항 적용.
    UPDATE HRD_DUTY_PERIOD DP
      SET DP.REJECT_REMARK                    = P_REJECT_REMARK
        , DP.REJECT_YN                        = 'Y'
        , DP.REJECT_DATE                      = GET_LOCAL_DATE(DP.SOB_ID)
        , DP.REJECT_PERSON_ID                 = P_CONNECT_PERSON_ID
        , DP.APPROVE_STATUS                   = 'R'
        , DP.EMAIL_STATUS                     = 'RR'
        , DP.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(DP.SOB_ID)
        , DP.LAST_UPDATED_BY                  = P_USER_ID
    WHERE DP.DUTY_PERIOD_ID                   = W_DUTY_PERIOD_ID
    ;
		COMMIT;
	EXCEPTION WHEN ERRNUMS.Approval_Nothing THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Approval_Nothing_Code, ERRNUMS.Approval_Nothing_Desc);
  END DATA_UPDATE_RETURN_APPROVE;
  
-- DATA DELETE-1차 승인된 것두 삭제.
  PROCEDURE DATA_DELETE1
	          ( W_DUTY_PERIOD_ID                        IN HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE
						)
  AS
    V_APPROVE_STATUS                                  HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE := 'N';
	BEGIN
	  BEGIN
		  SELECT DP.APPROVE_STATUS
			  INTO V_APPROVE_STATUS
			FROM HRD_DUTY_PERIOD DP
			WHERE DP.DUTY_PERIOD_ID                         = W_DUTY_PERIOD_ID
			;
		EXCEPTION WHEN OTHERS THEN
		  V_APPROVE_STATUS := 'N';
		END;
		IF V_APPROVE_STATUS NOT IN('A', 'N', 'B') THEN
		  RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10029', '&&VALUE:=Data(해당 자료)'));
		END IF;

		DELETE HRD_DUTY_PERIOD DP
		WHERE DP.DUTY_PERIOD_ID                           = W_DUTY_PERIOD_ID
		;
  END DATA_DELETE1;
  
-- DATA UPDATE REQUEST.
  PROCEDURE DATA_UPDATE_REQUEST
            ( W_DUTY_PERIOD_ID                        IN HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE
            , O_APPROVE_STATUS                        OUT VARCHAR2
            , O_APPROVE_STATUS_NAME                   OUT VARCHAR2
            )
  AS
    V_APPROVE_STATUS                                  VARCHAR2(1);
    
  BEGIN
    BEGIN
		  SELECT DP.APPROVE_STATUS
			  INTO V_APPROVE_STATUS
			FROM HRD_DUTY_PERIOD DP
			WHERE DP.DUTY_PERIOD_ID                         = W_DUTY_PERIOD_ID
			;
		EXCEPTION WHEN OTHERS THEN
		  V_APPROVE_STATUS := 'N';
		END;
		IF V_APPROVE_STATUS NOT IN('A', 'N') THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=Approval Request(승인요청)'));
    END IF;
		
    UPDATE HRD_DUTY_PERIOD DP
      SET DP.APPROVE_STATUS           = 'A'
        , DP.EMAIL_STATUS             = 'AR'
    WHERE DP.DUTY_PERIOD_ID           = W_DUTY_PERIOD_ID
    ;
    
    O_APPROVE_STATUS := 'A';
    BEGIN
      SELECT HAS.APPROVE_STEP_NAME
        INTO O_APPROVE_STATUS_NAME
        FROM HRM_APPROVE_STATUS_V HAS
      WHERE HAS.APPROVE_STEP        = O_APPROVE_STATUS
        AND ROWNUM                  <= 1
      ;        
    EXCEPTION  
      WHEN OTHERS THEN
        O_APPROVE_STATUS_NAME := '미승인';
    END;
  END DATA_UPDATE_REQUEST;
  
-- DATA UPDATE - STEP APPROVE.
  PROCEDURE DATA_UPDATE_APPROVE
	          ( W_DUTY_PERIOD_ID                        IN HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE
            , P_APPROVE_STATUS                        IN HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE
						, P_CHECK_YN                              IN VARCHAR2
						, P_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, P_APPROVE_FLAG                          IN VARCHAR2
						, P_SOB_ID                                IN HRD_DUTY_PERIOD.SOB_ID%TYPE
						, P_ORG_ID                                IN HRD_DUTY_PERIOD.ORG_ID%TYPE
						, P_USER_ID                               IN HRD_DUTY_PERIOD.CREATED_BY%TYPE
						)
  AS
	  V_APPROVE_STATUS                                  HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE := 'N';
	  D_SYSDATE                                         HRD_DUTY_PERIOD.CREATION_DATE%TYPE := NULL;
		V_CAP_B                                           VARCHAR2(1) := 'N';
    V_CAP_C                                           VARCHAR2(1) := 'N';
    V_DUTY_CODE_TYPE                                  VARCHAR2(10) := NULL;
    V_ATTEND_FLAG                                     VARCHAR2(20) := 'N';
  BEGIN
	  BEGIN
      SELECT HRM_MANAGER_G.USER_CAP_F
                             (PM.CORP_ID
                             , TRUNC(DP.START_DATE)
                             , TRUNC(DP.END_DATE)
                             , '20'
                             , P_CONNECT_PERSON_ID
                             , P_SOB_ID
                             , P_ORG_ID) AS CAP_C
           , HRD_DUTY_MANAGER_G.APPROVER_CAP_F
                             ( NVL(T1.FLOOR_ID, PM.FLOOR_ID)
                             , P_CONNECT_PERSON_ID
                             , P_SOB_ID
                             , P_ORG_ID) AS CAP_B
        INTO V_CAP_C, V_CAP_B
      FROM HRD_DUTY_PERIOD DP
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
                                           WHERE S_HL.CHARGE_DATE            <= ( SELECT TRUNC(DP1.END_DATE) END_DATE
                                                                                    FROM HRD_DUTY_PERIOD DP1
                                                                                  WHERE DP1.DUTY_PERIOD_ID  = W_DUTY_PERIOD_ID
                                                                                 )
                                             AND S_HL.PERSON_ID              = HL.PERSON_ID
                                           GROUP BY S_HL.PERSON_ID
                                         )
          ) T1
      WHERE DP.PERSON_ID                          = PM.PERSON_ID
        AND DP.SOB_ID                             = PM.SOB_ID
        AND DP.ORG_ID                             = PM.ORG_ID
        AND PM.PERSON_ID                          = T1.PERSON_ID
        AND DP.DUTY_PERIOD_ID                     = W_DUTY_PERIOD_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CAP_B := 'N';
      V_CAP_C := 'N';
    END;
    
		IF P_APPROVE_STATUS = 'A' AND P_APPROVE_FLAG = 'OK' THEN
		-- 미승인 --> 1차 승인 : 승인.
      IF V_CAP_B <> 'Y' THEN
        RAISE ERRNUMS.Approval_Nothing;
      END IF;
			UPDATE HRD_DUTY_PERIOD DP
				SET DP.APPROVED_YN                      = DECODE(P_CHECK_YN, 'Y', 'Y', DP.APPROVED_YN)
					, DP.APPROVED_DATE                    = DECODE(P_CHECK_YN, 'Y', GET_LOCAL_DATE(DP.SOB_ID), DP.APPROVED_DATE)
					, DP.APPROVED_PERSON_ID               = DECODE(P_CHECK_YN, 'Y', P_CONNECT_PERSON_ID, DP.APPROVED_PERSON_ID)
					, DP.APPROVE_STATUS                   = DECODE(P_CHECK_YN, 'Y', 'B', DP.APPROVE_STATUS)
          , DP.EMAIL_STATUS                     = 'AR'
					, DP.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(DP.SOB_ID)
					, DP.LAST_UPDATED_BY                  = P_USER_ID
			WHERE DP.DUTY_PERIOD_ID                   = W_DUTY_PERIOD_ID
			;
		ELSIF P_APPROVE_STATUS = 'B' AND P_APPROVE_FLAG = 'CANCEL' THEN
		-- 1차 승인 --> 미승인 : 승인 취소.
      IF V_CAP_B <> 'Y' THEN
        RAISE ERRNUMS.Approval_Nothing;
      END IF;
		  BEGIN
			-- 현재 상태.
			  SELECT DP.APPROVE_STATUS
				  INTO V_APPROVE_STATUS
				FROM HRD_DUTY_PERIOD DP
				WHERE DP.DUTY_PERIOD_ID                 = W_DUTY_PERIOD_ID
				;
			EXCEPTION WHEN OTHERS THEN
			  V_APPROVE_STATUS := 'N';
			END;
			IF V_APPROVE_STATUS <> 'B' THEN
			-- 1ST 승인단계가 아니면 오류 발생.
				RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=취소'));
				RETURN;
			END IF;

			UPDATE HRD_DUTY_PERIOD DP
				SET DP.APPROVED_YN                      = DECODE(P_CHECK_YN, 'Y', 'N', DP.APPROVED_YN)
					, DP.APPROVED_DATE                    = DECODE(P_CHECK_YN, 'Y', NULL, DP.APPROVED_DATE)
					, DP.APPROVED_PERSON_ID               = DECODE(P_CHECK_YN, 'Y', NULL, DP.APPROVED_PERSON_ID)
					, DP.APPROVE_STATUS                   = DECODE(P_CHECK_YN, 'Y', 'A', DP.APPROVE_STATUS)
          , DP.EMAIL_STATUS                     = 'BR'
					, DP.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(DP.SOB_ID)
					, DP.LAST_UPDATED_BY                  = P_USER_ID
			WHERE DP.DUTY_PERIOD_ID                   = W_DUTY_PERIOD_ID
			;
		ELSIF P_APPROVE_STATUS = 'B' AND P_APPROVE_FLAG = 'OK' THEN
		-- 1차 승인  --> 인사 승인: 승인.
      IF V_CAP_C <> 'C' THEN
        RAISE ERRNUMS.Approval_Nothing;
      END IF;
			UPDATE HRD_DUTY_PERIOD DP
				SET DP.CONFIRMED_YN                     = DECODE(P_CHECK_YN, 'Y', 'Y', DP.CONFIRMED_YN)
					, DP.CONFIRMED_DATE                   = DECODE(P_CHECK_YN, 'Y', GET_LOCAL_DATE(DP.SOB_ID), DP.CONFIRMED_DATE)
					, DP.CONFIRMED_PERSON_ID              = DECODE(P_CHECK_YN, 'Y', P_CONNECT_PERSON_ID, DP.CONFIRMED_PERSON_ID)
					, DP.APPROVE_STATUS                   = DECODE(P_CHECK_YN, 'Y', 'C', DP.APPROVE_STATUS)
					, DP.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(DP.SOB_ID)
					, DP.LAST_UPDATED_BY                  = P_USER_ID
			WHERE DP.DUTY_PERIOD_ID                   = W_DUTY_PERIOD_ID
			;
      
      /*-- 근무 카렌다 반영 START. --*/
      V_ATTEND_FLAG := ATTEND_FLAG_F(W_DUTY_PERIOD_ID);
      IF V_ATTEND_FLAG = 'LATE_IN' THEN
      -- 지각.
        UPDATE HRD_WORK_CALENDAR WC
           SET (WC.LATE_IN_FR
              , WC.LATE_IN_TO)
               =
               ( SELECT DP.START_DATE AS LATE_IN_FR
                      , DP.END_DATE AS LATE_IN_TO                      
                 FROM HRD_DUTY_PERIOD DP
                 WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                   AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                   AND DP.PERSON_ID         = WC.PERSON_ID
                   AND DP.CORP_ID           = WC.CORP_ID
                   AND DP.SOB_ID            = WC.SOB_ID
                   AND DP.ORG_ID            = WC.ORG_ID
               )
        WHERE EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_PERIOD DP
                       WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                         AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                         AND DP.PERSON_ID         = WC.PERSON_ID
                         AND DP.CORP_ID           = WC.CORP_ID
                         AND DP.SOB_ID            = WC.SOB_ID
                         AND DP.ORG_ID            = WC.ORG_ID
                     )
        ;
      ELSIF V_ATTEND_FLAG = 'EARLY_OUT' THEN
      -- 조퇴.
        UPDATE HRD_WORK_CALENDAR WC
           SET (WC.EARLY_OUT_FR
              , WC.EARLY_OUT_TO)
               =
               ( SELECT DP.START_DATE AS EARLY_OUT_FR
                      , DP.END_DATE AS EARLY_OUT_TO                      
                 FROM HRD_DUTY_PERIOD DP
                 WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                   AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                   AND DP.PERSON_ID         = WC.PERSON_ID
                   AND DP.CORP_ID           = WC.CORP_ID
                   AND DP.SOB_ID            = WC.SOB_ID
                   AND DP.ORG_ID            = WC.ORG_ID
               )
        WHERE EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_PERIOD DP
                       WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                         AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                         AND DP.PERSON_ID         = WC.PERSON_ID
                         AND DP.CORP_ID           = WC.CORP_ID
                         AND DP.SOB_ID            = WC.SOB_ID
                         AND DP.ORG_ID            = WC.ORG_ID
                     )
        ;
      ELSIF V_ATTEND_FLAG = 'SHORT_OUT' THEN
      -- 외출.        
        UPDATE HRD_WORK_CALENDAR WC
           SET (WC.SHORT_OUT_FR
               , WC.SHORT_OUT_TO)
               =
               ( SELECT DP.START_DATE AS SHORT_OUT_FR
                      , DP.END_DATE AS SHORT_OUT_TO                  
                 FROM HRD_DUTY_PERIOD DP
                 WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                   AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                   AND DP.PERSON_ID         = WC.PERSON_ID
                   AND DP.CORP_ID           = WC.CORP_ID
                   AND DP.SOB_ID            = WC.SOB_ID
                   AND DP.ORG_ID            = WC.ORG_ID
               )
        WHERE EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_PERIOD DP
                       WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                         AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                         AND DP.PERSON_ID         = WC.PERSON_ID
                         AND DP.CORP_ID           = WC.CORP_ID
                         AND DP.SOB_ID            = WC.SOB_ID
                         AND DP.ORG_ID            = WC.ORG_ID
                     )
        ;
      ELSIF V_ATTEND_FLAG = 'WORK_OUT' THEN
      -- 외근.
        UPDATE HRD_WORK_CALENDAR WC
           SET (WC.WORK_OUT_FR
              , WC.WORK_OUT_TO)
               =
               ( SELECT DP.START_DATE AS WORK_OUT_FR
                      , DP.END_DATE AS WORK_OUT_TO                      
                 FROM HRD_DUTY_PERIOD DP
                 WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                   AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                   AND DP.PERSON_ID         = WC.PERSON_ID
                   AND DP.CORP_ID           = WC.CORP_ID
                   AND DP.SOB_ID            = WC.SOB_ID
                   AND DP.ORG_ID            = WC.ORG_ID
               )
        WHERE EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_PERIOD DP
                       WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                         AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                         AND DP.PERSON_ID         = WC.PERSON_ID
                         AND DP.CORP_ID           = WC.CORP_ID
                         AND DP.SOB_ID            = WC.SOB_ID
                         AND DP.ORG_ID            = WC.ORG_ID
                     )
        ;
      ELSE      
        /*-- 근무 카렌다 반영 START. --*/
        UPDATE HRD_WORK_CALENDAR WC
           SET (WC.C_DUTY_ID
             , WC.C_DUTY_ID1
             , WC.OPEN_TIME
             , WC.CLOSE_TIME
             , WC.OLD_OPEN_TIME
             , WC.OLD_CLOSE_TIME
             , WC.LAST_UPDATE_DATE
             , WC.LAST_UPDATED_BY)
             =
             ( SELECT CASE
                        WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                        ELSE DECODE(WC.C_DUTY_ID, NULL, DP.DUTY_ID, WC.C_DUTY_ID)
                      END AS C_DUTY_ID
                    , CASE
                        WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                        ELSE DECODE(WC.C_DUTY_ID, NULL, NULL, DP.DUTY_ID) 
                      END AS C_DUTY_ID1
                    , CASE
                        WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                        ELSE DECODE(WC.WORK_DATE, DP.WORK_START_DATE, DP.REAL_START_DATE, NULL)
                      END AS OPEN_TIME
                    , CASE
                        WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                        ELSE DECODE(WC.WORK_DATE, DP.WORK_END_DATE, DP.REAL_END_DATE, NULL)
                      END AS CLOSE_TIME
                    , CASE
                        WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                        ELSE WC.OPEN_TIME 
                      END AS OLD_START_TIME
                    , CASE
                        WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                        ELSE WC.CLOSE_TIME 
                      END AS OLD_CLOSE_TIME
                    , GET_LOCAL_DATE(DP.SOB_ID)
                    , P_USER_ID
               FROM HRD_DUTY_PERIOD DP
               WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                 AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                 AND DP.PERSON_ID         = WC.PERSON_ID
                 AND DP.CORP_ID           = WC.CORP_ID
                 AND DP.SOB_ID            = WC.SOB_ID
                 AND DP.ORG_ID            = WC.ORG_ID
             )
        WHERE EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_PERIOD DP
                       WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                         AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                         AND DP.PERSON_ID         = WC.PERSON_ID
                         AND DP.CORP_ID           = WC.CORP_ID
                         AND DP.SOB_ID            = WC.SOB_ID
                         AND DP.ORG_ID            = WC.ORG_ID
                     )
        ;
      END IF;
		  /*-- 근무 카렌다 반영 END. --*/

		ELSIF P_APPROVE_STATUS = 'C' AND P_APPROVE_FLAG = 'CANCEL' THEN
		-- 확정 승인 --> 1차 승인 : 승인 취소.
      IF V_CAP_C <> 'C' THEN
        RAISE ERRNUMS.Approval_Nothing;
      END IF;
		  BEGIN
			-- 현재 상태.
			  SELECT DP.APPROVE_STATUS
				  INTO V_APPROVE_STATUS
				FROM HRD_DUTY_PERIOD DP
				WHERE DP.DUTY_PERIOD_ID                 = W_DUTY_PERIOD_ID
				;
			EXCEPTION WHEN OTHERS THEN
			  V_APPROVE_STATUS := 'N';
			END;
			IF V_APPROVE_STATUS <> 'C' THEN
			-- 1ST 승인단계가 아니면 오류 발생.
				RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=취소'));
				RETURN;
			END IF;
      
      UPDATE HRD_DUTY_PERIOD DP
        SET DP.CONFIRMED_YN                     = DECODE(P_CHECK_YN, 'Y', 'N', DP.CONFIRMED_YN)
          , DP.CONFIRMED_DATE                   = DECODE(P_CHECK_YN, 'Y', NULL, DP.CONFIRMED_DATE)
          , DP.CONFIRMED_PERSON_ID              = DECODE(P_CHECK_YN, 'Y', NULL, DP.CONFIRMED_PERSON_ID)
          , DP.APPROVE_STATUS                   = 'B'
          , DP.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(DP.SOB_ID)
          , DP.LAST_UPDATED_BY                  = P_USER_ID
      WHERE DP.DUTY_PERIOD_ID                   = W_DUTY_PERIOD_ID
      ;
       
      /*-- 근무 카렌다 반영 START. --*/
      V_ATTEND_FLAG := ATTEND_FLAG_F(W_DUTY_PERIOD_ID);
      IF V_ATTEND_FLAG = 'LATE_IN' THEN
      -- 지각.
        UPDATE HRD_WORK_CALENDAR WC
           SET WC.LATE_IN_FR   = NULL
             , WC.LATE_IN_TO   = NULL
        WHERE EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_PERIOD DP
                       WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                         AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                         AND DP.PERSON_ID         = WC.PERSON_ID
                         AND DP.CORP_ID           = WC.CORP_ID
                         AND DP.SOB_ID            = WC.SOB_ID
                         AND DP.ORG_ID            = WC.ORG_ID
                     )
        ;
      ELSIF V_ATTEND_FLAG = 'EARLY_OUT' THEN
      -- 조퇴.
        UPDATE HRD_WORK_CALENDAR WC
           SET WC.EARLY_OUT_FR   = NULL
             , WC.EARLY_OUT_TO   = NULL
        WHERE EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_PERIOD DP
                       WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                         AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                         AND DP.PERSON_ID         = WC.PERSON_ID
                         AND DP.CORP_ID           = WC.CORP_ID
                         AND DP.SOB_ID            = WC.SOB_ID
                         AND DP.ORG_ID            = WC.ORG_ID
                     )
        ;
      ELSIF V_ATTEND_FLAG = 'SHORT_OUT' THEN
      -- 외출.        
        UPDATE HRD_WORK_CALENDAR WC
           SET WC.SHORT_OUT_FR   = NULL
             , WC.SHORT_OUT_TO   = NULL
        WHERE EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_PERIOD DP
                       WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                         AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                         AND DP.PERSON_ID         = WC.PERSON_ID
                         AND DP.CORP_ID           = WC.CORP_ID
                         AND DP.SOB_ID            = WC.SOB_ID
                         AND DP.ORG_ID            = WC.ORG_ID
                     )
        ;
      ELSIF V_ATTEND_FLAG = 'WORK_OUT' THEN
      -- 외근.
        UPDATE HRD_WORK_CALENDAR WC
           SET WC.WORK_OUT_FR   = NULL
             , WC.WORK_OUT_TO   = NULL
        WHERE EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_PERIOD DP
                       WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                         AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                         AND DP.PERSON_ID         = WC.PERSON_ID
                         AND DP.CORP_ID           = WC.CORP_ID
                         AND DP.SOB_ID            = WC.SOB_ID
                         AND DP.ORG_ID            = WC.ORG_ID
                     )
        ;
      ELSE
        UPDATE HRD_WORK_CALENDAR WC
           SET (WC.C_DUTY_ID
             , WC.C_DUTY_ID1
             , WC.OPEN_TIME
             , WC.CLOSE_TIME
             , WC.OLD_OPEN_TIME
             , WC.OLD_CLOSE_TIME
             , WC.LAST_UPDATE_DATE
             , WC.LAST_UPDATED_BY)
             =
             ( SELECT DECODE(WC.C_DUTY_ID, DP.DUTY_ID, NULL, WC.C_DUTY_ID) AS C_DUTY_ID
                    , DECODE(WC.C_DUTY_ID1, DP.DUTY_ID, NULL, WC.C_DUTY_ID1) AS C_DUTY_ID1
                    , DECODE(WC.OPEN_TIME, DP.REAL_START_DATE, WC.OLD_OPEN_TIME, WC.OPEN_TIME) AS OPEN_TIME
                    , DECODE(WC.CLOSE_TIME, DP.REAL_END_DATE, WC.OLD_CLOSE_TIME, WC.CLOSE_TIME) AS CLOSE_TIME
                    , DECODE(WC.OPEN_TIME, DP.REAL_START_DATE, NULL, WC.OLD_OPEN_TIME) AS OLD_START_TIME
                    , DECODE(WC.CLOSE_TIME, DP.REAL_END_DATE, NULL, WC.OLD_CLOSE_TIME) AS OLD_CLOSE_TIME
                    , GET_LOCAL_DATE(DP.SOB_ID)
                    , P_USER_ID
               FROM HRD_DUTY_PERIOD DP
               WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                 AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                 AND DP.PERSON_ID         = WC.PERSON_ID
                 AND DP.CORP_ID           = WC.CORP_ID
                 AND DP.SOB_ID            = WC.SOB_ID
                 AND DP.ORG_ID            = WC.ORG_ID
             )
        WHERE EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_PERIOD DP
                       WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                         AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                         AND DP.PERSON_ID         = WC.PERSON_ID
                         AND DP.CORP_ID           = WC.CORP_ID
                         AND DP.SOB_ID            = WC.SOB_ID
                         AND DP.ORG_ID            = WC.ORG_ID
                     )
        ;
      END IF;
		  /*-- 근무 카렌다 반영 END. --*/

		ELSE
		-- 승인단계 선택 안함.
			RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10043', '&&VALUE:=승인상태&&TEXT:=승인상태를 선택후 다시 처리하세요'));
			RETURN;
		END IF;
		COMMIT;
	EXCEPTION WHEN ERRNUMS.Approval_Nothing THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Approval_Nothing_Code, ERRNUMS.Approval_Nothing_Desc);
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
					AND WC.CORP_ID                          = P_CORP_ID
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
					AND WC.CORP_ID                          = P_CORP_ID
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
        AND DPT.SOB_ID                                  = WC.SOB_ID
        AND DPT.ORG_ID                                  = WC.ORG_ID
				AND WC.WORK_DATE                                = W_WORK_DATE
				AND WC.PERSON_ID                                = W_PERSON_ID
				AND WC.CORP_ID                                  = W_CORP_ID
				AND WC.SOB_ID                                   = W_SOB_ID
				AND WC.ORG_ID                                   = W_ORG_ID
				AND DPT.START_YN                                = NVL(W_START_YN, DPT.START_YN)
				AND DPT.END_YN                                  = NVL(W_END_YN, DPT.END_YN)
				AND DPT.EFFECTIVE_DATE_FR                       <= W_WORK_DATE
				AND (DPT.EFFECTIVE_DATE_TO IS NULL OR DPT.EFFECTIVE_DATE_TO >= W_WORK_DATE)
			ORDER BY DPT.PERIOD_TIME
      ;

  END LU_PERIOD_TIME;

-- 지각/조퇴/외출/외근 신청 여부 체크.
  FUNCTION ATTEND_FLAG_F
            ( W_DUTY_PERIOD_ID           IN HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE
            ) RETURN VARCHAR2        
  AS
    V_ATTEND_FLAG                   VARCHAR2(20) := 'N';
    
  BEGIN
    BEGIN
      SELECT DC.ATTEND_FLAG
        INTO V_ATTEND_FLAG
        FROM HRD_DUTY_PERIOD DP
          , HRM_DUTY_CODE_V DC
      WHERE DP.DUTY_ID        = DC.DUTY_ID
        AND DP.DUTY_PERIOD_ID = W_DUTY_PERIOD_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    RETURN V_ATTEND_FLAG;
  END ATTEND_FLAG_F;

-- 반차일 경우 데이터 검증.
  FUNCTION DUTY_21_CHECK_F
	          ( P_PERSON_ID                IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
						, P_DUTY_ID                  IN HRD_DUTY_PERIOD.DUTY_ID%TYPE
						, P_START_DATE               IN HRD_DUTY_PERIOD.START_DATE%TYPE
						, P_START_TIME               IN VARCHAR2
						, P_END_DATE                 IN HRD_DUTY_PERIOD.END_DATE%TYPE
						, P_END_TIME                 IN VARCHAR2
						, P_SOB_ID                   IN HRD_DUTY_PERIOD.SOB_ID%TYPE
						, P_ORG_ID                   IN HRD_DUTY_PERIOD.ORG_ID%TYPE
						) RETURN VARCHAR2
  AS
    V_CHECK_YN                           VARCHAR2(1) := 'N';
    V_HOLY_TYPE                          VARCHAR2(2);
    V_START_TIME                         VARCHAR2(5);
    V_END_TIME                           VARCHAR2(5);
  BEGIN
    -- 근무계획 : 시작일자.
    BEGIN
      SELECT WC.HOLY_TYPE
           , TO_CHAR(WC.OPEN_TIME, 'HH24:MI') AS OPEN_TIME
        INTO V_HOLY_TYPE, V_START_TIME
        FROM HRD_WORK_CALENDAR WC
      WHERE WC.WORK_DATE        = TRUNC(P_START_DATE)
        AND WC.PERSON_ID        = P_PERSON_ID
        AND WC.SOB_ID           = P_SOB_ID
        AND WC.ORG_ID           = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_START_TIME := '00:00';
    END;
    -- 근무계획 : 종료일자.
    BEGIN
      SELECT TO_CHAR(WC.CLOSE_TIME, 'HH24:MI') AS END_TIME
        INTO V_END_TIME
        FROM HRD_WORK_CALENDAR WC
      WHERE WC.WORK_DATE        = TRUNC(P_END_DATE)
        AND WC.PERSON_ID        = P_PERSON_ID
        AND WC.SOB_ID           = P_SOB_ID
        AND WC.ORG_ID           = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_END_TIME := '00:00';
    END;
      
    IF P_START_TIME = '00:00' OR P_END_TIME = '00:00' THEN
      V_CHECK_YN := 'N';
    ELSE
      V_CHECK_YN := 'Y';
    END IF;
    RETURN V_CHECK_YN;
  END DUTY_21_CHECK_F;
  
END HRD_DUTY_PERIOD_G; 
/
