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

-- DATA INSERT - 1차 승인된 상태로 삽입.
  PROCEDURE DATA_INSERT1
	          ( P_CORP_ID                               IN HRD_DUTY_PERIOD.CORP_ID%TYPE
						, P_PERSON_ID                             IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
						, P_DUTY_ID                               IN HRD_DUTY_PERIOD.DUTY_ID%TYPE
						, P_START_DATE                            IN HRD_DUTY_PERIOD.START_DATE%TYPE
						, P_START_TIME                            IN VARCHAR2
						, P_END_DATE                              IN HRD_DUTY_PERIOD.END_DATE%TYPE
						, P_END_TIME                              IN VARCHAR2
            , P_APPROVED_YN                           IN HRD_DUTY_PERIOD.APPROVED_YN%TYPE
            , P_APPROVED_DATE                         IN HRD_DUTY_PERIOD.APPROVED_DATE%TYPE
            , P_APPROVED_PERSON_ID                    IN HRD_DUTY_PERIOD.APPROVED_PERSON_ID%TYPE
            , P_APPROVE_STATUS                        IN HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE
						, P_DESCRIPTION                           IN HRD_DUTY_PERIOD.DESCRIPTION%TYPE
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
            , P_DUTY_ID                               IN HRD_DUTY_PERIOD.DUTY_ID%TYPE
						, P_START_DATE                            IN HRD_DUTY_PERIOD.START_DATE%TYPE
						, P_END_DATE                              IN HRD_DUTY_PERIOD.END_DATE%TYPE
						, O_WORK_START_DATE                       OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, O_WORK_END_DATE                         OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, O_REAL_START_DATE                       OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, O_REAL_END_DATE                         OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
            , O_ERROR_CODE                            OUT VARCHAR2
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
      
-- 외출, 지각[2011-08-10]
  PROCEDURE LU_SELECT_DUTY
          ( P_CURSOR3            OUT TYPES.TCURSOR3
          , W_SOB_ID             IN  HRM_COMMON.SOB_ID%TYPE
          , W_ORG_ID             IN  HRM_COMMON.ORG_ID%TYPE
          );


       -- 공통코드 조회 LOOKUP - GROUP CODE..
       PROCEDURE LU_SELECT_GROUP( P_CURSOR3           OUT  TYPES.TCURSOR3
                                , W_GROUP_CODE        IN   HRM_COMMON.GROUP_CODE%TYPE
                                , W_CODE_NAME         IN   HRM_COMMON.CODE_NAME%TYPE
                                , W_SOB_ID            IN   HRM_COMMON.SOB_ID%TYPE
                                , W_ORG_ID            IN   HRM_COMMON.ORG_ID%TYPE
                                , W_ENABLED_FLAG_YN   IN   HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
                                );


-- 지각/조퇴/외출/외근 신청 여부 체크.
  FUNCTION ATTEND_FLAG_F
            ( W_DUTY_PERIOD_ID           IN HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE
            ) RETURN VARCHAR2;

-- 지각/조퇴/외출/외근/직퇴/반차일 경우 데이터 검증.
  FUNCTION DUTY_VALIDATE_YN_F
	          ( P_PERSON_ID                IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
						, P_DUTY_ID                  IN HRD_DUTY_PERIOD.DUTY_ID%TYPE
						, P_START_DATE               IN HRD_DUTY_PERIOD.START_DATE%TYPE
						, P_START_TIME               IN VARCHAR2
						, P_END_DATE                 IN HRD_DUTY_PERIOD.END_DATE%TYPE
						, P_END_TIME                 IN VARCHAR2
						, P_SOB_ID                   IN HRD_DUTY_PERIOD.SOB_ID%TYPE
						, P_ORG_ID                   IN HRD_DUTY_PERIOD.ORG_ID%TYPE
						) RETURN VARCHAR2;


-- [2011-09-06]
   PROCEDURE SELECT_DATA_APPLY
           ( P_CURSOR              OUT TYPES.TCURSOR
           , W_CORP_ID             IN  HRD_DUTY_PERIOD.CORP_ID%TYPE
           , W_START_DATE          IN  HRD_DUTY_PERIOD.START_DATE%TYPE
           , W_END_DATE            IN  HRD_DUTY_PERIOD.END_DATE%TYPE
           , W_APPROVE_STATUS      IN  HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE
           , W_SEARCH_TYPE         IN  HRM_COMMON.CODE%TYPE
           , W_DUTY_ID             IN  HRD_DUTY_PERIOD.DUTY_ID%TYPE
           , W_FLOOR_ID            IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
           , W_PERSON_ID           IN  HRD_DUTY_PERIOD.PERSON_ID%TYPE
           , W_CONNECT_PERSON_ID   IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
           , W_SOB_ID              IN  HRD_DUTY_PERIOD.SOB_ID%TYPE
           , W_ORG_ID              IN  HRD_DUTY_PERIOD.ORG_ID%TYPE
           );


-- [2011-09-06]
   PROCEDURE SELECT_DATA_APPROVE
           ( P_CURSOR              OUT TYPES.TCURSOR
           , W_CORP_ID             IN  HRD_DUTY_PERIOD.CORP_ID%TYPE
           , W_START_DATE          IN  HRD_DUTY_PERIOD.START_DATE%TYPE
           , W_END_DATE            IN  HRD_DUTY_PERIOD.END_DATE%TYPE
           , W_APPROVE_STATUS      IN  HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE
           , W_SEARCH_TYPE         IN  HRM_COMMON.CODE%TYPE
           , W_DUTY_ID             IN  HRD_DUTY_PERIOD.DUTY_ID%TYPE
           , W_FLOOR_ID            IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
           , W_PERSON_ID           IN  HRD_DUTY_PERIOD.PERSON_ID%TYPE
           , W_CONNECT_PERSON_ID   IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
           , W_SOB_ID              IN  HRD_DUTY_PERIOD.SOB_ID%TYPE
           , W_ORG_ID              IN  HRD_DUTY_PERIOD.ORG_ID%TYPE
           );



-- 고정근태 반려처리를 위한 조회.
   PROCEDURE DUTY_PERIOD_RETURN_SELECT
           ( P_CURSOR1             OUT  TYPES.TCURSOR1
           , W_CORP_ID             IN   HRD_DUTY_PERIOD.CORP_ID%TYPE
           , W_START_DATE          IN   HRD_DUTY_PERIOD.START_DATE%TYPE
           , W_END_DATE            IN   HRD_DUTY_PERIOD.END_DATE%TYPE
           , W_APPROVE_STATUS      IN   HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE
           , W_DUTY_ID             IN   HRD_DUTY_PERIOD.DUTY_ID%TYPE
           , W_FLOOR_ID            IN   HRM_PERSON_MASTER.FLOOR_ID%TYPE
           , W_PERSON_ID           IN   HRD_DUTY_PERIOD.PERSON_ID%TYPE
           , W_CONNECT_PERSON_ID   IN   HRM_PERSON_MASTER.PERSON_ID%TYPE
           , W_SOB_ID              IN   HRD_DUTY_PERIOD.SOB_ID%TYPE
           , W_ORG_ID              IN   HRD_DUTY_PERIOD.ORG_ID%TYPE
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


-- [2011-09-26]
   PROCEDURE GET_HOLY_TYPE_WORK_CALENDAR
           ( O_HOLY_TYPE    OUT  HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
           , W_SOB_ID       IN   HRM_PERSON_MASTER.SOB_ID%TYPE
           , W_ORG_ID       IN   HRM_PERSON_MASTER.ORG_ID%TYPE
           , W_SEARCH_DATE  IN   HRD_WORK_CALENDAR.WORK_DATE%TYPE
           , W_PERSON_ID    IN   HRM_PERSON_MASTER.PERSON_ID%TYPE
           );

--REQUEST_LIMIT GET[2011-12-13]
  PROCEDURE GET_REQUEST_LIMIT
          ( O_REQUEST_LIMIT_COUNT  OUT HRM_COMMON.VALUE1%TYPE
          , W_SOB_ID               IN  HRM_COMMON.SOB_ID%TYPE
          , W_ORG_ID               IN  HRM_COMMON.ORG_ID%TYPE
          , W_CODE                 IN  HRM_COMMON.CODE%TYPE
          );

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
           , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
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
			FROM HRD_DUTY_PERIOD DP
				, HRM_PERSON_MASTER PM
				, (-- 시점 인사내역.
						SELECT HL.PERSON_ID
								, HL.DEPT_ID
								, HL.POST_ID
								, HL.JOB_CATEGORY_ID
						FROM HRM_HISTORY_LINE HL
						WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
																						FROM HRM_HISTORY_LINE S_HL
																					 WHERE S_HL.CHARGE_DATE            <= W_END_DATE
																					   AND S_HL.PERSON_ID              = HL.PERSON_ID
																					 GROUP BY S_HL.PERSON_ID
																				 )
					) T1
       , (-- 시점 인사내역.
          SELECT PH.PERSON_ID
               , PH.FLOOR_ID
            FROM HRD_PERSON_HISTORY        PH
           WHERE PH.EFFECTIVE_DATE_FR  <=  W_END_DATE
             AND PH.EFFECTIVE_DATE_TO  >=  W_END_DATE
         ) T2
       , HRM_WORK_TYPE_V WT
   WHERE DP.PERSON_ID                          = PM.PERSON_ID
    AND DP.SOB_ID                             = PM.SOB_ID
    AND DP.ORG_ID                             = PM.ORG_ID
    AND PM.PERSON_ID                          = T1.PERSON_ID
    AND PM.PERSON_ID                          = T2.PERSON_ID
    AND PM.WORK_TYPE_ID                       = WT.WORK_TYPE_ID
    AND DECODE(W_SEARCH_TYPE, 'R', TRUNC(DP.CREATION_DATE), TRUNC(DP.START_DATE)) <= W_END_DATE
    AND DECODE(W_SEARCH_TYPE, 'R', TRUNC(DP.CREATION_DATE), TRUNC(DP.END_DATE))   >= W_START_DATE
    AND DP.PERSON_ID                          = NVL(W_PERSON_ID, DP.PERSON_ID)
    AND DP.DUTY_ID                            = NVL(W_DUTY_ID, DP.DUTY_ID)
    AND DP.CORP_ID                            = W_CORP_ID
    AND DP.SOB_ID                             = W_SOB_ID
    AND DP.ORG_ID                             = W_ORG_ID
    AND T2.FLOOR_ID                           = NVL(W_FLOOR_ID, T2.FLOOR_ID)
    AND DP.APPROVE_STATUS                     = NVL(W_APPROVE_STATUS, DP.APPROVE_STATUS)
    AND EXISTS (SELECT 'X'
                FROM HRD_DUTY_MANAGER DM
          WHERE DM.CORP_ID              = DP.CORP_ID
            AND DM.DUTY_CONTROL_ID      = T2.FLOOR_ID
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
    V_ERROR_CODE                                  VARCHAR2(10) := NULL;
    V_START_DATE                                  VARCHAR2(19) := NULL;
    V_END_DATE                                    VARCHAR2(19) := NULL;
    V_DUTY_PERIOD_ID                              HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE := 0;
    D_SYSDATE                                     DATE := NULL;
    D_START_DATE                                  DATE := NULL;
    D_END_DATE                                    DATE := NULL;
    D_WORK_START_DATE                             HRD_DUTY_PERIOD.WORK_START_DATE%TYPE := NULL;
    D_REAL_START_DATE                             HRD_DUTY_PERIOD.REAL_START_DATE%TYPE := NULL;
    D_WORK_END_DATE                               HRD_DUTY_PERIOD.WORK_END_DATE%TYPE := NULL;
    D_REAL_END_DATE                               HRD_DUTY_PERIOD.REAL_END_DATE%TYPE := NULL;

  BEGIN
    D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
    
    IF P_START_TIME <> ' ' THEN
       V_START_DATE := TO_CHAR(P_START_DATE, 'YYYY-MM-DD') || ' ' ||P_START_TIME || ':00';
       D_START_DATE := TO_DATE(V_START_DATE, 'YYYY-MM-DD HH24:MI:SS');
    ELSE
       D_START_DATE := P_START_DATE;
    END IF;
    
    IF P_END_TIME <> ' ' THEN
       V_END_DATE := TO_CHAR(P_END_DATE, 'YYYY-MM-DD') || ' ' || P_END_TIME || ':00';
       D_END_DATE := TO_DATE(V_END_DATE, 'YYYY-MM-DD HH24:MI:SS');
    ELSE
       D_END_DATE := P_END_DATE;
    END IF;
    
    
    

/*
RAISE_APPLICATION_ERROR(-20001, P_PERSON_ID ||
                       ' | ' || P_START_DATE || 
                       ' | ' || P_START_TIME ||
                       ' | ' || P_END_DATE || 
                       ' | ' || P_END_TIME ||
                       ' | ' || TO_CHAR(D_START_DATE, 'YYYY-MM-DD HH24:MI:SS') || 
                       ' | ' || TO_CHAR(D_END_DATE, 'YYYY-MM-DD HH24:MI:SS') ||
                       ' | ' || D_START_DATE || 
                       ' | ' || D_END_DATE ||
                       ' | ' || P_DUTY_ID ||
                       ' | ' || P_CORP_ID ||
                       ' | ' || P_SOB_ID ||
                       ' | ' || P_ORG_ID
                       );
*/

    -- 근태 기간 범위 Validate Check --
    IF D_END_DATE < D_START_DATE THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10012', NULL));
    END IF;
    
    -- 기존 자료수 체크.
    BEGIN
          SELECT COUNT(DP.PERSON_ID) AS RECORD_COUNT
            INTO V_RECORD_COUNT
            FROM HRD_DUTY_PERIOD DP
           WHERE DP.SOB_ID             = P_SOB_ID
             AND DP.ORG_ID             = P_ORG_ID
             AND DP.PERSON_ID          = P_PERSON_ID
             AND DP.DUTY_ID            = P_DUTY_ID
             AND DP.CORP_ID            = P_CORP_ID
             AND TRUNC(DP.START_DATE) <= TRUNC(D_END_DATE)
             AND TRUNC(DP.END_DATE)   >= TRUNC(D_START_DATE)
               ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;

/*
RAISE_APPLICATION_ERROR(-20001, P_PERSON_ID ||
                       ' | ' || D_START_DATE || 
                       ' | ' || D_END_DATE ||
                       ' | ' || P_DUTY_ID ||
                       ' | ' || P_CORP_ID ||
                       ' | ' || P_SOB_ID ||
                       ' | ' || P_ORG_ID ||
                       ' | ' || V_RECORD_COUNT
                       );

*/
    IF V_RECORD_COUNT <> 0 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10257', NULL));
      RETURN;      
    END IF;

   -- 근무시간 정리.
    HRD_DUTY_PERIOD_G.WORK_DATE
      ( P_CORP_ID => P_CORP_ID
      , P_PERSON_ID => P_PERSON_ID
      , P_SOB_ID => P_SOB_ID
      , P_ORG_ID => P_ORG_ID
      , P_DUTY_ID => P_DUTY_ID
      , P_START_DATE => D_START_DATE
      , P_END_DATE => D_END_DATE
      , O_WORK_START_DATE => D_WORK_START_DATE
      , O_WORK_END_DATE => D_WORK_END_DATE
      , O_REAL_START_DATE => D_REAL_START_DATE
      , O_REAL_END_DATE => D_REAL_END_DATE
      , O_ERROR_CODE => V_ERROR_CODE
      );
    -- 시작/종료일자 기간 검증 및 시간 입력 필수 체크.
    IF V_ERROR_CODE = 'E21' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10275', NULL));
    ELSIF V_ERROR_CODE = 'E100' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10359', NULL));
    END IF; 
    
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
    V_ERROR_CODE                                      VARCHAR2(10) := NULL;
    
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

    V_REJECT_YN                                       HRD_DUTY_PERIOD.REJECT_YN%TYPE := NULL;

  BEGIN
    BEGIN
      SELECT DP.CORP_ID, DP.PERSON_ID, DP.SOB_ID, DP.ORG_ID, DP.APPROVE_STATUS, DP.REJECT_YN
        INTO V_CORP_ID, V_PERSON_ID, V_SOB_ID, V_ORG_ID, V_APPROVE_STATUS, V_REJECT_YN
        FROM HRD_DUTY_PERIOD DP
      WHERE DP.DUTY_PERIOD_ID                  = W_DUTY_PERIOD_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_APPROVE_STATUS := 'N';
    END;
    IF V_APPROVE_STATUS NOT IN('A', 'N') AND V_REJECT_YN = 'N' THEN
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
    HRD_DUTY_PERIOD_G.WORK_DATE
      ( P_CORP_ID => V_CORP_ID
      , P_PERSON_ID => V_PERSON_ID
      , P_SOB_ID => V_SOB_ID
      , P_ORG_ID => V_ORG_ID
      , P_DUTY_ID => P_DUTY_ID
      , P_START_DATE => D_START_DATE
      , P_END_DATE => D_END_DATE
      , O_WORK_START_DATE => D_WORK_START_DATE
      , O_WORK_END_DATE => D_WORK_END_DATE
      , O_REAL_START_DATE => D_REAL_START_DATE
      , O_REAL_END_DATE => D_REAL_END_DATE
      , O_ERROR_CODE => V_ERROR_CODE
      );
    -- 시작/종료일자 기간 검증 및 시간 입력 필수 체크.
    IF V_ERROR_CODE = 'E21' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10275', NULL));
    ELSIF V_ERROR_CODE = 'E100' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10359', NULL));
    END IF; 
    
    UPDATE HRD_DUTY_PERIOD DP
      SET DUTY_ID                            = P_DUTY_ID  -- [2011-07-04] 추가
        , DP.START_DATE                       = D_START_DATE
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
    
    --[2011-09-30]
    IF V_REJECT_YN = 'Y' THEN
       UPDATE HRD_DUTY_PERIOD DP
         SET DP.APPROVED_YN         = 'N'
           , DP.APPROVED_DATE       = NULL
           --, DP.APPROVED_PERSON_ID  = NULL
           , DP.APPROVE_STATUS      = 'A'
           , DP.CONFIRMED_YN        = 'N'
           , DP.CONFIRMED_DATE      = NULL
           --, DP.CONFIRMED_PERSON_ID = NULL
           , DP.REJECT_REMARK       = NULL
           , DP.REJECT_YN           = 'N'
           , DP.REJECT_DATE         = NULL
           , DP.REJECT_PERSON_ID    = NULL
           , DP.EMAIL_STATUS        = 'N'
           , DP.ATTRIBUTE1          = DP.APPROVED_PERSON_ID
           , DP.ATTRIBUTE2          = DP.CONFIRMED_PERSON_ID
           , DP.ATTRIBUTE3          = DP.REJECT_PERSON_ID
       WHERE DP.DUTY_PERIOD_ID      = W_DUTY_PERIOD_ID
       ;
    END IF;

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
    IF V_APPROVE_STATUS NOT IN('A', 'N', 'R') THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10029', '&&VALUE:=Data(해당 자료)'));
    END IF;

    DELETE HRD_DUTY_PERIOD DP
    WHERE DP.DUTY_PERIOD_ID                           = W_DUTY_PERIOD_ID
    ;
  END DATA_DELETE;

PROCEDURE DATA_INSERT1
          ( P_CORP_ID                               IN HRD_DUTY_PERIOD.CORP_ID%TYPE
          , P_PERSON_ID                             IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
          , P_DUTY_ID                               IN HRD_DUTY_PERIOD.DUTY_ID%TYPE
          , P_START_DATE                            IN HRD_DUTY_PERIOD.START_DATE%TYPE
          , P_START_TIME                            IN VARCHAR2
          , P_END_DATE                              IN HRD_DUTY_PERIOD.END_DATE%TYPE
          , P_END_TIME                              IN VARCHAR2
          , P_APPROVED_YN                           IN HRD_DUTY_PERIOD.APPROVED_YN%TYPE
          , P_APPROVED_DATE                         IN HRD_DUTY_PERIOD.APPROVED_DATE%TYPE
          , P_APPROVED_PERSON_ID                    IN HRD_DUTY_PERIOD.APPROVED_PERSON_ID%TYPE
          , P_APPROVE_STATUS                        IN HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE
          , P_DESCRIPTION                           IN HRD_DUTY_PERIOD.DESCRIPTION%TYPE
          , P_SOB_ID                                IN HRD_DUTY_PERIOD.SOB_ID%TYPE
          , P_ORG_ID                                IN HRD_DUTY_PERIOD.ORG_ID%TYPE
          , P_USER_ID                               IN HRD_DUTY_PERIOD.CREATED_BY%TYPE
          )
  AS
    V_RECORD_COUNT                                NUMBER;
    V_ERROR_CODE                                  VARCHAR2(10) := NULL;
    V_DUTY_PERIOD_ID                              HRD_DUTY_PERIOD.DUTY_PERIOD_ID%TYPE := 0;
    D_SYSDATE                                     HRD_DUTY_PERIOD.CREATION_DATE%TYPE := NULL;
    D_START_DATE                                  HRD_DUTY_PERIOD.START_DATE%TYPE := NULL;
    D_END_DATE                                    HRD_DUTY_PERIOD.END_DATE%TYPE := NULL;
    D_WORK_START_DATE                             HRD_DUTY_PERIOD.WORK_START_DATE%TYPE := NULL;
    D_REAL_START_DATE                             HRD_DUTY_PERIOD.REAL_START_DATE%TYPE := NULL;
    D_WORK_END_DATE                               HRD_DUTY_PERIOD.WORK_END_DATE%TYPE := NULL;
    D_REAL_END_DATE                               HRD_DUTY_PERIOD.REAL_END_DATE%TYPE := NULL;

  BEGIN
    D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
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
      WHERE DP.START_DATE         = D_START_DATE
        AND DP.END_DATE           = D_END_DATE
        AND DP.PERSON_ID          = P_PERSON_ID
        AND DP.DUTY_ID            = P_DUTY_ID
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
    HRD_DUTY_PERIOD_G.WORK_DATE
      ( P_CORP_ID => P_CORP_ID
      , P_PERSON_ID => P_PERSON_ID
      , P_SOB_ID => P_SOB_ID
      , P_ORG_ID => P_ORG_ID
      , P_DUTY_ID => P_DUTY_ID
      , P_START_DATE => D_START_DATE
      , P_END_DATE => D_END_DATE
      , O_WORK_START_DATE => D_WORK_START_DATE
      , O_WORK_END_DATE => D_WORK_END_DATE
      , O_REAL_START_DATE => D_REAL_START_DATE
      , O_REAL_END_DATE => D_REAL_END_DATE
      , O_ERROR_CODE => V_ERROR_CODE
      );
    -- 시작/종료일자 기간 검증 및 시간 입력 필수 체크.
    IF V_ERROR_CODE = 'E21' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10275', NULL));
    ELSIF V_ERROR_CODE = 'E100' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10359', NULL));
    END IF; 
    
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
    , APPROVED_YN
    , APPROVED_DATE
    , APPROVED_PERSON_ID
    , APPROVE_STATUS
    , DESCRIPTION
    , SOB_ID, ORG_ID
    , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
    , ATTRIBUTE1
    ) VALUES
    ( V_DUTY_PERIOD_ID
    , D_START_DATE, D_END_DATE
    , P_PERSON_ID, P_DUTY_ID, P_CORP_ID
    , D_WORK_START_DATE, D_REAL_START_DATE
    , D_WORK_END_DATE, D_REAL_END_DATE
    , P_APPROVED_YN
    , P_APPROVED_DATE
    , P_APPROVED_PERSON_ID
    , P_APPROVE_STATUS
    , P_DESCRIPTION
    , P_SOB_ID, P_ORG_ID
    , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
    , P_APPROVED_PERSON_ID
    );  
  END DATA_INSERT1;

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
    IF V_APPROVE_STATUS NOT IN('A', 'N', 'R') THEN
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
              --(PM.CORP_ID
              (PM.WORK_CORP_ID -- PM.WORK_CORP_ID
              , TRUNC(DP.START_DATE)
              , TRUNC(DP.END_DATE)
              , '20'
              , P_CONNECT_PERSON_ID
              , P_SOB_ID
              , P_ORG_ID) AS CAP_C
           , HRD_DUTY_MANAGER_G.APPROVER_CAP_F
              ( NVL(T2.FLOOR_ID, PM.FLOOR_ID)
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
               , (-- 시점 인사내역.
                  SELECT PH.PERSON_ID
                       , PH.FLOOR_ID
                    FROM HRD_PERSON_HISTORY        PH
                   WHERE PH.EFFECTIVE_DATE_FR  <=  ( SELECT TRUNC(DP1.END_DATE) END_DATE
                                                      FROM HRD_DUTY_PERIOD DP1
                                                    WHERE DP1.DUTY_PERIOD_ID  = W_DUTY_PERIOD_ID
                                                   )
                     AND PH.EFFECTIVE_DATE_TO  >=  ( SELECT TRUNC(DP1.END_DATE) END_DATE
                                                      FROM HRD_DUTY_PERIOD DP1
                                                    WHERE DP1.DUTY_PERIOD_ID  = W_DUTY_PERIOD_ID
                                                   )
                 ) T2
      WHERE DP.PERSON_ID                          = PM.PERSON_ID
        AND DP.SOB_ID                             = PM.SOB_ID
        AND DP.ORG_ID                             = PM.ORG_ID
        AND PM.PERSON_ID                          = T1.PERSON_ID
        AND PM.PERSON_ID                          = T2.PERSON_ID
        AND DP.DUTY_PERIOD_ID                     = W_DUTY_PERIOD_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CAP_B := 'N';
      V_CAP_C := 'N';
    END;
    IF P_CHECK_YN = 'N' THEN
      NULL;
    ELSIF P_APPROVE_STATUS = 'A' AND P_APPROVE_FLAG = 'OK' THEN
    -- 미승인 --> 1차 승인 : 승인.
      IF V_CAP_B <> 'Y' THEN
        RAISE ERRNUMS.Approval_Nothing;
      END IF;
      UPDATE HRD_DUTY_PERIOD DP
        SET DP.APPROVED_YN                      = DECODE(P_CHECK_YN, 'Y', 'Y', DP.APPROVED_YN)
         , DP.APPROVED_DATE                    = DECODE(P_CHECK_YN, 'Y', GET_LOCAL_DATE(DP.SOB_ID), DP.APPROVED_DATE)
         --, DP.APPROVED_PERSON_ID               = DECODE(P_CHECK_YN, 'Y', P_CONNECT_PERSON_ID, DP.APPROVED_PERSON_ID)
         , DP.APPROVED_PERSON_ID               = P_CONNECT_PERSON_ID
         , DP.APPROVE_STATUS                   = DECODE(P_CHECK_YN, 'Y', 'B', DP.APPROVE_STATUS)
         , DP.EMAIL_STATUS                     = 'AR'
         , DP.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(DP.SOB_ID)
         , DP.LAST_UPDATED_BY                  = P_USER_ID
           , DP.ATTRIBUTE1                     = P_CONNECT_PERSON_ID
      WHERE DP.DUTY_PERIOD_ID                   = W_DUTY_PERIOD_ID
       AND DP.DUTY_ID <> 3784 --근태 :  철야
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
          --, DP.APPROVED_PERSON_ID               = DECODE(P_CHECK_YN, 'Y', NULL, DP.APPROVED_PERSON_ID)
          , DP.APPROVE_STATUS                   = DECODE(P_CHECK_YN, 'Y', 'A', DP.APPROVE_STATUS)
          , DP.EMAIL_STATUS                     = 'BR'
          , DP.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(DP.SOB_ID)
          , DP.LAST_UPDATED_BY                  = P_USER_ID
          , DP.ATTRIBUTE1                       = DP.APPROVED_PERSON_ID
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
         --, DP.CONFIRMED_PERSON_ID              = DECODE(P_CHECK_YN, 'Y', P_CONNECT_PERSON_ID, DP.CONFIRMED_PERSON_ID)
         , DP.CONFIRMED_PERSON_ID              = P_CONNECT_PERSON_ID
         , DP.APPROVE_STATUS                   = DECODE(P_CHECK_YN, 'Y', 'C', DP.APPROVE_STATUS)
         , DP.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(DP.SOB_ID)
         , DP.LAST_UPDATED_BY                  = P_USER_ID
         , DP.ATTRIBUTE2                       = P_CONNECT_PERSON_ID
      WHERE DP.DUTY_PERIOD_ID                   = W_DUTY_PERIOD_ID
        AND DP.DUTY_ID <> 3784 --근태 :  철야
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
                   AND DP.SOB_ID            = WC.SOB_ID
                   AND DP.ORG_ID            = WC.ORG_ID
               )
        WHERE EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_PERIOD DP
                       WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                         AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                         AND DP.PERSON_ID         = WC.PERSON_ID
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
                   AND DP.SOB_ID            = WC.SOB_ID
                   AND DP.ORG_ID            = WC.ORG_ID
               )
        WHERE EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_PERIOD DP
                       WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                         AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                         AND DP.PERSON_ID         = WC.PERSON_ID
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
                   AND DP.SOB_ID            = WC.SOB_ID
                   AND DP.ORG_ID            = WC.ORG_ID
               )
        WHERE EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_PERIOD DP
                       WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                         AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                         AND DP.PERSON_ID         = WC.PERSON_ID
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
                   AND DP.SOB_ID            = WC.SOB_ID
                   AND DP.ORG_ID            = WC.ORG_ID
               )
        WHERE EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_PERIOD DP
                       WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                         AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                         AND DP.PERSON_ID         = WC.PERSON_ID
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
                 AND DP.SOB_ID            = WC.SOB_ID
                 AND DP.ORG_ID            = WC.ORG_ID
             )
        WHERE EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_PERIOD DP
                       WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                         AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                         AND DP.PERSON_ID         = WC.PERSON_ID
                         AND DP.SOB_ID            = WC.SOB_ID
                         AND DP.ORG_ID            = WC.ORG_ID
                     )
        ;
      END IF;
      /*-- 근무 카렌다 반영 END. --*/
      
      /*-- 휴직 근태코드일 경우 휴직자 리스트 등록 **/
      BEGIN
        MERGE INTO HRM_ADMINISTRATIVE_LEAVE AL
        USING ( SELECT DP.PERSON_ID
                     , DP.SOB_ID
                     , DP.ORG_ID
                     , DP.WORK_START_DATE
                     , DP.WORK_END_DATE
                     , DP.DESCRIPTION
                     , DP.DUTY_PERIOD_ID
                     , DC.PAY_DAY_FLAG
                     , DC.DUTY_CODE
                  FROM HRD_DUTY_PERIOD  DP
                     , HRM_DUTY_CODE_V  DC
                WHERE DP.DUTY_ID                = DC.DUTY_ID
                  AND DC.ATTEND_FLAG            = 'TAKE_TIME_OFF'
                  AND DP.DUTY_PERIOD_ID         = W_DUTY_PERIOD_ID
              ) SX1
          ON (AL.PERSON_ID            = SX1.PERSON_ID
          AND AL.SOB_ID               = SX1.SOB_ID
          AND AL.ORG_ID               = SX1.ORG_ID
          AND AL.START_DATE           = SX1.WORK_START_DATE
          AND AL.END_DATE             = SX1.WORK_END_DATE
             )
        WHEN MATCHED THEN
          UPDATE 
            SET AL.REMARK             = SX1.DESCRIPTION
              , AL.DUTY_INTERFACE_ID  = SX1.DUTY_PERIOD_ID
              , AL.SALARY_PAID_YN     = SX1.PAY_DAY_FLAG
              , AL.DUTY_CODE          = SX1.DUTY_CODE
              , AL.LAST_UPDATE_DATE   = D_SYSDATE
              , AL.LAST_UPDATED_BY    = P_USER_ID
        WHEN NOT MATCHED THEN
          INSERT
          ( ADMINISTRATIVE_LEAVE_ID
          , PERSON_ID
          , SOB_ID 
          , ORG_ID 
          , START_DATE 
          , END_DATE 
          , REMARK 
          , DUTY_INTERFACE_ID
          , CREATION_DATE 
          , CREATED_BY 
          , LAST_UPDATE_DATE 
          , LAST_UPDATED_BY 
          ) VALUES
          ( HRM_ADMINISTRATIVE_LEAVE_S1.NEXTVAL
          , SX1.PERSON_ID
          , SX1.SOB_ID
          , SX1.ORG_ID
          , SX1.WORK_START_DATE
          , SX1.WORK_END_DATE
          , SX1.DESCRIPTION
          , SX1.DUTY_PERIOD_ID
          , D_SYSDATE
          , P_USER_ID
          , D_SYSDATE
          , P_USER_ID 
          )
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
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
          --, DP.CONFIRMED_PERSON_ID              = DECODE(P_CHECK_YN, 'Y', NULL, DP.CONFIRMED_PERSON_ID)
          , DP.APPROVE_STATUS                   = 'B'
          , DP.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(DP.SOB_ID)
          , DP.LAST_UPDATED_BY                  = P_USER_ID
          , DP.ATTRIBUTE2                       = DP.CONFIRMED_PERSON_ID
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
                 AND DP.SOB_ID            = WC.SOB_ID
                 AND DP.ORG_ID            = WC.ORG_ID
             )
        WHERE EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_PERIOD DP
                       WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                         AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                         AND DP.PERSON_ID         = WC.PERSON_ID
                         AND DP.SOB_ID            = WC.SOB_ID
                         AND DP.ORG_ID            = WC.ORG_ID
                     )
        ;
      END IF;
      /*-- 근무 카렌다 반영 END. --*/
      /*-- 휴직 근태코드일 경우 휴직자 리스트 등록 **/
      BEGIN
        DELETE FROM HRM_ADMINISTRATIVE_LEAVE AL
        WHERE EXISTS
                ( SELECT 'X'
                  FROM HRD_DUTY_PERIOD  DP
                     , HRM_DUTY_CODE_V  DC
                WHERE DP.DUTY_PERIOD_ID         = AL.DUTY_INTERFACE_ID
                  AND DP.DUTY_ID                = DC.DUTY_ID
                  AND DC.ATTEND_FLAG            = 'TAKE_TIME_OFF'
                  AND DP.DUTY_PERIOD_ID         = W_DUTY_PERIOD_ID
                 )   
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
    ELSE
    -- 승인단계 선택 안함.
     RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10043', '&&VALUE:=승인상태&&TEXT:=승인상태를 선택후 다시 처리하세요'));
     RETURN;
    END IF;
  EXCEPTION WHEN ERRNUMS.Approval_Nothing THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Approval_Nothing_Code, ERRNUMS.Approval_Nothing_Desc);
  END DATA_UPDATE_APPROVE;


