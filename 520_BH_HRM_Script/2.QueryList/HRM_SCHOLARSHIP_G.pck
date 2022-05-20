CREATE OR REPLACE PACKAGE HRM_SCHOLARSHIP_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                  OUT TYPES.TCURSOR
                      , W_PERSON_ID                               IN NUMBER);

-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                               IN NUMBER
           , P_SCHOLARSHIP_TYPE_ID                     IN NUMBER
           , P_GRADUATION_TYPE_ID                      IN NUMBER
           , P_ADMISSION_YYYYMM                        IN VARCHAR2
           , P_GRADUATION_YYYYMM                       IN VARCHAR2
           , P_SCHOOL_NAME                             IN VARCHAR2
           , P_SPECIAL_STUDY_NAME                      IN VARCHAR2
           , P_SUB_STUDY_NAME                          IN VARCHAR2
           , P_DEGREE_ID                               IN NUMBER
           , P_DESCRIPTION                             IN VARCHAR2
           , P_USER_ID                                 IN NUMBER
           , W_SOB_ID                                  IN NUMBER
           , O_SCHOLARSHIP_ID                          OUT NUMBER);

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_SCHOLARSHIP_ID                          IN NUMBER
           , P_SCHOLARSHIP_TYPE_ID                     IN NUMBER
           , P_GRADUATION_TYPE_ID                      IN NUMBER
           , P_ADMISSION_YYYYMM                        IN VARCHAR2
           , P_GRADUATION_YYYYMM                       IN VARCHAR2
           , P_SCHOOL_NAME                             IN VARCHAR2
           , P_SPECIAL_STUDY_NAME                      IN VARCHAR2
           , P_SUB_STUDY_NAME                          IN VARCHAR2
           , P_DEGREE_ID                               IN NUMBER
           , P_DESCRIPTION                             IN VARCHAR2
           , P_USER_ID                                 IN NUMBER
           , W_SOB_ID                                  IN NUMBER);

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_SCHOLARSHIP_ID                          IN NUMBER);


-- PRINT DATA_SELECT.
  PROCEDURE PRINT_SCHOLARSHIP
            ( P_CURSOR              OUT TYPES.TCURSOR
            , W_PERSON_ID           IN  NUMBER
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            );
                      
-- 학력조회
  PROCEDURE SELECT_SCHOLARSHIP(P_CURSOR                           OUT TYPES.TCURSOR
                             , W_PERSON_ID                        IN NUMBER
                             , W_CORP_ID                          IN  NUMBER
                             , W_DEPT_ID                          IN  NUMBER
                             , W_EMPLOYE_TYPE                     IN VARCHAR2
                             , W_SOB_ID                           IN NUMBER
                             , W_ORG_ID                           IN NUMBER
                             );
                             
END HRM_SCHOLARSHIP_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRM_SCHOLARSHIP_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                  OUT TYPES.TCURSOR
                      , W_PERSON_ID                               IN NUMBER)
  AS
  BEGIN
     OPEN P_CURSOR FOR
        SELECT HS.SCHOLARSHIP_ID
            , HS.PERSON_ID
            , HS.SCHOLARSHIP_TYPE_ID
            , HRM_COMMON_G.ID_NAME_F(HS.SCHOLARSHIP_TYPE_ID) SCHOLARSHIP_TYPE_NAME
            , HS.GRADUATION_TYPE_ID
            , HRM_COMMON_G.ID_NAME_F(HS.GRADUATION_TYPE_ID) GRADUATION_TYPE_NAME
            , TO_CHAR(HS.ADMISSION_DATE, 'YYYY-MM') AS ADMISSION_YYYYMM
            , TO_CHAR(HS.GRADUATION_DATE, 'YYYY-MM') AS GRADUATION_YYYYMM
            , HS.SCHOOL_NAME
            , HS.SPECIAL_STUDY_NAME
            , HS.SUB_STUDY_NAME
            , HS.DEGREE_ID
            , HRM_COMMON_G.ID_NAME_F(HS.DEGREE_ID) DEGREE_NAME
            , HS.DESCRIPTION
        FROM HRM_SCHOLARSHIP HS
        WHERE HS.PERSON_ID                                = W_PERSON_ID
        ;

  END DATA_SELECT;


