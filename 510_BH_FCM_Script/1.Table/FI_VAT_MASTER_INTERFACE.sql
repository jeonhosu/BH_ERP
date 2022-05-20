/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_MASTER_INTERFACE
/* Description  : 세금계산서집계-미승인 전표(결의전표) 자료.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_MASTER_INTERFACE 
( LINE_INTERFACE_ID               NUMBER        NOT NULL    -- 전표 라인 ID.
, HEADER_INTERFACE_ID             NUMBER        NOT NULL    -- 전표 헤더 ID.
, SOB_ID                          NUMBER        NOT NULL
, ORG_ID                          NUMBER        NOT NULL
, GL_DATE                         DATE          NOT NULL    -- 회계일자.
, GL_NUM                          VARCHAR2(30)              -- 회계번호.
, PERIOD_NAME                     VARCHAR2(10)              -- 회계년월.
, VAT_GUBUN                       VARCHAR2(10)  NOT NULL    -- 매입매출구분.
, TAX_INVOICE_TYPE                CHAR(1)       NOT NULL    -- 세금계산서 형태(1.일반, 2.전자).
, SLIP_TYPE                       VARCHAR2(10)  NOT NULL    -- 전표유형.
, VAT_ISSUE_DATE                  DATE                      -- 계산서발행일.   
, ACCOUNT_CONTROL_ID              NUMBER        NOT NULL    -- 전표계정통제ID.
, ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL    -- 전표계정코드.
, GL_AMOUNT                       NUMBER        DEFAULT 0   -- 공급가액.
, VAT_AMOUNT                      NUMBER        DEFAULT 0   -- 부가세 금액.
, VAT_SLIP_COUNT                  NUMBER(3)     DEFAULT 1   -- 계산서매수.
, VAT_NOTICE                      CHAR(1)       DEFAULT '0' -- 0:미신고, 1:확정신고, 2:수정신고
, SUPPLIER_ID                     NUMBER                    -- 공급자 거래처ID.
, RESIDENT_REG_NUM                VARCHAR2(2)               -- 주민번호.
, TAX_CODE                        VARCHAR2(10)              -- 피공급자 사업장 세금계산서 코드.
, CONSIGNEE_ID                    NUMBER                    -- 피공급자 거래처ID.
, VAT_TYPE_ID                     NUMBER                    -- 부가세 증빙 ID.
, VOUCH_CODE                      VARCHAR2(50)              -- 증빙코드.
, VAT_REASON_CODE                 VARCHAR2(50)              -- 부가세 사유.
, CREDITCARD_CODE                 VARCHAR2(50)              -- 신용카드번호.
, CASH_RECEIPT_NUM                VARCHAR2(20)              -- 현금영수증 승인번호.
, BURGET_ACCOUNT_CONTROL_ID       NUMBER                    -- 세금계산서(공통분)상대계정 계정통제ID.
, BURGET_ACCOUNT_CODE             VARCHAR2(20)              -- 세금계산서(공통분)상대계정 계정코드.
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_VAT_MASTER_INTERFACE IS '세금계산서명세 - 전표 인터페이스';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.LINE_INTERFACE_ID IS '전표 라인 ID';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.HEADER_INTERFACE_ID IS '전표 헤더 ID';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.GL_DATE IS '회계일자';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.GL_NUM  IS '회계번호';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.PERIOD_NAME IS '회계년월';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.VAT_GUBUN IS '매입매출구분 1:매입  2:매출';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.TAX_INVOICE_TYPE IS '세금계산서 형태(1.일반, 2.전자)';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.SLIP_TYPE IS '전표유형';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.VAT_ISSUE_DATE IS '계산서발행일';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.ACCOUNT_CONTROL_ID IS '계정통제ID';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.ACCOUNT_CODE IS '전표계정코드';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.GL_AMOUNT IS '공급가액';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.VAT_AMOUNT IS '부가세';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.VAT_SLIP_COUNT IS '계산서매수';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.VAT_NOTICE IS '0:미신고, 1:확정신고, 2:수정신고';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.SUPPLIER_ID IS '공급자사업자번호';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.RESIDENT_REG_NUM IS '주민번호';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.TAX_CODE IS '피공급자 사업장';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.CONSIGNEE_ID IS '피공급자사업자번호';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.VAT_TYPE_ID IS '부가세 증빙 ID-VAT_TYPE_AP/VAT_TYPE_AR';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.VOUCH_CODE IS '거래증빙코드';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.VAT_REASON_CODE IS '부가세 사유';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.CASH_RECEIPT_NUM IS '현금영수증 승인번호';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.CREDITCARD_CODE IS '신용카드코드';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.BURGET_ACCOUNT_CONTROL_ID IS '세금계산서(공통분)상대계정 계정통제ID';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.BURGET_ACCOUNT_CODE IS '세금계산서(공통분)상대계정 계정코드';

CREATE UNIQUE INDEX FI_VAT_MASTER_INTERFACE_PK ON 
  FI_VAT_MASTER_INTERFACE(LINE_INTERFACE_ID)
  TABLESPACE FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  LOGGING
  STORAGE (
           INITIAL 64K
           MINEXTENTS 1
           MAXEXTENTS 2147483645
          );

ALTER TABLE FI_VAT_MASTER_INTERFACE ADD ( 
  CONSTRAINT FI_VAT_MASTER_INTERFACE_PK PRIMARY KEY (LINE_INTERFACE_ID) 
        );
        
CREATE INDEX FI_VAT_MASTER_INTERFACE_N1 ON FI_VAT_MASTER_INTERFACE(SUPPLIER_ID, TAX_CODE, VAT_GUBUN)  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_MASTER_INTERFACE_N2 ON FI_VAT_MASTER_INTERFACE(GL_DATE, SOB_ID) TABLESPACE FCM_TS_IDX;
  
