/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRT_PAYMENT_ADD_ALLOWANCE
/* Description  : �޻� �߰� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRT_PAYMENT_ADD_ALLOWANCE              
( ADD_ALLOWANCE_ID	                               NUMBER NOT NULL,
  PERSON_ID                                        NUMBER NOT NULL,
  CORP_ID                                          NUMBER NOT NULL,
  PAY_YYYYMM	                                     VARCHAR2(7) NOT NULL,
  WAGE_TYPE	                                       VARCHAR2(5) NOT NULL,
  ALLOWANCE_ID                                     NUMBER NOT NULL,
  ALLOWANCE_AMOUNT                                 NUMBER DEFAULT 0,
  TAX_YN	                                         VARCHAR2(1),
  HIRE_INSUR_YN	                                   VARCHAR2(1),
  CREATED_FLAG                                     VARCHAR2(2) NOT NULL,
  DESCRIPTION                                      VARCHAR2(100),
  ATTRIBUTE1                                       VARCHAR2(100),
  ATTRIBUTE2                                       VARCHAR2(100),
  ATTRIBUTE3                                       VARCHAR2(100),
  ATTRIBUTE4                                       VARCHAR2(100),
  ATTRIBUTE5                                       VARCHAR2(100),
  SOB_ID                                           NUMBER NOT NULL,
  ORG_ID                                           NUMBER NOT NULL,
  CREATION_DATE                                    DATE NOT NULL,
  CREATED_BY                                       NUMBER NOT NULL,
  LAST_UPDATE_DATE                                 DATE NOT NULL,
  LAST_UPDATED_BY                                  NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRT_PAYMENT_ADD_ALLOWANCE.ADD_ALLOWANCE_ID IS '�߰����� ID';
COMMENT ON COLUMN HRT_PAYMENT_ADD_ALLOWANCE.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRT_PAYMENT_ADD_ALLOWANCE.CORP_ID IS '��üID';
COMMENT ON COLUMN HRT_PAYMENT_ADD_ALLOWANCE.PAY_YYYYMM IS '�޻� ���';
COMMENT ON COLUMN HRT_PAYMENT_ADD_ALLOWANCE.WAGE_TYPE IS '�޻� ����';
COMMENT ON COLUMN HRT_PAYMENT_ADD_ALLOWANCE.ALLOWANCE_ID IS '�����׸� ID';
COMMENT ON COLUMN HRT_PAYMENT_ADD_ALLOWANCE.ALLOWANCE_AMOUNT IS '���޾�';
COMMENT ON COLUMN HRT_PAYMENT_ADD_ALLOWANCE.TAX_YN IS '���� ����';
COMMENT ON COLUMN HRT_PAYMENT_ADD_ALLOWANCE.HIRE_INSUR_YN IS '��뺸�� ����';
COMMENT ON COLUMN HRT_PAYMENT_ADD_ALLOWANCE.CREATED_FLAG IS '��������(I-Interface, M-Manual)';
COMMENT ON COLUMN HRT_PAYMENT_ADD_ALLOWANCE.DESCRIPTION IS '���';
COMMENT ON COLUMN HRT_PAYMENT_ADD_ALLOWANCE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRT_PAYMENT_ADD_ALLOWANCE.CREATED_BY IS '������';
COMMENT ON COLUMN HRT_PAYMENT_ADD_ALLOWANCE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRT_PAYMENT_ADD_ALLOWANCE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRT_PAYMENT_ADD_ALLOWANCE_U1 ON HRT_PAYMENT_ADD_ALLOWANCE(ADD_ALLOWANCE_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRT_PAYMENT_ADD_ALLOWANCE_N1 ON HRT_PAYMENT_ADD_ALLOWANCE(PERSON_ID, CORP_ID, PAY_YYYYMM, WAGE_TYPE, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE HRT_PAYMENT_ADD_ALLOWANCE_S1;

-- ANALYZE.
ANALYZE TABLE HRT_PAYMENT_ADD_ALLOWANCE COMPUTE STATISTICS;
ANALYZE INDEX HRT_PAYMENT_ADD_ALLOWANCE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRT_PAYMENT_ADD_ALLOWANCE_N1 COMPUTE STATISTICS;
