/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_HOLY_TYPE
/* Description  : �������� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_HOLY_TYPE         
( HOLY_TYPE_ID                      NUMBER        NOT NULL,
  PERSON_ID                         NUMBER        NOT NULL,
  START_DATE                        DATE          NOT NULL,  
  END_DATE                          DATE          NOT NULL,
  CORP_ID                           NUMBER        NOT NULL,
  WORK_CORP_ID                      NUMBER        NOT NULL,
  HOLY_TYPE                         VARCHAR2(10)  NOT NULL,  
  APPROVED_YN                       CHAR(1)       DEFAULT 'N',
  APPROVED_DATE                     DATE          , 
  APPROVED_PERSON_ID                NUMBER        ,
  CONFIRMED_YN                      CHAR(1)       DEFAULT 'N',
  CONFIRMED_DATE                    DATE          ,
  CONFIRMED_PERSON_ID               NUMBER        ,
  APPROVE_STATUS                    VARCHAR2(1)   DEFAULT 'N',
  EMAIL_STATUS                      VARCHAR2(2)   DEFAULT 'N',
  CALENDAR_TRAN_YN                  CHAR(1)       DEFAULT 'N',
  DESCRIPTION                       VARCHAR2(100) ,
  REJECT_YN	                        CHAR(1)       DEFAULT 'N',
  REJECT_DATE	                      DATE          ,
  REJECT_PERSON_ID	                NUMBER        ,
  REJECT_REMARK                     VARCHAR2(100) ,
  ATTRIBUTE1                        VARCHAR2(100) ,
  ATTRIBUTE2                        VARCHAR2(100) ,
  ATTRIBUTE3                        VARCHAR2(100) ,
  ATTRIBUTE4                        VARCHAR2(100) ,
  ATTRIBUTE5                        VARCHAR2(100) ,
  SOB_ID                            NUMBER        NOT NULL,
  ORG_ID                            NUMBER        NOT NULL,
  CREATION_DATE                     DATE          NOT NULL,
  CREATED_BY                        NUMBER        NOT NULL,
  LAST_UPDATE_DATE                  DATE          NOT NULL,
  LAST_UPDATED_BY                   NUMBER        NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRD_HOLY_TYPE IS '�ٹ��������';
COMMENT ON COLUMN HRD_HOLY_TYPE.HOLY_TYPE_ID IS '�Ϸù�ȣ';
COMMENT ON COLUMN HRD_HOLY_TYPE.PERSON_ID IS '�����ȣ';
COMMENT ON COLUMN HRD_HOLY_TYPE.START_DATE IS '��������';
COMMENT ON COLUMN HRD_HOLY_TYPE.END_DATE IS '��������';
COMMENT ON COLUMN HRD_HOLY_TYPE.HOLY_TYPE IS '�ٹ�Ÿ��';
COMMENT ON COLUMN HRD_HOLY_TYPE.APPROVED_YN IS '1�� ���α���';
COMMENT ON COLUMN HRD_HOLY_TYPE.APPROVED_DATE IS '1�� �����Ͻ�';
COMMENT ON COLUMN HRD_HOLY_TYPE.APPROVED_PERSON_ID IS '1�� ������';
COMMENT ON COLUMN HRD_HOLY_TYPE.CONFIRMED_YN IS 'Ȯ�����α���-���ν� �ٹ�ī���� �ݿ�';
COMMENT ON COLUMN HRD_HOLY_TYPE.CONFIRMED_DATE IS 'Ȯ�������Ͻ�';
COMMENT ON COLUMN HRD_HOLY_TYPE.CONFIRMED_PERSON_ID IS 'Ȯ��������';
COMMENT ON COLUMN HRD_HOLY_TYPE.APPROVE_STATUS IS '���� ����(A-�̽���,B-1������, C-Ȯ������, N-���ι̿�û,R-�ݷ�)';
COMMENT ON COLUMN HRD_HOLY_TYPE.EMAIL_STATUS IS 'EMAIL �߼ۿ���(N-�̹߼�,AR/BR-�߼��غ�,AS/BS-�߼ۿϷ�)';
COMMENT ON COLUMN HRD_HOLY_TYPE.CALENDAR_TRAN_YN IS 'ī���� �ݿ� ����';
COMMENT ON COLUMN HRD_HOLY_TYPE.DESCRIPTION IS '���(����)';
COMMENT ON COLUMN HRD_HOLY_TYPE.REJECT_YN IS '�ݷ�����';
COMMENT ON COLUMN HRD_HOLY_TYPE.REJECT_DATE IS '�ݷ� ó���Ͻ�';
COMMENT ON COLUMN HRD_HOLY_TYPE.REJECT_PERSON_ID IS '�ݷ�ó����';
COMMENT ON COLUMN HRD_HOLY_TYPE.REJECT_REMARK IS '�ݷ�����';
COMMENT ON COLUMN HRD_HOLY_TYPE.ATTRIBUTE5 IS '�����ڵ�';
COMMENT ON COLUMN HRD_HOLY_TYPE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_HOLY_TYPE.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_HOLY_TYPE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_HOLY_TYPE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_HOLY_TYPE_U1 ON HRD_HOLY_TYPE(HOLY_TYPE_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRD_HOLY_TYPE_U2 ON HRD_HOLY_TYPE(START_DATE, END_DATE, PERSON_ID, HOLY_TYPE, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_HOLY_TYPE_N1 ON HRD_HOLY_TYPE(APPROVE_STATUS, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_HOLY_TYPE_N2 ON HRD_HOLY_TYPE(START_DATE, END_DATE, PERSON_ID, HOLY_TYPE, WORK_CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE;
DROP SEQUENCE HRD_HOLY_TYPE_S1;
CREATE SEQUENCE HRD_HOLY_TYPE_S1;

-- ANALYZE.
ANALYZE TABLE HRD_HOLY_TYPE COMPUTE STATISTICS;
ANALYZE INDEX HRD_HOLY_TYPE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_HOLY_TYPE_U2 COMPUTE STATISTICS;
ANALYZE INDEX HRD_HOLY_TYPE_N1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_HOLY_TYPE_N2 COMPUTE STATISTICS;
