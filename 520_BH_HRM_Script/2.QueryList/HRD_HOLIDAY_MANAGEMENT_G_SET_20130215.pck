CREATE OR REPLACE PACKAGE HRD_HOLIDAY_MANAGEMENT_G_SET
AS
-- 휴가사항 생성 및 사용수 집계 MAIN.
  PROCEDURE SET_MAIN
            ( P_DUTY_YEAR                 IN  VARCHAR2
						, P_CORP_ID                   IN  NUMBER
						, P_STD_DATE                  IN  DATE
						, P_PERSON_ID                 IN  NUMBER
						, P_DEPT_ID                   IN  NUMBER
						, P_SOB_ID                    IN  NUMBER
						, P_ORG_ID                    IN  NUMBER
						, P_USER_ID                   IN  NUMBER
            , O_STATUS                    OUT VARCHAR2
            , O_MESSAGE                   OUT VARCHAR2
						);

---------------------------------------------------------------------------------------------------
-- HOLIDAY_MANAGEMENT EXECUTE INSERT.
  PROCEDURE EXE_INSERT
            ( P_HOLIDAY_TYPE              IN  VARCHAR2
            , P_DUTY_YEAR                 IN  VARCHAR2
            , P_PERSON_ID                 IN  NUMBER
            , P_CORP_ID                   IN  NUMBER
            , P_PRE_NEXT_NUM              IN  NUMBER
            , P_CREATION_NUM              IN  NUMBER
            , P_PLUS_NUM                  IN  NUMBER
						, P_USE_NUM                   IN  NUMBER
            , P_YEAR_COUNT                IN  NUMBER
            , P_EXCEPT_YN                 IN  VARCHAR2
            , P_WORKING_RATE              IN  NUMBER
            , P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            );
            
-- HOLIDAY_MANAGEMENT EXECUTE UPDATE.
  PROCEDURE EXE_UPDATE
            ( W_HOLIDAY_TYPE              IN  VARCHAR2
            , W_DUTY_YEAR                 IN  VARCHAR2
            , W_PERSON_ID                 IN  NUMBER
						, W_CORP_ID                   IN  NUMBER
            , W_SOB_ID                    IN  NUMBER
            , W_ORG_ID                    IN  NUMBER
            , P_PRE_NEXT_NUM              IN  NUMBER
            , P_CREATION_NUM              IN  NUMBER
            , P_PLUS_NUM                  IN  NUMBER
						, P_USE_NUM                   IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            );

-- HOLIDAY_MANAGEMENT EXECUTE DELETE.
  PROCEDURE EXE_DELETE
            ( W_HOLIDAY_TYPE              IN  VARCHAR2
            , W_DUTY_YEAR                 IN  VARCHAR2
            , W_STD_DATE                  IN  DATE
            , W_PERSON_ID                 IN  NUMBER
            , W_DEPT_ID                   IN  NUMBER
            , W_CORP_ID                   IN  NUMBER
            , W_SOB_ID                    IN  NUMBER
            , W_ORG_ID                    IN  NUMBER
            );
						
---------------------------------------------------------------------------------------------------
-- 휴가사항 집계 기간.
  PROCEDURE HOLIDAY_PERIOD_P
            ( W_DUTY_YEAR                 IN  VARCHAR2
            , W_SOB_ID                    IN  NUMBER
            , W_ORG_ID                    IN  NUMBER
            , O_START_DATE                OUT DATE
            , O_END_DATE                  OUT DATE
            );
												
---------------------------------------------------------------------------------------------------
  -- 매년도(1월1일) 휴가사항 생성 
	PROCEDURE HOLIDAY_CREATE
            ( P_DUTY_YEAR                 IN  VARCHAR2
            , P_CORP_ID                   IN  NUMBER
            , P_STD_DATE                  IN  DATE
            , P_PERSON_ID                 IN  NUMBER
            , P_DEPT_ID                   IN  NUMBER
            , P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            , O_STATUS                    OUT VARCHAR2
            , O_MESSAGE                   OUT VARCHAR2
            );

-- 년차 생성.
  PROCEDURE YEAR_CREATE
            ( P_HOLIDAY_TYPE              IN  VARCHAR2
            , P_DUTY_YEAR                 IN  VARCHAR2
            , P_CORP_ID                   IN  NUMBER
            , P_STD_DATE                  IN  DATE
            , P_PERSON_ID                 IN  NUMBER
            , P_DEPT_ID                   IN  NUMBER
            , P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            , O_STATUS                    OUT VARCHAR2
            , O_MESSAGE                   OUT VARCHAR2
            );

-- 연중휴가 생성.
  PROCEDURE SUMMER_CREATE
            ( P_HOLIDAY_TYPE              IN  VARCHAR2
            , P_DUTY_YEAR                 IN  VARCHAR2
            , P_CORP_ID                   IN  NUMBER
            , P_STD_DATE                  IN  DATE
            , P_PERSON_ID                 IN  NUMBER
            , P_DEPT_ID                   IN  NUMBER
            , P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            , O_STATUS                    OUT VARCHAR2
            , O_MESSAGE                   OUT VARCHAR2
            );

  -- 년차수당 계산
  PROCEDURE AMT_CALCULATE
            ( P_DUTY_YEAR                 IN  VARCHAR2
            , P_CORP_ID                   IN  NUMBER
            , P_STD_DATE                  IN  DATE
            , P_PERSON_ID                 IN  NUMBER
            , P_DEPT_ID                   IN  NUMBER
            , P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            , O_STATUS                    OUT VARCHAR2
            , O_MESSAGE                   OUT VARCHAR2
            );
        
---------------------------------------------------------------------------------------------------
  -- 휴가사항 사용수 집계.
	PROCEDURE HOLIDAY_USE_CAL
            ( P_DUTY_YEAR                 IN  VARCHAR2
            , P_CORP_ID                   IN  NUMBER
            , P_STD_DATE                  IN  DATE
            , P_PERSON_ID                 IN  NUMBER
            , P_DEPT_ID                   IN  NUMBER
            , P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            , O_STATUS                    OUT VARCHAR2
            , O_MESSAGE                   OUT VARCHAR2
            );
						
-- 1년 미만자 년차 생성 및 년차 사용수 집계
  PROCEDURE YEAR_CAL
            ( P_HOLIDAY_TYPE              IN  VARCHAR2
            , P_DUTY_YEAR                 IN  VARCHAR2
            , P_CORP_ID                   IN  NUMBER
            , P_STD_DATE                  IN  DATE
            , P_START_DATE                IN  DATE
            , P_END_DATE                  IN  DATE
            , P_PERSON_ID                 IN  NUMBER
            , P_DEPT_ID                   IN  NUMBER
            , P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            , O_STATUS                    OUT VARCHAR2
            , O_MESSAGE                   OUT VARCHAR2
            );

-- 연중휴가 생성(1년 미만자) 및 사용수 집계
  PROCEDURE SUMMER_CAL
            ( P_HOLIDAY_TYPE              IN  VARCHAR2
            , P_DUTY_YEAR                 IN  VARCHAR2
            , P_CORP_ID                   IN  NUMBER
            , P_STD_DATE                  IN  DATE
            , P_PERSON_ID                 IN  NUMBER
            , P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            , O_STATUS                    OUT VARCHAR2
            , O_MESSAGE                   OUT VARCHAR2
            );

-- 특별휴가 사용수 집계
  PROCEDURE SPECIAL_CAL
            ( P_HOLIDAY_TYPE              IN  VARCHAR2
            , P_DUTY_YEAR                 IN  VARCHAR2
            , P_CORP_ID                   IN  NUMBER
            , P_STD_DATE                  IN  DATE
            , P_PERSON_ID                 IN  NUMBER
            , P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            , O_STATUS                    OUT VARCHAR2
            , O_MESSAGE                   OUT VARCHAR2
            );

---------------------------------------------------------------------------------------------------
-- 1년 미만자 년차수 생성.
  FUNCTION YEAR_PLUS_0
          ( W_CORP_ID                     IN  NUMBER
          , W_JOIN_DATE                   IN  DATE
          , W_START_DATE                  IN  DATE
          , W_END_DATE                    IN  DATE
          , W_PERSON_ID                   IN  NUMBER
          , W_SOB_ID                      IN  NUMBER
          , W_ORG_ID                      IN  NUMBER
          ) RETURN NUMBER;

---------------------------------------------------------------------------------------------------
-- 휴가사항ID에 따른 DUTY_CODE 반환.
  FUNCTION DUTY_CODE_F
          ( W_HOLIDAY_TYPE                IN  VARCHAR2
          , W_SOB_ID                      IN  NUMBER
          , W_ORG_ID                      IN  NUMBER
          ) RETURN VARCHAR2;
						
---------------------------------------------------------------------------------------------------
-- 근태 실제 사용수 집계
  FUNCTION DUTY_USE_CAL_F
          ( W_DUTY_CODE                   IN  VARCHAR2
          , W_START_DATE                  IN  DATE
          , W_END_DATE                    IN  DATE
          , W_PERSON_ID                   IN  NUMBER
          , W_CORP_ID                     IN  NUMBER
          , W_SOB_ID                      IN  NUMBER
          , W_ORG_ID                      IN  NUMBER
          ) RETURN NUMBER;
						
