/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_GRADE_HEADER
/* Description  : ȣ�� ���� : HEADER.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRP_GRADE_HEADER        
( GRADE_HEADER_ID                                 NUMBER NOT NULL,
  CORP_ID                                         NUMBER NOT NULL,
  START_YYYYMM	                                  VARCHAR2(7) NOT NULL,
  END_YYYYMM	                                    VARCHAR2(7) DEFAULT '2999-12',
  PAY_TYPE                                        VARCHAR2(2) NOT NULL,
  PAY_GRADE_ID                                    NUMBER NOT NULL,
  DESCRIPTION                                     VARCHAR2(100),
  ATTRIBUTE1                                      VARCHAR2(100),
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
  ENABLED_FLAG                                    VARCHAR2(1) DEFAULT 'Y',
  SOB_ID                                          NUMBER NOT NULL,
  ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRP_GRADE_HEADER.GRADE_HEADER_ID IS 'ȣ�� HEADER ID';
COMMENT ON COLUMN HRP_GRADE_HEADER.CORP_ID IS '��üID';
COMMENT ON COLUMN HRP_GRADE_HEADER.START_YYYYMM IS '���۳��';
COMMENT ON COLUMN HRP_GRADE_HEADER.END_YYYYMM IS '������';
COMMENT ON COLUMN HRP_GRADE_HEADER.PAY_TYPE IS '�޿��� Ÿ��';
COMMENT ON COLUMN HRP_GRADE_HEADER.PAY_GRADE_ID IS '���� ID';
COMMENT ON COLUMN HRP_GRADE_HEADER.DESCRIPTION IS '���';
COMMENT ON COLUMN HRP_GRADE_HEADER.ENABLED_FLAG IS '��뿩��';
COMMENT ON COLUMN HRP_GRADE_HEADER.CREATION_DATE  IS '��������';
COMMENT ON COLUMN HRP_GRADE_HEADER.CREATED_BY IS '������';
COMMENT ON COLUMN HRP_GRADE_HEADER.LAST_UPDATE_DATE IS '������������';
COMMENT ON COLUMN HRP_GRADE_HEADER.LAST_UPDATED_BY IS '����������';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRP_GRADE_HEADER_U1 ON HRP_GRADE_HEADER(GRADE_HEADER_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRP_GRADE_HEADER_U2 ON HRP_GRADE_HEADER(CORP_ID, START_YYYYMM, END_YYYYMM, PAY_TYPE, PAY_GRADE_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRP_GRADE_HEADER_S1;
CREATE SEQUENCE HRP_GRADE_HEADER_S1;

-- ANALYZE.
ANALYZE TABLE HRP_GRADE_HEADER COMPUTE STATISTICS;
ANALYZE INDEX HRP_GRADE_HEADER_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRP_GRADE_HEADER_U2 COMPUTE STATISTICS;
