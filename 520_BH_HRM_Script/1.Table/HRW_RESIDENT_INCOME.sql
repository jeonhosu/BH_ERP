/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRW_RESIDENT_INCOME
/* Description  : 소득등록-거주자사업소득.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRW_RESIDENT_INCOME 
( RESIDENT_INCOME_ID              NUMBER          NOT NULL,
  PERIOD_NAME                     VARCHAR2(7)     NOT NULL, 
  EARNER_ID                       NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  CORP_ID                         NUMBER          NOT NULL,
  PAY_DATE                        DATE            NOT NULL,
  RECEIPT_DATE                    DATE            NOT NULL,
  INCOME_CLASS_ETC                VARCHAR2(30)    , 
  PAYMENT_AMOUNT                  NUMBER          DEFAULT 0,
  PAYMENT_ETC_AMOUNT              NUMBER          DEFAULT 0, 
  EXP_RATE                        NUMBER          ,
  EXP_AMOUNT                      NUMBER          ,
  INCOME_AMOUNT                   NUMBER          ,
  INCOME_ETC_AMOUNT               NUMBER          ,
  TAX_RATE                        NUMBER          ,
  INCOME_TAX_AMT                  NUMBER          DEFAULT 0,
  LOCAL_TAX_AMT                   NUMBER          DEFAULT 0,
  SP_TAX_AMT                      NUMBER          DEFAULT 0,
  REAL_AMT                        NUMBER          DEFAULT 0,
  DESCRIPTION                     VARCHAR2(100)   ,
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
COMMENT ON TABLE HRW_RESIDENT_INCOME IS '소득등록-거구자사업소득';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.RESIDENT_INCOME_ID IS '소득 ID';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.EARNER_ID IS '소득자ID';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.PAY_DATE IS '지급일자';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.RECEIPT_DATE IS '영수일자';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.INCOME_CLASS_ETC IS '원천세 소득 구분';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.PAYMENT_AMOUNT IS '지급액';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.PAYMENT_ETC_AMOUNT IS '기타 지급액';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.EXP_RATE IS '필요경비율(%)';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.EXP_AMOUNT IS '필요경비';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.INCOME_AMOUNT IS '소득금액';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.INCOME_ETC_AMOUNT IS '기타 소득금액';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.TAX_RATE IS '세율';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.INCOME_TAX_AMT IS '소득세';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.LOCAL_TAX_AMT IS '지방세';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.SP_TAX_AMT IS '농특세';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.REAL_AMT IS '실지급액';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRW_RESIDENT_INCOME.LAST_UPDATED_BY IS '최종수정자';

-- PK.
ALTER TABLE HRW_RESIDENT_INCOME ADD CONSTRAINTS HRW_RESIDENT_INCOME_PK 
  PRIMARY KEY(CORP_ID, SOB_ID, ORG_ID, EARNER_ID, PAY_DATE) USING INDEX TABLESPACE FCM_TS_IDX;
-- CREATE INDEX.
CREATE UNIQUE INDEX HRW_RESIDENT_INCOME_U1 ON HRW_RESIDENT_INCOME(RESIDENT_INCOME_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE HRW_RESIDENT_INCOME_S1;

-- ANALYZE.
ANALYZE TABLE HRW_RESIDENT_INCOME COMPUTE STATISTICS;
ANALYZE INDEX HRW_RESIDENT_INCOME_U1 COMPUTE STATISTICS;

