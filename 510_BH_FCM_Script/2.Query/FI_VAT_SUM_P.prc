CREATE OR REPLACE PROCEDURE FI_VAT_SUM_P
  ( P_GB                                IN  VARCHAR2                 ,
    P_SLIP_LINE_ID                      IN  FI_SLIP_LINE.SLIP_LINE_ID%TYPE,
    P_SLIP_HEADER_ID                    IN  FI_SLIP_LINE.SLIP_HEADER_ID%TYPE,
    P_SOB_ID                            IN  FI_SLIP_LINE.SOB_ID%TYPE,
    P_ORG_ID                            IN  FI_SLIP_LINE.ORG_ID%TYPE,
    P_PERIOD_NAME                       IN  FI_SLIP_LINE.PERIOD_NAME%TYPE,
    P_GL_DATE                           IN  FI_SLIP_LINE.GL_DATE%TYPE,
    P_GL_NUM                            IN  FI_SLIP_LINE.GL_NUM%TYPE,
    P_CUSTOMER_ID                       IN  FI_SLIP_LINE.CUSTOMER_ID%TYPE,
    P_SLIP_TYPE                         IN  FI_SLIP_LINE.SLIP_TYPE%TYPE,
    P_ACCOUNT_CONTROL_ID                IN  FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE,
    P_ACCOUNT_CODE                      IN  FI_SLIP_LINE.ACCOUNT_CODE%TYPE,
    P_GL_AMOUNT                         IN  FI_SLIP_LINE.GL_AMOUNT%TYPE,
    P_CURRENCY_CODE                     IN  FI_SLIP_LINE.CURRENCY_CODE%TYPE,
    P_EXCHANGE_RATE                     IN  FI_SLIP_LINE.EXCHANGE_RATE%TYPE,
    P_GL_CURRENCY_AMOUNT                IN  FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE,
    P_MANAGEMENT1                       IN  FI_SLIP_LINE.MANAGEMENT1%TYPE,
    P_MANAGEMENT2                       IN  FI_SLIP_LINE.MANAGEMENT2%TYPE,
    P_REFER1                            IN  FI_SLIP_LINE.REFER1%TYPE,
    P_REFER2                            IN  FI_SLIP_LINE.REFER2%TYPE,
    P_REFER3                            IN  FI_SLIP_LINE.REFER3%TYPE,
    P_REFER4                            IN  FI_SLIP_LINE.REFER4%TYPE,
    P_REFER5                            IN  FI_SLIP_LINE.REFER5%TYPE,
    P_VOUCH_CODE                        IN  FI_SLIP_LINE.VOUCH_CODE%TYPE,
    P_REFER_RATE                        IN  FI_SLIP_LINE.REFER_RATE%TYPE,
    P_REFER_AMOUNT                      IN  FI_SLIP_LINE.REFER_AMOUNT%TYPE,
    P_REFER_DATE1                       IN  FI_SLIP_LINE.REFER_DATE1%TYPE,
    P_REMARK                            IN  FI_SLIP_LINE.REMARK%TYPE,
    P_USER_ID                           IN  FI_SLIP_LINE.CREATED_BY%TYPE
    ) 
  AS
