/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_LICENSE
/* Description  : 자격사항 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_LICENSE              
(PERSON_ID                                    NUMBER NOT NULL,
  LICENSE_ID	                                  NUMBER NOT NULL,
  LICENSE_GRADE_ID                       NUMBER,
  LICENSE_NO	                               VARCHAR2(100),
  LICENSE_DATE	                            DATE,	
  LICENSE_ORG	                              VARCHAR2(100),
  RENEW_DATE	                              DATE,
  DESCRIPTION                             VARCHAR2(100),
  ATTRIBUTE1                                  VARCHAR2(100),
  ATTRIBUTE2                                  VARCHAR2(100),
  ATTRIBUTE3                                  VARCHAR2(100),
  ATTRIBUTE4                                  VARCHAR2(100),
  ATTRIBUTE5                                  VARCHAR2(100),
  CREATION_DATE                            DATE NOT NULL,
  CREATED_BY                                  NUMBER NOT NULL,
  LAST_UPDATE_DATE                       DATE NOT NULL,
  LAST_UPDATED_BY                         NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_LICENSE.PERSON_ID IS '사원번호';
COMMENT ON COLUMN HRM_LICENSE.LICENSE_ID IS '자격증 종류 ID';
COMMENT ON COLUMN HRM_LICENSE.LICENSE_GRADE_ID IS '자격증 등급';
COMMENT ON COLUMN HRM_LICENSE.LICENSE_NO IS '자격증 번호';
COMMENT ON COLUMN HRM_LICENSE.LICENSE_DATE IS '자격 취득일자';
COMMENT ON COLUMN HRM_LICENSE.LICENSE_ORG IS '자격증 발급기관';
COMMENT ON COLUMN HRM_LICENSE.RENEW_DATE IS '자격증 갱신일자';
COMMENT ON COLUMN HRM_LICENSE.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRM_LICENSE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRM_LICENSE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_LICENSE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_LICENSE.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_LICENSE_U1 ON HRM_LICENSE(PERSON_ID, LICENSE_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRM_LICENSE COMPUTE STATISTICS;
ANALYZE INDEX HRM_LICENSE_U1 COMPUTE STATISTICS;
