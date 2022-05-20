CREATE OR REPLACE PACKAGE HRD_DAY_INTERFACE_G_SET
AS

-- 출퇴근 정리 및 집계 MAIN.
  PROCEDURE SET_MAIN
            ( P_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , P_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
            , P_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            , P_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , P_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , P_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
            , O_MESSAGE                           OUT VARCHAR2
						);
						
-- 출퇴근 정리 및 집계 처리.
  PROCEDURE WORKDATA_GO
	          ( P_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, P_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, P_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, P_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, P_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
						, P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
						, O_MESSAGE                           OUT VARCHAR2
						);
						
END HRD_DAY_INTERFACE_G_SET;

 
/
CREATE OR REPLACE PACKAGE BODY HRD_DAY_INTERFACE_G_SET
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_DAY_INTERFACE_G_SET
/* DESCRIPTION  : 현업 출퇴근 집계 관리.  : 근태 카드 체크 여부 : HRM_POST_CODE_V에서 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- 출퇴근 정리 및 집계 MAIN.
  PROCEDURE SET_MAIN
            ( P_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , P_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
            , P_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            , P_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , P_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , P_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
            , O_MESSAGE                           OUT VARCHAR2
						)
  AS 
	  V_RECORD_COUNT                                NUMBER := 0;
		V_CONNECT_PERSON_ID                           HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
    
	BEGIN
    -- 근태권한 설정.
    IF P_CONNECT_LEVEL = 'C' THEN
      V_CONNECT_PERSON_ID := NULL;
    ELSE
      V_CONNECT_PERSON_ID := P_CONNECT_PERSON_ID;
    END IF;    
    
	  -- 마감 여부 체크하여 마감(Trans_yn = 'y')된 자료이면 집계 안함.
    V_RECORD_COUNT := 0;
    BEGIN
      SELECT SUM(DECODE(DI.TRANS_YN, 'Y', 1, 0)) AS TRANS_COUNT
        INTO V_RECORD_COUNT
      FROM HRD_DAY_INTERFACE DI
        , HRM_PERSON_MASTER PM
        , (-- 시점 인사내역.
            SELECT HL.PERSON_ID
                , HL.DEPT_ID
                , HL.POST_ID
                , HL.JOB_CATEGORY_ID
            FROM HRM_HISTORY_LINE HL  
            WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                          	FROM HRM_HISTORY_LINE S_HL
																					 WHERE S_HL.CHARGE_DATE            <= P_WORK_DATE
																						 AND S_HL.PERSON_ID              = HL.PERSON_ID
																					 GROUP BY S_HL.PERSON_ID
																				 )
					) T1
               , (-- 시점 인사내역.
                  SELECT PH.PERSON_ID
                       , PH.FLOOR_ID
                    FROM HRD_PERSON_HISTORY        PH
                   WHERE PH.EFFECTIVE_DATE_FR  <=  P_WORK_DATE
                     AND PH.EFFECTIVE_DATE_TO  >=  P_WORK_DATE
                 ) T2
			WHERE DI.PERSON_ID              = PM.PERSON_ID
        AND DI.PERSON_ID              = T1.PERSON_ID
        AND DI.PERSON_ID              = T2.PERSON_ID
			  AND DI.WORK_DATE              = P_WORK_DATE
			  AND DI.WORK_CORP_ID           = P_CORP_ID
				AND DI.SOB_ID                 = P_SOB_ID
				AND DI.ORG_ID                 = P_ORG_ID
        AND DI.TRANS_YN               = 'N'
				AND EXISTS ( SELECT 'X'
											 FROM HRD_DUTY_MANAGER DM
											WHERE DM.CORP_ID               = DI.WORK_CORP_ID
												AND DM.DUTY_CONTROL_ID       = NVL(T2.FLOOR_ID, PM.PERSON_ID)
												AND DM.WORK_TYPE_ID          = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DI.WORK_TYPE_ID)
												AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
												AND DM.INOUT_YN              = 'Y'
												AND DM.START_DATE            <= P_WORK_DATE
												AND (DM.END_DATE IS NULL OR DM.END_DATE >= P_WORK_DATE)
										)	
       ;										
		EXCEPTION WHEN OTHERS THEN
		  V_RECORD_COUNT := 0;
		END;
		IF V_RECORD_COUNT > 0 THEN
		  O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10052', NULL);
			RETURN;
		END IF;
	  
		-- 출퇴근 정리 및 집계 처리 프로시져 호출.
		WORKDATA_GO( P_CONNECT_PERSON_ID => V_CONNECT_PERSON_ID
		           , P_WORK_DATE => P_WORK_DATE
							 , P_CORP_ID => P_CORP_ID
							 , P_SOB_ID => P_SOB_ID
							 , P_ORG_ID => P_ORG_ID
							 , P_USER_ID => P_USER_ID
							 , O_MESSAGE => O_MESSAGE
							 );
    
    -- 후일 출퇴근 정리 및 집계 처리 프로시져 호출.
		WORKDATA_GO( P_CONNECT_PERSON_ID => V_CONNECT_PERSON_ID
		           , P_WORK_DATE => P_WORK_DATE + 1
							 , P_CORP_ID => P_CORP_ID
							 , P_SOB_ID => P_SOB_ID
							 , P_ORG_ID => P_ORG_ID
							 , P_USER_ID => P_USER_ID
							 , O_MESSAGE => O_MESSAGE
							 );
							 							  
	END SET_MAIN;
	
-- 출퇴근 정리 및 집계 처리.
  PROCEDURE WORKDATA_GO
            ( P_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, P_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, P_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, P_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, P_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
						, P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
						, O_MESSAGE                           OUT VARCHAR2
						)
  AS
		/** 처리대상 조회 ==> 커서 적용 **/
		CURSOR CUR_PERSON
    IS
			SELECT PM.PERSON_ID
					 , PM.PERSON_NUM
					 , PM.NAME
					 , PM.CORP_ID
           , PM.WORK_CORP_ID
					 , T1.DEPT_ID
					 , T1.JOB_CLASS_ID
					 , T1.JOB_CATEGORY_ID
           , T1.JOB_CATEGORY_CODE
					 , T1.POST_ID
					 , T1.CARD_CHECK_FLAG
					 , T2.FLOOR_ID
					 , 'M' AS IO_CREATE_FLAG
					 , NVL(T_WC.WORK_TYPE_ID, PM.WORK_TYPE_ID) AS WORK_TYPE_ID
					 -- 당일 근무 정보.
					 , NVL(T_WC.WORK_TYPE_GROUP, '11') AS WORK_TYPE_GROUP
					 , T_WC.DUTY_ID AS DUTY_ID
					 , NVL(T_WC.HOLY_TYPE, '2') AS HOLY_TYPE
					 , T_WC.OPEN_TIME
					 , T_WC.CLOSE_TIME
					 , NVL(T_WC.DANGJIK_YN, 'N') AS DANGJIK_YN
					 , NVL(T_WC.ALL_NIGHT_YN, 'N') AS ALL_NIGHT_YN
					 , NVL(T_WC.LUNCH_YN, 'N') AS LUNCH_YN
					 , NVL(T_WC.DINNER_YN, 'N') AS DINNER_YN
					 , NVL(T_WC.MIDNIGHT_YN, 'N') AS MIDNIGHT_YN
					 -- 전일 근무 정보.
					 , NVL(P_WC.HOLY_TYPE, '2') AS P_HOLY_TYPE
					 , NVL(P_WC.DANGJIK_YN, 'N') AS P_DANGJIK_YN
					 , NVL(P_WC.ALL_NIGHT_YN, 'N') AS P_ALL_NIGHT_YN
				FROM HRM_PERSON_MASTER PM 
				  , (-- 시점 인사내역.
							SELECT HL.PERSON_ID
									, HL.DEPT_ID
									, HL.JOB_CLASS_ID
									, HL.POST_ID
									, PC.CARD_CHECK_FLAG
									, HL.JOB_CATEGORY_ID
                  , JC.JOB_CATEGORY_CODE
							FROM HRM_HISTORY_LINE HL  
							  , HRM_POST_CODE_V PC
                , HRM_JOB_CATEGORY_CODE_V JC
							WHERE HL.POST_ID          = PC.POST_ID(+)
                AND HL.JOB_CATEGORY_ID  = JC.JOB_CATEGORY_ID(+)
							  AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
																							FROM HRM_HISTORY_LINE S_HL
																						 WHERE S_HL.CHARGE_DATE            <= P_WORK_DATE
																							 AND S_HL.PERSON_ID              = HL.PERSON_ID
																						 GROUP BY S_HL.PERSON_ID
																					 )
						) T1
               , (-- 시점 인사내역.
                  SELECT PH.PERSON_ID
                       , PH.FLOOR_ID
                    FROM HRD_PERSON_HISTORY        PH
                   WHERE PH.EFFECTIVE_DATE_FR  <=  P_WORK_DATE
                     AND PH.EFFECTIVE_DATE_TO  >=  P_WORK_DATE
                 ) T2
					, (-- 당일 근무 계획. 
							SELECT WC.PERSON_ID
									 , WC.WORK_DATE
									 , WC.WORK_TYPE_ID
									 , WC.ATTRIBUTE5 AS WORK_TYPE_GROUP
									 , NVL(WC.C_DUTY_ID1, NVL(WC.C_DUTY_ID, WC.DUTY_ID)) AS DUTY_ID
									 , WC.HOLY_TYPE
									 , WC.OPEN_TIME
									 , WC.CLOSE_TIME
									 , WC.LUNCH_YN
									 , WC.DINNER_YN
									 , WC.MIDNIGHT_YN
									 , WC.DANGJIK_YN
									 , WC.ALL_NIGHT_YN
                   , WC.WORK_CORP_ID
									 , WC.CORP_ID                   
									 , WC.SOB_ID
									 , WC.ORG_ID					 
								FROM HRD_WORK_CALENDAR WC
							 WHERE WC.WORK_DATE                   = P_WORK_DATE
								 AND WC.WORK_CORP_ID                = P_CORP_ID
								 AND WC.SOB_ID                      = P_SOB_ID
								 AND WC.ORG_ID                      = P_ORG_ID
						) T_WC						
					, (-- 전일 근무 계획. 
							SELECT WC.PERSON_ID
									 , WC.WORK_DATE + 1 AS WORK_DATE
									 , NVL(WC.C_DUTY_ID1, NVL(WC.C_DUTY_ID, WC.DUTY_ID)) AS DUTY_ID
									 , WC.HOLY_TYPE
									 , WC.DANGJIK_YN
									 , WC.ALL_NIGHT_YN
                   , WC.WORK_CORP_ID
									 , WC.CORP_ID
									 , WC.SOB_ID
									 , WC.ORG_ID					 
								FROM HRD_WORK_CALENDAR WC
							 WHERE WC.WORK_DATE                   = (P_WORK_DATE - 1)
								 AND WC.WORK_CORP_ID                = P_CORP_ID
								 AND WC.SOB_ID                      = P_SOB_ID
								 AND WC.ORG_ID                      = P_ORG_ID
						) P_WC          
			WHERE PM.PERSON_ID                            = T1.PERSON_ID
        AND PM.PERSON_ID                            = T2.PERSON_ID
			  AND PM.PERSON_ID                            = T_WC.PERSON_ID(+)
				AND PM.WORK_CORP_ID                         = T_WC.WORK_CORP_ID(+)
				AND PM.SOB_ID                               = T_WC.SOB_ID(+)
				AND PM.ORG_ID                               = T_WC.ORG_ID(+)
				AND PM.PERSON_ID                            = P_WC.PERSON_ID(+)
				AND PM.WORK_CORP_ID                         = P_WC.WORK_CORP_ID(+)
				AND PM.SOB_ID                               = P_WC.SOB_ID(+)
				AND PM.ORG_ID                               = P_WC.ORG_ID(+)
				AND PM.WORK_CORP_ID                         = P_CORP_ID
				AND PM.SOB_ID                               = P_SOB_ID
				AND PM.ORG_ID                               = P_ORG_ID
				AND PM.JOIN_DATE                            <= P_WORK_DATE
				AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= P_WORK_DATE)
				AND EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_MANAGER DM
                      WHERE DM.CORP_ID               = PM.WORK_CORP_ID
                        AND DM.DUTY_CONTROL_ID       = NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                        AND DM.WORK_TYPE_ID          = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
                        AND NVL(P_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
                        AND DM.INOUT_YN              = 'Y'
                        AND DM.START_DATE            <= P_WORK_DATE
                        AND (DM.END_DATE IS NULL OR DM.END_DATE >= P_WORK_DATE)
                    )
        AND NOT EXISTS ( SELECT 'X'
                           FROM HRD_DAY_INTERFACE DI
                         WHERE DI.PERSON_ID       = PM.PERSON_ID
                           AND DI.WORK_DATE       = P_WORK_DATE
                           AND DI.TRANS_YN        = 'Y'
                       )
		  ;

    /**  출퇴근 기록 조회 위한 커서 정의 **/
    CURSOR CUR_IO_DATE
		       ( W_PERSON_ID                            HRM_PERSON_MASTER.PERSON_ID%TYPE
					 , W_WORK_DATE                            HRD_DAY_INTERFACE.WORK_DATE%TYPE
           , W_SOB_ID                               HRD_DAY_INTERFACE.SOB_ID%TYPE
           , W_ORG_ID                               HRD_DAY_INTERFACE.ORG_ID%TYPE) 
    IS
			SELECT AI.DEVICE_ID
					 , AI.IO_FLAG
					 , AI.PERSON_ID
					 , AI.CARD_NUM
					 , AI.IO_DATETIME
					 , AI.IO_DATE
					 , AI.IO_TIME
					 , AI.CREATED_FLAG
				FROM HRD_ATTEND_INTERFACE AI
			 WHERE AI.PERSON_ID                               = W_PERSON_ID
				 AND AI.IO_DATE                                 = W_WORK_DATE
         AND AI.SOB_ID                                  = W_SOB_ID
         AND AI.ORG_ID                                  = W_ORG_ID
			ORDER BY AI.IO_DATETIME, AI.IO_FLAG
      ;       
