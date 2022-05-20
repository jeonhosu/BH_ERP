/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_MONTH_TOTAL_DUTY
/* Description  : 월근태 근태 집계 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_MONTH_TOTAL_DUTY              
( MONTH_TOTAL_ID                                NUMBER NOT NULL, 
  DUTY_ID                                       NUMBER NOT NULL,
  DUTY_COUNT                                    NUMBER DEFAULT 0,  
  NON_PAY_YN                                    VARCHAR2(1) DEFAULT 'N',
  DESCRIPTION                                   VARCHAR2(100),
  ATTRIBUTE1                                    VARCHAR2(100),
  ATTRIBUTE2                                    VARCHAR2(100),
  ATTRIBUTE3                                    VARCHAR2(100),
  ATTRIBUTE4                                    VARCHAR2(100),
  ATTRIBUTE5                                    VARCHAR2(100),
  PERSON_ID                                     NUMBER NOT NULL,
  DUTY_TYPE                                     VARCHAR2(2) NOT NULL,
  DUTY_YYYYMM                                   VARCHAR2(7) NOT NULL,
  WORK_CORP_ID                                  NUMBER NOT NULL,  
  CORP_ID                                       NUMBER NOT NULL,  
  SOB_ID                                        NUMBER NOT NULL,
  ORG_ID                                        NUMBER NOT NULL,
  CREATION_DATE                                 DATE NOT NULL,
  CREATED_BY                                    NUMBER NOT NULL,
  LAST_UPDATE_DATE                              DATE NOT NULL,
  LAST_UPDATED_BY                               NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.MONTH_TOTAL_ID IS '월근태 ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.DUTY_ID IS '근태ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.DUTY_COUNT IS '근태 집계수';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.NON_PAY_YN IS '근여공제 Y/N';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.DUTY_TYPE IS '근태구분';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.DUTY_YYYYMM IS '근태년월';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_MONTH_TOTAL_DUTY_U1 ON HRD_MONTH_TOTAL_DUTY(MONTH_TOTAL_ID, DUTY_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_MONTH_TOTAL_DUTY_N1 ON HRD_MONTH_TOTAL_DUTY(PERSON_ID, DUTY_TYPE, DUTY_YYYYMM, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
--CREATE SEQUENCE HRD_MONTH_TOTAL_DUTY_S1;

-- ANALYZE.
ANALYZE TABLE HRD_MONTH_TOTAL_DUTY COMPUTE STATISTICS;
ANALYZE INDEX HRD_MONTH_TOTAL_DUTY_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_MONTH_TOTAL_DUTY_N1 COMPUTE STATISTICS;
