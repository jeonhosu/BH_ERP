/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_TAX_STANDARD
/* Description  : 갑근세 조견표 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRP_TAX_STANDARD              
(START_DATE                                                 DATE NOT NULL,
  END_DATE                                                  DATE NOT NULL,
  BEGIN_AMOUNT	                                            NUMBER,
  END_AMOUNT	                                              NUMBER,
  SUPP_NUM1	                                                NUMBER DEFAULT 0,
  SUPP_NUM2	                                                NUMBER DEFAULT 0,
  SUPP_NUM3	                                                NUMBER DEFAULT 0,
  SUPP_NUM4	                                                NUMBER DEFAULT 0,
  SUPP_NUM5	                                                NUMBER DEFAULT 0,
  SUPP_NUM6	                                                NUMBER DEFAULT 0,
  SUPP_NUM7	                                                NUMBER DEFAULT 0,
  SUPP_NUM8	                                                NUMBER DEFAULT 0,
  SUPP_NUM9	                                                NUMBER DEFAULT 0,
  SUPP_NUM10	                                              NUMBER DEFAULT 0,
  SUPP_NUM11	                                              NUMBER DEFAULT 0,
  DESCRIPTION                                               VARCHAR2(100),
  ATTRIBUTE1                                                VARCHAR2(100),
  ATTRIBUTE2                                                VARCHAR2(100),
  ATTRIBUTE3                                                VARCHAR2(100),
  ATTRIBUTE4                                                VARCHAR2(100),
  ATTRIBUTE5                                                VARCHAR2(100),
	SOB_ID                                                    NUMBER NOT NULL,
	ORG_ID                                                    NUMBER NOT NULL,
  CREATION_DATE                                             DATE NOT NULL,
  CREATED_BY                                                NUMBER NOT NULL,
  LAST_UPDATE_DATE                                          DATE NOT NULL,
  LAST_UPDATED_BY                                           NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRP_TAX_STANDARD.START_DATE IS '시작일자';
COMMENT ON COLUMN HRP_TAX_STANDARD.END_DATE IS '종료일자';
COMMENT ON COLUMN HRP_TAX_STANDARD.BEGIN_AMOUNT IS '적용 시작 금액';
COMMENT ON COLUMN HRP_TAX_STANDARD.END_AMOUNT IS '적용 종료 금액';
COMMENT ON COLUMN HRP_TAX_STANDARD.SUPP_NUM1 IS '부양가족수1~11';
COMMENT ON COLUMN HRP_TAX_STANDARD.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRP_TAX_STANDARD.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRP_TAX_STANDARD.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRP_TAX_STANDARD.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRP_TAX_STANDARD.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRP_TAX_STANDARD_U1 ON HRP_TAX_STANDARD(START_DATE, END_DATE, BEGIN_AMOUNT, END_AMOUNT, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRP_TAX_STANDARD COMPUTE STATISTICS;
ANALYZE INDEX HRP_TAX_STANDARD_U1 COMPUTE STATISTICS;
