/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_DEPOSIT_MASTER
/* Description  : ������ ������.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_DEPOSIT_MASTER 
( BANK_ID                       NUMBER          NOT NULL, -- �������ID.
  BANK_ACCOUNT_ID               NUMBER          NOT NULL, -- �������ID.
  SOB_ID                        NUMBER          NOT NULL, -- ȸ������.
  ORG_ID                        NUMBER          NOT NULL, -- �����ID.
  DEPOSIT_GB                    VARCHAR2(10)    NOT NULL, -- �����ݱ���(DEPOSIT_GB).
  ACCOUNT_TYPE                  VARCHAR2(20)    NOT NULL, -- ����������(ACCOUNT_TYPE).
  ISSUE_DATE                    DATE            NOT NULL, -- ��������.
  DUE_DATE                      DATE            , -- ��������.
  CURRENCY_CODE                 VARCHAR2(10)    , -- ��ȭ.
  EXCHANGE_RATE                 NUMBER          , -- ȯ��.
  DEPOSIT_CURR_AMOUNT           NUMBER          DEFAULT 0, -- �ݾ�_��ȭ.
  DEPOSIT_AMOUNT                NUMBER          DEFAULT 0, -- �ݾ�.  
  INTER_RATE                    NUMBER          , -- ������.
  SPREAD_RATE                   NUMBER          , -- SPREAD_RATE.
  INTER_KIND                    VARCHAR2(10)    , -- ��������.
  INTER_TYPE                    VARCHAR2(10)    , -- ��������.
  PAYMENT_PERIOD                VARCHAR2(10)    , -- �����ֱ�.
  PAYMENT_COUNT                 NUMBER          , -- ����Ƚ��.
  MONTH_CURR_AMOUNT             NUMBER          DEFAULT 0, -- �����Աݾ�_��ȭ.
  MONTH_AMOUNT                  NUMBER          DEFAULT 0, -- �����Աݾ�. 
  TOTAL_PAYMENT_COUNT           NUMBER          , -- �ѳ���Ƚ��. 
  TOTAL_CURR_AMOUNT             NUMBER          DEFAULT 0, -- �ѳ��Աݾ�_��ȭ.
  TOTAL_AMOUNT                  NUMBER          DEFAULT 0, -- �ѳ��Աݾ�.  
  CANCEL_DATE                   DATE            , -- �ؾ�����.
  CANCEL_EXCHANGE_RATE          NUMBER          , -- �ؾ��ȯ��. 
  CANCEL_PRIN_AMOUNT            NUMBER          , -- �ؾ�ÿ���.
  CANCEL_PRIN_CURR_AMOUNT       NUMBER          , -- �ؾ�ÿ���_��ȭ.
  CANCEL_INTER_RATE             NUMBER          , -- �ؾ��������.
  CANCEL_INTER_AMOUNT           NUMBER          , -- �ؾ���̱ݾ�.
  CANCEL_INTER_CURR_AMOUNT      NUMBER          , -- �ؾ���̱ݾ�_��ȭ.
  CANCEL_AMOUNT                 NUMBER          , -- �ؾ�ݾ�.
  CANCEL_CURR_AMOUNT            NUMBER          , -- �ؾ�ݾ�_��ȭ.
  MORTGAGE_YN                   VARCHAR2(1)     DEFAULT 'N', -- �㺸����(Y/N).
  MORTGAGE_DATE                 DATE            , -- �㺸��������.
  FINAL_CURR_AMOUNT             NUMBER          DEFAULT 0, -- �����ݾ�_��ȭ.
  FINAL_AMOUNT                  NUMBER          DEFAULT 0, -- �����ݾ�.  
  TRANS_STATUS                  VARCHAR2(10)    NOT NULL, -- �ŷ�_����.
  COST_CENTER_ID                NUMBER          , -- �ڽ�Ʈ(COST)��Ÿ�ڵ�.
  REMARK                        VARCHAR2(100)   , -- ����.
  ENABLED_FLAG                  VARCHAR2(1)     DEFAULT 'Y', -- ���(Y/N).
  CREATION_DATE                 DATE            NOT NULL, -- ������.
  CREATED_BY                    NUMBER          NOT NULL, -- ������.
  LAST_UPDATE_DATE              DATE            NOT NULL, -- ������.
  LAST_UPDATED_BY               NUMBER          NOT NULL  -- ������.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_DEPOSIT_MASTER IS '������ MASTER';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.BANK_ID IS '�������ID';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.BANK_ACCOUNT_ID IS '�������ID';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.SOB_ID IS 'ȸ���ڵ�';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.ORG_ID IS '�����ID';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.DEPOSIT_GB IS '�����ݱ���(DEPOSIT_GB)';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.ACCOUNT_TYPE IS '��������(ACCOUNT_TYPE)';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.ISSUE_DATE IS '��������';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.DUE_DATE IS '��������';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.DEPOSIT_CURR_AMOUNT IS '�����ݾ�_��ȭ';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.DEPOSIT_AMOUNT IS '�����ݾ�';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.INTER_RATE IS '������';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.SPREAD_RATE IS 'SPREAD_RATE';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.INTER_KIND IS '��������';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.INTER_TYPE IS '��������';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.PAYMENT_PERIOD IS '�����ֱ�';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.PAYMENT_COUNT IS '����Ƚ��';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.MONTH_CURR_AMOUNT IS '�����Աݾ�_��ȭ';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.MONTH_AMOUNT IS '�����Աݾ�';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.TOTAL_PAYMENT_COUNT IS '�ѳ���Ƚ��';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.TOTAL_CURR_AMOUNT IS '�ѳ��Աݾ�_��ȭ';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.TOTAL_AMOUNT IS '�ѳ��Աݾ�';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.CANCEL_DATE IS '�ؾ�����';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.CANCEL_EXCHANGE_RATE IS '�ؾ��ȯ��';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.CANCEL_PRIN_AMOUNT IS '�ؾ�ÿ���';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.CANCEL_PRIN_CURR_AMOUNT IS '�ؾ�ÿ���_��ȭ';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.CANCEL_INTER_RATE IS '�ؾ��������';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.CANCEL_INTER_AMOUNT IS '�ؾ���̱ݾ�';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.CANCEL_INTER_CURR_AMOUNT IS '�ؾ���̱ݾ�_��ȭ';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.CANCEL_AMOUNT IS '�ؾ�ݾ�';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.CANCEL_CURR_AMOUNT IS '�ؾ�ݾ�_��ȭ';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.FINAL_CURR_AMOUNT IS '�����ݾ�_��ȭ';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.FINAL_AMOUNT IS '�����ݾ�';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.TRANS_STATUS IS '�ŷ�����(TRANS_STATUS)';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.COST_CENTER_ID IS '�ڽ�Ʈ(COST)��Ÿ�ڵ�';
COMMENT ON COLUMN APPS.FI_DEPOSIT_MASTER.REMARK IS '����';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.ENABLED_FLAG IS '���(Y/N)';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.CREATION_DATE IS '������';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.CREATED_BY IS '������';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.LAST_UPDATE_DATE IS '������';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.LAST_UPDATED_BY IS '������';

CREATE UNIQUE INDEX FI_DEPOSIT_MASTER_PK ON 
  FI_DEPOSIT_MASTER( BANK_ID, BANK_ACCOUNT_ID, SOB_ID )
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

ALTER TABLE FI_DEPOSIT_MASTER ADD ( 
  CONSTRAINT FI_DEPOSIT_MASTER_PK PRIMARY KEY ( BANK_ID, BANK_ACCOUNT_ID, SOB_ID )
        );
