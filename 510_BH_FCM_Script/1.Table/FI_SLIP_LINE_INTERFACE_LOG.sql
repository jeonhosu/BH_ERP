/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_SLIP_LINE_INTERFACE_LOG_LOG
/* Description  : ��ǥ ���� �������̽� �α� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_SLIP_LINE_INTERFACE_LOG
( LINE_INTERFACE_ID               NUMBER        NOT NULL,      -- ��ǥ ���� �������̽� ID.
  SLIP_DATE                       DATE          NOT NULL,      -- ��ǥ����.
  SLIP_NUM                        VARCHAR2(30)  NOT NULL,      -- ��ǥ��ȣ.
  SLIP_LINE_SEQ                   NUMBER        NOT NULL,      -- ��ǥ���ȣ.
  HEADER_INTERFACE_ID             NUMBER        NOT NULL,      -- ��ǥ HEADER �������̽� ID.    
  SOB_ID                          NUMBER        NOT NULL,      -- ȸ������.
  ORG_ID                          NUMBER        NOT NULL,      -- �����ID.  
  DEPT_ID                         NUMBER        NOT NULL,      -- ���Ǻμ�.
  PERSON_ID                       NUMBER        NOT NULL,      -- ������.
  BUDGET_DEPT_ID                  NUMBER        ,              -- ���� �μ�.  
  ACCOUNT_BOOK_ID                 NUMBER        NOT NULL,      -- ȸ�����ID.
  SLIP_TYPE                       VARCHAR2(10)  NOT NULL,      -- ��ǥ����.
  JOURNAL_HEADER_ID               NUMBER        DEFAULT 0,     -- �ڵ��а����� ID.
  CUSTOMER_ID                     NUMBER        ,              -- �ŷ�óID
  ACCOUNT_CONTROL_ID              NUMBER        NOT NULL,       
  ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL,      
  COST_CENTER_ID                  NUMBER        ,     
  ACCOUNT_DR_CR                   VARCHAR2(2)   NOT NULL,     
  GL_AMOUNT                       NUMBER        DEFAULT 0, 
  CURRENCY_CODE                   VARCHAR2(10)  ,              -- ��ȭ.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,     -- ȯ��.
  GL_CURRENCY_AMOUNT              NUMBER        DEFAULT 0,     -- ��ȭ�ݾ�.
  BANK_ACCOUNT_ID                 NUMBER        ,              -- ����ID.
  MANAGEMENT1                     VARCHAR2(50)  ,               -- �ܾװ����׸��ڵ�1.
  MANAGEMENT2                     VARCHAR2(50)  ,               -- �ܾװ����׸��ڵ�2.
  REFER1                          VARCHAR2(50)  ,               -- �����׸��ڵ�1.
  REFER2                          VARCHAR2(50)  ,               -- �����׸��ڵ�2.
  REFER3                          VARCHAR2(50)  ,               -- �����׸��ڵ�3.
  REFER4                          VARCHAR2(50)  ,               -- �����׸��ڵ�4.
  REFER5                          VARCHAR2(50)  ,               -- �����׸��ڵ�5.
  REFER6                          VARCHAR2(50)  ,               -- �����׸��ڵ�6.
  REFER7                          VARCHAR2(50)  ,               -- �����׸��ڵ�7.
  REFER8                          VARCHAR2(50)  ,               -- �����׸��ڵ�8.
  REFER9                          VARCHAR2(50)  ,               -- �����׸��ڵ�9.
  VOUCH_CODE                      VARCHAR2(50)  ,               -- �������� ID.
  REFER_RATE                      NUMBER        ,               -- �������ڵ�.
  REFER_AMOUNT                    NUMBER        ,               -- �����ݾ��ڵ�.
  REFER_DATE1                     DATE          ,               -- ���������ڵ�1.
  REFER_DATE2                     DATE          ,               -- ���������ڵ�2 .   
  REMARK                          VARCHAR2(100) ,               -- ����.
  FUND_CODE                       VARCHAR2(10)  ,               -- �ڱ��ڵ�(FUND_CODE).
  UNIT_PRICE                      NUMBER        DEFAULT 0,      -- �ܰ�.
  UOM_CODE                        VARCHAR2(10)  ,               -- UOM.
  UOM_QUANTITY                    NUMBER        DEFAULT 0,      -- ����.
  UOM_WEIGHT                      NUMBER        DEFAULT 0,      -- �߷�.
  INVENTORY_ITEM_ID               NUMBER        ,               -- INTEM ID.
  TRANSFER_YN                     CHAR(1)       DEFAULT 'N',    -- �а� ����Y/N.
  TRANSFER_DATE                   DATE          ,               -- �а� ��������.
  TRANSFER_PERSON_ID              NUMBER        ,               -- �а� ����ó����.
  CONFIRM_YN                      CHAR(1)       DEFAULT 'N',    -- ���ο���.
  CONFIRM_DATE                    DATE          ,               -- ��������.
  CONFIRM_PERSON_ID               NUMBER        ,               -- ������.    
  SOURCE_TABLE                    VARCHAR2(100) ,
  SOURCE_HEADER_ID                NUMBER        ,
  SOURCE_LINE_ID                  NUMBER        ,  
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
  CREATION_DATE                   DATE          NOT NULL,      -- ������.
  CREATED_BY                      NUMBER        NOT NULL,      -- ������.
  LAST_UPDATE_DATE                DATE          NOT NULL,      -- ������.
  LAST_UPDATED_BY                 NUMBER        NOT NULL       -- ������.
  DELETED_DATE                    DATE          ,
  DELETED_BY                      NUMBER        
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE  FI_SLIP_LINE_INTERFACE_LOG IS 'ȸ����ǥ(GL) LINE INTERFACE ���� �α�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.LINE_INTERFACE_ID IS '��ǥ ���� ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.SLIP_DATE IS '��ǥ����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.SLIP_NUM IS '��ǥ��ȣ';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.SLIP_LINE_SEQ IS '��ǥ ���ι�ȣ';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.HEADER_INTERFACE_ID IS '��ǥ ��� �������̽� ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.DEPT_ID IS '���Ǻμ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.PERSON_ID IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.BUDGET_DEPT_ID IS '����μ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.ACCOUNT_BOOK_ID IS 'ȸ�����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.SLIP_TYPE IS '��ǥ����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.JOURNAL_HEADER_ID IS '�ڵ��а����� ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.CUSTOMER_ID IS '�ŷ�óID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.COST_CENTER_ID IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.ACCOUNT_DR_CR  IS '���뱸��(0-��, 1-��)';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.GL_AMOUNT IS '��ǥ �ݾ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.GL_CURRENCY_AMOUNT IS '��ȭ�ݾ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.BANK_ACCOUNT_ID IS '����ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.MANAGEMENT1 IS '�ܾװ����׸�1';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.MANAGEMENT2 IS '�ܾװ����׸�2';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.REFER1 IS '�����׸�1~9';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.VOUCH_CODE IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.REFER_RATE IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.REFER_AMOUNT IS '�����ݾ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.REFER_DATE1 IS '��������1';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.REFER_DATE2 IS '��������2';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.REMARK IS '����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.TRANSFER_YN IS '�а� ���� Y/N';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.TRANSFER_DATE IS '�а� ��������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.TRANSFER_PERSON_ID IS '�а� ����ó����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.CONFIRM_YN IS '���ο���';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.CONFIRM_DATE IS '��������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.CONFIRM_PERSON_ID IS '����ó����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.SOURCE_TABLE IS 'INTERFACE �ҽ����̺�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.SOURCE_HEADER_ID IS 'INTERFACE �ҽ� HEADER ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.SOURCE_LINE_ID IS 'INTERFACE �ҽ� LINE ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.FUND_CODE IS '�ڱ��ڵ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.UNIT_PRICE IS '�ܰ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.UOM_CODE IS '����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.UOM_QUANTITY IS '����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.UOM_WEIGHT IS '�߷�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.INVENTORY_ITEM_ID IS 'Inventory Item ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.CREATION_DATE IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.CREATED_BY IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.LAST_UPDATE_DATE IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.LAST_UPDATED_BY IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.DELETED_DATE IS '�����Ͻ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_LOG.DELETED_BY IS '����ó����';

CREATE INDEX FI_SLIP_LINE_INTERFACE_LOG_N1 ON FI_SLIP_LINE_INTERFACE_LOG(SOB_ID, SLIP_NUM) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_LINE_INTERFACE_LOG_N2 ON FI_SLIP_LINE_INTERFACE_LOG(SOB_ID, SLIP_DATE) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_LINE_INTERFACE_LOG_N3 ON FI_SLIP_LINE_INTERFACE_LOG(HEADER_INTERFACE_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_LINE_INTERFACE_LOG_N4 ON FI_SLIP_LINE_INTERFACE_LOG(LINE_INTERFACE_ID) TABLESPACE FCM_TS_IDX;

       
