/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_ARMY
/* Description  : 병역사항 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_ARMY              
(PERSON_ID                                      NUMBER NOT NULL,
  ARMY_KIND_ID	                               NUMBER,
  ARMY_STATUS_ID	                          NUMBER,
  ARMY_GRADE_ID	                            NUMBER,
  ARMY_START_DATE	                        DATE,	
  ARMY_END_DATE	                            DATE,	
  ARMY_END_TYPE_ID                        NUMBER,
  ARMY_EXCEPTION_DESC	               VARCHAR2(100),
  EXCEPTION_ID	                              NUMBER,
  EXCEPTION_OK_DATE	                    DATE,	
  EXCEPTION_FINISH_DATE	               DATE,	
  EXCEPTION_LICENSE_ID	                NUMBER,
  EXCEPTION_GRADE_ID	                  NUMBER,
  EXCEPTION_START_DATE	             DATE,
  EXCEPTION_END_DATE	                DATE,	
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
COMMENT ON COLUMN HRM_ARMY.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRM_ARMY.ARMY_KIND_ID IS '군별(육군,해군,공군...)';
COMMENT ON COLUMN HRM_ARMY.ARMY_STATUS_ID IS '역종(현역,예비역,민방위...)';
COMMENT ON COLUMN HRM_ARMY.ARMY_GRADE_ID IS '계급(이병, 일병...)';
COMMENT ON COLUMN HRM_ARMY.ARMY_START_DATE IS '입대일자';
COMMENT ON COLUMN HRM_ARMY.ARMY_END_DATE IS '전역일자';
COMMENT ON COLUMN HRM_ARMY.ARMY_END_TYPE_ID IS '전역사유';
COMMENT ON COLUMN HRM_ARMY.ARMY_EXCEPTION_DESC IS '면제사유';
COMMENT ON COLUMN HRM_ARMY.EXCEPTION_ID IS '특례구분';
COMMENT ON COLUMN HRM_ARMY.EXCEPTION_OK_DATE IS '특례처분일자';
COMMENT ON COLUMN HRM_ARMY.EXCEPTION_FINISH_DATE IS '특례만료일자';
COMMENT ON COLUMN HRM_ARMY.EXCEPTION_LICENSE_ID IS '특례라이센스';
COMMENT ON COLUMN HRM_ARMY.EXCEPTION_GRADE_ID IS '특례등급';
COMMENT ON COLUMN HRM_ARMY.EXCEPTION_START_DATE IS '특례군사훈련시작일자';
COMMENT ON COLUMN HRM_ARMY.EXCEPTION_END_DATE IS '특례군사훈련종료일자';
COMMENT ON COLUMN HRM_ARMY.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRM_ARMY.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRM_ARMY.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_ARMY.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_ARMY.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_ARMY_U1 ON HRM_ARMY(PERSON_ID, ARMY_KIND_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRM_ARMY COMPUTE STATISTICS;
ANALYZE INDEX HRM_ARMY_U1 COMPUTE STATISTICS;
