CREATE OR REPLACE PACKAGE HRD_HOLIDAY_MANAGEMENT_G
AS

-- 년차휴가/정기휴가/특별휴가 관리 조회.
  PROCEDURE SELECT_HOLIDAY_MANAGEMENT
            ( P_CURSOR              OUT TYPES.TCURSOR
						, W_CORP_ID             IN  NUMBER
						, W_YYYYMM              IN  VARCHAR2
            , W_JOB_CATEGORY_ID     IN  NUMBER
						, W_DEPT_ID             IN  NUMBER
						, W_FLOOR_ID            IN  NUMBER
						, W_PERSON_ID           IN  NUMBER
            , W_CONNECT_PERSON_ID   IN  NUMBER
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            );

-- HOLIDAY_MANAGEMENT DUTY SUMMARY SELECT
  PROCEDURE SELECT_DUTY_SUMMARY
            ( P_CURSOR1             OUT TYPES.TCURSOR1
						, W_CORP_ID             IN  NUMBER
						, W_YEAR                IN  VARCHAR2
						, W_PERSON_ID           IN  NUMBER
						, W_SOB_ID              IN  NUMBER
						, W_ORG_ID              IN  NUMBER
            );

-- 휴가사항 UPDATE.
  PROCEDURE UPDATE_HOLIDAY_MANAGEMENT
            ( W_DUTY_YEAR           IN  VARCHAR2
            , W_PERSON_ID           IN  NUMBER
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            , P_NY_PRE_NEXT_NUM     IN  NUMBER
            , P_NY_CREATION_NUM     IN  NUMBER
            , P_NY_PLUS_NUM         IN  NUMBER
						, P_SM_PRE_NEXT_NUM     IN  NUMBER
            , P_SM_CREATION_NUM     IN  NUMBER
            , P_SM_PLUS_NUM         IN  NUMBER
						, P_SP_PRE_NEXT_NUM     IN  NUMBER
            , P_SP_CREATION_NUM     IN  NUMBER
            , P_SP_PLUS_NUM         IN  NUMBER
            , P_USER_ID             IN  NUMBER
            );

-- 휴가별 내용 UPDATE.
  PROCEDURE EXE_UPDATE
            ( W_HOLIDAY_TYPE        IN  VARCHAR2
						, W_DUTY_YEAR           IN  VARCHAR2
            , W_PERSON_ID           IN  NUMBER
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            , P_PRE_NEXT_NUM        IN  NUMBER
            , P_CREATION_NUM        IN  NUMBER
            , P_PLUS_NUM            IN  NUMBER
            , P_USER_ID             IN  NUMBER
            );
						
-- HOLIDAY MANAGEMENT SELECT - SHORT INFOMATION.
  PROCEDURE SELECT_HOLIDAY_MANAGEMENT_S
            ( P_CURSOR3             OUT TYPES.TCURSOR3
						, W_CORP_ID             IN  NUMBER
            , W_PERSON_ID           IN  NUMBER
            , W_START_YEAR          IN  VARCHAR2
            , W_END_YEAR            IN  VARCHAR2
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            );
            
-- HOLIDAY MANAGEMENT SELECT - SHORT INFOMATION.
  PROCEDURE DATA_SELECT_S1
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_CORP_ID                           IN NUMBER
            , W_PERSON_ID                         IN HRD_HOLIDAY_MANAGEMENT.PERSON_ID%TYPE
            , W_START_YEAR                        IN HRD_HOLIDAY_MANAGEMENT.DUTY_YEAR%TYPE
            , W_END_YEAR                          IN HRD_HOLIDAY_MANAGEMENT.DUTY_YEAR%TYPE
            , W_SOB_ID                            IN HRD_HOLIDAY_MANAGEMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_HOLIDAY_MANAGEMENT.ORG_ID%TYPE
            );

-- MONTH TOTAL DATA STATUS --> RECORD COUNT.
  PROCEDURE DATA_CLOSED_COUNT
            ( W_HOLIDAY_TYPE        IN  VARCHAR2
						, W_DUTY_YEAR           IN  VARCHAR2
            , W_PERSON_ID           IN  NUMBER
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            , O_RECORD_COUNT        OUT NUMBER
            );

