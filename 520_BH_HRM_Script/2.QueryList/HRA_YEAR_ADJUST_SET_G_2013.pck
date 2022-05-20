CREATE OR REPLACE PACKAGE HRA_YEAR_ADJUST_SET_G_2013 AS
  /*================================================================================/
       ==> 연말정산 처리(2008. 12. 25)
         0. 연말정산 처리 기초자료 생성;
         1. 급여, 상여, 비과세(차량유지비, 야간근로수당),
         2. 전근무지 자료;
         3. 인정상여, 학자;
         3.5 근로소득 공제 계산 ?;
         4. 인적공제;
         5. 보험료 공제;
         6. 의료비 공제;
         7. 교육비 공제;
         8-1. 주택자금 공제(주택임차차입금원리금상환액/장기주택저당차입금이자상환액);
         8-2. 주택마련저축소득공제;
         9. 기부금 공제 (정치자금 공제 );
         10. 혼인, 장례, 이상비용 공제;
         11.1 개인연금저축소득공제  ?;
         11.2 연금저축 공제 ;
         11.3 퇴직연금 저축 ;
         12. 투자조합출자 ;
         13. 신용카드?    ;   ;
         14. 우리사주출연 ? ;
         14-1. 소기업/소상공인 공제부금에 대한 소득공제;
         14-2. 장기주식형저축소득공제;
         15. 과세표준;
         16.1 근로소득세액공제  ;
         16.2 납세조합 세금공제(을종 소득이 있는자에 한해) -- 해당 없음  ;
         16.3 주택자금차입금 세액공제  ;
         17. 결정세액  ;
         18. 차감세액  ;
  /================================================================================*/
  PROCEDURE MAIN_CAL
            ( P_CORP_ID           IN NUMBER
            , P_YEAR_YYYY         IN VARCHAR2
            , P_STD_DATE          IN DATE
            , P_DEPT_ID           IN NUMBER
            , P_FLOOR_ID          IN NUMBER
            , P_EMPLOYE_TYPE      IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_USER_ID           IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );

  -- 0. 연말정산 처리 대상 산출;
  PROCEDURE BASIC_CREATION
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN NUMBER
            , P_YEAR_YYYY         IN VARCHAR2
            , P_STD_DATE          IN DATE
            , P_DEPT_ID           IN NUMBER
            , P_FLOOR_ID          IN NUMBER
            , P_EMPLOYE_TYPE      IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_USER_ID           IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

  -- 3.5 근로소득공제 계산;
  FUNCTION INCOME_DED_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;

  -- 4. 인적공제;
  FUNCTION SUPP_FAMILY_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_STD_DATE          IN DATE
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 5. 보험료 공제;
  FUNCTION ETC_INSUR_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 6. 의료비 공제;
  FUNCTION MEDIC_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;

  -- 7. 교육비 공제;
  FUNCTION EDUCATION_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 8-1. 주택자금 공제(주택임차차입금원리금상환액);
  FUNCTION HOUSE_FUND_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;

  -- 8-2. 주택자금 공제(월세소득공제);
  FUNCTION HOUSE_FUND_MONTHLY_RENT_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;
            
  -- 8-3. 주택자금 공제(장기주택이자상환액);
  FUNCTION HOUSE_FUND_LONG_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;
            
  -- 8-4. 주택마련저축소득공제;
  FUNCTION HOUSE_SAVE_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 9. 기부금 공제
  FUNCTION DONATION_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_INCOME_AMT        IN NUMBER
            ) RETURN NUMBER;

  -- 10. 혼인, 장례, 이상비용 공제;
  FUNCTION MARRY_ETC_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;

  -- 11.1 개인연금저축소득공제, 퇴직연금 저축
  FUNCTION PER_ANNU_BANK_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 11.2 연금저축소득공제, 퇴직연금 저축;
  FUNCTION ANNU_BANK_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 11.3 퇴직연금 저축 ;
  FUNCTION RETR_ANNU_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 12. 투자조합출자;
  FUNCTION INVEST_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_INCOME_AMT        IN NUMBER
            ) RETURN NUMBER;

  -- 14.1 주택청약종합저축 불입액 소득공제;
  FUNCTION HOUSE_APP_DEPOSIT_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_HOUSE_DED_AMT     IN NUMBER
            ) RETURN NUMBER;

  -- 13. 신용카드등 공제;
  FUNCTION CARD_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;

  -- 14. 우리사주출연;
  FUNCTION EMPL_STOCK_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 14-1. 소기업/소상공인 공제부금에 대한 소득공제;
  FUNCTION SMALL_CORPOR_DED_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 14-2. 장기주식형저축소득공제;
  FUNCTION LONG_STOCK_SAVING_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;
            
  -- 14-4. 목돈안드는 전세 이자상환액 공제;
  FUNCTION FIX_LEASE_DED_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;            

-- 14-9. 특별공제 종합한도 초과액;
  FUNCTION SPECIAL_DED_LMT_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;
            
  -- 15. 과세표준 ;
  FUNCTION COMP_TAX_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TAX_STD_AMT       IN NUMBER
            ) RETURN NUMBER;

  -- 16.1 세액감면 - 소득세법 ;
  FUNCTION TAX_REDU_IN_LAW_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_INCOME_AMT        IN NUMBER
            , P_COMP_TAX_AMT      IN NUMBER
            ) RETURN NUMBER;

  -- 16.2 세액감면 - 조세특례제한법 ;
  FUNCTION TAX_REDU_SP_LAW_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_INCOME_AMT        IN NUMBER
            , P_COMP_TAX_AMT      IN NUMBER
            ) RETURN NUMBER;

  -- 16.3 세액감면 - 조세조약;
  FUNCTION TAX_REDU_TAX_TREATY_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_INCOME_AMT        IN NUMBER
            , P_COMP_TAX_AMT      IN NUMBER
            ) RETURN NUMBER;
            
  -- 17.1 근로소득세액공제 ;
  FUNCTION TAX_DED_INCOME_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_COMP_TAX_AMT      IN NUMBER
            ) RETURN NUMBER;

  -- 17.2 납세조합 세액공제;
  FUNCTION TAX_DED_TAXGROUP_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_COMP_TAX_AMT      IN NUMBER
            ) RETURN NUMBER;

  -- 17.3 주택자금차입금 세액공제;
  FUNCTION HOUSE_DEBT_BEN_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_REAL_TAX          IN NUMBER
            ) RETURN NUMBER;

