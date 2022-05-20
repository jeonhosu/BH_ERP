/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRW_EARNER_MASTER
/* Description  : �ҵ��� ������.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRW_EARNER_MASTER              
( EARNER_ID                       NUMBER          NOT NULL,
  EARNER_TYPE                     VARCHAR2(2)     NOT NULL,
  EARNER_NUM                      VARCHAR2(100)   NOT NULL, 
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  NAME                            VARCHAR2(100)   NOT NULL,
  CORP_ID                         NUMBER          NOT NULL,
  DEPT_ID                         NUMBER          ,
  FLOOR_ID                        NUMBER          ,
  REPRE_NUM                       VARCHAR2(30)    ,
  BUSINESS_TYPE                   VARCHAR2(10)    , 
  COMPANY_NAME                    VARCHAR2(200)   ,
  TAX_REG_NO                      VARCHAR2(20)    ,
  NATIONALITY_TYPE                VARCHAR2(2)     ,
  NATION_ID                       NUMBER          ,
  BUSINESS_CODE                   VARCHAR2(10)    , 
  YEAR_ADJUST_YN                  VARCHAR2(2)     ,
  INCOME_DATE_FR                  DATE            ,
  INCOME_DATE_TO                  DATE            ,
  BANK_ID                         NUMBER          ,
  ACCOUNT_NUM                     VARCHAR2(30)    ,
  ACCOUNT_HOLDER                  VARCHAR2(50)    ,
  EMAIL                           VARCHAR2(150)   ,
  TEL_NUM                         VARCHAR2(30)    ,
  HP_NUM                          VARCHAR2(30)    ,
  ZIP_CODE                        VARCHAR2(20)    ,
  ADDRESS1                        VARCHAR2(150)   ,
  ADDRESS2                        VARCHAR2(150)   ,
  ACCOUNT_CONTROL_ID              NUMBER          ,
  SCH_EXP_REPAY_DED_YN            VARCHAR2(2)     ,
  SCH_EXP_REPAY_AMT               NUMBER          ,
  SUPPLY_AMT                      NUMBER          ,
  DESCRIPTION                     VARCHAR2(100)   ,
  ATTRIBUTE1                      VARCHAR2(100)   ,
  ATTRIBUTE2                      VARCHAR2(100)   ,
  ATTRIBUTE3                      VARCHAR2(100)   ,
  ATTRIBUTE4                      VARCHAR2(100)   ,
  ATTRIBUTE5                      VARCHAR2(100)   ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRW_EARNER_MASTER IS '�ҵ��� ����';
COMMENT ON COLUMN HRW_EARNER_MASTER.EARNER_ID IS '�ҵ��� ID';
COMMENT ON COLUMN HRW_EARNER_MASTER.EARNER_TYPE IS '�ҵ��� ����(10:�����ڻ���ҵ�, 15:�����ڱ�Ÿ�ҵ�,20-������ڻ���ҵ�,25:������ڱ�Ÿ�ҵ�)';
COMMENT ON COLUMN HRW_EARNER_MASTER.EARNER_NUM IS '�����ȣ';
COMMENT ON COLUMN HRW_EARNER_MASTER.NAME IS '����';
COMMENT ON COLUMN HRW_EARNER_MASTER.CORP_ID IS '��üID';
COMMENT ON COLUMN HRW_EARNER_MASTER.DEPT_ID IS '�μ� ID';
COMMENT ON COLUMN HRW_EARNER_MASTER.FLOOR_ID IS '�۾���ID';
COMMENT ON COLUMN HRW_EARNER_MASTER.REPRE_NUM IS '�ֹι�ȣ';
COMMENT ON COLUMN HRW_EARNER_MASTER.BUSINESS_TYPE IS '����ڱ���(����/����)';
COMMENT ON COLUMN HRW_EARNER_MASTER.COMPANY_NAME IS '��ȣ';
COMMENT ON COLUMN HRW_EARNER_MASTER.TAX_REG_NO IS '����ڹ�ȣ';
COMMENT ON COLUMN HRW_EARNER_MASTER.NATIONALITY_TYPE IS '���ܱ��α���';
COMMENT ON COLUMN HRW_EARNER_MASTER.NATION_ID IS '���� ID';
COMMENT ON COLUMN HRW_EARNER_MASTER.BUSINESS_CODE IS '�ҵ���(����)�ڵ�';
COMMENT ON COLUMN HRW_EARNER_MASTER.YEAR_ADJUST_YN IS '�������꿩��';
COMMENT ON COLUMN HRW_EARNER_MASTER.INCOME_DATE_FR IS '�ҵ�߻�������';
COMMENT ON COLUMN HRW_EARNER_MASTER.INCOME_DATE_TO IS '�ҵ�߻�������';
COMMENT ON COLUMN HRW_EARNER_MASTER.BANK_ID IS '���� ID';
COMMENT ON COLUMN HRW_EARNER_MASTER.ACCOUNT_NUM IS '���¹�ȣ';
COMMENT ON COLUMN HRW_EARNER_MASTER.ACCOUNT_HOLDER IS '������';
COMMENT ON COLUMN HRW_EARNER_MASTER.EMAIL IS '�̸��� �ּ�';
COMMENT ON COLUMN HRW_EARNER_MASTER.TEL_NUM IS '��ȭ��ȣ';
COMMENT ON COLUMN HRW_EARNER_MASTER.HP_NUM IS '�޴���ȭ';
COMMENT ON COLUMN HRW_EARNER_MASTER.ZIP_CODE IS '�����ȣ';
COMMENT ON COLUMN HRW_EARNER_MASTER.ADDRESS1 IS '�ּ�1';
COMMENT ON COLUMN HRW_EARNER_MASTER.ADDRESS2 IS '�ּ�2';
COMMENT ON COLUMN HRW_EARNER_MASTER.ACCOUNT_CONTROL_ID IS '�������� ID';
COMMENT ON COLUMN HRW_EARNER_MASTER.SCH_EXP_REPAY_DED_YN IS '���ڱݻ�ȯ�����ڿ���';
COMMENT ON COLUMN HRW_EARNER_MASTER.SCH_EXP_REPAY_AMT IS '���ڱݻ�ȯ�����ݾ�';
COMMENT ON COLUMN HRW_EARNER_MASTER.SUPPLY_AMT IS '���޾�';
COMMENT ON COLUMN HRW_EARNER_MASTER.DESCRIPTION IS '���';
COMMENT ON COLUMN HRW_EARNER_MASTER.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRW_EARNER_MASTER.CREATED_BY IS '������';
COMMENT ON COLUMN HRW_EARNER_MASTER.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRW_EARNER_MASTER.LAST_UPDATED_BY IS '����������';

-- PK.
ALTER TABLE HRW_EARNER_MASTER ADD CONSTRAINTS HRW_EARNER_MASTER_PK PRIMARY KEY(EARNER_ID);
-- CREATE INDEX.
CREATE UNIQUE INDEX HRW_EARNER_MASTER_U1 ON HRW_EARNER_MASTER(EARNER_TYPE, EARNER_NUM, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRW_EARNER_MASTER_N1 ON HRW_EARNER_MASTER(EARNER_NUM, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE HRW_EARNER_MASTER_S1;

-- ANALYZE.
ANALYZE TABLE HRW_EARNER_MASTER COMPUTE STATISTICS;
ANALYZE INDEX HRW_EARNER_MASTER_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRW_EARNER_MASTER_N1 COMPUTE STATISTICS;

