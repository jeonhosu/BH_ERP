/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_DUTY_PERIOD
/* Description  : 고정근태 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_DUTY_PERIOD              
( DUTY_PERIOD_ID                                  NUMBER NOT NULL,
  START_DATE	                                    DATE NOT NULL,	
  END_DATE	                                      DATE NOT NULL,
  PERSON_ID	                                      NUMBER NOT NULL,
	DUTY_ID	                                        NUMBER NOT NULL,
  CORP_ID                                         NUMBER NOT NULL,
	WORK_START_DATE	                                DATE, 
	REAL_START_DATE	                                DATE, 
	WORK_END_DATE	                                  DATE,
  REAL_END_DATE	                                  DATE,
  APPROVED_YN	                                    CHAR(1)     DEFAULT 'N',
  APPROVED_DATE	                                  DATE, 
  APPROVED_PERSON_ID                              NUMBER,
  CONFIRMED_YN	                                  CHAR(1)     DEFAULT 'N',
  CONFIRMED_DATE	                                DATE,
  CONFIRMED_PERSON_ID	                            NUMBER,
	APPROVE_STATUS                                  VARCHAR2(1) DEFAULT 'A',
	CALENDAR_TRAN_YN                                CHAR(1)     DEFAULT 'N',
  EMAIL_STATUS                                    VARCHAR(2)  DEFAULT 'N',
  DESCRIPTION                                     VARCHAR2(100),
  REJECT_YN	                                      CHAR(1)     DEFAULT 'N',
  REJECT_DATE	                                    DATE,
  REJECT_PERSON_ID	                              NUMBER,
  REJECT_REMARK                                   VARCHAR2(100),
  ATTRIBUTE1                                      VARCHAR2(100),
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
	SOB_ID                                          NUMBER,
	ORG_ID                                          NUMBER,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_DUTY_PERIOD.DUTY_PERIOD_ID IS '일련번호';
COMMENT ON COLUMN HRD_DUTY_PERIOD.PERSON_ID IS '사원번호';
COMMENT ON COLUMN HRD_DUTY_PERIOD.START_DATE IS '시작일자';
COMMENT ON COLUMN HRD_DUTY_PERIOD.END_DATE IS '종료일자';
COMMENT ON COLUMN HRD_DUTY_PERIOD.DUTY_ID IS '근태 ID';
COMMENT ON COLUMN HRD_DUTY_PERIOD.WORK_START_DATE IS '해당 근무 시작시간';
COMMENT ON COLUMN HRD_DUTY_PERIOD.REAL_START_DATE IS '실제 근무 시작시간';
COMMENT ON COLUMN HRD_DUTY_PERIOD.WORK_END_DATE IS '해당 근무 종료시간';
COMMENT ON COLUMN HRD_DUTY_PERIOD.REAL_END_DATE IS '실제 근무 종료시간';
COMMENT ON COLUMN HRD_DUTY_PERIOD.APPROVED_YN IS '1차 승인구분';
COMMENT ON COLUMN HRD_DUTY_PERIOD.APPROVED_DATE IS '1차 승인일시';
COMMENT ON COLUMN HRD_DUTY_PERIOD.APPROVED_PERSON_ID IS '1차 승인자';
COMMENT ON COLUMN HRD_DUTY_PERIOD.CONFIRMED_YN IS '확정승인구분-승인시 근무카렌다 반영';
COMMENT ON COLUMN HRD_DUTY_PERIOD.CONFIRMED_DATE IS '확정승인일시';
COMMENT ON COLUMN HRD_DUTY_PERIOD.CONFIRMED_PERSON_ID IS '확정승인자';
COMMENT ON COLUMN HRD_DUTY_PERIOD.APPROVE_STATUS IS '승인 상태(A-미승인,B-1차승인, C-확정승인)';
COMMENT ON COLUMN HRD_DUTY_PERIOD.CALENDAR_TRAN_YN IS '카렌다 반영 구분';
COMMENT ON COLUMN HRD_DUTY_PERIOD.EMAIL_STATUS IS 'EMAIL 발송 여부(N-미발송, AR/BR-발송준비, AS/BS-발송)';
COMMENT ON COLUMN HRD_DUTY_PERIOD.DESCRIPTION IS '비고(사유)';
COMMENT ON COLUMN HRD_DUTY_PERIOD.REJECT_YN IS '반려여부';
COMMENT ON COLUMN HRD_DUTY_PERIOD.REJECT_DATE IS '반려승인일시';
COMMENT ON COLUMN HRD_DUTY_PERIOD.REJECT_PERSON_ID IS '반려승인자';
COMMENT ON COLUMN HRD_DUTY_PERIOD.REJECT_REMARK IS '반려사유';
COMMENT ON COLUMN HRD_DUTY_PERIOD.ATTRIBUTE5 IS '근태코드';
COMMENT ON COLUMN HRD_DUTY_PERIOD.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_DUTY_PERIOD.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_DUTY_PERIOD.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_DUTY_PERIOD.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_DUTY_PERIOD_U1 ON HRD_DUTY_PERIOD(DUTY_PERIOD_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRD_DUTY_PERIOD_U2 ON HRD_DUTY_PERIOD(START_DATE, END_DATE, PERSON_ID, DUTY_ID, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_DUTY_PERIOD_N1 ON HRD_DUTY_PERIOD(APPROVE_STATUS, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_DUTY_PERIOD_N2 ON HRD_DUTY_PERIOD(TRUNC(WORK_START_DATE), TRUNC(WORK_END_DATE), CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_DUTY_PERIOD_N3 ON HRD_DUTY_PERIOD(EMAIL_STATUS, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;


-- SEQUENCE;
DROP SEQUENCE HRD_DUTY_PERIOD_S1;
CREATE SEQUENCE HRD_DUTY_PERIOD_S1;

-- ANALYZE.
ANALYZE TABLE HRD_DUTY_PERIOD COMPUTE STATISTICS;
ANALYZE INDEX HRD_DUTY_PERIOD_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_DUTY_PERIOD_U2 COMPUTE STATISTICS;
ANALYZE INDEX HRD_DUTY_PERIOD_N1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_DUTY_PERIOD_N2 COMPUTE STATISTICS;
ANALYZE INDEX HRD_DUTY_PERIOD_N3 COMPUTE STATISTICS;
