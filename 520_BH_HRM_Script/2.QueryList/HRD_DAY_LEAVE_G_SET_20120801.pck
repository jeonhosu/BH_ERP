CREATE OR REPLACE PACKAGE HRD_DAY_LEAVE_G_SET
AS

-- 일근태 계산 MAIN.
  PROCEDURE SET_MAIN
            ( P_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
						, P_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, P_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, P_WORK_TYPE_ID                      IN HRD_WORK_CALENDAR.WORK_TYPE_ID%TYPE
						, P_HOLY_TYPE                         IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
						, P_DEPT_ID                           IN HRD_DAY_LEAVE.DEPT_ID%TYPE
						, P_FLOOR_ID                          IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
						, P_JOB_CATEGORY_ID                   IN HRD_DAY_LEAVE.JOB_CATEGORY_ID%TYPE
						, P_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , P_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , P_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_DAY_LEAVE.CREATED_BY%TYPE
						, P_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            );

-- 일근태 계산 처리.
  PROCEDURE WORKDATA_GO
            ( P_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
						, P_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, P_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, P_WORK_TYPE_ID                      IN HRD_WORK_CALENDAR.WORK_TYPE_ID%TYPE
						, P_HOLY_TYPE                         IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
						, P_DEPT_ID                           IN HRD_DAY_LEAVE.DEPT_ID%TYPE
						, P_FLOOR_ID                          IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
						, P_JOB_CATEGORY_ID                   IN HRD_DAY_LEAVE.JOB_CATEGORY_ID%TYPE
						, P_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , P_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , P_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_DAY_LEAVE.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            );

  PROCEDURE WORKDATA_GO_1
            ( P_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE						
						, P_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, P_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, P_WORK_TYPE_ID                      IN HRD_WORK_CALENDAR.WORK_TYPE_ID%TYPE
						, P_HOLY_TYPE                         IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
						, P_DEPT_ID                           IN HRD_DAY_LEAVE.DEPT_ID%TYPE
						, P_FLOOR_ID                          IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
						, P_JOB_CATEGORY_ID                   IN HRD_DAY_LEAVE.JOB_CATEGORY_ID%TYPE
						, P_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , P_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , P_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_DAY_LEAVE.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            );

/*============================================================================================*/
-- 외출시간 계산 function;
  FUNCTION LEAVE_TIME_F
	          ( W_WORK_DATE                         IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , W_JOB_CATEGORY_CODE                 IN VARCHAR2
            , W_HOLY_TYPE                         IN VARCHAR2
            , W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
					  ) RETURN NUMBER;

/*
-- 지각/조퇴 계산 function;
  FUNCTION LATE_TIME_F
	         ( W_WORK_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
					 , W_DUTY_ID                            IN HRD_DAY_LEAVE.DUTY_ID%TYPE
           , W_HOLY_TYPE                          IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
					 , W_PRE_HOLY_TYPE                      IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
					 , W_OPEN_TIME                          IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
					 , W_CLOSE_TIME                         IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
					 , W_PL_OPEN_TIME                       IN HRD_WORK_CALENDAR.OPEN_TIME%TYPE
					 , W_PL_CLOSE_TIME                      IN HRD_WORK_CALENDAR.CLOSE_TIME%TYPE
					 , W_JOB_CATEGORY_CODE                  IN HRM_COMMON.CODE%TYPE
					 , W_SOB_ID                             IN HRD_DAY_LEAVE.SOB_ID%TYPE
					 , W_ORG_ID                             IN HRD_DAY_LEAVE.ORG_ID%TYPE
					 ) RETURN NUMBER;
*/

-- 지각/조퇴 계산 function;
  FUNCTION LATE_TIME_F
	         ( W_WORK_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
					 , W_DUTY_ID                            IN HRD_DAY_LEAVE.DUTY_ID%TYPE
           , W_HOLY_TYPE                          IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
					 , W_PRE_HOLY_TYPE                      IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
           , W_PRE_DANGJIK_YN                     IN HRD_DAY_LEAVE.DANGJIK_YN%TYPE
           , W_PRE_ALL_NIGHT_YN                   IN HRD_DAY_LEAVE.ALL_NIGHT_YN%TYPE
					 , W_OPEN_TIME                          IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
					 , W_CLOSE_TIME                         IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
					 , W_PL_OPEN_TIME                       IN HRD_WORK_CALENDAR.OPEN_TIME%TYPE  
					 , W_PL_CLOSE_TIME                      IN HRD_WORK_CALENDAR.CLOSE_TIME%TYPE
					 , W_JOB_CATEGORY_CODE                  IN HRM_COMMON.CODE%TYPE
					 , W_SOB_ID                             IN HRD_DAY_LEAVE.SOB_ID%TYPE
					 , W_ORG_ID                             IN HRD_DAY_LEAVE.ORG_ID%TYPE
					 ) RETURN NUMBER;

-- 휴식연장 계산 function;
  FUNCTION REST_TIME_F
	         ( W_WORK_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
					 , W_DUTY_ID                            IN HRD_DAY_LEAVE.DUTY_ID%TYPE
           , W_NEXT_WORKING_YN                    IN VARCHAR2
					 , W_PRE_HOLY_TYPE                      IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
					 , W_OPEN_TIME                          IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
					 , W_CLOSE_TIME                         IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
           , W_BREAKFAST_YN                       IN HRD_WORK_CALENDAR.BREAKFAST_YN%TYPE
					 , W_LUNCH_YN                           IN HRD_WORK_CALENDAR.LUNCH_YN%TYPE
					 , W_DINNER_YN                          IN HRD_WORK_CALENDAR.DINNER_YN%TYPE
					 , W_MIDNIGHT_YN                        IN HRD_WORK_CALENDAR.MIDNIGHT_YN%TYPE
					 , W_JOB_CATEGORY_CODE                  IN HRM_COMMON.CODE%TYPE
					 , W_SOB_ID                             IN HRD_DAY_LEAVE.SOB_ID%TYPE
					 , W_ORG_ID                             IN HRD_DAY_LEAVE.ORG_ID%TYPE
					 ) RETURN NUMBER;

-- 연장시간 계산 PROCEDURE;
  PROCEDURE OVER_TIME_P
						( W_WORK_DATE                         IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_DUTY_ID                           IN HRD_DAY_LEAVE.DUTY_ID%TYPE
						, W_HOLY_TYPE                         IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
						, W_PRE_HOLY_TYPE                     IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
            , W_NEXT_HOLY_TYPE                    IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
						, W_DANGJIK_YN                        IN HRD_DAY_LEAVE.DANGJIK_YN%TYPE
						, W_ALL_NIGHT_YN                      IN HRD_DAY_LEAVE.ALL_NIGHT_YN%TYPE
						, W_OPEN_TIME                         IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
						, W_CLOSE_TIME                        IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
						, W_PL_OPEN_TIME                      IN HRD_WORK_CALENDAR.OPEN_TIME%TYPE
					  , W_PL_CLOSE_TIME                     IN HRD_WORK_CALENDAR.CLOSE_TIME%TYPE
						, W_BEFORE_OT_START                   IN HRD_WORK_CALENDAR.BEFORE_OT_START%TYPE
						, W_BEFORE_OT_END                     IN HRD_WORK_CALENDAR.BEFORE_OT_END%TYPE
						, W_AFTER_OT_START                    IN HRD_WORK_CALENDAR.AFTER_OT_START%TYPE
						, W_AFTER_OT_END                      IN HRD_WORK_CALENDAR.AFTER_OT_END%TYPE
						, W_JOB_CATEGORY_CODE                 IN HRM_COMMON.CODE%TYPE
						, W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
						, O_OVER_TIME                         OUT HRD_DAY_LEAVE_OT.OT_TIME%TYPE          -- 연장시간.
						, O_HOLIDAY_TIME                      OUT HRD_DAY_LEAVE_OT.OT_TIME%TYPE          -- 휴일근로.
            , O_HOLIDAY_OT_TIME                   OUT HRD_DAY_LEAVE_OT.OT_TIME%TYPE          -- 휴일연장.
						, O_NIGHT_TIME                        OUT HRD_DAY_LEAVE_OT.OT_TIME%TYPE          -- 야간근로.
						, O_NIGHT_BONUS_TIME                  OUT HRD_DAY_LEAVE_OT.OT_TIME%TYPE          -- 야간할증.
						);

/*============================================================================================*/
-- 출근 시간 정리.
	FUNCTION OPEN_TIME_F
						( P_JOB_CATEGORY_CODE                 IN HRM_COMMON.CODE%TYPE
						, P_HOLY_TYPE                         IN HRM_COMMON.CODE%TYPE
						, P_OPEN_TIME                         IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
						) RETURN DATE;

-- 퇴근 시간 정리.
	FUNCTION CLOSE_TIME_F
						( P_JOB_CATEGORY_CODE                 IN HRM_COMMON.CODE%TYPE
						, P_HOLY_TYPE                         IN HRM_COMMON.CODE%TYPE
						, P_CLOSE_TIME                        IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
						) RETURN DATE;

-- 연장 시작 시간 정리.
	FUNCTION OT_START_TIME_F
						( P_OPEN_TIME                         IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
						, P_PL_START_TIME                     IN HRD_WORK_CALENDAR.BEFORE_OT_START%TYPE
						, P_DEFAULT_RETURN_TIME               IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
						) RETURN DATE;

-- 연장 종료 시간 정리.
	FUNCTION OT_END_TIME_F
						( P_CLOSE_TIME                        IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
						, P_PL_END_TIME                       IN HRD_WORK_CALENDAR.BEFORE_OT_END%TYPE
						, P_DEFAULT_RETURN_TIME               IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
						) RETURN DATE;

/*============================================================================================*/
-- 식시공제 시간 반환;
  FUNCTION FOOD_DED_TIME_F
	         ( W_WORK_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
					 , W_FOOD_TYPE                          IN HRM_FOOD_TIME_V.FOOD_TYPE%TYPE
					 , W_START_TIME                         IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
					 , W_END_TIME                           IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
					 , W_JOB_CATEGORY_CODE                  IN HRM_COMMON.CODE%TYPE
					 , W_SOB_ID                             IN HRD_DAY_LEAVE.SOB_ID%TYPE
					 , W_ORG_ID                             IN HRD_DAY_LEAVE.ORG_ID%TYPE
					 ) RETURN NUMBER;

-- 휴식 공제 시간 반환;
  FUNCTION REST_DED_F
	         ( W_WORK_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
					 , W_REST_TYPE                          IN HRM_REST_TIME_V.REST_TYPE%TYPE
					 , W_START_TIME                         IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
					 , W_END_TIME                           IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
					 , W_JOB_CATEGORY_CODE                  IN HRM_COMMON.CODE%TYPE
					 , W_SOB_ID                             IN HRD_DAY_LEAVE.SOB_ID%TYPE
					 , W_ORG_ID                             IN HRD_DAY_LEAVE.ORG_ID%TYPE
					 ) RETURN NUMBER;

/*============================================================================================*/
-- DAY INTERFACE --> DAY LEAVE UPDATE.
  PROCEDURE LEAVE_DATETIME_UPDATE
            ( W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_END_DATE                          IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_HOLY_TYPE                         IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
            , W_WORK_TYPE_ID                      IN HRD_WORK_CALENDAR.WORK_TYPE_ID%TYPE
						, W_DEPT_ID                           IN HRD_DAY_INTERFACE.DEPT_ID%TYPE
            , W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_JOB_CATEGORY_ID                   IN HRM_PERSON_MASTER.JOB_CATEGORY_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
						, P_USER_ID                           IN HRD_DAY_LEAVE.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
						, O_MESSAGE                           OUT VARCHAR2
            );

-- DAY_LEAVE_OT SAVE(INSERT/UPDATE).
  PROCEDURE DAY_LEAVE_OT_SAVE
	          ( P_DAY_LEAVE_ID                      IN HRD_DAY_LEAVE_OT.DAY_LEAVE_ID%TYPE
            , P_OT_TYPE                           IN HRD_DAY_LEAVE_OT.OT_TYPE%TYPE
            , P_OT_TIME                           IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
            , P_PERSON_ID                         IN HRD_DAY_LEAVE_OT.PERSON_ID%TYPE
						, P_WORK_DATE                         IN HRD_DAY_LEAVE_OT.WORK_DATE%TYPE
						, P_CORP_ID                           IN HRD_DAY_LEAVE_OT.CORP_ID%TYPE
						, P_SOB_ID                            IN HRD_DAY_LEAVE_OT.SOB_ID%TYPE
						, P_ORG_ID                            IN HRD_DAY_LEAVE_OT.ORG_ID%TYPE
						, P_USER_ID                           IN HRD_DAY_LEAVE_OT.CREATED_BY%TYPE
						);

END HRD_DAY_LEAVE_G_SET; 
/
CREATE OR REPLACE PACKAGE BODY HRD_DAY_LEAVE_G_SET
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_DAY_LEAVE_G_SET
/* DESCRIPTION  : 일근태 계산 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/

  C_LEAVE_TIME       CONSTANT HRD_DAY_LEAVE_OT.OT_TYPE%TYPE := '11';       -- 외출시간.
  C_LATE_TIME        CONSTANT HRD_DAY_LEAVE_OT.OT_TYPE%TYPE := '12';       -- 지각/조퇴.
  C_REST_TIME        CONSTANT HRD_DAY_LEAVE_OT.OT_TYPE%TYPE := '13';       -- 휴식연장.
  C_OVER_TIME        CONSTANT HRD_DAY_LEAVE_OT.OT_TYPE%TYPE := '14';       -- 연장.
  C_HOLIDAY_TIME     CONSTANT HRD_DAY_LEAVE_OT.OT_TYPE%TYPE := '15';       -- 휴일근로.
  C_NIGHT_TIME       CONSTANT HRD_DAY_LEAVE_OT.OT_TYPE%TYPE := '16';       -- 야간근로.
  C_NIGHT_BONUS_TIME CONSTANT HRD_DAY_LEAVE_OT.OT_TYPE%TYPE := '17';       -- 야간할증.
  C_HOLIDAY_OT       CONSTANT HRD_DAY_LEAVE_OT.OT_TYPE%TYPE := '18';       -- 휴일연장.

-- 일근태 계산 MAIN.
  PROCEDURE SET_MAIN
            ( P_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
						, P_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, P_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, P_WORK_TYPE_ID                      IN HRD_WORK_CALENDAR.WORK_TYPE_ID%TYPE
						, P_HOLY_TYPE                         IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
						, P_DEPT_ID                           IN HRD_DAY_LEAVE.DEPT_ID%TYPE
						, P_FLOOR_ID                          IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
						, P_JOB_CATEGORY_ID                   IN HRD_DAY_LEAVE.JOB_CATEGORY_ID%TYPE
						, P_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , P_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , P_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_DAY_LEAVE.CREATED_BY%TYPE
						, P_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    V_RECORD_COUNT                                NUMBER := 0;

  BEGIN
    O_STATUS := 'F';
    -- 마감 여부 체크하여 마감(Close = 'y')된 자료이면 집계 안함.
    V_RECORD_COUNT := 0;
		BEGIN
	    -- 자료수 조회.
			SELECT COUNT(DL.PERSON_ID) AS CLOSE_COUNT
			  INTO V_RECORD_COUNT
			FROM HRD_DAY_LEAVE DL
				, HRD_WORK_CALENDAR WC
				, (-- 시점 인사내역.
						SELECT HL.PERSON_ID
								, HL.DEPT_ID
								, HL.JOB_CATEGORY_ID
								, HL.FLOOR_ID    
						FROM HRM_HISTORY_LINE HL  
						WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
																						FROM HRM_HISTORY_LINE S_HL
																					 WHERE S_HL.CHARGE_DATE            <= P_END_DATE
																						 AND S_HL.PERSON_ID              = HL.PERSON_ID
																					 GROUP BY S_HL.PERSON_ID
																				 )
						) T1
			WHERE DL.PERSON_ID                            = WC.PERSON_ID(+)
				AND DL.WORK_DATE                            = WC.WORK_DATE(+)
				AND DL.CORP_ID                              = WC.CORP_ID(+)
				AND DL.SOB_ID                               = WC.SOB_ID(+)
				AND DL.ORG_ID                               = WC.ORG_ID(+)
				AND DL.PERSON_ID                            = T1.PERSON_ID
				AND DL.PERSON_ID                            = NVL(P_PERSON_ID, DL.PERSON_ID)
				AND DL.WORK_DATE                            BETWEEN P_START_DATE AND P_END_DATE
				AND DL.WORK_CORP_ID                         = P_CORP_ID
				AND DL.SOB_ID                               = P_SOB_ID
				AND DL.ORG_ID                               = P_ORG_ID
				AND DL.CLOSED_YN                            = 'N'
				AND T1.FLOOR_ID                             = NVL(P_FLOOR_ID, T1.FLOOR_ID)
				AND NVL(WC.WORK_TYPE_ID, 0)                 = NVL(P_WORK_TYPE_ID, NVL(WC.WORK_TYPE_ID, 0))
				AND NVL(WC.HOLY_TYPE, '-')                  = NVL(P_HOLY_TYPE, NVL(WC.HOLY_TYPE, '-'))
				AND T1.JOB_CATEGORY_ID                      = NVL(P_JOB_CATEGORY_ID, T1.JOB_CATEGORY_ID)
				AND T1.DEPT_ID                              = NVL(P_DEPT_ID, T1.DEPT_ID)
			;
    EXCEPTION WHEN OTHERS THEN
		  V_RECORD_COUNT := 0;
		END;
    IF V_RECORD_COUNT = 0 THEN
      O_STATUS := 'F';
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10052', NULL);
      RETURN;
    END IF;
    
    -- 기존 HRD_DAY_LEAVE_OT 자료 삭제.
    DELETE FROM HRD_DAY_LEAVE_OT DLO
     WHERE EXISTS (SELECT 'X'
                     FROM HRD_DAY_LEAVE DL
                        , HRD_WORK_CALENDAR WC
                        , (-- 시점 인사내역.
                            SELECT HL.PERSON_ID
                                , HL.DEPT_ID
                                , HL.JOB_CATEGORY_ID
                                , HL.FLOOR_ID    
                            FROM HRM_HISTORY_LINE HL  
                            WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                            FROM HRM_HISTORY_LINE S_HL
                                                           WHERE S_HL.CHARGE_DATE            <= P_END_DATE
                                                             AND S_HL.PERSON_ID              = HL.PERSON_ID
                                                           GROUP BY S_HL.PERSON_ID
                                                         )
                            ) T1
                    WHERE DL.PERSON_ID                   = WC.PERSON_ID(+)
                      AND DL.WORK_DATE                   = WC.WORK_DATE(+)
                      AND DL.CORP_ID                     = WC.CORP_ID(+)
                      AND DL.SOB_ID                      = WC.SOB_ID(+)
                      AND DL.ORG_ID                      = WC.ORG_ID(+)
                      AND DL.PERSON_ID                   = T1.PERSON_ID
                      AND DL.DAY_LEAVE_ID                = DLO.DAY_LEAVE_ID
                      AND DL.PERSON_ID                   = NVL(P_PERSON_ID, DL.PERSON_ID)
                      AND DL.WORK_DATE                   BETWEEN P_START_DATE AND P_END_DATE
                      AND DL.WORK_CORP_ID                = P_CORP_ID
                      AND DL.SOB_ID                      = P_SOB_ID
                      AND DL.ORG_ID                      = P_ORG_ID
                      AND DL.CLOSED_YN                   = 'N'
                      AND T1.FLOOR_ID                    = NVL(P_FLOOR_ID, T1.FLOOR_ID)
                      AND NVL(WC.WORK_TYPE_ID, 0)        = NVL(P_WORK_TYPE_ID, NVL(WC.WORK_TYPE_ID, 0))
                      AND NVL(WC.HOLY_TYPE, '-')         = NVL(P_HOLY_TYPE, NVL(WC.HOLY_TYPE, '-'))
                      AND T1.JOB_CATEGORY_ID             = NVL(P_JOB_CATEGORY_ID, T1.JOB_CATEGORY_ID)
                      AND T1.DEPT_ID                     = NVL(P_DEPT_ID, T1.DEPT_ID)
                    );

    -- 일근태 계산 프로시져 호출.
    WORKDATA_GO( P_CORP_ID => P_CORP_ID
		           , P_START_DATE => P_START_DATE
							 , P_END_DATE => P_END_DATE
							 , P_WORK_TYPE_ID => P_WORK_TYPE_ID
							 , P_HOLY_TYPE => P_HOLY_TYPE
							 , P_DEPT_ID => P_DEPT_ID
							 , P_FLOOR_ID => P_FLOOR_ID
							 , P_JOB_CATEGORY_ID => P_JOB_CATEGORY_ID
							 , P_PERSON_ID => P_PERSON_ID
							 , P_SOB_ID => P_SOB_ID
							 , P_ORG_ID => P_ORG_ID
							 , P_USER_ID => P_USER_ID
               , O_STATUS => O_STATUS
							 , O_MESSAGE => O_MESSAGE
							 );


/*
    -- 일근태 계산 프로시져 호출.
    WORKDATA_GO_1
          ( P_CORP_ID => P_CORP_ID
          , P_START_DATE => P_START_DATE
          , P_END_DATE => P_END_DATE
          , P_WORK_TYPE_ID => P_WORK_TYPE_ID
          , P_HOLY_TYPE => P_HOLY_TYPE 
          , P_DEPT_ID => P_DEPT_ID
          , P_FLOOR_ID => P_FLOOR_ID
          , P_JOB_CATEGORY_ID => P_JOB_CATEGORY_ID
          , P_PERSON_ID => P_PERSON_ID
          , P_SOB_ID => P_SOB_ID
          , P_ORG_ID => P_ORG_ID
          , P_USER_ID => P_USER_ID
          , O_STATUS => O_STATUS
          , O_MESSAGE => O_MESSAGE
          );							 
*/
    O_STATUS := 'S';
  END SET_MAIN;



