/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_MONTH_TOTAL_OT
/* Description  : 월근태 잔업 집계 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_MONTH_TOTAL_OT              
( MONTH_TOTAL_ID                                NUMBER NOT NULL, 
  OT_TYPE                                       VARCHAR2(10) NOT NULL,
  OT_TIME                                       NUMBER DEFAULT 0,  
  DESCRIPTION                                   VARCHAR2(100),
  ATTRIBUTE1                                    VARCHAR2(100),
  ATTRIBUTE2                                    VARCHAR2(100),
  ATTRIBUTE3                                    VARCHAR2(100),
  ATTRIBUTE4                                    VARCHAR2(100),
  ATTRIBUTE5                                    VARCHAR2(100),
  PERSON_ID                                     NUMBER NOT NULL,
  DUTY_TYPE                                     VARCHAR2(2) NOT NULL,
  DUTY_YYYYMM                                   VARCHAR2(7) NOT NULL,
  WORK_CORP_ID                                  NUMBER NOT NULL,
  CORP_ID                                       NUMBER NOT NULL,  
  SOB_ID                                        NUMBER NOT NULL,
  ORG_ID                                        NUMBER NOT NULL,
  CREATION_DATE                                 DATE NOT NULL,
  CREATED_BY                                    NUMBER NOT NULL,
  LAST_UPDATE_DATE                              DATE NOT NULL,
  LAST_UPDATED_BY                               NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.MONTH_TOTAL_ID IS '월근태 ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.OT_TYPE IS '잔업 타입';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.OT_TIME IS '잔업 시간';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.DUTY_TYPE IS '근태구분';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.DUTY_YYYYMM IS '근태년월';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_MONTH_TOTAL_OT.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_MONTH_TOTAL_OT_U1 ON HRD_MONTH_TOTAL_OT(MONTH_TOTAL_ID, OT_TYPE) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_MONTH_TOTAL_OT_N1 ON HRD_MONTH_TOTAL_OT(PERSON_ID, DUTY_TYPE, DUTY_YYYYMM, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE HRD_MONTH_TOTAL_OT_S1;

-- ANALYZE.
ANALYZE TABLE HRD_MONTH_TOTAL_OT COMPUTE STATISTICS;
ANALYZE INDEX HRD_MONTH_TOTAL_OT_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_MONTH_TOTAL_OT_N1 COMPUTE STATISTICS;
