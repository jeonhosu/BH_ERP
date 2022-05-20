CREATE OR REPLACE PROCEDURE FI_VAT_SUM_P
(
    P_GB                                IN VARCHAR2                 ,
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
    P_REFER_DATE1                       IN  FI_SLIP_LINE.REFER_DATE1%TYPE

) AS
/*
    부가세 계정(VAT_ENABLED_FLAG  = 'Y')을 집계처리한다
*/
    V_VAT_GUBUN         FI_VAT_MASTER.VAT_GUBUN%TYPE := NULL;          -- 매입매출구분    
    V_VAT_SLIP_COUNT    FI_VAT_MASTER.VAT_SLIP_COUNT%TYPE := 1;        -- 계산서매수.
    V_GL_AMOUNT         FI_SLIP_LINE.GL_AMOUNT%TYPE := 0;              -- 공급가액.
    V_VAT_AMOUNT        FI_SLIP_LINE.GL_AMOUNT%TYPE := 0;              -- 부가세금액.
    V_TAX_INVOICE_TYPE  FI_VAT_MASTER.TAX_INVOICE_TYPE%TYPE := NULL;   -- 세금계산서 형태(1.일반, 2.전자)
    V_ISSUE_DATE        DATE := NULL;                                  -- 발행일자.
    V_RESIDENT_REG_NUM  FI_VAT_MASTER.RESIDENT_REG_NUM%TYPE := NULL;   -- 주민등록번호.
    V_TAX_CODE          FI_VAT_MASTER.TAX_CODE%TYPE := NULL;           -- TAX_CODE.
    V_CREDITCARD_CODE   FI_VAT_MASTER.CREDITCARD_CODE%TYPE := NULL;    -- 신용카드 코드.

    V_CONSIGNEE_ID      FI_VAT_MASTER.CONSIGNEE_ID%TYPE := NULL;       -- CONSIGNEE_ID.
    V_VAT_TYPE_AP       VARCHAR2(50) := NULL;
    V_VAT_TYPE_AR       VARCHAR2(50) := NULL;
    V_VAT_TYPE_ID       FI_VAT_MASTER.VAT_TYPE_ID%TYPE := NULL;        -- 부가세 증빙 ID.
    V_VAT_REASON_CODE   FI_VAT_MASTER.VAT_REASON_CODE%TYPE := NULL;
    V_CASH_RECEIPT      FI_VAT_MASTER.CASH_RECEIPT_NUM%TYPE := NULL;

  BEGIN
    -- 전표 입력
    IF P_GB = 'I' THEN
      -- 세금계산서 타입.
      BEGIN
        SELECT MAX(DECODE(FMC.LOOKUP_TYPE, 'TAX_ELECTRO', SMI.MANAGEMENT_VALUE, NULL)) AS TAX_INVOICE_TYPE
             , MAX(DECODE(FMC.LOOKUP_TYPE, 'CREDIT_CARD', SMI.MANAGEMENT_VALUE, NULL)) AS CREDIT_CARD
             , MAX(DECODE(FMC.LOOKUP_TYPE, 'ISSUE_DATE', SMI.MANAGEMENT_VALUE, NULL)) AS ISSUE_DATE
             , NVL(TO_NUMBER(MAX(DECODE(FMC.LOOKUP_TYPE, 'SUPPLY_AMOUNT', REPLACE(SMI.MANAGEMENT_VALUE, ',', ''), NULL))), 0) AS SUPPLY_AMOUNT
             , NVL(TO_NUMBER(MAX(DECODE(FMC.LOOKUP_TYPE, 'VAT_AMOUNT', REPLACE(SMI.MANAGEMENT_VALUE, ',', ''), NULL))), 0) AS VAT_AMOUNT
             , MAX(DECODE(FMC.LOOKUP_TYPE, 'TAX_CODE', SMI.MANAGEMENT_VALUE, NULL)) AS TAX_CODE
             , MAX(DECODE(FMC.LOOKUP_TYPE, 'RESIDENT_REG_NUM', SMI.MANAGEMENT_VALUE, NULL)) AS TAX_CODE
             , MAX(DECODE(FMC.LOOKUP_TYPE, 'VAT_TYPE_AP', SMI.MANAGEMENT_VALUE, NULL)) AS TAX_CODE
             , MAX(DECODE(FMC.LOOKUP_TYPE, 'VAT_TYPE_AR', SMI.MANAGEMENT_VALUE, NULL)) AS TAX_CODE
             , MAX(DECODE(FMC.LOOKUP_TYPE, 'VAT_REASON', SMI.MANAGEMENT_VALUE, NULL)) AS VAT_REASON
             , MAX(DECODE(FMC.LOOKUP_TYPE, 'CASH_RECEIPT', SMI.MANAGEMENT_VALUE, NULL)) AS CASH_RECEIPT
          INTO V_TAX_INVOICE_TYPE, V_CREDITCARD_CODE, V_ISSUE_DATE, V_GL_AMOUNT, V_VAT_AMOUNT, V_TAX_CODE, V_RESIDENT_REG_NUM
             , V_VAT_TYPE_AP, V_VAT_TYPE_AR, V_VAT_REASON_CODE, V_CASH_RECEIPT
          FROM FI_SLIP_MANAGEMENT_ITEM SMI
            , FI_MANAGEMENT_CODE_V FMC
        WHERE SMI.MANAGEMENT_ID        = FMC.MANAGEMENT_ID
          AND SMI.SLIP_LINE_ID         = P_SLIP_LINE_ID
          AND SMI.SOB_ID               = P_SOB_ID
          AND FMC.LOOKUP_TYPE          IN('TAX_ELECTRO', 'CREDIT_CARD', 'ISSUE_DATE',
                                          'SUPPLY_AMOUNT', 'VAT_AMOUNT', 'TAX_CODE', 'RESIDENT_REG_NUM',
                                          'VAT_TYPE_AP', 'VAT_TYPE_AR', 'VAT_REASON', 'CASH_RECEIPT')
        ;
      EXCEPTION WHEN OTHERS THEN
        V_TAX_INVOICE_TYPE := NULL;
        V_CREDITCARD_CODE := NULL;
        V_ISSUE_DATE := NULL;
        V_GL_AMOUNT := 0;
        V_VAT_AMOUNT := NVL(P_GL_AMOUNT, 0);
        V_TAX_CODE := NULL;
      END;

      -- TAX_CODE.
      IF V_TAX_CODE IS NULL THEN
        BEGIN
          SELECT FC.CODE AS TAX_CODE
            INTO V_TAX_CODE
            FROM FI_COMMON FC
          WHERE FC.GROUP_CODE           = 'TAX_CODE'
            AND FC.SOB_ID               = P_SOB_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          V_TAX_CODE := '110';
        END;
      END IF;

      -- 증빙 ID.
      IF V_VAT_TYPE_AP IS NOT NULL AND V_VAT_TYPE_AR IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10177', NULL));
      END IF;

      -- 세금계산서 타입.
      IF V_VAT_TYPE_AP IS NOT NULL THEN
        V_VAT_GUBUN := '1';
      ELSE
        V_VAT_GUBUN := '2';
      END IF;

      BEGIN
        SELECT FC.COMMON_ID
          INTO V_VAT_TYPE_ID
          FROM FI_COMMON FC
        WHERE FC.GROUP_CODE            = DECODE(V_VAT_GUBUN, '1', 'VAT_TYPE_AP', 'VAT_TYPE_AR')
          AND FC.CODE                  = DECODE(V_VAT_GUBUN, '1', V_VAT_TYPE_AP, V_VAT_TYPE_AR)
          AND FC.SOB_ID                = P_SOB_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_VAT_TYPE_ID := NULL;
      END;    
      BEGIN
        -- 부가세 DATA INSERT
        UPDATE FI_VAT_MASTER VM
          SET VM.GL_AMOUNT         = V_GL_AMOUNT
            , VM.VAT_AMOUNT        = V_VAT_AMOUNT
            , VM.VAT_SLIP_COUNT    = V_VAT_SLIP_COUNT
            , VM.SUPPLIER_ID       = P_CUSTOMER_ID
            , VM.RESIDENT_REG_NUM  = V_RESIDENT_REG_NUM
            , VM.TAX_CODE          = V_TAX_CODE
            , VM.CONSIGNEE_ID      = V_CONSIGNEE_ID
            , VM.VAT_TYPE_ID       = V_VAT_TYPE_ID
            , VM.VAT_REASON_CODE   = V_VAT_REASON_CODE
            , VM.CREDITCARD_CODE   = V_CREDITCARD_CODE
            , VM.CASH_RECEIPT_NUM  = V_CASH_RECEIPT
            , VM.VAT_ISSUE_DATE    = V_ISSUE_DATE
            , VM.VAT_GUBUN         = V_VAT_GUBUN
            , VM.TAX_INVOICE_TYPE  = NVL(V_TAX_INVOICE_TYPE, 'N')
        WHERE SLIP_LINE_ID    = P_SLIP_LINE_ID
          AND SOB_ID          = P_SOB_ID ;

        IF SQL%ROWCOUNT = 0 THEN
          INSERT INTO FI_VAT_MASTER
              (     SLIP_LINE_ID,          SLIP_HEADER_ID,
                    SOB_ID,                ORG_ID,
                    PERIOD_NAME,
                    GL_DATE,               GL_NUM,
                    VAT_GUBUN,             TAX_INVOICE_TYPE,
                    SLIP_TYPE,             VAT_ISSUE_DATE,
                    ACCOUNT_CONTROL_ID,    ACCOUNT_CODE,
                    GL_AMOUNT,             VAT_AMOUNT,
                    VAT_SLIP_COUNT,        VAT_NOTICE,
                    SUPPLIER_ID,           RESIDENT_REG_NUM,
                    TAX_CODE,              CONSIGNEE_ID,
                    VAT_TYPE_ID,           VOUCH_CODE,
                    VAT_REASON_CODE,       CREDITCARD_CODE,
                    CASH_RECEIPT_NUM )

          VALUES  ( P_SLIP_LINE_ID,               p_SLIP_HEADER_ID,
                    P_SOB_ID,                     P_ORG_ID,
                    P_PERIOD_NAME,
                    P_GL_DATE,                    P_GL_NUM,
                    V_VAT_GUBUN,                  NVL(V_TAX_INVOICE_TYPE, 'N'),
                    P_SLIP_TYPE,                  V_ISSUE_DATE,
                    P_ACCOUNT_CONTROL_ID,         P_ACCOUNT_CODE,
                    V_GL_AMOUNT,                  V_VAT_AMOUNT,
                    V_VAT_SLIP_COUNT,             '0',
                    P_CUSTOMER_ID,                V_RESIDENT_REG_NUM,
                    V_TAX_CODE,                   V_CONSIGNEE_ID,
                    V_VAT_TYPE_ID,                P_VOUCH_CODE,
                    V_VAT_REASON_CODE,            V_CREDITCARD_CODE,
                    V_CASH_RECEIPT);
        END IF;
      END;

    -- 전표 삭제.
    ELSE
      BEGIN
        DELETE FROM  FI_VAT_MASTER
        WHERE SLIP_LINE_ID       = P_SLIP_LINE_ID
          AND SOB_ID             = P_SOB_ID ;

      EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10176', NULL) || '(' || SQLERRM || ')');
      END;

    END IF;

END FI_VAT_SUM_P; 
/
