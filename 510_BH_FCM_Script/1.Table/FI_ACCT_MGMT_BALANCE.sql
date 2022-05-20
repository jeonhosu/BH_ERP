/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_ACCT_MGMT_BALANCE
/* Description  :  계좌 및 관리항목별 일계마감 테이블.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_ACCT_MGMT_BALANCE
( ACCT_MGMT_BALANCE_ID        NUMBER        NOT NULL,  -- 계정관리항목별 잔액 ID
  GL_DATE                     DATE          NOT NULL,  -- 회계일자.
  GL_DATE_SEQ                 NUMBER        DEFAULT 1, -- 일자일련번호.
  SOB_ID                      NUMBER        NOT NULL,  -- 회사코드.
  ORG_ID                      NUMBER        NOT NULL,  -- 사업부ID.
  ACCOUNT_BOOK_ID             NUMBER        NOT NULL,
  PERIOD_NAME                 VARCHAR2(10)  NOT NULL,
  ACCOUNT_CONTROL_ID          NUMBER        NOT NULL,  -- 계정관리ID.
  ACCOUNT_CODE                VARCHAR2(20)  NOT NULL,  -- 계정코드.
  CURRENCY_CODE               VARCHAR2(10)  ,          -- 통화.
  ACCT_MGMT_SEQ               NUMBER        DEFAULT 1, -- 같은 계정에 대한 일련번호.
  DR_SUM                      NUMBER        DEFAULT 0, -- 차변합계.
  CR_SUM                      NUMBER        DEFAULT 0, -- 대변합계.
  DR_CURR_SUM                 NUMBER        DEFAULT 0, -- 차변합계(외화).
  CR_CURR_SUM                 NUMBER        DEFAULT 0, -- 대변합계(외화).
  CREATION_DATE               DATE          NOT NULL,  -- 생성자.
  CREATED_BY                  NUMBER        NOT NULL,  -- 생성일.
  LAST_UPDATE_DATE            DATE          NOT NULL,  -- 수정자.
  LAST_UPDATED_BY             NUMBER        NOT NULL   -- 수정일.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_ACCT_MGMT_BALANCE IS '일계마감테이블';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.ACCT_MGMT_BALANCE_ID IS '계정관리항목별 잔액 ID';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.GL_DATE IS '회계일자';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.GL_DATE_SEQ IS '0=전월이월잔액 1=당월발생';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.SOB_ID IS '회사ID';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.ACCOUNT_CONTROL_ID IS '계정관리ID';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.ACCT_MGMT_SEQ IS '일련번호';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.DR_SUM IS '차변합계';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.CR_SUM IS '대변합계';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.DR_CURR_SUM IS '차변합계(외화)';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.CR_CURR_SUM IS '대변합계(외화)';

CREATE UNIQUE INDEX FI_ACCT_MGMT_BALANCE_PK ON 
  FI_ACCT_MGMT_BALANCE(GL_DATE, GL_DATE_SEQ, SOB_ID, ACCOUNT_CONTROL_ID, CURRENCY_CODE, ACCT_MGMT_SEQ)
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

ALTER TABLE FI_ACCT_MGMT_BALANCE ADD ( 
  CONSTRAINT FI_ACCT_MGMT_BALANCE_PK PRIMARY KEY (GL_DATE, GL_DATE_SEQ, SOB_ID, ACCOUNT_CONTROL_ID, CURRENCY_CODE, ACCT_MGMT_SEQ)
        );

CREATE UNIQUE INDEX FI_ACCT_MGMT_BALANCE_U1 ON FI_ACCT_MGMT_BALANCE(ACCT_MGMT_BALANCE_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_ACCT_MGMT_BALANCE_N1 ON FI_ACCT_MGMT_BALANCE(GL_DATE, GL_DATE_SEQ, SOB_ID, ACCOUNT_CODE) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_ACCT_MGMT_BALANCE_N2 ON FI_ACCT_MGMT_BALANCE(ACCOUNT_CONTROL_ID, SOB_ID) TABLESPACE FCM_TS_IDX;

CREATE SEQUENCE FI_ACCT_MGMT_BALANCE_S1;
