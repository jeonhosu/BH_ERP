CREATE OR REPLACE PACKAGE HRD_MONTH_TOTAL_G
AS

-- MONTH TOTAL SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
						, W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
            , W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE						
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            );

-- MONTH_TOTAL_OT SELECT
  PROCEDURE MONTH_TOTAL_OT
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
            );
            
-- MONTH_TOTAL_DUTY SELECT
  PROCEDURE MONTH_TOTAL_DUTY
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
            );
						
-- MONTH TOTAL UPDATE
  PROCEDURE DATA_UPDATE
            ( W_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
            , P_HOLIDAY_IN_COUNT                  IN HRD_MONTH_TOTAL.HOLIDAY_IN_COUNT%TYPE
						, P_LATE_DED_COUNT                    IN HRD_MONTH_TOTAL.LATE_DED_COUNT%TYPE
						, P_WEEKLY_DED_COUNT                  IN HRD_MONTH_TOTAL.WEEKLY_DED_COUNT%TYPE
						, P_CHANGE_DED_COUNT                  IN HRD_MONTH_TOTAL.CHANGE_DED_COUNT%TYPE
						, P_TOT_DED_DAY                       IN HRD_MONTH_TOTAL.TOTAL_DED_DAY%TYPE
						, P_PAY_DAY                           IN HRD_MONTH_TOTAL.PAY_DAY%TYPE
            , P_DESCRIPTION                       IN HRD_MONTH_TOTAL.DESCRIPTION%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            );

-- MONTH TOTAL CLOSE PROCESS GO.
  PROCEDURE DATA_CLOSE_PROC
            ( W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
            , W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            );

-- MONTH TOTAL CLOSE CANCEL GO.
  PROCEDURE DATA_CLOSE_CANCEL
            ( W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
            , W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            );

-- MONTH TOTAL DATA STATUS --> RECORD COUNT.
  PROCEDURE DATA_CLOSE_YN_COUNT
            ( W_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
            , W_CLOSE_YN                          IN HRD_MONTH_TOTAL.CLOSED_YN%TYPE
            , O_RECORD_COUNT                      OUT NUMBER
            );
												
