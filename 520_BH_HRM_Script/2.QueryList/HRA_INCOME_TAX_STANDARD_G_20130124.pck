CREATE OR REPLACE PACKAGE HRA_INCOME_TAX_STANDARD_G
AS
----------------------------------------------------------------------------------------- 
-- 1. �⺻ ����, Ư�� ����, ��Ÿ ����, ���װ���(����) ----------- SELECT.
----------------------------------------------------------------------------------------- 
  PROCEDURE SELECT_INCOME_TAX_STANDARD
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

----------------------------------------------------------------------------------------- 
-- 2. �⺻ ����, Ư�� ����, ��Ÿ ����, ���װ���(����) ----------- INSERT.
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
           , P_PRE_YEAR_INCOME_TOT_AMT_LMT  IN HRA_INCOME_TAX_STANDARD.PRE_YEAR_INCOME_TOT_AMT_LMT%TYPE  -- �߰��ٷμ��� ���� ���⵵ �ѱ޿��ѵ�.
           , P_LONG_HOUSE_PROF_LMT_3_FIX    IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_3_FIX%TYPE    -- ��������������Ա� 500����(������).
           , P_HOUSE_TOTAL_LMT_3_FIX        IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_3_FIX%TYPE        -- ��������������Ա� 500����(������ ���ѵ�).
           , P_LONG_HOUSE_PROF_LMT_3_ETC    IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_3_ETC%TYPE    -- ��������������Ա� 500����(��Ÿ). 
           , P_HOUSE_TOTAL_LMT_3_ETC        IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_3_ETC%TYPE        -- ��������������Ա� 500����(��Ÿ ���ѵ�).
           , P_HOUSE_SAVING_RATE            IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_RATE%TYPE            -- ���ø�������(û������)--
           , P_HOUSE_SAVING_LMT             IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_LMT%TYPE             -- ���ø�������(û������) �ѵ� --
           , P_WORKER_HOUSE_SAVING_RATE     IN HRA_INCOME_TAX_STANDARD.WORKER_HOUSE_SAVING_RATE%TYPE     -- �ٷ������ø�������--
           , P_WORKER_HOUSE_SAVING_LMT      IN HRA_INCOME_TAX_STANDARD.WORKER_HOUSE_SAVING_LMT%TYPE      -- �ٷ������ø������� �ѵ� --
           , P_LONG_HOUSE_SAVING_RATE       IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_SAVING_RATE%TYPE       -- ������ø�������--
           , P_LONG_HOUSE_SAVING_LMT        IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_SAVING_LMT%TYPE        -- ������ø������� �ѵ� --
           , P_HOUSE_SAVING_ALL_RATE        IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_ALL_RATE%TYPE        -- ������ø�����������--
           , P_HOUSE_SAVING_ALL_LMT         IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_ALL_LMT%TYPE         -- ������ø����������� �ѵ�--
           , P_TRAD_MARKET_DED_RATE         IN HRA_INCOME_TAX_STANDARD.TRAD_MARKET_DED_RATE%TYPE         -- ������� ��������--
           , P_CARD_MIN_USE_RATE_1          IN HRA_INCOME_TAX_STANDARD.CARD_MIN_USE_RATE_1%TYPE          -- ī����������ѵ�1--
           , P_CARD_MIN_USE_RATE_2          IN HRA_INCOME_TAX_STANDARD.CARD_MIN_USE_RATE_2%TYPE          -- ī����������ѵ�2--
           , P_FOREIGN_WORKER_TAX_DED_RATE  IN HRA_INCOME_TAX_STANDARD.FOREIGN_WORKER_TAX_DED_RATE%TYPE  -- �ܱ��α���� ���װ���--
           , P_SMALL_BUSINESS_TAX_DED_FR    IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_FR%TYPE    -- ���ұ�� ���û�� ���� ����--
           , P_SMALL_BUSINESS_TAX_DED_TO    IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_TO%TYPE    -- ���ұ�� ���û�� ���� ����--
           , P_SMALL_BUSINESS_TAX_DED_RATE  IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_RATE%TYPE  -- ���ұ�� ���û�� ���װ�����-- 
           );
          
  
----------------------------------------------------------------------------------------- 
-- 3. �⺻ ����, Ư�� ����, ��Ÿ ����, ���װ���(����) ----------- UPDATE.
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
           , P_PRE_YEAR_INCOME_TOT_AMT_LMT  IN HRA_INCOME_TAX_STANDARD.PRE_YEAR_INCOME_TOT_AMT_LMT%TYPE  -- �߰��ٷμ��� ���� ���⵵ �ѱ޿��ѵ�.
           , P_LONG_HOUSE_PROF_LMT_3_FIX    IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_3_FIX%TYPE    -- ��������������Ա� 500����(������).
           , P_HOUSE_TOTAL_LMT_3_FIX        IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_3_FIX%TYPE        -- ��������������Ա� 500����(������ ���ѵ�).
           , P_LONG_HOUSE_PROF_LMT_3_ETC    IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_3_ETC%TYPE    -- ��������������Ա� 500����(��Ÿ). 
           , P_HOUSE_TOTAL_LMT_3_ETC        IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_3_ETC%TYPE        -- ��������������Ա� 500����(��Ÿ ���ѵ�).
           , P_HOUSE_SAVING_RATE            IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_RATE%TYPE            -- ���ø�������(û������)--
           , P_HOUSE_SAVING_LMT             IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_LMT%TYPE             -- ���ø�������(û������) �ѵ� --
           , P_WORKER_HOUSE_SAVING_RATE     IN HRA_INCOME_TAX_STANDARD.WORKER_HOUSE_SAVING_RATE%TYPE     -- �ٷ������ø�������--
           , P_WORKER_HOUSE_SAVING_LMT      IN HRA_INCOME_TAX_STANDARD.WORKER_HOUSE_SAVING_LMT%TYPE      -- �ٷ������ø������� �ѵ� --
           , P_LONG_HOUSE_SAVING_RATE       IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_SAVING_RATE%TYPE       -- ������ø�������--
           , P_LONG_HOUSE_SAVING_LMT        IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_SAVING_LMT%TYPE        -- ������ø������� �ѵ� --
           , P_HOUSE_SAVING_ALL_RATE        IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_ALL_RATE%TYPE        -- ������ø�����������--
           , P_HOUSE_SAVING_ALL_LMT         IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_ALL_LMT%TYPE         -- ������ø����������� �ѵ�--
           , P_TRAD_MARKET_DED_RATE         IN HRA_INCOME_TAX_STANDARD.TRAD_MARKET_DED_RATE%TYPE         -- ������� ��������--
           , P_CARD_MIN_USE_RATE_1          IN HRA_INCOME_TAX_STANDARD.CARD_MIN_USE_RATE_1%TYPE          -- ī����������ѵ�1--
           , P_CARD_MIN_USE_RATE_2          IN HRA_INCOME_TAX_STANDARD.CARD_MIN_USE_RATE_2%TYPE          -- ī����������ѵ�2--
           , P_FOREIGN_WORKER_TAX_DED_RATE  IN HRA_INCOME_TAX_STANDARD.FOREIGN_WORKER_TAX_DED_RATE%TYPE  -- �ܱ��α���� ���װ���--
           , P_SMALL_BUSINESS_TAX_DED_FR    IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_FR%TYPE    -- ���ұ�� ���û�� ���� ����--
           , P_SMALL_BUSINESS_TAX_DED_TO    IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_TO%TYPE    -- ���ұ�� ���û�� ���� ����--
           , P_SMALL_BUSINESS_TAX_DED_RATE  IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_RATE%TYPE  -- ���ұ�� ���û�� ���װ�����-- 
           );

