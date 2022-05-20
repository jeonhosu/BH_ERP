/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_BANK_ACCOUNT_TL
/* Description  : 은행계좌 관리 - TERRITORY LANGUAGE.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BANK_ACCOUNT_TL
( BANK_ACCOUNT_ID               NUMBER           NOT NULL,
  SOB_ID                        NUMBER           NOT NULL,
  ORG_ID                        NUMBER           NOT NULL,  
  LANG_CODE                     VARCHAR2(50)     NOT NULL,
  BANK_ACCOUNT_NAME             VARCHAR2(100)    NOT NULL,   /* 계좌명 */
  OWNER_NAME                    VARCHAR2(100)    ,           /* 예금주 */
  REMARK                        VARCHAR2(200)    , 
  ATTRIBUTE_A                   VARCHAR2(250),
  ATTRIBUTE_B                   VARCHAR2(250),
  ATTRIBUTE_C                   VARCHAR2(250),
  ATTRIBUTE_D                   VARCHAR2(250),
  ATTRIBUTE_E                   VARCHAR2(250),
  ATTRIBUTE_1                   NUMBER,
  ATTRIBUTE_2                   NUMBER,
  ATTRIBUTE_3                   NUMBER,
  ATTRIBUTE_4                   NUMBER,
  ATTRIBUTE_5                   NUMBER,
  CREATION_DATE                 DATE NOT NULL,
  CREATED_BY                    NUMBER NOT NULL,
  LAST_UPDATE_DATE              DATE NOT NULL,
  LAST_UPDATED_BY               NUMBER NOT NULL
)
TABLESPACE FCM_TS_DATA
  PCTFREE 10
  INITRANS 1
  MAXTRANS 255
  STORAGE
  (
    INITIAL 64K
    MINEXTENTS 1
    MAXEXTENTS UNLIMITED
  );
  
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON TABLE FI_BANK_ACCOUNT_TL IS '은행 계좌 MASTER -다국어';
COMMENT ON COLUMN FI_BANK_ACCOUNT_TL.BANK_ACCOUNT_ID IS '계좌 ID';
COMMENT ON COLUMN FI_BANK_ACCOUNT_TL.BANK_ACCOUNT_NAME IS '계좌설명';
COMMENT ON COLUMN FI_BANK_ACCOUNT_TL.OWNER_NAME IS '예금주';

-- CREATE/RECREATE INDEXES 
CREATE UNIQUE INDEX FI_BANK_ACCOUNT_TL_U1 ON FI_BANK_ACCOUNT_TL (BANK_ACCOUNT_ID)
  TABLESPACE FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  STORAGE
  (
    INITIAL 64K
    MINEXTENTS 1
    MAXEXTENTS UNLIMITED
  );
