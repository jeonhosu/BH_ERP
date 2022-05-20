/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_DOCUMENT_NUM_HISTORY
/* Description  : ���� ä�� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_DOCUMENT_NUM_HISTORY
( DOCUMENT_NUM_ID                 NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  DOCUMENT_TYPE                   VARCHAR2(20)    NOT NULL,    
  DATE_TYPE_VALUE                 VARCHAR2(20)    ,
  YEAR_CHAR                       VARCHAR2(4)     ,
  MONTH_CHAR                      VARCHAR2(2)     ,
  DAY_CHAR                        VARCHAR2(2)     ,
  MAX_DOCUMENT_SEQ                NUMBER          ,
  DOCUMENT_NUM                    VARCHAR2(50)    ,
  DESCRIPTION                     VARCHAR2(150)   ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_DOCUMENT_NUM_HISTORY IS '������ȣ ä������ ����';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM_HISTORY.DOCUMENT_NUM_ID IS '����ID';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM_HISTORY.DOCUMENT_TYPE IS '����Ÿ��';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM_HISTORY.DATE_TYPE_VALUE IS '��¥���� ��';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM_HISTORY.SOB_ID IS 'SOB ID';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM_HISTORY.YEAR_CHAR IS '�⵵';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM_HISTORY.MONTH_CHAR IS '��';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM_HISTORY.DAY_CHAR IS '��';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM_HISTORY.MAX_DOCUMENT_SEQ IS '���� �����Ϸù�ȣ';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM_HISTORY.DOCUMENT_NUM IS '������ȣ';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM_HISTORY.DESCRIPTION IS '���';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM_HISTORY.CREATION_DATE IS '������';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM_HISTORY.CREATED_BY IS '������';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM_HISTORY.LAST_UPDATE_DATE IS '������';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM_HISTORY.LAST_UPDATED_BY IS '������';

-- UNIQUE INDEX.
CREATE UNIQUE INDEX FI_DOCUMENT_NUM_HISTORY_U1 ON FI_DOCUMENT_NUM_HISTORY(SOB_ID, DOCUMENT_TYPE, DATE_TYPE_VALUE) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_DOCUMENT_NUM_HISTORY_N1 ON FI_DOCUMENT_NUM_HISTORY(DOCUMENT_NUM_ID) TABLESPACE FCM_TS_IDX;
