/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_COMMON
/* Description  : 공통코드 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_COMMON			
( COMMON_ID                                     NUMBER NOT NULL,
  GROUP_CODE		                                VARCHAR2(70) NOT NULL,
  CODE			                                    VARCHAR2(70) NOT NULL,
  CODE_NAME		                                  VARCHAR2(150) NOT NULL,
  SYSTEM_FLAG		                                VARCHAR2(1), 
  CODE_LENGTH		                                NUMBER,
  VALUE1			                                  VARCHAR2(150),
  VALUE2			                                  VARCHAR2(150),
  VALUE3			                                  VARCHAR2(150), 
  VALUE4			                                  VARCHAR2(150),
  VALUE5			                                  VARCHAR2(150),
  VALUE6			                                  VARCHAR2(150),
  VALUE7			                                  VARCHAR2(150),
  VALUE8			                                  VARCHAR2(150),
  VALUE9			                                  VARCHAR2(150),
  VALUE10			                                  VARCHAR2(150),
	DEFAULT_FLAG                                  VARCHAR2(1) DEFAULT 'N',
  SORT_NUM                                      NUMBER DEFAULT 0,
  DESCRIPTION		                                VARCHAR2(100),
  ENABLED_FLAG                                  VARCHAR2(1) NOT NULL,
  EFFECTIVE_DATE_FR                             DATE NOT NULL,
  EFFECTIVE_DATE_TO                             DATE,
	SOB_ID                                        NUMBER NOT NULL,
	ORG_ID                                        NUMBER NOT NULL,
  CREATION_DATE		                              DATE NOT NULL,
  CREATED_BY		                                NUMBER NOT NULL,
  LAST_UPDATE_DATE	                            DATE NOT NULL,
  LAST_UPDATED_BY		                            NUMBER  NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_COMMON.COMMON_ID IS '공통코드 ID';
COMMENT ON COLUMN HRM_COMMON.GROUP_CODE IS '그룹핑 코드';
COMMENT ON COLUMN HRM_COMMON.CODE IS '공통코드';
COMMENT ON COLUMN HRM_COMMON.CODE_NAME IS '공통코드명';
COMMENT ON COLUMN HRM_COMMON.CODE_LENGTH IS '공통코드 길이';
COMMENT ON COLUMN HRM_COMMON.VALUE1 IS '적용 값-VALUE1~7';
COMMENT ON COLUMN HRM_COMMON.DEFAULT_FLAG IS '기본값';
COMMENT ON COLUMN HRM_COMMON.SORT_NUM IS '정렬순서';
COMMENT ON COLUMN HRM_COMMON.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRM_COMMON.ENABLED_FLAG IS '사용여부';
COMMENT ON COLUMN HRM_COMMON.EFFECTIVE_DATE_FR IS '적용 시작일자';
COMMENT ON COLUMN HRM_COMMON.EFFECTIVE_DATE_TO IS '적용 종료일자';
COMMENT ON COLUMN HRM_COMMON.CREATION_DATE	IS '생성일자';
COMMENT ON COLUMN HRM_COMMON.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_COMMON.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_COMMON.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_COMMON_U1 ON HRM_COMMON(GROUP_CODE, CODE, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRM_COMMON_U2 ON HRM_COMMON(COMMON_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRM_COMMON_N2 ON HRM_COMMON(ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRM_COMMON_S1;
CREATE SEQUENCE HRM_COMMON_S1;

-- ANALYZE.
ANALYZE TABLE HRM_COMMON COMPUTE STATISTICS;
ANALYZE INDEX HRM_COMMON_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_COMMON_U2 COMPUTE STATISTICS;


