CREATE OR REPLACE PACKAGE HRR_RETIREMENT_PENSION_G
AS

-- ÅðÁ÷¿¬±Ý°èÁÂÁ¶È¸.
  PROCEDURE SELECT_RETIREMENT_PENSION
            (  P_CURSOR                           OUT TYPES.TCURSOR
             , W_PERSON_ID                        IN NUMBER
             , W_CORP_ID                          IN NUMBER
             , W_DEPT_ID                          IN NUMBER
             , W_FLOOR_ID                         IN NUMBER
             , W_SOB_ID                           IN NUMBER
             , W_ORG_ID                           IN NUMBER
             );
                             
-- ÅðÁ÷¿¬±Ý°èÁÂ INSERT.
  PROCEDURE INSERT_RETIREMENT_PENSION
            ( O_RETIREMENT_PENSION_ID   OUT HRR_RETIREMENT_PENSION.RETIREMENT_PENSION_ID%TYPE
            , P_PERSON_ID               IN  HRR_RETIREMENT_PENSION.PERSON_ID%TYPE
            , P_SIGN_UP_DATE            IN  HRR_RETIREMENT_PENSION.SIGN_UP_DATE%TYPE 
            , P_YEAR_BANK_ID            IN  HRR_RETIREMENT_PENSION.YEAR_BANK_ID%TYPE
            , P_ACCOUNT_NUM             IN  HRR_RETIREMENT_PENSION.ACCOUNT_NUM%TYPE
            , P_ISSUE_DATE              IN  HRR_RETIREMENT_PENSION.ISSUE_DATE%TYPE
            , P_DUE_DATE                IN  HRR_RETIREMENT_PENSION.DUE_DATE%TYPE
            , P_SOB_ID                  IN  HRR_RETIREMENT_PENSION.SOB_ID%TYPE
            , P_ORG_ID                  IN  HRR_RETIREMENT_PENSION.ORG_ID%TYPE
            , P_USER_ID                 IN  HRR_RETIREMENT_PENSION.CREATED_BY%TYPE
            );
            
-- ÅðÁ÷¿¬±Ý°èÁÂ UDPATE.
  PROCEDURE UPDATE_RETIREMENT_PENSION
            ( W_RETIREMENT_PENSION_ID   IN  HRR_RETIREMENT_PENSION.RETIREMENT_PENSION_ID%TYPE
            , P_PERSON_ID               IN  HRR_RETIREMENT_PENSION.PERSON_ID%TYPE
            , P_SIGN_UP_DATE            IN  HRR_RETIREMENT_PENSION.SIGN_UP_DATE%TYPE 
            , P_YEAR_BANK_ID            IN  HRR_RETIREMENT_PENSION.YEAR_BANK_ID%TYPE
            , P_ACCOUNT_NUM             IN  HRR_RETIREMENT_PENSION.ACCOUNT_NUM%TYPE
            , P_ISSUE_DATE              IN  HRR_RETIREMENT_PENSION.ISSUE_DATE%TYPE
            , P_DUE_DATE                IN  HRR_RETIREMENT_PENSION.DUE_DATE%TYPE
            , P_SOB_ID                  IN  HRR_RETIREMENT_PENSION.SOB_ID%TYPE
            , P_ORG_ID                  IN  HRR_RETIREMENT_PENSION.ORG_ID%TYPE
            , P_USER_ID                 IN  HRR_RETIREMENT_PENSION.CREATED_BY%TYPE
            );
            
-- ÅðÁ÷¿¬±Ý°èÁÂ DELETE.
  PROCEDURE DELETE_RETIREMENT_PENSION
            ( W_RETIREMENT_PENSION_ID   IN HRR_RETIREMENT_PENSION.RETIREMENT_PENSION_ID%TYPE
            , P_SOB_ID                  IN HRR_RETIREMENT_PENSION.SOB_ID%TYPE
            , P_ORG_ID                  IN HRR_RETIREMENT_PENSION.ORG_ID%TYPE
            , P_USER_ID                 IN HRR_RETIREMENT_PENSION.CREATED_BY%TYPE
            );


