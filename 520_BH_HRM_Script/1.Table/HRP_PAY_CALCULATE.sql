/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_PAY_CALCULATE
/* Description  : �޿���� ���� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRP_PAY_CALCULATE							
( CALCULATE_ID                                  NUMBER NOT NULL,
  CORP_ID                                       NUMBER NOT NULL,
  WAGE_TYPE                                     VARCHAR2(5) NOT NULL,
  ALLOWANCE_TYPE                                VARCHAR2(2) NOT NULL,
  ALLOWANCE_ID                                  NUMBER NOT NULL, 
  PAY_TYPE		                                  VARCHAR2(2) NOT NULL, 
  SEX_TYPE		                                  VARCHAR2(1),
  TAX_YN		                                    VARCHAR2(1), 
  TAX_FREE_TYPE	                                VARCHAR2(10),  
  ROOKIE_YN		                                  VARCHAR2(1),
  EXCEPTION_YN                                  VARCHAR2(1),
  MONTHLY_PAY_YN                                VARCHAR2(1),
  GRADE_YN                                      VARCHAR2(1),
  PAY_MASTER_YN                                 VARCHAR2(1),
  ADD_ALLOWANCE_YN                              VARCHAR2(1),
  RETIRE_ADJUSTMENT_YN                          VARCHAR2(1),
  YEAR_ALLOWANCE_YN                             VARCHAR2(1),
  EMPLOYMENT_INSUR_YN                           VARCHAR2(1),
  DECIMAL_TYPE                                  VARCHAR2(2),
  DIGIT_NUMBER                                  NUMBER,
  TEMP_RETIRE_YN                                VARCHAR2(1),
  SYSTEM_CALCULATION                            VARCHAR2(250),
  IF_CONDITION                                  VARCHAR2(250),
  TRUE_VALUE                                    VARCHAR2(250),
  FALSE_VALUE                                   VARCHAR2(250),
  VALUE1                                        VARCHAR2(100),
  VALUE2                                        VARCHAR2(100),
  VALUE3                                        VARCHAR2(100),
  VALUE4                                        VARCHAR2(100),
  VALUE5                                        VARCHAR2(100),
  VALUE6                                        VARCHAR2(100),
  VALUE7                                        VARCHAR2(100),
  VALUE8                                        VARCHAR2(100),
  VALUE9                                        VARCHAR2(100),
  VALUE10                                       VARCHAR2(100),
  E_SYSTEM_CALCULATION                          VARCHAR2(250),
  E_IF_CONDITION                                VARCHAR2(250),
  E_TRUE_VALUE                                  VARCHAR2(250),
  E_FALSE_VALUE                                 VARCHAR2(250),  
  E_VALUE1                                      VARCHAR2(100),
  E_VALUE2                                      VARCHAR2(100),
  E_VALUE3                                      VARCHAR2(100),
  E_VALUE4                                      VARCHAR2(100),
  E_VALUE5                                      VARCHAR2(100),
  E_VALUE6                                      VARCHAR2(100),
  E_VALUE7                                      VARCHAR2(100),
  E_VALUE8                                      VARCHAR2(100),
  E_VALUE9                                      VARCHAR2(100),
  E_VALUE10                                     VARCHAR2(100),
  DESCRIPTION                                   VARCHAR2(100), 
  ATTRIBUTE1		                                VARCHAR2(100),					
  ATTRIBUTE2		                                VARCHAR2(100),
  ATTRIBUTE3		                                VARCHAR2(100),
  ATTRIBUTE4		                                VARCHAR2(100),
  ATTRIBUTE5		                                VARCHAR2(100),
  ENABLED_FLAG		                              VARCHAR2(1) DEFAULT 'N',
  EFFECTIVE_YYYYMM_FR                           VARCHAR2(7) NOT NULL,
  EFFECTIVE_YYYYMM_TO                           VARCHAR2(7),
	SOB_ID                                        NUMBER NOT NULL,
	ORG_ID                                        NUMBER NOT NULL,
  CREATION_DATE		                              DATE NOT NULL,
  CREATED_BY		                                NUMBER NOT NULL,
  LAST_UPDATE_DATE	                            DATE NOT NULL,
  LAST_UPDATED_BY	                              NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRP_PAY_CALCULATE.CALCULATE_ID IS '�޿���� ID';
COMMENT ON COLUMN HRP_PAY_CALCULATE.CORP_ID IS '��ü ID';
COMMENT ON COLUMN HRP_PAY_CALCULATE.WAGE_TYPE IS '�޻� ����';
COMMENT ON COLUMN HRP_PAY_CALCULATE.ALLOWANCE_TYPE IS '���ް��� ����(A-����, D-����)';
COMMENT ON COLUMN HRP_PAY_CALCULATE.ALLOWANCE_ID IS '����/�����׸� ID';
COMMENT ON COLUMN HRP_PAY_CALCULATE.PAY_TYPE IS '�޿���';
COMMENT ON COLUMN HRP_PAY_CALCULATE.SEX_TYPE IS '����';
COMMENT ON COLUMN HRP_PAY_CALCULATE.TAX_YN IS '����/����� ����';
COMMENT ON COLUMN HRP_PAY_CALCULATE.TAX_FREE_TYPE IS '����� ����';
COMMENT ON COLUMN HRP_PAY_CALCULATE.ROOKIE_YN IS '��������';
COMMENT ON COLUMN HRP_PAY_CALCULATE.EXCEPTION_YN IS '��/��� ����';
COMMENT ON COLUMN HRP_PAY_CALCULATE.MONTHLY_PAY_YN IS '�����޿� ����';
COMMENT ON COLUMN HRP_PAY_CALCULATE.GRADE_YN IS 'ȣ�������� ǥ��';
COMMENT ON COLUMN HRP_PAY_CALCULATE.PAY_MASTER_YN IS '�޿������� ǥ��';
COMMENT ON COLUMN HRP_PAY_CALCULATE.ADD_ALLOWANCE_YN IS '�޻� �߰����� ǥ��';
COMMENT ON COLUMN HRP_PAY_CALCULATE.RETIRE_ADJUSTMENT_YN IS '�������� ����';
COMMENT ON COLUMN HRP_PAY_CALCULATE.YEAR_ALLOWANCE_YN IS '�������� ����';
COMMENT ON COLUMN HRP_PAY_CALCULATE.EMPLOYMENT_INSUR_YN IS '��뺸�� ����';
COMMENT ON COLUMN HRP_PAY_CALCULATE.DECIMAL_TYPE IS '���� Ÿ��(�Ҽ��� ó��)';
COMMENT ON COLUMN HRP_PAY_CALCULATE.DIGIT_NUMBER IS '�Ҽ��� �ڸ���';
COMMENT ON COLUMN HRP_PAY_CALCULATE.TEMP_RETIRE_YN IS '������ ����';
COMMENT ON COLUMN HRP_PAY_CALCULATE.SYSTEM_CALCULATION IS '����';
COMMENT ON COLUMN HRP_PAY_CALCULATE.IF_CONDITION IS '����';
COMMENT ON COLUMN HRP_PAY_CALCULATE.TRUE_VALUE IS '����-�� ����';
COMMENT ON COLUMN HRP_PAY_CALCULATE.FALSE_VALUE IS '����-���� ����';
COMMENT ON COLUMN HRP_PAY_CALCULATE.E_SYSTEM_CALCULATION IS '����';
COMMENT ON COLUMN HRP_PAY_CALCULATE.E_IF_CONDITION IS '����';
COMMENT ON COLUMN HRP_PAY_CALCULATE.E_TRUE_VALUE IS '����-�� ����';
COMMENT ON COLUMN HRP_PAY_CALCULATE.E_FALSE_VALUE IS '����-���� ����';
COMMENT ON COLUMN HRP_PAY_CALCULATE.DESCRIPTION IS '���';
COMMENT ON COLUMN HRP_PAY_CALCULATE.ENABLED_FLAG IS '��� FLAG';
COMMENT ON COLUMN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_FR IS '���� ���۳��';
COMMENT ON COLUMN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_TO IS '���� ������';
COMMENT ON COLUMN HRP_PAY_CALCULATE.CREATION_DATE	IS '��������';
COMMENT ON COLUMN HRP_PAY_CALCULATE.CREATED_BY IS '������';
COMMENT ON COLUMN HRP_PAY_CALCULATE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRP_PAY_CALCULATE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRP_PAY_CALCULATE_U1 ON HRP_PAY_CALCULATE(CALCULATE_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRP_PAY_CALCULATE_U2 ON HRP_PAY_CALCULATE(CORP_ID, WAGE_TYPE, ALLOWANCE_ID, PAY_TYPE, SEX_TYPE, EFFECTIVE_YYYYMM_FR, EFFECTIVE_YYYYMM_TO, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRP_PAY_CALCULATE_S1;
CREATE SEQUENCE HRP_PAY_CALCULATE_S1;

-- ANALYZE.
ANALYZE TABLE HRP_PAY_CALCULATE COMPUTE STATISTICS;
ANALYZE INDEX HRP_PAY_CALCULATE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRP_PAY_CALCULATE_U2 COMPUTE STATISTICS;

