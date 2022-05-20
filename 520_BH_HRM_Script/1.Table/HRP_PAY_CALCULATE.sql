/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_PAY_CALCULATE
/* Description  : 급여계산 기준 관리
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
COMMENT ON COLUMN HRP_PAY_CALCULATE.CALCULATE_ID IS '급여계산 ID';
COMMENT ON COLUMN HRP_PAY_CALCULATE.CORP_ID IS '업체 ID';
COMMENT ON COLUMN HRP_PAY_CALCULATE.WAGE_TYPE IS '급상여 구분';
COMMENT ON COLUMN HRP_PAY_CALCULATE.ALLOWANCE_TYPE IS '지급공제 구분(A-지급, D-공제)';
COMMENT ON COLUMN HRP_PAY_CALCULATE.ALLOWANCE_ID IS '지급/공제항목 ID';
COMMENT ON COLUMN HRP_PAY_CALCULATE.PAY_TYPE IS '급여제';
COMMENT ON COLUMN HRP_PAY_CALCULATE.SEX_TYPE IS '성별';
COMMENT ON COLUMN HRP_PAY_CALCULATE.TAX_YN IS '과세/비과세 여부';
COMMENT ON COLUMN HRP_PAY_CALCULATE.TAX_FREE_TYPE IS '비과세 유형';
COMMENT ON COLUMN HRP_PAY_CALCULATE.ROOKIE_YN IS '수습적용';
COMMENT ON COLUMN HRP_PAY_CALCULATE.EXCEPTION_YN IS '입/퇴사 적용';
COMMENT ON COLUMN HRP_PAY_CALCULATE.MONTHLY_PAY_YN IS '월정급여 포함';
COMMENT ON COLUMN HRP_PAY_CALCULATE.GRADE_YN IS '호봉마스터 표시';
COMMENT ON COLUMN HRP_PAY_CALCULATE.PAY_MASTER_YN IS '급여마스터 표시';
COMMENT ON COLUMN HRP_PAY_CALCULATE.ADD_ALLOWANCE_YN IS '급상여 추가공제 표시';
COMMENT ON COLUMN HRP_PAY_CALCULATE.RETIRE_ADJUSTMENT_YN IS '퇴직정산 포함';
COMMENT ON COLUMN HRP_PAY_CALCULATE.YEAR_ALLOWANCE_YN IS '년차수당 여부';
COMMENT ON COLUMN HRP_PAY_CALCULATE.EMPLOYMENT_INSUR_YN IS '고용보험 적용';
COMMENT ON COLUMN HRP_PAY_CALCULATE.DECIMAL_TYPE IS '절사 타입(소숫점 처리)';
COMMENT ON COLUMN HRP_PAY_CALCULATE.DIGIT_NUMBER IS '소수점 자리수';
COMMENT ON COLUMN HRP_PAY_CALCULATE.TEMP_RETIRE_YN IS '휴직자 적용';
COMMENT ON COLUMN HRP_PAY_CALCULATE.SYSTEM_CALCULATION IS '계산식';
COMMENT ON COLUMN HRP_PAY_CALCULATE.IF_CONDITION IS '조건';
COMMENT ON COLUMN HRP_PAY_CALCULATE.TRUE_VALUE IS '조건-참 계산식';
COMMENT ON COLUMN HRP_PAY_CALCULATE.FALSE_VALUE IS '조건-거짓 계산식';
COMMENT ON COLUMN HRP_PAY_CALCULATE.E_SYSTEM_CALCULATION IS '계산식';
COMMENT ON COLUMN HRP_PAY_CALCULATE.E_IF_CONDITION IS '조건';
COMMENT ON COLUMN HRP_PAY_CALCULATE.E_TRUE_VALUE IS '조건-참 계산식';
COMMENT ON COLUMN HRP_PAY_CALCULATE.E_FALSE_VALUE IS '조건-거짓 계산식';
COMMENT ON COLUMN HRP_PAY_CALCULATE.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRP_PAY_CALCULATE.ENABLED_FLAG IS '사용 FLAG';
COMMENT ON COLUMN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_FR IS '적용 시작년월';
COMMENT ON COLUMN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_TO IS '적용 종료년월';
COMMENT ON COLUMN HRP_PAY_CALCULATE.CREATION_DATE	IS '생성일자';
COMMENT ON COLUMN HRP_PAY_CALCULATE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRP_PAY_CALCULATE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRP_PAY_CALCULATE.LAST_UPDATED_BY IS '최종수정자';

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