---------------------------------------------------------------------------------------------------
		
		D_SYSDATE                       HRD_DAY_INTERFACE.CREATION_DATE%TYPE;	 
		/*V_RECORD_COUNT                  NUMBER := 0;*/
		
		V_A_DUTY_ID                     HRM_COMMON.COMMON_ID%TYPE;
		V_NA_DUTY_ID                    HRM_COMMON.COMMON_ID%TYPE;
		V_H_DUTY_ID                     HRM_COMMON.COMMON_ID%TYPE;
		V_NH_DUTY_ID                    HRM_COMMON.COMMON_ID%TYPE;
		V_PH_DUTY_ID                    HRM_COMMON.COMMON_ID%TYPE;
		
		V_DUTY_ID                       HRM_COMMON.COMMON_ID%TYPE;
    V_ALL_NIGHT_YN                  VARCHAR2(2) := 'N';
    V_NIGHT_START_TIME              DATE := TO_DATE(TO_CHAR(P_WORK_DATE, 'YYYY-MM-DD') || ' 18:00', 'YYYY-MM-DD HH24:MI');
    
		IN_TIME                         HRD_DAY_INTERFACE.WORK_DATE%TYPE;
		OUT_TIME                        HRD_DAY_INTERFACE.WORK_DATE%TYPE;
		IN_TIME1                        HRD_DAY_INTERFACE.WORK_DATE%TYPE;
		OUT_TIME1                       HRD_DAY_INTERFACE.WORK_DATE%TYPE;
    -- 체크 출퇴근 시간.
		N_IN_TIME                       HRD_DAY_INTERFACE.WORK_DATE%TYPE;
		N_OUT_TIME                      HRD_DAY_INTERFACE.WORK_DATE%TYPE;
		N_IN_TIME1                      HRD_DAY_INTERFACE.WORK_DATE%TYPE;
		N_OUT_TIME1                     HRD_DAY_INTERFACE.WORK_DATE%TYPE;
    -- 수정 출퇴근 시간.
    M_IN_TIME                       HRD_DAY_MODIFY.MODIFY_TIME%TYPE;
    M_IN_TIME1                      HRD_DAY_MODIFY.MODIFY_TIME1%TYPE;
  BEGIN
    -- 기본값 설정.(근태기본값 : 결근)
		D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
		BEGIN
		  SELECT MAX(DECODE(DC.ATTEND_FLAG, 'A', DC.DUTY_ID, NULL)) AS ATTEND
					 , MAX(DECODE(DC.ATTEND_FLAG, 'NA', DC.DUTY_ID, NULL)) AS NONATTEND
					 , MAX(DECODE(DC.ATTEND_FLAG, 'H', DC.DUTY_ID, NULL)) AS HOLIDAY
					 , MAX(DECODE(DC.ATTEND_FLAG, 'NH', DC.DUTY_ID, NULL)) AS NONPAYHOLIDAY
					 , MAX(DECODE(DC.ATTEND_FLAG, 'PH', DC.DUTY_ID, NULL)) AS PAYHOLIDAY
				INTO V_A_DUTY_ID, V_NA_DUTY_ID, V_H_DUTY_ID, V_NH_DUTY_ID, V_PH_DUTY_ID
        FROM HRM_DUTY_CODE_V DC
       WHERE DC.ATTEND_FLAG                          IS NOT NULL
         AND DC.SOB_ID                               = P_SOB_ID
         AND DC.ORG_ID                               = P_ORG_ID
			;
		EXCEPTION WHEN OTHERS THEN
		  O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10045', '&&VALUE:=Duty Default Value(근태 기본값)&&TEXT:=Duty Code Check!(근태코드를 확인하세요)');
			RETURN;
		END;
		-- 출퇴근 생성 START --
		FOR C_PERSON IN  CUR_PERSON
		LOOP
      -- 변수 초기화.
			V_DUTY_ID                                           := V_NA_DUTY_ID;
			V_ALL_NIGHT_YN                                      := 'N';
      
			IN_TIME                                             := NULL;
			OUT_TIME                                            := NULL;
			IN_TIME1                                            := NULL;
			OUT_TIME1                                           := NULL;

			N_IN_TIME                                           := NULL;
      N_OUT_TIME                                          := NULL;
      N_IN_TIME1                                          := NULL;
      N_OUT_TIME1                                         := NULL;
   
      /*========================================================/
      ++++ 당일 출퇴근 시간 정리
      /========================================================*/
      FOR C_IO IN  CUR_IO_DATE(C_PERSON.PERSON_ID, P_WORK_DATE, P_SOB_ID, P_ORG_ID)
      LOOP
        IF C_IO.IO_FLAG = '1' THEN                         --출근
          IF IN_TIME IS NULL THEN
            IN_TIME := C_IO.IO_DATETIME;
          ELSE
            IN_TIME1 := C_IO.IO_DATETIME;
            -- 중복체크 검증.
            IF ABS(IN_TIME1 - IN_TIME) * 1440 <= 3 THEN
              IN_TIME1 := TO_DATE(NULL);
            END IF;
          END IF;
        ELSIF C_IO.IO_FLAG = '2' THEN                         --퇴근
          IF OUT_TIME IS NULL THEN
            OUT_TIME := C_IO.IO_DATETIME;
          ELSE
            OUT_TIME1 := C_IO.IO_DATETIME;
            -- 중복체크 검증.
            IF ABS(OUT_TIME1 - OUT_TIME) * 1440 <= 3 THEN
             OUT_TIME := OUT_TIME1;
             OUT_TIME1 := TO_DATE(NULL);
            END IF;
          END IF;
        END IF;
      END LOOP  C_IO;

      /*-- 근태 시각 자동 생성자 --*/
      IF C_PERSON.CARD_CHECK_FLAG = 'A' AND C_PERSON.HOLY_TYPE NOT IN('0', '1') THEN
        --> 출근기록이 없을 경우 자동 생성.
        IF IN_TIME IS NULL THEN
          IN_TIME := TO_DATE(TO_CHAR(P_WORK_DATE, 'YYYY-MM-DD') || '08:' || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(1,20)), '00'), 'YYYY-MM-DD HH24:MI');
          IF SYSDATE < IN_TIME THEN    -- 생성시간이 현재 시간보다 크면 초기화.
            IN_TIME := NULL;
          END IF;
        END IF;
        --> 퇴근기록이 없을 경우 자동 생성.
        IF OUT_TIME IS NULL THEN
          OUT_TIME := TO_DATE(TO_CHAR(P_WORK_DATE, 'YYYY-MM-DD') || '18:' || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(01,30)), '00'), 'YYYY-MM-DD HH24:MI');
          IF SYSDATE < OUT_TIME THEN    -- 생성시간이 현재 시간보다 크면 초기화.
            OUT_TIME := NULL;
          END IF;
        END IF;
      END IF;

      /*========================================================/
      ++++ 수정 출퇴근 시간 조회.
      /========================================================*/
      M_IN_TIME := NULL;
      M_IN_TIME1 := NULL;
      BEGIN
        -- 출근.
        SELECT DM.MODIFY_TIME
          , DM.MODIFY_TIME1
          INTO M_IN_TIME
          , M_IN_TIME1
          FROM HRD_DAY_MODIFY DM
        WHERE DM.PERSON_ID     = C_PERSON.PERSON_ID
          AND DM.WORK_DATE     = P_WORK_DATE
          AND DM.IO_FLAG       = '1'
        ;
      EXCEPTION WHEN OTHERS THEN
        M_IN_TIME := NULL;
        M_IN_TIME1 := NULL;
      END;
   
