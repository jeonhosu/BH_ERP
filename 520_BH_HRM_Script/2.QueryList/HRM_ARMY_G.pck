CREATE OR REPLACE PACKAGE HRM_ARMY_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                OUT TYPES.TCURSOR
                      , W_PERSON_ID                             IN NUMBER);

-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                             IN NUMBER
           , P_ARMY_KIND_ID                          IN NUMBER
           , P_ARMY_STATUS_ID                        IN NUMBER
           , P_ARMY_GRADE_ID                         IN NUMBER
           , P_ARMY_START_DATE                       IN DATE
           , P_ARMY_END_DATE                         IN DATE
           , P_ARMY_END_TYPE_ID                      IN NUMBER
           , P_ARMY_EXCEPTION_DESC                   IN VARCHAR2
           , P_EXCEPTION_ID                          IN NUMBER
           , P_EXCEPTION_OK_DATE                     IN DATE
           , P_EXCEPTION_FINISH_DATE                 IN DATE
           , P_EXCEPTION_LICENSE_ID                  IN NUMBER
           , P_EXCEPTION_GRADE_ID                    IN NUMBER
           , P_EXCEPTION_START_DATE                  IN DATE
           , P_EXCEPTION_END_DATE                    IN DATE
           , P_DESCRIPTION                           IN VARCHAR2
           , P_USER_ID                               IN NUMBER
           , W_SOB_ID                                IN NUMBER);

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_PERSON_ID                             IN NUMBER
           , P_ARMY_KIND_ID                          IN NUMBER
           , P_ARMY_STATUS_ID                        IN NUMBER
           , P_ARMY_GRADE_ID                         IN NUMBER
           , P_ARMY_START_DATE                       IN DATE
           , P_ARMY_END_DATE                         IN DATE
           , P_ARMY_END_TYPE_ID                      IN NUMBER
           , P_ARMY_EXCEPTION_DESC                   IN VARCHAR2
           , P_EXCEPTION_ID                          IN NUMBER
           , P_EXCEPTION_OK_DATE                     IN DATE
           , P_EXCEPTION_FINISH_DATE                 IN DATE
           , P_EXCEPTION_LICENSE_ID                  IN NUMBER
           , P_EXCEPTION_GRADE_ID                    IN NUMBER
           , P_EXCEPTION_START_DATE                  IN DATE
           , P_EXCEPTION_END_DATE                    IN DATE
           , P_DESCRIPTION                           IN VARCHAR2
           , P_USER_ID                               IN NUMBER
           , W_SOB_ID                                IN NUMBER);

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_PERSON_ID                             IN NUMBER);


-- PRINT DATA_SELECT.
  PROCEDURE PRINT_ARMY
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );


-- 병역현황 
  PROCEDURE SELECT_ARMY_CURRENT( P_CURSOR            OUT TYPES.TCURSOR
                                , W_CORP_ID           IN  NUMBER
                                , W_STD_DATE          IN  DATE
                                , W_DEPT_ID           IN  NUMBER
                                , W_FLOOR_ID          IN  NUMBER
                                , W_PERSON_ID         IN  NUMBER
                                , W_SOB_ID            IN  NUMBER
                                , W_ORG_ID            IN  NUMBER);
                                
