/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRR_RETIRE_INSURANCE
/* Description  : 퇴직 보험금 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRR_RETIRE_INSURANCE              
( RETIRE_INSUR_ID                                 NUMBER NOT NULL,
  ADJUSTMENT_TYPE                                 VARCHAR2(2) NOT NULL,
  ADJUSTMENT_ID                                   NUMBER(2) NOT NULL,
  PERSON_ID                                       NUMBER NOT NULL,
  CORP_ID                                         NUMBER NOT NULL,
  INSUR_CORP_ID                                   NUMBER NOT NULL,
  INSUR_AMOUNT                                    NUMBER DEFAULT 0,  
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
COMMENT ON COLUMN HRR_RETIRE_INSURANCE.RETIRE_INSUR_ID IS '퇴직 보험금 ID';
COMMENT ON COLUMN HRR_RETIRE_INSURANCE.ADJUSTMENT_TYPE IS '정산구분(R-퇴직금, M-중도정산)';
COMMENT ON COLUMN HRR_RETIRE_INSURANCE.ADJUSTMENT_ID IS '퇴직정산ID';
COMMENT ON COLUMN HRR_RETIRE_INSURANCE.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRR_RETIRE_INSURANCE.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRR_RETIRE_INSURANCE.INSUR_CORP_ID IS '보험사 ID';
COMMENT ON COLUMN HRR_RETIRE_INSURANCE.INSUR_AMOUNT IS '보험금액';
COMMENT ON COLUMN HRR_RETIRE_INSURANCE.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRR_RETIRE_INSURANCE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRR_RETIRE_INSURANCE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRR_RETIRE_INSURANCE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRR_RETIRE_INSURANCE.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRR_RETIRE_INSURANCE_U1 ON HRR_RETIRE_INSURANCE(RETIRE_INSUR_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRR_RETIRE_INSURANCE_U2 ON HRR_RETIRE_INSURANCE(ADJUSTMENT_TYPE, ADJUSTMENT_ID, PERSON_ID, CORP_ID, INSUR_CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRR_RETIRE_INSURANCE_S1;
CREATE SEQUENCE HRR_RETIRE_INSURANCE_S1;

-- ANALYZE.
ANALYZE TABLE HRR_RETIRE_INSURANCE COMPUTE STATISTICS;
ANALYZE INDEX HRR_RETIRE_INSURANCE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRR_RETIRE_INSURANCE_U2 COMPUTE STATISTICS;