----------------------------------------------------------------------------------------- 
-- 4. �⺻ ����, Ư�� ����, ��Ÿ ����, ���װ���(����) ----------- DELETE.
-----------------------------------------------------------------------------------------
  PROCEDURE DELETE_INCOME_TAX_STANDARD
          ( W_YEAR_YYYY   IN HRA_INCOME_TAX_STANDARD.YEAR_YYYY%TYPE
          , W_SOB_ID      IN HRA_INCOME_TAX_STANDARD.SOB_ID%TYPE
          , W_ORG_ID      IN HRA_INCOME_TAX_STANDARD.ORG_ID%TYPE 
          );

----------------------------------------------------------------------------------------- 
-- 5. �ش� �⵵ ���� ���� ���� ���� üũ.
-----------------------------------------------------------------------------------------
  PROCEDURE CHECK_TAX_STANDARD_YN
            ( W_YEAR_YYYY             IN HRA_INCOME_TAX_STANDARD.YEAR_YYYY%TYPE
            , W_SOB_ID                IN HRA_INCOME_TAX_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                IN HRA_INCOME_TAX_STANDARD.ORG_ID%TYPE
            , O_CHECK_YN              OUT VARCHAR2
            );

----------------------------------------------------------------------------------------- 
-- 6. ���⵵ ���� ���� COPY.
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
/* Description  : ����������ذ���
/*
/* Reference by : ����������ذ���
/* Program History : 
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 4-MAR-2011  Lee Sun Hee        Initialize
/******************************************************************************/

