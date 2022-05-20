CREATE OR REPLACE PACKAGE FI_BANK_ACCOUNT_G
AS

-- 은행계좌번호 조회.
  PROCEDURE SELECT_BANK_ACCOUNT
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_BANK_ID              IN FI_BANK_ACCOUNT.BANK_ID%TYPE
            , W_SOB_ID               IN FI_BANK_ACCOUNT.SOB_ID%TYPE
            , W_ORG_ID               IN FI_BANK_ACCOUNT.ORG_ID%TYPE
            );

-- 은행계좌 삽입.
  PROCEDURE INSERT_BANK_ACCOUNT
            ( P_BANK_ACCOUNT_ID      OUT FI_BANK_ACCOUNT.BANK_ACCOUNT_ID%TYPE
            , P_SOB_ID               IN  FI_BANK_ACCOUNT.SOB_ID%TYPE
            , P_ORG_ID               IN  FI_BANK_ACCOUNT.ORG_ID%TYPE
            , P_BANK_ACCOUNT_CODE    OUT VARCHAR2 
            , P_BANK_ACCOUNT_NAME    IN  FI_BANK_ACCOUNT.BANK_ACCOUNT_NAME%TYPE
            , P_BANK_ID              IN  FI_BANK_ACCOUNT.BANK_ID%TYPE
            , P_BANK_ACCOUNT_NUM     IN  FI_BANK_ACCOUNT.BANK_ACCOUNT_NUM%TYPE
            , P_OWNER_NAME           IN  FI_BANK_ACCOUNT.OWNER_NAME%TYPE
            , P_ACCOUNT_TYPE         IN  FI_BANK_ACCOUNT.ACCOUNT_TYPE%TYPE
            , P_GL_CONTROL_YN        IN  FI_BANK_ACCOUNT.GL_CONTROL_YN%TYPE
            , P_CURRENCY_CODE        IN  FI_BANK_ACCOUNT.CURRENCY_CODE%TYPE
            , P_LIMIT_AMOUNT         IN  FI_BANK_ACCOUNT.LIMIT_AMOUNT%TYPE
            , P_USE_AMOUNT           IN  FI_BANK_ACCOUNT.USE_AMOUNT%TYPE
            , P_REMARK               IN  FI_BANK_ACCOUNT.REMARK%TYPE
            , P_ENABLED_FLAG         IN  FI_BANK_ACCOUNT.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR    IN  FI_BANK_ACCOUNT.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO    IN  FI_BANK_ACCOUNT.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID              IN  FI_BANK_ACCOUNT.CREATED_BY%TYPE
            );

