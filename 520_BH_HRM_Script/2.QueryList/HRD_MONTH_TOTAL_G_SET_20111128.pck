CREATE OR REPLACE PACKAGE HRD_MONTH_TOTAL_G_SET
AS

-- 월근태 집계 MAIN.
  PROCEDURE SET_MAIN
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
						, W_DEPT_ID                           IN HRD_MONTH_TOTAL.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_WORK_DATE_FR                      IN DATE
            , P_WORK_DATE_TO                      IN DATE
            , P_EXCEPT_YN                         IN VARCHAR2
            , P_CONNECT_PERSON_ID                 IN NUMBER
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            );
            
-- 월근태 집계 처리 : 근태 예외 처리자 처리(베트남 주재원).
  PROCEDURE MONTH_TOTAL_EXCEPTION_GO
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
            , W_MONTH_START_DATE                  IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_MONTH_END_DATE                    IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_DEPT_ID                           IN HRD_MONTH_TOTAL.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_WORK_DATE_FR                      IN DATE
            , P_WORK_DATE_TO                      IN DATE
            , P_EXCEPT_YN                         IN VARCHAR2
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            );
            
-- 월근태 집계 처리.
  PROCEDURE MONTH_TOTAL_GO
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
            , W_MONTH_START_DATE                  IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_MONTH_END_DATE                    IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_DEPT_ID                           IN HRD_MONTH_TOTAL.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_WORK_DATE_FR                      IN DATE
            , P_WORK_DATE_TO                      IN DATE
            , P_EXCEPT_YN                         IN VARCHAR2
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            );

-- 월근태 잔업 집계 처리.
  PROCEDURE MONTH_TOTAL_OT_GO
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
            , W_WORK_CORP_ID                      IN HRD_MONTH_TOTAL.WORK_CORP_ID%TYPE
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE						
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            );

-- 월근태 근태 집계 처리.
  PROCEDURE MONTH_TOTAL_DUTY_GO
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE						
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            );

-- 월근태 주휴공제 계산 : 입사일자에 대한 주휴공제 계산.
  FUNCTION JOIN_DATE_WEEK_DED_F
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE						
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            ) RETURN NUMBER;

-- 지각/조퇴 4H 이상자에 대한 주휴공제 계산.
  FUNCTION LATE_TIME_WEEK_DED_F
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE						
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            ) RETURN NUMBER;
            
-- 월근태 주휴공제 계산.
  FUNCTION MONTH_TOTAL_WEEK_DED_F
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE						
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            ) RETURN NUMBER;  

-- TOT_DED_COUNT ==> CAL.
  PROCEDURE TOT_DED_COUNT_P
	          ( W_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
						, P_LATE_DED_COUNT                    IN HRD_MONTH_TOTAL.LATE_DED_COUNT%TYPE
						, P_WEEKLY_DED_COUNT                  IN HRD_MONTH_TOTAL.WEEKLY_DED_COUNT%TYPE
						, O_TOTAL_DED_COUNT                   OUT HRD_MONTH_TOTAL.TOTAL_DED_DAY%TYPE
						, O_PAY_DAY                           OUT HRD_MONTH_TOTAL.PAY_DAY%TYPE
						);
											
-- 무급일수.
  FUNCTION NON_PAY_DAY_F
            ( W_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
            ) RETURN NUMBER;

---------------------------------------------------------------------------------------------------
-- 연장근무시간 합계 저장.
  PROCEDURE SAVE_OT_TIME
            ( P_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
            , P_OT_TYPE                           IN HRD_MONTH_TOTAL_OT.OT_TYPE%TYPE
            , P_OT_TIME                           IN HRD_MONTH_TOTAL_OT.OT_TIME%TYPE
            , P_PERSON_ID                         IN HRD_MONTH_TOTAL_OT.PERSON_ID%TYPE
            , P_DUTY_TYPE                         IN HRD_MONTH_TOTAL_OT.DUTY_TYPE%TYPE
            , P_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL_OT.DUTY_YYYYMM%TYPE
            , P_WORK_CORP_ID                      IN HRD_MONTH_TOTAL_OT.WORK_CORP_ID%TYPE
            , P_CORP_ID                           IN HRD_MONTH_TOTAL_OT.CORP_ID%TYPE
            , P_SOB_ID                            IN HRD_MONTH_TOTAL_OT.SOB_ID%TYPE
            , P_ORG_ID                            IN HRD_MONTH_TOTAL_OT.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_MONTH_TOTAL_OT.CREATED_BY%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 월근태 마감여부.
  FUNCTION MONTH_TOTAL_CLOSED_FLAG
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
						, W_DEPT_ID                           IN HRD_MONTH_TOTAL.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_EXCEPT_YN                         IN VARCHAR2
            ) RETURN VARCHAR2;
            
---------------------------------------------------------------------------------------------------
-- 월근태 마감처리.
  PROCEDURE SET_CLOSED_MONTH_TOTAL
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
						, W_DEPT_ID                           IN HRD_MONTH_TOTAL.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_EXCEPT_YN                         IN VARCHAR2
            , P_CONNECT_PERSON_ID                 IN NUMBER
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            );

-- 월근태 마감처리 취소.
  PROCEDURE SET_CANCEL_CLOSED_MONTH_TOTAL
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
						, W_DEPT_ID                           IN HRD_MONTH_TOTAL.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_EXCEPT_YN                         IN VARCHAR2
            , P_CONNECT_PERSON_ID                 IN NUMBER
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            );
            
