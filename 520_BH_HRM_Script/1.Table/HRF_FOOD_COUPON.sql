/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRF_FOOD_COUPON
/* Description  : 식권 사용수 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRF_FOOD_COUPON              
( FOOD_DATE                                      DATE NOT NULL,
  DEVICE_ID                                      NUMBER NOT NULL,
  CORP_ID                                        NUMBER NOT NULL,
  FOOD_COUNT                                     NUMBER(5) DEFAULT 0,
  FOOD_1_COUNT                                   NUMBER(5) DEFAULT 0,
  FOOD_2_COUNT                                   NUMBER(5) DEFAULT 0,
  FOOD_3_COUNT                                   NUMBER(5) DEFAULT 0,
  FOOD_4_COUNT                                   NUMBER(5) DEFAULT 0,
  SNACK_1_COUNT                                  NUMBER(5) DEFAULT 0,
  SNACK_2_COUNT                                  NUMBER(5) DEFAULT 0,
  SNACK_3_COUNT                                  NUMBER(5) DEFAULT 0,
  SNACK_4_COUNT                                  NUMBER(5) DEFAULT 0,
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
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRF_FOOD_COUPON.FOOD_DATE IS '식사일자';
COMMENT ON COLUMN HRF_FOOD_COUPON.DEVICE_ID IS '식당 장치 ID';
COMMENT ON COLUMN HRF_FOOD_COUPON.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRF_FOOD_COUPON.FOOD_COUNT IS '총 식사수';
COMMENT ON COLUMN HRF_FOOD_COUPON.FOOD_1_COUNT IS '식사1';
COMMENT ON COLUMN HRF_FOOD_COUPON.FOOD_2_COUNT IS '식사2';
COMMENT ON COLUMN HRF_FOOD_COUPON.FOOD_3_COUNT IS '식사3';
COMMENT ON COLUMN HRF_FOOD_COUPON.FOOD_4_COUNT IS '식사4';
COMMENT ON COLUMN HRF_FOOD_COUPON.SNACK_1_COUNT IS '간식1';
COMMENT ON COLUMN HRF_FOOD_COUPON.SNACK_2_COUNT IS '간식2';
COMMENT ON COLUMN HRF_FOOD_COUPON.SNACK_3_COUNT IS '간식3';
COMMENT ON COLUMN HRF_FOOD_COUPON.SNACK_4_COUNT IS '간식4';
COMMENT ON COLUMN HRF_FOOD_COUPON.CLOSED_YN IS '마감구분';
COMMENT ON COLUMN HRF_FOOD_COUPON.CLOSED_DATE IS '마감일시';
COMMENT ON COLUMN HRF_FOOD_COUPON.CLOSED_PERSON_ID IS '마감 처리자';
COMMENT ON COLUMN HRF_FOOD_COUPON.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRF_FOOD_COUPON.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRF_FOOD_COUPON.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRF_FOOD_COUPON.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRF_FOOD_COUPON.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRF_FOOD_COUPON_U1 ON HRF_FOOD_COUPON(FOOD_DATE, DEVICE_ID, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.

-- ANALYZE.
ANALYZE TABLE HRF_FOOD_COUPON COMPUTE STATISTICS;
ANALYZE INDEX HRF_FOOD_COUPON_U1 COMPUTE STATISTICS;
