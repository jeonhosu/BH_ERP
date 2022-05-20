CREATE OR REPLACE PACKAGE FI_BANK_G
AS

-- 은행그룹 조회.
  PROCEDURE SELECT_BANK_GROUP
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_BANK_GROUP_CODE      IN FI_BANK.BANK_CODE%TYPE
            , W_ENABLED_FLAG         IN FI_BANK.ENABLED_FLAG%TYPE
            , W_SOB_ID               IN FI_BANK.SOB_ID%TYPE
            , W_ORG_ID               IN FI_BANK.ORG_ID%TYPE
            );

-- 은행그룹 삽입.
  PROCEDURE INSERT_BANK_GROUP
            ( P_BANK_ID           OUT FI_BANK.BANK_ID%TYPE
            , P_SOB_ID            IN FI_BANK.SOB_ID%TYPE
            , P_ORG_ID            IN FI_BANK.ORG_ID%TYPE
            , P_BANK_CODE         IN FI_BANK.BANK_CODE%TYPE
            , P_BANK_NAME         IN FI_BANK.BANK_NAME%TYPE
            , P_BANK_ENG_NAME     IN FI_BANK.BANK_ENG_NAME%TYPE
            , P_ENABLED_FLAG      IN FI_BANK.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_BANK.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_BANK.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_BANK.CREATED_BY%TYPE
            );

-- 은행그룹 수정.
  PROCEDURE UPDATE_BANK_GROUP
            ( W_BANK_ID           IN FI_BANK.BANK_ID%TYPE
            , P_SOB_ID            IN FI_BANK.SOB_ID%TYPE
            , P_BANK_NAME         IN FI_BANK.BANK_NAME%TYPE
            , P_BANK_ENG_NAME     IN FI_BANK.BANK_ENG_NAME%TYPE
            , P_ENABLED_FLAG      IN FI_BANK.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_BANK.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_BANK.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_BANK.CREATED_BY%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 은행지점 조회.
  PROCEDURE SELECT_BANK_SITE
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_BANK_GROUP_CODE   IN FI_BANK.BANK_GROUP%TYPE
            , W_BANK_ID           IN FI_BANK.BANK_ID%TYPE
            , W_SOB_ID            IN FI_BANK.SOB_ID%TYPE
            , W_ORG_ID            IN FI_BANK.ORG_ID%TYPE
            );
            
-- 은행지점 삽입.
  PROCEDURE INSERT_BANK_SITE
            ( P_BANK_ID           OUT FI_BANK.BANK_ID%TYPE
            , P_SOB_ID            IN FI_BANK.SOB_ID%TYPE
            , P_ORG_ID            IN FI_BANK.ORG_ID%TYPE
            , P_BANK_GROUP        IN FI_BANK.BANK_GROUP%TYPE
            , P_BANK_CODE         IN FI_BANK.BANK_CODE%TYPE
            , P_BANK_NAME         IN FI_BANK.BANK_NAME%TYPE
            , P_BANK_ENG_NAME     IN FI_BANK.BANK_ENG_NAME%TYPE
            , P_BANK_TYPE         IN FI_BANK.BANK_TYPE%TYPE
            , P_VAT_NUMBER        IN FI_BANK.VAT_NUMBER%TYPE
            , P_DC_LIMIT_AMOUNT   IN FI_BANK.DC_LIMIT_AMOUNT%TYPE
            , P_DC_METHOD_ID      IN FI_BANK.DC_METHOD_ID%TYPE
            , P_DC_RATE1          IN FI_BANK.DC_RATE1%TYPE
            , P_DC_RATE2          IN FI_BANK.DC_RATE2%TYPE
            , P_LOAN_LIMIT_AMOUNT IN FI_BANK.LOAN_LIMIT_AMOUNT%TYPE
            , P_START_DATE        IN FI_BANK.START_DATE%TYPE
            , P_REMARK            IN FI_BANK.REMARK%TYPE
            , P_ENABLED_FLAG      IN FI_BANK.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_BANK.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_BANK.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_BANK.CREATED_BY%TYPE
            );
            
