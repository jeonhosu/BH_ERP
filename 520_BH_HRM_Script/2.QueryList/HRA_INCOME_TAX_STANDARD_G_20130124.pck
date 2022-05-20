CREATE OR REPLACE PACKAGE HRA_INCOME_TAX_STANDARD_G
AS
----------------------------------------------------------------------------------------- 
-- 1. 기본 설정, 특별 공제, 기타 공제, 세액공재(감면) ----------- SELECT.
----------------------------------------------------------------------------------------- 
  PROCEDURE SELECT_INCOME_TAX_STANDARD
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

----------------------------------------------------------------------------------------- 
-- 2. 기본 설정, 특별 공제, 기타 공제, 세액공재(감면) ----------- INSERT.
----------------------------------------------------------------------------------------- 
  PROCEDURE INSERT_INCOME_TAX_STANDARD
           ( P_YEAR_YYYY                    IN HRA_INCOME_TAX_STANDARD.YEAR_YYYY%TYPE
           , P_SOB_ID                       IN HRA_INCOME_TAX_STANDARD.SOB_ID%TYPE
           , P_ORG_ID                       IN HRA_INCOME_TAX_STANDARD.ORG_ID%TYPE
           , P_FOREIGN_INCOME_RATE          IN HRA_INCOME_TAX_STANDARD.FOREIGN_INCOME_RATE%TYPE
           , P_DRIVE_DED_LMT                IN HRA_INCOME_TAX_STANDARD.DRIVE_DED_LMT%TYPE
           , P_RESE_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.RESE_DED_LMT%TYPE
           , P_REPORTER_DED_AMT             IN HRA_INCOME_TAX_STANDARD.REPORTER_DED_AMT%TYPE
           , P_FOREIGN_INCOME_DED_AMT       IN HRA_INCOME_TAX_STANDARD.FOREIGN_INCOME_DED_AMT%TYPE
           , P_MONTH_PAY_STD                IN HRA_INCOME_TAX_STANDARD.MONTH_PAY_STD%TYPE
           , P_OT_DED_LMT                   IN HRA_INCOME_TAX_STANDARD.OT_DED_LMT%TYPE
           , P_FOOD_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.FOOD_DED_LMT%TYPE
           , P_BABY_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.BABY_DED_LMT%TYPE
           , P_INCOME_DED_A                 IN HRA_INCOME_TAX_STANDARD.INCOME_DED_A%TYPE
           , P_INCOME_DED_RATE_A            IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_A%TYPE
           , P_INCOME_DED_AMT_A             IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_A%TYPE
           , P_INCOME_CALCU_BAS_A           IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_A%TYPE
           , P_INCOME_DED_B                 IN HRA_INCOME_TAX_STANDARD.INCOME_DED_B%TYPE
           , P_INCOME_DED_RATE_B            IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_B%TYPE
           , P_INCOME_DED_AMT_B             IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_B%TYPE
           , P_INCOME_CALCU_BAS_B           IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_B%TYPE
           , P_INCOME_DED_C                 IN HRA_INCOME_TAX_STANDARD.INCOME_DED_C%TYPE
           , P_INCOME_DED_RATE_C            IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_C%TYPE
           , P_INCOME_DED_AMT_C             IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_C%TYPE
           , P_INCOME_CALCU_BAS_C           IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_C%TYPE
           , P_INCOME_DED_D                 IN HRA_INCOME_TAX_STANDARD.INCOME_DED_D%TYPE
           , P_INCOME_DED_RATE_D            IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_D%TYPE
           , P_INCOME_DED_AMT_D             IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_D%TYPE
           , P_INCOME_CALCU_BAS_D           IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_D%TYPE
           , P_INCOME_DED_LMT               IN HRA_INCOME_TAX_STANDARD.INCOME_DED_LMT%TYPE
           , P_INCOME_DED_RATE_LMT          IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_LMT%TYPE
           , P_INCOME_DED_AMT_LMT           IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_LMT%TYPE
           , P_INCOME_CALCU_BAS_LMT         IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_LMT%TYPE
           , P_PERSON_DED_AMT               IN HRA_INCOME_TAX_STANDARD.PERSON_DED_AMT%TYPE
           , P_SPOUSE_DED_AMT               IN HRA_INCOME_TAX_STANDARD.SPOUSE_DED_AMT%TYPE
           , P_SUPPORT_DED_AMT              IN HRA_INCOME_TAX_STANDARD.SUPPORT_DED_AMT%TYPE
           , P_OLD_AGED_DED_AMT             IN HRA_INCOME_TAX_STANDARD.OLD_AGED_DED_AMT%TYPE
           , P_OLD_AGED_DED1_AMT            IN HRA_INCOME_TAX_STANDARD.OLD_AGED_DED1_AMT%TYPE
           , P_DISABILITY_DED_AMT           IN HRA_INCOME_TAX_STANDARD.DISABILITY_DED_AMT%TYPE
           , P_WOMAN_DED_AMT                IN HRA_INCOME_TAX_STANDARD.WOMAN_DED_AMT%TYPE
           , P_BRING_CHILD_DED_AMT          IN HRA_INCOME_TAX_STANDARD.BRING_CHILD_DED_AMT%TYPE
           , P_BIRTH_DED_AMT                IN HRA_INCOME_TAX_STANDARD.BIRTH_DED_AMT%TYPE
           , P_MANY_CHILD_DED_CNT           IN HRA_INCOME_TAX_STANDARD.MANY_CHILD_DED_CNT%TYPE
           , P_MANY_CHILD_DED_BAS_AMT       IN HRA_INCOME_TAX_STANDARD.MANY_CHILD_DED_BAS_AMT%TYPE
           , P_MANY_CHILD_DED_ADD_AMT       IN HRA_INCOME_TAX_STANDARD.MANY_CHILD_DED_ADD_AMT%TYPE
           , P_ANCESTOR_MAN_AGE             IN HRA_INCOME_TAX_STANDARD.ANCESTOR_MAN_AGE%TYPE
           , P_ANCESTOR_WOMAN_AGE           IN HRA_INCOME_TAX_STANDARD.ANCESTOR_WOMAN_AGE%TYPE
           , P_DESCENDANT_MAN_AGE           IN HRA_INCOME_TAX_STANDARD.DESCENDANT_MAN_AGE%TYPE
           , P_DESCENDANT_WOMAN_AGE         IN HRA_INCOME_TAX_STANDARD.DESCENDANT_WOMAN_AGE%TYPE
           , P_OLD_DED_AGE                  IN HRA_INCOME_TAX_STANDARD.OLD_DED_AGE%TYPE
           , P_OLD_DED_AGE1                 IN HRA_INCOME_TAX_STANDARD.OLD_DED_AGE1%TYPE
           , P_CHILDREN_DED_AGE             IN HRA_INCOME_TAX_STANDARD.CHILDREN_DED_AGE%TYPE
           , P_BIRTH_DED_AGE                IN HRA_INCOME_TAX_STANDARD.BIRTH_DED_AGE%TYPE
           , P_MANY_CHILD_DED_AGE           IN HRA_INCOME_TAX_STANDARD.MANY_CHILD_DED_AGE%TYPE
           , P_SIBLING_DED_AGE              IN HRA_INCOME_TAX_STANDARD.SIBLING_DED_AGE%TYPE
           , P_SIBLING_DED_AGE1             IN HRA_INCOME_TAX_STANDARD.SIBLING_DED_AGE1%TYPE
           , P_FOSTER_CHILD_DED_AGE         IN HRA_INCOME_TAX_STANDARD.FOSTER_CHILD_DED_AGE%TYPE
           , P_ETC_INSUR_LMT                IN HRA_INCOME_TAX_STANDARD.ETC_INSUR_LMT%TYPE
           , P_DISABILITY_INSUR_LMT         IN HRA_INCOME_TAX_STANDARD.DISABILITY_INSUR_LMT%TYPE
           , P_MEDIC_DED_STD                IN HRA_INCOME_TAX_STANDARD.MEDIC_DED_STD%TYPE
           , P_MEDIC_DED_LMT                IN HRA_INCOME_TAX_STANDARD.MEDIC_DED_LMT%TYPE
           , P_PER_EDU                      IN HRA_INCOME_TAX_STANDARD.PER_EDU%TYPE
           , P_DISABILITY_EDU               IN HRA_INCOME_TAX_STANDARD.DISABILITY_EDU%TYPE
           , P_KIND_EDU                     IN HRA_INCOME_TAX_STANDARD.KIND_EDU%TYPE
           , P_STUD_EDU                     IN HRA_INCOME_TAX_STANDARD.STUD_EDU%TYPE
           , P_UNIV_EDU                     IN HRA_INCOME_TAX_STANDARD.UNIV_EDU%TYPE
           , P_HOUSE_AMT_RATE               IN HRA_INCOME_TAX_STANDARD.HOUSE_AMT_RATE%TYPE
           , P_HOUSE_MONTHLY_STD            IN HRA_INCOME_TAX_STANDARD.HOUSE_MONTHLY_STD%TYPE
           , P_HOUSE_MONTHLY_RATE           IN HRA_INCOME_TAX_STANDARD.HOUSE_MONTHLY_RATE%TYPE
           , P_HOUSE_INTER_RATE             IN HRA_INCOME_TAX_STANDARD.HOUSE_INTER_RATE%TYPE
           , P_HOUSE_AMT_LMT                IN HRA_INCOME_TAX_STANDARD.HOUSE_AMT_LMT%TYPE
           , P_LONG_HOUSE_PROF_LMT          IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT%TYPE
           , P_HOUSE_TOTAL_LMT              IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT%TYPE
           , P_LONG_HOUSE_PROF_LMT_1        IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_1%TYPE
           , P_HOUSE_TOTAL_LMT_1            IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_1%TYPE
           , P_LONG_HOUSE_PROF_LMT_2        IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_2%TYPE
           , P_HOUSE_TOTAL_LMT_2            IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_2%TYPE
           , P_LEGAL_GIFT_RATE              IN HRA_INCOME_TAX_STANDARD.LEGAL_GIFT_RATE%TYPE
           , P_ASS_GIFT_RATE1               IN HRA_INCOME_TAX_STANDARD.ASS_GIFT_RATE1%TYPE
           , P_ASS_GIFT_RATE2               IN HRA_INCOME_TAX_STANDARD.ASS_GIFT_RATE2%TYPE
           , P_ASS_GIFT_RATE3               IN HRA_INCOME_TAX_STANDARD.ASS_GIFT_RATE3%TYPE
           , P_ASS_GIFT_RATE3_1             IN HRA_INCOME_TAX_STANDARD.ASS_GIFT_RATE3_1%TYPE
           , P_MARRY_DED_STD                IN HRA_INCOME_TAX_STANDARD.MARRY_DED_STD%TYPE
           , P_MARRY_DED                    IN HRA_INCOME_TAX_STANDARD.MARRY_DED%TYPE
           , P_FUNE_DED_STD                 IN HRA_INCOME_TAX_STANDARD.FUNE_DED_STD%TYPE
           , P_FUNE_DED                     IN HRA_INCOME_TAX_STANDARD.FUNE_DED%TYPE
           , P_MOVE_DED_STD                 IN HRA_INCOME_TAX_STANDARD.MOVE_DED_STD%TYPE
           , P_MOVE_DED                     IN HRA_INCOME_TAX_STANDARD.MOVE_DED%TYPE
           , P_SP_DED_STD                   IN HRA_INCOME_TAX_STANDARD.SP_DED_STD%TYPE
           , P_SP_DED_AMT                   IN HRA_INCOME_TAX_STANDARD.SP_DED_AMT%TYPE
           , P_PRIV_PENS_RATE               IN HRA_INCOME_TAX_STANDARD.PRIV_PENS_RATE%TYPE
           , P_PRIV_PENS_LMT                IN HRA_INCOME_TAX_STANDARD.PRIV_PENS_LMT%TYPE
           , P_PENS_DED_RATE                IN HRA_INCOME_TAX_STANDARD.PENS_DED_RATE%TYPE
           , P_PENS_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.PENS_DED_LMT%TYPE
           , P_RETR_PENS_LMT                IN HRA_INCOME_TAX_STANDARD.RETR_PENS_LMT%TYPE
           , P_SMALL_CORPOR_DED_LMT         IN HRA_INCOME_TAX_STANDARD.SMALL_CORPOR_DED_LMT%TYPE
           , P_INVEST_RATE1                 IN HRA_INCOME_TAX_STANDARD.INVEST_RATE1%TYPE
           , P_INVEST_LMT_RATE1             IN HRA_INCOME_TAX_STANDARD.INVEST_LMT_RATE1%TYPE
           , P_INVEST_RATE2                 IN HRA_INCOME_TAX_STANDARD.INVEST_RATE2%TYPE
           , P_INVEST_LMT_RATE2             IN HRA_INCOME_TAX_STANDARD.INVEST_LMT_RATE2%TYPE
           , P_CARD_BAS_RATE                IN HRA_INCOME_TAX_STANDARD.CARD_BAS_RATE%TYPE
           , P_CARD_DED_RATE                IN HRA_INCOME_TAX_STANDARD.CARD_DED_RATE%TYPE
           , P_CARD_DIRECT_RATE             IN HRA_INCOME_TAX_STANDARD.CARD_DIRECT_RATE%TYPE
           , P_CARD_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.CARD_DED_LMT%TYPE
           , P_CARD_DED_LMT_RATE            IN HRA_INCOME_TAX_STANDARD.CARD_DED_LMT_RATE%TYPE
           , P_CHECK_CARD_DED_RATE          IN HRA_INCOME_TAX_STANDARD.CHECK_CARD_DED_RATE%TYPE
           , P_CASH_BAS_RATE                IN HRA_INCOME_TAX_STANDARD.CASH_BAS_RATE%TYPE
           , P_CASH_DED_RATE                IN HRA_INCOME_TAX_STANDARD.CASH_DED_RATE%TYPE
           , P_CASH_DIRECT_RATE             IN HRA_INCOME_TAX_STANDARD.CASH_DIRECT_RATE%TYPE
           , P_CASH_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.CASH_DED_LMT%TYPE
           , P_CASH_DED_LMT_RATE            IN HRA_INCOME_TAX_STANDARD.CASH_DED_LMT_RATE%TYPE
           , P_CARD_ADD_DED_LMT             IN HRA_INCOME_TAX_STANDARD.CARD_ADD_DED_LMT%TYPE
           , P_CARDCASH_DED_LMT_RATE        IN HRA_INCOME_TAX_STANDARD.CARDCASH_DED_LMT_RATE%TYPE
           , P_STOCK_LMT                    IN HRA_INCOME_TAX_STANDARD.STOCK_LMT%TYPE
           , P_LONG_STOCK_SAVING_RATE_1     IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_RATE_1%TYPE
           , P_LONG_STOCK_SAVING_LMT_1      IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_LMT_1%TYPE
           , P_LONG_STOCK_SAVING_RATE_2     IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_RATE_2%TYPE
           , P_LONG_STOCK_SAVING_LMT_2      IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_LMT_2%TYPE
           , P_LONG_STOCK_SAVING_RATE_3     IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_RATE_3%TYPE
           , P_LONG_STOCK_SAVING_LMT_3      IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_LMT_3%TYPE
           , P_EMPLOYMENT_KEEP_RATE         IN HRA_INCOME_TAX_STANDARD.EMPLOYMENT_KEEP_RATE%TYPE
           , P_EMPLOYMENT_KEEP_LMT          IN HRA_INCOME_TAX_STANDARD.EMPLOYMENT_KEEP_LMT%TYPE
           , P_IN_TAX_BASE                  IN HRA_INCOME_TAX_STANDARD.IN_TAX_BASE%TYPE
           , P_IN_TAX_STD_A                 IN HRA_INCOME_TAX_STANDARD.IN_TAX_STD_A%TYPE
           , P_IN_TAX_RATE_A                IN HRA_INCOME_TAX_STANDARD.IN_TAX_RATE_A%TYPE
           , P_IN_TAX_STD_B                 IN HRA_INCOME_TAX_STANDARD.IN_TAX_STD_B%TYPE
           , P_IN_TAX_RATE_B                IN HRA_INCOME_TAX_STANDARD.IN_TAX_RATE_B%TYPE
           , P_IN_TAX_BASE_B                IN HRA_INCOME_TAX_STANDARD.IN_TAX_BASE_B%TYPE
           , P_IN_TAX_STD_C                 IN HRA_INCOME_TAX_STANDARD.IN_TAX_STD_C%TYPE
           , P_IN_TAX_RATE_C                IN HRA_INCOME_TAX_STANDARD.IN_TAX_RATE_C%TYPE
           , P_IN_TAX_BASE_C                IN HRA_INCOME_TAX_STANDARD.IN_TAX_BASE_C%TYPE
           , P_IN_TAX_LMT                   IN HRA_INCOME_TAX_STANDARD.IN_TAX_LMT%TYPE
           , P_POLI_GIFT_MAX                IN HRA_INCOME_TAX_STANDARD.POLI_GIFT_MAX%TYPE
           , P_POLI_GIFT_RATE               IN HRA_INCOME_TAX_STANDARD.POLI_GIFT_RATE%TYPE
           , P_POLI_GIFT_RATE1              IN HRA_INCOME_TAX_STANDARD.POLI_GIFT_RATE1%TYPE
           , P_TAX_ASSO_RATE                IN HRA_INCOME_TAX_STANDARD.TAX_ASSO_RATE%TYPE
           , P_HOUSE_DEBT_BEN_RATE          IN HRA_INCOME_TAX_STANDARD.HOUSE_DEBT_BEN_RATE%TYPE
           , P_FOREIGN_TAX_DED              IN HRA_INCOME_TAX_STANDARD.FOREIGN_TAX_DED%TYPE
           , P_LOCAL_TAX_RATE               IN HRA_INCOME_TAX_STANDARD.LOCAL_TAX_RATE%TYPE
           , P_SP_TAX_RATE                  IN HRA_INCOME_TAX_STANDARD.SP_TAX_RATE%TYPE
           , P_DESCRIPTION                  IN HRA_INCOME_TAX_STANDARD.DESCRIPTION%TYPE
           , P_USER_ID                      IN HRA_INCOME_TAX_STANDARD.CREATED_BY%TYPE 
           , P_PRE_YEAR_INCOME_TOT_AMT_LMT  IN HRA_INCOME_TAX_STANDARD.PRE_YEAR_INCOME_TOT_AMT_LMT%TYPE  -- 야간근로수당 적용 전년도 총급여한도.
           , P_LONG_HOUSE_PROF_LMT_3_FIX    IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_3_FIX%TYPE    -- 장기주택저당차입금 500만원(고정식).
           , P_HOUSE_TOTAL_LMT_3_FIX        IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_3_FIX%TYPE        -- 장기주택저당차입금 500만원(고정식 총한도).
           , P_LONG_HOUSE_PROF_LMT_3_ETC    IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_3_ETC%TYPE    -- 장기주택저당차입금 500만원(기타). 
           , P_HOUSE_TOTAL_LMT_3_ETC        IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_3_ETC%TYPE        -- 장기주택저당차입금 500만원(기타 총한도).
           , P_HOUSE_SAVING_RATE            IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_RATE%TYPE            -- 주택마련저축(청약저축)--
           , P_HOUSE_SAVING_LMT             IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_LMT%TYPE             -- 주택마련저축(청약저축) 한도 --
           , P_WORKER_HOUSE_SAVING_RATE     IN HRA_INCOME_TAX_STANDARD.WORKER_HOUSE_SAVING_RATE%TYPE     -- 근로자주택마련저축--
           , P_WORKER_HOUSE_SAVING_LMT      IN HRA_INCOME_TAX_STANDARD.WORKER_HOUSE_SAVING_LMT%TYPE      -- 근로자주택마련저축 한도 --
           , P_LONG_HOUSE_SAVING_RATE       IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_SAVING_RATE%TYPE       -- 장기주택마련저축--
           , P_LONG_HOUSE_SAVING_LMT        IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_SAVING_LMT%TYPE        -- 장기주택마련저축 한도 --
           , P_HOUSE_SAVING_ALL_RATE        IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_ALL_RATE%TYPE        -- 장기주택마련정합저축--
           , P_HOUSE_SAVING_ALL_LMT         IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_ALL_LMT%TYPE         -- 장기주택마련정합저축 한도--
           , P_TRAD_MARKET_DED_RATE         IN HRA_INCOME_TAX_STANDARD.TRAD_MARKET_DED_RATE%TYPE         -- 전통시장 공제비율--
           , P_CARD_MIN_USE_RATE_1          IN HRA_INCOME_TAX_STANDARD.CARD_MIN_USE_RATE_1%TYPE          -- 카드최저사용한도1--
           , P_CARD_MIN_USE_RATE_2          IN HRA_INCOME_TAX_STANDARD.CARD_MIN_USE_RATE_2%TYPE          -- 카드최저사용한도2--
           , P_FOREIGN_WORKER_TAX_DED_RATE  IN HRA_INCOME_TAX_STANDARD.FOREIGN_WORKER_TAX_DED_RATE%TYPE  -- 외국인기술자 세액감면--
           , P_SMALL_BUSINESS_TAX_DED_FR    IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_FR%TYPE    -- 증소기업 취업청년 시작 조건--
           , P_SMALL_BUSINESS_TAX_DED_TO    IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_TO%TYPE    -- 증소기업 취업청년 종료 조건--
           , P_SMALL_BUSINESS_TAX_DED_RATE  IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_RATE%TYPE  -- 증소기업 취업청년 세액감면율-- 
           );
          
  