----------------------------------------------------------------------------------------- 
--1. �⺻ ����, Ư�� ����, ��Ÿ ����, ���װ���(����) ----------- SELECT.
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
      SELECT ITS.YEAR_YYYY AS YEAR_YYYY     -- ����⵵.
           , ITS.FOREIGN_INCOME_RATE        -- �ܱ��αٷ��ڴ��ϼ���.
           , ITS.DRIVE_DED_LMT              -- �ڰ�����������.
           , ITS.RESE_DED_LMT               -- ����������.
           , ITS.REPORTER_DED_AMT           -- �������.
           , ITS.FOREIGN_INCOME_DED_AMT     -- ���ܱٷμҵ�.
           , ITS.MONTH_PAY_STD              -- �߰��ٷμ��� ���� �޿� ����.
           , ITS.OT_DED_LMT                 -- �߰��ٷμ��� �ѵ�.
           , ITS.FOOD_DED_LMT               -- �Ĵ��ѵ�.
           , ITS.BABY_DED_LMT               -- �������� �ѵ�.
           , ITS.INCOME_DED_A               -- �ٷμҵ���� A.
           , ITS.INCOME_DED_RATE_A          -- �ٷμҵ������ A.
           , ITS.INCOME_DED_AMT_A           -- �ٷμҵ�����ݾ� A.
           , ITS.INCOME_CALCU_BAS_A         -- �ٷμҵ� �⺻�ݾ� A.
           , ITS.INCOME_DED_B               -- �ٷμҵ���� B.
           , ITS.INCOME_DED_RATE_B          -- �ٷμҵ������ B.
           , ITS.INCOME_DED_AMT_B           -- �ٷμҵ�����ݾ� B.
           , ITS.INCOME_CALCU_BAS_B         -- �ٷμҵ� �⺻�ݾ� B.
           , ITS.INCOME_DED_C               -- �ٷμҵ���� C.
           , ITS.INCOME_DED_RATE_C          -- �ٷμҵ������ C.
           , ITS.INCOME_DED_AMT_C           -- �ٷμҵ�����ݾ� C.
           , ITS.INCOME_CALCU_BAS_C         -- �ٷμҵ� �⺻�ݾ� C.
           , ITS.INCOME_DED_D               -- �ٷμҵ���� D.
           , ITS.INCOME_DED_RATE_D          -- �ٷμҵ������ D.
           , ITS.INCOME_DED_AMT_D           -- �ٷμҵ�����ݾ� D.
           , ITS.INCOME_CALCU_BAS_D         -- �ٷμҵ� �⺻�ݾ� D.
           , ITS.INCOME_DED_LMT             -- �ٷμҵ���� �ѵ�.
           , ITS.INCOME_DED_RATE_LMT        -- �ٷμҵ������ �ѵ�.
           , ITS.INCOME_DED_AMT_LMT         -- �ٷμҵ�����ݾ� �ѵ�.
           , ITS.INCOME_CALCU_BAS_LMT       -- �ٷμҵ� �⺻�ݾ� �ѵ�.
           , ITS.PERSON_DED_AMT             -- �⺻����-����.
           , ITS.SPOUSE_DED_AMT             -- �⺻����-�����.
           , ITS.SUPPORT_DED_AMT            -- �⺻����-�ξ簡��.
           , ITS.OLD_AGED_DED_AMT           -- �߰�����-��ο��1(65~69).
           , ITS.OLD_AGED_DED1_AMT          -- �߰�����-��ο��(70~)
           , ITS.DISABILITY_DED_AMT         -- �߰�����-�����.
           , ITS.WOMAN_DED_AMT              -- �߰�����-�γ༼��.
           , ITS.BRING_CHILD_DED_AMT        -- �߰�����-�ڳ����.
           , ITS.BIRTH_DED_AMT              -- ���/�Ծ�.
           , ITS.MANY_CHILD_DED_CNT         -- ���ڳ��߰�-�ο�����.
           , ITS.MANY_CHILD_DED_BAS_AMT     -- ���ڳ��߰�-�⺻�ݾ�.
           , ITS.MANY_CHILD_DED_ADD_AMT     -- ���ڳ��߰�-�δ�ݾ�.
           , ITS.ANCESTOR_MAN_AGE           -- �������� ���� ��������.
           , ITS.ANCESTOR_WOMAN_AGE         -- �������� ���� ��������.
           , ITS.DESCENDANT_MAN_AGE         -- ������ ���� ��������.
           , ITS.DESCENDANT_WOMAN_AGE       -- ������ ���� ��������.
           , ITS.OLD_DED_AGE                -- ��ο��1.
           , ITS.OLD_DED_AGE1               -- ��ο��2.
           , ITS.CHILDREN_DED_AGE           -- �ڳ������ ���� ����.
           , ITS.BIRTH_DED_AGE              -- ��� ��������.
           , ITS.MANY_CHILD_DED_AGE         -- ���ڳ��߰����� ����.
           , ITS.SIBLING_DED_AGE            -- �����ڸ� ���� ����.
           , ITS.SIBLING_DED_AGE1           -- �����ڸ� ���� ����1.
           , ITS.FOSTER_CHILD_DED_AGE       -- ��Ź�Ƶ� ���� ����.
           , ITS.ETC_INSUR_LMT              -- ��Ÿ���强����.
           , ITS.DISABILITY_INSUR_LMT       -- ��Ÿ����ں���.
           , ITS.MEDIC_DED_STD              -- �Ƿ��-���� RATE.
           , ITS.MEDIC_DED_LMT              -- �Ƿ��-�ѵ�.
           , ITS.PER_EDU                    -- ��-����.
           , ITS.DISABILITY_EDU             -- ��-���.
           , ITS.KIND_EDU                   -- ��-�������Ƶ�.
           , ITS.STUD_EDU                   -- ��-���߰�.
           , ITS.UNIV_EDU                   -- ��-���б�.
           , ITS.HOUSE_AMT_RATE             -- ���ø���������Ծ�(��� ����).
           , ITS.HOUSE_MONTHLY_STD          -- �����ױ���.
           , ITS.HOUSE_MONTHLY_RATE         -- �����ҵ������.
           , ITS.HOUSE_INTER_RATE           -- �����������Ա� �����ݻ�ȯ��.
           , ITS.HOUSE_AMT_LMT              -- ���ø��������������ӱ� �ѵ�.
           , ITS.LONG_HOUSE_PROF_LMT        -- ��������������Ա� ���ڻ�ȯ��(10��)
           , ITS.HOUSE_TOTAL_LMT            -- �����ڱ� �Ѱ����ѵ�(10��)
           , ITS.LONG_HOUSE_PROF_LMT_1      -- ��������������Ա� ���ڻ�ȯ��(15��).
           , ITS.HOUSE_TOTAL_LMT_1          -- �����ڱ� �Ѱ����ѵ�(15��).
           , ITS.LONG_HOUSE_PROF_LMT_2      -- ��������������Ա� ���ڻ�ȯ��(30��).
           , ITS.HOUSE_TOTAL_LMT_2          -- �����ڱ� �Ѱ����ѵ�(30��).
           , ITS.LEGAL_GIFT_RATE            -- ������α�.
           , ITS.ASS_GIFT_RATE1             -- Ư�ʱ�α�(50%).
           , ITS.ASS_GIFT_RATE2             -- ������α�(30%).
           , ITS.ASS_GIFT_RATE3             -- ������α�(10%).
           , ITS.ASS_GIFT_RATE3_1           -- ������α�(������ü).
           , ITS.MARRY_DED_STD              -- ȥ�� ��������.
           , ITS.MARRY_DED                  -- ȥ�� ������
           , ITS.FUNE_DED_STD               -- ��� ��������.
           , ITS.FUNE_DED                   -- ��� ������.
           , ITS.MOVE_DED_STD               -- �̻� ��������.
           , ITS.MOVE_DED                   -- �̻� ������.
           , ITS.SP_DED_STD                 -- ǥ�ذ��� ���ؾ�.
           , ITS.SP_DED_AMT                 -- ǥ�ذ����ݾ�.
           , ITS.PRIV_PENS_RATE             -- ���� ����.
           , ITS.PRIV_PENS_LMT              -- ���� �����ѵ�.
           , ITS.PENS_DED_RATE              -- �������� ����.
           , ITS.PENS_DED_LMT               -- �������� �ѵ�.
           , ITS.RETR_PENS_LMT              -- �������� �ѵ�.      
           , ITS.SMALL_CORPOR_DED_LMT       -- �ұ�� �ҵ���� �ѵ�.
           , ITS.INVEST_RATE1               -- ������������1(2006�� ����).
           , ITS.INVEST_LMT_RATE1           -- �������������ѵ�1.
           , ITS.INVEST_RATE2               -- ������������2(2007����).
           , ITS.INVEST_LMT_RATE2           -- �������������ѵ�2.
           , ITS.CARD_BAS_RATE              -- �ſ�ī�� ���� ����ѵ� ����.
           , ITS.CARD_DED_RATE              -- �ſ�ī�� ��������.
           , ITS.CARD_DIRECT_RATE           -- ����ī�� ��������.
           , ITS.CARD_DED_LMT               -- �ſ�ī�� �����ѵ�1.
           , ITS.CARD_DED_LMT_RATE          -- �ſ�ī�� �����ѵ�-�ѱ޿��� ���� ����.
           , ITS.CHECK_CARD_DED_RATE        -- üũī�� ��������.
           , ITS.CASH_BAS_RATE              -- ���ݿ����� ���� ����ѵ� ����.
           , ITS.CASH_DED_RATE              -- ���ݿ����� ��������.
           , ITS.CASH_DIRECT_RATE           
           , ITS.CASH_DED_LMT               -- ���ݿ����� �����ѵ�1.
           , ITS.CASH_DED_LMT_RATE          -- ���ݿ����� �����ѵ�-�ѱ޿��� ���� ����.
           , ITS.CARD_ADD_DED_LMT           -- �߰������ѵ�.
           , ITS.CARDCASH_DED_LMT_RATE      -- �ſ�ī�����ݿ����� �����ѵ�-�ѱ޿��� ���� ����.
           , ITS.STOCK_LMT                  -- �츮���������ѵ�.                                       
           , ITS.LONG_STOCK_SAVING_RATE_1   -- ����ֽ������� ����1.
           , ITS.LONG_STOCK_SAVING_LMT_1    -- ����ֽ������� �ѵ�1.
           , ITS.LONG_STOCK_SAVING_RATE_2   -- ����ֽ������� ����2.
           , ITS.LONG_STOCK_SAVING_LMT_2    -- ����ֽ������� �ѵ�2.
           , ITS.LONG_STOCK_SAVING_RATE_3   -- ����ֽ������� ����3.
           , ITS.LONG_STOCK_SAVING_LMT_3    -- ����ֽ������� �ѵ�3.
           , ITS.EMPLOYMENT_KEEP_RATE       -- ��������߼ұ���ٷ��ڼҵ������.
           , ITS.EMPLOYMENT_KEEP_LMT        -- ��������߼ұ���ٷ��ڼҵ�����ѵ�.
           , ITS.IN_TAX_BASE                -- �ٷμҵ�⺻������.
           , ITS.IN_TAX_STD_A               -- �ٷμҵ漼�װ��� �ѵ�1.
           , ITS.IN_TAX_RATE_A              -- �ٷμҵ漼�װ��� �ѵ� ����1.
           , ITS.IN_TAX_STD_B               -- �ٷμҵ漼�װ��� �ѵ�2.
           , ITS.IN_TAX_RATE_B              -- �ٷμҵ漼�װ��� �ѵ� ����2.
           , ITS.IN_TAX_BASE_B              -- �ٷμҵ漼�װ����⺻ �ݾ�2.
           , ITS.IN_TAX_STD_C               -- �ٷμҵ漼�װ��� �ѵ�3.
           , ITS.IN_TAX_RATE_C              -- �ٷμҵ漼�װ��� �ѵ� ����3.
           , ITS.IN_TAX_BASE_C              -- �ٷμҵ漼�װ����⺻ �ݾ�3.
           , ITS.IN_TAX_LMT                 -- �ٷμҵ漼�װ��� �ѵ�.
           , ITS.POLI_GIFT_MAX              -- ��ġ��α��ѵ�.
           , ITS.POLI_GIFT_RATE             -- ��ġ��α� ����.
           , ITS.POLI_GIFT_RATE1            -- ��ġ��α� ����1.
           , ITS.TAX_ASSO_RATE              -- ��������.
           , ITS.HOUSE_DEBT_BEN_RATE        -- �����ڱ����Ա����ڼ��װ���.
           , ITS.FOREIGN_TAX_DED            -- �ܱ����μ��װ���.
           , ITS.LOCAL_TAX_RATE             -- �ҵ漼 ����.
           , ITS.SP_TAX_RATE                -- ��Ư�� ���� ����.
           -- ��ȣ��(2013.01.17) : 2012�⵵ �������� �߰� --
           , ITS.PRE_YEAR_INCOME_TOT_AMT_LMT-- �߰��ٷμ��� ���� ���⵵ �ѱ޿��ѵ�.
           , ITS.LONG_HOUSE_PROF_LMT_3_FIX  -- ��������������Ա� 500����(������).
           , ITS.HOUSE_TOTAL_LMT_3_FIX      -- ��������������Ա� 500����(������ ���ѵ�).
           , ITS.LONG_HOUSE_PROF_LMT_3_ETC  -- ��������������Ա� 500����(��Ÿ). 
           , ITS.HOUSE_TOTAL_LMT_3_ETC      -- ��������������Ա� 500����(��Ÿ ���ѵ�).
           , ITS.HOUSE_SAVING_RATE          -- ���ø�������(û������)--
           , ITS.HOUSE_SAVING_LMT           -- ���ø�������(û������) �ѵ� --
           , ITS.WORKER_HOUSE_SAVING_RATE   -- �ٷ������ø�������--
           , ITS.WORKER_HOUSE_SAVING_LMT    -- �ٷ������ø������� �ѵ� --
           , ITS.LONG_HOUSE_SAVING_RATE     -- ������ø�������--
           , ITS.LONG_HOUSE_SAVING_LMT      -- ������ø������� �ѵ� --
           , ITS.HOUSE_SAVING_ALL_RATE      -- ������ø�����������--
           , ITS.HOUSE_SAVING_ALL_LMT       -- ������ø����������� �ѵ�--
           , ITS.TRAD_MARKET_DED_RATE       -- ������� ��������--
           , ITS.CARD_MIN_USE_RATE_1        -- ī�� �������ݾ� �ѵ�1--
           , ITS.CARD_MIN_USE_RATE_2        -- ī�� �������ݾ� �ѵ�2--
           , ITS.FOREIGN_WORKER_TAX_DED_RATE-- �ܱ��α���� ���װ���--
           , ITS.SMALL_BUSINESS_TAX_DED_FR  -- ���ұ�� ���û�� ���� ����--
           , ITS.SMALL_BUSINESS_TAX_DED_TO  -- ���ұ�� ���û�� ���� ����--
           , ITS.SMALL_BUSINESS_TAX_DED_RATE-- ���ұ�� ���û�� ���װ�����-- 
        FROM HRA_INCOME_TAX_STANDARD ITS
      WHERE ITS.YEAR_YYYY  = P_YEAR_YYYY
        AND ITS.SOB_ID     = P_SOB_ID
        AND ITS.ORG_ID     = P_ORG_ID
      ;
  END SELECT_INCOME_TAX_STANDARD;
  
