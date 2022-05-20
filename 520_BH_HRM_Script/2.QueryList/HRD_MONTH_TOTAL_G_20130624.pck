CREATE OR REPLACE PACKAGE HRD_MONTH_TOTAL_G
AS


-- MONTH TOTAL SELECT[2011-12-21]수정
  PROCEDURE DATA_SELECT
           ( P_CURSOR             OUT TYPES.TCURSOR
           , W_DUTY_TYPE          IN  HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
           , W_DUTY_YYYYMM        IN  HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
           , W_CORP_ID            IN  HRD_MONTH_TOTAL.CORP_ID%TYPE
           , W_DEPT_ID            IN  HRM_DEPT_MASTER.DEPT_ID%TYPE
           , W_FLOOR_ID           IN  HRM_COMMON.COMMON_ID%TYPE
           , W_PERSON_ID          IN  HRD_MONTH_TOTAL.PERSON_ID%TYPE
           , W_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
           , W_SOB_ID             IN  HRD_MONTH_TOTAL.SOB_ID%TYPE
           , W_ORG_ID             IN  HRD_MONTH_TOTAL.ORG_ID%TYPE
           , W_WORK_CORP_ID       IN  HRD_MONTH_TOTAL.CORP_ID%TYPE
           , W_JOB_CATEGORY_ID    IN  NUMBER
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

-- 월근태 조회 : 주휴공제 리스트 --
  PROCEDURE SELECT_WEEKLY_DED
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
						, W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
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

-- MONTH TOTAL SELECT
  PROCEDURE SELECT_MONTH_TOTAL_SPREAD
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
						, W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
            , W_WORK_CORP_ID                      IN HRD_MONTH_TOTAL.WORK_CORP_ID%TYPE
            , W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
            , W_JOB_CATEGORY_ID                   IN HRD_MONTH_TOTAL.JOB_CATEGORY_ID%TYPE
						, W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE						
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
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

-- MONTH TOTAL SELECT[2011-12-21]수정
  PROCEDURE DATA_SELECT
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_DUTY_TYPE          IN  HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
            , W_DUTY_YYYYMM        IN  HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
            , W_CORP_ID            IN  HRD_MONTH_TOTAL.CORP_ID%TYPE
            , W_DEPT_ID            IN  HRM_DEPT_MASTER.DEPT_ID%TYPE
            , W_FLOOR_ID           IN  HRM_COMMON.COMMON_ID%TYPE
            , W_PERSON_ID          IN  HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID             IN  HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID             IN  HRD_MONTH_TOTAL.ORG_ID%TYPE
            , W_WORK_CORP_ID       IN  HRD_MONTH_TOTAL.CORP_ID%TYPE
            , W_JOB_CATEGORY_ID    IN  NUMBER
           )

   AS

             V_CONNECT_PERSON_ID      HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
             V_END_DATE               HRD_DAY_LEAVE.WORK_DATE%TYPE := NULL;
    
   BEGIN    
		           BEGIN
		                 SELECT ADD_MONTHS(TO_DATE(W_DUTY_YYYYMM || ' ' || WT.END_DAY, 'YYYY-MM-DD') + WT.END_ADD_DAY, WT.END_ADD_MONTH) AS END_DATE
	     		             INTO V_END_DATE
			                  FROM HRM_WORK_TERM_V       WT
			                 WHERE WT.DUTY_TERM_TYPE  =  W_DUTY_TYPE
				                  AND WT.SOB_ID          =  W_SOB_ID
				                  AND WT.ORG_ID          =  W_ORG_ID
		                      ;
		           EXCEPTION WHEN OTHERS THEN
		                     V_END_DATE := ADD_MONTHS(TRUNC(GET_LOCAL_DATE(W_SOB_ID), 'MONTH'), 1) - 1;
		           END;
             -- 근태권한 설정.
             IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => W_WORK_CORP_ID
                                        , W_START_DATE  => V_END_DATE
                                        , W_END_DATE    => V_END_DATE
                                        , W_MODULE_CODE => '20'
                                        , W_PERSON_ID   => W_CONNECT_PERSON_ID
                                        , W_SOB_ID      => W_SOB_ID
                                        , W_ORG_ID      => W_ORG_ID) = 'C' THEN
                V_CONNECT_PERSON_ID := NULL;
             ELSE
                V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
             END IF;

             OPEN P_CURSOR FOR
             SELECT HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID)  AS DEPT_NAME
					             , HRM_COMMON_G.ID_NAME_F(HL.POST_ID)         AS POST_NAME
					             , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
					             , HRM_COMMON_G.ID_NAME_F(HL.PAY_GRADE_ID)    AS PAY_GRADE_NAME
				               , PM.PERSON_ID		
					             , PM.DISPLAY_NAME
					             , T1.MONTH_TOTAL_ID
				            	 , T1.DUTY_TYPE
				            	 , T1.DUTY_YYYYMM 	
                       , T1.WORK_DATE_FR
                       , T1.WORK_DATE_TO				 
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
                       , PM.JOIN_DATE
                       , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)          AS CORP_NAME
                       , HRM_CORP_MASTER_G.CORP_NAME_F(PM.WORK_CORP_ID)     AS WORK_CORP_NAME
                       , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)                AS FLOOR_NAME
                       , HRM_COMMON_G.ID_NAME_F(HL.JOB_CLASS_ID )           AS JOB_CLASS_NAME
			           	FROM HRM_HISTORY_LINE  HL  
                      , HRM_DEPT_MASTER   DM
				             	, HRM_PERSON_MASTER PM
				             	,(SELECT MT.PERSON_ID    
							               		 , MT.MONTH_TOTAL_ID
							            	   	 , MT.DUTY_TYPE
								               	 , MT.DUTY_YYYYMM
                                 , MT.WORK_DATE_FR
                                 , MT.WORK_DATE_TO
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
					              			FROM HRD_MONTH_TOTAL     MT
					             		 WHERE MT.DUTY_TYPE     =  W_DUTY_TYPE
					              			 AND MT.DUTY_YYYYMM   =  W_DUTY_YYYYMM
					              			 AND MT.PERSON_ID     =  NVL(W_PERSON_ID, MT.PERSON_ID)
						              		 AND MT.CORP_ID       =  NVL(W_CORP_ID, MT.CORP_ID)
						              		 AND MT.WORK_CORP_ID  =  NVL(W_WORK_CORP_ID, MT.WORK_CORP_ID)
						              		 AND MT.SOB_ID        =  W_SOB_ID
							              	 AND MT.ORG_ID        =  W_ORG_ID
					        	     ) T1
                  , (-- 시점 인사내역.
                     SELECT PH.SOB_ID
                          , PH.ORG_ID
                          , PH.PERSON_ID
                          , PH.FLOOR_ID
                          , PH.DEPT_ID
                          , PH.WORK_TYPE_ID
                       FROM HRD_PERSON_HISTORY        PH
                      WHERE PH.EFFECTIVE_DATE_FR  <=  TRUNC(V_END_DATE)
                        AND PH.EFFECTIVE_DATE_TO  >=  TRUNC(V_END_DATE)
                    ) T2
			           WHERE HL.DEPT_ID          = DM.DEPT_ID
                   AND HL.PERSON_ID        = PM.PERSON_ID
			             AND PM.PERSON_ID        = T1.PERSON_ID(+)
			             AND PM.CORP_ID          = T1.CORP_ID(+)
			             AND PM.SOB_ID           = T1.SOB_ID(+)
			             AND PM.ORG_ID           = T1.ORG_ID(+)
                   AND PM.PERSON_ID        = T2.PERSON_ID(+)
                   AND PM.SOB_ID           = T2.SOB_ID(+)
                   AND PM.ORG_ID           = T2.ORG_ID(+)
			            AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
															                   FROM HRM_HISTORY_LINE      S_HL
                                               WHERE S_HL.PERSON_ID     =  HL.PERSON_ID
                                                 AND S_HL.CHARGE_DATE  <=  V_END_DATE
                                               GROUP BY S_HL.PERSON_ID
																                          	 )
                AND PM.CORP_ID          = NVL(W_CORP_ID, PM.CORP_ID)
                AND PM.WORK_CORP_ID     = NVL(W_WORK_CORP_ID, PM.WORK_CORP_ID)
                AND PM.PERSON_ID        = NVL(W_PERSON_ID, PM.PERSON_ID)
                AND PM.SOB_ID           = W_SOB_ID
                AND PM.ORG_ID           = W_ORG_ID
                AND HL.FLOOR_ID         = NVL(W_FLOOR_ID, HL.FLOOR_ID)
                AND T2.DEPT_ID          = NVL(W_DEPT_ID, T2.DEPT_ID)
                AND PM.JOIN_DATE       <= LAST_DAY(TO_DATE(W_DUTY_YYYYMM, 'YYYY-MM'))
                AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= TO_DATE(W_DUTY_YYYYMM, 'YYYY-MM'))
                AND ((W_JOB_CATEGORY_ID IS NULL
                  AND 1                 = 1)
                OR (W_JOB_CATEGORY_ID   IS NOT NULL
                  AND PM.JOB_CATEGORY_ID  = W_JOB_CATEGORY_ID))
                  
