/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_PREVIOUS_WORK
/* Description  : 연말정산 전근무지 자료.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRA_PREVIOUS_WORK
( YEAR_YYYY                           VARCHAR2(4) NOT NULL,                  
  SOB_ID                              NUMBER NOT NULL,                       
  ORG_ID                              NUMBER NOT NULL,			                 
  PERSON_ID                           NUMBER NOT NULL,		                   
  SEQ_NUM                             NUMBER NOT NULL,		                   
  COMPANY_NAME	                      VARCHAR2(100) NOT NULL,                
  COMPANY_NUM	                        VARCHAR2(20) NOT NULL,                 
  JOIN_DATE	                          DATE,								                   
  RETR_DATE	                          DATE,								                   
  LONG_YYYY	                          NUMBER,							                   
  LONG_MONTH	                        NUMBER,							                   
  PAY_TOTAL_AMT	                      NUMBER,							                   
  BONUS_TOTAL_AMT	                    NUMBER,							                   
  ADD_BONUS_AMT	                      NUMBER,							                   
  STOCK_BENE_AMT	                    NUMBER,							                   
  ANNU_INSUR_AMT	                    NUMBER,							                   
  MEDIC_INSUR_AMT	                    NUMBER,							                   
  HIRE_INSUR_AMT	                    NUMBER,							                   
  SAVE_TAX_DEDAMT	                    NUMBER,							                   
  IN_TAX_AMT	                        NUMBER,							                   
  LOCAL_TAX_AMT	                      NUMBER,							                   
  SP_TAX_AMT	                        NUMBER,							                   
  GLORY_AMT	                          NUMBER,							                   
  ETC_AMT	                            NUMBER,							                   
  GROUP_INSUR_AMT	                    NUMBER,							                   
  SUPP_TOTAL_AMT	                    NUMBER,							                   
  DESCRIPTION                         VARCHAR2(100),			                   
  ATTRIBUTE1                          VARCHAR2(100),			                   
  ATTRIBUTE2                          VARCHAR2(100),			                   
  ATTRIBUTE3                          VARCHAR2(100),			                   
  ATTRIBUTE4                          VARCHAR2(100),			                   
  ATTRIBUTE5                          VARCHAR2(100),                         
  CREATION_DATE                       DATE NOT NULL,			                   
  CREATED_BY                          NUMBER NOT NULL,		                   
  LAST_UPDATE_DATE                    DATE NOT NULL,			                   
  LAST_UPDATED_BY                     NUMBER NOT NULL,		                   
  NT_SCH_EDU_AMT	                    NUMBER,							                   
  NT_MEMBER_AMT	                      NUMBER,							                   
  NT_GUARD_AMT	                      NUMBER,							                   
  NT_CHILD_AMT	                      NUMBER,							                   
  NT_HIGH_SCH_AMT	                    NUMBER,							                   
  NT_SPECIAL_AMT	                    NUMBER,							                   
  NT_RESEARCH_AMT	                    NUMBER,							                   
  NT_COMPANY_AMT	                    NUMBER,							                   
  NT_COVER_AMT	                      NUMBER,							                   
  NT_WILD_AMT	                        NUMBER,							                   
  NT_DISASTER_AMT	                    NUMBER,							                   
  NT_OUTSIDE_GOVER_AMT	              NUMBER,							                   
  NT_OUTSIDE_ARMY_AMT	                NUMBER,							                   
  NT_OUTSIDE_WORK1	                  NUMBER,							                   
  NT_OUTSIDE_WORK2	                  NUMBER,							                   
  NT_STOCK_BENE_AMT	                  NUMBER,                                 
  NT_FORE_ENG_AMT                     NUMBER,                                 
  NT_EMPL_STOCK_AMT                   NUMBER,                                 
  NT_EMPL_BENE_AMT1	                  NUMBER,							                   
  NT_EMPL_BENE_AMT2	                  NUMBER,							                   
  NT_HOUSE_SUBSIDY_AMT	              NUMBER,							                   
  NT_SEA_RESOURCE_AMT	                NUMBER,							                   
  NT_ETC_AMT	                        NUMBER,							                   
  NT_FOREIGNER_AMT	                  NUMBER,							                   
  NT_BIRTH_AMT	                      NUMBER,							                   
  NT_OT_AMT	                          NUMBER,							                   
  NT_OUTSIDE_AMT	                    NUMBER		
) 
  TABLESPACE FCM_TS_DATA;

--> COMMET 설정 
COMMENT ON COLUMN HRA_PREVIOUS_WORK.YEAR_YYYY IS '정산년도';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.PERSON_ID IS '사원번호';  
COMMENT ON COLUMN HRA_PREVIOUS_WORK.SEQ_NUM IS '전근무지 일련번호';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.COMPANY_NAME IS '업체명';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.COMPANY_NUM IS '사업자번호';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.JOIN_DATE IS '입사일자';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.RETR_DATE IS '퇴사일자';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.LONG_YYYY IS '근속년수';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.LONG_MONTH IS '근속월수';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.PAY_TOTAL_AMT IS '총급여액';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.BONUS_TOTAL_AMT IS '총상여액';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.ADD_BONUS_AMT IS '인정상여액';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.STOCK_BENE_AMT IS '주식매수선택권 행사이익';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.ANNU_INSUR_AMT IS '국민연금';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.MEDIC_INSUR_AMT IS '건강보험료';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.HIRE_INSUR_AMT IS '고용보험료';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.SAVE_TAX_DEDAMT IS '세액공제액';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.IN_TAX_AMT IS '소득세';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.LOCAL_TAX_AMT IS '주민세';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.SP_TAX_AMT IS '농특세';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.CREATION_DATE IS '생성일자';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.LAST_UPDATE_DATE IS '최종 수정일시';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.LAST_UPDATED_BY IS '최종 수정자';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_SCH_EDU_AMT IS '비과세-학자금';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_MEMBER_AMT IS '비과세-무보수위원수당';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_GUARD_AMT IS '비과세-경호/승선수당';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_CHILD_AMT IS '비과세-유아/초중등_연구보조활동비';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_HIGH_SCH_AMT IS '비과세-고등_연구보조활동비';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_SPECIAL_AMT IS '비과세-특정연구기관육성법';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_RESEARCH_AMT IS '비과세-연구기관_연구보조활동비';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_COMPANY_AMT IS '비과세-기업연구소';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_COVER_AMT IS '비과세-취재수당';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_WILD_AMT IS '비과세-벽지수당';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_DISASTER_AMT IS '비과세-재해관련급';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_OUTSIDE_GOVER_AMT IS '비과세-외국정부등 근무자';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_OUTSIDE_ARMY_AMT IS '비과세-외국주둔군인등';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_OUTSIDE_WORK1 IS '비과세-국외근로(100만원)';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_OUTSIDE_WORK2 IS '비과세-국외근로(150만원)';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_STOCK_BENE_AMT IS '비과세-주식매수선택권';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_FORE_ENG_AMT IS '비과세-외근인기술자';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_EMPL_STOCK_AMT IS '비과세-우리사주조합배정';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_EMPL_BENE_AMT1 IS '비과세-우리사주조합인출금(50%)';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_EMPL_BENE_AMT2 IS '비과세-우리사주조합인출금(75%);';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_HOUSE_SUBSIDY_AMT IS '비과세-주택자금보조금';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_SEA_RESOURCE_AMT IS '비과세-해저광물자원개발';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_ETC_AMT IS '비과세-기타';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_FOREIGNER_AMT IS '비과세-외국인근로자';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_BIRTH_AMT IS '비과세-출생/보육수당';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_OT_AMT IS '비과세-야간근로';
COMMENT ON COLUMN HRA_PREVIOUS_WORK.NT_OUTSIDE_AMT IS '비과세-국외소득';

--> 인덱스 생성.                                                                                                                           
CREATE UNIQUE INDEX HRA_PREVIOUS_WORK_U1 ON HRA_PREVIOUS_WORK(YEAR_YYYY, SOB_ID, ORG_ID, PERSON_ID, SEQ_NUM) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRA_PREVIOUS_WORK_N1 ON HRA_PREVIOUS_WORK(YEAR_YYYY, SOB_ID, ORG_ID, PERSON_ID) TABLESPACE FCM_TS_IDX;

--> ANALYZE TABLE/INDEX;
ANALYZE TABLE HRA_PREVIOUS_WORK COMPUTE STATISTICS;
ANALYZE INDEX HRA_PREVIOUS_WORK_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRA_PREVIOUS_WORK_N1 COMPUTE STATISTICS;
