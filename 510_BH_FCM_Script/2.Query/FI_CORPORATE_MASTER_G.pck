CREATE OR REPLACE PACKAGE FI_CORPORATE_MASTER_G
AS

-- 법인정보 조회.
  PROCEDURE SELECT_CORPORATE
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_CORPORATE_ID         IN FI_CORPORATE_MASTER.CORPORATE_ID%TYPE
            , W_ENABLED_FLAG         IN FI_CORPORATE_MASTER.ENABLED_FLAG%TYPE
            , W_SOB_ID               IN FI_CORPORATE_MASTER.SOB_ID%TYPE
            );
/*
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
\*         AND FB.ORG_ID                  = W_ORG_ID*\
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
\*         AND FB.ORG_ID                  = W_ORG_ID*\
      ;

  END LU_BANK_SITE;
*/
END FI_CORPORATE_MASTER_G;
/
CREATE OR REPLACE PACKAGE BODY FI_CORPORATE_MASTER_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_CORPORATE_MASTER_G
/* Description  : 법인정보 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 법인정보 조회.
  PROCEDURE SELECT_CORPORATE
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_CORPORATE_ID         IN FI_CORPORATE_MASTER.CORPORATE_ID%TYPE
            , W_ENABLED_FLAG         IN FI_CORPORATE_MASTER.ENABLED_FLAG%TYPE
            , W_SOB_ID               IN FI_CORPORATE_MASTER.SOB_ID%TYPE
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    IF W_ENABLED_FLAG = 'N' THEN
      V_SYSDATE := NULL;
    END IF;
    OPEN P_CURSOR FOR
      SELECT CM.CORPORATE_ID
           , CM.CORPORATE_CODE
           , CM.CORPORATE_NAME
           , CM.CORPORATE_NAME_1
           , CM.CORPORATE_NAME_2
           , CM.LEGAL_NUM
           , CM.PRESIDENT_NAME
           , CM.BUSINESS_TYPE
           , CM.BUSINESS_ITEM
           , FI_COMMON_G.CODE_NAME_F('BUSINESS_TYPE', CM.CORPORATE_TYPE, CM.SOB_ID) AS CORPORATE_TYPE_DESC
           , CM.CORPORATE_TYPE
           , CM.TEL_NUM
           , CM.FAX_NUM
           , CM.EMAIL
           , CM.ZIP_CODE
           , CM.ADDR1
           , CM.ADDR2
           , CM.ENABLED_FLAG
           , CM.EFFECTIVE_DATE_FR
           , CM.EFFECTIVE_DATE_TO
           , CM.HOMETAX_ID
        FROM FI_CORPORATE_MASTER CM
      WHERE CM.CORPORATE_ID       = NVL(W_CORPORATE_ID, CM.CORPORATE_ID)
        AND CM.SOB_ID             = W_SOB_ID
        AND CM.ENABLED_FLAG       = DECODE(W_ENABLED_FLAG, 'Y', 'Y', CM.ENABLED_FLAG)
        AND CM.EFFECTIVE_DATE_FR  <= NVL(V_SYSDATE, CM.EFFECTIVE_DATE_FR)
        AND (CM.EFFECTIVE_DATE_TO IS NULL OR CM.EFFECTIVE_DATE_TO >= NVL(V_SYSDATE, CM.EFFECTIVE_DATE_FR))
      ORDER BY CM.CORPORATE_CODE
      ;
  END SELECT_CORPORATE;
/*
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
\*         AND FB.ORG_ID            = P_ORG_ID*\
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
\*         AND FB.ORG_ID                  = W_ORG_ID*\
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
\*         AND FB.ORG_ID                  = W_ORG_ID*\
      ;

  END LU_BANK_SITE;
*/
END FI_CORPORATE_MASTER_G;
/
