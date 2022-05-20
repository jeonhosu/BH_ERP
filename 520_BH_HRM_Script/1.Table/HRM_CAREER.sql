/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_CAREER,
/* Description  : ��»��� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_CAREER              
(CAREER_ID                                        NUMBER NOT NULL,
  PERSON_ID                                        NUMBER NOT NULL,
  COMPANY_NAME	                            VARCHAR2(100) NOT NULL,
  DEPT_NAME	                                    VARCHAR2(100) ,
  POST_NAME	                                    VARCHAR2(80),
  JOB_NAME	                                      VARCHAR2(80),
  START_DATE	                                  DATE,	
  END_DATE	                                      DATE,
  CAREER_START_DATE	                    DATE,	
  CAREER_END_DATE	                        DATE,
  CAREER_YEAR_COUNT	                    NUMBER,	
  RETIRE_DESCRIPTION                     VARCHAR2(100),
  ZIP_CODE	                                      VARCHAR2(30),
  ADDR1	                                            VARCHAR2(150),
  ADDR2	                                            VARCHAR2(150),
  DESCRIPTION                               VARCHAR2(100),
  ATTRIBUTE1                                    VARCHAR2(100),
  ATTRIBUTE2                                    VARCHAR2(100),
  ATTRIBUTE3                                    VARCHAR2(100),
  ATTRIBUTE4                                    VARCHAR2(100),
  ATTRIBUTE5                                    VARCHAR2(100),
  CREATION_DATE                             DATE NOT NULL,
  CREATED_BY                                  NUMBER NOT NULL,
  LAST_UPDATE_DATE                       DATE NOT NULL,
  LAST_UPDATED_BY                         NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_CAREER.CAREER_ID IS '������� ID';
COMMENT ON COLUMN HRM_CAREER.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRM_CAREER.COMPANY_NAME IS '��ü��';
COMMENT ON COLUMN HRM_CAREER.DEPT_NAME IS '�μ���';
COMMENT ON COLUMN HRM_CAREER.POST_NAME IS '������';
COMMENT ON COLUMN HRM_CAREER.JOB_NAME IS '������';
COMMENT ON COLUMN HRM_CAREER.START_DATE IS '�Ի�����';
COMMENT ON COLUMN HRM_CAREER.END_DATE IS '�������';
COMMENT ON COLUMN HRM_CAREER.CAREER_START_DATE IS '��� ���� �Ի�����';
COMMENT ON COLUMN HRM_CAREER.CAREER_END_DATE IS '��� ���� �������';
COMMENT ON COLUMN HRM_CAREER.CAREER_YEAR_COUNT IS '��� ���� ���';
COMMENT ON COLUMN HRM_CAREER.RETIRE_DESCRIPTION IS '������';
COMMENT ON COLUMN HRM_CAREER.ZIP_CODE IS '�����ȣ';
COMMENT ON COLUMN HRM_CAREER.ADDR1 IS '�ּ�1';
COMMENT ON COLUMN HRM_CAREER.ADDR2 IS '�ּ�2';
COMMENT ON COLUMN HRM_CAREER.DESCRIPTION IS '���';
COMMENT ON COLUMN HRM_CAREER.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRM_CAREER.CREATED_BY IS '������';
COMMENT ON COLUMN HRM_CAREER.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRM_CAREER.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_CAREER_U1 ON HRM_CAREER(CAREER_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRM_CAREER_U2 ON HRM_CAREER(PERSON_ID, COMPANY_NAME, START_DATE, END_DATE) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRM_CAREER_S1;
CREATE SEQUENCE HRM_CAREER_S1;

-- ANALYZE.
ANALYZE TABLE HRM_CAREER COMPUTE STATISTICS;
ANALYZE INDEX HRM_CAREER_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_CAREER_U2 COMPUTE STATISTICS;
