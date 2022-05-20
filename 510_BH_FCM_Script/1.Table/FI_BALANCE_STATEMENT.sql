/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BALANCE_STATEMENT
/* Description  : �����ܾ׸��� �ܾ� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BALANCE_STATEMENT
( GL_DATE                     DATE          NOT NULL,    -- �ܾ�����.
  GL_DATE_SEQ                 NUMBER        DEFAULT 1,   -- �ܾ����� �߻�����
  ACCOUNT_CONTROL_ID          NUMBER        NOT NULL,    -- ��������ID. 
  ACCOUNT_CODE                VARCHAR2(20)  NOT NULL,    -- �����ڵ�.  
  CURRENCY_CODE               VARCHAR2(20)  NOT NULL,    -- ��ȭ.
  ITEM_GROUP_ID               NUMBER        DEFAULT 1,   -- �����׸� �׷� ID
  SOB_ID                      NUMBER        NOT NULL,
  FORWARD_AMOUNT              NUMBER        DEFAULT 0,   -- �̿��ݾ�.
  INCREASE_AMOUNT             NUMBER        DEFAULT 0,   -- �����ݾ�
  DECREASE_AMOUNT             NUMBER        DEFAULT 0,   -- ���ұݾ�.
  REMAIN_AMOUNT               NUMBER        DEFAULT 0,   -- �ܾױݾ�.
  CURR_FORWARD_AMOUNT         NUMBER        DEFAULT 0,   -- ��ȭ �̿��ݾ�.
  CURR_INCREASE_AMOUNT        NUMBER        DEFAULT 0,   -- ��ȭ �����ݾ�.
  CURR_DECREASE_AMOUNT        NUMBER        DEFAULT 0,   -- ��ȭ ���ұݾ�.
  CURR_REMAIN_AMOUNT          NUMBER        DEFAULT 0,   -- ��ȭ �ܾױݾ�.
  NEW_EXCHANGE_RATE           NUMBER        DEFAULT 0,   -- ȯ��ȯ��.
  NEW_REMAIN_AMOUNT           NUMBER        DEFAULT 0,   -- ȯ��ݾ�.
  ESTIMATE_DATE               DATE          ,            -- ȯ�� �� ����.
  ESTIMATE_PERSON_ID          NUMBER        ,            -- ȯ�� �� ó����.
  CARRY_FORWARD_YN            VARCHAR2(1)   DEFAULT 'N',  -- �ܾ��̿� ����.
  CLOSED_YN                   CHAR(1)       DEFAULT 'N',  -- ��������.
  CLOSED_DATE                 DATE          ,             -- ����ó������.
  CLOSED_PERSON_ID            NUMBER        ,             -- ����ó����.
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

COMMENT ON TABLE FI_BALANCE_STATEMENT IS '�����ܾ׸��� �ܾ� ����';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.GL_DATE IS '�ܾ�����';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.GL_DATE_SEQ IS '�ܾ����� �߻�����(0-�̿��ݾ�, 1-�߻��ݾ�)';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.ITEM_GROUP_ID IS '�����׸� �׷� ID';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.SOB_ID IS 'ȸ��ID';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.FORWARD_AMOUNT IS '�̿� �ݾ�';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.INCREASE_AMOUNT IS '���� �ݾ�';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.DECREASE_AMOUNT IS '���� �ݾ�';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.REMAIN_AMOUNT IS '�ܾ� �ݾ�';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.CURR_FORWARD_AMOUNT IS '��ȭ �̿��ݾ�';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.CURR_INCREASE_AMOUNT IS '��ȭ �����ݾ�';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.CURR_DECREASE_AMOUNT IS '��ȭ ���ұݾ�';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.CURR_REMAIN_AMOUNT IS '��ȭ �ܾױݾ�';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.NEW_EXCHANGE_RATE IS 'ȯ�� ȯ��';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.NEW_REMAIN_AMOUNT IS 'ȯ�� �ݾ�';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.ESTIMATE_DATE IS 'ȯ���� �Ͻ�';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.ESTIMATE_PERSON_ID IS 'ȯ���� ó����';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.CARRY_FORWARD_YN IS '�ܾ��̿� ����';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.CLOSED_YN IS '���� ����';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.CLOSED_DATE IS '���� �Ͻ�';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.CLOSED_PERSON_ID IS '���� ó����';
COMMENT ON COLUMN FI_BALANCE_STATEMENT.DESCRIPTION IS '���';

-- INDEX.
ALTER TABLE FI_BALANCE_STATEMENT ADD CONSTRAINT FI_BALANCE_STATEMENT PRIMARY KEY(GL_DATE, GL_DATE_SEQ, ACCOUNT_CONTROL_ID, CURRENCY_CODE, ITEM_GROUP_ID, SOB_ID);

CREATE INDEX FI_BALANCE_STATEMENT_N1 ON FI_BALANCE_STATEMENT(GL_DATE, GL_DATE_SEQ, ACCOUNT_CODE, CURRENCY_CODE, ITEM_GROUP_ID, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BALANCE_STATEMENT_N2 ON FI_BALANCE_STATEMENT(GL_DATE, GL_DATE_SEQ, ACCOUNT_CONTROL_ID, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BALANCE_STATEMENT_N3 ON FI_BALANCE_STATEMENT(GL_DATE, GL_DATE_SEQ, ACCOUNT_CONTROL_ID, REMAIN_AMOUNT, CURR_REMAIN_AMOUNT, SOB_ID) TABLESPACE FCM_TS_IDX;
