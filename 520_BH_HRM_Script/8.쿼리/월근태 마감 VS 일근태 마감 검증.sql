DECLARE 
    V_MONTH_DATE_FR             DATE;
		V_MONTH_DATE_TO             DATE;
    V_WORK_DATE_FR              DATE;
    V_WORK_DATE_TO              DATE;
		
		V_TOTAL_DAY_CNT             NUMBER;
		V_NORMAL_DAY_CNT            NUMBER;
		V_PAY_DAY_CNT               NUMBER;
		V_NON_PAY_DAY_CNT           NUMBER;
		
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
		V_MONTH_DATE_FR := TRUNC(TO_DATE(&W_DUTY_YYYYMM, 'YYYY-MM'), 'MONTH');
		V_MONTH_DATE_TO := LAST_DAY(V_MONTH_DATE_FR);
		
		DELETE FROM HRM_TEMP_GT TG
	   WHERE TG.TEMP_FLAG     = 'MONTH_TOTAL_CHECK'
		 ;
		 
	  FOR R1 IN(SELECT PM.PERSON_ID
			             , PM.PERSON_NUM 
									 , T1.DEPT_ID
									 , T1.POST_ID
									 , T1.PAY_GRADE_ID
									 , NVL(T1.JOB_CATEGORY_ID, PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_ID
									 , HRM_COMMON_G.GET_CODE_F(NVL(T1.JOB_CATEGORY_ID, PM.JOB_CATEGORY_ID), PM.SOB_ID, PM.ORG_ID) AS JOB_CATEGORY_CODE
									 , T1.FLOOR_ID    
									 , PM.CORP_ID
									 , PM.ORI_JOIN_DATE
									 , PM.JOIN_DATE
									 , PM.RETIRE_DATE
									 , PM.SOB_ID
									 , PM.ORG_ID
									 , &W_DUTY_TYPE AS DUTY_TYPE 
									 , &W_DUTY_YYYYMM AS DUTY_YYYYMM 
									 , CASE
											 WHEN NVL(PM.RETIRE_DATE, V_MONTH_DATE_TO) < V_MONTH_DATE_TO THEN 'R'
											 WHEN V_MONTH_DATE_FR < NVL(PM.JOIN_DATE, PM.ORI_JOIN_DATE) THEN 'I'
											 ELSE 'N'
										 END AS EXCEPT_TYPE
								FROM HRM_PERSON_MASTER PM
									, ( -- 시점인사내역 
										 SELECT HL.PERSON_ID
													, HL.DEPT_ID
													, HL.POST_ID
													, HL.PAY_GRADE_ID
													, HL.JOB_CATEGORY_ID
													, HL.FLOOR_ID    
											FROM HRM_HISTORY_HEADER HH
												 , HRM_HISTORY_LINE   HL 
										WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
											AND HH.CHARGE_SEQ           IN 
														(SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
																FROM HRM_HISTORY_HEADER S_HH
																	 , HRM_HISTORY_LINE   S_HL
															 WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
																 AND S_HH.CHARGE_DATE       <= V_MONTH_DATE_TO 
																 AND S_HL.PERSON_ID         = HL.PERSON_ID
															 GROUP BY S_HL.PERSON_ID
														 )  
									) T1 
							 WHERE PM.PERSON_ID         = T1.PERSON_ID
								 AND PM.WORK_CORP_ID      = &W_CORP_ID
								 AND ((&W_PERSON_ID        IS NULL AND 1 = 1)
								 OR   (&W_PERSON_ID        IS NOT NULL AND PM.PERSON_ID = &W_PERSON_ID))
								 AND PM.SOB_ID            = &W_SOB_ID
								 AND PM.ORG_ID            = &W_ORG_ID
								 AND ((&W_FLOOR_ID         IS NULL AND 1 = 1)
								 OR   (&W_FLOOR_ID         IS NOT NULL AND T1.FLOOR_ID = &W_FLOOR_ID)) 
								 AND ((&W_DEPT_ID          IS NULL AND 1 = 1)
								 OR   (&W_DEPT_ID          IS NOT NULL AND T1.DEPT_ID = &W_DEPT_ID))  
								 AND ((&W_JOB_CATEGORY_ID  IS NULL AND 1 = 1)
								 OR  (&W_JOB_CATEGORY_ID   IS NOT NULL AND T1.JOB_CATEGORY_ID = &W_JOB_CATEGORY_ID))                 
								 AND PM.JOIN_DATE         <= V_MONTH_DATE_TO
								 AND (PM.RETIRE_DATE      IS NULL OR PM.RETIRE_DATE >= V_MONTH_DATE_FR) 
								 AND EXISTS
											 ( SELECT 'X'
													 FROM HRD_DAY_LEAVE_V DL
													WHERE DL.PERSON_ID    = PM.PERSON_ID 
														AND DL.SOB_ID       = PM.SOB_ID
														AND DL.ORG_ID       = PM.ORG_ID
														AND DL.CLOSED_YN    = 'Y'
														AND DL.WORK_DATE    BETWEEN CASE
																													WHEN PM.JOIN_DATE > V_MONTH_DATE_FR THEN PM.JOIN_DATE
																													ELSE V_MONTH_DATE_FR 
																												END
																										AND CASE 
																													WHEN (PM.RETIRE_DATE IS NOT NULL AND PM.RETIRE_DATE < V_MONTH_DATE_TO) THEN PM.RETIRE_DATE
																													ELSE V_MONTH_DATE_TO
																												END
											 ) 
							)
		LOOP 
      -- 입퇴사에 따른 시작/종료일자 설정.
      SELECT CASE
               WHEN R1.JOIN_DATE > V_MONTH_DATE_FR THEN R1.JOIN_DATE
               ELSE V_MONTH_DATE_FR
             END AS WORK_DATE_FR
           , CASE 
               WHEN (R1.RETIRE_DATE IS NOT NULL AND R1.RETIRE_DATE < V_MONTH_DATE_TO) THEN R1.RETIRE_DATE
               ELSE V_MONTH_DATE_TO
             END AS WORK_DATE_TO 
        INTO V_WORK_DATE_FR, V_WORK_DATE_TO 
        FROM DUAL
        ; 
		  
			V_TOTAL_DAY_CNT             := 0;        -- 총일수 
			V_NORMAL_DAY_CNT            := 0;        -- 평일, 유급휴일, 무급휴일, 휴일근무.
			V_PAY_DAY_CNT               := 0;        -- 유급일수 
			V_NON_PAY_DAY_CNT           := 0;        -- 무급일수 
					 			
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
											 --, DL.HOLIDAY_OT_TIME
											 , DL.NIGHT_TIME
											 , DL.NIGHT_BONUS_TIME
											 , DL.PERSON_ID
											 , &W_DUTY_TYPE AS DUTY_TYPE
											 , R1.DUTY_YYYYMM AS DUTY_YYYYMM
											 , DL.WORK_CORP_ID
											 , DL.CORP_ID
											 , DL.SOB_ID
											 , DL.ORG_ID
										FROM HRD_DAY_LEAVE_V1 DL
											, HRM_JOB_CATEGORY_CODE_V JC
									 WHERE DL.JOB_CATEGORY_ID         = JC.JOB_CATEGORY_ID
										 AND DL.PERSON_ID               = R1.PERSON_ID
										 AND DL.WORK_DATE               BETWEEN V_WORK_DATE_FR AND V_WORK_DATE_TO
										 AND DL.SOB_ID                  = R1.SOB_ID
										 AND DL.ORG_ID                  = R1.ORG_ID
										 AND DL.CLOSED_YN               = 'Y' 
								)
			LOOP
				V_LEAVE_TIME        := 0;        -- 외출시간 적용.2
				V_LATE_TIME         := 0;        -- 지각시간.3
				V_REST_TIME         := 0;        -- 휴식연장.4
				V_OVER_TIME         := 0;        -- 연장시간.5
				V_HOLIDAY_TIME      := 0;        -- 휴일근로.6
				--V_HOLIDAY_OT_TIME   := 0;        -- 휴일연장근로.7
				V_NIGHT_TIME        := 0;        -- 야간근로.8
				V_NIGHT_BONUS_TIME  := 0;        -- 야간할증.9
	      
				-- 잔업 사항 정리. --
				V_LEAVE_TIME        := C1.LEAVE_TIME;       -- 외출시간 적용.
				V_LATE_TIME         := C1.LATE_TIME;        -- 지각시간.
				V_REST_TIME         := C1.REST_TIME;        -- 휴식연장.
				V_OVER_TIME         := C1.OVER_TIME;        -- 연장시간.
				V_HOLIDAY_TIME      := C1.HOLIDAY_TIME;     -- 휴일근로.
				--V_HOLIDAY_OT_TIME   := C1.HOLIDAY_OT_TIME;  -- 휴일연장근로.
				V_NIGHT_TIME        := C1.NIGHT_TIME;       -- 야간근로.
				V_NIGHT_BONUS_TIME  := C1.NIGHT_BONUS_TIME; -- 야간할증.
	      
				-- 외출이 있을경우 연장(휴연포함)에서 그만큼 감소시키고 외출 시간을 0으로 만듬--
				IF NVL(V_LEAVE_TIME, 0) > 0 THEN
					IF NVL(V_LEAVE_TIME, 0) <= NVL(V_REST_TIME, 0) THEN
						V_REST_TIME := NVL(V_REST_TIME, 0) - NVL(V_LEAVE_TIME, 0);
						V_LEAVE_TIME := 0;
					ELSIF NVL(V_LEAVE_TIME, 0) <= (NVL(V_REST_TIME, 0) + NVL(V_HOLIDAY_OT_TIME, 0)) THEN
						V_HOLIDAY_OT_TIME := NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_REST_TIME, 0);
						V_HOLIDAY_OT_TIME := NVL(V_HOLIDAY_OT_TIME, 0) - NVL(V_LEAVE_TIME, 0);
						V_REST_TIME := 0;
						V_LEAVE_TIME := 0;
					ELSIF NVL(V_LEAVE_TIME, 0) <= (NVL(V_REST_TIME, 0)+ NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_HOLIDAY_TIME, 0)) THEN
						V_HOLIDAY_TIME := NVL(V_HOLIDAY_TIME, 0) + NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_REST_TIME, 0);
						V_HOLIDAY_TIME := NVL(V_HOLIDAY_TIME, 0) - NVL(V_LEAVE_TIME, 0);
						V_HOLIDAY_OT_TIME := 0;
						V_REST_TIME := 0;
						V_LEAVE_TIME := 0;
					ELSIF NVL(V_LEAVE_TIME, 0) <= (NVL(V_REST_TIME, 0)+ NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_HOLIDAY_TIME, 0) + NVL(V_OVER_TIME, 0)) THEN
						V_OVER_TIME := NVL(V_OVER_TIME, 0) + NVL(V_HOLIDAY_TIME, 0) + NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_REST_TIME, 0);
						V_OVER_TIME := NVL(V_OVER_TIME, 0) - NVL(V_LEAVE_TIME, 0);
						V_HOLIDAY_OT_TIME := 0;
						V_HOLIDAY_TIME := 0;
						V_REST_TIME := 0;
						V_LEAVE_TIME := 0;
					ELSE
						V_LEAVE_TIME := NVL(V_LEAVE_TIME, 0) - (NVL(V_OVER_TIME, 0) + NVL(V_HOLIDAY_TIME, 0) + NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_REST_TIME, 0));
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
			
			-- 근태계 COUNT -- 
			BEGIN
		    SELECT COUNT(DL.WORK_DATE) AS TOTAL_DAY_CNT 
				     , SUM(CASE
						         WHEN DC.DUTY_CODE IN('00', '51', '52', '53') THEN NVL(DC.APPLY_DAY, 1)
										 WHEN DC.DUTY_CODE IN('21') THEN 1 - (NVL(DC.APPLY_DAY, 0.5) - TRUNC(NVL(DC.APPLY_DAY, 0.5)))
										 ELSE 0
								   END) AS NORMAL_DAY_CNT
				     , SUM(CASE
						         WHEN DC.DUTY_CODE IN('00', '51', '52', '53') THEN 0
										 ELSE DECODE(DC.NON_PAY_DAY_FLAG, 'Y', 0, NVL(DC.APPLY_DAY, 1))
									 END) AS PAY_DAY_CNT 
						 , SUM(CASE
						         WHEN DC.DUTY_CODE IN('00', '51', '52', '53') THEN 0
										 ELSE DECODE(DC.NON_PAY_DAY_FLAG, 'Y', NVL(DC.APPLY_DAY, 1), 0)
						       END) AS NON_PAY_DAY_CNT
					INTO V_TOTAL_DAY_CNT
					   , V_NORMAL_DAY_CNT
					   , V_PAY_DAY_CNT
						 , V_NON_PAY_DAY_CNT 
				  FROM HRD_DAY_LEAVE_V DL
					   , HRM_DUTY_CODE_V DC 
				WHERE DL.DUTY_ID            = DC.DUTY_ID 
				  AND DL.PERSON_ID          = R1.PERSON_ID
          AND DL.WORK_DATE          BETWEEN V_WORK_DATE_FR AND V_WORK_DATE_TO
				  AND DL.SOB_ID             = R1.SOB_ID
				  AND DL.ORG_ID             = R1.ORG_ID
					AND DL.CLOSED_YN          = 'Y' 
			  ;
			EXCEPTION
				WHEN OTHERS THEN
					V_TOTAL_DAY_CNT := 0;
          V_NORMAL_DAY_CNT := 0;
					V_PAY_DAY_CNT := 0;
					V_NON_PAY_DAY_CNT := 0;
			END;
																												
			-- 저장 -- 
			INSERT INTO HRM_TEMP_GT 
			( TEMP_FLAG 
			, VARCHAR_1  -- 근태구분 
			, VARCHAR_2  -- 근태년월 
			, NUM_1      -- 사원ID  
			, NUM_6      -- 외출시간 
			, NUM_7      -- 지각시간
			, NUM_8      -- 휴식연장
			, NUM_9      -- 연장시간
			, NUM_10     -- 휴일근로
			, NUM_11     -- 휴일연장근로
			, NUM_12     -- 야간근로
			, NUM_13     -- 야간할증		  
			, NUM_14     -- 총일수
			, NUM_15     -- 출근, 휴일, 휴근 
			, NUM_16     -- 유급일수 
      , NUM_17     -- 무급일수 
			) VALUES
			( 'MONTH_TOTAL_CHECK'
			, R1.DUTY_TYPE
			, R1.DUTY_YYYYMM 
			, R1.PERSON_ID
			, V_TOT_LEAVE_TIME         -- 외출시간 적용.
			, V_TOT_LATE_TIME          -- 지각시간.
			, V_TOT_REST_TIME          -- 휴식연장.
			, V_TOT_OVER_TIME          -- 연장시간.
			, V_TOT_HOLIDAY_TIME       -- 휴일근로.
			, V_TOT_HOLIDAY_OT_TIME    -- 휴일연장근로.
			, V_TOT_NIGHT_TIME         -- 야간근로.
			, V_TOT_NIGHT_BONUS_TIME   -- 야간할증	
			, V_TOTAL_DAY_CNT          -- 총일수
      , V_NORMAL_DAY_CNT         -- 출근/휴일/휴근 
			, V_PAY_DAY_CNT            -- 유급일수 
			, V_NON_PAY_DAY_CNT        -- 무급일수 	  
			);
  END LOOP R1;
				 
