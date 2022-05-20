/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_UNLIQUIDATE_LINE
/* Description  : ��û�� ���� ��ǥ ��
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_UNLIQUIDATE_LINE 
( SLIP_LINE_ID                    NUMBER        NOT NULL,      -- ��ǥ ����ID.
  SOB_ID                          NUMBER        NOT NULL,      -- ȸ������.
  ORG_ID                          NUMBER        NOT NULL,      -- �����ID.
  LIQUIDATE_SLIP_LINE_ID          NUMBER        NOT NULL,      -- ������ǥ ����ID.
  PERIOD_NAME                     VARCHAR2(10)  NOT NULL,      -- ȸ����.
  UNLIQUIDATE_TYPE                CHAR(1)       DEFAULT '1',   -- �������� 1:����  0:������Data  (�߰�)
  GL_DATE                         DATE          ,              -- ȸ������.
  GL_NUM                          VARCHAR2(30)  ,              -- ȸ���ȣ
  ACCOUNT_BOOK_ID                 NUMBER        NOT NULL,      -- ȸ�����ID.
  SLIP_TYPE                       VARCHAR2(10)  NOT NULL,      -- ��ǥ����.    
  ACCOUNT_CONTROL_ID              NUMBER        NOT NULL,       
  ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL,    
  ACCOUNT_DR_CR                   VARCHAR2(2)   NOT NULL,     
  CUSTOMER_ID                     NUMBER        ,              -- �ŷ�óID.
  GL_AMOUNT                       NUMBER        DEFAULT 0, 
  CURRENCY_CODE                   VARCHAR2(10)  ,              -- ��ȭ.
  EXCHANGE_RATE                   NUMBER        ,              -- ȯ��.
  GL_CURRENCY_AMOUNT              NUMBER        ,              -- ��ȭ�ݾ�.
  MANAGEMENT1                     VARCHAR2(50)  ,
  MANAGEMENT2                     VARCHAR2(50)  ,
  REFER_DATE1                     DATE          ,              -- ���������ڵ�1.
  REFER_DATE2                     DATE          ,              -- ���������ڵ�2.
  REMARK                          VARCHAR2(100) ,              -- ����.
  CREATION_DATE                   DATE          NOT NULL,  
  CREATED_BY                      NUMBER        NOT NULL,   
  LAST_UPDATE_DATE                DATE          NOT NULL,   
  LAST_UPDATED_BY                 NUMBER        NOT NULL   
) TABLESPACE FCM_TS_DATA ;

COMMENT ON TABLE FI_UNLIQUIDATE_LINE IS '��û�� ������ǥ ��';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.SLIP_LINE_ID IS '��ǥ ���� ID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.UNLIQUIDATE_TYPE IS '�������� 1-����, 2-������';
/*
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.SLIP_LINE_SEQ IS '��ǥ ���� ��ȣ';*/
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.LIQUIDATE_SLIP_LINE_ID IS '������ǥ ���� ID';
/*COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.LIQUIDATE_SLIP_HEADER_ID IS '������ǥ ��� ID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.LIQUIDATE_SLIP_LINE_SEQ IS '������ǥ ���� ��ȣ';*/
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.GL_DATE IS 'ȸ������';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.GL_NUM IS 'ȸ�� ��ǥ��ȣ';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.ACCOUNT_BOOK_ID IS 'ȸ�����';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.SLIP_TYPE IS '��ǥ����';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.ACCOUNT_CODE IS '�����ڵ�';
--COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.COST_CENTER_ID IS '����ID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.ACCOUNT_DR_CR IS '���뱸��(1-��, 2-��)';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.CUSTOMER_ID IS '�ŷ�óID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.GL_AMOUNT IS '�߻��ݾ�';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.GL_CURRENCY_AMOUNT IS '��ȭ�ݾ�';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.REFER_DATE1 IS '��������1';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.REFER_DATE2 IS '��������2';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.REMARK IS '����';

CREATE UNIQUE INDEX FI_UNLIQUIDATE_LINE_PK ON 
  FI_UNLIQUIDATE_LINE(SLIP_LINE_ID, SOB_ID, LIQUIDATE_SLIP_LINE_ID)
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

ALTER TABLE FI_UNLIQUIDATE_LINE ADD ( 
  CONSTRAINT FI_UNLIQUIDATE_LINE_PK PRIMARY KEY ( SLIP_LINE_ID, SOB_ID, LIQUIDATE_SLIP_LINE_ID ) 
        );
        
CREATE INDEX FI_UNLIQUIDATE_LINE_N1 ON FI_UNLIQUIDATE_LINE(SOB_ID, GL_DATE, GL_NUM) TABLESPACE FCM_TS_IDX;