END HRD_MONTH_TOTAL_G_SET;

 
/
CREATE OR REPLACE PACKAGE BODY HRD_MONTH_TOTAL_G_SET
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_MONTH_TOTAL_G_SET
/* DESCRIPTION  : 월근태 집계.
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
  
-- 월근태 집계 MAIN.
  PROCEDURE SET_MAIN
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
            , W_DEPT_ID                           IN HRD_MONTH_TOTAL.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_WORK_DATE_FR                      IN DATE
            , P_WORK_DATE_TO                      IN DATE
            , P_EXCEPT_YN                         IN VARCHAR2
            , P_CONNECT_PERSON_ID                 IN NUMBER
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    V_CLOSED_FLAG                                 VARCHAR2(10) := 'N';
    V_MONTH_START_DATE                            HRD_DAY_LEAVE.WORK_DATE%TYPE;   -- MONTH_START_DATE.
		V_MONTH_END_DATE                              HRD_DAY_LEAVE.WORK_DATE%TYPE;   -- MONTH_END_DATE.
    V_CAP_C                                       VARCHAR2(1) := 'N';
  BEGIN
    O_STATUS := 'F';
    
    -- 해당 근태년월 기간.
    BEGIN
		  HRM_COMMON_DATE_G.YYYYMM_TERM_P
        ( W_YYYYMM => W_DUTY_YYYYMM
        , W_WORK_TERM_TYPE => W_DUTY_TYPE
        , W_JOB_CATEGORY_CODE => NULL
        , W_SOB_ID => W_SOB_ID
        , W_ORG_ID => W_ORG_ID
        , O_START_DATE => V_MONTH_START_DATE
        , O_END_DATE => V_MONTH_END_DATE
        );
		EXCEPTION WHEN OTHERS THEN
		  V_MONTH_START_DATE := TRUNC(TO_DATE(W_DUTY_YYYYMM, 'YYYY-MM'), 'MONTH');
			V_MONTH_END_DATE := ADD_MONTHS(V_MONTH_START_DATE, 1) - 1;
		END;
    
    -- 처리 권한체크 --
    BEGIN
      V_CAP_C := HRM_MANAGER_G.USER_CAP_F
                   ( W_CORP_ID
                   , TRUNC(V_MONTH_START_DATE)
                   , TRUNC(V_MONTH_END_DATE)
                   , '20'
                   , P_CONNECT_PERSON_ID
                   , W_SOB_ID
                   , W_ORG_ID);
    EXCEPTION WHEN OTHERS THEN
      V_CAP_C := 'N';
    END;
    IF V_CAP_C <> 'C' THEN
      O_STATUS := 'F';
      O_MESSAGE := ERRNUMS.Approval_Nothing_Code || ' ' || ERRNUMS.Approval_Nothing_Desc;
      RETURN;
    END IF;
    
    -- 마감 여부 체크하여 마감(Trans_yn = 'y')된 자료이면 집계 안함.
		V_CLOSED_FLAG := HRM_CLOSING_G.CLOSING_CHECK
                       ( W_CORP_ID => W_CORP_ID
                        , W_CLOSING_YYYYMM => W_DUTY_YYYYMM
                        , W_CLOSING_TYPE_ID => 0
                        , W_CLOSING_TYPE => W_DUTY_TYPE
                        , W_SOB_ID => W_SOB_ID
                        , W_ORG_ID => W_ORG_ID
                        );
   
    IF V_CLOSED_FLAG <> 'N' THEN
      O_STATUS := 'F';
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10052', NULL);
      RETURN;
    END IF;
    
    V_CLOSED_FLAG := MONTH_TOTAL_CLOSED_FLAG
                       ( W_CORP_ID => W_CORP_ID
                        , W_DUTY_TYPE => W_DUTY_TYPE
                        , W_DUTY_YYYYMM => W_DUTY_YYYYMM
                        , W_DEPT_ID => W_DEPT_ID
                        , W_FLOOR_ID => W_FLOOR_ID
                        , W_PERSON_ID => W_PERSON_ID
                        , W_SOB_ID => W_SOB_ID
                        , W_ORG_ID => W_ORG_ID
                        , P_EXCEPT_YN => P_EXCEPT_YN
                        );
   
    IF V_CLOSED_FLAG <> 'N' THEN
      O_STATUS := 'F';
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10052', NULL);
      RETURN;
    END IF;
    
		-- 기존자료 DELETE.
		BEGIN
      -- 월근태 잔업 삭제.
      DELETE FROM HRD_MONTH_TOTAL_OT MTO
      WHERE EXISTS( SELECT 'X'
                      FROM HRD_MONTH_TOTAL MT
                        , HRM_PERSON_MASTER PM
                    WHERE MT.PERSON_ID           = PM.PERSON_ID
                      AND MT.MONTH_TOTAL_ID      = MTO.MONTH_TOTAL_ID
                      AND MT.PERSON_ID           = NVL(W_PERSON_ID, MT.PERSON_ID)
                      AND MT.DUTY_TYPE           = W_DUTY_TYPE
                      AND MT.DUTY_YYYYMM         = W_DUTY_YYYYMM
                      AND MT.WORK_CORP_ID        = W_CORP_ID
                      AND MT.SOB_ID              = W_SOB_ID
                      AND MT.ORG_ID              = W_ORG_ID
                      AND MT.CLOSED_YN           = 'N'
                      AND PM.FLOOR_ID            = NVL(W_FLOOR_ID, PM.FLOOR_ID)
                      AND PM.DEPT_ID             = NVL(W_DEPT_ID, PM.DEPT_ID)
                  );
                  
      -- 월근태 근태 삭제.
      DELETE FROM HRD_MONTH_TOTAL_DUTY MTD
      WHERE EXISTS( SELECT 'X'
                      FROM HRD_MONTH_TOTAL MT
                        , HRM_PERSON_MASTER PM
                    WHERE MT.PERSON_ID           = PM.PERSON_ID
                      AND MT.MONTH_TOTAL_ID      = MTD.MONTH_TOTAL_ID
                      AND MT.PERSON_ID           = NVL(W_PERSON_ID, MT.PERSON_ID)
                      AND MT.DUTY_TYPE           = W_DUTY_TYPE
                      AND MT.DUTY_YYYYMM         = W_DUTY_YYYYMM
                      AND MT.WORK_CORP_ID        = W_CORP_ID
                      AND MT.SOB_ID              = W_SOB_ID
                      AND MT.ORG_ID              = W_ORG_ID
                      AND MT.CLOSED_YN           = 'N'
                      AND PM.FLOOR_ID            = NVL(W_FLOOR_ID, PM.FLOOR_ID)
                      AND PM.DEPT_ID             = NVL(W_DEPT_ID, PM.DEPT_ID)
                  );
      
      -- 주휴공제 삭제.
      DELETE FROM HRD_WEEKLY_DED WD
      WHERE WD.WORK_DATE           BETWEEN P_WORK_DATE_FR AND P_WORK_DATE_TO
				AND WD.WORK_CORP_ID        = W_CORP_ID
				AND WD.SOB_ID              = W_SOB_ID
				AND WD.ORG_ID              = W_ORG_ID
        AND EXISTS( SELECT 'X'
                      FROM HRD_MONTH_TOTAL MT
                        , HRM_PERSON_MASTER PM
                    WHERE MT.PERSON_ID           = PM.PERSON_ID
                      AND MT.PERSON_ID           = WD.PERSON_ID
                      AND MT.PERSON_ID           = NVL(W_PERSON_ID, MT.PERSON_ID)
                      AND MT.DUTY_TYPE           = W_DUTY_TYPE
                      AND MT.DUTY_YYYYMM         = W_DUTY_YYYYMM
                      AND MT.WORK_CORP_ID        = W_CORP_ID
                      AND MT.SOB_ID              = W_SOB_ID
                      AND MT.ORG_ID              = W_ORG_ID
                      AND MT.CLOSED_YN           = 'N'
                      AND PM.FLOOR_ID            = NVL(W_FLOOR_ID, PM.FLOOR_ID)
                      AND PM.DEPT_ID             = NVL(W_DEPT_ID, PM.DEPT_ID)
                  );
                  
      -- 월근태 삭제.
		  DELETE FROM HRD_MONTH_TOTAL MT
			WHERE MT.PERSON_ID           = NVL(W_PERSON_ID, MT.PERSON_ID)
			  AND MT.DUTY_TYPE           = W_DUTY_TYPE
				AND MT.DUTY_YYYYMM         = W_DUTY_YYYYMM
				AND MT.WORK_CORP_ID        = W_CORP_ID
				AND MT.SOB_ID              = W_SOB_ID
				AND MT.ORG_ID              = W_ORG_ID
        AND MT.CLOSED_YN           = 'N'
				AND EXISTS 
              ( SELECT 'X'
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID      = MT.PERSON_ID
                  AND PM.CORP_ID        = MT.CORP_ID
                  AND PM.SOB_ID         = MT.SOB_ID
                  AND PM.ORG_ID         = MT.ORG_ID
                  AND PM.FLOOR_ID       = NVL(W_FLOOR_ID, PM.FLOOR_ID)
                  AND PM.DEPT_ID        = NVL(W_DEPT_ID, PM.DEPT_ID)
             )
      ;
		EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
		  O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
      RETURN;
		END;
    -- 월근태 집계 처리 프로시져 호출.
    MONTH_TOTAL_GO 
      ( W_CORP_ID => W_CORP_ID
      , W_DUTY_TYPE => W_DUTY_TYPE
      , W_DUTY_YYYYMM => W_DUTY_YYYYMM
      , W_MONTH_START_DATE => V_MONTH_START_DATE
      , W_MONTH_END_DATE => V_MONTH_END_DATE
      , W_DEPT_ID => W_DEPT_ID
      , W_FLOOR_ID => W_FLOOR_ID
      , W_PERSON_ID => W_PERSON_ID
      , W_SOB_ID => W_SOB_ID
      , W_ORG_ID => W_ORG_ID
      , P_WORK_DATE_FR => P_WORK_DATE_FR
      , P_WORK_DATE_TO => P_WORK_DATE_TO
      , P_EXCEPT_YN => P_EXCEPT_YN
      , P_USER_ID => P_USER_ID
      , O_STATUS => O_STATUS
      , O_MESSAGE => O_MESSAGE
      );
		IF O_STATUS = 'F' THEN
      RETURN;
    END IF;
    -- 월근태 예외 처리자 처리(베트남 주재원) 집계 처리 프로시져 호출.
    MONTH_TOTAL_EXCEPTION_GO 
      ( W_CORP_ID => W_CORP_ID
      , W_DUTY_TYPE => W_DUTY_TYPE
      , W_DUTY_YYYYMM => W_DUTY_YYYYMM
      , W_MONTH_START_DATE => V_MONTH_START_DATE
      , W_MONTH_END_DATE => V_MONTH_END_DATE
      , W_DEPT_ID => W_DEPT_ID
      , W_FLOOR_ID => W_FLOOR_ID
      , W_PERSON_ID => W_PERSON_ID
      , W_SOB_ID => W_SOB_ID
      , W_ORG_ID => W_ORG_ID
      , P_WORK_DATE_FR => P_WORK_DATE_FR
      , P_WORK_DATE_TO => P_WORK_DATE_TO
      , P_EXCEPT_YN => P_EXCEPT_YN
      , P_USER_ID => P_USER_ID
      , O_STATUS => O_STATUS
      , O_MESSAGE => O_MESSAGE
      );  
    IF O_STATUS = 'F' THEN
      RETURN;
    END IF;
    O_STATUS := 'S'; 
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10060', NULL); 
  END SET_MAIN;

-- 월근태 집계 처리 : 근태 예외 처리자 처리(베트남 주재원).
  PROCEDURE MONTH_TOTAL_EXCEPTION_GO
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
            , W_MONTH_START_DATE                  IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_MONTH_END_DATE                    IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_DEPT_ID                           IN HRD_MONTH_TOTAL.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_WORK_DATE_FR                      IN DATE
            , P_WORK_DATE_TO                      IN DATE
            , P_EXCEPT_YN                         IN VARCHAR2
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    -- 월근태 집계 대상 CURSOR.
    CURSOR C_MONTH
           ( W_HOLY_0_DED_FLAG                    HRD_MONTH_TOTAL.HOLY_0_DED_FLAG%TYPE
           )
    IS
    SELECT PM.PERSON_ID
        , W_DUTY_YYYYMM AS DUTY_YYYYMM
        , PM.WORK_CORP_ID
        , PM.CORP_ID
        , T1.DEPT_ID
        , T1.POST_ID
        , T1.JOB_CATEGORY_ID
        , PM.ORI_JOIN_DATE
        , PM.JOIN_DATE
        , PM.RETIRE_DATE
        , PM.SOB_ID
        , PM.ORG_ID
        , CASE
            WHEN NVL(PM.RETIRE_DATE, W_MONTH_END_DATE) < W_MONTH_END_DATE THEN 'R'
            WHEN W_MONTH_START_DATE < NVL(PM.JOIN_DATE, PM.ORI_JOIN_DATE) THEN 'I'
            ELSE 'N'
          END AS EXCEPT_TYPE
        , ( SELECT COUNT(WD.HOLY_TYPE) AS HOLY_0_CNT
              FROM HRD_WORK_DATE_GT WD
            WHERE WD.WORK_DATE      BETWEEN CASE
                                              WHEN PM.JOIN_DATE > W_MONTH_START_DATE THEN PM.JOIN_DATE
                                              ELSE W_MONTH_START_DATE 
                                            END
                                        AND CASE 
                                              WHEN PM.RETIRE_DATE IS NOT NULL AND PM.RETIRE_DATE < W_MONTH_END_DATE THEN PM.RETIRE_DATE
                                              ELSE W_MONTH_END_DATE
                                            END
              AND WD.HOLY_TYPE      = 0
           ) AS HOLY_0_CNT
        , ( SELECT COUNT(WD.HOLY_TYPE) AS HOLY_0_CNT
              FROM HRD_WORK_DATE_GT WD
            WHERE WD.WORK_DATE      BETWEEN CASE
                                              WHEN PM.JOIN_DATE > W_MONTH_START_DATE THEN PM.JOIN_DATE
                                              ELSE W_MONTH_START_DATE 
                                            END
                                        AND CASE 
                                              WHEN PM.RETIRE_DATE IS NOT NULL AND PM.RETIRE_DATE < W_MONTH_END_DATE THEN PM.RETIRE_DATE
                                              ELSE W_MONTH_END_DATE
                                            END
              AND WD.HOLY_TYPE      = 1
           ) AS HOLY_1_CNT
        , ( SELECT COUNT(WD.HOLY_TYPE) AS HOLY_0_CNT
              FROM HRD_WORK_DATE_GT WD
            WHERE WD.WORK_DATE      BETWEEN CASE
                                              WHEN PM.JOIN_DATE > W_MONTH_START_DATE THEN PM.JOIN_DATE
                                              ELSE W_MONTH_START_DATE 
                                            END
                                        AND CASE 
                                              WHEN PM.RETIRE_DATE IS NOT NULL AND PM.RETIRE_DATE < W_MONTH_END_DATE THEN PM.RETIRE_DATE
                                              ELSE W_MONTH_END_DATE
                                            END
              AND WD.HOLY_TYPE      = 2
           ) AS HOLY_2_CNT
        , ( SELECT COUNT(WD.HOLY_TYPE) AS HOLY_0_CNT
              FROM HRD_WORK_DATE_GT WD
            WHERE WD.WORK_DATE      BETWEEN CASE
                                              WHEN PM.JOIN_DATE > W_MONTH_START_DATE THEN PM.JOIN_DATE
                                              ELSE W_MONTH_START_DATE 
                                            END
                                        AND CASE 
                                              WHEN PM.RETIRE_DATE IS NOT NULL AND PM.RETIRE_DATE < W_MONTH_END_DATE THEN PM.RETIRE_DATE
                                              ELSE W_MONTH_END_DATE
                                            END
              AND WD.HOLY_TYPE      = 3
           ) AS HOLY_3_CNT
         , ( SELECT COUNT(WD.HOLY_TYPE) AS HOLY_0_CNT
              FROM HRD_WORK_DATE_GT WD
            WHERE WD.WORK_DATE      BETWEEN CASE
                                              WHEN PM.JOIN_DATE > W_MONTH_START_DATE THEN PM.JOIN_DATE
                                              ELSE W_MONTH_START_DATE 
                                            END
                                        AND CASE 
                                              WHEN PM.RETIRE_DATE IS NOT NULL AND PM.RETIRE_DATE < W_MONTH_END_DATE THEN PM.RETIRE_DATE
                                              ELSE W_MONTH_END_DATE
                                            END
              AND WD.HOLY_TYPE      IN(2, 3)
           ) AS TOTAL_ATT_DAY
      FROM HRM_PERSON_MASTER PM
         , (-- 시점 인사내역.
            SELECT HL.PERSON_ID
                , HL.DEPT_ID
                , HL.POST_ID
                , HL.JOB_CATEGORY_ID
                , HL.FLOOR_ID
              FROM HRM_HISTORY_LINE HL
            WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                            FROM HRM_HISTORY_LINE S_HL
                                           WHERE S_HL.CHARGE_DATE            <= W_MONTH_END_DATE
                                             AND S_HL.PERSON_ID              = HL.PERSON_ID
                                           GROUP BY S_HL.PERSON_ID
                                         )
            ) T1
    WHERE PM.PERSON_ID              = T1.PERSON_ID  
      AND PM.JOIN_DATE              <= W_MONTH_END_DATE
      AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_MONTH_START_DATE )
      AND PM.PERSON_ID              = NVL(W_PERSON_ID, PM.PERSON_ID)
      AND PM.WORK_CORP_ID           = W_CORP_ID
      AND PM.SOB_ID                 = W_SOB_ID
      AND PM.ORG_ID                 = W_ORG_ID
      AND T1.FLOOR_ID               = NVL(W_FLOOR_ID, T1.FLOOR_ID)
      AND T1.DEPT_ID                = NVL(W_DEPT_ID, T1.DEPT_ID)
      /*AND ((P_EXCEPT_YN             = 'N'
      AND 1                         = 1)
      OR  (P_EXCEPT_YN              = 'Y'
      AND CASE
            WHEN NVL(PM.RETIRE_DATE, W_MONTH_END_DATE) < W_MONTH_END_DATE THEN 'R'
            WHEN W_MONTH_START_DATE < NVL(PM.JOIN_DATE, PM.ORI_JOIN_DATE) THEN 'I'
            ELSE 'N'
          END                       IN('N', 'I')))*/
      AND EXISTS
            ( SELECT DM.DEPT_ID
                FROM HRM_DEPT_MASTER DM
              WHERE DM.DEPT_ID   = T1.DEPT_ID
                AND DM.SOB_ID    = PM.SOB_ID
                AND DM.DEPT_CODE IN('7S0000','7S1000')
            )  -- 베트남 주재원.
    ;

    V_SYSDATE                                     HRD_MONTH_TOTAL.CREATION_DATE%TYPE;
    V_START_DATE                                  HRD_DAY_LEAVE.WORK_DATE%TYPE;
    V_END_DATE                                    HRD_DAY_LEAVE.WORK_DATE%TYPE;
    V_MONTH_TOTAL_ID                              HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE;
    V_TOTAL_DAY                                   HRD_MONTH_TOTAL.TOTAL_DAY%TYPE;
    V_WEEK_DED_COUNT                              NUMBER := 0;
    V_N1                                          NUMBER := 0;
    
    V_STD_HOLY_0_COUNT                            HRD_MONTH_TOTAL.STD_HOLY_0_COUNT%TYPE;
    V_HOLY_0_DED_FLAG                             HRD_MONTH_TOTAL.HOLY_0_DED_FLAG%TYPE;
    V_LATE_DED_FLAG                               HRM_CLOSING_TYPE_V.LATE_DED_FLAG%TYPE;
    V_LATE_STD_DAY                                HRM_CLOSING_TYPE_V.LATE_STD_DAY%TYPE;
    
  BEGIN
    -- SYSDATE.
    V_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
        
    -- HOLY_0 적용 어부.
    BEGIN
      SELECT NVL(MAX(CT.HOLY_0_FLAG), 'N') AS HOLY_0_FLAG
           , NVL(MAX(CT.LATE_DED_FLAG), 'N') AS LATE_DED_FLAG
           , NVL(MAX(CT.LATE_STD_DAY), 1) AS LATE_STD_DAY
        INTO V_HOLY_0_DED_FLAG
           , V_LATE_DED_FLAG
           , V_LATE_STD_DAY
        FROM HRM_CLOSING_TYPE_V CT
      WHERE CT.CLOSING_TYPE           = W_DUTY_TYPE
        AND CT.SOB_ID                 = W_SOB_ID
        AND CT.ORG_ID                 = W_ORG_ID
        AND CT.EFFECTIVE_DATE_FR      <= W_MONTH_END_DATE
        AND (CT.EFFECTIVE_DATE_TO IS NULL OR CT.EFFECTIVE_DATE_TO >= W_MONTH_START_DATE)
      GROUP BY CT.CLOSING_TYPE
      ;
    EXCEPTION WHEN OTHERS THEN
      V_HOLY_0_DED_FLAG := 'N';
    END;
    
    -- 근태 기간에 따른 달력 생성.
    DELETE FROM HRD_WORK_DATE_GT;           /*--> 임시테이블 DATA 삭제 <--*/
    
    /* -- 전호수 주석(2011. 11. 22)	
    BEGIN
      V_N1 := W_MONTH_END_DATE - W_MONTH_START_DATE + 1; 	
      FOR R1 IN 0 .. V_N1 - 1
      LOOP
        INSERT INTO HRD_WORK_DATE_GT
        ( WORK_DATE
        , WORK_WEEK
        , HOLIDAY_CHECK
        ) VALUES
        ( W_MONTH_START_DATE + R1
        , TO_CHAR(W_MONTH_START_DATE + R1, 'D')
        , HRD_HOLIDAY_CALENDAR_G.HOLIDAY_CHECK(W_MONTH_START_DATE + R1 , W_SOB_ID, W_ORG_ID)  
        );
      END LOOP C1;
      -- 근무유형 정의.
      UPDATE HRD_WORK_DATE_GT WD
        SET WD.HOLY_TYPE =  CASE
                              WHEN WD.HOLIDAY_CHECK IN('A', 'Y') THEN '1'    -- 공휴일 - 유휴일.
                              WHEN WD.WORK_WEEK IN('1') THEN '1'             -- 일요일 - 유휴일.
                              WHEN WD.WORK_WEEK IN('7') THEN '0'             -- 토요일 - 무휴일.
                              ELSE '2'                                       -- 정상근무.
                            END
      ;
    END;*/
    BEGIN
      V_N1 := P_WORK_DATE_TO - P_WORK_DATE_FR + 1;	
      FOR R1 IN 0 .. V_N1 - 1
      LOOP
        INSERT INTO HRD_WORK_DATE_GT
        ( WORK_DATE
        , WORK_WEEK
        , HOLIDAY_CHECK
        ) VALUES
        ( P_WORK_DATE_FR + R1
        , TO_CHAR(P_WORK_DATE_FR + R1, 'D')
        , HRD_HOLIDAY_CALENDAR_G.HOLIDAY_CHECK(P_WORK_DATE_FR + R1 , W_SOB_ID, W_ORG_ID)  
        );
      END LOOP C1;
      -- 근무유형 정의.
      UPDATE HRD_WORK_DATE_GT WD
        SET WD.HOLY_TYPE =  CASE
                              WHEN WD.HOLIDAY_CHECK IN('A', 'Y') THEN '1'    -- 공휴일 - 유휴일.
                              WHEN WD.WORK_WEEK IN('1') THEN '1'             -- 일요일 - 유휴일.
                              WHEN WD.WORK_WEEK IN('7') THEN '0'             -- 토요일 - 무휴일.
                              ELSE '2'                                       -- 정상근무.
                            END
      ;
    END;
    -- 기준 무급휴일수.
    V_STD_HOLY_0_COUNT := 0;
    BEGIN
      SELECT COUNT(WD.HOLY_TYPE) AS HOLY_0_COUNT
        INTO V_STD_HOLY_0_COUNT
        FROM HRD_WORK_DATE_GT WD
      WHERE WD.WORK_DATE              BETWEEN W_MONTH_START_DATE AND W_MONTH_END_DATE
        AND WD.HOLY_TYPE              = '0'
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
      
