/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FI
/* Program Name : FI_VAT_DECLARATION_ATTACH
/* Description  : �Ϲݰ����� �ΰ���ġ�� �Ű� - �߰� �ڷ�.
/* Reference by : ȸ�� ���� ���� ����.
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_DECLARATION_ATTACH
( DECLARATION_ID                  NUMBER          NOT NULL,   -- �Ű�ID.
  SS_TAX_INVOICE_AMT              NUMBER          DEFAULT 0,  -- �������� ���ݰ�꼭.
  SS_TAX_INVOICE_VAT              NUMBER          DEFAULT 0,  -- �������� ���ݰ�꼭.
  SS_TAX_ETC_AMT                  NUMBER          DEFAULT 0,  -- �������� ��Ÿ.
  SS_TAX_ETC_VAT                  NUMBER          DEFAULT 0,  -- �������� ��Ÿ.
  SS_ZERO_INVOICE_AMT             NUMBER          DEFAULT 0,  -- ������ ���ݰ�꼭.
  SS_ZERO_INVOICE_VAT             NUMBER          DEFAULT 0,  -- ������ ���ݰ�꼭.
  SS_ZERO_ETC_AMT                 NUMBER          DEFAULT 0,  -- ������ ��Ÿ.
  SS_ZERO_ETC_VAT                 NUMBER          DEFAULT 0,  -- ������ ��Ÿ.
  S_SALES_SUM_AMT                 NUMBER          DEFAULT 0,  -- �������� �հ�.
  S_SALES_SUM_VAT                 NUMBER          DEFAULT 0,  -- �������� �հ�.
  SP_TAX_INVOICE_AMT              NUMBER          DEFAULT 0,  -- ���Լ��� ���ݰ�꼭.
  SP_TAX_INVOICE_VAT              NUMBER          DEFAULT 0,  -- ���Լ��� ���ݰ�꼭.
  SP_ETC_DED_AMT                  NUMBER          DEFAULT 0,  -- ���Լ��� ��Ÿ���� ���Լ���.
  SP_ETC_DED_VAT                  NUMBER          DEFAULT 0,  -- ���Լ��� ��Ÿ���� ���Լ���.
  S_PURCHASE_SUM_AMT              NUMBER          DEFAULT 0,  -- ���Լ��� �հ�.
  S_PURCHASE_SUM_VAT              NUMBER          DEFAULT 0,  -- ���Լ��� �հ�.
  E_CREDIT_AMT                    NUMBER          DEFAULT 0,  -- ��Ÿ�������Լ��׸� : �ſ�ī�� �Ϲݸ���.
  E_CREDIT_VAT                    NUMBER          DEFAULT 0,  -- ��Ÿ�������Լ��׸� : �ſ�ī�� �Ϲݸ���.
  E_CREDIT_ASSET_AMT              NUMBER          DEFAULT 0,  -- ��Ÿ�������Լ��׸� : �ſ�ī�� �����ڻ�.
  E_CREDIT_ASSET_VAT              NUMBER          DEFAULT 0,  -- ��Ÿ�������Լ��׸� : �ſ�ī�� �����ڻ�.
  E_DEEMED_IP_AMT                 NUMBER          DEFAULT 0,  -- �������Լ���.
  E_DEEMED_IP_VAT                 NUMBER          DEFAULT 0,  -- �������Լ���.
  E_RECYCLE_IP_AMT                NUMBER          DEFAULT 0,  -- ��Ȱ�����ڿ��� ���Լ���.
  E_RECYCLE_IP_VAT                NUMBER          DEFAULT 0,  -- ��Ȱ�����ڿ��� ���Լ���.
  E_GOLD_BAR_IP_AMT               NUMBER          DEFAULT 0,  -- ������� ���Լ���.
  E_GOLD_BAR_IP_VAT               NUMBER          DEFAULT 0,  -- ������� ���Լ���.
  E_TAX_BUSINESS_IP_AMT           NUMBER          DEFAULT 0,  -- ���������ȯ���Լ���.
  E_TAX_BUSINESS_IP_VAT           NUMBER          DEFAULT 0,  -- ���������ȯ���Լ���.
  E_STOCK_IP_AMT                  NUMBER          DEFAULT 0,  -- �����Լ���.
  E_STOCK_IP_VAT                  NUMBER          DEFAULT 0,  -- �����Լ���.
  E_BAD_TAX_AMT                   NUMBER          DEFAULT 0,  -- ������ռ���.
  E_BAD_TAX_VAT                   NUMBER          DEFAULT 0,  -- ������ռ���.
  ETC_DED_IP_SUM_AMT              NUMBER          DEFAULT 0,  -- ��Ÿ�������Լ��׸� �հ�.
  ETC_DED_IP_SUM_VAT              NUMBER          DEFAULT 0,  -- ��Ÿ�������Լ��׸� �հ�.
  N_NOT_DED_AMT                   NUMBER          DEFAULT 0,  -- ������������ ���Լ���.
  N_NOT_DED_VAT                   NUMBER          DEFAULT 0,  -- ������������ ���Լ���.
  N_COMMON_IP_AMT                 NUMBER          DEFAULT 0,  -- ������Լ��� ���������.
  N_COMMON_IP_VAT                 NUMBER          DEFAULT 0,  -- ������Լ��� ���������.
  N_BAD_RECEIVE_AMT               NUMBER          DEFAULT 0,  -- ���ó�й�������.
  N_BAD_RECEIVE_VAT               NUMBER          DEFAULT 0,  -- ���ó�й�������.
  NOT_DED_SUM_AMT                 NUMBER          DEFAULT 0,  -- �����������Ҹ��Լ��׸��հ�.
  NOT_DED_SUM_VAT                 NUMBER          DEFAULT 0,  -- �����������Ҹ��Լ��׸��հ�.
  R_ETAX_REPORT_AMT               NUMBER          DEFAULT 0,  -- �氨�������� - ���ڽŰ��װ���.
  R_ETAX_REPORT_VAT               NUMBER          DEFAULT 0,  -- �氨�������� - ���ڽŰ��װ���.
  R_ETAX_ISSUE_AMT                NUMBER          DEFAULT 0,  -- �氨�������� - ���ڼ��ݰ�꼭 �߱޼��װ���.
  R_ETAX_ISSUE_VAT                NUMBER          DEFAULT 0,  -- �氨�������� - ���ڼ��ݰ�꼭 �߱޼��װ���.
  R_TAXI_TRANSPORT_AMT            NUMBER          DEFAULT 0,  -- �氨�������� - �ýÿ�ۻ���ڰ氨����.
  R_TAXI_TRANSPORT_VAT            NUMBER          DEFAULT 0,  -- �氨�������� - �ýÿ�ۻ���ڰ氨����.
  R_CASH_BILL_AMT                 NUMBER          DEFAULT 0,  -- �氨�������� - ���ݿ���������ڼ��װ���.
  R_CASH_BILL_VAT                 NUMBER          DEFAULT 0,  -- �氨�������� - ���ݿ���������ڼ��װ���.
  R_ETC_DED_AMT                   NUMBER          DEFAULT 0,  -- �氨�������� - ��Ÿ����.�氨����.
  R_ETC_DED_VAT                   NUMBER          DEFAULT 0,  -- �氨�������� - ��Ÿ����.�氨����.
  REDUCE_DED_SUM_AMT              NUMBER          DEFAULT 0,  -- �氨�������� �հ�.
  REDUCE_DED_SUM_VAT              NUMBER          DEFAULT 0,  -- �氨�������� �հ�.
  A_VAT_NUM_UNENROLL_AMT          NUMBER          DEFAULT 0,  -- ���꼼�� - ����ڹ̵�ϵ�.
  A_VAT_NUM_UNENROLL_VAT          NUMBER          DEFAULT 0,  -- ���꼼�� - ����ڹ̵�ϵ�.
  A_TAX_INVOICE_DELAY_AMT         NUMBER          DEFAULT 0,  -- ���꼼�� - ���ݰ�꼭 �����߱޵�.
  A_TAX_INVOICE_DELAY_VAT         NUMBER          DEFAULT 0,  -- ���꼼�� - ���ݰ�꼭 �����߱޵�.
  A_TAX_INVOICE_UNISSUE_AMT       NUMBER          DEFAULT 0,  -- ���꼼�� - ���ݰ�꼭 �̹߱޵�.
  A_TAX_INVOICE_UNISSUE_VAT       NUMBER          DEFAULT 0,  -- ���꼼�� - ���ݰ�꼭 �̹߱޵�.
  A_ETAX_UNSEND_IN_AMT            NUMBER          DEFAULT 0,  -- ���꼼�� - ���ڼ��ݰ�꼭 ������(�����Ⱓ��).
  A_ETAX_UNSEND_IN_VAT            NUMBER          DEFAULT 0,  -- ���꼼�� - ���ڼ��ݰ�꼭 ������(�����Ⱓ��).
  A_ETAX_UNSEND_OVER_AMT          NUMBER          DEFAULT 0,  -- ���꼼�� - ���ڼ��ݰ�꼭 ������(�����Ⱓ ���).
  A_ETAX_UNSEND_OVER_VAT          NUMBER          DEFAULT 0,  -- ���꼼�� - ���ڼ��ݰ�꼭 ������(�����Ⱓ ���).
  A_TAX_INV_SUM_BAD_AMT           NUMBER          DEFAULT 0,  -- ���꼼�� - ���ݰ�꼭 �հ�ǥ ����Ҽ���.
  A_TAX_INV_SUM_BAD_VAT           NUMBER          DEFAULT 0,  -- ���꼼�� - ���ݰ�꼭 �հ�ǥ ����Ҽ���.
  A_REPORT_BAD_AMT                NUMBER          DEFAULT 0,  -- ���꼼�� - �Ű�Ҽ���.
  A_REPORT_BAD_VAT                NUMBER          DEFAULT 0,  -- ���꼼�� - �Ű�Ҽ���.
  A_PAYMENT_BAD_AMT               NUMBER          DEFAULT 0,  -- ���꼼�� - ���κҼ���.
  A_PAYMENT_BAD_VAT               NUMBER          DEFAULT 0,  -- ���꼼�� - ���κҼ���.
  A_ZERO_REPORT_BAD_AMT           NUMBER          DEFAULT 0,  -- ���꼼�� - ����������ǥ�ؽŰ�Ҽ���.
  A_ZERO_REPORT_BAD_VAT           NUMBER          DEFAULT 0,  -- ���꼼�� - ����������ǥ�ؽŰ�Ҽ���.
  A_CASH_SALES_UNREPORT_AMT       NUMBER          DEFAULT 0,  -- ���꼼�� - ���ݸ������ ������.
  A_CASH_SALES_UNREPORT_VAT       NUMBER          DEFAULT 0,  -- ���꼼�� - ���ݸ������ ������.
  TAX_ADDITION_SUM_AMT            NUMBER          DEFAULT 0,  -- ���꼼�� �հ�.
  TAX_ADDITION_SUM_VAT            NUMBER          DEFAULT 0,  -- ���꼼�� �հ�.
  BILL_ISSUE_AMT                  NUMBER          DEFAULT 0,  -- ��꼭 ���αݾ�.
  BILL_RECEIPT_AMT                NUMBER          DEFAULT 0,  -- ��꼭 ����ݾ�.
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE FI_VAT_DECLARATION_ATTACH IS '�ΰ���ġ�� �Ű�';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.DECLARATION_ID IS '�Ű�ID';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SS_TAX_INVOICE_AMT IS '�������� ���ݰ�꼭(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SS_TAX_INVOICE_VAT IS '�������� ���ݰ�꼭';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SS_TAX_ETC_AMT IS '�������� ��Ÿ(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SS_TAX_ETC_VAT IS '�������� ��Ÿ';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SS_ZERO_INVOICE_AMT IS '������ ���ݰ�꼭(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SS_ZERO_INVOICE_VAT IS '������ ���ݰ�꼭(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SS_ZERO_ETC_AMT IS '������ ��Ÿ(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SS_ZERO_ETC_VAT IS '������ ��Ÿ(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.S_SALES_SUM_AMT IS '�������� �հ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.S_SALES_SUM_VAT IS '�������� �հ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SP_TAX_INVOICE_AMT IS '���Լ��� ���ݰ�꼭(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SP_TAX_INVOICE_VAT IS '���Լ��� ���ݰ�꼭(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SP_ETC_DED_AMT IS '���Լ��� ��Ÿ���� ���Լ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.SP_ETC_DED_VAT IS '���Լ��� ��Ÿ���� ���Լ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.S_PURCHASE_SUM_AMT IS '���Լ��� �հ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.S_PURCHASE_SUM_VAT IS '���Լ��� �հ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_CREDIT_AMT IS '��Ÿ�������Լ��׸� : �ſ�ī�� �Ϲݸ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_CREDIT_VAT IS '��Ÿ�������Լ��׸� : �ſ�ī�� �Ϲݸ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_CREDIT_ASSET_AMT IS '��Ÿ�������Լ��׸� : �ſ�ī�� �����ڻ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_CREDIT_ASSET_VAT IS '��Ÿ�������Լ��׸� : �ſ�ī�� �����ڻ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_DEEMED_IP_AMT IS '�������Լ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_DEEMED_IP_VAT IS '�������Լ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_RECYCLE_IP_AMT IS '��Ȱ�����ڿ��� ���Լ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_RECYCLE_IP_VAT IS '��Ȱ�����ڿ��� ���Լ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_GOLD_BAR_IP_AMT IS '������� ���Լ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_GOLD_BAR_IP_VAT  IS '������� ���Լ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_TAX_BUSINESS_IP_AMT IS '���������ȯ���Լ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_TAX_BUSINESS_IP_VAT IS '���������ȯ���Լ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_STOCK_IP_AMT IS '�����Լ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_STOCK_IP_VAT IS '�����Լ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_BAD_TAX_AMT  IS '������ռ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.E_BAD_TAX_VAT IS '������ռ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.ETC_DED_IP_SUM_AMT IS '��Ÿ�������Լ��׸� �հ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.ETC_DED_IP_SUM_VAT IS '��Ÿ�������Լ��׸� �հ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.N_NOT_DED_AMT IS '������������ ���Լ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.N_NOT_DED_VAT IS '������������ ���Լ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.N_COMMON_IP_AMT IS '������Լ��� ���������(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.N_COMMON_IP_VAT IS '������Լ��� ���������(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.N_BAD_RECEIVE_AMT IS '���ó�й�������(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.N_BAD_RECEIVE_VAT IS '���ó�й�������(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.NOT_DED_SUM_AMT IS '�����������Ҹ��Լ��׸��հ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.NOT_DED_SUM_VAT IS '�����������Ҹ��Լ��׸��հ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_ETAX_REPORT_AMT IS '�氨�������� - ���ڽŰ��װ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_ETAX_REPORT_VAT IS '�氨�������� - ���ڽŰ��װ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_ETAX_ISSUE_AMT IS '�氨�������� - ���ڼ��ݰ�꼭 �߱޼��װ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_ETAX_ISSUE_VAT IS '�氨�������� - ���ڼ��ݰ�꼭 �߱޼��װ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_TAXI_TRANSPORT_AMT  IS '�氨�������� - �ýÿ�ۻ���ڰ氨����(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_TAXI_TRANSPORT_VAT IS '�氨�������� - �ýÿ�ۻ���ڰ氨����(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_CASH_BILL_AMT IS '�氨�������� - ���ݿ���������ڼ��װ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_CASH_BILL_VAT IS '�氨�������� - ���ݿ���������ڼ��װ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_ETC_DED_AMT IS '�氨�������� - ��Ÿ����.�氨����(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.R_ETC_DED_VAT  IS '�氨�������� - ��Ÿ����.�氨����(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.REDUCE_DED_SUM_AMT IS '�氨�������� �հ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.REDUCE_DED_SUM_VAT IS '�氨�������� �հ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_VAT_NUM_UNENROLL_AMT IS '���꼼�� - ����ڹ̵�ϵ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_VAT_NUM_UNENROLL_VAT IS '���꼼�� - ����ڹ̵�ϵ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_TAX_INVOICE_DELAY_AMT IS '���꼼�� - ���ݰ�꼭 �����߱޵�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_TAX_INVOICE_DELAY_VAT IS '���꼼�� - ���ݰ�꼭 �����߱޵�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_TAX_INVOICE_UNISSUE_AMT IS '���꼼�� - ���ݰ�꼭 �̹߱޵�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_TAX_INVOICE_UNISSUE_VAT IS '���꼼�� - ���ݰ�꼭 �̹߱޵�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_ETAX_UNSEND_IN_AMT  IS '���꼼�� - ���ڼ��ݰ�꼭 ������(�����Ⱓ��)(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_ETAX_UNSEND_IN_VAT IS '���꼼�� - ���ڼ��ݰ�꼭 ������(�����Ⱓ��)(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_ETAX_UNSEND_OVER_AMT IS '���꼼�� - ���ڼ��ݰ�꼭 ������(�����Ⱓ ���)(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_ETAX_UNSEND_OVER_VAT IS '���꼼�� - ���ڼ��ݰ�꼭 ������(�����Ⱓ ���)(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_TAX_INV_SUM_BAD_AMT IS '���꼼�� - ���ݰ�꼭 �հ�ǥ ����Ҽ���AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_TAX_INV_SUM_BAD_VAT  IS '���꼼�� - ���ݰ�꼭 �հ�ǥ ����Ҽ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_REPORT_BAD_AMT IS '���꼼�� - �Ű�Ҽ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_REPORT_BAD_VAT IS '���꼼�� - �Ű�Ҽ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_PAYMENT_BAD_AMT IS '���꼼�� - ���κҼ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_PAYMENT_BAD_VAT IS '���꼼�� - ���κҼ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_ZERO_REPORT_BAD_AMT IS '���꼼�� - ����������ǥ�ؽŰ�Ҽ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_ZERO_REPORT_BAD_VAT IS '���꼼�� - ����������ǥ�ؽŰ�Ҽ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_CASH_SALES_UNREPORT_AMT  IS '���꼼�� - ���ݸ������ ������(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.A_CASH_SALES_UNREPORT_VAT IS '���꼼�� - ���ݸ������ ������(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.TAX_ADDITION_SUM_AMT  IS '���꼼�� �հ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.TAX_ADDITION_SUM_VAT IS '���꼼�� �հ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.CREATION_DATE  IS '��������';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.CREATED_BY IS '������';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN FI_VAT_DECLARATION_ATTACH.LAST_UPDATED_BY IS '����������';

-- PRKMARY KEY.
ALTER TABLE FI_VAT_DECLARATION_ATTACH ADD CONSTRAINT FI_VAT_DECLARATION_ATTACH_PK PRIMARY KEY(DECLARATION_ID);

-- ANALYZE.
ANALYZE TABLE FI_VAT_DECLARATION_ATTACH COMPUTE STATISTICS;

