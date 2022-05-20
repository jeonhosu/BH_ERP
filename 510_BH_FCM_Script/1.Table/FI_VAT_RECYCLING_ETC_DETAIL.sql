/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_RECYCLING_ETC_DETAIL
/* Description  : 재활용폐자원 및 중고자동차 매입세액 공제신고서 
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_RECYCLING_ETC_DETAIL
( RECYCLING_ETC_DETAIL_ID         NUMBER        NOT NULL,   
  SOB_ID                          NUMBER        NOT NULL,   
  ORG_ID                          NUMBER        NOT NULL, 
  TAX_CODE                        VARCHAR2(20)  NOT NULL,   
  VAT_MNG_SERIAL                  NUMBER        NOT NULL,   
  VAT_RECEIPT_TYPE                VARCHAR2(20)  NOT NULL,   
  SUPPLIER_ID                     NUMBER        NOT NULL,           
  VAT_COUNT                       NUMBER        ,           
  ITEM_DESC                       VARCHAR2(200) ,           
  ITEM_QTY                        NUMBER        DEFAULT 0,  
  CAR_NUM                         VARCHAR2(50)  ,
  CAR_BODY_NUM                    VARCHAR2(50)  ,
  ITEM_AMOUNT                     NUMBER        ,           
  DEEMED_VAT_AMOUNT               NUMBER        ,
  ATTRIBUTE_A                     VARCHAR2(200) ,
  ATTRIBUTE_B                     VARCHAR2(200) ,
  ATTRIBUTE_C                     VARCHAR2(200) ,
  ATTRIBUTE_D                     VARCHAR2(200) ,
  ATTRIBUTE_E                     VARCHAR2(200) ,
  ATTRIBUTE_1                     NUMBER        ,
  ATTRIBUTE_2                     NUMBER        ,
  ATTRIBUTE_3                     NUMBER        ,
  ATTRIBUTE_4                     NUMBER        ,
  ATTRIBUTE_5                     NUMBER        ,
  CREATION_DATE                   DATE          NOT NULL,
  CREATED_BY                      NUMBER        NOT NULL,
  LAST_UPDATE_DATE                DATE          NOT NULL,
  LAST_UPDATED_BY                 NUMBER        NOT NULL, 
  COPPER_ETC_ID                   NUMBER        ,
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_VAT_RECYCLING_ETC_DETAIL IS '재활용폐자원 및 중고자동차 매입세액 공제신고서';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.RECYCLING_ETC_DETAIL_ID IS '재활용폐자원 및 중고자동차 매입 상세 ID';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.TAX_CODE IS '부가세 신고 사업장코드';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.VAT_MNG_SERIAL IS '부가세신고기간구분번호';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.VAT_RECEIPT_TYPE IS '영수증(10)/계산서(20) 구분';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.SUPPLIER_ID IS '매입처ID';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.VAT_COUNT IS 'VAT 매수';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.ITEM_DESC IS '품명';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.ITEM_QTY IS '수량';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.CAR_NUM IS '차량번호';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.CAR_BODY_NUM IS '차대번호';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.ITEM_AMOUNT IS '취득금액';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.DEEMED_VAT_AMOUNT IS '매입세액 공제액';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.COPPER_ETC_ID IS '구리 스크랩등 매입세액 공제신고서 ID';


-- INDEX
CREATE UNIQUE INDEX FI_VAT_RECYCLING_ETC_DTL_U1 ON FI_VAT_RECYCLING_ETC_DETAIL(RECYCLING_ETC_DETAIL_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_RECYCLING_ETC_DTL_N1 ON FI_VAT_RECYCLING_ETC_DETAIL(SOB_ID, ORG_ID, TAX_CODE, VAT_MNG_SERIAL) TABLESPACE FCM_TS_IDX;

CREATE SEQUENCE FI_VAT_RECYCLING_ETC_DTL_S1;