---------------------------------------------------------------------------------------------------    
    -- 월근태 내역 집계 및 INSERT.
    FOR C1 IN C_MONTH( W_HOLY_0_DED_FLAG => V_HOLY_0_DED_FLAG)
		LOOP
		  -- 초기화.
		  BEGIN
			  SELECT HRD_MONTH_TOTAL_S1.NEXTVAL
				  INTO V_MONTH_TOTAL_ID
				  FROM DUAL;
			EXCEPTION WHEN OTHERS THEN
			  V_MONTH_TOTAL_ID := 1;
			END;

      -- 입퇴사에 따른 시작/종료일자 설정.
      SELECT CASE
               WHEN C1.JOIN_DATE > P_WORK_DATE_FR THEN C1.JOIN_DATE
               ELSE P_WORK_DATE_FR 
             END AS START_DATE
           , CASE 
               WHEN C1.RETIRE_DATE IS NOT NULL AND C1.RETIRE_DATE < P_WORK_DATE_TO THEN C1.RETIRE_DATE
               ELSE P_WORK_DATE_TO
             END AS END_DATE
        INTO V_START_DATE, V_END_DATE
        FROM DUAL
        ;
			-- 월 총일수.
      V_TOTAL_DAY := 0;
      V_TOTAL_DAY := V_END_DATE - V_START_DATE + 1;
      IF V_TOTAL_DAY < 0 THEN
				V_TOTAL_DAY := 0;
			END IF;

---------------------------------------------------------------------------------------------------
--   주휴공제일수
      BEGIN
        V_WEEK_DED_COUNT :=  JOIN_DATE_WEEK_DED_F
                              ( W_CORP_ID => C1.WORK_CORP_ID
                              , W_START_DATE => V_START_DATE
                              , W_END_DATE => V_END_DATE
                              , W_PERSON_ID => C1.PERSON_ID
                              , W_SOB_ID => W_SOB_ID
                              , W_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              );
     	  
        INSERT INTO HRD_MONTH_TOTAL
        ( MONTH_TOTAL_ID
        , PERSON_ID, DUTY_TYPE, DUTY_YYYYMM
        , WORK_CORP_ID, CORP_ID, DEPT_ID, POST_ID, JOB_CATEGORY_ID
        , HOLIDAY_IN_COUNT
        , LATE_DED_COUNT
        , WEEKLY_DED_COUNT
        , HOLY_0_COUNT
        , HOLY_1_COUNT
        , HOLY_2_COUNT
        , HOLY_3_COUNT
        , TOTAL_DAY
        , TOTAL_ATT_DAY
        , TOTAL_DED_DAY
        , PAY_DAY
        , HOLY_0_DED_FLAG
        , STD_HOLY_0_COUNT
        , SOB_ID, ORG_ID
        , CREATION_DATE, CREATED_BY
        , LAST_UPDATE_DATE, LAST_UPDATED_BY
        , EXCEPT_TYPE
        , WORK_DATE_FR
        , WORK_DATE_TO
        )	VALUES
        ( V_MONTH_TOTAL_ID                              ---
        , C1.PERSON_ID, W_DUTY_TYPE, C1.DUTY_YYYYMM
        , C1.WORK_CORP_ID, C1.CORP_ID, C1.DEPT_ID, C1.POST_ID, C1.JOB_CATEGORY_ID
        , 0
        , 0                             ---
        , V_WEEK_DED_COUNT
        , C1.HOLY_0_CNT
        , C1.HOLY_1_CNT
        , C1.HOLY_2_CNT
        , C1.HOLY_3_CNT
        , V_TOTAL_DAY                                   ---
        , C1.TOTAL_ATT_DAY
        , NVL(V_WEEK_DED_COUNT, 0)
        , CASE 
            WHEN NVL(V_TOTAL_DAY, 0) - (NVL(C1.HOLY_0_CNT, 0) + NVL(V_WEEK_DED_COUNT, 0)) < 0 THEN 0
            ELSE NVL(V_TOTAL_DAY, 0) - (NVL(C1.HOLY_0_CNT, 0) + NVL(V_WEEK_DED_COUNT, 0))
          END
        , V_HOLY_0_DED_FLAG                            ---
        , V_STD_HOLY_0_COUNT
        , W_SOB_ID, W_ORG_ID
        , V_SYSDATE, P_USER_ID
        , V_SYSDATE, P_USER_ID
        , C1.EXCEPT_TYPE
        , P_WORK_DATE_FR
        , P_WORK_DATE_TO
        );
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
      END;
		END LOOP C1;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10060', NULL);
  END MONTH_TOTAL_EXCEPTION_GO;
  
-- 출퇴근 정리 및 집계 처리.
  PROCEDURE MONTH_TOTAL_GO
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
            , W_MONTH_START_DATE                  IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_MONTH_END_DATE                    IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_DEPT_ID                           IN HRD_MONTH_TOTAL.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_WORK_DATE_FR                      IN DATE
            , P_WORK_DATE_TO                      IN DATE
            , P_EXCEPT_YN                         IN VARCHAR2
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
	  -- 월근태 집계 대상 CURSOR.
	  CURSOR C_MONTH
		       ( W_HOLY_0_DED_FLAG                    HRD_MONTH_TOTAL.HOLY_0_DED_FLAG%TYPE
					 )
		IS
		SELECT DL.PERSON_ID, TO_CHAR(DL.WORK_DATE, 'YYYY-MM') AS DUTY_YYYYMM
				 , DL.WORK_CORP_ID, DL.CORP_ID, T1.DEPT_ID, T1.POST_ID
         , T1.JOB_CATEGORY_ID, T1.JOB_CATEGORY_CODE
				 , T1.ORI_JOIN_DATE, T1.JOIN_DATE, T1.RETIRE_DATE
         , T1.PAY_TYPE
         , T1.EXCEPT_TYPE
				 , SUM(DECODE(DL.HOLIDAY_CHECK, 'Y', 1, 0)) AS HOLIDAY_IN_COUNT
				 , NVL(SUM(CASE 
				             WHEN DC.DUTY_CODE IN('00', '51', '52', '53') AND DL.HOLY_TYPE = '0' THEN 1
                     WHEN DC.DUTY_CODE IN('52') THEN 1  -- 근태 : 무급휴일은 무급처리.
										 ELSE 0
									 END), 0) AS HOLY_0_COUNT
         , NVL(SUM(CASE 
                     WHEN DC.DUTY_CODE IN('00', '51', '52', '53') AND DL.HOLY_TYPE = '1' THEN 1
                     ELSE 0
                   END), 0) AS HOLY_1_COUNT
         , NVL(SUM(CASE 
                     WHEN DC.DUTY_CODE IN('51', '52', '53') THEN 0
                     WHEN DL.HOLY_TYPE = '2' THEN 1
                     ELSE 0
                   END), 0) AS HOLY_2_COUNT
         , NVL(SUM(CASE 
                     WHEN DC.DUTY_CODE IN('51', '52', '53') THEN 0
                     WHEN DL.HOLY_TYPE = '3' THEN 1
                     ELSE 0
                   END), 0) AS HOLY_3_COUNT
				 , NVL(SUM(DECODE(DC.WORK_YN, 'Y', 1, 0)), 0) AS TOTAL_ATT_DAY
				 , NVL(SUM(CASE
                    WHEN DC.DUTY_CODE = '11' THEN 1
                    WHEN DC.NON_PAY_DAY_FLAG = 'Y' THEN 1
                    ELSE 0
                   END), 0) AS TOTAL_DED_DAY
			FROM HRD_DAY_LEAVE_V DL
			   , HRM_DUTY_CODE_V DC
				 , (-- 시점 인사내역.
						SELECT HL.PERSON_ID
								, HL.DEPT_ID
								, HL.POST_ID
								, NVL(HL.JOB_CATEGORY_ID, PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_ID
                , HRM_COMMON_G.GET_CODE_F(NVL(HL.JOB_CATEGORY_ID, PM.JOB_CATEGORY_ID), PM.SOB_ID, PM.ORG_ID) AS JOB_CATEGORY_CODE
                , S1.PAY_TYPE
								, HL.FLOOR_ID    
								, PM.CORP_ID
								, PM.ORI_JOIN_DATE
                , PM.JOIN_DATE
								, PM.RETIRE_DATE
								, PM.SOB_ID
								, PM.ORG_ID
                , CASE
                    WHEN NVL(PM.RETIRE_DATE, W_MONTH_END_DATE) < W_MONTH_END_DATE THEN 'R'
                    WHEN W_MONTH_START_DATE < NVL(PM.JOIN_DATE, PM.ORI_JOIN_DATE) THEN 'I'
                    ELSE 'N'
                  END AS EXCEPT_TYPE
							FROM HRM_HISTORY_LINE HL  
								, HRM_PERSON_MASTER PM
                , ( -- 급여마스터.
                    SELECT PMH.PERSON_ID
                         , PMH.PAY_TYPE
                      FROM HRP_PAY_MASTER_HEADER PMH
                    WHERE PMH.CORP_ID         = W_CORP_ID
                      AND PMH.PERSON_ID       = NVL(W_PERSON_ID, PMH.PERSON_ID)
                      AND PMH.START_YYYYMM    <= W_DUTY_YYYYMM
                      AND PMH.END_YYYYMM      >= W_DUTY_YYYYMM
                      AND PMH.SOB_ID          = W_SOB_ID
                      AND PMH.ORG_ID          = W_ORG_ID
                  ) S1
						WHERE HL.PERSON_ID        = PM.PERSON_ID
              AND PM.PERSON_ID        = S1.PERSON_ID(+)
							AND HL.HISTORY_LINE_ID  
                    IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                          FROM HRM_HISTORY_LINE S_HL
                         WHERE S_HL.CHARGE_DATE            <= W_MONTH_END_DATE
                           AND S_HL.PERSON_ID              = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       )
						) T1
		WHERE DL.DUTY_ID                = DC.DUTY_ID
		  AND DL.SOB_ID                 = DC.SOB_ID
			AND DL.ORG_ID                 = DC.ORG_ID
		  AND DL.PERSON_ID              = T1.PERSON_ID
			AND DL.CORP_ID                = T1.CORP_ID
			AND DL.SOB_ID                 = T1.SOB_ID
			AND DL.ORG_ID                 = T1.ORG_ID