END HRD_MONTH_TOTAL_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRD_MONTH_TOTAL_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_MONTH_TOTAL_G
/* DESCRIPTION  : 월근태 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- MONTH TOTAL SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
						, W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
						, W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            )
  AS
    V_CONNECT_PERSON_ID                           HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
    V_END_DATE                                    HRD_DAY_LEAVE.WORK_DATE%TYPE := NULL;
    
  BEGIN    
		BEGIN
		  SELECT ADD_MONTHS(TO_DATE(W_DUTY_YYYYMM || ' ' || WT.END_DAY, 'YYYY-MM-DD') + WT.END_ADD_DAY, WT.END_ADD_MONTH) AS END_DATE
			  INTO V_END_DATE
			  FROM HRM_WORK_TERM_V WT
			 WHERE WT.DUTY_TERM_TYPE                = W_DUTY_TYPE
				 AND WT.SOB_ID                        = W_SOB_ID
				 AND WT.ORG_ID                        = W_ORG_ID
		     ;
		EXCEPTION WHEN OTHERS THEN
		  V_END_DATE := ADD_MONTHS(TRUNC(GET_LOCAL_DATE(W_SOB_ID), 'MONTH'), 1) - 1;
		END;
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
      SELECT HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
					 , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
					 , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
					 , HRM_COMMON_G.ID_NAME_F(HL.PAY_GRADE_ID) AS PAY_GRADE_NAME
					 , PM.PERSON_ID		
					 , PM.DISPLAY_NAME
					 , T1.MONTH_TOTAL_ID
					 , T1.DUTY_TYPE
					 , T1.DUTY_YYYYMM 					 
					 , T1.CORP_ID
					 , PM.ORI_JOIN_DATE
					 , PM.PAY_DATE
					 , PM.RETIRE_DATE
					 , T1.HOLIDAY_IN_COUNT
					 , T1.LATE_DED_COUNT
					 , T1.WEEKLY_DED_COUNT
					 , T1.CHANGE_DED_COUNT
					 , T1.HOLY_0_COUNT
           , T1.HOLY_1_COUNT
           , T1.HOLY_2_COUNT
           , T1.HOLY_3_COUNT
					 , T1.TOTAL_DAY
					 , T1.TOTAL_ATT_DAY
					 , T1.TOTAL_DED_DAY
					 , T1.PAY_DAY
           , NVL(T1.HOLY_0_DED_FLAG, 'N') AS HOLY_0_DED_FLAG
					 , T1.DESCRIPTION
					 , T1.CLOSED_YN
					 , T1.CLOSED_PERSON
					 , T1.SOB_ID
					 , T1.ORG_ID
				FROM HRM_HISTORY_LINE HL  
          , HRM_DEPT_MASTER DM
					, HRM_PERSON_MASTER PM
					, (SELECT MT.PERSON_ID    
									 , MT.MONTH_TOTAL_ID
									 , MT.DUTY_TYPE
									 , MT.DUTY_YYYYMM 					 
									 , MT.CORP_ID									 
									 , MT.HOLIDAY_IN_COUNT
									 , MT.LATE_DED_COUNT
									 , MT.WEEKLY_DED_COUNT
									 , MT.CHANGE_DED_COUNT
									 , MT.HOLY_0_COUNT
                   , MT.HOLY_1_COUNT
                   , MT.HOLY_2_COUNT
                   , MT.HOLY_3_COUNT
									 , MT.TOTAL_DAY
									 , MT.TOTAL_ATT_DAY
									 , MT.TOTAL_DED_DAY
									 , MT.PAY_DAY
                   , MT.HOLY_0_DED_FLAG
									 , MT.DESCRIPTION
									 , MT.CLOSED_YN
									 , HRM_PERSON_MASTER_G.NAME_F(MT.CLOSED_PERSON_ID) AS CLOSED_PERSON
									 , MT.SOB_ID
									 , MT.ORG_ID
								FROM HRD_MONTH_TOTAL MT
							 WHERE MT.DUTY_TYPE             = W_DUTY_TYPE
								 AND MT.DUTY_YYYYMM           = W_DUTY_YYYYMM
								 AND MT.PERSON_ID             = NVL(W_PERSON_ID, MT.PERSON_ID)
								 AND MT.WORK_CORP_ID          = W_CORP_ID
								 AND MT.SOB_ID                = W_SOB_ID
								 AND MT.ORG_ID                = W_ORG_ID
						) T1
			WHERE HL.DEPT_ID          = DM.DEPT_ID
        AND HL.PERSON_ID        = PM.PERSON_ID
			  AND PM.PERSON_ID        = T1.PERSON_ID(+)
				AND PM.CORP_ID          = T1.CORP_ID(+)
				AND PM.SOB_ID           = T1.SOB_ID(+)
				AND PM.ORG_ID           = T1.ORG_ID(+)
				AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
																			FROM HRM_HISTORY_LINE S_HL
																		 WHERE S_HL.CHARGE_DATE            <= V_END_DATE
																			 AND S_HL.PERSON_ID              = HL.PERSON_ID
																     GROUP BY S_HL.PERSON_ID
																	 )
        AND PM.WORK_CORP_ID     = W_CORP_ID
        AND PM.PERSON_ID        = NVL(W_PERSON_ID, PM.PERSON_ID)
        AND PM.SOB_ID           = W_SOB_ID
        AND PM.ORG_ID           = W_ORG_ID
        AND HL.FLOOR_ID         = NVL(W_FLOOR_ID, HL.FLOOR_ID)
        AND HL.DEPT_ID          = NVL(W_DEPT_ID, HL.DEPT_ID)
        AND PM.JOIN_DATE        <= LAST_DAY(TO_DATE(W_DUTY_YYYYMM, 'YYYY-MM'))
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= TO_DATE(W_DUTY_YYYYMM, 'YYYY-MM'))
/*        AND EXISTS (SELECT 'X'
											FROM HRD_DUTY_MANAGER DM
											WHERE DM.CORP_ID                                = PM.WORK_CORP_ID
											 AND DM.DUTY_CONTROL_ID                         = HL.FLOOR_ID
											 AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
											 AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
											 AND DM.START_DATE                              <= V_END_DATE
											 AND (DM.END_DATE IS NULL OR DM.END_DATE        >= V_END_DATE)
											 AND DM.SOB_ID                                  = PM.SOB_ID
											 AND DM.ORG_ID                                  = PM.ORG_ID
									 ) */
			ORDER BY DM.DEPT_CODE, PM.PERSON_NUM
			;	

  END DATA_SELECT;

