/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_TAX_STANDARD
/* Description  : �ΰ��� - ����ǥ�ظ�.
/*
/* Reference by : 
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_TAX_STANDARD
( TAX_STANDARD_CODE               VARCHAR2(10)  NOT NULL,
  SOB_ID                          NUMBER        NOT NULL,
  BUSINESS_TYPE                   VARCHAR2(150) ,
  BUSINESS_ITEM                   VARCHAR2(150) ,  
  BUSINESS_ITEM_CODE              VARCHAR2(10)  ,
  TAX_AMOUNT                      NUMBER        DEFAULT 0,
  DESCRIPTION                     VARCHAR2(150) ,
  SORT_SEQ                        NUMBER        ,
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

COMMENT ON TABLE FI_VAT_TAX_STANDARD IS '�ΰ��� ����ǥ��';
COMMENT ON COLUMN FI_VAT_TAX_STANDARD.TAX_STANDARD_CODE IS '����ǥ�� �ڵ�';
COMMENT ON COLUMN FI_VAT_TAX_STANDARD.BUSINESS_TYPE IS '����';
COMMENT ON COLUMN FI_VAT_TAX_STANDARD.BUSINESS_ITEM IS '����';
COMMENT ON COLUMN FI_VAT_TAX_STANDARD.BUSINESS_ITEM_CODE IS '�����ڵ�';
COMMENT ON COLUMN FI_VAT_TAX_STANDARD.TAX_AMOUNT IS '�ݾ�';
COMMENT ON COLUMN FI_VAT_TAX_STANDARD.DESCRIPTION IS '���';
COMMENT ON COLUMN FI_VAT_TAX_STANDARD.SORT_SEQ IS '���ļ���';

ALTER TABLE FI_VAT_TAX_STANDARD ADD CONSTRAINT FI_VAT_TAX_STANDARD_PK PRIMARY KEY(TAX_STANDARD_CODE, SOB_ID);
CREATE INDEX FI_VAT_TAX_STANDARD_N1 ON FI_VAT_TAX_STANDARD(SORT_SEQ, SOB_ID) TABLESPACE FCM_TS_IDX;  

ANALYZE TABLE FI_VAT_TAX_STANDARD COMPUTE STATISTICS;
ANALYZE INDEX FI_VAT_TAX_STANDARD_N1 COMPUTE STATISTICS;
