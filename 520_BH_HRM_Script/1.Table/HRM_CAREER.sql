/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_CAREER,
/* Description  : 경력사항 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_CAREER              
(CAREER_ID                                        NUMBER NOT NULL,
  PERSON_ID                                        NUMBER NOT NULL,
  COMPANY_NAME	                            VARCHAR2(100) NOT NULL,
  DEPT_NAME	                                    VARCHAR2(100) ,
  POST_NAME	                                    VARCHAR2(80),
  JOB_NAME	                                      VARCHAR2(80),
  START_DATE	                                  DATE,	
  END_DATE	                                      DATE,
  CAREER_START_DATE	                    DATE,	
  CAREER_END_DATE	                        DATE,
  CAREER_YEAR_COUNT	                    NUMBER,	
  RETIRE_DESCRIPTION                     VARCHAR2(100),
  ZIP_CODE	                                      VARCHAR2(30),
  ADDR1	                                            VARCHAR2(150),
  ADDR2	                                            VARCHAR2(150),
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
COMMENT ON COLUMN HRM_CAREER.CAREER_ID IS '경력정보 ID';
COMMENT ON COLUMN HRM_CAREER.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRM_CAREER.COMPANY_NAME IS '업체명';
COMMENT ON COLUMN HRM_CAREER.DEPT_NAME IS '부서명';
COMMENT ON COLUMN HRM_CAREER.POST_NAME IS '직위명';
COMMENT ON COLUMN HRM_CAREER.JOB_NAME IS '담당업무';
COMMENT ON COLUMN HRM_CAREER.START_DATE IS '입사일자';
COMMENT ON COLUMN HRM_CAREER.END_DATE IS '퇴사일자';
COMMENT ON COLUMN HRM_CAREER.CAREER_START_DATE IS '경력 인정 입사일자';
COMMENT ON COLUMN HRM_CAREER.CAREER_END_DATE IS '경력 인정 퇴사일자';
COMMENT ON COLUMN HRM_CAREER.CAREER_YEAR_COUNT IS '경력 인정 년수';
COMMENT ON COLUMN HRM_CAREER.RETIRE_DESCRIPTION IS '퇴사사유';
COMMENT ON COLUMN HRM_CAREER.ZIP_CODE IS '우편번호';
COMMENT ON COLUMN HRM_CAREER.ADDR1 IS '주소1';
COMMENT ON COLUMN HRM_CAREER.ADDR2 IS '주소2';
COMMENT ON COLUMN HRM_CAREER.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRM_CAREER.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRM_CAREER.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_CAREER.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_CAREER.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_CAREER_U1 ON HRM_CAREER(CAREER_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRM_CAREER_U2 ON HRM_CAREER(PERSON_ID, COMPANY_NAME, START_DATE, END_DATE) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRM_CAREER_S1;
CREATE SEQUENCE HRM_CAREER_S1;

-- ANALYZE.
ANALYZE TABLE HRM_CAREER COMPUTE STATISTICS;
ANALYZE INDEX HRM_CAREER_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_CAREER_U2 COMPUTE STATISTICS;
