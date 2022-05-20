/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_TRIAL_BALANCE_BS
/* Description  : ����������� TABLE(��������ǥ)
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_TRIAL_BALANCE_BS 
( PERIOD_NAME                     VARCHAR2(10)  NOT NULL,  -- ȸ����.
  SOB_ID                          NUMBER        NOT NULL,  -- ȸ��ID.
  ORG_ID                          NUMBER        NOT NULL,  -- �����ID.
  ACCOUNT_BOOK_ID                 NUMBER        NOT NULL,
  ACCOUNT_CONTROL_ID              NUMBER        NOT NULL,  -- �������� ID.
  ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL,  -- �����ڵ�.    
  THIS_DR_AMOUNT                  NUMBER(16)    DEFAULT 0,  -- �������.
  THIS_CR_AMOUNT                  NUMBER(16)    DEFAULT 0,  -- ����뺯.  
  THIS_REMAIN_AMOUNT              NUMBER(16)    DEFAULT 0,  -- ����ܾ�.
  TOTAL_DR_AMOUNT                 NUMBER(16)    DEFAULT 0,  -- ��������(����+����).
  TOTAL_CR_AMOUNT                 NUMBER(16)    DEFAULT 0,  -- ����뺯(����+����).    
  TOTAL_REMAIN_AMOUNT             NUMBER(16)    DEFAULT 0,  -- �����ܾ�.  
  CREATION_DATE                   DATE          NOT NULL,
  CREATED_BY                      NUMBER        NOT NULL,  
  LAST_UPDATE_DATE                DATE          NOT NULL,  -- ������������.
  LAST_UPDATED_BY                 NUMBER        NOT NULL   -- ����������.  
) TABLESPACE FCM_TS_DATA ;

COMMENT ON TABLE FI_TRIAL_BALANCE_BS IS '�����������';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_BS.PERIOD_NAME IS '�������';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_BS.SOB_ID IS 'ȸ������';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_BS.ORG_ID IS '�����ID';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_BS.ACCOUNT_BOOK_ID IS 'ȸ����� ID'; 
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_BS.ACCOUNT_CONTROL_ID IS '�������� ID'; 
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_BS.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_BS.THIS_DR_AMOUNT IS '�������';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_BS.THIS_CR_AMOUNT IS '����뺯';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_BS.TOTAL_DR_AMOUNT IS '��������(����+����)';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_BS.TOTAL_CR_AMOUNT IS '����뺯(����+����)';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_BS.THIS_REMAIN_AMOUNT IS '����ܾ�';
COMMENT ON COLUMN APPS.FI_TRIAL_BALANCE_BS.TOTAL_REMAIN_AMOUNT IS '�����ܾ�';

CREATE UNIQUE INDEX FI_TRIAL_BALANCE_BS_PK ON 
  FI_TRIAL_BALANCE_BS(PERIOD_NAME, ACCOUNT_BOOK_ID, ACCOUNT_CONTROL_ID, SOB_ID )
  TABLESPACE FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  LOGGING
  STORAGE (
           INITIAL 20M
           MINEXTENTS 1
           MAXEXTENTS 2147483645
          );

ALTER TABLE FI_TRIAL_BALANCE_BS ADD ( 
  CONSTRAINT FI_TRIAL_BALANCE_BS_PK PRIMARY KEY ( PERIOD_NAME, ACCOUNT_BOOK_ID, ACCOUNT_CONTROL_ID, SOB_ID )
        );