-- 중도 입/퇴사자의 경우 입퇴사일 사이만 적용.			
			AND DL.WORK_DATE              BETWEEN CASE
			                                        WHEN T1.JOIN_DATE > P_WORK_DATE_FR THEN T1.JOIN_DATE
			                                        ELSE P_WORK_DATE_FR 
																						END
																		    AND CASE 
																				      WHEN T1.RETIRE_DATE IS NOT NULL AND T1.RETIRE_DATE < P_WORK_DATE_TO THEN T1.RETIRE_DATE
																				      ELSE P_WORK_DATE_TO
																						END
			AND DL.PERSON_ID              = NVL(W_PERSON_ID, DL.PERSON_ID)
			AND DL.WORK_CORP_ID           = W_CORP_ID
			AND DL.SOB_ID                 = W_SOB_ID
			AND DL.ORG_ID                 = W_ORG_ID
      AND DL.CLOSED_YN              = 'Y'
			AND T1.FLOOR_ID               = NVL(W_FLOOR_ID, T1.FLOOR_ID)
			AND T1.DEPT_ID                = NVL(W_DEPT_ID, T1.DEPT_ID) 
			AND T1.JOIN_DATE              <= W_MONTH_END_DATE
			AND (T1.RETIRE_DATE IS NULL OR T1.RETIRE_DATE >= W_MONTH_START_DATE) 
      /*AND ((P_EXCEPT_YN          = 'N'
      AND 1                      = 1)
      OR  (P_EXCEPT_YN           = 'Y'
      AND T1.EXCEPT_TYPE         IN('N', 'I')))*/
      AND NOT EXISTS
            ( SELECT 'X'
                FROM HRD_MONTH_TOTAL MT
              WHERE MT.PERSON_ID      = DL.PERSON_ID
                AND MT.SOB_ID         = DL.SOB_ID
                AND MT.WORK_CORP_ID   = DL.WORK_CORP_ID
                AND MT.DUTY_TYPE      = W_DUTY_TYPE
                AND MT.DUTY_YYYYMM    = W_DUTY_YYYYMM
                AND MT.CLOSED_YN      = 'Y'            
            )
		GROUP BY DL.PERSON_ID
				 , TO_CHAR(DL.WORK_DATE, 'YYYY-MM')
         , DL.WORK_CORP_ID
				 , DL.CORP_ID
				 , T1.DEPT_ID
				 , T1.POST_ID
				 , T1.JOB_CATEGORY_ID
         , T1.JOB_CATEGORY_CODE
				 , T1.ORI_JOIN_DATE
         , T1.JOIN_DATE
         , T1.PAY_TYPE
				 , T1.RETIRE_DATE
         , T1.EXCEPT_TYPE
		;

    V_SYSDATE                                     HRD_MONTH_TOTAL.CREATION_DATE%TYPE;
    V_START_DATE                                  HRD_DAY_LEAVE.WORK_DATE%TYPE;
    V_END_DATE                                    HRD_DAY_LEAVE.WORK_DATE%TYPE;
		V_MONTH_TOTAL_ID                              HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE;
    V_TOTAL_DAY                                   HRD_MONTH_TOTAL.TOTAL_DAY%TYPE;
		V_LATE_DED_COUNT                              HRD_MONTH_TOTAL.LATE_DED_COUNT%TYPE;
	  V_WEEK_DED_COUNT                              HRD_MONTH_TOTAL.WEEKLY_DED_COUNT%TYPE := 0;    -- 주휴공제수.
    V_TOTAL_DED_DAY                               HRD_MONTH_TOTAL.TOTAL_DED_DAY%TYPE := 0;  -- 총공제일수.
    
    V_STD_HOLY_0_COUNT                            HRD_MONTH_TOTAL.STD_HOLY_0_COUNT%TYPE;
		V_HOLY_0_DED_FLAG                             HRD_MONTH_TOTAL.HOLY_0_DED_FLAG%TYPE;
		V_LATE_DED_FLAG                               HRM_CLOSING_TYPE_V.LATE_DED_FLAG%TYPE;
		V_LATE_STD_DAY                                HRM_CLOSING_TYPE_V.LATE_STD_DAY%TYPE;
		
  BEGIN
	  -- SYSDATE.
		V_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
				
		-- HOLY_0 적용 어부.
		BEGIN
		  SELECT NVL(MAX(CT.HOLY_0_FLAG), 'N') AS HOLY_0_FLAG
			     , NVL(MAX(CT.LATE_DED_FLAG), 'N') AS LATE_DED_FLAG
					 , NVL(MAX(CT.LATE_STD_DAY), 1) AS LATE_STD_DAY
			  INTO V_HOLY_0_DED_FLAG
				   , V_LATE_DED_FLAG
					 , V_LATE_STD_DAY
				FROM HRM_CLOSING_TYPE_V CT
			WHERE CT.CLOSING_TYPE           = W_DUTY_TYPE
			  AND CT.SOB_ID                 = W_SOB_ID
				AND CT.ORG_ID                 = W_ORG_ID
				AND CT.EFFECTIVE_DATE_FR      <= W_MONTH_END_DATE
				AND (CT.EFFECTIVE_DATE_TO IS NULL OR CT.EFFECTIVE_DATE_TO >= W_MONTH_START_DATE)
			GROUP BY CT.CLOSING_TYPE
		  ;
		EXCEPTION WHEN OTHERS THEN
		  V_HOLY_0_DED_FLAG := 'N';
		END;

---------------------------------------------------------------------------------------------------		
		-- 월근태 내역 집계 및 INSERT.
    FOR C1 IN C_MONTH( W_HOLY_0_DED_FLAG => V_HOLY_0_DED_FLAG)
		LOOP
		  -- 초기화.
		  BEGIN
			  SELECT HRD_MONTH_TOTAL_S1.NEXTVAL
				  INTO V_MONTH_TOTAL_ID
				  FROM DUAL;
			EXCEPTION WHEN OTHERS THEN
			  V_MONTH_TOTAL_ID := 1;
			END;
			
      -- 기준 무급휴일수.
      V_STD_HOLY_0_COUNT := 0;
      BEGIN
        SELECT COUNT(WC.HOLY_TYPE) AS HOLY_0_COUNT
          INTO V_STD_HOLY_0_COUNT
          FROM HRD_WORK_CALENDAR WC
        WHERE WC.WORK_DATE              BETWEEN P_WORK_DATE_FR AND P_WORK_DATE_TO
          AND WC.PERSON_ID              = C1.PERSON_ID
          AND WC.CORP_ID                = C1.CORP_ID
          AND WC.SOB_ID                 = W_SOB_ID
          AND WC.ORG_ID                 = W_ORG_ID
          AND WC.HOLY_TYPE              = '0'
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      
      -- 입퇴사에 따른 시작/종료일자 설정.
      SELECT CASE
               WHEN C1.JOIN_DATE > P_WORK_DATE_FR THEN C1.JOIN_DATE
               ELSE P_WORK_DATE_FR
             END AS START_DATE
           , CASE 
               WHEN C1.RETIRE_DATE IS NOT NULL AND C1.RETIRE_DATE < P_WORK_DATE_TO THEN C1.RETIRE_DATE
               ELSE P_WORK_DATE_TO
             END AS END_DATE
        INTO V_START_DATE, V_END_DATE
        FROM DUAL
        ;
			-- 월 총일수.
      V_TOTAL_DAY := 0;
      V_TOTAL_DAY := V_END_DATE - V_START_DATE + 1;
      IF V_TOTAL_DAY < 0 THEN
				V_TOTAL_DAY := 0;
			END IF;
      
---------------------------------------------------------------------------------------------------
      BEGIN
        -- 월근태 연장집계 적용.
        MONTH_TOTAL_OT_GO 
          ( W_CORP_ID => C1.CORP_ID
          , W_WORK_CORP_ID => C1.WORK_CORP_ID
          , W_DUTY_TYPE => W_DUTY_TYPE
          , W_DUTY_YYYYMM => C1.DUTY_YYYYMM
          , W_START_DATE => V_START_DATE
          , W_END_DATE => V_END_DATE
          , W_PERSON_ID => C1.PERSON_ID
          , W_SOB_ID => W_SOB_ID
          , W_ORG_ID => W_ORG_ID
          , P_MONTH_TOTAL_ID => V_MONTH_TOTAL_ID
          , P_USER_ID => P_USER_ID
          , O_STATUS => O_STATUS
          , O_MESSAGE => O_MESSAGE
          );
        IF O_STATUS = 'F' THEN
          RETURN;  
        END IF;
        
---------------------------------------------------------------------------------------------------
        -- 월근태 근태집계 적용.
        MONTH_TOTAL_DUTY_GO 
          ( W_CORP_ID => C1.WORK_CORP_ID
          , W_DUTY_TYPE => W_DUTY_TYPE
          , W_DUTY_YYYYMM => C1.DUTY_YYYYMM
          , W_START_DATE => V_START_DATE
          , W_END_DATE => V_END_DATE
          , W_PERSON_ID => C1.PERSON_ID
          , W_SOB_ID => W_SOB_ID
          , W_ORG_ID => W_ORG_ID
          , P_MONTH_TOTAL_ID => V_MONTH_TOTAL_ID
          , P_USER_ID => P_USER_ID
          );

---------------------------------------------------------------------------------------------------
        -- 주휴공제일수
        IF C1.PAY_TYPE IN ('1', '3') OR C1.JOB_CATEGORY_CODE = '10' THEN
        -- 월급직/연봉직은 제외.
          V_WEEK_DED_COUNT := 0;
        ELSE
          V_WEEK_DED_COUNT :=  MONTH_TOTAL_WEEK_DED_F
                                ( W_CORP_ID => C1.WORK_CORP_ID
                                , W_START_DATE => V_START_DATE
                                , W_END_DATE => V_END_DATE
                                , W_PERSON_ID => C1.PERSON_ID
                                , W_SOB_ID => W_SOB_ID
                                , W_ORG_ID => W_ORG_ID
                                , P_USER_ID => P_USER_ID
                                );
        END IF;
        
---------------------------------------------------------------------------------------------------
        -- 지조결근 계산/적용.
        V_LATE_DED_COUNT := 0;  
        IF V_LATE_DED_FLAG = 'Y' THEN
          BEGIN
            SELECT COUNT(DLO.OT_TIME) AS LATE_COUNT
              INTO V_LATE_DED_COUNT
              FROM HRD_DAY_LEAVE DL
                , HRD_DAY_LEAVE_OT DLO
             WHERE DL.DAY_LEAVE_ID               = DLO.DAY_LEAVE_ID
               AND DL.PERSON_ID                  = C1.PERSON_ID
               AND DL.WORK_DATE                  BETWEEN V_START_DATE AND V_END_DATE
               AND DL.WORK_CORP_ID               = C1.WORK_CORP_ID
               AND DL.SOB_ID                     = W_SOB_ID
               AND DL.ORG_ID                     = W_ORG_ID
               AND DL.CLOSED_YN                  = 'Y'
               AND DLO.OT_TYPE                   = C_LATE_TIME
               AND DLO.OT_TIME                   <> 0
             ;           
          EXCEPTION WHEN OTHERS THEN
            V_LATE_DED_COUNT := 0;
          END; 
          
          BEGIN
            V_LATE_DED_COUNT := TRUNC(V_LATE_DED_COUNT / V_LATE_STD_DAY);
          EXCEPTION WHEN OTHERS THEN
            V_LATE_DED_COUNT := 0;
          END;		
        END IF;
        
        -- 총공제일수.
        V_TOTAL_DED_DAY := NVL(C1.TOTAL_DED_DAY, 0) + NVL(V_WEEK_DED_COUNT, 0);
---------------------------------------------------------------------------------------------------
        -- 총공제일수 : 연봉제는 제외.
        IF C1.PAY_TYPE IN ('1', '3') THEN --C1.JOB_CATEGORY_CODE = '10' THEN
        -- 월급직/연봉직은 제외.
          V_TOTAL_DED_DAY := 0;
        END IF;
          
        INSERT INTO HRD_MONTH_TOTAL
        ( MONTH_TOTAL_ID
        , PERSON_ID, DUTY_TYPE, DUTY_YYYYMM
        , WORK_CORP_ID, CORP_ID, DEPT_ID, POST_ID, JOB_CATEGORY_ID
        , HOLIDAY_IN_COUNT
        , LATE_DED_COUNT
        , WEEKLY_DED_COUNT
        , HOLY_0_COUNT
        , HOLY_1_COUNT
        , HOLY_2_COUNT
        , HOLY_3_COUNT
        , TOTAL_DAY
        , TOTAL_ATT_DAY
        , TOTAL_DED_DAY
        , PAY_DAY
        , HOLY_0_DED_FLAG
        , STD_HOLY_0_COUNT
        , SOB_ID, ORG_ID
        , CREATION_DATE, CREATED_BY
        , LAST_UPDATE_DATE, LAST_UPDATED_BY			
        , EXCEPT_TYPE
        , WORK_DATE_FR
        , WORK_DATE_TO
        )	VALUES
        ( V_MONTH_TOTAL_ID                              ---
        , C1.PERSON_ID, W_DUTY_TYPE, C1.DUTY_YYYYMM
        , C1.WORK_CORP_ID, C1.CORP_ID, C1.DEPT_ID, C1.POST_ID, C1.JOB_CATEGORY_ID
        , C1.HOLIDAY_IN_COUNT 
        , V_LATE_DED_COUNT                             ---
        , V_WEEK_DED_COUNT
        , C1.HOLY_0_COUNT
        , C1.HOLY_1_COUNT
        , C1.HOLY_2_COUNT
        , C1.HOLY_3_COUNT
        , V_TOTAL_DAY                                   ---
        , C1.TOTAL_ATT_DAY
        , V_TOTAL_DED_DAY
        , CASE 
            WHEN NVL(V_TOTAL_DAY, 0) - (NVL(V_TOTAL_DED_DAY, 0) + NVL(C1.HOLY_0_COUNT, 0)) < 0 THEN 0
            ELSE NVL(V_TOTAL_DAY, 0) - (NVL(V_TOTAL_DED_DAY, 0) + NVL(C1.HOLY_0_COUNT, 0))
          END
        , V_HOLY_0_DED_FLAG                            ---
        , V_STD_HOLY_0_COUNT
        , W_SOB_ID, W_ORG_ID
        , V_SYSDATE, P_USER_ID
        , V_SYSDATE, P_USER_ID
        , C1.EXCEPT_TYPE
        , P_WORK_DATE_FR
        , P_WORK_DATE_TO
        );
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
      END;
		END LOOP C1;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10060', NULL);
  END MONTH_TOTAL_GO;

