/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_MONTH_SETTLEMENT
/* Description  :  월마감 결산 자료 집계 테이블.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_MONTH_SETTLEMENT
( PERIOD_NAME                 VARCHAR2(7)   NOT NULL,     -- 회계일자.
  SOB_ID                      NUMBER        NOT NULL,     -- 회사코드.
  ORG_ID                      NUMBER        NOT NULL,     -- 사업부ID.
  FORM_HEADER_ID              NUMBER        NOT NULL,     -- 보고서 헤더 ID.
  FORM_ITEM_LEVEL             NUMBER        NOT NULL,     -- 보고서 항목 레벨.  
  GL_AMOUNT                   NUMBER        DEFAULT 0,    -- 금액.
  JOURNALIZE_AMOUNT           NUMBER        DEFAULT 0,    -- 분개대상.
  FORM_ITEM_TYPE              VARCHAR2(10)  ,             -- 보고서 항목 타입.
  FORM_ITEM_CLASS             VARCHAR2(10)  ,             -- 보고서 항목 분류.
  SLIP_YN                     CHAR(1)       DEFAULT 'N',  -- 전표 생성.
  CREATION_DATE               DATE          NOT NULL,     -- 생성자.
  CREATED_BY                  NUMBER        NOT NULL,     -- 생성일.
  LAST_UPDATE_DATE            DATE          NOT NULL,     -- 수정자.
  LAST_UPDATED_BY             NUMBER        NOT NULL      -- 수정일.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_MONTH_SETTLEMENT IS '월마감 결산자료 집계-사용안함';
COMMENT ON COLUMN APPS.FI_MONTH_SETTLEMENT.PERIOD_NAME IS '결산 년월';
COMMENT ON COLUMN APPS.FI_MONTH_SETTLEMENT.SOB_ID IS '회사ID';
COMMENT ON COLUMN APPS.FI_MONTH_SETTLEMENT.FORM_HEADER_ID IS '재무제표양식 헤더 ID';
COMMENT ON COLUMN APPS.FI_MONTH_SETTLEMENT.FORM_ITEM_LEVEL IS '재무제표 항목 레벨.';
COMMENT ON COLUMN APPS.FI_MONTH_SETTLEMENT.GL_AMOUNT IS '금액';
COMMENT ON COLUMN APPS.FI_MONTH_SETTLEMENT.JOURNALIZE_AMOUNT IS '분개대상금액';
COMMENT ON COLUMN APPS.FI_MONTH_SETTLEMENT.FORM_ITEM_TYPE IS '보고서 항목 타입';
COMMENT ON COLUMN APPS.FI_MONTH_SETTLEMENT.FORM_ITEM_CLASS IS '보고서 항목 분류';
COMMENT ON COLUMN APPS.FI_MONTH_SETTLEMENT.SLIP_YN IS '전표 생성Y/N';

CREATE UNIQUE INDEX FI_MONTH_SETTLEMENT_U1 ON FI_MONTH_SETTLEMENT(PERIOD_NAME, SOB_ID, FORM_HEADER_ID) TABLESPACE FCM_TS_IDX;
