/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_MONTH_TOTAL
/* Description  : ������ ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_MONTH_TOTAL              
( MONTH_TOTAL_ID                                NUMBER NOT NULL,
  PERSON_ID                                     NUMBER NOT NULL, 
	DUTY_TYPE                                     VARCHAR2(2) NOT NULL,
  DUTY_YYYYMM                                   VARCHAR2(7) NOT NULL,
  WORK_CORP_ID                                  NUMBER NOT NULL,
  CORP_ID                                       NUMBER NOT NULL,  
  DEPT_ID                                       NUMBER,
  POST_ID                                       NUMBER,
  JOB_CATEGORY_ID                               NUMBER,
  HOLIDAY_IN_COUNT                              NUMBER DEFAULT 0,
	LATE_DED_COUNT                                NUMBER DEFAULT 0,
  WEEKLY_DED_COUNT                              NUMBER DEFAULT 0,
  CHANGE_DED_COUNT                              NUMBER DEFAULT 0,
  HOLY_0_COUNT                                  NUMBER DEFAULT 0,
  HOLY_1_COUNT                                  NUMBER DEFAULT 0,
  HOLY_2_COUNT                                  NUMBER DEFAULT 0,
  HOLY_3_COUNT                                  NUMBER DEFAULT 0,
	TOTAL_DAY                                     NUMBER DEFAULT 0,
  TOTAL_ATT_DAY                                 NUMBER DEFAULT 0,
  TOTAL_DED_DAY                                 NUMBER DEFAULT 0,
  PAY_DAY                                       NUMBER DEFAULT 0,
  HOLY_0_DED_FLAG                               VARCHAR2(1) DEFAULT 'N',
  STD_HOLY_0_COUNT                              NUMBER DEFAULT 0,
  CLOSED_YN                                     VARCHAR2(1) DEFAULT 'N',  
  CLOSED_DATE                                   DATE,
  CLOSED_PERSON_ID                              NUMBER,
  DESCRIPTION                                   VARCHAR2(100),
  ATTRIBUTE1                                    VARCHAR2(100),
  ATTRIBUTE2                                    VARCHAR2(100),
  ATTRIBUTE3                                    VARCHAR2(100),
  ATTRIBUTE4                                    VARCHAR2(100),
  ATTRIBUTE5                                    VARCHAR2(100),
	SOB_ID                                        NUMBER NOT NULL,
	ORG_ID                                        NUMBER NOT NULL,
  CREATION_DATE                                 DATE NOT NULL,
  CREATED_BY                                    NUMBER NOT NULL,
  LAST_UPDATE_DATE                              DATE NOT NULL,
  LAST_UPDATED_BY                               NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_MONTH_TOTAL.MONTH_TOTAL_ID IS '������ ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL.DUTY_TYPE IS '���� Ÿ��(1-������)';
COMMENT ON COLUMN HRD_MONTH_TOTAL.DUTY_YYYYMM IS '���³��';
COMMENT ON COLUMN HRD_MONTH_TOTAL.WORK_CORP_ID IS '�ٹ� ��ü ID';
COMMENT ON COLUMN HRD_MONTH_TOTAL.CORP_ID IS '�Ҽ� ��üID';
COMMENT ON COLUMN HRD_MONTH_TOTAL.DEPT_ID IS '�μ��ڵ�';
COMMENT ON COLUMN HRD_MONTH_TOTAL.POST_ID IS '�����ڵ�';
COMMENT ON COLUMN HRD_MONTH_TOTAL.JOB_CATEGORY_ID IS '������';
COMMENT ON COLUMN HRD_MONTH_TOTAL.HOLIDAY_IN_COUNT IS '���ϱٹ�Ƚ��';
COMMENT ON COLUMN HRD_MONTH_TOTAL.LATE_DED_COUNT IS '��������Ƚ��';
COMMENT ON COLUMN HRD_MONTH_TOTAL.WEEKLY_DED_COUNT IS '���ް����ϼ�';
COMMENT ON COLUMN HRD_MONTH_TOTAL.CHANGE_DED_COUNT IS '�������ް����ϼ�-������ ���濡 ���� ���ް���';
COMMENT ON COLUMN HRD_MONTH_TOTAL.HOLY_0_COUNT IS '����Ƚ��';
COMMENT ON COLUMN HRD_MONTH_TOTAL.HOLY_1_COUNT IS '����Ƚ��';
COMMENT ON COLUMN HRD_MONTH_TOTAL.HOLY_2_COUNT IS '�ְ�Ƚ��';
COMMENT ON COLUMN HRD_MONTH_TOTAL.HOLY_3_COUNT IS '�߰�Ƚ��';
COMMENT ON COLUMN HRD_MONTH_TOTAL.TOTAL_DAY IS '�� ���ϼ�';
COMMENT ON COLUMN HRD_MONTH_TOTAL.TOTAL_ATT_DAY IS '����ϼ�';
COMMENT ON COLUMN HRD_MONTH_TOTAL.TOTAL_DED_DAY IS '�Ѱ����ϼ�';
COMMENT ON COLUMN HRD_MONTH_TOTAL.PAY_DAY IS '�޿��ϼ�';
COMMENT ON COLUMN HRD_MONTH_TOTAL.HOLY_0_DED_FLAG IS '�������� ���� ����';
COMMENT ON COLUMN HRD_MONTH_TOTAL.STD_HOLY_0_COUNT IS '���� �������ϼ�';
COMMENT ON COLUMN HRD_MONTH_TOTAL.CLOSED_YN IS '��������';
COMMENT ON COLUMN HRD_MONTH_TOTAL.CLOSED_DATE IS '�����Ͻ�';
COMMENT ON COLUMN HRD_MONTH_TOTAL.CLOSED_PERSON_ID IS '����ó����';
COMMENT ON COLUMN HRD_MONTH_TOTAL.DESCRIPTION IS '���';
COMMENT ON COLUMN HRD_MONTH_TOTAL.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_MONTH_TOTAL.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_MONTH_TOTAL.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_MONTH_TOTAL.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_MONTH_TOTAL_U1 ON HRD_MONTH_TOTAL(MONTH_TOTAL_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRD_MONTH_TOTAL_U2 ON HRD_MONTH_TOTAL(PERSON_ID, DUTY_YYYYMM, DUTY_TYPE, WORK_CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRD_MONTH_TOTAL_U3 ON HRD_MONTH_TOTAL(PERSON_ID, DUTY_YYYYMM, DUTY_TYPE, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE HRD_MONTH_TOTAL_S1;

-- ANALYZE.
ANALYZE TABLE HRD_MONTH_TOTAL COMPUTE STATISTICS;
ANALYZE INDEX HRD_MONTH_TOTAL_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_MONTH_TOTAL_U2 COMPUTE STATISTICS;
ANALYZE INDEX HRD_MONTH_TOTAL_U3 COMPUTE STATISTICS;