END HRD_HOLIDAY_MANAGEMENT_G_SET;


 
/
CREATE OR REPLACE PACKAGE BODY HRD_HOLIDAY_MANAGEMENT_G_SET
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_DAY_INTERFACE_TRANS_G
/* DESCRIPTION  : 출퇴근내역 이첩 / 이첩 취소 관리.
/* REFERENCE BY : 기준일자 : 01-01 ==> 해당 년도 휴가사항 생성.
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
  PROCEDURE SET_MAIN
            ( P_DUTY_YEAR                 IN  VARCHAR2
						, P_CORP_ID                   IN  NUMBER
						, P_STD_DATE                  IN  DATE
						, P_PERSON_ID                 IN  NUMBER
						, P_DEPT_ID                   IN  NUMBER
						, P_SOB_ID                    IN  NUMBER
						, P_ORG_ID                    IN  NUMBER
						, P_USER_ID                   IN  NUMBER
            , O_STATUS                    OUT VARCHAR2
            , O_MESSAGE                   OUT VARCHAR2
						)
  AS
	BEGIN
    O_STATUS := 'F';
	  IF TO_CHAR(P_STD_DATE, 'MM-DD') = '01-01' THEN
		  -- 휴가사항 생성.
		  HOLIDAY_CREATE 
        ( P_DUTY_YEAR         => P_DUTY_YEAR
        , P_CORP_ID           => P_CORP_ID
        , P_STD_DATE          => P_STD_DATE
        , P_PERSON_ID         => P_PERSON_ID
        , P_DEPT_ID           => P_DEPT_ID
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_USER_ID           => P_USER_ID
        , O_STATUS            => O_STATUS
        , O_MESSAGE           => O_MESSAGE
        );
		ELSE
		  -- 휴가사항 집계.
		  HOLIDAY_USE_CAL
        ( P_DUTY_YEAR         => P_DUTY_YEAR
        , P_CORP_ID           => P_CORP_ID
        , P_STD_DATE          => P_STD_DATE
        , P_PERSON_ID         => P_PERSON_ID
        , P_DEPT_ID           => P_DEPT_ID
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_USER_ID           => P_USER_ID
        , O_STATUS            => O_STATUS
        , O_MESSAGE           => O_MESSAGE
        );
		END IF;
  END SET_MAIN;

---------------------------------------------------------------------------------------------------
-- HOLIDAY_MANAGEMENT EXECUTE INSERT.
  PROCEDURE EXE_INSERT
            ( P_HOLIDAY_TYPE              IN  VARCHAR2
            , P_DUTY_YEAR                 IN  VARCHAR2
            , P_PERSON_ID                 IN  NUMBER
            , P_CORP_ID                   IN  NUMBER
            , P_PRE_NEXT_NUM              IN  NUMBER
            , P_CREATION_NUM              IN  NUMBER
            , P_PLUS_NUM                  IN  NUMBER
						, P_USE_NUM                   IN  NUMBER
            , P_YEAR_COUNT                IN  NUMBER
            , P_EXCEPT_YN                 IN  VARCHAR2
            , P_WORKING_RATE              IN  NUMBER
            , P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    INSERT INTO HRD_HOLIDAY_MANAGEMENT
    ( PERSON_ID, HOLIDAY_TYPE, DUTY_YEAR
    , SOB_ID, ORG_ID
    , PRE_NEXT_NUM, CREATION_NUM, PLUS_NUM, USE_NUM
    , YEAR_COUNT, EXCEPT_YN, WORKING_RATE  
    , CREATION_DATE, CREATED_BY
    , LAST_UPDATE_DATE, LAST_UPDATED_BY
    ) VALUES
    ( P_PERSON_ID, P_HOLIDAY_TYPE, P_DUTY_YEAR
    , P_SOB_ID, P_ORG_ID
    , P_PRE_NEXT_NUM, P_CREATION_NUM, P_PLUS_NUM, P_USE_NUM
    , P_YEAR_COUNT, P_EXCEPT_YN, P_WORKING_RATE  
    , V_SYSDATE, P_USER_ID
    , V_SYSDATE, P_USER_ID
    );
	END EXE_INSERT;
            
-- HOLIDAY_MANAGEMENT EXECUTE UPDATE.
  PROCEDURE EXE_UPDATE
            ( W_HOLIDAY_TYPE              IN  VARCHAR2
            , W_DUTY_YEAR                 IN  VARCHAR2
            , W_PERSON_ID                 IN  NUMBER
						, W_CORP_ID                   IN  NUMBER
            , W_SOB_ID                    IN  NUMBER
            , W_ORG_ID                    IN  NUMBER
            , P_PRE_NEXT_NUM              IN  NUMBER
            , P_CREATION_NUM              IN  NUMBER
            , P_PLUS_NUM                  IN  NUMBER
						, P_USE_NUM                   IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    UPDATE HRD_HOLIDAY_MANAGEMENT HM
      SET HM.PRE_NEXT_NUM        = NVL(P_PRE_NEXT_NUM, 0)
        , HM.CREATION_NUM        = NVL(P_CREATION_NUM, 0)
        , HM.PLUS_NUM            = NVL(P_PLUS_NUM, 0)
        , HM.USE_NUM             = NVL(P_USE_NUM, 0)
        , HM.LAST_UPDATE_DATE    = V_SYSDATE
        , HM.LAST_UPDATED_BY     = P_USER_ID
    WHERE HM.HOLIDAY_TYPE        = W_HOLIDAY_TYPE
      AND HM.DUTY_YEAR           = W_DUTY_YEAR
      AND HM.PERSON_ID           = W_PERSON_ID
      AND HM.SOB_ID              = W_SOB_ID
      AND HM.ORG_ID              = W_ORG_ID
    ;
	END EXE_UPDATE;

-- HOLIDAY_MANAGEMENT EXECUTE DELETE.
  PROCEDURE EXE_DELETE
            ( W_HOLIDAY_TYPE              IN  VARCHAR2
            , W_DUTY_YEAR                 IN  VARCHAR2
            , W_STD_DATE                  IN  DATE
            , W_PERSON_ID                 IN  NUMBER
            , W_DEPT_ID                   IN  NUMBER
            , W_CORP_ID                   IN  NUMBER
            , W_SOB_ID                    IN  NUMBER
            , W_ORG_ID                    IN  NUMBER
            )
  AS
  BEGIN
    DELETE FROM HRD_HOLIDAY_MANAGEMENT HM
    WHERE HM.HOLIDAY_TYPE        = W_HOLIDAY_TYPE
      AND HM.DUTY_YEAR           = W_DUTY_YEAR
      AND HM.SOB_ID              = W_SOB_ID
      AND HM.ORG_ID              = W_ORG_ID
      AND EXISTS ( SELECT 'X'
                     FROM HRM_PERSON_MASTER PM
                        , (-- 시점 인사내역.
                           SELECT HL.PERSON_ID
                                , HL.DEPT_ID
                                , HL.POST_ID
                                , HL.JOB_CATEGORY_ID
                                , HL.JOB_CLASS_ID
                                , HL.OCPT_ID
                             FROM HRM_HISTORY_LINE HL
                            WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                             FROM HRM_HISTORY_LINE             S_HL
                                                            WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                              AND S_HL.CHARGE_DATE          <= W_STD_DATE
                                                         GROUP BY S_HL.PERSON_ID
                                                         )
                          ) T1
                    WHERE PM.PERSON_ID         = T1.PERSON_ID
                      AND PM.PERSON_ID         = HM.PERSON_ID
                      AND PM.PERSON_ID         = NVL(W_PERSON_ID, PM.PERSON_ID)
                      AND PM.WORK_CORP_ID      = W_CORP_ID
                      AND PM.SOB_ID            = W_SOB_ID
                      AND PM.ORG_ID            = W_ORG_ID
                      AND T1.DEPT_ID           = NVL(W_DEPT_ID, T1.DEPT_ID)
                  )
    ;
	END EXE_DELETE;
	
---------------------------------------------------------------------------------------------------
-- 휴가사항 집계 기간.
  PROCEDURE HOLIDAY_PERIOD_P
            ( W_DUTY_YEAR                 IN  VARCHAR2
            , W_SOB_ID                    IN  NUMBER
            , W_ORG_ID                    IN  NUMBER
            , O_START_DATE                OUT DATE
            , O_END_DATE                  OUT DATE
            )
  AS
	  V_START_DATE         DATE;    -- 휴가사항 집계 종료일자.
		V_END_DATE           DATE;    -- 휴가사항 집계 종료일자.
	BEGIN
	  -- 휴가사항 적용 기간 조회.
		BEGIN
		  SELECT  HT.START_DATE, HT.END_DATE
			  INTO V_START_DATE, V_END_DATE
			  FROM HRM_HOLIDAY_TERM_V HT
			 WHERE HT.HOLIDAY_YEAR       = W_DUTY_YEAR
			   AND HT.SOB_ID             = W_SOB_ID
				 AND HT.ORG_ID             = W_ORG_ID
				 AND HT.ENABLED_FLAG       = 'Y'
			;
		EXCEPTION WHEN OTHERS THEN
		  V_START_DATE := TO_DATE(W_DUTY_YEAR || '-01-01', 'YYYY-MM-DD');
			V_END_DATE := TO_DATE(W_DUTY_YEAR || '-12-31', 'YYYY-MM-DD');
		END;
	  O_START_DATE := V_START_DATE;
		O_END_DATE := V_END_DATE;
	END HOLIDAY_PERIOD_P;
	
---------------------------------------------------------------------------------------------------
  -- 매년도(1월1일) 휴가사항 생성 
	PROCEDURE HOLIDAY_CREATE
            ( P_DUTY_YEAR                 IN  VARCHAR2
            , P_CORP_ID                   IN  NUMBER
            , P_STD_DATE                  IN  DATE
            , P_PERSON_ID                 IN  NUMBER
            , P_DEPT_ID                   IN  NUMBER
            , P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            , O_STATUS                    OUT VARCHAR2
            , O_MESSAGE                   OUT VARCHAR2
            )
  AS
	  V_HOLIDAY_TYPE                                HRD_HOLIDAY_MANAGEMENT.HOLIDAY_TYPE%TYPE := NULL;
	BEGIN
    O_STATUS := 'F';
	  -- 년차 생성.
    V_HOLIDAY_TYPE := '1';
    YEAR_CREATE
      ( P_HOLIDAY_TYPE      => V_HOLIDAY_TYPE
      , P_DUTY_YEAR         => P_DUTY_YEAR
      , P_CORP_ID           => P_CORP_ID
      , P_STD_DATE          => P_STD_DATE
      , P_PERSON_ID         => P_PERSON_ID
      , P_DEPT_ID           => P_DEPT_ID
      , P_SOB_ID            => P_SOB_ID
      , P_ORG_ID            => P_ORG_ID
      , P_USER_ID           => P_USER_ID
      , O_STATUS            => O_STATUS
      , O_MESSAGE           => O_MESSAGE
      );

    -- 연중휴가 생성.
    /*V_HOLIDAY_TYPE := '2';
    SUMMER_CREATE
      ( P_HOLIDAY_TYPE      => V_HOLIDAY_TYPE
      , P_DUTY_YEAR         => P_DUTY_YEAR
      , P_CORP_ID           => P_CORP_ID
      , P_STD_DATE          => P_STD_DATE
      , P_PERSON_ID         => P_PERSON_ID
      , P_DEPT_ID           => P_DEPT_ID
      , P_SOB_ID            => P_SOB_ID
      , P_ORG_ID            => P_ORG_ID
      , P_USER_ID           => P_USER_ID
      , O_STATUS            => O_STATUS
      , O_MESSAGE           => O_MESSAGE
      );*/
	END HOLIDAY_CREATE;

