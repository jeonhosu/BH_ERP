/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FI
/* Program Name : FI_CORPORATE_MASTER
/* Description  : �������� ����
/* Reference by : ȸ�� ���� ���� ����.
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_CORPORATE_MASTER              
( CORPORATE_ID                    NUMBER          NOT NULL,   -- ����ID.
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  CORPORATE_CODE                  VARCHAR2(20)    NOT NULL,   -- �����ڵ�.
  CORPORATE_NAME                  VARCHAR2(100)   NOT NULL,   -- ���θ�.
  CORPORATE_NAME_1                VARCHAR2(150)   ,           -- ���θ� ���.
  CORPORATE_NAME_2                VARCHAR2(200)   ,           -- ���θ� ����.
  LEGAL_NUM                       VARCHAR2(100)   NOT NULL,   -- ���ι�ȣ.
  PRESIDENT_NAME                  VARCHAR2(100)   NOT NULL,   -- ��ǥ��.
  BUSINESS_TYPE                   VARCHAR2(150)   ,           -- ����.
  BUSINESS_ITEM                   VARCHAR2(150)   ,           -- ����.  
  CORPORATE_TYPE                  VARCHAR2(10)    ,           -- ���α���.
  TEL_NUM                         VARCHAR2(20)    ,           -- ��ȭ.
  FAX_NUM                         VARCHAR2(20)    ,           -- �ѽ�.
  EMAIL                           VARCHAR2(100)   ,           -- EMAIL.
  ZIP_CODE                        VARCHAR2(20)    ,           -- �����ȣ.
  ADDR1                           VARCHAR2(150)   ,           -- �ּ�1.
  ADDR2                           VARCHAR2(150)   ,           -- �ּ�2.
  ENABLED_FLAG                    CHAR(1)         ,           -- ���.
  EFFECTIVE_DATE_FR               DATE NOT NULL   ,           -- ���� ��������.
  EFFECTIVE_DATE_TO               DATE            ,           -- ���� ��������.
  HOMETAX_ID                      VARCHAR2(100)   ,           -- Ȩ�ؽ� �α��� ID  
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
COMMENT ON COLUMN FI_CORPORATE_MASTER.CORPORATE_ID IS '����ID';
COMMENT ON COLUMN FI_CORPORATE_MASTER.CORPORATE_CODE IS '�����ڵ�';
COMMENT ON COLUMN FI_CORPORATE_MASTER.CORPORATE_NAME IS '���θ�';
COMMENT ON COLUMN FI_CORPORATE_MASTER.CORPORATE_NAME_1 IS '���θ�1';
COMMENT ON COLUMN FI_CORPORATE_MASTER.CORPORATE_NAME_2 IS '���θ�2';
COMMENT ON COLUMN FI_CORPORATE_MASTER.LEGAL_NUM IS '���ι�ȣ';
COMMENT ON COLUMN FI_CORPORATE_MASTER.PRESIDENT_NAME IS '��ǥ��';
COMMENT ON COLUMN FI_CORPORATE_MASTER.BUSINESS_TYPE IS '����';
COMMENT ON COLUMN FI_CORPORATE_MASTER.BUSINESS_ITEM IS '����';
COMMENT ON COLUMN FI_CORPORATE_MASTER.CORPORATE_TYPE IS '��ü Ÿ��(P-����, L-����)';
COMMENT ON COLUMN FI_CORPORATE_MASTER.TEL_NUM IS '��ȭ��ȣ';
COMMENT ON COLUMN FI_CORPORATE_MASTER.FAX_NUM IS '�ѽ���ȣ';
COMMENT ON COLUMN FI_CORPORATE_MASTER.EMAIL IS '�̸����ּ�';
COMMENT ON COLUMN FI_CORPORATE_MASTER.ZIP_CODE IS '�����ȣ';
COMMENT ON COLUMN FI_CORPORATE_MASTER.ADDR1 IS '�ּ�1';
COMMENT ON COLUMN FI_CORPORATE_MASTER.ADDR2 IS '�ּ�2';
COMMENT ON COLUMN FI_CORPORATE_MASTER.ENABLED_FLAG IS '��뿩��';
COMMENT ON COLUMN FI_CORPORATE_MASTER.EFFECTIVE_DATE_FR IS '���� ��������';
COMMENT ON COLUMN FI_CORPORATE_MASTER.EFFECTIVE_DATE_TO IS '���� ��������';
COMMENT ON COLUMN FI_CORPORATE_MASTER.HOMETAX_ID IS 'Ȩ�ؽ�ID';
COMMENT ON COLUMN FI_CORPORATE_MASTER.CREATION_DATE  IS '��������';
COMMENT ON COLUMN FI_CORPORATE_MASTER.CREATED_BY IS '������';
COMMENT ON COLUMN FI_CORPORATE_MASTER.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN FI_CORPORATE_MASTER.LAST_UPDATED_BY IS '����������';

-- PRKMARY KEY.
ALTER TABLE FI_CORPORATE_MASTER ADD CONSTRAINT FI_CORPORATE_MASTER_PK PRIMARY KEY(CORPORATE_CODE, SOB_ID);
-- CREATE INDEX.
CREATE UNIQUE INDEX FI_CORPORATE_MASTER_U1 ON FI_CORPORATE_MASTER(CORPORATE_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_CORPORATE_MASTER_N1 ON FI_CORPORATE_MASTER(ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO, SOB_ID) TABLESPACE FCM_TS_IDX;

-- CREATE SEQUENCE;
CREATE SEQUENCE FI_CORPORATE_MASTER_S1;

-- ANALYZE.
ANALYZE TABLE FI_CORPORATE_MASTER COMPUTE STATISTICS;
ANALYZE INDEX FI_CORPORATE_MASTER_U1 COMPUTE STATISTICS;
ANALYZE INDEX FI_CORPORATE_MASTER_N1 COMPUTE STATISTICS;
