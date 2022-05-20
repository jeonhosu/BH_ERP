/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_REALTY_LEASE
/* Description  : �ε��� �Ӵ볻��.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_REALTY_LEASE 
( REALTY_LEASE_ID                 NUMBER        NOT NULL,   -- �ε��� �Ӵ볻�� ID.
  TAX_CODE                        VARCHAR2(10)  NOT NULL,   -- ����� �ڵ�(TAX_CODE).
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  HOUSE_NUM                       VARCHAR2(20)  ,           -- ��.
  FLOOR_TYPE                      VARCHAR2(10)  NOT NULL,   -- ����/���� ����.
  FLOOR_COUNT                     VARCHAR2(20)  NOT NULL,   -- ����.
  ROOM_NO                         VARCHAR2(20)  ,           -- ȣ��.
  CUSTOMER_ID                     NUMBER        ,           -- �ŷ�óID.
  RESIDENT_NUM                    VARCHAR2(50)  ,           -- �ֹι�ȣ.
  AREA_M2                         NUMBER        ,           -- ����(M2)
  USE_DESC                        VARCHAR2(200) ,           -- �뵵.
  USE_DATE_FR                     DATE          ,           -- �Ӵ�Ⱓ(����).
  USE_DATE_TO                     DATE          ,           -- �Ӵ�Ⱓ(����).
  DEPOSIT_AMOUNT                  NUMBER        DEFAULT 0,  -- ������.
  MONTHLY_RENT_AMOUNT             NUMBER        DEFAULT 0,  -- ����.
  MAINTENANCE_FEE                 NUMBER        DEFAULT 0,  -- ������.
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

COMMENT ON TABLE FI_VAT_REALTY_LEASE IS '�ε����Ӵ볻��';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.REALTY_LEASE_ID IS '�ε��� �Ӵ볻�� ID';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.TAX_CODE IS '�ΰ��� �Ű� ������ڵ�';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.HOUSE_NUM IS '��';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.FLOOR_TYPE IS '������(����/����)';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.FLOOR_COUNT IS '����';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.ROOM_NO IS 'ȣ��';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.CUSTOMER_ID IS '�ŷ�óID';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.RESIDENT_NUM IS '�ֹι�ȣ';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.AREA_M2 IS '����';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.USE_DESC IS '�뵵';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.USE_DATE_FR IS '�Ӵ� ��������';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.USE_DATE_TO IS '�Ӵ� ��������';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.DEPOSIT_AMOUNT IS '������';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.MONTHLY_RENT_AMOUNT IS '����';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.MAINTENANCE_FEE IS '������';

ALTER TABLE FI_VAT_REALTY_LEASE ADD CONSTRAINT FI_VAT_REALTY_LEASE_PK PRIMARY KEY (REALTY_LEASE_ID);
CREATE INDEX FI_VAT_REALTY_LEASE_N1 ON FI_VAT_REALTY_LEASE(TAX_CODE, SOB_ID)  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_REALTY_LEASE_N2 ON FI_VAT_REALTY_LEASE(CUSTOMER_ID, SOB_ID)  TABLESPACE FCM_TS_IDX;
  
CREATE SEQUENCE FI_VAT_REALTY_LEASE_S1;