-- 년차 생성.
  PROCEDURE YEAR_CREATE
            ( P_HOLIDAY_TYPE              IN  VARCHAR2
            , P_DUTY_YEAR                 IN  VARCHAR2
            , P_CORP_ID                   IN  NUMBER
            , P_STD_DATE                  IN  DATE
            , P_PERSON_ID                 IN  NUMBER
            , P_DEPT_ID                   IN  NUMBER
            , P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            , O_STATUS                    OUT VARCHAR2
            , O_MESSAGE                   OUT VARCHAR2
            )
  AS
	  CURSOR C_PERSON
		       ( W_STD_JOIN_DATE                      IN HRM_HOLIDAY_TYPE_V.STD_JOIN_DATE%TYPE
		       )
		IS
			SELECT PM.PERSON_ID
           , PM.DISPLAY_NAME
           , CASE 
               WHEN W_STD_JOIN_DATE = 'JOIN_DATE' THEN
                 CASE 
                   WHEN TO_CHAR(PM.JOIN_DATE, 'MM-DD') = '01-01' THEN PM.JOIN_DATE - 1
                   WHEN TO_CHAR(PM.JOIN_DATE, 'MM-DD') = '01-02' THEN PM.JOIN_DATE - 2
                   ELSE PM.JOIN_DATE
                 END
               ELSE 
                 CASE 
                   WHEN TO_CHAR(PM.ORI_JOIN_DATE, 'MM-DD') = '01-01' THEN PM.ORI_JOIN_DATE - 1
                   WHEN TO_CHAR(PM.ORI_JOIN_DATE, 'MM-DD') = '01-02' THEN PM.ORI_JOIN_DATE - 2
                   ELSE PM.ORI_JOIN_DATE
                 END
             END AS JOIN_DATE
           , PM.RETIRE_DATE
           , NVL(HT.START_DATE, TO_DATE(P_DUTY_YEAR || '-01-01', 'YYYY-MM-DD')) AS STD_START_DATE
           , NVL(HT.END_DATE, TO_DATE(P_DUTY_YEAR || '-12-31', 'YYYY-MM-DD')) AS STD_END_DATE
           , P_HOLIDAY_TYPE AS HOLIDAY_TYPE
           , P_DUTY_YEAR AS DUTY_YEAR
           , NVL(PH1.REMAIN_NUM, 0) AS PRE_REMAIN_NUM
           , NVL(PH1.YEAR_TRANS_NEXT_YN, 'N') AS PRE_TRANS_NEXT_YN
        FROM HRM_PERSON_MASTER PM
          , (-- 시점 인사내역.
             SELECT HL.PERSON_ID
                  , HL.DEPT_ID
                  , HL.POST_ID
                  , PC.POST_CODE
                  , PC.POST_NAME
                  , PC.HOLIDAY_CONTROL_YN
                  , HL.JOB_CATEGORY_ID
                  , HL.JOB_CLASS_ID
                  , HL.OCPT_ID
               FROM HRM_HISTORY_LINE HL
                  , HRM_POST_CODE_V PC
              WHERE HL.POST_ID          = PC.POST_ID
                AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                               FROM HRM_HISTORY_LINE             S_HL
                                              WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                AND S_HL.CHARGE_DATE          <= P_STD_DATE
                                           GROUP BY S_HL.PERSON_ID
                                           )
            ) T1
          , (-- 전년도 휴가사항 조회.
            SELECT HM.PERSON_ID
                 , HM.SOB_ID
                 , HM.ORG_ID
                 , HM.HOLIDAY_TYPE
                 , HM.DUTY_YEAR
                 , NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) - NVL(HM.USE_NUM, 0) AS REMAIN_NUM
                 , HT.YEAR_TRANS_NEXT_YN
              FROM HRD_HOLIDAY_MANAGEMENT HM
                , HRM_HOLIDAY_TERM_V HT
             WHERE HM.DUTY_YEAR           = HT.HOLIDAY_YEAR(+)
               AND HM.SOB_ID              = HT.SOB_ID(+)
               AND HM.ORG_ID              = HT.ORG_ID(+)
               AND HM.HOLIDAY_TYPE        = P_HOLIDAY_TYPE
               AND HM.DUTY_YEAR           = TO_CHAR(TO_NUMBER(P_DUTY_YEAR) - 1)
               AND HM.PERSON_ID           = NVL(P_PERSON_ID, HM.PERSON_ID)
               AND HM.SOB_ID              = P_SOB_ID
               AND HM.ORG_ID              = P_ORG_ID
            ) PH1
          , ( SELECT HT.SOB_ID
                 , HT.ORG_ID
                 , HT.START_DATE
                 , HT.END_DATE
              FROM HRM_HOLIDAY_TERM_V HT
             WHERE HT.HOLIDAY_YEAR        = P_DUTY_YEAR
               AND HT.SOB_ID              = P_SOB_ID
               AND HT.ORG_ID              = P_ORG_ID
            ) HT
       WHERE PM.PERSON_ID             = T1.PERSON_ID
         AND PM.PERSON_ID             = PH1.PERSON_ID(+)
         AND PM.SOB_ID                = HT.SOB_ID(+)
         AND PM.ORG_ID                = HT.ORG_ID(+)
         AND PM.WORK_CORP_ID          = P_CORP_ID
         AND PM.PERSON_ID             = NVL(P_PERSON_ID, PM.PERSON_ID)
         AND T1.DEPT_ID               = NVL(P_DEPT_ID, T1.DEPT_ID)
         AND PM.SOB_ID                = P_SOB_ID
         AND PM.ORG_ID                = P_ORG_ID
         AND T1.HOLIDAY_CONTROL_YN    = 'Y'
         AND PM.JOIN_DATE             <= P_STD_DATE
         AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= TRUNC(P_STD_DATE, 'MONTH'))
			;
		
		V_START_DATE                   HRD_DAY_LEAVE.WORK_DATE%TYPE;
		V_END_DATE                     HRD_DAY_LEAVE.WORK_DATE%TYPE;
		
		V_DUTY_CODE                    HRM_HOLIDAY_TYPE_V.DUTY_CODE%TYPE;
		V_STD_JOIN_DATE                HRM_HOLIDAY_TYPE_V.STD_JOIN_DATE%TYPE;
		V_MONTH_DAY_TYPE               HRM_HOLIDAY_TYPE_V.MONTH_DAY_TYPE%TYPE;
		V_MIN_PERIOD_NUM               HRM_HOLIDAY_TYPE_V.MIN_PERIOD_NUM%TYPE;
		V_BASE_NUM                     HRM_HOLIDAY_TYPE_V.BASE_CREATION_NUM%TYPE;
    V_LIMIT_NUM                    HRM_HOLIDAY_TYPE_V.LIMIT_CREATION_NUM%TYPE;        -- 연차 생성 한도;

    V_PRE_TRANS_NEXT_YN            HRD_HOLIDAY_MANAGEMENT.TRANS_NEXT_YN%TYPE;         -- 전년도 년차 이월 여부.
		
    V_PRE_NEXT_NUM                 HRD_HOLIDAY_MANAGEMENT.PRE_NEXT_NUM%TYPE;
    V_CREATION_NUM                 HRD_HOLIDAY_MANAGEMENT.CREATION_NUM%TYPE;
    V_PLUS_NUM                     HRD_HOLIDAY_MANAGEMENT.PLUS_NUM%TYPE;
		
		V_KNSOK_YEAR                   NUMBER := 0;
		
	BEGIN
    O_STATUS := 'F';
		-- 기초 발생수, 최대 발생수 기준정보 설정.
		BEGIN
		  SELECT HT.STD_JOIN_DATE, HT.MONTH_DAY_TYPE, HT.MIN_PERIOD_NUM
		       , HT.BASE_CREATION_NUM, HT.LIMIT_CREATION_NUM
			  INTO V_STD_JOIN_DATE, V_MONTH_DAY_TYPE, V_MIN_PERIOD_NUM
				   , V_BASE_NUM, V_LIMIT_NUM
			  FROM HRM_HOLIDAY_TYPE_V HT
			 WHERE HT.HOLIDAY_TYPE       = P_HOLIDAY_TYPE
			   AND HT.SOB_ID             = P_SOB_ID
				 AND HT.ORG_ID             = P_ORG_ID
				 AND HT.ENABLED_FLAG       = 'Y'
			;
		EXCEPTION WHEN OTHERS THEN
			O_STATUS := 'F';
      O_MESSAGE := 'Year Holiday(Standard Infomation) is not found';
      RETURN;
		END;
	  
		-- 근태코드.
		V_DUTY_CODE := DUTY_CODE_F ( W_HOLIDAY_TYPE => P_HOLIDAY_TYPE
		                           , W_SOB_ID => P_SOB_ID
															 , W_ORG_ID => P_ORG_ID
															 );
    IF V_DUTY_CODE IS NULL THEN
			O_STATUS := 'F';
      O_MESSAGE := 'Year Holiday(Duty ID) is not found';
      RETURN;
		END IF;
    
		-- 기존 휴가사항 삭제.
		EXE_DELETE ( W_HOLIDAY_TYPE => P_HOLIDAY_TYPE
		           , W_DUTY_YEAR => P_DUTY_YEAR
               , W_STD_DATE => P_STD_DATE
							 , W_PERSON_ID => P_PERSON_ID
							 , W_DEPT_ID => P_DEPT_ID
							 , W_CORP_ID => P_CORP_ID
							 , W_SOB_ID => P_SOB_ID
							 , W_ORG_ID => P_ORG_ID
							 );
							 
	  FOR C1 IN C_PERSON
		          ( V_STD_JOIN_DATE
							)
		LOOP
		  V_PRE_NEXT_NUM                 := 0;
			V_CREATION_NUM                 := 0;
			V_PLUS_NUM                     := 0;
			
			V_KNSOK_YEAR                   := 0;
			V_PRE_TRANS_NEXT_YN            := 'N';
			
			-- 적용 기간 설정.
			IF C1.STD_START_DATE < C1.JOIN_DATE THEN 
			  V_START_DATE := C1.JOIN_DATE;
			ELSE
			  V_START_DATE := C1.STD_START_DATE;
			END IF;
			IF NVL(C1.RETIRE_DATE, P_STD_DATE) < C1.STD_END_DATE THEN
			  V_END_DATE := NVL(C1.RETIRE_DATE, P_STD_DATE);
			ELSE 
			  V_END_DATE := C1.STD_END_DATE;
			END IF;
			
			-- 근속 계산.
			V_KNSOK_YEAR := HRM_COMMON_DATE_G.YEAR_COUNT_F( P_START_DATE => C1.JOIN_DATE
			                                              , P_END_DATE => P_STD_DATE
																										, P_COUNT_TYPE => 'TRUNC'
																										);
