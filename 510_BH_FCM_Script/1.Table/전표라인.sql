/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_CUSTOMER_BALANCE_FORWARD
/* Description  : ��û����� �̿����賻��
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_CUSTOMER_BALANCE_FORWARD 
( PERIOD_NAME                     VARCHAR2(10)     NOT NULL,  -- ȸ����.
  SLIP_LINE_ID                    NUMBER           NOT NULL,  -- ��ǥ ���� ID.
  SOB_ID                          NUMBER           NOT NULL,
  ORG_ID                          NUMBER           NOT NULL,
  GL_DATE                         DATE             NOT NULL,  -- ȸ������. 
  ACCOUNT_BOOK_ID                 NUMBER           NOT NULL,  -- ȸ�����.
  ACCOUNT_CONTROL_ID              NUMBER           NOT NULL,  -- ��������ID.
  ACCOUNT_CODE                    VARCHAR2(20)     NOT NULL,  -- �����ڵ�.
  CURRENCY_CODE                   VARCHAR2(10)     NOT NULL,  -- ��ȭ.
  CUSTOMER_ID                     NUMBER           NOT NULL,  -- �ŷ�ó�ڵ�.
  MANAGEMENT1                     VARCHAR2(50)     ,          -- �����׸�1.
  MANAGEMENT2                     VARCHAR2(50)     ,          -- �����׸�2.
  REMAIN_AMOUNT                   NUMBER           DEFAULT 0, -- �ܾ�(��ȭ).
  REMAIN_CURR_AMOUNT              NUMBER           DEFAULT 0, -- �ܾ�(��ȭ).
  CREATION_DATE                   DATE             NOT NULL,
  CREATED_BY                      NUMBER           NOT NULL,
  LAST_UPDATE_DATE                DATE             NOT NULL,
  LAST_UPDATED_BY                 NUMBER           NOT NULL
) TABLESPACE FCM_TS_DATA;
COMMENT ON TABLE FI_CUSTOMER_BALANCE_FORWARD IS '��û����� �̿����賻��';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_FORWARD.PERIOD_NAME IS 'ȸ����';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_FORWARD.SLIP_LINE_ID IS '��ǥ ���� ID.';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_FORWARD.GL_DATE IS 'ȸ������';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_FORWARD.ACCOUNT_BOOK_ID IS 'ȸ�����';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_FORWARD.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_FORWARD.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_FORWARD.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_FORWARD.CUSTOMER_ID IS '�ŷ�ó�ڵ�';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_FORWARD.MANAGEMENT1 IS '�����׸�1';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_FORWARD.MANAGEMENT2 IS '�����׸�2';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_FORWARD.REMAIN_AMOUNT IS '�ܾ׿�ȭ';
COMMENT ON COLUMN APPS.FI_CUSTOMER_BALANCE_FORWARD.REMAIN_CURR_AMOUNT IS '�ܾ׿�ȭ';

CREATE UNIQUE INDEX FI_CUSTOMER_BALANCE_FORWARD_PK ON 
  FI_CUSTOMER_BALANCE_FORWARD(PERIOD_NAME, GL_DATE, SLIP_LINE_ID, ACCOUNT_BOOK_ID, ACCOUNT_CONTROL_ID, SOB_ID)
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

ALTER TABLE FI_CUSTOMER_BALANCE_FORWARD ADD ( 
  CONSTRAINT FI_CUSTOMER_BALANCE_FORWARD_PK PRIMARY KEY ( PERIOD_NAME, GL_DATE, SLIP_LINE_ID, ACCOUNT_BOOK_ID, ACCOUNT_CONTROL_ID, SOB_ID)
        );
