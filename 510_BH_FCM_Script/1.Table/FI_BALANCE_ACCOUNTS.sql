/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BALANCE_ACCOUNTS
/* Description  : �����ܾ׸��� ��������
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BALANCE_ACCOUNTS
( ACCOUNT_CONTROL_ID          NUMBER        NOT NULL,    -- ��������ID. 
  ACCOUNT_CODE                VARCHAR2(20)  NOT NULL,    -- �����ڵ�.
  SOB_ID                      NUMBER        NOT NULL,    
  CONTROL_CURRENCY_YN         VARCHAR2(1)   DEFAULT 'N',  -- ��ȭ����.
  ESTIMATE_YN                 VARCHAR2(1)   DEFAULT 'N',  -- ȯ��.
  DESCRIPTION                 VARCHAR2(200) ,
  ENABLED_FLAG                VARCHAR2(1)   DEFAULT 'Y',
  EFFECTIVE_DATE_FR           DATE          NOT NULL,
  EFFECTIVE_DATE_TO           DATE          ,
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

COMMENT ON TABLE FI_BALANCE_ACCOUNTS IS '�����ܾ׸��� ��������';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS.SOB_ID IS 'ȸ��ID';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS.CONTROL_CURRENCY_YN IS '��ȭ���� ����';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS.ESTIMATE_YN IS 'ȯ�� ���뿩��';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS.DESCRIPTION IS '���';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS.ENABLED_FLAG IS '��� ����';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS.EFFECTIVE_DATE_FR IS '���� ��������';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS.EFFECTIVE_DATE_TO IS '���� ��������';

-- INDEX.
ALTER TABLE FI_BALANCE_ACCOUNTS ADD CONSTRAINT FI_BALANCE_ACCOUNTS PRIMARY KEY(ACCOUNT_CONTROL_ID);

CREATE UNIQUE INDEX FI_BALANCE_ACCOUNTS_U1 ON FI_BALANCE_ACCOUNTS(ACCOUNT_CODE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BALANCE_ACCOUNTS_N1 ON FI_BALANCE_ACCOUNTS(SOB_ID, ESTIMATE_YN, ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BALANCE_ACCOUNTS_N2 ON FI_BALANCE_ACCOUNTS(SOB_ID, ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;
