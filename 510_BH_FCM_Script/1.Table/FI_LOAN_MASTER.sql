/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_LOAN_MASTER
/* Description  : ���Աݿ���
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_LOAN_MASTER 
( LOAN_NUM                        VARCHAR2(20)  NOT NULL,     -- ���Ա� ������ȣ.
  SOB_ID                          NUMBER        NOT NULL,     -- ȸ������.
  ORG_ID                          NUMBER        NOT NULL,     -- �����ID.
  LOAN_DESC                       VARCHAR2(100) ,             -- ���Գ���.
  LOAN_KIND                       VARCHAR2(10)  NOT NULL,     -- ���Ա�����.
  LOAN_TYPE                       VARCHAR2(10)  NOT NULL,     -- ���Աݱ���.
  LOAN_USE                        VARCHAR2(10)  ,             -- ���Ա� �뵵.
  L_ISSUE_DATE                    DATE          ,             -- ��������.
  L_DUE_DATE                      DATE          ,             -- ������������.
  L_CURRENCY_CODE                 VARCHAR2(10)  ,             -- ��ȭ.
  L_EXCHANGE_RATE                 NUMBER        ,             -- ȯ��.
  LIMIT_CURR_AMOUNT               NUMBER        DEFAULT 0,    -- �ѵ��ݾ�.
  LIMIT_AMOUNT                    NUMBER        DEFAULT 0,    -- �ѵ��ݾ�.  
  ISSUE_DATE                      DATE          ,             -- ��������.
  DUE_DATE                        DATE          ,             -- ��������.
  CURRENCY_CODE                   VARCHAR2(10)  ,             -- ��ȭ.
  EXCHANGE_RATE                   NUMBER        ,             -- ȯ��.
  LOAN_CURR_AMOUNT                NUMBER        ,             -- ���Աݾ�(��ȭ).
  LOAN_AMOUNT                     NUMBER        ,             -- ���Աݾ�(��ȭ).
  LOAN_ADD_CURR_AMOUNT            NUMBER        ,             -- �߰����Աݾ�(��ȭ).
  LOAN_ADD_AMOUNT                 NUMBER        ,             -- �߰����Աݾ�(��ȭ).
  LOAN_ACCOUNT_CONTROL_ID         NUMBER        ,             -- �Աݰ���ID.
  LOAN_BANK_ID                    NUMBER        ,             -- �Ա�����ID.
  LOAN_BANK_ACCOUNT_ID            NUMBER        ,             -- �Աݰ���ID.
  ENSURE_TYPE                     VARCHAR2(10)  ,             -- ��������.
  REPAY_CONDITION                 VARCHAR2(10)  ,             -- ���ݻ�ȯ����.
  TERM_YEAR                       NUMBER(2)     ,             -- ��ġ�Ⱓ_��.
  TERM_MONTH                      NUMBER(2)     ,             -- ��ġ�Ⱓ_��.
  REPAY_CYCLE_MONTH               NUMBER(2)     ,             -- ���ݻ�ȯ�ֱ�(����).
  START_REPAY_DATE                DATE          ,             -- ���ʿ��ݻ�ȯ��.
  INTER_RATE                      NUMBER(16,4)  ,             -- ������.
  SPREAD_RATE                     NUMBER(16,4)  ,             -- SPREAD��.
  INTER_TYPE                      VARCHAR2(10)  ,             -- ��������.
  INTER_PAYMENT_TYPE              VARCHAR2(10)  ,             -- ������������.
  START_INTER_DATE                DATE          ,             -- ��������������.  
  INTER_PAYMENT_CYCLE             VARCHAR2(10)  ,             -- ���������ֱ�.
  ADVANCE_INTER                   NUMBER(12)    ,             -- �������ڱݾ�.
  ADVANCE_CURR_INTER              NUMBER(16,4)  ,             -- �������ڱݾ�(��ȭ).
  INTER_ACCOUNT_CONTROL_ID        NUMBER        ,             -- ���� ���ް���ID.
  COMMI_AMOUNT                    NUMBER(12)    ,             -- ������.
  COMMI_CURR_AMOUNT               NUMBER(16,4)  ,             -- ������_��ȭ.
  COMMI_ACCOUNT_CONTROL_ID        NUMBER        ,             -- ������ ���ް���ID.
  REPAY_COUNT                     NUMBER(3)     DEFAULT 0,    -- ���ݻ�ȯ Ƚ��.
  REPAY_ONE_AMOUNT                NUMBER(12)    DEFAULT 0,    -- 1ȸ��ȯ�ױݾ�.
  REPAY_ONE_CURR_AMOUNT           NUMBER(16,4)  DEFAULT 0,    -- 1ȸ��ȯ�ױݾ�(��ȭ).
  REPAY_SUM_AMOUNT                NUMBER(12)    DEFAULT 0,    -- ��ȯ�״���.
  REPAY_SUM_CURR_AMOUNT           NUMBER(16,4)  DEFAULT 0,    -- ��ȯ�״���(��ȭ).
  REPAY_LAST_DATE                 DATE          ,             -- ������ȯ��.
  REPAY_INTER_COUNT               NUMBER(3)     DEFAULT 0,    -- ���ڻ�ȯ Ƚ��.
  REPAY_INTER_SUM_AMOUNT          NUMBER(12)    DEFAULT 0,    -- ���ڻ�ȯ�״���.
  REPAY_INTER_SUM_CURR_AMOUNT     NUMBER(16,4)  DEFAULT 0,    -- ���ڻ�ȯ�״���(��ȭ).
  COST_CENTER_ID                  NUMBER        ,             -- �ڽ�Ʈ��Ÿ.  
  REMARK                          VARCHAR2(100) ,             -- ����.
  MORTGAGE_REMARK                 VARCHAR2(100) ,             -- �㺸����.
  CREATION_DATE                   DATE          NOT NULL,     -- ��������.
  CREATED_BY                      NUMBER        NOT NULL,     -- ������.
  LAST_UPDATE_DATE                DATE          NOT NULL,     -- ������������.
  LAST_UPDATED_BY                 NUMBER        NOT NULL      -- ����������.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_LOAN_MASTER IS '���Ա� ����';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_NUM IS '���Աݰ�����ȣ';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.SOB_ID IS 'ȸ������';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.ORG_ID IS '�����ID';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_DESC IS '���� ����';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_KIND IS '���Ա�����(LOAN_KIND)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_TYPE IS '���Աݱ���(LOAN_TYPE)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_USE IS '���Ա� �뵵(LOAN_USE)';

COMMENT ON COLUMN APPS.FI_LOAN_MASTER.L_ISSUE_DATE IS '�ѵ� ��������';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.L_DUE_DATE IS '�ѵ� ��������';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.L_CURRENCY_CODE IS '�ѵ����� ��ȭ';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.L_EXCHANGE_RATE IS '�ѵ����� ȯ��';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LIMIT_CURR_AMOUNT IS '�ѵ�����ݾ�(��ȭ)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LIMIT_AMOUNT IS '�ѵ��������Աݾ�(��ȭ)';

COMMENT ON COLUMN APPS.FI_LOAN_MASTER.ISSUE_DATE IS '��������';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.DUE_DATE IS '��������';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_CURR_AMOUNT IS '���Աݾ�(��ȭ)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_AMOUNT IS '���Աݾ�(��ȭ)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_ADD_CURR_AMOUNT IS '�߰����Աݾ�(��ȭ)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_ADD_AMOUNT IS '�߰����Ծ�(��ȭ)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_ACCOUNT_CONTROL_ID IS '�Աݰ���ID';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_BANK_ID IS '�Ա�����ID';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LOAN_BANK_ACCOUNT_ID IS '�Աݰ���ID';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.ENSURE_TYPE IS '��������';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_CONDITION IS '���ݻ�ȯ����';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.TERM_YEAR IS '��ġ�Ⱓ_��';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.TERM_MONTH IS '��ġ�Ⱓ_��';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_CYCLE_MONTH IS '���ݻ�ȯ�ֱ�(����)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.START_REPAY_DATE IS '���ʿ��ݻ�ȯ��';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.INTER_RATE IS '������';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.SPREAD_RATE IS 'SPREAD��';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.INTER_TYPE IS '��������';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.INTER_PAYMENT_TYPE IS '������������';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.START_INTER_DATE IS '��������������';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.INTER_PAYMENT_CYCLE IS '���������ֱ�';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.ADVANCE_INTER IS '�������ڱݾ�';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.ADVANCE_CURR_INTER IS '�������ڱݾ�(��ȭ)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.INTER_ACCOUNT_CONTROL_ID IS '���� ���ް���ID';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.COMMI_AMOUNT IS '������';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.COMMI_CURR_AMOUNT IS '������(��ȭ)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.COMMI_ACCOUNT_CONTROL_ID IS '������ ���ް���ID';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_COUNT IS '���ݻ�ȯ_Ƚ��';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_ONE_AMOUNT IS '1ȸ��ȯ�ױݾ�';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_ONE_CURR_AMOUNT IS '1ȸ��ȯ�ױݾ�(��ȭ)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_SUM_AMOUNT IS '��ȯ�״���';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_SUM_CURR_AMOUNT IS '��ȯ�״���(��ȭ)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_LAST_DATE IS '������ȯ��';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_INTER_COUNT IS '���ڻ�ȯ_Ƚ��';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_INTER_SUM_AMOUNT IS '���ڻ�ȯ�״���';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REPAY_INTER_SUM_CURR_AMOUNT IS '���ڻ�ȯ�״���(��ȭ)';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.COST_CENTER_ID IS '�ڽ�Ʈ��Ÿ';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.REMARK IS '����';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.MORTGAGE_REMARK IS '�㺸����';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.CREATION_DATE IS '����DATA���� ����';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.CREATED_BY IS '����DATA���� USER';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LAST_UPDATE_DATE IS '����DATA���� ����';
COMMENT ON COLUMN APPS.FI_LOAN_MASTER.LAST_UPDATED_BY IS '����DATA���� USER';

CREATE UNIQUE INDEX FI_LOAN_MASTER_PK ON 
  FI_LOAN_MASTER(LOAN_NUM, SOB_ID)
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

ALTER TABLE FI_LOAN_MASTER ADD ( 
  CONSTRAINT FI_LOAN_MASTER_PK PRIMARY KEY (LOAN_NUM, SOB_ID)
        );
