/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_PAYABLE_BILL
/* Description  : 지급 어음/전자어음/수표 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_PAYABLE_BILL 
( PAYABLE_BILL_ID                 NUMBER        NOT NULL,   -- 지급어음 원장ID.
  BILL_NUM                        VARCHAR2(30)  NOT NULL,   -- 어음/수표번호.  
  SOB_ID                          NUMBER        NOT NULL,   -- 회사ID.
  ORG_ID                          NUMBER        NOT NULL,   -- 사업부ID.
  BILL_CLASS                      VARCHAR2(1)   NOT NULL,   -- 어음(1)/수표(2) 구분.
  BANK_ID                         NUMBER        NOT NULL,   -- 금융기관ID.
  ISSUE_DATE                      DATE          ,           -- 발행일자.
  DUE_DATE                        DATE          ,           -- 만기일자.
  CUSTOMER_ID                     NUMBER        ,           -- 거래처ID.
  BILL_STATUS                     VARCHAR2(1)   NOT NULL,   -- 어음/수표상태.
  BILL_AMOUNT                     NUMBER        ,           -- 어음/수표금액.
  ACCOUNT_CONTROL_ID              NUMBER        ,           -- 상대계정코드ID.
  ACCOUNT_CODE                    VARCHAR2(20)  ,           -- 상대계정코드.  
  REMARK                          VARCHAR2(150) ,           -- 적요.
  RECEIVE_DATE                    DATE          NOT NULL,   -- 은행 수령일자.
  CLOSE_DATE                      DATE          ,           -- 폐기일자.
  PAYMENT_DATE                    DATE          ,           -- 실결제일.
  BAD_DATE                        DATE          ,           -- 부도일자.
  PAYMENT_CANCEL_DATE             DATE          ,           -- 지급취소일.
  SLIP_LINE_ID                    NUMBER        ,           -- 전표 LINE ID.
  CREATION_DATE                   DATE          NOT NULL,   -- 생성자.
  CREATED_BY                      NUMBER        NOT NULL,   -- 생성일.
  LAST_UPDATE_DATE                DATE          NOT NULL,   -- 수정자.
  LAST_UPDATED_BY                 NUMBER        NOT NULL    -- 수정일.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_PAYABLE_BILL IS '지급어음-사용안함';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.PAYABLE_BILL_ID IS '지급어음 원장ID';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.BILL_NUM IS '어음/수표번호';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.SOB_ID IS '회사ID';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.ORG_ID IS '사업부ID';

COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.BILL_CLASS IS '종이어음/전자어음/수표 구분';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.BANK_ID IS '지급은행';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.ISSUE_DATE IS '발행일자';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.DUE_DATE IS '만기일자';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.CUSTOMER_ID IS '거래처코드';

COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.BILL_STATUS IS '어음/수표상태';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.BILL_AMOUNT IS '어음/수표금액';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.ACCOUNT_CONTROL_ID IS '상대계정코드ID';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.ACCOUNT_CODE IS '상대계정코드';

COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.REMARK IS '적요';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.RECEIVE_DATE IS '수령일자';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.CLOSE_DATE IS '폐기일자';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.PAYMENT_DATE IS '실결제일';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.BAD_DATE IS '부도일자';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.PAYMENT_CANCEL_DATE IS '지급취소일';

COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.PAYMENT_CANCEL_DATE IS '최초DATA생성 일자';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.CREATED_BY IS '최초DATA생성 USER';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.LAST_UPDATE_DATE IS '최종DATA생성 일자';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.LAST_UPDATED_BY IS '최종DATA생성 USER';

CREATE UNIQUE INDEX FI_PAYABLE_BILL_PK ON 
  FI_PAYABLE_BILL(BILL_NUM, SOB_ID)
  TABLESPACE  FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  LOGGING
  STORAGE (
           INITIAL 64K
           MINEXTENTS 1
           MAXEXTENTS 2147483645
          );

ALTER TABLE FI_PAYABLE_BILL ADD ( 
  CONSTRAINT FI_PAYABLE_BILL_PK PRIMARY KEY ( BILL_NUM, SOB_ID)
        );

CREATE UNIQUE INDEX FI_PAYABLE_BILL_U1 ON FI_PAYABLE_BILL(PAYABLE_BILL_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE FI_PAYABLE_BILL_S1;
CREATE SEQUENCE FI_PAYABLE_BILL_S1;