-- 일근태 계산 처리.

  PROCEDURE WORKDATA_GO
            ( P_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
						, P_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, P_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, P_WORK_TYPE_ID                      IN HRD_WORK_CALENDAR.WORK_TYPE_ID%TYPE
						, P_HOLY_TYPE                         IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
						, P_DEPT_ID                           IN HRD_DAY_LEAVE.DEPT_ID%TYPE
						, P_FLOOR_ID                          IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
						, P_JOB_CATEGORY_ID                   IN HRD_DAY_LEAVE.JOB_CATEGORY_ID%TYPE
						, P_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , P_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , P_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_DAY_LEAVE.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
	  CURSOR C_WORKDATA
		       ( W_CORP_ID                            IN HRD_DAY_LEAVE.CORP_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_WORK_TYPE_ID                      IN HRD_WORK_CALENDAR.WORK_TYPE_ID%TYPE
						, W_HOLY_TYPE                         IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
						, W_DEPT_ID                           IN HRD_DAY_LEAVE.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
						, W_JOB_CATEGORY_ID                   IN HRD_DAY_LEAVE.JOB_CATEGORY_ID%TYPE
						, W_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
						, W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
		        )
		IS
		  SELECT DL.DAY_LEAVE_ID
           , DL.PERSON_ID
           , DL.WORK_DATE
           , T1.JOB_CATEGORY_CODE
           , T1.DUTY_CONTROL_YN
           , DL.WORK_TYPE_GROUP
           , DL.DUTY_ID
					 , DC.DUTY_CODE
					 , DC.DAY_LEAVE_CONTROL_YN
           , DL.HOLY_TYPE
           , DL.OPEN_TIME
           , DL.CLOSE_TIME
           , DL.OPEN_TIME1
           , DL.CLOSE_TIME1
           , DL.NEXT_DAY_YN
           , DL.DANGJIK_YN
           , DL.ALL_NIGHT_YN
           , DL.LEAVE_TIME
           , DL.LATE_TIME
           , DL.OVER_TIME
           , DL.HOLIDAY_TIME
           , DL.NIGHT_TIME
           , DL.NIGHT_BONUS_TIME
           , DL.HOLIDAY_CHECK
           , TO_DATE(TO_CHAR(DL.WORK_DATE + NVL(ST1.I_ADD_DAYS, 0), 'YYYY-MM-DD')
                            || ' ' || NVL(ST1.I_TIME, TO_CHAR(DL.PL_OPEN_TIME, 'HH24:MI')), 'YYYY-MM-DD HH24:MI') AS STD_OPEN_TIME
           , TO_DATE(TO_CHAR(DL.WORK_DATE + NVL(ST1.O_ADD_DAYS, 0), 'YYYY-MM-DD')
                            || ' ' || NVL(ST1.O_TIME, TO_CHAR(DL.PL_CLOSE_TIME, 'HH24:MI')), 'YYYY-MM-DD HH24:MI') AS STD_CLOSE_TIME
           , DL.PL_OPEN_TIME
           , DL.PL_CLOSE_TIME
           -- 30" 단위 변경 계산.
           , CASE
               WHEN TO_CHAR(DL.PL_BEFORE_OT_START, 'MI') BETWEEN '01' AND '29' THEN TRUNC(DL.PL_BEFORE_OT_START, 'HH24') + (30/24/60)
               WHEN TO_CHAR(DL.PL_BEFORE_OT_START, 'MI') BETWEEN '31' AND '59' THEN TRUNC(DL.PL_BEFORE_OT_START, 'HH24') + (60/24/60)
               ELSE DL.PL_BEFORE_OT_START
             END AS PL_BEFORE_OT_START
           , CASE
               WHEN TO_CHAR(DL.PL_BEFORE_OT_END, 'MI') BETWEEN '01' AND '29' THEN TRUNC(DL.PL_BEFORE_OT_END, 'HH24')
               WHEN TO_CHAR(DL.PL_BEFORE_OT_END, 'MI') BETWEEN '31' AND '59' THEN TRUNC(DL.PL_BEFORE_OT_END, 'HH24') + (30/24/60)
               ELSE DL.PL_BEFORE_OT_END
             END AS PL_BEFORE_OT_END
           , CASE
               WHEN TO_CHAR(DL.PL_AFTER_OT_START, 'MI') BETWEEN '01' AND '29' THEN TRUNC(DL.PL_AFTER_OT_START, 'HH24') + (30/24/60)
               WHEN TO_CHAR(DL.PL_AFTER_OT_START, 'MI') BETWEEN '31' AND '59' THEN TRUNC(DL.PL_AFTER_OT_START, 'HH24') + (60/24/60)
               ELSE DL.PL_AFTER_OT_START
             END AS PL_AFTER_OT_START
           , CASE
               WHEN TO_CHAR(DL.PL_AFTER_OT_END, 'MI') BETWEEN '01' AND '29' THEN TRUNC(DL.PL_AFTER_OT_END, 'HH24')
               WHEN TO_CHAR(DL.PL_AFTER_OT_END, 'MI') BETWEEN '31' AND '59' THEN TRUNC(DL.PL_AFTER_OT_END, 'HH24') + (30/24/60)
               ELSE DL.PL_AFTER_OT_END
             END AS PL_AFTER_OT_END
           , DL.PL_BREAKFAST_YN
           , DL.PL_LUNCH_YN
           , DL.PL_DINNER_YN
           , DL.PL_MIDNIGHT_YN
           , PW1.HOLY_TYPE AS PRE_HOLY_TYPE
           , PW1.DANGJIK_YN AS PRE_DANGJIK_YN
           , PW1.ALL_NIGHT_YN AS PRE_ALL_NIGHT_YN
           , NW1.HOLY_TYPE AS NEXT_HOLY_TYPE
           , NW1.DANGJIK_YN AS NEXT_DANGJIK_YN
           , NW1.ALL_NIGHT_YN AS NEXT_ALL_NIGHT_YN
           , NW1.STD_OPEN_TIME AS NEXT_STD_OPEN_TIME
           , NW1.STD_CLOSE_TIME AS NEXT_STD_CLOSE_TIME
           , T1.ORI_JOIN_DATE
           , T1.RETIRE_DATE
           , T1.PERSON_NUM
           , T1.NAME
           , DL.CORP_ID
					 , DL.SOB_ID
					 , DL.ORG_ID
        FROM HRD_DAY_LEAVE_V1 DL
				   , HRM_DUTY_CODE_V DC
           , (-- 시점 인사내역.
              SELECT HL.PERSON_ID
                  , PM.NAME
                  , PM.PERSON_NUM
                  , PM.DISPLAY_NAME
                  , HL.DEPT_ID
                  , HL.POST_ID
									, PC.DUTY_CONTROL_YN
                  , HL.JOB_CATEGORY_ID
									, JCC.JOB_CATEGORY_CODE
                  , HL.FLOOR_ID
                  , PM.CORP_ID
                  , PM.ORI_JOIN_DATE
                  , PM.RETIRE_DATE
                  , PM.SOB_ID
                  , PM.ORG_ID
                FROM HRM_HISTORY_LINE HL
                  , HRM_PERSON_MASTER PM
									, HRM_JOB_CATEGORY_CODE_V JCC
									, HRM_POST_CODE_V PC
              WHERE HL.PERSON_ID        = PM.PERSON_ID
							  AND HL.JOB_CATEGORY_ID  = JCC.JOB_CATEGORY_ID
								AND HL.POST_ID          = PC.POST_ID
                AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                              FROM HRM_HISTORY_LINE S_HL
                                             WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
                                               AND S_HL.PERSON_ID              = HL.PERSON_ID
                                             GROUP BY S_HL.PERSON_ID
                                           )
              ) T1
						, (-- 전일근무 정보.
						  SELECT WC.WORK_DATE + 1 AS WORK_DATE
							     , WC.WORK_DATE AS ORI_WORK_DATE
							     , WC.PERSON_ID
									 , WC.CORP_ID
									 , WC.SOB_ID
									 , WC.ORG_ID
									 , WC.HOLY_TYPE
									 , WC.DANGJIK_YN
									 , WC.ALL_NIGHT_YN
								FROM HRD_WORK_CALENDAR WC
							 WHERE WC.WORK_DATE             = W_WORK_DATE - 1
							   AND WC.PERSON_ID             = NVL(W_PERSON_ID, WC.PERSON_ID)
								 AND WC.WORK_CORP_ID          = W_CORP_ID
								 AND WC.SOB_ID                = W_SOB_ID
								 AND WC.ORG_ID                = W_ORG_ID
							) PW1
						, (-- 후일근무 정보.
						  SELECT WC.WORK_DATE - 1 AS WORK_DATE
							     , WC.WORK_DATE AS ORI_WORK_DATE
							     , WC.PERSON_ID
									 , WC.CORP_ID
									 , WC.SOB_ID
									 , WC.ORG_ID
									 , WC.HOLY_TYPE
									 , WC.DANGJIK_YN
									 , WC.ALL_NIGHT_YN
									 , TO_DATE(TO_CHAR(WC.WORK_DATE + NVL(ST1.I_ADD_DAYS, 0), 'YYYY-MM-DD')
                                    || ' ' || NVL(ST1.I_TIME, NVL(TO_CHAR(WC.OPEN_TIME, 'HH24:MI'), '08:30')), 'YYYY-MM-DD HH24:MI') AS STD_OPEN_TIME
                   , TO_DATE(TO_CHAR(WC.WORK_DATE + NVL(ST1.O_ADD_DAYS, 0), 'YYYY-MM-DD')
                                    || ' ' || NVL(ST1.O_TIME, NVL(TO_CHAR(WC.CLOSE_TIME, 'HH24:MI'), '17:30')), 'YYYY-MM-DD HH24:MI') AS STD_CLOSE_TIME
								FROM HRD_WORK_CALENDAR WC
								   , (-- 기준 출퇴근 시간.
											SELECT WIT.WORK_TYPE
													 , WIT.HOLY_TYPE
													 , WIT.I_TIME
													 , WIT.I_ADD_DAYS
													 , WIT.O_TIME
													 , WIT.O_ADD_DAYS
												FROM HRM_WORK_IO_TIME_V WIT
											 WHERE WIT.SOB_ID               = W_SOB_ID
												 AND WIT.ORG_ID               = W_ORG_ID
											) ST1
							 WHERE WC.ATTRIBUTE5            = ST1.WORK_TYPE(+)
							   AND WC.HOLY_TYPE             = ST1.HOLY_TYPE(+)
							   AND WC.WORK_DATE             = W_WORK_DATE + 1
							   AND WC.PERSON_ID             = NVL(W_PERSON_ID, WC.PERSON_ID)
								 AND WC.WORK_CORP_ID          = W_CORP_ID
								 AND WC.SOB_ID                = W_SOB_ID
								 AND WC.ORG_ID                = W_ORG_ID
							) NW1
						, (-- 기준 출퇴근 시간.
						  SELECT WIT.WORK_TYPE
								   , WIT.HOLY_TYPE
								   , WIT.I_TIME
									 , WIT.I_ADD_DAYS
									 , WIT.O_TIME
									 , WIT.O_ADD_DAYS
								FROM HRM_WORK_IO_TIME_V WIT
							 WHERE WIT.SOB_ID               = W_SOB_ID
								 AND WIT.ORG_ID               = W_ORG_ID
							) ST1
      WHERE DL.DUTY_ID                = DC.DUTY_ID
			  AND DL.PERSON_ID              = T1.PERSON_ID
				AND DL.WORK_DATE              = PW1.WORK_DATE(+)
				AND DL.PERSON_ID              = PW1.PERSON_ID(+)
        AND DL.CORP_ID                = PW1.CORP_ID(+)
        AND DL.SOB_ID                 = PW1.SOB_ID(+)
        AND DL.ORG_ID                 = PW1.ORG_ID(+)
				AND DL.WORK_DATE              = NW1.WORK_DATE(+)
				AND DL.PERSON_ID              = NW1.PERSON_ID(+)
        AND DL.CORP_ID                = NW1.CORP_ID(+)
        AND DL.SOB_ID                 = NW1.SOB_ID(+)
        AND DL.ORG_ID                 = NW1.ORG_ID(+)
				AND DL.WORK_TYPE_GROUP        = ST1.WORK_TYPE(+)
				AND DL.HOLY_TYPE              = ST1.HOLY_TYPE(+)
        AND DL.WORK_DATE              = W_WORK_DATE
        AND DL.PERSON_ID              = NVL(W_PERSON_ID, DL.PERSON_ID)
        AND DL.WORK_CORP_ID           = W_CORP_ID
        AND DL.SOB_ID                 = W_SOB_ID
        AND DL.ORG_ID                 = W_ORG_ID
        AND DL.CLOSED_YN              = 'N'
        AND DL.HOLY_TYPE              = NVL(W_HOLY_TYPE, DL.HOLY_TYPE)
				AND DL.WORK_TYPE_ID           = NVL(W_WORK_TYPE_ID, DL.WORK_TYPE_ID)
        AND T1.FLOOR_ID               = NVL(W_FLOOR_ID, T1.FLOOR_ID)
        AND T1.DEPT_ID                = NVL(W_DEPT_ID, T1.DEPT_ID)
        AND T1.JOB_CATEGORY_ID        = NVL(W_JOB_CATEGORY_ID, T1.JOB_CATEGORY_ID)
				AND T1.ORI_JOIN_DATE          <= W_WORK_DATE
				AND (T1.RETIRE_DATE IS NULL OR T1.RETIRE_DATE >= W_WORK_DATE)
      ORDER BY DL.WORK_DATE, DL.HOLY_TYPE
			;

		V_DAY_COUNT                 NUMBER := 0;                          -- 계산총 일수.
    V_WORK_DATE                 HRD_DAY_LEAVE.WORK_DATE%TYPE;         -- 근무일자.

    V_LEAVE_TIME                HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 외출시간 적용.
		V_LATE_TIME                 HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 지각시간.
		V_REST_TIME                 HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 휴식연장.
		V_OVER_TIME                 HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 연장시간.
		V_HOLIDAY_TIME              HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 휴일근로.
    V_HOLIDAY_OT_TIME           HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 휴일연장근로.
		V_NIGHT_TIME                HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 야간근로.
		V_NIGHT_BONUS_TIME          HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 야간할증.
		V_HOLIDAY_CHECK             HRD_DAY_LEAVE.HOLIDAY_CHECK%TYPE;     -- 휴일근로여부.

		V_FOOD_DED_TIME             NUMBER := 0;                          -- 식사 공제시간.
		V_REST_DED_TIME             NUMBER := 0;                          -- 휴식시간 공제 시간.

		V_OPEN_TIME                 HRD_DAY_LEAVE.OPEN_TIME%TYPE;         -- 정리된 출근시간.
		V_CLOSE_TIME                HRD_DAY_LEAVE.CLOSE_TIME%TYPE;        -- 정리된 퇴근시간.
		V_OT_OPEN_TIME              HRD_DAY_LEAVE.OPEN_TIME%TYPE;         -- 30" 정리된 출근시간.
		V_OT_CLOSE_TIME             HRD_DAY_LEAVE.CLOSE_TIME%TYPE;        -- 30" 정리된 퇴근시간.

		V_OT_START_TIME             HRD_DAY_LEAVE.OPEN_TIME%TYPE;         -- 연장등 계산 시작 시간.
		V_OT_MID_TIME               HRD_DAY_LEAVE.OPEN_TIME%TYPE;         -- 연장등 계산 중간 시간.
		V_OT_END_TIME               HRD_DAY_LEAVE.CLOSE_TIME%TYPE;        -- 연장등 계산 종료 시간.

		V_PRE_HOLY_TYPE             HRD_DAY_LEAVE.HOLY_TYPE%TYPE := 'N';  -- 전일 근무/당직/철야 여부.

  BEGIN
    O_STATUS := 'F';
	  V_DAY_COUNT := (P_END_DATE - P_START_DATE) + 1;

		-- V_DAY_COUNT 만큼_일근태_계산.--
		FOR D1 IN 0 .. V_DAY_COUNT - 1
		LOOP
		  V_WORK_DATE := P_START_DATE + D1;

			-- V_WORK_DATE에 대한 일근태_계산.--
		  FOR C1 IN C_WORKDATA ( P_CORP_ID
														, V_WORK_DATE
														, P_WORK_TYPE_ID
														, P_HOLY_TYPE
														, P_DEPT_ID
														, P_FLOOR_ID
														, P_JOB_CATEGORY_ID
														, P_PERSON_ID
														, P_SOB_ID
														, P_ORG_ID
														)
			LOOP
			  -- 변수 초기화 --
        V_LEAVE_TIME                := 0;
				V_LATE_TIME                 := 0;
				V_REST_TIME                 := 0;
				V_OVER_TIME                 := 0;
				V_HOLIDAY_TIME              := 0;
        V_HOLIDAY_OT_TIME           := 0;
				V_NIGHT_TIME                := 0;
				V_NIGHT_BONUS_TIME          := 0;
				V_HOLIDAY_CHECK             := 'N';

				V_FOOD_DED_TIME             := 0;
				V_REST_DED_TIME             := 0;

				V_OPEN_TIME                 := NULL;                 -- 30"단위 정리전 시간.
				V_CLOSE_TIME                := NULL;

				V_OT_OPEN_TIME              := NULL;                 -- 30" 단위 정리된 시간.
				V_OT_CLOSE_TIME             := NULL;

				V_OT_START_TIME             := NULL;
				V_OT_MID_TIME               := NULL;
				V_OT_END_TIME               := NULL;

				-- 계산 방법 정의 시작 --
				-- 1. DUTY_CONTROL_YN = 'Y' 값만 처리(공통코드 : 직위에 설정).
				-- 2. 관리직, 생산직으로 분리 계산하고, HOLY_TYPE에 따라 계산.
				-- 3. 연장계산 기준정보 설정값은 공통코드(HD312, HD313)에 설정.
				-- 계산 방법 정의 끝 --
				IF C1.DUTY_CONTROL_YN = 'N' THEN
				-- 일근태 계산 제외 --.
				  NULL;
        ELSIF C1.DUTY_CODE IN ('11', '12', '13', '17', '19', 
                              '20', '22', '23', 
                              '30', 
                              '54', '55', '56', 
                              '77', '78', 
                              '94', '95', '96', '97', '98') THEN
          NULL;
				ELSE
				-- 일근태 계산 처리 --.
-----------------------------------------------------------------------------------------
					-- 출/퇴근 정리 START --
					IF C1.OPEN_TIME IS NOT NULL AND C1.OPEN_TIME1 IS NOT NULL THEN
					-- 출근 중복 존재시 작은값 적용.
						IF C1.OPEN_TIME < C1.OPEN_TIME1 THEN
							V_OPEN_TIME := C1.OPEN_TIME;
						ELSE
							V_OPEN_TIME := C1.OPEN_TIME1;
						END IF;
					ELSIF C1.OPEN_TIME IS NULL AND C1.OPEN_TIME1 IS NOT NULL THEN
					-- 중출에만 시간 존재시 중출값을 적용.
						V_OPEN_TIME := C1.OPEN_TIME1;
					ELSE
						V_OPEN_TIME := C1.OPEN_TIME;
					END IF;
-----------------------------------------------------------------------------------------
					IF C1.CLOSE_TIME IS NOT NULL AND C1.CLOSE_TIME1 IS NOT NULL THEN
					-- 퇴근 중복 존재시 큰값 적용.
						IF C1.CLOSE_TIME < C1.CLOSE_TIME1 THEN
							V_CLOSE_TIME := C1.CLOSE_TIME1;
						ELSE
							V_CLOSE_TIME := C1.CLOSE_TIME;
						END IF;
					ELSIF C1.CLOSE_TIME IS NULL AND C1.CLOSE_TIME1 IS NOT NULL THEN
					-- 중퇴에만 시간 존재시 중퇴값을 적용.
						V_CLOSE_TIME := C1.CLOSE_TIME1;
					ELSE
						V_CLOSE_TIME := C1.CLOSE_TIME;
					END IF;
-----------------------------------------------------------------------------------------
          -- 퇴근시간이 출근시간보다 클 경우 퇴근시간 NULL 적용.
				  IF V_CLOSE_TIME < V_OPEN_TIME THEN
					  V_CLOSE_TIME := TO_DATE(NULL);
					END IF;
-----------------------------------------------------------------------------------------
					/*-- 전일 야간, 당직, 철야로 인해 출근 없을 경우 강제로 출근시간 생성.
					IF V_OPEN_TIME IS NULL AND C1.DAY_LEAVE_CONTROL_YN = 'Y' THEN
					  IF (C1.PRE_HOLY_TYPE = '3' OR C1.PRE_DANGJIK_YN = 'Y' OR C1.PRE_ALL_NIGHT_YN = 'Y') THEN
							V_OPEN_TIME := C1.STD_OPEN_TIME;
						ELSE
							V_OPEN_TIME := C1.PL_OPEN_TIME;
						END IF;
					END IF;*/
					-- 금일 야간, 당직, 철야로 인해 퇴근 없을 경우 강제로 퇴근시간 생성.
					IF V_CLOSE_TIME IS NULL AND C1.DAY_LEAVE_CONTROL_YN = 'Y' THEN
					  IF (C1.HOLY_TYPE = '3' OR C1.DANGJIK_YN = 'Y' OR C1.ALL_NIGHT_YN = 'Y') AND
						   (C1.NEXT_DANGJIK_YN = 'Y' OR C1.NEXT_ALL_NIGHT_YN = 'Y' ) THEN
							V_CLOSE_TIME := C1.NEXT_STD_OPEN_TIME;
						ELSE
							V_CLOSE_TIME := C1.PL_CLOSE_TIME;
						END IF;
					END IF;
-----------------------------------------------------------------------------------------
          IF C1.PRE_HOLY_TYPE = '3' OR C1.PRE_DANGJIK_YN = 'Y' OR C1.ALL_NIGHT_YN = 'Y' THEN
					  V_PRE_HOLY_TYPE := 'Y';
					ELSE
					  V_PRE_HOLY_TYPE := 'N';
					END IF;
