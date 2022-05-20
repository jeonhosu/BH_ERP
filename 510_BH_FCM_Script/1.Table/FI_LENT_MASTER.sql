/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_LENT_MASTER
/* Description  : 어음 대여금 Master.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_LENT_MASTER 
( LENT_ID                         NUMBER        NOT NULL,       -- 대여금번호ID.
  LENT_NUM                        VARCHAR2(30)  NOT NULL,       -- 대여금관리번호.
  SOB_ID                          NUMBER        NOT NULL,       -- 회계조직.
	ORG_ID                          NUMBER        NOT NULL,       -- 사업부ID.	
  LENT_CLASS                      VARCHAR2(10)  NOT NULL,       -- 대여금종류.
  BANK_ID                         NUMBER        NOT NULL,       -- 거래은행(대여처).
  ACCOUNT_CONTROL_ID              NUMBER        NOT NULL,       -- 계정과목코드ID.
  ACCOUNT_CODE                    VARCHAR2(10)  NOT NULL,       -- 계정과목코드.  
  ISSUE_DATE                      DATE          NOT NULL,       -- 대여일자.
  DUE_DATE                        DATE          NOT NULL,       -- 만기일자.
  LENT_AMOUNT                     NUMBER(12)    DEFAULT 0,      -- 대여액.
  REMAIN_AMOUNT                   NUMBER(12)    DEFAULT 0,      -- 상환액.
  INTEREST_RATE                   NUMBER(7,4)   DEFAULT 0,      -- 이자율.
  INTEREST_RATE_TYPE              VARCHAR2(10)  NOT NULL,       -- 이자지급방법.
  INTEREST_START_DATE             DATE          ,               -- 이자지급시작일.
  INTEREST_DUE_DATE               DATE          ,               -- 이자지급만료일.
  CLOSING_DATE                    DATE          ,               -- 원금상환일.  
  LENT_CLOSE_YN                   CHAR(1)       NOT NULL,       -- 원금상환완료여부.
  BILL_NUM                        VARCHAR2(30)  ,               -- 어음번호.  
  CREATION_DATE                   DATE          NOT NULL,
  CREATED_BY                      NUMBER        NOT NULL,
  LAST_UPDATE_DATE                DATE          NOT NULL,
  LAST_UPDATED_BY                 NUMBER        NOT NULL 
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_LENT_MASTER IS '어음대여금';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.LENT_ID IS '대여금번호ID';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.LENT_NUM IS '대여금관리번호';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.SOB_ID IS '회계조직';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.ORG_ID IS '사업부ID';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.LENT_CLASS IS '대여금종류';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.BANK_ID IS '거래은행(대여처)';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.ACCOUNT_CONTROL_ID IS '계정과목코드ID';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.ACCOUNT_CODE IS '계정과목코드';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.ISSUE_DATE IS '대여일자';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.DUE_DATE IS '만기일자';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.LENT_AMOUNT IS '대여액';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.REMAIN_AMOUNT IS '상환액';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.INTEREST_RATE IS '이자율';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.INTEREST_RATE_TYPE IS '이자지급방법';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.INTEREST_START_DATE IS '이자지급시작일';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.INTEREST_DUE_DATE IS '이자지급만료일';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.CLOSING_DATE IS '원금상환일';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.LENT_CLOSE_YN IS '원금상환완료여부';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.BILL_NUM IS '어음번호';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.CREATION_DATE IS '최초DATA생성일자';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.CREATED_BY IS '최초DATA생성USER';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.LAST_UPDATE_DATE IS '최종DATA생성일자';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.LAST_UPDATED_BY IS '최종DATA생성USER';

CREATE UNIQUE INDEX FI_LENT_MASTER_PK ON 
  FI_LENT_MASTER(LENT_NUM, SOB_ID)
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

ALTER TABLE FI_LENT_MASTER ADD ( 
  CONSTRAINT FI_LENT_MASTER_PK PRIMARY KEY (LENT_NUM, SOB_ID)
        );

CREATE UNIQUE INDEX FI_LENT_MASTER_U1 ON 
  FI_LENT_MASTER(LENT_ID)
  TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE FI_LENT_MASTER_S1;
CREATE SEQUENCE FI_LENT_MASTER_S1;
