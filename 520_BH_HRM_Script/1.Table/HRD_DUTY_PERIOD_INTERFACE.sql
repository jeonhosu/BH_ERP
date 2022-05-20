/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_DUTY_PERIOD_INTERFACE
/* Description  : �������� ���� INTERFACE TABLE
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_DUTY_PERIOD_INTERFACE
( PERSON_NUM                                      VARCHAR2(20) NOT NULL,
  GW_DUTY_CODE                                    VARCHAR2(20) NOT NULL,
  START_DATE                                      DATE NOT NULL,  
  END_DATE                                        DATE NOT NULL,    
  CORP_ID                                         NUMBER NOT NULL,
  APPROVED_YN                                     CHAR(1) DEFAULT 'N',
  APPROVED_DATE                                   DATE, 
  APPROVED_PERSON_NUM                             VARCHAR2(20),
  CONFIRMED_YN                                    CHAR(1) DEFAULT 'N',
  CONFIRMED_DATE                                  DATE,
  CONFIRMED_PERSON_NUM                            VARCHAR2(20),
  APPROVE_STATUS                                  CHAR(1) DEFAULT 'A',
  TRAN_YN                                         CHAR(1) DEFAULT 'N',
  DESCRIPTION                                     VARCHAR2(100),
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
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRD_DUTY_PERIOD_INTERFACE IS '�������� �׷���� INTERFACE';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.PERSON_NUM IS '�����ȣ';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.GW_DUTY_CODE IS '�׷���� ���� CODE';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.START_DATE IS '��������';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.END_DATE IS '��������';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.APPROVED_YN IS '1�� ���α���';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.APPROVED_DATE IS '1�� �����Ͻ�';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.APPROVED_PERSON_NUM IS '1�� ������';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.CONFIRMED_YN IS 'Ȯ�����α���-���ν� �ٹ�ī���� �ݿ�';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.CONFIRMED_DATE IS 'Ȯ�������Ͻ�';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.CONFIRMED_PERSON_NUM IS 'Ȯ��������';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.APPROVE_STATUS IS '���� ����(A-�̽���,B-1������, C-Ȯ������)';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.TRAN_YN IS '�������� �ݿ� ����';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.DESCRIPTION IS '���(����)';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.ATTRIBUTE5 IS '�����ڵ�';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_DUTY_PERIOD_INTERFACE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_DUTY_PERIOD_INTERFACE_U1 ON HRD_DUTY_PERIOD_INTERFACE(PERSON_NUM, GW_DUTY_CODE, START_DATE, END_DATE, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRD_DUTY_PERIOD_INTERFACE COMPUTE STATISTICS;
ANALYZE INDEX HRD_DUTY_PERIOD_INTERFACE_U1 COMPUTE STATISTICS;
