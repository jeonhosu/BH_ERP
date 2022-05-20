/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_RESULT
/* Description  : 평가 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_RESULT              
(PERSON_ID                                     NUMBER NOT NULL,
  RESULT_YYYY	                               VARCHAR2(4) NOT NULL,
  RESULT_SEQ	                                NUMBER NOT NULL,	
  RES_1	                                           VARCHAR2(50),
  RES_2	                                           VARCHAR2(50),
  RES_3	                                           VARCHAR2(50),
  RES_4	                                           VARCHAR2(50),
  RES_5	                                           VARCHAR2(50),
  RES_6	                                           VARCHAR2(50),
  RES_7	                                           VARCHAR2(50),
  RES_8	                                           VARCHAR2(50),
  RES_9	                                           VARCHAR2(50),
  RES_10	                                         VARCHAR2(50),
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
COMMENT ON COLUMN HRM_RESULT.PERSON_ID IS '사원번호';
COMMENT ON COLUMN HRM_RESULT.RESULT_YYYY IS '평가년도';
COMMENT ON COLUMN HRM_RESULT.RESULT_SEQ IS '평가 일련번호';
COMMENT ON COLUMN HRM_RESULT.RES_1 IS '평가1';
COMMENT ON COLUMN HRM_RESULT.RES_2 IS '평가2';
COMMENT ON COLUMN HRM_RESULT.RES_3 IS '평가3';
COMMENT ON COLUMN HRM_RESULT.RES_4 IS '평가4';
COMMENT ON COLUMN HRM_RESULT.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRM_RESULT.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRM_RESULT.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_RESULT.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_RESULT.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_RESULT_U1 ON HRM_RESULT(PERSON_ID, RESULT_YYYY, RESULT_SEQ) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRM_RESULT COMPUTE STATISTICS;
ANALYZE INDEX HRM_RESULT_U1 COMPUTE STATISTICS;
