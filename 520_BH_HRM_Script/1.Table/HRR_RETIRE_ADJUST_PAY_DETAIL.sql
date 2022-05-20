/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRR_RETIRE_ADJUST_PAY_DETAIL
/* Description  : �������� ���� �� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRR_RETIRE_ADJUST_PAY_DETAIL              
( ADJUSTMENT_ID                   NUMBER        NOT NULL,
  PAY_YYYYMM                      VARCHAR2(7)   NOT NULL,
  WAGE_TYPE                       VARCHAR2(5)   NOT NULL,
  ALLOWANCE_ID                    NUMBER        NOT NULL,
  ALLOWANCE_AMOUNT                NUMBER        DEFAULT 0,
  PERSON_ID                       NUMBER        NOT NULL,
  CORP_ID                         NUMBER        NOT NULL,
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  CREATION_DATE                   DATE          NOT NULL,
  CREATED_BY                      NUMBER        NOT NULL,
  LAST_UPDATE_DATE                DATE          NOT NULL,
  LAST_UPDATED_BY                 NUMBER        NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRR_RETIRE_ADJUST_PAY_DETAIL IS '�������� �޻� ���� �󼼳���';
COMMENT ON COLUMN HRR_RETIRE_ADJUST_PAY_DETAIL.ADJUSTMENT_ID IS '��������ID';
COMMENT ON COLUMN HRR_RETIRE_ADJUST_PAY_DETAIL.PAY_YYYYMM IS '���� �޻� ���';
COMMENT ON COLUMN HRR_RETIRE_ADJUST_PAY_DETAIL.WAGE_TYPE IS '�޻� ����';
COMMENT ON COLUMN HRR_RETIRE_ADJUST_PAY_DETAIL.ALLOWANCE_ID IS '�����׸�ID';
COMMENT ON COLUMN HRR_RETIRE_ADJUST_PAY_DETAIL.ALLOWANCE_AMOUNT IS '���ޱݾ�';
COMMENT ON COLUMN HRR_RETIRE_ADJUST_PAY_DETAIL.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRR_RETIRE_ADJUST_PAY_DETAIL.CREATED_BY IS '������';
COMMENT ON COLUMN HRR_RETIRE_ADJUST_PAY_DETAIL.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRR_RETIRE_ADJUST_PAY_DETAIL.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRR_RETIRE_ADJUST_PAY_D_U1 ON HRR_RETIRE_ADJUST_PAY_DETAIL(ADJUSTMENT_ID, PAY_YYYYMM, WAGE_TYPE, ALLOWANCE_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRR_RETIRE_ADJUST_PAY_D_N1 ON HRR_RETIRE_ADJUST_PAY_DETAIL(ADJUSTMENT_ID, WAGE_TYPE) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRR_RETIRE_ADJUST_PAY_DETAIL COMPUTE STATISTICS;
ANALYZE INDEX HRR_RETIRE_ADJUST_PAY_D_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRR_RETIRE_ADJUST_PAY_D_N1 COMPUTE STATISTICS;
