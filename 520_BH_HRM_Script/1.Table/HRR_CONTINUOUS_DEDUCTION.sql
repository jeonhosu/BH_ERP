/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRR_CONTINUOUS_DEDUCTION
/* Description  : 퇴직 근속공제 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRR_CONTINUOUS_DEDUCTION              
( STD_YYYY                                        VARCHAR2(4) NOT NULL,
  START_YEAR                                      NUMBER      NOT NULL,
  END_YEAR                                        NUMBER    NOT NULL,
  DED_YEAR                                        NUMBER    DEFAULT 0,
  DED_AMOUNT                                      NUMBER DEFAULT 0,
  DED_ADD_AMOUNT                                  NUMBER DEFAULT 0,
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
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.STD_YYYY IS '적용 년도';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.START_YEAR IS '시작 근속년수';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.END_YEAR IS '종료 근속년수';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.DED_YEAR IS '공제 근속년수';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.DED_AMOUNT IS '공제금액';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.DED_ADD_AMOUNT IS '추가 공제금액';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRR_CONTINUOUS_DEDUCTION_U1 ON HRR_CONTINUOUS_DEDUCTION(STD_YYYY, START_YEAR, END_YEAR, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRR_CONTINUOUS_DEDUCTION COMPUTE STATISTICS;
ANALYZE INDEX HRR_CONTINUOUS_DEDUCTION_U1 COMPUTE STATISTICS;
