CREATE OR REPLACE PACKAGE HRM_LICENSE_G
AS
-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                      OUT TYPES.TCURSOR
                      , W_PERSON_ID                                   IN NUMBER);

-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                                   IN NUMBER
           , P_LICENSE_ID                                  IN NUMBER
           , P_LICENSE_GRADE_ID                            IN NUMBER
           , P_LICENSE_NO                                  IN VARCHAR2
           , P_LICENSE_DATE                                IN DATE
           , P_LICENSE_ORG                                 IN VARCHAR2
           , P_RENEW_DATE                                  IN DATE
           , P_DESCRIPTION                                 IN VARCHAR2
           , P_USER_ID                                     IN NUMBER
           , W_SOB_ID                                      IN NUMBER);

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_PERSON_ID                                   IN NUMBER
           , W_LICENSE_ID                                  IN NUMBER
           , P_LICENSE_GRADE_ID                            IN NUMBER
           , P_LICENSE_NO                                  IN VARCHAR2
           , P_LICENSE_DATE                                IN DATE
           , P_LICENSE_ORG                                 IN VARCHAR2
           , P_RENEW_DATE                                  IN DATE
           , P_DESCRIPTION                                 IN VARCHAR2
           , P_USER_ID                                     IN NUMBER
           , W_SOB_ID                                      IN NUMBER);

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_PERSON_ID                                   IN NUMBER
                      , W_LICENSE_ID                                  IN NUMBER);


-- 자격사항조회.
  PROCEDURE SELECT_LICENSE(P_CURSOR            OUT TYPES.TCURSOR
                         , W_CORP_ID           IN  NUMBER
                         , W_START_DATE        IN  DATE
                         , W_END_DATE          IN  DATE
                         , W_DEPT_ID           IN  NUMBER
                         , W_FLOOR_ID          IN  NUMBER
                         , W_POST_ID           IN  NUMBER
                         , W_PERSON_ID         IN  NUMBER
                         , W_EMPLOYE_YN        IN  VARCHAR2
                         , W_SOB_ID            IN  NUMBER
                         , W_ORG_ID            IN  NUMBER);
                         
END HRM_LICENSE_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRM_LICENSE_G
AS
-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                      OUT TYPES.TCURSOR
                      , W_PERSON_ID                                   IN NUMBER)
  AS
  BEGIN
     OPEN P_CURSOR FOR
        SELECT HL.PERSON_ID
            , HL.LICENSE_ID
            , HRM_COMMON_G.ID_NAME_F(HL.LICENSE_ID) LICENSE_NAME
            , HL.LICENSE_GRADE_ID
            , HRM_COMMON_G.ID_NAME_F(HL.LICENSE_GRADE_ID) LICENSE_GRADE_NAME
            , HL.LICENSE_NO
            , HL.LICENSE_DATE
            , HL.LICENSE_ORG
            , HL.RENEW_DATE
            , HL.DESCRIPTION
        FROM HRM_LICENSE HL
        WHERE HL.PERSON_ID                                = W_PERSON_ID
        ;

  END DATA_SELECT;


