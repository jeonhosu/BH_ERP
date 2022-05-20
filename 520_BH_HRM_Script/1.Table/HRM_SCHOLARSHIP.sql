/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_SCHOLARSHIP
/* Description  : 학력사항 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_SCHOLARSHIP              
(SCHOLARSHIP_ID	                            NUMBER NOT NULL,
  PERSON_ID                                      NUMBER NOT NULL,
  SCHOLARSHIP_TYPE_ID                   NUMBER,
  GRADUATION_TYPE_ID                    NUMBER,
  ADMISSION_DATE	                          DATE,	
  GRADUATION_DATE	                        DATE,	
  SCHOOL_NAME	                              VARCHAR2(100),
  SPECIAL_STUDY_NAME	                  VARCHAR2(100),
  SUB_STUDY_NAME	                        VARCHAR2(100),
  DEGREE_ID                                       NUMBER,
  DESCRIPTION                               VARCHAR2(100),
  ATTRIBUTE1                                    VARCHAR2(100),
  ATTRIBUTE2                                    VARCHAR2(100),
  ATTRIBUTE3                                    VARCHAR2(100),
  ATTRIBUTE4                                    VARCHAR2(100),
  ATTRIBUTE5                                    VARCHAR2(100),
  CREATION_DATE                             DATE NOT NULL,
  CREATED_BY                                  NUMBER NOT NULL,
  LAST_UPDATE_DATE                       DATE NOT NULL,
  LAST_UPDATED_BY                         NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_SCHOLARSHIP.SCHOLARSHIP_ID IS '학력사항 ID';
COMMENT ON COLUMN HRM_SCHOLARSHIP.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRM_SCHOLARSHIP.SCHOLARSHIP_TYPE_ID IS '학력타입 ID';
COMMENT ON COLUMN HRM_SCHOLARSHIP.GRADUATION_TYPE_ID IS '졸업구분 ID';
COMMENT ON COLUMN HRM_SCHOLARSHIP.ADMISSION_DATE IS '입학일자';
COMMENT ON COLUMN HRM_SCHOLARSHIP.GRADUATION_DATE IS '졸업일자';
COMMENT ON COLUMN HRM_SCHOLARSHIP.SCHOOL_NAME IS '학교명';
COMMENT ON COLUMN HRM_SCHOLARSHIP.SPECIAL_STUDY_NAME IS '전공';
COMMENT ON COLUMN HRM_SCHOLARSHIP.SUB_STUDY_NAME IS '부전공';
COMMENT ON COLUMN HRM_SCHOLARSHIP.DEGREE_ID IS '학위 ID';
COMMENT ON COLUMN HRM_SCHOLARSHIP.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRM_SCHOLARSHIP.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRM_SCHOLARSHIP.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_SCHOLARSHIP.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_SCHOLARSHIP.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_SCHOLARSHIP_U1 ON HRM_SCHOLARSHIP(SCHOLARSHIP_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRM_SCHOLARSHIP_N1 ON HRM_SCHOLARSHIP(PERSON_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE;
DROP SEQUENCE HRM_SCHOLARSHIP_S1;
CREATE SEQUENCE HRM_SCHOLARSHIP_S1;

-- ANALYZE.
ANALYZE TABLE HRM_SCHOLARSHIP COMPUTE STATISTICS;
ANALYZE INDEX HRM_SCHOLARSHIP_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_SCHOLARSHIP_N1 COMPUTE STATISTICS;
