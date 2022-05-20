/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_ARMY
/* Description  : �������� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_ARMY              
(PERSON_ID                                      NUMBER NOT NULL,
  ARMY_KIND_ID	                               NUMBER,
  ARMY_STATUS_ID	                          NUMBER,
  ARMY_GRADE_ID	                            NUMBER,
  ARMY_START_DATE	                        DATE,	
  ARMY_END_DATE	                            DATE,	
  ARMY_END_TYPE_ID                        NUMBER,
  ARMY_EXCEPTION_DESC	               VARCHAR2(100),
  EXCEPTION_ID	                              NUMBER,
  EXCEPTION_OK_DATE	                    DATE,	
  EXCEPTION_FINISH_DATE	               DATE,	
  EXCEPTION_LICENSE_ID	                NUMBER,
  EXCEPTION_GRADE_ID	                  NUMBER,
  EXCEPTION_START_DATE	             DATE,
  EXCEPTION_END_DATE	                DATE,	
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
COMMENT ON COLUMN HRM_ARMY.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRM_ARMY.ARMY_KIND_ID IS '����(����,�ر�,����...)';
COMMENT ON COLUMN HRM_ARMY.ARMY_STATUS_ID IS '����(����,����,�ι���...)';
COMMENT ON COLUMN HRM_ARMY.ARMY_GRADE_ID IS '���(�̺�, �Ϻ�...)';
COMMENT ON COLUMN HRM_ARMY.ARMY_START_DATE IS '�Դ�����';
COMMENT ON COLUMN HRM_ARMY.ARMY_END_DATE IS '��������';
COMMENT ON COLUMN HRM_ARMY.ARMY_END_TYPE_ID IS '��������';
COMMENT ON COLUMN HRM_ARMY.ARMY_EXCEPTION_DESC IS '��������';
COMMENT ON COLUMN HRM_ARMY.EXCEPTION_ID IS 'Ư�ʱ���';
COMMENT ON COLUMN HRM_ARMY.EXCEPTION_OK_DATE IS 'Ư��ó������';
COMMENT ON COLUMN HRM_ARMY.EXCEPTION_FINISH_DATE IS 'Ư�ʸ�������';
COMMENT ON COLUMN HRM_ARMY.EXCEPTION_LICENSE_ID IS 'Ư�ʶ��̼���';
COMMENT ON COLUMN HRM_ARMY.EXCEPTION_GRADE_ID IS 'Ư�ʵ��';
COMMENT ON COLUMN HRM_ARMY.EXCEPTION_START_DATE IS 'Ư�ʱ����Ʒý�������';
COMMENT ON COLUMN HRM_ARMY.EXCEPTION_END_DATE IS 'Ư�ʱ����Ʒ���������';
COMMENT ON COLUMN HRM_ARMY.DESCRIPTION IS '���';
COMMENT ON COLUMN HRM_ARMY.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRM_ARMY.CREATED_BY IS '������';
COMMENT ON COLUMN HRM_ARMY.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRM_ARMY.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_ARMY_U1 ON HRM_ARMY(PERSON_ID, ARMY_KIND_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRM_ARMY COMPUTE STATISTICS;
ANALYZE INDEX HRM_ARMY_U1 COMPUTE STATISTICS;