--DBMS_OUTPUT.PUT_LINE('성명 : ' || C1.DISPLAY_NAME || ', 근속 : ' || V_KNSOK_YEAR);
      IF V_KNSOK_YEAR < 1 THEN
  			-- 1년 미만.
				V_PLUS_NUM := YEAR_PLUS_0( W_CORP_ID => P_CORP_ID
																 , W_JOIN_DATE => C1.JOIN_DATE
																 , W_START_DATE => V_START_DATE
																 , W_END_DATE => V_END_DATE
																 , W_PERSON_ID => C1.PERSON_ID
																 , W_SOB_ID => P_SOB_ID
																 , W_ORG_ID => P_ORG_ID
																 );				
			ELSIF V_KNSOK_YEAR < 2 THEN
	  		-- 1년 이상 2년 미만.
				V_CREATION_NUM := V_BASE_NUM;
			ELSE
        -- 2년 이상자 --
			  V_CREATION_NUM := V_BASE_NUM + TRUNC((V_KNSOK_YEAR - 1) / 2);
			END IF;
			
			-- 전년도 잔여 연차수 이월.
			IF V_KNSOK_YEAR < 1 THEN
			-- 1년 미만자의 경우 사용수를 전년 이월수에 (-) 로 해서 이월 시킴.
			  V_PRE_NEXT_NUM := DUTY_USE_CAL_F( W_DUTY_CODE => V_DUTY_CODE
				                                , W_START_DATE => V_START_DATE
																				, W_END_DATE =>  V_END_DATE
																				, W_PERSON_ID => C1.PERSON_ID
																				, W_CORP_ID => P_CORP_ID
																				, W_SOB_ID => P_SOB_ID
																				, W_ORG_ID => P_ORG_ID
																				);
				V_PRE_NEXT_NUM := V_PRE_NEXT_NUM * -1;
      ELSIF V_KNSOK_YEAR < 2 THEN
			-- 1년 이상 2년 미만.
        -- 전호수 추가(2013-01-24) : 조선미S 요청 - 1년이상2년 미만자 잔여수 이월 --
        V_PRE_NEXT_NUM := C1.PRE_REMAIN_NUM;
			ELSE
			-- 1년 이상자는 전년도 이월여부에 따라 이월 처리.
			  IF C1.PRE_TRANS_NEXT_YN = 'Y' AND C1.PRE_REMAIN_NUM > 0 THEN
				  V_PRE_TRANS_NEXT_YN := 'Y';
					V_PRE_NEXT_NUM := C1.PRE_REMAIN_NUM;
				ELSIF C1.PRE_REMAIN_NUM < 0 THEN
					V_PRE_NEXT_NUM := C1.PRE_REMAIN_NUM * -1;
				END IF;
			END IF;
			--> 휴가 한도 설정;
			IF V_CREATION_NUM + V_PLUS_NUM > V_LIMIT_NUM THEN
			  V_CREATION_NUM := V_LIMIT_NUM;
			END IF;
			
			-- INSERT.
			EXE_INSERT( P_HOLIDAY_TYPE => P_HOLIDAY_TYPE
			          , P_DUTY_YEAR => P_DUTY_YEAR
								, P_PERSON_ID => C1.PERSON_ID
								, P_CORP_ID => P_CORP_ID
								, P_PRE_NEXT_NUM => V_PRE_NEXT_NUM
								, P_CREATION_NUM => V_CREATION_NUM
								, P_PLUS_NUM => V_PLUS_NUM
								, P_USE_NUM => 0
                , P_YEAR_COUNT  => V_KNSOK_YEAR
                , P_EXCEPT_YN   => 'N'
                , P_WORKING_RATE => 100
								, P_SOB_ID => P_SOB_ID
								, P_ORG_ID => P_ORG_ID
								, P_USER_ID => P_USER_ID
								);

		END LOOP C1;
    O_STATUS := 'S';
	END YEAR_CREATE;

