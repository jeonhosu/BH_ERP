/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_WEEKLY_DED_GT
/* Description  : 老辟怕 包府 - 林绒傍力 包府.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_WEEKLY_DED_GT
( PERSON_ID                       NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  WORK_DATE                       DATE            NOT NULL,
  DED_DATE                        DATE            NOT NULL,
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
  ATTRIBUTE_5                     NUMBER          
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRD_WEEKLY_DED_GT IS '老辟怕-林绒傍力包府';
COMMENT ON COLUMN HRD_WEEKLY_DED_GT.PERSON_ID IS '荤盔ID';
COMMENT ON COLUMN HRD_WEEKLY_DED_GT.WORK_DATE IS '辟公老磊';
COMMENT ON COLUMN HRD_WEEKLY_DED_GT.DED_DATE IS '傍力老磊';
COMMENT ON COLUMN HRD_WEEKLY_DED_GT.DESCRIPTION IS '厚绊';
