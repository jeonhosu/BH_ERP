CREATE OR REPLACE PACKAGE FI_CREDIT_CARD_G
AS

-- 신용카드(법인) 조회.
  PROCEDURE SELECT_CREDIT_CARD
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_CARD_CODE            IN FI_CREDIT_CARD.CARD_CODE%TYPE
            , W_PERSON_ID            IN FI_CREDIT_CARD.USE_PERSON_ID%TYPE
            , W_SOB_ID               IN FI_CREDIT_CARD.SOB_ID%TYPE
            , W_ORG_ID               IN FI_CREDIT_CARD.ORG_ID%TYPE
            );

-- 신용카드(법인) 삽입.
  PROCEDURE INSERT_CREDIT_CARD
            ( P_CARD_CODE             OUT FI_CREDIT_CARD.CARD_CODE%TYPE
            , P_SOB_ID                IN  FI_CREDIT_CARD.SOB_ID%TYPE
            , P_ORG_ID                IN  FI_CREDIT_CARD.ORG_ID%TYPE
            , P_CARD_NUM              IN  FI_CREDIT_CARD.CARD_NUM%TYPE
            , P_CARD_NAME             IN  FI_CREDIT_CARD.CARD_NAME%TYPE
            , P_CARD_ENG_NAME         IN  FI_CREDIT_CARD.CARD_ENG_NAME%TYPE
            , P_CARD_TYPE_ID          IN  FI_CREDIT_CARD.CARD_TYPE_ID%TYPE
            , P_CRAD_CORP_ID          IN  FI_CREDIT_CARD.CRAD_CORP_ID%TYPE
            , P_EXPIRE_PERIOD         IN  VARCHAR2
            , P_BANK_ID               IN  FI_CREDIT_CARD.BANK_ID%TYPE
            , P_BANK_ACCOUNT_ID       IN  FI_CREDIT_CARD.BANK_ACCOUNT_ID%TYPE
            , P_LIMIT_AMOUNT          IN  FI_CREDIT_CARD.LIMIT_AMOUNT%TYPE
            , P_CURRENCY_CODE         IN  FI_CREDIT_CARD.CURRENCY_CODE%TYPE
            , P_CURRENCY_LIMIT_AMOUNT IN  FI_CREDIT_CARD.CURRENCY_LIMIT_AMOUNT%TYPE
            , P_USE_PERSON_ID         IN  FI_CREDIT_CARD.USE_PERSON_ID%TYPE
            , P_ISSU_DATE             IN  FI_CREDIT_CARD.ISSU_DATE%TYPE
            , P_DUE_DATE              IN  FI_CREDIT_CARD.DUE_DATE%TYPE
            , P_CLOSE_DAY             IN  FI_CREDIT_CARD.CLOSE_DAY%TYPE
            , P_SETTLE_DAY            IN  FI_CREDIT_CARD.SETTLE_DAY%TYPE
            , P_REMARK                IN  FI_CREDIT_CARD.REMARK%TYPE
            , P_ENABLED_FLAG          IN  FI_CREDIT_CARD.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR     IN  FI_CREDIT_CARD.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO     IN  FI_CREDIT_CARD.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID               IN  FI_CREDIT_CARD.CREATED_BY%TYPE
            );

