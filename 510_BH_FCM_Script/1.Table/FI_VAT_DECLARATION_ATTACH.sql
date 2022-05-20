/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FI
/* Program Name : FI_VAT_DECLARATION_ATTACH
/* Description  : 일반과세자 부가가치세 신고서 - 추가 자료.
/* Reference by : 회계 법인 정보 관리.
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_DECLARATION_ATTACH
( DECLARATION_ID                  NUMBER          NOT NULL,   -- 신고서ID.
  SS_TAX_INVOICE_AMT              NUMBER          DEFAULT 0,  -- 과세매출 세금계산서.
  SS_TAX_INVOICE_VAT              NUMBER          DEFAULT 0,  -- 과세매출 세금계산서.
  SS_TAX_ETC_AMT                  NUMBER          DEFAULT 0,  -- 과세매출 기타.
  SS_TAX_ETC_VAT                  NUMBER          DEFAULT 0,  -- 과세매출 기타.
  SS_ZERO_INVOICE_AMT             NUMBER          DEFAULT 0,  -- 영세율 세금계산서.
  SS_ZERO_INVOICE_VAT             NUMBER          DEFAULT 0,  -- 영세율 세금계산서.
  SS_ZERO_ETC_AMT                 NUMBER          DEFAULT 0,  -- 영세율 기타.
  SS_ZERO_ETC_VAT                 NUMBER          DEFAULT 0,  -- 영세율 기타.
  S_SALES_SUM_AMT                 NUMBER          DEFAULT 0,  -- 과세매출 합계.
  S_SALES_SUM_VAT                 NUMBER          DEFAULT 0,  -- 과세매출 합계.
  SP_TAX_INVOICE_AMT              NUMBER          DEFAULT 0,  -- 매입세액 세금계산서.
  SP_TAX_INVOICE_VAT              NUMBER          DEFAULT 0,  -- 매입세액 세금계산서.
  SP_ETC_DED_AMT                  NUMBER          DEFAULT 0,  -- 매입세액 기타공제 매입세액.
  SP_ETC_DED_VAT                  NUMBER          DEFAULT 0,  -- 매입세액 기타공제 매입세액.
  S_PURCHASE_SUM_AMT              NUMBER          DEFAULT 0,  -- 매입세액 합계.
  S_PURCHASE_SUM_VAT              NUMBER          DEFAULT 0,  -- 매입세액 합계.
  E_CREDIT_AMT                    NUMBER          DEFAULT 0,  -- 기타공제매입세액명세 : 신용카드 일반매입.
  E_CREDIT_VAT                    NUMBER          DEFAULT 0,  -- 기타공제매입세액명세 : 신용카드 일반매입.
  E_CREDIT_ASSET_AMT              NUMBER          DEFAULT 0,  -- 기타공제매입세액명세 : 신용카드 고정자산.
  E_CREDIT_ASSET_VAT              NUMBER          DEFAULT 0,  -- 기타공제매입세액명세 : 신용카드 고정자산.
  E_DEEMED_IP_AMT                 NUMBER          DEFAULT 0,  -- 의제매입세액.
  E_DEEMED_IP_VAT                 NUMBER          DEFAULT 0,  -- 의제매입세액.
  E_RECYCLE_IP_AMT                NUMBER          DEFAULT 0,  -- 재활용폐자원등 매입세액.
  E_RECYCLE_IP_VAT                NUMBER          DEFAULT 0,  -- 재활용폐자원등 매입세액.
  E_GOLD_BAR_IP_AMT               NUMBER          DEFAULT 0,  -- 고금의제 매입세액.
  E_GOLD_BAR_IP_VAT               NUMBER          DEFAULT 0,  -- 고금의제 매입세액.
  E_TAX_BUSINESS_IP_AMT           NUMBER          DEFAULT 0,  -- 과세사업전환매입세액.
  E_TAX_BUSINESS_IP_VAT           NUMBER          DEFAULT 0,  -- 과세사업전환매입세액.
  E_STOCK_IP_AMT                  NUMBER          DEFAULT 0,  -- 재고매입세액.
  E_STOCK_IP_VAT                  NUMBER          DEFAULT 0,  -- 재고매입세액.
  E_BAD_TAX_AMT                   NUMBER          DEFAULT 0,  -- 변제대손세액.
  E_BAD_TAX_VAT                   NUMBER          DEFAULT 0,  -- 변제대손세액.
  ETC_DED_IP_SUM_AMT              NUMBER          DEFAULT 0,  -- 기타공제매입세액명세 합계.
  ETC_DED_IP_SUM_VAT              NUMBER          DEFAULT 0,  -- 기타공제매입세액명세 합계.
  N_NOT_DED_AMT                   NUMBER          DEFAULT 0,  -- 공제받지못할 매입세액.
  N_NOT_DED_VAT                   NUMBER          DEFAULT 0,  -- 공제받지못할 매입세액.
  N_COMMON_IP_AMT                 NUMBER          DEFAULT 0,  -- 공통매입세액 면제사업분.
  N_COMMON_IP_VAT                 NUMBER          DEFAULT 0,  -- 공통매입세액 면제사업분.
  N_BAD_RECEIVE_AMT               NUMBER          DEFAULT 0,  -- 대손처분받은세액.
  N_BAD_RECEIVE_VAT               NUMBER          DEFAULT 0,  -- 대손처분받은세액.
  NOT_DED_SUM_AMT                 NUMBER          DEFAULT 0,  -- 공제받지못할매입세액명세합계.
  NOT_DED_SUM_VAT                 NUMBER          DEFAULT 0,  -- 공제받지못할매입세액명세합계.
  R_ETAX_REPORT_AMT               NUMBER          DEFAULT 0,  -- 경감공제세액 - 전자신고세액공제.
  R_ETAX_REPORT_VAT               NUMBER          DEFAULT 0,  -- 경감공제세액 - 전자신고세액공제.
  R_ETAX_ISSUE_AMT                NUMBER          DEFAULT 0,  -- 경감공제세액 - 전자세금계산서 발급세액공제.
  R_ETAX_ISSUE_VAT                NUMBER          DEFAULT 0,  -- 경감공제세액 - 전자세금계산서 발급세액공제.
  R_TAXI_TRANSPORT_AMT            NUMBER          DEFAULT 0,  -- 경감공제세액 - 택시운송사업자경감세액.
  R_TAXI_TRANSPORT_VAT            NUMBER          DEFAULT 0,  -- 경감공제세액 - 택시운송사업자경감세액.
  R_CASH_BILL_AMT                 NUMBER          DEFAULT 0,  -- 경감공제세액 - 현금영수증사업자세액공제.
  R_CASH_BILL_VAT                 NUMBER          DEFAULT 0,  -- 경감공제세액 - 현금영수증사업자세액공제.
  R_ETC_DED_AMT                   NUMBER          DEFAULT 0,  -- 경감공제세액 - 기타공제.경감세액.
  R_ETC_DED_VAT                   NUMBER          DEFAULT 0,  -- 경감공제세액 - 기타공제.경감세액.
  REDUCE_DED_SUM_AMT              NUMBER          DEFAULT 0,  -- 경감공제세액 합계.
  REDUCE_DED_SUM_VAT              NUMBER          DEFAULT 0,  -- 경감공제세액 합계.
  A_VAT_NUM_UNENROLL_AMT          NUMBER          DEFAULT 0,  -- 가산세명세 - 사업자미등록등.
  A_VAT_NUM_UNENROLL_VAT          NUMBER          DEFAULT 0,  -- 가산세명세 - 사업자미등록등.
  A_TAX_INVOICE_DELAY_AMT         NUMBER          DEFAULT 0,  -- 가산세명세 - 세금계산서 지연발급등.
  A_TAX_INVOICE_DELAY_VAT         NUMBER          DEFAULT 0,  -- 가산세명세 - 세금계산서 지연발급등.
  A_TAX_INVOICE_UNISSUE_AMT       NUMBER          DEFAULT 0,  -- 가산세명세 - 세금계산서 미발급등.
  A_TAX_INVOICE_UNISSUE_VAT       NUMBER          DEFAULT 0,  -- 가산세명세 - 세금계산서 미발급등.
  A_ETAX_UNSEND_IN_AMT            NUMBER          DEFAULT 0,  -- 가산세명세 - 전자세금계산서 미전송(과세기간내).
  A_ETAX_UNSEND_IN_VAT            NUMBER          DEFAULT 0,  -- 가산세명세 - 전자세금계산서 미전송(과세기간내).
  A_ETAX_UNSEND_OVER_AMT          NUMBER          DEFAULT 0,  -- 가산세명세 - 전자세금계산서 미전송(과세기간 경과).
  A_ETAX_UNSEND_OVER_VAT          NUMBER          DEFAULT 0,  -- 가산세명세 - 전자세금계산서 미전송(과세기간 경과).
  A_TAX_INV_SUM_BAD_AMT           NUMBER          DEFAULT 0,  -- 가산세명세 - 세금계산서 합계표 제출불성실.
  A_TAX_INV_SUM_BAD_VAT           NUMBER          DEFAULT 0,  -- 가산세명세 - 세금계산서 합계표 제출불성실.
  A_REPORT_BAD_AMT                NUMBER          DEFAULT 0,  -- 가산세명세 - 신고불성실.
  A_REPORT_BAD_VAT                NUMBER          DEFAULT 0,  -- 가산세명세 - 신고불성실.
  A_PAYMENT_BAD_AMT               NUMBER          DEFAULT 0,  -- 가산세명세 - 납부불성실.
  A_PAYMENT_BAD_VAT               NUMBER          DEFAULT 0,  -- 가산세명세 - 납부불성실.
  A_ZERO_REPORT_BAD_AMT           NUMBER          DEFAULT 0,  -- 가산세명세 - 영세율과세표준신고불성실.
  A_ZERO_REPORT_BAD_VAT           NUMBER          DEFAULT 0,  -- 가산세명세 - 영세율과세표준신고불성실.
  A_CASH_SALES_UNREPORT_AMT       NUMBER          DEFAULT 0,  -- 가산세명세 - 현금매출명세서 미제출.
  A_CASH_SALES_UNREPORT_VAT       NUMBER          DEFAULT 0,  -- 가산세명세 - 현금매출명세서 미제출.
  TAX_ADDITION_SUM_AMT            NUMBER          DEFAULT 0,  -- 가산세액 합계.
  TAX_ADDITION_SUM_VAT            NUMBER          DEFAULT 0,  -- 가산세액 합계.
  BILL_ISSUE_AMT                  NUMBER          DEFAULT 0,  -- 계산서 교부금액.
  BILL_RECEIPT_AMT                NUMBER          DEFAULT 0,  -- 계산서 수취금액.
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE FI_VAT_DECLARATION_ATTACH IS '부가가치세 신고서';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.DECLARATION_ID IS '신고서ID';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SS_TAX_INVOICE_AMT IS '과세매출 세금계산서(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SS_TAX_INVOICE_VAT IS '과세매출 세금계산서';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SS_TAX_ETC_AMT IS '과세매출 기타(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SS_TAX_ETC_VAT IS '과세매출 기타';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SS_ZERO_INVOICE_AMT IS '영세율 세금계산서(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SS_ZERO_INVOICE_VAT IS '영세율 세금계산서(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SS_ZERO_ETC_AMT IS '영세율 기타(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SS_ZERO_ETC_VAT IS '영세율 기타(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.S_SALES_SUM_AMT IS '과세매출 합계(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.S_SALES_SUM_VAT IS '과세매출 합계(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SP_TAX_INVOICE_AMT IS '매입세액 세금계산서(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SP_TAX_INVOICE_VAT IS '매입세액 세금계산서(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SP_ETC_DED_AMT IS '매입세액 기타공제 매입세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SP_ETC_DED_VAT IS '매입세액 기타공제 매입세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.S_PURCHASE_SUM_AMT IS '매입세액 합계(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.S_PURCHASE_SUM_VAT IS '매입세액 합계(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_CREDIT_AMT IS '기타공제매입세액명세 : 신용카드 일반매입(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_CREDIT_VAT IS '기타공제매입세액명세 : 신용카드 일반매입(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_CREDIT_ASSET_AMT IS '기타공제매입세액명세 : 신용카드 고정자산(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_CREDIT_ASSET_VAT IS '기타공제매입세액명세 : 신용카드 고정자산(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_DEEMED_IP_AMT IS '의제매입세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_DEEMED_IP_VAT IS '의제매입세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_RECYCLE_IP_AMT IS '재활용폐자원등 매입세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_RECYCLE_IP_VAT IS '재활용폐자원등 매입세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_GOLD_BAR_IP_AMT IS '고금의제 매입세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_GOLD_BAR_IP_VAT  IS '고금의제 매입세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_TAX_BUSINESS_IP_AMT IS '과세사업전환매입세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_TAX_BUSINESS_IP_VAT IS '과세사업전환매입세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_STOCK_IP_AMT IS '재고매입세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_STOCK_IP_VAT IS '재고매입세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_BAD_TAX_AMT  IS '변제대손세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_BAD_TAX_VAT IS '변제대손세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.ETC_DED_IP_SUM_AMT IS '기타공제매입세액명세 합계(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.ETC_DED_IP_SUM_VAT IS '기타공제매입세액명세 합계(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.N_NOT_DED_AMT IS '공제받지못할 매입세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.N_NOT_DED_VAT IS '공제받지못할 매입세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.N_COMMON_IP_AMT IS '공통매입세액 면제사업분(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.N_COMMON_IP_VAT IS '공통매입세액 면제사업분(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.N_BAD_RECEIVE_AMT IS '대손처분받은세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.N_BAD_RECEIVE_VAT IS '대손처분받은세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.NOT_DED_SUM_AMT IS '공제받지못할매입세액명세합계(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.NOT_DED_SUM_VAT IS '공제받지못할매입세액명세합계(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_ETAX_REPORT_AMT IS '경감공제세액 - 전자신고세액공제(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_ETAX_REPORT_VAT IS '경감공제세액 - 전자신고세액공제(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_ETAX_ISSUE_AMT IS '경감공제세액 - 전자세금계산서 발급세액공제(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_ETAX_ISSUE_VAT IS '경감공제세액 - 전자세금계산서 발급세액공제(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_TAXI_TRANSPORT_AMT  IS '경감공제세액 - 택시운송사업자경감세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_TAXI_TRANSPORT_VAT IS '경감공제세액 - 택시운송사업자경감세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_CASH_BILL_AMT IS '경감공제세액 - 현금영수증사업자세액공제(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_CASH_BILL_VAT IS '경감공제세액 - 현금영수증사업자세액공제(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_ETC_DED_AMT IS '경감공제세액 - 기타공제.경감세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_ETC_DED_VAT  IS '경감공제세액 - 기타공제.경감세액(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.REDUCE_DED_SUM_AMT IS '경감공제세액 합계(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.REDUCE_DED_SUM_VAT IS '경감공제세액 합계(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_VAT_NUM_UNENROLL_AMT IS '가산세명세 - 사업자미등록등(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_VAT_NUM_UNENROLL_VAT IS '가산세명세 - 사업자미등록등(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_TAX_INVOICE_DELAY_AMT IS '가산세명세 - 세금계산서 지연발급등(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_TAX_INVOICE_DELAY_VAT IS '가산세명세 - 세금계산서 지연발급등(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_TAX_INVOICE_UNISSUE_AMT IS '가산세명세 - 세금계산서 미발급등(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_TAX_INVOICE_UNISSUE_VAT IS '가산세명세 - 세금계산서 미발급등(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_ETAX_UNSEND_IN_AMT  IS '가산세명세 - 전자세금계산서 미전송(과세기간내)(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_ETAX_UNSEND_IN_VAT IS '가산세명세 - 전자세금계산서 미전송(과세기간내)(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_ETAX_UNSEND_OVER_AMT IS '가산세명세 - 전자세금계산서 미전송(과세기간 경과)(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_ETAX_UNSEND_OVER_VAT IS '가산세명세 - 전자세금계산서 미전송(과세기간 경과)(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_TAX_INV_SUM_BAD_AMT IS '가산세명세 - 세금계산서 합계표 제출불성실AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_TAX_INV_SUM_BAD_VAT  IS '가산세명세 - 세금계산서 합계표 제출불성실(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_REPORT_BAD_AMT IS '가산세명세 - 신고불성실(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_REPORT_BAD_VAT IS '가산세명세 - 신고불성실(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_PAYMENT_BAD_AMT IS '가산세명세 - 납부불성실(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_PAYMENT_BAD_VAT IS '가산세명세 - 납부불성실(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_ZERO_REPORT_BAD_AMT IS '가산세명세 - 영세율과세표준신고불성실(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_ZERO_REPORT_BAD_VAT IS '가산세명세 - 영세율과세표준신고불성실(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_CASH_SALES_UNREPORT_AMT  IS '가산세명세 - 현금매출명세서 미제출(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_CASH_SALES_UNREPORT_VAT IS '가산세명세 - 현금매출명세서 미제출(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.TAX_ADDITION_SUM_AMT  IS '가산세액 합계(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.TAX_ADDITION_SUM_VAT IS '가산세액 합계(AMT-금액, VAT-세액)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.CREATED_BY IS '생성자';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.LAST_UPDATED_BY IS '최종수정자';

-- PRKMARY KEY.
ALTER TABLE FI_VAT_DECLARATION_ATTACH ADD CONSTRAINT FI_VAT_DECLARATION_ATTACH_PK PRIMARY KEY(DECLARATION_ID);

-- ANALYZE.
ANALYZE TABLE FI_VAT_DECLARATION_ATTACH COMPUTE STATISTICS;