END HRD_HOLIDAY_MANAGEMENT_G;

 
/
CREATE OR REPLACE PACKAGE BODY HRD_HOLIDAY_MANAGEMENT_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : HRD
/* PROGRAM NAME : HRD_HOLIDAY_MANAGEMENT_G
/* DESCRIPTION  : 휴가사항 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- 년차휴가/정기휴가/특별휴가 관리 조회.
  PROCEDURE SELECT_HOLIDAY_MANAGEMENT
            ( P_CURSOR              OUT TYPES.TCURSOR
						, W_CORP_ID             IN  NUMBER
						, W_YYYYMM              IN  VARCHAR2
            , W_JOB_CATEGORY_ID     IN  NUMBER
						, W_DEPT_ID             IN  NUMBER
						, W_FLOOR_ID            IN  NUMBER
						, W_PERSON_ID           IN  NUMBER
            , W_CONNECT_PERSON_ID   IN  NUMBER
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            )
  AS
    V_CONNECT_PERSON_ID           NUMBER;
    V_STD_YEAR                    VARCHAR2(4);
    V_END_DATE                    DATE;
		
		V_PAY_CAP                     VARCHAR2(5);
  BEGIN
    V_STD_YEAR := TO_CHAR(TO_DATE(W_YYYYMM, 'YYYY-MM'), 'YYYY');
    V_END_DATE := LAST_DAY(TO_DATE(W_YYYYMM, 'YYYY-MM'));
    
		-- 급여 권한 체크.
		V_PAY_CAP := HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID
																				 , W_START_DATE => V_END_DATE
																				 , W_END_DATE => V_END_DATE
																				 , W_MODULE_CODE => '30'
																				 , W_PERSON_ID => W_CONNECT_PERSON_ID
																				 , W_SOB_ID => W_SOB_ID
																				 , W_ORG_ID => W_ORG_ID);
    IF V_PAY_CAP = 'S' THEN
		  V_PAY_CAP := 'C';
		END IF;

    -- 근태권한 설정.
    IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID
                               , W_START_DATE => V_END_DATE
                               , W_END_DATE => V_END_DATE
                               , W_MODULE_CODE => '20'
                               , W_PERSON_ID => W_CONNECT_PERSON_ID
                               , W_SOB_ID => W_SOB_ID
                               , W_ORG_ID => W_ORG_ID) = 'C' THEN
      V_CONNECT_PERSON_ID := NULL;
    ELSE
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;

    OPEN P_CURSOR FOR
      SELECT DM.DEPT_NAME AS DEPT_NAME
           , PC.POST_CODE AS POST_NAME
           , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
           , HF.FLOOR_NAME AS FLOOR_NAME
           , PM.PERSON_ID    
           , PM.DISPLAY_NAME
           , PM.JOIN_DATE AS ORI_JOIN_DATE
           , PM.PAY_DATE
           , PM.RETIRE_DATE
           , V_STD_YEAR AS STD_YEAR
           -- 전년도 년차 정보.
					 , NVL(PY1.DUTY_YEAR, V_STD_YEAR - 1) AS PY_DUTY_YEAR
					 , NVL(PY1.PRE_NEXT_NUM, 0) AS PY_PRE_NEXT_NUM
					 , NVL(PY1.CREATION_NUM, 0) AS PY_CREATION_NUM
					 , NVL(PY1.PLUS_NUM, 0) AS PY_PLUS_NUM
					 , NVL(PY1.TOTAL_CREATION_NUM, 0) AS PY_TOTAL_CREATION_NUM
					 , NVL(PY1.USE_NUM, 0) AS PY_USE_NUM
					 , NVL(PY1.TOTAL_CREATION_NUM, 0) - NVL(PY1.USE_NUM, 0) AS PY_REMAIN_NUM
					 , NVL(PY1.TRANS_NEXT_YN, 'N') AS PY_TRANS_NEXT_YN
					 , NVL(PY1.TRANS_PAY_YN, 'N') AS PY_TRANS_PAY_YN
					 -- 당년도 년차 정보.
					 , NVL(NY1.DUTY_YEAR, V_STD_YEAR) AS NY_DUTY_YEAR
					 , NVL(NY1.PRE_NEXT_NUM, 0) AS NY_PRE_NEXT_NUM
					 , NVL(NY1.CREATION_NUM, 0) AS NY_CREATION_NUM
					 , NVL(NY1.PLUS_NUM, 0) AS NY_PLUS_NUM
					 , NVL(NY1.TOTAL_CREATION_NUM, 0) AS NY_TOTAL_CREATION_NUM
					 , NVL(NY1.USE_NUM, 0) AS NY_USE_NUM
					 , NVL(NY1.TOTAL_CREATION_NUM, 0) - NVL(NY1.USE_NUM, 0) AS NY_REMAIN_NUM
					 , NVL(NY1.TRANS_NEXT_YN, 'N') AS NY_TRANS_NEXT_YN
					 -- 년차수당은 급여 담당자에 한해 보여줌.
					 , DECODE(V_PAY_CAP, 'C', NY1.BASE_AMOUNT, NULL) AS BASE_AMOUNT
					 , DECODE(V_PAY_CAP, 'C', NY1.GENERAL_AMOUNT, NULL) AS GENERAL_AMOUNT
					 , DECODE(V_PAY_CAP, 'C', NY1.PAY_AMOUNT, NULL) AS PAY_AMOUNT
					 , DECODE(V_PAY_CAP, 'C', NY1.PAY_YYYYMM, NULL) AS PAY_YYYYMM
					 , NVL(DECODE(V_PAY_CAP, 'C', NY1.TRANS_PAY_YN, NULL), 'N') AS TRANS_PAY_YN
					 , NY1.TRANS_PAY_PERSON
					 -- 연중휴가 정보.
					 , NVL(SM1.DUTY_YEAR, V_STD_YEAR) AS SM_DUTY_YEAR
					 , NVL(SM1.PRE_NEXT_NUM, 0) AS SM_PRE_NEXT_NUM
					 , NVL(SM1.CREATION_NUM, 0) AS SM_CREATION_NUM
					 , NVL(SM1.PLUS_NUM, 0) AS SM_PLUS_NUM
					 , NVL(SM1.TOTAL_CREATION_NUM, 0) AS SM_TOTAL_CREATION_NUM
					 , NVL(SM1.USE_NUM, 0) AS SM_USE_NUM
					 , NVL(SM1.TOTAL_CREATION_NUM, 0) - NVL(SM1.USE_NUM, 0) AS SM_REMAIN_NUM
					 -- 특별유급휴가 정보.
					 , NVL(SP1.DUTY_YEAR, V_STD_YEAR) AS SP_DUTY_YEAR
					 , NVL(SP1.PRE_NEXT_NUM, 0) AS SP_PRE_NEXT_NUM
					 , NVL(SP1.CREATION_NUM, 0) AS SP_CREATION_NUM
					 , NVL(SP1.PLUS_NUM, 0) AS SP_PLUS_NUM
					 , NVL(SP1.TOTAL_CREATION_NUM, 0) AS SP_TOTAL_CREATION_NUM
					 , NVL(SP1.USE_NUM, 0) AS SP_USE_NUM
					 , NVL(SP1.TOTAL_CREATION_NUM, 0) - NVL(SP1.USE_NUM, 0) AS SP_REMAIN_NUM
        FROM HRM_PERSON_MASTER PM  
          , HRM_HISTORY_LINE   HL
          , HRM_DEPT_MASTER    DM
          , HRM_POST_CODE_V    PC
          , HRM_FLOOR_V        HF
					, (-- 전년도 년차 정보
						SELECT HM.PERSON_ID
								 , HM.SOB_ID
								 , HM.ORG_ID
						     , HM.DUTY_YEAR AS DUTY_YEAR
								 , HM.PRE_NEXT_NUM AS PRE_NEXT_NUM
								 , HM.CREATION_NUM AS CREATION_NUM
								 , HM.PLUS_NUM AS PLUS_NUM
								 , NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) AS TOTAL_CREATION_NUM
								 , HM.USE_NUM AS USE_NUM
								 , HM.TRANS_NEXT_YN AS TRANS_NEXT_YN
								 , HM.TRANS_PAY_YN AS TRANS_PAY_YN
							FROM HRD_HOLIDAY_MANAGEMENT HM
						WHERE HM.PERSON_ID             = NVL(W_PERSON_ID, HM.PERSON_ID)
					    AND HM.HOLIDAY_TYPE          = '1'
					    AND HM.DUTY_YEAR             = TO_CHAR(TO_DATE(V_STD_YEAR || '-01-01', 'YYYY-MM-DD') - 1, 'YYYY')
						  AND HM.SOB_ID                = W_SOB_ID
						  AND HM.ORG_ID                = W_ORG_ID
						) PY1
					, (-- 당년도 년차 정보.
						SELECT HM.PERSON_ID
								 , HM.SOB_ID
								 , HM.ORG_ID
						     , HM.DUTY_YEAR AS DUTY_YEAR
                 , HM.PRE_NEXT_NUM AS PRE_NEXT_NUM
                 , HM.CREATION_NUM AS CREATION_NUM
                 , HM.PLUS_NUM AS PLUS_NUM
                 , NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) AS TOTAL_CREATION_NUM
                 , HM.USE_NUM AS USE_NUM
                 , HM.TRANS_NEXT_YN AS TRANS_NEXT_YN
                 , HM.BASE_AMOUNT
                 , HM.GENERAL_AMOUNT
                 , HM.PAY_AMOUNT
                 , HM.PAY_YYYYMM
                 , HM.TRANS_PAY_YN
                 , HRM_PERSON_MASTER_G.NAME_F(HM.TRANS_PAY_PERSON_ID) AS TRANS_PAY_PERSON
              FROM HRD_HOLIDAY_MANAGEMENT HM
             WHERE HM.PERSON_ID             = NVL(W_PERSON_ID, HM.PERSON_ID)
               AND HM.HOLIDAY_TYPE          = '1'
               AND HM.DUTY_YEAR             = V_STD_YEAR
               AND HM.SOB_ID                = W_SOB_ID
               AND HM.ORG_ID                = W_ORG_ID
            ) NY1
          , (-- 당년도 연중휴가 정보.
            SELECT HM.PERSON_ID
                 , HM.SOB_ID
                 , HM.ORG_ID
                 , HM.DUTY_YEAR AS DUTY_YEAR
                 , HM.PRE_NEXT_NUM AS PRE_NEXT_NUM
                 , HM.CREATION_NUM AS CREATION_NUM
                 , HM.PLUS_NUM AS PLUS_NUM
                 , NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) AS TOTAL_CREATION_NUM
                 , HM.USE_NUM AS USE_NUM
              FROM HRD_HOLIDAY_MANAGEMENT HM
            WHERE HM.PERSON_ID             = NVL(W_PERSON_ID, HM.PERSON_ID)
              AND HM.HOLIDAY_TYPE          = '2'
              AND HM.DUTY_YEAR             = V_STD_YEAR
              AND HM.SOB_ID                = W_SOB_ID
              AND HM.ORG_ID                = W_ORG_ID
            ) SM1
          , (-- 당년도 특별유급휴가 정보.
            SELECT HM.PERSON_ID
                 , HM.SOB_ID
                 , HM.ORG_ID
                 , HM.DUTY_YEAR AS DUTY_YEAR
                 , HM.PRE_NEXT_NUM AS PRE_NEXT_NUM
                 , HM.CREATION_NUM AS CREATION_NUM
                 , HM.PLUS_NUM AS PLUS_NUM
                 , NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) AS TOTAL_CREATION_NUM
                 , HM.USE_NUM AS USE_NUM
              FROM HRD_HOLIDAY_MANAGEMENT HM
						WHERE HM.PERSON_ID             = NVL(W_PERSON_ID, HM.PERSON_ID)
						  AND HM.HOLIDAY_TYPE          = '3'
						  AND HM.DUTY_YEAR             = V_STD_YEAR
						  AND HM.SOB_ID                = W_SOB_ID
						  AND HM.ORG_ID                = W_ORG_ID
						) SP1	
      WHERE HL.DEPT_ID            = DM.DEPT_ID
        AND HL.POST_ID            = PC.POST_ID
        AND HL.FLOOR_ID           = HF.FLOOR_ID
        AND PM.PERSON_ID          = HL.PERSON_ID
			  AND PM.PERSON_ID          = PY1.PERSON_ID(+)
				AND PM.SOB_ID             = PY1.SOB_ID(+)
				AND PM.ORG_ID             = PY1.ORG_ID(+)
			  AND PM.PERSON_ID          = NY1.PERSON_ID(+)
				AND PM.SOB_ID             = NY1.SOB_ID(+)
				AND PM.ORG_ID             = NY1.ORG_ID(+)
				AND PM.PERSON_ID          = SM1.PERSON_ID(+)
				AND PM.SOB_ID             = SM1.SOB_ID(+)
				AND PM.ORG_ID             = SM1.ORG_ID(+)
				AND PM.PERSON_ID          = SP1.PERSON_ID(+)
				AND PM.SOB_ID             = SP1.SOB_ID(+)
				AND PM.ORG_ID             = SP1.ORG_ID(+)
        AND HL.HISTORY_LINE_ID    IN (SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                        FROM HRM_HISTORY_LINE S_HL
                                      WHERE S_HL.CHARGE_DATE            <= V_END_DATE
                                        AND S_HL.PERSON_ID              = HL.PERSON_ID
                                      GROUP BY S_HL.PERSON_ID
                                     )        
        AND PM.WORK_CORP_ID       = W_CORP_ID
        AND PM.SOB_ID             = W_SOB_ID
        AND PM.ORG_ID             = W_ORG_ID
        AND PM.PERSON_ID          = NVL(W_PERSON_ID, PM.PERSON_ID)
        AND HL.DEPT_ID            = NVL(W_DEPT_ID, HL.DEPT_ID)
				AND ((W_FLOOR_ID          IS NULL AND 1 = 1)
        OR   (W_FLOOR_ID          IS NOT NULL AND HL.FLOOR_ID = W_FLOOR_ID))
        AND ((W_JOB_CATEGORY_ID   IS NULL AND 1 = 1)
        OR   (W_JOB_CATEGORY_ID   IS NOT NULL AND HL.JOB_CATEGORY_ID = W_JOB_CATEGORY_ID))
        AND PM.JOIN_DATE          <= V_END_DATE
        AND (PM.RETIRE_DATE       >= TRUNC(V_END_DATE) OR PM.RETIRE_DATE IS NULL)

        /*AND EXISTS (SELECT 'X'
                      FROM HRD_DUTY_MANAGER DM
                      WHERE DM.CORP_ID                                = PM.CORP_ID
                       AND DM.DUTY_CONTROL_ID                         = HL.FLOOR_ID
                       AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
                       AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                       AND DM.START_DATE                              <= V_END_DATE
                       AND (DM.END_DATE IS NULL OR DM.END_DATE        >= V_END_DATE)
                       AND DM.SOB_ID                                  = PM.SOB_ID
                       AND DM.ORG_ID                                  = PM.ORG_ID
                   ) */
      ORDER BY DM.DEPT_SORT_NUM, DM.DEPT_CODE, HF.SORT_NUM, HF.FLOOR_CODE, PC.SORT_NUM, PC.POST_CODE, PM.PERSON_NUM
      ;
  END SELECT_HOLIDAY_MANAGEMENT;

