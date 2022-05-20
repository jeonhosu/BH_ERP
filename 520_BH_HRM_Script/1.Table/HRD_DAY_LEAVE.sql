/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_DAY_LEAVE
/* Description  : �ϱ��� ����
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
COMMENT ON COLUMN HRD_DAY_LEAVE.DAY_LEAVE_ID IS '�ϱ��� ID';
COMMENT ON COLUMN HRD_DAY_LEAVE.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRD_DAY_LEAVE.WORK_DATE IS '�ٹ�����';
COMMENT ON COLUMN HRD_DAY_LEAVE.WORK_CORP_ID IS '�ٹ� ��üID';
COMMENT ON COLUMN HRD_DAY_LEAVE.CORP_ID IS '�Ҽ� ��üID';
COMMENT ON COLUMN HRD_DAY_LEAVE.DEPT_ID IS '�μ�ID';
COMMENT ON COLUMN HRD_DAY_LEAVE.FLOOR_ID IS '�۾���ID';
COMMENT ON COLUMN HRD_DAY_LEAVE.POST_ID IS '����ID';
COMMENT ON COLUMN HRD_DAY_LEAVE.JOB_CATEGORY_ID IS '������ID';
COMMENT ON COLUMN HRD_DAY_LEAVE.DUTY_ID IS '����ID';
COMMENT ON COLUMN HRD_DAY_LEAVE.HOLY_TYPE IS '�ٹ�Ÿ��';
COMMENT ON COLUMN HRD_DAY_LEAVE.OPEN_TIME IS '����Ͻ�';
COMMENT ON COLUMN HRD_DAY_LEAVE.CLOSE_TIME IS '����Ͻ�';
COMMENT ON COLUMN HRD_DAY_LEAVE.OPEN_TIME1 IS '�����Ͻ�';
COMMENT ON COLUMN HRD_DAY_LEAVE.CLOSE_TIME1 IS '�����Ͻ�';
COMMENT ON COLUMN HRD_DAY_LEAVE.NEXT_DAY_YN IS '������� ����';
COMMENT ON COLUMN HRD_DAY_LEAVE.DANGJIK_YN IS '��������';
COMMENT ON COLUMN HRD_DAY_LEAVE.ALL_NIGHT_YN IS 'ö�߱���';
COMMENT ON COLUMN HRD_DAY_LEAVE.HOLIDAY_CHECK IS '���ϱٹ�����';
COMMENT ON COLUMN HRD_DAY_LEAVE.WEEKLY_DED_YN IS '���ް��� ����';
COMMENT ON COLUMN HRD_DAY_LEAVE.CLOSED_YN IS '��������';
COMMENT ON COLUMN HRD_DAY_LEAVE.CLOSED_DATE IS '�����Ͻ�';
COMMENT ON COLUMN HRD_DAY_LEAVE.CLOSED_PERSON_ID IS '����ó���� ID';
COMMENT ON COLUMN HRD_DAY_LEAVE.DESCRIPTION IS '���';
COMMENT ON COLUMN HRD_DAY_LEAVE.ATTRIBUTE10 IS '���������׷�';
COMMENT ON COLUMN HRD_DAY_LEAVE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_DAY_LEAVE.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_DAY_LEAVE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_DAY_LEAVE.LAST_UPDATED_BY IS '����������';

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
