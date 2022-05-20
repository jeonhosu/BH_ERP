CREATE OR REPLACE PACKAGE HRM_EDUCATION_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                OUT TYPES.TCURSOR
                      , W_PERSON_ID                             IN NUMBER);

-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                             IN NUMBER
           , P_START_DATE                            IN DATE
           , P_END_DATE                              IN DATE
           , P_EDU_ORG                               IN VARCHAR2
           , P_EDU_CURRICULUM                        IN VARCHAR2
           , P_EDU_PAY_AMOUNT                        IN NUMBER
           , P_EDU_PAY_RETURN_AMOUNT                 IN NUMBER
           , P_DESCRIPTION                           IN VARCHAR2
           , P_USER_ID                               IN NUMBER
           , W_SOB_ID                                IN NUMBER
           , O_EDUCATION_ID                          OUT NUMBER);

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_EDUCATION_ID                          IN NUMBER
           , P_START_DATE                            IN DATE
           , P_END_DATE                              IN DATE
           , P_EDU_ORG                               IN VARCHAR2
           , P_EDU_CURRICULUM                        IN VARCHAR2
           , P_EDU_PAY_AMOUNT                        IN NUMBER
           , P_EDU_PAY_RETURN_AMOUNT                 IN NUMBER
           , P_DESCRIPTION                           IN VARCHAR2
           , P_USER_ID                               IN NUMBER
           , W_SOB_ID                                IN NUMBER);

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_EDUCATION_ID                          IN NUMBER);


-- PRINT DATA_SELECT.
  PROCEDURE PRINT_EDUCATION
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );
                      
                      
-- 사원별교육현황(사원) 
  PROCEDURE SELECT_EDU_PERSON(P_CURSOR            OUT TYPES.TCURSOR
                            , W_CORP_ID           IN  NUMBER
                            , W_STD_DATE          IN DATE
                            , W_DEPT_ID           IN  NUMBER
                            , W_FLOOR_ID          IN  NUMBER
                            , W_POST_ID           IN  NUMBER
                            , W_PERSON_ID         IN  NUMBER
                            , W_SOB_ID            IN  NUMBER
                            , W_ORG_ID            IN  NUMBER);

-- 사원별교육현황(교육)
   PROCEDURE SELECT_PERSON_EDUCATION(P_CURSOR            OUT TYPES.TCURSOR
                                   , W_PERSON_ID         IN  NUMBER                               
                                     );
  
-- 교육별사원현황 
  PROCEDURE SELECT_EDUCATION_CURRENT(P_CURSOR            OUT TYPES.TCURSOR
                                   , W_CORP_ID           IN  NUMBER
                                   , W_START_DATE        IN  DATE
                                   , W_END_DATE          IN  DATE
                                   , W_DEPT_ID           IN  NUMBER
                                   , W_FLOOR_ID          IN  NUMBER
                                   , W_POST_ID           IN  NUMBER
                                   , W_PERSON_ID         IN  NUMBER
                                   , W_COMPLETED_YN      IN  VARCHAR2
                                   , W_SOB_ID            IN  NUMBER
                                   , W_ORG_ID            IN  NUMBER);

-----------------------------------------------------
-- 교육현황관리 : EXCEL UPLOAD 조회. [SSH 추가]   --
-----------------------------------------------------
  PROCEDURE EXCEL_EDUCATION_SELECT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            );

----------------------------------------------
-- 교육현황관리 : EXCEL UPLOAD. [SSH 추가]  --
----------------------------------------------
  PROCEDURE EXCEL_EDUCATION_UPLOAD
            ( P_USER_ID               IN  NUMBER 
            , P_PERSON_NUM            IN  VARCHAR2
            , P_START_DATE            IN  DATE
            , P_END_DATE              IN  DATE
            , P_EDU_ORG               IN  VARCHAR2
            , P_EDU_CURRICULUM        IN  VARCHAR2
            , P_EDU_PAY_AMOUNT        IN  NUMBER
            , P_EDU_PAY_RETURN_AMOUNT IN  NUMBER
            , P_COMPLETED_FLAG        IN  VARCHAR2
            , P_DESCRIPTION           IN  VARCHAR2
            , P_SOB_ID                IN  HRM_PERSON_MASTER.SOB_ID%TYPE
            );
                
                                                