--DBMS_OUTPUT.PUT_LINE('1성명 : ' || C1.NAME || '(' || C1.PERSON_ID || ')' ||
--                     ', 실제O =>' || TO_CHAR(C1.OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
--                     ', 실제C =>' || TO_CHAR(C1.CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
--                     ', 정리O=>' || TO_CHAR(V_OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
--                     ', 정리C=>' || TO_CHAR(V_CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS'));         
-----------------------------------------------------------------------------------------
					-- 출퇴근 시간 정리.
					V_OT_OPEN_TIME := OPEN_TIME_F( P_JOB_CATEGORY_CODE => C1.JOB_CATEGORY_CODE
																				, P_HOLY_TYPE => C1.HOLY_TYPE
																				, P_OPEN_TIME => V_OPEN_TIME
																				);
					V_OT_CLOSE_TIME := CLOSE_TIME_F( P_JOB_CATEGORY_CODE => C1.JOB_CATEGORY_CODE
																					, P_HOLY_TYPE => C1.HOLY_TYPE
																					, P_CLOSE_TIME => V_CLOSE_TIME
																					);
--DBMS_OUTPUT.PUT_LINE('2성명 : ' || C1.NAME || '(' || C1.PERSON_ID || ')' ||
--                     ', 실제O =>' || TO_CHAR(C1.OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
--                     ', 실제C =>' || TO_CHAR(C1.CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
--										 \*', 실제DO =>' || TO_CHAR(C1.OPEN_TIME1, 'YYYY-MM-DD HH24:MI:SS') ||
--                     ', 실제DC =>' || TO_CHAR(C1.CLOSE_TIME1, 'YYYY-MM-DD HH24:MI:SS') ||*\
--                     ', 정리O=>' || TO_CHAR(V_OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
--                     ', 정리C=>' || TO_CHAR(V_CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
--										 ', 30"O=>' || TO_CHAR(V_OT_OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
--                     ', 30"C=>' || TO_CHAR(V_OT_CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS'));
-----------------------------------------------------------------------------------------
          -- 0. 외출시간 적용 --> 출퇴근 수정에서 적용.
          V_LEAVE_TIME := LEAVE_TIME_F( W_WORK_DATE => V_WORK_DATE
                                      , W_CORP_ID => C1.CORP_ID
                                      , W_PERSON_ID => C1.PERSON_ID
                                      , W_JOB_CATEGORY_CODE => C1.JOB_CATEGORY_CODE
                                      , W_HOLY_TYPE => C1.HOLY_TYPE
                                      , W_SOB_ID => C1.SOB_ID
                                      , W_ORG_ID => C1.ORG_ID
                                      );
					-- 1. 지각/조퇴 시간 계산.
          IF C1.DUTY_CODE IN ('00', '12', '13', '18', '21') THEN
            V_LATE_TIME := LATE_TIME_F( W_WORK_DATE => V_WORK_DATE
                                      , W_DUTY_ID => C1.DUTY_ID
                                      , W_HOLY_TYPE => C1.HOLY_TYPE
                                      , W_PRE_HOLY_TYPE => V_PRE_HOLY_TYPE
                                      , W_PRE_DANGJIK_YN => C1.PRE_DANGJIK_YN
                                      , W_PRE_ALL_NIGHT_YN => C1.PRE_ALL_NIGHT_YN
                                      , W_OPEN_TIME => V_OT_OPEN_TIME
                                      , W_CLOSE_TIME => V_OT_CLOSE_TIME
                                      , W_PL_OPEN_TIME => C1.PL_OPEN_TIME
                                      , W_PL_CLOSE_TIME => C1.PL_CLOSE_TIME
                                      , W_JOB_CATEGORY_CODE => C1.JOB_CATEGORY_CODE
                                      , W_SOB_ID => C1.SOB_ID
                                      , W_ORG_ID => C1.ORG_ID
                                      );
          ELSE
            V_LATE_TIME := 0;
          END IF;
          -- 2. 휴식연장 시간 계산.
					V_REST_TIME := REST_TIME_F( W_WORK_DATE => V_WORK_DATE
					                          , W_DUTY_ID => C1.DUTY_ID
																		, W_NEXT_WORKING_YN => CASE
                                                             WHEN C1.HOLY_TYPE = '3' THEN 'Y'
                                                             WHEN C1.DANGJIK_YN = 'Y' THEN 'Y'
                                                             WHEN C1.ALL_NIGHT_YN = 'Y' THEN 'Y'
                                                             ELSE 'N'
                                                           END
																		, W_PRE_HOLY_TYPE => V_PRE_HOLY_TYPE
																		, W_OPEN_TIME => V_OPEN_TIME
																		, W_CLOSE_TIME => V_CLOSE_TIME
                                    , W_BREAKFAST_YN => C1.PL_BREAKFAST_YN
																		, W_LUNCH_YN => C1.PL_LUNCH_YN
																		, W_DINNER_YN => C1.PL_DINNER_YN
																		, W_MIDNIGHT_YN => C1.PL_MIDNIGHT_YN
																		, W_JOB_CATEGORY_CODE => C1.JOB_CATEGORY_CODE
																		, W_SOB_ID => C1.SOB_ID
																		, W_ORG_ID => C1.ORG_ID
																		);
					-- 3. 연장/야간근로/야간할증/휴일근로 시간 계산.
					OVER_TIME_P ( W_WORK_DATE => V_WORK_DATE
					            , W_DUTY_ID => C1.DUTY_ID
											, W_HOLY_TYPE => C1.HOLY_TYPE
											, W_PRE_HOLY_TYPE => V_PRE_HOLY_TYPE
                      , W_NEXT_HOLY_TYPE => C1.NEXT_HOLY_TYPE
											, W_DANGJIK_YN => C1.DANGJIK_YN
											, W_ALL_NIGHT_YN => C1.ALL_NIGHT_YN
											, W_OPEN_TIME => V_OT_OPEN_TIME
											, W_CLOSE_TIME => V_OT_CLOSE_TIME
											, W_PL_OPEN_TIME => C1.PL_OPEN_TIME
											, W_PL_CLOSE_TIME => C1.PL_CLOSE_TIME
											, W_BEFORE_OT_START => C1.PL_BEFORE_OT_START
											, W_BEFORE_OT_END => C1.PL_BEFORE_OT_END
											, W_AFTER_OT_START => C1.PL_AFTER_OT_START
											, W_AFTER_OT_END => C1.PL_AFTER_OT_END
											, W_JOB_CATEGORY_CODE => C1.JOB_CATEGORY_CODE
											, W_SOB_ID => C1.SOB_ID
											, W_ORG_ID => C1.ORG_ID
											, O_OVER_TIME => V_OVER_TIME
											, O_HOLIDAY_TIME => V_HOLIDAY_TIME
                      , O_HOLIDAY_OT_TIME => V_HOLIDAY_OT_TIME
											, O_NIGHT_TIME => V_NIGHT_TIME
											, O_NIGHT_BONUS_TIME => V_NIGHT_BONUS_TIME
											);
					-- 4. 휴일근무 체크.
					IF C1.HOLY_TYPE IN ('0', '1') AND V_HOLIDAY_TIME > 0 THEN
					  V_HOLIDAY_CHECK := 'Y';
					END IF;
          
          -- 휴일 8h 이하 근무시 기본8h적용.
          IF C1.HOLY_TYPE IN ('0', '1') THEN
            V_HOLIDAY_OT_TIME := NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_REST_TIME, 0);
            V_REST_TIME := 0;  -- 휴일휴식연장 -> 200% 지급.
            
            IF NVL(V_HOLIDAY_TIME, 0) > 8 THEN
              V_HOLIDAY_OT_TIME := NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_HOLIDAY_TIME, 0) - 8;
              V_HOLIDAY_TIME := 8;
            ELSIF NVL(V_HOLIDAY_TIME, 0) < 8 THEN
              IF NVL(V_HOLIDAY_TIME, 0) + NVL(V_HOLIDAY_OT_TIME, 0) > 8 THEN
                V_HOLIDAY_OT_TIME := NVL(V_HOLIDAY_TIME, 0) + NVL(V_HOLIDAY_OT_TIME, 0) - 8;
                V_HOLIDAY_TIME := 8;
              ELSE
                V_HOLIDAY_TIME := NVL(V_HOLIDAY_TIME, 0) + NVL(V_HOLIDAY_OT_TIME, 0);
                V_HOLIDAY_OT_TIME := 0;                
              END IF;
            END IF;
          END IF;
        END IF;

			  -- 계산 결과 UPDATE --
				UPDATE HRD_DAY_LEAVE DL
				   SET DL.HOLIDAY_CHECK     = V_HOLIDAY_CHECK
						 , DL.LAST_UPDATE_DATE  = GET_LOCAL_DATE(DL.SOB_ID)
						 , DL.LAST_UPDATED_BY   = P_USER_ID
		    WHERE DL.DAY_LEAVE_ID       = C1.DAY_LEAVE_ID
				;

        -- 잔업 사항 저장. --
        -- LEAVE_TIME.
        DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => C1.DAY_LEAVE_ID
                          , P_OT_TYPE => C_LEAVE_TIME      -- '11'
                          , P_OT_TIME => V_LEAVE_TIME
                          , P_PERSON_ID => C1.PERSON_ID
                          , P_WORK_DATE => C1.WORK_DATE
                          , P_CORP_ID => C1.CORP_ID
                          , P_SOB_ID => C1.SOB_ID
                          , P_ORG_ID => C1.ORG_ID
                          , P_USER_ID => P_USER_ID
                          );
        -- LATE_TIME.
        DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => C1.DAY_LEAVE_ID
                          , P_OT_TYPE => C_LATE_TIME       -- '12'
                          , P_OT_TIME => V_LATE_TIME
                          , P_PERSON_ID => C1.PERSON_ID
                          , P_WORK_DATE => C1.WORK_DATE
                          , P_CORP_ID => C1.CORP_ID
                          , P_SOB_ID => C1.SOB_ID
                          , P_ORG_ID => C1.ORG_ID
                          , P_USER_ID => P_USER_ID
                          );
        -- REST_TIME.
        DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => C1.DAY_LEAVE_ID
                          , P_OT_TYPE => C_REST_TIME       -- '13'
                          , P_OT_TIME => V_REST_TIME
                          , P_PERSON_ID => C1.PERSON_ID
                          , P_WORK_DATE => C1.WORK_DATE
                          , P_CORP_ID => C1.CORP_ID
                          , P_SOB_ID => C1.SOB_ID
                          , P_ORG_ID => C1.ORG_ID
                          , P_USER_ID => P_USER_ID
                          );
        -- OVER_TIME.
        DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => C1.DAY_LEAVE_ID
                          , P_OT_TYPE => C_OVER_TIME       --'14'
                          , P_OT_TIME => V_OVER_TIME
                          , P_PERSON_ID => C1.PERSON_ID
                          , P_WORK_DATE => C1.WORK_DATE
                          , P_CORP_ID => C1.CORP_ID
                          , P_SOB_ID => C1.SOB_ID
                          , P_ORG_ID => C1.ORG_ID
                          , P_USER_ID => P_USER_ID
                          );
        -- HOLIDAY_TIME.
        DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => C1.DAY_LEAVE_ID
                          , P_OT_TYPE => C_HOLIDAY_TIME    --'15'
                          , P_OT_TIME => V_HOLIDAY_TIME
                          , P_PERSON_ID => C1.PERSON_ID
                          , P_WORK_DATE => C1.WORK_DATE
                          , P_CORP_ID => C1.CORP_ID
                          , P_SOB_ID => C1.SOB_ID
                          , P_ORG_ID => C1.ORG_ID
                          , P_USER_ID => P_USER_ID
                          );
        -- HOLIDAY_OT_TIME.
        DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => C1.DAY_LEAVE_ID
                          , P_OT_TYPE => C_HOLIDAY_OT    --'18'
                          , P_OT_TIME => V_HOLIDAY_OT_TIME
                          , P_PERSON_ID => C1.PERSON_ID
                          , P_WORK_DATE => C1.WORK_DATE
                          , P_CORP_ID => C1.CORP_ID
                          , P_SOB_ID => C1.SOB_ID
                          , P_ORG_ID => C1.ORG_ID
                          , P_USER_ID => P_USER_ID
                          );
        -- NIGHT_TIME.
        DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => C1.DAY_LEAVE_ID
                          , P_OT_TYPE => C_NIGHT_TIME      -- '16'
                          , P_OT_TIME => V_NIGHT_TIME
                          , P_PERSON_ID => C1.PERSON_ID
                          , P_WORK_DATE => C1.WORK_DATE
                          , P_CORP_ID => C1.CORP_ID
                          , P_SOB_ID => C1.SOB_ID
                          , P_ORG_ID => C1.ORG_ID
                          , P_USER_ID => P_USER_ID
                          );
        -- NIGHT_BONUS_TIME.
        DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => C1.DAY_LEAVE_ID
                          , P_OT_TYPE => C_NIGHT_BONUS_TIME   -- '17'
                          , P_OT_TIME => V_NIGHT_BONUS_TIME
                          , P_PERSON_ID => C1.PERSON_ID
                          , P_WORK_DATE => C1.WORK_DATE
                          , P_CORP_ID => C1.CORP_ID
                          , P_SOB_ID => C1.SOB_ID
                          , P_ORG_ID => C1.ORG_ID
                          , P_USER_ID => P_USER_ID
                          );

		  END LOOP C1;
		END LOOP D1;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10058', NULL);
    RETURN;
  END WORKDATA_GO;
  
-- 일근태 계산 처리(실적만 가지고 계산-연장근무 신청 반영 안함).
  PROCEDURE WORKDATA_GO_1
            ( P_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE						
						, P_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, P_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, P_WORK_TYPE_ID                      IN HRD_WORK_CALENDAR.WORK_TYPE_ID%TYPE
						, P_HOLY_TYPE                         IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
						, P_DEPT_ID                           IN HRD_DAY_LEAVE.DEPT_ID%TYPE
						, P_FLOOR_ID                          IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
						, P_JOB_CATEGORY_ID                   IN HRD_DAY_LEAVE.JOB_CATEGORY_ID%TYPE
						, P_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , P_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , P_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_DAY_LEAVE.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    CURSOR C_WORKDATA
		       ( W_CORP_ID                            IN HRD_DAY_LEAVE.CORP_ID%TYPE						
						, W_WORK_DATE                         IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_WORK_TYPE_ID                      IN HRD_WORK_CALENDAR.WORK_TYPE_ID%TYPE
						, W_HOLY_TYPE                         IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
						, W_DEPT_ID                           IN HRD_DAY_LEAVE.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
						, W_JOB_CATEGORY_ID                   IN HRD_DAY_LEAVE.JOB_CATEGORY_ID%TYPE
						, W_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
						, W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
		        )
		IS
		  SELECT DL.DAY_LEAVE_ID
           , DL.PERSON_ID
           , DL.WORK_DATE
           , T1.JOB_CATEGORY_CODE
           , T1.DUTY_CONTROL_YN
           , DL.WORK_TYPE_GROUP           
           , DL.DUTY_ID
					 , DC.DUTY_CODE
					 , DC.DAY_LEAVE_CONTROL_YN
           , DL.HOLY_TYPE
           , DL.OPEN_TIME
           , DL.CLOSE_TIME
           , DL.OPEN_TIME1
           , DL.CLOSE_TIME1
           , DL.NEXT_DAY_YN
           , DL.DANGJIK_YN
           , DL.ALL_NIGHT_YN
           , DL.LEAVE_TIME
           , DL.LATE_TIME
           , DL.OVER_TIME
           , DL.HOLIDAY_TIME
           , DL.NIGHT_TIME
           , DL.NIGHT_BONUS_TIME
           , DL.HOLIDAY_CHECK
           , TO_DATE(TO_CHAR(DL.WORK_DATE + NVL(ST1.I_ADD_DAYS, 0), 'YYYY-MM-DD') 
                            || ' ' || NVL(ST1.I_TIME, TO_CHAR(DL.PL_OPEN_TIME, 'HH24:MI')), 'YYYY-MM-DD HH24:MI') AS STD_OPEN_TIME
           , TO_DATE(TO_CHAR(DL.WORK_DATE + NVL(ST1.O_ADD_DAYS, 0), 'YYYY-MM-DD') 
                            || ' ' || NVL(ST1.O_TIME, TO_CHAR(DL.PL_CLOSE_TIME, 'HH24:MI')), 'YYYY-MM-DD HH24:MI') AS STD_CLOSE_TIME
           , DL.PL_OPEN_TIME
           , DL.PL_CLOSE_TIME
           -- 30" 단위 변경 계산.
           , NULL AS PL_BEFORE_OT_START
           , NULL AS PL_BEFORE_OT_END
           , CASE
               WHEN TO_CHAR(DL.OPEN_TIME, 'MI') BETWEEN '01' AND '29' THEN TRUNC(DL.OPEN_TIME, 'HH24') + (30/24/60)
               WHEN TO_CHAR(DL.OPEN_TIME, 'MI') BETWEEN '31' AND '59' THEN TRUNC(DL.OPEN_TIME, 'HH24') + (60/24/60)
               ELSE DL.OPEN_TIME
             END AS PL_AFTER_OT_START
           , CASE
               WHEN TO_CHAR(CASE
                              WHEN DL.CLOSE_TIME1 IS NULL THEN DL.CLOSE_TIME
                              ELSE DL.CLOSE_TIME1
                            END, 'MI') BETWEEN '01' AND '29' THEN TRUNC(CASE
                                                                          WHEN DL.CLOSE_TIME1 IS NULL THEN DL.CLOSE_TIME
                                                                          ELSE DL.CLOSE_TIME1
                                                                        END, 'HH24')
               WHEN TO_CHAR(CASE
                              WHEN DL.CLOSE_TIME1 IS NULL THEN DL.CLOSE_TIME
                              ELSE DL.CLOSE_TIME1
                            END, 'MI') BETWEEN '31' AND '59' THEN TRUNC(CASE
                                                                          WHEN DL.CLOSE_TIME1 IS NULL THEN DL.CLOSE_TIME
                                                                          ELSE DL.CLOSE_TIME1
                                                                        END, 'HH24') + (30/24/60)
               ELSE CASE
                      WHEN DL.CLOSE_TIME1 IS NULL THEN DL.CLOSE_TIME
                      ELSE DL.CLOSE_TIME1
                    END
             END AS PL_AFTER_OT_END
           , DL.PL_BREAKFAST_YN
           , DL.PL_LUNCH_YN
           , DL.PL_DINNER_YN
           , DL.PL_MIDNIGHT_YN
           , PW1.HOLY_TYPE AS PRE_HOLY_TYPE
           , PW1.DANGJIK_YN AS PRE_DANGJIK_YN
           , PW1.ALL_NIGHT_YN AS PRE_ALL_NIGHT_YN
           , NW1.HOLY_TYPE AS NEXT_HOLY_TYPE
           , NW1.DANGJIK_YN AS NEXT_DANGJIK_YN
           , NW1.ALL_NIGHT_YN AS NEXT_ALL_NIGHT_YN
           , NW1.STD_OPEN_TIME AS NEXT_STD_OPEN_TIME
           , NW1.STD_CLOSE_TIME AS NEXT_STD_CLOSE_TIME
           , T1.ORI_JOIN_DATE
           , T1.RETIRE_DATE
           , T1.PERSON_NUM
           , T1.NAME
           , DL.CORP_ID 
					 , DL.SOB_ID
					 , DL.ORG_ID
        FROM HRD_DAY_LEAVE_V1 DL
				   , HRM_DUTY_CODE_V DC
           , (-- 시점 인사내역.
              SELECT HL.PERSON_ID
                  , PM.NAME
                  , PM.PERSON_NUM
                  , PM.DISPLAY_NAME
                  , HL.DEPT_ID
                  , HL.POST_ID
									, PC.DUTY_CONTROL_YN
                  , HL.JOB_CATEGORY_ID
									, JCC.JOB_CATEGORY_CODE
                  , HL.FLOOR_ID    
                  , PM.CORP_ID
                  , PM.ORI_JOIN_DATE
                  , PM.RETIRE_DATE
                  , PM.SOB_ID
                  , PM.ORG_ID
                FROM HRM_HISTORY_LINE HL  
                  , HRM_PERSON_MASTER PM
									, HRM_JOB_CATEGORY_CODE_V JCC
									, HRM_POST_CODE_V PC
              WHERE HL.PERSON_ID        = PM.PERSON_ID
							  AND HL.JOB_CATEGORY_ID  = JCC.JOB_CATEGORY_ID
								AND HL.POST_ID          = PC.POST_ID
                AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                              FROM HRM_HISTORY_LINE S_HL
                                             WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
                                               AND S_HL.PERSON_ID              = HL.PERSON_ID
                                             GROUP BY S_HL.PERSON_ID
                                           )
              ) T1
						, (-- 전일근무 정보.
						  SELECT WC.WORK_DATE + 1 AS WORK_DATE
							     , WC.WORK_DATE AS ORI_WORK_DATE
							     , WC.PERSON_ID
									 , WC.CORP_ID
									 , WC.SOB_ID
									 , WC.ORG_ID
									 , WC.HOLY_TYPE
									 , WC.DANGJIK_YN
									 , WC.ALL_NIGHT_YN
								FROM HRD_WORK_CALENDAR WC
							 WHERE WC.WORK_DATE             = W_WORK_DATE - 1
							   AND WC.PERSON_ID             = NVL(W_PERSON_ID, WC.PERSON_ID)
								 AND WC.WORK_CORP_ID          = W_CORP_ID
								 AND WC.SOB_ID                = W_SOB_ID
								 AND WC.ORG_ID                = W_ORG_ID
							) PW1
						, (-- 후일근무 정보.
						  SELECT WC.WORK_DATE - 1 AS WORK_DATE
							     , WC.WORK_DATE AS ORI_WORK_DATE
							     , WC.PERSON_ID
									 , WC.CORP_ID
									 , WC.SOB_ID
									 , WC.ORG_ID
									 , WC.HOLY_TYPE
									 , WC.DANGJIK_YN
									 , WC.ALL_NIGHT_YN
									 , TO_DATE(TO_CHAR(WC.WORK_DATE + NVL(ST1.I_ADD_DAYS, 0), 'YYYY-MM-DD') 
									                  || ' ' || NVL(ST1.I_TIME, TO_CHAR(WC.OPEN_TIME, 'HH24:MI')), 'YYYY-MM-DD HH24:MI') AS STD_OPEN_TIME
					         , TO_DATE(TO_CHAR(WC.WORK_DATE + NVL(ST1.O_ADD_DAYS, 0), 'YYYY-MM-DD') 
									                  || ' ' || NVL(ST1.O_TIME, TO_CHAR(WC.CLOSE_TIME, 'HH24:MI')), 'YYYY-MM-DD HH24:MI') AS STD_CLOSE_TIME
								FROM HRD_WORK_CALENDAR WC
								   , (-- 기준 출퇴근 시간.
											SELECT WIT.WORK_TYPE
													 , WIT.HOLY_TYPE
													 , WIT.I_TIME
													 , WIT.I_ADD_DAYS
													 , WIT.O_TIME
													 , WIT.O_ADD_DAYS
												FROM HRM_WORK_IO_TIME_V WIT
											 WHERE WIT.SOB_ID               = W_SOB_ID
												 AND WIT.ORG_ID               = W_ORG_ID
											) ST1	 
							 WHERE WC.ATTRIBUTE5            = ST1.WORK_TYPE(+)
							   AND WC.HOLY_TYPE             = ST1.HOLY_TYPE(+)        
							   AND WC.WORK_DATE             = W_WORK_DATE + 1
							   AND WC.PERSON_ID             = NVL(W_PERSON_ID, WC.PERSON_ID)
								 AND WC.WORK_CORP_ID          = W_CORP_ID
								 AND WC.SOB_ID                = W_SOB_ID
								 AND WC.ORG_ID                = W_ORG_ID
							) NW1
						, (-- 기준 출퇴근 시간.
						  SELECT WIT.WORK_TYPE
								   , WIT.HOLY_TYPE
								   , WIT.I_TIME
									 , WIT.I_ADD_DAYS
									 , WIT.O_TIME
									 , WIT.O_ADD_DAYS
								FROM HRM_WORK_IO_TIME_V WIT
							 WHERE WIT.SOB_ID               = W_SOB_ID
								 AND WIT.ORG_ID               = W_ORG_ID
							) ST1	 
      WHERE DL.DUTY_ID                = DC.DUTY_ID
			  AND DL.PERSON_ID              = T1.PERSON_ID
				AND DL.WORK_DATE              = PW1.WORK_DATE(+)
				AND DL.PERSON_ID              = PW1.PERSON_ID(+)
        AND DL.CORP_ID                = PW1.CORP_ID(+)
        AND DL.SOB_ID                 = PW1.SOB_ID(+)
        AND DL.ORG_ID                 = PW1.ORG_ID(+)
				AND DL.WORK_DATE              = NW1.WORK_DATE(+)
				AND DL.PERSON_ID              = NW1.PERSON_ID(+)
        AND DL.CORP_ID                = NW1.CORP_ID(+)
        AND DL.SOB_ID                 = NW1.SOB_ID(+)
        AND DL.ORG_ID                 = NW1.ORG_ID(+)
				AND DL.WORK_TYPE_GROUP        = ST1.WORK_TYPE(+)
				AND DL.HOLY_TYPE              = ST1.HOLY_TYPE(+)
        AND DL.WORK_DATE              = W_WORK_DATE
        AND DL.PERSON_ID              = NVL(W_PERSON_ID, DL.PERSON_ID)
        AND DL.WORK_CORP_ID           = W_CORP_ID
        AND DL.SOB_ID                 = W_SOB_ID
        AND DL.ORG_ID                 = W_ORG_ID
        AND DL.CLOSED_YN              = 'N'
        AND DL.HOLY_TYPE              = NVL(W_HOLY_TYPE, DL.HOLY_TYPE)
				AND DL.WORK_TYPE_ID           = NVL(W_WORK_TYPE_ID, DL.WORK_TYPE_ID)
        AND T1.FLOOR_ID               = NVL(W_FLOOR_ID, T1.FLOOR_ID)
        AND T1.DEPT_ID                = NVL(W_DEPT_ID, T1.DEPT_ID)
        AND T1.JOB_CATEGORY_ID        = NVL(W_JOB_CATEGORY_ID, T1.JOB_CATEGORY_ID)
				AND T1.ORI_JOIN_DATE          <= W_WORK_DATE
				AND (T1.RETIRE_DATE IS NULL OR T1.RETIRE_DATE >= W_WORK_DATE)
      ORDER BY DL.WORK_DATE, DL.HOLY_TYPE
			;
		
		V_DAY_COUNT                 NUMBER := 0;                          -- 계산총 일수.
    V_WORK_DATE                 HRD_DAY_LEAVE.WORK_DATE%TYPE;         -- 근무일자.
    
    V_LEAVE_TIME                HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 외출시간 적용.
		V_LATE_TIME                 HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 지각시간.
		V_REST_TIME                 HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 휴식연장.
		V_OVER_TIME                 HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 연장시간.
		V_HOLIDAY_TIME              HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 휴일근로.
    V_HOLIDAY_OT_TIME           HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 휴일연장근로.
		V_NIGHT_TIME                HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 야간근로.
		V_NIGHT_BONUS_TIME          HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 야간할증.
		V_HOLIDAY_CHECK             HRD_DAY_LEAVE.HOLIDAY_CHECK%TYPE;     -- 휴일근로여부.
		
		V_FOOD_DED_TIME             NUMBER := 0;                          -- 식사 공제시간.
		V_REST_DED_TIME             NUMBER := 0;                          -- 휴식시간 공제 시간.
				
		V_OPEN_TIME                 HRD_DAY_LEAVE.OPEN_TIME%TYPE;         -- 정리된 출근시간.
		V_CLOSE_TIME                HRD_DAY_LEAVE.CLOSE_TIME%TYPE;        -- 정리된 퇴근시간.
		V_OT_OPEN_TIME              HRD_DAY_LEAVE.OPEN_TIME%TYPE;         -- 30" 정리된 출근시간.
		V_OT_CLOSE_TIME             HRD_DAY_LEAVE.CLOSE_TIME%TYPE;        -- 30" 정리된 퇴근시간.
		
		V_OT_START_TIME             HRD_DAY_LEAVE.OPEN_TIME%TYPE;         -- 연장등 계산 시작 시간.
		V_OT_MID_TIME               HRD_DAY_LEAVE.OPEN_TIME%TYPE;         -- 연장등 계산 중간 시간.
		V_OT_END_TIME               HRD_DAY_LEAVE.CLOSE_TIME%TYPE;        -- 연장등 계산 종료 시간.
		
		V_PRE_HOLY_TYPE             HRD_DAY_LEAVE.HOLY_TYPE%TYPE := 'N';  -- 전일 근무/당직/철야 여부.
				
  BEGIN
    O_STATUS := 'F';
	  V_DAY_COUNT := (P_END_DATE - P_START_DATE) + 1;
    
		-- V_DAY_COUNT 만큼_일근태_계산.--
		FOR D1 IN 0 .. V_DAY_COUNT - 1
		LOOP 
		  V_WORK_DATE := P_START_DATE + D1;
			
			-- V_WORK_DATE에 대한 일근태_계산.--
		  FOR C1 IN C_WORKDATA ( P_CORP_ID						
														, V_WORK_DATE
														, P_WORK_TYPE_ID
														, P_HOLY_TYPE
														, P_DEPT_ID
														, P_FLOOR_ID
														, P_JOB_CATEGORY_ID
														, P_PERSON_ID
														, P_SOB_ID
														, P_ORG_ID
														)
			LOOP
			  -- 변수 초기화 --
        V_LEAVE_TIME                := 0;
				V_LATE_TIME                 := 0;
				V_REST_TIME                 := 0;
				V_OVER_TIME                 := 0;
				V_HOLIDAY_TIME              := 0;
        V_HOLIDAY_OT_TIME           := 0;
				V_NIGHT_TIME                := 0;
				V_NIGHT_BONUS_TIME          := 0;
				V_HOLIDAY_CHECK             := 'N';
			  
				V_FOOD_DED_TIME             := 0;
				V_REST_DED_TIME             := 0;
				
				V_OPEN_TIME                 := NULL;                 -- 30"단위 정리전 시간.
				V_CLOSE_TIME                := NULL;
				
				V_OT_OPEN_TIME              := NULL;                 -- 30" 단위 정리된 시간.
				V_OT_CLOSE_TIME             := NULL;
				
				V_OT_START_TIME             := NULL;
				V_OT_MID_TIME               := NULL;
				V_OT_END_TIME               := NULL;
				
				-- 계산 방법 정의 시작 --
				-- 1. DUTY_CONTROL_YN = 'Y' 값만 처리(공통코드 : 직위에 설정).
				-- 2. 관리직, 생산직으로 분리 계산하고, HOLY_TYPE에 따라 계산.
				-- 3. 연장계산 기준정보 설정값은 공통코드(HD312, HD313)에 설정.
				-- 계산 방법 정의 끝 --
				IF C1.DUTY_CONTROL_YN = 'N' THEN
				-- 일근태 계산 제외 --.
				  NULL;
				ELSE
				-- 일근태 계산 처리 --.				
-----------------------------------------------------------------------------------------
					-- 출/퇴근 정리 START --
					IF C1.OPEN_TIME IS NOT NULL AND C1.OPEN_TIME1 IS NOT NULL THEN
					-- 출근 중복 존재시 작은값 적용.
						IF C1.OPEN_TIME < C1.OPEN_TIME1 THEN
							V_OPEN_TIME := C1.OPEN_TIME;
						ELSE
							V_OPEN_TIME := C1.OPEN_TIME1;					
						END IF;
					ELSIF C1.OPEN_TIME IS NULL AND C1.OPEN_TIME1 IS NOT NULL THEN
					-- 중출에만 시간 존재시 중출값을 적용.
						V_OPEN_TIME := C1.OPEN_TIME1;
					ELSE
						V_OPEN_TIME := C1.OPEN_TIME;
					END IF;
-----------------------------------------------------------------------------------------					
					IF C1.CLOSE_TIME IS NOT NULL AND C1.CLOSE_TIME1 IS NOT NULL THEN
					-- 퇴근 중복 존재시 큰값 적용.
						IF C1.CLOSE_TIME < C1.CLOSE_TIME1 THEN
							V_CLOSE_TIME := C1.CLOSE_TIME1;
						ELSE
							V_CLOSE_TIME := C1.CLOSE_TIME;					
						END IF;
					ELSIF C1.CLOSE_TIME IS NULL AND C1.CLOSE_TIME1 IS NOT NULL THEN
					-- 중퇴에만 시간 존재시 중퇴값을 적용.
						V_CLOSE_TIME := C1.CLOSE_TIME1;
					ELSE
						V_CLOSE_TIME := C1.CLOSE_TIME;
					END IF;
-----------------------------------------------------------------------------------------	
          -- 퇴근시간이 출근시간보다 클 경우 퇴근시간 NULL 적용.
				  IF V_CLOSE_TIME < V_OPEN_TIME THEN
					  V_CLOSE_TIME := TO_DATE(NULL);
					END IF;
-----------------------------------------------------------------------------------------						
					-- 전일 야간, 당직, 철야로 인해 출근 없을 경우 강제로 출근시간 생성.
					IF V_OPEN_TIME IS NULL AND C1.DAY_LEAVE_CONTROL_YN = 'Y' THEN
					  IF (C1.PRE_HOLY_TYPE = '3' OR C1.PRE_DANGJIK_YN = 'Y' OR C1.PRE_ALL_NIGHT_YN = 'Y') THEN
							V_OPEN_TIME := C1.STD_OPEN_TIME;
						ELSE
							V_OPEN_TIME := C1.PL_OPEN_TIME;
						END IF;	
					END IF;
					-- 금일 야간, 당직, 철야로 인해 퇴근 없을 경우 강제로 퇴근시간 생성.
					IF V_CLOSE_TIME IS NULL AND C1.DAY_LEAVE_CONTROL_YN = 'Y' THEN
					  IF (C1.HOLY_TYPE = '3' OR C1.DANGJIK_YN = 'Y' OR C1.ALL_NIGHT_YN = 'Y') AND 
						   (C1.NEXT_DANGJIK_YN = 'Y' OR C1.NEXT_ALL_NIGHT_YN = 'Y' ) THEN
							V_CLOSE_TIME := C1.NEXT_STD_OPEN_TIME;
						ELSE
							V_CLOSE_TIME := C1.PL_CLOSE_TIME;
						END IF;	
					END IF;
-----------------------------------------------------------------------------------------
          IF C1.PRE_HOLY_TYPE = '3' OR C1.PRE_DANGJIK_YN = 'Y' OR C1.ALL_NIGHT_YN = 'Y' THEN
					  V_PRE_HOLY_TYPE := 'Y';
					ELSE
					  V_PRE_HOLY_TYPE := 'N';
					END IF;
/*DBMS_OUTPUT.PUT_LINE('1성명 : ' || C1.NAME || '(' || C1.PERSON_ID || ')' ||
                     ', 실제O =>' || TO_CHAR(C1.OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', 실제C =>' || TO_CHAR(C1.CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
                     ', 정리O=>' || TO_CHAR(V_OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', 정리C=>' || TO_CHAR(V_CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS'));         */ 
-----------------------------------------------------------------------------------------					
					-- 출퇴근 시간 정리.
					V_OT_OPEN_TIME := OPEN_TIME_F( P_JOB_CATEGORY_CODE => C1.JOB_CATEGORY_CODE
																				, P_HOLY_TYPE => C1.HOLY_TYPE
																				, P_OPEN_TIME => V_OPEN_TIME
																				);
					V_OT_CLOSE_TIME := CLOSE_TIME_F( P_JOB_CATEGORY_CODE => C1.JOB_CATEGORY_CODE
																					, P_HOLY_TYPE => C1.HOLY_TYPE
																					, P_CLOSE_TIME => V_CLOSE_TIME
																					);
/*DBMS_OUTPUT.PUT_LINE('2성명 : ' || C1.NAME || '(' || C1.PERSON_ID || ')' ||
                     ', 실제O =>' || TO_CHAR(C1.OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', 실제C =>' || TO_CHAR(C1.CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 \*', 실제DO =>' || TO_CHAR(C1.OPEN_TIME1, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', 실제DC =>' || TO_CHAR(C1.CLOSE_TIME1, 'YYYY-MM-DD HH24:MI:SS') ||*\
                     ', 정리O=>' || TO_CHAR(V_OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', 정리C=>' || TO_CHAR(V_CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 ', 30"O=>' || TO_CHAR(V_OT_OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', 30"C=>' || TO_CHAR(V_OT_CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
-----------------------------------------------------------------------------------------
          -- 0. 외출시간 적용 --> 출퇴근 수정에서 적용.
          V_LEAVE_TIME := LEAVE_TIME_F( W_WORK_DATE => V_WORK_DATE
                                      , W_CORP_ID => C1.CORP_ID
                                      , W_PERSON_ID => C1.PERSON_ID
                                      , W_JOB_CATEGORY_CODE => C1.JOB_CATEGORY_CODE
                                      , W_HOLY_TYPE => C1.HOLY_TYPE
                                      , W_SOB_ID => C1.SOB_ID
                                      , W_ORG_ID => C1.ORG_ID
                                      );
					-- 1. 지각/조퇴 시간 계산.
					V_LATE_TIME := LATE_TIME_F( W_WORK_DATE => V_WORK_DATE
																		, W_DUTY_ID => C1.DUTY_ID
																		, W_HOLY_TYPE => C1.HOLY_TYPE
																		, W_PRE_HOLY_TYPE => V_PRE_HOLY_TYPE
                                    , W_PRE_DANGJIK_YN => C1.PRE_DANGJIK_YN
                                    , W_PRE_ALL_NIGHT_YN => C1.PRE_ALL_NIGHT_YN
																		, W_OPEN_TIME => V_OT_OPEN_TIME
																		, W_CLOSE_TIME => V_OT_CLOSE_TIME
																		, W_PL_OPEN_TIME => C1.PL_OPEN_TIME
																		, W_PL_CLOSE_TIME => C1.PL_CLOSE_TIME
																		, W_JOB_CATEGORY_CODE => C1.JOB_CATEGORY_CODE
																		, W_SOB_ID => C1.SOB_ID
																		, W_ORG_ID => C1.ORG_ID
																		);
          -- 2. 휴식연장 시간 계산.
					V_REST_TIME := REST_TIME_F( W_WORK_DATE => V_WORK_DATE
					                          , W_DUTY_ID => C1.DUTY_ID
																		, W_NEXT_WORKING_YN => CASE
                                                             WHEN C1.HOLY_TYPE = '3' THEN 'Y'
                                                             WHEN C1.DANGJIK_YN = 'Y' THEN 'Y'
                                                             WHEN C1.ALL_NIGHT_YN = 'Y' THEN 'Y'
                                                             ELSE 'N'
                                                           END
																		, W_PRE_HOLY_TYPE => V_PRE_HOLY_TYPE
																		, W_OPEN_TIME => V_OPEN_TIME
																		, W_CLOSE_TIME => V_CLOSE_TIME
                                    , W_BREAKFAST_YN => C1.PL_BREAKFAST_YN
																		, W_LUNCH_YN => C1.PL_LUNCH_YN
																		, W_DINNER_YN => C1.PL_DINNER_YN
																		, W_MIDNIGHT_YN => C1.PL_MIDNIGHT_YN
																		, W_JOB_CATEGORY_CODE => C1.JOB_CATEGORY_CODE
																		, W_SOB_ID => C1.SOB_ID
																		, W_ORG_ID => C1.ORG_ID
																		);
					-- 3. 연장/야간근로/야간할증/휴일근로 시간 계산.
					OVER_TIME_P ( W_WORK_DATE => V_WORK_DATE
					            , W_DUTY_ID => C1.DUTY_ID
											, W_HOLY_TYPE => C1.HOLY_TYPE
											, W_PRE_HOLY_TYPE => V_PRE_HOLY_TYPE
                      , W_NEXT_HOLY_TYPE => C1.NEXT_HOLY_TYPE
											, W_DANGJIK_YN => C1.DANGJIK_YN
											, W_ALL_NIGHT_YN => C1.ALL_NIGHT_YN
											, W_OPEN_TIME => V_OT_OPEN_TIME
											, W_CLOSE_TIME => V_OT_CLOSE_TIME
											, W_PL_OPEN_TIME => C1.PL_OPEN_TIME
											, W_PL_CLOSE_TIME => C1.PL_CLOSE_TIME
											, W_BEFORE_OT_START => C1.PL_BEFORE_OT_START
											, W_BEFORE_OT_END => C1.PL_BEFORE_OT_END
											, W_AFTER_OT_START => V_OT_OPEN_TIME --C1.PL_AFTER_OT_START
											, W_AFTER_OT_END => V_OT_CLOSE_TIME --C1.PL_AFTER_OT_END
											, W_JOB_CATEGORY_CODE => C1.JOB_CATEGORY_CODE
											, W_SOB_ID => C1.SOB_ID
											, W_ORG_ID => C1.ORG_ID
											, O_OVER_TIME => V_OVER_TIME
											, O_HOLIDAY_TIME => V_HOLIDAY_TIME
                      , O_HOLIDAY_OT_TIME => V_HOLIDAY_OT_TIME
											, O_NIGHT_TIME => V_NIGHT_TIME
											, O_NIGHT_BONUS_TIME => V_NIGHT_BONUS_TIME
											);
					-- 4. 휴일근무 체크.
					IF C1.HOLY_TYPE IN ('0', '1') AND V_HOLIDAY_TIME > 0 THEN
					  V_HOLIDAY_CHECK := 'Y';
					END IF;
        END IF;
        
			  -- 계산 결과 UPDATE --
				UPDATE HRD_DAY_LEAVE DL
				   SET DL.HOLIDAY_CHECK     = V_HOLIDAY_CHECK
						 , DL.LAST_UPDATE_DATE  = GET_LOCAL_DATE(DL.SOB_ID)
						 , DL.LAST_UPDATED_BY   = P_USER_ID
		    WHERE DL.DAY_LEAVE_ID       = C1.DAY_LEAVE_ID
				;
        
        -- 잔업 사항 저장. --
        -- LEAVE_TIME.
        DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => C1.DAY_LEAVE_ID
                          , P_OT_TYPE => C_LEAVE_TIME      -- '11'
                          , P_OT_TIME => V_LEAVE_TIME
                          , P_PERSON_ID => C1.PERSON_ID
                          , P_WORK_DATE => C1.WORK_DATE
                          , P_CORP_ID => C1.CORP_ID
                          , P_SOB_ID => C1.SOB_ID
                          , P_ORG_ID => C1.ORG_ID
                          , P_USER_ID => P_USER_ID
                          );                          
        -- LATE_TIME.
        DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => C1.DAY_LEAVE_ID
                          , P_OT_TYPE => C_LATE_TIME       -- '12'
                          , P_OT_TIME => V_LATE_TIME
                          , P_PERSON_ID => C1.PERSON_ID
                          , P_WORK_DATE => C1.WORK_DATE
                          , P_CORP_ID => C1.CORP_ID
                          , P_SOB_ID => C1.SOB_ID
                          , P_ORG_ID => C1.ORG_ID
                          , P_USER_ID => P_USER_ID
                          );
        -- REST_TIME.
        DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => C1.DAY_LEAVE_ID
                          , P_OT_TYPE => C_REST_TIME       -- '13'
                          , P_OT_TIME => V_REST_TIME
                          , P_PERSON_ID => C1.PERSON_ID
                          , P_WORK_DATE => C1.WORK_DATE
                          , P_CORP_ID => C1.CORP_ID
                          , P_SOB_ID => C1.SOB_ID
                          , P_ORG_ID => C1.ORG_ID
                          , P_USER_ID => P_USER_ID
                          );   
        -- OVER_TIME.
        DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => C1.DAY_LEAVE_ID
                          , P_OT_TYPE => C_OVER_TIME       --'14'
                          , P_OT_TIME => V_OVER_TIME
                          , P_PERSON_ID => C1.PERSON_ID
                          , P_WORK_DATE => C1.WORK_DATE
                          , P_CORP_ID => C1.CORP_ID
                          , P_SOB_ID => C1.SOB_ID
                          , P_ORG_ID => C1.ORG_ID
                          , P_USER_ID => P_USER_ID
                          );   
        -- HOLIDAY_TIME.
        DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => C1.DAY_LEAVE_ID
                          , P_OT_TYPE => C_HOLIDAY_TIME    --'15'
                          , P_OT_TIME => V_HOLIDAY_TIME
                          , P_PERSON_ID => C1.PERSON_ID
                          , P_WORK_DATE => C1.WORK_DATE
                          , P_CORP_ID => C1.CORP_ID
                          , P_SOB_ID => C1.SOB_ID
                          , P_ORG_ID => C1.ORG_ID
                          , P_USER_ID => P_USER_ID
                          );   
        -- HOLIDAY_OT_TIME.
        DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => C1.DAY_LEAVE_ID
                          , P_OT_TYPE => C_HOLIDAY_OT    --'18'
                          , P_OT_TIME => V_HOLIDAY_OT_TIME
                          , P_PERSON_ID => C1.PERSON_ID
                          , P_WORK_DATE => C1.WORK_DATE
                          , P_CORP_ID => C1.CORP_ID
                          , P_SOB_ID => C1.SOB_ID
                          , P_ORG_ID => C1.ORG_ID
                          , P_USER_ID => P_USER_ID
                          );
        -- NIGHT_TIME.
        DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => C1.DAY_LEAVE_ID
                          , P_OT_TYPE => C_NIGHT_TIME      -- '16'
                          , P_OT_TIME => V_NIGHT_TIME
                          , P_PERSON_ID => C1.PERSON_ID
                          , P_WORK_DATE => C1.WORK_DATE
                          , P_CORP_ID => C1.CORP_ID
                          , P_SOB_ID => C1.SOB_ID
                          , P_ORG_ID => C1.ORG_ID
                          , P_USER_ID => P_USER_ID
                          );
        -- NIGHT_BONUS_TIME.
        DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => C1.DAY_LEAVE_ID
                          , P_OT_TYPE => C_NIGHT_BONUS_TIME   -- '17'
                          , P_OT_TIME => V_NIGHT_BONUS_TIME
                          , P_PERSON_ID => C1.PERSON_ID
                          , P_WORK_DATE => C1.WORK_DATE
                          , P_CORP_ID => C1.CORP_ID
                          , P_SOB_ID => C1.SOB_ID
                          , P_ORG_ID => C1.ORG_ID
                          , P_USER_ID => P_USER_ID
                          );
				  
		  END LOOP C1;
		END LOOP D1;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10058', NULL);
    RETURN;
  END WORKDATA_GO_1;


/*============================================================================================/
  --  외출, 지각/조퇴, 휴식연장, 연장, 휴일근로, 야간근로, 야간할증, 휴일근무 계산 시작.
/============================================================================================*/
-- 외출시간 계산 function;
  FUNCTION LEAVE_TIME_F
	          ( W_WORK_DATE                         IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , W_JOB_CATEGORY_CODE                 IN VARCHAR2
            , W_HOLY_TYPE                         IN VARCHAR2
            , W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
					 ) RETURN NUMBER
  AS
    V_LEAVE_TIME                                  HRD_DAY_LEAVE_OT.OT_TIME%TYPE := 0;    -- 외출시간.
    
    V_FOOD_DED_TIME                               NUMBER := 0;  -- 식사시간 제외.
    V_OPEN_TIME                                   DATE;  -- 외출 시작시간.
    V_CLOSE_TIME                                  DATE;  -- 외출 종료시간.
	BEGIN
    -- 근태계에서 신청/승인할 경우 적용. 고정근태 조회(외출신청여부).
    BEGIN
      SELECT MIN(DP.START_DATE) AS START_DATE, MAX(DP.END_DATE) AS END_DATE
        INTO V_OPEN_TIME, V_CLOSE_TIME
        FROM HRD_DUTY_PERIOD    DP
          , HRM_DUTY_CODE_V    DC
      WHERE DP.DUTY_ID            = DC.DUTY_ID
        AND DP.SOB_ID             = DC.SOB_ID
        AND DP.ORG_ID             = DC.ORG_ID
        AND DP.WORK_START_DATE    <= W_WORK_DATE
        AND DP.WORK_END_DATE      >= W_WORK_DATE
        AND DP.PERSON_ID          = W_PERSON_ID
        AND DP.SOB_ID             = W_SOB_ID
        AND DP.ORG_ID             = W_ORG_ID
        AND DC.DUTY_CODE          = '101'  -- 외출 근태코드.
        AND DP.APPROVE_STATUS     = 'C'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_OPEN_TIME := NULL;
      V_CLOSE_TIME := NULL;
    END;
    -- 생산직에 한해서 적용.
    IF W_JOB_CATEGORY_CODE IN('20') AND V_OPEN_TIME IS NOT NULL AND V_CLOSE_TIME IS NOT NULL THEN
      V_OPEN_TIME := OPEN_TIME_F(W_JOB_CATEGORY_CODE, W_HOLY_TYPE, V_OPEN_TIME);
      V_CLOSE_TIME := CLOSE_TIME_F(W_JOB_CATEGORY_CODE, W_HOLY_TYPE, V_CLOSE_TIME);
      
      --> 식사시간 제외 <--
      V_FOOD_DED_TIME := 0;
      V_FOOD_DED_TIME := FOOD_DED_TIME_F
                          ( W_WORK_DATE => W_WORK_DATE
                          , W_FOOD_TYPE => '2'
                          , W_START_TIME => V_OPEN_TIME
                          , W_END_TIME => V_CLOSE_TIME
                          , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
                          , W_SOB_ID => W_SOB_ID
                          , W_ORG_ID => W_ORG_ID
                          );
      V_FOOD_DED_TIME := V_FOOD_DED_TIME +
                         FOOD_DED_TIME_F
                          ( W_WORK_DATE => W_WORK_DATE
                          , W_FOOD_TYPE => '3'
                          , W_START_TIME => V_OPEN_TIME
                          , W_END_TIME => V_CLOSE_TIME
                          , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
                          , W_SOB_ID => W_SOB_ID
                          , W_ORG_ID => W_ORG_ID
                          );
      V_FOOD_DED_TIME := V_FOOD_DED_TIME +
                         FOOD_DED_TIME_F
                          ( W_WORK_DATE => W_WORK_DATE
                          , W_FOOD_TYPE => '4'
                          , W_START_TIME => V_OPEN_TIME
                          , W_END_TIME => V_CLOSE_TIME
                          , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
                          , W_SOB_ID => W_SOB_ID
                          , W_ORG_ID => W_ORG_ID
                          );
      V_LEAVE_TIME := ROUND((V_CLOSE_TIME - V_OPEN_TIME) * 24, 2) - V_FOOD_DED_TIME;
    END IF;
    
    /*-- 출퇴근조회에서 수정할 경우 적용.
	  SELECT HRM_COMMON_G.CODE_NAME_F('LEAVE_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
      INTO V_LEAVE_TIME
    FROM HRD_DAY_INTERFACE DI
    WHERE DI.WORK_DATE                        = W_WORK_DATE
      AND DI.PERSON_ID                        = W_PERSON_ID
      AND DI.WORK_CORP_ID                     = W_CORP_ID
      AND DI.SOB_ID                           = W_SOB_ID
      AND DI.ORG_ID                           = W_ORG_ID
    ;*/
	  RETURN V_LEAVE_TIME;
	EXCEPTION WHEN OTHERS THEN
	  DBMS_OUTPUT.PUT_LINE('LEAVE_TIME_ERROR =>' || SQLERRM);
		RETURN V_LEAVE_TIME;
	END LEAVE_TIME_F;

/*============================================================================================/
  --  지각/조퇴, 휴식연장, 연장, 휴일근로, 야간근로, 야간할증, 휴일근무 계산 시작.
/============================================================================================*/
/*
-- 지각/조퇴 계산 function;
  FUNCTION LATE_TIME_F
	         ( W_WORK_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
					 , W_DUTY_ID                            IN HRD_DAY_LEAVE.DUTY_ID%TYPE
           , W_HOLY_TYPE                          IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
					 , W_PRE_HOLY_TYPE                      IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
					 , W_OPEN_TIME                          IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
					 , W_CLOSE_TIME                         IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
					 , W_PL_OPEN_TIME                       IN HRD_WORK_CALENDAR.OPEN_TIME%TYPE
					 , W_PL_CLOSE_TIME                      IN HRD_WORK_CALENDAR.CLOSE_TIME%TYPE
					 , W_JOB_CATEGORY_CODE                  IN HRM_COMMON.CODE%TYPE
					 , W_SOB_ID                             IN HRD_DAY_LEAVE.SOB_ID%TYPE
					 , W_ORG_ID                             IN HRD_DAY_LEAVE.ORG_ID%TYPE
					 ) RETURN NUMBER
  AS
    V_LATE_TIME                                   HRD_DAY_LEAVE_OT.OT_TIME%TYPE := 0;    -- 지각 시간.
		V_EARLY_TIME                                  HRD_DAY_LEAVE_OT.OT_TIME%TYPE := 0;    -- 조퇴 시간.
		V_FOOD_DED_TIME                               NUMBER := 0;

		V_OPEN_TIME                                   HRD_DAY_LEAVE.WORK_DATE%TYPE;         -- 정리된 출근시간.
		V_CLOSE_TIME                                  HRD_DAY_LEAVE.WORK_DATE%TYPE;         -- 정리된 퇴근시간.

	BEGIN
	  V_OPEN_TIME := W_OPEN_TIME;
		V_CLOSE_TIME := W_CLOSE_TIME;

--DBMS_OUTPUT.PUT_LINE('근무일자 : ' || TO_CHAR(W_WORK_DATE, 'YYYY-MM-DD') ||
--                     ', 근무 =>' || W_HOLY_TYPE ||
--                     ', 출근 =>' || TO_CHAR(W_OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
--										 ', 퇴근 =>' || TO_CHAR(W_CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
--                     ', 계획출근 =>' || TO_CHAR(W_PL_OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
--                     ', 계획퇴근=>' || TO_CHAR(W_PL_CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
--										 ', 직구분=>' || W_JOB_CATEGORY_CODE);

-----------------------------------------------------------------------------------------
	  -- 주간 근무 계산 --
		IF W_HOLY_TYPE = '2' THEN
		  -- 지각 --
			V_LATE_TIME := 0;
			IF V_OPEN_TIME IS NULL THEN
				V_LATE_TIME := 0;
			ELSIF W_PL_OPEN_TIME < V_OPEN_TIME THEN
			-- 계획 출근보다 실제 출근이 늦을 경우.
				--> 식사시간 제외 <--
				V_FOOD_DED_TIME := 0;
				V_FOOD_DED_TIME := FOOD_DED_TIME_F( W_WORK_DATE => W_WORK_DATE
																					 , W_FOOD_TYPE => '2'
																					 , W_START_TIME => W_PL_OPEN_TIME
																					 , W_END_TIME => V_OPEN_TIME
																					 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																					 , W_SOB_ID => W_SOB_ID
																					 , W_ORG_ID => W_ORG_ID
																					 );
        BEGIN
			    V_LATE_TIME := ROUND((V_OPEN_TIME - W_PL_OPEN_TIME) * 24, 2) - V_FOOD_DED_TIME;
				EXCEPTION WHEN OTHERS THEN
				  V_LATE_TIME := 0;
					DBMS_OUTPUT.PUT_LINE('HolyType(2)_Late_Error : ' || SQLERRM);
				END;
			END IF;

			-- 조퇴 --
			V_EARLY_TIME := 0;
			IF V_CLOSE_TIME IS NULL THEN
				V_EARLY_TIME := 0;
			ELSIF V_CLOSE_TIME < W_PL_CLOSE_TIME THEN
			-- 계획 출근보다 실제 출근이 늦을 경우.
				--> 식사시간 제외 <--
				V_FOOD_DED_TIME := 0;
				V_FOOD_DED_TIME := FOOD_DED_TIME_F( W_WORK_DATE => W_WORK_DATE
																					 , W_FOOD_TYPE => '2'
																					 , W_START_TIME => V_CLOSE_TIME
																					 , W_END_TIME => W_PL_CLOSE_TIME
																					 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																					 , W_SOB_ID => W_SOB_ID
																					 , W_ORG_ID => W_ORG_ID
																					 );
        BEGIN
			    V_EARLY_TIME := ROUND((W_PL_CLOSE_TIME - V_CLOSE_TIME) * 24, 2) - V_FOOD_DED_TIME;
				EXCEPTION WHEN OTHERS THEN
				  V_EARLY_TIME := 0;
					DBMS_OUTPUT.PUT_LINE('HolyType(2)_Early_Error : ' || SQLERRM);
				END;
			END IF;

-----------------------------------------------------------------------------------------
		-- 야간 근무 계산 --
		ELSIF W_HOLY_TYPE = '3' THEN
			-- 지각 --
			V_LATE_TIME := 0;
			IF V_OPEN_TIME IS NULL THEN
				V_LATE_TIME := 0;
			ELSIF W_PL_OPEN_TIME < V_OPEN_TIME THEN
			-- 계획 출근보다 실제 출근이 늦을 경우.
				--> 식사시간 제외 <--
				V_FOOD_DED_TIME := 0;
				V_FOOD_DED_TIME := FOOD_DED_TIME_F( W_WORK_DATE => W_WORK_DATE
																					 , W_FOOD_TYPE => '4'
																					 , W_START_TIME => W_PL_OPEN_TIME
																					 , W_END_TIME => V_OPEN_TIME
																					 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																					 , W_SOB_ID => W_SOB_ID
																					 , W_ORG_ID => W_ORG_ID
																					 );
        BEGIN
			    V_LATE_TIME := ROUND((V_OPEN_TIME - W_PL_OPEN_TIME) * 24, 2) - V_FOOD_DED_TIME;
				EXCEPTION WHEN OTHERS THEN
				  V_LATE_TIME := 0;
					DBMS_OUTPUT.PUT_LINE('HolyType(2)_Late_Error : ' || SQLERRM);
				END;
			END IF;

			-- 조퇴 --
			V_EARLY_TIME := 0;
			IF V_CLOSE_TIME IS NULL THEN
				V_EARLY_TIME := 0;
			ELSIF V_CLOSE_TIME < W_PL_CLOSE_TIME THEN
			-- 계획 출근보다 실제 출근이 늦을 경우.
				--> 식사시간 제외 <--
				V_FOOD_DED_TIME := 0;
				V_FOOD_DED_TIME := FOOD_DED_TIME_F( W_WORK_DATE => W_WORK_DATE
																					 , W_FOOD_TYPE => '4'
																					 , W_START_TIME => V_CLOSE_TIME
																					 , W_END_TIME => W_PL_CLOSE_TIME
																					 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																					 , W_SOB_ID => W_SOB_ID
																					 , W_ORG_ID => W_ORG_ID
																					 );
        BEGIN
			    V_EARLY_TIME := ROUND((W_PL_CLOSE_TIME - V_CLOSE_TIME) * 24, 2) - V_FOOD_DED_TIME;
				EXCEPTION WHEN OTHERS THEN
				  V_EARLY_TIME := 0;
					DBMS_OUTPUT.PUT_LINE('HolyType(2)_Early_Error : ' || SQLERRM);
				END;
			END IF;
		END IF;
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
		IF V_LATE_TIME < 0 THEN
		  V_LATE_TIME := 0;
		END IF;
		IF V_EARLY_TIME < 0 THEN
		  V_EARLY_TIME := 0;
		END IF;

		V_LATE_TIME := V_LATE_TIME + V_EARLY_TIME;
	  RETURN V_LATE_TIME;

	EXCEPTION WHEN OTHERS THEN
	  DBMS_OUTPUT.PUT_LINE('LATE_TIME_ERROR =>' || SQLERRM);
		RETURN V_LATE_TIME;
	END LATE_TIME_F;
*/


-- 지각/조퇴 계산 function;
  FUNCTION LATE_TIME_F
          ( W_WORK_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
          , W_DUTY_ID                            IN HRD_DAY_LEAVE.DUTY_ID%TYPE
          , W_HOLY_TYPE                          IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
          , W_PRE_HOLY_TYPE                      IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
          , W_PRE_DANGJIK_YN                     IN HRD_DAY_LEAVE.DANGJIK_YN%TYPE
          , W_PRE_ALL_NIGHT_YN                   IN HRD_DAY_LEAVE.ALL_NIGHT_YN%TYPE
          , W_OPEN_TIME                          IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
          , W_CLOSE_TIME                         IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
          , W_PL_OPEN_TIME                       IN HRD_WORK_CALENDAR.OPEN_TIME%TYPE
          , W_PL_CLOSE_TIME                      IN HRD_WORK_CALENDAR.CLOSE_TIME%TYPE
          , W_JOB_CATEGORY_CODE                  IN HRM_COMMON.CODE%TYPE
          , W_SOB_ID                             IN HRD_DAY_LEAVE.SOB_ID%TYPE
          , W_ORG_ID                             IN HRD_DAY_LEAVE.ORG_ID%TYPE
          ) RETURN NUMBER
  AS
    V_LATE_TIME                                   HRD_DAY_LEAVE_OT.OT_TIME%TYPE := 0;    -- 지각 시간.
    V_EARLY_TIME                                  HRD_DAY_LEAVE_OT.OT_TIME%TYPE := 0;    -- 조퇴 시간.
    V_FOOD_DED_TIME                               NUMBER := 0;

    V_OPEN_TIME                                   HRD_DAY_LEAVE.WORK_DATE%TYPE;         -- 정리된 출근시간.
    V_CLOSE_TIME                                  HRD_DAY_LEAVE.WORK_DATE%TYPE;         -- 정리된 퇴근시간.

 BEGIN
   V_OPEN_TIME := W_OPEN_TIME;
   IF V_OPEN_TIME < W_PL_OPEN_TIME THEN
     V_OPEN_TIME := W_PL_OPEN_TIME;
   END IF;
   V_CLOSE_TIME := W_CLOSE_TIME;
   IF W_PL_CLOSE_TIME < V_CLOSE_TIME THEN
     V_CLOSE_TIME := W_PL_CLOSE_TIME;
   END IF;
   IF V_CLOSE_TIME < V_OPEN_TIME THEN
     V_CLOSE_TIME := V_OPEN_TIME;
   END IF;
/*DBMS_OUTPUT.PUT_LINE('근무일자 : ' || TO_CHAR(W_WORK_DATE, 'YYYY-MM-DD') ||
                     ', 근무 =>' || W_HOLY_TYPE ||
                     ', 출근 =>' || TO_CHAR(W_OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
                     ', 퇴근 =>' || TO_CHAR(W_CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
                     ', 계획출근 =>' || TO_CHAR(W_PL_OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
                     ', 계획퇴근=>' || TO_CHAR(W_PL_CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
                     ', 직구분=>' || W_JOB_CATEGORY_CODE);*/

-----------------------------------------------------------------------------------------
   -- 주간 근무 계산 --
    IF W_HOLY_TYPE = '2' THEN
    -- 지각 --
      V_LATE_TIME := 0;
      IF V_OPEN_TIME IS NULL THEN
        V_LATE_TIME := 0;
      ELSIF W_PL_OPEN_TIME < V_OPEN_TIME THEN
      -- 계획 출근보다 실제 출근이 늦을 경우.
        --> 식사시간 제외 <--
        V_FOOD_DED_TIME := 0;
        V_FOOD_DED_TIME := FOOD_DED_TIME_F( W_WORK_DATE => W_WORK_DATE
                          , W_FOOD_TYPE => '2'
                          , W_START_TIME => W_PL_OPEN_TIME
                          , W_END_TIME => V_OPEN_TIME
                          , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
                          , W_SOB_ID => W_SOB_ID
                          , W_ORG_ID => W_ORG_ID
                          );
          BEGIN
            V_LATE_TIME := ROUND((V_OPEN_TIME - W_PL_OPEN_TIME) * 24, 2) - V_FOOD_DED_TIME;
          EXCEPTION WHEN OTHERS THEN
            V_LATE_TIME := 0;
           DBMS_OUTPUT.PUT_LINE('HolyType(2)_Late_Error : ' || SQLERRM);
          END;
      END IF;

      -- 조퇴 --
      V_EARLY_TIME := 0;
      IF V_CLOSE_TIME IS NULL THEN
        V_EARLY_TIME := 0;
      ELSIF V_CLOSE_TIME < W_PL_CLOSE_TIME THEN
      -- 계획 출근보다 실제 출근이 늦을 경우.
        --> 식사시간 제외 <--
        V_FOOD_DED_TIME := 0;
        V_FOOD_DED_TIME := FOOD_DED_TIME_F( W_WORK_DATE => W_WORK_DATE
                      , W_FOOD_TYPE => '2'
                      , W_START_TIME => V_CLOSE_TIME
                      , W_END_TIME => W_PL_CLOSE_TIME
                      , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
                      , W_SOB_ID => W_SOB_ID
                      , W_ORG_ID => W_ORG_ID
                      );
        BEGIN
          V_EARLY_TIME := ROUND((W_PL_CLOSE_TIME - V_CLOSE_TIME) * 24, 2) - V_FOOD_DED_TIME;
        EXCEPTION WHEN OTHERS THEN
          V_EARLY_TIME := 0;
          DBMS_OUTPUT.PUT_LINE('HolyType(2)_Early_Error : ' || SQLERRM);
        END;
      END IF;
      
      IF W_PRE_HOLY_TYPE IN('1', '0') AND (NVL(W_PRE_DANGJIK_YN, 'N') = 'Y' OR NVL(W_PRE_ALL_NIGHT_YN, 'N') = 'Y') THEN
        V_LATE_TIME := 0;
        V_EARLY_TIME := 0;
      END IF;

-----------------------------------------------------------------------------------------
    -- 야간 근무 계산 --
    ELSIF W_HOLY_TYPE = '3' THEN
    -- 지각 --
      V_LATE_TIME := 0;
      IF V_OPEN_TIME IS NULL THEN
        V_LATE_TIME := 0;
      ELSIF W_PL_OPEN_TIME < V_OPEN_TIME THEN
      -- 계획 출근보다 실제 출근이 늦을 경우.
        --> 식사시간 제외 <--
        V_FOOD_DED_TIME := 0;
        V_FOOD_DED_TIME := FOOD_DED_TIME_F( W_WORK_DATE => W_WORK_DATE
                          , W_FOOD_TYPE => '4'
                          , W_START_TIME => W_PL_OPEN_TIME
                          , W_END_TIME => V_OPEN_TIME
                          , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
                          , W_SOB_ID => W_SOB_ID
                          , W_ORG_ID => W_ORG_ID
                          );
        BEGIN
          V_LATE_TIME := ROUND((V_OPEN_TIME - W_PL_OPEN_TIME) * 24, 2) - V_FOOD_DED_TIME;
        EXCEPTION WHEN OTHERS THEN
          V_LATE_TIME := 0;
          DBMS_OUTPUT.PUT_LINE('HolyType(2)_Late_Error : ' || SQLERRM);
        END;
      END IF;

      -- 조퇴 --
      V_EARLY_TIME := 0;
      IF V_CLOSE_TIME IS NULL THEN
        V_EARLY_TIME := 0;
      ELSIF V_CLOSE_TIME < W_PL_CLOSE_TIME THEN
      -- 계획 출근보다 실제 출근이 늦을 경우.
        --> 식사시간 제외 <--
        V_FOOD_DED_TIME := 0;
        V_FOOD_DED_TIME := FOOD_DED_TIME_F( W_WORK_DATE => W_WORK_DATE
                          , W_FOOD_TYPE => '4'
                          , W_START_TIME => V_CLOSE_TIME
                          , W_END_TIME => W_PL_CLOSE_TIME
                          , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
                          , W_SOB_ID => W_SOB_ID
                          , W_ORG_ID => W_ORG_ID
                          );
        BEGIN
          V_EARLY_TIME := ROUND((W_PL_CLOSE_TIME - V_CLOSE_TIME) * 24, 2) - V_FOOD_DED_TIME;
        EXCEPTION WHEN OTHERS THEN
          V_EARLY_TIME := 0;
          DBMS_OUTPUT.PUT_LINE('HolyType(2)_Early_Error : ' || SQLERRM);
        END;
      END IF;
    END IF;
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
  IF V_LATE_TIME < 0 THEN
    V_LATE_TIME := 0;
  END IF;
  IF V_EARLY_TIME < 0 THEN
    V_EARLY_TIME := 0;
  END IF;

  V_LATE_TIME := V_LATE_TIME + V_EARLY_TIME;
   RETURN V_LATE_TIME;

 EXCEPTION WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('LATE_TIME_ERROR =>' || SQLERRM);
  RETURN V_LATE_TIME;
 END LATE_TIME_F;


-- 휴식연장 계산 function(참고-출퇴근 시간은 정리전 출퇴근 시간이 와야 함);
  FUNCTION REST_TIME_F
	         ( W_WORK_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
					 , W_DUTY_ID                            IN HRD_DAY_LEAVE.DUTY_ID%TYPE
           , W_NEXT_WORKING_YN                    IN VARCHAR2
					 , W_PRE_HOLY_TYPE                      IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
					 , W_OPEN_TIME                          IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
					 , W_CLOSE_TIME                         IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
           , W_BREAKFAST_YN                       IN HRD_WORK_CALENDAR.BREAKFAST_YN%TYPE
					 , W_LUNCH_YN                           IN HRD_WORK_CALENDAR.LUNCH_YN%TYPE
					 , W_DINNER_YN                          IN HRD_WORK_CALENDAR.DINNER_YN%TYPE
					 , W_MIDNIGHT_YN                        IN HRD_WORK_CALENDAR.MIDNIGHT_YN%TYPE
					 , W_JOB_CATEGORY_CODE                  IN HRM_COMMON.CODE%TYPE
					 , W_SOB_ID                             IN HRD_DAY_LEAVE.SOB_ID%TYPE
					 , W_ORG_ID                             IN HRD_DAY_LEAVE.ORG_ID%TYPE
					 ) RETURN NUMBER
  AS
	  CURSOR C_REST_TIME
		IS
		SELECT LCS.JOB_CATEGORY_CODE
				 , LCS.OT_YN
				 , LCS.NIGHT_YN
				 , LCS.REST_TIME_YN
				 , LCS.HOLIDAY_YN
				 , LCS.NIGHT_BONUS_YN
				 , LCS.FOOD_TIME_DED
				 , LCS.REST_TIME_DED
				 , R1.REST_OT_TIME_NAME
				 , NVL(R1.REST_OT_TYPE, '0') AS REST_OT_TYPE
				 , TO_DATE(TO_CHAR(W_WORK_DATE + NVL(R1.START_ADD_DAY, 0), 'YYYY-MM-DD') || ' ' || NVL(R1.START_TIME, '00:00'), 'YYYY-MM-DD HH24:MI:SS') AS START_TIME
				 , TO_DATE(TO_CHAR(W_WORK_DATE + NVL(R1.END_ADD_DAY, 0), 'YYYY-MM-DD') || ' ' || NVL(R1.END_TIME, '00:00'), 'YYYY-MM-DD HH24:MI:SS') AS END_TIME
         , TO_DATE(TO_CHAR((W_WORK_DATE + 1) + NVL(R1.START_ADD_DAY, 0), 'YYYY-MM-DD') || ' ' || NVL(R1.START_TIME, '00:00'), 'YYYY-MM-DD HH24:MI:SS') AS NEXT_START_TIME
				 , TO_DATE(TO_CHAR((W_WORK_DATE + 1) + NVL(R1.END_ADD_DAY, 0), 'YYYY-MM-DD') || ' ' || NVL(R1.END_TIME, '00:00'), 'YYYY-MM-DD HH24:MI:SS') AS NEXT_END_TIME
				 , NVL(R1.REST_OT_TIME, 0) AS REST_OT_TIME
			FROM HRM_LEAVE_CAL_STD_V LCS
				, (-- 휴식연장 정보.
					SELECT ROT.JOB_CATEGORY_CODE
							 , ROT.REST_OT_TIME_NAME
							 , ROT.REST_OT_TYPE
							 , ROT.START_ADD_DAY
							 , ROT.START_TIME
							 , ROT.END_ADD_DAY
							 , ROT.END_TIME
							 , ROT.REST_OT_TIME
							 , ROT.SOB_ID
							 , ROT.ORG_ID
						FROM HRM_REST_OT_TIME_V ROT
					 WHERE ROT.JOB_CATEGORY_CODE    = W_JOB_CATEGORY_CODE
             AND ROT.ENABLED_FLAG         = 'Y'
						 AND ROT.EFFECTIVE_DATE_FR    <= W_WORK_DATE
						 AND (ROT.EFFECTIVE_DATE_TO IS NULL OR ROT.EFFECTIVE_DATE_TO >= W_WORK_DATE)
					) R1
		 WHERE LCS.JOB_CATEGORY_CODE          = R1.JOB_CATEGORY_CODE
			 AND LCS.SOB_ID                     = R1.SOB_ID
			 AND LCS.ORG_ID                     = R1.ORG_ID
			 AND LCS.JOB_CATEGORY_CODE          = W_JOB_CATEGORY_CODE
			 AND LCS.SOB_ID                     = W_SOB_ID
			 AND LCS.ORG_ID                     = W_ORG_ID
			 AND LCS.REST_TIME_YN               = 'Y'
			 AND LCS.EFFECTIVE_DATE_FR          <= W_WORK_DATE
			 AND (LCS.EFFECTIVE_DATE_TO IS NULL OR LCS.EFFECTIVE_DATE_TO >= W_WORK_DATE)
			 ;

    V_REST_TIME_1                HRD_DAY_LEAVE_OT.OT_TIME%TYPE := 0;  -- 조식.
		V_REST_TIME_2                HRD_DAY_LEAVE_OT.OT_TIME%TYPE := 0;  -- 중식.
		V_REST_TIME_3                HRD_DAY_LEAVE_OT.OT_TIME%TYPE := 0;  -- 석식.
		V_REST_TIME_4                HRD_DAY_LEAVE_OT.OT_TIME%TYPE := 0;  -- 야식.

	  V_REST_TIME                  HRD_DAY_LEAVE_OT.OT_TIME%TYPE := 0;  -- 총합계.

	BEGIN

/*DBMS_OUTPUT.PUT_LINE('근무일자 : ' || TO_CHAR(W_WORK_DATE, 'YYYY-MM-DD') ||
                     ', 근무 =>' || W_HOLY_TYPE ||
                     ', 출근 =>' || TO_CHAR(W_OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 ', 퇴근 =>' || TO_CHAR(W_CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
                     ', 중식 =>' || W_LUNCH_YN ||
                     ', 석식 =>' || W_DINNER_YN ||
                     ', 야식 =>' || W_MIDNIGHT_YN ||
										 ', 직구분=>' || W_JOB_CATEGORY_CODE);*/

	  FOR C1 IN C_REST_TIME
		LOOP
      IF W_BREAKFAST_YN = 'Y' AND C1.REST_OT_TYPE = '1' THEN
			-- 휴연(조식) --
			  BEGIN
				  SELECT NVL(V_REST_TIME_1, 0) +
                 CASE
					         WHEN W_OPEN_TIME <= C1.START_TIME AND C1.END_TIME <= W_CLOSE_TIME THEN C1.REST_OT_TIME
									 ELSE 0
					       END AS REST_TIME_1
					  INTO V_REST_TIME_1
					  FROM DUAL;
				EXCEPTION WHEN OTHERS THEN
				  V_REST_TIME_1 := 0;
				END;
			END IF;
      IF W_BREAKFAST_YN = 'Y' AND C1.REST_OT_TYPE = '1' THEN
			-- 후일 아침 휴연(조식) --
			  BEGIN
				  SELECT NVL(V_REST_TIME_1, 0) +
                 CASE
					         WHEN W_OPEN_TIME <= C1.NEXT_START_TIME AND C1.NEXT_END_TIME <= W_CLOSE_TIME THEN C1.REST_OT_TIME
									 ELSE 0
					       END AS REST_TIME_1
					  INTO V_REST_TIME_1
					  FROM DUAL;
				EXCEPTION WHEN OTHERS THEN
				  V_REST_TIME_1 := 0;
				END;
			END IF;
		  IF W_LUNCH_YN = 'Y' AND C1.REST_OT_TYPE = '2' THEN
			-- 휴연(중식) --
			  BEGIN
				  SELECT NVL(V_REST_TIME_2, 0) + 
                 CASE
					         WHEN W_OPEN_TIME <= C1.START_TIME AND C1.END_TIME <= W_CLOSE_TIME THEN C1.REST_OT_TIME
									 ELSE 0
					       END AS REST_TIME_2
					  INTO V_REST_TIME_2
					  FROM DUAL;
				EXCEPTION WHEN OTHERS THEN
				  V_REST_TIME_2 := 0;
				END;
			END IF;
			IF W_DINNER_YN = 'Y' AND C1.REST_OT_TYPE = '3' THEN
			-- 휴연(석식) --
			  BEGIN
				  SELECT NVL(V_REST_TIME_3, 0) +
                 CASE
					         WHEN W_OPEN_TIME <= C1.START_TIME AND C1.END_TIME <= W_CLOSE_TIME THEN C1.REST_OT_TIME
									 ELSE 0
					       END AS REST_TIME_3
					  INTO V_REST_TIME_3
					  FROM DUAL;
				EXCEPTION WHEN OTHERS THEN
				  V_REST_TIME_3 := 0;
				END;
			END IF;
			IF W_MIDNIGHT_YN = 'Y' AND C1.REST_OT_TYPE = '4' THEN
			-- 휴연(야식) --
			  BEGIN
				  SELECT NVL(V_REST_TIME_4, 0) +
                 CASE
					         WHEN W_OPEN_TIME <= C1.START_TIME AND C1.END_TIME <= W_CLOSE_TIME THEN C1.REST_OT_TIME
									 ELSE 0
					       END AS REST_TIME_4
					  INTO V_REST_TIME_4
					  FROM DUAL;
				EXCEPTION WHEN OTHERS THEN
				  V_REST_TIME_4 := 0;
				END;
			END IF;
		END LOOP C1;

		-- 음수 허용 안함. --
    IF V_REST_TIME_1 < 0 THEN
		  V_REST_TIME_1 := 0;
		END IF;
		IF V_REST_TIME_2 < 0 THEN
		  V_REST_TIME_2 := 0;
		END IF;
		IF V_REST_TIME_3 < 0 THEN
		  V_REST_TIME_3 := 0;
		END IF;
		IF V_REST_TIME_4 < 0 THEN
		  V_REST_TIME_4 := 0;
		END IF;
		V_REST_TIME := NVL(V_REST_TIME_1, 0) + NVL(V_REST_TIME_2, 0) + NVL(V_REST_TIME_3, 0) + NVL(V_REST_TIME_4, 0);

	  RETURN V_REST_TIME;

	EXCEPTION WHEN OTHERS THEN
	  DBMS_OUTPUT.PUT_LINE('REST_TIME_ERROR =>' || SQLERRM);
		RETURN V_REST_TIME;
	END REST_TIME_F;

-- 연장시간 계산 PROCEDURE;
  PROCEDURE OVER_TIME_P
						( W_WORK_DATE                         IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_DUTY_ID                           IN HRD_DAY_LEAVE.DUTY_ID%TYPE
						, W_HOLY_TYPE                         IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
						, W_PRE_HOLY_TYPE                     IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
            , W_NEXT_HOLY_TYPE                    IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
						, W_DANGJIK_YN                        IN HRD_DAY_LEAVE.DANGJIK_YN%TYPE
						, W_ALL_NIGHT_YN                      IN HRD_DAY_LEAVE.ALL_NIGHT_YN%TYPE
						, W_OPEN_TIME                         IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
						, W_CLOSE_TIME                        IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
						, W_PL_OPEN_TIME                      IN HRD_WORK_CALENDAR.OPEN_TIME%TYPE  
					  , W_PL_CLOSE_TIME                     IN HRD_WORK_CALENDAR.CLOSE_TIME%TYPE
						, W_BEFORE_OT_START                   IN HRD_WORK_CALENDAR.BEFORE_OT_START%TYPE
						, W_BEFORE_OT_END                     IN HRD_WORK_CALENDAR.BEFORE_OT_END%TYPE
						, W_AFTER_OT_START                    IN HRD_WORK_CALENDAR.AFTER_OT_START%TYPE
						, W_AFTER_OT_END                      IN HRD_WORK_CALENDAR.AFTER_OT_END%TYPE
						, W_JOB_CATEGORY_CODE                 IN HRM_COMMON.CODE%TYPE
						, W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
						, O_OVER_TIME                         OUT HRD_DAY_LEAVE_OT.OT_TIME%TYPE          -- 연장시간.															  
						, O_HOLIDAY_TIME                      OUT HRD_DAY_LEAVE_OT.OT_TIME%TYPE          -- 휴일근로.
            , O_HOLIDAY_OT_TIME                   OUT HRD_DAY_LEAVE_OT.OT_TIME%TYPE          -- 휴일연장.
						, O_NIGHT_TIME                        OUT HRD_DAY_LEAVE_OT.OT_TIME%TYPE          -- 야간근로.
						, O_NIGHT_BONUS_TIME                  OUT HRD_DAY_LEAVE_OT.OT_TIME%TYPE          -- 야간할증.
						)
  AS
	  CURSOR C_OVER_TIME
		IS
		SELECT LCS.JOB_CATEGORY_CODE
         , LCS.OT_YN
         , LCS.NIGHT_YN
         , LCS.REST_TIME_YN
         , LCS.HOLIDAY_YN
         , LCS.NIGHT_BONUS_YN
         , LCS.FOOD_TIME_DED
         , LCS.REST_TIME_DED
         , OS1.CAL_TYPE
				 , OS1.HOLY_TYPE
         , TO_DATE(TO_CHAR(W_WORK_DATE + NVL(OS1.START_ADD_DAY, 0), 'YYYY-MM-DD') || ' ' || NVL(OS1.START_TIME, '00:00'), 'YYYY-MM-DD HH24:MI:SS') AS START_TIME
				 , NVL(OS1.START_DEFAULT_TIME, 0) AS START_DEFAULT_TIME
         , TO_DATE(TO_CHAR(W_WORK_DATE + NVL(OS1.END_ADD_DAY, 0), 'YYYY-MM-DD') || ' ' || NVL(OS1.END_TIME, '00:00'), 'YYYY-MM-DD HH24:MI:SS') AS END_TIME     
				 , NVL(OS1.END_DEFAULT_TIME, 0) AS END_DEFAULT_TIME
      FROM HRM_LEAVE_CAL_STD_V LCS
        , (-- 연장 계산 기준 정보.
          SELECT OCS.JOB_CATEGORY_CODE
							 , OCS.CAL_TYPE
							 , OCS.HOLY_TYPE
							 , OCS.SOB_ID
							 , OCS.ORG_ID
							 , OCS.START_ADD_DAY
							 , OCS.START_TIME
							 , OCS.START_DEFAULT_TIME
							 , OCS.END_ADD_DAY
							 , OCS.END_TIME
							 , OCS.END_DEFAULT_TIME
						FROM HRM_OT_CAL_STD_V OCS 
					 WHERE OCS.JOB_CATEGORY_CODE    = W_JOB_CATEGORY_CODE
						 AND OCS.SOB_ID               = W_SOB_ID
						 AND OCS.ORG_ID               = W_ORG_ID
						 AND OCS.ENABLED_FLAG         = 'Y'
             AND OCS.EFFECTIVE_DATE_FR    <= W_WORK_DATE
             AND (OCS.EFFECTIVE_DATE_TO IS NULL OR OCS.EFFECTIVE_DATE_TO >= W_WORK_DATE)
          ) OS1
     WHERE LCS.JOB_CATEGORY_CODE          = OS1.JOB_CATEGORY_CODE
       AND LCS.SOB_ID                     = OS1.SOB_ID
       AND LCS.ORG_ID                     = OS1.ORG_ID
       AND LCS.JOB_CATEGORY_CODE          = W_JOB_CATEGORY_CODE
       AND LCS.SOB_ID                     = W_SOB_ID
       AND LCS.ORG_ID                     = W_ORG_ID
       AND LCS.EFFECTIVE_DATE_FR          <= W_WORK_DATE
       AND (LCS.EFFECTIVE_DATE_TO IS NULL OR LCS.EFFECTIVE_DATE_TO >= W_WORK_DATE)
			 ;
    V_TEMP_TIME                                   NUMBER := 0;                          -- 임시변수.
    V_OVER_TIME                                   HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 연장시간.
    V_B_OVER_TIME                                 HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 근무전 연장.
		V_A_OVER_TIME                                 HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 근무후 연장.
		V_HOLIDAY_TIME                                HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 휴일근로.
    V_HOLIDAY_OT_TIME                             HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 휴일야간근로.
		V_NIGHT_TIME                                  HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 야간근로.
		V_NIGHT_BONUS_TIME                            HRD_DAY_LEAVE_OT.OT_TIME%TYPE;        -- 야간할증.
		
		V_FOOD_DED_TIME                               NUMBER := 0;
		V_REST_DED_TIME                               NUMBER := 0;
		
		V_OPEN_TIME                                   HRD_DAY_LEAVE.WORK_DATE%TYPE;         -- 정리된 출근시간.
		V_CLOSE_TIME                                  HRD_DAY_LEAVE.WORK_DATE%TYPE;         -- 정리된 퇴근시간.
		
		V_STD_TIME                                    HRD_DAY_LEAVE.OPEN_TIME%TYPE;         -- 연장 적용 기준시간.
		V_OT_START_TIME                               HRD_DAY_LEAVE.OPEN_TIME%TYPE;         -- 연장등 계산 시작 시간.
		V_OT_MID_TIME                                 HRD_DAY_LEAVE.OPEN_TIME%TYPE;         -- 연장등 계산 중간 시간.
		V_OT_END_TIME                                 HRD_DAY_LEAVE.CLOSE_TIME%TYPE;        -- 연장등 계산 종료 시간.
		
	BEGIN
	  V_OPEN_TIME                                   := W_OPEN_TIME;
		V_CLOSE_TIME                                  := W_CLOSE_TIME;
    
		V_STD_TIME                                    := NULL;         -- 연장 적용 기준 시간.
		V_OT_START_TIME                               := NULL;         -- 연장등 계산 시작 시간.
		V_OT_MID_TIME                                 := NULL;         -- 연장등 계산 중간 시간.
		V_OT_END_TIME                                 := NULL;         -- 연장등 계산 종료 시간.
		
		V_OVER_TIME                                   := 0;            -- 연장시간.
    V_B_OVER_TIME                                 := 0;            -- 근무전 연장.
		V_A_OVER_TIME                                 := 0;            -- 근무후 연장.
			  
		V_HOLIDAY_TIME                                := 0;            -- 휴일근로.
    V_HOLIDAY_OT_TIME                             := 0;            -- 휴일야간근로.
		V_NIGHT_TIME                                  := 0;            -- 야간근로.
		V_NIGHT_BONUS_TIME                            := 0;            -- 야간할증.
		
		V_FOOD_DED_TIME                               := 0;
		V_REST_DED_TIME                               := 0;

/*DBMS_OUTPUT.PUT_LINE('근무일자 : ' || TO_CHAR(W_WORK_DATE, 'YYYY-MM-DD') ||
                     ', 근무 =>' || W_HOLY_TYPE || 
                     ', 출근 =>' || TO_CHAR(W_OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 ', 퇴근 =>' || TO_CHAR(W_CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', 계획출근 =>' || TO_CHAR(W_PL_OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
                     ', 계획퇴근=>' || TO_CHAR(W_PL_CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
										 ', 직구분=>' || W_JOB_CATEGORY_CODE);*/
										 				
	  -- 연장, 야간근로, 야간할증, 휴일근로 계산 --
	  FOR C1 IN C_OVER_TIME
		LOOP
-----------------------------------------------------------------------------------------		
-- 2. 주간근무.
			IF W_HOLY_TYPE = '2' THEN
				-- 2-1. 근무전 연장 계산.
				IF C1.OT_YN = 'Y' AND C1.CAL_TYPE = 'OB' AND C1.HOLY_TYPE = 'DAY' 
					AND V_OPEN_TIME IS NOT NULL AND W_BEFORE_OT_START IS NOT NULL AND W_BEFORE_OT_END IS NOT NULL THEN
				  -- 연장 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
					                                  , P_PL_START_TIME => W_BEFORE_OT_START
																						, P_DEFAULT_RETURN_TIME => W_PL_CLOSE_TIME);
          -- 연장 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
																				, P_PL_END_TIME => W_BEFORE_OT_END
																				, P_DEFAULT_RETURN_TIME => W_PL_CLOSE_TIME);
          -- 연장 적용 기준 시간.
					V_STD_TIME := C1.END_TIME + (C1.END_DEFAULT_TIME / 24);
					
					-- 연장 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OT_START_TIME
					                                  , P_PL_START_TIME => C1.START_TIME
																						, P_DEFAULT_RETURN_TIME => C1.END_TIME);
          -- 연장 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_OT_END_TIME
																				, P_PL_END_TIME => C1.END_TIME
																				, P_DEFAULT_RETURN_TIME => C1.END_TIME);