-- WORK DATE TIME 정리.
  PROCEDURE WORK_DATE
	          ( P_CORP_ID                               IN HRD_DUTY_PERIOD.CORP_ID%TYPE
						, P_PERSON_ID                             IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
						, P_SOB_ID                                IN HRD_DUTY_PERIOD.SOB_ID%TYPE
						, P_ORG_ID                                IN HRD_DUTY_PERIOD.ORG_ID%TYPE
            , P_DUTY_ID                               IN HRD_DUTY_PERIOD.DUTY_ID%TYPE
						, P_START_DATE                            IN HRD_DUTY_PERIOD.START_DATE%TYPE
						, P_END_DATE                              IN HRD_DUTY_PERIOD.END_DATE%TYPE
						, O_WORK_START_DATE                       OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, O_WORK_END_DATE                         OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, O_REAL_START_DATE                       OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, O_REAL_END_DATE                         OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
            , O_ERROR_CODE                            OUT VARCHAR2
						)
  AS
    V_DUTY_CODE                          VARCHAR2(10);  -- 근태코드.
    V_ONE_DAY_FLAG                       VARCHAR2(2);   -- 고정근태 신청시 1일에 대해서만 신청 가능여부.
    V_STD_END_DATETIME                   DATE;          -- 후일 종료일시.
    V_ERROR_CODE                         VARCHAR2(10) := NULL;  -- 데이터 검증시 
    
    V_START_TIME                         VARCHAR2(5);
    V_END_TIME                           VARCHAR2(5);
    D_PLAN_START_DATE                    HRD_WORK_CALENDAR.WORK_DATE%TYPE;
    D_PLAN_END_DATE                      HRD_WORK_CALENDAR.WORK_DATE%TYPE;
    D_WORK_START_DATE                    HRD_DUTY_PERIOD.WORK_START_DATE%TYPE := NULL;
    D_REAL_START_DATE                    HRD_DUTY_PERIOD.REAL_START_DATE%TYPE := NULL;
    D_WORK_END_DATE                      HRD_DUTY_PERIOD.WORK_END_DATE%TYPE := NULL;
    D_REAL_END_DATE                      HRD_DUTY_PERIOD.REAL_END_DATE%TYPE := NULL;
  BEGIN
    V_ONE_DAY_FLAG := 'N';
    V_START_TIME := TO_CHAR(P_START_DATE, 'HH24:MI');  -- 시작시간.
    V_END_TIME := TO_CHAR(P_END_DATE, 'HH24:MI');      -- 종료시간.
    
    -- DUTY CODE.
    V_DUTY_CODE := HRM_COMMON_G.GET_CODE_F(P_DUTY_ID, P_SOB_ID, P_ORG_ID);
    /*-- 전호수 주석(2012-11-05) : 직출/퇴 여러일자 신청 가능.
    IF V_DUTY_CODE IN ('100', '101', '102', '103', '104') THEN 
    -- 외근 : 100, 외출 : 101, 지각 : 102, 조퇴 : 103, 직출/퇴 : 104
      V_ONE_DAY_FLAG := 'Y';
    END IF;*/
    IF V_DUTY_CODE IN ('100', '101', '102', '103') THEN 
    -- 외근 : 100, 외출 : 101, 지각 : 102, 조퇴 : 103--
      V_ONE_DAY_FLAG := 'Y';
    END IF;
 
   -- 실제근무기간 생성 및 반환.
    -- 근무일자 생성.
    IF V_ONE_DAY_FLAG = 'Y' AND V_START_TIME = '00:00' THEN
      D_WORK_START_DATE := TRUNC(P_START_DATE) - 1;
    ELSIF V_START_TIME BETWEEN '00:01' AND '06:00' THEN
      D_WORK_START_DATE := TRUNC(P_START_DATE) - 1;
    ELSE
      D_WORK_START_DATE := TRUNC(P_START_DATE);
    END IF;
    -- WORK END DATE.
    IF V_ONE_DAY_FLAG = 'Y' AND V_END_TIME = '00:00' THEN
      D_WORK_END_DATE := TRUNC(P_END_DATE) - 1;
    ELSIF V_END_TIME BETWEEN '00:01' AND '06:00' THEN
      D_WORK_END_DATE := TRUNC(P_END_DATE) - 1;
    ELSE
      D_WORK_END_DATE := TRUNC(P_END_DATE);
    END IF;
