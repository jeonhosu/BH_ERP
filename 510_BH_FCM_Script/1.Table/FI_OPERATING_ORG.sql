/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_OPERATING_ORG
/* Description  : � ORG ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_OPERATING_ORG
( SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  OPERATING_FLAG                  CHAR(1)         ,
  ENABLED_FLAG                    VARCHAR2(1)     ,
  EFFECTIVE_DATE_FR               DATE            NOT NULL,
  EFFECTIVE_DATE_TO               DATE            ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_OPERATING_ORG IS 'SOB�� ���� � ORG ����';
COMMENT ON COLUMN APPS.FI_OPERATING_ORG.SOB_ID IS 'SET OF BOOK ID';
COMMENT ON COLUMN APPS.FI_OPERATING_ORG.ORG_ID IS 'ORG ID';
COMMENT ON COLUMN APPS.FI_OPERATING_ORG.OPERATING_FLAG IS '� FLAG';
COMMENT ON COLUMN APPS.FI_OPERATING_ORG.ENABLED_FLAG IS '��뿩��';
COMMENT ON COLUMN APPS.FI_OPERATING_ORG.EFFECTIVE_DATE_FR IS '��ȿ���� ��������';
COMMENT ON COLUMN APPS.FI_OPERATING_ORG.EFFECTIVE_DATE_TO IS '��ȿ���� ��������';
COMMENT ON COLUMN APPS.FI_OPERATING_ORG.CREATION_DATE IS '������';
COMMENT ON COLUMN APPS.FI_OPERATING_ORG.CREATED_BY IS '������';
COMMENT ON COLUMN APPS.FI_OPERATING_ORG.LAST_UPDATE_DATE IS '������';
COMMENT ON COLUMN APPS.FI_OPERATING_ORG.LAST_UPDATED_BY IS '������';

-- PRIMARY KEY
CREATE UNIQUE INDEX FI_OPERATING_ORG_PK ON 
  FI_OPERATING_ORG(SOB_ID, ORG_ID)
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

ALTER TABLE FI_OPERATING_ORG ADD ( 
  CONSTRAINT FI_OPERATING_ORG_PK PRIMARY KEY ( SOB_ID, ORG_ID ) 
        );
        
-- UNIQUE INDEX.
CREATE UNIQUE INDEX FI_OPERATING_ORG_U1 ON FI_OPERATING_ORG(SOB_ID, ORG_ID, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;

ANALYZE TABLE FI_OPERATING_ORG COMPUTE STATISTICS;
ANALYZE INDEX FI_OPERATING_ORG_U1 COMPUTE STATISTICS;    
