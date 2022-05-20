CREATE OR REPLACE PACKAGE HRM_REFERENCE_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                      OUT TYPES.TCURSOR
                     , W_PERSON_ID                                   IN NUMBER
                     , W_SOB_ID                                      IN NUMBER
                     , W_ORG_ID                                      IN NUMBER);

-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                                   IN NUMBER
           , P_REFERENCE_TYPE                              IN VARCHAR2
           , P_INSUR_NAME                                  IN VARCHAR2
           , P_INSUR_NUM                                   IN VARCHAR2
           , P_INSUR_START_DATE                            IN DATE
           , P_INSUR_END_DATE                              IN DATE
           , P_INSUR_AMOUNT                                IN NUMBER
           , P_GUAR_NAME1                                  IN VARCHAR2
           , P_GUAR_REPRE_NUM1                             IN VARCHAR2
           , P_GUAR_RELATION_ID1                           IN NUMBER
           , P_GUAR_TEL1                                   IN VARCHAR2
           , P_GUAR_ZIP_CODE1                              IN VARCHAR2
           , P_GUAR_ADDR1_1                                IN VARCHAR2
           , P_GUAR_ADDR1_2                                IN VARCHAR2
           , P_GUAR_NAME2                                  IN VARCHAR2
           , P_GUAR_REPRE_NUM2                             IN VARCHAR2
           , P_GUAR_RELATION_ID2                           IN NUMBER
           , P_GUAR_TEL2                                   IN VARCHAR2
           , P_GUAR_ZIP_CODE2                              IN VARCHAR2
           , P_GUAR_ADDR2_1                                IN VARCHAR2
           , P_GUAR_ADDR2_2                                IN VARCHAR2
           , P_DESCRIPTION                                 IN VARCHAR2
           , P_USER_ID                                     IN NUMBER
           , W_SOB_ID                                      IN NUMBER);

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_PERSON_ID                                   IN NUMBER
           , P_REFERENCE_TYPE                              IN VARCHAR2
           , P_INSUR_NAME                                  IN VARCHAR2
           , P_INSUR_NUM                                   IN VARCHAR2
           , P_INSUR_START_DATE                            IN DATE
           , P_INSUR_END_DATE                              IN DATE
           , P_INSUR_AMOUNT                                IN NUMBER
           , P_GUAR_NAME1                                  IN VARCHAR2
           , P_GUAR_REPRE_NUM1                             IN VARCHAR2
           , P_GUAR_RELATION_ID1                           IN NUMBER
           , P_GUAR_TEL1                                   IN VARCHAR2
           , P_GUAR_ZIP_CODE1                              IN VARCHAR2
           , P_GUAR_ADDR1_1                                IN VARCHAR2
           , P_GUAR_ADDR1_2                                IN VARCHAR2
           , P_GUAR_NAME2                                  IN VARCHAR2
           , P_GUAR_REPRE_NUM2                             IN VARCHAR2
           , P_GUAR_RELATION_ID2                           IN NUMBER
           , P_GUAR_TEL2                                   IN VARCHAR2
           , P_GUAR_ZIP_CODE2                              IN VARCHAR2
           , P_GUAR_ADDR2_1                                IN VARCHAR2
           , P_GUAR_ADDR2_2                                IN VARCHAR2
           , P_DESCRIPTION                                 IN VARCHAR2
           , P_USER_ID                                     IN NUMBER
           , W_SOB_ID                                      IN NUMBER);

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_PERSON_ID                                   IN NUMBER);

