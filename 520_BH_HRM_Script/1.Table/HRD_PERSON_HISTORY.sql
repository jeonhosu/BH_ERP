/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_PERSON_HISTORY
/* Description  : ���κ� �۾���/�������� ���� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_PERSON_HISTORY              
( CORP_ID                         NUMBER          NOT NULL,     -- ��üID.
  PERSON_ID                       NUMBER          NOT NULL,     -- ���ID.
  EFFECTIVE_DATE_FR               DATE            NOT NULL,     -- ���� ��������.
  EFFECTIVE_DATE_TO               DATE            NOT NULL,     -- ���� ��������.
  SOB_ID                          NUMBER          NOT NULL,     -- SOB ID.
  ORG_ID                          NUMBER          NOT NULL,     -- ORG ID.
  FLOOR_ID                        NUMBER          ,             -- ������ �۾���ID.
  WORK_TYPE_ID                    NUMBER          ,             -- ������ ��������ID.
  PRE_FLOOR_ID                    NUMBER          ,             -- ������ �۾���ID.
  PRE_WORK_TYPE_ID                NUMBER          ,             -- ������ ��������ID.
  DESCRIPTION                     VARCHAR2(200)   ,             -- ���.
  LAST_YN                         CHAR(1)         DEFAULT 'Y',  -- ��������.
  ATTRIBUTE_A                     VARCHAR2(200)   ,
  ATTRIBUTE_B                     VARCHAR2(200)   ,
  ATTRIBUTE_C                     VARCHAR2(200)   ,
  ATTRIBUTE_D                     VARCHAR2(200)   ,
  ATTRIBUTE_E                     VARCHAR2(200)   ,
  ATTRIBUTE_1                     NUMBER          ,
  ATTRIBUTE_2                     NUMBER          ,
  ATTRIBUTE_3                     NUMBER          ,
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRD_PERSON_HISTORY IS '���κ� �۾���/�������� ���� ����';
COMMENT ON COLUMN HRD_PERSON_HISTORY.CORP_ID IS '��üID';
COMMENT ON COLUMN HRD_PERSON_HISTORY.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR IS '��ȿ ��������';
COMMENT ON COLUMN HRD_PERSON_HISTORY.EFFECTIVE_DATE_TO IS '��ȿ ��������';
COMMENT ON COLUMN HRD_PERSON_HISTORY.FLOOR_ID IS '������ �۾���ID';
COMMENT ON COLUMN HRD_PERSON_HISTORY.WORK_TYPE_ID IS '�����ı�������ID';
COMMENT ON COLUMN HRD_PERSON_HISTORY.PRE_FLOOR_ID IS '������ �۾���ID';
COMMENT ON COLUMN HRD_PERSON_HISTORY.PRE_WORK_TYPE_ID IS '������ ��������ID';
COMMENT ON COLUMN HRD_PERSON_HISTORY.LAST_YN IS '��������';
COMMENT ON COLUMN HRD_PERSON_HISTORY.DESCRIPTION IS '���';
COMMENT ON COLUMN HRD_PERSON_HISTORY.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_PERSON_HISTORY.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_PERSON_HISTORY.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_PERSON_HISTORY.LAST_UPDATED_BY IS '����������';

ALTER TABLE HRD_PERSON_HISTORY ADD CONSTRAINT HRD_PERSON_HISTORY_PK PRIMARY KEY (CORP_ID, PERSON_ID, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO, SOB_ID, ORG_ID);

-- CREATE INDEX.
CREATE INDEX HRD_PERSON_HISTORY_N1 ON HRD_PERSON_HISTORY(CORP_ID, PERSON_ID, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO, LAST_YN, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRD_PERSON_HISTORY COMPUTE STATISTICS;
ANALYZE INDEX HRD_PERSON_HISTORY_N1 COMPUTE STATISTICS;
