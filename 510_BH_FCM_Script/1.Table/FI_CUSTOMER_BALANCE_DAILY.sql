/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_CUSTOMER_BALANCE_DAILY
/* Description  : ������ �ŷ�ó�� �ܾ׿���.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_CUSTOMER_BALANCE_DAILY
( GL_DATE                     DATE          NOT NULL,     -- ��ǥ����.
  GL_DATE_SEQ                 NUMBER        DEFAULT 1,    -- ���� ����(0-�̿��ݾ�, 1-����ݾ�).
  SOB_ID                      NUMBER        NOT NULL,     -- ȸ������.
  ORG_ID                      NUMBER        NOT NULL,     -- �����ID. 
  CUSTOMER_ID                 NUMBER        NOT NULL,     -- �ŷ�óID.
  ACCOUNT_BOOK_ID             NUMBER        NOT NULL,     -- ȸ����� ID.
  PERIOD_NAME                 VARCHAR2(10)  NOT NULL,     -- ȸ����.
  ACCOUNT_CONTROL_ID          NUMBER        NOT NULL,     -- �����ڵ�ID.
  ACCOUNT_CODE                VARCHAR2(20)  NOT NULL,     -- �����ڵ�. 
  CURRENCY_CODE               VARCHAR2(10)  ,             -- ��ȭ. 
  MANAGEMENT1                 VARCHAR2(50)  ,
  MANAGEMENT2                 VARCHAR2(50)  ,
  DR_AMOUNT                   NUMBER        DEFAULT 0,    -- ��������հ�.
  CR_AMOUNT                   NUMBER        DEFAULT 0,    -- ����뺯�հ�.
  DR_CURR_AMOUNT              NUMBER        DEFAULT 0,    -- ��������հ�(��ȭ).  
  CR_CURR_AMOUNT              NUMBER        DEFAULT 0,    -- ����뺯�հ�(��ȭ).
  CREATION_DATE               DATE          NOT NULL,     -- ������.
  CREATED_BY                  NUMBER        NOT NULL,     -- ������.
  LAST_UPDATE_DATE            DATE          NOT NULL,     -- ������.
  LAST_UPDATED_BY             NUMBER        NOT NULL      -- ������.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_CUSTOMER_BALANCE_DAILY IS '���ں� �ŷ�ó�� ������ �ܾ�';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.GL_DATE IS '��ǥ����';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.GL_DATE_SEQ IS '��������(0-�̿�,1-����)';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.CUSTOMER_ID IS '�ŷ�ó�ڵ�';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.ACCOUNT_BOOK_ID IS 'ȸ�����ID';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.PERIOD_NAME IS 'ȸ����';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.DR_AMOUNT IS '���������հ�';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.CR_AMOUNT IS '���ϴ뺯�հ�';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.DR_CURR_AMOUNT IS '���������հ�(��ȭ)';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_DAILY.CR_CURR_AMOUNT IS '���ϴ뺯�հ�(��ȭ)';

CREATE UNIQUE INDEX FI_CUSTOMER_BALANCE_DAILY_PK ON 
  FI_CUSTOMER_BALANCE_DAILY(GL_DATE, GL_DATE_SEQ, SOB_ID, CUSTOMER_ID, ACCOUNT_BOOK_ID, ACCOUNT_CONTROL_ID, CURRENCY_CODE)
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

ALTER TABLE FI_CUSTOMER_BALANCE_DAILY ADD ( 
  CONSTRAINT FI_CUSTOMER_BALANCE_DAILY_PK PRIMARY KEY (GL_DATE, GL_DATE_SEQ, SOB_ID, CUSTOMER_ID, ACCOUNT_BOOK_ID, ACCOUNT_CONTROL_ID, CURRENCY_CODE)
        );
