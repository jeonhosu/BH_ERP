/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_PERSON_PAYMENT_RULE
/* Description  : �޻� ���κ� ������ ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRP_PERSON_PAYMENT_RULE
( PERSON_RULE_ID                                  NUMBER NOT NULL,
  CORP_ID                                         NUMBER NOT NULL,
  PERSON_ID                                       NUMBER NOT NULL,
  PAYMENT_RATE                                    NUMBER,
  DESCRIPTION                                     VARCHAR2(100),
  ATTRIBUTE1                                      VARCHAR2(100),
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
  ENABLED_FLAG                                    VARCHAR2(1) DEFAULT 'Y',
  EFFECTIVE_YYYYMM_FR                             VARCHAR2(7) NOT NULL,
  EFFECTIVE_YYYYMM_TO                             VARCHAR2(7),
  SOB_ID                                          NUMBER NOT NULL,
  ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRP_PERSON_PAYMENT_RULE.PERSON_RULE_ID IS '���κ� ������ ID';
COMMENT ON COLUMN HRP_PERSON_PAYMENT_RULE.CORP_ID IS '��ü ID';
COMMENT ON COLUMN HRP_PERSON_PAYMENT_RULE.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRP_PERSON_PAYMENT_RULE.PAYMENT_RATE IS '������(%)';
COMMENT ON COLUMN HRP_PERSON_PAYMENT_RULE.DESCRIPTION IS '���';
COMMENT ON COLUMN HRP_PERSON_PAYMENT_RULE.ENABLED_FLAG IS '��� ����';
COMMENT ON COLUMN HRP_PERSON_PAYMENT_RULE.EFFECTIVE_YYYYMM_FR IS '���� ���۳��';
COMMENT ON COLUMN HRP_PERSON_PAYMENT_RULE.EFFECTIVE_YYYYMM_TO IS '���� ������';
COMMENT ON COLUMN HRP_PERSON_PAYMENT_RULE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRP_PERSON_PAYMENT_RULE.CREATED_BY IS '������';
COMMENT ON COLUMN HRP_PERSON_PAYMENT_RULE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRP_PERSON_PAYMENT_RULE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRP_PERSON_PAYMENT_RULE_U1 ON HRP_PERSON_PAYMENT_RULE(PERSON_RULE_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRP_PERSON_PAYMENT_RULE_U2 ON HRP_PERSON_PAYMENT_RULE(CORP_ID, PERSON_ID, EFFECTIVE_YYYYMM_FR, EFFECTIVE_YYYYMM_TO, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE
DROP SEQUENCE HRP_PERSON_PAYMENT_RULE_S1;
CREATE SEQUENCE HRP_PERSON_PAYMENT_RULE_S1;

-- ANALYZE.
ANALYZE TABLE HRP_PERSON_PAYMENT_RULE COMPUTE STATISTICS;
ANALYZE INDEX HRP_PERSON_PAYMENT_RULE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRP_PERSON_PAYMENT_RULE_U2 COMPUTE STATISTICS;
