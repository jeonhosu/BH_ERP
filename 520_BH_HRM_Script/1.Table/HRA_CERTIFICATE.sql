/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_CERTIFICATE
/* Description  : ���� ���� �߱� ����
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRA_CERTIFICATE
( PRINT_NUM                       VARCHAR2(20)    NOT NULL
, SOB_ID                          NUMBER          NOT NULL
, ORG_ID                          NUMBER          NOT NULL
, CHECK_MONTH                     VARCHAR2(10)    NOT NULL
, CHECK_SEQ                       NUMBER          DEFAULT 1
, CORP_ID                         NUMBER
, PERSON_ID                       NUMBER
, PRINT_YEAR                      VARCHAR2(4)     NOT NULL
, PRINT_DATE                      DATE            NOT NULL
, CERT_TYPE_ID                    NUMBER          NOT NULL
, SEND_ORG	                      VARCHAR2(100)
, DESCRIPTION                     VARCHAR2(100)
, PRINT_COUNT                     NUMBER          DEFAULT 0 NOT NULL
, CREATION_DATE                   DATE            NOT NULL
, CREATED_BY                      NUMBER          NOT NULL
, LAST_UPDATE_DATE                DATE            NOT NULL
, LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON TABLE HRA_CERTIFICATE IS '������� ���� �߱�';
COMMENT ON COLUMN HRA_CERTIFICATE.PRINT_NUM IS '�߱޹�ȣ';
COMMENT ON COLUMN HRA_CERTIFICATE.CHECK_MONTH IS 'üũ���';
COMMENT ON COLUMN HRA_CERTIFICATE.CHECK_SEQ IS 'üũ����-������ȣ';
COMMENT ON COLUMN HRA_CERTIFICATE.CORP_ID IS '��üID';
COMMENT ON COLUMN HRA_CERTIFICATE.PERSON_ID IS '���ID';
COMMENT ON COLUMN HRA_CERTIFICATE.PRINT_YEAR IS '¡���⵵';
COMMENT ON COLUMN HRA_CERTIFICATE.PRINT_DATE IS '�߱�����';
COMMENT ON COLUMN HRA_CERTIFICATE.CERT_TYPE_ID IS '����Ÿ�� ID';
COMMENT ON COLUMN HRA_CERTIFICATE.SEND_ORG IS '����ó';
COMMENT ON COLUMN HRA_CERTIFICATE.DESCRIPTION IS '�뵵';
COMMENT ON COLUMN HRA_CERTIFICATE.PRINT_COUNT IS '�μ�Ƚ��';

-- CREATE/RECREATE INDEXES 
CREATE INDEX HRA_CERTIFICATE_N1 ON HRA_CERTIFICATE (CHECK_MONTH, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRA_CERTIFICATE_N2 ON HRA_CERTIFICATE (CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRA_CERTIFICATE_U1 ON HRA_CERTIFICATE (PRINT_NUM, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
