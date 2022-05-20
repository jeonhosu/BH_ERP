/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_WEEKLY_DED
/* Description  : 일근태 관리 - 주휴공제 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_WEEKLY_DED
( PERSON_ID                       NUMBER          NOT NULL,
  WORK_DATE                       DATE            NOT NULL,
  WORK_CORP_ID                    NUMBER          NOT NULL,
  CORP_ID                         NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  DESCRIPTION                     VARCHAR2(100)   ,
  ATTRIBUTE_A                     VARCHAR2(250)   ,    
  ATTRIBUTE_B                     VARCHAR2(250)   ,    
  ATTRIBUTE_C                     VARCHAR2(250)   ,    
  ATTRIBUTE_D                     VARCHAR2(250)   ,    
  ATTRIBUTE_E                     VARCHAR2(250)   ,    
  ATTRIBUTE_1                     NUMBER          ,    
  ATTRIBUTE_2                     NUMBER          ,    
  ATTRIBUTE_3                     NUMBER          ,    
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          ,  
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRD_WEEKLY_DED IS '일근태-주휴공제관리';
COMMENT ON COLUMN HRD_WEEKLY_DED.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRD_WEEKLY_DED.WORK_DATE IS '근무일자';
COMMENT ON COLUMN HRD_WEEKLY_DED.WORK_CORP_ID IS '근무 업체ID';
COMMENT ON COLUMN HRD_WEEKLY_DED.CORP_ID IS '소속 업체ID';
COMMENT ON COLUMN HRD_WEEKLY_DED.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRD_WEEKLY_DED.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_WEEKLY_DED.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_WEEKLY_DED.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_WEEKLY_DED.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
ALTER TABLE HRD_WEEKLY_DED ADD CONSTRAINT HRD_WEEKLY_DED_PK PRIMARY KEY(PERSON_ID, WORK_DATE, WORK_CORP_ID, SOB_ID, ORG_ID);

-- ANALYZE.
ANALYZE TABLE HRD_WEEKLY_DED COMPUTE STATISTICS;
