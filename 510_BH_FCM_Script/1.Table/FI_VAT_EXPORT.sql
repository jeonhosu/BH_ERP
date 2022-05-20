/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_EXPORT
/* Description  : 수출실적명세서.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_EXPORT 
( EXPORT_ID                       NUMBER        NOT NULL,   -- 수출실적명세서 ID.
  TAX_CODE                        VARCHAR2(20)  NOT NULL,   -- 부가세 신고 사업장코드.
  DOCUMENT_NUM                    VARCHAR2(30)  ,           -- L/C번호(수출신고,신용장번호).
  SOB_ID                          NUMBER        NOT NULL,   
  SHIPPING_DATE                   DATE          ,           -- 선적일자.
  CURRENCY_CODE                   VARCHAR2(10)  ,           -- 통화.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,  -- 환율.
  CURR_AMOUNT                     NUMBER        DEFAULT 0,  -- 외화금액.
  BASE_AMOUNT                     NUMBER        DEFAULT 0,  -- 원화금액.
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

COMMENT ON TABLE FI_VAT_EXPORT IS '수출실적명세서';
COMMENT ON COLUMN FI_VAT_EXPORT.EXPORT_ID IS '수출실적명세서ID';
COMMENT ON COLUMN FI_VAT_EXPORT.TAX_CODE IS '부가세 신고 사업장코드';
COMMENT ON COLUMN FI_VAT_EXPORT.DOCUMENT_NUM IS 'L/C번호(수출신고,신용장번호)';
COMMENT ON COLUMN FI_VAT_EXPORT.SHIPPING_DATE IS '선적일자';
COMMENT ON COLUMN FI_VAT_EXPORT.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN FI_VAT_EXPORT.EXCHANGE_RATE  IS '환율';
COMMENT ON COLUMN FI_VAT_EXPORT.CURR_AMOUNT IS '외화금액';
COMMENT ON COLUMN FI_VAT_EXPORT.BASE_AMOUNT IS '원화금액';
COMMENT ON COLUMN FI_VAT_EXPORT.CLOSED_YN IS '마감여부';
COMMENT ON COLUMN FI_VAT_EXPORT.CLOSED_DATE IS '마감일시';
COMMENT ON COLUMN FI_VAT_EXPORT.CLOSED_PERSON_ID IS '마감처리자';
COMMENT ON COLUMN FI_VAT_EXPORT.CREATED_TYPE IS '생성구분(I-INTEFACE생성, M-수기생성)';
COMMENT ON COLUMN FI_VAT_EXPORT.SOURCE_TABLE IS '관련 테이블';
COMMENT ON COLUMN FI_VAT_EXPORT.INTERFACE_HEADER_ID IS '관련 헤더 ID';
COMMENT ON COLUMN FI_VAT_EXPORT.INTERFACE_LINE_ID IS '관련 라인ID';


ALTER TABLE FI_VAT_EXPORT ADD CONSTRAINT FI_VAT_EXPORT_PK PRIMARY KEY (EXPORT_ID);

CREATE INDEX FI_VAT_EXPORT_N1 ON FI_VAT_EXPORT(TAX_CODE, SHIPPING_DATE, SOB_ID)  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_EXPORT_N2 ON FI_VAT_EXPORT(TAX_CODE, DOCUMENT_NUM, SHIPPING_DATE, SOB_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE FI_VAT_EXPORT_S1;