END HRM_REFERENCE_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRM_REFERENCE_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                      OUT TYPES.TCURSOR
                      , W_PERSON_ID                                   IN NUMBER
           , W_SOB_ID                                      IN NUMBER
           , W_ORG_ID                                      IN NUMBER)
  AS
  BEGIN
     OPEN P_CURSOR FOR
        SELECT HR.PERSON_ID
            , HR.REFERENCE_TYPE
      , HRM_COMMON_G.CODE_NAME_F('REFERENCE_TYPE', HR.REFERENCE_TYPE, W_SOB_ID, W_ORG_ID) AS REFERENCE_TYPE_NAME 
            , HR.INSUR_NAME
            , HR.INSUR_NUM
            , HR.INSUR_START_DATE
            , HR.INSUR_END_DATE
            , HR.INSUR_AMOUNT
            , HR.GUAR_NAME1
            , HR.GUAR_REPRE_NUM1
            , HR.GUAR_RELATION_ID1
            , HRM_COMMON_G.ID_NAME_F(HR.GUAR_RELATION_ID1) GUAR_RELATION_NAME1
            , HR.GUAR_TEL1
            , HR.GUAR_ZIP_CODE1
            , HR.GUAR_ADDR1_1
            , HR.GUAR_ADDR1_2
            , HR.GUAR_NAME2
            , HR.GUAR_REPRE_NUM2
            , HR.GUAR_RELATION_ID2
            , HRM_COMMON_G.ID_NAME_F(HR.GUAR_RELATION_ID2) GUAR_RELATION_NAME2
            , HR.GUAR_TEL2
            , HR.GUAR_ZIP_CODE2
            , HR.GUAR_ADDR2_1
            , HR.GUAR_ADDR2_2
            , HR.DESCRIPTION
        FROM HRM_REFERENCE HR
        WHERE HR.PERSON_ID                                 = W_PERSON_ID
        ;
        
  END DATA_SELECT;


