/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_ZERO_TAX_RATE
/* Description  : 영세율첨부서류.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_ZERO_TAX_RATE 
( ZERO_TAX_RATE_ID                NUMBER        NOT NULL,   -- 영세율첨부서류 ID.
  TAX_CODE                        VARCHAR2(20)  NOT NULL,   -- 부가세 신고 사업장코드.
  SOB_ID                          NUMBER        NOT NULL,   
  DOCUMENT_TYPE                   VARCHAR2(10)  NOT NULL,   -- 서류구분.
  ISSUER_NAME                     VARCHAR2(100) ,           -- 발급자.
  ISSUE_DATE                      DATE          ,           -- 발급일자.
  SHIPPING_DATE                   DATE          ,           -- 선적일자.                   
  DOCUMENT_NUM                    VARCHAR2(50)  ,           -- L/C번호(수출신고,신용장번호).
  CURRENCY_CODE                   VARCHAR2(10)  ,           -- 통화.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,  -- 환율.
  TOTAL_CURR_AMOUNT               NUMBER        DEFAULT 0,  -- 당기제출 외화금액.
  TOTAL_BASE_AMOUNT               NUMBER        DEFAULT 0,  -- 당기제출 원화금액.
  THIS_CURR_AMOUNT                NUMBER        DEFAULT 0,  -- 당기신고 외화금액.
  THIS_BASE_AMOUNT                NUMBER        DEFAULT 0,  -- 당기신고 원화금액.
  VAT_ISSUE_DATE                  DATE          NOT NULL,   -- 세금계산서 발급일자.
  BANK_CODE                       VARCHAR2(20)  ,           -- 발급은행.
  CUSTOMER_CODE                   VARCHAR2(50)  ,           -- 거래처코드.
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

COMMENT ON TABLE FI_VAT_ZERO_TAX_RATE IS '영세율첨부서류';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.ZERO_TAX_RATE_ID IS '영세율첨부서류 ID';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.TAX_CODE IS '부가세 신고 사업장코드';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.DOCUMENT_TYPE IS '서류구분';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.ISSUER_NAME IS '발급자';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.ISSUE_DATE IS '발급일자';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.SHIPPING_DATE IS '선적일자';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.DOCUMENT_NUM IS 'L/C번호(수출신고,신용장번호)';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.EXCHANGE_RATE  IS '환율';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.TOTAL_CURR_AMOUNT IS '당기제출 외화금액';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.TOTAL_BASE_AMOUNT IS '당기제출 원화금액';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.THIS_CURR_AMOUNT IS '당기신고 외화금액';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.THIS_BASE_AMOUNT IS '당기신고 원화금액';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.VAT_ISSUE_DATE IS '세금계산서 발행일자';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.BANK_CODE IS '발급은행코드';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.CUSTOMER_CODE IS '거래처코드';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.CLOSED_YN IS '마감여부';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.CLOSED_DATE IS '마감일시';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.CLOSED_PERSON_ID IS '마감처리자';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.CREATED_TYPE IS '생성구분(I-INTEFACE생성, M-수기생성)';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.SOURCE_TABLE IS '관련 테이블';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.INTERFACE_HEADER_ID IS '관련 헤더 ID';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.INTERFACE_LINE_ID IS '관련 라인ID';

ALTER TABLE FI_VAT_ZERO_TAX_RATE ADD CONSTRAINT FI_VAT_ZERO_TAX_RATE_PK PRIMARY KEY (ZERO_TAX_RATE_ID);

CREATE INDEX FI_VAT_ZERO_TAX_RATE_N1 ON FI_VAT_ZERO_TAX_RATE(VAT_ISSUE_DATE, NVL(DOCUMENT_NUM, '-'), TAX_CODE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_ZERO_TAX_RATE_N2 ON FI_VAT_ZERO_TAX_RATE(ISSUE_DATE, TAX_CODE, SOB_ID)  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_ZERO_TAX_RATE_N3 ON FI_VAT_ZERO_TAX_RATE(ISSUE_DATE, CUSTOMER_CODE, TAX_CODE, SOB_ID) TABLESPACE FCM_TS_IDX;
  
CREATE SEQUENCE FI_VAT_ZERO_TAX_RATE_S1;
