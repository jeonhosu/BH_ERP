CREATE OR REPLACE PACKAGE HRM_BODY_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                          OUT TYPES.TCURSOR
                      , W_PERSON_ID                                       IN NUMBER);

-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                                       IN NUMBER
           , P_HEIGHT                                          IN NUMBER
           , P_WEIGHT                                          IN NUMBER
           , P_BLOOD_ID                                        IN NUMBER
           , P_LEFT_EYE                                        IN VARCHAR2
           , P_RIGHT_EYE                                       IN VARCHAR2
           , P_ACHRO_ID                                        IN NUMBER
           , P_FOOTWEAR_SIZE                                   IN NUMBER
           , P_UNIFORM_UPPER_SIZE                              IN VARCHAR2
           , P_UNIFORM_UNDER_SIZE                              IN VARCHAR2
           , P_DISABLED_ID                                     IN NUMBER
           , P_BOHUN_ID                                        IN NUMBER
           , P_BOHUN_NUM                                       IN VARCHAR2
           , P_DESCRIPTION                                     IN VARCHAR2
           , P_USER_ID                                         IN NUMBER
           , W_SOB_ID                                          IN NUMBER);

-- DATA_UPDATE..
  PROCEDURE DATA_UPDATE(W_PERSON_ID                                       IN NUMBER
           , P_HEIGHT                                          IN NUMBER
           , P_WEIGHT                                          IN NUMBER
           , P_BLOOD_ID                                        IN NUMBER
           , P_LEFT_EYE                                        IN VARCHAR2
           , P_RIGHT_EYE                                       IN VARCHAR2
           , P_ACHRO_ID                                        IN NUMBER
           , P_FOOTWEAR_SIZE                                   IN NUMBER
           , P_UNIFORM_UPPER_SIZE                              IN VARCHAR2
           , P_UNIFORM_UNDER_SIZE                              IN VARCHAR2
           , P_DISABLED_ID                                     IN NUMBER
           , P_BOHUN_ID                                        IN NUMBER
           , P_BOHUN_NUM                                       IN VARCHAR2
           , P_DESCRIPTION                                     IN VARCHAR2
           , P_USER_ID                                         IN NUMBER
           , W_SOB_ID                                          IN NUMBER);

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_PERSON_ID                                       IN NUMBER);


-- 신체현황 
  PROCEDURE SELECT_BODY_CURRENT( P_CURSOR            OUT TYPES.TCURSOR
                                , W_CORP_ID           IN  NUMBER
                                , W_STD_DATE          IN  DATE
                                , W_DEPT_ID           IN  NUMBER
                                , W_FLOOR_ID          IN  NUMBER
                                , W_PERSON_ID         IN  NUMBER
                                , W_SOB_ID            IN  NUMBER
                                , W_ORG_ID            IN  NUMBER);
                                
END HRM_BODY_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRM_BODY_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                          OUT TYPES.TCURSOR
                      , W_PERSON_ID                                       IN NUMBER)
  AS
  BEGIN
     OPEN P_CURSOR FOR
        SELECT HB.PERSON_ID
            , HB.HEIGHT
            , HB.WEIGHT
            , HB.BLOOD_ID
            , HRM_COMMON_G.ID_NAME_F(HB.BLOOD_ID) BLOOD_NAME
            , HB.LEFT_EYE
            , HB.RIGHT_EYE
            , HB.ACHRO_ID
            , HRM_COMMON_G.ID_NAME_F(HB.ACHRO_ID) ACHRO_NAME
            , HB.FOOTWEAR_SIZE
            , HB.UNIFORM_UPPER_SIZE
            , HB.UNIFORM_UNDER_SIZE
            , HB.DISABLED_ID
            , HRM_COMMON_G.ID_NAME_F(HB.DISABLED_ID) DISABLED_NAME
            , HB.BOHUN_ID
            , HRM_COMMON_G.ID_NAME_F(HB.BOHUN_ID) BOHUN_NAME
            , HB.BOHUN_NUM
            , HB.DESCRIPTION
        FROM HRM_BODY HB
        WHERE HB.PERSON_ID                                = W_PERSON_ID
        ;

  END DATA_SELECT;


