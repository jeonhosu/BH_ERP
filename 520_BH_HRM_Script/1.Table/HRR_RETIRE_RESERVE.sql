/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRR_RETIRE_RESERVE
/* Description  : ���� ����� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRR_RETIRE_RESERVE              
( PERSON_ID                                       NUMBER NOT NULL,
  RESERVE_YYYYMM                                  VARCHAR2(7) NOT NULL,
  CORP_ID                                         NUMBER NOT NULL,
  DEPT_ID                                         NUMBER,
  PAY_GRADE_ID                                    NUMBER,
  COST_CENTER_ID                                  NUMBER,
  JOIN_DATE                                       DATE,
  EXPIRE_DATE                                     DATE,
  START_DATE                                      DATE NOT NULL,
  END_DATE                                        DATE NOT NULL,
  TOTAL_PAY_AMOUNT                                NUMBER DEFAULT 0,
  TOTAL_BONUS_AMOUNT                              NUMBER DEFAULT 0,
  YEAR_ALLOWANCE_AMOUNT                           NUMBER DEFAULT 0,
  LONG_YEAR                                       NUMBER DEFAULT 0,
  LONG_MONTH                                      NUMBER DEFAULT 0,
  LONG_DAY                                        NUMBER DEFAULT 0,
  DAY_3RD_COUNT                                   NUMBER DEFAULT 0,
  DAY_AVG_AMOUNT                                  NUMBER DEFAULT 0,
  RETIRE_AMOUNT                                   NUMBER DEFAULT 0,
  PREVIOUS_RETIRE_AMOUNT                          NUMBER DEFAULT 0,
  THIS_RETIRE_AMOUNT                              NUMBER DEFAULT 0,
  GAP_RETIRE_AMOUNT                               NUMBER DEFAULT 0,
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
COMMENT ON COLUMN HRR_RETIRE_RESERVE.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.RESERVE_YYYYMM IS '�������� ���� ���';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.CORP_ID IS '��üID';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.DEPT_ID IS '�μ�ID';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.PAY_GRADE_ID IS '����ID';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.COST_CENTER_ID IS 'COST CENTER ID';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.JOIN_DATE IS '�Ի�����';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.EXPIRE_DATE IS '�ߵ���������';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.START_DATE IS '��������';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.END_DATE IS '��������';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.TOTAL_PAY_AMOUNT IS '�ѱ޿���(���ؿ����� ����)';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.TOTAL_BONUS_AMOUNT IS '�ѻ󿩾�(���ؿ����� ����)';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.YEAR_ALLOWANCE_AMOUNT IS '��������(���ؿ����� ����)';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.LONG_YEAR IS '�ټӳ��';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.LONG_MONTH IS '�ټӿ���';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.LONG_DAY IS '�ټ��ϼ�';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.DAY_3RD_COUNT IS '3���� �ϼ�';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.DAY_AVG_AMOUNT IS '����ձݾ�';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.RETIRE_AMOUNT IS '������';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.PREVIOUS_RETIRE_AMOUNT IS '���� ������';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.THIS_RETIRE_AMOUNT IS '��� ������';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.GAP_RETIRE_AMOUNT IS '������ ����';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.DESCRIPTION IS '���';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.CREATED_BY IS '������';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRR_RETIRE_RESERVE_U1 ON HRR_RETIRE_RESERVE(PERSON_ID, RESERVE_YYYYMM, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRR_RETIRE_RESERVE COMPUTE STATISTICS;
ANALYZE INDEX HRR_RETIRE_RESERVE_U1 COMPUTE STATISTICS;