/*
    부가세 계정(VAT_ENABLED_FLAG  = 'Y')을 집계처리한다
    P_GL_AMOUNT : 세액 / 공급가액은 관리항목에 입력.
*/
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_VAT_ID            FI_VAT_MASTER.VAT_ID%TYPE;                     -- 세금계산서 ID.
    V_TAX_CODE          FI_VAT_MASTER.TAX_CODE%TYPE := '110';          -- TAX_CODE(안산본사).
    V_VAT_ISSUE_DATE    FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE := NULL;     -- 세금계산서 발행일자.
    V_PERIOD_NAME       FI_VAT_MASTER.PERIOD_NAME%TYPE := NULL;        -- 발행년월.
    V_VAT_TYPE          FI_VAT_MASTER.VAT_TYPE%TYPE := NULL;           -- 계산서 유형.
    V_VAT_GUBUN         FI_VAT_MASTER.VAT_GUBUN%TYPE := NULL;          -- 매입매출구분
    
    V_GL_AMOUNT         FI_SLIP_LINE.GL_AMOUNT%TYPE := 0;              -- 공급가액.
    V_VAT_AMOUNT        FI_SLIP_LINE.GL_AMOUNT%TYPE := 0;              -- 부가세금액.
    V_VAT_COUNT         FI_VAT_MASTER.VAT_COUNT%TYPE := 1;             -- 계산서매수.
    V_TMEP_VAT_AMOUNT   FI_SLIP_LINE.GL_AMOUNT%TYPE := 0;              -- 부가세금액(관리항목에 입력한 금액).
    
    V_CUSTOMER_CODE     VARCHAR2(20);                                  -- 거래처코드.
    V_CUSTOMER_ID       FI_VAT_MASTER.CUSTOMER_ID%TYPE := NULL;        -- 거래처ID;
    V_BUSINESS_TYPE     FI_VAT_MASTER.BUSINESS_TYPE%TYPE := NULL;      -- 거래처구분(C-법인,P-개인);
    V_TAX_ELECTRO_YN    FI_VAT_MASTER.TAX_ELECTRO_YN%TYPE := 'N';      -- 전자세금계산서 여부;
    
    V_RESIDENT_REG_NUM  FI_VAT_MASTER.RESIDENT_REG_NUM%TYPE;           -- 주민번호.
    V_CREDITCARD_CODE   FI_VAT_MASTER.CREDITCARD_CODE%TYPE := NULL;    -- 신용카드번호.
    V_CASH_RECEIPT_NUM  FI_VAT_MASTER.CASH_RECEIPT_NUM%TYPE := NULL;   -- 현금영수증 승인번호.
    V_DOCUMENT_NUM      FI_VAT_MASTER.DOCUMENT_NUM%TYPE := NULL;       -- L/C번호(수출신고,신용장번호).
    V_INPUT_DED_NOT_CODE  FI_VAT_MASTER.INPUT_DED_NOT_CODE%TYPE;       -- 매입세액불공제사유코드.
    V_INPUT_FREE_CODE   FI_VAT_MASTER.INPUT_FREE_CODE%TYPE;            -- 면세매입사유코드.
    V_INPUT_DEEMED_TAX_CODE FI_VAT_MASTER.INPUT_DEEMED_TAX_CODE%TYPE;  -- 의제매입세액사유.;
  BEGIN
