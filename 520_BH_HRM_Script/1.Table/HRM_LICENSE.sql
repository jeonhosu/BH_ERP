/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_LICENSE
/* Description  : �ڰݻ��� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_LICENSE              
(PERSON_ID                                    NUMBER NOT NULL,
  LICENSE_ID	                                  NUMBER NOT NULL,
  LICENSE_GRADE_ID                       NUMBER,
  LICENSE_NO	                               VARCHAR2(100),
  LICENSE_DATE	                            DATE,	
  LICENSE_ORG	                              VARCHAR2(100),
  RENEW_DATE	                              DATE,
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
COMMENT ON COLUMN HRM_LICENSE.PERSON_ID IS '�����ȣ';
COMMENT ON COLUMN HRM_LICENSE.LICENSE_ID IS '�ڰ��� ���� ID';
COMMENT ON COLUMN HRM_LICENSE.LICENSE_GRADE_ID IS '�ڰ��� ���';
COMMENT ON COLUMN HRM_LICENSE.LICENSE_NO IS '�ڰ��� ��ȣ';
COMMENT ON COLUMN HRM_LICENSE.LICENSE_DATE IS '�ڰ� �������';
COMMENT ON COLUMN HRM_LICENSE.LICENSE_ORG IS '�ڰ��� �߱ޱ��';
COMMENT ON COLUMN HRM_LICENSE.RENEW_DATE IS '�ڰ��� ��������';
COMMENT ON COLUMN HRM_LICENSE.DESCRIPTION IS '���';
COMMENT ON COLUMN HRM_LICENSE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRM_LICENSE.CREATED_BY IS '������';
COMMENT ON COLUMN HRM_LICENSE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRM_LICENSE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_LICENSE_U1 ON HRM_LICENSE(PERSON_ID, LICENSE_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRM_LICENSE COMPUTE STATISTICS;
ANALYZE INDEX HRM_LICENSE_U1 COMPUTE STATISTICS;
