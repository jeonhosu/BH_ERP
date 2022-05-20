CREATE OR REPLACE PACKAGE FI_VAT_ZERO_RATE_G
AS

-- VAT ������÷�μ��� ��ȸ.
  PROCEDURE SELECT_ZERO_RATE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_ZERO_RATE_HEADER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_ZERO_RATE_HEADER.SOB_ID%TYPE
            , W_VAT_DATE_FR       IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_FR%TYPE
            , W_VAT_DATE_TO       IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_TO%TYPE
            , W_ZERO_RATE_TYPE    IN FI_VAT_ZERO_RATE_HEADER.ZERO_RATE_TYPE%TYPE
            , W_DOCUMENT_NUM      IN FI_VAT_ZERO_RATE_LINE.DOCUMENT_NUM%TYPE
            );

-- VAT ������÷�μ��� HEADER SAVE.
  PROCEDURE SAVE_ZERO_RATE_HEADER
            ( P_ZERO_RATE_HEADER_ID OUT FI_VAT_ZERO_RATE_HEADER.ZERO_RATE_HEADER_ID%TYPE
            , P_TAX_CODE            IN FI_VAT_ZERO_RATE_HEADER.TAX_CODE%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_HEADER.SOB_ID%TYPE
            , P_VAT_DATE_FR         IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_FR%TYPE
            , P_VAT_DATE_TO         IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_TO%TYPE
            , P_ZERO_RATE_TYPE      IN FI_VAT_ZERO_RATE_HEADER.ZERO_RATE_TYPE%TYPE
            , P_USER_ID             IN FI_VAT_ZERO_RATE_HEADER.CREATED_BY%TYPE 
            );
            
-- VAT ������÷�μ��� LINE INSERT.
  PROCEDURE INSERT_ZERO_RATE_LINE
            ( P_ZERO_RATE_LINE_ID   OUT FI_VAT_ZERO_RATE_LINE.ZERO_RATE_LINE_ID%TYPE
            , P_TAX_CODE            IN FI_VAT_ZERO_RATE_HEADER.TAX_CODE%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_HEADER.SOB_ID%TYPE
            , P_VAT_DATE_FR         IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_FR%TYPE
            , P_VAT_DATE_TO         IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_TO%TYPE
            , P_ZERO_RATE_TYPE      IN FI_VAT_ZERO_RATE_HEADER.ZERO_RATE_TYPE%TYPE
            , P_DOCUMENT_TYPE       IN FI_VAT_ZERO_RATE_LINE.DOCUMENT_TYPE%TYPE
            , P_ISSUER_NAME         IN FI_VAT_ZERO_RATE_LINE.ISSUER_NAME%TYPE
            , P_ISSUE_DATE          IN FI_VAT_ZERO_RATE_LINE.ISSUE_DATE%TYPE
            , P_SHIPPING_DATE       IN FI_VAT_ZERO_RATE_LINE.SHIPPING_DATE%TYPE
            , P_DOCUMENT_NUM        IN FI_VAT_ZERO_RATE_LINE.DOCUMENT_NUM%TYPE
            , P_CURRENCY_CODE       IN FI_VAT_ZERO_RATE_LINE.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_VAT_ZERO_RATE_LINE.EXCHANGE_RATE%TYPE
            , P_TOTAL_CURR_AMOUNT   IN FI_VAT_ZERO_RATE_LINE.TOTAL_CURR_AMOUNT%TYPE
            , P_TOTAL_BASE_AMOUNT   IN FI_VAT_ZERO_RATE_LINE.TOTAL_BASE_AMOUNT%TYPE
            , P_THIS_CURR_AMOUNT    IN FI_VAT_ZERO_RATE_LINE.THIS_CURR_AMOUNT%TYPE
            , P_THIS_BASE_AMOUNT    IN FI_VAT_ZERO_RATE_LINE.THIS_BASE_AMOUNT%TYPE
            , P_USER_ID             IN FI_VAT_ZERO_RATE_LINE.CREATED_BY%TYPE 
            );

-- VAT ������÷�μ��� LINE UPDATE.
  PROCEDURE UPDATE_ZERO_RATE_LINE
            ( W_ZERO_RATE_LINE_ID   IN FI_VAT_ZERO_RATE_LINE.ZERO_RATE_LINE_ID%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_LINE.SOB_ID%TYPE
            , P_DOCUMENT_TYPE       IN FI_VAT_ZERO_RATE_LINE.DOCUMENT_TYPE%TYPE
            , P_ISSUER_NAME         IN FI_VAT_ZERO_RATE_LINE.ISSUER_NAME%TYPE
            , P_ISSUE_DATE          IN FI_VAT_ZERO_RATE_LINE.ISSUE_DATE%TYPE
            , P_SHIPPING_DATE       IN FI_VAT_ZERO_RATE_LINE.SHIPPING_DATE%TYPE
            , P_DOCUMENT_NUM        IN FI_VAT_ZERO_RATE_LINE.DOCUMENT_NUM%TYPE
            , P_CURRENCY_CODE       IN FI_VAT_ZERO_RATE_LINE.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_VAT_ZERO_RATE_LINE.EXCHANGE_RATE%TYPE
            , P_TOTAL_CURR_AMOUNT   IN FI_VAT_ZERO_RATE_LINE.TOTAL_CURR_AMOUNT%TYPE
            , P_TOTAL_BASE_AMOUNT   IN FI_VAT_ZERO_RATE_LINE.TOTAL_BASE_AMOUNT%TYPE
            , P_THIS_CURR_AMOUNT    IN FI_VAT_ZERO_RATE_LINE.THIS_CURR_AMOUNT%TYPE
            , P_THIS_BASE_AMOUNT    IN FI_VAT_ZERO_RATE_LINE.THIS_BASE_AMOUNT%TYPE
            , P_USER_ID             IN FI_VAT_ZERO_RATE_LINE.CREATED_BY%TYPE 
            );

-- VAT ������÷�μ��� LINE DELETE.
  PROCEDURE DELETE_ZERO_RATE_LINE
            ( W_ZERO_RATE_LINE_ID   IN FI_VAT_ZERO_RATE_LINE.ZERO_RATE_LINE_ID%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_LINE.SOB_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- VAT ������÷�μ��� : �����ſ���/����Ȯ�μ� ���ڹ߱޸��� ��ȸ.
  PROCEDURE SELECT_ZERO_RATE_EISSUE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_ZERO_RATE_HEADER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_ZERO_RATE_HEADER.SOB_ID%TYPE
            , W_VAT_DATE_FR       IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_FR%TYPE
            , W_VAT_DATE_TO       IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_TO%TYPE
            );

-- VAT ������÷�μ��� : �����ſ���/����Ȯ�μ� ���ڹ߱޸��� ����.
  PROCEDURE INSERT_ZERO_RATE_EISSUE
            ( P_ZERO_RATE_EISSUE_ID OUT FI_VAT_ZERO_RATE_EISSUE.ZERO_RATE_EISSUE_ID%TYPE
            , P_TAX_CODE            IN FI_VAT_ZERO_RATE_HEADER.TAX_CODE%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_HEADER.SOB_ID%TYPE
            , P_VAT_DATE_FR         IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_FR%TYPE
            , P_VAT_DATE_TO         IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_TO%TYPE
            , P_DOCUMENT_TYPE       IN FI_VAT_ZERO_RATE_EISSUE.DOCUMENT_TYPE%TYPE
            , P_DOCUMENT_NUM        IN FI_VAT_ZERO_RATE_EISSUE.DOCUMENT_NUM%TYPE
            , P_ISSUE_DATE          IN FI_VAT_ZERO_RATE_EISSUE.ISSUE_DATE%TYPE
            , P_CUSTOMER_ID         IN FI_VAT_ZERO_RATE_EISSUE.CUSTOMER_ID%TYPE
            , P_THIS_AMOUNT         IN FI_VAT_ZERO_RATE_EISSUE.THIS_AMOUNT%TYPE
            , P_DESCRIPTION         IN FI_VAT_ZERO_RATE_EISSUE.DESCRIPTION%TYPE
            , P_USER_ID             IN FI_VAT_ZERO_RATE_EISSUE.CREATED_BY%TYPE 
            );

