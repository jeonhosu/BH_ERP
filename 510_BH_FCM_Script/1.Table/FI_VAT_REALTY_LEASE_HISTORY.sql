/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_VAT_REALTY_LEASE_HISTORY
/* Description  : 부동산 임대내역 - 임대료 계산내역.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_VAT_REALTY_LEASE_HISTORY
( REALTY_LEASE_ID                 NUMBER        NOT NULL,   -- 부동산 임대내역 ID.
  TAX_CODE                        VARCHAR2(10)  NOT NULL,   -- 사업장 코드(TAX_CODE).
  USE_DATE_FR                     DATE          ,           -- 임대기간(시작).
  USE_DATE_TO                     DATE          ,           -- 임대기간(종료).
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  DEPOSIT_INTEREST_AMT            NUMBER        DEFAULT 0,  -- 보증금이자.
  MONTHLY_RENT_SUM_AMT            NUMBER        DEFAULT 0,  -- 월세합계.
  MAINTENANCE_FEE                 NUMBER        DEFAULT 0,  -- 관리비.
  TOTAL_DAY                       NUMBER        DEFAULT 0,  -- 년일수.
  PERIOD_DAY                      NUMBER        DEFAULT 0,  -- 임대기간 일수.
  CLOSED_YN                       CHAR(1)       DEFAULT 'N',-- 마감구분.
  CLOSED_DATE                     DATE          ,           -- 마감일시.
  CLOSED_PERSON_ID                NUMBER        ,           -- 마감처리자.
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

COMMENT ON TABLE FI_VAT_REALTY_LEASE_HISTORY IS '부동산임대내역';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.REALTY_LEASE_ID IS '부동산 임대내역 ID';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.TAX_CODE IS '부가세 신고 사업장코드';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.USE_DATE_FR IS '임대 시작일자';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.USE_DATE_TO IS '임대 종료일자';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.DEPOSIT_INTEREST_AMT IS '보증금이자';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.MONTHLY_RENT_SUM_AMT IS '월세합계';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.MAINTENANCE_FEE IS '관리비';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.TOTAL_DAY IS '년일수';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.PERIOD_DAY IS '임대기간 일수';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.CLOSED_YN IS '마감여부';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.CLOSED_DATE IS '마감일시';
COMMENT ON COLUMN FI_VAT_REALTY_LEASE_HISTORY.CLOSED_PERSON_ID IS '마감처리자';

ALTER TABLE FI_VAT_REALTY_LEASE_HISTORY ADD CONSTRAINT FI_VAT_REALTY_LEASE_HTR_PK PRIMARY KEY (REALTY_LEASE_ID, TAX_CODE, USE_DATE_FR, USE_DATE_TO, SOB_ID);
CREATE INDEX FI_VAT_REALTY_LEASE_HTR_N1 ON FI_VAT_REALTY_LEASE_HISTORY(TAX_CODE, SOB_ID)  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_VAT_REALTY_LEASE_HTR_N2 ON FI_VAT_REALTY_LEASE_HISTORY(TAX_CODE, USE_DATE_FR, USE_DATE_TO, SOB_ID)  TABLESPACE FCM_TS_IDX;
