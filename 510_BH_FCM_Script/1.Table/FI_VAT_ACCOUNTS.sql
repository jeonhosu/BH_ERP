/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_ACCOUNTS
/* Description  : 부가세관련 계정.
/*
/* Reference by : FI_ACCOUNT_CONTROL에서 VAT_ENABLED_FLAG 변경시 TRIGGER를 통해 반영됨.
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_ACCOUNTS
( ACCOUNT_CONTROL_ID              NUMBER        NOT NULL,
  ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL,
  SOB_ID                          NUMBER        NOT NULL,
  VAT_GUBUN                       VARCHAR2(10)  ,
  VAT_TYPE                        VARCHAR2(10)  ,
  VAT_ENABLED_FLAG                VARCHAR2(10)  ,    
  VAT_ASSET_GB                    VARCHAR2(10)  ,
  VAT_DOCUMENT_TYPE               VARCHAR2(10)  ,
  ENABLED_FLAG                    CHAR(1)       DEFAULT 'Y',
  ATTRIBUTE_A                     VARCHAR2(100) ,
  ATTRIBUTE_B                     VARCHAR2(100) ,
  ATTRIBUTE_C                     VARCHAR2(100) ,
  ATTRIBUTE_D                     VARCHAR2(100) ,
  ATTRIBUTE_E                     VARCHAR2(100) ,
  ATTRIBUTE_1                     NUMBER        ,
  ATTRIBUTE_2                     NUMBER        ,
  ATTRIBUTE_3                     NUMBER        ,
  ATTRIBUTE_4                     NUMBER        ,
  ATTRIBUTE_5                     NUMBER        ,
  CREATION_DATE                   DATE          NOT NULL,
  CREATED_BY                      NUMBER        NOT NULL,
  LAST_UPDATE_DATE                DATE          NOT NULL,
  LAST_UPDATED_BY                 NUMBER        NOT NULL
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_VAT_ACCOUNTS IS '부가세관련 계정관리';
COMMENT ON COLUMN FI_VAT_ACCOUNTS.ACCOUNT_CONTROL_ID IS '계정 ID';
COMMENT ON COLUMN FI_VAT_ACCOUNTS.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN FI_VAT_ACCOUNTS.VAT_GUBUN IS '매입매출구분';
COMMENT ON COLUMN FI_VAT_ACCOUNTS.VAT_TYPE IS '계산서유형';
COMMENT ON COLUMN FI_VAT_ACCOUNTS.VAT_ENABLED_FLAG IS 'VAT 관리여부(트리거를 통해서만 수정)';
COMMENT ON COLUMN FI_VAT_ACCOUNTS.VAT_ASSET_GB IS '감가상각자산 구분';
COMMENT ON COLUMN FI_VAT_ACCOUNTS.VAT_DOCUMENT_TYPE IS '영세율서류 유형';
COMMENT ON COLUMN FI_VAT_ACCOUNTS.ENABLED_FLAG  IS '사용 여부';

ALTER TABLE FI_VAT_ACCOUNTS ADD CONSTRAINT FI_VAT_ACCOUNTS_PK PRIMARY KEY (ACCOUNT_CONTROL_ID);

CREATE UNIQUE INDEX FI_VAT_ACCOUNTS_U1 ON FI_VAT_ACCOUNTS(ACCOUNT_CODE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_ACCOUNTS_N1 ON FI_VAT_ACCOUNTS(VAT_TYPE, VAT_ASSET_GB, ENABLED_FLAG, SOB_ID) TABLESPACE FCM_TS_IDX;  
CREATE INDEX FI_VAT_ACCOUNTS_N2 ON FI_VAT_ACCOUNTS(VAT_TYPE, VAT_DOCUMENT_TYPE, ENABLED_FLAG, SOB_ID) TABLESPACE FCM_TS_IDX;

ANALYZE TABLE FI_VAT_ACCOUNTS COMPUTE STATISTICS;
ANALYZE INDEX FI_VAT_ACCOUNTS_U1 COMPUTE STATISTICS;
ANALYZE INDEX FI_VAT_ACCOUNTS_N1 COMPUTE STATISTICS;
ANALYZE INDEX FI_VAT_ACCOUNTS_N2 COMPUTE STATISTICS;
