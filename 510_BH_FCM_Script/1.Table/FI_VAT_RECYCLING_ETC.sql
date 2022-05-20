/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_RECYCLING_ETC
/* Description  : 재활용폐자원 및 중고자동차 매입세액 공제신고서 
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_RECYCLING_ETC
( RECYCLING_ETC_ID                NUMBER        NOT NULL,   
  SOB_ID                          NUMBER        NOT NULL,   
  ORG_ID                          NUMBER        NOT NULL, 
  TAX_CODE                        VARCHAR2(20)  NOT NULL,   
  VAT_MNG_SERIAL                  NUMBER        NOT NULL,   
  SALES_PRE_AMOUNT                NUMBER        DEFAULT 0,
  SALES_FIX_AMOUNT                NUMBER        DEFAULT 0, 
  LIMIT_RATE_NUMERATOR            NUMBER        DEFAULT 0,
  LIMIT_RATE_DENOMINATOR          NUMBER        DEFAULT 0,
  LIMIT_RATE                      NUMBER        DEFAULT 0,
  LIMIT_AMOUNT                    NUMBER        DEFAULT 0,
  PURCHASES_TAX_BILL_AMOUNT       NUMBER        DEFAULT 0,
  PURCHASES_BILL_AMOUNT           NUMBER        DEFAULT 0,
  DED_RANGE_AMOUNT                NUMBER        DEFAULT 0,
  DED_TARGET_AMOUNT               NUMBER        DEFAULT 0,
  DED_RATE_NUMERATOR              NUMBER        DEFAULT 0,
  DED_RATE_DENOMINATOR            NUMBER        DEFAULT 0,
  DED_RATE                        NUMBER        DEFAULT 0,
  DED_VAT_AMOUNT                  NUMBER        DEFAULT 0,
  DED_PRE_QUARTER_AMOUNT          NUMBER        DEFAULT 0,
  DED_PRE_MONTHLY_AMOUNT          NUMBER        DEFAULT 0,
  FIX_VAT_AMOUNT                  NUMBER        DEFAULT 0,
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

COMMENT ON TABLE FI_VAT_RECYCLING_ETC IS '재활용폐자원 및 중고자동차 매입세액 공제신고서';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.RECYCLING_ETC_ID IS '재활용폐자원 및 중고자동차 매입세액 ID';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.TAX_CODE IS '부가세 신고 사업장코드';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.VAT_MNG_SERIAL IS '부가세신고기간구분번호';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.SALES_PRE_AMOUNT IS '매출액-예정분';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.SALES_FIX_AMOUNT IS '매출금-확정분';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.LIMIT_RATE IS '대상액 한도율(80/100)';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.LIMIT_RATE_NUMERATOR IS '대상액 한도액 분자';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.LIMIT_RATE_DENOMINATOR IS '대상액 한도액 분모';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.PURCHASES_TAX_BILL_AMOUNT IS '당기매입액 세금계산서분';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.PURCHASES_BILL_AMOUNT IS '당기매입액 영수증등';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.DED_RANGE_AMOUNT IS '공제가능금액';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.DED_TARGET_AMOUNT IS '공제대상금액(공제가능금액과 당기매입액 영수증 금액중 적은 금액)';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.DED_RATE_NUMERATOR IS '공제대상액 공제율 분자';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.DED_RATE_DENOMINATOR IS '공제대상액 공제율 분모';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.DED_VAT_AMOUNT IS '공제대상세액';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.DED_PRE_QUARTER_AMOUNT IS '이미공제받은 세액-예정신고분';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.DED_PRE_MONTHLY_AMOUNT IS '이미공제받은 세액-월별조기분';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.FIX_VAT_AMOUNT IS '공제(납부)할 세액(공제대상세액-이미공제받은 세액 합계)';

ALTER TABLE FI_VAT_RECYCLING_ETC ADD CONSTRAINT FI_VAT_RECYCLING_ETC_PK PRIMARY KEY (SOB_ID, ORG_ID, TAX_CODE, VAT_MNG_SERIAL) USING INDEX TABLESPACE FCM_TS_IDX;

-- INDEX
CREATE UNIQUE INDEX FI_VAT_RECYCLING_ETC_U1 ON FI_VAT_RECYCLING_ETC(RECYCLING_ETC_ID) TABLESPACE FCM_TS_IDX;

CREATE SEQUENCE FI_VAT_RECYCLING_ETC_S1;
