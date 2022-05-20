CREATE OR REPLACE PACKAGE FI_VAT_REPORT_FILE_G
AS
            
-- VAT 부가세 전자신고 파일 생성 조회.
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

-- VAT 부가세 전자신고 파일 생성.
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
/* Description  : 부가세 신고 - 전자파일생성.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- VAT 부가세 전자신고 파일 생성 조회.
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
    
    -- 전자파일 생성 --
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
  
-- VAT 부가세 전자신고 파일 생성.
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
    V_VAT_PERIOD                  VARCHAR2(10);  -- 1.과세기간.
    V_BUSINESS_TYPE               VARCHAR2(50);  -- 업태.
    V_BUSINESS_ITEM               VARCHAR2(50);  -- 업종.
    
    V_TS_BUSINESS_TYPE            VARCHAR2(50);  -- 과세표준 업태.
    V_TS_BUSINESS_ITEM            VARCHAR2(50);  -- 과세표준 업종.
    V_TS_BUSINESS_ITEM_CODE       FI_VAT_TAX_STANDARD.BUSINESS_ITEM_CODE%TYPE;  -- 과세표준 업종코드.
    
    V_TAX_IMPORT_AMT              NUMBER;  -- 2.30.과세수입금액합계.
    V_EXC_TAX_IMPORT_AMT          NUMBER;  -- 2.29.과세수입금액제외금액 
    V_BANK_CODE                   FI_BUSINESS_MASTER.BANK_CODE%TYPE;  -- 80.은행코드.
    V_BANK_ACCOUNT_NUM            VARCHAR2(50);  -- 81.계좌번호.
    V_BANK_SITE_NAME              VARCHAR2(30);  -- 83.은행지점명.
  BEGIN
    -- 업종코드.
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
    
    -- 1. 부가세 신고서 HEADER 레코드.
    V_SEQ_NUM := 10;
    V_SOURCE_FILE := 'MASTER';
    -- 1.7 과세기간_년기(월).
    IF TO_CHAR(W_ISSUE_DATE_FR, 'MM') >= '01' AND TO_CHAR(W_ISSUE_DATE_FR, 'MM') <= '06' AND 
       TO_CHAR(W_ISSUE_DATE_TO, 'MM') >= '01' AND TO_CHAR(W_ISSUE_DATE_TO, 'MM') <= '06' THEN
     V_VAT_PERIOD := TO_CHAR(W_ISSUE_DATE_FR, 'YYYY') || '01';
    ELSE 
      V_VAT_PERIOD := TO_CHAR(W_ISSUE_DATE_FR, 'YYYY') || '02';
    END IF;
    FOR C1 IN ( SELECT RPAD('11', 2, ' ') ||  -- 자료구분(11-일반, 12-간이)
                       RPAD('V101', 4, ' ') ||   -- 서식코드(V101-일반사업자, V102-간이사업자)
                       RPAD(REPLACE(NVL(BM.VAT_NUM, ' '), '-', ''), 13, ' ') ||
                       RPAD('41', 2, ' ') ||     -- 세목구분(41-부가가치세).
                       RPAD(CASE 
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '07', '08', '09') THEN '3'  -- 예정신고.
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '05', '06', '10', '11', '12') THEN '1'  -- 확정신고.
                             END, 1, ' ') ||
                       RPAD('8', 1, ' ') ||  -- 납세자구분(1-개인, 8-법인)
                       REPLACE(V_VAT_PERIOD, 6, ' ') ||    -- 과세기간.
                       LPAD(CASE 
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '07') THEN '1'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('02', '08') THEN '2'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('03', '09') THEN '3'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '10') THEN '4'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('05', '11') THEN '5'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('06', '12') THEN '6'
                             END, 4, '0') ||    -- 신고차수.
                       LPAD('1', 4, '0') ||    -- 순차번호.
                       RPAD(NVL(CM.HOMETAX_ID, ' '), 20, ' ') ||    -- 홈텍스ID.
                       RPAD(REPLACE(NVL(CM.LEGAL_NUM, ' '), '-', ''), 13, ' ') ||    -- 납세자번호 : 법인(주민)등록번호.
                       RPAD(' ', 30, ' ') ||    -- 세무대리인성명.
                       RPAD(' ', 6, ' ') ||     -- 세무대리인관리번호.
                       RPAD(' ', 4, ' ') ||     -- 세무대리인전화번호1.
                       RPAD(' ', 5, ' ') ||     -- 세무대리인전화번호2.
                       RPAD(' ', 5, ' ') ||     -- 세무대리인전화번호3.
                       RPAD(NVL(CM.CORPORATE_NAME, ' '), 30, ' ') ||     -- 상호.
                       RPAD(NVL(BM.PRESIDENT_NAME, ' '), 30, ' ') ||     -- 대표자명.
                       RPAD(NVL(BM.ADDR1, ' ') || ' ' || NVL(BM.ADDR2, ' '), 70, ' ') ||     -- 소재지.
                       RPAD(NVL(BM.TEL_NUM, ' '), 14, ' ')||     -- 전화번호.
                       RPAD(NVL(BM.ADDR1, ' ') || ' ' || NVL(BM.ADDR2, ' '), 70, ' ') ||     -- 소재지.
                       RPAD(NVL(BM.TEL_NUM, ' '), 14, ' ') ||     -- 전화번호.
                       RPAD(NVL(BM.BUSINESS_TYPE, ' '), 30, ' ') ||     -- 업태.
                       RPAD(NVL(BM.BUSINESS_ITEM, ' '), 50, ' ') ||     -- 업종.
                       RPAD(V_TS_BUSINESS_ITEM_CODE, 7, ' ') ||    -- 업종코드.
                       RPAD(TO_CHAR(W_ISSUE_DATE_FR, 'YYYYMMDD'), 8, ' ') ||    -- 과세기간(시작일).
                       RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMMDD'), 8, ' ') ||    -- 과세기간(종료일).
                       RPAD(TO_CHAR(P_WRITE_DATE, 'YYYYMMDD'), 8, ' ') ||    -- 작성일자.
                       RPAD('20000101', 8, ' ') ||    -- 개업년월일.
                       RPAD('N', 1, ' ') ||    -- 보정신고구분.
                       RPAD(' ', 14, ' ') ||    -- 사업자휴대전화.
                       RPAD('9000', 4, ' ') ||    -- 세무프로그램코드(기타 : 9000).
                       RPAD(' ', 10, ' ') ||    -- 세무대리인사업자번호.
                       RPAD(NVL(BM.EMAIL, ' '), 50, ' ') ||    -- 이메일주소.
                       RPAD('100', 3, ' ') ||     -- 신고종류구분.
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
    -- 2. 신고서 레코드.
    -- 2.30 과세수입금액합계.
    BEGIN
      SELECT SUM(TS.TAX_AMOUNT) AS TAX_AMOUNT
        INTO V_TAX_IMPORT_AMT
        FROM FI_VAT_TAX_STANDARD TS
      WHERE TS.SOB_ID                   = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_TAX_IMPORT_AMT := 0;
    END;
    -- 2.29 과세수입금액합계.
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
    FOR C1 IN ( SELECT RPAD('17', 2, ' ') || -- 자료구분 : 17.
                       RPAD('V101', 4, ' ') ||  -- 서식코드 : 부가가치 일반서식
                       LPAD(REPLACE(LPAD(NVL(VD.S_TAX_INVOICE_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 3.과표신고과세세금계산서금액.
                       LPAD(REPLACE(LPAD(NVL(VD.S_TAX_INVOICE_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 4.세액
                       LPAD(REPLACE(LPAD(NVL(VD.S_TAX_ETC_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 5.과표신고과세기타금액.
                       LPAD(REPLACE(LPAD(NVL(VD.S_TAX_ETC_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 6.세액.
                       LPAD(REPLACE(LPAD(NVL(VD.S_ZERO_INVOICE_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 7.과표신고영세세금계산서.
                       LPAD(REPLACE(LPAD(NVL(VD.S_ZERO_ETC_AMT, 0), 13, '0'), '-', ''), 13, '-') ||  -- 8.과표신고영세기타.
                       LPAD(REPLACE(LPAD(NVL(VDA.SS_TAX_INVOICE_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 9.과표예정과세세금계산서금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.SS_TAX_INVOICE_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 10.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.SS_TAX_ETC_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 11.과표예정과세기타금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.SS_TAX_ETC_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 12.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.SS_ZERO_INVOICE_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 13.과표예정과세영세세금계산서금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.SS_ZERO_ETC_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 14. 과표예정과세영세기타금액.
                       LPAD(REPLACE(LPAD(NVL(VD.S_BAD_DEBT_TAX_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 15.대손세액가감세액.
                       LPAD(REPLACE(LPAD(NVL(VD.P_TAX_INVOICE_AMT, 0), 15, '0'), '-', ''), 15, '-') ||  -- 16.매입교부일반매입.
                       LPAD(REPLACE(LPAD(NVL(VD.P_TAX_INVOICE_VAT, 0), 13, '0'), '-', ''), 13, '-') ||  -- 17.세액.
                       LPAD(REPLACE(LPAD(NVL(VD.P_TAX_ASSET_AMT, 0), 13, '0'), '-', ''), 13, '-') ||  -- 18.매입교부고정자산매입.
                       LPAD(REPLACE(LPAD(NVL(VD.P_TAX_ASSET_VAT, 0), 13, '0'), '-', ''), 13, '-') ||  -- 19.매입교부고정자산매입.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_CREDIT_AMT, 0), 13, '0'), '-', ''), 13, '-') ||  -- 20.매입금전신용금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_CREDIT_VAT, 0), 13, '0'), '-', ''), 13, '-') ||  -- 21.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_DEEMED_IP_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 22.의제매입금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_DEEMED_IP_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 23.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_RECYCLE_IP_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 24.매입재활용.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_RECYCLE_IP_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 25.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_STOCK_IP_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 26.재고매입세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_BAD_TAX_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 27.대손변제새액.
                       LPAD(REPLACE(LPAD(NVL(VD.PURCHASE_SUM_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 28.매입금액합계.
                       LPAD(REPLACE(LPAD(NVL(VD.PURCHASE_SUM_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 29.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.N_COMMON_IP_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 30.공통매입면세사업금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.N_COMMON_IP_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 31.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.N_NOT_DED_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 32.불공제매입금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.N_NOT_DED_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 33.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.N_BAD_RECEIVE_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 34.대손처분세액.
                       LPAD(REPLACE(LPAD(NVL(VD.PURCHASE_SUM_AMT, 0) - NVL(VD.P_NOT_DED_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 35.차감매입금액.
                       LPAD(REPLACE(LPAD(NVL(VD.PURCHASE_SUM_VAT, 0) - NVL(VD.P_NOT_DED_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 36.세액.
                       LPAD(REPLACE(LPAD(NVL(VD.CALCULATE_TAX_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 37.납부(환급)세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_VAT_NUM_UNENROLL_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 38.사업자등록가산금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_VAT_NUM_UNENROLL_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 39.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_TAX_INV_SUM_BAD_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 40.세금계산서합계표가산금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_TAX_INV_SUM_BAD_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 41.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_REPORT_BAD_AMT, 0), 13, '0'), '-', ''), 13, '-') ||  -- 42.신고불성실가산금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_REPORT_BAD_VAT, 0), 13, '0'), '-', ''), 13, '-') ||  -- 43.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_ZERO_REPORT_BAD_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 44.영세율신고가산금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_ZERO_REPORT_BAD_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 45.세액.
                       LPAD(REPLACE(LPAD(NVL(VD.R_CREDIT_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 46.금전신용공제금액.
                       LPAD(REPLACE(LPAD(NVL(VD.R_CREDIT_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 47.세액.
                       LPAD(REPLACE(LPAD(NVL(VD.SCHEDULE_NOTICE_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 48.예정고지세액.
                       LPAD(REPLACE(LPAD(NVL(VD.SCHEDULE_YET_REFUND_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 49.예정미환급세액.
                       LPAD(REPLACE(LPAD(NVL(V_TAX_IMPORT_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 50.과세수입금액합계.
                       LPAD(REPLACE(LPAD(NVL(V_EXC_TAX_IMPORT_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 51.과세수입금액제외금액.
                       LPAD(REPLACE(LPAD(NVL(0, 0), 15, '0'), '-', ''), 15, '-') || -- 52.면세수입금액합계.
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
                            END, 1, ' ') ||  -- 53.환급구분 : (-)일 경우만 작성.
                       LPAD(REPLACE(LPAD(NVL(VDA.R_TAXI_TRANSPORT_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 54.택시사업자부가가치세경감.
                       LPAD(REPLACE(LPAD(NVL(VD.S_SCHEDULE_OMIT_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 55.과표예정신고누락분공제.
                       LPAD(REPLACE(LPAD(NVL(VD.S_SCHEDULE_OMIT_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 56.세액.
                       LPAD(REPLACE(LPAD(NVL(VD.S_BAD_DEBT_TAX_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 57.대손세액가감금액.
                       LPAD(REPLACE(LPAD(NVL(VD.P_ETC_DED_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 58.매입세액기타공제-14
                       LPAD(REPLACE(LPAD(NVL(VD.P_ETC_DED_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 59.세액.
                       LPAD(REPLACE(LPAD(NVL(VD.P_NOT_DED_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 60.매입공제받지못할금액.
                       LPAD(REPLACE(LPAD(NVL(VD.P_NOT_DED_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 61.세액.
                       LPAD(REPLACE(LPAD(NVL(VD.TAX_ADDITION_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 62.가산세계.
                       LPAD(REPLACE(LPAD(NVL(VDA.S_SALES_SUM_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 63.과표예정신고누락분금액합계 
                       LPAD(REPLACE(LPAD(NVL(VDA.S_SALES_SUM_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 64.세액
                       LPAD(REPLACE(LPAD(NVL(VDA.ETC_DED_IP_SUM_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 65.기타공제매입금액합계.
                       LPAD(REPLACE(LPAD(NVL(VDA.ETC_DED_IP_SUM_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 66.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.N_BAD_RECEIVE_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 67.대손처분금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.NOT_DED_SUM_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 68.매입공제받지못할금액 합계.
                       LPAD(REPLACE(LPAD(NVL(VDA.NOT_DED_SUM_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 69.세액
                       LPAD(REPLACE(LPAD(NVL(VDA.TAX_ADDITION_SUM_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 70.가산세게액.
                       LPAD(REPLACE(LPAD(NVL(VD.R_ETC_DED_VAT, 0) + NVL(VD.R_CREDIT_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 71. 경감세액계.
                       LPAD(0, 13, '0') || -- 72.성실신고사업자경감세액.
                       LPAD(0, 13, '0') || -- 73. POS 도입 사업자등에 대한 경감세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_PAYMENT_BAD_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 74.납부불성실가산금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_PAYMENT_BAD_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 75.세액.
                       LPAD(0, 15, '0') || -- 76.일반과세전환자 공제세액.
                       LPAD(REPLACE(LPAD(NVL(VD.R_ETC_DED_VAT, 0), 15, '0'), '-', ''), 15, '-') || -- 77.기타공제 경감세액.
                       LPAD(REPLACE(LPAD(NVL(VD.SALES_SUM_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 78.과세표준.
                       LPAD(REPLACE(LPAD(NVL(VD.BALANCE_TAX_VAT, 0), 15, '0'), '-', ''), 15, '-') || -- 79.차감납부할세액.
                       RPAD('0' || NVL(V_BANK_CODE, ' '), 3, ' ') || -- 80.은행코드드.
                       RPAD(REPLACE(NVL(V_BANK_ACCOUNT_NUM, ' '), '-', ''), 20, ' ') || -- 81.계좌번호.
                       RPAD(' ', 7, ' ') || -- 82.총괄납부승인번호 
                       RPAD(NVL(V_BANK_SITE_NAME, ' '), 30, ' ') || -- 83.은행지점명.
                       LPAD(REPLACE(LPAD(NVL(VD.SALES_SUM_VAT, 0), 15, '0'), '-', ''), 15, '-') || -- 84.산출세액.
                       RPAD(' ', 8, ' ') || -- 85.폐업일자.
                       RPAD(' ', 3, ' ') || -- 86.폐업사유.
                       RPAD('N', 1, ' ') || -- 87.기한후(과세표준) 여부.
                       LPAD(REPLACE(LPAD(NVL(VDA.BILL_ISSUE_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 88.계산서교부금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.BILL_RECEIPT_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 89.계산서수취금액.
                       LPAD(REPLACE(LPAD(NVL(VD.P_SCHEDULE_OMIT_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 90.매입예정신고누락금액.
                       LPAD(REPLACE(LPAD(NVL(VD.P_SCHEDULE_OMIT_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 91.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.SP_TAX_INVOICE_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 92.예정매입세액금산서누락금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.SP_TAX_INVOICE_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 93.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.SP_ETC_DED_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 94.예정매입기타공제누락세액금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.SP_ETC_DED_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 95.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.S_PURCHASE_SUM_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 96.예정매입누락합계금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.S_PURCHASE_SUM_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 97.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.R_ETC_DED_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 98.기타경감공제세액명세기타세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.R_ETAX_REPORT_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 99.전자신고공제세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.R_CASH_BILL_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 100.현금영수증사업자공제세액.
                       LPAD(REPLACE(LPAD(NVL(VD.BALANCE_TAX_VAT, 0), 15, '0'), '-', ''), 15, '-') || -- 101.실차감납부할세액.
                       RPAD(CASE
                              WHEN P_TAX_PAYER_TYPE = '1' THEN '0'
                              ELSE P_TAX_PAYER_TYPE
                            END, 1, ' ') || -- 102.일반과세자구분.
                       RPAD('0', 1, ' ') || -- 103.조기환급취소구분.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_TAX_BUSINESS_IP_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 104.과세사업자전환매입세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_CASH_SALES_UNREPORT_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 105.현금매출명세서미제출가산금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_CASH_SALES_UNREPORT_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 106.세액.
                       LPAD(REPLACE(LPAD(NVL(VD.S_TAX_BUYER_INVOICE_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 107.과표신고과세매입자발행금액.
                       LPAD(REPLACE(LPAD(NVL(VD.S_TAX_BUYER_INVOICE_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 108.과표신고과세매입자발행세액.
                       LPAD(REPLACE(LPAD(NVL(VD.P_BUYER_INVOICE_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 109.매입매입자발행금액.
                       LPAD(REPLACE(LPAD(NVL(VD.P_BUYER_INVOICE_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 110.매입매입자발행세액.
                       LPAD(REPLACE(LPAD(NVL(VD.GOLD_BAR_BUYER_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 111.금지금매입자납부특례기납부세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_GOLD_BAR_IP_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 112.매입고금의제매입금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_GOLD_BAR_IP_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 113.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_TAX_INVOICE_UNISSUE_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 114.세금계산서미발급등가산금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_TAX_INVOICE_UNISSUE_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 115.세금계산서미발급등가산세액.
                       LPAD(REPLACE(LPAD(NVL(VD.S_TAX_CREDIT_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 116.과표신고신용카드현금영수증금액.
                       LPAD(REPLACE(LPAD(NVL(VD.S_TAX_CREDIT_VAT, 0), 15, '0'), '-', ''), 15, '-') || -- 117.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_CREDIT_ASSET_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 118.매입신용고정자산금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.E_CREDIT_ASSET_VAT, 0), 15, '0'), '-', ''), 15, '-') || -- 119.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.R_ETAX_ISSUE_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 120.전자세금계산서교부세액공제세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_ETAX_UNSEND_IN_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 121.전자세금계산서미전송가산금액_과세기간내.                                              
                       LPAD(REPLACE(LPAD(NVL(VDA.A_ETAX_UNSEND_IN_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 122.세액.
                       LPAD(0, 13, '0') || -- 123.면세수입금액제외금액.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_ETAX_UNSEND_OVER_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 124.전자세금계산서미전송가산금액_과세기간후.                                              
                       LPAD(REPLACE(LPAD(NVL(VDA.A_ETAX_UNSEND_OVER_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 125.세액.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_TAX_INVOICE_DELAY_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 126.전자세금계산서지연발급등가산금.
                       LPAD(REPLACE(LPAD(NVL(VDA.A_TAX_INVOICE_DELAY_VAT, 0), 13, '0'), '-', ''), 13, '-') || -- 127.세액.
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
    
    -- 4. 부가가치세수입금액등(과세표준 면세수입금액).
    V_SEQ_NUM := 21;
    V_SOURCE_FILE := 'TAX_STANDARD';
    FOR C1 IN ( SELECT RPAD('15', 2, ' ') || -- 자료구분 : 15-정기부가가치세 수입금액.
                       RPAD('V101', 4, ' ') || -- 서식코드.(V101:일반, V102:간이)
                       RPAD(CASE
                              WHEN TS.TAX_STANDARD_CODE IN('26', '27', '28') AND NVL(TS.TAX_AMOUNT, 0) > 0 THEN '1'
                              WHEN TS.TAX_STANDARD_CODE IN('29') AND NVL(TS.TAX_AMOUNT, 0) > 0 THEN '2'
                              -- 추후 추가.
                            END, 1, ' ') || -- 수입금액종류구분.
                       RPAD(NVL(DECODE(TS.TAX_STANDARD_CODE, '29', V_TS_BUSINESS_TYPE, TS.BUSINESS_TYPE), ' '), 30, ' ') || -- 업태.
                       RPAD(NVL(DECODE(TS.TAX_STANDARD_CODE, '29', V_TS_BUSINESS_ITEM, TS.BUSINESS_ITEM), ' '), 50, ' ') || -- 종목명.
                       RPAD(NVL(DECODE(TS.TAX_STANDARD_CODE, '29', V_TS_BUSINESS_ITEM_CODE, TS.BUSINESS_ITEM_CODE), ' '), 7, ' ') || --업종코드.
                       LPAD(REPLACE(LPAD(NVL(TS.TAX_AMOUNT, 0), 15, '0'), '-', ''), 15, '-') || -- 수입금액.
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
----> 첨부서류 생성 <----    
    -- 7. 부동산임대공급가액명세서.
    V_SEQ_NUM := 31;
    V_SOURCE_FILE := 'REALTY';
    FOR C1 IN ( SELECT RPAD('17', 2, ' ') || -- 자료구분(17).
                       RPAD('V120', 4, ' ') || -- 서식코드.
                       LPAD(ROWNUM, 6, '0') || -- 일련번호.
                       RPAD(NVL(BM.ADDR1, ' ') || ' ' || NVL(BM.ADDR2, ' '), 70, ' ') || -- 소재지.
                       LPAD(REPLACE(LPAD(NVL(SX1.DEPOSIT_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 임대계약내용보증금합계.
                       LPAD(REPLACE(LPAD(NVL(SX1.MONTHLY_RENT_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 임대계약내용월세등합계.
                       LPAD(REPLACE(LPAD(NVL(SX1.LEASE_TOTAL_AMT, 0), 15, '0'), '-', ''), 15, '-') || -- 임대계약내용보증금합계.
                       LPAD(REPLACE(LPAD(NVL(SX1.LEASE_DEPOSIT_INTEREST_AMT, 0), 15, 0), '-', ''), 15, '-') || -- 임대료수입보증금이자합계.
                       LPAD(REPLACE(LPAD(NVL(SX1.LEASE_MONTHLY_RENT_AMT, 0), 15, 0), '-', ''), 15, '-') || -- 임대료수입월세등합계.
                       RPAD(REPLACE(NVL(BM.VAT_NUM, ' '), '-', ''), 10, ' ') || -- 임대인사업자등록번호.
                       LPAD(NVL(SX1.LEASE_COUNT, 0), 6, '0') || -- 임대건수.
                       LPAD('0', 4, '0') || -- 종사업자일련번호.
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
      -- 7.1 부동산임대공급가액 세부내용.
      V_SEQ_NUM := V_SEQ_NUM + 0.01;
      V_SOURCE_FILE := 'REALTY';
      FOR R1 IN ( SELECT RPAD('18', 2, ' ') || -- 자료구분(18)  
                         RPAD('V120', 4, ' ') || -- 서식코드.
                         LPAD(C1.ROW_SEQ, 6, '0') || -- 명세서 일련번호
                         LPAD(ROWNUM, 6, '0') || -- 일련번호.
                         RPAD(NVL(RL.FLOOR_COUNT, ' '), 10, ' ') || -- 층.
                         RPAD(NVL(RL.ROOM_NO, ' '), 10, ' ') || -- 호수.
                         RPAD(NVL(RL.AREA_M2, 0), 10, ' ') || -- 면적.
                         RPAD(NVL(SC.SUPP_CUST_NAME, ' '), 30, ' ') || -- 상호.
                         RPAD(REPLACE(NVL(SC.TAX_REG_NO, ' '), '-', ''), 13, ' ') || --임차인사업자번호.
                         RPAD(CASE
                                 WHEN RL.USE_DATE_FR BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO THEN TO_CHAR(RL.USE_DATE_FR, 'YYYYMMDD')
                                 ELSE ' '
                               END, 8, ' ') || -- 임대계약입주일.
                         RPAD(CASE
                                 WHEN RL.USE_DATE_TO BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO THEN TO_CHAR(RL.USE_DATE_TO, 'YYYYMMDD')
                                 ELSE ' '
                               END, 8, ' ') || -- 임대계약퇴거일.
                         LPAD(REPLACE(LPAD(NVL(RL.DEPOSIT_AMOUNT, 0), 13, '0'), '-', ''), 13, '-') ||-- 임대계약내용보증금.
                         LPAD(REPLACE(LPAD(NVL(RL.MONTHLY_RENT_AMOUNT, 0), 13, '0'), '-', ''), 13, '-') || -- 임대계약내용월세.
                         LPAD(REPLACE(LPAD(NVL(RLH.DEPOSIT_INTEREST_AMT, 0) + NVL(RLH.MONTHLY_RENT_SUM_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 임대료수입금액계.
                         LPAD(REPLACE(LPAD(NVL(RLH.DEPOSIT_INTEREST_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 임대료보증금이자.
                         LPAD(REPLACE(LPAD(NVL(RLH.MONTHLY_RENT_SUM_AMT, 0), 13, '0'), '-', ''), 13, '-') || -- 임대료수입금액월임대료.
                         RPAD(CASE 
                                WHEN RL.FLOOR_TYPE = '10' THEN 'N'
                                ELSE 'Y'
                              END, 1, ' ') || -- 지상/지하.
                         RPAD('0', 4, '0') || -- 종사업자일련번호.
                         RPAD(NVL(RL.HOUSE_NUM, ' '), 30, ' ') || -- 동.
                         RPAD(' ', 8, ' ') || -- 갱신일.
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
    
    -- 11. 건물등감가상각자산취득명세서.
    V_SEQ_NUM := 41;
    V_SOURCE_FILE := 'ASSET';
    FOR C1 IN ( SELECT RPAD('17', 2, ' ') || -- 자료구분 : 17-정기부가가치세 수입금액.
                       RPAD('V149', 4, ' ') || -- 서식코드.(V149:일반, V102:간이)
                       LPAD(NVL(SX1.ASSET_COUNT, 0), 11, '0') || -- 건수합계.
                       LPAD(REPLACE(LPAD(NVL(SX1.GL_AMOUNT, 0), 13, '0'), '-', ''), 13, '-') || -- 공급가액합계.
                       LPAD(REPLACE(LPAD(NVL(SX1.VAT_AMOUNT, 0), 13, '0'), '-', ''), 13, '-') || -- 세액합계.
                       LPAD(NVL(SX1.COUNT_1, 0), 11, '0') || -- 건물구축물수.
                       LPAD(REPLACE(LPAD(NVL(SX1.GL_AMOUNT_1, 0), 13, '0'), '-', ''), 13, '-') ||-- 건물 구축물.
                       LPAD(REPLACE(LPAD(NVL(SX1.VAT_AMOUNT_1, 0), 13, '0'), '-', ''), 13, '-') || 
                       LPAD(NVL(SX1.COUNT_2, 0), 11, '0') || -- 기계장치수.
                       LPAD(REPLACE(LPAD(NVL(SX1.GL_AMOUNT_2, 0), 13, '0'), '-', ''), 13, '-') ||-- 기계장치.
                       LPAD(REPLACE(LPAD(NVL(SX1.VAT_AMOUNT_2, 0), 13, '0'), '-', ''), 13, '-') ||
                       LPAD(NVL(SX1.COUNT_3, 0), 11, '0') || -- 차량운반구수.
                       LPAD(REPLACE(LPAD(NVL(SX1.GL_AMOUNT_3, 0), 13, '0'), '-', ''), 13, '-') ||-- 차량운반구.
                       LPAD(REPLACE(LPAD(NVL(SX1.VAT_AMOUNT_3, 0), 13, '0'), '-', ''), 13, '-') ||
                       LPAD(NVL(SX1.COUNT_4, 0), 11, '0') || -- 기타수.
                       LPAD(REPLACE(LPAD(NVL(SX1.GL_AMOUNT_4, 0), 13, '0'), '-', ''), 13, '-') ||-- 기타물.
                       LPAD(REPLACE(LPAD(NVL(SX1.VAT_AMOUNT_4, 0), 13, '0'), '-', ''), 13, '-') ||
                       RPAD(' ', 9, ' ') AS RECORD_FILE
                  FROM ( SELECT COUNT(DA.DPR_ASSET_ID) AS ASSET_COUNT
                             , SUM(DA.GL_AMOUNT) AS GL_AMOUNT
                             , SUM(DA.VAT_AMOUNT) AS VAT_AMOUNT
                             , SUM(DECODE(DA.VAT_ASSET_GB, '1', 1, 0)) AS COUNT_1  -- 건물,구축물 수.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '1', NVL(DA.GL_AMOUNT, 0), 0)) AS GL_AMOUNT_1  -- 건물,구축물.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '1', NVL(DA.VAT_AMOUNT, 0), 0)) AS VAT_AMOUNT_1  -- 건물,구축물.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '2', 1, 0)) AS COUNT_2  -- 기계장치 수.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '2', NVL(DA.GL_AMOUNT, 0), 0)) AS GL_AMOUNT_2  -- 기계장치
                             , SUM(DECODE(DA.VAT_ASSET_GB, '2', NVL(DA.VAT_AMOUNT, 0), 0)) AS VAT_AMOUNT_2  -- 기계장치.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '3', 1, 0)) AS COUNT_3  -- 차량운반구 수.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '3', NVL(DA.GL_AMOUNT, 0), 0)) AS GL_AMOUNT_3  -- 차량운반구.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '3', NVL(DA.VAT_AMOUNT, 0), 0)) AS VAT_AMOUNT_3  -- 차량운반구.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '4', 1, 0)) AS COUNT_4  -- 기타.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '4', NVL(DA.GL_AMOUNT, 0), 0)) AS GL_AMOUNT_4  -- 기타.
                             , SUM(DECODE(DA.VAT_ASSET_GB, '4', NVL(DA.VAT_AMOUNT, 0), 0)) AS VAT_AMOUNT_4  -- 기타.
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
    -- 12. 공제받지못할매입세액명세서.
    V_SEQ_NUM := 51;
    V_SOURCE_FILE := 'NOT_TAX_DED';
    FOR C1 IN ( SELECT RPAD('17', 2, ' ') || -- 자료구분 
                       RPAD('V153', 4, ' ') || -- 서식코드.(V149:일반, V102:간이)
                       LPAD(NVL(SX1.BILL_COUNT, 0), 11, '0') || -- 건수합계.
                       LPAD(REPLACE(LPAD(NVL(SX1.GL_AMOUNT, 0), 15, '0'), '-', ''), 15, '-') || -- 공급가액합계.
                       LPAD(REPLACE(LPAD(NVL(SX1.VAT_AMOUNT, 0), 15, '0'), '-', ''), 15, '-') || -- 세액합계.
                       LPAD(0, 15, '0') || -- 6.공통매입공급가액합계.
                       LPAD(0, 15, '0') || -- 7.
                       LPAD(0, 15, '0') || -- 8.
                       LPAD(0, 15, '0') || -- 9.
                       LPAD(0, 15, '0') || -- 10.
                       LPAD(0, 15, '0') || -- 11.
                       LPAD(0, 15, '0') || -- 12.
                       RPAD(' ', 48, ' ') AS RECORD_FILE
                  FROM (-- 매입세액불공제내역.
                        SELECT SUM(VM.VAT_COUNT) AS BILL_COUNT
                             , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                             , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
                          FROM FI_VAT_MASTER VM
                        WHERE VM.TAX_CODE           = W_TAX_CODE
                          AND VM.VAT_GUBUN          = '1'
                          AND VM.VAT_ISSUE_DATE     BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                          AND VM.VAT_TYPE           IN('8', '15')    -- 매입세액불공제.
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
      -- 12.1 공제받지못할매입세액명세서.
      V_SEQ_NUM := V_SEQ_NUM + 0.01;
      V_SOURCE_FILE := 'NOT_TAX_DED';
      FOR R1 IN ( SELECT RPAD('18', 2, ' ') || -- 자료구분(18)  
                         RPAD('V153', 4, ' ') || -- 서식코드.
                         RPAD(NVL(SX1.DED_NOT_CODE, ' '), 2, ' ') || -- 불공제사유구분.
                         LPAD(NVL(SX1.VAT_COUNT, 0), 11, '0') || -- 매수.
                         LPAD(REPLACE(LPAD(NVL(SX1.GL_AMOUNT, 0), 13, '0'), '-', ''), 13, '-') || -- 공급가액.
                         LPAD(REPLACE(LPAD(NVL(SX1.VAT_AMOUNT, 0), 13, '0'), '-', ''), 13, '-') || -- 세금계산서.
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
                               AND VM.VAT_TYPE           IN('8', '15')    -- 매입세액불공제.
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
    
    ---> 세금계산서 합계표 <---
    -- 22.1 표지.
    V_SEQ_NUM := 61;
    V_SOURCE_FILE := 'TAX_INVOICE_SUM';
    FOR C1 IN ( SELECT RPAD('7', 1, ' ') ||  -- 자료구분
                       RPAD(REPLACE(NVL(BM.VAT_NUM, ' '), '-', ''), 10, ' ') ||
                       RPAD(NVL(CM.CORPORATE_NAME, ' '), 30, ' ') ||     -- 상호.
                       RPAD(NVL(BM.PRESIDENT_NAME, ' '), 15, ' ') ||     -- 대표자명.
                       RPAD(NVL(BM.ADDR1, ' ') || ' ' || NVL(BM.ADDR2, ' '), 45, ' ') ||     -- 소재지.
                       RPAD(NVL(BM.BUSINESS_TYPE, ' '), 17, ' ') ||     -- 업태.
                       RPAD(NVL(BM.BUSINESS_ITEM, ' '), 25, ' ') ||     -- 업종.
                       RPAD(TO_CHAR(W_ISSUE_DATE_FR, 'YYMMDD') || TO_CHAR(W_ISSUE_DATE_TO, 'YYMMDD'), 12, ' ') ||    -- 거래기간.
                       RPAD(TO_CHAR(P_WRITE_DATE, 'YYMMDD'), 6, ' ') ||    -- 작성일자.
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
      -- 전자세금계산서 이외분 매출자료. 
      V_SEQ_NUM := 62;      
      FOR R1 IN ( SELECT '1' ||
                         RPAD(REPLACE(C1.VAT_NUM, '-', ''), 10, ' ') || -- 사업자번호.
                         LPAD(ROWNUM, 4, '0') || -- 일련번호.
                         RPAD(REPLACE(NVL(SX1.TAX_REG_NO, ' '), '-', ''), 10, ' ') || -- 거래자번호.
                         RPAD(NVL(SX1.CUSTOMER_DESC, ' '), 30, ' ') || -- 거래자번호.
                         RPAD(NVL(SX1.BUSINESS_CONDITION, ' '), 17, ' ') || -- 업태.
                         RPAD(NVL(SX1.BUSINESS_ITEM, ' '), 25, ' ') || -- 업종.
                         LPAD(NVL(SX1.VAT_COUNT, 0), 7, '0') || -- 세금계산서 매수.
                         RPAD('0', 2, '0') || -- 공란.
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
                              END, 14, '0') || -- 공급가액.
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
                              END, 13, '0') || -- 세액. 
                              LPAD(0, 1, '0') || -- 신고자주류코드.
                              LPAD(0, 1, '0') || -- 주류코드.
                              RPAD('7501', 4, '0') || -- 권번호.
                              RPAD('000', 3, '0') || -- 제출서.
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
                            AND VM.VAT_GUBUN                = '2'         -- 매출.
                            AND VM.TAX_CODE                 = W_TAX_CODE
                            AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                            AND VM.SOB_ID                   = W_SOB_ID
                            AND VM.TAX_ELECTRO_YN           = 'N'
                            AND NOT EXISTS 
                                  ( SELECT 'X'
                                      FROM FI_VAT_TYPE_V VT
                                    WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                                      AND VT.SOB_ID     = VM.SOB_ID
                                      AND VT.VAT_TYPE   IN ('5', '9', '3', '17')  -- 계산서/직수출/신용카드 제외.
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
      -- 전자세금계산서 이외분 매출합계자료. 
      V_SEQ_NUM := 62.1;      
      FOR R1 IN ( SELECT '3' ||
                         RPAD(REPLACE(C1.VAT_NUM, '-', ''), 10, ' ') || -- 사업자번호.
                         LPAD(NVL(SX1.CUSTOMER_COUNT, 0), 7, '0') || -- 거래처수.
                         LPAD(NVL(SX1.VAT_COUNT, 0), 7, '0') || -- 부가세수.
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
                              END, 15, '0') || -- 공급가액.
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
                              END, 14, '0') || -- 세액. 
                         LPAD(NVL(SX1.L_CUSTOMER_COUNT, 0), 7, '0') || -- 거래처수.
                         LPAD(NVL(SX1.L_VAT_COUNT, 0), 7, '0') || -- 부가세수.
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
                              END, 15, '0') || -- 공급가액.
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
                              END, 14, '0') || -- 세액. 
                          LPAD(NVL(SX1.P_CUSTOMER_COUNT, 0), 7, '0') || -- 거래처수.
                          LPAD(NVL(SX1.P_VAT_COUNT, 0), 7, '0') || -- 부가세수.
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
                              END, 15, '0') || -- 공급가액.
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
                              END, 14, '0') || -- 세액. 
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
                            AND VM.VAT_GUBUN                = '2'         -- 매출.
                            AND VM.TAX_CODE                 = W_TAX_CODE
                            AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                            AND VM.SOB_ID                   = W_SOB_ID
                            AND VM.TAX_ELECTRO_YN           = 'N'
                            AND NOT EXISTS 
                                  ( SELECT 'X'
                                      FROM FI_VAT_TYPE_V VT
                                    WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                                      AND VT.SOB_ID     = VM.SOB_ID
                                      AND VT.VAT_TYPE   IN ('5', '9', '3', '17')  -- 계산서/직수출/신용카드 제외.
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
      -- 전자세금계산서 발급분 매출합계자료. 
      V_SEQ_NUM := 62.2;      
      FOR R1 IN ( SELECT '5' ||
                         RPAD(REPLACE(C1.VAT_NUM, '-', ''), 10, ' ') || -- 사업자번호.
                         LPAD(NVL(SX1.CUSTOMER_COUNT, 0), 7, '0') || -- 거래처수.
                         LPAD(NVL(SX1.VAT_COUNT, 0), 7, '0') || -- 부가세수.
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
                              END, 15, '0') || -- 공급가액.
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
                              END, 14, '0') || -- 세액. 
                         LPAD(NVL(SX1.L_CUSTOMER_COUNT, 0), 7, '0') || -- 거래처수.
                         LPAD(NVL(SX1.L_VAT_COUNT, 0), 7, '0') || -- 부가세수.
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
                              END, 15, '0') || -- 공급가액.
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
                              END, 14, '0') || -- 세액. 
                          LPAD(NVL(SX1.P_CUSTOMER_COUNT, 0), 7, '0') || -- 거래처수.
                          LPAD(NVL(SX1.P_VAT_COUNT, 0), 7, '0') || -- 부가세수.
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
                              END, 15, '0') || -- 공급가액.
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
                              END, 14, '0') || -- 세액. 
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
                            AND VM.VAT_GUBUN                = '2'         -- 매출.
                            AND VM.TAX_CODE                 = W_TAX_CODE
                            AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                            AND VM.SOB_ID                   = W_SOB_ID
                            AND VM.TAX_ELECTRO_YN           = 'Y'
                            AND NOT EXISTS 
                                  ( SELECT 'X'
                                      FROM FI_VAT_TYPE_V VT
                                    WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                                      AND VT.SOB_ID     = VM.SOB_ID
                                      AND VT.VAT_TYPE   IN ('5', '9', '3', '17')  -- 계산서/직수출/신용카드 제외.
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
      
      --> 전자세금계산서 이외분 매입자료.<--
      V_SEQ_NUM := 63;      
      FOR R1 IN ( SELECT '2' ||
                         RPAD(REPLACE(C1.VAT_NUM, '-', ''), 10, ' ') || -- 사업자번호.
                         LPAD(ROWNUM, 4, '0') || -- 일련번호.
                         RPAD(REPLACE(NVL(SX1.TAX_REG_NO, ' '), '-', ''), 10, ' ') || -- 거래자번호.
                         RPAD(NVL(SX1.CUSTOMER_DESC, ' '), 30, ' ') || -- 거래자번호.
                         RPAD(NVL(SX1.BUSINESS_CONDITION, ' '), 17, ' ') || -- 업태.
                         RPAD(NVL(SX1.BUSINESS_ITEM, ' '), 25, ' ') || -- 업종.
                         LPAD(NVL(SX1.VAT_COUNT, 0), 7, '0') || -- 세금계산서 매수.
                         RPAD('0', 2, '0') || -- 공란.
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
                              END, 14, '0') || -- 공급가액.
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
                              END, 13, '0') || -- 세액. 
                              LPAD(0, 1, '0') || -- 신고자주류코드.
                              LPAD(0, 1, '0') || -- 주류코드.
                              RPAD('8501', 4, '0') || -- 권번호.
                              RPAD('000', 3, '0') || -- 제출서.
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
                            AND VM.VAT_GUBUN                = '1'         -- 매입.
                            AND VM.TAX_CODE                 = W_TAX_CODE
                            AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                            AND VM.SOB_ID                   = W_SOB_ID
                            AND VM.TAX_ELECTRO_YN           = 'N'
                            AND NOT EXISTS 
                                  ( SELECT 'X'
                                      FROM FI_VAT_TYPE_V VT
                                    WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                                      AND VT.SOB_ID     = VM.SOB_ID
                                      AND VT.VAT_TYPE   IN ('5', '9', '3')  -- 계산서/직수출/신용카드 제외.
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
      -- 전자세금계산서 이외분 매입합계자료. 
      V_SEQ_NUM := 63.1;      
      FOR R1 IN ( SELECT '4' ||
                         RPAD(REPLACE(C1.VAT_NUM, '-', ''), 10, ' ') || -- 사업자번호.
                         LPAD(NVL(SX1.CUSTOMER_COUNT, 0), 7, '0') || -- 거래처수.
                         LPAD(NVL(SX1.VAT_COUNT, 0), 7, '0') || -- 부가세수.
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
                              END, 15, '0') || -- 공급가액.
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
                              END, 14, '0') || -- 세액. 
                         LPAD(NVL(SX1.L_CUSTOMER_COUNT, 0), 7, '0') || -- 거래처수.
                         LPAD(NVL(SX1.L_VAT_COUNT, 0), 7, '0') || -- 부가세수.
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
                              END, 15, '0') || -- 공급가액.
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
                              END, 14, '0') || -- 세액. 
                          LPAD(NVL(SX1.P_CUSTOMER_COUNT, 0), 7, '0') || -- 거래처수.
                          LPAD(NVL(SX1.P_VAT_COUNT, 0), 7, '0') || -- 부가세수.
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
                              END, 15, '0') || -- 공급가액.
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
                              END, 14, '0') || -- 세액. 
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
                            AND VM.VAT_GUBUN                = '1'         -- 매입.
                            AND VM.TAX_CODE                 = W_TAX_CODE
                            AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                            AND VM.SOB_ID                   = W_SOB_ID
                            AND VM.TAX_ELECTRO_YN           = 'N'
                            AND NOT EXISTS 
                                  ( SELECT 'X'
                                      FROM FI_VAT_TYPE_V VT
                                    WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                                      AND VT.SOB_ID     = VM.SOB_ID
                                      AND VT.VAT_TYPE   IN ('5', '9', '3')  -- 계산서/직수출/신용카드 제외.
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
      -- 전자세금계산서 발급분 매입합계자료. 
      V_SEQ_NUM := 63.2;      
      FOR R1 IN ( SELECT '6' ||
                         RPAD(REPLACE(C1.VAT_NUM, '-', ''), 10, ' ') || -- 사업자번호.
                         LPAD(NVL(SX1.CUSTOMER_COUNT, 0), 7, '0') || -- 거래처수.
                         LPAD(NVL(SX1.VAT_COUNT, 0), 7, '0') || -- 부가세수.
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
                              END, 15, '0') || -- 공급가액.
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
                              END, 14, '0') || -- 세액. 
                         LPAD(NVL(SX1.L_CUSTOMER_COUNT, 0), 7, '0') || -- 거래처수.
                         LPAD(NVL(SX1.L_VAT_COUNT, 0), 7, '0') || -- 부가세수.
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
                              END, 15, '0') || -- 공급가액.
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
                              END, 14, '0') || -- 세액. 
                          LPAD(NVL(SX1.P_CUSTOMER_COUNT, 0), 7, '0') || -- 거래처수.
                          LPAD(NVL(SX1.P_VAT_COUNT, 0), 7, '0') || -- 부가세수.
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
                              END, 15, '0') || -- 공급가액.
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
                              END, 14, '0') || -- 세액. 
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
                            AND VM.VAT_GUBUN                = '1'         -- 매입.
                            AND VM.TAX_CODE                 = W_TAX_CODE
                            AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                            AND VM.SOB_ID                   = W_SOB_ID
                            AND VM.TAX_ELECTRO_YN           = 'Y'
                            AND NOT EXISTS 
                                  ( SELECT 'X'
                                      FROM FI_VAT_TYPE_V VT
                                    WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                                      AND VT.SOB_ID     = VM.SOB_ID
                                      AND VT.VAT_TYPE   IN ('5', '9', '3')  -- 계산서/직수출/신용카드 제외.
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
    
    ---> 계산서 합계표 <---
    -- 23.1 표지.
    V_SEQ_NUM := 64;
    V_SOURCE_FILE := 'BILL_SUM';
    BEGIN
      SELECT COUNT(DISTINCT SC.TAX_REG_NO) AS CUSTOMER_COUNT
        INTO V_RECORD_COUNT
        FROM FI_VAT_MASTER VM
          , FI_SUPP_CUST_V SC
      WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID(+)
        AND VM.SOB_ID                   = SC.SOB_ID(+)
        AND VM.VAT_GUBUN                = '1'         -- 매입.
        AND VM.TAX_CODE                 = W_TAX_CODE
        AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
        AND VM.SOB_ID                   = W_SOB_ID
        AND VM.VAT_TYPE                 = '5'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;          
    FOR C1 IN ( SELECT RPAD('A', 1, ' ') ||  -- 자료구분
                       RPAD(NVL(BM.TAX_OFFICE_CODE, ' '), 3, ' ') || -- 세무서.
                       RPAD(TO_CHAR(P_WRITE_DATE, 'YYYYMMDD'), 8, ' ') || -- 제출년월일.
                       RPAD('2', 1, ' ') || -- 제출자구분.
                       RPAD(' ', 6, ' ') || -- 세무대리인관리번호.
                       RPAD(REPLACE(NVL(BM.VAT_NUM, ' '), '-', ''), 10, ' ') ||
                       RPAD(NVL(CM.CORPORATE_NAME, ' '), 40, ' ') ||     -- 상호.
                       RPAD(REPLACE(NVL(CM.LEGAL_NUM, ' '), '-', ''), 13, ' ') || -- 주민(법인)번호.
                       RPAD(NVL(BM.PRESIDENT_NAME, ' '), 30, ' ') ||     -- 대표자명.
                       RPAD(NVL(BM.ZIP_CODE, ' '), 10, ' ') || -- 우편번호.
                       RPAD(NVL(BM.ADDR1, ' ') || ' ' || NVL(BM.ADDR2, ' '), 70, ' ') ||     -- 소재지.
                       RPAD(REPLACE(NVL(BM.TEL_NUM, ' '), '-', ''), 15,  ' ') || -- 전화번호. 
                       LPAD(NVL(V_RECORD_COUNT, 0), 5, '0') || -- 건수.                       
                       RPAD('101', 3, ' ') || -- 한글코드.
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
      -- 23.1 제출의무자인적사항레코드.
      V_SEQ_NUM := 64.1;
      V_SOURCE_FILE := 'BILL_SUM';
      FOR R1 IN( SELECT RPAD('B', 1, ' ') || 
                        RPAD(NVL(C1.TAX_OFFICE_CODE, ' '), 3, ' ') || -- 세무서코드.
                        LPAD(NVL(C1.ROW_NUM, 0), 6, '0') || -- 일련번호.
                        RPAD(REPLACE(NVL(C1.VAT_NUM, ' '), '-', ''), 10, ' ') || -- 사업자등록번호
                        RPAD(NVL(C1.CORPORATE_NAME, ' '), 40, ' ') || -- 상호.
                        RPAD(NVL(C1.PRESIDENT_NAME, ' '), 30, ' ') || -- 대표자.
                        RPAD(NVL(C1.ZIP_CODE, ' '), 10, ' ') || -- 대표자.
                        RPAD(NVL(C1.ADDRESS, ' '), 70, ' ') || -- 대표자.
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
        --27.2 제출의무자별 집계레코드.(매입)
        V_SEQ_NUM := 64.2;
        V_SOURCE_FILE := 'BILL_SUM';
        FOR R2 IN( SELECT RPAD('C', 1, ' ') || 
                          RPAD('18', 2, ' ') || --자료구분
                          RPAD(CASE 
                                 WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '04', '05', '06') THEN '1'
                                 ELSE '2'
                               END, 1, ' ') || --기구분.
                          RPAD(CASE 
                                 WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '07', '08', '09') THEN '1'  -- 예정신고.
                                 WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '05', '06', '10', '11', '12') THEN '2'  -- 확정신고.
                               END, 1, ' ') ||   
                          RPAD(NVL(C1.TAX_OFFICE_CODE, ' '), 3, ' ') || -- 세무서코드.  
                          LPAD(NVL(R1.ROW_NUM, 0), 6, '0') || -- 일련번호.
                          RPAD(REPLACE(NVL(C1.VAT_NUM, ' '), '-', ''), 10, ' ') || -- 사업자번호.
                          RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYY'), 4, ' ') || -- 귀속년도.
                          RPAD(TO_CHAR(W_ISSUE_DATE_FR, 'YYYYMMDD'), 8, ' ') || -- 거래기간시작년월일.
                          RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMMDD'), 8, ' ') || -- 거래기간종료년월일.
                          RPAD(TO_CHAR(P_WRITE_DATE, 'YYYYMMDD'), 8, ' ') || -- 거래기간종료년월일.
                          LPAD(NVL(SX1.CUSTOMER_COUNT, 0), 6, '0') || -- 매입처수.
                          LPAD(NVL(SX1.VAT_COUNT, 0), 6, '0') || -- 계산서매수.
                          RPAD(CASE WHEN NVL(SX1.GL_AMOUNT, 0) >= 0 THEN '0' ELSE '1' END, 1, ' ') || -- 음수표시.
                          LPAD(REPLACE(LPAD(NVL(SX1.GL_AMOUNT, 0), 14, '0'), '-', ''), 14, '-') || -- 매입금액.
                          RPAD(' ', 151, ' ') AS RECORD_FILE
                     FROM (SELECT COUNT(DISTINCT SC.TAX_REG_NO) AS CUSTOMER_COUNT
                                 , SUM(VM.VAT_COUNT) AS VAT_COUNT
                                 , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                                 , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
                              FROM FI_VAT_MASTER VM
                                , FI_SUPP_CUST_V SC
                            WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID(+)
                              AND VM.SOB_ID                   = SC.SOB_ID(+)
                              AND VM.VAT_GUBUN                = '1'         -- 매입.
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
          --27.3 제출의무자별 명세레코드.(매입)
          V_SEQ_NUM := 64.3;
          V_SOURCE_FILE := 'BILL_SUM';
          FOR R3 IN( SELECT RPAD('D', 1, ' ') || 
                            RPAD('18', 2, ' ') || --자료구분
                            RPAD(CASE 
                                   WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '04', '05', '06') THEN '1'
                                   ELSE '2'
                                 END, 1, ' ') || --기구분.
                            RPAD(CASE 
                                   WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '07', '08', '09') THEN '1'  -- 예정신고.
                                   WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '05', '06', '10', '11', '12') THEN '2'  -- 확정신고.
                                 END, 1, ' ') ||   
                            RPAD(NVL(C1.TAX_OFFICE_CODE, ' '), 3, ' ') || -- 세무서코드.  
                            LPAD(NVL(R1.ROW_NUM, 0), 6, '0') || -- 일련번호.
                            RPAD(REPLACE(NVL(C1.VAT_NUM, ' '), '-', ''), 10, ' ') || -- 사업자번호.
                            RPAD(REPLACE(NVL(SX1.TAX_REG_NO, ' '), '-', ''), 10, ' ') || -- 매입처 사업자번호.
                            RPAD(NVL(SX1.CUSTOMER_DESC, ' '), 40, ' ') || -- 매입처 상호.
                            LPAD(NVL(SX1.VAT_COUNT, 0), 5, '0') || -- 계산서매수.
                            RPAD(CASE WHEN NVL(SX1.GL_AMOUNT, 0) >= 0 THEN '0' ELSE '1' END, 1, ' ') || -- 음수표시.
                            LPAD(REPLACE(LPAD(NVL(SX1.GL_AMOUNT, 0), 14, '0'), '-', ''), 14, '-') || -- 매입금액.
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
                                AND VM.VAT_GUBUN                = '1'         -- 매입.
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
    
    --> 수출실적명세서 <--
    V_SEQ_NUM := 71;     
    V_SOURCE_FILE := 'EXPORT'; 
    FOR C1 IN ( SELECT RPAD('A', 1, ' ') ||  -- 자료구분
                       RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMM'), 6, ' ') || -- 수출신고년월(귀속년월).
                       RPAD('3', 1, ' ') || --신고구분
                       RPAD(REPLACE(NVL(BM.VAT_NUM, ' '), '-', ''), 10, ' ') || -- 사업자번호
                       RPAD(NVL(CM.CORPORATE_NAME, ' '), 30, ' ') ||     -- 상호.
                       RPAD(NVL(BM.PRESIDENT_NAME, ' '), 15, ' ') ||     -- 대표자명.
                       RPAD(NVL(BM.ADDR1, ' ') || ' ' || NVL(BM.ADDR2, ' '), 45, ' ') ||     -- 소재지.
                       RPAD(NVL(BM.BUSINESS_TYPE, ' '), 17, ' ') || -- 업태.
                       RPAD(NVL(BM.BUSINESS_ITEM, ' '), 25, ' ') || -- 업종.
                       RPAD(TO_CHAR(W_ISSUE_DATE_FR, 'YYYYMMDD') || TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMMDD'), 16, ' ') || -- 거래기간.
                       RPAD(TO_CHAR(W_ISSUE_DATE_FR, 'YYYYMMDD'), 8, ' ') || -- 작성일자.
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
      -- 30.2.집계.
      V_SEQ_NUM := 71.1;
      V_SOURCE_FILE := 'EXPORT';
      FOR R1 IN( SELECT RPAD('B', 1, ' ') || 
                        RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMM'), 6, ' ') || -- 수출신고년월(귀속년월).
                        RPAD('3', 1, ' ') || --신고구분
                        RPAD(REPLACE(NVL(C1.VAT_NUM, ' '), '-', ''), 10, ' ') || -- 사업자등록번호.
                        LPAD(NVL(SX1.TOT_COUNT, 0), 7, '0') || -- 건수합계.
                        LPAD(REPLACE(TO_CHAR(NVL(SX1.TOT_CURR_AMOUNT, 0), 'FM999999999999990.00'), '.', ''), 15, '0') || -- 외화합계.
                        LPAD(NVL(SX1.TOT_BASE_AMOUNT, 0), 15, '0') || -- 원화합계.
                        LPAD(NVL(SX1.ITEM_COUNT, 0), 7, '0') || -- 건수-재화.
                        LPAD(REPLACE(TO_CHAR(NVL(SX1.ITEM_CURR_AMOUNT, 0), 'FM999999999999990.00'), '.', ''), 15, '0') || -- 외화-재화.
                        LPAD(NVL(SX1.ITEM_BASE_AMOUNT, 0), 15, '0') || -- 원화-재화.
                        LPAD(NVL(SX1.ETC_COUNT, 0), 7, '0') || -- 건수-기타.
                        LPAD(REPLACE(TO_CHAR(NVL(SX1.ETC_CURR_AMOUNT, 0), 'FM999999999999990.00'), '.', ''), 15, '0') || -- 외화-기타.
                        LPAD(NVL(SX1.ETC_BASE_AMOUNT, 0), 15, '0') || -- 원화-기타.
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
      -- 30.3.명세서/.
      V_SEQ_NUM := 71.2;
      V_SOURCE_FILE := 'EXPORT';
      FOR R1 IN( SELECT RPAD('C', 1, ' ') || 
                        RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMM'), 6, ' ') || -- 수출신고년월(귀속년월).
                        RPAD('3', 1, ' ') || --신고구분
                        RPAD(REPLACE(NVL(C1.VAT_NUM, ' '), '-', ''), 10, ' ') || -- 사업자등록번호.
                        LPAD(ROWNUM, 7, '0') || -- 일련번호.
                        RPAD(REPLACE(NVL(VE.DOCUMENT_NUM, ' '), '-', ''), 15, ' ') || -- 수출신고번호.
                        RPAD(TO_CHAR(VE.SHIPPING_DATE, 'YYYYMMDD'), 8, ' ') || -- 선적일자.
                        RPAD(NVL(VE.CURRENCY_CODE, ' '), 3, ' ') || -- 통화.
                        LPAD(REPLACE(TO_CHAR(NVL(VE.EXCHANGE_RATE, 0), 'FM99990.0000'), '.', ''), 9, '0') || --환율.
                        LPAD(REPLACE(TO_CHAR(NVL(VE.CURR_AMOUNT, 0), 'FM999999999999990.00'), '.', ''), 15, '0') || -- 외화.
                        LPAD(NVL(VE.BASE_AMOUNT, 0), 15, '0') || -- 원화.
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
    
    --> 신용카드매출전표등 수취명세서 <--
    V_SEQ_NUM := 80;     
    V_SOURCE_FILE := 'CREDITCARD'; 
    FOR C1 IN ( SELECT RPAD('HL', 2, ' ') ||  -- 자료구분
                       RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYY'), 4, ' ') || -- 귀속년도.
                       RPAD(CASE 
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '04', '05', '06') THEN '1'
                               ELSE '2'
                             END, 1, ' ') || --반기구분.
                       RPAD(CASE 
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '07') THEN '1'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('02', '08') THEN '2'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('03', '09') THEN '3'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '10') THEN '4'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('05', '11') THEN '5'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('06', '12') THEN '6'
                             END, 1, ' ') || -- 반기내월순번.
                       RPAD(REPLACE(NVL(BM.VAT_NUM, ' '), '-', ''), 10, ' ') || -- 사업자번호
                       RPAD(NVL(CM.CORPORATE_NAME, ' '), 60, ' ') ||     -- 상호.
                       RPAD(NVL(BM.PRESIDENT_NAME, ' '), 30, ' ') ||     -- 대표자명.
                       RPAD(REPLACE(NVL(CM.LEGAL_NUM, ' '), '-', ''), 13, ' ') ||     -- 주민(법인)번호.
                       RPAD(TO_CHAR(P_WRITE_DATE, 'YYYYMMDD'), 8, ' ') || -- 제출일자.
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
      -- 30.2.수취명세.
      V_SEQ_NUM := 80.1;
      V_SOURCE_FILE := 'CREDITCARD';
      V_RECORD_COUNT := 0;
      FOR R1 IN(SELECT RPAD('DL', 2, ' ') || 
                       RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYY'), 4, ' ') || -- 귀속년도.
                       RPAD(CASE 
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '04', '05', '06') THEN '1'
                               ELSE '2'
                             END, 1, ' ') || --반기구분.
                       RPAD(CASE 
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '07') THEN '1'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('02', '08') THEN '2'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('03', '09') THEN '3'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '10') THEN '4'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('05', '11') THEN '5'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('06', '12') THEN '6'
                             END, 1, ' ') || -- 반기내월순번.
                        RPAD(REPLACE(NVL(C1.VAT_NUM, ' '), '-', ''), 10, ' ') || -- 사업자등록번호.
                        RPAD('1', 1, '0') || -- 카드구분.
                        RPAD(REPLACE(NVL(SX1.CARD_NUM, ' '), '-', ''), 20, ' ') || -- 카드번호.
                        RPAD(REPLACE(NVL(SX1.TAX_REG_NO, ' '), '-', ''), 10, ' ') || -- 가맹점 사업자번호.
                        LPAD(NVL(SX1.VAT_COUNT, 0), 9, '0') || -- 거래건수.
                        RPAD(CASE WHEN NVL(SX1.GL_AMOUNT, 0) >= 0 THEN ' ' ELSE '-' END, 1, ' ') || --음수.
                        LPAD(NVL(SX1.GL_AMOUNT, 0), 13, '0') || -- 공급가액.
                        RPAD(CASE WHEN NVL(SX1.VAT_AMOUNT, 0) >= 0 THEN ' ' ELSE '-' END, 1, ' ') || --음수.
                        LPAD(NVL(SX1.VAT_AMOUNT, 0), 13, '0') || -- 세액.
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
                        AND VM.VAT_GUBUN                = '1'         -- 매입.
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
      -- 40.3.합계.
      V_SEQ_NUM := 80.2;
      V_SOURCE_FILE := 'CREDITCARD';
      FOR R1 IN( SELECT RPAD('TL', 2, ' ') || 
                       RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYY'), 4, ' ') || -- 귀속년도.
                       RPAD(CASE 
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '04', '05', '06') THEN '1'
                               ELSE '2'
                             END, 1, ' ') || --반기구분.
                       RPAD(CASE 
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '07') THEN '1'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('02', '08') THEN '2'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('03', '09') THEN '3'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '10') THEN '4'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('05', '11') THEN '5'
                               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('06', '12') THEN '6'
                             END, 1, ' ') || -- 반기내월순번.
                        RPAD(REPLACE(NVL(C1.VAT_NUM, ' '), '-', ''), 10, ' ') || -- 사업자등록번호.
                        LPAD(NVL(V_RECORD_COUNT, 0), 7, '0') || -- DATA건수.
                        LPAD(NVL(SX1.VAT_COUNT, 0), 9, '0') || -- 거래건수(수취명세서 자료수).
                        RPAD(CASE WHEN NVL(SX1.GL_AMOUNT, 0) >= 0 THEN ' ' ELSE '-' END, 1, ' ') || --음수.
                        LPAD(NVL(SX1.GL_AMOUNT, 0), 15, '0') || -- 공급가액.
                        RPAD(CASE WHEN NVL(SX1.VAT_AMOUNT, 0) >= 0 THEN ' ' ELSE '-' END, 1, ' ') || --음수.
                        LPAD(NVL(SX1.VAT_AMOUNT, 0), 15, '0') || -- 세액.
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
                        AND VM.VAT_GUBUN                = '1'         -- 매입.
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
