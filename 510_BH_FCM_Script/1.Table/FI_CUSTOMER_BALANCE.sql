/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_CUSTOMER_BALANCE
/* Description  : ������ �ŷ�ó�� �ܾ׿���.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_CUSTOMER_BALANCE 
( PERIOD_NAME                 VARCHAR2(10)  NOT NULL,     -- ���س��.
  SOB_ID                      NUMBER        NOT NULL,     -- ȸ������.
  ORG_ID                      NUMBER        NOT NULL,     -- �����ID. 
  CUSTOMER_ID                 NUMBER        NOT NULL,     -- �ŷ�óID.
  ACCOUNT_BOOK_ID             NUMBER        NOT NULL,     -- ȸ����� ID.
  ACCOUNT_CONTROL_ID          NUMBER        NOT NULL,     -- �����ڵ�ID.
  ACCOUNT_CODE                VARCHAR2(20)  NOT NULL,     -- �����ڵ�. 
  CURRENCY_CODE               VARCHAR2(10)  ,             -- ��ȭ. 
  MANAGEMENT1                 VARCHAR2(50)  ,
  MANAGEMENT2                 VARCHAR2(50)  ,
  PRE_DR_AMOUNT               NUMBER(15,0)  DEFAULT 0,    -- ���������̿��ܾ�.
  PRE_CR_AMOUNT               NUMBER(15,0)  DEFAULT 0,    -- �����뺯�̿��ܾ�. 
  PRE_DR_CURR_AMOUNT          NUMBER(15,0)  DEFAULT 0,    -- ���������̿��ܾ�(��ȭ).
  PRE_CR_CURR_AMOUNT          NUMBER(15,0)  DEFAULT 0,    -- �����뺯�̿��ܾ�(��ȭ).
  THIS_DR_AMOUNT              NUMBER(15,0)  DEFAULT 0,    -- ��������հ�.
  THIS_CR_AMOUNT              NUMBER(15,0)  DEFAULT 0,    -- ����뺯�հ�.
  THIS_DR_CURR_AMOUNT         NUMBER(16,4)  DEFAULT 0,    -- ��������հ�(��ȭ).  
  THIS_CR_CURR_AMOUNT         NUMBER(16,4)  DEFAULT 0,    -- ����뺯�հ�(��ȭ).
  REMAIN_DR_AMOUNT            NUMBER(15,0)  DEFAULT 0,    -- �����ܾ�.
  REMAIN_CR_AMOUNT            NUMBER(15,0)  DEFAULT 0,    -- �뺯�ܾ�.
  REMAIN_DR_CURR_AMOUNT       NUMBER(16,4)  DEFAULT 0,    -- �����ܾ�(��ȭ).
  REMAIN_CR_CURR_AMOUNT       NUMBER(16,4)  DEFAULT 0,    -- �뺯�ܾ�(��ȭ).
  CREATION_DATE               DATE          NOT NULL,     -- ������.
  CREATED_BY                  NUMBER        NOT NULL,     -- ������.
  LAST_UPDATE_DATE            DATE          NOT NULL,     -- ������.
  LAST_UPDATED_BY             NUMBER        NOT NULL      -- ������.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_CUSTOMER_BALANCE IS '������ �ŷ�ó���ܾ�';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.PERIOD_NAME IS 'ȸ����';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.CUSTOMER_ID IS '�ŷ�ó�ڵ�';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.ACCOUNT_BOOK_ID IS 'ȸ�����ID';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.CURRENCY_CODE IS '��ȭ';

COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.PRE_DR_AMOUNT IS '���������̿��ݾ�';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.PRE_CR_AMOUNT IS '�����뺯�̿��ݾ�';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.PRE_DR_CURR_AMOUNT IS '���������̿��ݾ�(��ȭ)';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.PRE_CR_CURR_AMOUNT IS '�����뺯�̿��ݾ�(��ȭ)';

COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.THIS_DR_AMOUNT IS '��������հ�';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.THIS_CR_AMOUNT IS '����뺯�հ�';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.THIS_DR_CURR_AMOUNT IS '��������հ�(��ȭ)';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.THIS_CR_CURR_AMOUNT IS '����뺯�հ�(��ȭ)';

COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.REMAIN_DR_AMOUNT IS '��������ܾ�';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.REMAIN_CR_AMOUNT IS '����뺯�ܾ�';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.REMAIN_DR_CURR_AMOUNT IS '��������ܾ�(��ȭ)';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.REMAIN_CR_CURR_AMOUNT IS '����뺯�ܾ�(��ȭ)';

COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.CREATION_DATE IS '������';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.CREATED_BY IS '������';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.LAST_UPDATE_DATE IS '������';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE.LAST_UPDATED_BY IS '������';

CREATE UNIQUE INDEX FI_CUSTOMER_BALANCE_PK ON 
  FI_CUSTOMER_BALANCE(PERIOD_NAME, SOB_ID, CUSTOMER_ID, ACCOUNT_BOOK_ID, ACCOUNT_CONTROL_ID, CURRENCY_CODE)
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

ALTER TABLE FI_CUSTOMER_BALANCE ADD ( 
  CONSTRAINT FI_CUSTOMER_BALANCE_PK PRIMARY KEY (PERIOD_NAME, SOB_ID, CUSTOMER_ID, ACCOUNT_BOOK_ID, ACCOUNT_CONTROL_ID, CURRENCY_CODE)
        );
