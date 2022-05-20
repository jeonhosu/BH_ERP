CREATE OR REPLACE PACKAGE FI_DEPT_CC_MAPPING_G
AS

-- ���Ǻμ� ����.
  PROCEDURE DEPT_MAPPING_SELECT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_DATE          IN DATE
            , W_DEPT_CODE         IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            );

  PROCEDURE DEPT_MAPPING_INSERT
            ( P_DEPT_CODE               IN FI_DEPT_MAPPING.DEPT_CODE%TYPE
            , P_SOB_ID                  IN FI_DEPT_MAPPING.SOB_ID%TYPE
            , P_ORG_ID                  IN FI_DEPT_MAPPING.ORG_ID%TYPE
            , P_MAPPING_DEPT_CODE       IN FI_DEPT_MAPPING.MAPPING_DEPT_CODE%TYPE
            , P_MAPPING_DEPT_ALL        IN FI_DEPT_MAPPING.MAPPING_DEPT_ALL%TYPE
            , P_DESCRIPTION             IN FI_DEPT_MAPPING.DESCRIPTION%TYPE
            , P_ENABLED_FLAG            IN FI_DEPT_MAPPING.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR       IN FI_DEPT_MAPPING.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO       IN FI_DEPT_MAPPING.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID                 IN FI_DEPT_MAPPING.CREATED_BY%TYPE 
            );

  PROCEDURE DEPT_MAPPING_UPDATE
            ( W_DEPT_CODE               IN FI_DEPT_MAPPING.DEPT_CODE%TYPE
            , W_SOB_ID                  IN FI_DEPT_MAPPING.SOB_ID%TYPE
            , W_ORG_ID                  IN FI_DEPT_MAPPING.ORG_ID%TYPE
            , W_MAPPING_DEPT_CODE       IN FI_DEPT_MAPPING.MAPPING_DEPT_CODE%TYPE
            , P_MAPPING_DEPT_ALL        IN FI_DEPT_MAPPING.MAPPING_DEPT_ALL%TYPE
            , P_DESCRIPTION             IN FI_DEPT_MAPPING.DESCRIPTION%TYPE
            , P_ENABLED_FLAG            IN FI_DEPT_MAPPING.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR       IN FI_DEPT_MAPPING.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO       IN FI_DEPT_MAPPING.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID                 IN FI_DEPT_MAPPING.CREATED_BY%TYPE 
            );

-- �����ڵ� ����.
  PROCEDURE CC_MAPPING_SELECT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_DATE          IN DATE
            , W_DEPT_CODE         IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            );

  PROCEDURE CC_MAPPING_INSERT
            ( P_DEPT_CODE               IN FI_COSTCENTER_MAPPING.DEPT_CODE%TYPE
            , P_SOB_ID                  IN FI_COSTCENTER_MAPPING.SOB_ID%TYPE
            , P_ORG_ID                  IN FI_COSTCENTER_MAPPING.ORG_ID%TYPE
            , P_MAPPING_COSTCENTER_CODE IN FI_COSTCENTER_MAPPING.MAPPING_COSTCENTER_CODE%TYPE
            , P_MAPPING_COSTCENTER_ALL  IN FI_COSTCENTER_MAPPING.MAPPING_COSTCENTER_ALL%TYPE
            , P_DESCRIPTION             IN FI_COSTCENTER_MAPPING.DESCRIPTION%TYPE
            , P_ENABLED_FLAG            IN FI_COSTCENTER_MAPPING.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR       IN FI_COSTCENTER_MAPPING.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO       IN FI_COSTCENTER_MAPPING.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID                 IN FI_COSTCENTER_MAPPING.CREATED_BY%TYPE 
            );

  PROCEDURE CC_MAPPING_UPDATE
            ( W_DEPT_CODE               IN FI_COSTCENTER_MAPPING.DEPT_CODE%TYPE
            , W_SOB_ID                  IN FI_COSTCENTER_MAPPING.SOB_ID%TYPE
            , W_ORG_ID                  IN FI_COSTCENTER_MAPPING.ORG_ID%TYPE
            , W_MAPPING_COSTCENTER_CODE IN FI_COSTCENTER_MAPPING.MAPPING_COSTCENTER_CODE%TYPE
            , P_MAPPING_COSTCENTER_ALL  IN FI_COSTCENTER_MAPPING.MAPPING_COSTCENTER_ALL%TYPE
            , P_DESCRIPTION             IN FI_COSTCENTER_MAPPING.DESCRIPTION%TYPE
            , P_ENABLED_FLAG            IN FI_COSTCENTER_MAPPING.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR       IN FI_COSTCENTER_MAPPING.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO       IN FI_COSTCENTER_MAPPING.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID                 IN FI_COSTCENTER_MAPPING.CREATED_BY%TYPE 
            );

