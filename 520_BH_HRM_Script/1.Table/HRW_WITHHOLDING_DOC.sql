/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRW_WITHHOLDING_DOC
/* Description  : 원천징수이행상황신고서.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRW_WITHHOLDING_DOC
( WITHHOLDING_DOC_ID              NUMBER          NOT NULL,
  WITHHOLDING_NO                  VARCHAR2(20)    NOT NULL,
  CORP_ID                         NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  WITHHOLDING_TYPE                VARCHAR2(10)    NOT NULL,
  STD_YYYYMM                      VARCHAR2(8)     NOT NULL,
  PAY_YYYYMM                      VARCHAR2(8)     NOT NULL,
  INCOME_DISPOSED_YN              VARCHAR2(2)     ,
  SUBMIT_DATE                     DATE            ,
  PRE_WITHHOLDING_NO              VARCHAR2(20)    ,
  SOURCE_WITHHOLDING_NO           VARCHAR2(20)    ,
  CLOSED_YN                       VARCHAR2(2)     DEFAULT 'N',
  CLOSED_DATE                     DATE            ,
  CLOSED_PERSON_ID                NUMBER          ,
  MONTHLY_YN                      VARCHAR2(2)     ,
  HALF_YEARLY_YN                  VARCHAR2(2)     ,
  MODIFY_YN                       VARCHAR2(2)     ,
  YEAR_END_YN                     VARCHAR2(2)     ,
  REFUND_REQUEST_YN               VARCHAR2(2)     ,
  ALL_PAYMENT_YN                  VARCHAR2(2)     ,
  BUSINESS_UNIT_TAX_YN            VARCHAR2(2)     ,
  A01_PERSON_CNT                  NUMBER          ,
  A01_PAYMENT_AMT                 NUMBER          ,
  A01_INCOME_TAX_AMT              NUMBER          ,
  A01_SP_TAX_AMT                  NUMBER          ,
  A01_ADD_TAX_AMT                 NUMBER          ,
  A02_PERSON_CNT                  NUMBER          ,
  A02_PAYMENT_AMT                 NUMBER          ,
  A02_INCOME_TAX_AMT              NUMBER          ,
  A02_SP_TAX_AMT                  NUMBER          ,
  A02_ADD_TAX_AMT                 NUMBER          ,
  A03_PERSON_CNT                  NUMBER          ,
  A03_PAYMENT_AMT                 NUMBER          ,
  A03_INCOME_TAX_AMT              NUMBER          ,
  A03_ADD_TAX_AMT                 NUMBER          ,
  A04_PERSON_CNT                  NUMBER          ,
  A04_PAYMENT_AMT                 NUMBER          ,
  A04_INCOME_TAX_AMT              NUMBER          ,
  A04_SP_TAX_AMT                  NUMBER          ,
  A04_ADD_TAX_AMT                 NUMBER          ,
  A10_PERSON_CNT                  NUMBER          ,
  A10_PAYMENT_AMT                 NUMBER          ,
  A10_INCOME_TAX_AMT              NUMBER          ,
  A10_SP_TAX_AMT                  NUMBER          ,
  A10_ADD_TAX_AMT                 NUMBER          ,
  A10_THIS_REFUND_TAX_AMT         NUMBER          ,
  A10_PAY_INCOME_TAX_AMT          NUMBER          ,
  A10_PAY_SP_TAX_AMT              NUMBER          ,
  A20_PERSON_CNT                  NUMBER          ,
  A20_PAYMENT_AMT                 NUMBER          ,
  A20_INCOME_TAX_AMT              NUMBER          ,
  A20_ADD_TAX_AMT                 NUMBER          ,
  A20_THIS_REFUND_TAX_AMT         NUMBER          ,
  A20_PAY_INCOME_TAX_AMT          NUMBER          ,
  A25_PERSON_CNT                  NUMBER          ,
  A25_PAYMENT_AMT                 NUMBER          ,
  A25_INCOME_TAX_AMT              NUMBER          ,
  A25_ADD_TAX_AMT                 NUMBER          ,
  A26_PERSON_CNT                  NUMBER          ,
  A26_PAYMENT_AMT                 NUMBER          ,
  A26_INCOME_TAX_AMT              NUMBER          ,
  A26_SP_TAX_AMT                  NUMBER          ,
  A26_ADD_TAX_AMT                 NUMBER          ,
  A30_PERSON_CNT                  NUMBER          ,
  A30_PAYMENT_AMT                 NUMBER          ,
  A30_INCOME_TAX_AMT              NUMBER          ,
  A30_SP_TAX_AMT                  NUMBER          ,
  A30_ADD_TAX_AMT                 NUMBER          ,
  A30_THIS_REFUND_TAX_AMT         NUMBER          ,
  A30_PAY_INCOME_TAX_AMT          NUMBER          ,
  A30_PAY_SP_TAX_AMT              NUMBER          ,
  A40_PERSON_CNT                  NUMBER          ,
  A40_PAYMENT_AMT                 NUMBER          ,
  A40_INCOME_TAX_AMT              NUMBER          ,
  A40_ADD_TAX_AMT                 NUMBER          ,
  A40_THIS_REFUND_TAX_AMT         NUMBER          ,
  A40_PAY_INCOME_TAX_AMT          NUMBER          ,
  A45_PERSON_CNT                  NUMBER          ,
  A45_PAYMENT_AMT                 NUMBER          ,
  A45_INCOME_TAX_AMT              NUMBER          ,
  A45_ADD_TAX_AMT                 NUMBER          ,
  A46_PERSON_CNT                  NUMBER          ,
  A46_PAYMENT_AMT                 NUMBER          ,
  A46_INCOME_TAX_AMT              NUMBER          ,
  A46_ADD_TAX_AMT                 NUMBER          ,
  A47_PERSON_CNT                  NUMBER          ,
  A47_PAYMENT_AMT                 NUMBER          ,
  A47_INCOME_TAX_AMT              NUMBER          ,
  A47_ADD_TAX_AMT                 NUMBER          ,
  A47_THIS_REFUND_TAX_AMT         NUMBER          ,
  A47_PAY_INCOME_TAX_AMT          NUMBER          ,
  A50_PERSON_CNT                  NUMBER          ,
  A50_PAYMENT_AMT                 NUMBER          ,
  A50_INCOME_TAX_AMT              NUMBER          ,
  A50_SP_TAX_AMT                  NUMBER          ,
  A50_ADD_TAX_AMT                 NUMBER          ,
  A50_THIS_REFUND_TAX_AMT         NUMBER          ,
  A50_PAY_INCOME_TAX_AMT          NUMBER          ,
  A50_PAY_SP_TAX_AMT              NUMBER          ,
  A60_PERSON_CNT                  NUMBER          ,
  A60_PAYMENT_AMT                 NUMBER          ,
  A60_INCOME_TAX_AMT              NUMBER          ,
  A60_SP_TAX_AMT                  NUMBER          ,
  A60_ADD_TAX_AMT                 NUMBER          ,
  A60_THIS_REFUND_TAX_AMT         NUMBER          ,
  A60_PAY_INCOME_TAX_AMT          NUMBER          ,
  A60_PAY_SP_TAX_AMT              NUMBER          ,
  A69_PERSON_CNT                  NUMBER          ,
  A69_INCOME_TAX_AMT              NUMBER          ,
  A69_ADD_TAX_AMT                 NUMBER          ,
  A69_THIS_REFUND_TAX_AMT         NUMBER          ,
  A69_PAY_INCOME_TAX_AMT          NUMBER          ,  
  A70_PERSON_CNT                  NUMBER          ,
  A70_PAYMENT_AMT                 NUMBER          ,
  A70_INCOME_TAX_AMT              NUMBER          ,
  A70_ADD_TAX_AMT                 NUMBER          ,
  A70_THIS_REFUND_TAX_AMT         NUMBER          ,
  A70_PAY_INCOME_TAX_AMT          NUMBER          ,
  A80_PERSON_CNT                  NUMBER          ,
  A80_PAYMENT_AMT                 NUMBER          ,
  A80_INCOME_TAX_AMT              NUMBER          ,
  A80_ADD_TAX_AMT                 NUMBER          ,
  A80_THIS_REFUND_TAX_AMT         NUMBER          ,
  A80_PAY_INCOME_TAX_AMT          NUMBER          ,
  A90_INCOME_TAX_AMT              NUMBER          ,
  A90_SP_TAX_AMT                  NUMBER          ,
  A90_ADD_TAX_AMT                 NUMBER          ,
  A90_THIS_REFUND_TAX_AMT         NUMBER          ,
  A90_PAY_INCOME_TAX_AMT          NUMBER          ,
  A90_PAY_SP_TAX_AMT              NUMBER          ,
  A99_PERSON_CNT                  NUMBER          ,
  A99_PAYMENT_AMT                 NUMBER          ,
  A99_INCOME_TAX_AMT              NUMBER          ,
  A99_SP_TAX_AMT                  NUMBER          ,
  A99_ADD_TAX_AMT                 NUMBER          ,
  A99_THIS_REFUND_TAX_AMT         NUMBER          ,
  A99_PAY_INCOME_TAX_AMT          NUMBER          ,
  A99_PAY_SP_TAX_AMT              NUMBER          ,
  RECEIVE_REFUND_TAX_AMT          NUMBER          ,
  ALREADY_REFUND_TAX_AMT          NUMBER          ,
  REFUND_BALANCE_AMT              NUMBER          ,
  GENERAL_REFUND_AMT              NUMBER          ,
  FINANCIAL_AMT                   NUMBER          ,
  ETC_REFUND_FINANCIAL_AMT        NUMBER          ,
  ETC_REFUND_MERGER_AMT           NUMBER          ,
  ADJUST_REFUND_TAX_AMT           NUMBER          ,
  THIS_ADJUST_REFUND_TAX_AMT      NUMBER          ,
  NEXT_REFUND_TAX_AMT             NUMBER          ,
  REQUEST_REFUND_TAX_AMT          NUMBER          ,
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

-- 2016.03.07 추가 -- 
ALTER TABLE HRW_WITHHOLDING_DOC ADD A05_PERSON_CNT                  NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A05_PAYMENT_AMT                 NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A05_INCOME_TAX_AMT              NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A05_SP_TAX_AMT                  NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A05_ADD_TAX_AMT                 NUMBER
ALTER TABLE HRW_WITHHOLDING_DOC ADD A06_PERSON_CNT                  NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A06_PAYMENT_AMT                 NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A06_INCOME_TAX_AMT              NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A06_SP_TAX_AMT                  NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A06_ADD_TAX_AMT                 NUMBER

COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A05_PERSON_CNT IS '2015-근로소득-연말정산 분납 인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A05_PAYMENT_AMT IS '2015-근로소득-연말정산 분납 총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A05_INCOME_TAX_AMT IS '2015-근로소득-연말정산 분납 소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A05_SP_TAX_AMT IS '2015-근로소득-연말정산 분납 농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A05_ADD_TAX_AMT IS '2015-근로소득-연말정산 분납 가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A06_PERSON_CNT IS '2015-근로소득-연말정산 납부금액 인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A06_PAYMENT_AMT IS '2015-근로소득-연말정산 납부금액 총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A06_INCOME_TAX_AMT IS '2015-근로소득-연말정산 납부금액 소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A06_SP_TAX_AMT IS '2015-근로소득-연말정산 납부금액 농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A06_ADD_TAX_AMT IS '2015-근로소득-연말정산 납부금액 가산세';

-- 2014.11 추가 : jlake
ALTER TABLE HRW_WITHHOLDING_DOC ADD A21_PERSON_CNT          NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A21_PAYMENT_AMT         NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A21_INCOME_TAX_AMT      NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A21_ADD_TAX_AMT         NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A21_THIS_REFUND_TAX_AMT NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A21_PAY_INCOME_TAX_AMT  NUMBER;  
ALTER TABLE HRW_WITHHOLDING_DOC ADD A22_PERSON_CNT          NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A22_PAYMENT_AMT         NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A22_INCOME_TAX_AMT      NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A22_ADD_TAX_AMT         NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A22_THIS_REFUND_TAX_AMT NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A22_PAY_INCOME_TAX_AMT  NUMBER;  
ALTER TABLE HRW_WITHHOLDING_DOC ADD A41_PERSON_CNT          NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A41_PAYMENT_AMT         NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A41_INCOME_TAX_AMT      NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A41_ADD_TAX_AMT         NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A41_THIS_REFUND_TAX_AMT NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A41_PAY_INCOME_TAX_AMT  NUMBER;  
ALTER TABLE HRW_WITHHOLDING_DOC ADD A42_PERSON_CNT          NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A42_PAYMENT_AMT         NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A42_INCOME_TAX_AMT      NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A42_ADD_TAX_AMT         NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A42_THIS_REFUND_TAX_AMT NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A42_PAY_INCOME_TAX_AMT  NUMBER; 
ALTER TABLE HRW_WITHHOLDING_DOC ADD A48_PERSON_CNT          NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A48_PAYMENT_AMT         NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A48_INCOME_TAX_AMT      NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A48_ADD_TAX_AMT         NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A48_THIS_REFUND_TAX_AMT NUMBER;
ALTER TABLE HRW_WITHHOLDING_DOC ADD A48_PAY_INCOME_TAX_AMT  NUMBER; 

-- COMMENT 
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A21_PERSON_CNT IS '퇴직소득-연금계좌 인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A21_PAYMENT_AMT IS '퇴직소득-연금계좌 총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A21_INCOME_TAX_AMT IS '퇴직소득-연금계좌 소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A21_ADD_TAX_AMT IS '퇴직소득-연금계좌 가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A21_THIS_REFUND_TAX_AMT IS '퇴직소득-연금계좌 당월조정환급세액(X)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A21_PAY_INCOME_TAX_AMT IS '퇴직소득-연금계좌 소득세등(가산세포함)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A22_PERSON_CNT IS '퇴직소득-그외 인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A22_PAYMENT_AMT IS '퇴직소득-그외 총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A22_INCOME_TAX_AMT IS '퇴직소득-그외 소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A22_ADD_TAX_AMT IS '퇴직소득-그외 가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A22_THIS_REFUND_TAX_AMT IS '퇴직소득-그외 당월조정환급세액(X)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A22_PAY_INCOME_TAX_AMT IS '퇴직소득-그외 소득세등(가산세포함)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A41_PERSON_CNT IS '기타소득-연금계좌 인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A41_PAYMENT_AMT IS '기타소득-연금계좌 총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A41_INCOME_TAX_AMT IS '기타소득-연금계좌 소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A41_ADD_TAX_AMT IS '기타소득-연금계좌 가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A41_THIS_REFUND_TAX_AMT IS '기타소득-연금계좌 당월조정환급세액(X)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A41_PAY_INCOME_TAX_AMT IS '기타소득-연금계좌 소득세등(가산세포함)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A42_PERSON_CNT IS '기타소득-그외 인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A42_PAYMENT_AMT IS '기타소득-그외 총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A42_INCOME_TAX_AMT IS '기타소득-그외 소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A42_ADD_TAX_AMT IS '기타소득-그외 가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A42_THIS_REFUND_TAX_AMT IS '기타소득-그외 당월조정환급세액(X)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A42_PAY_INCOME_TAX_AMT IS '기타소득-그외 소득세등(가산세포함)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A48_PERSON_CNT IS '연금소득-연금계좌 인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A48_PAYMENT_AMT IS '연금소득-연금계좌 총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A48_INCOME_TAX_AMT IS '연금소득-연금계좌 소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A48_ADD_TAX_AMT IS '연금소득-연금계좌 가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A48_THIS_REFUND_TAX_AMT IS '연금소득-연금계좌 당월조정환급세액(X)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A48_PAY_INCOME_TAX_AMT IS '연금소득- 연금계좌 소득세등(가산세포함)(X)';

-- Add comments to the columns 
COMMENT ON TABLE HRW_WITHHOLDING_DOC IS '원천징수이행상황신고서';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID IS '신고서 ID';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.WITHHOLDING_NO IS '문서번호';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.WITHHOLDING_TYPE IS '신고구분';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.STD_YYYYMM IS '귀속년월';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.PAY_YYYYMM IS '지급년월';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.INCOME_DISPOSED_YN IS '소득처분여부';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.SUBMIT_DATE IS '제출일자';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.PRE_WITHHOLDING_NO IS '전월문서';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.SOURCE_WITHHOLDING_NO IS '수정전문서번호';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.MONTHLY_YN IS '매월 여부';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.HALF_YEARLY_YN IS '반기 여부';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.MODIFY_YN IS '수정 여부';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.YEAR_END_YN IS '연말 여부';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.REFUND_REQUEST_YN IS '환급신청 여부';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.ALL_PAYMENT_YN IS '일괄납부여부';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.BUSINESS_UNIT_TAX_YN IS '사업자단위과세 여부';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A01_PERSON_CNT IS '전월문서';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A01_PAYMENT_AMT IS '수정전문서번호';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A01_PERSON_CNT IS '근로소득-간이세액 인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A01_PAYMENT_AMT IS '근로소득-간이세액 총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A01_INCOME_TAX_AMT IS '근로소득-간이세액 소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A01_SP_TAX_AMT IS '근로소득-간이세액 농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A01_ADD_TAX_AMT IS '근로소득-간이세액 가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A02_PERSON_CNT IS '근로소득-중도퇴사 인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A02_PAYMENT_AMT IS '근로소득-중도퇴사 총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A02_INCOME_TAX_AMT IS '근로소득-중도퇴사 소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A02_SP_TAX_AMT IS '근로소득-중도퇴사 농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A02_ADD_TAX_AMT IS '근로소득-중도퇴사 가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A03_PERSON_CNT IS '근로소득-일용근로 인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A03_PAYMENT_AMT IS '근로소득-일용근로 총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A03_INCOME_TAX_AMT IS '근로소득-일용근로 소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A03_ADD_TAX_AMT IS '근로소득-일용근로 가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A04_PERSON_CNT IS '근로소득-연말정산 인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A04_PAYMENT_AMT IS '근로소득-연말정산 총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A04_INCOME_TAX_AMT IS '근로소득-연말정산 소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A04_SP_TAX_AMT IS '근로소득-연말정산 농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A04_ADD_TAX_AMT IS '근로소득-연말정산 가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A10_PERSON_CNT IS '근로소득-가감계 인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A10_PAYMENT_AMT IS '근로소득-가감계 총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A10_INCOME_TAX_AMT IS '근로소득-가감계 소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A10_SP_TAX_AMT IS '근로소득-가감계 농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A10_ADD_TAX_AMT IS '근로소득-가감계 가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A10_THIS_REFUND_TAX_AMT IS '근로소득-가감계 당월조정환급세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A10_PAY_INCOME_TAX_AMT IS '근로소득-가감계 소득세등(가산세포함)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A10_PAY_SP_TAX_AMT IS '근로소득-가감계 농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A20_PERSON_CNT IS '퇴직소득-인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A20_PAYMENT_AMT IS '퇴직소득-총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A20_INCOME_TAX_AMT IS '퇴직소득-소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A20_ADD_TAX_AMT IS '퇴직소득-가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A20_THIS_REFUND_TAX_AMT IS '퇴직소득-당월조정환급세액 ';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A20_PAY_INCOME_TAX_AMT IS '퇴직소득-소득세등(가산세포함)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A25_PERSON_CNT IS '사업소득-매월징수 인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A25_PAYMENT_AMT IS '사업소득-매월징수 총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A25_INCOME_TAX_AMT IS '사업소득-매월징수 소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A25_ADD_TAX_AMT IS '사업소득-매월징수 농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A26_PERSON_CNT IS '사업소득-연말정산 인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A26_PAYMENT_AMT IS '사업소득-연말정산 총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A26_INCOME_TAX_AMT IS '사업소득-연말정산 소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A26_SP_TAX_AMT IS '사업소득-연말정산 농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A26_ADD_TAX_AMT IS '사업소득-연말정산 가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A30_PERSON_CNT IS '사업소득-가감계 인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A30_PAYMENT_AMT IS '사업소득-가감계 총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A30_INCOME_TAX_AMT IS '사업소득-가감계 소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A30_SP_TAX_AMT IS '사업소득-가감계 농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A30_ADD_TAX_AMT IS '사업소득-가감계 가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A30_THIS_REFUND_TAX_AMT IS '사업소득-가감계 당월조정환급세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A30_PAY_INCOME_TAX_AMT IS '사업소득-가감계 소득세등(가산세포함)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A30_PAY_SP_TAX_AMT IS '사업소득-가감계 농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A40_PERSON_CNT IS '기타소득-인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A40_PAYMENT_AMT IS '기타소득-총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A40_INCOME_TAX_AMT IS '기타소득-소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A40_ADD_TAX_AMT IS '기타소득-가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A40_THIS_REFUND_TAX_AMT IS '기타소득-당월조정환급세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A40_PAY_INCOME_TAX_AMT IS '기타소득-소득세등(가산세포함)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A45_PERSON_CNT IS '연금소득-매월징수 인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A45_PAYMENT_AMT IS '연금소득-매월징수 총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A45_INCOME_TAX_AMT IS '연금소득-매월징수 소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A45_ADD_TAX_AMT IS '연금소득-매월징수 가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A46_PERSON_CNT IS '연금소득-연말정산 인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A46_PAYMENT_AMT IS '연금소득-연말정산 총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A46_INCOME_TAX_AMT IS '연금소득-연말정산 소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A46_ADD_TAX_AMT IS '연금소득-연말정산 가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A47_PERSON_CNT IS '연금소득-가감계 인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A47_PAYMENT_AMT IS '연금소득-가감계 총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A47_INCOME_TAX_AMT IS '연금소득-가감계 소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A47_ADD_TAX_AMT IS '연금소득-가감계 가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A47_THIS_REFUND_TAX_AMT IS '연금소득-가감계 당월조정환급세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A47_PAY_INCOME_TAX_AMT IS '연금소득-가감계 소득세등(가산세포함)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A50_PERSON_CNT IS '이자소득-인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A50_PAYMENT_AMT IS '이자소득-총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A50_INCOME_TAX_AMT IS '이자소득-소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A50_SP_TAX_AMT IS '이자소득-농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A50_ADD_TAX_AMT IS '이자소득-가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A50_THIS_REFUND_TAX_AMT IS '이자소득-당월조정환급세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A50_PAY_INCOME_TAX_AMT IS '이자소득-소득세등(가산세포함)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A50_PAY_SP_TAX_AMT IS '이자소득-농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A60_PERSON_CNT IS '배당소득-인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A60_PAYMENT_AMT IS '배당소득-총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A60_INCOME_TAX_AMT IS '배당소득-소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A60_SP_TAX_AMT IS '배당소득-농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A60_ADD_TAX_AMT IS '배당소득-가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A60_THIS_REFUND_TAX_AMT IS '배당소득-당월조정환급세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A60_PAY_INCOME_TAX_AMT IS '배당소득-소득세등(가산세포함)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A60_PAY_SP_TAX_AMT IS '배당소득-농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A69_PERSON_CNT IS '저축해지 추징세액등-인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A69_INCOME_TAX_AMT IS '저축해지 추징세액등-소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A69_ADD_TAX_AMT IS '저축해지 추징세액등-가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A69_THIS_REFUND_TAX_AMT IS '저축해지 추징세액등-당월조정환급세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A69_PAY_INCOME_TAX_AMT IS '저축해지 추징세액등-소득세등(가산세포함)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A70_PERSON_CNT IS '비거주자양도소득-인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A70_PAYMENT_AMT IS '근로소득-총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A70_INCOME_TAX_AMT IS '근로소득-소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A70_ADD_TAX_AMT IS '근로소득-가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A70_THIS_REFUND_TAX_AMT IS '근로소득-당월조정환급세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A70_PAY_INCOME_TAX_AMT IS '근로소득-소득세등(가산세포함)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A80_PERSON_CNT IS '내외국인법인원천-인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A80_PAYMENT_AMT IS '내외국인법인원천-총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A80_INCOME_TAX_AMT IS '내외국인법인원천-소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A80_ADD_TAX_AMT IS '내외국인법인원천-가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A80_THIS_REFUND_TAX_AMT IS '내외국인법인원천-당월조정환급세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A80_PAY_INCOME_TAX_AMT IS '내외국인법인원천-소득세등(가산세포함)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A90_INCOME_TAX_AMT IS '수정신고(세액)-소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A90_SP_TAX_AMT IS '근로소득-농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A90_ADD_TAX_AMT IS '근로소득-가산세 ';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A90_THIS_REFUND_TAX_AMT IS '근로소득-당월조정환급세액 ';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A90_PAY_INCOME_TAX_AMT IS '근로소득-소득세등(가산세포함)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A90_PAY_SP_TAX_AMT IS '근로소득-농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A99_PERSON_CNT IS '총합계-인원수';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A99_PAYMENT_AMT IS '총합계-총지급액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A99_INCOME_TAX_AMT IS '총합계-소득세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A99_SP_TAX_AMT IS '총합계-농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A99_ADD_TAX_AMT IS '총합계-가산세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A99_THIS_REFUND_TAX_AMT IS '총합계-당월조정환급세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A99_PAY_INCOME_TAX_AMT IS '총합계-소득세등(가산세포함)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.A99_PAY_SP_TAX_AMT IS '총합계-농어촌특별세';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.RECEIVE_REFUND_TAX_AMT IS '12.전월미환급세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.ALREADY_REFUND_TAX_AMT IS '13.기환급신청한세액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.REFUND_BALANCE_AMT IS '14.차감잔액(12-13)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.GENERAL_REFUND_AMT IS '15.일반환급';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.FINANCIAL_AMT IS '16.신탁재산금융회사등';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.ETC_REFUND_FINANCIAL_AMT IS '17.그밖의 환급세액-금융회사등';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.ETC_REFUND_MERGER_AMT IS '17.그밖의 환급세액-합병등';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.ADJUST_REFUND_TAX_AMT IS '18.조정대상환급세액(14+15+16+17)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.THIS_ADJUST_REFUND_TAX_AMT IS '19.당월조정환급세액계';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.NEXT_REFUND_TAX_AMT IS '20.차월이월환급세액(18-19)';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.REQUEST_REFUND_TAX_AMT IS '21.환급신청액';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRW_WITHHOLDING_DOC.LAST_UPDATED_BY IS '최종수정자';

-- PK.
ALTER TABLE HRW_WITHHOLDING_DOC ADD CONSTRAINTS HRW_WITHHOLDING_DOC_PK PRIMARY KEY(WITHHOLDING_DOC_ID);

CREATE UNIQUE INDEX HRW_WITHHOLDING_DOC_U1 ON HRW_WITHHOLDING_DOC(WITHHOLDING_NO, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE
CREATE SEQUENCE HRW_WITHHOLDING_DOC_S1;
-- ANALYZE.
ANALYZE TABLE HRW_WITHHOLDING_DOC COMPUTE STATISTICS;
ANALYZE INDEX HRW_WITHHOLDING_DOC_U1 COMPUTE STATISTICS;
