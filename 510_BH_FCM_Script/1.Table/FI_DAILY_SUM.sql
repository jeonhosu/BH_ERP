/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_DAILY_SUM
/* Description  : �ϰ踶�� ���̺�.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_DAILY_SUM 
( GL_DATE                     DATE          NOT NULL,  -- ȸ������.
  GL_DATE_SEQ                 NUMBER        DEFAULT 1,  -- �����Ϸù�ȣ.
  SOB_ID                      NUMBER        NOT NULL,  -- ȸ���ڵ�.
  ORG_ID                      NUMBER        NOT NULL,  -- �����ID.
  ACCOUNT_CONTROL_ID          NUMBER        NOT NULL,  -- ��������ID.
  ACCOUNT_CODE                VARCHAR2(20)  NOT NULL,  -- �����ڵ�.
  MANAGEMENT1                 VARCHAR2(50)  ,          -- �����׸�1.
  MANAGEMENT2                 VARCHAR2(50)  ,          -- �����׸�2.  
  DR_SUM                      NUMBER(15,0)  DEFAULT 0, -- �����հ�.
  CR_SUM                      NUMBER(15,0)  DEFAULT 0, -- �뺯�հ�.
  CURRENCY_CODE               VARCHAR2(10)  ,          -- ��ȭ.
  OLD_EXCHANGE_RATE           NUMBER        DEFAULT 0,  -- ���� ȯ��.
  EXCHANGE_RATE               NUMBER        DEFAULT 0,  -- ȯ��.
  DR_SUM_CURR                 NUMBER(16,4)  DEFAULT 0, -- �����հ�(��ȭ).
  CR_SUM_CURR                 NUMBER(16,4)  DEFAULT 0, -- �뺯�հ�(��ȭ).
  CREATION_DATE               DATE          NOT NULL,  -- ������.
  CREATED_BY                  NUMBER        NOT NULL,  -- ������.
  LAST_UPDATE_DATE            DATE          NOT NULL,  -- ������.
  LAST_UPDATED_BY             NUMBER        NOT NULL   -- ������.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_DAILY_SUM IS '���ں� �������̺�';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.GL_DATE IS 'ȸ������';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.GL_DATE_SEQ IS '0=�����̿��ܾ� 1=����߻�';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.SOB_ID IS 'ȸ��ID';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.MANAGEMENT1 IS '�����׸�1';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.MANAGEMENT2 IS '�����׸�2';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.DR_SUM IS '�����հ�';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.CR_SUM IS '�뺯�հ�';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.OLD_EXCHANGE_RATE IS '���� ȯ��';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.DR_SUM_CURR IS '�����հ�(��ȭ)';
COMMENT ON COLUMN APPS.FI_DAILY_SUM.CR_SUM_CURR IS '�뺯�հ�(��ȭ)';

CREATE UNIQUE INDEX FI_DAILY_SUM_U1 ON FI_DAILY_SUM(GL_DATE, GL_DATE_SEQ, SOB_ID, ACCOUNT_CONTROL_ID, CURRENCY_CODE) TABLESPACE FCM_TS_IDX;