/*DBMS_OUTPUT.put_line('D_WORK_START_DATE : ' || TO_CHAR(D_WORK_START_DATE, 'YYYY-MM-DD HH24:MI') ||
                    ' D_WORK_END_DATE : ' || TO_CHAR(D_WORK_END_DATE, 'YYYY-MM-DD HH24:MI'));*/
    
    -- 종료기준일자 설정.
    V_STD_END_DATETIME := TRUNC(D_WORK_START_DATE) + 1.25;  -- 후일 06시.
    
    -- 데이터 검증 --
    IF V_DUTY_CODE = '21' THEN  
    -- 반차일 경우 근무계획시간은 안됨.
      IF V_START_TIME IS NULL OR V_END_TIME IS NULL THEN
        O_ERROR_CODE := 'E21'; 
      ELSIF V_START_TIME = '00:00' OR V_END_TIME = '00:00' THEN
        O_ERROR_CODE := 'E21';
      END IF;
    ELSIF V_ONE_DAY_FLAG = 'Y' THEN 
    -- 외근 : 100, 외출 : 101, 지각 : 102, 조퇴 : 103, 직출/퇴 : 104
      IF V_STD_END_DATETIME < P_END_DATE THEN
        O_ERROR_CODE := 'E100';
      END IF;
    END IF;
    IF O_ERROR_CODE IS NOT NULL THEN
      RETURN;
    END IF;
    
