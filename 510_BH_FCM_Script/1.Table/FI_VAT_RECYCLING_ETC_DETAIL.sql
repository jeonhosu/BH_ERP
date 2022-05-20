/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_RECYCLING_ETC_DETAIL
/* Description  : ��Ȱ�����ڿ� �� �߰��ڵ��� ���Լ��� �����Ű� 
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_RECYCLING_ETC_DETAIL
( RECYCLING_ETC_DETAIL_ID         NUMBER        NOT NULL,   
  SOB_ID                          NUMBER        NOT NULL,   
  ORG_ID                          NUMBER        NOT NULL, 
  TAX_CODE                        VARCHAR2(20)  NOT NULL,   
  VAT_MNG_SERIAL                  NUMBER        NOT NULL,   
  VAT_RECEIPT_TYPE                VARCHAR2(20)  NOT NULL,   
  SUPPLIER_ID                     NUMBER        NOT NULL,           
  VAT_COUNT                       NUMBER        ,           
  ITEM_DESC                       VARCHAR2(200) ,           
  ITEM_QTY                        NUMBER        DEFAULT 0,  
  CAR_NUM                         VARCHAR2(50)  ,
  CAR_BODY_NUM                    VARCHAR2(50)  ,
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
  LAST_UPDATED_BY                 NUMBER        NOT NULL, 
  COPPER_ETC_ID                   NUMBER        ,
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_VAT_RECYCLING_ETC_DETAIL IS '��Ȱ�����ڿ� �� �߰��ڵ��� ���Լ��� �����Ű�';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.RECYCLING_ETC_DETAIL_ID IS '��Ȱ�����ڿ� �� �߰��ڵ��� ���� �� ID';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.TAX_CODE IS '�ΰ��� �Ű� ������ڵ�';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.VAT_MNG_SERIAL IS '�ΰ����Ű�Ⱓ���й�ȣ';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.VAT_RECEIPT_TYPE IS '������(10)/��꼭(20) ����';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.SUPPLIER_ID IS '����óID';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.VAT_COUNT IS 'VAT �ż�';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.ITEM_DESC IS 'ǰ��';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.ITEM_QTY IS '����';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.CAR_NUM IS '������ȣ';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.CAR_BODY_NUM IS '�����ȣ';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.ITEM_AMOUNT IS '���ݾ�';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.DEEMED_VAT_AMOUNT IS '���Լ��� ������';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC_DETAIL.COPPER_ETC_ID IS '���� ��ũ���� ���Լ��� �����Ű� ID';


-- INDEX
CREATE UNIQUE INDEX FI_VAT_RECYCLING_ETC_DTL_U1 ON FI_VAT_RECYCLING_ETC_DETAIL(RECYCLING_ETC_DETAIL_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_RECYCLING_ETC_DTL_N1 ON FI_VAT_RECYCLING_ETC_DETAIL(SOB_ID, ORG_ID, TAX_CODE, VAT_MNG_SERIAL) TABLESPACE FCM_TS_IDX;

CREATE SEQUENCE FI_VAT_RECYCLING_ETC_DTL_S1;
