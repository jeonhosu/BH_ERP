/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRF_FOOD_PERSON
/* Description  : 개인별 식사수 및 공제수 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRF_FOOD_PERSON              
( FOOD_PERSON_ID                                 NUMBER NOT NULL,
  PERSON_ID                                      NUMBER NOT NULL,
	FOOD_DATE                                      DATE NOT NULL,
	CORP_ID                                        NUMBER NOT NULL,
	FOOD_COUNT                                     NUMBER(2) DEFAULT 0,
	DED_COUNT                                      NUMBER(2) DEFAULT 0,
	FOOD_1_COUNT                                   NUMBER(2) DEFAULT 0,
	FOOD_2_COUNT                                   NUMBER(2) DEFAULT 0,
	FOOD_3_COUNT                                   NUMBER(2) DEFAULT 0,
	FOOD_4_COUNT                                   NUMBER(2) DEFAULT 0,
	SNACK_1_COUNT                                  NUMBER(2) DEFAULT 0,
	SNACK_2_COUNT                                  NUMBER(2) DEFAULT 0,
	SNACK_3_COUNT                                  NUMBER(2) DEFAULT 0,
	SNACK_4_COUNT                                  NUMBER(2) DEFAULT 0,
	CLOSED_YN                                      VARCHAR2(1) DEFAULT 'N',
	CLOSED_DATE                                    DATE,
	CLOSED_PERSON_ID                               NUMBER,
	DESCRIPTION                                    VARCHAR2(100),
	ATTRIBUTE1                                     VARCHAR2(100),
	ATTRIBUTE2                                     VARCHAR2(100),
	ATTRIBUTE3                                     VARCHAR2(100),
	ATTRIBUTE4                                     VARCHAR2(100),
	ATTRIBUTE5                                     VARCHAR2(100),
	SOB_ID                                         NUMBER NOT NULL,
	ORG_ID                                         NUMBER NOT NULL,
	CREATION_DATE                                  DATE NOT NULL,
  CREATED_BY                                     NUMBER NOT NULL,
  LAST_UPDATE_DATE                               DATE NOT NULL,
  LAST_UPDATED_BY                                NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRF_FOOD_PERSON.FOOD_PERSON_ID IS '식사수 ID';
COMMENT ON COLUMN HRF_FOOD_PERSON.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRF_FOOD_PERSON.FOOD_DATE IS '식사일자';
COMMENT ON COLUMN HRF_FOOD_PERSON.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRF_FOOD_PERSON.FOOD_COUNT IS '총 식사수';
COMMENT ON COLUMN HRF_FOOD_PERSON.DED_COUNT IS '공제수';
COMMENT ON COLUMN HRF_FOOD_PERSON.FOOD_1_COUNT IS '식사1';
COMMENT ON COLUMN HRF_FOOD_PERSON.FOOD_2_COUNT IS '식사2';
COMMENT ON COLUMN HRF_FOOD_PERSON.FOOD_3_COUNT IS '식사3';
COMMENT ON COLUMN HRF_FOOD_PERSON.FOOD_4_COUNT IS '식사4';
COMMENT ON COLUMN HRF_FOOD_PERSON.SNACK_1_COUNT IS '간식1';
COMMENT ON COLUMN HRF_FOOD_PERSON.SNACK_2_COUNT IS '간식2';
COMMENT ON COLUMN HRF_FOOD_PERSON.SNACK_3_COUNT IS '간식3';
COMMENT ON COLUMN HRF_FOOD_PERSON.SNACK_4_COUNT IS '간식4';
COMMENT ON COLUMN HRF_FOOD_PERSON.CLOSED_YN IS '마감구분';
COMMENT ON COLUMN HRF_FOOD_PERSON.CLOSED_DATE IS '마감일시';
COMMENT ON COLUMN HRF_FOOD_PERSON.CLOSED_PERSON_ID IS '마감 처리자';
COMMENT ON COLUMN HRF_FOOD_PERSON.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRF_FOOD_PERSON.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRF_FOOD_PERSON.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRF_FOOD_PERSON.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRF_FOOD_PERSON.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRF_FOOD_PERSON_U1 ON HRF_FOOD_PERSON(FOOD_PERSON_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRF_FOOD_PERSON_U2 ON HRF_FOOD_PERSON(PERSON_ID, FOOD_DATE, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRF_FOOD_PERSON_S1;
CREATE SEQUENCE HRF_FOOD_PERSON_S1;

-- ANALYZE.
ANALYZE TABLE HRF_FOOD_PERSON COMPUTE STATISTICS;
ANALYZE INDEX HRF_FOOD_PERSON_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRF_FOOD_PERSON_U2 COMPUTE STATISTICS;
