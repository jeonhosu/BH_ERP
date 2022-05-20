/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_VISITOR_CARD
/* Description  : 방문자 카드 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_VISITOR_CARD      
( VISITOR_CARD_ID                                 NUMBER NOT NULL,
  VISITOR_NAME                                    VARCHAR2(100) NOT NULL,
	CORP_ID                                         NUMBER NOT NULL,
	CARD_NUM                                        VARCHAR2(100),
	CARD_ID                                         NUMBER,
	CARD_NAME                                       VARCHAR2(100),
  DESCRIPTION                                     VARCHAR2(100),
	ATTRIBUTE1                                      VARCHAR2(100),
	ATTRIBUTE2                                      VARCHAR2(100),
	ATTRIBUTE3                                      VARCHAR2(100),
	ATTRIBUTE4                                      VARCHAR2(100),
	ATTRIBUTE5                                      VARCHAR2(100),
  ENDABLED_FLAG                                   VARCHAR2(1),
	EFFECTIVE_DATE_FR                               DATE NOT NULL,
	EFFECTIVE_DATE_TO                               DATE,
  SOB_ID                                          NUMBER NOT NULL,
  ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER  NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_VISITOR_CARD.VISITOR_CARD_ID IS '방문자 카드ID';
COMMENT ON COLUMN HRM_VISITOR_CARD.VISITOR_NAME IS '방문자명';
COMMENT ON COLUMN HRM_VISITOR_CARD.CORP_ID IS '카드 ID';
COMMENT ON COLUMN HRM_VISITOR_CARD.CARD_NUM IS '카드번호';
COMMENT ON COLUMN HRM_VISITOR_CARD.CARD_NAME IS '카드명';
COMMENT ON COLUMN HRM_VISITOR_CARD.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRM_VISITOR_CARD.ENABLED_FLAG IS '사용 FLAG';
COMMENT ON COLUMN HRM_VISITOR_CARD.EFFECTIVE_DATE_FR IS '시작일자';
COMMENT ON COLUMN HRM_VISITOR_CARD.EFFECTIVE_DATE_TO IS '종료일자';
COMMENT ON COLUMN HRM_VISITOR_CARD.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRM_VISITOR_CARD.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_VISITOR_CARD.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_VISITOR_CARD.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_VISITOR_CARD_U1 ON HRM_VISITOR_CARD(VISITOR_CARD_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE HRM_VISITOR_CARD_S1;
CREATE SEQUENCE HRM_VISITOR_CARD_S1;

-- ANALYZE.
ANALYZE TABLE HRM_VISITOR_CARD COMPUTE STATISTICS;
ANALYZE INDEX HRM_VISITOR_CARD_U1 COMPUTE STATISTICS;


