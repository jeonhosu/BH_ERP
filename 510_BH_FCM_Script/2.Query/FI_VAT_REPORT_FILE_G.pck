CREATE OR REPLACE PACKAGE FI_VAT_REPORT_FILE_G
AS
            
-- VAT �ΰ��� ���ڽŰ� ���� ���� ��ȸ.
  PROCEDURE SELECT_REPORT_FILE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_DECLARATION.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_DECLARATION.SOB_ID%TYPE
            , W_ORG_ID            IN FI_VAT_DECLARATION.ORG_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_DECLARATION.ISSUE_DATE_FR%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_DECLARATION.ISSUE_DATE_TO%TYPE
            , P_WRITE_DATE        IN FI_VAT_DECLARATION.WRITE_DATE%TYPE
            , P_MANAGEMENT_NUM    IN VARCHAR2
            , P_TAX_PAYER_TYPE    IN VARCHAR2
            , P_TAX_REFUND_TYPE   IN VARCHAR2
            , P_USER_ID           IN FI_VAT_DECLARATION.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            );

-- VAT �ΰ��� ���ڽŰ� ���� ����.
  PROCEDURE SET_REPORT_FILE
            ( W_TAX_CODE          IN FI_VAT_DECLARATION.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_DECLARATION.SOB_ID%TYPE
            , W_ORG_ID            IN FI_VAT_DECLARATION.ORG_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_DECLARATION.ISSUE_DATE_FR%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_DECLARATION.ISSUE_DATE_TO%TYPE
            , P_WRITE_DATE        IN FI_VAT_DECLARATION.WRITE_DATE%TYPE
            , P_MANAGEMENT_NUM    IN VARCHAR2
            , P_TAX_PAYER_TYPE    IN VARCHAR2
            , P_TAX_REFUND_TYPE   IN VARCHAR2
            , P_USER_ID           IN FI_VAT_DECLARATION.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            );
            
