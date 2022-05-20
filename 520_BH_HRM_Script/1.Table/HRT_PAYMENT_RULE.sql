/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRT_PAYMENT_RULE
/* Description  : (�İ���) �޻� ������ ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRT_PAYMENT_RULE
( RULE_ID                         NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  CORP_ID                         NUMBER          ,
  WAGE_TYPE                       VARCHAR2(5)     NOT NULL,
  JOIN_ID                         NUMBER          NOT NULL,
  PAY_TYPE                        VARCHAR2(2)     NOT NULL,
  STD_START_DATE                  VARCHAR2(100)   NOT NULL,
  STD_END_DATE                    VARCHAR2(100)   NOT NULL,
  START_MONTH                     NUMBER          ,
  END_MONTH                       NUMBER          ,
  PAYMENT_RATE                    NUMBER          ,
  DESCRIPTION                     VARCHAR2(100)   ,
  ATTRIBUTE1                      VARCHAR2(100)   ,
  ATTRIBUTE2                      VARCHAR2(100)   ,
  ATTRIBUTE3                      VARCHAR2(100)   ,
  ATTRIBUTE4                      VARCHAR2(100)   ,
  ATTRIBUTE5                      VARCHAR2(100)   ,
  ENABLED_FLAG                    VARCHAR2(1)     DEFAULT 'Y',
  EFFECTIVE_YYYYMM_FR             VARCHAR2(7)     NOT NULL,
  EFFECTIVE_YYYYMM_TO             VARCHAR2(7)     ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRT_PAYMENT_RULE IS '(�İ���) �޻� ����������';
COMMENT ON COLUMN HRT_PAYMENT_RULE.RULE_ID IS '������ ID';
COMMENT ON COLUMN HRT_PAYMENT_RULE.CORP_ID IS '��ü ID';
COMMENT ON COLUMN HRT_PAYMENT_RULE.WAGE_TYPE IS '�޻� ����';
COMMENT ON COLUMN HRT_PAYMENT_RULE.JOIN_ID IS '�Ի籸��';
COMMENT ON COLUMN HRT_PAYMENT_RULE.PAY_TYPE IS '�޿���';
COMMENT ON COLUMN HRT_PAYMENT_RULE.STD_START_DATE IS '���� ���� ��������(�׷�, ���� �Ի��ϵ�)';
COMMENT ON COLUMN HRT_PAYMENT_RULE.STD_END_DATE IS '���� ���� ��������(��������, ó���������ڵ�)';
COMMENT ON COLUMN HRT_PAYMENT_RULE.START_MONTH IS '���� ���� ����';
COMMENT ON COLUMN HRT_PAYMENT_RULE.END_MONTH IS '���� ���� ����';
COMMENT ON COLUMN HRT_PAYMENT_RULE.PAYMENT_RATE IS '������(%)';
COMMENT ON COLUMN HRT_PAYMENT_RULE.DESCRIPTION IS '���';
COMMENT ON COLUMN HRT_PAYMENT_RULE.ENABLED_FLAG IS '��� ����';
COMMENT ON COLUMN HRT_PAYMENT_RULE.EFFECTIVE_YYYYMM_FR IS '���� ���۳��';
COMMENT ON COLUMN HRT_PAYMENT_RULE.EFFECTIVE_YYYYMM_TO IS '���� ������';
COMMENT ON COLUMN HRT_PAYMENT_RULE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRT_PAYMENT_RULE.CREATED_BY IS '������';
COMMENT ON COLUMN HRT_PAYMENT_RULE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRT_PAYMENT_RULE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRT_PAYMENT_RULE_U1 ON HRT_PAYMENT_RULE(RULE_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRT_PAYMENT_RULE_U2 ON HRT_PAYMENT_RULE(WAGE_TYPE, JOIN_ID, PAY_TYPE, EFFECTIVE_YYYYMM_FR, EFFECTIVE_YYYYMM_TO, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE
CREATE SEQUENCE HRT_PAYMENT_RULE_S1;

-- ANALYZE.
ANALYZE TABLE HRT_PAYMENT_RULE COMPUTE STATISTICS;
ANALYZE INDEX HRT_PAYMENT_RULE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRT_PAYMENT_RULE_U2 COMPUTE STATISTICS;
