/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_INSURANCE_CHARGE
/* Description  : ����(����,�ǰ�)�� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRP_INSURANCE_CHARGE              
( PERSON_ID                                       NUMBER NOT NULL,
  CORP_ID                                         NUMBER NOT NULL,
  INSUR_TYPE                                      VARCHAR2(2) NOT NULL,
  INSUR_YN                                        VARCHAR2(1) DEFAULT 'N',
  INSUR_NO                                        VARCHAR2(50),
  INSUR_GRADE_STEP                                VARCHAR2(5),
  CORP_INSUR_AMOUNT                               NUMBER DEFAULT 0,
  CORP_INSUR_ADD_AMOUNT                           NUMBER DEFAULT 0,
  PERSON_INSUR_AMOUNT                             NUMBER DEFAULT 0,
  PERSON_INSUR_ADD_AMOUNT                         NUMBER DEFAULT 0,
  DESCRIPTION                                     VARCHAR2(100),
  ATTRIBUTE1                                      VARCHAR2(100),
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
  GET_DATE                                        DATE,
  LOSS_DATE                                       DATE,
  SOB_ID                                          NUMBER NOT NULL,
  ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.CORP_ID IS '��ü ID';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.INSUR_TYPE IS '���� ����(P-���ο���, M-�ǰ�����)';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.INSUR_YN IS '���� ���뱸��';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.INSUR_NO IS '���� ��ȣ';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.INSUR_GRADE_STEP IS '���� ���';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.CORP_INSUR_AMOUNT IS 'ȸ�� �δ� �����';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.CORP_INSUR_ADD_AMOUNT IS 'ȸ�� �δ� �߰��ݾ�';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.PERSON_INSUR_AMOUNT IS '���� �δ� �����';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.PERSON_INSUR_ADD_AMOUNT IS '���� �δ� �߰��ݾ�';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.DESCRIPTION IS '���';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.GET_DATE IS '�������';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.LOSS_DATE IS '�������';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.CREATED_BY IS '������';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRP_INSURANCE_CHARGE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRP_INSURANCE_CHARGE_U1 ON HRP_INSURANCE_CHARGE(PERSON_ID, CORP_ID, INSUR_TYPE, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRP_INSURANCE_CHARGE COMPUTE STATISTICS;
ANALYZE INDEX HRP_INSURANCE_CHARGE_U1 COMPUTE STATISTICS;
