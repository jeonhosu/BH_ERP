/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_BANK_ACCOUNT
/* Description  : 은행계좌 관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
--DROP TABLE FI_BANK_ACCOUNT CASCADE CONSTRAINTS ;

CREATE TABLE FI_BANK_ACCOUNT 
( BANK_ACCOUNT_ID               NUMBER           NOT NULL,
  SOB_ID                        NUMBER           NOT NULL,
  ORG_ID                        NUMBER           NOT NULL,  
  BANK_ACCOUNT_CODE             VARCHAR2(50)     NOT NULL,   /* 계좌코드 */
  BANK_ACCOUNT_NAME             VARCHAR2(100)    NOT NULL,   /* 계좌명 */
  BANK_ID                       NUMBER           NOT NULL,   /* 은행 ID */
  BANK_ACCOUNT_NUM              VARCHAR2(50)     NOT NULL,   /* 계좌번호 */  
  OWNER_NAME                    VARCHAR2(100)    ,           /* 예금주 */
  ACCOUNT_TYPE                  VARCHAR2(70)     ,           /* 예적금 종류(지급, 수금, 예금) */        
  GL_CONTROL_YN                 VARCHAR2(1)      ,           /* 예,적금 원장관리 여부 */  
  CURRENCY_CODE                 VARCHAR2(10)     ,            /* 통화 */
  LIMIT_AMOUNT                  NUMBER(16,4)     DEFAULT 0,   /* 한도금액 */
  USE_AMOUNT                    NUMBER(16,4)     DEFAULT 0,   /* 사용금액 */  
  REMAIN_AMOUNT                 NUMBER(16,4)     DEFAULT 0,   /* 잔액 금액 */
  ACCOUNT_OWNER_TYPE            VARCHAR2(70)     NOT NULL,    /* 계좌 소유주 타입(자사, 공급사, 고객사) */
  SUPPLIER_CUSTOMER_ID          NUMBER           ,            /* 공급사, 고객사 ID */  
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

COMMENT ON TABLE  FI_BANK_ACCOUNT IS '은행계좌번호마스터';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.BANK_ACCOUNT_ID IS '은행계좌 ID';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.BANK_ACCOUNT_CODE IS '계좌코드';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.BANK_ACCOUNT_NAME IS '계좌명';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.BANK_ID IS '은행ID';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.BANK_ACCOUNT_NUM IS '계좌번호';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.OWNER_NAME IS '예금주';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.ACCOUNT_TYPE IS '예적금 종류(지급, 수금, 예금)';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.GL_CONTROL_YN IS '예적금 원장관리 여부';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.LIMIT_AMOUNT IS '한도';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.USE_AMOUNT IS '사용금액';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.REMAIN_AMOUNT IS '잔액금액';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.ACCOUNT_OWNER_TYPE IS '계좌 소유주 타입(자사,공급사,고객사)';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.SUPPLIER_CUSTOMER_ID IS '공급사, 고객사 ID';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.REMARK IS '비고';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.ENABLED_FLAG IS '사용(Y/N)';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.EFFECTIVE_DATE_FR IS '유효적용 시작일자';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.EFFECTIVE_DATE_TO IS '유효적용 종료일자';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.CREATION_DATE IS '생성자';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.CREATED_BY IS '생성일';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.LAST_UPDATE_DATE IS '수정자';
COMMENT ON COLUMN APPS.FI_BANK_ACCOUNT.LAST_UPDATED_BY IS '수정일';

-- Primary Key.
CREATE UNIQUE INDEX FI_BANK_ACCOUNT_PK ON 
  FI_BANK_ACCOUNT(BANK_ACCOUNT_CODE, SOB_ID)  
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
          
ALTER TABLE FI_BANK_ACCOUNT ADD ( 
  CONSTRAINT FI_BANK_ACCOUNT_PK PRIMARY KEY (BANK_ACCOUNT_CODE, SOB_ID)
        );

-- Unique Index.
CREATE UNIQUE INDEX FI_BANK_ACCOUNT_U1 ON FI_BANK_ACCOUNT(BANK_ACCOUNT_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BANK_ACCOUNT_N1 ON FI_BANK_ACCOUNT(SOB_ID, BANK_ACCOUNT_NUM) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BANK_ACCOUNT_N2 ON FI_BANK_ACCOUNT(SOB_ID, ACCOUNT_OWNER_TYPE, ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE FI_BANK_ACCOUNT_S1;
