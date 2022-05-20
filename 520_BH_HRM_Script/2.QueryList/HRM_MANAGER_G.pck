CREATE OR REPLACE PACKAGE HRM_MANAGER_G
AS

-- DATA SELECT.
  PROCEDURE DATA_SELECT
	          ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRM_MANAGER.CORP_ID%TYPE
            , W_STD_DATE                          IN HRM_MANAGER.EFFECTIVE_DATE_FR%TYPE
            , W_MODULE_CODE                       IN HRM_MANAGER.MODULE_CODE%TYPE
            , W_PERSON_ID                         IN HRM_MANAGER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRM_MANAGER.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_MANAGER.ORG_ID%TYPE
						);

-- DATA_INSERT.
  PROCEDURE DATA_INSERT
	          ( P_CORP_ID                           IN HRM_MANAGER.CORP_ID%TYPE
						, P_MODULE_CODE                       IN HRM_MANAGER.MODULE_CODE%TYPE
						, P_PERSON_ID                         IN HRM_MANAGER.PERSON_ID%TYPE
						, P_CAPACITY_LEVEL                    IN HRM_MANAGER.CAPACITY_LEVEL%TYPE
						, P_DESCRIPTION                       IN HRM_MANAGER.DESCRIPTION%TYPE
						, P_USABLE                            IN HRM_MANAGER.USABLE%TYPE
						, P_EFFECTIVE_DATE_FR                 IN HRM_MANAGER.EFFECTIVE_DATE_FR%TYPE
					  , P_EFFECTIVE_DATE_TO                 IN HRM_MANAGER.EFFECTIVE_DATE_TO%TYPE
						, P_SOB_ID                            IN HRM_MANAGER.SOB_ID%TYPE
						, P_ORG_ID                            IN HRM_MANAGER.ORG_ID%TYPE
						, P_USER_ID                           IN HRM_MANAGER.CREATED_BY%TYPE
						);

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE
	          ( W_CORP_ID                           IN HRM_MANAGER.CORP_ID%TYPE
						, W_MODULE_CODE                       IN HRM_MANAGER.MODULE_CODE%TYPE
						, W_PERSON_ID                         IN HRM_MANAGER.PERSON_ID%TYPE
						, P_CAPACITY_LEVEL                    IN HRM_MANAGER.CAPACITY_LEVEL%TYPE
						, P_DESCRIPTION                       IN HRM_MANAGER.DESCRIPTION%TYPE
						, P_USABLE                            IN HRM_MANAGER.USABLE%TYPE
						, P_EFFECTIVE_DATE_FR                 IN HRM_MANAGER.EFFECTIVE_DATE_FR%TYPE
					  , P_EFFECTIVE_DATE_TO                 IN HRM_MANAGER.EFFECTIVE_DATE_TO%TYPE
						, W_SOB_ID                            IN HRM_MANAGER.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_MANAGER.ORG_ID%TYPE
						, P_USER_ID                           IN HRM_MANAGER.CREATED_BY%TYPE
						);											
						

-- 해당 담당자에 대한 모듈 권한 리턴(CAPACITY).
  FUNCTION USER_CAP_F
	         ( W_CORP_ID                            IN HRM_MANAGER.CORP_ID%TYPE
				   , W_START_DATE                         IN HRM_MANAGER.EFFECTIVE_DATE_FR%TYPE
			     , W_END_DATE                           IN HRM_MANAGER.EFFECTIVE_DATE_TO%TYPE
				   , W_MODULE_CODE                        IN HRM_MANAGER.MODULE_CODE%TYPE
				   , W_PERSON_ID                          IN HRM_MANAGER.PERSON_ID%TYPE
			     , W_SOB_ID                             IN HRM_MANAGER.SOB_ID%TYPE
				   , W_ORG_ID                             IN HRM_MANAGER.ORG_ID%TYPE
			     ) RETURN VARCHAR2;
																		
