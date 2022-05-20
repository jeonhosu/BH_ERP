/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_FORM_LINE
/* Description  : �繫��ǥ ���� ��� LINE.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_FORM_LINE 
( FORM_LINE_ID                    NUMBER          NOT NULL,     -- ��� LINE ID.
  SOB_ID                          NUMBER          NOT NULL, 
  ORG_ID                          NUMBER          NOT NULL,
  FORM_HEADER_ID                  NUMBER          NOT NULL,
  JOIN_LINE_CONTROL_ID            NUMBER          NOT NULL,     -- (��/��)���� HEADER ID./ ���� ���� ID    
  ITEM_SIGN_SHOW                  VARCHAR(10)     DEFAULT '+',  -- ���� ����.
  ITEM_SIGN                       NUMBER(2)       DEFAULT 1,    -- ����.
  ITEM_LEVEL                      NUMBER          ,             -- ��� LEVEL.
  LAST_LEVEL_YN                   CHAR(1)         DEFAULT 'N',  -- ���� ����.
  JOIN_ACCOUNT_CONTROL_ID         NUMBER          DEFAULT -1,   -- ����ID.
  JOIN_FORM_HEADER_ID             NUMBER          DEFAULT -1,   -- ��/�� ������ HEADER ID.
  ENABLED_FLAG                    CHAR(1)         DEFAULT 'Y',  -- ��뿩��.
  EFFECTIVE_DATE_FR               DATE            NOT NULL,     -- ��ȿ��������.
  EFFECTIVE_DATE_TO               DATE            ,             -- ��ȿ��������.
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL 
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_FORM_LINE IS '�繫��ǥ ���� ��� �� ����';
COMMENT ON COLUMN APPS.FI_FORM_LINE.FORM_LINE_ID IS '�繫��ǥ ���� LINE ID';
COMMENT ON COLUMN APPS.FI_FORM_LINE.SOB_ID IS 'ȸ������';
COMMENT ON COLUMN APPS.FI_FORM_LINE.ORG_ID IS '�����ID';
COMMENT ON COLUMN APPS.FI_FORM_LINE.FORM_HEADER_ID IS '������� HEADER ID';
COMMENT ON COLUMN APPS.FI_FORM_LINE.JOIN_LINE_CONTROL_ID IS '(��/��)���� HEADER ID./ ���� ���� ID';
COMMENT ON COLUMN APPS.FI_FORM_LINE.ITEM_SIGN_SHOW IS '������ȣ DISPLAY';
COMMENT ON COLUMN APPS.FI_FORM_LINE.ITEM_SIGN IS '���� ����';
COMMENT ON COLUMN APPS.FI_FORM_LINE.ITEM_LEVEL IS '�׸� ����';
COMMENT ON COLUMN APPS.FI_FORM_LINE.LAST_LEVEL_YN IS '���� ����';
COMMENT ON COLUMN APPS.FI_FORM_LINE.JOIN_ACCOUNT_CONTROL_ID IS '����� �������� ID';
COMMENT ON COLUMN APPS.FI_FORM_LINE.JOIN_FORM_HEADER_ID IS '����� ���� ��� ID';
COMMENT ON COLUMN APPS.FI_FORM_LINE.ENABLED_FLAG IS '��뿩��';
COMMENT ON COLUMN APPS.FI_FORM_LINE.EFFECTIVE_DATE_FR IS '��ȿ ������';
COMMENT ON COLUMN APPS.FI_FORM_LINE.EFFECTIVE_DATE_TO IS '��ȿ ������';

CREATE UNIQUE INDEX FI_FORM_LINE_PK ON
  FI_FORM_LINE(FORM_HEADER_ID, JOIN_LINE_CONTROL_ID, SOB_ID)
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

ALTER TABLE FI_FORM_LINE ADD ( 
  CONSTRAINT FI_FORM_LINE_PK PRIMARY KEY (FORM_HEADER_ID, JOIN_LINE_CONTROL_ID, SOB_ID)
        );
        
CREATE UNIQUE INDEX FI_FORM_LINE_U1 ON FI_FORM_LINE(FORM_LINE_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_FORM_LINE_N1 ON FI_FORM_LINE(ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_FORM_LINE_N2 ON FI_FORM_LINE(JOIN_ACCOUNT_CONTROL_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_FORM_LINE_N3 ON FI_FORM_LINE(JOIN_FORM_HEADER_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_FORM_LINE_N4 ON FI_FORM_LINE(FORM_HEADER_ID) TABLESPACE FCM_TS_IDX;

-- SEQUNCE.
DROP SEQUENCE FI_FORM_LINE_S1;
CREATE SEQUENCE FI_FORM_LINE_S1;
