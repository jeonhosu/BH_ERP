/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_DAILY_SUM
/* Description  : 은행계좌별 일마감테이블
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_DAILY_BANK_ACCOUNT_SUM
( GL_DATE                         DATE          NOT NULL,  -- 회계일자.
  GL_DATE_SEQ                     NUMBER        DEFAULT 1,  -- 일자일련번호.
  SOB_ID                          NUMBER        NOT NULL,  -- 회사ID.
  ORG_ID                          NUMBER        NOT NULL,
  ACCOUNT_BOOK_ID                 NUMBER        NOT NULL,
  ACCOUNT_CONTROL_ID              NUMBER        NOT NULL,  -- 계정관리ID.
  ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL,  -- 계정코드.
  BANK_ACCOUNT_ID                 NUMBER        NOT NULL,  -- 계좌ID.
  DR_AMOUNT                       NUMBER(15)    DEFAULT 0,  -- 차변합계.
  CR_AMOUNT                       NUMBER(15)    DEFAULT 0,  -- 대변합계.
  OLD_EXCHANGE_RATE               NUMBER        DEFAULT 0,  -- 기존 환율.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,  -- 환율.
  DR_CURR_AMOUNT                  NUMBER(16,4)  DEFAULT 0,  -- 차변합계(외화).
  CR_CURR_AMOUNT                  NUMBER(16,4)  DEFAULT 0,  -- 대변합계(외화).
  CREATION_DATE                   DATE          NOT NULL,
  CREATED_BY                      NUMBER        NOT NULL,
  LAST_UPDATE_DATE                DATE          NOT NULL,
  LAST_UPDATED_BY                 NUMBER        NOT NULL
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_DAILY_BANK_ACCOUNT_SUM IS '은행계좌별 일마감테이블';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.GL_DATE IS '회계일자';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.GL_DATE_SEQ IS '0=전월이월잔액 1=당월발생';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.SOB_ID IS '회사ID';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.ACCOUNT_BOOK_ID IS '회계장부 ID';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.ACCOUNT_CONTROL_ID IS '계정관리ID';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.BANK_ACCOUNT_ID IS '계좌ID';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.DR_AMOUNT IS '차변합계';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.CR_AMOUNT IS '대변합계';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.OLD_EXCHANGE_RATE IS '기존환율';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.DR_CURR_AMOUNT IS '차변합계(외화)';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.CR_CURR_AMOUNT IS '대변합계(외화)';

CREATE UNIQUE INDEX FI_DAILY_BANK_ACCOUNT_SUM_PK ON 
  FI_DAILY_BANK_ACCOUNT_SUM(GL_DATE, GL_DATE_SEQ, SOB_ID, ACCOUNT_CONTROL_ID, BANK_ACCOUNT_ID)
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
          
ALTER TABLE FI_DAILY_BANK_ACCOUNT_SUM ADD ( 
  CONSTRAINT FI_DAILY_BANK_ACCOUNT_SUM_PK PRIMARY KEY ( GL_DATE, GL_DATE_SEQ, SOB_ID, ACCOUNT_CONTROL_ID, BANK_ACCOUNT_ID)
        );          

CREATE INDEX FI_DAILY_BANK_ACCOUNT_SUM_N1 ON 
  FI_DAILY_BANK_ACCOUNT_SUM(ACCOUNT_CODE)
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

