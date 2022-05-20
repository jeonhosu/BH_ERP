/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_PERSON_HISTORY
/* Description  : 개인별 작업장/교대유형 변경 내역.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_PERSON_HISTORY              
( CORP_ID                         NUMBER          NOT NULL,     -- 업체ID.
  PERSON_ID                       NUMBER          NOT NULL,     -- 사원ID.
  EFFECTIVE_DATE_FR               DATE            NOT NULL,     -- 적용 시작일자.
  EFFECTIVE_DATE_TO               DATE            NOT NULL,     -- 적용 종료일자.
  SOB_ID                          NUMBER          NOT NULL,     -- SOB ID.
  ORG_ID                          NUMBER          NOT NULL,     -- ORG ID.
  FLOOR_ID                        NUMBER          ,             -- 변경후 작업장ID.
  WORK_TYPE_ID                    NUMBER          ,             -- 변경후 교대유형ID.
  PRE_FLOOR_ID                    NUMBER          ,             -- 변경후 작업장ID.
  PRE_WORK_TYPE_ID                NUMBER          ,             -- 변경후 교대유형ID.
  DESCRIPTION                     VARCHAR2(200)   ,             -- 비고.
  LAST_YN                         CHAR(1)         DEFAULT 'Y',  -- 최종구분.
  ATTRIBUTE_A                     VARCHAR2(200)   ,
  ATTRIBUTE_B                     VARCHAR2(200)   ,
  ATTRIBUTE_C                     VARCHAR2(200)   ,
  ATTRIBUTE_D                     VARCHAR2(200)   ,
  ATTRIBUTE_E                     VARCHAR2(200)   ,
  ATTRIBUTE_1                     NUMBER          ,
  ATTRIBUTE_2                     NUMBER          ,
  ATTRIBUTE_3                     NUMBER          ,
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRD_PERSON_HISTORY IS '개인별 작업장/교대유형 변경 내역';
COMMENT ON COLUMN HRD_PERSON_HISTORY.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRD_PERSON_HISTORY.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR IS '유효 시작일자';
COMMENT ON COLUMN HRD_PERSON_HISTORY.EFFECTIVE_DATE_TO IS '유효 종료일자';
COMMENT ON COLUMN HRD_PERSON_HISTORY.FLOOR_ID IS '변경후 작업장ID';
COMMENT ON COLUMN HRD_PERSON_HISTORY.WORK_TYPE_ID IS '변경후교대유형ID';
COMMENT ON COLUMN HRD_PERSON_HISTORY.PRE_FLOOR_ID IS '변경전 작업장ID';
COMMENT ON COLUMN HRD_PERSON_HISTORY.PRE_WORK_TYPE_ID IS '변경전 교대유형ID';
COMMENT ON COLUMN HRD_PERSON_HISTORY.LAST_YN IS '최종구분';
COMMENT ON COLUMN HRD_PERSON_HISTORY.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRD_PERSON_HISTORY.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_PERSON_HISTORY.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_PERSON_HISTORY.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_PERSON_HISTORY.LAST_UPDATED_BY IS '최종수정자';

ALTER TABLE HRD_PERSON_HISTORY ADD CONSTRAINT HRD_PERSON_HISTORY_PK PRIMARY KEY (CORP_ID, PERSON_ID, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO, SOB_ID, ORG_ID);

-- CREATE INDEX.
CREATE INDEX HRD_PERSON_HISTORY_N1 ON HRD_PERSON_HISTORY(CORP_ID, PERSON_ID, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO, LAST_YN, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRD_PERSON_HISTORY COMPUTE STATISTICS;
ANALYZE INDEX HRD_PERSON_HISTORY_N1 COMPUTE STATISTICS;
