/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRR_RETIRE_RESERVE
/* Description  : 퇴직 보험금 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRR_RETIRE_RESERVE              
( PERSON_ID                                       NUMBER NOT NULL,
  RESERVE_YYYYMM                                  VARCHAR2(7) NOT NULL,
  CORP_ID                                         NUMBER NOT NULL,
  DEPT_ID                                         NUMBER,
  PAY_GRADE_ID                                    NUMBER,
  COST_CENTER_ID                                  NUMBER,
  JOIN_DATE                                       DATE,
  EXPIRE_DATE                                     DATE,
  START_DATE                                      DATE NOT NULL,
  END_DATE                                        DATE NOT NULL,
  TOTAL_PAY_AMOUNT                                NUMBER DEFAULT 0,
  TOTAL_BONUS_AMOUNT                              NUMBER DEFAULT 0,
  YEAR_ALLOWANCE_AMOUNT                           NUMBER DEFAULT 0,
  LONG_YEAR                                       NUMBER DEFAULT 0,
  LONG_MONTH                                      NUMBER DEFAULT 0,
  LONG_DAY                                        NUMBER DEFAULT 0,
  DAY_3RD_COUNT                                   NUMBER DEFAULT 0,
  DAY_AVG_AMOUNT                                  NUMBER DEFAULT 0,
  RETIRE_AMOUNT                                   NUMBER DEFAULT 0,
  PREVIOUS_RETIRE_AMOUNT                          NUMBER DEFAULT 0,
  THIS_RETIRE_AMOUNT                              NUMBER DEFAULT 0,
  GAP_RETIRE_AMOUNT                               NUMBER DEFAULT 0,
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
COMMENT ON COLUMN HRR_RETIRE_RESERVE.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.RESERVE_YYYYMM IS '퇴죽충당금 설정 년월';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.DEPT_ID IS '부서ID';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.PAY_GRADE_ID IS '직급ID';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.COST_CENTER_ID IS 'COST CENTER ID';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.JOIN_DATE IS '입사일자';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.EXPIRE_DATE IS '중도정산일자';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.START_DATE IS '시작일자';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.END_DATE IS '종료일자';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.TOTAL_PAY_AMOUNT IS '총급여액(기준월수에 대한)';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.TOTAL_BONUS_AMOUNT IS '총상여액(기준월수에 대한)';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.YEAR_ALLOWANCE_AMOUNT IS '년차수당(기준월수에 대한)';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.LONG_YEAR IS '근속년수';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.LONG_MONTH IS '근속월수';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.LONG_DAY IS '근속일수';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.DAY_3RD_COUNT IS '3개월 일수';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.DAY_AVG_AMOUNT IS '일평균금액';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.RETIRE_AMOUNT IS '퇴직금';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.PREVIOUS_RETIRE_AMOUNT IS '전월 퇴직금';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.THIS_RETIRE_AMOUNT IS '당월 퇴직금';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.GAP_RETIRE_AMOUNT IS '퇴직금 차액';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRR_RETIRE_RESERVE.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRR_RETIRE_RESERVE_U1 ON HRR_RETIRE_RESERVE(PERSON_ID, RESERVE_YYYYMM, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRR_RETIRE_RESERVE COMPUTE STATISTICS;
ANALYZE INDEX HRR_RETIRE_RESERVE_U1 COMPUTE STATISTICS;