/*DBMS_OUTPUT.PUT_LINE('2-1. 근무전 연장 계산 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
										 ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 ', XX =>' || TO_CHAR(V_STD_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
                     
          IF V_OT_START_TIME <= V_STD_TIME THEN
					  -- 식사시간 제외.
						V_FOOD_DED_TIME := 0;
						IF C1.FOOD_TIME_DED = 'Y' THEN
						  V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE
							                                   , W_FOOD_TYPE => '4'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
						END IF;
					  -- 근무전 연장 계산.
						BEGIN
              V_TEMP_TIME := 0;
              V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
						  IF NVL(V_TEMP_TIME, 0) < 0 THEN
                V_TEMP_TIME := 0;
              END IF;
              V_B_OVER_TIME := NVL(V_B_OVER_TIME, 0) + NVL(V_TEMP_TIME, 0);              
						EXCEPTION WHEN OTHERS THEN
						  NULL;
						END;
					END IF;
				END IF;
				
				-- 2-2. 근무후 연장 계산.
				IF C1.OT_YN = 'Y' AND C1.CAL_TYPE = 'OA' AND C1.HOLY_TYPE = 'DAY' 
					AND V_CLOSE_TIME IS NOT NULL AND W_AFTER_OT_START IS NOT NULL AND W_AFTER_OT_END IS NOT NULL THEN
				  -- 연장 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
					                                  , P_PL_START_TIME => W_AFTER_OT_START
																						, P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 연장 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
																				, P_PL_END_TIME => W_AFTER_OT_END
																				, P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 연장 적용 기준 시간.
					V_STD_TIME := C1.START_TIME + (C1.START_DEFAULT_TIME / 24);
					
					-- 연장 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OT_START_TIME
					                                  , P_PL_START_TIME => C1.START_TIME
																						, P_DEFAULT_RETURN_TIME => C1.END_TIME);
          -- 연장 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_OT_END_TIME
																				, P_PL_END_TIME => C1.END_TIME
																				, P_DEFAULT_RETURN_TIME => C1.END_TIME);
/*DBMS_OUTPUT.PUT_LINE('2-2. 근무후 연장 계산 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
										 ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 ', XX =>' || TO_CHAR(V_STD_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
                     
          IF V_STD_TIME <= V_OT_END_TIME THEN
					  -- 식사시간 제외.
						V_FOOD_DED_TIME := 0;
						IF C1.FOOD_TIME_DED = 'Y' THEN
						  V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE
							                                   , W_FOOD_TYPE => '4'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
              V_FOOD_DED_TIME := V_FOOD_DED_TIME +
                                 FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE + 1
							                                   , W_FOOD_TYPE => '2'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
						END IF;
					  -- 근무후 연장 계산.            
            BEGIN
              V_TEMP_TIME := 0;
              V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
              IF NVL(V_TEMP_TIME, 0) < 0 THEN
                V_TEMP_TIME := 0;
              END IF;
              V_A_OVER_TIME := NVL(V_A_OVER_TIME, 0) + NVL(V_TEMP_TIME, 0);
            EXCEPTION WHEN OTHERS THEN
              NULL;
            END;
					END IF;
				END IF;				
				-- 2-3. 야간근로 계산.
				IF C1.NIGHT_YN = 'Y' AND C1.CAL_TYPE = 'NT' AND C1.HOLY_TYPE = 'NIGHT' 
					AND V_CLOSE_TIME IS NOT NULL AND W_AFTER_OT_START IS NOT NULL AND W_AFTER_OT_END IS NOT NULL THEN
				  -- 야간 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
					                                  , P_PL_START_TIME => W_AFTER_OT_START
																						, P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 야간 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
																				, P_PL_END_TIME => W_AFTER_OT_END
																				, P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 야간 적용 기준 시간.
					V_STD_TIME := C1.START_TIME + (C1.START_DEFAULT_TIME / 24);
					
					-- 근무후 야간 범위 적용.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OT_START_TIME
					                                  , P_PL_START_TIME => C1.START_TIME
																						, P_DEFAULT_RETURN_TIME => C1.END_TIME);
          -- 근무후 야간 범위 적용.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_OT_END_TIME
																				, P_PL_END_TIME => C1.END_TIME
																				, P_DEFAULT_RETURN_TIME => C1.END_TIME);
/*DBMS_OUTPUT.PUT_LINE('2-3. 야간근로 계산 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
										 ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 ', XX =>' || TO_CHAR(V_STD_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
                     
          IF V_STD_TIME <= V_OT_END_TIME THEN
					  -- 식사시간 제외.
						V_FOOD_DED_TIME := 0;
						IF C1.FOOD_TIME_DED = 'Y' THEN
						  V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE
							                                   , W_FOOD_TYPE => '4'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
						END IF;
					  -- 야간근로 연장 계산 : 철야/당직일 경우 야간근로 적용.
            IF W_JOB_CATEGORY_CODE IN('10') AND W_ALL_NIGHT_YN = 'Y' 
              AND TO_DATE(TO_CHAR(W_WORK_DATE + 1, 'YYYY-MM-DD') || '08:30:00', 'YYYY-MM-DD HH24:MI:SS') <= V_OT_END_TIME THEN
            -- 철야 근무.
              V_A_OVER_TIME := 0;
            ELSIF W_JOB_CATEGORY_CODE IN('10') AND W_DANGJIK_YN = 'Y' 
              AND TO_DATE(TO_CHAR(W_WORK_DATE + 1, 'YYYY-MM-DD') || '08:30:00', 'YYYY-MM-DD HH24:MI:SS') <= V_OT_END_TIME THEN
            -- 당직 근무.
              V_NIGHT_TIME := 0;
            ELSIF W_JOB_CATEGORY_CODE IN ('20') THEN
              -- 후일 근로시 종료시간 설정(08:30).
              IF TO_DATE(TO_CHAR(W_WORK_DATE + 1, 'YYYY-MM-DD') || '08:30', 'YYYY-MM-DD HH24:MI') <  V_OT_END_TIME THEN
                V_OT_END_TIME := TO_DATE(TO_CHAR(W_WORK_DATE + 1, 'YYYY-MM-DD') || '08:30', 'YYYY-MM-DD HH24:MI');
              END IF;
              BEGIN
                V_TEMP_TIME := 0;
                V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
                IF NVL(V_TEMP_TIME, 0) < 0 THEN
                  V_TEMP_TIME := 0;
                END IF;
                V_NIGHT_TIME := NVL(V_NIGHT_TIME, 0) + NVL(V_TEMP_TIME, 0);
              EXCEPTION WHEN OTHERS THEN
                NULL;
              END;
              -- 야간근로 --> 연장으로 변환 적용.
              IF V_NIGHT_TIME > 0 THEN
                V_A_OVER_TIME := NVL(V_A_OVER_TIME, 0) + NVL(V_NIGHT_TIME, 0);
                V_NIGHT_TIME := 0;
              END IF;
            END IF;
					END IF;
				END IF;
				-- 2-4. 야간 할증 계산.
				IF C1.NIGHT_BONUS_YN = 'Y' AND C1.CAL_TYPE = 'NB' AND C1.HOLY_TYPE = 'NIGHT' 
					AND V_CLOSE_TIME IS NOT NULL AND W_AFTER_OT_START IS NOT NULL AND W_AFTER_OT_END IS NOT NULL THEN
				  -- 야간 할증 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
					                                  , P_PL_START_TIME => W_AFTER_OT_START
																						, P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 야간 할증 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
																				, P_PL_END_TIME => W_AFTER_OT_END
																				, P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 야간 할증 적용 기준 시간.
					V_STD_TIME := C1.START_TIME + (C1.START_DEFAULT_TIME / 24);
					
					-- 야간 할증 범위 적용.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OT_START_TIME
					                                  , P_PL_START_TIME => C1.START_TIME
																						, P_DEFAULT_RETURN_TIME => C1.END_TIME);
          -- 야간 할증 범위 적용.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_OT_END_TIME
																				, P_PL_END_TIME => C1.END_TIME
																				, P_DEFAULT_RETURN_TIME => C1.END_TIME);
/*DBMS_OUTPUT.PUT_LINE('2-4. 야간 할증 계산 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
										 ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 ', XX =>' || TO_CHAR(V_STD_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
                     
          IF V_STD_TIME <= V_OT_END_TIME THEN
					  -- 식사시간 제외.
						V_FOOD_DED_TIME := 0;
						IF C1.FOOD_TIME_DED = 'Y' THEN
						  V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE
							                                   , W_FOOD_TYPE => '4'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
						END IF;
					  -- 야간할증 계산.
						BEGIN
              V_TEMP_TIME := 0;
              V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
						  IF NVL(V_TEMP_TIME, 0) < 0 THEN
                V_TEMP_TIME := 0;
              END IF;
              IF TO_DATE(TO_CHAR(W_WORK_DATE, 'YYYY-MM-DD') || ' 21:00', 'YYYY-MM-DD HH24:MI') < V_OPEN_TIME THEN
                NULL;
              ELSIF TO_DATE(TO_CHAR(W_WORK_DATE + 1, 'YYYY-MM-DD') || ' 06:00', 'YYYY-MM-DD HH24:MI') > V_CLOSE_TIME THEN
                NULL;
              ELSIF V_TEMP_TIME = 7 THEN
                -- 7H(만근)시 8H로 적용해줌(김일곤K 요청).
                V_TEMP_TIME := 8;
              END IF;
						  V_NIGHT_BONUS_TIME := NVL(V_NIGHT_BONUS_TIME, 0) + NVL(V_TEMP_TIME, 0);
						EXCEPTION WHEN OTHERS THEN
              NULL;
						END;
					END IF;
				END IF;
        -- 2-5. 철야후 후일 아침 근무후 연장 계산.
				IF C1.OT_YN = 'Y' AND C1.CAL_TYPE = 'OA' AND C1.HOLY_TYPE = 'NIGHT' 
					AND V_CLOSE_TIME IS NOT NULL AND W_AFTER_OT_START IS NOT NULL AND W_AFTER_OT_END IS NOT NULL THEN
				  -- 연장 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
					                                  , P_PL_START_TIME => W_AFTER_OT_START
																						, P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 연장 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
																				, P_PL_END_TIME => W_AFTER_OT_END
																				, P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
/*DBMS_OUTPUT.PUT_LINE('2-2-1. 야간근무후 연장 계산 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
          -- 연장 적용 기준 시간.
					V_STD_TIME := C1.START_TIME + (C1.START_DEFAULT_TIME / 24);
					
					-- 연장 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OT_START_TIME
					                                  , P_PL_START_TIME => C1.START_TIME
																						, P_DEFAULT_RETURN_TIME => C1.END_TIME);
          -- 연장 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_OT_END_TIME
																				, P_PL_END_TIME => C1.END_TIME
																				, P_DEFAULT_RETURN_TIME => C1.END_TIME);
/*DBMS_OUTPUT.PUT_LINE('2-2-1. 야간근무후 연장 계산 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
										 ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 ', XX =>' || TO_CHAR(V_STD_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
                     
					-- 휴일 야간근로시 종료시간 설정(08:30).
          IF TO_DATE(TO_CHAR(W_WORK_DATE + 1, 'YYYY-MM-DD') || '08:30', 'YYYY-MM-DD HH24:MI') <  V_OT_END_TIME THEN
            V_OT_END_TIME := TO_DATE(TO_CHAR(W_WORK_DATE + 1, 'YYYY-MM-DD') || '08:30', 'YYYY-MM-DD HH24:MI');
          END IF;
          
          IF V_STD_TIME <= V_OT_END_TIME THEN
					  -- 식사시간 제외.
						V_FOOD_DED_TIME := 0;
						IF C1.FOOD_TIME_DED = 'Y' THEN
						  V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE
							                                   , W_FOOD_TYPE => '4'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
						  V_FOOD_DED_TIME := V_FOOD_DED_TIME +
                                 FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE + 1
							                                   , W_FOOD_TYPE => '2'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
						END IF;
					  -- 근무후 연장 계산.
						BEGIN
              V_TEMP_TIME := 0;
              V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
						  IF NVL(V_TEMP_TIME, 0) < 0 THEN
                V_TEMP_TIME := 0;
              END IF;
						  V_A_OVER_TIME := NVL(V_A_OVER_TIME, 0) + NVL(V_TEMP_TIME, 0);
						EXCEPTION WHEN OTHERS THEN
						  NULL;
						END;
					END IF;
				END IF;

-----------------------------------------------------------------------------------------
-- 3. 야간근무.
			ELSIF W_HOLY_TYPE = '3' THEN
				-- 3-1. 근무전 연장 계산.
				IF C1.OT_YN = 'Y' AND C1.CAL_TYPE = 'OB' AND C1.HOLY_TYPE = 'NIGHT' 
					AND V_OPEN_TIME IS NOT NULL AND W_BEFORE_OT_START IS NOT NULL AND W_BEFORE_OT_END IS NOT NULL THEN
				  -- 연장 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
					                                  , P_PL_START_TIME => W_BEFORE_OT_START
																						, P_DEFAULT_RETURN_TIME => W_PL_CLOSE_TIME);
          -- 연장 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
																				, P_PL_END_TIME => W_BEFORE_OT_END
																				, P_DEFAULT_RETURN_TIME => W_PL_CLOSE_TIME);
          -- 연장 적용 기준 시간.
					V_STD_TIME := C1.END_TIME + (C1.END_DEFAULT_TIME / 24);
					
					-- 연장 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OT_START_TIME
					                                  , P_PL_START_TIME => C1.START_TIME
																						, P_DEFAULT_RETURN_TIME => C1.END_TIME);
          -- 연장 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_OT_END_TIME
																				, P_PL_END_TIME => C1.END_TIME
																				, P_DEFAULT_RETURN_TIME => C1.END_TIME);
/*DBMS_OUTPUT.PUT_LINE('3-1. 근무전 연장 계산 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
										 ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 ', XX =>' || TO_CHAR(V_STD_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
                     
          IF V_OT_START_TIME <= V_STD_TIME THEN
					  -- 식사시간 제외.
						V_FOOD_DED_TIME := 0;
						IF C1.FOOD_TIME_DED = 'Y' THEN
						  V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE 
							                                   , W_FOOD_TYPE => '3'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
						END IF;
					  -- 근무전 연장 계산.
						BEGIN
              V_TEMP_TIME := 0;
              V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
						  IF NVL(V_TEMP_TIME, 0) < 0 THEN
                V_TEMP_TIME := 0;
              END IF;
						  V_B_OVER_TIME := NVL(V_B_OVER_TIME, 0) + NVL(V_TEMP_TIME, 0);
						EXCEPTION WHEN OTHERS THEN
						  NULL;
						END;
					END IF;
				END IF;
				
				-- 3-2. 근무후 연장 계산.
				IF C1.OT_YN = 'Y' AND C1.CAL_TYPE = 'OA' AND C1.HOLY_TYPE = 'NIGHT' 
					AND V_CLOSE_TIME IS NOT NULL AND W_AFTER_OT_START IS NOT NULL AND W_AFTER_OT_END IS NOT NULL THEN
				  -- 연장 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
					                                  , P_PL_START_TIME => W_AFTER_OT_START
																						, P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 연장 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
																				, P_PL_END_TIME => W_AFTER_OT_END
																				, P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 연장 적용 기준 시간.
					V_STD_TIME := C1.START_TIME + (C1.START_DEFAULT_TIME / 24);
					
					-- 연장 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OT_START_TIME
					                                  , P_PL_START_TIME => C1.START_TIME
																						, P_DEFAULT_RETURN_TIME => C1.END_TIME);
          -- 연장 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_OT_END_TIME
																				, P_PL_END_TIME => C1.END_TIME
																				, P_DEFAULT_RETURN_TIME => C1.END_TIME);
/*DBMS_OUTPUT.PUT_LINE('3-2. 근무후 연장 계산 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
										 ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 ', XX =>' || TO_CHAR(V_STD_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
          
					-- 휴일 야간근로시 종료시간 설정(08:30).
          IF TO_DATE(TO_CHAR(W_WORK_DATE + 1, 'YYYY-MM-DD') || '08:30', 'YYYY-MM-DD HH24:MI') <  V_OT_END_TIME THEN
            V_OT_END_TIME := TO_DATE(TO_CHAR(W_WORK_DATE + 1, 'YYYY-MM-DD') || '08:30', 'YYYY-MM-DD HH24:MI');
          END IF;

          IF V_STD_TIME <= V_OT_END_TIME THEN
					  -- 식사시간 제외.
						V_FOOD_DED_TIME := 0;
						IF C1.FOOD_TIME_DED = 'Y' THEN
						  V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE
							                                   , W_FOOD_TYPE => '4'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
						  V_FOOD_DED_TIME := V_FOOD_DED_TIME +
                                 FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE + 1
							                                   , W_FOOD_TYPE => '2'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
						END IF;
					  -- 근무후 연장 계산.
						BEGIN
              V_TEMP_TIME := 0;
              V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
						  IF NVL(V_TEMP_TIME, 0) < 0 THEN
                V_TEMP_TIME := 0;
              END IF;
						  V_A_OVER_TIME := NVL(V_A_OVER_TIME, 0) + NVL(V_TEMP_TIME, 0);
						EXCEPTION WHEN OTHERS THEN
						  NULL;
						END;
					END IF;
				END IF;
				-- 3-4. 야간 할증 계산.
				IF C1.CAL_TYPE = 'NB' AND C1.HOLY_TYPE = 'NIGHT' 
					AND V_OPEN_TIME IS NOT NULL AND V_CLOSE_TIME IS NOT NULL  THEN
				  -- 야간 할증 적용 기준 시간.
					V_STD_TIME := C1.START_TIME + (C1.START_DEFAULT_TIME / 24);
					
					-- 야간 할증 범위 적용.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
					                                  , P_PL_START_TIME => C1.START_TIME
																						, P_DEFAULT_RETURN_TIME => C1.END_TIME);
          -- 야간 할증 범위 적용.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
																				, P_PL_END_TIME => C1.END_TIME
																				, P_DEFAULT_RETURN_TIME => C1.END_TIME);
                                        
/*DBMS_OUTPUT.PUT_LINE('3-4. 야간 할증 계산 : OPEN =>' || TO_CHAR(V_OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', CLOSE =>' || TO_CHAR(V_CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
										 ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 ', XX =>' || TO_CHAR(V_STD_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
                     
          IF V_STD_TIME <= V_OT_END_TIME THEN
					  -- 식사시간 제외.
						V_FOOD_DED_TIME := 0;
						IF C1.FOOD_TIME_DED = 'Y' THEN
						  V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE
							                                   , W_FOOD_TYPE => '4'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
						END IF;
					  -- 야간할증 계산.
						BEGIN
              V_TEMP_TIME := 0;
              V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
						  IF NVL(V_TEMP_TIME, 0) < 0 THEN
                V_TEMP_TIME := 0;
              END IF;
              IF TO_DATE(TO_CHAR(W_WORK_DATE, 'YYYY-MM-DD') || ' 21:00', 'YYYY-MM-DD HH24:MI') < V_OPEN_TIME THEN
                NULL;
              ELSIF TO_DATE(TO_CHAR(W_WORK_DATE + 1, 'YYYY-MM-DD') || ' 06:00', 'YYYY-MM-DD HH24:MI') > V_CLOSE_TIME THEN
                NULL;
              ELSIF V_TEMP_TIME = 7 THEN
                -- 7H(만근)시 8H로 적용해줌(김일곤K 요청).
                V_TEMP_TIME := 8;
              END IF;
						  V_NIGHT_BONUS_TIME := NVL(V_NIGHT_BONUS_TIME, 0) + NVL(V_TEMP_TIME, 0);              
						EXCEPTION WHEN OTHERS THEN
						  NULL;
						END;
					END IF;
				END IF;
			  
-----------------------------------------------------------------------------------------
-- 1. 휴일근무.
			ELSIF W_HOLY_TYPE IN('0', '1') THEN
        -- 1-0-1.휴일 주간근무전 연장 계산.
				IF C1.OT_YN = 'Y' AND C1.CAL_TYPE = 'OB' AND C1.HOLY_TYPE = 'DAY' 
					AND V_OPEN_TIME IS NOT NULL AND W_BEFORE_OT_START IS NOT NULL AND W_BEFORE_OT_END IS NOT NULL THEN
				  -- 연장 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
					                                  , P_PL_START_TIME => W_BEFORE_OT_START
																						, P_DEFAULT_RETURN_TIME => V_OPEN_TIME);
          -- 연장 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
																				, P_PL_END_TIME => W_BEFORE_OT_END
																				, P_DEFAULT_RETURN_TIME => V_OPEN_TIME);
          -- 연장 적용 기준 시간.
					V_STD_TIME := C1.END_TIME + (C1.END_DEFAULT_TIME / 24);
					
					-- 연장 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OT_START_TIME
					                                  , P_PL_START_TIME => C1.START_TIME
																						, P_DEFAULT_RETURN_TIME => C1.END_TIME);
          -- 연장 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_OT_END_TIME
																				, P_PL_END_TIME => C1.END_TIME
																				, P_DEFAULT_RETURN_TIME => C1.END_TIME);
/*DBMS_OUTPUT.PUT_LINE('2-1. 근무전 연장 계산 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
										 ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 ', XX =>' || TO_CHAR(V_STD_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
                     
          IF V_OT_START_TIME <= V_STD_TIME THEN
					  -- 식사시간 제외.
						V_FOOD_DED_TIME := 0;
						IF C1.FOOD_TIME_DED = 'Y' THEN
						  V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE
							                                   , W_FOOD_TYPE => '4'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
						END IF;
					  -- 근무전 연장 계산.
						BEGIN
              V_TEMP_TIME := 0;
              V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
						  IF NVL(V_TEMP_TIME, 0) < 0 THEN
                V_TEMP_TIME := 0;
              END IF;
              V_HOLIDAY_OT_TIME := NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_TEMP_TIME, 0);              
						EXCEPTION WHEN OTHERS THEN
						  NULL;
						END;
					END IF;
				END IF;
        -- 1-1-2. 휴일 야간 근무전 연장 계산.
				IF C1.OT_YN = 'Y' AND C1.CAL_TYPE = 'OB' AND C1.HOLY_TYPE = 'NIGHT' 
					AND V_OPEN_TIME IS NOT NULL AND W_BEFORE_OT_START IS NOT NULL AND W_BEFORE_OT_END IS NOT NULL THEN
				  -- 연장 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
					                                  , P_PL_START_TIME => W_BEFORE_OT_START
																						, P_DEFAULT_RETURN_TIME => V_OPEN_TIME);
          -- 연장 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
																				, P_PL_END_TIME => W_BEFORE_OT_END
																				, P_DEFAULT_RETURN_TIME => V_OPEN_TIME);
          -- 연장 적용 기준 시간.
					V_STD_TIME := C1.END_TIME + (C1.END_DEFAULT_TIME / 24);
					
					-- 연장 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OT_START_TIME
					                                  , P_PL_START_TIME => C1.START_TIME
																						, P_DEFAULT_RETURN_TIME => C1.END_TIME);
          -- 연장 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_OT_END_TIME
																				, P_PL_END_TIME => C1.END_TIME
																				, P_DEFAULT_RETURN_TIME => C1.END_TIME);
/*DBMS_OUTPUT.PUT_LINE('3-1. 근무전 연장 계산 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
										 ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 ', XX =>' || TO_CHAR(V_STD_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
                     
          IF V_OT_START_TIME <= V_STD_TIME THEN
					  -- 식사시간 제외.
						V_FOOD_DED_TIME := 0;
						IF C1.FOOD_TIME_DED = 'Y' THEN
						  V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE 
							                                   , W_FOOD_TYPE => '3'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
						END IF;
					  -- 근무전 연장 계산.
						BEGIN
              V_TEMP_TIME := 0;
              V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
						  IF NVL(V_TEMP_TIME, 0) < 0 THEN
                V_TEMP_TIME := 0;
              END IF;
						  V_HOLIDAY_OT_TIME := NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_TEMP_TIME, 0);
						EXCEPTION WHEN OTHERS THEN
						  NULL;
						END;
					END IF;
				END IF;
        
        -- 1-10. 휴일 주간 근로 계산.
			  IF C1.HOLIDAY_YN = 'Y' AND C1.CAL_TYPE = 'HD' AND C1.HOLY_TYPE = 'DAY'
					AND V_CLOSE_TIME IS NOT NULL AND W_AFTER_OT_START IS NOT NULL AND W_AFTER_OT_END IS NOT NULL THEN
				  -- 신청 적용한 시작 시간.
          V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
                                            , P_PL_START_TIME => W_AFTER_OT_START
                                            , P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 신청 적용한 종료 시간.
          V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
                                        , P_PL_END_TIME => W_AFTER_OT_END
                                        , P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 적용 기준 시간.
          V_STD_TIME := C1.START_TIME + (C1.START_DEFAULT_TIME / 24);
  					
          -- 신청 범위 적용.
          V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OT_START_TIME
                                            , P_PL_START_TIME => C1.START_TIME
                                            , P_DEFAULT_RETURN_TIME => C1.END_TIME);
          -- 야간 할증 범위 적용.
          V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_OT_END_TIME
                                        , P_PL_END_TIME => C1.END_TIME
                                        , P_DEFAULT_RETURN_TIME => C1.END_TIME);                                        
/*DBMS_OUTPUT.PUT_LINE('1-1. 휴일 주간 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
										 ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 ', XX =>' || TO_CHAR(V_STD_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
                     
          IF V_STD_TIME <= V_OT_END_TIME THEN
					  -- 식사시간 제외.
						V_FOOD_DED_TIME := 0;
						IF C1.FOOD_TIME_DED = 'Y' THEN
						  V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE
							                                   , W_FOOD_TYPE => '2'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
              
              V_FOOD_DED_TIME := NVL(V_FOOD_DED_TIME, 0) + 
                                 FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE
							                                   , W_FOOD_TYPE => '3'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
						END IF;
					  -- 휴일근로 계산.
						BEGIN
              V_TEMP_TIME := 0;
              V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
						  IF NVL(V_TEMP_TIME, 0) < 0 THEN
                V_TEMP_TIME := 0;
              END IF;
						  V_HOLIDAY_TIME := NVL(V_HOLIDAY_TIME, 0) + NVL(V_TEMP_TIME, 0);
						EXCEPTION WHEN OTHERS THEN
						  NULL;
						END;
					END IF;
				END IF;
        -- 1-11. 주간 근무후 연장 계산.
				IF C1.OT_YN = 'Y' AND C1.CAL_TYPE = 'OA' AND C1.HOLY_TYPE = 'DAY' 
					AND V_CLOSE_TIME IS NOT NULL AND W_AFTER_OT_START IS NOT NULL AND W_AFTER_OT_END IS NOT NULL THEN
				  -- 연장 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
					                                  , P_PL_START_TIME => W_AFTER_OT_START
																						, P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 연장 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
																				, P_PL_END_TIME => W_AFTER_OT_END
																				, P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 연장 적용 기준 시간.
					V_STD_TIME := C1.START_TIME + (C1.START_DEFAULT_TIME / 24);
					
					-- 연장 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OT_START_TIME
					                                  , P_PL_START_TIME => C1.START_TIME
																						, P_DEFAULT_RETURN_TIME => C1.END_TIME);
          -- 연장 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_OT_END_TIME
																				, P_PL_END_TIME => C1.END_TIME
																				, P_DEFAULT_RETURN_TIME => C1.END_TIME);
/*DBMS_OUTPUT.PUT_LINE('1-2. 휴일 주간 근무후 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
										 ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 ', XX =>' || TO_CHAR(TO_DATE(TO_CHAR(W_WORK_DATE, 'YYYY-MM-DD') || ' 21:00', 'YYYY-MM-DD HH24:MI'), 'YYYY-MM-DD HH24:MI:SS'));*/
          
          /*-- 전호수 주석 : 사용 안함.
          -- 근무후 야간 범위 재 적용(21:00 이후 적용).
          IF C1.NIGHT_YN = 'Y' AND (W_ALL_NIGHT_YN = 'Y' OR W_DANGJIK_YN = 'Y')
            AND V_OT_START_TIME < TO_DATE(TO_CHAR(W_WORK_DATE, 'YYYY-MM-DD') || ' 21:00', 'YYYY-MM-DD HH24:MI') THEN
            V_OT_START_TIME := TO_DATE(TO_CHAR(W_WORK_DATE, 'YYYY-MM-DD') || ' 21:00', 'YYYY-MM-DD HH24:MI');
          END IF;*/
          
          IF V_STD_TIME <= V_OT_END_TIME THEN
					  -- 식사시간 제외.
						V_FOOD_DED_TIME := 0;
						IF C1.FOOD_TIME_DED = 'Y' THEN
						  V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE
							                                   , W_FOOD_TYPE => '2'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
						  V_FOOD_DED_TIME := V_FOOD_DED_TIME + 
                                 FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE
							                                   , W_FOOD_TYPE => '3'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
              V_FOOD_DED_TIME := V_FOOD_DED_TIME + 
                                 FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE
							                                   , W_FOOD_TYPE => '4'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
            END IF;
					  -- 근무후 연장 계산.
						BEGIN
              V_TEMP_TIME := 0;
              V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
						  IF NVL(V_TEMP_TIME, 0) < 0 THEN
                V_TEMP_TIME := 0;
              END IF;
						  V_HOLIDAY_OT_TIME := NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_TEMP_TIME, 0);
						EXCEPTION WHEN OTHERS THEN
						  NULL;
						END;
					END IF;
				END IF;
				-- 10-3.휴일 야간근로 계산.
				IF C1.NIGHT_YN = 'Y' AND C1.CAL_TYPE = 'NT' AND C1.HOLY_TYPE = 'NIGHT' 
					AND V_CLOSE_TIME IS NOT NULL AND W_AFTER_OT_START IS NOT NULL AND W_AFTER_OT_END IS NOT NULL THEN
				  -- 야간 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
					                                  , P_PL_START_TIME => W_AFTER_OT_START
																						, P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 야간 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
																				, P_PL_END_TIME => W_AFTER_OT_END
																				, P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 야간 적용 기준 시간.
					V_STD_TIME := C1.START_TIME + (C1.START_DEFAULT_TIME / 24);
					
					-- 근무후 야간 범위 적용.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OT_START_TIME
					                                  , P_PL_START_TIME => C1.START_TIME
																						, P_DEFAULT_RETURN_TIME => C1.END_TIME);
          -- 근무후 야간 범위 적용.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_OT_END_TIME
																				, P_PL_END_TIME => C1.END_TIME
																				, P_DEFAULT_RETURN_TIME => C1.END_TIME);
