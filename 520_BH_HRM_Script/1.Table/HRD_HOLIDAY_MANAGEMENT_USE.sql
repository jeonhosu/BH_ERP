/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_HOLIDAY_MANAGEMENT_USE
/* Description  : ����/����/Ư���ް� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_HOLIDAY_MANAGEMENT_USE
( CORP_ID                             NUMBER      NOT NULL,
  PERSON_ID                           NUMBER      NOT NULL,
  HOLIDAY_TYPE                        VARCHAR2(2) NOT NULL,
  DUTY_YEAR                           VARCHAR2(4) NOT NULL,
  PRE_NEXT_NUM                        NUMBER      DEFAULT 0,
  CREATION_NUM                        NUMBER      DEFAULT 0,
  PLUS_NUM                            NUMBER      DEFAULT 0,
  USE_NUM                             NUMBER      DEFAULT 0,
  SOB_ID                              NUMBER      NOT NULL,
  ORG_ID                              NUMBER      NOT NULL,
  CREATION_DATE                       DATE        NOT NULL,
  CREATED_BY                          NUMBER      NOT NULL,
  LAST_UPDATE_DATE                    DATE        NOT NULL,
  LAST_UPDATED_BY                     NUMBER      NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.CORP_ID IS '��üID';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.HOLIDAY_TYPE IS '�ް�Ÿ��(1-����, 2-����, 3-Ư���ް�)';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.DUTY_YEAR IS '���³⵵';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.PRE_NEXT_NUM IS '���� �̿���';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.CREATION_NUM IS '�߻� �ް���';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.PLUS_NUM IS '�߰� �߻���';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.USE_NUM IS '����';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_HOLIDAY_MANAGEMENT_USE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_HOLIDAY_MANAGEMENT_USE_U1 ON HRD_HOLIDAY_MANAGEMENT_USE(CORP_ID, PERSON_ID, HOLIDAY_TYPE, DUTY_YEAR, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRD_HOLIDAY_MANAGEMENT_USE COMPUTE STATISTICS;
ANALYZE INDEX HRD_HOLIDAY_MANAGEMENT_USE_U1 COMPUTE STATISTICS;