----------------------------------------------------------------------------------------- 
-- 2. �⺻ ����, Ư�� ����, ��Ÿ ����, ���װ���(����) ----------- INSERT.
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
           , P_PRE_YEAR_INCOME_TOT_AMT_LMT  IN HRA_INCOME_TAX_STANDARD.PRE_YEAR_INCOME_TOT_AMT_LMT%TYPE  -- �߰��ٷμ��� ���� ���⵵ �ѱ޿��ѵ�.
           , P_LONG_HOUSE_PROF_LMT_3_FIX    IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_3_FIX%TYPE    -- ��������������Ա� 500����(������).
           , P_HOUSE_TOTAL_LMT_3_FIX        IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_3_FIX%TYPE        -- ��������������Ա� 500����(������ ���ѵ�).
           , P_LONG_HOUSE_PROF_LMT_3_ETC    IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_3_ETC%TYPE    -- ��������������Ա� 500����(��Ÿ). 
           , P_HOUSE_TOTAL_LMT_3_ETC        IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_3_ETC%TYPE        -- ��������������Ա� 500����(��Ÿ ���ѵ�).
           , P_HOUSE_SAVING_RATE            IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_RATE%TYPE            -- ���ø�������(û������)--
           , P_HOUSE_SAVING_LMT             IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_LMT%TYPE             -- ���ø�������(û������) �ѵ� --
           , P_WORKER_HOUSE_SAVING_RATE     IN HRA_INCOME_TAX_STANDARD.WORKER_HOUSE_SAVING_RATE%TYPE     -- �ٷ������ø�������--
           , P_WORKER_HOUSE_SAVING_LMT      IN HRA_INCOME_TAX_STANDARD.WORKER_HOUSE_SAVING_LMT%TYPE      -- �ٷ������ø������� �ѵ� --
           , P_LONG_HOUSE_SAVING_RATE       IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_SAVING_RATE%TYPE       -- ������ø�������--
           , P_LONG_HOUSE_SAVING_LMT        IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_SAVING_LMT%TYPE        -- ������ø������� �ѵ� --
           , P_HOUSE_SAVING_ALL_RATE        IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_ALL_RATE%TYPE        -- ������ø�����������--
           , P_HOUSE_SAVING_ALL_LMT         IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_ALL_LMT%TYPE         -- ������ø����������� �ѵ�--
           , P_TRAD_MARKET_DED_RATE         IN HRA_INCOME_TAX_STANDARD.TRAD_MARKET_DED_RATE%TYPE         -- ������� ��������--
           , P_CARD_MIN_USE_RATE_1          IN HRA_INCOME_TAX_STANDARD.CARD_MIN_USE_RATE_1%TYPE          -- ī����������ѵ�1--
           , P_CARD_MIN_USE_RATE_2          IN HRA_INCOME_TAX_STANDARD.CARD_MIN_USE_RATE_2%TYPE          -- ī����������ѵ�2--
           , P_FOREIGN_WORKER_TAX_DED_RATE  IN HRA_INCOME_TAX_STANDARD.FOREIGN_WORKER_TAX_DED_RATE%TYPE  -- �ܱ��α���� ���װ���--
           , P_SMALL_BUSINESS_TAX_DED_FR    IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_FR%TYPE    -- ���ұ�� ���û�� ���� ����--
           , P_SMALL_BUSINESS_TAX_DED_TO    IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_TO%TYPE    -- ���ұ�� ���û�� ���� ����--
           , P_SMALL_BUSINESS_TAX_DED_RATE  IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_RATE%TYPE  -- ���ұ�� ���û�� ���װ�����-- 
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
-- 3. �⺻ ����, Ư�� ����, ��Ÿ ����, ���װ���(����) ----------- UPDATE.
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
           , P_PRE_YEAR_INCOME_TOT_AMT_LMT  IN HRA_INCOME_TAX_STANDARD.PRE_YEAR_INCOME_TOT_AMT_LMT%TYPE  -- �߰��ٷμ��� ���� ���⵵ �ѱ޿��ѵ�.
           , P_LONG_HOUSE_PROF_LMT_3_FIX    IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_3_FIX%TYPE    -- ��������������Ա� 500����(������).
           , P_HOUSE_TOTAL_LMT_3_FIX        IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_3_FIX%TYPE        -- ��������������Ա� 500����(������ ���ѵ�).
           , P_LONG_HOUSE_PROF_LMT_3_ETC    IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_PROF_LMT_3_ETC%TYPE    -- ��������������Ա� 500����(��Ÿ). 
           , P_HOUSE_TOTAL_LMT_3_ETC        IN HRA_INCOME_TAX_STANDARD.HOUSE_TOTAL_LMT_3_ETC%TYPE        -- ��������������Ա� 500����(��Ÿ ���ѵ�).
           , P_HOUSE_SAVING_RATE            IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_RATE%TYPE            -- ���ø�������(û������)--
           , P_HOUSE_SAVING_LMT             IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_LMT%TYPE             -- ���ø�������(û������) �ѵ� --
           , P_WORKER_HOUSE_SAVING_RATE     IN HRA_INCOME_TAX_STANDARD.WORKER_HOUSE_SAVING_RATE%TYPE     -- �ٷ������ø�������--
           , P_WORKER_HOUSE_SAVING_LMT      IN HRA_INCOME_TAX_STANDARD.WORKER_HOUSE_SAVING_LMT%TYPE      -- �ٷ������ø������� �ѵ� --
           , P_LONG_HOUSE_SAVING_RATE       IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_SAVING_RATE%TYPE       -- ������ø�������--
           , P_LONG_HOUSE_SAVING_LMT        IN HRA_INCOME_TAX_STANDARD.LONG_HOUSE_SAVING_LMT%TYPE        -- ������ø������� �ѵ� --
           , P_HOUSE_SAVING_ALL_RATE        IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_ALL_RATE%TYPE        -- ������ø�����������--
           , P_HOUSE_SAVING_ALL_LMT         IN HRA_INCOME_TAX_STANDARD.HOUSE_SAVING_ALL_LMT%TYPE         -- ������ø����������� �ѵ�--
           , P_TRAD_MARKET_DED_RATE         IN HRA_INCOME_TAX_STANDARD.TRAD_MARKET_DED_RATE%TYPE         -- ������� ��������--
           , P_CARD_MIN_USE_RATE_1          IN HRA_INCOME_TAX_STANDARD.CARD_MIN_USE_RATE_1%TYPE          -- ī����������ѵ�1--
           , P_CARD_MIN_USE_RATE_2          IN HRA_INCOME_TAX_STANDARD.CARD_MIN_USE_RATE_2%TYPE          -- ī����������ѵ�2--
           , P_FOREIGN_WORKER_TAX_DED_RATE  IN HRA_INCOME_TAX_STANDARD.FOREIGN_WORKER_TAX_DED_RATE%TYPE  -- �ܱ��α���� ���װ���--
           , P_SMALL_BUSINESS_TAX_DED_FR    IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_FR%TYPE    -- ���ұ�� ���û�� ���� ����--
           , P_SMALL_BUSINESS_TAX_DED_TO    IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_TO%TYPE    -- ���ұ�� ���û�� ���� ����--
           , P_SMALL_BUSINESS_TAX_DED_RATE  IN HRA_INCOME_TAX_STANDARD.SMALL_BUSINESS_TAX_DED_RATE%TYPE  -- ���ұ�� ���û�� ���װ�����-- 
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
-- 4. �⺻ ����, Ư�� ����, ��Ÿ ����, ���װ���(����) ----------- DELETE.
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
-- 5. �ش� �⵵ ���� ���� ���� ���� üũ.     [�� �⵵ ���� ��ư�� ���]
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
-- 6. ���⵵ ���� ���� COPY.                 [�� �⵵ ���� ��ư�� ���]
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
    
    -- ������ ����.
    DELETE HRA_INCOME_TAX_STANDARD ITS
    WHERE ITS.YEAR_YYYY   = W_YEAR_YYYY
      AND ITS.SOB_ID      = W_SOB_ID
      AND ITS.ORG_ID      = W_ORG_ID
      ;
      
    BEGIN
      INSERT INTO HRA_INCOME_TAX_STANDARD
      (  YEAR_YYYY                  -- ����⵵.
       , SOB_ID
       , ORG_ID
       , FOREIGN_INCOME_RATE        -- �ܱ��αٷ��ڴ��ϼ���.
       , DRIVE_DED_LMT              -- �ڰ�����������.
       , RESE_DED_LMT               -- ����������.
       , REPORTER_DED_AMT           -- �������.
       , FOREIGN_INCOME_DED_AMT     -- ���ܱٷμҵ�.
       , MONTH_PAY_STD              -- �߰��ٷμ��� ���� �޿� ����.
       , OT_DED_LMT                 -- �߰��ٷμ��� �ѵ�.
       , FOOD_DED_LMT               -- �Ĵ��ѵ�.
       , BABY_DED_LMT               -- �������� �ѵ�.
       , INCOME_DED_A               -- �ٷμҵ���� A.
       , INCOME_DED_RATE_A          -- �ٷμҵ������ A.
       , INCOME_DED_AMT_A           -- �ٷμҵ�����ݾ� A.
       , INCOME_CALCU_BAS_A         -- �ٷμҵ� �⺻�ݾ� A.
       , INCOME_DED_B               -- �ٷμҵ���� B.
       , INCOME_DED_RATE_B          -- �ٷμҵ������ B.
       , INCOME_DED_AMT_B           -- �ٷμҵ�����ݾ� B.
       , INCOME_CALCU_BAS_B         -- �ٷμҵ� �⺻�ݾ� B.
       , INCOME_DED_C               -- �ٷμҵ���� C.
       , INCOME_DED_RATE_C          -- �ٷμҵ������ C.
       , INCOME_DED_AMT_C           -- �ٷμҵ�����ݾ� C.
       , INCOME_CALCU_BAS_C         -- �ٷμҵ� �⺻�ݾ� C.
       , INCOME_DED_D               -- �ٷμҵ���� D.
       , INCOME_DED_RATE_D          -- �ٷμҵ������ D.
       , INCOME_DED_AMT_D           -- �ٷμҵ�����ݾ� D.
       , INCOME_CALCU_BAS_D         -- �ٷμҵ� �⺻�ݾ� D.
       , INCOME_DED_LMT             -- �ٷμҵ���� �ѵ�.
       , INCOME_DED_RATE_LMT        -- �ٷμҵ������ �ѵ�.
       , INCOME_DED_AMT_LMT         -- �ٷμҵ�����ݾ� �ѵ�.
       , INCOME_CALCU_BAS_LMT       -- �ٷμҵ� �⺻�ݾ� �ѵ�.
       , PERSON_DED_AMT             -- �⺻����-����.
       , SPOUSE_DED_AMT             -- �⺻����-�����.
       , SUPPORT_DED_AMT            -- �⺻����-�ξ簡��.
       , OLD_AGED_DED_AMT           -- �߰�����-��ο��1(65~69).
       , OLD_AGED_DED1_AMT          -- �߰�����-��ο��(70~)
       , DISABILITY_DED_AMT         -- �߰�����-�����.
       , WOMAN_DED_AMT              -- �߰�����-�γ༼��.
       , BRING_CHILD_DED_AMT        -- �߰�����-�ڳ����.
       , BIRTH_DED_AMT              -- ���/�Ծ�.
       , MANY_CHILD_DED_CNT         -- ���ڳ��߰�-�ο�����.
       , MANY_CHILD_DED_BAS_AMT     -- ���ڳ��߰�-�⺻�ݾ�.
       , MANY_CHILD_DED_ADD_AMT     -- ���ڳ��߰�-�δ�ݾ�.
       , ANCESTOR_MAN_AGE           -- �������� ���� ��������.
       , ANCESTOR_WOMAN_AGE         -- �������� ���� ��������.
       , DESCENDANT_MAN_AGE         -- ������ ���� ��������.
       , DESCENDANT_WOMAN_AGE       -- ������ ���� ��������.
       , OLD_DED_AGE                -- ��ο��1.
       , OLD_DED_AGE1               -- ��ο��2.
       , CHILDREN_DED_AGE           -- �ڳ������ ���� ����.
       , BIRTH_DED_AGE              -- ��� ��������.
       , MANY_CHILD_DED_AGE         -- ���ڳ��߰����� ����.
       , SIBLING_DED_AGE            -- �����ڸ� ���� ����.
       , SIBLING_DED_AGE1           -- �����ڸ� ���� ����1.
       , FOSTER_CHILD_DED_AGE       -- ��Ź�Ƶ� ���� ����.
       , ETC_INSUR_LMT              -- ��Ÿ���强����.
       , DISABILITY_INSUR_LMT       -- ��Ÿ����ں���.
       , MEDIC_DED_STD              -- �Ƿ��-���� RATE.
       , MEDIC_DED_LMT              -- �Ƿ��-�ѵ�.
       , PER_EDU                    -- ��-����.
       , DISABILITY_EDU             -- ��-���.
       , KIND_EDU                   -- ��-�������Ƶ�.
       , STUD_EDU                   -- ��-���߰�.
       , UNIV_EDU                   -- ��-���б�.
       , HOUSE_AMT_RATE             -- ���ø���������Ծ�.
       , HOUSE_MONTHLY_STD          -- �����ױ���.
       , HOUSE_MONTHLY_RATE         -- �����ҵ������.
       , HOUSE_INTER_RATE           -- �����������Ա� �����ݻ�ȯ��.
       , HOUSE_AMT_LMT              -- ���ø��������������ӱ� �ѵ�.
       , LONG_HOUSE_PROF_LMT        -- ��������������Ա� ���ڻ�ȯ��(10��)
       , HOUSE_TOTAL_LMT            -- �����ڱ� �Ѱ����ѵ�(10��)
       , LONG_HOUSE_PROF_LMT_1      -- ��������������Ա� ���ڻ�ȯ��(15��).
       , HOUSE_TOTAL_LMT_1          -- �����ڱ� �Ѱ����ѵ�(15��).
       , LONG_HOUSE_PROF_LMT_2      -- ��������������Ա� ���ڻ�ȯ��(30��).
       , HOUSE_TOTAL_LMT_2          -- �����ڱ� �Ѱ����ѵ�(30��).
       , LEGAL_GIFT_RATE            -- ������α�.
       , ASS_GIFT_RATE1             -- Ư�ʱ�α�(50%).
       , ASS_GIFT_RATE2             -- ������α�(30%).
       , ASS_GIFT_RATE3             -- ������α�(10%).
       , ASS_GIFT_RATE3_1           -- ������α�(������ü).
       , MARRY_DED_STD              -- ȥ�� ��������.
       , MARRY_DED                  -- ȥ�� ������
       , FUNE_DED_STD               -- ��� ��������.
       , FUNE_DED                   -- ��� ������.
       , MOVE_DED_STD               -- �̻� ��������.
       , MOVE_DED                   -- �̻� ������.
       , SP_DED_STD                 -- ǥ�ذ��� ���ؾ�.
       , SP_DED_AMT                 -- ǥ�ذ����ݾ�.
       , PRIV_PENS_RATE             -- ���� ����.
       , PRIV_PENS_LMT              -- ���� �����ѵ�.
       , PENS_DED_RATE              -- �������� ����.
       , PENS_DED_LMT               -- �������� �ѵ�.
       , RETR_PENS_LMT              -- �������� �ѵ�.
       , SMALL_CORPOR_DED_LMT       -- �ұ�� �ҵ���� �ѵ�.
       , INVEST_RATE1               -- ������������1(2006�� ����).
       , INVEST_LMT_RATE1           -- �������������ѵ�1.
       , INVEST_RATE2               -- ������������2(2007����).
       , INVEST_LMT_RATE2           -- �������������ѵ�2.
       , CARD_BAS_RATE              -- �ſ�ī�� ���� ����ѵ� ����.
       , CARD_DED_RATE              -- �ſ�ī�� ��������.
       , CARD_DIRECT_RATE           --                                                 
       , CARD_DED_LMT               -- �ſ�ī�� �����ѵ�1.
       , CARD_DED_LMT_RATE          -- �ſ�ī�� �����ѵ�-�ѱ޿��� ���� ����.
       , CHECK_CARD_DED_RATE        -- üũī�� ��������.
       , CASH_BAS_RATE              -- ���ݿ����� ���� ����ѵ� ����.
       , CASH_DED_RATE              -- ���ݿ����� ��������.
       , CASH_DIRECT_RATE                                                           
       , CASH_DED_LMT               -- ���ݿ����� �����ѵ�1.
       , CASH_DED_LMT_RATE          -- ���ݿ����� �����ѵ�-�ѱ޿��� ���� ����.
       , CARD_ADD_DED_LMT           -- �߰������ѵ�1.
       , CARDCASH_DED_LMT_RATE      -- �ſ�ī�����ݿ����� �����ѵ�-�ѱ޿��� ���� ����.
       , STOCK_LMT                  -- �츮���������ѵ�.                                       
       , LONG_STOCK_SAVING_RATE_1   -- ����ֽ������� ����1.
       , LONG_STOCK_SAVING_LMT_1    -- ����ֽ������� �ѵ�1.
       , LONG_STOCK_SAVING_RATE_2   -- ����ֽ������� ����2.
       , LONG_STOCK_SAVING_LMT_2    -- ����ֽ������� �ѵ�2.
       , LONG_STOCK_SAVING_RATE_3   -- ����ֽ������� ����3.
       , LONG_STOCK_SAVING_LMT_3    -- ����ֽ������� �ѵ�3.
       , EMPLOYMENT_KEEP_RATE       -- ��������߼ұ���ٷ��ڼҵ������.
       , EMPLOYMENT_KEEP_LMT        -- ��������߼ұ���ٷ��ڼҵ�����ѵ�.
       , IN_TAX_BASE                -- �ٷμҵ�⺻������.
       , IN_TAX_STD_A               -- �ٷμҵ漼�װ��� �ѵ�1.
       , IN_TAX_RATE_A              -- �ٷμҵ漼�װ��� �ѵ� ����1.
       , IN_TAX_STD_B               -- �ٷμҵ漼�װ��� �ѵ�2.
       , IN_TAX_RATE_B              -- �ٷμҵ漼�װ��� �ѵ� ����2.
       , IN_TAX_BASE_B              -- �ٷμҵ漼�װ����⺻ �ݾ�2.
       , IN_TAX_STD_C               -- �ٷμҵ漼�װ��� �ѵ�3.
       , IN_TAX_RATE_C              -- �ٷμҵ漼�װ��� �ѵ� ����3.
       , IN_TAX_BASE_C              -- �ٷμҵ漼�װ����⺻ �ݾ�3.
       , IN_TAX_LMT                 -- �ٷμҵ漼�װ��� �ѵ�.
       , POLI_GIFT_MAX              -- ��ġ��α��ѵ�.
       , POLI_GIFT_RATE             -- ��ġ��α� ����.
       , POLI_GIFT_RATE1            -- ��ġ��α� ����1.
       , TAX_ASSO_RATE              -- ��������.
       , HOUSE_DEBT_BEN_RATE        -- �����ڱ����Ա����ڼ��װ���.
       , FOREIGN_TAX_DED            -- �ܱ����μ��װ���.
       , LOCAL_TAX_RATE             -- �ҵ漼 ����.
       , SP_TAX_RATE                -- ��Ư�� ���� ����.
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
      SELECT W_YEAR_YYYY AS YEAR_YYYY       -- ����⵵.
           , ITS.SOB_ID
           , ITS.ORG_ID
           , ITS.FOREIGN_INCOME_RATE        -- �ܱ��αٷ��ڴ��ϼ���.
           , ITS.DRIVE_DED_LMT              -- �ڰ�����������.
           , ITS.RESE_DED_LMT               -- ����������.
           , ITS.REPORTER_DED_AMT           -- �������.
           , ITS.FOREIGN_INCOME_DED_AMT     -- ���ܱٷμҵ�.
           , ITS.MONTH_PAY_STD              -- �߰��ٷμ��� ���� �޿� ����.
           , ITS.OT_DED_LMT                 -- �߰��ٷμ��� �ѵ�.
           , ITS.FOOD_DED_LMT               -- �Ĵ��ѵ�.
           , ITS.BABY_DED_LMT               -- �������� �ѵ�.
           , ITS.INCOME_DED_A               -- �ٷμҵ���� A.
           , ITS.INCOME_DED_RATE_A          -- �ٷμҵ������ A.
           , ITS.INCOME_DED_AMT_A           -- �ٷμҵ�����ݾ� A.
           , ITS.INCOME_CALCU_BAS_A         -- �ٷμҵ� �⺻�ݾ� A.
           , ITS.INCOME_DED_B               -- �ٷμҵ���� B.
           , ITS.INCOME_DED_RATE_B          -- �ٷμҵ������ B.
           , ITS.INCOME_DED_AMT_B           -- �ٷμҵ�����ݾ� B.
           , ITS.INCOME_CALCU_BAS_B         -- �ٷμҵ� �⺻�ݾ� B.
           , ITS.INCOME_DED_C               -- �ٷμҵ���� C.
           , ITS.INCOME_DED_RATE_C          -- �ٷμҵ������ C.
           , ITS.INCOME_DED_AMT_C           -- �ٷμҵ�����ݾ� C.
           , ITS.INCOME_CALCU_BAS_C         -- �ٷμҵ� �⺻�ݾ� C.
           , ITS.INCOME_DED_D               -- �ٷμҵ���� D.
           , ITS.INCOME_DED_RATE_D          -- �ٷμҵ������ D.
           , ITS.INCOME_DED_AMT_D           -- �ٷμҵ�����ݾ� D.
           , ITS.INCOME_CALCU_BAS_D         -- �ٷμҵ� �⺻�ݾ� D.
           , ITS.INCOME_DED_LMT             -- �ٷμҵ���� �ѵ�.
           , ITS.INCOME_DED_RATE_LMT        -- �ٷμҵ������ �ѵ�.
           , ITS.INCOME_DED_AMT_LMT         -- �ٷμҵ�����ݾ� �ѵ�.
           , ITS.INCOME_CALCU_BAS_LMT       -- �ٷμҵ� �⺻�ݾ� �ѵ�.
           , ITS.PERSON_DED_AMT             -- �⺻����-����.
           , ITS.SPOUSE_DED_AMT             -- �⺻����-�����.
           , ITS.SUPPORT_DED_AMT            -- �⺻����-�ξ簡��.
           , ITS.OLD_AGED_DED_AMT           -- �߰�����-��ο��1(65~69).
           , ITS.OLD_AGED_DED1_AMT          -- �߰�����-��ο��(70~)
           , ITS.DISABILITY_DED_AMT         -- �߰�����-�����.
           , ITS.WOMAN_DED_AMT              -- �߰�����-�γ༼��.
           , ITS.BRING_CHILD_DED_AMT        -- �߰�����-�ڳ����.
           , ITS.BIRTH_DED_AMT              -- ���/�Ծ�.
           , ITS.MANY_CHILD_DED_CNT         -- ���ڳ��߰�-�ο�����.
           , ITS.MANY_CHILD_DED_BAS_AMT     -- ���ڳ��߰�-�⺻�ݾ�.
           , ITS.MANY_CHILD_DED_ADD_AMT     -- ���ڳ��߰�-�δ�ݾ�.
           , ITS.ANCESTOR_MAN_AGE           -- �������� ���� ��������.
           , ITS.ANCESTOR_WOMAN_AGE         -- �������� ���� ��������.
           , ITS.DESCENDANT_MAN_AGE         -- ������ ���� ��������.
           , ITS.DESCENDANT_WOMAN_AGE       -- ������ ���� ��������.
           , ITS.OLD_DED_AGE                -- ��ο��1.
           , ITS.OLD_DED_AGE1               -- ��ο��2.
           , ITS.CHILDREN_DED_AGE           -- �ڳ������ ���� ����.
           , ITS.BIRTH_DED_AGE              -- ��� ��������.
           , ITS.MANY_CHILD_DED_AGE         -- ���ڳ��߰����� ����.
           , ITS.SIBLING_DED_AGE            -- �����ڸ� ���� ����.
           , ITS.SIBLING_DED_AGE1           -- �����ڸ� ���� ����1.
           , ITS.FOSTER_CHILD_DED_AGE       -- ��Ź�Ƶ� ���� ����.
           , ITS.ETC_INSUR_LMT              -- ��Ÿ���强����.
           , ITS.DISABILITY_INSUR_LMT       -- ��Ÿ����ں���.
           , ITS.MEDIC_DED_STD              -- �Ƿ��-���� RATE.
           , ITS.MEDIC_DED_LMT              -- �Ƿ��-�ѵ�.
           , ITS.PER_EDU                    -- ��-����.
           , ITS.DISABILITY_EDU             -- ��-���.
           , ITS.KIND_EDU                   -- ��-�������Ƶ�.
           , ITS.STUD_EDU                   -- ��-���߰�.
           , ITS.UNIV_EDU                   -- ��-���б�.
           , ITS.HOUSE_AMT_RATE             -- ���ø���������Ծ�.
           , ITS.HOUSE_MONTHLY_STD          -- �����ױ���.
           , ITS.HOUSE_MONTHLY_RATE         -- �����ҵ������.
           , ITS.HOUSE_INTER_RATE           -- �����������Ա� �����ݻ�ȯ��.
           , ITS.HOUSE_AMT_LMT              -- ���ø��������������ӱ� �ѵ�.
           , ITS.LONG_HOUSE_PROF_LMT        -- ��������������Ա� ���ڻ�ȯ��(10��)
           , ITS.HOUSE_TOTAL_LMT            -- �����ڱ� �Ѱ����ѵ�(10��)
           , ITS.LONG_HOUSE_PROF_LMT_1      -- ��������������Ա� ���ڻ�ȯ��(15��).
           , ITS.HOUSE_TOTAL_LMT_1          -- �����ڱ� �Ѱ����ѵ�(15��).
           , ITS.LONG_HOUSE_PROF_LMT_2      -- ��������������Ա� ���ڻ�ȯ��(30��).
           , ITS.HOUSE_TOTAL_LMT_2          -- �����ڱ� �Ѱ����ѵ�(30��).
           , ITS.LEGAL_GIFT_RATE            -- ������α�.
           , ITS.ASS_GIFT_RATE1             -- Ư�ʱ�α�(50%).
           , ITS.ASS_GIFT_RATE2             -- ������α�(30%).
           , ITS.ASS_GIFT_RATE3             -- ������α�(10%).
           , ITS.ASS_GIFT_RATE3_1           -- ������α�(������ü).
           , ITS.MARRY_DED_STD              -- ȥ�� ��������.
           , ITS.MARRY_DED                  -- ȥ�� ������
           , ITS.FUNE_DED_STD               -- ��� ��������.
           , ITS.FUNE_DED                   -- ��� ������.
           , ITS.MOVE_DED_STD               -- �̻� ��������.
           , ITS.MOVE_DED                   -- �̻� ������.
           , ITS.SP_DED_STD                 -- ǥ�ذ��� ���ؾ�.
           , ITS.SP_DED_AMT                 -- ǥ�ذ����ݾ�.
           , ITS.PRIV_PENS_RATE             -- ���� ����.
           , ITS.PRIV_PENS_LMT              -- ���� �����ѵ�.
           , ITS.PENS_DED_RATE              -- �������� ����.
           , ITS.PENS_DED_LMT               -- �������� �ѵ�.
           , ITS.RETR_PENS_LMT              -- �������� �ѵ�.
           , ITS.SMALL_CORPOR_DED_LMT       -- �ұ�� �ҵ���� �ѵ�.
           , ITS.INVEST_RATE1               -- ������������1(2006�� ����).
           , ITS.INVEST_LMT_RATE1           -- �������������ѵ�1.
           , ITS.INVEST_RATE2               -- ������������2(2007����).
           , ITS.INVEST_LMT_RATE2           -- �������������ѵ�2.
           , ITS.CARD_BAS_RATE              -- �ſ�ī�� ���� ����ѵ� ����.
           , ITS.CARD_DED_RATE              -- �ſ�ī�� ��������.
           , ITS.CARD_DIRECT_RATE           --                                                 
           , ITS.CARD_DED_LMT               -- �ſ�ī�� �����ѵ�1.
           , ITS.CARD_DED_LMT_RATE          -- �ſ�ī�� �����ѵ�-�ѱ޿��� ���� ����.
           , ITS.CHECK_CARD_DED_RATE        -- üũī�� ��������.
           , ITS.CASH_BAS_RATE              -- ���ݿ����� ���� ����ѵ� ����.
           , ITS.CASH_DED_RATE              -- ���ݿ����� ��������.
           , ITS.CASH_DIRECT_RATE                                                           
           , ITS.CASH_DED_LMT               -- ���ݿ����� �����ѵ�1.
           , ITS.CASH_DED_LMT_RATE          -- ���ݿ����� �����ѵ�-�ѱ޿��� ���� ����.
           , ITS.CARD_ADD_DED_LMT           -- �߰������ѵ�.
           , ITS.CARDCASH_DED_LMT_RATE      -- �ſ�ī�����ݿ����� �����ѵ�-�ѱ޿��� ���� ����.
           , ITS.STOCK_LMT                  -- �츮���������ѵ�.                                       
           , ITS.LONG_STOCK_SAVING_RATE_1   -- ����ֽ������� ����1.
           , ITS.LONG_STOCK_SAVING_LMT_1    -- ����ֽ������� �ѵ�1.
           , ITS.LONG_STOCK_SAVING_RATE_2   -- ����ֽ������� ����2.
           , ITS.LONG_STOCK_SAVING_LMT_2    -- ����ֽ������� �ѵ�2.
           , ITS.LONG_STOCK_SAVING_RATE_3   -- ����ֽ������� ����3.
           , ITS.LONG_STOCK_SAVING_LMT_3    -- ����ֽ������� �ѵ�3.
           , ITS.EMPLOYMENT_KEEP_RATE       -- ��������߼ұ���ٷ��ڼҵ������.
           , ITS.EMPLOYMENT_KEEP_LMT        -- ��������߼ұ���ٷ��ڼҵ�����ѵ�.
           , ITS.IN_TAX_BASE                -- �ٷμҵ�⺻������.
           , ITS.IN_TAX_STD_A               -- �ٷμҵ漼�װ��� �ѵ�1.
           , ITS.IN_TAX_RATE_A              -- �ٷμҵ漼�װ��� �ѵ� ����1.
           , ITS.IN_TAX_STD_B               -- �ٷμҵ漼�װ��� �ѵ�2.
           , ITS.IN_TAX_RATE_B              -- �ٷμҵ漼�װ��� �ѵ� ����2.
           , ITS.IN_TAX_BASE_B              -- �ٷμҵ漼�װ����⺻ �ݾ�2.
           , ITS.IN_TAX_STD_C               -- �ٷμҵ漼�װ��� �ѵ�3.
           , ITS.IN_TAX_RATE_C              -- �ٷμҵ漼�װ��� �ѵ� ����3.
           , ITS.IN_TAX_BASE_C              -- �ٷμҵ漼�װ����⺻ �ݾ�3.
           , ITS.IN_TAX_LMT                 -- �ٷμҵ漼�װ��� �ѵ�.
           , ITS.POLI_GIFT_MAX              -- ��ġ��α��ѵ�.
           , ITS.POLI_GIFT_RATE             -- ��ġ��α� ����.
           , ITS.POLI_GIFT_RATE1            -- ��ġ��α� ����1.
           , ITS.TAX_ASSO_RATE              -- ��������.
           , ITS.HOUSE_DEBT_BEN_RATE        -- �����ڱ����Ա����ڼ��װ���.
           , ITS.FOREIGN_TAX_DED            -- �ܱ����μ��װ���.
           , ITS.LOCAL_TAX_RATE             -- �ҵ漼 ����.
           , ITS.SP_TAX_RATE                -- ��Ư�� ���� ����.
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
