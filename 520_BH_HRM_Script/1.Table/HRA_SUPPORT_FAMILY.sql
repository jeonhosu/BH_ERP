/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_SUPPORT_FAMILY
/* Description  : �������� �ξ簡�� ����..
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRA_SUPPORT_FAMILY
( YEAR_YYYY                           VARCHAR2(4) NOT NULL,     
  SOB_ID                              NUMBER NOT NULL,
  ORG_ID                              NUMBER NOT NULL,
  PERSON_ID                           NUMBER NOT NULL,          
  REPRE_NUM	                          VARCHAR2(14) NOT NULL,    
  RELATION_CODE	                      VARCHAR2(2) NOT NULL,     
  FAMILY_NAME	                        VARCHAR2(50) NOT NULL,    
  BASE_YN	                            VARCHAR2(2) DEFAULT 'N',  
  INCOME_DED_YN	                      VARCHAR2(2) DEFAULT 'N',  
  SUPPORT_YN	                        VARCHAR2(2) DEFAULT 'N',  
  SPOUSE_YN	                          VARCHAR2(2) DEFAULT 'N',  
  OLD_YN	                            VARCHAR2(2) DEFAULT 'N',  
  OLD1_YN	                            VARCHAR2(2) DEFAULT 'N',  
  DEFORM_YN	                          VARCHAR2(2) DEFAULT 'N',  
  WOMAN_YN	                          VARCHAR2(2) DEFAULT 'N',  
  CHILD_YN	                          VARCHAR2(2) DEFAULT 'N',  
  BIRTH_YN	                          VARCHAR2(2) DEFAULT 'N',  
  INSURE_YN	                          VARCHAR2(2) DEFAULT 'N',  
  MEDICAL_YN	                        VARCHAR2(2) DEFAULT 'N',  
  EDUCATION_YN	                      VARCHAR2(2) DEFAULT 'N',  
  CREDIT_YN	                          VARCHAR2(2) DEFAULT 'N',  
  CASH_YN	                            VARCHAR2(2) DEFAULT 'N',  
  INSURE_AMT	                        NUMBER DEFAULT 0,         
  ETC_INSURE_AMT	                    NUMBER DEFAULT 0,	       
  DEFORM_INSURE_AMT                   NUMBER DEFAULT 0,         
  ETC_DEFORM_INSURE_AMT               NUMBER DEFAULT 0,	       
  MEDICAL_AMT	                        NUMBER DEFAULT 0,	       
  ETC_MEDICAL_AMT	                    NUMBER DEFAULT 0,         
  EDUCATION_TYPE	                    VARCHAR2(2),              
  EDUCATION_AMT	                      NUMBER DEFAULT 0,         
  ETC_EDUCATION_AMT	                  NUMBER DEFAULT 0,         
  CREDIT_AMT	                        NUMBER DEFAULT 0,         
  ETC_CREDIT_AMT	                    NUMBER DEFAULT 0,
  CHECK_CREDIT_AMT	                  NUMBER DEFAULT 0,         
  ETC_CHECK_CREDIT_AMT	              NUMBER DEFAULT 0,         
  CASH_AMT	                          NUMBER DEFAULT 0,         
  ETC_CASH_AMT	                      NUMBER DEFAULT 0,	       
  ACADE_GIRO_AMT	                    NUMBER DEFAULT 0,         
  ETC_ACADE_GIRO_AMT	                NUMBER DEFAULT 0,         
  DONAT_ALL	                          NUMBER DEFAULT 0,         
  ETC_DONAT_ALL	                      NUMBER DEFAULT 0,         
  DONAT_50P	                          NUMBER DEFAULT 0,         
  ETC_DONAT_50P	                      NUMBER DEFAULT 0,         
  DONAT_30P	                          NUMBER DEFAULT 0,         
  ETC_DONAT_30P	                      NUMBER DEFAULT 0,         
  DONAT_10P	                          NUMBER DEFAULT 0,         
  ETC_DONAT_10P	                      NUMBER DEFAULT 0,         
  DONAT_10P_RELIGION	                NUMBER DEFAULT 0,         
  ETC_DONAT_10P_RELIGION	            NUMBER DEFAULT 0,         
  DONAT_POLI	                        NUMBER DEFAULT 0,         
  ETC_DONAT_POLI	                    NUMBER DEFAULT 0,         
  DESCRIPTION                         VARCHAR2(100),            
  ATTRIBUTE1                          VARCHAR2(100),            
  ATTRIBUTE2                          VARCHAR2(100),            
  ATTRIBUTE3                          VARCHAR2(100),            
  ATTRIBUTE4                          VARCHAR2(100),            
  ATTRIBUTE5                          VARCHAR2(100),            
  CREATION_DATE                       DATE NOT NULL,            
  CREATED_BY                          NUMBER NOT NULL,          
  LAST_UPDATE_DATE                    DATE NOT NULL,            
  LAST_UPDATED_BY                     NUMBER NOT NULL 
) TABLESPACE FCM_TS_DATA;

--> COMMET ���� 
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.YEAR_YYYY IS '����⵵';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.PERSON_ID IS '�����ȣ';   
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.REPRE_NUM IS '�ξ簡�� �ֹι�ȣ';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.RELATION_CODE IS '�����ڵ�';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.FAMILY_NAME IS '����';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.BASE_YN IS '�⺻����';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.INCOME_DED_YN IS '�ҵ����';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.SUPPORT_YN IS '�ξ翩��';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.SPOUSE_YN IS '����ڰ���';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.OLD_YN IS '��ο�� ����(~69)';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.OLD1_YN IS '��ο�� ����(70~)';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.DEFORM_YN IS '��ֿ���';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.WOMAN_YN IS '�γ༼��';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.CHILD_YN IS '�ڳ����';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.BIRTH_YN IS '���/�Ծ����'; 
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.INSURE_YN IS '����� YN';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.MEDICAL_YN IS '�Ƿ�� YN';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.EDUCATION_YN IS '������ YN';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.CREDIT_YN IS '�ſ�ī�� YN';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.CASH_YN IS '���ݿ����� YN';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.INSURE_AMT IS '����û-�����';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.ETC_INSURE_AMT IS '��Ÿ-�����';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.DEFORM_INSURE_AMT IS '����û-��ֺ����';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.ETC_DEFORM_INSURE_AMT IS '��Ÿ-��ֺ����';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.MEDICAL_AMT IS '����û-�Ƿ��';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.ETC_MEDICAL_AMT IS '��Ÿ-�Ƿ��';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.EDUCATION_TYPE IS '�����񱸺�';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.EDUCATION_AMT IS '����û-������'; 
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.ETC_EDUCATION_AMT IS '��Ÿ������';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.CREDIT_AMT IS '����û-�ſ�ī��';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.ETC_CREDIT_AMT IS '��Ÿ-�ſ�ī��';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.CHECK_CREDIT_AMT IS '����û-����ī��';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.ETC_CHECK_CREDIT_AMT IS '��Ÿ-����ī��';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.CASH_AMT IS '����û-����';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.ETC_CASH_AMT IS '��Ÿ-����';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.ACADE_GIRO_AMT IS '����û-�п�����';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.ETC_ACADE_GIRO_AMT IS '��Ÿ-�п�����';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.DONAT_ALL IS '����û-��α� ����';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.ETC_DONAT_ALL IS '��Ÿ-��α� ����';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.DONAT_50P IS '����û-��α�(50%)';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.ETC_DONAT_50P IS '��Ÿ-��α�(50%)';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.DONAT_30P IS '����û-��α�(30%)';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.ETC_DONAT_30P IS '��Ÿ-��α�(30%)';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.DONAT_10P IS '����û-��α�(10%)';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.ETC_DONAT_10P IS '��Ÿ-��α�(10%)';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.DONAT_10P_RELIGION IS '����û-������α�';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.ETC_DONAT_POLI IS '��Ÿ-������α�';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.DONAT_POLI IS '����û-��ġ��α�';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.ETC_DONAT_10P_RELIGION IS '��Ÿ-��ġ��α�';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.DESCRIPTION IS '���';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.CREATION_DATE IS '��������';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.CREATED_BY IS '������';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.LAST_UPDATE_DATE IS '���� �����Ͻ�';
COMMENT ON COLUMN HRA_SUPPORT_FAMILY.LAST_UPDATED_BY IS '���� ������';

--> �ε��� ����.                                                                                                                           
CREATE UNIQUE INDEX HRA_SUPPORT_FAMILY_U1 ON HRA_SUPPORT_FAMILY(YEAR_YYYY, PERSON_ID, REPRE_NUM, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRA_SUPPORT_FAMILY_N1 ON HRA_SUPPORT_FAMILY(YEAR_YYYY, PERSON_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

--> ANALYZE TABLE/INDEX;
ANALYZE TABLE HRA_SUPPORT_FAMILY COMPUTE STATISTICS;
ANALYZE INDEX HRA_SUPPORT_FAMILY_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRA_SUPPORT_FAMILY_N1 COMPUTE STATISTICS;
