/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_SLIP_LINE_INTERFACE_TEMP
/* Description  : ��ǥ ���� �������̽� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_SLIP_LINE_INTERFACE_TEMP
( SLIP_DATE                       DATE          NOT NULL,      -- ��ǥ����.
  SLIP_NUM                        VARCHAR2(30)  ,              -- ��ǥ��ȣ.
  SLIP_LINE_SEQ                   NUMBER        NOT NULL,      -- ��ǥ���ȣ.
  HEADER_INTERFACE_ID             NUMBER        ,              -- ��ǥ HEADER �������̽� ID.    
  SOB_ID                          NUMBER        NOT NULL,      -- ȸ������.
  ORG_ID                          NUMBER        NOT NULL,      -- �����ID.  
  DEPT_ID                         NUMBER        ,              -- ���Ǻμ�.
  PERSON_ID                       NUMBER        ,              -- ������.
  BUDGET_DEPT_ID                  NUMBER        ,              -- ���� �μ�.  
  PERSON_NUM                      VARCHAR2(20)  ,              -- �����ȣ.
  ACCOUNT_BOOK_ID                 NUMBER        ,              -- ȸ�����ID.
  SLIP_TYPE                       VARCHAR2(10)  NOT NULL,      -- ��ǥ����.
  JOURNAL_HEADER_ID               NUMBER        DEFAULT 0,     -- �ڵ��а����� ID.
  ACCOUNT_CONTROL_ID              NUMBER        ,       
  ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL,
  ACCOUNT_DESC                    VARCHAR2(200) ,
  ACCOUNT_DR_CR                   VARCHAR2(2)   NOT NULL,     
  GL_AMOUNT                       NUMBER        DEFAULT 0, 
  CURRENCY_CODE                   VARCHAR2(10)  NOT NULL,      -- ��ȭ.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,     -- ȯ��.
  GL_CURRENCY_AMOUNT              NUMBER        DEFAULT 0,     -- ��ȭ�ݾ�.
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
  REFER10                         VARCHAR2(50)  ,               -- �����׸��ڵ�10.
  REFER11                         VARCHAR2(50)  ,               -- �����׸��ڵ�11.
  REFER12                         VARCHAR2(50)  ,               -- �����׸��ڵ�12.  
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
  ATTRIUTE_5                      NUMBER
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE  FI_SLIP_LINE_INTERFACE_TEMP IS 'ȸ����ǥ(GL) LINE INTERFACE';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.SLIP_DATE IS '��ǥ����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.SLIP_NUM IS '��ǥ��ȣ';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.SLIP_LINE_SEQ IS '��ǥ ���ι�ȣ';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.HEADER_INTERFACE_ID IS '��ǥ ��� �������̽� ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.DEPT_ID IS '���Ǻμ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.PERSON_ID IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.BUDGET_DEPT_ID IS '����μ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.PERSON_NUM IS '�����ȣ';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.ACCOUNT_BOOK_ID IS 'ȸ�����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.SLIP_TYPE IS '��ǥ����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.JOURNAL_HEADER_ID IS '�ڵ��а����� ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.ACCOUNT_DR_CR  IS '���뱸��(0-��, 1-��)';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.GL_AMOUNT IS '��ǥ �ݾ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.GL_CURRENCY_AMOUNT IS '��ȭ�ݾ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.MANAGEMENT1 IS '�ܾװ����׸�1';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.MANAGEMENT2 IS '�ܾװ����׸�2';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.REFER1 IS '�����׸�1~9';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.VOUCH_CODE IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.REFER_RATE IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.REFER_AMOUNT IS '�����ݾ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.REFER_DATE1 IS '��������1';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.REFER_DATE2 IS '��������2';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.REMARK IS '����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.TRANSFER_YN IS '�а� ���� Y/N';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.TRANSFER_DATE IS '�а� ��������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.TRANSFER_PERSON_ID IS '�а� ����ó����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.CONFIRM_YN IS '���ο���';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.CONFIRM_DATE IS '��������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.CONFIRM_PERSON_ID IS '����ó����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.SOURCE_TABLE IS 'INTERFACE �ҽ����̺�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.SOURCE_HEADER_ID IS 'INTERFACE �ҽ� HEADER ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.SOURCE_LINE_ID IS 'INTERFACE �ҽ� LINE ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.FUND_CODE IS '�ڱ��ڵ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.UNIT_PRICE IS '�ܰ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.UOM_CODE IS '����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.UOM_QUANTITY IS '����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.UOM_WEIGHT IS '�߷�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.INVENTORY_ITEM_ID IS 'Inventory Item ID';
          
CREATE INDEX FI_SLIP_LINE_INTERFACE_TEMP_N1 ON FI_SLIP_LINE_INTERFACE_TEMP(SOB_ID, SLIP_NUM) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_LINE_INTERFACE_TEMP_N2 ON FI_SLIP_LINE_INTERFACE_TEMP(SOB_ID, SLIP_DATE) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_LINE_INTERFACE_TEMP_N3 ON FI_SLIP_LINE_INTERFACE_TEMP(HEADER_INTERFACE_ID) TABLESPACE FCM_TS_IDX;
