CREATE OR REPLACE PACKAGE HRD_OT_LINE_G
AS
-- 연장근무 신청 라인 조회.
  PROCEDURE DATA_SELECT
            ( P_CURSOR                                OUT TYPES.TCURSOR
            , W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
						, W_WORK_DATE                             IN HRD_OT_LINE.WORK_DATE%TYPE
						, W_WORK_TYPE_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                             IN HRD_OT_LINE.PERSON_ID%TYPE
            );
						
-- DATA SELECT
  PROCEDURE DATA_INSERT_SELECT
            ( P_CURSOR                                OUT TYPES.TCURSOR
						, W_CORP_ID                               IN HRD_OT_HEADER.CORP_ID%TYPE
						, W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
						, W_STD_DATE                              IN HRD_OT_LINE.WORK_DATE%TYPE
						, W_DUTY_MANAGER_ID                       IN HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE
						, W_WORK_TYPE_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                             IN HRD_OT_LINE.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                     IN HRD_OT_HEADER.REQ_PERSON_ID%TYPE
						, W_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
						, W_ORG_ID                                IN HRD_OT_HEADER.ORG_ID%TYPE
            );						

-- DATA INSERT.
  PROCEDURE DATA_INSERT
            ( P_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
						, P_REQ_NUM                               IN HRD_OT_LINE.REQ_NUM%TYPE
            , P_PERSON_ID                             IN HRD_OT_LINE.PERSON_ID%TYPE
            , P_WORK_DATE                             IN HRD_OT_LINE.WORK_DATE%TYPE
            , P_BEFORE_OT_START                       IN HRD_OT_LINE.BEFORE_OT_START%TYPE
            , P_BEFORE_OT_END                         IN HRD_OT_LINE.BEFORE_OT_END%TYPE
            , P_AFTER_OT_START                        IN HRD_OT_LINE.AFTER_OT_START%TYPE
            , P_AFTER_OT_END                          IN HRD_OT_LINE.AFTER_OT_END%TYPE
						, P_LUNCH_YN                              IN HRD_OT_LINE.LUNCH_YN%TYPE
						, P_DINNER_YN                             IN HRD_OT_LINE.DINNER_YN%TYPE
						, P_MIDNIGHT_YN                           IN HRD_OT_LINE.MIDNIGHT_YN%TYPE
						, P_DANGJIK_YN                            IN HRD_OT_LINE.DANGJIK_YN%TYPE
						, P_ALL_NIGHT_YN                          IN HRD_OT_LINE.ALL_NIGHT_YN%TYPE
						, P_DESCRIPTION                           IN HRD_OT_LINE.DESCRIPTION%TYPE
            , P_USER_ID                               IN HRD_OT_LINE.CREATED_BY%TYPE
						, W_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
						, O_OT_LINE_ID                            OUT HRD_OT_LINE.OT_LINE_ID%TYPE						
            );

-- DATA UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_OT_LINE_ID                            IN HRD_OT_LINE.OT_LINE_ID%TYPE
						, W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
            , P_WORK_DATE                             IN HRD_OT_LINE.WORK_DATE%TYPE
            , P_BEFORE_OT_START                       IN HRD_OT_LINE.BEFORE_OT_START%TYPE
            , P_BEFORE_OT_END                         IN HRD_OT_LINE.BEFORE_OT_END%TYPE
            , P_AFTER_OT_START                        IN HRD_OT_LINE.AFTER_OT_START%TYPE
            , P_AFTER_OT_END                          IN HRD_OT_LINE.AFTER_OT_END%TYPE
						, P_LUNCH_YN                              IN HRD_OT_LINE.LUNCH_YN%TYPE
						, P_DINNER_YN                             IN HRD_OT_LINE.DINNER_YN%TYPE
						, P_MIDNIGHT_YN                           IN HRD_OT_LINE.MIDNIGHT_YN%TYPE
						, P_DANGJIK_YN                            IN HRD_OT_LINE.DANGJIK_YN%TYPE
						, P_ALL_NIGHT_YN                          IN HRD_OT_LINE.ALL_NIGHT_YN%TYPE
						, P_DESCRIPTION                           IN HRD_OT_LINE.DESCRIPTION%TYPE
            , P_USER_ID                               IN HRD_OT_LINE.CREATED_BY%TYPE
						, W_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
            );

-- DATA DELETE.
  PROCEDURE DATA_DELETE
            ( W_OT_LINE_ID                            IN HRD_OT_LINE.OT_LINE_ID%TYPE
						, W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
            );

