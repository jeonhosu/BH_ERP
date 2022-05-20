/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_FOREIGN_LANGUAGE
/* Description  : �ܱ��� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_FOREIGN_LANGUAGE              
( PERSON_ID                       NUMBER NOT NULL,
  LANGUAGE_ID                     NUMBER NOT NULL,
  EXAM_DATE	                      DATE   NOT NULL,
  EXAM_ID	                        NUMBER NOT NULL,
  EXAM_ORG_NAME                   VARCHAR2(100),
  LC	                            NUMBER DEFAULT 0,
  WC                              NUMBER DEFAULT 0,
  RC	                            NUMBER DEFAULT 0,
  SC                              NUMBER DEFAULT 0,
  SCORE	                          NUMBER DEFAULT 0,
  EXAM_LEVEL                      VARCHAR2(20),
  DESCRIPTION                     VARCHAR2(100),
  ATTRIBUTE1                      VARCHAR2(100),
  ATTRIBUTE2                      VARCHAR2(100),
  ATTRIBUTE3                      VARCHAR2(100),
  ATTRIBUTE4                      VARCHAR2(100),
  ATTRIBUTE5                      VARCHAR2(100),
  CREATION_DATE                   DATE NOT NULL,
  CREATED_BY                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                DATE NOT NULL,
  LAST_UPDATED_BY                 NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRM_FOREIGN_LANGUAGE IS '���л��� ����';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.LANGUAGE_ID IS '����ID';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.EXAM_DATE IS '��������';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.EXAM_ID IS '����/���� ����';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.EXAM_ORG_NAME IS '�� ���';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.LC IS '��� ����';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.WC IS '���� ����';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.RC IS '�б� ����';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.SC IS '���ϱ� ����';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.SCORE IS '����';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.EXAM_LEVEL IS '���� ���';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.DESCRIPTION IS '���';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.CREATED_BY IS '������';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_FOREIGN_LANGUAGE_U1 ON HRM_FOREIGN_LANGUAGE(PERSON_ID, LANGUAGE_ID, EXAM_DATE) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRM_FOREIGN_LANGUAGE COMPUTE STATISTICS;
ANALYZE INDEX HRM_FOREIGN_LANGUAGE_U1 COMPUTE STATISTICS;
