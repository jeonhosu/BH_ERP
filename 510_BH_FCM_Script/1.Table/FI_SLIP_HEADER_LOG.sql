/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_SLIP_HEADER_LOG
/* Description  : ��ǥ ��� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_SLIP_HEADER_LOG 
( SLIP_HEADER_ID                  NUMBER        NOT NULL,
  SLIP_DATE                       DATE          NOT NULL,      -- ��ǥ����.
  SLIP_NUM                        VARCHAR2(30)  NOT NULL,      -- ��ǥ��ȣ.
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  DEPT_ID                         NUMBER        NOT NULL,      -- ���Ǻμ�.
  PERSON_ID                       NUMBER        NOT NULL,      -- ������.
  BUDGET_DEPT_ID                  NUMBER        ,              -- ���� �μ�.
  ACCOUNT_BOOK_ID                 NUMBER        NOT NULL,      -- ȸ�����ID.
  SLIP_TYPE                       VARCHAR2(10)  NOT NULL,      -- ��ǥ����.
  PERIOD_NAME                     VARCHAR2(10)  NOT NULL,      -- ȸ����.
  CONFIRM_YN                      CHAR(1)       DEFAULT 'N',   -- ���ο���.
  CONFIRM_DATE                    DATE          ,              -- ��������.
  CONFIRM_PERSON_ID               NUMBER        ,              -- ������.  
  CHANGE_COUNT                    NUMBER(3)     ,              -- ��ǥ���� ����.
  GL_DATE                         DATE          ,              -- ȸ������.
  GL_NUM                          VARCHAR2(30)  ,              -- ȸ���ȣ  
  GL_AMOUNT                       NUMBER        DEFAULT 0,     -- ��ǥ�ݾ�.  
  CURRENCY_CODE                   VARCHAR2(10)  ,              -- ��ȭ.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,     -- ȯ��.
  GL_CURRENCY_AMOUNT              NUMBER        DEFAULT 0,     -- ��ȭ�ݾ�.  
  REQ_BANK_ACCOUNT_ID             NUMBER        ,              -- ������� ID
  REQ_PAYABLE_TYPE                VARCHAR2(10)  ,              -- ���޿�û���(����, ����...).
  REQ_PAYABLE_DATE                DATE          ,              -- ���޿�û��
  REMARK                          VARCHAR2(150) ,              -- ����
  CLOSED_YN                       CHAR(1)       DEFAULT 'N',   -- ���ο���.
  CLOSED_DATE                     DATE          ,              -- ��������.
  CLOSED_PERSON_ID                NUMBER        ,              -- ������.
  CREATED_TYPE                    VARCHAR2(50)  DEFAULT 'M',   -- �������.
  SOURCE_TABLE                    VARCHAR2(100) ,
  SOURCE_HEADER_ID                NUMBER        ,
  CREATION_DATE                   DATE          NOT NULL,      -- ������
  CREATED_BY                      NUMBER        NOT NULL,      -- ������
  LAST_UPDATE_DATE                DATE          NOT NULL,      -- ������
  LAST_UPDATED_BY                 NUMBER        NOT NULL       -- ������
  DELETED_DATE                    DATE          ,
  DELETED_BY                      NUMBER        
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_SLIP_HEADER_LOG IS 'ȸ����ǥ HEADER ���� �α�';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.SLIP_HEADER_ID IS '��ǥ ��� ID';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.SLIP_DATE IS '��ǥ����';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.SLIP_NUM IS '��ǥ��ȣ';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.DEPT_ID IS '���Ǻμ�';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.PERSON_ID IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.BUDGET_DEPT_ID IS '����μ�';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.ACCOUNT_BOOK_ID IS 'ȸ�����ID';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.SLIP_TYPE IS '��ǥ����';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.PERIOD_NAME IS 'ȸ����';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.CONFIRM_YN IS '���ο���';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.CONFIRM_DATE IS '��������';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.CONFIRM_PERSON_ID IS '����ó����';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.CHANGE_COUNT IS '����Ƚ��';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.GL_DATE IS 'ȸ������';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.GL_NUM IS 'ȸ���ȣ';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.GL_AMOUNT IS '��ǥ �ݾ�';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.GL_CURRENCY_AMOUNT IS '��ȭ�ݾ�';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.REQ_BANK_ACCOUNT_ID IS '���޻� �������';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.REQ_PAYABLE_TYPE IS '���� ��û���(����, ����...)';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.REQ_PAYABLE_DATE IS '���� ��û��';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.REMARK IS '����';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.CLOSED_YN IS '��������';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.CLOSED_DATE IS '��������';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.CLOSED_PERSON_ID IS '����ó����';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.CREATED_TYPE IS '�������(M:�޴���, I:�������̽�)';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.SOURCE_TABLE IS 'INTERFACE �ҽ����̺�';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.SOURCE_HEADER_ID IS 'INTERFACE �ҽ� HEADER ID';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.CREATION_DATE IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.CREATED_BY IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.LAST_UPDATE_DATE IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.LAST_UPDATED_BY IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.DELETED_DATE IS '�����Ͻ�';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_LOG.DELETED_BY IS '����ó����';

-- INDEX.
CREATE INDEX FI_SLIP_HEADER_LOG_N1 ON FI_SLIP_HEADER_LOG(SLIP_HEADER_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_HEADER_LOG_N2 ON FI_SLIP_HEADER_LOG(SOB_ID, SLIP_DATE, SLIP_NUM) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_HEADER_LOG_N3 ON FI_SLIP_HEADER_LOG(SOB_ID, GL_DATE, GL_NUM) TABLESPACE FCM_TS_IDX;

