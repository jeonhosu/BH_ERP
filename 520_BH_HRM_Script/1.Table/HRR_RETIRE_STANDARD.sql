/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRR_RETIRE_STANDARD
/* Description  : 퇴직정산 처리 기준.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRR_RETIRE_STANDARD              
( STD_YYYY                                        VARCHAR2(4) NOT NULL,
  STD_CALCULATE_MONTH                             NUMBER(2) NOT NULL,
  STD_MONTH                                       NUMBER(2) NOT NULL,
  PAY_MONTH                                       NUMBER(2) NOT NULL,
  BONUS_MONTH                                     NUMBER(2) NOT NULL,
  MONTH_DAY                                       NUMBER DEFAULT 0,
  YEAR_DAY                                        NUMBER DEFAULT 0,
  INCOME_DEDUCTION_RATE                           NUMBER,
  INCOME_DEDUCTION_LMT                            NUMBER,
  TAX_DEDUCTION_RATE                              NUMBER,
  TAX_DEDUCTION_LMT                               NUMBER,
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
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRR_RETIRE_STANDARD.STD_YYYY IS '적용년도';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.STD_CALCULATE_MONTH IS '처리대상 산출기준';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.STD_MONTH IS '기준 월수(3)';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.PAY_MONTH IS '기준 급여 월수(3)';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.BONUS_MONTH IS '기준 상여 월수(12)';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.MONTH_DAY IS '기준 월일수(30)';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.YEAR_DAY IS '기준 년일수(365)';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.INCOME_DEDUCTION_RATE IS '소득공제율(%)';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.INCOME_DEDUCTION_LMT IS '소득공제 한도';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.TAX_DEDUCTION_RATE IS '세액공제율(%)';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.TAX_DEDUCTION_LMT IS '세액공제 한도';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRR_RETIRE_STANDARD_U1 ON HRR_RETIRE_STANDARD(STD_YYYY, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRR_RETIRE_STANDARD COMPUTE STATISTICS;
ANALYZE INDEX HRR_RETIRE_STANDARD_U1 COMPUTE STATISTICS;
