/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_MASTER
/* Description  : 세금계산서집계
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_MASTER 
( VAT_ID                          NUMBER        NOT NULL,   -- 세금계산서ID.
  TAX_CODE                        VARCHAR2(10)  NOT NULL,   -- 사업장 코드(공통코드-TAX-CODE).
  VAT_ISSUE_DATE                  DATE          NOT NULL,   -- 계산서발행일.
  VAT_TYPE                        VARCHAR2(4)   NOT NULL,   -- 계산서 유형.
  VAT_GUBUN                       VARCHAR2(10)  NOT NULL,   -- 매입매출구분.
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  CUSTOMER_ID                     NUMBER        NOT NULL,   -- 공급자/거래처ID.
  GL_AMOUNT                       NUMBER        DEFAULT 0,  -- 공급가액.
  VAT_AMOUNT                      NUMBER        DEFAULT 0,  -- 부가세 금액.
  VAT_COUNT                       NUMBER(3)     DEFAULT 1,  -- 계산서매수.
  REMARK                          VARCHAR2(200) ,           -- 적요.
  CURRENCY_CODE                   VARCHAR2(10)  ,           -- 통화.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,  -- 환율.
  GL_CURR_AMOUNT                  NUMBER        DEFAULT 0,  -- 통화 공급가액.
  VAT_CURR_AMOUNT                 NUMBER        DEFAULT 0,  -- 통화 부가세 금액.
  PERIOD_NAME                     VARCHAR2(10)  ,           -- 회계년월.  
  BUSINESS_TYPE                   VARCHAR2(10)  ,           -- 거래처구분(C-사업자/P-개인)
  TAX_ELECTRO_YN                  CHAR(1)       DEFAULT 'N',-- 전자세금계산서 형태(N.일반, Y.전자).
  VAT_STATE                       CHAR(1)       DEFAULT '0',-- 0:미신고, 1:확정신고, 2:수정신고
  CREATED_TYPE                    CHAR(1)       DEFAULT 'A',-- 생성구분(A-자동생성, M-수기입력).
  CLOSED_YN                       CHAR(1)       DEFAULT 'N',-- 마감여부(Y:마감, N:미마감)
  CLOSED_DATE                     DATE          ,           -- 마감일시.
  CLOSED_PERSON_ID                NUMBER        ,           -- 마감처리자.
  RESIDENT_REG_NUM                VARCHAR2(50)  ,           -- 주민번호.
  CREDITCARD_CODE                 VARCHAR2(50)  ,           -- 신용카드번호.
  CASH_RECEIPT_NUM                VARCHAR2(50)  ,           -- 현금영수증 승인번호.
  DOCUMENT_NUM                    VARCHAR2(50)  ,           -- L/C번호(수출신고,신용장번호).
  SHIPPING_DATE                   DATE          ,           -- 선적일자.
  BANK_CODE                       VARCHAR2(30)  ,           -- 발급은행코드.
  INPUT_DED_NOT_CODE              VARCHAR2(10)  ,           -- 매입세액불공제사유코드.
  INPUT_FREE_CODE                 VARCHAR2(10)  ,           -- 면세매입사유코드.
  INPUT_DEEMED_TAX_CODE           VARCHAR2(10)  ,           -- 의제매입세액사유.
  SLIP_HEADER_ID                  NUMBER        ,           -- 전표 헤더 ID.
  SLIP_LINE_ID                    NUMBER        ,           -- 전표 라인 ID.
  GL_NUM                          VARCHAR2(30)  ,           -- 회계번호.
  GL_DATE                         DATE          NOT NULL,   -- 회계일자.
  ACCOUNT_CONTROL_ID              NUMBER        ,           -- 세금계산서 계정통제ID.
  ACCOUNT_CODE                    VARCHAR2(20)  ,           -- 세금계산서 계정코드.
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

COMMENT ON TABLE FI_VAT_MASTER IS '세금계산서명세';
COMMENT ON COLUMN FI_VAT_MASTER.VAT_ID IS '세금계산서 ID';
COMMENT ON COLUMN FI_VAT_MASTER.TAX_CODE IS '부가세 신고 사업장 코드';
COMMENT ON COLUMN FI_VAT_MASTER.VAT_ISSUE_DATE IS '계산서발행일';
COMMENT ON COLUMN FI_VAT_MASTER.VAT_TYPE IS '계산서 유형';
COMMENT ON COLUMN FI_VAT_MASTER.VAT_GUBUN IS '매입매출구분 1:매입  2:매출';
COMMENT ON COLUMN FI_VAT_MASTER.CUSTOMER_ID IS '공급자/거래처ID';
COMMENT ON COLUMN FI_VAT_MASTER.GL_AMOUNT IS '공급가액';
COMMENT ON COLUMN FI_VAT_MASTER.VAT_AMOUNT IS '부가세';
COMMENT ON COLUMN FI_VAT_MASTER.VAT_COUNT IS '계산서매수';
COMMENT ON COLUMN FI_VAT_MASTER.REMARK IS '적요';
COMMENT ON COLUMN FI_VAT_MASTER.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN FI_VAT_MASTER.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN FI_VAT_MASTER.GL_CURR_AMOUNT IS '외화 공급가액';
COMMENT ON COLUMN FI_VAT_MASTER.VAT_CURR_AMOUNT IS '외화 세액';
COMMENT ON COLUMN FI_VAT_MASTER.PERIOD_NAME IS '회계년월';
COMMENT ON COLUMN FI_VAT_MASTER.BUSINESS_TYPE IS '거래처구분(C-법인/P-개인)';
COMMENT ON COLUMN FI_VAT_MASTER.TAX_ELECTRO_YN IS '전자세금계산서 여부(N:일반, Y:전자)';
COMMENT ON COLUMN FI_VAT_MASTER.VAT_STATE IS '부가세 상태-0:미신고, 1:확정신고, 2:수정신고';
COMMENT ON COLUMN FI_VAT_MASTER.CREATED_TYPE IS '생성구분(A:자동생성,M:수기입력)';
COMMENT ON COLUMN FI_VAT_MASTER.CLOSED_YN IS '마감여부';
COMMENT ON COLUMN FI_VAT_MASTER.CLOSED_DATE IS '마감일시';
COMMENT ON COLUMN FI_VAT_MASTER.CLOSED_PERSON_ID IS '마감처리자';
COMMENT ON COLUMN FI_VAT_MASTER.RESIDENT_REG_NUM IS '주민번호';
COMMENT ON COLUMN FI_VAT_MASTER.CREDITCARD_CODE IS '신용카드코드';
COMMENT ON COLUMN FI_VAT_MASTER.CASH_RECEIPT_NUM IS '현금영수증 승인번호';
COMMENT ON COLUMN FI_VAT_MASTER.DOCUMENT_NUM IS 'L/C번호(수출신고,신용장번호)';
COMMENT ON COLUMN FI_VAT_MASTER.SHIPPING_DATE IS '선적일자';
COMMENT ON COLUMN FI_VAT_MASTER.BANK_CODE IS '발급은행코드';
COMMENT ON COLUMN FI_VAT_MASTER.INPUT_DED_NOT_CODE IS '매입세액불공제사유코드';
COMMENT ON COLUMN FI_VAT_MASTER.INPUT_FREE_CODE IS '면세매입사유코드';
COMMENT ON COLUMN FI_VAT_MASTER.INPUT_DEEMED_TAX_CODE IS '의제매입세액사유';
COMMENT ON COLUMN FI_VAT_MASTER.SLIP_HEADER_ID IS '전표 헤더 ID';
COMMENT ON COLUMN FI_VAT_MASTER.SLIP_LINE_ID IS '전표 라인 ID';
COMMENT ON COLUMN FI_VAT_MASTER.GL_NUM  IS '회계번호';
COMMENT ON COLUMN FI_VAT_MASTER.GL_DATE IS '회계일자';
COMMENT ON COLUMN FI_VAT_MASTER.ACCOUNT_CONTROL_ID IS '계정통제ID';
COMMENT ON COLUMN FI_VAT_MASTER.ACCOUNT_CODE IS '전표계정코드';

--ALTER TABLE FI_VAT_MASTER ADD CONSTRAINT FI_VAT_MASTER_PK PRIMARY KEY ();

CREATE UNIQUE INDEX FI_VAT_MASTER_UN ON FI_VAT_MASTER(VAT_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_MASTER_N1 ON FI_VAT_MASTER(TAX_CODE, VAT_ISSUE_DATE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_MASTER_N2 ON FI_VAT_MASTER(TAX_CODE, VAT_TYPE, SOB_ID)  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_MASTER_N3 ON FI_VAT_MASTER(TAX_CODE, VAT_GUBUN, SOB_ID)  TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE FI_VAT_MASTER_S1;