-- DATA DELETE(승인이 되었어도 삭제).
  PROCEDURE DATA_DELETE_C
            ( W_OT_LINE_ID                            IN HRD_OT_LINE.OT_LINE_ID%TYPE
            );

-------------------------------------------------------------------------------
-- 연장근무 반려 라인 조회.
  PROCEDURE OT_LINE_RETURN_SELECT
            ( P_CURSOR1                               OUT TYPES.TCURSOR1
            , W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
						, W_WORK_DATE                             IN HRD_OT_LINE.WORK_DATE%TYPE
            );

-- 연장근무 반려 적용.
  PROCEDURE OT_LINE_RETURN_UPDATE
            ( W_OT_LINE_ID                            IN HRD_OT_LINE.OT_LINE_ID%TYPE
						, W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
            , P_REJECT_REMARK                         IN HRD_OT_LINE.REJECT_REMARK%TYPE
            , P_APPROVE_STATUS                        IN HRD_OT_LINE.APPROVE_STATUS%TYPE
						, P_CHECK_YN                              IN VARCHAR2
						, P_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, P_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
						, P_ORG_ID                                IN HRD_OT_HEADER.ORG_ID%TYPE   
						, P_USER_ID                               IN HRD_OT_HEADER.CREATED_BY%TYPE
            );
            
-------------------------------------------------------------------------------
-- LINE DATA COUNT.
  PROCEDURE DATA_LINE_COUNT
	          ( W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
						, O_RECORD_COUNT                          OUT NUMBER
						);
            
-------------------------------------------------------------------------------
-- DATA SELECT OT TIME.
  PROCEDURE OT_STD_TIME_O
	          ( W_CORP_ID                               IN HRD_OT_HEADER.CORP_ID%TYPE
						, W_PERSON_ID                             IN HRD_OT_LINE.PERSON_ID%TYPE
						, W_WORK_DATE                             IN HRD_OT_LINE.WORK_DATE%TYPE
						, W_DANGJIK_YN                            IN HRD_OT_LINE.DANGJIK_YN%TYPE
						, W_ALL_NIGHT_YN                          IN HRD_OT_LINE.ALL_NIGHT_YN%TYPE
						, W_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
						, W_ORG_ID                                IN HRD_OT_HEADER.ORG_ID%TYPE
						, O_BEFORE_OT_START                       OUT HRD_OT_LINE.BEFORE_OT_START%TYPE
						, O_BEFORE_OT_END                         OUT HRD_OT_LINE.BEFORE_OT_END%TYPE
						, O_AFTER_OT_START                        OUT HRD_OT_LINE.AFTER_OT_START%TYPE
						, O_AFTER_OT_END                          OUT HRD_OT_LINE.AFTER_OT_END%TYPE
            );		
						
