/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_MONTH_PAYMENT
/* Description  : ���޻� ���� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRP_MONTH_PAYMENT              
( MONTH_PAYMENT_ID                                NUMBER NOT NULL,
  PERSON_ID	                                      NUMBER NOT NULL,
  PAY_YYYYMM	                                    VARCHAR2(7) NOT NULL,
  WAGE_TYPE                                       VARCHAR2(5) NOT NULL,
  CORP_ID                                         NUMBER NOT NULL,
  DEPT_ID	                                        NUMBER,
  POST_ID	                                        NUMBER,
  OCPT_ID	                                        NUMBER,
  ABIL_ID	                                        NUMBER,
  JOB_CATEGORY_ID	                                NUMBER,  
  PAY_TYPE	                                      VARCHAR2(2) NOT NULL,
  PAY_GRADE_ID	                                  NUMBER,
  GRADE_STEP	                                    NUMBER,
  COST_CENTER_ID	                                NUMBER,
  DIR_INDIR_TYPE	                                VARCHAR2(2),
  EMPLOYE_TYPE	                                  VARCHAR2(1),
  EXCEPT_TYPE	                                    VARCHAR2(1),
  HIRE_INSUR_YN                                   VARCHAR2(1),
  SUPPLY_DATE	                                    DATE, 
  STANDARD_DATE	                                  DATE,
  LONG_YEAR                                       NUMBER DEFAULT 0,
  LONG_MONTH	                                    NUMBER DEFAULT 0,
  GENERAL_HOURLY_AMOUNT                           NUMBER DEFAULT 0,
  PAY_DAY	                                        NUMBER DEFAULT 0,
  PAY_RATE	                                      NUMBER DEFAULT 100,  
  DED_PERSON_COUNT	                              NUMBER DEFAULT 0,
  PAY_AMOUNT	                                    NUMBER DEFAULT 0,
  DED_PAY_AMOUNT	                                NUMBER DEFAULT 0,
  BONUS_AMOUNT	                                  NUMBER DEFAULT 0,
  DED_BONUS_AMOUNT	                              NUMBER DEFAULT 0,
  TOT_SUPPLY_AMOUNT	                              NUMBER DEFAULT 0,
  TOT_DED_AMOUNT	                                NUMBER DEFAULT 0,
  REAL_AMOUNT	                                    NUMBER DEFAULT 0,
  DESCRIPTION                                     VARCHAR2(100),
  ATTRIBUTE1                                      VARCHAR2(100),
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
  SOB_ID                                          NUMBER NOT NULL,
  ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID IS '���޿����� ID';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.PAY_YYYYMM IS '�޻� ���';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.WAGE_TYPE IS '�޻� ����';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.CORP_ID IS '��üID';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.DEPT_ID IS '�μ��ڵ�';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.POST_ID IS '�����ڵ�';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.OCPT_ID IS '�����ڵ�';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.ABIL_ID IS '��å�ڵ�';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.JOB_CATEGORY_ID IS '������';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.PAY_TYPE IS '�޿��� ����';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.PAY_GRADE_ID IS '���� ID';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.GRADE_STEP IS 'ȣ��';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.COST_CENTER_ID IS '���� ID';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.DIR_INDIR_TYPE IS '������ ����';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.EMPLOYE_TYPE IS '��������';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.EXCEPT_TYPE IS '��(I)/���(R)������ ����ó��';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.HIRE_INSUR_YN IS '��뺸�� Y/N';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.SUPPLY_DATE IS '��������';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.STANDARD_DATE IS '��������';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.LONG_MONTH IS '�ټӳ��';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.GENERAL_HOURLY_AMOUNT IS '���ñ�';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.PAY_DAY IS '�޻��ϼ�';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.PAY_RATE IS '������';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.DED_PERSON_COUNT IS '�ξ簡�� �����ο���';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.PAY_AMOUNT IS '�޿� ���޾�';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.DED_PAY_AMOUNT IS '�޿� ������';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.BONUS_AMOUNT IS '�� ���޾�';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.DED_BONUS_AMOUNT IS '�� ������';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.TOT_SUPPLY_AMOUNT IS '�����޾�';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.TOT_DED_AMOUNT IS '�Ѱ�����';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.REAL_AMOUNT IS '�����޾�';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.DESCRIPTION IS '���';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.CREATED_BY IS '������';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRP_MONTH_PAYMENT_U1 ON HRP_MONTH_PAYMENT(MONTH_PAYMENT_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRP_MONTH_PAYMENT_U2 ON HRP_MONTH_PAYMENT(PAY_YYYYMM, PAY_TYPE, PERSON_ID, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRP_MONTH_PAYMENT_S1;
CREATE SEQUENCE HRP_MONTH_PAYMENT_S1;

-- ANALYZE.
ANALYZE TABLE HRP_MONTH_PAYMENT COMPUTE STATISTICS;
ANALYZE INDEX HRP_MONTH_PAYMENT_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRP_MONTH_PAYMENT_U2 COMPUTE STATISTICS;