END;		

/*
SELECT *
  FROM HRM_TEMP_GT X
 WHERE X.NUM_1 = 1192
	;
	*/
	
SELECT DECODE(D1.SORT_NUM, 1, D1.DUTY_TYPE) AS DP_DUTY_TYPE 
     , DECODE(D1.SORT_NUM, 1, D1.DUTY_YYYYMM) AS DP_DUTY_YYYYMM
		 , DECODE(D1.SORT_NUM, 1, PM.PERSON_NUM) AS DP_PERSON_NUM
		 , DECODE(D1.SORT_NUM, 1, PM.NAME) AS DP_NAME		 		 
		 , DECODE(D1.SORT_NUM, 1, T1.DEPT_NAME) AS DP_DEPT_NAME
		 , DECODE(D1.SORT_NUM, 1, T1.FLOOR_NAME) AS DP_FLOOR_NAME
		 , DECODE(D1.SORT_NUM, 1, T1.POST_NAME) AS DP_POST_NAME
		 , DECODE(D1.SORT_NUM, 1, T1.JOB_CATEGORY_NAME) AS DP_JOB_CATEGORY_NAME  
		 , CASE
		     WHEN D1.SORT_NUM = 1 THEN '일근태'
				 WHEN D1.SORT_NUM = 2 THEN '월근태'
				 ELSE '차이내역'
			 END AS DUTY_FLAG 
		 , DECODE(D1.LEAVE_TIME, 0, TO_NUMBER(NULL), D1.LEAVE_TIME) AS LEAVE_TIME        -- 외출시간 적용.
		 , DECODE(D1.LATE_TIME, 0, TO_NUMBER(NULL), D1.LATE_TIME) AS LATE_TIME         -- 지각시간.
		 , DECODE(D1.REST_TIME, 0, TO_NUMBER(NULL), D1.REST_TIME) AS REST_TIME         -- 휴식연장. 
		 , DECODE(D1.OVER_TIME, 0, TO_NUMBER(NULL), D1.OVER_TIME) AS OVER_TIME         -- 연장시간. 
		 , DECODE(D1.HOLIDAY_TIME, 0, TO_NUMBER(NULL), D1.HOLIDAY_TIME) AS HOLIDAY_TIME      -- 휴일근로.
		 , DECODE(D1.HOLIDAY_OT_TIME, 0, TO_NUMBER(NULL), D1.HOLIDAY_OT_TIME) AS HOLIDAY_OT_TIME    -- 휴일연장근로.
		 , DECODE(D1.NIGHT_TIME, 0, TO_NUMBER(NULL), D1.NIGHT_TIME) AS NIGHT_TIME        -- 야간근로.
		 , DECODE(D1.NIGHT_BONUS_TIME, 0, TO_NUMBER(NULL), D1.NIGHT_BONUS_TIME) AS NIGHT_BONUS_TIME  -- 야간할증	
		 , DECODE(D1.TOTAL_DAY_CNT, 0, TO_NUMBER(NULL), D1.TOTAL_DAY_CNT) AS TOTAL_DAY_CNT 
		 , DECODE(D1.NORMAL_DAY_CNT, 0, TO_NUMBER(NULL), D1.NORMAL_DAY_CNT) AS NORMAL_DAY_CNT
		 , DECODE(D1.PAY_DAY_CNT, 0, TO_NUMBER(NULL), D1.PAY_DAY_CNT) AS PAY_DAY_CNT
		 , DECODE(D1.NON_PAY_DAY_CNT, 0, TO_NUMBER(NULL), D1.NON_PAY_DAY_CNT) AS NON_PAY_DAY_CNT
		 , D1.DUTY_TYPE
     , D1.DUTY_YYYYMM
		 , PM.PERSON_NUM
		 , PM.NAME		 
		 , T1.DEPT_NAME
		 , T1.FLOOR_NAME
		 , T1.POST_NAME
		 , T1.JOB_CATEGORY_NAME 
  FROM HRM_PERSON_MASTER PM
		, ( -- 시점인사내역 
			 SELECT HL.PERSON_ID
						, HL.DEPT_ID
						, DM.DEPT_CODE
						, DM.DEPT_NAME
						, DM.DEPT_SORT_NUM 
						, HL.POST_ID
						, PC.POST_CODE
						, PC.POST_NAME
						, PC.SORT_NUM AS POST_SORT_NUM 
						, HL.PAY_GRADE_ID
						, HL.JOB_CATEGORY_ID
						, JCC.JOB_CATEGORY_CODE
						, JCC.JOB_CATEGORY_NAME
						, JCC.SORT_NUM AS JOB_CATE_SORT_NUM 
						, HL.FLOOR_ID    
						, HF.FLOOR_CODE
						, HF.FLOOR_NAME
						, HF.SORT_NUM AS FLOOR_SORT_NUM
				FROM HRM_HISTORY_HEADER HH
					 , HRM_HISTORY_LINE   HL
					 , HRM_DEPT_MASTER    DM
					 , HRM_FLOOR_V        HF
					 , HRM_POST_CODE_V    PC 
					 , HRM_JOB_CATEGORY_CODE_V JCC   
			WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
			  AND HL.DEPT_ID              = DM.DEPT_ID
				AND HL.FLOOR_ID             = HF.FLOOR_ID
				AND HL.POST_ID              = PC.POST_ID 
				AND HL.JOB_CATEGORY_ID      = JCC.JOB_CATEGORY_ID 
				AND HH.CHARGE_SEQ           IN 
							(SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
									FROM HRM_HISTORY_HEADER S_HH
										 , HRM_HISTORY_LINE   S_HL
								 WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
									 AND S_HH.CHARGE_DATE       <= &V_MONTH_DATE_TO 
									 AND S_HL.PERSON_ID         = HL.PERSON_ID
								 GROUP BY S_HL.PERSON_ID
							 )  
		   ) T1  
     , (-- 일근태 마감 내역 -- 
		    SELECT TG.NUM_1 AS PERSON_ID 
						 , TG.VARCHAR_1 AS DUTY_TYPE
						 , TG.VARCHAR_2 AS DUTY_YYYYMM
						 , TG.NUM_6 AS LEAVE_TIME        -- 외출시간 적용.
						 , TG.NUM_7 AS LATE_TIME         -- 지각시간.
						 , TG.NUM_8 AS REST_TIME         -- 휴식연장. 
						 , TG.NUM_9 AS OVER_TIME         -- 연장시간. 
						 , TG.NUM_10 AS HOLIDAY_TIME      -- 휴일근로.
						 , TG.NUM_11 AS HOLIDAY_OT_TIME  -- 휴일연장근로.
						 , TG.NUM_12 AS NIGHT_TIME        -- 야간근로.
						 , TG.NUM_13 AS NIGHT_BONUS_TIME  -- 야간할증	
						 , TG.NUM_14 AS TOTAL_DAY_CNT 
						 , TG.NUM_15 AS NORMAL_DAY_CNT
						 , TG.NUM_16 AS PAY_DAY_CNT
						 , TG.NUM_17 AS NON_PAY_DAY_CNT
						 , 1 AS SORT_NUM 
					FROM HRM_TEMP_GT TG 
				UNION ALL 
				-- 월근태 마감 내역 -- 
				SELECT MT.PERSON_ID
						 , MT.DUTY_TYPE
						 , MT.DUTY_YYYYMM
						 , MTO.LEAVE_TIME        -- 외출시간 적용.
						 , MTO.LATE_TIME         -- 지각시간.
						 , MTO.REST_TIME         -- 휴식연장. 
						 , MTO.OVER_TIME         -- 연장시간. 
						 , MTO.HOLIDAY_TIME      -- 휴일근로.
						 , 0 AS HOLIDAY_OT_TIME  -- 휴일연장근로.
						 , MTO.NIGHT_TIME        -- 야간근로.
						 , MTO.NIGHT_BONUS_TIME  -- 야간할증	
						 , SUM(MTD.DUTY_COUNT) AS TOTAL_DAY_CNT 
						 , SUM(CASE
										 WHEN DC.DUTY_CODE IN('00', '51', '52', '53') THEN NVL(MTD.DUTY_COUNT, 0)
										 WHEN DC.DUTY_CODE IN('21') THEN 1 - (NVL(MTD.DUTY_COUNT, 0) - TRUNC(NVL(MTD.DUTY_COUNT, 0)))
										 ELSE 0
									 END) AS NORMAL_DAY_CNT
						 , SUM(CASE
										 WHEN DC.DUTY_CODE IN('00', '51', '52', '53') THEN 0
										 ELSE DECODE(DC.NON_PAY_DAY_FLAG, 'Y', 0, MTD.DUTY_COUNT)
									 END) AS PAY_DAY_CNT
						 , SUM(CASE
										 WHEN DC.DUTY_CODE IN('00', '51', '52', '53') THEN 0
										 ELSE DECODE(DC.NON_PAY_DAY_FLAG, 'Y', MTD.DUTY_COUNT, 0) 
									 END)AS NON_PAY_DAY_CNT
						 , 2 AS SORT_NUM 
					 FROM HRD_MONTH_TOTAL      MT 
							, HRD_MONTH_TOTAL_OT_V MTO 
							, HRD_MONTH_TOTAL_DUTY MTD
							, HRM_DUTY_CODE_V      DC
				 WHERE MT.MONTH_TOTAL_ID        = MTO.MONTH_TOTAL_ID(+) 
					 AND MT.MONTH_TOTAL_ID        = MTD.MONTH_TOTAL_ID(+)  
					 AND MTD.DUTY_ID              = DC.DUTY_ID 
					 AND MT.DUTY_TYPE             = &W_DUTY_TYPE
					 AND MT.DUTY_YYYYMM           = &W_DUTY_YYYYMM
					 AND MT.SOB_ID                = &W_SOB_ID
					 AND MT.ORG_ID                = &W_ORG_ID
				 GROUP BY MT.PERSON_ID
							 , MT.DUTY_TYPE
							 , MT.DUTY_YYYYMM
							 , MTO.LEAVE_TIME        -- 외출시간 적용.
							 , MTO.LATE_TIME         -- 지각시간.
							 , MTO.REST_TIME         -- 휴식연장. 
							 , MTO.OVER_TIME         -- 연장시간. 
							 , MTO.HOLIDAY_TIME      -- 휴일근로.
							 , 0                     -- 휴일연장근로.
							 , MTO.NIGHT_TIME        -- 야간근로.
							 , MTO.NIGHT_BONUS_TIME  -- 야간할증	
				UNION ALL
				-- 집계 차이내역 
				SELECT X1.PERSON_ID
						 , X1.DUTY_TYPE
						 , X1.DUTY_YYYYMM
						 , SUM(X1.LEAVE_TIME * X1.SIGN_FLAG) AS LEAVE_TIME       -- 외출시간 적용.
						 , SUM(X1.LATE_TIME * X1.SIGN_FLAG) AS LATE_TIME         -- 지각시간.
						 , SUM(X1.REST_TIME * X1.SIGN_FLAG) AS REST_TIME         -- 휴식연장. 
						 , SUM(X1.OVER_TIME * X1.SIGN_FLAG) AS OVER_TIME         -- 연장시간. 
						 , SUM(X1.HOLIDAY_TIME * X1.SIGN_FLAG) AS HOLIDAY_TIME      -- 휴일근로.
						 , SUM(X1.HOLIDAY_OT_TIME * X1.SIGN_FLAG) AS HOLIDAY_OT_TIME  -- 휴일연장근로.
						 , SUM(X1.NIGHT_TIME * X1.SIGN_FLAG) AS NIGHT_TIME        -- 야간근로.
						 , SUM(X1.NIGHT_BONUS_TIME * X1.SIGN_FLAG) AS NIGHT_BONUS_TIME  -- 야간할증	
						 , SUM(X1.TOTAL_DAY_CNT * X1.SIGN_FLAG) AS TOTAL_DAY_CNT
						 , SUM(X1.NORMAL_DAY_CNT * X1.SIGN_FLAG) AS NORMAL_DAY_CNT
						 , SUM(X1.PAY_DAY_CNT * X1.SIGN_FLAG) AS PAY_DAY_CNT
						 , SUM(X1.NON_PAY_DAY_CNT * X1.SIGN_FLAG) AS NON_PAY_DAY_CNT
						 , 3 AS SORT_NUM
					FROM (SELECT TG.NUM_1 AS PERSON_ID 
										 , TG.VARCHAR_1 AS DUTY_TYPE
										 , TG.VARCHAR_2 AS DUTY_YYYYMM
										 , TG.NUM_6 AS LEAVE_TIME        -- 외출시간 적용.
										 , TG.NUM_7 AS LATE_TIME         -- 지각시간.
										 , TG.NUM_8 AS REST_TIME         -- 휴식연장. 
										 , TG.NUM_9 AS OVER_TIME         -- 연장시간. 
										 , TG.NUM_10 AS HOLIDAY_TIME      -- 휴일근로.
										 , TG.NUM_11 AS HOLIDAY_OT_TIME  -- 휴일연장근로.
										 , TG.NUM_12 AS NIGHT_TIME        -- 야간근로.
										 , TG.NUM_13 AS NIGHT_BONUS_TIME  -- 야간할증	
										 , TG.NUM_14 AS TOTAL_DAY_CNT 
										 , TG.NUM_15 AS NORMAL_DAY_CNT
										 , TG.NUM_16 AS PAY_DAY_CNT
										 , TG.NUM_17 AS NON_PAY_DAY_CNT
										 , 1 AS SIGN_FLAG 
									FROM HRM_TEMP_GT TG 
								UNION ALL 
								-- 월근태 마감 내역 -- 
								SELECT MT.PERSON_ID
										 , MT.DUTY_TYPE
										 , MT.DUTY_YYYYMM
										 , MTO.LEAVE_TIME        -- 외출시간 적용.
										 , MTO.LATE_TIME         -- 지각시간.
										 , MTO.REST_TIME         -- 휴식연장. 
										 , MTO.OVER_TIME         -- 연장시간. 
										 , MTO.HOLIDAY_TIME      -- 휴일근로.
										 , 0 AS HOLIDAY_OT_TIME  -- 휴일연장근로.
										 , MTO.NIGHT_TIME        -- 야간근로.
										 , MTO.NIGHT_BONUS_TIME  -- 야간할증	
										 , SUM(MTD.DUTY_COUNT) AS TOTAL_DAY_CNT 
										 , SUM(CASE
														 WHEN DC.DUTY_CODE IN('00', '51', '52', '53') THEN NVL(MTD.DUTY_COUNT, 0)
														 WHEN DC.DUTY_CODE IN('21') THEN 1 - (NVL(MTD.DUTY_COUNT, 0) - TRUNC(NVL(MTD.DUTY_COUNT, 0)))
														 ELSE 0
													 END) AS NORMAL_DAY_CNT
										 , SUM(CASE
														 WHEN DC.DUTY_CODE IN('00', '51', '52', '53') THEN 0
														 ELSE DECODE(DC.NON_PAY_DAY_FLAG, 'Y', 0, MTD.DUTY_COUNT)
													 END) AS PAY_DAY_CNT
										 , SUM(CASE
														 WHEN DC.DUTY_CODE IN('00', '51', '52', '53') THEN 0
														 ELSE DECODE(DC.NON_PAY_DAY_FLAG, 'Y', MTD.DUTY_COUNT, 0) 
													 END)AS NON_PAY_DAY_CNT
										 , -1 AS SIGN_FLAG 
									 FROM HRD_MONTH_TOTAL      MT 
											, HRD_MONTH_TOTAL_OT_V MTO 
											, HRD_MONTH_TOTAL_DUTY MTD
											, HRM_DUTY_CODE_V      DC
								 WHERE MT.MONTH_TOTAL_ID        = MTO.MONTH_TOTAL_ID(+) 
									 AND MT.MONTH_TOTAL_ID        = MTD.MONTH_TOTAL_ID(+)  
									 AND MTD.DUTY_ID              = DC.DUTY_ID 
									 AND MT.DUTY_TYPE             = &W_DUTY_TYPE
									 AND MT.DUTY_YYYYMM           = &W_DUTY_YYYYMM
									 AND MT.SOB_ID                = &W_SOB_ID
									 AND MT.ORG_ID                = &W_ORG_ID
								 GROUP BY MT.PERSON_ID
											 , MT.DUTY_TYPE
											 , MT.DUTY_YYYYMM
											 , MTO.LEAVE_TIME        -- 외출시간 적용.
											 , MTO.LATE_TIME         -- 지각시간.
											 , MTO.REST_TIME         -- 휴식연장. 
											 , MTO.OVER_TIME         -- 연장시간. 
											 , MTO.HOLIDAY_TIME      -- 휴일근로.
											 , 0                     -- 휴일연장근로.
											 , MTO.NIGHT_TIME        -- 야간근로.
											 , MTO.NIGHT_BONUS_TIME  -- 야간할증	
									) X1 
						GROUP BY X1.PERSON_ID
									 , X1.DUTY_TYPE
									 , X1.DUTY_YYYYMM 
        ) D1
 WHERE PM.PERSON_ID         = T1.PERSON_ID
   AND PM.PERSON_ID         = D1.PERSON_ID 
	 AND PM.WORK_CORP_ID      = &W_CORP_ID
	 AND ((&W_PERSON_ID        IS NULL AND 1 = 1)
	 OR   (&W_PERSON_ID        IS NOT NULL AND PM.PERSON_ID = &W_PERSON_ID))
	 AND PM.SOB_ID            = &W_SOB_ID
	 AND PM.ORG_ID            = &W_ORG_ID
	 AND ((&W_FLOOR_ID         IS NULL AND 1 = 1)
	 OR   (&W_FLOOR_ID         IS NOT NULL AND T1.FLOOR_ID = &W_FLOOR_ID)) 
	 AND ((&W_DEPT_ID          IS NULL AND 1 = 1)
	 OR   (&W_DEPT_ID          IS NOT NULL AND T1.DEPT_ID = &W_DEPT_ID))  
	 AND ((&W_JOB_CATEGORY_ID  IS NULL AND 1 = 1)
	 OR  (&W_JOB_CATEGORY_ID   IS NOT NULL AND T1.JOB_CATEGORY_ID = &W_JOB_CATEGORY_ID))                 
	 AND PM.JOIN_DATE         <= &V_MONTH_DATE_TO
	 AND (PM.RETIRE_DATE      IS NULL OR PM.RETIRE_DATE >= &V_MONTH_DATE_FR) 
ORDER BY PM.PERSON_NUM
       , D1.SORT_NUM 	   

 
;	 		 	 