-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_NAME                              IN VARCHAR2
            , W_DEPT_ID                           IN NUMBER
            , W_POST_ID                           IN NUMBER
            , W_FLOOR_ID                          IN NUMBER
            , W_EMPLOYE_TYPE                      IN VARCHAR2 DEFAULT NULL
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );
            
                        
END HRR_RETIREMENT_PENSION_G;
/
CREATE OR REPLACE PACKAGE BODY HRR_RETIREMENT_PENSION_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRR_RETIREMENT_PENSION_G
/* DESCRIPTION  : ÅðÁ÷¿¬±Ý °èÁÂ°ü¸®.
/* REFERENCE BY :
/* PROGRAM HISTORY : ½Å±Ô »ý¼º
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  1SSANG             INITIALIZE
/******************************************************************************/
-- ÅðÁ÷¿¬±Ý°èÁÂÁ¶È¸.
  PROCEDURE SELECT_RETIREMENT_PENSION
            (  P_CURSOR                           OUT TYPES.TCURSOR
             , W_PERSON_ID                        IN NUMBER
             , W_CORP_ID                          IN NUMBER
             , W_DEPT_ID                          IN NUMBER
             , W_FLOOR_ID                         IN NUMBER
             , W_SOB_ID                           IN NUMBER
             , W_ORG_ID                           IN NUMBER
             )
   AS
   BEGIN
     OPEN P_CURSOR FOR
       SELECT HRP.RETIREMENT_PENSION_ID
             , HPM.NAME
             , HRP.PERSON_ID
             , HPM.PERSON_NUM
             , HRM_DEPT_MASTER_G.DEPT_NAME_F(HPM.DEPT_ID) AS DEPT_NAME
             , HRM_COMMON_G.ID_NAME_F(HPM.FLOOR_ID) AS FLOOR_NAME
             , HRP.SIGN_UP_DATE 
             , HRP.CORP_NAME AS CORP_NAME
             , HRP.TAX_REG_NUM AS TAX_REG_NUM
             , HRP.YEAR_BANK_ID
             , HRP.ACCOUNT_NUM
             , HRP.ISSUE_DATE
             , HRP.DUE_DATE
             , HPM.JOIN_DATE
             , HPM.RETIRE_DATE
         FROM HRR_RETIREMENT_PENSION_V HRP
            , HRM_PERSON_MASTER        HPM            
        WHERE HRP.PERSON_ID           = HPM.PERSON_ID
          AND HRP.PERSON_ID           = NVL(W_PERSON_ID, HRP.PERSON_ID)
          AND HPM.CORP_ID             = W_CORP_ID
          AND HPM.DEPT_ID             = NVL(W_DEPT_ID, HPM.DEPT_ID)
          AND HPM.FLOOR_ID            = NVL(W_FLOOR_ID, HPM.FLOOR_ID) 
          AND HRP.SOB_ID              = W_SOB_ID
          AND HRP.ORG_ID              = W_ORG_ID
          ;          
  END SELECT_RETIREMENT_PENSION;

