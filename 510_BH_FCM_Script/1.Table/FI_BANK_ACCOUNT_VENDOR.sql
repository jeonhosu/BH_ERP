/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_BANK_ACCOUNT_VENDOR
/* Description  : 거래처 은행계좌 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
--DROP TABLE FI_BANK_ACCOUNT CASCADE CONSTRAINTS ;

CREATE TABLE FI_BANK_ACCOUNT_VENDOR 
( BANK_ACCOUNT_ID               NUMBER           NOT NULL,
  SOB_ID                        NUMBER           NOT NULL,
  ORG_ID                        NUMBER           NOT NULL,  
  VENDOR_TYPE                   VARCHAR2(10)     NOT NULL,    -- 거래처구분(CUSTOMER-고객사, SUPPLIER-공급사).
  VENDOR_ID                     NUMBER           ,            /* 공급사, 고객사 ID */
  BANK_ACCOUNT_CODE             VARCHAR2(50)     NOT NULL,    /* 계좌코드 */
  BANK_ACCOUNT_NAME             VARCHAR2(100)    NOT NULL,    /* 계좌명 */
  BANK_ID                       NUMBER           NOT NULL,    /* 은행 ID */
  BANK_ACCOUNT_NUM              VARCHAR2(50)     NOT NULL,    /* 계좌번호 */  
  OWNER_NAME                    VARCHAR2(100)    ,            /* 예금주 */
  ACCOUNT_TYPE                  VARCHAR2(70)     ,            /* 계좌 종류 */        
  CURRENCY_CODE                 VARCHAR2(10)     ,            /* 통화 */
  REMARK                        VARCHAR2(100)    ,            /* 적요 */
  ATTRIBUTE_A                   VARCHAR2(250)    ,
  ATTRIBUTE_B                   VARCHAR2(250)    ,
  ATTRIBUTE_C                   VARCHAR2(250)    ,
  ATTRIBUTE_D                   VARCHAR2(250)    ,
  ATTRIBUTE_E                   VARCHAR2(250)    ,
  ATTRIBUTE_1                   NUMBER           ,
  ATTRIBUTE_2                   NUMBER           ,
  ATTRIBUTE_3                   NUMBER           ,
  ATTRIBUTE_4                   NUMBER           ,
  ATTRIBUTE_5                   NUMBER           ,
  ENABLED_FLAG                  VARCHAR2(1)      DEFAULT 'Y', /* 사용(Y/N) */
  EFFECTIVE_DATE_FR             DATE             NOT NULL, 
  EFFECTIVE_DATE_TO             DATE             ,
  CREATION_DATE                 DATE             NOT NULL,    /* 생성자 */
  CREATED_BY                    NUMBER           NOT NULL,    /* 생성일 */
  LAST_UPDATE_DATE              DATE             NOT NULL,    /* 수정자 */
  LAST_UPDATED_BY               NUMBER           NOT NULL     /* 수정일 */ 
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE  FI_BANK_ACCOUNT_VENDOR IS '거래처 계좌번호마스터';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_ID IS '은행계좌 ID';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.VENDOR_TYPE IS '거래처구분(CUSTOMER-고객사, SUPPLIER-공급사)';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.VENDOR_ID IS '공급사, 고객사 ID';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_CODE IS '계좌코드';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_NAME IS '계좌명';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.BANK_ID IS '은행ID(공통코드:BANK_CODE)';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.BANK_ACCOUNT_NUM IS '계좌번호';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.OWNER_NAME IS '예금주';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.ACCOUNT_TYPE IS '계좌 종류(공통코드:ACCOUNT_TYPE)';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.REMARK IS '비고';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.ENABLED_FLAG IS '사용(Y/N)';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.EFFECTIVE_DATE_FR IS '유효적용 시작일자';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.EFFECTIVE_DATE_TO IS '유효적용 종료일자';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.CREATION_DATE IS '생성자';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.CREATED_BY IS '생성일';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.LAST_UPDATE_DATE IS '수정자';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT_VENDOR.LAST_UPDATED_BY IS '수정일';

-- Primary Key.
ALTER TABLE FI_BANK_ACCOUNT_VENDOR ADD CONSTRAINTS FI_BANK_ACCOUNT_VENDOR_PK PRIMARY KEY(BANK_ACCOUNT_CODE, SOB_ID, ORG_ID);

-- Unique Index.
CREATE UNIQUE INDEX FI_BANK_ACCOUNT_VENDOR_U1 ON FI_BANK_ACCOUNT_VENDOR(BANK_ACCOUNT_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BANK_ACCOUNT_VENDOR_N9 ON FI_BANK_ACCOUNT_VENDOR(BANK_ACCOUNT_CODE, SOB_ID, ORG_ID, ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE FI_BANK_ACCOUNT_VENDOR_S1;