-- 연중휴가 생성.
  PROCEDURE SUMMER_CREATE
            ( P_HOLIDAY_TYPE              IN  VARCHAR2
            , P_DUTY_YEAR                 IN  VARCHAR2
            , P_CORP_ID                   IN  NUMBER
            , P_STD_DATE                  IN  DATE
            , P_PERSON_ID                 IN  NUMBER
            , P_DEPT_ID                   IN  NUMBER
            , P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            , O_STATUS                    OUT VARCHAR2
            , O_MESSAGE                   OUT VARCHAR2
            )
  AS
	CURSOR C_PERSON
		       ( W_STD_JOIN_DATE                      IN HRM_HOLIDAY_TYPE_V.STD_JOIN_DATE%TYPE
		       )
		IS
			SELECT PM.PERSON_ID
					 , PM.DISPLAY_NAME
					 , CASE 
							 WHEN W_STD_JOIN_DATE = 'JOIN_DATE' THEN
								 CASE 
									 WHEN TO_CHAR(PM.JOIN_DATE, 'MM-DD') = '01-01' THEN PM.JOIN_DATE - 1
									 WHEN TO_CHAR(PM.JOIN_DATE, 'MM-DD') = '01-02' THEN PM.JOIN_DATE - 2
									 ELSE PM.JOIN_DATE
								 END
							 ELSE 
								 CASE 
									 WHEN TO_CHAR(PM.ORI_JOIN_DATE, 'MM-DD') = '01-01' THEN PM.ORI_JOIN_DATE - 1
									 WHEN TO_CHAR(PM.ORI_JOIN_DATE, 'MM-DD') = '01-02' THEN PM.ORI_JOIN_DATE - 2
									 ELSE PM.ORI_JOIN_DATE
								 END
						 END AS JOIN_DATE
					 , PM.RETIRE_DATE
				FROM HRM_PERSON_MASTER PM
					, HRM_POST_CODE_V PC
			 WHERE PM.POST_ID               = PC.POST_ID
				 AND PM.SOB_ID                = PC.SOB_ID
				 AND PM.ORG_ID                = PC.ORG_ID
				 AND PM.CORP_ID               = P_CORP_ID
				 AND PM.PERSON_ID             = NVL(P_PERSON_ID, PM.PERSON_ID)
				 AND PM.SOB_ID                = P_SOB_ID
				 AND PM.ORG_ID                = P_ORG_ID
				 AND PC.HOLIDAY_CONTROL_YN    = 'Y'
				 AND PM.ORI_JOIN_DATE         <= P_STD_DATE
				 AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= TRUNC(P_STD_DATE, 'MONTH'))
			;
		
		V_STD_DATE                     HRM_PERSON_MASTER.JOIN_DATE%TYPE;
				
		V_DUTY_CODE                    HRM_HOLIDAY_TYPE_V.DUTY_CODE%TYPE;
		V_STD_JOIN_DATE                HRM_HOLIDAY_TYPE_V.STD_JOIN_DATE%TYPE;
		V_MONTH_DAY_TYPE               HRM_HOLIDAY_TYPE_V.MONTH_DAY_TYPE%TYPE;
		V_MIN_PERIOD_NUM               HRM_HOLIDAY_TYPE_V.MIN_PERIOD_NUM%TYPE;
		V_BASE_NUM                     HRM_HOLIDAY_TYPE_V.BASE_CREATION_NUM%TYPE;
    V_LIMIT_NUM                    HRM_HOLIDAY_TYPE_V.LIMIT_CREATION_NUM%TYPE;        -- 연차 생성 한도;

    V_PRE_TRANS_NEXT_YN            HRD_HOLIDAY_MANAGEMENT.TRANS_NEXT_YN%TYPE;         -- 전년도 년차 이월 여부.
		
    V_PRE_NEXT_NUM                 HRD_HOLIDAY_MANAGEMENT.PRE_NEXT_NUM%TYPE;
    V_CREATION_NUM                 HRD_HOLIDAY_MANAGEMENT.CREATION_NUM%TYPE;

		
	BEGIN
    O_STATUS := 'F';
		-- 기초 발생수, 최대 발생수 기준정보 설정.
		BEGIN
		  SELECT HT.STD_JOIN_DATE, HT.MONTH_DAY_TYPE, HT.MIN_PERIOD_NUM
		       , HT.BASE_CREATION_NUM, HT.LIMIT_CREATION_NUM
			  INTO V_STD_JOIN_DATE, V_MONTH_DAY_TYPE, V_MIN_PERIOD_NUM
				   , V_BASE_NUM, V_LIMIT_NUM
			  FROM HRM_HOLIDAY_TYPE_V HT
			 WHERE HT.HOLIDAY_TYPE       = P_HOLIDAY_TYPE
			   AND HT.SOB_ID             = P_SOB_ID
				 AND HT.ORG_ID             = P_ORG_ID
				 AND HT.ENABLED_FLAG       = 'Y'
			;
		EXCEPTION WHEN OTHERS THEN
			O_STATUS := 'F';
      O_MESSAGE := 'Summer Holiday(Standard Infomation) is not found';
      RETURN;
		END;  
	  
		-- 근태코드.
		V_DUTY_CODE := DUTY_CODE_F ( W_HOLIDAY_TYPE => P_HOLIDAY_TYPE
		                           , W_SOB_ID => P_SOB_ID
															 , W_ORG_ID => P_ORG_ID
															 );
    IF V_DUTY_CODE IS NULL THEN
			O_STATUS := 'F';
      O_MESSAGE := 'Summer Holiday(Duty ID) is not found';
      RETURN;
		END IF;
		
		-- 기존 휴가사항 삭제.
		EXE_DELETE ( W_HOLIDAY_TYPE => P_HOLIDAY_TYPE
		           , W_DUTY_YEAR => P_DUTY_YEAR
               , W_STD_DATE => P_STD_DATE
							 , W_PERSON_ID => P_PERSON_ID
							 , W_DEPT_ID => P_DEPT_ID
							 , W_CORP_ID => P_CORP_ID
							 , W_SOB_ID => P_SOB_ID
							 , W_ORG_ID => P_ORG_ID
							 );
							 
	  FOR C1 IN C_PERSON
		          ( V_STD_JOIN_DATE
							)
		LOOP
		  V_PRE_NEXT_NUM                 := 0;
			V_CREATION_NUM                 := 0;
			
			-- 적용 기간 설정.
			IF V_MONTH_DAY_TYPE = 'DAY' THEN
				V_STD_DATE := P_STD_DATE + (V_MIN_PERIOD_NUM * -1);
			ELSE
				V_STD_DATE := ADD_MONTHS(P_STD_DATE, V_MIN_PERIOD_NUM * -1);
			END IF;
			
			-- 연중휴가 적용.
			IF C1.JOIN_DATE < V_STD_DATE THEN
				V_CREATION_NUM := V_BASE_NUM;
			ELSE
				V_CREATION_NUM := 0;
			END IF;
						
			--> 휴가 한도 설정;
			IF V_CREATION_NUM > V_LIMIT_NUM THEN
			  V_CREATION_NUM := V_LIMIT_NUM;
			END IF;
			
			-- INSERT.
			EXE_INSERT( P_HOLIDAY_TYPE => P_HOLIDAY_TYPE
			          , P_DUTY_YEAR => P_DUTY_YEAR
								, P_PERSON_ID => C1.PERSON_ID
								, P_CORP_ID => P_CORP_ID
								, P_PRE_NEXT_NUM => V_PRE_NEXT_NUM
								, P_CREATION_NUM => V_CREATION_NUM
								, P_PLUS_NUM => 0
								, P_USE_NUM => 0
                , P_YEAR_COUNT  => 0
                , P_EXCEPT_YN   => 'N'
                , P_WORKING_RATE => 100
								, P_SOB_ID => P_SOB_ID
								, P_ORG_ID => P_ORG_ID
								, P_USER_ID => P_USER_ID
								);

		END LOOP C1;
    O_STATUS := 'S';
	END SUMMER_CREATE;

  -- 년차수당 계산
  PROCEDURE AMT_CALCULATE
            ( P_DUTY_YEAR                 IN  VARCHAR2
            , P_CORP_ID                   IN  NUMBER
            , P_STD_DATE                  IN  DATE
            , P_PERSON_ID                 IN  NUMBER
            , P_DEPT_ID                   IN  NUMBER
            , P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            , O_STATUS                    OUT VARCHAR2
            , O_MESSAGE                   OUT VARCHAR2
            )
  AS
    V_STD_YEAR_RATE                               NUMBER;    -- 지급율. 
     
    V_BASE_AMT                                    NUMBER;    -- 기본급.
    V_ETC_AMT                                     NUMBER;    -- 기타수당.
    V_BASIC_AMT                                   NUMBER;    -- 기본급.
    V_YEAR_AMT                                    NUMBER;    -- 연차수당.
    V_YEAR_CNT                                    NUMBER;    -- 잔여 연차수.
  BEGIN
    O_STATUS := 'F';
    V_STD_YEAR_RATE := 1;
    FOR C1 IN  (SELECT PM.PERSON_ID
                    , PM.NAME
                    , PM.CORP_ID
                    , PM.ORI_JOIN_DATE
                    , PM.JOIN_DATE
                    , PM.RETIRE_DATE
                    , PM.PAY_GRADE_ID
                    , PM.SOB_ID
                    , PM.ORG_ID
                    , PMH1.PAY_TYPE                     
                    , CASE 
                        WHEN (MONTHS_BETWEEN(P_STD_DATE + 1,  PM.ORI_JOIN_DATE) / 12) < 1 AND NVL(PM.RETIRE_DATE, SYSDATE + 1) <= P_STD_DATE
                            THEN NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) - NVL(HM.USE_NUM, 0)
                        ELSE NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) - NVL(HM.USE_NUM, 0)
                      END AS REMAIN_NUM
                  FROM HRD_HOLIDAY_MANAGEMENT HM
                    , HRM_PERSON_MASTER PM
                    , HRM_PAY_GRADE_V PG
                    , ( SELECT PMH.PERSON_ID
                             , PMH.SOB_ID
                             , PMH.ORG_ID
                             , PMH.PAY_TYPE
                          FROM HRP_PAY_MASTER_HEADER PMH
                        WHERE PMH.CORP_ID       = P_CORP_ID
                          AND PMH.SOB_ID        = P_SOB_ID
                          AND PMH.ORG_ID        = P_ORG_ID
                          AND PMH.START_YYYYMM  <= TO_CHAR(P_STD_DATE, 'YYYY-MM')
                          AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= TO_CHAR(P_STD_DATE, 'YYYY-MM'))
                       ) PMH1
                WHERE HM.PERSON_ID      = PM.PERSON_ID
                  AND PM.PAY_GRADE_ID   = PG.PAY_GRADE_ID
                  AND PM.PERSON_ID      = PMH1.PERSON_ID(+)
                  AND HM.HOLIDAY_TYPE   = '1' -- 년차.
                  AND HM.DUTY_YEAR      = P_DUTY_YEAR
                  AND PM.WORK_CORP_ID   = P_CORP_ID
                  AND PM.PERSON_ID      = NVL(P_PERSON_ID, PM.PERSON_ID)
                  AND PM.DEPT_ID        = NVL(P_DEPT_ID, PM.DEPT_ID)     
                  AND PM.SOB_ID         = P_SOB_ID
                  AND PM.ORG_ID         = P_ORG_ID             
                  AND (PM.JOIN_DATE     <= P_STD_DATE)
                  AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= TRUNC(P_STD_DATE, 'MONTH'))
                  AND (PG.OFFICER_YN IS NULL OR PG.OFFICER_YN <> 'Y')
                )
    LOOP
       V_BASIC_AMT := 0;
       V_ETC_AMT   := 0;
       V_BASE_AMT  := 0;
       V_YEAR_AMT  := 0;
       V_YEAR_CNT  := 0;
       
       --> 기본급    
       BEGIN
          SELECT PML.ALLOWANCE_AMOUNT
            INTO V_BASIC_AMT 
          FROM HRP_PAY_MASTER_HEADER PMH
            , HRP_PAY_MASTER_LINE PML
            , HRM_ALLOWANCE_V HA
          WHERE PMH.PAY_HEADER_ID = PML.PAY_HEADER_ID
            AND PML.ALLOWANCE_ID  = HA.ALLOWANCE_ID
            AND PMH.PERSON_ID     = C1.PERSON_ID
            AND PMH.CORP_ID       = C1.CORP_ID
            AND PMH.START_YYYYMM  <= TO_CHAR(P_STD_DATE, 'YYYY-MM')
            AND (PMH.END_YYYYMM    >= TO_CHAR(P_STD_DATE, 'YYYY-MM'))
            AND PMH.SOB_ID         = C1.SOB_ID
            AND PMH.ORG_ID         = C1.ORG_ID
            AND HA.ALLOWANCE_TYPE  = 'BASIC'
          ;
       EXCEPTION WHEN OTHERS THEN
      	 V_BASIC_AMT := 0;
       END;
       
       -- 직책수당.
       BEGIN
          SELECT PML.ALLOWANCE_AMOUNT
            INTO V_ETC_AMT 
          FROM HRP_PAY_MASTER_HEADER PMH
            , HRP_PAY_MASTER_LINE PML
            , HRM_ALLOWANCE_V HA
          WHERE PMH.PAY_HEADER_ID = PML.PAY_HEADER_ID
            AND PML.ALLOWANCE_ID  = HA.ALLOWANCE_ID
            AND PMH.PERSON_ID     = C1.PERSON_ID
            AND PMH.CORP_ID       = C1.CORP_ID
            AND PMH.START_YYYYMM  <= TO_CHAR(P_STD_DATE, 'YYYY-MM')
            AND (PMH.END_YYYYMM    >= TO_CHAR(P_STD_DATE, 'YYYY-MM'))
            AND PMH.SOB_ID         = C1.SOB_ID
            AND PMH.ORG_ID         = C1.ORG_ID
            AND HA.ALLOWANCE_CODE  = 'A02'                -- 직책수당.
          ;
       EXCEPTION WHEN OTHERS THEN
      	 V_ETC_AMT := 0;
       END;
       
       --> 근속년수.
       V_YEAR_CNT := HRM_COMMON_DATE_G.YEAR_COUNT_F(C1.ORI_JOIN_DATE, P_STD_DATE, 'TRUNC');
       /*V_ETC_AMT := HRP_MONTH_PAYMENT_G_SET.LONG_ALLOWANCE( C1.CORP_ID
                                                          , TO_CHAR(P_STD_DATE, 'YYYY-MM')
                                                          , 'P1'
                                                          , NULL
                                                          , NULL
                                                          , C1.PERSON_ID
                                                          , P_STD_DATE
                                                          , 'N'
                                                          , C1.SOB_ID
                                                          , C1.ORG_ID
                                                          , P_USER_ID
                                                          );       */
       /*--> 근속수당  
          BEGIN  
            SELECT CASE
                    WHEN C1.PAY_CODE = '3' THEN V_BASIC_AMT + V_ETC_AMT
                    WHEN C1.PAY_CODE = '1' THEN V_BASIC_AMT + V_ETC_AMT
                    WHEN C1.PAY_CODE = '2' THEN (V_BASIC_AMT * 30) + V_ETC_AMT
                    ELSE (V_BASIC_AMT * 30) + V_ETC_AMT
                  END V_BASE_AMT
              INTO V_BASE_AMT
            FROM DUAL
            ;
            V_BASE_AMT := (V_BASE_AMT / 30) * V_STD_YEAR_RATE;
          
          EXCEPTION WHEN OTHERS THEN
            V_BASE_AMT := 0;
          END;                                                             
       
       ELSE
         V_ETC_AMT := INS_PAYROLL_PKG_001_2009.F_BASIC_PAY2_AMT(C1.LEGAL_ORG_ID
                                                           ,TO_CHAR(P_STD_DATE, 'YYYYMM')
                                                           ,C1.PERSON_NUMB
                                                           ,'HG00'
                                                           ,'HG01'
                                                           ,C1.PAY_CODE
                                                           ,V_YEAR_CNT
                                                           ,C1.PAY_GRADE1
                                                           ,C1.PAY_GRADE3
                                                           ,'');    
         --> 직책수당  
         V_ETC_AMT := V_ETC_AMT +
                                INS_PAYROLL_PKG_001_2009.F_BASIC_PAY2_AMT(C1.LEGAL_ORG_ID
                                                           ,TO_CHAR(P_STD_DATE, 'YYYYMM')
                                                           ,C1.PERSON_NUMB
                                                           ,'HG00'
                                                           ,'HG07'
                                                           ,C1.PAY_CODE
                                                           ,V_YEAR_CNT
                                                           ,C1.PAY_GRADE1
                                                           ,C1.PAY_GRADE3
                                                           ,'');       
            
       END IF;*/
      BEGIN
        SELECT CASE
                WHEN C1.PAY_TYPE = '3' THEN ROUND(NVL(V_BASIC_AMT, 0) / 30)     -- 연봉제.
                WHEN C1.PAY_TYPE = '1' THEN ROUND(NVL(V_BASIC_AMT, 0) / 30)     -- 월급제.
                WHEN C1.PAY_TYPE = '2' THEN NVL(V_BASIC_AMT, 0) + (ROUND(V_ETC_AMT / 209, 0) * 8)  -- 일급제.
                ELSE (NVL(V_BASIC_AMT, 0) + ROUND(V_ETC_AMT / 209, 0)) * 8  -- 시급제.
              END V_BASE_AMT
          INTO V_BASE_AMT
        FROM DUAL
        ;         
        V_BASE_AMT := V_BASE_AMT * V_STD_YEAR_RATE;                        
      EXCEPTION WHEN OTHERS THEN
        V_BASE_AMT  := 0;
      END;
--DBMS_OUTPUT.PUT_LINE('V_BASE_AMT=>' || V_BASIC_AMT || '//V_ETC_AMT=>' || V_ETC_AMT);         
       BEGIN                     
          IF C1.REMAIN_NUM > 0 THEN
            V_YEAR_AMT := TRUNC(V_BASE_AMT * C1.REMAIN_NUM, -1);
          ELSE
            V_YEAR_AMT := 0;
          END IF;
       EXCEPTION WHEN OTHERS THEN
         V_YEAR_AMT := 0;
         O_MESSAGE := 'YEAR AMT ERROR : ' || SUBSTR(SQLERRM, 1, 150);
         ROLLBACK;
         RETURN;
       END;