----------------------------------------------------------------------------------------- 
-- 3. 기본 설정, 특별 공제, 기타 공제, 세액공재(감면) ----------- UPDATE.
----------------------------------------------------------------------------------------- 
  PROCEDURE UPDATE_INCOME_TAX_STANDARD
           ( W_YEAR_YYYY                    IN HRA_INCOME_TAX_STANDARD.YEAR_YYYY%TYPE
           , P_SOB_ID                       IN HRA_INCOME_TAX_STANDARD.SOB_ID%TYPE
           , P_ORG_ID                       IN HRA_INCOME_TAX_STANDARD.ORG_ID%TYPE
           , P_FOREIGN_INCOME_RATE          IN HRA_INCOME_TAX_STANDARD.FOREIGN_INCOME_RATE%TYPE
           , P_DRIVE_DED_LMT                IN HRA_INCOME_TAX_STANDARD.DRIVE_DED_LMT%TYPE
           , P_RESE_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.RESE_DED_LMT%TYPE
           , P_REPORTER_DED_AMT             IN HRA_INCOME_TAX_STANDARD.REPORTER_DED_AMT%TYPE
           , P_FOREIGN_INCOME_DED_AMT       IN HRA_INCOME_TAX_STANDARD.FOREIGN_INCOME_DED_AMT%TYPE
           , P_MONTH_PAY_STD                IN HRA_INCOME_TAX_STANDARD.MONTH_PAY_STD%TYPE
           , P_OT_DED_LMT                   IN HRA_INCOME_TAX_STANDARD.OT_DED_LMT%TYPE
           , P_FOOD_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.FOOD_DED_LMT%TYPE
           , P_BABY_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.BABY_DED_LMT%TYPE
           , P_INCOME_DED_A                 IN HRA_INCOME_TAX_STANDARD.INCOME_DED_A%TYPE
           , P_INCOME_DED_RATE_A            IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_A%TYPE
           , P_INCOME_DED_AMT_A             IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_A%TYPE
           , P_INCOME_CALCU_BAS_A           IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_A%TYPE
           , P_INCOME_DED_B                 IN HRA_INCOME_TAX_STANDARD.INCOME_DED_B%TYPE
           , P_INCOME_DED_RATE_B            IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_B%TYPE
           , P_INCOME_DED_AMT_B             IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_B%TYPE
           , P_INCOME_CALCU_BAS_B           IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_B%TYPE
           , P_INCOME_DED_C                 IN HRA_INCOME_TAX_STANDARD.INCOME_DED_C%TYPE
           , P_INCOME_DED_RATE_C            IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_C%TYPE
           , P_INCOME_DED_AMT_C             IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_C%TYPE
           , P_INCOME_CALCU_BAS_C           IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_C%TYPE
           , P_INCOME_DED_D                 IN HRA_INCOME_TAX_STANDARD.INCOME_DED_D%TYPE
           , P_INCOME_DED_RATE_D            IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_D%TYPE
           , P_INCOME_DED_AMT_D             IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_D%TYPE
           , P_INCOME_CALCU_BAS_D           IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_D%TYPE
           , P_INCOME_DED_LMT               IN HRA_INCOME_TAX_STANDARD.INCOME_DED_LMT%TYPE
           , P_INCOME_DED_RATE_LMT          IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_LMT%TYPE
           , P_INCOME_DED_AMT_LMT           IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_LMT%TYPE
           , P_INCOME_CALCU_BAS_LMT         IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_LMT%TYPE
           , P_PERSON_DED_AMT               IN HRA_INCOME_TAX_STANDARD.PERSON_DED_AMT%TYPE
           , P_SPOUSE_DED_AMT               IN HRA_INCOME_TAX_STANDARD.SPOUSE_DED_AMT%TYPE
           , P_SUPPORT_DED_AMT              IN HRA_INCOME_TAX_STANDARD.SUPPORT_DED_AMT%TYPE
           , P_OLD_AGED_DED_AMT             IN HRA_INCOME_TAX_STANDARD.OLD_AGED_DED_AMT%TYPE
           , P_OLD_AGED_DED1_AMT            IN HRA_INCOME_TAX_STANDARD.OLD_AGED_DED1_AMT%TYPE
           , P_DISABILITY_DED_AMT           IN HRA_INCOME_TAX_STANDARD.DISABILITY_DED_AMT%TYPE
           , P_WOMAN_DED_AMT                IN HRA_INCOME_TAX_STANDARD.WOMAN_DED_AMT%TYPE
           , P_BRING_CHILD_DED_AMT          IN HRA_INCOME_TAX_STANDARD.BRING_CHILD_DED_AMT%TYPE
           , P_BIRTH_DED_AMT                IN HRA_INCOME_TAX_STANDARD.BIRTH_DED_AMT%TYPE
           , P_MANY_CHILD_DED_CNT           IN HRA_INCOME_TAX_STANDARD.MANY_CHILD_DED_CNT%TYPE
           , P_MANY_CHILD_DED_BAS_AMT       IN HRA_INCOME_TAX_STANDARD.MANY_CHILD_DED_BAS_AMT%TYPE
           , P_MANY_CHILD_DED_ADD_AMT       IN HRA_INCOME_TAX_STANDARD.MANY_CHILD_DED_ADD_AMT%TYPE
           , P_ANCESTOR_MAN_AGE             IN HRA_INCOME_TAX_STANDARD.ANCESTOR_MAN_AGE%TYPE
           , P_ANCESTOR_WOMAN_AGE           IN HRA_INCOME_TAX_STANDARD.ANCESTOR_WOMAN_AGE%TYPE
           , P_DESCENDANT_MAN_AGE           IN HRA_INCOME_TAX_STANDARD.DESCENDANT_MAN_AGE%TYPE
           , P_DESCENDANT_WOMAN_AGE         IN HRA_INCOME_TAX_STANDARD.DESCENDANT_WOMAN_AGE%TYPE
           , P_OLD_DED_AGE                  IN HRA_INCOME_TAX_STANDARD.OLD_DED_AGE%TYPE
           , P_OLD_DED_AGE1                 IN HRA_INCOME_TAX_STANDARD.OLD_DED_AGE1%TYPE
           , P_CHILDREN_DED_AGE             IN HRA_INCOME_TAX_STANDARD.CHILDREN_DED_AGE%TYPE
           , P_BIRTH_DED_AGE                IN HRA_INCOME_TAX_STANDARD.BIRTH_DED_AGE%TYPE
           , P_MANY_CHILD_DED_AGE           IN HRA_INCOME_TAX_STANDARD.MANY_CHILD_DED_AGE%TYPE
           , P_SIBLING_DED_AGE              IN HRA_INCOME_TAX_STANDARD.SIBLING_DED_AGE%TYPE
           , P_SIBLING_DED_AGE1             IN HRA_INCOME_TAX_STANDARD.SIBLING_DED_AGE1%TYPE
           , P_FOSTER_CHILD_DED_AGE         IN HRA_INCOME_TAX_STANDARD.FOSTER_CHILD_DED_AGE%TYPE
           , P_ETC_INSUR_LMT                IN HRA_INCOME_TAX_STANDARD.ETC_INSUR_LMT%TYPE
           , P_DISABILITY_INSUR_LMT         IN HRA_INCOME_TAX_STANDARD.DISABILITY_INSUR_LMT%TYPE
           , P_MEDIC_DED_STD                IN HRA_INCOME_TAX_STANDARD.MEDIC_DED_STD%TYPE
           , P_MEDIC_DED_LMT                IN HRA_INCOME_TAX_STANDARD.MEDIC_DED_LMT%TYPE
           , P_PER_EDU                      IN HRA_INCOME_TAX_STANDARD.PER_EDU%TYPE
           , P_DISABILITY_EDU               IN HRA_INCOME_TAX_STANDARD.DISABILITY_EDU%TYPE
           , P_KIND_EDU                     IN HRA_INCOME_TAX_STANDARD.KIND_EDU%TYPE
           , P_STUD_EDU                     IN HRA_INCOME_TAX_STANDARD.STUD_EDU%TYPE
           , P_UNIV_EDU                     IN HRA_INCOME_TAX_STANDARD.UNIV_EDU%TYPE
           , P_HOUSE_AMT_RATE               IN HRA_INCOME_TAX_STANDARD.HOUSE_AMT_RATE%TYPE
           , P_HOUSE_MONTHLY_STD            IN HRA_INCOME_TAX_STANDARD.HOUSE_MONTHLY_STD%TYPE
           , P_HOUSE_MONTHLY_RATE           IN HRA_INCOME_TAX_STANDARD.HOUSE_MONTHLY_RATE%TYPE
           , P_HOUSE_INTER_RATE             IN HRA_INCOME_TAX_STANDARD.HOUSE_INTER_RATE%TYPE
           , P_HOUSE_AMT_LMT                IN HRA_INCOME_TAX_STANDARD.HOUSE_AMT_LMT%TYPE
           , P_LONG_HOUSE_PROF_LMT          IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT%TYPE
           , P_HOUSE_TOTAL_LMT              IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT%TYPE
           , P_LONG_HOUSE_PROF_LMT_1        IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_1%TYPE
           , P_HOUSE_TOTAL_LMT_1            IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_1%TYPE
           , P_LONG_HOUSE_PROF_LMT_2        IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_2%TYPE
           , P_HOUSE_TOTAL_LMT_2            IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_2%TYPE
           , P_LEGAL_GIFT_RATE              IN HRA_INCOME_TAX_STANDARD.LEGAL_GIFT_RATE%TYPE
           , P_ASS_GIFT_RATE1               IN HRA_INCOME_TAX_STANDARD.ASS_GIFT_RATE1%TYPE
           , P_ASS_GIFT_RATE2               IN HRA_INCOME_TAX_STANDARD.ASS_GIFT_RATE2%TYPE
           , P_ASS_GIFT_RATE3               IN HRA_INCOME_TAX_STANDARD.ASS_GIFT_RATE3%TYPE
           , P_ASS_GIFT_RATE3_1             IN HRA_INCOME_TAX_STANDARD.ASS_GIFT_RATE3_1%TYPE
           , P_MARRY_DED_STD                IN HRA_INCOME_TAX_STANDARD.MARRY_DED_STD%TYPE
           , P_MARRY_DED                    IN HRA_INCOME_TAX_STANDARD.MARRY_DED%TYPE
           , P_FUNE_DED_STD                 IN HRA_INCOME_TAX_STANDARD.FUNE_DED_STD%TYPE
           , P_FUNE_DED                     IN HRA_INCOME_TAX_STANDARD.FUNE_DED%TYPE
           , P_MOVE_DED_STD                 IN HRA_INCOME_TAX_STANDARD.MOVE_DED_STD%TYPE
           , P_MOVE_DED                     IN HRA_INCOME_TAX_STANDARD.MOVE_DED%TYPE
           , P_SP_DED_STD                   IN HRA_INCOME_TAX_STANDARD.SP_DED_STD%TYPE
           , P_SP_DED_AMT                   IN HRA_INCOME_TAX_STANDARD.SP_DED_AMT%TYPE
           , P_PRIV_PENS_RATE               IN HRA_INCOME_TAX_STANDARD.PRIV_PENS_RATE%TYPE
           , P_PRIV_PENS_LMT                IN HRA_INCOME_TAX_STANDARD.PRIV_PENS_LMT%TYPE
           , P_PENS_DED_RATE                IN HRA_INCOME_TAX_STANDARD.PENS_DED_RATE%TYPE
           , P_PENS_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.PENS_DED_LMT%TYPE
           , P_RETR_PENS_LMT                IN HRA_INCOME_TAX_STANDARD.RETR_PENS_LMT%TYPE
           , P_SMALL_CORPOR_DED_LMT         IN HRA_INCOME_TAX_STANDARD.SMALL_CORPOR_DED_LMT%TYPE
           , P_INVEST_RATE1                 IN HRA_INCOME_TAX_STANDARD.INVEST_RATE1%TYPE
           , P_INVEST_LMT_RATE1             IN HRA_INCOME_TAX_STANDARD.INVEST_LMT_RATE1%TYPE
           , P_INVEST_RATE2                 IN HRA_INCOME_TAX_STANDARD.INVEST_RATE2%TYPE
           , P_INVEST_LMT_RATE2             IN HRA_INCOME_TAX_STANDARD.INVEST_LMT_RATE2%TYPE
           , P_CARD_BAS_RATE                IN HRA_INCOME_TAX_STANDARD.CARD_BAS_RATE%TYPE
           , P_CARD_DED_RATE                IN HRA_INCOME_TAX_STANDARD.CARD_DED_RATE%TYPE
           , P_CARD_DIRECT_RATE             IN HRA_INCOME_TAX_STANDARD.CARD_DIRECT_RATE%TYPE
           , P_CARD_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.CARD_DED_LMT%TYPE
           , P_CARD_DED_LMT_RATE            IN HRA_INCOME_TAX_STANDARD.CARD_DED_LMT_RATE%TYPE
           , P_CHECK_CARD_DED_RATE          IN HRA_INCOME_TAX_STANDARD.CHECK_CARD_DED_RATE%TYPE
           , P_CASH_BAS_RATE                IN HRA_INCOME_TAX_STANDARD.CASH_BAS_RATE%TYPE
           , P_CASH_DED_RATE                IN HRA_INCOME_TAX_STANDARD.CASH_DED_RATE%TYPE
           , P_CASH_DIRECT_RATE             IN HRA_INCOME_TAX_STANDARD.CASH_DIRECT_RATE%TYPE
           , P_CASH_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.CASH_DED_LMT%TYPE
           , P_CASH_DED_LMT_RATE            IN HRA_INCOME_TAX_STANDARD.CASH_DED_LMT_RATE%TYPE
           , P_CARD_ADD_DED_LMT             IN HRA_INCOME_TAX_STANDARD.CARD_ADD_DED_LMT%TYPE
           , P_CARDCASH_DED_LMT_RATE        IN HRA_INCOME_TAX_STANDARD.CARDCASH_DED_LMT_RATE%TYPE
           , P_STOCK_LMT                    IN HRA_INCOME_TAX_STANDARD.STOCK_LMT%TYPE
           , P_LONG_STOCK_SAVING_RATE_1     IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_RATE_1%TYPE
           , P_LONG_STOCK_SAVING_LMT_1      IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_LMT_1%TYPE
           , P_LONG_STOCK_SAVING_RATE_2     IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_RATE_2%TYPE
           , P_LONG_STOCK_SAVING_LMT_2      IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_LMT_2%TYPE
           , P_LONG_STOCK_SAVING_RATE_3     IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_RATE_3%TYPE
           , P_LONG_STOCK_SAVING_LMT_3      IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_LMT_3%TYPE
           , P_EMPLOYMENT_KEEP_RATE         IN HRA_INCOME_TAX_STANDARD.EMPLOYMENT_KEEP_RATE%TYPE
           , P_EMPLOYMENT_KEEP_LMT          IN HRA_INCOME_TAX_STANDARD.EMPLOYMENT_KEEP_LMT%TYPE
           , P_IN_TAX_BASE                  IN HRA_INCOME_TAX_STANDARD.IN_TAX_BASE%TYPE
           , P_IN_TAX_STD_A                 IN HRA_INCOME_TAX_STANDARD.IN_TAX_STD_A%TYPE
           , P_IN_TAX_RATE_A                IN HRA_INCOME_TAX_STANDARD.IN_TAX_RATE_A%TYPE
           , P_IN_TAX_STD_B                 IN HRA_INCOME_TAX_STANDARD.IN_TAX_STD_B%TYPE
           , P_IN_TAX_RATE_B                IN HRA_INCOME_TAX_STANDARD.IN_TAX_RATE_B%TYPE
           , P_IN_TAX_BASE_B                IN HRA_INCOME_TAX_STANDARD.IN_TAX_BASE_B%TYPE
           , P_IN_TAX_STD_C                 IN HRA_INCOME_TAX_STANDARD.IN_TAX_STD_C%TYPE
           , P_IN_TAX_RATE_C                IN HRA_INCOME_TAX_STANDARD.IN_TAX_RATE_C%TYPE
           , P_IN_TAX_BASE_C                IN HRA_INCOME_TAX_STANDARD.IN_TAX_BASE_C%TYPE
           , P_IN_TAX_LMT                   IN HRA_INCOME_TAX_STANDARD.IN_TAX_LMT%TYPE
           , P_POLI_GIFT_MAX                IN HRA_INCOME_TAX_STANDARD.POLI_GIFT_MAX%TYPE
           , P_POLI_GIFT_RATE               IN HRA_INCOME_TAX_STANDARD.POLI_GIFT_RATE%TYPE
           , P_POLI_GIFT_RATE1              IN HRA_INCOME_TAX_STANDARD.POLI_GIFT_RATE1%TYPE
           , P_TAX_ASSO_RATE                IN HRA_INCOME_TAX_STANDARD.TAX_ASSO_RATE%TYPE
           , P_HOUSE_DEBT_BEN_RATE          IN HRA_INCOME_TAX_STANDARD.HOUSE_DEBT_BEN_RATE%TYPE
           , P_FOREIGN_TAX_DED              IN HRA_INCOME_TAX_STANDARD.FOREIGN_TAX_DED%TYPE
           , P_LOCAL_TAX_RATE               IN HRA_INCOME_TAX_STANDARD.LOCAL_TAX_RATE%TYPE
           , P_SP_TAX_RATE                  IN HRA_INCOME_TAX_STANDARD.SP_TAX_RATE%TYPE
           , P_DESCRIPTION                  IN HRA_INCOME_TAX_STANDARD.DESCRIPTION%TYPE
           , P_USER_ID                      IN HRA_INCOME_TAX_STANDARD.CREATED_BY%TYPE 
           , P_PRE_YEAR_INCOME_TOT_AMT_LMT  IN HRA_INCOME_TAX_STANDARD.PRE_YEAR_INCOME_TOT_AMT_LMT%TYPE  -- 야간근로수당 적용 전년도 총급여한도.
           , P_LONG_HOUSE_PROF_LMT_3_FIX    IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_3_FIX%TYPE    -- 장기주택저당차입금 500만원(고정식).
           , P_HOUSE_TOTAL_LMT_3_FIX        IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_3_FIX%TYPE        -- 장기주택저당차입금 500만원(고정식 총한도).
           , P_LONG_HOUSE_PROF_LMT_3_ETC    IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_3_ETC%TYPE    -- 장기주택저당차입금 500만원(기타). 
           , P_HOUSE_TOTAL_LMT_3_ETC        IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_3_ETC%TYPE        -- 장기주택저당차입금 500만원(기타 총한도).
           , P_HOUSE_SAVING_RATE            IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_RATE%TYPE            -- 주택마련저축(청약저축)--
           , P_HOUSE_SAVING_LMT             IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_LMT%TYPE             -- 주택마련저축(청약저축) 한도 --
           , P_WORKER_HOUSE_SAVING_RATE     IN HRA_INCOME_TAX_STANDARD.WORKER_HOUSE_SAVING_RATE%TYPE     -- 근로자주택마련저축--
           , P_WORKER_HOUSE_SAVING_LMT      IN HRA_INCOME_TAX_STANDARD.WORKER_HOUSE_SAVING_LMT%TYPE      -- 근로자주택마련저축 한도 --
           , P_LONG_HOUSE_SAVING_RATE       IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_SAVING_RATE%TYPE       -- 장기주택마련저축--
           , P_LONG_HOUSE_SAVING_LMT        IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_SAVING_LMT%TYPE        -- 장기주택마련저축 한도 --
           , P_HOUSE_SAVING_ALL_RATE        IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_ALL_RATE%TYPE        -- 장기주택마련정합저축--
           , P_HOUSE_SAVING_ALL_LMT         IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_ALL_LMT%TYPE         -- 장기주택마련정합저축 한도--
           , P_TRAD_MARKET_DED_RATE         IN HRA_INCOME_TAX_STANDARD.TRAD_MARKET_DED_RATE%TYPE         -- 전통시장 공제비율--
           , P_CARD_MIN_USE_RATE_1          IN HRA_INCOME_TAX_STANDARD.CARD_MIN_USE_RATE_1%TYPE          -- 카드최저사용한도1--
           , P_CARD_MIN_USE_RATE_2          IN HRA_INCOME_TAX_STANDARD.CARD_MIN_USE_RATE_2%TYPE          -- 카드최저사용한도2--
           , P_FOREIGN_WORKER_TAX_DED_RATE  IN HRA_INCOME_TAX_STANDARD.FOREIGN_WORKER_TAX_DED_RATE%TYPE  -- 외국인기술자 세액감면--
           , P_SMALL_BUSINESS_TAX_DED_FR    IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_FR%TYPE    -- 증소기업 취업청년 시작 조건--
           , P_SMALL_BUSINESS_TAX_DED_TO    IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_TO%TYPE    -- 증소기업 취업청년 종료 조건--
           , P_SMALL_BUSINESS_TAX_DED_RATE  IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_RATE%TYPE  -- 증소기업 취업청년 세액감면율-- 
           );

