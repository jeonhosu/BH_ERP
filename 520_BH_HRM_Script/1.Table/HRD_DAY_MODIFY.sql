/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_DAY_MODIFY
/* Description  : ����� ���� �ð� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_DAY_MODIFY              
( PERSON_ID                                       NUMBER NOT NULL,
  WORK_DATE                                       DATE NOT NULL,  
  IO_FLAG	                                        VARCHAR2(1) NOT NULL,
  MODIFY_TIME	                                    DATE,
  MODIFY_TIME1	                                  DATE,	
  MODIFY_ID	                                      NUMBER NOT NULL,
  DESCRIPTION                                     VARCHAR2(100),
  ATTRIBUTE1                                      VARCHAR2(100),
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_DAY_MODIFY.PERSON_ID IS '�����ȣ';
COMMENT ON COLUMN HRD_DAY_MODIFY.WORK_DATE IS '�ٹ�����';
COMMENT ON COLUMN HRD_DAY_MODIFY.IO_FLAG IS '���𱸺�';
COMMENT ON COLUMN HRD_DAY_MODIFY.MODIFY_TIME IS '�����ð�1';
COMMENT ON COLUMN HRD_DAY_MODIFY.MODIFY_TIME1 IS '�����ð�2';
COMMENT ON COLUMN HRD_DAY_MODIFY.MODIFY_ID IS '��������ID';
COMMENT ON COLUMN HRD_DAY_MODIFY.DESCRIPTION IS '���';
COMMENT ON COLUMN HRD_DAY_MODIFY.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_DAY_MODIFY.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_DAY_MODIFY.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_DAY_MODIFY.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_DAY_MODIFY_U1 ON HRD_DAY_MODIFY(PERSON_ID, WORK_DATE, IO_FLAG) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRD_DAY_MODIFY COMPUTE STATISTICS;
ANALYZE INDEX HRD_DAY_MODIFY_U1 COMPUTE STATISTICS;