--DBMS_OUTPUT.PUT_LINE('REMAIN_NUM=>' || C1.REMAIN_NUM || '//V_YEAR_AMT=>' || V_YEAR_AMT);                  
       BEGIN
         IF V_YEAR_AMT >= 0 THEN
           UPDATE HRD_HOLIDAY_MANAGEMENT HM
             SET HM.BASE_AMOUNT     = V_BASIC_AMT
               , HM.GENERAL_AMOUNT  = V_BASE_AMT
               , HM.PAY_AMOUNT      = V_YEAR_AMT
               , HM.TRANS_PAY_YN    = 'N'
               , HM.LAST_UPDATE_DATE   = GET_LOCAL_DATE(HM.SOB_ID)
               , HM.LAST_UPDATED_BY    = P_USER_ID
           WHERE HM.HOLIDAY_TYPE    = '1'
             AND HM.DUTY_YEAR       = P_DUTY_YEAR
             AND HM.PERSON_ID       = C1.PERSON_ID
             AND HM.SOB_ID          = C1.SOB_ID
             AND HM.ORG_ID          = C1.ORG_ID
           ;
         END IF;
       END;
    END LOOP C1;
    O_STATUS := 'S';
  END AMT_CALCULATE;
  

---------------------------------------------------------------------------------------------------
  -- 휴가사항 사용수 집계.
	PROCEDURE HOLIDAY_USE_CAL
            ( P_DUTY_YEAR                 IN  VARCHAR2
            , P_CORP_ID                   IN  NUMBER
            , P_STD_DATE                  IN  DATE
            , P_PERSON_ID                 IN  NUMBER
            , P_DEPT_ID                   IN  NUMBER
            , P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            , O_STATUS                    OUT VARCHAR2
            , O_MESSAGE                   OUT VARCHAR2
            )
  AS
		V_START_DATE          HRD_DAY_LEAVE.WORK_DATE%TYPE;    -- 휴가사항 집계 시작일자.
		V_END_DATE            HRD_DAY_LEAVE.WORK_DATE%TYPE;    -- 휴가사항 집계 종료일자.
		
		V_KNSOK_YEAR          NUMBER := 0;                     -- 근속년수.
	BEGIN
    O_STATUS := 'F';
	  -- 적용 기간.
		HOLIDAY_PERIOD_P ( W_DUTY_YEAR => P_DUTY_YEAR
		                 , W_SOB_ID => P_SOB_ID
										 , W_ORG_ID => P_ORG_ID
										 , O_START_DATE => V_START_DATE
										 , O_END_DATE => V_END_DATE
										 ); 
	  
	  FOR C1 IN  ( SELECT HT.HOLIDAY_TYPE
			                  , HT.HOLIDAY_TYPE_NAME
												, HT.DUTY_CODE
			               FROM HRM_HOLIDAY_TYPE_V HT
										WHERE HT.ENABLED_FLAG        = 'Y'
										  AND HT.SOB_ID              = P_SOB_ID
											AND HT.ORG_ID              = P_ORG_ID
								 )
    LOOP
			IF C1.HOLIDAY_TYPE = '1' THEN
				YEAR_CAL(  P_HOLIDAY_TYPE => C1.HOLIDAY_TYPE
				         , P_DUTY_YEAR => P_DUTY_YEAR
								 , P_CORP_ID => P_CORP_ID
								 , P_STD_DATE => P_STD_DATE
								 , P_START_DATE => V_START_DATE
								 , P_END_DATE => V_END_DATE
								 , P_PERSON_ID => P_PERSON_ID
								 , P_DEPT_ID => P_DEPT_ID
								 , P_SOB_ID => P_SOB_ID
								 , P_ORG_ID => P_ORG_ID
								 , P_USER_ID => P_USER_ID
                 , O_STATUS => O_STATUS
								 , O_MESSAGE => O_MESSAGE
								 ); 
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF; 
			/*
      ELSIF C1.HOLIDAY_TYPE = '2' THEN
				SUMMER_CAL ( P_HOLIDAY_TYPE => C1.HOLIDAY_TYPE
				         , P_DUTY_YEAR => P_DUTY_YEAR
									 , P_CORP_ID => P_CORP_ID
									 , P_STD_DATE => P_STD_DATE
									 , P_PERSON_ID => P_PERSON_ID
									 , P_SOB_ID => P_SOB_ID
									 , P_ORG_ID => P_ORG_ID
									 , P_USER_ID => P_USER_ID
									 , O_STATUS => O_STATUS
								   , O_MESSAGE => O_MESSAGE
									 ); 
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF; 
			ELSIF C1.HOLIDAY_TYPE = '3' THEN
				SPECIAL_CAL( P_HOLIDAY_TYPE => C1.HOLIDAY_TYPE
				           , P_DUTY_YEAR => P_DUTY_YEAR
									 , P_CORP_ID => P_CORP_ID
									 , P_STD_DATE => P_STD_DATE
									 , P_PERSON_ID => P_PERSON_ID
									 , P_SOB_ID => P_SOB_ID
									 , P_ORG_ID => P_ORG_ID
									 , P_USER_ID => P_USER_ID
									 , O_STATUS => O_STATUS
								   , O_MESSAGE => O_MESSAGE
									 ); 
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF; */
			END IF; 
		END LOOP C1;
		O_STATUS := 'S';
	END HOLIDAY_USE_CAL;
						
