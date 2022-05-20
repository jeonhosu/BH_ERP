/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FI
/* Program Name : FI_BUSINESS_MASTER
/* Description  : 사업장등록 관리
/* Reference by : 회계 사업장 정보 관리.
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BUSINESS_MASTER
( BUSINESS_ID                     NUMBER          NOT NULL,   -- 사업장ID.
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  BUSINESS_CODE                   VARCHAR2(20)    NOT NULL,   -- 사업장코드.
  BUSINESS_NAME                   VARCHAR2(100)   NOT NULL,   -- 사업장명.
  BUSINESS_NAME_1                 VARCHAR2(150)   ,           -- 사업장명 약어.
  BUSINESS_NAME_2                 VARCHAR2(200)   ,           -- 사업장명 영문.
  VAT_NUM                         VARCHAR2(100)   NOT NULL,   -- 사업자번호.
  PRESIDENT_NAME                  VARCHAR2(100)   NOT NULL,   -- 대표자.
  BUSINESS_TYPE                   VARCHAR2(150)   ,           -- 업종.
  BUSINESS_ITEM                   VARCHAR2(150)   ,           -- 업태.  
  TEL_NUM                         VARCHAR2(20)    ,           -- 전화.
  FAX_NUM                         VARCHAR2(20)    ,           -- 팩스.
  EMAIL                           VARCHAR2(100)   ,           -- EMAIL.
  ZIP_CODE                        VARCHAR2(20)    ,           -- 우편번호.
  ADDR1                           VARCHAR2(150)   ,           -- 주소1.
  ADDR2                           VARCHAR2(150)   ,           -- 주소2.
  CORPORATE_ID                    NUMBER          ,           -- 법인ID.
  TAX_OFFICE_CODE                 VARCHAR2(10)    ,           -- 세무서코드.
  BANK_CODE                       VARCHAR2(10)    ,           -- 은행코드.
  BANK_ACCOUNT_CODE               VARCHAR2(10)    ,           -- 은행계좌코드.
  ENABLED_FLAG                    CHAR(1)         ,           -- 사용.
  EFFECTIVE_DATE_FR               DATE NOT NULL   ,           -- 적용 시작일자.
  EFFECTIVE_DATE_TO               DATE            ,           -- 적용 종료일자.
  ATTRIBUTE_A                     VARCHAR2(100)   ,
  ATTRIBUTE_B                     VARCHAR2(100)   ,
  ATTRIBUTE_C                     VARCHAR2(100)   ,
  ATTRIBUTE_D                     VARCHAR2(100)   ,
  ATTRIBUTE_E                     VARCHAR2(100)   ,
  ATTRIBUTE_1                     NUMBER          ,
  ATTRIBUTE_2                     NUMBER          ,
  ATTRIBUTE_3                     NUMBER          ,
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN FI_BUSINESS_MASTER.BUSINESS_ID IS '사업장ID';
COMMENT ON COLUMN FI_BUSINESS_MASTER.BUSINESS_CODE IS '사업장코드';
COMMENT ON COLUMN FI_BUSINESS_MASTER.BUSINESS_NAME IS '사업장명';
COMMENT ON COLUMN FI_BUSINESS_MASTER.BUSINESS_NAME_1 IS '사업장명1';
COMMENT ON COLUMN FI_BUSINESS_MASTER.BUSINESS_NAME_2 IS '사업장명2';
COMMENT ON COLUMN FI_BUSINESS_MASTER.VAT_NUM IS '사업자번호';
COMMENT ON COLUMN FI_BUSINESS_MASTER.PRESIDENT_NAME IS '대표자';
COMMENT ON COLUMN FI_BUSINESS_MASTER.BUSINESS_TYPE IS '업종';
COMMENT ON COLUMN FI_BUSINESS_MASTER.BUSINESS_ITEM IS '업태';
COMMENT ON COLUMN FI_BUSINESS_MASTER.TEL_NUM IS '전화번호';
COMMENT ON COLUMN FI_BUSINESS_MASTER.FAX_NUM IS '팩스번호';
COMMENT ON COLUMN FI_BUSINESS_MASTER.EMAIL IS '이메일주소';
COMMENT ON COLUMN FI_BUSINESS_MASTER.ZIP_CODE IS '우편번호';
COMMENT ON COLUMN FI_BUSINESS_MASTER.ADDR1 IS '주소1';
COMMENT ON COLUMN FI_BUSINESS_MASTER.ADDR2 IS '주소2';
COMMENT ON COLUMN FI_BUSINESS_MASTER.CORPORATE_ID IS '법인ID';
COMMENT ON COLUMN FI_BUSINESS_MASTER.TAX_OFFICE_CODE IS '세무서코드';
COMMENT ON COLUMN FI_BUSINESS_MASTER.BANK_CODE IS '은행코드';
COMMENT ON COLUMN FI_BUSINESS_MASTER.BANK_ACCOUNT_CODE IS '은행계좌코드';
COMMENT ON COLUMN FI_BUSINESS_MASTER.ENABLED_FLAG IS '사용여부';
COMMENT ON COLUMN FI_BUSINESS_MASTER.EFFECTIVE_DATE_FR IS '적용 시작일자';
COMMENT ON COLUMN FI_BUSINESS_MASTER.EFFECTIVE_DATE_TO IS '적용 종료일자';
COMMENT ON COLUMN FI_BUSINESS_MASTER.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN FI_BUSINESS_MASTER.CREATED_BY IS '생성자';
COMMENT ON COLUMN FI_BUSINESS_MASTER.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN FI_BUSINESS_MASTER.LAST_UPDATED_BY IS '최종수정자';

-- PRKMARY KEY.
ALTER TABLE FI_BUSINESS_MASTER ADD CONSTRAINT FI_BUSINESS_MASTER_PK PRIMARY KEY(BUSINESS_CODE, SOB_ID);
-- CREATE INDEX.
CREATE UNIQUE INDEX FI_BUSINESS_MASTER_U1 ON FI_BUSINESS_MASTER(BUSINESS_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BUSINESS_MASTER_N1 ON FI_BUSINESS_MASTER(ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO, SOB_ID) TABLESPACE FCM_TS_IDX;

-- CREATE SEQUENCE;
CREATE SEQUENCE FI_BUSINESS_MASTER_S1;

-- ANALYZE.
ANALYZE TABLE FI_BUSINESS_MASTER COMPUTE STATISTICS;
ANALYZE INDEX FI_BUSINESS_MASTER_U1 COMPUTE STATISTICS;
ANALYZE INDEX FI_BUSINESS_MASTER_N1 COMPUTE STATISTICS;
