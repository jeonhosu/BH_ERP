CREATE OR REPLACE PACKAGE FI_VAT_MASTER_G
AS

-- VAT 조회.
  PROCEDURE SELECT_VAT_MASTER
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_VAT_GUBUN         IN FI_VAT_MASTER.VAT_GUBUN%TYPE
            , W_VAT_TYPE          IN FI_VAT_MASTER.VAT_TYPE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            );

-- VAT 수정 조회.
  PROCEDURE SELECT_VAT_MASTER_UPDATE
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_VAT_GUBUN         IN FI_VAT_MASTER.VAT_GUBUN%TYPE
            , W_VAT_TYPE          IN FI_VAT_MASTER.VAT_TYPE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            );

-- VAT 수정화면에서 INSERT.
  PROCEDURE INSERT_VAT_MASTER
            ( P_VAT_ID                OUT FI_VAT_MASTER.VAT_ID%TYPE
            , P_VAT_ISSUE_DATE        IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , P_VAT_TYPE              IN FI_VAT_MASTER.VAT_TYPE%TYPE
            , P_VAT_GUBUN             IN FI_VAT_MASTER.VAT_GUBUN%TYPE
            , P_SOB_ID                IN FI_VAT_MASTER.SOB_ID%TYPE
            , P_ORG_ID                IN FI_VAT_MASTER.ORG_ID%TYPE
            , P_CUSTOMER_ID           IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            , P_GL_AMOUNT             IN FI_VAT_MASTER.GL_AMOUNT%TYPE
            , P_VAT_AMOUNT            IN FI_VAT_MASTER.VAT_AMOUNT%TYPE
            , P_REMARK                IN FI_VAT_MASTER.REMARK%TYPE
            , P_TAX_ELECTRO_YN        IN FI_VAT_MASTER.TAX_ELECTRO_YN%TYPE
            , P_USER_ID               IN FI_VAT_MASTER.CREATED_BY%TYPE 
            );

-- VAT 수정화면에서 UPDATE.
  PROCEDURE UPDATE_VAT_MASTER
            ( W_VAT_ID                IN FI_VAT_MASTER.VAT_ID%TYPE
            , W_SOB_ID                IN FI_VAT_MASTER.SOB_ID%TYPE
            , P_VAT_ISSUE_DATE        IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , P_VAT_TYPE              IN FI_VAT_MASTER.VAT_TYPE%TYPE
            , P_VAT_GUBUN             IN FI_VAT_MASTER.VAT_GUBUN%TYPE
            , P_CUSTOMER_ID           IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            , P_GL_AMOUNT             IN FI_VAT_MASTER.GL_AMOUNT%TYPE
            , P_VAT_AMOUNT            IN FI_VAT_MASTER.VAT_AMOUNT%TYPE
            , P_REMARK                IN FI_VAT_MASTER.REMARK%TYPE
            , P_TAX_ELECTRO_YN        IN FI_VAT_MASTER.TAX_ELECTRO_YN%TYPE
            , P_USER_ID               IN FI_VAT_MASTER.CREATED_BY%TYPE 
            );

-- VAT 수정화면에서 삭제.
  PROCEDURE DELETE_VAT_MASTER
            ( W_VAT_ID                IN FI_VAT_MASTER.VAT_ID%TYPE
            , W_SOB_ID                IN FI_VAT_MASTER.SOB_ID%TYPE
            );
            
-- SLIP INTERFACE VAT 조회.
  PROCEDURE SELECT_SLIP_VAT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ISSUE_DATE_FR     IN DATE
            , W_ISSUE_DATE_TO     IN DATE
            , W_VAT_CLASS         IN VARCHAR2
            , W_SUPPLIER_ID       IN NUMBER
            , W_VAT_TYPE_ID       IN NUMBER
--            , W_VAT_REASON_CODE   IN VARCHAR2 DEFAULT NULL
            );

---------------------------------------------------------------------------------------------------
-- 사업자 정보 조회.
  PROCEDURE SELECT_OPERATING_UNIT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            );
            
---------------------------------------------------------------------------------------------------
-- VAT 자료 마감 여부 체크.
  FUNCTION VAT_CLOSED_YN
            ( W_VAT_ID                IN FI_VAT_MASTER.VAT_ID%TYPE
            , W_SOB_ID                IN FI_VAT_MASTER.SOB_ID%TYPE
            ) RETURN VARCHAR2;

