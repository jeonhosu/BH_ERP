/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FI
/* Program Name : FI_VAT_DECLARATION
/* Description  : 일반과세자 부가가치세 신고서.
/* Reference by : 회계 법인 정보 관리.
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_DECLARATION
( DECLARATION_ID                  NUMBER          NOT NULL,   -- 신고서ID.
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  TAX_CODE                        VARCHAR2(20)    NOT NULL,   -- 사업장코드.
  ISSUE_DATE_FR                   DATE            NOT NULL,   -- 시작기간.
  ISSUE_DATE_TO                   DATE            NOT NULL,   -- 종료기간.
  WRITE_DATE                      DATE            NOT NULL,   -- 작성일자.
  S_TAX_INVOICE_AMT               NUMBER          DEFAULT 0,  -- 과세매출 세금계산서 발급분.
  S_TAX_INVOICE_VAT               NUMBER          DEFAULT 0,  -- 과세매출 세금계산서 발급분.
  S_TAX_BUYER_INVOICE_AMT         NUMBER          DEFAULT 0,  -- 과세매출 매입자발행세금계산서.
  S_TAX_BUYER_INVOICE_VAT         NUMBER          DEFAULT 0,  -- 과세매출 매입자발행세금계산서.
  S_TAX_CREDIT_AMT                NUMBER          DEFAULT 0,  -- 신용카드,현금영수증발행분.
  S_TAX_CREDIT_VAT                NUMBER          DEFAULT 0,  -- 신용카드,현금영수증발행분.
  S_TAX_ETC_AMT                   NUMBER          DEFAULT 0,  -- 기타(정규영주승외매출분)
  S_TAX_ETC_VAT                   NUMBER          DEFAULT 0,  -- 기타(정규영주승외매출분)
  S_ZERO_INVOICE_AMT              NUMBER          DEFAULT 0,  -- 영세율 세금계산서 발급분.
  S_ZERO_INVOICE_VAT              NUMBER          DEFAULT 0,  -- 영세율 세금계산서 발급분.
  S_ZERO_ETC_AMT                  NUMBER          DEFAULT 0,  -- 영세율 기타.
  S_ZERO_ETC_VAT                  NUMBER          DEFAULT 0,  -- 영세율 기타.
  S_SCHEDULE_OMIT_AMT             NUMBER          DEFAULT 0,  -- 예정신고누락분.
  S_SCHEDULE_OMIT_VAT             NUMBER          DEFAULT 0,  -- 예정신고누락분.
  S_BAD_DEBT_TAX_AMT              NUMBER          DEFAULT 0,  -- 대손세액가감.
  S_BAD_DEBT_TAX_VAT              NUMBER          DEFAULT 0,  -- 대손세액가감.
  SALES_SUM_AMT                   NUMBER          DEFAULT 0,  -- 과세매출 합계.
  SALES_SUM_VAT                   NUMBER          DEFAULT 0,  -- 과세매출 합계.
  P_TAX_INVOICE_AMT               NUMBER          DEFAULT 0,  -- 매입세액 세금계산서 일반매입.
  P_TAX_INVOICE_VAT               NUMBER          DEFAULT 0,  -- 매입세액 세금계산서 일반매입.
  P_TAX_ASSET_AMT                 NUMBER          DEFAULT 0,  -- 매입세액 고정자산매입.
  P_TAX_ASSET_VAT                 NUMBER          DEFAULT 0,  -- 매입세액 고정자산매입.
  P_SCHEDULE_OMIT_AMT             NUMBER          DEFAULT 0,  -- 매입세액 예정신고누락분.
  P_SCHEDULE_OMIT_VAT             NUMBER          DEFAULT 0,  -- 매입세액 예정신고누락분.
  P_BUYER_INVOICE_AMT             NUMBER          DEFAULT 0,  -- 매입세액 매입자발행세금계산서.
  P_BUYER_INVOICE_VAT             NUMBER          DEFAULT 0,  -- 매입세액 매입자발행세금계산서.
  P_ETC_DED_AMT                   NUMBER          DEFAULT 0,  -- 매입세액 기타공제 매입세액.
  P_ETC_DED_VAT                   NUMBER          DEFAULT 0,  -- 매입세액 기타공제 매입세액.
  PURCHASE_SUM_AMT                NUMBER          DEFAULT 0,  -- 매입세액 합계.
  PURCHASE_SUM_VAT                NUMBER          DEFAULT 0,  -- 매입세액 합계.
  P_NOT_DED_AMT                   NUMBER          DEFAULT 0,  -- 공제받지못할 매입세액.
  P_NOT_DED_VAT                   NUMBER          DEFAULT 0,  -- 공제받지못할 매입세액.
  CALCULATE_TAX_AMT               NUMBER          DEFAULT 0,  -- 산출세액.
  CALCULATE_TAX_VAT               NUMBER          DEFAULT 0,  -- 산출세액.
  R_ETC_DED_AMT                   NUMBER          DEFAULT 0,  -- 경감공제세액 - 기타공제.경감세액.
  R_ETC_DED_VAT                   NUMBER          DEFAULT 0,  -- 경감공제세액 - 기타공제.경감세액.
  R_CREDIT_AMT                    NUMBER          DEFAULT 0,  -- 경감공제세액-신용카드매출전표발행공제등.
  R_CREDIT_VAT                    NUMBER          DEFAULT 0,  -- 경감공제세액-신용카드매출전표발행공제등.
  SCHEDULE_YET_REFUND_AMT         NUMBER          DEFAULT 0,  -- 예정신고미환급세액.
  SCHEDULE_YET_REFUND_VAT         NUMBER          DEFAULT 0,  -- 예정신고미환급세액.
  SCHEDULE_NOTICE_AMT             NUMBER          DEFAULT 0,  -- 예정고지세액.
  SCHEDULE_NOTICE_VAT             NUMBER          DEFAULT 0,  -- 예정고지세액.
  GOLD_BAR_BUYER_AMT              NUMBER          DEFAULT 0,  -- 금지금 매입자 납부특례 기납부세액.
  GOLD_BAR_BUYER_VAT              NUMBER          DEFAULT 0,  -- 금지금 매입자 납부특례 기납부세액.
  TAX_ADDITION_AMT                NUMBER          DEFAULT 0,  -- 가산세액계.
  TAX_ADDITION_VAT                NUMBER          DEFAULT 0,  -- 가산세액계.
  BALANCE_TAX_AMT                 NUMBER          DEFAULT 0,  -- 차감납부세액.  
  BALANCE_TAX_VAT                 NUMBER          DEFAULT 0,  -- 차감납부세액.
  MODIFY_YN                       CHAR(1)         DEFAULT 'N',-- 수정구분.
  CLOSED_YN                       CHAR(1)         DEFAULT 'N',-- 마감구분.
  CLOSED_DATE                     DATE            ,           -- 마감일시.
  CLOSED_PERSON_ID                NUMBER          ,           -- 마감처리자.
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE FI_VAT_DECLARATION IS '부가가치세 신고서(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.DECLARATION_ID IS '신고서ID';
COMMENT ON COLUMN FI_VAT_DECLARATION.TAX_CODE IS '사업장코드';
COMMENT ON COLUMN FI_VAT_DECLARATION.ISSUE_DATE_FR IS '과세 시작기간';
COMMENT ON COLUMN FI_VAT_DECLARATION.ISSUE_DATE_TO IS '과세 종료기간';
COMMENT ON COLUMN FI_VAT_DECLARATION.WRITE_DATE IS '작성일자';
COMMENT ON COLUMN FI_VAT_DECLARATION.S_TAX_INVOICE_AMT IS '과세매출 세금계산서 발급분(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.S_TAX_BUYER_INVOICE_AMT IS '과세매출 매입자발행세금계산서(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.S_TAX_CREDIT_AMT IS '신용카드,현금영수증발행분(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.S_TAX_ETC_AMT IS '기타(정규영주승외매출분)(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.S_ZERO_INVOICE_AMT IS '업체 타입(P-개인, L-법영세율 세금계산서 발급분(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.S_ZERO_ETC_AMT IS '영세율 기타(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.S_SCHEDULE_OMIT_AMT IS '예정신고누락분(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.S_BAD_DEBT_TAX_AMT IS '대손세액가감(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.SALES_SUM_AMT IS '과세매출 합계(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.P_TAX_INVOICE_AMT IS '매입세액 세금계산서 일반매입(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.P_TAX_ASSET_AMT IS '매입세액 고정자산매입(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.P_SCHEDULE_OMIT_AMT IS '매입세액 예정신고누락분(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.P_BUYER_INVOICE_AMT IS '매입세액 매입자발행세금계산서(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.P_ETC_DED_AMT IS '매입세액 기타공제 매입세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.PURCHASE_SUM_AMT  IS '매입세액 합계(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.P_NOT_DED_AMT IS '공제받지못할 매입세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.CALCULATE_TAX_AMT IS '산출세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.R_ETC_DED_AMT IS '경감공제세액 - 기타공제.경감세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.R_CREDIT_AMT IS '경감공제세액-신용카드매출전표발행공제등(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.SCHEDULE_YET_REFUND_AMT IS '예정신고미환급세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.SCHEDULE_NOTICE_AMT  IS '예정고지세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.GOLD_BAR_BUYER_AMT IS '금지금 매입자 납부특례 기납부세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.TAX_ADDITION_AMT IS '가산세액계(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.BALANCE_TAX_AMT IS '차감납부세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION.MODIFY_YN IS '수정여부';
COMMENT ON COLUMN FI_VAT_DECLARATION.CLOSED_YN IS '마감여부';
COMMENT ON COLUMN FI_VAT_DECLARATION.CLOSED_DATE IS '마감일자';
COMMENT ON COLUMN FI_VAT_DECLARATION.CLOSED_PERSON_ID IS '마감처리자';
COMMENT ON COLUMN FI_VAT_DECLARATION.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN FI_VAT_DECLARATION.CREATED_BY IS '생성자';
COMMENT ON COLUMN FI_VAT_DECLARATION.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN FI_VAT_DECLARATION.LAST_UPDATED_BY IS '최종수정자';

-- PRKMARY KEY.
ALTER TABLE FI_VAT_DECLARATION ADD CONSTRAINT FI_VAT_DECLARATION_PK PRIMARY KEY(TAX_CODE, ISSUE_DATE_FR, ISSUE_DATE_TO, SOB_ID);
-- CREATE INDEX.
CREATE UNIQUE INDEX FI_VAT_DECLARATION_U1 ON FI_VAT_DECLARATION(DECLARATION_ID) TABLESPACE FCM_TS_IDX;

-- CREATE SEQUENCE;
CREATE SEQUENCE FI_VAT_DECLARATION_S1;

-- ANALYZE.
ANALYZE TABLE FI_VAT_DECLARATION COMPUTE STATISTICS;
ANALYZE INDEX FI_VAT_DECLARATION_U1 COMPUTE STATISTICS;