/*DBMS_OUTPUT.PUT_LINE('1-3. 휴일 야간 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
										 ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 ', XX =>' || TO_CHAR(V_STD_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
                     
          IF V_STD_TIME <= V_OT_END_TIME THEN
					  -- 식사시간 제외.
						V_FOOD_DED_TIME := 0;
						IF C1.FOOD_TIME_DED = 'Y' THEN
						  V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE
							                                   , W_FOOD_TYPE => '4'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
						END IF;
					  -- 야간근로 연장 계산.
            -- 야간근로 연장 계산 : 철야/당직일 경우 야간근로 적용.
            IF W_JOB_CATEGORY_CODE IN('10') AND W_ALL_NIGHT_YN = 'Y' 
              AND TO_DATE(TO_CHAR(W_WORK_DATE + 1, 'YYYY-MM-DD') || '08:30:00', 'YYYY-MM-DD HH24:MI:SS') <= V_OT_END_TIME THEN
            -- 철야 근무.
              V_A_OVER_TIME := 0;
            ELSIF W_JOB_CATEGORY_CODE IN('10') AND W_DANGJIK_YN = 'Y' 
              AND TO_DATE(TO_CHAR(W_WORK_DATE + 1, 'YYYY-MM-DD') || '08:30:00', 'YYYY-MM-DD HH24:MI:SS') <= V_OT_END_TIME THEN
            -- 당직 근무.
              V_NIGHT_TIME := 0;
            ELSIF W_JOB_CATEGORY_CODE IN ('20') THEN
              BEGIN
                V_TEMP_TIME := 0;
                V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
                IF NVL(V_TEMP_TIME, 0) < 0 THEN
                  V_TEMP_TIME := 0;
                END IF;
                V_NIGHT_TIME := NVL(V_NIGHT_TIME, 0) + NVL(V_TEMP_TIME, 0);
              EXCEPTION WHEN OTHERS THEN
                NULL;
              END;
              -- 휴일 야간근로 --> 휴일근로 변환 적용.
              IF W_ALL_NIGHT_YN <> 'Y' THEN
                V_HOLIDAY_OT_TIME := NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_NIGHT_TIME, 0);  -- 철야(야간)이 아닐경우 야간근로를 연장으로 적용함.
                V_NIGHT_TIME := 0;
              ELSIF V_NIGHT_TIME > 0 THEN
                V_HOLIDAY_TIME := NVL(V_HOLIDAY_TIME, 0) + NVL(V_NIGHT_TIME, 0);
                V_NIGHT_TIME := 0;
              END IF;
            END IF;
					END IF;
				END IF;
        -- 10-4. 휴일 야간근무후 연장 계산.
				IF C1.OT_YN = 'Y' AND C1.CAL_TYPE = 'OA' AND C1.HOLY_TYPE = 'NIGHT'
					AND V_CLOSE_TIME IS NOT NULL AND W_AFTER_OT_START IS NOT NULL AND W_AFTER_OT_END IS NOT NULL THEN
				  -- 연장 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
					                                  , P_PL_START_TIME => W_AFTER_OT_START
																						, P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 연장 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
																				, P_PL_END_TIME => W_AFTER_OT_END
																				, P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 연장 적용 기준 시간.
					V_STD_TIME := C1.START_TIME + (C1.START_DEFAULT_TIME / 24);
					
					-- 연장 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OT_START_TIME
					                                  , P_PL_START_TIME => C1.START_TIME
																						, P_DEFAULT_RETURN_TIME => C1.END_TIME);
          -- 연장 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_OT_END_TIME
																				, P_PL_END_TIME => C1.END_TIME
																				, P_DEFAULT_RETURN_TIME => C1.END_TIME);
          
          -- 휴일 야간근로시 종료시간 설정(08:30).
          IF TO_DATE(TO_CHAR(W_WORK_DATE + 1, 'YYYY-MM-DD') || '08:30', 'YYYY-MM-DD HH24:MI') <  V_OT_END_TIME THEN
            V_OT_END_TIME := TO_DATE(TO_CHAR(W_WORK_DATE + 1, 'YYYY-MM-DD') || '08:30', 'YYYY-MM-DD HH24:MI');
          END IF;
/*DBMS_OUTPUT.PUT_LINE('1-5. 야간 근무후 연장 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
										 ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 ', XX =>' || TO_CHAR(V_STD_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
					
          /*-- 전호수 수정. 
          -- 근무후 야간 범위 재 적용(21:00 이후 적용).
          IF C1.NIGHT_YN = 'Y' AND (W_ALL_NIGHT_YN = 'Y' OR W_DANGJIK_YN = 'Y')
            AND V_OT_START_TIME < TO_DATE(TO_CHAR(W_WORK_DATE, 'YYYY-MM-DD') || ' 21:00', 'YYYY-MM-DD HH24:MI') THEN
            V_OT_START_TIME := TO_DATE(TO_CHAR(W_WORK_DATE, 'YYYY-MM-DD') || ' 21:00', 'YYYY-MM-DD HH24:MI');
          END IF;*/
          					 
          IF V_STD_TIME <= V_OT_END_TIME THEN
					  -- 식사시간 제외.
						V_FOOD_DED_TIME := 0;
						IF C1.FOOD_TIME_DED = 'Y' THEN
						  V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE
							                                   , W_FOOD_TYPE => '4'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
						  V_FOOD_DED_TIME := V_FOOD_DED_TIME + 
                                 FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE + 1
							                                   , W_FOOD_TYPE => '2'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
            END IF;
					  -- 근무후 연장 계산.
						BEGIN
              V_TEMP_TIME := 0;
              V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
						  IF NVL(V_TEMP_TIME, 0) < 0 THEN
                V_TEMP_TIME := 0;
              END IF;
						  V_HOLIDAY_OT_TIME := NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_TEMP_TIME, 0);
						EXCEPTION WHEN OTHERS THEN
						  NULL;
						END;
					END IF;
				END IF;
				-- 10-5. 휴일야간 할증 계산.
				IF C1.NIGHT_BONUS_YN = 'Y' AND C1.CAL_TYPE = 'NB' AND C1.HOLY_TYPE = 'NIGHT' 
					AND V_CLOSE_TIME IS NOT NULL AND W_AFTER_OT_START IS NOT NULL AND W_AFTER_OT_END IS NOT NULL THEN
				  -- 야간 할증 신청 적용한 시작 시간.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
					                                  , P_PL_START_TIME => W_AFTER_OT_START
																						, P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 야간 할증 신청 적용한 종료 시간.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
																				, P_PL_END_TIME => W_AFTER_OT_END
																				, P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
          -- 야간 할증 적용 기준 시간.
					V_STD_TIME := C1.START_TIME + (C1.START_DEFAULT_TIME / 24);
					
					-- 야간 할증 범위 적용.
					V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OT_START_TIME
					                                  , P_PL_START_TIME => C1.START_TIME
																						, P_DEFAULT_RETURN_TIME => C1.END_TIME);
          -- 야간 할증 범위 적용.
					V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_OT_END_TIME
																				, P_PL_END_TIME => C1.END_TIME
																				, P_DEFAULT_RETURN_TIME => C1.END_TIME);