/*DBMS_OUTPUT.put_line('D_WORK_START_DATE : ' || TO_CHAR(D_WORK_START_DATE, 'YYYY-MM-DD HH24:MI') ||
                    ' D_WORK_END_DATE : ' || TO_CHAR(D_WORK_END_DATE, 'YYYY-MM-DD HH24:MI') ||
                    ' STD DATE : ' || TO_CHAR(V_STD_END_DATETIME, 'YYYY-MM-DD HH24:MI'));*/

/*-- 근무 계획 조회 START --*/
    IF V_START_TIME = '00:00' THEN
       D_PLAN_START_DATE := P_START_DATE;
    ELSE
    -- 시작 근무계획 조회.
      BEGIN
        SELECT WC.OPEN_TIME
          INTO D_PLAN_START_DATE
          FROM HRD_WORK_CALENDAR WC
        WHERE WC.WORK_DATE        = D_WORK_START_DATE
          AND WC.PERSON_ID        = P_PERSON_ID
          AND WC.SOB_ID           = P_SOB_ID
          AND WC.ORG_ID           = P_ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        D_PLAN_START_DATE := P_START_DATE;
      END;
    END IF;

    IF V_END_TIME = '00:00' THEN
      D_PLAN_END_DATE := P_END_DATE;
    ELSE
    -- 종료 근무계획 조회.
      BEGIN
        SELECT WC.CLOSE_TIME
          INTO D_PLAN_END_DATE
          FROM HRD_WORK_CALENDAR WC
        WHERE WC.WORK_DATE        = D_WORK_END_DATE
          AND WC.PERSON_ID        = P_PERSON_ID
          AND WC.SOB_ID           = P_SOB_ID
          AND WC.ORG_ID           = P_ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        D_PLAN_END_DATE := P_END_DATE;
      END;

    END IF;
