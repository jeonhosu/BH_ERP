CREATE OR REPLACE PACKAGE HRM_DEPT_MAPPING_G
AS
-- 부서마스터 조회.
  PROCEDURE DATA_SELECT
            ( P_CURSOR             OUT TYPES.TCURSOR
						, W_CORP_ID            IN HRM_DEPT_MAPPING.CORP_ID%TYPE
            , W_MODULE_TYPE        IN HRM_DEPT_MAPPING.MODULE_TYPE%TYPE
						, W_HR_DEPT_ID         IN HRM_DEPT_MAPPING.HR_DEPT_ID%TYPE
            , W_M_DEPT_ID          IN HRM_DEPT_MAPPING.M_DEPT_ID%TYPE
            , W_SOB_ID             IN HRM_DEPT_MAPPING.SOB_ID%TYPE
						, W_ORG_ID             IN HRM_DEPT_MAPPING.ORG_ID%TYPE
            );

-- DEPARTMENT INSERT.
  PROCEDURE DATA_INSERT
            ( P_MODULE_TYPE       IN HRM_DEPT_MAPPING.MODULE_TYPE%TYPE
            , P_HR_DEPT_ID        IN HRM_DEPT_MAPPING.HR_DEPT_ID%TYPE
            , P_CORP_ID           IN HRM_DEPT_MAPPING.CORP_ID%TYPE
            , P_M_DEPT_ID         IN HRM_DEPT_MAPPING.M_DEPT_ID%TYPE
            , P_DESCRIPTION       IN HRM_DEPT_MAPPING.DESCRIPTION%TYPE
            , P_ENABLED_FLAG      IN HRM_DEPT_MAPPING.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN HRM_DEPT_MAPPING.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN HRM_DEPT_MAPPING.EFFECTIVE_DATE_TO%TYPE
            , P_SOB_ID            IN HRM_DEPT_MAPPING.SOB_ID%TYPE
            , P_ORG_ID            IN HRM_DEPT_MAPPING.ORG_ID%TYPE
            , P_USER_ID           IN HRM_DEPT_MAPPING.CREATED_BY%TYPE
						);

-- DEPARTMENT UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_MODULE_TYPE       IN HRM_DEPT_MAPPING.MODULE_TYPE%TYPE
            , W_HR_DEPT_ID        IN HRM_DEPT_MAPPING.HR_DEPT_ID%TYPE
            , W_CORP_ID           IN HRM_DEPT_MAPPING.CORP_ID%TYPE
            , W_SOB_ID            IN HRM_DEPT_MAPPING.SOB_ID%TYPE
            , W_ORG_ID            IN HRM_DEPT_MAPPING.ORG_ID%TYPE
            , P_M_DEPT_ID         IN HRM_DEPT_MAPPING.M_DEPT_ID%TYPE
            , P_DESCRIPTION       IN HRM_DEPT_MAPPING.DESCRIPTION%TYPE
            , P_ENABLED_FLAG      IN HRM_DEPT_MAPPING.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN HRM_DEPT_MAPPING.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN HRM_DEPT_MAPPING.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN HRM_DEPT_MAPPING.CREATED_BY%TYPE
            );

---------------------------------------------------------------------------------------------------
-- LOOKUP DEPT - 맵핑 부서코드  조회.
  PROCEDURE LU_M_MAPPING_DEPT
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , W_MODULE_TYPE       IN HRM_DEPT_MAPPING.MODULE_TYPE%TYPE
            , W_SOB_ID            IN HRM_DEPT_MAPPING.SOB_ID%TYPE
            , W_ORG_ID            IN HRM_DEPT_MAPPING.ORG_ID%TYPE
            , W_ENABLED_YN        IN HRM_DEPT_MAPPING.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

