/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_PERIOD_TOTAL_GT
/* Description  : 기간근태 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE GLOBAL TEMPORARY TABLE HRD_PERIOD_TOTAL_GT              
( PERSON_ID                         NUMBER        NOT NULL, 
  SOB_ID                            NUMBER        NOT NULL,
  ORG_ID                            NUMBER        NOT NULL,
  HOLIDAY_IN_COUNT                  NUMBER        DEFAULT 0,
  LATE_DED_COUNT                    NUMBER        DEFAULT 0,
  WEEKLY_DED_COUNT                  NUMBER        DEFAULT 0,
  CHANGE_DED_COUNT                  NUMBER        DEFAULT 0,
  HOLY_0_COUNT                      NUMBER        DEFAULT 0,
  HOLY_1_COUNT                      NUMBER        DEFAULT 0,
  HOLY_2_COUNT                      NUMBER        DEFAULT 0,
  HOLY_3_COUNT                      NUMBER        DEFAULT 0,
  TOTAL_DAY                         NUMBER        DEFAULT 0,
  TOTAL_ATT_DAY                     NUMBER        DEFAULT 0,
  TOTAL_DED_DAY                     NUMBER        DEFAULT 0,
  PAY_DAY                           NUMBER        DEFAULT 0,
  HOLY_0_DED_FLAG                   VARCHAR2(1)   DEFAULT 'N',
  STD_HOLY_0_COUNT                  NUMBER        DEFAULT 0,
  DESCRIPTION                       VARCHAR2(300) ,
  ATTRIBUTE_A                       VARCHAR2(150) ,
  ATTRIBUTE_B                       VARCHAR2(150) ,
  ATTRIBUTE_C                       VARCHAR2(150) ,
  ATTRIBUTE_D                       VARCHAR2(150) ,
  ATTRIBUTE_E                       VARCHAR2(150) 
) ON COMMIT PRESERVE ROWS;

-- Add comments to the columns 
COMMENT ON TABLE HRD_PERIOD_TOTAL_GT IS '기간별 근태 집계';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.HOLIDAY_IN_COUNT IS '휴일근무횟수';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.LATE_DED_COUNT IS '지각조퇴횟수';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.WEEKLY_DED_COUNT IS '주휴공제일수';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.CHANGE_DED_COUNT IS '교대주휴공제일수-교대조 변경에 따른 주휴공제';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.HOLY_0_COUNT IS '무휴횟수';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.HOLY_1_COUNT IS '유휴횟수';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.HOLY_2_COUNT IS '주간횟수';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.HOLY_3_COUNT IS '야간횟수';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.TOTAL_DAY IS '월 총일수';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.TOTAL_ATT_DAY IS '출근일수';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.TOTAL_DED_DAY IS '총공제일수';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.PAY_DAY IS '급여일수';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.HOLY_0_DED_FLAG IS '무급휴일 공제 여부';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.STD_HOLY_0_COUNT IS '기준 무급휴일수';
COMMENT ON COLUMN HRD_PERIOD_TOTAL_GT.DESCRIPTION IS '비고';


