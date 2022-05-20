CREATE OR REPLACE PACKAGE HRM_FAMILY_G
AS

-- DATA_SELECT..
  PROCEDURE DATA_SELECT( P_CURSOR                                OUT TYPES.TCURSOR
                       , W_PERSON_ID                             IN NUMBER
                       , W_SOB_ID                                IN NUMBER
                       , W_ORG_ID                                IN NUMBER);

-- DATA_INSERT..
  PROCEDURE DATA_INSERT(P_PERSON_ID                             IN NUMBER
           , P_FAMILY_NAME                           IN VARCHAR2
           , P_RELATION_ID                           IN NUMBER
           , P_REPRE_NUM                             IN VARCHAR2
           , P_BIRTHDAY                              IN DATE
           , P_BIRTHDAY_TYPE                         IN VARCHAR2
           , P_COMPANY_NAME                          IN VARCHAR2
           , P_POST_NAME                             IN VARCHAR2
           , P_END_SCH_ID                            IN NUMBER
           , P_LIVE_YN                               IN VARCHAR2
           , P_MARRY_YN                              IN VARCHAR2
           , P_DEFORM_YN                             IN VARCHAR2
           , P_PAY_YN                                IN VARCHAR2
           , P_TAX_YN                                IN VARCHAR2
           , P_DESCRIPTION                           IN VARCHAR2
           , P_USER_ID                               IN NUMBER
           , W_SOB_ID                                IN NUMBER
           , O_FAMILY_ID                             OUT NUMBER);

-- DATA_UPDATE..
  PROCEDURE DATA_UPDATE(W_FAMILY_ID                             IN NUMBER
           , P_FAMILY_NAME                           IN VARCHAR2
           , P_RELATION_ID                           IN NUMBER
           , P_REPRE_NUM                             IN VARCHAR2
           , P_BIRTHDAY                              IN DATE
           , P_BIRTHDAY_TYPE                         IN VARCHAR2
           , P_COMPANY_NAME                          IN VARCHAR2
           , P_POST_NAME                             IN VARCHAR2
           , P_END_SCH_ID                            IN NUMBER
           , P_LIVE_YN                               IN VARCHAR2
           , P_MARRY_YN                              IN VARCHAR2
           , P_DEFORM_YN                             IN VARCHAR2
           , P_PAY_YN                                IN VARCHAR2
           , P_TAX_YN                                IN VARCHAR2
           , P_DESCRIPTION                           IN VARCHAR2
           , P_USER_ID                               IN NUMBER
           , W_SOB_ID                                IN NUMBER);

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_FAMILY_ID                             IN NUMBER);                                                


-- PRINT DATA_SELECT..
  PROCEDURE PRINT_FAMILY
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER);
                       
                       
-- 가족현황 
  PROCEDURE SELECT_FAMILY_CURRENT( P_CURSOR            OUT TYPES.TCURSOR
                                 , W_CORP_ID           IN  NUMBER
                                 , W_STD_DATE          IN  DATE
                                 , W_DEPT_ID           IN  NUMBER
                                 , W_FLOOR_ID          IN  NUMBER
                                 , W_PERSON_ID         IN  NUMBER
                                 , W_SOB_ID            IN  NUMBER
                                 , W_ORG_ID            IN  NUMBER);
                                 
END HRM_FAMILY_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRM_FAMILY_G
AS

