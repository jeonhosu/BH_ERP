/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BANK
/* Description  : �������MASTER
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BANK
( BANK_ID                         NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  BANK_GROUP                      VARCHAR2(20)    NOT NULL, /* ������� �׷��ڵ� */
  BANK_CODE                       VARCHAR2(20)    NOT NULL,  /* ��������ڵ� */
  BANK_NAME                       VARCHAR2(100)   ,  /* ���������(�ѱ�) */
  BANK_ENG_NAME                   VARCHAR2(100)   ,  /* ���������(����) */
  BANK_TYPE                       VARCHAR2(70)    ,  /* ����������� */
  VAT_NUMBER                      VARCHAR2(30)    ,  /* ����� ��Ϲ�ȣ */
  DC_LIMIT_AMOUNT                 NUMBER(11)      ,  /* �����ѵ��ݾ� */
  DC_METHOD_ID                    NUMBER          ,  /* ���η����� */
  DC_RATE1                        NUMBER(7,4)     ,  /* ������(90�� ����) */
  DC_RATE2                        NUMBER(7,4)     ,  /* ������(90�� ����) */
  LOAN_LIMIT_AMOUNT               NUMBER(11)      ,  /* �����ѵ��ݾ� */
  START_DATE                      DATE            ,  /* �ŷ� ������ */
  REMARK                          VARCHAR2(250)   ,
  ATTRIBUTE_A                     VARCHAR2(250)   ,
  ATTRIBUTE_B                     VARCHAR2(250)   ,
  ATTRIBUTE_C                     VARCHAR2(250)   ,
  ATTRIBUTE_D                     VARCHAR2(250)   ,
  ATTRIBUTE_E                     VARCHAR2(250)   ,
  ATTRIBUTE_1                     NUMBER          ,
  ATTRIBUTE_2                     NUMBER          ,
  ATTRIBUTE_3                     NUMBER          ,
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          ,
  ENABLED_FLAG                    VARCHAR2(1)     , /* ��뿩�� */
  EFFECTIVE_DATE_FR               DATE            NOT NULL, /* ��ȿ���� �������� */
  EFFECTIVE_DATE_TO               DATE            ,   /* ��ȿ���� �������� */
  CREATION_DATE                   DATE            NOT NULL, /* ������ */
  CREATED_BY                      NUMBER          NOT NULL, /* ������ */
  LAST_UPDATE_DATE                DATE            NOT NULL, /* ������ */
  LAST_UPDATED_BY                 NUMBER          NOT NULL  /* ������ */
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_BANK IS '�������(����)MASTER';
COMMENT ON COLUMN APPS.FI_BANK.BANK_ID IS '�������ID';
COMMENT ON COLUMN APPS.FI_BANK.BANK_GROUP IS '������� �׷��ڵ�';
COMMENT ON COLUMN APPS.FI_BANK.BANK_CODE IS '��������ڵ�';
COMMENT ON COLUMN APPS.FI_BANK.BANK_NAME IS '���������(�ѱ�)';
COMMENT ON COLUMN APPS.FI_BANK.BANK_ENG_NAME IS '���������(����)';
COMMENT ON COLUMN APPS.FI_BANK.BANK_TYPE IS '�����������';
COMMENT ON COLUMN APPS.FI_BANK.VAT_NUMBER IS '����� ��Ϲ�ȣ';
COMMENT ON COLUMN APPS.FI_BANK.DC_LIMIT_AMOUNT IS '�����ѵ��ݾ�';
COMMENT ON COLUMN APPS.FI_BANK.DC_RATE1 IS '������(90�� ����)';
COMMENT ON COLUMN APPS.FI_BANK.LOAN_LIMIT_AMOUNT IS '�����ѵ��ݾ�';
COMMENT ON COLUMN APPS.FI_BANK.DC_RATE2 IS '������(90�� ����)';
COMMENT ON COLUMN APPS.FI_BANK.DC_METHOD_ID IS '���η�����';
COMMENT ON COLUMN APPS.FI_BANK.START_DATE IS '�ŷ�������';
COMMENT ON COLUMN APPS.FI_BANK.ENABLED_FLAG IS '��뿩��';
COMMENT ON COLUMN APPS.FI_BANK.EFFECTIVE_DATE_FR IS '��ȿ���� ��������';
COMMENT ON COLUMN APPS.FI_BANK.EFFECTIVE_DATE_TO IS '��ȿ���� ��������';
COMMENT ON COLUMN APPS.FI_BANK.CREATION_DATE IS '������';
COMMENT ON COLUMN APPS.FI_BANK.CREATED_BY IS '������';
COMMENT ON COLUMN APPS.FI_BANK.LAST_UPDATE_DATE IS '������';
COMMENT ON COLUMN APPS.FI_BANK.LAST_UPDATED_BY IS '������';

-- PRIMARY KEY
CREATE UNIQUE INDEX FI_BANK_PK ON 
  FI_BANK(BANK_ID)
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

ALTER TABLE FI_BANK ADD ( 
  CONSTRAINT FI_BANK_PK PRIMARY KEY ( BANK_ID ) 
        );
        
-- UNIQUE INDEX.
CREATE UNIQUE INDEX FI_BANK_U1 ON FI_BANK(BANK_GROUP, BANK_CODE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BANK_N1 ON FI_BANK(SOB_ID, BANK_GROUP, BANK_CODE, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE FI_BANK_S1;
CREATE SEQUENCE FI_BANK_S1;
       
