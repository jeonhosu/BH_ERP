/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRF_FOOD_VISITOR_TIME
/* Description  : 방문자 식사시간 및 미체크 시간 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRF_FOOD_VISITOR_TIME              
( VISITOR_ID                                     NUMBER NOT NULL,
  FOOD_DATE                                      DATE NOT NULL,
  FOOD_VISITOR_ID                                NUMBER NOT NULL,
  FOOD_FLAG                                      VARCHAR2(1) NOT NULL,
  DEVICE_ID                                      NUMBER,
  FOOD_DATETIME                                  DATE,
  CREATED_FLAG                                   VARCHAR2(2),
  CREATION_DATE                                  DATE NOT NULL,
  CREATED_BY                                     NUMBER NOT NULL,
  LAST_UPDATE_DATE                               DATE NOT NULL,
  LAST_UPDATED_BY                                NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.VISITOR_ID IS '방문ID';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.FOOD_DATE IS '식사일자';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.FOOD_VISITOR_ID IS '식사수 ID';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.FOOD_FLAG IS '식사구분';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.DEVICE_ID IS '장치ID';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.FOOD_DATETIME IS '식사일시';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.CREATED_FLAG IS '생성구분';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRF_FOOD_VISITOR_TIME_U1 ON HRF_FOOD_VISITOR_TIME(VISITOR_ID, FOOD_DATETIME, DEVICE_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRF_FOOD_VISITOR_TIME_N1 ON HRF_FOOD_VISITOR_TIME(FOOD_VISITOR_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRF_FOOD_VISITOR_TIME COMPUTE STATISTICS;
ANALYZE INDEX HRF_FOOD_VISITOR_TIME_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRF_FOOD_VISITOR_TIME_N1 COMPUTE STATISTICS;
