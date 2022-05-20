/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_LOAN_CHANGE
/* Description  : ���Ա� ���� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_LOAN_CHANGE 
( LOAN_NUM                        VARCHAR2(20)  NOT NULL,     -- ���Ա� ������ȣ.
  SOB_ID                          NUMBER        NOT NULL,     -- ȸ������.
  ORG_ID                          NUMBER        NOT NULL,     -- �����ID.
  CHANGE_SEQ                      NUMBER(5,0)   NOT NULL,     -- �Ϸù�ȣ.
  CHANGE_DATE                     DATE          NOT NULL,     -- ��������.
  CHANGE_REASON_CODE              VARCHAR2(10)  ,             -- ��������ڵ�.
  DUE_DATE                        DATE          ,             -- ��������.
  INTEREST_RATE                   NUMBER(10,4)  ,             -- ������.
  CURRENCY_CODE                   VARCHAR2(10)  ,             -- ��ȭ.
  EXCHANGE_RATE                   NUMBER(10,4)  ,             -- ȯ��.
  CHANGE_AMOUNT                   NUMBER(12)    ,             -- �����ݾ�.
  CHANGE_CURR_AMOUNT              NUMBER(16,4)  ,             -- �����ݾ�_��ȭ.
--CONFIRM_YN                        VARCHAR2(1)   ,             -- Ȯ��(Y/N).
  REMARK                          VARCHAR2(150) ,             -- ����.
  SLIP_DATE                       DATE          ,             -- ��ǥ��ǥ����.
  SLIP_NUM                        VARCHAR2(30)  ,             -- ��ǥ��ǥ��ȣ.
  SLIP_LINE_ID                    NUMBER        ,             -- ��ǥ��ǥ���.
  GL_DATE                         DATE          ,             -- Ȯ����ǥ����.
  GL_NUM                          VARCHAR2(30)  ,             -- Ȯ����ǥ��ȣ.  
  CREATION_DATE                   DATE          NOT NULL,     -- ������.
  CREATED_BY                      NUMBER        NOT NULL,     -- ������.
  LAST_UPDATE_DATE                DATE          NOT NULL,     -- ������.
  LAST_UPDATED_BY                 NUMBER        NOT NULL      -- ������.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE  FI_LOAN_CHANGE IS '���Ա� ���� ����';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.LOAN_NUM IS '���Ա�_������ȣ';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.SOB_ID IS 'ȸ������';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.ORG_ID IS '�����ID';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.CHANGE_SEQ IS '�Ϸù�ȣ';

COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.CHANGE_DATE IS '��������';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.CHANGE_REASON_CODE IS '��������ڵ�';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.DUE_DATE IS '��������';

COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.INTEREST_RATE IS '������';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.CHANGE_AMOUNT IS '�����ݾ�';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.CHANGE_CURR_AMOUNT IS '�����ݾ�_��ȭ';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.REMARK IS '����';

COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.SLIP_DATE IS '��ǥ��ǥ����';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.SLIP_NUM IS '��ǥ��ǥ��ȣ';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.SLIP_LINE_ID IS '��ǥ��ǥ���';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.GL_DATE IS 'Ȯ����ǥ����';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.GL_NUM IS 'Ȯ����ǥ��ȣ';

COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.CREATION_DATE IS '������';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.CREATED_BY IS '������';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.LAST_UPDATE_DATE IS '������';
COMMENT ON COLUMN APPS.FI_LOAN_CHANGE.LAST_UPDATED_BY IS '������';
         
CREATE UNIQUE INDEX FI_LOAN_CHANGE_PK ON 
  FI_LOAN_CHANGE(LOAN_NUM, CHANGE_SEQ, SOB_ID)
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
   
ALTER TABLE FI_LOAN_CHANGE ADD ( 
  CONSTRAINT FI_LOAN_CHANGE_PK PRIMARY KEY ( LOAN_NUM, CHANGE_SEQ, SOB_ID )
        );