-- 월근태 잔업 집계 처리.
  PROCEDURE MONTH_TOTAL_OT_GO
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
            , W_WORK_CORP_ID                      IN HRD_MONTH_TOTAL.WORK_CORP_ID%TYPE
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE						
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    V_SYSDATE                   DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_LEAVE_TIME                HRD_MONTH_TOTAL_OT.OT_TIME%TYPE := 0;        -- 외출시간 적용.
		V_LATE_TIME                 HRD_MONTH_TOTAL_OT.OT_TIME%TYPE := 0;        -- 지각시간.
		V_REST_TIME                 HRD_MONTH_TOTAL_OT.OT_TIME%TYPE := 0;        -- 휴식연장.
		V_OVER_TIME                 HRD_MONTH_TOTAL_OT.OT_TIME%TYPE := 0;        -- 연장시간.
		V_HOLIDAY_TIME              HRD_MONTH_TOTAL_OT.OT_TIME%TYPE := 0;        -- 휴일근로.
    V_HOLIDAY_OT_TIME           HRD_MONTH_TOTAL_OT.OT_TIME%TYPE := 0;        -- 휴일연장근로.
		V_NIGHT_TIME                HRD_MONTH_TOTAL_OT.OT_TIME%TYPE := 0;        -- 야간근로.
		V_NIGHT_BONUS_TIME          HRD_MONTH_TOTAL_OT.OT_TIME%TYPE := 0;        -- 야간할증.
    
    V_TOT_LEAVE_TIME            HRD_MONTH_TOTAL_OT.OT_TIME%TYPE := 0;        -- 외출시간 적용.
		V_TOT_LATE_TIME             HRD_MONTH_TOTAL_OT.OT_TIME%TYPE := 0;        -- 지각시간.
		V_TOT_REST_TIME             HRD_MONTH_TOTAL_OT.OT_TIME%TYPE := 0;        -- 휴식연장.
		V_TOT_OVER_TIME             HRD_MONTH_TOTAL_OT.OT_TIME%TYPE := 0;        -- 연장시간.
		V_TOT_HOLIDAY_TIME          HRD_MONTH_TOTAL_OT.OT_TIME%TYPE := 0;        -- 휴일근로.
    V_TOT_HOLIDAY_OT_TIME       HRD_MONTH_TOTAL_OT.OT_TIME%TYPE := 0;        -- 휴일연장근로.
		V_TOT_NIGHT_TIME            HRD_MONTH_TOTAL_OT.OT_TIME%TYPE := 0;        -- 야간근로.
		V_TOT_NIGHT_BONUS_TIME      HRD_MONTH_TOTAL_OT.OT_TIME%TYPE := 0;        -- 야간할증.
    
  BEGIN
    O_STATUS := 'F';
    V_TOT_LEAVE_TIME            := 0;        -- 외출시간 적용.
		V_TOT_LATE_TIME             := 0;        -- 지각시간.
		V_TOT_REST_TIME             := 0;        -- 휴식연장.
		V_TOT_OVER_TIME             := 0;        -- 연장시간.
		V_TOT_HOLIDAY_TIME          := 0;        -- 휴일근로.
    V_TOT_HOLIDAY_OT_TIME       := 0;        -- 휴일연장근로.
		V_TOT_NIGHT_TIME            := 0;        -- 야간근로.
		V_TOT_NIGHT_BONUS_TIME      := 0;        -- 야간할증.
    FOR C1 IN ( SELECT DL.WORK_DATE 
                     , DL.LEAVE_TIME
                     , DL.LATE_TIME
                     , DL.REST_TIME
                     , DL.OVER_TIME
                     , DL.HOLIDAY_TIME
                     , DL.HOLIDAY_OT_TIME
                     , DL.NIGHT_TIME
                     , DL.NIGHT_BONUS_TIME
                     , DL.PERSON_ID
                     , W_DUTY_TYPE AS DUTY_TYPE
                     , W_DUTY_YYYYMM AS DUTY_YYYYMM
                     , DL.WORK_CORP_ID
                     , DL.CORP_ID
                     , DL.SOB_ID
                     , DL.ORG_ID
                  FROM HRD_DAY_LEAVE_V1 DL
                    , HRM_JOB_CATEGORY_CODE_V JC
                 WHERE DL.JOB_CATEGORY_ID         = JC.JOB_CATEGORY_ID
                   AND DL.PERSON_ID               = W_PERSON_ID
                   AND DL.WORK_DATE               BETWEEN W_START_DATE AND W_END_DATE
                   AND DL.WORK_CORP_ID            = W_WORK_CORP_ID
                   AND DL.SOB_ID                  = W_SOB_ID
                   AND DL.ORG_ID                  = W_ORG_ID
                ORDER BY DL.PERSON_ID, DL.WORK_DATE
              )
    LOOP
      V_LEAVE_TIME        := 0;        -- 외출시간 적용.
      V_LATE_TIME         := 0;        -- 지각시간.
      V_REST_TIME         := 0;        -- 휴식연장.
      V_OVER_TIME         := 0;        -- 연장시간.
      V_HOLIDAY_TIME      := 0;        -- 휴일근로.
      V_HOLIDAY_OT_TIME   := 0;        -- 휴일연장근로.
      V_NIGHT_TIME        := 0;        -- 야간근로.
      V_NIGHT_BONUS_TIME  := 0;        -- 야간할증.
      
      -- 잔업 사항 정리. --
      V_LEAVE_TIME        := C1.LEAVE_TIME;       -- 외출시간 적용.
      V_LATE_TIME         := C1.LATE_TIME;        -- 지각시간.
      V_REST_TIME         := C1.REST_TIME;        -- 휴식연장.
      V_OVER_TIME         := C1.OVER_TIME;        -- 연장시간.
      V_HOLIDAY_TIME      := C1.HOLIDAY_TIME;     -- 휴일근로.
      V_HOLIDAY_OT_TIME   := C1.HOLIDAY_OT_TIME;  -- 휴일연장근로.
      V_NIGHT_TIME        := C1.NIGHT_TIME;       -- 야간근로.
      V_NIGHT_BONUS_TIME  := C1.NIGHT_BONUS_TIME; -- 야간할증.
      
      -- 외출이 있을경우 연장(휴연포함)에서 그만큼 감소시키고 외출 시간을 0으로 만듬--
      IF NVL(V_LEAVE_TIME, 0) > 0 THEN
        IF NVL(V_LEAVE_TIME, 0) <= NVL(V_REST_TIME, 0) THEN
          V_REST_TIME := NVL(V_REST_TIME, 0) - NVL(V_LEAVE_TIME, 0);
          V_LEAVE_TIME := 0;
        ELSIF NVL(V_LEAVE_TIME, 0) <= NVL(V_REST_TIME, 0) + NVL(V_OVER_TIME, 0) THEN
          V_OVER_TIME := NVL(V_OVER_TIME, 0) + NVL(V_REST_TIME, 0);
          V_OVER_TIME := NVL(V_OVER_TIME, 0) - NVL(V_LEAVE_TIME, 0);
          V_REST_TIME := 0;
          V_LEAVE_TIME := 0;
        ELSE
          V_LEAVE_TIME := NVL(V_LEAVE_TIME, 0) - (NVL(V_OVER_TIME, 0) + NVL(V_REST_TIME, 0));
          V_OVER_TIME := 0;
          V_REST_TIME := 0;
        END IF;
      END IF;
      -- 지각/조퇴이 있을경우 연장(휴연포함)에서 그만큼 감소시키고 지각/조퇴 시간을 0으로 만듬--
      IF NVL(V_LATE_TIME, 0) > 0 THEN
        IF NVL(V_LATE_TIME, 0) <= NVL(V_REST_TIME, 0) THEN
          V_REST_TIME := NVL(V_REST_TIME, 0) - NVL(V_LATE_TIME, 0);
          V_LATE_TIME := 0;
        ELSIF NVL(V_LATE_TIME, 0) <= (NVL(V_REST_TIME, 0) + NVL(V_OVER_TIME, 0)) THEN
          V_OVER_TIME := NVL(V_OVER_TIME, 0) + NVL(V_REST_TIME, 0);
          V_OVER_TIME := NVL(V_OVER_TIME, 0) -  NVL(V_LATE_TIME, 0);
          V_REST_TIME := 0;
          V_LATE_TIME := 0;
        ELSE
          V_LATE_TIME := NVL(V_LATE_TIME, 0) - (NVL(V_OVER_TIME, 0) + NVL(V_REST_TIME, 0));
          V_OVER_TIME := 0;
          V_REST_TIME := 0;
        END IF;
      END IF;
      
      -- 합계 --
      V_TOT_LEAVE_TIME        := NVL(V_TOT_LEAVE_TIME, 0) + NVL(V_LEAVE_TIME, 0);             -- 외출시간 적용.
      V_TOT_LATE_TIME         := NVL(V_TOT_LATE_TIME, 0) + NVL(V_LATE_TIME, 0);               -- 지각시간.
      V_TOT_REST_TIME         := NVL(V_TOT_REST_TIME, 0) + NVL(V_REST_TIME, 0);               -- 휴식연장.
      V_TOT_OVER_TIME         := NVL(V_TOT_OVER_TIME, 0) + NVL(V_OVER_TIME, 0);               -- 연장시간.
      V_TOT_HOLIDAY_TIME      := NVL(V_TOT_HOLIDAY_TIME, 0) + NVL(V_HOLIDAY_TIME, 0);         -- 휴일근로.
      V_TOT_HOLIDAY_OT_TIME   := NVL(V_TOT_HOLIDAY_OT_TIME, 0) + NVL(V_HOLIDAY_OT_TIME, 0);   -- 휴일연장근로.
      V_TOT_NIGHT_TIME        := NVL(V_TOT_NIGHT_TIME, 0) + NVL(V_NIGHT_TIME, 0);             -- 야간근로.
      V_TOT_NIGHT_BONUS_TIME  := NVL(V_TOT_NIGHT_BONUS_TIME, 0) + NVL(V_NIGHT_BONUS_TIME, 0); -- 야간할증.
      
    END LOOP C1;
    -- 잔업시간 합계 저장.
    -- LEAVE_TIME.
    SAVE_OT_TIME
      ( P_MONTH_TOTAL_ID => P_MONTH_TOTAL_ID
      , P_OT_TYPE        => C_LEAVE_TIME
      , P_OT_TIME        => V_TOT_LEAVE_TIME
      , P_PERSON_ID      => W_PERSON_ID
      , P_DUTY_TYPE      => W_DUTY_TYPE
      , P_DUTY_YYYYMM    => W_DUTY_YYYYMM
      , P_WORK_CORP_ID   => W_WORK_CORP_ID
      , P_CORP_ID        => W_CORP_ID
      , P_SOB_ID         => W_SOB_ID
      , P_ORG_ID         => W_ORG_ID
      , P_USER_ID        => P_USER_ID
      );
    -- LATE_TIME.
    SAVE_OT_TIME
      ( P_MONTH_TOTAL_ID => P_MONTH_TOTAL_ID
      , P_OT_TYPE        => C_LATE_TIME
      , P_OT_TIME        => V_TOT_LATE_TIME
      , P_PERSON_ID      => W_PERSON_ID
      , P_DUTY_TYPE      => W_DUTY_TYPE
      , P_DUTY_YYYYMM    => W_DUTY_YYYYMM
      , P_WORK_CORP_ID   => W_WORK_CORP_ID
      , P_CORP_ID        => W_CORP_ID
      , P_SOB_ID         => W_SOB_ID
      , P_ORG_ID         => W_ORG_ID
      , P_USER_ID        => P_USER_ID
      );
    -- REST_TIME.
    SAVE_OT_TIME
      ( P_MONTH_TOTAL_ID => P_MONTH_TOTAL_ID
      , P_OT_TYPE        => C_REST_TIME
      , P_OT_TIME        => V_TOT_REST_TIME
      , P_PERSON_ID      => W_PERSON_ID
      , P_DUTY_TYPE      => W_DUTY_TYPE
      , P_DUTY_YYYYMM    => W_DUTY_YYYYMM
      , P_WORK_CORP_ID   => W_WORK_CORP_ID
      , P_CORP_ID        => W_CORP_ID
      , P_SOB_ID         => W_SOB_ID
      , P_ORG_ID         => W_ORG_ID
      , P_USER_ID        => P_USER_ID
      );
    -- OVER_TIME.
    SAVE_OT_TIME
      ( P_MONTH_TOTAL_ID => P_MONTH_TOTAL_ID
      , P_OT_TYPE        => C_OVER_TIME
      , P_OT_TIME        => V_TOT_OVER_TIME
      , P_PERSON_ID      => W_PERSON_ID
      , P_DUTY_TYPE      => W_DUTY_TYPE
      , P_DUTY_YYYYMM    => W_DUTY_YYYYMM
      , P_WORK_CORP_ID   => W_WORK_CORP_ID
      , P_CORP_ID        => W_CORP_ID
      , P_SOB_ID         => W_SOB_ID
      , P_ORG_ID         => W_ORG_ID
      , P_USER_ID        => P_USER_ID
      );
    -- HOLIDAY_TIME.
    SAVE_OT_TIME
      ( P_MONTH_TOTAL_ID => P_MONTH_TOTAL_ID
      , P_OT_TYPE        => C_HOLIDAY_TIME
      , P_OT_TIME        => V_TOT_HOLIDAY_TIME
      , P_PERSON_ID      => W_PERSON_ID
      , P_DUTY_TYPE      => W_DUTY_TYPE
      , P_DUTY_YYYYMM    => W_DUTY_YYYYMM
      , P_WORK_CORP_ID   => W_WORK_CORP_ID
      , P_CORP_ID        => W_CORP_ID
      , P_SOB_ID         => W_SOB_ID
      , P_ORG_ID         => W_ORG_ID
      , P_USER_ID        => P_USER_ID
      );
    -- HOLIDAY_OT_TIME.
    SAVE_OT_TIME
      ( P_MONTH_TOTAL_ID => P_MONTH_TOTAL_ID
      , P_OT_TYPE        => C_HOLIDAY_OT
      , P_OT_TIME        => V_TOT_HOLIDAY_OT_TIME
      , P_PERSON_ID      => W_PERSON_ID
      , P_DUTY_TYPE      => W_DUTY_TYPE
      , P_DUTY_YYYYMM    => W_DUTY_YYYYMM
      , P_WORK_CORP_ID   => W_WORK_CORP_ID
      , P_CORP_ID        => W_CORP_ID
      , P_SOB_ID         => W_SOB_ID
      , P_ORG_ID         => W_ORG_ID
      , P_USER_ID        => P_USER_ID
      );
    -- NIGHT_TIME.
    SAVE_OT_TIME
      ( P_MONTH_TOTAL_ID => P_MONTH_TOTAL_ID
      , P_OT_TYPE        => C_NIGHT_TIME
      , P_OT_TIME        => V_TOT_NIGHT_TIME
      , P_PERSON_ID      => W_PERSON_ID
      , P_DUTY_TYPE      => W_DUTY_TYPE
      , P_DUTY_YYYYMM    => W_DUTY_YYYYMM
      , P_WORK_CORP_ID   => W_WORK_CORP_ID
      , P_CORP_ID        => W_CORP_ID
      , P_SOB_ID         => W_SOB_ID
      , P_ORG_ID         => W_ORG_ID
      , P_USER_ID        => P_USER_ID
      );
    -- NIGHT_BONUS_TIME.
    SAVE_OT_TIME
      ( P_MONTH_TOTAL_ID => P_MONTH_TOTAL_ID
      , P_OT_TYPE        => C_NIGHT_BONUS_TIME
      , P_OT_TIME        => V_TOT_NIGHT_BONUS_TIME
      , P_PERSON_ID      => W_PERSON_ID
      , P_DUTY_TYPE      => W_DUTY_TYPE
      , P_DUTY_YYYYMM    => W_DUTY_YYYYMM
      , P_WORK_CORP_ID   => W_WORK_CORP_ID
      , P_CORP_ID        => W_CORP_ID
      , P_SOB_ID         => W_SOB_ID
      , P_ORG_ID         => W_ORG_ID
      , P_USER_ID        => P_USER_ID
      );
    O_STATUS := 'S';
    O_MESSAGE := 'OK';
  EXCEPTION WHEN OTHERS THEN
    O_STATUS := 'F';
    O_MESSAGE := 'OT Error : ' || SUBSTR(SQLERRM, 1, 150);
  END MONTH_TOTAL_OT_GO;

