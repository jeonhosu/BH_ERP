/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_FOREIGN_LANGUAGE
/* Description  : 외국어 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_FOREIGN_LANGUAGE              
( PERSON_ID                       NUMBER NOT NULL,
  LANGUAGE_ID                     NUMBER NOT NULL,
  EXAM_DATE	                      DATE   NOT NULL,
  EXAM_ID	                        NUMBER NOT NULL,
  EXAM_ORG_NAME                   VARCHAR2(100),
  LC	                            NUMBER DEFAULT 0,
  WC                              NUMBER DEFAULT 0,
  RC	                            NUMBER DEFAULT 0,
  SC                              NUMBER DEFAULT 0,
  SCORE	                          NUMBER DEFAULT 0,
  EXAM_LEVEL                      VARCHAR2(20),
  DESCRIPTION                     VARCHAR2(100),
  ATTRIBUTE1                      VARCHAR2(100),
  ATTRIBUTE2                      VARCHAR2(100),
  ATTRIBUTE3                      VARCHAR2(100),
  ATTRIBUTE4                      VARCHAR2(100),
  ATTRIBUTE5                      VARCHAR2(100),
  CREATION_DATE                   DATE NOT NULL,
  CREATED_BY                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                DATE NOT NULL,
  LAST_UPDATED_BY                 NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRM_FOREIGN_LANGUAGE IS '어학사항 관리';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.LANGUAGE_ID IS '어학ID';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.EXAM_DATE IS '응시일자';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.EXAM_ID IS '어학/검정 종류';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.EXAM_ORG_NAME IS '평가 기관';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.LC IS '듣기 점수';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.WC IS '쓰기 점수';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.RC IS '읽기 점수';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.SC IS '말하기 점수';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.SCORE IS '총점';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.EXAM_LEVEL IS '어학 등급';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_FOREIGN_LANGUAGE.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_FOREIGN_LANGUAGE_U1 ON HRM_FOREIGN_LANGUAGE(PERSON_ID, LANGUAGE_ID, EXAM_DATE) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRM_FOREIGN_LANGUAGE COMPUTE STATISTICS;
ANALYZE INDEX HRM_FOREIGN_LANGUAGE_U1 COMPUTE STATISTICS;
