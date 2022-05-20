/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : HR
/* PROGRAM NAME : HRA_YEAR_ADJUSTMENT
/* DESCRIPTION  : �������� ����..
/*
/* REFERENCE BY :
/* PROGRAM HISTORY
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 07-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
CREATE TABLE HRA_YEAR_ADJUSTMENT
( CORP_ID                           NUMBER        NOT NULL,
  YEAR_YYYY                         VARCHAR2(4)   NOT NULL,
  PERSON_ID                         NUMBER        NOT NULL,
  SOB_ID                            NUMBER        NOT NULL,
  ORG_ID                            NUMBER        NOT NULL,
  SUBMIT_DATE                       DATE          NOT NULL,
  ADJUST_DATE_FR                    DATE          NOT NULL,
  ADJUST_DATE_TO                    DATE          NOT NULL,
  PAY_TYPE                          VARCHAR2(10)  NOT NULL,
  AVG_PAY_AMT                       NUMBER,
  NOW_PAY_TOT_AMT                   NUMBER,
  NOW_BONUS_TOT_AMT                 NUMBER,
  NOW_ADD_BONUS_AMT                 NUMBER,
  NOW_STOCK_BENE_AMT                NUMBER,               
  PRE_PAY_TOT_AMT                   NUMBER,               
  PRE_BONUS_TOT_AMT                 NUMBER,               
  PRE_ADD_BONUS_AMT                 NUMBER,               
  PRE_STOCK_BENE_AMT                NUMBER,               
  INCOME_OUTSIDE_AMT                NUMBER,               
  NONTAX_OUTSIDE_AMT                NUMBER,               
  NONTAX_OT_AMT                     NUMBER,               
  NONTAX_RESEA_AMT                  NUMBER,               
  NONTAX_ETC_AMT                    NUMBER,               
  INCOME_TOT_AMT                    NUMBER,               
  INCOME_DED_AMT                    NUMBER,               
  PER_DED_AMT                       NUMBER,               
  SPOUSE_DED_AMT                    NUMBER,               
  SUPP_DED_COUNT                    NUMBER,               
  SUPP_DED_AMT                      NUMBER,               
  OLD_DED_COUNT                     NUMBER(2),            
  OLD_DED_AMT                       NUMBER,               
  OLD_DED_COUNT1                    NUMBER(2),            
  OLD_DED_AMT1                      NUMBER,               
  DEFORM_DED_COUNT                  NUMBER(2),            
  DEFORM_DED_AMT                    NUMBER,               
  WOMAN_DED_AMT                     NUMBER,               
  CHILD_DED_COUNT                   NUMBER(2),            
  CHILD_DED_AMT                     NUMBER,               
  PER_ADD_DED_AMT                   NUMBER,               
  MANY_CHILD_DED_COUNT              NUMBER(2),            
  MANY_CHILD_DED_AMT                NUMBER,               
  ANNU_INSUR_AMT                    NUMBER,               
  NATI_ANNU_AMT                     NUMBER,               
  RETR_ANNU_AMT                     NUMBER,               
  MEDIC_INSUR_AMT                   NUMBER,               
  HIRE_INSUR_AMT                    NUMBER,               
  GUAR_INSUR_AMT                    NUMBER,               
  DEFORM_INSUR_AMT                  NUMBER,               
  MEDIC_AMT                         NUMBER,               
  EDUCATION_AMT                     NUMBER,               
  HOUSE_FUND_AMT                    NUMBER,               
  DONAT_AMT                         NUMBER,               
  MARRY_ETC_AMT                     NUMBER,               
  STAND_DED_AMT                     NUMBER,               
  SUBT_DED_AMT                      NUMBER,               
  PERS_ANNU_BANK_AMT                NUMBER,               
  ANNU_BANK_AMT                     NUMBER,               
  INVES_AMT                         NUMBER,               
  FORE_INCOME_AMT                   NUMBER,               
  CREDIT_AMT                        NUMBER,               
  EMPL_STOCK_AMT                    NUMBER,               
  TAX_STD_AMT                       NUMBER,               
  COMP_TAX_AMT                      NUMBER,               
  TAX_REDU_IN_LAW_AMT               NUMBER,               
  TAX_REDU_SP_LAW_AMT               NUMBER,               
  TAX_DED_INCOME_AMT                NUMBER,               
  TAX_DED_TAXGROUP_AMT              NUMBER,               
  TAX_DED_HOUSE_DEBT_AMT            NUMBER,               
  TAX_DED_LONG_STOCK_AMT            NUMBER,               
  TAX_DED_DONAT_POLI_AMT            NUMBER,               
  TAX_DED_OUTSIDE_PAY_AMT           NUMBER,               
  FIX_IN_TAX_AMT                    NUMBER,               
  FIX_LOCAL_TAX_AMT                 NUMBER,               
  FIX_SP_TAX_AMT                    NUMBER,               
  PRE_IN_TAX_AMT                    NUMBER,               
  PRE_LOCAL_TAX_AMT                 NUMBER,               
  PRE_SP_TAX_AMT                    NUMBER,               
  SUBT_IN_TAX_AMT                   NUMBER,               
  SUBT_LOCAL_TAX_AMT                NUMBER,               
  SUBT_SP_TAX_AMT                   NUMBER,               
  CREATION_DATE                     DATE          NOT NULL,                 
  CREATED_BY                        NUMBER        NOT NULL,               
  LAST_UPDATE_DATE                  DATE          NOT NULL,                 
  LAST_UPDATED_BY                   NUMBER        NOT NULL,               
  TRANS_YN                          VARCHAR2(2)   DEFAULT 'N',          
  TRANS_PAY_YYYYMM                  VARCHAR2(7),
  TRANS_WAGE_TYPE                   VARCHAR2(10),
  TRANS_DATE                        DATE,                 
  TRANS_PERSON_ID                   NUMBER,               
  NONTAX_BIRTH_AMT                  NUMBER,               
  NONTAX_FOREIGNER_AMT              NUMBER,               
  BIRTH_DED_COUNT                   NUMBER,               
  BIRTH_DED_AMT                     NUMBER,               
  HOUSE_INTER_AMT                   NUMBER,               
  LONG_HOUSE_PROF_AMT               NUMBER,               
  HOUSE_SAVE_AMT                    NUMBER,               
  SMALL_CORPOR_DED_AMT              NUMBER,               
  LONG_STOCK_SAVING_AMT             NUMBER,               
  NONTAX_SCH_EDU_AMT                NUMBER,               
  NONTAX_MEMBER_AMT                 NUMBER,               
  NONTAX_GUARD_AMT                  NUMBER,               
  NONTAX_CHILD_AMT                  NUMBER,               
  NONTAX_HIGH_SCH_AMT               NUMBER,               
  NONTAX_SPECIAL_AMT                NUMBER,               
  NONTAX_RESEARCH_AMT               NUMBER,               
  NONTAX_COMPANY_AMT                NUMBER,               
  NONTAX_COVER_AMT                  NUMBER,               
  NONTAX_WILD_AMT                   NUMBER,               
  NONTAX_DISASTER_AMT               NUMBER,               
  NONTAX_OUTS_GOVER_AMT             NUMBER,               
  NONTAX_OUTS_ARMY_AMT              NUMBER,               
  NONTAX_OUTS_WORK_1                NUMBER,               
  NONTAX_OUTS_WORK_2                NUMBER,               
  NONTAX_STOCK_BENE_AMT             NUMBER,               
  NONTAX_FOR_ENG_AMT                NUMBER,               
  NONTAX_EMPL_STOCK_AMT             NUMBER,               
  NONTAX_EMPL_BENE_AMT_1            NUMBER,               
  NONTAX_EMPL_BENE_AMT_2            NUMBER,               
  NONTAX_HOUSE_SUBSIDY_AMT          NUMBER,               
  NONTAX_SEA_RESOURCE_AMT           NUMBER,               
  HIRE_KEEP_EMPLOY_AMT              NUMBER,               
  HOUSE_APP_DEPOSIT_AMT             NUMBER,               
  HOUSE_MONTHLY_AMT        					NUMBER,               
  DONAT_DED_ALL            					NUMBER,               
  DONAT_DED_50             					NUMBER,               
  DONAT_DED_30             					NUMBER,               
  DONAT_DED_RELIGION_10    					NUMBER,               
  DONAT_DED_10             					NUMBER,               
  DONAT_NEXT_ALL           					NUMBER,               
  DONAT_NEXT_50            					NUMBER,               
  DONAT_NEXT_30            					NUMBER,               
  DONAT_NEXT_RELIGION_10   					NUMBER,               
  DONAT_NEXT_10            					NUMBER  
) TABLESPACE FCM_TS_DATA;

--> COMMET ���� 
COMMENT ON TABLE HRA_YEAR_ADJUSTMENT IS '�������� ����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.CORP_ID IS '��üID';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.YEAR_YYYY IS '����⵵';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE IS '��������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.ADJUST_DATE_FR IS '���� ��������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.ADJUST_DATE_TO IS '���� ��������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.PAY_TYPE IS '�޿��ڵ�(1.����, 2.�ϱ�, 3.����, 4.�ñ�)';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.AVG_PAY_AMT IS '����ձ޿�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NOW_PAY_TOT_AMT IS '��-�޿��հ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NOW_BONUS_TOT_AMT IS '��-���հ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NOW_ADD_BONUS_AMT IS '��-�������հ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NOW_STOCK_BENE_AMT IS '��-�ֽĸż����ñ��������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.PRE_PAY_TOT_AMT IS '����-�޿��հ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.PRE_BONUS_TOT_AMT IS '����-���հ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.PRE_ADD_BONUS_AMT IS '����-�������հ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.PRE_STOCK_BENE_AMT IS '����-�ֽĸż����ñ��������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.INCOME_OUTSIDE_AMT IS '���� ���ܼҵ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_OUTSIDE_AMT IS '����� ���ܼҵ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_OT_AMT IS '����� �߰��ٷ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_RESEA_AMT IS '����� ����Ȱ����(2009�� ����)';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_ETC_AMT IS '����� ��Ÿ';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.INCOME_TOT_AMT IS '�ѱٷμҵ��հ�-����������� �ݾ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.INCOME_DED_AMT IS '�ٷμҵ����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.PER_DED_AMT IS '���� ����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.SPOUSE_DED_AMT IS '����� ����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.SUPP_DED_COUNT IS '�ξ簡����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.SUPP_DED_AMT IS '�ξ簡�� �ݾ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.OLD_DED_COUNT IS '��ο�� 65�� �̻� �ο���';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.OLD_DED_AMT IS '��ο�� 65�� �̻� �ݾ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.OLD_DED_COUNT1 IS '��ο�� 70�� �̻� �ο���';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.OLD_DED_AMT1 IS '��ο�� 70�� �̻� �ݾ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.DEFORM_DED_COUNT IS '����μ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.DEFORM_DED_AMT IS '����� �ݾ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.WOMAN_DED_AMT IS '�γ༼�� �ݾ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.CHILD_DED_COUNT IS '�ڳ���� �ο���';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.CHILD_DED_AMT IS '�ڳ������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.PER_ADD_DED_AMT IS '�Ҽ������߰�����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.MANY_CHILD_DED_COUNT IS '���ڳ� ���� �ο���';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.MANY_CHILD_DED_AMT IS '���ڳ� ���� �ݾ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.ANNU_INSUR_AMT IS '�����(������, ���ο���..��)';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NATI_ANNU_AMT IS '���ο���';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.RETR_ANNU_AMT IS '��������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.MEDIC_INSUR_AMT IS '�ǰ������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.HIRE_INSUR_AMT IS '��뺸���';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.GUAR_INSUR_AMT IS '���庸���';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.DEFORM_INSUR_AMT IS '��ֺ����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.MEDIC_AMT IS '�Ƿ��';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.EDUCATION_AMT IS '������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.HOUSE_FUND_AMT IS '�����ڱ�(�����������Աݻ�ȯ�� + ��������������Ա� + ���ø��������)';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.DONAT_AMT IS '��α�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.MARRY_ETC_AMT IS 'ȥ������̻��';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.STAND_DED_AMT IS 'ǥ�ذ���';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.SUBT_DED_AMT IS '�����ҵ������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.PERS_ANNU_BANK_AMT IS '���ο�������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.ANNU_BANK_AMT IS '��������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.INVES_AMT IS '������������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.FORE_INCOME_AMT IS '�ܱ��ٷ��ڼҵ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.CREDIT_AMT IS '�ſ���������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.EMPL_STOCK_AMT IS '�츮������������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.TAX_STD_AMT IS '���ռ��� ����ǥ��';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.COMP_TAX_AMT IS '���⼼��';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.TAX_REDU_IN_LAW_AMT IS '����-�ҵ漼��';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.TAX_REDU_SP_LAW_AMT IS '����-����Ư�����ѹ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.TAX_DED_INCOME_AMT IS '����-�ٷμҵ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.TAX_DED_TAXGROUP_AMT IS '����-��������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.TAX_DED_HOUSE_DEBT_AMT IS '����-�������Ա�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.TAX_DED_LONG_STOCK_AMT IS '����-�����������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.TAX_DED_DONAT_POLI_AMT IS '����-��ġ��α�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.TAX_DED_OUTSIDE_PAY_AMT IS '����-�ܱ�����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.FIX_IN_TAX_AMT IS '��������-�ҵ漼';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.FIX_LOCAL_TAX_AMT IS '��������-�ֹμ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.FIX_SP_TAX_AMT IS '��������-��Ư��';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.PRE_IN_TAX_AMT IS '�ⳳ��-�ҵ漼';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.PRE_LOCAL_TAX_AMT IS '�ⳳ��-�ֹμ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.PRE_SP_TAX_AMT IS '�ⳳ��-��Ư��';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.SUBT_IN_TAX_AMT IS '����-�ҵ漼';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.SUBT_LOCAL_TAX_AMT IS '����-�ֹμ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.SUBT_SP_TAX_AMT IS '����-��Ư��';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.TRANS_YN IS '���۱���';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.TRANS_PAY_YYYYMM IS '���۱޿����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.TRANS_WAGE_TYPE IS '���۱޻� ����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.TRANS_DATE IS '�޿���������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.TRANS_PERSON_ID IS '�޿�������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_BIRTH_AMT IS '����� ���/��������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_FOREIGNER_AMT IS '����� �ܱ��� �ٷ���';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.BIRTH_DED_COUNT IS '���/�Ծ��ڼ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.BIRTH_DED_AMT IS '���/�Ծ��� �����ݾ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.HOUSE_INTER_AMT IS '�����������Աݿ����ݻ�ȯ��';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.LONG_HOUSE_PROF_AMT IS '�����å�������Ա����ڻ�ȯ��';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.HOUSE_SAVE_AMT IS '���ø������������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.SMALL_CORPOR_DED_AMT IS '�ұ��/�һ���ΰ����α� �ҵ������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.LONG_STOCK_SAVING_AMT IS '����ֽ�������ҵ����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_SCH_EDU_AMT IS '�����-���ڱ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_MEMBER_AMT IS '�����-��������������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_GUARD_AMT IS '�����-��ȣ/�¼�����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_CHILD_AMT IS '�����-����/���ߵ�_��������/Ȱ����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_HIGH_SCH_AMT IS '�����-����_��������/Ȱ����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_SPECIAL_AMT IS '�����-Ư���������������_��������/Ȱ����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_RESEARCH_AMT IS '�����-�������_��������/Ȱ����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_COMPANY_AMT IS '�����-���������_��������/Ȱ����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_COVER_AMT IS '�����-�������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_WILD_AMT IS '�����-��������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_DISASTER_AMT IS '�����-���ذ��ñ޿�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_OUTS_GOVER_AMT IS '�����-�ܱ����ε�ٹ���';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_OUTS_ARMY_AMT IS '�����-�ܱ��ֵб��ε�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_OUTS_WORK_1 IS '�����-���ܱٷ�(100����)';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_OUTS_WORK_2 IS '�����-���ܱٷ�(150����)';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_STOCK_BENE_AMT IS '�����-�ֽĸż����ñ�';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_FOR_ENG_AMT IS '�����-�ܱ��α����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_EMPL_STOCK_AMT IS '�����-�츮�������չ���';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_EMPL_BENE_AMT_1 IS '�����-�츮�������������(50%)';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_EMPL_BENE_AMT_2 IS '�����-�츮�������������(75%)';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_HOUSE_SUBSIDY_AMT IS '�����-�����ڱݺ�����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.NONTAX_SEA_RESOURCE_AMT IS '�����-���������ڿ�����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.HIRE_KEEP_EMPLOY_AMT IS '��������߼ұ���ٷ��ڼҵ����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.HOUSE_APP_DEPOSIT_AMT IS '����û���������� ���Ծ� �ҵ����';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.HOUSE_MONTHLY_AMT IS '�����ҵ������';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.DONAT_DED_ALL IS '��α����װ�����(������α�)';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.DONAT_DED_50 IS '��α�50%�ҵ������(Ư�ʱ�α�)';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.DONAT_DED_30 IS '��α�30%�ҵ������(�츮����)';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.DONAT_DED_RELIGION_10 IS '��α�10%�ҵ������(������ü������α�)';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.DONAT_DED_10 IS '��α�10%�ҵ������(��������ü������α�)';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.DONAT_NEXT_ALL IS '��α�����_�̿���(������α�)';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.DONAT_NEXT_50 IS '��α�50%�ҵ�_�̿���(Ư�ʱ�α�)';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.DONAT_NEXT_30 IS '��α�30%�ҵ�_�̿���(�츮����)';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.DONAT_NEXT_RELIGION_10 IS '��α�10%�ҵ�_�̿���(������ü������α�)';
COMMENT ON COLUMN HRA_YEAR_ADJUSTMENT.DONAT_NEXT_10 IS '��α�10%�ҵ�_�̿���(��������ü������α�)';

--> �ε��� ����.                                                                                                                           
CREATE UNIQUE INDEX HRA_YEAR_ADJUSTMENT_U1 ON HRA_YEAR_ADJUSTMENT(CORP_ID, YEAR_YYYY, PERSON_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRA_YEAR_ADJUSTMENT_N1 ON HRA_YEAR_ADJUSTMENT(YEAR_YYYY, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

--> ANALYZE TABLE/INDEX;
ANALYZE TABLE HRA_YEAR_ADJUSTMENT COMPUTE STATISTICS;
ANALYZE INDEX HRA_YEAR_ADJUSTMENT_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRA_YEAR_ADJUSTMENT_N1 COMPUTE STATISTICS;