---------------------------------------------------------------------------------------------------
    -- 전표 입력
    IF P_GB = 'I' THEN
      -- 세금계산서 관련정보 조회.
      BEGIN
        SELECT MAX(DECODE(FMC.LOOKUP_TYPE, 'TAX_CODE', SMI.MANAGEMENT_VALUE, NULL)) AS TAX_CODE  -- 부가세신고 사업장코드.
             , MAX(DECODE(FMC.LOOKUP_TYPE, 'TAX_ELECTRO', SMI.MANAGEMENT_VALUE, NULL)) AS TAX_ELECTRO  -- 전자세금계산서.
             , MAX(DECODE(FMC.LOOKUP_TYPE, 'VAT_ISSUE_DATE', SMI.MANAGEMENT_VALUE, NULL)) AS VAT_ISSUE_DATE  -- 세금계산서 발행일.
             , NVL(TO_NUMBER(MAX(DECODE(FMC.LOOKUP_TYPE, 'SUPPLY_AMOUNT', REPLACE(SMI.MANAGEMENT_VALUE, ',', ''), NULL))), 0) AS SUPPLY_AMOUNT  -- 공급가액.
             , NVL(TO_NUMBER(MAX(DECODE(FMC.LOOKUP_TYPE, 'VAT_AMOUNT', REPLACE(SMI.MANAGEMENT_VALUE, ',', ''), NULL))), 0) AS VAT_AMOUNT  -- 세액.
             , MAX(DECODE(FMC.LOOKUP_TYPE, 'CUSTOMER', SMI.MANAGEMENT_VALUE, NULL)) AS CUSTOMER_CODE         -- 거래처.
             , MAX(DECODE(FMC.LOOKUP_TYPE, 'RESIDENT_REG_NUM', SMI.MANAGEMENT_VALUE, NULL)) AS RESIDENT_REG_NUM  -- 주민등록번호.
             , MAX(DECODE(FMC.LOOKUP_TYPE, 'CREDIT_CARD', SMI.MANAGEMENT_VALUE, NULL)) AS CREDIT_CARD        -- 신용카드코드.
             , MAX(DECODE(FMC.LOOKUP_TYPE, 'CASH_RECEIPT', SMI.MANAGEMENT_VALUE, NULL)) AS CASH_RECEIPT      -- 현금영수증번호.
             , MAX(CASE
                     WHEN FMC.LOOKUP_TYPE = 'DOCUMENT_NO' THEN SMI.MANAGEMENT_VALUE
                     WHEN FMC.LOOKUP_TYPE = 'LC_NO' THEN SMI.MANAGEMENT_VALUE
                     ELSE NULL
                    END) AS DOCUMENT_NO                                                                      -- 면장NO.
             , MAX(DECODE(FMC.LOOKUP_TYPE, 'VAT_NOT_DED', SMI.MANAGEMENT_VALUE, NULL)) AS VAT_DED_NOT        -- 불공제사유.
             , MAX(DECODE(FMC.LOOKUP_TYPE, 'VAT_FREE', SMI.MANAGEMENT_VALUE, NULL)) AS VAT_FREE              -- 면세사유.

          INTO V_TAX_CODE, V_TAX_ELECTRO_YN, V_VAT_ISSUE_DATE, V_GL_AMOUNT, V_TMEP_VAT_AMOUNT, V_CUSTOMER_CODE
             , V_RESIDENT_REG_NUM, V_CREDITCARD_CODE, V_CASH_RECEIPT_NUM, V_DOCUMENT_NUM
             , V_INPUT_DED_NOT_CODE, V_INPUT_FREE_CODE
          FROM FI_SLIP_MANAGEMENT_ITEM SMI
            , FI_MANAGEMENT_CODE_V FMC
        WHERE SMI.MANAGEMENT_ID        = FMC.MANAGEMENT_ID
          AND SMI.SLIP_LINE_ID         = P_SLIP_LINE_ID
          AND SMI.SOB_ID               = P_SOB_ID
          AND FMC.LOOKUP_TYPE          IN('TAX_CODE', 'TAX_ELECTRO', 'VAT_ISSUE_DATE', 
                                          'SUPPLY_AMOUNT', 'VAT_AMOUNT', 'CUSTOMER', 
                                          'RESIDENT_REG_NUM', 'CREDIT_CARD', 'CASH_RECEIPT',
                                          'LC_NO', 'DOCUMENT_NO',
                                          'VAT_NOT_DED', 'VAT_FREE')
        ;
      EXCEPTION WHEN OTHERS THEN
        V_TAX_CODE := NULL; 
        V_TAX_ELECTRO_YN := NULL;
        V_VAT_ISSUE_DATE := NULL;
        V_GL_AMOUNT := 0;
        V_TMEP_VAT_AMOUNT := 0;
        V_CUSTOMER_CODE := NULL;
        V_RESIDENT_REG_NUM := NULL;
        V_CREDITCARD_CODE := NULL;
        V_CASH_RECEIPT_NUM := NULL;
        V_DOCUMENT_NUM := NULL;
        V_INPUT_DED_NOT_CODE := NULL;
        V_INPUT_FREE_CODE := NULL;
      END;

      -- TAX_CODE.
      IF V_TAX_CODE IS NULL THEN
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
      END IF;

      -- 매입매출구분, 세금계산서 유형.
      BEGIN
        SELECT VA.VAT_GUBUN
            , VA.VAT_TYPE
            , NVL(VT.TAX_ELECTRO_YN, 'N') AS TAX_ELECTRO_YN
          INTO V_VAT_GUBUN
            , V_VAT_TYPE
            , V_TAX_ELECTRO_YN
          FROM FI_VAT_ACCOUNTS VA
            , FI_VAT_TYPE_V VT
        WHERE VA.VAT_TYPE           = VT.VAT_TYPE(+)
          AND VA.SOB_ID             = VT.SOB_ID(+)
          AND VA.ACCOUNT_CONTROL_ID = P_ACCOUNT_CONTROL_ID
          AND VA.SOB_ID             = P_SOB_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        IF SUBSTR(P_ACCOUNT_CODE, 1, 1) = '1' THEN
          V_VAT_GUBUN := '1';
        ELSE
          V_VAT_GUBUN := '2';
        END IF;
        V_VAT_TYPE := '1';
        V_TAX_ELECTRO_YN := 'N';
      END;
      
      -- 사업장 정보.
      BEGIN
        SELECT SC.SUPP_CUST_ID
          INTO V_CUSTOMER_ID
          FROM FI_SUPP_CUST_V SC
        WHERE SC.SUPP_CUST_CODE   = V_CUSTOMER_CODE
          AND SC.SOB_ID           = P_SOB_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10272', '&&FIELD_NAME:=Customer(거래처)'));
      END;
      -- 거래처구분.
      IF V_CUSTOMER_CODE IS NOT NULL THEN
      -- 법인사업자/개인사업자.
        V_BUSINESS_TYPE := 'C';
      ELSE
      -- 개인.
        V_BUSINESS_TYPE := 'P';
      END IF;
      --부가세.
      V_PERIOD_NAME     := TO_CHAR(V_VAT_ISSUE_DATE, 'YYYY-MM');
      IF NVL(V_TMEP_VAT_AMOUNT, 0) <> 0 THEN
        V_VAT_AMOUNT    := NVL(V_TMEP_VAT_AMOUNT, 0);
      ELSE
        V_VAT_AMOUNT    := P_GL_AMOUNT;
      END IF;
      BEGIN
        -- 부가세 DATA INSERT
        UPDATE FI_VAT_MASTER VM
          SET VM.VAT_ISSUE_DATE    = V_VAT_ISSUE_DATE
            , VM.VAT_TYPE          = V_VAT_TYPE
            , VM.VAT_GUBUN         = V_VAT_GUBUN
            , VM.CUSTOMER_ID       = V_CUSTOMER_ID
            , VM.GL_AMOUNT         = NVL(V_GL_AMOUNT, 0)
            , VM.VAT_AMOUNT        = NVL(V_VAT_AMOUNT, 0)
            , VM.VAT_COUNT         = NVL(V_VAT_COUNT, 0)
            , VM.REMARK            = P_REMARK
            , VM.CURRENCY_CODE     = P_CURRENCY_CODE
            , VM.EXCHANGE_RATE     = NVL(P_EXCHANGE_RATE, 0)
            , VM.GL_CURR_AMOUNT    = NVL(P_GL_CURRENCY_AMOUNT, 0)
            , VM.PERIOD_NAME       = V_PERIOD_NAME
            , VM.BUSINESS_TYPE     = V_BUSINESS_TYPE
            , VM.TAX_ELECTRO_YN    = NVL(V_TAX_ELECTRO_YN, 'N')
            , VM.CREATED_TYPE      = 'A'
            , VM.CREDITCARD_CODE   = V_CREDITCARD_CODE
            , VM.CASH_RECEIPT_NUM  = V_CASH_RECEIPT_NUM
            , VM.DOCUMENT_NUM      = V_DOCUMENT_NUM
            , VM.INPUT_DED_NOT_CODE   = V_INPUT_DED_NOT_CODE
            , VM.INPUT_FREE_CODE      = V_INPUT_FREE_CODE
            , VM.GL_DATE              = P_GL_DATE
        WHERE SLIP_LINE_ID    = P_SLIP_LINE_ID
          AND SOB_ID          = P_SOB_ID ;
        IF SQL%ROWCOUNT = 0 THEN
          SELECT FI_VAT_MASTER_S1.NEXTVAL
            INTO V_VAT_ID
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
          , CURRENCY_CODE
          , EXCHANGE_RATE
          , GL_CURR_AMOUNT
          , PERIOD_NAME
          , BUSINESS_TYPE
          , TAX_ELECTRO_YN
          , CREDITCARD_CODE
          , CASH_RECEIPT_NUM
          , DOCUMENT_NUM
          , INPUT_DED_NOT_CODE
          , INPUT_FREE_CODE
          , INPUT_DEEMED_TAX_CODE
          , SLIP_HEADER_ID
          , SLIP_LINE_ID
          , GL_NUM
          , GL_DATE
          , ACCOUNT_CONTROL_ID
          , ACCOUNT_CODE
          , CREATION_DATE
          , CREATED_BY
          , LAST_UPDATE_DATE
          , LAST_UPDATED_BY
          ) VALUES
          ( V_VAT_ID
          , V_TAX_CODE
          , V_VAT_ISSUE_DATE
          , V_VAT_TYPE
          , V_VAT_GUBUN
          , P_SOB_ID
          , p_ORG_ID
          , V_CUSTOMER_ID
          , NVL(V_GL_AMOUNT, 0)
          , NVL(V_VAT_AMOUNT, 0)
          , NVL(V_VAT_COUNT, 1)
          , P_REMARK
          , P_CURRENCY_CODE
          , NVL(P_EXCHANGE_RATE, 0)
          , NVL(P_GL_CURRENCY_AMOUNT, 0)
          , V_PERIOD_NAME
          , V_BUSINESS_TYPE
          , V_TAX_ELECTRO_YN
          , V_CREDITCARD_CODE
          , V_CASH_RECEIPT_NUM
          , V_DOCUMENT_NUM
          , V_INPUT_DED_NOT_CODE
          , V_INPUT_FREE_CODE
          , V_INPUT_DEEMED_TAX_CODE
          , P_SLIP_HEADER_ID
          , P_SLIP_LINE_ID
          , P_GL_NUM
          , P_GL_DATE
          , P_ACCOUNT_CONTROL_ID
          , P_ACCOUNT_CODE
          , V_SYSDATE
          , P_USER_ID
          , V_SYSDATE
          , P_USER_ID
          );
        END IF;
      END;

---------------------------------------------------------------------------------------------------
    -- 전표 삭제.
    ELSE
      BEGIN
        DELETE FROM  FI_VAT_MASTER
        WHERE SLIP_LINE_ID       = P_SLIP_LINE_ID
          AND SOB_ID             = P_SOB_ID 
        ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10176', NULL) || '(' || SQLERRM || ')');
      END;
    END IF;

END FI_VAT_SUM_P; 
/
