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
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            , O_MESSAGE                           OUT VARCHAR2
            );

-- 월근태 집계 처리.
  PROCEDURE MONTH_TOTAL_GO
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE						
						, W_DEPT_ID                           IN HRD_MONTH_TOTAL.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            , O_MESSAGE                           OUT VARCHAR2
            );
						
						
-- TOT_DED_COUNT ==> CAL.
  PROCEDURE TOT_DED_COUNT_P
	          ( W_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
						, P_LATE_DED_COUNT                    IN HRD_MONTH_TOTAL.LATE_DED_COUNT%TYPE
						, P_WEEKLY_DED_COUNT                  IN HRD_MONTH_TOTAL.WEEKLY_DED_COUNT%TYPE
						, O_TOT_DED_COUNT                     OUT HRD_MONTH_TOTAL.TOT_DED_DAY%TYPE
						, O_PAY_DAY                           OUT HRD_MONTH_TOTAL.PAY_DAY%TYPE
						);
											
-- 무급일수.
  FUNCTION NON_PAY_DAY_F
            ( W_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
            ) RETURN NUMBER;

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
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    V_CLOSED_FLAG                                 VARCHAR2(10) := 'N';
    V_START_DATE                                  HRD_DAY_LEAVE.WORK_DATE%TYPE;
		V_END_DATE                                    HRD_DAY_LEAVE.WORK_DATE%TYPE;
		
  BEGIN
    -- 마감 여부 체크하여 마감(Trans_yn = 'y')된 자료이면 집계 안함.
		V_CLOSED_FLAG := HRM_CLOSING_G.CLOSING_CHECK( W_CORP_ID => W_CORP_ID
																								 , W_CLOSING_YYYYMM => W_DUTY_YYYYMM
																								 , W_CLOSING_TYPE_ID => 0
																								 , W_CLOSING_TYPE => W_DUTY_TYPE
																								 , W_SOB_ID => W_SOB_ID
																								 , W_ORG_ID => W_ORG_ID
																								 );
    
    IF V_CLOSED_FLAG <> 'N' THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10052', NULL);
      RETURN;
    END IF;
    
		BEGIN
		  HRM_COMMON_DATE_G.YYYYMM_TERM_P( W_YYYYMM => W_DUTY_YYYYMM
			                                , W_WORK_TERM_TYPE => W_DUTY_TYPE
																			, W_JOB_CATEGORY_CODE => NULL
																			, W_SOB_ID => W_SOB_ID
																			, W_ORG_ID => W_ORG_ID
																			, O_START_DATE => V_START_DATE
																			, O_END_DATE => V_END_DATE
																			);
		EXCEPTION WHEN OTHERS THEN
		  V_START_DATE := TRUNC(TO_DATE(W_DUTY_YYYYMM, 'YYYY-MM'), 'MONTH');
			V_END_DATE := ADD_MONTHS(V_START_DATE, 1) - 1;
		END;
		
		-- 기존자료 DELETE.
		BEGIN
		  DELETE FROM HRD_MONTH_TOTAL MT
			WHERE MT.PERSON_ID           = NVL(W_PERSON_ID, MT.PERSON_ID)
			  AND MT.DUTY_TYPE           = W_DUTY_TYPE
				AND MT.DUTY_YYYYMM         = W_DUTY_YYYYMM
				AND MT.CORP_ID             = W_CORP_ID
				AND MT.SOB_ID              = W_SOB_ID
				AND MT.ORG_ID              = W_ORG_ID
				AND EXISTS ( SELECT 'X'
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
		  RAISE_APPLICATION_ERROR(-20001, SQLERRM);
		END;
    -- 월근태 집계 처리 프로시져 호출.
    MONTH_TOTAL_GO ( W_CORP_ID => W_CORP_ID
		               , W_DUTY_TYPE => W_DUTY_TYPE
									 , W_START_DATE => V_START_DATE
									 , W_END_DATE => V_END_DATE
									 , W_DEPT_ID => W_DEPT_ID
									 , W_FLOOR_ID => W_FLOOR_ID
									 , W_PERSON_ID => W_PERSON_ID
									 , W_SOB_ID => W_SOB_ID
									 , W_ORG_ID => W_ORG_ID
									 , P_USER_ID => P_USER_ID
									 , O_MESSAGE => O_MESSAGE
									 );
		  
  END SET_MAIN;

-- 출퇴근 정리 및 집계 처리.
  PROCEDURE MONTH_TOTAL_GO
            ( W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_DEPT_ID                           IN HRD_MONTH_TOTAL.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
	  -- 월근태 집계 대상 CURSOR.
	  CURSOR C_MONTH
		       ( W_HOLY_0_DED_FLAG                    HRD_MONTH_TOTAL.HOLY_0_DED_FLAG%TYPE
					 )
		IS
		SELECT DL.PERSON_ID, TO_CHAR(DL.WORK_DATE, 'YYYY-MM') AS DUTY_YYYYMM
				 , DL.CORP_ID, T1.DEPT_ID, T1.POST_ID, T1.JOB_CATEGORY_ID
				 , T1.ORI_JOIN_DATE, T1.RETIRE_DATE
				 , NVL(SUM(DL.LEAVE_TIME), 0) AS LEAVE_TIME
				 , NVL(SUM(DL.LATE_TIME), 0) AS LATE_TIME
				 , NVL(SUM(DL.REST_TIME), 0) AS REST_TIME
				 , NVL(SUM(DL.OVER_TIME), 0) AS OVER_TIME
				 , NVL(SUM(DL.HOLIDAY_TIME), 0) AS HOLIDAY_TIME
				 , NVL(SUM(DL.NIGHT_TIME), 0) AS NIGHT_TIME
				 , NVL(SUM(DL.NIGHT_BONUS_TIME), 0) AS NIGHT_BONUS_TIME
				 , COUNT(DL.HOLIDAY_CHECK) AS HOLIDAY_IN_COUNT
				 , NVL(SUM(CASE 
				             WHEN DL.LATE_TIME > 0 THEN 1
										 ELSE 0
									 END), 0) AS LATE_DED_COUNT
				 , NVL(SUM(CASE 
				             WHEN W_HOLY_0_DED_FLAG = 'Y' AND DL.HOLY_TYPE = '0' THEN 1
										 ELSE 0
									 END), 0) AS HOLY_0_COUNT
				 , NVL(SUM(DECODE(DC.ATTEND_FLAG, 'A', 1, 0)), 0) AS TOT_ATT_DAY
				 , NVL(SUM(DECODE(DC.NON_PAY_DAY_FLAG, 'Y', 1, 0)), 0) AS TOT_DED_DAY
			FROM HRD_DAY_LEAVE_V1 DL
			   , HRM_DUTY_CODE_V DC
				 , (-- 시점 인사내역.
						SELECT HL.PERSON_ID
								, HL.DEPT_ID
								, HL.POST_ID
								, HL.JOB_CATEGORY_ID
								, HL.FLOOR_ID    
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
																					 WHERE S_HL.CHARGE_DATE            <= W_END_DATE
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
			                                        WHEN T1.ORI_JOIN_DATE > W_START_DATE THEN T1.ORI_JOIN_DATE
			                                        ELSE W_START_DATE 
																						END
																		    AND CASE 
																				      WHEN T1.RETIRE_DATE IS NOT NULL AND T1.RETIRE_DATE < W_END_DATE THEN T1.RETIRE_DATE
																				      ELSE W_END_DATE
																						END
			AND DL.PERSON_ID              = NVL(W_PERSON_ID, DL.PERSON_ID)
			AND DL.CORP_ID                = W_CORP_ID
			AND DL.SOB_ID                 = W_SOB_ID
			AND DL.ORG_ID                 = W_ORG_ID
      AND DL.CLOSED_YN              = 'Y'
			AND T1.FLOOR_ID               = NVL(W_FLOOR_ID, T1.FLOOR_ID)
			AND T1.DEPT_ID                = NVL(W_DEPT_ID, T1.DEPT_ID) 
			AND T1.ORI_JOIN_DATE          <= W_END_DATE
			AND (T1.RETIRE_DATE IS NULL OR T1.RETIRE_DATE >= W_START_DATE) 
		GROUP BY DL.PERSON_ID
				 , TO_CHAR(DL.WORK_DATE, 'YYYY-MM')
				 , DL.CORP_ID
				 , T1.DEPT_ID
				 , T1.POST_ID
				 , T1.JOB_CATEGORY_ID
				 , T1.ORI_JOIN_DATE
				 , T1.RETIRE_DATE
		;
	  
		-- 근태 집계 CURSOR.
		CURSOR C_DUTY
		       ( C_PERSON_ID          HRD_MONTH_TOTAL.PERSON_ID%TYPE
					 )
		IS
		SELECT DL.PERSON_ID
					 , TO_CHAR(DL.WORK_DATE, 'YYYY-MM') AS DUTY_YYYYMM
					 , DL.DUTY_ID
           , SUM(DC.APPLY_DAY) AS DUTY_COUNT
			FROM HRD_DAY_LEAVE_V1 DL
			   , HRM_DUTY_CODE_V DC
		WHERE DL.DUTY_ID                = DC.DUTY_ID
		  AND DL.SOB_ID                 = DC.SOB_ID
			AND DL.ORG_ID                 = DC.ORG_ID
		  AND DL.WORK_DATE              BETWEEN W_START_DATE AND W_END_DATE
			AND DL.PERSON_ID              = C_PERSON_ID
			AND DL.CORP_ID                = W_CORP_ID
			AND DL.SOB_ID                 = W_SOB_ID
			AND DL.ORG_ID                 = W_ORG_ID
      AND DL.CLOSED_YN              = 'Y'
    GROUP BY DL.PERSON_ID
				 , TO_CHAR(DL.WORK_DATE, 'YYYY-MM')
				 , DL.DUTY_ID
		;
		
    V_SYSDATE                                     HRD_MONTH_TOTAL.CREATION_DATE%TYPE;
		V_MONTH_TOTAL_ID                              HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE;
    V_MONTH_DAY                                   HRD_MONTH_TOTAL.MONTH_TOTAL_DAY%TYPE;
		V_LATE_DED_COUNT                              HRD_MONTH_TOTAL.LATE_DED_COUNT%TYPE;
				
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
				AND CT.EFFECTIVE_DATE_FR      <= W_END_DATE
				AND (CT.EFFECTIVE_DATE_TO IS NULL OR CT.EFFECTIVE_DATE_TO >= W_START_DATE)
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
		  V_LATE_DED_COUNT := 0;
			V_MONTH_DAY := 0;
		  BEGIN
			  SELECT HRD_MONTH_TOTAL_S1.NEXTVAL
				  INTO V_MONTH_TOTAL_ID
				  FROM DUAL;
			EXCEPTION WHEN OTHERS THEN
			  V_MONTH_TOTAL_ID := 1;
			END;
			
			-- 월 총일수.
			BEGIN
			  SELECT CASE 
									WHEN C1.RETIRE_DATE IS NOT NULL AND C1.RETIRE_DATE < W_END_DATE THEN C1.RETIRE_DATE
									ELSE W_END_DATE
							 END -			
							 CASE
									WHEN C1.ORI_JOIN_DATE > W_START_DATE THEN C1.ORI_JOIN_DATE
									ELSE W_START_DATE 
							 END + 1 AS MONTH_DAY
          INTO V_MONTH_DAY
				  FROM DUAL;
			EXCEPTION WHEN OTHERS THEN
				V_MONTH_DAY := 0;
			END;
			
			-- 지조결근 계산/적용.
			IF V_LATE_DED_FLAG = 'Y' THEN
				BEGIN
					V_LATE_DED_COUNT := TRUNC(C1.LATE_DED_COUNT / V_LATE_STD_DAY);
				EXCEPTION WHEN OTHERS THEN
					V_LATE_DED_COUNT := 0;
				END;
			ELSE
			  V_LATE_DED_COUNT := 0;
			END IF;
			-- 근태일수 집계.
			FOR R1 IN C_DUTY(C_PERSON_ID => C1.PERSON_ID)
			LOOP 
			  INSERT INTO HRD_MONTH_TOTAL_SUMMARY
				( MONTH_TOTAL_SUMMARY_ID
				, PERSON_ID, MONTH_TOTAL_ID
				, DUTY_ID, DAY_COUNT
				, SOB_ID, ORG_ID
				, CREATION_DATE, CREATED_BY
				, LAST_UPDATE_DATE, LAST_UPDATED_BY				
				) VALUES
				( HRD_MONTH_TOTAL_SUMMARY_S1.NEXTVAL
				, C1.PERSON_ID, V_MONTH_TOTAL_ID
				, R1.DUTY_ID, NVL(R1.DUTY_COUNT, 0)
				, W_SOB_ID, W_ORG_ID
				, V_SYSDATE, P_USER_ID
				, V_SYSDATE, P_USER_ID
				);
			END LOOP R1;			
			
			INSERT INTO HRD_MONTH_TOTAL
			( MONTH_TOTAL_ID
			, PERSON_ID, DUTY_TYPE, DUTY_YYYYMM
			, CORP_ID, DEPT_ID, POST_ID, JOB_CATEGORY_ID
			, LEAVE_TIME
			, LATE_TIME
			, REST_TIME
			, OVER_TIME
			, HOLIDAY_TIME
			, NIGHT_TIME
			, NIGHT_BONUS_TIME
			, HOLIDAY_IN_COUNT
			, LATE_DED_COUNT
			, HOLY_0_COUNT
			, MONTH_TOTAL_DAY
			, TOT_ATT_DAY
			, TOT_DED_DAY
			, PAY_DAY
			, HOLY_0_DED_FLAG
			, SOB_ID, ORG_ID
			, CREATION_DATE, CREATED_BY
			, LAST_UPDATE_DATE, LAST_UPDATED_BY			
			)	VALUES
			( V_MONTH_TOTAL_ID                              ---
			, C1.PERSON_ID, W_DUTY_TYPE, C1.DUTY_YYYYMM
			, C1.CORP_ID, C1.DEPT_ID, C1.POST_ID, C1.JOB_CATEGORY_ID
			, C1.LEAVE_TIME
			, C1.LATE_TIME
			, C1.REST_TIME
			, C1.OVER_TIME
			, C1.HOLIDAY_TIME
			, C1.NIGHT_TIME
			, C1.NIGHT_BONUS_TIME
			, C1.HOLIDAY_IN_COUNT 
			, V_LATE_DED_COUNT                             ---
			, C1.HOLY_0_COUNT
      , V_MONTH_DAY                                   ---
			, C1.TOT_ATT_DAY
			, C1.TOT_DED_DAY + C1.HOLY_0_COUNT
			, CASE 
			    WHEN V_MONTH_DAY - C1.TOT_DED_DAY - C1.HOLY_0_COUNT < 0 THEN 0
					ELSE V_MONTH_DAY - C1.TOT_DED_DAY - C1.HOLY_0_COUNT
				END
			, V_HOLY_0_DED_FLAG                            ---
			, W_SOB_ID, W_ORG_ID
			, V_SYSDATE, P_USER_ID
			, V_SYSDATE, P_USER_ID
			);
			
		END LOOP C1;
    COMMIT;
---------------------------------------------------------------------------------------------------
--   주휴공제일수

    
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10060', NULL);
    RETURN;
  
  EXCEPTION 
	  WHEN ERRNUMS.Insert_Error THEN
		  O_MESSAGE := 'Insert Error ';
      RETURN;
  END MONTH_TOTAL_GO;


---------------------------------------------------------------------------------------------------
-- TOT_DED_COUNT ==> CAL.
  PROCEDURE TOT_DED_COUNT_P
	          ( W_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
						, P_LATE_DED_COUNT                    IN HRD_MONTH_TOTAL.LATE_DED_COUNT%TYPE
						, P_WEEKLY_DED_COUNT                  IN HRD_MONTH_TOTAL.WEEKLY_DED_COUNT%TYPE
						, O_TOT_DED_COUNT                     OUT HRD_MONTH_TOTAL.TOT_DED_DAY%TYPE
						, O_PAY_DAY                           OUT HRD_MONTH_TOTAL.PAY_DAY%TYPE
						)
  AS
		V_MONTH_TOTAL_DAY                             HRD_MONTH_TOTAL.MONTH_TOTAL_DAY%TYPE := 0;
		V_TOT_DED_COUNT                               HRD_MONTH_TOTAL.TOT_DED_DAY%TYPE := 0;
		V_PAY_DAY                                     HRD_MONTH_TOTAL.PAY_DAY%TYPE := 0;
		
	BEGIN
	  BEGIN
	    SELECT MT.MONTH_TOTAL_DAY
			  INTO V_MONTH_TOTAL_DAY
        FROM HRD_MONTH_TOTAL MT 
       WHERE MT.MONTH_TOTAL_ID      = W_MONTH_TOTAL_ID
			;
		EXCEPTION WHEN OTHERS THEN
		  V_MONTH_TOTAL_DAY := 0;
		END;
	  V_TOT_DED_COUNT := NON_PAY_DAY_F(W_MONTH_TOTAL_ID) + NVL(P_LATE_DED_COUNT, 0) + NVL(P_WEEKLY_DED_COUNT, 0);
		IF V_TOT_DED_COUNT < 0 THEN
		  V_TOT_DED_COUNT := 0;
		END IF;
		V_PAY_DAY := V_MONTH_TOTAL_DAY - V_TOT_DED_COUNT;
		IF V_PAY_DAY < 0 THEN
		  V_PAY_DAY := 0;
		END IF;
		
		-- RETURN.
		O_TOT_DED_COUNT := V_TOT_DED_COUNT;
		O_PAY_DAY := V_PAY_DAY;
		
	END TOT_DED_COUNT_P;
		
-- 무급일수.
  FUNCTION NON_PAY_DAY_F
            ( W_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
            ) RETURN NUMBER
  AS
	  V_NON_PAY_DAY                                 HRD_MONTH_TOTAL.TOT_DED_DAY%TYPE := 0;
		
	BEGIN
	  BEGIN
	    SELECT NVL(MTS.DAY_COUNT, 0) AS DAY_COUNT
        INTO V_NON_PAY_DAY
        FROM HRD_MONTH_TOTAL MT 
				  , HRD_MONTH_TOTAL_SUMMARY MTS
          , HRM_DUTY_CODE_V DC
					, HRM_WORK_TERM_V WT
      WHERE MT.MONTH_TOTAL_ID      = MTS.MONTH_TOTAL_ID
			  AND MTS.DUTY_ID            = DC.DUTY_ID
			  AND MT.DUTY_TYPE           = WT.WORK_TERM_TYPE
        AND MT.MONTH_TOTAL_ID      = W_MONTH_TOTAL_ID
        AND DC.NON_PAY_DAY_FLAG    = 'Y'
        AND DC.EFFECTIVE_DATE_FR   <= ADD_MONTHS(TO_DATE(MT.DUTY_YYYYMM || ' ' || WT.END_DAY, 'YYYY-MM-DD') + WT.END_ADD_DAY, WT.END_ADD_MONTH)
        AND (DC.EFFECTIVE_DATE_TO IS NULL OR DC.EFFECTIVE_DATE_TO >= ADD_MONTHS(TO_DATE(MT.DUTY_YYYYMM || ' ' || WT.START_DAY, 'YYYY-MM-DD') + WT.START_ADD_DAY, WT.START_ADD_MONTH))
			;
		EXCEPTION WHEN OTHERS THEN
		  V_NON_PAY_DAY := 0;
		END;
		RETURN V_NON_PAY_DAY;
		
	END NON_PAY_DAY_F;

END HRD_MONTH_TOTAL_G_SET;
/