-- MONTH_TOTAL_OT SELECT
  PROCEDURE MONTH_TOTAL_OT
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
		  SELECT MTO.MONTH_TOTAL_ID
					 , MTO.OT_TYPE
					 , HRM_COMMON_G.CODE_NAME_F('OT_TYPE', MTO.OT_TYPE, MTO.SOB_ID, MTO.ORG_ID) AS OT_TYPE_NAME
					 , MTO.OT_TIME
				FROM HRD_MONTH_TOTAL_OT MTO
          , HRM_OT_TYPE_V OT
			 WHERE MTO.OT_TYPE              = OT.OT_TYPE
         AND MTO.SOB_ID               = OT.SOB_ID
         AND MTO.ORG_ID               = OT.ORG_ID
         AND MTO.MONTH_TOTAL_ID       = W_MONTH_TOTAL_ID
      ORDER BY OT.SORT_NUM, OT.OT_TYPE       
			;
  
  END MONTH_TOTAL_OT;
  
-- MONTH_TOTAL_DUTY SELECT
  PROCEDURE MONTH_TOTAL_DUTY
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
            )
  AS
	BEGIN
	  OPEN P_CURSOR1 FOR
		  SELECT MTD.MONTH_TOTAL_ID
					 , MTD.DUTY_ID
					 , HRM_COMMON_G.ID_NAME_F(MTD.DUTY_ID) AS DUTY_NAME
					 , MTD.DUTY_COUNT
					 , NVL(CASE
                   WHEN DC.DUTY_CODE = '11' THEN 'Y'
                   ELSE DC.NON_PAY_DAY_FLAG
                 END, 'N') AS NON_PAY_YN
				FROM HRD_MONTH_TOTAL_DUTY MTD
				  , HRM_DUTY_CODE_V DC
			 WHERE MTD.DUTY_ID              = DC.DUTY_ID
			   AND MTD.SOB_ID               = DC.SOB_ID
				 AND MTD.ORG_ID               = DC.ORG_ID
			   AND MTD.MONTH_TOTAL_ID       = W_MONTH_TOTAL_ID
			;
	
	END MONTH_TOTAL_DUTY;
	
-- MONTH TOTAL UPDATE
  PROCEDURE DATA_UPDATE
            ( W_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
            , P_HOLIDAY_IN_COUNT                  IN HRD_MONTH_TOTAL.HOLIDAY_IN_COUNT%TYPE
						, P_LATE_DED_COUNT                    IN HRD_MONTH_TOTAL.LATE_DED_COUNT%TYPE
						, P_WEEKLY_DED_COUNT                  IN HRD_MONTH_TOTAL.WEEKLY_DED_COUNT%TYPE
						, P_CHANGE_DED_COUNT                  IN HRD_MONTH_TOTAL.CHANGE_DED_COUNT%TYPE
						, P_TOT_DED_DAY                       IN HRD_MONTH_TOTAL.TOTAL_DED_DAY%TYPE
						, P_PAY_DAY                           IN HRD_MONTH_TOTAL.PAY_DAY%TYPE
            , P_DESCRIPTION                       IN HRD_MONTH_TOTAL.DESCRIPTION%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , P_USER_ID                           IN HRD_MONTH_TOTAL.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                                     HRD_MONTH_TOTAL.CREATION_DATE%TYPE;
    V_CLOSE_COUNT                                 NUMBER := 0;
    V_TOTAL_DED_COUNT                             HRD_MONTH_TOTAL.TOTAL_DED_DAY%TYPE;
    
  BEGIN
    V_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
    -- 마감 여부 체크.
		DATA_CLOSE_YN_COUNT( W_MONTH_TOTAL_ID => W_MONTH_TOTAL_ID
		                    , W_CLOSE_YN => 'Y'
												, O_RECORD_COUNT => V_CLOSE_COUNT);
    IF V_CLOSE_COUNT > 0 THEN
      RAISE ERRNUMS.Data_Closed;
      RETURN;
    END IF;
    
		-- 총공제수 계산.
		V_TOTAL_DED_COUNT := HRD_MONTH_TOTAL_G_SET.NON_PAY_DAY_F(W_MONTH_TOTAL_ID) + NVL(P_LATE_DED_COUNT, 0) + NVL(P_WEEKLY_DED_COUNT, 0);

		-- UPDATE하기.
    UPDATE HRD_MONTH_TOTAL MT
      SET MT.LATE_DED_COUNT           = NVL(P_LATE_DED_COUNT, 0)
				, MT.WEEKLY_DED_COUNT         = NVL(P_WEEKLY_DED_COUNT, 0)
				, MT.CHANGE_DED_COUNT         = NVL(P_CHANGE_DED_COUNT, 0)
				, MT.TOTAL_DED_DAY            = NVL(V_TOTAL_DED_COUNT, 0)
				, MT.PAY_DAY                  = CASE 
                                          WHEN NVL(MT.TOTAL_DAY, 0) - (NVL(V_TOTAL_DED_COUNT, 0) + DECODE(MT.HOLY_0_DED_FLAG, 'Y', NVL(MT.HOLY_0_COUNT, 0), 0)) < 0 THEN 0
                                          ELSE NVL(MT.TOTAL_DAY, 0) - (NVL(V_TOTAL_DED_COUNT, 0) + DECODE(MT.HOLY_0_DED_FLAG, 'Y', NVL(MT.HOLY_0_COUNT, 0), 0))
                                        END
        , MT.DESCRIPTION              = P_DESCRIPTION
        , MT.LAST_UPDATE_DATE         = V_SYSDATE
        , MT.LAST_UPDATED_BY          = P_USER_ID
    WHERE MT.MONTH_TOTAL_ID           = W_MONTH_TOTAL_ID
    ;
  EXCEPTION
    WHEN ERRNUMS.Data_Closed THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
  END DATA_UPDATE;

-- MONTH TOTAL CLOSE PROCESS GO.
  PROCEDURE DATA_CLOSE_PROC
            ( W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
            , W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            )
  AS
    V_SYSDATE                                     HRD_DAY_LEAVE.CREATION_DATE%TYPE;
    
  BEGIN
    V_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);

    UPDATE HRD_MONTH_TOTAL MT
      SET MT.CLOSED_YN             = 'Y'
        , MT.CLOSED_DATE           = V_SYSDATE
        , MT.CLOSED_PERSON_ID      = W_CONNECT_PERSON_ID
    WHERE MT.DUTY_TYPE             = W_DUTY_TYPE
			AND MT.DUTY_YYYYMM           = W_DUTY_YYYYMM
			AND MT.WORK_CORP_ID          = W_CORP_ID
			AND MT.SOB_ID                = W_SOB_ID
			AND MT.ORG_ID                = W_ORG_ID
      AND MT.CLOSED_YN             = 'N'
    ;
    COMMIT;

  END DATA_CLOSE_PROC;

