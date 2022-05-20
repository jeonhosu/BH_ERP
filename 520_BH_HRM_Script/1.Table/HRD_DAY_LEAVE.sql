/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_DAY_LEAVE
/* Description  : 일근태 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_DAY_LEAVE              
( DAY_LEAVE_ID                    NUMBER          NOT NULL,
  PERSON_ID                       NUMBER          NOT NULL,
  WORK_DATE                       DATE            NOT NULL,
  WORK_CORP_ID                    NUMBER          NOT NULL,
	CORP_ID                         NUMBER          NOT NULL,
  DEPT_ID                         NUMBER          ,
  FLOOR_ID                        NUMBER          ,
  POST_ID                         NUMBER          ,
  JOB_CATEGORY_ID                 NUMBER          ,
  DUTY_ID                         NUMBER          NOT NULL,
  HOLY_TYPE                       VARCHAR2(2)     NOT NULL,
  OPEN_TIME                       DATE            ,
  CLOSE_TIME                      DATE            ,
  OPEN_TIME1                      DATE            ,
  CLOSE_TIME1                     DATE            ,
  NEXT_DAY_YN	                    VARCHAR2(1)     DEFAULT 'N',
  DANGJIK_YN	                    VARCHAR2(1)     DEFAULT 'N',
  ALL_NIGHT_YN	                  VARCHAR2(1)     DEFAULT 'N',
  HOLIDAY_CHECK	                  VARCHAR2(1)     DEFAULT 'N',
  WEEKLY_DED_YN                   VARCHAR2(1)     DEFAULT 'N',
  CLOSED_YN	                      VARCHAR2(1)     DEFAULT 'N',
  CLOSED_DATE	                    DATE            ,
  CLOSED_PERSON_ID	              NUMBER          ,
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
	SOB_ID                          NUMBER          NOT NULL,
	ORG_ID                          NUMBER          NOT NULL,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_DAY_LEAVE.DAY_LEAVE_ID IS '일근태 ID';
COMMENT ON COLUMN HRD_DAY_LEAVE.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRD_DAY_LEAVE.WORK_DATE IS '근무일자';
COMMENT ON COLUMN HRD_DAY_LEAVE.WORK_CORP_ID IS '근무 업체ID';
COMMENT ON COLUMN HRD_DAY_LEAVE.CORP_ID IS '소속 업체ID';
COMMENT ON COLUMN HRD_DAY_LEAVE.DEPT_ID IS '부서ID';
COMMENT ON COLUMN HRD_DAY_LEAVE.FLOOR_ID IS '작업장ID';
COMMENT ON COLUMN HRD_DAY_LEAVE.POST_ID IS '직위ID';
COMMENT ON COLUMN HRD_DAY_LEAVE.JOB_CATEGORY_ID IS '직구분ID';
COMMENT ON COLUMN HRD_DAY_LEAVE.DUTY_ID IS '근태ID';
COMMENT ON COLUMN HRD_DAY_LEAVE.HOLY_TYPE IS '근무타입';
COMMENT ON COLUMN HRD_DAY_LEAVE.OPEN_TIME IS '출근일시';
COMMENT ON COLUMN HRD_DAY_LEAVE.CLOSE_TIME IS '퇴근일시';
COMMENT ON COLUMN HRD_DAY_LEAVE.OPEN_TIME1 IS '중출일시';
COMMENT ON COLUMN HRD_DAY_LEAVE.CLOSE_TIME1 IS '중퇴일시';
COMMENT ON COLUMN HRD_DAY_LEAVE.NEXT_DAY_YN IS '후일퇴근 여부';
COMMENT ON COLUMN HRD_DAY_LEAVE.DANGJIK_YN IS '당직구분';
COMMENT ON COLUMN HRD_DAY_LEAVE.ALL_NIGHT_YN IS '철야구분';
COMMENT ON COLUMN HRD_DAY_LEAVE.HOLIDAY_CHECK IS '휴일근무여부';
COMMENT ON COLUMN HRD_DAY_LEAVE.WEEKLY_DED_YN IS '주휴공제 여부';
COMMENT ON COLUMN HRD_DAY_LEAVE.CLOSED_YN IS '마감여부';
COMMENT ON COLUMN HRD_DAY_LEAVE.CLOSED_DATE IS '마감일시';
COMMENT ON COLUMN HRD_DAY_LEAVE.CLOSED_PERSON_ID IS '마감처리자 ID';
COMMENT ON COLUMN HRD_DAY_LEAVE.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRD_DAY_LEAVE.ATTRIBUTE10 IS '교대유형그룹';
COMMENT ON COLUMN HRD_DAY_LEAVE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_DAY_LEAVE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_DAY_LEAVE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_DAY_LEAVE.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_DAY_LEAVE_U1 ON HRD_DAY_LEAVE(DAY_LEAVE_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRD_DAY_LEAVE_U2 ON HRD_DAY_LEAVE(PERSON_ID, WORK_DATE, WORK_CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRD_DAY_LEAVE_U3 ON HRD_DAY_LEAVE(PERSON_ID, WORK_DATE, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
/*DROP SEQUENCE HRD_DAY_LEAVE_S1;
CREATE SEQUENCE HRD_DAY_LEAVE_S1;*/

-- ANALYZE.
ANALYZE TABLE HRD_DAY_LEAVE COMPUTE STATISTICS;
ANALYZE INDEX HRD_DAY_LEAVE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_DAY_LEAVE_U2 COMPUTE STATISTICS;
ANALYZE INDEX HRD_DAY_LEAVE_U3 COMPUTE STATISTICS;