/*-- 근무 계획 조회 END --*/

DBMS_OUTPUT.put_line('P_START_DATE : ' || TO_CHAR(P_START_DATE, 'YYYY-MM-DD HH24:MI') ||
                    ' D_PLAN_START_DATE : ' || TO_CHAR(D_PLAN_START_DATE, 'YYYY-MM-DD HH24:MI') ||
                    ' P_END_DATE : ' || TO_CHAR(P_END_DATE, 'YYYY-MM-DD HH24:MI') ||
                    ' D_PLAN_END_DATE : ' || TO_CHAR(D_PLAN_END_DATE, 'YYYY-MM-DD HH24:MI'));
    IF P_START_DATE = D_PLAN_START_DATE AND P_END_DATE = D_PLAN_END_DATE THEN
      D_REAL_START_DATE := NULL;
    ELSIF P_START_DATE = D_PLAN_START_DATE AND P_END_DATE <> D_PLAN_END_DATE THEN
      D_REAL_START_DATE := P_END_DATE;
      D_REAL_END_DATE := D_PLAN_END_DATE;
    ELSE
      D_REAL_START_DATE := D_PLAN_START_DATE;
      D_REAL_END_DATE := P_START_DATE;
    END IF;
    
    IF V_DUTY_CODE IN ('100', '101', '102', '103') THEN 
    -- 외근 : 100, 외출 : 101, 지각 : 102, 조퇴 : 103.
      D_REAL_START_DATE := NULL;
      D_REAL_END_DATE := NULL;
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
/*
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
*/

    OPEN P_CURSOR1 FOR
    SELECT DISTINCT DPT.PERIOD_TIME
      FROM HRM_DUTY_PERIOD_TIME_V DPT
  ORDER BY DPT.PERIOD_TIME
         ;
 
  END LU_PERIOD_TIME;

-- 외출, 지각[2011-08-10]
  PROCEDURE LU_SELECT_DUTY
          ( P_CURSOR3            OUT TYPES.TCURSOR3
          , W_SOB_ID             IN  HRM_COMMON.SOB_ID%TYPE
          , W_ORG_ID             IN  HRM_COMMON.ORG_ID%TYPE
          )

  AS

            V_STD_DATE  HRM_COMMON.EFFECTIVE_DATE_FR%TYPE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));

  BEGIN

            OPEN P_CURSOR3 FOR
            SELECT HC.CODE_NAME
                 , HC.CODE
                 , HC.COMMON_ID
                 , HC.VALUE8
              FROM HRM_COMMON HC
             WHERE HC.GROUP_CODE          = 'DUTY'
               AND HC.SOB_ID              = W_SOB_ID
               AND HC.ORG_ID              = W_ORG_ID
               AND HC.VALUE8              = 'Y'
               AND HC.EFFECTIVE_DATE_FR   <= NVL(V_STD_DATE, HC.EFFECTIVE_DATE_FR)
               AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, HC.EFFECTIVE_DATE_TO))
          ORDER BY HC.CODE
                 ;

  END LU_SELECT_DUTY;


       -- 공통코드 조회 LOOKUP - GROUP CODE..
       PROCEDURE LU_SELECT_GROUP( P_CURSOR3           OUT  TYPES.TCURSOR3
                                , W_GROUP_CODE        IN   HRM_COMMON.GROUP_CODE%TYPE
                                , W_CODE_NAME         IN   HRM_COMMON.CODE_NAME%TYPE
                                , W_SOB_ID            IN   HRM_COMMON.SOB_ID%TYPE
                                , W_ORG_ID            IN   HRM_COMMON.ORG_ID%TYPE
                                , W_ENABLED_FLAG_YN   IN   HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
                                )

       AS

                 V_STD_DATE   HRM_COMMON.EFFECTIVE_DATE_FR%TYPE := NULL;

       BEGIN
                 IF W_ENABLED_FLAG_YN = 'Y' THEN
                   V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
                 ELSE
                   V_STD_DATE := NULL;
                 END IF;

        OPEN P_CURSOR3 FOR
        SELECT HC.CODE_NAME
             , HC.CODE
             , HC.COMMON_ID
             , HC.VALUE1
             , HC.VALUE2
             , HC.VALUE3
             , HC.VALUE4
             , HC.VALUE5
             , HC.VALUE6
             , HC.VALUE7
             , HC.VALUE8
             , HC.VALUE9
             , HC.VALUE10
          FROM HRM_COMMON HC
         WHERE HC.GROUP_CODE           = W_GROUP_CODE
           AND HC.CODE_NAME              LIKE W_CODE_NAME || '%'
           AND HC.SOB_ID               = W_SOB_ID
           AND HC.ORG_ID               = W_ORG_ID
           AND HC.ENABLED_FLAG         = 'Y'
           AND HC.EFFECTIVE_DATE_FR   <= NVL(V_STD_DATE, HC.EFFECTIVE_DATE_FR)
           AND(HC.EFFECTIVE_DATE_TO      IS NULL 
            OR HC.EFFECTIVE_DATE_TO   >= NVL(V_STD_DATE, HC.EFFECTIVE_DATE_TO))
      ORDER BY HC.CODE_NAME
             ;

       END LU_SELECT_GROUP;


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
    
