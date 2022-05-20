/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_HOLIDAY_CALENDAR
/* Description  : ���ϻ��� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_HOLIDAY_CALENDAR              
(WORK_YYYY	                                                VARCHAR2(4) NOT NULL,
  WORK_DATE	                                                DATE NOT NULL,
  HOLIDAY_NAME	                                            VARCHAR2(50),
  ALL_CHECK	                                                VARCHAR2(1) DEFAULT 'N',
  DESCRIPTION                                               VARCHAR2(100),
  ATTRIBUTE1                                                VARCHAR2(100),
  ATTRIBUTE2                                                VARCHAR2(100),
  ATTRIBUTE3                                                VARCHAR2(100),
  ATTRIBUTE4                                                VARCHAR2(100),
  ATTRIBUTE5                                                VARCHAR2(100),
	SOB_ID                                                    NUMBER NOT NULL,
	ORG_ID                                                    NUMBER NOT NULL,
  CREATION_DATE                                             DATE NOT NULL,
  CREATED_BY                                                NUMBER NOT NULL,
  LAST_UPDATE_DATE                                          DATE NOT NULL,
  LAST_UPDATED_BY                                           NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_HOLIDAY_CALENDAR.WORK_YYYY IS '����⵵';
COMMENT ON COLUMN HRD_HOLIDAY_CALENDAR.WORK_DATE IS '��������';
COMMENT ON COLUMN HRD_HOLIDAY_CALENDAR.HOLIDAY_NAME IS '���ϸ�';
COMMENT ON COLUMN HRD_HOLIDAY_CALENDAR.ALL_CHECK IS '��ü����(������ ���� ���� ����)';
COMMENT ON COLUMN HRD_HOLIDAY_CALENDAR.DESCRIPTION IS '���';
COMMENT ON COLUMN HRD_HOLIDAY_CALENDAR.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_HOLIDAY_CALENDAR.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_HOLIDAY_CALENDAR.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_HOLIDAY_CALENDAR.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_HOLIDAY_CALENDAR_U1 ON HRD_HOLIDAY_CALENDAR(WORK_DATE, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_HOLIDAY_CALENDAR_N1 ON HRD_HOLIDAY_CALENDAR(WORK_YYYY) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRD_HOLIDAY_CALENDAR COMPUTE STATISTICS;
ANALYZE INDEX HRD_HOLIDAY_CALENDAR_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_HOLIDAY_CALENDAR_N1 COMPUTE STATISTICS;
