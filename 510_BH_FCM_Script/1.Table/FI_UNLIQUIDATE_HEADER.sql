/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_UNLIQUIDATE_HEADER
/* Description  : ��û�� ��ǥ �߻�ǥ��
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_UNLIQUIDATE_HEADER
( SLIP_LINE_ID                    NUMBER        NOT NULL,      -- ��ǥ ����ID.  
  SOB_ID                          NUMBER        NOT NULL,      -- ȸ������.
  ORG_ID                          NUMBER        NOT NULL,      -- �����ID.
  PERIOD_NAME                     VARCHAR2(10)  NOT NULL,      -- ȸ����.
  GL_DATE                         DATE          ,              -- ȸ������.
  GL_NUM                          VARCHAR2(30)  ,              -- ȸ���ȣ
  ACCOUNT_BOOK_ID                 NUMBER        NOT NULL,      -- ȸ�����ID.
  SLIP_TYPE                       VARCHAR2(10)  NOT NULL,      -- ��ǥ����.    
  ACCOUNT_CONTROL_ID              NUMBER        NOT NULL,       
  ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL,       
  ACCOUNT_DR_CR                   VARCHAR2(2)   NOT NULL,     
  CUSTOMER_ID                     NUMBER        ,              -- �ŷ�ó ID
  GL_AMOUNT                       NUMBER        DEFAULT 0, 
  CURRENCY_CODE                   VARCHAR2(10)  ,
  OLD_EXCHANGE_RATE               NUMBER        DEFAULT 0,
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,     -- ȯ��.
  GL_CURRENCY_AMOUNT              NUMBER        DEFAULT 0,     -- ��ȭ�ݾ�.
  MANAGEMENT1                     VARCHAR2(50)  ,
  MANAGEMENT2                     VARCHAR2(50)  ,
  REFER1                          VARCHAR2(50)  ,	             -- �����׸�1~9.      (�߰�)
  REFER2                          VARCHAR2(50)  ,
  REFER3                          VARCHAR2(50)  ,
  REFER4                          VARCHAR2(50)  ,
  REFER5                          VARCHAR2(50)  ,
  REFER6                          VARCHAR2(50)  ,
  REFER7                          VARCHAR2(50)  ,
  REFER8                          VARCHAR2(50)  ,
  REFER9                          VARCHAR2(50)  ,
  REFER_DATE1                     DATE          ,              -- ���������ڵ�1.
  REFER_DATE2                     DATE          ,              -- ���������ڵ�2.
  V_REMAIN_AMOUNT                 NUMBER        DEFAULT 0,     -- �̹ݿ� �ܾ�
  V_REMAIN_CURRENCY_AMOUNT        NUMBER        DEFAULT 0,     -- �̹ݿ� ��ȭ�ܾ�.  
  GL_REMAIN_AMOUNT                NUMBER        DEFAULT 0,     -- �ܾ�
  GL_REMAIN_CURRENCY_AMOUNT       NUMBER        DEFAULT 0,     -- ��ȭ�ܾ�.    
  REMARK                          VARCHAR2(150) ,              -- ����.
  SLIP_STATUS                     VARCHAR2(5)   DEFAULT 'N',   -- N �̹���, P-�κ�, V-�̹ݿ� ����, C-�Ϸ�.
  CREATION_DATE                   DATE          NOT NULL,   
  CREATED_BY                      NUMBER        NOT NULL,   
  LAST_UPDATE_DATE                DATE          NOT NULL,   
  LAST_UPDATED_BY                 NUMBER        NOT NULL      
) TABLESPACE FCM_TS_DATA ;

COMMENT ON TABLE FI_UNLIQUIDATE_HEADER IS '��û����ǥǥ��';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.SLIP_LINE_ID IS '��ǥ ���� ID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.GL_DATE IS 'ȸ������';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.GL_NUM IS 'ȸ�� ��ǥ��ȣ';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.ACCOUNT_BOOK_ID IS 'ȸ�����';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.SLIP_TYPE IS '��ǥ����';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.ACCOUNT_CODE IS '�����ڵ�';
--COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.COST_CENTER_ID IS '����ID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.ACCOUNT_DR_CR IS '���뱸��(1-��, 2-��)';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.CUSTOMER_ID IS '�ŷ�óID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.GL_AMOUNT IS '�߻��ݾ�';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.GL_CURRENCY_AMOUNT IS '��ȭ�ݾ�';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.REFER_DATE1 IS '��������1';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.REFER_DATE2 IS '��������2';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.V_REMAIN_AMOUNT IS '�̹ݿ� �ܾ�';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.V_REMAIN_CURRENCY_AMOUNT IS '�̹ݿ� ��ȭ�ܾ�';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.GL_REMAIN_AMOUNT IS '�ܾ�';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.GL_REMAIN_CURRENCY_AMOUNT IS '��ȭ�ܾ�';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.REMARK IS '����';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.SLIP_STATUS IS 'N �̹���, P-�κ�, V-�̹ݿ� ����, C-�Ϸ�';

CREATE UNIQUE INDEX FI_UNLIQUIDATE_HEADER_PK ON 
  FI_UNLIQUIDATE_HEADER(SLIP_LINE_ID)
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

ALTER TABLE FI_UNLIQUIDATE_HEADER ADD ( 
  CONSTRAINT FI_UNLIQUIDATE_HEADER_PK PRIMARY KEY ( SLIP_LINE_ID ) 
        );
        
-- UNIQUE INDEX.
CREATE INDEX FI_UNLIQUIDATE_HEADERE_N1 ON FI_UNLIQUIDATE_HEADER(SOB_ID, GL_DATE, GL_NUM) TABLESPACE FCM_TS_IDX;
