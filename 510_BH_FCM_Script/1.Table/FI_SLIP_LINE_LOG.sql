/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_SLIP_LINE_LOG
/* Description  : ��ǥ ���� �α� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_SLIP_LINE_LOG 
( SLIP_LINE_ID                    NUMBER        NOT NULL,      -- ��ǥ ����ID.
  SLIP_DATE                       DATE          NOT NULL,      -- ��ǥ����.
  SLIP_NUM                        VARCHAR2(30)  NOT NULL,      -- ��ǥ��ȣ.
  SLIP_LINE_SEQ                   NUMBER        NOT NULL,      -- ��ǥ���ȣ.
  SLIP_HEADER_ID                  NUMBER        NOT NULL,      -- ��ǥ HEADER ID.    
  SOB_ID                          NUMBER        NOT NULL,      -- ȸ������.
  ORG_ID                          NUMBER        NOT NULL,      -- �����ID.  
  DEPT_ID                         NUMBER        NOT NULL,      -- ���Ǻμ�.
  PERSON_ID                       NUMBER        NOT NULL,      -- ������.
  BUDGET_DEPT_ID                  NUMBER        ,              -- ���� �μ�.  
  ACCOUNT_BOOK_ID                 NUMBER        NOT NULL,      -- ȸ�����ID.
  SLIP_TYPE                       VARCHAR2(10)  NOT NULL,      -- ��ǥ����.
  PERIOD_NAME                     VARCHAR2(10)  NOT NULL,      -- ȸ����.
  CONFIRM_YN                      CHAR(1)       DEFAULT 'N',   -- ���ο���.
  CONFIRM_DATE                    DATE          ,              -- ��������.
  CONFIRM_PERSON_ID               NUMBER        ,              -- ������.  
  GL_DATE                         DATE          ,              -- ȸ������.
  GL_NUM                          VARCHAR2(30)  ,              -- ȸ���ȣ.
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
  REFER9                          VARCHAR2(50)  ,              -- �����׸��ڵ�9.
  VOUCH_CODE                      VARCHAR2(50)  ,               -- �������� ID.
  REFER_RATE                      NUMBER        ,              -- �������ڵ�.
  REFER_AMOUNT                    NUMBER        ,              -- �����ݾ��ڵ�.
  REFER_DATE1                     DATE          ,              -- ���������ڵ�1.
  REFER_DATE2                     DATE          ,              -- ���������ڵ�2 .   
  REMARK                          VARCHAR2(100) ,              -- ����.
  UNLIQUIDATE_SLIP_HEADER_ID      NUMBER        ,
  UNLIQUIDATE_SLIP_LINE_ID        NUMBER        ,
  FUND_CODE                       VARCHAR2(10)  ,              -- �ڱ��ڵ�(FUND_CODE).
  LINE_TYPE                       VARCHAR2(10)  ,  
  CLOSED_YN                       CHAR(1)       DEFAULT 'N',   -- ���ο���.
  CLOSED_DATE                     DATE          ,              -- ��������.
  CLOSED_PERSON_ID                NUMBER        ,              -- ������.
  SOURCE_TABLE                    VARCHAR2(100) ,
  SOURCE_HEADER_ID                NUMBER        ,
  SOURCE_LINE_ID                  NUMBER        ,  
  CREATION_DATE                   DATE          NOT NULL,      -- ������.
  CREATED_BY                      NUMBER        NOT NULL,      -- ������.
  LAST_UPDATE_DATE                DATE          NOT NULL,      -- ������.
  LAST_UPDATED_BY                 NUMBER        NOT NULL       -- ������.
  DELETED_DATE                    DATE          ,
  DELETED_BY                      NUMBER        
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE  FI_SLIP_LINE_LOG IS 'ȸ����ǥ(GL) LINE ���� �α�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.SLIP_LINE_ID IS '��ǥ ���� ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.SLIP_DATE IS '��ǥ����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.SLIP_NUM IS '��ǥ��ȣ';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.SLIP_LINE_SEQ IS '��ǥ ���ι�ȣ';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.SLIP_HEADER_ID IS '��ǥ ��� ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.DEPT_ID IS '���Ǻμ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.PERSON_ID IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.BUDGET_DEPT_ID IS '����μ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.ACCOUNT_BOOK_ID IS 'ȸ�����ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.SLIP_TYPE IS '��ǥ����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.PERIOD_NAME IS 'ȸ����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CONFIRM_YN IS '���ο���';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CONFIRM_DATE IS '��������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CONFIRM_PERSON_ID IS '����ó����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.GL_DATE IS 'ȸ������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.GL_NUM IS 'ȸ���ȣ';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CUSTOMER_ID IS '�ŷ�óID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.COST_CENTER_ID IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.ACCOUNT_DR_CR  IS '���뱸��(0-��, 1-��)';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.GL_AMOUNT IS '��ǥ �ݾ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.GL_CURRENCY_AMOUNT IS '��ȭ�ݾ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.BANK_ACCOUNT_ID IS '����ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.MANAGEMENT1 IS '�ܾװ����׸�1';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.MANAGEMENT2 IS '�ܾװ����׸�2';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.REFER1 IS '�����׸�1~9';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.VOUCH_CODE IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.REFER_RATE IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.REFER_AMOUNT IS '�����ݾ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.REFER_DATE1 IS '��������1';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.REFER_DATE2 IS '��������2';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.REMARK IS '����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.UNLIQUIDATE_SLIP_HEADER_ID IS '��û�� ��ǥHEADER ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.UNLIQUIDATE_SLIP_LINE_ID IS '��û�� ��ǥLINE ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.FUND_CODE IS '�ڱ��ڵ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CLOSED_YN IS '��������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CLOSED_DATE IS '��������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CLOSED_PERSON_ID IS '����ó����';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.SOURCE_TABLE IS 'INTERFACE �ҽ����̺�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.SOURCE_HEADER_ID IS 'INTERFACE �ҽ� HEADER ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.SOURCE_LINE_ID IS 'INTERFACE �ҽ� LINE ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CREATION_DATE IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CREATED_BY IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.LAST_UPDATE_DATE IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.LAST_UPDATED_BY IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.DELETED_DATE IS '�����Ͻ�';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.DELETED_BY IS '������';
          
CREATE INDEX FI_SLIP_LINE_LOG_N1 ON FI_SLIP_LINE_LOG(SLIP_DATE, SLIP_NUM, SLIP_LINE_SEQ, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_LINE_LOG_N2 ON FI_SLIP_LINE_LOG(SOB_ID, GL_DATE, GL_NUM) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_LINE_LOG_N3 ON FI_SLIP_LINE_LOG(SLIP_HEADER_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_LINE_LOG_N4 ON FI_SLIP_LINE_LOG(SLIP_LINE_ID) TABLESPACE FCM_TS_IDX;
       
