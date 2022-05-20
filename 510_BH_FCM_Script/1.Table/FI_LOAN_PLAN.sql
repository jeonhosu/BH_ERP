/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_LOAN_PLAN
/* Description  : 차입금 상환계획
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_LOAN_PLAN 
( PLAN_DATE                       DATE          NOT NULL,       -- 상환계획일자_휴일감안한_상환일.
  LOAN_NUM                        VARCHAR2(20)  NOT NULL,       -- 차입금 관리번호.
  SOB_ID                          NUMBER        NOT NULL,       -- 회계조직.
  ORG_ID                          NUMBER        NOT NULL,       -- 사업부ID.  
  CURRENCY_CODE                   VARCHAR2(10)  ,               -- 통화.  
  EXCHANGE_RATE                   NUMBER(10,4)  ,               -- 환율.
  REPAY_AMOUNT                    NUMBER(12)    DEFAULT 0,      -- 원금상환액금액.
  REPAY_CURR_AMOUNT               NUMBER(16,4)  DEFAULT 0,      -- 원금상환액금액_외화.  
  INTEREST_AMOUNT                 NUMBER(12)    DEFAULT 0,      -- 이자상환액금액.
  INTEREST_CURR_AMOUNT            NUMBER(16,4)  DEFAULT 0,      -- 이자상환액금액_외화.
  COMMISSION_AMOUNT               NUMBER(12)    DEFAULT 0,      -- 수수료.
  COMMISSION_CURR_AMOUNT          NUMBER(16,4)  DEFAULT 0,      -- 수수료(외화).
  COST_CENTER_ID                  VARCHAR2(10)  ,               -- 코스트센타.
  DEPT_ID                         NUMBER        NOT NULL,       -- 발의부서.
  USER_ID                         NUMBER        NOT NULL,       -- 발의자(사용자).
  REMARK                          VARCHAR2(150) ,               -- 적요.
  SLIP_DATE                       DATE          ,               -- 기표전표일자.
  SLIP_NUM                        VARCHAR2(30)  ,               -- 기표전표번호.
  SLIP_LINE_ID                    NUMBER        ,               -- 기표전표행번.
  GL_DATE                         DATE          ,               -- 확정전표일자.
  GL_NUM                          VARCHAR2(30)  ,               -- 확정전표번호.  
  CREATION_DATE                   DATE          NOT NULL,       -- 생성자.
  CREATED_BY                      NUMBER        NOT NULL,       -- 생성일.
  LAST_UPDATE_DATE                DATE          NOT NULL,       -- 수정자.
  LAST_UPDATED_BY                 NUMBER        NOT NULL        -- 수정일.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_LOAN_PLAN IS '차입금 상환 계획관리';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.PLAN_DATE IS '상환계획일자_휴일감안한_상환일';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.LOAN_NUM IS '차입금_관리번호';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.SOB_ID IS '회계조직';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.ORG_ID IS '사업부ID';

COMMENT ON COLUMN APPS.FI_LOAN_PLAN.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.REPAY_AMOUNT IS '원금상환액금액';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.REPAY_CURR_AMOUNT IS '원금상환액금액_외화';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.INTEREST_AMOUNT IS '이자상환액금액';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.INTEREST_CURR_AMOUNT IS '이자상환액금액_외화';

COMMENT ON COLUMN APPS.FI_LOAN_PLAN.COST_CENTER_ID IS '코스트센타';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.DEPT_ID IS '발의부서';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.USER_ID IS '발의자(사용자)';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.REMARK IS '적요';

COMMENT ON COLUMN APPS.FI_LOAN_PLAN.SLIP_DATE IS '기표전표일자';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.SLIP_NUM IS '기표전표번호';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.SLIP_LINE_ID IS '기표전표행번';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.GL_DATE IS '확정전표일자';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.GL_NUM IS '확정전표번호';

COMMENT ON COLUMN APPS.FI_LOAN_PLAN.CREATION_DATE IS '생성자';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.CREATED_BY IS '생성일';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.LAST_UPDATE_DATE IS '수정자';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.LAST_UPDATED_BY IS '수정일';


CREATE UNIQUE INDEX FI_LOAN_PLAN_PK ON 
  FI_LOAN_PLAN(PLAN_DATE, LOAN_NUM, SOB_ID)
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

ALTER TABLE FI_LOAN_PLAN ADD ( 
  CONSTRAINT FI_LOAN_PLAN_PK PRIMARY KEY (PLAN_DATE, LOAN_NUM, SOB_ID)
        );