END HRM_DEPT_MAPPING_G;
/
CREATE OR REPLACE PACKAGE BODY HRM_DEPT_MAPPING_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_DEPT_MAPPING_G
/* Description  : 부서마스터 맵핑 관리 패키지
/*
/* Reference by : 부서정보 관리.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 부서마스터 맵핑 조회.
  PROCEDURE DATA_SELECT
	          ( P_CURSOR             OUT TYPES.TCURSOR
						, W_CORP_ID            IN HRM_DEPT_MAPPING.CORP_ID%TYPE
            , W_MODULE_TYPE        IN HRM_DEPT_MAPPING.MODULE_TYPE%TYPE
						, W_HR_DEPT_ID         IN HRM_DEPT_MAPPING.HR_DEPT_ID%TYPE
            , W_M_DEPT_ID          IN HRM_DEPT_MAPPING.M_DEPT_ID%TYPE
						, W_SOB_ID             IN HRM_DEPT_MAPPING.SOB_ID%TYPE
						, W_ORG_ID             IN HRM_DEPT_MAPPING.ORG_ID%TYPE
						)
  AS
  BEGIN
		OPEN P_CURSOR FOR
      SELECT DM.MODULE_TYPE
           , HRM_COMMON_G.CODE_NAME_F('SYS_MODULE', DM.MODULE_TYPE, DM.SOB_ID, DM.ORG_ID) AS MODULE_TYPE_NAME
           , DM.HR_DEPT_ID
           , HRM_DEPT_MASTER_G.DEPT_NAME_F(DM.HR_DEPT_ID) AS HR_DEPT_NAME
           , DM.CORP_ID
           , DM.M_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(DM.M_DEPT_ID) AS M_DEPT_NAME
           , DM.DESCRIPTION
           , DM.ENABLED_FLAG
           , DM.EFFECTIVE_DATE_FR
           , DM.EFFECTIVE_DATE_TO
        FROM HRM_DEPT_MAPPING DM
       WHERE DM.MODULE_TYPE             = W_MODULE_TYPE
         AND DM.CORP_ID                 = W_CORP_ID
         AND DM.HR_DEPT_ID              = NVL(W_HR_DEPT_ID, DM.HR_DEPT_ID)
         AND DM.M_DEPT_ID               = NVL(W_M_DEPT_ID, DM.M_DEPT_ID)
         AND DM.SOB_ID                  = W_SOB_ID
         AND DM.ORG_ID                  = W_ORG_ID
			;

  END DATA_SELECT;

-- DEPARTMENT INSERT.
  PROCEDURE DATA_INSERT
	          ( P_MODULE_TYPE       IN HRM_DEPT_MAPPING.MODULE_TYPE%TYPE
            , P_HR_DEPT_ID        IN HRM_DEPT_MAPPING.HR_DEPT_ID%TYPE
            , P_CORP_ID           IN HRM_DEPT_MAPPING.CORP_ID%TYPE
            , P_M_DEPT_ID         IN HRM_DEPT_MAPPING.M_DEPT_ID%TYPE
            , P_DESCRIPTION       IN HRM_DEPT_MAPPING.DESCRIPTION%TYPE
            , P_ENABLED_FLAG      IN HRM_DEPT_MAPPING.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN HRM_DEPT_MAPPING.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN HRM_DEPT_MAPPING.EFFECTIVE_DATE_TO%TYPE
            , P_SOB_ID            IN HRM_DEPT_MAPPING.SOB_ID%TYPE
            , P_ORG_ID            IN HRM_DEPT_MAPPING.ORG_ID%TYPE
            , P_USER_ID           IN HRM_DEPT_MAPPING.CREATED_BY%TYPE
						)
  AS
	  V_SYSDATE                      DATE;
    V_RECORD_COUNT                 NUMBER := 0;
    
  BEGIN
	  V_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT := 0;
    
    BEGIN
      SELECT COUNT(DM.MODULE_TYPE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRM_DEPT_MAPPING DM
       WHERE DM.MODULE_TYPE      = P_MODULE_TYPE
        AND DM.HR_DEPT_ID        = P_HR_DEPT_ID
        AND DM.M_DEPT_ID         = P_M_DEPT_ID
        AND DM.CORP_ID           = P_CORP_ID
        AND DM.SOB_ID            = P_SOB_ID
        AND DM.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    
    IF V_RECORD_COUNT > 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;
    
    INSERT INTO HRM_DEPT_MAPPING
    ( MODULE_TYPE
    , HR_DEPT_ID 
    , CORP_ID 
    , M_DEPT_ID 
    , DESCRIPTION 
    , ENABLED_FLAG 
    , EFFECTIVE_DATE_FR 
    , EFFECTIVE_DATE_TO 
    , SOB_ID 
    , ORG_ID 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_MODULE_TYPE
    , P_HR_DEPT_ID
    , P_CORP_ID
    , P_M_DEPT_ID
    , P_DESCRIPTION
    , P_ENABLED_FLAG
    , P_EFFECTIVE_DATE_FR
    , P_EFFECTIVE_DATE_TO
    , P_SOB_ID
    , P_ORG_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  
  EXCEPTION 
    WHEN ERRNUMS.Exist_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END DATA_INSERT;

-- DEPARTMENT UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_MODULE_TYPE       IN HRM_DEPT_MAPPING.MODULE_TYPE%TYPE
            , W_HR_DEPT_ID        IN HRM_DEPT_MAPPING.HR_DEPT_ID%TYPE
            , W_CORP_ID           IN HRM_DEPT_MAPPING.CORP_ID%TYPE
            , W_SOB_ID            IN HRM_DEPT_MAPPING.SOB_ID%TYPE
            , W_ORG_ID            IN HRM_DEPT_MAPPING.ORG_ID%TYPE
            , P_M_DEPT_ID         IN HRM_DEPT_MAPPING.M_DEPT_ID%TYPE
            , P_DESCRIPTION       IN HRM_DEPT_MAPPING.DESCRIPTION%TYPE
            , P_ENABLED_FLAG      IN HRM_DEPT_MAPPING.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN HRM_DEPT_MAPPING.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN HRM_DEPT_MAPPING.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN HRM_DEPT_MAPPING.CREATED_BY%TYPE
            )
  AS
  BEGIN
    UPDATE HRM_DEPT_MAPPING
      SET M_DEPT_ID         = P_M_DEPT_ID
        , DESCRIPTION       = P_DESCRIPTION
        , ENABLED_FLAG      = P_ENABLED_FLAG
        , EFFECTIVE_DATE_FR = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO = P_EFFECTIVE_DATE_TO
        , LAST_UPDATE_DATE  = GET_LOCAL_DATE(SOB_ID)
        , LAST_UPDATED_BY   = P_USER_ID
    WHERE MODULE_TYPE       = W_MODULE_TYPE
      AND HR_DEPT_ID        = W_HR_DEPT_ID
      AND CORP_ID           = W_CORP_ID
      AND SOB_ID            = W_SOB_ID
      AND ORG_ID            = W_ORG_ID
    ;

  END DATA_UPDATE;

---------------------------------------------------------------------------------------------------
-- LOOKUP DEPT - 맵핑 부서코드  조회.
  PROCEDURE LU_M_MAPPING_DEPT
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , W_MODULE_TYPE       IN HRM_DEPT_MAPPING.MODULE_TYPE%TYPE
            , W_SOB_ID            IN HRM_DEPT_MAPPING.SOB_ID%TYPE
            , W_ORG_ID            IN HRM_DEPT_MAPPING.ORG_ID%TYPE
            , W_ENABLED_YN        IN HRM_DEPT_MAPPING.ENABLED_FLAG%TYPE DEFAULT 'Y'
            )
  AS
    N_DEPT_LEVEL                  HRM_DEPT_MASTER.DEPT_LEVEL%TYPE := 1;
    V_STD_DATE                    HRM_DEPT_MASTER.START_DATE%TYPE;

  BEGIN    
    -- 유효일자 체크 여부.
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
    ELSE
      V_STD_DATE := NULL;
    END IF;

    IF W_MODULE_TYPE = 'FCM' THEN
    -- 회계.    
      BEGIN
        SELECT NVL(AB.DEPT_LEVEL, 1) AS DEPT_LEVEL
          INTO N_DEPT_LEVEL
          FROM FI_ACCOUNT_BOOK AB
         WHERE AB.SOB_ID          = W_SOB_ID
           AND AB.OPERATING_FLAG  = 'Y'
        ;
      EXCEPTION WHEN OTHERS THEN
        N_DEPT_LEVEL := 1;
      END;

      OPEN P_CURSOR3 FOR
        SELECT DM.DEPT_NAME
            , DM.DEPT_CODE
            , DM.DEPT_ID
        FROM FI_DEPT_MASTER DM
        WHERE DM.DEPT_LEVEL            = N_DEPT_LEVEL
          AND DM.SOB_ID                = W_SOB_ID
          AND DM.ENABLED_FLAG          = DECODE(W_ENABLED_YN, 'Y', 'Y', DM.ENABLED_FLAG)
          AND DM.EFFECTIVE_DATE_FR            <= NVL(V_STD_DATE, DM.EFFECTIVE_DATE_FR)
          AND (DM.EFFECTIVE_DATE_TO IS NULL OR DM.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, DM.EFFECTIVE_DATE_TO))
        ;
    ELSE 
      OPEN P_CURSOR3 FOR
        SELECT NULL AS DEPT_NAME
            , NULL AS DEPT_CODE
            , NULL AS DEPT_ID
        FROM DUAL;        
    END IF;
    
  END LU_M_MAPPING_DEPT;

END HRM_DEPT_MAPPING_G;
/