----------------------------------------------------------------------------------------- 
-- 4. 기본 설정, 특별 공제, 기타 공제, 세액공재(감면) ----------- DELETE.
-----------------------------------------------------------------------------------------
  PROCEDURE DELETE_INCOME_TAX_STANDARD
          ( W_YEAR_YYYY   IN HRA_INCOME_TAX_STANDARD.YEAR_YYYY%TYPE
          , W_SOB_ID      IN HRA_INCOME_TAX_STANDARD.SOB_ID%TYPE
          , W_ORG_ID      IN HRA_INCOME_TAX_STANDARD.ORG_ID%TYPE 
          );

----------------------------------------------------------------------------------------- 
-- 5. 해당 년도 기준 정보 존재 여부 체크.
-----------------------------------------------------------------------------------------
  PROCEDURE CHECK_TAX_STANDARD_YN
            ( W_YEAR_YYYY             IN HRA_INCOME_TAX_STANDARD.YEAR_YYYY%TYPE
            , W_SOB_ID                IN HRA_INCOME_TAX_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                IN HRA_INCOME_TAX_STANDARD.ORG_ID%TYPE
            , O_CHECK_YN              OUT VARCHAR2
            );

----------------------------------------------------------------------------------------- 
-- 6. 전년도 기준 정보 COPY.
-----------------------------------------------------------------------------------------
  PROCEDURE COPY_TAX_STANDARD
            ( W_YEAR_YYYY             IN HRA_INCOME_TAX_STANDARD.YEAR_YYYY%TYPE
            , W_SOB_ID                IN HRA_INCOME_TAX_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                IN HRA_INCOME_TAX_STANDARD.ORG_ID%TYPE
            , P_USER_ID               IN HRA_INCOME_TAX_STANDARD.CREATED_BY%TYPE
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

END HRA_INCOME_TAX_STANDARD_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_INCOME_TAX_STANDARD_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_INCOME_TAX_STANDARD_G
/* Description  : 연말정산기준관리
/*
/* Reference by : 연말정산기준관리
/* Program History : 
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 4-MAR-2011  Lee Sun Hee        Initialize
/******************************************************************************/

----------------------------------------------------------------------------------------- 
--1. 기본 설정, 특별 공제, 기타 공제, 세액공재(감면) ----------- SELECT.
----------------------------------------------------------------------------------------- 
  PROCEDURE SELECT_INCOME_TAX_STANDARD
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS 
  BEGIN
    OPEN P_CURSOR FOR
      SELECT ITS.YEAR_YYYY AS YEAR_YYYY     -- 적용년도.
           , ITS.FOREIGN_INCOME_RATE        -- 외국인근로자단일세율.
           , ITS.DRIVE_DED_LMT              -- 자가운전보조금.
           , ITS.RESE_DED_LMT               -- 연구보조비.
           , ITS.REPORTER_DED_AMT           -- 취재수당.
           , ITS.FOREIGN_INCOME_DED_AMT     -- 국외근로소득.
           , ITS.MONTH_PAY_STD              -- 야간근로수당 적용 급여 기준.
           , ITS.OT_DED_LMT                 -- 야간근로수당 한도.
           , ITS.FOOD_DED_LMT               -- 식대한도.
           , ITS.BABY_DED_LMT               -- 보육수당 한도.
           , ITS.INCOME_DED_A               -- 근로소득공제 A.
           , ITS.INCOME_DED_RATE_A          -- 근로소득공제율 A.
           , ITS.INCOME_DED_AMT_A           -- 근로소득공제금액 A.
           , ITS.INCOME_CALCU_BAS_A         -- 근로소득 기본금액 A.
           , ITS.INCOME_DED_B               -- 근로소득공제 B.
           , ITS.INCOME_DED_RATE_B          -- 근로소득공제율 B.
           , ITS.INCOME_DED_AMT_B           -- 근로소득공제금액 B.
           , ITS.INCOME_CALCU_BAS_B         -- 근로소득 기본금액 B.
           , ITS.INCOME_DED_C               -- 근로소득공제 C.
           , ITS.INCOME_DED_RATE_C          -- 근로소득공제율 C.
           , ITS.INCOME_DED_AMT_C           -- 근로소득공제금액 C.
           , ITS.INCOME_CALCU_BAS_C         -- 근로소득 기본금액 C.
           , ITS.INCOME_DED_D               -- 근로소득공제 D.
           , ITS.INCOME_DED_RATE_D          -- 근로소득공제율 D.
           , ITS.INCOME_DED_AMT_D           -- 근로소득공제금액 D.
           , ITS.INCOME_CALCU_BAS_D         -- 근로소득 기본금액 D.
           , ITS.INCOME_DED_LMT             -- 근로소득공제 한도.
           , ITS.INCOME_DED_RATE_LMT        -- 근로소득공제율 한도.
           , ITS.INCOME_DED_AMT_LMT         -- 근로소득공제금액 한도.
           , ITS.INCOME_CALCU_BAS_LMT       -- 근로소득 기본금액 한도.
           , ITS.PERSON_DED_AMT             -- 기본공제-본인.
           , ITS.SPOUSE_DED_AMT             -- 기본공제-배우자.
           , ITS.SUPPORT_DED_AMT            -- 기본공제-부양가족.
           , ITS.OLD_AGED_DED_AMT           -- 추가공제-경로우대1(65~69).
           , ITS.OLD_AGED_DED1_AMT          -- 추가공제-경로우대(70~)
           , ITS.DISABILITY_DED_AMT         -- 추가공제-장애자.
           , ITS.WOMAN_DED_AMT              -- 추가공제-부녀세대.
           , ITS.BRING_CHILD_DED_AMT        -- 추가공제-자녀양육.
           , ITS.BIRTH_DED_AMT              -- 출산/입양.
           , ITS.MANY_CHILD_DED_CNT         -- 다자녀추가-인원기준.
           , ITS.MANY_CHILD_DED_BAS_AMT     -- 다자녀추가-기본금액.
           , ITS.MANY_CHILD_DED_ADD_AMT     -- 다자녀추가-인당금액.
           , ITS.ANCESTOR_MAN_AGE           -- 직계존속 남자 공제나이.
           , ITS.ANCESTOR_WOMAN_AGE         -- 직계존속 여자 공제나이.
           , ITS.DESCENDANT_MAN_AGE         -- 직계비속 남자 공제나이.
           , ITS.DESCENDANT_WOMAN_AGE       -- 직계비속 여자 공제나이.
           , ITS.OLD_DED_AGE                -- 경로우대1.
           , ITS.OLD_DED_AGE1               -- 경로우대2.
           , ITS.CHILDREN_DED_AGE           -- 자녀양육비 공제 나이.
           , ITS.BIRTH_DED_AGE              -- 출생 공제나이.
           , ITS.MANY_CHILD_DED_AGE         -- 다자녀추가공제 나이.
           , ITS.SIBLING_DED_AGE            -- 형제자매 공제 나이.
           , ITS.SIBLING_DED_AGE1           -- 형제자매 공제 나이1.
           , ITS.FOSTER_CHILD_DED_AGE       -- 위탁아동 공제 나이.
           , ITS.ETC_INSUR_LMT              -- 기타보장성보험.
           , ITS.DISABILITY_INSUR_LMT       -- 기타장애자보험.
           , ITS.MEDIC_DED_STD              -- 의료비-기준 RATE.
           , ITS.MEDIC_DED_LMT              -- 의료비-한도.
           , ITS.PER_EDU                    -- 교-본인.
           , ITS.DISABILITY_EDU             -- 교-장애.
           , ITS.KIND_EDU                   -- 교-취학전아동.
           , ITS.STUD_EDU                   -- 교-초중고교.
           , ITS.UNIV_EDU                   -- 교-대학교.
           , ITS.HOUSE_AMT_RATE             -- 주택마련저축불입액(사용 안함).
           , ITS.HOUSE_MONTHLY_STD          -- 월세액기준.
           , ITS.HOUSE_MONTHLY_RATE         -- 월세소득공제율.
           , ITS.HOUSE_INTER_RATE           -- 주택임차차입금 원리금상환액.
           , ITS.HOUSE_AMT_LMT              -- 주택마련주택임차차임금 한도.
           , ITS.LONG_HOUSE_PROF_LMT        -- 장기주택저당차입금 이자상환액(10년)
           , ITS.HOUSE_TOTAL_LMT            -- 주택자금 총공제한도(10년)
           , ITS.LONG_HOUSE_PROF_LMT_1      -- 장기주택저당차입금 이자상환액(15년).
           , ITS.HOUSE_TOTAL_LMT_1          -- 주택자금 총공제한도(15년).
           , ITS.LONG_HOUSE_PROF_LMT_2      -- 장기주택저당차입금 이자상환액(30년).
           , ITS.HOUSE_TOTAL_LMT_2          -- 주택자금 총공제한도(30년).
           , ITS.LEGAL_GIFT_RATE            -- 법정기부금.
           , ITS.ASS_GIFT_RATE1             -- 특례기부금(50%).
           , ITS.ASS_GIFT_RATE2             -- 지정기부금(30%).
           , ITS.ASS_GIFT_RATE3             -- 지정기부금(10%).
           , ITS.ASS_GIFT_RATE3_1           -- 지정기부금(종교단체).
           , ITS.MARRY_DED_STD              -- 혼인 공제기준.
           , ITS.MARRY_DED                  -- 혼인 공제액
           , ITS.FUNE_DED_STD               -- 장례 공제기준.
           , ITS.FUNE_DED                   -- 장례 공제액.
           , ITS.MOVE_DED_STD               -- 이사 공제기준.
           , ITS.MOVE_DED                   -- 이상 공제액.
           , ITS.SP_DED_STD                 -- 표준공제 기준액.
           , ITS.SP_DED_AMT                 -- 표준공제금액.
           , ITS.PRIV_PENS_RATE             -- 개인 연금.
           , ITS.PRIV_PENS_LMT              -- 개인 연금한도.
           , ITS.PENS_DED_RATE              -- 연금저축 비율.
           , ITS.PENS_DED_LMT               -- 연금저축 한도.
           , ITS.RETR_PENS_LMT              -- 퇴직연금 한도.      
           , ITS.SMALL_CORPOR_DED_LMT       -- 소기업 소득공제 한도.
           , ITS.INVEST_RATE1               -- 투자조합출자1(2006년 이전).
           , ITS.INVEST_LMT_RATE1           -- 투자조합출자한도1.
           , ITS.INVEST_RATE2               -- 투자조합출자2(2007이후).
           , ITS.INVEST_LMT_RATE2           -- 투자조합출자한도2.
           , ITS.CARD_BAS_RATE              -- 신용카드 최저 사용한도 비율.
           , ITS.CARD_DED_RATE              -- 신용카드 공제비율.
           , ITS.CARD_DIRECT_RATE           -- 직불카드 공제비율.
           , ITS.CARD_DED_LMT               -- 신용카드 공제한도1.
           , ITS.CARD_DED_LMT_RATE          -- 신용카드 공제한도-총급여에 대한 비율.
           , ITS.CHECK_CARD_DED_RATE        -- 체크카드 공제비율.
           , ITS.CASH_BAS_RATE              -- 현금영수증 최저 사용한도 비율.
           , ITS.CASH_DED_RATE              -- 현금영수증 공제비율.
           , ITS.CASH_DIRECT_RATE           
           , ITS.CASH_DED_LMT               -- 현금영수증 공제한도1.
           , ITS.CASH_DED_LMT_RATE          -- 현금영수증 공제한도-총급여에 대한 비율.
           , ITS.CARD_ADD_DED_LMT           -- 추가공제한도.
           , ITS.CARDCASH_DED_LMT_RATE      -- 신용카드현금영수증 공제한도-총급여에 대한 비율.
           , ITS.STOCK_LMT                  -- 우리사주출자한도.                                       
           , ITS.LONG_STOCK_SAVING_RATE_1   -- 장기주식형저축 비율1.
           , ITS.LONG_STOCK_SAVING_LMT_1    -- 장기주식형저축 한도1.
           , ITS.LONG_STOCK_SAVING_RATE_2   -- 장기주식형저축 비율2.
           , ITS.LONG_STOCK_SAVING_LMT_2    -- 장기주식형저축 한도2.
           , ITS.LONG_STOCK_SAVING_RATE_3   -- 장기주식형저축 비율3.
           , ITS.LONG_STOCK_SAVING_LMT_3    -- 장기주식형저축 한도3.
           , ITS.EMPLOYMENT_KEEP_RATE       -- 고용유지중소기업근로자소득공제율.
           , ITS.EMPLOYMENT_KEEP_LMT        -- 고용유지중소기업근로자소득공제한도.
           , ITS.IN_TAX_BASE                -- 근로소득기본공제금.
           , ITS.IN_TAX_STD_A               -- 근로소득세액공제 한도1.
           , ITS.IN_TAX_RATE_A              -- 근로소득세액공제 한도 비율1.
           , ITS.IN_TAX_STD_B               -- 근로소득세액공제 한도2.
           , ITS.IN_TAX_RATE_B              -- 근로소득세액공제 한도 비율2.
           , ITS.IN_TAX_BASE_B              -- 근로소득세액공제기본 금액2.
           , ITS.IN_TAX_STD_C               -- 근로소득세액공제 한도3.
           , ITS.IN_TAX_RATE_C              -- 근로소득세액공제 한도 비율3.
           , ITS.IN_TAX_BASE_C              -- 근로소득세액공제기본 금액3.
           , ITS.IN_TAX_LMT                 -- 근로소득세액공제 한도.
           , ITS.POLI_GIFT_MAX              -- 정치기부금한도.
           , ITS.POLI_GIFT_RATE             -- 정치기부금 비율.
           , ITS.POLI_GIFT_RATE1            -- 정치기부금 비율1.
           , ITS.TAX_ASSO_RATE              -- 납세조합.
           , ITS.HOUSE_DEBT_BEN_RATE        -- 주택자금차입금이자세액공제.
           , ITS.FOREIGN_TAX_DED            -- 외국납부세액공제.
           , ITS.LOCAL_TAX_RATE             -- 소득세 비율.
           , ITS.SP_TAX_RATE                -- 농특세 적용 비율.
           -- 전호수(2013.01.17) : 2012년도 연말정산 추가 --
           , ITS.PRE_YEAR_INCOME_TOT_AMT_LMT-- 야간근로수당 적용 전년도 총급여한도.
           , ITS.LONG_HOUSE_PROF_LMT_3_FIX  -- 장기주택저당차입금 500만원(고정식).
           , ITS.HOUSE_TOTAL_LMT_3_FIX      -- 장기주택저당차입금 500만원(고정식 총한도).
           , ITS.LONG_HOUSE_PROF_LMT_3_ETC  -- 장기주택저당차입금 500만원(기타). 
           , ITS.HOUSE_TOTAL_LMT_3_ETC      -- 장기주택저당차입금 500만원(기타 총한도).
           , ITS.HOUSE_SAVING_RATE          -- 주택마련저축(청약저축)--
           , ITS.HOUSE_SAVING_LMT           -- 주택마련저축(청약저축) 한도 --
           , ITS.WORKER_HOUSE_SAVING_RATE   -- 근로자주택마련저축--
           , ITS.WORKER_HOUSE_SAVING_LMT    -- 근로자주택마련저축 한도 --
           , ITS.LONG_HOUSE_SAVING_RATE     -- 장기주택마련저축--
           , ITS.LONG_HOUSE_SAVING_LMT      -- 장기주택마련저축 한도 --
           , ITS.HOUSE_SAVING_ALL_RATE      -- 장기주택마련정합저축--
           , ITS.HOUSE_SAVING_ALL_LMT       -- 장기주택마련정합저축 한도--
           , ITS.TRAD_MARKET_DED_RATE       -- 전통시장 공제비율--
           , ITS.CARD_MIN_USE_RATE_1        -- 카드 최저사용금액 한도1--
           , ITS.CARD_MIN_USE_RATE_2        -- 카드 최저사용금액 한도2--
           , ITS.FOREIGN_WORKER_TAX_DED_RATE-- 외국인기술자 세액감면--
           , ITS.SMALL_BUSINESS_TAX_DED_FR  -- 증소기업 취업청년 시작 조건--
           , ITS.SMALL_BUSINESS_TAX_DED_TO  -- 증소기업 취업청년 종료 조건--
           , ITS.SMALL_BUSINESS_TAX_DED_RATE-- 증소기업 취업청년 세액감면율-- 
        FROM HRA_INCOME_TAX_STANDARD ITS
      WHERE ITS.YEAR_YYYY  = P_YEAR_YYYY
        AND ITS.SOB_ID     = P_SOB_ID
        AND ITS.ORG_ID     = P_ORG_ID
      ;
  END SELECT_INCOME_TAX_STANDARD;
  
----------------------------------------------------------------------------------------- 
-- 2. 기본 설정, 특별 공제, 기타 공제, 세액공재(감면) ----------- INSERT.
----------------------------------------------------------------------------------------- 
  PROCEDURE INSERT_INCOME_TAX_STANDARD
           ( P_YEAR_YYYY                    IN HRA_INCOME_TAX_STANDARD.YEAR_YYYY%TYPE
           , P_SOB_ID                       IN HRA_INCOME_TAX_STANDARD.SOB_ID%TYPE
           , P_ORG_ID                       IN HRA_INCOME_TAX_STANDARD.ORG_ID%TYPE
           , P_FOREIGN_INCOME_RATE          IN HRA_INCOME_TAX_STANDARD.FOREIGN_INCOME_RATE%TYPE
           , P_DRIVE_DED_LMT                IN HRA_INCOME_TAX_STANDARD.DRIVE_DED_LMT%TYPE
           , P_RESE_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.RESE_DED_LMT%TYPE
           , P_REPORTER_DED_AMT             IN HRA_INCOME_TAX_STANDARD.REPORTER_DED_AMT%TYPE
           , P_FOREIGN_INCOME_DED_AMT       IN HRA_INCOME_TAX_STANDARD.FOREIGN_INCOME_DED_AMT%TYPE
           , P_MONTH_PAY_STD                IN HRA_INCOME_TAX_STANDARD.MONTH_PAY_STD%TYPE
           , P_OT_DED_LMT                   IN HRA_INCOME_TAX_STANDARD.OT_DED_LMT%TYPE
           , P_FOOD_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.FOOD_DED_LMT%TYPE
           , P_BABY_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.BABY_DED_LMT%TYPE
           , P_INCOME_DED_A                 IN HRA_INCOME_TAX_STANDARD.INCOME_DED_A%TYPE
           , P_INCOME_DED_RATE_A            IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_A%TYPE
           , P_INCOME_DED_AMT_A             IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_A%TYPE
           , P_INCOME_CALCU_BAS_A           IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_A%TYPE
           , P_INCOME_DED_B                 IN HRA_INCOME_TAX_STANDARD.INCOME_DED_B%TYPE
           , P_INCOME_DED_RATE_B            IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_B%TYPE
           , P_INCOME_DED_AMT_B             IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_B%TYPE
           , P_INCOME_CALCU_BAS_B           IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_B%TYPE
           , P_INCOME_DED_C                 IN HRA_INCOME_TAX_STANDARD.INCOME_DED_C%TYPE
           , P_INCOME_DED_RATE_C            IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_C%TYPE
           , P_INCOME_DED_AMT_C             IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_C%TYPE
           , P_INCOME_CALCU_BAS_C           IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_C%TYPE
           , P_INCOME_DED_D                 IN HRA_INCOME_TAX_STANDARD.INCOME_DED_D%TYPE
           , P_INCOME_DED_RATE_D            IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_D%TYPE
           , P_INCOME_DED_AMT_D             IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_D%TYPE
           , P_INCOME_CALCU_BAS_D           IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_D%TYPE
           , P_INCOME_DED_LMT               IN HRA_INCOME_TAX_STANDARD.INCOME_DED_LMT%TYPE
           , P_INCOME_DED_RATE_LMT          IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_LMT%TYPE
           , P_INCOME_DED_AMT_LMT           IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_LMT%TYPE
           , P_INCOME_CALCU_BAS_LMT         IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_LMT%TYPE
           , P_PERSON_DED_AMT               IN HRA_INCOME_TAX_STANDARD.PERSON_DED_AMT%TYPE
           , P_SPOUSE_DED_AMT               IN HRA_INCOME_TAX_STANDARD.SPOUSE_DED_AMT%TYPE
           , P_SUPPORT_DED_AMT              IN HRA_INCOME_TAX_STANDARD.SUPPORT_DED_AMT%TYPE
           , P_OLD_AGED_DED_AMT             IN HRA_INCOME_TAX_STANDARD.OLD_AGED_DED_AMT%TYPE
           , P_OLD_AGED_DED1_AMT            IN HRA_INCOME_TAX_STANDARD.OLD_AGED_DED1_AMT%TYPE
           , P_DISABILITY_DED_AMT           IN HRA_INCOME_TAX_STANDARD.DISABILITY_DED_AMT%TYPE
           , P_WOMAN_DED_AMT                IN HRA_INCOME_TAX_STANDARD.WOMAN_DED_AMT%TYPE
           , P_BRING_CHILD_DED_AMT          IN HRA_INCOME_TAX_STANDARD.BRING_CHILD_DED_AMT%TYPE
           , P_BIRTH_DED_AMT                IN HRA_INCOME_TAX_STANDARD.BIRTH_DED_AMT%TYPE
           , P_MANY_CHILD_DED_CNT           IN HRA_INCOME_TAX_STANDARD.MANY_CHILD_DED_CNT%TYPE
           , P_MANY_CHILD_DED_BAS_AMT       IN HRA_INCOME_TAX_STANDARD.MANY_CHILD_DED_BAS_AMT%TYPE
           , P_MANY_CHILD_DED_ADD_AMT       IN HRA_INCOME_TAX_STANDARD.MANY_CHILD_DED_ADD_AMT%TYPE
           , P_ANCESTOR_MAN_AGE             IN HRA_INCOME_TAX_STANDARD.ANCESTOR_MAN_AGE%TYPE
           , P_ANCESTOR_WOMAN_AGE           IN HRA_INCOME_TAX_STANDARD.ANCESTOR_WOMAN_AGE%TYPE
           , P_DESCENDANT_MAN_AGE           IN HRA_INCOME_TAX_STANDARD.DESCENDANT_MAN_AGE%TYPE
           , P_DESCENDANT_WOMAN_AGE         IN HRA_INCOME_TAX_STANDARD.DESCENDANT_WOMAN_AGE%TYPE
           , P_OLD_DED_AGE                  IN HRA_INCOME_TAX_STANDARD.OLD_DED_AGE%TYPE
           , P_OLD_DED_AGE1                 IN HRA_INCOME_TAX_STANDARD.OLD_DED_AGE1%TYPE
           , P_CHILDREN_DED_AGE             IN HRA_INCOME_TAX_STANDARD.CHILDREN_DED_AGE%TYPE
           , P_BIRTH_DED_AGE                IN HRA_INCOME_TAX_STANDARD.BIRTH_DED_AGE%TYPE
           , P_MANY_CHILD_DED_AGE           IN HRA_INCOME_TAX_STANDARD.MANY_CHILD_DED_AGE%TYPE
           , P_SIBLING_DED_AGE              IN HRA_INCOME_TAX_STANDARD.SIBLING_DED_AGE%TYPE
           , P_SIBLING_DED_AGE1             IN HRA_INCOME_TAX_STANDARD.SIBLING_DED_AGE1%TYPE
           , P_FOSTER_CHILD_DED_AGE         IN HRA_INCOME_TAX_STANDARD.FOSTER_CHILD_DED_AGE%TYPE
           , P_ETC_INSUR_LMT                IN HRA_INCOME_TAX_STANDARD.ETC_INSUR_LMT%TYPE
           , P_DISABILITY_INSUR_LMT         IN HRA_INCOME_TAX_STANDARD.DISABILITY_INSUR_LMT%TYPE
           , P_MEDIC_DED_STD                IN HRA_INCOME_TAX_STANDARD.MEDIC_DED_STD%TYPE
           , P_MEDIC_DED_LMT                IN HRA_INCOME_TAX_STANDARD.MEDIC_DED_LMT%TYPE
           , P_PER_EDU                      IN HRA_INCOME_TAX_STANDARD.PER_EDU%TYPE
           , P_DISABILITY_EDU               IN HRA_INCOME_TAX_STANDARD.DISABILITY_EDU%TYPE
           , P_KIND_EDU                     IN HRA_INCOME_TAX_STANDARD.KIND_EDU%TYPE
           , P_STUD_EDU                     IN HRA_INCOME_TAX_STANDARD.STUD_EDU%TYPE
           , P_UNIV_EDU                     IN HRA_INCOME_TAX_STANDARD.UNIV_EDU%TYPE
           , P_HOUSE_AMT_RATE               IN HRA_INCOME_TAX_STANDARD.HOUSE_AMT_RATE%TYPE
           , P_HOUSE_MONTHLY_STD            IN HRA_INCOME_TAX_STANDARD.HOUSE_MONTHLY_STD%TYPE
           , P_HOUSE_MONTHLY_RATE           IN HRA_INCOME_TAX_STANDARD.HOUSE_MONTHLY_RATE%TYPE
           , P_HOUSE_INTER_RATE             IN HRA_INCOME_TAX_STANDARD.HOUSE_INTER_RATE%TYPE
           , P_HOUSE_AMT_LMT                IN HRA_INCOME_TAX_STANDARD.HOUSE_AMT_LMT%TYPE
           , P_LONG_HOUSE_PROF_LMT          IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT%TYPE
           , P_HOUSE_TOTAL_LMT              IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT%TYPE
           , P_LONG_HOUSE_PROF_LMT_1        IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_1%TYPE
           , P_HOUSE_TOTAL_LMT_1            IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_1%TYPE
           , P_LONG_HOUSE_PROF_LMT_2        IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_2%TYPE
           , P_HOUSE_TOTAL_LMT_2            IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_2%TYPE
           , P_LEGAL_GIFT_RATE              IN HRA_INCOME_TAX_STANDARD.LEGAL_GIFT_RATE%TYPE
           , P_ASS_GIFT_RATE1               IN HRA_INCOME_TAX_STANDARD.ASS_GIFT_RATE1%TYPE
           , P_ASS_GIFT_RATE2               IN HRA_INCOME_TAX_STANDARD.ASS_GIFT_RATE2%TYPE
           , P_ASS_GIFT_RATE3               IN HRA_INCOME_TAX_STANDARD.ASS_GIFT_RATE3%TYPE
           , P_ASS_GIFT_RATE3_1             IN HRA_INCOME_TAX_STANDARD.ASS_GIFT_RATE3_1%TYPE
           , P_MARRY_DED_STD                IN HRA_INCOME_TAX_STANDARD.MARRY_DED_STD%TYPE
           , P_MARRY_DED                    IN HRA_INCOME_TAX_STANDARD.MARRY_DED%TYPE
           , P_FUNE_DED_STD                 IN HRA_INCOME_TAX_STANDARD.FUNE_DED_STD%TYPE
           , P_FUNE_DED                     IN HRA_INCOME_TAX_STANDARD.FUNE_DED%TYPE
           , P_MOVE_DED_STD                 IN HRA_INCOME_TAX_STANDARD.MOVE_DED_STD%TYPE
           , P_MOVE_DED                     IN HRA_INCOME_TAX_STANDARD.MOVE_DED%TYPE
           , P_SP_DED_STD                   IN HRA_INCOME_TAX_STANDARD.SP_DED_STD%TYPE
           , P_SP_DED_AMT                   IN HRA_INCOME_TAX_STANDARD.SP_DED_AMT%TYPE
           , P_PRIV_PENS_RATE               IN HRA_INCOME_TAX_STANDARD.PRIV_PENS_RATE%TYPE
           , P_PRIV_PENS_LMT                IN HRA_INCOME_TAX_STANDARD.PRIV_PENS_LMT%TYPE
           , P_PENS_DED_RATE                IN HRA_INCOME_TAX_STANDARD.PENS_DED_RATE%TYPE
           , P_PENS_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.PENS_DED_LMT%TYPE
           , P_RETR_PENS_LMT                IN HRA_INCOME_TAX_STANDARD.RETR_PENS_LMT%TYPE
           , P_SMALL_CORPOR_DED_LMT         IN HRA_INCOME_TAX_STANDARD.SMALL_CORPOR_DED_LMT%TYPE
           , P_INVEST_RATE1                 IN HRA_INCOME_TAX_STANDARD.INVEST_RATE1%TYPE
           , P_INVEST_LMT_RATE1             IN HRA_INCOME_TAX_STANDARD.INVEST_LMT_RATE1%TYPE
           , P_INVEST_RATE2                 IN HRA_INCOME_TAX_STANDARD.INVEST_RATE2%TYPE
           , P_INVEST_LMT_RATE2             IN HRA_INCOME_TAX_STANDARD.INVEST_LMT_RATE2%TYPE
           , P_CARD_BAS_RATE                IN HRA_INCOME_TAX_STANDARD.CARD_BAS_RATE%TYPE
           , P_CARD_DED_RATE                IN HRA_INCOME_TAX_STANDARD.CARD_DED_RATE%TYPE
           , P_CARD_DIRECT_RATE             IN HRA_INCOME_TAX_STANDARD.CARD_DIRECT_RATE%TYPE
           , P_CARD_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.CARD_DED_LMT%TYPE
           , P_CARD_DED_LMT_RATE            IN HRA_INCOME_TAX_STANDARD.CARD_DED_LMT_RATE%TYPE
           , P_CHECK_CARD_DED_RATE          IN HRA_INCOME_TAX_STANDARD.CHECK_CARD_DED_RATE%TYPE
           , P_CASH_BAS_RATE                IN HRA_INCOME_TAX_STANDARD.CASH_BAS_RATE%TYPE
           , P_CASH_DED_RATE                IN HRA_INCOME_TAX_STANDARD.CASH_DED_RATE%TYPE
           , P_CASH_DIRECT_RATE             IN HRA_INCOME_TAX_STANDARD.CASH_DIRECT_RATE%TYPE
           , P_CASH_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.CASH_DED_LMT%TYPE
           , P_CASH_DED_LMT_RATE            IN HRA_INCOME_TAX_STANDARD.CASH_DED_LMT_RATE%TYPE
           , P_CARD_ADD_DED_LMT             IN HRA_INCOME_TAX_STANDARD.CARD_ADD_DED_LMT%TYPE
           , P_CARDCASH_DED_LMT_RATE        IN HRA_INCOME_TAX_STANDARD.CARDCASH_DED_LMT_RATE%TYPE
           , P_STOCK_LMT                    IN HRA_INCOME_TAX_STANDARD.STOCK_LMT%TYPE
           , P_LONG_STOCK_SAVING_RATE_1     IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_RATE_1%TYPE
           , P_LONG_STOCK_SAVING_LMT_1      IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_LMT_1%TYPE
           , P_LONG_STOCK_SAVING_RATE_2     IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_RATE_2%TYPE
           , P_LONG_STOCK_SAVING_LMT_2      IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_LMT_2%TYPE
           , P_LONG_STOCK_SAVING_RATE_3     IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_RATE_3%TYPE
           , P_LONG_STOCK_SAVING_LMT_3      IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_LMT_3%TYPE
           , P_EMPLOYMENT_KEEP_RATE         IN HRA_INCOME_TAX_STANDARD.EMPLOYMENT_KEEP_RATE%TYPE
           , P_EMPLOYMENT_KEEP_LMT          IN HRA_INCOME_TAX_STANDARD.EMPLOYMENT_KEEP_LMT%TYPE
           , P_IN_TAX_BASE                  IN HRA_INCOME_TAX_STANDARD.IN_TAX_BASE%TYPE
           , P_IN_TAX_STD_A                 IN HRA_INCOME_TAX_STANDARD.IN_TAX_STD_A%TYPE
           , P_IN_TAX_RATE_A                IN HRA_INCOME_TAX_STANDARD.IN_TAX_RATE_A%TYPE
           , P_IN_TAX_STD_B                 IN HRA_INCOME_TAX_STANDARD.IN_TAX_STD_B%TYPE
           , P_IN_TAX_RATE_B                IN HRA_INCOME_TAX_STANDARD.IN_TAX_RATE_B%TYPE
           , P_IN_TAX_BASE_B                IN HRA_INCOME_TAX_STANDARD.IN_TAX_BASE_B%TYPE
           , P_IN_TAX_STD_C                 IN HRA_INCOME_TAX_STANDARD.IN_TAX_STD_C%TYPE
           , P_IN_TAX_RATE_C                IN HRA_INCOME_TAX_STANDARD.IN_TAX_RATE_C%TYPE
           , P_IN_TAX_BASE_C                IN HRA_INCOME_TAX_STANDARD.IN_TAX_BASE_C%TYPE
           , P_IN_TAX_LMT                   IN HRA_INCOME_TAX_STANDARD.IN_TAX_LMT%TYPE
           , P_POLI_GIFT_MAX                IN HRA_INCOME_TAX_STANDARD.POLI_GIFT_MAX%TYPE
           , P_POLI_GIFT_RATE               IN HRA_INCOME_TAX_STANDARD.POLI_GIFT_RATE%TYPE
           , P_POLI_GIFT_RATE1              IN HRA_INCOME_TAX_STANDARD.POLI_GIFT_RATE1%TYPE
           , P_TAX_ASSO_RATE                IN HRA_INCOME_TAX_STANDARD.TAX_ASSO_RATE%TYPE
           , P_HOUSE_DEBT_BEN_RATE          IN HRA_INCOME_TAX_STANDARD.HOUSE_DEBT_BEN_RATE%TYPE
           , P_FOREIGN_TAX_DED              IN HRA_INCOME_TAX_STANDARD.FOREIGN_TAX_DED%TYPE
           , P_LOCAL_TAX_RATE               IN HRA_INCOME_TAX_STANDARD.LOCAL_TAX_RATE%TYPE
           , P_SP_TAX_RATE                  IN HRA_INCOME_TAX_STANDARD.SP_TAX_RATE%TYPE
           , P_DESCRIPTION                  IN HRA_INCOME_TAX_STANDARD.DESCRIPTION%TYPE
           , P_USER_ID                      IN HRA_INCOME_TAX_STANDARD.CREATED_BY%TYPE 
           , P_PRE_YEAR_INCOME_TOT_AMT_LMT  IN HRA_INCOME_TAX_STANDARD.PRE_YEAR_INCOME_TOT_AMT_LMT%TYPE  -- 야간근로수당 적용 전년도 총급여한도.
           , P_LONG_HOUSE_PROF_LMT_3_FIX    IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_3_FIX%TYPE    -- 장기주택저당차입금 500만원(고정식).
           , P_HOUSE_TOTAL_LMT_3_FIX        IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_3_FIX%TYPE        -- 장기주택저당차입금 500만원(고정식 총한도).
           , P_LONG_HOUSE_PROF_LMT_3_ETC    IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_3_ETC%TYPE    -- 장기주택저당차입금 500만원(기타). 
           , P_HOUSE_TOTAL_LMT_3_ETC        IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_3_ETC%TYPE        -- 장기주택저당차입금 500만원(기타 총한도).
           , P_HOUSE_SAVING_RATE            IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_RATE%TYPE            -- 주택마련저축(청약저축)--
           , P_HOUSE_SAVING_LMT             IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_LMT%TYPE             -- 주택마련저축(청약저축) 한도 --
           , P_WORKER_HOUSE_SAVING_RATE     IN HRA_INCOME_TAX_STANDARD.WORKER_HOUSE_SAVING_RATE%TYPE     -- 근로자주택마련저축--
           , P_WORKER_HOUSE_SAVING_LMT      IN HRA_INCOME_TAX_STANDARD.WORKER_HOUSE_SAVING_LMT%TYPE      -- 근로자주택마련저축 한도 --
           , P_LONG_HOUSE_SAVING_RATE       IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_SAVING_RATE%TYPE       -- 장기주택마련저축--
           , P_LONG_HOUSE_SAVING_LMT        IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_SAVING_LMT%TYPE        -- 장기주택마련저축 한도 --
           , P_HOUSE_SAVING_ALL_RATE        IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_ALL_RATE%TYPE        -- 장기주택마련정합저축--
           , P_HOUSE_SAVING_ALL_LMT         IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_ALL_LMT%TYPE         -- 장기주택마련정합저축 한도--
           , P_TRAD_MARKET_DED_RATE         IN HRA_INCOME_TAX_STANDARD.TRAD_MARKET_DED_RATE%TYPE         -- 전통시장 공제비율--
           , P_CARD_MIN_USE_RATE_1          IN HRA_INCOME_TAX_STANDARD.CARD_MIN_USE_RATE_1%TYPE          -- 카드최저사용한도1--
           , P_CARD_MIN_USE_RATE_2          IN HRA_INCOME_TAX_STANDARD.CARD_MIN_USE_RATE_2%TYPE          -- 카드최저사용한도2--
           , P_FOREIGN_WORKER_TAX_DED_RATE  IN HRA_INCOME_TAX_STANDARD.FOREIGN_WORKER_TAX_DED_RATE%TYPE  -- 외국인기술자 세액감면--
           , P_SMALL_BUSINESS_TAX_DED_FR    IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_FR%TYPE    -- 증소기업 취업청년 시작 조건--
           , P_SMALL_BUSINESS_TAX_DED_TO    IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_TO%TYPE    -- 증소기업 취업청년 종료 조건--
           , P_SMALL_BUSINESS_TAX_DED_RATE  IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_RATE%TYPE  -- 증소기업 취업청년 세액감면율-- 
           )
  IS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT      NUMBER := 0;
  BEGIN
    BEGIN
      SELECT COUNT(ITS.YEAR_YYYY) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRA_INCOME_TAX_STANDARD ITS
       WHERE ITS.YEAR_YYYY        = P_YEAR_YYYY
         AND ITS.SOB_ID           = P_SOB_ID
         AND ITS.ORG_ID           = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT > 0 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('EAPP_90003', '&&FIELD_NAME:=' || P_YEAR_YYYY));
      RETURN;  
    END IF;
    
    INSERT INTO HRA_INCOME_TAX_STANDARD
   ( YEAR_YYYY
   , SOB_ID 
   , ORG_ID 
   , FOREIGN_INCOME_RATE 
   , DRIVE_DED_LMT 
   , RESE_DED_LMT 
   , REPORTER_DED_AMT 
   , FOREIGN_INCOME_DED_AMT 
   , MONTH_PAY_STD 
   , OT_DED_LMT 
   , FOOD_DED_LMT 
   , BABY_DED_LMT 
   , INCOME_DED_A 
   , INCOME_DED_RATE_A 
   , INCOME_DED_AMT_A 
   , INCOME_CALCU_BAS_A 
   , INCOME_DED_B 
   , INCOME_DED_RATE_B 
   , INCOME_DED_AMT_B 
   , INCOME_CALCU_BAS_B 
   , INCOME_DED_C 
   , INCOME_DED_RATE_C 
   , INCOME_DED_AMT_C 
   , INCOME_CALCU_BAS_C 
   , INCOME_DED_D 
   , INCOME_DED_RATE_D 
   , INCOME_DED_AMT_D 
   , INCOME_CALCU_BAS_D 
   , INCOME_DED_LMT 
   , INCOME_DED_RATE_LMT 
   , INCOME_DED_AMT_LMT 
   , INCOME_CALCU_BAS_LMT 
   , PERSON_DED_AMT 
   , SPOUSE_DED_AMT 
   , SUPPORT_DED_AMT 
   , OLD_AGED_DED_AMT 
   , OLD_AGED_DED1_AMT 
   , DISABILITY_DED_AMT 
   , WOMAN_DED_AMT 
   , BRING_CHILD_DED_AMT 
   , BIRTH_DED_AMT 
   , MANY_CHILD_DED_CNT 
   , MANY_CHILD_DED_BAS_AMT 
   , MANY_CHILD_DED_ADD_AMT 
   , ANCESTOR_MAN_AGE 
   , ANCESTOR_WOMAN_AGE 
   , DESCENDANT_MAN_AGE 
   , DESCENDANT_WOMAN_AGE 
   , OLD_DED_AGE 
   , OLD_DED_AGE1 
   , CHILDREN_DED_AGE 
   , BIRTH_DED_AGE 
   , MANY_CHILD_DED_AGE 
   , SIBLING_DED_AGE 
   , SIBLING_DED_AGE1 
   , FOSTER_CHILD_DED_AGE 
   , ETC_INSUR_LMT 
   , DISABILITY_INSUR_LMT 
   , MEDIC_DED_STD 
   , MEDIC_DED_LMT 
   , PER_EDU 
   , DISABILITY_EDU 
   , KIND_EDU 
   , STUD_EDU 
   , UNIV_EDU 
   , HOUSE_AMT_RATE 
   , HOUSE_MONTHLY_STD 
   , HOUSE_MONTHLY_RATE 
   , HOUSE_INTER_RATE 
   , HOUSE_AMT_LMT 
   , LONG_HOUSE_PROF_LMT 
   , HOUSE_TOTAL_LMT 
   , LONG_HOUSE_PROF_LMT_1 
   , HOUSE_TOTAL_LMT_1 
   , LONG_HOUSE_PROF_LMT_2 
   , HOUSE_TOTAL_LMT_2 
   , LEGAL_GIFT_RATE 
   , ASS_GIFT_RATE1 
   , ASS_GIFT_RATE2 
   , ASS_GIFT_RATE3 
   , ASS_GIFT_RATE3_1 
   , MARRY_DED_STD 
   , MARRY_DED 
   , FUNE_DED_STD 
   , FUNE_DED 
   , MOVE_DED_STD 
   , MOVE_DED 
   , SP_DED_STD 
   , SP_DED_AMT 
   , PRIV_PENS_RATE 
   , PRIV_PENS_LMT 
   , PENS_DED_RATE 
   , PENS_DED_LMT 
   , RETR_PENS_LMT 
   , SMALL_CORPOR_DED_LMT 
   , INVEST_RATE1 
   , INVEST_LMT_RATE1 
   , INVEST_RATE2 
   , INVEST_LMT_RATE2 
   , CARD_BAS_RATE 
   , CARD_DED_RATE 
   , CARD_DIRECT_RATE 
   , CARD_DED_LMT 
   , CARD_DED_LMT_RATE 
   , CHECK_CARD_DED_RATE 
   , CASH_BAS_RATE 
   , CASH_DED_RATE 
   , CASH_DIRECT_RATE 
   , CASH_DED_LMT 
   , CASH_DED_LMT_RATE 
   , CARD_ADD_DED_LMT
   , CARDCASH_DED_LMT_RATE 
   , STOCK_LMT 
   , LONG_STOCK_SAVING_RATE_1 
   , LONG_STOCK_SAVING_LMT_1 
   , LONG_STOCK_SAVING_RATE_2 
   , LONG_STOCK_SAVING_LMT_2 
   , LONG_STOCK_SAVING_RATE_3 
   , LONG_STOCK_SAVING_LMT_3 
   , EMPLOYMENT_KEEP_RATE 
   , EMPLOYMENT_KEEP_LMT 
   , IN_TAX_BASE 
   , IN_TAX_STD_A 
   , IN_TAX_RATE_A 
   , IN_TAX_STD_B 
   , IN_TAX_RATE_B 
   , IN_TAX_BASE_B 
   , IN_TAX_STD_C 
   , IN_TAX_RATE_C 
   , IN_TAX_BASE_C 
   , IN_TAX_LMT 
   , POLI_GIFT_MAX 
   , POLI_GIFT_RATE 
   , POLI_GIFT_RATE1 
   , TAX_ASSO_RATE 
   , HOUSE_DEBT_BEN_RATE 
   , FOREIGN_TAX_DED 
   , LOCAL_TAX_RATE 
   , SP_TAX_RATE 
   , DESCRIPTION 
   , CREATION_DATE 
   , CREATED_BY 
   , LAST_UPDATE_DATE 
   , LAST_UPDATED_BY 
   , PRE_YEAR_INCOME_TOT_AMT_LMT
   , LONG_HOUSE_PROF_LMT_3_FIX  
   , HOUSE_TOTAL_LMT_3_FIX      
   , LONG_HOUSE_PROF_LMT_3_ETC  
   , HOUSE_TOTAL_LMT_3_ETC      
   , HOUSE_SAVING_RATE          
   , HOUSE_SAVING_LMT           
   , WORKER_HOUSE_SAVING_RATE   
   , WORKER_HOUSE_SAVING_LMT    
   , LONG_HOUSE_SAVING_RATE     
   , LONG_HOUSE_SAVING_LMT      
   , HOUSE_SAVING_ALL_RATE      
   , HOUSE_SAVING_ALL_LMT       
   , TRAD_MARKET_DED_RATE       
   , CARD_MIN_USE_RATE_1
   , CARD_MIN_USE_RATE_2
   , FOREIGN_WORKER_TAX_DED_RATE
   , SMALL_BUSINESS_TAX_DED_FR  
   , SMALL_BUSINESS_TAX_DED_TO  
   , SMALL_BUSINESS_TAX_DED_RATE
   ) VALUES
   ( P_YEAR_YYYY
   , P_SOB_ID
   , P_ORG_ID
   , NVL(P_FOREIGN_INCOME_RATE, 0)
   , NVL(P_DRIVE_DED_LMT, 0)
   , NVL(P_RESE_DED_LMT, 0)
   , NVL(P_REPORTER_DED_AMT, 0)
   , NVL(P_FOREIGN_INCOME_DED_AMT, 0)
   , NVL(P_MONTH_PAY_STD, 0)
   , NVL(P_OT_DED_LMT, 0)
   , NVL(P_FOOD_DED_LMT, 0)
   , NVL(P_BABY_DED_LMT, 0)
   , NVL(P_INCOME_DED_A, 0)
   , NVL(P_INCOME_DED_RATE_A, 0)
   , NVL(P_INCOME_DED_AMT_A, 0)
   , NVL(P_INCOME_CALCU_BAS_A, 0)
   , NVL(P_INCOME_DED_B, 0)
   , NVL(P_INCOME_DED_RATE_B, 0)
   , NVL(P_INCOME_DED_AMT_B, 0)
   , NVL(P_INCOME_CALCU_BAS_B, 0)
   , NVL(P_INCOME_DED_C, 0)
   , NVL(P_INCOME_DED_RATE_C, 0)
   , NVL(P_INCOME_DED_AMT_C, 0)
   , NVL(P_INCOME_CALCU_BAS_C, 0)
   , NVL(P_INCOME_DED_D, 0)
   , NVL(P_INCOME_DED_RATE_D, 0)
   , NVL(P_INCOME_DED_AMT_D, 0)
   , NVL(P_INCOME_CALCU_BAS_D, 0)
   , NVL(P_INCOME_DED_LMT, 0)
   , NVL(P_INCOME_DED_RATE_LMT, 0)
   , NVL(P_INCOME_DED_AMT_LMT, 0)
   , NVL(P_INCOME_CALCU_BAS_LMT, 0)
   , NVL(P_PERSON_DED_AMT, 0)
   , NVL(P_SPOUSE_DED_AMT, 0)
   , NVL(P_SUPPORT_DED_AMT, 0)
   , NVL(P_OLD_AGED_DED_AMT, 0)
   , NVL(P_OLD_AGED_DED1_AMT, 0)
   , NVL(P_DISABILITY_DED_AMT, 0)
   , NVL(P_WOMAN_DED_AMT, 0)
   , NVL(P_BRING_CHILD_DED_AMT, 0)
   , NVL(P_BIRTH_DED_AMT, 0)
   , NVL(P_MANY_CHILD_DED_CNT, 0)
   , NVL(P_MANY_CHILD_DED_BAS_AMT, 0)
   , NVL(P_MANY_CHILD_DED_ADD_AMT, 0)
   , NVL(P_ANCESTOR_MAN_AGE, 0)
   , NVL(P_ANCESTOR_WOMAN_AGE, 0)
   , NVL(P_DESCENDANT_MAN_AGE, 0)
   , NVL(P_DESCENDANT_WOMAN_AGE, 0)
   , NVL(P_OLD_DED_AGE, 0)
   , NVL(P_OLD_DED_AGE1, 0)
   , NVL(P_CHILDREN_DED_AGE, 0)
   , NVL(P_BIRTH_DED_AGE, 0)
   , NVL(P_MANY_CHILD_DED_AGE, 0)
   , NVL(P_SIBLING_DED_AGE, 0)
   , NVL(P_SIBLING_DED_AGE1, 0)
   , NVL(P_FOSTER_CHILD_DED_AGE, 0)
   , NVL(P_ETC_INSUR_LMT, 0)
   , NVL(P_DISABILITY_INSUR_LMT, 0)
   , NVL(P_MEDIC_DED_STD, 0)
   , NVL(P_MEDIC_DED_LMT, 0)
   , NVL(P_PER_EDU, 0)
   , NVL(P_DISABILITY_EDU, 0)
   , NVL(P_KIND_EDU, 0)
   , NVL(P_STUD_EDU, 0)
   , NVL(P_UNIV_EDU, 0)
   , NVL(P_HOUSE_AMT_RATE, 0)
   , NVL(P_HOUSE_MONTHLY_STD, 0)
   , NVL(P_HOUSE_MONTHLY_RATE, 0)
   , NVL(P_HOUSE_INTER_RATE, 0)
   , NVL(P_HOUSE_AMT_LMT, 0)
   , NVL(P_LONG_HOUSE_PROF_LMT, 0)
   , NVL(P_HOUSE_TOTAL_LMT, 0)
   , NVL(P_LONG_HOUSE_PROF_LMT_1, 0)
   , NVL(P_HOUSE_TOTAL_LMT_1, 0)
   , NVL(P_LONG_HOUSE_PROF_LMT_2, 0)
   , NVL(P_HOUSE_TOTAL_LMT_2, 0)
   , NVL(P_LEGAL_GIFT_RATE, 0)
   , NVL(P_ASS_GIFT_RATE1, 0)
   , NVL(P_ASS_GIFT_RATE2, 0)
   , NVL(P_ASS_GIFT_RATE3, 0)
   , NVL(P_ASS_GIFT_RATE3_1, 0)
   , NVL(P_MARRY_DED_STD, 0)
   , NVL(P_MARRY_DED, 0)
   , NVL(P_FUNE_DED_STD, 0)
   , NVL(P_FUNE_DED, 0)
   , NVL(P_MOVE_DED_STD, 0)
   , NVL(P_MOVE_DED, 0)
   , NVL(P_SP_DED_STD, 0)
   , NVL(P_SP_DED_AMT, 0)
   , NVL(P_PRIV_PENS_RATE, 0)
   , NVL(P_PRIV_PENS_LMT, 0)
   , NVL(P_PENS_DED_RATE, 0)
   , NVL(P_PENS_DED_LMT, 0)
   , NVL(P_RETR_PENS_LMT, 0)
   , NVL(P_SMALL_CORPOR_DED_LMT, 0)
   , NVL(P_INVEST_RATE1, 0)
   , NVL(P_INVEST_LMT_RATE1, 0)
   , NVL(P_INVEST_RATE2, 0)
   , NVL(P_INVEST_LMT_RATE2, 0)
   , NVL(P_CARD_BAS_RATE, 0)
   , NVL(P_CARD_DED_RATE, 0)
   , NVL(P_CARD_DIRECT_RATE, 0)
   , NVL(P_CARD_DED_LMT, 0)
   , NVL(P_CARD_DED_LMT_RATE, 0)
   , NVL(P_CHECK_CARD_DED_RATE, 0)
   , NVL(P_CASH_BAS_RATE, 0)
   , NVL(P_CASH_DED_RATE, 0)
   , NVL(P_CASH_DIRECT_RATE, 0)
   , NVL(P_CASH_DED_LMT, 0)
   , NVL(P_CASH_DED_LMT_RATE, 0)
   , NVL(P_CARD_ADD_DED_LMT, 0)
   , NVL(P_CARDCASH_DED_LMT_RATE, 0)
   , NVL(P_STOCK_LMT, 0)
   , NVL(P_LONG_STOCK_SAVING_RATE_1, 0)
   , NVL(P_LONG_STOCK_SAVING_LMT_1, 0)
   , NVL(P_LONG_STOCK_SAVING_RATE_2, 0)
   , NVL(P_LONG_STOCK_SAVING_LMT_2, 0)
   , NVL(P_LONG_STOCK_SAVING_RATE_3, 0)
   , NVL(P_LONG_STOCK_SAVING_LMT_3, 0)
   , NVL(P_EMPLOYMENT_KEEP_RATE, 0)
   , NVL(P_EMPLOYMENT_KEEP_LMT, 0)
   , NVL(P_IN_TAX_BASE, 0)
   , NVL(P_IN_TAX_STD_A, 0)
   , NVL(P_IN_TAX_RATE_A, 0)
   , NVL(P_IN_TAX_STD_B, 0)
   , NVL(P_IN_TAX_RATE_B, 0)
   , NVL(P_IN_TAX_BASE_B, 0)
   , NVL(P_IN_TAX_STD_C, 0)
   , NVL(P_IN_TAX_RATE_C, 0)
   , NVL(P_IN_TAX_BASE_C, 0)
   , NVL(P_IN_TAX_LMT, 0)
   , NVL(P_POLI_GIFT_MAX, 0)
   , NVL(P_POLI_GIFT_RATE, 0)
   , NVL(P_POLI_GIFT_RATE1, 0)
   , NVL(P_TAX_ASSO_RATE, 0)
   , NVL(P_HOUSE_DEBT_BEN_RATE, 0)
   , NVL(P_FOREIGN_TAX_DED, 0)
   , NVL(P_LOCAL_TAX_RATE, 0)
   , NVL(P_SP_TAX_RATE, 0)
   , P_DESCRIPTION
   , V_SYSDATE
   , P_USER_ID
   , V_SYSDATE
   , P_USER_ID
   , NVL(P_PRE_YEAR_INCOME_TOT_AMT_LMT, 0)
   , NVL(P_LONG_HOUSE_PROF_LMT_3_FIX, 0)
   , NVL(P_HOUSE_TOTAL_LMT_3_FIX, 0)
   , NVL(P_LONG_HOUSE_PROF_LMT_3_ETC, 0)
   , NVL(P_HOUSE_TOTAL_LMT_3_ETC, 0)
   , NVL(P_HOUSE_SAVING_RATE, 0)
   , NVL(P_HOUSE_SAVING_LMT, 0)
   , NVL(P_WORKER_HOUSE_SAVING_RATE, 0)
   , NVL(P_WORKER_HOUSE_SAVING_LMT, 0)
   , NVL(P_LONG_HOUSE_SAVING_RATE, 0)
   , NVL(P_LONG_HOUSE_SAVING_LMT, 0)
   , NVL(P_HOUSE_SAVING_ALL_RATE, 0)
   , NVL(P_HOUSE_SAVING_ALL_LMT, 0)
   , NVL(P_TRAD_MARKET_DED_RATE, 0)
   , NVL(P_CARD_MIN_USE_RATE_1, 0)
   , NVL(P_CARD_MIN_USE_RATE_2, 0)
   , NVL(P_FOREIGN_WORKER_TAX_DED_RATE, 0)
   , NVL(P_SMALL_BUSINESS_TAX_DED_FR, 0)
   , NVL(P_SMALL_BUSINESS_TAX_DED_TO, 0)
   , NVL(P_SMALL_BUSINESS_TAX_DED_RATE, 0)
   );

  END INSERT_INCOME_TAX_STANDARD;