-- 월근태 근태 집계 처리.
  PROCEDURE MONTH_TOTAL_DUTY_GO
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE						
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                                     HRD_MONTH_TOTAL.CREATION_DATE%TYPE;
    V_HOLY_0_DUTY_ID                              NUMBER := NULL;
    V_HOLY_1_DUTY_ID                              NUMBER := NULL;
  BEGIN
    BEGIN
      SELECT MAX(DECODE(DC.ATTEND_FLAG, 'NH', DC.DUTY_ID, NULL)) AS HOLY_0_DUTY_ID
          , MAX(DECODE(DC.ATTEND_FLAG, 'H', DC.DUTY_ID, NULL)) AS HOLY_1_DUTY_ID
        INTO V_HOLY_0_DUTY_ID, V_HOLY_1_DUTY_ID
        FROM HRM_DUTY_CODE_V DC
      WHERE DC.SOB_ID             = W_SOB_ID
        AND DC.ORG_ID             = W_ORG_ID
        AND DC.ATTEND_FLAG        IN('H', 'NH')
        AND DC.EFFECTIVE_DATE_FR  <= W_END_DATE
        AND (DC.EFFECTIVE_DATE_TO IS NULL OR DC.EFFECTIVE_DATE_TO >= W_START_DATE)
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
	  -- SYSDATE.
		V_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
				
    INSERT INTO HRD_MONTH_TOTAL_DUTY
    ( MONTH_TOTAL_ID
    , DUTY_ID, DUTY_COUNT
    , PERSON_ID, DUTY_TYPE, DUTY_YYYYMM
    , WORK_CORP_ID, CORP_ID
    , SOB_ID, ORG_ID
    , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
    )
		SELECT P_MONTH_TOTAL_ID
         , CASE
             WHEN DL.HOLY_TYPE = '0' AND DC.ATTEND_FLAG IN('H', 'NH') THEN V_HOLY_0_DUTY_ID
             WHEN DL.HOLY_TYPE = '1' AND DC.ATTEND_FLAG IN('H', 'NH') THEN V_HOLY_1_DUTY_ID
             ELSE DL.DUTY_ID
           END DUTY_ID, SUM(DC.APPLY_DAY) AS DUTY_COUNT
         , DL.PERSON_ID, W_DUTY_TYPE, W_DUTY_YYYYMM
         , DL.WORK_CORP_ID, DL.CORP_ID
         , DL.SOB_ID, DL.ORG_ID
         , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID 
			FROM HRD_DAY_LEAVE_V DL
			   , HRM_DUTY_CODE_V DC
		WHERE DL.DUTY_ID                = DC.DUTY_ID
		  AND DL.SOB_ID                 = DC.SOB_ID
			AND DL.ORG_ID                 = DC.ORG_ID
		  AND DL.WORK_DATE              BETWEEN W_START_DATE AND W_END_DATE
			AND DL.PERSON_ID              = W_PERSON_ID
			AND DL.WORK_CORP_ID           = W_CORP_ID
			AND DL.SOB_ID                 = W_SOB_ID
			AND DL.ORG_ID                 = W_ORG_ID
      AND DL.CLOSED_YN              = 'Y'
    GROUP BY CASE
               WHEN DL.HOLY_TYPE = '0' AND DC.ATTEND_FLAG IN('H', 'NH') THEN V_HOLY_0_DUTY_ID
               WHEN DL.HOLY_TYPE = '1' AND DC.ATTEND_FLAG IN('H', 'NH') THEN V_HOLY_1_DUTY_ID
               ELSE DL.DUTY_ID
             END
				 , DL.PERSON_ID
         , DL.WORK_CORP_ID
				 , DL.CORP_ID
         , DL.SOB_ID
         , DL.ORG_ID
		;
    
  END MONTH_TOTAL_DUTY_GO;

-- 월근태 주휴공제 계산 : 입사일자에 대한 주휴공제 계산.
  FUNCTION JOIN_DATE_WEEK_DED_F
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE						
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            ) RETURN NUMBER
  AS
    V_ADD_DAY                     NUMBER := 0;
    V_WEEK_DED_COUNT              HRD_MONTH_TOTAL.WEEKLY_DED_COUNT%TYPE := 0;
  BEGIN
    BEGIN
      -- 임시테이블 삭제.
      DELETE FROM HRD_WORK_DATE_GT WD
      WHERE WD.WORK_CORP_ID         = W_CORP_ID
        AND WD.PERSON_ID            = W_PERSON_ID
        AND WD.SOB_ID               = W_SOB_ID
        AND WD.ORG_ID               = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    -- 해당 기간에 입사자 조회.
    FOR C1 IN ( SELECT PM.JOIN_DATE AS WORK_DATE     
                     , PM.PERSON_ID
                     , PM.WORK_CORP_ID  
                     , PM.CORP_ID
                     , PM.SOB_ID        
                     , PM.ORG_ID     
                  FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID              = W_PERSON_ID
                  AND PM.WORK_CORP_ID           = W_CORP_ID
                  AND PM.SOB_ID                 = W_SOB_ID
                  AND PM.ORG_ID                 = W_ORG_ID
                  AND PM.JOIN_DATE              BETWEEN W_START_DATE AND W_END_DATE
               )
    LOOP
      V_ADD_DAY := 7;
      BEGIN
        SELECT CASE
                 WHEN WC.ATTRIBUTE5 IN ('32') THEN 6  -- 유휴, 무휴 순.
                 ELSE 7
               END AS WORK_TYPE_GROUP
          INTO V_ADD_DAY
          FROM HRD_WORK_CALENDAR WC
        WHERE WC.WORK_DATE        = C1.WORK_DATE
          AND WC.PERSON_ID        = C1.PERSON_ID
          AND WC.WORK_CORP_ID     = C1.WORK_CORP_ID
          AND WC.SOB_ID           = C1.SOB_ID
          AND WC.ORG_ID           = C1.ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_ADD_DAY := 7;
      END;
      V_ADD_DAY := V_ADD_DAY  - 1;
      
      INSERT INTO HRD_WORK_DATE_GT
      ( WORK_DATE, OPEN_TIME, PERSON_ID
      , WORK_CORP_ID, CORP_ID
      , SOB_ID, ORG_ID
      )  
      SELECT C1.WORK_DATE AS WORK_DATE  -- 발생일자.
          , MIN(SX1.WORK_DATE) AS DED_DATE  -- 주휴공제일자.
          , SX1.PERSON_ID
          , SX1.WORK_CORP_ID
          , SX1.CORP_ID
          , SX1.SOB_ID
          , SX1.ORG_ID
        FROM (SELECT ROWNUM AS ROW_NUM 
                  , WC.WORK_DATE
                  , WC.PERSON_ID
                  , WC.WORK_CORP_ID
                  , WC.CORP_ID
                  , WC.SOB_ID
                  , WC.ORG_ID
                FROM HRD_WORK_CALENDAR WC
              WHERE WC.WORK_DATE            BETWEEN C1.WORK_DATE AND C1.WORK_DATE + V_ADD_DAY
                AND WC.PERSON_ID            = C1.PERSON_ID
                AND WC.CORP_ID              = C1.CORP_ID
                AND WC.SOB_ID               = C1.SOB_ID
                AND WC.ORG_ID               = C1.ORG_ID
                AND NOT EXISTS 
                      ( SELECT 'X'
                          FROM HRD_HOLIDAY_CALENDAR HC
                        WHERE HC.WORK_DATE    = WC.WORK_DATE
                          AND HC.SOB_ID       = WC.SOB_ID
                          AND HC.ORG_ID       = WC.ORG_ID
                          /*AND HC.ALL_CHECK    = CASE
                                                  WHEN WC.ATTRIBUTE5 IN('32') THEN 'Y'
                                                  ELSE HC.ALL_CHECK
                                                END*/
                      )
                AND WC.HOLY_TYPE            IN '1'
              ORDER BY WC.WORK_DATE
             ) SX1
      WHERE SX1.ROW_NUM           <= 1
      GROUP BY SX1.PERSON_ID
          , SX1.WORK_CORP_ID
          , SX1.CORP_ID
          , SX1.SOB_ID
          , SX1.ORG_ID
      ;
    END LOOP C1;
    
    -- 주휴공제 테이블 반영.
    FOR C1 IN ( SELECT DISTINCT MIN(WD.WORK_DATE) AS WORK_DATE, WD.OPEN_TIME AS DED_DATE  -- 근무일자, 공제일자.
                  FROM HRD_WORK_DATE_GT WD
                WHERE WD.WORK_DATE            BETWEEN W_START_DATE AND W_END_DATE   -- 근무일자 기준.
                  AND WD.PERSON_ID            = W_PERSON_ID
                  AND WD.WORK_CORP_ID         = W_CORP_ID
                  AND WD.SOB_ID               = W_SOB_ID
                  AND WD.ORG_ID               = W_ORG_ID
                GROUP BY WD.OPEN_TIME
               )
    LOOP
      UPDATE HRD_WEEKLY_DED WD
        SET WD.DED_DATE           = C1.DED_DATE
          , WD.LAST_UPDATED_BY    = P_USER_ID
      WHERE WD.PERSON_ID          = W_PERSON_ID
        AND WD.WORK_DATE          = C1.WORK_DATE
        AND WD.WORK_CORP_ID       = W_CORP_ID
        AND WD.SOB_ID             = W_SOB_ID
        AND WD.ORG_ID             = W_ORG_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO HRD_WEEKLY_DED
        ( PERSON_ID
        , WORK_DATE
        , DED_DATE
        , WORK_CORP_ID
        , CORP_ID
        , SOB_ID
        , ORG_ID
        , CREATION_DATE
        , CREATED_BY
        , LAST_UPDATE_DATE
        , LAST_UPDATED_BY        
        ) VALUES
        ( W_PERSON_ID
        , C1.WORK_DATE  -- 근무일자
        , C1.DED_DATE -- 공제일자.
        , W_CORP_ID  -- WORK_CORP_ID
        , W_CORP_ID
        , W_SOB_ID
        , W_ORG_ID
        , SYSDATE
        , P_USER_ID
        , SYSDATE
        , P_USER_ID
        );
      END IF;
    END LOOP C1;
    
    -- 주휴공제수 RETURN.
    BEGIN
      SELECT COUNT(DISTINCT WORK_DATE) AS WEEK_DED_COUNT
        INTO V_WEEK_DED_COUNT
        FROM HRD_WORK_DATE_GT WD
      WHERE WD.WORK_DATE            BETWEEN W_START_DATE AND W_END_DATE
        AND WD.PERSON_ID            = W_PERSON_ID
        AND WD.WORK_CORP_ID         = W_CORP_ID
        AND WD.SOB_ID               = W_SOB_ID
        AND WD.ORG_ID               = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_WEEK_DED_COUNT := 0;
    END;
    RETURN V_WEEK_DED_COUNT;
  END JOIN_DATE_WEEK_DED_F;


