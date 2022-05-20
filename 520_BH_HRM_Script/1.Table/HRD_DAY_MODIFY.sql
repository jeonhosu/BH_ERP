/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_DAY_MODIFY
/* Description  : 출퇴근 수정 시간 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_DAY_MODIFY              
( PERSON_ID                                       NUMBER NOT NULL,
  WORK_DATE                                       DATE NOT NULL,  
  IO_FLAG	                                        VARCHAR2(1) NOT NULL,
  MODIFY_TIME	                                    DATE,
  MODIFY_TIME1	                                  DATE,	
  MODIFY_ID	                                      NUMBER NOT NULL,
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
COMMENT ON COLUMN HRD_DAY_MODIFY.PERSON_ID IS '사원번호';
COMMENT ON COLUMN HRD_DAY_MODIFY.WORK_DATE IS '근무일자';
COMMENT ON COLUMN HRD_DAY_MODIFY.IO_FLAG IS '출퇴구분';
COMMENT ON COLUMN HRD_DAY_MODIFY.MODIFY_TIME IS '수정시간1';
COMMENT ON COLUMN HRD_DAY_MODIFY.MODIFY_TIME1 IS '수정시간2';
COMMENT ON COLUMN HRD_DAY_MODIFY.MODIFY_ID IS '수정사유ID';
COMMENT ON COLUMN HRD_DAY_MODIFY.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRD_DAY_MODIFY.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_DAY_MODIFY.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_DAY_MODIFY.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_DAY_MODIFY.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_DAY_MODIFY_U1 ON HRD_DAY_MODIFY(PERSON_ID, WORK_DATE, IO_FLAG) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRD_DAY_MODIFY COMPUTE STATISTICS;
ANALYZE INDEX HRD_DAY_MODIFY_U1 COMPUTE STATISTICS;
