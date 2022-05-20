/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_TAX_RATE
/* Description  : 연말정산/퇴직정산 종합소득세율관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRA_TAX_RATE
(TAX_RATE_ID                                      NUMBER NOT NULL,
  TAX_YYYY	                                      VARCHAR2(4) NOT NULL,
  TAX_TYPE_ID                                     NUMBER NOT NULL,
  START_AMOUNT	                                  NUMBER DEFAULT 0,
  END_AMOUNT	                                    NUMBER DEFAULT 0,
  TAX_RATE	                                      NUMBER,
  ACCUM_SUB_AMOUNT	                              NUMBER,
  DESCRIPTION                                     VARCHAR2(100),
  ATTRIBUTE1                                      VARCHAR2(100),
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
	SOB_ID                                          NUMBER NOT NULL,
	ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
)
  TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRA_TAX_RATE.TAX_RATE_ID IS '종합소득세율관리ID';
COMMENT ON COLUMN HRA_TAX_RATE.TAX_YYYY IS '적용년도';
COMMENT ON COLUMN HRA_TAX_RATE.TAX_TYPE_ID IS '세율타입(10-연말정산,20-퇴직정산)';
COMMENT ON COLUMN HRA_TAX_RATE.START_AMOUNT IS '시작 금액';
COMMENT ON COLUMN HRA_TAX_RATE.END_AMOUNT IS '종료 금액';
COMMENT ON COLUMN HRA_TAX_RATE.TAX_RATE IS '세율(%)';
COMMENT ON COLUMN HRA_TAX_RATE.TAX_RATE IS '누진금액';
COMMENT ON COLUMN HRA_TAX_RATE.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRA_TAX_RATE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRA_TAX_RATE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRA_TAX_RATE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRA_TAX_RATE.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRA_TAX_RATE_U1 ON HRA_TAX_RATE(TAX_RATE_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRA_TAX_RATE_N1 ON HRA_TAX_RATE(TAX_YYYY, TAX_TYPE_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE
DROP SEQUENCE HRA_TAX_RATE_S1;
CREATE SEQUENCE HRA_TAX_RATE_S1;

-- ANALYZE.
ANALYZE TABLE HRA_TAX_RATE COMPUTE STATISTICS;
ANALYZE INDEX HRA_TAX_RATE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRA_TAX_RATE_N1 COMPUTE STATISTICS;
