/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_ACCT_MGMT_BALANCE_ITEM
/* Description  :  계좌 및 관리항목별 일계마감 테이블.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_ACCT_MGMT_BALANCE_ITEM
( ACCT_MGMT_BALANCE_ID        NUMBER        NOT NULL,  -- 계정관리항목별 잔액 ID
  SOB_ID                      NUMBER        NOT NULL,
  BALANCE_ITEM_SEQ            NUMBER        DEFAULT 1, -- 일련번호.
  MANAGEMENT_ID               NUMBER        NOT NULL,  -- 관리항목ID
  MANAGEMENT_CODE             VARCHAR2(20)  NOT NULL,  -- 관리항목코드
  MANAGEMENT_VALUE            VARCHAR2(100) NOT NULL,  -- 관리항목 값.
  MANGEMENT_TAG               VARCHAR2(100) ,   
  DESCRIPTION                 VARCHAR2(150) ,
  ATTRIBUTE_A                 VARCHAR2(150) ,
  ATTRIBUTE_B                 VARCHAR2(150) ,
  ATTRIBUTE_C                 VARCHAR2(150) ,
  ATTRIBUTE_1                 NUMBER        ,
  ATTRIBUTE_2                 NUMBER        ,
  ATTRIBUTE_3                 NUMBER        ,
  CREATION_DATE               DATE          NOT NULL,  -- 생성자.
  CREATED_BY                  NUMBER        NOT NULL,  -- 생성일.
  LAST_UPDATE_DATE            DATE          NOT NULL,  -- 수정자.
  LAST_UPDATED_BY             NUMBER        NOT NULL   -- 수정일.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_ACCT_MGMT_BALANCE_ITEM IS '일계마감테이블';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE_ITEM.ACCT_MGMT_BALANCE_ID IS '계정관리항목별 잔액 ID';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE_ITEM.SOB_ID IS '회사ID';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE_ITEM.BALANCE_ITEM_SEQ IS '관리항목 순서';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE_ITEM.MANAGEMENT_ID IS '관리항목 ID';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE_ITEM.MANAGEMENT_CODE IS '관리항목CODE';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE_ITEM.MANAGEMENT_VALUE IS '관리항목 값';
COMMENT ON COLUMN FI_ACCT_MGMT_BALANCE_ITEM.MANGEMENT_TAG IS '관리항목 TAG';

CREATE UNIQUE INDEX FI_ACCT_MGMT_BALANCE_ITEM_PK ON 
  FI_ACCT_MGMT_BALANCE_ITEM(ACCT_MGMT_BALANCE_ID, SOB_ID, MANAGEMENT_ID, MANAGEMENT_VALUE)
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

ALTER TABLE FI_ACCT_MGMT_BALANCE_ITEM ADD ( 
  CONSTRAINT FI_ACCT_MGMT_BALANCE_ITEM_PK PRIMARY KEY (ACCT_MGMT_BALANCE_ID, SOB_ID, MANAGEMENT_ID, MANAGEMENT_VALUE)
        );

CREATE UNIQUE INDEX FI_ACCT_MGMT_BALANCE_ITEM_U1 ON FI_ACCT_MGMT_BALANCE_ITEM(ACCT_MGMT_BALANCE_ID, SOB_ID, BALANCE_ITEM_SEQ) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_ACCT_MGMT_BALANCE_ITEM_N1 ON FI_ACCT_MGMT_BALANCE_ITEM(MANAGEMENT_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_ACCT_MGMT_BALANCE_ITEM_N2 ON FI_ACCT_MGMT_BALANCE_ITEM(MANAGEMENT_VALUE, SOB_ID) TABLESPACE FCM_TS_IDX;
