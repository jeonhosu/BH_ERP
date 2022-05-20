/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : EAPP_CALENDAR_YEAR
/* Description  : 년도 정보 관ㄹ..
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE EAPP_CALENDAR_YEAR
(
  YEAR                                                              NUMBER,
  YEAR_STRING                                                 CHAR(4)
)
TABLESPACE EAPP_TS_DATA;

-- COMMENT.
COMMENT ON COLUMN EAPP_CALENDAR_YEAR.YEAR IS '년도';
COMMENT ON COLUMN EAPP_CALENDAR_YEAR.YEAR_STRING IS '년도(문자)';


-- INDEX.
CREATE UNIQUE INDEX EAPP_CALENDAR_YEAR_U1 ON EAPP_CALENDAR_YEAR(YEAR) TABLESPACE EAPP_TS_IDX;
CREATE UNIQUE INDEX EAPP_CALENDAR_YEAR_N1 ON EAPP_CALENDAR_YEAR(YEAR_STRING) TABLESPACE EAPP_TS_IDX;

-- ANALYZE .
ANALYZE TABLE EAPP_CALENDAR_YEAR COMPUTE STATISTICS;
ANALYZE INDEX EAPP_CALENDAR_YEAR_U1 COMPUTE STATISTICS;
ANALYZE INDEX EAPP_CALENDAR_YEAR_N1 COMPUTE STATISTICS;