END HRM_EDUCATION_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRM_EDUCATION_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT(P_CURSOR                                OUT TYPES.TCURSOR
                      , W_PERSON_ID                             IN NUMBER)
  AS
  BEGIN
     OPEN P_CURSOR FOR
        SELECT HE.EDUCATION_ID
            , HE.PERSON_ID
            , HE.START_DATE
            , HE.END_DATE
            , HE.EDU_ORG
            , HE.EDU_CURRICULUM
            , HE.EDU_PAY_AMOUNT
            , HE.EDU_PAY_RETURN_AMOUNT 
            , HE.DESCRIPTION
        FROM HRM_EDUCATION HE
        WHERE HE.PERSON_ID                                = W_PERSON_ID
        ;

  END DATA_SELECT;


-- DATA_INSERT.
  PROCEDURE DATA_INSERT(P_PERSON_ID                             IN NUMBER
           , P_START_DATE                            IN DATE
           , P_END_DATE                              IN DATE
           , P_EDU_ORG                               IN VARCHAR2
           , P_EDU_CURRICULUM                        IN VARCHAR2
           , P_EDU_PAY_AMOUNT                        IN NUMBER
           , P_EDU_PAY_RETURN_AMOUNT                 IN NUMBER
           , P_DESCRIPTION                           IN VARCHAR2
           , P_USER_ID                               IN NUMBER
           , W_SOB_ID                                IN NUMBER
           , O_EDUCATION_ID                          OUT NUMBER)
  AS
   D_SYSDATE                                                   DATE;
    N_EDUCATION_ID                                              NUMBER := 0;
    
  BEGIN
   D_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
  
  SELECT  HRM_EDUCATION_S1.NEXTVAL
   INTO N_EDUCATION_ID
  FROM DUAL;
      
  INSERT INTO HRM_EDUCATION
  ( EDUCATION_ID
  , PERSON_ID, START_DATE, END_DATE
  , EDU_ORG, EDU_CURRICULUM
  , EDU_PAY_AMOUNT, EDU_PAY_RETURN_AMOUNT 
  , DESCRIPTION
  , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
  ) VALUES
  ( N_EDUCATION_ID
  , P_PERSON_ID, TRUNC(P_START_DATE), TRUNC(P_END_DATE)
  , P_EDU_ORG, P_EDU_CURRICULUM
  , P_EDU_PAY_AMOUNT, P_EDU_PAY_RETURN_AMOUNT 
  , P_DESCRIPTION
  , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
  );
      
  O_EDUCATION_ID := N_EDUCATION_ID;
      
  END DATA_INSERT;

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE(W_EDUCATION_ID                          IN NUMBER
           , P_START_DATE                            IN DATE
           , P_END_DATE                              IN DATE
           , P_EDU_ORG                               IN VARCHAR2
           , P_EDU_CURRICULUM                        IN VARCHAR2
           , P_EDU_PAY_AMOUNT                        IN NUMBER
           , P_EDU_PAY_RETURN_AMOUNT                 IN NUMBER
           , P_DESCRIPTION                           IN VARCHAR2
           , P_USER_ID                               IN NUMBER
           , W_SOB_ID                                IN NUMBER)
  AS
  BEGIN
  UPDATE HRM_EDUCATION HE
   SET HE.START_DATE                                       = TRUNC(P_START_DATE)
      , HE.END_DATE                                     = TRUNC(P_END_DATE)
      , HE.EDU_ORG                                      = P_EDU_ORG
      , HE.EDU_CURRICULUM                               = P_EDU_CURRICULUM
      , HE.EDU_PAY_AMOUNT                               = NVL(P_EDU_PAY_AMOUNT, 0)
      , HE.EDU_PAY_RETURN_AMOUNT                        = NVL(P_EDU_PAY_RETURN_AMOUNT, 0)
      , HE.DESCRIPTION                                  = P_DESCRIPTION
      , HE.LAST_UPDATE_DATE                             = GET_LOCAL_DATE(W_SOB_ID)
      , HE.LAST_UPDATED_BY                              = P_USER_ID
  WHERE HE.EDUCATION_ID                                     = W_EDUCATION_ID
  ;

  END DATA_UPDATE;

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_EDUCATION_ID                          IN NUMBER)
  AS
  BEGIN
    DELETE HRM_EDUCATION HE
    WHERE HE.EDUCATION_ID                                     = W_EDUCATION_ID
    ;

  END DATA_DELETE;


