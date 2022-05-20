/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_EDUCATION
/* Description  : 교육사항 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_EDUCATION
(EDUCATION_ID                                 NUMBER NOT NULL,
  PERSON_ID                                     NUMBER NOT NULL,
  START_DATE	                                DATE	NOT NULL,
  END_DATE	                                    DATE	NOT NULL,
  EDU_ORG	                                      VARCHAR2(100),
  EDU_CURRICULUM	                        VARCHAR2(100),
  EDU_PAY_AMOUNT	                       NUMBER DEFAULT 0,	
  EDU_PAY_RETURN_AMOUNT	          NUMBER DEFAULT 0,
  DESCRIPTION	                              VARCHAR2(100),
  ATTRIBUTE1	                                  VARCHAR2(100),
  ATTRIBUTE2	                                  VARCHAR2(100),
  ATTRIBUTE3	                                  VARCHAR2(100),
  ATTRIBUTE4	                                  VARCHAR2(100),
  ATTRIBUTE5	                                  VARCHAR2(100),
  CREATION_DATE                             DATE NOT NULL,
  CREATED_BY                                  NUMBER NOT NULL,
  LAST_UPDATE_DATE                       DATE NOT NULL,
  LAST_UPDATED_BY                         NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_EDUCATION.EDUCATION_ID IS '교육사항 ID';
COMMENT ON COLUMN HRM_EDUCATION.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRM_EDUCATION.START_DATE IS '교육시작일자';
COMMENT ON COLUMN HRM_EDUCATION.END_DATE IS '교육종료일자';
COMMENT ON COLUMN HRM_EDUCATION.EDU_ORG IS '교육기관';
COMMENT ON COLUMN HRM_EDUCATION.EDU_CURRICULUM IS '교육명';
COMMENT ON COLUMN HRM_EDUCATION.EDU_PAY_AMOUNT IS '교육비';
COMMENT ON COLUMN HRM_EDUCATION.EDU_PAY_RETURN_AMOUNT IS '교육비환급액';
COMMENT ON COLUMN HRM_EDUCATION.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRM_EDUCATION.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRM_EDUCATION.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_EDUCATION.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_EDUCATION.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_EDUCATION_U1 ON HRM_EDUCATION(EDUCATION_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRM_EDUCATION_U2 ON HRM_EDUCATION(PERSON_ID, START_DATE, END_DATE) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRM_EDUCATION_S1;
CREATE SEQUENCE HRM_EDUCATION_S1;

-- ANALYZE.
ANALYZE TABLE HRM_EDUCATION COMPUTE STATISTICS;
ANALYZE INDEX HRM_EDUCATION_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_EDUCATION_U2 COMPUTE STATISTICS;