-- 신용카드(법인) 수정.
  PROCEDURE UPDATE_CREDIT_CARD
            ( W_CARD_CODE             IN FI_CREDIT_CARD.CARD_CODE%TYPE
            , W_SOB_ID                IN FI_CREDIT_CARD.SOB_ID%TYPE
            , W_ORG_ID                IN FI_CREDIT_CARD.ORG_ID%TYPE
            , P_CARD_NUM              IN FI_CREDIT_CARD.CARD_NUM%TYPE
            , P_CARD_NAME             IN FI_CREDIT_CARD.CARD_NAME%TYPE
            , P_CARD_ENG_NAME         IN FI_CREDIT_CARD.CARD_ENG_NAME%TYPE
            , P_CARD_TYPE_ID          IN FI_CREDIT_CARD.CARD_TYPE_ID%TYPE
            , P_CRAD_CORP_ID          IN FI_CREDIT_CARD.CRAD_CORP_ID%TYPE
            , P_EXPIRE_PERIOD         IN  VARCHAR2
            , P_BANK_ID               IN FI_CREDIT_CARD.BANK_ID%TYPE
            , P_BANK_ACCOUNT_ID       IN FI_CREDIT_CARD.BANK_ACCOUNT_ID%TYPE
            , P_LIMIT_AMOUNT          IN FI_CREDIT_CARD.LIMIT_AMOUNT%TYPE
            , P_CURRENCY_CODE         IN FI_CREDIT_CARD.CURRENCY_CODE%TYPE
            , P_CURRENCY_LIMIT_AMOUNT IN FI_CREDIT_CARD.CURRENCY_LIMIT_AMOUNT%TYPE
            , P_USE_PERSON_ID         IN FI_CREDIT_CARD.USE_PERSON_ID%TYPE
            , P_ISSU_DATE             IN FI_CREDIT_CARD.ISSU_DATE%TYPE
            , P_DUE_DATE              IN FI_CREDIT_CARD.DUE_DATE%TYPE
            , P_CLOSE_DAY             IN FI_CREDIT_CARD.CLOSE_DAY%TYPE
            , P_SETTLE_DAY            IN FI_CREDIT_CARD.SETTLE_DAY%TYPE
            , P_REMARK                IN FI_CREDIT_CARD.REMARK%TYPE
            , P_ENABLED_FLAG          IN FI_CREDIT_CARD.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR     IN FI_CREDIT_CARD.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO     IN FI_CREDIT_CARD.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID               IN FI_CREDIT_CARD.CREATED_BY%TYPE );

---------------------------------------------------------------------------------------------------
-- LOOKUP : 신용카드(법인) 조회.
  PROCEDURE LU_CREDIT_CARD
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_CREDIT_CARD.SOB_ID%TYPE
            , W_ORG_ID               IN FI_CREDIT_CARD.ORG_ID%TYPE
            , W_ENABLED_YN           IN FI_CREDIT_CARD.ENABLED_FLAG%TYPE
            );

END FI_CREDIT_CARD_G; 
/
CREATE OR REPLACE PACKAGE BODY FI_CREDIT_CARD_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_CREDIT_CARD_G
/* Description  : 신용카드 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 신용카드(법인) 조회.
  PROCEDURE SELECT_CREDIT_CARD
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_CARD_CODE            IN FI_CREDIT_CARD.CARD_CODE%TYPE
            , W_PERSON_ID            IN FI_CREDIT_CARD.USE_PERSON_ID%TYPE
            , W_SOB_ID               IN FI_CREDIT_CARD.SOB_ID%TYPE
            , W_ORG_ID               IN FI_CREDIT_CARD.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT CC.CARD_CODE
           , CC.CARD_NUM
           , CC.CARD_NAME
           , CC.CARD_ENG_NAME
           , CC.CARD_TYPE_ID
           , FI_COMMON_G.ID_NAME_F(CC.CARD_TYPE_ID) AS CARD_TYPE_NAME
           , CC.CRAD_CORP_ID
           , FI_COMMON_G.ID_NAME_F(CC.CRAD_CORP_ID) AS CRAD_CORP_NAME
           , TO_CHAR(CC.EXPIRE_DATE, 'YYYY-MM') AS EXPIRE_PERIOD
           , CC.BANK_ID
           , FB.BANK_NAME
           , CC.BANK_ACCOUNT_ID
           , BA.BANK_ACCOUNT_NAME
           , BA.BANK_ACCOUNT_NUM
           , CC.LIMIT_AMOUNT
           , CC.CURRENCY_CODE
           , CC.CURRENCY_CODE AS DISPLAY_CURRENCY_CODE
           , CC.CURRENCY_LIMIT_AMOUNT
           , CC.USE_PERSON_ID
           , HRM_PERSON_MASTER_G.NAME_F(CC.USE_PERSON_ID) AS USE_PERSON_NAME
           , CC.ISSU_DATE
           , CC.DUE_DATE
           , CC.CLOSE_DAY
           , CC.SETTLE_DAY
           , CC.REMARK
           , CC.ENABLED_FLAG
           , CC.EFFECTIVE_DATE_FR
           , CC.EFFECTIVE_DATE_TO
           , EAPP_USER_G.USER_NAME_F(CC.LAST_UPDATED_BY) AS LAST_UPDATED_PERSON
        FROM FI_CREDIT_CARD CC
           , FI_BANK FB
           , FI_BANK_ACCOUNT BA
       WHERE CC.BANK_ID               = FB.BANK_ID(+)
         AND CC.BANK_ACCOUNT_ID       = BA.BANK_ACCOUNT_ID(+)
         AND CC.CARD_CODE             = NVL(W_CARD_CODE, CC.CARD_CODE)
         AND CC.SOB_ID                = W_SOB_ID
/*         AND CC.ORG_ID                = W_ORG_ID*/
         AND NVL(CC.USE_PERSON_ID, 0) = NVL(W_PERSON_ID, NVL(CC.USE_PERSON_ID, 0))
        ;

  END SELECT_CREDIT_CARD;

