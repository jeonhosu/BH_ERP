/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_FAMILY.
/* Description  : 부양가족 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_FAMILY
( FAMILY_ID                                       NUMBER NOT NULL,
  PERSON_ID	                                      NUMBER NOT NULL,
  FAMILY_NAME	                                    VARCHAR2(100) NOT NULL,
  RELATION_ID	                                    NUMBER NOT NULL,
  REPRE_NUM	                                      VARCHAR2(30),
  BIRTHDAY	                                      DATE,
  BIRTHDAY_TYPE                                   VARCHAR2(1),
  COMPANY_NAME	                                  VARCHAR2(100),
  POST_NAME	                                      VARCHAR2(100),
  END_SCH_ID	                                    NUMBER,
  LIVE_YN	                                        VARCHAR2(1) DEFAULT 'N',
  MARRY_YN	                                      VARCHAR2(1) DEFAULT 'N',
  DEFORM_YN	                                      VARCHAR2(1) DEFAULT 'N',
  PAY_YN                                          VARCHAR2(1) DEFAULT 'N',
  TAX_YN                                          VARCHAR2(1) DEFAULT 'N',
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
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_FAMILY.FAMILY_ID IS '가족사항 ID';
COMMENT ON COLUMN HRM_FAMILY.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRM_FAMILY.FAMILY_NAME IS '성명';
COMMENT ON COLUMN HRM_FAMILY.RELATION_ID IS '관계 ID';
COMMENT ON COLUMN HRM_FAMILY.REPRE_NUM IS '주민번호';
COMMENT ON COLUMN HRM_FAMILY.BIRTHDAY IS '생년월일';
COMMENT ON COLUMN HRM_FAMILY.BIRTHDAY_TYPE IS '음양구분(1-음, 2-양)';
COMMENT ON COLUMN HRM_FAMILY.COMPANY_NAME IS '회사명';
COMMENT ON COLUMN HRM_FAMILY.POST_NAME IS '직위명';
COMMENT ON COLUMN HRM_FAMILY.END_SCH_ID IS '최종학력';
COMMENT ON COLUMN HRM_FAMILY.LIVE_YN IS '동거여부';
COMMENT ON COLUMN HRM_FAMILY.MARRY_YN IS '결혼여부';
COMMENT ON COLUMN HRM_FAMILY.DEFORM_YN IS '장애여부';
COMMENT ON COLUMN HRM_FAMILY.PAY_YN IS '가족수당 지급여부';
COMMENT ON COLUMN HRM_FAMILY.TAX_YN IS '부양가족공제';
COMMENT ON COLUMN HRM_FAMILY.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRM_FAMILY.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRM_FAMILY.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_FAMILY.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_FAMILY.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_FAMILY_U1 ON HRM_FAMILY(FAMILY_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRM_FAMILY_U2 ON HRM_FAMILY(PERSON_ID, FAMILY_NAME, RELATION_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRM_FAMILY_S1;
CREATE SEQUENCE HRM_FAMILY_S1;

-- ANALYZE.
ANALYZE TABLE HRM_FAMILY COMPUTE STATISTICS;
ANALYZE INDEX HRM_FAMILY_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_FAMILY_U2 COMPUTE STATISTICS;