END HRM_ARMY_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRM_ARMY_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                OUT TYPES.TCURSOR
                      , W_PERSON_ID                             IN NUMBER)
  AS
  BEGIN
     OPEN P_CURSOR FOR
        SELECT HA.PERSON_ID
            , HA.ARMY_KIND_ID
            , HRM_COMMON_G.ID_NAME_F(HA.ARMY_KIND_ID) ARMY_KIND_NAME
            , HA.ARMY_STATUS_ID
            , HRM_COMMON_G.ID_NAME_F(HA.ARMY_STATUS_ID) ARMY_STATUS_NAME
            , HA.ARMY_GRADE_ID
            , HRM_COMMON_G.ID_NAME_F(HA.ARMY_GRADE_ID) ARMY_GRADE_NAME
            , HA.ARMY_START_DATE
            , HA.ARMY_END_DATE
            , HA.ARMY_END_TYPE_ID
            , HRM_COMMON_G.ID_NAME_F(HA.ARMY_END_TYPE_ID) ARMY_END_TYPE_NAME
            , HA.ARMY_EXCEPTION_DESC
            , HA.EXCEPTION_ID
            , HRM_COMMON_G.ID_NAME_F(HA.EXCEPTION_ID) EXCEPTION_NAME
            , HA.EXCEPTION_OK_DATE
            , HA.EXCEPTION_FINISH_DATE
            , HA.EXCEPTION_LICENSE_ID
            , HRM_COMMON_G.ID_NAME_F(HA.EXCEPTION_LICENSE_ID) EXCEPTION_LICENSE_NAME
            , HA.EXCEPTION_GRADE_ID
            , HRM_COMMON_G.ID_NAME_F(HA.EXCEPTION_GRADE_ID) EXCEPTION_GRADE_NAME
            , HA.EXCEPTION_START_DATE
            , HA.EXCEPTION_END_DATE
            , HA.DESCRIPTION
        FROM HRM_ARMY HA
        WHERE HA.PERSON_ID                                = W_PERSON_ID
        ;

  END DATA_SELECT;


