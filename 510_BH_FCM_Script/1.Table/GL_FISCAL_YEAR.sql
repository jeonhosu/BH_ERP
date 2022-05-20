/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM - GL
/* Program Name : GL_FISCAL_YEAR
/* Description  : ȸ�迬�� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE GL_FISCAL_YEAR              
( FISCAL_YEAR_ID                                  NUMBER NOT NULL,
  FISCAL_CALENDAR_ID                              NUMBER NOT NULL,
  FISCAL_COUNT                                    NUMBER NOT NULL,
  FISCAL_YEAR                                     VARCHAR2(50) NOT NULL,
  START_DATE                                      DATE NOT NULL,
  END_DATE                                        DATE NOT NULL,
  SOB_ID                                          NUMBER NOT NULL,
  ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE GL_FISCAL_YEAR IS 'ȸ�迬�� ����';
COMMENT ON COLUMN GL_FISCAL_YEAR.FISCAL_YEAR_ID IS 'ȸ�迬�� ID';
COMMENT ON COLUMN GL_FISCAL_YEAR.FISCAL_CALENDAR_ID IS 'ȸ��޷� ID';
COMMENT ON COLUMN GL_FISCAL_YEAR.FISCAL_COUNT IS 'ȸ����';
COMMENT ON COLUMN GL_FISCAL_YEAR.FISCAL_YEAR IS 'ȸ��⵵';
COMMENT ON COLUMN GL_FISCAL_YEAR.START_DATE IS 'ȸ��⵵ ��������';
COMMENT ON COLUMN GL_FISCAL_YEAR.END_DATE IS 'ȸ��⵵ ��������';
COMMENT ON COLUMN GL_FISCAL_YEAR.SOB_ID IS 'ȸ������';
COMMENT ON COLUMN GL_FISCAL_YEAR.CREATION_DATE  IS '��������';
COMMENT ON COLUMN GL_FISCAL_YEAR.CREATED_BY IS '������';
COMMENT ON COLUMN GL_FISCAL_YEAR.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN GL_FISCAL_YEAR.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX GL_FISCAL_YEAR_U1 ON GL_FISCAL_YEAR(FISCAL_YEAR_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX GL_FISCAL_YEAR_U2 ON GL_FISCAL_YEAR(FISCAL_CALENDAR_ID, FISCAL_YEAR, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE GL_FISCAL_YEAR_S1;
CREATE SEQUENCE GL_FISCAL_YEAR_S1;

-- ANALYZE.
ANALYZE TABLE GL_FISCAL_YEAR COMPUTE STATISTICS;
ANALYZE INDEX GL_FISCAL_YEAR_U1 COMPUTE STATISTICS;
ANALYZE INDEX GL_FISCAL_YEAR_U2 COMPUTE STATISTICS;
