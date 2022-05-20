/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_LOAN_CHANGE
/* Description  : 차입금 변동 내역
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_LOAN_CHANGE 
( LOAN_NUM                        VARCHAR2(20)  NOT NULL,     -- 차입금 관리번호.
  SOB_ID                          NUMBER        NOT NULL,     -- 회계조직.
  ORG_ID                          NUMBER        NOT NULL,     -- 사업부ID.
  CHANGE_SEQ                      NUMBER(5,0)   NOT NULL,     -- 일련번호.
  CHANGE_DATE                     DATE          NOT NULL,     -- 변경일자.
  CHANGE_REASON_CODE              VARCHAR2(10)  ,             -- 변경사유코드.
  DUE_DATE                        DATE          ,             -- 만기일자.
  INTEREST_RATE                   NUMBER(10,4)  ,             -- 이자율.
  CURRENCY_CODE                   VARCHAR2(10)  ,             -- 통화.
  EXCHANGE_RATE                   NUMBER(10,4)  ,             -- 환율.
  CHANGE_AMOUNT                   NUMBER(12)    ,             -- 변동금액.
  CHANGE_CURR_AMOUNT              NUMBER(16,4)  ,             -- 변동금액_외화.
--CONFIRM_YN                        VARCHAR2(1)   ,             -- 확정(Y/N).
  REMARK                          VARCHAR2(150) ,             -- 적요.
  SLIP_DATE                       DATE          ,             -- 기표전표일자.
  SLIP_NUM                        VARCHAR2(30)  ,             -- 기표전표번호.
  SLIP_LINE_ID                    NUMBER        ,             -- 기표전표행번.
  GL_DATE                         DATE          ,             -- 확정전표일자.
  GL_NUM                          VARCHAR2(30)  ,             -- 확정전표번호.  
  CREATION_DATE                   DATE          NOT NULL,     -- 생성자.
  CREATED_BY                      NUMBER        NOT NULL,     -- 생성일.
  LAST_UPDATE_DATE                DATE          NOT NULL,     -- 수정자.
  LAST_UPDATED_BY                 NUMBER        NOT NULL      -- 수정일.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE  FI_LOAN_CHANGE IS '차입금 변동 내역';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.LOAN_NUM IS '차입금_관리번호';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.SOB_ID IS '회계조직';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.ORG_ID IS '사업부ID';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.CHANGE_SEQ IS '일련번호';

COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.CHANGE_DATE IS '변경일자';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.CHANGE_REASON_CODE IS '변경사유코드';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.DUE_DATE IS '만기일자';

COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.INTEREST_RATE IS '이자율';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.CHANGE_AMOUNT IS '변동금액';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.CHANGE_CURR_AMOUNT IS '변동금액_외화';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.REMARK IS '적요';

COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.SLIP_DATE IS '기표전표일자';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.SLIP_NUM IS '기표전표번호';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.SLIP_LINE_ID IS '기표전표행번';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.GL_DATE IS '확정전표일자';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.GL_NUM IS '확정전표번호';

COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.CREATION_DATE IS '생성자';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.CREATED_BY IS '생성일';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.LAST_UPDATE_DATE IS '수정자';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.LAST_UPDATED_BY IS '수정일';
         
CREATE UNIQUE INDEX FI_LOAN_CHANGE_PK ON 
  FI_LOAN_CHANGE(LOAN_NUM, CHANGE_SEQ, SOB_ID)
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
   
ALTER TABLE FI_LOAN_CHANGE ADD ( 
  CONSTRAINT FI_LOAN_CHANGE_PK PRIMARY KEY ( LOAN_NUM, CHANGE_SEQ, SOB_ID )
        );
