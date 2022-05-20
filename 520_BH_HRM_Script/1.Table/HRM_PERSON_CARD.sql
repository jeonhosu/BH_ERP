/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_PERSON_CARD
/* Description  : 자격사항 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_PERSON_CARD              
(CARD_FLAG	                                VARCHAR2(5) NOT NULL,
  PERSON_ID	                                 NUMBER NOT NULL,
  CARD_NUM	                                 VARCHAR2(30) NOT NULL,
  USER_NUM  	                                VARCHAR2(20) NOT NULL,
  CARD_NAME	                                VARCHAR2(50),
  START_DATE	                              DATE,
  END_DATE	                                  DATE,
  DESCRIPTION                             VARCHAR2(100),
  ATTRIBUTE1                                  VARCHAR2(100),
  ATTRIBUTE2                                  VARCHAR2(100),
  ATTRIBUTE3                                  VARCHAR2(100),
  ATTRIBUTE4                                  VARCHAR2(100),
  ATTRIBUTE5                                  VARCHAR2(100),
  CREATION_DATE                            DATE NOT NULL,
  CREATED_BY                                  NUMBER NOT NULL,
  LAST_UPDATE_DATE                       DATE NOT NULL,
  LAST_UPDATED_BY                         NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_PERSON_CARD.CARD_FLAG IS '카드구분';
COMMENT ON COLUMN HRM_PERSON_CARD.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRM_PERSON_CARD.CARD_NUM IS '카드번호';
COMMENT ON COLUMN HRM_PERSON_CARD.USER_NUM IS '사용자번호';
COMMENT ON COLUMN HRM_PERSON_CARD.CARD_NAME IS '카드명';
COMMENT ON COLUMN HRM_PERSON_CARD.START_DATE IS '적용 시작일자';
COMMENT ON COLUMN HRM_PERSON_CARD.END_DATE IS '적용 종료일자';
COMMENT ON COLUMN HRM_PERSON_CARD.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRM_PERSON_CARD.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRM_PERSON_CARD.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_PERSON_CARD.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_PERSON_CARD.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_PERSON_CARD_U1 ON HRM_PERSON_CARD(CARD_FLAG, PERSON_ID, CARD_NUM) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRM_PERSON_CARD COMPUTE STATISTICS;
ANALYZE INDEX HRM_PERSON_CARD_U1 COMPUTE STATISTICS;