-- 해당 담당자에 대한 모듈 권한 OUT VALUE 리턴(CAPACITY).
  PROCEDURE USER_CAP_R
	          ( W_CORP_ID                           IN HRM_MANAGER.CORP_ID%TYPE
						, W_START_DATE                        IN HRM_MANAGER.EFFECTIVE_DATE_FR%TYPE
						, W_END_DATE                          IN HRM_MANAGER.EFFECTIVE_DATE_TO%TYPE
						, W_MODULE_CODE                       IN HRM_MANAGER.MODULE_CODE%TYPE
						, W_PERSON_ID                         IN HRM_MANAGER.PERSON_ID%TYPE
						, W_SOB_ID                            IN HRM_MANAGER.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_MANAGER.ORG_ID%TYPE
						, O_CAP_LEVEL                         OUT HRM_MANAGER.CAPACITY_LEVEL%TYPE
						);						
	                                                
END HRM_MANAGER_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRM_MANAGER_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_MANAGER_G
/* Description  : 인사 시스템 모듈 담당자 관리 패키지
/*
/* Reference by : 인사 시스템 모듈 담당자 관리 .
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- DATA SELECT.
  PROCEDURE DATA_SELECT
	          ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_CORP_ID                           IN HRM_MANAGER.CORP_ID%TYPE
						, W_STD_DATE                          IN HRM_MANAGER.EFFECTIVE_DATE_FR%TYPE
						, W_MODULE_CODE                       IN HRM_MANAGER.MODULE_CODE%TYPE
						, W_PERSON_ID                         IN HRM_MANAGER.PERSON_ID%TYPE
						, W_SOB_ID                            IN HRM_MANAGER.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_MANAGER.ORG_ID%TYPE
						)
  AS
	BEGIN
	  -- 부서별 관리 기준 작성.
    OPEN P_CURSOR FOR
      SELECT HM.CORP_ID
					, HRM_CORP_MASTER_G.CORP_NAME_F(HM.CORP_ID) AS CORP_NAME
					, HM.MODULE_CODE
					, HRM_COMMON_G.CODE_NAME_F('HR_MODULE', HM.MODULE_CODE, HM.SOB_ID, HM.ORG_ID) AS MODULE_NAME
					, HM.PERSON_ID
					, HRM_PERSON_MASTER_G.NAME_F(HM.PERSON_ID) AS PERSON_NAME
					, HM.CAPACITY_LEVEL
					, HRM_COMMON_G.CODE_NAME_F('CAP_LEVEL', HM.CAPACITY_LEVEL, HM.SOB_ID, HM.ORG_ID) AS CAPACITY_LEVEL_NAME
					, HM.DESCRIPTION
					, HM.USABLE
					, HM.EFFECTIVE_DATE_FR
					, HM.EFFECTIVE_DATE_TO
			FROM HRM_MANAGER HM
			WHERE HM.CORP_ID                                  = W_CORP_ID
				AND HM.MODULE_CODE                              = NVL(W_MODULE_CODE, HM.MODULE_CODE)
				AND HM.PERSON_ID                                = NVL(W_PERSON_ID, HM.PERSON_ID)
				AND HM.EFFECTIVE_DATE_FR                        <= W_STD_DATE
				AND (HM.EFFECTIVE_DATE_TO IS NULL OR HM.EFFECTIVE_DATE_TO >= W_STD_DATE)
				AND HM.SOB_ID                                   = W_SOB_ID
				AND HM.ORG_ID                                   = W_ORG_ID
		ORDER BY HM.PERSON_ID, HM.CORP_ID, HM.MODULE_CODE, HM.CAPACITY_LEVEL
    ;

	END DATA_SELECT;
	
-- DATA_INSERT.
  PROCEDURE DATA_INSERT
	          ( P_CORP_ID                           IN HRM_MANAGER.CORP_ID%TYPE
						, P_MODULE_CODE                       IN HRM_MANAGER.MODULE_CODE%TYPE
						, P_PERSON_ID                         IN HRM_MANAGER.PERSON_ID%TYPE
						, P_CAPACITY_LEVEL                    IN HRM_MANAGER.CAPACITY_LEVEL%TYPE
						, P_DESCRIPTION                       IN HRM_MANAGER.DESCRIPTION%TYPE
						, P_USABLE                            IN HRM_MANAGER.USABLE%TYPE
						, P_EFFECTIVE_DATE_FR                 IN HRM_MANAGER.EFFECTIVE_DATE_FR%TYPE
					  , P_EFFECTIVE_DATE_TO                 IN HRM_MANAGER.EFFECTIVE_DATE_TO%TYPE
						, P_SOB_ID                            IN HRM_MANAGER.SOB_ID%TYPE
						, P_ORG_ID                            IN HRM_MANAGER.ORG_ID%TYPE
						, P_USER_ID                           IN HRM_MANAGER.CREATED_BY%TYPE
						)
  AS
	  V_SYSDATE                                     HRM_MANAGER.CREATION_DATE%TYPE;
		
	BEGIN
	  V_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
		
	  INSERT INTO HRM_MANAGER
		(CORP_ID, MODULE_CODE, PERSON_ID, CAPACITY_LEVEL
		, DESCRIPTION
		, USABLE, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO
		, SOB_ID, ORG_ID
		, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY)
		VALUES
		( P_CORP_ID, P_MODULE_CODE, P_PERSON_ID, P_CAPACITY_LEVEL
		, P_DESCRIPTION
		, P_USABLE, P_EFFECTIVE_DATE_FR, P_EFFECTIVE_DATE_TO
		, P_SOB_ID, P_ORG_ID
		, V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
		);
		COMMIT;					
	
	END DATA_INSERT;	

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE
	          ( W_CORP_ID                           IN HRM_MANAGER.CORP_ID%TYPE
						, W_MODULE_CODE                       IN HRM_MANAGER.MODULE_CODE%TYPE
						, W_PERSON_ID                         IN HRM_MANAGER.PERSON_ID%TYPE
						, P_CAPACITY_LEVEL                    IN HRM_MANAGER.CAPACITY_LEVEL%TYPE
						, P_DESCRIPTION                       IN HRM_MANAGER.DESCRIPTION%TYPE
						, P_USABLE                            IN HRM_MANAGER.USABLE%TYPE
						, P_EFFECTIVE_DATE_FR                 IN HRM_MANAGER.EFFECTIVE_DATE_FR%TYPE
					  , P_EFFECTIVE_DATE_TO                 IN HRM_MANAGER.EFFECTIVE_DATE_TO%TYPE
						, W_SOB_ID                            IN HRM_MANAGER.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_MANAGER.ORG_ID%TYPE
						, P_USER_ID                           IN HRM_MANAGER.CREATED_BY%TYPE
						)
  AS
	BEGIN
	  UPDATE HRM_MANAGER HM
		  SET HM.DESCRIPTION                          = P_DESCRIPTION
				, HM.USABLE                               = P_USABLE
				, HM.EFFECTIVE_DATE_FR                    = P_EFFECTIVE_DATE_FR
				, HM.EFFECTIVE_DATE_TO                    = P_EFFECTIVE_DATE_TO
				, HM.LAST_UPDATE_DATE                     = GET_LOCAL_DATE(HM.SOB_ID)
				, HM.LAST_UPDATED_BY                      = P_USER_ID
		WHERE HM.CORP_ID                              = W_CORP_ID
			AND HM.MODULE_CODE                          = W_MODULE_CODE
			AND HM.PERSON_ID                            = W_PERSON_ID
      AND HM.CAPACITY_LEVEL                       = P_CAPACITY_LEVEL
			AND HM.SOB_ID                               = W_SOB_ID
			AND HM.ORG_ID                               = W_ORG_ID
      ;
	  COMMIT;
				
	END DATA_UPDATE;
		
						
-- 해당 담당자에 대한 모듈 권한 리턴(CAPACITY).
  FUNCTION USER_CAP_F
	         ( W_CORP_ID                           IN HRM_MANAGER.CORP_ID%TYPE
					 , W_START_DATE                        IN HRM_MANAGER.EFFECTIVE_DATE_FR%TYPE
					 , W_END_DATE                          IN HRM_MANAGER.EFFECTIVE_DATE_TO%TYPE
					 , W_MODULE_CODE                       IN HRM_MANAGER.MODULE_CODE%TYPE
					 , W_PERSON_ID                         IN HRM_MANAGER.PERSON_ID%TYPE
					 , W_SOB_ID                            IN HRM_MANAGER.SOB_ID%TYPE
					 , W_ORG_ID                            IN HRM_MANAGER.ORG_ID%TYPE
					 ) RETURN VARCHAR2
  AS
	  V_CAP_LEVEL                                   HRM_MANAGER.CAPACITY_LEVEL%TYPE := NULL;
		
	BEGIN
	  BEGIN
	    SELECT HM.CAPACITY_LEVEL
			  INTO V_CAP_LEVEL
			FROM HRM_MANAGER HM
			WHERE HM.CORP_ID                                  = W_CORP_ID
				AND HM.MODULE_CODE                              = W_MODULE_CODE
				AND HM.PERSON_ID                                = W_PERSON_ID
				AND HM.USABLE                                   = 'Y'
				AND HM.EFFECTIVE_DATE_FR                        <= W_END_DATE
				AND (HM.EFFECTIVE_DATE_TO IS NULL OR HM.EFFECTIVE_DATE_TO >= W_START_DATE)
				AND HM.SOB_ID                                   = W_SOB_ID
				AND HM.ORG_ID                                   = W_ORG_ID
      ;
	  EXCEPTION WHEN OTHERS THEN
		  V_CAP_LEVEL := 'N';
		END;
		RETURN V_CAP_LEVEL;
		
	END USER_CAP_F;

-- 해당 담당자에 대한 모듈 권한 OUT VALUE 리턴(CAPACITY).
  PROCEDURE USER_CAP_R
	          ( W_CORP_ID                           IN HRM_MANAGER.CORP_ID%TYPE
						, W_START_DATE                        IN HRM_MANAGER.EFFECTIVE_DATE_FR%TYPE
						, W_END_DATE                          IN HRM_MANAGER.EFFECTIVE_DATE_TO%TYPE
						, W_MODULE_CODE                       IN HRM_MANAGER.MODULE_CODE%TYPE
						, W_PERSON_ID                         IN HRM_MANAGER.PERSON_ID%TYPE
						, W_SOB_ID                            IN HRM_MANAGER.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_MANAGER.ORG_ID%TYPE
						, O_CAP_LEVEL                         OUT HRM_MANAGER.CAPACITY_LEVEL%TYPE
						)
  AS
	  V_CAP_LEVEL                                   HRM_MANAGER.CAPACITY_LEVEL%TYPE := NULL;
		
	BEGIN
	  BEGIN
	    SELECT HM.CAPACITY_LEVEL
			  INTO V_CAP_LEVEL
			FROM HRM_MANAGER HM
			WHERE HM.CORP_ID                                  = W_CORP_ID
				AND HM.MODULE_CODE                              = W_MODULE_CODE
				AND HM.PERSON_ID                                = W_PERSON_ID
				AND HM.USABLE                                   = 'Y'
				AND HM.EFFECTIVE_DATE_FR                        <= W_END_DATE
				AND (HM.EFFECTIVE_DATE_TO IS NULL OR HM.EFFECTIVE_DATE_TO >= W_START_DATE)
				AND HM.SOB_ID                                   = W_SOB_ID
				AND HM.ORG_ID                                   = W_ORG_ID
      ;
	  EXCEPTION WHEN OTHERS THEN
		  V_CAP_LEVEL := 'N';
		END;

		O_CAP_LEVEL := V_CAP_LEVEL;
	
	END USER_CAP_R;
		
END HRM_MANAGER_G;
/
