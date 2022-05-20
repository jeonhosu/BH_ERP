/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_DAILY_SUM
/* Description  : 일계마감 테이블.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_DAILY_SUM 
( GL_DATE                     DATE          NOT NULL,  -- 회계일자.
  GL_DATE_SEQ                 NUMBER        DEFAULT 1,  -- 일자일련번호.
  SOB_ID                      NUMBER        NOT NULL,  -- 회사코드.
  ORG_ID                      NUMBER        NOT NULL,  -- 사업부ID.
  ACCOUNT_CONTROL_ID          NUMBER        NOT NULL,  -- 계정관리ID.
  ACCOUNT_CODE                VARCHAR2(20)  NOT NULL,  -- 계정코드.
  MANAGEMENT1                 VARCHAR2(50)  ,          -- 관리항목1.
  MANAGEMENT2                 VARCHAR2(50)  ,          -- 관리항목2.  
  DR_SUM                      NUMBER(15,0)  DEFAULT 0, -- 차변합계.
  CR_SUM                      NUMBER(15,0)  DEFAULT 0, -- 대변합계.
  CURRENCY_CODE               VARCHAR2(10)  ,          -- 통화.
  OLD_EXCHANGE_RATE           NUMBER        DEFAULT 0,  -- 기존 환율.
  EXCHANGE_RATE               NUMBER        DEFAULT 0,  -- 환율.
  DR_SUM_CURR                 NUMBER(16,4)  DEFAULT 0, -- 차변합계(외화).
  CR_SUM_CURR                 NUMBER(16,4)  DEFAULT 0, -- 대변합계(외화).
  CREATION_DATE               DATE          NOT NULL,  -- 생성자.
  CREATED_BY                  NUMBER        NOT NULL,  -- 생성일.
  LAST_UPDATE_DATE            DATE          NOT NULL,  -- 수정자.
  LAST_UPDATED_BY             NUMBER        NOT NULL   -- 수정일.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_DAILY_SUM IS '일자별 마감테이블';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.GL_DATE IS '회계일자';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.GL_DATE_SEQ IS '0=전월이월잔액 1=당월발생';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.SOB_ID IS '회사ID';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.ACCOUNT_CONTROL_ID IS '계정관리ID';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.MANAGEMENT1 IS '관리항목1';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.MANAGEMENT2 IS '관리항목2';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.DR_SUM IS '차변합계';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.CR_SUM IS '대변합계';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.OLD_EXCHANGE_RATE IS '기존 환율';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.DR_SUM_CURR IS '차변합계(외화)';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.CR_SUM_CURR IS '대변합계(외화)';

CREATE UNIQUE INDEX FI_DAILY_SUM_U1 ON FI_DAILY_SUM(GL_DATE, GL_DATE_SEQ, SOB_ID, ACCOUNT_CONTROL_ID, CURRENCY_CODE) TABLESPACE FCM_TS_IDX;
