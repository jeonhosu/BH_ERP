/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_DUTY_PERIOD
/* Description  : �������� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_DUTY_PERIOD              
( DUTY_PERIOD_ID                                  NUMBER NOT NULL,
  START_DATE	                                    DATE NOT NULL,	
  END_DATE	                                      DATE NOT NULL,
  PERSON_ID	                                      NUMBER NOT NULL,
	DUTY_ID	                                        NUMBER NOT NULL,
  CORP_ID                                         NUMBER NOT NULL,
	WORK_START_DATE	                                DATE, 
	REAL_START_DATE	                                DATE, 
	WORK_END_DATE	                                  DATE,
  REAL_END_DATE	                                  DATE,
  APPROVED_YN	                                    CHAR(1)     DEFAULT 'N',
  APPROVED_DATE	                                  DATE, 
  APPROVED_PERSON_ID                              NUMBER,
  CONFIRMED_YN	                                  CHAR(1)     DEFAULT 'N',
  CONFIRMED_DATE	                                DATE,
  CONFIRMED_PERSON_ID	                            NUMBER,
	APPROVE_STATUS                                  VARCHAR2(1) DEFAULT 'A',
	CALENDAR_TRAN_YN                                CHAR(1)     DEFAULT 'N',
  EMAIL_STATUS                                    VARCHAR(2)  DEFAULT 'N',
  DESCRIPTION                                     VARCHAR2(100),
  REJECT_YN	                                      CHAR(1)     DEFAULT 'N',
  REJECT_DATE	                                    DATE,
  REJECT_PERSON_ID	                              NUMBER,
  REJECT_REMARK                                   VARCHAR2(100),
  ATTRIBUTE1                                      VARCHAR2(100),
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
	SOB_ID                                          NUMBER,
	ORG_ID                                          NUMBER,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_DUTY_PERIOD.DUTY_PERIOD_ID IS '�Ϸù�ȣ';
COMMENT ON COLUMN HRD_DUTY_PERIOD.PERSON_ID IS '�����ȣ';
COMMENT ON COLUMN HRD_DUTY_PERIOD.START_DATE IS '��������';
COMMENT ON COLUMN HRD_DUTY_PERIOD.END_DATE IS '��������';
COMMENT ON COLUMN HRD_DUTY_PERIOD.DUTY_ID IS '���� ID';
COMMENT ON COLUMN HRD_DUTY_PERIOD.WORK_START_DATE IS '�ش� �ٹ� ���۽ð�';
COMMENT ON COLUMN HRD_DUTY_PERIOD.REAL_START_DATE IS '���� �ٹ� ���۽ð�';
COMMENT ON COLUMN HRD_DUTY_PERIOD.WORK_END_DATE IS '�ش� �ٹ� ����ð�';
COMMENT ON COLUMN HRD_DUTY_PERIOD.REAL_END_DATE IS '���� �ٹ� ����ð�';
COMMENT ON COLUMN HRD_DUTY_PERIOD.APPROVED_YN IS '1�� ���α���';
COMMENT ON COLUMN HRD_DUTY_PERIOD.APPROVED_DATE IS '1�� �����Ͻ�';
COMMENT ON COLUMN HRD_DUTY_PERIOD.APPROVED_PERSON_ID IS '1�� ������';
COMMENT ON COLUMN HRD_DUTY_PERIOD.CONFIRMED_YN IS 'Ȯ�����α���-���ν� �ٹ�ī���� �ݿ�';
COMMENT ON COLUMN HRD_DUTY_PERIOD.CONFIRMED_DATE IS 'Ȯ�������Ͻ�';
COMMENT ON COLUMN HRD_DUTY_PERIOD.CONFIRMED_PERSON_ID IS 'Ȯ��������';
COMMENT ON COLUMN HRD_DUTY_PERIOD.APPROVE_STATUS IS '���� ����(A-�̽���,B-1������, C-Ȯ������)';
COMMENT ON COLUMN HRD_DUTY_PERIOD.CALENDAR_TRAN_YN IS 'ī���� �ݿ� ����';
COMMENT ON COLUMN HRD_DUTY_PERIOD.EMAIL_STATUS IS 'EMAIL �߼� ����(N-�̹߼�, AR/BR-�߼��غ�, AS/BS-�߼�)';
COMMENT ON COLUMN HRD_DUTY_PERIOD.DESCRIPTION IS '���(����)';
COMMENT ON COLUMN HRD_DUTY_PERIOD.REJECT_YN IS '�ݷ�����';
COMMENT ON COLUMN HRD_DUTY_PERIOD.REJECT_DATE IS '�ݷ������Ͻ�';
COMMENT ON COLUMN HRD_DUTY_PERIOD.REJECT_PERSON_ID IS '�ݷ�������';
COMMENT ON COLUMN HRD_DUTY_PERIOD.REJECT_REMARK IS '�ݷ�����';
COMMENT ON COLUMN HRD_DUTY_PERIOD.ATTRIBUTE5 IS '�����ڵ�';
COMMENT ON COLUMN HRD_DUTY_PERIOD.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_DUTY_PERIOD.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_DUTY_PERIOD.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_DUTY_PERIOD.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_DUTY_PERIOD_U1 ON HRD_DUTY_PERIOD(DUTY_PERIOD_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRD_DUTY_PERIOD_U2 ON HRD_DUTY_PERIOD(START_DATE, END_DATE, PERSON_ID, DUTY_ID, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_DUTY_PERIOD_N1 ON HRD_DUTY_PERIOD(APPROVE_STATUS, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_DUTY_PERIOD_N2 ON HRD_DUTY_PERIOD(TRUNC(WORK_START_DATE), TRUNC(WORK_END_DATE), CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_DUTY_PERIOD_N3 ON HRD_DUTY_PERIOD(EMAIL_STATUS, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;


-- SEQUENCE;
DROP SEQUENCE HRD_DUTY_PERIOD_S1;
CREATE SEQUENCE HRD_DUTY_PERIOD_S1;

-- ANALYZE.
ANALYZE TABLE HRD_DUTY_PERIOD COMPUTE STATISTICS;
ANALYZE INDEX HRD_DUTY_PERIOD_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_DUTY_PERIOD_U2 COMPUTE STATISTICS;
ANALYZE INDEX HRD_DUTY_PERIOD_N1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_DUTY_PERIOD_N2 COMPUTE STATISTICS;
ANALYZE INDEX HRD_DUTY_PERIOD_N3 COMPUTE STATISTICS;
