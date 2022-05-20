/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_MONTH_DEDUCTION
/* Description  : ���޻� �������� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRP_MONTH_DEDUCTION              
( PERSON_ID                                       NUMBER NOT NULL,
  PAY_YYYYMM                                      VARCHAR2(7) NOT NULL,
  WAGE_TYPE                                       VARCHAR2(5) NOT NULL,
  CORP_ID                                         NUMBER NOT NULL,
  DEDUCTION_ID                                    NUMBER NOT NULL,
  DEDUCTION_AMOUNT                                NUMBER DEFAULT 0,
  MONTH_PAYMENT_ID                                NUMBER NOT NULL,
  CREATED_FLAG                                    VARCHAR2(2) DEFAULT 'C',
  SOB_ID                                          NUMBER NOT NULL,
  ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.PAY_YYYYMM IS '�޻� ���';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.WAGE_TYPE IS '�޻� ����';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.CORP_ID IS '��üID';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.DEDUCTION_ID IS '�����׸� ID';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.DEDUCTION_AMOUNT IS '������';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.MONTH_PAYMENT_ID IS '���޿����� ID';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.CREATED_FLAG IS '��������(C-����, I-INTERFACE)';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.CREATED_BY IS '������';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRP_MONTH_DEDUCTION_U1 ON HRP_MONTH_DEDUCTION(PAY_YYYYMM, WAGE_TYPE, CORP_ID, PERSON_ID, DEDUCTION_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRP_MONTH_DEDUCTION_N1 ON HRP_MONTH_DEDUCTION(MONTH_PAYMENT_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRP_MONTH_DEDUCTION COMPUTE STATISTICS;
ANALYZE INDEX HRP_MONTH_DEDUCTION_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRP_MONTH_DEDUCTION_N1 COMPUTE STATISTICS;