-- PRINT DATA_SELECT.
  PROCEDURE PRINT_EDUCATION
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT  SX1.PERSON_ID
            , TO_CHAR(SX1.START_DATE, 'YYYY-MM-DD') AS START_DATE
            , TO_CHAR(SX1.END_DATE, 'YYYY-MM-DD') AS END_DATE
            , TO_CHAR(SX1.START_DATE, 'YYYY-MM-DD') || '~' ||
                TO_CHAR(SX1.END_DATE, 'YYYY-MM-DD') AS EDUCATION_PERIOD
            , SX1.EDU_ORG
            , SX1.EDU_CURRICULUM
            , TO_CHAR(SX1.EDU_PAY_AMOUNT, 'FM999,999,999,999,999') AS EDU_PAY_AMOUNT
            , TO_CHAR(SX1.EDU_PAY_RETURN_AMOUNT, 'FM999,999,999,999') AS EDU_PAY_RETURN_AMOUNT
            , SX1.DESCRIPTION
        FROM ( SELECT HE.EDUCATION_ID
                    , HE.PERSON_ID
                    , HE.START_DATE
                    , HE.END_DATE
                    , HE.EDU_ORG
                    , HE.EDU_CURRICULUM
                    , HE.EDU_PAY_AMOUNT
                    , HE.EDU_PAY_RETURN_AMOUNT 
                    , HE.DESCRIPTION
                 FROM HRM_EDUCATION HE
                WHERE HE.PERSON_ID        = W_PERSON_ID
                ORDER BY HE.END_DATE DESC
             ) SX1
      WHERE ROWNUM                <= 4
      ;
  END PRINT_EDUCATION;
  
  
-- 사원별교육현황 (사원)
  PROCEDURE SELECT_EDU_PERSON(P_CURSOR            OUT TYPES.TCURSOR
                            , W_CORP_ID           IN  NUMBER
                            , W_STD_DATE          IN DATE
                            , W_DEPT_ID           IN  NUMBER
                            , W_FLOOR_ID          IN  NUMBER
                            , W_POST_ID           IN  NUMBER
                            , W_PERSON_ID         IN  NUMBER
                            , W_SOB_ID            IN  NUMBER
                            , W_ORG_ID            IN  NUMBER)
  AS
  BEGIN
     OPEN P_CURSOR FOR
     SELECT  HPM.PERSON_NUM
            ,HPM.NAME
            ,T1.DEPT_NAME
            ,T1.FLOOR_NAME
            ,T1.POST_NAME
            ,HPM.PERSON_ID
       FROM  HRM_PERSON_MASTER HPM
            ,(-- 시점 인사내역.
               SELECT HL.PERSON_ID
                    , HL.DEPT_ID
                    , HL.POST_ID
                    , HL.PAY_GRADE_ID
                    , HL.JOB_CATEGORY_ID
                    , HL.FLOOR_ID
                    , HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
                    , HRM_COMMON_G.ID_NAME_F(HL.FLOOR_ID) AS FLOOR_NAME
                    , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
                    , HRM_COMMON_G.ID_NAME_F(HL.PAY_GRADE_ID) AS PAY_GRADE_NAME  
                 FROM HRM_HISTORY_LINE HL  
                 WHERE ((W_DEPT_ID         IS NULL AND 1 = 1)
                   OR   (W_DEPT_ID         IS NOT NULL AND HL.DEPT_ID = W_DEPT_ID))
                   AND ((W_FLOOR_ID        IS NULL AND 1 = 1)
                   OR   (W_FLOOR_ID        IS NOT NULL AND HL.FLOOR_ID = W_FLOOR_ID))
                   AND ((W_POST_ID         IS NULL AND 1 = 1)
                   OR   (W_POST_ID         IS NOT NULL AND HL.POST_ID = W_POST_ID))
                   AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                  FROM HRM_HISTORY_LINE S_HL
                                                 WHERE S_HL.CHARGE_DATE             <= W_STD_DATE
                                                   AND S_HL.PERSON_ID              = HL.PERSON_ID
                                                 GROUP BY S_HL.PERSON_ID
                                               )
              ) T1
      WHERE HPM.PERSON_ID   = T1.PERSON_ID 
        AND HPM.CORP_ID     = W_CORP_ID
        AND HPM.SOB_ID      = W_SOB_ID
        AND HPM.ORG_ID      = W_ORG_ID
        AND HPM.PERSON_ID    = NVL(W_PERSON_ID, HPM.PERSON_ID)
        AND HPM.JOIN_DATE             <= W_STD_DATE
        AND (HPM.RETIRE_DATE IS NULL OR HPM.RETIRE_DATE >= W_STD_DATE)
      ORDER BY HPM.PERSON_NUM
      ;     
  END SELECT_EDU_PERSON;    
  
