/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_RECYCLING_ETC
/* Description  : ��Ȱ�����ڿ� �� �߰��ڵ��� ���Լ��� �����Ű� 
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_RECYCLING_ETC
( RECYCLING_ETC_ID                NUMBER        NOT NULL,   
  SOB_ID                          NUMBER        NOT NULL,   
  ORG_ID                          NUMBER        NOT NULL, 
  TAX_CODE                        VARCHAR2(20)  NOT NULL,   
  VAT_MNG_SERIAL                  NUMBER        NOT NULL,   
  SALES_PRE_AMOUNT                NUMBER        DEFAULT 0,
  SALES_FIX_AMOUNT                NUMBER        DEFAULT 0, 
  LIMIT_RATE_NUMERATOR            NUMBER        DEFAULT 0,
  LIMIT_RATE_DENOMINATOR          NUMBER        DEFAULT 0,
  LIMIT_RATE                      NUMBER        DEFAULT 0,
  LIMIT_AMOUNT                    NUMBER        DEFAULT 0,
  PURCHASES_TAX_BILL_AMOUNT       NUMBER        DEFAULT 0,
  PURCHASES_BILL_AMOUNT           NUMBER        DEFAULT 0,
  DED_RANGE_AMOUNT                NUMBER        DEFAULT 0,
  DED_TARGET_AMOUNT               NUMBER        DEFAULT 0,
  DED_RATE_NUMERATOR              NUMBER        DEFAULT 0,
  DED_RATE_DENOMINATOR            NUMBER        DEFAULT 0,
  DED_RATE                        NUMBER        DEFAULT 0,
  DED_VAT_AMOUNT                  NUMBER        DEFAULT 0,
  DED_PRE_QUARTER_AMOUNT          NUMBER        DEFAULT 0,
  DED_PRE_MONTHLY_AMOUNT          NUMBER        DEFAULT 0,
  FIX_VAT_AMOUNT                  NUMBER        DEFAULT 0,
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

COMMENT ON TABLE FI_VAT_RECYCLING_ETC IS '��Ȱ�����ڿ� �� �߰��ڵ��� ���Լ��� �����Ű�';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.RECYCLING_ETC_ID IS '��Ȱ�����ڿ� �� �߰��ڵ��� ���Լ��� ID';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.TAX_CODE IS '�ΰ��� �Ű� ������ڵ�';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.VAT_MNG_SERIAL IS '�ΰ����Ű�Ⱓ���й�ȣ';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.SALES_PRE_AMOUNT IS '�����-������';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.SALES_FIX_AMOUNT IS '�����-Ȯ����';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.LIMIT_RATE IS '���� �ѵ���(80/100)';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.LIMIT_RATE_NUMERATOR IS '���� �ѵ��� ����';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.LIMIT_RATE_DENOMINATOR IS '���� �ѵ��� �и�';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.PURCHASES_TAX_BILL_AMOUNT IS '�����Ծ� ���ݰ�꼭��';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.PURCHASES_BILL_AMOUNT IS '�����Ծ� ��������';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.DED_RANGE_AMOUNT IS '�������ɱݾ�';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.DED_TARGET_AMOUNT IS '�������ݾ�(�������ɱݾװ� �����Ծ� ������ �ݾ��� ���� �ݾ�)';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.DED_RATE_NUMERATOR IS '�������� ������ ����';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.DED_RATE_DENOMINATOR IS '�������� ������ �и�';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.DED_VAT_AMOUNT IS '������󼼾�';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.DED_PRE_QUARTER_AMOUNT IS '�̹̰������� ����-�����Ű��';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.DED_PRE_MONTHLY_AMOUNT IS '�̹̰������� ����-���������';
COMMENT ON COLUMN FI_VAT_RECYCLING_ETC.FIX_VAT_AMOUNT IS '����(����)�� ����(������󼼾�-�̹̰������� ���� �հ�)';

ALTER TABLE FI_VAT_RECYCLING_ETC ADD CONSTRAINT FI_VAT_RECYCLING_ETC_PK PRIMARY KEY (SOB_ID, ORG_ID, TAX_CODE, VAT_MNG_SERIAL) USING INDEX TABLESPACE FCM_TS_IDX;

-- INDEX
CREATE UNIQUE INDEX FI_VAT_RECYCLING_ETC_U1 ON FI_VAT_RECYCLING_ETC(RECYCLING_ETC_ID) TABLESPACE FCM_TS_IDX;

CREATE SEQUENCE FI_VAT_RECYCLING_ETC_S1;
