/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_DPR_ASSET
/* Description  : ������������ ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_DPR_ASSET 
( DPR_ASSET_ID                    NUMBER        NOT NULL,   -- ������������ ID.
  TAX_CODE                        VARCHAR(10)   NOT NULL,   -- �ΰ��� �Ű� ������ڵ�.
  ACQUIRE_DATE                    DATE          NOT NULL,   -- �������.  
  ACCOUNT_CONTROL_ID              NUMBER        NOT NULL,   -- ��������ID.
  VAT_ASSET_GB                    VARCHAR2(10)  NOT NULL,   -- ������ �ڻ걸��.
  CUSTOMER_ID                     NUMBER        NOT NULL,   -- �ŷ�óID.
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  GL_AMOUNT                       NUMBER        DEFAULT 0,  -- ���ް���.
  VAT_AMOUNT                      NUMBER        DEFAULT 0,  -- �ΰ��� �ݾ�.
  CURRENCY_CODE                   VARCHAR2(10)  ,           -- ��ȭ.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,  -- ȯ��.
  GL_CURR_AMOUNT                  NUMBER        DEFAULT 0,  -- ��ȭ ���ް���.
  VAT_CURR_AMOUNT                 NUMBER        DEFAULT 0,  -- ��ȭ �ΰ��� �ݾ�.
  REMARK                          VARCHAR2(200) ,           -- ����.
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

COMMENT ON TABLE FI_VAT_DPR_ASSET IS '������������ ����';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.DPR_ASSET_ID IS '��������� ID';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.TAX_CODE IS '�ΰ����Ű� ������ڵ�';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.ACQUIRE_DATE IS '�������';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.VAT_ASSET_GB IS '������ �ڻ걸��';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.CUSTOMER_ID IS '�ŷ�óID';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.GL_AMOUNT IS '���ް���';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.VAT_AMOUNT IS '�ΰ���';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.GL_CURR_AMOUNT IS '��ȭ ���ް���';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.VAT_CURR_AMOUNT IS '��ȭ �ΰ�����';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.REMARK IS '����';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.CLOSED_YN IS '��������';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.CLOSED_DATE IS '�����Ͻ�';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.CLOSED_PERSON_ID IS '����ó����';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.CREATED_TYPE IS '��������(I-INTEFACE����, M-�������)';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.SOURCE_TABLE IS '���� ���̺�';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.INTERFACE_HEADER_ID IS '���� ��� ID';
COMMENT ON COLUMN FI_VAT_DPR_ASSET.INTERFACE_LINE_ID IS '���� ����ID';

ALTER TABLE FI_VAT_DPR_ASSET ADD CONSTRAINT FI_VAT_DPR_ASSET_PK PRIMARY KEY (DPR_ASSET_ID);
CREATE INDEX FI_VAT_DPR_ASSET_N1 ON FI_VAT_DPR_ASSET(TAX_CODE, ACQUIRE_DATE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_DPR_ASSET_N2 ON FI_VAT_DPR_ASSET(TAX_CODE, CUSTOMER_ID, SOB_ID)  TABLESPACE FCM_TS_IDX;

CREATE SEQUENCE FI_VAT_DPR_ASSET_S1;
