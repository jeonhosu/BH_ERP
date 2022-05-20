CREATE OR REPLACE PACKAGE "FI_ACCOUNT_BOOK_G"
AS

-- 회계장부 조회.
  PROCEDURE SELECT_ACCOUNT_BOOK
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_ACCOUNT_BOOK_CODE    IN FI_ACCOUNT_BOOK.ACCOUNT_BOOK_CODE%TYPE
            , W_SOB_ID               IN FI_ACCOUNT_BOOK.SOB_ID%TYPE
            );

-- 회계장부 삽입.
  PROCEDURE INSERT_ACCOUNT_BOOK
            ( P_ACCOUNT_BOOK_ID             OUT FI_ACCOUNT_BOOK.ACCOUNT_BOOK_ID%TYPE
            , P_SOB_ID                      IN FI_ACCOUNT_BOOK.SOB_ID%TYPE
            , P_ACCOUNT_BOOK_CODE           IN FI_ACCOUNT_BOOK.ACCOUNT_BOOK_CODE%TYPE
            , P_ACCOUNT_BOOK_NAME           IN FI_ACCOUNT_BOOK.ACCOUNT_BOOK_NAME%TYPE
            , P_ACCOUNT_BOOK_NAME_S         IN FI_ACCOUNT_BOOK.ACCOUNT_BOOK_NAME_S%TYPE
            , P_ACCOUNT_SET_ID              IN FI_ACCOUNT_BOOK.ACCOUNT_SET_ID%TYPE
            , P_FISCAL_CALENDAR_ID          IN FI_ACCOUNT_BOOK.FISCAL_CALENDAR_ID%TYPE
            , P_FUTURE_OPEN_PERIOD_COUNT    IN FI_ACCOUNT_BOOK.FUTURE_OPEN_PERIOD_COUNT%TYPE
            , P_CURRENCY_CODE               IN FI_ACCOUNT_BOOK.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE_TYPE          IN FI_ACCOUNT_BOOK.EXCHANGE_RATE_TYPE%TYPE
            , P_EXCHANGE_PROFIT_ACCOUNT_ID  IN FI_ACCOUNT_BOOK.EXCHANGE_PROFIT_ACCOUNT_ID%TYPE
            , P_EXCHANGE_LOSS_ACCOUNT_ID    IN FI_ACCOUNT_BOOK.EXCHANGE_LOSS_ACCOUNT_ID%TYPE
            , P_BUDGET_CONTROL_YN           IN FI_ACCOUNT_BOOK.BUDGET_CONTROL_YN%TYPE
            , P_DEPT_LEVEL                  IN FI_ACCOUNT_BOOK.DEPT_LEVEL%TYPE
            , P_OPERATING_FLAG              IN FI_ACCOUNT_BOOK.OPERATING_FLAG%TYPE
            , P_REMARK                      IN FI_ACCOUNT_BOOK.REMARK%TYPE
            , P_USER_ID                     IN FI_ACCOUNT_BOOK.CREATED_BY%TYPE
            );