----------------------------------------------------------------------------------------- 
-- 3. 기본 설정, 특별 공제, 기타 공제, 세액공재(감면) ----------- UPDATE.
----------------------------------------------------------------------------------------- 
  PROCEDURE UPDATE_INCOME_TAX_STANDARD
           ( W_YEAR_YYYY                    IN HRA_INCOME_TAX_STANDARD.YEAR_YYYY%TYPE
           , P_SOB_ID                       IN HRA_INCOME_TAX_STANDARD.SOB_ID%TYPE
           , P_ORG_ID                       IN HRA_INCOME_TAX_STANDARD.ORG_ID%TYPE
           , P_FOREIGN_INCOME_RATE          IN HRA_INCOME_TAX_STANDARD.FOREIGN_INCOME_RATE%TYPE
           , P_DRIVE_DED_LMT                IN HRA_INCOME_TAX_STANDARD.DRIVE_DED_LMT%TYPE
           , P_RESE_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.RESE_DED_LMT%TYPE
           , P_REPORTER_DED_AMT             IN HRA_INCOME_TAX_STANDARD.REPORTER_DED_AMT%TYPE
           , P_FOREIGN_INCOME_DED_AMT       IN HRA_INCOME_TAX_STANDARD.FOREIGN_INCOME_DED_AMT%TYPE
           , P_MONTH_PAY_STD                IN HRA_INCOME_TAX_STANDARD.MONTH_PAY_STD%TYPE
           , P_OT_DED_LMT                   IN HRA_INCOME_TAX_STANDARD.OT_DED_LMT%TYPE
           , P_FOOD_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.FOOD_DED_LMT%TYPE
           , P_BABY_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.BABY_DED_LMT%TYPE
           , P_INCOME_DED_A                 IN HRA_INCOME_TAX_STANDARD.INCOME_DED_A%TYPE
           , P_INCOME_DED_RATE_A            IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_A%TYPE
           , P_INCOME_DED_AMT_A             IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_A%TYPE
           , P_INCOME_CALCU_BAS_A           IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_A%TYPE
           , P_INCOME_DED_B                 IN HRA_INCOME_TAX_STANDARD.INCOME_DED_B%TYPE
           , P_INCOME_DED_RATE_B            IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_B%TYPE
           , P_INCOME_DED_AMT_B             IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_B%TYPE
           , P_INCOME_CALCU_BAS_B           IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_B%TYPE
           , P_INCOME_DED_C                 IN HRA_INCOME_TAX_STANDARD.INCOME_DED_C%TYPE
           , P_INCOME_DED_RATE_C            IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_C%TYPE
           , P_INCOME_DED_AMT_C             IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_C%TYPE
           , P_INCOME_CALCU_BAS_C           IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_C%TYPE
           , P_INCOME_DED_D                 IN HRA_INCOME_TAX_STANDARD.INCOME_DED_D%TYPE
           , P_INCOME_DED_RATE_D            IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_D%TYPE
           , P_INCOME_DED_AMT_D             IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_D%TYPE
           , P_INCOME_CALCU_BAS_D           IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_D%TYPE
           , P_INCOME_DED_LMT               IN HRA_INCOME_TAX_STANDARD.INCOME_DED_LMT%TYPE
           , P_INCOME_DED_RATE_LMT          IN HRA_INCOME_TAX_STANDARD.INCOME_DED_RATE_LMT%TYPE
           , P_INCOME_DED_AMT_LMT           IN HRA_INCOME_TAX_STANDARD.INCOME_DED_AMT_LMT%TYPE
           , P_INCOME_CALCU_BAS_LMT         IN HRA_INCOME_TAX_STANDARD.INCOME_CALCU_BAS_LMT%TYPE
           , P_PERSON_DED_AMT               IN HRA_INCOME_TAX_STANDARD.PERSON_DED_AMT%TYPE
           , P_SPOUSE_DED_AMT               IN HRA_INCOME_TAX_STANDARD.SPOUSE_DED_AMT%TYPE
           , P_SUPPORT_DED_AMT              IN HRA_INCOME_TAX_STANDARD.SUPPORT_DED_AMT%TYPE
           , P_OLD_AGED_DED_AMT             IN HRA_INCOME_TAX_STANDARD.OLD_AGED_DED_AMT%TYPE
           , P_OLD_AGED_DED1_AMT            IN HRA_INCOME_TAX_STANDARD.OLD_AGED_DED1_AMT%TYPE
           , P_DISABILITY_DED_AMT           IN HRA_INCOME_TAX_STANDARD.DISABILITY_DED_AMT%TYPE
           , P_WOMAN_DED_AMT                IN HRA_INCOME_TAX_STANDARD.WOMAN_DED_AMT%TYPE
           , P_BRING_CHILD_DED_AMT          IN HRA_INCOME_TAX_STANDARD.BRING_CHILD_DED_AMT%TYPE
           , P_BIRTH_DED_AMT                IN HRA_INCOME_TAX_STANDARD.BIRTH_DED_AMT%TYPE
           , P_MANY_CHILD_DED_CNT           IN HRA_INCOME_TAX_STANDARD.MANY_CHILD_DED_CNT%TYPE
           , P_MANY_CHILD_DED_BAS_AMT       IN HRA_INCOME_TAX_STANDARD.MANY_CHILD_DED_BAS_AMT%TYPE
           , P_MANY_CHILD_DED_ADD_AMT       IN HRA_INCOME_TAX_STANDARD.MANY_CHILD_DED_ADD_AMT%TYPE
           , P_ANCESTOR_MAN_AGE             IN HRA_INCOME_TAX_STANDARD.ANCESTOR_MAN_AGE%TYPE
           , P_ANCESTOR_WOMAN_AGE           IN HRA_INCOME_TAX_STANDARD.ANCESTOR_WOMAN_AGE%TYPE
           , P_DESCENDANT_MAN_AGE           IN HRA_INCOME_TAX_STANDARD.DESCENDANT_MAN_AGE%TYPE
           , P_DESCENDANT_WOMAN_AGE         IN HRA_INCOME_TAX_STANDARD.DESCENDANT_WOMAN_AGE%TYPE
           , P_OLD_DED_AGE                  IN HRA_INCOME_TAX_STANDARD.OLD_DED_AGE%TYPE
           , P_OLD_DED_AGE1                 IN HRA_INCOME_TAX_STANDARD.OLD_DED_AGE1%TYPE
           , P_CHILDREN_DED_AGE             IN HRA_INCOME_TAX_STANDARD.CHILDREN_DED_AGE%TYPE
           , P_BIRTH_DED_AGE                IN HRA_INCOME_TAX_STANDARD.BIRTH_DED_AGE%TYPE
           , P_MANY_CHILD_DED_AGE           IN HRA_INCOME_TAX_STANDARD.MANY_CHILD_DED_AGE%TYPE
           , P_SIBLING_DED_AGE              IN HRA_INCOME_TAX_STANDARD.SIBLING_DED_AGE%TYPE
           , P_SIBLING_DED_AGE1             IN HRA_INCOME_TAX_STANDARD.SIBLING_DED_AGE1%TYPE
           , P_FOSTER_CHILD_DED_AGE         IN HRA_INCOME_TAX_STANDARD.FOSTER_CHILD_DED_AGE%TYPE
           , P_ETC_INSUR_LMT                IN HRA_INCOME_TAX_STANDARD.ETC_INSUR_LMT%TYPE
           , P_DISABILITY_INSUR_LMT         IN HRA_INCOME_TAX_STANDARD.DISABILITY_INSUR_LMT%TYPE
           , P_MEDIC_DED_STD                IN HRA_INCOME_TAX_STANDARD.MEDIC_DED_STD%TYPE
           , P_MEDIC_DED_LMT                IN HRA_INCOME_TAX_STANDARD.MEDIC_DED_LMT%TYPE
           , P_PER_EDU                      IN HRA_INCOME_TAX_STANDARD.PER_EDU%TYPE
           , P_DISABILITY_EDU               IN HRA_INCOME_TAX_STANDARD.DISABILITY_EDU%TYPE
           , P_KIND_EDU                     IN HRA_INCOME_TAX_STANDARD.KIND_EDU%TYPE
           , P_STUD_EDU                     IN HRA_INCOME_TAX_STANDARD.STUD_EDU%TYPE
           , P_UNIV_EDU                     IN HRA_INCOME_TAX_STANDARD.UNIV_EDU%TYPE
           , P_HOUSE_AMT_RATE               IN HRA_INCOME_TAX_STANDARD.HOUSE_AMT_RATE%TYPE
           , P_HOUSE_MONTHLY_STD            IN HRA_INCOME_TAX_STANDARD.HOUSE_MONTHLY_STD%TYPE
           , P_HOUSE_MONTHLY_RATE           IN HRA_INCOME_TAX_STANDARD.HOUSE_MONTHLY_RATE%TYPE
           , P_HOUSE_INTER_RATE             IN HRA_INCOME_TAX_STANDARD.HOUSE_INTER_RATE%TYPE
           , P_HOUSE_AMT_LMT                IN HRA_INCOME_TAX_STANDARD.HOUSE_AMT_LMT%TYPE
           , P_LONG_HOUSE_PROF_LMT          IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT%TYPE
           , P_HOUSE_TOTAL_LMT              IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT%TYPE
           , P_LONG_HOUSE_PROF_LMT_1        IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_1%TYPE
           , P_HOUSE_TOTAL_LMT_1            IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_1%TYPE
           , P_LONG_HOUSE_PROF_LMT_2        IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_2%TYPE
           , P_HOUSE_TOTAL_LMT_2            IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_2%TYPE
           , P_LEGAL_GIFT_RATE              IN HRA_INCOME_TAX_STANDARD.LEGAL_GIFT_RATE%TYPE
           , P_ASS_GIFT_RATE1               IN HRA_INCOME_TAX_STANDARD.ASS_GIFT_RATE1%TYPE
           , P_ASS_GIFT_RATE2               IN HRA_INCOME_TAX_STANDARD.ASS_GIFT_RATE2%TYPE
           , P_ASS_GIFT_RATE3               IN HRA_INCOME_TAX_STANDARD.ASS_GIFT_RATE3%TYPE
           , P_ASS_GIFT_RATE3_1             IN HRA_INCOME_TAX_STANDARD.ASS_GIFT_RATE3_1%TYPE
           , P_MARRY_DED_STD                IN HRA_INCOME_TAX_STANDARD.MARRY_DED_STD%TYPE
           , P_MARRY_DED                    IN HRA_INCOME_TAX_STANDARD.MARRY_DED%TYPE
           , P_FUNE_DED_STD                 IN HRA_INCOME_TAX_STANDARD.FUNE_DED_STD%TYPE
           , P_FUNE_DED                     IN HRA_INCOME_TAX_STANDARD.FUNE_DED%TYPE
           , P_MOVE_DED_STD                 IN HRA_INCOME_TAX_STANDARD.MOVE_DED_STD%TYPE
           , P_MOVE_DED                     IN HRA_INCOME_TAX_STANDARD.MOVE_DED%TYPE
           , P_SP_DED_STD                   IN HRA_INCOME_TAX_STANDARD.SP_DED_STD%TYPE
           , P_SP_DED_AMT                   IN HRA_INCOME_TAX_STANDARD.SP_DED_AMT%TYPE
           , P_PRIV_PENS_RATE               IN HRA_INCOME_TAX_STANDARD.PRIV_PENS_RATE%TYPE
           , P_PRIV_PENS_LMT                IN HRA_INCOME_TAX_STANDARD.PRIV_PENS_LMT%TYPE
           , P_PENS_DED_RATE                IN HRA_INCOME_TAX_STANDARD.PENS_DED_RATE%TYPE
           , P_PENS_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.PENS_DED_LMT%TYPE
           , P_RETR_PENS_LMT                IN HRA_INCOME_TAX_STANDARD.RETR_PENS_LMT%TYPE
           , P_SMALL_CORPOR_DED_LMT         IN HRA_INCOME_TAX_STANDARD.SMALL_CORPOR_DED_LMT%TYPE
           , P_INVEST_RATE1                 IN HRA_INCOME_TAX_STANDARD.INVEST_RATE1%TYPE
           , P_INVEST_LMT_RATE1             IN HRA_INCOME_TAX_STANDARD.INVEST_LMT_RATE1%TYPE
           , P_INVEST_RATE2                 IN HRA_INCOME_TAX_STANDARD.INVEST_RATE2%TYPE
           , P_INVEST_LMT_RATE2             IN HRA_INCOME_TAX_STANDARD.INVEST_LMT_RATE2%TYPE
           , P_CARD_BAS_RATE                IN HRA_INCOME_TAX_STANDARD.CARD_BAS_RATE%TYPE
           , P_CARD_DED_RATE                IN HRA_INCOME_TAX_STANDARD.CARD_DED_RATE%TYPE
           , P_CARD_DIRECT_RATE             IN HRA_INCOME_TAX_STANDARD.CARD_DIRECT_RATE%TYPE
           , P_CARD_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.CARD_DED_LMT%TYPE
           , P_CARD_DED_LMT_RATE            IN HRA_INCOME_TAX_STANDARD.CARD_DED_LMT_RATE%TYPE
           , P_CHECK_CARD_DED_RATE          IN HRA_INCOME_TAX_STANDARD.CHECK_CARD_DED_RATE%TYPE
           , P_CASH_BAS_RATE                IN HRA_INCOME_TAX_STANDARD.CASH_BAS_RATE%TYPE
           , P_CASH_DED_RATE                IN HRA_INCOME_TAX_STANDARD.CASH_DED_RATE%TYPE
           , P_CASH_DIRECT_RATE             IN HRA_INCOME_TAX_STANDARD.CASH_DIRECT_RATE%TYPE
           , P_CASH_DED_LMT                 IN HRA_INCOME_TAX_STANDARD.CASH_DED_LMT%TYPE
           , P_CASH_DED_LMT_RATE            IN HRA_INCOME_TAX_STANDARD.CASH_DED_LMT_RATE%TYPE
           , P_CARD_ADD_DED_LMT             IN HRA_INCOME_TAX_STANDARD.CARD_ADD_DED_LMT%TYPE
           , P_CARDCASH_DED_LMT_RATE        IN HRA_INCOME_TAX_STANDARD.CARDCASH_DED_LMT_RATE%TYPE
           , P_STOCK_LMT                    IN HRA_INCOME_TAX_STANDARD.STOCK_LMT%TYPE
           , P_LONG_STOCK_SAVING_RATE_1     IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_RATE_1%TYPE
           , P_LONG_STOCK_SAVING_LMT_1      IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_LMT_1%TYPE
           , P_LONG_STOCK_SAVING_RATE_2     IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_RATE_2%TYPE
           , P_LONG_STOCK_SAVING_LMT_2      IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_LMT_2%TYPE
           , P_LONG_STOCK_SAVING_RATE_3     IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_RATE_3%TYPE
           , P_LONG_STOCK_SAVING_LMT_3      IN HRA_INCOME_TAX_STANDARD.LONG_STOCK_SAVING_LMT_3%TYPE
           , P_EMPLOYMENT_KEEP_RATE         IN HRA_INCOME_TAX_STANDARD.EMPLOYMENT_KEEP_RATE%TYPE
           , P_EMPLOYMENT_KEEP_LMT          IN HRA_INCOME_TAX_STANDARD.EMPLOYMENT_KEEP_LMT%TYPE
           , P_IN_TAX_BASE                  IN HRA_INCOME_TAX_STANDARD.IN_TAX_BASE%TYPE
           , P_IN_TAX_STD_A                 IN HRA_INCOME_TAX_STANDARD.IN_TAX_STD_A%TYPE
           , P_IN_TAX_RATE_A                IN HRA_INCOME_TAX_STANDARD.IN_TAX_RATE_A%TYPE
           , P_IN_TAX_STD_B                 IN HRA_INCOME_TAX_STANDARD.IN_TAX_STD_B%TYPE
           , P_IN_TAX_RATE_B                IN HRA_INCOME_TAX_STANDARD.IN_TAX_RATE_B%TYPE
           , P_IN_TAX_BASE_B                IN HRA_INCOME_TAX_STANDARD.IN_TAX_BASE_B%TYPE
           , P_IN_TAX_STD_C                 IN HRA_INCOME_TAX_STANDARD.IN_TAX_STD_C%TYPE
           , P_IN_TAX_RATE_C                IN HRA_INCOME_TAX_STANDARD.IN_TAX_RATE_C%TYPE
           , P_IN_TAX_BASE_C                IN HRA_INCOME_TAX_STANDARD.IN_TAX_BASE_C%TYPE
           , P_IN_TAX_LMT                   IN HRA_INCOME_TAX_STANDARD.IN_TAX_LMT%TYPE
           , P_POLI_GIFT_MAX                IN HRA_INCOME_TAX_STANDARD.POLI_GIFT_MAX%TYPE
           , P_POLI_GIFT_RATE               IN HRA_INCOME_TAX_STANDARD.POLI_GIFT_RATE%TYPE
           , P_POLI_GIFT_RATE1              IN HRA_INCOME_TAX_STANDARD.POLI_GIFT_RATE1%TYPE
           , P_TAX_ASSO_RATE                IN HRA_INCOME_TAX_STANDARD.TAX_ASSO_RATE%TYPE
           , P_HOUSE_DEBT_BEN_RATE          IN HRA_INCOME_TAX_STANDARD.HOUSE_DEBT_BEN_RATE%TYPE
           , P_FOREIGN_TAX_DED              IN HRA_INCOME_TAX_STANDARD.FOREIGN_TAX_DED%TYPE
           , P_LOCAL_TAX_RATE               IN HRA_INCOME_TAX_STANDARD.LOCAL_TAX_RATE%TYPE
           , P_SP_TAX_RATE                  IN HRA_INCOME_TAX_STANDARD.SP_TAX_RATE%TYPE
           , P_DESCRIPTION                  IN HRA_INCOME_TAX_STANDARD.DESCRIPTION%TYPE
           , P_USER_ID                      IN HRA_INCOME_TAX_STANDARD.CREATED_BY%TYPE 
           , P_PRE_YEAR_INCOME_TOT_AMT_LMT  IN HRA_INCOME_TAX_STANDARD.PRE_YEAR_INCOME_TOT_AMT_LMT%TYPE  -- 야간근로수당 적용 전년도 총급여한도.
           , P_LONG_HOUSE_PROF_LMT_3_FIX    IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_3_FIX%TYPE    -- 장기주택저당차입금 500만원(고정식).
           , P_HOUSE_TOTAL_LMT_3_FIX        IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_3_FIX%TYPE        -- 장기주택저당차입금 500만원(고정식 총한도).
           , P_LONG_HOUSE_PROF_LMT_3_ETC    IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_3_ETC%TYPE    -- 장기주택저당차입금 500만원(기타). 
           , P_HOUSE_TOTAL_LMT_3_ETC        IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_3_ETC%TYPE        -- 장기주택저당차입금 500만원(기타 총한도).
           , P_HOUSE_SAVING_RATE            IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_RATE%TYPE            -- 주택마련저축(청약저축)--
           , P_HOUSE_SAVING_LMT             IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_LMT%TYPE             -- 주택마련저축(청약저축) 한도 --
           , P_WORKER_HOUSE_SAVING_RATE     IN HRA_INCOME_TAX_STANDARD.WORKER_HOUSE_SAVING_RATE%TYPE     -- 근로자주택마련저축--
           , P_WORKER_HOUSE_SAVING_LMT      IN HRA_INCOME_TAX_STANDARD.WORKER_HOUSE_SAVING_LMT%TYPE      -- 근로자주택마련저축 한도 --
           , P_LONG_HOUSE_SAVING_RATE       IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_SAVING_RATE%TYPE       -- 장기주택마련저축--
           , P_LONG_HOUSE_SAVING_LMT        IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_SAVING_LMT%TYPE        -- 장기주택마련저축 한도 --
           , P_HOUSE_SAVING_ALL_RATE        IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_ALL_RATE%TYPE        -- 장기주택마련정합저축--
           , P_HOUSE_SAVING_ALL_LMT         IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_ALL_LMT%TYPE         -- 장기주택마련정합저축 한도--
           , P_TRAD_MARKET_DED_RATE         IN HRA_INCOME_TAX_STANDARD.TRAD_MARKET_DED_RATE%TYPE         -- 전통시장 공제비율--
           , P_CARD_MIN_USE_RATE_1          IN HRA_INCOME_TAX_STANDARD.CARD_MIN_USE_RATE_1%TYPE          -- 카드최저사용한도1--
           , P_CARD_MIN_USE_RATE_2          IN HRA_INCOME_TAX_STANDARD.CARD_MIN_USE_RATE_2%TYPE          -- 카드최저사용한도2--
           , P_FOREIGN_WORKER_TAX_DED_RATE  IN HRA_INCOME_TAX_STANDARD.FOREIGN_WORKER_TAX_DED_RATE%TYPE  -- 외국인기술자 세액감면--
           , P_SMALL_BUSINESS_TAX_DED_FR    IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_FR%TYPE    -- 증소기업 취업청년 시작 조건--
           , P_SMALL_BUSINESS_TAX_DED_TO    IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_TO%TYPE    -- 증소기업 취업청년 종료 조건--
           , P_SMALL_BUSINESS_TAX_DED_RATE  IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_RATE%TYPE  -- 증소기업 취업청년 세액감면율-- 
           )
  IS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN

   UPDATE HRA_INCOME_TAX_STANDARD
    SET FOREIGN_INCOME_RATE          = NVL(P_FOREIGN_INCOME_RATE, 0)
      , DRIVE_DED_LMT                = NVL(P_DRIVE_DED_LMT, 0)
      , RESE_DED_LMT                 = NVL(P_RESE_DED_LMT, 0)
      , REPORTER_DED_AMT             = NVL(P_REPORTER_DED_AMT, 0)
      , FOREIGN_INCOME_DED_AMT       = NVL(P_FOREIGN_INCOME_DED_AMT, 0)
      , MONTH_PAY_STD                = NVL(P_MONTH_PAY_STD, 0)
      , OT_DED_LMT                   = NVL(P_OT_DED_LMT, 0)
      , FOOD_DED_LMT                 = NVL(P_FOOD_DED_LMT, 0)
      , BABY_DED_LMT                 = NVL(P_BABY_DED_LMT, 0)
      , INCOME_DED_A                 = NVL(P_INCOME_DED_A, 0)
      , INCOME_DED_RATE_A            = NVL(P_INCOME_DED_RATE_A, 0)
      , INCOME_DED_AMT_A             = NVL(P_INCOME_DED_AMT_A, 0)
      , INCOME_CALCU_BAS_A           = NVL(P_INCOME_CALCU_BAS_A, 0)
      , INCOME_DED_B                 = NVL(P_INCOME_DED_B, 0)
      , INCOME_DED_RATE_B            = NVL(P_INCOME_DED_RATE_B, 0)
      , INCOME_DED_AMT_B             = NVL(P_INCOME_DED_AMT_B, 0)
      , INCOME_CALCU_BAS_B           = NVL(P_INCOME_CALCU_BAS_B, 0)
      , INCOME_DED_C                 = NVL(P_INCOME_DED_C, 0)
      , INCOME_DED_RATE_C            = NVL(P_INCOME_DED_RATE_C, 0)
      , INCOME_DED_AMT_C             = NVL(P_INCOME_DED_AMT_C, 0)
      , INCOME_CALCU_BAS_C           = NVL(P_INCOME_CALCU_BAS_C, 0)
      , INCOME_DED_D                 = NVL(P_INCOME_DED_D, 0)
      , INCOME_DED_RATE_D            = NVL(P_INCOME_DED_RATE_D, 0)
      , INCOME_DED_AMT_D             = NVL(P_INCOME_DED_AMT_D, 0)
      , INCOME_CALCU_BAS_D           = NVL(P_INCOME_CALCU_BAS_D, 0)
      , INCOME_DED_LMT               = NVL(P_INCOME_DED_LMT, 0)
      , INCOME_DED_RATE_LMT          = NVL(P_INCOME_DED_RATE_LMT, 0)
      , INCOME_DED_AMT_LMT           = NVL(P_INCOME_DED_AMT_LMT, 0)
      , INCOME_CALCU_BAS_LMT         = NVL(P_INCOME_CALCU_BAS_LMT, 0)
      , PERSON_DED_AMT               = NVL(P_PERSON_DED_AMT, 0)
      , SPOUSE_DED_AMT               = NVL(P_SPOUSE_DED_AMT, 0)
      , SUPPORT_DED_AMT              = NVL(P_SUPPORT_DED_AMT, 0)
      , OLD_AGED_DED_AMT             = NVL(P_OLD_AGED_DED_AMT, 0)
      , OLD_AGED_DED1_AMT            = NVL(P_OLD_AGED_DED1_AMT, 0)
      , DISABILITY_DED_AMT           = NVL(P_DISABILITY_DED_AMT, 0)
      , WOMAN_DED_AMT                = NVL(P_WOMAN_DED_AMT, 0)
      , BRING_CHILD_DED_AMT          = NVL(P_BRING_CHILD_DED_AMT, 0)
      , BIRTH_DED_AMT                = NVL(P_BIRTH_DED_AMT, 0)
      , MANY_CHILD_DED_CNT           = NVL(P_MANY_CHILD_DED_CNT, 0)
      , MANY_CHILD_DED_BAS_AMT       = NVL(P_MANY_CHILD_DED_BAS_AMT, 0)
      , MANY_CHILD_DED_ADD_AMT       = NVL(P_MANY_CHILD_DED_ADD_AMT, 0)
      , ANCESTOR_MAN_AGE             = NVL(P_ANCESTOR_MAN_AGE, 0)
      , ANCESTOR_WOMAN_AGE           = NVL(P_ANCESTOR_WOMAN_AGE, 0)
      , DESCENDANT_MAN_AGE           = NVL(P_DESCENDANT_MAN_AGE, 0)
      , DESCENDANT_WOMAN_AGE         = NVL(P_DESCENDANT_WOMAN_AGE, 0)
      , OLD_DED_AGE                  = NVL(P_OLD_DED_AGE, 0)
      , OLD_DED_AGE1                 = NVL(P_OLD_DED_AGE1, 0)
      , CHILDREN_DED_AGE             = NVL(P_CHILDREN_DED_AGE, 0)
      , BIRTH_DED_AGE                = NVL(P_BIRTH_DED_AGE, 0)
      , MANY_CHILD_DED_AGE           = NVL(P_MANY_CHILD_DED_AGE, 0)
      , SIBLING_DED_AGE              = NVL(P_SIBLING_DED_AGE, 0)
      , SIBLING_DED_AGE1             = NVL(P_SIBLING_DED_AGE1, 0)
      , FOSTER_CHILD_DED_AGE         = NVL(P_FOSTER_CHILD_DED_AGE, 0)
      , ETC_INSUR_LMT                = NVL(P_ETC_INSUR_LMT, 0)
      , DISABILITY_INSUR_LMT         = NVL(P_DISABILITY_INSUR_LMT, 0)
      , MEDIC_DED_STD                = NVL(P_MEDIC_DED_STD, 0)
      , MEDIC_DED_LMT                = NVL(P_MEDIC_DED_LMT, 0)
      , PER_EDU                      = NVL(P_PER_EDU, 0)
      , DISABILITY_EDU               = NVL(P_DISABILITY_EDU, 0)
      , KIND_EDU                     = NVL(P_KIND_EDU, 0)
      , STUD_EDU                     = NVL(P_STUD_EDU, 0)
      , UNIV_EDU                     = NVL(P_UNIV_EDU, 0)
      , HOUSE_AMT_RATE               = NVL(P_HOUSE_AMT_RATE, 0)
      , HOUSE_MONTHLY_STD            = NVL(P_HOUSE_MONTHLY_STD, 0)
      , HOUSE_MONTHLY_RATE           = NVL(P_HOUSE_MONTHLY_RATE, 0)
      , HOUSE_INTER_RATE             = NVL(P_HOUSE_INTER_RATE, 0)
      , HOUSE_AMT_LMT                = NVL(P_HOUSE_AMT_LMT, 0)
      , LONG_HOUSE_PROF_LMT          = NVL(P_LONG_HOUSE_PROF_LMT, 0)
      , HOUSE_TOTAL_LMT              = NVL(P_HOUSE_TOTAL_LMT, 0)
      , LONG_HOUSE_PROF_LMT_1        = NVL(P_LONG_HOUSE_PROF_LMT_1, 0)
      , HOUSE_TOTAL_LMT_1            = NVL(P_HOUSE_TOTAL_LMT_1, 0)
      , LONG_HOUSE_PROF_LMT_2        = NVL(P_LONG_HOUSE_PROF_LMT_2, 0)
      , HOUSE_TOTAL_LMT_2            = NVL(P_HOUSE_TOTAL_LMT_2, 0)
      , LEGAL_GIFT_RATE              = NVL(P_LEGAL_GIFT_RATE, 0)
      , ASS_GIFT_RATE1               = NVL(P_ASS_GIFT_RATE1, 0)
      , ASS_GIFT_RATE2               = NVL(P_ASS_GIFT_RATE2, 0)
      , ASS_GIFT_RATE3               = NVL(P_ASS_GIFT_RATE3, 0)
      , ASS_GIFT_RATE3_1             = NVL(P_ASS_GIFT_RATE3_1, 0)
      , MARRY_DED_STD                = NVL(P_MARRY_DED_STD, 0)
      , MARRY_DED                    = NVL(P_MARRY_DED, 0)
      , FUNE_DED_STD                 = NVL(P_FUNE_DED_STD, 0)
      , FUNE_DED                     = NVL(P_FUNE_DED, 0)
      , MOVE_DED_STD                 = NVL(P_MOVE_DED_STD, 0)
      , MOVE_DED                     = NVL(P_MOVE_DED, 0)
      , SP_DED_STD                   = NVL(P_SP_DED_STD, 0)
      , SP_DED_AMT                   = NVL(P_SP_DED_AMT, 0)
      , PRIV_PENS_RATE               = NVL(P_PRIV_PENS_RATE, 0)
      , PRIV_PENS_LMT                = NVL(P_PRIV_PENS_LMT, 0)
      , PENS_DED_RATE                = NVL(P_PENS_DED_RATE, 0)
      , PENS_DED_LMT                 = NVL(P_PENS_DED_LMT, 0)
      , RETR_PENS_LMT                = NVL(P_RETR_PENS_LMT, 0)
      , SMALL_CORPOR_DED_LMT         = NVL(P_SMALL_CORPOR_DED_LMT, 0)
      , INVEST_RATE1                 = NVL(P_INVEST_RATE1, 0)
      , INVEST_LMT_RATE1             = NVL(P_INVEST_LMT_RATE1, 0)
      , INVEST_RATE2                 = NVL(P_INVEST_RATE2, 0)
      , INVEST_LMT_RATE2             = NVL(P_INVEST_LMT_RATE2, 0)
      , CARD_BAS_RATE                = NVL(P_CARD_BAS_RATE, 0)
      , CARD_DED_RATE                = NVL(P_CARD_DED_RATE, 0)
      , CARD_DIRECT_RATE             = NVL(P_CARD_DIRECT_RATE, 0)
      , CARD_DED_LMT                 = NVL(P_CARD_DED_LMT, 0)
      , CARD_DED_LMT_RATE            = NVL(P_CARD_DED_LMT_RATE, 0)
      , CHECK_CARD_DED_RATE          = NVL(P_CHECK_CARD_DED_RATE, 0)
      , CASH_BAS_RATE                = NVL(P_CASH_BAS_RATE, 0)
      , CASH_DED_RATE                = NVL(P_CASH_DED_RATE, 0)
      , CASH_DIRECT_RATE             = NVL(P_CASH_DIRECT_RATE, 0)
      , CASH_DED_LMT                 = NVL(P_CASH_DED_LMT, 0)
      , CASH_DED_LMT_RATE            = NVL(P_CASH_DED_LMT_RATE, 0)
      , CARD_ADD_DED_LMT             = NVL(P_CARD_ADD_DED_LMT, 0)
      , CARDCASH_DED_LMT_RATE        = NVL(P_CARDCASH_DED_LMT_RATE, 0)
      , STOCK_LMT                    = NVL(P_STOCK_LMT, 0)
      , LONG_STOCK_SAVING_RATE_1     = NVL(P_LONG_STOCK_SAVING_RATE_1, 0)
      , LONG_STOCK_SAVING_LMT_1      = NVL(P_LONG_STOCK_SAVING_LMT_1, 0)
      , LONG_STOCK_SAVING_RATE_2     = NVL(P_LONG_STOCK_SAVING_RATE_2, 0)
      , LONG_STOCK_SAVING_LMT_2      = NVL(P_LONG_STOCK_SAVING_LMT_2, 0)
      , LONG_STOCK_SAVING_RATE_3     = NVL(P_LONG_STOCK_SAVING_RATE_3, 0)
      , LONG_STOCK_SAVING_LMT_3      = NVL(P_LONG_STOCK_SAVING_LMT_3, 0)
      , EMPLOYMENT_KEEP_RATE         = NVL(P_EMPLOYMENT_KEEP_RATE, 0)
      , EMPLOYMENT_KEEP_LMT          = NVL(P_EMPLOYMENT_KEEP_LMT, 0)
      , IN_TAX_BASE                  = NVL(P_IN_TAX_BASE, 0)
      , IN_TAX_STD_A                 = NVL(P_IN_TAX_STD_A, 0)
      , IN_TAX_RATE_A                = NVL(P_IN_TAX_RATE_A, 0)
      , IN_TAX_STD_B                 = NVL(P_IN_TAX_STD_B, 0)
      , IN_TAX_RATE_B                = NVL(P_IN_TAX_RATE_B, 0)
      , IN_TAX_BASE_B                = NVL(P_IN_TAX_BASE_B, 0)
      , IN_TAX_STD_C                 = NVL(P_IN_TAX_STD_C, 0)
      , IN_TAX_RATE_C                = NVL(P_IN_TAX_RATE_C, 0)
      , IN_TAX_BASE_C                = NVL(P_IN_TAX_BASE_C, 0)
      , IN_TAX_LMT                   = NVL(P_IN_TAX_LMT, 0)
      , POLI_GIFT_MAX                = NVL(P_POLI_GIFT_MAX, 0)
      , POLI_GIFT_RATE               = NVL(P_POLI_GIFT_RATE, 0)
      , POLI_GIFT_RATE1              = NVL(P_POLI_GIFT_RATE1, 0)
      , TAX_ASSO_RATE                = NVL(P_TAX_ASSO_RATE, 0)
      , HOUSE_DEBT_BEN_RATE          = NVL(P_HOUSE_DEBT_BEN_RATE, 0)
      , FOREIGN_TAX_DED              = NVL(P_FOREIGN_TAX_DED, 0)
      , LOCAL_TAX_RATE               = NVL(P_LOCAL_TAX_RATE, 0)
      , SP_TAX_RATE                  = NVL(P_SP_TAX_RATE, 0)
      , DESCRIPTION                  = P_DESCRIPTION
      , LAST_UPDATE_DATE             = V_SYSDATE
      , LAST_UPDATED_BY              = P_USER_ID
			, PRE_YEAR_INCOME_TOT_AMT_LMT  = NVL(P_PRE_YEAR_INCOME_TOT_AMT_LMT, 0)             
			, LONG_HOUSE_PROF_LMT_3_FIX    = NVL(P_LONG_HOUSE_PROF_LMT_3_FIX, 0)  
			, HOUSE_TOTAL_LMT_3_FIX        = NVL(P_HOUSE_TOTAL_LMT_3_FIX, 0)      
			, LONG_HOUSE_PROF_LMT_3_ETC    = NVL(P_LONG_HOUSE_PROF_LMT_3_ETC, 0)  
			, HOUSE_TOTAL_LMT_3_ETC        = NVL(P_HOUSE_TOTAL_LMT_3_ETC, 0)      
			, HOUSE_SAVING_RATE            = NVL(P_HOUSE_SAVING_RATE, 0)          
			, HOUSE_SAVING_LMT             = NVL(P_HOUSE_SAVING_LMT, 0)           
			, WORKER_HOUSE_SAVING_RATE     = NVL(P_WORKER_HOUSE_SAVING_RATE, 0)   
			, WORKER_HOUSE_SAVING_LMT      = NVL(P_WORKER_HOUSE_SAVING_LMT, 0)    
			, LONG_HOUSE_SAVING_RATE       = NVL(P_LONG_HOUSE_SAVING_RATE, 0)     
			, LONG_HOUSE_SAVING_LMT        = NVL(P_LONG_HOUSE_SAVING_LMT, 0)      
			, HOUSE_SAVING_ALL_RATE        = NVL(P_HOUSE_SAVING_ALL_RATE, 0)      
			, HOUSE_SAVING_ALL_LMT         = NVL(P_HOUSE_SAVING_ALL_LMT, 0)       
			, TRAD_MARKET_DED_RATE         = NVL(P_TRAD_MARKET_DED_RATE, 0)       
      , CARD_MIN_USE_RATE_1          = NVL(P_CARD_MIN_USE_RATE_1, 0)
      , CARD_MIN_USE_RATE_2          = NVL(P_CARD_MIN_USE_RATE_2, 0)
			, FOREIGN_WORKER_TAX_DED_RATE  = NVL(P_FOREIGN_WORKER_TAX_DED_RATE, 0)
			, SMALL_BUSINESS_TAX_DED_FR    = NVL(P_SMALL_BUSINESS_TAX_DED_FR, 0)  
			, SMALL_BUSINESS_TAX_DED_TO    = NVL(P_SMALL_BUSINESS_TAX_DED_TO, 0)  
			, SMALL_BUSINESS_TAX_DED_RATE  = NVL(P_SMALL_BUSINESS_TAX_DED_RATE, 0)
    WHERE YEAR_YYYY   = W_YEAR_YYYY
      AND SOB_ID      = P_SOB_ID
      AND ORG_ID      = P_ORG_ID;
  END UPDATE_INCOME_TAX_STANDARD;


