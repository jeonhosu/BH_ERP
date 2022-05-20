-/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_MANAGEMENT_LEDGER_DETAIL
/* Description  : 관리항목별원장-전체조회.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_MANAGEMENT_LEDGER_DETAIL
( RET_SEQ                         NUMBER          NOT NULL,
  GL_DATE                         DATE            ,
  REMARKS                         VARCHAR2(200)   ,
  DR_AMT                          NUMBER          ,
  CR_AMT                          NUMBER          ,
  REMAIN_AMT                      NUMBER          ,
  ACCOUNT_CODE                    VARCHAR2(20)    ,
  ACCOUNT_DESC                    VARCHAR2(200)   ,
  MANAGEMENT_CD                   VARCHAR2(50)    ,
  MANAGEMENT_NM                   VARCHAR2(200)   ,
  SLIP_HEADER_ID                  NUMBER          ,
  SLIP_LINE_ID                    NUMBER          ,
  GL_NUM                          VARCHAR2(30)
)
TABLESPACE FCM_TS_DATA;
  
-- ADD COMMENTS TO THE TABLE 
COMMENT ON TABLE FI_MANAGEMENT_LEDGER_DETAIL IS '원장조회_상세(전체)';
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.RET_SEQ IS '조회일련번호';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.GL_DATE IS '회계일자';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.REMARKS IS '적요';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.DR_AMT IS '차변(금액)';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.CR_AMT IS '대변(금액)';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.REMAIN_AMT IS '잔액';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.ACCOUNT_DESC IS '계정명';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.MANAGEMENT_CD IS '관리항목코드';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.MANAGEMENT_NM IS '관리항목명';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.SLIP_HEADER_ID IS '전표헤더아이디';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.SLIP_LINE_ID IS '전표라인아이디';
COMMENT ON COLUMN FI_MANAGEMENT_LEDGER_DETAIL.GL_NUM IS '전표번호';

-- CREATE/RECREATE PRIMARY, UNIQUE AND FOREIGN KEY CONSTRAINTS 
ALTER TABLE FI_MANAGEMENT_LEDGER_DETAIL
  ADD CONSTRAINT FI_MANAGEMENT_LEDGER_DETAIL_PK PRIMARY KEY (RET_SEQ)
  USING INDEX 
  TABLESPACE FCM_TS_IDX;