-- HOLIDAY_MANAGEMENT DUTY SUMMARY SELECT
  PROCEDURE SELECT_DUTY_SUMMARY
            ( P_CURSOR1             OUT TYPES.TCURSOR1
						, W_CORP_ID             IN  NUMBER
						, W_YEAR                IN  VARCHAR2
						, W_PERSON_ID           IN  NUMBER
						, W_SOB_ID              IN  NUMBER
						, W_ORG_ID              IN  NUMBER
            )
  AS
    V_START_DATE                  DATE;
		V_END_DATE                    DATE;
		V_START_YYYYMM                VARCHAR2(7);
		V_END_YYYYMM                  VARCHAR2(7);
	BEGIN
    BEGIN
			SELECT HT.START_DATE, TO_CHAR(HT.START_DATE, 'YYYY-MM') AS START_YYYYMM
			     , HT.END_DATE, TO_CHAR(HT.END_DATE, 'YYYY-MM') AS END_YYYYMM
			  INTO V_START_DATE, V_START_YYYYMM
				   , V_END_DATE, V_END_YYYYMM
				FROM HRM_HOLIDAY_TERM_V HT
			 WHERE HT.HOLIDAY_YEAR          = W_YEAR
			   AND HT.SOB_ID                = W_SOB_ID
				 AND HT.ORG_ID                = W_ORG_ID
				 ;
		EXCEPTION WHEN OTHERS THEN
      IF W_YEAR IS NULL THEN
        V_START_DATE := TRUNC(SYSDATE, 'YEAR');
        V_END_DATE := LAST_DAY(TRUNC(SYSDATE));
      ELSE
        V_START_DATE := TO_DATE(W_YEAR || '-01-01', 'YYYY-MM-DD');
        V_END_DATE := TO_DATE(W_YEAR || '-12-31', 'YYYY-MM-DD');
      END IF;
      V_START_YYYYMM := TO_CHAR(V_START_DATE, 'YYYY-MM');
      V_END_YYYYMM := TO_CHAR(V_END_DATE, 'YYYY-MM');
		END;
		
	  OPEN P_CURSOR1 FOR
		  SELECT CY.YYYYMM
					 , ADD_MONTHS(TO_DATE(CY.YYYYMM || '-' || WT.END_DAY, 'YYYY-MM-DD'), NVL(WT.END_ADD_MONTH, 0)) + NVL(WT.END_ADD_DAY, 0) - 
						 ADD_MONTHS(TO_DATE(CY.YYYYMM || '-' || WT.START_DAY, 'YYYY-MM-DD'), NVL(WT.START_ADD_MONTH, 0)) + NVL(WT.START_ADD_DAY, 0) + 1 AS MONTH_DAY
					 , MT1.PAY_DAY
					 , D1.DUTY_DAY_11 AS DUTY_DAY_11
					 , D1.DUTY_DAY_20 AS DUTY_DAY_20
					 , D1.DUTY_DAY_22 AS DUTY_DAY_22
					 , D1.DUTY_DAY_23 AS DUTY_DAY_23
					 , D1.DUTY_DAY_54 AS DUTY_DAY_54
					 , D1.DUTY_DAY_55 AS DUTY_DAY_55
					 , D1.DUTY_DAY_56 AS DUTY_DAY_56
				FROM EAPP_CALENDAR_YYYYMM_V CY
					, HRM_WORK_TERM_V WT
					, (-- 월근태 정보.
						SELECT MT.DUTY_YYYYMM             
								 , (NVL(MT.TOTAL_DAY, 0) - NVL(MT.TOTAL_DED_DAY, 0)) AS PAY_DAY
							FROM HRD_MONTH_TOTAL MT
						 WHERE MT.DUTY_TYPE          = 'D2'
							 AND MT.PERSON_ID          = W_PERSON_ID
							 AND MT.DUTY_YYYYMM        BETWEEN V_START_YYYYMM AND V_END_YYYYMM
							 AND MT.SOB_ID             = W_SOB_ID
							 AND MT.ORG_ID             = W_ORG_ID
						) MT1
					, (-- 근태 자료.
						SELECT DL.PERSON_ID
									 , TO_CHAR(DL.WORK_DATE, 'YYYY-MM') AS DUTY_YYYYMM
									 , '11' AS DUTY_GROUP_11  
									 , NVL(SUM(DECODE(DC.HOLIDAY_MANAGE_DUTY_GROUP, '11', DC.APPLY_DAY, 0)), 0) AS DUTY_DAY_11
									 , '20' AS DUTY_GROUP_20  
									 , NVL(SUM(DECODE(DC.HOLIDAY_MANAGE_DUTY_GROUP, '20', DC.APPLY_DAY, 0)), 0) AS DUTY_DAY_20
									 , '22' AS DUTY_GROUP_22  
									 , NVL(SUM(DECODE(DC.HOLIDAY_MANAGE_DUTY_GROUP, '22', DC.APPLY_DAY, 0)), 0) AS DUTY_DAY_22
									 , '23' AS DUTY_GROUP_23 
									 , NVL(SUM(DECODE(DC.HOLIDAY_MANAGE_DUTY_GROUP, '23', DC.APPLY_DAY, 0)), 0) AS DUTY_DAY_23
									 , '54' AS DUTY_GROUP_54  
									 , NVL(SUM(DECODE(DC.HOLIDAY_MANAGE_DUTY_GROUP, '54', DC.APPLY_DAY, 0)), 0) AS DUTY_DAY_54
									 , '55' AS DUTY_GROUP_55  
									 , NVL(SUM(DECODE(DC.HOLIDAY_MANAGE_DUTY_GROUP, '55', DC.APPLY_DAY, 0)), 0) AS DUTY_DAY_55
									 , '56' AS DUTY_GROUP_56  
									 , NVL(SUM(DECODE(DC.HOLIDAY_MANAGE_DUTY_GROUP, '56', DC.APPLY_DAY, 0)), 0) AS DUTY_DAY_56
								FROM HRD_DAY_LEAVE_V1 DL
									 , HRM_DUTY_CODE_V DC
									 , HRM_PERSON_MASTER PM         
							WHERE DL.DUTY_ID                = DC.DUTY_ID
								AND DL.PERSON_ID              = PM.PERSON_ID
							  -- 중도 입/퇴사자의 경우 입퇴사일 사이만 적용.      
								AND DL.WORK_DATE              BETWEEN CASE
																												WHEN PM.JOIN_DATE > V_START_DATE THEN PM.JOIN_DATE
																												ELSE V_START_DATE 
																											END
																									AND CASE 
																												WHEN PM.RETIRE_DATE IS NOT NULL AND PM.RETIRE_DATE < V_END_DATE THEN PM.RETIRE_DATE
																												ELSE V_END_DATE
																													END
                AND PM.PERSON_ID              = W_PERSON_ID
                AND PM.WORK_CORP_ID           = W_CORP_ID
                AND PM.SOB_ID                 = W_SOB_ID
                AND PM.ORG_ID                 = W_ORG_ID
                AND DL.CLOSED_YN              = 'Y'
                AND DC.HOLIDAY_MANAGE_DUTY_GROUP IS NOT NULL
							GROUP BY DL.PERSON_ID
									   , TO_CHAR(DL.WORK_DATE, 'YYYY-MM')
							 ) D1
			WHERE CY.YYYYMM                        = MT1.DUTY_YYYYMM(+)
			  AND CY.YYYYMM                        = D1.DUTY_YYYYMM(+)
			  AND CY.YYYYMM                        BETWEEN V_START_YYYYMM AND V_END_YYYYMM
			  AND WT.SOB_ID                        = W_SOB_ID
			  AND WT.ORG_ID                        = W_ORG_ID
			ORDER BY CY.YYYYMM 
      ;
	END SELECT_DUTY_SUMMARY;

