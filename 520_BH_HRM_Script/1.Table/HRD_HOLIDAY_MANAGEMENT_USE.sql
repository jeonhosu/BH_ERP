/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_HOLIDAY_MANAGEMENT_USE
/* Description  : 년차/연중/특별휴가 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_HOLIDAY_MANAGEMENT_USE
( CORP_ID                             NUMBER      NOT NULL,
  PERSON_ID                           NUMBER      NOT NULL,
  HOLIDAY_TYPE                        VARCHAR2(2) NOT NULL,
  DUTY_YEAR                           VARCHAR2(4) NOT NULL,
  PRE_NEXT_NUM                        NUMBER      DEFAULT 0,
  CREATION_NUM                        NUMBER      DEFAULT 0,
  PLUS_NUM                            NUMBER      DEFAULT 0,
  USE_NUM                             NUMBER      DEFAULT 0,
  SOB_ID                              NUMBER      NOT NULL,
  ORG_ID                              NUMBER      NOT NULL,
  CREATION_DATE                       DATE        NOT NULL,
  CREATED_BY                          NUMBER      NOT NULL,
  LAST_UPDATE_DATE                    DATE        NOT NULL,
  LAST_UPDATED_BY                     NUMBER      NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.HOLIDAY_TYPE IS '휴가타입(1-년차, 2-연중, 3-특별휴가)';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.DUTY_YEAR IS '근태년도';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.PRE_NEXT_NUM IS '전년 이월수';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.CREATION_NUM IS '발생 휴가수';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.PLUS_NUM IS '추가 발생수';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.USE_NUM IS '사용수';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_HOLIDAY_MANAGEMENT_USE_U1 ON HRD_HOLIDAY_MANAGEMENT_USE(CORP_ID, PERSON_ID, HOLIDAY_TYPE, DUTY_YEAR, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRD_HOLIDAY_MANAGEMENT_USE COMPUTE STATISTICS;
ANALYZE INDEX HRD_HOLIDAY_MANAGEMENT_USE_U1 COMPUTE STATISTICS;
