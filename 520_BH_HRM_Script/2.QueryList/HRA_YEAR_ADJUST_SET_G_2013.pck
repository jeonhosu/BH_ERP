CREATE OR REPLACE PACKAGE HRA_YEAR_ADJUST_SET_G_2013 AS
  /*================================================================================/
       ==> �������� ó��(2008. 12. 25)
         0. �������� ó�� �����ڷ� ����;
         1. �޿�, ��, �����(����������, �߰��ٷμ���),
         2. ���ٹ��� �ڷ�;
         3. ������, ����;
         3.5 �ٷμҵ� ���� ��� ?;
         4. ��������;
         5. ����� ����;
         6. �Ƿ�� ����;
         7. ������ ����;
         8-1. �����ڱ� ����(�����������Աݿ����ݻ�ȯ��/��������������Ա����ڻ�ȯ��);
         8-2. ���ø�������ҵ����;
         9. ��α� ���� (��ġ�ڱ� ���� );
         10. ȥ��, ���, �̻��� ����;
         11.1 ���ο�������ҵ����  ?;
         11.2 �������� ���� ;
         11.3 �������� ���� ;
         12. ������������ ;
         13. �ſ�ī��?    ;   ;
         14. �츮�����⿬ ? ;
         14-1. �ұ��/�һ���� �����αݿ� ���� �ҵ����;
         14-2. ����ֽ�������ҵ����;
         15. ����ǥ��;
         16.1 �ٷμҵ漼�װ���  ;
         16.2 �������� ���ݰ���(���� �ҵ��� �ִ��ڿ� ����) -- �ش� ����  ;
         16.3 �����ڱ����Ա� ���װ���  ;
         17. ��������  ;
         18. ��������  ;
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

  -- 0. �������� ó�� ��� ����;
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

  -- 3.5 �ٷμҵ���� ���;
  FUNCTION INCOME_DED_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;

  -- 4. ��������;
  FUNCTION SUPP_FAMILY_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_STD_DATE          IN DATE
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 5. ����� ����;
  FUNCTION ETC_INSUR_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 6. �Ƿ�� ����;
  FUNCTION MEDIC_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;

  -- 7. ������ ����;
  FUNCTION EDUCATION_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 8-1. �����ڱ� ����(�����������Աݿ����ݻ�ȯ��);
  FUNCTION HOUSE_FUND_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;

  -- 8-2. �����ڱ� ����(�����ҵ����);
  FUNCTION HOUSE_FUND_MONTHLY_RENT_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;
            
  -- 8-3. �����ڱ� ����(����������ڻ�ȯ��);
  FUNCTION HOUSE_FUND_LONG_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;
            
  -- 8-4. ���ø�������ҵ����;
  FUNCTION HOUSE_SAVE_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 9. ��α� ����
  FUNCTION DONATION_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_INCOME_AMT        IN NUMBER
            ) RETURN NUMBER;

  -- 10. ȥ��, ���, �̻��� ����;
  FUNCTION MARRY_ETC_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;

  -- 11.1 ���ο�������ҵ����, �������� ����
  FUNCTION PER_ANNU_BANK_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 11.2 ��������ҵ����, �������� ����;
  FUNCTION ANNU_BANK_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 11.3 �������� ���� ;
  FUNCTION RETR_ANNU_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 12. ������������;
  FUNCTION INVEST_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_INCOME_AMT        IN NUMBER
            ) RETURN NUMBER;

  -- 14.1 ����û���������� ���Ծ� �ҵ����;
  FUNCTION HOUSE_APP_DEPOSIT_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_HOUSE_DED_AMT     IN NUMBER
            ) RETURN NUMBER;

  -- 13. �ſ�ī��� ����;
  FUNCTION CARD_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;

  -- 14. �츮�����⿬;
  FUNCTION EMPL_STOCK_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 14-1. �ұ��/�һ���� �����αݿ� ���� �ҵ����;
  FUNCTION SMALL_CORPOR_DED_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 14-2. ����ֽ�������ҵ����;
  FUNCTION LONG_STOCK_SAVING_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;
            
  -- 14-4. �񵷾ȵ�� ���� ���ڻ�ȯ�� ����;
  FUNCTION FIX_LEASE_DED_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;            

-- 14-9. Ư������ �����ѵ� �ʰ���;
  FUNCTION SPECIAL_DED_LMT_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;
            
  -- 15. ����ǥ�� ;
  FUNCTION COMP_TAX_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TAX_STD_AMT       IN NUMBER
            ) RETURN NUMBER;

  -- 16.1 ���װ��� - �ҵ漼�� ;
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

  -- 16.2 ���װ��� - ����Ư�����ѹ� ;
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

  -- 16.3 ���װ��� - ��������;
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
            
  -- 17.1 �ٷμҵ漼�װ��� ;
  FUNCTION TAX_DED_INCOME_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_COMP_TAX_AMT      IN NUMBER
            ) RETURN NUMBER;

  -- 17.2 �������� ���װ���;
  FUNCTION TAX_DED_TAXGROUP_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_COMP_TAX_AMT      IN NUMBER
            ) RETURN NUMBER;

  -- 17.3 �����ڱ����Ա� ���װ���;
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
       ==> �������� ó��(2008. 12. 25)
         0. �������� ó�� �����ڷ� ����;
         1. �޿�, ��, �����(����������, �߰��ٷμ���),
         2. ���ٹ��� �ڷ�;
         3. ������, ����;
         3.5 �ٷμҵ� ���� ��� ?;
         4. ��������;
         5. ����� ����;
         6. �Ƿ�� ����;
         6.1 �����, ��Ÿ �Ƿ�� ���� 
         7. ������ ����;
         7.1 �����, ��Ÿ ������ ���� 
         8-1. �����ڱ� ����(�����������Աݿ����ݻ�ȯ��/��������������Ա����ڻ�ȯ��);
         8-2. ���ø�������ҵ����;
         9. ��α� ���� (��ġ�ڱ� ���� );
         10. ȥ��, ���, �̻��� ����;
         11.1 ���ο�������ҵ����  ?;
         11.2 �������� ���� ;
         11.3 �������� ���� ;
         12. ������������ ;
         13. �ſ�ī��?    ;   ;
         14. �츮�����⿬ ? ;
         14-1. �ұ��/�һ���� �����αݿ� ���� �ҵ����;
         14-2. ����ֽ�������ҵ����;
         -- Ư������ �����ѵ� �ʰ��� ���� 
         15. ����ǥ��;
         16.1 �ٷμҵ漼�װ���  ;
         16.2 �������� ���ݰ���(���� �ҵ��� �ִ��ڿ� ����) -- �ش� ����  ;
         16.3 �����ڱ����Ա� ���װ���  ;
         17. ��������  ;
         18. ��������  ;
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
    --- ���� ���� �հ�  
    V_PRE_PAY_SUM                 NUMBER;  -- ���� �޿��հ�  ;
    V_PRE_BONUS_SUM               NUMBER;  -- ���� ���հ� ; 
    V_PRE_ADD_BONUS               NUMBER;  -- ���� ������ �հ� ; 
    V_PRE_STOCK_BENE_AMT          NUMBER;  -- ���� �ֽĸż����ñ� �������  ;
    V_PRE_EMPLOYEE_STOCK_AMT      NUMBER;  -- 2013�� �߰� : ���� �츮�������������  
    V_PRE_OFFICE_RETIRE_OVER_AMT  NUMBER;  -- 2013�� �߰� : ���� �ӿ������ҵ�ݾ� �ѵ��ʰ���  
    
    V_PRE_ANNU_INSUR_AMT          NUMBER;  -- ���� ���ο���;
    V_PRE_PUBLIC_INSUR_AMT        NUMBER;  -- 2013�� �߰� : ���� ���������ݺ��� 
    V_PRE_MARINE_INSUR_AMT        NUMBER;  -- 2013�� �߰� : ���� ���ο��ݺ���  
    V_PRE_SCHOOL_STAFF_INSUR_AMT  NUMBER;  -- 2013�� �߰� : ���� �縳�б� ���������ݺ���
    V_PRE_POST_OFFICE_INSUR_AMT   NUMBER;  -- 2013�� �߰� : ���� ������ü�����ݺ��� 
     
    V_PRE_MEDIC_INSUR_AMT         NUMBER;  -- ���� �ǰ����� �հ� ; 
    V_PRE_HIRE_INSUR_AMT          NUMBER;  -- ���� ��뺸�� �հ� ;
    
    V_PRE_IN_TAX_AMT              NUMBER;  -- ���� �ҵ漼 �հ� ; 
    V_PRE_LOCAL_TAX_AMT           NUMBER;  -- ���� �ֹμ� �հ� ; 
    
    ---------------------------------------------------------------------------------------------------     
    -- �����ڷ� ���� ���� ���ذ� - ��ο�� ���� ����.
    V_OLD_DED_AGE                 NUMBER;
    V_OLD_DED_AGE1                NUMBER;
    
    -- ���⵵ �߰������ ����� ����--
    V_PRE_YEAR_OT_DED_FLAG        VARCHAR2(2) := 'N';
          
    --- ���� ���� �հ�              
    V_PAY_SUM                     NUMBER;  -- �� �޿��հ�  ;
    V_BONUS_SUM                   NUMBER;  -- �� ���հ� ;  
    V_ADD_BONUS                   NUMBER;  -- �� ������ �հ�   ;
    
    V_STOCK_BENE_AMT              NUMBER;  -- 2013�� �߰� : �ֽĸż����ñ� �������  
    V_EMPLOYEE_STOCK_AMT          NUMBER;  -- 2013�� �߰� : �츮�������������  
    V_OFFICERS_RETIRE_OVER_AMT    NUMBER;  -- 2013�� �߰� : �ӿ������ҵ�ݾ� �ѵ��ʰ���  
    
    --- ���ܼҵ�       
    V_INCOME_OUTSIDE_AMT          NUMBER;  -- ���� ���� �ҵ� ; 
    V_NONTAX_OUTSIDE_AMT          NUMBER;  -- ���� ����� �ҵ�  ;
    V_TAX_OUTSIDE_AMT             NUMBER;  -- ���� �ⳳ�μ���  ;                                      
  
    --- �����
    V_NONTAX_ETC_AMT              NUMBER;   -- ��Ÿ�����  ;
    V_NONTAX_OT_AMT               NUMBER;   -- �߰��ٷκ����  ;
    V_NONTAX_BABY_AMT             NUMBER;   -- ���ƺ�������.
    V_NONTAX_OUTS_WORK_1          NUMBER;   -- ����� ���ܼ���;   
    V_NONTAX_OUTS_WORK_2          NUMBER;   -- ����� ���ܼ���(300����);  
    
    
    --- ���� ���� �հ�  
    V_IN_TAX_AMT                  NUMBER;   -- �ҵ漼 �հ�; 
    V_LOCAL_TAX_AMT               NUMBER;   -- �ֹμ� �հ�; 

---------------------------------------------------------------------------------------------------  
    V_TOTAL_PAY                   NUMBER;  -- �� �޿�(�� �޿��հ� + ���� �޿��հ�);
  
    V_INCOME_DED_AMT              NUMBER;  -- �ٷμҵ���� �ݾ�  ;
    V_INCOME_PAY                  NUMBER;  -- �����޾� - �ٷμҵ���� �ݾ� ;
    V_REAL_TAX                    NUMBER;  -- �Ǽ��ݾ� 
  
    V_SUPP_FAMILY_DED_AMT         NUMBER;  -- �������� �հ�  ;  
        
    V_ANNU_INSUR_AMT              NUMBER;  -- ���ο���;
    V_PUBLIC_INSUR_AMT            NUMBER;  -- 2013�� �߰� : ���������ݺ��� 
    V_MARINE_INSUR_AMT            NUMBER;  -- 2013�� �߰� : ���ο��ݺ���  
    V_SCHOOL_STAFF_INSUR_AMT      NUMBER;  -- 2013�� �߰� : �縳�б� ���������ݺ���
    V_POST_OFFICE_INSUR_AMT       NUMBER;  -- 2013�� �߰� : ������ü�����ݺ��� 
     
    V_MEDIC_INSUR_AMT             NUMBER;  -- �ǰ����� �հ� ; 
    V_HIRE_INSUR_AMT              NUMBER;  -- ��뺸�� �հ� ;
    
    V_ANNU_BANK_AMT               NUMBER;  -- ��������  ;
    V_RETR_ANNU_AMT               NUMBER;  -- ������������  ;
      
    V_INSURE_DED_AMT              NUMBER;  -- ����� �հ�  ; 
    V_MEDIC_DED_AMT               NUMBER;  -- �Ƿ�� �հ� ;
    V_EDU_DED_AMT                 NUMBER;  -- ������ �հ� ;
    V_HOUSE_DED_AMT               NUMBER;  -- �����ڱ� �հ�; 
    V_DONAT_DED_AMT               NUMBER;  -- ��α� �հ� ;
    V_MARRY_ETC_DED_AMT           NUMBER;  -- ȥ������̻� �հ� ;
  
    V_SP_STD_DED_AMT              NUMBER;  -- ǥ�ذ��� ;
    V_SP_DED_SUM                  NUMBER;  -- Ư������ �հ� ;
    V_SUBT_DED_AMT                NUMBER;  -- �����ҵ���� ; 
  
    V_PER_ANNU_BANK_AMT           NUMBER;  -- ���ο�������;  
    V_HOUSE_SAVE_AMT              NUMBER;  -- ���ø����������;
    V_CARD_AMT                    NUMBER;  -- �ſ�ī��, ���ݿ����� ���� ;
    
    V_SMALL_CORPOR_DED_AMT        NUMBER;  -- 2008 - �ұ��/�һ��� �����αݾ�;
    V_INVEST_AMT                  NUMBER;  -- 2008 - �������� ����;    
    V_EMPL_STOCK_AMT              NUMBER;  -- 2008 - �츮�����⿬��  ;
    V_HIRE_KEEP_EMPLOY_AMT        NUMBER;  -- 2008 - ��������߼ұ���ٷ��ڼҵ���� ;
    
    --> 2011�⵵ �߰�;     
    V_HOUSE_APP_DEPOSIT_AMT       NUMBER;  -- ����û���������� ���Ծ� �ҵ����;  
    V_LONG_STOCK_SAVING_AMT       NUMBER;  -- ����ֽ�����;;
    V_FIX_LEASE_DED_AMT           NUMBER;  -- 2013-�񵷾ȵ�� ���� ���ڻ�ȯ�� ;
    V_ETC_DED_SUM                 NUMBER;  -- ��Ÿ�ҵ���� ��  ;
    
    V_SP_DED_TOT_AMT              NUMBER;  -- 2013-Ư������ �����ѵ� �ʰ��� 
    V_TAX_STD_AMT                 NUMBER;  -- ����ǥ�� ; 
    V_COMP_TAX_AMT                NUMBER;  -- ���⼼�� ; 
  
    V_TAX_REDU_IN_LAW_AMT         NUMBER;  -- ���װ���-�ҵ漼��.
    V_TAX_REDU_SP_LAW_AMT         NUMBER;  -- ���װ���-����Ư�����ѹ�.
    V_TAX_REDU_TAX_TREATY         NUMBER;  -- ���װ���-��������.
    
    F_IN_TAX_AMT                  NUMBER; -- �����ҵ漼 �հ� ; 
    F_SP_TAX_AMT                  NUMBER; -- ������Ư�� �հ�.;
    F_LOCAL_TAX_AMT               NUMBER; -- �����ֹμ� �հ�  ;
    S_IN_TAX_AMT                  NUMBER; -- �����ҵ漼 �հ�;  
    S_SP_TAX_AMT                  NUMBER; -- ������Ư�� �հ�.;
    S_LOCAL_TAX_AMT               NUMBER; -- �����ֹμ� �հ�  ;
  
---------------------------------------------------------------------------------------------------     
    V_RECORD_COUNT                NUMBER;
  BEGIN
---> �ʱ�ȭ  
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
    
---> 0. �������� ó�� �����ڷ� ����  
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

---> 1. �������� ��ȸ : ��ο�� ����.
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
    
---> 1. �ξ簡�� ���� ���� üũ : ������ �����ڷḸ �ڵ����� ����.
    FOR C1 IN (SELECT HA.PERSON_ID
                   , PM.NAME
                   , PM.DISPLAY_NAME
                   , PM.REPRE_NUM
                   , DECODE(HB.DISABLED_ID, NULL, 'N', 'Y') AS DISABILITY_YN
                 FROM HRM_PERSON_MASTER PM
                   , (-- ���� �λ系��.
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
                  AND HA.CLOSED_FLAG   != 'Y'  -- ���� ���� ���� �����͸� ó�� -- 
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
        , BIRTH_YN -- ���/�Ծ�;
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
        , '0'  -- ����;
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

---> �������� ��� ����;
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
                   , NVL(HIT1.FOREIGN_INCOME_RATE, 0) FOREIGN_INCOME_RATE -- �ܱ��αٷ��ڴ��ϼ���;
                   , NVL(HIT1.DRIVE_DED_LMT, 0) DRIVE_DED_LMT -- �ڰ�����������;
                   , NVL(HIT1.PRE_YEAR_INCOME_TOT_AMT_LMT, 0) AS PRE_YEAR_INCOME_TOT_AMT_LMT  -- �߰��ٷμ��� ���������Ⱓ �ѱ޿��ѵ�.
                   , NVL(HIT1.MONTH_PAY_STD, 0) MONTH_PAY_STD -- �߰��ٷμ��� ���� �޿� ����;
                   , NVL(HIT1.OT_DED_LMT, 0) OT_DED_LMT -- �߰��ٷμ��� �ѵ�;
                   , NVL(HIT1.SP_DED_STD, 0) SP_DED_STD -- ǥ�ذ��� ���ؾ�;
                   , NVL(HIT1.SP_DED_AMT, 0) SP_DED_AMT -- ǥ�ذ����ݾ�;
                   , NVL(HIT1.LOCAL_TAX_RATE, 1) LOCAL_TAX_RATE -- �ҵ漼 ����;
                   , NVL(HIT1.FOREIGN_INCOME_DED_AMT, 0) AS FOREIGN_INCOME_DED_AMT  -- ���ܼҵ�ٷ�.
                   , NVL(HIT1.FOREIGN_INCOME_DED_AMT2, 0) AS FOREIGN_INCOME_DED_AMT2  -- ���ܼҵ�ٷ�(������)   
                   , NVL(HIT1.BABY_DED_LMT, 0) AS BABY_DED_LMT  -- ���ƺ�������.
                   , NVL(PM.FOREIGN_TAX_YN, 'N') AS FOREIGN_TAX_YN  -- �ܱ��� ���ϼ�������.
                 FROM HRM_PERSON_MASTER  PM
                   , (-- ���� �λ系��.
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
                   , ( -- �����������;
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
                  AND HA.CLOSED_FLAG   != 'Y'  -- �̸��� �ڷ� -- 
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
----- ���� �ʱ�ȭ  -----------------------------------------------------------------------------------------------------                       
      V_PAY_SUM                     := 0;  -- �� �޿��հ� ; 
      V_BONUS_SUM                   := 0;  -- �� ���հ� ;  
      V_ADD_BONUS                   := 0;  -- �� ������ �հ�  ; 
      
      V_STOCK_BENE_AMT              := 0;  -- �ֽĸż������ñ��������;  
      V_EMPLOYEE_STOCK_AMT          := 0;  -- 2013�� �߰� : �츮�������������  
      V_OFFICERS_RETIRE_OVER_AMT    := 0;  -- 2013�� �߰� : �ӿ������ҵ�ݾ� �ѵ��ʰ���  
      
      --- ���ܼҵ�       
      V_INCOME_OUTSIDE_AMT          := 0;  -- ���� ���� �ҵ�  ;
      V_NONTAX_OUTSIDE_AMT          := 0;  -- ���� ����� �ҵ�  ;
      V_TAX_OUTSIDE_AMT             := 0;  -- ���� �ⳳ�μ���  ;                                      
      
      -- ���⵵ �߰� ����� ��� ���� --
      V_PRE_YEAR_OT_DED_FLAG        := 'N';
      
      --- �����  
      V_NONTAX_ETC_AMT              := 0;  -- ��Ÿ�����  ;
      V_NONTAX_OT_AMT               := 0;  -- �߰��ٷκ����;  
      V_NONTAX_BABY_AMT             := 0;  -- ��������.
      V_NONTAX_OUTS_WORK_1          := 0;  -- ����� ���ܱٷμ���;
      V_NONTAX_OUTS_WORK_2          := 0;  -- ����� ���ܱٷμ���(300����);
      
      --- ���� ����         
      V_ANNU_INSUR_AMT              := 0;  -- ���ο���;
      V_MEDIC_INSUR_AMT             := 0;  -- �ǰ����� �հ�;  
      V_HIRE_INSUR_AMT              := 0;  -- ��뺸�� �հ�;  
      
      V_PUBLIC_INSUR_AMT            := 0;  -- 2013�� �߰� : ���������ݺ��� 

      V_MARINE_INSUR_AMT            := 0;  -- 2013�� �߰� : ���ο��ݺ���  
      V_SCHOOL_STAFF_INSUR_AMT      := 0;  -- 2013�� �߰� : �縳�б� ���������ݺ���
      V_POST_OFFICE_INSUR_AMT       := 0;  -- 2013�� �߰� : ������ü�����ݺ��� 
    
      V_IN_TAX_AMT                  := 0;  -- �ҵ漼 �հ�;  
      V_LOCAL_TAX_AMT               := 0;  -- �ֹμ� �հ�;  
      
      --- ���� ���� �հ�  
      V_PRE_PAY_SUM                 := 0;  -- ���� �޿��հ�;  
      V_PRE_BONUS_SUM               := 0;  -- ���� ���հ�;  
      V_PRE_ADD_BONUS               := 0;  -- ���� ������ �հ�;  
      V_PRE_STOCK_BENE_AMT          := 0;  -- ���� �ֽĸż����ñ��������;  
      V_PRE_EMPLOYEE_STOCK_AMT      := 0;  -- 2013�� �߰� : ���� �츮�������������  
      V_PRE_OFFICE_RETIRE_OVER_AMT  := 0;  -- 2013�� �߰� : ���� �ӿ������ҵ�ݾ� �ѵ��ʰ���  
    
      V_PRE_ANNU_INSUR_AMT          := 0;  -- ���� ���ο���;
      V_PRE_PUBLIC_INSUR_AMT        := 0;  -- 2013�� �߰� : ���� ���������ݺ��� 
      V_PRE_MARINE_INSUR_AMT        := 0;  -- 2013�� �߰� : ���� ���ο��ݺ���  
      V_PRE_SCHOOL_STAFF_INSUR_AMT  := 0;  -- 2013�� �߰� : ���� �縳�б� ���������ݺ���
      V_PRE_POST_OFFICE_INSUR_AMT   := 0;  -- 2013�� �߰� : ���� ������ü�����ݺ��� 
       
      V_PRE_MEDIC_INSUR_AMT         := 0;  -- ���� �ǰ����� �հ� ; 
      V_PRE_HIRE_INSUR_AMT          := 0;  -- ���� ��뺸�� �հ� ;
      
      V_PRE_IN_TAX_AMT              := 0;  -- ���� �ҵ漼 �հ�;  
      V_PRE_LOCAL_TAX_AMT           := 0;  -- ���� �ֹμ� �հ�;  
      
---------------------------------------------------------------------------------------------------  
      V_TOTAL_PAY                   := 0;  -- �� �޿�(�� �޿��հ� + ���� �޿��հ�);
    
      V_INCOME_DED_AMT              := 0;  -- �ٷμҵ���� �ݾ�  ;
      V_INCOME_PAY                  := 0;  -- �����޾� - �ٷμҵ���� �ݾ�;  
      V_REAL_TAX                    := 0;  -- �Ǽ��ݾ� ;
    
      V_SUPP_FAMILY_DED_AMT         := 0;  -- �������� �հ� ;     
      
      V_ANNU_BANK_AMT               := 0;  -- ��������  ;
      V_RETR_ANNU_AMT               := 0;  -- ������������ ;
      
      V_INSURE_DED_AMT              := 0;  -- ����� �հ� ;  
      V_MEDIC_DED_AMT               := 0;  -- �Ƿ�� �հ� ;
      V_EDU_DED_AMT                 := 0;  -- ������ �հ� ;
      V_HOUSE_DED_AMT               := 0;  -- �����ڱ� �հ�;
      V_DONAT_DED_AMT               := 0;  -- ��α� �հ� ;
      V_MARRY_ETC_DED_AMT           := 0;  -- ȥ������̻� �հ� ;
    
      V_SP_STD_DED_AMT              := 0;  -- ǥ�ذ��� ;
      V_SP_DED_SUM                  := 0;  -- Ư������ �հ� ;
      V_SUBT_DED_AMT                := 0;  -- �����ҵ����;  
    
      V_PER_ANNU_BANK_AMT           := 0;  -- ���ο������� ;      
      V_HOUSE_SAVE_AMT              := 0;  -- ���ø����������;
      V_CARD_AMT                    := 0;  -- �ſ�ī��, ���ݿ����� ���� ;
      
      V_SMALL_CORPOR_DED_AMT        := 0;  -- 2008 - �ұ��/�һ��� �����αݾ�;
      V_INVEST_AMT                  := 0;  -- 2008 - �������� ����;       
      V_EMPL_STOCK_AMT              := 0;  -- 2008 - �츮�����⿬�� ;           
        
      --> 2011.01.17 BY 
      V_HOUSE_APP_DEPOSIT_AMT       := 0;  -- ����û���������� ���Ծ� �ҵ����;      
      V_LONG_STOCK_SAVING_AMT       := 0;  -- ����ֽ�����;;          
      V_HIRE_KEEP_EMPLOY_AMT        := 0;  -- 2008 - ��������߼ұ���ٷ��ڼҵ���� ;
      V_FIX_LEASE_DED_AMT           := 0;  -- �񵷾ȵ�� �������ڻ�ȯ�� ����; 
      V_ETC_DED_SUM                 := 0;  -- ��Ÿ�ҵ���� ��  ;
      
      V_SP_DED_TOT_AMT              := 0;  -- 2013.12.31 ��ȣ�� �߰� : Ư������ �����ѵ� �ʰ���; 
      V_TAX_STD_AMT                 := 0;  -- ����ǥ�� ; 
      V_COMP_TAX_AMT                := 0;  -- ���⼼�� ; 
      
      V_TAX_REDU_IN_LAW_AMT         := 0;  -- ���װ���-�ҵ漼��.
      V_TAX_REDU_SP_LAW_AMT         := 0;  -- ���װ���-����Ư�����ѹ�.
      V_TAX_REDU_TAX_TREATY         := 0;  -- ���װ���-��������.
      
      F_IN_TAX_AMT                  := 0;  -- �����ҵ漼 �հ� ; 
      F_SP_TAX_AMT                  := 0;  -- ������Ư�� �հ�.;
      F_LOCAL_TAX_AMT               := 0;  -- �����ֹμ� �հ�  ;
      S_IN_TAX_AMT                  := 0;  -- �����ҵ漼 �հ� ; 
      S_SP_TAX_AMT                  := 0;  -- ������Ư�� �հ�.;
      S_LOCAL_TAX_AMT               := 0;  -- �����ֹμ� �հ�; 
    
----- <����> ------------------------------------------------------------------------------             
      -- �ѱ޿�, �ѻ�, ��Ÿ�����, �߰��ٷμ��� ���� -- 
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
        --> �� �ٹ��� �޿� �հ� 
        V_PAY_SUM   := V_PAY_SUM + NVL(C1S.PAY_AMT, 0);      -- �޿�  
        V_BONUS_SUM := V_BONUS_SUM + NVL(C1S.BONUS_AMT, 0);  -- ��   
       
        -- ������ �ѵ� ���� --
        --> ����������;
        V_TEMP_AMT := 0;
        IF NVL(C1.DRIVE_DED_LMT, 0) < NVL(C1S.NONTAX_CAR_AMT, 0) THEN 
          V_TEMP_AMT := NVL(C1.DRIVE_DED_LMT, 0);
        ELSE
          V_TEMP_AMT := NVL(C1S.NONTAX_CAR_AMT, 0);
        END IF;
        V_NONTAX_ETC_AMT := NVL(V_NONTAX_ETC_AMT, 0) + NVL(V_TEMP_AMT, 0);
        
        --> ���ܱٷμҵ�(100���� �ѵ�);
        V_TEMP_AMT := 0;        
        IF NVL(C1.FOREIGN_INCOME_DED_AMT, 0) < NVL(C1S.NONTAX_OUTSIDE_AMT, 0) THEN 
          V_TEMP_AMT := NVL(C1.FOREIGN_INCOME_DED_AMT, 0);
        ELSE
          V_TEMP_AMT := NVL(C1S.NONTAX_OUTSIDE_AMT, 0);
        END IF;
        V_NONTAX_OUTS_WORK_1 := NVL(V_NONTAX_OUTS_WORK_1, 0) + NVL(V_TEMP_AMT, 0);
        --V_INCOME_OUTSIDE_AMT := NVL(V_INCOME_OUTSIDE_AMT, 0) + NVL(C1S.NONTAX_OUTSIDE_AMT, 0);  -- �޿����� ���޹��� ���ܱٷμ���.
        
        --> ���ܱٷμҵ�(300���� �ѵ�);
        V_TEMP_AMT := 0;        
        IF NVL(C1.FOREIGN_INCOME_DED_AMT2, 0) < NVL(C1S.NONTAX_OUTSIDE_AMT2, 0) THEN 
          V_TEMP_AMT := NVL(C1.FOREIGN_INCOME_DED_AMT2, 0);
        ELSE
          V_TEMP_AMT := NVL(C1S.NONTAX_OUTSIDE_AMT2, 0);
        END IF;
        V_NONTAX_OUTS_WORK_2 := NVL(V_NONTAX_OUTS_WORK_2, 0) + NVL(V_TEMP_AMT, 0);
                
        --> ���ƺ�������;
        V_TEMP_AMT := 0;
        IF NVL(C1.BABY_DED_LMT, 0) < NVL(C1S.NONTAX_BABY_AMT, 0) THEN 
          V_TEMP_AMT := NVL(C1.BABY_DED_LMT, 0);
        ELSE
          V_TEMP_AMT := NVL(C1S.NONTAX_BABY_AMT, 0);
        END IF;
        V_NONTAX_BABY_AMT := NVL(V_NONTAX_BABY_AMT, 0) + NVL(V_TEMP_AMT, 0);
        
        --> ������ �߰��ٷμ��� ����� üũ (100���� ����).  
        IF C1.PAY_TYPE IN ('2', '4') AND NVL(C1S.TOT_PAY_AMOUNT, 0) <= NVL(C1.MONTH_PAY_STD, 0) THEN
          V_NONTAX_OT_AMT := NVL(V_NONTAX_OT_AMT, 0) + NVL(C1S.NONTAX_OT_AMT, 0);
        END IF;
      END LOOP C1S;
      
      -- (����) �ⳳ�� ����, ���ο���, �ǰ�����, ��뺸�� ���� --                       
      BEGIN
        SELECT SUM(CASE  -- �ҵ漼.
                     WHEN HD.DEDUCTION_CODE = 'D01' THEN MD.DEDUCTION_AMOUNT
                     ELSE 0
                   END) AS IN_TAX_AMT
            , SUM(CASE  -- �ֹμ�.
                   WHEN HD.DEDUCTION_CODE = 'D02' THEN MD.DEDUCTION_AMOUNT
                   ELSE 0
                 END) AS LOCAL_TAX_AMT
            , SUM(CASE  -- ����.
                   WHEN HD.DEDUCTION_CODE IN('D03', 'D08') THEN MD.DEDUCTION_AMOUNT
                   ELSE 0
                 END) AS ANNU_INSUR_AMT
            , SUM(CASE  -- ���.
                   WHEN HD.DEDUCTION_CODE = 'D04' THEN MD.DEDUCTION_AMOUNT
                   ELSE 0
                 END) AS HIRE_INSUR_AMT
            , SUM(CASE  -- �ǰ�+�����.
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
          --DBMS_OUTPUT.PUT_LINE('�ⳳ�� ���׵� ���� ���� :' || SUBSTR(SQLERRM, 1, 150));
          V_IN_TAX_AMT      := 0;
          V_LOCAL_TAX_AMT   := 0;
          V_ANNU_INSUR_AMT  := 0;
          V_HIRE_INSUR_AMT  := 0;
          V_MEDIC_INSUR_AMT := 0;
      END;
      
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        -- �ܱ��δ��ϼ��� : ����� ���� ����.
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
--DBMS_OUTPUT.PUT_LINE('�޿����⳻��=> �ѱ޿�->' || V_TOTAL_PAY || '/�ѻ�->' || V_TOTAL_BONUS || '/��Ÿ�����=>' || V_NONTAX_ETC_AMT || '/�߰������=>' || V_NONTAX_OT_AMT);        
      
      -- �������� ���� : ������, ���ڱ�, ��Ÿ����, ���� �ҵ� �ڷ� --
      BEGIN
        SELECT NVL(HF.ADD_BONUS_AMT, 0) + NVL(HF.ADD_EDUCATION_AMT, 0) +
               NVL(HF.ADD_ETC_AMT, 0) AS ADD_BONUS
             , NVL(HF.INCOME_OUTSIDE_AMT, 0) AS INCOME_OUTSIDE_AMT
             , NVL(HF.NONTAX_OUTSIDE_AMT, 0) AS NONTAX_OUTSIDE_AMT
             , NVL(HF.TAX_OUTSIDE_AMT, 0) TAX_OUTSIDE_AMT
               -- �ⳳ�� ���� : ��ȣ�� �߰�.
             , (NVL(V_IN_TAX_AMT, 0) + NVL(HF.IN_TAX_AMT, 0)) AS IN_TAX_AMT
             , (NVL(V_LOCAL_TAX_AMT, 0) + NVL(HF.LOCAL_TAX_AMT, 0)) AS LOCAL_TAX_AMT
               -- ���⵵ �߰������ ��� --
             , NVL(HF.PRE_YEAR_OT_DED_FLAG, 'N') AS PRE_YEAR_OT_DED_FLAG
             -- 2013�⵵ �߰� : �ֽĸż����ñ� �������, �츮�������������, �ӿ������ҵ�ݾ� �ѵ��ʰ��� -- 
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
          --DBMS_OUTPUT.PUT_LINE('�����󿩵� ��Ÿ�ڷ� ���� ���� :' || SUBSTR(SQLERRM, 1, 150));
          V_ADD_BONUS          := 0;
          V_INCOME_OUTSIDE_AMT := 0;
          V_NONTAX_OUTSIDE_AMT := 0;
          V_TAX_OUTSIDE_AMT    := 0;
          V_PRE_YEAR_OT_DED_FLAG := 'N';
          V_STOCK_BENE_AMT := 0;
          V_EMPLOYEE_STOCK_AMT := 0;
          V_OFFICERS_RETIRE_OVER_AMT := 0;
      END;
    
--DBMS_OUTPUT.PUT_LINE('�ⳳ�γ���=> �ҵ漼=>' || V_IN_TAX_AMT || '/�ֹμ�=>' || V_LOCAL_TAX_AMT || '/���ο���=>' || V_ANNU_INSUR_AMT || '/��뺸��=>' || V_HIRE_INSUR_AMT || '/�ǰ�����=>' || V_MEDIC_INSUR_AMT);        
-- <����>�ٹ��� �ڷ� ��ȸ  -----------------------------------------------------------------------------------------------------------                       
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
        -- �ܱ��δ��ϼ��� : ����� ���� ����.
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
      
      --> ����� �ѵ� üũ <--
      --> ������ �߰��ٷμ��� �ѵ� ����.
      IF NVL(C1.OT_DED_LMT, 0) < NVL(V_NONTAX_OT_AMT, 0) THEN 
        V_NONTAX_OT_AMT := NVL(C1.OT_DED_LMT, 0);
      END IF;
      
      --> �߰��ٷμ��� ���������Ⱓ �ѱ޿��ѵ� üũ --
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
        -- �����⵵ �ѱ޿� �ѵ� �̸� : �ű����� --
        NULL;
      ELSIF NVL(V_TEMP_AMT, 0) >= 0 AND NVL(V_TEMP_AMT, 0) <= NVL(C1.PRE_YEAR_INCOME_TOT_AMT_LMT, 0) THEN
        -- �����⵵ �ѱ޿� �ѵ� �̸� --
        NULL;
      ELSE
        -- �����⵵ �ѱ޿� �ѵ� �ʰ��� �߰��ٷμ��� ���� ���� --
        V_NONTAX_OT_AMT := 0;
      END IF;
      
      --> �����Է� : ���ܱٷμ��� ����� ����(100����) --
      IF NVL(V_NONTAX_OUTSIDE_AMT, 0) > 0 THEN
        -- 1�� �ݾ����� ȯ���Ͽ� �ݾ� ���� --
        IF (NVL(C1.FOREIGN_INCOME_DED_AMT, 0) * 12) < (NVL(V_NONTAX_OUTSIDE_AMT, 0) + NVL(V_NONTAX_OUTS_WORK_1, 0)) THEN
          V_NONTAX_OUTSIDE_AMT := (NVL(V_NONTAX_OUTSIDE_AMT, 0) + NVL(V_NONTAX_OUTS_WORK_1, 0)) - NVL(C1.FOREIGN_INCOME_DED_AMT, 0);
        END IF;
      END IF;
      
      /*--> �����Է� : ���ܱٷμ��� ����� ����(300����) --
      IF NVL(V_NONTAX_OUTSIDE_AMT2, 0) > 0 THEN
        -- 1�� �ݾ����� ȯ���Ͽ� �ݾ� ���� --
        IF (NVL(C1.FOREIGN_INCOME_DED_AMT2, 0) * 12) < (NVL(V_NONTAX_OUTSIDE_AMT2, 0) + NVL(V_NONTAX_OUTS_WORK_2, 0)) THEN
          V_NONTAX_OUTSIDE_AMT2 := (NVL(V_NONTAX_OUTSIDE_AMT2, 0) + NVL(V_NONTAX_OUTS_WORK_2, 0)) - NVL(C1.FOREIGN_INCOME_DED_AMT2, 0);
        END IF;
      END IF;*/
      
      --> ���ܱٷμ��� ����� ���� �հ�--
      V_NONTAX_OUTS_WORK_1 := NVL(V_NONTAX_OUTS_WORK_1, 0) + NVL(V_NONTAX_OUTSIDE_AMT, 0);
      
      --> �޿��������� ����� �ݾ� ����(����������, �������, ���ƺ�������, ���ܱٷμ���1, ���ܱٷμ���2, �����Է� ���ܱٷμ���).
      V_PAY_SUM := NVL(V_PAY_SUM, 0) - NVL(V_NONTAX_ETC_AMT, 0) - NVL(V_NONTAX_OT_AMT, 0) 
                                     - NVL(V_NONTAX_BABY_AMT, 0) 
                                     - NVL(V_NONTAX_OUTS_WORK_1, 0)
                                     - NVL(V_NONTAX_OUTS_WORK_2, 0);
    
      --> �� �޿��� + ���� �޿���    
      V_TOTAL_PAY := NVL(V_PAY_SUM, 0) + NVL(V_PRE_PAY_SUM, 0);  -- �޿�  
      V_TOTAL_PAY := NVL(V_TOTAL_PAY, 0) + NVL(V_BONUS_SUM, 0) + NVL(V_PRE_BONUS_SUM, 0);  -- ��  
      V_TOTAL_PAY := NVL(V_TOTAL_PAY, 0) + NVL(V_ADD_BONUS, 0) + NVL(V_PRE_ADD_BONUS, 0);  -- ���� ��  
      V_TOTAL_PAY := NVL(V_TOTAL_PAY, 0) + NVL(V_INCOME_OUTSIDE_AMT, 0);  -- ���ܱٷ�  
      V_TOTAL_PAY := NVL(V_TOTAL_PAY, 0) + NVL(V_STOCK_BENE_AMT, 0) + NVL(V_PRE_STOCK_BENE_AMT, 0);  -- 
      V_TOTAL_PAY := NVL(V_TOTAL_PAY, 0) + NVL(V_EMPLOYEE_STOCK_AMT, 0) + NVL(V_PRE_EMPLOYEE_STOCK_AMT, 0);
      V_TOTAL_PAY := NVL(V_TOTAL_PAY, 0) + NVL(V_OFFICERS_RETIRE_OVER_AMT, 0) + NVL(V_PRE_OFFICE_RETIRE_OVER_AMT, 0);
          
      --> �ѱ޿� - �����(����� ��ȸ �ѱ޿� �հ�)          
      --  V_TOTAL_PAY := V_TOTAL_PAY - V_NONTAX_ETC_AMT - V_NONTAX_OT_AMT - V_NONTAX_OUTSIDE_AMT ;
    
      -- 3.5 �ٷμҵ� ���� ���                          
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
      
