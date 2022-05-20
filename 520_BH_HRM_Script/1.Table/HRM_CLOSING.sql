/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_CLOSING
/* Description  : 근태/급여 마감 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_CLOSING
(CORP_ID	                                      NUMBER	NOT NULL,
  CLOSING_YYYYMM	                              VARCHAR2(7) NOT NULL,
  CLOSING_TYPE_ID	                              NUMBER,
  CLOSING_YN	                                  VARCHAR2(1) DEFAULT 'N',
  OPEN_DATE	                                    DATE,
  DESCRIPTION	                                  VARCHAR2(100),
  ATTRIBUTE1                                    VARCHAR2(100),
  ATTRIBUTE2                                    VARCHAR2(100),
  ATTRIBUTE3                                    VARCHAR2(100),
  ATTRIBUTE4                                    VARCHAR2(100),
  ATTRIBUTE5                                    VARCHAR2(100),
	SOB_ID                                        NUMBER NOT NULL,
	ORG_ID                                        NUMBER NOT NULL,
  CREATION_DATE                                 DATE NOT NULL,
  CREATED_BY                                    NUMBER NOT NULL,
  LAST_UPDATE_DATE                              DATE NOT NULL,
  LAST_UPDATED_BY                               NUMBER NOT NULL
)
  TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_CLOSING.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRM_CLOSING.CLOSING_YYYYMM IS '마감처리 년월';
COMMENT ON COLUMN HRM_CLOSING.CLOSING_TYPE_ID IS '마감 유형';
COMMENT ON COLUMN HRM_CLOSING.CLOSING_YN IS '마감 여부';
COMMENT ON COLUMN HRM_CLOSING.OPEN_DATE IS '오픈 일자';
COMMENT ON COLUMN HRM_CLOSING.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRM_CLOSING.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRM_CLOSING.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_CLOSING.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_CLOSING.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_CLOSING_U1 ON HRM_CLOSING(CORP_ID, CLOSING_YYYYMM, CLOSING_TYPE_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRM_CLOSING COMPUTE STATISTICS;
ANALYZE INDEX HRM_CLOSING_U1 COMPUTE STATISTICS;
