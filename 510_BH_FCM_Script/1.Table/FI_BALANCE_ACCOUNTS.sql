/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BALANCE_ACCOUNTS
/* Description  : 계정잔액명세서 관리계정
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BALANCE_ACCOUNTS
( ACCOUNT_CONTROL_ID          NUMBER        NOT NULL,    -- 계정관리ID. 
  ACCOUNT_CODE                VARCHAR2(20)  NOT NULL,    -- 계정코드.
  SOB_ID                      NUMBER        NOT NULL,    
  CONTROL_CURRENCY_YN         VARCHAR2(1)   DEFAULT 'N',  -- 외화관리.
  ESTIMATE_YN                 VARCHAR2(1)   DEFAULT 'N',  -- 환평가.
  DESCRIPTION                 VARCHAR2(200) ,
  ENABLED_FLAG                VARCHAR2(1)   DEFAULT 'Y',
  EFFECTIVE_DATE_FR           DATE          NOT NULL,
  EFFECTIVE_DATE_TO           DATE          ,
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

COMMENT ON TABLE FI_BALANCE_ACCOUNTS IS '계정잔액명세서 관리계정';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS.ACCOUNT_CONTROL_ID IS '계정통제ID';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS.SOB_ID IS '회사ID';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS.CONTROL_CURRENCY_YN IS '외화관리 여부';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS.ESTIMATE_YN IS '환평가 적용여부';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS.DESCRIPTION IS '비고';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS.ENABLED_FLAG IS '사용 여부';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS.EFFECTIVE_DATE_FR IS '적용 시작일자';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS.EFFECTIVE_DATE_TO IS '적용 종료일자';

-- INDEX.
ALTER TABLE FI_BALANCE_ACCOUNTS ADD CONSTRAINT FI_BALANCE_ACCOUNTS PRIMARY KEY(ACCOUNT_CONTROL_ID);

CREATE UNIQUE INDEX FI_BALANCE_ACCOUNTS_U1 ON FI_BALANCE_ACCOUNTS(ACCOUNT_CODE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BALANCE_ACCOUNTS_N1 ON FI_BALANCE_ACCOUNTS(SOB_ID, ESTIMATE_YN, ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BALANCE_ACCOUNTS_N2 ON FI_BALANCE_ACCOUNTS(SOB_ID, ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;
