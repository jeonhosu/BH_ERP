/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_DONATION_INFO
/* Description  : �������� ��α� ����..
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRA_DONATION_INFO
( YEAR_YYYY                       VARCHAR2(4)   NOT NULL,            
  PERSON_ID                       NUMBER        NOT NULL,                 
  SEQ_NUM                         NUMBER        NOT NULL,                 
  RELATION_CODE                   VARCHAR2(2)   NOT NULL,            
  FAMILY_NAME                     VARCHAR2(50)  ,                    
  REPRE_NUM                       VARCHAR2(14)  ,                     
  DONA_DATE                       DATE          ,                            
  DONA_TYPE                       VARCHAR2(2)   ,                     
  SUB_DESCRIPTION                 VARCHAR2(100) ,                   
  COMP_NUM                        VARCHAR2(15)  ,                    
  COMP_NAME                       VARCHAR2(100) ,                   
  DONA_AMT                        NUMBER        ,                          
  DONA_BILL_NUM                   NUMBER        ,                          
  DESCRIPTION                     VARCHAR2(100) ,                   
  ATTRIBUTE1                      VARCHAR2(100) ,                   
  ATTRIBUTE2                      VARCHAR2(100) ,                   
  ATTRIBUTE3                      VARCHAR2(100) ,                   
  ATTRIBUTE4                      VARCHAR2(100) ,                   
  ATTRIBUTE5                      VARCHAR2(100) ,                   
  CREATION_DATE                   DATE          NOT NULL,                   
  CREATED_BY                      NUMBER        NOT NULL,                 
  LAST_UPDATE_DATE                DATE          NOT NULL,                   
  LAST_UPDATED_BY                 NUMBER        NOT NULL
) TABLESPACE FCM_TS_DATA;

--> COMMET ���� 
COMMENT ON COLUMN HRA_DONATION_INFO.YEAR_YYYY IS '����⵵';
COMMENT ON COLUMN HRA_DONATION_INFO.PERSON_ID IS '�����ȣ';  
COMMENT ON COLUMN HRA_DONATION_INFO.SEQ_NUM IS '�Ϸù�ȣ';
COMMENT ON COLUMN HRA_DONATION_INFO.RELATION_CODE IS '�����ڵ�';
COMMENT ON COLUMN HRA_DONATION_INFO.FAMILY_NAME IS '����';
COMMENT ON COLUMN HRA_DONATION_INFO.REPRE_NUM IS '�ֹι�ȣ';
COMMENT ON COLUMN HRA_DONATION_INFO.DONA_DATE IS '�������';
COMMENT ON COLUMN HRA_DONATION_INFO.DONA_TYPE IS '��α� ����';
COMMENT ON COLUMN HRA_DONATION_INFO.SUB_DESCRIPTION IS '����';
COMMENT ON COLUMN HRA_DONATION_INFO.COMP_NUM IS '����ڵ�Ϲ�ȣ';
COMMENT ON COLUMN HRA_DONATION_INFO.COMP_NAME IS '����ڸ�';
COMMENT ON COLUMN HRA_DONATION_INFO.DONA_AMT IS '��α�';
COMMENT ON COLUMN HRA_DONATION_INFO.DONA_BILL_NUM IS '��ο����� �Ϸù�ȣ';
COMMENT ON COLUMN HRA_DONATION_INFO.DESCRIPTION IS '���';
COMMENT ON COLUMN HRA_DONATION_INFO.CREATION_DATE IS '��������';
COMMENT ON COLUMN HRA_DONATION_INFO.CREATED_BY IS '������';
COMMENT ON COLUMN HRA_DONATION_INFO.LAST_UPDATE_DATE IS '���� �����Ͻ�';
COMMENT ON COLUMN HRA_DONATION_INFO.LAST_UPDATED_BY IS '���� ������';

--> �ε��� ����.                                                                                                                           
CREATE UNIQUE INDEX HRA_DONATION_INFO_U1 ON HRA_DONATION_INFO(YEAR_YYYY, PERSON_ID, SEQ_NUM) TABLESPACE FCM_TS_IDX;

--> ANALYZE TABLE/INDEX;
ANALYZE TABLE HRA_DONATION_INFO COMPUTE STATISTICS;
ANALYZE INDEX HRA_DONATION_INFO_U1 COMPUTE STATISTICS;
