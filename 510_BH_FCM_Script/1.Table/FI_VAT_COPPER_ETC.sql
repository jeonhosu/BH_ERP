/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_COPPER_ETC
/* Description  : 구리스크랩등 매입세액 공제신고서 
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_COPPER_ETC
( COPPER_ETC_ID                   NUMBER        NOT NULL,   
  SOB_ID                          NUMBER        NOT NULL,   
  ORG_ID                          NUMBER        NOT NULL, 
  TAX_CODE                        VARCHAR2(20)  NOT NULL,   
  VAT_MNG_SERIAL                  NUMBER        NOT NULL,   
  VAT_RECEIPT_TYPE                VARCHAR2(20)  NOT NULL,   
  SUPPLIER_ID                     NUMBER        NOT NULL,           
  VAT_COUNT                       NUMBER        ,           
  ITEM_DESC                       VARCHAR2(200) ,           
  ITEM_QTY                        NUMBER        DEFAULT 0,  
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
  LAST_UPDATED_BY                 NUMBER        NOT NULL
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_VAT_COPPER_ETC IS '구리스크랩등 매입세액 공제신고서';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.COPPER_ETC_ID IS '구리스크랩등 ID';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.TAX_CODE IS '부가세 신고 사업장코드';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.VAT_MNG_SERIAL IS '부가세신고기간구분번호';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.VAT_RECEIPT_TYPE IS '영수증(10)/계산서(20) 구분';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.SUPPLIER_ID IS '매입처ID';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.VAT_COUNT IS 'VAT 매수';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.ITEM_DESC IS '품명';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.ITEM_QTY IS '수량';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.ITEM_AMOUNT IS '취득금액';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.DEEMED_VAT_AMOUNT IS '의제매입세액';

ALTER TABLE FI_VAT_COPPER_ETC ADD CONSTRAINT FI_VAT_COPPER_ETC_PK PRIMARY KEY (SOB_ID, ORG_ID, TAX_CODE, VAT_MNG_SERIAL, VAT_RECEIPT_TYPE, SUPPLIER_ID) USING INDEX TABLESPACE FCM_TS_IDX;

-- INDEX
CREATE UNIQUE INDEX FI_VAT_COPPER_ETC_U1 ON FI_VAT_COPPER_ETC(COPPER_ETC_ID) TABLESPACE FCM_TS_IDX;

CREATE SEQUENCE FI_VAT_COPPER_ETC_S1;
