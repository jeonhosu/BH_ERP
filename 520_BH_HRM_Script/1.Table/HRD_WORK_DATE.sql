/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_WORK_DATE
/* Description  : 해당 기간에 대해 일자를 생성
/*
/* Reference by : TEMPORARY TABLE을 이용하여 처리.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_WORK_DATE
  ( SESSION_ID                                    NUMBER NOT NULL
	, RUN_DATETIME                                  DATE NOT NULL
	, WORK_DATE                                     DATE NOT NULL
  , PERSON_ID                                     NUMBER
	, CORP_ID                                       NUMBER
	, WORK_WEEK                                     VARCHAR2(10)
  , HOLIDAY_CHECK                                 VARCHAR2(2)
	, SOB_ID                                        NUMBER
	, ORG_ID                                        NUMBER
	, N_VALUE1                                      NUMBER
	, N_VALUE2                                      NUMBER
	, N_VALUE3                                      NUMBER
	, N_VALUE4                                      NUMBER
	, N_VALUE5                                      NUMBER
	, V_VALUE1                                      VARCHAR2(100)
	, V_VALUE2                                      VARCHAR2(100)
	, V_VALUE3                                      VARCHAR2(100)
	, V_VALUE4                                      VARCHAR2(100)
	, V_VALUE5                                      VARCHAR2(100)
  ) TABLESPACE FCM_TS_DATA;

CREATE INDEX 	HRD_WORK_DATE_N1 ON HRD_WORK_DATE(WORK_DATE, PERSON_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX 	HRD_WORK_DATE_N2 ON HRD_WORK_DATE(RUN_DATETIME, SESSION_ID) TABLESPACE FCM_TS_IDX;

ANALYZE TABLE HRD_WORK_DATE COMPUTE STATISTICS;
ANALYZE INDEX HRD_WORK_DATE_N1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_WORK_DATE_N2 COMPUTE STATISTICS;