-- 회계장부 수정.
  PROCEDURE UPDATE_ACCOUNT_BOOK
            ( W_ACCOUNT_BOOK_ID             IN FI_ACCOUNT_BOOK.ACCOUNT_BOOK_ID%TYPE
            , P_SOB_ID                      IN FI_ACCOUNT_BOOK.SOB_ID%TYPE
            , P_ACCOUNT_BOOK_NAME           IN FI_ACCOUNT_BOOK.ACCOUNT_BOOK_NAME%TYPE
            , P_ACCOUNT_BOOK_NAME_S         IN FI_ACCOUNT_BOOK.ACCOUNT_BOOK_NAME_S%TYPE
            , P_ACCOUNT_SET_ID              IN FI_ACCOUNT_BOOK.ACCOUNT_SET_ID%TYPE
            , P_FISCAL_CALENDAR_ID          IN FI_ACCOUNT_BOOK.FISCAL_CALENDAR_ID%TYPE
            , P_FUTURE_OPEN_PERIOD_COUNT    IN FI_ACCOUNT_BOOK.FUTURE_OPEN_PERIOD_COUNT%TYPE
            , P_CURRENCY_CODE               IN FI_ACCOUNT_BOOK.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE_TYPE          IN FI_ACCOUNT_BOOK.EXCHANGE_RATE_TYPE%TYPE
            , P_EXCHANGE_PROFIT_ACCOUNT_ID  IN FI_ACCOUNT_BOOK.EXCHANGE_PROFIT_ACCOUNT_ID%TYPE
            , P_EXCHANGE_LOSS_ACCOUNT_ID    IN FI_ACCOUNT_BOOK.EXCHANGE_LOSS_ACCOUNT_ID%TYPE
            , P_BUDGET_CONTROL_YN           IN FI_ACCOUNT_BOOK.BUDGET_CONTROL_YN%TYPE
            , P_DEPT_LEVEL                  IN FI_ACCOUNT_BOOK.DEPT_LEVEL%TYPE
            , P_OPERATING_FLAG              IN FI_ACCOUNT_BOOK.OPERATING_FLAG%TYPE
            , P_REMARK                      IN FI_ACCOUNT_BOOK.REMARK%TYPE
            , P_USER_ID                     IN FI_ACCOUNT_BOOK.CREATED_BY%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 운영회계장부 값.
  FUNCTION OPERATING_ACCOUNT_BOOK_COUNT_F
            ( W_SOB_ID            IN NUMBER
            , W_ACCOUNT_BOOK_ID   IN NUMBER DEFAULT 0
            ) RETURN NUMBER;

-- 운영회계 장부.
  FUNCTION OPERATING_ACCOUNT_BOOK_F
            ( W_SOB_ID            IN NUMBER
            ) RETURN NUMBER;

-- 운영회계 장부의 계정세트.
  FUNCTION OPERATING_ACCOUNT_SET_F
            ( W_SOB_ID            IN NUMBER
            ) RETURN NUMBER;

-- 운영회계 장부의 회계달력.
  FUNCTION OPERATING_FISCAL_CALENDAR_F
            ( W_SOB_ID            IN NUMBER
            ) RETURN NUMBER;

-- 운영 회계장부 기본 통화.
  FUNCTION BASE_CURRENCY_F
            ( W_SOB_ID            IN NUMBER
            ) RETURN VARCHAR2;

-- 운영 회계장부 기본 통화.
  PROCEDURE BASE_CURRENCY
            ( W_SOB_ID            IN NUMBER
            , O_CURRENCY_CODE     OUT VARCHAR2
            );

-- 운영 회계장부 환차손익 계정ID.
  FUNCTION  EXCHANGE_PROFIT_LOSS_ID_F
            ( W_SOB_ID            IN NUMBER
            , W_CONVERSION_AMOUNT IN NUMBER
            ) RETURN NUMBER;

  PROCEDURE EXCHANGE_PROFIT_LOSS_P
            ( W_SOB_ID            IN NUMBER
            , W_CONVERSION_AMOUNT IN NUMBER
            , O_ACCOUNT_ID        OUT NUMBER
            , O_ACCOUNT_CODE      OUT VARCHAR2
            , O_ACCOUNT_DESC      OUT VARCHAR2
            , O_ACCOUNT_DR_CR       OUT VARCHAR2
            , O_ACCOUNT_DR_CR_NAME  OUT VARCHAR2
            );

-- 운영 회계장부 환차이익 계정 ID.
  FUNCTION EXCHANGE_PROFIT_ACCOUNT_ID_F
            ( W_SOB_ID            IN NUMBER
            ) RETURN NUMBER;

  PROCEDURE EXCHANGE_PROFIT_ACCOUNT_P
            ( W_SOB_ID            IN NUMBER
            , O_ACCOUNT_ID        OUT NUMBER
            , O_ACCOUNT_CODE      OUT VARCHAR2
            , O_ACCOUNT_DESC      OUT VARCHAR2
            );

-- 운영 회계장부 환차손실 계정 ID.
  FUNCTION EXCHANGE_LOSS_ACCOUNT_ID_F
            ( W_SOB_ID            IN NUMBER
            ) RETURN NUMBER;

  PROCEDURE EXCHANGE_LOSS_ACCOUNT_P
            ( W_SOB_ID            IN NUMBER
            , O_ACCOUNT_ID        OUT NUMBER
            , O_ACCOUNT_CODE      OUT VARCHAR2
            , O_ACCOUNT_DESC      OUT VARCHAR2
            );

---------------------------------------------------------------------------------------------------
-- 회계장부 조회.
  PROCEDURE LU_ACCOUNT_BOOK
            ( P_CURSOR3           OUT TYPES.TCURSOR
            , W_SOB_ID            IN FI_ACCOUNT_BOOK.SOB_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 운영 회계장부 리턴.
  PROCEDURE DV_OPERATING_ACCOUNT_BOOK
            ( W_SOB_ID            IN NUMBER
            , O_ACCOUNT_BOOK_ID   OUT NUMBER
            , O_ACCOUNT_BOOK_CODE OUT VARCHAR2
            , O_ACCOUNT_BOOK_NAME OUT VARCHAR2
            , O_ACCOUNT_SET_ID    OUT NUMBER
            , O_FISCAL_CALENDAR_ID OUT NUMBER
            , O_CURRENCY_CODE     OUT VARCHAR2
            , O_EXCHANGE_RATE_TYPE OUT VARCHAR2
            , O_BUDGET_CONTROL_YN OUT VARCHAR2
            , O_DEPT_LEVEL        OUT NUMBER
            , O_SOB_DESCRIPTION   OUT VARCHAR2
            );

END FI_ACCOUNT_BOOK_G; 
 

 
/
CREATE OR REPLACE PACKAGE BODY "FI_ACCOUNT_BOOK_G"
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_ACCOUNT_BOOK_G
/* Description  : 회계장부 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 회계장부 조회.
  PROCEDURE SELECT_ACCOUNT_BOOK
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_ACCOUNT_BOOK_CODE    IN FI_ACCOUNT_BOOK.ACCOUNT_BOOK_CODE%TYPE
            , W_SOB_ID               IN FI_ACCOUNT_BOOK.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT AB.ACCOUNT_BOOK_ID
           , AB.ACCOUNT_BOOK_CODE
           , AB.ACCOUNT_BOOK_NAME
           , AB.ACCOUNT_BOOK_NAME_S
           , AB.ACCOUNT_SET_ID
           , GAS.ACCOUNT_SET_CODE
           , GAS.ACCOUNT_SET_NAME
           , AB.FISCAL_CALENDAR_ID
           , FC.FISCAL_CALENDAR_CODE
           , FC.FISCAL_CALENDAR_NAME
           , AB.FUTURE_OPEN_PERIOD_COUNT
           , AB.CURRENCY_CODE
           , ECT.CURRENCY_DESC
           , AB.EXCHANGE_RATE_TYPE
           , ERT.EXCHANGE_RATE_TYPE_DESC
           , AB.EXCHANGE_PROFIT_ACCOUNT_ID
           , FI_ACCOUNT_CONTROL_G.ACCOUNT_CODE_F(AB.EXCHANGE_PROFIT_ACCOUNT_ID, AB.SOB_ID) AS EXCHANGE_PROFIT_ACCOUNT_CODE
           , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(AB.EXCHANGE_PROFIT_ACCOUNT_ID, AB.SOB_ID) AS EXCHANGE_PROFIT_ACCOUNT_DESC
           , AB.EXCHANGE_LOSS_ACCOUNT_ID
           , FI_ACCOUNT_CONTROL_G.ACCOUNT_CODE_F(AB.EXCHANGE_LOSS_ACCOUNT_ID, AB.SOB_ID) AS EXCHANGE_LOSS_ACCOUNT_CODE
           , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(AB.EXCHANGE_LOSS_ACCOUNT_ID, AB.SOB_ID) AS EXCHANGE_LOSS_ACCOUNT_DESC
           , AB.BUDGET_CONTROL_YN
           , AB.DEPT_LEVEL
           , AB.OPERATING_FLAG
           , AB.REMARK
           , AB.LAST_UPDATE_DATE
           , AB.LAST_UPDATED_BY
        FROM FI_ACCOUNT_BOOK AB
          , FI_ACCOUNT_SET GAS
          , GL_FISCAL_CALENDAR FC
          , EAPP_CURRENCY_TLV ECT
          , ( SELECT LET.ENTRY_CODE AS EXCHANGE_RATE_TYPE
                   , LET.ENTRY_DESCRIPTION AS EXCHANGE_RATE_TYPE_DESC
                   , LET.SOB_ID
                   , LET.ORG_ID
                FROM EAPP_LOOKUP_ENTRY_TLV LET
               WHERE LET.LOOKUP_MODULE          = 'EAPP'
                 AND LET.LOOKUP_TYPE            = 'EXCHANGE_RATE_TYPE'
                 AND LET.SOB_ID                 = W_SOB_ID
                 AND LET.ORG_ID                 = FI_COMMON_G.OPERATING_ORG_F(W_SOB_ID)
            ) ERT
       WHERE AB.ACCOUNT_SET_ID          = GAS.ACCOUNT_SET_ID(+)
         AND AB.FISCAL_CALENDAR_ID      = FC.FISCAL_CALENDAR_ID(+)
         AND AB.CURRENCY_CODE           = ECT.CURRENCY_CODE(+)
         AND AB.SOB_ID                  = ECT.SOB_ID(+)
         AND AB.EXCHANGE_RATE_TYPE      = ERT.EXCHANGE_RATE_TYPE(+)
         AND AB.SOB_ID                  = ERT.SOB_ID(+)
         AND AB.ACCOUNT_BOOK_CODE       = NVL(W_ACCOUNT_BOOK_CODE, AB.ACCOUNT_BOOK_CODE)
         AND AB.SOB_ID                  = W_SOB_ID
      ORDER BY AB.ACCOUNT_BOOK_CODE
      ;

  END SELECT_ACCOUNT_BOOK;

-- 회계장부 삽입.
  PROCEDURE INSERT_ACCOUNT_BOOK
            ( P_ACCOUNT_BOOK_ID             OUT FI_ACCOUNT_BOOK.ACCOUNT_BOOK_ID%TYPE
            , P_SOB_ID                      IN FI_ACCOUNT_BOOK.SOB_ID%TYPE
            , P_ACCOUNT_BOOK_CODE           IN FI_ACCOUNT_BOOK.ACCOUNT_BOOK_CODE%TYPE
            , P_ACCOUNT_BOOK_NAME           IN FI_ACCOUNT_BOOK.ACCOUNT_BOOK_NAME%TYPE
            , P_ACCOUNT_BOOK_NAME_S         IN FI_ACCOUNT_BOOK.ACCOUNT_BOOK_NAME_S%TYPE
            , P_ACCOUNT_SET_ID              IN FI_ACCOUNT_BOOK.ACCOUNT_SET_ID%TYPE
            , P_FISCAL_CALENDAR_ID          IN FI_ACCOUNT_BOOK.FISCAL_CALENDAR_ID%TYPE
            , P_FUTURE_OPEN_PERIOD_COUNT    IN FI_ACCOUNT_BOOK.FUTURE_OPEN_PERIOD_COUNT%TYPE
            , P_CURRENCY_CODE               IN FI_ACCOUNT_BOOK.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE_TYPE          IN FI_ACCOUNT_BOOK.EXCHANGE_RATE_TYPE%TYPE
            , P_EXCHANGE_PROFIT_ACCOUNT_ID  IN FI_ACCOUNT_BOOK.EXCHANGE_PROFIT_ACCOUNT_ID%TYPE
            , P_EXCHANGE_LOSS_ACCOUNT_ID    IN FI_ACCOUNT_BOOK.EXCHANGE_LOSS_ACCOUNT_ID%TYPE
            , P_BUDGET_CONTROL_YN           IN FI_ACCOUNT_BOOK.BUDGET_CONTROL_YN%TYPE
            , P_DEPT_LEVEL                  IN FI_ACCOUNT_BOOK.DEPT_LEVEL%TYPE
            , P_OPERATING_FLAG              IN FI_ACCOUNT_BOOK.OPERATING_FLAG%TYPE
            , P_REMARK                      IN FI_ACCOUNT_BOOK.REMARK%TYPE
            , P_USER_ID                     IN FI_ACCOUNT_BOOK.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE   DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT NUMBER := 0;

  BEGIN
    -- 동일한 회계장부코드 존재 체크.
    BEGIN
      SELECT COUNT(AB.ACCOUNT_BOOK_CODE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_ACCOUNT_BOOK AB
       WHERE AB.SOB_ID            = P_SOB_ID
         AND AB.ACCOUNT_BOOK_CODE = P_ACCOUNT_BOOK_CODE
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;

    -- 운영 회계장부 존재 여부 체크.
    IF OPERATING_ACCOUNT_BOOK_COUNT_F(P_SOB_ID, P_ACCOUNT_BOOK_ID) <> 0 THEN
      RAISE ERRNUMS.Account_Book_Duplication;
    END IF;

    SELECT FI_ACCOUNT_BOOK_S1.NEXTVAL
      INTO P_ACCOUNT_BOOK_ID
      FROM DUAL;

    INSERT INTO FI_ACCOUNT_BOOK
    ( ACCOUNT_BOOK_ID
    , SOB_ID
    , ACCOUNT_BOOK_CODE
    , ACCOUNT_BOOK_NAME
    , ACCOUNT_BOOK_NAME_S
    , ACCOUNT_SET_ID
    , FISCAL_CALENDAR_ID
    , FUTURE_OPEN_PERIOD_COUNT
    , CURRENCY_CODE
    , EXCHANGE_RATE_TYPE
    , EXCHANGE_PROFIT_ACCOUNT_ID
    , EXCHANGE_LOSS_ACCOUNT_ID
    , BUDGET_CONTROL_YN
    , DEPT_LEVEL
    , OPERATING_FLAG
    , REMARK
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY )
    VALUES
    ( P_ACCOUNT_BOOK_ID
    , P_SOB_ID
    , P_ACCOUNT_BOOK_CODE
    , P_ACCOUNT_BOOK_NAME
    , P_ACCOUNT_BOOK_NAME_S
    , P_ACCOUNT_SET_ID
    , P_FISCAL_CALENDAR_ID
    , P_FUTURE_OPEN_PERIOD_COUNT
    , P_CURRENCY_CODE
    , P_EXCHANGE_RATE_TYPE
    , P_EXCHANGE_PROFIT_ACCOUNT_ID
    , P_EXCHANGE_LOSS_ACCOUNT_ID
    , P_BUDGET_CONTROL_YN
    , P_DEPT_LEVEL
    , P_OPERATING_FLAG
    , P_REMARK
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );

  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
    WHEN ERRNUMS.Account_Book_Duplication THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Account_Book_Duplication_Code, ERRNUMS.Account_Book_Duplication_Desc);
  END INSERT_ACCOUNT_BOOK;

-- 회계장부 수정.
  PROCEDURE UPDATE_ACCOUNT_BOOK
            ( W_ACCOUNT_BOOK_ID             IN FI_ACCOUNT_BOOK.ACCOUNT_BOOK_ID%TYPE
            , P_SOB_ID                      IN FI_ACCOUNT_BOOK.SOB_ID%TYPE
            , P_ACCOUNT_BOOK_NAME           IN FI_ACCOUNT_BOOK.ACCOUNT_BOOK_NAME%TYPE
            , P_ACCOUNT_BOOK_NAME_S         IN FI_ACCOUNT_BOOK.ACCOUNT_BOOK_NAME_S%TYPE
            , P_ACCOUNT_SET_ID              IN FI_ACCOUNT_BOOK.ACCOUNT_SET_ID%TYPE
            , P_FISCAL_CALENDAR_ID          IN FI_ACCOUNT_BOOK.FISCAL_CALENDAR_ID%TYPE
            , P_FUTURE_OPEN_PERIOD_COUNT    IN FI_ACCOUNT_BOOK.FUTURE_OPEN_PERIOD_COUNT%TYPE
            , P_CURRENCY_CODE               IN FI_ACCOUNT_BOOK.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE_TYPE          IN FI_ACCOUNT_BOOK.EXCHANGE_RATE_TYPE%TYPE
            , P_EXCHANGE_PROFIT_ACCOUNT_ID  IN FI_ACCOUNT_BOOK.EXCHANGE_PROFIT_ACCOUNT_ID%TYPE
            , P_EXCHANGE_LOSS_ACCOUNT_ID    IN FI_ACCOUNT_BOOK.EXCHANGE_LOSS_ACCOUNT_ID%TYPE
            , P_BUDGET_CONTROL_YN           IN FI_ACCOUNT_BOOK.BUDGET_CONTROL_YN%TYPE
            , P_DEPT_LEVEL                  IN FI_ACCOUNT_BOOK.DEPT_LEVEL%TYPE
            , P_OPERATING_FLAG              IN FI_ACCOUNT_BOOK.OPERATING_FLAG%TYPE
            , P_REMARK                      IN FI_ACCOUNT_BOOK.REMARK%TYPE
            , P_USER_ID                     IN FI_ACCOUNT_BOOK.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
  -- 운영 회계장부 존재 여부 체크.
    IF OPERATING_ACCOUNT_BOOK_COUNT_F(P_SOB_ID, W_ACCOUNT_BOOK_ID) <> 0 THEN
      RAISE ERRNUMS.Account_Book_Duplication;
    END IF;

    UPDATE FI_ACCOUNT_BOOK
      SET ACCOUNT_BOOK_NAME           = P_ACCOUNT_BOOK_NAME
        , ACCOUNT_BOOK_NAME_S         = P_ACCOUNT_BOOK_NAME_S
        , ACCOUNT_SET_ID              = P_ACCOUNT_SET_ID
        , FISCAL_CALENDAR_ID          = P_FISCAL_CALENDAR_ID
        , FUTURE_OPEN_PERIOD_COUNT    = P_FUTURE_OPEN_PERIOD_COUNT
        , CURRENCY_CODE               = P_CURRENCY_CODE
        , EXCHANGE_RATE_TYPE          = P_EXCHANGE_RATE_TYPE
        , EXCHANGE_PROFIT_ACCOUNT_ID  = P_EXCHANGE_PROFIT_ACCOUNT_ID
        , EXCHANGE_LOSS_ACCOUNT_ID    = P_EXCHANGE_LOSS_ACCOUNT_ID
        , BUDGET_CONTROL_YN           = P_BUDGET_CONTROL_YN
        , DEPT_LEVEL                  = P_DEPT_LEVEL
        , OPERATING_FLAG              = P_OPERATING_FLAG
        , REMARK                      = P_REMARK
        , LAST_UPDATE_DATE            = V_SYSDATE
        , LAST_UPDATED_BY             = P_USER_ID
    WHERE ACCOUNT_BOOK_ID             = W_ACCOUNT_BOOK_ID;

  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
    WHEN ERRNUMS.Account_Book_Duplication THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Account_Book_Duplication_Code, ERRNUMS.Account_Book_Duplication_Desc);
  END UPDATE_ACCOUNT_BOOK;

---------------------------------------------------------------------------------------------------
-- 운영 회계장부 체크.
  FUNCTION OPERATING_ACCOUNT_BOOK_COUNT_F
            ( W_SOB_ID            IN NUMBER
            , W_ACCOUNT_BOOK_ID   IN NUMBER DEFAULT 0
            ) RETURN NUMBER
  AS
    V_RECORD_COUNT NUMBER := 0;

  BEGIN
    -- 운영 회계장부 존재 여부 체크.
    BEGIN
      SELECT COUNT(AB.ACCOUNT_BOOK_CODE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_ACCOUNT_BOOK AB
       WHERE AB.ACCOUNT_BOOK_ID   <> W_ACCOUNT_BOOK_ID
         AND AB.SOB_ID            = W_SOB_ID
         AND AB.OPERATING_FLAG    = 'Y'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    RETURN V_RECORD_COUNT;

  END OPERATING_ACCOUNT_BOOK_COUNT_F;

-- 운영회계 장부.
  FUNCTION OPERATING_ACCOUNT_BOOK_F
            ( W_SOB_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_ACCOUNT_BOOK_ID             NUMBER := NULL;

  BEGIN
    BEGIN
      SELECT AB.ACCOUNT_BOOK_ID
        INTO V_ACCOUNT_BOOK_ID
        FROM FI_ACCOUNT_BOOK AB
       WHERE AB.SOB_ID                  = W_SOB_ID
         AND AB.OPERATING_FLAG          = 'Y'
         AND ROWNUM                     <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ACCOUNT_BOOK_ID := NULL;
    END;
    RETURN V_ACCOUNT_BOOK_ID;

  END OPERATING_ACCOUNT_BOOK_F;

-- 운영회계 장부의 계정세트.
  FUNCTION OPERATING_ACCOUNT_SET_F
            ( W_SOB_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_ACCOUNT_SET_ID              NUMBER := NULL;

  BEGIN
    BEGIN
      SELECT AB.ACCOUNT_SET_ID
        INTO V_ACCOUNT_SET_ID
        FROM FI_ACCOUNT_BOOK AB
       WHERE AB.SOB_ID                  = W_SOB_ID
         AND AB.OPERATING_FLAG          = 'Y'
         AND ROWNUM                     <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ACCOUNT_SET_ID := NULL;
    END;
    RETURN V_ACCOUNT_SET_ID;

  END OPERATING_ACCOUNT_SET_F;

-- 운영회계 장부의 회계달력.
  FUNCTION OPERATING_FISCAL_CALENDAR_F
            ( W_SOB_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_FISCAL_CALENDAR_ID          NUMBER := NULL;

  BEGIN
    BEGIN
      SELECT AB.FISCAL_CALENDAR_ID
        INTO V_FISCAL_CALENDAR_ID
        FROM FI_ACCOUNT_BOOK AB
       WHERE AB.SOB_ID                  = W_SOB_ID
         AND AB.OPERATING_FLAG          = 'Y'
         AND ROWNUM                     <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_FISCAL_CALENDAR_ID := NULL;
    END;
    RETURN V_FISCAL_CALENDAR_ID;

  END OPERATING_FISCAL_CALENDAR_F;

-- 운영 회계장부 기본 통화.
  FUNCTION BASE_CURRENCY_F
            ( W_SOB_ID            IN NUMBER
            ) RETURN VARCHAR2
  AS
    V_CURRENCY_CODE               VARCHAR2(10);

  BEGIN
    BEGIN
      SELECT AB.CURRENCY_CODE
        INTO V_CURRENCY_CODE
        FROM FI_ACCOUNT_BOOK AB
       WHERE AB.SOB_ID            = W_SOB_ID
         AND AB.OPERATING_FLAG    = 'Y'
         AND ROWNUM               <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CURRENCY_CODE := 'KRW';
    END;
    RETURN V_CURRENCY_CODE;

  END BASE_CURRENCY_F;

-- 운영 회계장부 기본 통화.
  PROCEDURE BASE_CURRENCY
            ( W_SOB_ID            IN NUMBER
            , O_CURRENCY_CODE     OUT VARCHAR2
            )
  AS
  BEGIN
    BEGIN
      SELECT AB.CURRENCY_CODE
        INTO O_CURRENCY_CODE
        FROM FI_ACCOUNT_BOOK AB
       WHERE AB.SOB_ID            = W_SOB_ID
         AND AB.OPERATING_FLAG    = 'Y'
         AND ROWNUM               <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      O_CURRENCY_CODE := 'KRW';
    END;

  END BASE_CURRENCY;

-- 운영 회계장부 환차손익 계정ID.
  FUNCTION  EXCHANGE_PROFIT_LOSS_ID_F
            ( W_SOB_ID            IN NUMBER
            , W_CONVERSION_AMOUNT IN NUMBER
            ) RETURN NUMBER
  AS
    V_ACCOUNT_ID                  NUMBER;

  BEGIN
    IF W_CONVERSION_AMOUNT < 0 THEN
    -- 환차 손실.
      V_ACCOUNT_ID := EXCHANGE_LOSS_ACCOUNT_ID_F(W_SOB_ID);
    ELSE
    -- 환차 이익.
      V_ACCOUNT_ID := EXCHANGE_PROFIT_ACCOUNT_ID_F(W_SOB_ID);
    END IF;
    RETURN V_ACCOUNT_ID;

  END EXCHANGE_PROFIT_LOSS_ID_F;

  PROCEDURE EXCHANGE_PROFIT_LOSS_P
            ( W_SOB_ID            IN NUMBER
            , W_CONVERSION_AMOUNT IN NUMBER
            , O_ACCOUNT_ID        OUT NUMBER
            , O_ACCOUNT_CODE      OUT VARCHAR2
            , O_ACCOUNT_DESC      OUT VARCHAR2
            , O_ACCOUNT_DR_CR       OUT VARCHAR2
            , O_ACCOUNT_DR_CR_NAME  OUT VARCHAR2
            )
  AS
  BEGIN
    IF W_CONVERSION_AMOUNT < 0 THEN
    -- 환차 손실.
      O_ACCOUNT_DR_CR := '1';
      EXCHANGE_LOSS_ACCOUNT_P ( W_SOB_ID => W_SOB_ID
                              , O_ACCOUNT_ID => O_ACCOUNT_ID
                              , O_ACCOUNT_CODE => O_ACCOUNT_CODE
                              , O_ACCOUNT_DESC => O_ACCOUNT_DESC
                              );
    ELSE
    -- 환차 이익.
      O_ACCOUNT_DR_CR := '2';
      EXCHANGE_PROFIT_ACCOUNT_P( W_SOB_ID => W_SOB_ID
                              , O_ACCOUNT_ID => O_ACCOUNT_ID
                              , O_ACCOUNT_CODE => O_ACCOUNT_CODE
                              , O_ACCOUNT_DESC => O_ACCOUNT_DESC
                              );
    END IF;
    O_ACCOUNT_DR_CR_NAME := FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', O_ACCOUNT_DR_CR, W_SOB_ID);

  END EXCHANGE_PROFIT_LOSS_P;

  -- 운영 회계장부 환차이익 계정 ID.
  FUNCTION EXCHANGE_PROFIT_ACCOUNT_ID_F
            ( W_SOB_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_ACCOUNT_ID                  NUMBER;

  BEGIN
    BEGIN
      SELECT AB.EXCHANGE_PROFIT_ACCOUNT_ID
        INTO V_ACCOUNT_ID
        FROM FI_ACCOUNT_BOOK AB
       WHERE AB.SOB_ID            = W_SOB_ID
         AND AB.OPERATING_FLAG    = 'Y'
         AND ROWNUM               <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ACCOUNT_ID := NULL;
    END;
    RETURN V_ACCOUNT_ID;

  END EXCHANGE_PROFIT_ACCOUNT_ID_F;

  PROCEDURE EXCHANGE_PROFIT_ACCOUNT_P
            ( W_SOB_ID            IN NUMBER
            , O_ACCOUNT_ID        OUT NUMBER
            , O_ACCOUNT_CODE      OUT VARCHAR2
            , O_ACCOUNT_DESC      OUT VARCHAR2
            )
  AS
  BEGIN
    BEGIN
      SELECT AC.ACCOUNT_CONTROL_ID
           , AC.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
        INTO O_ACCOUNT_ID
           , O_ACCOUNT_CODE
           , O_ACCOUNT_DESC
        FROM FI_ACCOUNT_CONTROL AC
       WHERE AC.ACCOUNT_CONTROL_ID  = EXCHANGE_PROFIT_ACCOUNT_ID_F( W_SOB_ID )
         AND AC.SOB_ID              = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_ACCOUNT_ID := NULL;
      O_ACCOUNT_CODE := NULL;
      O_ACCOUNT_DESC := NULL;
    END;

  END EXCHANGE_PROFIT_ACCOUNT_P;

-- 운영 회계장부 환차손실 계정 ID.
  FUNCTION EXCHANGE_LOSS_ACCOUNT_ID_F
            ( W_SOB_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_ACCOUNT_ID                  NUMBER;

  BEGIN
    BEGIN
      SELECT AB.EXCHANGE_LOSS_ACCOUNT_ID
        INTO V_ACCOUNT_ID
        FROM FI_ACCOUNT_BOOK AB
       WHERE AB.SOB_ID            = W_SOB_ID
         AND AB.OPERATING_FLAG    = 'Y'
         AND ROWNUM               <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ACCOUNT_ID := NULL;
    END;
    RETURN V_ACCOUNT_ID;

  END EXCHANGE_LOSS_ACCOUNT_ID_F;

  PROCEDURE EXCHANGE_LOSS_ACCOUNT_P
            ( W_SOB_ID            IN NUMBER
            , O_ACCOUNT_ID        OUT NUMBER
            , O_ACCOUNT_CODE      OUT VARCHAR2
            , O_ACCOUNT_DESC      OUT VARCHAR2
            )
  AS
  BEGIN
    BEGIN
      SELECT AC.ACCOUNT_CONTROL_ID
           , AC.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
        INTO O_ACCOUNT_ID
           , O_ACCOUNT_CODE
           , O_ACCOUNT_DESC
        FROM FI_ACCOUNT_CONTROL AC
       WHERE AC.ACCOUNT_CONTROL_ID  = EXCHANGE_LOSS_ACCOUNT_ID_F( W_SOB_ID )
         AND AC.SOB_ID              = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_ACCOUNT_ID := NULL;
      O_ACCOUNT_CODE := NULL;
      O_ACCOUNT_DESC := NULL;
    END;

  END EXCHANGE_LOSS_ACCOUNT_P;

---------------------------------------------------------------------------------------------------
-- 회계장부 조회.
  PROCEDURE LU_ACCOUNT_BOOK
            ( P_CURSOR3              OUT TYPES.TCURSOR
            , W_SOB_ID               IN FI_ACCOUNT_BOOK.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT AB.ACCOUNT_BOOK_NAME
           , AB.ACCOUNT_BOOK_CODE
           , AB.ACCOUNT_BOOK_ID
           , AB.OPERATING_FLAG
        FROM FI_ACCOUNT_BOOK AB
       WHERE AB.SOB_ID                  = W_SOB_ID
      ORDER BY AB.ACCOUNT_BOOK_CODE
      ;

  END LU_ACCOUNT_BOOK;

---------------------------------------------------------------------------------------------------
-- 운영 회계장부 리턴.
  PROCEDURE DV_OPERATING_ACCOUNT_BOOK
            ( W_SOB_ID            IN NUMBER
            , O_ACCOUNT_BOOK_ID   OUT NUMBER
            , O_ACCOUNT_BOOK_CODE OUT VARCHAR2
            , O_ACCOUNT_BOOK_NAME OUT VARCHAR2
            , O_ACCOUNT_SET_ID    OUT NUMBER
            , O_FISCAL_CALENDAR_ID OUT NUMBER
            , O_CURRENCY_CODE     OUT VARCHAR2
            , O_EXCHANGE_RATE_TYPE OUT VARCHAR2
            , O_BUDGET_CONTROL_YN OUT VARCHAR2
            , O_DEPT_LEVEL        OUT NUMBER
            , O_SOB_DESCRIPTION   OUT VARCHAR2
            )
  AS
  BEGIN
    SELECT AB.ACCOUNT_BOOK_ID
         , AB.ACCOUNT_BOOK_CODE
         , AB.ACCOUNT_BOOK_NAME
         , AB.ACCOUNT_SET_ID
         , AB.FISCAL_CALENDAR_ID
         , AB.CURRENCY_CODE
         , AB.EXCHANGE_RATE_TYPE
         , AB.BUDGET_CONTROL_YN
         , AB.DEPT_LEVEL
         , SOB.SOB_DESCRIPTION
      INTO O_ACCOUNT_BOOK_ID
         , O_ACCOUNT_BOOK_CODE
         , O_ACCOUNT_BOOK_NAME
         , O_ACCOUNT_SET_ID
         , O_FISCAL_CALENDAR_ID
         , O_CURRENCY_CODE
         , O_EXCHANGE_RATE_TYPE
         , O_BUDGET_CONTROL_YN
         , O_DEPT_LEVEL
         , O_SOB_DESCRIPTION
      FROM FI_ACCOUNT_BOOK AB
        , EAPP_SET_OF_BOOKS_TLV SOB
     WHERE AB.SOB_ID                  = SOB.SOB_ID
       AND AB.SOB_ID                  = W_SOB_ID
       AND AB.OPERATING_FLAG          = 'Y'
       AND ROWNUM                     <= 1
    ;

  END DV_OPERATING_ACCOUNT_BOOK;

END FI_ACCOUNT_BOOK_G; 
/