END FI_VAT_REPORT_FILE_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_REPORT_FILE_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_VAT_REPORT_FILE_G
/* Description  : �ΰ��� �Ű� - �������ϻ���.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- VAT �ΰ��� ���ڽŰ� ���� ���� ��ȸ.
  PROCEDURE SELECT_REPORT_FILE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_DECLARATION.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_DECLARATION.SOB_ID%TYPE
            , W_ORG_ID            IN FI_VAT_DECLARATION.ORG_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_DECLARATION.ISSUE_DATE_FR%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_DECLARATION.ISSUE_DATE_TO%TYPE
            , P_WRITE_DATE        IN FI_VAT_DECLARATION.WRITE_DATE%TYPE
            , P_MANAGEMENT_NUM    IN VARCHAR2
            , P_TAX_PAYER_TYPE    IN VARCHAR2
            , P_TAX_REFUND_TYPE   IN VARCHAR2
            , P_USER_ID           IN FI_VAT_DECLARATION.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
  BEGIN
    DELETE FROM FI_VAT_REPORT_FILE_GT VRF
    WHERE VRF.SOB_ID            = W_SOB_ID;
    
    -- �������� ���� --
    SET_REPORT_FILE
      ( W_TAX_CODE
      , W_SOB_ID
      , W_ORG_ID
      , W_ISSUE_DATE_FR
      , W_ISSUE_DATE_TO
      , P_WRITE_DATE
      , P_MANAGEMENT_NUM
      , P_TAX_PAYER_TYPE
      , P_TAX_REFUND_TYPE
      , P_USER_ID
      , O_MESSAGE
      );
  
    OPEN P_CURSOR FOR
      SELECT VRF.REPORT_FILE
        FROM FI_VAT_REPORT_FILE_GT VRF
      WHERE VRF.SOB_ID            = W_SOB_ID
      ORDER BY VRF.SEQ_NUM
      ;
  END SELECT_REPORT_FILE;
  
-- VAT �ΰ��� ���ڽŰ� ���� ����.
  PROCEDURE SET_REPORT_FILE
            ( W_TAX_CODE          IN FI_VAT_DECLARATION.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_DECLARATION.SOB_ID%TYPE
            , W_ORG_ID            IN FI_VAT_DECLARATION.ORG_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_DECLARATION.ISSUE_DATE_FR%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_DECLARATION.ISSUE_DATE_TO%TYPE
            , P_WRITE_DATE        IN FI_VAT_DECLARATION.WRITE_DATE%TYPE
            , P_MANAGEMENT_NUM    IN VARCHAR2
            , P_TAX_PAYER_TYPE    IN VARCHAR2
            , P_TAX_REFUND_TYPE   IN VARCHAR2
            , P_USER_ID           IN FI_VAT_DECLARATION.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SEQ_NUM                     NUMBER := 0;
    V_SOURCE_FILE                 VARCHAR2(150);
    V_REPORT_FILE                 VARCHAR2(3000);
    V_RECORD_COUNT                NUMBER := 0;
    V_VAT_PERIOD                  VARCHAR2(10);  -- 1.�����Ⱓ.
    V_BUSINESS_TYPE               VARCHAR2(50);  -- ����.
    V_BUSINESS_ITEM               VARCHAR2(50);  -- ����.
    
    V_TS_BUSINESS_TYPE            VARCHAR2(50);  -- ����ǥ�� ����.
    V_TS_BUSINESS_ITEM            VARCHAR2(50);  -- ����ǥ�� ����.
    V_TS_BUSINESS_ITEM_CODE       FI_VAT_TAX_STANDARD.BUSINESS_ITEM_CODE%TYPE;  -- ����ǥ�� �����ڵ�.
    
    V_TAX_IMPORT_AMT              NUMBER;  -- 2.30.�������Աݾ��հ�.
    V_EXC_TAX_IMPORT_AMT          NUMBER;  -- 2.29.�������Աݾ����ܱݾ� 
    V_BANK_CODE                   FI_BUSINESS_MASTER.BANK_CODE%TYPE;  -- 80.�����ڵ�.
    V_BANK_ACCOUNT_NUM            VARCHAR2(50);  -- 81.���¹�ȣ.
    V_BANK_SITE_NAME              VARCHAR2(30);  -- 83.����������.
  BEGIN
    -- �����ڵ�.
    BEGIN
      SELECT VTS.BUSINESS_TYPE
           , VTS.BUSINESS_ITEM
           , VTS.BUSINESS_ITEM_CODE
        INTO V_TS_BUSINESS_TYPE
           , V_TS_BUSINESS_ITEM
           , V_TS_BUSINESS_ITEM_CODE
        FROM FI_VAT_TAX_STANDARD VTS
      WHERE VTS.SOB_ID           = W_SOB_ID
        AND VTS.TAX_STANDARD_CODE = '26'
        AND ROWNUM               <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_TS_BUSINESS_ITEM_CODE := '321000';
    END;
    
    -- 1. �ΰ��� �Ű� HEADER ���ڵ�.
    V_SEQ_NUM := 10;
    V_SOURCE_FILE := 'MASTER';
    -- 1.7 �����Ⱓ_���(��).
    IF TO_CHAR(W_ISSUE_DATE_FR, 'MM') >= '01' AND TO_CHAR(W_ISSUE_DATE_FR, 'MM') <= '06' AND 
       TO_CHAR(W_ISSUE_DATE_TO, 'MM') >= '01' AND TO_CHAR(W_ISSUE_DATE_TO, 'MM') <= '06' THEN
     V_VAT_PERIOD := TO_CHAR(W_ISSUE_DATE_FR, 'YYYY') || '01';
    ELSE 
      V_VAT_PERIOD := TO_CHAR(W_ISSUE_DATE_FR, 'YYYY') || '02';
    END IF;
    FOR C1 IN ( SELECT RPAD('11', 2, ' ') ||  -- �ڷᱸ��(11-�Ϲ�, 12-����)
                       RPAD('V101', 4, ' ') ||   -- �����ڵ�(V101-�Ϲݻ����, V102-���̻����)
                       RPAD(REPLACE(NVL(BM.VAT_NUM, ' '), '-', ''), 13, ' ') ||
                       RPAD('41', 2, ' ') ||     -- ���񱸺�(41-�ΰ���ġ��).
                       RPAD(CASE 
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '07', '08', '09') THEN '3'  -- �����Ű�.
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '05', '06', '10', '11', '12') THEN '1'  -- Ȯ���Ű�.
                             END, 1, ' ') ||
                       RPAD('8', 1, ' ') ||  -- �����ڱ���(1-����, 8-����)
                       REPLACE(V_VAT_PERIOD, 6, ' ') ||    -- �����Ⱓ.
                       LPAD(CASE 
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '07') THEN '1'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('02', '08') THEN '2'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('03', '09') THEN '3'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '10') THEN '4'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('05', '11') THEN '5'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('06', '12') THEN '6'
                             END, 4, '0') ||    -- �Ű�����.
                       LPAD('1', 4, '0') ||    -- ������ȣ.
                       RPAD(NVL(CM.HOMETAX_ID, ' '), 20, ' ') ||    -- Ȩ�ؽ�ID.
                       RPAD(REPLACE(NVL(CM.LEGAL_NUM, ' '), '-', ''), 13, ' ') ||    -- �����ڹ�ȣ : ����(�ֹ�)��Ϲ�ȣ.
                       RPAD(' ', 30, ' ') ||    -- �����븮�μ���.
                       RPAD(' ', 6, ' ') ||     -- �����븮�ΰ�����ȣ.
                       RPAD(' ', 4, ' ') ||     -- �����븮����ȭ��ȣ1.
                       RPAD(' ', 5, ' ') ||     -- �����븮����ȭ��ȣ2.
                       RPAD(' ', 5, ' ') ||     -- �����븮����ȭ��ȣ3.
                       RPAD(NVL(CM.CORPORATE_NAME, ' '), 30, ' ') ||     -- ��ȣ.
                       RPAD(NVL(BM.PRESIDENT_NAME, ' '), 30, ' ') ||     -- ��ǥ�ڸ�.
                       RPAD(NVL(BM.ADDR1, ' ') || ' ' || NVL(BM.ADDR2, ' '), 70, ' ') ||     -- ������.
                       RPAD(NVL(BM.TEL_NUM, ' '), 14, ' ')||     -- ��ȭ��ȣ.
                       RPAD(NVL(BM.ADDR1, ' ') || ' ' || NVL(BM.ADDR2, ' '), 70, ' ') ||     -- ������.
                       RPAD(NVL(BM.TEL_NUM, ' '), 14, ' ') ||     -- ��ȭ��ȣ.
                       RPAD(NVL(BM.BUSINESS_TYPE, ' '), 30, ' ') ||     -- ����.
                       RPAD(NVL(BM.BUSINESS_ITEM, ' '), 50, ' ') ||     -- ����.
                       RPAD(V_TS_BUSINESS_ITEM_CODE, 7, ' ') ||    -- �����ڵ�.
                       RPAD(TO_CHAR(W_ISSUE_DATE_FR, 'YYYYMMDD'), 8, ' ') ||    -- �����Ⱓ(������).
                       RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMMDD'), 8, ' ') ||    -- �����Ⱓ(������).
                       RPAD(TO_CHAR(P_WRITE_DATE, 'YYYYMMDD'), 8, ' ') ||    -- �ۼ�����.
                       RPAD('20000101', 8, ' ') ||    -- ���������.
                       RPAD('N', 1, ' ') ||    -- �����Ű���.
                       RPAD(' ', 14, ' ') ||    -- ������޴���ȭ.
                       RPAD('9000', 4, ' ') ||    -- �������α׷��ڵ�(��Ÿ : 9000).
                       RPAD(' ', 10, ' ') ||    -- �����븮�λ���ڹ�ȣ.
                       RPAD(NVL(BM.EMAIL, ' '), 50, ' ') ||    -- �̸����ּ�.
                       RPAD('100', 3, ' ') ||     -- �Ű���������.
                       RPAD(' ', 51, ' ') AS RECORD_FILE
                     , BM.BUSINESS_TYPE
                     , BM.BUSINESS_ITEM
                     , BM.BANK_CODE
                     , BA.BANK_ACCOUNT_NUM
                     , FB.BANK_NAME AS BANK_SITE_NAME
                  FROM FI_VAT_DECLARATION VD
                    , FI_BUSINESS_MASTER BM 
                    , FI_CORPORATE_MASTER CM
                    , FI_BANK_ACCOUNT BA
                    , FI_BANK FB
                WHERE VD.TAX_CODE                 = BM.BUSINESS_CODE
                  AND VD.SOB_ID                   = BM.SOB_ID
                  AND BM.CORPORATE_ID             = CM.CORPORATE_ID
                  AND BM.SOB_ID                   = CM.SOB_ID
                  AND BM.BANK_ACCOUNT_CODE        = BA.BANK_ACCOUNT_CODE(+)
                  AND BM.SOB_ID                   = BA.SOB_ID(+)
                  AND BA.BANK_ID                  = FB.BANK_ID(+)
                  AND BA.SOB_ID                   = FB.SOB_ID(+)
                  AND VD.TAX_CODE                 = W_TAX_CODE
                  AND VD.SOB_ID                   = W_SOB_ID
                  AND VD.ISSUE_DATE_FR            = W_ISSUE_DATE_FR
                  AND VD.ISSUE_DATE_TO            = W_ISSUE_DATE_TO
                )
    LOOP
      DBMS_OUTPUT.PUT_LINE(C1.RECORD_FILE);
      INSERT INTO FI_VAT_REPORT_FILE_GT
      ( SEQ_NUM
      , SOURCE_FILE
      , SOB_ID
      , REPORT_FILE
      ) VALUES
      ( V_SEQ_NUM
      , V_SOURCE_FILE
      , W_SOB_ID
      , C1.RECORD_FILE
      );
      V_BUSINESS_TYPE := C1.BUSINESS_TYPE;
      V_BUSINESS_ITEM := C1.BUSINESS_ITEM;
      V_BANK_CODE := C1.BANK_CODE;
      V_BANK_ACCOUNT_NUM := C1.BANK_ACCOUNT_NUM;
      V_BANK_SITE_NAME := C1.BANK_SITE_NAME;
    END LOOP C1;
    -- 2. �Ű� ���ڵ�.
    -- 2.30 �������Աݾ��հ�.
    BEGIN
      SELECT SUM(TS.TAX_AMOUNT) AS TAX_AMOUNT
        INTO V_TAX_IMPORT_AMT
        FROM FI_VAT_TAX_STANDARD TS
      WHERE TS.SOB_ID                   = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_TAX_IMPORT_AMT := 0;
    END;
    -- 2.29 �������Աݾ��հ�.
    BEGIN
      SELECT TS.TAX_AMOUNT 
        INTO V_EXC_TAX_IMPORT_AMT
        FROM FI_VAT_TAX_STANDARD TS
      WHERE TS.TAX_STANDARD_CODE        = '29'
        AND TS.SOB_ID                   = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_EXC_TAX_IMPORT_AMT := 0;
    END;
    V_SEQ_NUM := 11;
    V_SOURCE_FILE := 'DECLARATION';
    FOR C1 IN ( SELECT RPAD('17', 2, ' ') || -- �ڷᱸ�� : 17.
                       RPAD('V101', 4, ' ') ||  -- �����ڵ� : �ΰ���ġ �Ϲݼ���
                       LPAD(REPLACE(LPAD(NVL(VD.S_TAX_INVOICE_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 3.��ǥ�Ű�������ݰ�꼭�ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VD.S_TAX_INVOICE_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 4.����
                       LPAD(REPLACE(LPAD(NVL(VD.S_TAX_ETC_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 5.��ǥ�Ű������Ÿ�ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VD.S_TAX_ETC_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 6.����.
                       LPAD(REPLACE(LPAD(NVL(VD.S_ZERO_INVOICE_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 7.��ǥ�Ű������ݰ�꼭.
                       LPAD(REPLACE(LPAD(NVL(VD.S_ZERO_ETC_AMT, 0), 13, '0'), '-', ''), 13, '-') ||  -- 8.��ǥ�Ű�����Ÿ.
                       LPAD(REPLACE(LPAD(NVL(VDA.SS_TAX_INVOICE_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 9.��ǥ�����������ݰ�꼭�ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.SS_TAX_INVOICE_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 10.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.SS_TAX_ETC_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 11.��ǥ����������Ÿ�ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.SS_TAX_ETC_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 12.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.SS_ZERO_INVOICE_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 13.��ǥ���������������ݰ�꼭�ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.SS_ZERO_ETC_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 14. ��ǥ��������������Ÿ�ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VD.S_BAD_DEBT_TAX_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 15.��ռ��װ�������.
                       LPAD(REPLACE(LPAD(NVL(VD.P_TAX_INVOICE_AMT, 0), 15, '0'), '-', ''), 15, '-') ||  -- 16.���Ա����Ϲݸ���.
                       LPAD(REPLACE(LPAD(NVL(VD.P_TAX_INVOICE_VAT, 0), 13, '0'), '-', ''), 13, '-') ||  -- 17.����.
                       LPAD(REPLACE(LPAD(NVL(VD.P_TAX_ASSET_AMT, 0), 13, '0'), '-', ''), 13, '-') ||  -- 18.���Ա��ΰ����ڻ����.
                       LPAD(REPLACE(LPAD(NVL(VD.P_TAX_ASSET_VAT, 0), 13, '0'), '-', ''), 13, '-') ||  -- 19.���Ա��ΰ����ڻ����.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_CREDIT_AMT, 0), 13, '0'), '-', ''), 13, '-') ||  -- 20.���Ա����ſ�ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_CREDIT_VAT, 0), 13, '0'), '-', ''), 13, '-') ||  -- 21.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_DEEMED_IP_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 22.�������Աݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_DEEMED_IP_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 23.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_RECYCLE_IP_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 24.������Ȱ��.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_RECYCLE_IP_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 25.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_STOCK_IP_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 26.�����Լ���.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_BAD_TAX_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 27.��պ�������.
                       LPAD(REPLACE(LPAD(NVL(VD.PURCHASE_SUM_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 28.���Աݾ��հ�.
                       LPAD(REPLACE(LPAD(NVL(VD.PURCHASE_SUM_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 29.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.N_COMMON_IP_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 30.������Ը鼼����ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.N_COMMON_IP_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 31.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.N_NOT_DED_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 32.�Ұ������Աݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.N_NOT_DED_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 33.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.N_BAD_RECEIVE_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 34.���ó�м���.
                       LPAD(REPLACE(LPAD(NVL(VD.PURCHASE_SUM_AMT, 0) - NVL(VD.P_NOT_DED_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 35.�������Աݾ�.
                       LPAD(REPLACE(LPAD(NVL(VD.PURCHASE_SUM_VAT, 0) - NVL(VD.P_NOT_DED_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 36.����.
                       LPAD(REPLACE(LPAD(NVL(VD.CALCULATE_TAX_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 37.����(ȯ��)����.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_VAT_NUM_UNENROLL_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 38.����ڵ�ϰ���ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_VAT_NUM_UNENROLL_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 39.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_TAX_INV_SUM_BAD_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 40.���ݰ�꼭�հ�ǥ����ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_TAX_INV_SUM_BAD_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 41.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_REPORT_BAD_AMT, 0), 13, '0'), '-', ''), 13, '-') ||  -- 42.�Ű�Ҽ��ǰ���ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_REPORT_BAD_VAT, 0), 13, '0'), '-', ''), 13, '-') ||  -- 43.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_ZERO_REPORT_BAD_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 44.�������Ű���ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_ZERO_REPORT_BAD_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 45.����.
                       LPAD(REPLACE(LPAD(NVL(VD.R_CREDIT_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 46.�����ſ�����ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VD.R_CREDIT_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 47.����.
                       LPAD(REPLACE(LPAD(NVL(VD.SCHEDULE_NOTICE_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 48.������������.
                       LPAD(REPLACE(LPAD(NVL(VD.SCHEDULE_YET_REFUND_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 49.������ȯ�޼���.
                       LPAD(REPLACE(LPAD(NVL(V_TAX_IMPORT_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 50.�������Աݾ��հ�.
                       LPAD(REPLACE(LPAD(NVL(V_EXC_TAX_IMPORT_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 51.�������Աݾ����ܱݾ�.
                       LPAD(REPLACE(LPAD(NVL(0, 0), 15, '0'), '-', ''), 15, '-') || -- 52.�鼼���Աݾ��հ�.
                       RPAD(CASE
                              WHEN NVL(VD.BALANCE_TAX_VAT, 0) >= 0 THEN ' '
                              WHEN P_TAX_REFUND_TYPE = 0 THEN
                                CASE 
                                  WHEN NVL(VD.S_ZERO_INVOICE_AMT, 0) + NVL(VD.S_ZERO_INVOICE_VAT, 0) > 0 THEN '2'
                                  WHEN NVL(VD.P_TAX_ASSET_AMT, 0) + NVL(VD.P_TAX_ASSET_VAT, 0)
                                       + NVL(VDA.E_CREDIT_ASSET_AMT, 0) + NVL(VDA.E_CREDIT_ASSET_VAT, 0) > 0 THEN '3'
                                  ELSE '1'
                                END
                              ELSE P_TAX_REFUND_TYPE
                            END, 1, ' ') ||  -- 53.ȯ�ޱ��� : (-)�� ��츸 �ۼ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.R_TAXI_TRANSPORT_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 54.�ýû���ںΰ���ġ���氨.
                       LPAD(REPLACE(LPAD(NVL(VD.S_SCHEDULE_OMIT_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 55.��ǥ�����Ű����а���.
                       LPAD(REPLACE(LPAD(NVL(VD.S_SCHEDULE_OMIT_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 56.����.
                       LPAD(REPLACE(LPAD(NVL(VD.S_BAD_DEBT_TAX_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 57.��ռ��װ����ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VD.P_ETC_DED_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 58.���Լ��ױ�Ÿ����-14
                       LPAD(REPLACE(LPAD(NVL(VD.P_ETC_DED_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 59.����.
                       LPAD(REPLACE(LPAD(NVL(VD.P_NOT_DED_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 60.���԰����������ұݾ�.
                       LPAD(REPLACE(LPAD(NVL(VD.P_NOT_DED_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 61.����.
                       LPAD(REPLACE(LPAD(NVL(VD.TAX_ADDITION_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 62.���꼼��.
                       LPAD(REPLACE(LPAD(NVL(VDA.S_SALES_SUM_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 63.��ǥ�����Ű����бݾ��հ� 
                       LPAD(REPLACE(LPAD(NVL(VDA.S_SALES_SUM_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 64.����
                       LPAD(REPLACE(LPAD(NVL(VDA.ETC_DED_IP_SUM_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 65.��Ÿ�������Աݾ��հ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.ETC_DED_IP_SUM_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 66.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.N_BAD_RECEIVE_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 67.���ó�бݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.NOT_DED_SUM_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 68.���԰����������ұݾ� �հ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.NOT_DED_SUM_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 69.����
                       LPAD(REPLACE(LPAD(NVL(VDA.TAX_ADDITION_SUM_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 70.���꼼�Ծ�.
                       LPAD(REPLACE(LPAD(NVL(VD.R_ETC_DED_VAT, 0) + NVL(VD.R_CREDIT_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 71. �氨���װ�.
                       LPAD(0, 13, '0') || -- 72.���ǽŰ����ڰ氨����.
                       LPAD(0, 13, '0') || -- 73. POS ���� ����ڵ ���� �氨����.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_PAYMENT_BAD_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 74.���κҼ��ǰ���ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_PAYMENT_BAD_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 75.����.
                       LPAD(0, 15, '0') || -- 76.�Ϲݰ�����ȯ�� ��������.
                       LPAD(REPLACE(LPAD(NVL(VD.R_ETC_DED_VAT, 0), 15, '0'), '-', ''), 15, '-') || -- 77.��Ÿ���� �氨����.
                       LPAD(REPLACE(LPAD(NVL(VD.SALES_SUM_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 78.����ǥ��.
                       LPAD(REPLACE(LPAD(NVL(VD.BALANCE_TAX_VAT, 0), 15, '0'), '-', ''), 15, '-') || -- 79.���������Ҽ���.
                       RPAD('0' || NVL(V_BANK_CODE, ' '), 3, ' ') || -- 80.�����ڵ��.
                       RPAD(REPLACE(NVL(V_BANK_ACCOUNT_NUM, ' '), '-', ''), 20, ' ') || -- 81.���¹�ȣ.
                       RPAD(' ', 7, ' ') || -- 82.�Ѱ����ν��ι�ȣ 
                       RPAD(NVL(V_BANK_SITE_NAME, ' '), 30, ' ') || -- 83.����������.
                       LPAD(REPLACE(LPAD(NVL(VD.SALES_SUM_VAT, 0), 15, '0'), '-', ''), 15, '-') || -- 84.���⼼��.
                       RPAD(' ', 8, ' ') || -- 85.�������.
                       RPAD(' ', 3, ' ') || -- 86.�������.
                       RPAD('N', 1, ' ') || -- 87.������(����ǥ��) ����.
                       LPAD(REPLACE(LPAD(NVL(VDA.BILL_ISSUE_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 88.��꼭���αݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.BILL_RECEIPT_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 89.��꼭����ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VD.P_SCHEDULE_OMIT_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 90.���Կ����Ű����ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VD.P_SCHEDULE_OMIT_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 91.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.SP_TAX_INVOICE_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 92.�������Լ��ױݻ꼭�����ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.SP_TAX_INVOICE_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 93.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.SP_ETC_DED_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 94.�������Ա�Ÿ�����������ױݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.SP_ETC_DED_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 95.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.S_PURCHASE_SUM_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 96.�������Դ����հ�ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.S_PURCHASE_SUM_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 97.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.R_ETC_DED_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 98.��Ÿ�氨�������׸���Ÿ����.
                       LPAD(REPLACE(LPAD(NVL(VDA.R_ETAX_REPORT_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 99.���ڽŰ��������.
                       LPAD(REPLACE(LPAD(NVL(VDA.R_CASH_BILL_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 100.���ݿ���������ڰ�������.
                       LPAD(REPLACE(LPAD(NVL(VD.BALANCE_TAX_VAT, 0), 15, '0'), '-', ''), 15, '-') || -- 101.�����������Ҽ���.
                       RPAD(CASE
                              WHEN P_TAX_PAYER_TYPE = '1' THEN '0'
                              ELSE P_TAX_PAYER_TYPE
                            END, 1, ' ') || -- 102.�Ϲݰ����ڱ���.
                       RPAD('0', 1, ' ') || -- 103.����ȯ����ұ���.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_TAX_BUSINESS_IP_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 104.�����������ȯ���Լ���.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_CASH_SALES_UNREPORT_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 105.���ݸ�����������Ⱑ��ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_CASH_SALES_UNREPORT_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 106.����.
                       LPAD(REPLACE(LPAD(NVL(VD.S_TAX_BUYER_INVOICE_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 107.��ǥ�Ű���������ڹ���ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VD.S_TAX_BUYER_INVOICE_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 108.��ǥ�Ű���������ڹ��༼��.
                       LPAD(REPLACE(LPAD(NVL(VD.P_BUYER_INVOICE_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 109.���Ը����ڹ���ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VD.P_BUYER_INVOICE_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 110.���Ը����ڹ��༼��.
                       LPAD(REPLACE(LPAD(NVL(VD.GOLD_BAR_BUYER_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 111.�����ݸ����ڳ���Ư�ʱⳳ�μ���.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_GOLD_BAR_IP_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 112.���԰���������Աݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_GOLD_BAR_IP_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 113.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_TAX_INVOICE_UNISSUE_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 114.���ݰ�꼭�̹߱޵��ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_TAX_INVOICE_UNISSUE_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 115.���ݰ�꼭�̹߱޵�꼼��.
                       LPAD(REPLACE(LPAD(NVL(VD.S_TAX_CREDIT_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 116.��ǥ�Ű�ſ�ī�����ݿ������ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VD.S_TAX_CREDIT_VAT, 0), 15, '0'), '-', ''), 15, '-') || -- 117.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_CREDIT_ASSET_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 118.���Խſ�����ڻ�ݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_CREDIT_ASSET_VAT, 0), 15, '0'), '-', ''), 15, '-') || -- 119.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.R_ETAX_ISSUE_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 120.���ڼ��ݰ�꼭���μ��װ�������.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_ETAX_UNSEND_IN_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 121.���ڼ��ݰ�꼭�����۰���ݾ�_�����Ⱓ��.                                              
                       LPAD(REPLACE(LPAD(NVL(VDA.A_ETAX_UNSEND_IN_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 122.����.
                       LPAD(0, 13, '0') || -- 123.�鼼���Աݾ����ܱݾ�.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_ETAX_UNSEND_OVER_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 124.���ڼ��ݰ�꼭�����۰���ݾ�_�����Ⱓ��.                                              
                       LPAD(REPLACE(LPAD(NVL(VDA.A_ETAX_UNSEND_OVER_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 125.����.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_TAX_INVOICE_DELAY_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 126.���ڼ��ݰ�꼭�����߱޵���.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_TAX_INVOICE_DELAY_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 127.����.
                       RPAD(' ', 88, ' ') AS RECORD_FILE                       
                  FROM FI_VAT_DECLARATION VD
                    , FI_VAT_DECLARATION_ATTACH VDA
                WHERE VD.DECLARATION_ID     = VDA.DECLARATION_ID
                  AND VD.TAX_CODE           = W_TAX_CODE
                  AND VD.SOB_ID             = W_SOB_ID
                  AND VD.ISSUE_DATE_FR      = W_ISSUE_DATE_FR
                  AND VD.ISSUE_DATE_TO      = W_ISSUE_DATE_TO
                )
    LOOP
      DBMS_OUTPUT.PUT_LINE(C1.RECORD_FILE);
      INSERT INTO FI_VAT_REPORT_FILE_GT
      ( SEQ_NUM
      , SOURCE_FILE
      , SOB_ID
      , REPORT_FILE
      ) VALUES
      ( V_SEQ_NUM
      , V_SOURCE_FILE
      , W_SOB_ID
      , C1.RECORD_FILE
      );
    END LOOP C1;
    
    -- 4. �ΰ���ġ�����Աݾ׵�(����ǥ�� �鼼���Աݾ�).
    V_SEQ_NUM := 21;
    V_SOURCE_FILE := 'TAX_STANDARD';
    FOR C1 IN ( SELECT RPAD('15', 2, ' ') || -- �ڷᱸ�� : 15-����ΰ���ġ�� ���Աݾ�.
                       RPAD('V101', 4, ' ') || -- �����ڵ�.(V101:�Ϲ�, V102:����)
                       RPAD(CASE
                              WHEN TS.TAX_STANDARD_CODE IN('26', '27', '28') AND NVL(TS.TAX_AMOUNT, 0) > 0 THEN '1'
                              WHEN TS.TAX_STANDARD_CODE IN('29') AND NVL(TS.TAX_AMOUNT, 0) > 0 THEN '2'
                              -- ���� �߰�.
                            END, 1, ' ') || -- ���Աݾ���������.
                       RPAD(NVL(DECODE(TS.TAX_STANDARD_CODE, '29', V_TS_BUSINESS_TYPE, TS.BUSINESS_TYPE), ' '), 30, ' ') || -- ����.
                       RPAD(NVL(DECODE(TS.TAX_STANDARD_CODE, '29', V_TS_BUSINESS_ITEM, TS.BUSINESS_ITEM), ' '), 50, ' ') || -- �����.
                       RPAD(NVL(DECODE(TS.TAX_STANDARD_CODE, '29', V_TS_BUSINESS_ITEM_CODE, TS.BUSINESS_ITEM_CODE), ' '), 7, ' ') || --�����ڵ�.
                       LPAD(REPLACE(LPAD(NVL(TS.TAX_AMOUNT, 0), 15, '0'), '-', ''), 15, '-') || -- ���Աݾ�.
                       RPAD(' ', 41, ' ') AS RECORD_FILE
                  FROM FI_VAT_TAX_STANDARD TS
                WHERE TS.SOB_ID             = W_SOB_ID
               )
    LOOP
      DBMS_OUTPUT.PUT_LINE(C1.RECORD_FILE);
      INSERT INTO FI_VAT_REPORT_FILE_GT
      ( SEQ_NUM
      , SOURCE_FILE
      , SOB_ID
      , REPORT_FILE
      ) VALUES
      ( V_SEQ_NUM
      , V_SOURCE_FILE
      , W_SOB_ID
      , C1.RECORD_FILE
      );
    END LOOP C1;
----> ÷�μ��� ���� <----    
    -- 7. �ε����Ӵ���ް��׸���.
    V_SEQ_NUM := 31;
    V_SOURCE_FILE := 'REALTY';
    FOR C1 IN ( SELECT RPAD('17', 2, ' ') || -- �ڷᱸ��(17).
                       RPAD('V120', 4, ' ') || -- �����ڵ�.
                       LPAD(ROWNUM, 6, '0') || -- �Ϸù�ȣ.
                       RPAD(NVL(BM.ADDR1, ' ') || ' ' || NVL(BM.ADDR2, ' '), 70, ' ') || -- ������.
                       LPAD(REPLACE(LPAD(NVL(SX1.DEPOSIT_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- �Ӵ��೻�뺸�����հ�.
                       LPAD(REPLACE(LPAD(NVL(SX1.MONTHLY_RENT_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- �Ӵ��೻��������հ�.
                       LPAD(REPLACE(LPAD(NVL(SX1.LEASE_TOTAL_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- �Ӵ��೻�뺸�����հ�.
                       LPAD(REPLACE(LPAD(NVL(SX1.LEASE_DEPOSIT_INTEREST_AMT, 0), 15, 0), '-', ''), 15, '-') || -- �Ӵ����Ժ����������հ�.
                       LPAD(REPLACE(LPAD(NVL(SX1.LEASE_MONTHLY_RENT_AMT, 0), 15, 0), '-', ''), 15, '-') || -- �Ӵ����Կ������հ�.
                       RPAD(REPLACE(NVL(BM.VAT_NUM, ' '), '-', ''), 10, ' ') || -- �Ӵ��λ���ڵ�Ϲ�ȣ.
                       LPAD(NVL(SX1.LEASE_COUNT, 0), 6, '0') || -- �Ӵ�Ǽ�.
                       LPAD('0', 4, '0') || -- ��������Ϸù�ȣ.
                       RPAD(' ', 73, ' ') AS RECORD_FILE 
                     , ROWNUM AS ROW_SEQ      
                  FROM FI_BUSINESS_MASTER BM 
                    , ( SELECT RLH.TAX_CODE
                             , RLH.SOB_ID
                             , SUM(NVL(RL.DEPOSIT_AMOUNT, 0)) AS DEPOSIT_AMT
                             , SUM(NVL(RL.MONTHLY_RENT_AMOUNT, 0)) AS MONTHLY_RENT_AMT
                             , SUM(NVL(RLH.DEPOSIT_INTEREST_AMT, 0) + NVL(RLH.MONTHLY_RENT_SUM_AMT, 0)) AS LEASE_TOTAL_AMT
                             , SUM(RLH.DEPOSIT_INTEREST_AMT) AS LEASE_DEPOSIT_INTEREST_AMT
                             , SUM(RLH.MONTHLY_RENT_SUM_AMT) AS LEASE_MONTHLY_RENT_AMT
                             , COUNT(DISTINCT RLH.REALTY_LEASE_ID) AS LEASE_COUNT
                          FROM FI_VAT_REALTY_LEASE_HISTORY RLH
                            , FI_VAT_REALTY_LEASE RL
                            , FI_SUPP_CUST_V SC
                        WHERE RLH.REALTY_LEASE_ID         = RL.REALTY_LEASE_ID
                          AND RLH.SOB_ID                  = RL.SOB_ID
                          AND RL.CUSTOMER_ID              = SC.SUPP_CUST_ID
                          AND RL.ORG_ID                   = SC.ORG_ID
                          AND RL.TAX_CODE                 = W_TAX_CODE
                          AND RL.SOB_ID                   = W_SOB_ID
                          AND RLH.USE_DATE_FR             = W_ISSUE_DATE_FR
                          AND RLH.USE_DATE_TO             = W_ISSUE_DATE_TO
                        GROUP BY RLH.TAX_CODE, RLH.SOB_ID
                       ) SX1
                WHERE BM.BUSINESS_CODE            = SX1.TAX_CODE
                  AND BM.SOB_ID                   = SX1.SOB_ID
                  AND BM.BUSINESS_CODE            = W_TAX_CODE
                  AND BM.SOB_ID                   = W_SOB_ID
               )
    LOOP
      DBMS_OUTPUT.PUT_LINE(C1.RECORD_FILE);
      INSERT INTO FI_VAT_REPORT_FILE_GT
      ( SEQ_NUM
      , SOURCE_FILE
      , SOB_ID
      , REPORT_FILE
      ) VALUES
      ( V_SEQ_NUM
      , V_SOURCE_FILE
      , W_SOB_ID
      , C1.RECORD_FILE
      );
      -- 7.1 �ε����Ӵ���ް��� ���γ���.
      V_SEQ_NUM := V_SEQ_NUM + 0.01;
      V_SOURCE_FILE := 'REALTY';
      FOR R1 IN ( SELECT RPAD('18', 2, ' ') || -- �ڷᱸ��(18)  
                         RPAD('V120', 4, ' ') || -- �����ڵ�.
                         LPAD(C1.ROW_SEQ, 6, '0') || -- ���� �Ϸù�ȣ
                         LPAD(ROWNUM, 6, '0') || -- �Ϸù�ȣ.
                         RPAD(NVL(RL.FLOOR_COUNT, ' '), 10, ' ') || -- ��.
                         RPAD(NVL(RL.ROOM_NO, ' '), 10, ' ') || -- ȣ��.
                         RPAD(NVL(RL.AREA_M2, 0), 10, ' ') || -- ����.
                         RPAD(NVL(SC.SUPP_CUST_NAME, ' '), 30, ' ') || -- ��ȣ.
                         RPAD(REPLACE(NVL(SC.TAX_REG_NO, ' '), '-', ''), 13, ' ') || --�����λ���ڹ�ȣ.
                         RPAD(CASE
                                 WHEN RL.USE_DATE_FR BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO THEN TO_CHAR(RL.USE_DATE_FR, 'YYYYMMDD')
                                 ELSE ' '
                               END, 8, ' ') || -- �Ӵ���������.
                         RPAD(CASE
                                 WHEN RL.USE_DATE_TO BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO THEN TO_CHAR(RL.USE_DATE_TO, 'YYYYMMDD')
                                 ELSE ' '
                               END, 8, ' ') || -- �Ӵ��������.
                         LPAD(REPLACE(LPAD(NVL(RL.DEPOSIT_AMOUNT, 0), 13, '0'), '-', ''), 13, '-') ||-- �Ӵ��೻�뺸����.
                         LPAD(REPLACE(LPAD(NVL(RL.MONTHLY_RENT_AMOUNT, 0), 13, '0'), '-', ''), 13, '-') || -- �Ӵ��೻�����.
                         LPAD(REPLACE(LPAD(NVL(RLH.DEPOSIT_INTEREST_AMT, 0) + NVL(RLH.MONTHLY_RENT_SUM_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- �Ӵ����Աݾװ�.
                         LPAD(REPLACE(LPAD(NVL(RLH.DEPOSIT_INTEREST_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- �Ӵ�Ẹ��������.
                         LPAD(REPLACE(LPAD(NVL(RLH.MONTHLY_RENT_SUM_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- �Ӵ����Աݾ׿��Ӵ��.
                         RPAD(CASE 
                                WHEN RL.FLOOR_TYPE = '10' THEN 'N'
                                ELSE 'Y'
                              END, 1, ' ') || -- ����/����.
                         RPAD('0', 4, '0') || -- ��������Ϸù�ȣ.
                         RPAD(NVL(RL.HOUSE_NUM, ' '), 30, ' ') || -- ��.
                         RPAD(' ', 8, ' ') || -- ������.
                         RPAD(' ', 35, ' ') AS RECORD_FILE                         
                    FROM FI_VAT_REALTY_LEASE_HISTORY RLH
                      , FI_VAT_REALTY_LEASE RL
                      , FI_SUPP_CUST_V SC
                  WHERE RLH.REALTY_LEASE_ID         = RL.REALTY_LEASE_ID
                    AND RLH.SOB_ID                  = RL.SOB_ID
                    AND RL.CUSTOMER_ID              = SC.SUPP_CUST_ID
                    AND RL.ORG_ID                   = SC.ORG_ID
                    AND RL.TAX_CODE                 = W_TAX_CODE
                    AND RL.SOB_ID                   = W_SOB_ID
                    AND RLH.USE_DATE_FR             = W_ISSUE_DATE_FR
                    AND RLH.USE_DATE_TO             = W_ISSUE_DATE_TO
                 )
      LOOP
        DBMS_OUTPUT.PUT_LINE(R1.RECORD_FILE);
        INSERT INTO FI_VAT_REPORT_FILE_GT
        ( SEQ_NUM
        , SOURCE_FILE
        , SOB_ID
        , REPORT_FILE
        ) VALUES
        ( V_SEQ_NUM
        , V_SOURCE_FILE
        , W_SOB_ID
        , R1.RECORD_FILE
        );
      END LOOP R1;      
    END LOOP C1;
    
    -- 11. �ǹ�������ڻ�������.
    V_SEQ_NUM := 41;
    V_SOURCE_FILE := 'ASSET';
    FOR C1 IN ( SELECT RPAD('17', 2, ' ') || -- �ڷᱸ�� : 17-����ΰ���ġ�� ���Աݾ�.
                       RPAD('V149', 4, ' ') || -- �����ڵ�.(V149:�Ϲ�, V102:����)
                       LPAD(NVL(SX1.ASSET_COUNT, 0), 11, '0') || -- �Ǽ��հ�.
                       LPAD(REPLACE(LPAD(NVL(SX1.GL_AMOUNT, 0), 13, '0'), '-', ''), 13, '-') || -- ���ް����հ�.
                       LPAD(REPLACE(LPAD(NVL(SX1.VAT_AMOUNT, 0), 13, '0'), '-', ''), 13, '-') || -- �����հ�.
                       LPAD(NVL(SX1.COUNT_1, 0), 11, '0') || -- �ǹ����๰��.
                       LPAD(REPLACE(LPAD(NVL(SX1.GL_AMOUNT_1, 0), 13, '0'), '-', ''), 13, '-') ||-- �ǹ� ���๰.
                       LPAD(REPLACE(LPAD(NVL(SX1.VAT_AMOUNT_1, 0), 13, '0'), '-', ''), 13, '-') || 
                       LPAD(NVL(SX1.COUNT_2, 0), 11, '0') || -- �����ġ��.
                       LPAD(REPLACE(LPAD(NVL(SX1.GL_AMOUNT_2, 0), 13, '0'), '-', ''), 13, '-') ||-- �����ġ.
                       LPAD(REPLACE(LPAD(NVL(SX1.VAT_AMOUNT_2, 0), 13, '0'), '-', ''), 13, '-') ||
                       LPAD(NVL(SX1.COUNT_3, 0), 11, '0') || -- ������ݱ���.
                       LPAD(REPLACE(LPAD(NVL(SX1.GL_AMOUNT_3, 0), 13, '0'), '-', ''), 13, '-') ||-- ������ݱ�.
                       LPAD(REPLACE(LPAD(NVL(SX1.VAT_AMOUNT_3, 0), 13, '0'), '-', ''), 13, '-') ||
                       LPAD(NVL(SX1.COUNT_4, 0), 11, '0') || -- ��Ÿ��.
                       LPAD(REPLACE(LPAD(NVL(SX1.GL_AMOUNT_4, 0), 13, '0'), '-', ''), 13, '-') ||-- ��Ÿ��.
                       LPAD(REPLACE(LPAD(NVL(SX1.VAT_AMOUNT_4, 0), 13, '0'), '-', ''), 13, '-') ||
                       RPAD(' ', 9, ' ') AS RECORD_FILE
                  FROM ( SELECT COUNT(DA.DPR_ASSET_ID) AS ASSET_COUNT
                             , SUM(DA.GL_AMOUNT) AS GL_AMOUNT
                             , SUM(DA.VAT_AMOUNT) AS VAT_AMOUNT
                             , SUM(DECODE(DA.VAT_ASSET_GB, '1', 1, 0)) AS COUNT_1  -- �ǹ�,���๰ ��.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '1', NVL(DA.GL_AMOUNT, 0), 0)) AS GL_AMOUNT_1  -- �ǹ�,���๰.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '1', NVL(DA.VAT_AMOUNT, 0), 0)) AS VAT_AMOUNT_1  -- �ǹ�,���๰.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '2', 1, 0)) AS COUNT_2  -- �����ġ ��.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '2', NVL(DA.GL_AMOUNT, 0), 0)) AS GL_AMOUNT_2  -- �����ġ
                             , SUM(DECODE(DA.VAT_ASSET_GB, '2', NVL(DA.VAT_AMOUNT, 0), 0)) AS VAT_AMOUNT_2  -- �����ġ.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '3', 1, 0)) AS COUNT_3  -- ������ݱ� ��.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '3', NVL(DA.GL_AMOUNT, 0), 0)) AS GL_AMOUNT_3  -- ������ݱ�.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '3', NVL(DA.VAT_AMOUNT, 0), 0)) AS VAT_AMOUNT_3  -- ������ݱ�.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '4', 1, 0)) AS COUNT_4  -- ��Ÿ.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '4', NVL(DA.GL_AMOUNT, 0), 0)) AS GL_AMOUNT_4  -- ��Ÿ.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '4', NVL(DA.VAT_AMOUNT, 0), 0)) AS VAT_AMOUNT_4  -- ��Ÿ.
                          FROM FI_VAT_DPR_ASSET DA
                        WHERE DA.TAX_CODE           = W_TAX_CODE
                          AND DA.ACQUIRE_DATE       BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                          AND DA.SOB_ID             = W_SOB_ID
                       ) SX1           
               )
    LOOP
      DBMS_OUTPUT.PUT_LINE(C1.RECORD_FILE);
      INSERT INTO FI_VAT_REPORT_FILE_GT
      ( SEQ_NUM
      , SOURCE_FILE
      , SOB_ID
      , REPORT_FILE
      ) VALUES
      ( V_SEQ_NUM
      , V_SOURCE_FILE
      , W_SOB_ID
      , C1.RECORD_FILE
      );
    END LOOP C1;
    -- 12. �����������Ҹ��Լ��׸���.
    V_SEQ_NUM := 51;
    V_SOURCE_FILE := 'NOT_TAX_DED';
    FOR C1 IN ( SELECT RPAD('17', 2, ' ') || -- �ڷᱸ�� 
                       RPAD('V153', 4, ' ') || -- �����ڵ�.(V149:�Ϲ�, V102:����)
                       LPAD(NVL(SX1.BILL_COUNT, 0), 11, '0') || -- �Ǽ��հ�.
                       LPAD(REPLACE(LPAD(NVL(SX1.GL_AMOUNT, 0), 15, '0'), '-', ''), 15, '-') || -- ���ް����հ�.
                       LPAD(REPLACE(LPAD(NVL(SX1.VAT_AMOUNT, 0), 15, '0'), '-', ''), 15, '-') || -- �����հ�.
                       LPAD(0, 15, '0') || -- 6.������԰��ް����հ�.
                       LPAD(0, 15, '0') || -- 7.
                       LPAD(0, 15, '0') || -- 8.
                       LPAD(0, 15, '0') || -- 9.
                       LPAD(0, 15, '0') || -- 10.
                       LPAD(0, 15, '0') || -- 11.
                       LPAD(0, 15, '0') || -- 12.
                       RPAD(' ', 48, ' ') AS RECORD_FILE
                  FROM (-- ���Լ��׺Ұ�������.
                        SELECT SUM(VM.VAT_COUNT) AS BILL_COUNT
                             , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                             , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
                          FROM FI_VAT_MASTER VM
                        WHERE VM.TAX_CODE           = W_TAX_CODE
                          AND VM.VAT_GUBUN          = '1'
                          AND VM.VAT_ISSUE_DATE     BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                          AND VM.VAT_TYPE           IN('8', '15')    -- ���Լ��׺Ұ���.
                          AND VM.SOB_ID             = W_SOB_ID
                       ) SX1                       
               )
    LOOP
      DBMS_OUTPUT.PUT_LINE(C1.RECORD_FILE);
      INSERT INTO FI_VAT_REPORT_FILE_GT
      ( SEQ_NUM
      , SOURCE_FILE
      , SOB_ID
      , REPORT_FILE
      ) VALUES
      ( V_SEQ_NUM
      , V_SOURCE_FILE
      , W_SOB_ID
      , C1.RECORD_FILE
      );
      -- 12.1 �����������Ҹ��Լ��׸���.
      V_SEQ_NUM := V_SEQ_NUM + 0.01;
      V_SOURCE_FILE := 'NOT_TAX_DED';
      FOR R1 IN ( SELECT RPAD('18', 2, ' ') || -- �ڷᱸ��(18)  
                         RPAD('V153', 4, ' ') || -- �����ڵ�.
                         RPAD(NVL(SX1.DED_NOT_CODE, ' '), 2, ' ') || -- �Ұ�����������.
                         LPAD(NVL(SX1.VAT_COUNT, 0), 11, '0') || -- �ż�.
                         LPAD(REPLACE(LPAD(NVL(SX1.GL_AMOUNT, 0), 13, '0'), '-', ''), 13, '-') || -- ���ް���.
                         LPAD(REPLACE(LPAD(NVL(SX1.VAT_AMOUNT, 0), 13, '0'), '-', ''), 13, '-') || -- ���ݰ�꼭.
                         RPAD(' ', 55, ' ') AS RECORD_FILE                         
                    FROM ( SELECT VM.SOB_ID
                                , SUBSTR(VM.INPUT_DED_NOT_CODE, 2, 2) AS DED_NOT_CODE
                                , SUM(VM.VAT_COUNT) AS VAT_COUNT
                                , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                                , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
                              FROM FI_VAT_MASTER VM
                             WHERE VM.TAX_CODE           = W_TAX_CODE
                               AND VM.VAT_GUBUN          = '1'
                               AND VM.VAT_ISSUE_DATE     BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                               AND VM.VAT_TYPE           IN('8', '15')    -- ���Լ��׺Ұ���.
                               AND VM.SOB_ID             = W_SOB_ID
                           GROUP BY VM.SOB_ID
                                , VM.INPUT_DED_NOT_CODE
                         ) SX1
                 )
      LOOP
        DBMS_OUTPUT.PUT_LINE(R1.RECORD_FILE);
        INSERT INTO FI_VAT_REPORT_FILE_GT
        ( SEQ_NUM
        , SOURCE_FILE
        , SOB_ID
        , REPORT_FILE
        ) VALUES
        ( V_SEQ_NUM
        , V_SOURCE_FILE
        , W_SOB_ID
        , R1.RECORD_FILE
        );
      END LOOP R1;      
    END LOOP C1;
    
    ---> ���ݰ�꼭 �հ�ǥ <---
    -- 22.1 ǥ��.
    V_SEQ_NUM := 61;
    V_SOURCE_FILE := 'TAX_INVOICE_SUM';
    FOR C1 IN ( SELECT RPAD('7', 1, ' ') ||  -- �ڷᱸ��
                       RPAD(REPLACE(NVL(BM.VAT_NUM, ' '), '-', ''), 10, ' ') ||
                       RPAD(NVL(CM.CORPORATE_NAME, ' '), 30, ' ') ||     -- ��ȣ.
                       RPAD(NVL(BM.PRESIDENT_NAME, ' '), 15, ' ') ||     -- ��ǥ�ڸ�.
                       RPAD(NVL(BM.ADDR1, ' ') || ' ' || NVL(BM.ADDR2, ' '), 45, ' ') ||     -- ������.
                       RPAD(NVL(BM.BUSINESS_TYPE, ' '), 17, ' ') ||     -- ����.
                       RPAD(NVL(BM.BUSINESS_ITEM, ' '), 25, ' ') ||     -- ����.
                       RPAD(TO_CHAR(W_ISSUE_DATE_FR, 'YYMMDD') || TO_CHAR(W_ISSUE_DATE_TO, 'YYMMDD'), 12, ' ') ||    -- �ŷ��Ⱓ.
                       RPAD(TO_CHAR(P_WRITE_DATE, 'YYMMDD'), 6, ' ') ||    -- �ۼ�����.
                       RPAD(' ', 9, ' ') AS RECORD_FILE
                     , BM.VAT_NUM
                  FROM FI_VAT_DECLARATION VD
                    , FI_BUSINESS_MASTER BM 
                    , FI_CORPORATE_MASTER CM
                WHERE VD.TAX_CODE                 = BM.BUSINESS_CODE
                  AND VD.SOB_ID                   = BM.SOB_ID
                  AND BM.CORPORATE_ID             = CM.CORPORATE_ID
                  AND BM.SOB_ID                   = CM.SOB_ID
                  AND VD.TAX_CODE                 = W_TAX_CODE
                  AND VD.SOB_ID                   = W_SOB_ID
                  AND VD.ISSUE_DATE_FR            = W_ISSUE_DATE_FR
                  AND VD.ISSUE_DATE_TO            = W_ISSUE_DATE_TO
                )
    LOOP
      DBMS_OUTPUT.PUT_LINE(C1.RECORD_FILE);
      INSERT INTO FI_VAT_REPORT_FILE_GT
      ( SEQ_NUM
      , SOURCE_FILE
      , SOB_ID
      , REPORT_FILE
      ) VALUES
      ( V_SEQ_NUM
      , V_SOURCE_FILE
      , W_SOB_ID
      , C1.RECORD_FILE
      );
      -- ���ڼ��ݰ�꼭 �̿ܺ� �����ڷ�. 
      V_SEQ_NUM := 62;      
      FOR R1 IN ( SELECT '1' ||
                         RPAD(REPLACE(C1.VAT_NUM, '-', ''), 10, ' ') || -- ����ڹ�ȣ.
                         LPAD(ROWNUM, 4, '0') || -- �Ϸù�ȣ.
                         RPAD(REPLACE(NVL(SX1.TAX_REG_NO, ' '), '-', ''), 10, ' ') || -- �ŷ��ڹ�ȣ.
                         RPAD(NVL(SX1.CUSTOMER_DESC, ' '), 30, ' ') || -- �ŷ��ڹ�ȣ.
                         RPAD(NVL(SX1.BUSINESS_CONDITION, ' '), 17, ' ') || -- ����.
                         RPAD(NVL(SX1.BUSINESS_ITEM, ' '), 25, ' ') || -- ����.
                         LPAD(NVL(SX1.VAT_COUNT, 0), 7, '0') || -- ���ݰ�꼭 �ż�.
                         RPAD('0', 2, '0') || -- ����.
                         LPAD(CASE
                                WHEN NVL(SX1.GL_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.GL_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.GL_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.GL_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.GL_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 14, '0') || -- ���ް���.
                         LPAD(CASE
                                WHEN NVL(SX1.VAT_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.VAT_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.VAT_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.VAT_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.VAT_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 13, '0') || -- ����. 
                              LPAD(0, 1, '0') || -- �Ű����ַ��ڵ�.
                              LPAD(0, 1, '0') || -- �ַ��ڵ�.
                              RPAD('7501', 4, '0') || -- �ǹ�ȣ.
                              RPAD('000', 3, '0') || -- ���⼭.
                              RPAD(' ', 28, ' ') AS RECORD_FILE
                    FROM (SELECT NVL(SC.TAX_REG_NO, VM.RESIDENT_REG_NUM) AS TAX_REG_NO
                               , SC.SUPP_CUST_NAME AS CUSTOMER_DESC
                               , SC.BUSINESS_CONDITION
                               , SC.BUSINESS_ITEM
                               , SUM(VM.VAT_COUNT) AS VAT_COUNT
                               , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                               , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
                            FROM FI_VAT_MASTER VM
                              , FI_SUPP_CUST_V SC
                          WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID(+)
                            AND VM.SOB_ID                   = SC.SOB_ID(+)
                            AND VM.VAT_GUBUN                = '2'         -- ����.
                            AND VM.TAX_CODE                 = W_TAX_CODE
                            AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                            AND VM.SOB_ID                   = W_SOB_ID
                            AND VM.TAX_ELECTRO_YN           = 'N'
                            AND NOT EXISTS 
                                  ( SELECT 'X'
                                      FROM FI_VAT_TYPE_V VT
                                    WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                                      AND VT.SOB_ID     = VM.SOB_ID
                                      AND VT.VAT_TYPE   IN ('5', '9', '3', '17')  -- ��꼭/������/�ſ�ī�� ����.
                                  )
                          GROUP BY NVL(SC.TAX_REG_NO, VM.RESIDENT_REG_NUM)
                               , SC.SUPP_CUST_NAME
                               , SC.BUSINESS_CONDITION
                               , SC.BUSINESS_ITEM
                         ) SX1
                 )
      LOOP
        DBMS_OUTPUT.PUT_LINE(R1.RECORD_FILE);
        INSERT INTO FI_VAT_REPORT_FILE_GT
        ( SEQ_NUM
        , SOURCE_FILE
        , SOB_ID
        , REPORT_FILE
        ) VALUES
        ( V_SEQ_NUM
        , V_SOURCE_FILE
        , W_SOB_ID
        , R1.RECORD_FILE
        );
      END LOOP R1;
      -- ���ڼ��ݰ�꼭 �̿ܺ� �����հ��ڷ�. 
      V_SEQ_NUM := 62.1;      
      FOR R1 IN ( SELECT '3' ||
                         RPAD(REPLACE(C1.VAT_NUM, '-', ''), 10, ' ') || -- ����ڹ�ȣ.
                         LPAD(NVL(SX1.CUSTOMER_COUNT, 0), 7, '0') || -- �ŷ�ó��.
                         LPAD(NVL(SX1.VAT_COUNT, 0), 7, '0') || -- �ΰ�����.
                         LPAD(CASE
                                WHEN NVL(SX1.GL_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.GL_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.GL_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.GL_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.GL_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 15, '0') || -- ���ް���.
                         LPAD(CASE
                                WHEN NVL(SX1.VAT_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.VAT_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.VAT_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.VAT_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.VAT_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 14, '0') || -- ����. 
                         LPAD(NVL(SX1.L_CUSTOMER_COUNT, 0), 7, '0') || -- �ŷ�ó��.
                         LPAD(NVL(SX1.L_VAT_COUNT, 0), 7, '0') || -- �ΰ�����.
                         LPAD(CASE
                                WHEN NVL(SX1.L_GL_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.L_GL_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.L_GL_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.L_GL_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.L_GL_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 15, '0') || -- ���ް���.
                         LPAD(CASE
                                WHEN NVL(SX1.L_VAT_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.L_VAT_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.L_VAT_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.L_VAT_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.L_VAT_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 14, '0') || -- ����. 
                          LPAD(NVL(SX1.P_CUSTOMER_COUNT, 0), 7, '0') || -- �ŷ�ó��.
                          LPAD(NVL(SX1.P_VAT_COUNT, 0), 7, '0') || -- �ΰ�����.
                          LPAD(CASE
                                WHEN NVL(SX1.P_GL_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.P_GL_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.P_GL_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.P_GL_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.P_GL_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 15, '0') || -- ���ް���.
                          LPAD(CASE
                                WHEN NVL(SX1.P_VAT_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.P_VAT_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.P_VAT_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.P_VAT_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.P_VAT_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 14, '0') || -- ����. 
                              RPAD(' ', 30, ' ') AS RECORD_FILE
                    FROM (SELECT COUNT(DISTINCT VM.CUSTOMER_ID) AS CUSTOMER_COUNT
                               , SUM(VM.VAT_COUNT) VAT_COUNT
                               , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                               , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
                               , COUNT(DISTINCT CASE 
                                                   WHEN SC.SUPP_CUST_CODE IS NULL THEN '-'
                                                   ELSE SC.SUPP_CUST_CODE
                                                 END) AS L_CUSTOMER_COUNT
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, 0, VM.VAT_COUNT)) AS L_VAT_COUNT                               
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, 0, VM.GL_AMOUNT)) AS L_GL_AMOUNT
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, 0, VM.VAT_AMOUNT)) AS L_VAT_AMOUNT
                               , COUNT(DISTINCT CASE 
                                                   WHEN SC.SUPP_CUST_CODE IS NULL THEN '-'
                                                   ELSE VM.RESIDENT_REG_NUM
                                                 END) AS P_CUSTOMER_COUNT
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, VM.VAT_COUNT, 0)) AS P_VAT_COUNT                               
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, VM.GL_AMOUNT, 0)) AS P_GL_AMOUNT
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, VM.VAT_AMOUNT, 0)) AS P_VAT_AMOUNT
                            FROM FI_VAT_MASTER VM
                              , FI_SUPP_CUST_V SC
                          WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID(+)
                            AND VM.SOB_ID                   = SC.SOB_ID(+)
                            AND VM.VAT_GUBUN                = '2'         -- ����.
                            AND VM.TAX_CODE                 = W_TAX_CODE
                            AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                            AND VM.SOB_ID                   = W_SOB_ID
                            AND VM.TAX_ELECTRO_YN           = 'N'
                            AND NOT EXISTS 
                                  ( SELECT 'X'
                                      FROM FI_VAT_TYPE_V VT
                                    WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                                      AND VT.SOB_ID     = VM.SOB_ID
                                      AND VT.VAT_TYPE   IN ('5', '9', '3', '17')  -- ��꼭/������/�ſ�ī�� ����.
                                  )
                         ) SX1
                 )
      LOOP
        DBMS_OUTPUT.PUT_LINE(R1.RECORD_FILE);
        INSERT INTO FI_VAT_REPORT_FILE_GT
        ( SEQ_NUM
        , SOURCE_FILE
        , SOB_ID
        , REPORT_FILE
        ) VALUES
        ( V_SEQ_NUM
        , V_SOURCE_FILE
        , W_SOB_ID
        , R1.RECORD_FILE
        );
      END LOOP R1;
      -- ���ڼ��ݰ�꼭 �߱޺� �����հ��ڷ�. 
      V_SEQ_NUM := 62.2;      
      FOR R1 IN ( SELECT '5' ||
                         RPAD(REPLACE(C1.VAT_NUM, '-', ''), 10, ' ') || -- ����ڹ�ȣ.
                         LPAD(NVL(SX1.CUSTOMER_COUNT, 0), 7, '0') || -- �ŷ�ó��.
                         LPAD(NVL(SX1.VAT_COUNT, 0), 7, '0') || -- �ΰ�����.
                         LPAD(CASE
                                WHEN NVL(SX1.GL_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.GL_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.GL_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.GL_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.GL_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 15, '0') || -- ���ް���.
                         LPAD(CASE
                                WHEN NVL(SX1.VAT_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.VAT_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.VAT_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.VAT_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.VAT_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 14, '0') || -- ����. 
                         LPAD(NVL(SX1.L_CUSTOMER_COUNT, 0), 7, '0') || -- �ŷ�ó��.
                         LPAD(NVL(SX1.L_VAT_COUNT, 0), 7, '0') || -- �ΰ�����.
                         LPAD(CASE
                                WHEN NVL(SX1.L_GL_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.L_GL_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.L_GL_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.L_GL_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.L_GL_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 15, '0') || -- ���ް���.
                         LPAD(CASE
                                WHEN NVL(SX1.L_VAT_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.L_VAT_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.L_VAT_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.L_VAT_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.L_VAT_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 14, '0') || -- ����. 
                          LPAD(NVL(SX1.P_CUSTOMER_COUNT, 0), 7, '0') || -- �ŷ�ó��.
                          LPAD(NVL(SX1.P_VAT_COUNT, 0), 7, '0') || -- �ΰ�����.
                          LPAD(CASE
                                WHEN NVL(SX1.P_GL_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.P_GL_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.P_GL_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.P_GL_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.P_GL_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 15, '0') || -- ���ް���.
                          LPAD(CASE
                                WHEN NVL(SX1.P_VAT_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.P_VAT_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.P_VAT_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.P_VAT_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.P_VAT_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 14, '0') || -- ����. 
                              RPAD(' ', 30, ' ') AS RECORD_FILE
                    FROM (SELECT COUNT(DISTINCT VM.CUSTOMER_ID) AS CUSTOMER_COUNT
                               , SUM(VM.VAT_COUNT) VAT_COUNT
                               , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                               , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
                               , COUNT(DISTINCT CASE 
                                                   WHEN SC.SUPP_CUST_CODE IS NULL THEN '-'
                                                   ELSE SC.SUPP_CUST_CODE
                                                 END) AS L_CUSTOMER_COUNT
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, 0, VM.VAT_COUNT)) AS L_VAT_COUNT                               
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, 0, VM.GL_AMOUNT)) AS L_GL_AMOUNT
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, 0, VM.VAT_AMOUNT)) AS L_VAT_AMOUNT
                               , COUNT(DISTINCT CASE 
                                                   WHEN SC.SUPP_CUST_CODE IS NULL THEN '-'
                                                   ELSE VM.RESIDENT_REG_NUM
                                                 END) AS P_CUSTOMER_COUNT
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, VM.VAT_COUNT, 0)) AS P_VAT_COUNT                               
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, VM.GL_AMOUNT, 0)) AS P_GL_AMOUNT
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, VM.VAT_AMOUNT, 0)) AS P_VAT_AMOUNT
                            FROM FI_VAT_MASTER VM
                              , FI_SUPP_CUST_V SC
                          WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID(+)
                            AND VM.SOB_ID                   = SC.SOB_ID(+)
                            AND VM.VAT_GUBUN                = '2'         -- ����.
                            AND VM.TAX_CODE                 = W_TAX_CODE
                            AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                            AND VM.SOB_ID                   = W_SOB_ID
                            AND VM.TAX_ELECTRO_YN           = 'Y'
                            AND NOT EXISTS 
                                  ( SELECT 'X'
                                      FROM FI_VAT_TYPE_V VT
                                    WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                                      AND VT.SOB_ID     = VM.SOB_ID
                                      AND VT.VAT_TYPE   IN ('5', '9', '3', '17')  -- ��꼭/������/�ſ�ī�� ����.
                                  )
                         ) SX1
                 )
      LOOP
        DBMS_OUTPUT.PUT_LINE(R1.RECORD_FILE);
        INSERT INTO FI_VAT_REPORT_FILE_GT
        ( SEQ_NUM
        , SOURCE_FILE
        , SOB_ID
        , REPORT_FILE
        ) VALUES
        ( V_SEQ_NUM
        , V_SOURCE_FILE
        , W_SOB_ID
        , R1.RECORD_FILE
        );
      END LOOP R1;
      
      --> ���ڼ��ݰ�꼭 �̿ܺ� �����ڷ�.<--
      V_SEQ_NUM := 63;      
      FOR R1 IN ( SELECT '2' ||
                         RPAD(REPLACE(C1.VAT_NUM, '-', ''), 10, ' ') || -- ����ڹ�ȣ.
                         LPAD(ROWNUM, 4, '0') || -- �Ϸù�ȣ.
                         RPAD(REPLACE(NVL(SX1.TAX_REG_NO, ' '), '-', ''), 10, ' ') || -- �ŷ��ڹ�ȣ.
                         RPAD(NVL(SX1.CUSTOMER_DESC, ' '), 30, ' ') || -- �ŷ��ڹ�ȣ.
                         RPAD(NVL(SX1.BUSINESS_CONDITION, ' '), 17, ' ') || -- ����.
                         RPAD(NVL(SX1.BUSINESS_ITEM, ' '), 25, ' ') || -- ����.
                         LPAD(NVL(SX1.VAT_COUNT, 0), 7, '0') || -- ���ݰ�꼭 �ż�.
                         RPAD('0', 2, '0') || -- ����.
                         LPAD(CASE
                                WHEN NVL(SX1.GL_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.GL_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.GL_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.GL_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.GL_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 14, '0') || -- ���ް���.
                         LPAD(CASE
                                WHEN NVL(SX1.VAT_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.VAT_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.VAT_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.VAT_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.VAT_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 13, '0') || -- ����. 
                              LPAD(0, 1, '0') || -- �Ű����ַ��ڵ�.
                              LPAD(0, 1, '0') || -- �ַ��ڵ�.
                              RPAD('8501', 4, '0') || -- �ǹ�ȣ.
                              RPAD('000', 3, '0') || -- ���⼭.
                              RPAD(' ', 28, ' ') AS RECORD_FILE
                    FROM (SELECT NVL(SC.TAX_REG_NO, VM.RESIDENT_REG_NUM) AS TAX_REG_NO
                               , SC.SUPP_CUST_NAME AS CUSTOMER_DESC
                               , SC.BUSINESS_CONDITION
                               , SC.BUSINESS_ITEM
                               , SUM(VM.VAT_COUNT) AS VAT_COUNT
                               , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                               , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
                            FROM FI_VAT_MASTER VM
                              , FI_SUPP_CUST_V SC
                          WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID(+)
                            AND VM.SOB_ID                   = SC.SOB_ID(+)
                            AND VM.VAT_GUBUN                = '1'         -- ����.
                            AND VM.TAX_CODE                 = W_TAX_CODE
                            AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                            AND VM.SOB_ID                   = W_SOB_ID
                            AND VM.TAX_ELECTRO_YN           = 'N'
                            AND NOT EXISTS 
                                  ( SELECT 'X'
                                      FROM FI_VAT_TYPE_V VT
                                    WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                                      AND VT.SOB_ID     = VM.SOB_ID
                                      AND VT.VAT_TYPE   IN ('5', '9', '3')  -- ��꼭/������/�ſ�ī�� ����.
                                  )
                          GROUP BY NVL(SC.TAX_REG_NO, VM.RESIDENT_REG_NUM)
                               , SC.SUPP_CUST_NAME
                               , SC.BUSINESS_CONDITION
                               , SC.BUSINESS_ITEM
                         ) SX1
                 )
      LOOP
        DBMS_OUTPUT.PUT_LINE(R1.RECORD_FILE);
        INSERT INTO FI_VAT_REPORT_FILE_GT
        ( SEQ_NUM
        , SOURCE_FILE
        , SOB_ID
        , REPORT_FILE
        ) VALUES
        ( V_SEQ_NUM
        , V_SOURCE_FILE
        , W_SOB_ID
        , R1.RECORD_FILE
        );
      END LOOP R1;
      -- ���ڼ��ݰ�꼭 �̿ܺ� �����հ��ڷ�. 
      V_SEQ_NUM := 63.1;      
      FOR R1 IN ( SELECT '4' ||
                         RPAD(REPLACE(C1.VAT_NUM, '-', ''), 10, ' ') || -- ����ڹ�ȣ.
                         LPAD(NVL(SX1.CUSTOMER_COUNT, 0), 7, '0') || -- �ŷ�ó��.
                         LPAD(NVL(SX1.VAT_COUNT, 0), 7, '0') || -- �ΰ�����.
                         LPAD(CASE
                                WHEN NVL(SX1.GL_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.GL_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.GL_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.GL_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.GL_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 15, '0') || -- ���ް���.
                         LPAD(CASE
                                WHEN NVL(SX1.VAT_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.VAT_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.VAT_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.VAT_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.VAT_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 14, '0') || -- ����. 
                         LPAD(NVL(SX1.L_CUSTOMER_COUNT, 0), 7, '0') || -- �ŷ�ó��.
                         LPAD(NVL(SX1.L_VAT_COUNT, 0), 7, '0') || -- �ΰ�����.
                         LPAD(CASE
                                WHEN NVL(SX1.L_GL_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.L_GL_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.L_GL_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.L_GL_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.L_GL_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 15, '0') || -- ���ް���.
                         LPAD(CASE
                                WHEN NVL(SX1.L_VAT_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.L_VAT_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.L_VAT_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.L_VAT_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.L_VAT_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 14, '0') || -- ����. 
                          LPAD(NVL(SX1.P_CUSTOMER_COUNT, 0), 7, '0') || -- �ŷ�ó��.
                          LPAD(NVL(SX1.P_VAT_COUNT, 0), 7, '0') || -- �ΰ�����.
                          LPAD(CASE
                                WHEN NVL(SX1.P_GL_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.P_GL_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.P_GL_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.P_GL_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.P_GL_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 15, '0') || -- ���ް���.
                          LPAD(CASE
                                WHEN NVL(SX1.P_VAT_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.P_VAT_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.P_VAT_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.P_VAT_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.P_VAT_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 14, '0') || -- ����. 
                              RPAD(' ', 30, ' ') AS RECORD_FILE
                    FROM (SELECT COUNT(DISTINCT VM.CUSTOMER_ID) AS CUSTOMER_COUNT
                               , SUM(VM.VAT_COUNT) VAT_COUNT
                               , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                               , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
                               , COUNT(DISTINCT CASE 
                                                   WHEN SC.SUPP_CUST_CODE IS NULL THEN '-'
                                                   ELSE SC.SUPP_CUST_CODE
                                                 END) AS L_CUSTOMER_COUNT
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, 0, VM.VAT_COUNT)) AS L_VAT_COUNT                               
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, 0, VM.GL_AMOUNT)) AS L_GL_AMOUNT
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, 0, VM.VAT_AMOUNT)) AS L_VAT_AMOUNT
                               , COUNT(DISTINCT CASE 
                                                   WHEN SC.SUPP_CUST_CODE IS NULL THEN '-'
                                                   ELSE VM.RESIDENT_REG_NUM
                                                 END) AS P_CUSTOMER_COUNT
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, VM.VAT_COUNT, 0)) AS P_VAT_COUNT                               
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, VM.GL_AMOUNT, 0)) AS P_GL_AMOUNT
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, VM.VAT_AMOUNT, 0)) AS P_VAT_AMOUNT
                            FROM FI_VAT_MASTER VM
                              , FI_SUPP_CUST_V SC
                          WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID(+)
                            AND VM.SOB_ID                   = SC.SOB_ID(+)
                            AND VM.VAT_GUBUN                = '1'         -- ����.
                            AND VM.TAX_CODE                 = W_TAX_CODE
                            AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                            AND VM.SOB_ID                   = W_SOB_ID
                            AND VM.TAX_ELECTRO_YN           = 'N'
                            AND NOT EXISTS 
                                  ( SELECT 'X'
                                      FROM FI_VAT_TYPE_V VT
                                    WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                                      AND VT.SOB_ID     = VM.SOB_ID
                                      AND VT.VAT_TYPE   IN ('5', '9', '3')  -- ��꼭/������/�ſ�ī�� ����.
                                  )
                         ) SX1
                 )
      LOOP
        DBMS_OUTPUT.PUT_LINE(R1.RECORD_FILE);
        INSERT INTO FI_VAT_REPORT_FILE_GT
        ( SEQ_NUM
        , SOURCE_FILE
        , SOB_ID
        , REPORT_FILE
        ) VALUES
        ( V_SEQ_NUM
        , V_SOURCE_FILE
        , W_SOB_ID
        , R1.RECORD_FILE
        );
      END LOOP R1;
      -- ���ڼ��ݰ�꼭 �߱޺� �����հ��ڷ�. 
      V_SEQ_NUM := 63.2;      
      FOR R1 IN ( SELECT '6' ||
                         RPAD(REPLACE(C1.VAT_NUM, '-', ''), 10, ' ') || -- ����ڹ�ȣ.
                         LPAD(NVL(SX1.CUSTOMER_COUNT, 0), 7, '0') || -- �ŷ�ó��.
                         LPAD(NVL(SX1.VAT_COUNT, 0), 7, '0') || -- �ΰ�����.
                         LPAD(CASE
                                WHEN NVL(SX1.GL_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.GL_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.GL_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.GL_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.GL_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 15, '0') || -- ���ް���.
                         LPAD(CASE
                                WHEN NVL(SX1.VAT_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.VAT_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.VAT_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.VAT_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.VAT_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 14, '0') || -- ����. 
                         LPAD(NVL(SX1.L_CUSTOMER_COUNT, 0), 7, '0') || -- �ŷ�ó��.
                         LPAD(NVL(SX1.L_VAT_COUNT, 0), 7, '0') || -- �ΰ�����.
                         LPAD(CASE
                                WHEN NVL(SX1.L_GL_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.L_GL_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.L_GL_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.L_GL_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.L_GL_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 15, '0') || -- ���ް���.
                         LPAD(CASE
                                WHEN NVL(SX1.L_VAT_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.L_VAT_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.L_VAT_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.L_VAT_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.L_VAT_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 14, '0') || -- ����. 
                          LPAD(NVL(SX1.P_CUSTOMER_COUNT, 0), 7, '0') || -- �ŷ�ó��.
                          LPAD(NVL(SX1.P_VAT_COUNT, 0), 7, '0') || -- �ΰ�����.
                          LPAD(CASE
                                WHEN NVL(SX1.P_GL_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.P_GL_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.P_GL_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.P_GL_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.P_GL_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 15, '0') || -- ���ް���.
                          LPAD(CASE
                                WHEN NVL(SX1.P_VAT_AMOUNT, 0) >= 0 THEN TO_CHAR(NVL(SX1.P_VAT_AMOUNT, 0))
                                ELSE  SUBSTRB(REPLACE(TO_CHAR(NVL(SX1.P_VAT_AMOUNT, 0)), '-', ''), 1, LENGTH(TO_CHAR(NVL(SX1.P_VAT_AMOUNT, 0))) - 2) ||
                                                  CASE SUBSTR(TO_CHAR(NVL(SX1.P_VAT_AMOUNT, 0)), -1, 1)
                                                    WHEN '1' THEN 'J'
                                                    WHEN '2' THEN 'K'
                                                    WHEN '3' THEN 'L'
                                                    WHEN '4' THEN 'M'
                                                    WHEN '5' THEN 'N'
                                                    WHEN '6' THEN 'O'
                                                    WHEN '7' THEN 'P'
                                                    WHEN '8' THEN 'Q'
                                                    WHEN '9' THEN 'R'
                                                    WHEN '0' THEN '}'
                                                  END
                              END, 14, '0') || -- ����. 
                              RPAD(' ', 30, ' ') AS RECORD_FILE
                    FROM (SELECT COUNT(DISTINCT VM.CUSTOMER_ID) AS CUSTOMER_COUNT
                               , SUM(VM.VAT_COUNT) VAT_COUNT
                               , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                               , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
                               , COUNT(DISTINCT CASE 
                                                   WHEN SC.SUPP_CUST_CODE IS NULL THEN '-'
                                                   ELSE SC.SUPP_CUST_CODE
                                                 END) AS L_CUSTOMER_COUNT
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, 0, VM.VAT_COUNT)) AS L_VAT_COUNT                               
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, 0, VM.GL_AMOUNT)) AS L_GL_AMOUNT
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, 0, VM.VAT_AMOUNT)) AS L_VAT_AMOUNT
                               , COUNT(DISTINCT CASE 
                                                   WHEN SC.SUPP_CUST_CODE IS NULL THEN '-'
                                                   ELSE VM.RESIDENT_REG_NUM
                                                 END) AS P_CUSTOMER_COUNT
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, VM.VAT_COUNT, 0)) AS P_VAT_COUNT                               
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, VM.GL_AMOUNT, 0)) AS P_GL_AMOUNT
                               , SUM(DECODE(SC.SUPP_CUST_CODE, NULL, VM.VAT_AMOUNT, 0)) AS P_VAT_AMOUNT
                            FROM FI_VAT_MASTER VM
                              , FI_SUPP_CUST_V SC
                          WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID(+)
                            AND VM.SOB_ID                   = SC.SOB_ID(+)
                            AND VM.VAT_GUBUN                = '1'         -- ����.
                            AND VM.TAX_CODE                 = W_TAX_CODE
                            AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                            AND VM.SOB_ID                   = W_SOB_ID
                            AND VM.TAX_ELECTRO_YN           = 'Y'
                            AND NOT EXISTS 
                                  ( SELECT 'X'
                                      FROM FI_VAT_TYPE_V VT
                                    WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                                      AND VT.SOB_ID     = VM.SOB_ID
                                      AND VT.VAT_TYPE   IN ('5', '9', '3')  -- ��꼭/������/�ſ�ī�� ����.
                                  )
                         ) SX1
                 )
      LOOP
        DBMS_OUTPUT.PUT_LINE(R1.RECORD_FILE);
        INSERT INTO FI_VAT_REPORT_FILE_GT
        ( SEQ_NUM
        , SOURCE_FILE
        , SOB_ID
        , REPORT_FILE
        ) VALUES
        ( V_SEQ_NUM
        , V_SOURCE_FILE
        , W_SOB_ID
        , R1.RECORD_FILE
        );
      END LOOP R1;      
    END LOOP C1;
    
    ---> ��꼭 �հ�ǥ <---
    -- 23.1 ǥ��.
    V_SEQ_NUM := 64;
    V_SOURCE_FILE := 'BILL_SUM';
    BEGIN
      SELECT COUNT(DISTINCT SC.TAX_REG_NO) AS CUSTOMER_COUNT
        INTO V_RECORD_COUNT
        FROM FI_VAT_MASTER VM
          , FI_SUPP_CUST_V SC
      WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID(+)
        AND VM.SOB_ID                   = SC.SOB_ID(+)
        AND VM.VAT_GUBUN                = '1'         -- ����.
        AND VM.TAX_CODE                 = W_TAX_CODE
        AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
        AND VM.SOB_ID                   = W_SOB_ID
        AND VM.VAT_TYPE                 = '5'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;          
    FOR C1 IN ( SELECT RPAD('A', 1, ' ') ||  -- �ڷᱸ��
                       RPAD(NVL(BM.TAX_OFFICE_CODE, ' '), 3, ' ') || -- ������.
                       RPAD(TO_CHAR(P_WRITE_DATE, 'YYYYMMDD'), 8, ' ') || -- ��������.
                       RPAD('2', 1, ' ') || -- �����ڱ���.
                       RPAD(' ', 6, ' ') || -- �����븮�ΰ�����ȣ.
                       RPAD(REPLACE(NVL(BM.VAT_NUM, ' '), '-', ''), 10, ' ') ||
                       RPAD(NVL(CM.CORPORATE_NAME, ' '), 40, ' ') ||     -- ��ȣ.
                       RPAD(REPLACE(NVL(CM.LEGAL_NUM, ' '), '-', ''), 13, ' ') || -- �ֹ�(����)��ȣ.
                       RPAD(NVL(BM.PRESIDENT_NAME, ' '), 30, ' ') ||     -- ��ǥ�ڸ�.
                       RPAD(NVL(BM.ZIP_CODE, ' '), 10, ' ') || -- �����ȣ.
                       RPAD(NVL(BM.ADDR1, ' ') || ' ' || NVL(BM.ADDR2, ' '), 70, ' ') ||     -- ������.
                       RPAD(REPLACE(NVL(BM.TEL_NUM, ' '), '-', ''), 15,  ' ') || -- ��ȭ��ȣ. 
                       LPAD(NVL(V_RECORD_COUNT, 0), 5, '0') || -- �Ǽ�.                       
                       RPAD('101', 3, ' ') || -- �ѱ��ڵ�.
                       RPAD(' ', 15, ' ') AS RECORD_FILE
                     , BM.VAT_NUM
                     , CM.CORPORATE_NAME
                     , CM.PRESIDENT_NAME
                     , BM.ZIP_CODE
                     , NVL(BM.ADDR1, ' ') || ' ' || NVL(BM.ADDR2, ' ') AS ADDRESS
                     , ROWNUM AS ROW_NUM
                     , BM.TAX_OFFICE_CODE
                  FROM FI_VAT_DECLARATION VD
                    , FI_BUSINESS_MASTER BM 
                    , FI_CORPORATE_MASTER CM
                WHERE VD.TAX_CODE                 = BM.BUSINESS_CODE
                  AND VD.SOB_ID                   = BM.SOB_ID
                  AND BM.CORPORATE_ID             = CM.CORPORATE_ID
                  AND BM.SOB_ID                   = CM.SOB_ID
                  AND VD.TAX_CODE                 = W_TAX_CODE
                  AND VD.SOB_ID                   = W_SOB_ID
                  AND VD.ISSUE_DATE_FR            = W_ISSUE_DATE_FR
                  AND VD.ISSUE_DATE_TO            = W_ISSUE_DATE_TO
                )
    LOOP
      DBMS_OUTPUT.PUT_LINE(C1.RECORD_FILE);
      INSERT INTO FI_VAT_REPORT_FILE_GT
      ( SEQ_NUM
      , SOURCE_FILE
      , SOB_ID
      , REPORT_FILE
      ) VALUES
      ( V_SEQ_NUM
      , V_SOURCE_FILE
      , W_SOB_ID
      , C1.RECORD_FILE
      );
      -- 23.1 �����ǹ����������׷��ڵ�.
      V_SEQ_NUM := 64.1;
      V_SOURCE_FILE := 'BILL_SUM';
      FOR R1 IN( SELECT RPAD('B', 1, ' ') || 
                        RPAD(NVL(C1.TAX_OFFICE_CODE, ' '), 3, ' ') || -- �������ڵ�.
                        LPAD(NVL(C1.ROW_NUM, 0), 6, '0') || -- �Ϸù�ȣ.
                        RPAD(REPLACE(NVL(C1.VAT_NUM, ' '), '-', ''), 10, ' ') || -- ����ڵ�Ϲ�ȣ
                        RPAD(NVL(C1.CORPORATE_NAME, ' '), 40, ' ') || -- ��ȣ.
                        RPAD(NVL(C1.PRESIDENT_NAME, ' '), 30, ' ') || -- ��ǥ��.
                        RPAD(NVL(C1.ZIP_CODE, ' '), 10, ' ') || -- ��ǥ��.
                        RPAD(NVL(C1.ADDRESS, ' '), 70, ' ') || -- ��ǥ��.
                        RPAD(' ', 60, ' ') AS RECORD_FILE
                      , ROWNUM AS ROW_NUM
                   FROM DUAL
               )
      LOOP
        DBMS_OUTPUT.PUT_LINE(R1.RECORD_FILE);
        INSERT INTO FI_VAT_REPORT_FILE_GT
        ( SEQ_NUM
        , SOURCE_FILE
        , SOB_ID
        , REPORT_FILE
        ) VALUES
        ( V_SEQ_NUM
        , V_SOURCE_FILE
        , W_SOB_ID
        , R1.RECORD_FILE
        );
        --27.2 �����ǹ��ں� ���跹�ڵ�.(����)
        V_SEQ_NUM := 64.2;
        V_SOURCE_FILE := 'BILL_SUM';
        FOR R2 IN( SELECT RPAD('C', 1, ' ') || 
                          RPAD('18', 2, ' ') || --�ڷᱸ��
                          RPAD(CASE 
                                 WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '04', '05', '06') THEN '1'
                                 ELSE '2'
                               END, 1, ' ') || --�ⱸ��.
                          RPAD(CASE 
                                 WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '07', '08', '09') THEN '1'  -- �����Ű�.
                                 WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '05', '06', '10', '11', '12') THEN '2'  -- Ȯ���Ű�.
                               END, 1, ' ') ||   
                          RPAD(NVL(C1.TAX_OFFICE_CODE, ' '), 3, ' ') || -- �������ڵ�.  
                          LPAD(NVL(R1.ROW_NUM, 0), 6, '0') || -- �Ϸù�ȣ.
                          RPAD(REPLACE(NVL(C1.VAT_NUM, ' '), '-', ''), 10, ' ') || -- ����ڹ�ȣ.
                          RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYY'), 4, ' ') || -- �ͼӳ⵵.
                          RPAD(TO_CHAR(W_ISSUE_DATE_FR, 'YYYYMMDD'), 8, ' ') || -- �ŷ��Ⱓ���۳����.
                          RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMMDD'), 8, ' ') || -- �ŷ��Ⱓ��������.
                          RPAD(TO_CHAR(P_WRITE_DATE, 'YYYYMMDD'), 8, ' ') || -- �ŷ��Ⱓ��������.
                          LPAD(NVL(SX1.CUSTOMER_COUNT, 0), 6, '0') || -- ����ó��.
                          LPAD(NVL(SX1.VAT_COUNT, 0), 6, '0') || -- ��꼭�ż�.
                          RPAD(CASE WHEN NVL(SX1.GL_AMOUNT, 0) >= 0 THEN '0' ELSE '1' END, 1, ' ') || -- ����ǥ��.
                          LPAD(REPLACE(LPAD(NVL(SX1.GL_AMOUNT, 0), 14, '0'), '-', ''), 14, '-') || -- ���Աݾ�.
                          RPAD(' ', 151, ' ') AS RECORD_FILE
                     FROM (SELECT COUNT(DISTINCT SC.TAX_REG_NO) AS CUSTOMER_COUNT
                                 , SUM(VM.VAT_COUNT) AS VAT_COUNT
                                 , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                                 , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
                              FROM FI_VAT_MASTER VM
                                , FI_SUPP_CUST_V SC
                            WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID(+)
                              AND VM.SOB_ID                   = SC.SOB_ID(+)
                              AND VM.VAT_GUBUN                = '1'         -- ����.
                              AND VM.TAX_CODE                 = W_TAX_CODE
                              AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                              AND VM.SOB_ID                   = W_SOB_ID
                              AND VM.VAT_TYPE                 = '5'
                           ) SX1
                 )
        LOOP
          DBMS_OUTPUT.PUT_LINE(R2.RECORD_FILE);
          INSERT INTO FI_VAT_REPORT_FILE_GT
          ( SEQ_NUM
          , SOURCE_FILE
          , SOB_ID
          , REPORT_FILE
          ) VALUES
          ( V_SEQ_NUM
          , V_SOURCE_FILE
          , W_SOB_ID
          , R2.RECORD_FILE
          );
          --27.3 �����ǹ��ں� �����ڵ�.(����)
          V_SEQ_NUM := 64.3;
          V_SOURCE_FILE := 'BILL_SUM';
          FOR R3 IN( SELECT RPAD('D', 1, ' ') || 
                            RPAD('18', 2, ' ') || --�ڷᱸ��
                            RPAD(CASE 
                                   WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '04', '05', '06') THEN '1'
                                   ELSE '2'
                                 END, 1, ' ') || --�ⱸ��.
                            RPAD(CASE 
                                   WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '07', '08', '09') THEN '1'  -- �����Ű�.
                                   WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '05', '06', '10', '11', '12') THEN '2'  -- Ȯ���Ű�.
                                 END, 1, ' ') ||   
                            RPAD(NVL(C1.TAX_OFFICE_CODE, ' '), 3, ' ') || -- �������ڵ�.  
                            LPAD(NVL(R1.ROW_NUM, 0), 6, '0') || -- �Ϸù�ȣ.
                            RPAD(REPLACE(NVL(C1.VAT_NUM, ' '), '-', ''), 10, ' ') || -- ����ڹ�ȣ.
                            RPAD(REPLACE(NVL(SX1.TAX_REG_NO, ' '), '-', ''), 10, ' ') || -- ����ó ����ڹ�ȣ.
                            RPAD(NVL(SX1.CUSTOMER_DESC, ' '), 40, ' ') || -- ����ó ��ȣ.
                            LPAD(NVL(SX1.VAT_COUNT, 0), 5, '0') || -- ��꼭�ż�.
                            RPAD(CASE WHEN NVL(SX1.GL_AMOUNT, 0) >= 0 THEN '0' ELSE '1' END, 1, ' ') || -- ����ǥ��.
                            LPAD(REPLACE(LPAD(NVL(SX1.GL_AMOUNT, 0), 14, '0'), '-', ''), 14, '-') || -- ���Աݾ�.
                            RPAD(' ', 136, ' ') AS RECORD_FILE
                       FROM (SELECT  SC.TAX_REG_NO
                                   , SC.SUPP_CUST_NAME AS CUSTOMER_DESC
                                   , SUM(VM.VAT_COUNT) AS VAT_COUNT
                                   , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                                   , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
                                FROM FI_VAT_MASTER VM
                                  , FI_SUPP_CUST_V SC
                              WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID(+)
                                AND VM.SOB_ID                   = SC.SOB_ID(+)
                                AND VM.VAT_GUBUN                = '1'         -- ����.
                                AND VM.TAX_CODE                 = W_TAX_CODE
                                AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                                AND VM.SOB_ID                   = W_SOB_ID
                                AND VM.VAT_TYPE                 = '5'
                              GROUP BY SC.TAX_REG_NO
                                   , SC.SUPP_CUST_NAME 
                             ) SX1
                   )
          LOOP
            DBMS_OUTPUT.PUT_LINE(R3.RECORD_FILE);
            INSERT INTO FI_VAT_REPORT_FILE_GT
            ( SEQ_NUM
            , SOURCE_FILE
            , SOB_ID
            , REPORT_FILE
            ) VALUES
            ( V_SEQ_NUM
            , V_SOURCE_FILE
            , W_SOB_ID
            , R3.RECORD_FILE
            );
          END LOOP R3;
        END LOOP R2;        
      END LOOP R1;
    END LOOP C1;
    
    --> ����������� <--
    V_SEQ_NUM := 71;     
    V_SOURCE_FILE := 'EXPORT'; 
    FOR C1 IN ( SELECT RPAD('A', 1, ' ') ||  -- �ڷᱸ��
                       RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMM'), 6, ' ') || -- ����Ű���(�ͼӳ��).
                       RPAD('3', 1, ' ') || --�Ű���
                       RPAD(REPLACE(NVL(BM.VAT_NUM, ' '), '-', ''), 10, ' ') || -- ����ڹ�ȣ
                       RPAD(NVL(CM.CORPORATE_NAME, ' '), 30, ' ') ||     -- ��ȣ.
                       RPAD(NVL(BM.PRESIDENT_NAME, ' '), 15, ' ') ||     -- ��ǥ�ڸ�.
                       RPAD(NVL(BM.ADDR1, ' ') || ' ' || NVL(BM.ADDR2, ' '), 45, ' ') ||     -- ������.
                       RPAD(NVL(BM.BUSINESS_TYPE, ' '), 17, ' ') || -- ����.
                       RPAD(NVL(BM.BUSINESS_ITEM, ' '), 25, ' ') || -- ����.
                       RPAD(TO_CHAR(W_ISSUE_DATE_FR, 'YYYYMMDD') || TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMMDD'), 16, ' ') || -- �ŷ��Ⱓ.
                       RPAD(TO_CHAR(W_ISSUE_DATE_FR, 'YYYYMMDD'), 8, ' ') || -- �ۼ�����.
                       RPAD(' ', 6, ' ') AS RECORD_FILE
                     , BM.VAT_NUM
                     , CM.CORPORATE_NAME
                     , CM.PRESIDENT_NAME
                     , BM.ZIP_CODE
                     , NVL(BM.ADDR1, ' ') || ' ' || NVL(BM.ADDR2, ' ') AS ADDRESS
                     , ROWNUM AS ROW_NUM
                     , BM.TAX_OFFICE_CODE
                  FROM FI_VAT_DECLARATION VD
                    , FI_BUSINESS_MASTER BM 
                    , FI_CORPORATE_MASTER CM
                WHERE VD.TAX_CODE                 = BM.BUSINESS_CODE
                  AND VD.SOB_ID                   = BM.SOB_ID
                  AND BM.CORPORATE_ID             = CM.CORPORATE_ID
                  AND BM.SOB_ID                   = CM.SOB_ID
                  AND VD.TAX_CODE                 = W_TAX_CODE
                  AND VD.SOB_ID                   = W_SOB_ID
                  AND VD.ISSUE_DATE_FR            = W_ISSUE_DATE_FR
                  AND VD.ISSUE_DATE_TO            = W_ISSUE_DATE_TO
                )
    LOOP
      DBMS_OUTPUT.PUT_LINE(C1.RECORD_FILE);
      INSERT INTO FI_VAT_REPORT_FILE_GT
      ( SEQ_NUM
      , SOURCE_FILE
      , SOB_ID
      , REPORT_FILE
      ) VALUES
      ( V_SEQ_NUM
      , V_SOURCE_FILE
      , W_SOB_ID
      , C1.RECORD_FILE
      );
      -- 30.2.����.
      V_SEQ_NUM := 71.1;
      V_SOURCE_FILE := 'EXPORT';
      FOR R1 IN( SELECT RPAD('B', 1, ' ') || 
                        RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMM'), 6, ' ') || -- ����Ű���(�ͼӳ��).
                        RPAD('3', 1, ' ') || --�Ű���
                        RPAD(REPLACE(NVL(C1.VAT_NUM, ' '), '-', ''), 10, ' ') || -- ����ڵ�Ϲ�ȣ.
                        LPAD(NVL(SX1.TOT_COUNT, 0), 7, '0') || -- �Ǽ��հ�.
                        LPAD(REPLACE(TO_CHAR(NVL(SX1.TOT_CURR_AMOUNT, 0), 'FM999999999999990.00'), '.', ''), 15, '0') || -- ��ȭ�հ�.
                        LPAD(NVL(SX1.TOT_BASE_AMOUNT, 0), 15, '0') || -- ��ȭ�հ�.
                        LPAD(NVL(SX1.ITEM_COUNT, 0), 7, '0') || -- �Ǽ�-��ȭ.
                        LPAD(REPLACE(TO_CHAR(NVL(SX1.ITEM_CURR_AMOUNT, 0), 'FM999999999999990.00'), '.', ''), 15, '0') || -- ��ȭ-��ȭ.
                        LPAD(NVL(SX1.ITEM_BASE_AMOUNT, 0), 15, '0') || -- ��ȭ-��ȭ.
                        LPAD(NVL(SX1.ETC_COUNT, 0), 7, '0') || -- �Ǽ�-��Ÿ.
                        LPAD(REPLACE(TO_CHAR(NVL(SX1.ETC_CURR_AMOUNT, 0), 'FM999999999999990.00'), '.', ''), 15, '0') || -- ��ȭ-��Ÿ.
                        LPAD(NVL(SX1.ETC_BASE_AMOUNT, 0), 15, '0') || -- ��ȭ-��Ÿ.
                        RPAD(' ', 51, ' ') AS RECORD_FILE
                      , ROWNUM AS ROW_NUM
                   FROM ( SELECT  COUNT(VE.EXPORT_ID) AS TOT_COUNT
                                , SUM(VE.CURR_AMOUNT) TOT_CURR_AMOUNT
                                , SUM(VE.BASE_AMOUNT) TOT_BASE_AMOUNT
                                , COUNT(VE.EXPORT_ID) AS ITEM_COUNT
                                , SUM(VE.CURR_AMOUNT) ITEM_CURR_AMOUNT
                                , SUM(VE.BASE_AMOUNT) ITEM_BASE_AMOUNT
                                , 0 AS ETC_COUNT
                                , 0 AS ETC_CURR_AMOUNT
                                , 0 AS ETC_BASE_AMOUNT
                            FROM FI_VAT_EXPORT VE
                          WHERE VE.TAX_CODE                 = W_TAX_CODE
                            AND VE.SHIPPING_DATE            BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                            AND VE.SOB_ID                   = W_SOB_ID
                         ) SX1
               )
      LOOP
        DBMS_OUTPUT.PUT_LINE(R1.RECORD_FILE);
        INSERT INTO FI_VAT_REPORT_FILE_GT
        ( SEQ_NUM
        , SOURCE_FILE
        , SOB_ID
        , REPORT_FILE
        ) VALUES
        ( V_SEQ_NUM
        , V_SOURCE_FILE
        , W_SOB_ID
        , R1.RECORD_FILE
        );    
      END LOOP R1;
      -- 30.3.����/.
      V_SEQ_NUM := 71.2;
      V_SOURCE_FILE := 'EXPORT';
      FOR R1 IN( SELECT RPAD('C', 1, ' ') || 
                        RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMM'), 6, ' ') || -- ����Ű���(�ͼӳ��).
                        RPAD('3', 1, ' ') || --�Ű���
                        RPAD(REPLACE(NVL(C1.VAT_NUM, ' '), '-', ''), 10, ' ') || -- ����ڵ�Ϲ�ȣ.
                        LPAD(ROWNUM, 7, '0') || -- �Ϸù�ȣ.
                        RPAD(REPLACE(NVL(VE.DOCUMENT_NUM, ' '), '-', ''), 15, ' ') || -- ����Ű��ȣ.
                        RPAD(TO_CHAR(VE.SHIPPING_DATE, 'YYYYMMDD'), 8, ' ') || -- ��������.
                        RPAD(NVL(VE.CURRENCY_CODE, ' '), 3, ' ') || -- ��ȭ.
                        LPAD(REPLACE(TO_CHAR(NVL(VE.EXCHANGE_RATE, 0), 'FM99990.0000'), '.', ''), 9, '0') || --ȯ��.
                        LPAD(REPLACE(TO_CHAR(NVL(VE.CURR_AMOUNT, 0), 'FM999999999999990.00'), '.', ''), 15, '0') || -- ��ȭ.
                        LPAD(NVL(VE.BASE_AMOUNT, 0), 15, '0') || -- ��ȭ.
                        RPAD(' ', 90, ' ') AS RECORD_FILE
                   FROM FI_VAT_EXPORT VE
                 WHERE VE.TAX_CODE                 = W_TAX_CODE
                   AND VE.SHIPPING_DATE            BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                   AND VE.SOB_ID                   = W_SOB_ID
               )
      LOOP
        DBMS_OUTPUT.PUT_LINE(R1.RECORD_FILE);
        INSERT INTO FI_VAT_REPORT_FILE_GT
        ( SEQ_NUM
        , SOURCE_FILE
        , SOB_ID
        , REPORT_FILE
        ) VALUES
        ( V_SEQ_NUM
        , V_SOURCE_FILE
        , W_SOB_ID
        , R1.RECORD_FILE
        );    
      END LOOP R1;
    END LOOP C1;
    
    --> �ſ�ī�������ǥ�� ������� <--
    V_SEQ_NUM := 80;     
    V_SOURCE_FILE := 'CREDITCARD'; 
    FOR C1 IN ( SELECT RPAD('HL', 2, ' ') ||  -- �ڷᱸ��
                       RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYY'), 4, ' ') || -- �ͼӳ⵵.
                       RPAD(CASE 
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '04', '05', '06') THEN '1'
                               ELSE '2'
                             END, 1, ' ') || --�ݱⱸ��.
                       RPAD(CASE 
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '07') THEN '1'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('02', '08') THEN '2'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('03', '09') THEN '3'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '10') THEN '4'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('05', '11') THEN '5'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('06', '12') THEN '6'
                             END, 1, ' ') || -- �ݱ⳻������.
                       RPAD(REPLACE(NVL(BM.VAT_NUM, ' '), '-', ''), 10, ' ') || -- ����ڹ�ȣ
                       RPAD(NVL(CM.CORPORATE_NAME, ' '), 60, ' ') ||     -- ��ȣ.
                       RPAD(NVL(BM.PRESIDENT_NAME, ' '), 30, ' ') ||     -- ��ǥ�ڸ�.
                       RPAD(REPLACE(NVL(CM.LEGAL_NUM, ' '), '-', ''), 13, ' ') ||     -- �ֹ�(����)��ȣ.
                       RPAD(TO_CHAR(P_WRITE_DATE, 'YYYYMMDD'), 8, ' ') || -- ��������.
                       RPAD(' ', 11, ' ') AS RECORD_FILE
                     , BM.VAT_NUM
                  FROM FI_VAT_DECLARATION VD
                    , FI_BUSINESS_MASTER BM 
                    , FI_CORPORATE_MASTER CM
                WHERE VD.TAX_CODE                 = BM.BUSINESS_CODE
                  AND VD.SOB_ID                   = BM.SOB_ID
                  AND BM.CORPORATE_ID             = CM.CORPORATE_ID
                  AND BM.SOB_ID                   = CM.SOB_ID
                  AND VD.TAX_CODE                 = W_TAX_CODE
                  AND VD.SOB_ID                   = W_SOB_ID
                  AND VD.ISSUE_DATE_FR            = W_ISSUE_DATE_FR
                  AND VD.ISSUE_DATE_TO            = W_ISSUE_DATE_TO
                )
    LOOP
      DBMS_OUTPUT.PUT_LINE(C1.RECORD_FILE);
      INSERT INTO FI_VAT_REPORT_FILE_GT
      ( SEQ_NUM
      , SOURCE_FILE
      , SOB_ID
      , REPORT_FILE
      ) VALUES
      ( V_SEQ_NUM
      , V_SOURCE_FILE
      , W_SOB_ID
      , C1.RECORD_FILE
      );
      -- 30.2.�����.
      V_SEQ_NUM := 80.1;
      V_SOURCE_FILE := 'CREDITCARD';
      V_RECORD_COUNT := 0;
      FOR R1 IN(SELECT RPAD('DL', 2, ' ') || 
                       RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYY'), 4, ' ') || -- �ͼӳ⵵.
                       RPAD(CASE 
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '04', '05', '06') THEN '1'
                               ELSE '2'
                             END, 1, ' ') || --�ݱⱸ��.
                       RPAD(CASE 
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '07') THEN '1'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('02', '08') THEN '2'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('03', '09') THEN '3'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '10') THEN '4'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('05', '11') THEN '5'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('06', '12') THEN '6'
                             END, 1, ' ') || -- �ݱ⳻������.
                        RPAD(REPLACE(NVL(C1.VAT_NUM, ' '), '-', ''), 10, ' ') || -- ����ڵ�Ϲ�ȣ.
                        RPAD('1', 1, '0') || -- ī�屸��.
                        RPAD(REPLACE(NVL(SX1.CARD_NUM, ' '), '-', ''), 20, ' ') || -- ī���ȣ.
                        RPAD(REPLACE(NVL(SX1.TAX_REG_NO, ' '), '-', ''), 10, ' ') || -- ������ ����ڹ�ȣ.
                        LPAD(NVL(SX1.VAT_COUNT, 0), 9, '0') || -- �ŷ��Ǽ�.
                        RPAD(CASE WHEN NVL(SX1.GL_AMOUNT, 0) >= 0 THEN ' ' ELSE '-' END, 1, ' ') || --����.
                        LPAD(NVL(SX1.GL_AMOUNT, 0), 13, '0') || -- ���ް���.
                        RPAD(CASE WHEN NVL(SX1.VAT_AMOUNT, 0) >= 0 THEN ' ' ELSE '-' END, 1, ' ') || --����.
                        LPAD(NVL(SX1.VAT_AMOUNT, 0), 13, '0') || -- ����.
                        RPAD(' ', 54, ' ') AS RECORD_FILE
                      , ROWNUM AS ROW_NUM
                FROM (SELECT CC.CARD_NUM
                            , SC.TAX_REG_NO
                            , SUM(VM.VAT_COUNT) AS VAT_COUNT
                            , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                            , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT                     
                       FROM FI_VAT_MASTER VM
                          , FI_SUPP_CUST_V SC
                          , FI_CREDIT_CARD CC
                      WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID
                        AND VM.SOB_ID                   = SC.SOB_ID
                        AND VM.CREDITCARD_CODE          = CC.CARD_CODE(+)
                        AND VM.SOB_ID                   = CC.SOB_ID(+)
                        AND VM.VAT_GUBUN                = '1'         -- ����.
                        AND VM.TAX_CODE                 = W_TAX_CODE
                        AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                        AND VM.SOB_ID                   = W_SOB_ID
                        AND VM.VAT_TYPE                 = '3'
                      GROUP BY CC.CARD_NUM
                            , SC.TAX_REG_NO
                      ) SX1
               )
      LOOP
        V_RECORD_COUNT := NVL(V_RECORD_COUNT, 0) + 1;
        DBMS_OUTPUT.PUT_LINE(R1.RECORD_FILE);
        INSERT INTO FI_VAT_REPORT_FILE_GT
        ( SEQ_NUM
        , SOURCE_FILE
        , SOB_ID
        , REPORT_FILE
        ) VALUES
        ( V_SEQ_NUM
        , V_SOURCE_FILE
        , W_SOB_ID
        , R1.RECORD_FILE
        );    
      END LOOP R1;
      -- 40.3.�հ�.
      V_SEQ_NUM := 80.2;
      V_SOURCE_FILE := 'CREDITCARD';
      FOR R1 IN( SELECT RPAD('TL', 2, ' ') || 
                       RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYY'), 4, ' ') || -- �ͼӳ⵵.
                       RPAD(CASE 
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '04', '05', '06') THEN '1'
                               ELSE '2'
                             END, 1, ' ') || --�ݱⱸ��.
                       RPAD(CASE 
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '07') THEN '1'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('02', '08') THEN '2'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('03', '09') THEN '3'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '10') THEN '4'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('05', '11') THEN '5'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('06', '12') THEN '6'
                             END, 1, ' ') || -- �ݱ⳻������.
                        RPAD(REPLACE(NVL(C1.VAT_NUM, ' '), '-', ''), 10, ' ') || -- ����ڵ�Ϲ�ȣ.
                        LPAD(NVL(V_RECORD_COUNT, 0), 7, '0') || -- DATA�Ǽ�.
                        LPAD(NVL(SX1.VAT_COUNT, 0), 9, '0') || -- �ŷ��Ǽ�(������� �ڷ��).
                        RPAD(CASE WHEN NVL(SX1.GL_AMOUNT, 0) >= 0 THEN ' ' ELSE '-' END, 1, ' ') || --����.
                        LPAD(NVL(SX1.GL_AMOUNT, 0), 15, '0') || -- ���ް���.
                        RPAD(CASE WHEN NVL(SX1.VAT_AMOUNT, 0) >= 0 THEN ' ' ELSE '-' END, 1, ' ') || --����.
                        LPAD(NVL(SX1.VAT_AMOUNT, 0), 15, '0') || -- ����.
                        RPAD(' ', 74, ' ') AS RECORD_FILE
                      , ROWNUM AS ROW_NUM
                FROM (SELECT SUM(VM.VAT_COUNT) AS VAT_COUNT
                            , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                            , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT                     
                       FROM FI_VAT_MASTER VM
                          , FI_SUPP_CUST_V SC
                          , FI_CREDIT_CARD CC
                      WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID
                        AND VM.SOB_ID                   = SC.SOB_ID
                        AND VM.CREDITCARD_CODE          = CC.CARD_CODE(+)
                        AND VM.SOB_ID                   = CC.SOB_ID(+)
                        AND VM.VAT_GUBUN                = '1'         -- ����.
                        AND VM.TAX_CODE                 = W_TAX_CODE
                        AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                        AND VM.SOB_ID                   = W_SOB_ID
                        AND VM.VAT_TYPE                 = '3'
                      ) SX1
               )
      LOOP
        DBMS_OUTPUT.PUT_LINE(R1.RECORD_FILE);
        INSERT INTO FI_VAT_REPORT_FILE_GT
        ( SEQ_NUM
        , SOURCE_FILE
        , SOB_ID
        , REPORT_FILE
        ) VALUES
        ( V_SEQ_NUM
        , V_SOURCE_FILE
        , W_SOB_ID
        , R1.RECORD_FILE
        );    
      END LOOP R1;
    END LOOP C1;
    
  END SET_REPORT_FILE;

END FI_VAT_REPORT_FILE_G;
/
