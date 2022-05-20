/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRR_RETIRE_STANDARD
/* Description  : �������� ó�� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRR_RETIRE_STANDARD              
( STD_YYYY                                        VARCHAR2(4) NOT NULL,
  STD_CALCULATE_MONTH                             NUMBER(2) NOT NULL,
  STD_MONTH                                       NUMBER(2) NOT NULL,
  PAY_MONTH                                       NUMBER(2) NOT NULL,
  BONUS_MONTH                                     NUMBER(2) NOT NULL,
  MONTH_DAY                                       NUMBER DEFAULT 0,
  YEAR_DAY                                        NUMBER DEFAULT 0,
  INCOME_DEDUCTION_RATE                           NUMBER,
  INCOME_DEDUCTION_LMT                            NUMBER,
  TAX_DEDUCTION_RATE                              NUMBER,
  TAX_DEDUCTION_LMT                               NUMBER,
  DESCRIPTION                                     VARCHAR2(100),
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
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRR_RETIRE_STANDARD.STD_YYYY IS '����⵵';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.STD_CALCULATE_MONTH IS 'ó����� �������';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.STD_MONTH IS '���� ����(3)';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.PAY_MONTH IS '���� �޿� ����(3)';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.BONUS_MONTH IS '���� �� ����(12)';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.MONTH_DAY IS '���� ���ϼ�(30)';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.YEAR_DAY IS '���� ���ϼ�(365)';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.INCOME_DEDUCTION_RATE IS '�ҵ������(%)';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.INCOME_DEDUCTION_LMT IS '�ҵ���� �ѵ�';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.TAX_DEDUCTION_RATE IS '���װ�����(%)';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.TAX_DEDUCTION_LMT IS '���װ��� �ѵ�';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.DESCRIPTION IS '���';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.CREATED_BY IS '������';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRR_RETIRE_STANDARD.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRR_RETIRE_STANDARD_U1 ON HRR_RETIRE_STANDARD(STD_YYYY, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRR_RETIRE_STANDARD COMPUTE STATISTICS;
ANALYZE INDEX HRR_RETIRE_STANDARD_U1 COMPUTE STATISTICS;
