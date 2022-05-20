/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_DAILY_SUM
/* Description  : ������º� �ϸ������̺�
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_DAILY_BANK_ACCOUNT_SUM
( GL_DATE                         DATE          NOT NULL,  -- ȸ������.
  GL_DATE_SEQ                     NUMBER        DEFAULT 1,  -- �����Ϸù�ȣ.
  SOB_ID                          NUMBER        NOT NULL,  -- ȸ��ID.
  ORG_ID                          NUMBER        NOT NULL,
  ACCOUNT_BOOK_ID                 NUMBER        NOT NULL,
  ACCOUNT_CONTROL_ID              NUMBER        NOT NULL,  -- ��������ID.
  ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL,  -- �����ڵ�.
  BANK_ACCOUNT_ID                 NUMBER        NOT NULL,  -- ����ID.
  DR_AMOUNT                       NUMBER(15)    DEFAULT 0,  -- �����հ�.
  CR_AMOUNT                       NUMBER(15)    DEFAULT 0,  -- �뺯�հ�.
  OLD_EXCHANGE_RATE               NUMBER        DEFAULT 0,  -- ���� ȯ��.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,  -- ȯ��.
  DR_CURR_AMOUNT                  NUMBER(16,4)  DEFAULT 0,  -- �����հ�(��ȭ).
  CR_CURR_AMOUNT                  NUMBER(16,4)  DEFAULT 0,  -- �뺯�հ�(��ȭ).
  CREATION_DATE                   DATE          NOT NULL,
  CREATED_BY                      NUMBER        NOT NULL,
  LAST_UPDATE_DATE                DATE          NOT NULL,
  LAST_UPDATED_BY                 NUMBER        NOT NULL
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_DAILY_BANK_ACCOUNT_SUM IS '������º� �ϸ������̺�';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.GL_DATE IS 'ȸ������';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.GL_DATE_SEQ IS '0=�����̿��ܾ� 1=����߻�';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.SOB_ID IS 'ȸ��ID';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.ACCOUNT_BOOK_ID IS 'ȸ����� ID';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.BANK_ACCOUNT_ID IS '����ID';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.DR_AMOUNT IS '�����հ�';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.CR_AMOUNT IS '�뺯�հ�';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.OLD_EXCHANGE_RATE IS '����ȯ��';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.DR_CURR_AMOUNT IS '�����հ�(��ȭ)';
COMMENT ON COLUMN APPS.FI_DAILY_BANK_ACCOUNT_SUM.CR_CURR_AMOUNT IS '�뺯�հ�(��ȭ)';

CREATE UNIQUE INDEX FI_DAILY_BANK_ACCOUNT_SUM_PK ON 
  FI_DAILY_BANK_ACCOUNT_SUM(GL_DATE, GL_DATE_SEQ, SOB_ID, ACCOUNT_CONTROL_ID, BANK_ACCOUNT_ID)
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
          
ALTER TABLE FI_DAILY_BANK_ACCOUNT_SUM ADD ( 
  CONSTRAINT FI_DAILY_BANK_ACCOUNT_SUM_PK PRIMARY KEY ( GL_DATE, GL_DATE_SEQ, SOB_ID, ACCOUNT_CONTROL_ID, BANK_ACCOUNT_ID)
        );          

CREATE INDEX FI_DAILY_BANK_ACCOUNT_SUM_N1 ON 
  FI_DAILY_BANK_ACCOUNT_SUM(ACCOUNT_CODE)
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

