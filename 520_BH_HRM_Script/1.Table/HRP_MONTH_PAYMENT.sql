/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_MONTH_PAYMENT
/* Description  : 월급상여 내역 관리
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
COMMENT ON COLUMN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID IS '월급여내역 ID';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.PAY_YYYYMM IS '급상여 년월';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.WAGE_TYPE IS '급상여 구분';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.DEPT_ID IS '부서코드';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.POST_ID IS '직위코드';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.OCPT_ID IS '직무코드';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.ABIL_ID IS '직책코드';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.JOB_CATEGORY_ID IS '직구분';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.PAY_TYPE IS '급여제 구분';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.PAY_GRADE_ID IS '직급 ID';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.GRADE_STEP IS '호봉';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.COST_CENTER_ID IS '원가 ID';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.DIR_INDIR_TYPE IS '직간접 구분';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.EMPLOYE_TYPE IS '재직구분';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.EXCEPT_TYPE IS '입(I)/퇴사(R)등으로 예외처리';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.HIRE_INSUR_YN IS '고용보험 Y/N';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.SUPPLY_DATE IS '지급일자';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.STANDARD_DATE IS '기준일자';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.LONG_MONTH IS '근속년수';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.GENERAL_HOURLY_AMOUNT IS '통상시급';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.PAY_DAY IS '급상여일수';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.PAY_RATE IS '지급율';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.DED_PERSON_COUNT IS '부양가족 공제인원수';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.PAY_AMOUNT IS '급여 지급액';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.DED_PAY_AMOUNT IS '급여 공제액';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.BONUS_AMOUNT IS '상여 지급액';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.DED_BONUS_AMOUNT IS '상여 공제액';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.TOT_SUPPLY_AMOUNT IS '총지급액';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.TOT_DED_AMOUNT IS '총공제액';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.REAL_AMOUNT IS '실지급액';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRP_MONTH_PAYMENT.LAST_UPDATED_BY IS '최종수정자';

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