-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                                   IN NUMBER
           , P_LICENSE_ID                                  IN NUMBER
           , P_LICENSE_GRADE_ID                            IN NUMBER
           , P_LICENSE_NO                                  IN VARCHAR2
           , P_LICENSE_DATE                                IN DATE
           , P_LICENSE_ORG                                 IN VARCHAR2
           , P_RENEW_DATE                                  IN DATE
           , P_DESCRIPTION                                 IN VARCHAR2
           , P_USER_ID                                     IN NUMBER
           , W_SOB_ID                                      IN NUMBER)
  AS
   D_SYSDATE                                                         DATE;
  
  BEGIN
   D_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
  
  INSERT INTO HRM_LICENSE
  (PERSON_ID, LICENSE_ID, LICENSE_GRADE_ID, LICENSE_NO
  , LICENSE_DATE, LICENSE_ORG, RENEW_DATE
  , DESCRIPTION
  , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
  ) VALUES
  (P_PERSON_ID, P_LICENSE_ID, P_LICENSE_GRADE_ID, P_LICENSE_NO
  , TRUNC(P_LICENSE_DATE), P_LICENSE_ORG, TRUNC(P_RENEW_DATE)
  , P_DESCRIPTION
  , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
  );
      
  END DATA_INSERT;

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_PERSON_ID                                   IN NUMBER
           , W_LICENSE_ID                                  IN NUMBER
           , P_LICENSE_GRADE_ID                            IN NUMBER
           , P_LICENSE_NO                                  IN VARCHAR2
           , P_LICENSE_DATE                                IN DATE
           , P_LICENSE_ORG                                 IN VARCHAR2
           , P_RENEW_DATE                                  IN DATE
           , P_DESCRIPTION                                 IN VARCHAR2
           , P_USER_ID                                     IN NUMBER
           , W_SOB_ID                                      IN NUMBER)
  AS
  BEGIN
  UPDATE HRM_LICENSE HL
   SET HL.LICENSE_GRADE_ID                                       = P_LICENSE_GRADE_ID
      , HL.LICENSE_NO                                         = P_LICENSE_NO
      , HL.LICENSE_DATE                                       = TRUNC(P_LICENSE_DATE)
      , HL.LICENSE_ORG                                        = P_LICENSE_ORG
      , HL.RENEW_DATE                                         = TRUNC(P_RENEW_DATE)
      , HL.DESCRIPTION                                        = P_DESCRIPTION
      , HL.LAST_UPDATE_DATE                                   = GET_LOCAL_DATE(W_SOB_ID)
      , HL.LAST_UPDATED_BY                                    = P_USER_ID
  WHERE HL.PERSON_ID                                              = W_PERSON_ID
   AND HL.LICENSE_ID                                             = W_LICENSE_ID
  ;

  END DATA_UPDATE;

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_PERSON_ID                                   IN NUMBER
                      , W_LICENSE_ID                                  IN NUMBER)
  AS
  BEGIN
    DELETE HRM_LICENSE HL
    WHERE HL.PERSON_ID                                              = W_PERSON_ID
     AND HL.LICENSE_ID                                             = W_LICENSE_ID
    ;
  END DATA_DELETE;


-- 자격사항조회.
  PROCEDURE SELECT_LICENSE(P_CURSOR            OUT TYPES.TCURSOR
                         , W_CORP_ID           IN  NUMBER
                         , W_START_DATE        IN  DATE
                         , W_END_DATE          IN  DATE
                         , W_DEPT_ID           IN  NUMBER
                         , W_FLOOR_ID          IN  NUMBER
                         , W_POST_ID           IN  NUMBER
                         , W_PERSON_ID         IN  NUMBER
                         , W_EMPLOYE_YN        IN  VARCHAR2
                         , W_SOB_ID            IN  NUMBER
                         , W_ORG_ID            IN  NUMBER)
                         
  AS
  BEGIN
    OPEN P_CURSOR FOR
    SELECT HL.PERSON_ID
         , HPM.PERSON_NUM
         , HPM.NAME
         , HL.LICENSE_ID
         , HL.LICENSE_GRADE_ID
         , HRM_COMMON_G.ID_NAME_F(HL.LICENSE_ID) LICENSE_NAME
         , HRM_COMMON_G.ID_NAME_F(HL.LICENSE_GRADE_ID) LICENSE_GRADE_NAME
         , HL.LICENSE_NO
         , HL.LICENSE_DATE
         , HL.LICENSE_ORG
         , HL.RENEW_DATE
         , HL.DESCRIPTION
      FROM HRM_LICENSE HL
         , HRM_PERSON_MASTER HPM
     WHERE HL.PERSON_ID                          = HPM.PERSON_ID
       AND HPM.CORP_ID                           = W_CORP_ID
       AND HL.PERSON_ID                          = NVL(W_PERSON_ID, HL.PERSON_ID)
       AND HPM.POST_ID                           = NVL(W_POST_ID, HPM.POST_ID)
       AND HPM.FLOOR_ID                          = NVL(W_FLOOR_ID, HPM.FLOOR_ID )
       AND HPM.DEPT_ID                           = NVL(W_DEPT_ID, HPM.DEPT_ID) 
       AND HPM.EMPLOYE_TYPE                      = DECODE(W_EMPLOYE_YN,'Y','1',HPM.EMPLOYE_TYPE)
       AND HPM.SOB_ID                            = W_SOB_ID
       AND HPM.ORG_ID                            = W_ORG_ID
       AND HL.LICENSE_DATE                       >= W_START_DATE
       AND HL.LICENSE_DATE                       <= W_END_DATE
     ORDER BY HPM.PERSON_NUM, HL.LICENSE_DATE
     ;
  END SELECT_LICENSE;
  
  
END HRM_LICENSE_G;
/
