/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_SCHOLARSHIP
/* Description  : �з»��� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_SCHOLARSHIP              
(SCHOLARSHIP_ID	                            NUMBER NOT NULL,
  PERSON_ID                                      NUMBER NOT NULL,
  SCHOLARSHIP_TYPE_ID                   NUMBER,
  GRADUATION_TYPE_ID                    NUMBER,
  ADMISSION_DATE	                          DATE,	
  GRADUATION_DATE	                        DATE,	
  SCHOOL_NAME	                              VARCHAR2(100),
  SPECIAL_STUDY_NAME	                  VARCHAR2(100),
  SUB_STUDY_NAME	                        VARCHAR2(100),
  DEGREE_ID                                       NUMBER,
  DESCRIPTION                               VARCHAR2(100),
  ATTRIBUTE1                                    VARCHAR2(100),
  ATTRIBUTE2                                    VARCHAR2(100),
  ATTRIBUTE3                                    VARCHAR2(100),
  ATTRIBUTE4                                    VARCHAR2(100),
  ATTRIBUTE5                                    VARCHAR2(100),
  CREATION_DATE                             DATE NOT NULL,
  CREATED_BY                                  NUMBER NOT NULL,
  LAST_UPDATE_DATE                       DATE NOT NULL,
  LAST_UPDATED_BY                         NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_SCHOLARSHIP.SCHOLARSHIP_ID IS '�з»��� ID';
COMMENT ON COLUMN HRM_SCHOLARSHIP.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRM_SCHOLARSHIP.SCHOLARSHIP_TYPE_ID IS '�з�Ÿ�� ID';
COMMENT ON COLUMN HRM_SCHOLARSHIP.GRADUATION_TYPE_ID IS '�������� ID';
COMMENT ON COLUMN HRM_SCHOLARSHIP.ADMISSION_DATE IS '��������';
COMMENT ON COLUMN HRM_SCHOLARSHIP.GRADUATION_DATE IS '��������';
COMMENT ON COLUMN HRM_SCHOLARSHIP.SCHOOL_NAME IS '�б���';
COMMENT ON COLUMN HRM_SCHOLARSHIP.SPECIAL_STUDY_NAME IS '����';
COMMENT ON COLUMN HRM_SCHOLARSHIP.SUB_STUDY_NAME IS '������';
COMMENT ON COLUMN HRM_SCHOLARSHIP.DEGREE_ID IS '���� ID';
COMMENT ON COLUMN HRM_SCHOLARSHIP.DESCRIPTION IS '���';
COMMENT ON COLUMN HRM_SCHOLARSHIP.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRM_SCHOLARSHIP.CREATED_BY IS '������';
COMMENT ON COLUMN HRM_SCHOLARSHIP.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRM_SCHOLARSHIP.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_SCHOLARSHIP_U1 ON HRM_SCHOLARSHIP(SCHOLARSHIP_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRM_SCHOLARSHIP_N1 ON HRM_SCHOLARSHIP(PERSON_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE;
DROP SEQUENCE HRM_SCHOLARSHIP_S1;
CREATE SEQUENCE HRM_SCHOLARSHIP_S1;

-- ANALYZE.
ANALYZE TABLE HRM_SCHOLARSHIP COMPUTE STATISTICS;
ANALYZE INDEX HRM_SCHOLARSHIP_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_SCHOLARSHIP_N1 COMPUTE STATISTICS;