-- 은행지점 수정.
  PROCEDURE UPDATE_BANK_SITE
            ( W_BANK_ID           IN FI_BANK.BANK_ID%TYPE
            , P_BANK_NAME         IN FI_BANK.BANK_NAME%TYPE
            , P_BANK_ENG_NAME     IN FI_BANK.BANK_ENG_NAME%TYPE
            , P_BANK_TYPE         IN FI_BANK.BANK_TYPE%TYPE
            , P_VAT_NUMBER        IN FI_BANK.VAT_NUMBER%TYPE
            , P_DC_LIMIT_AMOUNT   IN FI_BANK.DC_LIMIT_AMOUNT%TYPE
            , P_DC_METHOD_ID      IN FI_BANK.DC_METHOD_ID%TYPE
            , P_DC_RATE1          IN FI_BANK.DC_RATE1%TYPE
            , P_DC_RATE2          IN FI_BANK.DC_RATE2%TYPE
            , P_LOAN_LIMIT_AMOUNT IN FI_BANK.LOAN_LIMIT_AMOUNT%TYPE
            , P_START_DATE        IN FI_BANK.START_DATE%TYPE
            , P_REMARK            IN FI_BANK.REMARK%TYPE
            , P_ENABLED_FLAG      IN FI_BANK.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_BANK.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_BANK.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_BANK.CREATED_BY%TYPE
            );

-----------------------------------------------------------------------------------------
-- 은행 명칭 리턴 FUNCTION.
  FUNCTION ID_NAME_F
            ( W_BANK_ID           IN FI_BANK.BANK_ID%TYPE
            ) RETURN VARCHAR2;
  
  PROCEDURE ID_NAME_P
            ( W_BANK_ID           IN FI_BANK.BANK_ID%TYPE
            , O_RETURN_VALUE      OUT VARCHAR2
            );              

  FUNCTION CODE_NAME_F
           ( W_BANK_CODE           IN FI_BANK.BANK_CODE%TYPE
           , W_SOB_ID              IN FI_BANK.SOB_ID%TYPE
           ) RETURN VARCHAR2;

  PROCEDURE CODE_NAME_P
            ( W_BANK_CODE          IN FI_BANK.BANK_CODE%TYPE
            , W_SOB_ID             IN FI_BANK.SOB_ID%TYPE
            , O_RETURN_VALUE       OUT VARCHAR2
            ); 

-----------------------------------------------------------------------------------------
-- 은행그룹 LOOKUP 조회.
  PROCEDURE LU_BANK_GROUP
            ( P_CURSOR3              OUT TYPES.TCURSOR
            , W_SOB_ID               IN FI_BANK.SOB_ID%TYPE
            , W_ORG_ID               IN FI_BANK.ORG_ID%TYPE
            , W_ENABLED_YN           IN FI_BANK.ENABLED_FLAG%TYPE
            );            
            
-- 은행지점 lookup 조회.
  PROCEDURE LU_BANK_SITE
            ( P_CURSOR3              OUT TYPES.TCURSOR
            , W_SOB_ID               IN FI_BANK.SOB_ID%TYPE
            , W_ORG_ID               IN FI_BANK.ORG_ID%TYPE
            , W_ENABLED_YN           IN FI_BANK.ENABLED_FLAG%TYPE
            );
            
END FI_BANK_G;
/
CREATE OR REPLACE PACKAGE BODY FI_BANK_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_BANK_G
/* Description  : 금융기관(은행)관리 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 은행그룹 조회.
  PROCEDURE SELECT_BANK_GROUP
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_BANK_GROUP_CODE      IN FI_BANK.BANK_CODE%TYPE
            , W_ENABLED_FLAG         IN FI_BANK.ENABLED_FLAG%TYPE
            , W_SOB_ID               IN FI_BANK.SOB_ID%TYPE
            , W_ORG_ID               IN FI_BANK.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT FB.BANK_ID
           , FB.BANK_CODE
           , FB.BANK_NAME
           , FB.BANK_ENG_NAME
           , FB.ENABLED_FLAG
           , FB.EFFECTIVE_DATE_FR
           , FB.EFFECTIVE_DATE_TO
        FROM FI_BANK FB
       WHERE FB.BANK_GROUP              = '-'
         AND FB.SOB_ID                  = W_SOB_ID
/*         AND FB.ORG_ID                  = W_ORG_ID*/
         AND FB.BANK_CODE               = NVL(W_BANK_GROUP_CODE, FB.BANK_CODE)
      ORDER BY FB.BANK_CODE
      ;
      
  END SELECT_BANK_GROUP;

