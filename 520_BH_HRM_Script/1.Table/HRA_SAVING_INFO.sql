/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_SAVING_INFO
/* Description  : �������� ���� �ݾ� �� ���� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRA_SAVING_INFO
( SAVING_INFO_ID                  NUMBER        NOT NULL,
  YEAR_YYYY                       VARCHAR2(4)   NOT NULL,            
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  PERSON_ID                       NUMBER        NOT NULL,                 
  SAVING_TYPE                     VARCHAR2(10)  NOT NULL,
  BANK_CODE                       VARCHAR2(10)  NOT NULL,
  ACCOUNT_NUM                     VARCHAR2(50)  NOT NULL,
  SAVING_COUNT                    NUMBER        DEFAULT 0,
  SAVING_AMOUNT                   NUMBER        DEFAULT 0,
  SAVING_DED_AMOUNT               NUMBER        DEFAULT 0,
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
COMMENT ON TABLE HRA_SAVING_INFO IS '�������� ������� ����';
COMMENT ON COLUMN HRA_SAVING_INFO.SAVING_INFO_ID IS '������� ID';
COMMENT ON COLUMN HRA_SAVING_INFO.YEAR_YYYY IS '����⵵';
COMMENT ON COLUMN HRA_SAVING_INFO.PERSON_ID IS '�����ȣ';  
COMMENT ON COLUMN HRA_SAVING_INFO.SAVING_TYPE IS '��������';
COMMENT ON COLUMN HRA_SAVING_INFO.BANK_CODE IS '�����ڵ�';
COMMENT ON COLUMN HRA_SAVING_INFO.ACCOUNT_NUM IS '���¹�ȣ';
COMMENT ON COLUMN HRA_SAVING_INFO.SAVING_COUNT IS 'Ƚ��';
COMMENT ON COLUMN HRA_SAVING_INFO.SAVING_AMOUNT IS '�ݾ�';
COMMENT ON COLUMN HRA_SAVING_INFO.SAVING_DED_AMOUNT IS '�����ݾ�';
COMMENT ON COLUMN HRA_SAVING_INFO.DESCRIPTION IS '���';
COMMENT ON COLUMN HRA_SAVING_INFO.CREATION_DATE IS '��������';
COMMENT ON COLUMN HRA_SAVING_INFO.CREATED_BY IS '������';
COMMENT ON COLUMN HRA_SAVING_INFO.LAST_UPDATE_DATE IS '���� �����Ͻ�';
COMMENT ON COLUMN HRA_SAVING_INFO.LAST_UPDATED_BY IS '���� ������';

--> �ε��� ����.
CREATE UNIQUE INDEX HRA_SAVING_INFO_U1 ON HRA_SAVING_INFO(SAVING_INFO_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRA_SAVING_INFO_U2 ON HRA_SAVING_INFO(YEAR_YYYY, SOB_ID, ORG_ID, PERSON_ID, SAVING_TYPE, BANK_CODE, ACCOUNT_NUM) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRA_SAVING_INFO_N1 ON HRA_SAVING_INFO(YEAR_YYYY, SOB_ID, ORG_ID, PERSON_ID) TABLESPACE FCM_TS_IDX;

--> ANALYZE TABLE/INDEX;
ANALYZE TABLE HRA_SAVING_INFO COMPUTE STATISTICS;
ANALYZE INDEX HRA_SAVING_INFO_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRA_SAVING_INFO_U2 COMPUTE STATISTICS;
ANALYZE INDEX HRA_SAVING_INFO_N1 COMPUTE STATISTICS;