-- 신용카드(법인) 삽입.
  PROCEDURE INSERT_CREDIT_CARD
            ( P_CARD_CODE             OUT FI_CREDIT_CARD.CARD_CODE%TYPE
            , P_SOB_ID                IN  FI_CREDIT_CARD.SOB_ID%TYPE
            , P_ORG_ID                IN  FI_CREDIT_CARD.ORG_ID%TYPE
            , P_CARD_NUM              IN  FI_CREDIT_CARD.CARD_NUM%TYPE
            , P_CARD_NAME             IN  FI_CREDIT_CARD.CARD_NAME%TYPE
            , P_CARD_ENG_NAME         IN  FI_CREDIT_CARD.CARD_ENG_NAME%TYPE
            , P_CARD_TYPE_ID          IN  FI_CREDIT_CARD.CARD_TYPE_ID%TYPE
            , P_CRAD_CORP_ID          IN  FI_CREDIT_CARD.CRAD_CORP_ID%TYPE
            , P_EXPIRE_PERIOD         IN  VARCHAR2
            , P_BANK_ID               IN  FI_CREDIT_CARD.BANK_ID%TYPE
            , P_BANK_ACCOUNT_ID       IN  FI_CREDIT_CARD.BANK_ACCOUNT_ID%TYPE
            , P_LIMIT_AMOUNT          IN  FI_CREDIT_CARD.LIMIT_AMOUNT%TYPE
            , P_CURRENCY_CODE         IN  FI_CREDIT_CARD.CURRENCY_CODE%TYPE
            , P_CURRENCY_LIMIT_AMOUNT IN  FI_CREDIT_CARD.CURRENCY_LIMIT_AMOUNT%TYPE
            , P_USE_PERSON_ID         IN  FI_CREDIT_CARD.USE_PERSON_ID%TYPE
            , P_ISSU_DATE             IN  FI_CREDIT_CARD.ISSU_DATE%TYPE
            , P_DUE_DATE              IN  FI_CREDIT_CARD.DUE_DATE%TYPE
            , P_CLOSE_DAY             IN  FI_CREDIT_CARD.CLOSE_DAY%TYPE
            , P_SETTLE_DAY            IN  FI_CREDIT_CARD.SETTLE_DAY%TYPE
            , P_REMARK                IN  FI_CREDIT_CARD.REMARK%TYPE
            , P_ENABLED_FLAG          IN  FI_CREDIT_CARD.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR     IN  FI_CREDIT_CARD.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO     IN  FI_CREDIT_CARD.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID               IN  FI_CREDIT_CARD.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE   DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT NUMBER := 0;

  BEGIN
    -- 동일한 카드코드 존재 체크.
    /*BEGIN
      SELECT COUNT(CC.CARD_NUM) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_CREDIT_CARD CC
       WHERE CC.CARD_CODE         = P_CARD_CODE
         AND CC.SOB_ID            = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;*/

    -- 카드코드  자동 채번
    SELECT MAX(TO_NUMBER(SUBSTR(CC.CARD_CODE,2,4)))+1
        INTO P_CARD_CODE
        FROM FI_CREDIT_CARD        CC
       WHERE CC.SOB_ID         = P_SOB_ID
         AND CC.ORG_ID         = P_ORG_ID
    ;

    P_CARD_CODE := 'C' || LPAD(TO_CHAR(P_CARD_CODE),4,'0');

    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;

    -- 동일한 카드번호 존재 체크.
    BEGIN
      SELECT COUNT(CC.CARD_NUM) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_CREDIT_CARD CC
       WHERE CC.CARD_NUM          = P_CARD_NUM
         AND CC.SOB_ID            = P_SOB_ID
/*         AND CC.ORG_ID            = P_ORG_ID*/
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;

    INSERT INTO FI_CREDIT_CARD
    ( CARD_CODE
    , SOB_ID
    , ORG_ID
    , CARD_NUM
    , CARD_NAME
    , CARD_ENG_NAME
    , CARD_TYPE_ID
    , CRAD_CORP_ID
    , EXPIRE_DATE
    , BANK_ID
    , BANK_ACCOUNT_ID
    , LIMIT_AMOUNT
    , CURRENCY_CODE
    , CURRENCY_LIMIT_AMOUNT
    , USE_PERSON_ID
    , ISSU_DATE
    , DUE_DATE
    , CLOSE_DAY
    , SETTLE_DAY
    , REMARK
    , ENABLED_FLAG
    , EFFECTIVE_DATE_FR
    , EFFECTIVE_DATE_TO
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY )
    VALUES
    ( P_CARD_CODE
    , P_SOB_ID
    , P_ORG_ID
    , P_CARD_NUM
    , P_CARD_NAME
    , P_CARD_ENG_NAME
    , P_CARD_TYPE_ID
    , P_CRAD_CORP_ID
    , TO_DATE(P_EXPIRE_PERIOD, 'YYYY-MM')
    , P_BANK_ID
    , P_BANK_ACCOUNT_ID
    , P_LIMIT_AMOUNT
    , P_CURRENCY_CODE
    , P_CURRENCY_LIMIT_AMOUNT
    , P_USE_PERSON_ID
    , P_ISSU_DATE
    , P_DUE_DATE
    , P_CLOSE_DAY
    , P_SETTLE_DAY
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
  END INSERT_CREDIT_CARD;

-- 신용카드(법인) 수정.
  PROCEDURE UPDATE_CREDIT_CARD
            ( W_CARD_CODE             IN FI_CREDIT_CARD.CARD_CODE%TYPE
            , W_SOB_ID                IN FI_CREDIT_CARD.SOB_ID%TYPE
            , W_ORG_ID                IN FI_CREDIT_CARD.ORG_ID%TYPE
            , P_CARD_NUM              IN FI_CREDIT_CARD.CARD_NUM%TYPE
            , P_CARD_NAME             IN FI_CREDIT_CARD.CARD_NAME%TYPE
            , P_CARD_ENG_NAME         IN FI_CREDIT_CARD.CARD_ENG_NAME%TYPE
            , P_CARD_TYPE_ID          IN FI_CREDIT_CARD.CARD_TYPE_ID%TYPE
            , P_CRAD_CORP_ID          IN FI_CREDIT_CARD.CRAD_CORP_ID%TYPE
            , P_EXPIRE_PERIOD         IN  VARCHAR2
            , P_BANK_ID               IN FI_CREDIT_CARD.BANK_ID%TYPE
            , P_BANK_ACCOUNT_ID       IN FI_CREDIT_CARD.BANK_ACCOUNT_ID%TYPE
            , P_LIMIT_AMOUNT          IN FI_CREDIT_CARD.LIMIT_AMOUNT%TYPE
            , P_CURRENCY_CODE         IN FI_CREDIT_CARD.CURRENCY_CODE%TYPE
            , P_CURRENCY_LIMIT_AMOUNT IN FI_CREDIT_CARD.CURRENCY_LIMIT_AMOUNT%TYPE
            , P_USE_PERSON_ID         IN FI_CREDIT_CARD.USE_PERSON_ID%TYPE
            , P_ISSU_DATE             IN FI_CREDIT_CARD.ISSU_DATE%TYPE
            , P_DUE_DATE              IN FI_CREDIT_CARD.DUE_DATE%TYPE
            , P_CLOSE_DAY             IN FI_CREDIT_CARD.CLOSE_DAY%TYPE
            , P_SETTLE_DAY            IN FI_CREDIT_CARD.SETTLE_DAY%TYPE
            , P_REMARK                IN FI_CREDIT_CARD.REMARK%TYPE
            , P_ENABLED_FLAG          IN FI_CREDIT_CARD.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR     IN FI_CREDIT_CARD.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO     IN FI_CREDIT_CARD.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID               IN FI_CREDIT_CARD.CREATED_BY%TYPE )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN

     UPDATE FI_CREDIT_CARD
        SET CARD_NUM              = P_CARD_NUM
          , CARD_NAME             = P_CARD_NAME
          , CARD_ENG_NAME         = P_CARD_ENG_NAME
          , CARD_TYPE_ID          = P_CARD_TYPE_ID
          , CRAD_CORP_ID          = P_CRAD_CORP_ID
          , EXPIRE_DATE           = TO_DATE(P_EXPIRE_PERIOD, 'YYYY-MM')
          , BANK_ID               = P_BANK_ID
          , BANK_ACCOUNT_ID       = P_BANK_ACCOUNT_ID
          , LIMIT_AMOUNT          = P_LIMIT_AMOUNT
          , CURRENCY_CODE         = P_CURRENCY_CODE
          , CURRENCY_LIMIT_AMOUNT = P_CURRENCY_LIMIT_AMOUNT
          , USE_PERSON_ID         = P_USE_PERSON_ID
          , ISSU_DATE             = P_ISSU_DATE
          , DUE_DATE              = P_DUE_DATE
          , CLOSE_DAY             = P_CLOSE_DAY
          , SETTLE_DAY            = P_SETTLE_DAY
          , REMARK                = P_REMARK
          , ENABLED_FLAG          = P_ENABLED_FLAG
          , EFFECTIVE_DATE_FR     = P_EFFECTIVE_DATE_FR
          , EFFECTIVE_DATE_TO     = P_EFFECTIVE_DATE_TO
          , LAST_UPDATE_DATE      = V_SYSDATE
          , LAST_UPDATED_BY       = P_USER_ID
     WHERE CARD_CODE             = W_CARD_CODE
       AND SOB_ID                = W_SOB_ID
    ;

  END UPDATE_CREDIT_CARD;

---------------------------------------------------------------------------------------------------
-- LOOKUP : 신용카드(법인) 조회.
  PROCEDURE LU_CREDIT_CARD
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_CREDIT_CARD.SOB_ID%TYPE
            , W_ORG_ID               IN FI_CREDIT_CARD.ORG_ID%TYPE
            , W_ENABLED_YN           IN FI_CREDIT_CARD.ENABLED_FLAG%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT CC.CARD_NAME
           , CC.CARD_NUM
           , CC.CARD_CODE
        FROM FI_CREDIT_CARD CC
       WHERE CC.SOB_ID                = W_SOB_ID
         AND CC.ENABLED_FLAG          = DECODE(W_ENABLED_YN, 'Y', W_ENABLED_YN, CC.ENABLED_FLAG)
/*         AND CC.ORG_ID                = W_ORG_ID*/
        ;
  END LU_CREDIT_CARD;

END FI_CREDIT_CARD_G; 
/
