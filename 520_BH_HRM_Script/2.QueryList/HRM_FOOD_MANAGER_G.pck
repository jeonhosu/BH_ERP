CREATE OR REPLACE PACKAGE HRM_FOOD_MANAGER_G
AS

-- DATA SELECT.
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_STD_DATE                          IN HRF_FOOD_MANAGER.EFFECTIVE_DATE_FR%TYPE
            , W_DEVICE_ID                         IN HRF_FOOD_MANAGER.DEVICE_ID%TYPE
            , W_USER_ID                           IN HRF_FOOD_MANAGER.USER_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_MANAGER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_MANAGER.ORG_ID%TYPE
            );

-- DATA_INSERT.
  PROCEDURE DATA_INSERT
            ( P_DEVICE_ID                         IN HRF_FOOD_MANAGER.DEVICE_ID%TYPE
            , P_USER_ID                           IN HRF_FOOD_MANAGER.USER_ID%TYPE
						, P_DESCRIPTION                       IN HRF_FOOD_MANAGER.DESCRIPTION%TYPE
            , P_ENABLED_FLAG                      IN HRF_FOOD_MANAGER.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR                 IN HRF_FOOD_MANAGER.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO                 IN HRF_FOOD_MANAGER.EFFECTIVE_DATE_TO%TYPE
            , P_SOB_ID                            IN HRF_FOOD_MANAGER.SOB_ID%TYPE
            , P_ORG_ID                            IN HRF_FOOD_MANAGER.ORG_ID%TYPE
            , P_CONNECT_USER_ID                   IN HRF_FOOD_MANAGER.CREATED_BY%TYPE
            );

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_DEVICE_ID                         IN HRF_FOOD_MANAGER.DEVICE_ID%TYPE
            , W_USER_ID                           IN HRF_FOOD_MANAGER.USER_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_MANAGER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_MANAGER.ORG_ID%TYPE
						, P_DESCRIPTION                       IN HRF_FOOD_MANAGER.DESCRIPTION%TYPE
            , P_ENABLED_FLAG                      IN HRF_FOOD_MANAGER.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR                 IN HRF_FOOD_MANAGER.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO                 IN HRF_FOOD_MANAGER.EFFECTIVE_DATE_TO%TYPE
            , P_CONNECT_USER_ID                   IN HRF_FOOD_MANAGER.CREATED_BY%TYPE
            );