-- 지각/조퇴 4H 이상자에 대한 주휴공제 계산.
  FUNCTION LATE_TIME_WEEK_DED_F
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE						
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            ) RETURN NUMBER
  AS
    V_ADD_DAY                     NUMBER := 0;
    V_WEEK_DED_COUNT              HRD_MONTH_TOTAL.WEEKLY_DED_COUNT%TYPE := 0;
  BEGIN
    BEGIN
      -- 임시테이블 삭제.
      DELETE FROM HRD_WORK_DATE_GT WD
      WHERE WD.WORK_CORP_ID         = W_CORP_ID
        AND WD.PERSON_ID            = W_PERSON_ID
        AND WD.SOB_ID               = W_SOB_ID
        AND WD.ORG_ID               = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    
    -- 지각/조퇴시간 4H 이상.
    FOR C1 IN ( SELECT DL.DUTY_ID
                     , DL.WORK_DATE
                     , DL.PERSON_ID
                     , DL.WORK_CORP_ID
                     , DL.CORP_ID
                     , DL.SOB_ID
                     , DL.ORG_ID         
                  FROM HRD_DAY_LEAVE_V1 DL
                WHERE DL.WORK_DATE              BETWEEN W_START_DATE AND W_END_DATE
                  AND DL.PERSON_ID              = W_PERSON_ID
                  AND DL.WORK_CORP_ID           = W_CORP_ID
                  AND DL.SOB_ID                 = W_SOB_ID
                  AND DL.ORG_ID                 = W_ORG_ID
                  AND DL.HOLY_TYPE              NOT IN('0', '1')  -- 휴일은 제외.
                  AND DL.CLOSED_YN              = 'Y'
                  AND ((NVL(DL.LATE_TIME, 0) + NVL(DL.LEAVE_TIME, 0)) > 4
                  AND ((NVL(DL.OVER_TIME, 0) + NVL(DL.REST_TIME, 0)) - (NVL(DL.LATE_TIME, 0) + NVL(DL.LEAVE_TIME, 0))) < 0)
               )
    LOOP
      V_ADD_DAY := 7;
      BEGIN
        SELECT CASE
                 WHEN WC.ATTRIBUTE5 IN ('32') THEN 6  -- 유휴, 무휴 순.
                 ELSE 7
               END AS WORK_TYPE_GROUP
          INTO V_ADD_DAY
          FROM HRD_WORK_CALENDAR WC
        WHERE WC.WORK_DATE        = C1.WORK_DATE
          AND WC.PERSON_ID        = C1.PERSON_ID
          AND WC.WORK_CORP_ID     = C1.WORK_CORP_ID
          AND WC.SOB_ID           = C1.SOB_ID
          AND WC.ORG_ID           = C1.ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_ADD_DAY := 7;
      END;
      V_ADD_DAY := V_ADD_DAY  - 1;
      
      INSERT INTO HRD_WORK_DATE_GT
      ( WORK_DATE, OPEN_TIME, PERSON_ID
      , WORK_CORP_ID, CORP_ID
      , SOB_ID, ORG_ID
      )  
      SELECT C1.WORK_DATE AS WORK_DATE  -- 발생일자.
          , MIN(SX1.WORK_DATE) AS DED_DATE  -- 주휴공제일자.
          , SX1.PERSON_ID
          , SX1.WORK_CORP_ID
          , SX1.CORP_ID
          , SX1.SOB_ID
          , SX1.ORG_ID
        FROM (SELECT ROWNUM AS ROW_NUM 
                  , WC.WORK_DATE
                  , WC.PERSON_ID
                  , WC.WORK_CORP_ID
                  , WC.CORP_ID
                  , WC.SOB_ID
                  , WC.ORG_ID
                FROM HRD_WORK_CALENDAR WC
              WHERE WC.WORK_DATE            BETWEEN C1.WORK_DATE AND C1.WORK_DATE + V_ADD_DAY
                AND WC.PERSON_ID            = C1.PERSON_ID
                AND WC.CORP_ID              = C1.CORP_ID
                AND WC.SOB_ID               = C1.SOB_ID
                AND WC.ORG_ID               = C1.ORG_ID
                AND NOT EXISTS 
                      ( SELECT 'X'
                          FROM HRD_HOLIDAY_CALENDAR HC
                        WHERE HC.WORK_DATE    = WC.WORK_DATE
                          AND HC.SOB_ID       = WC.SOB_ID
                          AND HC.ORG_ID       = WC.ORG_ID
                          /*AND HC.ALL_CHECK    = CASE
                                                  WHEN WC.ATTRIBUTE5 IN('32') THEN 'Y'
                                                  ELSE HC.ALL_CHECK
                                                END*/
                      )
                AND WC.HOLY_TYPE            IN '1'
              ORDER BY WC.WORK_DATE
             ) SX1
      WHERE SX1.ROW_NUM           <= 1
      GROUP BY SX1.PERSON_ID
          , SX1.WORK_CORP_ID
          , SX1.CORP_ID
          , SX1.SOB_ID
          , SX1.ORG_ID
      ;
    END LOOP C1;
    
    -- 주휴공제 테이블 반영.
    FOR C1 IN ( SELECT DISTINCT MIN(WD.WORK_DATE) AS WORK_DATE, WD.OPEN_TIME AS DED_DATE  -- 근무일자, 공제일자.
                  FROM HRD_WORK_DATE_GT WD
                WHERE WD.WORK_DATE            BETWEEN W_START_DATE AND W_END_DATE   -- 근무일자 기준.
                  AND WD.PERSON_ID            = W_PERSON_ID
                  AND WD.WORK_CORP_ID         = W_CORP_ID
                  AND WD.SOB_ID               = W_SOB_ID
                  AND WD.ORG_ID               = W_ORG_ID
                GROUP BY WD.OPEN_TIME
               )
    LOOP
      UPDATE HRD_WEEKLY_DED WD
        SET WD.DED_DATE           = C1.DED_DATE
          , WD.LAST_UPDATED_BY    = P_USER_ID
      WHERE WD.PERSON_ID          = W_PERSON_ID
        AND WD.DED_DATE           = C1.DED_DATE
        AND WD.WORK_CORP_ID       = W_CORP_ID
        AND WD.SOB_ID             = W_SOB_ID
        AND WD.ORG_ID             = W_ORG_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO HRD_WEEKLY_DED
        ( PERSON_ID
        , WORK_DATE
        , DED_DATE
        , WORK_CORP_ID
        , CORP_ID
        , SOB_ID
        , ORG_ID
        , CREATION_DATE
        , CREATED_BY
        , LAST_UPDATE_DATE
        , LAST_UPDATED_BY        
        ) VALUES
        ( W_PERSON_ID
        , C1.WORK_DATE  -- 근무일자
        , C1.DED_DATE -- 공제일자.
        , W_CORP_ID  -- WORK_CORP_ID
        , W_CORP_ID
        , W_SOB_ID
        , W_ORG_ID
        , SYSDATE
        , P_USER_ID
        , SYSDATE
        , P_USER_ID
        );
      END IF;
    END LOOP C1;
    
    -- 주휴공제수 UPDATE.
    BEGIN
      SELECT COUNT(DISTINCT WORK_DATE) AS WEEK_DED_COUNT
        INTO V_WEEK_DED_COUNT
        FROM HRD_WEEKLY_DED WD
      WHERE WD.DED_DATE             BETWEEN W_START_DATE AND W_END_DATE
        AND WD.PERSON_ID            = W_PERSON_ID
        AND WD.WORK_CORP_ID         = W_CORP_ID
        AND WD.SOB_ID               = W_SOB_ID
        AND WD.ORG_ID               = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_WEEK_DED_COUNT := 0;
    END;
    RETURN V_WEEK_DED_COUNT;
  END LATE_TIME_WEEK_DED_F;
  
-- 월근태 주휴공제 계산.
  FUNCTION MONTH_TOTAL_WEEK_DED_F
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE						
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            ) RETURN NUMBER
  AS
    V_ADD_DAY                     NUMBER := 0;
    V_WEEK_DED_COUNT              HRD_MONTH_TOTAL.WEEKLY_DED_COUNT%TYPE := 0;
  BEGIN
---------------------------------------------------------------------------------------------------
--   신규입사에 대한 주휴공제일수
    V_WEEK_DED_COUNT := JOIN_DATE_WEEK_DED_F
                          ( W_CORP_ID => W_CORP_ID
                          , W_START_DATE => W_START_DATE
                          , W_END_DATE => W_END_DATE
                          , W_PERSON_ID => W_PERSON_ID
                          , W_SOB_ID => W_SOB_ID
                          , W_ORG_ID => W_ORG_ID
                          , P_USER_ID => P_USER_ID
                          );

--   지각/조퇴 4H이상에 대한 주휴공제일수
    V_WEEK_DED_COUNT := LATE_TIME_WEEK_DED_F
                          ( W_CORP_ID => W_CORP_ID
                          , W_START_DATE => W_START_DATE
                          , W_END_DATE => W_END_DATE
                          , W_PERSON_ID => W_PERSON_ID
                          , W_SOB_ID => W_SOB_ID
                          , W_ORG_ID => W_ORG_ID
                          , P_USER_ID => P_USER_ID
                          );
                          
    BEGIN
      -- 임시테이블 삭제.
      DELETE FROM HRD_WORK_DATE_GT WD
      WHERE WD.WORK_CORP_ID         = W_CORP_ID
        AND WD.PERSON_ID            = W_PERSON_ID
        AND WD.SOB_ID               = W_SOB_ID
        AND WD.ORG_ID               = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    
    -- 결근일자 UPDATE.
    FOR C1 IN ( SELECT DL.DUTY_ID
                     , DL.WORK_DATE
                     , DL.PERSON_ID
                     , DL.WORK_CORP_ID
                     , DL.CORP_ID
                     , DL.SOB_ID
                     , DL.ORG_ID         
                  FROM HRD_DAY_LEAVE_V DL
                     , HRM_DUTY_CODE_V DC
                WHERE DL.DUTY_ID                = DC.DUTY_ID
                  AND DL.SOB_ID                 = DC.SOB_ID
                  AND DL.ORG_ID                 = DC.ORG_ID
                  AND DL.WORK_DATE              BETWEEN W_START_DATE AND W_END_DATE
                  AND DL.PERSON_ID              = W_PERSON_ID
                  AND DL.WORK_CORP_ID           = W_CORP_ID
                  AND DL.SOB_ID                 = W_SOB_ID
                  AND DL.ORG_ID                 = W_ORG_ID
                  AND DL.CLOSED_YN              = 'Y'
                  AND DC.DUTY_CODE              IN('11', '31', '54', '78', '95', '97')
               )
    LOOP
      V_ADD_DAY := 7;
      BEGIN
        SELECT CASE
                 WHEN WC.ATTRIBUTE5 IN ('32') THEN 6  -- 유휴, 무휴 순.
                 ELSE 7
               END AS WORK_TYPE_GROUP
          INTO V_ADD_DAY
          FROM HRD_WORK_CALENDAR WC
        WHERE WC.WORK_DATE        = C1.WORK_DATE
          AND WC.PERSON_ID        = C1.PERSON_ID
          AND WC.WORK_CORP_ID     = C1.WORK_CORP_ID
          AND WC.SOB_ID           = C1.SOB_ID
          AND WC.ORG_ID           = C1.ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_ADD_DAY := 7;
      END;
      V_ADD_DAY := V_ADD_DAY  - 1;
      
      INSERT INTO HRD_WORK_DATE_GT
      ( WORK_DATE, OPEN_TIME, PERSON_ID
      , WORK_CORP_ID, CORP_ID
      , SOB_ID, ORG_ID
      )  
      SELECT C1.WORK_DATE AS WORK_DATE  -- 발생일자.
          , MIN(SX1.WORK_DATE) AS DED_DATE  -- 주휴공제일자.
          , SX1.PERSON_ID
          , SX1.WORK_CORP_ID
          , SX1.CORP_ID
          , SX1.SOB_ID
          , SX1.ORG_ID
        FROM (SELECT ROWNUM AS ROW_NUM 
                  , WC.WORK_DATE
                  , WC.PERSON_ID
                  , WC.WORK_CORP_ID
                  , WC.CORP_ID
                  , WC.SOB_ID
                  , WC.ORG_ID
                FROM HRD_WORK_CALENDAR WC
              WHERE WC.WORK_DATE            BETWEEN C1.WORK_DATE AND C1.WORK_DATE + V_ADD_DAY
                AND WC.PERSON_ID            = C1.PERSON_ID
                AND WC.CORP_ID              = C1.CORP_ID
                AND WC.SOB_ID               = C1.SOB_ID
                AND WC.ORG_ID               = C1.ORG_ID
                AND NOT EXISTS 
                      ( SELECT 'X'
                          FROM HRD_HOLIDAY_CALENDAR HC
                        WHERE HC.WORK_DATE    = WC.WORK_DATE
                          AND HC.SOB_ID       = WC.SOB_ID
                          AND HC.ORG_ID       = WC.ORG_ID
                          /*AND HC.ALL_CHECK    = CASE
                                                  WHEN WC.ATTRIBUTE5 IN('32') THEN 'Y'
                                                  ELSE HC.ALL_CHECK
                                                END*/
                      )
                AND WC.HOLY_TYPE            IN '1'
              ORDER BY WC.WORK_DATE
             ) SX1
      WHERE SX1.ROW_NUM           <= 1
      GROUP BY SX1.PERSON_ID
          , SX1.WORK_CORP_ID
          , SX1.CORP_ID
          , SX1.SOB_ID
          , SX1.ORG_ID
      ;
    END LOOP C1;
    
    -- 주휴공제 테이블 반영.
    FOR C1 IN ( SELECT DISTINCT MIN(WD.WORK_DATE) AS WORK_DATE, WD.OPEN_TIME AS DED_DATE  -- 근무일자, 공제일자.
                  FROM HRD_WORK_DATE_GT WD
                WHERE WD.WORK_DATE            BETWEEN W_START_DATE AND W_END_DATE   -- 근무일자 기준.
                  AND WD.PERSON_ID            = W_PERSON_ID
                  AND WD.WORK_CORP_ID         = W_CORP_ID
                  AND WD.SOB_ID               = W_SOB_ID
                  AND WD.ORG_ID               = W_ORG_ID
                GROUP BY WD.OPEN_TIME
               )
    LOOP
      UPDATE HRD_WEEKLY_DED WD
        SET WD.DED_DATE           = C1.DED_DATE
          , WD.LAST_UPDATED_BY    = P_USER_ID
      WHERE WD.PERSON_ID          = W_PERSON_ID
        AND WD.DED_DATE           = C1.DED_DATE
        AND WD.WORK_CORP_ID       = W_CORP_ID
        AND WD.SOB_ID             = W_SOB_ID
        AND WD.ORG_ID             = W_ORG_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO HRD_WEEKLY_DED
        ( PERSON_ID
        , WORK_DATE
        , DED_DATE
        , WORK_CORP_ID
        , CORP_ID
        , SOB_ID
        , ORG_ID
        , CREATION_DATE
        , CREATED_BY
        , LAST_UPDATE_DATE
        , LAST_UPDATED_BY        
        ) VALUES
        ( W_PERSON_ID
        , C1.WORK_DATE  -- 근무일자
        , C1.DED_DATE -- 공제일자.
        , W_CORP_ID  -- WORK_CORP_ID
        , W_CORP_ID
        , W_SOB_ID
        , W_ORG_ID
        , SYSDATE
        , P_USER_ID
        , SYSDATE
        , P_USER_ID
        );
      END IF;
    END LOOP C1;
    
    -- 주휴공제수 UPDATE.
    BEGIN
      SELECT COUNT(DISTINCT WORK_DATE) AS WEEK_DED_COUNT
        INTO V_WEEK_DED_COUNT
        FROM HRD_WEEKLY_DED WD
      WHERE WD.DED_DATE             BETWEEN W_START_DATE AND W_END_DATE
        AND WD.PERSON_ID            = W_PERSON_ID
        AND WD.WORK_CORP_ID         = W_CORP_ID
        AND WD.SOB_ID               = W_SOB_ID
        AND WD.ORG_ID               = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_WEEK_DED_COUNT := 0;
    END;
    RETURN V_WEEK_DED_COUNT;    
  END MONTH_TOTAL_WEEK_DED_F;
  
