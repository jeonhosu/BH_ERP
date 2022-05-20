/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_DAY_INTERFACE
/* Description  : 출퇴근 수정 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_DAY_INTERFACE              
( PERSON_ID	                                      NUMBER NOT NULL,
  WORK_DATE	                                      DATE NOT NULL,
  WORK_CORP_ID                                    NUMBER NOT NULL,
	CORP_ID                                         NUMBER NOT NULL,
  DEPT_ID	                                        NUMBER,
  POST_ID	                                        NUMBER,
  JOB_CATEGORY_ID	                                NUMBER,
	WORK_TYPE_ID                                    NUMBER,
  DUTY_ID                                         NUMBER NOT NULL,
  HOLY_TYPE	                                      VARCHAR2(2) NOT NULL,
  OPEN_TIME	                                      DATE,
  CLOSE_TIME	                                    DATE,
  OPEN_TIME1	                                    DATE,
  CLOSE_TIME1	                                    DATE,
  NEXT_DAY_YN	                                    VARCHAR2(1) DEFAULT 'N',
  DANGJIK_YN                                      VARCHAR2(1) DEFAULT 'N',
  ALL_NIGHT_YN                                    VARCHAR2(1) DEFAULT 'N',
  LEAVE_ID	                                      NUMBER,
  LEAVE_TIME_CODE                                 VARCHAR2(10),
  MODIFY_YN	                                      VARCHAR2(1) DEFAULT 'N',
  MODIFY_IN_YN	                                  VARCHAR2(1) DEFAULT 'N',
  MODIFY_OUT_YN	                                  VARCHAR2(1) DEFAULT 'N',
  APPROVED_YN	                                    VARCHAR2(1) DEFAULT 'N',
  APPROVED_DATE	                                  DATE,
  APPROVED_PERSON_ID	                            NUMBER,
  APPROVED_IN_YN                                  VARCHAR2(1) DEFAULT 'N',
  APPROVED_IN_DATE	                              DATE,
  APPROVED_IN_PERSON_ID	                          NUMBER,
  CONFIRMED_YN	                                  VARCHAR2(1)  DEFAULT 'N',
  CONFIRMED_DATE	                                DATE,
  CONFIRMED_PERSON_ID	                            NUMBER,
	APPROVE_STATUS                                  VARCHAR2(1) DEFAULT 'N',
  EMAIL_STATUS                                    VARCHAR2(2) DEFAULT 'N',
  TRANS_YN	                                      VARCHAR2(1)  DEFAULT 'N',
  TRANS_DATE	                                    DATE,
  TRANS_PERSON_ID	                                NUMBER,
  DESCRIPTION                                     VARCHAR2(100),
  REJECT_REMARK                                   VARCHAR2(100),
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
COMMENT ON COLUMN HRD_DAY_INTERFACE.PERSON_ID IS '사원번호';
COMMENT ON COLUMN HRD_DAY_INTERFACE.WORK_DATE IS '근무일자';
COMMENT ON COLUMN HRD_DAY_INTERFACE.WORK_CORP_ID IS '업체ID';
COMMENT ON COLUMN HRD_DAY_INTERFACE.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRD_DAY_INTERFACE.DEPT_ID IS '부서ID';
COMMENT ON COLUMN HRD_DAY_INTERFACE.POST_ID IS '직위ID';
COMMENT ON COLUMN HRD_DAY_INTERFACE.JOB_CATEGORY_ID IS '직구분ID';
COMMENT ON COLUMN HRD_DAY_INTERFACE.WORK_TYPE_ID IS '교대유형ID';
COMMENT ON COLUMN HRD_DAY_INTERFACE.DUTY_ID IS '근태ID';
COMMENT ON COLUMN HRD_DAY_INTERFACE.HOLY_TYPE IS '근무타입';
COMMENT ON COLUMN HRD_DAY_INTERFACE.OPEN_TIME IS '출근일시';
COMMENT ON COLUMN HRD_DAY_INTERFACE.CLOSE_TIME IS '퇴근일시';
COMMENT ON COLUMN HRD_DAY_INTERFACE.OPEN_TIME1 IS '중출일시';
COMMENT ON COLUMN HRD_DAY_INTERFACE.CLOSE_TIME1 IS '중퇴일시';
COMMENT ON COLUMN HRD_DAY_INTERFACE.NEXT_DAY_YN IS '후일퇴근 여부';
COMMENT ON COLUMN HRD_DAY_INTERFACE.DANGJIK_YN IS '당직 근무';
COMMENT ON COLUMN HRD_DAY_INTERFACE.ALL_NIGHT_YN IS '철야 근무';
COMMENT ON COLUMN HRD_DAY_INTERFACE.LEAVE_ID IS '외출사유ID';
COMMENT ON COLUMN HRD_DAY_INTERFACE.LEAVE_TIME_CODE IS '외출시간코드';
COMMENT ON COLUMN HRD_DAY_INTERFACE.MODIFY_YN IS '수정여부';
COMMENT ON COLUMN HRD_DAY_INTERFACE.MODIFY_IN_YN IS '출근시간 수정';
COMMENT ON COLUMN HRD_DAY_INTERFACE.MODIFY_OUT_YN IS '퇴근시간 수정';
COMMENT ON COLUMN HRD_DAY_INTERFACE.APPROVED_YN IS '승인구분';
COMMENT ON COLUMN HRD_DAY_INTERFACE.APPROVED_DATE IS '승인일시';
COMMENT ON COLUMN HRD_DAY_INTERFACE.APPROVED_PERSON_ID IS '승인자';
COMMENT ON COLUMN HRD_DAY_INTERFACE.CONFIRMED_YN IS '확정승인구분';
COMMENT ON COLUMN HRD_DAY_INTERFACE.CONFIRMED_DATE IS '확정승인일시';
COMMENT ON COLUMN HRD_DAY_INTERFACE.CONFIRMED_PERSON_ID IS '확정승인자';
COMMENT ON COLUMN HRD_DAY_INTERFACE.APPROVE_STATUS IS '승인상태';
COMMENT ON COLUMN HRD_DAY_INTERFACE.EMAIL_STATUS IS 'EMAIL 발송여부(N-미발송,AR/BR-발송준비,AS/BS-발송완료)';
COMMENT ON COLUMN HRD_DAY_INTERFACE.TRANS_YN IS '마감여부';
COMMENT ON COLUMN HRD_DAY_INTERFACE.TRANS_DATE IS '마감일시';
COMMENT ON COLUMN HRD_DAY_INTERFACE.TRANS_PERSON_ID IS '마감처리자';
COMMENT ON COLUMN HRD_DAY_INTERFACE.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRD_DAY_INTERFACE.REJECT_REMARK IS '반려사유';
COMMENT ON COLUMN HRD_DAY_INTERFACE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_DAY_INTERFACE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_DAY_INTERFACE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_DAY_INTERFACE.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_DAY_INTERFACE_U1 ON HRD_DAY_INTERFACE(PERSON_ID, WORK_DATE, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_DAY_INTERFACE_N1 ON HRD_DAY_INTERFACE(PERSON_ID, WORK_DATE, WORK_CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_DAY_INTERFACE_N2 ON HRD_DAY_INTERFACE(PERSON_ID, WORK_DATE, WORK_CORP_ID, APPROVE_STATUS, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRD_DAY_INTERFACE COMPUTE STATISTICS;
ANALYZE INDEX HRD_DAY_INTERFACE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_DAY_INTERFACE_N1 COMPUTE STATISTICS;
