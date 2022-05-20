/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BALANCE_STATEMENT_EXCHANGE_EXCHANGE
/* Description  : 계정잔액명세서 잔액 관리 - 외화 재평가 위한 환율관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BALANCE_STATEMENT_EXCHANGE
( GL_DATE                     DATE          NOT NULL,    -- 잔액일자.
  CURRENCY_CODE               VARCHAR2(20)  NOT NULL,    -- 통화.
  SOB_ID                      NUMBER        NOT NULL,
  EXCHANGE_RATE               NUMBER        DEFAULT 0,   -- 환산환율.
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

COMMENT ON TABLE FI_BALANCE_STATEMENT_EXCHANGE IS '계정잔액명세서 : 외화재평가 위한 환율관리';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_EXCHANGE.GL_DATE IS '환율일자';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_EXCHANGE.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_EXCHANGE.SOB_ID IS '회사ID';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_EXCHANGE.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN FI_BALANCE_STATEMENT_EXCHANGE.DESCRIPTION IS '비고';

-- INDEX.
ALTER TABLE FI_BALANCE_STATEMENT_EXCHANGE ADD CONSTRAINT FI_BALANCE_STATEMENT_EXCHANGE PRIMARY KEY(GL_DATE, CURRENCY_CODE, SOB_ID);