-- DATA_INSERT..
  PROCEDURE DATA_INSERT(P_PERSON_ID                                       IN NUMBER
           , P_HEIGHT                                          IN NUMBER
           , P_WEIGHT                                          IN NUMBER
           , P_BLOOD_ID                                        IN NUMBER
           , P_LEFT_EYE                                        IN VARCHAR2
           , P_RIGHT_EYE                                       IN VARCHAR2
           , P_ACHRO_ID                                        IN NUMBER
           , P_FOOTWEAR_SIZE                                   IN NUMBER
           , P_UNIFORM_UPPER_SIZE                              IN VARCHAR2
           , P_UNIFORM_UNDER_SIZE                              IN VARCHAR2
           , P_DISABLED_ID                                     IN NUMBER
           , P_BOHUN_ID                                        IN NUMBER
           , P_BOHUN_NUM                                       IN VARCHAR2
           , P_DESCRIPTION                                     IN VARCHAR2
           , P_USER_ID                                         IN NUMBER
           , W_SOB_ID                                          IN NUMBER)
  AS
   D_SYSDATE                                                             DATE;
  
  BEGIN
   D_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
  
  INSERT INTO HRM_BODY
  (PERSON_ID
  , HEIGHT, WEIGHT, BLOOD_ID
  , LEFT_EYE, RIGHT_EYE, ACHRO_ID
  , FOOTWEAR_SIZE, UNIFORM_UPPER_SIZE, UNIFORM_UNDER_SIZE
  , DISABLED_ID, BOHUN_ID, BOHUN_NUM
  , DESCRIPTION
  , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
  ) VALUES
  (P_PERSON_ID
  , P_HEIGHT, P_WEIGHT, P_BLOOD_ID
  , P_LEFT_EYE, P_RIGHT_EYE, P_ACHRO_ID
  , P_FOOTWEAR_SIZE, P_UNIFORM_UPPER_SIZE, P_UNIFORM_UNDER_SIZE
  , P_DISABLED_ID, P_BOHUN_ID, P_BOHUN_NUM
  , P_DESCRIPTION
  , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
  );
      
  END DATA_INSERT;

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_PERSON_ID                                       IN NUMBER
           , P_HEIGHT                                          IN NUMBER
           , P_WEIGHT                                          IN NUMBER
           , P_BLOOD_ID                                        IN NUMBER
           , P_LEFT_EYE                                        IN VARCHAR2
           , P_RIGHT_EYE                                       IN VARCHAR2
           , P_ACHRO_ID                                        IN NUMBER
           , P_FOOTWEAR_SIZE                                   IN NUMBER
           , P_UNIFORM_UPPER_SIZE                              IN VARCHAR2
           , P_UNIFORM_UNDER_SIZE                              IN VARCHAR2
           , P_DISABLED_ID                                     IN NUMBER
           , P_BOHUN_ID                                        IN NUMBER
           , P_BOHUN_NUM                                       IN VARCHAR2
           , P_DESCRIPTION                                     IN VARCHAR2
           , P_USER_ID                                         IN NUMBER
           , W_SOB_ID                                          IN NUMBER)
  AS
  BEGIN
  UPDATE HRM_BODY HB
   SET HB.HEIGHT                                                     = P_HEIGHT
      , HB.WEIGHT                                                 = P_WEIGHT
      , HB.BLOOD_ID                                               = P_BLOOD_ID
      , HB.LEFT_EYE                                               = P_LEFT_EYE
      , HB.RIGHT_EYE                                              = P_RIGHT_EYE
      , HB.ACHRO_ID                                               = P_ACHRO_ID
      , HB.FOOTWEAR_SIZE                                          = P_FOOTWEAR_SIZE
      , HB.UNIFORM_UPPER_SIZE                                     = P_UNIFORM_UPPER_SIZE
      , HB.UNIFORM_UNDER_SIZE                                     = P_UNIFORM_UNDER_SIZE
      , HB.DISABLED_ID                                            = P_DISABLED_ID
      , HB.BOHUN_ID                                               = P_BOHUN_ID
      , HB.BOHUN_NUM                                              = P_BOHUN_NUM
      , HB.DESCRIPTION                                            = P_DESCRIPTION
      , HB.LAST_UPDATE_DATE                                       = GET_LOCAL_DATE(W_SOB_ID)
      , HB.LAST_UPDATED_BY                                        = P_USER_ID
  WHERE HB.PERSON_ID                                                  = W_PERSON_ID
  ;

  END DATA_UPDATE;

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_PERSON_ID                                       IN NUMBER)
  AS
  BEGIN
  DELETE HRM_BODY HB
  WHERE HB.PERSON_ID                                                  = W_PERSON_ID
  ;
      
  END DATA_DELETE;