/*DBMS_OUTPUT.PUT_LINE('1-4. 휴일 야할 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
										 ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                     ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
										 ', XX =>' || TO_CHAR(V_STD_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
                     
          IF V_STD_TIME <= V_OT_END_TIME THEN
					  -- 식사시간 제외.
						V_FOOD_DED_TIME := 0;
						IF C1.FOOD_TIME_DED = 'Y' THEN
						  V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE
							                                   , W_FOOD_TYPE => '4'
																								 , W_START_TIME => V_OT_START_TIME
																								 , W_END_TIME => V_OT_END_TIME
																								 , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
						END IF;
					  -- 야간할증 계산.
						BEGIN
              V_TEMP_TIME := 0;
              V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
						  IF NVL(V_TEMP_TIME, 0) < 0 THEN
                V_TEMP_TIME := 0;
              END IF;
              IF TO_DATE(TO_CHAR(W_WORK_DATE, 'YYYY-MM-DD') || ' 21:00', 'YYYY-MM-DD HH24:MI') < V_OPEN_TIME THEN
                NULL;
              ELSIF TO_DATE(TO_CHAR(W_WORK_DATE + 1, 'YYYY-MM-DD') || ' 06:00', 'YYYY-MM-DD HH24:MI') > V_CLOSE_TIME THEN
                NULL;
              ELSIF V_TEMP_TIME = 7 THEN
                -- 7H(만근)시 8H로 적용해줌(김일곤K 요청).
                V_TEMP_TIME := 8;
              END IF;
						  V_NIGHT_BONUS_TIME := NVL(V_NIGHT_BONUS_TIME, 0) + NVL(V_TEMP_TIME, 0);
						EXCEPTION WHEN OTHERS THEN
						  NULL;
						END;
					END IF;
				END IF;
      END IF;
----> 근무 : 무휴/유휴 계산 끝.
-----------------------------------------------------------------------------------------
      -- 10-1. 철야후 후일 본 근로 계산.
      IF C1.OT_YN = 'Y' AND C1.CAL_TYPE = 'AN' AND C1.HOLY_TYPE = 'DAY'
        AND V_CLOSE_TIME IS NOT NULL AND W_AFTER_OT_START IS NOT NULL AND W_AFTER_OT_END IS NOT NULL THEN
        -- 신청 적용한 시작 시간.
        V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
                                          , P_PL_START_TIME => W_AFTER_OT_START
                                          , P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
        -- 신청 적용한 종료 시간.
        V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
                                      , P_PL_END_TIME => W_AFTER_OT_END
                                      , P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
/*DBMS_OUTPUT.PUT_LINE('2-10-1. 철야후 주간연장 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                   ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') );*/
        -- 적용 기준 시간.
        V_STD_TIME := C1.START_TIME + (C1.START_DEFAULT_TIME / 24);
  					
        -- 신청 범위 적용.
        V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OT_START_TIME
                                          , P_PL_START_TIME => C1.START_TIME
                                          , P_DEFAULT_RETURN_TIME => C1.END_TIME);
        -- 야간 할증 범위 적용.
        V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_OT_END_TIME
                                      , P_PL_END_TIME => C1.END_TIME
                                      , P_DEFAULT_RETURN_TIME => C1.END_TIME);                                        
