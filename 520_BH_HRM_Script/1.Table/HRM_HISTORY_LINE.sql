/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_HISTORY_LINE
/* Description  : 인사발령사항 LINE.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_HISTORY_LINE              
(HISTORY_LINE_ID                                  NUMBER NOT NULL,
  HISTORY_HEADER_ID                               NUMBER NOT NULL,
  HISTORY_NUM	                                    VARCHAR2(20) NOT NULL,
  PERSON_ID	                                      NUMBER NOT NULL,
  CHARGE_DATE	                                    DATE NOT NULL,
  CHARGE_ID	                                      NUMBER NOT NULL,
  RETIRE_ID	                                      NUMBER,
  OPERATING_UNIT_ID                               NUMBER,	
  DEPT_ID	                                        NUMBER,
  JOB_CLASS_ID	                                  NUMBER,
  JOB_ID	                                        NUMBER,
  POST_ID	                                        NUMBER,
  OCPT_ID	                                        NUMBER,
  ABIL_ID	                                        NUMBER,
  PAY_GRADE_ID	                                  NUMBER,
  JOB_CATEGORY_ID	                                NUMBER,
	FLOOR_ID                                        NUMBER,
  PRE_OPERATING_UNIT_ID                           NUMBER,	
  PRE_DEPT_ID	                                    NUMBER,
  PRE_JOB_CLASS_ID	                              NUMBER,
  PRE_JOB_ID	                                    NUMBER,
  PRE_POST_ID	                                    NUMBER,
  PRE_OCPT_ID	                                    NUMBER,
  PRE_ABIL_ID	                                    NUMBER,
  PRE_PAY_GRADE_ID	                              NUMBER,
  PRE_JOB_CATEGORY_ID	                            NUMBER,
	PRE_FLOOR_ID                                    NUMBER,
  PRINT_YN                                        VARCHAR2(1) DEFAULT 'Y',
  DESCRIPTION                                     VARCHAR2(100),
  ATTRIBUTE1                                      VARCHAR2(100),
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_HISTORY_LINE.HISTORY_LINE_ID IS '발령사항 LINE ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.HISTORY_HEADER_ID IS '발령사항 HEADER ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.HISTORY_NUM IS '발령번호';
COMMENT ON COLUMN HRM_HISTORY_LINE.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.CHARGE_DATE IS '발령일자';
COMMENT ON COLUMN HRM_HISTORY_LINE.CHARGE_ID IS '발령사유';
COMMENT ON COLUMN HRM_HISTORY_LINE.RETIRE_ID IS '퇴직사유';
COMMENT ON COLUMN HRM_HISTORY_LINE.OPERATING_UNIT_ID IS '사업장ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.DEPT_ID IS '부서ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.JOB_CLASS_ID IS '직군ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.JOB_ID IS '직종ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.POST_ID IS '직위ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.OCPT_ID IS '직무ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.ABIL_ID IS '직책ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PAY_GRADE_ID IS '직급ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.JOB_CATEGORY_ID IS '직구분ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.FLOOR_ID IS '작업장ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_OPERATING_UNIT_ID IS '전 사업장ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_DEPT_ID IS '전 부서ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_JOB_CLASS_ID IS '전 직군ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_JOB_ID IS '전 직종ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_POST_ID IS '전 직위ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_OCPT_ID IS '전 직무ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_ABIL_ID IS '전 직책ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_PAY_GRADE_ID IS '전 직급ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_JOB_CATEGORY_ID IS '전 직구분ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRE_FLOOR_ID IS '전 작업장ID';
COMMENT ON COLUMN HRM_HISTORY_LINE.PRINT_YN IS '인쇄 구분';
COMMENT ON COLUMN HRM_HISTORY_LINE.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRM_HISTORY_LINE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRM_HISTORY_LINE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_HISTORY_LINE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_HISTORY_LINE.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_HISTORY_LINE_U1 ON HRM_HISTORY_LINE(HISTORY_LINE_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRM_HISTORY_LINE_U2 ON HRM_HISTORY_LINE(HISTORY_HEADER_ID, PERSON_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRM_HISTORY_LINE_N1 ON HRM_HISTORY_LINE(PERSON_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRM_HISTORY_LINE_S1;
CREATE SEQUENCE HRM_HISTORY_LINE_S1;

-- ANALYZE.
ANALYZE TABLE HRM_HISTORY_LINE COMPUTE STATISTICS;
ANALYZE INDEX HRM_HISTORY_LINE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_HISTORY_LINE_U2 COMPUTE STATISTICS;
ANALYZE INDEX HRM_HISTORY_LINE_N1 COMPUTE STATISTICS;