-- 사원별교육현황 (교육)
  PROCEDURE SELECT_PERSON_EDUCATION(P_CURSOR            OUT TYPES.TCURSOR
                                  , W_PERSON_ID         IN  NUMBER                                               
                                    )
  AS
  BEGIN
    OPEN P_CURSOR FOR
    SELECT HE.PERSON_ID
          ,HE.EDUCATION_ID
          ,HE.START_DATE
          ,HE.END_DATE
          ,HE.EDU_ORG
          ,HE.EDU_CURRICULUM
          ,HE.EDU_PAY_AMOUNT
          ,HE.EDU_PAY_RETURN_AMOUNT
          ,HE.DESCRIPTION
    FROM HRM_EDUCATION     HE
    WHERE HE.PERSON_ID    = W_PERSON_ID
    ORDER BY HE.START_DATE
    ;
  END SELECT_PERSON_EDUCATION;
        
  
-- 교육별사원현황 
  PROCEDURE SELECT_EDUCATION_CURRENT(P_CURSOR            OUT TYPES.TCURSOR
                                   , W_CORP_ID           IN  NUMBER
                                   , W_START_DATE        IN  DATE
                                   , W_END_DATE          IN  DATE
                                   , W_DEPT_ID           IN  NUMBER
                                   , W_FLOOR_ID          IN  NUMBER
                                   , W_POST_ID           IN  NUMBER
                                   , W_PERSON_ID         IN  NUMBER
                                   , W_COMPLETED_YN      IN  VARCHAR2
                                   , W_SOB_ID            IN  NUMBER
                                   , W_ORG_ID            IN  NUMBER)
  AS
  BEGIN
     OPEN P_CURSOR FOR
     SELECT  HPM.PERSON_NUM
            ,HPM.NAME
            ,T1.DEPT_NAME
            ,T1.FLOOR_NAME
            ,T1.POST_NAME
            ,T1.JOB_CATEGORY_NAME
            ,HE.PERSON_ID
            ,HE.EDUCATION_ID
            ,HE.START_DATE
            ,HE.END_DATE
            ,HE.EDU_ORG
            ,HE.EDU_CURRICULUM
            ,HE.EDU_PAY_AMOUNT
            ,HE.EDU_PAY_RETURN_AMOUNT
            ,HE.DESCRIPTION
            ,HE.COMPLETED_FLAG
       FROM  HRM_PERSON_MASTER HPM
            ,HRM_EDUCATION     HE
            ,(-- 시점 인사내역.
               SELECT HL.PERSON_ID
                    , HL.DEPT_ID
                    , HL.POST_ID
                    , HL.PAY_GRADE_ID
                    , HL.JOB_CATEGORY_ID
                    , HL.FLOOR_ID
                    , HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
                    , HRM_COMMON_G.ID_NAME_F(HL.FLOOR_ID) AS FLOOR_NAME
                    , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
                    , HRM_COMMON_G.ID_NAME_F(HL.PAY_GRADE_ID) AS PAY_GRADE_NAME  
                    , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                 FROM HRM_HISTORY_LINE HL  
                 WHERE ((W_DEPT_ID         IS NULL AND 1 = 1)
                   OR   (W_DEPT_ID         IS NOT NULL AND HL.DEPT_ID = W_DEPT_ID))
                   AND ((W_FLOOR_ID        IS NULL AND 1 = 1)
                   OR   (W_FLOOR_ID        IS NOT NULL AND HL.FLOOR_ID = W_FLOOR_ID))
                   AND ((W_POST_ID         IS NULL AND 1 = 1)
                   OR   (W_POST_ID         IS NOT NULL AND HL.POST_ID = W_POST_ID))
                   AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                  FROM HRM_HISTORY_LINE S_HL
                                                 WHERE S_HL.CHARGE_DATE             <= W_END_DATE
                                                   AND S_HL.PERSON_ID              = HL.PERSON_ID
                                                 GROUP BY S_HL.PERSON_ID
                                               )
              ) T1
      WHERE HPM.PERSON_ID   = T1.PERSON_ID 
        AND HPM.CORP_ID     = W_CORP_ID
        AND HPM.PERSON_ID   = HE.PERSON_ID
        AND HPM.SOB_ID      = W_SOB_ID
        AND HPM.ORG_ID      = W_ORG_ID
        AND HE.PERSON_ID    = NVL(W_PERSON_ID, HE.PERSON_ID)
        AND HE.END_DATE     >= W_START_DATE
        AND HE.START_DATE   <= W_END_DATE
        AND HE.COMPLETED_FLAG  = DECODE(W_COMPLETED_YN,'Y','1',HE.COMPLETED_FLAG)
      ORDER BY HPM.PERSON_NUM, HE.START_DATE
      ;
 END SELECT_EDUCATION_CURRENT;