/*DBMS_OUTPUT.PUT_LINE('2-10-2. 철야후 주간연장 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                   ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                   ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                   ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
                   ', XX =>' || TO_CHAR(V_STD_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
                     
        IF V_STD_TIME <= V_OT_END_TIME THEN
          -- 식사시간 제외.
          V_FOOD_DED_TIME := 0;
          IF C1.FOOD_TIME_DED = 'Y' THEN
            V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE + 1
                                               , W_FOOD_TYPE => '2'
                                               , W_START_TIME => V_OT_START_TIME
                                               , W_END_TIME => V_OT_END_TIME
                                               , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
                                               , W_SOB_ID => W_SOB_ID
                                               , W_ORG_ID => W_ORG_ID
                                               );
              
            V_FOOD_DED_TIME := NVL(V_FOOD_DED_TIME, 0) + 
                               FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE + 1
                                               , W_FOOD_TYPE => '3'
                                               , W_START_TIME => V_OT_START_TIME
                                               , W_END_TIME => V_OT_END_TIME
                                               , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
                                               , W_SOB_ID => W_SOB_ID
                                               , W_ORG_ID => W_ORG_ID
                                               );
          END IF;
          BEGIN
            V_TEMP_TIME := 0;
            V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
            IF NVL(V_TEMP_TIME, 0) < 0 THEN
              V_TEMP_TIME := 0;
            END IF;
            IF W_NEXT_HOLY_TYPE IN('0', '1') THEN
              V_HOLIDAY_OT_TIME := NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_TEMP_TIME, 0);
            ELSE
              V_A_OVER_TIME := NVL(V_A_OVER_TIME, 0) + NVL(V_TEMP_TIME, 0);
            END IF;
          EXCEPTION WHEN OTHERS THEN
            NULL;
          END;
        END IF;
      END IF;
      -- 10-2.주간 근무후 연장 계산.
      IF C1.OT_YN = 'Y' AND C1.CAL_TYPE = 'OA' AND C1.HOLY_TYPE = 'DAY' 
        AND V_CLOSE_TIME IS NOT NULL AND W_AFTER_OT_START IS NOT NULL AND W_AFTER_OT_END IS NOT NULL THEN
        -- 연장 신청 적용한 시작 시간.
        V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
                                          , P_PL_START_TIME => W_AFTER_OT_START
                                          , P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
        -- 연장 신청 적용한 종료 시간.
        V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
                                      , P_PL_END_TIME => W_AFTER_OT_END
                                      , P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
/*DBMS_OUTPUT.PUT_LINE('10-2-1.철야 후 주간 근무후 연장 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                   ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
        -- 연장 적용 기준 시간.
        V_STD_TIME := C1.START_TIME + (C1.START_DEFAULT_TIME / 24);
					
        -- 연장 신청 적용한 시작 시간.
        V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OT_START_TIME
                                          , P_PL_START_TIME => C1.START_TIME + 1
                                          , P_DEFAULT_RETURN_TIME => C1.END_TIME);
        -- 연장 신청 적용한 종료 시간.
        V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_OT_END_TIME
                                      , P_PL_END_TIME => C1.END_TIME + 1
                                      , P_DEFAULT_RETURN_TIME => C1.END_TIME);
/*DBMS_OUTPUT.PUT_LINE('10-2-1.철야 후 주간 근무후 연장 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                   ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                   ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                   ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
                   ', XX =>' || TO_CHAR(V_STD_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
          
        IF V_STD_TIME <= V_OT_END_TIME THEN
          -- 식사시간 제외.
          V_FOOD_DED_TIME := 0;
          IF C1.FOOD_TIME_DED = 'Y' THEN
            V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE + 1
                                               , W_FOOD_TYPE => '2'
                                               , W_START_TIME => V_OT_START_TIME
                                               , W_END_TIME => V_OT_END_TIME
                                               , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
                                               , W_SOB_ID => W_SOB_ID
                                               , W_ORG_ID => W_ORG_ID
                                               );
            V_FOOD_DED_TIME := V_FOOD_DED_TIME + 
                               FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE + 1
                                               , W_FOOD_TYPE => '3'
                                               , W_START_TIME => V_OT_START_TIME
                                               , W_END_TIME => V_OT_END_TIME
                                               , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
                                               , W_SOB_ID => W_SOB_ID
                                               , W_ORG_ID => W_ORG_ID
                                               );
            V_FOOD_DED_TIME := V_FOOD_DED_TIME + 
                               FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE + 1
                                               , W_FOOD_TYPE => '4'
                                               , W_START_TIME => V_OT_START_TIME
                                               , W_END_TIME => V_OT_END_TIME
                                               , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
                                               , W_SOB_ID => W_SOB_ID
                                               , W_ORG_ID => W_ORG_ID
                                               );
          END IF;
          -- 근무후 연장 계산.
          BEGIN
            V_TEMP_TIME := 0;
            V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
            IF NVL(V_TEMP_TIME, 0) < 0 THEN
              V_TEMP_TIME := 0;
            END IF;
            IF W_NEXT_HOLY_TYPE IN('0', '1') THEN
              V_HOLIDAY_OT_TIME := NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_TEMP_TIME, 0);
            ELSE
              V_A_OVER_TIME := NVL(V_A_OVER_TIME, 0) + NVL(V_TEMP_TIME, 0);
            END IF;
          EXCEPTION WHEN OTHERS THEN
            NULL;
          END;
        END IF;
      END IF;        
      -- 10-3. 철야후 야간근로 계산.
      IF C1.NIGHT_YN = 'Y' AND C1.CAL_TYPE = 'NT' AND C1.HOLY_TYPE = 'NIGHT' 
        AND V_CLOSE_TIME IS NOT NULL AND W_AFTER_OT_START IS NOT NULL AND W_AFTER_OT_END IS NOT NULL THEN
        -- 야간 신청 적용한 시작 시간.
        V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
                                          , P_PL_START_TIME => W_AFTER_OT_START
                                          , P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
        -- 야간 신청 적용한 종료 시간.
        V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
                                      , P_PL_END_TIME => W_AFTER_OT_END
                                      , P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
/*DBMS_OUTPUT.PUT_LINE('10-3-1.철야후 야간근로 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                   ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
        -- 야간 적용 기준 시간.
        V_STD_TIME := C1.START_TIME + (C1.START_DEFAULT_TIME / 24);
					
        -- 근무후 야간 범위 적용.
        V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OT_START_TIME
                                          , P_PL_START_TIME => C1.START_TIME + 1
                                          , P_DEFAULT_RETURN_TIME => C1.END_TIME);
        -- 근무후 야간 범위 적용.
        V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_OT_END_TIME
                                      , P_PL_END_TIME => C1.END_TIME + 1
                                      , P_DEFAULT_RETURN_TIME => C1.END_TIME);
/*DBMS_OUTPUT.PUT_LINE('10-3-2.철야후 야간근로 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                   ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                   ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                   ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
                   ', XX =>' || TO_CHAR(V_STD_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
                     
        IF V_STD_TIME <= V_OT_END_TIME THEN
          -- 식사시간 제외.
          V_FOOD_DED_TIME := 0;
          IF C1.FOOD_TIME_DED = 'Y' THEN
            V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE + 1
                                               , W_FOOD_TYPE => '4'
                                               , W_START_TIME => V_OT_START_TIME
                                               , W_END_TIME => V_OT_END_TIME
                                               , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
                                               , W_SOB_ID => W_SOB_ID
                                               , W_ORG_ID => W_ORG_ID
                                               );
          END IF;
          -- 야간근로 연장 계산.
          -- 야간근로 연장 계산 : 철야/당직일 경우 야간근로 적용.
          IF W_JOB_CATEGORY_CODE IN('10') AND W_ALL_NIGHT_YN = 'Y' 
            AND TO_DATE(TO_CHAR(W_WORK_DATE + 2, 'YYYY-MM-DD') || '08:30:00', 'YYYY-MM-DD HH24:MI:SS') <= V_OT_END_TIME THEN
          -- 철야 근무.
            V_A_OVER_TIME := 0;
          ELSIF W_JOB_CATEGORY_CODE IN('10') AND W_DANGJIK_YN = 'Y' 
            AND TO_DATE(TO_CHAR(W_WORK_DATE + 2, 'YYYY-MM-DD') || '08:30:00', 'YYYY-MM-DD HH24:MI:SS') <= V_OT_END_TIME THEN
          -- 당직 근무.
            V_NIGHT_TIME := 0;
          ELSIF W_JOB_CATEGORY_CODE IN ('20') THEN
            -- 휴일 야간근로시 종료시간 설정(08:30).
            IF TO_DATE(TO_CHAR(W_WORK_DATE + 2, 'YYYY-MM-DD') || '08:30', 'YYYY-MM-DD HH24:MI') <  V_OT_END_TIME THEN
              V_OT_END_TIME := TO_DATE(TO_CHAR(W_WORK_DATE + 2, 'YYYY-MM-DD') || '08:30', 'YYYY-MM-DD HH24:MI');
            END IF;
            BEGIN
              V_TEMP_TIME := 0;
              V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
              IF NVL(V_TEMP_TIME, 0) < 0 THEN
                V_TEMP_TIME := 0;
              END IF;
              V_NIGHT_TIME := NVL(V_NIGHT_TIME, 0) + NVL(V_TEMP_TIME, 0);
            EXCEPTION WHEN OTHERS THEN
              NULL;
            END;
            IF W_NEXT_HOLY_TYPE IN('0', '1') THEN
              V_HOLIDAY_OT_TIME := NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_NIGHT_TIME, 0);
            ELSE
              V_A_OVER_TIME := NVL(V_A_OVER_TIME, 0) + NVL(V_NIGHT_TIME, 0);
            END IF;
            V_NIGHT_TIME := 0;
          END IF;
        END IF;
      END IF;
      -- 10-4. 휴일야간 할증 계산.
      IF C1.NIGHT_BONUS_YN = 'Y' AND C1.CAL_TYPE = 'NB' AND C1.HOLY_TYPE = 'NIGHT' 
        AND V_CLOSE_TIME IS NOT NULL AND W_AFTER_OT_START IS NOT NULL AND W_AFTER_OT_END IS NOT NULL THEN
        -- 야간 할증 신청 적용한 시작 시간.
        V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OPEN_TIME
                                          , P_PL_START_TIME => W_AFTER_OT_START
                                          , P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
        -- 야간 할증 신청 적용한 종료 시간.
        V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_CLOSE_TIME
                                      , P_PL_END_TIME => W_AFTER_OT_END
                                      , P_DEFAULT_RETURN_TIME => V_CLOSE_TIME);
        -- 야간 할증 적용 기준 시간.
        V_STD_TIME := C1.START_TIME + (C1.START_DEFAULT_TIME / 24);
					
        -- 야간 할증 범위 적용.
        V_OT_START_TIME := OT_START_TIME_F( P_OPEN_TIME => V_OT_START_TIME
                                          , P_PL_START_TIME => C1.START_TIME + 1
                                          , P_DEFAULT_RETURN_TIME => C1.END_TIME);
        -- 야간 할증 범위 적용.
        V_OT_END_TIME := OT_END_TIME_F( P_CLOSE_TIME => V_OT_END_TIME
                                      , P_PL_END_TIME => C1.END_TIME + 1
                                      , P_DEFAULT_RETURN_TIME => C1.END_TIME);
/*DBMS_OUTPUT.PUT_LINE('1-4. 휴일 야할 : OT_START =>' || TO_CHAR(V_OT_START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                   ', OT_END=>' || TO_CHAR(V_OT_END_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                   ', C1_START =>' || TO_CHAR(C1.START_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                   ', C1_END=>' || TO_CHAR(C1.END_TIME, 'YYYY-MM-DD HH24:MI:SS') ||
                   ', XX =>' || TO_CHAR(V_STD_TIME, 'YYYY-MM-DD HH24:MI:SS'));*/
                     
        IF V_STD_TIME <= V_OT_END_TIME THEN
          -- 식사시간 제외.
          V_FOOD_DED_TIME := 0;
          IF C1.FOOD_TIME_DED = 'Y' THEN
            V_FOOD_DED_TIME := FOOD_DED_TIME_F ( W_WORK_DATE => W_WORK_DATE + 1
                                               , W_FOOD_TYPE => '4'
                                               , W_START_TIME => V_OT_START_TIME
                                               , W_END_TIME => V_OT_END_TIME
                                               , W_JOB_CATEGORY_CODE => W_JOB_CATEGORY_CODE
                                               , W_SOB_ID => W_SOB_ID
                                               , W_ORG_ID => W_ORG_ID
                                               );
          END IF;
          -- 야간할증 계산.
          BEGIN
            V_TEMP_TIME := 0;
            V_TEMP_TIME := ROUND((V_OT_END_TIME - V_OT_START_TIME) * 24, 2) - V_FOOD_DED_TIME;
            IF NVL(V_TEMP_TIME, 0) < 0 THEN
              V_TEMP_TIME := 0;
            END IF;
            IF TO_DATE(TO_CHAR(W_WORK_DATE, 'YYYY-MM-DD') || ' 21:00', 'YYYY-MM-DD HH24:MI') < V_OPEN_TIME THEN
              NULL;
            ELSIF TO_DATE(TO_CHAR(W_WORK_DATE + 1, 'YYYY-MM-DD') || ' 06:00', 'YYYY-MM-DD HH24:MI') > V_CLOSE_TIME THEN
              NULL;
            ELSIF V_TEMP_TIME = 7 THEN
              -- 7H(만근)시 8H로 적용해줌(김일곤K 요청).
              V_TEMP_TIME := 8;
            END IF;
            V_NIGHT_BONUS_TIME := NVL(V_NIGHT_BONUS_TIME, 0) + NVL(V_TEMP_TIME, 0);
          EXCEPTION WHEN OTHERS THEN
            NULL;
          END;
        END IF;
      END IF;
		END LOOP C1;
	  IF V_B_OVER_TIME < 0 THEN
		  V_B_OVER_TIME := 0;		
		END IF;
		IF V_A_OVER_TIME < 0 THEN
		  V_A_OVER_TIME := 0;
		END IF;
		V_OVER_TIME := V_B_OVER_TIME + V_A_OVER_TIME;  -- 연장시간.		
		IF V_HOLIDAY_TIME < 0 THEN                     -- 휴일근로.
		  V_HOLIDAY_TIME := 0;			
		END IF;
    IF V_HOLIDAY_OT_TIME < 0 THEN                  -- 휴일연장근로.
      V_HOLIDAY_OT_TIME := 0;                      
    END IF;
		IF V_NIGHT_TIME < 0 THEN                       -- 야간근로.
		  V_NIGHT_TIME := 0;			
		END IF;
		IF V_NIGHT_BONUS_TIME < 0 THEN                 -- 야간할증.
		  V_NIGHT_BONUS_TIME := 0;			
		END IF;
		O_OVER_TIME                   := V_OVER_TIME;            -- 연장시간.															  
		O_HOLIDAY_TIME                := V_HOLIDAY_TIME;         -- 휴일근로.
    O_HOLIDAY_OT_TIME             := V_HOLIDAY_OT_TIME;      -- 휴일연장근로.
		O_NIGHT_TIME                  := V_NIGHT_TIME;           -- 야간근로.
		O_NIGHT_BONUS_TIME            := V_NIGHT_BONUS_TIME;     -- 야간할증.

	EXCEPTION WHEN OTHERS THEN
	  DBMS_OUTPUT.PUT_LINE('OVER_TIME_ERROR =>' || SQLERRM);
		O_OVER_TIME                   := 0;            -- 연장시간.															  
		O_HOLIDAY_TIME                := 0;            -- 휴일근로.
    O_HOLIDAY_OT_TIME             := 0;            -- 휴일연장근로.
		O_NIGHT_TIME                  := 0;            -- 야간근로.
		O_NIGHT_BONUS_TIME            := 0;            -- 야간할증.
	END OVER_TIME_P;	
  
/*============================================================================================/
  --  출퇴근 시간 30" 단위 정리.
/============================================================================================*/
-- 출근 시간 정리.
	FUNCTION OPEN_TIME_F
	         ( P_JOB_CATEGORY_CODE                  IN HRM_COMMON.CODE%TYPE
					 , P_HOLY_TYPE                          IN HRM_COMMON.CODE%TYPE
	         , P_OPEN_TIME                          IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
					 ) RETURN DATE
  AS
	  V_OPEN_TIME                                   HRD_DAY_LEAVE.OPEN_TIME%TYPE := NULL;

  BEGIN

		IF P_HOLY_TYPE IS NULL OR P_OPEN_TIME IS NULL THEN
			RETURN TO_DATE(NULL);
		END IF;

    IF P_JOB_CATEGORY_CODE = '10' THEN
		/*======================================================================/
			-- 관리직 출근시간 정리
			-- 기준 : 평일 - 30" 단위 적용(예, 09:20 -> 09:30, 09:40 -> 10:00
			--									               07:20 -> 08:30, 12:45 -> 13:30)
			--			  휴일 - 30" 단위 적용(예, 09:30 -> 09:30, 09:20 -> 09:30
			--											   		     07:29 -> 07:30, 06:40 -> 07:00)
		/======================================================================*/
		  IF P_HOLY_TYPE IN('1', '0') THEN   -- 휴일(유휴, 무휴).
			  SELECT CASE
				         WHEN TO_CHAR(P_OPEN_TIME, 'MI') BETWEEN '01' AND '29' THEN TRUNC(P_OPEN_TIME, 'HH24') + (30/24/60)
								 WHEN TO_CHAR(P_OPEN_TIME, 'MI') BETWEEN '31' AND '59' THEN TRUNC(P_OPEN_TIME, 'HH24') + (60/24/60)
								 ELSE P_OPEN_TIME
				       END AS OPEN_TIME
				  INTO V_OPEN_TIME
				  FROM DUAL
				;
			ELSE   -- 평일.
			  SELECT CASE
				         WHEN TO_CHAR(P_OPEN_TIME, 'MI') BETWEEN '01' AND '29' THEN TRUNC(P_OPEN_TIME, 'HH24') + (30/24/60)
								 WHEN TO_CHAR(P_OPEN_TIME, 'MI') BETWEEN '31' AND '59' THEN TRUNC(P_OPEN_TIME, 'HH24') + (60/24/60)
								 ELSE P_OPEN_TIME
				       END AS OPEN_TIME
				  INTO V_OPEN_TIME
				  FROM DUAL
				;
			END IF;

			-- 식사시간 적용.
			BEGIN
			  SELECT TO_DATE(TO_CHAR(V_OPEN_TIME, 'YYYY-MM-DD') || ' ' || FT.END_TIME, 'YYYY-MM-DD HH24:MI:SS') AS OPEN_TIME
				  INTO V_OPEN_TIME
					FROM HRM_FOOD_TIME_V FT
				 WHERE FT.JOB_CATEGORY_CODE              = DECODE(FT.JOB_CATEGORY_CODE, NULL, FT.JOB_CATEGORY_CODE, P_JOB_CATEGORY_CODE)
					 AND TO_CHAR(V_OPEN_TIME, 'HH24:MI')   BETWEEN FT.START_TIME AND FT.END_TIME
				;
			EXCEPTION WHEN OTHERS THEN
			  NULL;
			END;
		ELSE
		/*======================================================================/
			-- 생산직 출근시간 정리
			-- 기준 : 평일 - 30" 단위 적용(예, 09:20 -> 09:30, 09:40 -> 10:00
			--									               07:20 -> 08:30, 12:45 -> 13:30)
			--			  휴일 - 30" 단위 적용(예, 09:30 -> 09:30, 09:20 -> 09:30
			--											   		     07:29 -> 07:30, 06:40 -> 07:00)
		/======================================================================*/
		  IF P_HOLY_TYPE IN('1', '0') THEN   -- 휴일(유휴, 무휴).
			  SELECT CASE
				         WHEN TO_CHAR(P_OPEN_TIME, 'MI') BETWEEN '01' AND '29' THEN TRUNC(P_OPEN_TIME, 'HH24') + (30/24/60)
								 WHEN TO_CHAR(P_OPEN_TIME, 'MI') BETWEEN '31' AND '59' THEN TRUNC(P_OPEN_TIME, 'HH24') + (60/24/60)
								 ELSE P_OPEN_TIME
				       END AS OPEN_TIME
				  INTO V_OPEN_TIME
				  FROM DUAL
				;
			ELSE   -- 평일.
			  SELECT CASE
				         WHEN TO_CHAR(P_OPEN_TIME, 'MI') BETWEEN '01' AND '29' THEN TRUNC(P_OPEN_TIME, 'HH24') + (30/24/60)
								 WHEN TO_CHAR(P_OPEN_TIME, 'MI') BETWEEN '31' AND '59' THEN TRUNC(P_OPEN_TIME, 'HH24') + (60/24/60)
								 ELSE P_OPEN_TIME
				       END AS OPEN_TIME
				  INTO V_OPEN_TIME
				  FROM DUAL
				;
			END IF;

			-- 식사시간 적용.
			BEGIN
			  SELECT TO_DATE(TO_CHAR(V_OPEN_TIME, 'YYYY-MM-DD') || ' ' || FT.END_TIME, 'YYYY-MM-DD HH24:MI:SS') AS OPEN_TIME
				  INTO V_OPEN_TIME
					FROM HRM_FOOD_TIME_V FT
				 WHERE FT.JOB_CATEGORY_CODE              = DECODE(FT.JOB_CATEGORY_CODE, NULL, FT.JOB_CATEGORY_CODE, P_JOB_CATEGORY_CODE)
					 AND TO_CHAR(V_OPEN_TIME, 'HH24:MI')   BETWEEN FT.START_TIME AND FT.END_TIME
				;
			EXCEPTION WHEN OTHERS THEN
			  NULL;
			END;
		END IF;
		RETURN TRUNC(V_OPEN_TIME, 'MI');

	END OPEN_TIME_F;

-- 퇴근 시간 정리.
	FUNCTION CLOSE_TIME_F
	         ( P_JOB_CATEGORY_CODE                  IN HRM_COMMON.CODE%TYPE
					 , P_HOLY_TYPE                          IN HRM_COMMON.CODE%TYPE
	         , P_CLOSE_TIME                         IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
					 ) RETURN DATE
  AS
	  V_CLOSE_TIME                                  HRD_DAY_LEAVE.OPEN_TIME%TYPE := NULL;

  BEGIN

		IF P_HOLY_TYPE IS NULL OR P_CLOSE_TIME IS NULL THEN
			RETURN TO_DATE(NULL);
		END IF;

    IF P_JOB_CATEGORY_CODE = '10' THEN
		/*======================================================================/
			-- 관리직 퇴근시간 정리
			-- 기준 : 평일 - 30" 단위 적용(예, 09:20 -> 09:00, 09:40 -> 09:30
			--									               07:20 -> 07:00, 12:45 -> 12:30)
			--			  휴일 - 30" 단위 적용(예, 09:30 -> 09:30, 09:20 -> 09:00
			--											   		     07:29 -> 07:00, 06:40 -> 06:30)
		/======================================================================*/
		  IF P_HOLY_TYPE IN('1', '0') THEN   -- 휴일(유휴, 무휴).
			  SELECT CASE
				         WHEN TO_CHAR(P_CLOSE_TIME, 'MI') BETWEEN '01' AND '29' THEN TRUNC(P_CLOSE_TIME, 'HH24') + (0/24/60)
								 WHEN TO_CHAR(P_CLOSE_TIME, 'MI') BETWEEN '31' AND '59' THEN TRUNC(P_CLOSE_TIME, 'HH24') + (30/24/60)
								 ELSE P_CLOSE_TIME
				       END AS CLOSE_TIME
				  INTO V_CLOSE_TIME
				  FROM DUAL
				;
			ELSE   -- 평일.
			  SELECT CASE
				         WHEN TO_CHAR(P_CLOSE_TIME, 'MI') BETWEEN '01' AND '29' THEN TRUNC(P_CLOSE_TIME, 'HH24') + (0/24/60)
								 WHEN TO_CHAR(P_CLOSE_TIME, 'MI') BETWEEN '31' AND '59' THEN TRUNC(P_CLOSE_TIME, 'HH24') + (30/24/60)
								 ELSE P_CLOSE_TIME
				       END AS CLOSE_TIME
				  INTO V_CLOSE_TIME
				  FROM DUAL
				;
			END IF;

			-- 식사시간 적용.
			BEGIN
			  SELECT TO_DATE(TO_CHAR(V_CLOSE_TIME, 'YYYY-MM-DD') || ' ' || FT.START_TIME, 'YYYY-MM-DD HH24:MI:SS') AS CLOSE_TIME
				  INTO V_CLOSE_TIME
					FROM HRM_FOOD_TIME_V FT
				 WHERE FT.JOB_CATEGORY_CODE               = DECODE(FT.JOB_CATEGORY_CODE, NULL, FT.JOB_CATEGORY_CODE, P_JOB_CATEGORY_CODE)
					 AND TO_CHAR(V_CLOSE_TIME, 'HH24:MI')   BETWEEN FT.START_TIME AND FT.END_TIME
				;
			EXCEPTION WHEN OTHERS THEN
			  NULL;
			END;
		ELSE
		/*======================================================================/
			-- 생산직 출근시간 정리
			-- 기준 : 평일 - 30" 단위 적용(예, 09:20 -> 09:30, 09:40 -> 10:00
			--									               07:20 -> 08:30, 12:45 -> 13:30)
			--			  휴일 - 30" 단위 적용(예, 09:30 -> 09:30, 09:20 -> 09:30
			--											   		     07:29 -> 07:30, 06:40 -> 07:00)
		/======================================================================*/
		  IF P_HOLY_TYPE IN('1', '0') THEN   -- 휴일(유휴, 무휴).
			  SELECT CASE
				         WHEN TO_CHAR(P_CLOSE_TIME, 'MI') BETWEEN '01' AND '29' THEN TRUNC(P_CLOSE_TIME, 'HH24') + (0/24/60)
								 WHEN TO_CHAR(P_CLOSE_TIME, 'MI') BETWEEN '31' AND '59' THEN TRUNC(P_CLOSE_TIME, 'HH24') + (30/24/60)
								 ELSE P_CLOSE_TIME
				       END AS CLOSE_TIME
				  INTO V_CLOSE_TIME
				  FROM DUAL
				;
			ELSE   -- 평일.
			  SELECT CASE
				         WHEN TO_CHAR(P_CLOSE_TIME, 'MI') BETWEEN '01' AND '29' THEN TRUNC(P_CLOSE_TIME, 'HH24') + (0/24/60)
								 WHEN TO_CHAR(P_CLOSE_TIME, 'MI') BETWEEN '31' AND '59' THEN TRUNC(P_CLOSE_TIME, 'HH24') + (30/24/60)
								 ELSE P_CLOSE_TIME
				       END AS CLOSE_TIME
				  INTO V_CLOSE_TIME
				  FROM DUAL
				;
			END IF;

			-- 식사시간 적용.
			BEGIN
			  SELECT TO_DATE(TO_CHAR(V_CLOSE_TIME, 'YYYY-MM-DD') || ' ' || FT.START_TIME, 'YYYY-MM-DD HH24:MI:SS') AS CLOSE_TIME
				  INTO V_CLOSE_TIME
					FROM HRM_FOOD_TIME_V FT
				 WHERE FT.JOB_CATEGORY_CODE               = DECODE(FT.JOB_CATEGORY_CODE, NULL, FT.JOB_CATEGORY_CODE, P_JOB_CATEGORY_CODE)
					 AND TO_CHAR(V_CLOSE_TIME, 'HH24:MI')   BETWEEN FT.START_TIME AND FT.END_TIME
				;
			EXCEPTION WHEN OTHERS THEN
			  NULL;
			END;
		END IF;
		RETURN TRUNC(V_CLOSE_TIME, 'MI');

	END CLOSE_TIME_F;

