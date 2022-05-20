/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_ACCOUNTS
/* Description  : �ΰ������� ����.
/*
/* Reference by : FI_ACCOUNT_CONTROL���� VAT_ENABLED_FLAG ����� TRIGGER�� ���� �ݿ���.
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_ACCOUNTS
( ACCOUNT_CONTROL_ID              NUMBER        NOT NULL,
  ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL,
  SOB_ID                          NUMBER        NOT NULL,
  VAT_GUBUN                       VARCHAR2(10)  ,
  VAT_TYPE                        VARCHAR2(10)  ,
  VAT_ENABLED_FLAG                VARCHAR2(10)  ,    
  VAT_ASSET_GB                    VARCHAR2(10)  ,
  VAT_DOCUMENT_TYPE               VARCHAR2(10)  ,
  ENABLED_FLAG                    CHAR(1)       DEFAULT 'Y',
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

COMMENT ON TABLE FI_VAT_ACCOUNTS IS '�ΰ������� ��������';
COMMENT ON COLUMN FI_VAT_ACCOUNTS.ACCOUNT_CONTROL_ID IS '���� ID';
COMMENT ON COLUMN FI_VAT_ACCOUNTS.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN FI_VAT_ACCOUNTS.VAT_GUBUN IS '���Ը��ⱸ��';
COMMENT ON COLUMN FI_VAT_ACCOUNTS.VAT_TYPE IS '��꼭����';
COMMENT ON COLUMN FI_VAT_ACCOUNTS.VAT_ENABLED_FLAG IS 'VAT ��������(Ʈ���Ÿ� ���ؼ��� ����)';
COMMENT ON COLUMN FI_VAT_ACCOUNTS.VAT_ASSET_GB IS '�������ڻ� ����';
COMMENT ON COLUMN FI_VAT_ACCOUNTS.VAT_DOCUMENT_TYPE IS '���������� ����';
COMMENT ON COLUMN FI_VAT_ACCOUNTS.ENABLED_FLAG  IS '��� ����';

ALTER TABLE FI_VAT_ACCOUNTS ADD CONSTRAINT FI_VAT_ACCOUNTS_PK PRIMARY KEY (ACCOUNT_CONTROL_ID);

CREATE UNIQUE INDEX FI_VAT_ACCOUNTS_U1 ON FI_VAT_ACCOUNTS(ACCOUNT_CODE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_ACCOUNTS_N1 ON FI_VAT_ACCOUNTS(VAT_TYPE, VAT_ASSET_GB, ENABLED_FLAG, SOB_ID) TABLESPACE FCM_TS_IDX;  
CREATE INDEX FI_VAT_ACCOUNTS_N2 ON FI_VAT_ACCOUNTS(VAT_TYPE, VAT_DOCUMENT_TYPE, ENABLED_FLAG, SOB_ID) TABLESPACE FCM_TS_IDX;

ANALYZE TABLE FI_VAT_ACCOUNTS COMPUTE STATISTICS;
ANALYZE INDEX FI_VAT_ACCOUNTS_U1 COMPUTE STATISTICS;
ANALYZE INDEX FI_VAT_ACCOUNTS_N1 COMPUTE STATISTICS;
ANALYZE INDEX FI_VAT_ACCOUNTS_N2 COMPUTE STATISTICS;
