/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_DUTY_MANAGER
/* Description  : ���� ����� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_DUTY_MANAGER              
( DUTY_MANAGER_ID                                   NUMBER NOT NULL,
  CORP_ID                                           NUMBER NOT NULL,
  DUTY_CONTROL_ID	                                  NUMBER NOT NULL,
  WORK_TYPE_ID                                      NUMBER DEFAULT 0,
  MANAGER_ID1	                                      NUMBER NOT NULL,
  MANAGER_ID2	                                      NUMBER,
  APPROVER_ID1	                                    NUMBER NOT NULL,
  APPROVER_ID2	                                    NUMBER,
  OT_YN	                                            VARCHAR2(1) DEFAULT 'N',
  DUTY_YN	                                          VARCHAR2(1) DEFAULT 'N',
  INOUT_YN	                                        VARCHAR2(1) DEFAULT 'N',
  LUNCH_YN	                                        VARCHAR2(1) DEFAULT 'N',
  DINNER_YN	                                        VARCHAR2(1) DEFAULT 'N',
  MIDNIGHT_YN	                                      VARCHAR2(1) DEFAULT 'N',
	DESCRIPTION                                       VARCHAR2(100),
  ATTRIBUTE1                                        VARCHAR2(100),
  ATTRIBUTE2                                        VARCHAR2(100),
  ATTRIBUTE3                                        VARCHAR2(100),
  ATTRIBUTE4                                        VARCHAR2(100),
  ATTRIBUTE5                                        VARCHAR2(100),
  ENABLED_FLAG                                      VARCHAR2(1) DEFAULT 'N',
  EFFECTIVE_DATE_FR                                 DATE NOT NULL,
  EFFECTIVE_DATE_TO                                 DATE NOT NULL,
	SOB_ID                                            NUMBER NOT NULL,
	ORG_ID                                            NUMBER NOT NULL,
  CREATION_DATE                                     DATE NOT NULL,
  CREATED_BY                                        NUMBER NOT NULL,
  LAST_UPDATE_DATE                                  DATE NOT NULL,
  LAST_UPDATED_BY                                   NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_DUTY_MANAGER.DUTY_MANAGER_ID IS '���°��� ID';
COMMENT ON COLUMN HRD_DUTY_MANAGER.CORP_ID IS '��üID';
COMMENT ON COLUMN HRD_DUTY_MANAGER.DUTY_CONTROL_ID IS '���� �������� ID ';
COMMENT ON COLUMN HRD_DUTY_MANAGER.MANAGER_ID1 IS '�����1';
COMMENT ON COLUMN HRD_DUTY_MANAGER.MANAGER_ID2 IS '�����2';
COMMENT ON COLUMN HRD_DUTY_MANAGER.APPROVER_ID1 IS '������1';
COMMENT ON COLUMN HRD_DUTY_MANAGER.APPROVER_ID2 IS '������2';
COMMENT ON COLUMN HRD_DUTY_MANAGER.OT_YN IS '�����û ���� ����';
COMMENT ON COLUMN HRD_DUTY_MANAGER.DUTY_YN IS '��������(�ް�)��û ���ɿ���';
COMMENT ON COLUMN HRD_DUTY_MANAGER.INOUT_YN IS '����� ���� ���ɿ���';
COMMENT ON COLUMN HRD_DUTY_MANAGER.LUNCH_YN IS '�߽Ŀ��� ��û ���ɿ���';
COMMENT ON COLUMN HRD_DUTY_MANAGER.DINNER_YN IS '���Ŀ��� ��û ���ɿ���';
COMMENT ON COLUMN HRD_DUTY_MANAGER.MIDNIGHT_YN IS '�߽Ŀ��� ��û ���ɿ���';
COMMENT ON COLUMN HRD_DUTY_MANAGER.DESCRIPTION IS '���';
COMMENT ON COLUMN HRD_DUTY_MANAGER.ENABLED_FLAG IS '��뿩��';
COMMENT ON COLUMN HRD_DUTY_MANAGER.EFFECTIVE_DATE_FR IS '���� ��������';
COMMENT ON COLUMN HRD_DUTY_MANAGER.EFFECTIVE_DATE_TO IS '���� ��������';
COMMENT ON COLUMN HRD_DUTY_MANAGER.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_DUTY_MANAGER.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_DUTY_MANAGER.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_DUTY_MANAGER.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_DUTY_MANAGER_U1 ON HRD_DUTY_MANAGER(DUTY_MANAGER_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRD_DUTY_MANAGER_U2 ON HRD_DUTY_MANAGER(CORP_ID, DUTY_CONTROL_ID, WORK_TYPE_ID, MANAGER_ID1, APPROVER_ID1, START_DATE, END_DATE, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_DUTY_MANAGER_N1 ON HRD_DUTY_MANAGER(MANAGER_ID1, APPROVER_ID1, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRD_DUTY_MANAGER_S1;
CREATE SEQUENCE HRD_DUTY_MANAGER_S1;

-- ANALYZE.
ANALYZE TABLE HRD_DUTY_MANAGER COMPUTE STATISTICS;
ANALYZE INDEX HRD_DUTY_MANAGER_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_DUTY_MANAGER_U2 COMPUTE STATISTICS;
ANALYZE INDEX HRD_DUTY_MANAGER_N1 COMPUTE STATISTICS;
