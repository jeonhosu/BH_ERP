/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_TRIAL_BALANCE_PL
/* Description  : 손익계정집계
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_TRIAL_BALANCE_PL
( PERIOD_NAME                     VARCHAR2(10)  NOT NULL,  -- 회계년월.
  SOB_ID                          NUMBER        NOT NULL,  -- 회사ID.
  ORG_ID                          NUMBER        NOT NULL,  -- 사업부ID.
  ACCOUNT_BOOK_ID                 NUMBER        NOT NULL,  
  ACCOUNT_CONTROL_ID              NUMBER        NOT NULL,  -- 계정관리 ID.
  ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL,  -- 계정코드.    
  THIS_DR_AMOUNT                  NUMBER(16)    DEFAULT 0,  -- 당월차변.
  THIS_CR_AMOUNT                  NUMBER(16)    DEFAULT 0,  -- 당월대변.  
  THIS_REMAIN_AMOUNT              NUMBER(16)    DEFAULT 0,  -- 당월잔액.
  TOTAL_DR_AMOUNT                 NUMBER(16)    DEFAULT 0,  -- 누계차변(실적+조정).
  TOTAL_CR_AMOUNT                 NUMBER(16)    DEFAULT 0,  -- 누계대변(실적+조정).    
  TOTAL_REMAIN_AMOUNT             NUMBER(16)    DEFAULT 0,  -- 누적잔액.  
  CREATION_DATE                   DATE          NOT NULL,
  CREATED_BY                      NUMBER        NOT NULL,  
  LAST_UPDATE_DATE                DATE          NOT NULL,  -- 최종수정일자.
  LAST_UPDATED_BY                 NUMBER        NOT NULL   -- 최종수정자.   
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_TRIAL_BALANCE_PL IS '손익계정집계';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_PL.PERIOD_NAME IS '실적년월';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_PL.SOB_ID IS '회계조직';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_PL.ORG_ID IS '사업부ID';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_PL.ACCOUNT_BOOK_ID IS '회계장부 ID'; 
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_PL.ACCOUNT_CONTROL_ID IS '계정관리 ID'; 
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_PL.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_PL.THIS_DR_AMOUNT IS '당월차변';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_PL.THIS_CR_AMOUNT IS '당월대변';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_PL.THIS_REMAIN_AMOUNT IS '당월잔액';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_PL.TOTAL_DR_AMOUNT IS '누계차변(실적+조정)';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_PL.TOTAL_CR_AMOUNT IS '누계대변(실적+조정)';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_PL.TOTAL_REMAIN_AMOUNT IS '누적잔액';

CREATE UNIQUE INDEX FI_TRIAL_BALANCE_PL_PK ON 
  FI_TRIAL_BALANCE_PL(PERIOD_NAME, ACCOUNT_BOOK_ID, ACCOUNT_CONTROL_ID, SOB_ID )
  TABLESPACE FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  LOGGING
  STORAGE (
           INITIAL 20M
           MINEXTENTS 1
           MAXEXTENTS 2147483645
          );

ALTER TABLE FI_TRIAL_BALANCE_PL ADD ( 
  CONSTRAINT FI_TRIAL_BALANCE_PL_PK PRIMARY KEY (PERIOD_NAME, ACCOUNT_BOOK_ID, ACCOUNT_CONTROL_ID, SOB_ID )
        );