/*---------------------------------------------------------------------------------------------------/
----- 관리직 퇴근시간 없애기
----- 적용 안함.
/*--------------------------------------------------------------------------------------------------*/
/*   IF WORKDATA_CUR.JOB_CATE_CODE = '10' THEN
    IF '3' IN(WORKDATA_CUR.P_HOLY_TYPE, WORKDATA_CUR.PRE_HOLY_TYPE) THEN
     NULL;
    ELSIF '1' IN(WORKDATA_CUR.P_HOLY_TYPE) THEN
     NULL;
    ELSIF 'Y' IN(WORKDATA_CUR.DANGJIK_CHK, WORKDATA_CUR.PRE_DANGJIK_CHK) THEN
     NULL;
    ELSIF 'Y' IN(WORKDATA_CUR.ALL_NIGHT_CHK, WORKDATA_CUR.PRE_ALL_NIGHT_CHK) THEN
     NULL;
    ELSIF WORKDATA_CUR.P_DUTY_CODE IN('13', '21') THEN
     NULL;
    ELSE
     OUT_TIME := TO_DATE(NULL);
     OUT_TIME2 := TO_DATE(NULL);
    END IF;
   ELSE
    NULL;
   END IF;*/

/*---------------------------------------------------------------------------------------------------/
----- 관리직 퇴근시간 없애기 - 단, 철야, 당직, 야간, 휴일일 경우 제외
----- 적용 안함.
/*--------------------------------------------------------------------------------------------------*/
/*   IF C_PERSON.JOB_CATE_CODE = '10' THEN
   \* 2009-04-22수정 : 관리직 출퇴근시간 집계 - 22:30 이후/당직/철야/휴일 실적 보이기*\
    IF WORKDATA_CUR.P_HOLY_TYPE IN('0', '1') THEN
     NULL;
    ELSIF 'Y' IN(WORKDATA_CUR.DANGJIK_CHK, WORKDATA_CUR.PRE_DANGJIK_CHK) THEN
     NULL;
    ELSIF 'Y' IN(WORKDATA_CUR.ALL_NIGHT_CHK, WORKDATA_CUR.PRE_ALL_NIGHT_CHK) THEN
     NULL;
    ELSIF WORKDATA_CUR.P_DUTY_CODE IN('13', '21') THEN
     NULL;
    ELSIF NVL(OUT_TIME2, OUT_TIME) IS NOT NULL THEN
     IF NVL(OUT_TIME2, OUT_TIME) < TO_DATE(TO_CHAR(IN_DAY, 'YYYY-MM-DD') || '22:30:00', 'YYYY-MM-DD HH24:MI:SS') THEN
      OUT_TIME := TO_DATE(NULL);
      OUT_TIME2 := TO_DATE(NULL);
     END IF;
    END IF;
   END IF;*/

