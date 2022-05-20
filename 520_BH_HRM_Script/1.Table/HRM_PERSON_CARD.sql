/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_PERSON_CARD
/* Description  : �ڰݻ��� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_PERSON_CARD              
(CARD_FLAG	                                VARCHAR2(5) NOT NULL,
  PERSON_ID	                                 NUMBER NOT NULL,
  CARD_NUM	                                 VARCHAR2(30) NOT NULL,
  USER_NUM  	                                VARCHAR2(20) NOT NULL,
  CARD_NAME	                                VARCHAR2(50),
  START_DATE	                              DATE,
  END_DATE	                                  DATE,
  DESCRIPTION                             VARCHAR2(100),
  ATTRIBUTE1                                  VARCHAR2(100),
  ATTRIBUTE2                                  VARCHAR2(100),
  ATTRIBUTE3                                  VARCHAR2(100),
  ATTRIBUTE4                                  VARCHAR2(100),
  ATTRIBUTE5                                  VARCHAR2(100),
  CREATION_DATE                            DATE NOT NULL,
  CREATED_BY                                  NUMBER NOT NULL,
  LAST_UPDATE_DATE                       DATE NOT NULL,
  LAST_UPDATED_BY                         NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_PERSON_CARD.CARD_FLAG IS 'ī�屸��';
COMMENT ON COLUMN HRM_PERSON_CARD.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRM_PERSON_CARD.CARD_NUM IS 'ī���ȣ';
COMMENT ON COLUMN HRM_PERSON_CARD.USER_NUM IS '����ڹ�ȣ';
COMMENT ON COLUMN HRM_PERSON_CARD.CARD_NAME IS 'ī���';
COMMENT ON COLUMN HRM_PERSON_CARD.START_DATE IS '���� ��������';
COMMENT ON COLUMN HRM_PERSON_CARD.END_DATE IS '���� ��������';
COMMENT ON COLUMN HRM_PERSON_CARD.DESCRIPTION IS '���';
COMMENT ON COLUMN HRM_PERSON_CARD.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRM_PERSON_CARD.CREATED_BY IS '������';
COMMENT ON COLUMN HRM_PERSON_CARD.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRM_PERSON_CARD.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_PERSON_CARD_U1 ON HRM_PERSON_CARD(CARD_FLAG, PERSON_ID, CARD_NUM) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRM_PERSON_CARD COMPUTE STATISTICS;
ANALYZE INDEX HRM_PERSON_CARD_U1 COMPUTE STATISTICS;
