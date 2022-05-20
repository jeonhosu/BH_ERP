/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRW_INCOME_RESIDENT_BSN
/* Description  : 소득등록-거주자사업소득.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRW_INCOME_RESIDENT_BSN              
( INCOME_ID                       NUMBER          NOT NULL,
  CORP_ID                         NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  EARNER_ID                       NUMBER          NOT NULL,
  PAY_DATE                        DATE            NOT NULL,
  RECEIPT_DATE                    DATE            NOT NULL,
  PAYMENT_AMOUNT                  NUMBER          DEFAULT 0,
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
COMMENT ON TABLE HRW_INCOME_RESIDENT_BSN IS '소득등록-거구자사업소득';
COMMENT ON COLUMN HRW_INCOME_RESIDENT_BSN.INCOME_ID IS '소득 ID';
COMMENT ON COLUMN HRW_INCOME_RESIDENT_BSN.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRW_INCOME_RESIDENT_BSN.EARNER_ID IS '소득자ID';
COMMENT ON COLUMN HRW_INCOME_RESIDENT_BSN.PAY_DATE IS '지급일자';
COMMENT ON COLUMN HRW_INCOME_RESIDENT_BSN.RECEIPT_DATE IS '영수일자';
COMMENT ON COLUMN HRW_INCOME_RESIDENT_BSN.PAYMENT_AMOUNT IS '지급액';
COMMENT ON COLUMN HRW_INCOME_RESIDENT_BSN.TAX_RATE IS '세율';
COMMENT ON COLUMN HRW_INCOME_RESIDENT_BSN.INCOME_TAX_AMT IS '소득세';
COMMENT ON COLUMN HRW_INCOME_RESIDENT_BSN.LOCAL_TAX_AMT IS '지방세';
COMMENT ON COLUMN HRW_INCOME_RESIDENT_BSN.SP_TAX_AMT IS '농특세';
COMMENT ON COLUMN HRW_INCOME_RESIDENT_BSN.REAL_AMT IS '실지급액';
COMMENT ON COLUMN HRW_INCOME_RESIDENT_BSN.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRW_INCOME_RESIDENT_BSN.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRW_INCOME_RESIDENT_BSN.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRW_INCOME_RESIDENT_BSN.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRW_INCOME_RESIDENT_BSN.LAST_UPDATED_BY IS '최종수정자';

-- PK.
ALTER TABLE HRW_INCOME_RESIDENT_BSN ADD CONSTRAINTS HRW_INCOME_RESIDENT_BSN_PK PRIMARY KEY(INCOME_ID);
-- CREATE INDEX.
CREATE UNIQUE INDEX HRW_INCOME_RESIDENT_BSN_U1 ON HRW_INCOME_RESIDENT_BSN(EARNER_ID, PAY_DATE, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE HRW_INCOME_RESIDENT_BSN_S1;

-- ANALYZE.
ANALYZE TABLE HRW_INCOME_RESIDENT_BSN COMPUTE STATISTICS;
ANALYZE INDEX HRW_INCOME_RESIDENT_BSN_U1 COMPUTE STATISTICS;

