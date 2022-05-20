/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_FOUNDATION
/* Description  : �������� �����ڷ�.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRA_FOUNDATION
( YEAR_YYYY                                                   VARCHAR2(4) NOT NULL,
  PERSON_ID                                                   NUMBER NOT NULL,
  SOB_ID                                                      NUMBER NOT NULL,
  ORG_ID                                                      NUMBER NOT NULL,
  ADD_BONUS_AMT                                               NUMBER DEFAULT 0,
  ADD_EDUCATION_AMT                                           NUMBER DEFAULT 0,
  ADD_ETC_AMT                                                 NUMBER DEFAULT 0,
  INCOME_OUTSIDE_AMT                                          NUMBER DEFAULT 0,
  NONTAX_OUTSIDE_AMT                                          NUMBER DEFAULT 0,
  TAX_OUTSIDE_AMT                                             NUMBER DEFAULT 0,
  IN_TAX_AMT                                                  NUMBER DEFAULT 0,
  LOCAL_TAX_AMT                                               NUMBER DEFAULT 0,                                                                            
  ANNU_INSUR_AMT                                              NUMBER DEFAULT 0,
  HIRE_MEDIC_INSUR_AMT                                        NUMBER DEFAULT 0,
  GUAR_INSUR_AMT                                              NUMBER DEFAULT 0,
  DEFORM_INSUR_AMT                                            NUMBER DEFAULT 0,
  MEDIC_AMT                                                   NUMBER DEFAULT 0,
  EDUCATION_AMT                                               NUMBER DEFAULT 0,
  HOUSE_SAVE_AMT                                              NUMBER DEFAULT 0,
  HOUSE_ADD_AMT                                               NUMBER DEFAULT 0,
  LONG_HOUSE_INTER_AMT                                        NUMBER DEFAULT 0,
  LONG_HOUSE_INTER_AMT_1                                      NUMBER DEFAULT 0,
  LONG_HOUSE_INTER_AMT_2                                      NUMBER DEFAULT 0,
  SMALL_CORPOR_DED_AMT                                        NUMBER DEFAULT 0,
  LONG_STOCK_SAVING_AMT_1                                     NUMBER DEFAULT 0,
  LONG_STOCK_SAVING_AMT_2                                     NUMBER DEFAULT 0,
  LONG_STOCK_SAVING_AMT_3                                     NUMBER DEFAULT 0,  
  DONAT_ALL                                                   NUMBER DEFAULT 0,
  ETC_DONAT_ALL                                               NUMBER DEFAULT 0,
  DONAT_50P                                                   NUMBER DEFAULT 0,
  ETC_DONAT_50P                                               NUMBER DEFAULT 0,
  DONAT_30P                                                   NUMBER DEFAULT 0,
  ETC_DONAT_30P                                               NUMBER DEFAULT 0,
  DONAT_10P                                                   NUMBER DEFAULT 0,
  ETC_DONAT_10P                                               NUMBER DEFAULT 0,
  DONAT_10P_RELIGION                                          NUMBER DEFAULT 0,
  ETC_DONAT_10P_RELIGION                                      NUMBER DEFAULT 0,
  DONAT_POLI                                                  NUMBER DEFAULT 0,
  ETC_DONAT_POLI                                              NUMBER DEFAULT 0,
  MARRY_COUNT                                                 NUMBER DEFAULT 0, 
  FUNER_COUNT                                                 NUMBER DEFAULT 0,
  HOUSE_MOVE_COUNT                                            NUMBER DEFAULT 0,
  PERSON_ANNU_AMT                                             NUMBER DEFAULT 0,
  ANNU_BANK_AMT                                               NUMBER DEFAULT 0,
  RETR_ANNU_AMT                                               NUMBER DEFAULT 0,
  INVES_AMT                                                   NUMBER DEFAULT 0,
  CREDIT_AMT                                                  NUMBER DEFAULT 0,
  ACADE_GIRO_AMT                                              NUMBER DEFAULT 0,
  CASH_AMT                                                    NUMBER DEFAULT 0,
  EMPL_STOCK_AMT                                              NUMBER DEFAULT 0,
  HOUSE_DEBT_BEN_AMT                                          NUMBER DEFAULT 0,
  DESCRIPTION                                                 VARCHAR2(100),
  ATTRIBUTE1                                                  VARCHAR2(100),
  ATTRIBUTE2                                                  VARCHAR2(100),
  ATTRIBUTE3                                                  VARCHAR2(100),
  ATTRIBUTE4                                                  VARCHAR2(100),
  ATTRIBUTE5                                                  VARCHAR2(100),
  CREATION_DATE                                               DATE NOT NULL,
  CREATED_BY                                                  NUMBER NOT NULL,
  LAST_UPDATE_DATE                                            DATE NOT NULL,
  LAST_UPDATED_BY                                             NUMBER NOT NULL,
  HOUSE_APP_DEPOSIT_AMT                                       NUMBER DEFAULT 0,
  HOUSE_MONTHLY_AMT                                           NUMBER DEFAULT 0,
  LOW_HOUSE_ADD_AMT                                           NUMBER DEFAULT 0
) TABLESPACE FCM_TS_DATA;

--> COMMET ���� 
COMMENT ON TABLE HRA_FOUNDATION IS '������������ڷ�';
COMMENT ON COLUMN HRA_FOUNDATION.YEAR_YYYY IS '����⵵';
COMMENT ON COLUMN HRA_FOUNDATION.PERSON_ID IS '�����ȣ';
COMMENT ON COLUMN HRA_FOUNDATION.ADD_BONUS_AMT IS '�����󿩱�';
COMMENT ON COLUMN HRA_FOUNDATION.ADD_EDUCATION_AMT IS '���ڱ�';
COMMENT ON COLUMN HRA_FOUNDATION.ADD_ETC_AMT IS '��Ÿ����';
COMMENT ON COLUMN HRA_FOUNDATION.INCOME_OUTSIDE_AMT IS '����-���ܼҵ�';
COMMENT ON COLUMN HRA_FOUNDATION.NONTAX_OUTSIDE_AMT IS '�����-���ܼҵ�';
COMMENT ON COLUMN HRA_FOUNDATION.TAX_OUTSIDE_AMT IS '����-���ܼҵ�';
COMMENT ON COLUMN HRA_FOUNDATION.IN_TAX_AMT IS '(��Ÿ)�ⳳ�ҵ漼';
COMMENT ON COLUMN HRA_FOUNDATION.LOCAL_TAX_AMT IS '(��Ÿ)�ⳳ�ֹμ�';
COMMENT ON COLUMN HRA_FOUNDATION.ANNU_INSUR_AMT IS '��Ÿ���ݺ����';
COMMENT ON COLUMN HRA_FOUNDATION.HIRE_MEDIC_INSUR_AMT IS '��Ÿ�����ǷẸ���';
COMMENT ON COLUMN HRA_FOUNDATION.GUAR_INSUR_AMT IS '���庸���';
COMMENT ON COLUMN HRA_FOUNDATION.DEFORM_INSUR_AMT IS '��ֺ����';
COMMENT ON COLUMN HRA_FOUNDATION.MEDIC_AMT IS '���� �Ƿ��';
COMMENT ON COLUMN HRA_FOUNDATION.EDUCATION_AMT IS '���� ������';
COMMENT ON COLUMN HRA_FOUNDATION.HOUSE_SAVE_AMT IS '���ø�������';
COMMENT ON COLUMN HRA_FOUNDATION.HOUSE_ADD_AMT IS '���ÿ����ݻ�ȯ';
COMMENT ON COLUMN HRA_FOUNDATION.LONG_HOUSE_INTER_AMT IS '����������ڻ�ȯ';
COMMENT ON COLUMN HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_1 IS '����������ڻ�ȯ(�ѵ�1000����)';
COMMENT ON COLUMN HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_2 IS '����������ڻ�ȯ(�ѵ�1500����)';
COMMENT ON COLUMN HRA_FOUNDATION.SMALL_CORPOR_DED_AMT IS '�ұ�������α� �ҵ����';
COMMENT ON COLUMN HRA_FOUNDATION.LONG_STOCK_SAVING_AMT_1 IS '����ֽ�������ҵ����1����';
COMMENT ON COLUMN HRA_FOUNDATION.LONG_STOCK_SAVING_AMT_2 IS '����ֽ�������ҵ����2����';
COMMENT ON COLUMN HRA_FOUNDATION.LONG_STOCK_SAVING_AMT_3 IS '����ֽ�������ҵ����3����';
COMMENT ON COLUMN HRA_FOUNDATION.DONAT_ALL IS '���� ��α�';
COMMENT ON COLUMN HRA_FOUNDATION.ETC_DONAT_ALL IS '��Ÿ ���� ��α�';
COMMENT ON COLUMN HRA_FOUNDATION.DONAT_50P IS '50% ��α�';
COMMENT ON COLUMN HRA_FOUNDATION.ETC_DONAT_50P IS '��Ÿ 50% ��α�';
COMMENT ON COLUMN HRA_FOUNDATION.DONAT_30P IS '30% ��α�';
COMMENT ON COLUMN HRA_FOUNDATION.ETC_DONAT_30P IS '��Ÿ 30% ��α�';
COMMENT ON COLUMN HRA_FOUNDATION.DONAT_10P IS '10% ��α�';
COMMENT ON COLUMN HRA_FOUNDATION.ETC_DONAT_10P IS '��Ÿ 10% ��α�';
COMMENT ON COLUMN HRA_FOUNDATION.DONAT_10P_RELIGION IS '������α�-������α�';
COMMENT ON COLUMN HRA_FOUNDATION.ETC_DONAT_10P_RELIGION IS '��Ÿ ������α�-������α�';
COMMENT ON COLUMN HRA_FOUNDATION.DONAT_POLI IS '��ġ ��α�';
COMMENT ON COLUMN HRA_FOUNDATION.ETC_DONAT_POLI IS '��Ÿ ��ġ ��α�';
COMMENT ON COLUMN HRA_FOUNDATION.MARRY_COUNT IS '��ȥ��';
COMMENT ON COLUMN HRA_FOUNDATION.FUNER_COUNT IS '��ʼ�';
COMMENT ON COLUMN HRA_FOUNDATION.HOUSE_MOVE_COUNT IS '�̻��';
COMMENT ON COLUMN HRA_FOUNDATION.PERSON_ANNU_AMT IS '���ο�������';
COMMENT ON COLUMN HRA_FOUNDATION.ANNU_BANK_AMT IS '��������';
COMMENT ON COLUMN HRA_FOUNDATION.RETR_ANNU_AMT IS '���� ��������';
COMMENT ON COLUMN HRA_FOUNDATION.INVES_AMT IS '�������� ����';
COMMENT ON COLUMN HRA_FOUNDATION.CREDIT_AMT IS '�ſ�ī�� �ݾ�';
COMMENT ON COLUMN HRA_FOUNDATION.ACADE_GIRO_AMT IS '�п� ���κ�';
COMMENT ON COLUMN HRA_FOUNDATION.CASH_AMT IS '���ݿ�����';
COMMENT ON COLUMN HRA_FOUNDATION.EMPL_STOCK_AMT IS '�츮��������';
COMMENT ON COLUMN HRA_FOUNDATION.HOUSE_DEBT_BEN_AMT IS '�������Ա����� ��ȯ�� ���װ���';
COMMENT ON COLUMN HRA_FOUNDATION.DESCRIPTION IS '���';
COMMENT ON COLUMN HRA_FOUNDATION.CREATION_DATE IS '��������';
COMMENT ON COLUMN HRA_FOUNDATION.CREATED_BY IS '������';
COMMENT ON COLUMN HRA_FOUNDATION.LAST_UPDATE_DATE IS '���� �����Ͻ�';
COMMENT ON COLUMN HRA_FOUNDATION.LAST_UPDATED_BY IS '���� ������';
COMMENT ON COLUMN HRA_FOUNDATION.HOUSE_APP_DEPOSIT_AMT IS '��Źû���������� ���Ծ� �ҵ����';
COMMENT ON COLUMN HRA_FOUNDATION.HOUSE_MONTHLY_AMT IS '���ҵ�ٷ��� �����ҵ����';
COMMENT ON COLUMN HRA_FOUNDATION.LOW_HOUSE_ADD_AMT IS '���ҵ�ٷ��� �����������Աݿ����ݻ�Ȳ�� �ҵ����';


--> �ε��� ����.                                                                                                                           
CREATE UNIQUE INDEX HRA_FOUNDATION_U1 ON HRA_FOUNDATION(YEAR_YYYY, PERSON_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;


--> ANALYZE TABLE/INDEX;
ANALYZE TABLE HRA_FOUNDATION COMPUTE STATISTICS;
ANALYZE INDEX HRA_FOUNDATION_U1 COMPUTE STATISTICS;