-- VAT ������÷�μ��� : �����ſ���/����Ȯ�μ� ���ڹ߱޸��� ����.
  PROCEDURE UPDATE_ZERO_RATE_EISSUE
            ( W_ZERO_RATE_EISSUE_ID IN FI_VAT_ZERO_RATE_EISSUE.ZERO_RATE_EISSUE_ID%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_EISSUE.SOB_ID%TYPE
            , P_DOCUMENT_TYPE       IN FI_VAT_ZERO_RATE_EISSUE.DOCUMENT_TYPE%TYPE
            , P_DOCUMENT_NUM        IN FI_VAT_ZERO_RATE_EISSUE.DOCUMENT_NUM%TYPE
            , P_ISSUE_DATE          IN FI_VAT_ZERO_RATE_EISSUE.ISSUE_DATE%TYPE
            , P_CUSTOMER_ID         IN FI_VAT_ZERO_RATE_EISSUE.CUSTOMER_ID%TYPE
            , P_THIS_AMOUNT         IN FI_VAT_ZERO_RATE_EISSUE.THIS_AMOUNT%TYPE
            , P_DESCRIPTION         IN FI_VAT_ZERO_RATE_EISSUE.DESCRIPTION%TYPE
            , P_USER_ID             IN FI_VAT_ZERO_RATE_EISSUE.CREATED_BY%TYPE 
            );

-- VAT ������÷�μ��� : �����ſ���/����Ȯ�μ� ���ڹ߱޸��� ����.
  PROCEDURE DELETE_ZERO_RATE_EISSUE
            ( W_ZERO_RATE_EISSUE_ID IN FI_VAT_ZERO_RATE_EISSUE.ZERO_RATE_EISSUE_ID%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_EISSUE.SOB_ID%TYPE
            );

-- VAT ������÷�μ��� : �����ſ���/����Ȯ�μ� ���ڹ߱޸��� �հ� ��ȸ.
  PROCEDURE SELECT_ZERO_RATE_EISSUE_SUM
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_ZERO_RATE_HEADER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_ZERO_RATE_HEADER.SOB_ID%TYPE
            , W_VAT_DATE_FR       IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_FR%TYPE
            , W_VAT_DATE_TO       IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_TO%TYPE
            );
            
---------------------------------------------------------------------------------------------------
-- VAT ������÷�μ��� ����.
  PROCEDURE SET_ZERO_RATE
            ( W_TAX_CODE          IN FI_VAT_ZERO_RATE_HEADER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_ZERO_RATE_HEADER.SOB_ID%TYPE
            , W_VAT_DATE_FR       IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_FR%TYPE
            , W_VAT_DATE_TO       IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_TO%TYPE
            , W_ZERO_RATE_TYPE    IN FI_VAT_ZERO_RATE_HEADER.ZERO_RATE_TYPE%TYPE
            , P_USER_ID           IN FI_VAT_ZERO_RATE_HEADER.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            );

---------------------------------------------------------------------------------------------------
-- VAT ������÷�μ��� HEADER �������� üũ.
  FUNCTION CLOSED_YN_HEADER_F
            ( W_ZERO_RATE_HEADER_ID IN FI_VAT_ZERO_RATE_HEADER.ZERO_RATE_HEADER_ID%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_HEADER.SOB_ID%TYPE
            ) RETURN VARCHAR2;

-- VAT ������÷�μ��� LINE �������� üũ.
  FUNCTION CLOSED_YN_LINE_F
            ( W_ZERO_RATE_LINE_ID   IN FI_VAT_ZERO_RATE_LINE.ZERO_RATE_LINE_ID%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_LINE.SOB_ID%TYPE
            ) RETURN VARCHAR2;

-- VAT ������÷�μ��� : ���ڹ߱޸��� �������� üũ.
  FUNCTION CLOSED_YN_EISSUE_F
            ( W_ZERO_RATE_EISSUE_ID IN FI_VAT_ZERO_RATE_EISSUE.ZERO_RATE_EISSUE_ID%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_EISSUE.SOB_ID%TYPE
            ) RETURN VARCHAR2;
            
