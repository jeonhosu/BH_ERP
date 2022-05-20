/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_REALTY_LEASE_HISTORY
/* Description  : �ε��� �Ӵ볻�� - �Ӵ�� ��곻��.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_REALTY_LEASE_HISTORY
( REALTY_LEASE_ID                 NUMBER        NOT NULL,   -- �ε��� �Ӵ볻�� ID.
  TAX_CODE                        VARCHAR2(10)  NOT NULL,   -- ����� �ڵ�(TAX_CODE).
  USE_DATE_FR                     DATE          ,           -- �Ӵ�Ⱓ(����).
  USE_DATE_TO                     DATE          ,           -- �Ӵ�Ⱓ(����).
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  DEPOSIT_INTEREST_AMT            NUMBER        DEFAULT 0,  -- ����������.
  MONTHLY_RENT_SUM_AMT            NUMBER        DEFAULT 0,  -- �����հ�.
  MAINTENANCE_FEE                 NUMBER        DEFAULT 0,  -- ������.
  TOTAL_DAY                       NUMBER        DEFAULT 0,  -- ���ϼ�.
  PERIOD_DAY                      NUMBER        DEFAULT 0,  -- �Ӵ�Ⱓ �ϼ�.
  CLOSED_YN                       CHAR(1)       DEFAULT 'N',-- ��������.
  CLOSED_DATE                     DATE          ,           -- �����Ͻ�.
  CLOSED_PERSON_ID                NUMBER        ,           -- ����ó����.
  ATTRIBUTE_A                     VARCHAR2(100) ,
  ATTRIBUTE_B                     VARCHAR2(100) ,
  ATTRIBUTE_C                     VARCHAR2(100) ,
  ATTRIBUTE_D                     VARCHAR2(100) ,
  ATTRIBUTE_E                     VARCHAR2(100) ,
  ATTRIBUTE_1                     NUMBER        ,
  ATTRIBUTE_2                     NUMBER        ,
  ATTRIBUTE_3                     NUMBER        ,
  ATTRIBUTE_4                     NUMBER        ,
  ATTRIBUTE_5                     NUMBER        ,
  CREATION_DATE                   DATE          NOT NULL,
  CREATED_BY                      NUMBER        NOT NULL,
  LAST_UPDATE_DATE                DATE          NOT NULL,
  LAST_UPDATED_BY                 NUMBER        NOT NULL
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_VAT_REALTY_LEASE_HISTORY IS '�ε����Ӵ볻��';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.REALTY_LEASE_ID IS '�ε��� �Ӵ볻�� ID';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.TAX_CODE IS '�ΰ��� �Ű� ������ڵ�';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.USE_DATE_FR IS '�Ӵ� ��������';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.USE_DATE_TO IS '�Ӵ� ��������';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.DEPOSIT_INTEREST_AMT IS '����������';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.MONTHLY_RENT_SUM_AMT IS '�����հ�';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.MAINTENANCE_FEE IS '������';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.TOTAL_DAY IS '���ϼ�';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.PERIOD_DAY IS '�Ӵ�Ⱓ �ϼ�';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.CLOSED_YN IS '��������';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.CLOSED_DATE IS '�����Ͻ�';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.CLOSED_PERSON_ID IS '����ó����';

ALTER TABLE FI_VAT_REALTY_LEASE_HISTORY ADD CONSTRAINT FI_VAT_REALTY_LEASE_HTR_PK PRIMARY KEY (REALTY_LEASE_ID, TAX_CODE, USE_DATE_FR, USE_DATE_TO, SOB_ID);
CREATE INDEX FI_VAT_REALTY_LEASE_HTR_N1 ON FI_VAT_REALTY_LEASE_HISTORY(TAX_CODE, SOB_ID)  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_REALTY_LEASE_HTR_N2 ON FI_VAT_REALTY_LEASE_HISTORY(TAX_CODE, USE_DATE_FR, USE_DATE_TO, SOB_ID)  TABLESPACE FCM_TS_IDX;