-- 휴가사항 UPDATE.
  PROCEDURE UPDATE_HOLIDAY_MANAGEMENT
            ( W_DUTY_YEAR           IN  VARCHAR2
            , W_PERSON_ID           IN  NUMBER
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            , P_NY_PRE_NEXT_NUM     IN  NUMBER
            , P_NY_CREATION_NUM     IN  NUMBER
            , P_NY_PLUS_NUM         IN  NUMBER
						, P_SM_PRE_NEXT_NUM     IN  NUMBER
            , P_SM_CREATION_NUM     IN  NUMBER
            , P_SM_PLUS_NUM         IN  NUMBER
						, P_SP_PRE_NEXT_NUM     IN  NUMBER
            , P_SP_CREATION_NUM     IN  NUMBER
            , P_SP_PLUS_NUM         IN  NUMBER
            , P_USER_ID             IN  NUMBER
            )
  AS
	  V_ERR_MESSAGE            VARCHAR2(300);
		V_CLOSED_COUNT           NUMBER := 0;
    V_HOLIDAY_TYPE           VARCHAR2(4);
  BEGIN
-------------------------------------------------------------------------------	
		-- 년차사항 수정.
		V_HOLIDAY_TYPE := '1';		
    -- 년차 마감 여부 체크.
		DATA_CLOSED_COUNT( W_HOLIDAY_TYPE => V_HOLIDAY_TYPE
		                 , W_DUTY_YEAR    => W_DUTY_YEAR
										 , W_PERSON_ID    => W_PERSON_ID
										 , W_SOB_ID       => W_SOB_ID
										 , W_ORG_ID       => W_ORG_ID
										 , O_RECORD_COUNT => V_CLOSED_COUNT
										 );
    IF V_CLOSED_COUNT > 0 THEN
      RAISE ERRNUMS.Data_Closed;
      RETURN;
    END IF;
		
		EXE_UPDATE ( W_HOLIDAY_TYPE   => V_HOLIDAY_TYPE
		           , W_DUTY_YEAR      => W_DUTY_YEAR
							 , W_PERSON_ID      => W_PERSON_ID
							 , W_SOB_ID         => W_SOB_ID
							 , W_ORG_ID         => W_ORG_ID
							 , P_PRE_NEXT_NUM   => P_NY_PRE_NEXT_NUM
							 , P_CREATION_NUM   => P_NY_CREATION_NUM
							 , P_PLUS_NUM       => P_NY_PLUS_NUM
							 , P_USER_ID        => P_USER_ID
							 );

