CREATE OR REPLACE PACKAGE HRF_FOOD_MISTAKE_CHECK_G
AS

-- FOOD MISTAKE CHECK PERSON.
  PROCEDURE DATA_SELECT_PERSON
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_START_DATE                        IN HRF_FOOD_INTERFACE.FOOD_DATE%TYPE
            , W_END_DATE                          IN HRF_FOOD_INTERFACE.FOOD_DATE%TYPE
            , W_DEVICE_ID                         IN HRF_FOOD_INTERFACE.DEVICE_ID%TYPE
						, W_PERSON_ID                         IN HRF_FOOD_INTERFACE.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_MANAGER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_MANAGER.ORG_ID%TYPE
            , W_USER_ID                           IN HRF_FOOD_INTERFACE.CREATED_BY%TYPE
            );

-- FOOD MISTAKE CHECK VISITOR.
  PROCEDURE DATA_SELECT_VISITOR
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_START_DATE                        IN HRF_FOOD_INTERFACE.FOOD_DATE%TYPE
            , W_END_DATE                          IN HRF_FOOD_INTERFACE.FOOD_DATE%TYPE
            , W_DEVICE_ID                         IN HRF_FOOD_INTERFACE.DEVICE_ID%TYPE
						, W_VISITOR_ID                        IN HRF_FOOD_INTERFACE.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_MANAGER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_MANAGER.ORG_ID%TYPE
            , W_USER_ID                           IN HRF_FOOD_INTERFACE.CREATED_BY%TYPE
            );						

-- FOOD MISTAKE CHECK PERSON INSERT.
  PROCEDURE DATA_INSERT_PERSON
            ( P_DEVICE_ID                         IN HRF_FOOD_INTERFACE.DEVICE_ID%TYPE
            , P_PERSON_ID                         IN HRF_FOOD_INTERFACE.PERSON_ID%TYPE
            , P_FOOD_FLAG                         IN HRF_FOOD_INTERFACE.FOOD_FLAG%TYPE
						, P_FOOD_DATE                         IN HRF_FOOD_INTERFACE.FOOD_DATE%TYPE
            , P_USER_ID                           IN HRF_FOOD_PERSON.CREATED_BY%TYPE
						, W_SOB_ID                            IN HRF_FOOD_MANAGER.SOB_ID%TYPE
						, O_FOOD_DATETIME                     OUT HRF_FOOD_INTERFACE.FOOD_DATETIME%TYPE
            );
						
-- FOOD MISTAKE CHECK VISITOR INSERT.
  PROCEDURE DATA_INSERT_VISITOR
            ( P_DEVICE_ID                         IN HRF_FOOD_INTERFACE.DEVICE_ID%TYPE
            , P_VISITOR_ID                        IN HRF_FOOD_INTERFACE.PERSON_ID%TYPE
            , P_FOOD_FLAG                         IN HRF_FOOD_INTERFACE.FOOD_FLAG%TYPE
						, P_FOOD_DATE                         IN HRF_FOOD_INTERFACE.FOOD_DATE%TYPE
            , P_USER_ID                           IN HRF_FOOD_PERSON.CREATED_BY%TYPE
						, W_SOB_ID                            IN HRF_FOOD_MANAGER.SOB_ID%TYPE
						, O_FOOD_DATETIME                     OUT HRF_FOOD_INTERFACE.FOOD_DATETIME%TYPE
            );						

