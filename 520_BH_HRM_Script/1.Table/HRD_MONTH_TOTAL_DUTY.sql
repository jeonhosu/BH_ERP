/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_MONTH_TOTAL_DUTY
/* Description  : ������ ���� ���� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_MONTH_TOTAL_DUTY              
( MONTH_TOTAL_ID                                NUMBER NOT NULL, 
  DUTY_ID                                       NUMBER NOT NULL,
  DUTY_COUNT                                    NUMBER DEFAULT 0,  
  NON_PAY_YN                                    VARCHAR2(1) DEFAULT 'N',
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
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.MONTH_TOTAL_ID IS '������ ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.DUTY_ID IS '����ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.DUTY_COUNT IS '���� �����';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.NON_PAY_YN IS '�ٿ����� Y/N';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.DESCRIPTION IS '���';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.DUTY_TYPE IS '���±���';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.DUTY_YYYYMM IS '���³��';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.CORP_ID IS '��üID';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_MONTH_TOTAL_DUTY.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_MONTH_TOTAL_DUTY_U1 ON HRD_MONTH_TOTAL_DUTY(MONTH_TOTAL_ID, DUTY_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_MONTH_TOTAL_DUTY_N1 ON HRD_MONTH_TOTAL_DUTY(PERSON_ID, DUTY_TYPE, DUTY_YYYYMM, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
--CREATE SEQUENCE HRD_MONTH_TOTAL_DUTY_S1;

-- ANALYZE.
ANALYZE TABLE HRD_MONTH_TOTAL_DUTY COMPUTE STATISTICS;
ANALYZE INDEX HRD_MONTH_TOTAL_DUTY_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_MONTH_TOTAL_DUTY_N1 COMPUTE STATISTICS;
