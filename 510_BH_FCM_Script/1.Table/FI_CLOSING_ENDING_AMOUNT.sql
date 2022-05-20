/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM - GL
/* Program Name : FI_CLOSING_ENDING_AMOUNT
/* Description  : 회계 결산 기말금액 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_CLOSING_ENDING_AMOUNT              
( PERIOD_NAME           VARCHAR2(10)    NOT NULL,  /* 회계년월 */
  ACCOUNT_CONTROL_ID    NUMBER          NOT NULL,  /* 계정관리 ID */
  SOB_ID                NUMBER          NOT NULL,
  ORG_ID                NUMBER          NOT NULL,
  ENDING_AMOUNT         NUMBER          DEFAULT 0,
  REMARK                VARCHAR2(200)   ,          /* 계정설명 */  
  CREATION_DATE         DATE            NOT NULL,  /* 생성일자 */
  CREATED_BY            NUMBER          NOT NULL,  /* 생성자 */
  LAST_UPDATE_DATE      DATE            NOT NULL,  /* 최종수정일자 */
  LAST_UPDATED_BY       NUMBER          NOT NULL   /* 최종수정자 */
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE FI_CLOSING_ENDING_AMOUNT IS '결산 기말금액 관리';
COMMENT ON COLUMN FI_CLOSING_ENDING_AMOUNT.PERIOD_NAME IS '회계년월';
COMMENT ON COLUMN FI_CLOSING_ENDING_AMOUNT.ACCOUNT_CONTROL_ID IS '계정관리 ID';
COMMENT ON COLUMN FI_CLOSING_ENDING_AMOUNT.ENDING_AMOUNT IS '기말금액';
COMMENT ON COLUMN FI_CLOSING_ENDING_AMOUNT.REMARK IS '비고';
COMMENT ON COLUMN FI_CLOSING_ENDING_AMOUNT.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN FI_CLOSING_ENDING_AMOUNT.CREATED_BY IS '생성자';
COMMENT ON COLUMN FI_CLOSING_ENDING_AMOUNT.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN FI_CLOSING_ENDING_AMOUNT.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX FI_CLOSING_ENDING_AMOUNT_U1 ON FI_CLOSING_ENDING_AMOUNT(PERIOD_NAME, ACCOUNT_CONTROL_ID, SOB_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE FI_CLOSING_ENDING_AMOUNT COMPUTE STATISTICS;
ANALYZE INDEX FI_CLOSING_ENDING_AMOUNT_U1 COMPUTE STATISTICS;
