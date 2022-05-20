/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_FORM_HEADER
/* Description  : �繫��ǥ ���� ��� Master.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_FORM_HEADER 
( FORM_HEADER_ID                  NUMBER          NOT NULL,
  FORM_TYPE_ID                    NUMBER          NOT NULL,     -- ���� ��� ID
  SOB_ID                          NUMBER          NOT NULL, 
  ORG_ID                          NUMBER          NOT NULL, 
  FORM_ITEM_CODE                  VARCHAR2(30)    NOT NULL,     -- ��� �׸� �ڵ�.
  FORM_ITEM_NAME                  VARCHAR2(100)   ,             -- ��� �׸��.
  SORT_SEQ                        NUMBER          ,             -- ���ļ���.
  ITEM_LEVEL                      NUMBER          ,             -- ��� LEVEL.
  LAST_LEVEL_YN                   CHAR(1)         DEFAULT 'N',  -- ���� ����.
  COLUMN_POSITION_NUM             NUMBER          ,             -- �׸� �μ�� ��ġ(1, 2)
  ACCOUNT_DR_CR                   CHAR(1)         ,             -- �μ�� ����.
  MINUS_SIGN_DISPLAY              VARCHAR2(10)    ,             -- ������ ǥ�� �׸�.
  DISPLAY_YN                      CHAR(1)         DEFAULT 'Y',  -- �׸�� ȭ�� ǥ��.
  AMOUNT_PRINT_YN                 CHAR(1)         DEFAULT 'Y',  -- �ݾ� ���.
  UNDER_LINE_YN                   CHAR(1)         DEFAULT 'N',  -- �������.
  FORM_ITEM_TYPE                  VARCHAR2(10)    ,             
  FORM_ITEM_CLASS                 VARCHAR2(10)    ,
  RELATE_HEADER_ID                NUMBER          ,
  ENABLED_FLAG                    CHAR(1)         DEFAULT 'Y',  -- ��뿩��.
  EFFECTIVE_DATE_FR               DATE            NOT NULL,     -- ��ȿ��������.
  EFFECTIVE_DATE_TO               DATE            ,             -- ��ȿ��������.
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL 
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_FORM_HEADER IS '�繫��ǥ ���� ��� �� ����';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.FORM_HEADER_ID IS '�繫��ǥ ���� ID';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.FORM_TYPE_ID IS '�������ID(�����ڵ�)';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.SOB_ID IS 'ȸ������';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.ORG_ID IS '�����ID';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.FORM_ITEM_CODE IS '�׸��ڵ�';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.FORM_ITEM_NAME IS '�׸��';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.SORT_SEQ IS '���� ����';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.ITEM_LEVEL IS '�׸� ����';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.LAST_LEVEL_YN IS '���� ����';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.COLUMN_POSITION_NUM IS '�μ� ������ġ(1,2)';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.ACCOUNT_DR_CR IS '�μ�� ����';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.MINUS_SIGN_DISPLAY IS '(-)�� ���� ǥ�� ����';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.DISPLAY_YN IS 'ȭ�� ǥ��';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.AMOUNT_PRINT_YN IS '�ݾ� ǥ��';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.UNDER_LINE_YN IS '�������';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.FORM_ITEM_TYPE IS '�׸� Ÿ��';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.FORM_ITEM_CLASS IS '�׸� �з�';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.RELATE_HEADER_ID IS '���� �׸� ��� ID';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.ENABLED_FLAG IS '��뿩��';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.EFFECTIVE_DATE_FR IS '��ȿ ������';
COMMENT ON COLUMN APPS.FI_FORM_HEADER.EFFECTIVE_DATE_TO IS '��ȿ ������';

CREATE UNIQUE INDEX FI_FORM_HEADER_PK ON
  FI_FORM_HEADER(FORM_TYPE_ID, SOB_ID, FORM_ITEM_CODE)
  TABLESPACE FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  LOGGING
  STORAGE (
           INITIAL 64K
           MINEXTENTS 1
           MAXEXTENTS 2147483645
          );

ALTER TABLE FI_FORM_HEADER ADD ( 
  CONSTRAINT FI_FORM_HEADER_PK PRIMARY KEY (FORM_TYPE_ID, SOB_ID, FORM_ITEM_CODE)
        );
        
CREATE UNIQUE INDEX FI_FORM_HEADER_U1 ON FI_FORM_HEADER(FORM_HEADER_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_FORM_HEADER_N1 ON FI_FORM_HEADER(FORM_TYPE_ID, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_FORM_HEADER_N2 ON FI_FORM_HEADER(ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_FORM_HEADER_N3 ON FI_FORM_HEADER(FORM_HEADER_ID, SORT_SEQ) TABLESPACE FCM_TS_IDX;

-- SEQUNCE.
DROP SEQUENCE FI_FORM_HEADER_S1;
CREATE SEQUENCE FI_FORM_HEADER_S1;
