/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BILL_MOVE
/* Description  : ���� �̵�����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BILL_MOVE 
( BILL_NUM              VARCHAR2(30)  NOT NULL,       -- ������ȣ.
  MOVE_SEQ              NUMBER        NOT NULL,       -- �Ϸù�ȣ.
  SOB_ID                NUMBER        NOT NULL,       
  ORG_ID                NUMBER        NOT NULL,
  MOVE_DATE             DATE          NOT NULL,       -- ��������.
  BILL_STATUS           VARCHAR2(10)  NOT NULL,       -- ��������.
  BILL_TYPE             VARCHAR2(10)  NOT NULL,       -- ��������(�����ڵ�:BILL_TYPE,1:��Ӿ���,2:�����ǥ,3:���¼�ǥ,4:���ھ���).
  DEPT_ID               NUMBER        NOT NULL,       -- �߻��μ�.
  PERSON_ID             NUMBER        NOT NULL,       -- �����ID.
  CUSTOMER_ID           NUMBER        NOT NULL,       -- �ŷ�ó�ڵ�.
  BILL_AMOUNT           NUMBER        DEFAULT 0,      -- �߻��ݾ�/���αݾ�.
  DC_INTEREST_RATE      NUMBER        DEFAULT 0,      -- ������.
  DC_TERM               NUMBER        DEFAULT 0,      -- ���αⰣ.
  DC_INTEREST_AMOUNT    NUMBER        DEFAULT 0,      -- ��������.
  PAYMENT_TYPE          VARCHAR2(10)  ,               -- �Աݱ���(�����ڵ�:PAYMENT_TYPE ).
  BANK_ID               NUMBER        ,               -- ����/��Ź/���� ����.
  BILL_GIVE_DEPT_ID     NUMBER        ,               -- �輭/�Աݺμ�.
  SLIP_DATE             DATE          ,               -- ��ǥ����.
  SLIP_HEADER_ID        NUMBER        ,               -- ��ǥ ��� ID.
  SLIP_LINE_ID          NUMBER        ,               -- ��ǥ ���� ID.
  CREATION_DATE         DATE          NOT NULL,       -- ������.
  CREATED_BY            NUMBER        NOT NULL,       -- ������.
  LAST_UPDATE_DATE      DATE          NOT NULL,       -- ������.
  LAST_UPDATED_BY       NUMBER        NOT NULL        -- ������.
) TABLESPACE FCM_TS_DATA ;

COMMENT ON TABLE FI_BILL_MOVE IS '�����̵�����';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.BILL_NUM IS '������ȣ';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.MOVE_SEQ IS '�Ϸù�ȣ';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.MOVE_DATE IS '��������';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.BILL_STATUS IS '��������';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.BILL_TYPE IS '��������(�����ڵ�:BILL_TYPE)';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.DEPT_ID IS '�߻��μ�';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.PERSON_ID IS '�����ID';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.CUSTOMER_ID IS '�ŷ�ó';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.BILL_AMOUNT IS '�߻��ݾ�/���αݾ�';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.DC_INTEREST_RATE IS '������';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.DC_TERM IS '���αⰣ';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.DC_INTEREST_AMOUNT IS '��������';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.PAYMENT_TYPE IS '�Աݱ���(�����ڵ�:PAYMENT_TYPE )';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.BANK_ID IS '����/��Ź/���� ����';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.BILL_GIVE_DEPT_ID IS '�輭�Աݺμ�';

COMMENT ON COLUMN APPS.FI_BILL_MOVE.SLIP_DATE IS '��ǥ����';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.SLIP_HEADER_ID IS '��ǥ��ȣ/����(��Ź)���ۼ�����/�̵��뺸���׷��ȣ';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.SLIP_LINE_ID IS '��ǥ��ȣ/����(��Ź)���ۼ�����/�̵��뺸���׷��ȣ';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.CREATION_DATE IS '������';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.CREATED_BY IS '������';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.LAST_UPDATE_DATE IS '������';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.LAST_UPDATED_BY IS '������';

CREATE UNIQUE INDEX FI_BILL_MOVE_PK ON 
  FI_BILL_MOVE( BILL_NUM, MOVE_SEQ, SOB_ID)
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

ALTER TABLE FI_BILL_MOVE ADD ( 
  CONSTRAINT FI_BILL_MOVE_PK PRIMARY KEY ( BILL_NUM, MOVE_SEQ, SOB_ID )
        );
/*
CREATE INDEX FI_BILL_MOVE_N1 ON 
  FI_BILL_MOVE(MOVE_DATE, BILL_STATUS)  
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
*/
