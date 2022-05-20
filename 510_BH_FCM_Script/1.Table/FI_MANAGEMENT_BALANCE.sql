/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_MANAGEMENT_BALANCE
/* Description  : ������ �����׸� ���ں� �ݾ�.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_MANAGEMENT_BALANCE
( GL_DATE                     DATE          NOT NULL,  -- ȸ������.
  GL_DATE_SEQ                 NUMBER        DEFAULT 1,  -- �����Ϸù�ȣ.
  SOB_ID                      NUMBER        NOT NULL,  -- ȸ���ڵ�.
  ORG_ID                      NUMBER        NOT NULL,  -- �����ID.
  ACCOUNT_CONTROL_ID          NUMBER        NOT NULL,  -- ��������ID. 
  MANAGEMENT_ID               NUMBER        NOT NULL,  -- �����׸� ID.    
  MANAGEMENT_VALUE            VARCHAR2(50)  NOT NULL,  -- �����׸� ��.
  DR_SUM                      NUMBER        DEFAULT 0, -- �����հ�.
  CR_SUM                      NUMBER        DEFAULT 0, -- �뺯�հ�.
  CURRENCY_CODE               VARCHAR2(10)  ,          -- ��ȭ.
  OLD_EXCHANGE_RATE           NUMBER        DEFAULT 0,  -- ���� ȯ��.
  EXCHANGE_RATE               NUMBER        DEFAULT 0,  -- ȯ��.
  DR_CURR_SUM                 NUMBER        DEFAULT 0, -- �����հ�(��ȭ).
  CR_CURR_SUM                 NUMBER        DEFAULT 0, -- �뺯�հ�(��ȭ).
  ACCOUNT_CODE                VARCHAR2(20)  NOT NULL,  -- �����ڵ�.
  MANAGEMENT_CODE             VARCHAR2(10)  NOT NULL,  -- �����׸� �ڵ�.
  ATTRIBUTE_A	                VARCHAR2(250)	,		
  ATTRIBUTE_B	                VARCHAR2(250)	,		
  ATTRIBUTE_C	                VARCHAR2(250)	,		
  ATTRIBUTE_D	                VARCHAR2(250)	,		
  ATTRIBUTE_E	                VARCHAR2(250)	,		
  ATTRIBUTE_1	                NUMBER	      ,		
  ATTRIBUTE_2	                NUMBER	      ,		
  ATTRIBUTE_3	                NUMBER	      ,		
  ATTRIBUTE_4	                NUMBER	      ,
  ATTRIBUTE_5	                NUMBER	      ,
  CREATION_DATE               DATE          NOT NULL,  -- ������.
  CREATED_BY                  NUMBER        NOT NULL,  -- ������.
  LAST_UPDATE_DATE            DATE          NOT NULL,  -- ������.
  LAST_UPDATED_BY             NUMBER        NOT NULL   -- ������.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_MANAGEMENT_BALANCE IS '������ �����׸� ���ں� �ݾ�';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.GL_DATE IS 'ȸ������';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.GL_DATE_SEQ IS '0=�����̿��ܾ� 1=����߻�';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.SOB_ID IS 'ȸ��ID';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.MANAGEMENT_ID IS '�����׸�ID';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.MANAGEMENT_VALUE IS '�����׸� ��';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.DR_SUM IS '�����հ�';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.CR_SUM IS '�뺯�հ�';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.OLD_EXCHANGE_RATE IS '���� ȯ��';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.DR_CURR_SUM IS '�����հ�(��ȭ)';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.CR_CURR_SUM IS '�뺯�հ�(��ȭ)';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN FI_MANAGEMENT_BALANCE.MANAGEMENT_CODE IS '�����׸��ڵ�';

CREATE UNIQUE INDEX FI_MANAGEMENT_BALANCE_U1 ON FI_MANAGEMENT_BALANCE(GL_DATE, GL_DATE_SEQ, SOB_ID, ACCOUNT_CONTROL_ID, MANAGEMENT_ID, MANAGEMENT_VALUE, CURRENCY_CODE) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_MANAGEMENT_BALANCE_N1 ON FI_MANAGEMENT_BALANCE(GL_DATE_SEQ, SOB_ID, NVL(DR_SUM, 0), NVL(CR_SUM, 0), NVL(DR_CURR_SUM, 0), NVL(CR_CURR_SUM, 0)) TABLESPACE FCM_TS_IDX;