-- MONTH TOTAL CLOSE CANCEL GO.
  PROCEDURE DATA_CLOSE_CANCEL
            ( W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
            , W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
						, W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            )
  AS
    
  BEGIN
    UPDATE HRD_MONTH_TOTAL MT
      SET MT.CLOSED_YN             = 'N'
        , MT.CLOSED_DATE           = NULL
        , MT.CLOSED_PERSON_ID      = NULL
    WHERE MT.DUTY_TYPE             = W_DUTY_TYPE
			AND MT.DUTY_YYYYMM           = W_DUTY_YYYYMM
			AND MT.WORK_CORP_ID          = W_CORP_ID
			AND MT.SOB_ID                = W_SOB_ID
			AND MT.ORG_ID                = W_ORG_ID
      AND MT.CLOSED_YN             = 'Y'
    ;
    COMMIT;

  END DATA_CLOSE_CANCEL;

-- MONTH TOTAL DATA STATUS --> RECORD COUNT.
  PROCEDURE DATA_CLOSE_YN_COUNT
            ( W_MONTH_TOTAL_ID                    IN HRD_MONTH_TOTAL.MONTH_TOTAL_ID%TYPE
            , W_CLOSE_YN                          IN HRD_MONTH_TOTAL.CLOSED_YN%TYPE
            , O_RECORD_COUNT                      OUT NUMBER
            )
  AS
    V_RECORD_COUNT                                NUMBER := 0;
		
  BEGIN
		
    BEGIN
      -- 자료수 조회.
      SELECT COUNT(MT.PERSON_ID) AS CLOSE_COUNT
        INTO V_RECORD_COUNT
      FROM HRD_MONTH_TOTAL MT
      WHERE MT.MONTH_TOTAL_ID                     = W_MONTH_TOTAL_ID
        AND MT.CLOSED_YN                          = NVL(W_CLOSE_YN, MT.CLOSED_YN)
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    O_RECORD_COUNT := V_RECORD_COUNT;

  END DATA_CLOSE_YN_COUNT;

END HRD_MONTH_TOTAL_G;
/
