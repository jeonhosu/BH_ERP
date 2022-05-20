/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_PERIOD_TOTAL_OT_GT
/* Description  : 월근태 잔업 집계 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE GLOBAL TEMPORARY TABLE HRD_PERIOD_TOTAL_OT_GT              
( PERSON_ID                         NUMBER        NOT NULL, 
  SOB_ID                            NUMBER        NOT NULL,
  ORG_ID                            NUMBER        NOT NULL,
  OT_TYPE                           VARCHAR2(10)  NOT NULL,
  OT_TIME                           NUMBER        DEFAULT 0,  
  DESCRIPTION                       VARCHAR2(300) ,
  ATTRIBUTE_A                       VARCHAR2(150) ,
  ATTRIBUTE_B                       VARCHAR2(150) ,
  ATTRIBUTE_C                       VARCHAR2(150) ,
  ATTRIBUTE_D                       VARCHAR2(150) ,
  ATTRIBUTE_E                       VARCHAR2(150)    
) ON COMMIT PRESERVE ROWS;

-- Add comments to the columns 
COMMENT ON TABLE HRD_PERIOD_TOTAL_OT_GT IS '기간 근태 집계 - 잔업';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_OT_GT.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_OT_GT.OT_TYPE IS '잔업 타입';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_OT_GT.OT_TIME IS '잔업 시간';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_OT_GT.DESCRIPTION IS '비고';