-- 지각/조퇴/외출/외근/직퇴/반차일 경우 데이터 검증 
-- (시작/종료일자는 동일해야 함(단,야간자의 경우 종료일자는 후일일수 있음).
  FUNCTION DUTY_VALIDATE_YN_F
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
    V_DUTY_CODE                          VARCHAR2(10);
    V_STD_END_DATETIME                   DATE;
    V_CHECK_YN                           VARCHAR2(1) := '-';
  BEGIN
    -- 종료기준일자 설정.
    V_STD_END_DATETIME := P_START_DATE + + 1.25;  -- 후일 06시.
    
    -- DUTY CODE.
    V_DUTY_CODE := HRM_COMMON_G.GET_CODE_F(P_DUTY_ID, P_SOB_ID, P_ORG_ID);
    IF V_DUTY_CODE = '21' THEN  
    -- 반차일 경우 근무계획시간은 안됨.
      IF P_START_TIME IS NULL OR P_END_TIME IS NULL THEN
        V_CHECK_YN := 'E21'; 
      ELSIF P_START_TIME = '00:00' OR P_END_TIME = '00:00' THEN
        V_CHECK_YN := 'E21';
      ELSE
        V_CHECK_YN := 'Y';
      END IF;
    ELSIF V_DUTY_CODE IN ('100', '101', '102', '103', '104') THEN 
    -- 외근 : 100, 외출 : 101, 지각 : 102, 조퇴 : 103, 직출/퇴 : 104
      IF V_STD_END_DATETIME < TO_DATE(TO_CHAR(P_END_DATE, 'YYYY-MM-DD') || ' ' || P_END_TIME, 'YYYY-MM-DD HH24:MI') THEN
        V_CHECK_YN := 'E100';
      ELSE
        V_CHECK_YN := 'Y';
      END IF;
    ELSE
      V_CHECK_YN := 'Y';
    END IF;
    RETURN V_CHECK_YN;
  END DUTY_VALIDATE_YN_F;


-- [2011-09-06] 수정
   PROCEDURE SELECT_DATA_APPLY
           ( P_CURSOR              OUT TYPES.TCURSOR
           , W_CORP_ID             IN  HRD_DUTY_PERIOD.CORP_ID%TYPE
           , W_START_DATE          IN  HRD_DUTY_PERIOD.START_DATE%TYPE
           , W_END_DATE            IN  HRD_DUTY_PERIOD.END_DATE%TYPE
           , W_APPROVE_STATUS      IN  HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE
           , W_SEARCH_TYPE         IN  HRM_COMMON.CODE%TYPE
           , W_DUTY_ID             IN  HRD_DUTY_PERIOD.DUTY_ID%TYPE
           , W_FLOOR_ID            IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
           , W_PERSON_ID           IN  HRD_DUTY_PERIOD.PERSON_ID%TYPE
           , W_CONNECT_PERSON_ID   IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
           , W_SOB_ID              IN  HRD_DUTY_PERIOD.SOB_ID%TYPE
           , W_ORG_ID              IN  HRD_DUTY_PERIOD.ORG_ID%TYPE
           )

   AS
             V_CONNECT_PERSON_ID       HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

  BEGIN
             -- 근태권한 설정.
             IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     =>  W_CORP_ID
                                        , W_START_DATE  =>  W_START_DATE
                                        , W_END_DATE    =>  W_END_DATE
                                        , W_MODULE_CODE => '20'
                                        , W_PERSON_ID   =>  W_CONNECT_PERSON_ID
                                        , W_SOB_ID      =>  W_SOB_ID
                                        , W_ORG_ID      =>  W_ORG_ID) = 'C'
             THEN
                V_CONNECT_PERSON_ID := NULL;
             ELSE
                V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
             END IF;

             IF W_APPROVE_STATUS IN('A', 'N')
             THEN
                V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
             END IF;

             OPEN P_CURSOR FOR
             SELECT 'N'                                 AS APPROVE_YN
                  , PM.NAME                             AS PERSON_NAME
                  --, HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
                  , HRM_COMMON_G.ID_NAME_F(DP.FLOOR_ID) AS FLOOR_NAME
                  , HRM_COMMON_G.ID_NAME_F(DP.DUTY_ID)  AS DUTY_NAME
                  , TRUNC(DP.START_DATE)                AS START_DATE
                  , TO_CHAR(DP.START_DATE, 'HH24:MI')   AS START_TIME
                  , TRUNC(DP.END_DATE)                  AS END_DATE
                  , TO_CHAR(DP.END_DATE, 'HH24:MI')     AS END_TIME
                  , DP.DESCRIPTION
                  , DP.REJECT_REMARK
                  , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DP.APPROVE_STATUS, DP.SOB_ID, DP.ORG_ID) AS APPROVE_STATUS_NAME
                  , PM.PERSON_NUM                              AS PERSON_NUMBER
                  , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)  AS CORP_NAME
                  --, HRM_COMMON_G.ID_NAME_F(T2.WORK_TYPE_ID)    AS WORK_TYPE
                  --, HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID)  AS DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(DP.WORK_TYPE_ID)    AS WORK_TYPE
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(DP.DEPT_ID)  AS DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                  , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE
                  , PM.JOIN_DATE
                  , PM.RETIRE_DATE
                  , HRM_PERSON_MASTER_G.NAME_F(DP.APPROVED_PERSON_ID)  AS APPROVERD_PERSON_NAME
                  , HRM_PERSON_MASTER_G.NAME_F(DP.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                  , EAPP_USER_G.USER_NAME_F(DP.CREATED_BY)             AS REQUEST_PERSON_NAME
                  , WT.WORK_TYPE_GROUP
                  , DP.APPROVE_STATUS
                  , DP.CORP_ID
                  , DP.DUTY_ID
                  , DP.DUTY_PERIOD_ID
                  , DP.PERSON_ID
                  , DP.REJECT_YN
                  , DP.REJECT_DATE
                  , HRM_PERSON_MASTER_G.NAME_F(DP.REJECT_PERSON_ID) AS REJECT_PERSON_NAME
              FROM (SELECT S_DP.DUTY_PERIOD_ID
                         , S_DP.START_DATE
                         , S_DP.END_DATE
                         , S_DP.PERSON_ID
                         , S_DP.DUTY_ID
                         , S_DP.CORP_ID
                         , S_DP.WORK_START_DATE
                         , S_DP.REAL_START_DATE
                         , S_DP.WORK_END_DATE
                         , S_DP.REAL_END_DATE
                         , S_DP.APPROVED_YN
                         , S_DP.APPROVED_DATE
                         , S_DP.APPROVED_PERSON_ID
                         , S_DP.CONFIRMED_YN
                         , S_DP.CONFIRMED_DATE
                         , S_DP.CONFIRMED_PERSON_ID
                         , S_DP.APPROVE_STATUS
                         , S_DP.CALENDAR_TRAN_YN
                         , S_DP.DESCRIPTION
                         , S_DP.ATTRIBUTE1
                         , S_DP.ATTRIBUTE2
                         , S_DP.ATTRIBUTE3
                         , S_DP.ATTRIBUTE4
                         , S_DP.ATTRIBUTE5
                         , S_DP.SOB_ID
                         , S_DP.ORG_ID
                         , S_DP.CREATION_DATE
                         , S_DP.CREATED_BY
                         , S_DP.LAST_UPDATE_DATE
                         , S_DP.LAST_UPDATED_BY
                         , S_DP.EMAIL_STATUS
                         , S_DP.REJECT_REMARK
                         , S_DP.REJECT_YN
                         , S_DP.REJECT_DATE
                         , S_DP.REJECT_PERSON_ID
                         ,(SELECT S_PH.FLOOR_ID
                             FROM HRD_PERSON_HISTORY        S_PH
                            WHERE S_PH.PERSON_ID          = S_DP.PERSON_ID
                              AND S_PH.CORP_ID            = S_DP.CORP_ID
                              AND S_PH.EFFECTIVE_DATE_FR <= S_DP.END_DATE
                              AND S_PH.EFFECTIVE_DATE_TO >= S_DP.END_DATE
                              AND ROWNUM = 1) AS FLOOR_ID
                         ,(SELECT S_PH.WORK_TYPE_ID
                             FROM HRD_PERSON_HISTORY        S_PH
                            WHERE S_PH.PERSON_ID          = S_DP.PERSON_ID
                              AND S_PH.CORP_ID            = S_DP.CORP_ID
                              AND S_PH.EFFECTIVE_DATE_FR <= S_DP.END_DATE
                              AND S_PH.EFFECTIVE_DATE_TO >= S_DP.END_DATE
                              AND ROWNUM = 1) AS WORK_TYPE_ID
                         ,(SELECT S_PH.DEPT_ID
                             FROM HRD_PERSON_HISTORY        S_PH
                            WHERE S_PH.PERSON_ID          = S_DP.PERSON_ID
                              AND S_PH.CORP_ID            = S_DP.CORP_ID
                              AND S_PH.EFFECTIVE_DATE_FR <= S_DP.END_DATE
                              AND S_PH.EFFECTIVE_DATE_TO >= S_DP.END_DATE
                              AND ROWNUM = 1) AS DEPT_ID
                      FROM HRD_DUTY_PERIOD S_DP
                   ) DP
                 , HRM_PERSON_MASTER PM
                 , (-- 시점 인사내역.
                    SELECT HL.PERSON_ID
                         , HL.POST_ID
                         , HL.JOB_CATEGORY_ID
                         , HL.JOB_CLASS_ID
                         , HL.OCPT_ID
                      FROM HRM_HISTORY_LINE HL
                     WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                      FROM HRM_HISTORY_LINE        S_HL
                                                      WHERE S_HL.CHARGE_DATE   <=  W_END_DATE
                                                        AND S_HL.PERSON_ID      =  HL.PERSON_ID
                                                   GROUP BY S_HL.PERSON_ID
                                                  )
                   ) T1
                 , (-- 시점 인사내역.
                    SELECT PH.PERSON_ID
                         , PH.FLOOR_ID
                         , PH.WORK_TYPE_ID
                         , PH.DEPT_ID
                      FROM HRD_PERSON_HISTORY          PH
                     WHERE PH.EFFECTIVE_DATE_FR   <=   W_END_DATE
                       AND PH.EFFECTIVE_DATE_TO   >=   W_END_DATE
                   ) T2
                 , HRM_WORK_TYPE_V WT
             WHERE DP.PERSON_ID                          = PM.PERSON_ID
               AND DP.SOB_ID                             = PM.SOB_ID
               AND DP.ORG_ID                             = PM.ORG_ID
               AND PM.PERSON_ID                          = T1.PERSON_ID
               AND PM.PERSON_ID                          = T2.PERSON_ID
               AND PM.WORK_TYPE_ID                       = WT.WORK_TYPE_ID
               AND DECODE(W_SEARCH_TYPE, 'R', TRUNC(DP.CREATION_DATE), TRUNC(DP.START_DATE)) <= W_END_DATE
               AND DECODE(W_SEARCH_TYPE, 'R', TRUNC(DP.CREATION_DATE), TRUNC(DP.END_DATE))   >= W_START_DATE
               AND DP.PERSON_ID                          = NVL(W_PERSON_ID, DP.PERSON_ID)
               AND DP.DUTY_ID                            = NVL(W_DUTY_ID, DP.DUTY_ID)
               AND DP.CORP_ID                            = W_CORP_ID
               AND DP.SOB_ID                             = W_SOB_ID
               AND DP.ORG_ID                             = W_ORG_ID
               --AND T2.FLOOR_ID                           = NVL(W_FLOOR_ID, T2.FLOOR_ID)
               AND DP.FLOOR_ID                           = NVL(W_FLOOR_ID, DP.FLOOR_ID)
               AND(DP.APPROVE_STATUS = DECODE(NVL(W_APPROVE_STATUS, DP.APPROVE_STATUS), 'A', 'R', NVL(W_APPROVE_STATUS, DP.APPROVE_STATUS))
                OR DP.APPROVE_STATUS = NVL(W_APPROVE_STATUS, DP.APPROVE_STATUS))
               AND EXISTS (SELECT 'X'
                             FROM HRD_DUTY_MANAGER          DM
                            WHERE DM.CORP_ID              = DP.CORP_ID
                              AND DM.DUTY_CONTROL_ID      = T2.FLOOR_ID
                              AND DM.WORK_TYPE_ID         = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
                              AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
                              AND DM.SOB_ID               = DP.SOB_ID
                              AND DM.ORG_ID               = DP.ORG_ID
                          )
          ORDER BY PM.NAME
                   ;

   END SELECT_DATA_APPLY;


