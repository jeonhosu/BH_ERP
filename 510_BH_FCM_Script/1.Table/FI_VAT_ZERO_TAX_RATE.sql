/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_ZERO_TAX_RATE
/* Description  : ������÷�μ���.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_ZERO_TAX_RATE 
( ZERO_TAX_RATE_ID                NUMBER        NOT NULL,   -- ������÷�μ��� ID.
  TAX_CODE                        VARCHAR2(20)  NOT NULL,   -- �ΰ��� �Ű� ������ڵ�.
  SOB_ID                          NUMBER        NOT NULL,   
  DOCUMENT_TYPE                   VARCHAR2(10)  NOT NULL,   -- ��������.
  ISSUER_NAME                     VARCHAR2(100) ,           -- �߱���.
  ISSUE_DATE                      DATE          ,           -- �߱�����.
  SHIPPING_DATE                   DATE          ,           -- ��������.                   
  DOCUMENT_NUM                    VARCHAR2(50)  ,           -- L/C��ȣ(����Ű�,�ſ����ȣ).
  CURRENCY_CODE                   VARCHAR2(10)  ,           -- ��ȭ.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,  -- ȯ��.
  TOTAL_CURR_AMOUNT               NUMBER        DEFAULT 0,  -- ������� ��ȭ�ݾ�.
  TOTAL_BASE_AMOUNT               NUMBER        DEFAULT 0,  -- ������� ��ȭ�ݾ�.
  THIS_CURR_AMOUNT                NUMBER        DEFAULT 0,  -- ���Ű� ��ȭ�ݾ�.
  THIS_BASE_AMOUNT                NUMBER        DEFAULT 0,  -- ���Ű� ��ȭ�ݾ�.
  VAT_ISSUE_DATE                  DATE          NOT NULL,   -- ���ݰ�꼭 �߱�����.
  BANK_CODE                       VARCHAR2(20)  ,           -- �߱�����.
  CUSTOMER_CODE                   VARCHAR2(50)  ,           -- �ŷ�ó�ڵ�.
  CLOSED_YN                       CHAR(1)       DEFAULT 'N',-- ��������.
  CLOSED_DATE                     DATE          ,           -- �����Ͻ�.
  CLOSED_PERSON_ID                NUMBER        ,           -- ����ó����.
  CREATED_TYPE                    VARCHAR2(2)   ,           -- ��������(I-INTERFACE, M-����).
  SOURCE_TABLE                    VARCHAR2(100) ,
  INTERFACE_HEADER_ID             NUMBER        ,
  INTERFACE_LINE_ID               NUMBER        ,
  ATTRIBUTE_A                     VARCHAR2(100) ,
  ATTRIBUTE_B                     VARCHAR2(100) ,
  ATTRIBUTE_C                     VARCHAR2(100) ,
  ATTRIBUTE_D                     VARCHAR2(100) ,
  ATTRIBUTE_E                     VARCHAR2(100) ,
  ATTRIBUTE_1                     NUMBER        ,
  ATTRIBUTE_2                     NUMBER        ,
  ATTRIBUTE_3                     NUMBER        ,
  ATTRIBUTE_4                     NUMBER        ,
  ATTRIBUTE_5                     NUMBER        ,
  CREATION_DATE                   DATE          NOT NULL,
  CREATED_BY                      NUMBER        NOT NULL,
  LAST_UPDATE_DATE                DATE          NOT NULL,
  LAST_UPDATED_BY                 NUMBER        NOT NULL
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_VAT_ZERO_TAX_RATE IS '������÷�μ���';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.ZERO_TAX_RATE_ID IS '������÷�μ��� ID';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.TAX_CODE IS '�ΰ��� �Ű� ������ڵ�';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.DOCUMENT_TYPE IS '��������';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.ISSUER_NAME IS '�߱���';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.ISSUE_DATE IS '�߱�����';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.SHIPPING_DATE IS '��������';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.DOCUMENT_NUM IS 'L/C��ȣ(����Ű�,�ſ����ȣ)';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.EXCHANGE_RATE  IS 'ȯ��';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.TOTAL_CURR_AMOUNT IS '������� ��ȭ�ݾ�';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.TOTAL_BASE_AMOUNT IS '������� ��ȭ�ݾ�';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.THIS_CURR_AMOUNT IS '���Ű� ��ȭ�ݾ�';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.THIS_BASE_AMOUNT IS '���Ű� ��ȭ�ݾ�';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.VAT_ISSUE_DATE IS '���ݰ�꼭 ��������';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.BANK_CODE IS '�߱������ڵ�';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.CUSTOMER_CODE IS '�ŷ�ó�ڵ�';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.CLOSED_YN IS '��������';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.CLOSED_DATE IS '�����Ͻ�';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.CLOSED_PERSON_ID IS '����ó����';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.CREATED_TYPE IS '��������(I-INTEFACE����, M-�������)';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.SOURCE_TABLE IS '���� ���̺�';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.INTERFACE_HEADER_ID IS '���� ��� ID';
COMMENT ON COLUMN FI_VAT_ZERO_TAX_RATE.INTERFACE_LINE_ID IS '���� ����ID';

ALTER TABLE FI_VAT_ZERO_TAX_RATE ADD CONSTRAINT FI_VAT_ZERO_TAX_RATE_PK PRIMARY KEY (ZERO_TAX_RATE_ID);

CREATE INDEX FI_VAT_ZERO_TAX_RATE_N1 ON FI_VAT_ZERO_TAX_RATE(VAT_ISSUE_DATE, NVL(DOCUMENT_NUM, '-'), TAX_CODE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_ZERO_TAX_RATE_N2 ON FI_VAT_ZERO_TAX_RATE(ISSUE_DATE, TAX_CODE, SOB_ID)  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_ZERO_TAX_RATE_N3 ON FI_VAT_ZERO_TAX_RATE(ISSUE_DATE, CUSTOMER_CODE, TAX_CODE, SOB_ID) TABLESPACE FCM_TS_IDX;
  
CREATE SEQUENCE FI_VAT_ZERO_TAX_RATE_S1;
