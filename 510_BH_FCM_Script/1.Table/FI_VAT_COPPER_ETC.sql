/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_COPPER_ETC
/* Description  : ������ũ���� ���Լ��� �����Ű� 
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_COPPER_ETC
( COPPER_ETC_ID                   NUMBER        NOT NULL,   
  SOB_ID                          NUMBER        NOT NULL,   
  ORG_ID                          NUMBER        NOT NULL, 
  TAX_CODE                        VARCHAR2(20)  NOT NULL,   
  VAT_MNG_SERIAL                  NUMBER        NOT NULL,   
  VAT_RECEIPT_TYPE                VARCHAR2(20)  NOT NULL,   
  SUPPLIER_ID                     NUMBER        NOT NULL,           
  VAT_COUNT                       NUMBER        ,           
  ITEM_DESC                       VARCHAR2(200) ,           
  ITEM_QTY                        NUMBER        DEFAULT 0,  
  ITEM_AMOUNT                     NUMBER        ,           
  DEEMED_VAT_AMOUNT               NUMBER        ,
  ATTRIBUTE_A                     VARCHAR2(200) ,
  ATTRIBUTE_B                     VARCHAR2(200) ,
  ATTRIBUTE_C                     VARCHAR2(200) ,
  ATTRIBUTE_D                     VARCHAR2(200) ,
  ATTRIBUTE_E                     VARCHAR2(200) ,
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

COMMENT ON TABLE FI_VAT_COPPER_ETC IS '������ũ���� ���Լ��� �����Ű�';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.COPPER_ETC_ID IS '������ũ���� ID';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.TAX_CODE IS '�ΰ��� �Ű� ������ڵ�';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.VAT_MNG_SERIAL IS '�ΰ����Ű�Ⱓ���й�ȣ';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.VAT_RECEIPT_TYPE IS '������(10)/��꼭(20) ����';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.SUPPLIER_ID IS '����óID';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.VAT_COUNT IS 'VAT �ż�';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.ITEM_DESC IS 'ǰ��';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.ITEM_QTY IS '����';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.ITEM_AMOUNT IS '���ݾ�';
COMMENT ON COLUMN FI_VAT_COPPER_ETC.DEEMED_VAT_AMOUNT IS '�������Լ���';

ALTER TABLE FI_VAT_COPPER_ETC ADD CONSTRAINT FI_VAT_COPPER_ETC_PK PRIMARY KEY (SOB_ID, ORG_ID, TAX_CODE, VAT_MNG_SERIAL, VAT_RECEIPT_TYPE, SUPPLIER_ID) USING INDEX TABLESPACE FCM_TS_IDX;

-- INDEX
CREATE UNIQUE INDEX FI_VAT_COPPER_ETC_U1 ON FI_VAT_COPPER_ETC(COPPER_ETC_ID) TABLESPACE FCM_TS_IDX;

CREATE SEQUENCE FI_VAT_COPPER_ETC_S1;
