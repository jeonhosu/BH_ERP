/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_EXPORT
/* Description  : �����������.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_EXPORT 
( EXPORT_ID                       NUMBER        NOT NULL,   -- ����������� ID.
  TAX_CODE                        VARCHAR2(20)  NOT NULL,   -- �ΰ��� �Ű� ������ڵ�.
  DOCUMENT_NUM                    VARCHAR2(30)  ,           -- L/C��ȣ(����Ű�,�ſ����ȣ).
  SOB_ID                          NUMBER        NOT NULL,   
  SHIPPING_DATE                   DATE          ,           -- ��������.
  CURRENCY_CODE                   VARCHAR2(10)  ,           -- ��ȭ.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,  -- ȯ��.
  CURR_AMOUNT                     NUMBER        DEFAULT 0,  -- ��ȭ�ݾ�.
  BASE_AMOUNT                     NUMBER        DEFAULT 0,  -- ��ȭ�ݾ�.
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

COMMENT ON TABLE FI_VAT_EXPORT IS '�����������';
COMMENT ON COLUMN FI_VAT_EXPORT.EXPORT_ID IS '�����������ID';
COMMENT ON COLUMN FI_VAT_EXPORT.TAX_CODE IS '�ΰ��� �Ű� ������ڵ�';
COMMENT ON COLUMN FI_VAT_EXPORT.DOCUMENT_NUM IS 'L/C��ȣ(����Ű�,�ſ����ȣ)';
COMMENT ON COLUMN FI_VAT_EXPORT.SHIPPING_DATE IS '��������';
COMMENT ON COLUMN FI_VAT_EXPORT.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN FI_VAT_EXPORT.EXCHANGE_RATE  IS 'ȯ��';
COMMENT ON COLUMN FI_VAT_EXPORT.CURR_AMOUNT IS '��ȭ�ݾ�';
COMMENT ON COLUMN FI_VAT_EXPORT.BASE_AMOUNT IS '��ȭ�ݾ�';
COMMENT ON COLUMN FI_VAT_EXPORT.CLOSED_YN IS '��������';
COMMENT ON COLUMN FI_VAT_EXPORT.CLOSED_DATE IS '�����Ͻ�';
COMMENT ON COLUMN FI_VAT_EXPORT.CLOSED_PERSON_ID IS '����ó����';
COMMENT ON COLUMN FI_VAT_EXPORT.CREATED_TYPE IS '��������(I-INTEFACE����, M-�������)';
COMMENT ON COLUMN FI_VAT_EXPORT.SOURCE_TABLE IS '���� ���̺�';
COMMENT ON COLUMN FI_VAT_EXPORT.INTERFACE_HEADER_ID IS '���� ��� ID';
COMMENT ON COLUMN FI_VAT_EXPORT.INTERFACE_LINE_ID IS '���� ����ID';


ALTER TABLE FI_VAT_EXPORT ADD CONSTRAINT FI_VAT_EXPORT_PK PRIMARY KEY (EXPORT_ID);

CREATE INDEX FI_VAT_EXPORT_N1 ON FI_VAT_EXPORT(TAX_CODE, SHIPPING_DATE, SOB_ID)  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_EXPORT_N2 ON FI_VAT_EXPORT(TAX_CODE, DOCUMENT_NUM, SHIPPING_DATE, SOB_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE FI_VAT_EXPORT_S1;
