/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRT_PAY_MST_COMMON_LINE
/* Description  : 급여마스터 공용 LINE 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRT_PAY_MST_COMMON_LINE              
( COMMON_LINE_ID                  NUMBER          NOT NULL,
  COMMON_HEADER_ID                NUMBER          NOT NULL,
  ALLOWANCE_TYPE                  VARCHAR2(1)     NOT NULL,
  ALLOWANCE_ID                    NUMBER          NOT NULL,
  ALLOWANCE_AMOUNT                NUMBER          DEFAULT 0,
  DESCRIPTION                     VARCHAR2(100)   ,
  ATTRIBUTE1                      VARCHAR2(100)   ,
  ATTRIBUTE2                      VARCHAR2(100)   ,
  ATTRIBUTE3                      VARCHAR2(100)   ,
  ATTRIBUTE4                      VARCHAR2(100)   ,
  ATTRIBUTE5                      VARCHAR2(100)   ,
  ENABLED_FLAG                    VARCHAR2(1)     DEFAULT 'Y',
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRT_PAY_MST_COMMON_LINE.COMMON_LINE_ID IS '급여마스터 공용 LINE ID';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_LINE.COMMON_HEADER_ID IS '급여공용 헤더 ID';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_LINE.ALLOWANCE_TYPE IS '지급공제 구분(A-지급, D-공제)';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_LINE.ALLOWANCE_ID IS '수당 ID';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_LINE.ALLOWANCE_AMOUNT IS '수당 금액';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_LINE.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_LINE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_LINE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_LINE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRT_PAY_MST_COMMON_LINE.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRT_PAY_MST_COMMON_LINE_U1 ON HRT_PAY_MST_COMMON_LINE(COMMON_LINE_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRT_PAY_MST_COMMON_LINE_U2 ON HRT_PAY_MST_COMMON_LINE(COMMON_HEADER_ID, ALLOWANCE_TYPE, ALLOWANCE_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE HRT_PAY_MST_COMMON_LINE_S1;

-- ANALYZE.
ANALYZE TABLE HRT_PAY_MST_COMMON_LINE COMPUTE STATISTICS;
ANALYZE INDEX HRT_PAY_MST_COMMON_LINE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRT_PAY_MST_COMMON_LINE_U2 COMPUTE STATISTICS;
