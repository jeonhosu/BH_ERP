/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FI
/* Program Name : FI_BUSINESS_MASTER
/* Description  : ������� ����
/* Reference by : ȸ�� ����� ���� ����.
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BUSINESS_MASTER
( BUSINESS_ID                     NUMBER          NOT NULL,   -- �����ID.
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  BUSINESS_CODE                   VARCHAR2(20)    NOT NULL,   -- ������ڵ�.
  BUSINESS_NAME                   VARCHAR2(100)   NOT NULL,   -- ������.
  BUSINESS_NAME_1                 VARCHAR2(150)   ,           -- ������ ���.
  BUSINESS_NAME_2                 VARCHAR2(200)   ,           -- ������ ����.
  VAT_NUM                         VARCHAR2(100)   NOT NULL,   -- ����ڹ�ȣ.
  PRESIDENT_NAME                  VARCHAR2(100)   NOT NULL,   -- ��ǥ��.
  BUSINESS_TYPE                   VARCHAR2(150)   ,           -- ����.
  BUSINESS_ITEM                   VARCHAR2(150)   ,           -- ����.  
  TEL_NUM                         VARCHAR2(20)    ,           -- ��ȭ.
  FAX_NUM                         VARCHAR2(20)    ,           -- �ѽ�.
  EMAIL                           VARCHAR2(100)   ,           -- EMAIL.
  ZIP_CODE                        VARCHAR2(20)    ,           -- �����ȣ.
  ADDR1                           VARCHAR2(150)   ,           -- �ּ�1.
  ADDR2                           VARCHAR2(150)   ,           -- �ּ�2.
  CORPORATE_ID                    NUMBER          ,           -- ����ID.
  TAX_OFFICE_CODE                 VARCHAR2(10)    ,           -- �������ڵ�.
  BANK_CODE                       VARCHAR2(10)    ,           -- �����ڵ�.
  BANK_ACCOUNT_CODE               VARCHAR2(10)    ,           -- ��������ڵ�.
  ENABLED_FLAG                    CHAR(1)         ,           -- ���.
  EFFECTIVE_DATE_FR               DATE NOT NULL   ,           -- ���� ��������.
  EFFECTIVE_DATE_TO               DATE            ,           -- ���� ��������.
  ATTRIBUTE_A                     VARCHAR2(100)   ,
  ATTRIBUTE_B                     VARCHAR2(100)   ,
  ATTRIBUTE_C                     VARCHAR2(100)   ,
  ATTRIBUTE_D                     VARCHAR2(100)   ,
  ATTRIBUTE_E                     VARCHAR2(100)   ,
  ATTRIBUTE_1                     NUMBER          ,
  ATTRIBUTE_2                     NUMBER          ,
  ATTRIBUTE_3                     NUMBER          ,
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN FI_BUSINESS_MASTER.BUSINESS_ID IS '�����ID';
COMMENT ON COLUMN FI_BUSINESS_MASTER.BUSINESS_CODE IS '������ڵ�';
COMMENT ON COLUMN FI_BUSINESS_MASTER.BUSINESS_NAME IS '������';
COMMENT ON COLUMN FI_BUSINESS_MASTER.BUSINESS_NAME_1 IS '������1';
COMMENT ON COLUMN FI_BUSINESS_MASTER.BUSINESS_NAME_2 IS '������2';
COMMENT ON COLUMN FI_BUSINESS_MASTER.VAT_NUM IS '����ڹ�ȣ';
COMMENT ON COLUMN FI_BUSINESS_MASTER.PRESIDENT_NAME IS '��ǥ��';
COMMENT ON COLUMN FI_BUSINESS_MASTER.BUSINESS_TYPE IS '����';
COMMENT ON COLUMN FI_BUSINESS_MASTER.BUSINESS_ITEM IS '����';
COMMENT ON COLUMN FI_BUSINESS_MASTER.TEL_NUM IS '��ȭ��ȣ';
COMMENT ON COLUMN FI_BUSINESS_MASTER.FAX_NUM IS '�ѽ���ȣ';
COMMENT ON COLUMN FI_BUSINESS_MASTER.EMAIL IS '�̸����ּ�';
COMMENT ON COLUMN FI_BUSINESS_MASTER.ZIP_CODE IS '�����ȣ';
COMMENT ON COLUMN FI_BUSINESS_MASTER.ADDR1 IS '�ּ�1';
COMMENT ON COLUMN FI_BUSINESS_MASTER.ADDR2 IS '�ּ�2';
COMMENT ON COLUMN FI_BUSINESS_MASTER.CORPORATE_ID IS '����ID';
COMMENT ON COLUMN FI_BUSINESS_MASTER.TAX_OFFICE_CODE IS '�������ڵ�';
COMMENT ON COLUMN FI_BUSINESS_MASTER.BANK_CODE IS '�����ڵ�';
COMMENT ON COLUMN FI_BUSINESS_MASTER.BANK_ACCOUNT_CODE IS '��������ڵ�';
COMMENT ON COLUMN FI_BUSINESS_MASTER.ENABLED_FLAG IS '��뿩��';
COMMENT ON COLUMN FI_BUSINESS_MASTER.EFFECTIVE_DATE_FR IS '���� ��������';
COMMENT ON COLUMN FI_BUSINESS_MASTER.EFFECTIVE_DATE_TO IS '���� ��������';
COMMENT ON COLUMN FI_BUSINESS_MASTER.CREATION_DATE  IS '��������';
COMMENT ON COLUMN FI_BUSINESS_MASTER.CREATED_BY IS '������';
COMMENT ON COLUMN FI_BUSINESS_MASTER.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN FI_BUSINESS_MASTER.LAST_UPDATED_BY IS '����������';

-- PRKMARY KEY.
ALTER TABLE FI_BUSINESS_MASTER ADD CONSTRAINT FI_BUSINESS_MASTER_PK PRIMARY KEY(BUSINESS_CODE, SOB_ID);
-- CREATE INDEX.
CREATE UNIQUE INDEX FI_BUSINESS_MASTER_U1 ON FI_BUSINESS_MASTER(BUSINESS_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BUSINESS_MASTER_N1 ON FI_BUSINESS_MASTER(ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO, SOB_ID) TABLESPACE FCM_TS_IDX;

-- CREATE SEQUENCE;
CREATE SEQUENCE FI_BUSINESS_MASTER_S1;

-- ANALYZE.
ANALYZE TABLE FI_BUSINESS_MASTER COMPUTE STATISTICS;
ANALYZE INDEX FI_BUSINESS_MASTER_U1 COMPUTE STATISTICS;
ANALYZE INDEX FI_BUSINESS_MASTER_N1 COMPUTE STATISTICS;
