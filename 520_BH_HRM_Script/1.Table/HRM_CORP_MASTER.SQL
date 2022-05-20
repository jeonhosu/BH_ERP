/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_CORP_MASTER
/* Description  : 업체정보 관리
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_CORP_MASTER							
( CORP_ID		                                    NUMBER NOT NULL, 
  CORP_NAME		                                  VARCHAR2(100) NOT NULL,
  CORP_NAME_S		                                VARCHAR2(100),
  LEGAL_NUMBER		                              VARCHAR2(50),
  PRESIDENT_NAME		                            VARCHAR2(80),
  ZIP_CODE		                                  VARCHAR2(20),
  ADDR1		                                      VARCHAR2(150),
  ADDR2		                                      VARCHAR2(150),
  CORP_CATEGORY		                              VARCHAR2(2),
  CORP_TYPE	                                    VARCHAR2(2),
  CORP_SORT_NUM		                              NUMBER,
  PERSON_CHARGE_NAME                            VARCHAR2(80),
  TEL_NUMBER		                                VARCHAR2(20),
  FAX_NUMBER		                                VARCHAR2(20),
  EMAIL                                         VARCHAR2(100),
  HOMEPAGE_URL		                              VARCHAR2(100),
  DEPT_CONTROL_YN                               VARCHAR2(1) DEFAULT 'N',
  DEPT_CONTROL_LEVEL                            NUMBER,
  DUTY_CONTROL_YN                               VARCHAR2(1) DEFAULT 'N',
  PAY_CONTROL_YN                                VARCHAR2(1) DEFAULT 'N',
	DEFAULT_FLAG                                  VARCHAR2(1) DEFAULT 'N',
  ATTRIBUTE1		                                VARCHAR2(100),
  ATTRIBUTE2		                                VARCHAR2(100),
  ATTRIBUTE3		                                VARCHAR2(100),
  ATTRIBUTE4		                                VARCHAR2(100),
  ATTRIBUTE5		                                VARCHAR2(100),
  ENABLED_FLAG                                  VARCHAR2(1),
  EFFECTIVE_DATE_FR                             DATE NOT NULL,
  EFFECTIVE_DATE_TO                             DATE,
	SOB_ID                                        NUMBER NOT NULL,
	ORG_ID                                        NUMBER NOT NULL,
  CREATION_DATE		                              DATE NOT NULL,
  CREATED_BY		                                NUMBER NOT NULL,
  LAST_UPDATE_DATE	                            DATE NOT NULL,
  LAST_UPDATED_BY	                              NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_CORP_MASTER.CORP_ID IS '업체 일련번호';
COMMENT ON COLUMN HRM_CORP_MASTER.CORP_NAME IS '업체 상호';
COMMENT ON COLUMN HRM_CORP_MASTER.CORP_NAME_S IS '업체 약호';
COMMENT ON COLUMN HRM_CORP_MASTER.LEGAL_NUMBER IS '법인번호';
COMMENT ON COLUMN HRM_CORP_MASTER.PRESIDENT_NAME IS '대표자 성명';
COMMENT ON COLUMN HRM_CORP_MASTER.ADDR1 IS '주소1';
COMMENT ON COLUMN HRM_CORP_MASTER.ADDR2 IS '주소2';
COMMENT ON COLUMN HRM_CORP_MASTER.CORP_CATEGORY IS '업체 카테고리(P-개인, L-법인)';
COMMENT ON COLUMN HRM_CORP_MASTER.CORP_TYPE IS '업체 타입(1-자산, 2-소사, 3-외주)';
COMMENT ON COLUMN HRM_CORP_MASTER.CORP_SORT_NUM IS '정렬순서';
COMMENT ON COLUMN HRM_CORP_MASTER.PERSON_CHARGE_NAME IS '담당자';
COMMENT ON COLUMN HRM_CORP_MASTER.TEL_NUMBER IS '전화번호';
COMMENT ON COLUMN HRM_CORP_MASTER.FAX_NUMBER IS '팩스번호';
COMMENT ON COLUMN HRM_CORP_MASTER.EMAIL IS '이메일주소';
COMMENT ON COLUMN HRM_CORP_MASTER.HOMEPAGE_URL IS '홈페이지 URL';
COMMENT ON COLUMN HRM_CORP_MASTER.DEPT_CONTROL_YN IS '조직관리 여부';
COMMENT ON COLUMN HRM_CORP_MASTER.DEPT_CONTROL_LEVEL IS '조직관리 LEVEL';
COMMENT ON COLUMN HRM_CORP_MASTER.DUTY_CONTROL_YN IS '근태관리 여부';
COMMENT ON COLUMN HRM_CORP_MASTER.PAY_CONTROL_YN IS '급여관리 여부';
COMMENT ON COLUMN HRM_CORP_MASTER.DEFAULT_FLAG IS '기본';
COMMENT ON COLUMN HRM_CORP_MASTER.ENABLED_FLAG IS '사용여부';
COMMENT ON COLUMN HRM_CORP_MASTER.EFFECTIVE_DATE_FR IS '적용 시작일자';
COMMENT ON COLUMN HRM_CORP_MASTER.EFFECTIVE_DATE_TO IS '적용 종료일자';
COMMENT ON COLUMN HRM_CORP_MASTER.CREATION_DATE	IS '생성일자';
COMMENT ON COLUMN HRM_CORP_MASTER.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_CORP_MASTER.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_CORP_MASTER.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_CORP_MASTER_U1 ON HRM_CORP_MASTER(CORP_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRM_CORP_MASTER_N1 ON HRM_CORP_MASTER(DEPT_CONTROL_YN, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRM_CORP_MASTER_N2 ON HRM_CORP_MASTER(DUTY_CONTROL_YN, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRM_CORP_MASTER_N3 ON HRM_CORP_MASTER(PAY_CONTROL_YN, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- CREATE SEQUENCE;
DROP SEQUENCE HRM_CORP_MASTER_S1;
CREATE SEQUENCE HRM_CORP_MASTER_S1;

-- ANALYZE.
ANALYZE TABLE HRM_CORP_MASTER COMPUTE STATISTICS;
ANALYZE INDEX HRM_CORP_MASTER_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_CORP_MASTER_N1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_CORP_MASTER_N2 COMPUTE STATISTICS;
ANALYZE INDEX HRM_CORP_MASTER_N3 COMPUTE STATISTICS;
