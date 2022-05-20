/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_WORK_CALENDAR
/* Description  : �ٹ���ȹ ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_WORK_CALENDAR              
( WORK_DATE	                                      DATE NOT NULL,
  PERSON_ID	                                      NUMBER NOT NULL,
  WORK_CORP_ID                                    NUMBER NOT NULL,
	CORP_ID                                         NUMBER NOT NULL,
  WORK_YYYYMM                                     VARCHAR2(7),
  WORK_WEEK	                                      VARCHAR2(2),
  WORK_TYPE_ID                                    NUMBER,
  DUTY_ID	                                        NUMBER,
  C_DUTY_ID	                                      NUMBER,
  C_DUTY_ID1                                      NUMBER,
  HOLY_TYPE	                                      VARCHAR2(2),
  OPEN_TIME	                                      DATE,
  CLOSE_TIME	                                    DATE,	
  OLD_OPEN_TIME	                                  DATE,	
  OLD_CLOSE_TIME	                                DATE,
  BEFORE_OT_START	                                DATE,
  BEFORE_OT_END	                                  DATE,
  AFTER_OT_START	                                DATE,
  AFTER_OT_END	                                  DATE,
  LUNCH_YN	                                      VARCHAR2(1) DEFAULT 'N',
  DINNER_YN	                                      VARCHAR2(1) DEFAULT 'N',
  MIDNIGHT_YN	                                    VARCHAR2(1) DEFAULT 'N',
  DANGJIK_YN	                                    VARCHAR2(1) DEFAULT 'N',
  ALL_NIGHT_YN	                                  VARCHAR2(1) DEFAULT 'N',
  DESCRIPTION                                     VARCHAR2(100),
  ATTRIBUTE1                                      VARCHAR2(100),
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
	SOB_ID                                          NUMBER NOT NULL,
	ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL,
  LATE_IN_FR	                                    DATE,
  LATE_IN_TO	                                    DATE,
  EARLY_OUT_FR	                                  DATE,
  EARLY_OUT_TO	                                  DATE,
  SHORT_OUT_FR	                                  DATE,
  SHORT_OUT_TO	                                  DATE,
  WORK_OUT_FR	                                    DATE,
  WORK_OUT_TO	                                    DATE  
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_WORK_CALENDAR.WORK_DATE IS '�ٹ�����';
COMMENT ON COLUMN HRD_WORK_CALENDAR.PERSON_ID IS '�����ȣ';
COMMENT ON COLUMN HRD_WORK_CALENDAR.WORK_CORP_ID IS '�ٹ� ��üID';
COMMENT ON COLUMN HRD_WORK_CALENDAR.CORP_ID IS '�Ҽ� ��üID';
COMMENT ON COLUMN HRD_WORK_CALENDAR.WORK_YYYYMM IS '������ ���';
COMMENT ON COLUMN HRD_WORK_CALENDAR.WORK_WEEK IS '����';
COMMENT ON COLUMN HRD_WORK_CALENDAR.WORK_TYPE_ID IS '�ٹ�����ID';
COMMENT ON COLUMN HRD_WORK_CALENDAR.DUTY_ID IS '����ID';
COMMENT ON COLUMN HRD_WORK_CALENDAR.C_DUTY_ID IS '���� ����ID1';
COMMENT ON COLUMN HRD_WORK_CALENDAR.C_DUTY_ID1 IS '���� ����ID2';
COMMENT ON COLUMN HRD_WORK_CALENDAR.HOLY_TYPE IS '�ٹ�����';
COMMENT ON COLUMN HRD_WORK_CALENDAR.OPEN_TIME IS '����Ͻ�';
COMMENT ON COLUMN HRD_WORK_CALENDAR.CLOSE_TIME IS '����Ͻ�';
COMMENT ON COLUMN HRD_WORK_CALENDAR.OLD_OPEN_TIME IS '������ ����Ͻ�';
COMMENT ON COLUMN HRD_WORK_CALENDAR.OLD_CLOSE_TIME IS '������ ����Ͻ�';
COMMENT ON COLUMN HRD_WORK_CALENDAR.BEFORE_OT_START IS '�ٹ��� ���� ���۽ð�';
COMMENT ON COLUMN HRD_WORK_CALENDAR.BEFORE_OT_END IS '�ٹ��� ���� ����ð�';
COMMENT ON COLUMN HRD_WORK_CALENDAR.AFTER_OT_START IS '�ٹ��� ���� ���۽ð�';
COMMENT ON COLUMN HRD_WORK_CALENDAR.AFTER_OT_END IS '�ٹ��� ���� ����ð�';
COMMENT ON COLUMN HRD_WORK_CALENDAR.OUTING_START IS '���� ���۽ð�';
COMMENT ON COLUMN HRD_WORK_CALENDAR.OUTING_END IS '���� ����ð�';
COMMENT ON COLUMN HRD_WORK_CALENDAR.LUNCH_YN IS '�߽Ŀ��� ����';
COMMENT ON COLUMN HRD_WORK_CALENDAR.DINNER_YN IS '���Ŀ��� ����';
COMMENT ON COLUMN HRD_WORK_CALENDAR.MIDNIGHT_YN IS '�߽Ŀ��� ����';
COMMENT ON COLUMN HRD_WORK_CALENDAR.DANGJIK_YN IS '���� ����';
COMMENT ON COLUMN HRD_WORK_CALENDAR.ALL_NIGHT_YN IS 'ö�� ����';
COMMENT ON COLUMN HRD_WORK_CALENDAR.DESCRIPTION IS '���';
COMMENT ON COLUMN HRD_WORK_CALENDAR.ATTRIBUTE5 IS '�������� TYPE';
COMMENT ON COLUMN HRD_WORK_CALENDAR.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_WORK_CALENDAR.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_WORK_CALENDAR.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_WORK_CALENDAR.LAST_UPDATED_BY IS '����������';
COMMENT ON COLUMN HRD_WORK_CALENDAR.LATE_IN_FR IS '���� ���۽ð�';
COMMENT ON COLUMN HRD_WORK_CALENDAR.LATE_IN_TO IS '���� ����ð�';
COMMENT ON COLUMN HRD_WORK_CALENDAR.EARLY_OUT_FR IS '���� ���۽ð�';
COMMENT ON COLUMN HRD_WORK_CALENDAR.EARLY_OUT_TO IS '���� ����ð�';
COMMENT ON COLUMN HRD_WORK_CALENDAR.SHORT_OUT_FR IS '���� ���۽ð�';
COMMENT ON COLUMN HRD_WORK_CALENDAR.SHORT_OUT_TO IS '���� ����ð�';
COMMENT ON COLUMN HRD_WORK_CALENDAR.WORK_OUT_FR IS '�ܱ� ���۽ð�';
COMMENT ON COLUMN HRD_WORK_CALENDAR.WORK_OUT_TO IS '�ܱ� ����ð�';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_WORK_CALENDAR_U1 ON HRD_WORK_CALENDAR(WORK_DATE, PERSON_ID, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_WORK_CALENDAR_N1 ON HRD_WORK_CALENDAR(WORK_DATE, PERSON_ID, WORK_CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_WORK_CALENDAR_N2 ON HRD_WORK_CALENDAR(WORK_YYYYMM, PERSON_ID, WORK_CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
-- ANALYZE.
ANALYZE TABLE HRD_WORK_CALENDAR COMPUTE STATISTICS;
ANALYZE INDEX HRD_WORK_CALENDAR_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_WORK_CALENDAR_N1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_WORK_CALENDAR_N2 COMPUTE STATISTICS;
