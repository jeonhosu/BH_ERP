-- 테이블명: APPS.FI_UNLIQUIDATE_SUMMARY
-- 테이블설명: 

/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_UNLIQUIDATE_SUMMARY
/* Description  : 미청산계정 이월집계내역
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_UNLIQUIDATE_SUMMARY
( PERIOD_NAME              VARCHAR2(10)     NOT NULL,  -- 회계년월.
  SLIP_LINE_ID             NUMBER           NOT NULL,  -- 전표 라인 ID.
  SOB_ID                   NUMBER           NOT NULL,
  ORG_ID                   NUMBER           NOT NULL,
  GL_DATE                  DATE             NOT NULL,  -- 회계일자. 
  ACCOUNT_BOOK_ID          NUMBER           NOT NULL,  -- 회계장부.
  ACCOUNT_CONTROL_ID       NUMBER           NOT NULL,  -- 계정통제ID.
  ACCOUNT_CODE             VARCHAR2(20)     NOT NULL,  -- 계정코드.
  CURRENCY_CODE            VARCHAR2(10)     NOT NULL,  -- 통화.
  CUSTOMER_ID              NUMBER           ,              -- 거래처코드.
  MANAGEMENT1              VARCHAR2(50)     ,              -- 관리항목1.
  MANAGEMENT2              VARCHAR2(50)     ,              -- 관리항목2.
  REMAIN_AMOUNT            NUMBER           DEFAULT 0,  -- 잔액(원화).
  REMAIN_CURR_AMOUNT       NUMBER           DEFAULT 0,  -- 잔액(외화).
  CREATION_DATE            DATE             NOT NULL, /* 생성자 */
  CREATED_BY               NUMBER           NOT NULL, /* 생성일 */
  LAST_UPDATE_DATE         DATE             NOT NULL, /* 수정자 */
  LAST_UPDATED_BY          NUMBER           NOT NULL  /* 수정일 */
) TABLESPACE FCM_TS_DATA;
);
COMMENT ON TABLE FI_UNLIQUIDATE_SUMMARY IS '미청산계정 이월집계내역';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.PERIOD_NAME IS '회계년월';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.SLIP_LINE_ID IS '전표 라인 ID.';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.GL_DATE IS '회계일자';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.ACCOUNT_BOOK_ID IS '회계장부';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.ACCOUNT_CONTROL_ID IS '계정통제ID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.CUSTOMER_ID IS '거래처코드';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.MANAGEMENT1 IS '관리항목1';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.MANAGEMENT2 IS '관리항목2';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.REMAIN_AMOUNT IS '잔액원화';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_SUMMARY.REMAIN_CURR_AMOUNT IS '잔액외화';

CREATE UNIQUE INDEX FI_UNLIQUIDATE_SUMMARY_PK ON 
  FI_UNLIQUIDATE_SUMMARY(ACCOUNT_BOOK_ID, PERIOD_NAME, SLIP_LINE_ID, GL_DATE, SOB_ID)
  TABLESPACE FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  LOGGING
  STORAGE (
           INITIAL 64K
           MINEXTENTS 1
           MAXEXTENTS 2147483645
          );

ALTER TABLE FI_UNLIQUIDATE_SUMMARY ADD ( 
  CONSTRAINT FI_UNLIQUIDATE_SUMMARY_PK PRIMARY KEY ( ACCOUNT_BOOK_ID, PERIOD_NAME, SLIP_LINE_ID, GL_DATE, SOB_ID)
        );
