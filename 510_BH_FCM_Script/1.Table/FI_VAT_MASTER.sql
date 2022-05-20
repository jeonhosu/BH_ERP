/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_MASTER
/* Description  : ���ݰ�꼭����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_MASTER 
( VAT_ID                          NUMBER        NOT NULL,   -- ���ݰ�꼭ID.
  TAX_CODE                        VARCHAR2(10)  NOT NULL,   -- ����� �ڵ�(�����ڵ�-TAX-CODE).
  VAT_ISSUE_DATE                  DATE          NOT NULL,   -- ��꼭������.
  VAT_TYPE                        VARCHAR2(4)   NOT NULL,   -- ��꼭 ����.
  VAT_GUBUN                       VARCHAR2(10)  NOT NULL,   -- ���Ը��ⱸ��.
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  CUSTOMER_ID                     NUMBER        NOT NULL,   -- ������/�ŷ�óID.
  GL_AMOUNT                       NUMBER        DEFAULT 0,  -- ���ް���.
  VAT_AMOUNT                      NUMBER        DEFAULT 0,  -- �ΰ��� �ݾ�.
  VAT_COUNT                       NUMBER(3)     DEFAULT 1,  -- ��꼭�ż�.
  REMARK                          VARCHAR2(200) ,           -- ����.
  CURRENCY_CODE                   VARCHAR2(10)  ,           -- ��ȭ.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,  -- ȯ��.
  GL_CURR_AMOUNT                  NUMBER        DEFAULT 0,  -- ��ȭ ���ް���.
  VAT_CURR_AMOUNT                 NUMBER        DEFAULT 0,  -- ��ȭ �ΰ��� �ݾ�.
  PERIOD_NAME                     VARCHAR2(10)  ,           -- ȸ����.  
  BUSINESS_TYPE                   VARCHAR2(10)  ,           -- �ŷ�ó����(C-�����/P-����)
  TAX_ELECTRO_YN                  CHAR(1)       DEFAULT 'N',-- ���ڼ��ݰ�꼭 ����(N.�Ϲ�, Y.����).
  VAT_STATE                       CHAR(1)       DEFAULT '0',-- 0:�̽Ű�, 1:Ȯ���Ű�, 2:�����Ű�
  CREATED_TYPE                    CHAR(1)       DEFAULT 'A',-- ��������(A-�ڵ�����, M-�����Է�).
  CLOSED_YN                       CHAR(1)       DEFAULT 'N',-- ��������(Y:����, N:�̸���)
  CLOSED_DATE                     DATE          ,           -- �����Ͻ�.
  CLOSED_PERSON_ID                NUMBER        ,           -- ����ó����.
  RESIDENT_REG_NUM                VARCHAR2(50)  ,           -- �ֹι�ȣ.
  CREDITCARD_CODE                 VARCHAR2(50)  ,           -- �ſ�ī���ȣ.
  CASH_RECEIPT_NUM                VARCHAR2(50)  ,           -- ���ݿ����� ���ι�ȣ.
  DOCUMENT_NUM                    VARCHAR2(50)  ,           -- L/C��ȣ(����Ű�,�ſ����ȣ).
  SHIPPING_DATE                   DATE          ,           -- ��������.
  BANK_CODE                       VARCHAR2(30)  ,           -- �߱������ڵ�.
  INPUT_DED_NOT_CODE              VARCHAR2(10)  ,           -- ���Լ��׺Ұ��������ڵ�.
  INPUT_FREE_CODE                 VARCHAR2(10)  ,           -- �鼼���Ի����ڵ�.
  INPUT_DEEMED_TAX_CODE           VARCHAR2(10)  ,           -- �������Լ��׻���.
  SLIP_HEADER_ID                  NUMBER        ,           -- ��ǥ ��� ID.
  SLIP_LINE_ID                    NUMBER        ,           -- ��ǥ ���� ID.
  GL_NUM                          VARCHAR2(30)  ,           -- ȸ���ȣ.
  GL_DATE                         DATE          NOT NULL,   -- ȸ������.
  ACCOUNT_CONTROL_ID              NUMBER        ,           -- ���ݰ�꼭 ��������ID.
  ACCOUNT_CODE                    VARCHAR2(20)  ,           -- ���ݰ�꼭 �����ڵ�.
  ATTRIBUTE_A                     VARCHAR2(100) ,
  ATTRIBUTE_B                     VARCHAR2(100) ,
  ATTRIBUTE_C                     VARCHAR2(100) ,
  ATTRIBUTE_D                     VARCHAR2(100) ,
  ATTRIBUTE_E                     VARCHAR2(100) ,
  ATTRIBUTE_1                     NUMBER        ,
  ATTRIBUTE_2                     NUMBER        ,
  ATTRIBUTE_3                     NUMBER        ,
  ATTRIBUTE_4                     NUMBER        ,
  ATTRIBUTE_5                     NUMBER        ,
  CREATION_DATE                   DATE          NOT NULL,
  CREATED_BY                      NUMBER        NOT NULL,
  LAST_UPDATE_DATE                DATE          NOT NULL,
  LAST_UPDATED_BY                 NUMBER        NOT NULL
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_VAT_MASTER IS '���ݰ�꼭��';
COMMENT ON COLUMN FI_VAT_MASTER.VAT_ID IS '���ݰ�꼭 ID';
COMMENT ON COLUMN FI_VAT_MASTER.TAX_CODE IS '�ΰ��� �Ű� ����� �ڵ�';
COMMENT ON COLUMN FI_VAT_MASTER.VAT_ISSUE_DATE IS '��꼭������';
COMMENT ON COLUMN FI_VAT_MASTER.VAT_TYPE IS '��꼭 ����';
COMMENT ON COLUMN FI_VAT_MASTER.VAT_GUBUN IS '���Ը��ⱸ�� 1:����  2:����';
COMMENT ON COLUMN FI_VAT_MASTER.CUSTOMER_ID IS '������/�ŷ�óID';
COMMENT ON COLUMN FI_VAT_MASTER.GL_AMOUNT IS '���ް���';
COMMENT ON COLUMN FI_VAT_MASTER.VAT_AMOUNT IS '�ΰ���';
COMMENT ON COLUMN FI_VAT_MASTER.VAT_COUNT IS '��꼭�ż�';
COMMENT ON COLUMN FI_VAT_MASTER.REMARK IS '����';
COMMENT ON COLUMN FI_VAT_MASTER.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN FI_VAT_MASTER.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN FI_VAT_MASTER.GL_CURR_AMOUNT IS '��ȭ ���ް���';
COMMENT ON COLUMN FI_VAT_MASTER.VAT_CURR_AMOUNT IS '��ȭ ����';
COMMENT ON COLUMN FI_VAT_MASTER.PERIOD_NAME IS 'ȸ����';
COMMENT ON COLUMN FI_VAT_MASTER.BUSINESS_TYPE IS '�ŷ�ó����(C-����/P-����)';
COMMENT ON COLUMN FI_VAT_MASTER.TAX_ELECTRO_YN IS '���ڼ��ݰ�꼭 ����(N:�Ϲ�, Y:����)';
COMMENT ON COLUMN FI_VAT_MASTER.VAT_STATE IS '�ΰ��� ����-0:�̽Ű�, 1:Ȯ���Ű�, 2:�����Ű�';
COMMENT ON COLUMN FI_VAT_MASTER.CREATED_TYPE IS '��������(A:�ڵ�����,M:�����Է�)';
COMMENT ON COLUMN FI_VAT_MASTER.CLOSED_YN IS '��������';
COMMENT ON COLUMN FI_VAT_MASTER.CLOSED_DATE IS '�����Ͻ�';
COMMENT ON COLUMN FI_VAT_MASTER.CLOSED_PERSON_ID IS '����ó����';
COMMENT ON COLUMN FI_VAT_MASTER.RESIDENT_REG_NUM IS '�ֹι�ȣ';
COMMENT ON COLUMN FI_VAT_MASTER.CREDITCARD_CODE IS '�ſ�ī���ڵ�';
COMMENT ON COLUMN FI_VAT_MASTER.CASH_RECEIPT_NUM IS '���ݿ����� ���ι�ȣ';
COMMENT ON COLUMN FI_VAT_MASTER.DOCUMENT_NUM IS 'L/C��ȣ(����Ű�,�ſ����ȣ)';
COMMENT ON COLUMN FI_VAT_MASTER.SHIPPING_DATE IS '��������';
COMMENT ON COLUMN FI_VAT_MASTER.BANK_CODE IS '�߱������ڵ�';
COMMENT ON COLUMN FI_VAT_MASTER.INPUT_DED_NOT_CODE IS '���Լ��׺Ұ��������ڵ�';
COMMENT ON COLUMN FI_VAT_MASTER.INPUT_FREE_CODE IS '�鼼���Ի����ڵ�';
COMMENT ON COLUMN FI_VAT_MASTER.INPUT_DEEMED_TAX_CODE IS '�������Լ��׻���';
COMMENT ON COLUMN FI_VAT_MASTER.SLIP_HEADER_ID IS '��ǥ ��� ID';
COMMENT ON COLUMN FI_VAT_MASTER.SLIP_LINE_ID IS '��ǥ ���� ID';
COMMENT ON COLUMN FI_VAT_MASTER.GL_NUM  IS 'ȸ���ȣ';
COMMENT ON COLUMN FI_VAT_MASTER.GL_DATE IS 'ȸ������';
COMMENT ON COLUMN FI_VAT_MASTER.ACCOUNT_CONTROL_ID IS '��������ID';
COMMENT ON COLUMN FI_VAT_MASTER.ACCOUNT_CODE IS '��ǥ�����ڵ�';

--ALTER TABLE FI_VAT_MASTER ADD CONSTRAINT FI_VAT_MASTER_PK PRIMARY KEY ();

CREATE UNIQUE INDEX FI_VAT_MASTER_UN ON FI_VAT_MASTER(VAT_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_MASTER_N1 ON FI_VAT_MASTER(TAX_CODE, VAT_ISSUE_DATE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_MASTER_N2 ON FI_VAT_MASTER(TAX_CODE, VAT_TYPE, SOB_ID)  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_MASTER_N3 ON FI_VAT_MASTER(TAX_CODE, VAT_GUBUN, SOB_ID)  TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE FI_VAT_MASTER_S1;

