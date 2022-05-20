CREATE OR REPLACE PACKAGE HRM_FOREIGN_LANGUAGE_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                      OUT TYPES.TCURSOR
                      , W_PERSON_ID                                   IN NUMBER);

-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                                   IN NUMBER
           , P_EXAM_DATE                                   IN DATE
           , P_EXAM_ID                                     IN NUMBER
           , P_EXAM_ORG_NAME                               IN VARCHAR2
           , P_LC                                          IN NUMBER
           , P_WC                                          IN NUMBER
           , P_RC                                          IN NUMBER
           , P_SC                                          IN NUMBER
           , P_DESCRIPTION                                 IN VARCHAR2
           , P_USER_ID                                     IN NUMBER
           , W_SOB_ID                                      IN NUMBER
           , O_SCORE                                       OUT NUMBER);

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_PERSON_ID                                   IN NUMBER
           , W_EXAM_DATE                                   IN DATE
           , P_EXAM_ID                                     IN NUMBER
           , P_EXAM_ORG_NAME                               IN VARCHAR2
           , P_LC                                          IN NUMBER
           , P_WC                                          IN NUMBER
           , P_RC                                          IN NUMBER
           , P_SC                                          IN NUMBER
           , P_DESCRIPTION                                 IN VARCHAR2
           , P_USER_ID                                     IN NUMBER
           , W_SOB_ID                                      IN NUMBER
           , O_SCORE                                       OUT NUMBER);

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_PERSON_ID                                   IN NUMBER
                      , W_EXAM_DATE                                   IN DATE);


-- PRINT DATA_SELECT.
  PROCEDURE PRINT_FOREIGN_LANGUAGE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );
                     
             
-- 어학사항조회.
  PROCEDURE SELECT_FOREIGN_LANGUAGE(P_CURSOR            OUT TYPES.TCURSOR
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
                                  
END HRM_FOREIGN_LANGUAGE_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRM_FOREIGN_LANGUAGE_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                      OUT TYPES.TCURSOR
                      , W_PERSON_ID                                   IN NUMBER)
  AS
  BEGIN
     OPEN P_CURSOR FOR
        SELECT FL.PERSON_ID
            , FL.EXAM_DATE
            , FL.EXAM_ID
            , HRM_COMMON_G.ID_NAME_F(FL.EXAM_ID) EXAM_NAME
            , FL.EXAM_ORG_NAME
            , FL.LC
            , FL.WC
            , FL.RC
            , FL.SC
            , FL.SCORE
            , FL.DESCRIPTION
        FROM HRM_FOREIGN_LANGUAGE FL
        WHERE FL.PERSON_ID                                            = W_PERSON_ID
        ;

  END DATA_SELECT;


-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                                   IN NUMBER
           , P_EXAM_DATE                                   IN DATE
           , P_EXAM_ID                                     IN NUMBER
           , P_EXAM_ORG_NAME                               IN VARCHAR2
           , P_LC                                          IN NUMBER
           , P_WC                                          IN NUMBER
           , P_RC                                          IN NUMBER
           , P_SC                                          IN NUMBER
           , P_DESCRIPTION                                 IN VARCHAR2
           , P_USER_ID                                     IN NUMBER
           , W_SOB_ID                                      IN NUMBER
           , O_SCORE                                       OUT NUMBER)
  AS
   D_SYSDATE                                                         DATE;
  V_SCORE                                                           HRM_FOREIGN_LANGUAGE.SCORE%TYPE := 0;
  
  BEGIN
   D_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
  V_SCORE := NVL(P_LC, 0) + NVL(P_WC, 0) + NVL(P_RC, 0) + NVL(P_SC, 0);
  
  INSERT INTO HRM_FOREIGN_LANGUAGE
  (PERSON_ID, EXAM_DATE, EXAM_ID, EXAM_ORG_NAME
  , LC, WC, RC, SC, SCORE
  , DESCRIPTION
  , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
  ) VALUES
  (P_PERSON_ID, TRUNC(P_EXAM_DATE), P_EXAM_ID, P_EXAM_ORG_NAME
  , P_LC, P_WC, P_RC, P_SC, V_SCORE
  , P_DESCRIPTION
  , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
  );
  O_SCORE := V_SCORE;
  
  END DATA_INSERT;

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_PERSON_ID                                   IN NUMBER
           , W_EXAM_DATE                                   IN DATE
           , P_EXAM_ID                                     IN NUMBER
           , P_EXAM_ORG_NAME                               IN VARCHAR2
           , P_LC                                          IN NUMBER
           , P_WC                                          IN NUMBER
           , P_RC                                          IN NUMBER
           , P_SC                                          IN NUMBER
           , P_DESCRIPTION                                 IN VARCHAR2
           , P_USER_ID                                     IN NUMBER
           , W_SOB_ID                                      IN NUMBER
           , O_SCORE                                       OUT NUMBER)
  AS
   V_SCORE                                                           HRM_FOREIGN_LANGUAGE.SCORE%TYPE := 0;
  
  BEGIN
   V_SCORE := NVL(P_LC, 0) + NVL(P_WC, 0) + NVL(P_RC, 0) + NVL(P_SC, 0);
  
  UPDATE HRM_FOREIGN_LANGUAGE FL
   SET FL.EXAM_ID                                                = P_EXAM_ID
      , FL.EXAM_ORG_NAME                                      = P_EXAM_ORG_NAME
      , FL.LC                                                 = P_LC
      , FL.WC                                                 = P_WC
      , FL.RC                                                 = P_RC
      , FL.SC                                                 = P_SC
      , FL.SCORE                                              = V_SCORE
      , FL.DESCRIPTION                                        = P_DESCRIPTION
      , FL.LAST_UPDATE_DATE                                   = GET_LOCAL_DATE(W_SOB_ID)
      , FL.LAST_UPDATED_BY                                    = P_USER_ID
  WHERE FL.PERSON_ID                                              = W_PERSON_ID
   AND FL.EXAM_DATE                                              = TRUNC(W_EXAM_DATE)
  ;
    O_SCORE := V_SCORE;
  
  END DATA_UPDATE;

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_PERSON_ID                                   IN NUMBER
                      , W_EXAM_DATE                                   IN DATE)
  AS
  BEGIN
    DELETE HRM_FOREIGN_LANGUAGE FL
    WHERE FL.PERSON_ID                                              = W_PERSON_ID
     AND FL.EXAM_DATE                                              = TRUNC(W_EXAM_DATE)
    ;

  END DATA_DELETE;