----------------------------------------------------------------------------------------- 
-- 4. 기본 설정, 특별 공제, 기타 공제, 세액공재(감면) ----------- DELETE.
-----------------------------------------------------------------------------------------
  PROCEDURE DELETE_INCOME_TAX_STANDARD
          ( W_YEAR_YYYY   IN HRA_INCOME_TAX_STANDARD.YEAR_YYYY%TYPE
          , W_SOB_ID      IN HRA_INCOME_TAX_STANDARD.SOB_ID%TYPE
          , W_ORG_ID      IN HRA_INCOME_TAX_STANDARD.ORG_ID%TYPE 
          )
  IS

  BEGIN

   DELETE HRA_INCOME_TAX_STANDARD
    WHERE YEAR_YYYY   = W_YEAR_YYYY
      AND SOB_ID      = W_SOB_ID
      AND ORG_ID      = W_ORG_ID;   
  END DELETE_INCOME_TAX_STANDARD;
  
  
----------------------------------------------------------------------------------------- 
-- 5. 해당 년도 기준 정보 존재 여부 체크.     [전 년도 복사 버튼에 사용]
-----------------------------------------------------------------------------------------
  PROCEDURE CHECK_TAX_STANDARD_YN
            ( W_YEAR_YYYY             IN HRA_INCOME_TAX_STANDARD.YEAR_YYYY%TYPE
            , W_SOB_ID                IN HRA_INCOME_TAX_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                IN HRA_INCOME_TAX_STANDARD.ORG_ID%TYPE
            , O_CHECK_YN              OUT VARCHAR2
            )
  AS
  BEGIN
    SELECT DECODE(COUNT(ITS.YEAR_YYYY), 0, 'N', 'Y') AS RECORD_COUNT
      INTO O_CHECK_YN
      FROM HRA_INCOME_TAX_STANDARD ITS
     WHERE ITS.YEAR_YYYY    = W_YEAR_YYYY
       AND ITS.SOB_ID       = W_SOB_ID
       AND ITS.ORG_ID       = W_ORG_ID
       ;
  EXCEPTION WHEN OTHERS THEN
    O_CHECK_YN := 'N';            
            
  END CHECK_TAX_STANDARD_YN;