-- DATA_SELECT.
  PROCEDURE DATA_SELECT( P_CURSOR                                OUT TYPES.TCURSOR
                       , W_PERSON_ID                             IN NUMBER
                       , W_SOB_ID                                IN NUMBER
                       , W_ORG_ID                                IN NUMBER)
  AS
  BEGIN  
     OPEN P_CURSOR FOR
        SELECT HF.FAMILY_ID 
            , HF.PERSON_ID
            , HF.FAMILY_NAME
            , HF.RELATION_ID
            , HRM_COMMON_G.ID_NAME_F(HF.RELATION_ID) RELATION_NAME
            , HF.REPRE_NUM
            , HF.BIRTHDAY
            , HF.BIRTHDAY_TYPE
            , HRM_COMMON_G.CODE_NAME_F('BIRTHDAY_TYPE', HF.BIRTHDAY_TYPE, W_SOB_ID, W_ORG_ID) BIRTHDAY_TYPE_NAME
            , HF.COMPANY_NAME
            , HF.POST_NAME
            , HF.END_SCH_ID
            , HRM_COMMON_G.ID_NAME_F(HF.END_SCH_ID) END_SCH_NAME
            , HF.LIVE_YN
            , HF.MARRY_YN
            , HF.DEFORM_YN
            , HF.PAY_YN
            , HF.TAX_YN
            , HF.DESCRIPTION
        FROM HRM_FAMILY HF
        WHERE HF.PERSON_ID                                = W_PERSON_ID
        ORDER BY HF.REPRE_NUM, HF.FAMILY_NAME        
        ;
        
  END DATA_SELECT;

-- DATA_INSERT..
  PROCEDURE DATA_INSERT(P_PERSON_ID                             IN NUMBER
           , P_FAMILY_NAME                           IN VARCHAR2
           , P_RELATION_ID                           IN NUMBER
           , P_REPRE_NUM                             IN VARCHAR2
           , P_BIRTHDAY                              IN DATE
           , P_BIRTHDAY_TYPE                         IN VARCHAR2
           , P_COMPANY_NAME                          IN VARCHAR2
           , P_POST_NAME                             IN VARCHAR2
           , P_END_SCH_ID                            IN NUMBER
           , P_LIVE_YN                               IN VARCHAR2
           , P_MARRY_YN                              IN VARCHAR2
           , P_DEFORM_YN                             IN VARCHAR2
           , P_PAY_YN                                IN VARCHAR2
           , P_TAX_YN                                IN VARCHAR2
           , P_DESCRIPTION                           IN VARCHAR2
           , P_USER_ID                               IN NUMBER
           , W_SOB_ID                                IN NUMBER
           , O_FAMILY_ID                             OUT NUMBER)
  AS
    N_FAMILY_ID                                                 NUMBER := 0;
    D_SYSDATE                                                   DATE;
  
  BEGIN
   D_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
  
  BEGIN
   SELECT HRM_FAMILY_S1.NEXTVAL
    INTO N_FAMILY_ID
   FROM DUAL;
  EXCEPTION WHEN OTHERS THEN
   N_FAMILY_ID := -1;
   RETURN;      
  END;
      
  INSERT INTO HRM_FAMILY
   ( FAMILY_ID, PERSON_ID, FAMILY_NAME, RELATION_ID
   , REPRE_NUM, BIRTHDAY, BIRTHDAY_TYPE
   , COMPANY_NAME, POST_NAME, END_SCH_ID
   , LIVE_YN, MARRY_YN, DEFORM_YN, PAY_YN, TAX_YN
   , DESCRIPTION
   , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
   ) VALUES
   ( N_FAMILY_ID, P_PERSON_ID, P_FAMILY_NAME, P_RELATION_ID
   , P_REPRE_NUM, TRUNC(P_BIRTHDAY), P_BIRTHDAY_TYPE
   , P_COMPANY_NAME, P_POST_NAME, P_END_SCH_ID
   , P_LIVE_YN, P_MARRY_YN, P_DEFORM_YN, P_PAY_YN, P_TAX_YN
   , P_DESCRIPTION
   , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
   );
        
   O_FAMILY_ID := N_FAMILY_ID;
        
  END DATA_INSERT;