END HRM_FOOD_MANAGER_G;
/
CREATE OR REPLACE PACKAGE BODY HRM_FOOD_MANAGER_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_MANAGER_G
/* Description  : 식당별 담당자 지정 관리.
/*
/* Reference by : 
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- DATA SELECT.
  PROCEDURE DATA_SELECT
	          ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_STD_DATE                          IN HRF_FOOD_MANAGER.EFFECTIVE_DATE_FR%TYPE
						, W_DEVICE_ID                         IN HRF_FOOD_MANAGER.DEVICE_ID%TYPE
            , W_USER_ID                           IN HRF_FOOD_MANAGER.USER_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_MANAGER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_MANAGER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT FM.DEVICE_ID
			     , HRM_COMMON_G.ID_NAME_F(FM.DEVICE_ID) AS DEVICE_NAME
					 , FM.USER_ID
					 , EU.DESCRIPTION AS USER_NAME
					 , FM.DESCRIPTION
					 , FM.ENABLED_FLAG
					 , FM.EFFECTIVE_DATE_FR
           , FM.EFFECTIVE_DATE_TO
      FROM HRF_FOOD_MANAGER FM
			   , EAPP_USER EU
      WHERE FM.USER_ID                            = EU.USER_ID
			  AND FM.DEVICE_ID                          = NVL(W_DEVICE_ID, FM.DEVICE_ID)
        AND FM.USER_ID                            = NVL(W_USER_ID, FM.USER_ID)
        AND FM.EFFECTIVE_DATE_FR                  <= W_STD_DATE
        AND (FM.EFFECTIVE_DATE_TO IS NULL OR FM.EFFECTIVE_DATE_TO >= W_STD_DATE)
        AND FM.SOB_ID                             = W_SOB_ID
        AND FM.ORG_ID                             = W_ORG_ID
    ORDER BY FM.DEVICE_ID, FM.USER_ID
    ;

  END DATA_SELECT;

-- DATA_INSERT.
  PROCEDURE DATA_INSERT
            ( P_DEVICE_ID                         IN HRF_FOOD_MANAGER.DEVICE_ID%TYPE
            , P_USER_ID                           IN HRF_FOOD_MANAGER.USER_ID%TYPE
						, P_DESCRIPTION                       IN HRF_FOOD_MANAGER.DESCRIPTION%TYPE
            , P_ENABLED_FLAG                      IN HRF_FOOD_MANAGER.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR                 IN HRF_FOOD_MANAGER.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO                 IN HRF_FOOD_MANAGER.EFFECTIVE_DATE_TO%TYPE
            , P_SOB_ID                            IN HRF_FOOD_MANAGER.SOB_ID%TYPE
            , P_ORG_ID                            IN HRF_FOOD_MANAGER.ORG_ID%TYPE
            , P_CONNECT_USER_ID                   IN HRF_FOOD_MANAGER.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                                     HRM_MANAGER.CREATION_DATE%TYPE;

  BEGIN
    V_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);

    INSERT INTO HRF_FOOD_MANAGER
    ( DEVICE_ID, USER_ID
    , DESCRIPTION
    , ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO
    , SOB_ID, ORG_ID
    , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY)
    VALUES
    ( P_DEVICE_ID, P_USER_ID
    , P_DESCRIPTION
    , P_ENABLED_FLAG, P_EFFECTIVE_DATE_FR, P_EFFECTIVE_DATE_TO
    , P_SOB_ID, P_ORG_ID
    , V_SYSDATE, P_CONNECT_USER_ID, V_SYSDATE, P_CONNECT_USER_ID
    );
    COMMIT;

  END DATA_INSERT;

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_DEVICE_ID                         IN HRF_FOOD_MANAGER.DEVICE_ID%TYPE
            , W_USER_ID                           IN HRF_FOOD_MANAGER.USER_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_MANAGER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_MANAGER.ORG_ID%TYPE
						, P_DESCRIPTION                       IN HRF_FOOD_MANAGER.DESCRIPTION%TYPE
            , P_ENABLED_FLAG                      IN HRF_FOOD_MANAGER.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR                 IN HRF_FOOD_MANAGER.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO                 IN HRF_FOOD_MANAGER.EFFECTIVE_DATE_TO%TYPE
            , P_CONNECT_USER_ID                   IN HRF_FOOD_MANAGER.CREATED_BY%TYPE
            )
  AS
  BEGIN
    UPDATE HRF_FOOD_MANAGER FM
      SET FM.DESCRIPTION                          = P_DESCRIPTION
        , FM.ENABLED_FLAG                         = P_ENABLED_FLAG
        , FM.EFFECTIVE_DATE_FR                    = P_EFFECTIVE_DATE_FR
        , FM.EFFECTIVE_DATE_TO                    = P_EFFECTIVE_DATE_TO
        , FM.LAST_UPDATE_DATE                     = GET_LOCAL_DATE(FM.SOB_ID)
        , FM.LAST_UPDATED_BY                      = P_CONNECT_USER_ID
    WHERE FM.DEVICE_ID                            = W_DEVICE_ID
      AND FM.USER_ID                              = W_USER_ID
      AND FM.SOB_ID                               = W_SOB_ID
      AND FM.ORG_ID                               = W_ORG_ID
      ;
    COMMIT;

  END DATA_UPDATE;

END HRM_FOOD_MANAGER_G;
/
