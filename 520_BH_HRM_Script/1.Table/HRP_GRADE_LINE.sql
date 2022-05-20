/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_GRADE_LINE
/* Description  : 호봉 관리 : LINE - 호봉 항목별 STEP 및 금액 .
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
COMMENT ON COLUMN HRP_GRADE_LINE.GRADE_LINE_ID IS '호봉 LINE ID';
COMMENT ON COLUMN HRP_GRADE_LINE.GRADE_HEADER_ID IS '호봉 HEADER ID';
COMMENT ON COLUMN HRP_GRADE_LINE.GRADE_STEP IS '호봉 등급';
COMMENT ON COLUMN HRP_GRADE_LINE.ALLOWANCE_ID IS '지급항목 ID';
COMMENT ON COLUMN HRP_GRADE_LINE.ALLOWANCE_AMOUNT IS '지급 금액';
COMMENT ON COLUMN HRP_GRADE_LINE.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRP_GRADE_LINE.ENABLED_FLAG IS '사용여부';
COMMENT ON COLUMN HRP_GRADE_LINE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRP_GRADE_LINE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRP_GRADE_LINE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRP_GRADE_LINE.LAST_UPDATED_BY IS '최종수정자';

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