-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                             IN NUMBER
           , P_ARMY_KIND_ID                          IN NUMBER
           , P_ARMY_STATUS_ID                        IN NUMBER
           , P_ARMY_GRADE_ID                         IN NUMBER
           , P_ARMY_START_DATE                       IN DATE
           , P_ARMY_END_DATE                         IN DATE
           , P_ARMY_END_TYPE_ID                      IN NUMBER
           , P_ARMY_EXCEPTION_DESC                   IN VARCHAR2
           , P_EXCEPTION_ID                          IN NUMBER
           , P_EXCEPTION_OK_DATE                     IN DATE
           , P_EXCEPTION_FINISH_DATE                 IN DATE
           , P_EXCEPTION_LICENSE_ID                  IN NUMBER
           , P_EXCEPTION_GRADE_ID                    IN NUMBER
           , P_EXCEPTION_START_DATE                  IN DATE
           , P_EXCEPTION_END_DATE                    IN DATE
           , P_DESCRIPTION                           IN VARCHAR2
           , P_USER_ID                               IN NUMBER
           , W_SOB_ID                                IN NUMBER)
  AS
    D_SYSDATE                                                   DATE;
  
  BEGIN
    D_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);

    INSERT INTO HRM_ARMY
    (PERSON_ID, ARMY_KIND_ID, ARMY_STATUS_ID
    , ARMY_GRADE_ID, ARMY_START_DATE, ARMY_END_DATE
    , ARMY_END_TYPE_ID, ARMY_EXCEPTION_DESC
    , EXCEPTION_ID, EXCEPTION_OK_DATE, EXCEPTION_FINISH_DATE
    , EXCEPTION_LICENSE_ID, EXCEPTION_GRADE_ID
    , EXCEPTION_START_DATE, EXCEPTION_END_DATE
    , DESCRIPTION
    , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
    ) VALUES
    (P_PERSON_ID, P_ARMY_KIND_ID, P_ARMY_STATUS_ID
    , P_ARMY_GRADE_ID, TRUNC(P_ARMY_START_DATE), TRUNC(P_ARMY_END_DATE)
    , P_ARMY_END_TYPE_ID, P_ARMY_EXCEPTION_DESC
    , P_EXCEPTION_ID, TRUNC(P_EXCEPTION_OK_DATE), TRUNC(P_EXCEPTION_FINISH_DATE)
    , P_EXCEPTION_LICENSE_ID, P_EXCEPTION_GRADE_ID
    , TRUNC(P_EXCEPTION_START_DATE), TRUNC(P_EXCEPTION_END_DATE)
    , P_DESCRIPTION
    , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
    );
        
  END DATA_INSERT;

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_PERSON_ID                             IN NUMBER
           , P_ARMY_KIND_ID                          IN NUMBER
           , P_ARMY_STATUS_ID                        IN NUMBER
           , P_ARMY_GRADE_ID                         IN NUMBER
           , P_ARMY_START_DATE                       IN DATE
           , P_ARMY_END_DATE                         IN DATE
           , P_ARMY_END_TYPE_ID                      IN NUMBER
           , P_ARMY_EXCEPTION_DESC                   IN VARCHAR2
           , P_EXCEPTION_ID                          IN NUMBER
           , P_EXCEPTION_OK_DATE                     IN DATE
           , P_EXCEPTION_FINISH_DATE                 IN DATE
           , P_EXCEPTION_LICENSE_ID                  IN NUMBER
           , P_EXCEPTION_GRADE_ID                    IN NUMBER
           , P_EXCEPTION_START_DATE                  IN DATE
           , P_EXCEPTION_END_DATE                    IN DATE
           , P_DESCRIPTION                           IN VARCHAR2
           , P_USER_ID                               IN NUMBER
           , W_SOB_ID                                IN NUMBER)
  AS
  BEGIN
    UPDATE HRM_ARMY HA
     SET HA.ARMY_KIND_ID                                     = P_ARMY_KIND_ID
        , HA.ARMY_STATUS_ID                               = P_ARMY_STATUS_ID
        , HA.ARMY_GRADE_ID                                = P_ARMY_GRADE_ID
        , HA.ARMY_START_DATE                              = TRUNC(P_ARMY_START_DATE)
        , HA.ARMY_END_DATE                                = TRUNC(P_ARMY_END_DATE)
        , HA.ARMY_END_TYPE_ID                             = P_ARMY_END_TYPE_ID
        , HA.ARMY_EXCEPTION_DESC                          = P_ARMY_EXCEPTION_DESC
        , HA.EXCEPTION_ID                                 = P_EXCEPTION_ID
        , HA.EXCEPTION_OK_DATE                            = TRUNC(P_EXCEPTION_OK_DATE)
        , HA.EXCEPTION_FINISH_DATE                        = TRUNC(P_EXCEPTION_FINISH_DATE)
        , HA.EXCEPTION_LICENSE_ID                         = P_EXCEPTION_LICENSE_ID
        , HA.EXCEPTION_GRADE_ID                           = P_EXCEPTION_GRADE_ID
        , HA.EXCEPTION_START_DATE                         = TRUNC(P_EXCEPTION_START_DATE)
        , HA.EXCEPTION_END_DATE                           = TRUNC(P_EXCEPTION_END_DATE)
        , HA.DESCRIPTION                                  = P_DESCRIPTION
        , HA.LAST_UPDATE_DATE                             = GET_LOCAL_DATE(W_SOB_ID)
        , HA.LAST_UPDATED_BY                              = P_USER_ID
    WHERE HA.PERSON_ID                                        = W_PERSON_ID
    ;

  END DATA_UPDATE;

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_PERSON_ID                             IN NUMBER)
  AS
  BEGIN
    DELETE HRM_ARMY HA
    WHERE HA.PERSON_ID                                        = W_PERSON_ID 
    ;
  END DATA_DELETE;


