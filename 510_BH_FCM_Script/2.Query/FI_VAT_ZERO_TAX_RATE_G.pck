CREATE OR REPLACE PACKAGE FI_VAT_ZERO_TAX_RATE_G
AS

-- VAT 영세율첨부서류 조회.
  PROCEDURE SELECT_ZERO_TAX_RATE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_ZERO_TAX_RATE.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_ZERO_TAX_RATE.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_ZERO_TAX_RATE.ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_ZERO_TAX_RATE.ISSUE_DATE%TYPE
            , W_DOCUMENT_NUM      IN FI_VAT_ZERO_TAX_RATE.DOCUMENT_NUM%TYPE
            );

-- VAT 영세율첨부서류 INSERT.
  PROCEDURE INSERT_ZERO_TAX_RATE
            ( P_ZERO_TAX_RATE_ID    OUT FI_VAT_ZERO_TAX_RATE.ZERO_TAX_RATE_ID%TYPE
            , P_TAX_CODE            IN FI_VAT_ZERO_TAX_RATE.TAX_CODE%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_TAX_RATE.SOB_ID%TYPE
            , P_DOCUMENT_TYPE       IN FI_VAT_ZERO_TAX_RATE.DOCUMENT_TYPE%TYPE
            , P_ISSUER_NAME         IN FI_VAT_ZERO_TAX_RATE.ISSUER_NAME%TYPE
            , P_ISSUE_DATE          IN FI_VAT_ZERO_TAX_RATE.ISSUE_DATE%TYPE
            , P_SHIPPING_DATE       IN FI_VAT_ZERO_TAX_RATE.SHIPPING_DATE%TYPE
            , P_DOCUMENT_NUM        IN FI_VAT_ZERO_TAX_RATE.DOCUMENT_NUM%TYPE
            , P_CURRENCY_CODE       IN FI_VAT_ZERO_TAX_RATE.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_VAT_ZERO_TAX_RATE.EXCHANGE_RATE%TYPE
            , P_TOTAL_CURR_AMOUNT   IN FI_VAT_ZERO_TAX_RATE.TOTAL_CURR_AMOUNT%TYPE
            , P_TOTAL_BASE_AMOUNT   IN FI_VAT_ZERO_TAX_RATE.TOTAL_BASE_AMOUNT%TYPE
            , P_THIS_CURR_AMOUNT    IN FI_VAT_ZERO_TAX_RATE.THIS_CURR_AMOUNT%TYPE
            , P_THIS_BASE_AMOUNT    IN FI_VAT_ZERO_TAX_RATE.THIS_BASE_AMOUNT%TYPE
            , P_USER_ID             IN FI_VAT_ZERO_TAX_RATE.CREATED_BY%TYPE 
            );

-- VAT 영세율첨부서류 UPDATE.
  PROCEDURE UPDATE_ZERO_TAX_RATE
            ( W_ZERO_TAX_RATE_ID    IN FI_VAT_ZERO_TAX_RATE.ZERO_TAX_RATE_ID%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_TAX_RATE.SOB_ID%TYPE
            , P_DOCUMENT_TYPE       IN FI_VAT_ZERO_TAX_RATE.DOCUMENT_TYPE%TYPE
            , P_ISSUER_NAME         IN FI_VAT_ZERO_TAX_RATE.ISSUER_NAME%TYPE
            , P_ISSUE_DATE          IN FI_VAT_ZERO_TAX_RATE.ISSUE_DATE%TYPE
            , P_SHIPPING_DATE       IN FI_VAT_ZERO_TAX_RATE.SHIPPING_DATE%TYPE
            , P_DOCUMENT_NUM        IN FI_VAT_ZERO_TAX_RATE.DOCUMENT_NUM%TYPE
            , P_CURRENCY_CODE       IN FI_VAT_ZERO_TAX_RATE.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_VAT_ZERO_TAX_RATE.EXCHANGE_RATE%TYPE
            , P_TOTAL_CURR_AMOUNT   IN FI_VAT_ZERO_TAX_RATE.TOTAL_CURR_AMOUNT%TYPE
            , P_TOTAL_BASE_AMOUNT   IN FI_VAT_ZERO_TAX_RATE.TOTAL_BASE_AMOUNT%TYPE
            , P_THIS_CURR_AMOUNT    IN FI_VAT_ZERO_TAX_RATE.THIS_CURR_AMOUNT%TYPE
            , P_THIS_BASE_AMOUNT    IN FI_VAT_ZERO_TAX_RATE.THIS_BASE_AMOUNT%TYPE
            , P_USER_ID             IN FI_VAT_ZERO_TAX_RATE.CREATED_BY%TYPE 
            );