----- �ٷμҵ�ݾ� : �ѱ޿� - �ٷμҵ���� ���  
      V_INCOME_PAY := NVL(V_TOTAL_PAY, 0) - NVL(V_INCOME_DED_AMT, 0);
      
      -- ���� �����ϸ� ���� ���   
      V_REAL_TAX := V_INCOME_PAY;

-- UPDATE : �����ٹ��� ����� �ڷ� --------------------------------------------------------------------------
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
          
-- ���ٹ���(�޿�/��/������/���ڱ�/�ⳳ�μ��׵�), ���ٹ����ڷ� UPDATE -----------------------------------------------------------------------                       
      UPDATE HRA_YEAR_ADJUSTMENT HA
        SET HA.NOW_PAY_TOT_AMT    = NVL(V_PAY_SUM, 0)
          , HA.NOW_BONUS_TOT_AMT  = NVL(V_BONUS_SUM, 0)
          , HA.NOW_ADD_BONUS_AMT  = NVL(V_ADD_BONUS, 0)
          , HA.NOW_STOCK_BENE_AMT = NVL(V_STOCK_BENE_AMT, 0)
          , HA.NOW_EMPLOYEE_STOCK_AMT     = NVL(V_EMPLOYEE_STOCK_AMT, 0)
          , HA.NOW_OFFICE_RETIRE_OVER_AMT = NVL(V_OFFICERS_RETIRE_OVER_AMT, 0) 
          
          -- ���� -- 
          , HA.PRE_PAY_TOT_AMT    = NVL(V_PRE_PAY_SUM, 0)
          , HA.PRE_BONUS_TOT_AMT  = NVL(V_PRE_BONUS_SUM, 0)
          , HA.PRE_ADD_BONUS_AMT  = NVL(V_PRE_ADD_BONUS, 0)
          , HA.PRE_STOCK_BENE_AMT = NVL(V_PRE_STOCK_BENE_AMT, 0)
          , HA.PRE_EMPLOYEE_STOCK_AMT     = NVL(V_PRE_EMPLOYEE_STOCK_AMT, 0)
          , HA.PRE_OFFICE_RETIRE_OVER_AMT = NVL(V_PRE_OFFICE_RETIRE_OVER_AMT, 0) 
          
          -- ���� ���ܱٷ� -- 
          , HA.INCOME_OUTSIDE_AMT = NVL(V_INCOME_OUTSIDE_AMT, 0)
          
          -- ����� --
          , HA.NONTAX_OUTSIDE_AMT = NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(V_NONTAX_OUTS_WORK_1, 0) + NVL(V_NONTAX_OUTS_WORK_2, 0)
          , HA.NONTAX_OT_AMT      = NVL(HA.NONTAX_OT_AMT, 0) + NVL(V_NONTAX_OT_AMT, 0)
          
          /* -- ��ȣ�� �ּ�(2013-02-13) : 2009�⵵���� ���� --
          , HA.NONTAX_RESEA_AMT   = 0*/
          , HA.NONTAX_ETC_AMT     = NVL(HA.NONTAX_ETC_AMT, 0) + NVL(V_NONTAX_ETC_AMT, 0)
          , HA.NONTAX_BIRTH_AMT   = NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(V_NONTAX_BABY_AMT, 0)
          , HA.NONTAX_OUTS_WORK_1 = NVL(HA.NONTAX_OUTS_WORK_1, 0) + NVL(V_NONTAX_OUTS_WORK_1, 0)
          , HA.NONTAX_OUTS_WORK_2 = NVL(HA.NONTAX_OUTS_WORK_2, 0) + NVL(V_NONTAX_OUTS_WORK_2, 0)
          
          --> �ѱٷμҵ��հ�(�Ѽҵ�-�����)  
          , HA.INCOME_TOT_AMT     = NVL(V_TOTAL_PAY, 0)
          , HA.INCOME_DED_AMT     = NVL(V_INCOME_DED_AMT, 0)
          , HA.NATI_ANNU_AMT      = NVL(V_ANNU_INSUR_AMT, 0) + NVL(V_PRE_ANNU_INSUR_AMT, 0)     -- ���ο���  
          , HA.RETR_ANNU_AMT      = NVL(V_RETR_ANNU_AMT, 0)  -- ��������  
          , HA.MEDIC_INSUR_AMT    = NVL(V_MEDIC_INSUR_AMT, 0) + NVL(V_PRE_MEDIC_INSUR_AMT, 0)   -- �ǰ�����  
          , HA.HIRE_INSUR_AMT     = NVL(V_HIRE_INSUR_AMT, 0) + NVL(V_PRE_HIRE_INSUR_AMT, 0)     -- ��뺸��  
          --> �ܱ����μ��� 
          , HA.TAX_DED_OUTSIDE_PAY_AMT = NVL(V_TAX_OUTSIDE_AMT, 0)
          --> �ⳳ�μ���                 
          , HA.PRE_IN_TAX_AMT     = NVL(V_IN_TAX_AMT, 0) + NVL(V_PRE_IN_TAX_AMT, 0)
          , HA.PRE_LOCAL_TAX_AMT  = NVL(V_LOCAL_TAX_AMT, 0) + NVL(V_PRE_LOCAL_TAX_AMT, 0)
          , HA.PRE_SP_TAX_AMT     = 0
      WHERE HA.YEAR_YYYY          = P_YEAR_YYYY
        AND HA.PERSON_ID          = C1.PERSON_ID
        AND HA.SOB_ID             = C1.SOB_ID
        AND HA.ORG_ID             = C1.ORG_ID
      ;
