/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_PREVIOUS_WORK
/* Description  : �������� ���ٹ��� �ڷ�.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRA_PREVIOUS_WORK
( YEAR_YYYY                           VARCHAR2(4) NOT NULL,                  
  SOB_ID                              NUMBER NOT NULL,                       
  ORG_ID                              NUMBER NOT NULL,			                 
  PERSON_ID                           NUMBER NOT NULL,		                   
  SEQ_NUM                             NUMBER NOT NULL,		                   
  COMPANY_NAME	                      VARCHAR2(100) NOT NULL,                
  COMPANY_NUM	                        VARCHAR2(20) NOT NULL,                 
  JOIN_DATE	                          DATE,								                   
  RETR_DATE	                          DATE,								                   
  LONG_YYYY	                          NUMBER,							                   
  LONG_MONTH	                        NUMBER,							                   
  PAY_TOTAL_AMT	                      NUMBER,							                   
  BONUS_TOTAL_AMT	                    NUMBER,							                   
  ADD_BONUS_AMT	                      NUMBER,							                   
  STOCK_BENE_AMT	                    NUMBER,							                   
  ANNU_INSUR_AMT	                    NUMBER,							                   
  MEDIC_INSUR_AMT	                    NUMBER,							                   
  HIRE_INSUR_AMT	                    NUMBER,							                   
  SAVE_TAX_DEDAMT	                    NUMBER,							                   
  IN_TAX_AMT	                        NUMBER,							                   
  LOCAL_TAX_AMT	                      NUMBER,							                   
  SP_TAX_AMT	                        NUMBER,							                   
  GLORY_AMT	                          NUMBER,							                   
  ETC_AMT	                            NUMBER,							                   
  GROUP_INSUR_AMT	                    NUMBER,							                   
  SUPP_TOTAL_AMT	                    NUMBER,							                   
  DESCRIPTION                         VARCHAR2(100),			                   
  ATTRIBUTE1                          VARCHAR2(100),			                   
  ATTRIBUTE2                          VARCHAR2(100),			                   
  ATTRIBUTE3                          VARCHAR2(100),			                   
  ATTRIBUTE4                          VARCHAR2(100),			                   
  ATTRIBUTE5                          VARCHAR2(100),                         
  CREATION_DATE                       DATE NOT NULL,			                   
  CREATED_BY                          NUMBER NOT NULL,		                   
  LAST_UPDATE_DATE                    DATE NOT NULL,			                   
  LAST_UPDATED_BY                     NUMBER NOT NULL,		                   
  NT_SCH_EDU_AMT	                    NUMBER,							                   
  NT_MEMBER_AMT	                      NUMBER,							                   
  NT_GUARD_AMT	                      NUMBER,							                   
  NT_CHILD_AMT	                      NUMBER,							                   
  NT_HIGH_SCH_AMT	                    NUMBER,							                   
  NT_SPECIAL_AMT	                    NUMBER,							                   
  NT_RESEARCH_AMT	                    NUMBER,							                   
  NT_COMPANY_AMT	                    NUMBER,							                   
  NT_COVER_AMT	                      NUMBER,							                   
  NT_WILD_AMT	                        NUMBER,							                   
  NT_DISASTER_AMT	                    NUMBER,							                   
  NT_OUTSIDE_GOVER_AMT	              NUMBER,							                   
  NT_OUTSIDE_ARMY_AMT	                NUMBER,							                   
  NT_OUTSIDE_WORK1	                  NUMBER,							                   
  NT_OUTSIDE_WORK2	                  NUMBER,							                   
  NT_STOCK_BENE_AMT	                  NUMBER,                                 
  NT_FORE_ENG_AMT                     NUMBER,                                 
  NT_EMPL_STOCK_AMT                   NUMBER,                                 
  NT_EMPL_BENE_AMT1	                  NUMBER,							                   
  NT_EMPL_BENE_AMT2	                  NUMBER,							                   
  NT_HOUSE_SUBSIDY_AMT	              NUMBER,							                   
  NT_SEA_RESOURCE_AMT	                NUMBER,							                   
  NT_ETC_AMT	                        NUMBER,							                   
  NT_FOREIGNER_AMT	                  NUMBER,							                   
  NT_BIRTH_AMT	                      NUMBER,							                   
  NT_OT_AMT	                          NUMBER,							                   
  NT_OUTSIDE_AMT	                    NUMBER		
) 
  TABLESPACE FCM_TS_DATA;

--> COMMET ���� 
COMMENT ON COLUMN HRA_PREVIOUS_WORK.YEAR_YYYY IS '����⵵';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.PERSON_ID IS '�����ȣ';  
COMMENT ON COLUMN HRA_PREVIOUS_WORK.SEQ_NUM IS '���ٹ��� �Ϸù�ȣ';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.COMPANY_NAME IS '��ü��';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.COMPANY_NUM IS '����ڹ�ȣ';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.JOIN_DATE IS '�Ի�����';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.RETR_DATE IS '�������';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.LONG_YYYY IS '�ټӳ��';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.LONG_MONTH IS '�ټӿ���';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.PAY_TOTAL_AMT IS '�ѱ޿���';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.BONUS_TOTAL_AMT IS '�ѻ󿩾�';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.ADD_BONUS_AMT IS '�����󿩾�';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.STOCK_BENE_AMT IS '�ֽĸż����ñ� �������';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.ANNU_INSUR_AMT IS '���ο���';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.MEDIC_INSUR_AMT IS '�ǰ������';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.HIRE_INSUR_AMT IS '��뺸���';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.SAVE_TAX_DEDAMT IS '���װ�����';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.IN_TAX_AMT IS '�ҵ漼';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.LOCAL_TAX_AMT IS '�ֹμ�';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.SP_TAX_AMT IS '��Ư��';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.DESCRIPTION IS '���';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.CREATION_DATE IS '��������';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.CREATED_BY IS '������';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.LAST_UPDATE_DATE IS '���� �����Ͻ�';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.LAST_UPDATED_BY IS '���� ������';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_SCH_EDU_AMT IS '�����-���ڱ�';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_MEMBER_AMT IS '�����-��������������';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_GUARD_AMT IS '�����-��ȣ/�¼�����';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_CHILD_AMT IS '�����-����/���ߵ�_��������Ȱ����';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_HIGH_SCH_AMT IS '�����-���_��������Ȱ����';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_SPECIAL_AMT IS '�����-Ư���������������';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_RESEARCH_AMT IS '�����-�������_��������Ȱ����';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_COMPANY_AMT IS '�����-���������';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_COVER_AMT IS '�����-�������';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_WILD_AMT IS '�����-��������';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_DISASTER_AMT IS '�����-���ذ��ñ�';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_OUTSIDE_GOVER_AMT IS '�����-�ܱ����ε� �ٹ���';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_OUTSIDE_ARMY_AMT IS '�����-�ܱ��ֵб��ε�';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_OUTSIDE_WORK1 IS '�����-���ܱٷ�(100����)';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_OUTSIDE_WORK2 IS '�����-���ܱٷ�(150����)';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_STOCK_BENE_AMT IS '�����-�ֽĸż����ñ�';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_FORE_ENG_AMT IS '�����-�ܱ��α����';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_EMPL_STOCK_AMT IS '�����-�츮�������չ���';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_EMPL_BENE_AMT1 IS '�����-�츮�������������(50%)';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_EMPL_BENE_AMT2 IS '�����-�츮�������������(75%);';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_HOUSE_SUBSIDY_AMT IS '�����-�����ڱݺ�����';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_SEA_RESOURCE_AMT IS '�����-���������ڿ�����';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_ETC_AMT IS '�����-��Ÿ';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_FOREIGNER_AMT IS '�����-�ܱ��αٷ���';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_BIRTH_AMT IS '�����-���/��������';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_OT_AMT IS '�����-�߰��ٷ�';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_OUTSIDE_AMT IS '�����-���ܼҵ�';

--> �ε��� ����.                                                                                                                           
CREATE UNIQUE INDEX HRA_PREVIOUS_WORK_U1 ON HRA_PREVIOUS_WORK(YEAR_YYYY, SOB_ID, ORG_ID, PERSON_ID, SEQ_NUM) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRA_PREVIOUS_WORK_N1 ON HRA_PREVIOUS_WORK(YEAR_YYYY, SOB_ID, ORG_ID, PERSON_ID) TABLESPACE FCM_TS_IDX;

--> ANALYZE TABLE/INDEX;
ANALYZE TABLE HRA_PREVIOUS_WORK COMPUTE STATISTICS;
ANALYZE INDEX HRA_PREVIOUS_WORK_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRA_PREVIOUS_WORK_N1 COMPUTE STATISTICS;