-- VAT 영세율첨부서류 DELETE.
  PROCEDURE DELETE_ZERO_TAX_RATE
            ( W_ZERO_TAX_RATE_ID    IN FI_VAT_ZERO_TAX_RATE.ZERO_TAX_RATE_ID%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_TAX_RATE.SOB_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- VAT 영세율첨부서류 조회.
  PROCEDURE SET_CREATE_ZERO_TAX_RATE
            ( W_TAX_CODE          IN FI_VAT_ZERO_TAX_RATE.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_ZERO_TAX_RATE.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_ZERO_TAX_RATE.ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_ZERO_TAX_RATE.ISSUE_DATE%TYPE
            , P_USER_ID           IN FI_VAT_ZERO_TAX_RATE.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            );

---------------------------------------------------------------------------------------------------
-- VAT 수출실적명세서 마감여부 체크.
  FUNCTION CLOSED_YN_F
            ( W_ZERO_TAX_RATE_ID  IN FI_VAT_ZERO_TAX_RATE.ZERO_TAX_RATE_ID%TYPE
            , P_SOB_ID            IN FI_VAT_ZERO_TAX_RATE.SOB_ID%TYPE
            ) RETURN VARCHAR2;

END FI_VAT_ZERO_TAX_RATE_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_ZERO_TAX_RATE_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_VAT_ZERO_TAX_RATE_G
/* Description  : 부가세 조회-영세율첨부서류 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- VAT 영세율첨부서류 조회.
  PROCEDURE SELECT_ZERO_TAX_RATE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_ZERO_TAX_RATE.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_ZERO_TAX_RATE.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_ZERO_TAX_RATE.ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_ZERO_TAX_RATE.ISSUE_DATE%TYPE
            , W_DOCUMENT_NUM      IN FI_VAT_ZERO_TAX_RATE.DOCUMENT_NUM%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT ZTR.TAX_CODE
           , FI_COMMON_G.CODE_NAME_F('TAX_CODE', ZTR.TAX_CODE, ZTR.SOB_ID) AS TAX_CODE_DESC
           , ZTR.DOCUMENT_TYPE
           , FI_COMMON_G.CODE_NAME_F('VAT_DOC_TYPE', ZTR.DOCUMENT_TYPE, ZTR.SOB_ID) AS DOCUMENT_TYPE_DESC
           , ZTR.ISSUER_NAME
           , ZTR.ISSUE_DATE
           , ZTR.SHIPPING_DATE
           , ZTR.DOCUMENT_NUM
           , ZTR.CURRENCY_CODE
           , ZTR.EXCHANGE_RATE
           , ZTR.TOTAL_CURR_AMOUNT
           , ZTR.TOTAL_BASE_AMOUNT
           , ZTR.THIS_CURR_AMOUNT
           , ZTR.THIS_BASE_AMOUNT
           , ZTR.ZERO_TAX_RATE_ID
           , ZTR.INTERFACE_HEADER_ID
        FROM FI_VAT_ZERO_TAX_RATE ZTR
      WHERE ZTR.TAX_CODE          = W_TAX_CODE
        AND ZTR.VAT_ISSUE_DATE    BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
        AND ZTR.SOB_ID            = W_SOB_ID
        AND NVL(ZTR.DOCUMENT_NUM, '-') LIKE W_DOCUMENT_NUM || '%'
      ORDER BY ZTR.TAX_CODE, ZTR.CUSTOMER_CODE, ZTR.DOCUMENT_NUM, ZTR.ISSUE_DATE
      ;
  END SELECT_ZERO_TAX_RATE;

-- VAT 영세율첨부서류 INSERT.
  PROCEDURE INSERT_ZERO_TAX_RATE
            ( P_ZERO_TAX_RATE_ID    OUT FI_VAT_ZERO_TAX_RATE.ZERO_TAX_RATE_ID%TYPE
            , P_TAX_CODE            IN FI_VAT_ZERO_TAX_RATE.TAX_CODE%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_TAX_RATE.SOB_ID%TYPE
            , P_DOCUMENT_TYPE       IN FI_VAT_ZERO_TAX_RATE.DOCUMENT_TYPE%TYPE
            , P_ISSUER_NAME         IN FI_VAT_ZERO_TAX_RATE.ISSUER_NAME%TYPE
            , P_ISSUE_DATE          IN FI_VAT_ZERO_TAX_RATE.ISSUE_DATE%TYPE
            , P_SHIPPING_DATE       IN FI_VAT_ZERO_TAX_RATE.SHIPPING_DATE%TYPE
            , P_DOCUMENT_NUM        IN FI_VAT_ZERO_TAX_RATE.DOCUMENT_NUM%TYPE
            , P_CURRENCY_CODE       IN FI_VAT_ZERO_TAX_RATE.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_VAT_ZERO_TAX_RATE.EXCHANGE_RATE%TYPE
            , P_TOTAL_CURR_AMOUNT   IN FI_VAT_ZERO_TAX_RATE.TOTAL_CURR_AMOUNT%TYPE
            , P_TOTAL_BASE_AMOUNT   IN FI_VAT_ZERO_TAX_RATE.TOTAL_BASE_AMOUNT%TYPE
            , P_THIS_CURR_AMOUNT    IN FI_VAT_ZERO_TAX_RATE.THIS_CURR_AMOUNT%TYPE
            , P_THIS_BASE_AMOUNT    IN FI_VAT_ZERO_TAX_RATE.THIS_BASE_AMOUNT%TYPE
            , P_USER_ID             IN FI_VAT_ZERO_TAX_RATE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT      NUMBER := 0;
  BEGIN
    BEGIN
      SELECT COUNT(ZTR.TAX_CODE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_VAT_ZERO_TAX_RATE ZTR
      WHERE ZTR.TAX_CODE          = P_TAX_CODE
        AND ZTR.DOCUMENT_TYPE     = P_DOCUMENT_TYPE
        AND ZTR.ISSUER_NAME       = P_ISSUER_NAME
        AND ZTR.DOCUMENT_NUM      = P_DOCUMENT_NUM
        AND ZTR.SOB_ID            = P_SOB_ID
        AND ZTR.ISSUE_DATE        = P_ISSUE_DATE
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90003', '&&FIELD_NAME:=L/C Num(L/C번호)'));
    END IF;

    SELECT FI_VAT_ZERO_TAX_RATE_S1.NEXTVAL
      INTO P_ZERO_TAX_RATE_ID
      FROM DUAL;

    INSERT INTO FI_VAT_ZERO_TAX_RATE
    ( ZERO_TAX_RATE_ID
    , TAX_CODE 
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
    ( P_ZERO_TAX_RATE_ID
    , P_TAX_CODE
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
  END INSERT_ZERO_TAX_RATE;

-- VAT 영세율첨부서류 UPDATE.
  PROCEDURE UPDATE_ZERO_TAX_RATE
            ( W_ZERO_TAX_RATE_ID    IN FI_VAT_ZERO_TAX_RATE.ZERO_TAX_RATE_ID%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_TAX_RATE.SOB_ID%TYPE
            , P_DOCUMENT_TYPE       IN FI_VAT_ZERO_TAX_RATE.DOCUMENT_TYPE%TYPE
            , P_ISSUER_NAME         IN FI_VAT_ZERO_TAX_RATE.ISSUER_NAME%TYPE
            , P_ISSUE_DATE          IN FI_VAT_ZERO_TAX_RATE.ISSUE_DATE%TYPE
            , P_SHIPPING_DATE       IN FI_VAT_ZERO_TAX_RATE.SHIPPING_DATE%TYPE
            , P_DOCUMENT_NUM        IN FI_VAT_ZERO_TAX_RATE.DOCUMENT_NUM%TYPE
            , P_CURRENCY_CODE       IN FI_VAT_ZERO_TAX_RATE.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_VAT_ZERO_TAX_RATE.EXCHANGE_RATE%TYPE
            , P_TOTAL_CURR_AMOUNT   IN FI_VAT_ZERO_TAX_RATE.TOTAL_CURR_AMOUNT%TYPE
            , P_TOTAL_BASE_AMOUNT   IN FI_VAT_ZERO_TAX_RATE.TOTAL_BASE_AMOUNT%TYPE
            , P_THIS_CURR_AMOUNT    IN FI_VAT_ZERO_TAX_RATE.THIS_CURR_AMOUNT%TYPE
            , P_THIS_BASE_AMOUNT    IN FI_VAT_ZERO_TAX_RATE.THIS_BASE_AMOUNT%TYPE
            , P_USER_ID             IN FI_VAT_ZERO_TAX_RATE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    IF FI_VAT_ZERO_TAX_RATE_G.CLOSED_YN_F(W_ZERO_TAX_RATE_ID, P_SOB_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90007', '&&FIELD_NAME:=This Document Data(해당 L/C번호)'));
    END IF;
    UPDATE FI_VAT_ZERO_TAX_RATE
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
    WHERE ZERO_TAX_RATE_ID    = W_ZERO_TAX_RATE_ID;
  END UPDATE_ZERO_TAX_RATE;

-- VAT 영세율첨부서류 DELETE.
  PROCEDURE DELETE_ZERO_TAX_RATE
            ( W_ZERO_TAX_RATE_ID    IN FI_VAT_ZERO_TAX_RATE.ZERO_TAX_RATE_ID%TYPE
            , P_SOB_ID              IN FI_VAT_ZERO_TAX_RATE.SOB_ID%TYPE
            )
  AS
  BEGIN
    IF FI_VAT_ZERO_TAX_RATE_G.CLOSED_YN_F(W_ZERO_TAX_RATE_ID, P_SOB_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90007', '&&FIELD_NAME:=This Document Data(해당 L/C번호)'));
    END IF;

    DELETE FROM FI_VAT_ZERO_TAX_RATE
    WHERE ZERO_TAX_RATE_ID    = W_ZERO_TAX_RATE_ID;
  END DELETE_ZERO_TAX_RATE;

---------------------------------------------------------------------------------------------------
-- VAT 영세율첨부서류 조회.
  PROCEDURE SET_CREATE_ZERO_TAX_RATE
            ( W_TAX_CODE          IN FI_VAT_ZERO_TAX_RATE.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_ZERO_TAX_RATE.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_ZERO_TAX_RATE.ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_ZERO_TAX_RATE.ISSUE_DATE%TYPE
            , P_USER_ID           IN FI_VAT_ZERO_TAX_RATE.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_ZERO_TAX_RATE_ID  FI_VAT_ZERO_TAX_RATE.ZERO_TAX_RATE_ID%TYPE;
  BEGIN
    FOR C1 IN ( SELECT '2' AS DOCUMENT_TYPE
                     , S_SMI.BANK_CODE
                     , S_FB.BANK_NAME AS ISSUER_NAME
                     , TO_DATE(S_SMI.ISSUE_DATE, 'YYYY-MM-DD') AS ISSUE_DATE
                     , S_SMI.DOCUMENT_NUM
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
                    , (-- 전표 정보.
                      SELECT SMI.SLIP_LINE_ID
                           , SMI.SOB_ID
                           , MAX(CASE 
                                   WHEN SMI.MANAGEMENT_CODE IN('15', '25') THEN SMI.MANAGEMENT_VALUE        -- 15:L/C번호, 25:면장번호.
                                 END) AS DOCUMENT_NUM
                           , MAX(DECODE(SMI.MANAGEMENT_CODE, '10', SMI.MANAGEMENT_VALUE)) AS ISSUE_DATE     -- 발행일자.
                           , MAX(DECODE(SMI.MANAGEMENT_CODE, '30', SMI.MANAGEMENT_VALUE)) AS BANK_CODE      -- 은행.
                           , MAX(DECODE(SMI.MANAGEMENT_CODE, '13', SMI.MANAGEMENT_VALUE)) AS CUSTOMER_CODE  -- 거래처.
                        FROM FI_SLIP_MANAGEMENT_ITEM SMI
                      WHERE SMI.SOB_ID                  = W_SOB_ID
                      GROUP BY SMI.SLIP_LINE_ID
                           , SMI.SOB_ID
                      ) S_SMI
                    , (-- 은행정보
                       SELECT FB.BANK_CODE
                           , FB.BANK_NAME
                           , FB.SOB_ID
                        FROM FI_BANK FB
                      WHERE FB.BANK_GROUP               = '-'
                        AND FB.SOB_ID                   = W_SOB_ID
                      ) S_FB 
                    , (-- 세금계산서 발행일자.
                      SELECT SSL.SLIP_HEADER_ID
                          , SSL.SOB_ID
                          , TO_DATE(MAX(DECODE(SMI.MANAGEMENT_CODE, '33', SMI.MANAGEMENT_VALUE)), 'YYYY-MM-DD') AS VAT_ISSUE_DATE  -- 33:세금계산서발행일.
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
                  AND VA.VAT_TYPE                 IN('2', '14')  -- 영세율.
                  AND VA.VAT_DOCUMENT_TYPE        = '2'          -- 영세율첨부서류.
                  AND VA.ENABLED_FLAG             = 'Y'
                  AND VA.VAT_ENABLED_FLAG         = 'N'          -- 부가세여부가 아닌것.
                  AND S_VID.VAT_ISSUE_DATE        BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                  AND SH.SOB_ID                   = W_SOB_ID
                  AND SH.CONFIRM_YN               = 'Y'
                  /*SELECT '2' AS DOCUMENT_TYPE
                     , S_SMI.BANK_CODE
                     , S_FB.BANK_NAME AS ISSUER_NAME
                     , TO_DATE(S_SMI.ISSUE_DATE, 'YYYY-MM-DD') AS ISSUE_DATE
                     , S_SMI.DOCUMENT_NUM
                     , SL.CURRENCY_CODE AS CURRENCY_CODE
                     , SL.EXCHANGE_RATE AS EXCHANGE_RATE
                     , SL.GL_CURRENCY_AMOUNT AS GL_CURR_AMOUNT
                     , SL.GL_AMOUNT
                     , VA.SOB_ID
                     , 'I' AS CREATED_TYPE
                     , 'SLIP' AS SOURCE_TABLE
                     , SL.SLIP_HEADER_ID
                     , SL.SLIP_LINE_ID
                  FROM FI_VAT_ACCOUNTS VA
                    , FI_ACCOUNT_CONTROL AC
                    , FI_SLIP_LINE SL
                    , FI_SLIP_HEADER SH
                    , (-- 전표 정보.
                      SELECT SMI.SLIP_LINE_ID
                           , SMI.SOB_ID
                           , MAX(CASE 
                                   WHEN MC.LOOKUP_TYPE IN('LC_NO', 'DOCUMENT_NO') THEN SMI.MANAGEMENT_VALUE
                                 END) AS DOCUMENT_NUM
                           , MAX(DECODE(MC.LOOKUP_TYPE, 'ISSUE_DATE', SMI.MANAGEMENT_VALUE)) AS ISSUE_DATE
                           , MAX(DECODE(MC.LOOKUP_TYPE, 'BANK', SMI.MANAGEMENT_VALUE)) AS BANK_CODE
                           , MAX(DECODE(MC.LOOKUP_TYPE, 'CUSTOMER', SMI.MANAGEMENT_VALUE)) AS CUSTOMER_CODE
                        FROM FI_SLIP_MANAGEMENT_ITEM SMI
                          , FI_MANAGEMENT_CODE_V MC
                      WHERE SMI.MANAGEMENT_ID           = MC.MANAGEMENT_ID
                        AND SMI.SOB_ID                  = MC.SOB_ID
                        AND SMI.SOB_ID                  = W_SOB_ID
                      GROUP BY SMI.SLIP_LINE_ID
                           , SMI.SOB_ID
                      ) S_SMI
                    , (-- 은행정보
                       SELECT FB.BANK_CODE
                           , FB.BANK_NAME
                           , FB.SOB_ID
                        FROM FI_BANK FB
                      WHERE FB.BANK_GROUP               = '-'
                        AND FB.SOB_ID                   = W_SOB_ID
                      ) S_FB 
                    , (-- 세금계산서 발행일자.
                      SELECT SSL.SLIP_HEADER_ID
                          , SSL.SOB_ID
                          , TO_DATE(MAX(DECODE(SMI.MANAGEMENT_CODE, '33', SMI.MANAGEMENT_VALUE)), 'YYYY-MM-DD') AS VAT_ISSUE_DATE  -- 33:세금계산서발행일.
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
                  AND VA.VAT_TYPE                 IN('2', '14')  -- 영세율.
                  AND VA.VAT_DOCUMENT_TYPE        = '2'          -- 영세율첨부서류.
                  AND VA.ENABLED_FLAG             = 'Y'
                  AND VA.VAT_ENABLED_FLAG         = 'N'          -- 부가세여부가 아닌것.
                  AND S_VID.VAT_ISSUE_DATE        BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                  AND SH.SOB_ID                   = W_SOB_ID
                  AND SH.CONFIRM_YN               = 'Y'*/
              )
    LOOP
      UPDATE FI_VAT_ZERO_TAX_RATE ZTR
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
      WHERE ZTR.SOURCE_TABLE      = C1.SOURCE_TABLE
        AND ZTR.INTERFACE_LINE_ID = C1.SLIP_LINE_ID
        AND ZTR.SOB_ID            = C1.SOB_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        SELECT FI_VAT_ZERO_TAX_RATE_S1.NEXTVAL
          INTO V_ZERO_TAX_RATE_ID
          FROM DUAL;

        INSERT INTO FI_VAT_ZERO_TAX_RATE
        ( ZERO_TAX_RATE_ID
        , TAX_CODE
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
        , CREATED_TYPE
        , SOURCE_TABLE
        , INTERFACE_HEADER_ID
        , INTERFACE_LINE_ID
        , CREATION_DATE
        , CREATED_BY
        , LAST_UPDATE_DATE
        , LAST_UPDATED_BY )
        VALUES
        ( V_ZERO_TAX_RATE_ID
        , W_TAX_CODE
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
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END SET_CREATE_ZERO_TAX_RATE;

---------------------------------------------------------------------------------------------------
-- VAT 영세율첨부서류 마감여부 체크.
  FUNCTION CLOSED_YN_F
            ( W_ZERO_TAX_RATE_ID  IN FI_VAT_ZERO_TAX_RATE.ZERO_TAX_RATE_ID%TYPE
            , P_SOB_ID            IN FI_VAT_ZERO_TAX_RATE.SOB_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_CLOSED_YN         CHAR(1) := 'N';
  BEGIN
    BEGIN
      SELECT ZTR.CLOSED_YN
        INTO V_CLOSED_YN
        FROM FI_VAT_ZERO_TAX_RATE ZTR
      WHERE ZTR.ZERO_TAX_RATE_ID  = W_ZERO_TAX_RATE_ID
        AND ZTR.SOB_ID            = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CLOSED_YN := 'N';
    END;
    RETURN V_CLOSED_YN;
  END CLOSED_YN_F;

END FI_VAT_ZERO_TAX_RATE_G;
/