-- [2011-09-06] 수정
   PROCEDURE SELECT_DATA_APPROVE
           ( P_CURSOR              OUT TYPES.TCURSOR
           , W_CORP_ID             IN  HRD_DUTY_PERIOD.CORP_ID%TYPE
           , W_START_DATE          IN  HRD_DUTY_PERIOD.START_DATE%TYPE
           , W_END_DATE            IN  HRD_DUTY_PERIOD.END_DATE%TYPE
           , W_APPROVE_STATUS      IN  HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE
           , W_SEARCH_TYPE         IN  HRM_COMMON.CODE%TYPE
           , W_DUTY_ID             IN  HRD_DUTY_PERIOD.DUTY_ID%TYPE
           , W_FLOOR_ID            IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
           , W_PERSON_ID           IN  HRD_DUTY_PERIOD.PERSON_ID%TYPE
           , W_CONNECT_PERSON_ID   IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
           , W_SOB_ID              IN  HRD_DUTY_PERIOD.SOB_ID%TYPE
           , W_ORG_ID              IN  HRD_DUTY_PERIOD.ORG_ID%TYPE
           )

   AS
             V_CONNECT_PERSON_ID       HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

  BEGIN
             -- 근태권한 설정.
             IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     =>  W_CORP_ID
                                        , W_START_DATE  =>  W_START_DATE
                                        , W_END_DATE    =>  W_END_DATE
                                        , W_MODULE_CODE => '20'
                                        , W_PERSON_ID   =>  W_CONNECT_PERSON_ID
                                        , W_SOB_ID      =>  W_SOB_ID
                                        , W_ORG_ID      =>  W_ORG_ID) = 'C'
             THEN
                V_CONNECT_PERSON_ID := NULL;
             ELSE
                V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
             END IF;

             IF W_APPROVE_STATUS IN('A', 'N')
             THEN
                V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
             END IF;

             OPEN P_CURSOR FOR
             SELECT 'N'                                 AS APPROVE_YN
                  , PM.NAME                             AS PERSON_NAME
                  --, HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
                  , HRM_COMMON_G.ID_NAME_F(DP.FLOOR_ID) AS FLOOR_NAME
                  , HRM_COMMON_G.ID_NAME_F(DP.DUTY_ID)  AS DUTY_NAME
                  , TRUNC(DP.START_DATE)                AS START_DATE
                  , TO_CHAR(DP.START_DATE, 'HH24:MI')   AS START_TIME
                  , TRUNC(DP.END_DATE)                  AS END_DATE
                  , TO_CHAR(DP.END_DATE, 'HH24:MI')     AS END_TIME
                  , DP.DESCRIPTION
                  , DP.REJECT_REMARK
                  , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DP.APPROVE_STATUS, DP.SOB_ID, DP.ORG_ID) AS APPROVE_STATUS_NAME
                  , PM.PERSON_NUM                              AS PERSON_NUMBER
                  , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)  AS CORP_NAME
                  --, HRM_COMMON_G.ID_NAME_F(T2.WORK_TYPE_ID)    AS WORK_TYPE
                  --, HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID)  AS DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(DP.WORK_TYPE_ID)    AS WORK_TYPE
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(DP.DEPT_ID)  AS DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                  , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE
                  , PM.JOIN_DATE
                  , PM.RETIRE_DATE
                  , HRM_PERSON_MASTER_G.NAME_F(DP.APPROVED_PERSON_ID)  AS APPROVERD_PERSON_NAME
                  , HRM_PERSON_MASTER_G.NAME_F(DP.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                  , EAPP_USER_G.USER_NAME_F(DP.CREATED_BY)             AS REQUEST_PERSON_NAME
                  , WT.WORK_TYPE_GROUP
                  , DP.APPROVE_STATUS
                  , DP.CORP_ID
                  , DP.DUTY_ID
                  , DP.DUTY_PERIOD_ID
                  , DP.PERSON_ID
              FROM (SELECT S_DP.DUTY_PERIOD_ID
                         , S_DP.START_DATE
                         , S_DP.END_DATE
                         , S_DP.PERSON_ID
                         , S_DP.DUTY_ID
                         , S_DP.CORP_ID
                         , S_DP.WORK_START_DATE
                         , S_DP.REAL_START_DATE
                         , S_DP.WORK_END_DATE
                         , S_DP.REAL_END_DATE
                         , S_DP.APPROVED_YN
                         , S_DP.APPROVED_DATE
                         , S_DP.APPROVED_PERSON_ID
                         , S_DP.CONFIRMED_YN
                         , S_DP.CONFIRMED_DATE
                         , S_DP.CONFIRMED_PERSON_ID
                         , S_DP.APPROVE_STATUS
                         , S_DP.CALENDAR_TRAN_YN
                         , S_DP.DESCRIPTION
                         , S_DP.ATTRIBUTE1
                         , S_DP.ATTRIBUTE2
                         , S_DP.ATTRIBUTE3
                         , S_DP.ATTRIBUTE4
                         , S_DP.ATTRIBUTE5
                         , S_DP.SOB_ID
                         , S_DP.ORG_ID
                         , S_DP.CREATION_DATE
                         , S_DP.CREATED_BY
                         , S_DP.LAST_UPDATE_DATE
                         , S_DP.LAST_UPDATED_BY
                         , S_DP.EMAIL_STATUS
                         , S_DP.REJECT_REMARK
                         , S_DP.REJECT_YN
                         , S_DP.REJECT_DATE
                         , S_DP.REJECT_PERSON_ID
                         ,(SELECT S_PH.FLOOR_ID
                             FROM HRD_PERSON_HISTORY        S_PH
                            WHERE S_PH.PERSON_ID          = S_DP.PERSON_ID
                              AND S_PH.CORP_ID            = S_DP.CORP_ID
                              AND S_PH.EFFECTIVE_DATE_FR <= S_DP.WORK_END_DATE
                              AND S_PH.EFFECTIVE_DATE_TO >= S_DP.WORK_END_DATE
                              AND ROWNUM = 1) AS FLOOR_ID
                         ,(SELECT S_PH.WORK_TYPE_ID
                             FROM HRD_PERSON_HISTORY        S_PH
                            WHERE S_PH.PERSON_ID          = S_DP.PERSON_ID
                              AND S_PH.CORP_ID            = S_DP.CORP_ID
                              AND S_PH.EFFECTIVE_DATE_FR <= S_DP.WORK_END_DATE
                              AND S_PH.EFFECTIVE_DATE_TO >= S_DP.WORK_END_DATE
                              AND ROWNUM = 1) AS WORK_TYPE_ID
                         ,(SELECT S_PH.DEPT_ID
                             FROM HRD_PERSON_HISTORY        S_PH
                            WHERE S_PH.PERSON_ID          = S_DP.PERSON_ID
                              AND S_PH.CORP_ID            = S_DP.CORP_ID
                              AND S_PH.EFFECTIVE_DATE_FR <= S_DP.WORK_END_DATE
                              AND S_PH.EFFECTIVE_DATE_TO >= S_DP.WORK_END_DATE
                              AND ROWNUM = 1) AS DEPT_ID
                      FROM HRD_DUTY_PERIOD S_DP
                   ) DP
                 , HRM_PERSON_MASTER PM
                 , (-- 시점 인사내역.
                    SELECT HL.PERSON_ID
                         , HL.POST_ID
                         , HL.JOB_CATEGORY_ID
                         , HL.JOB_CLASS_ID
                         , HL.OCPT_ID
                      FROM HRM_HISTORY_LINE HL
                     WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                      FROM HRM_HISTORY_LINE        S_HL
                                                      WHERE S_HL.CHARGE_DATE   <=  W_END_DATE
                                                        AND S_HL.PERSON_ID      =  HL.PERSON_ID
                                                   GROUP BY S_HL.PERSON_ID
                                                  )
                   ) T1
                 /*, (-- 시점 인사내역.
                    SELECT PH.PERSON_ID
                         , PH.FLOOR_ID
                         , PH.WORK_TYPE_ID
                         , PH.DEPT_ID
                      FROM HRD_PERSON_HISTORY          PH
                     WHERE PH.EFFECTIVE_DATE_FR   <=   W_END_DATE
                       AND PH.EFFECTIVE_DATE_TO   >=   W_END_DATE
                   ) T2*/
                 , HRM_WORK_TYPE_V WT
             WHERE DP.PERSON_ID                          = PM.PERSON_ID
               AND DP.SOB_ID                             = PM.SOB_ID
               AND DP.ORG_ID                             = PM.ORG_ID
               AND PM.PERSON_ID                          = T1.PERSON_ID
               /*AND PM.PERSON_ID                          = T2.PERSON_ID*/
               AND PM.WORK_TYPE_ID                       = WT.WORK_TYPE_ID
               AND DECODE(W_SEARCH_TYPE, 'R', TRUNC(DP.CREATION_DATE), TRUNC(DP.WORK_START_DATE)) <= W_END_DATE
               AND DECODE(W_SEARCH_TYPE, 'R', TRUNC(DP.CREATION_DATE), TRUNC(DP.WORK_END_DATE))   >= W_START_DATE
               AND DP.PERSON_ID                          = NVL(W_PERSON_ID, DP.PERSON_ID)
               AND DP.DUTY_ID                            = NVL(W_DUTY_ID, DP.DUTY_ID)
               AND DP.CORP_ID                            = W_CORP_ID
               AND DP.SOB_ID                             = W_SOB_ID
               AND DP.ORG_ID                             = W_ORG_ID
               --AND T2.FLOOR_ID                           = NVL(W_FLOOR_ID, T2.FLOOR_ID)
               AND DP.FLOOR_ID                           = NVL(W_FLOOR_ID, DP.FLOOR_ID)
               AND DP.APPROVE_STATUS                     = NVL(W_APPROVE_STATUS, DP.APPROVE_STATUS)
               AND EXISTS (SELECT 'X'
                             FROM HRD_DUTY_MANAGER          DM
                            WHERE DM.CORP_ID              = DP.CORP_ID
                              AND DM.DUTY_CONTROL_ID      = DP.FLOOR_ID
                              AND DM.WORK_TYPE_ID         = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
                              AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
                              AND DM.SOB_ID               = DP.SOB_ID
                              AND DM.ORG_ID               = DP.ORG_ID
                          )
          ORDER BY PM.NAME
                   ;

   END SELECT_DATA_APPROVE;


