/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM - GL
/* Program Name : GL_FISCAL_CALENDAR
/* Description  : ȸ��޷� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE GL_FISCAL_CALENDAR              
( FISCAL_CALENDAR_ID                              NUMBER NOT NULL,
  FISCAL_CALENDAR_CODE                            VARCHAR2(50) NOT NULL,
  FISCAL_CALENDAR_NAME                            VARCHAR2(100) NOT NULL,
  SOB_ID                                          NUMBER NOT NULL,
  ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE GL_FISCAL_CALENDAR IS 'ȸ��޷�';
COMMENT ON COLUMN GL_FISCAL_CALENDAR.FISCAL_CALENDAR_ID IS 'ȸ��޷� ID';
COMMENT ON COLUMN GL_FISCAL_CALENDAR.FISCAL_CALENDAR_CODE IS 'ȸ��޷� ID';
COMMENT ON COLUMN GL_FISCAL_CALENDAR.FISCAL_CALENDAR_NAME IS 'ȸ��޷¸�';
COMMENT ON COLUMN GL_FISCAL_CALENDAR.SOB_ID IS 'ȸ������';
COMMENT ON COLUMN GL_FISCAL_CALENDAR.ORG_ID IS '�����ID';
COMMENT ON COLUMN GL_FISCAL_CALENDAR.CREATION_DATE  IS '��������';
COMMENT ON COLUMN GL_FISCAL_CALENDAR.CREATED_BY IS '������';
COMMENT ON COLUMN GL_FISCAL_CALENDAR.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN GL_FISCAL_CALENDAR.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX GL_FISCAL_CALENDAR_U1 ON GL_FISCAL_CALENDAR(FISCAL_CALENDAR_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX GL_FISCAL_CALENDAR_U2 ON GL_FISCAL_CALENDAR(FISCAL_CALENDAR_CODE, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE GL_FISCAL_CALENDAR COMPUTE STATISTICS;
ANALYZE INDEX GL_FISCAL_CALENDAR_U1 COMPUTE STATISTICS;
ANALYZE INDEX GL_FISCAL_CALENDAR_U2 COMPUTE STATISTICS;