END HRF_FOOD_MISTAKE_CHECK_G;
/
CREATE OR REPLACE PACKAGE BODY HRF_FOOD_MISTAKE_CHECK_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRF_FOOD_MISTAKE_CHECK_G
/* DESCRIPTION  : 식사 미체크자 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- FOOD MISTAKE CHECK PERSON.
  PROCEDURE DATA_SELECT_PERSON
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_START_DATE                        IN HRF_FOOD_INTERFACE.FOOD_DATE%TYPE
            , W_END_DATE                          IN HRF_FOOD_INTERFACE.FOOD_DATE%TYPE
            , W_DEVICE_ID                         IN HRF_FOOD_INTERFACE.DEVICE_ID%TYPE
						, W_PERSON_ID                         IN HRF_FOOD_INTERFACE.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_MANAGER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_MANAGER.ORG_ID%TYPE
            , W_USER_ID                           IN HRF_FOOD_INTERFACE.CREATED_BY%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT FI.DEVICE_ID
					 , HRM_COMMON_G.ID_NAME_F(FI.DEVICE_ID) AS DEVICE_NAME
					 , FI.PERSON_ID
					 , PM.DISPLAY_NAME
					 , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID) AS CORP_NAME
					 , PM.DEPT_NAME
					 , PM.POST_NAME
					 , FI.FOOD_FLAG
					 , HRM_COMMON_G.CODE_NAME_F('FOOD_FLAG', FI.FOOD_FLAG, W_SOB_ID, W_ORG_ID) AS FOOD_NAME
					 , FI.FOOD_DATE
					 , FI.FOOD_DATETIME		 
				FROM HRF_FOOD_INTERFACE FI
				  , HRF_FOOD_MANAGER FM
					, HRM_PERSON_MASTER_V1 PM
			WHERE FI.DEVICE_ID              = FM.DEVICE_ID
			  AND FI.PERSON_ID              = PM.PERSON_ID
			  AND FM.USER_ID                = W_USER_ID
				AND FI.FOOD_DATE              BETWEEN W_START_DATE AND W_END_DATE
				AND FI.CREATED_FLAG           = 'M'
				AND FI.DEVICE_ID              = NVL(W_DEVICE_ID, FI.DEVICE_ID)
				AND FI.PERSON_ID              = NVL(W_PERSON_ID, FI.PERSON_ID)
				AND FI.CARD_TYPE              = 'P'
      ;
  END DATA_SELECT_PERSON;
	
-- FOOD MISTAKE CHECK VISITOR.
  PROCEDURE DATA_SELECT_VISITOR
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_START_DATE                        IN HRF_FOOD_INTERFACE.FOOD_DATE%TYPE
            , W_END_DATE                          IN HRF_FOOD_INTERFACE.FOOD_DATE%TYPE
            , W_DEVICE_ID                         IN HRF_FOOD_INTERFACE.DEVICE_ID%TYPE
						, W_VISITOR_ID                        IN HRF_FOOD_INTERFACE.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_MANAGER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_MANAGER.ORG_ID%TYPE
            , W_USER_ID                           IN HRF_FOOD_INTERFACE.CREATED_BY%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT FI.DEVICE_ID
					 , HRM_COMMON_G.ID_NAME_F(FI.DEVICE_ID) AS DEVICE_NAME
					 , FI.PERSON_ID
					 , VC.VISITOR_NAME
					 , HRM_CORP_MASTER_G.CORP_NAME_F(VC.CORP_ID) AS CORP_NAME
					 , FI.FOOD_FLAG
					 , HRM_COMMON_G.CODE_NAME_F('FOOD_FLAG', FI.FOOD_FLAG, W_SOB_ID, W_ORG_ID) AS FOOD_NAME
					 , FI.FOOD_DATE
					 , FI.FOOD_DATETIME		 
				FROM HRF_FOOD_INTERFACE FI
				  , HRF_FOOD_MANAGER FM
					, HRM_VISITOR_CARD VC
			WHERE FI.DEVICE_ID              = FM.DEVICE_ID
			  AND FI.PERSON_ID              = VC.VISITOR_CARD_ID
			  AND FM.USER_ID                = W_USER_ID
				AND FI.FOOD_DATE              BETWEEN W_START_DATE AND W_END_DATE
				AND FI.CREATED_FLAG           = 'M'
				AND FI.DEVICE_ID              = NVL(W_DEVICE_ID, FI.DEVICE_ID)
				AND FI.PERSON_ID              = NVL(W_VISITOR_ID, FI.PERSON_ID)
				AND FI.CARD_TYPE              = 'V'
      ;
  END DATA_SELECT_VISITOR;	

-- FOOD MISTAKE CHECK PERSON INSERT.
  PROCEDURE DATA_INSERT_PERSON
            ( P_DEVICE_ID                         IN HRF_FOOD_INTERFACE.DEVICE_ID%TYPE
            , P_PERSON_ID                         IN HRF_FOOD_INTERFACE.PERSON_ID%TYPE
            , P_FOOD_FLAG                         IN HRF_FOOD_INTERFACE.FOOD_FLAG%TYPE
						, P_FOOD_DATE                         IN HRF_FOOD_INTERFACE.FOOD_DATE%TYPE
            , P_USER_ID                           IN HRF_FOOD_PERSON.CREATED_BY%TYPE
						, W_SOB_ID                            IN HRF_FOOD_MANAGER.SOB_ID%TYPE
						, O_FOOD_DATETIME                     OUT HRF_FOOD_INTERFACE.FOOD_DATETIME%TYPE						
            )
  AS
	  V_SYSDATE                                     HRF_FOOD_INTERFACE.CREATION_DATE%TYPE;
	  V_FOOD_DATETIME                               HRF_FOOD_INTERFACE.FOOD_DATETIME%TYPE;
    
		V_START_DATETIME                              HRF_FOOD_INTERFACE.FOOD_DATETIME%TYPE;
		V_END_DATETIME                                HRF_FOOD_INTERFACE.FOOD_DATETIME%TYPE;
		
		V_RANDOM_VALUE                                NUMBER := 0;
		V_MAX_VALUE                                   NUMBER := 0;
		
  BEGIN
	  V_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
		-- 랜덤하게 식사시간 채번.
		BEGIN
		  SELECT TO_DATE(TO_CHAR(P_FOOD_DATE + FT.START_ADD_DAY, 'YYYY-MM-DD') || ' ' || FT.START_TIME, 'YYYY-MM-DD HH24:MI:SS') AS START_DATETIME
			     , TO_DATE(TO_CHAR(P_FOOD_DATE + FT.END_ADD_DAY, 'YYYY-MM-DD') || ' ' || FT.END_TIME, 'YYYY-MM-DD HH24:MI:SS') AS END_DATETIME
				INTO V_START_DATETIME, V_END_DATETIME
        FROM HRM_PERSON_MASTER PM
          , HRM_JOB_CATEGORY_CODE_V JC
          , HRM_FOOD_TIME_V FT
       WHERE PM.JOB_CATEGORY_ID    = JC.JOB_CATEGORY_ID
         AND JC.JOB_CATEGORY_CODE  = FT.JOB_CATEGORY_CODE
         AND PM.PERSON_ID          = P_PERSON_ID
         AND FT.FOOD_TYPE          = P_FOOD_FLAG
       ;
			 
		  SELECT (V_END_DATETIME - V_START_DATETIME) / (1 / 24 / 60) AS MAX_VALUE
			  INTO V_MAX_VALUE
			  FROM DUAL;
		EXCEPTION WHEN OTHERS THEN
		  RAISE ERRNUMS.Food_Time_Error;
		END;
		
		V_RANDOM_VALUE := DBMS_RANDOM.VALUE(1, V_MAX_VALUE);		
		V_FOOD_DATETIME := V_START_DATETIME + (V_RANDOM_VALUE * ( 1 / 24/ 60));
		
    INSERT INTO HRF_FOOD_INTERFACE
		( DEVICE_ID, PERSON_ID
		, FOOD_FLAG, FOOD_DATETIME, FOOD_DATE, FOOD_TIME
		, CREATED_FLAG
		, CARD_NUM, CARD_TYPE
		, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY		
		) VALUES
		( P_DEVICE_ID, P_PERSON_ID
		, P_FOOD_FLAG, V_FOOD_DATETIME, TRUNC(V_FOOD_DATETIME), TO_CHAR(V_FOOD_DATETIME, 'HH24:MI')
		, 'M'
		, NULL, 'P'
		, V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID		
		);
		COMMIT;
    O_FOOD_DATETIME := V_FOOD_DATETIME;
	
	EXCEPTION 
	  WHEN ERRNUMS.Food_Time_Error THEN
		RAISE_APPLICATION_ERROR(ERRNUMS.Food_Time_Error_Code, ERRNUMS.Food_Time_Error_Desc);	
  END DATA_INSERT_PERSON;
	
-- FOOD MISTAKE CHECK VISITOR INSERT.
  PROCEDURE DATA_INSERT_VISITOR
            ( P_DEVICE_ID                         IN HRF_FOOD_INTERFACE.DEVICE_ID%TYPE
            , P_VISITOR_ID                        IN HRF_FOOD_INTERFACE.PERSON_ID%TYPE
            , P_FOOD_FLAG                         IN HRF_FOOD_INTERFACE.FOOD_FLAG%TYPE
						, P_FOOD_DATE                         IN HRF_FOOD_INTERFACE.FOOD_DATE%TYPE
            , P_USER_ID                           IN HRF_FOOD_PERSON.CREATED_BY%TYPE
						, W_SOB_ID                            IN HRF_FOOD_MANAGER.SOB_ID%TYPE
						, O_FOOD_DATETIME                     OUT HRF_FOOD_INTERFACE.FOOD_DATETIME%TYPE
            )
  AS
	  V_SYSDATE                                     HRF_FOOD_INTERFACE.CREATION_DATE%TYPE;
	  V_FOOD_DATETIME                               HRF_FOOD_INTERFACE.FOOD_DATETIME%TYPE;
    
		V_START_DATETIME                              HRF_FOOD_INTERFACE.FOOD_DATETIME%TYPE;
		V_END_DATETIME                                HRF_FOOD_INTERFACE.FOOD_DATETIME%TYPE;
		
		V_RANDOM_VALUE                                NUMBER := 0;
		V_MAX_VALUE                                   NUMBER := 0;
		
  BEGIN
	  V_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
		-- 랜덤하게 식사시간 채번.
		BEGIN
		  SELECT TO_DATE(TO_CHAR(P_FOOD_DATE + FT.START_ADD_DAY, 'YYYY-MM-DD') || ' ' || FT.START_TIME, 'YYYY-MM-DD HH24:MI:SS') AS START_DATETIME
			     , TO_DATE(TO_CHAR(P_FOOD_DATE + FT.END_ADD_DAY, 'YYYY-MM-DD') || ' ' || FT.END_TIME, 'YYYY-MM-DD HH24:MI:SS') AS END_DATETIME
				INTO V_START_DATETIME, V_END_DATETIME
        FROM HRM_FOOD_TIME_V FT
       WHERE FT.JOB_CATEGORY_CODE  = '20'
         AND FT.FOOD_TYPE          = P_FOOD_FLAG
       ;
			 
		  SELECT (V_END_DATETIME - V_START_DATETIME) / (1 / 24 / 60) AS MAX_VALUE
			  INTO V_MAX_VALUE
			  FROM DUAL;
		EXCEPTION WHEN OTHERS THEN
		 RAISE ERRNUMS.Food_Time_Error;
		END;
		
		V_RANDOM_VALUE := DBMS_RANDOM.VALUE(1, V_MAX_VALUE);		
		V_FOOD_DATETIME := V_START_DATETIME + (V_RANDOM_VALUE * ( 1 / 24/ 60));
		
    INSERT INTO HRF_FOOD_INTERFACE
		( DEVICE_ID, PERSON_ID
		, FOOD_FLAG, FOOD_DATETIME, FOOD_DATE, FOOD_TIME
		, CREATED_FLAG
		, CARD_NUM, CARD_TYPE
		, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY		
		) VALUES
		( P_DEVICE_ID, P_VISITOR_ID
		, P_FOOD_FLAG, V_FOOD_DATETIME, TRUNC(V_FOOD_DATETIME), TO_CHAR(V_FOOD_DATETIME, 'HH24:MI')
		, 'M'
		, NULL, 'V'
		, V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID		
		);
		COMMIT;
    O_FOOD_DATETIME := V_FOOD_DATETIME;
	
	EXCEPTION 
	  WHEN ERRNUMS.Food_Time_Error THEN
		RAISE_APPLICATION_ERROR(ERRNUMS.Food_Time_Error_Code, ERRNUMS.Food_Time_Error_Desc);
	END DATA_INSERT_VISITOR;	

END HRF_FOOD_MISTAKE_CHECK_G;
/