END HRA_YEAR_ADJUST_SET_G_2013;
/
CREATE OR REPLACE PACKAGE BODY HRA_YEAR_ADJUST_SET_G_2013 AS
  /*================================================================================/
       ** 2013-12-31 JEON HO SU MODIFIED                                          **
       ==> 연말정산 처리(2008. 12. 25)
         0. 연말정산 처리 기초자료 생성;
         1. 급여, 상여, 비과세(차량유지비, 야간근로수당),
         2. 전근무지 자료;
         3. 인정상여, 학자;
         3.5 근로소득 공제 계산 ?;
         4. 인적공제;
         5. 보험료 공제;
         6. 의료비 공제;
         6.1 장애인, 기타 의료비 구분 
         7. 교육비 공제;
         7.1 장애인, 기타 교육비 구분 
         8-1. 주택자금 공제(주택임차차입금원리금상환액/장기주택저당차입금이자상환액);
         8-2. 주택마련저축소득공제;
         9. 기부금 공제 (정치자금 공제 );
         10. 혼인, 장례, 이상비용 공제;
         11.1 개인연금저축소득공제  ?;
         11.2 연금저축 공제 ;
         11.3 퇴직연금 저축 ;
         12. 투자조합출자 ;
         13. 신용카드?    ;   ;
         14. 우리사주출연 ? ;
         14-1. 소기업/소상공인 공제부금에 대한 소득공제;
         14-2. 장기주식형저축소득공제;
         -- 특별공제 종합한도 초과액 공제 
         15. 과세표준;
         16.1 근로소득세액공제  ;
         16.2 납세조합 세금공제(을종 소득이 있는자에 한해) -- 해당 없음  ;
         16.3 주택자금차입금 세액공제  ;
         17. 결정세액  ;
         18. 차감세액  ;
  /================================================================================*/
  PROCEDURE MAIN_CAL
            ( P_CORP_ID           IN NUMBER
            , P_YEAR_YYYY         IN VARCHAR2
            , P_STD_DATE          IN DATE
            , P_DEPT_ID           IN NUMBER
            , P_FLOOR_ID          IN NUMBER
            , P_EMPLOYE_TYPE      IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_USER_ID           IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_PRE_YEAR                    VARCHAR2(4);
    V_STR_MONTH                   VARCHAR2(7);
    V_END_MONTH                   VARCHAR2(7);
    V_START_DATE                  DATE;
    
    V_TEMP_AMT                    NUMBER;
    V_TEMP_RATE                   NUMBER;
    
    ---------------------------------------------------------------------------------------------------     
    --- 종전 내역 합계  
    V_PRE_PAY_SUM                 NUMBER;  -- 종전 급여합계  ;
    V_PRE_BONUS_SUM               NUMBER;  -- 종전 상여합계 ; 
    V_PRE_ADD_BONUS               NUMBER;  -- 종전 인정상여 합계 ; 
    V_PRE_STOCK_BENE_AMT          NUMBER;  -- 종전 주식매수선택권 행사이익  ;
    V_PRE_EMPLOYEE_STOCK_AMT      NUMBER;  -- 2013년 추가 : 종전 우리사주조합인출금  
    V_PRE_OFFICE_RETIRE_OVER_AMT  NUMBER;  -- 2013년 추가 : 종전 임원퇴직소득금액 한도초과액  
    
    V_PRE_ANNU_INSUR_AMT          NUMBER;  -- 종전 국민연금;
    V_PRE_PUBLIC_INSUR_AMT        NUMBER;  -- 2013년 추가 : 종전 공무원연금보험 
    V_PRE_MARINE_INSUR_AMT        NUMBER;  -- 2013년 추가 : 종전 군인연금보험  
    V_PRE_SCHOOL_STAFF_INSUR_AMT  NUMBER;  -- 2013년 추가 : 종전 사립학교 교직원연금보험
    V_PRE_POST_OFFICE_INSUR_AMT   NUMBER;  -- 2013년 추가 : 종전 별정우체국연금보험 
     
    V_PRE_MEDIC_INSUR_AMT         NUMBER;  -- 종전 건강보험 합계 ; 
    V_PRE_HIRE_INSUR_AMT          NUMBER;  -- 종전 고용보험 합계 ;
    
    V_PRE_IN_TAX_AMT              NUMBER;  -- 종전 소득세 합계 ; 
    V_PRE_LOCAL_TAX_AMT           NUMBER;  -- 종전 주민세 합계 ; 
    
    ---------------------------------------------------------------------------------------------------     
    -- 본인자료 생성 위한 기준값 - 경로우대 공제 기준.
    V_OLD_DED_AGE                 NUMBER;
    V_OLD_DED_AGE1                NUMBER;
    
    -- 전년도 야간비과세 대상자 여부--
    V_PRE_YEAR_OT_DED_FLAG        VARCHAR2(2) := 'N';
          
    --- 지급 내역 합계              
    V_PAY_SUM                     NUMBER;  -- 현 급여합계  ;
    V_BONUS_SUM                   NUMBER;  -- 현 상여합계 ;  
    V_ADD_BONUS                   NUMBER;  -- 현 인정상여 합계   ;
    
    V_STOCK_BENE_AMT              NUMBER;  -- 2013년 추가 : 주식매수선택권 행사이익  
    V_EMPLOYEE_STOCK_AMT          NUMBER;  -- 2013년 추가 : 우리사주조합인출금  
    V_OFFICERS_RETIRE_OVER_AMT    NUMBER;  -- 2013년 추가 : 임원퇴직소득금액 한도초과액  
    
    --- 국외소득       
    V_INCOME_OUTSIDE_AMT          NUMBER;  -- 국외 과세 소득 ; 
    V_NONTAX_OUTSIDE_AMT          NUMBER;  -- 국외 비과세 소득  ;
    V_TAX_OUTSIDE_AMT             NUMBER;  -- 국외 기납부세액  ;                                      
  
    --- 비과세
    V_NONTAX_ETC_AMT              NUMBER;   -- 기타비과세  ;
    V_NONTAX_OT_AMT               NUMBER;   -- 야간근로비과세  ;
    V_NONTAX_BABY_AMT             NUMBER;   -- 육아보육수당.
    V_NONTAX_OUTS_WORK_1          NUMBER;   -- 비과세 국외수당;   
    V_NONTAX_OUTS_WORK_2          NUMBER;   -- 비과세 국외수당(300만원);  
    
    
    --- 공제 내역 합게  
    V_IN_TAX_AMT                  NUMBER;   -- 소득세 합계; 
    V_LOCAL_TAX_AMT               NUMBER;   -- 주민세 합계; 

---------------------------------------------------------------------------------------------------  
    V_TOTAL_PAY                   NUMBER;  -- 총 급여(현 급여합계 + 종전 급여합계);
  
    V_INCOME_DED_AMT              NUMBER;  -- 근로소득공제 금액  ;
    V_INCOME_PAY                  NUMBER;  -- 총지급액 - 근로소득공제 금액 ;
    V_REAL_TAX                    NUMBER;  -- 실세금액 
  
    V_SUPP_FAMILY_DED_AMT         NUMBER;  -- 인적공제 합계  ;  
        
    V_ANNU_INSUR_AMT              NUMBER;  -- 국민연금;
    V_PUBLIC_INSUR_AMT            NUMBER;  -- 2013년 추가 : 공무원연금보험 
    V_MARINE_INSUR_AMT            NUMBER;  -- 2013년 추가 : 군인연금보험  
    V_SCHOOL_STAFF_INSUR_AMT      NUMBER;  -- 2013년 추가 : 사립학교 교직원연금보험
    V_POST_OFFICE_INSUR_AMT       NUMBER;  -- 2013년 추가 : 별정우체국연금보험 
     
    V_MEDIC_INSUR_AMT             NUMBER;  -- 건강보험 합계 ; 
    V_HIRE_INSUR_AMT              NUMBER;  -- 고용보험 합계 ;
    
    V_ANNU_BANK_AMT               NUMBER;  -- 연금저축  ;
    V_RETR_ANNU_AMT               NUMBER;  -- 퇴직연금저축  ;
      
    V_INSURE_DED_AMT              NUMBER;  -- 보험료 합계  ; 
    V_MEDIC_DED_AMT               NUMBER;  -- 의료비 합계 ;
    V_EDU_DED_AMT                 NUMBER;  -- 교육비 합계 ;
    V_HOUSE_DED_AMT               NUMBER;  -- 주택자금 합계; 
    V_DONAT_DED_AMT               NUMBER;  -- 기부금 합계 ;
    V_MARRY_ETC_DED_AMT           NUMBER;  -- 혼인장례이사 합계 ;
  
    V_SP_STD_DED_AMT              NUMBER;  -- 표준공제 ;
    V_SP_DED_SUM                  NUMBER;  -- 특별공제 합계 ;
    V_SUBT_DED_AMT                NUMBER;  -- 차감소득공제 ; 
  
    V_PER_ANNU_BANK_AMT           NUMBER;  -- 개인연금저축;  
    V_HOUSE_SAVE_AMT              NUMBER;  -- 주택마련저축공제;
    V_CARD_AMT                    NUMBER;  -- 신용카드, 현금영수증 공제 ;
    
    V_SMALL_CORPOR_DED_AMT        NUMBER;  -- 2008 - 소기업/소상인 공제부금액;
    V_INVEST_AMT                  NUMBER;  -- 2008 - 투자조합 출자;    
    V_EMPL_STOCK_AMT              NUMBER;  -- 2008 - 우리사주출연금  ;
    V_HIRE_KEEP_EMPLOY_AMT        NUMBER;  -- 2008 - 고용유지중소기업근로자소득공제 ;
    
    --> 2011년도 추가;     
    V_HOUSE_APP_DEPOSIT_AMT       NUMBER;  -- 주택청약종합저축 불입액 소득공제;  
    V_LONG_STOCK_SAVING_AMT       NUMBER;  -- 장기주식저축;;
    V_FIX_LEASE_DED_AMT           NUMBER;  -- 2013-목돈안드는 전세 이자상환액 ;
    V_ETC_DED_SUM                 NUMBER;  -- 기타소득공제 계  ;
    
    V_SP_DED_TOT_AMT              NUMBER;  -- 2013-특별공제 종합한도 초과액 
    V_TAX_STD_AMT                 NUMBER;  -- 과세표준 ; 
    V_COMP_TAX_AMT                NUMBER;  -- 산출세액 ; 
  
    V_TAX_REDU_IN_LAW_AMT         NUMBER;  -- 세액감면-소득세법.
    V_TAX_REDU_SP_LAW_AMT         NUMBER;  -- 세액감면-조세특례제한법.
    V_TAX_REDU_TAX_TREATY         NUMBER;  -- 세액감면-조세조약.
    
    F_IN_TAX_AMT                  NUMBER; -- 결정소득세 합계 ; 
    F_SP_TAX_AMT                  NUMBER; -- 결정농특세 합계.;
    F_LOCAL_TAX_AMT               NUMBER; -- 결정주민세 합계  ;
    S_IN_TAX_AMT                  NUMBER; -- 차감소득세 합계;  
    S_SP_TAX_AMT                  NUMBER; -- 차감농특세 합계.;
    S_LOCAL_TAX_AMT               NUMBER; -- 차감주민세 합계  ;
  
---------------------------------------------------------------------------------------------------     
    V_RECORD_COUNT                NUMBER;
  BEGIN
---> 초기화  
    O_STATUS := 'F';
    
    BEGIN
      V_STR_MONTH := P_YEAR_YYYY || '-01';
      V_END_MONTH := P_YEAR_YYYY || '-12';
      V_START_DATE := TRUNC(P_STD_DATE, 'MONTH');
      V_PRE_YEAR := TO_CHAR(TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') - 1, 'YYYY');
    EXCEPTION
      WHEN OTHERS THEN
        V_START_DATE := P_STD_DATE;
        V_PRE_YEAR := P_YEAR_YYYY - 1;
    END;
    
---> 0. 연말정산 처리 기초자료 생성  
    BASIC_CREATION
      ( P_CORP_ID           => P_CORP_ID
      , P_YEAR_YYYY         => P_YEAR_YYYY
      , P_STD_DATE          => P_STD_DATE
      , P_DEPT_ID           => P_DEPT_ID
      , P_FLOOR_ID          => P_FLOOR_ID
      , P_EMPLOYE_TYPE      => P_EMPLOYE_TYPE
      , P_PERSON_ID         => P_PERSON_ID
      , P_USER_ID           => P_USER_ID
      , P_SOB_ID            => P_SOB_ID
      , P_ORG_ID            => P_ORG_ID
      , O_STATUS            => O_STATUS
      , O_MESSAGE           => O_MESSAGE
      );
    IF O_STATUS = 'F' THEN
      RETURN;
    END IF;

---> 1. 기준정보 조회 : 경로우대 기준.
    BEGIN
      SELECT HIT.OLD_DED_AGE
           , HIT.OLD_DED_AGE1
        INTO V_OLD_DED_AGE
           , V_OLD_DED_AGE1
        FROM HRA_INCOME_TAX_STANDARD HIT
       WHERE HIT.YEAR_YYYY        = P_YEAR_YYYY
         AND HIT.SOB_ID           = P_SOB_ID
         AND HIT.ORG_ID           = P_ORG_ID
         ;
    EXCEPTION WHEN OTHERS THEN
      V_OLD_DED_AGE := 'N';
      V_OLD_DED_AGE1 := 'N';
    END;
    
---> 1. 부양가족 존재 여부 체크 : 없으면 본인자료만 자동으로 생성.
    FOR C1 IN (SELECT HA.PERSON_ID
                   , PM.NAME
                   , PM.DISPLAY_NAME
                   , PM.REPRE_NUM
                   , DECODE(HB.DISABLED_ID, NULL, 'N', 'Y') AS DISABILITY_YN
                 FROM HRM_PERSON_MASTER PM
                   , (-- 시점 인사내역.
                      SELECT HL.PERSON_ID
                           , HL.DEPT_ID
                           , HL.POST_ID
                           , HL.PAY_GRADE_ID
                           , HL.FLOOR_ID
                           , HL.JOB_CATEGORY_ID
                           , HL.JOB_CLASS_ID
                           , HL.OCPT_ID
                           , HL.ABIL_ID
                        FROM HRM_HISTORY_HEADER HH
                           , HRM_HISTORY_LINE   HL 
                      WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
                        AND HH.CHARGE_SEQ           IN 
                              (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                  FROM HRM_HISTORY_HEADER S_HH
                                     , HRM_HISTORY_LINE   S_HL
                                 WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                   AND S_HH.CHARGE_DATE       <= LAST_DAY(P_STD_DATE) 
                                   AND S_HL.PERSON_ID         = HL.PERSON_ID
                                 GROUP BY S_HL.PERSON_ID
                               )        
                    ) T1                      
                   , HRA_YEAR_ADJUSTMENT HA
                   , HRM_BODY            HB                   
                WHERE PM.PERSON_ID      = T1.PERSON_ID
                  AND PM.PERSON_ID      = HA.PERSON_ID
                  AND PM.PERSON_ID      = HB.PERSON_ID(+)                  
                  AND HA.YEAR_YYYY      = P_YEAR_YYYY
                  AND HA.SOB_ID         = P_SOB_ID
                  AND HA.ORG_ID         = P_ORG_ID
                  AND HA.CLOSED_FLAG   != 'Y'  -- 마감 되지 않은 데이터만 처리 -- 
                  AND ((P_PERSON_ID     IS NULL AND 1 = 1)
                    OR (P_PERSON_ID     IS NOT NULL AND HA.PERSON_ID = P_PERSON_ID)) 
                  AND PM.CORP_ID        = P_CORP_ID                  
                  AND PM.SOB_ID         = P_SOB_ID
                  AND PM.ORG_ID         = P_ORG_ID
                  AND ((P_PERSON_ID     IS NULL AND 1 = 1)
                    OR (P_PERSON_ID     IS NOT NULL AND PM.PERSON_ID = P_PERSON_ID))                  
                  AND PM.JOIN_DATE     <= P_STD_DATE
                  AND ((P_EMPLOYE_TYPE  IS NULL AND (PM.RETIRE_DATE >= V_START_DATE OR PM.RETIRE_DATE IS NULL))
                    OR (P_EMPLOYE_TYPE != '3' AND (PM.RETIRE_DATE >= V_START_DATE OR PM.RETIRE_DATE IS NULL))
                    OR (P_EMPLOYE_TYPE  = '3' AND (PM.RETIRE_DATE BETWEEN V_START_DATE AND LAST_DAY(P_STD_DATE))))
                  AND ((P_DEPT_ID       IS NULL AND 1 = 1)
                  OR   (P_DEPT_ID       IS NOT NULL AND T1.DEPT_ID = P_DEPT_ID))
                  AND ((P_FLOOR_ID      IS NULL AND 1 = 1)
                  OR   (P_FLOOR_ID      IS NOT NULL AND T1.FLOOR_ID = P_FLOOR_ID))
               )
    LOOP
      V_RECORD_COUNT := 0;
      BEGIN
        SELECT COUNT(SF.REPRE_NUM) AS FAMILY_COUNT
          INTO V_RECORD_COUNT
          FROM HRA_SUPPORT_FAMILY SF
        WHERE SF.YEAR_YYYY        = P_YEAR_YYYY
          AND SF.SOB_ID           = P_SOB_ID
          AND SF.ORG_ID           = P_ORG_ID
          AND SF.PERSON_ID        = C1.PERSON_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_RECORD_COUNT := 0;
      END;
      IF V_RECORD_COUNT = 0 THEN
        INSERT INTO HRA_SUPPORT_FAMILY
        ( YEAR_YYYY
        , SOB_ID
        , ORG_ID  
        , PERSON_ID
        , REPRE_NUM
        , RELATION_CODE
        , FAMILY_NAME
        , BASE_YN
        , INCOME_DED_YN
        , SPOUSE_YN
        , OLD_YN
        , OLD1_YN
        , DISABILITY_YN
        , WOMAN_YN
        , CHILD_YN
        , BIRTH_YN -- 출생/입양;
        , CREATION_DATE
        , CREATED_BY
        , LAST_UPDATE_DATE
        , LAST_UPDATED_BY
        ) VALUES
        ( P_YEAR_YYYY
        , P_SOB_ID
        , P_ORG_ID
        , C1.PERSON_ID
        , C1.REPRE_NUM
        , '0'  -- 본인;
        , C1.NAME
        , 'Y'
        , 'Y'
        , 'N'
        , CASE
            WHEN EAPP_REGISTER_AGE_F(C1.REPRE_NUM, P_STD_DATE, 0) BETWEEN V_OLD_DED_AGE AND V_OLD_DED_AGE1 - 1 THEN 'Y'
            ELSE 'N'
          END                 --OLD_YN;
        , CASE
            WHEN EAPP_REGISTER_AGE_F(C1.REPRE_NUM, P_STD_DATE, 0) >= V_OLD_DED_AGE1 THEN 'Y'
            ELSE 'N'
          END                 --OLD1_YN;
        , NVL(C1.DISABILITY_YN, 'N')    --DEFORM_YN
        , 'N'
        , 'N'
        , 'N'
        , V_SYSDATE
        , P_USER_ID
        , V_SYSDATE
        , P_USER_ID
        );
      END IF;
    END LOOP C1;

---> 연말정산 대상 산출;
    FOR C1 IN (SELECT HA.PERSON_ID
                   , PM.PERSON_NUM
                   , PM.NAME
                   , PM.CORP_ID
                   , PM.SOB_ID
                   , PM.ORG_ID
                   , PM.DEPT_ID
                   , PM.ORI_JOIN_DATE
                   , PM.JOIN_DATE
                   , PM.RETIRE_DATE
                   , PM.EMPLOYE_TYPE
                   , HA.PAY_TYPE
                   , HA.ADJUST_DATE_FR
                   , HA.ADJUST_DATE_TO 
                   , NVL(HIT1.FOREIGN_INCOME_RATE, 0) FOREIGN_INCOME_RATE -- 외국인근로자단일세율;
                   , NVL(HIT1.DRIVE_DED_LMT, 0) DRIVE_DED_LMT -- 자가운전보조금;
                   , NVL(HIT1.PRE_YEAR_INCOME_TOT_AMT_LMT, 0) AS PRE_YEAR_INCOME_TOT_AMT_LMT  -- 야간근로수당 직전과세기간 총급여한도.
                   , NVL(HIT1.MONTH_PAY_STD, 0) MONTH_PAY_STD -- 야간근로수당 적용 급여 기준;
                   , NVL(HIT1.OT_DED_LMT, 0) OT_DED_LMT -- 야간근로수당 한도;
                   , NVL(HIT1.SP_DED_STD, 0) SP_DED_STD -- 표준공제 기준액;
                   , NVL(HIT1.SP_DED_AMT, 0) SP_DED_AMT -- 표준공제금액;
                   , NVL(HIT1.LOCAL_TAX_RATE, 1) LOCAL_TAX_RATE -- 소득세 비율;
                   , NVL(HIT1.FOREIGN_INCOME_DED_AMT, 0) AS FOREIGN_INCOME_DED_AMT  -- 국외소득근로.
                   , NVL(HIT1.FOREIGN_INCOME_DED_AMT2, 0) AS FOREIGN_INCOME_DED_AMT2  -- 국외소득근로(선원등)   
                   , NVL(HIT1.BABY_DED_LMT, 0) AS BABY_DED_LMT  -- 육아보육수당.
                   , NVL(PM.FOREIGN_TAX_YN, 'N') AS FOREIGN_TAX_YN  -- 외국인 단일세율적용.
                 FROM HRM_PERSON_MASTER  PM
                   , (-- 시점 인사내역.
                      SELECT HL.PERSON_ID
                           , HL.DEPT_ID
                           , HL.POST_ID
                           , HL.PAY_GRADE_ID
                           , HL.FLOOR_ID
                           , HL.JOB_CATEGORY_ID
                           , HL.JOB_CLASS_ID
                           , HL.OCPT_ID
                           , HL.ABIL_ID
                        FROM HRM_HISTORY_HEADER HH
                           , HRM_HISTORY_LINE   HL 
                      WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
                        AND HH.CHARGE_SEQ           IN 
                              (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                  FROM HRM_HISTORY_HEADER S_HH
                                     , HRM_HISTORY_LINE   S_HL
                                 WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                   AND S_HH.CHARGE_DATE       <= LAST_DAY(P_STD_DATE) 
                                   AND S_HL.PERSON_ID         = HL.PERSON_ID
                                 GROUP BY S_HL.PERSON_ID
                               )                              
                    ) T1                            
                   , HRA_YEAR_ADJUSTMENT HA
                   , ( -- 연말정산기준;
                      SELECT HIT.YEAR_YYYY
                          , HIT.FOREIGN_INCOME_RATE
                          , HIT.DRIVE_DED_LMT
                          , HIT.MONTH_PAY_STD
                          , HIT.PRE_YEAR_INCOME_TOT_AMT_LMT
                          , HIT.OT_DED_LMT
                          , HIT.SP_DED_STD
                          , HIT.SP_DED_AMT
                          , HIT.LOCAL_TAX_RATE
                          , HIT.FOREIGN_INCOME_DED_AMT
                          , HIT.BABY_DED_LMT
                          , HIT.FOREIGN_INCOME_DED_AMT2 
                        FROM HRA_INCOME_TAX_STANDARD HIT
                      WHERE HIT.YEAR_YYYY       = P_YEAR_YYYY
                        AND HIT.SOB_ID          = P_SOB_ID
                        AND HIT.ORG_ID          = P_ORG_ID
                     ) HIT1
                WHERE PM.PERSON_ID      = T1.PERSON_ID
                  AND PM.PERSON_ID      = HA.PERSON_ID
                  AND P_YEAR_YYYY       = HIT1.YEAR_YYYY                  
                  AND HA.YEAR_YYYY      = P_YEAR_YYYY
                  AND ((P_PERSON_ID     IS NULL AND 1 = 1)
                    OR (P_PERSON_ID     IS NOT NULL AND HA.PERSON_ID = P_PERSON_ID))                                    
                  AND HA.SOB_ID         = P_SOB_ID
                  AND HA.ORG_ID         = P_ORG_ID
                  AND HA.CLOSED_FLAG   != 'Y'  -- 미마감 자료 -- 
                  AND PM.CORP_ID        = P_CORP_ID                  
                  AND PM.SOB_ID         = P_SOB_ID
                  AND PM.ORG_ID         = P_ORG_ID
                  AND ((P_PERSON_ID     IS NULL AND 1 = 1)
                    OR (P_PERSON_ID     IS NOT NULL AND PM.PERSON_ID = P_PERSON_ID))                                    
                  AND PM.JOIN_DATE     <= P_STD_DATE
                  AND ((P_EMPLOYE_TYPE  IS NULL AND (PM.RETIRE_DATE >= V_START_DATE OR PM.RETIRE_DATE IS NULL))
                    OR (P_EMPLOYE_TYPE != '3' AND (PM.RETIRE_DATE >= V_START_DATE OR PM.RETIRE_DATE IS NULL))
                    OR (P_EMPLOYE_TYPE  = '3' AND (PM.RETIRE_DATE BETWEEN V_START_DATE AND LAST_DAY(P_STD_DATE))))
                  AND ((P_DEPT_ID       IS NULL AND 1 = 1)
                  OR   (P_DEPT_ID       IS NOT NULL AND T1.DEPT_ID = P_DEPT_ID))
                  AND ((P_FLOOR_ID      IS NULL AND 1 = 1)
                  OR   (P_FLOOR_ID      IS NOT NULL AND T1.FLOOR_ID = P_FLOOR_ID))
               ) 
    LOOP
----- 변수 초기화  -----------------------------------------------------------------------------------------------------                       
      V_PAY_SUM                     := 0;  -- 현 급여합계 ; 
      V_BONUS_SUM                   := 0;  -- 현 상여합계 ;  
      V_ADD_BONUS                   := 0;  -- 현 인정상여 합계  ; 
      
      V_STOCK_BENE_AMT              := 0;  -- 주식매수수선택권행사이익;  
      V_EMPLOYEE_STOCK_AMT          := 0;  -- 2013년 추가 : 우리사주조합인출금  
      V_OFFICERS_RETIRE_OVER_AMT    := 0;  -- 2013년 추가 : 임원퇴직소득금액 한도초과액  
      
      --- 국외소득       
      V_INCOME_OUTSIDE_AMT          := 0;  -- 국외 과세 소득  ;
      V_NONTAX_OUTSIDE_AMT          := 0;  -- 국외 비과세 소득  ;
      V_TAX_OUTSIDE_AMT             := 0;  -- 국외 기납부세액  ;                                      
      
      -- 전년도 야간 비과세 대상 여부 --
      V_PRE_YEAR_OT_DED_FLAG        := 'N';
      
      --- 비과세  
      V_NONTAX_ETC_AMT              := 0;  -- 기타비과세  ;
      V_NONTAX_OT_AMT               := 0;  -- 야간근로비과세;  
      V_NONTAX_BABY_AMT             := 0;  -- 보육수당.
      V_NONTAX_OUTS_WORK_1          := 0;  -- 비과세 국외근로수당;
      V_NONTAX_OUTS_WORK_2          := 0;  -- 비과세 국외근로수당(300만원);
      
      --- 공제 내역         
      V_ANNU_INSUR_AMT              := 0;  -- 국민연금;
      V_MEDIC_INSUR_AMT             := 0;  -- 건강보험 합계;  
      V_HIRE_INSUR_AMT              := 0;  -- 고용보험 합계;  
      
      V_PUBLIC_INSUR_AMT            := 0;  -- 2013년 추가 : 공무원연금보험 

      V_MARINE_INSUR_AMT            := 0;  -- 2013년 추가 : 군인연금보험  
      V_SCHOOL_STAFF_INSUR_AMT      := 0;  -- 2013년 추가 : 사립학교 교직원연금보험
      V_POST_OFFICE_INSUR_AMT       := 0;  -- 2013년 추가 : 별정우체국연금보험 
    
      V_IN_TAX_AMT                  := 0;  -- 소득세 합계;  
      V_LOCAL_TAX_AMT               := 0;  -- 주민세 합계;  
      
      --- 종전 내역 합계  
      V_PRE_PAY_SUM                 := 0;  -- 종전 급여합계;  
      V_PRE_BONUS_SUM               := 0;  -- 종전 상여합계;  
      V_PRE_ADD_BONUS               := 0;  -- 종전 인정상여 합계;  
      V_PRE_STOCK_BENE_AMT          := 0;  -- 종전 주식매수선택권행사이익;  
      V_PRE_EMPLOYEE_STOCK_AMT      := 0;  -- 2013년 추가 : 종전 우리사주조합인출금  
      V_PRE_OFFICE_RETIRE_OVER_AMT  := 0;  -- 2013년 추가 : 종전 임원퇴직소득금액 한도초과액  
    
      V_PRE_ANNU_INSUR_AMT          := 0;  -- 종전 국민연금;
      V_PRE_PUBLIC_INSUR_AMT        := 0;  -- 2013년 추가 : 종전 공무원연금보험 
      V_PRE_MARINE_INSUR_AMT        := 0;  -- 2013년 추가 : 종전 군인연금보험  
      V_PRE_SCHOOL_STAFF_INSUR_AMT  := 0;  -- 2013년 추가 : 종전 사립학교 교직원연금보험
      V_PRE_POST_OFFICE_INSUR_AMT   := 0;  -- 2013년 추가 : 종전 별정우체국연금보험 
       
      V_PRE_MEDIC_INSUR_AMT         := 0;  -- 종전 건강보험 합계 ; 
      V_PRE_HIRE_INSUR_AMT          := 0;  -- 종전 고용보험 합계 ;
      
      V_PRE_IN_TAX_AMT              := 0;  -- 종전 소득세 합계;  
      V_PRE_LOCAL_TAX_AMT           := 0;  -- 종전 주민세 합계;  
      
---------------------------------------------------------------------------------------------------  
      V_TOTAL_PAY                   := 0;  -- 총 급여(현 급여합계 + 종전 급여합계);
    
      V_INCOME_DED_AMT              := 0;  -- 근로소득공제 금액  ;
      V_INCOME_PAY                  := 0;  -- 총지급액 - 근로소득공제 금액;  
      V_REAL_TAX                    := 0;  -- 실세금액 ;
    
      V_SUPP_FAMILY_DED_AMT         := 0;  -- 인적공제 합계 ;     
      
      V_ANNU_BANK_AMT               := 0;  -- 연금저축  ;
      V_RETR_ANNU_AMT               := 0;  -- 퇴직연금저축 ;
      
      V_INSURE_DED_AMT              := 0;  -- 보험료 합계 ;  
      V_MEDIC_DED_AMT               := 0;  -- 의료비 합계 ;
      V_EDU_DED_AMT                 := 0;  -- 교육비 합계 ;
      V_HOUSE_DED_AMT               := 0;  -- 주택자금 합계;
      V_DONAT_DED_AMT               := 0;  -- 기부금 합계 ;
      V_MARRY_ETC_DED_AMT           := 0;  -- 혼인장례이사 합계 ;
    
      V_SP_STD_DED_AMT              := 0;  -- 표준공제 ;
      V_SP_DED_SUM                  := 0;  -- 특별공제 합계 ;
      V_SUBT_DED_AMT                := 0;  -- 차감소득공제;  
    
      V_PER_ANNU_BANK_AMT           := 0;  -- 개인연금저축 ;      
      V_HOUSE_SAVE_AMT              := 0;  -- 주택마련저축공제;
      V_CARD_AMT                    := 0;  -- 신용카드, 현금영수증 공제 ;
      
      V_SMALL_CORPOR_DED_AMT        := 0;  -- 2008 - 소기업/소상인 공제부금액;
      V_INVEST_AMT                  := 0;  -- 2008 - 투자조합 출자;       
      V_EMPL_STOCK_AMT              := 0;  -- 2008 - 우리사주출연금 ;           
        
      --> 2011.01.17 BY 
      V_HOUSE_APP_DEPOSIT_AMT       := 0;  -- 주택청약종합저축 불입액 소득공제;      
      V_LONG_STOCK_SAVING_AMT       := 0;  -- 장기주식저축;;          
      V_HIRE_KEEP_EMPLOY_AMT        := 0;  -- 2008 - 고용유지중소기업근로자소득공제 ;
      V_FIX_LEASE_DED_AMT           := 0;  -- 목돈안드는 전세이자상환액 공제; 
      V_ETC_DED_SUM                 := 0;  -- 기타소득공제 계  ;
      
      V_SP_DED_TOT_AMT              := 0;  -- 2013.12.31 전호수 추가 : 특별공제 종합한도 초과액; 
      V_TAX_STD_AMT                 := 0;  -- 과세표준 ; 
      V_COMP_TAX_AMT                := 0;  -- 산출세액 ; 
      
      V_TAX_REDU_IN_LAW_AMT         := 0;  -- 세액감면-소득세법.
      V_TAX_REDU_SP_LAW_AMT         := 0;  -- 세액감면-조세특례제한법.
      V_TAX_REDU_TAX_TREATY         := 0;  -- 세액감면-조세조약.
      
      F_IN_TAX_AMT                  := 0;  -- 결정소득세 합계 ; 
      F_SP_TAX_AMT                  := 0;  -- 결정농특세 합계.;
      F_LOCAL_TAX_AMT               := 0;  -- 결정주민세 합계  ;
      S_IN_TAX_AMT                  := 0;  -- 차감소득세 합계 ; 
      S_SP_TAX_AMT                  := 0;  -- 차감농특세 합계.;
      S_LOCAL_TAX_AMT               := 0;  -- 차감주민세 합계; 
    
----- <주현> ------------------------------------------------------------------------------             
      -- 총급여, 총상여, 기타비과세, 야간근로수당 산출 -- 
      FOR C1S IN (SELECT A.PERSON_ID
                      , A.PAY_YYYYMM
                      , SUM(A.TOT_PAY_AMOUNT) AS TOT_PAY_AMOUNT
                      , SUM(A.PAY_AMT) AS PAY_AMT
                      , SUM(A.BONUS_AMT) AS BONUS_AMT
                      , SUM(A.NONTAX_CAR_AMT) AS NONTAX_CAR_AMT
                      , SUM(A.NONTAX_OUTSIDE_AMT) AS NONTAX_OUTSIDE_AMT
                      , 0 AS NONTAX_OUTSIDE_AMT2
                      , SUM(A.NONTAX_BABY_AMT) AS NONTAX_BABY_AMT
                      , SUM(A.NONTAX_OT_AMT) AS NONTAX_OT_AMT
                      , SUM(A.AVG_PAY_AMT) AS AVG_PAY_AMT
                    FROM ( 
                          SELECT MP.PERSON_ID
                              , MP.PAY_YYYYMM
                              , SUM(MA.ALLOWANCE_AMOUNT) AS TOT_PAY_AMOUNT
                              , SUM(CASE
                                      WHEN HA.ALLOWANCE_CODE IN ('A09', 'A16') THEN 0
                                      ELSE MA.ALLOWANCE_AMOUNT
                                    END) PAY_AMT
                              , SUM(CASE
                                      WHEN HA.ALLOWANCE_CODE IN ('A09', 'A16') THEN MA.ALLOWANCE_AMOUNT
                                      ELSE 0
                                    END) BONUS_AMT
                              , SUM(CASE
                                      WHEN HA.TAX_FREE IN ('CAR') THEN MA.ALLOWANCE_AMOUNT
                                      ELSE 0
                                    END) NONTAX_CAR_AMT
                              , SUM(CASE
                                      WHEN HA.TAX_FREE IN ('OUTSIDE') THEN MA.ALLOWANCE_AMOUNT
                                      ELSE 0
                                    END) NONTAX_OUTSIDE_AMT
                              , SUM(CASE
                                      WHEN HA.TAX_FREE IN ('BABY') THEN MA.ALLOWANCE_AMOUNT
                                      ELSE 0
                                    END) NONTAX_BABY_AMT
                              , SUM(CASE
                                      WHEN HA.TAX_FREE IN ('OT') THEN MA.ALLOWANCE_AMOUNT
                                      ELSE 0
                                    END) NONTAX_OT_AMT
                              , SUM(CASE
                                      WHEN HA.GENERAL_PAY_YN = 'Y' THEN MA.ALLOWANCE_AMOUNT
                                      ELSE 0
                                    END) AVG_PAY_AMT
                             FROM HRP_MONTH_PAYMENT   MP
                                , HRP_MONTH_ALLOWANCE MA
                                , HRM_ALLOWANCE_V     HA
                         WHERE MP.PAY_YYYYMM      = MA.PAY_YYYYMM
                           AND MP.WAGE_TYPE       = MA.WAGE_TYPE
                           AND MP.PERSON_ID       = MA.PERSON_ID
                           AND MP.SOB_ID          = MA.SOB_ID
                           AND MP.ORG_ID          = MA.ORG_ID
                           AND MA.ALLOWANCE_ID    = HA.ALLOWANCE_ID
                           AND MP.PAY_YYYYMM      BETWEEN V_STR_MONTH AND V_END_MONTH
                           AND MP.WAGE_TYPE       IN ('P1', 'P2', 'P3', 'P4', 'P5')
                           AND MP.PERSON_ID       = C1.PERSON_ID
                           AND MP.SOB_ID          = C1.SOB_ID
                           AND MP.ORG_ID          = C1.ORG_ID
                           AND HA.ALLOWANCE_CODE  LIKE 'A%'
                         GROUP BY MP.PERSON_ID, MP.PAY_YYYYMM
                        ) A
                   GROUP BY A.PERSON_ID, A.PAY_YYYYMM
                   ) 
      LOOP      
        --> 현 근무지 급여 합계 
        V_PAY_SUM   := V_PAY_SUM + NVL(C1S.PAY_AMT, 0);      -- 급여  
        V_BONUS_SUM := V_BONUS_SUM + NVL(C1S.BONUS_AMT, 0);  -- 상여   
       
        -- 월단위 한도 검증 --
        --> 차량유지비;
        V_TEMP_AMT := 0;
        IF NVL(C1.DRIVE_DED_LMT, 0) < NVL(C1S.NONTAX_CAR_AMT, 0) THEN 
          V_TEMP_AMT := NVL(C1.DRIVE_DED_LMT, 0);
        ELSE
          V_TEMP_AMT := NVL(C1S.NONTAX_CAR_AMT, 0);
        END IF;
        V_NONTAX_ETC_AMT := NVL(V_NONTAX_ETC_AMT, 0) + NVL(V_TEMP_AMT, 0);
        
        --> 국외근로소득(100만원 한도);
        V_TEMP_AMT := 0;        
        IF NVL(C1.FOREIGN_INCOME_DED_AMT, 0) < NVL(C1S.NONTAX_OUTSIDE_AMT, 0) THEN 
          V_TEMP_AMT := NVL(C1.FOREIGN_INCOME_DED_AMT, 0);
        ELSE
          V_TEMP_AMT := NVL(C1S.NONTAX_OUTSIDE_AMT, 0);
        END IF;
        V_NONTAX_OUTS_WORK_1 := NVL(V_NONTAX_OUTS_WORK_1, 0) + NVL(V_TEMP_AMT, 0);
        --V_INCOME_OUTSIDE_AMT := NVL(V_INCOME_OUTSIDE_AMT, 0) + NVL(C1S.NONTAX_OUTSIDE_AMT, 0);  -- 급여에서 지급받은 국외근로수당.
        
        --> 국외근로소득(300만원 한도);
        V_TEMP_AMT := 0;        
        IF NVL(C1.FOREIGN_INCOME_DED_AMT2, 0) < NVL(C1S.NONTAX_OUTSIDE_AMT2, 0) THEN 
          V_TEMP_AMT := NVL(C1.FOREIGN_INCOME_DED_AMT2, 0);
        ELSE
          V_TEMP_AMT := NVL(C1S.NONTAX_OUTSIDE_AMT2, 0);
        END IF;
        V_NONTAX_OUTS_WORK_2 := NVL(V_NONTAX_OUTS_WORK_2, 0) + NVL(V_TEMP_AMT, 0);
                
        --> 육아보육수당;
        V_TEMP_AMT := 0;
        IF NVL(C1.BABY_DED_LMT, 0) < NVL(C1S.NONTAX_BABY_AMT, 0) THEN 
          V_TEMP_AMT := NVL(C1.BABY_DED_LMT, 0);
        ELSE
          V_TEMP_AMT := NVL(C1S.NONTAX_BABY_AMT, 0);
        END IF;
        V_NONTAX_BABY_AMT := NVL(V_NONTAX_BABY_AMT, 0) + NVL(V_TEMP_AMT, 0);
        
        --> 생산직 야간근로수당 비과세 체크 (100만원 이하).  
        IF C1.PAY_TYPE IN ('2', '4') AND NVL(C1S.TOT_PAY_AMOUNT, 0) <= NVL(C1.MONTH_PAY_STD, 0) THEN
          V_NONTAX_OT_AMT := NVL(V_NONTAX_OT_AMT, 0) + NVL(C1S.NONTAX_OT_AMT, 0);
        END IF;
      END LOOP C1S;
      
      -- (주현) 기납부 세액, 국민연금, 건강보험, 고용보험 집계 --                       
      BEGIN
        SELECT SUM(CASE  -- 소득세.
                     WHEN HD.DEDUCTION_CODE = 'D01' THEN MD.DEDUCTION_AMOUNT
                     ELSE 0
                   END) AS IN_TAX_AMT
            , SUM(CASE  -- 주민세.
                   WHEN HD.DEDUCTION_CODE = 'D02' THEN MD.DEDUCTION_AMOUNT
                   ELSE 0
                 END) AS LOCAL_TAX_AMT
            , SUM(CASE  -- 국민.
                   WHEN HD.DEDUCTION_CODE IN('D03', 'D08') THEN MD.DEDUCTION_AMOUNT
                   ELSE 0
                 END) AS ANNU_INSUR_AMT
            , SUM(CASE  -- 고용.
                   WHEN HD.DEDUCTION_CODE = 'D04' THEN MD.DEDUCTION_AMOUNT
                   ELSE 0
                 END) AS HIRE_INSUR_AMT
            , SUM(CASE  -- 건강+장기요양.
                   WHEN HD.DEDUCTION_CODE IN('D05', 'D06', 'D07') THEN MD.DEDUCTION_AMOUNT
                   ELSE 0
                 END) AS MEDIC_INSUR_AMT
          INTO V_IN_TAX_AMT
             , V_LOCAL_TAX_AMT
             , V_ANNU_INSUR_AMT
             , V_HIRE_INSUR_AMT
             , V_MEDIC_INSUR_AMT
          FROM HRP_MONTH_PAYMENT  MP
            , HRP_MONTH_DEDUCTION MD
            , HRM_DEDUCTION_V     HD
         WHERE MP.PAY_YYYYMM      = MD.PAY_YYYYMM
           AND MP.WAGE_TYPE       = MD.WAGE_TYPE
           AND MP.PERSON_ID       = MD.PERSON_ID
           AND MP.SOB_ID          = MD.SOB_ID
           AND MP.ORG_ID          = MD.ORG_ID
           AND MD.DEDUCTION_ID    = HD.DEDUCTION_ID
           AND MP.PAY_YYYYMM      BETWEEN V_STR_MONTH AND V_END_MONTH
           AND MP.WAGE_TYPE       IN ('P1', 'P2', 'P3', 'P4', 'P5')
           AND MP.PERSON_ID       = C1.PERSON_ID
           AND MP.SOB_ID          = C1.SOB_ID
           AND MP.ORG_ID          = C1.ORG_ID
         GROUP BY MP.PERSON_ID
         ;
      EXCEPTION
        WHEN OTHERS THEN
          --DBMS_OUTPUT.PUT_LINE('기납부 세액등 생성 오류 :' || SUBSTR(SQLERRM, 1, 150));
          V_IN_TAX_AMT      := 0;
          V_LOCAL_TAX_AMT   := 0;
          V_ANNU_INSUR_AMT  := 0;
          V_HIRE_INSUR_AMT  := 0;
          V_MEDIC_INSUR_AMT := 0;
      END;
      
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        -- 외국인단일세율 : 보험료 적용 안함.
        V_ANNU_INSUR_AMT  := 0;
        V_HIRE_INSUR_AMT  := 0;
        V_MEDIC_INSUR_AMT := 0;
      END IF;
      IF NVL(V_ANNU_INSUR_AMT, 0) < 0 THEN
        V_ANNU_INSUR_AMT := 0;  
      END IF;
      IF NVL(V_HIRE_INSUR_AMT, 0) < 0 THEN
        V_HIRE_INSUR_AMT := 0;  
      END IF;
      IF NVL(V_MEDIC_INSUR_AMT, 0) < 0 THEN
        V_MEDIC_INSUR_AMT := 0;  
      END IF;
--DBMS_OUTPUT.PUT_LINE('급여산출내역=> 총급여->' || V_TOTAL_PAY || '/총상여->' || V_TOTAL_BONUS || '/기타비과세=>' || V_NONTAX_ETC_AMT || '/야간비과세=>' || V_NONTAX_OT_AMT);        
      
      -- 연말정산 기초 : 인정상여, 학자금, 기타지급, 국외 소득 자료 --
      BEGIN
        SELECT NVL(HF.ADD_BONUS_AMT, 0) + NVL(HF.ADD_EDUCATION_AMT, 0) +
               NVL(HF.ADD_ETC_AMT, 0) AS ADD_BONUS
             , NVL(HF.INCOME_OUTSIDE_AMT, 0) AS INCOME_OUTSIDE_AMT
             , NVL(HF.NONTAX_OUTSIDE_AMT, 0) AS NONTAX_OUTSIDE_AMT
             , NVL(HF.TAX_OUTSIDE_AMT, 0) TAX_OUTSIDE_AMT
               -- 기납부 세액 : 전호수 추가.
             , (NVL(V_IN_TAX_AMT, 0) + NVL(HF.IN_TAX_AMT, 0)) AS IN_TAX_AMT
             , (NVL(V_LOCAL_TAX_AMT, 0) + NVL(HF.LOCAL_TAX_AMT, 0)) AS LOCAL_TAX_AMT
               -- 전년도 야간비과세 대상 --
             , NVL(HF.PRE_YEAR_OT_DED_FLAG, 'N') AS PRE_YEAR_OT_DED_FLAG
             -- 2013년도 추가 : 주식매수선택권 행사이익, 우리사주조합인출금, 임원퇴직소득금액 한도초과액 -- 
             , NVL(HF.STOCK_BENE_AMT, 0) AS STOCK_BENE_AMT   
             , NVL(HF.EMPLOYEE_STOCK_AMT, 0) AS EMPLOYEE_STOCK_AMT  
             , NVL(HF.OFFICERS_RETIRE_OVER_AMT, 0) AS OFFICERS_RETIRE_OVER_AMT  
          INTO V_ADD_BONUS
             , V_INCOME_OUTSIDE_AMT
             , V_NONTAX_OUTSIDE_AMT
             , V_TAX_OUTSIDE_AMT
             , V_IN_TAX_AMT
             , V_LOCAL_TAX_AMT
             , V_PRE_YEAR_OT_DED_FLAG
             , V_STOCK_BENE_AMT
             , V_EMPLOYEE_STOCK_AMT
             , V_OFFICERS_RETIRE_OVER_AMT
          FROM HRA_FOUNDATION HF
        WHERE HF.YEAR_YYYY       = P_YEAR_YYYY
          AND HF.PERSON_ID       = C1.PERSON_ID
          AND HF.SOB_ID          = C1.SOB_ID
          AND HF.ORG_ID          = C1.ORG_ID
        ;
      EXCEPTION
        WHEN OTHERS THEN
          --DBMS_OUTPUT.PUT_LINE('인정상여등 기타자료 생성 오류 :' || SUBSTR(SQLERRM, 1, 150));
          V_ADD_BONUS          := 0;
          V_INCOME_OUTSIDE_AMT := 0;
          V_NONTAX_OUTSIDE_AMT := 0;
          V_TAX_OUTSIDE_AMT    := 0;
          V_PRE_YEAR_OT_DED_FLAG := 'N';
          V_STOCK_BENE_AMT := 0;
          V_EMPLOYEE_STOCK_AMT := 0;
          V_OFFICERS_RETIRE_OVER_AMT := 0;
      END;
    
--DBMS_OUTPUT.PUT_LINE('기납부내역=> 소득세=>' || V_IN_TAX_AMT || '/주민세=>' || V_LOCAL_TAX_AMT || '/국민연금=>' || V_ANNU_INSUR_AMT || '/고용보험=>' || V_HIRE_INSUR_AMT || '/건강보험=>' || V_MEDIC_INSUR_AMT);        
-- <종전>근무지 자료 조회  -----------------------------------------------------------------------------------------------------------                       
      BEGIN
        SELECT SUM(HPW.PAY_TOTAL_AMT) AS PAY_TOTAL_AMT
            , SUM(HPW.BONUS_TOTAL_AMT) AS BONUS_TOTAL_AMT
            , SUM(HPW.ADD_BONUS_AMT) AS ADD_BONUS_AMT
            , SUM(HPW.STOCK_BENE_AMT) AS STOCK_NENE_AMT
            , SUM(HPW.MEDIC_INSUR_AMT) AS MEDIC_INSUR_AMT
            , SUM(HPW.HIRE_INSUR_AMT) AS HIRE_INSUR_AMT
            , SUM(HPW.ANNU_INSUR_AMT) AS ANNU_INSUR_AMT
            , SUM(HPW.IN_TAX_AMT) AS IN_TAX_AMT
            , SUM(HPW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
          INTO V_PRE_PAY_SUM
             , V_PRE_BONUS_SUM
             , V_PRE_ADD_BONUS
             , V_PRE_STOCK_BENE_AMT
             , V_PRE_MEDIC_INSUR_AMT
             , V_PRE_HIRE_INSUR_AMT
             , V_PRE_ANNU_INSUR_AMT
             , V_PRE_IN_TAX_AMT
             , V_PRE_LOCAL_TAX_AMT
          FROM HRA_PREVIOUS_WORK HPW
        WHERE HPW.YEAR_YYYY   = P_YEAR_YYYY
          AND HPW.PERSON_ID   = C1.PERSON_ID
          AND HPW.SOB_ID      = C1.SOB_ID
          AND HPW.ORG_ID      = C1.ORG_ID         
        GROUP BY HPW.PERSON_ID
        ;
      EXCEPTION
        WHEN OTHERS THEN
          V_PRE_PAY_SUM         := 0;
          V_PRE_BONUS_SUM       := 0;
          V_PRE_ADD_BONUS       := 0;
          V_PRE_STOCK_BENE_AMT  := 0;
          V_PRE_MEDIC_INSUR_AMT := 0;
          V_PRE_HIRE_INSUR_AMT  := 0;
          V_PRE_ANNU_INSUR_AMT  := 0;
          V_PRE_IN_TAX_AMT      := 0;
          V_PRE_LOCAL_TAX_AMT   := 0;
          V_PRE_EMPLOYEE_STOCK_AMT     := 0;
          V_PRE_OFFICE_RETIRE_OVER_AMT := 0;
      END;
      
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        -- 외국인단일세율 : 보험료 적용 안함.
        V_PRE_MEDIC_INSUR_AMT := 0;
        V_PRE_HIRE_INSUR_AMT  := 0;
        V_PRE_ANNU_INSUR_AMT  := 0;
      END IF;
      IF NVL(V_PRE_ANNU_INSUR_AMT, 0) < 0 THEN
        V_PRE_ANNU_INSUR_AMT := 0;  
      END IF;
      IF NVL(V_PRE_HIRE_INSUR_AMT, 0) < 0 THEN
        V_PRE_HIRE_INSUR_AMT := 0;  
      END IF;
      IF NVL(V_PRE_MEDIC_INSUR_AMT, 0) < 0 THEN
        V_PRE_MEDIC_INSUR_AMT := 0;  
      END IF;
      
      --> 비과세 한도 체크 <--
      --> 생산직 야간근로수당 한도 적용.
      IF NVL(C1.OT_DED_LMT, 0) < NVL(V_NONTAX_OT_AMT, 0) THEN 
        V_NONTAX_OT_AMT := NVL(C1.OT_DED_LMT, 0);
      END IF;
      
      --> 야간근로수당 직전과세기간 총급여한도 체크 --
      V_TEMP_AMT := 0;
      BEGIN
        SELECT YA.INCOME_TOT_AMT
          INTO V_TEMP_AMT
          FROM HRA_YEAR_ADJUSTMENT YA
         WHERE YA.YEAR_YYYY       = V_PRE_YEAR
           AND YA.PERSON_ID       = C1.PERSON_ID
           AND YA.SOB_ID          = C1.SOB_ID
           AND YA.ORG_ID          = C1.ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_TEMP_AMT := -1;
      END;
      IF NVL(V_PRE_YEAR_OT_DED_FLAG, 'N') = 'Y' THEN
        -- 직전년도 총급여 한도 미만 : 신규입자 --
        NULL;
      ELSIF NVL(V_TEMP_AMT, 0) >= 0 AND NVL(V_TEMP_AMT, 0) <= NVL(C1.PRE_YEAR_INCOME_TOT_AMT_LMT, 0) THEN
        -- 직전년도 총급여 한도 미만 --
        NULL;
      ELSE
        -- 직전년도 총급여 한도 초과시 야간근로수당 적용 안함 --
        V_NONTAX_OT_AMT := 0;
      END IF;
      
      --> 수기입력 : 국외근로수당 비과세 적용(100만원) --
      IF NVL(V_NONTAX_OUTSIDE_AMT, 0) > 0 THEN
        -- 1년 금액으로 환산하여 금액 검증 --
        IF (NVL(C1.FOREIGN_INCOME_DED_AMT, 0) * 12) < (NVL(V_NONTAX_OUTSIDE_AMT, 0) + NVL(V_NONTAX_OUTS_WORK_1, 0)) THEN
          V_NONTAX_OUTSIDE_AMT := (NVL(V_NONTAX_OUTSIDE_AMT, 0) + NVL(V_NONTAX_OUTS_WORK_1, 0)) - NVL(C1.FOREIGN_INCOME_DED_AMT, 0);
        END IF;
      END IF;
      
      /*--> 수기입력 : 국외근로수당 비과세 적용(300만원) --
      IF NVL(V_NONTAX_OUTSIDE_AMT2, 0) > 0 THEN
        -- 1년 금액으로 환산하여 금액 검증 --
        IF (NVL(C1.FOREIGN_INCOME_DED_AMT2, 0) * 12) < (NVL(V_NONTAX_OUTSIDE_AMT2, 0) + NVL(V_NONTAX_OUTS_WORK_2, 0)) THEN
          V_NONTAX_OUTSIDE_AMT2 := (NVL(V_NONTAX_OUTSIDE_AMT2, 0) + NVL(V_NONTAX_OUTS_WORK_2, 0)) - NVL(C1.FOREIGN_INCOME_DED_AMT2, 0);
        END IF;
      END IF;*/
      
      --> 국외근로수당 비과세 적용 합계--
      V_NONTAX_OUTS_WORK_1 := NVL(V_NONTAX_OUTS_WORK_1, 0) + NVL(V_NONTAX_OUTSIDE_AMT, 0);
      
      --> 급여내역에서 비과세 금액 제외(차량유지비, 연장수당, 육아보육수당, 국외근로수당1, 국외근로수당2, 수기입력 국외근로수당).
      V_PAY_SUM := NVL(V_PAY_SUM, 0) - NVL(V_NONTAX_ETC_AMT, 0) - NVL(V_NONTAX_OT_AMT, 0) 
                                     - NVL(V_NONTAX_BABY_AMT, 0) 
                                     - NVL(V_NONTAX_OUTS_WORK_1, 0)
                                     - NVL(V_NONTAX_OUTS_WORK_2, 0);
    
      --> 현 급여계 + 종전 급여계    
      V_TOTAL_PAY := NVL(V_PAY_SUM, 0) + NVL(V_PRE_PAY_SUM, 0);  -- 급여  
      V_TOTAL_PAY := NVL(V_TOTAL_PAY, 0) + NVL(V_BONUS_SUM, 0) + NVL(V_PRE_BONUS_SUM, 0);  -- 상여  
      V_TOTAL_PAY := NVL(V_TOTAL_PAY, 0) + NVL(V_ADD_BONUS, 0) + NVL(V_PRE_ADD_BONUS, 0);  -- 인정 상여  
      V_TOTAL_PAY := NVL(V_TOTAL_PAY, 0) + NVL(V_INCOME_OUTSIDE_AMT, 0);  -- 국외근로  
      V_TOTAL_PAY := NVL(V_TOTAL_PAY, 0) + NVL(V_STOCK_BENE_AMT, 0) + NVL(V_PRE_STOCK_BENE_AMT, 0);  -- 
      V_TOTAL_PAY := NVL(V_TOTAL_PAY, 0) + NVL(V_EMPLOYEE_STOCK_AMT, 0) + NVL(V_PRE_EMPLOYEE_STOCK_AMT, 0);
      V_TOTAL_PAY := NVL(V_TOTAL_PAY, 0) + NVL(V_OFFICERS_RETIRE_OVER_AMT, 0) + NVL(V_PRE_OFFICE_RETIRE_OVER_AMT, 0);
          
      --> 총급여 - 비과세(비과세 제회 총급여 합계)          
      --  V_TOTAL_PAY := V_TOTAL_PAY - V_NONTAX_ETC_AMT - V_NONTAX_OT_AMT - V_NONTAX_OUTSIDE_AMT ;
    
      -- 3.5 근로소득 공제 계산                          
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_INCOME_DED_AMT := 0;
      ELSE
        V_INCOME_DED_AMT := INCOME_DED_CAL
                            ( O_STATUS      => O_STATUS
                            , O_MESSAGE     => O_MESSAGE
                            , P_YEAR_YYYY   => P_YEAR_YYYY
                            , P_SOB_ID      => P_SOB_ID
                            , P_ORG_ID      => P_ORG_ID
                            , P_TOTAL_PAY   => V_TOTAL_PAY
                            );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      V_REAL_TAX := NVL(V_TOTAL_PAY, 0) - NVL(V_INCOME_DED_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
      
----- 근로소득금액 : 총급여 - 근로소득공제 계산  
      V_INCOME_PAY := NVL(V_TOTAL_PAY, 0) - NVL(V_INCOME_DED_AMT, 0);
      
      -- 실제 차감하며 세액 계산   
      V_REAL_TAX := V_INCOME_PAY;

-- UPDATE : 종전근무지 비과세 자료 --------------------------------------------------------------------------
      UPDATE HRA_YEAR_ADJUSTMENT HA
        SET ( HA.PRE_NT_OUTSIDE_AMT 
            , HA.PRE_NT_OT_AMT 
            , HA.PRE_NT_ETC_AMT 
            , HA.PRE_NT_BIRTH_AMT 
            , HA.PRE_NT_FOREIGNER_AMT 
            , HA.PRE_NT_SCH_EDU_AMT 
            , HA.PRE_NT_MEMBER_AMT 
            , HA.PRE_NT_GUARD_AMT 
            , HA.PRE_NT_CHILD_AMT 
            , HA.PRE_NT_HIGH_SCH_AMT 
            , HA.PRE_NT_SPECIAL_AMT 
            , HA.PRE_NT_RESEARCH_AMT 
            , HA.PRE_NT_COMPANY_AMT 
            , HA.PRE_NT_COVER_AMT 
            , HA.PRE_NT_WILD_AMT 
            , HA.PRE_NT_DISASTER_AMT 
            , HA.PRE_NT_OUTS_GOVER_AMT 
            , HA.PRE_NT_OUTS_ARMY_AMT 
            , HA.PRE_NT_OUTS_WORK_1 
            , HA.PRE_NT_OUTS_WORK_2 
            , HA.PRE_NT_STOCK_BENE_AMT 
            , HA.PRE_NT_FOR_ENG_AMT 
            , HA.PRE_NT_EMPL_STOCK_AMT 
            , HA.PRE_NT_EMPL_BENE_AMT_1 
            , HA.PRE_NT_EMPL_BENE_AMT_2 
            , HA.PRE_NT_HOUSE_SUBSIDY_AMT 
            , HA.PRE_NT_SEA_RESOURCE_AMT
            ) =
           (SELECT NVL(SUM(HPW.NT_OUTSIDE_AMT), 0)
                 , NVL(SUM(HPW.NT_OT_AMT), 0)
                 , NVL(SUM(HPW.NT_ETC_AMT), 0) 
                 , NVL(SUM(HPW.NT_BIRTH_AMT), 0)
                 , NVL(SUM(HPW.NT_FOREIGNER_AMT), 0) 
                 , NVL(SUM(HPW.NT_SCH_EDU_AMT), 0) 
                 , NVL(SUM(HPW.NT_MEMBER_AMT), 0) 
                 , NVL(SUM(HPW.NT_GUARD_AMT), 0) 
                 , NVL(SUM(HPW.NT_CHILD_AMT), 0) 
                 , NVL(SUM(HPW.NT_HIGH_SCH_AMT), 0) 
                 , NVL(SUM(HPW.NT_SPECIAL_AMT), 0) 
                 , NVL(SUM(HPW.NT_RESEARCH_AMT), 0) 
                 , NVL(SUM(HPW.NT_COMPANY_AMT), 0) 
                 , NVL(SUM(HPW.NT_COVER_AMT), 0) 
                 , NVL(SUM(HPW.NT_WILD_AMT), 0) 
                 , NVL(SUM(HPW.NT_DISASTER_AMT), 0) 
                 , NVL(SUM(HPW.NT_OUTSIDE_GOVER_AMT), 0) 
                 , NVL(SUM(HPW.NT_OUTSIDE_ARMY_AMT), 0) 
                 , NVL(SUM(HPW.NT_OUTSIDE_WORK1), 0) 
                 , NVL(SUM(HPW.NT_OUTSIDE_WORK2), 0) 
                 , NVL(SUM(HPW.NT_STOCK_BENE_AMT), 0) 
                 , NVL(SUM(HPW.NT_FORE_ENG_AMT), 0) 
                 , NVL(SUM(HPW.NT_EMPL_STOCK_AMT), 0) 
                 , NVL(SUM(HPW.NT_EMPL_BENE_AMT1), 0) 
                 , NVL(SUM(HPW.NT_EMPL_BENE_AMT2), 0)
                 , NVL(SUM(HPW.NT_HOUSE_SUBSIDY_AMT), 0)
                 , NVL(SUM(HPW.NT_SEA_RESOURCE_AMT), 0)
               FROM HRA_PREVIOUS_WORK HPW
              WHERE HPW.YEAR_YYYY   = HA.YEAR_YYYY
                AND HPW.PERSON_ID   = HA.PERSON_ID
                AND HPW.SOB_ID      = HA.SOB_ID
                AND HPW.ORG_ID      = HA.ORG_ID
              GROUP BY HPW.YEAR_YYYY
                     , HPW.PERSON_ID
          )
      WHERE HA.YEAR_YYYY          = P_YEAR_YYYY
        AND HA.PERSON_ID          = C1.PERSON_ID
        AND HA.SOB_ID             = C1.SOB_ID
        AND HA.ORG_ID             = C1.ORG_ID
      ;
          
-- 현근무지(급여/상여/인정상여/학자금/기납부세액등), 전근무지자료 UPDATE -----------------------------------------------------------------------                       
      UPDATE HRA_YEAR_ADJUSTMENT HA
        SET HA.NOW_PAY_TOT_AMT    = NVL(V_PAY_SUM, 0)
          , HA.NOW_BONUS_TOT_AMT  = NVL(V_BONUS_SUM, 0)
          , HA.NOW_ADD_BONUS_AMT  = NVL(V_ADD_BONUS, 0)
          , HA.NOW_STOCK_BENE_AMT = NVL(V_STOCK_BENE_AMT, 0)
          , HA.NOW_EMPLOYEE_STOCK_AMT     = NVL(V_EMPLOYEE_STOCK_AMT, 0)
          , HA.NOW_OFFICE_RETIRE_OVER_AMT = NVL(V_OFFICERS_RETIRE_OVER_AMT, 0) 
          
          -- 종전 -- 
          , HA.PRE_PAY_TOT_AMT    = NVL(V_PRE_PAY_SUM, 0)
          , HA.PRE_BONUS_TOT_AMT  = NVL(V_PRE_BONUS_SUM, 0)
          , HA.PRE_ADD_BONUS_AMT  = NVL(V_PRE_ADD_BONUS, 0)
          , HA.PRE_STOCK_BENE_AMT = NVL(V_PRE_STOCK_BENE_AMT, 0)
          , HA.PRE_EMPLOYEE_STOCK_AMT     = NVL(V_PRE_EMPLOYEE_STOCK_AMT, 0)
          , HA.PRE_OFFICE_RETIRE_OVER_AMT = NVL(V_PRE_OFFICE_RETIRE_OVER_AMT, 0) 
          
          -- 과세 국외근로 -- 
          , HA.INCOME_OUTSIDE_AMT = NVL(V_INCOME_OUTSIDE_AMT, 0)
          
          -- 비과세 --
          , HA.NONTAX_OUTSIDE_AMT = NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(V_NONTAX_OUTS_WORK_1, 0) + NVL(V_NONTAX_OUTS_WORK_2, 0)
          , HA.NONTAX_OT_AMT      = NVL(HA.NONTAX_OT_AMT, 0) + NVL(V_NONTAX_OT_AMT, 0)
          
          /* -- 전호수 주석(2013-02-13) : 2009년도부터 폐지 --
          , HA.NONTAX_RESEA_AMT   = 0*/
          , HA.NONTAX_ETC_AMT     = NVL(HA.NONTAX_ETC_AMT, 0) + NVL(V_NONTAX_ETC_AMT, 0)
          , HA.NONTAX_BIRTH_AMT   = NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(V_NONTAX_BABY_AMT, 0)
          , HA.NONTAX_OUTS_WORK_1 = NVL(HA.NONTAX_OUTS_WORK_1, 0) + NVL(V_NONTAX_OUTS_WORK_1, 0)
          , HA.NONTAX_OUTS_WORK_2 = NVL(HA.NONTAX_OUTS_WORK_2, 0) + NVL(V_NONTAX_OUTS_WORK_2, 0)
          
          --> 총근로소득합계(총소득-비과세)  
          , HA.INCOME_TOT_AMT     = NVL(V_TOTAL_PAY, 0)
          , HA.INCOME_DED_AMT     = NVL(V_INCOME_DED_AMT, 0)
          , HA.NATI_ANNU_AMT      = NVL(V_ANNU_INSUR_AMT, 0) + NVL(V_PRE_ANNU_INSUR_AMT, 0)     -- 국민연금  
          , HA.RETR_ANNU_AMT      = NVL(V_RETR_ANNU_AMT, 0)  -- 퇴직연금  
          , HA.MEDIC_INSUR_AMT    = NVL(V_MEDIC_INSUR_AMT, 0) + NVL(V_PRE_MEDIC_INSUR_AMT, 0)   -- 건강보험  
          , HA.HIRE_INSUR_AMT     = NVL(V_HIRE_INSUR_AMT, 0) + NVL(V_PRE_HIRE_INSUR_AMT, 0)     -- 고용보험  
          --> 외국납부세액 
          , HA.TAX_DED_OUTSIDE_PAY_AMT = NVL(V_TAX_OUTSIDE_AMT, 0)
          --> 기납부세액                 
          , HA.PRE_IN_TAX_AMT     = NVL(V_IN_TAX_AMT, 0) + NVL(V_PRE_IN_TAX_AMT, 0)
          , HA.PRE_LOCAL_TAX_AMT  = NVL(V_LOCAL_TAX_AMT, 0) + NVL(V_PRE_LOCAL_TAX_AMT, 0)
          , HA.PRE_SP_TAX_AMT     = 0
      WHERE HA.YEAR_YYYY          = P_YEAR_YYYY
        AND HA.PERSON_ID          = C1.PERSON_ID
        AND HA.SOB_ID             = C1.SOB_ID
        AND HA.ORG_ID             = C1.ORG_ID
      ;
-------------------------------------------------------------------------------------------------------------------------------        
      -- 4. 인적공제 계산 
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_SUPP_FAMILY_DED_AMT := 0;
      ELSE
        V_SUPP_FAMILY_DED_AMT := SUPP_FAMILY_CAL
                                  ( O_STATUS            => O_STATUS
                                  , O_MESSAGE           => O_MESSAGE
                                  , P_YEAR_YYYY         => P_YEAR_YYYY
                                  , P_STD_DATE          => P_STD_DATE
                                  , P_PERSON_ID         => C1.PERSON_ID
                                  , P_SOB_ID            => C1.SOB_ID
                                  , P_ORG_ID            => C1.ORG_ID
                                  );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - NVL(V_SUPP_FAMILY_DED_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
      
-------------------------------------------------------------------------------------------------------------------------------        
      -- 11.1 연금보험료 공제 : 국민연금 보험료 공제 적용 
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - (NVL(V_ANNU_INSUR_AMT, 0) + NVL(V_PRE_ANNU_INSUR_AMT, 0));
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF; 
                          
      -- 11.3 연금보험료 공제 : 퇴직 연금저축  공제 계산 
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_RETR_ANNU_AMT := 0;
      ELSE
        V_RETR_ANNU_AMT := RETR_ANNU_CAL
                             ( O_STATUS      => O_STATUS
                             , O_MESSAGE     => O_MESSAGE
                             , P_YEAR_YYYY   => P_YEAR_YYYY
                             , P_PERSON_ID   => C1.PERSON_ID
                             , P_SOB_ID      => C1.SOB_ID
                             , P_ORG_ID      => C1.ORG_ID
                             );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - NVL(V_RETR_ANNU_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
      IF V_RETR_ANNU_AMT < 0 THEN
        V_RETR_ANNU_AMT := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------        
      -- 11.2 연금보험료 공제 : 연금저축  공제 계산 
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_ANNU_BANK_AMT := 0;
      ELSE
        V_ANNU_BANK_AMT := ANNU_BANK_CAL
                             ( O_STATUS      => O_STATUS
                             , O_MESSAGE     => O_MESSAGE
                             , P_YEAR_YYYY   => P_YEAR_YYYY
                             , P_PERSON_ID   => C1.PERSON_ID
                             , P_SOB_ID      => C1.SOB_ID
                             , P_ORG_ID      => C1.ORG_ID              
                             );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - NVL(V_ANNU_BANK_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
      IF V_ANNU_BANK_AMT < 0 THEN
        V_ANNU_BANK_AMT := 0;
      END IF;     
      
-------------------------------------------------------------------------------------------------------------------------------        
      -- 5. 특별공제 : 보험료공제 계산 
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_INSURE_DED_AMT := 0;
      ELSE
        V_INSURE_DED_AMT := ETC_INSUR_CAL
                              ( O_STATUS      => O_STATUS
                              , O_MESSAGE     => O_MESSAGE
                              , P_YEAR_YYYY   => P_YEAR_YYYY
                              , P_PERSON_ID   => C1.PERSON_ID
                              , P_SOB_ID      => C1.SOB_ID
                              , P_ORG_ID      => C1.ORG_ID
                              );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      IF NVL(V_INSURE_DED_AMT, 0) < 0 THEN
        V_INSURE_DED_AMT := 0;
      END IF;
      V_INSURE_DED_AMT := NVL(V_INSURE_DED_AMT, 0) + NVL(V_MEDIC_INSUR_AMT, 0) + NVL(V_PRE_MEDIC_INSUR_AMT, 0);
      V_INSURE_DED_AMT := NVL(V_INSURE_DED_AMT, 0) + NVL(V_HIRE_INSUR_AMT, 0) + NVL(V_PRE_HIRE_INSUR_AMT, 0);
    
-------------------------------------------------------------------------------------------------------------------------------        
      -- 6. 특별공제 : 의료비 공제 계산 
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_MEDIC_DED_AMT := 0;
      ELSE
        V_MEDIC_DED_AMT := MEDIC_CAL
                             ( O_STATUS      => O_STATUS
                             , O_MESSAGE     => O_MESSAGE
                             , P_YEAR_YYYY   => P_YEAR_YYYY
                             , P_PERSON_ID   => C1.PERSON_ID
                             , P_SOB_ID      => C1.SOB_ID
                             , P_ORG_ID      => C1.ORG_ID
                             , P_TOTAL_PAY   => V_TOTAL_PAY
                             );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      IF V_MEDIC_DED_AMT < 0 THEN
        V_MEDIC_DED_AMT := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------        
      -- 7. 특별공제 : 교육비  공제 계산 
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_EDU_DED_AMT := 0;
      ELSE
        V_EDU_DED_AMT := EDUCATION_CAL
                           ( O_STATUS      => O_STATUS
                           , O_MESSAGE     => O_MESSAGE
                           , P_YEAR_YYYY   => P_YEAR_YYYY
                           , P_PERSON_ID   => C1.PERSON_ID
                           , P_SOB_ID      => C1.SOB_ID
                           , P_ORG_ID      => C1.ORG_ID
                           );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      IF V_EDU_DED_AMT < 0 THEN
        V_EDU_DED_AMT := 0;
      END IF;
      
-------------------------------------------------------------------------------------------------------------------------------
      -- 8-1. 특별공제 : 주택자금 공제(주택임차차입금원리금상환액);
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_HOUSE_DED_AMT := 0;
      ELSE
        V_HOUSE_DED_AMT := HOUSE_FUND_CAL
                             ( O_STATUS      => O_STATUS
                             , O_MESSAGE     => O_MESSAGE
                             , P_YEAR_YYYY   => P_YEAR_YYYY
                             , P_PERSON_ID   => C1.PERSON_ID
                             , P_SOB_ID      => C1.SOB_ID
                             , P_ORG_ID      => C1.ORG_ID                                                          
                             , P_TOTAL_PAY   => V_TOTAL_PAY
                             );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      IF V_HOUSE_DED_AMT < 0 THEN
        V_HOUSE_DED_AMT := 0;
      END IF;
      
      -- 8-2. 특별공제 : 주택자금 공제(월세액);
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_HOUSE_DED_AMT := 0;
      ELSE
        V_HOUSE_DED_AMT := NVL(V_HOUSE_DED_AMT, 0)
                           + NVL(HOUSE_FUND_MONTHLY_RENT_CAL
                                   ( O_STATUS      => O_STATUS
                                   , O_MESSAGE     => O_MESSAGE
                                   , P_YEAR_YYYY   => P_YEAR_YYYY
                                   , P_PERSON_ID   => C1.PERSON_ID
                                   , P_SOB_ID      => C1.SOB_ID
                                   , P_ORG_ID      => C1.ORG_ID              
                                   , P_TOTAL_PAY   => V_TOTAL_PAY
                                   ), 0);	
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      IF V_HOUSE_DED_AMT < 0 THEN
        V_HOUSE_DED_AMT := 0;
      END IF;
      
      -- 8-4. 그밖의 소득공제 : 주택마련저축공제;
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_HOUSE_SAVE_AMT := 0;
      ELSE
        V_HOUSE_SAVE_AMT := HOUSE_SAVE_CAL
                              ( O_STATUS      => O_STATUS
                              , O_MESSAGE     => O_MESSAGE
                              , P_YEAR_YYYY   => P_YEAR_YYYY
                              , P_PERSON_ID   => C1.PERSON_ID
                              , P_SOB_ID      => C1.SOB_ID
                              , P_ORG_ID      => C1.ORG_ID                                        
                              );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      IF V_HOUSE_SAVE_AMT < 0 THEN
        V_HOUSE_SAVE_AMT := 0;
      END IF;
      
      -- 8-3. 특별공제 : 주택자금 공제(장기주택이자상환액);
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_HOUSE_DED_AMT := 0;
      ELSE
        V_HOUSE_DED_AMT := NVL(V_HOUSE_DED_AMT, 0)
                           + NVL(HOUSE_FUND_LONG_CAL
                                   ( O_STATUS      => O_STATUS
                                   , O_MESSAGE     => O_MESSAGE
                                   , P_YEAR_YYYY   => P_YEAR_YYYY
                                   , P_PERSON_ID   => C1.PERSON_ID
                                   , P_SOB_ID      => C1.SOB_ID
                                   , P_ORG_ID      => C1.ORG_ID         
                                   , P_TOTAL_PAY   => V_TOTAL_PAY
                                   ), 0);	
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      IF V_HOUSE_DED_AMT < 0 THEN
        V_HOUSE_DED_AMT := 0;
      END IF;
      
      /*-- 8-1. 주택자금 공제(주택임차차입금원리금상환액/월세소득공제/장기주택이자상환액);
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_HOUSE_DED_AMT := 0;
      ELSE
        V_HOUSE_DED_AMT := HOUSE_FUND_CAL
                             ( O_STATUS      => O_STATUS
                             , O_MESSAGE     => O_MESSAGE
                             , P_YEAR_YYYY   => P_YEAR_YYYY
                             , P_PERSON_ID   => C1.PERSON_ID
                             , P_SOB_ID      => C1.SOB_ID
                             , P_ORG_ID      => C1.ORG_ID         
                             , P_TOTAL_PAY   => V_TOTAL_PAY                                   
                             );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      IF V_HOUSE_DED_AMT < 0 THEN
        V_HOUSE_DED_AMT := 0;
      END IF;*/
      
      -- 9. 특별공제 : 기부금  공제 계산 
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_DONAT_DED_AMT := 0;
      ELSE
        V_DONAT_DED_AMT := DONATION_CAL
                             ( O_STATUS      => O_STATUS
                             , O_MESSAGE     => O_MESSAGE
                             , P_YEAR_YYYY   => P_YEAR_YYYY
                             , P_PERSON_ID   => C1.PERSON_ID
                             , P_SOB_ID      => C1.SOB_ID
                             , P_ORG_ID      => C1.ORG_ID         
                             , P_INCOME_AMT  => NVL(V_INCOME_PAY, 0) 
                             );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      IF V_DONAT_DED_AMT < 0 THEN
        V_DONAT_DED_AMT := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------        
      -- 10. 특별공제 : 혼인장례이사  공제 계산 
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_MARRY_ETC_DED_AMT := 0;
      ELSE
        V_MARRY_ETC_DED_AMT := MARRY_ETC_CAL
                                 ( O_STATUS      => O_STATUS
                                 , O_MESSAGE     => O_MESSAGE
                                 , P_YEAR_YYYY   => P_YEAR_YYYY
                                 , P_PERSON_ID   => C1.PERSON_ID
                                 , P_SOB_ID      => C1.SOB_ID
                                 , P_ORG_ID      => C1.ORG_ID              
                                 , P_TOTAL_PAY   => V_TOTAL_PAY                                   
                                 );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      IF V_MARRY_ETC_DED_AMT < 0 THEN
        V_MARRY_ETC_DED_AMT := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------        
      -- 특별공제 합계 = 보험료, 의료비, 교육비, 주택자금공제, 기부금 계산.    
      V_SP_DED_SUM := NVL(V_INSURE_DED_AMT, 0) + NVL(V_MEDIC_DED_AMT, 0) + NVL(V_EDU_DED_AMT, 0) + 
                      NVL(V_HOUSE_DED_AMT, 0) + NVL(V_HOUSE_SAVE_AMT, 0) + 
                      NVL(V_DONAT_DED_AMT, 0) + NVL(V_MARRY_ETC_DED_AMT, 0);
      
      -- 특별공제 - 표준공제 : 
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_SP_STD_DED_AMT := 0;
      ELSE
        IF NVL(V_SP_DED_SUM, 0) < NVL(C1.SP_DED_STD, 0) THEN
          V_SP_STD_DED_AMT := C1.SP_DED_AMT;
        ELSE
          V_SP_STD_DED_AMT := 0;
        END IF;
      END IF;
      
      -- 차감소득공제(표준공제 금액이 있으면 표준공제 금액만 차감함).           
      IF NVL(V_SP_STD_DED_AMT, 0) > 0 THEN
        V_SUBT_DED_AMT := NVL(V_REAL_TAX, 0) - NVL(V_SP_STD_DED_AMT, 0);
      ELSE
        V_SUBT_DED_AMT := NVL(V_REAL_TAX, 0)- NVL(V_SP_DED_SUM, 0);
      END IF;
      IF V_SUBT_DED_AMT < 0 THEN
        V_SUBT_DED_AMT := 0;
      END IF;
      V_REAL_TAX := V_SUBT_DED_AMT;
    
-------------------------------------------------------------------------------------------------------------------------------        
      -- 11.1 개인연금저축  공제 계산 
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_PER_ANNU_BANK_AMT := 0;
      ELSE
        V_PER_ANNU_BANK_AMT := PER_ANNU_BANK_CAL
                                 ( O_STATUS      => O_STATUS
                                  , O_MESSAGE     => O_MESSAGE
                                  , P_YEAR_YYYY   => P_YEAR_YYYY
                                  , P_PERSON_ID   => C1.PERSON_ID
                                  , P_SOB_ID      => C1.SOB_ID
                                  , P_ORG_ID      => C1.ORG_ID                                                
                                 );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      IF V_PER_ANNU_BANK_AMT < 0 THEN
        V_PER_ANNU_BANK_AMT := 0;
      END IF;
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - NVL(V_PER_ANNU_BANK_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;

-------------------------------------------------------------------------------------------------------------------------------        
      -- 11.3 주택마련 저축계산 
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - NVL(V_HOUSE_SAVE_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
      
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 12. 투자조합출자 
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_INVEST_AMT := 0;
      ELSE
        V_INVEST_AMT := INVEST_CAL
                          ( O_STATUS      => O_STATUS
                          , O_MESSAGE     => O_MESSAGE
                          , P_YEAR_YYYY   => P_YEAR_YYYY
                          , P_PERSON_ID   => C1.PERSON_ID
                          , P_SOB_ID      => C1.SOB_ID
                          , P_ORG_ID      => C1.ORG_ID              
                          , P_INCOME_AMT  => NVL(V_INCOME_PAY, 0) 
                          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      IF V_INVEST_AMT < 0 THEN
        V_INVEST_AMT := 0;
      END IF;
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - NVL(V_INVEST_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 13. 신용카드등 공제 
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_CARD_AMT := 0;
      ELSE
        V_CARD_AMT := CARD_CAL
                        ( O_STATUS      => O_STATUS
                        , O_MESSAGE     => O_MESSAGE
                        , P_YEAR_YYYY   => P_YEAR_YYYY
                        , P_PERSON_ID   => C1.PERSON_ID
                        , P_SOB_ID      => C1.SOB_ID
                        , P_ORG_ID      => C1.ORG_ID              
                        , P_TOTAL_PAY   => V_TOTAL_PAY                                    
                        );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      IF V_CARD_AMT < 0 THEN
        V_CARD_AMT := 0;
      END IF;
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - NVL(V_CARD_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
      
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 14. 우리사주조합출연 공제   
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_EMPL_STOCK_AMT := 0;
      ELSE
        V_EMPL_STOCK_AMT := EMPL_STOCK_CAL
                           ( O_STATUS      => O_STATUS
                           , O_MESSAGE     => O_MESSAGE
                           , P_YEAR_YYYY   => P_YEAR_YYYY
                           , P_PERSON_ID   => C1.PERSON_ID
                           , P_SOB_ID      => C1.SOB_ID
                           , P_ORG_ID      => C1.ORG_ID                                         
                           );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      IF V_EMPL_STOCK_AMT < 0 THEN
        V_EMPL_STOCK_AMT := 0;
      END IF;
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - NVL(V_EMPL_STOCK_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 14.-1 소기업/소상인공제부금액;
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_SMALL_CORPOR_DED_AMT := 0;
      ELSE
        V_SMALL_CORPOR_DED_AMT := SMALL_CORPOR_DED_CAL
                                    ( O_STATUS      => O_STATUS
                                    , O_MESSAGE     => O_MESSAGE
                                    , P_YEAR_YYYY   => P_YEAR_YYYY
                                    , P_PERSON_ID   => C1.PERSON_ID
                                    , P_SOB_ID      => C1.SOB_ID
                                    , P_ORG_ID      => C1.ORG_ID              
                                    );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      IF V_SMALL_CORPOR_DED_AMT < 0 THEN
        V_SMALL_CORPOR_DED_AMT := 0;
      END IF;
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - NVL(V_SMALL_CORPOR_DED_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 14-2. 장기주식형저축소득공제;   
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_LONG_STOCK_SAVING_AMT := 0;
      ELSE
        V_LONG_STOCK_SAVING_AMT := LONG_STOCK_SAVING_CAL
                                     ( O_STATUS      => O_STATUS
                                     , O_MESSAGE     => O_MESSAGE
                                     , P_YEAR_YYYY   => P_YEAR_YYYY
                                     , P_PERSON_ID   => C1.PERSON_ID
                                     , P_SOB_ID      => C1.SOB_ID
                                     , P_ORG_ID      => C1.ORG_ID              
                                     );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      IF V_LONG_STOCK_SAVING_AMT < 0 THEN
        V_LONG_STOCK_SAVING_AMT := 0;
      END IF;
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - NVL(V_LONG_STOCK_SAVING_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
      
      -- 14-4. 목돈안드는 전세 이자상환액 공제;
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_FIX_LEASE_DED_AMT := 0;
      ELSE
        V_FIX_LEASE_DED_AMT := FIX_LEASE_DED_CAL
                                 ( O_STATUS      => O_STATUS
                                 , O_MESSAGE     => O_MESSAGE
                                 , P_YEAR_YYYY   => P_YEAR_YYYY
                                 , P_PERSON_ID   => C1.PERSON_ID
                                 , P_SOB_ID      => C1.SOB_ID
                                 , P_ORG_ID      => C1.ORG_ID              
                                 );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      IF V_FIX_LEASE_DED_AMT < 0 THEN
        V_FIX_LEASE_DED_AMT := 0;
      END IF;
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - NVL(V_FIX_LEASE_DED_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
      
      -- 14-9. 2013-특별공제 종합한도 초과액   
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_SP_DED_TOT_AMT := 0;
      ELSE
        V_SP_DED_TOT_AMT := SPECIAL_DED_LMT_CAL
                              ( O_STATUS      => O_STATUS
                              , O_MESSAGE     => O_MESSAGE
                              , P_YEAR_YYYY   => P_YEAR_YYYY
                              , P_PERSON_ID   => C1.PERSON_ID
                              , P_SOB_ID      => C1.SOB_ID
                              , P_ORG_ID      => C1.ORG_ID              
                              );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      IF V_SP_DED_TOT_AMT < 0 THEN
        V_SP_DED_TOT_AMT := 0;
      END IF;
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - NVL(V_SP_DED_TOT_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
      
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 과세표준 계산;
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_TAX_STD_AMT := TRUNC(NVL(V_TOTAL_PAY, 0) * (C1.FOREIGN_INCOME_RATE / 100));
      ELSE
        V_TAX_STD_AMT := V_REAL_TAX; 
      END IF;
      IF V_TAX_STD_AMT < 0 THEN
        V_TAX_STD_AMT := 0;
      END IF;
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 15.0 산출세액 계산   
      V_COMP_TAX_AMT := COMP_TAX_CAL
                          ( O_STATUS      => O_STATUS
                          , O_MESSAGE     => O_MESSAGE                                 
                          , P_YEAR_YYYY   => P_YEAR_YYYY
                          , P_PERSON_ID   => C1.PERSON_ID
                          , P_SOB_ID      => C1.SOB_ID
                          , P_ORG_ID      => C1.ORG_ID
                          , P_TAX_STD_AMT => V_TAX_STD_AMT
                          );
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;      
      IF V_COMP_TAX_AMT < 0 THEN
        V_COMP_TAX_AMT := 0;
      END IF;
      V_REAL_TAX := V_COMP_TAX_AMT;
      
      -- 15.1 2013.12.31 전호수 추가  
      -- 투자조합 공제 금액이 있을 경우 농특세 계산 위한 산출세액 계산  
      -- 중소기업창업투자조합 출자 등에 대한 소득공제를 받은 경우 해당 소득공제액을   
      -- 과세표준에 산입하여 계산한 산출세액과 당해 소득금액 공제액을 차감한 과세표준으로  
      -- 계산한 산출세액의 차액의 20%에 상당하는 금액을 농어촌특별세로 납부  
      V_TEMP_AMT := 0;
      IF NVL(V_INVEST_AMT, 0) > 0 THEN
        IF (NVL(V_TAX_STD_AMT, 0) - NVL(V_INVEST_AMT, 0)) < 0 THEN
          V_TEMP_AMT := 0;
        ELSE
          V_TEMP_AMT := COMP_TAX_CAL
                              ( O_STATUS      => O_STATUS
                              , O_MESSAGE     => O_MESSAGE                                 
                              , P_YEAR_YYYY   => P_YEAR_YYYY
                              , P_PERSON_ID   => C1.PERSON_ID
                              , P_SOB_ID      => C1.SOB_ID
                              , P_ORG_ID      => C1.ORG_ID
                              , P_TAX_STD_AMT => (NVL(V_TAX_STD_AMT, 0) - NVL(V_INVEST_AMT, 0))
                              );
        END IF;
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;      
        IF V_TEMP_AMT < 0 THEN
          V_TEMP_AMT := 0;
        END IF;
        
        -- 농특세율 조회 -- 
        BEGIN
          SELECT NVL(HIT.SP_TAX_RATE, 0) AS SP_TAX_RATE
            INTO V_TEMP_RATE
            FROM HRA_INCOME_TAX_STANDARD HIT
           WHERE HIT.YEAR_YYYY     = P_YEAR_YYYY
             AND HIT.SOB_ID        = P_SOB_ID
             AND HIT.ORG_ID        = P_ORG_ID
          ;          
        EXCEPTION
          WHEN OTHERS THEN
            V_TEMP_RATE := 20;   
        END;          
        V_TEMP_AMT := NVL(V_COMP_TAX_AMT, 0) - NVL(V_TEMP_AMT, 0);
        IF NVL(V_TEMP_AMT, 0) < 0 THEN
          V_TEMP_AMT := 0;
        END IF;
        -- 농특세 계산 -- 
        F_SP_TAX_AMT := NVL(F_SP_TAX_AMT, 0) +
                        TRUNC(V_TEMP_AMT * (V_TEMP_RATE / 100));        
      END IF;
            
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      BEGIN
        -- 표준공제액 및 차감소득공제액, 과세표준, 산출세액  UPDATE  
        UPDATE HRA_YEAR_ADJUSTMENT HA
          SET HA.STAND_DED_AMT     = V_SP_STD_DED_AMT
            , HA.SUBT_DED_AMT      = V_SUBT_DED_AMT
            , HA.TAX_STD_AMT       = V_TAX_STD_AMT
            , HA.COMP_TAX_AMT      = V_COMP_TAX_AMT
        WHERE HA.YEAR_YYYY         = P_YEAR_YYYY
          AND HA.PERSON_ID         = C1.PERSON_ID
          AND HA.SOB_ID            = C1.SOB_ID
          AND HA.ORG_ID            = C1.ORG_ID
        ;
       EXCEPTION 
         WHEN OTHERS THEN
           O_STATUS := 'F';
           O_MESSAGE := 'Stand_ded_Update Error : ' || SUBSTR(SQLERRM, 1, 200);
           RETURN;    
       END;
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 16.1 세감-소득세법 계산.     
      V_TAX_REDU_IN_LAW_AMT := TAX_REDU_IN_LAW_CAL
                                  ( O_STATUS        => O_STATUS
                                  , O_MESSAGE       => O_MESSAGE
                                  , P_YEAR_YYYY     => P_YEAR_YYYY
                                  , P_PERSON_ID     => C1.PERSON_ID
                                  , P_SOB_ID        => C1.SOB_ID
                                  , P_ORG_ID        => C1.ORG_ID
                                  , P_INCOME_AMT    => V_INCOME_PAY
                                  , P_COMP_TAX_AMT  => V_COMP_TAX_AMT
                                  );
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
      
      -- 16.2 세감-조세특례제한법.
      V_TAX_REDU_SP_LAW_AMT := TAX_REDU_SP_LAW_CAL
                                  ( O_STATUS        => O_STATUS
                                  , O_MESSAGE       => O_MESSAGE
                                  , P_YEAR_YYYY     => P_YEAR_YYYY
                                  , P_PERSON_ID     => C1.PERSON_ID
                                  , P_SOB_ID        => C1.SOB_ID
                                  , P_ORG_ID        => C1.ORG_ID
                                  , P_INCOME_AMT    => V_INCOME_PAY
                                  , P_COMP_TAX_AMT  => V_COMP_TAX_AMT
                                  );
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
            
      -- 16.3 세액감면-조세조약.
      V_TAX_REDU_TAX_TREATY := TAX_REDU_TAX_TREATY_CAL
                                  ( O_STATUS        => O_STATUS
                                  , O_MESSAGE       => O_MESSAGE
                                  , P_YEAR_YYYY     => P_YEAR_YYYY
                                  , P_PERSON_ID     => C1.PERSON_ID
                                  , P_SOB_ID        => C1.SOB_ID
                                  , P_ORG_ID        => C1.ORG_ID
                                  , P_INCOME_AMT    => V_INCOME_PAY
                                  , P_COMP_TAX_AMT  => V_COMP_TAX_AMT
                                  );
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
                                
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 17.1 근로소득공제 계산        
      V_TEMP_AMT := 0;
      V_TEMP_AMT := TAX_DED_INCOME_CAL
                      ( O_STATUS        => O_STATUS
                      , O_MESSAGE       => O_MESSAGE                                 
                      , P_YEAR_YYYY     => P_YEAR_YYYY
                      , P_PERSON_ID     => C1.PERSON_ID
                      , P_SOB_ID        => C1.SOB_ID
                      , P_ORG_ID        => C1.ORG_ID
                      , P_COMP_TAX_AMT  => V_COMP_TAX_AMT
                      );
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
      
      IF V_TEMP_AMT < 0 THEN
        V_TEMP_AMT := 0;
      END IF;
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - NVL(V_TEMP_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 17.2 납세조합 세액공제 계산(을종 소득이 있는자에 한해) - 해당없음        
      /*V_TEMP_AMT := 0;
      V_TEMP_AMT := IFC_YEAR_ADJUST_SET_PKG_2010.TAX_DED_TAXGROUP_CAL('101',  I_YEAR_YYYY, C1.PERSON_NUMB, V_COMP_TAX_AMT);
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
      
      IF V_TEMP_AMT < 0 THEN
        V_TEMP_AMT := 0;
      END IF;
      V_REAL_TAX := V_REAL_TAX - V_TEMP_AMT;
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;          */
    
      --DBMS_OUTPUT.PUT_LINE('V_REAL_TAX =>' || V_REAL_TAX);
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 17.3 주택차입금이자상환액 세액공제 계산.
      V_TEMP_AMT := 0;
      V_TEMP_AMT := HOUSE_DEBT_BEN_CAL
                    ( O_STATUS        => O_STATUS
                    , O_MESSAGE       => O_MESSAGE                                 
                    , P_YEAR_YYYY     => P_YEAR_YYYY
                    , P_PERSON_ID     => C1.PERSON_ID
                    , P_SOB_ID        => C1.SOB_ID
                    , P_ORG_ID        => C1.ORG_ID
                    , P_REAL_TAX      => V_REAL_TAX
                    );
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
      
      IF V_TEMP_AMT < 0 THEN
        V_TEMP_AMT := 0;
      END IF;
      
      -- 농어촌특별세 계산--
      IF V_TEMP_AMT > 0 THEN
        -- 농특세율 조회 -- 
        BEGIN
          SELECT NVL(HIT.SP_TAX_RATE, 0) AS SP_TAX_RATE
            INTO V_TEMP_RATE
            FROM HRA_INCOME_TAX_STANDARD HIT
           WHERE HIT.YEAR_YYYY     = P_YEAR_YYYY
             AND HIT.SOB_ID        = P_SOB_ID
             AND HIT.ORG_ID        = P_ORG_ID
          ;          
        EXCEPTION
          WHEN OTHERS THEN
            V_TEMP_RATE := 20;   
        END;                  
        F_SP_TAX_AMT := NVL(F_SP_TAX_AMT, 0) + TRUNC(V_TEMP_AMT * (V_TEMP_RATE / 100));
      END IF;
      
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - NVL(V_TEMP_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 16.4 외국납부 세액 공제          
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - NVL(V_TAX_OUTSIDE_AMT, 0); -- 국외소득 조회부분에서 같이 조회함  
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
      
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 16.5 정치기부금 세액 공제     
      V_TEMP_AMT := 0;
      BEGIN
        SELECT NVL(HA.TAX_DED_DONAT_POLI_AMT, 0) AS TAX_DED_DONAT_POLI_AMT
          INTO V_TEMP_AMT
          FROM HRA_YEAR_ADJUSTMENT HA
        WHERE HA.YEAR_YYYY        = P_YEAR_YYYY
          AND HA.PERSON_ID        = C1.PERSON_ID
          AND HA.SOB_ID           = C1.SOB_ID
          AND HA.ORG_ID           = C1.ORG_ID
        ;
      EXCEPTION
        WHEN OTHERS THEN
          V_TEMP_AMT := 0;
      END;
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - NVL(V_TEMP_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
      
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 17. 결정세액  
      F_IN_TAX_AMT    := V_REAL_TAX;
      F_LOCAL_TAX_AMT := TRUNC(F_IN_TAX_AMT * (C1.LOCAL_TAX_RATE / 100));
      
      V_TEMP_AMT := 0;
      BEGIN
        SELECT HA.FIX_SP_TAX_AMT
          INTO V_TEMP_AMT
          FROM HRA_YEAR_ADJUSTMENT HA
        WHERE HA.YEAR_YYYY        = P_YEAR_YYYY
          AND HA.PERSON_ID        = C1.PERSON_ID
          AND HA.SOB_ID           = C1.SOB_ID
          AND HA.ORG_ID           = C1.ORG_ID
        ;
      EXCEPTION
        WHEN OTHERS THEN
          V_TEMP_AMT := 0;
      END;
      F_SP_TAX_AMT := NVL(F_SP_TAX_AMT, 0) + NVL(V_TEMP_AMT, 0);
      
------------------------------------------------------------------------------------------------------------------------------
      -- 18. 차감세액 
      S_IN_TAX_AMT    := NVL(F_IN_TAX_AMT, 0) - NVL(V_IN_TAX_AMT, 0) - NVL(V_PRE_IN_TAX_AMT, 0);
      S_LOCAL_TAX_AMT := NVL(F_LOCAL_TAX_AMT, 0) - NVL(V_LOCAL_TAX_AMT, 0) - NVL(V_PRE_LOCAL_TAX_AMT, 0);
      
      -- 원단위 절사 
      S_IN_TAX_AMT    := DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(S_IN_TAX_AMT, 0), 'YEAR_IN_TAX');
      S_LOCAL_TAX_AMT := DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(S_LOCAL_TAX_AMT, 0), 'YEAR_LOCAL_TAX');
      S_SP_TAX_AMT    := DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(S_SP_TAX_AMT, 0), 'SP_TAX');
                               

      /*S_IN_TAX_AMT    := DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(F_IN_TAX_AMT, 0), 'YEAR_IN_TAX') -
                         DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(V_IN_TAX_AMT, 0), 'YEAR_IN_TAX') -
                         DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(V_PRE_IN_TAX_AMT, 0), 'YEAR_IN_TAX');
      S_SP_TAX_AMT    := DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(F_SP_TAX_AMT, 0), 'SP_TAX');
      S_LOCAL_TAX_AMT := DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(F_LOCAL_TAX_AMT, 0), 'YEAR_LOCAL_TAX') -
                         DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(V_LOCAL_TAX_AMT, 0), 'YEAR_LOCAL_TAX') -
                         DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(V_PRE_LOCAL_TAX_AMT, 0), 'YEAR_LOCAL_TAX');
    */
      --DBMS_OUTPUT.PUT_LINE('결정세액 =>' || TO_CHAR(V_REAL_TAX, 'FM999,999,999,999'));
    
----- 현근무지(급여/상여/인정상여/학자금/기납부세액등), 전근무지자료 UPDATE --------------------------------------------------
      BEGIN
        UPDATE HRA_YEAR_ADJUSTMENT HA
          SET HA.FIX_IN_TAX_AMT     = F_IN_TAX_AMT
            , HA.FIX_SP_TAX_AMT     = F_SP_TAX_AMT 
            , HA.FIX_LOCAL_TAX_AMT  = F_LOCAL_TAX_AMT 
            , HA.SUBT_IN_TAX_AMT    = S_IN_TAX_AMT
            , HA.SUBT_SP_TAX_AMT    = S_SP_TAX_AMT
            , HA.SUBT_LOCAL_TAX_AMT = S_LOCAL_TAX_AMT
            , HA.LAST_UPDATE_DATE   = V_SYSDATE
            , HA.LAST_UPDATED_BY    = P_USER_ID
         WHERE HA.YEAR_YYYY         = P_YEAR_YYYY
           AND HA.PERSON_ID         = C1.PERSON_ID
           AND HA.SOB_ID            = C1.SOB_ID
           AND HA.ORG_ID            = C1.ORG_ID
        ;
      EXCEPTION
        WHEN OTHERS THEN
          O_STATUS := 'F';
          O_MESSAGE := 'Fix In Tax Error : ' || SUBSTR(SQLERRM, 1, 200);
          RETURN;
      END;
    END LOOP C1;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);  
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Year Adjust Cal Error : ' || SUBSTR(SQLERRM, 1, 200);      
  END MAIN_CAL;

  -- 0. 연말정산 처리 대상 산출;
  PROCEDURE BASIC_CREATION
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN NUMBER
            , P_YEAR_YYYY         IN VARCHAR2
            , P_STD_DATE          IN DATE
            , P_DEPT_ID           IN NUMBER
            , P_FLOOR_ID          IN NUMBER
            , P_EMPLOYE_TYPE      IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_USER_ID           IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
    V_SYSDATE                 DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_START_DATE              DATE;
    V_RECORD_COUNT            NUMBER;
  BEGIN
    O_STATUS := 'F';
    --> 초기화.
    BEGIN
      V_START_DATE := TRUNC(P_STD_DATE, 'MONTH');      
    EXCEPTION
      WHEN OTHERS THEN
        V_START_DATE := P_STD_DATE;
    END;
    V_RECORD_COUNT := 0;
    BEGIN
      SELECT COUNT(HA.PERSON_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRA_YEAR_ADJUSTMENT HA
       WHERE HA.CORP_ID           = P_CORP_ID
         AND HA.YEAR_YYYY         = P_YEAR_YYYY
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
         AND HA.CLOSED_FLAG       = 'N' 
         AND EXISTS 
               (SELECT 'X'  
                  FROM HRM_PERSON_MASTER PM
                    , (-- 시점 인사내역.
                        SELECT  HL.PERSON_ID
                              , HL.DEPT_ID
                              , HL.POST_ID
                              , HL.PAY_GRADE_ID
                              , HL.JOB_CATEGORY_ID
                              , HL.FLOOR_ID    
                          FROM HRM_HISTORY_HEADER HH
                             , HRM_HISTORY_LINE   HL  
                        WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
                          AND HH.CHARGE_SEQ           IN 
                                (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                    FROM HRM_HISTORY_HEADER S_HH
                                       , HRM_HISTORY_LINE   S_HL
                                   WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                     AND S_HH.CHARGE_DATE       <= LAST_DAY(P_STD_DATE) 
                                     AND S_HL.PERSON_ID         = HL.PERSON_ID
                                   GROUP BY S_HL.PERSON_ID
                                 )                                 
                    ) T1
                WHERE PM.PERSON_ID      = T1.PERSON_ID
                  AND PM.PERSON_ID      = HA.PERSON_ID
                  AND PM.CORP_ID        = P_CORP_ID
                  AND PM.SOB_ID         = P_SOB_ID
                  AND PM.ORG_ID         = P_ORG_ID
                  AND ((P_PERSON_ID     IS NULL AND 1 = 1)
                    OR (P_PERSON_ID     IS NOT NULL AND PM.PERSON_ID = P_PERSON_ID))
                  AND PM.JOIN_DATE     <= P_STD_DATE
                  AND ((P_EMPLOYE_TYPE  IS NULL AND (PM.RETIRE_DATE >= V_START_DATE OR PM.RETIRE_DATE IS NULL))
                    OR (P_EMPLOYE_TYPE != '3' AND (PM.RETIRE_DATE >= V_START_DATE OR PM.RETIRE_DATE IS NULL))
                    OR (P_EMPLOYE_TYPE  = '3' AND (PM.RETIRE_DATE BETWEEN V_START_DATE AND LAST_DAY(P_STD_DATE))))
                  AND ((P_DEPT_ID       IS NULL AND 1 = 1)
                  OR   (P_DEPT_ID       IS NOT NULL AND T1.DEPT_ID = P_DEPT_ID))
                  AND ((P_FLOOR_ID      IS NULL AND 1 = 1)
                  OR   (P_FLOOR_ID      IS NOT NULL AND T1.FLOOR_ID = P_FLOOR_ID))
              )
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT > 0 THEN
      --> 기존자료 삭제.
      DELETE FROM HRA_YEAR_ADJUSTMENT HA
       WHERE HA.CORP_ID           = P_CORP_ID
         AND HA.YEAR_YYYY         = P_YEAR_YYYY
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
         AND HA.CLOSED_FLAG      != 'Y'
         AND EXISTS 
               (SELECT 'X'  
                  FROM HRM_PERSON_MASTER PM
                    , (-- 시점 인사내역.
                        SELECT  HL.PERSON_ID
                              , HL.DEPT_ID
                              , HL.POST_ID
                              , HL.PAY_GRADE_ID
                              , HL.JOB_CATEGORY_ID
                              , HL.FLOOR_ID    
                          FROM HRM_HISTORY_HEADER HH
                             , HRM_HISTORY_LINE   HL 
                        WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
                          AND HH.CHARGE_SEQ           IN 
                                (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                    FROM HRM_HISTORY_HEADER S_HH
                                       , HRM_HISTORY_LINE   S_HL
                                   WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                     AND S_HH.CHARGE_DATE       <= LAST_DAY(P_STD_DATE) 
                                     AND S_HL.PERSON_ID         = HL.PERSON_ID
                                   GROUP BY S_HL.PERSON_ID
                                 )  
                    ) T1                    
                WHERE PM.PERSON_ID      = T1.PERSON_ID
                  AND PM.PERSON_ID      = HA.PERSON_ID
                  AND ((P_PERSON_ID     IS NULL AND 1 = 1)
                    OR (P_PERSON_ID     IS NOT NULL AND PM.PERSON_ID = P_PERSON_ID))
                  AND PM.JOIN_DATE     <= P_STD_DATE
                  AND ((P_EMPLOYE_TYPE  IS NULL AND (PM.RETIRE_DATE >= V_START_DATE OR PM.RETIRE_DATE IS NULL))
                    OR (P_EMPLOYE_TYPE != '3' AND (PM.RETIRE_DATE >= V_START_DATE OR PM.RETIRE_DATE IS NULL))
                    OR (P_EMPLOYE_TYPE  = '3' AND (PM.RETIRE_DATE BETWEEN V_START_DATE AND LAST_DAY(P_STD_DATE))))
                  AND ((P_DEPT_ID       IS NULL AND 1 = 1)
                  OR   (P_DEPT_ID       IS NOT NULL AND T1.DEPT_ID = P_DEPT_ID))
                  AND ((P_FLOOR_ID      IS NULL AND 1 = 1)
                  OR   (P_FLOOR_ID      IS NOT NULL AND T1.FLOOR_ID = P_FLOOR_ID))
              )
      ;
    END IF;
    
    --> 연말정산 처리대상 생성  
    INSERT INTO HRA_YEAR_ADJUSTMENT
    ( CORP_ID
    , YEAR_YYYY
    , PERSON_ID
    , SOB_ID
    , ORG_ID
    , SUBMIT_DATE
    , ADJUST_DATE_FR
    , ADJUST_DATE_TO
    , PAY_TYPE
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY
    )
    (SELECT PM.CORP_ID
          , P_YEAR_YYYY  AS YEAR_YYYY
          , PM.PERSON_ID
          , PM.SOB_ID
          , PM.ORG_ID
          , P_STD_DATE AS SUBMIT_DATE
          , CASE
              WHEN TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') < PM.JOIN_DATE THEN PM.JOIN_DATE
              ELSE TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD')
            END AS ADJUST_DATE_FR
          , CASE
              WHEN PM.RETIRE_DATE IS NULL THEN TO_DATE(P_YEAR_YYYY || '-12-31', 'YYYY-MM-DD')
              WHEN PM.RETIRE_DATE < TO_DATE(P_YEAR_YYYY || '-12-31', 'YYYY-MM-DD') THEN PM.RETIRE_DATE
              ELSE TO_DATE(P_YEAR_YYYY || '-12-31', 'YYYY-MM-DD')
            END AS ADJUST_DATE_TO
          , NVL(MH.PAY_TYPE, '1') AS PAY_TYPE
          , V_SYSDATE AS CREATION_DATE
          , P_USER_ID AS CREATED_BY
          , V_SYSDATE AS LAST_UPDATE_DATE
          , P_USER_ID AS LAST_UPDATED_BY
       FROM HRM_PERSON_MASTER PM
          , (-- 시점 인사내역.
             SELECT  HL.PERSON_ID
                   , HL.DEPT_ID
                   , HL.POST_ID
                   , HL.PAY_GRADE_ID
                   , HL.FLOOR_ID
                   , HL.JOB_CATEGORY_ID
                   , HL.JOB_CLASS_ID
                   , HL.OCPT_ID
                   , HL.ABIL_ID
                FROM HRM_HISTORY_HEADER HH
                   , HRM_HISTORY_LINE   HL 
              WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
                AND HH.CHARGE_SEQ           IN 
                      (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                          FROM HRM_HISTORY_HEADER S_HH
                             , HRM_HISTORY_LINE   S_HL
                         WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                           AND S_HH.CHARGE_DATE       <= LAST_DAY(P_STD_DATE) 
                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       )                                    
            ) T1               
          , ( SELECT PMH.CORP_ID
                  , PMH.PERSON_ID
                  , PMH.SOB_ID
                  , PMH.ORG_ID
                  , PMH.PAY_TYPE
               FROM HRP_PAY_MASTER_HEADER PMH
             WHERE PMH.CORP_ID              = P_CORP_ID
               AND PMH.SOB_ID               = P_SOB_ID
               AND PMH.ORG_ID               = P_ORG_ID
               AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                 OR (P_PERSON_ID            IS NOT NULL AND PMH.PERSON_ID = P_PERSON_ID))
               AND PMH.START_YYYYMM         <= TO_CHAR(P_STD_DATE, 'YYYY-MM')
               AND PMH.END_YYYYMM           >= TO_CHAR(P_STD_DATE, 'YYYY-MM')
            ) MH
      WHERE PM.PERSON_ID          = T1.PERSON_ID 
        AND PM.PERSON_ID          = MH.PERSON_ID        
        AND PM.CORP_ID            = P_CORP_ID 
        AND PM.SOB_ID             = P_SOB_ID
        AND PM.ORG_ID             = P_ORG_ID
        AND ((P_PERSON_ID         IS NULL AND 1 = 1)
          OR (P_PERSON_ID         IS NOT NULL AND PM.PERSON_ID = P_PERSON_ID))
        AND PM.JOIN_DATE         <= P_STD_DATE
        AND ((P_EMPLOYE_TYPE      IS NULL AND (PM.RETIRE_DATE >= V_START_DATE OR PM.RETIRE_DATE IS NULL))
          OR (P_EMPLOYE_TYPE     != '3' AND (PM.RETIRE_DATE >= V_START_DATE OR PM.RETIRE_DATE IS NULL))
          OR (P_EMPLOYE_TYPE      = '3' AND (PM.RETIRE_DATE BETWEEN V_START_DATE AND LAST_DAY(P_STD_DATE))))
        AND ((P_DEPT_ID           IS NULL AND 1 = 1)
        OR   (P_DEPT_ID           IS NOT NULL AND T1.DEPT_ID = P_DEPT_ID))
        AND ((P_FLOOR_ID          IS NULL AND 1 = 1)
        OR   (P_FLOOR_ID          IS NOT NULL AND T1.FLOOR_ID = P_FLOOR_ID))                           
        AND NOT EXISTS
              ( SELECT 'X'
                  FROM HRA_YEAR_ADJUSTMENT HA
                 WHERE HA.PERSON_ID     = PM.PERSON_ID
                   AND HA.YEAR_YYYY     = P_YEAR_YYYY
                   AND HA.SOB_ID        = P_SOB_ID
                   AND HA.ORG_ID        = P_ORG_ID
                   AND HA.CLOSED_FLAG   = 'Y'
              )              
    );
    O_STATUS := 'S';
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Basic Creation Error : ' || SUBSTR(SQLERRM, 1, 200);
  END BASIC_CREATION;

  -- 3.5 근로소득공제 계산;
  FUNCTION INCOME_DED_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER
  AS
    V_AMOUNT                  NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( -- 연말정산 처리기준 중 근로소득공제 관련 항목  
               SELECT HIT.INCOME_DED_A,
                       HIT.INCOME_DED_RATE_A,
                       HIT.INCOME_DED_AMT_A,
                       HIT.INCOME_CALCU_BAS_A,
                       HIT.INCOME_DED_B,
                       HIT.INCOME_DED_RATE_B,
                       HIT.INCOME_DED_AMT_B,
                       HIT.INCOME_CALCU_BAS_B,
                       HIT.INCOME_DED_C,
                       HIT.INCOME_DED_RATE_C,
                       HIT.INCOME_DED_AMT_C,
                       HIT.INCOME_CALCU_BAS_C,
                       HIT.INCOME_DED_D,
                       HIT.INCOME_DED_RATE_D,
                       HIT.INCOME_DED_AMT_D,
                       HIT.INCOME_CALCU_BAS_D,
                       HIT.INCOME_DED_LMT,
                       HIT.INCOME_DED_RATE_LMT,
                       HIT.INCOME_DED_AMT_LMT,
                       HIT.INCOME_CALCU_BAS_LMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                WHERE HIT.YEAR_YYYY         = P_YEAR_YYYY
                  AND HIT.SOB_ID            = P_SOB_ID
                  AND HIT.ORG_ID            = P_ORG_ID
               ) 
    LOOP
--DBMS_OUTPUT.PUT_LINE('I_YEAR_YYYY =>' || I_YEAR_YYYY || 'I_TOTAL_PAY =>' || I_TOTAL_PAY);
      ----- 3.5 근로소득 공제 계산                          
      IF NVL(P_TOTAL_PAY, 0) BETWEEN 0 AND NVL(C1.INCOME_DED_A, 0) THEN
        V_AMOUNT := TRUNC((NVL(P_TOTAL_PAY, 0) - NVL(C1.INCOME_DED_AMT_A, 0)) * (NVL(C1.INCOME_DED_RATE_A, 0) / 100));
        V_AMOUNT := NVL(V_AMOUNT, 0) + NVL(C1.INCOME_CALCU_BAS_A, 0);
      ELSIF NVL(P_TOTAL_PAY, 0) BETWEEN NVL(C1.INCOME_DED_A, 0) + 1 AND NVL(C1.INCOME_DED_B, 0) THEN
        V_AMOUNT := TRUNC((NVL(P_TOTAL_PAY, 0) - NVL(C1.INCOME_DED_AMT_B, 0)) * (NVL(C1.INCOME_DED_RATE_B, 0) / 100));
        V_AMOUNT := NVL(V_AMOUNT, 0) + NVL(C1.INCOME_CALCU_BAS_B, 0);
      ELSIF NVL(P_TOTAL_PAY, 0) BETWEEN NVL(C1.INCOME_DED_B, 0) + 1 AND NVL(C1.INCOME_DED_C, 0) THEN
        V_AMOUNT := TRUNC((NVL(P_TOTAL_PAY, 0) - NVL(C1.INCOME_DED_AMT_C, 0)) * (NVL(C1.INCOME_DED_RATE_C, 0) / 100));
        V_AMOUNT := NVL(V_AMOUNT, 0) + NVL(C1.INCOME_CALCU_BAS_C, 0);
      ELSIF NVL(P_TOTAL_PAY, 0) BETWEEN NVL(C1.INCOME_DED_C, 0) + 1 AND NVL(C1.INCOME_DED_D, 0) THEN
        V_AMOUNT := TRUNC((NVL(P_TOTAL_PAY, 0) - NVL(C1.INCOME_DED_AMT_D, 0)) * (NVL(C1.INCOME_DED_RATE_D, 0) / 100));
        V_AMOUNT := NVL(V_AMOUNT, 0) + NVL(C1.INCOME_CALCU_BAS_D, 0);
      ELSIF NVL(C1.INCOME_DED_LMT, 0) <= NVL(P_TOTAL_PAY, 0) THEN
        V_AMOUNT := TRUNC((NVL(P_TOTAL_PAY, 0) - NVL(C1.INCOME_DED_AMT_LMT, 0)) * (NVL(C1.INCOME_DED_RATE_LMT, 0) / 100));
        V_AMOUNT := NVL(V_AMOUNT, 0) + NVL(C1.INCOME_CALCU_BAS_LMT, 0);
        -- 2010.02.02 2010년 연말정산 수정. 전액공제 폐지;
/*      ELSE   -- 전액공제(
        V_INCOME_DED_AMT := NVL(P_TOTAL_PAY, 0);  */
      END IF;
    END LOOP C1;
    O_STATUS := 'S';
    RETURN NVL(V_AMOUNT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Income Ded Cal Error : ' || SQLERRM;
      RETURN 0;
  END INCOME_DED_CAL;

  -- 4. 인적공제;
  FUNCTION SUPP_FAMILY_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_STD_DATE          IN DATE
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_SUPP_FAMILY_AMT         NUMBER := 0;
    V_MANY_CHILD_DED_AGE      NUMBER := 0; -- 자녀양육비 공제 나이;
    V_MANY_CHILD_COUNT        NUMBER := 0; -- 다자녀추공제 인원수.
    V_MANY_CHILD_DED          NUMBER := 0; -- 다자녀추가공제  .
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT HIT.MANY_CHILD_DED_AGE
        INTO V_MANY_CHILD_DED_AGE
        FROM HRA_INCOME_TAX_STANDARD HIT
       WHERE HIT.YEAR_YYYY      = P_YEAR_YYYY
         AND HIT.SOB_ID         = P_SOB_ID
         AND HIT.ORG_ID         = P_ORG_ID;
    EXCEPTION
      WHEN OTHERS THEN
        V_MANY_CHILD_DED_AGE := 0;
    END;
    -- 연말정산 처리기준 중 부양가족 관련 항목--
    FOR C1 IN (SELECT HIT.YEAR_YYYY
                    , NVL(HIT.PERSON_DED_AMT, 0) AS PERSON_DED_AMT
                    , NVL(HIT.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT
                    , NVL(HIT.SUPPORT_DED_AMT, 0) AS SUPPORT_DED_AMT
                    , NVL(HIT.OLD_AGED_DED_AMT, 0) AS OLD_DED_AMT
                    , NVL(HIT.OLD_AGED_DED1_AMT, 0) AS OLD_DED1_AMT
                    , NVL(HIT.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT
                    , NVL(HIT.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT
                    , NVL(HIT.BRING_CHILD_DED_AMT, 0) AS BRING_CHILD_DED_AMT
                    , NVL(HIT.BIRTH_DED_AMT, 0) AS BIRTH_DED_AMT
                    , NVL(HIT.MANY_CHILD_DED_CNT, 0) AS MANY_CHILD_DED_CNT
                    , NVL(HIT.MANY_CHILD_DED_BAS_AMT, 0) AS MANY_CHILD_DED_BAS_AMT
                    , NVL(HIT.MANY_CHILD_DED_ADD_AMT, 0) AS MANY_CHILD_DED_ADD_AMT
                    , NVL(HIT.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT  -- 2013년 추가 : 한부모가족 공제  
                    --> 인원수 --
                    , NVL(HSF1.PERSON_ID, 0) AS PERSON_ID
                    , NVL(HSF1.PERSON_COUNT, 0) AS PERSON_COUNT
                    , NVL(HSF1.SPOUSE_COUNT, 0) AS SPOUSE_COUNT
                    , NVL(HSF1.SUPPORT_COUNT, 0) AS SUPPORT_COUNT
                    , NVL(HSF1.OLD_COUNT, 0) AS OLD_COUNT
                    , NVL(HSF1.OLD_COUNT1, 0) AS OLD_COUNT1
                    , NVL(HSF1.DISABILITY_COUNT, 0) AS DISABILITY_COUNT
                    , NVL(HSF1.WOMAN_COUNT, 0) AS WOMAN_COUNT
                    , NVL(HSF1.CHILD_COUNT, 0) AS CHILD_COUNT
                    , NVL(HSF1.BIRTH_COUNT, 0) AS BIRTH_COUNT
                    , NVL(HSF1.MANY_CHILD_DED_COUNT, 0) AS MANY_CHILD_DED_COUNT 
                    , NVL(HSF1.SINGLE_PARENT_COUNT, 0) AS SINGLE_PARENT_COUNT  
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , (--> 부양가족 자료 
                      SELECT NVL(SX1.YEAR_YYYY, P_YEAR_YYYY) AS YEAR_YYYY
                           , NVL(SX1.PERSON_ID, PM.PERSON_ID) AS PERSON_ID
                           , NVL(SX1.SOB_ID, PM.SOB_ID) AS SOB_ID
                           , NVL(SX1.ORG_ID, PM.ORG_ID) AS ORG_ID
                           , NVL(SX1.PERSON_COUNT, 1) AS PERSON_COUNT   -- 본인--
                           , NVL(SX1.SPOUSE_COUNT, 0) AS SPOUSE_COUNT  -- 배우자--
                           , NVL(SX1.SUPPORT_COUNT, 0) AS SUPPORT_COUNT
                           , NVL(SX1.OLD_COUNT, 0) AS OLD_COUNT
                           , NVL(SX1.OLD_COUNT1, 0) AS OLD_COUNT1
                           , NVL(SX1.DISABILITY_COUNT, 0) AS DISABILITY_COUNT
                           , NVL(SX1.WOMAN_COUNT, 0) AS WOMAN_COUNT
                           , NVL(SX1.CHILD_COUNT, 0) AS CHILD_COUNT
                           , NVL(SX1.BIRTH_COUNT, 0) AS BIRTH_COUNT -- 출산/입양자;
                           , NVL(SX1.MANY_CHILD_DED_COUNT, 0) AS MANY_CHILD_DED_COUNT
                           , NVL(SX1.SINGLE_PARENT_COUNT, 0) AS SINGLE_PARENT_COUNT  -- 2013년 추가 : 한부모가족공제  
                        FROM HRM_PERSON_MASTER PM
                          , (  
                              SELECT HSF.YEAR_YYYY
                                   , HSF.PERSON_ID
                                   , HSF.SOB_ID
                                   , HSF.ORG_ID
                                   , SUM(CASE
                                            WHEN HSF.BASE_YN = 'Y' AND HSF.RELATION_CODE = '0' THEN 1
                                            ELSE 0
                                          END) AS PERSON_COUNT  -- 본인--
                                   , SUM(CASE
                                            WHEN HSF.BASE_YN = 'Y' AND HSF.RELATION_CODE = '3' THEN 1
                                            ELSE 0
                                          END) AS SPOUSE_COUNT  -- 배우자--
                                   , SUM(CASE
                                            WHEN HSF.BASE_YN = 'Y' AND HSF.RELATION_CODE NOT IN ('0', '3') THEN 1
                                            ELSE 0
                                          END) AS SUPPORT_COUNT  -- 부양가족 -- 
                                   -- 추가공제 -- 
                                   , SUM(DECODE(HSF.OLD_YN, 'Y', 1, 0)) AS OLD_COUNT
                                   , SUM(DECODE(HSF.OLD1_YN, 'Y', 1, 0)) AS OLD_COUNT1
                                   , SUM(CASE
                                            WHEN HSF.BASE_YN = 'Y' AND HSF.DISABILITY_YN = 'Y' THEN 1
                                            ELSE 0
                                          END) AS DISABILITY_COUNT  -- 장애인  
                                   , SUM(CASE
                                            WHEN HSF.SINGLE_PARENT_DED_YN = 'Y' THEN 0
                                            WHEN HSF.WOMAN_YN = 'Y' THEN 1 
                                            ELSE 0
                                          END) AS WOMAN_COUNT  -- 부녀자 : 한부모가족일 경우 한부모가족 적용  
                                   , SUM(DECODE(HSF.CHILD_YN, 'Y', 1, 0)) AS CHILD_COUNT  -- 자녀양육  
                                   , SUM(DECODE(HSF.BIRTH_YN, 'Y', 1, 0)) AS BIRTH_COUNT -- 출산/입양자;
                                   , SUM(CASE
                                            WHEN HSF.BASE_YN = 'Y' AND HSF.RELATION_CODE = '4' AND
                                                 EAPP_REGISTER_AGE_F(HSF.REPRE_NUM, P_STD_DATE, 0) <= V_MANY_CHILD_DED_AGE THEN 1
                                            ELSE 0
                                          END) MANY_CHILD_DED_COUNT  -- 다자녀  
                                    , SUM(DECODE(HSF.SINGLE_PARENT_DED_YN, 'Y', 1, 0)) AS SINGLE_PARENT_COUNT -- 한부모가족공제;
                                FROM HRA_SUPPORT_FAMILY HSF
                               WHERE HSF.YEAR_YYYY      = P_YEAR_YYYY
                                 AND HSF.PERSON_ID      = P_PERSON_ID
                                 AND HSF.SOB_ID         = P_SOB_ID
                                 AND HSF.ORG_ID         = P_ORG_ID
                                 AND HSF.REPRE_NUM      IS NOT NULL
                               GROUP BY HSF.YEAR_YYYY
                                   , HSF.PERSON_ID
                                   , HSF.SOB_ID
                                   , HSF.ORG_ID
                               ) SX1
                      WHERE PM.PERSON_ID      = SX1.PERSON_ID(+)
                        AND PM.PERSON_ID      = P_PERSON_ID
                     ) HSF1
                WHERE HIT.YEAR_YYYY     = HSF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HSF1.SOB_ID
                  AND HIT.ORG_ID        = HSF1.ORG_ID
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
                ) 
    LOOP
      -- 다자녀가구 추가공제  
      IF C1.MANY_CHILD_DED_COUNT > 2 THEN
        V_MANY_CHILD_COUNT := C1.MANY_CHILD_DED_COUNT;
        V_MANY_CHILD_DED   := C1.MANY_CHILD_DED_BAS_AMT + (C1.MANY_CHILD_DED_ADD_AMT * (C1.MANY_CHILD_DED_COUNT - 2));
      ELSIF C1.MANY_CHILD_DED_COUNT = 2 THEN
        V_MANY_CHILD_COUNT := C1.MANY_CHILD_DED_COUNT;
        V_MANY_CHILD_DED   := C1.MANY_CHILD_DED_BAS_AMT;
      ELSE
        V_MANY_CHILD_COUNT := 0;
        V_MANY_CHILD_DED   := 0;
      END IF;
      V_SUPP_FAMILY_AMT := C1.PERSON_DED_AMT * C1.PERSON_COUNT; -- 본인 ;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.SPOUSE_DED_AMT * C1.SPOUSE_COUNT); -- 배우자;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.SUPPORT_DED_AMT * C1.SUPPORT_COUNT); -- 부양가족;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.OLD_DED_AMT * C1.OLD_COUNT); -- 추가-경로우대;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.OLD_DED1_AMT * C1.OLD_COUNT1); -- 추가-경로우대1;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.DISABILITY_DED_AMT * C1.DISABILITY_COUNT); -- 추가-장애인;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.WOMAN_DED_AMT * C1.WOMAN_COUNT); -- 추가-부녀세대 ;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.BRING_CHILD_DED_AMT * C1.CHILD_COUNT); -- 추가-자녀양육비;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.BIRTH_DED_AMT * C1.BIRTH_COUNT); -- 추가-출산/입양자;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + V_MANY_CHILD_DED; -- 추가-다자녀가구;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.SINGLE_PARENT_DED_AMT * C1.SINGLE_PARENT_COUNT); -- 추가-한부모가족공제;

      --> 인적공제 UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.PER_DED_AMT           = NVL(C1.PERSON_DED_AMT, 0) * NVL(C1.PERSON_COUNT, 1)
           , HA.SPOUSE_DED_AMT        = NVL(C1.SPOUSE_DED_AMT, 0) * C1.SPOUSE_COUNT
           , HA.SUPP_DED_COUNT        = NVL(C1.SUPPORT_COUNT, 0)
           , HA.SUPP_DED_AMT          = NVL(C1.SUPPORT_DED_AMT, 0) * C1.SUPPORT_COUNT
           , HA.OLD_DED_COUNT         = NVL(C1.OLD_COUNT, 0)
           , HA.OLD_DED_AMT           = NVL(C1.OLD_DED_AMT, 0) * C1.OLD_COUNT
           , HA.OLD_DED_COUNT1        = NVL(C1.OLD_COUNT1, 0)
           , HA.OLD_DED_AMT1          = NVL(C1.OLD_DED1_AMT, 0) * C1.OLD_COUNT1
           , HA.DISABILITY_DED_COUNT  = NVL(C1.DISABILITY_COUNT, 0)
           , HA.DISABILITY_DED_AMT    = NVL(C1.DISABILITY_DED_AMT, 0) * C1.DISABILITY_COUNT
           , HA.WOMAN_DED_AMT         = NVL(C1.WOMAN_DED_AMT, 0) * C1.WOMAN_COUNT
           , HA.CHILD_DED_COUNT       = NVL(C1.CHILD_COUNT, 0)
           , HA.CHILD_DED_AMT         = NVL(C1.BRING_CHILD_DED_AMT, 0) * C1.CHILD_COUNT
           , HA.BIRTH_DED_COUNT       = NVL(C1.BIRTH_COUNT, 0)
           , HA.BIRTH_DED_AMT         = NVL(C1.BIRTH_DED_AMT, 0) * C1.BIRTH_COUNT
           , HA.MANY_CHILD_DED_COUNT  = NVL(V_MANY_CHILD_COUNT, 0)
           , HA.MANY_CHILD_DED_AMT    = NVL(V_MANY_CHILD_DED, 0)
           , HA.SINGLE_PARENT_DED_AMT = NVL(C1.SINGLE_PARENT_DED_AMT, 0) * C1.SINGLE_PARENT_COUNT -- 추가-한부모가족공제;
       WHERE HA.YEAR_YYYY             = P_YEAR_YYYY
         AND HA.PERSON_ID             = P_PERSON_ID
         AND HA.SOB_ID                = P_SOB_ID
         AND HA.ORG_ID                = P_ORG_ID
       ;
    END LOOP C1;
    O_STATUS := 'S';
    RETURN NVL(V_SUPP_FAMILY_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Support Family Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END SUPP_FAMILY_CAL;

  -- 5. 보험료 공제;
  FUNCTION ETC_INSUR_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_TOTAL_INSUR_AMT  NUMBER := 0; -- 기타보험 총 합계 
    V_ETC_INSUR_AMT    NUMBER := 0; -- 보장성보험료 공제 
    V_DISABILITY_INSUR_AMT NUMBER := 0; -- 장애보험료 공제 
  BEGIN
    O_STATUS := 'F';
    -- 연말정산 처리기준 중 보험료 관련 항목--
    FOR C1 IN (SELECT HIT.YEAR_YYYY
                    , NVL(HIT.ETC_INSUR_LMT, 0) AS ETC_INSUR_LMT
                    , NVL(HIT.DISABILITY_INSUR_LMT, 0) AS DISABILITY_INSUR_LMT
                    --> 보험료--
                    , NVL(HSF1.ETC_ANNU_INSURE_AMT, 0) ETC_ANNU_INSURE_AMT
                    , NVL(HSF1.ETC_HIRE_MEDIC_INSURE_AMT, 0) ETC_HIRE_MEDIC_INSURE_AMT
                    , NVL(HSF2.INSURE_SUM, 0) GUAR_INSURE_AMT
                    , NVL(HSF2.DISABILITY_INSURE_SUM, 0) DISABILITY_INSURE_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --> 정산기초자료 조회  
                      SELECT HF.YEAR_YYYY
                           , HF.PERSON_ID
                           , HF.SOB_ID
                           , HF.ORG_ID
                           , HF.ANNU_INSUR_AMT AS ETC_ANNU_INSURE_AMT    -- 기타연금보험.
                           , HF.HIRE_MEDIC_INSUR_AMT AS ETC_HIRE_MEDIC_INSURE_AMT    -- 기타고용의료.
                        FROM HRA_FOUNDATION HF
                      WHERE HF.YEAR_YYYY     = P_YEAR_YYYY
                        AND HF.PERSON_ID     = P_PERSON_ID
                        AND HF.SOB_ID        = P_SOB_ID
                        AND HF.ORG_ID        = P_ORG_ID
                     ) HSF1
                   , ( --  부양가족 보장성 보험료, 장애보험료 조회 
                      SELECT HSF.YEAR_YYYY
                           , HSF.PERSON_ID
                           , HSF.SOB_ID
                           , HSF.ORG_ID
                           , SUM(NVL(HSF.INSURE_AMT, 0) + NVL(HSF.ETC_INSURE_AMT, 0)) AS INSURE_SUM
                           , SUM(NVL(HSF.DISABILITY_INSURE_AMT, 0) + NVL(HSF.ETC_DISABILITY_INSURE_AMT, 0)) AS DISABILITY_INSURE_SUM
                        FROM HRA_SUPPORT_FAMILY HSF
                      WHERE HSF.YEAR_YYYY    = P_YEAR_YYYY
                        AND HSF.PERSON_ID    = P_PERSON_ID
                        AND HSF.SOB_ID       = P_SOB_ID
                        AND HSF.ORG_ID       = P_ORG_ID
                        AND HSF.REPRE_NUM    IS NOT NULL
                      GROUP BY HSF.YEAR_YYYY
                           , HSF.PERSON_ID
                           , HSF.SOB_ID
                           , HSF.ORG_ID
                     ) HSF2
              WHERE HIT.YEAR_YYYY       = HSF1.YEAR_YYYY(+)
                AND HIT.SOB_ID          = HSF1.SOB_ID(+)
                AND HIT.ORG_ID          = HSF1.ORG_ID(+)
                AND HIT.YEAR_YYYY       = HSF2.YEAR_YYYY(+)
                AND HIT.SOB_ID          = HSF2.SOB_ID(+)
                AND HIT.ORG_ID          = HSF2.ORG_ID(+)
                AND HIT.YEAR_YYYY       = P_YEAR_YYYY
                AND HIT.SOB_ID          = P_SOB_ID
                AND HIT.ORG_ID          = P_ORG_ID
              ) 
    LOOP
      -- 보장보험 한도 적용
      IF C1.ETC_INSUR_LMT < C1.GUAR_INSURE_AMT THEN
        V_ETC_INSUR_AMT := C1.ETC_INSUR_LMT;
      ELSE
        V_ETC_INSUR_AMT := C1.GUAR_INSURE_AMT;
      END IF;
      -- 장애보험 한도 적용  
      IF C1.DISABILITY_INSUR_LMT < C1.DISABILITY_INSURE_AMT THEN
        V_DISABILITY_INSUR_AMT := C1.DISABILITY_INSUR_LMT;
      ELSE
        V_DISABILITY_INSUR_AMT := C1.DISABILITY_INSURE_AMT;
      END IF;
      V_TOTAL_INSUR_AMT := V_ETC_INSUR_AMT + V_DISABILITY_INSUR_AMT +
                           C1.ETC_ANNU_INSURE_AMT +
                           C1.ETC_HIRE_MEDIC_INSURE_AMT;

      --> 보험료 UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.ANNU_INSUR_AMT   = NVL(HA.ANNU_INSUR_AMT, 0) + C1.ETC_ANNU_INSURE_AMT
           , HA.HIRE_INSUR_AMT   = NVL(HA.HIRE_INSUR_AMT, 0) + C1.ETC_HIRE_MEDIC_INSURE_AMT
           , HA.GUAR_INSUR_AMT   = V_ETC_INSUR_AMT
           , HA.DISABILITY_INSUR_AMT = V_DISABILITY_INSUR_AMT
       WHERE HA.YEAR_YYYY        = P_YEAR_YYYY
         AND HA.PERSON_ID        = P_PERSON_ID
         AND HA.SOB_ID           = P_SOB_ID
         AND HA.ORG_ID           = P_ORG_ID
      ;
    END LOOP C1;
    O_STATUS := 'S';
    RETURN NVL(V_TOTAL_INSUR_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'ETC Inusrance Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END ETC_INSUR_CAL;

  -- 6. 의료비 공제;
  FUNCTION MEDIC_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER
  AS
    V_MED_TOTAL_AMT       NUMBER := 0;  -- 의료비 총 공제 
    V_MED_PER_AMT         NUMBER := 0;  -- 의료비 본인/장애자/경로 공제액        
    V_MED_SUPP_AMT        NUMBER := 0;  -- 의료비 부양가족 
    
    V_DISABILITY_MED_AMT  NUMBER := 0;  -- 의료비 공제 : 장애자  
    V_ETC_MEDIC_AMT       NUMBER := 0;  -- 의료비 공제 : 기타  
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.MEDIC_DED_STD, 0) AS MEDIC_DED_STD
                    , NVL(HIT.MEDIC_DED_LMT, 0) AS MEDIC_DED_LMT
                    --> 의료비                           
                    , NVL(HSF1.PER_MEDI_SUM, 0) AS PER_MEDI_SUM
                    , NVL(HSF1.OLD_MEDI_SUM, 0) AS OLD_MEDI_SUM
                    , NVL(HSF1.DISABILITY_MEDI_SUM, 0) AS DISABILITY_MEDI_SUM
                    , NVL(HSF1.SUPP_MEDI_SUM, 0) AS SUPP_MEDI_SUM
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , (SELECT HSF.YEAR_YYYY
                          , HSF.SOB_ID
                          , HSF.ORG_ID
                          , HSF.PERSON_ID
                          , SUM(CASE
                                  WHEN HSF.RELATION_CODE = '0' AND HSF.DISABILITY_YN = 'Y' THEN 0
                                  WHEN HSF.RELATION_CODE = '0' THEN NVL(HSF.MEDICAL_AMT, 0) + NVL(HSF.ETC_MEDICAL_AMT, 0)        
                                  ELSE 0
                                END) AS PER_MEDI_SUM
                          , SUM(CASE
                                  WHEN HSF.RELATION_CODE = '0' THEN 0
                                  WHEN 'Y' IN (HSF.OLD_YN, HSF.OLD1_YN) AND HSF.DISABILITY_YN <> 'Y' 
                                    THEN NVL(HSF.MEDICAL_AMT, 0) + NVL(HSF.ETC_MEDICAL_AMT, 0)
                                  ELSE 0
                                END) AS OLD_MEDI_SUM
                          , SUM(CASE
                                  WHEN HSF.DISABILITY_YN = 'Y' THEN NVL(HSF.MEDICAL_AMT, 0) + NVL(HSF.ETC_MEDICAL_AMT, 0)
                                  ELSE 0
                                END) AS DISABILITY_MEDI_SUM
                          , SUM(CASE
                                  WHEN HSF.RELATION_CODE = '0' THEN 0
                                  WHEN 'Y' IN (HSF.OLD_YN, HSF.OLD1_YN) THEN 0
                                  WHEN HSF.DISABILITY_YN = 'Y' THEN 0
                                  ELSE NVL(HSF.MEDICAL_AMT, 0) + NVL(HSF.ETC_MEDICAL_AMT, 0)
                                END) AS SUPP_MEDI_SUM
                        FROM HRA_SUPPORT_FAMILY HSF
                      WHERE HSF.YEAR_YYYY    = P_YEAR_YYYY
                        AND HSF.PERSON_ID    = P_PERSON_ID
                        AND HSF.SOB_ID       = P_SOB_ID
                        AND HSF.ORG_ID       = P_ORG_ID                           
                        AND HSF.REPRE_NUM IS NOT NULL
                      GROUP BY HSF.YEAR_YYYY, HSF.PERSON_ID, HSF.SOB_ID, HSF.ORG_ID
                     ) HSF1
                WHERE HIT.YEAR_YYYY     = HSF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HSF1.SOB_ID
                  AND HIT.ORG_ID        = HSF1.ORG_ID
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
                ) 
    LOOP
      -- 본인공제 
      V_MED_PER_AMT := C1.PER_MEDI_SUM + C1.OLD_MEDI_SUM + C1.DISABILITY_MEDI_SUM;
          
      -- 부양가족 공제  
      V_MED_SUPP_AMT := C1.SUPP_MEDI_SUM - TRUNC(P_TOTAL_PAY * (C1.MEDIC_DED_STD / 100));
      IF C1.MEDIC_DED_LMT < V_MED_SUPP_AMT THEN
        V_MED_SUPP_AMT := C1.MEDIC_DED_LMT;
      END IF;    
      
      -- 의료비 공제 계산   
      V_MED_TOTAL_AMT := V_MED_PER_AMT + V_MED_SUPP_AMT;
      IF V_MED_TOTAL_AMT < 0 THEN
        V_MED_TOTAL_AMT := 0;
      END IF;
      
      -- 2013.12.31 전호수 추가 : 장애인 의료비와 기타 의료비 구분 -- 
      V_DISABILITY_MED_AMT := C1.DISABILITY_MEDI_SUM;
      V_ETC_MEDIC_AMT      := 0;
      IF NVL(V_DISABILITY_MED_AMT, 0) < NVL(V_MED_TOTAL_AMT, 0) THEN
        V_ETC_MEDIC_AMT      := NVL(V_MED_TOTAL_AMT, 0) - NVL(V_DISABILITY_MED_AMT, 0);
      ELSE
        V_DISABILITY_MED_AMT := NVL(V_MED_TOTAL_AMT, 0);
      END IF;
    END LOOP C1;
    
    --> 의료비 UPDATE 
    UPDATE HRA_YEAR_ADJUSTMENT HA
       SET HA.MEDIC_AMT             = NVL(V_MED_TOTAL_AMT, 0)
         , HA.DISABILITY_MEDIC_AMT  = NVL(V_DISABILITY_MED_AMT, 0)
         , HA.ETC_MEDIC_AMT         = NVL(V_ETC_MEDIC_AMT, 0) 
     WHERE HA.YEAR_YYYY       = P_YEAR_YYYY
       AND HA.PERSON_ID       = P_PERSON_ID
       AND HA.SOB_ID          = P_SOB_ID
       AND HA.ORG_ID          = P_ORG_ID
    ;
    O_STATUS := 'S';
    RETURN NVL(V_MED_TOTAL_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Medical Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END MEDIC_CAL;

  -- 7. 교육비 공제;
  FUNCTION EDUCATION_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_EDU_TOTAL_AMT       NUMBER := 0;  -- 총 교육비 
    V_PER_EDU_AMT         NUMBER := 0;  -- 교육비 공제 : 본인 교육비  
    V_DISABILITY_EDU_AMT  NUMBER := 0;  -- 교육비 공제 : 장애인 교육비  
    V_CHILD_EDU_AMT       NUMBER := 0;  -- 교육비 공제 : 취학전 아동 교육비  
    V_HIGH_EDU_AMT        NUMBER := 0;  -- 교육비 공제 : 초중고교 교육비  
    V_COLL_EDU_AMT        NUMBER := 0;  -- 교육비 공제 : 대학교 교육비  
    
    V_DISABILITY_EDU_SUM  NUMBER := 0;  -- 교육비 공제 누계 : 장애인 교육비    
    V_ETC_EDU_SUM         NUMBER := 0;  -- 교육비 공제 누계 : 기타  
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.PER_EDU, 0) AS PER_EDU
                    , NVL(HIT.KIND_EDU, 0) AS KIND_EDU
                    , NVL(HIT.STUD_EDU, 0) AS STUD_EDU
                    , NVL(HIT.UNIV_EDU, 0) AS UNIV_EDU
                    --> 교육비         
                    , NVL(HSF1.PERSON_ID, 0) AS PERSON_ID
                    , NVL(HSF1.PER_EDU_COUNT, 0) AS PER_EDU_COUNT
                    , NVL(HSF1.PER_EDU_AMT, 0) AS PER_EDU_AMT
                    , NVL(HSF1.DISABILITY_EDU_COUNT, 0) AS DISABILITY_EDU_COUNT
                    , NVL(HSF1.DISABILITY_EDU_AMT, 0) AS DISABILITY_EDU_AMT
                    , NVL(HSF1.CHILD_EDU_COUNT, 0) AS CHILD_EDU_COUNT
                    , NVL(HSF1.CHILD_EDU_AMT, 0) AS CHILD_EDU_AMT
                    , NVL(HSF1.HIGH_EDU_COUNT, 0) AS HIGH_EDU_COUNT
                    , NVL(HSF1.HIGH_EDU_AMT, 0) AS HIGH_EDU_AMT
                    , NVL(HSF1.COLL_EDU_COUNT, 0) AS COLL_EDU_COUNT
                    , NVL(HSF1.COLL_EDU_AMT, 0) AS COLL_EDU_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , (SELECT HSF.YEAR_YYYY
                          , HSF.PERSON_ID
                          , HSF.SOB_ID
                          , HSF.ORG_ID
                          , HSF.REPRE_NUM
                          , SUM(DECODE(HSF.EDUCATION_TYPE, '10', 1, 0)) PER_EDU_COUNT
                          , SUM(DECODE(HSF.EDUCATION_TYPE, '10', NVL(HSF.EDUCATION_AMT, 0) + NVL(HSF.ETC_EDUCATION_AMT, 0), 0)) PER_EDU_AMT
                          , SUM(DECODE(HSF.EDUCATION_TYPE, '20', 1, 0)) DISABILITY_EDU_COUNT
                          , SUM(DECODE(HSF.EDUCATION_TYPE, '20', NVL(HSF.EDUCATION_AMT, 0) + NVL(HSF.ETC_EDUCATION_AMT, 0), 0)) DISABILITY_EDU_AMT
                          , SUM(DECODE(HSF.EDUCATION_TYPE, '30', 1, 0)) CHILD_EDU_COUNT
                          , SUM(DECODE(HSF.EDUCATION_TYPE, '30', NVL(HSF.EDUCATION_AMT, 0) + NVL(HSF.ETC_EDUCATION_AMT, 0), 0)) CHILD_EDU_AMT
                          , SUM(DECODE(HSF.EDUCATION_TYPE, '40', 1, 0)) HIGH_EDU_COUNT
                          , SUM(DECODE(HSF.EDUCATION_TYPE, '40', NVL(HSF.EDUCATION_AMT, 0) + NVL(HSF.ETC_EDUCATION_AMT, 0), 0)) HIGH_EDU_AMT
                          , SUM(DECODE(HSF.EDUCATION_TYPE, '50', 1, 0)) COLL_EDU_COUNT
                          , SUM(DECODE(HSF.EDUCATION_TYPE, '50', NVL(HSF.EDUCATION_AMT, 0) + NVL(HSF.ETC_EDUCATION_AMT, 0), 0)) COLL_EDU_AMT
                        FROM HRA_SUPPORT_FAMILY HSF
                      WHERE HSF.YEAR_YYYY    = P_YEAR_YYYY
                        AND HSF.PERSON_ID    = P_PERSON_ID
                        AND NVL(HSF.EDUCATION_AMT, 0) + NVL(HSF.ETC_EDUCATION_AMT, 0) > 0
                        AND HSF.REPRE_NUM IS NOT NULL
                      GROUP BY HSF.YEAR_YYYY, HSF.PERSON_ID, HSF.REPRE_NUM, HSF.SOB_ID, HSF.ORG_ID
                     ) HSF1
                WHERE HIT.YEAR_YYYY   = HSF1.YEAR_YYYY
                  AND HIT.SOB_ID      = HSF1.SOB_ID
                  AND HIT.ORG_ID      = HSF1.ORG_ID
                  AND HIT.YEAR_YYYY   = P_YEAR_YYYY
                  AND HIT.SOB_ID      = P_SOB_ID
                  AND HIT.ORG_ID      = P_ORG_ID
               ) 
    LOOP
      -- 본인공제 
      IF C1.PER_EDU < C1.PER_EDU_AMT THEN
        V_PER_EDU_AMT := C1.PER_EDU;
      ELSE
        V_PER_EDU_AMT := C1.PER_EDU_AMT;
      END IF;
      -- 장애인 공제  
      IF C1.PER_EDU < C1.DISABILITY_EDU_AMT THEN
        V_DISABILITY_EDU_AMT := C1.PER_EDU;
      ELSE
        V_DISABILITY_EDU_AMT := C1.DISABILITY_EDU_AMT;
      END IF;
      -- 취학전 아동 공제  
      IF C1.KIND_EDU < C1.CHILD_EDU_AMT THEN
        V_CHILD_EDU_AMT := C1.KIND_EDU;
      ELSE
        V_CHILD_EDU_AMT := C1.CHILD_EDU_AMT;
      END IF;
      -- 초중고교 공제  
      IF C1.STUD_EDU < C1.HIGH_EDU_AMT THEN
        V_HIGH_EDU_AMT := C1.STUD_EDU;
      ELSE
        V_HIGH_EDU_AMT := C1.HIGH_EDU_AMT;
      END IF;
      -- 대학생 공제  
      IF C1.UNIV_EDU < C1.COLL_EDU_AMT THEN
        V_COLL_EDU_AMT := C1.UNIV_EDU;
      ELSE
        V_COLL_EDU_AMT := C1.COLL_EDU_AMT;
      END IF;
      
      -- 2013.12.31 전호수 추가 : 장애인 교육비 누계 -- 
      V_DISABILITY_EDU_SUM := NVL(V_DISABILITY_EDU_SUM, 0) + NVL(V_DISABILITY_EDU_AMT, 0);
      
      -- 교육비 합계 
      V_EDU_TOTAL_AMT := NVL(V_EDU_TOTAL_AMT, 0) + NVL(V_PER_EDU_AMT, 0) + NVL(V_DISABILITY_EDU_AMT, 0) +
                         NVL(V_CHILD_EDU_AMT, 0) + NVL(V_HIGH_EDU_AMT, 0) + NVL(V_COLL_EDU_AMT, 0); 
    END LOOP C1;
    
    -- 2013.12.31 전호수 추가 : 장애인 의료비와 기타 의료비 구분 -- 
    V_ETC_EDU_SUM          := 0;
    IF NVL(V_DISABILITY_EDU_SUM, 0) < NVL(V_EDU_TOTAL_AMT, 0) THEN
      V_ETC_EDU_SUM        := NVL(V_EDU_TOTAL_AMT, 0) - NVL(V_DISABILITY_EDU_SUM, 0);
    ELSE
      V_DISABILITY_EDU_SUM := NVL(V_EDU_TOTAL_AMT, 0);
    END IF;     
      
    --> 교육비  UPDATE 
    UPDATE HRA_YEAR_ADJUSTMENT HA
       SET HA.EDUCATION_AMT             = NVL(V_EDU_TOTAL_AMT, 0)
         , HA.DISABILITY_EDUCATION_AMT  = NVL(V_DISABILITY_EDU_SUM, 0)
         , HA.ETC_EDUCATION_AMT         = NVL(V_ETC_EDU_SUM, 0) 
     WHERE HA.YEAR_YYYY     = P_YEAR_YYYY
       AND HA.PERSON_ID     = P_PERSON_ID
       AND HA.SOB_ID        = P_SOB_ID
       AND HA.ORG_ID        = P_ORG_ID
     ;
    O_STATUS := 'S'; 
    RETURN NVL(V_EDU_TOTAL_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Education Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END EDUCATION_CAL;

  -- 8-1. 주택자금 공제(주택임차차입금원리금상환액);
  FUNCTION HOUSE_FUND_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER
  AS
    V_HOUSE_INTER_AMT             NUMBER := 0;  -- 주택임차차입금원리금상환(40%);
    
    V_HOUSE_INTER_TOT_AMT_ETC     NUMBER := 0;  -- 주택임차차입금원리금상환(40%) 총누계;
    V_HOUSE_INTER_AMT_ETC         NUMBER := 0;  -- 주택임차차입금원리금상환(40%) 거주자;
  BEGIN
    O_STATUS := 'F';
    -- 주택임차차입금 원리금 상환액 : 대출기관 -- 
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.HOUSE_INTER_RATE, 0) HOUSE_INTER_RATE  -- 주택임차차입금 원리금상환액 공제율;
                    , NVL(HIT.HOUSE_AMT_LMT, 0) HOUSE_AMT_LMT  -- -- 주택자금 한도;
                    
                    --> 주택자금;
                    , NVL(HF1.HOUSE_ADD_AMT, 0) HOUSE_ADD_AMT  -- 주택임차차입금 원리금상환액공제;
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , (SELECT HF.YEAR_YYYY
                          , HF.PERSON_ID
                          , HF.SOB_ID
                          , HF.ORG_ID
                          , HF.HOUSE_ADD_AMT
                          , HF.LONG_HOUSE_INTER_AMT
                          , HF.LONG_HOUSE_INTER_AMT_1
                          , HF.LONG_HOUSE_INTER_AMT_2
                          , HF.HOUSE_MONTHLY_AMT 
                          , HF.LONG_HOUSE_INTER_AMT_3_FIX
                          , HF.LONG_HOUSE_INTER_AMT_3_ETC
                        FROM HRA_FOUNDATION HF
                      WHERE HF.YEAR_YYYY        = P_YEAR_YYYY
                        AND HF.PERSON_ID        = P_PERSON_ID
                        AND HF.SOB_ID           = P_SOB_ID
                        AND HF.ORG_ID           = P_ORG_ID                        
                     ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
               ) 
    LOOP
      -- 주택임차차입금원리금상환액; 
      V_HOUSE_INTER_AMT := TRUNC(C1.HOUSE_ADD_AMT * (C1.HOUSE_INTER_RATE / 100));
      IF NVL(C1.HOUSE_AMT_LMT, 0) < NVL(V_HOUSE_INTER_AMT, 0) THEN
        V_HOUSE_INTER_AMT := NVL(C1.HOUSE_AMT_LMT, 0);
      END IF;
      
      --> 주택자금   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.HOUSE_FUND_AMT        = NVL(HA.HOUSE_FUND_AMT, 0) + NVL(V_HOUSE_INTER_AMT, 0)
           , HA.HOUSE_INTER_AMT       = NVL(V_HOUSE_INTER_AMT, 0)
       WHERE HA.YEAR_YYYY             = P_YEAR_YYYY
         AND HA.PERSON_ID             = P_PERSON_ID
         AND HA.SOB_ID                = P_SOB_ID
         AND HA.ORG_ID                = P_ORG_ID
      ;      
    END LOOP C1;
    
    -- 주택임차차입금 원리금 상환액 : 거주자 -- 
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.HOUSE_INTER_RATE, 0) AS HOUSE_INTER_RATE  -- 주택임차차입금 원리금상환액 공제율;
                    , NVL(HIT.HOUSE_AMT_LMT, 0) AS HOUSE_AMT_LMT  -- -- 주택자금 한도;
                    
                    --> 주택자금;
                    , HF1.HOUSE_LEASE_ID 
                    , NVL(HF1.LOAN_AMT, 0) AS LOAN_AMT  -- 주택임차차입금 원리금상환액공제 : 거주자;
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , (SELECT HLI.HOUSE_LEASE_ID 
                            , HLI.YEAR_YYYY
                            , HLI.PERSON_ID
                            , HLI.SOB_ID
                            , HLI.ORG_ID
                            , HLI.LEASE_TERM_FR
                            , NVL(HLI.LOAN_AMT, 0) + NVL(HLI.LOAN_INTEREST_AMT, 0) AS LOAN_AMT
                          FROM HRA_HOUSE_LEASE_INFO HLI  
                        WHERE HLI.HOUSE_LEASE_TYPE  = '20'  -- 주택임차차입금 원리금 상환액 : 거주자  
                          AND HLI.YEAR_YYYY         = P_YEAR_YYYY
                          AND HLI.PERSON_ID         = P_PERSON_ID
                          AND HLI.SOB_ID            = P_SOB_ID
                          AND HLI.ORG_ID            = P_ORG_ID                                         
                     ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
               ORDER BY HF1.LEASE_TERM_FR 
               ) 
    LOOP
      V_HOUSE_INTER_AMT_ETC := 0;
      -- 주택임차차입금원리금상환액; 
      V_HOUSE_INTER_AMT_ETC := TRUNC(C1.LOAN_AMT * (C1.HOUSE_INTER_RATE / 100));
      IF NVL(C1.HOUSE_AMT_LMT, 0) < (NVL(V_HOUSE_INTER_AMT, 0) + 
                                     NVL(V_HOUSE_INTER_TOT_AMT_ETC, 0) + 
                                     NVL(V_HOUSE_INTER_AMT_ETC, 0)) THEN
        V_HOUSE_INTER_AMT_ETC := NVL(C1.HOUSE_AMT_LMT, 0) - 
                                 NVL(V_HOUSE_INTER_AMT, 0) - 
                                 NVL(V_HOUSE_INTER_TOT_AMT_ETC, 0);
      END IF;
      -- 총누계 -- 
      V_HOUSE_INTER_TOT_AMT_ETC := NVL(V_HOUSE_INTER_TOT_AMT_ETC, 0) + NVL(V_HOUSE_INTER_AMT_ETC, 0);
      
      -- 공제금액 UPDATE -- 
      UPDATE HRA_HOUSE_LEASE_INFO HLI
         SET HLI.HOUSE_DED_AMT      = V_HOUSE_INTER_AMT_ETC
       WHERE HLI.HOUSE_LEASE_ID     = C1.HOUSE_LEASE_ID
      ;
    END LOOP C1;
    
    --> 주택자금   UPDATE : 주택임차차입금 원리금 상환액 - 거주자 -- 
    IF NVL(V_HOUSE_INTER_TOT_AMT_ETC, 0) > 0 THEN
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.HOUSE_FUND_AMT        = NVL(HA.HOUSE_FUND_AMT, 0) + NVL(V_HOUSE_INTER_TOT_AMT_ETC, 0)
           , HA.HOUSE_INTER_AMT_ETC   = NVL(V_HOUSE_INTER_TOT_AMT_ETC, 0)
       WHERE HA.YEAR_YYYY             = P_YEAR_YYYY
         AND HA.PERSON_ID             = P_PERSON_ID
         AND HA.SOB_ID                = P_SOB_ID
         AND HA.ORG_ID                = P_ORG_ID
      ;      
    END IF;
    O_STATUS := 'S';
    RETURN (NVL(V_HOUSE_INTER_AMT, 0) + NVL(V_HOUSE_INTER_TOT_AMT_ETC, 0));
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'House Fund Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END HOUSE_FUND_CAL;

  -- 8-2. 주택자금 공제(월세소득공제);
  FUNCTION HOUSE_FUND_MONTHLY_RENT_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER
  AS
    V_HOUSE_MONTHLY_AMT           NUMBER := 0;  -- 월세소득공제금액.
    V_HOUSE_MONTHLY_TOT_AMT       NUMBER := 0;  -- 월세소득공제 누적금액.
    V_HOUSE_TOT_DED_AMT           NUMBER := 0;  -- 주택자금 누적공제금액.
  BEGIN
    O_STATUS := 'F';
    BEGIN
      -- 주택자금공제금액 => 한도 적용 위해;
      SELECT NVL(YA.HOUSE_INTER_AMT, 0) +
             NVL(YA.HOUSE_INTER_AMT_ETC, 0) AS HOUSE_DED_AMT  -- 주택임차차입금 원리금상환액공제(대출기관 + 거주자);
        INTO V_HOUSE_TOT_DED_AMT
        FROM HRA_YEAR_ADJUSTMENT YA
      WHERE YA.YEAR_YYYY          = P_YEAR_YYYY
        AND YA.PERSON_ID          = P_PERSON_ID
        AND YA.SOB_ID             = P_SOB_ID
        AND YA.ORG_ID             = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_HOUSE_TOT_DED_AMT := 0;
    END;
       
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.HOUSE_AMT_LMT, 0) AS HOUSE_AMT_LMT  -- -- 주택자금 한도;
                    , NVL(HIT.HOUSE_MONTHLY_STD, 0) AS HOUSE_MONTHLY_STD  -- 월세소득기준금액.
                    , NVL(HIT.HOUSE_MONTHLY_RATE, 0) AS HOUSE_MONTHLY_RATE  -- 월세소득공제액.
                    
                    --> 주택자금;
                    , HF1.HOUSE_LEASE_ID 
                    , NVL(HF1.MONTLY_LEASE_AMT, 0) AS HOUSE_MONTHLY_AMT  -- 월세소득공제;
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( SELECT HLI.HOUSE_LEASE_ID 
                            , HLI.YEAR_YYYY
                            , HLI.PERSON_ID
                            , HLI.SOB_ID
                            , HLI.ORG_ID
                            , HLI.LEASE_TERM_FR
                            , HLI.MONTLY_LEASE_AMT  -- 월세액  
                          FROM HRA_HOUSE_LEASE_INFO HLI  
                        WHERE HLI.HOUSE_LEASE_TYPE  = '10'  -- 월세  
                          AND HLI.YEAR_YYYY         = P_YEAR_YYYY
                          AND HLI.PERSON_ID         = P_PERSON_ID
                          AND HLI.SOB_ID            = P_SOB_ID
                          AND HLI.ORG_ID            = P_ORG_ID                  
                     ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
                ORDER BY HF1.LEASE_TERM_FR
               ) 
    LOOP
      -- 저소득근로자 월세소득공제;
      V_HOUSE_MONTHLY_AMT := 0;
      
      -- 주택마련저축 및 주택임차차입금 소득공제금액 합계액 포함;
      IF P_TOTAL_PAY <= NVL(C1.HOUSE_MONTHLY_STD, 0) THEN
        V_HOUSE_MONTHLY_AMT := TRUNC(C1.HOUSE_MONTHLY_AMT * (C1.HOUSE_MONTHLY_RATE / 100));                
        IF NVL(C1.HOUSE_AMT_LMT, 0) < (NVL(V_HOUSE_TOT_DED_AMT, 0) + 
                                       NVL(V_HOUSE_MONTHLY_TOT_AMT, 0) +
                                       NVL(V_HOUSE_MONTHLY_AMT, 0)) THEN
          V_HOUSE_MONTHLY_AMT := NVL(C1.HOUSE_AMT_LMT, 0) - 
                                 NVL(V_HOUSE_TOT_DED_AMT, 0) - 
                                 NVL(V_HOUSE_MONTHLY_TOT_AMT, 0);
        END IF;
        V_HOUSE_MONTHLY_TOT_AMT := NVL(V_HOUSE_MONTHLY_TOT_AMT, 0) + NVL(V_HOUSE_MONTHLY_AMT, 0);
        
        -- 공제금액 UPDATE -- 
        UPDATE HRA_HOUSE_LEASE_INFO HLI
           SET HLI.HOUSE_DED_AMT      = V_HOUSE_MONTHLY_AMT
         WHERE HLI.HOUSE_LEASE_ID     = C1.HOUSE_LEASE_ID
        ;
      END IF;            
    END LOOP C1;
    
    --> 주택자금   UPDATE 
    UPDATE HRA_YEAR_ADJUSTMENT HA
       SET HA.HOUSE_FUND_AMT        = NVL(HA.HOUSE_FUND_AMT, 0) + NVL(V_HOUSE_MONTHLY_TOT_AMT, 0)
         , HA.HOUSE_MONTHLY_AMT     = NVL(V_HOUSE_MONTHLY_TOT_AMT, 0)
     WHERE HA.YEAR_YYYY             = P_YEAR_YYYY
       AND HA.PERSON_ID             = P_PERSON_ID
       AND HA.SOB_ID                = P_SOB_ID
       AND HA.ORG_ID                = P_ORG_ID
    ;
    O_STATUS := 'S';
    RETURN NVL(V_HOUSE_MONTHLY_TOT_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'House Monthly Rental Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END HOUSE_FUND_MONTHLY_RENT_CAL;
            
  -- 8-3. 주택자금 공제(장기주택이자상환액);
  FUNCTION HOUSE_FUND_LONG_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER
  AS
    V_HOUSE_DED_AMT               NUMBER := 0;  -- 주택마련저축공제;
    V_TOTAL_HOUSE_DED_AMT         NUMBER := 0;  -- 주택공제 누적공제금액.
    
    V_LONG_HOUSE_PROF_AMT         NUMBER := 0;  -- 장기주택저당차입금이자상환액(10년)
    V_LONG_HOUSE_PROF_AMT_1       NUMBER := 0;  -- 장기주택저당차입금이자상환액(15년)
    V_LONG_HOUSE_PROF_AMT_2       NUMBER := 0;  -- 장기주택저당차입금이자상환액(30년)
    V_LONG_HOUSE_PROF_AMT_3_FIX   NUMBER := 0;  -- 장기주택저당차입금이자상환액(2012년 이후 고정금리등)
    V_LONG_HOUSE_PROF_AMT_3_ETC   NUMBER := 0;  -- 장기주택저당차입금이자상환액(2012년 이후 기타)
  BEGIN
    BEGIN
      -- 장기주택저당 차입금 이자상환공제금액 => 한도 적용 위해;
      SELECT NVL(YA.HOUSE_INTER_AMT, 0) + NVL(YA.HOUSE_INTER_AMT_ETC, 0) +    -- 주택임차차이금원리금상환액공제(대출기관 + 거주자);
             NVL(YA.HOUSE_MONTHLY_AMT, 0) +                                   -- 월세액;
             NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0) +                               -- 주택청약저축(가);
             NVL(YA.HOUSE_APP_SAVE_AMT, 0) +                                  -- 주택청약종합저축(나);
             NVL(YA.HOUSE_SAVE_AMT, 0) +                                      -- 장기주택마련저축공제액(다);
             NVL(YA.WORKER_HOUSE_SAVE_AMT, 0) AS HOUSE_DED_AMT  -- 근로자주택마련저축(라) ;
        INTO V_HOUSE_DED_AMT
        FROM HRA_YEAR_ADJUSTMENT YA
      WHERE YA.YEAR_YYYY          = P_YEAR_YYYY
        AND YA.PERSON_ID          = P_PERSON_ID
        AND YA.SOB_ID             = P_SOB_ID
        AND YA.ORG_ID             = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_HOUSE_DED_AMT := 0;
    END;
    V_TOTAL_HOUSE_DED_AMT := NVL(V_HOUSE_DED_AMT, 0);
       
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.LONG_HOUSE_PROF_LMT, 0) LONG_HOUSE_PROF_LMT  -- 장기주택저당차입금이자상환액 한도(10);
                    , NVL(HIT.HOUSE_TOTAL_LMT, 0) HOUSE_TOTAL_LMT  -- 장기주택저당차입금이자상환액 총한도(10);
                    , NVL(HIT.LONG_HOUSE_PROF_LMT_1, 0) LONG_HOUSE_PROF_LMT_1  -- 장기주택저당차입금이자상환액 한도(15);
                    , NVL(HIT.HOUSE_TOTAL_LMT_1, 0) HOUSE_TOTAL_LMT_1  -- 장기주택저당차입금이자상환액 총한도(15);
                    , NVL(HIT.LONG_HOUSE_PROF_LMT_2, 0) LONG_HOUSE_PROF_LMT_2  -- 장기주택저당차입금이자상환액 한도(30);
                    , NVL(HIT.HOUSE_TOTAL_LMT_2, 0) HOUSE_TOTAL_LMT_2  -- 장기주택저당차입금이자상환액 총한도(30);
                    
                    , NVL(HIT.LONG_HOUSE_PROF_LMT_3_FIX, 0) LONG_HOUSE_PROF_LMT_3_FIX  -- 장기주택저당차입금 이자상환액(2012년 이후 - 고정금리등);
                    , NVL(HIT.HOUSE_TOTAL_LMT_3_FIX, 0) HOUSE_TOTAL_LMT_3_FIX  -- 주택자금 총공제한도(2012년 이후 - 고정금리등);
                    , NVL(HIT.LONG_HOUSE_PROF_LMT_3_ETC, 0) LONG_HOUSE_PROF_LMT_3_ETC  -- 장기주택저당차입금 이자상환액(2012년 이후 - 기타);
                    , NVL(HIT.HOUSE_TOTAL_LMT_3_ETC, 0) HOUSE_TOTAL_LMT_3_ETC  -- 주택자금 총공제한도(2012년 이후 - 기타);
                    
                    --> 주택자금;
                    , NVL(HF1.LONG_HOUSE_INTER_AMT, 0) LONG_HOUSE_INTER_AMT  -- 장기주택저당차입금이자상환액(10);
                    , NVL(HF1.LONG_HOUSE_INTER_AMT_1, 0) LONG_HOUSE_INTER_AMT_1  -- 장기주택저당차입금이자상환액(15);
                    , NVL(HF1.LONG_HOUSE_INTER_AMT_2, 0) LONG_HOUSE_INTER_AMT_2  -- 장기주택저당차입금이자상환액(30);
                    , NVL(HF1.LONG_HOUSE_INTER_AMT_3_FIX, 0) AS LONG_HOUSE_INTER_AMT_3_FIX  -- 장기주택저당차입금 이자상환액(2012년 이후 - 고정금리등);
                    , NVL(HF1.LONG_HOUSE_INTER_AMT_3_ETC, 0) AS LONG_HOUSE_INTER_AMT_3_ETC  -- 장기주택저당차입금 이자상환액(2012년 이후 - 기타);
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , (SELECT HF.YEAR_YYYY
                          , HF.PERSON_ID
                          , HF.SOB_ID
                          , HF.ORG_ID
                          , HF.LONG_HOUSE_INTER_AMT
                          , HF.LONG_HOUSE_INTER_AMT_1
                          , HF.LONG_HOUSE_INTER_AMT_2
                          , HF.LONG_HOUSE_INTER_AMT_3_FIX
                          , HF.LONG_HOUSE_INTER_AMT_3_ETC
                        FROM HRA_FOUNDATION HF
                      WHERE HF.YEAR_YYYY        = P_YEAR_YYYY
                        AND HF.PERSON_ID        = P_PERSON_ID
                        AND HF.SOB_ID           = P_SOB_ID
                        AND HF.ORG_ID           = P_ORG_ID                        
                     ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
               ) 
    LOOP
      -- 장기주택저당차입금 이자상환액공제(10년) ; 
      IF NVL(C1.LONG_HOUSE_INTER_AMT, 0) > 0 THEN
        -- 600만원 한도 계산;
        V_LONG_HOUSE_PROF_AMT := NVL(C1.LONG_HOUSE_INTER_AMT, 0);
        IF NVL(C1.LONG_HOUSE_PROF_LMT, 0) < NVL(V_LONG_HOUSE_PROF_AMT, 0) THEN
          V_LONG_HOUSE_PROF_AMT := NVL(C1.LONG_HOUSE_PROF_LMT, 0);
        END IF;
        -- 총 주택자금 한도 설정(600만); 
        IF NVL(C1.HOUSE_TOTAL_LMT, 0) < (NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT, 0)) THEN
          V_LONG_HOUSE_PROF_AMT := NVL(C1.HOUSE_TOTAL_LMT, 0) - NVL(V_TOTAL_HOUSE_DED_AMT, 0);
        END IF;
        V_TOTAL_HOUSE_DED_AMT := NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT, 0);
      END IF;
      
      -- 장기주택저당차입금 이자상환액공제(15년) ; 
      IF NVL(C1.LONG_HOUSE_INTER_AMT_1, 0) > 0 THEN
        -- 1,000만원 한도 계산;
        V_LONG_HOUSE_PROF_AMT_1 := NVL(C1.LONG_HOUSE_INTER_AMT_1, 0);
        IF NVL(C1.LONG_HOUSE_PROF_LMT_1, 0) < NVL(V_LONG_HOUSE_PROF_AMT_1, 0) THEN
          V_LONG_HOUSE_PROF_AMT_1 := NVL(C1.LONG_HOUSE_PROF_LMT_1, 0);
        END IF;
        -- 총 주택자금 한도 설정(1,000만); 
        IF NVL(C1.HOUSE_TOTAL_LMT_1, 0) < (NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT_1, 0)) THEN
          V_LONG_HOUSE_PROF_AMT_1 := NVL(C1.HOUSE_TOTAL_LMT_1, 0) - NVL(V_TOTAL_HOUSE_DED_AMT, 0);
        END IF;
        V_TOTAL_HOUSE_DED_AMT := NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT_1, 0);
      END IF;
      
      -- 장기주택저당차입금 이자상환액공제(30년) ; 
      IF NVL(C1.LONG_HOUSE_INTER_AMT_2, 0) > 0 THEN 
        -- 1,500만원 한도 계산;
        V_LONG_HOUSE_PROF_AMT_2 := NVL(C1.LONG_HOUSE_INTER_AMT_2, 0);
        IF NVL(C1.LONG_HOUSE_PROF_LMT_2, 0) < NVL(V_LONG_HOUSE_PROF_AMT_2, 0) THEN
          V_LONG_HOUSE_PROF_AMT_2 := NVL(C1.LONG_HOUSE_PROF_LMT_2, 0);
        END IF;
        -- 총 주택자금 한도 설정(1,500만); 
        IF NVL(C1.HOUSE_TOTAL_LMT_2, 0) < (NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT_2, 0)) THEN
          V_LONG_HOUSE_PROF_AMT_2 := NVL(C1.HOUSE_TOTAL_LMT_2, 0) - NVL(V_TOTAL_HOUSE_DED_AMT, 0);
        END IF;
        V_TOTAL_HOUSE_DED_AMT := NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT_2, 0);
      END IF;
      
      -- 장기주택저당차입금 이자상환액(2012년 이후 - 고정금리등);
      IF NVL(C1.LONG_HOUSE_INTER_AMT_3_FIX, 0) > 0 THEN 
        V_LONG_HOUSE_PROF_AMT_3_FIX := NVL(C1.LONG_HOUSE_INTER_AMT_3_FIX, 0);
        IF NVL(C1.LONG_HOUSE_PROF_LMT_3_FIX, 0) < NVL(V_LONG_HOUSE_PROF_AMT_3_FIX, 0) THEN
          V_LONG_HOUSE_PROF_AMT_3_FIX := NVL(C1.LONG_HOUSE_PROF_LMT_3_FIX, 0);
        END IF;
        -- 총 주택자금 한도 설정; 
        IF NVL(C1.HOUSE_TOTAL_LMT_3_FIX, 0) < (NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT_3_FIX, 0)) THEN
          V_LONG_HOUSE_PROF_AMT_3_FIX := NVL(C1.HOUSE_TOTAL_LMT_3_FIX, 0) - NVL(V_TOTAL_HOUSE_DED_AMT, 0);
        END IF;
        V_TOTAL_HOUSE_DED_AMT := NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT_3_FIX, 0);
      END IF;
      
      -- 장기주택저당차입금 이자상환액(2012년 이후 - 기타);
      IF NVL(C1.LONG_HOUSE_INTER_AMT_3_ETC, 0) > 0 THEN 
        V_LONG_HOUSE_PROF_AMT_3_ETC := NVL(C1.LONG_HOUSE_INTER_AMT_3_ETC, 0);
        IF NVL(C1.LONG_HOUSE_PROF_LMT_3_ETC, 0) < NVL(V_LONG_HOUSE_PROF_AMT_3_ETC, 0) THEN
          V_LONG_HOUSE_PROF_AMT_3_ETC := NVL(C1.LONG_HOUSE_PROF_LMT_3_ETC, 0);
        END IF;
        -- 총 주택자금 한도 설정; 
        IF NVL(C1.HOUSE_TOTAL_LMT_3_ETC, 0) < (NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT_3_ETC, 0)) THEN
          V_LONG_HOUSE_PROF_AMT_3_ETC := NVL(C1.HOUSE_TOTAL_LMT_3_ETC, 0) - NVL(V_TOTAL_HOUSE_DED_AMT, 0);
        END IF;
        V_TOTAL_HOUSE_DED_AMT := NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT_3_ETC, 0);
      END IF;
      
      --> 주택자금   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.HOUSE_FUND_AMT            = NVL(HA.HOUSE_FUND_AMT, 0) + (NVL(V_TOTAL_HOUSE_DED_AMT, 0)- NVL(V_HOUSE_DED_AMT, 0))
           , HA.LONG_HOUSE_PROF_AMT       = NVL(V_LONG_HOUSE_PROF_AMT, 0)
           , HA.LONG_HOUSE_PROF_AMT_1     = NVL(V_LONG_HOUSE_PROF_AMT_1, 0)
           , HA.LONG_HOUSE_PROF_AMT_2     = NVL(V_LONG_HOUSE_PROF_AMT_2, 0)
           , HA.LONG_HOUSE_PROF_AMT_3_FIX = NVL(V_LONG_HOUSE_PROF_AMT_3_FIX, 0)
           , HA.LONG_HOUSE_PROF_AMT_3_ETC = NVL(V_LONG_HOUSE_PROF_AMT_3_ETC, 0)
       WHERE HA.YEAR_YYYY             = P_YEAR_YYYY
         AND HA.PERSON_ID             = P_PERSON_ID
         AND HA.SOB_ID                = P_SOB_ID
         AND HA.ORG_ID                = P_ORG_ID
      ;
    END LOOP C1;
    V_TOTAL_HOUSE_DED_AMT := NVL(V_TOTAL_HOUSE_DED_AMT, 0) - NVL(V_HOUSE_DED_AMT, 0);
    
    O_STATUS := 'S';
    RETURN NVL(V_TOTAL_HOUSE_DED_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'House Fund Long Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END HOUSE_FUND_LONG_CAL;            
            
  -- 8-4. 주택마련저축소득공제;
  FUNCTION HOUSE_SAVE_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_HOUSE_DED_AMT               NUMBER := 0;  -- 주택자금 누적공제금액.
    V_TOTAL_AMT                   NUMBER := 0;  -- 주택마련저축소득공제 누적금액.
    
    V_SUM_HOUSE_SAVING_AMT        NUMBER := 0;  -- 주택청약저축(가) 누적금액.
    V_SUM_HOUSE_SAVING_ALL_AMT    NUMBER := 0;  -- 주택청약종합저축(나) 누적금액.
    V_SUM_LONG_HOUSE_SAVING_AMT   NUMBER := 0;  -- 장기주택마련저축공제액(다) 누적금액.
    V_SUM_WORKER_HOUSE_SAVING_AMT NUMBER := 0;  -- 근로자주택마련저축(라) 누적금액.
    
    V_HOUSE_SAVING_AMT            NUMBER := 0;  -- 주택청약저축(가).
    V_HOUSE_SAVING_ALL_AMT        NUMBER := 0;  -- 주택청약종합저축(나).
    V_LONG_HOUSE_SAVING_AMT       NUMBER := 0;  -- 장기주택마련저축공제액(다).
    V_WORKER_HOUSE_SAVING_AMT     NUMBER := 0;  -- 근로자주택마련저축(라).
  BEGIN
    O_STATUS := 'F';
    BEGIN
      -- 주택자금공제금액 => 한도 적용 위해;
      SELECT ( NVL(YA.HOUSE_INTER_AMT, 0) + NVL(YA.HOUSE_INTER_AMT_ETC, 0)) +  -- 주택임차차입금 원리금상환액공제(대출기관 + 거주자) ;
             NVL(YA.HOUSE_MONTHLY_AMT, 0) AS HOUSE_DED_AMT -- 월세액공제;
        INTO V_HOUSE_DED_AMT
        FROM HRA_YEAR_ADJUSTMENT YA
      WHERE YA.YEAR_YYYY          = P_YEAR_YYYY
        AND YA.PERSON_ID          = P_PERSON_ID
        AND YA.SOB_ID             = P_SOB_ID
        AND YA.ORG_ID             = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_HOUSE_DED_AMT := 0;
    END;
    V_TOTAL_AMT := NVL(V_HOUSE_DED_AMT, 0);
    
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.HOUSE_SAVING_RATE, 0) AS HOUSE_SAVING_RATE  -- 주택마련저축소득공제 --
                    , NVL(HIT.HOUSE_SAVING_LMT, 0) AS HOUSE_SAVING_LMT    -- 주택마련저축소득공제 한도 --
                    , NVL(HIT.WORKER_HOUSE_SAVING_RATE, 0) AS WORKER_HOUSE_SAVING_RATE  -- 근로자주택마련저축 공제 --
                    , NVL(HIT.WORKER_HOUSE_SAVING_LMT, 0) AS WORKER_HOUSE_SAVING_LMT  -- 근로자주택마련저축 공제 한도 -- 
                    , NVL(HIT.LONG_HOUSE_SAVING_RATE, 0) AS LONG_HOUSE_SAVING_RATE  -- 장기주택마련저축 공제 -- 
                    , NVL(HIT.LONG_HOUSE_SAVING_LMT, 0) AS LONG_HOUSE_SAVING_LMT  -- 장기주택마련저축 공제 한도 --
                    , NVL(HIT.HOUSE_SAVING_ALL_RATE, 0) AS HOUSE_SAVING_ALL_RATE  -- 주택청약종합저축 공제 --
                    , NVL(HIT.HOUSE_SAVING_ALL_LMT, 0) AS HOUSE_SAVING_ALL_LMT  -- 주택청약종합저축 공제 한도 --
                    , NVL(HIT.HOUSE_AMT_LMT, 0) AS HOUSE_AMT_LMT  -- 전체 한도 --
                    --> 주택마련저축금액.
                    , HF1.SAVING_INFO_ID
                    , HF1.SAVING_TYPE
                    , NVL(HF1.SAVING_AMOUNT, 0) HOUSE_SAVE_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , (--  연말정산 기초자료  조회  
                      SELECT HSI.SAVING_INFO_ID
                          , HSI.YEAR_YYYY
                          , HSI.SOB_ID
                          , HSI.ORG_ID
                          , HSI.SAVING_TYPE
                          , HSI.SAVING_AMOUNT
                        FROM HRA_SAVING_INFO HSI
                          , HRM_SAVING_TYPE_V ST
                      WHERE HSI.SAVING_TYPE             = ST.SAVING_TYPE
                        AND HSI.SOB_ID                  = ST.SOB_ID
                        AND HSI.ORG_ID                  = ST.ORG_ID
                        AND HSI.YEAR_YYYY               = P_YEAR_YYYY
                        AND HSI.SOB_ID                  = P_SOB_ID
                        AND HSI.ORG_ID                  = P_ORG_ID
                        AND HSI.PERSON_ID               = P_PERSON_ID
                        AND HSI.SAVING_TYPE             IN ('31', '32', '33', '34')  -- 주택저축.
                     ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
               ) 
    LOOP
      V_HOUSE_SAVING_AMT            := 0;  -- 주택청약저축(가).
      V_HOUSE_SAVING_ALL_AMT        := 0;  -- 주택청약종합저축(나).
      V_LONG_HOUSE_SAVING_AMT       := 0;  -- 장기주택마련저축공제액(다).
      V_WORKER_HOUSE_SAVING_AMT     := 0;  -- 근로자주택마련저축(라).
      IF C1.SAVING_TYPE = '31' THEN
        -- 주택청약저축(가).
        V_HOUSE_SAVING_AMT := TRUNC(NVL(C1.HOUSE_SAVE_AMT, 0) * (NVL(C1.HOUSE_SAVING_RATE, 0) / 100));
        IF NVL(C1.HOUSE_SAVING_LMT, 0) < NVL(V_SUM_HOUSE_SAVING_AMT, 0) + NVL(V_HOUSE_SAVING_AMT, 0) THEN
          V_HOUSE_SAVING_AMT := NVL(C1.HOUSE_SAVING_LMT, 0) - NVL(V_SUM_HOUSE_SAVING_AMT, 0);
        END IF;
        IF NVL(C1.HOUSE_AMT_LMT, 0) < NVL(V_TOTAL_AMT, 0) + NVL(V_HOUSE_SAVING_AMT, 0) THEN
          V_HOUSE_SAVING_AMT := NVL(C1.HOUSE_AMT_LMT, 0) - NVL(V_TOTAL_AMT, 0);
        END IF;
        V_TOTAL_AMT := NVL(V_TOTAL_AMT, 0) + NVL(V_HOUSE_SAVING_AMT, 0);
        V_SUM_HOUSE_SAVING_AMT := NVL(V_SUM_HOUSE_SAVING_AMT, 0) + NVL(V_HOUSE_SAVING_AMT, 0);  -- 주택청약저축(가) 누적금액.
      ELSIF C1.SAVING_TYPE = '32' THEN
        -- 주택청약종합저축(나).
        V_HOUSE_SAVING_ALL_AMT := TRUNC(NVL(C1.HOUSE_SAVE_AMT, 0) * (NVL(C1.HOUSE_SAVING_ALL_RATE, 0) / 100));
        IF NVL(C1.HOUSE_SAVING_ALL_LMT, 0) < NVL(V_SUM_HOUSE_SAVING_ALL_AMT, 0) + NVL(V_HOUSE_SAVING_ALL_AMT, 0) THEN
          V_HOUSE_SAVING_ALL_AMT := NVL(C1.HOUSE_SAVING_ALL_LMT, 0) - NVL(V_SUM_HOUSE_SAVING_ALL_AMT, 0);
        END IF;
        IF NVL(C1.HOUSE_AMT_LMT, 0) < NVL(V_TOTAL_AMT, 0) + NVL(V_HOUSE_SAVING_ALL_AMT, 0) THEN
          V_HOUSE_SAVING_ALL_AMT := NVL(C1.HOUSE_AMT_LMT, 0) - NVL(V_TOTAL_AMT, 0);
        END IF;
        V_TOTAL_AMT := NVL(V_TOTAL_AMT, 0) + NVL(V_HOUSE_SAVING_ALL_AMT, 0);
        V_SUM_HOUSE_SAVING_ALL_AMT := NVL(V_SUM_HOUSE_SAVING_ALL_AMT, 0) + NVL(V_HOUSE_SAVING_ALL_AMT, 0);  -- 주택청약종합저축(나) 누적금액.
      ELSIF C1.SAVING_TYPE = '33' THEN
        -- 장기주택마련저축공제액(다).
        V_LONG_HOUSE_SAVING_AMT := TRUNC(NVL(C1.HOUSE_SAVE_AMT, 0) * (NVL(C1.LONG_HOUSE_SAVING_RATE , 0) / 100));
        IF NVL(C1.LONG_HOUSE_SAVING_LMT, 0) < NVL(V_SUM_LONG_HOUSE_SAVING_AMT, 0) + NVL(V_LONG_HOUSE_SAVING_AMT, 0) THEN
          V_LONG_HOUSE_SAVING_AMT := NVL(C1.LONG_HOUSE_SAVING_LMT, 0) - NVL(V_SUM_LONG_HOUSE_SAVING_AMT, 0);
        END IF;
        IF NVL(C1.HOUSE_AMT_LMT, 0) < NVL(V_TOTAL_AMT, 0) + NVL(V_LONG_HOUSE_SAVING_AMT, 0) THEN
          V_LONG_HOUSE_SAVING_AMT := NVL(C1.HOUSE_AMT_LMT, 0) - NVL(V_TOTAL_AMT, 0);
        END IF; 
        V_TOTAL_AMT := NVL(V_TOTAL_AMT, 0) + NVL(V_LONG_HOUSE_SAVING_AMT, 0);
        V_SUM_LONG_HOUSE_SAVING_AMT := NVL(V_SUM_LONG_HOUSE_SAVING_AMT, 0) + NVL(V_LONG_HOUSE_SAVING_AMT, 0);  -- 장기주택마련저축공제액(다) 누적금액.
      ELSIF C1.SAVING_TYPE = '34' THEN
        -- 근로자주택마련저축(라).
        V_WORKER_HOUSE_SAVING_AMT := TRUNC(NVL(C1.HOUSE_SAVE_AMT, 0) * (NVL(C1.WORKER_HOUSE_SAVING_RATE, 0) / 100));
        IF NVL(C1.WORKER_HOUSE_SAVING_LMT, 0) < NVL(V_SUM_WORKER_HOUSE_SAVING_AMT, 0) + NVL(V_WORKER_HOUSE_SAVING_AMT, 0) THEN
          V_WORKER_HOUSE_SAVING_AMT := NVL(C1.WORKER_HOUSE_SAVING_LMT, 0) - NVL(V_SUM_WORKER_HOUSE_SAVING_AMT, 0);
        END IF;
        IF NVL(C1.HOUSE_AMT_LMT, 0) < NVL(V_TOTAL_AMT, 0) + NVL(V_WORKER_HOUSE_SAVING_AMT, 0) THEN
          V_WORKER_HOUSE_SAVING_AMT := NVL(C1.HOUSE_AMT_LMT, 0) - NVL(V_TOTAL_AMT, 0);
        END IF; 
        V_TOTAL_AMT := NVL(V_TOTAL_AMT, 0) + NVL(V_WORKER_HOUSE_SAVING_AMT, 0);
        V_SUM_WORKER_HOUSE_SAVING_AMT := NVL(V_SUM_WORKER_HOUSE_SAVING_AMT, 0) + NVL(V_WORKER_HOUSE_SAVING_AMT, 0);  -- 근로자주택마련저축(라) 누적금액.
      END IF;
      -- 개인연금저축 공제금액 UPDATE.
      UPDATE HRA_SAVING_INFO HSI
        SET HSI.SAVING_DED_AMOUNT  = CASE
                                       WHEN C1.SAVING_TYPE = '31' THEN V_HOUSE_SAVING_AMT
                                       WHEN C1.SAVING_TYPE = '32' THEN V_HOUSE_SAVING_ALL_AMT
                                       WHEN C1.SAVING_TYPE = '33' THEN V_LONG_HOUSE_SAVING_AMT
                                       WHEN C1.SAVING_TYPE = '34' THEN V_WORKER_HOUSE_SAVING_AMT
                                     END
      WHERE HSI.SAVING_INFO_ID     = C1.SAVING_INFO_ID
      ;
    END LOOP C1;
    
    --> 주택자금   UPDATE 
    UPDATE HRA_YEAR_ADJUSTMENT HA
      SET HA.HOUSE_FUND_AMT         = NVL(HA.HOUSE_FUND_AMT, 0) + (NVL(V_TOTAL_AMT, 0) - NVL(V_HOUSE_DED_AMT, 0))
        , HA.HOUSE_APP_DEPOSIT_AMT  = NVL(V_SUM_HOUSE_SAVING_AMT, 0)
        , HA.HOUSE_APP_SAVE_AMT     = NVL(V_SUM_HOUSE_SAVING_ALL_AMT, 0)
        , HA.HOUSE_SAVE_AMT         = NVL(V_SUM_LONG_HOUSE_SAVING_AMT, 0)
        , HA.WORKER_HOUSE_SAVE_AMT  = NVL(V_SUM_WORKER_HOUSE_SAVING_AMT, 0)
    WHERE HA.YEAR_YYYY     = P_YEAR_YYYY
      AND HA.PERSON_ID     = P_PERSON_ID
      AND HA.SOB_ID        = P_SOB_ID
      AND HA.ORG_ID        = P_ORG_ID
    ;
    O_STATUS := 'S';
    RETURN NVL(V_TOTAL_AMT, 0) - NVL(V_HOUSE_DED_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'House Save Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END HOUSE_SAVE_CAL;

  -- 9. 기부금 공제
  FUNCTION DONATION_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_INCOME_AMT        IN NUMBER
            ) RETURN NUMBER
  AS
    V_DONAT_LMT                 NUMBER := 0;  -- 기부금 한도 설정;
    V_DONAT_TOTAL               NUMBER := 0;  -- 기부금 합계;
    V_LAPSE_DONA_AMT            NUMBER := 0;  -- 소멸금액.
    V_NEXT_DONA_AMT             NUMBER := 0;  -- 이월금액.
    
    -- 기부금 누적 금액;
    V_SUM_TAX_DED_POLI_AMT      NUMBER := 0; -- 세액공제 : 기부 정치자금
    V_SUM_DONAT_POLI            NUMBER := 0; -- 정치기부금; 
    V_SUM_DONAT_ALL             NUMBER := 0; -- 전액 기부금;  
    V_SUM_DONAT_50P             NUMBER := 0; -- 기부금 50% ; 
    V_SUM_DONAT_30P             NUMBER := 0; -- 기부금 30%;
    V_SUM_DONAT_10P             NUMBER := 0; -- 기부금 10% ;  
    V_SUM_DONAT_10P_RELIGION    NUMBER := 0; -- 기부금 10% ;  
    
    -- 기부금 이월금액    
    V_SUM_DONAT_NEXT_POLI       NUMBER := 0; -- 정치기부금; 
    V_SUM_DONAT_NEXT_ALL        NUMBER := 0; -- 전액 기부금;  
    V_SUM_DONAT_NEXT_50P        NUMBER := 0; -- 기부금 50% ; 
    V_SUM_DONAT_NEXT_30P        NUMBER := 0; -- 기부금 30%;
    V_SUM_DONAT_NEXT_10P        NUMBER := 0; -- 기부금 10% ;  
    V_SUM_DONAT_NEXT_10P_REL    NUMBER := 0; -- 기부금 10% ;
    
    -- 건수별;
    V_TAX_DED_POLI_AMT          NUMBER := 0; -- 세액공제 : 기부 정치자금  
    V_DONAT_POLI                NUMBER := 0; -- 정치기부금; 
    V_DONAT_ALL                 NUMBER := 0; -- 전액 기부금;  
    V_DONAT_50P                 NUMBER := 0; -- 기부금 50% ; 
    V_DONAT_30P                 NUMBER := 0; -- 기부금 30%;
    V_DONAT_10P                 NUMBER := 0; -- 기부금 10% ;  
    V_DONAT_10P_RELIGION        NUMBER := 0; -- 기부금 10% ;  
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , HIT.SOB_ID
                    , HIT.ORG_ID
                    , NVL(HIT.LEGAL_GIFT_RATE, 0) AS DONAT_ALL_RATE
                    , NVL(HIT.ASS_GIFT_RATE1, 0) AS DONAT_50P_RATE
                    , NVL(30, 0) AS DONAT_30P_RATE
                    , NVL(HIT.ASS_GIFT_RATE2, 0) AS NO_RELIGION_DONAT_RATE
                    , NVL(HIT.ASS_GIFT_RATE3, 0) AS RELIGION_DONAT_10P_RATE
                    , NVL(HIT.ASS_GIFT_RATE3_1, 0) AS RELIGION_DONAT_10P_RATE_1                    
                    , NVL(HIT.POLI_GIFT_MAX, 0) AS DONAT_POLI_MAX  
                    , NVL(HIT.POLI_GIFT_RATE, 0) AS DONAT_POLI_RATE
                    , NVL(HIT.POLI_GIFT_RATE1, 1) AS DONAT_POLI_RATE1
                  FROM HRA_INCOME_TAX_STANDARD HIT
                WHERE HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
               ) 
    LOOP
      -- 전액 공제 (한도)  ;
      V_DONAT_LMT := 0;
      V_DONAT_LMT := TRUNC(P_INCOME_AMT * (C1.DONAT_ALL_RATE / 100)); -- 전액공제 한도  
      
      -- 1. 정치자금 기부금 공제 
      -- 기부금액이 100,000원 미만인 경우 전액세액공제 대상으로 '0' 
      -- 기부금액이 100,000원 초과한 경우 MIN(기부금액 - 100,000, 근로소득금액) 적용       
      FOR R1 IN ( SELECT DA.DONATION_ADJUSTMENT_ID
                      , DA.YEAR_YYYY
                      , DA.PERSON_ID
                      , DA.SOB_ID
                      , DA.ORG_ID
                      , DA.DONA_YYYY
                      , DA.DONA_TYPE
                      , DA.TOTAL_DONA_AMT
                      , DT.AVAILABLE_YEAR
                    FROM HRA_DONATION_ADJUSTMENT DA
                      , HRM_DONATION_TYPE_V DT
                  WHERE DA.DONA_TYPE              = DT.DONATION_TYPE
                    AND DA.SOB_ID                 = DT.SOB_ID
                    AND DA.ORG_ID                 = DT.ORG_ID
                    AND DA.YEAR_YYYY              = C1.YEAR_YYYY
                    AND DA.PERSON_ID              = P_PERSON_ID
                    AND DA.SOB_ID                 = C1.SOB_ID
                    AND DA.ORG_ID                 = C1.ORG_ID
                    AND DA.DONA_TYPE              = '20'    -- 정치기부금  
                  ORDER BY DA.DONA_TYPE, DA.DONA_YYYY DESC
                 )
      LOOP
        V_TAX_DED_POLI_AMT := NVL(R1.TOTAL_DONA_AMT, 0);        
        IF NVL(C1.DONAT_POLI_MAX, 0) < (NVL(V_SUM_TAX_DED_POLI_AMT, 0) + NVL(V_TAX_DED_POLI_AMT, 0)) THEN
          -- 정치기부금 누적금액이 한도 초과시 한도금액 이상은 정치기부금 설정 
          V_TAX_DED_POLI_AMT := NVL(C1.DONAT_POLI_MAX, 0) - NVL(V_SUM_TAX_DED_POLI_AMT, 0);          
          V_DONAT_POLI       := NVL(R1.TOTAL_DONA_AMT, 0) - NVL(V_TAX_DED_POLI_AMT, 0);
        END IF;        
        -- 세액공제 : 정치 기부금 누적금액;
        V_SUM_TAX_DED_POLI_AMT := NVL(V_SUM_TAX_DED_POLI_AMT, 0) + NVL(V_TAX_DED_POLI_AMT, 0);
        
        -- 기부금 누적.
        V_SUM_DONAT_POLI := NVL(V_SUM_DONAT_POLI, 0) + NVL(V_DONAT_POLI, 0);
        
        -- 공제금액, 소멸금액, 이월금액 처리 --
        V_NEXT_DONA_AMT := 0;
        V_LAPSE_DONA_AMT := 0;
        -- 기부금 한도 초과 금액 계산.
        IF NVL(V_DONAT_LMT, 0) < (NVL(V_SUM_DONAT_POLI, 0) + NVL(V_SUM_TAX_DED_POLI_AMT, 0)) THEN
          V_NEXT_DONA_AMT := (NVL(V_SUM_DONAT_POLI, 0) + NVL(V_SUM_TAX_DED_POLI_AMT, 0)) - NVL(V_DONAT_LMT, 0);
          V_LAPSE_DONA_AMT := 0;
        END IF;
        IF (TO_NUMBER(R1.DONA_YYYY) + NVL(R1.AVAILABLE_YEAR, 0)) > TO_NUMBER(R1.YEAR_YYYY) THEN
          NULL;
        ELSE
          -- 기부금액소멸.
          V_LAPSE_DONA_AMT := V_NEXT_DONA_AMT;
          V_NEXT_DONA_AMT := 0;
        END IF;
        
        -- 기부금조정명세서 UPDATE.
        UPDATE HRA_DONATION_ADJUSTMENT DA
          SET DA.DONA_DED_AMT     = (NVL(V_TAX_DED_POLI_AMT, 0) + NVL(V_DONAT_POLI, 0)) - (NVL(V_NEXT_DONA_AMT, 0) - NVL(V_LAPSE_DONA_AMT, 0))
            , DA.LAPSE_DONA_AMT   = NVL(V_LAPSE_DONA_AMT, 0)
            , DA.NEXT_DONA_AMT    = NVL(V_NEXT_DONA_AMT, 0)
        WHERE DA.DONATION_ADJUSTMENT_ID = R1.DONATION_ADJUSTMENT_ID
        ;
      END LOOP R1;
      -- 정치기부금 공제액.
      V_TAX_DED_POLI_AMT := TRUNC(NVL(V_TAX_DED_POLI_AMT, 0) * NVL(C1.DONAT_POLI_RATE, 0) / C1.DONAT_POLI_RATE1);
      
      -- 정치자금 기부금 법정기부금에 포함해서 처리 위해       
      -- 법정기부금.
      FOR R1 IN ( SELECT DA.DONATION_ADJUSTMENT_ID
                      , DA.YEAR_YYYY
                      , DA.PERSON_ID
                      , DA.SOB_ID
                      , DA.ORG_ID
                      , DA.DONA_YYYY
                      , DA.DONA_TYPE
                      , DA.TOTAL_DONA_AMT
                      , DT.AVAILABLE_YEAR
                    FROM HRA_DONATION_ADJUSTMENT DA
                      , HRM_DONATION_TYPE_V DT
                  WHERE DA.DONA_TYPE              = DT.DONATION_TYPE
                    AND DA.SOB_ID                 = DT.SOB_ID
                    AND DA.ORG_ID                 = DT.ORG_ID
                    AND DA.YEAR_YYYY              = C1.YEAR_YYYY
                    AND DA.PERSON_ID              = P_PERSON_ID
                    AND DA.SOB_ID                 = C1.SOB_ID
                    AND DA.ORG_ID                 = C1.ORG_ID
                    AND DA.DONA_TYPE              = '10'
                  ORDER BY DA.DONA_TYPE, DA.DONA_YYYY DESC
                 )
      LOOP
        V_NEXT_DONA_AMT := 0;
        V_LAPSE_DONA_AMT := 0;
        V_DONAT_ALL := NVL(R1.TOTAL_DONA_AMT, 0); -- 전액공제 금액;  
        IF NVL(V_DONAT_LMT, 0) < (NVL(V_SUM_DONAT_POLI, 0) + NVL(V_SUM_DONAT_ALL, 0)) + NVL(V_DONAT_ALL, 0) THEN
          -- 기부금 한도 초과 금액 계산.
          V_NEXT_DONA_AMT := (NVL(V_SUM_DONAT_POLI, 0) + NVL(V_SUM_DONAT_ALL, 0)) + NVL(V_DONAT_ALL, 0) - NVL(V_DONAT_LMT, 0);
          V_LAPSE_DONA_AMT := 0;
        
          V_DONAT_ALL := NVL(V_DONAT_LMT, 0) - (NVL(V_SUM_DONAT_POLI, 0) + NVL(V_SUM_DONAT_ALL, 0));
        END IF;        
        
        -- 공제금액, 소멸금액, 이월금액 처리 --
        IF (TO_NUMBER(R1.DONA_YYYY) + NVL(R1.AVAILABLE_YEAR, 0)) > TO_NUMBER(R1.YEAR_YYYY) THEN
          NULL;
        ELSE
          -- 기부금액소멸.
          V_LAPSE_DONA_AMT := V_NEXT_DONA_AMT;
          V_NEXT_DONA_AMT := 0;
        END IF;
        -- 누계 -- 
        V_SUM_DONAT_ALL := NVL(V_SUM_DONAT_ALL, 0) + NVL(V_DONAT_ALL, 0);
        V_SUM_DONAT_NEXT_ALL := NVL(V_SUM_DONAT_NEXT_ALL, 0) + NVL(V_NEXT_DONA_AMT, 0);
        
        -- 기부금조정명세서 UPDATE.
        UPDATE HRA_DONATION_ADJUSTMENT DA
          SET DA.DONA_DED_AMT     = NVL(V_DONAT_ALL, 0)
            , DA.LAPSE_DONA_AMT   = NVL(V_LAPSE_DONA_AMT, 0)
            , DA.NEXT_DONA_AMT    = NVL(V_NEXT_DONA_AMT, 0)
        WHERE DA.DONATION_ADJUSTMENT_ID = R1.DONATION_ADJUSTMENT_ID
        ;
      END LOOP R1;
      
      -- 50% 한도(특례기부금, 공익법인기부신탁기부금);  
      V_DONAT_LMT := 0;
      V_DONAT_LMT := TRUNC((NVL(P_INCOME_AMT, 0) - NVL(V_SUM_DONAT_ALL, 0)) * (C1.DONAT_50P_RATE / 100));
      FOR R1 IN ( SELECT DA.DONATION_ADJUSTMENT_ID
                      , DA.YEAR_YYYY
                      , DA.PERSON_ID
                      , DA.SOB_ID
                      , DA.ORG_ID
                      , DA.DONA_YYYY
                      , DA.DONA_TYPE
                      , DA.TOTAL_DONA_AMT
                      , DT.AVAILABLE_YEAR
                    FROM HRA_DONATION_ADJUSTMENT DA
                      , HRM_DONATION_TYPE_V DT
                  WHERE DA.DONA_TYPE              = DT.DONATION_TYPE
                    AND DA.SOB_ID                 = DT.SOB_ID
                    AND DA.ORG_ID                 = DT.ORG_ID
                    AND DA.YEAR_YYYY              = C1.YEAR_YYYY
                    AND DA.PERSON_ID              = P_PERSON_ID
                    AND DA.SOB_ID                 = C1.SOB_ID
                    AND DA.ORG_ID                 = C1.ORG_ID
                    AND DA.DONA_TYPE              IN('30', '31')
                  ORDER BY DA.DONA_TYPE, DA.DONA_YYYY DESC
                 )
      LOOP
        V_NEXT_DONA_AMT := 0;
        V_LAPSE_DONA_AMT := 0;
        V_DONAT_50P := NVL(R1.TOTAL_DONA_AMT, 0); -- 특별공제(50%) 금액;  
        IF NVL(V_DONAT_LMT, 0) < NVL(V_SUM_DONAT_50P, 0) + NVL(V_DONAT_50P, 0) THEN
          -- 기부금 한도 초과 금액 계산.
          V_NEXT_DONA_AMT := NVL(V_SUM_DONAT_50P, 0) + NVL(V_DONAT_50P, 0) - NVL(V_DONAT_LMT, 0);
          V_LAPSE_DONA_AMT := 0;
        
          V_DONAT_50P := NVL(V_DONAT_LMT, 0) - NVL(V_SUM_DONAT_50P, 0);
        END IF;        
        
        -- 공제금액, 소멸금액, 이월금액 처리 --
        IF (TO_NUMBER(R1.DONA_YYYY) + NVL(R1.AVAILABLE_YEAR, 0)) > TO_NUMBER(R1.YEAR_YYYY) THEN
          NULL;
        ELSE
          -- 기부금액소멸.
          V_LAPSE_DONA_AMT := V_NEXT_DONA_AMT;
          V_NEXT_DONA_AMT := 0;
        END IF;
        
        -- 누계 -- 
        V_SUM_DONAT_50P := NVL(V_SUM_DONAT_50P, 0) + NVL(V_DONAT_50P, 0);
        V_SUM_DONAT_NEXT_50P := NVL(V_SUM_DONAT_NEXT_50P, 0) + NVL(V_NEXT_DONA_AMT, 0);
        
        -- 기부금조정명세서 UPDATE.
        UPDATE HRA_DONATION_ADJUSTMENT DA
          SET DA.DONA_DED_AMT     = NVL(V_DONAT_50P, 0)
            , DA.LAPSE_DONA_AMT   = NVL(V_LAPSE_DONA_AMT, 0)
            , DA.NEXT_DONA_AMT    = NVL(V_NEXT_DONA_AMT, 0)
        WHERE DA.DONATION_ADJUSTMENT_ID = R1.DONATION_ADJUSTMENT_ID
        ;
      END LOOP R1;
      
      --30% 공제(우리사주기부금); 
      V_DONAT_LMT := 0;
      V_DONAT_LMT := TRUNC((NVL(P_INCOME_AMT, 0) - NVL(V_SUM_DONAT_ALL, 0) - 
                            NVL(V_SUM_DONAT_50P, 0)) * (C1.DONAT_30P_RATE / 100));
      FOR R1 IN ( SELECT DA.DONATION_ADJUSTMENT_ID
                      , DA.YEAR_YYYY
                      , DA.PERSON_ID
                      , DA.SOB_ID
                      , DA.ORG_ID
                      , DA.DONA_YYYY
                      , DA.DONA_TYPE
                      , DA.TOTAL_DONA_AMT
                      , DT.AVAILABLE_YEAR
                    FROM HRA_DONATION_ADJUSTMENT DA
                      , HRM_DONATION_TYPE_V DT
                  WHERE DA.DONA_TYPE              = DT.DONATION_TYPE
                    AND DA.SOB_ID                 = DT.SOB_ID
                    AND DA.ORG_ID                 = DT.ORG_ID
                    AND DA.YEAR_YYYY              = C1.YEAR_YYYY
                    AND DA.PERSON_ID              = P_PERSON_ID
                    AND DA.SOB_ID                 = C1.SOB_ID
                    AND DA.ORG_ID                 = C1.ORG_ID
                    AND DA.DONA_TYPE              = '42'
                  ORDER BY DA.DONA_TYPE, DA.DONA_YYYY DESC
                 )
      LOOP
        V_NEXT_DONA_AMT := 0;
        V_LAPSE_DONA_AMT := 0;
        V_DONAT_30P := NVL(R1.TOTAL_DONA_AMT, 0); -- 우리사주(30%) 금액;  
        IF NVL(V_DONAT_LMT, 0) < NVL(V_SUM_DONAT_30P, 0) + NVL(V_DONAT_30P, 0) THEN
          -- 기부금 한도 초과 금액 계산.
          V_NEXT_DONA_AMT := NVL(V_SUM_DONAT_30P, 0) + NVL(V_DONAT_30P, 0) - NVL(V_DONAT_LMT, 0);
          V_LAPSE_DONA_AMT := 0;
        
          V_DONAT_30P := NVL(V_DONAT_LMT, 0) - NVL(V_SUM_DONAT_30P, 0);
        END IF;
        
        -- 공제금액, 소멸금액, 이월금액 처리 --
        IF (TO_NUMBER(R1.DONA_YYYY) + NVL(R1.AVAILABLE_YEAR, 0)) > TO_NUMBER(R1.YEAR_YYYY) THEN
          NULL;
        ELSE
          -- 기부금액소멸.
          V_LAPSE_DONA_AMT := V_NEXT_DONA_AMT;
          V_NEXT_DONA_AMT := 0;
        END IF;
        
        -- 누계 -- 
        V_SUM_DONAT_30P := NVL(V_SUM_DONAT_30P, 0) + NVL(V_DONAT_30P, 0);
        V_SUM_DONAT_NEXT_30P := NVL(V_SUM_DONAT_NEXT_30P, 0) + NVL(V_NEXT_DONA_AMT, 0);
        
        -- 기부금조정명세서 UPDATE.
        UPDATE HRA_DONATION_ADJUSTMENT DA
          SET DA.DONA_DED_AMT     = NVL(V_DONAT_30P, 0)
            , DA.LAPSE_DONA_AMT   = NVL(V_LAPSE_DONA_AMT, 0)
            , DA.NEXT_DONA_AMT    = NVL(V_NEXT_DONA_AMT, 0)
        WHERE DA.DONATION_ADJUSTMENT_ID = R1.DONATION_ADJUSTMENT_ID
        ;
      END LOOP R1;
      
      -- 종교단체 기부금 합계 조회 => 종교단체 기부금이 있으면 계산식이 달라짐.
      BEGIN
        SELECT SUM(DECODE(DT.DONATION_TYPE, '40', DA.TOTAL_DONA_AMT, 0)) AS DONAT_10P
            , SUM(DECODE(DT.DONATION_TYPE, '41', DA.TOTAL_DONA_AMT, 0)) AS DONAT_10P_RELIGION
          INTO V_DONAT_10P
            , V_DONAT_10P_RELIGION
          FROM HRA_DONATION_ADJUSTMENT DA
            , HRM_DONATION_TYPE_V DT
        WHERE DA.DONA_TYPE              = DT.DONATION_TYPE
          AND DA.SOB_ID                 = DT.SOB_ID
          AND DA.ORG_ID                 = DT.ORG_ID
          AND DA.YEAR_YYYY              = C1.YEAR_YYYY
          AND DA.PERSON_ID              = P_PERSON_ID
          AND DA.SOB_ID                 = C1.SOB_ID
          AND DA.ORG_ID                 = C1.ORG_ID
          AND DA.DONA_TYPE              IN('40', '41')  -- 종교단체외기부금(40), 종교단체기부금(41).
        ;
      EXCEPTION WHEN OTHERS THEN
        V_DONAT_10P := 0;
        V_DONAT_10P_RELIGION := 0;
      END;
      -- 지정 기부금;
      IF NVL(V_DONAT_10P_RELIGION, 0) > 0 THEN
      --5.1 종교단체기부금이 있는 경우;
        -- 한도액설정 : 종교단체 기부금이외;
        V_DONAT_LMT := 0;
        V_DONAT_LMT := TRUNC((NVL(P_INCOME_AMT, 0) - NVL(V_SUM_DONAT_ALL, 0) - NVL(V_SUM_DONAT_50P, 0) - 
                              NVL(V_SUM_DONAT_30P, 0)) * (C1.RELIGION_DONAT_10P_RATE_1 / 100));
        FOR R1 IN ( SELECT DA.DONATION_ADJUSTMENT_ID
                        , DA.YEAR_YYYY
                        , DA.PERSON_ID
                        , DA.SOB_ID
                        , DA.ORG_ID
                        , DA.DONA_YYYY
                        , DA.DONA_TYPE
                        , DA.TOTAL_DONA_AMT
                        , DT.AVAILABLE_YEAR
                      FROM HRA_DONATION_ADJUSTMENT DA
                        , HRM_DONATION_TYPE_V DT
                    WHERE DA.DONA_TYPE              = DT.DONATION_TYPE
                      AND DA.SOB_ID                 = DT.SOB_ID
                      AND DA.ORG_ID                 = DT.ORG_ID
                      AND DA.YEAR_YYYY              = C1.YEAR_YYYY
                      AND DA.PERSON_ID              = P_PERSON_ID
                      AND DA.SOB_ID                 = C1.SOB_ID
                      AND DA.ORG_ID                 = C1.ORG_ID
                      AND DA.DONA_TYPE              = '40'
                    ORDER BY DA.DONA_TYPE, DA.DONA_YYYY DESC
                   )
        LOOP
          V_NEXT_DONA_AMT := 0;
          V_LAPSE_DONA_AMT := 0;
          V_DONAT_10P := NVL(R1.TOTAL_DONA_AMT, 0); -- 종교단체외 금액;  
          IF NVL(V_DONAT_LMT, 0) < NVL(V_SUM_DONAT_10P, 0) + NVL(V_DONAT_10P, 0) THEN
            -- 기부금 한도 초과 금액 계산.
            V_NEXT_DONA_AMT := NVL(V_SUM_DONAT_10P, 0) + NVL(V_DONAT_10P, 0) - NVL(V_DONAT_LMT, 0);
            V_LAPSE_DONA_AMT := 0;
            
            V_DONAT_10P := NVL(V_DONAT_LMT, 0) - NVL(V_SUM_DONAT_10P, 0);
          END IF;
                    
          -- 공제금액, 소멸금액, 이월금액 처리 --
          IF (TO_NUMBER(R1.DONA_YYYY) + NVL(R1.AVAILABLE_YEAR, 0)) > TO_NUMBER(R1.YEAR_YYYY) THEN
            NULL;
          ELSE
            -- 기부금액소멸.
            V_LAPSE_DONA_AMT := V_NEXT_DONA_AMT;
            V_NEXT_DONA_AMT := 0;
          END IF;
          
          -- 누계 -- 
          V_SUM_DONAT_10P := NVL(V_SUM_DONAT_10P, 0) + NVL(V_DONAT_10P, 0);
          V_SUM_DONAT_NEXT_10P := NVL(V_SUM_DONAT_NEXT_10P, 0) + NVL(V_NEXT_DONA_AMT, 0);
          
          -- 기부금조정명세서 UPDATE.
          UPDATE HRA_DONATION_ADJUSTMENT DA
            SET DA.DONA_DED_AMT     = NVL(V_DONAT_10P, 0)
              , DA.LAPSE_DONA_AMT   = NVL(V_LAPSE_DONA_AMT, 0)
              , DA.NEXT_DONA_AMT    = NVL(V_NEXT_DONA_AMT, 0)
          WHERE DA.DONATION_ADJUSTMENT_ID = R1.DONATION_ADJUSTMENT_ID
          ;
        END LOOP R1;
        -- 한도액설정 : 종교단체 기부금;
        V_DONAT_LMT := 0;
        V_DONAT_LMT := TRUNC((NVL(P_INCOME_AMT, 0) - NVL(V_SUM_DONAT_ALL, 0) - NVL(V_SUM_DONAT_50P, 0) - 
                              NVL(V_SUM_DONAT_30P, 0)) * (C1.RELIGION_DONAT_10P_RATE / 100));
                              
        FOR R1 IN ( SELECT DA.DONATION_ADJUSTMENT_ID
                        , DA.YEAR_YYYY
                        , DA.PERSON_ID
                        , DA.SOB_ID
                        , DA.ORG_ID
                        , DA.DONA_YYYY
                        , DA.DONA_TYPE
                        , DA.TOTAL_DONA_AMT
                        , DT.AVAILABLE_YEAR
                      FROM HRA_DONATION_ADJUSTMENT DA
                        , HRM_DONATION_TYPE_V DT
                    WHERE DA.DONA_TYPE              = DT.DONATION_TYPE
                      AND DA.SOB_ID                 = DT.SOB_ID
                      AND DA.ORG_ID                 = DT.ORG_ID
                      AND DA.YEAR_YYYY              = C1.YEAR_YYYY
                      AND DA.PERSON_ID              = P_PERSON_ID
                      AND DA.SOB_ID                 = C1.SOB_ID
                      AND DA.ORG_ID                 = C1.ORG_ID
                      AND DA.DONA_TYPE              = '41'
                    ORDER BY DA.DONA_TYPE, DA.DONA_YYYY DESC
                   )
        LOOP
          V_NEXT_DONA_AMT := 0;
          V_LAPSE_DONA_AMT := 0;
          V_DONAT_10P_RELIGION := NVL(R1.TOTAL_DONA_AMT, 0); -- 종교단체외 금액;  
          IF NVL(V_DONAT_LMT, 0) < NVL(V_SUM_DONAT_10P_RELIGION, 0) + NVL(V_DONAT_10P_RELIGION, 0) THEN
            -- 기부금 한도 초과 금액 계산.
            V_NEXT_DONA_AMT := (NVL(V_SUM_DONAT_10P_RELIGION, 0) + NVL(V_DONAT_10P_RELIGION, 0)) - NVL(V_DONAT_LMT, 0);
            V_LAPSE_DONA_AMT := 0;
            
            V_DONAT_10P_RELIGION := NVL(V_DONAT_LMT, 0) - NVL(V_SUM_DONAT_10P_RELIGION, 0);
          END IF;
                    
          -- 공제금액, 소멸금액, 이월금액 처리 --
          IF (TO_NUMBER(R1.DONA_YYYY) + NVL(R1.AVAILABLE_YEAR, 0)) > TO_NUMBER(R1.YEAR_YYYY) THEN
            NULL;
          ELSE
            -- 기부금액소멸.
            V_LAPSE_DONA_AMT := V_NEXT_DONA_AMT;
            V_NEXT_DONA_AMT := 0;
          END IF;
          
          -- 누계 -- 
          V_SUM_DONAT_10P_RELIGION := NVL(V_SUM_DONAT_10P_RELIGION, 0) + NVL(V_DONAT_10P_RELIGION, 0);
          V_SUM_DONAT_NEXT_10P_REL := NVL(V_SUM_DONAT_NEXT_10P_REL, 0) + NVL(V_NEXT_DONA_AMT, 0);
          
          -- 기부금조정명세서 UPDATE.
          UPDATE HRA_DONATION_ADJUSTMENT DA
            SET DA.DONA_DED_AMT     = NVL(V_DONAT_10P_RELIGION, 0)
              , DA.LAPSE_DONA_AMT   = NVL(V_LAPSE_DONA_AMT, 0)
              , DA.NEXT_DONA_AMT    = NVL(V_NEXT_DONA_AMT, 0)
          WHERE DA.DONATION_ADJUSTMENT_ID = R1.DONATION_ADJUSTMENT_ID
          ;
        END LOOP R1;
      ELSIF NVL(V_DONAT_10P_RELIGION, 0) = 0 THEN
      -- 5.2 종교단체기부금이 없는 경우;
        -- 한도액설정;
        V_DONAT_LMT := 0;
        V_DONAT_LMT := TRUNC((NVL(P_INCOME_AMT, 0) - NVL(V_SUM_DONAT_ALL, 0) - NVL(V_SUM_DONAT_50P, 0) - 
                              NVL(V_SUM_DONAT_30P, 0)) * (C1.NO_RELIGION_DONAT_RATE / 100));
        FOR R1 IN ( SELECT DA.DONATION_ADJUSTMENT_ID
                        , DA.YEAR_YYYY
                        , DA.PERSON_ID
                        , DA.SOB_ID
                        , DA.ORG_ID
                        , DA.DONA_YYYY
                        , DA.DONA_TYPE
                        , DA.TOTAL_DONA_AMT
                        , DT.AVAILABLE_YEAR
                      FROM HRA_DONATION_ADJUSTMENT DA
                        , HRM_DONATION_TYPE_V DT
                    WHERE DA.DONA_TYPE              = DT.DONATION_TYPE
                      AND DA.SOB_ID                 = DT.SOB_ID
                      AND DA.ORG_ID                 = DT.ORG_ID
                      AND DA.YEAR_YYYY              = C1.YEAR_YYYY
                      AND DA.PERSON_ID              = P_PERSON_ID
                      AND DA.SOB_ID                 = C1.SOB_ID
                      AND DA.ORG_ID                 = C1.ORG_ID
                      AND DA.DONA_TYPE              = '40'
                    ORDER BY DA.DONA_TYPE, DA.DONA_YYYY DESC
                   )
        LOOP
          V_NEXT_DONA_AMT := 0;
          V_LAPSE_DONA_AMT := 0;
          V_DONAT_10P := NVL(R1.TOTAL_DONA_AMT, 0); -- 종교단체외 금액;  
          IF NVL(V_DONAT_LMT, 0) < NVL(V_SUM_DONAT_10P, 0) + NVL(V_DONAT_10P, 0) THEN
            -- 기부금 한도 초과 금액 계산.
            V_NEXT_DONA_AMT := NVL(V_SUM_DONAT_10P, 0) + NVL(V_DONAT_10P, 0) - NVL(V_DONAT_LMT, 0);
            V_LAPSE_DONA_AMT := 0;

            V_DONAT_10P := NVL(V_DONAT_LMT, 0) - NVL(V_SUM_DONAT_10P, 0);
          END IF;          
          
          -- 공제금액, 소멸금액, 이월금액 처리 --
          IF (TO_NUMBER(R1.DONA_YYYY) + NVL(R1.AVAILABLE_YEAR, 0)) > TO_NUMBER(R1.YEAR_YYYY) THEN
            NULL;
          ELSE
            -- 기부금액소멸.
            V_LAPSE_DONA_AMT := V_NEXT_DONA_AMT;
            V_NEXT_DONA_AMT := 0;
          END IF;
          
          -- 누계 -- 
          V_SUM_DONAT_10P := NVL(V_SUM_DONAT_10P, 0) + NVL(V_DONAT_10P, 0);
          V_SUM_DONAT_NEXT_10P := NVL(V_SUM_DONAT_NEXT_10P, 0) + NVL(V_NEXT_DONA_AMT, 0);
          
          -- 기부금조정명세서 UPDATE.
          UPDATE HRA_DONATION_ADJUSTMENT DA
            SET DA.DONA_DED_AMT     = NVL(V_DONAT_10P, 0)
              , DA.LAPSE_DONA_AMT   = NVL(V_LAPSE_DONA_AMT, 0)
              , DA.NEXT_DONA_AMT    = NVL(V_NEXT_DONA_AMT, 0)
          WHERE DA.DONATION_ADJUSTMENT_ID = R1.DONATION_ADJUSTMENT_ID
          ;
        END LOOP R1;
      ELSE
        V_DONAT_LMT := 0;
        V_SUM_DONAT_10P := 0;
        V_SUM_DONAT_10P_RELIGION := 0;
        V_SUM_DONAT_NEXT_10P := 0;
        V_SUM_DONAT_NEXT_10P_REL := 0;
      END IF;
    
      -- 총합계;
      V_DONAT_TOTAL := 0;
      V_DONAT_TOTAL := TRUNC(NVL(V_SUM_DONAT_POLI, 0) + NVL(V_SUM_DONAT_ALL, 0) + NVL(V_SUM_DONAT_50P, 0) + NVL(V_SUM_DONAT_30P, 0) + 
                       NVL(V_SUM_DONAT_10P, 0) + NVL(V_SUM_DONAT_10P_RELIGION, 0));
    
      --> 기부금   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
        SET HA.DONAT_AMT              = TRUNC(NVL(V_DONAT_TOTAL, 0))          
          , HA.DONAT_DED_ALL          = TRUNC(NVL(V_SUM_DONAT_ALL, 0))
          , HA.DONAT_DED_50           = TRUNC(NVL(V_SUM_DONAT_50P, 0))
          , HA.DONAT_DED_30           = TRUNC(NVL(V_SUM_DONAT_30P, 0))
          , HA.DONAT_DED_10           = TRUNC(NVL(V_SUM_DONAT_10P, 0))
          , HA.DONAT_DED_RELIGION_10  = TRUNC(NVL(V_SUM_DONAT_10P_RELIGION, 0))
          , HA.DONAT_NEXT_ALL         = TRUNC(NVL(V_SUM_DONAT_NEXT_ALL, 0))
          , HA.DONAT_NEXT_50          = TRUNC(NVL(V_SUM_DONAT_NEXT_50P, 0))
          , HA.DONAT_NEXT_30          = TRUNC(NVL(V_SUM_DONAT_NEXT_30P, 0))
          , HA.DONAT_NEXT_10          = TRUNC(NVL(V_SUM_DONAT_NEXT_10P, 0))
          , HA.DONAT_NEXT_RELIGION_10 = TRUNC(NVL(V_SUM_DONAT_NEXT_10P_REL, 0))
          , HA.DONAT_DED_POLI_AMT     = TRUNC(NVL(V_SUM_DONAT_POLI, 0))
          , HA.DONAT_NEXT_POLI_AMT    = TRUNC(NVL(V_SUM_DONAT_NEXT_POLI, 0))
          , HA.TAX_DED_DONAT_POLI_AMT = TRUNC(NVL(V_TAX_DED_POLI_AMT, 0))
      WHERE HA.YEAR_YYYY          = P_YEAR_YYYY
        AND HA.PERSON_ID          = P_PERSON_ID
        AND HA.SOB_ID             = P_SOB_ID
        AND HA.ORG_ID             = P_ORG_ID
      ;
    END LOOP C1;
    O_STATUS := 'S';
    RETURN NVL(V_DONAT_TOTAL, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Donation Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END DONATION_CAL;

  -- 10. 혼인, 장례, 이상비용 공제;
  FUNCTION MARRY_ETC_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER
  AS
    V_MARRY_ETC_AMT NUMBER := 0; -- 혼인장례이사 금액 
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.MARRY_DED_STD, 0) MARRY_DED_STD
                    , NVL(HIT.MARRY_DED, 0) MARRY_DED
                    , NVL(HIT.FUNE_DED_STD, 0) FUNE_DED_STD
                    , NVL(HIT.FUNE_DED, 0) FUNE_DED
                    , NVL(HIT.MOVE_DED_STD, 0) MOVE_DED_STD
                    , NVL(HIT.MOVE_DED, 0) MOVE_DED
                    --> 혼인장례이사           
                    , NVL(HF1.MARRY_COUNT, 0) MARRY_COUNT
                    , NVL(HF1.FUNER_COUNT, 0) FUNER_COUNT
                    , NVL(HF1.HOUSE_MOVE_COUNT, 0) HOUSE_MOVE_COUNT
                  FROM HRA_INCOME_TAX_STANDARD HIT
                    , ( SELECT HF.YEAR_YYYY
                            , HF.SOB_ID
                            , HF.ORG_ID
                            , NVL(HF.MARRY_COUNT, 0) MARRY_COUNT
                            , NVL(HF.FUNER_COUNT, 0) FUNER_COUNT
                            , NVL(HF.HOUSE_MOVE_COUNT, 0) HOUSE_MOVE_COUNT
                          FROM HRA_FOUNDATION HF
                         WHERE HF.YEAR_YYYY     = P_YEAR_YYYY
                           AND HF.PERSON_ID     = P_PERSON_ID
                           AND HF.SOB_ID        = P_SOB_ID
                           AND HF.ORG_ID        = P_ORG_ID
                      ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
              ) 
    LOOP
      --  결혼금액  
      IF P_TOTAL_PAY <= C1.MARRY_DED_STD THEN
        V_MARRY_ETC_AMT := C1.MARRY_DED * C1.MARRY_COUNT;
      END IF;
      -- 장례금액 
      IF P_TOTAL_PAY <= C1.FUNE_DED_STD THEN
        V_MARRY_ETC_AMT := V_MARRY_ETC_AMT + (C1.FUNE_DED * C1.FUNER_COUNT);
      END IF;
      -- 이사금액 
      IF P_TOTAL_PAY <= C1.MOVE_DED_STD THEN
        V_MARRY_ETC_AMT := V_MARRY_ETC_AMT + (C1.MOVE_DED * C1.HOUSE_MOVE_COUNT);
      END IF;
    
      --> 결혼,이사,장례 공제금액   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.MARRY_ETC_AMT     = NVL(V_MARRY_ETC_AMT, 0)
       WHERE HA.YEAR_YYYY         = P_YEAR_YYYY
         AND HA.PERSON_ID         = P_PERSON_ID
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
      ;
    END LOOP C1;
    O_STATUS := 'S';
    RETURN NVL(V_MARRY_ETC_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Marry etc Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END MARRY_ETC_CAL;

  -- 11.1 개인연금저축소득공제, 퇴직연금 저축
  FUNCTION PER_ANNU_BANK_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_TOTAL_AMT                   NUMBER := 0;  -- 개인연금저축 누적금액.
    V_PER_ANNU_AMT                NUMBER := 0; -- 개인연금저축;
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.PRIV_PENS_RATE, 0) PRIV_PENS_RATE
                    , NVL(HIT.PRIV_PENS_LMT, 0) PRIV_PENS_LMT
                    -- 개인연금 저축.
                    , HF1.SAVING_INFO_ID
                    , NVL(HF1.SAVING_AMOUNT, 0) PERSON_ANNU_AMT
                  FROM HRA_INCOME_TAX_STANDARD HIT
                    , ( --  연말정산 기초자료  조회  
                      SELECT HSI.SAVING_INFO_ID
                          , HSI.YEAR_YYYY
                          , HSI.SOB_ID
                          , HSI.ORG_ID
                          , HSI.SAVING_AMOUNT
                        FROM HRA_SAVING_INFO HSI
                          , HRM_SAVING_TYPE_V ST
                      WHERE HSI.SAVING_TYPE             = ST.SAVING_TYPE
                        AND HSI.SOB_ID                  = ST.SOB_ID
                        AND HSI.ORG_ID                  = ST.ORG_ID
                        AND HSI.YEAR_YYYY               = P_YEAR_YYYY
                        AND HSI.SOB_ID                  = P_SOB_ID
                        AND HSI.ORG_ID                  = P_ORG_ID
                        AND HSI.PERSON_ID               = P_PERSON_ID
                        AND HSI.SAVING_TYPE             IN ('21')
                     ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
              ) 
    LOOP
      --  개인연금저축 금액.
      V_PER_ANNU_AMT := 0;
      V_PER_ANNU_AMT := TRUNC(NVL(C1.PERSON_ANNU_AMT, 0) * (C1.PRIV_PENS_RATE / 100));
      IF NVL(C1.PRIV_PENS_LMT, 0) < NVL(V_TOTAL_AMT, 0) + NVL(V_PER_ANNU_AMT, 0) THEN
        V_PER_ANNU_AMT := NVL(C1.PRIV_PENS_LMT, 0) - NVL(V_TOTAL_AMT, 0);
      END IF;
      V_TOTAL_AMT := NVL(V_TOTAL_AMT, 0) + NVL(V_PER_ANNU_AMT, 0);
      
      -- 개인연금저축 공제금액 UPDATE.
      UPDATE HRA_SAVING_INFO HSI
        SET HSI.SAVING_DED_AMOUNT  = NVL(V_PER_ANNU_AMT, 0)
      WHERE HSI.SAVING_INFO_ID     = C1.SAVING_INFO_ID
      ;
    END LOOP C1;
    --> 개인연금저축    UPDATE 
    UPDATE HRA_YEAR_ADJUSTMENT HA
      SET HA.PERS_ANNU_BANK_AMT = NVL(V_TOTAL_AMT, 0)
    WHERE HA.YEAR_YYYY         = P_YEAR_YYYY
      AND HA.PERSON_ID         = P_PERSON_ID
      AND HA.SOB_ID            = P_SOB_ID
      AND HA.ORG_ID            = P_ORG_ID
    ;
    O_STATUS := 'S';
    RETURN NVL(V_TOTAL_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Person Annu Bank Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END PER_ANNU_BANK_CAL;

  -- 11.2 연금저축소득공제, 퇴직연금 저축;
  FUNCTION ANNU_BANK_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_TOTAL_AMT                   NUMBER := 0;  -- 연금저축 누적금액.
    V_ANNU_BANK_AMT               NUMBER := 0;  -- 연금저축.
    V_RETR_ANNU_AMT               NUMBER := 0;  -- 퇴직연금저축(한도 설정위해);
  BEGIN
    O_STATUS := 'F';
    BEGIN
      -- 퇴직연금납입액 공제금액 조회.
      SELECT NVL(YA.RETR_ANNU_AMT, 0) AS RETR_ANNU_AMT
        INTO V_RETR_ANNU_AMT
        FROM HRA_YEAR_ADJUSTMENT YA
      WHERE YA.YEAR_YYYY          = P_YEAR_YYYY
        AND YA.PERSON_ID          = P_PERSON_ID
        AND YA.SOB_ID             = P_SOB_ID
        AND YA.ORG_ID             = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETR_ANNU_AMT := 0;
    END;
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.PENS_DED_RATE, 0) PENS_DED_RATE
                    , NVL(HIT.PENS_DED_LMT, 0) PENS_DED_LMT
                    --> 연금 저축.
                    , HF1.SAVING_INFO_ID
                    , NVL(HF1.SAVING_AMOUNT, 0) ANNU_BANK_AMT
                  FROM HRA_INCOME_TAX_STANDARD HIT
                    , ( --  연말정산 기초자료  조회  
                      SELECT HSI.SAVING_INFO_ID
                          , HSI.YEAR_YYYY
                          , HSI.SOB_ID
                          , HSI.ORG_ID
                          , HSI.SAVING_AMOUNT AS SAVING_AMOUNT
                        FROM HRA_SAVING_INFO HSI
                          , HRM_SAVING_TYPE_V ST
                      WHERE HSI.SAVING_TYPE             = ST.SAVING_TYPE
                        AND HSI.SOB_ID                  = ST.SOB_ID
                        AND HSI.ORG_ID                  = ST.ORG_ID
                        AND HSI.YEAR_YYYY               = P_YEAR_YYYY
                        AND HSI.SOB_ID                  = P_SOB_ID
                        AND HSI.ORG_ID                  = P_ORG_ID
                        AND HSI.PERSON_ID               = P_PERSON_ID
                        AND HSI.SAVING_TYPE             IN ('22')
                       ) HF1
                WHERE HIT.YEAR_YYYY       = HF1.YEAR_YYYY
                  AND HIT.SOB_ID          = HF1.SOB_ID
                  AND HIT.ORG_ID          = HF1.ORG_ID
                  AND HIT.YEAR_YYYY       = P_YEAR_YYYY
                  AND HIT.SOB_ID          = P_SOB_ID
                  AND HIT.ORG_ID          = P_ORG_ID
              ) 
    LOOP
      --  연금저축 금액;
      V_ANNU_BANK_AMT := 0;
      V_ANNU_BANK_AMT := TRUNC(NVL(C1.ANNU_BANK_AMT, 0) * (C1.PENS_DED_RATE / 100));
      IF NVL(C1.PENS_DED_LMT, 0) < NVL(V_RETR_ANNU_AMT, 0) + NVL(V_TOTAL_AMT, 0) + NVL(V_ANNU_BANK_AMT, 0) THEN
        V_ANNU_BANK_AMT := NVL(C1.PENS_DED_LMT, 0) - NVL(V_RETR_ANNU_AMT, 0) - NVL(V_TOTAL_AMT, 0);
      END IF;
      IF NVL(V_ANNU_BANK_AMT, 0) < 0 THEN
        V_ANNU_BANK_AMT := 0;
      END IF;
      V_TOTAL_AMT := NVL(V_TOTAL_AMT, 0) + NVL(V_ANNU_BANK_AMT, 0);
      
      -- 연금저축 공제금액 UPDATE.
      UPDATE HRA_SAVING_INFO HSI
        SET HSI.SAVING_DED_AMOUNT  = NVL(V_ANNU_BANK_AMT, 0)
      WHERE HSI.SAVING_INFO_ID     = C1.SAVING_INFO_ID
      ;
    END LOOP C1;
    
    --> 연금저축    UPDATE;
    UPDATE HRA_YEAR_ADJUSTMENT HA
       SET HA.ANNU_BANK_AMT = NVL(V_TOTAL_AMT, 0)
    WHERE HA.YEAR_YYYY      = P_YEAR_YYYY
      AND HA.PERSON_ID      = P_PERSON_ID
      AND HA.SOB_ID         = P_SOB_ID
      AND HA.ORG_ID         = P_ORG_ID
    ;
    O_STATUS := 'S';
    RETURN NVL(V_TOTAL_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Annu Bank Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END ANNU_BANK_CAL;

  -- 11.3 퇴직연금 저축 ;
  FUNCTION RETR_ANNU_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_TOTAL_AMT                   NUMBER := 0;  -- 퇴직연금저축 누적금액.
    V_RETR_ANNU_AMT               NUMBER := 0;  -- 퇴직연금저축;
    V_ANNU_BANK_AMT               NUMBER := 0;  -- 연금저축.
  BEGIN
    O_STATUS := 'F';
    BEGIN
      -- 퇴직연금납입액 공제금액 조회.
      SELECT NVL(YA.ANNU_BANK_AMT, 0) AS ANNU_BANK_AMT
        INTO V_ANNU_BANK_AMT
        FROM HRA_YEAR_ADJUSTMENT YA
      WHERE YA.YEAR_YYYY          = P_YEAR_YYYY
        AND YA.PERSON_ID          = P_PERSON_ID
        AND YA.SOB_ID             = P_SOB_ID
        AND YA.ORG_ID             = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ANNU_BANK_AMT := 0;
    END;
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.RETR_PENS_LMT, 0) RETR_PENS_LMT
                    --> 퇴직연금 저축.
                    , HF1.SAVING_INFO_ID
                    , NVL(HF1.SAVING_AMOUNT, 0) RETR_ANNU_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  연말정산 기초자료  조회  
                      SELECT HSI.SAVING_INFO_ID
                          , HSI.YEAR_YYYY
                          , HSI.SOB_ID
                          , HSI.ORG_ID
                          , HSI.SAVING_AMOUNT AS SAVING_AMOUNT
                        FROM HRA_SAVING_INFO HSI
                          , HRM_SAVING_TYPE_V ST
                      WHERE HSI.SAVING_TYPE             = ST.SAVING_TYPE
                        AND HSI.SOB_ID                  = ST.SOB_ID
                        AND HSI.ORG_ID                  = ST.ORG_ID
                        AND HSI.YEAR_YYYY               = P_YEAR_YYYY
                        AND HSI.SOB_ID                  = P_SOB_ID
                        AND HSI.ORG_ID                  = P_ORG_ID
                        AND HSI.PERSON_ID               = P_PERSON_ID
                        AND HSI.SAVING_TYPE             IN ('11', '12')
                     ) HF1
                WHERE HIT.YEAR_YYYY       = HF1.YEAR_YYYY
                  AND HIT.SOB_ID          = HF1.SOB_ID
                  AND HIT.ORG_ID          = HF1.ORG_ID
                  AND HIT.YEAR_YYYY       = P_YEAR_YYYY
                  AND HIT.SOB_ID          = P_SOB_ID
                  AND HIT.ORG_ID          = P_ORG_ID
               ) 
    LOOP
      --  퇴직연금저축 금액.
      V_RETR_ANNU_AMT := 0;
      V_RETR_ANNU_AMT := NVL(C1.RETR_ANNU_AMT, 0);
      IF NVL(C1.RETR_PENS_LMT, 0) < NVL(V_ANNU_BANK_AMT, 0) + NVL(V_TOTAL_AMT, 0) + NVL(V_RETR_ANNU_AMT, 0) THEN
        V_RETR_ANNU_AMT := NVL(C1.RETR_PENS_LMT, 0) - NVL(V_ANNU_BANK_AMT, 0) - NVL(V_TOTAL_AMT, 0);
      END IF;
      IF NVL(V_RETR_ANNU_AMT, 0) < 0 THEN
        V_RETR_ANNU_AMT := 0;
      END IF;
      V_TOTAL_AMT := NVL(V_TOTAL_AMT, 0) + NVL(V_RETR_ANNU_AMT, 0);
      
      -- 연금저축 공제금액 UPDATE.
      UPDATE HRA_SAVING_INFO HSI
        SET HSI.SAVING_DED_AMOUNT  = NVL(V_RETR_ANNU_AMT, 0)
      WHERE HSI.SAVING_INFO_ID     = C1.SAVING_INFO_ID
      ;
    END LOOP C1;
    
    -- 퇴직연금저축    UPDATE 
    UPDATE HRA_YEAR_ADJUSTMENT HA
       SET HA.RETR_ANNU_AMT     = NVL(V_TOTAL_AMT, 0)
     WHERE HA.YEAR_YYYY         = P_YEAR_YYYY
       AND HA.PERSON_ID         = P_PERSON_ID
       AND HA.SOB_ID            = P_SOB_ID
       AND HA.ORG_ID            = P_ORG_ID
    ;      
    O_STATUS := 'S';
    RETURN NVL(V_TOTAL_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Retire Annu Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END RETR_ANNU_CAL;

  -- 12. 투자조합출자;
  FUNCTION INVEST_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_INCOME_AMT        IN NUMBER
            ) RETURN NUMBER
  AS
    V_INVEST_AMT_10     NUMBER := 0;  -- 투자조합 출자 
    V_INVEST_LMT_10     NUMBER := 0;  -- 투자조합출자 한도 
    
    V_INVEST_AMT_11     NUMBER := 0;  -- 2013.12.31 전호수 추가 : 투자조합 출자(2011) 
    V_INVEST_LMT_11     NUMBER := 0;  -- 2013.12.31 전호수 추가 : 투자조합출자 한도 (2011) 
    V_INVEST_AMT_12     NUMBER := 0;  -- 2013.12.31 전호수 추가 : 투자조합 출자(2012) 
    V_INVEST_LMT_12     NUMBER := 0;  -- 2013.12.31 전호수 추가 : 투자조합출자 한도(2012) 
    V_INVEST_AMT_13     NUMBER := 0;  -- 2013.12.31 전호수 추가 : 투자조합 출자(2013) 
    V_INVEST_LMT_13     NUMBER := 0;  -- 2013.12.31 전호수 추가 : 투자조합출자 한도(2013) 
    
    V_INVEST_LMT        NUMBER := 0;  -- 투자조합출자 한도(전체)       
    V_INVEST_OVER_AMT   NUMBER := 0;  -- 투자조합출자 한도 초과금액  
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.INVEST_RATE1, 0) AS INVEST_RATE_10
                    , NVL(HIT.INVEST_LMT_RATE1, 0) AS INVEST_LMT_RATE_10
                    , NVL(HIT.INVEST_RATE2, 0) AS INVEST_RATE2
                    , NVL(HIT.INVEST_LMT_RATE2, 0) AS INVEST_LMT_RATE2
                    , NVL(HIT.INVEST_RATE_11, 0) AS INVEST_RATE_11 
                    , NVL(HIT.INVEST_LMT_RATE_11, 0) AS INVEST_LMT_RATE_11 
                    , NVL(HIT.INVEST_RATE_12_1, 0) AS INVEST_RATE_12_1 
                    , NVL(HIT.INVEST_RATE_12_2, 0) AS INVEST_RATE_12_2 
                    , NVL(HIT.INVEST_LMT_RATE_12, 0) AS INVEST_LMT_RATE_12 
                    , NVL(HIT.INVEST_RATE_13_1, 0) AS INVEST_RATE_13_1 
                    , NVL(HIT.INVEST_RATE_13_2, 0) AS INVEST_RATE_13_2 
                    , NVL(HIT.INVEST_LMT_RATE_13, 0) AS INVEST_LMT_RATE_13  
                    , NVL(HIT.INVEST_LMT_RATE, 0) AS INVEST_LMT_RATE 
                    --> 투자조합 출자 내역           
                    , NVL(HF1.INVES_AMT, 0) AS INVES_AMT_10
                    , NVL(HF1.INVEST_AMT_11, 0) AS INVEST_AMT_11 
                    , NVL(HF1.INVEST_AMT_12_1, 0) AS INVEST_AMT_12_1 
                    , NVL(HF1.INVEST_AMT_12_2, 0) AS INVEST_AMT_12_2 
                    , NVL(HF1.INVEST_AMT_13_1, 0) AS INVEST_AMT_13_1 
                    , NVL(HF1.INVEST_AMT_13_2, 0) AS INVEST_AMT_13_2 
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  연말정산 기초자료  조회  
                      SELECT HF.YEAR_YYYY
                          , HF.SOB_ID
                          , HF.ORG_ID
                          , NVL(HF.INVES_AMT, 0) AS INVES_AMT
                          , NVL(HF.INVEST_AMT_11, 0) AS INVEST_AMT_11 
                          , NVL(HF.INVEST_AMT_12_1, 0) AS INVEST_AMT_12_1 
                          , NVL(HF.INVEST_AMT_12_2, 0) AS INVEST_AMT_12_2 
                          , NVL(HF.INVEST_AMT_13_1, 0) AS INVEST_AMT_13_1 
                          , NVL(HF.INVEST_AMT_13_2, 0) AS INVEST_AMT_13_2 
                        FROM HRA_FOUNDATION HF
                      WHERE HF.YEAR_YYYY    = P_YEAR_YYYY
                        AND HF.PERSON_ID    = P_PERSON_ID
                        AND HF.SOB_ID       = P_SOB_ID
                        AND HF.ORG_ID       = P_ORG_ID
                     ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID                  
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
               ) 
    LOOP
      --  2010년 이전 투자조합 출자 금액   
      V_INVEST_AMT_10 := TRUNC(C1.INVES_AMT_10 * (C1.INVEST_RATE_10 / 100));
      V_INVEST_LMT_10 := TRUNC(P_INCOME_AMT * (C1.INVEST_LMT_RATE_10 / 100));      
      IF V_INVEST_LMT_10 < V_INVEST_AMT_10 THEN
        V_INVEST_AMT_10 := V_INVEST_LMT_10;
      END IF;
      
      --  2011년 이전 투자조합 출자 금액   
      V_INVEST_AMT_11 := TRUNC(C1.INVEST_AMT_11 * (C1.INVEST_RATE_11 / 100));
      V_INVEST_LMT_11 := TRUNC(P_INCOME_AMT * (C1.INVEST_LMT_RATE_11 / 100));      
      IF V_INVEST_LMT_11 < V_INVEST_AMT_11 THEN
        V_INVEST_AMT_11 := V_INVEST_LMT_11;
      END IF;
      
      --  2012년 이전 투자조합 출자 금액   
      V_INVEST_AMT_12 := TRUNC(C1.INVEST_AMT_12_1 * (C1.INVEST_RATE_12_1 / 100));
      V_INVEST_AMT_12 := NVL(V_INVEST_AMT_12, 0) + TRUNC(C1.INVEST_AMT_12_2 * (C1.INVEST_RATE_12_2 / 100));      
      V_INVEST_LMT_12 := TRUNC(P_INCOME_AMT * (C1.INVEST_LMT_RATE_12 / 100));      
      IF V_INVEST_LMT_12 < V_INVEST_AMT_12 THEN
        V_INVEST_AMT_12 := V_INVEST_LMT_12;
      END IF;
      
      --  2013년 이전 투자조합 출자 금액   
      V_INVEST_AMT_13 := TRUNC(C1.INVEST_AMT_13_1 * (C1.INVEST_RATE_13_1 / 100));
      V_INVEST_AMT_13 := NVL(V_INVEST_AMT_13, 0) + TRUNC(C1.INVEST_AMT_13_2 * (C1.INVEST_RATE_13_2 / 100));      
      V_INVEST_LMT_13 := TRUNC(P_INCOME_AMT * (C1.INVEST_LMT_RATE_13 / 100));      
      IF V_INVEST_LMT_13 < V_INVEST_AMT_13 THEN
        V_INVEST_AMT_13 := V_INVEST_LMT_13;
      END IF;
      
      --  투자조합 출자 한도 금액   
      V_INVEST_LMT := TRUNC(P_INCOME_AMT * (C1.INVEST_LMT_RATE / 100)); 
      V_INVEST_OVER_AMT := ( NVL(V_INVEST_AMT_10, 0) + NVL(V_INVEST_AMT_11, 0) + 
                             NVL(V_INVEST_AMT_12, 0) + NVL(V_INVEST_AMT_13, 0)) - 
                           NVL(V_INVEST_LMT, 0);  -- 한도 초과 금액 산출  
      IF V_INVEST_OVER_AMT > 0  THEN
        -- 2010년 이전  
        IF NVL(V_INVEST_AMT_10, 0) < NVL(V_INVEST_OVER_AMT, 0) THEN
          V_INVEST_OVER_AMT := NVL(V_INVEST_OVER_AMT, 0) - NVL(V_INVEST_AMT_10, 0);
          V_INVEST_AMT_10   := 0;
        ELSE
          V_INVEST_AMT_10   := NVL(V_INVEST_AMT_10, 0) - NVL(V_INVEST_OVER_AMT, 0);
          V_INVEST_OVER_AMT := 0;            
        END IF;
        -- 2011년 이전  
        IF NVL(V_INVEST_AMT_11, 0) < NVL(V_INVEST_OVER_AMT, 0) THEN
          V_INVEST_OVER_AMT := NVL(V_INVEST_OVER_AMT, 0) - NVL(V_INVEST_AMT_11, 0);
          V_INVEST_AMT_11   := 0;
        ELSE
          V_INVEST_AMT_11   := NVL(V_INVEST_AMT_11, 0) - NVL(V_INVEST_OVER_AMT, 0);
          V_INVEST_OVER_AMT := 0;            
        END IF; 
        -- 2012년 이전  
        IF NVL(V_INVEST_AMT_12, 0) < NVL(V_INVEST_OVER_AMT, 0) THEN
          V_INVEST_OVER_AMT := NVL(V_INVEST_OVER_AMT, 0) - NVL(V_INVEST_AMT_12, 0);
          V_INVEST_AMT_12   := 0;
        ELSE
          V_INVEST_AMT_12   := NVL(V_INVEST_AMT_12, 0) - NVL(V_INVEST_OVER_AMT, 0);
          V_INVEST_OVER_AMT := 0;            
        END IF; 
        -- 2013년 이전  
        IF NVL(V_INVEST_AMT_13, 0) < NVL(V_INVEST_OVER_AMT, 0) THEN
          V_INVEST_OVER_AMT := NVL(V_INVEST_OVER_AMT, 0) - NVL(V_INVEST_AMT_13, 0);
          V_INVEST_AMT_13   := 0;
        ELSE
          V_INVEST_AMT_13   := NVL(V_INVEST_AMT_13, 0) - NVL(V_INVEST_OVER_AMT, 0);
          V_INVEST_OVER_AMT := 0;            
        END IF; 
      END IF;
                
      --> 투자조합 출자   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.INVES_AMT       = ( NVL(V_INVEST_AMT_10, 0) + NVL(V_INVEST_AMT_11, 0) +
                                    NVL(V_INVEST_AMT_12, 0) + NVL(V_INVEST_AMT_13, 0)) 
           , HA.INVEST_AMT_10   = NVL(V_INVEST_AMT_10, 0) 
           , HA.INVEST_AMT_11   = NVL(V_INVEST_AMT_11, 0) 
           , HA.INVEST_AMT_12   = NVL(V_INVEST_AMT_12, 0) 
           , HA.INVEST_AMT_13   = NVL(V_INVEST_AMT_13, 0) 
       WHERE HA.YEAR_YYYY       = P_YEAR_YYYY
         AND HA.PERSON_ID       = P_PERSON_ID
         AND HA.SOB_ID          = P_SOB_ID
         AND HA.ORG_ID          = P_ORG_ID
      ;
    END LOOP C1;
    O_STATUS := 'S';
    RETURN NVL(( NVL(V_INVEST_AMT_10, 0) + NVL(V_INVEST_AMT_11, 0) +
                 NVL(V_INVEST_AMT_12, 0) + NVL(V_INVEST_AMT_13, 0)), 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Invest Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END INVEST_CAL;

  -- 14.1 주택청약종합저축 불입액 소득공제 : 사용 안함;
  FUNCTION HOUSE_APP_DEPOSIT_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_HOUSE_DED_AMT     IN NUMBER
            ) RETURN NUMBER
  AS
    V_ADD_AMOUNT                  NUMBER := 0;  -- 누적금액.
    V_HOUSE_APP_DEPOSIT_AMT       NUMBER := 0; -- 주택청약종합저축 불입액 소득공제;
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.HOUSE_AMT_RATE, 0) HOUSE_APP_DEPOSIT_RATE
                    , NVL(HIT.HOUSE_AMT_LMT, 0) HOUSE_APP_DEPOSIT_LMT
                    , NVL(HIT.HOUSE_AMT_LMT, 0) HOUSE_AMT_LMT
                    -- 
                    , NVL(HF1.HOUSE_APP_DEPOSIT_AMT, 0) HOUSE_APP_DEPOSIT_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  연말정산 기초자료  조회  : 주택저축 자료.
                     SELECT HSI.SAVING_INFO_ID
                          , HSI.YEAR_YYYY
                          , HSI.SOB_ID
                          , HSI.ORG_ID
                          , HSI.PERSON_ID
                          , HSI.SAVING_TYPE
                          , ST.SAVING_TYPE_NAME
                          , HSI.SAVING_AMOUNT AS HOUSE_APP_DEPOSIT_AMT
                        FROM HRA_SAVING_INFO HSI
                          , HRM_SAVING_TYPE_V ST
                      WHERE HSI.SAVING_TYPE           = ST.SAVING_TYPE
                        AND HSI.SOB_ID                = ST.SOB_ID
                        AND HSI.ORG_ID                = ST.ORG_ID
                        AND ST.SAVING_GROUP           = 3  -- 주택저축 관련.
                        AND HSI.YEAR_YYYY             = P_YEAR_YYYY
                        AND HSI.PERSON_ID             = P_PERSON_ID
                        AND HSI.SOB_ID                = P_SOB_ID
                        AND HSI.ORG_ID                = P_ORG_ID
                     ) HF1
                WHERE HIT.YEAR_YYYY         = HF1.YEAR_YYYY
                  AND HIT.SOB_ID            = HF1.SOB_ID
                  AND HIT.ORG_ID            = HF1.ORG_ID
                  AND HIT.YEAR_YYYY         = P_YEAR_YYYY
                  AND HIT.SOB_ID            = P_SOB_ID
                  AND HIT.ORG_ID            = P_ORG_ID
               ) 
    LOOP
      V_HOUSE_APP_DEPOSIT_AMT := TRUNC(C1.HOUSE_APP_DEPOSIT_AMT * (C1.HOUSE_APP_DEPOSIT_RATE / 100));
      IF C1.HOUSE_APP_DEPOSIT_LMT < V_HOUSE_APP_DEPOSIT_AMT THEN
        V_HOUSE_APP_DEPOSIT_AMT := C1.HOUSE_APP_DEPOSIT_LMT;
      END IF;      
