/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_DAY_INTERFACE
/* Description  : ����� ���� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_DAY_INTERFACE              
( PERSON_ID	                                      NUMBER NOT NULL,
  WORK_DATE	                                      DATE NOT NULL,
  WORK_CORP_ID                                    NUMBER NOT NULL,
	CORP_ID                                         NUMBER NOT NULL,
  DEPT_ID	                                        NUMBER,
  POST_ID	                                        NUMBER,
  JOB_CATEGORY_ID	                                NUMBER,
	WORK_TYPE_ID                                    NUMBER,
  DUTY_ID                                         NUMBER NOT NULL,
  HOLY_TYPE	                                      VARCHAR2(2) NOT NULL,
  OPEN_TIME	                                      DATE,
  CLOSE_TIME	                                    DATE,
  OPEN_TIME1	                                    DATE,
  CLOSE_TIME1	                                    DATE,
  NEXT_DAY_YN	                                    VARCHAR2(1) DEFAULT 'N',
  DANGJIK_YN                                      VARCHAR2(1) DEFAULT 'N',
  ALL_NIGHT_YN                                    VARCHAR2(1) DEFAULT 'N',
  LEAVE_ID	                                      NUMBER,
  LEAVE_TIME_CODE                                 VARCHAR2(10),
  MODIFY_YN	                                      VARCHAR2(1) DEFAULT 'N',
  MODIFY_IN_YN	                                  VARCHAR2(1) DEFAULT 'N',
  MODIFY_OUT_YN	                                  VARCHAR2(1) DEFAULT 'N',
  APPROVED_YN	                                    VARCHAR2(1) DEFAULT 'N',
  APPROVED_DATE	                                  DATE,
  APPROVED_PERSON_ID	                            NUMBER,
  APPROVED_IN_YN                                  VARCHAR2(1) DEFAULT 'N',
  APPROVED_IN_DATE	                              DATE,
  APPROVED_IN_PERSON_ID	                          NUMBER,
  CONFIRMED_YN	                                  VARCHAR2(1)  DEFAULT 'N',
  CONFIRMED_DATE	                                DATE,
  CONFIRMED_PERSON_ID	                            NUMBER,
	APPROVE_STATUS                                  VARCHAR2(1) DEFAULT 'N',
  EMAIL_STATUS                                    VARCHAR2(2) DEFAULT 'N',
  TRANS_YN	                                      VARCHAR2(1)  DEFAULT 'N',
  TRANS_DATE	                                    DATE,
  TRANS_PERSON_ID	                                NUMBER,
  DESCRIPTION                                     VARCHAR2(100),
  REJECT_REMARK                                   VARCHAR2(100),
  ATTRIBUTE1                                      VARCHAR2(100),
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
	SOB_ID                                          NUMBER NOT NULL,
	ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_DAY_INTERFACE.PERSON_ID IS '�����ȣ';
COMMENT ON COLUMN HRD_DAY_INTERFACE.WORK_DATE IS '�ٹ�����';
COMMENT ON COLUMN HRD_DAY_INTERFACE.WORK_CORP_ID IS '��üID';
COMMENT ON COLUMN HRD_DAY_INTERFACE.CORP_ID IS '��üID';
COMMENT ON COLUMN HRD_DAY_INTERFACE.DEPT_ID IS '�μ�ID';
COMMENT ON COLUMN HRD_DAY_INTERFACE.POST_ID IS '����ID';
COMMENT ON COLUMN HRD_DAY_INTERFACE.JOB_CATEGORY_ID IS '������ID';
COMMENT ON COLUMN HRD_DAY_INTERFACE.WORK_TYPE_ID IS '��������ID';
COMMENT ON COLUMN HRD_DAY_INTERFACE.DUTY_ID IS '����ID';
COMMENT ON COLUMN HRD_DAY_INTERFACE.HOLY_TYPE IS '�ٹ�Ÿ��';
COMMENT ON COLUMN HRD_DAY_INTERFACE.OPEN_TIME IS '����Ͻ�';
COMMENT ON COLUMN HRD_DAY_INTERFACE.CLOSE_TIME IS '����Ͻ�';
COMMENT ON COLUMN HRD_DAY_INTERFACE.OPEN_TIME1 IS '�����Ͻ�';
COMMENT ON COLUMN HRD_DAY_INTERFACE.CLOSE_TIME1 IS '�����Ͻ�';
COMMENT ON COLUMN HRD_DAY_INTERFACE.NEXT_DAY_YN IS '������� ����';
COMMENT ON COLUMN HRD_DAY_INTERFACE.DANGJIK_YN IS '���� �ٹ�';
COMMENT ON COLUMN HRD_DAY_INTERFACE.ALL_NIGHT_YN IS 'ö�� �ٹ�';
COMMENT ON COLUMN HRD_DAY_INTERFACE.LEAVE_ID IS '�������ID';
COMMENT ON COLUMN HRD_DAY_INTERFACE.LEAVE_TIME_CODE IS '����ð��ڵ�';
COMMENT ON COLUMN HRD_DAY_INTERFACE.MODIFY_YN IS '��������';
COMMENT ON COLUMN HRD_DAY_INTERFACE.MODIFY_IN_YN IS '��ٽð� ����';
COMMENT ON COLUMN HRD_DAY_INTERFACE.MODIFY_OUT_YN IS '��ٽð� ����';
COMMENT ON COLUMN HRD_DAY_INTERFACE.APPROVED_YN IS '���α���';
COMMENT ON COLUMN HRD_DAY_INTERFACE.APPROVED_DATE IS '�����Ͻ�';
COMMENT ON COLUMN HRD_DAY_INTERFACE.APPROVED_PERSON_ID IS '������';
COMMENT ON COLUMN HRD_DAY_INTERFACE.CONFIRMED_YN IS 'Ȯ�����α���';
COMMENT ON COLUMN HRD_DAY_INTERFACE.CONFIRMED_DATE IS 'Ȯ�������Ͻ�';
COMMENT ON COLUMN HRD_DAY_INTERFACE.CONFIRMED_PERSON_ID IS 'Ȯ��������';
COMMENT ON COLUMN HRD_DAY_INTERFACE.APPROVE_STATUS IS '���λ���';
COMMENT ON COLUMN HRD_DAY_INTERFACE.EMAIL_STATUS IS 'EMAIL �߼ۿ���(N-�̹߼�,AR/BR-�߼��غ�,AS/BS-�߼ۿϷ�)';
COMMENT ON COLUMN HRD_DAY_INTERFACE.TRANS_YN IS '��������';
COMMENT ON COLUMN HRD_DAY_INTERFACE.TRANS_DATE IS '�����Ͻ�';
COMMENT ON COLUMN HRD_DAY_INTERFACE.TRANS_PERSON_ID IS '����ó����';
COMMENT ON COLUMN HRD_DAY_INTERFACE.DESCRIPTION IS '���';
COMMENT ON COLUMN HRD_DAY_INTERFACE.REJECT_REMARK IS '�ݷ�����';
COMMENT ON COLUMN HRD_DAY_INTERFACE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_DAY_INTERFACE.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_DAY_INTERFACE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_DAY_INTERFACE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_DAY_INTERFACE_U1 ON HRD_DAY_INTERFACE(PERSON_ID, WORK_DATE, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_DAY_INTERFACE_N1 ON HRD_DAY_INTERFACE(PERSON_ID, WORK_DATE, WORK_CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_DAY_INTERFACE_N2 ON HRD_DAY_INTERFACE(PERSON_ID, WORK_DATE, WORK_CORP_ID, APPROVE_STATUS, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRD_DAY_INTERFACE COMPUTE STATISTICS;
ANALYZE INDEX HRD_DAY_INTERFACE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_DAY_INTERFACE_N1 COMPUTE STATISTICS;