/*------------------------------------------------------------------------------------------/
----- 근태코드 설정 **
----- 고정근태 유 : 고정근태 적용
----- 고정근태 무 : . HOLY_TYPE(2, 3) - 출근기록 유(00-출근), 출근기록 무(11-결근)
           . HOLY_TYPE(0) - 출근기록 유(40-휴일근로), 출근기록 무(53-휴일)
           . 전일 철야, 전일 당직 - 출근기록 무(00-출근)
/------------------------------------------------------------------------------------------*/
      SELECT /*CASE
        WHEN WORKDATA_CUR.P_DUTY_CODE IN('00', '11', '53', '40') THEN*/
            CASE
              WHEN C_PERSON.HOLY_TYPE IN('0', '1') THEN
                CASE
                  WHEN C_PERSON.P_HOLY_TYPE = '3' AND TO_CHAR(OUT_TIME, 'HH24:MI') >= '09:30' THEN V_PH_DUTY_ID          -- 휴일 : 전일 야간, 금일 09:30 이후 퇴근
                  WHEN C_PERSON.P_HOLY_TYPE = 'N' AND TO_CHAR(OUT_TIME, 'HH24:MI') >= '08:00' THEN V_PH_DUTY_ID          -- 휴일 : 전일 야간, 금일 09:30 이후 퇴근
                  WHEN C_PERSON.P_ALL_NIGHT_YN = 'Y' AND TO_CHAR(OUT_TIME, 'HH24:MI') >= '09:30' THEN V_PH_DUTY_ID       -- 휴일 : 전일 철야, 금일 09:30 이후 퇴근
                  WHEN C_PERSON.P_DANGJIK_YN = 'Y' AND TO_CHAR(OUT_TIME, 'HH24:MI') >= '11:00' THEN V_PH_DUTY_ID         -- 휴일 : 전일 야간, 금일 09:30 이후 퇴근
                  WHEN (C_PERSON.P_ALL_NIGHT_YN = 'Y' OR C_PERSON.P_DANGJIK_YN = 'Y')
                    AND (C_PERSON.ALL_NIGHT_YN = 'Y' OR C_PERSON.DANGJIK_YN = 'Y') THEN V_PH_DUTY_ID                     -- 전일철야/당직, 금일 철야
                  WHEN IN_TIME IS NOT NULL THEN V_PH_DUTY_ID                                                             -- 휴일근무
                  WHEN M_IN_TIME IS NOT NULL THEN V_PH_DUTY_ID                                                           -- 휴일근무
                  WHEN C_PERSON.HOLY_TYPE IN('0') THEN V_NH_DUTY_ID
                  ELSE V_H_DUTY_ID                                                                                       -- 휴일
                END
              ELSE                                                                                                       -- 주간/야간
                CASE
                  WHEN C_PERSON.P_ALL_NIGHT_YN = 'Y' OR C_PERSON.P_DANGJIK_YN = 'Y' THEN V_A_DUTY_ID                     -- 전일철야/전일당직 정상근무
                  WHEN (C_PERSON.P_ALL_NIGHT_YN = 'Y' OR C_PERSON.P_DANGJIK_YN = 'Y')
                    AND (C_PERSON.ALL_NIGHT_YN = 'Y' OR C_PERSON.DANGJIK_YN = 'Y') THEN V_A_DUTY_ID                      -- 전일철야/당직, 금일 철야
                  WHEN IN_TIME IS NOT NULL  THEN V_A_DUTY_ID                                                             -- 출근기록 있음
                  WHEN M_IN_TIME IS NOT NULL THEN V_A_DUTY_ID                                                            -- 출근기록 있음
                  ELSE V_NA_DUTY_ID                                                                                      -- 출근기록 없음
                END
            END
      /*ELSE WORKDATA_CUR.P_DUTY_CODE
      END*/ AS DUTY_ID
        INTO V_DUTY_ID
      FROM DUAL;
      
      -- 휴일 야간 출근시 철야 자동 적용 --
      IF C_PERSON.HOLY_TYPE IN('0', '1') AND C_PERSON.ALL_NIGHT_YN = 'N' AND IN_TIME IS NOT NULL AND V_NIGHT_START_TIME < IN_TIME THEN 
        V_ALL_NIGHT_YN := 'Y';
      ELSE
        V_ALL_NIGHT_YN := C_PERSON.ALL_NIGHT_YN;
      END IF;
      
   /*\*-- 기존 데이터 존재 체크 - 미 존재 : 삽입, 존재 : 수정 --*\
      BEGIN
        SELECT DECODE(COUNT(DI.PERSON_ID), 0, 'I', 'U') AS DATA_FLAG
               , CASE
                   WHEN DI.MODIFY_YN = 'Y' THEN 'Y'
                   WHEN DI.MODIFY_IN_YN = 'Y' THEN 'Y'
                   WHEN DI.MODIFY_OUT_YN = 'Y' THEN 'Y'
                   ELSE 'N'
                 END MODIFY_FLAG
            INTO V_DATA_MODE, MODIFY_FLAG
            FROM HRD_DAY_INTERFACE_V DI
           WHERE DI.WORK_DATE             = P_WORK_DATE
             AND DI.PERSON_ID             = C_PERSON.PERSON_ID
          GROUP BY CASE
                   WHEN DI.MODIFY_YN = 'Y' THEN 'Y'
                   WHEN DI.MODIFY_IN_YN = 'Y' THEN 'Y'
                   WHEN DI.MODIFY_OUT_YN = 'Y' THEN 'Y'
                   ELSE 'N'
                 END   
        ;
      EXCEPTION WHEN OTHERS THEN
       V_DATA_MODE := 'I';
          MODIFY_FLAG := 'N';
      END;*/
   
    BEGIN
      UPDATE HRD_DAY_INTERFACE DI
        SET DI.DUTY_ID            = V_DUTY_ID
                                    /*-- 전호수 수정 : 휴일 수정자에 대해 다시 집계시 근태변경 반영 안되는 문제 대문.
                                    CASE
                                      WHEN DI.MODIFY_YN = 'Y' THEN DI.DUTY_ID
                                      WHEN DI.MODIFY_IN_YN = 'Y' THEN DI.DUTY_ID
                                      WHEN DI.MODIFY_OUT_YN = 'Y' THEN DI.DUTY_ID
                                      ELSE V_DUTY_ID
                                    END*/
          , DI.WORK_TYPE_ID       = C_PERSON.WORK_TYPE_ID
          , DI.HOLY_TYPE          = C_PERSON.HOLY_TYPE
          , DI.OPEN_TIME          = IN_TIME
          , DI.CLOSE_TIME         = OUT_TIME
          , DI.OPEN_TIME1         = IN_TIME1
          , DI.CLOSE_TIME1        = OUT_TIME1
          , DI.ALL_NIGHT_YN       = V_ALL_NIGHT_YN
          , DI.LAST_UPDATE_DATE   = GET_LOCAL_DATE(DI.SOB_ID)
          , DI.LAST_UPDATED_BY    = P_USER_ID
      WHERE DI.WORK_DATE          = P_WORK_DATE  
        AND DI.PERSON_ID          = C_PERSON.PERSON_ID
        AND DI.WORK_CORP_ID       = C_PERSON.WORK_CORP_ID
        AND DI.SOB_ID             = P_SOB_ID
        AND DI.ORG_ID             = P_ORG_ID
      ;
    END;
    IF (SQL%NOTFOUND) THEN
      INSERT INTO HRD_DAY_INTERFACE
      ( PERSON_ID, WORK_DATE, WORK_CORP_ID, CORP_ID, DEPT_ID, POST_ID
      , JOB_CATEGORY_ID, WORK_TYPE_ID
      , DUTY_ID, HOLY_TYPE
      , OPEN_TIME, CLOSE_TIME
      , OPEN_TIME1, CLOSE_TIME1
      , ALL_NIGHT_YN
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
      ) VALUES
      ( C_PERSON.PERSON_ID, P_WORK_DATE, C_PERSON.WORK_CORP_ID, C_PERSON.CORP_ID, C_PERSON.DEPT_ID, C_PERSON.POST_ID
      , C_PERSON.JOB_CATEGORY_ID, C_PERSON.WORK_TYPE_ID
      , V_DUTY_ID, C_PERSON.HOLY_TYPE
      , IN_TIME, OUT_TIME
      , IN_TIME1, OUT_TIME1
      , V_ALL_NIGHT_YN
      , P_SOB_ID, P_ORG_ID
      , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
      );
   
   END IF;
  END LOOP C_PERSON;
  COMMIT;
  O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10046', NULL);
  END WORKDATA_GO;

END HRD_DAY_INTERFACE_G_SET;
/
