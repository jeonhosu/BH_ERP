/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_TR_DAILY_SUM
/* Description  : 일일자금일보 집계.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_TR_DAILY_SUM
( TR_TYPE                           VARCHAR2(20)  NOT NULL,
  SOB_ID                            NUMBER        NOT NULL,
  GL_DATE                           DATE          ,
  ACCOUNT_CONTROL_ID                NUMBER        ,
  ACCOUNT_CODE                      VARCHAR2(20)  ,  
  CURRENCY_CODE                     VARCHAR2(10)  ,
  EXCHANGE_RATE                     NUMBER        ,
  BEGIN_CURR_AMOUNT                 NUMBER        DEFAULT 0,
  BEGIN_AMOUNT                      NUMBER        DEFAULT 0,
  DR_CURR_AMOUNT                    NUMBER        DEFAULT 0,
  CR_CURR_AMOUNT                    NUMBER        DEFAULT 0,
  DR_AMOUNT                         NUMBER        DEFAULT 0,
  CR_AMOUNT                         NUMBER        DEFAULT 0,
  REMAIN_CURR_AMOUNT                NUMBER        DEFAULT 0,
  REMAIN_AMOUNT                     NUMBER        DEFAULT 0,
  DESCRIPTION                       VARCHAR2(200) ,
  BANK_CODE                         VARCHAR2(20)  ,
  BANK_ACCOUNT_CODE                 VARCHAR2(20)  ,  
  LOAN_USE                          VARCHAR2(10)  ,
  LOAN_NUM                          VARCHAR2(10)  ,
  TR_CATEGORY                       VARCHAR2(10)  ,
  TR_CLASS                          VARCHAR2(10)  ,
  CLOSED_YN                         CHAR(1),
  CLOSED_DATE                       DATE,
  CLOSED_BY                         NUMBER
) TABLESPACE FCM_TS_DATA
;

COMMENT ON TABLE FI_TR_DAILY_SUM IS '일일자금일보 집계';
COMMENT ON TABLE FI_TR_DAILY_SUM IS '일일자금일보 집계';
COMMENT ON COLUMN FI_TR_DAILY_SUM.TR_TYPE IS '자금일보 타입';
COMMENT ON COLUMN FI_TR_DAILY_SUM.GL_DATE IS '전표일자';
COMMENT ON COLUMN FI_TR_DAILY_SUM.ACCOUNT_CONTROL_ID IS '계정통제ID';
COMMENT ON COLUMN FI_TR_DAILY_SUM.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN FI_TR_DAILY_SUM.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN FI_TR_DAILY_SUM.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN FI_TR_DAILY_SUM.BEGIN_CURR_AMOUNT IS '기초금액(외화)';
COMMENT ON COLUMN FI_TR_DAILY_SUM.BEGIN_AMOUNT IS '기초금액';
COMMENT ON COLUMN FI_TR_DAILY_SUM.DR_CURR_AMOUNT IS '차변금액(외화)';
COMMENT ON COLUMN FI_TR_DAILY_SUM.CR_CURR_AMOUNT IS '대변금액(외화)';
COMMENT ON COLUMN FI_TR_DAILY_SUM.DR_AMOUNT IS '차변금액';
COMMENT ON COLUMN FI_TR_DAILY_SUM.CR_AMOUNT IS '대변금액';
COMMENT ON COLUMN FI_TR_DAILY_SUM.REMAIN_CURR_AMOUNT IS '잔액(외화)';
COMMENT ON COLUMN FI_TR_DAILY_SUM.REMAIN_AMOUNT IS '잔액';
COMMENT ON COLUMN FI_TR_DAILY_SUM.DESCRIPTION IS '비고';
COMMENT ON COLUMN FI_TR_DAILY_SUM.BANK_CODE IS '은행코드';
COMMENT ON COLUMN FI_TR_DAILY_SUM.BANK_ACCOUNT_CODE IS '은행계좌코드';
COMMENT ON COLUMN FI_TR_DAILY_SUM.LOAN_USE IS '차입금 용도';
COMMENT ON COLUMN FI_TR_DAILY_SUM.LOAN_NUM IS '차입금 번호';
COMMENT ON COLUMN FI_TR_DAILY_SUM.TR_CATEGORY IS '자금일보 카테고리';
COMMENT ON COLUMN FI_TR_DAILY_SUM.TR_CLASS IS '자금일보 분류';
COMMENT ON COLUMN FI_TR_DAILY_SUM.CLOSED_YN IS '마감';
COMMENT ON COLUMN FI_TR_DAILY_SUM.CLOSED_DATE IS '마감일자';
COMMENT ON COLUMN FI_TR_DAILY_SUM.CLOSED_BY IS '마감자';
COMMENT ON COLUMN FI_TR_DAILY_SUM.TR_DAILY_SUM_ID IS '계획입력시 채번 ID';
COMMENT ON COLUMN FI_TR_DAILY_SUM.FUND_MOVE IS '자금이동 CODE';

CREATE INDEX FI_TR_DAILY_SUM_N1 ON FI_TR_DAILY_SUM(GL_DATE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_TR_DAILY_SUM_N2 ON FI_TR_DAILY_SUM(ACCOUNT_CONTROL_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_TR_DAILY_SUM_N3 ON FI_TR_DAILY_SUM(TR_TYPE, GL_DATE, SOB_ID) TABLESPACE FCM_TS_IDX;

