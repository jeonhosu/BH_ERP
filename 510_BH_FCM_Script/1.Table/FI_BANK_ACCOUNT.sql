/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_BANK_ACCOUNT
/* Description  : ������� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
--DROP TABLE FI_BANK_ACCOUNT CASCADE CONSTRAINTS ;

CREATE TABLE FI_BANK_ACCOUNT 
( BANK_ACCOUNT_ID               NUMBER           NOT NULL,
  SOB_ID                        NUMBER           NOT NULL,
  ORG_ID                        NUMBER           NOT NULL,  
  BANK_ACCOUNT_CODE             VARCHAR2(50)     NOT NULL,   /* �����ڵ� */
  BANK_ACCOUNT_NAME             VARCHAR2(100)    NOT NULL,   /* ���¸� */
  BANK_ID                       NUMBER           NOT NULL,   /* ���� ID */
  BANK_ACCOUNT_NUM              VARCHAR2(50)     NOT NULL,   /* ���¹�ȣ */  
  OWNER_NAME                    VARCHAR2(100)    ,           /* ������ */
  ACCOUNT_TYPE                  VARCHAR2(70)     ,           /* ������ ����(����, ����, ����) */        
  GL_CONTROL_YN                 VARCHAR2(1)      ,           /* ��,���� ������� ���� */  
  CURRENCY_CODE                 VARCHAR2(10)     ,            /* ��ȭ */
  LIMIT_AMOUNT                  NUMBER(16,4)     DEFAULT 0,   /* �ѵ��ݾ� */
  USE_AMOUNT                    NUMBER(16,4)     DEFAULT 0,   /* ���ݾ� */  
  REMAIN_AMOUNT                 NUMBER(16,4)     DEFAULT 0,   /* �ܾ� �ݾ� */
  ACCOUNT_OWNER_TYPE            VARCHAR2(70)     NOT NULL,    /* ���� ������ Ÿ��(�ڻ�, ���޻�, ����) */
  SUPPLIER_CUSTOMER_ID          NUMBER           ,            /* ���޻�, ���� ID */  
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

COMMENT ON TABLE  FI_BANK_ACCOUNT IS '������¹�ȣ������';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.BANK_ACCOUNT_ID IS '������� ID';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.BANK_ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.BANK_ACCOUNT_NAME IS '���¸�';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.BANK_ID IS '����ID';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.BANK_ACCOUNT_NUM IS '���¹�ȣ';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.OWNER_NAME IS '������';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.ACCOUNT_TYPE IS '������ ����(����, ����, ����)';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.GL_CONTROL_YN IS '������ ������� ����';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.LIMIT_AMOUNT IS '�ѵ�';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.USE_AMOUNT IS '���ݾ�';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.REMAIN_AMOUNT IS '�ܾױݾ�';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.ACCOUNT_OWNER_TYPE IS '���� ������ Ÿ��(�ڻ�,���޻�,����)';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.SUPPLIER_CUSTOMER_ID IS '���޻�, ���� ID';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.REMARK IS '���';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.ENABLED_FLAG IS '���(Y/N)';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.EFFECTIVE_DATE_FR IS '��ȿ���� ��������';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.EFFECTIVE_DATE_TO IS '��ȿ���� ��������';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.CREATION_DATE IS '������';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.CREATED_BY IS '������';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.LAST_UPDATE_DATE IS '������';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.LAST_UPDATED_BY IS '������';

-- Primary Key.
CREATE UNIQUE INDEX FI_BANK_ACCOUNT_PK ON 
  FI_BANK_ACCOUNT(BANK_ACCOUNT_CODE, SOB_ID)  
  TABLESPACE FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  LOGGING
  STORAGE (
           INITIAL 64K
           MINEXTENTS 1
           MAXEXTENTS 2147483645
          );
          
ALTER TABLE FI_BANK_ACCOUNT ADD ( 
  CONSTRAINT FI_BANK_ACCOUNT_PK PRIMARY KEY (BANK_ACCOUNT_CODE, SOB_ID)
        );

-- Unique Index.
CREATE UNIQUE INDEX FI_BANK_ACCOUNT_U1 ON FI_BANK_ACCOUNT(BANK_ACCOUNT_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BANK_ACCOUNT_N1 ON FI_BANK_ACCOUNT(SOB_ID, BANK_ACCOUNT_NUM) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BANK_ACCOUNT_N2 ON FI_BANK_ACCOUNT(SOB_ID, ACCOUNT_OWNER_TYPE, ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE FI_BANK_ACCOUNT_S1;
