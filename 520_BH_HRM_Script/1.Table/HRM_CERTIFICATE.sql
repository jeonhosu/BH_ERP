/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_CERTIFICATE
/* Description  : ���� �߱� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_CERTIFICATE              
(PRINT_NUM	                                      VARCHAR2(10) NOT NULL,
  CORP_ID                                         NUMBER,                                                
  PRINT_DATE	                                    DATE,
  PERSON_ID	                                      NUMBER NOT NULL,
  CERT_TYPE_ID                                    NUMBER,
  PRINT_COUNT	                                    NUMBER,
  SEND_ORG	                                      VARCHAR2(100),
  DESCRIPTION                                     VARCHAR2(100),
  PRINT_YYYYMM	                                  VARCHAR2(6) NOT NULL,
  PRINT_SEQ	                                      NUMBER NOT NULL,
  ATTRIBUTE1                                      VARCHAR2(100),
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
	SOB_ID                                          NUMBER NOT NULL,
	ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_CERTIFICATE.PRINT_NUM IS '�μ��ȣ';
COMMENT ON COLUMN HRM_CERTIFICATE.CORP_ID IS '��üID';
COMMENT ON COLUMN HRM_CERTIFICATE.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRM_CERTIFICATE.PRINT_DATE IS '�μ�����';
COMMENT ON COLUMN HRM_CERTIFICATE.CERT_TYPE_ID IS '���� ���� ID';
COMMENT ON COLUMN HRM_CERTIFICATE.PRINT_COUNT IS '�μ�ż�';
COMMENT ON COLUMN HRM_CERTIFICATE.SEND_ORG IS '����ó';
COMMENT ON COLUMN HRM_CERTIFICATE.DESCRIPTION IS '���';
COMMENT ON COLUMN HRM_CERTIFICATE.PRINT_YYYYMM IS '������';
COMMENT ON COLUMN HRM_CERTIFICATE.PRINT_SEQ IS '�������';
COMMENT ON COLUMN HRM_CERTIFICATE.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRM_CERTIFICATE.CREATED_BY IS '������';
COMMENT ON COLUMN HRM_CERTIFICATE.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRM_CERTIFICATE.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_CERTIFICATE_U1 ON HRM_CERTIFICATE(PRINT_NUM, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRM_CERTIFICATE_N1 ON HRM_CERTIFICATE(PRINT_YYYYMM, PRINT_SEQ) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRM_CERTIFICATE_N2 ON HRM_CERTIFICATE(CORP_ID, PRINT_DATE, PERSON_ID, CERT_TYPE_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRM_CERTIFICATE COMPUTE STATISTICS;
ANALYZE INDEX HRM_CERTIFICATE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_CERTIFICATE_N1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_CERTIFICATE_N2 COMPUTE STATISTICS;
