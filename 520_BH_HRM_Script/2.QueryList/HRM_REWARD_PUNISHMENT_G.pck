CREATE OR REPLACE PACKAGE HRM_REWARD_PUNISHMENT_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                      OUT TYPES.TCURSOR
                      , W_PERSON_ID                                   IN NUMBER
           , W_SOB_ID                                      IN NUMBER
           , W_ORG_ID                                      IN NUMBER);

-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                                   IN NUMBER
           , P_RP_TYPE                                     IN VARCHAR2
           , P_RP_ID                                       IN NUMBER
           , P_RP_DATE                                     IN DATE
           , P_RP_DESCRIPTION                              IN VARCHAR2
           , P_RP_ORG                                      IN VARCHAR2
           , P_DESCRIPTION                                 IN VARCHAR2
           , P_USER_ID                                     IN NUMBER
           , W_SOB_ID                                      IN NUMBER
           , O_REWARD_PUNISHMENT_ID                        OUT NUMBER);

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_REWARD_PUNISHMENT_ID                        IN NUMBER
           , P_RP_TYPE                                     IN VARCHAR2
           , P_RP_ID                                       IN NUMBER
           , P_RP_DATE                                     IN DATE
           , P_RP_DESCRIPTION                              IN VARCHAR2
           , P_RP_ORG                                      IN VARCHAR2
           , P_DESCRIPTION                                 IN VARCHAR2
           , P_USER_ID                                     IN NUMBER
           , W_SOB_ID                                      IN NUMBER);

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_REWARD_PUNISHMENT_ID                        IN NUMBER);


-- 어학사항조회.
  PROCEDURE SELECT_REWARD_PUNISHMENT(P_CURSOR            OUT TYPES.TCURSOR
                       	          , W_CORP_ID           IN  NUMBER
                                  , W_START_DATE        IN  DATE
                                  , W_END_DATE          IN  DATE
                                  , W_DEPT_ID           IN  NUMBER
                                  , W_FLOOR_ID          IN  NUMBER
                                  , W_RNP_TYPE          IN  VARCHAR2
                                  , W_PERSON_ID         IN  NUMBER
                                  , W_EMPLOYE_YN        IN  VARCHAR2
                                  , W_SOB_ID            IN  NUMBER
                                  , W_ORG_ID            IN  NUMBER);
                                  
END HRM_REWARD_PUNISHMENT_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRM_REWARD_PUNISHMENT_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                      OUT TYPES.TCURSOR
                      , W_PERSON_ID                                   IN NUMBER
           , W_SOB_ID                                      IN NUMBER
           , W_ORG_ID                                      IN NUMBER)
  AS
  BEGIN
     OPEN P_CURSOR FOR
        SELECT RP.REWARD_PUNISHMENT_ID
            , RP.PERSON_ID
            , RP.RP_TYPE
            , HRM_COMMON_G.CODE_NAME_F('RP_TYPE', RP.RP_TYPE, W_SOB_ID, W_ORG_ID) RP_TYPE_NAME
            , RP.RP_ID
            , HRM_COMMON_G.ID_NAME_F(RP.RP_ID) RP_NAME
            , RP.RP_DATE
            , RP.RP_DESCRIPTION
            , RP.RP_ORG
            , RP.DESCRIPTION
        FROM HRM_REWARD_PUNISHMENT RP
        WHERE RP.PERSON_ID                                    = W_PERSON_ID
        ;

  END DATA_SELECT;


