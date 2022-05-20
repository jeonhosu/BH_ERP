/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_MEDICAL_INFO
/* Description  : �������� �Ƿ�񳻿�.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRA_MEDICAL_INFO
(YEAR_YYYY                                                    VARCHAR2(4) NOT NULL,
  PERSON_ID                                                   NUMBER NOT NULL,
  SEQ_NUM                                                     NUMBER NOT NULL,
  RELATION_CODE	                                          VARCHAR2(2) NOT NULL,
  FAMILY_NAME	                                              VARCHAR2(50),
  REPRE_NUM	                                                VARCHAR2(14),
  DEFORM_YN	                                                VARCHAR2(2),
  OLD_YN	                                                      VARCHAR2(2),
  EVIDENCE_CODE	                                          VARCHAR2(2),
  COMP_NUM	                                                VARCHAR2(50),
  COMP_NAME	                                                VARCHAR2(100),
  CREDIT_COUNT	                                          NUMBER DEFAULT 0,
  CREDIT_AMT	                                              NUMBER DEFAULT 0,
  ETC_COUNT	                                                NUMBER DEFAULT 0,	
  ETC_AMT	                                                    NUMBER DEFAULT 0,	
  DESCRIPTION                                             VARCHAR2(100),
  ATTRIBUTE1                                                  VARCHAR2(100),
  ATTRIBUTE2                                                  VARCHAR2(100),
  ATTRIBUTE3                                                  VARCHAR2(100),
  ATTRIBUTE4                                                  VARCHAR2(100),
  ATTRIBUTE5                                                  VARCHAR2(100),
  CREATION_DATE                                           DATE NOT NULL,
  CREATED_BY                                                NUMBER NOT NULL,
  LAST_UPDATE_DATE                                    DATE NOT NULL,
  LAST_UPDATED_BY                                       NUMBER NOT NULL
) 
  TABLESPACE FCM_TS_DATA;

--> COMMET ���� 
COMMENT ON COLUMN HRA_MEDICAL_INFO.YEAR_YYYY IS '����⵵';
COMMENT ON COLUMN HRA_MEDICAL_INFO.PERSON_ID IS '�����ȣ';  
COMMENT ON COLUMN HRA_MEDICAL_INFO.SEQ_NUM IS '�Ϸù�ȣ';
COMMENT ON COLUMN HRA_MEDICAL_INFO.RELATION_CODE IS '�����ڵ�';
COMMENT ON COLUMN HRA_MEDICAL_INFO.FAMILY_NAME IS '����';
COMMENT ON COLUMN HRA_MEDICAL_INFO.REPRE_NUM IS '�ֹι�ȣ';
COMMENT ON COLUMN HRA_MEDICAL_INFO.DEFORM_YN IS '��ֿ���';
COMMENT ON COLUMN HRA_MEDICAL_INFO.OLD_YN IS '��ο���';
COMMENT ON COLUMN HRA_MEDICAL_INFO.EVIDENCE_CODE IS '�����ڵ�';
COMMENT ON COLUMN HRA_MEDICAL_INFO.COMP_NUM IS '����ڵ�Ϲ�ȣ';
COMMENT ON COLUMN HRA_MEDICAL_INFO.COMP_NAME IS '����ڸ�';
COMMENT ON COLUMN HRA_MEDICAL_INFO.CREDIT_COUNT IS '�ſ�ī�� Ƚ��';
COMMENT ON COLUMN HRA_MEDICAL_INFO.CREDIT_AMT IS '�ſ�ī�� �ݾ�';
COMMENT ON COLUMN HRA_MEDICAL_INFO.ETC_COUNT IS '��Ÿ Ƚ��';
COMMENT ON COLUMN HRA_MEDICAL_INFO.ETC_AMT IS '��Ÿ �ݾ�';
COMMENT ON COLUMN HRA_MEDICAL_INFO.DESCRIPTION IS '���';
COMMENT ON COLUMN HRA_MEDICAL_INFO.CREATION_DATE IS '��������';
COMMENT ON COLUMN HRA_MEDICAL_INFO.CREATED_BY IS '������';
COMMENT ON COLUMN HRA_MEDICAL_INFO.LAST_UPDATE_DATE IS '���� �����Ͻ�';
COMMENT ON COLUMN HRA_MEDICAL_INFO.LAST_UPDATED_BY IS '���� ������';


--> �ε��� ����.                                                                                                                           
CREATE UNIQUE INDEX HRA_MEDICAL_INFO_U1 ON HRA_MEDICAL_INFO(YEAR_YYYY, PERSON_ID, SEQ_NUM) TABLESPACE FCM_TS_IDX;


--> ANALYZE TABLE/INDEX;
ANALYZE TABLE HRA_MEDICAL_INFO COMPUTE STATISTICS;
ANALYZE INDEX HRA_MEDICAL_INFO_U1 COMPUTE STATISTICS;

