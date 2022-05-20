/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : FI
/* PROGRAM NAME : FI_SURTAX_CARD
/* DESCRIPTION  : �Ϲݰ����� �ΰ���ġ�� �Ű�.
/* REFERENCE BY : ȸ�� ���� ���� ����.
/* PROGRAM HISTORY
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 07-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- CREATE TABLE
CREATE TABLE FI_SURTAX_CARD
(
  SOB_ID                      NUMBER NOT NULL,
  ORG_ID                      NUMBER NOT NULL,
  TAX_CODE                    VARCHAR2(10) NOT NULL,
  VAT_MNG_SERIAL              NUMBER NOT NULL,
  SPEC_SERIAL                 NUMBER NOT NULL,
  VAT_MAKE_GB                 VARCHAR2(50),
  GUBUN_1                     VARCHAR2(1),
  GUBUN_2                     VARCHAR2(1),
  GUBUN_3                     VARCHAR2(1),
  GUBUN_4                     VARCHAR2(1),
  TITLE_1_1                   DATE,
  TITLE_1_2                   DATE,
  TITLE_2                     VARCHAR2(50),
  TITLE_3                     VARCHAR2(50),
  TITLE_4                     VARCHAR2(30),
  TITLE_5                     VARCHAR2(30),
  TITLE_6                     VARCHAR2(30),
  TITLE_7                     VARCHAR2(30),
  TITLE_8                     VARCHAR2(30),
  TITLE_9                     VARCHAR2(100),
  TITLE_10                    VARCHAR2(50),
  TITLE_11                    VARCHAR2(50),
  TITLE_12                    VARCHAR2(50),
  TITLE_13                    VARCHAR2(30),
  TITLE_14                    DATE,
  TITLE_15                    VARCHAR2(30),
  TITLE_16                    VARCHAR2(50),
  COL1_1                      NUMBER,
  COL1_2                      NUMBER,
  COL2_1                      NUMBER,
  COL2_2                      NUMBER,
  COL3_1                      NUMBER,
  COL3_2                      NUMBER,
  COL4_1                      NUMBER,
  COL4_2                      NUMBER,
  COL5_1                      NUMBER,
  COL6_1                      NUMBER,
  COL7_1                      NUMBER,
  COL7_2                      NUMBER,
  COL8_2                      NUMBER,
  COL9_1                      NUMBER,
  COL9_2                      NUMBER,
  COL10_1                     NUMBER,
  COL10_2                     NUMBER,
  COL11_1                     NUMBER,
  COL11_2                     NUMBER,
  COL12_1                     NUMBER,
  COL12_2                     NUMBER,
  COL13_1                     NUMBER,
  COL13_2                     NUMBER,
  COL14_1                     NUMBER,
  COL14_2                     NUMBER,
  COL15_1                     NUMBER,
  COL15_2                     NUMBER,
  COL16_1                     NUMBER,
  COL16_2                     NUMBER,
  COL17_1                     NUMBER,
  COL17_2                     NUMBER,
  COL_DA                      NUMBER,
  COL18_2                     NUMBER,
  COL19_2                     NUMBER,
  COL20_2                     NUMBER,
  COL21_2                     NUMBER,
  COL22_2                     NUMBER,
  COL23_2                     NUMBER,
  COL24_2                     NUMBER,
  COL25                       NUMBER,
  DEAL_BANK                   VARCHAR2(50),
  DEAL_BANK_CD                VARCHAR2(20),
  DEAL_BRANCH                 VARCHAR2(50),
  DEAL_BRANCH_ID              NUMBER,
  ACC_NO                      VARCHAR2(50),
  CLOSURE_DATE                DATE,
  CLOSURE_REASON              VARCHAR2(100),
  COL26_1                     VARCHAR2(50),
  COL26_2                     VARCHAR2(50),
  COL26_3                     NUMBER,
  COL27_1                     VARCHAR2(50),
  COL27_2                     VARCHAR2(50),
  COL27_3                     NUMBER,
  COL28_1                     VARCHAR2(50),
  COL28_2                     VARCHAR2(50),
  COL28_3                     NUMBER,
  COL29_1                     VARCHAR2(50),
  COL29_2                     VARCHAR2(50),
  COL29_3                     NUMBER,
  COL30                       NUMBER,
  COL31_1                     NUMBER,
  COL31_2                     NUMBER,
  COL32_1                     NUMBER,
  COL32_2                     NUMBER,
  COL33_1                     NUMBER,
  COL34_1                     NUMBER,
  COL35_1                     NUMBER,
  COL35_2                     NUMBER,
  COL36_1                     NUMBER,
  COL36_2                     NUMBER,
  COL37_1                     NUMBER,
  COL37_2                     NUMBER,
  COL38_1                     NUMBER,
  COL38_2                     NUMBER,
  COL39_1                     NUMBER,
  COL39_2                     NUMBER,
  COL40_1                     NUMBER,
  COL40_2                     NUMBER,
  COL41_1                     NUMBER,
  COL41_2                     NUMBER,
  COL42_1                     NUMBER,
  COL42_2                     NUMBER,
  COL43_1                     NUMBER,
  COL43_2                     NUMBER,
  COL44_2                     NUMBER,
  COL45_2                     NUMBER,
  COL46_2                     NUMBER,
  COL47_1                     NUMBER,
  COL47_2                     NUMBER,
  COL48_1                     NUMBER,
  COL48_2                     NUMBER,
  COL49_1                     NUMBER,
  COL49_2                     NUMBER,
  COL50_1                     NUMBER,
  COL50_2                     NUMBER,
  COL51_1                     NUMBER,
  COL51_2                     NUMBER,
  COL52_2                     NUMBER,
  COL53_2                     NUMBER,
  COL54_2                     NUMBER,
  COL55_2                     NUMBER,
  COL56_2                     NUMBER,
  COL57_2                     NUMBER,
  COL58_1                     NUMBER,
  COL58_2                     NUMBER,
  COL59_1                     NUMBER,
  COL59_2                     NUMBER,
  COL60_1                     NUMBER,
  COL60_2                     NUMBER,
  COL61_1                     NUMBER,
  COL61_2                     NUMBER,
  COL62_1                     NUMBER,
  COL62_2                     NUMBER,
  COL63_1                     NUMBER,
  COL63_2                     NUMBER,
  COL64_1                     NUMBER,
  COL64_2                     NUMBER,
  COL65_1                     NUMBER,
  COL65_2                     NUMBER,
  COL66_1                     NUMBER,
  COL66_2                     NUMBER,
  COL67_1                     NUMBER,
  COL67_2                     NUMBER,
  COL68_2                     NUMBER,
  COL69_1                     VARCHAR2(50),
  COL69_2                     VARCHAR2(50),
  COL69_3                     NUMBER,
  COL70_1                     VARCHAR2(50),
  COL70_2                     VARCHAR2(50),
  COL70_3                     NUMBER,
  COL71_1                     VARCHAR2(50),
  COL71_2                     VARCHAR2(50),
  COL71_3                     NUMBER,
  COL72                       NUMBER,
  COL73                       NUMBER,
  COL74                       NUMBER,
  HOMETAX_USERID              VARCHAR2(20),
  VAT_PRESENTER_GB            NUMBER(1),
  VAT_LEVIER_GB               VARCHAR2(1),
  VAT_REFUND_GB               VARCHAR2(1),
  E_FILE_SURTAX_YN            VARCHAR2(1),
  E_FILE_ZERO_YN              VARCHAR2(1),
  E_FILE_REAL_ESTATE_YN       VARCHAR2(1),
  E_FILE_BLD_YN               VARCHAR2(1),
  E_FILE_NO_DEDUCTION_YN      VARCHAR2(1),
  E_FILE_SUM_VAT_YN           VARCHAR2(1),
  E_FILE_SUM_CALC_YN          VARCHAR2(1),
  E_FILE_EXPORT_YN            VARCHAR2(1),
  E_FILE_GET_YN               VARCHAR2(1),
  CREATION_DATE               DATE NOT NULL,
  CREATED_BY                  NUMBER NOT NULL,
  LAST_UPDATE_DATE            DATE NOT NULL,
  LAST_UPDATED_BY             NUMBER NOT NULL,
  E_FILE_TAX_PUB_YN           VARCHAR2(1),
  E_FILE_DOMESTIC_LC_YN       VARCHAR2(1),
  R_ORIGIN_PLACE_AMT          NUMBER DEFAULT 0,
  R_ORIGIN_PLACE_VAT          NUMBER DEFAULT 0,
  A_TAX_RECEIVE_DELAY_AMT     NUMBER DEFAULT 0,
  A_TAX_RECEIVE_DELAY_VAT     NUMBER DEFAULT 0,
  A_TAX_INV_SUM_BAD_AMT_1     NUMBER DEFAULT 0,
  A_TAX_INV_SUM_BAD_VAT_1     NUMBER DEFAULT 0,
  A_REPORT_BAD_AMT_1          NUMBER DEFAULT 0,
  A_REPORT_BAD_VAT_1          NUMBER DEFAULT 0,
  A_REPORT_BAD_AMT_2          NUMBER DEFAULT 0,
  A_REPORT_BAD_VAT_2          NUMBER DEFAULT 0,
  A_REPORT_BAD_AMT_3          NUMBER DEFAULT 0,
  A_REPORT_BAD_VAT_3          NUMBER DEFAULT 0,
  A_REPORT_BAD_AMT_4          NUMBER DEFAULT 0,
  A_REPORT_BAD_VAT_4          NUMBER DEFAULT 0,
  A_REALTY_LEASE_UNREPORT_AMT NUMBER DEFAULT 0,
  A_REALTY_LEASE_UNREPORT_VAT NUMBER DEFAULT 0,
  MODIFY_DEGREE               NUMBER,
  MODIFY_DESC                 VARCHAR2(300),
  CLOSED_FLAG                 VARCHAR2(2) DEFAULT 'N',
  LAST_FLAG                   VARCHAR2(2) DEFAULT 'N'
)
TABLESPACE FCM_TS_DATA
  PCTFREE 10
  INITRANS 1
  MAXTRANS 255
  STORAGE
  (
    INITIAL 64K
    NEXT 1M
    MINEXTENTS 1
    MAXEXTENTS UNLIMITED
  );
  
-- 2014.1�� ���� �߰� 
ALTER TABLE FI_SURTAX_CARD ADD COL26_4                    VARCHAR2(200);
ALTER TABLE FI_SURTAX_CARD ADD COL27_4                    VARCHAR2(200);
ALTER TABLE FI_SURTAX_CARD ADD COL28_4                    VARCHAR2(200);
ALTER TABLE FI_SURTAX_CARD ADD COL29_4                    VARCHAR2(200);

ALTER TABLE FI_SURTAX_CARD ADD PROXY_PAY_TAX_AMT          NUMBER DEFAULT 0;
ALTER TABLE FI_SURTAX_CARD ADD PROXY_PAY_TAX_VAT          NUMBER DEFAULT 0;
ALTER TABLE FI_SURTAX_CARD ADD SPECIAL_PAY_TAX_AMT        NUMBER DEFAULT 0;
ALTER TABLE FI_SURTAX_CARD ADD SPECIAL_PAY_TAX_VAT        NUMBER DEFAULT 0;
ALTER TABLE FI_SURTAX_CARD ADD E_FORE_TOUR_REFUND_AMT     NUMBER DEFAULT 0;
ALTER TABLE FI_SURTAX_CARD ADD E_FORE_TOUR_REFUND_VAT     NUMBER DEFAULT 0;   
ALTER TABLE FI_SURTAX_CARD ADD A_MISS_DEAL_ACCOUNT_AMT    NUMBER DEFAULT 0;
ALTER TABLE FI_SURTAX_CARD ADD A_MISS_DEAL_ACCOUNT_VAT    NUMBER DEFAULT 0;
ALTER TABLE FI_SURTAX_CARD ADD A_DELAY_PAYMENT_AMT        NUMBER DEFAULT 0;
ALTER TABLE FI_SURTAX_CARD ADD A_DELAY_PAYMENT_VAT        NUMBER DEFAULT 0;

COMMENT ON COLUMN FI_SURTAX_CARD.COL26_4 IS '2014.04.01-����ǥ�� ������1';
COMMENT ON COLUMN FI_SURTAX_CARD.COL27_4 IS '2014.04.01-����ǥ�� ������2';
COMMENT ON COLUMN FI_SURTAX_CARD.COL28_4 IS '2014.04.01-����ǥ�� ������3';
COMMENT ON COLUMN FI_SURTAX_CARD.COL29_4 IS '2014.04.01-����ǥ�� ������4';
COMMENT ON COLUMN FI_SURTAX_CARD.PROXY_PAY_TAX_AMT IS '2014.04.01-���������� �븮���� �ⳳ�μ���';
COMMENT ON COLUMN FI_SURTAX_CARD.PROXY_PAY_TAX_VAT IS '2014.04.01-���������� �븮���� �ⳳ�μ���';
COMMENT ON COLUMN FI_SURTAX_CARD.SPECIAL_PAY_TAX_AMT IS '2014.04.01-�����ڳ���Ư�� �ⳳ�μ���';
COMMENT ON COLUMN FI_SURTAX_CARD.SPECIAL_PAY_TAX_VAT IS '2014.04.01-�����ڳ���Ư�� �ⳳ�μ���';
COMMENT ON COLUMN FI_SURTAX_CARD.E_FORE_TOUR_REFUND_AMT IS '2014.04.01-�׹��� �������Լ��� : �ܱ��� �������� ���� ȯ�޼���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_SURTAX_CARD.E_FORE_TOUR_REFUND_VAT IS '2014.04.01-�׹��� �������Լ��� : �ܱ��� �������� ���� ȯ�޼���';
COMMENT ON COLUMN FI_SURTAX_CARD.A_MISS_DEAL_ACCOUNT_AMT IS '2014.04.01-���꼼�� : ������ ����Ư�� �ŷ����� �̻��(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_SURTAX_CARD.A_MISS_DEAL_ACCOUNT_VAT IS '2014.04.01-���꼼�� : ������ ����Ư�� �ŷ����� �̻��';
COMMENT ON COLUMN FI_SURTAX_CARD.A_DELAY_PAYMENT_AMT IS '2014.04.01-���꼼�� : ������ ����Ư�� �ŷ����� �����Ա�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_SURTAX_CARD.A_DELAY_PAYMENT_VAT IS '2014.04.01-���꼼�� : ������ ����Ư�� �ŷ����� �����Ա�';



-- ADD COMMENTS TO THE TABLE 
COMMENT ON TABLE FI_SURTAX_CARD IS '�ΰ����Ű�';
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN FI_SURTAX_CARD.SOB_ID IS 'ȸ����̵�';
COMMENT ON COLUMN FI_SURTAX_CARD.ORG_ID IS '����ξ��̵�';
COMMENT ON COLUMN FI_SURTAX_CARD.TAX_CODE IS '�������̵�';
COMMENT ON COLUMN FI_SURTAX_CARD.VAT_MNG_SERIAL IS '�ΰ����Ű�Ⱓ���й�ȣ';
COMMENT ON COLUMN FI_SURTAX_CARD.SPEC_SERIAL IS '�Ϸù�ȣ';
COMMENT ON COLUMN FI_SURTAX_CARD.VAT_MAKE_GB IS '�Ű���(01-����Ű�, 02-�����Ű�)';
COMMENT ON COLUMN FI_SURTAX_CARD.GUBUN_1 IS '�Ű�����_����';
COMMENT ON COLUMN FI_SURTAX_CARD.GUBUN_2 IS '�Ű�����_Ȯ��';
COMMENT ON COLUMN FI_SURTAX_CARD.GUBUN_3 IS '�Ű�����_�����İ���ǥ��';
COMMENT ON COLUMN FI_SURTAX_CARD.GUBUN_4 IS '�Ű�����_������������ȯ��';
COMMENT ON COLUMN FI_SURTAX_CARD.TITLE_1_1 IS '�Ű�Ⱓ_����';
COMMENT ON COLUMN FI_SURTAX_CARD.TITLE_1_2 IS '�Ű�Ⱓ_����';
COMMENT ON COLUMN FI_SURTAX_CARD.TITLE_2 IS '��ȣ';
COMMENT ON COLUMN FI_SURTAX_CARD.TITLE_3 IS '����';
COMMENT ON COLUMN FI_SURTAX_CARD.TITLE_4 IS '����ڵ�Ϲ�ȣ';
COMMENT ON COLUMN FI_SURTAX_CARD.TITLE_5 IS '���ε�Ϲ�ȣ';
COMMENT ON COLUMN FI_SURTAX_CARD.TITLE_6 IS '�������ȭ';
COMMENT ON COLUMN FI_SURTAX_CARD.TITLE_7 IS '�ּ�����ȭ';
COMMENT ON COLUMN FI_SURTAX_CARD.TITLE_8 IS '�޴���ȭ';
COMMENT ON COLUMN FI_SURTAX_CARD.TITLE_9 IS '������ּ�';
COMMENT ON COLUMN FI_SURTAX_CARD.TITLE_10 IS '���ڿ����ּ�';
COMMENT ON COLUMN FI_SURTAX_CARD.TITLE_11 IS '����';
COMMENT ON COLUMN FI_SURTAX_CARD.TITLE_12 IS '����';
COMMENT ON COLUMN FI_SURTAX_CARD.TITLE_13 IS '�����ڵ�';
COMMENT ON COLUMN FI_SURTAX_CARD.TITLE_14 IS '�ۼ�����';
COMMENT ON COLUMN FI_SURTAX_CARD.TITLE_15 IS '�Ű���';
COMMENT ON COLUMN FI_SURTAX_CARD.TITLE_16 IS '������';
COMMENT ON COLUMN FI_SURTAX_CARD.COL1_1 IS '����_���ݰ�꼭�߱޺�_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL1_2 IS '����_���ݰ�꼭�߱޺�_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL2_1 IS '����_�����ڹ��༼�ݰ�꼭_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL2_2 IS '����_�����ڹ��༼�ݰ�꼭_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL3_1 IS '����_�ſ�ī��_���ݿ����������_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL3_2 IS '����_�ſ�ī��_���ݿ����������_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL4_1 IS '����_��Ÿ_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL4_2 IS '����_��Ÿ_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL5_1 IS '������_���ݰ�꼭�߱޺�_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL6_1 IS '�缼��_��Ÿ_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL7_1 IS '�����Ű�����_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL7_2 IS '�����Ű�����_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL8_2 IS '��ռ��װ���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL9_1 IS '�հ�_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL9_2 IS '�հ�_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL10_1 IS '����_�Ϲݸ���_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL10_2 IS '����_�Ϲݸ���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL11_1 IS '����_�����ڻ����_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL11_2 IS '����_�����ڻ����_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL12_1 IS '����_�����Ű�����_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL12_2 IS '����_�����Ű�����_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL13_1 IS '����_�����ڹ��༼�ݰ�꼭_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL13_2 IS '����_�����ڹ��༼�ݰ�꼭_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL14_1 IS '����_��Ÿ�������Լ���_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL14_2 IS '����_��Ÿ�������Լ���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL15_1 IS '����_�հ�_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL15_2 IS '����_�հ�_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL16_1 IS '����_�����������Ҹ��Լ���_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL16_2 IS '����_�����������Ҹ��Լ���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL17_1 IS '����_������_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL17_2 IS '����_������_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL_DA IS '���μ���';
COMMENT ON COLUMN FI_SURTAX_CARD.COL18_2 IS '��Ÿ�氨��������';
COMMENT ON COLUMN FI_SURTAX_CARD.COL19_2 IS '�ſ�ī�������ǥ����������';
COMMENT ON COLUMN FI_SURTAX_CARD.COL20_2 IS '�氨����_�հ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL21_2 IS '�����Ű��ȯ�޼���';
COMMENT ON COLUMN FI_SURTAX_CARD.COL22_2 IS '������������';
COMMENT ON COLUMN FI_SURTAX_CARD.COL23_2 IS '������_������_����Ư��_�ⳳ�μ���';
COMMENT ON COLUMN FI_SURTAX_CARD.COL24_2 IS '���꼼�װ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL25 IS '�������Ͽ������Ҽ���';
COMMENT ON COLUMN FI_SURTAX_CARD.DEAL_BANK IS '�ŷ�����';
COMMENT ON COLUMN FI_SURTAX_CARD.DEAL_BANK_CD IS '�ŷ������ڵ�';
COMMENT ON COLUMN FI_SURTAX_CARD.DEAL_BRANCH IS '�ŷ�����';
COMMENT ON COLUMN FI_SURTAX_CARD.DEAL_BRANCH_ID IS '�ŷ������ڵ�';
COMMENT ON COLUMN FI_SURTAX_CARD.ACC_NO IS '���¹�ȣ';
COMMENT ON COLUMN FI_SURTAX_CARD.CLOSURE_DATE IS '�����';
COMMENT ON COLUMN FI_SURTAX_CARD.CLOSURE_REASON IS '�������';
COMMENT ON COLUMN FI_SURTAX_CARD.COL26_1 IS '����ǥ��_����1';
COMMENT ON COLUMN FI_SURTAX_CARD.COL26_2 IS '����ǥ��_����1';
COMMENT ON COLUMN FI_SURTAX_CARD.COL26_3 IS '����ǥ��_�ݾ�1';
COMMENT ON COLUMN FI_SURTAX_CARD.COL27_1 IS '����ǥ��_����2';
COMMENT ON COLUMN FI_SURTAX_CARD.COL27_2 IS '����ǥ��_����2';
COMMENT ON COLUMN FI_SURTAX_CARD.COL27_3 IS '����ǥ��_�ݾ�2';
COMMENT ON COLUMN FI_SURTAX_CARD.COL28_1 IS '����ǥ��_����3';
COMMENT ON COLUMN FI_SURTAX_CARD.COL28_2 IS '����ǥ��_����3';
COMMENT ON COLUMN FI_SURTAX_CARD.COL28_3 IS '����ǥ��_�ݾ�3';
COMMENT ON COLUMN FI_SURTAX_CARD.COL29_1 IS '����ǥ��_����4';
COMMENT ON COLUMN FI_SURTAX_CARD.COL29_2 IS '����ǥ��_����4';
COMMENT ON COLUMN FI_SURTAX_CARD.COL29_3 IS '����ǥ��_�ݾ�4';
COMMENT ON COLUMN FI_SURTAX_CARD.COL30 IS '����ǥ��_�հ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL31_1 IS '�����Ű�_����_����_���ݰ�꼭_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL31_2 IS '�����Ű�_����_����_���ݰ�꼭_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL32_1 IS '�����Ű�_����_����_��Ÿ_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL32_2 IS '�����Ű�_����_����_��Ÿ_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL33_1 IS '�����Ű�_����_������_���ݰ�꼭';
COMMENT ON COLUMN FI_SURTAX_CARD.COL34_1 IS '�����Ű�_����_������_��Ÿ';
COMMENT ON COLUMN FI_SURTAX_CARD.COL35_1 IS '�����Ű�_����_�հ�_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL35_2 IS '�����Ű�_����_�հ�_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL36_1 IS '�����Ű�_����_���ݰ�꼭_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL36_2 IS '�����Ű�_����_���ݰ�꼭_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL37_1 IS '�����Ű�_����_��Ÿ�������Լ���_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL37_2 IS '�����Ű�_����_��Ÿ�������Լ���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL38_1 IS '�����Ű�_����_�հ�_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL38_2 IS '�����Ű�_����_�հ�_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL39_1 IS '��Ÿ����_�ſ�ī��_�Ϲݸ���_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL39_2 IS '��Ÿ����_�ſ�ī��_�Ϲݸ���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL40_1 IS '��Ÿ����_�ſ�ī��_�����ڻ����_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL40_2 IS '��Ÿ����_�ſ�ī��_�����ڻ����_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL41_1 IS '��Ÿ����_�������Լ���_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL41_2 IS '��Ÿ����_�������Լ���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL42_1 IS '��Ÿ����_��Ȱ�����ڿ�����Լ���_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL42_2 IS '��Ÿ����_��Ȱ�����ڿ�����Լ���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL43_1 IS '��Ÿ����_����������Լ���_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL43_2 IS '��Ÿ����_����������Լ���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL44_2 IS '��Ÿ����_���������ȯ���Լ���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL45_2 IS '��Ÿ����_�����Լ���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL46_2 IS '��Ÿ����_������ռ���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL47_1 IS '��Ÿ����_�հ�_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL47_2 IS '��Ÿ����_���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL48_1 IS '�����������Ҹ��Լ���_������������_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL48_2 IS '�����������Ҹ��Լ���_������������_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL49_1 IS '�����������Ҹ��Լ���_������Լ��׸鼼_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL49_2 IS '�����������Ҹ��Լ���_������Լ��׸鼼_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL50_1 IS '�����������Ҹ��Լ���_���ó�й�������_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL50_2 IS '�����������Ҹ��Լ���_���ó�й�������_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL51_1 IS '�����������Ҹ��Լ���_�հ�_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL51_2 IS '�����������Ҹ��Լ���_�հ�_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL52_2 IS '��Ź�氨��������_���ڽŰ��װ���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL53_2 IS '��Ÿ�氨��������_���ڼ��ݰ�꼭�߱޼��װ���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL54_2 IS '��Ÿ�氨��������_�ýÿ�ۻ���ڰ氨����_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL55_2 IS '��Ÿ�氨��������_���ݿ���������ڼ��װ���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL56_2 IS '��Ÿ�氨��������_��Ÿ_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL57_2 IS '��Ÿ�氨��������_�հ�_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL58_1 IS '���꼼��_����ڹ̵�ϵ�_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL58_2 IS '���꼼��_����ڹ̵�ϵ�_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL59_1 IS '���꼼��_�����߱޵�_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL59_2 IS '���꼼��_�����߱޵�_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL60_1 IS '���꼼��_�̹߱޵�_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL60_2 IS '���꼼��_�̹߱޵�_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL61_1 IS '���꼼��_������15������_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL61_2 IS '���꼼��_������15������_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL62_1 IS '���꼼��_�����Ⱓ������15������_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL62_2 IS '���꼼��_�����Ⱓ������15������_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL63_1 IS '���꼼��_���ݰ�꼭�հ�ǥ����Ҽ���_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL63_2 IS '���꼼��_���ݰ�꼭�հ�ǥ����Ҽ���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL64_1 IS '���꼼��_�Ű�Ҽ���_�ݾ�(�հ�)';
COMMENT ON COLUMN FI_SURTAX_CARD.COL64_2 IS '���꼼��_�Ű�Ҽ���_����(�հ�)';
COMMENT ON COLUMN FI_SURTAX_CARD.COL65_1 IS '���꼼��_���κҼ���_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL65_2 IS '���꼼��_���κҼ���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL66_1 IS '���꼼��_����������ǥ�ؽŰ�Ҽ���_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL66_2 IS '���꼼��_����������ǥ�ؽŰ�Ҽ���_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL67_1 IS '���꼼��_���ݸ�������������_�ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL67_2 IS '���꼼��_���ݸ�������������_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL68_2 IS '���꼼��_�հ�_����';
COMMENT ON COLUMN FI_SURTAX_CARD.COL69_1 IS '�鼼������Աݾ�_����1';
COMMENT ON COLUMN FI_SURTAX_CARD.COL69_2 IS '�鼼������Աݾ�_����1';
COMMENT ON COLUMN FI_SURTAX_CARD.COL69_3 IS '�鼼������Աݾ�_�ݾ�1';
COMMENT ON COLUMN FI_SURTAX_CARD.COL70_1 IS '�鼼������Աݾ�_����2';
COMMENT ON COLUMN FI_SURTAX_CARD.COL70_2 IS '�鼼������Աݾ�_����2';
COMMENT ON COLUMN FI_SURTAX_CARD.COL70_3 IS '�鼼������Աݾ�_�ݾ�2';
COMMENT ON COLUMN FI_SURTAX_CARD.COL71_1 IS '�鼼������Աݾ�_����3';
COMMENT ON COLUMN FI_SURTAX_CARD.COL71_2 IS '�鼼������Աݾ�_����3';
COMMENT ON COLUMN FI_SURTAX_CARD.COL71_3 IS '�鼼������Աݾ�_�ݾ�3';
COMMENT ON COLUMN FI_SURTAX_CARD.COL72 IS '�鼼������Աݾ�_�հ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL73 IS '��꼭�߱ޱݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.COL74 IS '��꼭����ݾ�';
COMMENT ON COLUMN FI_SURTAX_CARD.HOMETAX_USERID IS 'Ȩ�ý�_����ھ��̵�';
COMMENT ON COLUMN FI_SURTAX_CARD.VAT_PRESENTER_GB IS '�����ڱ���';
COMMENT ON COLUMN FI_SURTAX_CARD.VAT_LEVIER_GB IS '�Ϲݰ����ڱ���';
COMMENT ON COLUMN FI_SURTAX_CARD.VAT_REFUND_GB IS 'ȯ�ޱ���';
COMMENT ON COLUMN FI_SURTAX_CARD.E_FILE_SURTAX_YN IS '���ڽŰ����ϻ�����󿩺�_�ΰ����Ű�';
COMMENT ON COLUMN FI_SURTAX_CARD.E_FILE_ZERO_YN IS '���ڽŰ����ϻ�����󿩺�_������÷�μ����������';
COMMENT ON COLUMN FI_SURTAX_CARD.E_FILE_REAL_ESTATE_YN IS '���ڽŰ����ϻ�����󿩺�_�ε����Ӵ���ް��׸���';
COMMENT ON COLUMN FI_SURTAX_CARD.E_FILE_BLD_YN IS '���ڽŰ����ϻ�����󿩺�_�ǹ�������ڻ�������';
COMMENT ON COLUMN FI_SURTAX_CARD.E_FILE_NO_DEDUCTION_YN IS '���ڽŰ����ϻ�����󿩺�_�����������Ҹ��Լ��׸���';
COMMENT ON COLUMN FI_SURTAX_CARD.E_FILE_SUM_VAT_YN IS '���ڽð����ϻ�����󿩺�_���ݰ�꼭�հ�ǥ';
COMMENT ON COLUMN FI_SURTAX_CARD.E_FILE_SUM_CALC_YN IS '���ڽŰ����ϻ�����󿩺�_��꼭�հ�ǥ';
COMMENT ON COLUMN FI_SURTAX_CARD.E_FILE_EXPORT_YN IS '���ڽŰ����ϻ�����󿩺�_�����������';
COMMENT ON COLUMN FI_SURTAX_CARD.E_FILE_GET_YN IS '���ڽŰ����ϻ�����󿩺�_�ſ�ī�������ǥ��������';
COMMENT ON COLUMN FI_SURTAX_CARD.CREATION_DATE IS '������';
COMMENT ON COLUMN FI_SURTAX_CARD.CREATED_BY IS '������';
COMMENT ON COLUMN FI_SURTAX_CARD.LAST_UPDATE_DATE IS '������';
COMMENT ON COLUMN FI_SURTAX_CARD.LAST_UPDATED_BY IS '������';
COMMENT ON COLUMN FI_SURTAX_CARD.E_FILE_TAX_PUB_YN IS '���ڽŰ����ϻ�����󿩺�_���ڼ��ݰ�꼭�߱޼��װ����Ű�';
COMMENT ON COLUMN FI_SURTAX_CARD.E_FILE_DOMESTIC_LC_YN IS '���ڽŰ����ϻ�����󿩺�_�����ſ��屸��Ȯ�μ����ڹ߱޸���';
COMMENT ON COLUMN FI_SURTAX_CARD.R_ORIGIN_PLACE_AMT IS '�氨�������� - ������Ȯ�μ� �߱ް����ݾ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_SURTAX_CARD.R_ORIGIN_PLACE_VAT IS '�氨�������� - ������Ȯ�μ� �߱ް����ݾ�(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_SURTAX_CARD.A_TAX_RECEIVE_DELAY_AMT IS '���꼼�� - ���ݰ�꼭 ��������(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_SURTAX_CARD.A_TAX_RECEIVE_DELAY_VAT IS '���꼼�� - ���ݰ�꼭 ��������(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_SURTAX_CARD.A_TAX_INV_SUM_BAD_AMT_1 IS '���꼼�� - ���ݰ�꼭 �հ�ǥ ��������AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_SURTAX_CARD.A_TAX_INV_SUM_BAD_VAT_1 IS '���꼼�� - ���ݰ�꼭 �հ�ǥ ��������(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_SURTAX_CARD.A_REPORT_BAD_AMT_1 IS '���꼼�� - �Ű�Ҽ���(AMT-�ݾ�, VAT-����)-���Ű�(�Ϲ�)';
COMMENT ON COLUMN FI_SURTAX_CARD.A_REPORT_BAD_VAT_1 IS '���꼼�� - �Ű�Ҽ���(AMT-�ݾ�, VAT-����)-���Ű�(�Ϲ�)';
COMMENT ON COLUMN FI_SURTAX_CARD.A_REPORT_BAD_AMT_2 IS '���꼼�� - �Ű�Ҽ���(AMT-�ݾ�, VAT-����)-���Ű�(�δ�)';
COMMENT ON COLUMN FI_SURTAX_CARD.A_REPORT_BAD_VAT_2 IS '���꼼�� - �Ű�Ҽ���(AMT-�ݾ�, VAT-����)-���Ű�(�δ�)';
COMMENT ON COLUMN FI_SURTAX_CARD.A_REPORT_BAD_AMT_3 IS '���꼼�� - �Ű�Ҽ���(AMT-�ݾ�, VAT-����)-����/�ʰ� ȯ�޽Ű�(�Ϲ�)';
COMMENT ON COLUMN FI_SURTAX_CARD.A_REPORT_BAD_VAT_3 IS '���꼼�� - �Ű�Ҽ���(AMT-�ݾ�, VAT-����)-����/�ʰ� ȯ�޽Ű�(�Ϲ�)';
COMMENT ON COLUMN FI_SURTAX_CARD.A_REPORT_BAD_AMT_4 IS '���꼼�� - �Ű�Ҽ���(AMT-�ݾ�, VAT-����)-����/�ʰ� ȯ�޽Ű�(�δ�)';
COMMENT ON COLUMN FI_SURTAX_CARD.A_REPORT_BAD_VAT_4 IS '���꼼�� - �Ű�Ҽ���(AMT-�ݾ�, VAT-����)-����/�ʰ� ȯ�޽Ű�(�δ�)';
COMMENT ON COLUMN FI_SURTAX_CARD.A_REALTY_LEASE_UNREPORT_AMT IS '���꼼�� - �ε����Ӵ���ް��׸��� �Ҽ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_SURTAX_CARD.A_REALTY_LEASE_UNREPORT_VAT IS '���꼼�� - �ε����Ӵ���ް��׸��� �Ҽ���(AMT-�ݾ�, VAT-����)';
COMMENT ON COLUMN FI_SURTAX_CARD.MODIFY_DEGREE IS '�����Ű� ����';
COMMENT ON COLUMN FI_SURTAX_CARD.MODIFY_DESC IS '��������';
COMMENT ON COLUMN FI_SURTAX_CARD.CLOSED_FLAG IS '��������(�Ű� ���� ó���� ���� FLAG ������Ʈ �ǽ� : ������ �Ŀ� �����Ű� �ۼ��� �����Ű� ���� ����)';
COMMENT ON COLUMN FI_SURTAX_CARD.LAST_FLAG IS '��������(�Ű�)';

-- CREATE/RECREATE PRIMARY, UNIQUE AND FOREIGN KEY CONSTRAINTS 
ALTER TABLE FI_SURTAX_CARD
  ADD CONSTRAINT FI_SURTAX_CARD_PK PRIMARY KEY (SOB_ID, ORG_ID, TAX_CODE, VAT_MNG_SERIAL, SPEC_SERIAL)
  USING INDEX 
  TABLESPACE FCM_TS_DATA
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  STORAGE
  (
    INITIAL 64K
    NEXT 1M
    MINEXTENTS 1
    MAXEXTENTS UNLIMITED
  );

