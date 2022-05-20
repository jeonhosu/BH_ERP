/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_SLIP_HEADER_INTERFACE
/* Description  : ��ǥ ��� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_SLIP_HEADER_INTERFACE
( HEADER_INTERFACE_ID             NUMBER        NOT NULL,
  SLIP_DATE                       DATE          NOT NULL,      -- ��ǥ����.
  SLIP_NUM                        VARCHAR2(30)  NOT NULL,      -- ��ǥ��ȣ.
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  DEPT_ID                         NUMBER        NOT NULL,      -- ���Ǻμ�.
  PERSON_ID                       NUMBER        NOT NULL,      -- ������.
  BUDGET_DEPT_ID                  NUMBER        ,              -- ���� �μ�.
  ACCOUNT_BOOK_ID                 NUMBER        NOT NULL,      -- ȸ�����ID.
  SLIP_TYPE                       VARCHAR2(10)  NOT NULL,      -- ��ǥ����.
  JOURNAL_HEADER_ID               NUMBER        DEFAULT 0,     -- �ڵ��а����� ID.
  GL_DATE                         DATE          ,
  GL_NUM                          VARCHAR2(30)  ,
  GL_AMOUNT                       NUMBER        DEFAULT 0,     -- ��ǥ�ݾ�.  
  CURRENCY_CODE                   VARCHAR2(10)  ,              -- ��ȭ.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,     -- ȯ��.
  GL_CURRENCY_AMOUNT              NUMBER        DEFAULT 0,     -- ��ȭ�ݾ�.  
  REQ_BANK_ACCOUNT_ID             NUMBER        ,              -- ������� ID
  REQ_PAYABLE_TYPE                VARCHAR2(10)  ,              -- ���޿�û���(����, ����...).
  REQ_PAYABLE_DATE                DATE          ,              -- ���޿�û��
  REMARK                          VARCHAR2(150) ,              -- ����
  SUB_REMARK                      VARCHAR2(150) ,              -- �ݾ� Ŀ��Ʈ.
  SUBSTANCE                       NVARCHAR2(2000),             -- ����.
  TRANSFER_YN                     CHAR(1)       DEFAULT 'N',   -- �а� ����Y/N.
  TRANSFER_DATE                   DATE          ,              -- �а� ��������.
  TRANSFER_PERSON_ID              NUMBER        ,              -- �а� ����ó����.
  CONFIRM_YN                      CHAR(1)       DEFAULT 'N',   -- ���ο���.
  CONFIRM_DATE                    DATE          ,              -- ��������.
  CONFIRM_PERSON_ID               NUMBER        ,              -- ������.    
  SOURCE_TABLE                    VARCHAR2(100) ,
  SOURCE_HEADER_ID                NUMBER        ,
  ATTRIUTE_A                      VARCHAR2(100) ,
  ATTRIUTE_B                      VARCHAR2(100) ,
  ATTRIUTE_C                      VARCHAR2(100) ,
  ATTRIUTE_D                      VARCHAR2(100) ,
  ATTRIUTE_E                      VARCHAR2(100) ,
  ATTRIUTE_1                      NUMBER        ,
  ATTRIUTE_2                      NUMBER        ,
  ATTRIUTE_3                      NUMBER        ,
  ATTRIUTE_4                      NUMBER        ,
  ATTRIUTE_5                      NUMBER        ,
  CREATION_DATE                   DATE          NOT NULL,      -- ������
  CREATED_BY                      NUMBER        NOT NULL,      -- ������
  LAST_UPDATE_DATE                DATE          NOT NULL,      -- ������
  LAST_UPDATED_BY                 NUMBER        NOT NULL       -- ������
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_SLIP_HEADER_INTERFACE IS '��ǥ �������̽� HEADER';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.HEADER_INTERFACE_ID IS '��ǥ ��� �������̽� ID';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.SLIP_DATE IS '��ǥ����';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.SLIP_NUM IS '��ǥ��ȣ';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.DEPT_ID IS '���Ǻμ�';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.PERSON_ID IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.BUDGET_DEPT_ID IS '����μ�';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.ACCOUNT_BOOK_ID IS 'ȸ�����ID';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.SLIP_TYPE IS '��ǥ����';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.JOURNAL_HEADER_ID IS '�ڵ��а�����ID';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.GL_AMOUNT IS '��ǥ �ݾ�';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.GL_CURRENCY_AMOUNT IS '��ȭ�ݾ�';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.REQ_BANK_ACCOUNT_ID IS '���޻� �������';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.REQ_PAYABLE_TYPE IS '���� ��û���(����, ����...)';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.REQ_PAYABLE_DATE IS '���� ��û��';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.REMARK IS '����';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.SUB_REMARK IS '�ݾ� ����';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.SUBSTANCE IS '����';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.TRANSFER_YN IS '�а� ���� Y/N';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.TRANSFER_DATE IS '�а� ��������';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.TRANSFER_PERSON_ID IS '�а� ����ó����';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.CONFIRM_YN IS '���ο���';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.CONFIRM_DATE IS '��������';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.CONFIRM_PERSON_ID IS '����ó����';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.SOURCE_TABLE IS 'INTERFACE �ҽ����̺�';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.SOURCE_HEADER_ID IS 'INTERFACE �ҽ� HEADER ID';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.CREATION_DATE IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.CREATED_BY IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.LAST_UPDATE_DATE IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.LAST_UPDATED_BY IS '������';

-- PRIMARY KEY
CREATE UNIQUE INDEX FI_SLIP_HEADER_INTERFACE_PK ON 
  FI_SLIP_HEADER_INTERFACE(HEADER_INTERFACE_ID)
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

ALTER TABLE FI_SLIP_HEADER_INTERFACE ADD ( 
  CONSTRAINT FI_SLIP_HEADER_INTERFACE_PK PRIMARY KEY ( HEADER_INTERFACE_ID ) 
        );
        
-- UNIQUE INDEX.
CREATE UNIQUE INDEX FI_SLIP_HEADER_INTERFACE_U1 ON FI_SLIP_HEADER_INTERFACE(SOB_ID, SLIP_NUM) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_HEADER_INTERFACE_N1 ON FI_SLIP_HEADER_INTERFACE(SOB_ID, SLIP_DATE) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE FI_SLIP_HEADER_INTERFACE_S1;
       
