/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRF_FOOD_VISITOR_TIME
/* Description  : �湮�� �Ļ�ð� �� ��üũ �ð� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRF_FOOD_VISITOR_TIME              
( VISITOR_ID                                     NUMBER NOT NULL,
  FOOD_DATE                                      DATE NOT NULL,
  FOOD_VISITOR_ID                                NUMBER NOT NULL,
  FOOD_FLAG                                      VARCHAR2(1) NOT NULL,
  DEVICE_ID                                      NUMBER,
  FOOD_DATETIME                                  DATE,
  CREATED_FLAG                                   VARCHAR2(2),
  CREATION_DATE                                  DATE NOT NULL,
  CREATED_BY                                     NUMBER NOT NULL,
  LAST_UPDATE_DATE                               DATE NOT NULL,
  LAST_UPDATED_BY                                NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.VISITOR_ID IS '�湮ID';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.FOOD_DATE IS '�Ļ�����';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.FOOD_VISITOR_ID IS '�Ļ�� ID';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.FOOD_FLAG IS '�Ļ籸��';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.DEVICE_ID IS '��ġID';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.FOOD_DATETIME IS '�Ļ��Ͻ�';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.CREATED_FLAG IS '��������';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.CREATED_BY IS '������';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRF_FOOD_VISITOR_TIME.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRF_FOOD_VISITOR_TIME_U1 ON HRF_FOOD_VISITOR_TIME(VISITOR_ID, FOOD_DATETIME, DEVICE_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRF_FOOD_VISITOR_TIME_N1 ON HRF_FOOD_VISITOR_TIME(FOOD_VISITOR_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRF_FOOD_VISITOR_TIME COMPUTE STATISTICS;
ANALYZE INDEX HRF_FOOD_VISITOR_TIME_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRF_FOOD_VISITOR_TIME_N1 COMPUTE STATISTICS;
