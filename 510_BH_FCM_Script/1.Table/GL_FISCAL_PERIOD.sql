/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM - GL
/* Program Name : GL_FISCAL_PERIOD
/* Description  : ȸ��Ⱓ ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE GL_FISCAL_PERIOD              
( PERIOD_NAME                                     VARCHAR2(10) NOT NULL,
  FISCAL_CALENDAR_ID                              NUMBER NOT NULL,
  FISCAL_YEAR_ID                                  NUMBER NOT NULL,  
  PERIOD_STATUS                                   VARCHAR2(1) DEFAULT 'N',
  START_DATE                                      DATE NOT NULL,
  END_DATE                                        DATE NOT NULL,
  QUARTER_NUM                                     NUMBER NOT NULL,
  HALF_NUM                                        NUMBER NOT NULL,
  PERIOD_TYPE                                     VARCHAR2(50),
  PERIOD_YEAR                                     VARCHAR2(4),
  PERIOD_NUM                                      NUMBER,
  ADJUSTMENT_PERIOD_FLAG                          VARCHAR2(1) DEFAULT 'N',
  SOB_ID                                          NUMBER NOT NULL,
  ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT TABLE GL_FISCAL_PERIOD IS 'ȸ��Ⱓ ����';
COMMENT ON COLUMN GL_FISCAL_PERIOD.PERIOD_NAME IS 'ȸ��Ⱓ��';
COMMENT ON COLUMN GL_FISCAL_PERIOD.FISCAL_CALENDAR_ID IS 'ȸ��޷� ID';
COMMENT ON COLUMN GL_FISCAL_PERIOD.FISCAL_YEAR_ID IS 'ȸ�迬�� ID';
COMMENT ON COLUMN GL_FISCAL_PERIOD.PERIOD_STATUS IS '����';
COMMENT ON COLUMN GL_FISCAL_PERIOD.START_DATE IS 'ȸ��Ⱓ ��������';
COMMENT ON COLUMN GL_FISCAL_PERIOD.END_DATE IS 'ȸ��Ⱓ ��������';
COMMENT ON COLUMN GL_FISCAL_PERIOD.QUARTER_NUM IS '�б�';
COMMENT ON COLUMN GL_FISCAL_PERIOD.HALF_NUM IS '�ݱ�';
COMMENT ON COLUMN GL_FISCAL_PERIOD.PERIOD_TYPE IS 'ȸ��Ⱓ Ÿ��';
COMMENT ON COLUMN GL_FISCAL_PERIOD.PERIOD_YEAR IS 'ȸ�� �⵵';
COMMENT ON COLUMN GL_FISCAL_PERIOD.PERIOD_NUM IS '��';
COMMENT ON COLUMN GL_FISCAL_PERIOD.ADJUSTMENT_PERIOD_FLAG IS '���� ȸ��Ⱓ FLAG';
COMMENT ON COLUMN GL_FISCAL_PERIOD.SOB_ID IS 'ȸ������';
COMMENT ON COLUMN GL_FISCAL_PERIOD.CREATION_DATE  IS '��������';
COMMENT ON COLUMN GL_FISCAL_PERIOD.CREATED_BY IS '������';
COMMENT ON COLUMN GL_FISCAL_PERIOD.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN GL_FISCAL_PERIOD.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX GL_FISCAL_PERIOD_U1 ON GL_FISCAL_PERIOD(PERIOD_NAME, FISCAL_CALENDAR_ID, FISCAL_YEAR_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX GL_FISCAL_PERIOD_N1 ON GL_FISCAL_PERIOD(FISCAL_CALENDAR_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE GL_FISCAL_PERIOD COMPUTE STATISTICS;
ANALYZE INDEX GL_FISCAL_PERIOD_U1 COMPUTE STATISTICS;
