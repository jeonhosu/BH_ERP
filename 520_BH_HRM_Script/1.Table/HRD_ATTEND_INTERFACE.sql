/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_ATTEND_INTERFACE
/* Description  : ����� interface ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_ATTEND_INTERFACE              
( DEVICE_ID	                                      NUMBER NOT NULL,
  PERSON_ID	                                      NUMBER NOT NULL,
  IO_FLAG	                                        VARCHAR2(1) NOT NULL,
  IO_DATETIME	                                    DATE NOT NULL,
  IO_DATE	                                        DATE NOT NULL,
  IO_TIME	                                        VARCHAR2(5) NOT NULL,
  CREATED_FLAG	                                  VARCHAR2(2),
	CARD_NUM                                        VARCHAR2(50),
  SOB_ID                                          NUMBER NOT NULL,
  ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRD_ATTEND_INTERFACE.DEVICE_ID IS '��ġID';
COMMENT ON COLUMN HRD_ATTEND_INTERFACE.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRD_ATTEND_INTERFACE.IO_FLAG IS '���𱸺�';
COMMENT ON COLUMN HRD_ATTEND_INTERFACE.IO_DATETIME IS '�����Ͻ�';
COMMENT ON COLUMN HRD_ATTEND_INTERFACE.IO_DATE IS '���������';
COMMENT ON COLUMN HRD_ATTEND_INTERFACE.IO_TIME IS '����ٽð�';
COMMENT ON COLUMN HRD_ATTEND_INTERFACE.CREATED_FLAG IS '��������';
COMMENT ON COLUMN HRD_ATTEND_INTERFACE.CARD_NUM IS 'ī���ȣ';
COMMENT ON COLUMN HRD_ATTEND_INTERFACE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRD_ATTEND_INTERFACE.CREATED_BY IS '������';
COMMENT ON COLUMN HRD_ATTEND_INTERFACE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRD_ATTEND_INTERFACE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRD_ATTEND_INTERFACE_U1 ON HRD_ATTEND_INTERFACE(DEVICE_ID, PERSON_ID, IO_FLAG, IO_DATETIME, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRD_ATTEND_INTERFACE_N1 ON HRD_ATTEND_INTERFACE(PERSON_ID, IO_DATE, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRD_ATTEND_INTERFACE COMPUTE STATISTICS;
ANALYZE INDEX HRD_ATTEND_INTERFACE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRD_ATTEND_INTERFACE_N1 COMPUTE STATISTICS;