-------------------------------------------------------------------------------    
		-- 연중휴가 수정.
		V_HOLIDAY_TYPE := '2';
		
    -- 연중휴가 마감 여부 체크.
		DATA_CLOSED_COUNT( W_HOLIDAY_TYPE => V_HOLIDAY_TYPE
		                 , W_DUTY_YEAR    => W_DUTY_YEAR
										 , W_PERSON_ID    => W_PERSON_ID
										 , W_SOB_ID       => W_SOB_ID
										 , W_ORG_ID       => W_ORG_ID
										 , O_RECORD_COUNT => V_CLOSED_COUNT
										 );
    IF V_CLOSED_COUNT > 0 THEN
      RAISE ERRNUMS.Data_Closed;
      RETURN;
    END IF;
		
		EXE_UPDATE ( W_HOLIDAY_TYPE   => V_HOLIDAY_TYPE
		           , W_DUTY_YEAR      => W_DUTY_YEAR
							 , W_PERSON_ID      => W_PERSON_ID
							 , W_SOB_ID         => W_SOB_ID
							 , W_ORG_ID         => W_ORG_ID
							 , P_PRE_NEXT_NUM   => P_SM_PRE_NEXT_NUM
							 , P_CREATION_NUM   => P_SM_CREATION_NUM
							 , P_PLUS_NUM       => P_SM_PLUS_NUM
							 , P_USER_ID        => P_USER_ID
							 );
							 