END HRD_OT_LINE_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRD_OT_LINE_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_OT_HEADER_G
/* DESCRIPTION  : 연장근무 HEADER 신청 승인 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- DATA SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                                OUT TYPES.TCURSOR
            , W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
						, W_WORK_DATE                             IN HRD_OT_LINE.WORK_DATE%TYPE
						, W_WORK_TYPE_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                             IN HRD_OT_LINE.PERSON_ID%TYPE
            )
  AS
  BEGIN
	  OPEN P_CURSOR FOR
			SELECT OL.REQ_NUM  
					, OL.PERSON_ID
					, PM.NAME
          , PM.PERSON_NUM
					, HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
					, HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
					, HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME		
					, OL.WORK_DATE
					, OL.DANGJIK_YN
					, OL.ALL_NIGHT_YN
					, OL.BEFORE_OT_START
					, OL.BEFORE_OT_END
					, OL.AFTER_OT_START
					, OL.AFTER_OT_END
					, OL.LUNCH_YN
					, OL.DINNER_YN
					, OL.MIDNIGHT_YN
					, OL.DESCRIPTION
					, OL.LINE_SEQ
					, HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', OH.APPROVE_STATUS, OH.SOB_ID, OH.ORG_ID) AS APPROVE_STATUS_NAME
					, OH.APPROVE_STATUS
					, HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE_NAME
					, WC.HOLY_TYPE
					, HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.HOLY_TYPE, WC.SOB_ID, WC.ORG_ID) AS HOLY_NAME
          , 'N' AS APPROVE_YN
					, OL.OT_LINE_ID
					, OL.OT_HEADER_ID
          , OL.REJECT_REMARK
				FROM HRD_OT_LINE OL
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
																						 WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
																							 AND S_HL.PERSON_ID              = HL.PERSON_ID
																						 GROUP BY S_HL.PERSON_ID
																					 )
						) T1
					, HRD_OT_HEADER OH
					, HRD_WORK_CALENDAR WC
			 WHERE OL.PERSON_ID                               = PM.PERSON_ID
			   AND PM.PERSON_ID                               = T1.PERSON_ID
				 AND OL.REQ_NUM                                 = OH.REQ_NUM
				 AND OL.WORK_DATE                               = WC.WORK_DATE
				 AND OL.PERSON_ID                               = WC.PERSON_ID
				 AND OH.CORP_ID                                 = WC.CORP_ID
				 AND OH.SOB_ID                                  = WC.SOB_ID
				 AND OH.ORG_ID                                  = WC.ORG_ID				     
				 AND OH.OT_HEADER_ID                            = W_OT_HEADER_ID
				 AND OL.PERSON_ID                               = NVL(W_PERSON_ID, OL.PERSON_ID)
				 AND PM.WORK_TYPE_ID                            = NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
			 ORDER BY PM.WORK_TYPE_ID, WC.HOLY_TYPE
       ;
  END DATA_SELECT;

-- DATA INSERT SELECT
  PROCEDURE DATA_INSERT_SELECT
            ( P_CURSOR                                OUT TYPES.TCURSOR
						, W_CORP_ID                               IN HRD_OT_HEADER.CORP_ID%TYPE
						, W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
						, W_STD_DATE                              IN HRD_OT_LINE.WORK_DATE%TYPE
						, W_DUTY_MANAGER_ID                       IN HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE
						, W_WORK_TYPE_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                             IN HRD_OT_LINE.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                     IN HRD_OT_HEADER.REQ_PERSON_ID%TYPE
						, W_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
						, W_ORG_ID                                IN HRD_OT_HEADER.ORG_ID%TYPE
            )
  AS
	  V_CONNECT_PERSON_ID                               HRD_OT_HEADER.REQ_PERSON_ID%TYPE := NULL;
				
  BEGIN		
		V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
		
		OPEN P_CURSOR FOR
			SELECT PM.PERSON_ID
          , PM.NAME
          , PM.PERSON_NUM
          , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME    
          , W_STD_DATE AS WORK_DATE
          , 'N' AS DANGJIK_YN
          , 'N' AS ALL_NIGHT_YN
          , TO_DATE(TO_CHAR(W_STD_DATE + A_OST.START_ADD_DAY, 'YYYY-MM-DD') ||  ' ' || A_OST.START_TIME, 'YYYY-MM-DD HH24:MI') AS AFTER_OT_START
          , TO_DATE(TO_CHAR(W_STD_DATE + A_OST.END_ADD_DAY, 'YYYY-MM-DD') ||  ' ' || A_OST.END_TIME, 'YYYY-MM-DD HH24:MI') AS AFTER_OT_END
          , TO_DATE(TO_CHAR(W_STD_DATE + B_OST.START_ADD_DAY, 'YYYY-MM-DD') ||  ' ' || B_OST.START_TIME, 'YYYY-MM-DD HH24:MI') AS BEFORE_OT_START
          , TO_DATE(TO_CHAR(W_STD_DATE + B_OST.END_ADD_DAY, 'YYYY-MM-DD') ||  ' ' || B_OST.END_TIME, 'YYYY-MM-DD HH24:MI') AS BEFORE_OT_END          
          , 'N' AS LUNCH_YN
          , 'N' AS DINNER_YN
          , 'N' AS MIDNIGHT_YN
          , NULL AS DESCRIPTION
          , 0 AS LINE_SEQ
          , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', 'N', PM.SOB_ID, PM.ORG_ID) AS APPROVE_STATUS_NAME
          , 'N' APPROVE_STATUS
          , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE_NAME
          , WC.HOLY_TYPE
          , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.HOLY_TYPE, WC.SOB_ID, WC.ORG_ID) AS HOLY_NAME
					, NULL AS OT_LINE_ID
					, W_OT_HEADER_ID AS OT_HEADER_ID
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
																					 WHERE S_HL.CHARGE_DATE            <= W_STD_DATE
																					   AND S_HL.PERSON_ID              = HL.PERSON_ID
																					 GROUP BY S_HL.PERSON_ID
																				 )
						) T1
          , HRD_WORK_CALENDAR WC
          , HRM_WORK_TYPE_V B_WT
          , HRM_OT_STD_TIME_V B_OST
					, HRM_WORK_TYPE_V A_WT
          , HRM_OT_STD_TIME_V A_OST
       WHERE W_STD_DATE                                = WC.WORK_DATE
			   AND PM.PERSON_ID                               = T1.PERSON_ID(+)
         AND PM.PERSON_ID                               = WC.PERSON_ID
         AND PM.CORP_ID                                 = WC.CORP_ID
         AND PM.SOB_ID                                  = WC.SOB_ID
         AND PM.ORG_ID                                  = WC.ORG_ID
         AND WC.WORK_TYPE_ID                            = B_WT.WORK_TYPE_ID
         AND B_WT.WORK_TYPE_GROUP                       = NVL(B_OST.WORK_TYPE, B_WT.WORK_TYPE_GROUP)
         AND B_WT.SOB_ID                                = B_OST.SOB_ID
         AND B_WT.ORG_ID                                = B_OST.ORG_ID
         AND WC.HOLY_TYPE                               = B_OST.HOLY_TYPE
         AND 'B'                                        = B_OST.OT_STD_TYPE
				 AND WC.WORK_TYPE_ID                            = A_WT.WORK_TYPE_ID
         AND A_WT.WORK_TYPE_GROUP                       = NVL(A_OST.WORK_TYPE, A_WT.WORK_TYPE_GROUP)
         AND A_WT.SOB_ID                                = A_OST.SOB_ID
         AND A_WT.ORG_ID                                = A_OST.ORG_ID
         AND WC.HOLY_TYPE                               = A_OST.HOLY_TYPE
         AND 'A'                                        = A_OST.OT_STD_TYPE
         AND PM.WORK_CORP_ID                            = W_CORP_ID
         AND PM.PERSON_ID                               = NVL(W_PERSON_ID, PM.PERSON_ID)
         AND PM.WORK_TYPE_ID                            = NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
         AND PM.SOB_ID                                  = W_SOB_ID
         AND PM.ORG_ID                                  = W_ORG_ID
         AND PM.ORI_JOIN_DATE                           <= W_STD_DATE
         AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_STD_DATE)
         AND EXISTS ( SELECT 'X'
                       FROM HRD_DUTY_MANAGER DM
                      WHERE DM.CORP_ID                  = PM.CORP_ID
                        AND DM.DUTY_CONTROL_ID          = T1.FLOOR_ID
                        AND DM.WORK_TYPE_ID             = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
                        AND DM.SOB_ID                   = PM.SOB_ID
                        AND DM.ORG_ID                   = PM.ORG_ID
                        AND DM.DUTY_MANAGER_ID          = W_DUTY_MANAGER_ID
                        AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
                        AND DM.START_DATE               <= W_STD_DATE
                        AND (DM.END_DATE IS NULL OR DM.END_DATE >= W_STD_DATE)
                    )
				 ORDER BY PM.WORK_TYPE_ID, WC.HOLY_TYPE
         ;
				 
  END DATA_INSERT_SELECT;

-- DATA INSERT.
  PROCEDURE DATA_INSERT
            ( P_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
						, P_REQ_NUM                               IN HRD_OT_LINE.REQ_NUM%TYPE
            , P_PERSON_ID                             IN HRD_OT_LINE.PERSON_ID%TYPE
            , P_WORK_DATE                             IN HRD_OT_LINE.WORK_DATE%TYPE
            , P_BEFORE_OT_START                       IN HRD_OT_LINE.BEFORE_OT_START%TYPE
            , P_BEFORE_OT_END                         IN HRD_OT_LINE.BEFORE_OT_END%TYPE
            , P_AFTER_OT_START                        IN HRD_OT_LINE.AFTER_OT_START%TYPE
            , P_AFTER_OT_END                          IN HRD_OT_LINE.AFTER_OT_END%TYPE
						, P_LUNCH_YN                              IN HRD_OT_LINE.LUNCH_YN%TYPE
						, P_DINNER_YN                             IN HRD_OT_LINE.DINNER_YN%TYPE
						, P_MIDNIGHT_YN                           IN HRD_OT_LINE.MIDNIGHT_YN%TYPE
						, P_DANGJIK_YN                            IN HRD_OT_LINE.DANGJIK_YN%TYPE
						, P_ALL_NIGHT_YN                          IN HRD_OT_LINE.ALL_NIGHT_YN%TYPE
						, P_DESCRIPTION                           IN HRD_OT_LINE.DESCRIPTION%TYPE
            , P_USER_ID                               IN HRD_OT_LINE.CREATED_BY%TYPE
						, W_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
						, O_OT_LINE_ID                            OUT HRD_OT_LINE.OT_LINE_ID%TYPE
            )
  AS
    D_SYSDATE                                         HRD_OT_HEADER.CREATION_DATE%TYPE;
    V_OT_LINE_ID                                      HRD_OT_LINE.OT_LINE_ID%TYPE;
		
  BEGIN
    IF HRD_OT_HEADER_G.DATA_STATUS_CHECK(P_OT_HEADER_ID)= 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=삽입'));
    END IF;
    
		BEGIN
      D_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
      SELECT HRD_OT_LINE_S1.NEXTVAL
			  INTO V_OT_LINE_ID
			  FROM DUAL;
		EXCEPTION WHEN OTHERS THEN
		  RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=삽입'));
		END;			
    INSERT INTO HRD_OT_LINE
    (OT_LINE_ID, OT_HEADER_ID, REQ_NUM
    , PERSON_ID, WORK_DATE
    , BEFORE_OT_START, BEFORE_OT_END
		, AFTER_OT_START, AFTER_OT_END
		, LUNCH_YN, DINNER_YN, MIDNIGHT_YN
		, DANGJIK_YN, ALL_NIGHT_YN
    , DESCRIPTION
    , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
    ) VALUES
    ( V_OT_LINE_ID, P_OT_HEADER_ID, P_REQ_NUM
    , P_PERSON_ID, P_WORK_DATE
    , P_BEFORE_OT_START, P_BEFORE_OT_END
		, P_AFTER_OT_START, P_AFTER_OT_END
		, P_LUNCH_YN, P_DINNER_YN, P_MIDNIGHT_YN
		, P_DANGJIK_YN, P_ALL_NIGHT_YN
    , P_DESCRIPTION
    , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
    );

		-- 라인 일련번호 생성.
		UPDATE HRD_OT_LINE OL
      SET OL.LINE_SEQ                         = ROWNUM
    WHERE OL.OT_HEADER_ID                     = P_OT_HEADER_ID
    ;
    COMMIT;
		
		O_OT_LINE_ID := V_OT_LINE_ID;
		
  END DATA_INSERT;

-- DATA UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_OT_LINE_ID                            IN HRD_OT_LINE.OT_LINE_ID%TYPE
						, W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
            , P_WORK_DATE                             IN HRD_OT_LINE.WORK_DATE%TYPE
            , P_BEFORE_OT_START                       IN HRD_OT_LINE.BEFORE_OT_START%TYPE
            , P_BEFORE_OT_END                         IN HRD_OT_LINE.BEFORE_OT_END%TYPE
            , P_AFTER_OT_START                        IN HRD_OT_LINE.AFTER_OT_START%TYPE
            , P_AFTER_OT_END                          IN HRD_OT_LINE.AFTER_OT_END%TYPE
						, P_LUNCH_YN                              IN HRD_OT_LINE.LUNCH_YN%TYPE
						, P_DINNER_YN                             IN HRD_OT_LINE.DINNER_YN%TYPE
						, P_MIDNIGHT_YN                           IN HRD_OT_LINE.MIDNIGHT_YN%TYPE
						, P_DANGJIK_YN                            IN HRD_OT_LINE.DANGJIK_YN%TYPE
						, P_ALL_NIGHT_YN                          IN HRD_OT_LINE.ALL_NIGHT_YN%TYPE
						, P_DESCRIPTION                           IN HRD_OT_LINE.DESCRIPTION%TYPE
            , P_USER_ID                               IN HRD_OT_LINE.CREATED_BY%TYPE
						, W_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
            )
  AS
  BEGIN
    IF HRD_OT_HEADER_G.DATA_STATUS_CHECK(W_OT_HEADER_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=수정'));
    END IF;

    UPDATE HRD_OT_LINE OL
      SET OL.WORK_DATE                        = P_WORK_DATE
			  , OL.BEFORE_OT_START                  = P_BEFORE_OT_START
			  , OL.BEFORE_OT_END                    = P_BEFORE_OT_END
				, OL.AFTER_OT_START                   = P_AFTER_OT_START 
				, OL.AFTER_OT_END                     = P_AFTER_OT_END
				, OL.LUNCH_YN                         = P_LUNCH_YN
				, OL.DINNER_YN                        = P_DINNER_YN 
				, OL.MIDNIGHT_YN                      = P_MIDNIGHT_YN
				, OL.DANGJIK_YN                       = P_DANGJIK_YN
				, OL.ALL_NIGHT_YN                     = P_ALL_NIGHT_YN
			  , OL.DESCRIPTION                      = P_DESCRIPTION
        , OL.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(W_SOB_ID)
        , OL.LAST_UPDATED_BY                  = P_USER_ID
    WHERE OL.OT_LINE_ID                       = W_OT_LINE_ID
    ;
    COMMIT;

  END DATA_UPDATE;

-- DATA DELETE.
  PROCEDURE DATA_DELETE
            ( W_OT_LINE_ID                            IN HRD_OT_LINE.OT_LINE_ID%TYPE
						, W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
            )
  AS
  BEGIN
    IF HRD_OT_HEADER_G.DATA_STATUS_CHECK(W_OT_HEADER_ID)= 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=삭제'));
    END IF;

    DELETE HRD_OT_LINE OL
    WHERE OL.OT_LINE_ID                       = W_OT_LINE_ID
    ;
		
  END DATA_DELETE;

-- DATA DELETE(승인이 되었어도 삭제).
  PROCEDURE DATA_DELETE_C
            ( W_OT_LINE_ID                            IN HRD_OT_LINE.OT_LINE_ID%TYPE
            )
  AS
  BEGIN
    DELETE HRD_OT_LINE OL
    WHERE OL.OT_LINE_ID                       = W_OT_LINE_ID
    ;
  END DATA_DELETE_C;
  
-------------------------------------------------------------------------------
-- 연장근무 신청 라인 조회.
  PROCEDURE OT_LINE_RETURN_SELECT
            ( P_CURSOR1                               OUT TYPES.TCURSOR1
            , W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
						, W_WORK_DATE                             IN HRD_OT_LINE.WORK_DATE%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
			SELECT 'N' AS SELECT_YN
          , OL.REJECT_REMARK
          , OL.REQ_NUM
					, OL.PERSON_ID
					, PM.NAME
          , PM.PERSON_NUM
					, HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
					, HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
					, HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME		
					, OL.WORK_DATE
					, OL.DANGJIK_YN
					, OL.ALL_NIGHT_YN
					, OL.BEFORE_OT_START
					, OL.BEFORE_OT_END
					, OL.AFTER_OT_START
					, OL.AFTER_OT_END
					, OL.LUNCH_YN
					, OL.DINNER_YN
					, OL.MIDNIGHT_YN
					, OL.DESCRIPTION
					, OL.LINE_SEQ
					, HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', OH.APPROVE_STATUS, OH.SOB_ID, OH.ORG_ID) AS APPROVE_STATUS_NAME
					, HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE_NAME
					, HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.HOLY_TYPE, WC.SOB_ID, WC.ORG_ID) AS HOLY_NAME
					, OL.OT_LINE_ID
					, OL.OT_HEADER_ID
				FROM HRD_OT_LINE OL
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
																						 WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
																							 AND S_HL.PERSON_ID              = HL.PERSON_ID
																						 GROUP BY S_HL.PERSON_ID
																					 )
						) T1
					, HRD_OT_HEADER OH
					, HRD_WORK_CALENDAR WC
			 WHERE OL.PERSON_ID                               = PM.PERSON_ID
			   AND PM.PERSON_ID                               = T1.PERSON_ID
				 AND OL.REQ_NUM                                 = OH.REQ_NUM
				 AND OL.WORK_DATE                               = WC.WORK_DATE
				 AND OL.PERSON_ID                               = WC.PERSON_ID
				 AND OH.CORP_ID                                 = WC.CORP_ID
				 AND OH.SOB_ID                                  = WC.SOB_ID
				 AND OH.ORG_ID                                  = WC.ORG_ID				     
				 AND OH.OT_HEADER_ID                            = W_OT_HEADER_ID
			 ORDER BY PM.WORK_TYPE_ID, WC.HOLY_TYPE
       ;
  END OT_LINE_RETURN_SELECT;

-- 연장근무 반려 적용.
  PROCEDURE OT_LINE_RETURN_UPDATE
            ( W_OT_LINE_ID                            IN HRD_OT_LINE.OT_LINE_ID%TYPE
						, W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
            , P_REJECT_REMARK                         IN HRD_OT_LINE.REJECT_REMARK%TYPE
            , P_APPROVE_STATUS                        IN HRD_OT_LINE.APPROVE_STATUS%TYPE
						, P_CHECK_YN                              IN VARCHAR2
						, P_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, P_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
						, P_ORG_ID                                IN HRD_OT_HEADER.ORG_ID%TYPE   
						, P_USER_ID                               IN HRD_OT_HEADER.CREATED_BY%TYPE
            )
  AS
    V_APPROVE_STATUS                                  HRD_OT_HEADER.APPROVE_STATUS%TYPE := 'N';
    V_CAP_B                                           VARCHAR2(1) := 'N';
    V_CAP_C                                           VARCHAR2(1) := 'N';
  BEGIN
    BEGIN
      SELECT HRM_MANAGER_G.USER_CAP_F
                             (OH.CORP_ID 
                             , OH.REQ_DATE
                             , OH.REQ_DATE
                             , '20'
                             , P_CONNECT_PERSON_ID
                             , OH.SOB_ID
                             , OH.ORG_ID) AS CAP_C
           , HRD_DUTY_MANAGER_G.APPROVER_CAP_F
                             ( DM.DUTY_CONTROL_ID
                             , P_CONNECT_PERSON_ID
                             , P_SOB_ID
                             , P_ORG_ID) AS CAP_B
        INTO V_CAP_C, V_CAP_B
        FROM HRD_OT_HEADER OH
          , HRD_DUTY_MANAGER DM          
      WHERE OH.DUTY_MANAGER_ID    = DM.DUTY_MANAGER_ID
        AND OH.OT_HEADER_ID       = W_OT_HEADER_ID
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
    
    UPDATE HRD_OT_LINE OL
      SET OL.REJECT_REMARK                    = P_REJECT_REMARK
        , OL.REJECT_YN                        = 'Y'
        , OL.REJECT_DATE                      = GET_LOCAL_DATE(P_SOB_ID)
        , OL.REJECT_PERSON_ID                 = P_CONNECT_PERSON_ID
        , OL.APPROVE_STATUS                   = 'R'
        , OL.EMAIL_STATUS                     = 'RR'
    WHERE OL.OT_LINE_ID                       = W_OT_LINE_ID
    ;
	  
    /*-- 근무 카렌다 반영 START. --*/
    UPDATE HRD_WORK_CALENDAR WC
       SET WC.BEFORE_OT_START                 = NULL
         , WC.BEFORE_OT_END                   = NULL
         , WC.AFTER_OT_START                  = NULL
         , WC.AFTER_OT_END                    = NULL
         , WC.LUNCH_YN                        = 'N'
         , WC.DINNER_YN                       = 'N'
         , WC.MIDNIGHT_YN                     = 'N'
         , WC.DANGJIK_YN                      = 'N'
         , WC.ALL_NIGHT_YN                    = 'N'
    WHERE EXISTS ( SELECT 'X'
                   FROM HRD_OT_HEADER OH
                     , HRD_OT_LINE OL
                   WHERE OH.OT_HEADER_ID       = OL.OT_HEADER_ID
                     AND OH.CORP_ID            = WC.CORP_ID
                     AND OH.SOB_ID             = WC.SOB_ID
                     AND OH.ORG_ID             = WC.ORG_ID
                     AND OL.WORK_DATE          = WC.WORK_DATE
                     AND OL.PERSON_ID          = WC.PERSON_ID
                     AND OL.OT_LINE_ID         = W_OT_LINE_ID
                 )
    ;
		COMMIT;
  EXCEPTION WHEN ERRNUMS.Approval_Nothing THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Approval_Nothing_Code, ERRNUMS.Approval_Nothing_Desc);
  END OT_LINE_RETURN_UPDATE;
  
