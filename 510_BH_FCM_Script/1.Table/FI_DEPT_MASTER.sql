/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_DEPT_MASTER
/* Description  : 부서마스터 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_DEPT_MASTER              
( DEPT_ID                                         NUMBER NOT NULL,
  SOB_ID                                          NUMBER NOT NULL,
  DEPT_CODE                                       VARCHAR2(30) NOT NULL,
  DEPT_NAME                                       VARCHAR2(100), 
  DEPT_NAME_S                                     VARCHAR2(100),
  DEPT_LEVEL                                      NUMBER NOT NULL, 
  UPPER_DEPT_ID                                   NUMBER,  
  SORT_NUM                                        NUMBER DEFAULT 0,
  DEPT_GROUP                                      VARCHAR2(30),
  DESCRIPTION                                     VARCHAR2(100), 
  ATTRIBUTE1                                      VARCHAR2(100),          
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
  ENABLED_FLAG                                    CHAR(1),
  EFFECTIVE_DATE_FR                               DATE NOT NULL,
  EFFECTIVE_DATE_TO                               DATE,
  CREATION_DATE                                    DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                  NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE FI_DEPT_MASTER IS '회계 부서MASTER';
COMMENT ON COLUMN FI_DEPT_MASTER.DEPT_ID IS '부서 ID';
COMMENT ON COLUMN FI_DEPT_MASTER.SOB_ID IS '회사 ID';
COMMENT ON COLUMN FI_DEPT_MASTER.DEPT_CODE IS '부서코드';
COMMENT ON COLUMN FI_DEPT_MASTER.DEPT_NAME IS '부서명';
COMMENT ON COLUMN FI_DEPT_MASTER.DEPT_NAME_S IS '약칭 부서명';
COMMENT ON COLUMN FI_DEPT_MASTER.DEPT_LEVEL IS '부서코드 LEVEL';
COMMENT ON COLUMN FI_DEPT_MASTER.UPPER_DEPT_ID IS '상위 부서ID';
COMMENT ON COLUMN FI_DEPT_MASTER.SORT_NUM IS '정렬순서';
COMMENT ON COLUMN FI_DEPT_MASTER.DEPT_GROUP IS '부서 그룹단위';
COMMENT ON COLUMN FI_DEPT_MASTER.ENABLED_FLAG IS '사용 여부';
COMMENT ON COLUMN FI_DEPT_MASTER.EFFECTIVE_DATE_FR IS '시작일자';
COMMENT ON COLUMN FI_DEPT_MASTER.EFFECTIVE_DATE_TO IS '종료일자';
COMMENT ON COLUMN FI_DEPT_MASTER.USABLE IS '사용 FLAG';
COMMENT ON COLUMN FI_DEPT_MASTER.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN FI_DEPT_MASTER.CREATED_BY IS '생성자';
COMMENT ON COLUMN FI_DEPT_MASTER.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN FI_DEPT_MASTER.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX FI_DEPT_MASTER_U1 ON FI_DEPT_MASTER(DEPT_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX FI_DEPT_MASTER_U2 ON FI_DEPT_MASTER(SOB_ID, DEPT_CODE) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_DEPT_MASTER_N1 ON FI_DEPT_MASTER(UPPER_DEPT_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE FI_DEPT_MASTER_S1;
CREATE SEQUENCE FI_DEPT_MASTER_S1;

-- ANALYZE.
ANALYZE TABLE FI_DEPT_MASTER COMPUTE STATISTICS;
ANALYZE INDEX FI_DEPT_MASTER_U1 COMPUTE STATISTICS;
ANALYZE INDEX FI_DEPT_MASTER_U2 COMPUTE STATISTICS;
ANALYZE INDEX FI_DEPT_MASTER_N1 COMPUTE STATISTICS;
