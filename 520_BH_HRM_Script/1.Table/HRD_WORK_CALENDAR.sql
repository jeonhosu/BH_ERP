/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_WORK_CALENDAR
/* Description  : 근무계획 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_WORK_CALENDAR              
( WORK_DATE	                                      DATE NOT NULL,
  PERSON_ID	                                      NUMBER NOT NULL,
  WORK_CORP_ID                                    NUMBER NOT NULL,
	CORP_ID                                         NUMBER NOT NULL,
  WORK_YYYYMM                                     VARCHAR2(7),
  WORK_WEEK	                                      VARCHAR2(2),
  WORK_TYPE_ID                                    NUMBER,
  DUTY_ID	                                        NUMBER,
  C_DUTY_ID	                                      NUMBER,
  C_DUTY_ID1                                      NUMBER,
  HOLY_TYPE	                                      VARCHAR2(2),
  OPEN_TIME	                                      DATE,
  CLOSE_TIME	                                    DATE,	
  OLD_OPEN_TIME	                                  DATE,	
  OLD_CLOSE_TIME	                                DATE,
  BEFORE_OT_START	                                DATE,
  BEFORE_OT_END	                                  DATE,
  AFTER_OT_START	                                DATE,
  AFTER_OT_END	                                  DATE,
  LUNCH_YN	                                      VARCHAR2(1) DEFAULT 'N',
  DINNER_YN	                                      VARCHAR2(1) DEFAULT 'N',
  MIDNIGHT_YN	                                    VARCHAR2(1) DEFAULT 'N',
  DANGJIK_YN	                                    VARCHAR2(1) DEFAULT 'N',
  ALL_NIGHT_YN	                                  VARCHAR2(1) DEFAULT 'N',
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
  LAST_UPDATED_BY                                 NUMBER NOT NULL,
  LATE_IN_FR	                                    DATE,
  LATE_IN_TO	                                    DATE,
  EARLY_OUT_FR	                                  DATE,
  EARLY_OUT_TO	                                  DATE,
  SHORT_OUT_FR	                                  DATE,
  SHORT_OUT_TO	                                  DATE,
  WORK_OUT_FR	                                    DATE,
  WORK_OUT_TO	                                    DATE  
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_WORK_CALENDAR.WORK_DATE IS '근무일자';
COMMENT ON COLUMN HRD_WORK_CALENDAR.PERSON_ID IS '사원번호';
COMMENT ON COLUMN HRD_WORK_CALENDAR.WORK_CORP_ID IS '근무 업체ID';
COMMENT ON COLUMN HRD_WORK_CALENDAR.CORP_ID IS '소속 업체ID';
COMMENT ON COLUMN HRD_WORK_CALENDAR.WORK_YYYYMM IS '월근태 년월';
COMMENT ON COLUMN HRD_WORK_CALENDAR.WORK_WEEK IS '요일';
COMMENT ON COLUMN HRD_WORK_CALENDAR.WORK_TYPE_ID IS '근무유형ID';
COMMENT ON COLUMN HRD_WORK_CALENDAR.DUTY_ID IS '근태ID';
COMMENT ON COLUMN HRD_WORK_CALENDAR.C_DUTY_ID IS '변경 근태ID1';
COMMENT ON COLUMN HRD_WORK_CALENDAR.C_DUTY_ID1 IS '변경 근태ID2';
COMMENT ON COLUMN HRD_WORK_CALENDAR.HOLY_TYPE IS '근무구분';
COMMENT ON COLUMN HRD_WORK_CALENDAR.OPEN_TIME IS '출근일시';
COMMENT ON COLUMN HRD_WORK_CALENDAR.CLOSE_TIME IS '퇴근일시';
COMMENT ON COLUMN HRD_WORK_CALENDAR.OLD_OPEN_TIME IS '변경전 출근일시';
COMMENT ON COLUMN HRD_WORK_CALENDAR.OLD_CLOSE_TIME IS '변경전 퇴근일시';
COMMENT ON COLUMN HRD_WORK_CALENDAR.BEFORE_OT_START IS '근무전 연장 시작시간';
COMMENT ON COLUMN HRD_WORK_CALENDAR.BEFORE_OT_END IS '근무전 연장 종료시간';
COMMENT ON COLUMN HRD_WORK_CALENDAR.AFTER_OT_START IS '근무후 연장 시작시간';
COMMENT ON COLUMN HRD_WORK_CALENDAR.AFTER_OT_END IS '근무후 연장 종료시간';
COMMENT ON COLUMN HRD_WORK_CALENDAR.OUTING_START IS '외출 시작시간';
COMMENT ON COLUMN HRD_WORK_CALENDAR.OUTING_END IS '외출 종료시간';
COMMENT ON COLUMN HRD_WORK_CALENDAR.LUNCH_YN IS '중식연장 여부';
COMMENT ON COLUMN HRD_WORK_CALENDAR.DINNER_YN IS '석식연장 여부';
COMMENT ON COLUMN HRD_WORK_CALENDAR.MIDNIGHT_YN IS '야식연장 여부';
COMMENT ON COLUMN HRD_WORK_CALENDAR.DANGJIK_YN IS '당직 여부';
COMMENT ON COLUMN HRD_WORK_CALENDAR.ALL_NIGHT_YN IS '철야 여부';
COMMENT ON COLUMN HRD_WORK_CALENDAR.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRD_WORK_CALENDAR.ATTRIBUTE5 IS '교대유형 TYPE';
COMMENT ON COLUMN HRD_WORK_CALENDAR.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_WORK_CALENDAR.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_WORK_CALENDAR.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_WORK_CALENDAR.LAST_UPDATED_BY IS '최종수정자';
COMMENT ON COLUMN HRD_WORK_CALENDAR.LATE_IN_FR IS '지각 시작시간';
COMMENT ON COLUMN HRD_WORK_CALENDAR.LATE_IN_TO IS '지각 종료시간';
COMMENT ON COLUMN HRD_WORK_CALENDAR.EARLY_OUT_FR IS '조퇴 시작시간';
COMMENT ON COLUMN HRD_WORK_CALENDAR.EARLY_OUT_TO IS '조퇴 종료시간';
COMMENT ON COLUMN HRD_WORK_CALENDAR.SHORT_OUT_FR IS '외출 시작시간';
COMMENT ON COLUMN HRD_WORK_CALENDAR.SHORT_OUT_TO IS '외출 종료시간';
COMMENT ON COLUMN HRD_WORK_CALENDAR.WORK_OUT_FR IS '외근 시작시간';
COMMENT ON COLUMN HRD_WORK_CALENDAR.WORK_OUT_TO IS '외근 종료시간';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_WORK_CALENDAR_U1 ON HRD_WORK_CALENDAR(WORK_DATE, PERSON_ID, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_WORK_CALENDAR_N1 ON HRD_WORK_CALENDAR(WORK_DATE, PERSON_ID, WORK_CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_WORK_CALENDAR_N2 ON HRD_WORK_CALENDAR(WORK_YYYYMM, PERSON_ID, WORK_CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
-- ANALYZE.
ANALYZE TABLE HRD_WORK_CALENDAR COMPUTE STATISTICS;
ANALYZE INDEX HRD_WORK_CALENDAR_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_WORK_CALENDAR_N1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_WORK_CALENDAR_N2 COMPUTE STATISTICS;