END FI_VAT_ZERO_RATE_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_ZERO_RATE_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_VAT_ZERO_RATE_G
/* Description  : �ΰ��� ��ȸ-������÷�μ��� ����.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- VAT ������÷�μ��� ��ȸ.
  PROCEDURE SELECT_ZERO_RATE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_ZERO_RATE_HEADER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_ZERO_RATE_HEADER.SOB_ID%TYPE
            , W_VAT_DATE_FR       IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_FR%TYPE
            , W_VAT_DATE_TO       IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_TO%TYPE
            , W_ZERO_RATE_TYPE    IN FI_VAT_ZERO_RATE_HEADER.ZERO_RATE_TYPE%TYPE
            , W_DOCUMENT_NUM      IN FI_VAT_ZERO_RATE_LINE.DOCUMENT_NUM%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT ZRH.TAX_CODE
           , FI_COMMON_G.CODE_NAME_F('TAX_CODE', ZRH.TAX_CODE, ZRH.SOB_ID) AS TAX_CODE_DESC
           , ZRH.VAT_DATE_FR
           , ZRH.VAT_DATE_TO
           , ZRH.ZERO_RATE_TYPE
           , FI_COMMON_G.CODE_NAME_F('VAT_ZERO_RATE_TYPE', ZRH.ZERO_RATE_TYPE, ZRH.SOB_ID) AS ZERO_RATE_TYPE_DESC
           , ZRL.DOCUMENT_TYPE
           , FI_COMMON_G.CODE_NAME_F('VAT_DOC_TYPE', ZRL.DOCUMENT_TYPE, ZRL.SOB_ID) AS DOCUMENT_TYPE_DESC
           , ZRL.ISSUER_NAME
           , ZRL.ISSUE_DATE
           , ZRL.SHIPPING_DATE
           , ZRL.DOCUMENT_NUM
           , ZRL.CURRENCY_CODE
           , ZRL.EXCHANGE_RATE
           , ZRL.TOTAL_CURR_AMOUNT
           , ZRL.TOTAL_BASE_AMOUNT
           , ZRL.THIS_CURR_AMOUNT
           , ZRL.THIS_BASE_AMOUNT
           , ZRL.ZERO_RATE_LINE_ID
           , ZRL.INTERFACE_HEADER_ID
        FROM FI_VAT_ZERO_RATE_LINE ZRL
          , FI_VAT_ZERO_RATE_HEADER ZRH
      WHERE ZRL.ZERO_RATE_HEADER_ID = ZRH.ZERO_RATE_HEADER_ID
        AND ZRL.SOB_ID              = ZRH.SOB_ID
        AND ZRH.TAX_CODE            = W_TAX_CODE
        AND ZRH.VAT_DATE_FR         = W_VAT_DATE_FR 
        AND ZRH.VAT_DATE_TO         = W_VAT_DATE_TO
        AND ZRH.ZERO_RATE_TYPE      = W_ZERO_RATE_TYPE
        AND ZRH.SOB_ID              = W_SOB_ID
        AND NVL(ZRL.DOCUMENT_NUM, '-')  LIKE W_DOCUMENT_NUM || '%'
      ORDER BY ZRH.TAX_CODE, ZRL.CUSTOMER_CODE, ZRL.DOCUMENT_NUM, ZRL.ISSUE_DATE
      ;
  END SELECT_ZERO_RATE;

-- VAT ������÷�μ��� HEADER SAVE.
  PROCEDURE SAVE_ZERO_RATE_HEADER
            ( P_ZERO_RATE_HEADER_ID OUT FI_VAT_ZERO_RATE_HEADER.ZERO_RATE_HEADER_ID%TYPE
            , P_TAX_CODE            IN FI_VAT_ZERO_RATE_HEADER.TAX_CODE%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_HEADER.SOB_ID%TYPE
            , P_VAT_DATE_FR         IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_FR%TYPE
            , P_VAT_DATE_TO         IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_TO%TYPE
            , P_ZERO_RATE_TYPE      IN FI_VAT_ZERO_RATE_HEADER.ZERO_RATE_TYPE%TYPE
            , P_USER_ID             IN FI_VAT_ZERO_RATE_HEADER.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE                       DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    -- ���� �ڷ� ��ȸ�Ͽ� ID �о�� --
    BEGIN
      SELECT ZRH.ZERO_RATE_HEADER_ID
        INTO P_ZERO_RATE_HEADER_ID
        FROM FI_VAT_ZERO_RATE_HEADER ZRH
      WHERE ZRH.TAX_CODE          = P_TAX_CODE
        AND ZRH.SOB_ID            = P_SOB_ID
        AND ZRH.VAT_DATE_FR       = P_VAT_DATE_FR
        AND ZRH.VAT_DATE_TO       = P_VAT_DATE_TO
        AND ZRH.ZERO_RATE_TYPE    = P_ZERO_RATE_TYPE
      ;
    EXCEPTION WHEN OTHERS THEN
      P_ZERO_RATE_HEADER_ID := -1;
    END;
    IF P_ZERO_RATE_HEADER_ID = -1 THEN
      SELECT FI_VAT_ZERO_RATE_HEADER_S1.NEXTVAL
        INTO P_ZERO_RATE_HEADER_ID
        FROM DUAL;
      
      -- INSERT.
      INSERT INTO FI_VAT_ZERO_RATE_HEADER
      ( ZERO_RATE_HEADER_ID 
      , SOB_ID 
      , VAT_DATE_FR 
      , VAT_DATE_TO 
      , ZERO_RATE_TYPE 
      , CREATION_DATE  
      , CREATED_BY
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY 
      ) VALUES
      ( P_ZERO_RATE_HEADER_ID
      , P_SOB_ID
      , P_VAT_DATE_FR
      , P_VAT_DATE_TO
      , P_ZERO_RATE_TYPE
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID
      );
    END IF;
  END SAVE_ZERO_RATE_HEADER;
  
-- VAT ������÷�μ��� LINE INSERT.
  PROCEDURE INSERT_ZERO_RATE_LINE
            ( P_ZERO_RATE_LINE_ID   OUT FI_VAT_ZERO_RATE_LINE.ZERO_RATE_LINE_ID%TYPE
            , P_TAX_CODE            IN FI_VAT_ZERO_RATE_HEADER.TAX_CODE%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_HEADER.SOB_ID%TYPE
            , P_VAT_DATE_FR         IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_FR%TYPE
            , P_VAT_DATE_TO         IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_TO%TYPE
            , P_ZERO_RATE_TYPE      IN FI_VAT_ZERO_RATE_HEADER.ZERO_RATE_TYPE%TYPE
            , P_DOCUMENT_TYPE       IN FI_VAT_ZERO_RATE_LINE.DOCUMENT_TYPE%TYPE
            , P_ISSUER_NAME         IN FI_VAT_ZERO_RATE_LINE.ISSUER_NAME%TYPE
            , P_ISSUE_DATE          IN FI_VAT_ZERO_RATE_LINE.ISSUE_DATE%TYPE
            , P_SHIPPING_DATE       IN FI_VAT_ZERO_RATE_LINE.SHIPPING_DATE%TYPE
            , P_DOCUMENT_NUM        IN FI_VAT_ZERO_RATE_LINE.DOCUMENT_NUM%TYPE
            , P_CURRENCY_CODE       IN FI_VAT_ZERO_RATE_LINE.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_VAT_ZERO_RATE_LINE.EXCHANGE_RATE%TYPE
            , P_TOTAL_CURR_AMOUNT   IN FI_VAT_ZERO_RATE_LINE.TOTAL_CURR_AMOUNT%TYPE
            , P_TOTAL_BASE_AMOUNT   IN FI_VAT_ZERO_RATE_LINE.TOTAL_BASE_AMOUNT%TYPE
            , P_THIS_CURR_AMOUNT    IN FI_VAT_ZERO_RATE_LINE.THIS_CURR_AMOUNT%TYPE
            , P_THIS_BASE_AMOUNT    IN FI_VAT_ZERO_RATE_LINE.THIS_BASE_AMOUNT%TYPE
            , P_USER_ID             IN FI_VAT_ZERO_RATE_LINE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE             DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_ZERO_RATE_HEADER_ID FI_VAT_ZERO_RATE_HEADER.ZERO_RATE_HEADER_ID%TYPE;
    V_RECORD_COUNT        NUMBER := 0;
  BEGIN
    -- ��� üũ �� ������ ó��.
    SAVE_ZERO_RATE_HEADER
            ( P_ZERO_RATE_HEADER_ID => V_ZERO_RATE_HEADER_ID
            , P_TAX_CODE            => P_TAX_CODE
            , P_SOB_ID              => P_SOB_ID
            , P_VAT_DATE_FR         => P_VAT_DATE_FR
            , P_VAT_DATE_TO         => P_VAT_DATE_TO
            , P_ZERO_RATE_TYPE      => P_ZERO_RATE_TYPE
            , P_USER_ID             => P_USER_ID 
            );
            
    -- ���� L/C��ȣ ����--
    BEGIN
      SELECT COUNT(ZRL.ZERO_RATE_LINE_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_VAT_ZERO_RATE_LINE ZRL
      WHERE ZRL.ZERO_RATE_HEADER_ID = V_ZERO_RATE_HEADER_ID
        AND ZRL.DOCUMENT_TYPE       = P_DOCUMENT_TYPE
        AND ZRL.ISSUER_NAME         = P_ISSUER_NAME
        AND ZRL.DOCUMENT_NUM        = P_DOCUMENT_NUM
        AND ZRL.SOB_ID              = P_SOB_ID
        AND ZRL.ISSUE_DATE          = P_ISSUE_DATE
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90003', '&&FIELD_NAME:=L/C Num(L/C��ȣ)'));
    END IF;

    SELECT FI_VAT_ZERO_RATE_LINE_S1.NEXTVAL
      INTO P_ZERO_RATE_LINE_ID
      FROM DUAL;

    INSERT INTO FI_VAT_ZERO_RATE_LINE
    ( ZERO_RATE_LINE_ID
    , ZERO_RATE_HEADER_ID 
    , SOB_ID 
    , DOCUMENT_TYPE 
    , ISSUER_NAME 
    , ISSUE_DATE 
    , SHIPPING_DATE 
    , DOCUMENT_NUM 
    , CURRENCY_CODE 
    , EXCHANGE_RATE 
    , TOTAL_CURR_AMOUNT 
    , TOTAL_BASE_AMOUNT 
    , THIS_CURR_AMOUNT 
    , THIS_BASE_AMOUNT 
    , CREATED_TYPE 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_ZERO_RATE_LINE_ID
    , V_ZERO_RATE_HEADER_ID
    , P_SOB_ID
    , P_DOCUMENT_TYPE
    , P_ISSUER_NAME
    , P_ISSUE_DATE
    , P_SHIPPING_DATE
    , P_DOCUMENT_NUM
    , P_CURRENCY_CODE
    , NVL(P_EXCHANGE_RATE, 0)
    , NVL(P_TOTAL_CURR_AMOUNT, 0)
    , NVL(P_TOTAL_BASE_AMOUNT, 0)
    , NVL(P_THIS_CURR_AMOUNT, 0)
    , NVL(P_THIS_BASE_AMOUNT, 0)
    , 'M' --CREATED_TYPE
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  END INSERT_ZERO_RATE_LINE;

-- VAT ������÷�μ��� LINE UPDATE.
  PROCEDURE UPDATE_ZERO_RATE_LINE
            ( W_ZERO_RATE_LINE_ID   IN FI_VAT_ZERO_RATE_LINE.ZERO_RATE_LINE_ID%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_LINE.SOB_ID%TYPE
            , P_DOCUMENT_TYPE       IN FI_VAT_ZERO_RATE_LINE.DOCUMENT_TYPE%TYPE
            , P_ISSUER_NAME         IN FI_VAT_ZERO_RATE_LINE.ISSUER_NAME%TYPE
            , P_ISSUE_DATE          IN FI_VAT_ZERO_RATE_LINE.ISSUE_DATE%TYPE
            , P_SHIPPING_DATE       IN FI_VAT_ZERO_RATE_LINE.SHIPPING_DATE%TYPE
            , P_DOCUMENT_NUM        IN FI_VAT_ZERO_RATE_LINE.DOCUMENT_NUM%TYPE
            , P_CURRENCY_CODE       IN FI_VAT_ZERO_RATE_LINE.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_VAT_ZERO_RATE_LINE.EXCHANGE_RATE%TYPE
            , P_TOTAL_CURR_AMOUNT   IN FI_VAT_ZERO_RATE_LINE.TOTAL_CURR_AMOUNT%TYPE
            , P_TOTAL_BASE_AMOUNT   IN FI_VAT_ZERO_RATE_LINE.TOTAL_BASE_AMOUNT%TYPE
            , P_THIS_CURR_AMOUNT    IN FI_VAT_ZERO_RATE_LINE.THIS_CURR_AMOUNT%TYPE
            , P_THIS_BASE_AMOUNT    IN FI_VAT_ZERO_RATE_LINE.THIS_BASE_AMOUNT%TYPE
            , P_USER_ID             IN FI_VAT_ZERO_RATE_LINE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    IF CLOSED_YN_LINE_F(W_ZERO_RATE_LINE_ID, P_SOB_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90007', '&&FIELD_NAME:=This Document Data(�ش� L/C��ȣ)'));
    END IF;
    UPDATE FI_VAT_ZERO_RATE_LINE
      SET DOCUMENT_TYPE       = P_DOCUMENT_TYPE
        , ISSUER_NAME         = P_ISSUER_NAME
        , ISSUE_DATE          = P_ISSUE_DATE
        , SHIPPING_DATE       = P_SHIPPING_DATE
        , DOCUMENT_NUM        = P_DOCUMENT_NUM
        , CURRENCY_CODE       = P_CURRENCY_CODE
        , EXCHANGE_RATE       = P_EXCHANGE_RATE
        , TOTAL_CURR_AMOUNT   = P_TOTAL_CURR_AMOUNT
        , TOTAL_BASE_AMOUNT   = P_TOTAL_BASE_AMOUNT
        , THIS_CURR_AMOUNT    = P_THIS_CURR_AMOUNT
        , THIS_BASE_AMOUNT    = P_THIS_BASE_AMOUNT
        , LAST_UPDATE_DATE    = V_SYSDATE
        , LAST_UPDATED_BY     = P_USER_ID
    WHERE ZERO_RATE_LINE_ID   = W_ZERO_RATE_LINE_ID;
  END UPDATE_ZERO_RATE_LINE;

-- VAT ������÷�μ��� LINE DELETE.
  PROCEDURE DELETE_ZERO_RATE_LINE
            ( W_ZERO_RATE_LINE_ID   IN FI_VAT_ZERO_RATE_LINE.ZERO_RATE_LINE_ID%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_LINE.SOB_ID%TYPE
            )
  AS
  BEGIN
    IF FI_VAT_ZERO_RATE_G.CLOSED_YN_LINE_F(W_ZERO_RATE_LINE_ID, P_SOB_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90007', '&&FIELD_NAME:=This Document Data(�ش� L/C��ȣ)'));
    END IF;

    DELETE FROM FI_VAT_ZERO_RATE_LINE
    WHERE ZERO_RATE_LINE_ID   = W_ZERO_RATE_LINE_ID
      AND SOB_ID              = P_SOB_ID
    ;
  END DELETE_ZERO_RATE_LINE;

---------------------------------------------------------------------------------------------------
-- VAT ������÷�μ��� : �����ſ���/����Ȯ�μ� ���ڹ߱޸��� ��ȸ.
  PROCEDURE SELECT_ZERO_RATE_EISSUE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_ZERO_RATE_HEADER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_ZERO_RATE_HEADER.SOB_ID%TYPE
            , W_VAT_DATE_FR       IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_FR%TYPE
            , W_VAT_DATE_TO       IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_TO%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT ZRH.TAX_CODE
           , FI_COMMON_G.CODE_NAME_F('TAX_CODE', ZRH.TAX_CODE, ZRH.SOB_ID) AS TAX_CODE_DESC
           , ZRH.VAT_DATE_FR
           , ZRH.VAT_DATE_TO
           , ZRE.DOCUMENT_TYPE
           , FI_COMMON_G.CODE_NAME_F('VAT_DOC_TYPE', ZRE.DOCUMENT_TYPE, ZRE.SOB_ID) AS DOCUMENT_TYPE_DESC
           , ZRE.DOCUMENT_NUM
           , ZRE.ISSUE_DATE
           , SC.SUPP_CUST_NAME AS CUSTOMER_NAME
           , ZRE.CUSTOMER_ID
           , SC.TAX_REG_NO AS TAX_REG_NO
           , ZRE.THIS_AMOUNT
           , ZRE.DESCRIPTION
           , ZRE.ZERO_RATE_EISSUE_ID
           , ZRE.INTERFACE_HEADER_ID
        FROM FI_VAT_ZERO_RATE_EISSUE ZRE
          , FI_SUPP_CUST_V SC
          , FI_VAT_ZERO_RATE_HEADER ZRH
      WHERE ZRE.CUSTOMER_ID         = SC.SUPP_CUST_ID
        AND ZRE.SOB_ID              = SC.SOB_ID
        AND ZRE.ZERO_RATE_HEADER_ID = ZRH.ZERO_RATE_HEADER_ID
        AND ZRE.SOB_ID              = ZRH.SOB_ID
        AND ZRH.TAX_CODE            = W_TAX_CODE
        AND ZRH.VAT_DATE_FR         = W_VAT_DATE_FR 
        AND ZRH.VAT_DATE_TO         = W_VAT_DATE_TO
        AND ZRH.ZERO_RATE_TYPE      = '2'
        AND ZRH.SOB_ID              = W_SOB_ID
      ORDER BY ZRH.TAX_CODE, SC.SUPP_CUST_CODE, ZRE.DOCUMENT_NUM, ZRE.ISSUE_DATE
      ;
  END SELECT_ZERO_RATE_EISSUE;

-- VAT ������÷�μ��� : �����ſ���/����Ȯ�μ� ���ڹ߱޸��� ����.
  PROCEDURE INSERT_ZERO_RATE_EISSUE
            ( P_ZERO_RATE_EISSUE_ID OUT FI_VAT_ZERO_RATE_EISSUE.ZERO_RATE_EISSUE_ID%TYPE
            , P_TAX_CODE            IN FI_VAT_ZERO_RATE_HEADER.TAX_CODE%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_HEADER.SOB_ID%TYPE
            , P_VAT_DATE_FR         IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_FR%TYPE
            , P_VAT_DATE_TO         IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_TO%TYPE
            , P_DOCUMENT_TYPE       IN FI_VAT_ZERO_RATE_EISSUE.DOCUMENT_TYPE%TYPE
            , P_DOCUMENT_NUM        IN FI_VAT_ZERO_RATE_EISSUE.DOCUMENT_NUM%TYPE
            , P_ISSUE_DATE          IN FI_VAT_ZERO_RATE_EISSUE.ISSUE_DATE%TYPE
            , P_CUSTOMER_ID         IN FI_VAT_ZERO_RATE_EISSUE.CUSTOMER_ID%TYPE
            , P_THIS_AMOUNT         IN FI_VAT_ZERO_RATE_EISSUE.THIS_AMOUNT%TYPE
            , P_DESCRIPTION         IN FI_VAT_ZERO_RATE_EISSUE.DESCRIPTION%TYPE
            , P_USER_ID             IN FI_VAT_ZERO_RATE_EISSUE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE             DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_ZERO_RATE_HEADER_ID FI_VAT_ZERO_RATE_HEADER.ZERO_RATE_HEADER_ID%TYPE;
    V_RECORD_COUNT        NUMBER := 0;
  BEGIN
    -- ��� üũ �� ������ ó��.
    SAVE_ZERO_RATE_HEADER
            ( P_ZERO_RATE_HEADER_ID => V_ZERO_RATE_HEADER_ID
            , P_TAX_CODE            => P_TAX_CODE
            , P_SOB_ID              => P_SOB_ID
            , P_VAT_DATE_FR         => P_VAT_DATE_FR
            , P_VAT_DATE_TO         => P_VAT_DATE_TO
            , P_ZERO_RATE_TYPE      => '2'  
            , P_USER_ID             => P_USER_ID 
            );
            
    -- ���� L/C��ȣ ����--
    BEGIN
      SELECT COUNT(ZRL.ZERO_RATE_LINE_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_VAT_ZERO_RATE_LINE ZRL
      WHERE ZRL.ZERO_RATE_HEADER_ID = V_ZERO_RATE_HEADER_ID
        AND ZRL.DOCUMENT_TYPE       = P_DOCUMENT_TYPE
        AND ZRL.DOCUMENT_NUM        = P_DOCUMENT_NUM
        AND ZRL.SOB_ID              = P_SOB_ID
        AND ZRL.ISSUE_DATE          = P_ISSUE_DATE
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90003', '&&FIELD_NAME:=L/C Num(L/C��ȣ)'));
    END IF;

    SELECT FI_VAT_ZERO_RATE_EISSUE_S1.NEXTVAL
      INTO P_ZERO_RATE_EISSUE_ID
      FROM DUAL;

    INSERT INTO FI_VAT_ZERO_RATE_EISSUE
    ( ZERO_RATE_EISSUE_ID
    , ZERO_RATE_HEADER_ID 
    , SOB_ID 
    , DOCUMENT_TYPE 
    , DOCUMENT_NUM 
    , ISSUE_DATE 
    , CUSTOMER_ID 
    , THIS_AMOUNT 
    , DESCRIPTION 
    , CREATED_TYPE 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_ZERO_RATE_EISSUE_ID
    , V_ZERO_RATE_HEADER_ID
    , P_SOB_ID
    , P_DOCUMENT_TYPE
    , P_DOCUMENT_NUM
    , P_ISSUE_DATE
    , P_CUSTOMER_ID
    , P_THIS_AMOUNT
    , P_DESCRIPTION
    , 'M'  -- �������� --
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );  
  END INSERT_ZERO_RATE_EISSUE;

-- VAT ������÷�μ��� : �����ſ���/����Ȯ�μ� ���ڹ߱޸��� ����.
  PROCEDURE UPDATE_ZERO_RATE_EISSUE
            ( W_ZERO_RATE_EISSUE_ID IN FI_VAT_ZERO_RATE_EISSUE.ZERO_RATE_EISSUE_ID%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_EISSUE.SOB_ID%TYPE
            , P_DOCUMENT_TYPE       IN FI_VAT_ZERO_RATE_EISSUE.DOCUMENT_TYPE%TYPE
            , P_DOCUMENT_NUM        IN FI_VAT_ZERO_RATE_EISSUE.DOCUMENT_NUM%TYPE
            , P_ISSUE_DATE          IN FI_VAT_ZERO_RATE_EISSUE.ISSUE_DATE%TYPE
            , P_CUSTOMER_ID         IN FI_VAT_ZERO_RATE_EISSUE.CUSTOMER_ID%TYPE
            , P_THIS_AMOUNT         IN FI_VAT_ZERO_RATE_EISSUE.THIS_AMOUNT%TYPE
            , P_DESCRIPTION         IN FI_VAT_ZERO_RATE_EISSUE.DESCRIPTION%TYPE
            , P_USER_ID             IN FI_VAT_ZERO_RATE_EISSUE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    IF CLOSED_YN_LINE_F(W_ZERO_RATE_EISSUE_ID, P_SOB_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90007', '&&FIELD_NAME:=This Document Data(�ش� L/C��ȣ)'));
    END IF;
    UPDATE FI_VAT_ZERO_RATE_EISSUE
      SET DOCUMENT_TYPE       = P_DOCUMENT_TYPE
        , DOCUMENT_NUM        = P_DOCUMENT_NUM
        , ISSUE_DATE          = P_ISSUE_DATE
        , CUSTOMER_ID         = P_CUSTOMER_ID
        , THIS_AMOUNT         = P_THIS_AMOUNT
        , DESCRIPTION         = P_DESCRIPTION
        , LAST_UPDATE_DATE    = V_SYSDATE
        , LAST_UPDATED_BY     = P_USER_ID
    WHERE ZERO_RATE_EISSUE_ID = W_ZERO_RATE_EISSUE_ID;
  END UPDATE_ZERO_RATE_EISSUE;

-- VAT ������÷�μ��� : �����ſ���/����Ȯ�μ� ���ڹ߱޸��� ����.
  PROCEDURE DELETE_ZERO_RATE_EISSUE
            ( W_ZERO_RATE_EISSUE_ID IN FI_VAT_ZERO_RATE_EISSUE.ZERO_RATE_EISSUE_ID%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_EISSUE.SOB_ID%TYPE
            )
  AS 
  BEGIN
    IF CLOSED_YN_LINE_F(W_ZERO_RATE_EISSUE_ID, P_SOB_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90007', '&&FIELD_NAME:=This Document Data(�ش� L/C��ȣ)'));
    END IF;
    DELETE FI_VAT_ZERO_RATE_EISSUE
    WHERE ZERO_RATE_EISSUE_ID = W_ZERO_RATE_EISSUE_ID;
  END DELETE_ZERO_RATE_EISSUE;

-- VAT ������÷�μ��� : �����ſ���/����Ȯ�μ� ���ڹ߱޸��� �հ� ��ȸ.
  PROCEDURE SELECT_ZERO_RATE_EISSUE_SUM
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_ZERO_RATE_HEADER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_ZERO_RATE_HEADER.SOB_ID%TYPE
            , W_VAT_DATE_FR       IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_FR%TYPE
            , W_VAT_DATE_TO       IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_TO%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT COUNT(ZRE.ZERO_RATE_EISSUE_ID) AS TOTAL_COUNT
           , SUM(ZRE.THIS_AMOUNT) AS TOTAL_AMOUNT
           , SUM(DECODE(ZRE.DOCUMENT_TYPE, '2', 1, 0)) AS LC_COUNT  -- LC
           , SUM(DECODE(ZRE.DOCUMENT_TYPE, '2', ZRE.THIS_AMOUNT, 0)) AS LC_AMOUNT
           , SUM(DECODE(ZRE.DOCUMENT_TYPE, '3', 1, 0)) AS INVOICE_COUNT  -- INVOICE
           , SUM(DECODE(ZRE.DOCUMENT_TYPE, '3', ZRE.THIS_AMOUNT, 0)) AS INVOICE_AMOUNT
        FROM FI_VAT_ZERO_RATE_EISSUE ZRE
          , FI_VAT_ZERO_RATE_HEADER ZRH
      WHERE ZRE.ZERO_RATE_HEADER_ID = ZRH.ZERO_RATE_HEADER_ID
        AND ZRE.SOB_ID              = ZRH.SOB_ID
        AND ZRH.TAX_CODE            = W_TAX_CODE
        AND ZRH.VAT_DATE_FR         = W_VAT_DATE_FR 
        AND ZRH.VAT_DATE_TO         = W_VAT_DATE_TO
        AND ZRH.ZERO_RATE_TYPE      = '2'
        AND ZRH.SOB_ID              = W_SOB_ID
      ;
  END SELECT_ZERO_RATE_EISSUE_SUM;
 
---------------------------------------------------------------------------------------------------
-- VAT ������÷�μ��� ����.
  PROCEDURE SET_ZERO_RATE
            ( W_TAX_CODE          IN FI_VAT_ZERO_RATE_HEADER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_ZERO_RATE_HEADER.SOB_ID%TYPE
            , W_VAT_DATE_FR       IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_FR%TYPE
            , W_VAT_DATE_TO       IN FI_VAT_ZERO_RATE_HEADER.VAT_DATE_TO%TYPE
            , W_ZERO_RATE_TYPE    IN FI_VAT_ZERO_RATE_HEADER.ZERO_RATE_TYPE%TYPE
            , P_USER_ID           IN FI_VAT_ZERO_RATE_HEADER.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE             DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_ZERO_RATE_HEADER_ID FI_VAT_ZERO_RATE_HEADER.ZERO_RATE_HEADER_ID%TYPE;
    V_ZERO_RATE_LINE_ID   FI_VAT_ZERO_RATE_LINE.ZERO_RATE_LINE_ID%TYPE;
    V_ZERO_RATE_EISSUE_ID FI_VAT_ZERO_RATE_EISSUE.ZERO_RATE_EISSUE_ID%TYPE;
  BEGIN
    -- ������÷�μ��� ��� ��ȸ --
    BEGIN
      SELECT ZRH.ZERO_RATE_HEADER_ID
        INTO V_ZERO_RATE_HEADER_ID
        FROM FI_VAT_ZERO_RATE_HEADER ZRH
      WHERE ZRH.SOB_ID              = W_SOB_ID
        AND ZRH.TAX_CODE            = W_TAX_CODE
        AND ZRH.VAT_DATE_FR         = W_VAT_DATE_FR
        AND ZRH.VAT_DATE_TO         = W_VAT_DATE_TO
        AND ZRH.ZERO_RATE_TYPE      = W_ZERO_RATE_TYPE
        AND ROWNUM                  <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ZERO_RATE_HEADER_ID := -1;
    END;
    IF V_ZERO_RATE_HEADER_ID > 0 THEN
      -- ���� üũ.
      IF CLOSED_YN_HEADER_F(V_ZERO_RATE_HEADER_ID, W_SOB_ID) = 'Y' THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90007', '&&FIELD_NAME:=This Zero Tax Rate(�ش� ������÷�μ���)'));
      END IF;
      
      -- ���� �ڷ� ���� : HEADER.
      DELETE FROM FI_VAT_ZERO_RATE_HEADER ZRH
      WHERE ZRH.ZERO_RATE_HEADER_ID = V_ZERO_RATE_HEADER_ID;
      
      -- ���� �ڷ� ���� : LINE.
      DELETE FROM FI_VAT_ZERO_RATE_LINE ZRL
      WHERE ZRL.ZERO_RATE_HEADER_ID = V_ZERO_RATE_HEADER_ID;
      
      -- ���� �ڷ� ���� : ���ڹ߱޸���.
      DELETE FROM FI_VAT_ZERO_RATE_EISSUE ZRE
      WHERE ZRE.ZERO_RATE_HEADER_ID = V_ZERO_RATE_HEADER_ID
        AND '2'                     = W_ZERO_RATE_TYPE;
    END IF;
    
    -- ������÷�μ��� ��� ���� --
    SELECT FI_VAT_ZERO_RATE_HEADER_S1.NEXTVAL
      INTO V_ZERO_RATE_HEADER_ID
      FROM DUAL;
    INSERT INTO FI_VAT_ZERO_RATE_HEADER
    ( ZERO_RATE_HEADER_ID
    , SOB_ID
    , TAX_CODE
    , VAT_DATE_FR
    , VAT_DATE_TO
    , ZERO_RATE_TYPE
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY 
    ) VALUES
    ( V_ZERO_RATE_HEADER_ID
    , W_SOB_ID
    , W_TAX_CODE
    , W_VAT_DATE_FR
    , W_VAT_DATE_TO
    , W_ZERO_RATE_TYPE
    , V_SYSDATE 
    , P_USER_ID 
    , V_SYSDATE 
    , P_USER_ID 
    );
    -- ������÷�μ��� LINE ���� --
    FOR C1 IN ( SELECT CASE
                         WHEN S_SMI.LC_NUM IS NOT NULL THEN '2'       -- �����ſ���.
                         WHEN S_SMI.INVOICE_NUM IS NOT NULL THEN '3'  -- �κ��̽�.
                         ELSE '2'                                     -- �����ſ���.
                       END AS DOCUMENT_TYPE  
                     , S_SMI.BANK_CODE
                     , S_FB.BANK_NAME AS ISSUER_NAME
                     , TO_DATE(S_SMI.ISSUE_DATE, 'YYYY-MM-DD') AS ISSUE_DATE
                     , CASE
                         WHEN S_SMI.PC_NUM IS NOT NULL THEN S_SMI.PC_NUM            -- ����Ȯ�μ� ��ȣ.
                         WHEN S_SMI.LC_NUM IS NOT NULL THEN S_SMI.LC_NUM            -- �����ſ���.
                         WHEN S_SMI.INVOICE_NUM IS NOT NULL THEN S_SMI.INVOICE_NUM  -- �κ��̽�.
                         ELSE S_SMI.LC_NUM                                          -- �����ſ���.
                       END AS DOCUMENT_NUM
                     , SL.CURRENCY_CODE AS CURRENCY_CODE
                     , SL.EXCHANGE_RATE AS EXCHANGE_RATE
                     , SL.GL_CURRENCY_AMOUNT AS GL_CURR_AMOUNT
                     , SL.GL_AMOUNT
                     , S_VID.VAT_ISSUE_DATE
                     , S_SMI.CUSTOMER_CODE
                     , VA.SOB_ID
                     , 'I' AS CREATED_TYPE
                     , 'SLIP' AS SOURCE_TABLE
                     , SL.SLIP_HEADER_ID
                     , SL.SLIP_LINE_ID
                  FROM FI_VAT_ACCOUNTS VA
                    , FI_ACCOUNT_CONTROL AC
                    , FI_SLIP_LINE SL
                    , FI_SLIP_HEADER SH
                    , (-- ��ǥ ����.
                      SELECT SMI.SLIP_LINE_ID
                           , SMI.SOB_ID
                           , MAX(DECODE(SMI.MANAGEMENT_CODE, '15', SMI.MANAGEMENT_VALUE)) AS LC_NUM         -- 15:L/C��ȣ.
                           , MAX(DECODE(SMI.MANAGEMENT_CODE, '25', SMI.MANAGEMENT_VALUE)) AS INVOICE_NUM    -- 25:�����ȣ.
                           , MAX(DECODE(SMI.MANAGEMENT_CODE, '28', SMI.MANAGEMENT_VALUE)) AS PC_NUM         -- 28:����Ȯ�μ���ȣ.
                           , MAX(DECODE(SMI.MANAGEMENT_CODE, '10', SMI.MANAGEMENT_VALUE)) AS ISSUE_DATE     -- ��������.
                           , MAX(DECODE(SMI.MANAGEMENT_CODE, '30', SMI.MANAGEMENT_VALUE)) AS BANK_CODE      -- ����.
                           , MAX(DECODE(SMI.MANAGEMENT_CODE, '13', SMI.MANAGEMENT_VALUE)) AS CUSTOMER_CODE  -- �ŷ�ó.
                        FROM FI_SLIP_MANAGEMENT_ITEM SMI
                      WHERE SMI.SOB_ID                  = W_SOB_ID
                      GROUP BY SMI.SLIP_LINE_ID
                           , SMI.SOB_ID
                      ) S_SMI
                    , (-- ��������
                       SELECT FB.BANK_CODE
                           , FB.BANK_NAME
                           , FB.SOB_ID
                        FROM FI_BANK FB
                      WHERE FB.BANK_GROUP               = '-'
                        AND FB.SOB_ID                   = W_SOB_ID
                      ) S_FB 
                    , (-- ���ݰ�꼭 ��������.
                      SELECT SSL.SLIP_HEADER_ID
                          , SSL.SOB_ID
                          , TO_DATE(MAX(DECODE(SMI.MANAGEMENT_CODE, '33', SMI.MANAGEMENT_VALUE)), 'YYYY-MM-DD') AS VAT_ISSUE_DATE  -- 33:���ݰ�꼭������.
                      FROM FI_VAT_ACCOUNTS SVA
                        , FI_SLIP_LINE SSL
                        , FI_SLIP_MANAGEMENT_ITEM SMI
                      WHERE SVA.ACCOUNT_CONTROL_ID      = SSL.ACCOUNT_CONTROL_ID
                        AND SVA.SOB_ID                  = SSL.SOB_ID
                        AND SSL.SLIP_LINE_ID            = SMI.SLIP_LINE_ID
                        AND SSL.SOB_ID                  = SMI.SOB_ID
                        AND SVA.VAT_DOCUMENT_TYPE       = '2'
                        AND SVA.ENABLED_FLAG            = 'Y'
                        AND SVA.VAT_ENABLED_FLAG        = 'Y'
                        AND SVA.SOB_ID                  = W_SOB_ID
                      GROUP BY SSL.SLIP_HEADER_ID
                          , SSL.SOB_ID
                      ) S_VID 
                WHERE VA.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
                  AND VA.SOB_ID                   = AC.SOB_ID
                  AND AC.ACCOUNT_CONTROL_ID       = SL.ACCOUNT_CONTROL_ID
                  AND AC.SOB_ID                   = SL.SOB_ID
                  AND SL.SLIP_HEADER_ID           = SH.SLIP_HEADER_ID
                  AND SL.SOB_ID                   = SH.SOB_ID
                  AND SL.SLIP_LINE_ID             = S_SMI.SLIP_LINE_ID(+)
                  AND SL.SOB_ID                   = S_SMI.SOB_ID(+)
                  AND S_SMI.BANK_CODE             = S_FB.BANK_CODE(+)
                  AND S_SMI.SOB_ID                = S_FB.SOB_ID(+)
                  AND SH.SLIP_HEADER_ID           = S_VID.SLIP_HEADER_ID
                  AND SH.SOB_ID                   = S_VID.SOB_ID
                  AND VA.SOB_ID                   = W_SOB_ID
                  AND VA.VAT_TYPE                 IN('2', '14')  -- ������.
                  AND VA.VAT_DOCUMENT_TYPE        = '2'          -- ������÷�μ���.
                  AND VA.ENABLED_FLAG             = 'Y'
                  AND VA.VAT_ENABLED_FLAG         = 'N'          -- �ΰ������ΰ� �ƴѰ�.
                  AND S_VID.VAT_ISSUE_DATE        BETWEEN W_VAT_DATE_FR AND W_VAT_DATE_TO
                  AND SH.SOB_ID                   = W_SOB_ID
                  AND SH.CONFIRM_YN               = 'Y'
              )
    LOOP
      UPDATE FI_VAT_ZERO_RATE_LINE ZTR
        SET ZTR.DOCUMENT_TYPE     = C1.DOCUMENT_TYPE
          , ZTR.ISSUER_NAME       = C1.ISSUER_NAME
          , ZTR.ISSUE_DATE        = C1.ISSUE_DATE
          , ZTR.DOCUMENT_NUM      = C1.DOCUMENT_NUM
          , ZTR.CURRENCY_CODE     = C1.CURRENCY_CODE
          , ZTR.EXCHANGE_RATE     = NVL(C1.EXCHANGE_RATE, 0)
          , ZTR.THIS_CURR_AMOUNT  = NVL(C1.GL_CURR_AMOUNT, 0)
          , ZTR.THIS_BASE_AMOUNT  = NVL(C1.GL_AMOUNT, 0)
          , ZTR.VAT_ISSUE_DATE    = C1.VAT_ISSUE_DATE
          , ZTR.BANK_CODE         = C1.BANK_CODE
          , ZTR.CUSTOMER_CODE     = C1.CUSTOMER_CODE
          , ZTR.LAST_UPDATE_DATE  = V_SYSDATE
          , ZTR.LAST_UPDATED_BY   = P_USER_ID
      WHERE ZTR.ZERO_RATE_HEADER_ID = V_ZERO_RATE_HEADER_ID
        AND ZTR.SOURCE_TABLE        = C1.SOURCE_TABLE
        AND ZTR.INTERFACE_LINE_ID   = C1.SLIP_LINE_ID
        AND ZTR.SOB_ID              = C1.SOB_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        SELECT FI_VAT_ZERO_RATE_LINE_S1.NEXTVAL
          INTO V_ZERO_RATE_LINE_ID
          FROM DUAL;

        INSERT INTO FI_VAT_ZERO_RATE_LINE
        ( ZERO_RATE_LINE_ID
        , ZERO_RATE_HEADER_ID
        , SOB_ID
        , DOCUMENT_TYPE
        , ISSUER_NAME
        , ISSUE_DATE
        , DOCUMENT_NUM
        , CURRENCY_CODE
        , EXCHANGE_RATE
        , THIS_CURR_AMOUNT
        , THIS_BASE_AMOUNT
        , VAT_ISSUE_DATE
        , BANK_CODE
        , CUSTOMER_CODE
        , EISSUE_YN
        , CREATED_TYPE
        , SOURCE_TABLE
        , INTERFACE_HEADER_ID
        , INTERFACE_LINE_ID
        , CREATION_DATE
        , CREATED_BY
        , LAST_UPDATE_DATE
        , LAST_UPDATED_BY )
        VALUES
        ( V_ZERO_RATE_LINE_ID
        , V_ZERO_RATE_HEADER_ID
        , C1.SOB_ID
        , C1.DOCUMENT_TYPE
        , C1.ISSUER_NAME
        , C1.ISSUE_DATE
        , C1.DOCUMENT_NUM
        , C1.CURRENCY_CODE
        , NVL(C1.EXCHANGE_RATE, 0)
        , NVL(C1.GL_CURR_AMOUNT, 0)
        , NVL(C1.GL_AMOUNT, 0)
        , C1.VAT_ISSUE_DATE
        , C1.BANK_CODE
        , C1.CUSTOMER_CODE
        , 'Y'  -- ���ڹ߱� --
        , C1.CREATED_TYPE
        , C1.SOURCE_TABLE
        , C1.SLIP_HEADER_ID
        , C1.SLIP_LINE_ID
        , V_SYSDATE
        , P_USER_ID
        , V_SYSDATE
        , P_USER_ID );
      END IF;
    END LOOP C1;
    -- ������÷�μ��� : �����ſ���/����Ȯ�μ� ���ڹ߱޸��� ���� --
    FOR C1 IN ( SELECT ZRL.SOB_ID
                     , ZRL.DOCUMENT_TYPE
                     , ZRL.DOCUMENT_NUM
                     , ZRL.ISSUE_DATE
                     , ZRL.CUSTOMER_CODE
                     , SC.SUPP_CUST_ID AS CUSTOMER_ID
                     , NVL(ZRL.THIS_BASE_AMOUNT, 0) AS THIS_AMOUNT
                     , ZRL.CREATED_TYPE
                     , ZRL.SOURCE_TABLE
                     , ZRL.INTERFACE_HEADER_ID
                     , ZRL.INTERFACE_LINE_ID
                  FROM FI_VAT_ZERO_RATE_LINE ZRL
                    , FI_SUPP_CUST_V SC
                WHERE ZRL.CUSTOMER_CODE         = SC.SUPP_CUST_CODE
                  AND ZRL.SOB_ID                = SC.SOB_ID
                  AND ZRL.ZERO_RATE_HEADER_ID   = V_ZERO_RATE_HEADER_ID
                  AND ZRL.DOCUMENT_TYPE         IN ('2', '3')   -- 2:L/C, 3:INVOICE.
                  AND ZRL.EISSUE_YN             = 'Y'    
                  AND '2'                       = W_ZERO_RATE_TYPE  -- ������ �Ǵ� ����....
              )
    LOOP
      SELECT FI_VAT_ZERO_RATE_EISSUE_S1.NEXTVAL
        INTO V_ZERO_RATE_EISSUE_ID
        FROM DUAL;
      INSERT INTO FI_VAT_ZERO_RATE_EISSUE
      ( ZERO_RATE_EISSUE_ID
      , ZERO_RATE_HEADER_ID 
      , SOB_ID 
      , DOCUMENT_TYPE 
      , DOCUMENT_NUM 
      , ISSUE_DATE 
      , CUSTOMER_ID 
      , THIS_AMOUNT 
      , CREATED_TYPE 
      , SOURCE_TABLE 
      , INTERFACE_HEADER_ID 
      , INTERFACE_LINE_ID 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( V_ZERO_RATE_EISSUE_ID
      , V_ZERO_RATE_HEADER_ID 
      , C1.SOB_ID 
      , C1.DOCUMENT_TYPE 
      , C1.DOCUMENT_NUM 
      , C1.ISSUE_DATE 
      , C1.CUSTOMER_ID 
      , NVL(C1.THIS_AMOUNT, 0)
      , C1.CREATED_TYPE 
      , C1.SOURCE_TABLE 
      , C1.INTERFACE_HEADER_ID 
      , C1.INTERFACE_LINE_ID 
      , V_SYSDATE
      , P_USER_ID 
      , V_SYSDATE
      , P_USER_ID       
      );
    END LOOP C1;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END SET_ZERO_RATE;

---------------------------------------------------------------------------------------------------
-- VAT ������÷�μ��� HEADER �������� üũ.
  FUNCTION CLOSED_YN_HEADER_F
            ( W_ZERO_RATE_HEADER_ID IN FI_VAT_ZERO_RATE_HEADER.ZERO_RATE_HEADER_ID%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_HEADER.SOB_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_CLOSED_YN         CHAR(1) := 'N';
  BEGIN
    BEGIN
      SELECT ZRH.CLOSED_YN
        INTO V_CLOSED_YN
        FROM FI_VAT_ZERO_RATE_HEADER ZRH
      WHERE ZRH.ZERO_RATE_HEADER_ID = W_ZERO_RATE_HEADER_ID
        AND ZRH.SOB_ID              = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CLOSED_YN := 'N';
    END;
    RETURN V_CLOSED_YN;
  END CLOSED_YN_HEADER_F;

-- VAT ������÷�μ��� LINE �������� üũ.
  FUNCTION CLOSED_YN_LINE_F
            ( W_ZERO_RATE_LINE_ID   IN FI_VAT_ZERO_RATE_LINE.ZERO_RATE_LINE_ID%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_LINE.SOB_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_CLOSED_YN         CHAR(1) := 'N';
  BEGIN
    BEGIN
      SELECT ZRL.CLOSED_YN
        INTO V_CLOSED_YN
        FROM FI_VAT_ZERO_RATE_LINE ZRL
      WHERE ZRL.ZERO_RATE_LINE_ID = W_ZERO_RATE_LINE_ID
        AND ZRL.SOB_ID            = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CLOSED_YN := 'N';
    END;
    RETURN V_CLOSED_YN;
  END CLOSED_YN_LINE_F;

-- VAT ������÷�μ��� : ���ڹ߱޸��� �������� üũ.
  FUNCTION CLOSED_YN_EISSUE_F
            ( W_ZERO_RATE_EISSUE_ID IN FI_VAT_ZERO_RATE_EISSUE.ZERO_RATE_EISSUE_ID%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_RATE_EISSUE.SOB_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_CLOSED_YN         CHAR(1) := 'N';
  BEGIN
    BEGIN
      SELECT ZRE.CLOSED_YN
        INTO V_CLOSED_YN
        FROM FI_VAT_ZERO_RATE_EISSUE ZRE
      WHERE ZRE.ZERO_RATE_EISSUE_ID = W_ZERO_RATE_EISSUE_ID
        AND ZRE.SOB_ID              = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CLOSED_YN := 'N';
    END;
    RETURN V_CLOSED_YN;
  END CLOSED_YN_EISSUE_F;
  
END FI_VAT_ZERO_RATE_G;
/