-- 1년 미만자 년차 생성 및 년차 사용수 집계
  PROCEDURE YEAR_CAL
            ( P_HOLIDAY_TYPE              IN  VARCHAR2
            , P_DUTY_YEAR                 IN  VARCHAR2
            , P_CORP_ID                   IN  NUMBER
            , P_STD_DATE                  IN  DATE
            , P_START_DATE                IN  DATE
            , P_END_DATE                  IN  DATE
            , P_PERSON_ID                 IN  NUMBER
            , P_DEPT_ID                   IN  NUMBER
            , P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            , O_STATUS                    OUT VARCHAR2
            , O_MESSAGE                   OUT VARCHAR2
            )
  AS
	CURSOR C_PERSON
		       ( W_STD_JOIN_DATE                      IN HRM_HOLIDAY_TYPE_V.STD_JOIN_DATE%TYPE
		       )
		IS
			SELECT PM.PERSON_ID
           , PM.DISPLAY_NAME
           , CASE 
               WHEN W_STD_JOIN_DATE = 'JOIN_DATE' THEN
                 CASE 
                   WHEN TO_CHAR(PM.JOIN_DATE, 'MM-DD') = '01-01' THEN PM.JOIN_DATE - 1
                   WHEN TO_CHAR(PM.JOIN_DATE, 'MM-DD') = '01-02' THEN PM.JOIN_DATE - 2
                   ELSE PM.JOIN_DATE
                 END
               ELSE 
                 CASE 
                   WHEN TO_CHAR(PM.ORI_JOIN_DATE, 'MM-DD') = '01-01' THEN PM.ORI_JOIN_DATE - 1
                   WHEN TO_CHAR(PM.ORI_JOIN_DATE, 'MM-DD') = '01-02' THEN PM.ORI_JOIN_DATE - 2
                   ELSE PM.ORI_JOIN_DATE
                 END
             END AS JOIN_DATE
           , PM.RETIRE_DATE
           , NVL(NH1.PRE_NEXT_NUM, 0) AS PRE_NEXT_NUM
           , NVL(NH1.CREATION_NUM, 0) AS CREATION_NUM
           , NVL(NH1.PLUS_NUM, 0) AS PLUS_NUM
           , PH1.HOLIDAY_TYPE
           , PH1.DUTY_YEAR
           , NVL(PH1.USE_NUM, 0) AS PRE_USE_NUM
           , NVL(PH1.REMAIN_NUM, 0) AS PRE_REMAIN_NUM
           , NVL(PH1.YEAR_TRANS_NEXT_YN, 'N') AS PRE_TRANS_NEXT_YN
        FROM HRM_PERSON_MASTER PM
          , (-- 시점 인사내역.
             SELECT HL.PERSON_ID
                  , HL.DEPT_ID
                  , HL.POST_ID
                  , PC.POST_CODE
                  , PC.POST_NAME
                  , PC.HOLIDAY_CONTROL_YN
                  , HL.JOB_CATEGORY_ID
                  , HL.JOB_CLASS_ID
                  , HL.OCPT_ID
               FROM HRM_HISTORY_LINE HL
                  , HRM_POST_CODE_V PC
              WHERE HL.POST_ID          = PC.POST_ID
                AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                               FROM HRM_HISTORY_LINE             S_HL
                                              WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                AND S_HL.CHARGE_DATE          <= P_STD_DATE
                                           GROUP BY S_HL.PERSON_ID
                                           )
            ) T1
          , (-- 금년도 휴가사항 조회.
            SELECT HM.PERSON_ID
                 , HM.SOB_ID
                 , HM.ORG_ID
                 , HM.HOLIDAY_TYPE
                 , HM.DUTY_YEAR
                 , NVL(HM.PRE_NEXT_NUM, 0) AS PRE_NEXT_NUM
                 , NVL(HM.CREATION_NUM, 0) AS CREATION_NUM
                 , NVL(HM.PLUS_NUM, 0) AS PLUS_NUM
                 , NVL(HM.USE_NUM, 0) AS USE_NUM
                 , NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) - NVL(HM.USE_NUM, 0) AS REMAIN_NUM
                 , NVL(HT.YEAR_TRANS_NEXT_YN, 'N') AS YEAR_TRANS_NEXT_YN
                 , NVL(HT.START_DATE, TO_DATE(HM.DUTY_YEAR || '-01-01', 'YYYY-MM-DD')) AS START_DATE
                 , NVL(HT.END_DATE, TO_DATE(HM.DUTY_YEAR || '-12-31', 'YYYY-MM-DD')) AS END_DATE
              FROM HRD_HOLIDAY_MANAGEMENT HM
                , HRM_HOLIDAY_TERM_V HT
             WHERE HM.DUTY_YEAR           = HT.HOLIDAY_YEAR(+)
               AND HM.SOB_ID              = HT.SOB_ID(+)
               AND HM.ORG_ID              = HT.ORG_ID(+)
               AND HM.HOLIDAY_TYPE        = P_HOLIDAY_TYPE
               AND HM.DUTY_YEAR           = P_DUTY_YEAR
               AND HM.PERSON_ID           = NVL(P_PERSON_ID, HM.PERSON_ID)
               AND HM.SOB_ID              = P_SOB_ID
               AND HM.ORG_ID              = P_ORG_ID
            ) NH1
          , (-- 전년도 휴가사항 조회.
            SELECT HM.PERSON_ID
                 , HM.SOB_ID
                 , HM.ORG_ID
                 , HM.HOLIDAY_TYPE
                 , HM.DUTY_YEAR
                 , NVL(HM.USE_NUM, 0) AS USE_NUM
                 , NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) - NVL(HM.USE_NUM, 0) AS REMAIN_NUM
                 , NVL(HT.YEAR_TRANS_NEXT_YN, 'N') AS YEAR_TRANS_NEXT_YN
                 , NVL(HT.START_DATE, TO_DATE(HM.DUTY_YEAR || '-01-01', 'YYYY-MM-DD')) AS START_DATE
                 , NVL(HT.END_DATE, TO_DATE(HM.DUTY_YEAR || '-12-31', 'YYYY-MM-DD')) AS END_DATE
              FROM HRD_HOLIDAY_MANAGEMENT HM
                , HRM_HOLIDAY_TERM_V HT
             WHERE HM.DUTY_YEAR           = HT.HOLIDAY_YEAR(+)
               AND HM.SOB_ID              = HT.SOB_ID(+)
               AND HM.ORG_ID              = HT.ORG_ID(+)
               AND HM.HOLIDAY_TYPE        = P_HOLIDAY_TYPE
               AND HM.DUTY_YEAR           = P_DUTY_YEAR - 1
               AND HM.PERSON_ID           = NVL(P_PERSON_ID, HM.PERSON_ID)
               AND HM.SOB_ID              = P_SOB_ID
               AND HM.ORG_ID              = P_ORG_ID
            ) PH1          
       WHERE PM.PERSON_ID             = T1.PERSON_ID
         AND PM.PERSON_ID             = NH1.PERSON_ID(+)
         AND PM.PERSON_ID             = PH1.PERSON_ID(+)
         AND PM.WORK_CORP_ID          = P_CORP_ID
         AND PM.PERSON_ID             = NVL(P_PERSON_ID, PM.PERSON_ID)
         AND T1.DEPT_ID               = NVL(P_DEPT_ID, T1.DEPT_ID)
         AND PM.SOB_ID                = P_SOB_ID
         AND PM.ORG_ID                = P_ORG_ID
         AND T1.HOLIDAY_CONTROL_YN    = 'Y'
         AND PM.ORI_JOIN_DATE         <= P_STD_DATE
         AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= TRUNC(P_STD_DATE, 'MONTH'))
			;
		
		V_STD_START_DATE               DATE;
    V_STD_END_DATE                 DATE;
		V_START_DATE                   HRD_DAY_LEAVE.WORK_DATE%TYPE;
		V_END_DATE                     HRD_DAY_LEAVE.WORK_DATE%TYPE;
		
		V_DUTY_CODE                    HRM_HOLIDAY_TYPE_V.DUTY_CODE%TYPE;
		V_STD_JOIN_DATE                HRM_HOLIDAY_TYPE_V.STD_JOIN_DATE%TYPE;
		V_MONTH_DAY_TYPE               HRM_HOLIDAY_TYPE_V.MONTH_DAY_TYPE%TYPE;
		V_MIN_PERIOD_NUM               HRM_HOLIDAY_TYPE_V.MIN_PERIOD_NUM%TYPE;
		V_BASE_NUM                     HRM_HOLIDAY_TYPE_V.BASE_CREATION_NUM%TYPE;
    V_LIMIT_NUM                    HRM_HOLIDAY_TYPE_V.LIMIT_CREATION_NUM%TYPE;        -- 연차 생성 한도;

    V_PRE_TRANS_NEXT_YN            HRD_HOLIDAY_MANAGEMENT.TRANS_NEXT_YN%TYPE;         -- 전년도 년차 이월 여부.
		
    V_PRE_NEXT_NUM                 HRD_HOLIDAY_MANAGEMENT.PRE_NEXT_NUM%TYPE;
    V_CREATION_NUM                 HRD_HOLIDAY_MANAGEMENT.CREATION_NUM%TYPE;
    V_PLUS_NUM                     HRD_HOLIDAY_MANAGEMENT.PLUS_NUM%TYPE;
		V_USE_NUM                      HRD_HOLIDAY_MANAGEMENT.USE_NUM%TYPE;
		
		V_KNSOK_YEAR                   NUMBER := 0;
		V_JOIN_DAY                     NUMBER := 0;
		
	BEGIN
    O_STATUS := 'F';
	  -- 기초 발생수, 최대 발생수 기준정보 설정.
		BEGIN
		  SELECT HT.STD_JOIN_DATE, HT.MONTH_DAY_TYPE, HT.MIN_PERIOD_NUM
		       , HT.BASE_CREATION_NUM, HT.LIMIT_CREATION_NUM
			  INTO V_STD_JOIN_DATE, V_MONTH_DAY_TYPE, V_MIN_PERIOD_NUM
				   , V_BASE_NUM, V_LIMIT_NUM
			  FROM HRM_HOLIDAY_TYPE_V HT
			 WHERE HT.HOLIDAY_TYPE       = P_HOLIDAY_TYPE
			   AND HT.SOB_ID             = P_SOB_ID
				 AND HT.ORG_ID             = P_ORG_ID
				 AND HT.ENABLED_FLAG       = 'Y'
			;
		EXCEPTION WHEN OTHERS THEN
			O_STATUS := 'F';
      O_MESSAGE := ERRNUMS.Data_Not_Found_Desc;
      RETURN;
		END;  
    
	  -- 집계 기간 --
    HOLIDAY_PERIOD_P ( W_DUTY_YEAR => P_DUTY_YEAR
		                 , W_SOB_ID => P_SOB_ID
										 , W_ORG_ID => P_ORG_ID
										 , O_START_DATE => V_STD_START_DATE
										 , O_END_DATE => V_STD_END_DATE
										 ); 
--raise_application_error(-20001, to_char(V_STD_START_DATE, 'yyyy-mm-dd') || ', ' || to_char(v_std_end_date, 'yyyy-mm-dd'));

		-- 근태코드.
		V_DUTY_CODE := DUTY_CODE_F ( W_HOLIDAY_TYPE => P_HOLIDAY_TYPE
		                           , W_SOB_ID => P_SOB_ID
															 , W_ORG_ID => P_ORG_ID
															 );
    IF V_DUTY_CODE IS NULL THEN
			O_STATUS := 'F';
      O_MESSAGE := ERRNUMS.Data_Not_Found_Desc;
      RETURN;
		END IF;
		
	  FOR C1 IN C_PERSON
		          ( V_STD_JOIN_DATE
							)
		LOOP
		  V_PRE_NEXT_NUM                 := NVL(C1.PRE_NEXT_NUM, 0);
			V_CREATION_NUM                 := NVL(C1.CREATION_NUM, 0);
			V_PLUS_NUM                     := NVL(C1.PLUS_NUM, 0);
			V_USE_NUM                      := 0;
			V_KNSOK_YEAR                   := 0;
			V_JOIN_DAY                     := 0;
			V_PRE_TRANS_NEXT_YN            := 'N';
			
			-- 적용 기간 설정.
			IF V_STD_START_DATE < C1.JOIN_DATE THEN 
			  V_START_DATE := C1.JOIN_DATE;
			ELSE
			  V_START_DATE := V_STD_START_DATE;
			END IF;
			IF NVL(C1.RETIRE_DATE, P_STD_DATE) < V_STD_END_DATE THEN
			  V_END_DATE := NVL(C1.RETIRE_DATE, P_STD_DATE);
			ELSE 
			  V_END_DATE := V_STD_END_DATE;
			END IF;
			
			-- 근속 계산.
			V_KNSOK_YEAR := HRM_COMMON_DATE_G.YEAR_COUNT_F( P_START_DATE => C1.JOIN_DATE
			                                              , P_END_DATE => P_STD_DATE
																										, P_COUNT_TYPE => 'TRUNC'
																										);
--DBMS_OUTPUT.PUT_LINE('YEAR CAL : 성명 : ' || C1.DISPLAY_NAME || ', 근속 : ' || V_KNSOK_YEAR);
      IF V_KNSOK_YEAR < 1 THEN
			-- 1년 이상 2년 미만.
				V_PLUS_NUM := YEAR_PLUS_0( W_CORP_ID => P_CORP_ID
																 , W_JOIN_DATE => C1.JOIN_DATE
																 , W_START_DATE => V_START_DATE
																 , W_END_DATE => V_END_DATE
																 , W_PERSON_ID => C1.PERSON_ID
																 , W_SOB_ID => P_SOB_ID
																 , W_ORG_ID => P_ORG_ID
																 );				
				-- 기존 휴가사항 삭제.
				EXE_DELETE ( W_HOLIDAY_TYPE => P_HOLIDAY_TYPE
									 , W_DUTY_YEAR => P_DUTY_YEAR
                   , W_STD_DATE => P_STD_DATE
									 , W_PERSON_ID => C1.PERSON_ID
									 , W_DEPT_ID => NULL
									 , W_CORP_ID => P_CORP_ID
									 , W_SOB_ID => P_SOB_ID
									 , W_ORG_ID => P_ORG_ID
									 );
        -- INSERT.
				EXE_INSERT( P_HOLIDAY_TYPE => P_HOLIDAY_TYPE
									, P_DUTY_YEAR => P_DUTY_YEAR
									, P_PERSON_ID => C1.PERSON_ID
									, P_CORP_ID => P_CORP_ID
									, P_PRE_NEXT_NUM => V_PRE_NEXT_NUM
									, P_CREATION_NUM => V_CREATION_NUM
									, P_PLUS_NUM => V_PLUS_NUM
									, P_USE_NUM => 0
                  , P_YEAR_COUNT  => V_KNSOK_YEAR
                  , P_EXCEPT_YN   => 'N'
                  , P_WORKING_RATE => 100
									, P_SOB_ID => P_SOB_ID
									, P_ORG_ID => P_ORG_ID
									, P_USER_ID => P_USER_ID
									);
									
			ELSIF V_KNSOK_YEAR < 2 THEN
			-- 1년 이상 2년 미만.
			  V_JOIN_DAY := HRM_COMMON_DATE_G.PERIOD_DAY_F( P_START_DATE => C1.JOIN_DATE
				                                            , P_END_DATE => TO_DATE((P_DUTY_YEAR - 1)  || '-12-31', 'YYYY-MM-DD')
																										, P_ADD_DAY => 1
																										);			
				V_CREATION_NUM := TRUNC((V_JOIN_DAY / 365) * V_BASE_NUM);
				V_PRE_NEXT_NUM := C1.PRE_USE_NUM * -1;
				/*--전호수 주석(2013-02-05) : 1년 근속자 한도 설정 위해 --
        V_PLUS_NUM := V_BASE_NUM - V_CREATION_NUM;*/
        -- BH전용 : 총 발생수 적용 --
        V_PLUS_NUM := V_CREATION_NUM - V_BASE_NUM;
        V_CREATION_NUM := V_BASE_NUM;
			END IF;
			
			-- 사용수 집계.
      /*IF P_DUTY_YEAR = '2011' THEN
        V_START_DATE := TO_DATE('2011-04-01', 'YYYY-MM-DD');
        BEGIN
          SELECT HMU.USE_NUM
            INTO V_USE_NUM
            FROM HRD_HOLIDAY_MANAGEMENT_USE HMU
          WHERE HMU.CORP_ID       = P_CORP_ID
            AND HMU.PERSON_ID     = C1.PERSON_ID
            AND HMU.HOLIDAY_TYPE  = P_HOLIDAY_TYPE
            AND HMU.DUTY_YEAR     = P_DUTY_YEAR
            AND HMU.SOB_ID        = P_SOB_ID
            AND HMU.ORG_ID        = P_ORG_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          V_USE_NUM := 0;
        END;
      END IF;*/
			V_USE_NUM := NVL(V_USE_NUM, 0) + 
                   DUTY_USE_CAL_F ( W_DUTY_CODE => V_DUTY_CODE
			                            , W_START_DATE => V_START_DATE
																	, W_END_DATE => V_END_DATE
																	, W_PERSON_ID => C1.PERSON_ID
																	, W_CORP_ID => P_CORP_ID
																	, W_SOB_ID => P_SOB_ID
																	, W_ORG_ID => P_ORG_ID
																	);
			
			-- UPDATE.
			EXE_UPDATE( W_HOLIDAY_TYPE => P_HOLIDAY_TYPE
								, W_DUTY_YEAR => P_DUTY_YEAR
								, W_PERSON_ID => C1.PERSON_ID
								, W_CORP_ID => P_CORP_ID
								, W_SOB_ID => P_SOB_ID
								, W_ORG_ID => P_ORG_ID
								, P_PRE_NEXT_NUM => V_PRE_NEXT_NUM
								, P_CREATION_NUM => V_CREATION_NUM
								, P_PLUS_NUM => V_PLUS_NUM
								, P_USE_NUM => V_USE_NUM
								, P_USER_ID => P_USER_ID
								);
		END LOOP C1;
    O_STATUS := 'S';
	END YEAR_CAL;

