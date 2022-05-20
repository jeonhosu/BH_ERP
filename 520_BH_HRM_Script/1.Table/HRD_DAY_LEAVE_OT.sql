/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_DAY_LEAVE_OT
/* Description  : 일근태 잔업 집계 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_DAY_LEAVE_OT              
( DAY_LEAVE_ID                                  NUMBER NOT NULL, 
  OT_TYPE                                       VARCHAR2(10) NOT NULL,
  OT_TIME                                       NUMBER DEFAULT 0,  
  DESCRIPTION                                   VARCHAR2(100),
  ATTRIBUTE1                                    VARCHAR2(100),
  ATTRIBUTE2                                    VARCHAR2(100),
  ATTRIBUTE3                                    VARCHAR2(100),
  ATTRIBUTE4                                    VARCHAR2(100),
  ATTRIBUTE5                                    VARCHAR2(100),
  PERSON_ID                                     NUMBER NOT NULL,
  WORK_DATE                                     DATE NOT NULL,
  CORP_ID                                       NUMBER NOT NULL,  
  SOB_ID                                        NUMBER NOT NULL,
  ORG_ID                                        NUMBER NOT NULL,
  CREATION_DATE                                 DATE NOT NULL,
  CREATED_BY                                    NUMBER NOT NULL,
  LAST_UPDATE_DATE                              DATE NOT NULL,
  LAST_UPDATED_BY                               NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.DAY_LEAVE_ID IS '일근태 ID';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.OT_TYPE IS '잔업 타입';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.OT_TIME IS '잔업 시간';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.WORK_DATE IS '근무일자';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_DAY_LEAVE_OT.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_DAY_LEAVE_OT_U1 ON HRD_DAY_LEAVE_OT(DAY_LEAVE_ID, OT_TYPE) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_DAY_LEAVE_OT_N1 ON HRD_DAY_LEAVE_OT(PERSON_ID, CORP_ID, WORK_DATE, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
/*DROP SEQUENCE HRD_DAY_LEAVE_OT_S1;
CREATE SEQUENCE HRD_DAY_LEAVE_OT_S1;*/

-- ANALYZE.
ANALYZE TABLE HRD_DAY_LEAVE_OT COMPUTE STATISTICS;
ANALYZE INDEX HRD_DAY_LEAVE_OT_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_DAY_LEAVE_OT_N1 COMPUTE STATISTICS;
