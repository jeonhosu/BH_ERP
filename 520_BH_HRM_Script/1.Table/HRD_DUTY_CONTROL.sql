/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_DUTY_CONTROL
/* Description  : 근태관리 관리 단위
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_DUTY_CONTROL              
( CORP_ID                                       NUMBER NOT NULL,
  DUTY_CONTROL_TYPE                             VARCHAR2(10) NOT NULL,
  DUTY_CONTROL_ID                               NUMBER NOT NULL,
  WORK_TYPE_ID                                  NUMBER DEFAULT 0,
  DESCRIPTION                                   VARCHAR2(100),
  ATTRIBUTE1                                    VARCHAR2(100),
  ATTRIBUTE2                                    VARCHAR2(100),
  ATTRIBUTE3                                    VARCHAR2(100),
  ATTRIBUTE4                                    VARCHAR2(100),
  ATTRIBUTE5                                    VARCHAR2(100),
	START_DATE                                    DATE NOT NULL,
	END_DATE                                      DATE,
	SOB_ID                                        NUMBER NOT NULL,
	ORG_ID                                        NUMBER NOT NULL,
  CREATION_DATE                                 DATE NOT NULL,
  CREATED_BY                                    NUMBER NOT NULL,
  LAST_UPDATE_DATE                              DATE NOT NULL,
  LAST_UPDATED_BY                               NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_DUTY_CONTROL.CORP_ID IS '시작년월';
COMMENT ON COLUMN HRD_DUTY_CONTROL.DUTY_CONTROL_TYPE IS '종료년월';
COMMENT ON COLUMN HRD_DUTY_CONTROL.DUTY_CONTROL_ID IS '급여코드';
COMMENT ON COLUMN HRD_DUTY_CONTROL.WORK_TYPE_ID IS '직급코드';
COMMENT ON COLUMN HRD_DUTY_CONTROL.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRD_DUTY_CONTROL.START_DATE IS '시작일자';
COMMENT ON COLUMN HRD_DUTY_CONTROL.END_DATE IS '종료일자';
COMMENT ON COLUMN HRD_DUTY_CONTROL.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_DUTY_CONTROL.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_DUTY_CONTROL.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_DUTY_CONTROL.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_DUTY_CONTROL_U1 ON HRD_DUTY_CONTROL(CORP_ID, DUTY_CONTROL_TYPE, DUTY_CONTROL_ID, WORK_TYPE_ID, START_DATE, END_DATE, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRD_DUTY_CONTROL COMPUTE STATISTICS;
ANALYZE INDEX HRD_DUTY_CONTROL_U1 COMPUTE STATISTICS;