-- 고정근태 반려처리를 위한 조회.
   PROCEDURE DUTY_PERIOD_RETURN_SELECT
           ( P_CURSOR1             OUT  TYPES.TCURSOR1
           , W_CORP_ID             IN   HRD_DUTY_PERIOD.CORP_ID%TYPE
           , W_START_DATE          IN   HRD_DUTY_PERIOD.START_DATE%TYPE
           , W_END_DATE            IN   HRD_DUTY_PERIOD.END_DATE%TYPE
           , W_APPROVE_STATUS      IN   HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE
           , W_DUTY_ID             IN   HRD_DUTY_PERIOD.DUTY_ID%TYPE
           , W_FLOOR_ID            IN   HRM_PERSON_MASTER.FLOOR_ID%TYPE
           , W_PERSON_ID           IN   HRD_DUTY_PERIOD.PERSON_ID%TYPE
           , W_CONNECT_PERSON_ID   IN   HRM_PERSON_MASTER.PERSON_ID%TYPE
           , W_SOB_ID              IN   HRD_DUTY_PERIOD.SOB_ID%TYPE
           , W_ORG_ID              IN   HRD_DUTY_PERIOD.ORG_ID%TYPE
           )

  AS

             V_CONNECT_PERSON_ID        HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

  BEGIN
             -- 근태권한 설정.
             IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => W_CORP_ID
                                        , W_START_DATE  => W_START_DATE
                                        , W_END_DATE    => W_END_DATE
                                        , W_MODULE_CODE => '20'
                                        , W_PERSON_ID   => W_CONNECT_PERSON_ID
                                        , W_SOB_ID      => W_SOB_ID
                                        , W_ORG_ID      => W_ORG_ID) = 'C' THEN
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
                  , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
                  , DP.DUTY_PERIOD_ID
               FROM HRD_DUTY_PERIOD DP
                  , HRM_PERSON_MASTER PM
                  , (-- 시점 인사내역.
                     SELECT HL.PERSON_ID
                          , HL.POST_ID
                          , HL.JOB_CATEGORY_ID
                       FROM HRM_HISTORY_LINE HL
                      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                       FROM HRM_HISTORY_LINE             S_HL
                                                      WHERE S_HL.CHARGE_DATE          <= W_END_DATE
                                                        AND S_HL.PERSON_ID             = HL.PERSON_ID
                                                   GROUP BY S_HL.PERSON_ID
                                                   )
                   ) T1
                 , (-- 시점 인사내역.
                    SELECT PH.PERSON_ID
                         , PH.FLOOR_ID
                         , PH.WORK_TYPE_ID
                         , PH.DEPT_ID
                      FROM HRD_PERSON_HISTORY          PH
                     WHERE PH.EFFECTIVE_DATE_FR   <=   W_END_DATE
                       AND PH.EFFECTIVE_DATE_TO   >=   W_END_DATE
                   ) T2
                  , HRM_WORK_TYPE_V WT
              WHERE DP.PERSON_ID                          = PM.PERSON_ID
                AND DP.SOB_ID                             = PM.SOB_ID
                AND DP.ORG_ID                             = PM.ORG_ID
                AND PM.PERSON_ID                          = T1.PERSON_ID
                AND PM.PERSON_ID                          = T2.PERSON_ID
                AND PM.WORK_TYPE_ID                       = WT.WORK_TYPE_ID
                AND TRUNC(DP.START_DATE)                 <= W_END_DATE
                AND TRUNC(DP.END_DATE)                   >= W_START_DATE
                AND DP.PERSON_ID                          = NVL(W_PERSON_ID, DP.PERSON_ID)
                AND DP.DUTY_ID                            = NVL(W_DUTY_ID, DP.DUTY_ID)
                AND DP.CORP_ID                            = W_CORP_ID
                AND DP.SOB_ID                             = W_SOB_ID
                AND DP.ORG_ID                             = W_ORG_ID
                AND T2.FLOOR_ID                           = NVL(W_FLOOR_ID, T2.FLOOR_ID)
                AND DP.APPROVE_STATUS                     = NVL(W_APPROVE_STATUS, DP.APPROVE_STATUS)
                AND EXISTS (SELECT 'X'
                              FROM HRD_DUTY_MANAGER         DM
                             WHERE DM.CORP_ID             = DP.CORP_ID
                               AND DM.DUTY_CONTROL_ID     = T2.FLOOR_ID
                               AND DM.WORK_TYPE_ID        = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
                               AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
                               AND DM.SOB_ID              = DP.SOB_ID
                               AND DM.ORG_ID              = DP.ORG_ID
                           )
          ORDER BY PM.NAME
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
                             (PM.WORK_CORP_ID
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
        , DP.ATTRIBUTE3                       = P_CONNECT_PERSON_ID
    WHERE DP.DUTY_PERIOD_ID                   = W_DUTY_PERIOD_ID
    ;
    
    -- 근무계획 반영 사항 취소.
    IF P_APPROVE_STATUS = 'C' THEN
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
                 AND DP.SOB_ID            = WC.SOB_ID
                 AND DP.ORG_ID            = WC.ORG_ID
             )
        WHERE EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_PERIOD DP
                       WHERE DP.DUTY_PERIOD_ID    = W_DUTY_PERIOD_ID
                         AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                         AND DP.PERSON_ID         = WC.PERSON_ID
                         AND DP.SOB_ID            = WC.SOB_ID
                         AND DP.ORG_ID            = WC.ORG_ID
                     )
        ;
      END IF;
      /*-- 근무 카렌다 반영 END. --*/
    END IF;
	EXCEPTION WHEN ERRNUMS.Approval_Nothing THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Approval_Nothing_Code, ERRNUMS.Approval_Nothing_Desc);
  END DATA_UPDATE_RETURN_APPROVE;


-- [2011-09-26]
   PROCEDURE GET_HOLY_TYPE_WORK_CALENDAR
           ( O_HOLY_TYPE    OUT  HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
           , W_SOB_ID       IN   HRM_PERSON_MASTER.SOB_ID%TYPE
           , W_ORG_ID       IN   HRM_PERSON_MASTER.ORG_ID%TYPE
           , W_SEARCH_DATE  IN   HRD_WORK_CALENDAR.WORK_DATE%TYPE
           , W_PERSON_ID    IN   HRM_PERSON_MASTER.PERSON_ID%TYPE
           )
   AS

   BEGIN

           SELECT WC.HOLY_TYPE
             INTO O_HOLY_TYPE
             FROM HRD_WORK_CALENDAR    WC
            WHERE WC.SOB_ID          = W_SOB_ID
              AND WC.ORG_ID          = W_ORG_ID
              AND WC.WORK_DATE       = W_SEARCH_DATE
              AND WC.PERSON_ID       = W_PERSON_ID
                ;

   END GET_HOLY_TYPE_WORK_CALENDAR;




--REQUEST_LIMIT GET[2011-12-13]
  PROCEDURE GET_REQUEST_LIMIT
          ( O_REQUEST_LIMIT_COUNT  OUT HRM_COMMON.VALUE1%TYPE
          , W_SOB_ID               IN  HRM_COMMON.SOB_ID%TYPE
          , W_ORG_ID               IN  HRM_COMMON.ORG_ID%TYPE
          , W_CODE                 IN  HRM_COMMON.CODE%TYPE
          )
  AS

  BEGIN
            SELECT C.VALUE1
              INTO O_REQUEST_LIMIT_COUNT
              FROM HRM_COMMON C
             WHERE C.SOB_ID     = W_SOB_ID
               AND C.ORG_ID     = W_ORG_ID
               AND C.GROUP_CODE = 'REQUEST_LIMIT'
               AND C.CODE       = W_CODE
                 ;

  EXCEPTION
       WHEN OTHERS
       THEN
            O_REQUEST_LIMIT_COUNT := NULL;

  END GET_REQUEST_LIMIT;



END HRD_DUTY_PERIOD_G; 
/