-------------------------------------------------------------------------------------------------------------------------------        
      -- 4. �������� ��� 
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
      -- 11.1 ���ݺ���� ���� : ���ο��� ����� ���� ���� 
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - (NVL(V_ANNU_INSUR_AMT, 0) + NVL(V_PRE_ANNU_INSUR_AMT, 0));
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF; 
                          
      -- 11.3 ���ݺ���� ���� : ���� ��������  ���� ��� 
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
      -- 11.2 ���ݺ���� ���� : ��������  ���� ��� 
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
      -- 5. Ư������ : �������� ��� 
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
      -- 6. Ư������ : �Ƿ�� ���� ��� 
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
      -- 7. Ư������ : ������  ���� ��� 
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
      -- 8-1. Ư������ : �����ڱ� ����(�����������Աݿ����ݻ�ȯ��);
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
      
      -- 8-2. Ư������ : �����ڱ� ����(������);
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
      
      -- 8-4. �׹��� �ҵ���� : ���ø����������;
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
      
      -- 8-3. Ư������ : �����ڱ� ����(����������ڻ�ȯ��);
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
      
      /*-- 8-1. �����ڱ� ����(�����������Աݿ����ݻ�ȯ��/�����ҵ����/����������ڻ�ȯ��);
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
      
      -- 9. Ư������ : ��α�  ���� ��� 
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
      -- 10. Ư������ : ȥ������̻�  ���� ��� 
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
      -- Ư������ �հ� = �����, �Ƿ��, ������, �����ڱݰ���, ��α� ���.    
      V_SP_DED_SUM := NVL(V_INSURE_DED_AMT, 0) + NVL(V_MEDIC_DED_AMT, 0) + NVL(V_EDU_DED_AMT, 0) + 
                      NVL(V_HOUSE_DED_AMT, 0) + NVL(V_HOUSE_SAVE_AMT, 0) + 
                      NVL(V_DONAT_DED_AMT, 0) + NVL(V_MARRY_ETC_DED_AMT, 0);
      
      -- Ư������ - ǥ�ذ��� : 
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_SP_STD_DED_AMT := 0;
      ELSE
        IF NVL(V_SP_DED_SUM, 0) < NVL(C1.SP_DED_STD, 0) THEN
          V_SP_STD_DED_AMT := C1.SP_DED_AMT;
        ELSE
          V_SP_STD_DED_AMT := 0;
        END IF;
      END IF;
      
      -- �����ҵ����(ǥ�ذ��� �ݾ��� ������ ǥ�ذ��� �ݾ׸� ������).           
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
      -- 11.1 ���ο�������  ���� ��� 
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
      -- 11.3 ���ø��� ������ 
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - NVL(V_HOUSE_SAVE_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
      
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 12. ������������ 
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
      -- 13. �ſ�ī��� ���� 
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
      -- 14. �츮���������⿬ ����   
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
      -- 14.-1 �ұ��/�һ��ΰ����αݾ�;
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
      -- 14-2. ����ֽ�������ҵ����;   
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
      
      -- 14-4. �񵷾ȵ�� ���� ���ڻ�ȯ�� ����;
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
      
      -- 14-9. 2013-Ư������ �����ѵ� �ʰ���   
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
      -- ����ǥ�� ���;
      IF C1.FOREIGN_TAX_YN = 'Y' THEN
        V_TAX_STD_AMT := TRUNC(NVL(V_TOTAL_PAY, 0) * (C1.FOREIGN_INCOME_RATE / 100));
      ELSE
        V_TAX_STD_AMT := V_REAL_TAX; 
      END IF;
      IF V_TAX_STD_AMT < 0 THEN
        V_TAX_STD_AMT := 0;
      END IF;
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 15.0 ���⼼�� ���   
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
      
      -- 15.1 2013.12.31 ��ȣ�� �߰�  
      -- �������� ���� �ݾ��� ���� ��� ��Ư�� ��� ���� ���⼼�� ���  
      -- �߼ұ��â���������� ���� � ���� �ҵ������ ���� ��� �ش� �ҵ��������   
      -- ����ǥ�ؿ� �����Ͽ� ����� ���⼼�װ� ���� �ҵ�ݾ� �������� ������ ����ǥ������  
      -- ����� ���⼼���� ������ 20%�� ����ϴ� �ݾ��� �����Ư������ ����  
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
        
        -- ��Ư���� ��ȸ -- 
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
        -- ��Ư�� ��� -- 
        F_SP_TAX_AMT := NVL(F_SP_TAX_AMT, 0) +
                        TRUNC(V_TEMP_AMT * (V_TEMP_RATE / 100));        
      END IF;
            
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      BEGIN
        -- ǥ�ذ����� �� �����ҵ������, ����ǥ��, ���⼼��  UPDATE  
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
      -- 16.1 ����-�ҵ漼�� ���.     
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
      
      -- 16.2 ����-����Ư�����ѹ�.
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
            
      -- 16.3 ���װ���-��������.
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
      -- 17.1 �ٷμҵ���� ���        
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
      -- 17.2 �������� ���װ��� ���(���� �ҵ��� �ִ��ڿ� ����) - �ش����        
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
      -- 17.3 �������Ա����ڻ�ȯ�� ���װ��� ���.
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
      
      -- �����Ư���� ���--
      IF V_TEMP_AMT > 0 THEN
        -- ��Ư���� ��ȸ -- 
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
      -- 16.4 �ܱ����� ���� ����          
      V_REAL_TAX := NVL(V_REAL_TAX, 0) - NVL(V_TAX_OUTSIDE_AMT, 0); -- ���ܼҵ� ��ȸ�κп��� ���� ��ȸ��  
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
      
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 16.5 ��ġ��α� ���� ����     
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
      -- 17. ��������  
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
      -- 18. �������� 
      S_IN_TAX_AMT    := NVL(F_IN_TAX_AMT, 0) - NVL(V_IN_TAX_AMT, 0) - NVL(V_PRE_IN_TAX_AMT, 0);
      S_LOCAL_TAX_AMT := NVL(F_LOCAL_TAX_AMT, 0) - NVL(V_LOCAL_TAX_AMT, 0) - NVL(V_PRE_LOCAL_TAX_AMT, 0);
      
      -- ������ ���� 
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
      --DBMS_OUTPUT.PUT_LINE('�������� =>' || TO_CHAR(V_REAL_TAX, 'FM999,999,999,999'));
    
----- ���ٹ���(�޿�/��/������/���ڱ�/�ⳳ�μ��׵�), ���ٹ����ڷ� UPDATE --------------------------------------------------
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

  -- 0. �������� ó�� ��� ����;
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
    --> �ʱ�ȭ.
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
                    , (-- ���� �λ系��.
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
      --> �����ڷ� ����.
      DELETE FROM HRA_YEAR_ADJUSTMENT HA
       WHERE HA.CORP_ID           = P_CORP_ID
         AND HA.YEAR_YYYY         = P_YEAR_YYYY
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
         AND HA.CLOSED_FLAG      != 'Y'
         AND EXISTS 
               (SELECT 'X'  
                  FROM HRM_PERSON_MASTER PM
                    , (-- ���� �λ系��.
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
    
    --> �������� ó����� ����  
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
          , (-- ���� �λ系��.
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

  -- 3.5 �ٷμҵ���� ���;
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
    FOR C1 IN ( -- �������� ó������ �� �ٷμҵ���� ���� �׸�  
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
      ----- 3.5 �ٷμҵ� ���� ���                          
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
        -- 2010.02.02 2010�� �������� ����. ���װ��� ����;
/*      ELSE   -- ���װ���(
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

  -- 4. ��������;
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
    V_MANY_CHILD_DED_AGE      NUMBER := 0; -- �ڳ������ ���� ����;
    V_MANY_CHILD_COUNT        NUMBER := 0; -- ���ڳ��߰��� �ο���.
    V_MANY_CHILD_DED          NUMBER := 0; -- ���ڳ��߰�����  .
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
    -- �������� ó������ �� �ξ簡�� ���� �׸�--
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
                    , NVL(HIT.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT  -- 2013�� �߰� : �Ѻθ��� ����  
                    --> �ο��� --
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
                   , (--> �ξ簡�� �ڷ� 
                      SELECT NVL(SX1.YEAR_YYYY, P_YEAR_YYYY) AS YEAR_YYYY
                           , NVL(SX1.PERSON_ID, PM.PERSON_ID) AS PERSON_ID
                           , NVL(SX1.SOB_ID, PM.SOB_ID) AS SOB_ID
                           , NVL(SX1.ORG_ID, PM.ORG_ID) AS ORG_ID
                           , NVL(SX1.PERSON_COUNT, 1) AS PERSON_COUNT   -- ����--
                           , NVL(SX1.SPOUSE_COUNT, 0) AS SPOUSE_COUNT  -- �����--
                           , NVL(SX1.SUPPORT_COUNT, 0) AS SUPPORT_COUNT
                           , NVL(SX1.OLD_COUNT, 0) AS OLD_COUNT
                           , NVL(SX1.OLD_COUNT1, 0) AS OLD_COUNT1
                           , NVL(SX1.DISABILITY_COUNT, 0) AS DISABILITY_COUNT
                           , NVL(SX1.WOMAN_COUNT, 0) AS WOMAN_COUNT
                           , NVL(SX1.CHILD_COUNT, 0) AS CHILD_COUNT
                           , NVL(SX1.BIRTH_COUNT, 0) AS BIRTH_COUNT -- ���/�Ծ���;
                           , NVL(SX1.MANY_CHILD_DED_COUNT, 0) AS MANY_CHILD_DED_COUNT
                           , NVL(SX1.SINGLE_PARENT_COUNT, 0) AS SINGLE_PARENT_COUNT  -- 2013�� �߰� : �Ѻθ�������  
                        FROM HRM_PERSON_MASTER PM
                          , (  
                              SELECT HSF.YEAR_YYYY
                                   , HSF.PERSON_ID
                                   , HSF.SOB_ID
                                   , HSF.ORG_ID
                                   , SUM(CASE
                                            WHEN HSF.BASE_YN = 'Y' AND HSF.RELATION_CODE = '0' THEN 1
                                            ELSE 0
                                          END) AS PERSON_COUNT  -- ����--
                                   , SUM(CASE
                                            WHEN HSF.BASE_YN = 'Y' AND HSF.RELATION_CODE = '3' THEN 1
                                            ELSE 0
                                          END) AS SPOUSE_COUNT  -- �����--
                                   , SUM(CASE
                                            WHEN HSF.BASE_YN = 'Y' AND HSF.RELATION_CODE NOT IN ('0', '3') THEN 1
                                            ELSE 0
                                          END) AS SUPPORT_COUNT  -- �ξ簡�� -- 
                                   -- �߰����� -- 
                                   , SUM(DECODE(HSF.OLD_YN, 'Y', 1, 0)) AS OLD_COUNT
                                   , SUM(DECODE(HSF.OLD1_YN, 'Y', 1, 0)) AS OLD_COUNT1
                                   , SUM(CASE
                                            WHEN HSF.BASE_YN = 'Y' AND HSF.DISABILITY_YN = 'Y' THEN 1
                                            ELSE 0
                                          END) AS DISABILITY_COUNT  -- �����  
                                   , SUM(CASE
                                            WHEN HSF.SINGLE_PARENT_DED_YN = 'Y' THEN 0
                                            WHEN HSF.WOMAN_YN = 'Y' THEN 1 
                                            ELSE 0
                                          END) AS WOMAN_COUNT  -- �γ��� : �Ѻθ����� ��� �Ѻθ��� ����  
                                   , SUM(DECODE(HSF.CHILD_YN, 'Y', 1, 0)) AS CHILD_COUNT  -- �ڳ����  
                                   , SUM(DECODE(HSF.BIRTH_YN, 'Y', 1, 0)) AS BIRTH_COUNT -- ���/�Ծ���;
                                   , SUM(CASE
                                            WHEN HSF.BASE_YN = 'Y' AND HSF.RELATION_CODE = '4' AND
                                                 EAPP_REGISTER_AGE_F(HSF.REPRE_NUM, P_STD_DATE, 0) <= V_MANY_CHILD_DED_AGE THEN 1
                                            ELSE 0
                                          END) MANY_CHILD_DED_COUNT  -- ���ڳ�  
                                    , SUM(DECODE(HSF.SINGLE_PARENT_DED_YN, 'Y', 1, 0)) AS SINGLE_PARENT_COUNT -- �Ѻθ�������;
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
      -- ���ڳడ�� �߰�����  
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
      V_SUPP_FAMILY_AMT := C1.PERSON_DED_AMT * C1.PERSON_COUNT; -- ���� ;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.SPOUSE_DED_AMT * C1.SPOUSE_COUNT); -- �����;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.SUPPORT_DED_AMT * C1.SUPPORT_COUNT); -- �ξ簡��;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.OLD_DED_AMT * C1.OLD_COUNT); -- �߰�-��ο��;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.OLD_DED1_AMT * C1.OLD_COUNT1); -- �߰�-��ο��1;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.DISABILITY_DED_AMT * C1.DISABILITY_COUNT); -- �߰�-�����;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.WOMAN_DED_AMT * C1.WOMAN_COUNT); -- �߰�-�γ༼�� ;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.BRING_CHILD_DED_AMT * C1.CHILD_COUNT); -- �߰�-�ڳ������;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.BIRTH_DED_AMT * C1.BIRTH_COUNT); -- �߰�-���/�Ծ���;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + V_MANY_CHILD_DED; -- �߰�-���ڳడ��;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.SINGLE_PARENT_DED_AMT * C1.SINGLE_PARENT_COUNT); -- �߰�-�Ѻθ�������;

      --> �������� UPDATE 
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
           , HA.SINGLE_PARENT_DED_AMT = NVL(C1.SINGLE_PARENT_DED_AMT, 0) * C1.SINGLE_PARENT_COUNT -- �߰�-�Ѻθ�������;
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

  -- 5. ����� ����;
  FUNCTION ETC_INSUR_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_TOTAL_INSUR_AMT  NUMBER := 0; -- ��Ÿ���� �� �հ� 
    V_ETC_INSUR_AMT    NUMBER := 0; -- ���强����� ���� 
    V_DISABILITY_INSUR_AMT NUMBER := 0; -- ��ֺ���� ���� 
  BEGIN
    O_STATUS := 'F';
    -- �������� ó������ �� ����� ���� �׸�--
    FOR C1 IN (SELECT HIT.YEAR_YYYY
                    , NVL(HIT.ETC_INSUR_LMT, 0) AS ETC_INSUR_LMT
                    , NVL(HIT.DISABILITY_INSUR_LMT, 0) AS DISABILITY_INSUR_LMT
                    --> �����--
                    , NVL(HSF1.ETC_ANNU_INSURE_AMT, 0) ETC_ANNU_INSURE_AMT
                    , NVL(HSF1.ETC_HIRE_MEDIC_INSURE_AMT, 0) ETC_HIRE_MEDIC_INSURE_AMT
                    , NVL(HSF2.INSURE_SUM, 0) GUAR_INSURE_AMT
                    , NVL(HSF2.DISABILITY_INSURE_SUM, 0) DISABILITY_INSURE_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --> ��������ڷ� ��ȸ  
                      SELECT HF.YEAR_YYYY
                           , HF.PERSON_ID
                           , HF.SOB_ID
                           , HF.ORG_ID
                           , HF.ANNU_INSUR_AMT AS ETC_ANNU_INSURE_AMT    -- ��Ÿ���ݺ���.
                           , HF.HIRE_MEDIC_INSUR_AMT AS ETC_HIRE_MEDIC_INSURE_AMT    -- ��Ÿ����Ƿ�.
                        FROM HRA_FOUNDATION HF
                      WHERE HF.YEAR_YYYY     = P_YEAR_YYYY
                        AND HF.PERSON_ID     = P_PERSON_ID
                        AND HF.SOB_ID        = P_SOB_ID
                        AND HF.ORG_ID        = P_ORG_ID
                     ) HSF1
                   , ( --  �ξ簡�� ���强 �����, ��ֺ���� ��ȸ 
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
      -- ���庸�� �ѵ� ����
      IF C1.ETC_INSUR_LMT < C1.GUAR_INSURE_AMT THEN
        V_ETC_INSUR_AMT := C1.ETC_INSUR_LMT;
      ELSE
        V_ETC_INSUR_AMT := C1.GUAR_INSURE_AMT;
      END IF;
      -- ��ֺ��� �ѵ� ����  
      IF C1.DISABILITY_INSUR_LMT < C1.DISABILITY_INSURE_AMT THEN
        V_DISABILITY_INSUR_AMT := C1.DISABILITY_INSUR_LMT;
      ELSE
        V_DISABILITY_INSUR_AMT := C1.DISABILITY_INSURE_AMT;
      END IF;
      V_TOTAL_INSUR_AMT := V_ETC_INSUR_AMT + V_DISABILITY_INSUR_AMT +
                           C1.ETC_ANNU_INSURE_AMT +
                           C1.ETC_HIRE_MEDIC_INSURE_AMT;

      --> ����� UPDATE 
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

  -- 6. �Ƿ�� ����;
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
    V_MED_TOTAL_AMT       NUMBER := 0;  -- �Ƿ�� �� ���� 
    V_MED_PER_AMT         NUMBER := 0;  -- �Ƿ�� ����/�����/��� ������        
    V_MED_SUPP_AMT        NUMBER := 0;  -- �Ƿ�� �ξ簡�� 
    
    V_DISABILITY_MED_AMT  NUMBER := 0;  -- �Ƿ�� ���� : �����  
    V_ETC_MEDIC_AMT       NUMBER := 0;  -- �Ƿ�� ���� : ��Ÿ  
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.MEDIC_DED_STD, 0) AS MEDIC_DED_STD
                    , NVL(HIT.MEDIC_DED_LMT, 0) AS MEDIC_DED_LMT
                    --> �Ƿ��                           
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
      -- ���ΰ��� 
      V_MED_PER_AMT := C1.PER_MEDI_SUM + C1.OLD_MEDI_SUM + C1.DISABILITY_MEDI_SUM;
          
      -- �ξ簡�� ����  
      V_MED_SUPP_AMT := C1.SUPP_MEDI_SUM - TRUNC(P_TOTAL_PAY * (C1.MEDIC_DED_STD / 100));
      IF C1.MEDIC_DED_LMT < V_MED_SUPP_AMT THEN
        V_MED_SUPP_AMT := C1.MEDIC_DED_LMT;
      END IF;    
      
      -- �Ƿ�� ���� ���   
      V_MED_TOTAL_AMT := V_MED_PER_AMT + V_MED_SUPP_AMT;
      IF V_MED_TOTAL_AMT < 0 THEN
        V_MED_TOTAL_AMT := 0;
      END IF;
      
      -- 2013.12.31 ��ȣ�� �߰� : ����� �Ƿ��� ��Ÿ �Ƿ�� ���� -- 
      V_DISABILITY_MED_AMT := C1.DISABILITY_MEDI_SUM;
      V_ETC_MEDIC_AMT      := 0;
      IF NVL(V_DISABILITY_MED_AMT, 0) < NVL(V_MED_TOTAL_AMT, 0) THEN
        V_ETC_MEDIC_AMT      := NVL(V_MED_TOTAL_AMT, 0) - NVL(V_DISABILITY_MED_AMT, 0);
      ELSE
        V_DISABILITY_MED_AMT := NVL(V_MED_TOTAL_AMT, 0);
      END IF;
    END LOOP C1;
    
    --> �Ƿ�� UPDATE 
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

  -- 7. ������ ����;
  FUNCTION EDUCATION_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_EDU_TOTAL_AMT       NUMBER := 0;  -- �� ������ 
    V_PER_EDU_AMT         NUMBER := 0;  -- ������ ���� : ���� ������  
    V_DISABILITY_EDU_AMT  NUMBER := 0;  -- ������ ���� : ����� ������  
    V_CHILD_EDU_AMT       NUMBER := 0;  -- ������ ���� : ������ �Ƶ� ������  
    V_HIGH_EDU_AMT        NUMBER := 0;  -- ������ ���� : ���߰� ������  
    V_COLL_EDU_AMT        NUMBER := 0;  -- ������ ���� : ���б� ������  
    
    V_DISABILITY_EDU_SUM  NUMBER := 0;  -- ������ ���� ���� : ����� ������    
    V_ETC_EDU_SUM         NUMBER := 0;  -- ������ ���� ���� : ��Ÿ  
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.PER_EDU, 0) AS PER_EDU
                    , NVL(HIT.KIND_EDU, 0) AS KIND_EDU
                    , NVL(HIT.STUD_EDU, 0) AS STUD_EDU
                    , NVL(HIT.UNIV_EDU, 0) AS UNIV_EDU
                    --> ������         
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
      -- ���ΰ��� 
      IF C1.PER_EDU < C1.PER_EDU_AMT THEN
        V_PER_EDU_AMT := C1.PER_EDU;
      ELSE
        V_PER_EDU_AMT := C1.PER_EDU_AMT;
      END IF;
      -- ����� ����  
      IF C1.PER_EDU < C1.DISABILITY_EDU_AMT THEN
        V_DISABILITY_EDU_AMT := C1.PER_EDU;
      ELSE
        V_DISABILITY_EDU_AMT := C1.DISABILITY_EDU_AMT;
      END IF;
      -- ������ �Ƶ� ����  
      IF C1.KIND_EDU < C1.CHILD_EDU_AMT THEN
        V_CHILD_EDU_AMT := C1.KIND_EDU;
      ELSE
        V_CHILD_EDU_AMT := C1.CHILD_EDU_AMT;
      END IF;
      -- ���߰� ����  
      IF C1.STUD_EDU < C1.HIGH_EDU_AMT THEN
        V_HIGH_EDU_AMT := C1.STUD_EDU;
      ELSE
        V_HIGH_EDU_AMT := C1.HIGH_EDU_AMT;
      END IF;
      -- ���л� ����  
      IF C1.UNIV_EDU < C1.COLL_EDU_AMT THEN
        V_COLL_EDU_AMT := C1.UNIV_EDU;
      ELSE
        V_COLL_EDU_AMT := C1.COLL_EDU_AMT;
      END IF;
      
      -- 2013.12.31 ��ȣ�� �߰� : ����� ������ ���� -- 
      V_DISABILITY_EDU_SUM := NVL(V_DISABILITY_EDU_SUM, 0) + NVL(V_DISABILITY_EDU_AMT, 0);
      
      -- ������ �հ� 
      V_EDU_TOTAL_AMT := NVL(V_EDU_TOTAL_AMT, 0) + NVL(V_PER_EDU_AMT, 0) + NVL(V_DISABILITY_EDU_AMT, 0) +
                         NVL(V_CHILD_EDU_AMT, 0) + NVL(V_HIGH_EDU_AMT, 0) + NVL(V_COLL_EDU_AMT, 0); 
    END LOOP C1;
    
    -- 2013.12.31 ��ȣ�� �߰� : ����� �Ƿ��� ��Ÿ �Ƿ�� ���� -- 
    V_ETC_EDU_SUM          := 0;
    IF NVL(V_DISABILITY_EDU_SUM, 0) < NVL(V_EDU_TOTAL_AMT, 0) THEN
      V_ETC_EDU_SUM        := NVL(V_EDU_TOTAL_AMT, 0) - NVL(V_DISABILITY_EDU_SUM, 0);
    ELSE
      V_DISABILITY_EDU_SUM := NVL(V_EDU_TOTAL_AMT, 0);
    END IF;     
      
    --> ������  UPDATE 
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

  -- 8-1. �����ڱ� ����(�����������Աݿ����ݻ�ȯ��);
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
    V_HOUSE_INTER_AMT             NUMBER := 0;  -- �����������Աݿ����ݻ�ȯ(40%);
    
    V_HOUSE_INTER_TOT_AMT_ETC     NUMBER := 0;  -- �����������Աݿ����ݻ�ȯ(40%) �Ѵ���;
    V_HOUSE_INTER_AMT_ETC         NUMBER := 0;  -- �����������Աݿ����ݻ�ȯ(40%) ������;
  BEGIN
    O_STATUS := 'F';
    -- �����������Ա� ������ ��ȯ�� : ������ -- 
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.HOUSE_INTER_RATE, 0) HOUSE_INTER_RATE  -- �����������Ա� �����ݻ�ȯ�� ������;
                    , NVL(HIT.HOUSE_AMT_LMT, 0) HOUSE_AMT_LMT  -- -- �����ڱ� �ѵ�;
                    
                    --> �����ڱ�;
                    , NVL(HF1.HOUSE_ADD_AMT, 0) HOUSE_ADD_AMT  -- �����������Ա� �����ݻ�ȯ�װ���;
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
      -- �����������Աݿ����ݻ�ȯ��; 
      V_HOUSE_INTER_AMT := TRUNC(C1.HOUSE_ADD_AMT * (C1.HOUSE_INTER_RATE / 100));
      IF NVL(C1.HOUSE_AMT_LMT, 0) < NVL(V_HOUSE_INTER_AMT, 0) THEN
        V_HOUSE_INTER_AMT := NVL(C1.HOUSE_AMT_LMT, 0);
      END IF;
      
      --> �����ڱ�   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.HOUSE_FUND_AMT        = NVL(HA.HOUSE_FUND_AMT, 0) + NVL(V_HOUSE_INTER_AMT, 0)
           , HA.HOUSE_INTER_AMT       = NVL(V_HOUSE_INTER_AMT, 0)
       WHERE HA.YEAR_YYYY             = P_YEAR_YYYY
         AND HA.PERSON_ID             = P_PERSON_ID
         AND HA.SOB_ID                = P_SOB_ID
         AND HA.ORG_ID                = P_ORG_ID
      ;      
    END LOOP C1;
    
    -- �����������Ա� ������ ��ȯ�� : ������ -- 
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.HOUSE_INTER_RATE, 0) AS HOUSE_INTER_RATE  -- �����������Ա� �����ݻ�ȯ�� ������;
                    , NVL(HIT.HOUSE_AMT_LMT, 0) AS HOUSE_AMT_LMT  -- -- �����ڱ� �ѵ�;
                    
                    --> �����ڱ�;
                    , HF1.HOUSE_LEASE_ID 
                    , NVL(HF1.LOAN_AMT, 0) AS LOAN_AMT  -- �����������Ա� �����ݻ�ȯ�װ��� : ������;
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , (SELECT HLI.HOUSE_LEASE_ID 
                            , HLI.YEAR_YYYY
                            , HLI.PERSON_ID
                            , HLI.SOB_ID
                            , HLI.ORG_ID
                            , HLI.LEASE_TERM_FR
                            , NVL(HLI.LOAN_AMT, 0) + NVL(HLI.LOAN_INTEREST_AMT, 0) AS LOAN_AMT
                          FROM HRA_HOUSE_LEASE_INFO HLI  
                        WHERE HLI.HOUSE_LEASE_TYPE  = '20'  -- �����������Ա� ������ ��ȯ�� : ������  
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
      -- �����������Աݿ����ݻ�ȯ��; 
      V_HOUSE_INTER_AMT_ETC := TRUNC(C1.LOAN_AMT * (C1.HOUSE_INTER_RATE / 100));
      IF NVL(C1.HOUSE_AMT_LMT, 0) < (NVL(V_HOUSE_INTER_AMT, 0) + 
                                     NVL(V_HOUSE_INTER_TOT_AMT_ETC, 0) + 
                                     NVL(V_HOUSE_INTER_AMT_ETC, 0)) THEN
        V_HOUSE_INTER_AMT_ETC := NVL(C1.HOUSE_AMT_LMT, 0) - 
                                 NVL(V_HOUSE_INTER_AMT, 0) - 
                                 NVL(V_HOUSE_INTER_TOT_AMT_ETC, 0);
      END IF;
      -- �Ѵ��� -- 
      V_HOUSE_INTER_TOT_AMT_ETC := NVL(V_HOUSE_INTER_TOT_AMT_ETC, 0) + NVL(V_HOUSE_INTER_AMT_ETC, 0);
      
      -- �����ݾ� UPDATE -- 
      UPDATE HRA_HOUSE_LEASE_INFO HLI
         SET HLI.HOUSE_DED_AMT      = V_HOUSE_INTER_AMT_ETC
       WHERE HLI.HOUSE_LEASE_ID     = C1.HOUSE_LEASE_ID
      ;
    END LOOP C1;
    
    --> �����ڱ�   UPDATE : �����������Ա� ������ ��ȯ�� - ������ -- 
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

  -- 8-2. �����ڱ� ����(�����ҵ����);
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
    V_HOUSE_MONTHLY_AMT           NUMBER := 0;  -- �����ҵ�����ݾ�.
    V_HOUSE_MONTHLY_TOT_AMT       NUMBER := 0;  -- �����ҵ���� �����ݾ�.
    V_HOUSE_TOT_DED_AMT           NUMBER := 0;  -- �����ڱ� ���������ݾ�.
  BEGIN
    O_STATUS := 'F';
    BEGIN
      -- �����ڱݰ����ݾ� => �ѵ� ���� ����;
      SELECT NVL(YA.HOUSE_INTER_AMT, 0) +
             NVL(YA.HOUSE_INTER_AMT_ETC, 0) AS HOUSE_DED_AMT  -- �����������Ա� �����ݻ�ȯ�װ���(������ + ������);
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
                    , NVL(HIT.HOUSE_AMT_LMT, 0) AS HOUSE_AMT_LMT  -- -- �����ڱ� �ѵ�;
                    , NVL(HIT.HOUSE_MONTHLY_STD, 0) AS HOUSE_MONTHLY_STD  -- �����ҵ���رݾ�.
                    , NVL(HIT.HOUSE_MONTHLY_RATE, 0) AS HOUSE_MONTHLY_RATE  -- �����ҵ������.
                    
                    --> �����ڱ�;
                    , HF1.HOUSE_LEASE_ID 
                    , NVL(HF1.MONTLY_LEASE_AMT, 0) AS HOUSE_MONTHLY_AMT  -- �����ҵ����;
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( SELECT HLI.HOUSE_LEASE_ID 
                            , HLI.YEAR_YYYY
                            , HLI.PERSON_ID
                            , HLI.SOB_ID
                            , HLI.ORG_ID
                            , HLI.LEASE_TERM_FR
                            , HLI.MONTLY_LEASE_AMT  -- ������  
                          FROM HRA_HOUSE_LEASE_INFO HLI  
                        WHERE HLI.HOUSE_LEASE_TYPE  = '10'  -- ����  
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
      -- ���ҵ�ٷ��� �����ҵ����;
      V_HOUSE_MONTHLY_AMT := 0;
      
      -- ���ø������� �� �����������Ա� �ҵ�����ݾ� �հ�� ����;
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
        
        -- �����ݾ� UPDATE -- 
        UPDATE HRA_HOUSE_LEASE_INFO HLI
           SET HLI.HOUSE_DED_AMT      = V_HOUSE_MONTHLY_AMT
         WHERE HLI.HOUSE_LEASE_ID     = C1.HOUSE_LEASE_ID
        ;
      END IF;            
    END LOOP C1;
    
    --> �����ڱ�   UPDATE 
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
            
  -- 8-3. �����ڱ� ����(����������ڻ�ȯ��);
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
    V_HOUSE_DED_AMT               NUMBER := 0;  -- ���ø����������;
    V_TOTAL_HOUSE_DED_AMT         NUMBER := 0;  -- ���ð��� ���������ݾ�.
    
    V_LONG_HOUSE_PROF_AMT         NUMBER := 0;  -- ��������������Ա����ڻ�ȯ��(10��)
    V_LONG_HOUSE_PROF_AMT_1       NUMBER := 0;  -- ��������������Ա����ڻ�ȯ��(15��)
    V_LONG_HOUSE_PROF_AMT_2       NUMBER := 0;  -- ��������������Ա����ڻ�ȯ��(30��)
    V_LONG_HOUSE_PROF_AMT_3_FIX   NUMBER := 0;  -- ��������������Ա����ڻ�ȯ��(2012�� ���� �����ݸ���)
    V_LONG_HOUSE_PROF_AMT_3_ETC   NUMBER := 0;  -- ��������������Ա����ڻ�ȯ��(2012�� ���� ��Ÿ)
  BEGIN
    BEGIN
      -- ����������� ���Ա� ���ڻ�ȯ�����ݾ� => �ѵ� ���� ����;
      SELECT NVL(YA.HOUSE_INTER_AMT, 0) + NVL(YA.HOUSE_INTER_AMT_ETC, 0) +    -- �����������̱ݿ����ݻ�ȯ�װ���(������ + ������);
             NVL(YA.HOUSE_MONTHLY_AMT, 0) +                                   -- ������;
             NVL(YA.HOUSE_APP_DEPOSIT_AMT, 0) +                               -- ����û������(��);
             NVL(YA.HOUSE_APP_SAVE_AMT, 0) +                                  -- ����û����������(��);
             NVL(YA.HOUSE_SAVE_AMT, 0) +                                      -- ������ø������������(��);
             NVL(YA.WORKER_HOUSE_SAVE_AMT, 0) AS HOUSE_DED_AMT  -- �ٷ������ø�������(��) ;
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
                    , NVL(HIT.LONG_HOUSE_PROF_LMT, 0) LONG_HOUSE_PROF_LMT  -- ��������������Ա����ڻ�ȯ�� �ѵ�(10);
                    , NVL(HIT.HOUSE_TOTAL_LMT, 0) HOUSE_TOTAL_LMT  -- ��������������Ա����ڻ�ȯ�� ���ѵ�(10);
                    , NVL(HIT.LONG_HOUSE_PROF_LMT_1, 0) LONG_HOUSE_PROF_LMT_1  -- ��������������Ա����ڻ�ȯ�� �ѵ�(15);
                    , NVL(HIT.HOUSE_TOTAL_LMT_1, 0) HOUSE_TOTAL_LMT_1  -- ��������������Ա����ڻ�ȯ�� ���ѵ�(15);
                    , NVL(HIT.LONG_HOUSE_PROF_LMT_2, 0) LONG_HOUSE_PROF_LMT_2  -- ��������������Ա����ڻ�ȯ�� �ѵ�(30);
                    , NVL(HIT.HOUSE_TOTAL_LMT_2, 0) HOUSE_TOTAL_LMT_2  -- ��������������Ա����ڻ�ȯ�� ���ѵ�(30);
                    
                    , NVL(HIT.LONG_HOUSE_PROF_LMT_3_FIX, 0) LONG_HOUSE_PROF_LMT_3_FIX  -- ��������������Ա� ���ڻ�ȯ��(2012�� ���� - �����ݸ���);
                    , NVL(HIT.HOUSE_TOTAL_LMT_3_FIX, 0) HOUSE_TOTAL_LMT_3_FIX  -- �����ڱ� �Ѱ����ѵ�(2012�� ���� - �����ݸ���);
                    , NVL(HIT.LONG_HOUSE_PROF_LMT_3_ETC, 0) LONG_HOUSE_PROF_LMT_3_ETC  -- ��������������Ա� ���ڻ�ȯ��(2012�� ���� - ��Ÿ);
                    , NVL(HIT.HOUSE_TOTAL_LMT_3_ETC, 0) HOUSE_TOTAL_LMT_3_ETC  -- �����ڱ� �Ѱ����ѵ�(2012�� ���� - ��Ÿ);
                    
                    --> �����ڱ�;
                    , NVL(HF1.LONG_HOUSE_INTER_AMT, 0) LONG_HOUSE_INTER_AMT  -- ��������������Ա����ڻ�ȯ��(10);
                    , NVL(HF1.LONG_HOUSE_INTER_AMT_1, 0) LONG_HOUSE_INTER_AMT_1  -- ��������������Ա����ڻ�ȯ��(15);
                    , NVL(HF1.LONG_HOUSE_INTER_AMT_2, 0) LONG_HOUSE_INTER_AMT_2  -- ��������������Ա����ڻ�ȯ��(30);
                    , NVL(HF1.LONG_HOUSE_INTER_AMT_3_FIX, 0) AS LONG_HOUSE_INTER_AMT_3_FIX  -- ��������������Ա� ���ڻ�ȯ��(2012�� ���� - �����ݸ���);
                    , NVL(HF1.LONG_HOUSE_INTER_AMT_3_ETC, 0) AS LONG_HOUSE_INTER_AMT_3_ETC  -- ��������������Ա� ���ڻ�ȯ��(2012�� ���� - ��Ÿ);
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
      -- ��������������Ա� ���ڻ�ȯ�װ���(10��) ; 
      IF NVL(C1.LONG_HOUSE_INTER_AMT, 0) > 0 THEN
        -- 600���� �ѵ� ���;
        V_LONG_HOUSE_PROF_AMT := NVL(C1.LONG_HOUSE_INTER_AMT, 0);
        IF NVL(C1.LONG_HOUSE_PROF_LMT, 0) < NVL(V_LONG_HOUSE_PROF_AMT, 0) THEN
          V_LONG_HOUSE_PROF_AMT := NVL(C1.LONG_HOUSE_PROF_LMT, 0);
        END IF;
        -- �� �����ڱ� �ѵ� ����(600��); 
        IF NVL(C1.HOUSE_TOTAL_LMT, 0) < (NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT, 0)) THEN
          V_LONG_HOUSE_PROF_AMT := NVL(C1.HOUSE_TOTAL_LMT, 0) - NVL(V_TOTAL_HOUSE_DED_AMT, 0);
        END IF;
        V_TOTAL_HOUSE_DED_AMT := NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT, 0);
      END IF;
      
      -- ��������������Ա� ���ڻ�ȯ�װ���(15��) ; 
      IF NVL(C1.LONG_HOUSE_INTER_AMT_1, 0) > 0 THEN
        -- 1,000���� �ѵ� ���;
        V_LONG_HOUSE_PROF_AMT_1 := NVL(C1.LONG_HOUSE_INTER_AMT_1, 0);
        IF NVL(C1.LONG_HOUSE_PROF_LMT_1, 0) < NVL(V_LONG_HOUSE_PROF_AMT_1, 0) THEN
          V_LONG_HOUSE_PROF_AMT_1 := NVL(C1.LONG_HOUSE_PROF_LMT_1, 0);
        END IF;
        -- �� �����ڱ� �ѵ� ����(1,000��); 
        IF NVL(C1.HOUSE_TOTAL_LMT_1, 0) < (NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT_1, 0)) THEN
          V_LONG_HOUSE_PROF_AMT_1 := NVL(C1.HOUSE_TOTAL_LMT_1, 0) - NVL(V_TOTAL_HOUSE_DED_AMT, 0);
        END IF;
        V_TOTAL_HOUSE_DED_AMT := NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT_1, 0);
      END IF;
      
      -- ��������������Ա� ���ڻ�ȯ�װ���(30��) ; 
      IF NVL(C1.LONG_HOUSE_INTER_AMT_2, 0) > 0 THEN 
        -- 1,500���� �ѵ� ���;
        V_LONG_HOUSE_PROF_AMT_2 := NVL(C1.LONG_HOUSE_INTER_AMT_2, 0);
        IF NVL(C1.LONG_HOUSE_PROF_LMT_2, 0) < NVL(V_LONG_HOUSE_PROF_AMT_2, 0) THEN
          V_LONG_HOUSE_PROF_AMT_2 := NVL(C1.LONG_HOUSE_PROF_LMT_2, 0);
        END IF;
        -- �� �����ڱ� �ѵ� ����(1,500��); 
        IF NVL(C1.HOUSE_TOTAL_LMT_2, 0) < (NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT_2, 0)) THEN
          V_LONG_HOUSE_PROF_AMT_2 := NVL(C1.HOUSE_TOTAL_LMT_2, 0) - NVL(V_TOTAL_HOUSE_DED_AMT, 0);
        END IF;
        V_TOTAL_HOUSE_DED_AMT := NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT_2, 0);
      END IF;
      
      -- ��������������Ա� ���ڻ�ȯ��(2012�� ���� - �����ݸ���);
      IF NVL(C1.LONG_HOUSE_INTER_AMT_3_FIX, 0) > 0 THEN 
        V_LONG_HOUSE_PROF_AMT_3_FIX := NVL(C1.LONG_HOUSE_INTER_AMT_3_FIX, 0);
        IF NVL(C1.LONG_HOUSE_PROF_LMT_3_FIX, 0) < NVL(V_LONG_HOUSE_PROF_AMT_3_FIX, 0) THEN
          V_LONG_HOUSE_PROF_AMT_3_FIX := NVL(C1.LONG_HOUSE_PROF_LMT_3_FIX, 0);
        END IF;
        -- �� �����ڱ� �ѵ� ����; 
        IF NVL(C1.HOUSE_TOTAL_LMT_3_FIX, 0) < (NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT_3_FIX, 0)) THEN
          V_LONG_HOUSE_PROF_AMT_3_FIX := NVL(C1.HOUSE_TOTAL_LMT_3_FIX, 0) - NVL(V_TOTAL_HOUSE_DED_AMT, 0);
        END IF;
        V_TOTAL_HOUSE_DED_AMT := NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT_3_FIX, 0);
      END IF;
      
      -- ��������������Ա� ���ڻ�ȯ��(2012�� ���� - ��Ÿ);
      IF NVL(C1.LONG_HOUSE_INTER_AMT_3_ETC, 0) > 0 THEN 
        V_LONG_HOUSE_PROF_AMT_3_ETC := NVL(C1.LONG_HOUSE_INTER_AMT_3_ETC, 0);
        IF NVL(C1.LONG_HOUSE_PROF_LMT_3_ETC, 0) < NVL(V_LONG_HOUSE_PROF_AMT_3_ETC, 0) THEN
          V_LONG_HOUSE_PROF_AMT_3_ETC := NVL(C1.LONG_HOUSE_PROF_LMT_3_ETC, 0);
        END IF;
        -- �� �����ڱ� �ѵ� ����; 
        IF NVL(C1.HOUSE_TOTAL_LMT_3_ETC, 0) < (NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT_3_ETC, 0)) THEN
          V_LONG_HOUSE_PROF_AMT_3_ETC := NVL(C1.HOUSE_TOTAL_LMT_3_ETC, 0) - NVL(V_TOTAL_HOUSE_DED_AMT, 0);
        END IF;
        V_TOTAL_HOUSE_DED_AMT := NVL(V_TOTAL_HOUSE_DED_AMT, 0) + NVL(V_LONG_HOUSE_PROF_AMT_3_ETC, 0);
      END IF;
      
      --> �����ڱ�   UPDATE 
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
            
  -- 8-4. ���ø�������ҵ����;
  FUNCTION HOUSE_SAVE_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_HOUSE_DED_AMT               NUMBER := 0;  -- �����ڱ� ���������ݾ�.
    V_TOTAL_AMT                   NUMBER := 0;  -- ���ø�������ҵ���� �����ݾ�.
    
    V_SUM_HOUSE_SAVING_AMT        NUMBER := 0;  -- ����û������(��) �����ݾ�.
    V_SUM_HOUSE_SAVING_ALL_AMT    NUMBER := 0;  -- ����û����������(��) �����ݾ�.
    V_SUM_LONG_HOUSE_SAVING_AMT   NUMBER := 0;  -- ������ø������������(��) �����ݾ�.
    V_SUM_WORKER_HOUSE_SAVING_AMT NUMBER := 0;  -- �ٷ������ø�������(��) �����ݾ�.
    
    V_HOUSE_SAVING_AMT            NUMBER := 0;  -- ����û������(��).
    V_HOUSE_SAVING_ALL_AMT        NUMBER := 0;  -- ����û����������(��).
    V_LONG_HOUSE_SAVING_AMT       NUMBER := 0;  -- ������ø������������(��).
    V_WORKER_HOUSE_SAVING_AMT     NUMBER := 0;  -- �ٷ������ø�������(��).
  BEGIN
    O_STATUS := 'F';
    BEGIN
      -- �����ڱݰ����ݾ� => �ѵ� ���� ����;
      SELECT ( NVL(YA.HOUSE_INTER_AMT, 0) + NVL(YA.HOUSE_INTER_AMT_ETC, 0)) +  -- �����������Ա� �����ݻ�ȯ�װ���(������ + ������) ;
             NVL(YA.HOUSE_MONTHLY_AMT, 0) AS HOUSE_DED_AMT -- �����װ���;
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
                    , NVL(HIT.HOUSE_SAVING_RATE, 0) AS HOUSE_SAVING_RATE  -- ���ø�������ҵ���� --
                    , NVL(HIT.HOUSE_SAVING_LMT, 0) AS HOUSE_SAVING_LMT    -- ���ø�������ҵ���� �ѵ� --
                    , NVL(HIT.WORKER_HOUSE_SAVING_RATE, 0) AS WORKER_HOUSE_SAVING_RATE  -- �ٷ������ø������� ���� --
                    , NVL(HIT.WORKER_HOUSE_SAVING_LMT, 0) AS WORKER_HOUSE_SAVING_LMT  -- �ٷ������ø������� ���� �ѵ� -- 
                    , NVL(HIT.LONG_HOUSE_SAVING_RATE, 0) AS LONG_HOUSE_SAVING_RATE  -- ������ø������� ���� -- 
                    , NVL(HIT.LONG_HOUSE_SAVING_LMT, 0) AS LONG_HOUSE_SAVING_LMT  -- ������ø������� ���� �ѵ� --
                    , NVL(HIT.HOUSE_SAVING_ALL_RATE, 0) AS HOUSE_SAVING_ALL_RATE  -- ����û���������� ���� --
                    , NVL(HIT.HOUSE_SAVING_ALL_LMT, 0) AS HOUSE_SAVING_ALL_LMT  -- ����û���������� ���� �ѵ� --
                    , NVL(HIT.HOUSE_AMT_LMT, 0) AS HOUSE_AMT_LMT  -- ��ü �ѵ� --
                    --> ���ø�������ݾ�.
                    , HF1.SAVING_INFO_ID
                    , HF1.SAVING_TYPE
                    , NVL(HF1.SAVING_AMOUNT, 0) HOUSE_SAVE_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , (--  �������� �����ڷ�  ��ȸ  
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
                        AND HSI.SAVING_TYPE             IN ('31', '32', '33', '34')  -- ��������.
                     ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
               ) 
    LOOP
      V_HOUSE_SAVING_AMT            := 0;  -- ����û������(��).
      V_HOUSE_SAVING_ALL_AMT        := 0;  -- ����û����������(��).
      V_LONG_HOUSE_SAVING_AMT       := 0;  -- ������ø������������(��).
      V_WORKER_HOUSE_SAVING_AMT     := 0;  -- �ٷ������ø�������(��).
      IF C1.SAVING_TYPE = '31' THEN
        -- ����û������(��).
        V_HOUSE_SAVING_AMT := TRUNC(NVL(C1.HOUSE_SAVE_AMT, 0) * (NVL(C1.HOUSE_SAVING_RATE, 0) / 100));
        IF NVL(C1.HOUSE_SAVING_LMT, 0) < NVL(V_SUM_HOUSE_SAVING_AMT, 0) + NVL(V_HOUSE_SAVING_AMT, 0) THEN
          V_HOUSE_SAVING_AMT := NVL(C1.HOUSE_SAVING_LMT, 0) - NVL(V_SUM_HOUSE_SAVING_AMT, 0);
        END IF;
        IF NVL(C1.HOUSE_AMT_LMT, 0) < NVL(V_TOTAL_AMT, 0) + NVL(V_HOUSE_SAVING_AMT, 0) THEN
          V_HOUSE_SAVING_AMT := NVL(C1.HOUSE_AMT_LMT, 0) - NVL(V_TOTAL_AMT, 0);
        END IF;
        V_TOTAL_AMT := NVL(V_TOTAL_AMT, 0) + NVL(V_HOUSE_SAVING_AMT, 0);
        V_SUM_HOUSE_SAVING_AMT := NVL(V_SUM_HOUSE_SAVING_AMT, 0) + NVL(V_HOUSE_SAVING_AMT, 0);  -- ����û������(��) �����ݾ�.
      ELSIF C1.SAVING_TYPE = '32' THEN
        -- ����û����������(��).
        V_HOUSE_SAVING_ALL_AMT := TRUNC(NVL(C1.HOUSE_SAVE_AMT, 0) * (NVL(C1.HOUSE_SAVING_ALL_RATE, 0) / 100));
        IF NVL(C1.HOUSE_SAVING_ALL_LMT, 0) < NVL(V_SUM_HOUSE_SAVING_ALL_AMT, 0) + NVL(V_HOUSE_SAVING_ALL_AMT, 0) THEN
          V_HOUSE_SAVING_ALL_AMT := NVL(C1.HOUSE_SAVING_ALL_LMT, 0) - NVL(V_SUM_HOUSE_SAVING_ALL_AMT, 0);
        END IF;
        IF NVL(C1.HOUSE_AMT_LMT, 0) < NVL(V_TOTAL_AMT, 0) + NVL(V_HOUSE_SAVING_ALL_AMT, 0) THEN
          V_HOUSE_SAVING_ALL_AMT := NVL(C1.HOUSE_AMT_LMT, 0) - NVL(V_TOTAL_AMT, 0);
        END IF;
        V_TOTAL_AMT := NVL(V_TOTAL_AMT, 0) + NVL(V_HOUSE_SAVING_ALL_AMT, 0);
        V_SUM_HOUSE_SAVING_ALL_AMT := NVL(V_SUM_HOUSE_SAVING_ALL_AMT, 0) + NVL(V_HOUSE_SAVING_ALL_AMT, 0);  -- ����û����������(��) �����ݾ�.
      ELSIF C1.SAVING_TYPE = '33' THEN
        -- ������ø������������(��).
        V_LONG_HOUSE_SAVING_AMT := TRUNC(NVL(C1.HOUSE_SAVE_AMT, 0) * (NVL(C1.LONG_HOUSE_SAVING_RATE , 0) / 100));
        IF NVL(C1.LONG_HOUSE_SAVING_LMT, 0) < NVL(V_SUM_LONG_HOUSE_SAVING_AMT, 0) + NVL(V_LONG_HOUSE_SAVING_AMT, 0) THEN
          V_LONG_HOUSE_SAVING_AMT := NVL(C1.LONG_HOUSE_SAVING_LMT, 0) - NVL(V_SUM_LONG_HOUSE_SAVING_AMT, 0);
        END IF;
        IF NVL(C1.HOUSE_AMT_LMT, 0) < NVL(V_TOTAL_AMT, 0) + NVL(V_LONG_HOUSE_SAVING_AMT, 0) THEN
          V_LONG_HOUSE_SAVING_AMT := NVL(C1.HOUSE_AMT_LMT, 0) - NVL(V_TOTAL_AMT, 0);
        END IF; 
        V_TOTAL_AMT := NVL(V_TOTAL_AMT, 0) + NVL(V_LONG_HOUSE_SAVING_AMT, 0);
        V_SUM_LONG_HOUSE_SAVING_AMT := NVL(V_SUM_LONG_HOUSE_SAVING_AMT, 0) + NVL(V_LONG_HOUSE_SAVING_AMT, 0);  -- ������ø������������(��) �����ݾ�.
      ELSIF C1.SAVING_TYPE = '34' THEN
        -- �ٷ������ø�������(��).
        V_WORKER_HOUSE_SAVING_AMT := TRUNC(NVL(C1.HOUSE_SAVE_AMT, 0) * (NVL(C1.WORKER_HOUSE_SAVING_RATE, 0) / 100));
        IF NVL(C1.WORKER_HOUSE_SAVING_LMT, 0) < NVL(V_SUM_WORKER_HOUSE_SAVING_AMT, 0) + NVL(V_WORKER_HOUSE_SAVING_AMT, 0) THEN
          V_WORKER_HOUSE_SAVING_AMT := NVL(C1.WORKER_HOUSE_SAVING_LMT, 0) - NVL(V_SUM_WORKER_HOUSE_SAVING_AMT, 0);
        END IF;
        IF NVL(C1.HOUSE_AMT_LMT, 0) < NVL(V_TOTAL_AMT, 0) + NVL(V_WORKER_HOUSE_SAVING_AMT, 0) THEN
          V_WORKER_HOUSE_SAVING_AMT := NVL(C1.HOUSE_AMT_LMT, 0) - NVL(V_TOTAL_AMT, 0);
        END IF; 
        V_TOTAL_AMT := NVL(V_TOTAL_AMT, 0) + NVL(V_WORKER_HOUSE_SAVING_AMT, 0);
        V_SUM_WORKER_HOUSE_SAVING_AMT := NVL(V_SUM_WORKER_HOUSE_SAVING_AMT, 0) + NVL(V_WORKER_HOUSE_SAVING_AMT, 0);  -- �ٷ������ø�������(��) �����ݾ�.
      END IF;
      -- ���ο������� �����ݾ� UPDATE.
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
    
    --> �����ڱ�   UPDATE 
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

  -- 9. ��α� ����
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
    V_DONAT_LMT                 NUMBER := 0;  -- ��α� �ѵ� ����;
    V_DONAT_TOTAL               NUMBER := 0;  -- ��α� �հ�;
    V_LAPSE_DONA_AMT            NUMBER := 0;  -- �Ҹ�ݾ�.
    V_NEXT_DONA_AMT             NUMBER := 0;  -- �̿��ݾ�.
    
    -- ��α� ���� �ݾ�;
    V_SUM_TAX_DED_POLI_AMT      NUMBER := 0; -- ���װ��� : ��� ��ġ�ڱ�
    V_SUM_DONAT_POLI            NUMBER := 0; -- ��ġ��α�; 
    V_SUM_DONAT_ALL             NUMBER := 0; -- ���� ��α�;  
    V_SUM_DONAT_50P             NUMBER := 0; -- ��α� 50% ; 
    V_SUM_DONAT_30P             NUMBER := 0; -- ��α� 30%;
    V_SUM_DONAT_10P             NUMBER := 0; -- ��α� 10% ;  
    V_SUM_DONAT_10P_RELIGION    NUMBER := 0; -- ��α� 10% ;  
    
    -- ��α� �̿��ݾ�    
    V_SUM_DONAT_NEXT_POLI       NUMBER := 0; -- ��ġ��α�; 
    V_SUM_DONAT_NEXT_ALL        NUMBER := 0; -- ���� ��α�;  
    V_SUM_DONAT_NEXT_50P        NUMBER := 0; -- ��α� 50% ; 
    V_SUM_DONAT_NEXT_30P        NUMBER := 0; -- ��α� 30%;
    V_SUM_DONAT_NEXT_10P        NUMBER := 0; -- ��α� 10% ;  
    V_SUM_DONAT_NEXT_10P_REL    NUMBER := 0; -- ��α� 10% ;
    
    -- �Ǽ���;
    V_TAX_DED_POLI_AMT          NUMBER := 0; -- ���װ��� : ��� ��ġ�ڱ�  
    V_DONAT_POLI                NUMBER := 0; -- ��ġ��α�; 
    V_DONAT_ALL                 NUMBER := 0; -- ���� ��α�;  
    V_DONAT_50P                 NUMBER := 0; -- ��α� 50% ; 
    V_DONAT_30P                 NUMBER := 0; -- ��α� 30%;
    V_DONAT_10P                 NUMBER := 0; -- ��α� 10% ;  
    V_DONAT_10P_RELIGION        NUMBER := 0; -- ��α� 10% ;  
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
      -- ���� ���� (�ѵ�)  ;
      V_DONAT_LMT := 0;
      V_DONAT_LMT := TRUNC(P_INCOME_AMT * (C1.DONAT_ALL_RATE / 100)); -- ���װ��� �ѵ�  
      
      -- 1. ��ġ�ڱ� ��α� ���� 
      -- ��αݾ��� 100,000�� �̸��� ��� ���׼��װ��� ������� '0' 
      -- ��αݾ��� 100,000�� �ʰ��� ��� MIN(��αݾ� - 100,000, �ٷμҵ�ݾ�) ����       
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
                    AND DA.DONA_TYPE              = '20'    -- ��ġ��α�  
                  ORDER BY DA.DONA_TYPE, DA.DONA_YYYY DESC
                 )
      LOOP
        V_TAX_DED_POLI_AMT := NVL(R1.TOTAL_DONA_AMT, 0);        
        IF NVL(C1.DONAT_POLI_MAX, 0) < (NVL(V_SUM_TAX_DED_POLI_AMT, 0) + NVL(V_TAX_DED_POLI_AMT, 0)) THEN
          -- ��ġ��α� �����ݾ��� �ѵ� �ʰ��� �ѵ��ݾ� �̻��� ��ġ��α� ���� 
          V_TAX_DED_POLI_AMT := NVL(C1.DONAT_POLI_MAX, 0) - NVL(V_SUM_TAX_DED_POLI_AMT, 0);          
          V_DONAT_POLI       := NVL(R1.TOTAL_DONA_AMT, 0) - NVL(V_TAX_DED_POLI_AMT, 0);
        END IF;        
        -- ���װ��� : ��ġ ��α� �����ݾ�;
        V_SUM_TAX_DED_POLI_AMT := NVL(V_SUM_TAX_DED_POLI_AMT, 0) + NVL(V_TAX_DED_POLI_AMT, 0);
        
        -- ��α� ����.
        V_SUM_DONAT_POLI := NVL(V_SUM_DONAT_POLI, 0) + NVL(V_DONAT_POLI, 0);
        
        -- �����ݾ�, �Ҹ�ݾ�, �̿��ݾ� ó�� --
        V_NEXT_DONA_AMT := 0;
        V_LAPSE_DONA_AMT := 0;
        -- ��α� �ѵ� �ʰ� �ݾ� ���.
        IF NVL(V_DONAT_LMT, 0) < (NVL(V_SUM_DONAT_POLI, 0) + NVL(V_SUM_TAX_DED_POLI_AMT, 0)) THEN
          V_NEXT_DONA_AMT := (NVL(V_SUM_DONAT_POLI, 0) + NVL(V_SUM_TAX_DED_POLI_AMT, 0)) - NVL(V_DONAT_LMT, 0);
          V_LAPSE_DONA_AMT := 0;
        END IF;
        IF (TO_NUMBER(R1.DONA_YYYY) + NVL(R1.AVAILABLE_YEAR, 0)) > TO_NUMBER(R1.YEAR_YYYY) THEN
          NULL;
        ELSE
          -- ��αݾ׼Ҹ�.
          V_LAPSE_DONA_AMT := V_NEXT_DONA_AMT;
          V_NEXT_DONA_AMT := 0;
        END IF;
        
        -- ��α��������� UPDATE.
        UPDATE HRA_DONATION_ADJUSTMENT DA
          SET DA.DONA_DED_AMT     = (NVL(V_TAX_DED_POLI_AMT, 0) + NVL(V_DONAT_POLI, 0)) - (NVL(V_NEXT_DONA_AMT, 0) - NVL(V_LAPSE_DONA_AMT, 0))
            , DA.LAPSE_DONA_AMT   = NVL(V_LAPSE_DONA_AMT, 0)
            , DA.NEXT_DONA_AMT    = NVL(V_NEXT_DONA_AMT, 0)
        WHERE DA.DONATION_ADJUSTMENT_ID = R1.DONATION_ADJUSTMENT_ID
        ;
      END LOOP R1;
      -- ��ġ��α� ������.
      V_TAX_DED_POLI_AMT := TRUNC(NVL(V_TAX_DED_POLI_AMT, 0) * NVL(C1.DONAT_POLI_RATE, 0) / C1.DONAT_POLI_RATE1);
      
      -- ��ġ�ڱ� ��α� ������αݿ� �����ؼ� ó�� ����       
      -- ������α�.
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
        V_DONAT_ALL := NVL(R1.TOTAL_DONA_AMT, 0); -- ���װ��� �ݾ�;  
        IF NVL(V_DONAT_LMT, 0) < (NVL(V_SUM_DONAT_POLI, 0) + NVL(V_SUM_DONAT_ALL, 0)) + NVL(V_DONAT_ALL, 0) THEN
          -- ��α� �ѵ� �ʰ� �ݾ� ���.
          V_NEXT_DONA_AMT := (NVL(V_SUM_DONAT_POLI, 0) + NVL(V_SUM_DONAT_ALL, 0)) + NVL(V_DONAT_ALL, 0) - NVL(V_DONAT_LMT, 0);
          V_LAPSE_DONA_AMT := 0;
        
          V_DONAT_ALL := NVL(V_DONAT_LMT, 0) - (NVL(V_SUM_DONAT_POLI, 0) + NVL(V_SUM_DONAT_ALL, 0));
        END IF;        
        
        -- �����ݾ�, �Ҹ�ݾ�, �̿��ݾ� ó�� --
        IF (TO_NUMBER(R1.DONA_YYYY) + NVL(R1.AVAILABLE_YEAR, 0)) > TO_NUMBER(R1.YEAR_YYYY) THEN
          NULL;
        ELSE
          -- ��αݾ׼Ҹ�.
          V_LAPSE_DONA_AMT := V_NEXT_DONA_AMT;
          V_NEXT_DONA_AMT := 0;
        END IF;
        -- ���� -- 
        V_SUM_DONAT_ALL := NVL(V_SUM_DONAT_ALL, 0) + NVL(V_DONAT_ALL, 0);
        V_SUM_DONAT_NEXT_ALL := NVL(V_SUM_DONAT_NEXT_ALL, 0) + NVL(V_NEXT_DONA_AMT, 0);
        
        -- ��α��������� UPDATE.
        UPDATE HRA_DONATION_ADJUSTMENT DA
          SET DA.DONA_DED_AMT     = NVL(V_DONAT_ALL, 0)
            , DA.LAPSE_DONA_AMT   = NVL(V_LAPSE_DONA_AMT, 0)
            , DA.NEXT_DONA_AMT    = NVL(V_NEXT_DONA_AMT, 0)
        WHERE DA.DONATION_ADJUSTMENT_ID = R1.DONATION_ADJUSTMENT_ID
        ;
      END LOOP R1;
      
      -- 50% �ѵ�(Ư�ʱ�α�, ���͹��α�ν�Ź��α�);  
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
        V_DONAT_50P := NVL(R1.TOTAL_DONA_AMT, 0); -- Ư������(50%) �ݾ�;  
        IF NVL(V_DONAT_LMT, 0) < NVL(V_SUM_DONAT_50P, 0) + NVL(V_DONAT_50P, 0) THEN
          -- ��α� �ѵ� �ʰ� �ݾ� ���.
          V_NEXT_DONA_AMT := NVL(V_SUM_DONAT_50P, 0) + NVL(V_DONAT_50P, 0) - NVL(V_DONAT_LMT, 0);
          V_LAPSE_DONA_AMT := 0;
        
          V_DONAT_50P := NVL(V_DONAT_LMT, 0) - NVL(V_SUM_DONAT_50P, 0);
        END IF;        
        
        -- �����ݾ�, �Ҹ�ݾ�, �̿��ݾ� ó�� --
        IF (TO_NUMBER(R1.DONA_YYYY) + NVL(R1.AVAILABLE_YEAR, 0)) > TO_NUMBER(R1.YEAR_YYYY) THEN
          NULL;
        ELSE
          -- ��αݾ׼Ҹ�.
          V_LAPSE_DONA_AMT := V_NEXT_DONA_AMT;
          V_NEXT_DONA_AMT := 0;
        END IF;
        
        -- ���� -- 
        V_SUM_DONAT_50P := NVL(V_SUM_DONAT_50P, 0) + NVL(V_DONAT_50P, 0);
        V_SUM_DONAT_NEXT_50P := NVL(V_SUM_DONAT_NEXT_50P, 0) + NVL(V_NEXT_DONA_AMT, 0);
        
        -- ��α��������� UPDATE.
        UPDATE HRA_DONATION_ADJUSTMENT DA
          SET DA.DONA_DED_AMT     = NVL(V_DONAT_50P, 0)
            , DA.LAPSE_DONA_AMT   = NVL(V_LAPSE_DONA_AMT, 0)
            , DA.NEXT_DONA_AMT    = NVL(V_NEXT_DONA_AMT, 0)
        WHERE DA.DONATION_ADJUSTMENT_ID = R1.DONATION_ADJUSTMENT_ID
        ;
      END LOOP R1;
      
      --30% ����(�츮���ֱ�α�); 
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
        V_DONAT_30P := NVL(R1.TOTAL_DONA_AMT, 0); -- �츮����(30%) �ݾ�;  
        IF NVL(V_DONAT_LMT, 0) < NVL(V_SUM_DONAT_30P, 0) + NVL(V_DONAT_30P, 0) THEN
          -- ��α� �ѵ� �ʰ� �ݾ� ���.
          V_NEXT_DONA_AMT := NVL(V_SUM_DONAT_30P, 0) + NVL(V_DONAT_30P, 0) - NVL(V_DONAT_LMT, 0);
          V_LAPSE_DONA_AMT := 0;
        
          V_DONAT_30P := NVL(V_DONAT_LMT, 0) - NVL(V_SUM_DONAT_30P, 0);
        END IF;
        
        -- �����ݾ�, �Ҹ�ݾ�, �̿��ݾ� ó�� --
        IF (TO_NUMBER(R1.DONA_YYYY) + NVL(R1.AVAILABLE_YEAR, 0)) > TO_NUMBER(R1.YEAR_YYYY) THEN
          NULL;
        ELSE
          -- ��αݾ׼Ҹ�.
          V_LAPSE_DONA_AMT := V_NEXT_DONA_AMT;
          V_NEXT_DONA_AMT := 0;
        END IF;
        
        -- ���� -- 
        V_SUM_DONAT_30P := NVL(V_SUM_DONAT_30P, 0) + NVL(V_DONAT_30P, 0);
        V_SUM_DONAT_NEXT_30P := NVL(V_SUM_DONAT_NEXT_30P, 0) + NVL(V_NEXT_DONA_AMT, 0);
        
        -- ��α��������� UPDATE.
        UPDATE HRA_DONATION_ADJUSTMENT DA
          SET DA.DONA_DED_AMT     = NVL(V_DONAT_30P, 0)
            , DA.LAPSE_DONA_AMT   = NVL(V_LAPSE_DONA_AMT, 0)
            , DA.NEXT_DONA_AMT    = NVL(V_NEXT_DONA_AMT, 0)
        WHERE DA.DONATION_ADJUSTMENT_ID = R1.DONATION_ADJUSTMENT_ID
        ;
      END LOOP R1;
      
      -- ������ü ��α� �հ� ��ȸ => ������ü ��α��� ������ ������ �޶���.
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
          AND DA.DONA_TYPE              IN('40', '41')  -- ������ü�ܱ�α�(40), ������ü��α�(41).
        ;
      EXCEPTION WHEN OTHERS THEN
        V_DONAT_10P := 0;
        V_DONAT_10P_RELIGION := 0;
      END;
      -- ���� ��α�;
      IF NVL(V_DONAT_10P_RELIGION, 0) > 0 THEN
      --5.1 ������ü��α��� �ִ� ���;
        -- �ѵ��׼��� : ������ü ��α��̿�;
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
          V_DONAT_10P := NVL(R1.TOTAL_DONA_AMT, 0); -- ������ü�� �ݾ�;  
          IF NVL(V_DONAT_LMT, 0) < NVL(V_SUM_DONAT_10P, 0) + NVL(V_DONAT_10P, 0) THEN
            -- ��α� �ѵ� �ʰ� �ݾ� ���.
            V_NEXT_DONA_AMT := NVL(V_SUM_DONAT_10P, 0) + NVL(V_DONAT_10P, 0) - NVL(V_DONAT_LMT, 0);
            V_LAPSE_DONA_AMT := 0;
            
            V_DONAT_10P := NVL(V_DONAT_LMT, 0) - NVL(V_SUM_DONAT_10P, 0);
          END IF;
                    
          -- �����ݾ�, �Ҹ�ݾ�, �̿��ݾ� ó�� --
          IF (TO_NUMBER(R1.DONA_YYYY) + NVL(R1.AVAILABLE_YEAR, 0)) > TO_NUMBER(R1.YEAR_YYYY) THEN
            NULL;
          ELSE
            -- ��αݾ׼Ҹ�.
            V_LAPSE_DONA_AMT := V_NEXT_DONA_AMT;
            V_NEXT_DONA_AMT := 0;
          END IF;
          
          -- ���� -- 
          V_SUM_DONAT_10P := NVL(V_SUM_DONAT_10P, 0) + NVL(V_DONAT_10P, 0);
          V_SUM_DONAT_NEXT_10P := NVL(V_SUM_DONAT_NEXT_10P, 0) + NVL(V_NEXT_DONA_AMT, 0);
          
          -- ��α��������� UPDATE.
          UPDATE HRA_DONATION_ADJUSTMENT DA
            SET DA.DONA_DED_AMT     = NVL(V_DONAT_10P, 0)
              , DA.LAPSE_DONA_AMT   = NVL(V_LAPSE_DONA_AMT, 0)
              , DA.NEXT_DONA_AMT    = NVL(V_NEXT_DONA_AMT, 0)
          WHERE DA.DONATION_ADJUSTMENT_ID = R1.DONATION_ADJUSTMENT_ID
          ;
        END LOOP R1;
        -- �ѵ��׼��� : ������ü ��α�;
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
          V_DONAT_10P_RELIGION := NVL(R1.TOTAL_DONA_AMT, 0); -- ������ü�� �ݾ�;  
          IF NVL(V_DONAT_LMT, 0) < NVL(V_SUM_DONAT_10P_RELIGION, 0) + NVL(V_DONAT_10P_RELIGION, 0) THEN
            -- ��α� �ѵ� �ʰ� �ݾ� ���.
            V_NEXT_DONA_AMT := (NVL(V_SUM_DONAT_10P_RELIGION, 0) + NVL(V_DONAT_10P_RELIGION, 0)) - NVL(V_DONAT_LMT, 0);
            V_LAPSE_DONA_AMT := 0;
            
            V_DONAT_10P_RELIGION := NVL(V_DONAT_LMT, 0) - NVL(V_SUM_DONAT_10P_RELIGION, 0);
          END IF;
                    
          -- �����ݾ�, �Ҹ�ݾ�, �̿��ݾ� ó�� --
          IF (TO_NUMBER(R1.DONA_YYYY) + NVL(R1.AVAILABLE_YEAR, 0)) > TO_NUMBER(R1.YEAR_YYYY) THEN
            NULL;
          ELSE
            -- ��αݾ׼Ҹ�.
            V_LAPSE_DONA_AMT := V_NEXT_DONA_AMT;
            V_NEXT_DONA_AMT := 0;
          END IF;
          
          -- ���� -- 
          V_SUM_DONAT_10P_RELIGION := NVL(V_SUM_DONAT_10P_RELIGION, 0) + NVL(V_DONAT_10P_RELIGION, 0);
          V_SUM_DONAT_NEXT_10P_REL := NVL(V_SUM_DONAT_NEXT_10P_REL, 0) + NVL(V_NEXT_DONA_AMT, 0);
          
          -- ��α��������� UPDATE.
          UPDATE HRA_DONATION_ADJUSTMENT DA
            SET DA.DONA_DED_AMT     = NVL(V_DONAT_10P_RELIGION, 0)
              , DA.LAPSE_DONA_AMT   = NVL(V_LAPSE_DONA_AMT, 0)
              , DA.NEXT_DONA_AMT    = NVL(V_NEXT_DONA_AMT, 0)
          WHERE DA.DONATION_ADJUSTMENT_ID = R1.DONATION_ADJUSTMENT_ID
          ;
        END LOOP R1;
      ELSIF NVL(V_DONAT_10P_RELIGION, 0) = 0 THEN
      -- 5.2 ������ü��α��� ���� ���;
        -- �ѵ��׼���;
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
          V_DONAT_10P := NVL(R1.TOTAL_DONA_AMT, 0); -- ������ü�� �ݾ�;  
          IF NVL(V_DONAT_LMT, 0) < NVL(V_SUM_DONAT_10P, 0) + NVL(V_DONAT_10P, 0) THEN
            -- ��α� �ѵ� �ʰ� �ݾ� ���.
            V_NEXT_DONA_AMT := NVL(V_SUM_DONAT_10P, 0) + NVL(V_DONAT_10P, 0) - NVL(V_DONAT_LMT, 0);
            V_LAPSE_DONA_AMT := 0;

            V_DONAT_10P := NVL(V_DONAT_LMT, 0) - NVL(V_SUM_DONAT_10P, 0);
          END IF;          
          
          -- �����ݾ�, �Ҹ�ݾ�, �̿��ݾ� ó�� --
          IF (TO_NUMBER(R1.DONA_YYYY) + NVL(R1.AVAILABLE_YEAR, 0)) > TO_NUMBER(R1.YEAR_YYYY) THEN
            NULL;
          ELSE
            -- ��αݾ׼Ҹ�.
            V_LAPSE_DONA_AMT := V_NEXT_DONA_AMT;
            V_NEXT_DONA_AMT := 0;
          END IF;
          
          -- ���� -- 
          V_SUM_DONAT_10P := NVL(V_SUM_DONAT_10P, 0) + NVL(V_DONAT_10P, 0);
          V_SUM_DONAT_NEXT_10P := NVL(V_SUM_DONAT_NEXT_10P, 0) + NVL(V_NEXT_DONA_AMT, 0);
          
          -- ��α��������� UPDATE.
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
    
      -- ���հ�;
      V_DONAT_TOTAL := 0;
      V_DONAT_TOTAL := TRUNC(NVL(V_SUM_DONAT_POLI, 0) + NVL(V_SUM_DONAT_ALL, 0) + NVL(V_SUM_DONAT_50P, 0) + NVL(V_SUM_DONAT_30P, 0) + 
                       NVL(V_SUM_DONAT_10P, 0) + NVL(V_SUM_DONAT_10P_RELIGION, 0));
    
      --> ��α�   UPDATE 
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

  -- 10. ȥ��, ���, �̻��� ����;
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
    V_MARRY_ETC_AMT NUMBER := 0; -- ȥ������̻� �ݾ� 
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.MARRY_DED_STD, 0) MARRY_DED_STD
                    , NVL(HIT.MARRY_DED, 0) MARRY_DED
                    , NVL(HIT.FUNE_DED_STD, 0) FUNE_DED_STD
                    , NVL(HIT.FUNE_DED, 0) FUNE_DED
                    , NVL(HIT.MOVE_DED_STD, 0) MOVE_DED_STD
                    , NVL(HIT.MOVE_DED, 0) MOVE_DED
                    --> ȥ������̻�           
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
      --  ��ȥ�ݾ�  
      IF P_TOTAL_PAY <= C1.MARRY_DED_STD THEN
        V_MARRY_ETC_AMT := C1.MARRY_DED * C1.MARRY_COUNT;
      END IF;
      -- ��ʱݾ� 
      IF P_TOTAL_PAY <= C1.FUNE_DED_STD THEN
        V_MARRY_ETC_AMT := V_MARRY_ETC_AMT + (C1.FUNE_DED * C1.FUNER_COUNT);
      END IF;
      -- �̻�ݾ� 
      IF P_TOTAL_PAY <= C1.MOVE_DED_STD THEN
        V_MARRY_ETC_AMT := V_MARRY_ETC_AMT + (C1.MOVE_DED * C1.HOUSE_MOVE_COUNT);
      END IF;
    
      --> ��ȥ,�̻�,��� �����ݾ�   UPDATE 
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

  -- 11.1 ���ο�������ҵ����, �������� ����
  FUNCTION PER_ANNU_BANK_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_TOTAL_AMT                   NUMBER := 0;  -- ���ο������� �����ݾ�.
    V_PER_ANNU_AMT                NUMBER := 0; -- ���ο�������;
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.PRIV_PENS_RATE, 0) PRIV_PENS_RATE
                    , NVL(HIT.PRIV_PENS_LMT, 0) PRIV_PENS_LMT
                    -- ���ο��� ����.
                    , HF1.SAVING_INFO_ID
                    , NVL(HF1.SAVING_AMOUNT, 0) PERSON_ANNU_AMT
                  FROM HRA_INCOME_TAX_STANDARD HIT
                    , ( --  �������� �����ڷ�  ��ȸ  
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
      --  ���ο������� �ݾ�.
      V_PER_ANNU_AMT := 0;
      V_PER_ANNU_AMT := TRUNC(NVL(C1.PERSON_ANNU_AMT, 0) * (C1.PRIV_PENS_RATE / 100));
      IF NVL(C1.PRIV_PENS_LMT, 0) < NVL(V_TOTAL_AMT, 0) + NVL(V_PER_ANNU_AMT, 0) THEN
        V_PER_ANNU_AMT := NVL(C1.PRIV_PENS_LMT, 0) - NVL(V_TOTAL_AMT, 0);
      END IF;
      V_TOTAL_AMT := NVL(V_TOTAL_AMT, 0) + NVL(V_PER_ANNU_AMT, 0);
      
      -- ���ο������� �����ݾ� UPDATE.
      UPDATE HRA_SAVING_INFO HSI
        SET HSI.SAVING_DED_AMOUNT  = NVL(V_PER_ANNU_AMT, 0)
      WHERE HSI.SAVING_INFO_ID     = C1.SAVING_INFO_ID
      ;
    END LOOP C1;
    --> ���ο�������    UPDATE 
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

  -- 11.2 ��������ҵ����, �������� ����;
  FUNCTION ANNU_BANK_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_TOTAL_AMT                   NUMBER := 0;  -- �������� �����ݾ�.
    V_ANNU_BANK_AMT               NUMBER := 0;  -- ��������.
    V_RETR_ANNU_AMT               NUMBER := 0;  -- ������������(�ѵ� ��������);
  BEGIN
    O_STATUS := 'F';
    BEGIN
      -- �������ݳ��Ծ� �����ݾ� ��ȸ.
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
                    --> ���� ����.
                    , HF1.SAVING_INFO_ID
                    , NVL(HF1.SAVING_AMOUNT, 0) ANNU_BANK_AMT
                  FROM HRA_INCOME_TAX_STANDARD HIT
                    , ( --  �������� �����ڷ�  ��ȸ  
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
      --  �������� �ݾ�;
      V_ANNU_BANK_AMT := 0;
      V_ANNU_BANK_AMT := TRUNC(NVL(C1.ANNU_BANK_AMT, 0) * (C1.PENS_DED_RATE / 100));
      IF NVL(C1.PENS_DED_LMT, 0) < NVL(V_RETR_ANNU_AMT, 0) + NVL(V_TOTAL_AMT, 0) + NVL(V_ANNU_BANK_AMT, 0) THEN
        V_ANNU_BANK_AMT := NVL(C1.PENS_DED_LMT, 0) - NVL(V_RETR_ANNU_AMT, 0) - NVL(V_TOTAL_AMT, 0);
      END IF;
      IF NVL(V_ANNU_BANK_AMT, 0) < 0 THEN
        V_ANNU_BANK_AMT := 0;
      END IF;
      V_TOTAL_AMT := NVL(V_TOTAL_AMT, 0) + NVL(V_ANNU_BANK_AMT, 0);
      
      -- �������� �����ݾ� UPDATE.
      UPDATE HRA_SAVING_INFO HSI
        SET HSI.SAVING_DED_AMOUNT  = NVL(V_ANNU_BANK_AMT, 0)
      WHERE HSI.SAVING_INFO_ID     = C1.SAVING_INFO_ID
      ;
    END LOOP C1;
    
    --> ��������    UPDATE;
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

  -- 11.3 �������� ���� ;
  FUNCTION RETR_ANNU_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_TOTAL_AMT                   NUMBER := 0;  -- ������������ �����ݾ�.
    V_RETR_ANNU_AMT               NUMBER := 0;  -- ������������;
    V_ANNU_BANK_AMT               NUMBER := 0;  -- ��������.
  BEGIN
    O_STATUS := 'F';
    BEGIN
      -- �������ݳ��Ծ� �����ݾ� ��ȸ.
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
                    --> �������� ����.
                    , HF1.SAVING_INFO_ID
                    , NVL(HF1.SAVING_AMOUNT, 0) RETR_ANNU_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  �������� �����ڷ�  ��ȸ  
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
      --  ������������ �ݾ�.
      V_RETR_ANNU_AMT := 0;
      V_RETR_ANNU_AMT := NVL(C1.RETR_ANNU_AMT, 0);
      IF NVL(C1.RETR_PENS_LMT, 0) < NVL(V_ANNU_BANK_AMT, 0) + NVL(V_TOTAL_AMT, 0) + NVL(V_RETR_ANNU_AMT, 0) THEN
        V_RETR_ANNU_AMT := NVL(C1.RETR_PENS_LMT, 0) - NVL(V_ANNU_BANK_AMT, 0) - NVL(V_TOTAL_AMT, 0);
      END IF;
      IF NVL(V_RETR_ANNU_AMT, 0) < 0 THEN
        V_RETR_ANNU_AMT := 0;
      END IF;
      V_TOTAL_AMT := NVL(V_TOTAL_AMT, 0) + NVL(V_RETR_ANNU_AMT, 0);
      
      -- �������� �����ݾ� UPDATE.
      UPDATE HRA_SAVING_INFO HSI
        SET HSI.SAVING_DED_AMOUNT  = NVL(V_RETR_ANNU_AMT, 0)
      WHERE HSI.SAVING_INFO_ID     = C1.SAVING_INFO_ID
      ;
    END LOOP C1;
    
    -- ������������    UPDATE 
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

  -- 12. ������������;
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
    V_INVEST_AMT_10     NUMBER := 0;  -- �������� ���� 
    V_INVEST_LMT_10     NUMBER := 0;  -- ������������ �ѵ� 
    
    V_INVEST_AMT_11     NUMBER := 0;  -- 2013.12.31 ��ȣ�� �߰� : �������� ����(2011) 
    V_INVEST_LMT_11     NUMBER := 0;  -- 2013.12.31 ��ȣ�� �߰� : ������������ �ѵ� (2011) 
    V_INVEST_AMT_12     NUMBER := 0;  -- 2013.12.31 ��ȣ�� �߰� : �������� ����(2012) 
    V_INVEST_LMT_12     NUMBER := 0;  -- 2013.12.31 ��ȣ�� �߰� : ������������ �ѵ�(2012) 
    V_INVEST_AMT_13     NUMBER := 0;  -- 2013.12.31 ��ȣ�� �߰� : �������� ����(2013) 
    V_INVEST_LMT_13     NUMBER := 0;  -- 2013.12.31 ��ȣ�� �߰� : ������������ �ѵ�(2013) 
    
    V_INVEST_LMT        NUMBER := 0;  -- ������������ �ѵ�(��ü)       
    V_INVEST_OVER_AMT   NUMBER := 0;  -- ������������ �ѵ� �ʰ��ݾ�  
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
                    --> �������� ���� ����           
                    , NVL(HF1.INVES_AMT, 0) AS INVES_AMT_10
                    , NVL(HF1.INVEST_AMT_11, 0) AS INVEST_AMT_11 
                    , NVL(HF1.INVEST_AMT_12_1, 0) AS INVEST_AMT_12_1 
                    , NVL(HF1.INVEST_AMT_12_2, 0) AS INVEST_AMT_12_2 
                    , NVL(HF1.INVEST_AMT_13_1, 0) AS INVEST_AMT_13_1 
                    , NVL(HF1.INVEST_AMT_13_2, 0) AS INVEST_AMT_13_2 
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  �������� �����ڷ�  ��ȸ  
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
      --  2010�� ���� �������� ���� �ݾ�   
      V_INVEST_AMT_10 := TRUNC(C1.INVES_AMT_10 * (C1.INVEST_RATE_10 / 100));
      V_INVEST_LMT_10 := TRUNC(P_INCOME_AMT * (C1.INVEST_LMT_RATE_10 / 100));      
      IF V_INVEST_LMT_10 < V_INVEST_AMT_10 THEN
        V_INVEST_AMT_10 := V_INVEST_LMT_10;
      END IF;
      
      --  2011�� ���� �������� ���� �ݾ�   
      V_INVEST_AMT_11 := TRUNC(C1.INVEST_AMT_11 * (C1.INVEST_RATE_11 / 100));
      V_INVEST_LMT_11 := TRUNC(P_INCOME_AMT * (C1.INVEST_LMT_RATE_11 / 100));      
      IF V_INVEST_LMT_11 < V_INVEST_AMT_11 THEN
        V_INVEST_AMT_11 := V_INVEST_LMT_11;
      END IF;
      
      --  2012�� ���� �������� ���� �ݾ�   
      V_INVEST_AMT_12 := TRUNC(C1.INVEST_AMT_12_1 * (C1.INVEST_RATE_12_1 / 100));
      V_INVEST_AMT_12 := NVL(V_INVEST_AMT_12, 0) + TRUNC(C1.INVEST_AMT_12_2 * (C1.INVEST_RATE_12_2 / 100));      
      V_INVEST_LMT_12 := TRUNC(P_INCOME_AMT * (C1.INVEST_LMT_RATE_12 / 100));      
      IF V_INVEST_LMT_12 < V_INVEST_AMT_12 THEN
        V_INVEST_AMT_12 := V_INVEST_LMT_12;
      END IF;
      
      --  2013�� ���� �������� ���� �ݾ�   
      V_INVEST_AMT_13 := TRUNC(C1.INVEST_AMT_13_1 * (C1.INVEST_RATE_13_1 / 100));
      V_INVEST_AMT_13 := NVL(V_INVEST_AMT_13, 0) + TRUNC(C1.INVEST_AMT_13_2 * (C1.INVEST_RATE_13_2 / 100));      
      V_INVEST_LMT_13 := TRUNC(P_INCOME_AMT * (C1.INVEST_LMT_RATE_13 / 100));      
      IF V_INVEST_LMT_13 < V_INVEST_AMT_13 THEN
        V_INVEST_AMT_13 := V_INVEST_LMT_13;
      END IF;
      
      --  �������� ���� �ѵ� �ݾ�   
      V_INVEST_LMT := TRUNC(P_INCOME_AMT * (C1.INVEST_LMT_RATE / 100)); 
      V_INVEST_OVER_AMT := ( NVL(V_INVEST_AMT_10, 0) + NVL(V_INVEST_AMT_11, 0) + 
                             NVL(V_INVEST_AMT_12, 0) + NVL(V_INVEST_AMT_13, 0)) - 
                           NVL(V_INVEST_LMT, 0);  -- �ѵ� �ʰ� �ݾ� ����  
      IF V_INVEST_OVER_AMT > 0  THEN
        -- 2010�� ����  
        IF NVL(V_INVEST_AMT_10, 0) < NVL(V_INVEST_OVER_AMT, 0) THEN
          V_INVEST_OVER_AMT := NVL(V_INVEST_OVER_AMT, 0) - NVL(V_INVEST_AMT_10, 0);
          V_INVEST_AMT_10   := 0;
        ELSE
          V_INVEST_AMT_10   := NVL(V_INVEST_AMT_10, 0) - NVL(V_INVEST_OVER_AMT, 0);
          V_INVEST_OVER_AMT := 0;            
        END IF;
        -- 2011�� ����  
        IF NVL(V_INVEST_AMT_11, 0) < NVL(V_INVEST_OVER_AMT, 0) THEN
          V_INVEST_OVER_AMT := NVL(V_INVEST_OVER_AMT, 0) - NVL(V_INVEST_AMT_11, 0);
          V_INVEST_AMT_11   := 0;
        ELSE
          V_INVEST_AMT_11   := NVL(V_INVEST_AMT_11, 0) - NVL(V_INVEST_OVER_AMT, 0);
          V_INVEST_OVER_AMT := 0;            
        END IF; 
        -- 2012�� ����  
        IF NVL(V_INVEST_AMT_12, 0) < NVL(V_INVEST_OVER_AMT, 0) THEN
          V_INVEST_OVER_AMT := NVL(V_INVEST_OVER_AMT, 0) - NVL(V_INVEST_AMT_12, 0);
          V_INVEST_AMT_12   := 0;
        ELSE
          V_INVEST_AMT_12   := NVL(V_INVEST_AMT_12, 0) - NVL(V_INVEST_OVER_AMT, 0);
          V_INVEST_OVER_AMT := 0;            
        END IF; 
        -- 2013�� ����  
        IF NVL(V_INVEST_AMT_13, 0) < NVL(V_INVEST_OVER_AMT, 0) THEN
          V_INVEST_OVER_AMT := NVL(V_INVEST_OVER_AMT, 0) - NVL(V_INVEST_AMT_13, 0);
          V_INVEST_AMT_13   := 0;
        ELSE
          V_INVEST_AMT_13   := NVL(V_INVEST_AMT_13, 0) - NVL(V_INVEST_OVER_AMT, 0);
          V_INVEST_OVER_AMT := 0;            
        END IF; 
      END IF;
                
      --> �������� ����   UPDATE 
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

  -- 14.1 ����û���������� ���Ծ� �ҵ���� : ��� ����;
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
    V_ADD_AMOUNT                  NUMBER := 0;  -- �����ݾ�.
    V_HOUSE_APP_DEPOSIT_AMT       NUMBER := 0; -- ����û���������� ���Ծ� �ҵ����;
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.HOUSE_AMT_RATE, 0) HOUSE_APP_DEPOSIT_RATE
                    , NVL(HIT.HOUSE_AMT_LMT, 0) HOUSE_APP_DEPOSIT_LMT
                    , NVL(HIT.HOUSE_AMT_LMT, 0) HOUSE_AMT_LMT
                    -- 
                    , NVL(HF1.HOUSE_APP_DEPOSIT_AMT, 0) HOUSE_APP_DEPOSIT_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  �������� �����ڷ�  ��ȸ  : �������� �ڷ�.
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
                        AND ST.SAVING_GROUP           = 3  -- �������� ����.
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
      -- �����������Ա� �ҵ�����ݾ� �� �����װ����װ� �ջ��Ͽ� �� 300���� �ѵ�;
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

  -- 13. �ſ�ī��� ����;
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
    V_MIN_USER_LMT                NUMBER := 0;  -- �������ݾ�--
    V_CARD_LMT                    NUMBER := 0;  -- �ſ�ī�� ��� �ѵ�;
       
    V_CARD_AMT                    NUMBER := 0;  -- �ſ�ī�� ����;
    V_TRAD_MARKET_AMT             NUMBER := 0;  -- �ſ�ī�� (�������) �߰����� �ݾ�.
    V_PUBLIC_TRANSIT_AMT          NUMBER := 0;  -- �ſ�ī�� (���߱���) �߰����� �ݾ�.    
    V_OVER_AMT                    NUMBER := 0;  -- �ʰ��ݾ�;
    
    V_EXCEPT_CARD_AMT             NUMBER := 0;  -- �ſ�ī�� ���� ���ܱݾ�.
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.CARD_BAS_RATE, 0) AS CARD_BAS_RATE              -- ī�� ���� ������.
                    , NVL(HIT.CARD_DED_RATE, 0) AS CARD_DED_RATE              -- ī�� ������.
                    , NVL(HIT.CHECK_CARD_DED_RATE, 0) AS CHECK_CARD_DED_RATE  -- üũī�� ��������(2010�������� �߰�);
                    , NVL(HIT.CARD_DED_LMT, 0) AS CARD_DED_LMT                -- ī������ѵ�.
                    , NVL(HIT.CARD_DED_LMT_RATE, 0) AS CARD_DED_LMT_RATE      -- ���� �ѵ���.                    
                    -- 2012�� �������� �߰� --
                    , NVL(HIT.TRAD_MARKET_DED_RATE, 0) AS TRAD_MARKET_DED_RATE-- ������� ������.                    
                    , NVL(HIT.CARD_MIN_USE_RATE_1, 0) AS CARD_MIN_USE_RATE_1  -- �������ݾ���1.
                    , NVL(HIT.CARD_MIN_USE_RATE_2, 0) AS CARD_MIN_USE_RATE_2  -- �������ݾ���2.
                    , NVL(HIT.CARD_ADD_DED_LMT, 0) AS CARD_ADD_DED_LMT        -- �߰����� �ѵ��ݾ�.
                    -- 2013.12.31 ��ȣ�� �߰� -- 
                    , NVL(HIT.PUBLIC_TRANSIT_DED_RATE, 0) AS PUBLIC_TRANSIT_DED_RATE  -- ���߱��� ������.
                    , NVL(HIT.PUBLIC_TRANSIT_DED_LMT, 0) AS PUBLIC_TRANSIT_DED_LMT    -- ���߱������ �ѵ��ݾ�.
                    --> �ſ�ī�� ��� ����
                    , ( NVL(HSF1.CREDIT_SUM, 0) + 
                        NVL(HSF1.CHECK_CREDIT_SUM, 0) + 
                        NVL(HSF1.TRAD_MARKET_SUM, 0) + 
                        NVL(HSF1.PUBLIC_TRANSIT_SUM, 0)) AS TOTAL_CARD_SUM    -- �� ���ݾ� --
                    , NVL(HSF1.CREDIT_SUM, 0) AS CREDIT_SUM                   -- �ſ�ī��.
                    , NVL(HSF1.CHECK_CREDIT_SUM, 0) AS CHECK_CREDIT_SUM       -- ����ī��.
                    , NVL(HSF1.TRAD_MARKET_SUM, 0) AS TRAD_MARKET_SUM         -- �������.
                    , NVL(HSF1.PUBLIC_TRANSIT_SUM, 0) AS PUBLIC_TRANSIT_SUM   -- 2013.12.31 ��ȣ�� �߰� : ���߱���.
                 FROM HRA_INCOME_TAX_STANDARD HIT
                    , ( --  �ξ簡���ڷ�  ��ȸ  
                        SELECT HSF.YEAR_YYYY
                             , HSF.SOB_ID
                             , HSF.ORG_ID
                             , SUM( NVL(HSF.CREDIT_AMT, 0) +
                                    NVL(HSF.ETC_CREDIT_AMT, 0) +
                                    NVL(HSF.ACADE_GIRO_AMT, 0) +
                                    NVL(HSF.ETC_ACADE_GIRO_AMT, 0)) AS CREDIT_SUM                   -- �ſ�ī��.
                             , SUM( NVL(HSF.CHECK_CREDIT_AMT, 0) +
                                    NVL(HSF.ETC_CHECK_CREDIT_AMT, 0) +
                                    NVL(HSF.CASH_AMT, 0) +
                                    NVL(HSF.ETC_CASH_AMT, 0)) AS CHECK_CREDIT_SUM     -- ����ī��.
                             , SUM( NVL(HSF.TRAD_MARKET_AMT, 0) +  
                                    NVL(HSF.ETC_TRAD_MARKET_AMT, 0)) AS TRAD_MARKET_SUM       -- �������.
                             , SUM( NVL(HSF.PUBLIC_TRANSIT_AMT, 0) +  
                                    NVL(HSF.ETC_PUBLIC_TRANSIT_AMT, 0)) AS PUBLIC_TRANSIT_SUM -- 2013.12.31 ��ȣ�� �߰� : ���߱���.
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
      /*        --  �ſ�ī�� ��� �ݾ�   
      V_CARD_AMT := C1.CREDIT_SUM - TRUNC(I_TOTAL_PAY * (C1.CARD_BAS_RATE / 100));
      V_CARD_AMT := TRUNC(V_CARD_AMT * (C1.CARD_DED_RATE / 100));*/
    
      -- 2011.01.17 MODYFIED BY YOUNG MIN;
      --  �ſ�ī�� ��� �ݾ�   
      -- �ʰ��ݾ� = �ſ�ī�� �� ���ݾ� - �ѱ޿��� * 25%;
      -- �����ݾ� = �ʰ��ݾ� * (�ſ�ī��+����+�п���)/�ſ�ī�� �� ���ݾ� * 20%;
      --            + �ʰ��ݾ� * (�̿� �ſ�ī��� ���ݾ�)/�ſ�ī�� �� ���ݾ� * 25%;
      
      -- 1. ������� �ݾ� ���� --
      V_MIN_USER_LMT := TRUNC(NVL(P_TOTAL_PAY, 0) * (C1.CARD_BAS_RATE/100)); 
      
      -- 2. �ʰ��ݾ� --
      V_OVER_AMT := ( NVL(C1.CREDIT_SUM, 0) + NVL(C1.CHECK_CREDIT_SUM, 0) + 
                      NVL(C1.TRAD_MARKET_SUM, 0) + NVL(C1.PUBLIC_TRANSIT_SUM, 0)) - 
                      NVL(V_MIN_USER_LMT, 0);
      
      -- 3. �Ϲݰ��� �ݾ� --
      -- ��� : (������� + ����ī��) * ������ + (�ſ�ī�����-�������ݾ�) * ������.
      V_CARD_AMT := TRUNC(NVL(C1.TRAD_MARKET_SUM * (C1.TRAD_MARKET_DED_RATE / 100), 0) +        -- ������� --
                          NVL(C1.PUBLIC_TRANSIT_SUM * (C1.PUBLIC_TRANSIT_DED_RATE / 100), 0) +  -- ���߱��� --
                          NVL(C1.CHECK_CREDIT_SUM * (C1.CHECK_CARD_DED_RATE / 100), 0) +        -- ����ī�� --
                          NVL(C1.CREDIT_SUM * (C1.CARD_DED_RATE / 100), 0));                 -- ī��--
      
      -- 3.1 ���� ���� �ݾ� --
      IF NVL(V_MIN_USER_LMT, 0) <= NVL(C1.CREDIT_SUM, 0) THEN 
        -- �������ݾ�(�ѱ޿��� 25%) <= �ſ�ī�� ���� : �������ݾ� * 20% --
        V_EXCEPT_CARD_AMT := TRUNC(V_MIN_USER_LMT * (C1.CARD_MIN_USE_RATE_1 / 100));
      ELSE
        -- �������ݾ�(�ѱ޿��� 25%) > �ſ�ī�� ���� : �ſ�ī�� ���� * 20% + (�������ݾ�-�ſ�ī�����) * 30% --
        V_EXCEPT_CARD_AMT := TRUNC(C1.CREDIT_SUM * (C1.CARD_MIN_USE_RATE_1 / 100))
                             + TRUNC((NVL(V_MIN_USER_LMT, 0) - NVL(C1.CREDIT_SUM, 0)) * (C1.CARD_MIN_USE_RATE_2 / 100));
      END IF;
      V_CARD_AMT := TRUNC(NVL(V_CARD_AMT, 0) - NVL(V_EXCEPT_CARD_AMT, 0));
      
      /*IF NVL(V_MIN_USER_LMT, 0) <= NVL(C1.TOTAL_CARD_SUM, 0) THEN 
        -- ��� : (������� + ����ī��) * ������ + (�ſ�ī�����-�������ݾ�) * ������.
        V_CARD_AMT := TRUNC(NVL(C1.TRAD_MARKET_SUM * (C1.TRAD_MARKET_DED_RATE / 100), 0) +  -- ������� --
                            NVL(C1.CHECK_CREDIT_SUM * (C1.CHECK_CARD_DED_RATE / 100), 0) +  -- ����ī�� --
                            NVL((NVL(C1.CREDIT_SUM, 0) - NVL(V_MIN_USER_LMT, 0)) * (C1.CARD_MIN_USE_RATE_1 / 100), 0));
      ELSE
        V_CARD_AMT := TRUNC(NVL(C1.TRAD_MARKET_SUM * (C1.TRAD_MARKET_DED_RATE / 100), 0) +  -- ������� --
                            NVL(C1.CHECK_CREDIT_SUM * (C1.CHECK_CARD_DED_RATE / 100), 0) +  -- ����ī�� --
                            NVL((NVL(C1.CREDIT_SUM, 0) - NVL(V_MIN_USER_LMT, 0)) * (C1.CARD_MIN_USE_RATE_2 / 100), 0));
      END IF;*/
                          
      -- 4. �ѱ޿��� ���� �ѵ� --  
      V_CARD_LMT := TRUNC(P_TOTAL_PAY * (C1.CARD_DED_RATE / 100));
      IF C1.CARD_DED_LMT < V_CARD_LMT THEN
        V_CARD_LMT := C1.CARD_DED_LMT;
      END IF;
    
      -- 5. �ſ�ī�� ���ݾ� --
      V_OVER_AMT := 0;
      IF V_CARD_LMT < V_CARD_AMT THEN
        V_OVER_AMT := NVL(V_CARD_AMT, 0) - NVL(V_CARD_LMT, 0);  -- �ѵ� �ʰ� �ݾ� ���� --
        V_CARD_AMT := V_CARD_LMT;
      END IF;
      -- ���� => 0 --
      IF V_CARD_AMT < 0 THEN
        V_CARD_AMT := 0;
      END IF;
      
      -- 6.1 �߰����� �ݾ� --
      V_TRAD_MARKET_AMT := TRUNC(NVL(C1.TRAD_MARKET_SUM * (C1.TRAD_MARKET_DED_RATE / 100), 0));
      IF V_OVER_AMT < V_TRAD_MARKET_AMT THEN
        -- �ѵ� �ʰ��ݾ� VS ������� ���� ���Ͽ� ������ ���� --
        V_TRAD_MARKET_AMT := V_OVER_AMT;
      END IF;
      IF C1.CARD_ADD_DED_LMT < V_TRAD_MARKET_AMT THEN
        -- 6.1���� �߰����� �ѵ� ���Ͽ� ������ ���� --
        V_TRAD_MARKET_AMT := C1.CARD_ADD_DED_LMT;
      END IF;
      -- ���� => 0 --
      IF NVL(V_TRAD_MARKET_AMT, 0) < 0 THEN
        V_TRAD_MARKET_AMT := 0;
      END IF;
      
      -- 6.2 2013.12.31 ��ȣ�� �߰� : (���߱���) �߰����� �ݾ� --
      V_PUBLIC_TRANSIT_AMT := TRUNC(NVL(C1.PUBLIC_TRANSIT_SUM * (C1.PUBLIC_TRANSIT_DED_RATE / 100), 0));
      IF V_OVER_AMT < V_PUBLIC_TRANSIT_AMT THEN
        -- �ѵ� �ʰ��ݾ� VS ������� ���� ���Ͽ� ������ ���� --
        V_PUBLIC_TRANSIT_AMT := V_OVER_AMT;
      END IF;
      IF C1.PUBLIC_TRANSIT_DED_LMT < V_PUBLIC_TRANSIT_AMT THEN
        -- 6.2���� �߰����� �ѵ� ���Ͽ� ������ ���� --
        V_PUBLIC_TRANSIT_AMT := C1.PUBLIC_TRANSIT_DED_LMT;
      END IF;
      -- ���� => 0 --
      IF NVL(V_PUBLIC_TRANSIT_AMT, 0) < 0 THEN
        V_PUBLIC_TRANSIT_AMT := 0;
      END IF;     
      
      -- �ſ�ī�� ���� �ݾ� --
      V_CARD_AMT := NVL(V_CARD_AMT, 0) + NVL(V_TRAD_MARKET_AMT, 0) +
                    NVL(V_PUBLIC_TRANSIT_AMT, 0);
      IF V_CARD_AMT < 0 THEN
        V_CARD_AMT := 0;
      END IF;
      
      --> �ſ�ī�� ����   UPDATE 
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

  -- 14. �츮�����⿬;
  FUNCTION EMPL_STOCK_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_EMPL_STOCK_AMT              NUMBER := 0; -- �츮�����⿬��  
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.STOCK_LMT, 0) STOCK_LMT
                    --> �츮���������⿬��            
                    , NVL(HF1.EMPL_STOCK_AMT, 0) EMPL_STOCK_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  �������� �����ڷ�  ��ȸ  
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
      --  �츮�����⿬�� 
      V_EMPL_STOCK_AMT := C1.EMPL_STOCK_AMT;
      IF C1.STOCK_LMT < V_EMPL_STOCK_AMT THEN
        V_EMPL_STOCK_AMT := C1.STOCK_LMT;
      END IF;
    
      -- �츮���� ����   UPDATE 
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

  -- 14-1. �ұ��/�һ���� �����αݿ� ���� �ҵ����;
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
                    --> �ұ��/�һ���ΰ����αݾ�;        
                    , NVL(HF1.SMALL_CORPOR_DED_AMT, 0) SMALL_CORPOR_DED_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  �������� �����ڷ�  ��ȸ  
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
      --  �ұ��/�һ���� �����αݾ�;
      V_SMALL_CORPOR_DED_AMT := C1.SMALL_CORPOR_DED_AMT;
      IF C1.SMALL_CORPOR_DED_LMT < V_SMALL_CORPOR_DED_AMT THEN
        V_SMALL_CORPOR_DED_AMT := C1.SMALL_CORPOR_DED_LMT;
      END IF;
    
      --> �ұ��/�һ���� ����   UPDATE 
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

  -- 14-2. ����ֽ�������ҵ����;
  FUNCTION LONG_STOCK_SAVING_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    -- ���� �����ݾ�.
    V_LONG_STOCK_SAVING_AMT       NUMBER := 0;
    -- �����ݾ�.
    V_LONG_STOCK_SAVING_AMT1      NUMBER := 0;
    V_LONG_STOCK_SAVING_AMT2      NUMBER := 0;
    V_LONG_STOCK_SAVING_AMT3      NUMBER := 0;
    
    -- �����ݾ�(�ѵ�üũ).
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
                    --> ����ֽ�������ҵ����;
                    , HF1.SAVING_INFO_ID
                    , NVL(HF1.SAVING_COUNT, 0) SAVING_COUNT
                    , NVL(HF1.SAVING_AMOUNT, 0) SAVING_AMOUNT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  �������� �����ڷ�  ��ȸ  
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
        --  ����ֽ�������ҵ���� 1����;
        V_LONG_STOCK_SAVING_AMT1 := C1.SAVING_AMOUNT;
        IF C1.LONG_STOCK_SAVING_LMT_1 < NVL(V_SUM_LONG_STOCK_SAVING_AMT1, 0) + NVL(V_LONG_STOCK_SAVING_AMT1, 0) THEN
          V_LONG_STOCK_SAVING_AMT1 := NVL(C1.LONG_STOCK_SAVING_LMT_1, 0) - NVL(V_SUM_LONG_STOCK_SAVING_AMT1, 0);
        END IF;
        -- �ѵ� ����;
        V_SUM_LONG_STOCK_SAVING_AMT1 := NVL(V_SUM_LONG_STOCK_SAVING_AMT1, 0) + NVL(V_LONG_STOCK_SAVING_AMT1, 0);
        -- �����ݾ� ���.
        V_LONG_STOCK_SAVING_AMT1 := TRUNC(V_LONG_STOCK_SAVING_AMT1 * (C1.LONG_STOCK_SAVING_RATE_1 / 100));        
        -- ���� �����ݾ�.
        V_LONG_STOCK_SAVING_AMT := NVL(V_LONG_STOCK_SAVING_AMT, 0) + NVL(V_LONG_STOCK_SAVING_AMT1, 0);
      ELSIF C1.SAVING_COUNT = 2 THEN
        --  ����ֽ�������ҵ���� 2����;
        V_LONG_STOCK_SAVING_AMT2 := C1.SAVING_AMOUNT;
        IF C1.LONG_STOCK_SAVING_LMT_2 < NVL(V_SUM_LONG_STOCK_SAVING_AMT2, 0) + NVL(V_LONG_STOCK_SAVING_AMT2, 0) THEN
          V_LONG_STOCK_SAVING_AMT2 := NVL(C1.LONG_STOCK_SAVING_LMT_2, 0) - NVL(V_SUM_LONG_STOCK_SAVING_AMT2, 0);
        END IF;
        -- �ѵ� ����;
        V_SUM_LONG_STOCK_SAVING_AMT2 := NVL(V_SUM_LONG_STOCK_SAVING_AMT2, 0) + NVL(V_LONG_STOCK_SAVING_AMT2, 0);
        -- �����ݾ� ���.
        V_LONG_STOCK_SAVING_AMT2 := TRUNC(V_LONG_STOCK_SAVING_AMT2 * (C1.LONG_STOCK_SAVING_RATE_2 / 100));        
        -- ���� �����ݾ�.
        V_LONG_STOCK_SAVING_AMT := NVL(V_LONG_STOCK_SAVING_AMT, 0) + NVL(V_LONG_STOCK_SAVING_AMT2, 0);
      ELSE
        --  ����ֽ�������ҵ���� 3����;
        V_LONG_STOCK_SAVING_AMT3 := C1.SAVING_AMOUNT;
        IF C1.LONG_STOCK_SAVING_LMT_3 < NVL(V_SUM_LONG_STOCK_SAVING_AMT3, 0) + NVL(V_LONG_STOCK_SAVING_AMT3, 0) THEN
          V_LONG_STOCK_SAVING_AMT3 := NVL(C1.LONG_STOCK_SAVING_LMT_3, 0) - NVL(V_SUM_LONG_STOCK_SAVING_AMT3, 0);
        END IF;
        -- �ѵ� ����;
        V_SUM_LONG_STOCK_SAVING_AMT3 := NVL(V_SUM_LONG_STOCK_SAVING_AMT3, 0) + NVL(V_LONG_STOCK_SAVING_AMT3, 0);
        -- �����ݾ� ���.
        V_LONG_STOCK_SAVING_AMT3 := TRUNC(V_LONG_STOCK_SAVING_AMT3 * (C1.LONG_STOCK_SAVING_RATE_3 / 100));        
        -- ���� �����ݾ�.
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
    
    --> ����ֽ�������ҵ����   UPDATE
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

  -- 14-4. �񵷾ȵ�� ���� ���ڻ�ȯ�� ����;
  FUNCTION FIX_LEASE_DED_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER 
  AS
    V_FIX_LEASE_DED_AMT   NUMBER := 0; -- �񵷾ȵ�� ���� ���ڻ�ȯ��       
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.FIX_LEASE_DED_RATE, 0) AS FIX_LEASE_DED_RATE
                    , NVL(HIT.FIX_LEASE_DED_LMT, 0) AS FIX_LEASE_DED_LMT 
                    --> �񵷾ȵ�� ���� ���ڻ�ȯ��            
                    , NVL(HF1.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  �������� �����ڷ�  ��ȸ  
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
      --  �񵷾ȵ�� ���� ���ڻ�ȯ��     
      V_FIX_LEASE_DED_AMT := TRUNC((C1.FIX_LEASE_DED_AMT * (C1.FIX_LEASE_DED_RATE / 100)));
      IF C1.FIX_LEASE_DED_LMT < V_FIX_LEASE_DED_AMT THEN
        V_FIX_LEASE_DED_AMT := C1.FIX_LEASE_DED_LMT;
      END IF;
    
      -- �񵷾ȵ�� ���� ���ڻ�ȯ�� UPDATE 
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

-- 14-9. Ư������ �����ѵ� �ʰ���;
  FUNCTION SPECIAL_DED_LMT_CAL
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_SP_DED_TOT_AMT        NUMBER := 0; -- 2013-Ư������ �����ѵ� �ʰ��� ����  
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.SP_DED_TOT_LMT, 0) AS SP_DED_TOT_LMT
                    /*-- ��� �׸� -- 
                    -- 1.���强 ����� + 2.��Ÿ�Ƿ�� + 3.��Ÿ ������ + 4.�����������Աݿ����� ��ȯ�� +
                    -- 5.������ + 6.��������������Ա� ���ڻ�ȯ�� + 7.��α� �� ������α�(2013���� ����и�) + 
                    -- 8.���ø������� + 9.�ſ�ī��� ���ݾ� + 10.�ұ��,�һ���� �����α� + 
                    -- 11.�������յ�����(2013�� �������ںи�) + 12.�츮�����⿬��
                    */ 
                    , NVL(HF1.SP_DED_SUM_AMT, 0) AS SP_DED_SUM_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  �������� �����ڷ�  ��ȸ  
                       SELECT HA.YEAR_YYYY
                            , HA.SOB_ID
                            , HA.ORG_ID
                            , ( NVL(HA.GUAR_INSUR_AMT, 0) +    -- 1.���强 ����� 
                                NVL(HA.ETC_MEDIC_AMT, 0) +     -- 2.��Ÿ�Ƿ��  
                                NVL(HA.ETC_EDUCATION_AMT, 0) + -- 3.��Ÿ������  
                                NVL(HA.HOUSE_FUND_AMT, 0) + -- �����ڱ�(�����������Աݻ�ȯ�� + ������ +��������������Ա� + ���ø��������) 
                                NVL(HA.CREDIT_AMT, 0) +    -- �ſ�ī�� 
                                NVL(HA.SMALL_CORPOR_DED_AMT, 0) +    -- 10.�ұ��,�һ���� �����α�  
                                NVL(HA.INVEST_AMT_13, 0) +    -- 11.�������յ�����(2013�� �������ںи�)  
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
      -- Ư������ �����ѵ� �ʰ���  
      V_SP_DED_TOT_AMT := 0; 
      IF C1.SP_DED_TOT_LMT < C1.SP_DED_SUM_AMT THEN
        V_SP_DED_TOT_AMT := NVL(C1.SP_DED_SUM_AMT, 0) - NVL(C1.SP_DED_TOT_LMT, 0);
      END IF;
    
      -- Ư������ �����ѵ� �ʰ��� UPDATE 
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
              
  -- 15. ����ǥ�� ;
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
    V_COMP_TAX_AMT                NUMBER := 0; -- ���⼼��  
    V_TAX_RATE                    NUMBER := 0; -- ���⼼��  
    V_ACCUM_AMT                   NUMBER := 0; -- �����ݾ� 
  BEGIN
    O_STATUS := 'F';
    BEGIN
      --> ���⼼�� ��ȸ  
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
  
    --> ���⼼�� ���  
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

  -- 16.1 ���װ��� - �ҵ漼�� ;
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
      -- �������� ����    
      V_TAX_DED_TAXGROUP_AMT := TRUNC(P_COMP_TAX_AMT * (C1.TAX_ASSO_RATE / 100));
    
      -----> �ٷμҵ� ����   UPDATE 
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

  -- 16.2 ���װ��� - ����Ư�����ѹ� ;
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
      -- �������� ����    
      V_TAX_DED_TAXGROUP_AMT := TRUNC(P_COMP_TAX_AMT * (C1.TAX_ASSO_RATE / 100));
    
      -----> �ٷμҵ� ����   UPDATE 
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

  -- 16.3 ���װ��� - ��������;
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
      -- �������� ����    
      V_TAX_DED_TAXGROUP_AMT := TRUNC(P_COMP_TAX_AMT * (C1.TAX_ASSO_RATE / 100));
    
      -----> �ٷμҵ� ����   UPDATE 
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
            
            
  -- 17.1 �ٷμҵ漼�װ��� ;
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
    V_TAX_DED_AMT                 NUMBER := 0; -- �ٷμҵ� ���װ���
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
      -- �ѵ�  
      IF C1.IN_TAX_LMT < V_TAX_DED_AMT THEN
        V_TAX_DED_AMT := C1.IN_TAX_LMT;
      END IF;
    
-----> �ٷμҵ� ����   UPDATE 
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

  -- 17.2 �������� ���װ���;
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
    V_TAX_DED_TAXGROUP_AMT        NUMBER := 0; -- �������հ����ݾ�  
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
      -- �������� ����    
      V_TAX_DED_TAXGROUP_AMT := TRUNC(P_COMP_TAX_AMT * (C1.TAX_ASSO_RATE / 100));
    
      -----> �ٷμҵ� ����   UPDATE 
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

  -- 17.3 �����ڱ����Ա� ���װ���;
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
    FOR C1 IN ( -- �������� ó������ �� �ٷμҵ����  �׸�  
               SELECT HIT.YEAR_YYYY
                   , NVL(HIT.HOUSE_DEBT_BEN_RATE, 0) HOUSE_DEBT_BEN_RATE
                   , NVL(HIT.SP_TAX_RATE, 0) SP_TAX_RATE
                   --> �������Աݻ�ȯ�� ���װ���              
                   , NVL(HF1.HOUSE_DEBT_BEN_AMT, 0) HOUSE_DEBT_BEN_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  �������� �����ڷ�  ��ȸ  
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
      -- �������Աݻ�ȯ�� ����    
      V_HOUSE_DEBT_BEN_AMT := TRUNC(C1.HOUSE_DEBT_BEN_AMT * (C1.HOUSE_DEBT_BEN_RATE / 100));
    
      /*DBMS_OUTPUT.PUT_LINE('V_HOUSE_DEBT_BEN_AMT -> ' || V_HOUSE_DEBT_BEN_AMT);        
      DBMS_OUTPUT.PUT_LINE('NVL(V_HOUSE_DEBT_BEN_AMT, 0)' || NVL(V_HOUSE_DEBT_BEN_AMT, 0));      
      DBMS_OUTPUT.PUT_LINE('TRUNC(V_HOUSE_DEBT_BEN_AMT / (C1.SP_TAX_RATE / 100), -1)' || TRUNC(V_HOUSE_DEBT_BEN_AMT / (C1.SP_TAX_RATE / 100), -1));        */
    
      -- �ѵ�����.
      IF P_REAL_TAX < V_HOUSE_DEBT_BEN_AMT THEN
        V_HOUSE_DEBT_BEN_AMT := P_REAL_TAX;
      END IF;
      --DBMS_OUTPUT.PUT_LINE('V_HOUSE_DEBT_BEN_AMT -> ' || V_HOUSE_DEBT_BEN_AMT);        
    
      -----> �����ڱ����Ա� ���װ��� 
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
