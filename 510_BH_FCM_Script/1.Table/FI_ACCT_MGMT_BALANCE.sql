/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_ACCT_MGMT_BALANCE
/* Description  :  ���� �� �����׸� �ϰ踶�� ���̺�.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_ACCT_MGMT_BALANCE
( ACCT_MGMT_BALANCE_ID        NUMBER        NOT NULL,  -- ���������׸� �ܾ� ID
  GL_DATE                     DATE          NOT NULL,  -- ȸ������.
  GL_DATE_SEQ                 NUMBER        DEFAULT 1, -- �����Ϸù�ȣ.
  SOB_ID                      NUMBER        NOT NULL,  -- ȸ���ڵ�.
  ORG_ID                      NUMBER        NOT NULL,  -- �����ID.
  ACCOUNT_BOOK_ID             NUMBER        NOT NULL,
  PERIOD_NAME                 VARCHAR2(10)  NOT NULL,
  ACCOUNT_CONTROL_ID          NUMBER        NOT NULL,  -- ��������ID.
  ACCOUNT_CODE                VARCHAR2(20)  NOT NULL,  -- �����ڵ�.
  CURRENCY_CODE               VARCHAR2(10)  ,          -- ��ȭ.
  ACCT_MGMT_SEQ               NUMBER        DEFAULT 1, -- ���� ������ ���� �Ϸù�ȣ.
  DR_SUM                      NUMBER        DEFAULT 0, -- �����հ�.
  CR_SUM                      NUMBER        DEFAULT 0, -- �뺯�հ�.
  DR_CURR_SUM                 NUMBER        DEFAULT 0, -- �����հ�(��ȭ).
  CR_CURR_SUM                 NUMBER        DEFAULT 0, -- �뺯�հ�(��ȭ).
  CREATION_DATE               DATE          NOT NULL,  -- ������.
  CREATED_BY                  NUMBER        NOT NULL,  -- ������.
  LAST_UPDATE_DATE            DATE          NOT NULL,  -- ������.
  LAST_UPDATED_BY             NUMBER        NOT NULL   -- ������.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_ACCT_MGMT_BALANCE IS '�ϰ踶�����̺�';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.ACCT_MGMT_BALANCE_ID IS '���������׸� �ܾ� ID';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.GL_DATE IS 'ȸ������';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.GL_DATE_SEQ IS '0=�����̿��ܾ� 1=����߻�';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.SOB_ID IS 'ȸ��ID';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.ACCT_MGMT_SEQ IS '�Ϸù�ȣ';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.DR_SUM IS '�����հ�';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.CR_SUM IS '�뺯�հ�';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.DR_CURR_SUM IS '�����հ�(��ȭ)';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE.CR_CURR_SUM IS '�뺯�հ�(��ȭ)';

CREATE UNIQUE INDEX FI_ACCT_MGMT_BALANCE_PK ON 
  FI_ACCT_MGMT_BALANCE(GL_DATE, GL_DATE_SEQ, SOB_ID, ACCOUNT_CONTROL_ID, CURRENCY_CODE, ACCT_MGMT_SEQ)
  TABLESPACE FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  LOGGING
  STORAGE (
           INITIAL 64K
           MINEXTENTS 1
           MAXEXTENTS 2147483645
          );

ALTER TABLE FI_ACCT_MGMT_BALANCE ADD ( 
  CONSTRAINT FI_ACCT_MGMT_BALANCE_PK PRIMARY KEY (GL_DATE, GL_DATE_SEQ, SOB_ID, ACCOUNT_CONTROL_ID, CURRENCY_CODE, ACCT_MGMT_SEQ)
        );

CREATE UNIQUE INDEX FI_ACCT_MGMT_BALANCE_U1 ON FI_ACCT_MGMT_BALANCE(ACCT_MGMT_BALANCE_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_ACCT_MGMT_BALANCE_N1 ON FI_ACCT_MGMT_BALANCE(GL_DATE, GL_DATE_SEQ, SOB_ID, ACCOUNT_CODE) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_ACCT_MGMT_BALANCE_N2 ON FI_ACCT_MGMT_BALANCE(ACCOUNT_CONTROL_ID, SOB_ID) TABLESPACE FCM_TS_IDX;

CREATE SEQUENCE FI_ACCT_MGMT_BALANCE_S1;
