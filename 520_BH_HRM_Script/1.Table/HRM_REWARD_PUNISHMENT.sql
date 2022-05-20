/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_REWARD_PUNISHMENT
/* Description  : 상벌사항 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_REWARD_PUNISHMENT              
(REWARD_PUNISHMENT_ID                             NUMBER NOT NULL,
  PERSON_ID                                       NUMBER NOT NULL,
  RP_TYPE	                                        VARCHAR2(1) NOT NULL,
  RP_ID	                                          NUMBER NOT NULL,
  RP_DATE	                                        DATE,	
  RP_DESCRIPTION	                                VARCHAR2(100),
  RP_ORG	                                        VARCHAR2(100),
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
COMMENT ON COLUMN HRM_REWARD_PUNISHMENT.REWARD_PUNISHMENT_ID IS '상벌 ID';
COMMENT ON COLUMN HRM_REWARD_PUNISHMENT.PERSON_ID IS '사원번호';
COMMENT ON COLUMN HRM_REWARD_PUNISHMENT.RP_TYPE IS '상벌 구분';
COMMENT ON COLUMN HRM_REWARD_PUNISHMENT.RP_ID IS '상벌 ID';
COMMENT ON COLUMN HRM_REWARD_PUNISHMENT.RP_DATE IS '상벌일자';
COMMENT ON COLUMN HRM_REWARD_PUNISHMENT.RP_DESCRIPTION IS '상벌 사유';
COMMENT ON COLUMN HRM_REWARD_PUNISHMENT.RP_ORG IS '시행처';
COMMENT ON COLUMN HRM_REWARD_PUNISHMENT.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRM_REWARD_PUNISHMENT.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRM_REWARD_PUNISHMENT.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_REWARD_PUNISHMENT.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_REWARD_PUNISHMENT.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_REWARD_PUNISHMENT_U1 ON HRM_REWARD_PUNISHMENT(REWARD_PUNISHMENT_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRM_REWARD_PUNISHMENT_N1 ON HRM_REWARD_PUNISHMENT(PERSON_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRM_REWARD_PUNISHMENT_S1;
CREATE SEQUENCE HRM_REWARD_PUNISHMENT_S1;

-- ANALYZE.
ANALYZE TABLE HRM_REWARD_PUNISHMENT COMPUTE STATISTICS;
ANALYZE INDEX HRM_REWARD_PUNISHMENT_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_REWARD_PUNISHMENT_N1 COMPUTE STATISTICS;
