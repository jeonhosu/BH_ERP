/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_TR_DAILY
/* Description  : 老老磊陛老焊.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_TR_DAILY
( TR_DAILY_ID                       NUMBER        NOT NULL,
  TR_TYPE                           VARCHAR2(20)  NOT NULL,
  SOB_ID                            NUMBER        NOT NULL,
  GL_DATE                           DATE          ,
  ACCOUNT_CONTROL_ID                NUMBER        ,
  ACCOUNT_CODE                      VARCHAR2(20)  ,
  ACCOUNT_DR_CR                     VARCHAR2(1)   ,
  CURRENCY_CODE                     VARCHAR2(10)  ,
  EXCHANGE_RATE                     NUMBER        ,
  GL_CURRENCY_AMOUNT                NUMBER        DEFAULT 0,
  GL_AMOUNT                         NUMBER        DEFAULT 0,
  CUSTOMER_CODE                     VARCHAR2(20)  ,
  BANK_ACCOUNT_CODE                 VARCHAR2(20)  ,  
  REMARK                            VARCHAR2(200) ,
  SLIP_LINE_ID                      NUMBER        ,
  FUND_MOVE                         VARCHAR2(10)  ,
  LOAN_USE                          VARCHAR2(10)  ,
  LOAN_NUM                          VARCHAR2(10)  ,
  TR_CATEGORY                       VARCHAR2(10)  ,
  TR_CLASS                          VARCHAR2(10)  ,
  CLOSED_YN                         CHAR(1),
  CLOSED_DATE                       DATE,
  CLOSED_BY                         NUMBER
) TABLESPACE FCM_TS_DATA
;

COMMENT ON TABLE FI_TR_DAILY IS '老老磊陛老焊';

CREATE UNIQUE INDEX FI_TR_DAILY_U1 ON FI_TR_DAILY(TR_DAILY_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_TR_DAILY_N1 ON FI_TR_DAILY(GL_DATE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_TR_DAILY_N2 ON FI_TR_DAILY(ACCOUNT_CONTROL_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_TR_DAILY_N3 ON FI_TR_DAILY(TR_TYPE, GL_DATE, SOB_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE FI_TR_DAILY_S1;