-- 은행계좌 수정.
  PROCEDURE UPDATE_BANK_ACCOUNT
            ( W_BANK_ACCOUNT_ID      IN FI_BANK_ACCOUNT.BANK_ACCOUNT_ID%TYPE
            , P_BANK_ACCOUNT_NAME    IN FI_BANK_ACCOUNT.BANK_ACCOUNT_NAME%TYPE
            , P_BANK_ACCOUNT_NUM     IN FI_BANK_ACCOUNT.BANK_ACCOUNT_NUM%TYPE
            , P_OWNER_NAME           IN FI_BANK_ACCOUNT.OWNER_NAME%TYPE
            , P_ACCOUNT_TYPE         IN FI_BANK_ACCOUNT.ACCOUNT_TYPE%TYPE
            , P_GL_CONTROL_YN        IN FI_BANK_ACCOUNT.GL_CONTROL_YN%TYPE
            , P_CURRENCY_CODE        IN FI_BANK_ACCOUNT.CURRENCY_CODE%TYPE
            , P_LIMIT_AMOUNT         IN FI_BANK_ACCOUNT.LIMIT_AMOUNT%TYPE
            , P_USE_AMOUNT           IN FI_BANK_ACCOUNT.USE_AMOUNT%TYPE
            , P_REMARK               IN FI_BANK_ACCOUNT.REMARK%TYPE
            , P_ENABLED_FLAG         IN FI_BANK_ACCOUNT.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR    IN FI_BANK_ACCOUNT.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO    IN FI_BANK_ACCOUNT.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID              IN FI_BANK_ACCOUNT.CREATED_BY%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 은행계좌 번호 리턴.
  FUNCTION  BANK_ACCOUNT_NUM_F
            ( W_BANK_ID              IN FI_BANK_ACCOUNT.BANK_ACCOUNT_ID%TYPE
            ) RETURN VARCHAR2;

-- 은행계좌명 리턴.
  FUNCTION  BANK_ACCOUNT_NAME_F
            ( W_BANK_ID              IN FI_BANK_ACCOUNT.BANK_ACCOUNT_ID%TYPE
            ) RETURN VARCHAR2;

---------------------------------------------------------------------------------------------------
-- 은행계좌 조회 LOOKUP.
  PROCEDURE LU_BANK_ACCOUNT
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_BANK_ID              IN FI_BANK_ACCOUNT.BANK_ID%TYPE
            , W_SOB_ID               IN FI_BANK_ACCOUNT.SOB_ID%TYPE
            , W_ORG_ID               IN FI_BANK_ACCOUNT.ORG_ID%TYPE
            , W_ENABLED_YN           IN FI_BANK_ACCOUNT.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

  PROCEDURE LU_BANK_ACCOUNT1
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_BANK_ID              IN FI_BANK_ACCOUNT.BANK_ID%TYPE
            , W_SUPPLIER_CUSTOMER_ID IN FI_BANK_ACCOUNT.SUPPLIER_CUSTOMER_ID%TYPE
            , W_SOB_ID               IN FI_BANK_ACCOUNT.SOB_ID%TYPE
            , W_ORG_ID               IN FI_BANK_ACCOUNT.ORG_ID%TYPE
            , W_ENABLED_YN           IN FI_BANK_ACCOUNT.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

  PROCEDURE LU_BANK_ACCOUNT_OWNER_TYPE
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_ACCOUNT_OWNER_TYPE   IN FI_BANK_ACCOUNT.ACCOUNT_OWNER_TYPE%TYPE
            , W_BANK_ID              IN FI_BANK_ACCOUNT.BANK_ID%TYPE
            , W_SUPPLIER_CUSTOMER_ID IN FI_BANK_ACCOUNT.SUPPLIER_CUSTOMER_ID%TYPE
            , W_SOB_ID               IN FI_BANK_ACCOUNT.SOB_ID%TYPE
            , W_ORG_ID               IN FI_BANK_ACCOUNT.ORG_ID%TYPE
            , W_ENABLED_YN           IN FI_BANK_ACCOUNT.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

END FI_BANK_ACCOUNT_G; 
/
CREATE OR REPLACE PACKAGE BODY FI_BANK_ACCOUNT_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_BANK_ACCOUNT_G
/* Description  : 은행 계좌번호 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 은행계좌번호 조회.
  PROCEDURE SELECT_BANK_ACCOUNT
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_BANK_ID              IN FI_BANK_ACCOUNT.BANK_ID%TYPE
            , W_SOB_ID               IN FI_BANK_ACCOUNT.SOB_ID%TYPE
            , W_ORG_ID               IN FI_BANK_ACCOUNT.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT BA.BANK_ACCOUNT_ID
           , BA.BANK_ACCOUNT_CODE
           , BA.BANK_ACCOUNT_NAME
           , BA.BANK_ID
           , BA.BANK_ACCOUNT_NUM
           , BA.OWNER_NAME
           , BA.ACCOUNT_TYPE
           , FI_COMMON_G.CODE_NAME_F('ACCOUNT_TYPE', BA.ACCOUNT_TYPE, BA.SOB_ID, BA.ORG_ID) AS ACCOUNT_TYPE_NAME
           , BA.GL_CONTROL_YN
           , BA.CURRENCY_CODE AS DISPLAY_CURRENCY_CODE
           , BA.CURRENCY_CODE
           , BA.LIMIT_AMOUNT
           , BA.USE_AMOUNT
--           , BA.ACCOUNT_OWNER_TYPE
           , BA.REMARK
           , BA.ENABLED_FLAG
           , BA.EFFECTIVE_DATE_FR
           , BA.EFFECTIVE_DATE_TO
        FROM FI_BANK_ACCOUNT BA
       WHERE BA.BANK_ID                 = W_BANK_ID
         AND BA.SOB_ID                  = W_SOB_ID
/*         AND BA.ORG_ID                  = W_ORG_ID*/
         AND BA.ACCOUNT_OWNER_TYPE      = 'OWNER'
      ;

  END SELECT_BANK_ACCOUNT;

-- 은행계좌 삽입.
  PROCEDURE INSERT_BANK_ACCOUNT
            ( P_BANK_ACCOUNT_ID      OUT FI_BANK_ACCOUNT.BANK_ACCOUNT_ID%TYPE
            , P_SOB_ID               IN  FI_BANK_ACCOUNT.SOB_ID%TYPE
            , P_ORG_ID               IN  FI_BANK_ACCOUNT.ORG_ID%TYPE
            , P_BANK_ACCOUNT_CODE    OUT VARCHAR2 
            , P_BANK_ACCOUNT_NAME    IN  FI_BANK_ACCOUNT.BANK_ACCOUNT_NAME%TYPE
            , P_BANK_ID              IN  FI_BANK_ACCOUNT.BANK_ID%TYPE
            , P_BANK_ACCOUNT_NUM     IN  FI_BANK_ACCOUNT.BANK_ACCOUNT_NUM%TYPE
            , P_OWNER_NAME           IN  FI_BANK_ACCOUNT.OWNER_NAME%TYPE
            , P_ACCOUNT_TYPE         IN  FI_BANK_ACCOUNT.ACCOUNT_TYPE%TYPE
            , P_GL_CONTROL_YN        IN  FI_BANK_ACCOUNT.GL_CONTROL_YN%TYPE
            , P_CURRENCY_CODE        IN  FI_BANK_ACCOUNT.CURRENCY_CODE%TYPE
            , P_LIMIT_AMOUNT         IN  FI_BANK_ACCOUNT.LIMIT_AMOUNT%TYPE
            , P_USE_AMOUNT           IN  FI_BANK_ACCOUNT.USE_AMOUNT%TYPE
            , P_REMARK               IN  FI_BANK_ACCOUNT.REMARK%TYPE
            , P_ENABLED_FLAG         IN  FI_BANK_ACCOUNT.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR    IN  FI_BANK_ACCOUNT.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO    IN  FI_BANK_ACCOUNT.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID              IN  FI_BANK_ACCOUNT.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE      DATE   := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT NUMBER := 0;
  BEGIN
    /*-- 동일한 계좌코드 존재 체크.
    BEGIN
      SELECT COUNT(BA.BANK_ACCOUNT_NUM) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BANK_ACCOUNT BA
       WHERE BA.SOB_ID            = P_SOB_ID
         AND BA.BANK_ACCOUNT_CODE = P_BANK_ACCOUNT_CODE
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;*/
    
    IF P_BANK_ACCOUNT_CODE IS NULL THEN
      -- 계좌 자동 채번
      SELECT MAX(TO_NUMBER(SUBSTR(BA.BANK_ACCOUNT_CODE,2,4)))+1
          INTO P_BANK_ACCOUNT_CODE
          FROM FI_BANK_ACCOUNT        BA
         WHERE BA.SOB_ID         = P_SOB_ID
           AND BA.ORG_ID         = P_ORG_ID
      ;

      P_BANK_ACCOUNT_CODE := 'F' || LPAD(TO_CHAR(P_BANK_ACCOUNT_CODE),4,'0');
    END IF;
    
    -- 동일한 계좌번호 존재 체크.
    BEGIN
      SELECT COUNT(BA.BANK_ACCOUNT_NUM) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BANK_ACCOUNT BA
       WHERE BA.SOB_ID            = P_SOB_ID
         AND BA.BANK_ACCOUNT_NUM  = P_BANK_ACCOUNT_NUM
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;

    SELECT FI_BANK_ACCOUNT_S1.NEXTVAL
      INTO P_BANK_ACCOUNT_ID
      FROM DUAL;

    INSERT INTO FI_BANK_ACCOUNT
    ( BANK_ACCOUNT_ID
    , SOB_ID
    , ORG_ID
    , BANK_ACCOUNT_CODE
    , BANK_ACCOUNT_NAME
    , BANK_ID
    , BANK_ACCOUNT_NUM
    , OWNER_NAME
    , ACCOUNT_TYPE
    , GL_CONTROL_YN
    , CURRENCY_CODE
    , LIMIT_AMOUNT
    , USE_AMOUNT
    , ACCOUNT_OWNER_TYPE
    , REMARK
    , ENABLED_FLAG
    , EFFECTIVE_DATE_FR
    , EFFECTIVE_DATE_TO
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY )
    VALUES
    ( P_BANK_ACCOUNT_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_BANK_ACCOUNT_CODE
    , P_BANK_ACCOUNT_NAME
    , P_BANK_ID
    , P_BANK_ACCOUNT_NUM
    , P_OWNER_NAME
    , P_ACCOUNT_TYPE
    , P_GL_CONTROL_YN
    , P_CURRENCY_CODE
    , P_LIMIT_AMOUNT
    , P_USE_AMOUNT
    , 'OWNER'     -- ACCOUNT_OWNER_TYPE
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
  END INSERT_BANK_ACCOUNT;

-- 은행계좌 수정.
  PROCEDURE UPDATE_BANK_ACCOUNT
            ( W_BANK_ACCOUNT_ID      IN FI_BANK_ACCOUNT.BANK_ACCOUNT_ID%TYPE
            , P_BANK_ACCOUNT_NAME    IN FI_BANK_ACCOUNT.BANK_ACCOUNT_NAME%TYPE
            , P_BANK_ACCOUNT_NUM     IN FI_BANK_ACCOUNT.BANK_ACCOUNT_NUM%TYPE
            , P_OWNER_NAME           IN FI_BANK_ACCOUNT.OWNER_NAME%TYPE
            , P_ACCOUNT_TYPE         IN FI_BANK_ACCOUNT.ACCOUNT_TYPE%TYPE
            , P_GL_CONTROL_YN        IN FI_BANK_ACCOUNT.GL_CONTROL_YN%TYPE
            , P_CURRENCY_CODE        IN FI_BANK_ACCOUNT.CURRENCY_CODE%TYPE
            , P_LIMIT_AMOUNT         IN FI_BANK_ACCOUNT.LIMIT_AMOUNT%TYPE
            , P_USE_AMOUNT           IN FI_BANK_ACCOUNT.USE_AMOUNT%TYPE
            , P_REMARK               IN FI_BANK_ACCOUNT.REMARK%TYPE
            , P_ENABLED_FLAG         IN FI_BANK_ACCOUNT.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR    IN FI_BANK_ACCOUNT.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO    IN FI_BANK_ACCOUNT.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID              IN FI_BANK_ACCOUNT.CREATED_BY%TYPE
            )
  AS
  BEGIN
    UPDATE FI_BANK_ACCOUNT
      SET BANK_ACCOUNT_NAME    = P_BANK_ACCOUNT_NAME
        , BANK_ACCOUNT_NUM     = P_BANK_ACCOUNT_NUM
        , OWNER_NAME           = P_OWNER_NAME
        , ACCOUNT_TYPE         = P_ACCOUNT_TYPE
        , GL_CONTROL_YN        = P_GL_CONTROL_YN
        , CURRENCY_CODE        = P_CURRENCY_CODE
        , LIMIT_AMOUNT         = P_LIMIT_AMOUNT
        , USE_AMOUNT           = P_USE_AMOUNT
        , REMARK               = P_REMARK
        , ENABLED_FLAG         = P_ENABLED_FLAG
        , EFFECTIVE_DATE_FR    = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO    = P_EFFECTIVE_DATE_TO
        , LAST_UPDATE_DATE     = GET_LOCAL_DATE(SOB_ID)
        , LAST_UPDATED_BY      = P_USER_ID
    WHERE BANK_ACCOUNT_ID      = W_BANK_ACCOUNT_ID
    ;

  END UPDATE_BANK_ACCOUNT;

---------------------------------------------------------------------------------------------------
-- 은행계좌 번호 리턴.
  FUNCTION  BANK_ACCOUNT_NUM_F
            ( W_BANK_ID              IN FI_BANK_ACCOUNT.BANK_ACCOUNT_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                   VARCHAR2(200) := NULL;
  BEGIN
    BEGIN
      SELECT BA.BANK_ACCOUNT_NUM
        INTO V_RETURN_VALUE
        FROM FI_BANK_ACCOUNT BA
       WHERE BA.BANK_ID                 = W_BANK_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;

  END BANK_ACCOUNT_NUM_F;

-- 은행계좌명 리턴.
  FUNCTION  BANK_ACCOUNT_NAME_F
            ( W_BANK_ID              IN FI_BANK_ACCOUNT.BANK_ACCOUNT_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                   VARCHAR2(200) := NULL;
  BEGIN
    BEGIN
      SELECT BA.BANK_ACCOUNT_NAME
        INTO V_RETURN_VALUE
        FROM FI_BANK_ACCOUNT BA
       WHERE BA.BANK_ID                 = W_BANK_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := NULL;
    END;
    RETURN V_RETURN_VALUE;

  END BANK_ACCOUNT_NAME_F;

---------------------------------------------------------------------------------------------------
-- 은행계좌 조회 LOOKUP.
  PROCEDURE LU_BANK_ACCOUNT
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_BANK_ID              IN FI_BANK_ACCOUNT.BANK_ID%TYPE
            , W_SOB_ID               IN FI_BANK_ACCOUNT.SOB_ID%TYPE
            , W_ORG_ID               IN FI_BANK_ACCOUNT.ORG_ID%TYPE
            , W_ENABLED_YN           IN FI_BANK_ACCOUNT.ENABLED_FLAG%TYPE DEFAULT 'Y'
            )
  AS
    V_STD_DATE                       DATE := NULL;

  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    END IF;

    OPEN P_CURSOR3 FOR
      SELECT BA.BANK_ACCOUNT_NAME
           , BA.BANK_ACCOUNT_NUM
           , FB.BANK_NAME
           , BA.OWNER_NAME
           , BA.BANK_ACCOUNT_ID
        FROM FI_BANK_ACCOUNT_TLV BA
           , FI_BANK FB
       WHERE BA.BANK_ID                 = FB.BANK_ID
         AND BA.BANK_ID                 = NVL(W_BANK_ID, BA.BANK_ID)
         AND BA.SOB_ID                  = W_SOB_ID
/*         AND BA.ORG_ID                  = W_ORG_ID*/
         AND BA.ACCOUNT_OWNER_TYPE      = 'OWNER'
         AND BA.ENABLED_FLAG            = DECODE(W_ENABLED_YN, 'Y', 'Y', BA.ENABLED_FLAG)
         AND BA.EFFECTIVE_DATE_FR       <= NVL(V_STD_DATE, BA.EFFECTIVE_DATE_FR)
         AND (BA.EFFECTIVE_DATE_TO IS NULL OR BA.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, BA.EFFECTIVE_DATE_TO))
      ;

  END LU_BANK_ACCOUNT;

  PROCEDURE LU_BANK_ACCOUNT1
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_BANK_ID              IN FI_BANK_ACCOUNT.BANK_ID%TYPE
            , W_SUPPLIER_CUSTOMER_ID IN FI_BANK_ACCOUNT.SUPPLIER_CUSTOMER_ID%TYPE
            , W_SOB_ID               IN FI_BANK_ACCOUNT.SOB_ID%TYPE
            , W_ORG_ID               IN FI_BANK_ACCOUNT.ORG_ID%TYPE
            , W_ENABLED_YN           IN FI_BANK_ACCOUNT.ENABLED_FLAG%TYPE DEFAULT 'Y'
            )
  AS
    V_STD_DATE                       DATE := NULL;

  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    END IF;

    OPEN P_CURSOR3 FOR
      SELECT BA.BANK_ACCOUNT_NAME
           , BA.BANK_ACCOUNT_NUM
           , FB.BANK_NAME
           , BA.OWNER_NAME
           , BA.BANK_ACCOUNT_ID
        FROM FI_BANK_ACCOUNT_TLV BA
           , FI_BANK FB
       WHERE BA.BANK_ID                 = FB.BANK_ID
         AND BA.BANK_ID                 = NVL(W_BANK_ID, BA.BANK_ID)
         AND BA.SOB_ID                  = W_SOB_ID
         AND BA.SUPPLIER_CUSTOMER_ID    = NVL(W_SUPPLIER_CUSTOMER_ID, BA.SUPPLIER_CUSTOMER_ID)
         AND BA.ENABLED_FLAG            = DECODE(W_ENABLED_YN, 'Y', 'Y', BA.ENABLED_FLAG)
         AND BA.EFFECTIVE_DATE_FR       <= NVL(V_STD_DATE, BA.EFFECTIVE_DATE_FR)
         AND (BA.EFFECTIVE_DATE_TO IS NULL OR BA.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, BA.EFFECTIVE_DATE_TO))
      ;

  END LU_BANK_ACCOUNT1;

  PROCEDURE LU_BANK_ACCOUNT_OWNER_TYPE
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_ACCOUNT_OWNER_TYPE   IN FI_BANK_ACCOUNT.ACCOUNT_OWNER_TYPE%TYPE
            , W_BANK_ID              IN FI_BANK_ACCOUNT.BANK_ID%TYPE
            , W_SUPPLIER_CUSTOMER_ID IN FI_BANK_ACCOUNT.SUPPLIER_CUSTOMER_ID%TYPE
            , W_SOB_ID               IN FI_BANK_ACCOUNT.SOB_ID%TYPE
            , W_ORG_ID               IN FI_BANK_ACCOUNT.ORG_ID%TYPE
            , W_ENABLED_YN           IN FI_BANK_ACCOUNT.ENABLED_FLAG%TYPE DEFAULT 'Y'
            )
  AS
    V_STD_DATE                       DATE := NULL;
  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    END IF;

    IF W_ACCOUNT_OWNER_TYPE = 'OWNER' THEN
    -- 자사 통장.
      OPEN P_CURSOR3 FOR
        SELECT BA.BANK_ACCOUNT_NAME
             , BA.BANK_ACCOUNT_NUM
             , FB.BANK_NAME
             , BA.OWNER_NAME
             , BA.BANK_ACCOUNT_ID
          FROM FI_BANK_ACCOUNT_TLV BA
             , FI_BANK FB
         WHERE BA.BANK_ID                 = FB.BANK_ID
           AND BA.BANK_ID                 = NVL(W_BANK_ID, BA.BANK_ID)
           AND BA.SOB_ID                  = W_SOB_ID
           AND BA.ACCOUNT_OWNER_TYPE      = 'OWNER'
           AND BA.ENABLED_FLAG            = DECODE(W_ENABLED_YN, 'Y', 'Y', BA.ENABLED_FLAG)
           AND BA.EFFECTIVE_DATE_FR       <= NVL(V_STD_DATE, BA.EFFECTIVE_DATE_FR)
           AND (BA.EFFECTIVE_DATE_TO IS NULL OR BA.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, BA.EFFECTIVE_DATE_TO))
        ;
    ELSE
    -- 고객사 통장.
      OPEN P_CURSOR3 FOR
        SELECT BA.BANK_ACCOUNT_NAME
             , BA.BANK_ACCOUNT_NUM
             , FB.BANK_NAME
             , BA.OWNER_NAME
             , BA.BANK_ACCOUNT_ID
          FROM FI_BANK_ACCOUNT_TLV BA
             , FI_BANK FB
         WHERE BA.BANK_ID                 = FB.BANK_ID
           AND BA.BANK_ID                 = NVL(W_BANK_ID, BA.BANK_ID)
           AND BA.SOB_ID                  = W_SOB_ID
           AND BA.SUPPLIER_CUSTOMER_ID    = NVL(W_SUPPLIER_CUSTOMER_ID, BA.SUPPLIER_CUSTOMER_ID)
           AND BA.ENABLED_FLAG            = DECODE(W_ENABLED_YN, 'Y', 'Y', BA.ENABLED_FLAG)
           AND BA.EFFECTIVE_DATE_FR       <= NVL(V_STD_DATE, BA.EFFECTIVE_DATE_FR)
           AND (BA.EFFECTIVE_DATE_TO IS NULL OR BA.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, BA.EFFECTIVE_DATE_TO))
        ;
    END IF;

  END LU_BANK_ACCOUNT_OWNER_TYPE;

END FI_BANK_ACCOUNT_G; 
/
