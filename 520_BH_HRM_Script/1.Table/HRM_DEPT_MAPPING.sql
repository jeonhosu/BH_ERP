/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_DEPT_MAPPING
/* Description  : �μ������� ���� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_DEPT_MAPPING              
( MODULE_TYPE                     VARCHAR2(20)  NOT NULL,
  HR_DEPT_ID                      NUMBER        NOT NULL,
  CORP_ID                         NUMBER        NOT NULL,
  M_DEPT_ID                       NUMBER        NOT NULL,
  DESCRIPTION                     VARCHAR2(100) , 
  ATTRIBUTE1                      VARCHAR2(100) ,          
  ATTRIBUTE2                      VARCHAR2(100) ,
  ATTRIBUTE3                      VARCHAR2(100) ,
  ATTRIBUTE4                      VARCHAR2(100) ,
  ATTRIBUTE5                      VARCHAR2(100) ,
  ENABLED_FLAG                    CHAR(1)       ,
  EFFECTIVE_DATE_FR               DATE          NOT NULL,
  EFFECTIVE_DATE_TO               DATE          ,
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  CREATION_DATE                   DATE          NOT NULL,
  CREATED_BY                      NUMBER        NOT NULL,
  LAST_UPDATE_DATE                DATE          NOT NULL,
  LAST_UPDATED_BY                 NUMBER        NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRM_DEPT_MAPPING IS '�μ������� ���� ���̺�';
COMMENT ON COLUMN HRM_DEPT_MAPPING.HR_DEPT_ID IS '�λ� �μ� ID';
COMMENT ON COLUMN HRM_DEPT_MAPPING.CORP_ID IS '��ü ID';
COMMENT ON COLUMN HRM_DEPT_MAPPING.M_DEPT_ID IS '���� �μ��ڵ�';
COMMENT ON COLUMN HRM_DEPT_MAPPING.ENABLED_FLAG IS '��� ����';
COMMENT ON COLUMN HRM_DEPT_MAPPING.EFFECTIVE_DATE_FR IS '���� ��������';
COMMENT ON COLUMN HRM_DEPT_MAPPING.EFFECTIVE_DATE_TO IS '���� ��������';
COMMENT ON COLUMN HRM_DEPT_MAPPING.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRM_DEPT_MAPPING.CREATED_BY IS '������';
COMMENT ON COLUMN HRM_DEPT_MAPPING.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRM_DEPT_MAPPING.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_DEPT_MAPPING_U1 ON HRM_DEPT_MAPPING(MODULE_TYPE, HR_DEPT_ID, CORP_ID, M_DEPT_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRM_DEPT_MAPPING_N1 ON HRM_DEPT_MAPPING(ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRM_DEPT_MAPPING COMPUTE STATISTICS;
ANALYZE INDEX HRM_DEPT_MAPPING_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_DEPT_MAPPING_N1 COMPUTE STATISTICS;

