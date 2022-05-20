/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_LOAN_MASTER
/* Description  : 차입금원장
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_LOAN_MASTER 
( LOAN_NUM                        VARCHAR2(20)  NOT NULL,     -- 차입금 관리번호.
  SOB_ID                          NUMBER        NOT NULL,     -- 회계조직.
  ORG_ID                          NUMBER        NOT NULL,     -- 사업부ID.
  LOAN_DESC                       VARCHAR2(100) ,             -- 차입내역.
  LOAN_KIND                       VARCHAR2(10)  NOT NULL,     -- 차입금종류.
  LOAN_TYPE                       VARCHAR2(10)  NOT NULL,     -- 차입금구분.
  LOAN_USE                        VARCHAR2(10)  ,             -- 차입금 용도.
  L_ISSUE_DATE                    DATE          ,             -- 약정일자.
  L_DUE_DATE                      DATE          ,             -- 약정만기일자.
  L_CURRENCY_CODE                 VARCHAR2(10)  ,             -- 통화.
  L_EXCHANGE_RATE                 NUMBER        ,             -- 환율.
  LIMIT_CURR_AMOUNT               NUMBER        DEFAULT 0,    -- 한도금액.
  LIMIT_AMOUNT                    NUMBER        DEFAULT 0,    -- 한도금액.  
  ISSUE_DATE                      DATE          ,             -- 차입일자.
  DUE_DATE                        DATE          ,             -- 만기일자.
  CURRENCY_CODE                   VARCHAR2(10)  ,             -- 통화.
  EXCHANGE_RATE                   NUMBER        ,             -- 환율.
  LOAN_CURR_AMOUNT                NUMBER        ,             -- 차입금액(외화).
  LOAN_AMOUNT                     NUMBER        ,             -- 차입금액(원화).
  LOAN_ADD_CURR_AMOUNT            NUMBER        ,             -- 추가차입금액(외화).
  LOAN_ADD_AMOUNT                 NUMBER        ,             -- 추가차입금액(원화).
  LOAN_ACCOUNT_CONTROL_ID         NUMBER        ,             -- 입금계정ID.
  LOAN_BANK_ID                    NUMBER        ,             -- 입금은행ID.
  LOAN_BANK_ACCOUNT_ID            NUMBER        ,             -- 입금계좌ID.
  ENSURE_TYPE                     VARCHAR2(10)  ,             -- 보증구분.
  REPAY_CONDITION                 VARCHAR2(10)  ,             -- 원금상환조건.
  TERM_YEAR                       NUMBER(2)     ,             -- 거치기간_년.
  TERM_MONTH                      NUMBER(2)     ,             -- 거치기간_월.
  REPAY_CYCLE_MONTH               NUMBER(2)     ,             -- 원금상환주기(개월).
  START_REPAY_DATE                DATE          ,             -- 최초원금상환일.
  INTER_RATE                      NUMBER(16,4)  ,             -- 이자율.
  SPREAD_RATE                     NUMBER(16,4)  ,             -- SPREAD율.
  INTER_TYPE                      VARCHAR2(10)  ,             -- 이자유형.
  INTER_PAYMENT_TYPE              VARCHAR2(10)  ,             -- 이자지급형태.
  START_INTER_DATE                DATE          ,             -- 최초이자지급일.  
  INTER_PAYMENT_CYCLE             VARCHAR2(10)  ,             -- 이자지급주기.
  ADVANCE_INTER                   NUMBER(12)    ,             -- 선급이자금액.
  ADVANCE_CURR_INTER              NUMBER(16,4)  ,             -- 선급이자금액(외화).
  INTER_ACCOUNT_CONTROL_ID        NUMBER        ,             -- 이자 지급계정ID.
  COMMI_AMOUNT                    NUMBER(12)    ,             -- 수수료.
  COMMI_CURR_AMOUNT               NUMBER(16,4)  ,             -- 수수료_외화.
  COMMI_ACCOUNT_CONTROL_ID        NUMBER        ,             -- 수수료 지급계정ID.
  REPAY_COUNT                     NUMBER(3)     DEFAULT 0,    -- 원금상환 횟수.
  REPAY_ONE_AMOUNT                NUMBER(12)    DEFAULT 0,    -- 1회상환액금액.
  REPAY_ONE_CURR_AMOUNT           NUMBER(16,4)  DEFAULT 0,    -- 1회상환액금액(외화).
  REPAY_SUM_AMOUNT                NUMBER(12)    DEFAULT 0,    -- 상환액누계.
  REPAY_SUM_CURR_AMOUNT           NUMBER(16,4)  DEFAULT 0,    -- 상환액누계(외화).
  REPAY_LAST_DATE                 DATE          ,             -- 최종상환일.
  REPAY_INTER_COUNT               NUMBER(3)     DEFAULT 0,    -- 이자상환 횟수.
  REPAY_INTER_SUM_AMOUNT          NUMBER(12)    DEFAULT 0,    -- 이자상환액누계.
  REPAY_INTER_SUM_CURR_AMOUNT     NUMBER(16,4)  DEFAULT 0,    -- 이자상환액누계(외화).
  COST_CENTER_ID                  NUMBER        ,             -- 코스트센타.  
  REMARK                          VARCHAR2(100) ,             -- 적요.
  MORTGAGE_REMARK                 VARCHAR2(100) ,             -- 담보내용.
  CREATION_DATE                   DATE          NOT NULL,     -- 생성일자.
  CREATED_BY                      NUMBER        NOT NULL,     -- 생성자.
  LAST_UPDATE_DATE                DATE          NOT NULL,     -- 최종수정일자.
  LAST_UPDATED_BY                 NUMBER        NOT NULL      -- 최종수정자.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_LOAN_MASTER IS '차입금 원장';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_NUM IS '차입금관리번호';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.SOB_ID IS '회계조직';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.ORG_ID IS '사업부ID';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_DESC IS '차입 내역';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_KIND IS '차입금종류(LOAN_KIND)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_TYPE IS '차입금구분(LOAN_TYPE)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_USE IS '차입금 용도(LOAN_USE)';

COMMENT ON COLUMN APPS.FI_LOAN_MASTER.L_ISSUE_DATE IS '한도 약정일자';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.L_DUE_DATE IS '한도 만기일자';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.L_CURRENCY_CODE IS '한도대출 통화';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.L_EXCHANGE_RATE IS '한도대출 환율';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LIMIT_CURR_AMOUNT IS '한도대출금액(외화)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LIMIT_AMOUNT IS '한도대출차입금액(원화)';

COMMENT ON COLUMN APPS.FI_LOAN_MASTER.ISSUE_DATE IS '차입일자';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.DUE_DATE IS '만기일자';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_CURR_AMOUNT IS '차입금액(외화)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_AMOUNT IS '차입금액(원화)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_ADD_CURR_AMOUNT IS '추가차입금액(외화)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_ADD_AMOUNT IS '추가차입액(원화)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_ACCOUNT_CONTROL_ID IS '입금계정ID';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_BANK_ID IS '입금은행ID';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_BANK_ACCOUNT_ID IS '입금계좌ID';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.ENSURE_TYPE IS '보증구분';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_CONDITION IS '원금상환조건';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.TERM_YEAR IS '거치기간_년';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.TERM_MONTH IS '거치기간_월';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_CYCLE_MONTH IS '원금상환주기(개월)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.START_REPAY_DATE IS '최초원금상환일';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.INTER_RATE IS '이자율';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.SPREAD_RATE IS 'SPREAD율';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.INTER_TYPE IS '이자유형';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.INTER_PAYMENT_TYPE IS '이자지급형태';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.START_INTER_DATE IS '최초이자지급일';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.INTER_PAYMENT_CYCLE IS '이자지급주기';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.ADVANCE_INTER IS '선급이자금액';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.ADVANCE_CURR_INTER IS '선급이자금액(외화)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.INTER_ACCOUNT_CONTROL_ID IS '이자 지급계정ID';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.COMMI_AMOUNT IS '수수료';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.COMMI_CURR_AMOUNT IS '수수료(외화)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.COMMI_ACCOUNT_CONTROL_ID IS '수수료 지급계정ID';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_COUNT IS '원금상환_횟수';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_ONE_AMOUNT IS '1회상환액금액';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_ONE_CURR_AMOUNT IS '1회상환액금액(외화)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_SUM_AMOUNT IS '상환액누계';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_SUM_CURR_AMOUNT IS '상환액누계(외화)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_LAST_DATE IS '최종상환일';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_INTER_COUNT IS '이자상환_횟수';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_INTER_SUM_AMOUNT IS '이자상환액누계';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_INTER_SUM_CURR_AMOUNT IS '이자상환액누계(외화)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.COST_CENTER_ID IS '코스트센타';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REMARK IS '적요';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.MORTGAGE_REMARK IS '담보내용';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.CREATION_DATE IS '최초DATA생성 일자';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.CREATED_BY IS '최초DATA생성 USER';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LAST_UPDATE_DATE IS '최종DATA생성 일자';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LAST_UPDATED_BY IS '최종DATA생성 USER';

CREATE UNIQUE INDEX FI_LOAN_MASTER_PK ON 
  FI_LOAN_MASTER(LOAN_NUM, SOB_ID)
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

ALTER TABLE FI_LOAN_MASTER ADD ( 
  CONSTRAINT FI_LOAN_MASTER_PK PRIMARY KEY (LOAN_NUM, SOB_ID)
        );
