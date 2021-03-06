/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_WEEKLY_DED
/* Description  : 老辟怕 包府 - 林绒傍力 包府.
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
COMMENT ON TABLE HRD_WEEKLY_DED IS '老辟怕-林绒傍力包府';
COMMENT ON COLUMN HRD_WEEKLY_DED.PERSON_ID IS '荤盔ID';
COMMENT ON COLUMN HRD_WEEKLY_DED.WORK_DATE IS '辟公老磊';
COMMENT ON COLUMN HRD_WEEKLY_DED.WORK_CORP_ID IS '辟公 诀眉ID';
COMMENT ON COLUMN HRD_WEEKLY_DED.CORP_ID IS '家加 诀眉ID';
COMMENT ON COLUMN HRD_WEEKLY_DED.DESCRIPTION IS '厚绊';
COMMENT ON COLUMN HRD_WEEKLY_DED.CREATION_DATE  IS '积己老磊';
COMMENT ON COLUMN HRD_WEEKLY_DED.CREATED_BY IS '积己磊';
COMMENT ON COLUMN HRD_WEEKLY_DED.LAST_UPDATE_DATE IS '弥辆荐沥老磊';
COMMENT ON COLUMN HRD_WEEKLY_DED.LAST_UPDATED_BY IS '弥辆荐沥磊';

-- CREATE INDEX.
ALTER TABLE HRD_WEEKLY_DED ADD CONSTRAINT HRD_WEEKLY_DED_PK PRIMARY KEY(PERSON_ID, WORK_DATE, WORK_CORP_ID, SOB_ID, ORG_ID);

-- ANALYZE.
ANALYZE TABLE HRD_WEEKLY_DED COMPUTE STATISTICS;