END FI_VAT_MASTER_G; 
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_MASTER_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_VAT_MASTER_G
/* Description  : 부가세 조회-매입매출장 조회.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- VAT 조회.
  PROCEDURE SELECT_VAT_MASTER
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_VAT_GUBUN         IN FI_VAT_MASTER.VAT_GUBUN%TYPE
            , W_VAT_TYPE          IN FI_VAT_MASTER.VAT_TYPE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT     
            TO_CHAR(VM.VAT_ISSUE_DATE, 'YYYY-MM-DD') AS VAT_ISSUE_DATE
          , FI_COMMON_G.CODE_NAME_F('VAT_GUBUN', VM.VAT_GUBUN, VM.SOB_ID) AS VAT_GUBUN_DESC
          , VM.VAT_GUBUN
          , CASE
              WHEN GROUPING(TO_CHAR(VM.VAT_ISSUE_DATE, 'YYYY-MM')) = 1 THEN '[' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL) || ']'   --총합계
              WHEN GROUPING(VM.VAT_ISSUE_DATE) = 1 THEN '[' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL) || ']'--소계
              ELSE FI_COMMON_G.CODE_NAME_F('VAT_TYPE', VM.VAT_TYPE, VM.SOB_ID)
            END AS VAT_TYPE_DESC   ----세무유형
          , VM.VAT_TYPE
          , CASE
              WHEN GROUPING(TO_CHAR(VM.VAT_ISSUE_DATE, 'YYYY-MM')) = 1 THEN '[' || TO_CHAR(COUNT(VM.VAT_ISSUE_DATE), 'FM999,999,999') || ']'
              WHEN GROUPING(VM.VAT_ISSUE_DATE) = 1 THEN '[' || TO_CHAR(COUNT(VM.VAT_ISSUE_DATE), 'FM999,999,999') || ']'
              ELSE VM.REMARK
            END AS REMARK
            /*CASE
              WHEN GROUPING(TO_CHAR(VM.VAT_ISSUE_DATE, 'YYYY-MM')) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10279', '&&CNT:=' || TO_CHAR(COUNT(VM.VAT_ISSUE_DATE), 'FM999,999,999'))
              WHEN GROUPING(VM.VAT_ISSUE_DATE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10279', '&&CNT:=' || TO_CHAR(COUNT(VM.VAT_ISSUE_DATE), 'FM999,999,999'))
              ELSE VM.REMARK
            END AS REMARK*/
          , DECODE(GROUPING(VM.VAT_ISSUE_DATE), 1,  0, MAX(VM.CUSTOMER_ID)) AS CUSTOMER_ID
          , SC.SUPP_CUST_CODE AS CUSTOMER_CODE
          , SC.SUPP_CUST_NAME AS CUSTOMER_NAME
          , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
          , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
          , SUM(NVL(VM.GL_AMOUNT, 0) + NVL(VM.VAT_AMOUNT, 0)) AS TOTAL_AMOUNT
          , CASE
              WHEN VM.VAT_ISSUE_DATE = VM.GL_DATE THEN 'N'
              ELSE 'Y'
            END AS DATE_CHECK
          , CASE
              WHEN ROUND(VM.GL_AMOUNT * 0.1, 0) - NVL(VM.VAT_AMOUNT, 0) > 20 THEN 'Y'
              ELSE 'N'
            END AS AMOUNT_CHECK
          , VM.CREDITCARD_CODE
          , FCC.CARD_NUM
          , FCC.CARD_NAME
          , VM.CASH_RECEIPT_NUM
          , VM.CURRENCY_CODE
          , DECODE(GROUPING(VM.VAT_ISSUE_DATE), 1,  0, MAX(VM.EXCHANGE_RATE)) AS EXCHANGE_RATE
          , SUM(VM.GL_CURR_AMOUNT) AS GL_CURR_AMOUNT
          , VM.GL_NUM
          , TO_CHAR(VM.GL_DATE, 'YYYY-MM-DD') AS GL_DATE
          , DECODE(GROUPING(VM.VAT_ISSUE_DATE), 1,  0, MAX(VM.ACCOUNT_CONTROL_ID)) AS ACCOUNT_CONTROL_ID
          , AC.ACCOUNT_CODE
          , AC.ACCOUNT_DESC
          , DECODE(GROUPING(VM.VAT_ISSUE_DATE), 1,  0, MAX(VM.SLIP_HEADER_ID)) AS SLIP_HEADER_ID
          , DECODE(GROUPING(VM.VAT_ISSUE_DATE), 1,  0, MAX(VM.SLIP_LINE_ID)) AS SLIP_LINE_ID
        FROM FI_VAT_MASTER VM
          , FI_ACCOUNT_CONTROL AC
          , FI_SUPP_CUST_V SC     --거래처[ S(SUPP) : 매입처, C(CUST) : 매출처 ]
          , FI_CREDIT_CARD FCC
      WHERE VM.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID(+)
        AND VM.SOB_ID                   = AC.SOB_ID(+)
        AND VM.CUSTOMER_ID              = SC.SUPP_CUST_ID
        AND VM.SOB_ID                   = SC.SOB_ID
        AND VM.CREDITCARD_CODE          = FCC.CARD_CODE(+)
        AND VM.SOB_ID                   = FCC.SOB_ID(+)
        AND VM.TAX_CODE                 = W_TAX_CODE
        AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
        AND VM.SOB_ID                   = W_SOB_ID
        AND VM.VAT_TYPE                 = NVL(W_VAT_TYPE, VM.VAT_TYPE)
        AND VM.VAT_GUBUN                = NVL(W_VAT_GUBUN, VM.VAT_GUBUN)
        AND VM.CUSTOMER_ID              = NVL(W_CUSTOMER_ID, VM.CUSTOMER_ID)
      GROUP BY ROLLUP
          ((TO_CHAR(VM.VAT_ISSUE_DATE, 'YYYY-MM'))
          , (VM.VAT_ISSUE_DATE
          , VM.SLIP_LINE_ID
          , VM.VAT_GUBUN
          , VM.VAT_TYPE
          , FI_COMMON_G.CODE_NAME_F('VAT_GUBUN', VM.VAT_GUBUN, VM.SOB_ID)
          , FI_COMMON_G.CODE_NAME_F('VAT_TYPE', VM.VAT_TYPE, VM.SOB_ID)
          
          , VM.REMARK
          , SC.SUPP_CUST_CODE
          , SC.SUPP_CUST_NAME
          , CASE
              WHEN VM.VAT_ISSUE_DATE = VM.GL_DATE THEN 'N'
              ELSE 'Y'
            END
          , CASE
              WHEN ROUND(VM.GL_AMOUNT * 0.1, 0) - NVL(VM.VAT_AMOUNT, 0) > 20 THEN 'Y'
              ELSE 'N'
            END
          , VM.CREDITCARD_CODE
          , FCC.CARD_NUM
          , FCC.CARD_NAME
          , VM.CASH_RECEIPT_NUM
          , VM.CURRENCY_CODE
          , VM.GL_NUM
          , VM.GL_DATE
          , AC.ACCOUNT_CODE
          , AC.ACCOUNT_DESC))
        ;
  END SELECT_VAT_MASTER;

