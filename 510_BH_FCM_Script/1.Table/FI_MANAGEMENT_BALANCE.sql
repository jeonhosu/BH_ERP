/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_MANAGEMENT_BALANCE
/* Description  : 계정별 관리항목별 일자별 금액.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_MANAGEMENT_BALANCE
( GL_DATE                     DATE          NOT NULL,  -- 회계일자.
  GL_DATE_SEQ                 NUMBER        DEFAULT 1,  -- 일자일련번호.
  SOB_ID                      NUMBER        NOT NULL,  -- 회사코드.
  ORG_ID                      NUMBER        NOT NULL,  -- 사업부ID.
  ACCOUNT_CONTROL_ID          NUMBER        NOT NULL,  -- 계정관리ID. 
  MANAGEMENT_ID               NUMBER        NOT NULL,  -- 관리항목 ID.    
  MANAGEMENT_VALUE            VARCHAR2(50)  NOT NULL,  -- 관리항목 값.
  DR_SUM                      NUMBER        DEFAULT 0, -- 차변합계.
  CR_SUM                      NUMBER        DEFAULT 0, -- 대변합계.
  CURRENCY_CODE               VARCHAR2(10)  ,          -- 통화.
  OLD_EXCHANGE_RATE           NUMBER        DEFAULT 0,  -- 기존 환율.
  EXCHANGE_RATE               NUMBER        DEFAULT 0,  -- 환율.
  DR_CURR_SUM                 NUMBER        DEFAULT 0, -- 차변합계(외화).
  CR_CURR_SUM                 NUMBER        DEFAULT 0, -- 대변합계(외화).
  ACCOUNT_CODE                VARCHAR2(20)  NOT NULL,  -- 계정코드.
  MANAGEMENT_CODE             VARCHAR2(10)  NOT NULL,  -- 관리항목 코드.
  ATTRIBUTE_A	                VARCHAR2(250)	,		
  ATTRIBUTE_B	                VARCHAR2(250)	,		
  ATTRIBUTE_C	                VARCHAR2(250)	,		
  ATTRIBUTE_D	                VARCHAR2(250)	,		
  ATTRIBUTE_E	                VARCHAR2(250)	,		
  ATTRIBUTE_1	                NUMBER	      ,		
  ATTRIBUTE_2	                NUMBER	      ,		
  ATTRIBUTE_3	                NUMBER	      ,		
  ATTRIBUTE_4	                NUMBER	      ,
  ATTRIBUTE_5	                NUMBER	      ,
  CREATION_DATE               DATE          NOT NULL,  -- 생성자.
  CREATED_BY                  NUMBER        NOT NULL,  -- 생성일.
  LAST_UPDATE_DATE            DATE          NOT NULL,  -- 수정자.
  LAST_UPDATED_BY             NUMBER        NOT NULL   -- 수정일.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_MANAGEMENT_BALANCE IS '계정별 관리항목별 일자별 금액';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.GL_DATE IS '회계일자';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.GL_DATE_SEQ IS '0=전월이월잔액 1=당월발생';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.SOB_ID IS '회사ID';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.ACCOUNT_CONTROL_ID IS '계정관리ID';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.MANAGEMENT_ID IS '관리항목ID';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.MANAGEMENT_VALUE IS '관리항목 값';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.DR_SUM IS '차변합계';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.CR_SUM IS '대변합계';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.OLD_EXCHANGE_RATE IS '기존 환율';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.DR_CURR_SUM IS '차변합계(외화)';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.CR_CURR_SUM IS '대변합계(외화)';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.MANAGEMENT_CODE IS '관리항목코드';

CREATE UNIQUE INDEX FI_MANAGEMENT_BALANCE_U1 ON FI_MANAGEMENT_BALANCE(GL_DATE, GL_DATE_SEQ, SOB_ID, ACCOUNT_CONTROL_ID, MANAGEMENT_ID, MANAGEMENT_VALUE, CURRENCY_CODE) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_MANAGEMENT_BALANCE_N1 ON FI_MANAGEMENT_BALANCE(GL_DATE_SEQ, SOB_ID, NVL(DR_SUM, 0), NVL(CR_SUM, 0), NVL(DR_CURR_SUM, 0), NVL(CR_CURR_SUM, 0)) TABLESPACE FCM_TS_IDX;
