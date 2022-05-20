/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_PAY_MASTER_HEADER
/* Description  : �޿������� HEADER ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRP_PAY_MASTER_HEADER              
( PAY_HEADER_ID                   NUMBER          NOT NULL,
  PERSON_ID	                      NUMBER          NOT NULL,
  CORP_ID                         NUMBER          NOT NULL,
  START_YYYYMM	                  VARCHAR2(7)     NOT NULL,
  END_YYYYMM	                    VARCHAR2(7)     DEFAULT '9999-12',
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  PRINT_TYPE	                    VARCHAR2(1)     NOT NULL,
  BANK_ID	                        NUMBER          ,
  BANK_ACCOUNTS	                  VARCHAR2(50)    ,
  PAY_TYPE                        VARCHAR2(2)     ,
  PAY_GRADE_ID	                  NUMBER          ,
  GRADE_STEP	                    NUMBER          ,
  CORP_CAR_YN	                    VARCHAR2(1)     DEFAULT 'N',
  PAY_PROVIDE_YN                  VARCHAR2(1)     DEFAULT 'Y',
  BONUS_PROVIDE_YN                VARCHAR2(1)     DEFAULT 'Y',
  YEAR_PROVIDE_YN                 VARCHAR2(1)     DEFUALT 'Y',
  HIRE_INSUR_YN	                  VARCHAR2(1)     DEFAULT 'Y',
  DED_FAMILY_COUNT	              NUMBER          DEFAULT 1,
  DED_CHILD_COUNT                 NUMBER          DEFAULT 0,
  LAST_YN                         VARCHAR2(1)     ,
  DESCRIPTION                     VARCHAR2(150)   ,
  ATTRIBUTE_A                     VARCHAR2(150)   ,
  ATTRIBUTE_B                     VARCHAR2(150)   ,
  ATTRIBUTE_C                     VARCHAR2(150)   ,
  ATTRIBUTE_D                     VARCHAR2(150)   ,
  ATTRIBUTE_E                     VARCHAR2(150)   ,
  ATTRIBUTE_1                     NUMBER          ,
  ATTRIBUTE_2                     NUMBER          ,
  ATTRIBUTE_3                     NUMBER          ,
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID IS '�޿������� ��� ID';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.CORP_ID IS '��üID';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.START_YYYYMM IS '���۳��';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.END_YYYYMM IS '������';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.PRINT_TYPE IS '�μ�Ÿ��';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.BANK_ID IS '���� ID';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.BANK_ACCOUNTS IS '���¹�ȣ';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.PAY_TYPE IS '�޿��� Ÿ��';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID IS '���� ID';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.GRADE_STEP IS 'ȣ��';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.CORP_CAR_YN IS 'ȸ���� ����';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.PAY_PROVIDE_YN IS '�޿� ����';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.BONUS_PROVIDE_YN IS '�󿩱� ����';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.YEAR_PROVIDE_YN IS '�������� ����';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.HIRE_INSUR_YN IS '��뺸�� ����';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.DED_FAMILY_COUNT IS '�ξ簡��(����)';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.DED_CHILD_COUNT IS '���ڳ����';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.LAST_YN IS '��������';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.DESCRIPTION IS '���';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.CREATED_BY IS '������';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRP_PAY_MASTER_HEADER.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
ALTER TABLE HRP_PAY_MASTER_HEADER ADD CONSTRAINT HRP_PAY_MASTER_HEADER_PK PRIMARY KEY (PERSON_ID, CORP_ID, START_YYYYMM, END_YYYYMM, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

CREATE UNIQUE INDEX HRP_PAY_MASTER_HEADER_U1 ON HRP_PAY_MASTER_HEADER(PAY_HEADER_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRP_PAY_MASTER_HEADER_S1;
CREATE SEQUENCE HRP_PAY_MASTER_HEADER_S1;

-- ANALYZE.
ANALYZE TABLE HRP_PAY_MASTER_HEADER COMPUTE STATISTICS;
ANALYZE INDEX HRP_PAY_MASTER_HEADER_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRP_PAY_MASTER_HEADER_U2 COMPUTE STATISTICS;