-- VAT 수정 조회.
  PROCEDURE SELECT_VAT_MASTER_UPDATE
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_VAT_GUBUN         IN FI_VAT_MASTER.VAT_GUBUN%TYPE
            , W_VAT_TYPE          IN FI_VAT_MASTER.VAT_TYPE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT     
            VM.VAT_ISSUE_DATE AS VAT_ISSUE_DATE
          , FI_COMMON_G.CODE_NAME_F('VAT_GUBUN', VM.VAT_GUBUN, VM.SOB_ID) AS VAT_GUBUN_DESC
          , VM.VAT_GUBUN
          , FI_COMMON_G.CODE_NAME_F('VAT_TYPE', VM.VAT_TYPE, VM.SOB_ID) AS VAT_TYPE_DESC   ----세무유형
          , VM.VAT_TYPE
          , VM.REMARK AS REMARK
          , VM.CUSTOMER_ID AS CUSTOMER_ID
          , SC.SUPP_CUST_CODE AS CUSTOMER_CODE
          , SC.SUPP_CUST_NAME AS CUSTOMER_NAME
          , VM.GL_AMOUNT AS GL_AMOUNT
          , VM.VAT_AMOUNT AS VAT_AMOUNT
          , NVL(VM.GL_AMOUNT, 0) + NVL(VM.VAT_AMOUNT, 0) AS TOTAL_AMOUNT
          , NVL(VM.TAX_ELECTRO_YN, 'N') AS TAX_ELECTRO_YN
          , NVL(VM.CLOSED_YN, 'N') AS CLOSED_YN
          , VM.CREATED_TYPE          
          , CASE
              WHEN VM.VAT_ISSUE_DATE = VM.GL_DATE THEN 'N'
              ELSE 'Y'
            END AS DATE_CHECK
          , CASE
              WHEN ROUND(VM.GL_AMOUNT * 0.1, 0) - NVL(VM.VAT_AMOUNT, 0) > 20 THEN 'Y'
              ELSE 'N'
            END AS AMOUNT_CHECK
          , VM.VAT_ID
        FROM FI_VAT_MASTER VM
          , FI_ACCOUNT_CONTROL AC
          , FI_SUPP_CUST_V SC     --거래처[ S(SUPP) : 매입처, C(CUST) : 매출처 ]
      WHERE VM.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID(+)
        AND VM.SOB_ID                   = AC.SOB_ID(+)
        AND VM.CUSTOMER_ID              = SC.SUPP_CUST_ID
        AND VM.SOB_ID                   = SC.SOB_ID
        AND VM.TAX_CODE                 = W_TAX_CODE
        AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
        AND VM.SOB_ID                   = W_SOB_ID
        AND VM.VAT_TYPE                 = NVL(W_VAT_TYPE, VM.VAT_TYPE)
        AND VM.VAT_GUBUN                = NVL(W_VAT_GUBUN, VM.VAT_GUBUN)
        AND VM.CUSTOMER_ID              = NVL(W_CUSTOMER_ID, VM.CUSTOMER_ID)
      ORDER BY VM.VAT_ISSUE_DATE, VM.SLIP_LINE_ID
      ;
  END SELECT_VAT_MASTER_UPDATE;

