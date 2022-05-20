/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_OT_HEADER
/* Description  : ����ٹ���û ��� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_OT_HEADER              
( OT_HEADER_ID                        NUMBER        NOT NULL,
  REQ_NUM	                            VARCHAR2(10)  NOT NULL,
  REQ_TYPE	                          VARCHAR2(2)   NOT NULL,
  REQ_DATE	                          DATE          NOT NULL,	
  CORP_ID                             NUMBER        NOT NULL,
	REQ_MONTH	                          VARCHAR2(6)   ,
  REQ_SEQ	                            NUMBER        ,
	DUTY_MANAGER_ID                     NUMBER        NOT NULL, 
  REQ_PERSON_ID                       NUMBER        NOT NULL,
  APPROVED_YN	                        CHAR(1)       DEFAULT 'N',
  APPROVED_DATE	                      DATE          ,
  APPROVED_PERSON_ID                  NUMBER        ,
  CONFIRMED_YN	                      CHAR(1)       DEFAULT 'N',
  CONFIRMED_DATE	                    DATE          ,
  CONFIRMED_PERSON_ID	                NUMBER        ,
	APPROVE_STATUS                      VARCHAR2(2)   DEFAULT 'N',
  EMAIL_STATUS                        VARCHAR2(2)   DEFAULT 'N',
	CALENDAR_TRAN_YN                    CHAR(1)       DEFAULT 'N',
  DESCRIPTION                         VARCHAR2(100) ,
  REJECT_YN	                          CHAR(1)       DEFAULT 'N',
  REJECT_DATE	                        DATE          ,
  REJECT_PERSON_ID	                  NUMBER        ,
  REJECT_REMARK                       VARCHAR2(200),
  ATTRIBUTE1                          VARCHAR2(100),
  ATTRIBUTE2                          VARCHAR2(100),
  ATTRIBUTE3                          VARCHAR2(100),
  ATTRIBUTE4                          VARCHAR2(100),
  ATTRIBUTE5                          VARCHAR2(100),
	SOB_ID                              NUMBER NOT NULL,
	ORG_ID                              NUMBER NOT NULL,
  CREATION_DATE                       DATE NOT NULL,
  CREATED_BY                          NUMBER NOT NULL,
  LAST_UPDATE_DATE                    DATE NOT NULL,
  LAST_UPDATED_BY                     NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_OT_HEADER.OT_HEADER_ID IS '��û HEADER ID';
COMMENT ON COLUMN HRD_OT_HEADER.REQ_NUM IS '��û��ȣ(���-XXX)';
COMMENT ON COLUMN HRD_OT_HEADER.REQ_TYPE IS '��û����(1-����, 2-�߰�)';
COMMENT ON COLUMN HRD_OT_HEADER.REQ_DATE IS '��û����';
COMMENT ON COLUMN HRD_OT_HEADER.CORP_ID IS '��üID';
COMMENT ON COLUMN HRD_OT_HEADER.REQ_MONTH IS '��û���(��û��ȣ ��������)';
COMMENT ON COLUMN HRD_OT_HEADER.REQ_SEQ IS '��û����(��û��ȣ ��������)';
COMMENT ON COLUMN HRD_OT_HEADER.DUTY_MANAGER_ID IS '���� ���� ���� ID';
COMMENT ON COLUMN HRD_OT_HEADER.REQ_PERSON_ID IS '��û��';
COMMENT ON COLUMN HRD_OT_HEADER.APPROVED_YN IS '�������α���';
COMMENT ON COLUMN HRD_OT_HEADER.APPROVED_DATE IS '���� �����Ͻ�';
COMMENT ON COLUMN HRD_OT_HEADER.APPROVED_PERSON_ID IS '���� ������';
COMMENT ON COLUMN HRD_OT_HEADER.CONFIRMED_YN IS 'Ȯ�����α���-���ν� �ٹ�ī���� �ݿ�';
COMMENT ON COLUMN HRD_OT_HEADER.CONFIRMED_DATE IS 'Ȯ�������Ͻ�';
COMMENT ON COLUMN HRD_OT_HEADER.CONFIRMED_PERSON_ID IS 'Ȯ��������';
COMMENT ON COLUMN HRD_OT_HEADER.APPROVE_STATUS IS '���λ���(N-���ι̿�û,A-�̽���,B-��������,C-Ȯ������,R-�ݷ�)';
COMMENT ON COLUMN HRD_OT_HEADER.EMAIL_STATUS IS 'EMAIL �߼ۿ���(N-�̹߼�,AR/BR-�߼��غ�,AS/BS-�߼ۿϷ�)';
COMMENT ON COLUMN HRD_OT_HEADER.CALENDAR_TRAN_YN IS '�ٹ�ī���� ���� ����';
COMMENT ON COLUMN HRD_OT_HEADER.DESCRIPTION IS '���';
COMMENT ON COLUMN HRD_OT_HEADER.REJECT_YN IS '�ݷ� ����';
COMMENT ON COLUMN HRD_OT_HEADER.REJECT_DATE IS '�ݷ� �Ͻ�';
COMMENT ON COLUMN HRD_OT_HEADER.REJECT_PERSON_ID IS '�ݷ� ó����'
COMMENT ON COLUMN HRD_OT_HEADER.REJECT_REMARK IS '�ݷ�����';
COMMENT ON COLUMN HRD_OT_HEADER.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_OT_HEADER.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_OT_HEADER.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_OT_HEADER.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_OT_HEADER_U1 ON HRD_OT_HEADER(OT_HEADER_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRD_OT_HEADER_U2 ON HRD_OT_HEADER(REQ_NUM) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRD_OT_HEADER_U3 ON HRD_OT_HEADER(CORP_ID, REQ_MONTH, REQ_SEQ, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_OT_HEADER_N1 ON HRD_OT_HEADER(REQ_MONTH) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_OT_HEADER_N2 ON HRD_OT_HEADER(OT_HEADER_ID, APPROVE_STATUS, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRD_OT_HEADER_S1; 
CREATE SEQUENCE HRD_OT_HEADER_S1;

-- ANALYZE.
ANALYZE TABLE HRD_OT_HEADER COMPUTE STATISTICS;
ANALYZE INDEX HRD_OT_HEADER_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_OT_HEADER_U2 COMPUTE STATISTICS;
ANALYZE INDEX HRD_OT_HEADER_N1 COMPUTE STATISTICS;