-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                                   IN NUMBER
           , P_REFERENCE_TYPE                              IN VARCHAR2
           , P_INSUR_NAME                                  IN VARCHAR2
           , P_INSUR_NUM                                   IN VARCHAR2
           , P_INSUR_START_DATE                            IN DATE
           , P_INSUR_END_DATE                              IN DATE
           , P_INSUR_AMOUNT                                IN NUMBER
           , P_GUAR_NAME1                                  IN VARCHAR2
           , P_GUAR_REPRE_NUM1                             IN VARCHAR2
           , P_GUAR_RELATION_ID1                           IN NUMBER
           , P_GUAR_TEL1                                   IN VARCHAR2
           , P_GUAR_ZIP_CODE1                              IN VARCHAR2
           , P_GUAR_ADDR1_1                                IN VARCHAR2
           , P_GUAR_ADDR1_2                                IN VARCHAR2
           , P_GUAR_NAME2                                  IN VARCHAR2
           , P_GUAR_REPRE_NUM2                             IN VARCHAR2
           , P_GUAR_RELATION_ID2                           IN NUMBER
           , P_GUAR_TEL2                                   IN VARCHAR2
           , P_GUAR_ZIP_CODE2                              IN VARCHAR2
           , P_GUAR_ADDR2_1                                IN VARCHAR2
           , P_GUAR_ADDR2_2                                IN VARCHAR2
           , P_DESCRIPTION                                 IN VARCHAR2
           , P_USER_ID                                     IN NUMBER
           , W_SOB_ID                                      IN NUMBER)
  AS
   D_SYSDATE                                                         DATE;
  
  BEGIN
   D_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);

  INSERT INTO HRM_REFERENCE
  (PERSON_ID, REFERENCE_TYPE
  , INSUR_NAME, INSUR_NUM, INSUR_START_DATE, INSUR_END_DATE, INSUR_AMOUNT
  , GUAR_NAME1, GUAR_REPRE_NUM1
  , GUAR_RELATION_ID1, GUAR_TEL1
  , GUAR_ZIP_CODE1, GUAR_ADDR1_1, GUAR_ADDR1_2
  , GUAR_NAME2, GUAR_REPRE_NUM2
  , GUAR_RELATION_ID2, GUAR_TEL2
  , GUAR_ZIP_CODE2, GUAR_ADDR2_1, GUAR_ADDR2_2
  , DESCRIPTION
  , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
  ) VALUES
  (P_PERSON_ID, P_REFERENCE_TYPE
  , P_INSUR_NAME, P_INSUR_NUM, TRUNC(P_INSUR_START_DATE), TRUNC(P_INSUR_END_DATE), P_INSUR_AMOUNT
  , P_GUAR_NAME1, P_GUAR_REPRE_NUM1
  , P_GUAR_RELATION_ID1, P_GUAR_TEL1
  , P_GUAR_ZIP_CODE1, P_GUAR_ADDR1_1, P_GUAR_ADDR1_2
  , P_GUAR_NAME2, P_GUAR_REPRE_NUM2
  , P_GUAR_RELATION_ID2, P_GUAR_TEL2
  , P_GUAR_ZIP_CODE2, P_GUAR_ADDR2_1, P_GUAR_ADDR2_2
  , P_DESCRIPTION
  , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
  );

  END DATA_INSERT;

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_PERSON_ID                                   IN NUMBER
           , P_REFERENCE_TYPE                              IN VARCHAR2
           , P_INSUR_NAME                                  IN VARCHAR2
           , P_INSUR_NUM                                   IN VARCHAR2
           , P_INSUR_START_DATE                            IN DATE
           , P_INSUR_END_DATE                              IN DATE
           , P_INSUR_AMOUNT                                IN NUMBER
           , P_GUAR_NAME1                                  IN VARCHAR2
           , P_GUAR_REPRE_NUM1                             IN VARCHAR2
           , P_GUAR_RELATION_ID1                           IN NUMBER
           , P_GUAR_TEL1                                   IN VARCHAR2
           , P_GUAR_ZIP_CODE1                              IN VARCHAR2
           , P_GUAR_ADDR1_1                                IN VARCHAR2
           , P_GUAR_ADDR1_2                                IN VARCHAR2
           , P_GUAR_NAME2                                  IN VARCHAR2
           , P_GUAR_REPRE_NUM2                             IN VARCHAR2
           , P_GUAR_RELATION_ID2                           IN NUMBER
           , P_GUAR_TEL2                                   IN VARCHAR2
           , P_GUAR_ZIP_CODE2                              IN VARCHAR2
           , P_GUAR_ADDR2_1                                IN VARCHAR2
           , P_GUAR_ADDR2_2                                IN VARCHAR2
           , P_DESCRIPTION                                 IN VARCHAR2
           , P_USER_ID                                     IN NUMBER
           , W_SOB_ID                                      IN NUMBER)
  AS
  BEGIN
  UPDATE HRM_REFERENCE HR
    SET HR.REFERENCE_TYPE                                       = P_REFERENCE_TYPE
      , HR.INSUR_NAME                                         = P_INSUR_NAME
      , HR.INSUR_NUM                                          = P_INSUR_NUM
      , HR.INSUR_START_DATE                                   = TRUNC(P_INSUR_START_DATE)
      , HR.INSUR_END_DATE                                     = TRUNC(P_INSUR_END_DATE)
      , HR.INSUR_AMOUNT                                       = P_INSUR_AMOUNT
      , HR.GUAR_NAME1                                         = P_GUAR_NAME1
      , HR.GUAR_REPRE_NUM1                                    = P_GUAR_REPRE_NUM1
      , HR.GUAR_RELATION_ID1                                  = P_GUAR_RELATION_ID1
      , HR.GUAR_TEL1                                          = P_GUAR_TEL1
      , HR.GUAR_ZIP_CODE1                                     = P_GUAR_ZIP_CODE1
      , HR.GUAR_ADDR1_1                                       = P_GUAR_ADDR1_1
      , HR.GUAR_ADDR1_2                                       = P_GUAR_ADDR1_2
      , HR.GUAR_NAME2                                         = P_GUAR_NAME2
      , HR.GUAR_REPRE_NUM2                                    = P_GUAR_REPRE_NUM2
      , HR.GUAR_RELATION_ID2                                  = P_GUAR_RELATION_ID2
      , HR.GUAR_TEL2                                          = P_GUAR_TEL2
      , HR.GUAR_ZIP_CODE2                                     = P_GUAR_ZIP_CODE2
      , HR.GUAR_ADDR2_1                                       = P_GUAR_ADDR2_1
      , HR.GUAR_ADDR2_2                                       = P_GUAR_ADDR2_2
      , HR.DESCRIPTION                                        = P_DESCRIPTION
      , HR.LAST_UPDATE_DATE                                   = GET_LOCAL_DATE(W_SOB_ID)
      , HR.LAST_UPDATED_BY                                    = P_USER_ID
  WHERE HR.PERSON_ID                                              = W_PERSON_ID
  ;

  END DATA_UPDATE;

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_PERSON_ID                                   IN NUMBER)
  AS
  BEGIN
      DELETE HRM_REFERENCE HR
      WHERE HR.PERSON_ID                                              = W_PERSON_ID
      ;

  END DATA_DELETE;

END HRM_REFERENCE_G;
/
