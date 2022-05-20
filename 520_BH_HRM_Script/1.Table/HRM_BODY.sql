/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_BODYS
/* Description  : ��ü���� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_BODY              
(PERSON_ID    	                                    NUMBER NOT NULL,
  HEIGHT	                                          NUMBER,
  WEIGHT	                                          NUMBER,	
  BLOOD_ID	                                        NUMBER,
  LEFT_EYE	                                        VARCHAR2(5),
  RIGHT_EYE	                                        VARCHAR2(5),
  ACHRO_ID                                          NUMBER,
  FOOTWEAR_SIZE	                                    NUMBER,	
  UNIFORM_UPPER_SIZE	                              VARCHAR2(5),
  UNIFORM_UNDER_SIZE	                              VARCHAR2(5),	
  DISABLED_ID	                                      NUMBER,
  BOHUN_ID	                                        NUMBER,
  BOHUN_NUM	                                        VARCHAR2(50),
  DESCRIPTION                                       VARCHAR2(100),
  ATTRIBUTE1                                        VARCHAR2(100),
  ATTRIBUTE2                                        VARCHAR2(100),
  ATTRIBUTE3                                        VARCHAR2(100),
  ATTRIBUTE4                                        VARCHAR2(100),
  ATTRIBUTE5                                        VARCHAR2(100),
  CREATION_DATE                                     DATE NOT NULL,
  CREATED_BY                                        NUMBER NOT NULL,
  LAST_UPDATE_DATE                                  DATE NOT NULL,
  LAST_UPDATED_BY                                   NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_BODY.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRM_BODY.HEIGHT IS '����';
COMMENT ON COLUMN HRM_BODY.WEIGHT IS 'ü��';
COMMENT ON COLUMN HRM_BODY.BLOOD_ID IS '������ TYPE';
COMMENT ON COLUMN HRM_BODY.LEFT_EYE IS '�÷�(��)';
COMMENT ON COLUMN HRM_BODY.RIGHT_EYE IS '�÷�(��)';
COMMENT ON COLUMN HRM_BODY.ACHRO_ID IS '���� ID';
COMMENT ON COLUMN HRM_BODY.FOOTWEAR_SIZE IS '�Ź߻�����';
COMMENT ON COLUMN HRM_BODY.UNIFORM_UPPER_SIZE IS '���� ������';
COMMENT ON COLUMN HRM_BODY.UNIFORM_UNDER_SIZE IS '���� ������';
COMMENT ON COLUMN HRM_BODY.DISABLED_ID IS '��ֱ��� ID';
COMMENT ON COLUMN HRM_BODY.BOHUN_ID IS '���� ID';
COMMENT ON COLUMN HRM_BODY.BOHUN_NUM IS '���ƹ�ȣ';
COMMENT ON COLUMN HRM_BODY.DESCRIPTION IS '���';
COMMENT ON COLUMN HRM_BODY.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRM_BODY.CREATED_BY IS '������';
COMMENT ON COLUMN HRM_BODY.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRM_BODY.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_BODY_U1 ON HRM_BODY(PERSON_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRM_BODY COMPUTE STATISTICS;
ANALYZE INDEX HRM_BODY_U1 COMPUTE STATISTICS;