/*                  AND EXISTS (SELECT 'X'
									                   		FROM HRD_DUTY_MANAGER                              DM
									                  		WHERE DM.CORP_ID                                  = PM.WORK_CORP_ID
											                    AND DM.DUTY_CONTROL_ID                          = HL.FLOOR_ID
										                   	 AND DM.WORK_TYPE_ID                             = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
										                   	 AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
									                   		 AND DM.START_DATE                              <= V_END_DATE
										                   	 AND (DM.END_DATE IS NULL OR DM.END_DATE        >= V_END_DATE)
											                    AND DM.SOB_ID                                   = PM.SOB_ID
											                    AND DM.ORG_ID                                   = PM.ORG_ID
									                  ) 
*/
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

-- 월근태 조회 : 주휴공제 리스트 --
  PROCEDURE SELECT_WEEKLY_DED
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
						, W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            )
  AS
    V_DATE_FR           DATE;
    V_DATE_TO           DATE;    
  BEGIN    
		BEGIN
		  SELECT ADD_MONTHS(TO_DATE(W_DUTY_YYYYMM || ' ' || WT.START_DAY, 'YYYY-MM-DD') + WT.START_ADD_DAY, WT.START_ADD_MONTH) AS DATE_FR
           , ADD_MONTHS(TO_DATE(W_DUTY_YYYYMM || ' ' || WT.END_DAY, 'YYYY-MM-DD') + WT.END_ADD_DAY, WT.END_ADD_MONTH) AS DATE_TO
			  INTO V_DATE_FR
           , V_DATE_TO
			  FROM HRM_WORK_TERM_V WT
			 WHERE WT.DUTY_TERM_TYPE                = W_DUTY_TYPE
				 AND WT.SOB_ID                        = W_SOB_ID
				 AND WT.ORG_ID                        = W_ORG_ID
		     ;
		EXCEPTION WHEN OTHERS THEN
      V_DATE_TO := TRUNC(TO_DATE(W_DUTY_YYYYMM, 'YYYY-MM'), 'MONTH');
		  V_DATE_TO := LAST_DAY(TO_DATE(W_DUTY_YYYYMM, 'YYYY-MM'));
		END;
    
    OPEN P_CURSOR1 FOR
      SELECT TO_CHAR(WD.WORK_DATE, 'YYYY-MM-DD') AS WORK_DATE
           , HRM_COMMON_G.WEEK_F(TO_CHAR(WD.WORK_DATE, 'D'), WD.SOB_ID, WD.ORG_ID) AS WORK_DATE_WEEKLY
           , ( SELECT HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.HOLY_TYPE, WC.SOB_ID, WC.ORG_ID) AS HOLY_TYPE_DESC
                 FROM HRD_WORK_CALENDAR WC
                WHERE WC.WORK_DATE      = WD.WORK_DATE
                  AND WC.PERSON_ID      = WD.PERSON_ID
                  AND WC.SOB_ID         = WD.SOB_ID
                  AND WC.ORG_ID         = WD.ORG_ID
                  AND ROWNUM            <= 1
             ) AS WORK_HOLY_TYPE
           , TO_CHAR(WD.DED_DATE, 'YYYY-MM-DD') AS DED_DATE            
           , HRM_COMMON_G.WEEK_F(TO_CHAR(WD.DED_DATE, 'D'), WD.SOB_ID, WD.ORG_ID) AS DED_WEEKLY
           , ( SELECT HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.HOLY_TYPE, WC.SOB_ID, WC.ORG_ID) AS HOLY_TYPE_DESC
                 FROM HRD_WORK_CALENDAR WC
                WHERE WC.WORK_DATE      = WD.DED_DATE
                  AND WC.PERSON_ID      = WD.PERSON_ID
                  AND WC.SOB_ID         = WD.SOB_ID
                  AND WC.ORG_ID         = WD.ORG_ID
                  AND ROWNUM            <= 1
             ) AS DED_HOLY_TYPE
           , W_DUTY_TYPE AS DUTY_TYPE
           , W_DUTY_YYYYMM AS DUTY_YYYYMM
           , WD.PERSON_ID
        FROM HRD_WEEKLY_DED WD
       WHERE WD.DED_DATE        BETWEEN V_DATE_FR AND V_DATE_TO 
         AND WD.PERSON_ID       = W_PERSON_ID
         AND WD.SOB_ID          = W_SOB_ID
         AND WD.ORG_ID          = W_ORG_ID
       ORDER BY WD.DED_DATE
       ;
  END SELECT_WEEKLY_DED;
  
  	
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

