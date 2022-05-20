/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BANK
/* Description  : 금융기관MASTER
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BANK
( BANK_ID                         NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  BANK_GROUP                      VARCHAR2(20)    NOT NULL, /* 금융기관 그룹코드 */
  BANK_CODE                       VARCHAR2(20)    NOT NULL,  /* 금융기관코드 */
  BANK_NAME                       VARCHAR2(100)   ,  /* 금융기관명(한글) */
  BANK_ENG_NAME                   VARCHAR2(100)   ,  /* 금융기관명(영문) */
  BANK_TYPE                       VARCHAR2(70)    ,  /* 금융기관유형 */
  VAT_NUMBER                      VARCHAR2(30)    ,  /* 사업자 등록번호 */
  DC_LIMIT_AMOUNT                 NUMBER(11)      ,  /* 할인한도금액 */
  DC_METHOD_ID                    NUMBER          ,  /* 할인료계산방법 */
  DC_RATE1                        NUMBER(7,4)     ,  /* 할인율(90일 이전) */
  DC_RATE2                        NUMBER(7,4)     ,  /* 할인율(90일 이후) */
  LOAN_LIMIT_AMOUNT               NUMBER(11)      ,  /* 차월한도금액 */
  START_DATE                      DATE            ,  /* 거래 개시일 */
  REMARK                          VARCHAR2(250)   ,
  ATTRIBUTE_A                     VARCHAR2(250)   ,
  ATTRIBUTE_B                     VARCHAR2(250)   ,
  ATTRIBUTE_C                     VARCHAR2(250)   ,
  ATTRIBUTE_D                     VARCHAR2(250)   ,
  ATTRIBUTE_E                     VARCHAR2(250)   ,
  ATTRIBUTE_1                     NUMBER          ,
  ATTRIBUTE_2                     NUMBER          ,
  ATTRIBUTE_3                     NUMBER          ,
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          ,
  ENABLED_FLAG                    VARCHAR2(1)     , /* 사용여부 */
  EFFECTIVE_DATE_FR               DATE            NOT NULL, /* 유효적용 시작일자 */
  EFFECTIVE_DATE_TO               DATE            ,   /* 유효적용 종료일자 */
  CREATION_DATE                   DATE            NOT NULL, /* 생성자 */
  CREATED_BY                      NUMBER          NOT NULL, /* 생성일 */
  LAST_UPDATE_DATE                DATE            NOT NULL, /* 수정자 */
  LAST_UPDATED_BY                 NUMBER          NOT NULL  /* 수정일 */
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_BANK IS '금융기관(은행)MASTER';
COMMENT ON COLUMN APPS.FI_BANK.BANK_ID IS '금융기관ID';
COMMENT ON COLUMN APPS.FI_BANK.BANK_GROUP IS '금융기관 그룹코드';
COMMENT ON COLUMN APPS.FI_BANK.BANK_CODE IS '금융기관코드';
COMMENT ON COLUMN APPS.FI_BANK.BANK_NAME IS '금융기관명(한글)';
COMMENT ON COLUMN APPS.FI_BANK.BANK_ENG_NAME IS '금융기관명(영문)';
COMMENT ON COLUMN APPS.FI_BANK.BANK_TYPE IS '금융기관유형';
COMMENT ON COLUMN APPS.FI_BANK.VAT_NUMBER IS '사업자 등록번호';
COMMENT ON COLUMN APPS.FI_BANK.DC_LIMIT_AMOUNT IS '할인한도금액';
COMMENT ON COLUMN APPS.FI_BANK.DC_RATE1 IS '할인율(90일 이전)';
COMMENT ON COLUMN APPS.FI_BANK.LOAN_LIMIT_AMOUNT IS '차월한도금액';
COMMENT ON COLUMN APPS.FI_BANK.DC_RATE2 IS '할인율(90일 이후)';
COMMENT ON COLUMN APPS.FI_BANK.DC_METHOD_ID IS '할인료계산방법';
COMMENT ON COLUMN APPS.FI_BANK.START_DATE IS '거래시작일';
COMMENT ON COLUMN APPS.FI_BANK.ENABLED_FLAG IS '사용여부';
COMMENT ON COLUMN APPS.FI_BANK.EFFECTIVE_DATE_FR IS '유효적용 시작일자';
COMMENT ON COLUMN APPS.FI_BANK.EFFECTIVE_DATE_TO IS '유효적용 종료일자';
COMMENT ON COLUMN APPS.FI_BANK.CREATION_DATE IS '생성자';
COMMENT ON COLUMN APPS.FI_BANK.CREATED_BY IS '생성일';
COMMENT ON COLUMN APPS.FI_BANK.LAST_UPDATE_DATE IS '수정자';
COMMENT ON COLUMN APPS.FI_BANK.LAST_UPDATED_BY IS '수정일';

-- PRIMARY KEY
CREATE UNIQUE INDEX FI_BANK_PK ON 
  FI_BANK(BANK_ID)
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

ALTER TABLE FI_BANK ADD ( 
  CONSTRAINT FI_BANK_PK PRIMARY KEY ( BANK_ID ) 
        );
        
-- UNIQUE INDEX.
CREATE UNIQUE INDEX FI_BANK_U1 ON FI_BANK(BANK_GROUP, BANK_CODE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BANK_N1 ON FI_BANK(SOB_ID, BANK_GROUP, BANK_CODE, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE FI_BANK_S1;
CREATE SEQUENCE FI_BANK_S1;
       
