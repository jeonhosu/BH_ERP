/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_FOUNDATION
/* Description  : 연말정산 기초자료.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRA_FOUNDATION
( YEAR_YYYY                                                   VARCHAR2(4) NOT NULL,
  PERSON_ID                                                   NUMBER NOT NULL,
  SOB_ID                                                      NUMBER NOT NULL,
  ORG_ID                                                      NUMBER NOT NULL,
  ADD_BONUS_AMT                                               NUMBER DEFAULT 0,
  ADD_EDUCATION_AMT                                           NUMBER DEFAULT 0,
  ADD_ETC_AMT                                                 NUMBER DEFAULT 0,
  INCOME_OUTSIDE_AMT                                          NUMBER DEFAULT 0,
  NONTAX_OUTSIDE_AMT                                          NUMBER DEFAULT 0,
  TAX_OUTSIDE_AMT                                             NUMBER DEFAULT 0,
  IN_TAX_AMT                                                  NUMBER DEFAULT 0,
  LOCAL_TAX_AMT                                               NUMBER DEFAULT 0,                                                                            
  ANNU_INSUR_AMT                                              NUMBER DEFAULT 0,
  HIRE_MEDIC_INSUR_AMT                                        NUMBER DEFAULT 0,
  GUAR_INSUR_AMT                                              NUMBER DEFAULT 0,
  DEFORM_INSUR_AMT                                            NUMBER DEFAULT 0,
  MEDIC_AMT                                                   NUMBER DEFAULT 0,
  EDUCATION_AMT                                               NUMBER DEFAULT 0,
  HOUSE_SAVE_AMT                                              NUMBER DEFAULT 0,
  HOUSE_ADD_AMT                                               NUMBER DEFAULT 0,
  LONG_HOUSE_INTER_AMT                                        NUMBER DEFAULT 0,
  LONG_HOUSE_INTER_AMT_1                                      NUMBER DEFAULT 0,
  LONG_HOUSE_INTER_AMT_2                                      NUMBER DEFAULT 0,
  SMALL_CORPOR_DED_AMT                                        NUMBER DEFAULT 0,
  LONG_STOCK_SAVING_AMT_1                                     NUMBER DEFAULT 0,
  LONG_STOCK_SAVING_AMT_2                                     NUMBER DEFAULT 0,
  LONG_STOCK_SAVING_AMT_3                                     NUMBER DEFAULT 0,  
  DONAT_ALL                                                   NUMBER DEFAULT 0,
  ETC_DONAT_ALL                                               NUMBER DEFAULT 0,
  DONAT_50P                                                   NUMBER DEFAULT 0,
  ETC_DONAT_50P                                               NUMBER DEFAULT 0,
  DONAT_30P                                                   NUMBER DEFAULT 0,
  ETC_DONAT_30P                                               NUMBER DEFAULT 0,
  DONAT_10P                                                   NUMBER DEFAULT 0,
  ETC_DONAT_10P                                               NUMBER DEFAULT 0,
  DONAT_10P_RELIGION                                          NUMBER DEFAULT 0,
  ETC_DONAT_10P_RELIGION                                      NUMBER DEFAULT 0,
  DONAT_POLI                                                  NUMBER DEFAULT 0,
  ETC_DONAT_POLI                                              NUMBER DEFAULT 0,
  MARRY_COUNT                                                 NUMBER DEFAULT 0, 
  FUNER_COUNT                                                 NUMBER DEFAULT 0,
  HOUSE_MOVE_COUNT                                            NUMBER DEFAULT 0,
  PERSON_ANNU_AMT                                             NUMBER DEFAULT 0,
  ANNU_BANK_AMT                                               NUMBER DEFAULT 0,
  RETR_ANNU_AMT                                               NUMBER DEFAULT 0,
  INVES_AMT                                                   NUMBER DEFAULT 0,
  CREDIT_AMT                                                  NUMBER DEFAULT 0,
  ACADE_GIRO_AMT                                              NUMBER DEFAULT 0,
  CASH_AMT                                                    NUMBER DEFAULT 0,
  EMPL_STOCK_AMT                                              NUMBER DEFAULT 0,
  HOUSE_DEBT_BEN_AMT                                          NUMBER DEFAULT 0,
  DESCRIPTION                                                 VARCHAR2(100),
  ATTRIBUTE1                                                  VARCHAR2(100),
  ATTRIBUTE2                                                  VARCHAR2(100),
  ATTRIBUTE3                                                  VARCHAR2(100),
  ATTRIBUTE4                                                  VARCHAR2(100),
  ATTRIBUTE5                                                  VARCHAR2(100),
  CREATION_DATE                                               DATE NOT NULL,
  CREATED_BY                                                  NUMBER NOT NULL,
  LAST_UPDATE_DATE                                            DATE NOT NULL,
  LAST_UPDATED_BY                                             NUMBER NOT NULL,
  HOUSE_APP_DEPOSIT_AMT                                       NUMBER DEFAULT 0,
  HOUSE_MONTHLY_AMT                                           NUMBER DEFAULT 0,
  LOW_HOUSE_ADD_AMT                                           NUMBER DEFAULT 0
) TABLESPACE FCM_TS_DATA;

--> COMMET 설정 
COMMENT ON TABLE HRA_FOUNDATION IS '연말정산기초자료';
COMMENT ON COLUMN HRA_FOUNDATION.YEAR_YYYY IS '정산년도';
COMMENT ON COLUMN HRA_FOUNDATION.PERSON_ID IS '사원번호';
COMMENT ON COLUMN HRA_FOUNDATION.ADD_BONUS_AMT IS '인정상여금';
COMMENT ON COLUMN HRA_FOUNDATION.ADD_EDUCATION_AMT IS '학자금';
COMMENT ON COLUMN HRA_FOUNDATION.ADD_ETC_AMT IS '기타지급';
COMMENT ON COLUMN HRA_FOUNDATION.INCOME_OUTSIDE_AMT IS '과세-국외소득';
COMMENT ON COLUMN HRA_FOUNDATION.NONTAX_OUTSIDE_AMT IS '비과세-국외소득';
COMMENT ON COLUMN HRA_FOUNDATION.TAX_OUTSIDE_AMT IS '세액-국외소득';
COMMENT ON COLUMN HRA_FOUNDATION.IN_TAX_AMT IS '(기타)기납소득세';
COMMENT ON COLUMN HRA_FOUNDATION.LOCAL_TAX_AMT IS '(기타)기납주민세';
COMMENT ON COLUMN HRA_FOUNDATION.ANNU_INSUR_AMT IS '기타연금보험료';
COMMENT ON COLUMN HRA_FOUNDATION.HIRE_MEDIC_INSUR_AMT IS '기타고용의료보험료';
COMMENT ON COLUMN HRA_FOUNDATION.GUAR_INSUR_AMT IS '보장보험료';
COMMENT ON COLUMN HRA_FOUNDATION.DEFORM_INSUR_AMT IS '장애보험료';
COMMENT ON COLUMN HRA_FOUNDATION.MEDIC_AMT IS '본인 의료비';
COMMENT ON COLUMN HRA_FOUNDATION.EDUCATION_AMT IS '본인 교육비';
COMMENT ON COLUMN HRA_FOUNDATION.HOUSE_SAVE_AMT IS '주택마련저축';
COMMENT ON COLUMN HRA_FOUNDATION.HOUSE_ADD_AMT IS '주택원리금상환';
COMMENT ON COLUMN HRA_FOUNDATION.LONG_HOUSE_INTER_AMT IS '장기주택이자상환';
COMMENT ON COLUMN HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_1 IS '장기주택이자상환(한도1000만원)';
COMMENT ON COLUMN HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_2 IS '장기주택이자상환(한도1500만원)';
COMMENT ON COLUMN HRA_FOUNDATION.SMALL_CORPOR_DED_AMT IS '소기업공제부금 소득공제';
COMMENT ON COLUMN HRA_FOUNDATION.LONG_STOCK_SAVING_AMT_1 IS '장기주식형저축소득공제1년차';
COMMENT ON COLUMN HRA_FOUNDATION.LONG_STOCK_SAVING_AMT_2 IS '장기주식형저축소득공제2년차';
COMMENT ON COLUMN HRA_FOUNDATION.LONG_STOCK_SAVING_AMT_3 IS '장기주식형저축소득공제3년차';
COMMENT ON COLUMN HRA_FOUNDATION.DONAT_ALL IS '전액 기부금';
COMMENT ON COLUMN HRA_FOUNDATION.ETC_DONAT_ALL IS '기타 전액 기부금';
COMMENT ON COLUMN HRA_FOUNDATION.DONAT_50P IS '50% 기부금';
COMMENT ON COLUMN HRA_FOUNDATION.ETC_DONAT_50P IS '기타 50% 기부금';
COMMENT ON COLUMN HRA_FOUNDATION.DONAT_30P IS '30% 기부금';
COMMENT ON COLUMN HRA_FOUNDATION.ETC_DONAT_30P IS '기타 30% 기부금';
COMMENT ON COLUMN HRA_FOUNDATION.DONAT_10P IS '10% 기부금';
COMMENT ON COLUMN HRA_FOUNDATION.ETC_DONAT_10P IS '기타 10% 기부금';
COMMENT ON COLUMN HRA_FOUNDATION.DONAT_10P_RELIGION IS '지정기부금-종교기부금';
COMMENT ON COLUMN HRA_FOUNDATION.ETC_DONAT_10P_RELIGION IS '기타 지정기부금-종교기부금';
COMMENT ON COLUMN HRA_FOUNDATION.DONAT_POLI IS '정치 기부금';
COMMENT ON COLUMN HRA_FOUNDATION.ETC_DONAT_POLI IS '기타 정치 기부금';
COMMENT ON COLUMN HRA_FOUNDATION.MARRY_COUNT IS '결혼수';
COMMENT ON COLUMN HRA_FOUNDATION.FUNER_COUNT IS '장례수';
COMMENT ON COLUMN HRA_FOUNDATION.HOUSE_MOVE_COUNT IS '이사수';
COMMENT ON COLUMN HRA_FOUNDATION.PERSON_ANNU_AMT IS '개인연금저축';
COMMENT ON COLUMN HRA_FOUNDATION.ANNU_BANK_AMT IS '연금저축';
COMMENT ON COLUMN HRA_FOUNDATION.RETR_ANNU_AMT IS '퇴직 연금저축';
COMMENT ON COLUMN HRA_FOUNDATION.INVES_AMT IS '투자조합 출자';
COMMENT ON COLUMN HRA_FOUNDATION.CREDIT_AMT IS '신용카드 금액';
COMMENT ON COLUMN HRA_FOUNDATION.ACADE_GIRO_AMT IS '학원 지로비';
COMMENT ON COLUMN HRA_FOUNDATION.CASH_AMT IS '현금영수증';
COMMENT ON COLUMN HRA_FOUNDATION.EMPL_STOCK_AMT IS '우리사주출자';
COMMENT ON COLUMN HRA_FOUNDATION.HOUSE_DEBT_BEN_AMT IS '주택차입금이자 상환액 세액공제';
COMMENT ON COLUMN HRA_FOUNDATION.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRA_FOUNDATION.CREATION_DATE IS '생성일자';
COMMENT ON COLUMN HRA_FOUNDATION.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRA_FOUNDATION.LAST_UPDATE_DATE IS '최종 수정일시';
COMMENT ON COLUMN HRA_FOUNDATION.LAST_UPDATED_BY IS '최종 수정자';
COMMENT ON COLUMN HRA_FOUNDATION.HOUSE_APP_DEPOSIT_AMT IS '주탁청약종합저축 불입액 소득공제';
COMMENT ON COLUMN HRA_FOUNDATION.HOUSE_MONTHLY_AMT IS '저소득근로자 월세소득공제';
COMMENT ON COLUMN HRA_FOUNDATION.LOW_HOUSE_ADD_AMT IS '저소득근로자 주택임차차입금원리금상황액 소득공제';


--> 인덱스 생성.                                                                                                                           
CREATE UNIQUE INDEX HRA_FOUNDATION_U1 ON HRA_FOUNDATION(YEAR_YYYY, PERSON_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;


--> ANALYZE TABLE/INDEX;
ANALYZE TABLE HRA_FOUNDATION COMPUTE STATISTICS;
ANALYZE INDEX HRA_FOUNDATION_U1 COMPUTE STATISTICS;