-------------------------------------------------------------------------------							 
    -- 특별휴가 수정.
		V_HOLIDAY_TYPE := '3';
		
    -- 특별휴가 마감 여부 체크.
		DATA_CLOSED_COUNT( W_HOLIDAY_TYPE => V_HOLIDAY_TYPE
		                 , W_DUTY_YEAR    => W_DUTY_YEAR
										 , W_PERSON_ID    => W_PERSON_ID
										 , W_SOB_ID       => W_SOB_ID
										 , W_ORG_ID       => W_ORG_ID
										 , O_RECORD_COUNT => V_CLOSED_COUNT
										 );
    IF V_CLOSED_COUNT > 0 THEN
      RAISE ERRNUMS.Data_Closed;
      RETURN;
    END IF;
		
		EXE_UPDATE ( W_HOLIDAY_TYPE   => V_HOLIDAY_TYPE
		           , W_DUTY_YEAR      => W_DUTY_YEAR
							 , W_PERSON_ID      => W_PERSON_ID
							 , W_SOB_ID         => W_SOB_ID
							 , W_ORG_ID         => W_ORG_ID
							 , P_PRE_NEXT_NUM   => P_SP_PRE_NEXT_NUM
							 , P_CREATION_NUM   => P_SP_CREATION_NUM
							 , P_PLUS_NUM       => P_SP_PLUS_NUM
							 , P_USER_ID        => P_USER_ID
							 );
  EXCEPTION
    WHEN ERRNUMS.Data_Closed THEN		
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
		WHEN ERRNUMS.Update_Error THEN
		  V_ERR_MESSAGE := 'C : UPDATE ERROR';
			RAISE_APPLICATION_ERROR(-20001, V_ERR_MESSAGE);	
  END UPDATE_HOLIDAY_MANAGEMENT;