-- DATA_UPDATE..
  PROCEDURE DATA_UPDATE( W_FAMILY_ID                             IN NUMBER
                       , P_FAMILY_NAME                           IN VARCHAR2
                       , P_RELATION_ID                           IN NUMBER
                       , P_REPRE_NUM                             IN VARCHAR2
                       , P_BIRTHDAY                              IN DATE
                       , P_BIRTHDAY_TYPE                         IN VARCHAR2
                       , P_COMPANY_NAME                          IN VARCHAR2
                       , P_POST_NAME                             IN VARCHAR2
                       , P_END_SCH_ID                            IN NUMBER
                       , P_LIVE_YN                               IN VARCHAR2
                       , P_MARRY_YN                              IN VARCHAR2
                       , P_DEFORM_YN                             IN VARCHAR2
                       , P_PAY_YN                                IN VARCHAR2
                       , P_TAX_YN                                IN VARCHAR2
                       , P_DESCRIPTION                           IN VARCHAR2
                       , P_USER_ID                               IN NUMBER
                       , W_SOB_ID                                IN NUMBER
                       )
  AS
  BEGIN
    UPDATE HRM_FAMILY HF
      SET HF.FAMILY_NAME              = P_FAMILY_NAME
        , HF.RELATION_ID              = P_RELATION_ID
        , HF.REPRE_NUM                = P_REPRE_NUM
        , HF.BIRTHDAY                 = TRUNC(P_BIRTHDAY)
        , HF.BIRTHDAY_TYPE            = P_BIRTHDAY_TYPE
        , HF.COMPANY_NAME             = P_COMPANY_NAME
        , HF.POST_NAME                = P_POST_NAME
        , HF.END_SCH_ID               = P_END_SCH_ID
        , HF.LIVE_YN                  = P_LIVE_YN
        , HF.MARRY_YN                 = P_MARRY_YN
        , HF.DEFORM_YN                = P_DEFORM_YN
        , HF.PAY_YN                   = P_PAY_YN
        , HF.TAX_YN                   = P_TAX_YN
        , HF.DESCRIPTION              = P_DESCRIPTION
        , HF.LAST_UPDATE_DATE         = GET_LOCAL_DATE(W_SOB_ID)
        , HF.LAST_UPDATED_BY          = P_USER_ID
    WHERE HF.FAMILY_ID                = W_FAMILY_ID
    ;
    
    -- 부양가족 성명 변경시 연말정산 부양가족 이름 변경 -- 
    UPDATE HRA_SUPPORT_FAMILY SF
       SET SF.FAMILY_NAME         = P_FAMILY_NAME 
     WHERE SF.REPRE_NUM           = ENCRYPT_F(P_REPRE_NUM) 
       AND SF.SOB_ID              = W_SOB_ID
       AND EXISTS
             ( SELECT 'X'
                 FROM HRM_FAMILY HF
                WHERE HF.PERSON_ID  = SF.PERSON_ID
                  AND HF.FAMILY_ID  = W_FAMILY_ID
             ) 
    ;
  END DATA_UPDATE;

-- DATA_DELETE..
  PROCEDURE DATA_DELETE(W_FAMILY_ID                             IN NUMBER)
  AS
  BEGIN
    DELETE HRM_FAMILY HF
    WHERE HF.FAMILY_ID                                        = W_FAMILY_ID
    ;
  END DATA_DELETE;


-- PRINT DATA_SELECT..
  PROCEDURE PRINT_FAMILY
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER)
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT  SX1.PERSON_ID
            , SX1.FAMILY_NAME
            , SX1.RELATION_NAME
            , SX1.REPRE_NUM
            , SX1.BIRTHDAY
            , SX1.BIRTHDAY_TYPE_NAME
            , SX1.COMPANY_NAME
            , SX1.POST_NAME
            , SX1.END_SCH_NAME
            , SX1.LIVE_YN
            , SX1.MARRY_YN
            , SX1.DEFORM_YN
            , SX1.PAY_YN
            , SX1.TAX_YN
            , SX1.DESCRIPTION
        FROM ( SELECT HF.FAMILY_ID 
                    , HF.PERSON_ID
                    , HF.FAMILY_NAME
                    , HF.RELATION_ID
                    , HR.RELATION_NAME AS RELATION_NAME
                    , HF.REPRE_NUM
                    , TO_CHAR(HF.BIRTHDAY, 'YYYY-MM-DD') AS BIRTHDAY
                    , HF.BIRTHDAY_TYPE
                    , HRM_COMMON_G.CODE_NAME_F('BIRTHDAY_TYPE', HF.BIRTHDAY_TYPE, W_SOB_ID, W_ORG_ID) AS BIRTHDAY_TYPE_NAME
                    , HF.COMPANY_NAME
                    , HF.POST_NAME
                    , HF.END_SCH_ID
                    , HRM_COMMON_G.ID_NAME_F(HF.END_SCH_ID) END_SCH_NAME
                    , HF.LIVE_YN
                    , HF.MARRY_YN
                    , HF.DEFORM_YN
                    , HF.PAY_YN
                    , HF.TAX_YN
                    , HF.DESCRIPTION
                FROM HRM_FAMILY     HF
                   , HRM_RELATION_V HR
              WHERE HF.RELATION_ID        = HR.RELATION_ID
                AND HF.PERSON_ID          = W_PERSON_ID
              ORDER BY HR.SORT_NUM, HR.RELATION_CODE, HF.REPRE_NUM, HF.FAMILY_NAME        
             ) SX1
     WHERE ROWNUM                 <= 7
        ;
  END PRINT_FAMILY;
  