/*      -- 2011.01.17 BY YOUNG MIN;
      -- 주택임차차입금 소득공제금액 및 월세액공제액과 합산하여 연 300만원 한도;
      IF C1.HOUSE_AMT_LMT < (V_HOUSE_APP_DEPOSIT_AMT + I_HOUSE_DED_AMT) THEN
        V_HOUSE_APP_DEPOSIT_AMT := (V_HOUSE_APP_DEPOSIT_AMT + I_HOUSE_DED_AMT) - C1.HOUSE_AMT_LMT;
      END IF;
*/   
      /*UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.HOUSE_APP_DEPOSIT_AMT = NVL(V_HOUSE_APP_DEPOSIT_AMT, 0)
       WHERE HA.YEAR_YYYY         = P_YEAR_YYYY
         AND HA.PERSON_ID         = P_PERSON_ID
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
      ;*/
    END LOOP C1;
    O_STATUS := 'S';
    RETURN 0;
    /*RETURN NVL(V_HOUSE_APP_DEPOSIT_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Invest Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;*/
  END HOUSE_APP_DEPOSIT_CAL;

  -- 13. 신용카드등 공제;
  FUNCTION CARD_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER
  AS
    V_MIN_USER_LMT                NUMBER := 0;  -- 최저사용금액--
    V_CARD_LMT                    NUMBER := 0;  -- 신용카드 사용 한도;
       
    V_CARD_AMT                    NUMBER := 0;  -- 신용카드 공제;
    V_TRAD_MARKET_AMT             NUMBER := 0;  -- 신용카드 (전통시장) 추가공제 금액.
    V_PUBLIC_TRANSIT_AMT          NUMBER := 0;  -- 신용카드 (대중교통) 추가공제 금액.    
    V_OVER_AMT                    NUMBER := 0;  -- 초과금액;
    
    V_EXCEPT_CARD_AMT             NUMBER := 0;  -- 신용카드 공제 제외금액.
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.CARD_BAS_RATE, 0) AS CARD_BAS_RATE              -- 카드 최저 사용비율.
                    , NVL(HIT.CARD_DED_RATE, 0) AS CARD_DED_RATE              -- 카드 공제율.
                    , NVL(HIT.CHECK_CARD_DED_RATE, 0) AS CHECK_CARD_DED_RATE  -- 체크카드 공제비율(2010연말정산 추가);
                    , NVL(HIT.CARD_DED_LMT, 0) AS CARD_DED_LMT                -- 카드공제한도.
                    , NVL(HIT.CARD_DED_LMT_RATE, 0) AS CARD_DED_LMT_RATE      -- 공제 한도율.                    
                    -- 2012년 연말정산 추가 --
                    , NVL(HIT.TRAD_MARKET_DED_RATE, 0) AS TRAD_MARKET_DED_RATE-- 전통시장 공제율.                    
                    , NVL(HIT.CARD_MIN_USE_RATE_1, 0) AS CARD_MIN_USE_RATE_1  -- 최저사용금액율1.
                    , NVL(HIT.CARD_MIN_USE_RATE_2, 0) AS CARD_MIN_USE_RATE_2  -- 최저사용금액율2.
                    , NVL(HIT.CARD_ADD_DED_LMT, 0) AS CARD_ADD_DED_LMT        -- 추가공제 한도금액.
                    -- 2013.12.31 전호수 추가 -- 
                    , NVL(HIT.PUBLIC_TRANSIT_DED_RATE, 0) AS PUBLIC_TRANSIT_DED_RATE  -- 대중교통 공제율.
                    , NVL(HIT.PUBLIC_TRANSIT_DED_LMT, 0) AS PUBLIC_TRANSIT_DED_LMT    -- 대중교통공제 한도금액.
                    --> 신용카드 사용 내역
                    , ( NVL(HSF1.CREDIT_SUM, 0) + 
                        NVL(HSF1.CHECK_CREDIT_SUM, 0) + 
                        NVL(HSF1.TRAD_MARKET_SUM, 0) + 
                        NVL(HSF1.PUBLIC_TRANSIT_SUM, 0)) AS TOTAL_CARD_SUM    -- 총 사용금액 --
                    , NVL(HSF1.CREDIT_SUM, 0) AS CREDIT_SUM                   -- 신용카드.
                    , NVL(HSF1.CHECK_CREDIT_SUM, 0) AS CHECK_CREDIT_SUM       -- 직불카드.
                    , NVL(HSF1.TRAD_MARKET_SUM, 0) AS TRAD_MARKET_SUM         -- 전통시장.
                    , NVL(HSF1.PUBLIC_TRANSIT_SUM, 0) AS PUBLIC_TRANSIT_SUM   -- 2013.12.31 전호수 추가 : 대중교통.
                 FROM HRA_INCOME_TAX_STANDARD HIT
                    , ( --  부양가족자료  조회  
                        SELECT HSF.YEAR_YYYY
                             , HSF.SOB_ID
                             , HSF.ORG_ID
                             , SUM( NVL(HSF.CREDIT_AMT, 0) +
                                    NVL(HSF.ETC_CREDIT_AMT, 0) +
                                    NVL(HSF.ACADE_GIRO_AMT, 0) +
                                    NVL(HSF.ETC_ACADE_GIRO_AMT, 0)) AS CREDIT_SUM                   -- 신용카드.
                             , SUM( NVL(HSF.CHECK_CREDIT_AMT, 0) +
                                    NVL(HSF.ETC_CHECK_CREDIT_AMT, 0) +
                                    NVL(HSF.CASH_AMT, 0) +
                                    NVL(HSF.ETC_CASH_AMT, 0)) AS CHECK_CREDIT_SUM     -- 직불카드.
                             , SUM( NVL(HSF.TRAD_MARKET_AMT, 0) +  
                                    NVL(HSF.ETC_TRAD_MARKET_AMT, 0)) AS TRAD_MARKET_SUM       -- 전통시장.
                             , SUM( NVL(HSF.PUBLIC_TRANSIT_AMT, 0) +  
                                    NVL(HSF.ETC_PUBLIC_TRANSIT_AMT, 0)) AS PUBLIC_TRANSIT_SUM -- 2013.12.31 전호수 추가 : 대중교통.
                          FROM HRA_SUPPORT_FAMILY HSF
                         WHERE HSF.YEAR_YYYY    = P_YEAR_YYYY
                           AND HSF.PERSON_ID    = P_PERSON_ID
                           AND HSF.SOB_ID       = P_SOB_ID
                           AND HSF.ORG_ID       = P_ORG_ID
                           AND HSF.REPRE_NUM IS NOT NULL
                        GROUP BY HSF.YEAR_YYYY, HSF.PERSON_ID, HSF.SOB_ID, HSF.ORG_ID
                       ) HSF1
                WHERE HIT.YEAR_YYYY       = HSF1.YEAR_YYYY
                  AND HIT.SOB_ID          = HSF1.SOB_ID
                  AND HIT.ORG_ID          = HSF1.ORG_ID
                  AND HIT.YEAR_YYYY       = P_YEAR_YYYY
                  AND HIT.SOB_ID          = P_SOB_ID
                  AND HIT.ORG_ID          = P_ORG_ID
               ) 
     LOOP
      /*        --  신용카드 사용 금액   
      V_CARD_AMT := C1.CREDIT_SUM - TRUNC(I_TOTAL_PAY * (C1.CARD_BAS_RATE / 100));
      V_CARD_AMT := TRUNC(V_CARD_AMT * (C1.CARD_DED_RATE / 100));*/
    
      -- 2011.01.17 MODYFIED BY YOUNG MIN;
      --  신용카드 사용 금액   
      -- 초과금액 = 신용카드 등 사용금액 - 총급여액 * 25%;
      -- 공제금액 = 초과금액 * (신용카드+현금+학원등)/신용카드 등 사용금액 * 20%;
      --            + 초과금액 * (이외 신용카드등 사용금액)/신용카드 등 사용금액 * 25%;
      
      -- 1. 최저사용 금액 설정 --
      V_MIN_USER_LMT := TRUNC(NVL(P_TOTAL_PAY, 0) * (C1.CARD_BAS_RATE/100)); 
      
      -- 2. 초과금액 --
      V_OVER_AMT := ( NVL(C1.CREDIT_SUM, 0) + NVL(C1.CHECK_CREDIT_SUM, 0) + 
                      NVL(C1.TRAD_MARKET_SUM, 0) + NVL(C1.PUBLIC_TRANSIT_SUM, 0)) - 
                      NVL(V_MIN_USER_LMT, 0);
      
      -- 3. 일반공제 금액 --
      -- 계산 : (전통시장 + 직불카드) * 공제율 + (신용카드사용분-최저사용금액) * 공제율.
      V_CARD_AMT := TRUNC(NVL(C1.TRAD_MARKET_SUM * (C1.TRAD_MARKET_DED_RATE / 100), 0) +        -- 전통시장 --
                          NVL(C1.PUBLIC_TRANSIT_SUM * (C1.PUBLIC_TRANSIT_DED_RATE / 100), 0) +  -- 대중교통 --
                          NVL(C1.CHECK_CREDIT_SUM * (C1.CHECK_CARD_DED_RATE / 100), 0) +        -- 직불카드 --
                          NVL(C1.CREDIT_SUM * (C1.CARD_DED_RATE / 100), 0));                 -- 카드--
      
      -- 3.1 공제 제외 금액 --
      IF NVL(V_MIN_USER_LMT, 0) <= NVL(C1.CREDIT_SUM, 0) THEN 
        -- 최저사용금액(총급여의 25%) <= 신용카드 사용분 : 최저사용금액 * 20% --
        V_EXCEPT_CARD_AMT := TRUNC(V_MIN_USER_LMT * (C1.CARD_MIN_USE_RATE_1 / 100));
      ELSE
        -- 최저사용금액(총급여의 25%) > 신용카드 사용분 : 신용카드 사용분 * 20% + (최저사용금액-신용카드사용분) * 30% --
        V_EXCEPT_CARD_AMT := TRUNC(C1.CREDIT_SUM * (C1.CARD_MIN_USE_RATE_1 / 100))
                             + TRUNC((NVL(V_MIN_USER_LMT, 0) - NVL(C1.CREDIT_SUM, 0)) * (C1.CARD_MIN_USE_RATE_2 / 100));
      END IF;
      V_CARD_AMT := TRUNC(NVL(V_CARD_AMT, 0) - NVL(V_EXCEPT_CARD_AMT, 0));
      
      /*IF NVL(V_MIN_USER_LMT, 0) <= NVL(C1.TOTAL_CARD_SUM, 0) THEN 
        -- 계산 : (전통시장 + 직불카드) * 공제율 + (신용카드사용분-최저사용금액) * 공제율.
        V_CARD_AMT := TRUNC(NVL(C1.TRAD_MARKET_SUM * (C1.TRAD_MARKET_DED_RATE / 100), 0) +  -- 전통시장 --
                            NVL(C1.CHECK_CREDIT_SUM * (C1.CHECK_CARD_DED_RATE / 100), 0) +  -- 직불카드 --
                            NVL((NVL(C1.CREDIT_SUM, 0) - NVL(V_MIN_USER_LMT, 0)) * (C1.CARD_MIN_USE_RATE_1 / 100), 0));
      ELSE
        V_CARD_AMT := TRUNC(NVL(C1.TRAD_MARKET_SUM * (C1.TRAD_MARKET_DED_RATE / 100), 0) +  -- 전통시장 --
                            NVL(C1.CHECK_CREDIT_SUM * (C1.CHECK_CARD_DED_RATE / 100), 0) +  -- 직불카드 --
                            NVL((NVL(C1.CREDIT_SUM, 0) - NVL(V_MIN_USER_LMT, 0)) * (C1.CARD_MIN_USE_RATE_2 / 100), 0));
      END IF;*/
                          
      -- 4. 총급여에 대한 한도 --  
      V_CARD_LMT := TRUNC(P_TOTAL_PAY * (C1.CARD_DED_RATE / 100));
      IF C1.CARD_DED_LMT < V_CARD_LMT THEN
        V_CARD_LMT := C1.CARD_DED_LMT;
      END IF;
    
      -- 5. 신용카드 사용금액 --
      V_OVER_AMT := 0;
      IF V_CARD_LMT < V_CARD_AMT THEN
        V_OVER_AMT := NVL(V_CARD_AMT, 0) - NVL(V_CARD_LMT, 0);  -- 한도 초과 금액 산출 --
        V_CARD_AMT := V_CARD_LMT;
      END IF;
      -- 음수 => 0 --
      IF V_CARD_AMT < 0 THEN
        V_CARD_AMT := 0;
      END IF;
      
      -- 6.1 추가공제 금액 --
      V_TRAD_MARKET_AMT := TRUNC(NVL(C1.TRAD_MARKET_SUM * (C1.TRAD_MARKET_DED_RATE / 100), 0));
      IF V_OVER_AMT < V_TRAD_MARKET_AMT THEN
        -- 한도 초과금액 VS 전통시장 사용분 비교하여 적은값 적용 --
        V_TRAD_MARKET_AMT := V_OVER_AMT;
      END IF;
      IF C1.CARD_ADD_DED_LMT < V_TRAD_MARKET_AMT THEN
        -- 6.1값과 추가공제 한도 비교하여 적은값 적용 --
        V_TRAD_MARKET_AMT := C1.CARD_ADD_DED_LMT;
      END IF;
      -- 음수 => 0 --
      IF NVL(V_TRAD_MARKET_AMT, 0) < 0 THEN
        V_TRAD_MARKET_AMT := 0;
      END IF;
      
      -- 6.2 2013.12.31 전호수 추가 : (대중교통) 추가공제 금액 --
      V_PUBLIC_TRANSIT_AMT := TRUNC(NVL(C1.PUBLIC_TRANSIT_SUM * (C1.PUBLIC_TRANSIT_DED_RATE / 100), 0));
      IF V_OVER_AMT < V_PUBLIC_TRANSIT_AMT THEN
        -- 한도 초과금액 VS 전통시장 사용분 비교하여 적은값 적용 --
        V_PUBLIC_TRANSIT_AMT := V_OVER_AMT;
      END IF;
      IF C1.PUBLIC_TRANSIT_DED_LMT < V_PUBLIC_TRANSIT_AMT THEN
        -- 6.2값과 추가공제 한도 비교하여 적은값 적용 --
        V_PUBLIC_TRANSIT_AMT := C1.PUBLIC_TRANSIT_DED_LMT;
      END IF;
      -- 음수 => 0 --
      IF NVL(V_PUBLIC_TRANSIT_AMT, 0) < 0 THEN
        V_PUBLIC_TRANSIT_AMT := 0;
      END IF;     
      
      -- 신용카드 공제 금액 --
      V_CARD_AMT := NVL(V_CARD_AMT, 0) + NVL(V_TRAD_MARKET_AMT, 0) +
                    NVL(V_PUBLIC_TRANSIT_AMT, 0);
      IF V_CARD_AMT < 0 THEN
        V_CARD_AMT := 0;
      END IF;
      
      --> 신용카드 공제   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.CREDIT_AMT      = NVL(V_CARD_AMT, 0)
       WHERE HA.YEAR_YYYY       = P_YEAR_YYYY
         AND HA.PERSON_ID       = P_PERSON_ID
         AND HA.SOB_ID          = P_SOB_ID
         AND HA.ORG_ID          = P_ORG_ID
      ;    
    END LOOP C1; 
    O_STATUS := 'S'; 
    RETURN NVL(V_CARD_AMT, 0);  
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Credit Card Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END CARD_CAL;

  -- 14. 우리사주출연;
  FUNCTION EMPL_STOCK_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_EMPL_STOCK_AMT              NUMBER := 0; -- 우리사주출연금  
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.STOCK_LMT, 0) STOCK_LMT
                    --> 우리사주조합출연금            
                    , NVL(HF1.EMPL_STOCK_AMT, 0) EMPL_STOCK_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  연말정산 기초자료  조회  
                      SELECT HF.YEAR_YYYY
                          , HF.SOB_ID
                          , HF.ORG_ID
                          , HF.EMPL_STOCK_AMT
                        FROM HRA_FOUNDATION HF
                       WHERE HF.YEAR_YYYY   = P_YEAR_YYYY
                         AND HF.PERSON_ID   = P_PERSON_ID
                         AND HF.SOB_ID      = P_SOB_ID
                         AND HF.ORG_ID      = P_ORG_ID
                     ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
               ) 
    LOOP
      --  우리사주출연금 
      V_EMPL_STOCK_AMT := C1.EMPL_STOCK_AMT;
      IF C1.STOCK_LMT < V_EMPL_STOCK_AMT THEN
        V_EMPL_STOCK_AMT := C1.STOCK_LMT;
      END IF;
    
      -- 우리사주 공제   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.EMPL_STOCK_AMT = NVL(V_EMPL_STOCK_AMT, 0)
       WHERE HA.YEAR_YYYY       = P_YEAR_YYYY
         AND HA.PERSON_ID       = P_PERSON_ID
         AND HA.SOB_ID          = P_SOB_ID
         AND HA.ORG_ID          = P_ORG_ID
      ;
    END LOOP C1;
    O_STATUS := 'S';
    RETURN NVL(V_EMPL_STOCK_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Employee Stock Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END EMPL_STOCK_CAL;

  -- 14-1. 소기업/소상공인 공제부금에 대한 소득공제;
  FUNCTION SMALL_CORPOR_DED_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_SMALL_CORPOR_DED_AMT NUMBER := 0;
  BEGIN
    O_STATUS := 'S';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.SMALL_CORPOR_DED_LMT, 0) SMALL_CORPOR_DED_LMT
                    --> 소기업/소상공인공제부금액;        
                    , NVL(HF1.SMALL_CORPOR_DED_AMT, 0) SMALL_CORPOR_DED_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  연말정산 기초자료  조회  
                     SELECT HF.YEAR_YYYY 
                         , HF.SOB_ID
                         , HF.ORG_ID
                         , HF.SMALL_CORPOR_DED_AMT
                       FROM HRA_FOUNDATION HF
                      WHERE HF.YEAR_YYYY    = P_YEAR_YYYY
                        AND HF.PERSON_ID    = P_PERSON_ID
                        AND HF.SOB_ID       = P_SOB_ID
                        AND HF.ORG_ID       = P_ORG_ID
                     ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
              ) 
    LOOP
      V_SMALL_CORPOR_DED_AMT := 0;
      --  소기업/소상공인 공제부금액;
      V_SMALL_CORPOR_DED_AMT := C1.SMALL_CORPOR_DED_AMT;
      IF C1.SMALL_CORPOR_DED_LMT < V_SMALL_CORPOR_DED_AMT THEN
        V_SMALL_CORPOR_DED_AMT := C1.SMALL_CORPOR_DED_LMT;
      END IF;
    
      --> 소기업/소상공인 공제   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.SMALL_CORPOR_DED_AMT  = NVL(V_SMALL_CORPOR_DED_AMT, 0)
       WHERE HA.YEAR_YYYY             = P_YEAR_YYYY
         AND HA.PERSON_ID             = P_PERSON_ID
         AND HA.SOB_ID                = P_SOB_ID
         AND HA.ORG_ID                = P_ORG_ID
      ;
    END LOOP C1;
    O_STATUS := 'S';
    RETURN NVL(V_SMALL_CORPOR_DED_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Small Corpor Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END SMALL_CORPOR_DED_CAL;

  -- 14-2. 장기주식형저축소득공제;
  FUNCTION LONG_STOCK_SAVING_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    -- 공제 누적금액.
    V_LONG_STOCK_SAVING_AMT       NUMBER := 0;
    -- 공제금액.
    V_LONG_STOCK_SAVING_AMT1      NUMBER := 0;
    V_LONG_STOCK_SAVING_AMT2      NUMBER := 0;
    V_LONG_STOCK_SAVING_AMT3      NUMBER := 0;
    
    -- 누적금액(한도체크).
    V_SUM_LONG_STOCK_SAVING_AMT1  NUMBER := 0;  
    V_SUM_LONG_STOCK_SAVING_AMT2  NUMBER := 0;
    V_SUM_LONG_STOCK_SAVING_AMT3  NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.LONG_STOCK_SAVING_RATE_1, 0) LONG_STOCK_SAVING_RATE_1
                    , NVL(HIT.LONG_STOCK_SAVING_LMT_1, 0) LONG_STOCK_SAVING_LMT_1
                    , NVL(HIT.LONG_STOCK_SAVING_RATE_2, 0) LONG_STOCK_SAVING_RATE_2
                    , NVL(HIT.LONG_STOCK_SAVING_LMT_2, 0) LONG_STOCK_SAVING_LMT_2
                    , NVL(HIT.LONG_STOCK_SAVING_RATE_3, 0) LONG_STOCK_SAVING_RATE_3 
                    , NVL(HIT.LONG_STOCK_SAVING_LMT_3, 0) LONG_STOCK_SAVING_LMT_3
                    --> 장기주식형저축소득공제;
                    , HF1.SAVING_INFO_ID
                    , NVL(HF1.SAVING_COUNT, 0) SAVING_COUNT
                    , NVL(HF1.SAVING_AMOUNT, 0) SAVING_AMOUNT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  연말정산 기초자료  조회  
                     SELECT HSI.SAVING_INFO_ID
                          , HSI.YEAR_YYYY
                          , HSI.SOB_ID
                          , HSI.ORG_ID
                          , HSI.SAVING_COUNT
                          , HSI.SAVING_AMOUNT AS SAVING_AMOUNT
                        FROM HRA_SAVING_INFO HSI
                          , HRM_SAVING_TYPE_V ST
                      WHERE HSI.SAVING_TYPE             = ST.SAVING_TYPE
                        AND HSI.SOB_ID                  = ST.SOB_ID
                        AND HSI.ORG_ID                  = ST.ORG_ID
                        AND HSI.YEAR_YYYY               = P_YEAR_YYYY
                        AND HSI.SOB_ID                  = P_SOB_ID
                        AND HSI.ORG_ID                  = P_ORG_ID
                        AND HSI.PERSON_ID               = P_PERSON_ID
                        AND HSI.SAVING_TYPE             IN ('41')
                     ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
                ORDER BY HF1.SAVING_COUNT
              ) 
    LOOP
      IF C1.SAVING_COUNT = 1 THEN
        --  장기주식형저축소득공제 1년차;
        V_LONG_STOCK_SAVING_AMT1 := C1.SAVING_AMOUNT;
        IF C1.LONG_STOCK_SAVING_LMT_1 < NVL(V_SUM_LONG_STOCK_SAVING_AMT1, 0) + NVL(V_LONG_STOCK_SAVING_AMT1, 0) THEN
          V_LONG_STOCK_SAVING_AMT1 := NVL(C1.LONG_STOCK_SAVING_LMT_1, 0) - NVL(V_SUM_LONG_STOCK_SAVING_AMT1, 0);
        END IF;
        -- 한도 누적;
        V_SUM_LONG_STOCK_SAVING_AMT1 := NVL(V_SUM_LONG_STOCK_SAVING_AMT1, 0) + NVL(V_LONG_STOCK_SAVING_AMT1, 0);
        -- 공제금액 계산.
        V_LONG_STOCK_SAVING_AMT1 := TRUNC(V_LONG_STOCK_SAVING_AMT1 * (C1.LONG_STOCK_SAVING_RATE_1 / 100));        
        -- 공제 누적금액.
        V_LONG_STOCK_SAVING_AMT := NVL(V_LONG_STOCK_SAVING_AMT, 0) + NVL(V_LONG_STOCK_SAVING_AMT1, 0);
      ELSIF C1.SAVING_COUNT = 2 THEN
        --  장기주식형저축소득공제 2년차;
        V_LONG_STOCK_SAVING_AMT2 := C1.SAVING_AMOUNT;
        IF C1.LONG_STOCK_SAVING_LMT_2 < NVL(V_SUM_LONG_STOCK_SAVING_AMT2, 0) + NVL(V_LONG_STOCK_SAVING_AMT2, 0) THEN
          V_LONG_STOCK_SAVING_AMT2 := NVL(C1.LONG_STOCK_SAVING_LMT_2, 0) - NVL(V_SUM_LONG_STOCK_SAVING_AMT2, 0);
        END IF;
        -- 한도 누적;
        V_SUM_LONG_STOCK_SAVING_AMT2 := NVL(V_SUM_LONG_STOCK_SAVING_AMT2, 0) + NVL(V_LONG_STOCK_SAVING_AMT2, 0);
        -- 공제금액 계산.
        V_LONG_STOCK_SAVING_AMT2 := TRUNC(V_LONG_STOCK_SAVING_AMT2 * (C1.LONG_STOCK_SAVING_RATE_2 / 100));        
        -- 공제 누적금액.
        V_LONG_STOCK_SAVING_AMT := NVL(V_LONG_STOCK_SAVING_AMT, 0) + NVL(V_LONG_STOCK_SAVING_AMT2, 0);
      ELSE
        --  장기주식형저축소득공제 3년차;
        V_LONG_STOCK_SAVING_AMT3 := C1.SAVING_AMOUNT;
        IF C1.LONG_STOCK_SAVING_LMT_3 < NVL(V_SUM_LONG_STOCK_SAVING_AMT3, 0) + NVL(V_LONG_STOCK_SAVING_AMT3, 0) THEN
          V_LONG_STOCK_SAVING_AMT3 := NVL(C1.LONG_STOCK_SAVING_LMT_3, 0) - NVL(V_SUM_LONG_STOCK_SAVING_AMT3, 0);
        END IF;
        -- 한도 누적;
        V_SUM_LONG_STOCK_SAVING_AMT3 := NVL(V_SUM_LONG_STOCK_SAVING_AMT3, 0) + NVL(V_LONG_STOCK_SAVING_AMT3, 0);
        -- 공제금액 계산.
        V_LONG_STOCK_SAVING_AMT3 := TRUNC(V_LONG_STOCK_SAVING_AMT3 * (C1.LONG_STOCK_SAVING_RATE_3 / 100));        
        -- 공제 누적금액.
        V_LONG_STOCK_SAVING_AMT := NVL(V_LONG_STOCK_SAVING_AMT, 0) + NVL(V_LONG_STOCK_SAVING_AMT3, 0);
      END IF;
      
      UPDATE HRA_SAVING_INFO SI
        SET SI.SAVING_DED_AMOUNT = CASE
                                     WHEN C1.SAVING_COUNT = 1 THEN V_LONG_STOCK_SAVING_AMT1
                                     WHEN C1.SAVING_COUNT = 2 THEN V_LONG_STOCK_SAVING_AMT2
                                     ELSE V_LONG_STOCK_SAVING_AMT3
                                   END
      WHERE SI.SAVING_INFO_ID    = C1.SAVING_INFO_ID
      ;
    END LOOP C1;
    
    --> 장기주식형저축소득공제   UPDATE
    UPDATE HRA_YEAR_ADJUSTMENT HA
      SET HA.LONG_STOCK_SAVING_AMT   = V_LONG_STOCK_SAVING_AMT
    WHERE HA.YEAR_YYYY         = P_YEAR_YYYY
      AND HA.PERSON_ID         = P_PERSON_ID
      AND HA.SOB_ID            = P_SOB_ID
      AND HA.ORG_ID            = P_ORG_ID
    ;    
    O_STATUS := 'S';
    RETURN NVL(V_LONG_STOCK_SAVING_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Long Stock Saving Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END LONG_STOCK_SAVING_CAL;

  -- 14-4. 목돈안드는 전세 이자상환액 공제;
  FUNCTION FIX_LEASE_DED_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER 
  AS
    V_FIX_LEASE_DED_AMT   NUMBER := 0; -- 목돈안드는 전세 이자상환액       
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.FIX_LEASE_DED_RATE, 0) AS FIX_LEASE_DED_RATE
                    , NVL(HIT.FIX_LEASE_DED_LMT, 0) AS FIX_LEASE_DED_LMT 
                    --> 목돈안드는 전세 이자상환액            
                    , NVL(HF1.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  연말정산 기초자료  조회  
                      SELECT HF.YEAR_YYYY
                          , HF.SOB_ID
                          , HF.ORG_ID
                          , HF.FIX_LEASE_DED_AMT
                        FROM HRA_FOUNDATION HF
                       WHERE HF.YEAR_YYYY   = P_YEAR_YYYY
                         AND HF.PERSON_ID   = P_PERSON_ID
                         AND HF.SOB_ID      = P_SOB_ID
                         AND HF.ORG_ID      = P_ORG_ID
                     ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
               ) 
    LOOP
      --  목돈안드는 전세 이자상환액     
      V_FIX_LEASE_DED_AMT := TRUNC((C1.FIX_LEASE_DED_AMT * (C1.FIX_LEASE_DED_RATE / 100)));
      IF C1.FIX_LEASE_DED_LMT < V_FIX_LEASE_DED_AMT THEN
        V_FIX_LEASE_DED_AMT := C1.FIX_LEASE_DED_LMT;
      END IF;
    
      -- 목돈안드는 전세 이자상환액 UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.FIX_LEASE_DED_AMT = NVL(V_FIX_LEASE_DED_AMT, 0)
       WHERE HA.YEAR_YYYY         = P_YEAR_YYYY
         AND HA.PERSON_ID         = P_PERSON_ID
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
      ;
    END LOOP C1;
    O_STATUS := 'S';
    RETURN NVL(V_FIX_LEASE_DED_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Fix Lease Ded Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END FIX_LEASE_DED_CAL;

-- 14-9. 특별공제 종합한도 초과액;
  FUNCTION SPECIAL_DED_LMT_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_SP_DED_TOT_AMT        NUMBER := 0; -- 2013-특별공제 종합한도 초과액 기준  
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.SP_DED_TOT_LMT, 0) AS SP_DED_TOT_LMT
                    /*-- 대상 항목 -- 
                    -- 1.보장성 보험료 + 2.기타의료비 + 3.기타 교육비 + 4.주택임차차입금원리금 상환액 +
                    -- 5.월세액 + 6.장기주택저당차입금 이자상환액 + 7.기부금 중 지정기부금(2013이후 지출분만) + 
                    -- 8.주택마련저축 + 9.신용카드등 사용금액 + 10.소기업,소상공인 공제부금 + 
                    -- 11.투자조합등출자(2013년 이후투자분만) + 12.우리사주출연금
                    */ 
                    , NVL(HF1.SP_DED_SUM_AMT, 0) AS SP_DED_SUM_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  연말정산 기초자료  조회  
                       SELECT HA.YEAR_YYYY
                            , HA.SOB_ID
                            , HA.ORG_ID
                            , ( NVL(HA.GUAR_INSUR_AMT, 0) +    -- 1.보장성 보험료 
                                NVL(HA.ETC_MEDIC_AMT, 0) +     -- 2.기타의료비  
                                NVL(HA.ETC_EDUCATION_AMT, 0) + -- 3.기타교육비  
                                NVL(HA.HOUSE_FUND_AMT, 0) + -- 주택자금(주택임차차입금상환액 + 월세액 +장기주택저당차입금 + 주택마련저축액) 
                                NVL(HA.CREDIT_AMT, 0) +    -- 신용카드 
                                NVL(HA.SMALL_CORPOR_DED_AMT, 0) +    -- 10.소기업,소상공인 공제부금  
                                NVL(HA.INVEST_AMT_13, 0) +    -- 11.투자조합등출자(2013년 이후투자분만)  
                                NVL(HA.EMPL_STOCK_AMT, 0)) AS SP_DED_SUM_AMT  
                         FROM HRA_YEAR_ADJUSTMENT HA                           
                        WHERE HA.YEAR_YYYY              = P_YEAR_YYYY
                          AND HA.PERSON_ID              = P_PERSON_ID
                          AND HA.SOB_ID                 = P_SOB_ID
                          AND HA.ORG_ID                 = P_ORG_ID
                     ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
               ) 
    LOOP
      -- 특별공제 종합한도 초과액  
      V_SP_DED_TOT_AMT := 0; 
      IF C1.SP_DED_TOT_LMT < C1.SP_DED_SUM_AMT THEN
        V_SP_DED_TOT_AMT := NVL(C1.SP_DED_SUM_AMT, 0) - NVL(C1.SP_DED_TOT_LMT, 0);
      END IF;
    
      -- 특별공제 종합한도 초과액 UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.SP_DED_TOT_AMT    = NVL(V_SP_DED_TOT_AMT, 0)
       WHERE HA.YEAR_YYYY         = P_YEAR_YYYY
         AND HA.PERSON_ID         = P_PERSON_ID
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
      ;
    END LOOP C1;
    O_STATUS := 'S';
    RETURN NVL(V_SP_DED_TOT_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Special Deduction Lmt Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END SPECIAL_DED_LMT_CAL;                       
              
  -- 15. 과세표준 ;
  FUNCTION COMP_TAX_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TAX_STD_AMT       IN NUMBER
            ) RETURN NUMBER
  AS
    V_COMP_TAX_AMT                NUMBER := 0; -- 산출세액  
    V_TAX_RATE                    NUMBER := 0; -- 산출세율  
    V_ACCUM_AMT                   NUMBER := 0; -- 누진금액 
  BEGIN
    O_STATUS := 'F';
    BEGIN
      --> 산출세액 조회  
      SELECT TR.TAX_RATE, TR.ACCUM_SUB_AMOUNT
        INTO V_TAX_RATE, V_ACCUM_AMT
        FROM HRA_TAX_RATE TR
          , HRM_COMMON    HC
      WHERE TR.TAX_TYPE_ID              = HC.COMMON_ID
        AND TR.TAX_YYYY                 = P_YEAR_YYYY
        AND HC.CODE                     = '10'
        AND TR.SOB_ID                   = P_SOB_ID
        AND TR.ORG_ID                   = P_ORG_ID
        AND NVL(P_TAX_STD_AMT, 0)       BETWEEN NVL(TR.START_AMOUNT, 0) AND NVL(TR.END_AMOUNT, 0)
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_TAX_RATE  := 1;
        V_ACCUM_AMT := 0;
        O_STATUS := 'F';
        O_MESSAGE := '1.Comp Tax Cal Error : (' || P_TAX_STD_AMT || ') ' || SUBSTR(SQLERRM, 1, 200);
        RETURN 0;
    END;
  
    --> 산출세액 계산  
    V_COMP_TAX_AMT := 0;
    V_COMP_TAX_AMT := TRUNC(P_TAX_STD_AMT * (V_TAX_RATE / 100));
    V_COMP_TAX_AMT := NVL(V_COMP_TAX_AMT, 0) - NVL(V_ACCUM_AMT, 0);
  
    IF V_COMP_TAX_AMT < 0 THEN
      V_COMP_TAX_AMT := 0;
    END IF;
    O_STATUS := 'S';
    RETURN NVL(V_COMP_TAX_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := '2.Comp Tax Cal Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END COMP_TAX_CAL;

  -- 16.1 세액감면 - 소득세법 ;
  FUNCTION TAX_REDU_IN_LAW_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_INCOME_AMT        IN NUMBER
            , P_COMP_TAX_AMT      IN NUMBER
            ) RETURN NUMBER
  AS
    V_TAX_REDU_IN_LAW_AMT       NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    /*FOR C1 IN (SELECT HIT.YEAR_YYYY
                   , NVL(HIT.TAX_ASSO_RATE, 0) TAX_ASSO_RATE
                 FROM HRA_INCOME_TAX_STANDARD HIT
                WHERE HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
              ) 
    LOOP    
      -- 납세조합 공제    
      V_TAX_DED_TAXGROUP_AMT := TRUNC(P_COMP_TAX_AMT * (C1.TAX_ASSO_RATE / 100));
    
      -----> 근로소득 공제   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.TAX_DED_TAXGROUP_AMT = NVL(V_TAX_DED_TAXGROUP_AMT, 0)
       WHERE HA.YEAR_YYYY         = C1.YEAR_YYYY
         AND HA.PERSON_ID         = P_PERSON_ID
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
       ;    
    END LOOP C1;*/
    O_STATUS := 'S';
    RETURN NVL(V_TAX_REDU_IN_LAW_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Tax Redu Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END TAX_REDU_IN_LAW_CAL;

  -- 16.2 세액감면 - 조세특례제한법 ;
  FUNCTION TAX_REDU_SP_LAW_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_INCOME_AMT        IN NUMBER
            , P_COMP_TAX_AMT      IN NUMBER
            ) RETURN NUMBER
  AS
    V_TAX_REDU_SP_LAW_AMT       NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
   /* FOR C1 IN (SELECT HIT.YEAR_YYYY
                   , NVL(HIT.TAX_ASSO_RATE, 0) TAX_ASSO_RATE
                 FROM HRA_INCOME_TAX_STANDARD HIT
                WHERE HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
              ) 
    LOOP    
      -- 납세조합 공제    
      V_TAX_DED_TAXGROUP_AMT := TRUNC(P_COMP_TAX_AMT * (C1.TAX_ASSO_RATE / 100));
    
      -----> 근로소득 공제   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.TAX_DED_TAXGROUP_AMT = NVL(V_TAX_DED_TAXGROUP_AMT, 0)
       WHERE HA.YEAR_YYYY         = C1.YEAR_YYYY
         AND HA.PERSON_ID         = P_PERSON_ID
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
       ;    
    END LOOP C1;*/
    O_STATUS := 'S';
    RETURN NVL(V_TAX_REDU_SP_LAW_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Tax Redu Sp Law Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END TAX_REDU_SP_LAW_CAL;

  -- 16.3 세액감면 - 조세조약;
  FUNCTION TAX_REDU_TAX_TREATY_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_INCOME_AMT        IN NUMBER
            , P_COMP_TAX_AMT      IN NUMBER
            ) RETURN NUMBER
  AS
    V_TAX_REDU_TAX_TREATY_AMT   NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    /* FOR C1 IN (SELECT HIT.YEAR_YYYY
                   , NVL(HIT.TAX_ASSO_RATE, 0) TAX_ASSO_RATE
                 FROM HRA_INCOME_TAX_STANDARD HIT
                WHERE HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
              ) 
    LOOP    
      -- 납세조합 공제    
      V_TAX_DED_TAXGROUP_AMT := TRUNC(P_COMP_TAX_AMT * (C1.TAX_ASSO_RATE / 100));
    
      -----> 근로소득 공제   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.TAX_DED_TAXGROUP_AMT = NVL(V_TAX_DED_TAXGROUP_AMT, 0)
       WHERE HA.YEAR_YYYY         = C1.YEAR_YYYY
         AND HA.PERSON_ID         = P_PERSON_ID
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
       ;    
    END LOOP C1;*/
    O_STATUS := 'S';
    RETURN NVL(V_TAX_REDU_TAX_TREATY_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Tax Redu Tax Treaty Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END TAX_REDU_TAX_TREATY_CAL;
            
            
  -- 17.1 근로소득세액공제 ;
  FUNCTION TAX_DED_INCOME_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_COMP_TAX_AMT      IN NUMBER
            ) RETURN NUMBER
  AS
    V_TAX_DED_AMT                 NUMBER := 0; -- 근로소득 세액공제
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN (SELECT HIT.YEAR_YYYY
                    , NVL(HIT.IN_TAX_STD_A, 0) IN_TAX_STD_A
                    , NVL(HIT.IN_TAX_RATE_A, 0) IN_TAX_RATE_A
                    , NVL(HIT.IN_TAX_STD_B, 0) IN_TAX_STD_B
                    , NVL(HIT.IN_TAX_RATE_B, 0) IN_TAX_RATE_B
                    , NVL(HIT.IN_TAX_BASE_B, 0) IN_TAX_BASE_B
                    , NVL(HIT.IN_TAX_STD_C, 0) IN_TAX_STD_C
                    , NVL(HIT.IN_TAX_LMT, 0) IN_TAX_LMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                WHERE HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
                ) 
    LOOP
      IF NVL(P_COMP_TAX_AMT, 0) <= NVL(C1.IN_TAX_STD_A, 0) THEN
        V_TAX_DED_AMT := TRUNC(P_COMP_TAX_AMT * (C1.IN_TAX_RATE_A / 100));
      ELSIF NVL(P_COMP_TAX_AMT, 0) < NVL(C1.IN_TAX_STD_C, 0) THEN
        V_TAX_DED_AMT := TRUNC(P_COMP_TAX_AMT * (NVL(C1.IN_TAX_RATE_B, 0) / 100));
        V_TAX_DED_AMT := NVL(V_TAX_DED_AMT, 0) + NVL(C1.IN_TAX_BASE_B, 0);
      ELSIF  NVL(C1.IN_TAX_STD_C, 0) <= NVL(P_COMP_TAX_AMT, 0) THEN
        V_TAX_DED_AMT := C1.IN_TAX_LMT;
      ELSE
        V_TAX_DED_AMT := 0;        
      END IF;      
      -- 한도  
      IF C1.IN_TAX_LMT < V_TAX_DED_AMT THEN
        V_TAX_DED_AMT := C1.IN_TAX_LMT;
      END IF;
    
