/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_DEPT_MASTER
/* Description  : 부서마스터 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_DEPT_MASTER							
( DEPT_ID                                         NUMBER NOT NULL,
  CORP_ID		                                      NUMBER NOT NULL,
  DEPT_CODE		                                    VARCHAR2(30) NOT NULL,
  DEPT_NAME		                                    VARCHAR2(100), 
  DEPT_NAME_S		                                  VARCHAR2(100),
  DEPT_LEVEL		                                  NUMBER NOT NULL, 
  UPPER_DEPT_ID	                                  NUMBER,  
  DEPT_SORT_NUM		                                NUMBER DEFAULT 0,
  T_O			                                        NUMBER,
  DEPT_GROUP		                                  VARCHAR2(30),
  VALUER_1		                                    NUMBER,
  VALUER_2		                                    NUMBER,
  DESCRIPTION                                     VARCHAR2(100), 
  ATTRIBUTE1		                                  VARCHAR2(100),					
  ATTRIBUTE2		                                  VARCHAR2(100),
  ATTRIBUTE3		                                  VARCHAR2(100),
  ATTRIBUTE4		                                  VARCHAR2(100),
  ATTRIBUTE5		                                  VARCHAR2(100),
  USABLE		                                      VARCHAR2(1),
  START_DATE		                                  DATE NOT NULL,
  END_DATE		                                    DATE,
  SOB_ID                                          NUMBER NOT NULL,
  ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE		                                DATE NOT NULL,
  CREATED_BY		                                  NUMBER NOT NULL,
  LAST_UPDATE_DATE	                              DATE NOT NULL,
  LAST_UPDATED_BY	                                NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_DEPT_MASTER.DEPT_ID IS '부서 ID';
COMMENT ON COLUMN HRM_DEPT_MASTER.CORP_ID IS '업체 ID';
COMMENT ON COLUMN HRM_DEPT_MASTER.DEPT_CODE IS '부서코드';
COMMENT ON COLUMN HRM_DEPT_MASTER.DEPT_NAME IS '부서명';
COMMENT ON COLUMN HRM_DEPT_MASTER.DEPT_NAME_S IS '약칭 부서명';
COMMENT ON COLUMN HRM_DEPT_MASTER.DEPT_LEVEL IS '부서코드 LEVEL';
COMMENT ON COLUMN HRM_DEPT_MASTER.UPPER_DEPT_ID IS '상위 부서ID';
COMMENT ON COLUMN HRM_DEPT_MASTER.DEPT_SORT_NUM IS '정렬순서';
COMMENT ON COLUMN HRM_DEPT_MASTER.T_O IS '부서 TO';
COMMENT ON COLUMN HRM_DEPT_MASTER.DEPT_GROUP IS '부서 그룹단위';
COMMENT ON COLUMN HRM_DEPT_MASTER.VALUER_1 IS '1차 평가자';
COMMENT ON COLUMN HRM_DEPT_MASTER.VALUER_2 IS '2차 평가자';
COMMENT ON COLUMN HRM_DEPT_MASTER.USABLE IS '사용 여부';
COMMENT ON COLUMN HRM_DEPT_MASTER.START_DATE IS '시작일자';
COMMENT ON COLUMN HRM_DEPT_MASTER.END_DATE IS '종료일자';
COMMENT ON COLUMN HRM_DEPT_MASTER.USABLE IS '사용 FLAG';
COMMENT ON COLUMN HRM_DEPT_MASTER.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRM_DEPT_MASTER.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_DEPT_MASTER.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_DEPT_MASTER.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_DEPT_MASTER_U1 ON HRM_DEPT_MASTER(DEPT_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRM_DEPT_MASTER_U2 ON HRM_DEPT_MASTER(CORP_ID, DEPT_CODE, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;


-- SEQUENCE.
DROP SEQUENCE HRM_DEPT_MASTER_S1;
CREATE SEQUENCE HRM_DEPT_MASTER_S1;

-- ANALYZE.
ANALYZE TABLE HRM_DEPT_MASTER COMPUTE STATISTICS;
ANALYZE INDEX HRM_DEPT_MASTER_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_DEPT_MASTER_U2 COMPUTE STATISTICS;

