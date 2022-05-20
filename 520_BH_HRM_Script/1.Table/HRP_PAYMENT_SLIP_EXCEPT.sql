/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_PAYMENT_SLIP_EXCEPT
/* Description  : 월급상여 지급내역 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRP_PAYMENT_SLIP_EXCEPT
( PAY_YYYYMM                      VARCHAR2(7)     NOT NULL,
  WAGE_TYPE                       VARCHAR2(5)     NOT NULL,
  EXCEPT_TYPE                     VARCHAR2(50)    NOT NULL,
  PERSON_NUM                      VARCHAR2(30)    NOT NULL,
  NAME                            VARCHAR2(100)   ,
  IN_TAX_AMT                      NUMBER          ,
  LOCAL_TAX_AMT                   NUMBER          ,
  SP_TAX_AMT                      NUMBER          ,
  SUM_TAX_AMT                     NUMBER
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRP_PAYMENT_SLIP_EXCEPT IS '급상여 전표 예외 처리자 관리';
COMMENT ON COLUMN HRP_PAYMENT_SLIP_EXCEPT.PAY_YYYYMM IS '급상여 년월';
COMMENT ON COLUMN HRP_PAYMENT_SLIP_EXCEPT.WAGE_TYPE IS '급상여 구분';
COMMENT ON COLUMN HRP_PAYMENT_SLIP_EXCEPT.EXCEPT_TYPE IS '예외처리 구분';
COMMENT ON COLUMN HRP_PAYMENT_SLIP_EXCEPT.PERSON_NUM IS '사원 번호';
COMMENT ON COLUMN HRP_PAYMENT_SLIP_EXCEPT.NAME IS '성명';
COMMENT ON COLUMN HRP_PAYMENT_SLIP_EXCEPT.IN_TAX_AMT IS '소득세';
COMMENT ON COLUMN HRP_PAYMENT_SLIP_EXCEPT.LOCAL_TAX_AMT IS '주민세';
COMMENT ON COLUMN HRP_PAYMENT_SLIP_EXCEPT.SP_TAX_AMT IS '농특세';
COMMENT ON COLUMN HRP_PAYMENT_SLIP_EXCEPT.SUM_TAX_AMT  IS '합계';
