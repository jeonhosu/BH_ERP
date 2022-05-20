/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_LOAN_PLAN
/* Description  : ���Ա� ��ȯ��ȹ
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_LOAN_PLAN 
( PLAN_DATE                       DATE          NOT NULL,       -- ��ȯ��ȹ����_���ϰ�����_��ȯ��.
  LOAN_NUM                        VARCHAR2(20)  NOT NULL,       -- ���Ա� ������ȣ.
  SOB_ID                          NUMBER        NOT NULL,       -- ȸ������.
  ORG_ID                          NUMBER        NOT NULL,       -- �����ID.  
  CURRENCY_CODE                   VARCHAR2(10)  ,               -- ��ȭ.  
  EXCHANGE_RATE                   NUMBER(10,4)  ,               -- ȯ��.
  REPAY_AMOUNT                    NUMBER(12)    DEFAULT 0,      -- ���ݻ�ȯ�ױݾ�.
  REPAY_CURR_AMOUNT               NUMBER(16,4)  DEFAULT 0,      -- ���ݻ�ȯ�ױݾ�_��ȭ.  
  INTEREST_AMOUNT                 NUMBER(12)    DEFAULT 0,      -- ���ڻ�ȯ�ױݾ�.
  INTEREST_CURR_AMOUNT            NUMBER(16,4)  DEFAULT 0,      -- ���ڻ�ȯ�ױݾ�_��ȭ.
  COMMISSION_AMOUNT               NUMBER(12)    DEFAULT 0,      -- ������.
  COMMISSION_CURR_AMOUNT          NUMBER(16,4)  DEFAULT 0,      -- ������(��ȭ).
  COST_CENTER_ID                  VARCHAR2(10)  ,               -- �ڽ�Ʈ��Ÿ.
  DEPT_ID                         NUMBER        NOT NULL,       -- ���Ǻμ�.
  USER_ID                         NUMBER        NOT NULL,       -- ������(�����).
  REMARK                          VARCHAR2(150) ,               -- ����.
  SLIP_DATE                       DATE          ,               -- ��ǥ��ǥ����.
  SLIP_NUM                        VARCHAR2(30)  ,               -- ��ǥ��ǥ��ȣ.
  SLIP_LINE_ID                    NUMBER        ,               -- ��ǥ��ǥ���.
  GL_DATE                         DATE          ,               -- Ȯ����ǥ����.
  GL_NUM                          VARCHAR2(30)  ,               -- Ȯ����ǥ��ȣ.  
  CREATION_DATE                   DATE          NOT NULL,       -- ������.
  CREATED_BY                      NUMBER        NOT NULL,       -- ������.
  LAST_UPDATE_DATE                DATE          NOT NULL,       -- ������.
  LAST_UPDATED_BY                 NUMBER        NOT NULL        -- ������.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_LOAN_PLAN IS '���Ա� ��ȯ ��ȹ����';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.PLAN_DATE IS '��ȯ��ȹ����_���ϰ�����_��ȯ��';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.LOAN_NUM IS '���Ա�_������ȣ';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.SOB_ID IS 'ȸ������';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.ORG_ID IS '�����ID';

COMMENT ON COLUMN APPS.FI_LOAN_PLAN.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.REPAY_AMOUNT IS '���ݻ�ȯ�ױݾ�';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.REPAY_CURR_AMOUNT IS '���ݻ�ȯ�ױݾ�_��ȭ';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.INTEREST_AMOUNT IS '���ڻ�ȯ�ױݾ�';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.INTEREST_CURR_AMOUNT IS '���ڻ�ȯ�ױݾ�_��ȭ';

COMMENT ON COLUMN APPS.FI_LOAN_PLAN.COST_CENTER_ID IS '�ڽ�Ʈ��Ÿ';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.DEPT_ID IS '���Ǻμ�';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.USER_ID IS '������(�����)';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.REMARK IS '����';

COMMENT ON COLUMN APPS.FI_LOAN_PLAN.SLIP_DATE IS '��ǥ��ǥ����';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.SLIP_NUM IS '��ǥ��ǥ��ȣ';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.SLIP_LINE_ID IS '��ǥ��ǥ���';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.GL_DATE IS 'Ȯ����ǥ����';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.GL_NUM IS 'Ȯ����ǥ��ȣ';

COMMENT ON COLUMN APPS.FI_LOAN_PLAN.CREATION_DATE IS '������';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.CREATED_BY IS '������';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.LAST_UPDATE_DATE IS '������';
COMMENT ON COLUMN APPS.FI_LOAN_PLAN.LAST_UPDATED_BY IS '������';


CREATE UNIQUE INDEX FI_LOAN_PLAN_PK ON 
  FI_LOAN_PLAN(PLAN_DATE, LOAN_NUM, SOB_ID)
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

ALTER TABLE FI_LOAN_PLAN ADD ( 
  CONSTRAINT FI_LOAN_PLAN_PK PRIMARY KEY (PLAN_DATE, LOAN_NUM, SOB_ID)
        );
