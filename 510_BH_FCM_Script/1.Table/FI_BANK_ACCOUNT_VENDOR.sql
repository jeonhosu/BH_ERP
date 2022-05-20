/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_BANK_ACCOUNT_VENDOR
/* Description  : �ŷ�ó ������� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
--DROP TABLE FI_BANK_ACCOUNT CASCADE CONSTRAINTS ;

CREATE TABLE FI_BANK_ACCOUNT_VENDOR 
( BANK_ACCOUNT_ID               NUMBER           NOT NULL,
  SOB_ID                        NUMBER           NOT NULL,
  ORG_ID                        NUMBER           NOT NULL,  
  VENDOR_TYPE                   VARCHAR2(10)     NOT NULL,    -- �ŷ�ó����(CUSTOMER-����, SUPPLIER-���޻�).
  VENDOR_ID                     NUMBER           ,            /* ���޻�, ���� ID */
  BANK_ACCOUNT_CODE             VARCHAR2(50)     NOT NULL,    /* �����ڵ� */
  BANK_ACCOUNT_NAME             VARCHAR2(100)    NOT NULL,    /* ���¸� */
  BANK_ID                       NUMBER           NOT NULL,    /* ���� ID */
  BANK_ACCOUNT_NUM              VARCHAR2(50)     NOT NULL,    /* ���¹�ȣ */  
  OWNER_NAME                    VARCHAR2(100)    ,            /* ������ */
  ACCOUNT_TYPE                  VARCHAR2(70)     ,            /* ���� ���� */        
  CURRENCY_CODE                 VARCHAR2(10)     ,            /* ��ȭ */
  REMARK                        VARCHAR2(100)    ,            /* ���� */
  ATTRIBUTE_A                   VARCHAR2(250)    ,
  ATTRIBUTE_B                   VARCHAR2(250)    ,
  ATTRIBUTE_C                   VARCHAR2(250)    ,
  ATTRIBUTE_D                   VARCHAR2(250)    ,
  ATTRIBUTE_E                   VARCHAR2(250)    ,
  ATTRIBUTE_1                   NUMBER           ,
  ATTRIBUTE_2                   NUMBER           ,
  ATTRIBUTE_3                   NUMBER           ,
  ATTRIBUTE_4                   NUMBER           ,
  ATTRIBUTE_5                   NUMBER           ,
  ENABLED_FLAG                  VARCHAR2(1)      DEFAULT 'Y', /* ���(Y/N) */
  EFFECTIVE_DATE_FR             DATE             NOT NULL, 
  EFFECTIVE_DATE_TO             DATE             ,
  CREATION_DATE                 DATE             NOT NULL,    /* ������ */
  CREATED_BY                    NUMBER           NOT NULL,    /* ������ */
  LAST_UPDATE_DATE              DATE             NOT NULL,    /* ������ */
  LAST_UPDATED_BY               NUMBER           NOT NULL     /* ������ */ 
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE  FI_BANK_ACCOUNT_VENDOR IS '�ŷ�ó ���¹�ȣ������';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_ID IS '������� ID';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.VENDOR_TYPE IS '�ŷ�ó����(CUSTOMER-����, SUPPLIER-���޻�)';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.VENDOR_ID IS '���޻�, ���� ID';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_NAME IS '���¸�';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.BANK_ID IS '����ID(�����ڵ�:BANK_CODE)';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_NUM IS '���¹�ȣ';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.OWNER_NAME IS '������';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.ACCOUNT_TYPE IS '���� ����(�����ڵ�:ACCOUNT_TYPE)';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.REMARK IS '���';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.ENABLED_FLAG IS '���(Y/N)';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.EFFECTIVE_DATE_FR IS '��ȿ���� ��������';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.EFFECTIVE_DATE_TO IS '��ȿ���� ��������';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.CREATION_DATE IS '������';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.CREATED_BY IS '������';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.LAST_UPDATE_DATE IS '������';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.LAST_UPDATED_BY IS '������';

-- Primary Key.
ALTER TABLE FI_BANK_ACCOUNT_VENDOR ADD CONSTRAINTS FI_BANK_ACCOUNT_VENDOR_PK PRIMARY KEY(BANK_ACCOUNT_CODE, SOB_ID, ORG_ID);

-- Unique Index.
CREATE UNIQUE INDEX FI_BANK_ACCOUNT_VENDOR_U1 ON FI_BANK_ACCOUNT_VENDOR(BANK_ACCOUNT_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BANK_ACCOUNT_VENDOR_N9 ON FI_BANK_ACCOUNT_VENDOR(BANK_ACCOUNT_CODE, SOB_ID, ORG_ID, ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE FI_BANK_ACCOUNT_VENDOR_S1;