-- PRINT DATA_SELECT.
  PROCEDURE PRINT_ARMY
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
        SELECT HA.PERSON_ID
            , HA.ARMY_KIND_ID
            , HRM_COMMON_G.ID_NAME_F(HA.ARMY_KIND_ID) ARMY_KIND_NAME
            , HA.ARMY_STATUS_ID
            , HRM_COMMON_G.ID_NAME_F(HA.ARMY_STATUS_ID) ARMY_STATUS_NAME
            , HA.ARMY_GRADE_ID
            , HRM_COMMON_G.ID_NAME_F(HA.ARMY_GRADE_ID) ARMY_GRADE_NAME
            , HA.ARMY_START_DATE
            , HA.ARMY_END_DATE
            , HA.ARMY_END_TYPE_ID
            , HRM_COMMON_G.ID_NAME_F(HA.ARMY_END_TYPE_ID) ARMY_END_TYPE_NAME
            , HA.ARMY_EXCEPTION_DESC
            , HA.EXCEPTION_ID
            , HRM_COMMON_G.ID_NAME_F(HA.EXCEPTION_ID) EXCEPTION_NAME
            , HA.EXCEPTION_OK_DATE
            , HA.EXCEPTION_FINISH_DATE
            , HA.EXCEPTION_LICENSE_ID
            , HRM_COMMON_G.ID_NAME_F(HA.EXCEPTION_LICENSE_ID) EXCEPTION_LICENSE_NAME
            , HA.EXCEPTION_GRADE_ID
            , HRM_COMMON_G.ID_NAME_F(HA.EXCEPTION_GRADE_ID) EXCEPTION_GRADE_NAME
            , HA.EXCEPTION_START_DATE
            , HA.EXCEPTION_END_DATE
            , HA.DESCRIPTION
         FROM HRM_ARMY HA
        WHERE HA.PERSON_ID        = W_PERSON_ID
          AND ROWNUM              <= 1
        ;
  END PRINT_ARMY;

-- 병역현황 
  PROCEDURE SELECT_ARMY_CURRENT( P_CURSOR            OUT TYPES.TCURSOR
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
        SELECT HA.PERSON_ID
             , HPM.PERSON_NUM
             , HPM.NAME
             , HA.ARMY_KIND_ID
             , HRM_COMMON_G.ID_NAME_F(HA.ARMY_KIND_ID) ARMY_KIND_NAME
             , HA.ARMY_STATUS_ID
             , HRM_COMMON_G.ID_NAME_F(HA.ARMY_STATUS_ID) ARMY_STATUS_NAME
             , HA.ARMY_GRADE_ID
             , HRM_COMMON_G.ID_NAME_F(HA.ARMY_GRADE_ID) ARMY_GRADE_NAME
             , HA.ARMY_START_DATE
             , HA.ARMY_END_DATE
             , HA.ARMY_END_TYPE_ID
             , HRM_COMMON_G.ID_NAME_F(HA.ARMY_END_TYPE_ID) ARMY_END_TYPE_NAME
             , HA.ARMY_EXCEPTION_DESC
             , HA.EXCEPTION_ID
             , HRM_COMMON_G.ID_NAME_F(HA.EXCEPTION_ID) EXCEPTION_NAME
             , HA.EXCEPTION_OK_DATE
             , HA.EXCEPTION_FINISH_DATE
             , HA.EXCEPTION_LICENSE_ID
             , HRM_COMMON_G.ID_NAME_F(HA.EXCEPTION_LICENSE_ID) EXCEPTION_LICENSE_NAME
             , HA.EXCEPTION_GRADE_ID
             , HRM_COMMON_G.ID_NAME_F(HA.EXCEPTION_GRADE_ID) EXCEPTION_GRADE_NAME
             , HA.EXCEPTION_START_DATE
             , HA.EXCEPTION_END_DATE
             , HA.DESCRIPTION
        FROM HRM_ARMY HA
           , HRM_PERSON_MASTER HPM
       WHERE HPM.PERSON_ID   = HA.PERSON_ID
         AND HPM.CORP_ID     = W_CORP_ID
         AND HPM.DEPT_ID     = NVL(W_DEPT_ID, HPM.DEPT_ID)
         AND ((W_FLOOR_ID   IS NULL AND 1 = 1)
          OR (W_FLOOR_ID   IS NOT NULL AND HPM.FLOOR_ID = W_FLOOR_ID))
         AND HPM.SOB_ID      = W_SOB_ID
         AND HPM.ORG_ID      = W_ORG_ID
         AND HA.PERSON_ID    = NVL(W_PERSON_ID, HA.PERSON_ID)
         AND HPM.JOIN_DATE    <= W_STD_DATE
         AND (HPM.RETIRE_DATE >= W_STD_DATE OR HPM.RETIRE_DATE IS NULL)
       ORDER BY HPM.PERSON_NUM
     ;
  END SELECT_ARMY_CURRENT;
    
END HRM_ARMY_G;
/
