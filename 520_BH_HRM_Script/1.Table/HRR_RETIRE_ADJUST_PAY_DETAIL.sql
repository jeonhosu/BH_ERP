/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRR_RETIRE_ADJUST_PAY_DETAIL
/* Description  : 퇴직정상 지급 상세 내역.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRR_RETIRE_ADJUST_PAY_DETAIL              
( ADJUSTMENT_ID                   NUMBER        NOT NULL,
  PAY_YYYYMM                      VARCHAR2(7)   NOT NULL,
  WAGE_TYPE                       VARCHAR2(5)   NOT NULL,
  ALLOWANCE_ID                    NUMBER        NOT NULL,
  ALLOWANCE_AMOUNT                NUMBER        DEFAULT 0,
  PERSON_ID                       NUMBER        NOT NULL,
  CORP_ID                         NUMBER        NOT NULL,
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  CREATION_DATE                   DATE          NOT NULL,
  CREATED_BY                      NUMBER        NOT NULL,
  LAST_UPDATE_DATE                DATE          NOT NULL,
  LAST_UPDATED_BY                 NUMBER        NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRR_RETIRE_ADJUST_PAY_DETAIL IS '퇴직정산 급상여 지급 상세내역';
COMMENT ON COLUMN HRR_RETIRE_ADJUST_PAY_DETAIL.ADJUSTMENT_ID IS '퇴직정산ID';
COMMENT ON COLUMN HRR_RETIRE_ADJUST_PAY_DETAIL.PAY_YYYYMM IS '적용 급상여 년월';
COMMENT ON COLUMN HRR_RETIRE_ADJUST_PAY_DETAIL.WAGE_TYPE IS '급상여 구분';
COMMENT ON COLUMN HRR_RETIRE_ADJUST_PAY_DETAIL.ALLOWANCE_ID IS '지급항목ID';
COMMENT ON COLUMN HRR_RETIRE_ADJUST_PAY_DETAIL.ALLOWANCE_AMOUNT IS '지급금액';
COMMENT ON COLUMN HRR_RETIRE_ADJUST_PAY_DETAIL.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRR_RETIRE_ADJUST_PAY_DETAIL.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRR_RETIRE_ADJUST_PAY_DETAIL.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRR_RETIRE_ADJUST_PAY_DETAIL.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRR_RETIRE_ADJUST_PAY_D_U1 ON HRR_RETIRE_ADJUST_PAY_DETAIL(ADJUSTMENT_ID, PAY_YYYYMM, WAGE_TYPE, ALLOWANCE_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRR_RETIRE_ADJUST_PAY_D_N1 ON HRR_RETIRE_ADJUST_PAY_DETAIL(ADJUSTMENT_ID, WAGE_TYPE) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRR_RETIRE_ADJUST_PAY_DETAIL COMPUTE STATISTICS;
ANALYZE INDEX HRR_RETIRE_ADJUST_PAY_D_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRR_RETIRE_ADJUST_PAY_D_N1 COMPUTE STATISTICS;
