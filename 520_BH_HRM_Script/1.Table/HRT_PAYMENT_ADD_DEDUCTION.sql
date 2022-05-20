/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRT_PAYMENT_ADD_DEDUCTION
/* Description  : �޻� �߰� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRT_PAYMENT_ADD_DEDUCTION              
( ADD_DEDUCTION_ID                                 NUMBER NOT NULL,
  PERSON_ID                                        NUMBER NOT NULL,
  CORP_ID                                          NUMBER NOT NULL,
  PAY_YYYYMM                                       VARCHAR2(7) NOT NULL,
  WAGE_TYPE                                        VARCHAR2(5) NOT NULL,
  DEDUCTION_ID                                     NUMBER NOT NULL,
  DEDUCTION_AMOUNT                                 NUMBER DEFAULT 0,
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
COMMENT ON COLUMN HRT_PAYMENT_ADD_DEDUCTION.ADD_DEDUCTION_ID IS '�߰����� ID';
COMMENT ON COLUMN HRT_PAYMENT_ADD_DEDUCTION.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRT_PAYMENT_ADD_DEDUCTION.CORP_ID IS '��üID';
COMMENT ON COLUMN HRT_PAYMENT_ADD_DEDUCTION.PAY_YYYYMM IS '�޻� ���';
COMMENT ON COLUMN HRT_PAYMENT_ADD_DEDUCTION.WAGE_TYPE IS '�޻� ����';
COMMENT ON COLUMN HRT_PAYMENT_ADD_DEDUCTION.DEDUCTION_ID IS '�����׸� ID';
COMMENT ON COLUMN HRT_PAYMENT_ADD_DEDUCTION.DEDUCTION_AMOUNT IS '���޾�';
COMMENT ON COLUMN HRT_PAYMENT_ADD_DEDUCTION.CREATED_FLAG IS '��������(I-Interface, M-Manual)';
COMMENT ON COLUMN HRT_PAYMENT_ADD_DEDUCTION.DESCRIPTION IS '���';
COMMENT ON COLUMN HRT_PAYMENT_ADD_DEDUCTION.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRT_PAYMENT_ADD_DEDUCTION.CREATED_BY IS '������';
COMMENT ON COLUMN HRT_PAYMENT_ADD_DEDUCTION.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRT_PAYMENT_ADD_DEDUCTION.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRT_PAYMENT_ADD_DEDUCTION_U1 ON HRT_PAYMENT_ADD_DEDUCTION(ADD_DEDUCTION_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRT_PAYMENT_ADD_DEDUCTION_N1 ON HRT_PAYMENT_ADD_DEDUCTION(PERSON_ID, CORP_ID, PAY_YYYYMM, WAGE_TYPE, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE HRT_PAYMENT_ADD_DEDUCTION_S1;

-- ANALYZE.
ANALYZE TABLE HRT_PAYMENT_ADD_DEDUCTION COMPUTE STATISTICS;
ANALYZE INDEX HRT_PAYMENT_ADD_DEDUCTION_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRT_PAYMENT_ADD_DEDUCTION_N1 COMPUTE STATISTICS;
