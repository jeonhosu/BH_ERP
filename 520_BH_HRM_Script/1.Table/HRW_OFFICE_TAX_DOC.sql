/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRW_OFFICE_TAX_DOC
/* Description  : 지방소득세 신고서.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRW_OFFICE_TAX_DOC
( OFFICE_TAX_ID                   NUMBER          NOT NULL,
  OFFICE_TAX_NO                   VARCHAR2(20)    NOT NULL,
  CORP_ID                         NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  OFFICE_TAX_TYPE                 VARCHAR2(10)    NOT NULL,
  STD_YYYYMM                      VARCHAR2(8)     NOT NULL,
  PAY_YYYYMM                      VARCHAR2(8)     NOT NULL,
  SUBMIT_DATE                     DATE            ,
  PAY_SUPPLY_DATE                 DATE            ,
  TAX_OFFICER                     VARCHAR2(100)   ,
  OWNER_TAX_FREE_YN               VARCHAR2(2)     DEFAULT 'Y',
  NON_PAY_PERSON_YN               VARCHAR2(2)     DEFAULT 'N',
  REGULAR_WORKER_COUNT            NUMBER          ,
  DAY_WORKER_COUNT                NUMBER          ,
  TOTAL_PAYMENT_AMT               NUMBER          ,
  TAX_FREE_AMT                    NUMBER          ,
  PAYMENT_TAX_AMT                 NUMBER          ,
  COMP_TAX_AMT                    NUMBER          ,
  DUE_DATE                        DATE            ,
  TAX_ADDITION_AMT                NUMBER          ,
  TOTAL_TAX_AMT                   NUMBER          ,
  ORIGINAL_DUE_DATE               DATE            ,
  DELAY_DAY_COUNT                 NUMBER          ,
  BAD_PAY_ADDITION_AMT            NUMBER          ,
  BAD_REPORT_ADDITION_AMT         NUMBER          ,
  OWN_TYPE                        VARCHAR2(2)     ,
  CLOSED_YN                       VARCHAR2(2)     ,
  CLOSED_DATE                     DATE            ,
  CLOSED_PERSON_ID                NUMBER          ,
  DESCRIPTION                     VARCHAR2(100)   ,
  ATTRIBUTE_1                     NUMBER          ,
  ATTRIBUTE_2                     NUMBER          ,
  ATTRIBUTE_3                     NUMBER          ,
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          ,
  ATTRIBUTE_A                     NUMBER          ,
  ATTRIBUTE_B                     VARCHAR2(100)   ,
  ATTRIBUTE_C                     VARCHAR2(100)   ,
  ATTRIBUTE_D                     VARCHAR2(100)   ,
  ATTRIBUTE_E                     VARCHAR2(100)   ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRW_OFFICE_TAX_DOC IS '지방소득세 신고서(50인 이상 해당)';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID IS '지방소득세 ID';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.OFFICE_TAX_NO IS '문서번호';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.OFFICE_TAX_TYPE IS '신고구분';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.STD_YYYYMM IS '귀속년월';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.PAY_YYYYMM IS '지급년월';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.SUBMIT_DATE IS '제출일자';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.PAY_SUPPLY_DATE IS '급여지급일자';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.TAX_OFFICER IS '제출처';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.OWNER_TAX_FREE_YN IS '사용자부담금비과세 포함';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.NON_PAY_PERSON_YN IS '무급자 포함';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.REGULAR_WORKER_COUNT IS '인원수-사용직';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.DAY_WORKER_COUNT IS '인원수-일용직';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.TOTAL_PAYMENT_AMT IS '총급여액';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.TAX_FREE_AMT IS '과세제외급여액';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.PAYMENT_TAX_AMT IS '과세급여액';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.COMP_TAX_AMT IS '산출세액';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.DUE_DATE IS '납부기한';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.TAX_ADDITION_AMT IS '가산세';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.TOTAL_TAX_AMT IS '신고세액합계';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.ORIGINAL_DUE_DATE IS '당초납부기한';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.DELAY_DAY_COUNT IS '납부지연일수';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.BAD_PAY_ADDITION_AMT IS '납부불성실가산세';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.BAD_REPORT_ADDITION_AMT IS '신고불성실가산세';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.OWN_TYPE IS '소유구분(1-자가, 2-임대)';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.CLOSED_YN IS '마감구분';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.CLOSED_DATE IS '마감일시';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.CLOSED_PERSON_ID IS '마감처리자';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRW_OFFICE_TAX_DOC.LAST_UPDATED_BY IS '최종수정자';

-- PK.
ALTER TABLE HRW_OFFICE_TAX_DOC ADD CONSTRAINTS HRW_OFFICE_TAX_DOC_PK PRIMARY KEY(OFFICE_TAX_ID);

CREATE UNIQUE INDEX HRW_OFFICE_TAX_DOC_U1 ON HRW_OFFICE_TAX_DOC(OFFICE_TAX_NO, CORP_ID, SOB_ID, ORG_ID);

-- SEQUENCE
CREATE SEQUENCE HRW_OFFICE_TAX_DOC_S1;
-- ANALYZE.
ANALYZE TABLE HRW_OFFICE_TAX_DOC COMPUTE STATISTICS;
