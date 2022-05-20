/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_SLIP_EXCEL_UPLOAD
/* Description  : ��ǥ EXCEL UPLOAD ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_SLIP_EXCEL_UPLOAD
( SLIP_DATE                       DATE          NOT NULL,      -- ��ǥ����.
  SLIP_NUM                        VARCHAR2(30)  NOT NULL,      -- ��ǥ��ȣ.
  SLIP_LINE_SEQ                   NUMBER        NOT NULL,      -- ��ǥ���ȣ.
  SLIP_HEADER_ID                  NUMBER        ,              -- ��ǥ HEADER ID.    
  SOB_ID                          NUMBER        NOT NULL,      -- ȸ������.
  ORG_ID                          NUMBER        NOT NULL,      -- �����ID.  
  DEPT_CODE                       VARCHAR2(50)  ,              -- ���Ǻμ�.
  PERSON_NUM                      VARCHAR2(20)  ,              -- �����ȣ.
  BUDGET_DEPT_CODE                VARCHAR2(50)  ,              -- ���� �μ�.
  SLIP_TYPE                       VARCHAR2(10)  NOT NULL,      -- ��ǥ����.
  GL_DATE                         DATE          ,              -- ��ǥ����.
  GL_NUM                          VARCHAR2(30)  ,              -- ��ǥ��ȣ.
  HEADER_REMARK                   VARCHAR2(100) ,              -- ��� ����.
  ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL,      -- �����ڵ�.
  ACCOUNT_DESC                    VARCHAR2(200) ,              -- ������.
  ACCOUNT_DR_CR                   VARCHAR2(2)   NOT NULL,      -- ��/��.
  GL_AMOUNT                       NUMBER        DEFAULT 0,     -- �ݾ�.
  CURRENCY_CODE                   VARCHAR2(10)  NOT NULL,      -- ��ȭ.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,     -- ȯ��.
  GL_CURRENCY_AMOUNT              NUMBER        DEFAULT 0,     -- ��ȭ�ݾ�.
  MANAGEMENT1                     VARCHAR2(50)  ,               -- �ܾװ����׸��ڵ�1.
  MANAGEMENT2                     VARCHAR2(50)  ,               -- �ܾװ����׸��ڵ�2.
  REFER1                          VARCHAR2(50)  ,               -- �����׸��ڵ�1.
  REFER2                          VARCHAR2(50)  ,               -- �����׸��ڵ�2.
  REFER3                          VARCHAR2(50)  ,               -- �����׸��ڵ�3.
  REFER4                          VARCHAR2(50)  ,               -- �����׸��ڵ�4.
  REFER5                          VARCHAR2(50)  ,               -- �����׸��ڵ�5.
  REFER6                          VARCHAR2(50)  ,               -- �����׸��ڵ�6.
  REFER7                          VARCHAR2(50)  ,               -- �����׸��ڵ�7.
  REFER8                          VARCHAR2(50)  ,               -- �����׸��ڵ�8.
  REFER9                          VARCHAR2(50)  ,               -- �����׸��ڵ�9.
  REFER10                         VARCHAR2(50)  ,               -- �����׸��ڵ�10.
  REFER11                         VARCHAR2(50)  ,               -- �����׸��ڵ�11.
  REFER12                         VARCHAR2(50)  ,               -- �����׸��ڵ�12.
  VOUCH_CODE                      VARCHAR2(50)  ,               -- �������� ID.
  REFER_RATE                      NUMBER        ,               -- �������ڵ�.
  REFER_AMOUNT                    NUMBER        ,               -- �����ݾ��ڵ�.
  REFER_DATE1                     DATE          ,               -- ���������ڵ�1.
  REFER_DATE2                     DATE          ,               -- ���������ڵ�2 .   
  REMARK                          VARCHAR2(100) ,               -- ����.
  FUND_CODE                       VARCHAR2(10)  ,               -- �ڱ��ڵ�(FUND_CODE).
  SLIP_YN                         VARCHAR2(1)   DEFAULT 'N',    -- ��ǥ��������.
  SLIP_PERSON_ID                  NUMBER        ,               -- ��ǥ������. 
  USER_ID                         NUMBER        ,               -- �۾���ID.
  CREATED_DATE                    DATE          ,               
  ATTRIBUTE_A                     VARCHAR2(100) ,
  ATTRIBUTE_B                     VARCHAR2(100) ,
  ATTRIBUTE_C                     VARCHAR2(100) ,
  ATTRIBUTE_D                     VARCHAR2(100) ,
  ATTRIBUTE_E                     VARCHAR2(100) ,
  ATTRIBUTE_1                     NUMBER        ,
  ATTRIBUTE_2                     NUMBER        ,
  ATTRIBUTE_3                     NUMBER        ,
  ATTRIBUTE_4                     NUMBER        ,
  ATTRIBUTE_5                     NUMBER
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE  FI_SLIP_EXCEL_UPLOAD IS 'ȸ����ǥ(GL) ���ε� ���� ���̺�';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.SLIP_DATE IS '��ǥ����';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.SLIP_NUM IS '��ǥ��ȣ';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.SLIP_LINE_SEQ IS '��ǥ ���ι�ȣ';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.SLIP_HEADER_ID IS '��ǥ ��� ID';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.DEPT_CODE IS '���Ǻμ�';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.PERSON_NUM IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.BUDGET_DEPT_CODE IS '����μ�';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.SLIP_TYPE IS '��ǥ����';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.HEADER_REMARK IS '��� ����';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.ACCOUNT_CODE IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.ACCOUNT_DR_CR  IS '���뱸��(0-��, 1-��)';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.GL_AMOUNT IS '��ǥ �ݾ�';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.CURRENCY_CODE IS '��ȭ';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.EXCHANGE_RATE IS 'ȯ��';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.GL_CURRENCY_AMOUNT IS '��ȭ�ݾ�';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.MANAGEMENT1 IS '�ܾװ����׸�1';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.MANAGEMENT2 IS '�ܾװ����׸�2';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.REFER1 IS '�����׸�1~12';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.VOUCH_CODE IS '�����ڵ�';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.REFER_RATE IS '������';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.REFER_AMOUNT IS '�����ݾ�';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.REFER_DATE1 IS '��������1';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.REFER_DATE2 IS '��������2';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.REMARK IS '����';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.FUND_CODE IS '�ڱ��ڵ�';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.SLIP_YN IS '��ǥ���� ����';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.SLIP_PERSON_ID IS '��ǥ���� ó����';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.SLIP_YN IS '��ǥ���� ����';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.USER_ID IS '�۾��� ID';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.CREATED_DATE IS '�۾��� �Ͻ�';
