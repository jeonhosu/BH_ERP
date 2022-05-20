/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_MANAGER
/* Description  : �λ� �ý��� ��� ����� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_MANAGER              
( CORP_ID                                       NUMBER NOT NULL,
  MODULE_CODE                                   VARCHAR2(50) NOT NULL,
  PERSON_ID                                     NUMBER NOT NULL,
  CAPACITY_LEVEL                                VARCHAR2(10) NOT NULL,
  DESCRIPTION                                   VARCHAR2(100),
  ATTRIBUTE1                                    VARCHAR2(100),
  ATTRIBUTE2                                    VARCHAR2(100),
  ATTRIBUTE3                                    VARCHAR2(100),
  ATTRIBUTE4                                    VARCHAR2(100),
  ATTRIBUTE5                                    VARCHAR2(100),
  USABLE                                        VARCHAR2(1) DEFAULT 'Y',
	EFFECTIVE_DATE_FR                             DATE NOT NULL,
	EFFECTIVE_DATE_TO                             DATE,
	SOB_ID                                        NUMBER NOT NULL,
	ORG_ID                                        NUMBER NOT NULL,
	CREATION_DATE                                 DATE NOT NULL,
  CREATED_BY                                    NUMBER NOT NULL,
  LAST_UPDATE_DATE                              DATE NOT NULL,
  LAST_UPDATED_BY                               NUMBER NOT NULL
) TABLESPACE EAPP_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_MANAGER.CORP_ID IS '��ü ID';
COMMENT ON COLUMN HRM_MANAGER.MODULE_CODE IS '��� �ڵ�(�����ڵ� �ڵ�)';
COMMENT ON COLUMN HRM_MANAGER.PERSON_ID IS '��� ID';
COMMENT ON COLUMN HRM_MANAGER.CAPACITY_LEVEL IS '���� ��� LEVEL';
COMMENT ON COLUMN HRM_MANAGER.DESCRIPTION IS '���';
COMMENT ON COLUMN HRM_MANAGER.USABLE IS '��뿩��';
COMMENT ON COLUMN HRM_MANAGER.EFFECTIVE_DATE_FR IS '��� ��������';
COMMENT ON COLUMN HRM_MANAGER.EFFECTIVE_DATE_TO IS '��� ��������';
COMMENT ON COLUMN HRM_MANAGER.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRM_MANAGER.CREATED_BY IS '������';
COMMENT ON COLUMN HRM_MANAGER.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRM_MANAGER.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_MANAGER_U1 ON HRM_MANAGER(CORP_ID, MODULE_CODE, PERSON_ID, CAPACITY_LEVEL, SOB_ID, ORG_ID) TABLESPACE EAPP_TS_IDX;
CREATE INDEX HRM_MANAGER_N1 ON HRM_MANAGER(CORP_ID, MODULE_CODE, PERSON_ID, SOB_ID, ORG_ID) TABLESPACE EAPP_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRM_MANAGER COMPUTE STATISTICS;
ANALYZE INDEX HRM_MANAGER_U1 COMPUTE STATISTICS;