-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                                   IN NUMBER
           , P_RP_TYPE                                     IN VARCHAR2
           , P_RP_ID                                       IN NUMBER
           , P_RP_DATE                                     IN DATE
           , P_RP_DESCRIPTION                              IN VARCHAR2
           , P_RP_ORG                                      IN VARCHAR2
           , P_DESCRIPTION                                 IN VARCHAR2
           , P_USER_ID                                     IN NUMBER
           , W_SOB_ID                                      IN NUMBER
           , O_REWARD_PUNISHMENT_ID                        OUT NUMBER)
  AS
   D_SYSDATE                                                         DATE;
  V_REWARD_PUNISHMENT_ID                                            HRM_REWARD_PUNISHMENT.REWARD_PUNISHMENT_ID%TYPE := 0;
  
  BEGIN
   D_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    SELECT HRM_REWARD_PUNISHMENT_S1.NEXTVAL
     INTO V_REWARD_PUNISHMENT_ID
   FROM DUAL;
   EXCEPTION WHEN OTHERS THEN
    V_REWARD_PUNISHMENT_ID := 0;
  END;
    
  INSERT INTO HRM_REWARD_PUNISHMENT
  (REWARD_PUNISHMENT_ID
  , PERSON_ID, RP_TYPE
  , RP_ID, RP_DATE, RP_DESCRIPTION, RP_ORG
  , DESCRIPTION
  , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
  ) VALUES
  (V_REWARD_PUNISHMENT_ID
  , P_PERSON_ID, P_RP_TYPE
  , P_RP_ID, TRUNC(P_RP_DATE), P_RP_DESCRIPTION, P_RP_ORG
  , P_DESCRIPTION
  , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
  );
    
  O_REWARD_PUNISHMENT_ID := V_REWARD_PUNISHMENT_ID;
  
  END DATA_INSERT;

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_REWARD_PUNISHMENT_ID                        IN NUMBER
           , P_RP_TYPE                                     IN VARCHAR2
           , P_RP_ID                                       IN NUMBER
           , P_RP_DATE                                     IN DATE
           , P_RP_DESCRIPTION                              IN VARCHAR2
           , P_RP_ORG                                      IN VARCHAR2
           , P_DESCRIPTION                                 IN VARCHAR2
           , P_USER_ID                                     IN NUMBER
           , W_SOB_ID                                      IN NUMBER)
  AS
  BEGIN
  UPDATE HRM_REWARD_PUNISHMENT RP
   SET RP.RP_TYPE                                                = P_RP_TYPE
      , RP.RP_ID                                              = P_RP_ID
      , RP.RP_DATE                                            = TRUNC(P_RP_DATE)
      , RP.RP_DESCRIPTION                                     = P_RP_DESCRIPTION
      , RP.RP_ORG                                             = P_RP_ORG
      , RP.DESCRIPTION                                        = P_DESCRIPTION
      , RP.LAST_UPDATE_DATE                                   = GET_LOCAL_DATE(W_SOB_ID)
      , RP.LAST_UPDATED_BY                                    = P_USER_ID
  WHERE RP.REWARD_PUNISHMENT_ID                                   = W_REWARD_PUNISHMENT_ID
  ;

  END DATA_UPDATE;

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_REWARD_PUNISHMENT_ID                        IN NUMBER)
  AS
  BEGIN
    DELETE HRM_REWARD_PUNISHMENT RP
    WHERE RP.REWARD_PUNISHMENT_ID                                   = W_REWARD_PUNISHMENT_ID
    ;
  END DATA_DELETE;


-- 어학사항조회.
  PROCEDURE SELECT_REWARD_PUNISHMENT(P_CURSOR            OUT TYPES.TCURSOR
                       	          , W_CORP_ID           IN  NUMBER
                                  , W_START_DATE        IN  DATE
                                  , W_END_DATE          IN  DATE
                                  , W_DEPT_ID           IN  NUMBER
                                  , W_FLOOR_ID          IN  NUMBER
                                  , W_RNP_TYPE          IN  VARCHAR2
                                  , W_PERSON_ID         IN  NUMBER
                                  , W_EMPLOYE_YN        IN  VARCHAR2
                                  , W_SOB_ID            IN  NUMBER
                                  , W_ORG_ID            IN  NUMBER)
  AS
  BEGIN
     OPEN P_CURSOR FOR    
         SELECT HPM.PERSON_ID
         	    , HPM.PERSON_NUM
              , HPM.NAME
              , HRP.REWARD_PUNISHMENT_ID
              , HRP.RP_TYPE
              , HRM_COMMON_G.CODE_NAME_F('RP_TYPE', HRP.RP_TYPE, W_SOB_ID, W_ORG_ID) HRP_TYPE_NAME
              , HRP.RP_ID
              , HRM_COMMON_G.ID_NAME_F(HRP.RP_ID) RP_NAME
              , HRP.RP_DATE
              , HRP.RP_DESCRIPTION
              , HRP.RP_ORG
              , HRP.DESCRIPTION
          FROM HRM_REWARD_PUNISHMENT              HRP
              , HRM_PERSON_MASTER                 HPM
         WHERE HPM.PERSON_ID                       = HRP.PERSON_ID
           AND HRP.PERSON_ID                       = NVL(W_PERSON_ID, HRP.PERSON_ID)
           AND HPM.FLOOR_ID                        = NVL(W_FLOOR_ID, HPM.FLOOR_ID )
           AND HPM.DEPT_ID                         = NVL(W_DEPT_ID, HPM.DEPT_ID) 
           AND HRP.RP_TYPE                         = NVL(W_RNP_TYPE, HRP.RP_TYPE)
           AND HPM.CORP_ID                         = W_CORP_ID
           AND HPM.EMPLOYE_TYPE                    = DECODE(W_EMPLOYE_YN,'Y','1',HPM.EMPLOYE_TYPE)
           AND HPM.SOB_ID                          = W_SOB_ID
           AND HPM.ORG_ID                          = W_ORG_ID
           AND HRP.RP_DATE                         >= W_START_DATE
           AND HRP.RP_DATE                         <= W_END_DATE
         ORDER BY HPM.PERSON_NUM, HRP.RP_DATE;       
  END SELECT_REWARD_PUNISHMENT;
  
END HRM_REWARD_PUNISHMENT_G;
/
