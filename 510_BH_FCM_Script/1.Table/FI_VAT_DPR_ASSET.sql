/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_DPR_ASSET
/* Description  : 감가상각취득명세서 내역.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_DPR_ASSET 
( DPR_ASSET_ID                    NUMBER        NOT NULL,   -- 감가상각취득명세서 ID.
  TAX_CODE                        VARCHAR(10)   NOT NULL,   -- 부가세 신고 사업자코드.
  ACQUIRE_DATE                    DATE          NOT NULL,   -- 취득일자.  
  ACCOUNT_CONTROL_ID              NUMBER        NOT NULL,   -- 계정통제ID.
  VAT_ASSET_GB                    VARCHAR2(10)  NOT NULL,   -- 감가상각 자산구분.
  CUSTOMER_ID                     NUMBER        NOT NULL,   -- 거래처ID.
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  GL_AMOUNT                       NUMBER        DEFAULT 0,  -- 공급가액.
  VAT_AMOUNT                      NUMBER        DEFAULT 0,  -- 부가세 금액.
  CURRENCY_CODE                   VARCHAR2(10)  ,           -- 통화.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,  -- 환율.
  GL_CURR_AMOUNT                  NUMBER        DEFAULT 0,  -- 통화 공급가액.
  VAT_CURR_AMOUNT                 NUMBER        DEFAULT 0,  -- 통화 부가세 금액.
  REMARK                          VARCHAR2(200) ,           -- 적요.
  CLOSED_YN                       CHAR(1)       DEFAULT 'N',-- 마감구분.
  CLOSED_DATE                     DATE          ,           -- 마감일시.
  CLOSED_PERSON_ID                NUMBER        ,           -- 마감처리자.
  CREATED_TYPE                    VARCHAR2(2)   ,           -- 생성구분(I-INTERFACE, M-수기).
  SOURCE_TABLE                    VARCHAR2(100) ,
  INTERFACE_HEADER_ID             NUMBER        ,
  INTERFACE_LINE_ID               NUMBER        ,
  ATTRIBUTE_A                     VARCHAR2(100) ,
  ATTRIBUTE_B                     VARCHAR2(100) ,
  ATTRIBUTE_C                     VARCHAR2(100) ,
  ATTRIBUTE_D                     VARCHAR2(100) ,
  ATTRIBUTE_E                     VARCHAR2(100) ,
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

COMMENT ON TABLE FI_VAT_DPR_ASSET IS '감가상각취득명세서 내역';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.DPR_ASSET_ID IS '감가상각취명세 ID';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.TAX_CODE IS '부가세신고 사업장코드';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.ACQUIRE_DATE IS '취득일자';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.ACCOUNT_CONTROL_ID IS '계정통제ID';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.VAT_ASSET_GB IS '감가상각 자산구분';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.CUSTOMER_ID IS '거래처ID';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.GL_AMOUNT IS '공급가액';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.VAT_AMOUNT IS '부가세';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.GL_CURR_AMOUNT IS '외화 공급가액';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.VAT_CURR_AMOUNT IS '외화 부가세액';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.REMARK IS '적요';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.CLOSED_YN IS '마감여부';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.CLOSED_DATE IS '마감일시';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.CLOSED_PERSON_ID IS '마감처리자';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.CREATED_TYPE IS '생성구분(I-INTEFACE생성, M-수기생성)';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.SOURCE_TABLE IS '관련 테이블';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.INTERFACE_HEADER_ID IS '관련 헤더 ID';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.INTERFACE_LINE_ID IS '관련 라인ID';

ALTER TABLE FI_VAT_DPR_ASSET ADD CONSTRAINT FI_VAT_DPR_ASSET_PK PRIMARY KEY (DPR_ASSET_ID);
CREATE INDEX FI_VAT_DPR_ASSET_N1 ON FI_VAT_DPR_ASSET(TAX_CODE, ACQUIRE_DATE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_DPR_ASSET_N2 ON FI_VAT_DPR_ASSET(TAX_CODE, CUSTOMER_ID, SOB_ID)  TABLESPACE FCM_TS_IDX;

CREATE SEQUENCE FI_VAT_DPR_ASSET_S1;