-- 연장 시작 시간 정리.
	FUNCTION OT_START_TIME_F
						( P_OPEN_TIME                         IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
						, P_PL_START_TIME                     IN HRD_WORK_CALENDAR.BEFORE_OT_START%TYPE
						, P_DEFAULT_RETURN_TIME               IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
						) RETURN DATE
  AS
	  V_OT_START_TIME                               HRD_WORK_CALENDAR.BEFORE_OT_START%TYPE;

	BEGIN
	  BEGIN
		  SELECT CASE
			         WHEN P_PL_START_TIME IS NULL THEN P_DEFAULT_RETURN_TIME
							 WHEN P_OPEN_TIME IS NULL THEN P_DEFAULT_RETURN_TIME
							 WHEN P_OPEN_TIME < P_PL_START_TIME THEN P_PL_START_TIME
							 ELSE P_OPEN_TIME
			       END AS OT_START_TIME
			  INTO V_OT_START_TIME
			  FROM DUAL;
		EXCEPTION WHEN OTHERS THEN
		  V_OT_START_TIME := P_DEFAULT_RETURN_TIME;
		END;
	  RETURN TRUNC(V_OT_START_TIME, 'MI');

	END OT_START_TIME_F;

-- 연장 종료 시간 정리.
	FUNCTION OT_END_TIME_F
						( P_CLOSE_TIME                        IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
						, P_PL_END_TIME                       IN HRD_WORK_CALENDAR.BEFORE_OT_END%TYPE
						, P_DEFAULT_RETURN_TIME               IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
						) RETURN DATE
  AS
	  V_OT_END_TIME                                 HRD_WORK_CALENDAR.BEFORE_OT_END%TYPE;

	BEGIN
	  BEGIN
		  SELECT CASE
			         WHEN P_PL_END_TIME IS NULL THEN P_DEFAULT_RETURN_TIME
							 WHEN P_CLOSE_TIME IS NULL THEN P_DEFAULT_RETURN_TIME
							 WHEN P_PL_END_TIME < P_CLOSE_TIME THEN P_PL_END_TIME
							 ELSE P_CLOSE_TIME
			       END AS OT_END_TIME
			  INTO V_OT_END_TIME
			  FROM DUAL;
		EXCEPTION WHEN OTHERS THEN
		  V_OT_END_TIME := P_DEFAULT_RETURN_TIME;
		END;
	  RETURN TRUNC(V_OT_END_TIME, 'MI');

	END OT_END_TIME_F;

/*============================================================================================/
  --  식시공제 시간 반환;
/============================================================================================*/
  FUNCTION FOOD_DED_TIME_F
	         ( W_WORK_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
					 , W_FOOD_TYPE                          IN HRM_FOOD_TIME_V.FOOD_TYPE%TYPE
					 , W_START_TIME                         IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
					 , W_END_TIME                           IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
					 , W_JOB_CATEGORY_CODE                  IN HRM_COMMON.CODE%TYPE
					 , W_SOB_ID                             IN HRD_DAY_LEAVE.SOB_ID%TYPE
					 , W_ORG_ID                             IN HRD_DAY_LEAVE.ORG_ID%TYPE
					 ) RETURN NUMBER
  AS
    V_FOOD_DED_TIME                               NUMBER := 0;

  BEGIN
	  BEGIN
		  SELECT NVL(TO_NUMBER(MAX(FT.FOOD_DED_TIME)), 0) AS FOOD_DED_TIME
			  INTO V_FOOD_DED_TIME
				FROM HRM_FOOD_TIME_V FT
			 WHERE FT.JOB_CATEGORY_CODE           = DECODE(FT.JOB_CATEGORY_CODE, NULL, FT.JOB_CATEGORY_CODE, W_JOB_CATEGORY_CODE)
				 AND FT.FOOD_TYPE                   = W_FOOD_TYPE
				 AND W_START_TIME                  <= TO_DATE(TO_CHAR(W_WORK_DATE  + FT.START_ADD_DAY, 'YYYY-MM-DD') || ' ' || FT.START_TIME || ':59', 'YYYY-MM-DD HH24:MI:SS')
				 AND W_END_TIME                    >= TO_DATE(TO_CHAR(W_WORK_DATE  + FT.END_ADD_DAY, 'YYYY-MM-DD') || ' ' || FT.END_TIME || ':00', 'YYYY-MM-DD HH24:MI:SS')
				 AND FT.SOB_ID                      = W_SOB_ID
				 AND FT.ORG_ID                      = W_ORG_ID
				 ;
		EXCEPTION WHEN OTHERS THEN
		  V_FOOD_DED_TIME := 0;
		END;
		RETURN V_FOOD_DED_TIME;

  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('식사공제계산_ERROR=>' || SUBSTR(SQLERRM, 1, 200));
  END FOOD_DED_TIME_F;

/*============================================================================================/
  ++  휴식 제외시간 계산;
      -- 각 중간 출근/퇴근 자에 한해 적용 처리;
      -- 넘겨 받는 변수 : 오전(21), 오후(22), 야간(31), 새벽(32)  ;
      .-- REST_FLAG :  근무전(B), 근무중(M), 근무후(A) FLAG ;
/============================================================================================*/
  FUNCTION REST_DED_F
	         ( W_WORK_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
					 , W_REST_TYPE                          IN HRM_REST_TIME_V.REST_TYPE%TYPE
					 , W_START_TIME                         IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
					 , W_END_TIME                           IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
					 , W_JOB_CATEGORY_CODE                  IN HRM_COMMON.CODE%TYPE
					 , W_SOB_ID                             IN HRD_DAY_LEAVE.SOB_ID%TYPE
					 , W_ORG_ID                             IN HRD_DAY_LEAVE.ORG_ID%TYPE
					 ) RETURN NUMBER
  AS
    V_REST_DED_TIME                               NUMBER := 0;

  BEGIN
	  BEGIN
		  SELECT NVL(TO_NUMBER(MAX(RT.REST_DED_TIME)), 0) AS REST_DED_TIME
        INTO V_REST_DED_TIME
        FROM HRM_REST_TIME_V RT
       WHERE RT.JOB_CATEGORY_CODE           = DECODE(RT.JOB_CATEGORY_CODE, NULL, RT.JOB_CATEGORY_CODE, W_JOB_CATEGORY_CODE)
         AND RT.REST_TYPE                   = W_REST_TYPE
         AND W_START_TIME                  <= TO_DATE(TO_CHAR(W_WORK_DATE  + RT.START_ADD_DAY, 'YYYY-MM-DD') || ' ' || RT.START_TIME || ':59', 'YYYY-MM-DD HH24:MI:SS')
         AND W_END_TIME                    >= TO_DATE(TO_CHAR(W_WORK_DATE  + RT.END_ADD_DAY, 'YYYY-MM-DD') || ' ' || RT.END_TIME || ':00', 'YYYY-MM-DD HH24:MI:SS')
         AND RT.SOB_ID                      = W_SOB_ID
         AND RT.ORG_ID                      = W_ORG_ID
         ;
		EXCEPTION WHEN OTHERS THEN
		  V_REST_DED_TIME := 0;
		END;

		RETURN V_REST_DED_TIME;

  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('휴식공제계산_ERROR==>' || SUBSTR(SQLERRM, 1, 200));
  END REST_DED_F;

-- DAY INTERFACE --> DAY LEAVE UPDATE.
  PROCEDURE LEAVE_DATETIME_UPDATE
            ( W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_END_DATE                          IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_HOLY_TYPE                         IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
            , W_WORK_TYPE_ID                      IN HRD_WORK_CALENDAR.WORK_TYPE_ID%TYPE
						, W_DEPT_ID                           IN HRD_DAY_INTERFACE.DEPT_ID%TYPE
            , W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_JOB_CATEGORY_ID                   IN HRM_PERSON_MASTER.JOB_CATEGORY_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
						, P_USER_ID                           IN HRD_DAY_LEAVE.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
						, O_MESSAGE                           OUT VARCHAR2
            )
  AS
	  V_SYSDATE                                     DATE := GET_LOCAL_DATE(W_SOB_ID);
		V_CLOSE_COUNT                                 NUMBER := 0;
    
    V_A_DUTY_ID                                   HRM_COMMON.COMMON_ID%TYPE;
		V_NA_DUTY_ID                                  HRM_COMMON.COMMON_ID%TYPE;
		V_H_DUTY_ID                                   HRM_COMMON.COMMON_ID%TYPE;
		V_NH_DUTY_ID                                  HRM_COMMON.COMMON_ID%TYPE;
		V_PH_DUTY_ID                                  HRM_COMMON.COMMON_ID%TYPE;    
	BEGIN
    O_STATUS := 'F';
    BEGIN
		  SELECT COUNT(DL.PERSON_ID) AS CLOSE_COUNT
			  INTO V_CLOSE_COUNT
			  FROM HRD_DAY_LEAVE DL
			WHERE DL.WORK_DATE                BETWEEN W_START_DATE AND W_END_DATE
        AND DL.PERSON_ID                = NVL(W_PERSON_ID, DL.PERSON_ID)
        AND DL.WORK_CORP_ID             = W_CORP_ID
        AND DL.SOB_ID                   = W_SOB_ID
        AND DL.ORG_ID                   = W_ORG_ID
        AND DL.CLOSED_YN                = 'N'
        AND EXISTS 
              ( SELECT 'X'
                  FROM HRM_HISTORY_LINE HL
                    , HRM_PERSON_MASTER PM
                WHERE HL.PERSON_ID        = PM.PERSON_ID
                  AND HL.HISTORY_LINE_ID  
                        IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                              FROM HRM_HISTORY_LINE S_HL
                             WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                               AND S_HL.PERSON_ID              = HL.PERSON_ID
                             GROUP BY S_HL.PERSON_ID
                           )
                  AND PM.PERSON_ID         = DL.PERSON_ID
                  AND PM.CORP_ID           = DL.CORP_ID
                  AND PM.SOB_ID            = DL.SOB_ID
                  AND PM.ORG_ID            = DL.ORG_ID
                  AND HL.FLOOR_ID          = NVL(W_FLOOR_ID, HL.FLOOR_ID)
                  AND HL.JOB_CATEGORY_ID   = NVL(W_JOB_CATEGORY_ID, HL.JOB_CATEGORY_ID)
              )
	      ;
		EXCEPTION WHEN OTHERS THEN
		  V_CLOSE_COUNT := 0;
		END;
		IF V_CLOSE_COUNT = 0 THEN
      O_STATUS := 'F';
		  O_MESSAGE := ERRNUMS.Data_Closed_Code || ' ' || ERRNUMS.Data_closed_Desc;
			RETURN;
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
      O_STATUS := 'F';
		  O_MESSAGE := ERRNUMS.Data_Not_Found_Code || ' ' || ERRNUMS.Data_Not_Found_Desc;
      RETURN;
		END;
    
	  BEGIN
		  UPDATE HRD_DAY_LEAVE DL
			  SET ( DL.DUTY_ID, DL.HOLY_TYPE
						, DL.OPEN_TIME, DL.CLOSE_TIME, DL.OPEN_TIME1, DL.CLOSE_TIME1
						, DL.NEXT_DAY_YN, DL.DANGJIK_YN, DL.ALL_NIGHT_YN
			      , DL.LAST_UPDATE_DATE, DL.LAST_UPDATED_BY			
			      ) = 
						( SELECT DI.DUTY_ID AS DUTY_ID                      
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
                       WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                       ELSE DI.CLOSE_TIME1
                     END AS CLOSE_TIME1
									 , DI.NEXT_DAY_YN
									 , NVL(DI.DANGJIK_YN, 'N') AS DANGJIK_YN
									 , NVL(DI.ALL_NIGHT_YN, 'N') AS ALL_NIGHT_YN
									 , V_SYSDATE, P_USER_ID
							FROM HRD_DAY_INTERFACE_V DI
								, (-- 시점 인사내역.
										SELECT HL.PERSON_ID
												, HL.DEPT_ID
												, HL.POST_ID
												, HL.JOB_CATEGORY_ID
												, HL.FLOOR_ID
										FROM HRM_HISTORY_LINE HL
										WHERE HL.HISTORY_LINE_ID  
                            IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                  FROM HRM_HISTORY_LINE S_HL
                                 WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                                   AND S_HL.PERSON_ID              = HL.PERSON_ID
                                 GROUP BY S_HL.PERSON_ID
                               )
									) T1
								, HRD_DAY_MODIFY I_DM
								, HRD_DAY_MODIFY O_DM
                , (-- 후일 근무 정보 조회. 
                  SELECT DIT.WORK_DATE - 1 AS WORK_DATE
                       , DIT.PERSON_ID
                       , DIT.SOB_ID
                       , DIT.ORG_ID
                       , DIT.OPEN_TIME
                       , DIT.CLOSE_TIME
                       , DIT.OPEN_TIME1
                       , DIT.CLOSE_TIME1
                    FROM HRD_DAY_INTERFACE DIT
                  WHERE DIT.WORK_DATE     BETWEEN W_START_DATE AND W_END_DATE + 1
                    AND DIT.PERSON_ID     = NVL(W_PERSON_ID, DIT.PERSON_ID)
                    AND DIT.WORK_CORP_ID  = W_CORP_ID
                    AND DIT.SOB_ID        = W_SOB_ID
                    AND DIT.ORG_ID        = W_ORG_ID
                  ) N_DI
							WHERE DI.PERSON_ID                        = T1.PERSON_ID
								AND DI.PERSON_ID                        = I_DM.PERSON_ID(+)
								AND DI.WORK_DATE                        = I_DM.WORK_DATE(+)
								AND '1'                                 = I_DM.IO_FLAG(+)
								AND DI.PERSON_ID                        = O_DM.PERSON_ID(+)
								AND DI.WORK_DATE                        = O_DM.WORK_DATE(+)
								AND '2'                                 = O_DM.IO_FLAG(+)
								AND DI.WORK_DATE                        = N_DI.WORK_DATE(+)
                AND DI.PERSON_ID                        = N_DI.PERSON_ID(+)
                AND DI.SOB_ID                           = N_DI.SOB_ID(+)
                AND DI.ORG_ID                           = N_DI.ORG_ID(+)
								AND DI.WORK_DATE                        = DL.WORK_DATE
								AND DI.PERSON_ID                        = DL.PERSON_ID
								AND DI.SOB_ID                           = DL.SOB_ID
								AND DI.ORG_ID                           = DL.ORG_ID
						)		
			WHERE DL.PERSON_ID				                        = NVL(W_PERSON_ID, DL.PERSON_ID)
			  AND DL.WORK_DATE                                BETWEEN W_START_DATE AND W_END_DATE
				AND DL.WORK_CORP_ID                             = W_CORP_ID
				AND DL.SOB_ID                                   = W_SOB_ID
				AND DL.ORG_ID                                   = W_ORG_ID
        AND DL.CLOSED_YN                                = 'N'
				AND EXISTS 
              ( SELECT 'X'
                FROM HRD_DAY_INTERFACE DI
                  , HRD_WORK_CALENDAR WC
                  , (-- 시점 인사내역.
                      SELECT HL.PERSON_ID
                          , HL.DEPT_ID
                          , HL.POST_ID
                          , HL.JOB_CATEGORY_ID
                          , HL.FLOOR_ID
                      FROM HRM_HISTORY_LINE HL
                      WHERE HL.HISTORY_LINE_ID  
                              IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                    FROM HRM_HISTORY_LINE S_HL
                                   WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                                     AND S_HL.PERSON_ID              = HL.PERSON_ID
                                   GROUP BY S_HL.PERSON_ID
                                 )
                    ) T1
                WHERE DI.PERSON_ID                        = WC.PERSON_ID
                  AND DI.WORK_DATE                        = WC.WORK_DATE
                  AND DI.SOB_ID                           = WC.SOB_ID
                  AND DI.ORG_ID                           = WC.ORG_ID
                  AND DI.PERSON_ID                        = T1.PERSON_ID
                  AND DI.WORK_DATE                        = DL.WORK_DATE
                  AND DI.PERSON_ID                        = DL.PERSON_ID
                  AND DI.SOB_ID                           = DL.SOB_ID
                  AND DI.ORG_ID                           = DL.ORG_ID
                  AND WC.WORK_TYPE_ID                     = NVL(W_WORK_TYPE_ID, WC.WORK_TYPE_ID)
                  AND WC.HOLY_TYPE                        = NVL(W_HOLY_TYPE, WC.HOLY_TYPE)
                  AND T1.DEPT_ID                          = NVL(W_DEPT_ID, T1.DEPT_ID)
                  AND T1.FLOOR_ID                         = NVL(W_FLOOR_ID, T1.FLOOR_ID)
                  AND T1.JOB_CATEGORY_ID                  = NVL(W_JOB_CATEGORY_ID, T1.JOB_CATEGORY_ID)
              )
      ;
      
			-- 근태 ID : 결근에 대해 출근시간이 존재할 경우 출근으로 변경.
      UPDATE HRD_DAY_LEAVE DL
			  SET ( DL.DUTY_ID
			      ) = 
						( SELECT  CASE
                        WHEN HDL.HOLY_TYPE IN('0', '1') THEN
                          CASE
                            WHEN (NVL(B_WC.ALL_NIGHT_YN, 'N') = 'Y' OR NVL(B_WC.DANGJIK_YN, 'N') = 'Y')
                              AND (NVL(HDL.ALL_NIGHT_YN,'N') = 'Y' OR NVL(HDL.DANGJIK_YN,'N') = 'Y' OR HDL.HOLY_TYPE = '3') THEN V_PH_DUTY_ID   -- 전일철야/당직, 금일 철야
                            WHEN HDL.OPEN_TIME IS NOT NULL THEN V_PH_DUTY_ID                                                                                                                                              -- 휴일근무
                            WHEN HDL.HOLY_TYPE IN ('0') THEN V_NH_DUTY_ID                                                     -- 무휴일.
                            ELSE V_H_DUTY_ID                                                                                  -- 유휴일.
                          END
                        ELSE                                                                                                  -- 주간/야간
                          CASE
                            WHEN NVL(B_WC.ALL_NIGHT_YN, 'N') = 'Y' OR NVL(B_WC.DANGJIK_YN, 'N') = 'Y' THEN V_A_DUTY_ID        -- 전일철야/전일당직 정상근무
                            WHEN (NVL(B_WC.ALL_NIGHT_YN, 'N') = 'Y' OR NVL(B_WC.DANGJIK_YN, 'N') = 'Y')                       
                              AND (NVL(HDL.ALL_NIGHT_YN,'N') = 'Y' OR NVL(HDL.DANGJIK_YN,'N') = 'Y') THEN V_A_DUTY_ID         -- 전일철야/당직, 금일 철야
                            WHEN HDL.OPEN_TIME IS NOT NULL  THEN V_A_DUTY_ID                                                  -- 출근기록 있음
                            ELSE V_NA_DUTY_ID                                                                                 -- 출근기록 없음
                          END
                      END AS DUTY_ID
              FROM HRD_DAY_LEAVE HDL                
                , (-- 전일 근무 정보 조회. 
                  SELECT WC.WORK_DATE + 1 AS WORK_DATE
                       , WC.WORK_DATE AS REAL_WORK_DATE
                       , WC.PERSON_ID
                       , WC.SOB_ID
                       , WC.ORG_ID
                       , WC.DANGJIK_YN
                       , WC.ALL_NIGHT_YN
                       , WC.HOLY_TYPE
                    FROM HRD_WORK_CALENDAR WC
                  WHERE WC.WORK_DATE    BETWEEN W_START_DATE - 1 AND W_END_DATE
                    AND WC.PERSON_ID    = NVL(W_PERSON_ID, WC.PERSON_ID)
                    AND WC.WORK_CORP_ID = W_CORP_ID
                    AND WC.SOB_ID       = W_SOB_ID
                    AND WC.ORG_ID       = W_ORG_ID
                  ) B_WC
              WHERE HDL.PERSON_ID                       = B_WC.PERSON_ID(+)
                AND HDL.WORK_DATE                       = B_WC.WORK_DATE(+)
                AND HDL.SOB_ID                          = B_WC.SOB_ID(+)
                AND HDL.ORG_ID                          = B_WC.ORG_ID(+)
                AND HDL.WORK_DATE                       = DL.WORK_DATE
                AND HDL.PERSON_ID                       = DL.PERSON_ID
                AND HDL.SOB_ID                          = DL.SOB_ID
                AND HDL.ORG_ID                          = DL.ORG_ID
						)		
			WHERE DL.PERSON_ID				                        = NVL(W_PERSON_ID, DL.PERSON_ID)
			  AND DL.WORK_DATE                                BETWEEN W_START_DATE AND W_END_DATE
				AND DL.WORK_CORP_ID                             = W_CORP_ID
				AND DL.SOB_ID                                   = W_SOB_ID
				AND DL.ORG_ID                                   = W_ORG_ID
        AND DL.CLOSED_YN                                = 'N'
				AND EXISTS 
              ( SELECT 'X'
                FROM HRD_DAY_INTERFACE DI
                  , HRD_WORK_CALENDAR WC
                  , (-- 시점 인사내역.
                      SELECT HL.PERSON_ID
                          , HL.DEPT_ID
                          , HL.POST_ID
                          , HL.JOB_CATEGORY_ID
                          , HL.FLOOR_ID
                      FROM HRM_HISTORY_LINE HL
                      WHERE HL.HISTORY_LINE_ID  
                              IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                    FROM HRM_HISTORY_LINE S_HL
                                   WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                                     AND S_HL.PERSON_ID              = HL.PERSON_ID
                                   GROUP BY S_HL.PERSON_ID
                                 )
                    ) T1
                WHERE DI.PERSON_ID                        = WC.PERSON_ID
                  AND DI.WORK_DATE                        = WC.WORK_DATE
                  AND DI.SOB_ID                           = WC.SOB_ID
                  AND DI.ORG_ID                           = WC.ORG_ID
                  AND DI.PERSON_ID                        = T1.PERSON_ID
                  AND DI.WORK_DATE                        = DL.WORK_DATE
                  AND DI.PERSON_ID                        = DL.PERSON_ID
                  AND DI.SOB_ID                           = DL.SOB_ID
                  AND DI.ORG_ID                           = DL.ORG_ID
                  AND WC.WORK_TYPE_ID                     = NVL(W_WORK_TYPE_ID, WC.WORK_TYPE_ID)
                  AND WC.HOLY_TYPE                        = NVL(W_HOLY_TYPE, WC.HOLY_TYPE)
                  AND T1.DEPT_ID                          = NVL(W_DEPT_ID, T1.DEPT_ID)
                  AND T1.FLOOR_ID                         = NVL(W_FLOOR_ID, T1.FLOOR_ID)
                  AND T1.JOB_CATEGORY_ID                  = NVL(W_JOB_CATEGORY_ID, T1.JOB_CATEGORY_ID)
              )
      ;
      
      -- 출퇴근 조회 근태/동기화.
      UPDATE HRD_DAY_INTERFACE DI
        SET DI.DUTY_ID = ( SELECT DL.DUTY_ID
                             FROM HRD_DAY_LEAVE_V DL
                           WHERE DL.PERSON_ID     = DI.PERSON_ID
                             AND DL.WORK_DATE     = DI.WORK_DATE
                             AND DL.SOB_ID        = DI.SOB_ID
                             AND DL.ORG_ID        = DI.ORG_ID
                         )
      WHERE DI.WORK_DATE                          BETWEEN W_START_DATE AND W_END_DATE
			  AND DI.PERSON_ID				                  = NVL(W_PERSON_ID, DI.PERSON_ID)
				AND DI.WORK_CORP_ID                       = W_CORP_ID
				AND DI.SOB_ID                             = W_SOB_ID
				AND DI.ORG_ID                             = W_ORG_ID
				AND EXISTS 
              ( SELECT 'X'
                FROM HRD_DAY_LEAVE_V DLV
                  , (-- 시점 인사내역.
                      SELECT HL.PERSON_ID
                          , HL.DEPT_ID
                          , HL.POST_ID
                          , HL.JOB_CATEGORY_ID
                          , HL.FLOOR_ID
                      FROM HRM_HISTORY_LINE HL
                      WHERE HL.HISTORY_LINE_ID  
                              IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                    FROM HRM_HISTORY_LINE S_HL
                                   WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                                     AND S_HL.PERSON_ID              = HL.PERSON_ID
                                   GROUP BY S_HL.PERSON_ID
                                 )
                    ) T1
                WHERE DLV.PERSON_ID         = T1.PERSON_ID
                  AND DLV.WORK_DATE         = DI.WORK_DATE
                  AND DLV.PERSON_ID         = DI.PERSON_ID
                  AND DLV.SOB_ID            = DI.SOB_ID
                  AND DLV.ORG_ID            = DI.ORG_ID
                  AND DLV.WORK_TYPE_ID      = NVL(W_WORK_TYPE_ID, DLV.WORK_TYPE_ID)
                  AND DLV.HOLY_TYPE         = NVL(W_HOLY_TYPE, DLV.HOLY_TYPE)
                  AND T1.DEPT_ID            = NVL(W_DEPT_ID, T1.DEPT_ID)
                  AND T1.FLOOR_ID           = NVL(W_FLOOR_ID, T1.FLOOR_ID)
                  AND T1.JOB_CATEGORY_ID    = NVL(W_JOB_CATEGORY_ID, T1.JOB_CATEGORY_ID)
              )
      ;
		EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
      RETURN;
		END;
    O_STATUS := 'S';
		O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10056', NULL);	
	END LEAVE_DATETIME_UPDATE;	

-- DAY_LEAVE_OT SAVE(INSERT/UPDATE).
  PROCEDURE DAY_LEAVE_OT_SAVE
	          ( P_DAY_LEAVE_ID                      IN HRD_DAY_LEAVE_OT.DAY_LEAVE_ID%TYPE
            , P_OT_TYPE                           IN HRD_DAY_LEAVE_OT.OT_TYPE%TYPE
            , P_OT_TIME                           IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
            , P_PERSON_ID                         IN HRD_DAY_LEAVE_OT.PERSON_ID%TYPE
						, P_WORK_DATE                         IN HRD_DAY_LEAVE_OT.WORK_DATE%TYPE
						, P_CORP_ID                           IN HRD_DAY_LEAVE_OT.CORP_ID%TYPE
						, P_SOB_ID                            IN HRD_DAY_LEAVE_OT.SOB_ID%TYPE
						, P_ORG_ID                            IN HRD_DAY_LEAVE_OT.ORG_ID%TYPE
						, P_USER_ID                           IN HRD_DAY_LEAVE_OT.CREATED_BY%TYPE
						)
  AS
    V_SYSDATE       HRD_DAY_LEAVE_OT.CREATION_DATE%TYPE := GET_LOCAL_DATE(P_SOB_ID);
    V_RE            NUMBER := 0;

  BEGIN
    IF P_OT_TIME > 0 THEN
      SELECT COUNT(X.DAY_LEAVE_ID) AS COUNT
       INTO V_RE
      FROM HRD_DAY_LEAVE_OT X
      WHERE X.DAY_LEAVE_ID  = P_DAY_LEAVE_ID
        AND X.OT_TYPE       = P_OT_TYPE
       ;
--DBMS_OUTPUT.PUT_LINE('ID : ' || P_DAY_LEAVE_ID || ', OT TYPE : ' || P_OT_TYPE || '레코드 수 : ' || V_RE);

      INSERT INTO HRD_DAY_LEAVE_OT
      ( DAY_LEAVE_ID
      , OT_TYPE, OT_TIME
      , PERSON_ID, WORK_DATE, CORP_ID
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY
      , LAST_UPDATE_DATE, LAST_UPDATED_BY
      ) VALUES
      ( P_DAY_LEAVE_ID
      , P_OT_TYPE, NVL(P_OT_TIME, 0)
      , P_PERSON_ID, P_WORK_DATE, P_CORP_ID
      , P_SOB_ID, P_ORG_ID
      , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
      );
    END IF;

  END DAY_LEAVE_OT_SAVE;

END HRD_DAY_LEAVE_G_SET; 
/