-- 휴가별 내용 UPDATE.
  PROCEDURE EXE_UPDATE
            ( W_HOLIDAY_TYPE        IN  VARCHAR2
						, W_DUTY_YEAR           IN  VARCHAR2
            , W_PERSON_ID           IN  NUMBER
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            , P_PRE_NEXT_NUM        IN  NUMBER
            , P_CREATION_NUM        IN  NUMBER
            , P_PLUS_NUM            IN  NUMBER
            , P_USER_ID             IN  NUMBER
            )
  AS
	  V_ERR_MESSAGE            VARCHAR2(300);
    V_SYSDATE                DATE := GET_LOCAL_DATE(W_SOB_ID);
		
  BEGIN
		BEGIN
		  UPDATE HRD_HOLIDAY_MANAGEMENT HM
			  SET HM.PRE_NEXT_NUM        = NVL(P_PRE_NEXT_NUM, 0)
				  , HM.CREATION_NUM        = NVL(P_CREATION_NUM, 0)
					, HM.USE_NUM             = NVL(P_PLUS_NUM, 0)
		      , HM.LAST_UPDATE_DATE    = V_SYSDATE
					, HM.LAST_UPDATED_BY     = P_USER_ID
			WHERE HM.HOLIDAY_TYPE        = W_HOLIDAY_TYPE
			  AND HM.DUTY_YEAR           = W_DUTY_YEAR
				AND HM.PERSON_ID           = W_PERSON_ID
				AND HM.SOB_ID              = W_SOB_ID
				AND HM.ORG_ID              = W_ORG_ID
			;
			/*if (sql%notfound) then
			dbms_output.put_line(w_holiday_type ||  '    자료 없음');			
			else
			dbms_output.put_line(w_holiday_type ||  '    자료 있음');						
			end if;*/
			IF (SQL%NOTFOUND) THEN
			  INSERT INTO HRD_HOLIDAY_MANAGEMENT
				( PERSON_ID, HOLIDAY_TYPE, DUTY_YEAR
				, PRE_NEXT_NUM, CREATION_NUM, PLUS_NUM
				, SOB_ID, ORG_ID
				, CREATION_DATE, CREATED_BY
				, LAST_UPDATE_DATE, LAST_UPDATED_BY
				) VALUES
				( W_PERSON_ID, W_HOLIDAY_TYPE, W_DUTY_YEAR
				, P_PRE_NEXT_NUM, P_CREATION_NUM, P_PLUS_NUM
				, W_SOB_ID, W_ORG_ID
				, V_SYSDATE, P_USER_ID
				, V_SYSDATE, P_USER_ID
				);
			END IF;
		EXCEPTION WHEN OTHERS THEN
		  V_ERR_MESSAGE := SQLERRM;
		  RAISE_APPLICATION_ERROR(-20001, V_ERR_MESSAGE);	
		END;
  END EXE_UPDATE;	