-- 월근태 현황 : 항목별 조회.
  PROCEDURE SELECT_MONTH_TOTAL_SPREAD
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
						, W_DUTY_TYPE                         IN HRD_MONTH_TOTAL.DUTY_TYPE%TYPE
						, W_DUTY_YYYYMM                       IN HRD_MONTH_TOTAL.DUTY_YYYYMM%TYPE
            , W_WORK_CORP_ID                      IN HRD_MONTH_TOTAL.WORK_CORP_ID%TYPE
            , W_CORP_ID                           IN HRD_MONTH_TOTAL.CORP_ID%TYPE
            , W_JOB_CATEGORY_ID                   IN HRD_MONTH_TOTAL.JOB_CATEGORY_ID%TYPE
						, W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
						, W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE						
						, W_PERSON_ID                         IN HRD_MONTH_TOTAL.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_MONTH_TOTAL.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_MONTH_TOTAL.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT MT.PERSON_ID
           , PM.NAME
           , PM.PERSON_NUM
           , T2.FLOOR_NAME
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
           , MTO.LEAVE_TIME
           , MTO.LATE_TIME
           , MTO.REST_TIME
           , MTO.OVER_TIME
           , MTO.HOLIDAY_TIME
           , MTO.HOLYDAY_OT_TIME
           , MTO.NIGHT_BONUS_TIME
           , MTO.NIGHT_TIME
           , MTD.DUTY_00       -- 출근.
           , MTD.DUTY_11       -- 결근.
           , MTD.DUTY_54       -- 무급휴가.
           , MTD.DUTY_55       -- 유급휴가.
           , MTD.UNPAID_COUNT  -- 무급총일수.
           , T2.DEPT_CODE
           , T2.DEPT_NAME
           , T1.POST_NAME
           , T1.JOB_CATEGORY_NAME
           , PM.JOIN_DATE
           , PM.RETIRE_DATE
           , MT.DESCRIPTION
           , MT.CLOSED_YN
           , DECODE(MT.CLOSED_YN, 'Y', HRM_PERSON_MASTER_G.NAME_F(MT.CLOSED_PERSON_ID), NULL) AS CLOSED_PERSON
           , MT.MONTH_TOTAL_ID
           , MT.DUTY_TYPE
           , MT.DUTY_YYYYMM
        FROM HRM_PERSON_MASTER      PM
           , HRD_MONTH_TOTAL        MT
           , HRD_MONTH_TOTAL_OT_V   MTO
           , HRD_MONTH_TOTAL_DUTY_V MTD
           , (-- 시점 인사내역.
              SELECT HL.PERSON_ID
                  , HL.DEPT_ID
                  , HL.POST_ID
                  , PC.POST_CODE
                  , PC.POST_NAME
                  , PC.SORT_NUM AS POST_SORT_NUM
                  , HL.JOB_CATEGORY_ID AS JOB_CATEGORY_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                  , HL.FLOOR_ID
                FROM HRM_HISTORY_LINE   HL  
                  , HRM_POST_CODE_V     PC
              WHERE HL.POST_ID          = PC.POST_ID
                AND ((W_JOB_CATEGORY_ID IS NULL AND 1 = 1)
                OR   (W_JOB_CATEGORY_ID IS NOT NULL AND HL.JOB_CATEGORY_ID = W_JOB_CATEGORY_ID))
                AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                              FROM HRM_HISTORY_LINE S_HL
                                             WHERE S_HL.CHARGE_DATE     <= LAST_DAY(TO_DATE(W_DUTY_YYYYMM, 'YYYY-MM'))
                                               AND S_HL.PERSON_ID       = HL.PERSON_ID
                                             GROUP BY S_HL.PERSON_ID
                                           )
             ) T1
           , ( -- 시점 인사내역.
               SELECT PH.PERSON_ID
                    , PH.FLOOR_ID
                    , HF.FLOOR_CODE
                    , HF.FLOOR_NAME
                    , HF.SORT_NUM AS FLOOR_SORT_NUM
                    , PH.DEPT_ID
                    , DM.DEPT_CODE
                    , DM.DEPT_NAME
                    , DM.DEPT_SORT_NUM
                    , PH.WORK_TYPE_ID
                 FROM HRD_PERSON_HISTORY PH
                   , HRM_DEPT_MASTER     DM
                   , HRM_FLOOR_V         HF
                WHERE PH.DEPT_ID            = DM.DEPT_ID
                  AND PH.FLOOR_ID           = HF.FLOOR_ID
                  AND PH.SOB_ID             = W_SOB_ID
                  AND PH.ORG_ID             = W_ORG_ID
                  AND PH.EFFECTIVE_DATE_FR  <=  LAST_DAY(TO_DATE(W_DUTY_YYYYMM, 'YYYY-MM'))
                  AND PH.EFFECTIVE_DATE_TO  >=  LAST_DAY(TO_DATE(W_DUTY_YYYYMM, 'YYYY-MM'))
                  AND ((W_DEPT_ID           IS NULL AND 1 = 1)
                  OR   (W_DEPT_ID           IS NOT NULL AND PH.DEPT_ID = W_DEPT_ID))
                  AND ((W_FLOOR_ID          IS NULL AND 1 = 1)
                  OR   (W_FLOOR_ID          IS NOT NULL AND PH.FLOOR_ID = W_FLOOR_ID))
              ) T2 
        WHERE PM.PERSON_ID             = MT.PERSON_ID
          AND MT.MONTH_TOTAL_ID        = MTO.MONTH_TOTAL_ID(+)
          AND MT.MONTH_TOTAL_ID        = MTD.MONTH_TOTAL_ID(+)
          AND MT.PERSON_ID             = T1.PERSON_ID
          AND MT.PERSON_ID             = T2.PERSON_ID
          AND MT.DUTY_YYYYMM           = W_DUTY_YYYYMM
          AND MT.DUTY_TYPE             = W_DUTY_TYPE
          AND MT.PERSON_ID             = NVL(W_PERSON_ID, MT.PERSON_ID)
          AND MT.WORK_CORP_ID          = NVL(W_WORK_CORP_ID, MT.WORK_CORP_ID)
          AND MT.CORP_ID               = NVL(W_CORP_ID, MT.CORP_ID)
          AND MT.SOB_ID                = W_SOB_ID
          AND MT.ORG_ID                = W_ORG_ID
        ORDER BY T2.FLOOR_SORT_NUM, T2.FLOOR_CODE, T1.POST_SORT_NUM, T1.POST_CODE, PM.PERSON_NUM
        ;
  END SELECT_MONTH_TOTAL_SPREAD;
  
END HRD_MONTH_TOTAL_G;
/