-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                               IN NUMBER
           , P_SCHOLARSHIP_TYPE_ID                     IN NUMBER
           , P_GRADUATION_TYPE_ID                      IN NUMBER
           , P_ADMISSION_YYYYMM                        IN VARCHAR2
           , P_GRADUATION_YYYYMM                       IN VARCHAR2
           , P_SCHOOL_NAME                             IN VARCHAR2
           , P_SPECIAL_STUDY_NAME                      IN VARCHAR2
           , P_SUB_STUDY_NAME                          IN VARCHAR2
           , P_DEGREE_ID                               IN NUMBER
           , P_DESCRIPTION                             IN VARCHAR2
           , P_USER_ID                                 IN NUMBER
           , W_SOB_ID                                  IN NUMBER
           , O_SCHOLARSHIP_ID                          OUT NUMBER)
  AS
   D_SYSDATE                                                     DATE;
    N_SCHOLARSHIP_ID                                              NUMBER;
    
  BEGIN
   D_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
  SELECT HRM_SCHOLARSHIP_S1.NEXTVAL
   INTO N_SCHOLARSHIP_ID
  FROM DUAL;
    
  INSERT INTO HRM_SCHOLARSHIP
  ( SCHOLARSHIP_ID
  , PERSON_ID, SCHOLARSHIP_TYPE_ID, GRADUATION_TYPE_ID
  , ADMISSION_DATE, GRADUATION_DATE, SCHOOL_NAME
  , SPECIAL_STUDY_NAME, SUB_STUDY_NAME, DEGREE_ID
  , DESCRIPTION
  , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
  ) VALUES
  ( N_SCHOLARSHIP_ID
  , P_PERSON_ID, P_SCHOLARSHIP_TYPE_ID, P_GRADUATION_TYPE_ID
  , TO_DATE(P_ADMISSION_YYYYMM, 'YYYY-MM'), TO_DATE(P_GRADUATION_YYYYMM, 'YYYY-MM'), P_SCHOOL_NAME
  , P_SPECIAL_STUDY_NAME, P_SUB_STUDY_NAME, P_DEGREE_ID
  , P_DESCRIPTION
  , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
  );
      
  O_SCHOLARSHIP_ID := N_SCHOLARSHIP_ID;
      
  END DATA_INSERT;

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_SCHOLARSHIP_ID                          IN NUMBER
           , P_SCHOLARSHIP_TYPE_ID                     IN NUMBER
           , P_GRADUATION_TYPE_ID                      IN NUMBER
           , P_ADMISSION_YYYYMM                        IN VARCHAR2
           , P_GRADUATION_YYYYMM                       IN VARCHAR2
           , P_SCHOOL_NAME                             IN VARCHAR2
           , P_SPECIAL_STUDY_NAME                      IN VARCHAR2
           , P_SUB_STUDY_NAME                          IN VARCHAR2
           , P_DEGREE_ID                               IN NUMBER
           , P_DESCRIPTION                             IN VARCHAR2
           , P_USER_ID                                 IN NUMBER
           , W_SOB_ID                                  IN NUMBER)
  AS
  BEGIN
    UPDATE HRM_SCHOLARSHIP HS
      SET HS.SCHOLARSHIP_TYPE_ID                                = P_SCHOLARSHIP_TYPE_ID
            , HS.GRADUATION_TYPE_ID                             = P_GRADUATION_TYPE_ID
            , HS.ADMISSION_DATE                                 = TO_DATE(P_ADMISSION_YYYYMM, 'YYYY-MM')
            , HS.GRADUATION_DATE                                = TO_DATE(P_GRADUATION_YYYYMM, 'YYYY-MM')
            , HS.SCHOOL_NAME                                    = P_SCHOOL_NAME
            , HS.SPECIAL_STUDY_NAME                             = P_SPECIAL_STUDY_NAME
            , HS.SUB_STUDY_NAME                                 = P_SUB_STUDY_NAME
            , HS.DEGREE_ID                                      = P_DEGREE_ID
            , HS.DESCRIPTION                                    = P_DESCRIPTION
            , HS.LAST_UPDATE_DATE                               = GET_LOCAL_DATE(W_SOB_ID)
            , HS.LAST_UPDATED_BY                                = P_USER_ID
    WHERE HS.SCHOLARSHIP_ID                                     = W_SCHOLARSHIP_ID
    ;

  END DATA_UPDATE;

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_SCHOLARSHIP_ID                          IN NUMBER)
  AS
  BEGIN
    DELETE HRM_SCHOLARSHIP HS
    WHERE HS.SCHOLARSHIP_ID                                     = W_SCHOLARSHIP_ID
    ;

  END DATA_DELETE;