-----> 근로소득 공제   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.TAX_DED_INCOME_AMT      = NVL(V_TAX_DED_AMT, 0)
       WHERE HA.YEAR_YYYY               = P_YEAR_YYYY
         AND HA.PERSON_ID               = P_PERSON_ID
         AND HA.SOB_ID                  = P_SOB_ID
         AND HA.ORG_ID                  = P_ORG_ID
      ;    
    END LOOP C1; 
    O_STATUS := 's'; 
    RETURN NVL(V_TAX_DED_AMT, 0);  
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Tax Ded Income Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END TAX_DED_INCOME_CAL;

  -- 17.2 납세조합 세액공제;
  FUNCTION TAX_DED_TAXGROUP_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_COMP_TAX_AMT      IN NUMBER
            ) RETURN NUMBER
  AS
    V_TAX_DED_TAXGROUP_AMT        NUMBER := 0; -- 납세조합공제금액  
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN (SELECT HIT.YEAR_YYYY
                   , NVL(HIT.TAX_ASSO_RATE, 0) TAX_ASSO_RATE
                 FROM HRA_INCOME_TAX_STANDARD HIT
                WHERE HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
              ) 
    LOOP    
      -- 납세조합 공제    
      V_TAX_DED_TAXGROUP_AMT := TRUNC(P_COMP_TAX_AMT * (C1.TAX_ASSO_RATE / 100));
    
      -----> 근로소득 공제   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.TAX_DED_TAXGROUP_AMT = NVL(V_TAX_DED_TAXGROUP_AMT, 0)
       WHERE HA.YEAR_YYYY         = C1.YEAR_YYYY
         AND HA.PERSON_ID         = P_PERSON_ID
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
       ;    
    END LOOP C1;
    O_STATUS := 'S';
    RETURN NVL(V_TAX_DED_TAXGROUP_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Tax Ded Taxgroup Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END TAX_DED_TAXGROUP_CAL;

  -- 17.3 주택자금차입금 세액공제;
  FUNCTION HOUSE_DEBT_BEN_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_REAL_TAX          IN NUMBER
            ) RETURN NUMBER
  AS
    V_HOUSE_DEBT_BEN_AMT          NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( -- 연말정산 처리기준 중 근로소득공제  항목  
               SELECT HIT.YEAR_YYYY
                   , NVL(HIT.HOUSE_DEBT_BEN_RATE, 0) HOUSE_DEBT_BEN_RATE
                   , NVL(HIT.SP_TAX_RATE, 0) SP_TAX_RATE
                   --> 주택차입금상환액 세액공제              
                   , NVL(HF1.HOUSE_DEBT_BEN_AMT, 0) HOUSE_DEBT_BEN_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  연말정산 기초자료  조회  
                      SELECT HF.YEAR_YYYY 
                          , HF.SOB_ID
                          , HF.ORG_ID
                          , HF.HOUSE_DEBT_BEN_AMT
                        FROM HRA_FOUNDATION HF
                       WHERE HF.YEAR_YYYY = P_YEAR_YYYY
                         AND HF.SOB_ID    = P_SOB_ID
                         AND HF.ORG_ID    = P_ORG_ID
                         AND HF.PERSON_ID = P_PERSON_ID
                     ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
               ) 
    LOOP
      -- 주택차입금상환액 공제    
      V_HOUSE_DEBT_BEN_AMT := TRUNC(C1.HOUSE_DEBT_BEN_AMT * (C1.HOUSE_DEBT_BEN_RATE / 100));
    
      /*DBMS_OUTPUT.PUT_LINE('V_HOUSE_DEBT_BEN_AMT -> ' || V_HOUSE_DEBT_BEN_AMT);        
      DBMS_OUTPUT.PUT_LINE('NVL(V_HOUSE_DEBT_BEN_AMT, 0)' || NVL(V_HOUSE_DEBT_BEN_AMT, 0));      
      DBMS_OUTPUT.PUT_LINE('TRUNC(V_HOUSE_DEBT_BEN_AMT / (C1.SP_TAX_RATE / 100), -1)' || TRUNC(V_HOUSE_DEBT_BEN_AMT / (C1.SP_TAX_RATE / 100), -1));        */
    
      -- 한도설정.
      IF P_REAL_TAX < V_HOUSE_DEBT_BEN_AMT THEN
        V_HOUSE_DEBT_BEN_AMT := P_REAL_TAX;
      END IF;
      --DBMS_OUTPUT.PUT_LINE('V_HOUSE_DEBT_BEN_AMT -> ' || V_HOUSE_DEBT_BEN_AMT);        
    
      -----> 주택자금차입금 세액공제 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.TAX_DED_HOUSE_DEBT_AMT  = NVL(V_HOUSE_DEBT_BEN_AMT, 0),
             HA.FIX_SP_TAX_AMT          = TRUNC(V_HOUSE_DEBT_BEN_AMT / (C1.SP_TAX_RATE / 100), -1)
       WHERE HA.YEAR_YYYY         = P_YEAR_YYYY
         AND HA.PERSON_ID         = P_PERSON_ID
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
       ;
    END LOOP C1;
    O_STATUS := 'S';
    RETURN NVL(V_HOUSE_DEBT_BEN_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'House Debt Ben Error : ' || SUBSTR(SQLERRM, 1, 200);
      RETURN 0;
  END HOUSE_DEBT_BEN_CAL;

END HRA_YEAR_ADJUST_SET_G_2013;
/