-- 연중휴가 생성(1년 미만자) 및 사용수 집계
  PROCEDURE SUMMER_CAL
            ( P_HOLIDAY_TYPE              IN  VARCHAR2
            , P_DUTY_YEAR                 IN  VARCHAR2
            , P_CORP_ID                   IN  NUMBER
            , P_STD_DATE                  IN  DATE
            , P_PERSON_ID                 IN  NUMBER
            , P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            , O_STATUS                    OUT VARCHAR2
            , O_MESSAGE                   OUT VARCHAR2
            )
  AS
	BEGIN
	  NULL;
	
	END SUMMER_CAL;

-- 특별휴가 사용수 집계
  PROCEDURE SPECIAL_CAL
            ( P_HOLIDAY_TYPE              IN  VARCHAR2
            , P_DUTY_YEAR                 IN  VARCHAR2
            , P_CORP_ID                   IN  NUMBER
            , P_STD_DATE                  IN  DATE
            , P_PERSON_ID                 IN  NUMBER
            , P_SOB_ID                    IN  NUMBER
            , P_ORG_ID                    IN  NUMBER
            , P_USER_ID                   IN  NUMBER
            , O_STATUS                    OUT VARCHAR2
            , O_MESSAGE                   OUT VARCHAR2
            )
  AS
	BEGIN
	  NULL;
	
	END SPECIAL_CAL;


---------------------------------------------------------------------------------------------------
-- 1년 미만자 년차수 생성.
  FUNCTION YEAR_PLUS_0
          ( W_CORP_ID                     IN  NUMBER
          , W_JOIN_DATE                   IN  DATE
          , W_START_DATE                  IN  DATE
          , W_END_DATE                    IN  DATE
          , W_PERSON_ID                   IN  NUMBER
          , W_SOB_ID                      IN  NUMBER
          , W_ORG_ID                      IN  NUMBER
          ) RETURN NUMBER
  AS
	  CURSOR C_DUTY
		       ( W_STD_DAY                            IN VARCHAR2
					 )
		IS
		  SELECT CASE
							 WHEN TO_CHAR(DL.WORK_DATE, 'DD') < W_STD_DAY THEN TO_CHAR(DL.WORK_DATE, 'YYYY-MM')
							 ELSE TO_CHAR(ADD_MONTHS(DL.WORK_DATE, 1), 'YYYY-MM')
						 END AS DUTY_YYYYMM
					 , NVL(SUM(DECODE(DC.NON_PAY_DAY_FLAG, 'Y', DC.APPLY_DAY * -1, 1)), 0) AS WORK_DAY	 
				FROM HRD_DAY_LEAVE_V1 DL
					 , HRM_DUTY_CODE_V DC
			 WHERE DL.DUTY_ID               = DC.DUTY_ID
				 AND DL.PERSON_ID             = W_PERSON_ID
				 AND DL.WORK_DATE             BETWEEN W_START_DATE AND W_END_DATE
			GROUP BY CASE
								 WHEN TO_CHAR(DL.WORK_DATE, 'DD') < W_STD_DAY THEN TO_CHAR(DL.WORK_DATE, 'YYYY-MM')
								 ELSE TO_CHAR(ADD_MONTHS(DL.WORK_DATE, 1), 'YYYY-MM')
							 END
			;
		
		V_STD_DAY                                     VARCHAR2(2) := '01';
	  V_PLUS_NUM                                    HRD_HOLIDAY_MANAGEMENT.PLUS_NUM%TYPE := 0;
		V_1ST_DATE_FLAG                               VARCHAR2(1) := 'N';  -- 1일자 입사.
		
		V_ADD_MONTH                                   NUMBER := 0;
		V_MONTH_START                                 DATE;
		V_MONTH_END                                   DATE;
		V_MONTH_DAY                                   NUMBER;
	BEGIN
	  
	  -- 초기화.
		V_ADD_MONTH := 0;
	  V_STD_DAY := TO_CHAR(W_JOIN_DATE, 'DD');
	  FOR C1 IN C_DUTY
		          ( W_STD_DAY => V_STD_DAY
							)
		LOOP
		  BEGIN
        V_MONTH_END := TO_DATE(C1.DUTY_YYYYMM || '-' || V_STD_DAY, 'YYYY-MM-DD');
        V_MONTH_START := ADD_MONTHS(V_MONTH_END, -1);
        V_MONTH_END := V_MONTH_END - 1;
  			
  			
        V_MONTH_DAY := HRM_COMMON_DATE_G.PERIOD_DAY_F ( P_START_DATE => V_MONTH_START
                                                      , P_END_DATE => V_MONTH_END
                                                      , P_ADD_DAY => 1
                                                      );
--DBMS_OUTPUT.PUT_LINE('월 일수 : ' || V_MONTH_DAY || ', 실일수 : ' || C1.WORK_DAY);
        IF NVL(C1.WORK_DAY, -1) = V_MONTH_DAY THEN
          V_PLUS_NUM := V_PLUS_NUM + 1;
        END IF;
       EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('PERSON ID : ' || W_PERSON_ID || ', DUTY YYYYMM : ' || C1.DUTY_YYYYMM || 
                             ', STD DAY : ' || V_STD_DAY || 
                             ', 입사일 : ' || TO_CHAR(W_JOIN_DATE, 'YYYY-MM-DD') || 
                             ', 시작일 : ' || TO_CHAR(W_START_DATE, 'YYYY-MM-DD') || 
                             ', 종료일 : ' || TO_CHAR(W_END_DATE, 'YYYY-MM-DD'));
      END;
		END LOOP C1;
		
	  RETURN V_PLUS_NUM;
--DBMS_OUTPUT.PUT_LINE('추가발생수 : ' || V_PLUS_NUM);		
		
	END YEAR_PLUS_0;
	
---------------------------------------------------------------------------------------------------
-- 휴가사항ID에 따른 DUTY_CODE 반환.
  FUNCTION DUTY_CODE_F
          ( W_HOLIDAY_TYPE                IN  VARCHAR2
          , W_SOB_ID                      IN  NUMBER
          , W_ORG_ID                      IN  NUMBER
          ) RETURN VARCHAR2
	AS
	  V_DUTY_CODE                                   HRM_HOLIDAY_TYPE_V.DUTY_CODE%TYPE := NULL;
		
	BEGIN
	  BEGIN
			SELECT HT.DUTY_CODE
			  INTO V_DUTY_CODE
				FROM HRM_HOLIDAY_TYPE_V HT
			WHERE HT.HOLIDAY_TYPE           = W_HOLIDAY_TYPE
				AND HT.SOB_ID                 = W_SOB_ID
				AND HT.ORG_ID                 = W_ORG_ID
				AND HT.ENABLED_FLAG           = 'Y'
		 ;
		EXCEPTION WHEN OTHERS THEN
		  V_DUTY_CODE := NULL; 
		END;
		RETURN V_DUTY_CODE;
		
	END DUTY_CODE_F;
		
---------------------------------------------------------------------------------------------------
-- 근태 실제 사용수 집계
  FUNCTION DUTY_USE_CAL_F
          ( W_DUTY_CODE                   IN  VARCHAR2
          , W_START_DATE                  IN  DATE
          , W_END_DATE                    IN  DATE
          , W_PERSON_ID                   IN  NUMBER
          , W_CORP_ID                     IN  NUMBER
          , W_SOB_ID                      IN  NUMBER
          , W_ORG_ID                      IN  NUMBER
          ) RETURN NUMBER
	AS
	  V_USE_COUNT                                   NUMBER := 0;
		
	BEGIN
	  BEGIN
			SELECT SUM(DC.APPLY_DAY) AS DUTY_COUNT
			    INTO V_USE_COUNT
					FROM HRD_DAY_LEAVE_V DL
						 , HRM_DUTY_CODE_V DC
				WHERE DL.DUTY_ID                = DC.DUTY_ID
					AND DL.SOB_ID                 = DC.SOB_ID
					AND DL.ORG_ID                 = DC.ORG_ID
					AND DL.WORK_DATE              BETWEEN W_START_DATE AND W_END_DATE
					AND DL.PERSON_ID              = W_PERSON_ID
					AND DL.SOB_ID                 = W_SOB_ID
					AND DL.ORG_ID                 = W_ORG_ID
					AND DL.CLOSED_YN              = 'Y'
					AND DC.HOLIDAY_MANAGE_DUTY_GROUP  = W_DUTY_CODE
				GROUP BY DL.PERSON_ID
       ;
		EXCEPTION WHEN OTHERS THEN
		  V_USE_COUNT := 0; 
		END;
		RETURN V_USE_COUNT;
		
	END DUTY_USE_CAL_F;
	
END HRD_HOLIDAY_MANAGEMENT_G_SET;
/