-----------------------------------------------------
-- 교육현황관리 : EXCEL UPLOAD 조회. [SSH 추가]   --
-----------------------------------------------------
  PROCEDURE EXCEL_EDUCATION_SELECT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT TO_CHAR(NULL) AS PERSON_NUM
           , TO_CHAR(NULL) AS NAME
           , TO_CHAR(NULL) AS START_DATE
           , TO_CHAR(NULL) AS END_DATE
           , TO_CHAR(NULL) AS EDU_ORG
           , TO_CHAR(NULL) AS EDU_CURRICULUM       
           , TO_CHAR(NULL) AS EDU_PAY_AMOUNT  
           , TO_CHAR(NULL) AS EDU_PAY_RETURN_AMOUNT   
           , TO_CHAR(NULL) AS COMPLETED_FLAG   
           , TO_CHAR(NULL) AS DESCRIPTION   
        FROM DUAL;
  END EXCEL_EDUCATION_SELECT;

----------------------------------------------
-- 교육현황관리 : EXCEL UPLOAD. [SSH 추가]  --
----------------------------------------------  
  PROCEDURE EXCEL_EDUCATION_UPLOAD
            ( P_USER_ID               IN  NUMBER 
            , P_PERSON_NUM            IN  VARCHAR2
            , P_START_DATE            IN  DATE
            , P_END_DATE              IN  DATE
            , P_EDU_ORG               IN  VARCHAR2
            , P_EDU_CURRICULUM        IN  VARCHAR2
            , P_EDU_PAY_AMOUNT        IN  NUMBER
            , P_EDU_PAY_RETURN_AMOUNT IN  NUMBER
            , P_COMPLETED_FLAG        IN  VARCHAR2
            , P_DESCRIPTION           IN  VARCHAR2
            , P_SOB_ID                IN  HRM_PERSON_MASTER.SOB_ID%TYPE
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
    N_EDUCATION_ID      NUMBER := 0;
    P_PERSON_ID         NUMBER := 0;
    
  BEGIN
 
		SELECT  HRM_EDUCATION_S1.NEXTVAL
			INTO  N_EDUCATION_ID
		FROM DUAL;
    
    SELECT HPM.PERSON_ID
      INTO P_PERSON_ID
      FROM HRM_PERSON_MASTER HPM
     WHERE HPM.PERSON_NUM    =  P_PERSON_NUM;
     
     
     
		INSERT INTO HRM_EDUCATION
		( EDUCATION_ID
		, PERSON_ID, START_DATE, END_DATE
		, EDU_ORG, EDU_CURRICULUM
		, EDU_PAY_AMOUNT, EDU_PAY_RETURN_AMOUNT 
		, DESCRIPTION, COMPLETED_FLAG
		, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
		) VALUES
		( N_EDUCATION_ID
		, P_PERSON_ID, TRUNC(P_START_DATE), TRUNC(P_END_DATE)
		, P_EDU_ORG, P_EDU_CURRICULUM
		, P_EDU_PAY_AMOUNT, P_EDU_PAY_RETURN_AMOUNT 
		, P_DESCRIPTION, P_COMPLETED_FLAG
		, V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
		);
 
  END EXCEL_EDUCATION_UPLOAD;
             
   
END HRM_EDUCATION_G;
/
