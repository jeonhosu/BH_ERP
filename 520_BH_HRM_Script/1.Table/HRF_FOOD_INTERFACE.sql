/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRF_FOOD_INTERFACE
/* Description  : 식수 interface 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRF_FOOD_INTERFACE              
( DEVICE_ID                                      NUMBER NOT NULL,
  PERSON_ID                                      NUMBER NOT NULL,
  FOOD_FLAG                                      VARCHAR2(1) NOT NULL,
  FOOD_DATETIME                                  DATE NOT NULL,
  FOOD_DATE                                      DATE NOT NULL,
  FOOD_TIME                                      VARCHAR2(5) NOT NULL,
  CREATED_FLAG                                   VARCHAR2(2),
  CARD_NUM                                       VARCHAR2(50),
	CARD_TYPE                                      VARCHAR2(2),
  SOB_ID                                         NUMBER NOT NULL,
  ORG_ID                                         NUMBER NOT NULL,
  CREATION_DATE                                  DATE NOT NULL,
  CREATED_BY                                     NUMBER NOT NULL,
  LAST_UPDATE_DATE                               DATE NOT NULL,
  LAST_UPDATED_BY                                NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRF_FOOD_INTERFACE.DEVICE_ID IS '장치ID';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.FOOD_FLAG IS '식사구분';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.FOOD_DATETIME IS '식사일시';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.FOOD_DATE IS '식사일자';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.FOOD_TIME IS '식사시간';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.CREATED_FLAG IS '생성구분';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.CARD_NUM IS '카드번호';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.CARD_TYPE IS '카드구분(P-PERSON, V-VISITOR)';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRF_FOOD_INTERFACE_U1 ON HRF_FOOD_INTERFACE(DEVICE_ID, PERSON_ID, FOOD_FLAG, FOOD_DATETIME, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRF_FOOD_INTERFACE_N1 ON HRF_FOOD_INTERFACE(PERSON_ID, FOOD_DATE, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRF_FOOD_INTERFACE COMPUTE STATISTICS;
ANALYZE INDEX HRF_FOOD_INTERFACE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRF_FOOD_INTERFACE_N1 COMPUTE STATISTICS;
