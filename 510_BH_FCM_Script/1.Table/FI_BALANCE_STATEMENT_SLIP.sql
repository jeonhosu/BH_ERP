/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BALANCE_STATEMENT_SLIP
/* Description  : �����ܾ׸��� ���� ��ǥ �� �ݾ� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BALANCE_STATEMENT_SLIP
( GL_DATE                     DATE          NOT NULL,    -- ��ǥ����.
  ACCOUNT_CONTROL_ID          NUMBER        NOT NULL,    -- ��������ID. 
  ACCOUNT_CODE                VARCHAR2(20)  NOT NULL,    -- �����ڵ�.  
  CURRENCY_CODE               VARCHAR2(20)  NOT NULL,    -- ��ȭ.
  ITEM_GROUP_ID               NUMBER        DEFAULT 1,   -- �����׸� �׷� ID
  SOB_ID                      NUMBER        NOT NULL,
  DR_AMOUNT                   NUMBER        DEFAULT 0,   -- �����ݾ�
  CR_AMOUNT                   NUMBER        DEFAULT 0,   -- ���ұݾ�.
  DR_CURR_AMOUNT              NUMBER        DEFAULT 0,   -- ��ȭ �̿��ݾ�.
  CR_CURR_AMOUNT              NUMBER        DEFAULT 0,   -- ��ȭ �����ݾ�.
  SLIP_LINE_ID                NUMBER        NOT NULL,    -- ��ǥ ���� ID
  SLIP_HEADER_ID              NUMBER        NOT NULL,    -- ��ǥ ��� ID
  DESCRIPTION                 VARCHAR2(200) ,
  ATTRIBUTE_A                 VARCHAR2(250) ,    
  ATTRIBUTE_B                 VARCHAR2(250) ,    
  ATTRIBUTE_C                 VARCHAR2(250) ,    
  ATTRIBUTE_D                 VARCHAR2(250) ,    
  ATTRIBUTE_E                 VARCHAR2(250) ,    
  ATTRIBUTE_1                 NUMBER        ,    
  ATTRIBUTE_2                 NUMBER        ,    
  ATTRIBUTE_3                 NUMBER        ,    
  ATTRIBUTE_4                 NUMBER        ,
  ATTRIBUTE_5                 NUMBER        ,
  CREATION_DATE               DATE          NOT NULL,  -- ������.
  CREATED_BY                  NUMBER        NOT NULL,  -- ������.
  LAST_UPDATE_DATE            DATE          NOT NULL,  -- ������.
  LAST_UPDATED_BY             NUMBER        NOT NULL   -- ������.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_BALANCE_STATEMENT_SLIP IS '�����ܾ׸��� ���� ��ǥ����';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.GL_DATE IS '��ǥ����';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.ITEM_GROUP_ID IS '�����׸� �׷� ID';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.SOB_ID IS 'ȸ��ID';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.DR_AMOUNT IS '���� �ݾ�';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.CR_AMOUNT IS '�뺯 �ݾ�';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.DR_CURR_AMOUNT IS '��ȭ �����ݾ�';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.CR_CURR_AMOUNT IS '��ȭ �뺯�ݾ�';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.SLIP_LINE_ID IS '��ǥ ����ID';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.SLIP_HEADER_ID IS '��ǥ ���ID';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.DESCRIPTION IS '���';

-- INDEX.
ALTER TABLE FI_BALANCE_STATEMENT_SLIP ADD CONSTRAINT FI_BALANCE_STATEMENT_SLIP PRIMARY KEY (SLIP_LINE_ID);

CREATE INDEX FI_BALANCE_STATEMENT_SLIP_N1 ON FI_BALANCE_STATEMENT_SLIP(GL_DATE, ACCOUNT_CONTROL_ID, CURRENCY_CODE, ITEM_GROUP_ID, SOB_ID);
CREATE INDEX FI_BALANCE_STATEMENT_SLIP_N2 ON FI_BALANCE_STATEMENT_SLIP(GL_DATE, ACCOUNT_CODE, CURRENCY_CODE, ITEM_GROUP_ID, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BALANCE_STATEMENT_SLIP_N3 ON FI_BALANCE_STATEMENT_SLIP(GL_DATE, ACCOUNT_CONTROL_ID, SOB_ID) TABLESPACE FCM_TS_IDX;
