/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_PAYABLE_BILL
/* Description  : ���� ����/���ھ���/��ǥ ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_PAYABLE_BILL 
( PAYABLE_BILL_ID                 NUMBER        NOT NULL,   -- ���޾��� ����ID.
  BILL_NUM                        VARCHAR2(30)  NOT NULL,   -- ����/��ǥ��ȣ.  
  SOB_ID                          NUMBER        NOT NULL,   -- ȸ��ID.
  ORG_ID                          NUMBER        NOT NULL,   -- �����ID.
  BILL_CLASS                      VARCHAR2(1)   NOT NULL,   -- ����(1)/��ǥ(2) ����.
  BANK_ID                         NUMBER        NOT NULL,   -- �������ID.
  ISSUE_DATE                      DATE          ,           -- ��������.
  DUE_DATE                        DATE          ,           -- ��������.
  CUSTOMER_ID                     NUMBER        ,           -- �ŷ�óID.
  BILL_STATUS                     VARCHAR2(1)   NOT NULL,   -- ����/��ǥ����.
  BILL_AMOUNT                     NUMBER        ,           -- ����/��ǥ�ݾ�.
  ACCOUNT_CONTROL_ID              NUMBER        ,           -- �������ڵ�ID.
  ACCOUNT_CODE                    VARCHAR2(20)  ,           -- �������ڵ�.  
  REMARK                          VARCHAR2(150) ,           -- ����.
  RECEIVE_DATE                    DATE          NOT NULL,   -- ���� ��������.
  CLOSE_DATE                      DATE          ,           -- �������.
  PAYMENT_DATE                    DATE          ,           -- �ǰ�����.
  BAD_DATE                        DATE          ,           -- �ε�����.
  PAYMENT_CANCEL_DATE             DATE          ,           -- ���������.
  SLIP_LINE_ID                    NUMBER        ,           -- ��ǥ LINE ID.
  CREATION_DATE                   DATE          NOT NULL,   -- ������.
  CREATED_BY                      NUMBER        NOT NULL,   -- ������.
  LAST_UPDATE_DATE                DATE          NOT NULL,   -- ������.
  LAST_UPDATED_BY                 NUMBER        NOT NULL    -- ������.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_PAYABLE_BILL IS '���޾���-������';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.PAYABLE_BILL_ID IS '���޾��� ����ID';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.BILL_NUM IS '����/��ǥ��ȣ';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.SOB_ID IS 'ȸ��ID';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.ORG_ID IS '�����ID';

COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.BILL_CLASS IS '���̾���/���ھ���/��ǥ ����';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.BANK_ID IS '��������';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.ISSUE_DATE IS '��������';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.DUE_DATE IS '��������';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.CUSTOMER_ID IS '�ŷ�ó�ڵ�';

COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.BILL_STATUS IS '����/��ǥ����';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.BILL_AMOUNT IS '����/��ǥ�ݾ�';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.ACCOUNT_CONTROL_ID IS '�������ڵ�ID';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.ACCOUNT_CODE IS '�������ڵ�';

COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.REMARK IS '����';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.RECEIVE_DATE IS '��������';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.CLOSE_DATE IS '�������';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.PAYMENT_DATE IS '�ǰ�����';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.BAD_DATE IS '�ε�����';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.PAYMENT_CANCEL_DATE IS '���������';

COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.PAYMENT_CANCEL_DATE IS '����DATA���� ����';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.CREATED_BY IS '����DATA���� USER';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.LAST_UPDATE_DATE IS '����DATA���� ����';
COMMENT ON COLUMN APPS.FI_PAYABLE_BILL.LAST_UPDATED_BY IS '����DATA���� USER';

CREATE UNIQUE INDEX FI_PAYABLE_BILL_PK ON 
  FI_PAYABLE_BILL(BILL_NUM, SOB_ID)
  TABLESPACE  FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  LOGGING
  STORAGE (
           INITIAL 64K
           MINEXTENTS 1
           MAXEXTENTS 2147483645
          );

ALTER TABLE FI_PAYABLE_BILL ADD ( 
  CONSTRAINT FI_PAYABLE_BILL_PK PRIMARY KEY ( BILL_NUM, SOB_ID)
        );

CREATE UNIQUE INDEX FI_PAYABLE_BILL_U1 ON FI_PAYABLE_BILL(PAYABLE_BILL_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE FI_PAYABLE_BILL_S1;
CREATE SEQUENCE FI_PAYABLE_BILL_S1;
