/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_REFERENCE,
/* Description  : �ſ����� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_REFERENCE              
(PERSON_ID                                        NUMBER NOT NULL,
  REFERENCE_TYPE                            VARCHAR2(2) NOT NULL,
  INSUR_NAME                                    VARCHAR2(100),
  INSUR_NUM                                       VARCHAR2(50),
  INSUR_START_DATE                          DATE,
  INSUR_END_DATE                              DATE,  
  INSUR_AMOUNT                                NUMBER,
  GUAR_NAME1                                    VARCHAR2(100),
  GUAR_REPRE_NUM1                         VARCHAR2(30),
  GUAR_RELATION_ID1                         NUMBER,
  GUAR_TEL1                                       VARCHAR2(30),
  GUAR_ZIP_CODE1                            VARCHAR2(30),
  GUAR_ADDR1_1                                VARCHAR2(150),
  GUAR_ADDR1_2                                VARCHAR2(150),
  GUAR_NAME2                                    VARCHAR2(100),
  GUAR_REPRE_NUM2                         VARCHAR2(30),
  GUAR_RELATION_ID2                         NUMBER,
  GUAR_TEL2                                       VARCHAR2(30),
  GUAR_ZIP_CODE2                            VARCHAR2(30),
  GUAR_ADDR2_1                                VARCHAR2(150),
  GUAR_ADDR2_2                                VARCHAR2(150),
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
COMMENT ON COLUMN HRM_REFERENCE.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRM_REFERENCE.REFERENCE_TYPE IS '��������(I-����, P-���)';
COMMENT ON COLUMN HRM_REFERENCE.INSUR_NAME IS '�����';
COMMENT ON COLUMN HRM_REFERENCE.INSUR_NUM IS '�����ȣ';
COMMENT ON COLUMN HRM_REFERENCE.INSUR_START_DATE IS '�����������';
COMMENT ON COLUMN HRM_REFERENCE.INSUR_END_DATE IS '������������';
COMMENT ON COLUMN HRM_REFERENCE.INSUR_AMOUNT IS '�����';
COMMENT ON COLUMN HRM_REFERENCE.GUAR_NAME1 IS '������ ����1';
COMMENT ON COLUMN HRM_REFERENCE.GUAR_REPRE_NUM1 IS '������ �ֹι�ȣ1';
COMMENT ON COLUMN HRM_REFERENCE.GUAR_RELATION_ID1 IS '������ ����1';
COMMENT ON COLUMN HRM_REFERENCE.GUAR_TEL1 IS '������ ����ó1';
COMMENT ON COLUMN HRM_REFERENCE.GUAR_ZIP_CODE1 IS '�����ȣ1';
COMMENT ON COLUMN HRM_REFERENCE.GUAR_ADDR1_1 IS '�ּ�1-1';
COMMENT ON COLUMN HRM_REFERENCE.GUAR_ADDR1_2 IS '�ּ�1-2';
COMMENT ON COLUMN HRM_REFERENCE.GUAR_NAME2 IS '������ ����2';
COMMENT ON COLUMN HRM_REFERENCE.GUAR_REPRE_NUM2 IS '������ �ֹι�ȣ2';
COMMENT ON COLUMN HRM_REFERENCE.GUAR_RELATION_ID2 IS '������ ����2';
COMMENT ON COLUMN HRM_REFERENCE.GUAR_TEL1 IS '������ ����ó2';
COMMENT ON COLUMN HRM_REFERENCE.GUAR_ZIP_CODE2 IS '�����ȣ2';
COMMENT ON COLUMN HRM_REFERENCE.GUAR_ADDR2_1 IS '�ּ�2-1';
COMMENT ON COLUMN HRM_REFERENCE.GUAR_ADDR2_2 IS '�ּ�2-2';
COMMENT ON COLUMN HRM_REFERENCE.DESCRIPTION IS '���';
COMMENT ON COLUMN HRM_REFERENCE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRM_REFERENCE.CREATED_BY IS '������';
COMMENT ON COLUMN HRM_REFERENCE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRM_REFERENCE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_REFERENCE_U1 ON HRM_REFERENCE(PERSON_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRM_REFERENCE COMPUTE STATISTICS;
ANALYZE INDEX HRM_REFERENCE_U1 COMPUTE STATISTICS;
