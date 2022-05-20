/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_PERIOD_TOTAL_DUTY_GT
/* Description  : 월근태 근태 집계 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE GLOBAL TEMPORARY TABLE HRD_PERIOD_TOTAL_DUTY_GT              
( PERSON_ID                         NUMBER        NOT NULL,
  SOB_ID                            NUMBER        NOT NULL,
  ORG_ID                            NUMBER        NOT NULL,
  DUTY_ID                           NUMBER        NOT NULL,
  DUTY_COUNT                        NUMBER        DEFAULT 0,  
  NON_PAY_YN                        VARCHAR2(1)   DEFAULT 'N',
  DESCRIPTION                       VARCHAR2(100) ,
  ATTRIBUTE1                        VARCHAR2(100) ,
  ATTRIBUTE2                        VARCHAR2(100) ,
  ATTRIBUTE3                        VARCHAR2(100) ,
  ATTRIBUTE4                        VARCHAR2(100) ,
  ATTRIBUTE5                        VARCHAR2(100)
) ON COMMIT PRESERVE ROWS;

-- Add comments to the columns 
COMMENT ON TABLE HRD_PERIOD_TOTAL_DUTY_GT IS '기간 근태 집계 - 근태계';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_DUTY_GT.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_DUTY_GT.DUTY_ID IS '근태ID';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_DUTY_GT.DUTY_COUNT IS '근태 집계수';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_DUTY_GT.NON_PAY_YN IS '근여공제 Y/N';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_DUTY_GT.DESCRIPTION IS '비고';