-- ÅðÁ÷¿¬±Ý°èÁÂ INSERT.
  PROCEDURE INSERT_RETIREMENT_PENSION
            ( O_RETIREMENT_PENSION_ID   OUT HRR_RETIREMENT_PENSION.RETIREMENT_PENSION_ID%TYPE
            , P_PERSON_ID               IN  HRR_RETIREMENT_PENSION.PERSON_ID%TYPE
            , P_SIGN_UP_DATE            IN  HRR_RETIREMENT_PENSION.SIGN_UP_DATE%TYPE 
            , P_YEAR_BANK_ID            IN  HRR_RETIREMENT_PENSION.YEAR_BANK_ID%TYPE
            , P_ACCOUNT_NUM             IN  HRR_RETIREMENT_PENSION.ACCOUNT_NUM%TYPE
            , P_ISSUE_DATE              IN  HRR_RETIREMENT_PENSION.ISSUE_DATE%TYPE
            , P_DUE_DATE                IN  HRR_RETIREMENT_PENSION.DUE_DATE%TYPE
            , P_SOB_ID                  IN  HRR_RETIREMENT_PENSION.SOB_ID%TYPE
            , P_ORG_ID                  IN  HRR_RETIREMENT_PENSION.ORG_ID%TYPE
            , P_USER_ID                 IN  HRR_RETIREMENT_PENSION.CREATED_BY%TYPE
            )
  AS
    D_SYSDATE                          DATE;
    V_RECORD_COUNT                     NUMBER;
  BEGIN
    D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
     -- ±âÁ¸ ÀÚ·á¼ö Ã¼Å©.
   BEGIN
      SELECT COUNT(HRP.PERSON_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRR_RETIREMENT_PENSION HRP
      WHERE HRP.PERSON_ID          = P_PERSON_ID
        AND HRP.SOB_ID             = P_SOB_ID
        AND HRP.ORG_ID             = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10257', NULL));
      RETURN;
    END IF;
    
    -- ÀºÇàÁ¤º¸ °ËÁõ --
    V_RECORD_COUNT := 0;
    BEGIN
      SELECT COUNT(HC.COMMON_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRM_COMMON HC
       WHERE HC.GROUP_CODE      = 'YEAR_BANK'
         AND HC.SOB_ID          = P_SOB_ID
         AND HC.ORG_ID          = P_ORG_ID
         AND HC.COMMON_ID       = P_YEAR_BANK_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;   
    END;
    IF V_RECORD_COUNT < 1 OR V_RECORD_COUNT > 1 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Bank Info : ' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10054', NULL));
      RETURN;
    END IF;
           
    SELECT HRR_RETIREMENT_PENSION_S1.NEXTVAL
      INTO O_RETIREMENT_PENSION_ID
    FROM DUAL;

    INSERT INTO HRR_RETIREMENT_PENSION
    ( RETIREMENT_PENSION_ID
    , PERSON_ID
    , SIGN_UP_DATE 
    , YEAR_BANK_ID
    , ACCOUNT_NUM
    , ISSUE_DATE
    , DUE_DATE
    , SOB_ID
    , ORG_ID
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY
    ) VALUES
    ( O_RETIREMENT_PENSION_ID
    , P_PERSON_ID
    , P_SIGN_UP_DATE 
    , P_YEAR_BANK_ID
    , P_ACCOUNT_NUM
    , P_ISSUE_DATE
    , P_DUE_DATE
    , P_SOB_ID
    , P_ORG_ID
    , D_SYSDATE
    , P_USER_ID
    , D_SYSDATE
    , P_USER_ID
    );
  END INSERT_RETIREMENT_PENSION;