----------------------------------------------------------------------------------------- 
-- 6. 전년도 기준 정보 COPY.                 [전 년도 복사 버튼에 사용]
-----------------------------------------------------------------------------------------
  PROCEDURE COPY_TAX_STANDARD
            ( W_YEAR_YYYY             IN HRA_INCOME_TAX_STANDARD.YEAR_YYYY%TYPE
            , W_SOB_ID                IN HRA_INCOME_TAX_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                IN HRA_INCOME_TAX_STANDARD.ORG_ID%TYPE
            , P_USER_ID               IN HRA_INCOME_TAX_STANDARD.CREATED_BY%TYPE
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_PRE_YEAR_YYYY               HRA_INCOME_TAX_STANDARD.YEAR_YYYY%TYPE;
  BEGIN
    O_STATUS := 'F';
    V_PRE_YEAR_YYYY := W_YEAR_YYYY - 1;
    
    -- 데이터 삭제.
    DELETE HRA_INCOME_TAX_STANDARD ITS
    WHERE ITS.YEAR_YYYY   = W_YEAR_YYYY
      AND ITS.SOB_ID      = W_SOB_ID
      AND ITS.ORG_ID      = W_ORG_ID
      ;
      
    BEGIN
      INSERT INTO HRA_INCOME_TAX_STANDARD
      (  YEAR_YYYY                  -- 적용년도.
       , SOB_ID
       , ORG_ID
       , FOREIGN_INCOME_RATE        -- 외국인근로자단일세율.
       , DRIVE_DED_LMT              -- 자가운전보조금.
       , RESE_DED_LMT               -- 연구보조비.
       , REPORTER_DED_AMT           -- 취재수당.
       , FOREIGN_INCOME_DED_AMT     -- 국외근로소득.
       , MONTH_PAY_STD              -- 야간근로수당 적용 급여 기준.
       , OT_DED_LMT                 -- 야간근로수당 한도.
       , FOOD_DED_LMT               -- 식대한도.
       , BABY_DED_LMT               -- 보육수당 한도.
       , INCOME_DED_A               -- 근로소득공제 A.
       , INCOME_DED_RATE_A          -- 근로소득공제율 A.
       , INCOME_DED_AMT_A           -- 근로소득공제금액 A.
       , INCOME_CALCU_BAS_A         -- 근로소득 기본금액 A.
       , INCOME_DED_B               -- 근로소득공제 B.
       , INCOME_DED_RATE_B          -- 근로소득공제율 B.
       , INCOME_DED_AMT_B           -- 근로소득공제금액 B.
       , INCOME_CALCU_BAS_B         -- 근로소득 기본금액 B.
       , INCOME_DED_C               -- 근로소득공제 C.
       , INCOME_DED_RATE_C          -- 근로소득공제율 C.
       , INCOME_DED_AMT_C           -- 근로소득공제금액 C.
       , INCOME_CALCU_BAS_C         -- 근로소득 기본금액 C.
       , INCOME_DED_D               -- 근로소득공제 D.
       , INCOME_DED_RATE_D          -- 근로소득공제율 D.
       , INCOME_DED_AMT_D           -- 근로소득공제금액 D.
       , INCOME_CALCU_BAS_D         -- 근로소득 기본금액 D.
       , INCOME_DED_LMT             -- 근로소득공제 한도.
       , INCOME_DED_RATE_LMT        -- 근로소득공제율 한도.
       , INCOME_DED_AMT_LMT         -- 근로소득공제금액 한도.
       , INCOME_CALCU_BAS_LMT       -- 근로소득 기본금액 한도.
       , PERSON_DED_AMT             -- 기본공제-본인.
       , SPOUSE_DED_AMT             -- 기본공제-배우자.
       , SUPPORT_DED_AMT            -- 기본공제-부양가족.
       , OLD_AGED_DED_AMT           -- 추가공제-경로우대1(65~69).
       , OLD_AGED_DED1_AMT          -- 추가공제-경로우대(70~)
       , DISABILITY_DED_AMT         -- 추가공제-장애자.
       , WOMAN_DED_AMT              -- 추가공제-부녀세대.
       , BRING_CHILD_DED_AMT        -- 추가공제-자녀양육.
       , BIRTH_DED_AMT              -- 출산/입양.
       , MANY_CHILD_DED_CNT         -- 다자녀추가-인원기준.
       , MANY_CHILD_DED_BAS_AMT     -- 다자녀추가-기본금액.
       , MANY_CHILD_DED_ADD_AMT     -- 다자녀추가-인당금액.
       , ANCESTOR_MAN_AGE           -- 직계존속 남자 공제나이.
       , ANCESTOR_WOMAN_AGE         -- 직계존속 여자 공제나이.
       , DESCENDANT_MAN_AGE         -- 직계비속 남자 공제나이.
       , DESCENDANT_WOMAN_AGE       -- 직계비속 여자 공제나이.
       , OLD_DED_AGE                -- 경로우대1.
       , OLD_DED_AGE1               -- 경로우대2.
       , CHILDREN_DED_AGE           -- 자녀양육비 공제 나이.
       , BIRTH_DED_AGE              -- 출생 공제나이.
       , MANY_CHILD_DED_AGE         -- 다자녀추가공제 나이.
       , SIBLING_DED_AGE            -- 형제자매 공제 나이.
       , SIBLING_DED_AGE1           -- 형제자매 공제 나이1.
       , FOSTER_CHILD_DED_AGE       -- 위탁아동 공제 나이.
       , ETC_INSUR_LMT              -- 기타보장성보험.
       , DISABILITY_INSUR_LMT       -- 기타장애자보험.
       , MEDIC_DED_STD              -- 의료비-기준 RATE.
       , MEDIC_DED_LMT              -- 의료비-한도.
       , PER_EDU                    -- 교-본인.
       , DISABILITY_EDU             -- 교-장애.
       , KIND_EDU                   -- 교-취학전아동.
       , STUD_EDU                   -- 교-초중고교.
       , UNIV_EDU                   -- 교-대학교.
       , HOUSE_AMT_RATE             -- 주택마련저축불입액.
       , HOUSE_MONTHLY_STD          -- 월세액기준.
       , HOUSE_MONTHLY_RATE         -- 월세소득공제율.
       , HOUSE_INTER_RATE           -- 주택임차차입금 원리금상환액.
       , HOUSE_AMT_LMT              -- 주택마련주택임차차임금 한도.
       , LONG_HOUSE_PROF_LMT        -- 장기주택저당차입금 이자상환액(10년)
       , HOUSE_TOTAL_LMT            -- 주택자금 총공제한도(10년)
       , LONG_HOUSE_PROF_LMT_1      -- 장기주택저당차입금 이자상환액(15년).
       , HOUSE_TOTAL_LMT_1          -- 주택자금 총공제한도(15년).
       , LONG_HOUSE_PROF_LMT_2      -- 장기주택저당차입금 이자상환액(30년).
       , HOUSE_TOTAL_LMT_2          -- 주택자금 총공제한도(30년).
       , LEGAL_GIFT_RATE            -- 법정기부금.
       , ASS_GIFT_RATE1             -- 특례기부금(50%).
       , ASS_GIFT_RATE2             -- 지정기부금(30%).
       , ASS_GIFT_RATE3             -- 지정기부금(10%).
       , ASS_GIFT_RATE3_1           -- 지정기부금(종교단체).
       , MARRY_DED_STD              -- 혼인 공제기준.
       , MARRY_DED                  -- 혼인 공제액
       , FUNE_DED_STD               -- 장례 공제기준.
       , FUNE_DED                   -- 장례 공제액.
       , MOVE_DED_STD               -- 이사 공제기준.
       , MOVE_DED                   -- 이상 공제액.
       , SP_DED_STD                 -- 표준공제 기준액.
       , SP_DED_AMT                 -- 표준공제금액.
       , PRIV_PENS_RATE             -- 개인 연금.
       , PRIV_PENS_LMT              -- 개인 연금한도.
       , PENS_DED_RATE              -- 연금저축 비율.
       , PENS_DED_LMT               -- 연금저축 한도.
       , RETR_PENS_LMT              -- 퇴직연금 한도.
       , SMALL_CORPOR_DED_LMT       -- 소기업 소득공제 한도.
       , INVEST_RATE1               -- 투자조합출자1(2006년 이전).
       , INVEST_LMT_RATE1           -- 투자조합출자한도1.
       , INVEST_RATE2               -- 투자조합출자2(2007이후).
       , INVEST_LMT_RATE2           -- 투자조합출자한도2.
       , CARD_BAS_RATE              -- 신용카드 최저 사용한도 비율.
       , CARD_DED_RATE              -- 신용카드 공제비율.
       , CARD_DIRECT_RATE           --                                                 
       , CARD_DED_LMT               -- 신용카드 공제한도1.
       , CARD_DED_LMT_RATE          -- 신용카드 공제한도-총급여에 대한 비율.
       , CHECK_CARD_DED_RATE        -- 체크카드 공제비율.
       , CASH_BAS_RATE              -- 현금영수증 최저 사용한도 비율.
       , CASH_DED_RATE              -- 현금영수증 공제비율.
       , CASH_DIRECT_RATE                                                           
       , CASH_DED_LMT               -- 현금영수증 공제한도1.
       , CASH_DED_LMT_RATE          -- 현금영수증 공제한도-총급여에 대한 비율.
       , CARD_ADD_DED_LMT           -- 추가공제한도1.
       , CARDCASH_DED_LMT_RATE      -- 신용카드현금영수증 공제한도-총급여에 대한 비율.
       , STOCK_LMT                  -- 우리사주출자한도.                                       
       , LONG_STOCK_SAVING_RATE_1   -- 장기주식형저축 비율1.
       , LONG_STOCK_SAVING_LMT_1    -- 장기주식형저축 한도1.
       , LONG_STOCK_SAVING_RATE_2   -- 장기주식형저축 비율2.
       , LONG_STOCK_SAVING_LMT_2    -- 장기주식형저축 한도2.
       , LONG_STOCK_SAVING_RATE_3   -- 장기주식형저축 비율3.
       , LONG_STOCK_SAVING_LMT_3    -- 장기주식형저축 한도3.
       , EMPLOYMENT_KEEP_RATE       -- 고용유지중소기업근로자소득공제율.
       , EMPLOYMENT_KEEP_LMT        -- 고용유지중소기업근로자소득공제한도.
       , IN_TAX_BASE                -- 근로소득기본공제금.
       , IN_TAX_STD_A               -- 근로소득세액공제 한도1.
       , IN_TAX_RATE_A              -- 근로소득세액공제 한도 비율1.
       , IN_TAX_STD_B               -- 근로소득세액공제 한도2.
       , IN_TAX_RATE_B              -- 근로소득세액공제 한도 비율2.
       , IN_TAX_BASE_B              -- 근로소득세액공제기본 금액2.
       , IN_TAX_STD_C               -- 근로소득세액공제 한도3.
       , IN_TAX_RATE_C              -- 근로소득세액공제 한도 비율3.
       , IN_TAX_BASE_C              -- 근로소득세액공제기본 금액3.
       , IN_TAX_LMT                 -- 근로소득세액공제 한도.
       , POLI_GIFT_MAX              -- 정치기부금한도.
       , POLI_GIFT_RATE             -- 정치기부금 비율.
       , POLI_GIFT_RATE1            -- 정치기부금 비율1.
       , TAX_ASSO_RATE              -- 납세조합.
       , HOUSE_DEBT_BEN_RATE        -- 주택자금차입금이자세액공제.
       , FOREIGN_TAX_DED            -- 외국납부세액공제.
       , LOCAL_TAX_RATE             -- 소득세 비율.
       , SP_TAX_RATE                -- 농특세 적용 비율.
       , CREATION_DATE 
       , CREATED_BY 
       , LAST_UPDATE_DATE 
       , LAST_UPDATED_BY
       , PRE_YEAR_INCOME_TOT_AMT_LMT
       , LONG_HOUSE_PROF_LMT_3_FIX  
       , HOUSE_TOTAL_LMT_3_FIX      
       , LONG_HOUSE_PROF_LMT_3_ETC  
       , HOUSE_TOTAL_LMT_3_ETC      
       , HOUSE_SAVING_RATE          
       , HOUSE_SAVING_LMT           
       , WORKER_HOUSE_SAVING_RATE   
       , WORKER_HOUSE_SAVING_LMT    
       , LONG_HOUSE_SAVING_RATE     
       , LONG_HOUSE_SAVING_LMT      
       , HOUSE_SAVING_ALL_RATE      
       , HOUSE_SAVING_ALL_LMT       
       , TRAD_MARKET_DED_RATE       
       , CARD_MIN_USE_RATE_1
       , CARD_MIN_USE_RATE_2
       , FOREIGN_WORKER_TAX_DED_RATE
       , SMALL_BUSINESS_TAX_DED_FR  
       , SMALL_BUSINESS_TAX_DED_TO  
       , SMALL_BUSINESS_TAX_DED_RATE
      )
      SELECT W_YEAR_YYYY AS YEAR_YYYY       -- 적용년도.
           , ITS.SOB_ID
           , ITS.ORG_ID
           , ITS.FOREIGN_INCOME_RATE        -- 외국인근로자단일세율.
           , ITS.DRIVE_DED_LMT              -- 자가운전보조금.
           , ITS.RESE_DED_LMT               -- 연구보조비.
           , ITS.REPORTER_DED_AMT           -- 취재수당.
           , ITS.FOREIGN_INCOME_DED_AMT     -- 국외근로소득.
           , ITS.MONTH_PAY_STD              -- 야간근로수당 적용 급여 기준.
           , ITS.OT_DED_LMT                 -- 야간근로수당 한도.
           , ITS.FOOD_DED_LMT               -- 식대한도.
           , ITS.BABY_DED_LMT               -- 보육수당 한도.
           , ITS.INCOME_DED_A               -- 근로소득공제 A.
           , ITS.INCOME_DED_RATE_A          -- 근로소득공제율 A.
           , ITS.INCOME_DED_AMT_A           -- 근로소득공제금액 A.
           , ITS.INCOME_CALCU_BAS_A         -- 근로소득 기본금액 A.
           , ITS.INCOME_DED_B               -- 근로소득공제 B.
           , ITS.INCOME_DED_RATE_B          -- 근로소득공제율 B.
           , ITS.INCOME_DED_AMT_B           -- 근로소득공제금액 B.
           , ITS.INCOME_CALCU_BAS_B         -- 근로소득 기본금액 B.
           , ITS.INCOME_DED_C               -- 근로소득공제 C.
           , ITS.INCOME_DED_RATE_C          -- 근로소득공제율 C.
           , ITS.INCOME_DED_AMT_C           -- 근로소득공제금액 C.
           , ITS.INCOME_CALCU_BAS_C         -- 근로소득 기본금액 C.
           , ITS.INCOME_DED_D               -- 근로소득공제 D.
           , ITS.INCOME_DED_RATE_D          -- 근로소득공제율 D.
           , ITS.INCOME_DED_AMT_D           -- 근로소득공제금액 D.
           , ITS.INCOME_CALCU_BAS_D         -- 근로소득 기본금액 D.
           , ITS.INCOME_DED_LMT             -- 근로소득공제 한도.
           , ITS.INCOME_DED_RATE_LMT        -- 근로소득공제율 한도.
           , ITS.INCOME_DED_AMT_LMT         -- 근로소득공제금액 한도.
           , ITS.INCOME_CALCU_BAS_LMT       -- 근로소득 기본금액 한도.
           , ITS.PERSON_DED_AMT             -- 기본공제-본인.
           , ITS.SPOUSE_DED_AMT             -- 기본공제-배우자.
           , ITS.SUPPORT_DED_AMT            -- 기본공제-부양가족.
           , ITS.OLD_AGED_DED_AMT           -- 추가공제-경로우대1(65~69).
           , ITS.OLD_AGED_DED1_AMT          -- 추가공제-경로우대(70~)
           , ITS.DISABILITY_DED_AMT         -- 추가공제-장애자.
           , ITS.WOMAN_DED_AMT              -- 추가공제-부녀세대.
           , ITS.BRING_CHILD_DED_AMT        -- 추가공제-자녀양육.
           , ITS.BIRTH_DED_AMT              -- 출산/입양.
           , ITS.MANY_CHILD_DED_CNT         -- 다자녀추가-인원기준.
           , ITS.MANY_CHILD_DED_BAS_AMT     -- 다자녀추가-기본금액.
           , ITS.MANY_CHILD_DED_ADD_AMT     -- 다자녀추가-인당금액.
           , ITS.ANCESTOR_MAN_AGE           -- 직계존속 남자 공제나이.
           , ITS.ANCESTOR_WOMAN_AGE         -- 직계존속 여자 공제나이.
           , ITS.DESCENDANT_MAN_AGE         -- 직계비속 남자 공제나이.
           , ITS.DESCENDANT_WOMAN_AGE       -- 직계비속 여자 공제나이.
           , ITS.OLD_DED_AGE                -- 경로우대1.
           , ITS.OLD_DED_AGE1               -- 경로우대2.
           , ITS.CHILDREN_DED_AGE           -- 자녀양육비 공제 나이.
           , ITS.BIRTH_DED_AGE              -- 출생 공제나이.
           , ITS.MANY_CHILD_DED_AGE         -- 다자녀추가공제 나이.
           , ITS.SIBLING_DED_AGE            -- 형제자매 공제 나이.
           , ITS.SIBLING_DED_AGE1           -- 형제자매 공제 나이1.
           , ITS.FOSTER_CHILD_DED_AGE       -- 위탁아동 공제 나이.
           , ITS.ETC_INSUR_LMT              -- 기타보장성보험.
           , ITS.DISABILITY_INSUR_LMT       -- 기타장애자보험.
           , ITS.MEDIC_DED_STD              -- 의료비-기준 RATE.
           , ITS.MEDIC_DED_LMT              -- 의료비-한도.
           , ITS.PER_EDU                    -- 교-본인.
           , ITS.DISABILITY_EDU             -- 교-장애.
           , ITS.KIND_EDU                   -- 교-취학전아동.
           , ITS.STUD_EDU                   -- 교-초중고교.
           , ITS.UNIV_EDU                   -- 교-대학교.
           , ITS.HOUSE_AMT_RATE             -- 주택마련저축불입액.
           , ITS.HOUSE_MONTHLY_STD          -- 월세액기준.
           , ITS.HOUSE_MONTHLY_RATE         -- 월세소득공제율.
           , ITS.HOUSE_INTER_RATE           -- 주택임차차입금 원리금상환액.
           , ITS.HOUSE_AMT_LMT              -- 주택마련주택임차차임금 한도.
           , ITS.LONG_HOUSE_PROF_LMT        -- 장기주택저당차입금 이자상환액(10년)
           , ITS.HOUSE_TOTAL_LMT            -- 주택자금 총공제한도(10년)
           , ITS.LONG_HOUSE_PROF_LMT_1      -- 장기주택저당차입금 이자상환액(15년).
           , ITS.HOUSE_TOTAL_LMT_1          -- 주택자금 총공제한도(15년).
           , ITS.LONG_HOUSE_PROF_LMT_2      -- 장기주택저당차입금 이자상환액(30년).
           , ITS.HOUSE_TOTAL_LMT_2          -- 주택자금 총공제한도(30년).
           , ITS.LEGAL_GIFT_RATE            -- 법정기부금.
           , ITS.ASS_GIFT_RATE1             -- 특례기부금(50%).
           , ITS.ASS_GIFT_RATE2             -- 지정기부금(30%).
           , ITS.ASS_GIFT_RATE3             -- 지정기부금(10%).
           , ITS.ASS_GIFT_RATE3_1           -- 지정기부금(종교단체).
           , ITS.MARRY_DED_STD              -- 혼인 공제기준.
           , ITS.MARRY_DED                  -- 혼인 공제액
           , ITS.FUNE_DED_STD               -- 장례 공제기준.
           , ITS.FUNE_DED                   -- 장례 공제액.
           , ITS.MOVE_DED_STD               -- 이사 공제기준.
           , ITS.MOVE_DED                   -- 이상 공제액.
           , ITS.SP_DED_STD                 -- 표준공제 기준액.
           , ITS.SP_DED_AMT                 -- 표준공제금액.
           , ITS.PRIV_PENS_RATE             -- 개인 연금.
           , ITS.PRIV_PENS_LMT              -- 개인 연금한도.
           , ITS.PENS_DED_RATE              -- 연금저축 비율.
           , ITS.PENS_DED_LMT               -- 연금저축 한도.
           , ITS.RETR_PENS_LMT              -- 퇴직연금 한도.
           , ITS.SMALL_CORPOR_DED_LMT       -- 소기업 소득공제 한도.
           , ITS.INVEST_RATE1               -- 투자조합출자1(2006년 이전).
           , ITS.INVEST_LMT_RATE1           -- 투자조합출자한도1.
           , ITS.INVEST_RATE2               -- 투자조합출자2(2007이후).
           , ITS.INVEST_LMT_RATE2           -- 투자조합출자한도2.
           , ITS.CARD_BAS_RATE              -- 신용카드 최저 사용한도 비율.
           , ITS.CARD_DED_RATE              -- 신용카드 공제비율.
           , ITS.CARD_DIRECT_RATE           --                                                 
           , ITS.CARD_DED_LMT               -- 신용카드 공제한도1.
           , ITS.CARD_DED_LMT_RATE          -- 신용카드 공제한도-총급여에 대한 비율.
           , ITS.CHECK_CARD_DED_RATE        -- 체크카드 공제비율.
           , ITS.CASH_BAS_RATE              -- 현금영수증 최저 사용한도 비율.
           , ITS.CASH_DED_RATE              -- 현금영수증 공제비율.
           , ITS.CASH_DIRECT_RATE                                                           
           , ITS.CASH_DED_LMT               -- 현금영수증 공제한도1.
           , ITS.CASH_DED_LMT_RATE          -- 현금영수증 공제한도-총급여에 대한 비율.
           , ITS.CARD_ADD_DED_LMT           -- 추가공제한도.
           , ITS.CARDCASH_DED_LMT_RATE      -- 신용카드현금영수증 공제한도-총급여에 대한 비율.
           , ITS.STOCK_LMT                  -- 우리사주출자한도.                                       
           , ITS.LONG_STOCK_SAVING_RATE_1   -- 장기주식형저축 비율1.
           , ITS.LONG_STOCK_SAVING_LMT_1    -- 장기주식형저축 한도1.
           , ITS.LONG_STOCK_SAVING_RATE_2   -- 장기주식형저축 비율2.
           , ITS.LONG_STOCK_SAVING_LMT_2    -- 장기주식형저축 한도2.
           , ITS.LONG_STOCK_SAVING_RATE_3   -- 장기주식형저축 비율3.
           , ITS.LONG_STOCK_SAVING_LMT_3    -- 장기주식형저축 한도3.
           , ITS.EMPLOYMENT_KEEP_RATE       -- 고용유지중소기업근로자소득공제율.
           , ITS.EMPLOYMENT_KEEP_LMT        -- 고용유지중소기업근로자소득공제한도.
           , ITS.IN_TAX_BASE                -- 근로소득기본공제금.
           , ITS.IN_TAX_STD_A               -- 근로소득세액공제 한도1.
           , ITS.IN_TAX_RATE_A              -- 근로소득세액공제 한도 비율1.
           , ITS.IN_TAX_STD_B               -- 근로소득세액공제 한도2.
           , ITS.IN_TAX_RATE_B              -- 근로소득세액공제 한도 비율2.
           , ITS.IN_TAX_BASE_B              -- 근로소득세액공제기본 금액2.
           , ITS.IN_TAX_STD_C               -- 근로소득세액공제 한도3.
           , ITS.IN_TAX_RATE_C              -- 근로소득세액공제 한도 비율3.
           , ITS.IN_TAX_BASE_C              -- 근로소득세액공제기본 금액3.
           , ITS.IN_TAX_LMT                 -- 근로소득세액공제 한도.
           , ITS.POLI_GIFT_MAX              -- 정치기부금한도.
           , ITS.POLI_GIFT_RATE             -- 정치기부금 비율.
           , ITS.POLI_GIFT_RATE1            -- 정치기부금 비율1.
           , ITS.TAX_ASSO_RATE              -- 납세조합.
           , ITS.HOUSE_DEBT_BEN_RATE        -- 주택자금차입금이자세액공제.
           , ITS.FOREIGN_TAX_DED            -- 외국납부세액공제.
           , ITS.LOCAL_TAX_RATE             -- 소득세 비율.
           , ITS.SP_TAX_RATE                -- 농특세 적용 비율.
           , V_SYSDATE
           , P_USER_ID
           , V_SYSDATE
           , P_USER_ID
           , NVL(ITS.PRE_YEAR_INCOME_TOT_AMT_LMT, 0)
           , NVL(ITS.LONG_HOUSE_PROF_LMT_3_FIX, 0)
           , NVL(ITS.HOUSE_TOTAL_LMT_3_FIX, 0)
           , NVL(ITS.LONG_HOUSE_PROF_LMT_3_ETC, 0)
           , NVL(ITS.HOUSE_TOTAL_LMT_3_ETC, 0)
           , NVL(ITS.HOUSE_SAVING_RATE, 0)
           , NVL(ITS.HOUSE_SAVING_LMT, 0)
           , NVL(ITS.WORKER_HOUSE_SAVING_RATE, 0)
           , NVL(ITS.WORKER_HOUSE_SAVING_LMT, 0)
           , NVL(ITS.LONG_HOUSE_SAVING_RATE, 0)
           , NVL(ITS.LONG_HOUSE_SAVING_LMT, 0)
           , NVL(ITS.HOUSE_SAVING_ALL_RATE, 0)
           , NVL(ITS.HOUSE_SAVING_ALL_LMT, 0)
           , NVL(ITS.TRAD_MARKET_DED_RATE, 0)
           , NVL(ITS.CARD_MIN_USE_RATE_1, 0)
           , NVL(ITS.CARD_MIN_USE_RATE_2, 0)
           , NVL(ITS.FOREIGN_WORKER_TAX_DED_RATE, 0)
           , NVL(ITS.SMALL_BUSINESS_TAX_DED_FR, 0)
           , NVL(ITS.SMALL_BUSINESS_TAX_DED_TO, 0)
           , NVL(ITS.SMALL_BUSINESS_TAX_DED_RATE, 0)
         FROM HRA_INCOME_TAX_STANDARD ITS
        WHERE ITS.YEAR_YYYY  = V_PRE_YEAR_YYYY
          AND ITS.SOB_ID     = W_SOB_ID
          AND ITS.ORG_ID     = W_ORG_ID
        ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'SDM_10027', NULL);
          
  END COPY_TAX_STANDARD;
  
END HRA_INCOME_TAX_STANDARD_G;
/
