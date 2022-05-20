/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_LENT_MASTER
/* Description  : ���� �뿩�� Master.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_LENT_MASTER 
( LENT_ID                         NUMBER        NOT NULL,       -- �뿩�ݹ�ȣID.
  LENT_NUM                        VARCHAR2(30)  NOT NULL,       -- �뿩�ݰ�����ȣ.
  SOB_ID                          NUMBER        NOT NULL,       -- ȸ������.
	ORG_ID                          NUMBER        NOT NULL,       -- �����ID.	
  LENT_CLASS                      VARCHAR2(10)  NOT NULL,       -- �뿩������.
  BANK_ID                         NUMBER        NOT NULL,       -- �ŷ�����(�뿩ó).
  ACCOUNT_CONTROL_ID              NUMBER        NOT NULL,       -- ���������ڵ�ID.
  ACCOUNT_CODE                    VARCHAR2(10)  NOT NULL,       -- ���������ڵ�.  
  ISSUE_DATE                      DATE          NOT NULL,       -- �뿩����.
  DUE_DATE                        DATE          NOT NULL,       -- ��������.
  LENT_AMOUNT                     NUMBER(12)    DEFAULT 0,      -- �뿩��.
  REMAIN_AMOUNT                   NUMBER(12)    DEFAULT 0,      -- ��ȯ��.
  INTEREST_RATE                   NUMBER(7,4)   DEFAULT 0,      -- ������.
  INTEREST_RATE_TYPE              VARCHAR2(10)  NOT NULL,       -- �������޹��.
  INTEREST_START_DATE             DATE          ,               -- �������޽�����.
  INTEREST_DUE_DATE               DATE          ,               -- �������޸�����.
  CLOSING_DATE                    DATE          ,               -- ���ݻ�ȯ��.  
  LENT_CLOSE_YN                   CHAR(1)       NOT NULL,       -- ���ݻ�ȯ�ϷῩ��.
  BILL_NUM                        VARCHAR2(30)  ,               -- ������ȣ.  
  CREATION_DATE                   DATE          NOT NULL,
  CREATED_BY                      NUMBER        NOT NULL,
  LAST_UPDATE_DATE                DATE          NOT NULL,
  LAST_UPDATED_BY                 NUMBER        NOT NULL 
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_LENT_MASTER IS '�����뿩��';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.LENT_ID IS '�뿩�ݹ�ȣID';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.LENT_NUM IS '�뿩�ݰ�����ȣ';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.SOB_ID IS 'ȸ������';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.ORG_ID IS '�����ID';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.LENT_CLASS IS '�뿩������';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.BANK_ID IS '�ŷ�����(�뿩ó)';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.ACCOUNT_CONTROL_ID IS '���������ڵ�ID';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.ACCOUNT_CODE IS '���������ڵ�';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.ISSUE_DATE IS '�뿩����';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.DUE_DATE IS '��������';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.LENT_AMOUNT IS '�뿩��';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.REMAIN_AMOUNT IS '��ȯ��';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.INTEREST_RATE IS '������';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.INTEREST_RATE_TYPE IS '�������޹��';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.INTEREST_START_DATE IS '�������޽�����';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.INTEREST_DUE_DATE IS '�������޸�����';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.CLOSING_DATE IS '���ݻ�ȯ��';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.LENT_CLOSE_YN IS '���ݻ�ȯ�ϷῩ��';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.BILL_NUM IS '������ȣ';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.CREATION_DATE IS '����DATA��������';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.CREATED_BY IS '����DATA����USER';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.LAST_UPDATE_DATE IS '����DATA��������';
COMMENT ON COLUMN APPS.FI_LENT_MASTER.LAST_UPDATED_BY IS '����DATA����USER';

CREATE UNIQUE INDEX FI_LENT_MASTER_PK ON 
  FI_LENT_MASTER(LENT_NUM, SOB_ID)
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

ALTER TABLE FI_LENT_MASTER ADD ( 
  CONSTRAINT FI_LENT_MASTER_PK PRIMARY KEY (LENT_NUM, SOB_ID)
        );

CREATE UNIQUE INDEX FI_LENT_MASTER_U1 ON 
  FI_LENT_MASTER(LENT_ID)
  TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE FI_LENT_MASTER_S1;
CREATE SEQUENCE FI_LENT_MASTER_S1;
