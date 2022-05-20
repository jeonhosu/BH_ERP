/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRF_FOOD_MANAGER
/* Description  : 식당별 담당자 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRF_FOOD_MANAGER      
( DEVICE_ID                                       NUMBER NOT NULL,
  USER_ID                                         NUMBER NOT NULL,
	DESCRIPTION                                     VARCHAR2(100),
	ENABLED_FLAG                                    VARCHAR2(1) NOT NULL,
  EFFECTIVE_DATE_FR                               DATE NOT NULL,
  EFFECTIVE_DATE_TO                               DATE,
  SOB_ID                                          NUMBER NOT NULL,
  ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER  NOT NULL
)
  TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRF_FOOD_MANAGER.DEVICE_ID IS '장치 ID';
COMMENT ON COLUMN HRF_FOOD_MANAGER.USER_ID IS '사용자 ID';
COMMENT ON COLUMN HRF_FOOD_MANAGER.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRF_FOOD_MANAGER.ENABLED_FLAG IS '사용 FLAG';
COMMENT ON COLUMN HRF_FOOD_MANAGER.EFFECTIVE_DATE_FR IS '시작일자';
COMMENT ON COLUMN HRF_FOOD_MANAGER.EFFECTIVE_DATE_TO IS '종료일자';
COMMENT ON COLUMN HRF_FOOD_MANAGER.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRF_FOOD_MANAGER.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRF_FOOD_MANAGER.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRF_FOOD_MANAGER.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRF_FOOD_MANAGER_U1 ON HRF_FOOD_MANAGER(DEVICE_ID, USER_ID, EFFECTIVE_DATE_FR, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRF_FOOD_MANAGER COMPUTE STATISTICS;
ANALYZE INDEX HRF_FOOD_MANAGER_U1 COMPUTE STATISTICS;


