/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_MONTH_ALLOWANCE
/* Description  : ���޻� ���޳��� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRT_MONTH_PAYMENT_SLIP_EXP
( PERSON_ID                       NUMBER          NOT NULL,
  PAY_YYYYMM                      VARCHAR2(7)     NOT NULL,
  WAGE_TYPE                       VARCHAR2(5)     NOT NULL,
  CORP_ID                         NUMBER          NOT NULL,
  ALLOWANCE_ID                    NUMBER          NOT NULL,
  ALLOWANCE_AMOUNT                NUMBER          DEFAULT 0,
  MONTH_PAYMENT_ID                NUMBER          NOT NULL,
  CREATED_FLAG                    VARCHAR2(2)     DEFAULT 'C',
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRT_MONTH_ALLOWANCE IS '�޻� ���޳���';
COMMENT ON COLUMN HRT_MONTH_ALLOWANCE.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRT_MONTH_ALLOWANCE.PAY_YYYYMM IS '�޻� ���';
COMMENT ON COLUMN HRT_MONTH_ALLOWANCE.WAGE_TYPE IS '�޻� ����';
COMMENT ON COLUMN HRT_MONTH_ALLOWANCE.CORP_ID IS '��üID';
COMMENT ON COLUMN HRT_MONTH_ALLOWANCE.ALLOWANCE_ID IS '�����׸� ID';
COMMENT ON COLUMN HRT_MONTH_ALLOWANCE.ALLOWANCE_AMOUNT IS '���޾�';
COMMENT ON COLUMN HRT_MONTH_ALLOWANCE.MONTH_PAYMENT_ID IS '���޿�����ID';
COMMENT ON COLUMN HRT_MONTH_ALLOWANCE.CREATED_FLAG IS '��������(C-����, I-INTERFACE)';
COMMENT ON COLUMN HRT_MONTH_ALLOWANCE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRT_MONTH_ALLOWANCE.CREATED_BY IS '������';
COMMENT ON COLUMN HRT_MONTH_ALLOWANCE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRT_MONTH_ALLOWANCE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRT_MONTH_ALLOWANCE_U1 ON HRT_MONTH_ALLOWANCE(PAY_YYYYMM, WAGE_TYPE, CORP_ID, PERSON_ID, ALLOWANCE_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRT_MONTH_ALLOWANCE_N1 ON HRT_MONTH_ALLOWANCE(MONTH_PAYMENT_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRT_MONTH_ALLOWANCE COMPUTE STATISTICS;
ANALYZE INDEX HRT_MONTH_ALLOWANCE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRT_MONTH_ALLOWANCE_N1 COMPUTE STATISTICS;
