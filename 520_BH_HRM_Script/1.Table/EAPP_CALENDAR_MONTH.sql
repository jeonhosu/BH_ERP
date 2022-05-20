/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : EAPP_CALENDAR_MONTH
/* Description  : 월 정보.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE EAPP_CALENDAR_MONTH
(LANG_CODE                                        VARCHAR2(10) NOT NULL,
  MONTH                                             NUMBER NOT NULL,
  MONTH_STRING                                VARCHAR2(2) NOT NULL,
  FULL_NAME                                       VARCHAR2(100),
  SHORT_NAME                                    VARCHAR2(50)
)
TABLESPACE EAPP_TS_DATA;

-- COMMENT.
COMMENT ON COLUMN EAPP_CALENDAR_MONTH.LANG_CODE IS '언어코드';
COMMENT ON COLUMN EAPP_CALENDAR_MONTH.MONTH IS '월(숫자)';
COMMENT ON COLUMN EAPP_CALENDAR_MONTH.MONTH_STRING IS '월(문자)';
COMMENT ON COLUMN EAPP_CALENDAR_MONTH.FULL_NAME IS '명칭';
COMMENT ON COLUMN EAPP_CALENDAR_MONTH.SHORT_NAME IS '약칭';

-- INDEX.
CREATE UNIQUE INDEX EAPP_CALENDAR_MONTH_U1 ON EAPP_CALENDAR_MONTH(LANG_CODE, MONTH) TABLESPACE EAPP_TS_IDX;
CREATE UNIQUE INDEX EAPP_CALENDAR_MONTH_N1 ON EAPP_CALENDAR_MONTH(LANG_CODE, MONTH_STRING) TABLESPACE EAPP_TS_IDX;


-- ANALALYZE.
ANALYZE TABLE EAPP_CALENDAR_MONTH COMPUTE STATISTICS;
ANALYZE INDEX EAPP_CALENDAR_MONTH_U1 COMPUTE STATISTICS;
ANALYZE INDEX EAPP_CALENDAR_MONTH_N1 COMPUTE STATISTICS;