-- 가족현황 
  PROCEDURE SELECT_FAMILY_CURRENT( P_CURSOR            OUT TYPES.TCURSOR
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
           SELECT  HPM.PERSON_NUM
                  ,HPM.NAME
                  ,HF.PERSON_ID
                  ,HF.FAMILY_NAME
                  ,HF.RELATION_ID
                  ,HRM_COMMON_G.ID_NAME_F(HF.RELATION_ID) RELATION_NAME
                  ,HF.REPRE_NUM
                  ,HF.BIRTHDAY
                  ,HF.BIRTHDAY_TYPE
                  ,HRM_COMMON_G.CODE_NAME_F('BIRTHDAY_TYPE', HF.BIRTHDAY_TYPE, HPM.SOB_ID, HPM.ORG_ID) BIRTHDAY_TYPE_NAME
                  ,HF.COMPANY_NAME
                  ,HF.POST_NAME
                  ,HF.END_SCH_ID
                  ,HRM_COMMON_G.ID_NAME_F(HF.END_SCH_ID) END_SCH_NAME
                  ,HRM_COMMON_G.CODE_NAME_F('NATIONALITY_TYPE', CASE WHEN SUBSTR(HF.REPRE_NUM,8,1) IN('5', '6', '7', '8') THEN '9' ELSE '1' END, HPM.SOB_ID, HPM.ORG_ID) NATIONALITY_TYPE_NAME
                  ,HF.LIVE_YN
                  ,HF.DEFORM_YN
                  ,HF.PAY_YN
                  ,HF.TAX_YN
                  ,HF.DESCRIPTION
             FROM  HRM_PERSON_MASTER HPM
                  ,HRM_FAMILY        HF
                  ,HRM_RELATION_V    HRV
            WHERE  HPM.PERSON_ID   = HF.PERSON_ID
               AND HF.RELATION_ID  = HRV.RELATION_ID
               AND HPM.CORP_ID     = W_CORP_ID
               AND HPM.DEPT_ID     = NVL(W_DEPT_ID, HPM.DEPT_ID)
               AND ((W_FLOOR_ID   IS NULL AND 1 = 1)
               OR   (W_FLOOR_ID   IS NOT NULL AND HPM.FLOOR_ID = W_FLOOR_ID))
               AND HPM.SOB_ID      = W_SOB_ID
               AND HPM.ORG_ID      = W_ORG_ID
               AND HF.PERSON_ID    = NVL(W_PERSON_ID, HF.PERSON_ID)
               AND HPM.JOIN_DATE    <= W_STD_DATE
               AND (HPM.RETIRE_DATE >= W_STD_DATE OR HPM.RETIRE_DATE IS NULL)
            ORDER BY HPM.PERSON_NUM, HRV.RELATION_CODE, HF.BIRTHDAY
            ;   
 END SELECT_FAMILY_CURRENT;
 
 
END HRM_FAMILY_G;
/
