/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_DOCUMENT_NUM
/* Description  : 문서 채번 기준.
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

COMMENT ON TABLE FI_DOCUMENT_NUM IS '문서번호 관리';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.DOCUMENT_NUM_ID IS '문서ID';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.SOB_ID IS 'SOB ID';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.DOCUMENT_TYPE IS '문서유형';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.DESCRIPTION IS '비고';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.PREFIX_CHAR IS 'Prefix문자';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.PREFIX_SEPARATE IS 'Prefix와 Date Type 구분 기호';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.DATE_TYPE IS 'Date Type(YYYYMMDD, YYYYMM, YYYY)';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.SEQ_SEPARATE IS 'Date Type과 Seq 구분 기호';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.SEQ_COUNT IS '일런번호자리수';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.CREATION_DATE IS '생성자';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.CREATED_BY IS '생성일';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.LAST_UPDATE_DATE IS '수정자';
COMMENT ON COLUMN APPS.FI_DOCUMENT_NUM.LAST_UPDATED_BY IS '수정일';

-- UNIQUE INDEX.
CREATE UNIQUE INDEX FI_DOCUMENT_NUM_U1 ON FI_DOCUMENT_NUM(DOCUMENT_NUM_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX FI_DOCUMENT_NUM_U2 ON FI_DOCUMENT_NUM(SOB_ID, DOCUMENT_TYPE) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE FI_DOCUMENT_NUM_S1;
       
