/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_HOLIDAY_MANAGEMENT
/* Description  : 년차/연중/특별휴가 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_HOLIDAY_MANAGEMENT              
( CORP_ID                                         NUMBER NOT NULL,
  PERSON_ID	                                      NUMBER NOT NULL,
	HOLIDAY_TYPE	                                  VARCHAR2(2) NOT NULL,
	DUTY_YEAR	                                      VARCHAR2(4) NOT NULL,
  PRE_NEXT_NUM	                                  NUMBER DEFAULT 0,
  CREATION_NUM	                                  NUMBER DEFAULT 0,
  PLUS_NUM	                                      NUMBER DEFAULT 0,
  USE_NUM	                                        NUMBER DEFAULT 0,
  YEAR_COUNT	                                    NUMBER DEFAULT 0,
  TRANS_NEXT_YN	                                  VARCHAR2(1) DEFAULT 'N',
  BASE_AMOUNT	                                    NUMBER DEFAULT 0,
  GENERAL_AMOUNT	                                NUMBER DEFAULT 0,
  PAY_AMOUNT	                                    NUMBER DEFAULT 0,
  PAY_YYYYMM	                                    VARCHAR2(7),
  TRANS_PAY_YN	                                  VARCHAR2(1) DEFAULT 'N',
  TRANS_PAY_DATE	                                DATE,
  TRANS_PAY_PERSON_ID	                            NUMBER,
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
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.HOLIDAY_TYPE IS '휴가타입(1-년차, 2-연중, 3-특별휴가)';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.DUTY_YEAR IS '근태년도';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.PRE_NEXT_NUM IS '전년 이월수';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.CREATION_NUM IS '발생 휴가수';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.PLUS_NUM IS '추가 발생수';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.USE_NUM IS '사용수';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.YEAR_COUNT IS '근속년수';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.TRANS_NEXT_YN IS '잔여수 이월 구분';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.BASE_AMOUNT IS '기본급';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.GENERAL_AMOUNT IS '통상임금';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.PAY_AMOUNT IS '년차수당';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.PAY_YYYYMM IS '지급 급연년월';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.TRANS_PAY_YN IS '급여전송 구분';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.TRANS_PAY_DATE IS '급여전송 일시';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.TRANS_PAY_PERSON_ID IS '급여전송 처리자';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_HOLIDAY_MANAGEMENT_U1 ON HRD_HOLIDAY_MANAGEMENT(CORP_ID, PERSON_ID, HOLIDAY_TYPE, DUTY_YEAR, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRD_HOLIDAY_MANAGEMENT COMPUTE STATISTICS;
ANALYZE INDEX HRD_HOLIDAY_MANAGEMENT_U1 COMPUTE STATISTICS;
