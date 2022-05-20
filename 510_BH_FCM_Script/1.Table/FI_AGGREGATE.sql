/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_AGGREGATE
/* Description  : ������������
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_AGGREGATE 
( PERIOD_NAME                     VARCHAR2(10)    NOT NULL,     /* ������� */
  SOB_ID                          NUMBER          NOT NULL,     /* ȸ������ */
  ORG_ID                          NUMBER          NOT NULL,     /* �����ID */
  ACCOUNT_BOOK_ID                 NUMBER          NOT NULL,
  ACCOUNT_CONTROL_ID              NUMBER          NOT NULL,     /* �������� ID */
  ACCOUNT_CODE                    VARCHAR2(20)    NOT NULL,     /* �����ڵ� */
  CURRENCY_CODE                   VARCHAR2(10)    NOT NULL,     /* ��ȭ */
  PERIOD_DR_AMOUNT                NUMBER          DEFAULT 0,    /* ��� �����ݾ� */
  PERIOD_CR_AMOUNT                NUMBER          DEFAULT 0,    /* ��� �뺯�ݾ� */  
  YEAR_DR_AMOUNT                  NUMBER          DEFAULT 0,    /* �� �����ݾ� */
  YEAR_CR_AMOUNT                  NUMBER          DEFAULT 0,    /* �� �뺯�ݾ� */
  TOTAL_DR_AMOUNT                 NUMBER          DEFAULT 0,    /* �� ���� �����ݾ� */
  TOTAL_CR_AMOUNT                 NUMBER          DEFAULT 0,    /* �� ���� �뺯�ݾ� */
  BASE_PERIOD_DR_AMOUNT           NUMBER          DEFAULT 0, 
  BASE_PERIOD_CR_AMOUNT           NUMBER          DEFAULT 0,
  BASE_YEAR_DR_AMOUNT             NUMBER          DEFAULT 0,
  BASE_YEAR_CR_AMOUNT             NUMBER          DEFAULT 0,
  BASE_TOTAL_DR_AMOUNT            NUMBER          DEFAULT 0,
  BASE_TOTAL_CR_AMOUNT            NUMBER          DEFAULT 0,
  CREATION_DATE                   DATE            NOT NULL,     /* ������ */
  CREATED_BY                      NUMBER          NOT NULL,     /* ������ */
  LAST_UPDATE_DATE                DATE            NOT NULL,     /* ������ */
  LAST_UPDATED_BY                 NUMBER          NOT NULL      /* ������ */
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_AGGREGATE IS '������������';
COMMENT ON COLUMN APPS.FI_AGGREGATE.PERIOD_NAME IS 'ȸ����';
COMMENT ON COLUMN APPS.FI_AGGREGATE.SOB_ID IS 'ȸ������';
COMMENT ON COLUMN APPS.FI_AGGREGATE.ORG_ID IS '�����ID';
COMMENT ON COLUMN APPS.FI_AGGREGATE.ACCOUNT_CONTROL_ID IS '�������� ID';
COMMENT ON COLUMN APPS.FI_AGGREGATE.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_AGGREGATE.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_AGGREGATE.PERIOD_DR_AMOUNT IS '�� �����ݾ�';
COMMENT ON COLUMN APPS.FI_AGGREGATE.PERIOD_CR_AMOUNT IS '�� �뺯�ݾ�';
COMMENT ON COLUMN APPS.FI_AGGREGATE.YEAR_DR_AMOUNT IS '�� �����ݾ�';
COMMENT ON COLUMN APPS.FI_AGGREGATE.YEAR_CR_AMOUNT IS '�� �뺯�ݾ�';
COMMENT ON COLUMN APPS.FI_AGGREGATE.TOTAL_DR_AMOUNT IS '���� �����ݾ�';
COMMENT ON COLUMN APPS.FI_AGGREGATE.TOTAL_CR_AMOUNT IS '���� �뺯�ݾ�';
COMMENT ON COLUMN APPS.FI_AGGREGATE.BASE_PERIOD_DR_AMOUNT IS '�⺻��ȭ �� �����ݾ�';
COMMENT ON COLUMN APPS.FI_AGGREGATE.BASE_PERIOD_CR_AMOUNT IS '�⺻��ȭ �� �뺯�ݾ�';
COMMENT ON COLUMN APPS.FI_AGGREGATE.BASE_YEAR_DR_AMOUNT IS '�⺻��ȭ �� �����ݾ�';
COMMENT ON COLUMN APPS.FI_AGGREGATE.BASE_YEAR_CR_AMOUNT IS '�⺻��ȭ �� �뺯�ݾ�';
COMMENT ON COLUMN APPS.FI_AGGREGATE.BASE_TOTAL_DR_AMOUNT IS '�⺻��ȭ ���� �����ݾ�';
COMMENT ON COLUMN APPS.FI_AGGREGATE.BASE_TOTAL_CR_AMOUNT IS '�⺻��ȭ ���� �뺯�ݾ�';

CREATE UNIQUE INDEX FI_AGGREGATE_PK ON
  FI_AGGREGATE(PERIOD_NAME, ACCOUNT_CONTROL_ID, CURRENCY_CODE,  SOB_ID, ACCOUNT_BOOK_ID)
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

ALTER TABLE FI_AGGREGATE ADD ( 
  CONSTRAINT FI_AGGREGATE_PK PRIMARY KEY (PERIOD_NAME, ACCOUNT_CONTROL_ID, CURRENCY_CODE,  SOB_ID, ACCOUNT_BOOK_ID)
        );

CREATE INDEX FI_AGGREGATE_N1 ON FI_AGGREGATE(PERIOD_NAME, SOB_ID) TABLESPACE FCM_TS_IDX;
