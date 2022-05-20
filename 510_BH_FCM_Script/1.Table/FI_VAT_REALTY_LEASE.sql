/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_REALTY_LEASE
/* Description  : 부동산 임대내역.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_REALTY_LEASE 
( REALTY_LEASE_ID                 NUMBER        NOT NULL,   -- 부동산 임대내역 ID.
  TAX_CODE                        VARCHAR2(10)  NOT NULL,   -- 사업장 코드(TAX_CODE).
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  HOUSE_NUM                       VARCHAR2(20)  ,           -- 동.
  FLOOR_TYPE                      VARCHAR2(10)  NOT NULL,   -- 지상/지하 구분.
  FLOOR_COUNT                     VARCHAR2(20)  NOT NULL,   -- 층수.
  ROOM_NO                         VARCHAR2(20)  ,           -- 호수.
  CUSTOMER_ID                     NUMBER        ,           -- 거래처ID.
  RESIDENT_NUM                    VARCHAR2(50)  ,           -- 주민번호.
  AREA_M2                         NUMBER        ,           -- 면적(M2)
  USE_DESC                        VARCHAR2(200) ,           -- 용도.
  USE_DATE_FR                     DATE          ,           -- 임대기간(시작).
  USE_DATE_TO                     DATE          ,           -- 임대기간(종료).
  DEPOSIT_AMOUNT                  NUMBER        DEFAULT 0,  -- 보증금.
  MONTHLY_RENT_AMOUNT             NUMBER        DEFAULT 0,  -- 월세.
  MAINTENANCE_FEE                 NUMBER        DEFAULT 0,  -- 관리비.
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

COMMENT ON TABLE FI_VAT_REALTY_LEASE IS '부동산임대내역';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.REALTY_LEASE_ID IS '부동산 임대내역 ID';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.TAX_CODE IS '부가세 신고 사업장코드';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.HOUSE_NUM IS '동';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.FLOOR_TYPE IS '층구분(지상/지하)';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.FLOOR_COUNT IS '층수';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.ROOM_NO IS '호수';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.CUSTOMER_ID IS '거래처ID';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.RESIDENT_NUM IS '주민번호';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.AREA_M2 IS '면적';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.USE_DESC IS '용도';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.USE_DATE_FR IS '임대 시작일자';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.USE_DATE_TO IS '임대 종료일자';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.DEPOSIT_AMOUNT IS '보증금';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.MONTHLY_RENT_AMOUNT IS '월세';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE.MAINTENANCE_FEE IS '관리비';

ALTER TABLE FI_VAT_REALTY_LEASE ADD CONSTRAINT FI_VAT_REALTY_LEASE_PK PRIMARY KEY (REALTY_LEASE_ID);
CREATE INDEX FI_VAT_REALTY_LEASE_N1 ON FI_VAT_REALTY_LEASE(TAX_CODE, SOB_ID)  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_REALTY_LEASE_N2 ON FI_VAT_REALTY_LEASE(CUSTOMER_ID, SOB_ID)  TABLESPACE FCM_TS_IDX;
  
CREATE SEQUENCE FI_VAT_REALTY_LEASE_S1;