-- HOLIDAY MANAGEMENT SELECT - SHORT INFOMATION.
  PROCEDURE SELECT_HOLIDAY_MANAGEMENT_S
            ( P_CURSOR3             OUT TYPES.TCURSOR3
						, W_CORP_ID             IN  NUMBER
            , W_PERSON_ID           IN  NUMBER
            , W_START_YEAR          IN  VARCHAR2
            , W_END_YEAR            IN  VARCHAR2
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
		  SELECT HM.HOLIDAY_TYPE
			     , HRM_COMMON_G.CODE_NAME_F('HOLIDAY_TYPE', HM.HOLIDAY_TYPE, HM.SOB_ID, HM.ORG_ID) AS HOLIDAY_TYPE_NAME
					 , NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) AS CREATION_NUM
					 , NVL(HM.USE_NUM, 0) AS USE_NUM
					 , NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) - NVL(HM.USE_NUM, 0) AS REMAIN_NUM					 
			  FROM HRD_HOLIDAY_MANAGEMENT HM
           , HRM_PERSON_MASTER      PM
			 WHERE HM.PERSON_ID          = PM.PERSON_ID
         AND PM.WORK_CORP_ID       = W_CORP_ID
			   AND HM.PERSON_ID          = NVL(W_PERSON_ID, HM.PERSON_ID)
				 AND HM.DUTY_YEAR          BETWEEN W_START_YEAR AND W_END_YEAR
				 AND HM.SOB_ID             = W_SOB_ID
				 AND HM.ORG_ID             = W_ORG_ID
			;
  END SELECT_HOLIDAY_MANAGEMENT_S;

-- HOLIDAY MANAGEMENT SELECT - SHORT INFOMATION.
  PROCEDURE DATA_SELECT_S1
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_CORP_ID                           IN NUMBER
            , W_PERSON_ID                         IN HRD_HOLIDAY_MANAGEMENT.PERSON_ID%TYPE
            , W_START_YEAR                        IN HRD_HOLIDAY_MANAGEMENT.DUTY_YEAR%TYPE
            , W_END_YEAR                          IN HRD_HOLIDAY_MANAGEMENT.DUTY_YEAR%TYPE
            , W_SOB_ID                            IN HRD_HOLIDAY_MANAGEMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_HOLIDAY_MANAGEMENT.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
		  SELECT HM.HOLIDAY_TYPE
			     , HRM_COMMON_G.CODE_NAME_F('HOLIDAY_TYPE', HM.HOLIDAY_TYPE, HM.SOB_ID, HM.ORG_ID) AS HOLIDAY_TYPE_NAME
					 , NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) AS CREATION_NUM
					 , NVL(HM.USE_NUM, 0) AS USE_NUM
					 , NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) - NVL(HM.USE_NUM, 0) AS REMAIN_NUM					 
			  FROM HRD_HOLIDAY_MANAGEMENT HM
           , HRM_PERSON_MASTER      PM
			 WHERE HM.PERSON_ID          = PM.PERSON_ID
         AND PM.WORK_CORP_ID       = W_CORP_ID
			   AND HM.PERSON_ID          = NVL(W_PERSON_ID, HM.PERSON_ID)
				 AND HM.DUTY_YEAR          BETWEEN W_START_YEAR AND W_END_YEAR
				 AND HM.SOB_ID             = W_SOB_ID
				 AND HM.ORG_ID             = W_ORG_ID
			;

  END DATA_SELECT_S1;
  
-- MONTH TOTAL DATA STATUS --> RECORD COUNT.
-- 급여처리, 잔여수 이월시 처리 불가.
  PROCEDURE DATA_CLOSED_COUNT
            ( W_HOLIDAY_TYPE        IN  VARCHAR2
						, W_DUTY_YEAR           IN  VARCHAR2
            , W_PERSON_ID           IN  NUMBER
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            , O_RECORD_COUNT        OUT NUMBER
            )
  AS
    V_RECORD_COUNT                                NUMBER := 0;
  BEGIN
    BEGIN
      -- 자료수 조회.
      SELECT COUNT(HM.PERSON_ID) AS CLOSE_COUNT
        INTO V_RECORD_COUNT
        FROM HRD_HOLIDAY_MANAGEMENT HM
       WHERE HM.HOLIDAY_TYPE        = W_HOLIDAY_TYPE
			   AND HM.DUTY_YEAR           = W_DUTY_YEAR
				 AND HM.PERSON_ID           = W_PERSON_ID
				 AND HM.SOB_ID              = W_SOB_ID
				 AND HM.ORG_ID              = W_ORG_ID
				 AND (HM.TRANS_NEXT_YN      = 'Y'
  		   OR   HM.TRANS_PAY_YN       = 'Y')
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    O_RECORD_COUNT := V_RECORD_COUNT;
  END DATA_CLOSED_COUNT;

END HRD_HOLIDAY_MANAGEMENT_G;
/
