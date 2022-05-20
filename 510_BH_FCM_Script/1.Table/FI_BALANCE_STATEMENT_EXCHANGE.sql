/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BALANCE_STATEMENT_EXCHANGE_EXCHANGE
/* Description  : �����ܾ׸��� �ܾ� ���� - ��ȭ ���� ���� ȯ������
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BALANCE_STATEMENT_EXCHANGE
( GL_DATE                     DATE          NOT NULL,    -- �ܾ�����.
  CURRENCY_CODE               VARCHAR2(20)  NOT NULL,    -- ��ȭ.
  SOB_ID                      NUMBER        NOT NULL,
  EXCHANGE_RATE               NUMBER        DEFAULT 0,   -- ȯ��ȯ��.
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

COMMENT ON TABLE FI_BALANCE_STATEMENT_EXCHANGE IS '�����ܾ׸��� : ��ȭ���� ���� ȯ������';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_EXCHANGE.GL_DATE IS 'ȯ������';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_EXCHANGE.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_EXCHANGE.SOB_ID IS 'ȸ��ID';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_EXCHANGE.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_EXCHANGE.DESCRIPTION IS '���';

-- INDEX.
ALTER TABLE FI_BALANCE_STATEMENT_EXCHANGE ADD CONSTRAINT FI_BALANCE_STATEMENT_EXCHANGE PRIMARY KEY(GL_DATE, CURRENCY_CODE, SOB_ID);
