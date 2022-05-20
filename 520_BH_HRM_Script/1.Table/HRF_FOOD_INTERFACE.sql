/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRF_FOOD_INTERFACE
/* Description  : �ļ� interface ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRF_FOOD_INTERFACE              
( DEVICE_ID                                      NUMBER NOT NULL,
  PERSON_ID                                      NUMBER NOT NULL,
  FOOD_FLAG                                      VARCHAR2(1) NOT NULL,
  FOOD_DATETIME                                  DATE NOT NULL,
  FOOD_DATE                                      DATE NOT NULL,
  FOOD_TIME                                      VARCHAR2(5) NOT NULL,
  CREATED_FLAG                                   VARCHAR2(2),
  CARD_NUM                                       VARCHAR2(50),
	CARD_TYPE                                      VARCHAR2(2),
  SOB_ID                                         NUMBER NOT NULL,
  ORG_ID                                         NUMBER NOT NULL,
  CREATION_DATE                                  DATE NOT NULL,
  CREATED_BY                                     NUMBER NOT NULL,
  LAST_UPDATE_DATE                               DATE NOT NULL,
  LAST_UPDATED_BY                                NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRF_FOOD_INTERFACE.DEVICE_ID IS '��ġID';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.FOOD_FLAG IS '�Ļ籸��';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.FOOD_DATETIME IS '�Ļ��Ͻ�';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.FOOD_DATE IS '�Ļ�����';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.FOOD_TIME IS '�Ļ�ð�';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.CREATED_FLAG IS '��������';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.CARD_NUM IS 'ī���ȣ';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.CARD_TYPE IS 'ī�屸��(P-PERSON, V-VISITOR)';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.CREATED_BY IS '������';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRF_FOOD_INTERFACE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRF_FOOD_INTERFACE_U1 ON HRF_FOOD_INTERFACE(DEVICE_ID, PERSON_ID, FOOD_FLAG, FOOD_DATETIME, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRF_FOOD_INTERFACE_N1 ON HRF_FOOD_INTERFACE(PERSON_ID, FOOD_DATE, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRF_FOOD_INTERFACE COMPUTE STATISTICS;
ANALYZE INDEX HRF_FOOD_INTERFACE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRF_FOOD_INTERFACE_N1 COMPUTE STATISTICS;