-- 은행그룹 삽입.
  PROCEDURE INSERT_BANK_GROUP
            ( P_BANK_ID           OUT FI_BANK.BANK_ID%TYPE
            , P_SOB_ID            IN FI_BANK.SOB_ID%TYPE
            , P_ORG_ID            IN FI_BANK.ORG_ID%TYPE
            , P_BANK_CODE         IN FI_BANK.BANK_CODE%TYPE
            , P_BANK_NAME         IN FI_BANK.BANK_NAME%TYPE
            , P_BANK_ENG_NAME     IN FI_BANK.BANK_ENG_NAME%TYPE
            , P_ENABLED_FLAG      IN FI_BANK.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_BANK.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_BANK.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_BANK.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE   DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT NUMBER := 0;
    
  BEGIN
    -- 동일한 은행 그룹코드 존재 체크.
    BEGIN
      SELECT COUNT(FB.BANK_CODE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BANK FB
       WHERE FB.SOB_ID            = P_SOB_ID
/*         AND FB.ORG_ID            = P_ORG_ID*/
         AND FB.BANK_GROUP        = '-'
         AND FB.BANK_CODE         = P_BANK_CODE
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;
    
    SELECT FI_BANK_S1.NEXTVAL
     INTO P_BANK_ID
     FROM DUAL;

    INSERT INTO FI_BANK
    ( BANK_ID
    , SOB_ID 
    , ORG_ID 
    , BANK_GROUP 
    , BANK_CODE 
    , BANK_NAME 
    , BANK_ENG_NAME 
    , ENABLED_FLAG 
    , EFFECTIVE_DATE_FR 
    , EFFECTIVE_DATE_TO 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_BANK_ID
    , P_SOB_ID
    , P_ORG_ID
    , '-'
    , P_BANK_CODE
    , P_BANK_NAME
    , P_BANK_ENG_NAME
    , P_ENABLED_FLAG
    , P_EFFECTIVE_DATE_FR
    , P_EFFECTIVE_DATE_TO
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  
  EXCEPTION 
    WHEN ERRNUMS.Exist_Data THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END INSERT_BANK_GROUP;

-- 은행그룹 수정.
  PROCEDURE UPDATE_BANK_GROUP
            ( W_BANK_ID           IN FI_BANK.BANK_ID%TYPE
            , P_SOB_ID            IN FI_BANK.SOB_ID%TYPE
            , P_BANK_NAME         IN FI_BANK.BANK_NAME%TYPE
            , P_BANK_ENG_NAME     IN FI_BANK.BANK_ENG_NAME%TYPE
            , P_ENABLED_FLAG      IN FI_BANK.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_BANK.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_BANK.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_BANK.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN

    UPDATE FI_BANK
      SET BANK_NAME         = P_BANK_NAME
        , BANK_ENG_NAME     = P_BANK_ENG_NAME
        , ENABLED_FLAG      = P_ENABLED_FLAG
        , EFFECTIVE_DATE_FR = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO = P_EFFECTIVE_DATE_TO
        , LAST_UPDATE_DATE  = V_SYSDATE
        , LAST_UPDATED_BY   = P_USER_ID
    WHERE BANK_ID           = W_BANK_ID
    ;
      
  END UPDATE_BANK_GROUP;

---------------------------------------------------------------------------------------------------
-- 은행지점 조회.
  PROCEDURE SELECT_BANK_SITE
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_BANK_GROUP_CODE   IN FI_BANK.BANK_GROUP%TYPE
            , W_BANK_ID           IN FI_BANK.BANK_ID%TYPE
            , W_SOB_ID            IN FI_BANK.SOB_ID%TYPE
            , W_ORG_ID            IN FI_BANK.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT FB.BANK_ID
           , FB.BANK_GROUP
           , FB.BANK_CODE
           , FB.BANK_NAME
           , FB.BANK_ENG_NAME
           , FB.BANK_TYPE
           , FI_COMMON_G.CODE_NAME_F('BANK_TYPE', FB.BANK_TYPE, FB.SOB_ID, FB.ORG_ID) AS BANK_TYPE_NAME
           , FB.VAT_NUMBER
           , FB.DC_LIMIT_AMOUNT
           , FB.DC_METHOD_ID
           , FI_COMMON_G.ID_NAME_F(FB.DC_METHOD_ID) AS DC_METHOD_NAME
           , FB.DC_RATE1
           , FB.DC_RATE2
           , FB.LOAN_LIMIT_AMOUNT
           , FB.START_DATE
           , FB.REMARK
           , FB.ENABLED_FLAG
           , FB.EFFECTIVE_DATE_FR
           , FB.EFFECTIVE_DATE_TO
           , SX1.BANK_NAME AS BANK_GROUP_NAME
        FROM FI_BANK FB
           , (SELECT G_FB.BANK_CODE
                   , G_FB.BANK_NAME
                FROM FI_BANK G_FB
               WHERE G_FB.BANK_GROUP          = '-'
             ) SX1
       WHERE FB.BANK_GROUP              = SX1.BANK_CODE
         AND FB.BANK_GROUP              = NVL(W_BANK_GROUP_CODE, FB.BANK_GROUP)
         AND FB.BANK_ID                 = NVL(W_BANK_ID, FB.BANK_ID)
         AND FB.SOB_ID                  = W_SOB_ID
/*         AND FB.ORG_ID                  = W_ORG_ID*/
      ;         
  END SELECT_BANK_SITE;
  
-- 은행지점 삽입.
  PROCEDURE INSERT_BANK_SITE
            ( P_BANK_ID           OUT FI_BANK.BANK_ID%TYPE
            , P_SOB_ID            IN FI_BANK.SOB_ID%TYPE
            , P_ORG_ID            IN FI_BANK.ORG_ID%TYPE
            , P_BANK_GROUP        IN FI_BANK.BANK_GROUP%TYPE
            , P_BANK_CODE         IN FI_BANK.BANK_CODE%TYPE
            , P_BANK_NAME         IN FI_BANK.BANK_NAME%TYPE
            , P_BANK_ENG_NAME     IN FI_BANK.BANK_ENG_NAME%TYPE
            , P_BANK_TYPE         IN FI_BANK.BANK_TYPE%TYPE
            , P_VAT_NUMBER        IN FI_BANK.VAT_NUMBER%TYPE
            , P_DC_LIMIT_AMOUNT   IN FI_BANK.DC_LIMIT_AMOUNT%TYPE
            , P_DC_METHOD_ID      IN FI_BANK.DC_METHOD_ID%TYPE
            , P_DC_RATE1          IN FI_BANK.DC_RATE1%TYPE
            , P_DC_RATE2          IN FI_BANK.DC_RATE2%TYPE
            , P_LOAN_LIMIT_AMOUNT IN FI_BANK.LOAN_LIMIT_AMOUNT%TYPE
            , P_START_DATE        IN FI_BANK.START_DATE%TYPE
            , P_REMARK            IN FI_BANK.REMARK%TYPE
            , P_ENABLED_FLAG      IN FI_BANK.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_BANK.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_BANK.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_BANK.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT NUMBER := 0;
    
  BEGIN
    -- 동일한 은행 그룹코드 존재 체크.
    BEGIN
      SELECT COUNT(FB.BANK_CODE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BANK FB
       WHERE FB.SOB_ID            = P_SOB_ID
/*         AND FB.ORG_ID            = P_ORG_ID*/
         AND FB.BANK_GROUP        = P_BANK_GROUP
         AND FB.BANK_CODE         = P_BANK_CODE
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;
    
    SELECT FI_BANK_S1.NEXTVAL
     INTO P_BANK_ID
     FROM DUAL;

    INSERT INTO FI_BANK
    ( BANK_ID
    , SOB_ID 
    , ORG_ID 
    , BANK_GROUP 
    , BANK_CODE 
    , BANK_NAME 
    , BANK_ENG_NAME 
    , BANK_TYPE 
    , VAT_NUMBER 
    , DC_LIMIT_AMOUNT 
    , DC_METHOD_ID 
    , DC_RATE1 
    , DC_RATE2 
    , LOAN_LIMIT_AMOUNT 
    , START_DATE 
    , REMARK 
    , ENABLED_FLAG 
    , EFFECTIVE_DATE_FR 
    , EFFECTIVE_DATE_TO 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_BANK_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_BANK_GROUP
    , P_BANK_CODE
    , P_BANK_NAME
    , P_BANK_ENG_NAME
    , P_BANK_TYPE
    , P_VAT_NUMBER
    , P_DC_LIMIT_AMOUNT
    , P_DC_METHOD_ID
    , P_DC_RATE1
    , P_DC_RATE2
    , P_LOAN_LIMIT_AMOUNT
    , P_START_DATE
    , P_REMARK
    , P_ENABLED_FLAG
    , P_EFFECTIVE_DATE_FR
    , P_EFFECTIVE_DATE_TO
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  
  EXCEPTION 
    WHEN ERRNUMS.Exist_Data THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END INSERT_BANK_SITE;
  
-- 은행지점 수정.
  PROCEDURE UPDATE_BANK_SITE
            ( W_BANK_ID           IN FI_BANK.BANK_ID%TYPE
            , P_BANK_NAME         IN FI_BANK.BANK_NAME%TYPE
            , P_BANK_ENG_NAME     IN FI_BANK.BANK_ENG_NAME%TYPE
            , P_BANK_TYPE         IN FI_BANK.BANK_TYPE%TYPE
            , P_VAT_NUMBER        IN FI_BANK.VAT_NUMBER%TYPE
            , P_DC_LIMIT_AMOUNT   IN FI_BANK.DC_LIMIT_AMOUNT%TYPE
            , P_DC_METHOD_ID      IN FI_BANK.DC_METHOD_ID%TYPE
            , P_DC_RATE1          IN FI_BANK.DC_RATE1%TYPE
            , P_DC_RATE2          IN FI_BANK.DC_RATE2%TYPE
            , P_LOAN_LIMIT_AMOUNT IN FI_BANK.LOAN_LIMIT_AMOUNT%TYPE
            , P_START_DATE        IN FI_BANK.START_DATE%TYPE
            , P_REMARK            IN FI_BANK.REMARK%TYPE
            , P_ENABLED_FLAG      IN FI_BANK.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_BANK.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_BANK.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_BANK.CREATED_BY%TYPE
            )
  AS
  BEGIN
    UPDATE FI_BANK
      SET BANK_NAME         = P_BANK_NAME
        , BANK_ENG_NAME     = P_BANK_ENG_NAME
        , BANK_TYPE         = P_BANK_TYPE
        , VAT_NUMBER        = P_VAT_NUMBER
        , DC_LIMIT_AMOUNT   = P_DC_LIMIT_AMOUNT
        , DC_METHOD_ID      = P_DC_METHOD_ID
        , DC_RATE1          = P_DC_RATE1
        , DC_RATE2          = P_DC_RATE2
        , LOAN_LIMIT_AMOUNT = P_LOAN_LIMIT_AMOUNT
        , START_DATE        = P_START_DATE
        , REMARK            = P_REMARK
        , ENABLED_FLAG      = P_ENABLED_FLAG
        , EFFECTIVE_DATE_FR = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO = P_EFFECTIVE_DATE_TO
        , LAST_UPDATE_DATE  = GET_LOCAL_DATE(SOB_ID)
        , LAST_UPDATED_BY   = P_USER_ID
    WHERE BANK_ID           = W_BANK_ID
    ;
    
  END UPDATE_BANK_SITE;

-----------------------------------------------------------------------------------------
-- 은행 명칭 리턴 FUNCTION.
  FUNCTION ID_NAME_F
            ( W_BANK_ID           IN FI_BANK.BANK_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                VARCHAR2(150) := NULL;
    
  BEGIN
    BEGIN
      SELECT FB.BANK_NAME
        INTO V_RETURN_VALUE
      FROM FI_BANK FB
      WHERE FB.BANK_ID            = W_BANK_ID 
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;
        
  END ID_NAME_F;  

  PROCEDURE ID_NAME_P
            ( W_BANK_ID           IN FI_BANK.BANK_ID%TYPE
            , O_RETURN_VALUE      OUT VARCHAR2
            )
  AS
  BEGIN
    BEGIN
      SELECT FB.BANK_NAME
        INTO O_RETURN_VALUE
      FROM FI_BANK FB
      WHERE FB.BANK_ID            = W_BANK_ID 
      ;
    EXCEPTION WHEN OTHERS THEN
      O_RETURN_VALUE := NULL;
    END;
    
  END ID_NAME_P;  
  
  FUNCTION CODE_NAME_F
           ( W_BANK_CODE           IN FI_BANK.BANK_CODE%TYPE
           , W_SOB_ID              IN FI_BANK.SOB_ID%TYPE
           ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                 VARCHAR2(150) := NULL;
    
  BEGIN
    BEGIN
      SELECT FB.BANK_NAME
        INTO V_RETURN_VALUE
      FROM FI_BANK FB
      WHERE FB.BANK_CODE           = W_BANK_CODE
        AND FB.SOB_ID              = W_SOB_ID 
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;
  
  END CODE_NAME_F;                                                

  PROCEDURE CODE_NAME_P
            ( W_BANK_CODE          IN FI_BANK.BANK_CODE%TYPE
            , W_SOB_ID             IN FI_BANK.SOB_ID%TYPE
            , O_RETURN_VALUE       OUT VARCHAR2
            )
  AS
  BEGIN
   BEGIN
      SELECT FB.BANK_NAME
        INTO O_RETURN_VALUE
      FROM FI_BANK FB
      WHERE FB.BANK_CODE           = W_BANK_CODE
        AND FB.SOB_ID              = W_SOB_ID 
      ;
    EXCEPTION WHEN OTHERS THEN
      O_RETURN_VALUE := NULL;
    END;

  END CODE_NAME_P;
    
-- 은행그룹 LOOKUP 조회.
  PROCEDURE LU_BANK_GROUP
            ( P_CURSOR3              OUT TYPES.TCURSOR
            , W_SOB_ID               IN FI_BANK.SOB_ID%TYPE
            , W_ORG_ID               IN FI_BANK.ORG_ID%TYPE
            , W_ENABLED_YN           IN FI_BANK.ENABLED_FLAG%TYPE
            )
  AS
    V_STD_DATE                       DATE := NULL;
    
  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    END IF;
    
    OPEN P_CURSOR3 FOR
      SELECT FB.BANK_NAME
           , FB.BANK_CODE
           , FB.BANK_ID
        FROM FI_BANK FB
       WHERE FB.BANK_GROUP              = '-'
         AND FB.ENABLED_FLAG            = DECODE(W_ENABLED_YN, 'Y', 'Y', FB.ENABLED_FLAG)
         AND FB.EFFECTIVE_DATE_FR       <= NVL(V_STD_DATE, FB.EFFECTIVE_DATE_FR)
         AND (FB.EFFECTIVE_DATE_TO IS NULL OR FB.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, FB.EFFECTIVE_DATE_TO))
         AND FB.SOB_ID                  = W_SOB_ID
/*         AND FB.ORG_ID                  = W_ORG_ID*/
      ;
      
  END LU_BANK_GROUP;          
            
-- 은행지점 lookup 조회.
  PROCEDURE LU_BANK_SITE
            ( P_CURSOR3              OUT TYPES.TCURSOR
            , W_SOB_ID               IN FI_BANK.SOB_ID%TYPE
            , W_ORG_ID               IN FI_BANK.ORG_ID%TYPE
            , W_ENABLED_YN           IN FI_BANK.ENABLED_FLAG%TYPE
            )
  AS
    V_STD_DATE                       DATE := NULL;
    
  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    END IF;
    
    OPEN P_CURSOR3 FOR
      SELECT FB.BANK_NAME
           , FB.BANK_CODE
           , FB.BANK_ID
        FROM FI_BANK FB
       WHERE FB.BANK_GROUP              <> '-'
         AND FB.ENABLED_FLAG            = DECODE(W_ENABLED_YN, 'Y', 'Y', FB.ENABLED_FLAG)
         AND FB.EFFECTIVE_DATE_FR       <= NVL(V_STD_DATE, FB.EFFECTIVE_DATE_FR)
         AND (FB.EFFECTIVE_DATE_TO IS NULL OR FB.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, FB.EFFECTIVE_DATE_TO))
         AND FB.SOB_ID                  = W_SOB_ID
/*         AND FB.ORG_ID                  = W_ORG_ID*/
      ;
  
  END LU_BANK_SITE;
  
END FI_BANK_G;
/