END FI_DEPT_CC_MAPPING_G;
/
CREATE OR REPLACE PACKAGE BODY FI_DEPT_CC_MAPPING_G
AS

-- ���Ǻμ� ����.
  PROCEDURE DEPT_MAPPING_SELECT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_DATE          IN DATE
            , W_DEPT_CODE         IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT DMP.DEPT_CODE
           , DM.DEPT_NAME
           , DMP.SOB_ID
           , DMP.MAPPING_DEPT_CODE
           , DM1.DEPT_NAME AS MAPPING_DEPT_NAME
           , DMP.MAPPING_DEPT_ALL
           , DMP.DESCRIPTION
           , DMP.ENABLED_FLAG
           , DMP.EFFECTIVE_DATE_FR
           , DMP.EFFECTIVE_DATE_TO
        FROM FI_DEPT_MAPPING DMP
          , FI_DEPT_MASTER DM
          , FI_DEPT_MASTER DM1
      WHERE DMP.DEPT_CODE               = DM.DEPT_CODE
        AND DMP.SOB_ID                  = DM.SOB_ID
        AND DMP.MAPPING_DEPT_CODE       = DM1.DEPT_CODE(+)
        AND DMP.SOB_ID                  = DM1.SOB_ID(+)
        AND DMP.DEPT_CODE               = NVL(W_DEPT_CODE, DMP.DEPT_CODE)  
        AND DMP.SOB_ID                  = W_SOB_ID
        AND DMP.EFFECTIVE_DATE_FR       <= W_STD_DATE
        AND (DMP.EFFECTIVE_DATE_TO IS NULL OR DMP.EFFECTIVE_DATE_TO >= W_STD_DATE)        
      ORDER BY DMP.DEPT_CODE
      ;

  END DEPT_MAPPING_SELECT;

  PROCEDURE DEPT_MAPPING_INSERT
            ( P_DEPT_CODE               IN FI_DEPT_MAPPING.DEPT_CODE%TYPE
            , P_SOB_ID                  IN FI_DEPT_MAPPING.SOB_ID%TYPE
            , P_ORG_ID                  IN FI_DEPT_MAPPING.ORG_ID%TYPE
            , P_MAPPING_DEPT_CODE       IN FI_DEPT_MAPPING.MAPPING_DEPT_CODE%TYPE
            , P_MAPPING_DEPT_ALL        IN FI_DEPT_MAPPING.MAPPING_DEPT_ALL%TYPE
            , P_DESCRIPTION             IN FI_DEPT_MAPPING.DESCRIPTION%TYPE
            , P_ENABLED_FLAG            IN FI_DEPT_MAPPING.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR       IN FI_DEPT_MAPPING.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO       IN FI_DEPT_MAPPING.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID                 IN FI_DEPT_MAPPING.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE                           DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT                      NUMBER := 0;
    
  BEGIN
    BEGIN
      SELECT COUNT(CM.DEPT_CODE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_DEPT_MAPPING CM
      WHERE CM.DEPT_CODE          = P_DEPT_CODE
        AND CM.MAPPING_DEPT_CODE  = P_MAPPING_DEPT_CODE
        AND CM.SOB_ID             = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;
    
    INSERT INTO FI_DEPT_MAPPING
    ( DEPT_CODE
    , SOB_ID 
    , ORG_ID 
    , MAPPING_DEPT_CODE 
    , MAPPING_DEPT_ALL 
    , DESCRIPTION 
    , ENABLED_FLAG 
    , EFFECTIVE_DATE_FR 
    , EFFECTIVE_DATE_TO 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_DEPT_CODE
    , P_SOB_ID
    , P_ORG_ID
    , P_MAPPING_DEPT_CODE
    , P_MAPPING_DEPT_ALL
    , P_DESCRIPTION
    , P_ENABLED_FLAG
    , P_EFFECTIVE_DATE_FR
    , P_EFFECTIVE_DATE_TO
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
    
  EXCEPTION 
    WHEN ERRNUMS.Exist_Data THEN 
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END DEPT_MAPPING_INSERT;

  PROCEDURE DEPT_MAPPING_UPDATE
            ( W_DEPT_CODE               IN FI_DEPT_MAPPING.DEPT_CODE%TYPE
            , W_SOB_ID                  IN FI_DEPT_MAPPING.SOB_ID%TYPE
            , W_ORG_ID                  IN FI_DEPT_MAPPING.ORG_ID%TYPE
            , W_MAPPING_DEPT_CODE       IN FI_DEPT_MAPPING.MAPPING_DEPT_CODE%TYPE
            , P_MAPPING_DEPT_ALL        IN FI_DEPT_MAPPING.MAPPING_DEPT_ALL%TYPE
            , P_DESCRIPTION             IN FI_DEPT_MAPPING.DESCRIPTION%TYPE
            , P_ENABLED_FLAG            IN FI_DEPT_MAPPING.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR       IN FI_DEPT_MAPPING.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO       IN FI_DEPT_MAPPING.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID                 IN FI_DEPT_MAPPING.CREATED_BY%TYPE 
            )
  AS
  BEGIN
    UPDATE FI_DEPT_MAPPING
      SET MAPPING_DEPT_ALL  = P_MAPPING_DEPT_ALL
        , DESCRIPTION             = P_DESCRIPTION
        , ENABLED_FLAG            = P_ENABLED_FLAG
        , EFFECTIVE_DATE_FR       = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO       = P_EFFECTIVE_DATE_TO
        , LAST_UPDATE_DATE        = GET_LOCAL_DATE(SOB_ID)
        , LAST_UPDATED_BY         = P_USER_ID
    WHERE DEPT_CODE               = W_DEPT_CODE
      AND SOB_ID                  = W_SOB_ID
      AND MAPPING_DEPT_CODE       = W_MAPPING_DEPT_CODE
    ;
    
  END DEPT_MAPPING_UPDATE;
              
-- �����ڵ� ����.
  PROCEDURE CC_MAPPING_SELECT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_DATE          IN DATE
            , W_DEPT_CODE         IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT CM.DEPT_CODE
           , DM.DEPT_NAME
           , CM.SOB_ID
           , CM.MAPPING_COSTCENTER_CODE
           , CC.COST_CENTER_DESC AS MAPPING_COST_CENTER_DESC
           , CM.MAPPING_COSTCENTER_ALL
           , CM.DESCRIPTION
           , CM.ENABLED_FLAG
           , CM.EFFECTIVE_DATE_FR
           , CM.EFFECTIVE_DATE_TO
        FROM FI_COSTCENTER_MAPPING CM
          , FI_DEPT_MASTER DM
          , CST_COST_CENTER_TLV CC
      WHERE CM.DEPT_CODE                = DM.DEPT_CODE
        AND CM.SOB_ID                   = DM.SOB_ID
        AND CM.MAPPING_COSTCENTER_CODE  = CC.COST_CENTER_CODE(+)
        AND CM.SOB_ID                   = CC.SOB_ID(+)
        AND CM.DEPT_CODE                = NVL(W_DEPT_CODE, CM.DEPT_CODE)  
        AND CM.SOB_ID                   = W_SOB_ID
        AND CM.EFFECTIVE_DATE_FR        <= W_STD_DATE
        AND (CM.EFFECTIVE_DATE_TO IS NULL OR CM.EFFECTIVE_DATE_TO >= W_STD_DATE)        
      ORDER BY CM.DEPT_CODE
      ;
      
  END CC_MAPPING_SELECT;

  PROCEDURE CC_MAPPING_INSERT
            ( P_DEPT_CODE               IN FI_COSTCENTER_MAPPING.DEPT_CODE%TYPE
            , P_SOB_ID                  IN FI_COSTCENTER_MAPPING.SOB_ID%TYPE
            , P_ORG_ID                  IN FI_COSTCENTER_MAPPING.ORG_ID%TYPE
            , P_MAPPING_COSTCENTER_CODE IN FI_COSTCENTER_MAPPING.MAPPING_COSTCENTER_CODE%TYPE
            , P_MAPPING_COSTCENTER_ALL  IN FI_COSTCENTER_MAPPING.MAPPING_COSTCENTER_ALL%TYPE
            , P_DESCRIPTION             IN FI_COSTCENTER_MAPPING.DESCRIPTION%TYPE
            , P_ENABLED_FLAG            IN FI_COSTCENTER_MAPPING.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR       IN FI_COSTCENTER_MAPPING.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO       IN FI_COSTCENTER_MAPPING.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID                 IN FI_COSTCENTER_MAPPING.CREATED_BY%TYPE 
            )
  AS 
    V_SYSDATE                           DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT                      NUMBER := 0;
    
  BEGIN
    BEGIN
      SELECT COUNT(CM.DEPT_CODE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_COSTCENTER_MAPPING CM
      WHERE CM.DEPT_CODE          = P_DEPT_CODE
        AND CM.MAPPING_COSTCENTER_CODE  = P_MAPPING_COSTCENTER_CODE
        AND CM.SOB_ID                   = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;
    
    INSERT INTO FI_COSTCENTER_MAPPING
    ( DEPT_CODE
    , SOB_ID 
    , ORG_ID 
    , MAPPING_COSTCENTER_CODE 
    , MAPPING_COSTCENTER_ALL 
    , DESCRIPTION 
    , ENABLED_FLAG 
    , EFFECTIVE_DATE_FR 
    , EFFECTIVE_DATE_TO 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_DEPT_CODE
    , P_SOB_ID
    , P_ORG_ID
    , P_MAPPING_COSTCENTER_CODE
    , P_MAPPING_COSTCENTER_ALL
    , P_DESCRIPTION
    , P_ENABLED_FLAG
    , P_EFFECTIVE_DATE_FR
    , P_EFFECTIVE_DATE_TO
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
    
  EXCEPTION 
    WHEN ERRNUMS.Exist_Data THEN 
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END CC_MAPPING_INSERT;

  PROCEDURE CC_MAPPING_UPDATE
            ( W_DEPT_CODE               IN FI_COSTCENTER_MAPPING.DEPT_CODE%TYPE
            , W_SOB_ID                  IN FI_COSTCENTER_MAPPING.SOB_ID%TYPE
            , W_ORG_ID                  IN FI_COSTCENTER_MAPPING.ORG_ID%TYPE
            , W_MAPPING_COSTCENTER_CODE IN FI_COSTCENTER_MAPPING.MAPPING_COSTCENTER_CODE%TYPE
            , P_MAPPING_COSTCENTER_ALL  IN FI_COSTCENTER_MAPPING.MAPPING_COSTCENTER_ALL%TYPE
            , P_DESCRIPTION             IN FI_COSTCENTER_MAPPING.DESCRIPTION%TYPE
            , P_ENABLED_FLAG            IN FI_COSTCENTER_MAPPING.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR       IN FI_COSTCENTER_MAPPING.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO       IN FI_COSTCENTER_MAPPING.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID                 IN FI_COSTCENTER_MAPPING.CREATED_BY%TYPE 
            )
  AS
  BEGIN
    UPDATE FI_COSTCENTER_MAPPING
      SET MAPPING_COSTCENTER_ALL  = P_MAPPING_COSTCENTER_ALL
        , DESCRIPTION             = P_DESCRIPTION
        , ENABLED_FLAG            = P_ENABLED_FLAG
        , EFFECTIVE_DATE_FR       = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO       = P_EFFECTIVE_DATE_TO
        , LAST_UPDATE_DATE        = GET_LOCAL_DATE(SOB_ID)
        , LAST_UPDATED_BY         = P_USER_ID
    WHERE DEPT_CODE               = W_DEPT_CODE
      AND SOB_ID                  = W_SOB_ID
      AND MAPPING_COSTCENTER_CODE = W_MAPPING_COSTCENTER_CODE
    ;
    
  END CC_MAPPING_UPDATE;
  
END FI_DEPT_CC_MAPPING_G;
/
