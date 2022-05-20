/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_ACCT_MGMT_BALANCE_ITEM
/* Description  :  ���� �� �����׸� �ϰ踶�� ���̺�.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_ACCT_MGMT_BALANCE_ITEM
( ACCT_MGMT_BALANCE_ID        NUMBER        NOT NULL,  -- ���������׸� �ܾ� ID
  SOB_ID                      NUMBER        NOT NULL,
  BALANCE_ITEM_SEQ            NUMBER        DEFAULT 1, -- �Ϸù�ȣ.
  MANAGEMENT_ID               NUMBER        NOT NULL,  -- �����׸�ID
  MANAGEMENT_CODE             VARCHAR2(20)  NOT NULL,  -- �����׸��ڵ�
  MANAGEMENT_VALUE            VARCHAR2(100) NOT NULL,  -- �����׸� ��.
  MANGEMENT_TAG               VARCHAR2(100) ,   
  DESCRIPTION                 VARCHAR2(150) ,
  ATTRIBUTE_A                 VARCHAR2(150) ,
  ATTRIBUTE_B                 VARCHAR2(150) ,
  ATTRIBUTE_C                 VARCHAR2(150) ,
  ATTRIBUTE_1                 NUMBER        ,
  ATTRIBUTE_2                 NUMBER        ,
  ATTRIBUTE_3                 NUMBER        ,
  CREATION_DATE               DATE          NOT NULL,  -- ������.
  CREATED_BY                  NUMBER        NOT NULL,  -- ������.
  LAST_UPDATE_DATE            DATE          NOT NULL,  -- ������.
  LAST_UPDATED_BY             NUMBER        NOT NULL   -- ������.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_ACCT_MGMT_BALANCE_ITEM IS '�ϰ踶�����̺�';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE_ITEM.ACCT_MGMT_BALANCE_ID IS '���������׸� �ܾ� ID';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE_ITEM.SOB_ID IS 'ȸ��ID';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE_ITEM.BALANCE_ITEM_SEQ IS '�����׸� ����';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE_ITEM.MANAGEMENT_ID IS '�����׸� ID';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE_ITEM.MANAGEMENT_CODE IS '�����׸�CODE';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE_ITEM.MANAGEMENT_VALUE IS '�����׸� ��';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE_ITEM.MANGEMENT_TAG IS '�����׸� TAG';

CREATE UNIQUE INDEX FI_ACCT_MGMT_BALANCE_ITEM_PK ON 
  FI_ACCT_MGMT_BALANCE_ITEM(ACCT_MGMT_BALANCE_ID, SOB_ID, MANAGEMENT_ID, MANAGEMENT_VALUE)
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

ALTER TABLE FI_ACCT_MGMT_BALANCE_ITEM ADD ( 
  CONSTRAINT FI_ACCT_MGMT_BALANCE_ITEM_PK PRIMARY KEY (ACCT_MGMT_BALANCE_ID, SOB_ID, MANAGEMENT_ID, MANAGEMENT_VALUE)
        );

CREATE UNIQUE INDEX FI_ACCT_MGMT_BALANCE_ITEM_U1 ON FI_ACCT_MGMT_BALANCE_ITEM(ACCT_MGMT_BALANCE_ID, SOB_ID, BALANCE_ITEM_SEQ) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_ACCT_MGMT_BALANCE_ITEM_N1 ON FI_ACCT_MGMT_BALANCE_ITEM(MANAGEMENT_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_ACCT_MGMT_BALANCE_ITEM_N2 ON FI_ACCT_MGMT_BALANCE_ITEM(MANAGEMENT_VALUE, SOB_ID) TABLESPACE FCM_TS_IDX;
