/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRW_EARNER_FAMILY
/* Description  : �ҵ��� �ξ簡�� ����.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRW_EARNER_FAMILY
( EARNER_FAMILY_ID                NUMBER          NOT NULL,
  EARNER_ID                       NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  NAME                            VARCHAR2(100)   NOT NULL,
  REPRE_NUM                       VARCHAR2(30)    ,
  RELATION_ID                     NUMBER          ,
  NATIONALITY_TYPE                VARCHAR2(2)     ,
  DISABILITY_YN                   VARCHAR2(2)     DEFAULT 'N',
  SUPPORT_YN                      VARCHAR2(2)     DEFAULT 'N',
  DESCRIPTION                     VARCHAR2(100)   ,
  ATTRIBUTE1                      VARCHAR2(100)   ,
  ATTRIBUTE2                      VARCHAR2(100)   ,
  ATTRIBUTE3                      VARCHAR2(100)   ,
  ATTRIBUTE4                      VARCHAR2(100)   ,
  ATTRIBUTE5                      VARCHAR2(100)   ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRW_EARNER_FAMILY IS '�ҵ��� �ξ簡�� ����';
COMMENT ON COLUMN HRW_EARNER_FAMILY.EARNER_FAMILY_ID IS '�ξ簡�� ID';
COMMENT ON COLUMN HRW_EARNER_FAMILY.EARNER_ID IS '�ҵ��� ID';
COMMENT ON COLUMN HRW_EARNER_FAMILY.NAME IS '����';
COMMENT ON COLUMN HRW_EARNER_FAMILY.REPRE_NUM IS '�ֹι�ȣ';
COMMENT ON COLUMN HRW_EARNER_FAMILY.RELATION_ID IS '����ID';
COMMENT ON COLUMN HRW_EARNER_FAMILY.NATIONALITY_TYPE IS '���ܱ��α���';
COMMENT ON COLUMN HRW_EARNER_FAMILY.DISABILITY_YN IS '����� Y/N';
COMMENT ON COLUMN HRW_EARNER_FAMILY.SUPPORT_YN IS '�ξ翩��';
COMMENT ON COLUMN HRW_EARNER_FAMILY.DESCRIPTION IS '���';
COMMENT ON COLUMN HRW_EARNER_FAMILY.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRW_EARNER_FAMILY.CREATED_BY IS '������';
COMMENT ON COLUMN HRW_EARNER_FAMILY.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRW_EARNER_FAMILY.LAST_UPDATED_BY IS '����������';

-- PK.
ALTER TABLE HRW_EARNER_FAMILY ADD CONSTRAINTS HRW_EARNER_FAMILY_PK PRIMARY KEY(EARNER_ID, REPRE_NUM, SOB_ID, ORG_ID);
CREATE UNIQUE INDEX HRW_EARNER_FAMILY_U1 ON HRW_EARNER_FAMILY(EARNER_FAMILY_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE
CREATE SEQUENCE HRW_EARNER_FAMILY_S1;
-- ANALYZE.
ANALYZE TABLE HRW_EARNER_FAMILY COMPUTE STATISTICS;
ANALYZE INDEX HRW_EARNER_FAMILY_U1 COMPUTE STATISTICS;
