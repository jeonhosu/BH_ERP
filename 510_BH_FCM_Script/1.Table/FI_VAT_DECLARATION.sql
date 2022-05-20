/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FI
/* Program Name : FI_VAT_DECLARATION
/* Description  : �Ϲݰ����� �ΰ���ġ�� �Ű�.
/* Reference by : ȸ�� ���� ���� ����.
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_DECLARATION
( DECLARATION_ID                  NUMBER          NOT NULL,   -- �Ű�ID.
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  TAX_CODE                        VARCHAR2(20)    NOT NULL,   -- ������ڵ�.
  ISSUE_DATE_FR                   DATE            NOT NULL,   -- ���۱Ⱓ.
  ISSUE_DATE_TO                   DATE            NOT NULL,   -- ����Ⱓ.
  WRITE_DATE                      DATE            NOT NULL,   -- �ۼ�����.
  S_TAX_INVOICE_AMT               NUMBER          DEFAULT 0,  -- �������� ���ݰ�꼭 �߱޺�.
  S_TAX_INVOICE_VAT               NUMBER          DEFAULT 0,  -- �������� ���ݰ�꼭 �߱޺�.
  S_TAX_BUYER_INVOICE_AMT         NUMBER          DEFAULT 0,  -- �������� �����ڹ��༼�ݰ�꼭.
  S_TAX_BUYER_INVOICE_VAT         NUMBER          DEFAULT 0,  -- �������� �����ڹ��༼�ݰ�꼭.
  S_TAX_CREDIT_AMT                NUMBER          DEFAULT 0,  -- �ſ�ī��,���ݿ����������.
  S_TAX_CREDIT_VAT                NUMBER          DEFAULT 0,  -- �ſ�ī��,���ݿ����������.
  S_TAX_ETC_AMT                   NUMBER          DEFAULT 0,  -- ��Ÿ(���Կ��ֽ¿ܸ����)
  S_TAX_ETC_VAT                   NUMBER          DEFAULT 0,  -- ��Ÿ(���Կ��ֽ¿ܸ����)
  S_ZERO_INVOICE_AMT              NUMBER          DEFAULT 0,  -- ������ ���ݰ�꼭 �߱޺�.
  S_ZERO_INVOICE_VAT              NUMBER          DEFAULT 0,  -- ������ ���ݰ�꼭 �߱޺�.
  S_ZERO_ETC_AMT                  NUMBER          DEFAULT 0,  -- ������ ��Ÿ.
  S_ZERO_ETC_VAT                  NUMBER          DEFAULT 0,  -- ������ ��Ÿ.
  S_SCHEDULE_OMIT_AMT             NUMBER          DEFAULT 0,  -- �����Ű�����.
  S_SCHEDULE_OMIT_VAT             NUMBER          DEFAULT 0,  -- �����Ű�����.
  S_BAD_DEBT_TAX_AMT              NUMBER          DEFAULT 0,  -- ��ռ��װ���.
  S_BAD_DEBT_TAX_VAT              NUMBER          DEFAULT 0,  -- ��ռ��װ���.
  SALES_SUM_AMT                   NUMBER          DEFAULT 0,  -- �������� �հ�.
  SALES_SUM_VAT                   NUMBER          DEFAULT 0,  -- �������� �հ�.
  P_TAX_INVOICE_AMT               NUMBER          DEFAULT 0,  -- ���Լ��� ���ݰ�꼭 �Ϲݸ���.
  P_TAX_INVOICE_VAT               NUMBER          DEFAULT 0,  -- ���Լ��� ���ݰ�꼭 �Ϲݸ���.
  P_TAX_ASSET_AMT                 NUMBER          DEFAULT 0,  -- ���Լ��� �����ڻ����.
  P_TAX_ASSET_VAT                 NUMBER          DEFAULT 0,  -- ���Լ��� �����ڻ����.
  P_SCHEDULE_OMIT_AMT             NUMBER          DEFAULT 0,  -- ���Լ��� �����Ű�����.
  P_SCHEDULE_OMIT_VAT             NUMBER          DEFAULT 0,  -- ���Լ��� �����Ű�����.
  P_BUYER_INVOICE_AMT             NUMBER          DEFAULT 0,  -- ���Լ��� �����ڹ��༼�ݰ�꼭.
  P_BUYER_INVOICE_VAT             NUMBER          DEFAULT 0,  -- ���Լ��� �����ڹ��༼�ݰ�꼭.
  P_ETC_DED_AMT                   NUMBER          DEFAULT 0,  -- ���Լ��� ��Ÿ���� ���Լ���.
  P_ETC_DED_VAT                   NUMBER          DEFAULT 0,  -- ���Լ��� ��Ÿ���� ���Լ���.
  PURCHASE_SUM_AMT                NUMBER          DEFAULT 0,  -- ���Լ��� �հ�.
  PURCHASE_SUM_VAT                NUMBER          DEFAULT 0,  -- ���Լ��� �հ�.
  P_NOT_DED_AMT                   NUMBER          DEFAULT 0,  -- ������������ ���Լ���.
  P_NOT_DED_VAT                   NUMBER          DEFAULT 0,  -- ������������ ���Լ���.
  CALCULATE_TAX_AMT               NUMBER          DEFAULT 0,  -- ���⼼��.
  CALCULATE_TAX_VAT               NUMBER          DEFAULT 0,  -- ���⼼��.
  R_ETC_DED_AMT                   NUMBER          DEFAULT 0,  -- �氨�������� - ��Ÿ����.�氨����.
  R_ETC_DED_VAT                   NUMBER          DEFAULT 0,  -- �氨�������� - ��Ÿ����.�氨����.
  R_CREDIT_AMT                    NUMBER          DEFAULT 0,  -- �氨��������-�ſ�ī�������ǥ���������.
  R_CREDIT_VAT                    NUMBER          DEFAULT 0,  -- �氨��������-�ſ�ī�������ǥ���������.
  SCHEDULE_YET_REFUND_AMT         NUMBER          DEFAULT 0,  -- �����Ű��ȯ�޼���.
  SCHEDULE_YET_REFUND_VAT         NUMBER          DEFAULT 0,  -- �����Ű��ȯ�޼���.
  SCHEDULE_NOTICE_AMT             NUMBER          DEFAULT 0,  -- ������������.
  SCHEDULE_NOTICE_VAT             NUMBER          DEFAULT 0,  -- ������������.
  GOLD_BAR_BUYER_AMT              NUMBER          DEFAULT 0,  -- ������ ������ ����Ư�� �ⳳ�μ���.
  GOLD_BAR_BUYER_VAT              NUMBER          DEFAULT 0,  -- ������ ������ ����Ư�� �ⳳ�μ���.
  TAX_ADDITION_AMT                NUMBER          DEFAULT 0,  -- ���꼼�װ�.
  TAX_ADDITION_VAT                NUMBER          DEFAULT 0,  -- ���꼼�װ�.
  BALANCE_TAX_AMT                 NUMBER          DEFAULT 0,  -- �������μ���.  
  BALANCE_TAX_VAT                 NUMBER          DEFAULT 0,  -- �������μ���.
  MODIFY_YN                       CHAR(1)         DEFAULT 'N',-- ��������.
  CLOSED_YN                       CHAR(1)         DEFAULT 'N',-- ��������.
  CLOSED_DATE                     DATE            ,           -- �����Ͻ�.
  CLOSED_PERSON_ID                NUMBER          ,           -- ����ó����.
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE FI_VAT_DECLARATION IS '�ΰ���ġ�� �Ű�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.DECLARATION_ID IS '�Ű�ID';
COMMENT ON COLUMN FI_VAT_DECLARATION.TAX_CODE IS '������ڵ�';
COMMENT ON COLUMN FI_VAT_DECLARATION.ISSUE_DATE_FR IS '���� ���۱Ⱓ';
COMMENT ON COLUMN FI_VAT_DECLARATION.ISSUE_DATE_TO IS '���� ����Ⱓ';
COMMENT ON COLUMN FI_VAT_DECLARATION.WRITE_DATE IS '�ۼ�����';
COMMENT ON COLUMN FI_VAT_DECLARATION.S_TAX_INVOICE_AMT IS '�������� ���ݰ�꼭 �߱޺�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.S_TAX_BUYER_INVOICE_AMT IS '�������� �����ڹ��༼�ݰ�꼭(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.S_TAX_CREDIT_AMT IS '�ſ�ī��,���ݿ����������(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.S_TAX_ETC_AMT IS '��Ÿ(���Կ��ֽ¿ܸ����)(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.S_ZERO_INVOICE_AMT IS '��ü Ÿ��(P-����, L-�������� ���ݰ�꼭 �߱޺�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.S_ZERO_ETC_AMT IS '������ ��Ÿ(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.S_SCHEDULE_OMIT_AMT IS '�����Ű�����(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.S_BAD_DEBT_TAX_AMT IS '��ռ��װ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.SALES_SUM_AMT IS '�������� �հ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.P_TAX_INVOICE_AMT IS '���Լ��� ���ݰ�꼭 �Ϲݸ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.P_TAX_ASSET_AMT IS '���Լ��� �����ڻ����(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.P_SCHEDULE_OMIT_AMT IS '���Լ��� �����Ű�����(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.P_BUYER_INVOICE_AMT IS '���Լ��� �����ڹ��༼�ݰ�꼭(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.P_ETC_DED_AMT IS '���Լ��� ��Ÿ���� ���Լ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.PURCHASE_SUM_AMT  IS '���Լ��� �հ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.P_NOT_DED_AMT IS '������������ ���Լ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.CALCULATE_TAX_AMT IS '���⼼��(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.R_ETC_DED_AMT IS '�氨�������� - ��Ÿ����.�氨����(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.R_CREDIT_AMT IS '�氨��������-�ſ�ī�������ǥ���������(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.SCHEDULE_YET_REFUND_AMT IS '�����Ű��ȯ�޼���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.SCHEDULE_NOTICE_AMT  IS '������������(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.GOLD_BAR_BUYER_AMT IS '������ ������ ����Ư�� �ⳳ�μ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.TAX_ADDITION_AMT IS '���꼼�װ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.BALANCE_TAX_AMT IS '�������μ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION.MODIFY_YN IS '��������';
COMMENT ON COLUMN FI_VAT_DECLARATION.CLOSED_YN IS '��������';
COMMENT ON COLUMN FI_VAT_DECLARATION.CLOSED_DATE IS '��������';
COMMENT ON COLUMN FI_VAT_DECLARATION.CLOSED_PERSON_ID IS '����ó����';
COMMENT ON COLUMN FI_VAT_DECLARATION.CREATION_DATE  IS '��������';
COMMENT ON COLUMN FI_VAT_DECLARATION.CREATED_BY IS '������';
COMMENT ON COLUMN FI_VAT_DECLARATION.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN FI_VAT_DECLARATION.LAST_UPDATED_BY IS '����������';

-- PRKMARY KEY.
ALTER TABLE FI_VAT_DECLARATION ADD CONSTRAINT FI_VAT_DECLARATION_PK PRIMARY KEY(TAX_CODE, ISSUE_DATE_FR, ISSUE_DATE_TO, SOB_ID);
-- CREATE INDEX.
CREATE UNIQUE INDEX FI_VAT_DECLARATION_U1 ON FI_VAT_DECLARATION(DECLARATION_ID) TABLESPACE FCM_TS_IDX;

-- CREATE SEQUENCE;
CREATE SEQUENCE FI_VAT_DECLARATION_S1;

-- ANALYZE.
ANALYZE TABLE FI_VAT_DECLARATION COMPUTE STATISTICS;
ANALYZE INDEX FI_VAT_DECLARATION_U1 COMPUTE STATISTICS;

