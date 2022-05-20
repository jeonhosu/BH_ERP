/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_MONTH_DEDUCTION
/* Description  : 월급상여 공제내역 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRP_MONTH_DEDUCTION              
( PERSON_ID                                       NUMBER NOT NULL,
  PAY_YYYYMM                                      VARCHAR2(7) NOT NULL,
  WAGE_TYPE                                       VARCHAR2(5) NOT NULL,
  CORP_ID                                         NUMBER NOT NULL,
  DEDUCTION_ID                                    NUMBER NOT NULL,
  DEDUCTION_AMOUNT                                NUMBER DEFAULT 0,
  MONTH_PAYMENT_ID                                NUMBER NOT NULL,
  CREATED_FLAG                                    VARCHAR2(2) DEFAULT 'C',
  SOB_ID                                          NUMBER NOT NULL,
  ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.PAY_YYYYMM IS '급상여 년월';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.WAGE_TYPE IS '급상여 구분';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.DEDUCTION_ID IS '공제항목 ID';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.DEDUCTION_AMOUNT IS '공제액';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.MONTH_PAYMENT_ID IS '월급여내역 ID';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.CREATED_FLAG IS '생성구분(C-생성, I-INTERFACE)';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRP_MONTH_DEDUCTION.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRP_MONTH_DEDUCTION_U1 ON HRP_MONTH_DEDUCTION(PAY_YYYYMM, WAGE_TYPE, CORP_ID, PERSON_ID, DEDUCTION_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRP_MONTH_DEDUCTION_N1 ON HRP_MONTH_DEDUCTION(MONTH_PAYMENT_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRP_MONTH_DEDUCTION COMPUTE STATISTICS;
ANALYZE INDEX HRP_MONTH_DEDUCTION_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRP_MONTH_DEDUCTION_N1 COMPUTE STATISTICS;