-- 신체현황 
  PROCEDURE SELECT_BODY_CURRENT( P_CURSOR            OUT TYPES.TCURSOR
                                , W_CORP_ID           IN  NUMBER
                                , W_STD_DATE          IN  DATE
                                , W_DEPT_ID           IN  NUMBER
                                , W_FLOOR_ID          IN  NUMBER
                                , W_PERSON_ID         IN  NUMBER
                                , W_SOB_ID            IN  NUMBER
                                , W_ORG_ID            IN  NUMBER)
  AS
  BEGIN
      OPEN P_CURSOR FOR
       SELECT HB.PERSON_ID
            , HPM.PERSON_NUM
            , HPM.NAME
            , HB.HEIGHT
            , HB.WEIGHT
            , HB.BLOOD_ID
            , HRM_COMMON_G.ID_NAME_F(HB.BLOOD_ID) BLOOD_NAME
            , HB.LEFT_EYE
            , HB.RIGHT_EYE
            , HB.ACHRO_ID
            , HRM_COMMON_G.ID_NAME_F(HB.ACHRO_ID) ACHRO_NAME
            , HB.FOOTWEAR_SIZE
            , HB.UNIFORM_UPPER_SIZE
            , HB.UNIFORM_UNDER_SIZE
            , HB.DISABLED_ID
            , HRM_COMMON_G.ID_NAME_F(HB.DISABLED_ID) DISABLED_NAME
            , HB.BOHUN_ID
            , HRM_COMMON_G.ID_NAME_F(HB.BOHUN_ID) BOHUN_NAME
            , HB.BOHUN_NUM
            , HB.DESCRIPTION
         FROM HRM_BODY HB
            , HRM_PERSON_MASTER HPM
        WHERE HPM.PERSON_ID   = HB.PERSON_ID
          AND HPM.CORP_ID     = W_CORP_ID
          AND HPM.DEPT_ID     = NVL(W_DEPT_ID, HPM.DEPT_ID)
          AND ((W_FLOOR_ID   IS NULL AND 1 = 1)
           OR (W_FLOOR_ID   IS NOT NULL AND HPM.FLOOR_ID = W_FLOOR_ID))
          AND HPM.SOB_ID      = W_SOB_ID
          AND HPM.ORG_ID      = W_ORG_ID
          AND HB.PERSON_ID    = NVL(W_PERSON_ID, HB.PERSON_ID)
          AND HPM.JOIN_DATE    <= W_STD_DATE
          AND (HPM.RETIRE_DATE >= W_STD_DATE OR HPM.RETIRE_DATE IS NULL)
     ORDER BY HPM.PERSON_NUM
     ;
   END SELECT_BODY_CURRENT;    
   
     
END HRM_BODY_G;
/
