/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_MONTH_TOTAL
/* Description  : 월근태 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_MONTH_TOTAL              
( MONTH_TOTAL_ID                                NUMBER NOT NULL,
  PERSON_ID                                     NUMBER NOT NULL, 
	DUTY_TYPE                                     VARCHAR2(2) NOT NULL,
  DUTY_YYYYMM                                   VARCHAR2(7) NOT NULL,
  WORK_CORP_ID                                  NUMBER NOT NULL,
  CORP_ID                                       NUMBER NOT NULL,  
  DEPT_ID                                       NUMBER,
  POST_ID                                       NUMBER,
  JOB_CATEGORY_ID                               NUMBER,
  HOLIDAY_IN_COUNT                              NUMBER DEFAULT 0,
	LATE_DED_COUNT                                NUMBER DEFAULT 0,
  WEEKLY_DED_COUNT                              NUMBER DEFAULT 0,
  CHANGE_DED_COUNT                              NUMBER DEFAULT 0,
  HOLY_0_COUNT                                  NUMBER DEFAULT 0,
  HOLY_1_COUNT                                  NUMBER DEFAULT 0,
  HOLY_2_COUNT                                  NUMBER DEFAULT 0,
  HOLY_3_COUNT                                  NUMBER DEFAULT 0,
	TOTAL_DAY                                     NUMBER DEFAULT 0,
  TOTAL_ATT_DAY                                 NUMBER DEFAULT 0,
  TOTAL_DED_DAY                                 NUMBER DEFAULT 0,
  PAY_DAY                                       NUMBER DEFAULT 0,
  HOLY_0_DED_FLAG                               VARCHAR2(1) DEFAULT 'N',
  STD_HOLY_0_COUNT                              NUMBER DEFAULT 0,
  CLOSED_YN                                     VARCHAR2(1) DEFAULT 'N',  
  CLOSED_DATE                                   DATE,
  CLOSED_PERSON_ID                              NUMBER,
  DESCRIPTION                                   VARCHAR2(100),
  ATTRIBUTE1                                    VARCHAR2(100),
  ATTRIBUTE2                                    VARCHAR2(100),
  ATTRIBUTE3                                    VARCHAR2(100),
  ATTRIBUTE4                                    VARCHAR2(100),
  ATTRIBUTE5                                    VARCHAR2(100),
	SOB_ID                                        NUMBER NOT NULL,
	ORG_ID                                        NUMBER NOT NULL,
  CREATION_DATE                                 DATE NOT NULL,
  CREATED_BY                                    NUMBER NOT NULL,
  LAST_UPDATE_DATE                              DATE NOT NULL,
  LAST_UPDATED_BY                               NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_MONTH_TOTAL.MONTH_TOTAL_ID IS '월근태 ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL.DUTY_TYPE IS '근태 타입(1-월근태)';
COMMENT ON COLUMN HRD_MONTH_TOTAL.DUTY_YYYYMM IS '근태년월';
COMMENT ON COLUMN HRD_MONTH_TOTAL.WORK_CORP_ID IS '근무 업체 ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL.CORP_ID IS '소속 업체ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL.DEPT_ID IS '부서코드';
COMMENT ON COLUMN HRD_MONTH_TOTAL.POST_ID IS '직위코드';
COMMENT ON COLUMN HRD_MONTH_TOTAL.JOB_CATEGORY_ID IS '직구분';
COMMENT ON COLUMN HRD_MONTH_TOTAL.HOLIDAY_IN_COUNT IS '휴일근무횟수';
COMMENT ON COLUMN HRD_MONTH_TOTAL.LATE_DED_COUNT IS '지각조퇴횟수';
COMMENT ON COLUMN HRD_MONTH_TOTAL.WEEKLY_DED_COUNT IS '주휴공제일수';
COMMENT ON COLUMN HRD_MONTH_TOTAL.CHANGE_DED_COUNT IS '교대주휴공제일수-교대조 변경에 따른 주휴공제';
COMMENT ON COLUMN HRD_MONTH_TOTAL.HOLY_0_COUNT IS '무휴횟수';
COMMENT ON COLUMN HRD_MONTH_TOTAL.HOLY_1_COUNT IS '유휴횟수';
COMMENT ON COLUMN HRD_MONTH_TOTAL.HOLY_2_COUNT IS '주간횟수';
COMMENT ON COLUMN HRD_MONTH_TOTAL.HOLY_3_COUNT IS '야간횟수';
COMMENT ON COLUMN HRD_MONTH_TOTAL.TOTAL_DAY IS '월 총일수';
COMMENT ON COLUMN HRD_MONTH_TOTAL.TOTAL_ATT_DAY IS '출근일수';
COMMENT ON COLUMN HRD_MONTH_TOTAL.TOTAL_DED_DAY IS '총공제일수';
COMMENT ON COLUMN HRD_MONTH_TOTAL.PAY_DAY IS '급여일수';
COMMENT ON COLUMN HRD_MONTH_TOTAL.HOLY_0_DED_FLAG IS '무급휴일 공제 여부';
COMMENT ON COLUMN HRD_MONTH_TOTAL.STD_HOLY_0_COUNT IS '기준 무급휴일수';
COMMENT ON COLUMN HRD_MONTH_TOTAL.CLOSED_YN IS '마감구분';
COMMENT ON COLUMN HRD_MONTH_TOTAL.CLOSED_DATE IS '마감일시';
COMMENT ON COLUMN HRD_MONTH_TOTAL.CLOSED_PERSON_ID IS '마감처리자';
COMMENT ON COLUMN HRD_MONTH_TOTAL.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRD_MONTH_TOTAL.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_MONTH_TOTAL.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_MONTH_TOTAL.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_MONTH_TOTAL.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_MONTH_TOTAL_U1 ON HRD_MONTH_TOTAL(MONTH_TOTAL_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRD_MONTH_TOTAL_U2 ON HRD_MONTH_TOTAL(PERSON_ID, DUTY_YYYYMM, DUTY_TYPE, WORK_CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRD_MONTH_TOTAL_U3 ON HRD_MONTH_TOTAL(PERSON_ID, DUTY_YYYYMM, DUTY_TYPE, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE HRD_MONTH_TOTAL_S1;

-- ANALYZE.
ANALYZE TABLE HRD_MONTH_TOTAL COMPUTE STATISTICS;
ANALYZE INDEX HRD_MONTH_TOTAL_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_MONTH_TOTAL_U2 COMPUTE STATISTICS;
ANALYZE INDEX HRD_MONTH_TOTAL_U3 COMPUTE STATISTICS;
