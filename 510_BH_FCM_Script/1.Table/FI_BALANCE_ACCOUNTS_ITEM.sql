/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BALANCE_ACCOUNTS_ITEM
/* Description  : 계정잔액명세서 관리계정별 관리항목 정의
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BALANCE_ACCOUNTS_ITEM
( ACCOUNT_CONTROL_ID          NUMBER        NOT NULL,  -- 계정관리ID. 
  ACCOUNT_CODE                VARCHAR2(20)  NOT NULL,  -- 계정코드.
  SOB_ID                      NUMBER        NOT NULL,  
  MANAGEMENT_SEQ              NUMBER        DEFAULT 1,  -- 관리항목 순서.
  MANAGEMENT_ID               NUMBER        NOT NULL,  -- 관리항목 ID
  MANAGEMENT_CODE             VARCHAR2(20)  NOT NULL,  -- 관리항목CODE.  
  BALANCE_YN                  VARCHAR2(1)   DEFAULT 'N', -- 잔액정산여부.
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

COMMENT ON TABLE FI_BALANCE_ACCOUNTS_ITEM IS '계정잔액명세서 관리계정별 관리항목';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS_ITEM.ACCOUNT_CONTROL_ID IS '계정통제ID';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS_ITEM.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS_ITEM.SOB_ID IS '회사ID';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_SEQ IS '관리항목 순서';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_ID IS '관리항목 ID';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS_ITEM.MANAGEMENT_CODE IS '관리항목 코드';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS_ITEM.BALANCE_YN IS '잔액정산여부';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS_ITEM.DESCRIPTION IS '비고';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS_ITEM.ENABLED_FLAG IS '사용 여부';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS_ITEM.EFFECTIVE_DATE_FR IS '적용 시작일자';
COMMENT ON COLUMN FI_BALANCE_ACCOUNTS_ITEM.EFFECTIVE_DATE_TO IS '적용 종료일자';

-- INDEX.
ALTER TABLE FI_BALANCE_ACCOUNTS_ITEM ADD CONSTRAINT FI_BALANCE_ACCOUNTS_ITEM PRIMARY KEY(ACCOUNT_CONTROL_ID, MANAGEMENT_ID, SOB_ID);

CREATE UNIQUE INDEX FI_BALANCE_ACCOUNTS_ITEM_U1 ON FI_BALANCE_ACCOUNTS_ITEM(ACCOUNT_CODE, MANAGEMENT_ID, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BALANCE_ACCOUNTS_ITEM_N1 ON FI_BALANCE_ACCOUNTS_ITEM(MANAGEMENT_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BALANCE_ACCOUNTS_ITEM_N2 ON FI_BALANCE_ACCOUNTS_ITEM(MANAGEMENT_CODE, SOB_ID) TABLESPACE FCM_TS_IDX;
