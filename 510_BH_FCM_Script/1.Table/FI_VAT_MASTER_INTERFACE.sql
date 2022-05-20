/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_MASTER_INTERFACE
/* Description  : ���ݰ�꼭����-�̽��� ��ǥ(������ǥ) �ڷ�.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_MASTER_INTERFACE 
( LINE_INTERFACE_ID               NUMBER        NOT NULL    -- ��ǥ ���� ID.
, HEADER_INTERFACE_ID             NUMBER        NOT NULL    -- ��ǥ ��� ID.
, SOB_ID                          NUMBER        NOT NULL
, ORG_ID                          NUMBER        NOT NULL
, GL_DATE                         DATE          NOT NULL    -- ȸ������.
, GL_NUM                          VARCHAR2(30)              -- ȸ���ȣ.
, PERIOD_NAME                     VARCHAR2(10)              -- ȸ����.
, VAT_GUBUN                       VARCHAR2(10)  NOT NULL    -- ���Ը��ⱸ��.
, TAX_INVOICE_TYPE                CHAR(1)       NOT NULL    -- ���ݰ�꼭 ����(1.�Ϲ�, 2.����).
, SLIP_TYPE                       VARCHAR2(10)  NOT NULL    -- ��ǥ����.
, VAT_ISSUE_DATE                  DATE                      -- ��꼭������.   
, ACCOUNT_CONTROL_ID              NUMBER        NOT NULL    -- ��ǥ��������ID.
, ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL    -- ��ǥ�����ڵ�.
, GL_AMOUNT                       NUMBER        DEFAULT 0   -- ���ް���.
, VAT_AMOUNT                      NUMBER        DEFAULT 0   -- �ΰ��� �ݾ�.
, VAT_SLIP_COUNT                  NUMBER(3)     DEFAULT 1   -- ��꼭�ż�.
, VAT_NOTICE                      CHAR(1)       DEFAULT '0' -- 0:�̽Ű�, 1:Ȯ���Ű�, 2:�����Ű�
, SUPPLIER_ID                     NUMBER                    -- ������ �ŷ�óID.
, RESIDENT_REG_NUM                VARCHAR2(2)               -- �ֹι�ȣ.
, TAX_CODE                        VARCHAR2(10)              -- �ǰ����� ����� ���ݰ�꼭 �ڵ�.
, CONSIGNEE_ID                    NUMBER                    -- �ǰ����� �ŷ�óID.
, VAT_TYPE_ID                     NUMBER                    -- �ΰ��� ���� ID.
, VOUCH_CODE                      VARCHAR2(50)              -- �����ڵ�.
, VAT_REASON_CODE                 VARCHAR2(50)              -- �ΰ��� ����.
, CREDITCARD_CODE                 VARCHAR2(50)              -- �ſ�ī���ȣ.
, CASH_RECEIPT_NUM                VARCHAR2(20)              -- ���ݿ����� ���ι�ȣ.
, BURGET_ACCOUNT_CONTROL_ID       NUMBER                    -- ���ݰ�꼭(�����)������ ��������ID.
, BURGET_ACCOUNT_CODE             VARCHAR2(20)              -- ���ݰ�꼭(�����)������ �����ڵ�.
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_VAT_MASTER_INTERFACE IS '���ݰ�꼭�� - ��ǥ �������̽�';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.LINE_INTERFACE_ID IS '��ǥ ���� ID';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.HEADER_INTERFACE_ID IS '��ǥ ��� ID';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.GL_DATE IS 'ȸ������';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.GL_NUM  IS 'ȸ���ȣ';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.PERIOD_NAME IS 'ȸ����';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.VAT_GUBUN IS '���Ը��ⱸ�� 1:����  2:����';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.TAX_INVOICE_TYPE IS '���ݰ�꼭 ����(1.�Ϲ�, 2.����)';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.SLIP_TYPE IS '��ǥ����';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.VAT_ISSUE_DATE IS '��꼭������';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.ACCOUNT_CODE IS '��ǥ�����ڵ�';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.GL_AMOUNT IS '���ް���';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.VAT_AMOUNT IS '�ΰ���';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.VAT_SLIP_COUNT IS '��꼭�ż�';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.VAT_NOTICE IS '0:�̽Ű�, 1:Ȯ���Ű�, 2:�����Ű�';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.SUPPLIER_ID IS '�����ڻ���ڹ�ȣ';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.RESIDENT_REG_NUM IS '�ֹι�ȣ';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.TAX_CODE IS '�ǰ����� �����';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.CONSIGNEE_ID IS '�ǰ����ڻ���ڹ�ȣ';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.VAT_TYPE_ID IS '�ΰ��� ���� ID-VAT_TYPE_AP/VAT_TYPE_AR';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.VOUCH_CODE IS '�ŷ������ڵ�';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.VAT_REASON_CODE IS '�ΰ��� ����';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.CASH_RECEIPT_NUM IS '���ݿ����� ���ι�ȣ';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.CREDITCARD_CODE IS '�ſ�ī���ڵ�';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.BURGET_ACCOUNT_CONTROL_ID IS '���ݰ�꼭(�����)������ ��������ID';
COMMENT ON COLUMN FI_VAT_MASTER_INTERFACE.BURGET_ACCOUNT_CODE IS '���ݰ�꼭(�����)������ �����ڵ�';

CREATE UNIQUE INDEX FI_VAT_MASTER_INTERFACE_PK ON 
  FI_VAT_MASTER_INTERFACE(LINE_INTERFACE_ID)
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

ALTER TABLE FI_VAT_MASTER_INTERFACE ADD ( 
  CONSTRAINT FI_VAT_MASTER_INTERFACE_PK PRIMARY KEY (LINE_INTERFACE_ID) 
        );
        
CREATE INDEX FI_VAT_MASTER_INTERFACE_N1 ON FI_VAT_MASTER_INTERFACE(SUPPLIER_ID, TAX_CODE, VAT_GUBUN)  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_MASTER_INTERFACE_N2 ON FI_VAT_MASTER_INTERFACE(GL_DATE, SOB_ID) TABLESPACE FCM_TS_IDX;
  