-- VAT 수정화면에서 INSERT.
  PROCEDURE INSERT_VAT_MASTER
            ( P_VAT_ID                OUT FI_VAT_MASTER.VAT_ID%TYPE
            , P_VAT_ISSUE_DATE        IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , P_VAT_TYPE              IN FI_VAT_MASTER.VAT_TYPE%TYPE
            , P_VAT_GUBUN             IN FI_VAT_MASTER.VAT_GUBUN%TYPE
            , P_SOB_ID                IN FI_VAT_MASTER.SOB_ID%TYPE
            , P_ORG_ID                IN FI_VAT_MASTER.ORG_ID%TYPE
            , P_CUSTOMER_ID           IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            , P_GL_AMOUNT             IN FI_VAT_MASTER.GL_AMOUNT%TYPE
            , P_VAT_AMOUNT            IN FI_VAT_MASTER.VAT_AMOUNT%TYPE
            , P_REMARK                IN FI_VAT_MASTER.REMARK%TYPE
            , P_TAX_ELECTRO_YN        IN FI_VAT_MASTER.TAX_ELECTRO_YN%TYPE
            , P_USER_ID               IN FI_VAT_MASTER.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_TAX_CODE        FI_VAT_MASTER.TAX_CODE%TYPE;
    V_PERIOD_NAME     FI_VAT_MASTER.PERIOD_NAME%TYPE;
    V_BUSINESS_TYPE   FI_VAT_MASTER.BUSINESS_TYPE%TYPE;
  BEGIN
    -- TAX_CODE.
    BEGIN
      SELECT FC.CODE AS TAX_CODE
        INTO V_TAX_CODE
        FROM FI_COMMON FC
      WHERE FC.GROUP_CODE           = 'TAX_CODE'
        AND FC.SOB_ID               = P_SOB_ID
        AND FC.DEFAULT_FLAG         = 'Y'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_TAX_CODE := '110';
    END;

    -- 사업장 정보.
    BEGIN
      SELECT SC.BUSINESS_TYPE_S
        INTO V_BUSINESS_TYPE
        FROM FI_SUPP_CUST_V SC
      WHERE SC.SUPP_CUST_ID     = P_CUSTOMER_ID
        AND SC.SOB_ID           = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, '[' || P_CUSTOMER_ID || ']' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10272', '&&FIELD_NAME:=Customer(거래처)'));
    END;
    -- 회계기간.
    V_PERIOD_NAME := TO_CHAR(P_VAT_ISSUE_DATE, 'YYYY-MM');
    SELECT FI_VAT_MASTER_S1.NEXTVAL
      INTO P_VAT_ID
      FROM DUAL;

    INSERT INTO FI_VAT_MASTER
    ( VAT_ID
    , TAX_CODE 
    , VAT_ISSUE_DATE 
    , VAT_TYPE 
    , VAT_GUBUN 
    , SOB_ID 
    , ORG_ID 
    , CUSTOMER_ID 
    , GL_AMOUNT 
    , VAT_AMOUNT 
    , VAT_COUNT 
    , REMARK 
    , PERIOD_NAME 
    , BUSINESS_TYPE 
    , TAX_ELECTRO_YN 
    , CREATED_TYPE 
    , GL_DATE
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_VAT_ID
    , V_TAX_CODE
    , P_VAT_ISSUE_DATE
    , P_VAT_TYPE
    , P_VAT_GUBUN
    , P_SOB_ID
    , P_ORG_ID
    , P_CUSTOMER_ID
    , P_GL_AMOUNT
    , P_VAT_AMOUNT
    , 1   -- VAT_COUNT
    , P_REMARK
    , V_PERIOD_NAME
    , V_BUSINESS_TYPE
    , NVL(P_TAX_ELECTRO_YN, 'N')
    , 'M' --CREATED_TYPE
    , P_VAT_ISSUE_DATE -- GL_DATE
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID 
    );
  END INSERT_VAT_MASTER;

-- VAT 수정화면에서 UPDATE.
  PROCEDURE UPDATE_VAT_MASTER
            ( W_VAT_ID                IN FI_VAT_MASTER.VAT_ID%TYPE
            , W_SOB_ID                IN FI_VAT_MASTER.SOB_ID%TYPE
            , P_VAT_ISSUE_DATE        IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , P_VAT_TYPE              IN FI_VAT_MASTER.VAT_TYPE%TYPE
            , P_VAT_GUBUN             IN FI_VAT_MASTER.VAT_GUBUN%TYPE
            , P_CUSTOMER_ID           IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            , P_GL_AMOUNT             IN FI_VAT_MASTER.GL_AMOUNT%TYPE
            , P_VAT_AMOUNT            IN FI_VAT_MASTER.VAT_AMOUNT%TYPE
            , P_REMARK                IN FI_VAT_MASTER.REMARK%TYPE
            , P_TAX_ELECTRO_YN        IN FI_VAT_MASTER.TAX_ELECTRO_YN%TYPE
            , P_USER_ID               IN FI_VAT_MASTER.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_PERIOD_NAME     FI_VAT_MASTER.PERIOD_NAME%TYPE;
    V_BUSINESS_TYPE   FI_VAT_MASTER.BUSINESS_TYPE%TYPE;
  BEGIN
    IF FI_VAT_MASTER_G.VAT_CLOSED_YN(W_VAT_ID, W_SOB_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90007', '&&FIELD_NAME:=This VAT Data(해당 부가세)'));
    END IF;
    
    -- 사업장 정보.
    BEGIN
      SELECT SC.BUSINESS_TYPE_S
        INTO V_BUSINESS_TYPE
        FROM FI_SUPP_CUST_V SC
      WHERE SC.SUPP_CUST_ID     = P_CUSTOMER_ID
        AND SC.SOB_ID           = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, '[' || P_CUSTOMER_ID || ']' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10272', '&&FIELD_NAME:=Customer(거래처)'));
    END;
    -- 회계기간.
    V_PERIOD_NAME := TO_CHAR(P_VAT_ISSUE_DATE, 'YYYY-MM');
    
    UPDATE FI_VAT_MASTER
      SET VAT_ISSUE_DATE        = P_VAT_ISSUE_DATE
        , VAT_TYPE              = P_VAT_TYPE
        , VAT_GUBUN             = P_VAT_GUBUN
        , CUSTOMER_ID           = P_CUSTOMER_ID
        , GL_AMOUNT             = P_GL_AMOUNT
        , VAT_AMOUNT            = P_VAT_AMOUNT
        , REMARK                = P_REMARK
        , PERIOD_NAME           = V_PERIOD_NAME
        , BUSINESS_TYPE         = V_BUSINESS_TYPE
        , TAX_ELECTRO_YN        = NVL(P_TAX_ELECTRO_YN, 'N')
        , LAST_UPDATE_DATE      = V_SYSDATE
        , LAST_UPDATED_BY       = P_USER_ID
    WHERE VAT_ID                = W_VAT_ID
    ;
  
  END UPDATE_VAT_MASTER;

-- VAT 수정화면에서 삭제.
  PROCEDURE DELETE_VAT_MASTER
            ( W_VAT_ID                IN FI_VAT_MASTER.VAT_ID%TYPE
            , W_SOB_ID                IN FI_VAT_MASTER.SOB_ID%TYPE
            )
  AS
  BEGIN
    IF FI_VAT_MASTER_G.VAT_CLOSED_YN(W_VAT_ID, W_SOB_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90007', '&&FIELD_NAME:=This VAT Data(해당 부가세)'));
    END IF;
    
    DELETE FROM FI_VAT_MASTER
    WHERE VAT_ID                = W_VAT_ID
      AND SOB_ID                = W_SOB_ID
    ;
  END DELETE_VAT_MASTER;
  
-- SLIP INTERFACE VAT 조회.
  PROCEDURE SELECT_SLIP_VAT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ISSUE_DATE_FR     IN DATE
            , W_ISSUE_DATE_TO     IN DATE
            , W_VAT_CLASS         IN VARCHAR2
            , W_SUPPLIER_ID       IN NUMBER
            , W_VAT_TYPE_ID       IN NUMBER
--            , W_VAT_REASON_CODE   IN VARCHAR2 DEFAULT NULL
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT DECODE(GROUPING(SX1.SUPPLIER_CODE), 1, TO_CHAR(NULL), SX1.VAT_TYPE) AS VAT_TYPE
           , CASE
               WHEN GROUPING(SX1.VAT_TYPE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL)
               WHEN GROUPING(SX1.SUPPLIER_CODE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL)
               ELSE SX1.VAT_TYPE_NAME
             END AS VAT_TYPE_NAME
           , SX1.VAT_REASON_NAME
           , SX1.SUPPLIER_CODE
           , SX1.SUPPLIER_NAME
           , SX1.TAX_REG_NO AS TAX_REG_NO
           , SX1.VAT_ISSUE_DATE AS VAT_ISSUE_DATE
           , SX1.SLIP_DATE AS SLIP_DATE
           , SUM(SX1.GL_AMOUNT) AS GL_AMOUNT
           , SUM(SX1.VAT_AMOUNT) AS VAT_AMOUNT
           , SUM(SX1.TOTAL_AMOUNT) AS TOTAL_AMOUNT
           , SX1.CREDITCARD_CODE
           , SX1.CARD_NUM
           , SX1.CARD_NAME
           , SX1.CASH_RECEIPT_NUM
           , SX1.REMARK
           , NULL AS MANAGEMENT1                           -- 계좌번호 OR CODE 값.
           , SX1.CURRENCY_CODE
           , TO_CHAR(SX1.EXCHANGE_RATE, 'FM9999,9999,999,999.9999') AS EXCHANGE_RATE
           , TO_CHAR(SX1.GL_CURRENCY_AMOUNT, 'FM9999,9999,999,999.9999') AS GL_CURRENCY_AMOUNT
           , SX1.SLIP_NUM
           , TO_CHAR(SX1.HEADER_INTERFACE_ID) AS HEADER_INTERFACE_ID
        FROM (SELECT DECODE(VM.VAT_TYPE_AP, NULL, '2', '1') AS VAT_GUBUN
                   , CASE
                       WHEN VM.VAT_TYPE_AP IS NULL THEN FI_COMMON_G.GET_ID_F('VAT_TYPE_AR', 'CODE = ''' || VM.VAT_TYPE_AR || '''', VM.SOB_ID)
                       ELSE FI_COMMON_G.GET_ID_F('VAT_TYPE_AP', 'CODE = ''' || VM.VAT_TYPE_AP || '''', VM.SOB_ID)
                     END AS VAT_TYPE_ID
                   , NVL(VM.VAT_TYPE_AP, VM.VAT_TYPE_AR) AS VAT_TYPE
                   , CASE
                       WHEN VM.VAT_TYPE_AP IS NULL THEN FI_COMMON_G.CODE_NAME_F('VAT_TYPE_AR', VM.VAT_TYPE_AR, VM.SOB_ID)
                       ELSE FI_COMMON_G.CODE_NAME_F('VAT_TYPE_AP', VM.VAT_TYPE_AP, VM.SOB_ID)
                     END AS VAT_TYPE_NAME
                   , FI_COMMON_G.CODE_NAME_F('VAT_REASON', VM.VAT_REASON_CODE, VM.SOB_ID) AS VAT_REASON_NAME
                   , SC.SUPP_CUST_ID AS SUPPLIER_ID
                   , VM.SUPPLIER_CODE
                   , SC.SUPP_CUST_NAME AS SUPPLIER_NAME
                   , SC.TAX_REG_NO
                   , VM.VAT_ISSUE_DATE
                   , VM.SLIP_DATE
                   , NVL(VM.GL_AMOUNT, 0) AS GL_AMOUNT
                   , NVL(VM.VAT_AMOUNT, 0) AS VAT_AMOUNT
                   , NVL(VM.GL_AMOUNT, 0) + NVL(VM.VAT_AMOUNT, 0) AS TOTAL_AMOUNT
                   , VM.CREDITCARD_CODE
                   , CC.CARD_NUM
                   , CC.CARD_NAME
                   , VM.CASH_RECEIPT_NUM
                   , VM.REMARK
                   , VM.CURRENCY_CODE
                   , VM.EXCHANGE_RATE
                   , VM.GL_CURRENCY_AMOUNT
                   , VM.SLIP_NUM
                   , VM.HEADER_INTERFACE_ID
                   , VM.TAX_CODE
                   , VM.LINE_INTERFACE_ID
                FROM (SELECT SL.HEADER_INTERFACE_ID
                           , SL.SOB_ID
                           , FI_SLIP_INTERFACE_G.SLIP_IF_ITEM_VALUE_F(SL.LINE_INTERFACE_ID, 'TAX_CODE', SL.SOB_ID) AS TAX_CODE
                           , FI_SLIP_INTERFACE_G.SLIP_IF_ITEM_VALUE_F(SL.LINE_INTERFACE_ID, 'VAT_TYPE_AP', SL.SOB_ID) AS VAT_TYPE_AP
                           , FI_SLIP_INTERFACE_G.SLIP_IF_ITEM_VALUE_F(SL.LINE_INTERFACE_ID, 'VAT_TYPE_AR', SL.SOB_ID) AS VAT_TYPE_AR
                           , FI_SLIP_INTERFACE_G.SLIP_IF_ITEM_VALUE_F(SL.LINE_INTERFACE_ID, 'VAT_REASON', SL.SOB_ID) AS VAT_REASON_CODE
                           , FI_SLIP_INTERFACE_G.SLIP_IF_ITEM_VALUE_F(SL.LINE_INTERFACE_ID, 'CUSTOMER', SL.SOB_ID) AS SUPPLIER_CODE
                           , FI_SLIP_INTERFACE_G.SLIP_IF_ITEM_VALUE_F(SL.LINE_INTERFACE_ID, 'ISSUE_DATE', SL.SOB_ID) AS VAT_ISSUE_DATE
                           , TO_CHAR(SL.SLIP_DATE, 'YYYY-MM-DD') AS SLIP_DATE
                           , TO_NUMBER(FI_SLIP_INTERFACE_G.SLIP_IF_ITEM_VALUE_F(SL.LINE_INTERFACE_ID, 'SUPPLY_AMOUNT', SL.SOB_ID)) AS GL_AMOUNT
                           , NVL(SL.GL_AMOUNT, 0) AS VAT_AMOUNT
                           , FI_SLIP_INTERFACE_G.SLIP_IF_ITEM_VALUE_F(SL.LINE_INTERFACE_ID, 'CREDIT_CARD', SL.SOB_ID) AS CREDITCARD_CODE
                           , FI_SLIP_INTERFACE_G.SLIP_IF_ITEM_VALUE_F(SL.LINE_INTERFACE_ID, 'CASH_RECEIPT', SL.SOB_ID) AS CASH_RECEIPT_NUM
                           , SL.REMARK
                           , SL.CURRENCY_CODE
                           , SL.EXCHANGE_RATE
                           , SL.GL_CURRENCY_AMOUNT
                           , SL.SLIP_NUM
                           , SL.LINE_INTERFACE_ID 
                        FROM FI_SLIP_LINE_INTERFACE SL
                          , FI_ACCOUNT_CONTROL AC
                      WHERE SL.ACCOUNT_CONTROL_ID      = AC.ACCOUNT_CONTROL_ID
                        AND SL.SOB_ID                  = W_SOB_ID
                        AND SL.CONFIRM_YN              = 'N'
                        AND AC.VAT_ENABLED_FLAG        = 'Y'
                      ) VM
                  , FI_SUPP_CUST_V SC
                  , FI_CREDIT_CARD CC
              WHERE VM.SUPPLIER_CODE            = SC.SUPP_CUST_CODE
                AND VM.SOB_ID                   = SC.SOB_ID
                AND VM.CREDITCARD_CODE          = CC.CARD_CODE(+)
                AND VM.SOB_ID                   = CC.SOB_ID(+)
                AND VM.VAT_ISSUE_DATE           BETWEEN TO_CHAR(W_ISSUE_DATE_FR , 'YYYY-MM-DD') AND TO_CHAR(W_ISSUE_DATE_TO, 'YYYY-MM-DD')
             ) SX1
      WHERE SX1.TAX_CODE                = W_TAX_CODE
        AND SX1.VAT_GUBUN               = NVL(W_VAT_CLASS, SX1.VAT_GUBUN)
        AND SX1.SUPPLIER_ID             = NVL(W_SUPPLIER_ID, SX1.SUPPLIER_ID)
        AND SX1.VAT_TYPE_ID             = NVL(W_VAT_TYPE_ID, SX1.VAT_TYPE_ID)
      GROUP BY ROLLUP ((SX1.VAT_TYPE
           , SX1.VAT_TYPE_NAME)
           , (SX1.VAT_REASON_NAME
           , SX1.SUPPLIER_CODE
           , SX1.SUPPLIER_NAME
           , SX1.TAX_REG_NO
           , SX1.VAT_ISSUE_DATE
           , SX1.SLIP_DATE
           , SX1.CREDITCARD_CODE
           , SX1.CARD_NUM
           , SX1.CARD_NAME
           , SX1.CASH_RECEIPT_NUM
           , SX1.REMARK
           , SX1.CURRENCY_CODE
           , SX1.EXCHANGE_RATE
           , SX1.GL_CURRENCY_AMOUNT
           , SX1.SLIP_NUM
           , SX1.HEADER_INTERFACE_ID
           , SX1.LINE_INTERFACE_ID
           ))
      ;

  END SELECT_SLIP_VAT;

---------------------------------------------------------------------------------------------------
-- 사업자 정보 조회.
  PROCEDURE SELECT_OPERATING_UNIT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT CM.CORP_NAME
           , OU.PRESIDENT_NAME
           , OU.VAT_NUMBER
           , OU.ADDR1 || ' ' || OU.ADDR2 AS ADDRESS
           , OU.BUSINESS_TYPE
           , OU.BUSINESS_ITEM
        FROM HRM_CORP_MASTER CM
          , HRM_OPERATING_UNIT OU
          , FI_TAX_CODE_V TC
      WHERE CM.CORP_ID                  = OU.CORP_ID
        AND CM.SOB_ID                   = OU.SOB_ID
        AND OU.VAT_NUMBER               = TC.TAX_REG_NO
        AND OU.SOB_ID                   = TC.SOB_ID
        AND TC.TAX_CODE                 = W_TAX_CODE
        AND TC.SOB_ID                   = W_SOB_ID
      ;
  END SELECT_OPERATING_UNIT;
            
---------------------------------------------------------------------------------------------------
-- VAT 자료 마감 여부 체크.
  FUNCTION VAT_CLOSED_YN
            ( W_VAT_ID                IN FI_VAT_MASTER.VAT_ID%TYPE
            , W_SOB_ID                IN FI_VAT_MASTER.SOB_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE    VARCHAR2(2) := 'N';
  BEGIN
    BEGIN
      SELECT VM.CLOSED_YN
        INTO V_RETURN_VALUE
        FROM FI_VAT_MASTER VM
      WHERE VM.VAT_ID             = W_VAT_ID
        AND VM.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := 'N';
    END;
    RETURN V_RETURN_VALUE;
  END VAT_CLOSED_YN;
  
END FI_VAT_MASTER_G; 
/