-- ÅðÁ÷¿¬±Ý°èÁÂ UDPATE.
  PROCEDURE UPDATE_RETIREMENT_PENSION
            ( W_RETIREMENT_PENSION_ID   IN  HRR_RETIREMENT_PENSION.RETIREMENT_PENSION_ID%TYPE
            , P_PERSON_ID               IN  HRR_RETIREMENT_PENSION.PERSON_ID%TYPE
            , P_SIGN_UP_DATE            IN  HRR_RETIREMENT_PENSION.SIGN_UP_DATE%TYPE 
            , P_YEAR_BANK_ID            IN  HRR_RETIREMENT_PENSION.YEAR_BANK_ID%TYPE
            , P_ACCOUNT_NUM             IN  HRR_RETIREMENT_PENSION.ACCOUNT_NUM%TYPE
            , P_ISSUE_DATE              IN  HRR_RETIREMENT_PENSION.ISSUE_DATE%TYPE
            , P_DUE_DATE                IN  HRR_RETIREMENT_PENSION.DUE_DATE%TYPE
            , P_SOB_ID                  IN  HRR_RETIREMENT_PENSION.SOB_ID%TYPE
            , P_ORG_ID                  IN  HRR_RETIREMENT_PENSION.ORG_ID%TYPE
            , P_USER_ID                 IN  HRR_RETIREMENT_PENSION.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    /*-- »ç¾÷ÀÚ¹øÈ£ °ËÁõ --
    IF EAPP_NUM_DIGIT_CHECKER_G.CHECK_TAX_NUM_F(P_TAX_REG_NUM) = 'N' THEN
      RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10009', NULL));
      RETURN;
    END IF;*/
    
    UPDATE HRR_RETIREMENT_PENSION
      SET SIGN_UP_DATE            = P_SIGN_UP_DATE  
        , YEAR_BANK_ID            = P_YEAR_BANK_ID
        , ACCOUNT_NUM             = P_ACCOUNT_NUM
        , ISSUE_DATE              = P_ISSUE_DATE
        , DUE_DATE                = P_DUE_DATE
        , LAST_UPDATE_DATE        = V_SYSDATE
        , LAST_UPDATED_BY         = P_USER_ID
    WHERE RETIREMENT_PENSION_ID   = W_RETIREMENT_PENSION_ID
    ;
  END UPDATE_RETIREMENT_PENSION;

-- ÅðÁ÷¿¬±Ý°èÁÂ DELETE.
  PROCEDURE DELETE_RETIREMENT_PENSION
            ( W_RETIREMENT_PENSION_ID   IN HRR_RETIREMENT_PENSION.RETIREMENT_PENSION_ID%TYPE
            , P_SOB_ID                  IN HRR_RETIREMENT_PENSION.SOB_ID%TYPE
            , P_ORG_ID                  IN HRR_RETIREMENT_PENSION.ORG_ID%TYPE
            , P_USER_ID                 IN HRR_RETIREMENT_PENSION.CREATED_BY%TYPE
            )
  AS
  BEGIN
    DELETE HRR_RETIREMENT_PENSION
    WHERE RETIREMENT_PENSION_ID = W_RETIREMENT_PENSION_ID
    ;
  END DELETE_RETIREMENT_PENSION;    



-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_NAME                              IN VARCHAR2
            , W_DEPT_ID                           IN NUMBER
            , W_POST_ID                           IN NUMBER
            , W_FLOOR_ID                          IN NUMBER
            , W_EMPLOYE_TYPE                      IN VARCHAR2 DEFAULT NULL
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            )
  AS
    V_SYSDATE           DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT PM.NAME AS NAME
          , PM.PERSON_NUM
          , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID) AS CORP_NAME
          , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.FLOOR_ID) AS FLOOR_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME  
          , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
          , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
          , PM.ORI_JOIN_DATE
          , PM.JOIN_DATE
          , PM.RETIRE_DATE
          , CASE
              WHEN ADD_MONTHS(PM.JOIN_DATE, 12) < TO_DATE('2012-01-01', 'YYYY-MM-DD') THEN TO_DATE('2012-01-01', 'YYYY-MM-DD')
              ELSE ADD_MONTHS(PM.JOIN_DATE, 12) 
            END AS SIGN_UP_DATE            
          , PM.PERSON_ID
          , PM.CORP_ID
          , PM.DEPT_ID
          , T1.FLOOR_ID
          , PM.POST_ID
          , PM.PAY_GRADE_ID
      FROM HRM_PERSON_MASTER PM
        , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
            SELECT  HL.PERSON_ID
                  , HL.DEPT_ID
                  , HL.POST_ID
                  , HL.PAY_GRADE_ID
                  , HL.JOB_CATEGORY_ID
                  , HL.FLOOR_ID    
              FROM HRM_HISTORY_HEADER HH
                 , HRM_HISTORY_LINE   HL 
            WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
              AND HH.CHARGE_SEQ           IN 
                    (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                        FROM HRM_HISTORY_HEADER S_HH
                           , HRM_HISTORY_LINE   S_HL
                       WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                         AND S_HH.CHARGE_DATE       <= V_SYSDATE
                         AND S_HL.PERSON_ID         = HL.PERSON_ID
                       GROUP BY S_HL.PERSON_ID
                     )  
          ) T1
      WHERE PM.PERSON_ID              = T1.PERSON_ID
        AND ((W_CORP_ID               IS NULL AND 1 = 1)
        OR   (W_CORP_ID               IS NOT NULL AND PM.CORP_ID = W_CORP_ID)) 
        AND ((W_NAME                  IS NULL AND 1 = 1)
        OR   (W_NAME                  IS NOT NULL AND PM.NAME = W_NAME)) 
        AND PM.SOB_ID                 = W_SOB_ID
        AND PM.ORG_ID                 = W_ORG_ID
        AND ((W_EMPLOYE_TYPE          IS NULL AND 1 = 1)
        OR   (W_EMPLOYE_TYPE          IS NOT NULL AND PM.EMPLOYE_TYPE = W_EMPLOYE_TYPE))
        AND ((W_DEPT_ID               IS NULL AND 1 = 1)
        OR   (W_DEPT_ID               IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
        AND ((W_FLOOR_ID              IS NULL AND 1 = 1)
        OR   (W_FLOOR_ID              IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
        AND ((W_POST_ID               IS NULL AND 1 = 1)
        OR   (W_POST_ID               IS NOT NULL AND T1.POST_ID = W_POST_ID))
      ORDER BY PM.PERSON_NUM
      ;
  END LU_PERSON;
          
END HRR_RETIREMENT_PENSION_G; 
/