-------------------------------------------------------------------------------
-- LINE DATA COUNT.
  PROCEDURE DATA_LINE_COUNT
	          ( W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
						, O_RECORD_COUNT                          OUT NUMBER
						)
  AS
	  V_RECORD_COUNT                                    NUMBER := 0;
		
	BEGIN
	  BEGIN
		  SELECT COUNT(OL.PERSON_ID)
			  INTO V_RECORD_COUNT
			  FROM HRD_OT_LINE OL
			 WHERE OL.OT_HEADER_ID                         = W_OT_HEADER_ID
			;
		EXCEPTION WHEN OTHERS THEN
		  V_RECORD_COUNT := 0;
		END;
	  O_RECORD_COUNT := V_RECORD_COUNT;
		
	END;	

-- DATA SELECT OT TIME.
  PROCEDURE OT_STD_TIME_O
	          ( W_CORP_ID                               IN HRD_OT_HEADER.CORP_ID%TYPE
						, W_PERSON_ID                             IN HRD_OT_LINE.PERSON_ID%TYPE
						, W_WORK_DATE                             IN HRD_OT_LINE.WORK_DATE%TYPE
						, W_DANGJIK_YN                            IN HRD_OT_LINE.DANGJIK_YN%TYPE
						, W_ALL_NIGHT_YN                          IN HRD_OT_LINE.ALL_NIGHT_YN%TYPE
						, W_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
						, W_ORG_ID                                IN HRD_OT_HEADER.ORG_ID%TYPE
						, O_BEFORE_OT_START                       OUT HRD_OT_LINE.BEFORE_OT_START%TYPE
						, O_BEFORE_OT_END                         OUT HRD_OT_LINE.BEFORE_OT_END%TYPE
						, O_AFTER_OT_START                        OUT HRD_OT_LINE.AFTER_OT_START%TYPE
						, O_AFTER_OT_END                          OUT HRD_OT_LINE.AFTER_OT_END%TYPE
            )
  AS
	  V_BEFORE_OT_START                                 HRD_OT_LINE.BEFORE_OT_START%TYPE := NULL;
	  V_BEFORE_OT_END                                   HRD_OT_LINE.BEFORE_OT_END%TYPE := NULL;
	  V_AFTER_OT_START                                  HRD_OT_LINE.AFTER_OT_START%TYPE := NULL;
	  V_AFTER_OT_END                                    HRD_OT_LINE.AFTER_OT_END%TYPE := NULL;

	BEGIN
	  BEGIN
      SELECT  TO_DATE(TO_CHAR(W_WORK_DATE + B_OST.START_ADD_DAY, 'YYYY-MM-DD') ||  ' ' || B_OST.START_TIME, 'YYYY-MM-DD HH24:MI') AS BEFORE_OT_START
						, TO_DATE(TO_CHAR(W_WORK_DATE + B_OST.END_ADD_DAY, 'YYYY-MM-DD') ||  ' ' || B_OST.END_TIME, 'YYYY-MM-DD HH24:MI') AS BEFORE_OT_END
						, TO_DATE(TO_CHAR(W_WORK_DATE + A_OST.START_ADD_DAY, 'YYYY-MM-DD') ||  ' ' || A_OST.START_TIME, 'YYYY-MM-DD HH24:MI') AS AFTER_OT_START
						, TO_DATE(TO_CHAR(W_WORK_DATE + A_OST.END_ADD_DAY, 'YYYY-MM-DD') ||  ' ' || A_OST.END_TIME, 'YYYY-MM-DD HH24:MI') AS AFTER_OT_END
        INTO  V_BEFORE_OT_START, V_BEFORE_OT_END
				    , V_AFTER_OT_START, V_AFTER_OT_END
        FROM HRD_WORK_CALENDAR WC
					, HRM_OT_STD_TIME_V B_OST
					, HRM_OT_STD_TIME_V A_OST
       WHERE WC.ATTRIBUTE5                              = NVL(B_OST.WORK_TYPE, WC.ATTRIBUTE5)
				 AND WC.HOLY_TYPE                               = B_OST.HOLY_TYPE
				 AND 'B'                                        = B_OST.OT_STD_TYPE
         AND WC.SOB_ID                                  = B_OST.SOB_ID
         AND WC.ORG_ID                                  = B_OST.ORG_ID
				 AND WC.ATTRIBUTE5                              = NVL(A_OST.WORK_TYPE, WC.ATTRIBUTE5)
         AND DECODE(W_ALL_NIGHT_YN, 'Y', 'ALL_NIGHT', DECODE(W_DANGJIK_YN, 'Y', 'DANGJIK', WC.HOLY_TYPE)) = A_OST.HOLY_TYPE
         AND 'A'                                        = A_OST.OT_STD_TYPE
         AND WC.SOB_ID                                  = A_OST.SOB_ID
         AND WC.ORG_ID                                  = A_OST.ORG_ID
				 AND WC.WORK_DATE                               = W_WORK_DATE
         AND WC.PERSON_ID                               = W_PERSON_ID
         AND WC.WORK_CORP_ID                            = W_CORP_ID
         AND WC.SOB_ID                                  = W_SOB_ID
				 AND WC.ORG_ID                                  = W_ORG_ID
		     ;
    
		EXCEPTION WHEN OTHERS THEN
		  V_BEFORE_OT_START := NULL;
			V_BEFORE_OT_END := NULL;
		  V_AFTER_OT_START := NULL;
			V_AFTER_OT_END := NULL;			
		END;
	  
		O_BEFORE_OT_START := V_BEFORE_OT_START;
		O_BEFORE_OT_END   := V_BEFORE_OT_END;
	  O_AFTER_OT_START  := V_AFTER_OT_START;
		O_AFTER_OT_END    := V_AFTER_OT_END;

	END OT_STD_TIME_O;

END HRD_OT_LINE_G;
/
