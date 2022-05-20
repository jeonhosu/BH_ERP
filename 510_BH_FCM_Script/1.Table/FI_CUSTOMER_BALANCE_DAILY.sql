/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_CUSTOMER_BALANCE_DAILY
/* Description  : 계정별 거래처별 잔액원장.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_CUSTOMER_BALANCE_DAILY
( GL_DATE                     DATE          NOT NULL,     -- 전표일자.
  GL_DATE_SEQ                 NUMBER        DEFAULT 1,    -- 생성 구분(0-이월금액, 1-정상금액).
  SOB_ID                      NUMBER        NOT NULL,     -- 회계조직.
  ORG_ID                      NUMBER        NOT NULL,     -- 사업부ID. 
  CUSTOMER_ID                 NUMBER        NOT NULL,     -- 거래처ID.
  ACCOUNT_BOOK_ID             NUMBER        NOT NULL,     -- 회계장부 ID.
  PERIOD_NAME                 VARCHAR2(10)  NOT NULL,     -- 회계년월.
  ACCOUNT_CONTROL_ID          NUMBER        NOT NULL,     -- 계정코드ID.
  ACCOUNT_CODE                VARCHAR2(20)  NOT NULL,     -- 계정코드. 
  CURRENCY_CODE               VARCHAR2(10)  ,             -- 통화. 
  MANAGEMENT1                 VARCHAR2(50)  ,
  MANAGEMENT2                 VARCHAR2(50)  ,
  DR_AMOUNT                   NUMBER        DEFAULT 0,    -- 당월차변합계.
  CR_AMOUNT                   NUMBER        DEFAULT 0,    -- 당월대변합계.
  DR_CURR_AMOUNT              NUMBER        DEFAULT 0,    -- 당월차변합계(외화).  
  CR_CURR_AMOUNT              NUMBER        DEFAULT 0,    -- 당월대변합계(외화).
  CREATION_DATE               DATE          NOT NULL,     -- 생성자.
  CREATED_BY                  NUMBER        NOT NULL,     -- 생성일.
  LAST_UPDATE_DATE            DATE          NOT NULL,     -- 수정자.
  LAST_UPDATED_BY             NUMBER        NOT NULL      -- 수정일.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_CUSTOMER_BALANCE_DAILY IS '일자별 거래처별 계정별 잔액';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.GL_DATE IS '전표일자';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.GL_DATE_SEQ IS '생성구분(0-이월,1-정상)';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.CUSTOMER_ID IS '거래처코드';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.ACCOUNT_BOOK_ID IS '회계장부ID';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.PERIOD_NAME IS '회계년월';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.ACCOUNT_CONTROL_ID IS '계정통제ID';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.DR_AMOUNT IS '당일차변합계';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.CR_AMOUNT IS '당일대변합계';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.DR_CURR_AMOUNT IS '당일차변합계(외화)';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.CR_CURR_AMOUNT IS '당일대변합계(외화)';

CREATE UNIQUE INDEX FI_CUSTOMER_BALANCE_DAILY_PK ON 
  FI_CUSTOMER_BALANCE_DAILY(GL_DATE, GL_DATE_SEQ, SOB_ID, CUSTOMER_ID, ACCOUNT_BOOK_ID, ACCOUNT_CONTROL_ID, CURRENCY_CODE)
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

ALTER TABLE FI_CUSTOMER_BALANCE_DAILY ADD ( 
  CONSTRAINT FI_CUSTOMER_BALANCE_DAILY_PK PRIMARY KEY (GL_DATE, GL_DATE_SEQ, SOB_ID, CUSTOMER_ID, ACCOUNT_BOOK_ID, ACCOUNT_CONTROL_ID, CURRENCY_CODE)
        );
