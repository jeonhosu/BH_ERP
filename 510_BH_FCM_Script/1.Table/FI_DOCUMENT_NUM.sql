/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_DOCUMENT_NUM
/* Description  : ���� ä�� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_DOCUMENT_NUM
( DOCUMENT_NUM_ID                 NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  DOCUMENT_TYPE                   VARCHAR2(20)    NOT NULL,
  PREFIX_CHAR                     VARCHAR2(10)    ,
  PREFIX_SEPARATE                 VARCHAR2(10)    ,
  DATE_TYPE                       VARCHAR2(20)    ,
  SEQ_SEPARATE                    VARCHAR2(10)    ,
  SEQ_COUNT                       NUMBER          ,
  DESCRIPTION                     VARCHAR2(150)   ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_DOCUMENT_NUM IS '������ȣ ����';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.DOCUMENT_NUM_ID IS '����ID';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.SOB_ID IS 'SOB ID';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.DOCUMENT_TYPE IS '��������';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.DESCRIPTION IS '���';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.PREFIX_CHAR IS 'Prefix����';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.PREFIX_SEPARATE IS 'Prefix�� Date Type ���� ��ȣ';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.DATE_TYPE IS 'Date Type(YYYYMMDD, YYYYMM, YYYY)';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.SEQ_SEPARATE IS 'Date Type�� Seq ���� ��ȣ';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.SEQ_COUNT IS '�Ϸ���ȣ�ڸ���';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.CREATION_DATE IS '������';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.CREATED_BY IS '������';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.LAST_UPDATE_DATE IS '������';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.LAST_UPDATED_BY IS '������';

-- UNIQUE INDEX.
CREATE UNIQUE INDEX FI_DOCUMENT_NUM_U1 ON FI_DOCUMENT_NUM(DOCUMENT_NUM_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX FI_DOCUMENT_NUM_U2 ON FI_DOCUMENT_NUM(SOB_ID, DOCUMENT_TYPE) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE FI_DOCUMENT_NUM_S1;
       
