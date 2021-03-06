/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_GRADE_LINE
/* Description  : ȣ?? ???? : LINE - ȣ?? ?׸??? STEP ?? ?ݾ? .
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRP_GRADE_LINE        
( GRADE_LINE_ID                                   NUMBER NOT NULL,
  GRADE_HEADER_ID                                 NUMBER NOT NULL,
  GRADE_STEP                                      NUMBER NOT NULL,
  ALLOWANCE_ID                                    NUMBER NOT NULL,
  ALLOWANCE_AMOUNT                                NUMBER DEFAULT 0,
  DESCRIPTION                                     VARCHAR2(100),
  ATTRIBUTE1                                      VARCHAR2(100),
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
  ENABLED_FLAG                                    VARCHAR2(1) DEFAULT 'Y',
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRP_GRADE_LINE.GRADE_LINE_ID IS 'ȣ?? LINE ID';
COMMENT ON COLUMN HRP_GRADE_LINE.GRADE_HEADER_ID IS 'ȣ?? HEADER ID';
COMMENT ON COLUMN HRP_GRADE_LINE.GRADE_STEP IS 'ȣ?? ????';
COMMENT ON COLUMN HRP_GRADE_LINE.ALLOWANCE_ID IS '?????׸? ID';
COMMENT ON COLUMN HRP_GRADE_LINE.ALLOWANCE_AMOUNT IS '???? ?ݾ?';
COMMENT ON COLUMN HRP_GRADE_LINE.DESCRIPTION IS '????';
COMMENT ON COLUMN HRP_GRADE_LINE.ENABLED_FLAG IS '???뿩??';
COMMENT ON COLUMN HRP_GRADE_LINE.CREATION_DATE  IS '????????';
COMMENT ON COLUMN HRP_GRADE_LINE.CREATED_BY IS '??????';
COMMENT ON COLUMN HRP_GRADE_LINE.LAST_UPDATE_DATE IS '????????????';
COMMENT ON COLUMN HRP_GRADE_LINE.LAST_UPDATED_BY IS '??????????';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRP_GRADE_LINE_U1 ON HRP_GRADE_LINE(GRADE_LINE_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRP_GRADE_LINE_U2 ON HRP_GRADE_LINE(GRADE_HEADER_ID, GRADE_STEP, ALLOWANCE_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRP_GRADE_LINE_S1;
CREATE SEQUENCE HRP_GRADE_LINE_S1;

-- ANALYZE.
ANALYZE TABLE HRP_GRADE_LINE COMPUTE STATISTICS;
ANALYZE INDEX HRP_GRADE_LINE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRP_GRADE_LINE_U2 COMPUTE STATISTICS;
