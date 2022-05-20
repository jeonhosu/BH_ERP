/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_ZERO_RATE_DOCUMENT
/* Description  : ������ �������.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2013  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_ZERO_RATE_DOCUMENT
( TAX_CODE                        VARCHAR2(10)  NOT NULL,   -- �ΰ���ġ���Ű�Ⱓ���� ID  
  VAT_MNG_SERIAL                  NUMBER        NOT NULL,
  SOB_ID                          NUMBER        NOT NULL,   
  ORG_ID                          NUMBER        NOT NULL,
  V_11_01_01_1                    NUMBER        DEFAULT 0,
  V_11_01_01_2                    NUMBER        DEFAULT 0,
  V_11_01_01_3                    NUMBER        DEFAULT 0,
  V_11_01_01_4                    NUMBER        DEFAULT 0,
  V_11_01_01_5                    NUMBER        DEFAULT 0,
  V_11_01_02_1                    NUMBER        DEFAULT 0,
  V_11_01_03_1                    NUMBER        DEFAULT 0,
  V_11_01_03_2                    NUMBER        DEFAULT 0,
  V_11_01_04_1                    NUMBER        DEFAULT 0,
  V_11_01_04_2                    NUMBER        DEFAULT 0,
  V_11_01_04_3                    NUMBER        DEFAULT 0,
  V_11_01_04_4                    NUMBER        DEFAULT 0,
  V_11_01_04_5                    NUMBER        DEFAULT 0,
  V_11_01_04_6                    NUMBER        DEFAULT 0,
  V_11_01_04_7                    NUMBER        DEFAULT 0,
  V_11_01_04_8                    NUMBER        DEFAULT 0,
  V_SUM_AMT                       NUMBER        DEFAULT 0,
  T_105_01_01_1                   NUMBER        DEFAULT 0,
  T_105_01_03_1                   NUMBER        DEFAULT 0,
  T_105_01_03_2                   NUMBER        DEFAULT 0,
  T_105_01_04_1                   NUMBER        DEFAULT 0,
  T_105_01_05_1                   NUMBER        DEFAULT 0,
  T_107_00_00_0                   NUMBER        DEFAULT 0,
  T_121_13_00_0                   NUMBER        DEFAULT 0,
  T_SUM_AMT                       NUMBER        DEFAULT 0,
  TOTAL_AMT                       NUMBER        DEFAULT 0,    
  ATTRIBUTE_A                     VARCHAR2(150) ,
  ATTRIBUTE_B                     VARCHAR2(150) ,
  ATTRIBUTE_C                     VARCHAR2(150) ,
  ATTRIBUTE_D                     VARCHAR2(150) ,
  ATTRIBUTE_E                     VARCHAR2(150) ,
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

COMMENT ON TABLE FI_VAT_ZERO_RATE_DOCUMENT IS '������ �������';
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.TAX_CODE IS '������ڵ�'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.VAT_MNG_SERIAL IS '�ΰ����Ű�Ⱓ���й�ȣ'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_01_1 IS '��������(������� ����)';
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_01_2 IS '�߰蹫��/��Ź�Ǹ�/�ܱ��ε� �Ǵ� ��Ź�������� ����� ����';
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_01_3 IS '�����ſ���/����Ȯ�μ��� ���Ͽ� �����ϴ� ��ȭ';
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_01_4 IS '�ѱ��������´� �� �ѱ����������Ƿ���ܿ� �����ϴ� �ؿܹ���� ��ȭ';
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_01_5 IS '��Ź�������� ��������� �����ϴ� ��ȭ';
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_02_1 IS '���ܿ��� �����ϴ� �뿪';
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_03_1 IS '����/�װ��⿡ ���� �ܱ�����뿪'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_03_2 IS '�������տ�۰�࿡ ���� �ܱ�����뿪'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_04_1 IS '�������� �������/�ܱ����ο��� ���޵Ǵ� ��ȭ �Ǵ� �뿪'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_04_2 IS '������ȭ�Ӱ����뿪'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_04_3 IS '�ܱ����� ����/�װ��� � �����ϴ� ��ȭ �Ǵ� �뿪'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_04_4 IS '���� ���� �ܱ�����/������/�������հ� �̿� ���ϴ� �����ⱸ, �������ձ� �Ǵ� �̱������� �����ϴ� ��ȭ �Ǵ� �뿪'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_04_5 IS '����������� ���� �Ϲݿ������ �Ǵ� �ܱ������� �������ǰ �Ǹž��ڰ� �ܱ��ΰ��������� �����ϴ� �����˼� �뿪 �Ǵ� �������ǰ'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_04_6 IS '�ܱ��������Ǹ��� �Ǵ� ���ѿܱ����� ���� ���� �������������� �����ϴ� ��ȭ �Ǵ� �뿪'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_04_7 IS '�ܱ��� ��� �����ϴ� ��ȭ �Ǵ� �뿪'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_11_01_04_8 IS '�ܱ���ȯ�� ��ġ�뿪'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.V_SUM_AMT    IS '�ΰ���ġ������ ���� ������ ���� ���޽��� �հ�'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.T_105_01_01_1 IS '����������� �� ���δ� � �����ϴ� ������'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.T_105_01_03_1 IS '����ö���Ǽ��뿪'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.T_105_01_03_2 IS '����/������ġ��ü�� �����ϴ� ��ȸ��ݽü���'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.T_105_01_04_1 IS '����ο� ���屸 �� ����ο� ������ű�� ��'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.T_105_01_05_1 IS '��/��� ��� �����ϴ� �����/������/�Ӿ��� �Ǵ� ����� ������'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.T_107_00_00_0 IS '�ܱ��ΰ����� ��� �����ϴ� ��ȭ'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.T_121_13_00_0 IS '����Ư����ġ�� �鼼ǰ�Ǹ��忡�� �Ǹ��ϰų� ����Ư����ġ�� �鼼ǰ�Ǹ��忡 �����ϴ� ��ǰ'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.T_SUM_AMT    IS '��Ư�� �� �� ���� ������ ���� ������ ���� ���޽��� �հ�'; 
COMMENT ON COLUMN FI_VAT_ZERO_RATE_DOCUMENT.TOTAL_AMT    IS '������ ���� ���޽��� �� �հ�'; 

ALTER TABLE FI_VAT_ZERO_RATE_DOCUMENT ADD CONSTRAINT FI_VAT_ZERO_RATE_DOCUMENT_PK PRIMARY KEY (TAX_CODE, VAT_MNG_SERIAL, SOB_ID, ORG_ID);
