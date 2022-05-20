/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_MONTH_SETTLEMENT
/* Description  :  ������ ��� �ڷ� ���� ���̺�.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_MONTH_SETTLEMENT
( PERIOD_NAME                 VARCHAR2(7)   NOT NULL,     -- ȸ������.
  SOB_ID                      NUMBER        NOT NULL,     -- ȸ���ڵ�.
  ORG_ID                      NUMBER        NOT NULL,     -- �����ID.
  FORM_HEADER_ID              NUMBER        NOT NULL,     -- ���� ��� ID.
  FORM_ITEM_LEVEL             NUMBER        NOT NULL,     -- ���� �׸� ����.  
  GL_AMOUNT                   NUMBER        DEFAULT 0,    -- �ݾ�.
  JOURNALIZE_AMOUNT           NUMBER        DEFAULT 0,    -- �а����.
  FORM_ITEM_TYPE              VARCHAR2(10)  ,             -- ���� �׸� Ÿ��.
  FORM_ITEM_CLASS             VARCHAR2(10)  ,             -- ���� �׸� �з�.
  SLIP_YN                     CHAR(1)       DEFAULT 'N',  -- ��ǥ ����.
  CREATION_DATE               DATE          NOT NULL,     -- ������.
  CREATED_BY                  NUMBER        NOT NULL,     -- ������.
  LAST_UPDATE_DATE            DATE          NOT NULL,     -- ������.
  LAST_UPDATED_BY             NUMBER        NOT NULL      -- ������.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_MONTH_SETTLEMENT IS '������ ����ڷ� ����-������';
COMMENT ON COLUMN APPS.FI_MONTH_SETTLEMENT.PERIOD_NAME IS '��� ���';
COMMENT ON COLUMN APPS.FI_MONTH_SETTLEMENT.SOB_ID IS 'ȸ��ID';
COMMENT ON COLUMN APPS.FI_MONTH_SETTLEMENT.FORM_HEADER_ID IS '�繫��ǥ��� ��� ID';
COMMENT ON COLUMN APPS.FI_MONTH_SETTLEMENT.FORM_ITEM_LEVEL IS '�繫��ǥ �׸� ����.';
COMMENT ON COLUMN APPS.FI_MONTH_SETTLEMENT.GL_AMOUNT IS '�ݾ�';
COMMENT ON COLUMN APPS.FI_MONTH_SETTLEMENT.JOURNALIZE_AMOUNT IS '�а����ݾ�';
COMMENT ON COLUMN APPS.FI_MONTH_SETTLEMENT.FORM_ITEM_TYPE IS '���� �׸� Ÿ��';
COMMENT ON COLUMN APPS.FI_MONTH_SETTLEMENT.FORM_ITEM_CLASS IS '���� �׸� �з�';
COMMENT ON COLUMN APPS.FI_MONTH_SETTLEMENT.SLIP_YN IS '��ǥ ����Y/N';

CREATE UNIQUE INDEX FI_MONTH_SETTLEMENT_U1 ON FI_MONTH_SETTLEMENT(PERIOD_NAME, SOB_ID, FORM_HEADER_ID) TABLESPACE FCM_TS_IDX;
