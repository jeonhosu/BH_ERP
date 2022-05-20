/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRR_CONTINUOUS_DEDUCTION
/* Description  : ���� �ټӰ��� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRR_CONTINUOUS_DEDUCTION              
( STD_YYYY                                        VARCHAR2(4) NOT NULL,
  START_YEAR                                      NUMBER      NOT NULL,
  END_YEAR                                        NUMBER    NOT NULL,
  DED_YEAR                                        NUMBER    DEFAULT 0,
  DED_AMOUNT                                      NUMBER DEFAULT 0,
  DED_ADD_AMOUNT                                  NUMBER DEFAULT 0,
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
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.STD_YYYY IS '���� �⵵';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.START_YEAR IS '���� �ټӳ��';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.END_YEAR IS '���� �ټӳ��';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.DED_YEAR IS '���� �ټӳ��';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.DED_AMOUNT IS '�����ݾ�';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.DED_ADD_AMOUNT IS '�߰� �����ݾ�';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.DESCRIPTION IS '���';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.CREATED_BY IS '������';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRR_CONTINUOUS_DEDUCTION.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRR_CONTINUOUS_DEDUCTION_U1 ON HRR_CONTINUOUS_DEDUCTION(STD_YYYY, START_YEAR, END_YEAR, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRR_CONTINUOUS_DEDUCTION COMPUTE STATISTICS;
ANALYZE INDEX HRR_CONTINUOUS_DEDUCTION_U1 COMPUTE STATISTICS;
