/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM - GL
/* Program Name : FI_CLOSING_AMOUNT
/* Description  : 회계 결산 대체 금액 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_CLOSING_AMOUNT              
( PERIOD_NAME           VARCHAR2(10)    NOT NULL,  /* 마감 년월 */
  CLOSING_GROUP         VARCHAR2(20)    ,          /* 계정그룹 */
  ACCOUNT_CONTROL_ID    NUMBER          ,          /* 계정관리 ID */
  ACCOUNT_CODE          VARCHAR2(20)    ,          /* 계정코드 */
  ACCOUNT_DR_CR         VARCHAR2(1)     ,          /* 차대구분 */
  SOB_ID                NUMBER          NOT NULL,
  ORG_ID                NUMBER          NOT NULL,
  AMOUNT                NUMBER          DEFAULT 0,  
  REMARK                VARCHAR2(200)   ,          /* 계정설명 */  
  CREATION_DATE         DATE            NOT NULL,  /* 생성일자 */
  CREATED_BY            NUMBER          NOT NULL,  /* 생성자 */
  LAST_UPDATE_DATE      DATE            NOT NULL,  /* 최종수정일자 */
  LAST_UPDATED_BY       NUMBER          NOT NULL   /* 최종수정자 */
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE FI_CLOSING_AMOUNT IS '결산 대체 금액 관리';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.PERIOD_NAME IS '마감년월';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.CLOSING_GROUP IS '결산계정 그룹';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.ACCOUNT_CONTROL_ID IS '계정관리 ID';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.AMOUNT IS '금액';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.REMARK IS '비고';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.CREATED_BY IS '생성자';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN FI_CLOSING_AMOUNT.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE INDEX FI_CLOSING_AMOUNT_N1 ON FI_CLOSING_AMOUNT(ACCOUNT_CONTROL_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_CLOSING_AMOUNT_N2 ON FI_CLOSING_AMOUNT(ACCOUNT_CODE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_CLOSING_AMOUNT_N3 ON FI_CLOSING_AMOUNT(PERIOD_NAME, SOB_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE FI_CLOSING_AMOUNT COMPUTE STATISTICS;
ANALYZE INDEX FI_CLOSING_AMOUNT_N1 COMPUTE STATISTICS;
ANALYZE INDEX FI_CLOSING_AMOUNT_N2 COMPUTE STATISTICS;
ANALYZE INDEX FI_CLOSING_AMOUNT_N3 COMPUTE STATISTICS;
