/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_AGGREGATE
/* Description  : 계정실적집계
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_AGGREGATE 
( PERIOD_NAME                     VARCHAR2(10)    NOT NULL,     /* 실적년월 */
  SOB_ID                          NUMBER          NOT NULL,     /* 회계조직 */
  ORG_ID                          NUMBER          NOT NULL,     /* 사업부ID */
  ACCOUNT_BOOK_ID                 NUMBER          NOT NULL,
  ACCOUNT_CONTROL_ID              NUMBER          NOT NULL,     /* 계정관리 ID */
  ACCOUNT_CODE                    VARCHAR2(20)    NOT NULL,     /* 계정코드 */
  CURRENCY_CODE                   VARCHAR2(10)    NOT NULL,     /* 통화 */
  PERIOD_DR_AMOUNT                NUMBER          DEFAULT 0,    /* 당월 차변금액 */
  PERIOD_CR_AMOUNT                NUMBER          DEFAULT 0,    /* 당월 대변금액 */  
  YEAR_DR_AMOUNT                  NUMBER          DEFAULT 0,    /* 년 차변금액 */
  YEAR_CR_AMOUNT                  NUMBER          DEFAULT 0,    /* 년 대변금액 */
  TOTAL_DR_AMOUNT                 NUMBER          DEFAULT 0,    /* 총 누계 차변금액 */
  TOTAL_CR_AMOUNT                 NUMBER          DEFAULT 0,    /* 총 누계 대변금액 */
  BASE_PERIOD_DR_AMOUNT           NUMBER          DEFAULT 0, 
  BASE_PERIOD_CR_AMOUNT           NUMBER          DEFAULT 0,
  BASE_YEAR_DR_AMOUNT             NUMBER          DEFAULT 0,
  BASE_YEAR_CR_AMOUNT             NUMBER          DEFAULT 0,
  BASE_TOTAL_DR_AMOUNT            NUMBER          DEFAULT 0,
  BASE_TOTAL_CR_AMOUNT            NUMBER          DEFAULT 0,
  CREATION_DATE                   DATE            NOT NULL,     /* 생성자 */
  CREATED_BY                      NUMBER          NOT NULL,     /* 생성일 */
  LAST_UPDATE_DATE                DATE            NOT NULL,     /* 수정자 */
  LAST_UPDATED_BY                 NUMBER          NOT NULL      /* 수정일 */
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_AGGREGATE IS '계정실적집계';
COMMENT ON COLUMN APPS.FI_AGGREGATE.PERIOD_NAME IS '회계년월';
COMMENT ON COLUMN APPS.FI_AGGREGATE.SOB_ID IS '회계조직';
COMMENT ON COLUMN APPS.FI_AGGREGATE.ORG_ID IS '사업부ID';
COMMENT ON COLUMN APPS.FI_AGGREGATE.ACCOUNT_CONTROL_ID IS '계정관리 ID';
COMMENT ON COLUMN APPS.FI_AGGREGATE.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN APPS.FI_AGGREGATE.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN APPS.FI_AGGREGATE.PERIOD_DR_AMOUNT IS '월 차변금액';
COMMENT ON COLUMN APPS.FI_AGGREGATE.PERIOD_CR_AMOUNT IS '월 대변금액';
COMMENT ON COLUMN APPS.FI_AGGREGATE.YEAR_DR_AMOUNT IS '년 차변금액';
COMMENT ON COLUMN APPS.FI_AGGREGATE.YEAR_CR_AMOUNT IS '년 대변금액';
COMMENT ON COLUMN APPS.FI_AGGREGATE.TOTAL_DR_AMOUNT IS '누적 차변금액';
COMMENT ON COLUMN APPS.FI_AGGREGATE.TOTAL_CR_AMOUNT IS '누적 대변금액';
COMMENT ON COLUMN APPS.FI_AGGREGATE.BASE_PERIOD_DR_AMOUNT IS '기본통화 월 차변금액';
COMMENT ON COLUMN APPS.FI_AGGREGATE.BASE_PERIOD_CR_AMOUNT IS '기본통화 월 대변금액';
COMMENT ON COLUMN APPS.FI_AGGREGATE.BASE_YEAR_DR_AMOUNT IS '기본통화 년 차변금액';
COMMENT ON COLUMN APPS.FI_AGGREGATE.BASE_YEAR_CR_AMOUNT IS '기본통화 년 대변금액';
COMMENT ON COLUMN APPS.FI_AGGREGATE.BASE_TOTAL_DR_AMOUNT IS '기본통화 누적 차변금액';
COMMENT ON COLUMN APPS.FI_AGGREGATE.BASE_TOTAL_CR_AMOUNT IS '기본통화 누적 대변금액';

CREATE UNIQUE INDEX FI_AGGREGATE_PK ON
  FI_AGGREGATE(PERIOD_NAME, ACCOUNT_CONTROL_ID, CURRENCY_CODE,  SOB_ID, ACCOUNT_BOOK_ID)
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

ALTER TABLE FI_AGGREGATE ADD ( 
  CONSTRAINT FI_AGGREGATE_PK PRIMARY KEY (PERIOD_NAME, ACCOUNT_CONTROL_ID, CURRENCY_CODE,  SOB_ID, ACCOUNT_BOOK_ID)
        );

CREATE INDEX FI_AGGREGATE_N1 ON FI_AGGREGATE(PERIOD_NAME, SOB_ID) TABLESPACE FCM_TS_IDX;
