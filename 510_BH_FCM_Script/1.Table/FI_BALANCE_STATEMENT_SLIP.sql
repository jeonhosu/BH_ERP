/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BALANCE_STATEMENT_SLIP
/* Description  : 계정잔액명세서 생성 전표 및 금액 정보.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BALANCE_STATEMENT_SLIP
( GL_DATE                     DATE          NOT NULL,    -- 전표일자.
  ACCOUNT_CONTROL_ID          NUMBER        NOT NULL,    -- 계정관리ID. 
  ACCOUNT_CODE                VARCHAR2(20)  NOT NULL,    -- 계정코드.  
  CURRENCY_CODE               VARCHAR2(20)  NOT NULL,    -- 통화.
  ITEM_GROUP_ID               NUMBER        DEFAULT 1,   -- 관리항목 그룹 ID
  SOB_ID                      NUMBER        NOT NULL,
  DR_AMOUNT                   NUMBER        DEFAULT 0,   -- 증가금액
  CR_AMOUNT                   NUMBER        DEFAULT 0,   -- 감소금액.
  DR_CURR_AMOUNT              NUMBER        DEFAULT 0,   -- 외화 이월금액.
  CR_CURR_AMOUNT              NUMBER        DEFAULT 0,   -- 외화 증가금액.
  SLIP_LINE_ID                NUMBER        NOT NULL,    -- 전표 라인 ID
  SLIP_HEADER_ID              NUMBER        NOT NULL,    -- 전표 헤더 ID
  DESCRIPTION                 VARCHAR2(200) ,
  ATTRIBUTE_A                 VARCHAR2(250) ,    
  ATTRIBUTE_B                 VARCHAR2(250) ,    
  ATTRIBUTE_C                 VARCHAR2(250) ,    
  ATTRIBUTE_D                 VARCHAR2(250) ,    
  ATTRIBUTE_E                 VARCHAR2(250) ,    
  ATTRIBUTE_1                 NUMBER        ,    
  ATTRIBUTE_2                 NUMBER        ,    
  ATTRIBUTE_3                 NUMBER        ,    
  ATTRIBUTE_4                 NUMBER        ,
  ATTRIBUTE_5                 NUMBER        ,
  CREATION_DATE               DATE          NOT NULL,  -- 생성자.
  CREATED_BY                  NUMBER        NOT NULL,  -- 생성일.
  LAST_UPDATE_DATE            DATE          NOT NULL,  -- 수정자.
  LAST_UPDATED_BY             NUMBER        NOT NULL   -- 수정일.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_BALANCE_STATEMENT_SLIP IS '계정잔액명세서 적용 전표내역';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.GL_DATE IS '전표일자';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.ACCOUNT_CONTROL_ID IS '계정통제ID';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.ITEM_GROUP_ID IS '관리항목 그룹 ID';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.SOB_ID IS '회사ID';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.DR_AMOUNT IS '차변 금액';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.CR_AMOUNT IS '대변 금액';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.DR_CURR_AMOUNT IS '외화 차변금액';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.CR_CURR_AMOUNT IS '외화 대변금액';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.SLIP_LINE_ID IS '전표 라인ID';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.SLIP_HEADER_ID IS '전표 헤더ID';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_SLIP.DESCRIPTION IS '비고';

-- INDEX.
ALTER TABLE FI_BALANCE_STATEMENT_SLIP ADD CONSTRAINT FI_BALANCE_STATEMENT_SLIP PRIMARY KEY (SLIP_LINE_ID);

CREATE INDEX FI_BALANCE_STATEMENT_SLIP_N1 ON FI_BALANCE_STATEMENT_SLIP(GL_DATE, ACCOUNT_CONTROL_ID, CURRENCY_CODE, ITEM_GROUP_ID, SOB_ID);
CREATE INDEX FI_BALANCE_STATEMENT_SLIP_N2 ON FI_BALANCE_STATEMENT_SLIP(GL_DATE, ACCOUNT_CODE, CURRENCY_CODE, ITEM_GROUP_ID, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BALANCE_STATEMENT_SLIP_N3 ON FI_BALANCE_STATEMENT_SLIP(GL_DATE, ACCOUNT_CONTROL_ID, SOB_ID) TABLESPACE FCM_TS_IDX;