-- PRINT DATA_SELECT.
  PROCEDURE PRINT_FOREIGN_LANGUAGE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT  SX1.PERSON_ID
            , TO_CHAR(SX1.EXAM_DATE, 'YYYY-MM-DD') AS EXAM_DATE
            , SX1.EXAM_ID
            , SX1.EXAM_NAME
            , SX1.EXAM_ORG_NAME
            , SX1.LC
            , SX1.WC
            , SX1.RC
            , SX1.SC
            , SX1.SCORE
            , SX1.DESCRIPTION
        FROM (SELECT  FL.PERSON_ID
                    , FL.EXAM_DATE
                    , FL.EXAM_ID
                    , HRM_COMMON_G.ID_NAME_F(FL.EXAM_ID) EXAM_NAME
                    , FL.EXAM_ORG_NAME
                    , FL.LC
                    , FL.WC
                    , FL.RC
                    , FL.SC
                    , FL.SCORE
                    , FL.DESCRIPTION
                FROM HRM_FOREIGN_LANGUAGE FL
              WHERE FL.PERSON_ID          = W_PERSON_ID
              ORDER BY FL.EXAM_DATE DESC
             ) SX1
       WHERE ROWNUM               <= 4
      ;
  END PRINT_FOREIGN_LANGUAGE;
  
  
-- 어학사항조회.
  PROCEDURE SELECT_FOREIGN_LANGUAGE(P_CURSOR            OUT TYPES.TCURSOR
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
         SELECT HFL.PERSON_ID
              , HPM.PERSON_NUM
              , HPM.NAME
              , HFL.EXAM_DATE
              , HRM_COMMON_G.ID_NAME_F(HFL.LANGUAGE_ID) AS LANGUAGE_NAME  -- 어학 구분.
              , HRM_COMMON_G.ID_NAME_F(HFL.EXAM_ID) AS EXAM_NAME          -- 어학 종류.
              , HFL.EXAM_ORG_NAME  -- 평가 기관.
              , HFL.EXAM_LEVEL     -- 어학 등급.
              , HFL.LC
              , HFL.WC
              , HFL.RC
              , HFL.SC
              , HFL.SCORE
              , HFL.DESCRIPTION
           FROM HRM_FOREIGN_LANGUAGE                        HFL
              , HRM_PERSON_MASTER                           HPM
          WHERE HFL.PERSON_ID                          = HPM.PERSON_ID
            AND HPM.CORP_ID                           = W_CORP_ID
            AND HFL.PERSON_ID                          = NVL(W_PERSON_ID, HFL.PERSON_ID)
            AND HPM.POST_ID                           = NVL(W_POST_ID, HPM.POST_ID)
            AND HPM.FLOOR_ID                          = NVL(W_FLOOR_ID, HPM.FLOOR_ID )
            AND HPM.DEPT_ID                           = NVL(W_DEPT_ID, HPM.DEPT_ID) 
            AND HPM.EMPLOYE_TYPE                      = DECODE(W_EMPLOYE_YN,'Y','1',HPM.EMPLOYE_TYPE)
            AND HPM.SOB_ID                            = W_SOB_ID
            AND HPM.ORG_ID                            = W_ORG_ID
            AND HFL.EXAM_DATE                         >= W_START_DATE
            AND HFL.EXAM_DATE                         <= W_END_DATE
          ORDER BY HPM.PERSON_NUM, HFL.EXAM_DATE
          ;         
  END SELECT_FOREIGN_LANGUAGE;
  
  
END HRM_FOREIGN_LANGUAGE_G;
/