---------------------------------------------------------------------------------------------------
-- TOT_DED_COUNT ==> CAL.
  PROCEDURE TOT_DED_COUNT_P
	          ( W_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
						, P_LATE_DED_COUNT                    IN HRD_MONTH_TOTAL.LATE_DED_COUNT%TYPE
						, P_WEEKLY_DED_COUNT                  IN HRD_MONTH_TOTAL.WEEKLY_DED_COUNT%TYPE
						, O_TOTAL_DED_COUNT                   OUT HRD_MONTH_TOTAL.TOTAL_DED_DAY%TYPE
						, O_PAY_DAY                           OUT HRD_MONTH_TOTAL.PAY_DAY%TYPE
						)
  AS
		V_TOTAL_DAY                                   HRD_MONTH_TOTAL.TOTAL_DAY%TYPE := 0;
    V_HOLY_0_COUNT                                HRD_MONTH_TOTAL.HOLY_0_COUNT%TYPE;
		V_TOTAL_DED_COUNT                             HRD_MONTH_TOTAL.TOTAL_DED_DAY%TYPE := 0;
		V_PAY_DAY                                     HRD_MONTH_TOTAL.PAY_DAY%TYPE := 0;
		
	BEGIN
	  BEGIN
	    SELECT MT.TOTAL_DAY
           , DECODE(MT.HOLY_0_DED_FLAG, 'Y', MT.HOLY_0_COUNT, 0) AS HOLY_0_COUNT
			  INTO V_TOTAL_DAY
           , V_HOLY_0_COUNT
        FROM HRD_MONTH_TOTAL MT 
       WHERE MT.MONTH_TOTAL_ID      = W_MONTH_TOTAL_ID
			;
		EXCEPTION WHEN OTHERS THEN
		  V_TOTAL_DAY := 0;
		END;
	  V_TOTAL_DED_COUNT := NON_PAY_DAY_F(W_MONTH_TOTAL_ID) + NVL(P_LATE_DED_COUNT, 0) + NVL(P_WEEKLY_DED_COUNT, 0);
		IF V_TOTAL_DED_COUNT < 0 THEN
		  V_TOTAL_DED_COUNT := 0;
		END IF;
		V_PAY_DAY := NVL(V_TOTAL_DAY, 0) - (NVL(V_TOTAL_DED_COUNT, 0) + NVL(V_HOLY_0_COUNT, 0));
		IF V_PAY_DAY < 0 THEN
		  V_PAY_DAY := 0;
		END IF;
		
		-- RETURN.
		O_TOTAL_DED_COUNT := V_TOTAL_DED_COUNT;
		O_PAY_DAY := V_PAY_DAY;
		
	END TOT_DED_COUNT_P;
		
-- 무급일수.
  FUNCTION NON_PAY_DAY_F
            ( W_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
            ) RETURN NUMBER
  AS
	  V_NON_PAY_DAY                                 HRD_MONTH_TOTAL.TOTAL_DED_DAY%TYPE := 0;
		
	BEGIN
	  BEGIN
	    SELECT NVL(MTS.DUTY_COUNT, 0) AS DAY_COUNT
        INTO V_NON_PAY_DAY
        FROM HRD_MONTH_TOTAL MT 
				  , HRD_MONTH_TOTAL_DUTY MTS
          , HRM_DUTY_CODE_V DC
					, HRM_WORK_TERM_V WT
      WHERE MT.MONTH_TOTAL_ID      = MTS.MONTH_TOTAL_ID
			  AND MTS.DUTY_ID            = DC.DUTY_ID
			  AND MT.DUTY_TYPE           = WT.DUTY_TERM_TYPE
        AND MT.MONTH_TOTAL_ID      = W_MONTH_TOTAL_ID
        AND (DC.NON_PAY_DAY_FLAG    = 'Y'
          OR DC.DUTY_CODE          = '11')
        AND DC.EFFECTIVE_DATE_FR   <= ADD_MONTHS(TO_DATE(MT.DUTY_YYYYMM || ' ' || WT.END_DAY, 'YYYY-MM-DD') + WT.END_ADD_DAY, WT.END_ADD_MONTH)
        AND (DC.EFFECTIVE_DATE_TO IS NULL OR DC.EFFECTIVE_DATE_TO >= ADD_MONTHS(TO_DATE(MT.DUTY_YYYYMM || ' ' || WT.START_DAY, 'YYYY-MM-DD') + WT.START_ADD_DAY, WT.START_ADD_MONTH))
			;
		EXCEPTION WHEN OTHERS THEN
		  V_NON_PAY_DAY := 0;
		END;
		RETURN V_NON_PAY_DAY;		
	END NON_PAY_DAY_F;

---------------------------------------------------------------------------------------------------
-- 연장근무시간 합계 저장.
  PROCEDURE SAVE_OT_TIME
            ( P_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
            , P_OT_TYPE                           IN HRD_MONTH_TOTAL_OT.OT_TYPE%TYPE
            , P_OT_TIME                           IN HRD_MONTH_TOTAL_OT.OT_TIME%TYPE
            , P_PERSON_ID                         IN HRD_MONTH_TOTAL_OT.PERSON_ID%TYPE
            , P_DUTY_TYPE                         IN HRD_MONTH_TOTAL_OT.DUTY_TYPE%TYPE
            , P_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL_OT.DUTY_YYYYMM%TYPE
            , P_WORK_CORP_ID                      IN HRD_MONTH_TOTAL_OT.WORK_CORP_ID%TYPE
            , P_CORP_ID                           IN HRD_MONTH_TOTAL_OT.CORP_ID%TYPE
            , P_SOB_ID                            IN HRD_MONTH_TOTAL_OT.SOB_ID%TYPE
            , P_ORG_ID                            IN HRD_MONTH_TOTAL_OT.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_MONTH_TOTAL_OT.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    IF NVL(P_OT_TIME, 0) <> 0 THEN
      -- 연장근무시간 INSERT.
      INSERT INTO HRD_MONTH_TOTAL_OT
      ( MONTH_TOTAL_ID
      , OT_TYPE, OT_TIME
      , PERSON_ID, DUTY_TYPE, DUTY_YYYYMM
      , WORK_CORP_ID, CORP_ID
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY
      , LAST_UPDATE_DATE, LAST_UPDATED_BY
      ) VALUES
      ( P_MONTH_TOTAL_ID
      , P_OT_TYPE, NVL(P_OT_TIME, 0)
      , P_PERSON_ID, P_DUTY_TYPE, P_DUTY_YYYYMM
      , P_WORK_CORP_ID, P_CORP_ID
      , P_SOB_ID, P_ORG_ID
      , V_SYSDATE, P_USER_ID
      , V_SYSDATE, P_USER_ID
      );
    END IF;
  END SAVE_OT_TIME;

---------------------------------------------------------------------------------------------------
-- 월근태 마감여부.
  FUNCTION MONTH_TOTAL_CLOSED_FLAG
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
						, W_DEPT_ID                           IN HRD_MONTH_TOTAL.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_EXCEPT_YN                         IN VARCHAR2
            ) RETURN VARCHAR2
  AS
    V_CLOSED_FLAG    VARCHAR2(2) := 'N';
    V_CLOSED_NO_CNT  NUMBER := 0;
  BEGIN
    BEGIN
      SELECT NVL(SUM(DECODE(MT.CLOSED_YN, 'N', 1, 0)), 1) AS CLOSED_NO_CNT
        INTO V_CLOSED_NO_CNT
        FROM HRD_MONTH_TOTAL MT
          , HRM_PERSON_MASTER PM
      WHERE MT.PERSON_ID             = PM.PERSON_ID
        AND MT.DUTY_TYPE             = W_DUTY_TYPE
        AND MT.DUTY_YYYYMM           = W_DUTY_YYYYMM
        AND MT.PERSON_ID             = NVL(W_PERSON_ID, MT.PERSON_ID)
        AND MT.WORK_CORP_ID          = W_CORP_ID
        AND MT.SOB_ID                = W_SOB_ID
        AND MT.ORG_ID                = W_ORG_ID
        AND PM.DEPT_ID               = NVL(W_DEPT_ID, PM.DEPT_ID)
        AND PM.FLOOR_ID              = NVL(W_FLOOR_ID, PM.FLOOR_ID)
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CLOSED_NO_CNT := 1;
    END;
    IF V_CLOSED_NO_CNT > 0 THEN
      V_CLOSED_FLAG := 'N';
    ELSE
      V_CLOSED_FLAG := 'Y';
    END IF;
    RETURN V_CLOSED_FLAG;
  END MONTH_TOTAL_CLOSED_FLAG;
  
---------------------------------------------------------------------------------------------------
-- 월근태 마감처리.
  PROCEDURE SET_CLOSED_MONTH_TOTAL
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
						, W_DEPT_ID                           IN HRD_MONTH_TOTAL.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_EXCEPT_YN                         IN VARCHAR2
            , P_CONNECT_PERSON_ID                 IN NUMBER
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    BEGIN
      UPDATE HRD_MONTH_TOTAL MT
        SET MT.CLOSED_YN        = 'Y'
          , MT.CLOSED_DATE      = V_SYSDATE
          , MT.CLOSED_PERSON_ID = P_CONNECT_PERSON_ID
      WHERE MT.PERSON_ID        = NVL(W_PERSON_ID, MT.PERSON_ID)
        AND MT.DUTY_TYPE        = W_DUTY_TYPE
        AND MT.DUTY_YYYYMM      = W_DUTY_YYYYMM
        AND MT.WORK_CORP_ID     = W_CORP_ID
        AND MT.SOB_ID           = W_SOB_ID
        AND MT.ORG_ID           = W_ORG_ID
        AND EXISTS 
              ( SELECT 'X'
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID      = MT.PERSON_ID
                  AND PM.FLOOR_ID       = NVL(W_FLOOR_ID, PM.FLOOR_ID)
                  AND PM.DEPT_ID        = NVL(W_DEPT_ID, PM.DEPT_ID)
             )
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10024', NULL);
  END SET_CLOSED_MONTH_TOTAL;            

-- 월근태 마감처리 취소.
  PROCEDURE SET_CANCEL_CLOSED_MONTH_TOTAL
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
						, W_DEPT_ID                           IN HRD_MONTH_TOTAL.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_EXCEPT_YN                         IN VARCHAR2
            , P_CONNECT_PERSON_ID                 IN NUMBER
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    O_STATUS := 'F';
    BEGIN
      UPDATE HRD_MONTH_TOTAL MT
        SET MT.CLOSED_YN        = 'N'
          , MT.CLOSED_DATE      = V_SYSDATE
          , MT.CLOSED_PERSON_ID = P_CONNECT_PERSON_ID
      WHERE MT.PERSON_ID        = NVL(W_PERSON_ID, MT.PERSON_ID)
        AND MT.DUTY_TYPE        = W_DUTY_TYPE
        AND MT.DUTY_YYYYMM      = W_DUTY_YYYYMM
        AND MT.WORK_CORP_ID     = W_CORP_ID
        AND MT.SOB_ID           = W_SOB_ID
        AND MT.ORG_ID           = W_ORG_ID
        AND ((P_EXCEPT_YN       = 'N'
        AND 1                   = 1)
        OR  (P_EXCEPT_YN        = 'Y'
        AND MT.EXCEPT_TYPE      IN('N', 'I')))
        AND EXISTS 
              ( SELECT 'X'
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID      = MT.PERSON_ID
                  AND PM.FLOOR_ID       = NVL(W_FLOOR_ID, PM.FLOOR_ID)
                  AND PM.DEPT_ID        = NVL(W_DEPT_ID, PM.DEPT_ID)
             )
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10025', NULL);
  END SET_CANCEL_CLOSED_MONTH_TOTAL;

END HRD_MONTH_TOTAL_G_SET;
/