-- PRINT DATA_SELECT.
  PROCEDURE PRINT_SCHOLARSHIP
            ( P_CURSOR              OUT TYPES.TCURSOR
            , W_PERSON_ID           IN  NUMBER
            , W_SOB_ID              IN  NUMBER
            , W_ORG_ID              IN  NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT SX1.SCHOLARSHIP_ID
          , SX1.PERSON_ID
          , SX1.SCHOLARSHIP_TYPE_ID
          , SX1.SCHOLARSHIP_TYPE_NAME
          , SX1.GRADUATION_TYPE_ID
          , SX1.GRADUATION_TYPE_NAME
          , SX1.ADMISSION_YYYYMM
          , SX1.GRADUATION_YYYYMM
          , SX1.SCHOOL_NAME
          , SX1.SPECIAL_STUDY_NAME
          , SX1.SUB_STUDY_NAME
          , SX1.DEGREE_ID
          , SX1.DEGREE_NAME
          , SX1.DESCRIPTION
        FROM ( SELECT HS.SCHOLARSHIP_ID
                    , HS.PERSON_ID
                    , HS.SCHOLARSHIP_TYPE_ID
                    , HRM_COMMON_G.ID_NAME_F(HS.SCHOLARSHIP_TYPE_ID) SCHOLARSHIP_TYPE_NAME
                    , HS.GRADUATION_TYPE_ID
                    , HRM_COMMON_G.ID_NAME_F(HS.GRADUATION_TYPE_ID) GRADUATION_TYPE_NAME
                    , TO_CHAR(HS.ADMISSION_DATE, 'YYYY-MM') AS ADMISSION_YYYYMM
                    , TO_CHAR(HS.GRADUATION_DATE, 'YYYY-MM') AS GRADUATION_YYYYMM
                    , HS.SCHOOL_NAME
                    , HS.SPECIAL_STUDY_NAME
                    , HS.SUB_STUDY_NAME
                    , HS.DEGREE_ID
                    , HRM_COMMON_G.ID_NAME_F(HS.DEGREE_ID) DEGREE_NAME
                    , HS.DESCRIPTION
                FROM HRM_SCHOLARSHIP HS
               WHERE HS.PERSON_ID          = W_PERSON_ID
               ORDER BY HS.GRADUATION_DATE DESC
             ) SX1
      WHERE ROWNUM <= 4
      ;
  END PRINT_SCHOLARSHIP;
  
  
-- 학력조회
  PROCEDURE SELECT_SCHOLARSHIP(P_CURSOR                           OUT TYPES.TCURSOR
                             , W_PERSON_ID                        IN NUMBER
                             , W_CORP_ID                          IN  NUMBER
                             , W_DEPT_ID                          IN  NUMBER
                             , W_EMPLOYE_TYPE                     IN VARCHAR2
                             , W_SOB_ID                           IN NUMBER
                             , W_ORG_ID                           IN NUMBER
                             )
   AS
   BEGIN
     OPEN P_CURSOR FOR
       SELECT HPM.PERSON_NUM
             ,HPM.NAME
             ,HPM.PERSON_ID
             ,HS.SCHOLARSHIP_ID
             ,HRM_COMMON_G.ID_NAME_F(HS.SCHOLARSHIP_TYPE_ID) SCHOLARSHIP_TYPE_NAME
             ,HS.SCHOLARSHIP_TYPE_ID
             ,HS.GRADUATION_TYPE_ID
             ,HRM_COMMON_G.ID_NAME_F(HS.GRADUATION_TYPE_ID) GRADUATION_TYPE_NAME
             ,TO_CHAR(HS.ADMISSION_DATE, 'YYYY-MM') AS ADMISSION_YYYYMM
            -- ,HS.ADMISSION_DATE
             ,TO_CHAR(HS.GRADUATION_DATE, 'YYYY-MM') AS GRADUATION_YYYYMM
             --,HS.GRADUATION_DATE
             ,HS.SCHOOL_NAME
             ,HS.SPECIAL_STUDY_NAME
             ,HS.SUB_STUDY_NAME
             ,HS.DEGREE_ID               
             ,HRM_COMMON_G.ID_NAME_F(HS.DEGREE_ID) DEGREE_NAME
             ,HS.DESCRIPTION
       FROM  HRM_PERSON_MASTER HPM
            ,HRM_SCHOLARSHIP HS
       WHERE HPM.PERSON_ID                         = HS.PERSON_ID 
         AND HPM.PERSON_ID                         = NVL(W_PERSON_ID, HPM.PERSON_ID)
         AND HPM.CORP_ID                           = W_CORP_ID
         AND HPM.DEPT_ID                           = NVL(W_DEPT_ID, HPM.DEPT_ID)
         AND HPM.EMPLOYE_TYPE                      = NVL(W_EMPLOYE_TYPE, EMPLOYE_TYPE)
         AND HPM.SOB_ID                            = W_SOB_ID
         AND HPM.ORG_ID                            = W_ORG_ID
       ORDER BY HPM.PERSON_ID, HS.SCHOLARSHIP_TYPE_ID
       ;
  END SELECT_SCHOLARSHIP;
  
END HRM_SCHOLARSHIP_G;
/
