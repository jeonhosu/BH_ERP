CREATE OR REPLACE PACKAGE HRA_YEAR_ADJUST_SET_G_2010 AS
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
            , P_PERSON_ID         IN NUMBER
            , P_USER_ID           IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , O_ERR_MSG           OUT VARCHAR2
            );

  -- 0. �������� ó�� ��� ����;
  PROCEDURE BASIC_CREATION
            ( P_CORP_ID           IN NUMBER
            , P_YEAR_YYYY         IN VARCHAR2
            , P_STD_DATE          IN DATE
            , P_PERSON_ID         IN NUMBER
            , P_USER_ID           IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , O_ERR_MSG           OUT VARCHAR2
            );

  -- 3.5 �ٷμҵ���� ���;
  FUNCTION INCOME_DED_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;

  -- 4. ��������;
  FUNCTION SUPP_FAMILY_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_STD_DATE          IN DATE
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 5. ����� ����;
  FUNCTION ETC_INSUR_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 6. �Ƿ�� ����;
  FUNCTION MEDIC_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;

  -- 7. ������ ����;
  FUNCTION EDUCATION_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 8-1. �����ڱ� ����(�����������Աݿ����ݻ�ȯ��/��������������Ա����ڻ�ȯ��);
  FUNCTION HOUSE_FUND_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;

  -- 8-2. ���ø�������ҵ����;
  FUNCTION HOUSE_SAVE_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 9. ��α� ����
  FUNCTION DONATION_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_INCOME_AMT        IN NUMBER
            ) RETURN NUMBER;

  -- 10. ȥ��, ���, �̻��� ����;
  FUNCTION MARRY_ETC_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;

  -- 11.1 ���ο�������ҵ����, �������� ����
  FUNCTION PER_ANNU_BANK_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 11.2 ��������ҵ����, �������� ����;
  FUNCTION ANNU_BANK_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 11.3 �������� ���� ;
  FUNCTION RETR_ANNU_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 12. ������������;
  FUNCTION INVEST_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_INCOME_AMT        IN NUMBER
            ) RETURN NUMBER;

  -- 14.1 ����û���������� ���Ծ� �ҵ����;
  FUNCTION HOUSE_APP_DEPOSIT_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_HOUSE_DED_AMT     IN NUMBER
            ) RETURN NUMBER;

  -- 13. �ſ�ī��� ����;
  FUNCTION CARD_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER;

  -- 14. �츮�����⿬;
  FUNCTION EMPL_STOCK_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 14-1. �ұ��/�һ���� �����αݿ� ���� �ҵ����;
  FUNCTION SMALL_CORPOR_DED_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 14-2. ����ֽ�������ҵ����;
  FUNCTION LONG_STOCK_SAVING_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER;

  -- 15. ����ǥ�� ;
  FUNCTION COMP_TAX_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TAX_STD_AMT       IN NUMBER
            ) RETURN NUMBER;

  -- 16.1 �ٷμҵ漼�װ��� ;
  FUNCTION TAX_DED_INCOME_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_COMP_TAX_AMT      IN NUMBER
            ) RETURN NUMBER;

  -- 16.2 �������� ���װ���;
  FUNCTION TAX_DED_TAXGROUP_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_COMP_TAX_AMT      IN NUMBER
            ) RETURN NUMBER;

  -- 16.3 �����ڱ����Ա� ���װ���;
  FUNCTION HOUSE_DEBT_BEN_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_REAL_TAX          IN NUMBER
            ) RETURN NUMBER;

END HRA_YEAR_ADJUST_SET_G_2010;
/
CREATE OR REPLACE PACKAGE BODY HRA_YEAR_ADJUST_SET_G_2010 AS
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
            , P_PERSON_ID         IN NUMBER
            , P_USER_ID           IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , O_ERR_MSG           OUT VARCHAR2
            )
  AS
    V_SYSDATE    DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_STR_MONTH  VARCHAR2(7);
    V_END_MONTH  VARCHAR2(7);
    V_START_DATE DATE;
  
    V_TEMP_AMT   NUMBER;
    V_TEMP_RATE  NUMBER;
    ---------------------------------------------------------------------------------------------------       
    --- ���� ���� �հ�              
    V_PAY_SUM   NUMBER; -- �� �޿��հ�  ;
    V_BONUS_SUM NUMBER; -- �� ���հ� ;  
    V_ADD_BONUS NUMBER; -- �� ������ �հ�   ;
  
    --- ���ܼҵ�       
    V_INCOME_OUTSIDE_AMT NUMBER; -- ���� ���� �ҵ� ; 
    V_NONTAX_OUTSIDE_AMT NUMBER; -- ���� ����� �ҵ�  ;
    V_TAX_OUTSIDE_AMT    NUMBER; -- ���� �ⳳ�μ���  ;                                      
  
    --- �����  
    V_NONTAX_ETC_AMT NUMBER; -- ��Ÿ�����  ;
    V_NONTAX_OT_AMT  NUMBER; -- �߰��ٷκ����  ;
  
    --- ���� ���� �հ�  
    V_IN_TAX_AMT      NUMBER; -- �ҵ漼 �հ�; 
    V_LOCAL_TAX_AMT   NUMBER; -- �ֹμ� �հ�; 
    V_ANNU_INSUR_AMT  NUMBER; -- ���ο���;
    V_MEDIC_INSUR_AMT NUMBER; -- �ǰ����� �հ� ; 
    V_HIRE_INSUR_AMT  NUMBER; -- ��뺸�� �հ� ;
  
    --- ���� ���� �հ�  
    P_PAY_SUM        NUMBER; -- ���� �޿��հ�  ;
    P_BONUS_SUM      NUMBER; -- ���� ���հ� ; 
    P_ADD_BONUS      NUMBER; -- ���� ������ �հ� ; 
    P_STOCK_BENE_AMT NUMBER; -- ���� �ֽð������ñ��������  ;
  
    P_IN_TAX_AMT      NUMBER; -- �ҵ漼 �հ� ; 
    P_LOCAL_TAX_AMT   NUMBER; -- �ֹμ� �հ� ; 
    P_ANNU_INSUR_AMT  NUMBER; -- ���ο���;
    P_MEDIC_INSUR_AMT NUMBER; -- �ǰ����� �հ�  ;
    P_HIRE_INSUR_AMT  NUMBER; -- ��뺸�� �հ�  ;
    ---------------------------------------------------------------------------------------------------  
    V_TOTAL_PAY NUMBER; -- �� �޿�(�� �޿��հ� + ���� �޿��հ�);
  
    V_INCOME_DED_AMT NUMBER; -- �ٷμҵ���� �ݾ�  ;
    V_INCOME_PAY     NUMBER; -- �����޾� - �ٷμҵ���� �ݾ� ;
    V_REAL_TAX       NUMBER; -- �Ǽ��ݾ� 
  
    V_SUPP_FAMILY_DED_AMT NUMBER; -- �������� �հ�  ;    
    V_INSURE_DED_AMT      NUMBER; -- ����� �հ�  ; 
    V_MEDIC_DED_AMT       NUMBER; -- �Ƿ�� �հ� ;
    V_EDU_DED_AMT         NUMBER; -- ������ �հ� ;
    V_HOUSE_DED_AMT       NUMBER; -- �����ڱ� �հ�; 
    V_DONAT_DED_AMT       NUMBER; -- ��α� �հ� ;
    V_MARRY_ETC_DED_AMT   NUMBER; -- ȥ������̻� �հ� ;
  
    V_SP_STD_DED_AMT NUMBER; -- ǥ�ذ��� ;
    V_SP_DED_SUM     NUMBER; -- Ư������ �հ� ;
    V_SUBT_DED_AMT   NUMBER; -- �����ҵ���� ; 
  
    V_PER_ANNU_BANK_AMT NUMBER; -- ���ο�������;  
    V_ANNU_BANK_AMT     NUMBER; -- ��������  ;
    V_RETR_ANNU_AMT     NUMBER; -- ������������  ;
    V_INVEST_AMT        NUMBER; -- �������� ����;
    V_CARD_AMT          NUMBER; -- �ſ�ī��, ���ݿ����� ���� ;
    V_EMPL_STOCK_AMT    NUMBER; -- �츮�����⿬��  ;
    --> 2008�⵵ �߰�;     
    V_SMALL_CORPOR_DED_AMT NUMBER; -- �ұ��/�һ��� �����αݾ�;       
    V_HOUSE_SAVE_AMT       NUMBER; -- ���ø����������;
    --> 2011�⵵ �߰�;     
    V_HOUSE_APP_DEPOSIT_AMT NUMBER; -- ����û���������� ���Ծ� �ҵ����;
  
    V_LONG_STOCK_SAVING_AMT NUMBER; -- ����ֽ�����;;
  
    V_ETC_DED_SUM NUMBER; -- ��Ÿ�ҵ���� ��  ;
  
    V_TAX_STD_AMT  NUMBER; -- ����ǥ�� ; 
    V_COMP_TAX_AMT NUMBER; -- ���⼼�� ; 
  
    F_IN_TAX_AMT    NUMBER; -- �����ҵ漼 �հ� ; 
    F_SP_TAX_AMT    NUMBER; -- ������Ư�� �հ�.;
    F_LOCAL_TAX_AMT NUMBER; -- �����ֹμ� �հ�  ;
    S_IN_TAX_AMT    NUMBER; -- �����ҵ漼 �հ�;  
    S_SP_TAX_AMT    NUMBER; -- ������Ư�� �հ�.;
    S_LOCAL_TAX_AMT NUMBER; -- �����ֹμ� �հ�  ;
  
---------------------------------------------------------------------------------------------------     
    V_ERR_MSG      VARCHAR2(500);
    V_RECORD_COUNT NUMBER;
    
  BEGIN
---> �ʱ�ȭ  
    BEGIN
      V_ERR_MSG   := NULL;
      V_STR_MONTH := P_YEAR_YYYY || '-01';
      V_END_MONTH := P_YEAR_YYYY || '-12';
      V_START_DATE := TRUNC(P_STD_DATE, 'MONTH');      
    EXCEPTION
      WHEN OTHERS THEN
        V_START_DATE := P_STD_DATE;
    END;
--DBMS_OUTPUT.PUT_LINE('V_STR_MONTH -> ' || V_STR_MONTH || 'V_END_MONTH -> ' || V_END_MONTH);        
  
    V_RECORD_COUNT := 0;
    BEGIN
      SELECT COUNT(HIT.YEAR_YYYY) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRA_INCOME_TAX_STANDARD HIT
      WHERE HIT.NATION_CODE      = '101'
        AND HIT.YEAR_YYYY        = P_YEAR_YYYY
        AND HIT.SOB_ID           = P_SOB_ID
        AND HIT.ORG_ID           = P_ORG_ID
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT = 0 THEN
      O_ERR_MSG := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10244', NULL);
      RETURN;
    END IF;
  
    V_RECORD_COUNT := 0;
    BEGIN
      SELECT COUNT(HT.TAX_YYYY) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRA_TAX_RATE HT
      WHERE HT.TAX_YYYY          = P_YEAR_YYYY
        AND EXISTS ( SELECT 'X'
                       FROM HRM_COMMON HC
                     WHERE HC.COMMON_ID     = HT.TAX_TYPE_ID
                       AND HC.SOB_ID        = HT.SOB_ID
                       AND HC.ORG_ID        = HT.ORG_ID
                       AND HC.GROUP_CODE    = 'TAX_TYPE'
                       AND HC.CODE          = '10'
                   )
        AND HT.SOB_ID            = P_SOB_ID
        AND HT.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT = 0 THEN
      O_ERR_MSG := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10245', NULL);
      RETURN;
    END IF;
    
---> 0. �������� ó�� �����ڷ� ����  
    BASIC_CREATION
          ( P_CORP_ID           => P_CORP_ID
          , P_YEAR_YYYY         => P_YEAR_YYYY
          , P_STD_DATE          => P_STD_DATE
          , P_PERSON_ID         => P_PERSON_ID
          , P_USER_ID           => P_USER_ID
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , O_ERR_MSG           => V_ERR_MSG
          );
    IF V_ERR_MSG IS NOT NULL THEN
      ROLLBACK;
      O_ERR_MSG := V_ERR_MSG;
      RETURN;
    END IF;

---> 1. �ξ簡�� ���� ���� üũ.
    FOR C1 IN (SELECT HA.PERSON_ID
                   , PM.DISPLAY_NAME
                 FROM HRM_PERSON_MASTER PM
                   , HRA_YEAR_ADJUSTMENT HA
                WHERE PM.PERSON_ID      = HA.PERSON_ID
                  AND PM.SOB_ID         = HA.SOB_ID
                  AND PM.ORG_ID         = HA.ORG_ID                  
                  AND HA.YEAR_YYYY      = P_YEAR_YYYY
                  AND PM.CORP_ID        = P_CORP_ID                  
                  AND PM.PERSON_ID      = NVL(P_PERSON_ID, PM.PERSON_ID)                  
                  AND PM.SOB_ID         = P_SOB_ID
                  AND PM.ORG_ID         = P_ORG_ID
                  AND PM.ORI_JOIN_DATE  <= P_STD_DATE
                  AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= V_START_DATE)
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
        O_ERR_MSG := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10325', '&&NAME:=' || C1.DISPLAY_NAME);
        RETURN;
      END IF;
    END LOOP C1;

---> �������� ��� ����;
    FOR C1 IN (SELECT HA.PERSON_ID
                   , PM.PERSON_NUM
                   , PM.NAME
                   , PM.CORP_ID
                   , PM.DEPT_ID
                   , PM.ORI_JOIN_DATE
                   , PM.JOIN_DATE
                   , PM.RETIRE_DATE
                   , PM.EMPLOYE_TYPE
                   , HA.PAY_TYPE
                   , NVL(HIT1.DRIVE_DED_LMT, 0) DRIVE_DED_LMT -- �ڰ�����������;
                   , NVL(HIT1.MONTH_PAY_STD, 0) MONTH_PAY_STD -- �߰��ٷμ��� ���� �޿� ����;
                   , NVL(HIT1.OT_DED_LMT, 0) OT_DED_LMT -- �߰��ٷμ��� �ѵ�;
                   , NVL(HIT1.SP_DED_STD, 0) SP_DED_STD -- ǥ�ذ��� ���ؾ�;
                   , NVL(HIT1.SP_DED_AMT, 0) SP_DED_AMT -- ǥ�ذ����ݾ�;
                   , NVL(HIT1.LOCAL_TAX_RATE, 1) LOCAL_TAX_RATE -- �ҵ漼 ����;
                 FROM HRM_PERSON_MASTER PM
                   , HRA_YEAR_ADJUSTMENT HA
                   , ( -- �����������;
                      SELECT HIT.YEAR_YYYY
                          , HIT.DRIVE_DED_LMT
                          , HIT.MONTH_PAY_STD
                          , HIT.OT_DED_LMT
                          , HIT.SP_DED_STD
                          , HIT.SP_DED_AMT
                          , HIT.LOCAL_TAX_RATE
                        FROM HRA_INCOME_TAX_STANDARD HIT
                      WHERE HIT.NATION_CODE     = '101'
                        AND HIT.YEAR_YYYY       = P_YEAR_YYYY
                        AND HIT.SOB_ID          = P_SOB_ID
                        AND HIT.ORG_ID          = P_ORG_ID
                     ) HIT1
                WHERE P_YEAR_YYYY       = HIT1.YEAR_YYYY
                  AND PM.PERSON_ID      = HA.PERSON_ID
                  AND HA.YEAR_YYYY      = P_YEAR_YYYY
                  AND PM.CORP_ID        = P_CORP_ID                  
                  AND PM.PERSON_ID      = NVL(P_PERSON_ID, PM.PERSON_ID)                  
                  AND PM.SOB_ID         = P_SOB_ID
                  AND PM.ORG_ID         = P_ORG_ID
                  AND PM.ORI_JOIN_DATE  <= P_STD_DATE
                  AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= V_START_DATE)
               ) 
    LOOP
----- ���� �ʱ�ȭ  -----------------------------------------------------------------------------------------------------                       
      V_PAY_SUM   := 0; -- �� �޿��հ� ; 
      V_BONUS_SUM := 0; -- �� ���հ� ;  
      V_ADD_BONUS := 0; -- �� ������ �հ�  ; 
    
      --- ���ܼҵ�       
      V_INCOME_OUTSIDE_AMT := 0; -- ���� ���� �ҵ�  ;
      V_NONTAX_OUTSIDE_AMT := 0; -- ���� ����� �ҵ�  ;
      V_TAX_OUTSIDE_AMT    := 0; -- ���� �ⳳ�μ���  ;                                      
    
      --- �����  
      V_NONTAX_ETC_AMT := 0; -- ��Ÿ�����  ;
      V_NONTAX_OT_AMT  := 0; -- �߰��ٷκ����;  
    
      --- ���� ���� �հ�  
      V_IN_TAX_AMT      := 0; -- �ҵ漼 �հ�;  
      V_LOCAL_TAX_AMT   := 0; -- �ֹμ� �հ�;  
      V_ANNU_INSUR_AMT  := 0; -- ���ο���;
      V_MEDIC_INSUR_AMT := 0; -- �ǰ����� �հ�;  
      V_HIRE_INSUR_AMT  := 0; -- ��뺸�� �հ�;  
    
      --- ���� ���� �հ�  
      P_PAY_SUM        := 0; -- ���� �޿��հ�;  
      P_BONUS_SUM      := 0; -- ���� ���հ�;  
      P_ADD_BONUS      := 0; -- ���� ������ �հ�;  
      P_STOCK_BENE_AMT := 0; -- ���� �ֽð������ñ��������;  
    
      P_IN_TAX_AMT      := 0; -- �ҵ漼 �հ�;  
      P_LOCAL_TAX_AMT   := 0; -- �ֹμ� �հ�;  
      P_ANNU_INSUR_AMT  := 0; -- ���ο���;
      P_MEDIC_INSUR_AMT := 0; -- �ǰ����� �հ�  ;
      P_HIRE_INSUR_AMT  := 0; -- ��뺸�� �հ�  ;
---------------------------------------------------------------------------------------------------  
      V_TOTAL_PAY := 0; -- �� �޿�(�� �޿��հ� + ���� �޿��հ�);
    
      V_INCOME_DED_AMT := 0; -- �ٷμҵ���� �ݾ�  ;
      V_INCOME_PAY     := 0; -- �����޾� - �ٷμҵ���� �ݾ�;  
      V_REAL_TAX       := 0; -- �Ǽ��ݾ� ;
    
      V_SUPP_FAMILY_DED_AMT := 0; -- �������� �հ� ;     
      V_INSURE_DED_AMT      := 0; -- ����� �հ� ;  
      V_MEDIC_DED_AMT       := 0; -- �Ƿ�� �հ� ;
      V_EDU_DED_AMT         := 0; -- ������ �հ� ;
      V_HOUSE_DED_AMT       := 0; -- �����ڱ� �հ�;
      V_DONAT_DED_AMT       := 0; -- ��α� �հ� ;
      V_MARRY_ETC_DED_AMT   := 0; -- ȥ������̻� �հ� ;
    
      V_SP_STD_DED_AMT := 0; -- ǥ�ذ��� ;
      V_SP_DED_SUM     := 0; -- Ư������ �հ� ;
      V_SUBT_DED_AMT   := 0; -- �����ҵ����;  
    
      V_PER_ANNU_BANK_AMT := 0; -- ���ο������� ; 
      V_ANNU_BANK_AMT     := 0; -- ��������  ;
      V_RETR_ANNU_AMT     := 0; -- ������������ ; 
      V_INVEST_AMT        := 0; -- �������� ����; 
      V_CARD_AMT          := 0; -- �ſ�ī��, ���ݿ����� ���� ;
      V_EMPL_STOCK_AMT    := 0; -- �츮�����⿬�� ;
      --> 2008�⵵ �߰�;     
      V_SMALL_CORPOR_DED_AMT := 0; -- �ұ��/�һ��� �����αݾ�;     
      V_HOUSE_SAVE_AMT       := 0; -- ���ø����������;  
      --> 2011.01.17 BY YOUNG MIN
      V_HOUSE_APP_DEPOSIT_AMT := 0; -- ����û���������� ���Ծ� �ҵ����;  
    
      V_LONG_STOCK_SAVING_AMT := 0; -- ����ֽ�����;;
    
      V_ETC_DED_SUM := 0; -- ��Ÿ�ҵ���� ��  ;
    
      V_TAX_STD_AMT  := 0; -- ����ǥ�� ; 
      V_COMP_TAX_AMT := 0; -- ���⼼�� ; 
    
      F_IN_TAX_AMT    := 0; -- �����ҵ漼 �հ� ; 
      F_SP_TAX_AMT    := 0; -- ������Ư�� �հ�.;
      F_LOCAL_TAX_AMT := 0; -- �����ֹμ� �հ�  ;
      S_IN_TAX_AMT    := 0; -- �����ҵ漼 �հ� ; 
      S_SP_TAX_AMT    := 0; -- ������Ư�� �հ�.;
      S_LOCAL_TAX_AMT := 0; -- �����ֹμ� �հ�; 
    
---------------------------------------------------------------------------------------------------     
      V_ERR_MSG := TO_CHAR(NULL);
    
----- �ѱ޿�, �ѻ�, ��Ÿ�����, �߰��ٷμ��� ����  ------------------------------------------------------------------------------             
      FOR C1S IN ( -- �ѱ޿�, �����, ����� �޿� 
                  SELECT A.PERSON_ID
                      , A.PAY_YYYYMM
                      , SUM(A.TOT_PAY_AMOUNT) AS TOT_PAY_AMOUNT
                      , SUM(A.PAY_AMT) PAY_AMT
                      , SUM(A.BONUS_AMT) BONUS_AMT
                      , SUM(A.NONTAX_ETC_AMT) NONTAX_ETC_AMT
                      , SUM(A.NONTAX_OT_AMT) NONTAX_OT_AMT
                      , SUM(A.AVG_PAY_AMT) AVG_PAY_AMT
                    FROM ( 
                          SELECT MP.PERSON_ID
                              , MP.PAY_YYYYMM
                              , SUM(CASE
                                      WHEN MP.WAGE_TYPE = 'P1' THEN MA.ALLOWANCE_AMOUNT
                                      ELSE 0
                                    END) AS TOT_PAY_AMOUNT
                              , SUM(CASE
                                      WHEN HA.ALLOWANCE_CODE IN ('A09', 'A16') THEN 0
                                      ELSE MA.ALLOWANCE_AMOUNT
                                    END) PAY_AMT
                              , SUM(CASE
                                      WHEN HA.ALLOWANCE_CODE IN ('A09', 'A16') THEN MA.ALLOWANCE_AMOUNT
                                      ELSE 0
                                    END) BONUS_AMT
                              , SUM(CASE
                                      WHEN HA.TAX_FREE IN ('ETC') THEN MA.ALLOWANCE_AMOUNT
                                      ELSE 0
                                    END) NONTAX_ETC_AMT
                              , SUM(CASE
                                      WHEN HA.TAX_FREE IN ('OT') THEN MA.ALLOWANCE_AMOUNT
                                      ELSE 0
                                    END) NONTAX_OT_AMT
                              , SUM(CASE
                                      WHEN HA.GENERAL_PAY_YN = 'Y' /*IN 
                                           ('A01', 'A02', 'A03', 'A04', 'A06', 'A08',
                                            'A11', 'A24', 'A25', 'A33')*/ THEN MA.ALLOWANCE_AMOUNT
                                      ELSE 0
                                    END) AVG_PAY_AMT
                             FROM HRP_MONTH_PAYMENT MP
                               , HRP_MONTH_ALLOWANCE MA
                               , HRM_ALLOWANCE_V HA
                         WHERE MP.PAY_YYYYMM      = MA.PAY_YYYYMM
                           AND MP.WAGE_TYPE       = MA.WAGE_TYPE
                           AND MP.PERSON_ID       = MA.PERSON_ID
                           AND MP.SOB_ID          = MA.SOB_ID
                           AND MP.ORG_ID          = MA.ORG_ID
                           AND MA.ALLOWANCE_ID    = HA.ALLOWANCE_ID
                           AND MP.PAY_YYYYMM      BETWEEN V_STR_MONTH AND V_END_MONTH
                           AND MP.WAGE_TYPE       IN ('P1', 'P2', 'P4', 'P5')
                           AND MP.PERSON_ID       = C1.PERSON_ID
                           AND MP.SOB_ID          = P_SOB_ID
                           AND MP.ORG_ID          = P_ORG_ID
                           AND HA.ALLOWANCE_CODE  LIKE 'A%'
                         GROUP BY MP.PERSON_ID, MP.PAY_YYYYMM
                        ) A
                   GROUP BY A.PERSON_ID, A.PAY_YYYYMM
                   ) 
      LOOP      
        --> �� �ٹ��� �޿� �հ� 
        V_PAY_SUM   := V_PAY_SUM + NVL(C1S.PAY_AMT, 0);
        V_BONUS_SUM := V_BONUS_SUM + NVL(C1S.BONUS_AMT, 0);
      
        --> ���������� �ѵ� üũ(�ѵ� �ʰ��� �ѱ޿��� ����). 
        V_TEMP_AMT := 0;
        BEGIN
          SELECT CASE -- ���������� �����ó��.
                   WHEN C1.DRIVE_DED_LMT < C1S.NONTAX_ETC_AMT THEN NVL(C1.DRIVE_DED_LMT, 0)
                   ELSE NVL(C1S.NONTAX_ETC_AMT, 0)
                 END NONTAX_ETC_AMT
            INTO V_TEMP_AMT
            FROM DUAL;
        EXCEPTION
          WHEN OTHERS THEN
            V_TEMP_AMT := 0;
        END;
        V_NONTAX_ETC_AMT := V_NONTAX_ETC_AMT + NVL(V_TEMP_AMT, 0);
      
        --> ������ �����ٷμ��� ����� üũ (100���� ����).  
        IF C1.PAY_TYPE IN ('2', '4') AND C1S.TOT_PAY_AMOUNT <= C1.MONTH_PAY_STD /*C1S.AVG_PAY_AMT <= C1.MONTH_PAY_STD*/ THEN
          BEGIN
            V_NONTAX_OT_AMT := V_NONTAX_OT_AMT + NVL(C1S.NONTAX_OT_AMT, 0);
          EXCEPTION
            WHEN OTHERS THEN
              V_NONTAX_OT_AMT := V_NONTAX_OT_AMT;
          END;
        END IF;
      END LOOP C1S;
      --> ������ �߰��ٷμ��� �ѵ� ����.
      SELECT CASE
               WHEN C1.OT_DED_LMT < V_NONTAX_OT_AMT THEN
                NVL(C1.OT_DED_LMT, 0)
               ELSE
                V_NONTAX_OT_AMT
             END NONTAX_OT_AMT
        INTO V_NONTAX_OT_AMT
        FROM DUAL;
    
-- �ⳳ�� ����, ���ο���, �ǰ�����, ��뺸�� ���� ------------------------------------------------------------------------------------------                       
      BEGIN
        SELECT SUM(CASE
                     WHEN HD.DEDUCTION_CODE = 'D01' THEN MD.DEDUCTION_AMOUNT
                     ELSE 0
                   END) AS IN_TAX_AMT
            , SUM(CASE
                   WHEN HD.DEDUCTION_CODE = 'D02' THEN MD.DEDUCTION_AMOUNT
                   ELSE 0
                 END) AS LOCAL_TAX_AMT
            , SUM(CASE
                   WHEN HD.DEDUCTION_CODE IN('D03', 'D08') THEN MD.DEDUCTION_AMOUNT
                   ELSE 0
                 END) AS ANNU_INSUR_AMT
            , SUM(CASE
                   WHEN HD.DEDUCTION_CODE = 'D04' THEN MD.DEDUCTION_AMOUNT
                   ELSE 0
                 END) AS HIRE_INSUR_AMT
            , SUM(CASE
                   WHEN HD.DEDUCTION_CODE IN('D05', 'D07') THEN MD.DEDUCTION_AMOUNT
                   ELSE 0
                 END) AS MEDIC_INSUR_AMT
          INTO V_IN_TAX_AMT,
               V_LOCAL_TAX_AMT,
               V_ANNU_INSUR_AMT,
               V_HIRE_INSUR_AMT,
               V_MEDIC_INSUR_AMT
          FROM HRP_MONTH_PAYMENT MP
            , HRP_MONTH_DEDUCTION MD
            , HRM_DEDUCTION_V HD
         WHERE MP.PAY_YYYYMM      = MD.PAY_YYYYMM
           AND MP.WAGE_TYPE       = MD.WAGE_TYPE
           AND MP.PERSON_ID       = MD.PERSON_ID
           AND MP.SOB_ID          = MD.SOB_ID
           AND MP.ORG_ID          = MD.ORG_ID
           AND MD.DEDUCTION_ID    = HD.DEDUCTION_ID
           AND MP.PAY_YYYYMM      BETWEEN V_STR_MONTH AND V_END_MONTH
           AND MP.WAGE_TYPE       IN ('P1', 'P2', 'P4', 'P5')
           AND MP.PERSON_ID       = C1.PERSON_ID
           AND MP.SOB_ID          = P_SOB_ID
           AND MP.ORG_ID          = P_ORG_ID
         GROUP BY MP.PERSON_ID
         ;
      EXCEPTION
        WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('�ⳳ�� ���׵� ���� ���� :' || SUBSTR(SQLERRM, 1, 150));
          V_IN_TAX_AMT      := 0;
          V_LOCAL_TAX_AMT   := 0;
          V_ANNU_INSUR_AMT  := 0;
          V_HIRE_INSUR_AMT  := 0;
          V_MEDIC_INSUR_AMT := 0;
      END;
    
--DBMS_OUTPUT.PUT_LINE('�޿����⳻��=> �ѱ޿�->' || V_TOTAL_PAY || '/�ѻ�->' || V_TOTAL_BONUS || '/��Ÿ�����=>' || V_NONTAX_ETC_AMT || '/�߰������=>' || V_NONTAX_OT_AMT);        
-- ������, ���ڱ�, ��Ÿ����, ���� �ҵ� �ڷ� ----------------------------------------------------------------------------------------------                       
      BEGIN
        SELECT NVL(HF.ADD_BONUS_AMT, 0) + NVL(HF.ADD_EDUCATION_AMT, 0) +
               NVL(HF.ADD_ETC_AMT, 0) AS ADD_BONUS,
               NVL(HF.INCOME_OUTSIDE_AMT, 0) INCOME_OUTSIDE_AMT,
               NVL(HF.NONTAX_OUTSIDE_AMT, 0) NONTAX_OUTSIDE_AMT,
               NVL(HF.TAX_OUTSIDE_AMT, 0) TAX_OUTSIDE_AMT,
               -- �ⳳ�� ���� : ��ȣ�� �߰�..
               NVL(V_IN_TAX_AMT, 0) + NVL(HF.IN_TAX_AMT, 0) IN_TAX_AMT,
               NVL(V_LOCAL_TAX_AMT, 0) + NVL(HF.LOCAL_TAX_AMT, 0) LOCAL_TAX_AMT
          INTO V_ADD_BONUS,
               V_INCOME_OUTSIDE_AMT,
               V_NONTAX_OUTSIDE_AMT,
               V_TAX_OUTSIDE_AMT,
               V_IN_TAX_AMT,
               V_LOCAL_TAX_AMT
          FROM HRA_FOUNDATION HF
        WHERE HF.YEAR_YYYY       = P_YEAR_YYYY
          AND HF.PERSON_ID       = C1.PERSON_ID
          AND HF.SOB_ID          = P_SOB_ID
          AND HF.ORG_ID          = P_ORG_ID
        ;
      EXCEPTION
        WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('�����󿩵� ��Ÿ�ڷ� ���� ���� :' || SUBSTR(SQLERRM, 1, 150));
          V_ADD_BONUS          := 0;
          V_INCOME_OUTSIDE_AMT := 0;
          V_NONTAX_OUTSIDE_AMT := 0;
          V_TAX_OUTSIDE_AMT    := 0;
      END;
    
--DBMS_OUTPUT.PUT_LINE('�ⳳ�γ���=> �ҵ漼=>' || V_IN_TAX_AMT || '/�ֹμ�=>' || V_LOCAL_TAX_AMT || '/���ο���=>' || V_ANNU_INSUR_AMT || '/��뺸��=>' || V_HIRE_INSUR_AMT || '/�ǰ�����=>' || V_MEDIC_INSUR_AMT);        
-- �����ٹ��� �ڷ� ��ȸ  -----------------------------------------------------------------------------------------------------------                       
      BEGIN
        SELECT SUM(HPW.PAY_TOTAL_AMT) PAY_TOTAL_AMT
            , SUM(HPW.BONUS_TOTAL_AMT) BONUS_TOTAL_AMT
            , SUM(HPW.ADD_BONUS_AMT) ADD_BONUS_AMT
            , SUM(HPW.STOCK_BENE_AMT) STOCK_NENE_AMT
            , SUM(HPW.MEDIC_INSUR_AMT) MEDIC_INSUR_AMT
            , SUM(HPW.HIRE_INSUR_AMT) HIRE_INSUR_AMT
            , SUM(HPW.ANNU_INSUR_AMT) ANNU_INSUR_AMT
            , SUM(HPW.IN_TAX_AMT) IN_TAX_AMT
            , SUM(HPW.LOCAL_TAX_AMT) LOCAL_TAX_AMT
          INTO P_PAY_SUM,
               P_BONUS_SUM,
               P_ADD_BONUS,
               P_STOCK_BENE_AMT,
               P_MEDIC_INSUR_AMT,
               P_HIRE_INSUR_AMT,
               P_ANNU_INSUR_AMT,
               P_IN_TAX_AMT,
               P_LOCAL_TAX_AMT
          FROM HRA_PREVIOUS_WORK HPW
        WHERE HPW.YEAR_YYYY   = P_YEAR_YYYY
          AND HPW.PERSON_ID   = C1.PERSON_ID
          AND HPW.SOB_ID      = P_SOB_ID
          AND HPW.ORG_ID      = P_ORG_ID         
        GROUP BY HPW.PERSON_ID
        ;
      EXCEPTION
        WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('���� �ٹ��� �ڷ� ���� ���� :' || SUBSTR(SQLERRM, 1, 150));
          P_PAY_SUM         := 0;
          P_BONUS_SUM       := 0;
          P_ADD_BONUS       := 0;
          P_STOCK_BENE_AMT  := 0;
          P_MEDIC_INSUR_AMT := 0;
          P_HIRE_INSUR_AMT  := 0;
          P_ANNU_INSUR_AMT  := 0;
          P_IN_TAX_AMT      := 0;
          P_LOCAL_TAX_AMT   := 0;
      END;
      --> �޿��������� ����� �ݾ� ����.
      V_PAY_SUM := NVL(V_PAY_SUM, 0) - NVL(V_NONTAX_ETC_AMT, 0) - NVL(V_NONTAX_OT_AMT, 0);
      V_INCOME_OUTSIDE_AMT := NVL(V_INCOME_OUTSIDE_AMT, 0) - NVL(V_NONTAX_OUTSIDE_AMT, 0);
    
      --> �� �޿��� + ���� �޿���    
      V_TOTAL_PAY := NVL(V_PAY_SUM, 0) + NVL(P_PAY_SUM, 0);
      V_TOTAL_PAY := NVL(V_TOTAL_PAY, 0) + NVL(V_BONUS_SUM, 0) + NVL(P_BONUS_SUM, 0);
      V_TOTAL_PAY := NVL(V_TOTAL_PAY, 0) + NVL(V_ADD_BONUS, 0) + NVL(P_ADD_BONUS, 0);
      V_TOTAL_PAY := NVL(V_TOTAL_PAY, 0) + NVL(V_INCOME_OUTSIDE_AMT, 0) + NVL(P_STOCK_BENE_AMT, 0);
    
      --> �ѱ޿� - �����(����� ��ȸ �ѱ޿� �հ�)          
      --  V_TOTAL_PAY := V_TOTAL_PAY - V_NONTAX_ETC_AMT - V_NONTAX_OT_AMT - V_NONTAX_OUTSIDE_AMT ;
    
      -- 3.5 �ٷμҵ� ���� ���                          
      V_INCOME_DED_AMT := INCOME_DED_CAL
                          ( '101'
                          , P_YEAR_YYYY
                          , P_SOB_ID
                          , P_ORG_ID
                          , V_TOTAL_PAY
                          );
      V_REAL_TAX := NVL(V_TOTAL_PAY, 0) - NVL(V_INCOME_DED_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
      
----- �ѱ޿� - �ٷμҵ���� ���  
      V_INCOME_PAY := NVL(V_TOTAL_PAY, 0) - NVL(V_INCOME_DED_AMT, 0);
    
      -- ���� �����ϸ� ���� ���   
      V_REAL_TAX := V_INCOME_PAY;
    
-- ���ٹ���(�޿�/��/������/���ڱ�/�ⳳ�μ��׵�), ���ٹ����ڷ� UPDATE -----------------------------------------------------------------------                       
      UPDATE HRA_YEAR_ADJUSTMENT HA
        SET HA.NOW_PAY_TOT_AMT    = V_PAY_SUM
          , HA.NOW_BONUS_TOT_AMT  = V_BONUS_SUM
          , HA.NOW_ADD_BONUS_AMT  = V_ADD_BONUS
          , HA.NOW_STOCK_BENE_AMT = 0
          , HA.PRE_PAY_TOT_AMT    = P_PAY_SUM
          , HA.PRE_BONUS_TOT_AMT  = P_BONUS_SUM
          , HA.PRE_ADD_BONUS_AMT  = P_ADD_BONUS
          , HA.PRE_STOCK_BENE_AMT = P_STOCK_BENE_AMT
          , HA.INCOME_OUTSIDE_AMT = V_INCOME_OUTSIDE_AMT
          -- �����   
          , HA.NONTAX_OUTSIDE_AMT = V_NONTAX_OUTSIDE_AMT
          , HA.NONTAX_OT_AMT      = V_NONTAX_OT_AMT
          , HA.NONTAX_RESEA_AMT   = 0
          , HA.NONTAX_ETC_AMT     = V_NONTAX_ETC_AMT
          --> �ѱٷμҵ��հ�(�Ѽҵ�-�����)  
          , HA.INCOME_TOT_AMT     = V_TOTAL_PAY
          , HA.INCOME_DED_AMT     = V_INCOME_DED_AMT
          , HA.NATI_ANNU_AMT      = V_ANNU_INSUR_AMT + P_ANNU_INSUR_AMT
          , HA.RETR_ANNU_AMT      = 0
          , HA.MEDIC_INSUR_AMT    = V_MEDIC_INSUR_AMT + P_MEDIC_INSUR_AMT
          , HA.HIRE_INSUR_AMT     = V_HIRE_INSUR_AMT + P_HIRE_INSUR_AMT
          --> �ܱ����μ��� 
          , HA.TAX_DED_OUTSIDE_PAY_AMT = V_TAX_OUTSIDE_AMT
          --> �ⳳ�μ���                 
          , HA.PRE_IN_TAX_AMT     = V_IN_TAX_AMT + P_IN_TAX_AMT
          , HA.PRE_LOCAL_TAX_AMT  = V_LOCAL_TAX_AMT + P_LOCAL_TAX_AMT
          , HA.PRE_SP_TAX_AMT     = 0
      WHERE HA.YEAR_YYYY          = P_YEAR_YYYY
        AND HA.PERSON_ID          = C1.PERSON_ID
        AND HA.SOB_ID             = P_SOB_ID
        AND HA.ORG_ID             = P_ORG_ID
      ;
-------------------------------------------------------------------------------------------------------------------------------        
      -- 4. �������� ��� 
      V_RECORD_COUNT := 0;
      BEGIN
        SELECT COUNT(SF.PERSON_ID) AS PERSON_COUNT
          INTO V_RECORD_COUNT
          FROM HRA_SUPPORT_FAMILY SF
        WHERE SF.YEAR_YYYY        = P_YEAR_YYYY
          AND SF.PERSON_ID        = C1.PERSON_ID
          AND SF.RELATION_CODE    = '0'
          AND SF.SOB_ID           = P_SOB_ID
          AND SF.ORG_ID           = P_ORG_ID
        ;
      EXCEPTION
        WHEN OTHERS THEN
          V_RECORD_COUNT := 0;
      END;
      IF V_RECORD_COUNT = 0 THEN
        ROLLBACK;
        O_ERR_MSG := '**' || C1.NAME || '(' || C1.PERSON_NUM ||
                     ')**�� �������� ó���� ���� �ξ簡���� ��ϵ��� �ʾҽ��ϴ�. �ξ簡���� ����� �ٽ� �۾��Ͻʽÿ�';
        RETURN;
      END IF;
    
      V_SUPP_FAMILY_DED_AMT := SUPP_FAMILY_CAL
                                ( '101'
                                , P_YEAR_YYYY
                                , P_STD_DATE
                                , C1.PERSON_ID
                                , P_SOB_ID
                                , P_ORG_ID
                                );
      V_REAL_TAX := V_REAL_TAX - V_SUPP_FAMILY_DED_AMT;
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------        
      -- 11.3 ���� ��������  ���� ��� 
      V_RETR_ANNU_AMT := RETR_ANNU_CAL
                           ( '101'
                           , P_YEAR_YYYY
                           , C1.PERSON_ID
                           , P_SOB_ID
                           , P_ORG_ID
                           );
      IF V_RETR_ANNU_AMT < 0 THEN
        V_RETR_ANNU_AMT := 0;
      END IF;
      V_REAL_TAX := V_REAL_TAX - V_RETR_ANNU_AMT;
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------        
      -- 5. �������� ��� 
      V_INSURE_DED_AMT := ETC_INSUR_CAL
                            ( '101'
                            , P_YEAR_YYYY
                            , C1.PERSON_ID
                            , P_SOB_ID
                            , P_ORG_ID
                            );
      IF NVL(V_INSURE_DED_AMT, 0) < 0 THEN
        V_INSURE_DED_AMT := 0;
      END IF;
      V_INSURE_DED_AMT := V_INSURE_DED_AMT + V_MEDIC_INSUR_AMT + P_MEDIC_INSUR_AMT;
      V_INSURE_DED_AMT := V_INSURE_DED_AMT + V_HIRE_INSUR_AMT + P_HIRE_INSUR_AMT;
    
-------------------------------------------------------------------------------------------------------------------------------        
      -- 6. �Ƿ�� ���� ��� 
      V_MEDIC_DED_AMT := MEDIC_CAL
                           ( '101'
                           , P_YEAR_YYYY
                           , C1.PERSON_ID
                           , P_SOB_ID
                           , P_ORG_ID
                           , V_TOTAL_PAY
                           );
      IF V_MEDIC_DED_AMT < 0 THEN
        V_MEDIC_DED_AMT := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------        
      -- 7. ������  ���� ��� 
      V_EDU_DED_AMT := EDUCATION_CAL
                         ( '101'
                         , P_YEAR_YYYY
                         , C1.PERSON_ID
                         , P_SOB_ID
                         , P_ORG_ID
                         );
      IF V_EDU_DED_AMT < 0 THEN
        V_EDU_DED_AMT := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------        
      -- 8. �����ڱ�  ���� ��� 
      V_HOUSE_DED_AMT := HOUSE_FUND_CAL
                           ( '101'
                           , P_YEAR_YYYY
                           , C1.PERSON_ID
                           , P_SOB_ID
                           , P_ORG_ID
                           , V_TOTAL_PAY
                           );
      IF V_HOUSE_DED_AMT < 0 THEN
        V_HOUSE_DED_AMT := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------        
      -- 9. ��α�  ���� ��� 
      V_DONAT_DED_AMT := DONATION_CAL
                           ( '101'
                           , P_YEAR_YYYY
                           , C1.PERSON_ID
                           , P_SOB_ID
                           , P_ORG_ID
                           , V_TOTAL_PAY - V_INCOME_DED_AMT
                           );
      IF V_DONAT_DED_AMT < 0 THEN
        V_DONAT_DED_AMT := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------        
      -- 10. ȥ������̻�  ���� ��� 
      V_MARRY_ETC_DED_AMT := MARRY_ETC_CAL
                               ( '101'
                               , P_YEAR_YYYY
                               , C1.PERSON_ID
                               , P_SOB_ID
                               , P_ORG_ID
                               , V_TOTAL_PAY
                               );
      IF V_MARRY_ETC_DED_AMT < 0 THEN
        V_MARRY_ETC_DED_AMT := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------        
      -- Ư������ �հ�, ��Ÿ�����, ǥ�ذ���, �����ҵ������ ���.    
      V_SP_DED_SUM := V_INSURE_DED_AMT + V_MEDIC_DED_AMT + V_EDU_DED_AMT + V_HOUSE_DED_AMT + V_DONAT_DED_AMT + V_MARRY_ETC_DED_AMT;
      IF V_SP_DED_SUM < C1.SP_DED_STD THEN
        V_SP_STD_DED_AMT := C1.SP_DED_AMT;
      END IF;
    
      -- �����ҵ����(ǥ�ذ��� �ݾ��� ������ ǥ�ذ��� �ݾ׸� ������).           
      IF V_SP_DED_SUM < C1.SP_DED_STD THEN
        V_SUBT_DED_AMT := V_REAL_TAX - V_SP_STD_DED_AMT - V_ANNU_INSUR_AMT - P_ANNU_INSUR_AMT - V_RETR_ANNU_AMT;
      ELSE
        V_SUBT_DED_AMT := V_REAL_TAX - V_SP_DED_SUM - V_ANNU_INSUR_AMT - P_ANNU_INSUR_AMT - V_RETR_ANNU_AMT;
      END IF;
      IF V_SUBT_DED_AMT < 0 THEN
        V_SUBT_DED_AMT := 0;
      END IF;
      V_REAL_TAX := V_SUBT_DED_AMT;
    
-------------------------------------------------------------------------------------------------------------------------------        
      -- 11.1 ���ο�������  ���� ��� 
      V_PER_ANNU_BANK_AMT := PER_ANNU_BANK_CAL
                               ( '101'
                               , P_YEAR_YYYY
                               , C1.PERSON_ID
                               , P_SOB_ID
                               , P_ORG_ID
                               );
      IF V_PER_ANNU_BANK_AMT < 0 THEN
        V_PER_ANNU_BANK_AMT := 0;
      END IF;
      V_REAL_TAX := V_REAL_TAX - V_PER_ANNU_BANK_AMT;
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------        
      -- 11.2 ��������  ���� ��� 
      V_ANNU_BANK_AMT := ANNU_BANK_CAL
                           ( '101'
                           , P_YEAR_YYYY
                           , C1.PERSON_ID
                           , P_SOB_ID
                           , P_ORG_ID
                           );
      IF V_ANNU_BANK_AMT < 0 THEN
        V_ANNU_BANK_AMT := 0;
      END IF;
      V_REAL_TAX := V_REAL_TAX - V_ANNU_BANK_AMT;
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 12. ������������ 
      V_INVEST_AMT := INVEST_CAL
                        ( '101'
                        , P_YEAR_YYYY
                        , C1.PERSON_ID
                        , P_SOB_ID
                        , P_ORG_ID
                        , V_TOTAL_PAY - V_INCOME_DED_AMT
                        );
      IF V_INVEST_AMT < 0 THEN
        V_INVEST_AMT := 0;
      END IF;
      V_REAL_TAX := V_REAL_TAX - V_INVEST_AMT;
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 13. �ſ�ī��� ����   
      V_CARD_AMT := CARD_CAL
                      ( '101'
                      , P_YEAR_YYYY
                      , C1.PERSON_ID
                      , P_SOB_ID
                      , P_ORG_ID
                      , V_TOTAL_PAY
                      );
      IF V_CARD_AMT < 0 THEN
        V_CARD_AMT := 0;
      END IF;
      V_REAL_TAX := V_REAL_TAX - V_CARD_AMT;
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 14.-1 ���ø����������;
      V_HOUSE_SAVE_AMT := HOUSE_SAVE_CAL
                            ( '101'
                            , P_YEAR_YYYY
                            , C1.PERSON_ID
                            , P_SOB_ID
                            , P_ORG_ID
                            );
      IF V_HOUSE_SAVE_AMT < 0 THEN
        V_HOUSE_SAVE_AMT := 0;
      END IF;
      V_REAL_TAX := V_REAL_TAX - V_HOUSE_SAVE_AMT;
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
    
/*      -------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 2011.01.17 BY YOUNG MIN
      -- 14.-1 ����û���������� ���Ծ� �ҵ����;
      V_HOUSE_APP_DEPOSIT_AMT := HOUSE_APP_DEPOSIT_CAL
                                   ( '101'
                                   , P_YEAR_YYYY
                                   , C1.PERSON_ID
                                   , P_SOB_ID
                                   , P_ORG_ID
                                   , V_HOUSE_DED_AMT     -- �����������Ա� �ҵ�����ݾ�;
                                   );
      IF V_HOUSE_APP_DEPOSIT_AMT < 0 THEN
        V_HOUSE_APP_DEPOSIT_AMT := 0;
      END IF;
      V_REAL_TAX := V_REAL_TAX - V_HOUSE_APP_DEPOSIT_AMT;
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;*/
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 14. �츮���������⿬ ����   
      V_EMPL_STOCK_AMT := EMPL_STOCK_CAL
                         ( '101'
                         , P_YEAR_YYYY
                         , C1.PERSON_ID
                         , P_SOB_ID
                         , P_ORG_ID
                         );
      IF V_EMPL_STOCK_AMT < 0 THEN
        V_EMPL_STOCK_AMT := 0;
      END IF;
      V_REAL_TAX := V_REAL_TAX - V_EMPL_STOCK_AMT;
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 14.-1 �ұ��/�һ��ΰ����αݾ�;
      V_SMALL_CORPOR_DED_AMT := SMALL_CORPOR_DED_CAL
                                  ( '101'
                                  , P_YEAR_YYYY
                                  , C1.PERSON_ID
                                  , P_SOB_ID
                                  , P_ORG_ID
                                  );
      IF V_SMALL_CORPOR_DED_AMT < 0 THEN
        V_SMALL_CORPOR_DED_AMT := 0;
      END IF;
      V_REAL_TAX := V_REAL_TAX - V_SMALL_CORPOR_DED_AMT;
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 14-2. ����ֽ�������ҵ����;   
      V_LONG_STOCK_SAVING_AMT := LONG_STOCK_SAVING_CAL
                                   ( '101'
                                   , P_YEAR_YYYY
                                   , C1.PERSON_ID
                                   , P_SOB_ID
                                   , P_ORG_ID
                                   );
      IF V_LONG_STOCK_SAVING_AMT < 0 THEN
        V_LONG_STOCK_SAVING_AMT := 0;
      END IF;
      V_REAL_TAX := V_REAL_TAX - V_LONG_STOCK_SAVING_AMT;
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- ����ǥ�� ���             
      V_TAX_STD_AMT := V_REAL_TAX; 
/*      V_TAX_STD_AMT := 13730926;*/
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 15. ���⼼�� ���   
      V_COMP_TAX_AMT := COMP_TAX_CAL
                        ( P_NATION_CODE       => '101'
                        , P_YEAR_YYYY         => P_YEAR_YYYY
                        , P_PERSON_ID         => C1.PERSON_ID
                        , P_SOB_ID            => P_SOB_ID
                        , P_ORG_ID            => P_ORG_ID
                        , P_TAX_STD_AMT       => V_TAX_STD_AMT
                        );
      IF V_COMP_TAX_AMT < 0 THEN
        V_COMP_TAX_AMT := 0;
      END IF;
      V_REAL_TAX := V_COMP_TAX_AMT;
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      ----- ǥ�ذ����� �� �����ҵ������, ����ǥ��, ���⼼��  UPDATE  
      UPDATE HRA_YEAR_ADJUSTMENT HA
        SET HA.STAND_DED_AMT      = V_SP_STD_DED_AMT
          , HA.SUBT_DED_AMT       = V_SUBT_DED_AMT
          , HA.TAX_STD_AMT        = V_TAX_STD_AMT
          , HA.COMP_TAX_AMT       = V_COMP_TAX_AMT
      WHERE HA.YEAR_YYYY         = P_YEAR_YYYY
        AND HA.PERSON_ID         = C1.PERSON_ID
        AND HA.SOB_ID            = P_SOB_ID
        AND HA.ORG_ID            = P_ORG_ID
      ;
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 16.1 �ٷμҵ���� ���        
      V_TEMP_AMT := 0;
      V_TEMP_AMT := TAX_DED_INCOME_CAL
                    ( '101'
                    , P_YEAR_YYYY
                    , C1.PERSON_ID
                    , P_SOB_ID
                    , P_ORG_ID
                    , V_COMP_TAX_AMT
                    );
      IF V_TEMP_AMT < 0 THEN
        V_TEMP_AMT := 0;
      END IF;
      V_REAL_TAX := V_REAL_TAX - V_TEMP_AMT;
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 16.2 �������� ���װ��� ���(���� �ҵ��� �ִ��ڿ� ����) - �ش����        
      /*V_TEMP_AMT := 0;
      V_TEMP_AMT := IFC_YEAR_ADJUST_SET_PKG_2010.TAX_DED_TAXGROUP_CAL('101',  I_YEAR_YYYY, C1.PERSON_NUMB, V_COMP_TAX_AMT);
      IF V_TEMP_AMT < 0 THEN
        V_TEMP_AMT := 0;
      END IF;
      V_REAL_TAX := V_REAL_TAX - V_TEMP_AMT;
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;          */
    
      --DBMS_OUTPUT.PUT_LINE('V_REAL_TAX =>' || V_REAL_TAX);
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 16.3 �������Ա����ڻ�ȯ�� ���װ��� ���.
      V_TEMP_AMT := 0;
      V_TEMP_AMT := HOUSE_DEBT_BEN_CAL
                    ( '101'
                    , P_YEAR_YYYY
                    , C1.PERSON_ID
                    , P_SOB_ID
                    , P_ORG_ID
                    , V_REAL_TAX
                    );
      IF V_TEMP_AMT < 0 THEN
        V_TEMP_AMT := 0;
      END IF;
      
      -- �����Ư���� ���--
      IF V_TEMP_AMT > 0 THEN
        BEGIN
          SELECT TR.TAX_RATE
            INTO V_TEMP_RATE
            FROM HRM_TAX_RATE_V TR
          WHERE TR.TAX_TYPE       = 'SPECIAL'
            AND TR.SOB_ID         = P_SOB_ID
            AND TR.ORG_ID         = P_ORG_ID
            AND ROWNUM            <= 1
          ;
        EXCEPTION WHEN OTHERS THEN
          V_TEMP_RATE := 20;
        END;
        F_SP_TAX_AMT := NVL(F_SP_TAX_AMT, 0) + TRUNC(V_TEMP_AMT * (V_TEMP_RATE / 100));
      END IF;
      
      V_REAL_TAX := V_REAL_TAX - V_TEMP_AMT;
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 16.4 �ܱ����� ���� ����          
      V_REAL_TAX := V_REAL_TAX - V_TAX_OUTSIDE_AMT; -- ���ܼҵ� ��ȸ�κп��� ���� ��ȸ��  
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
          AND HA.SOB_ID           = P_SOB_ID
          AND HA.ORG_ID           = P_ORG_ID
        ;
      EXCEPTION
        WHEN OTHERS THEN
          V_TEMP_AMT := 0;
      END;
      V_REAL_TAX := V_REAL_TAX - NVL(V_TEMP_AMT, 0);
      IF V_REAL_TAX < 0 THEN
        V_REAL_TAX := 0;
      END IF;
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 17. ��������  
      F_IN_TAX_AMT    := V_REAL_TAX;
      F_LOCAL_TAX_AMT := DECIMAL_F(P_SOB_ID, P_ORG_ID, F_IN_TAX_AMT * (C1.LOCAL_TAX_RATE / 100), 'YEAR_LOCAL_TAX');
      BEGIN
        SELECT HA.FIX_SP_TAX_AMT
          INTO F_SP_TAX_AMT
          FROM HRA_YEAR_ADJUSTMENT HA
        WHERE HA.YEAR_YYYY        = P_YEAR_YYYY
          AND HA.PERSON_ID        = C1.PERSON_ID
          AND HA.SOB_ID           = P_SOB_ID
          AND HA.ORG_ID           = P_ORG_ID
        ;
      EXCEPTION
        WHEN OTHERS THEN
          F_SP_TAX_AMT := 0;
      END;
    
-------------------------------------------------------------------------------------------------------------------------------                                                                                            
      -- 18. �������� 
      S_IN_TAX_AMT    := DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(F_IN_TAX_AMT, 0), 'YEAR_IN_TAX') -
                         DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(V_IN_TAX_AMT, 0), 'YEAR_IN_TAX') -
                         DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(P_IN_TAX_AMT, 0), 'YEAR_IN_TAX');
      S_SP_TAX_AMT    := DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(F_SP_TAX_AMT, 0), 'SP_TAX');
      S_LOCAL_TAX_AMT := DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(F_LOCAL_TAX_AMT, 0), 'YEAR_LOCAL_TAX') -
                         DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(V_LOCAL_TAX_AMT, 0), 'YEAR_LOCAL_TAX') -
                         DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(P_LOCAL_TAX_AMT, 0), 'YEAR_LOCAL_TAX');
    
      --DBMS_OUTPUT.PUT_LINE('�������� =>' || TO_CHAR(V_REAL_TAX, 'FM999,999,999,999'));
    
      ----- ���ٹ���(�޿�/��/������/���ڱ�/�ⳳ�μ��׵�), ���ٹ����ڷ� UPDATE -----------------------------------------------------------------------                       
      UPDATE HRA_YEAR_ADJUSTMENT HA
        SET HA.FIX_IN_TAX_AMT     = F_IN_TAX_AMT
          , HA.FIX_LOCAL_TAX_AMT  = F_LOCAL_TAX_AMT
          , HA.SUBT_IN_TAX_AMT    = S_IN_TAX_AMT
          , HA.SUBT_SP_TAX_AMT    = S_SP_TAX_AMT
          , HA.SUBT_LOCAL_TAX_AMT = S_LOCAL_TAX_AMT
          , HA.LAST_UPDATE_DATE   = V_SYSDATE
          , HA.LAST_UPDATED_BY    = P_USER_ID
       WHERE HA.YEAR_YYYY         = P_YEAR_YYYY
         AND HA.PERSON_ID         = C1.PERSON_ID
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
      ;
    END LOOP C1;
    COMMIT;
    O_ERR_MSG := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);  
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      V_ERR_MSG := SQLERRM;
      O_ERR_MSG := V_ERR_MSG; --'�������� ó���� ������ �߻��߽��ϴ�. �α׸� Ȯ���ϼ���';
  END MAIN_CAL;

  -- 0. �������� ó�� ��� ����;
  PROCEDURE BASIC_CREATION
            ( P_CORP_ID           IN NUMBER
            , P_YEAR_YYYY         IN VARCHAR2
            , P_STD_DATE          IN DATE
            , P_PERSON_ID         IN NUMBER
            , P_USER_ID           IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , O_ERR_MSG           OUT VARCHAR2
            )
  AS
    V_ERR_MSG                 VARCHAR2(500);
    V_SYSDATE                 DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_START_DATE              DATE;
    V_RECORD_COUNT            NUMBER;
  BEGIN
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
         AND EXISTS ( SELECT 'X'  
                        FROM HRM_PERSON_MASTER PM
                      WHERE PM.CORP_ID        = HA.CORP_ID
                        AND PM.PERSON_ID      = HA.PERSON_ID
                        AND PM.SOB_ID         = HA.SOB_ID
                        AND PM.ORG_ID         = HA.ORG_ID
                        AND PM.PERSON_ID      = NVL(P_PERSON_ID, PM.PERSON_ID)
                        AND PM.JOIN_DATE      <= P_STD_DATE
                        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= V_START_DATE)
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
         AND EXISTS ( SELECT 'X'  
                        FROM HRM_PERSON_MASTER PM
                      WHERE PM.CORP_ID        = HA.CORP_ID
                        AND PM.PERSON_ID      = HA.PERSON_ID
                        AND PM.SOB_ID         = HA.SOB_ID
                        AND PM.ORG_ID         = HA.ORG_ID
                        AND PM.PERSON_ID      = NVL(P_PERSON_ID, PM.PERSON_ID)
                        AND PM.JOIN_DATE      <= P_STD_DATE
                        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= V_START_DATE)
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
            END ADJUST_DATE_FR
          , CASE
              WHEN PM.RETIRE_DATE IS NULL THEN TO_DATE(P_YEAR_YYYY || '-12-31', 'YYYY-MM-DD')
              WHEN PM.RETIRE_DATE < TO_DATE(P_YEAR_YYYY || '-12-31', 'YYYY-MM-DD') THEN PM.RETIRE_DATE
              ELSE TO_DATE(P_YEAR_YYYY || '-12-31', 'YYYY-MM-DD')
            END ADJUST_DATE_TO
          , NVL(MH.PAY_TYPE, '1') PAY_TYPE
          , V_SYSDATE CREATION_DATE
          , P_USER_ID CREATED_BY
          , V_SYSDATE LAST_UPDATE_DATE
          , P_USER_ID LAST_UPDATED_BY
       FROM HRM_PERSON_MASTER PM
         , ( SELECT PMH.CORP_ID
                  , PMH.PERSON_ID
                  , PMH.SOB_ID
                  , PMH.ORG_ID
                  , PMH.PAY_TYPE
               FROM HRP_PAY_MASTER_HEADER PMH
             WHERE PMH.CORP_ID              = P_CORP_ID
               AND PMH.SOB_ID               = P_SOB_ID
               AND PMH.ORG_ID               = P_ORG_ID
               AND PMH.PERSON_ID            = NVL(P_PERSON_ID, PMH.PERSON_ID)
               AND PMH.START_YYYYMM         <= TO_CHAR(P_STD_DATE, 'YYYY-MM')
               AND PMH.END_YYYYMM           >= TO_CHAR(P_STD_DATE, 'YYYY-MM')
            ) MH
      WHERE PM.PERSON_ID          = MH.PERSON_ID
        AND PM.CORP_ID            = MH.CORP_ID
        AND PM.SOB_ID             = MH.SOB_ID
        AND PM.ORG_ID             = MH.ORG_ID        
        AND PM.CORP_ID            = P_CORP_ID
        AND PM.PERSON_ID          = NVL(P_PERSON_ID, PM.PERSON_ID)
        AND PM.SOB_ID             = P_SOB_ID
        AND PM.ORG_ID             = P_ORG_ID
        AND PM.JOIN_DATE          <= P_STD_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= V_START_DATE)
    );
    COMMIT;
    O_ERR_MSG := TO_CHAR(NULL);
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      V_ERR_MSG := 'Basic Creation Error : ' || SUBSTR(SQLERRM, 1, 200);
      O_ERR_MSG := V_ERR_MSG;
  END BASIC_CREATION;

  -- 3.5 �ٷμҵ���� ���;
  FUNCTION INCOME_DED_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER
  AS
    V_AMOUNT                  NUMBER := 0;
  BEGIN
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
                WHERE HIT.NATION_CODE       = P_NATION_CODE
                  AND HIT.YEAR_YYYY         = P_YEAR_YYYY
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
    RETURN NVL(V_AMOUNT, 0);
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END INCOME_DED_CAL;

  -- 4. ��������;
  FUNCTION SUPP_FAMILY_CAL
            ( P_NATION_CODE       IN VARCHAR2
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
    BEGIN
      SELECT HIT.MANY_CHILD_DED_AGE
        INTO V_MANY_CHILD_DED_AGE
        FROM HRA_INCOME_TAX_STANDARD HIT
       WHERE HIT.NATION_CODE    = P_NATION_CODE
         AND HIT.YEAR_YYYY      = P_YEAR_YYYY
         AND HIT.SOB_ID         = P_SOB_ID
         AND HIT.ORG_ID         = P_ORG_ID;
    EXCEPTION
      WHEN OTHERS THEN
        V_MANY_CHILD_DED_AGE := 20;
    END;
    -- �������� ó������ �� �ξ簡�� ���� �׸�--
    FOR C1 IN (SELECT HIT.YEAR_YYYY
                    , NVL(HIT.PERSON_DED_AMT, 0) AS PERSON_DED_AMT
                    , NVL(HIT.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT
                    , NVL(HIT.SUPPORT_DED_AMT, 0) AS SUPPORT_DED_AMT
                    , NVL(HIT.OLD_AGED_DED_AMT, 0) AS OLD_DED_AMT
                    , NVL(HIT.OLD_AGED_DED1_AMT, 0) AS OLD_DED1_AMT
                    , NVL(HIT.DEFORM_DED_AMT, 0) AS DEFORM_DED_AMT
                    , NVL(HIT.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT
                    , NVL(HIT.BRING_CHILD_DED_AMT, 0) AS BRING_CHILD_DED_AMT
                    , NVL(HIT.BIRTH_DED_AMT, 0) AS BIRTH_DED_AMT
                    , NVL(HIT.MANY_CHILD_DED_CNT, 0) AS MANY_CHILD_DED_CNT
                    , NVL(HIT.MANY_CHILD_DED_BAS_AMT, 0) AS MANY_CHILD_DED_BAS_AMT
                    , NVL(HIT.MANY_CHILD_DED_ADD_AMT, 0) AS MANY_CHILD_DED_ADD_AMT
                    --> �ο��� --
                    , NVL(HSF1.PERSON_ID, 0) AS PERSON_ID
                    , NVL(HSF1.PERSON_COUNT, 0) AS PERSON_COUNT
                    , NVL(HSF1.SPOUSE_COUNT, 0) AS SPOUSE_COUNT
                    , NVL(HSF1.SUPPORT_COUNT, 0) AS SUPPORT_COUNT
                    , NVL(HSF1.OLD_COUNT, 0) AS OLD_COUNT
                    , NVL(HSF1.OLD_COUNT1, 0) AS OLD_COUNT1
                    , NVL(HSF1.DEFORM_COUNT, 0) AS DEFORM_COUNT
                    , NVL(HSF1.WOMAN_COUNT, 0) AS WOMAN_COUNT
                    , NVL(HSF1.CHILD_COUNT, 0) AS CHILD_COUNT
                    , NVL(HSF1.BIRTH_COUNT, 0) AS BIRTH_COUNT
                    , NVL(HSF1.MANY_CHILD_DED_COUNT, 0) AS MANY_CHILD_DED_COUNT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --> �ξ簡�� �ڷ�  
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
                                  END) AS SUPPORT_COUNT
                           , SUM(DECODE(HSF.OLD_YN, 'Y', 1, 0)) AS OLD_COUNT
                           , SUM(DECODE(HSF.OLD1_YN, 'Y', 1, 0)) AS OLD_COUNT1
                           , SUM(DECODE(HSF.DEFORM_YN, 'Y', 1, 0)) AS DEFORM_COUNT
                           , SUM(DECODE(HSF.WOMAN_YN, 'Y', 1, 0)) AS WOMAN_COUNT
                           , SUM(DECODE(HSF.CHILD_YN, 'Y', 1, 0)) AS CHILD_COUNT
                           , SUM(DECODE(HSF.BIRTH_YN, 'Y', 1, 0)) AS BIRTH_COUNT -- ���/�Ծ���;
                           , SUM(CASE
                                    WHEN HSF.BASE_YN = 'Y' AND HSF.RELATION_CODE = '4' AND
                                         EAPP_REGISTER_AGE_F(HSF.REPRE_NUM, P_STD_DATE, 0) <= V_MANY_CHILD_DED_AGE THEN 1
                                    ELSE 0
                                  END) MANY_CHILD_DED_COUNT
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
                       ) HSF1
                WHERE HIT.YEAR_YYYY     = HSF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HSF1.SOB_ID
                  AND HIT.ORG_ID        = HSF1.ORG_ID
                  AND HIT.NATION_CODE   = P_NATION_CODE
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
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.DEFORM_DED_AMT * C1.DEFORM_COUNT); -- �߰�-�����;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.WOMAN_DED_AMT * C1.WOMAN_COUNT); -- �߰�-�γ༼�� ;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.BRING_CHILD_DED_AMT * C1.CHILD_COUNT); -- �߰�-�ڳ������;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + (C1.BIRTH_DED_AMT * C1.BIRTH_COUNT); -- �߰�-���/�Ծ���;
      V_SUPP_FAMILY_AMT := V_SUPP_FAMILY_AMT + V_MANY_CHILD_DED; -- �߰�-���ڳడ��;

      --> �������� UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.PER_DED_AMT          = NVL(C1.PERSON_DED_AMT, 0) * C1.PERSON_COUNT
           , HA.SPOUSE_DED_AMT       = NVL(C1.SPOUSE_DED_AMT, 0) * C1.SPOUSE_COUNT
           , HA.SUPP_DED_COUNT       = NVL(C1.SUPPORT_COUNT, 0)
           , HA.SUPP_DED_AMT         = NVL(C1.SUPPORT_DED_AMT, 0) * C1.SUPPORT_COUNT
           , HA.OLD_DED_COUNT        = NVL(C1.OLD_COUNT, 0)
           , HA.OLD_DED_AMT          = NVL(C1.OLD_DED_AMT, 0) * C1.OLD_COUNT
           , HA.OLD_DED_COUNT1       = NVL(C1.OLD_COUNT1, 0)
           , HA.OLD_DED_AMT1         = NVL(C1.OLD_DED1_AMT, 0) * C1.OLD_COUNT1
           , HA.DEFORM_DED_COUNT     = NVL(C1.DEFORM_COUNT, 0)
           , HA.DEFORM_DED_AMT       = NVL(C1.DEFORM_DED_AMT, 0) * C1.DEFORM_COUNT
           , HA.WOMAN_DED_AMT        = NVL(C1.WOMAN_DED_AMT, 0) * C1.WOMAN_COUNT
           , HA.CHILD_DED_COUNT      = NVL(C1.CHILD_COUNT, 0)
           , HA.CHILD_DED_AMT        = NVL(C1.BRING_CHILD_DED_AMT, 0) * C1.CHILD_COUNT
           , HA.BIRTH_DED_COUNT      = NVL(C1.BIRTH_COUNT, 0)
           , HA.BIRTH_DED_AMT        = NVL(C1.BIRTH_DED_AMT, 0) * C1.BIRTH_COUNT
           , HA.MANY_CHILD_DED_COUNT = NVL(V_MANY_CHILD_COUNT, 0)
           , HA.MANY_CHILD_DED_AMT   = NVL(V_MANY_CHILD_DED, 0)
       WHERE HA.YEAR_YYYY            = P_YEAR_YYYY
         AND HA.PERSON_ID            = P_PERSON_ID
         AND HA.SOB_ID               = P_SOB_ID
         AND HA.ORG_ID               = P_ORG_ID
       ;
    END LOOP C1;
    RETURN NVL(V_SUPP_FAMILY_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END SUPP_FAMILY_CAL;

  -- 5. ����� ����;
  FUNCTION ETC_INSUR_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_TOTAL_INSUR_AMT  NUMBER := 0; -- ��Ÿ���� �� �հ� 
    V_ETC_INSUR_AMT    NUMBER := 0; -- ���强����� ���� 
    V_DEFORM_INSUR_AMT NUMBER := 0; -- ��ֺ���� ���� 
  BEGIN
    -- �������� ó������ �� ����� ���� �׸�--
    FOR C1 IN (SELECT HIT.YEAR_YYYY
                    , NVL(HIT.ETC_INSUR_LMT, 0) AS ETC_INSUR_LMT
                    , NVL(HIT.DEFORM_INSUR_LMT, 0) AS DEFORM_INSUR_LMT
                    --> �����--
                    , NVL(HSF1.ETC_ANNU_INSURE_AMT, 0) ETC_ANNU_INSURE_AMT
                    , NVL(HSF1.ETC_HIRE_MEDIC_INSURE_AMT, 0) ETC_HIRE_MEDIC_INSURE_AMT
                    , NVL(HSF2.INSURE_SUM, 0) GUAR_INSURE_AMT
                    , NVL(HSF2.DEFORM_INSURE_SUM, 0) DEFORM_INSURE_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --> ��������ڷ� ��ȸ  
                      SELECT HF.YEAR_YYYY
                           , HF.PERSON_ID
                           , HF.SOB_ID
                           , HF.ORG_ID
                           , HF.ANNU_INSUR_AMT AS ETC_ANNU_INSURE_AMT
                           , HF.HIRE_MEDIC_INSUR_AMT AS ETC_HIRE_MEDIC_INSURE_AMT
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
                           , SUM(NVL(HSF.DEFORM_INSURE_AMT, 0) + NVL(HSF.ETC_DEFORM_INSURE_AMT, 0)) AS DEFORM_INSURE_SUM
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
                AND HIT.NATION_CODE     = P_NATION_CODE
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
      IF C1.DEFORM_INSUR_LMT < C1.DEFORM_INSURE_AMT THEN
        V_DEFORM_INSUR_AMT := C1.DEFORM_INSUR_LMT;
      ELSE
        V_DEFORM_INSUR_AMT := C1.DEFORM_INSURE_AMT;
      END IF;
      V_TOTAL_INSUR_AMT := V_ETC_INSUR_AMT + V_DEFORM_INSUR_AMT +
                           C1.ETC_ANNU_INSURE_AMT +
                           C1.ETC_HIRE_MEDIC_INSURE_AMT;
      --> ����� UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.ANNU_INSUR_AMT   = NVL(HA.ANNU_INSUR_AMT, 0) + C1.ETC_ANNU_INSURE_AMT
           , HA.HIRE_INSUR_AMT   = NVL(HA.HIRE_INSUR_AMT, 0) + C1.ETC_HIRE_MEDIC_INSURE_AMT
           , HA.GUAR_INSUR_AMT   = V_ETC_INSUR_AMT
           , HA.DEFORM_INSUR_AMT = V_DEFORM_INSUR_AMT
       WHERE HA.YEAR_YYYY        = P_YEAR_YYYY
         AND HA.PERSON_ID        = P_PERSON_ID
         AND HA.SOB_ID           = P_SOB_ID
         AND HA.ORG_ID           = P_ORG_ID
      ;
    END LOOP C1;
    RETURN NVL(V_TOTAL_INSUR_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END ETC_INSUR_CAL;

  -- 6. �Ƿ�� ����;
  FUNCTION MEDIC_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER
  AS
    V_MED_TOTAL_AMT NUMBER := 0; -- �Ƿ�� �� ���� 
    V_MED_PER_AMT   NUMBER := 0; -- �Ƿ�� ����/�����/��� ������  
    V_MED_SUPP_AMT  NUMBER := 0; -- �Ƿ�� �ξ簡�� 
    --    V_MED_DED_LMT                              NUMBER := 0;   -- �Ƿ�� ���� �ѵ� 
  BEGIN
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.MEDIC_DED_STD, 0) MEDIC_DED_STD
                    , NVL(HIT.MEDIC_DED_LMT, 0) MEDIC_DED_LMT
                    --> �Ƿ��                           
                    , NVL(HSF1.PER_MEDI_SUM, 0) PER_MEDI_SUM
                    , NVL(HSF1.OLD_MEDI_SUM, 0) OLD_MEDI_SUM
                    , NVL(HSF1.DEFORM_MEDI_SUM, 0) DEFORM_MEDI_SUM
                    , NVL(HSF1.SUPP_MEDI_SUM, 0) SUPP_MEDI_SUM
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , (SELECT HSF.YEAR_YYYY
                          , HSF.SOB_ID
                          , HSF.ORG_ID
                          , HSF.PERSON_ID
                          , SUM(DECODE(HSF.RELATION_CODE, '0', NVL(HSF.MEDICAL_AMT, 0) + NVL(HSF.ETC_MEDICAL_AMT, 0), 0)) PER_MEDI_SUM
                          , SUM(CASE
                                  WHEN HSF.RELATION_CODE = '0' THEN 0
                                  WHEN 'Y' IN (HSF.OLD_YN, HSF.OLD1_YN) AND HSF.DEFORM_YN <> 'Y' 
                                    THEN NVL(HSF.MEDICAL_AMT, 0) + NVL(HSF.ETC_MEDICAL_AMT, 0)
                                  ELSE 0
                                END) OLD_MEDI_SUM
                          , SUM(CASE
                                  WHEN HSF.RELATION_CODE = '0' THEN 0
                                  WHEN HSF.DEFORM_YN = 'Y' THEN NVL(HSF.MEDICAL_AMT, 0) + NVL(HSF.ETC_MEDICAL_AMT, 0)
                                  ELSE 0
                                END) DEFORM_MEDI_SUM
                          , SUM(CASE
                                  WHEN HSF.RELATION_CODE = '0' THEN 0
                                  WHEN 'Y' IN (HSF.OLD_YN, HSF.OLD1_YN) THEN 0
                                  WHEN HSF.DEFORM_YN = 'Y' THEN 0
                                  ELSE NVL(HSF.MEDICAL_AMT, 0) + NVL(HSF.ETC_MEDICAL_AMT, 0)
                                END) SUPP_MEDI_SUM
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
                  AND HIT.NATION_CODE   = P_NATION_CODE
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
                ) 
    LOOP
      -- ���ΰ��� 
      V_MED_PER_AMT := C1.PER_MEDI_SUM + C1.OLD_MEDI_SUM + C1.DEFORM_MEDI_SUM;
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
    END LOOP C1;
    --> �Ƿ�� UPDATE 
    UPDATE HRA_YEAR_ADJUSTMENT HA
       SET HA.MEDIC_AMT = NVL(V_MED_TOTAL_AMT, 0)
     WHERE HA.YEAR_YYYY       = P_YEAR_YYYY
       AND HA.PERSON_ID       = P_PERSON_ID
       AND HA.SOB_ID          = P_SOB_ID
       AND HA.ORG_ID          = P_ORG_ID
    ;
    RETURN NVL(V_MED_TOTAL_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END MEDIC_CAL;

  -- 7. ������ ����;
  FUNCTION EDUCATION_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_EDU_TOTAL_AMT NUMBER := 0; -- �� ������ 
    V_PER_EDU_AMT    NUMBER := 0; -- ���� ������  
    V_DEFORM_EDU_AMT NUMBER := 0; -- ����� ������  
    V_CHILD_EDU_AMT  NUMBER := 0; -- ������ �Ƶ� ������  
    V_HIGH_EDU_AMT   NUMBER := 0; -- ���߰� ������  
    V_COLL_EDU_AMT   NUMBER := 0; -- ���б� ������  
  BEGIN
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.PER_EDU, 0) PER_EDU
                    , NVL(HIT.KIND_EDU, 0) KIND_EDU
                    , NVL(HIT.STUD_EDU, 0) STUD_EDU
                    , NVL(HIT.UNIV_EDU, 0) UNIV_EDU
                    --> ������         
                    , NVL(HSF1.PERSON_ID, 0) PERSON_ID
                    , NVL(HSF1.PER_EDU_COUNT, 0) PER_EDU_COUNT
                    , NVL(HSF1.PER_EDU_AMT, 0) PER_EDU_AMT
                    , NVL(HSF1.DEFORM_EDU_COUNT, 0) DEFORM_EDU_COUNT
                    , NVL(HSF1.DEFORM_EDU_AMT, 0) DEFORM_EDU_AMT
                    , NVL(HSF1.CHILD_EDU_COUNT, 0) CHILD_EDU_COUNT
                    , NVL(HSF1.CHILD_EDU_AMT, 0) CHILD_EDU_AMT
                    , NVL(HSF1.HIGH_EDU_COUNT, 0) HIGH_EDU_COUNT
                    , NVL(HSF1.HIGH_EDU_AMT, 0) HIGH_EDU_AMT
                    , NVL(HSF1.COLL_EDU_COUNT, 0) COLL_EDU_COUNT
                    , NVL(HSF1.COLL_EDU_AMT, 0) COLL_EDU_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , (SELECT HSF.YEAR_YYYY
                          , HSF.PERSON_ID
                          , HSF.SOB_ID
                          , HSF.ORG_ID
                          , HSF.REPRE_NUM
                          , SUM(DECODE(HSF.EDUCATION_TYPE, '10', 1, 0)) PER_EDU_COUNT
                          , SUM(DECODE(HSF.EDUCATION_TYPE, '10', NVL(HSF.EDUCATION_AMT, 0) + NVL(HSF.ETC_EDUCATION_AMT, 0), 0)) PER_EDU_AMT
                          , SUM(DECODE(HSF.EDUCATION_TYPE, '20', 1, 0)) DEFORM_EDU_COUNT
                          , SUM(DECODE(HSF.EDUCATION_TYPE, '20', NVL(HSF.EDUCATION_AMT, 0) + NVL(HSF.ETC_EDUCATION_AMT, 0), 0)) DEFORM_EDU_AMT
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
                  AND HIT.NATION_CODE = P_NATION_CODE
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
      IF C1.PER_EDU < C1.DEFORM_EDU_AMT THEN
        V_DEFORM_EDU_AMT := C1.PER_EDU;
      ELSE
        V_DEFORM_EDU_AMT := C1.DEFORM_EDU_AMT;
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
      -- ������ �հ� 
      V_EDU_TOTAL_AMT := V_EDU_TOTAL_AMT + V_PER_EDU_AMT + V_DEFORM_EDU_AMT +
                         V_CHILD_EDU_AMT + V_HIGH_EDU_AMT + V_COLL_EDU_AMT;      
    END LOOP C1;
    --> ������  UPDATE 
    UPDATE HRA_YEAR_ADJUSTMENT HA
       SET HA.EDUCATION_AMT = NVL(V_EDU_TOTAL_AMT, 0)
     WHERE HA.YEAR_YYYY     = P_YEAR_YYYY
       AND HA.PERSON_ID     = P_PERSON_ID
       AND HA.SOB_ID        = P_SOB_ID
       AND HA.ORG_ID        = P_ORG_ID
     ;  
    RETURN NVL(V_EDU_TOTAL_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END EDUCATION_CAL;

  -- 8-1. �����ڱ� ����(�����������Աݿ����ݻ�ȯ��/��������������Ա����ڻ�ȯ��);
  FUNCTION HOUSE_FUND_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER
  AS
    V_HOUSE_ADD_AMT               NUMBER := 0; -- �����������Աݿ����ݻ�ȯ40%
    V_LONG_HOUSE_INTER_AMT        NUMBER := 0; -- ��������������Ա�0;
    V_HOUSE_MONTHLY_AMT           NUMBER := 0; -- ���ҵ�ٷ��� �����ҵ����;
    V_HOUSE_TOTAL_AMT             NUMBER := 0; -- �����ڱ� �� �հ� 0;
  BEGIN
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.HOUSE_INTER_RATE, 0) HOUSE_INTER_RATE
                    , NVL(HIT.HOUSE_AMT_LMT, 0) HOUSE_AMT_LMT
                    , NVL(HIT.LONG_HOUSE_PROF_LMT, 0) LONG_HOUSE_PROF_LMT
                    , NVL(HIT.HOUSE_TOTAL_LMT, 0) HOUSE_TOTAL_LMT
                    , NVL(HIT.LONG_HOUSE_PROF_LMT_1, 0) LONG_HOUSE_PROF_LMT_1
                    , NVL(HIT.HOUSE_TOTAL_LMT_1, 0) HOUSE_TOTAL_LMT_1
                    , NVL(HIT.LONG_HOUSE_PROF_LMT_2, 0) LONG_HOUSE_PROF_LMT_2
                    , NVL(HIT.HOUSE_TOTAL_LMT_2, 0) HOUSE_TOTAL_LMT_2
                    , NVL(HIT.HOUSE_MONTHLY_STD, 0) HOUSE_MONTHLY_STD
                    , NVL(HIT.HOUSE_MONTHLY_RATE, 0) HOUSE_MONTHLY_RATE
                    --> �����ڱ�;
                    , NVL(HF1.HOUSE_ADD_AMT, 0) HOUSE_ADD_AMT
                    , NVL(HF1.LONG_HOUSE_INTER_AMT, 0) LONG_HOUSE_INTER_AMT
                    , NVL(HF1.LONG_HOUSE_INTER_AMT_1, 0) LONG_HOUSE_INTER_AMT_1
                    , NVL(HF1.LONG_HOUSE_INTER_AMT_2, 0) LONG_HOUSE_INTER_AMT_2
                    , NVL(HF1.HOUSE_MONTHLY_AMT, 0) HOUSE_MONTHLY_AMT                        
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
                        FROM HRA_FOUNDATION HF
                      WHERE HF.YEAR_YYYY        = P_YEAR_YYYY
                        AND HF.PERSON_ID        = P_PERSON_ID
                        AND HF.SOB_ID           = P_SOB_ID
                        AND HF.ORG_ID           = P_ORG_ID                        
                     ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.NATION_CODE   = P_NATION_CODE
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
               ) 
    LOOP
      -- �����������Աݿ����ݻ�ȯ��; 
      V_HOUSE_ADD_AMT := TRUNC(C1.HOUSE_ADD_AMT * (C1.HOUSE_INTER_RATE / 100));
      IF C1.HOUSE_AMT_LMT < V_HOUSE_ADD_AMT THEN
        V_HOUSE_ADD_AMT := C1.HOUSE_AMT_LMT;
      END IF;
      
      -- ���ҵ�ٷ��� �����ҵ����;
      -- ���ø������� �� �����������Ա� �ҵ�����ݾ� �հ�� ����;
      IF P_TOTAL_PAY < NVL(C1.HOUSE_MONTHLY_STD, 0) THEN
        V_HOUSE_MONTHLY_AMT := TRUNC(C1.HOUSE_MONTHLY_AMT * (C1.HOUSE_MONTHLY_RATE / 100));
        IF C1.HOUSE_AMT_LMT < V_HOUSE_ADD_AMT + V_HOUSE_MONTHLY_AMT THEN
          V_HOUSE_MONTHLY_AMT := (V_HOUSE_ADD_AMT + V_HOUSE_MONTHLY_AMT) - C1.HOUSE_AMT_LMT;
        END IF;
      END IF;
      -------------------------------------------------    
      -- ��������������Ա� ���ڻ�ȯ�װ��� ; 
      IF NVL(C1.LONG_HOUSE_INTER_AMT, 0) > 0 THEN
        --DBMS_OUTPUT.PUT_LINE('600');                
        -- 600���� �ѵ� ���;
        V_LONG_HOUSE_INTER_AMT := C1.LONG_HOUSE_INTER_AMT;
        IF C1.LONG_HOUSE_PROF_LMT < V_LONG_HOUSE_INTER_AMT THEN
          V_LONG_HOUSE_INTER_AMT := C1.LONG_HOUSE_PROF_LMT;
        END IF;
      
        -- �� �����ڱ� �ѵ� ����; 
        V_HOUSE_TOTAL_AMT := V_HOUSE_ADD_AMT + V_LONG_HOUSE_INTER_AMT;
        IF C1.HOUSE_TOTAL_LMT < V_HOUSE_TOTAL_AMT THEN
          V_LONG_HOUSE_INTER_AMT := V_LONG_HOUSE_INTER_AMT - (V_HOUSE_TOTAL_AMT - NVL(C1.HOUSE_TOTAL_LMT, 0));
        END IF;      
      ELSIF NVL(C1.LONG_HOUSE_INTER_AMT_1, 0) > 0 THEN
        --DBMS_OUTPUT.PUT_LINE('1000');                
        -- 1000���� �ѵ� ���;
        V_LONG_HOUSE_INTER_AMT := C1.LONG_HOUSE_INTER_AMT_1;
        IF C1.LONG_HOUSE_PROF_LMT_1 < V_LONG_HOUSE_INTER_AMT THEN
          V_LONG_HOUSE_INTER_AMT := C1.LONG_HOUSE_PROF_LMT_1;
        END IF;
      
        -- �� �����ڱ� �ѵ� ����; 
        V_HOUSE_TOTAL_AMT := V_HOUSE_ADD_AMT + V_LONG_HOUSE_INTER_AMT;
        IF C1.HOUSE_TOTAL_LMT_1 < V_HOUSE_TOTAL_AMT THEN
          V_LONG_HOUSE_INTER_AMT := V_LONG_HOUSE_INTER_AMT - (V_HOUSE_TOTAL_AMT - NVL(C1.HOUSE_TOTAL_LMT_1, 0));
        END IF;      
      ELSE
        --DBMS_OUTPUT.PUT_LINE('1500// �ݾ� : ' || C1.LONG_HOUSE_INTER_AMT_2);                
        -- 1500���� �ѵ� ���;
        V_LONG_HOUSE_INTER_AMT := C1.LONG_HOUSE_INTER_AMT_2;
        IF C1.LONG_HOUSE_PROF_LMT_2 < V_LONG_HOUSE_INTER_AMT THEN
          V_LONG_HOUSE_INTER_AMT := C1.LONG_HOUSE_PROF_LMT_2;
        END IF;
        --DBMS_OUTPUT.PUT_LINE('V_LONG_HOUSE_INTER_AMT : ' || V_LONG_HOUSE_INTER_AMT);     
      
        -- �� �����ڱ� �ѵ� ����; 
        V_HOUSE_TOTAL_AMT := V_HOUSE_ADD_AMT + V_LONG_HOUSE_INTER_AMT;
        IF C1.HOUSE_TOTAL_LMT_2 < V_HOUSE_TOTAL_AMT THEN
          V_LONG_HOUSE_INTER_AMT := V_LONG_HOUSE_INTER_AMT - (V_HOUSE_TOTAL_AMT - NVL(C1.HOUSE_TOTAL_LMT_2, 0));
        END IF;
        --DBMS_OUTPUT.PUT_LINE('V_HOUSE_TOTAL_AMT : ' || V_HOUSE_TOTAL_AMT);               
        /*V_LONG_HOUSE_INTER_AMT := C1.LONG_HOUSE_INTER_AMT_2;
        IF C1.LONG_HOUSE_PROF_LMT_2 < V_LONG_HOUSE_INTER_AMT THEN
          V_LONG_HOUSE_INTER_AMT := C1.LONG_HOUSE_PROF_LMT_2;
        END IF;
        
        -- �� �����ڱ� �ѵ� ����; 
        V_HOUSE_TOTAL_AMT := V_HOUSE_ADD_AMT + V_LONG_HOUSE_INTER_AMT;
        IF C1.HOUSE_TOTAL_LMT_2 < V_HOUSE_TOTAL_AMT THEN
          V_LONG_HOUSE_INTER_AMT := V_LONG_HOUSE_INTER_AMT -  ( V_HOUSE_TOTAL_AMT - NVL(C1.HOUSE_TOTAL_LMT_2, 0) );
        END IF;*/
      
      END IF;
      -------------------------------------------------
      --DBMS_OUTPUT.PUT_LINE('������ HOUSE_TOTAL_AMT : ' || V_HOUSE_TOTAL_AMT || ', V_HOUSE_ADD_AMT : ' || V_HOUSE_ADD_AMT || ', V_LONG_HOUSE_INTER_AMT' || V_LONG_HOUSE_INTER_AMT);                       
      -- �������ڱݾ�;
      V_HOUSE_TOTAL_AMT := V_HOUSE_ADD_AMT + V_LONG_HOUSE_INTER_AMT + V_HOUSE_MONTHLY_AMT;
      --DBMS_OUTPUT.PUT_LINE('UPDATE �� V_HOUSE_TOTAL_AMT : ' || V_HOUSE_TOTAL_AMT);      
                       
      --> �����ڱ�   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.HOUSE_FUND_AMT      = NVL(V_HOUSE_TOTAL_AMT, 0),
             HA.HOUSE_INTER_AMT     = NVL(V_HOUSE_ADD_AMT, 0),
             HA.LONG_HOUSE_PROF_AMT = NVL(V_LONG_HOUSE_INTER_AMT, 0),
             HA.HOUSE_MONTHLY_AMT   = NVL(V_HOUSE_MONTHLY_AMT, 0)
       WHERE HA.YEAR_YYYY           = P_YEAR_YYYY
         AND HA.PERSON_ID           = P_PERSON_ID
         AND HA.SOB_ID              = P_SOB_ID
         AND HA.ORG_ID              = P_ORG_ID
      ;
    END LOOP C1;
    RETURN NVL(V_HOUSE_TOTAL_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END HOUSE_FUND_CAL;

  -- 8-2. ���ø�������ҵ����;
  FUNCTION HOUSE_SAVE_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_HOUSE_SAVE_AMT              NUMBER := 0; -- ���ø���������Ծ� 40%;
  
    V_HOUSE_ADD_AMT               NUMBER := 0; -- �����������Աݿ����ݻ�ȯ40%
    V_LONG_HOUSE_INTER_AMT        NUMBER := 0; -- ��������������Ա�0;
    V_LONG_HOUSE_INTER_FLAG       VARCHAR(2) := '0'; -- ��������������Ա� �ѵ� ������ ���� FLAG;
  
    V_HOUSE_SUM_AMT               NUMBER := 0; -- �����������̱ݿ����ݻ�ȯ�� + ���ø����������;
    V_HOUSE_TOTAL_AMT             NUMBER := 0; -- �����ڱ� �� �հ� 0;
    
    V_HOUSE_REVERSE_TMP_1         NUMBER := 0; -- �������� �ٽ� ����/����ҵ���� �����ݾ׿� �־��ִ� �ӽú���.;
    V_HOUSE_REVERSE_TMP_2         NUMBER := 0; -- �������� �ٽ� ����/����ҵ���� �����ݾ׿� �־��ִ� �ӽú���.;
    
    V_HOUSE_APP_DEPOSIT_RATE      NUMBER := 0;
    V_HOUSE_APP_DEPOSIT_LMT       NUMBER := 0;
    
    V_31_TMP                      NUMBER := 0;
    V_HOUSE_FUND_AMT              NUMBER := 0;
  BEGIN
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.HOUSE_AMT_RATE, 0) HOUSE_AMT_RATE
                    , NVL(HIT.HOUSE_AMT_LMT, 0) HOUSE_AMT_LMT
                    , NVL(HIT.HOUSE_TOTAL_LMT, 0) HOUSE_TOTAL_LMT
                    , NVL(HIT.HOUSE_TOTAL_LMT_1, 0) HOUSE_TOTAL_LMT_1
                    , NVL(HIT.HOUSE_TOTAL_LMT_2, 0) HOUSE_TOTAL_LMT_2
                    --> �����ڱ�
                    , NVL(HF1.HOUSE_SAVE_AMT, 0) HOUSE_SAVE_AMT
                    , NVL(HIT.HOUSE_APP_DEPOSIT_LMT, 0) HOUSE_APP_DEPOSIT_LMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , (SELECT HF.YEAR_YYYY
                          , HF.SOB_ID
                          , HF.ORG_ID
                          , HF.HOUSE_SAVE_AMT
                        FROM HRA_FOUNDATION HF
                      WHERE HF.YEAR_YYYY    = P_YEAR_YYYY
                        AND HF.PERSON_ID    = P_PERSON_ID
                        AND HF.SOB_ID       = P_SOB_ID
                        AND HF.ORG_ID       = P_ORG_ID
                     ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.NATION_CODE   = P_NATION_CODE
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
               ) 
    LOOP
      -------------------------------------------------      
      -- �����ڱ� ���ѵ� ����;
      BEGIN
        SELECT CASE
                 WHEN NVL(HF.LONG_HOUSE_INTER_AMT_2, 0) > 0 THEN '2'
                 WHEN NVL(HF.LONG_HOUSE_INTER_AMT_1, 0) > 0 THEN '1'
                 ELSE '0'
               END LONG_HOUSE_INTER_FLAG
          INTO V_LONG_HOUSE_INTER_FLAG
          FROM HRA_FOUNDATION HF
        WHERE HF.YEAR_YYYY       = P_YEAR_YYYY
          AND HF.PERSON_ID       = P_PERSON_ID
          AND HF.SOB_ID          = P_SOB_ID
          AND HF.ORG_ID          = P_ORG_ID
        ;
      EXCEPTION
        WHEN OTHERS THEN
          V_LONG_HOUSE_INTER_FLAG := '0'; -- �����ڱ� ���ѵ� 600���� ����;
      END;
      -- �����������Աݿ����ݻ�ȯ��/��������������Ա����ڻ�ȯ��;
      BEGIN
        SELECT NVL(HA.HOUSE_INTER_AMT, 0) HOUSE_INTER_AMT,
               NVL(HA.LONG_HOUSE_PROF_AMT, 0) LONG_HOUSE_PROF_AMT
          INTO V_HOUSE_ADD_AMT, V_LONG_HOUSE_INTER_AMT
          FROM HRA_YEAR_ADJUSTMENT HA
        WHERE HA.YEAR_YYYY       = P_YEAR_YYYY
          AND HA.PERSON_ID       = P_PERSON_ID
          AND HA.SOB_ID          = P_SOB_ID
          AND HA.ORG_ID          = P_ORG_ID
        ;
      EXCEPTION
        WHEN OTHERS THEN
          V_HOUSE_ADD_AMT        := 0; -- �����������Աݿ����ݻ�ȯ40%
          V_LONG_HOUSE_INTER_AMT := 0; -- ��������������Ա�0;
      END;
      -------------------------------------------------
      -- ���ø���������Ծ�  
      V_HOUSE_SAVE_AMT := TRUNC(C1.HOUSE_SAVE_AMT * (C1.HOUSE_AMT_RATE / 100));
      V_HOUSE_SUM_AMT  := V_HOUSE_SAVE_AMT + V_HOUSE_ADD_AMT;
      IF C1.HOUSE_AMT_LMT < V_HOUSE_SUM_AMT THEN
        V_HOUSE_SAVE_AMT := V_HOUSE_SAVE_AMT - (V_HOUSE_SUM_AMT - C1.HOUSE_AMT_LMT);
      END IF;
      V_HOUSE_SUM_AMT := V_HOUSE_SAVE_AMT + V_HOUSE_ADD_AMT;
    
      -------------------------------------------------        
      -- �� �����ڱ� ���ѵ� ����; 
      IF V_LONG_HOUSE_INTER_FLAG = '2' THEN
        -- �ѵ� 1500����;
        V_HOUSE_TOTAL_AMT := V_HOUSE_SUM_AMT + V_LONG_HOUSE_INTER_AMT;
        IF C1.HOUSE_TOTAL_LMT_2 < V_HOUSE_TOTAL_AMT THEN
          V_HOUSE_SAVE_AMT := V_HOUSE_SAVE_AMT - (V_HOUSE_TOTAL_AMT - C1.HOUSE_TOTAL_LMT_2);
        END IF;      
      ELSIF V_LONG_HOUSE_INTER_FLAG = '1' THEN
        -- �ѵ� 1000����;
        V_HOUSE_TOTAL_AMT := V_HOUSE_SUM_AMT + V_LONG_HOUSE_INTER_AMT;
        IF C1.HOUSE_TOTAL_LMT_1 < V_HOUSE_TOTAL_AMT THEN
          V_HOUSE_SAVE_AMT := V_HOUSE_SAVE_AMT - (V_HOUSE_TOTAL_AMT - C1.HOUSE_TOTAL_LMT_1);
        END IF;      
      ELSE
        -- �ѵ� 600����;
        V_HOUSE_TOTAL_AMT := V_HOUSE_SUM_AMT + V_LONG_HOUSE_INTER_AMT;
        IF C1.HOUSE_TOTAL_LMT < V_HOUSE_TOTAL_AMT THEN
          V_HOUSE_SAVE_AMT := V_HOUSE_SAVE_AMT - (V_HOUSE_TOTAL_AMT - C1.HOUSE_TOTAL_LMT);
        END IF;      
      END IF;
      
      IF V_HOUSE_SAVE_AMT > C1.HOUSE_AMT_LMT THEN
        V_HOUSE_SAVE_AMT := C1.HOUSE_AMT_LMT;
      END IF;
/*      V_HOUSE_SAVE_AMT := 480000;*/
      -------------------------------------------------        
/*      V_HOUSE_SAVE_AMT := V_HOUSE_SAVE_AMT;*/
      --> �����ڱ�   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
        SET HA.HOUSE_FUND_AMT = NVL(HA.HOUSE_FUND_AMT, 0) + NVL(V_HOUSE_SAVE_AMT, 0)
/*             HA.HOUSE_SAVE_AMT = 480000*/
          , HA.HOUSE_SAVE_AMT = NVL(V_HOUSE_SAVE_AMT, 0)
      WHERE HA.YEAR_YYYY     = P_YEAR_YYYY
        AND HA.PERSON_ID     = P_PERSON_ID
        AND HA.SOB_ID        = P_SOB_ID
        AND HA.ORG_ID        = P_ORG_ID
      ;
      
/*      UPDATE IFC_HA_PENS_SAVING HPS
         SET HPS.PS_DED_AMT = NVL(V_HOUSE_SAVE_AMT, 0)
       WHERE HPS.PS_YYYY = I_YEAR_YYYY
         AND HPS.PERSON_NUMB = I_PERSON_NUMB
         AND SUBSTR(HPS.PS_TYPE, 1, 1) = '3';*/
      BEGIN
        SELECT NVL(HA.HOUSE_FUND_AMT, 0)
            , HA.HOUSE_FUND_AMT
          INTO V_HOUSE_REVERSE_TMP_1,
               V_HOUSE_FUND_AMT
          FROM HRA_YEAR_ADJUSTMENT HA
        WHERE HA.YEAR_YYYY          = P_YEAR_YYYY
          AND HA.PERSON_ID          = P_PERSON_ID
          AND HA.SOB_ID             = P_SOB_ID
          AND HA.ORG_ID             = P_ORG_ID
        ;
      EXCEPTION 
        WHEN OTHERS THEN
          V_HOUSE_REVERSE_TMP_1 := 0;
          V_HOUSE_FUND_AMT := 0;
      END;
      
      BEGIN
        SELECT NVL(HIT.HOUSE_APP_DEPOSIT_RATE, 0) HOUSE_APP_DEPOSIT_RATE,
               NVL(HIT.HOUSE_APP_DEPOSIT_LMT, 0) HOUSE_APP_DEPOSIT_LMT
          INTO V_HOUSE_APP_DEPOSIT_RATE,
               V_HOUSE_APP_DEPOSIT_LMT
          FROM HRA_INCOME_TAX_STANDARD HIT
        WHERE HIT.NATION_CODE     = P_NATION_CODE
          AND HIT.YEAR_YYYY       = P_YEAR_YYYY
          AND HIT.SOB_ID          = P_SOB_ID
          AND HIT.ORG_ID          = P_ORG_ID
        ;
      EXCEPTION 
        WHEN OTHERS THEN
          V_HOUSE_APP_DEPOSIT_RATE := 0;
          V_HOUSE_APP_DEPOSIT_LMT := 0;
      END;
         
      -- �����ڱ�_�����������Աݿ����ݻ�ȯ��(0) + �����ڱ�_������(0) + ���ø�������ҵ����_û������(0) + 
      -- ���ø�������ҵ����_����û����������(0) + ���ø�������ҵ����_������ø�������(960,000) + 
      -- ���ø�������ҵ����_�ٷ������ø�������(0) �� ���Ͽ� �ѵ���(300����) �ʰ� �� �� �����ϴ�.
      V_HOUSE_APP_DEPOSIT_LMT := C1.HOUSE_AMT_LMT - V_HOUSE_FUND_AMT;
      IF V_HOUSE_APP_DEPOSIT_LMT < 0 THEN
        V_HOUSE_APP_DEPOSIT_LMT := 0;
      END IF;
         
/*      SELECT SUM(NVL(HPS.PS_DED_AMT, 0))
        INTO V_31_DED_TOT_AMT
        FROM IFC_HA_PENS_SAVING HPS
       WHERE HPS.PS_YYYY = I_YEAR_YYYY
         AND HPS.PERSON_NUMB = I_PERSON_NUMB
         AND SUBSTR(HPS.PS_TYPE, 1, 1) IN ('31');*/
         
      FOR C1_1 IN ( SELECT HSI.SAVING_INFO_ID
                        , HSI.YEAR_YYYY
                        , HSI.PERSON_ID
                        , HSI.SAVING_TYPE
                        , HSI.BANK_CODE
                        , HSI.ACCOUNT_NUM
                        , HSI.SAVING_AMOUNT
                        , HSI.SAVING_DED_AMOUNT                            
                      FROM HRA_SAVING_INFO HSI
                     WHERE HSI.YEAR_YYYY    = P_YEAR_YYYY
                       AND HSI.PERSON_ID    = P_PERSON_ID
                       AND HSI.SOB_ID       = P_SOB_ID
                       AND HSI.ORG_ID       = P_ORG_ID
                       AND SUBSTR(HSI.SAVING_TYPE, 1, 1) IN ('3')
                     ORDER BY HSI.SAVING_TYPE ASC
                   ) 
      LOOP
        -- û�������� �����ѵ��� �ٸ��⿡ ���� �ۼ�;
        IF C1_1.SAVING_TYPE = '31' THEN 
          IF C1_1.SAVING_DED_AMOUNT <= V_HOUSE_APP_DEPOSIT_LMT THEN 
            V_HOUSE_REVERSE_TMP_1 := V_HOUSE_REVERSE_TMP_1 - C1_1.SAVING_DED_AMOUNT;
          ELSE 
            IF V_HOUSE_REVERSE_TMP_1 < 0 THEN
              V_HOUSE_REVERSE_TMP_1 := 0;
            END IF;
            BEGIN
              UPDATE HRA_SAVING_INFO HSI
                 SET HSI.SAVING_DED_AMOUNT  = V_HOUSE_APP_DEPOSIT_LMT
               WHERE HSI.SAVING_INFO_ID     = C1_1.SAVING_INFO_ID
              ;
            EXCEPTION
              WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('UPDATE SAVING ���� => ' || TO_CHAR(SQLCODE) || SQLERRM);
                RETURN 0;
            END;
            V_HOUSE_REVERSE_TMP_1 := V_HOUSE_REVERSE_TMP_1 +(C1_1.SAVING_DED_AMOUNT - V_HOUSE_APP_DEPOSIT_LMT);
          END IF;
           
        ELSIF C1_1.SAVING_TYPE = '32' THEN 
          IF C1_1.SAVING_DED_AMOUNT <= C1.HOUSE_APP_DEPOSIT_LMT THEN 
            V_HOUSE_REVERSE_TMP_1 := V_HOUSE_REVERSE_TMP_1 - C1_1.SAVING_DED_AMOUNT;
          ELSE 
            BEGIN
              UPDATE HRA_SAVING_INFO HSI
                 SET SAVING_DED_AMOUNT      = C1.HOUSE_APP_DEPOSIT_LMT
              WHERE HSI.SAVING_INFO_ID     = C1_1.SAVING_INFO_ID
              ;
            EXCEPTION
              WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('UPDATE SAVING INFO ERROR => ' || SUBSTR(SQLERRM, 1, 150));
            END;
            V_HOUSE_REVERSE_TMP_1 := V_HOUSE_REVERSE_TMP_1 +(C1_1.SAVING_DED_AMOUNT - V_HOUSE_APP_DEPOSIT_LMT);
          END IF;
        ELSIF C1_1.SAVING_DED_AMOUNT < V_HOUSE_REVERSE_TMP_1 THEN
          V_HOUSE_REVERSE_TMP_1 := V_HOUSE_REVERSE_TMP_1 - C1_1.SAVING_DED_AMOUNT;
          IF V_HOUSE_REVERSE_TMP_1 < 0 THEN
            V_HOUSE_REVERSE_TMP_1 := 0;
          END IF;
        ELSE
          IF V_HOUSE_REVERSE_TMP_1 < 0 THEN
            V_HOUSE_REVERSE_TMP_1 := 0;
          END IF;
          BEGIN
            UPDATE HRA_SAVING_INFO HSI
               SET HSI.SAVING_DED_AMOUNT  = V_HOUSE_REVERSE_TMP_1
            WHERE HSI.SAVING_INFO_ID     = C1_1.SAVING_INFO_ID
            ;
          EXCEPTION
            WHEN OTHERS THEN
              DBMS_OUTPUT.PUT_LINE('UPDATE SAVING INFO ERROR => ' || SUBSTR(SQLERRM, 1, 150));
              RETURN 0;
          END;
        END IF;
      END LOOP C1_1;
    END LOOP C1;
    RETURN NVL(V_HOUSE_SAVE_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('HOUSE_SAVE_CAL_ERROR : =>' || SUBSTR(SQLERRM, 1, 150));
      RETURN 0;
  END HOUSE_SAVE_CAL;

  -- 9. ��α� ����
  FUNCTION DONATION_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_INCOME_AMT        IN NUMBER
            ) RETURN NUMBER
  AS
    V_DONAT_POLI  NUMBER := 0; -- ��ġ��α�  
    V_DONAT_TOTAL NUMBER := 0; -- ��α� �հ� 
  
    V_DONAT_LMT NUMBER := 0; -- ��α� �ѵ� ����  
  
    V_DONAT_ALL NUMBER := 0; -- ���� ��α�  
    V_DONAT_50P NUMBER := 0; -- ��α� 50%  
    V_DONAT_30P NUMBER := 0; -- ��α� 30%
    V_DONAT_10P NUMBER := 0; -- ��α� 10%   
    V_DONAT_10P_RELIGION NUMBER := 0; -- ��α� 10%   
    
    V_DONAT_NEXT_ALL NUMBER := 0; -- ���� ��α�  �̿���;
    V_DONAT_NEXT_50P NUMBER := 0; -- ��α� 50%    �̿���;
    V_DONAT_NEXT_30P NUMBER := 0; -- ��α� 30%  �̿���;
    V_DONAT_NEXT_10P NUMBER := 0; -- ��α� 10%     �̿���;
    V_DONAT_NEXT_10P_RELIGION NUMBER := 0; -- ��α� 10%     �̿���;
    
    V_DONAT_ALL_TMP NUMBER := 0; -- ���� ��α�  �̿���;
    V_DONAT_50P_TMP NUMBER := 0; -- ��α� 50%    �̿���;
    V_DONAT_30P_TMP NUMBER := 0; -- ��α� 30%  �̿���;
    V_DONAT_10P_TMP NUMBER := 0; -- ��α� 10%     �̿���;
    V_DONAT_10P_RELIGION_TMP NUMBER := 0; -- ��α� 10%     �̿���;
    
    --> 2008�� ���� : ������α�  ������ ���� % ����;
    V_DONAT_5P           NUMBER := 0; -- ��α� 10% ������α�;
    --V_DONAT_NON_RELIGION NUMBER := 0; -- ��α� 10%�� ��������α�;
  BEGIN
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.LEGAL_GIFT_RATE, 0) DONAT_ALL_RATE
                    , NVL(HIT.ASS_GIFT_RATE1, 0) DONAT_50P_RATE
                    , NVL(HIT.ASS_GIFT_RATE2, 0) DONAT_30P_RATE
                    , NVL(HIT.ASS_GIFT_RATE3, 0) DONAT_10P_RATE
                    , NVL(HIT.ASS_GIFT_RATE3_1, 0) DONAT_5P_RATE
/*                       NVL(HIT.ASS_GIFT_RATE4, 0) DONAT_20P_RATE,*/
                    , NVL(20, 0) DONAT_20P_RATE
                    , NVL(HIT.POLI_GIFT_MAX, 0) DONAT_POLI_MAX
                    , NVL(HIT.POLI_GIFT_RATE, 0) DONAT_POLI_RATE
                    , NVL(HIT.POLI_GIFT_RATE1, 1) DONAT_POLI_RATE1
                    --> ��α� ����          
                    , NVL(HF1.DONAT_ALL, 0) DONAT_ALL
                    , NVL(HF1.DONAT_50P, 0) DONAT_50P
                    , NVL(HF1.DONAT_30P, 0) DONAT_30P
                    , NVL(HF1.DONAT_10P, 0) DONAT_10P
                    , NVL(HF1.DONAT_10P_RELIGION, 0) DONAT_10P_RELIGION
                    , NVL(HF1.DONAT_POLI, 0) DONAT_POLI
                  FROM HRA_INCOME_TAX_STANDARD HIT
                    , ( SELECT HSF.YEAR_YYYY
                            , HSF.SOB_ID
                            , HSF.ORG_ID
                            , SUM(NVL(HSF.DONAT_ALL, 0) + NVL(HSF.ETC_DONAT_ALL, 0)) DONAT_ALL
                            , SUM(NVL(HSF.DONAT_50P, 0) + NVL(HSF.ETC_DONAT_50P, 0)) DONAT_50P
                            , SUM(NVL(HSF.DONAT_30P, 0) + NVL(HSF.ETC_DONAT_30P, 0)) DONAT_30P
                            , SUM(NVL(HSF.DONAT_10P, 0) + NVL(HSF.ETC_DONAT_10P, 0)) DONAT_10P
                            , SUM(NVL(HSF.DONAT_10P_RELIGION, 0) + NVL(HSF.ETC_DONAT_10P_RELIGION, 0)) DONAT_10P_RELIGION
                            , SUM(NVL(HSF.DONAT_POLI, 0) + NVL(HSF.ETC_DONAT_POLI, 0)) DONAT_POLI
                          FROM HRA_SUPPORT_FAMILY HSF
                             , HRM_YEAR_RELATION_V HFR
                        WHERE HSF.RELATION_CODE = HFR.YEAR_RELATION_CODE(+)
                          AND HSF.SOB_ID        = HFR.SOB_ID(+)
                          AND HSF.ORG_ID        = HFR.ORG_ID(+)
                          AND HSF.YEAR_YYYY     = P_YEAR_YYYY
                          AND HSF.PERSON_ID     = P_PERSON_ID
                          AND HSF.SOB_ID        = P_SOB_ID
                          AND HSF.ORG_ID        = P_ORG_ID
                          AND 'Y' IN (HSF.BASE_YN, HSF.MEDICAL_YN, HSF.EDUCATION_YN, HSF.CREDIT_YN)
                          AND HFR.DONATION_DED_YN = 'Y'
                        GROUP BY HSF.YEAR_YYYY, HSF.PERSON_ID, HSF.SOB_ID, HSF.ORG_ID
                       ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.NATION_CODE   = P_NATION_CODE
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
               ) 
    LOOP
      --  ��ġ��α� ���� ;
      IF C1.DONAT_POLI_MAX < C1.DONAT_POLI THEN
        V_DONAT_POLI := C1.DONAT_POLI_MAX;
        V_DONAT_ALL  := C1.DONAT_POLI - C1.DONAT_POLI_MAX; -- ��ġ��α� �ѵ� �ݾ��� ���װ����� ����   
      ELSE
        V_DONAT_POLI := C1.DONAT_POLI;
      END IF;
      V_DONAT_POLI := TRUNC(V_DONAT_POLI * C1.DONAT_POLI_RATE / C1.DONAT_POLI_RATE1);
    
      -- ���� ���� (�ѵ�)  ;
      V_DONAT_LMT := 0;
      V_DONAT_LMT := TRUNC(P_INCOME_AMT * (C1.DONAT_ALL_RATE / 100)); -- ���װ��� �ѵ�  
    
      V_DONAT_ALL := V_DONAT_ALL + C1.DONAT_ALL; -- ���װ��� �ݾ�  
      IF V_DONAT_LMT < V_DONAT_ALL THEN
        V_DONAT_NEXT_ALL := V_DONAT_ALL - V_DONAT_LMT;       -- �̿��ݾ�;
        V_DONAT_ALL := V_DONAT_LMT;
      END IF;
    
      -- 50% �ѵ�(Ư�ʱ�α�);  
      V_DONAT_LMT := 0;
      V_DONAT_LMT := TRUNC((P_INCOME_AMT - V_DONAT_ALL) * (C1.DONAT_50P_RATE / 100));
      IF V_DONAT_LMT < C1.DONAT_50P THEN
        V_DONAT_NEXT_50P := C1.DONAT_50P - V_DONAT_LMT;       -- �̿��ݾ�;
        V_DONAT_50P := V_DONAT_LMT;
      ELSE
        V_DONAT_50P := C1.DONAT_50P;
      END IF;
    
      --30% ����(�츮���ֱ�α�); 
      V_DONAT_LMT := 0;
      V_DONAT_LMT := TRUNC((P_INCOME_AMT - V_DONAT_ALL - V_DONAT_50P) * (C1.DONAT_30P_RATE / 100));
      IF V_DONAT_LMT < C1.DONAT_30P THEN
        V_DONAT_NEXT_30P := C1.DONAT_30P - V_DONAT_LMT;       -- �̿��ݾ�;
        V_DONAT_30P := V_DONAT_LMT;
      ELSE
        V_DONAT_30P := C1.DONAT_30P;
      END IF;
      V_DONAT_LMT := 0;
      
      -- ���� ��α�;
      -- ������ü��α��� �ִ� ���;
      IF NVL(C1.DONAT_10P_RELIGION, 0) > 0 THEN
        -- �ѵ��׼���;
        IF ((P_INCOME_AMT - V_DONAT_ALL - V_DONAT_50P - V_DONAT_30P) * (C1.DONAT_10P_RATE / 100)) < C1.DONAT_10P THEN
          V_DONAT_LMT := ((P_INCOME_AMT - V_DONAT_ALL - V_DONAT_50P - V_DONAT_30P) * (C1.DONAT_10P_RATE / 100)) 
                          + ((P_INCOME_AMT - V_DONAT_ALL - V_DONAT_50P - V_DONAT_30P) * (C1.DONAT_10P_RATE / 100));
        ELSE 
          V_DONAT_LMT := ((P_INCOME_AMT - V_DONAT_ALL - V_DONAT_50P - V_DONAT_30P) * (C1.DONAT_10P_RATE / 100)) + C1.DONAT_10P;
        END IF;
        
        -- ������ ���;
        IF C1.DONAT_10P + C1.DONAT_10P_RELIGION > V_DONAT_LMT THEN
          V_DONAT_NEXT_10P_RELIGION := C1.DONAT_10P + C1.DONAT_10P_RELIGION - V_DONAT_LMT;       -- �̿��ݾ�;
          V_DONAT_10P_RELIGION := V_DONAT_LMT;
        ELSE
          V_DONAT_10P_RELIGION := C1.DONAT_10P + C1.DONAT_10P_RELIGION;
        END IF;
        
      -- ������ü��α��� ���� ���;
      ELSIF NVL(C1.DONAT_10P_RELIGION, 0) = 0 THEN
        -- �ѵ��׼���;
        V_DONAT_LMT := ((P_INCOME_AMT - V_DONAT_ALL - V_DONAT_50P - V_DONAT_30P) * (C1.DONAT_20P_RATE / 100));
        
        -- ������ ���;
        IF C1.DONAT_10P > V_DONAT_LMT THEN
          V_DONAT_NEXT_10P := C1.DONAT_10P - V_DONAT_LMT;       -- �̿��ݾ�;
          V_DONAT_10P := V_DONAT_LMT;
        ELSE
          V_DONAT_10P := C1.DONAT_10P;
        END IF;
        
      ELSE
          V_DONAT_LMT := 0;
          V_DONAT_10P := 0;
          V_DONAT_10P_RELIGION := 0;
          
      END IF;
    
/*      -- ���� ��α� ����  : 2. ������ü ��α�;
      \* �ѵ� ���� : (��).������α� ���ؼҵ�ݾ� * 10% + 
      (��). MIN(  ������α� ���ؼҵ�ݾ� * 5%,  ������ü�ܿ� ������ �ݾ� ) *\
      -- (��). ������α� ���ؼҵ�ݾ� * 10%;    
      V_DONAT_LMT := 0;
      V_DONAT_LMT := TRUNC((I_INCOME_AMT - V_DONAT_ALL - V_DONAT_50P -
                           V_DONAT_30P) * (C1.DONAT_10P_RATE / 100));
    
      -- (��). ������α� ���ؼҵ�ݾ� * 5%;
      V_DONAT_5P := TRUNC((I_INCOME_AMT - V_DONAT_ALL - V_DONAT_50P -
                          V_DONAT_30P) * ((C1.DONAT_5P_RATE + C1.DONAT_5P_RATE) / 100));
    
      -- ���� ��α� ����  : 1. ��������ü ��α�(�ѵ� 15%);
      V_DONAT_LMT := 0;
      V_DONAT_LMT := TRUNC((I_INCOME_AMT - V_DONAT_ALL - V_DONAT_50P -
                           V_DONAT_30P) *
                           ((C1.DONAT_10P_RATE + C1.DONAT_5P_RATE) / 100));
      IF V_DONAT_LMT < C1.DONAT_10P THEN
        V_DONAT_10P := V_DONAT_LMT;
      ELSE
        V_DONAT_10P := C1.DONAT_10P;
      END IF;
    
      -- (��). ��������ü�ܿ� ������ �ݾ�;
      V_DONAT_NON_RELIGION := NVL(C1.DONAT_10P_RELIGION, 0);
      IF V_DONAT_NON_RELIGION > 0 THEN
        -- �ѵ�����;
        -- �ٷμҵ�ݾ�*10% + MIN(�ٷμҵ�ݾ�*10%, ������ü�� ��α�);
        IF V_DONAT_5P < C1.DONAT_10P THEN      -- �ٷμҵ�ݾ��� 10%�� ������ü �� ��αݺ��� �������;
           V_DONAT_LMT := V_DONAT_5P + V_DONAT_5P;
        ELSE 
           V_DONAT_LMT := V_DONAT_5P + NVL(C1.DONAT_10P, 0);
        END IF;
           
        IF NVL(C1.DONAT_10P_RELIGION, 0) < V_DONAT_LMT THEN
          V_DONAT_10P := V_DONAT_10P + NVL(C1.DONAT_10P_RELIGION, 0);
        ELSE
          V_DONAT_10P := V_DONAT_10P + V_DONAT_LMT;
        END IF;
      
\*        -- (��)�� �ѵ� ����;
        IF V_DONAT_NON_RELIGION < V_DONAT_5P THEN
          V_DONAT_5P := V_DONAT_NON_RELIGION;
        END IF;
        V_DONAT_LMT := V_DONAT_LMT + V_DONAT_5P;

      
        --DBMS_OUTPUT.PUT_LINE('V_DONAT_LMT->' || V_DONAT_LMT || 'V_DONAT_10P=>' || V_DONAT_10P || 'V_DONAT_NON_RELIGION=>' || V_DONAT_NON_RELIGION || 'V_DONAT_5P=>' || V_DONAT_5P);        
        -- ������α�15% + ������ü ��α� ����;  
        IF V_DONAT_LMT < NVL(C1.DONAT_10P_RELIGION, 0) THEN
          V_DONAT_10P := V_DONAT_10P + V_DONAT_LMT;
        ELSE
          V_DONAT_10P := V_DONAT_10P + NVL(C1.DONAT_10P_RELIGION, 0);
        END IF;*\
      END IF;*/
    
      -- ���հ� 
      V_DONAT_TOTAL := TRUNC(V_DONAT_ALL + V_DONAT_50P + V_DONAT_30P + V_DONAT_10P + V_DONAT_10P_RELIGION);
    
      --> ��α�   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
        SET HA.DONAT_AMT              = TRUNC(NVL(V_DONAT_TOTAL, 0))
          , HA.TAX_DED_DONAT_POLI_AMT = TRUNC(NVL(V_DONAT_POLI, 0))
/*           , HA.DONAT_DED_ALL          = TRUNC(NVL(V_DONAT_ALL, 0)),
             HA.DONAT_DED_50           = TRUNC(NVL(V_DONAT_50P, 0)),
             HA.DONAT_DED_30           = TRUNC(NVL(V_DONAT_30P, 0)),
             HA.DONAT_DED_RELIGION_10  = TRUNC(NVL(V_DONAT_10P_RELIGION, 0)),
             HA.DONAT_DED_10           = TRUNC(NVL(V_DONAT_10P, 0)),
             HA.DONAT_NEXT_ALL         = TRUNC(NVL(V_DONAT_NEXT_ALL, 0)),
             HA.DONAT_NEXT_50          = TRUNC(NVL(V_DONAT_NEXT_50P, 0)),
             HA.DONAT_NEXT_30          = TRUNC(NVL(V_DONAT_NEXT_30P, 0)),
             HA.DONAT_NEXT_RELIGION_10 = TRUNC(NVL(V_DONAT_NEXT_10P_RELIGION, 0)),
             HA.DONAT_NEXT_10          = TRUNC(NVL(V_DONAT_NEXT_10P, 0))*/
      WHERE HA.YEAR_YYYY          = P_YEAR_YYYY
        AND HA.PERSON_ID          = P_PERSON_ID
        AND HA.SOB_ID             = P_SOB_ID
        AND HA.ORG_ID             = P_ORG_ID
      ;
    END LOOP C1;
    RETURN NVL(V_DONAT_TOTAL, 0);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('DONATION ERROR =>' || SUBSTR(SQLERRM, 1, 150));
      RETURN 0;
  END DONATION_CAL;

  -- 10. ȥ��, ���, �̻��� ����;
  FUNCTION MARRY_ETC_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER
  AS
    V_MARRY_ETC_AMT NUMBER := 0; -- ȥ������̻� �ݾ� 
  BEGIN
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
                  AND HIT.NATION_CODE   = P_NATION_CODE
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
    RETURN NVL(V_MARRY_ETC_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END MARRY_ETC_CAL;

  -- 11.1 ���ο�������ҵ����, �������� ����
  FUNCTION PER_ANNU_BANK_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_PER_ANNU_AMT                NUMBER := 0; -- ���ο�������;
    V_PER_ANNU_TMP                NUMBER := 0;
  BEGIN
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.PRIV_PENS_RATE, 0) PRIV_PENS_RATE
                    , NVL(HIT.PRIV_PENS_LMT, 0) PRIV_PENS_LMT
                    -- ���ο��� ����         
                    , NVL(HF1.PERSON_ANNU_AMT, 0) PERSON_ANNU_AMT
                  FROM HRA_INCOME_TAX_STANDARD HIT
                    , ( SELECT HF.YEAR_YYYY
                            , HF.SOB_ID
                            , HF.ORG_ID
                            , NVL(HF.PERSON_ANNU_AMT, 0) PERSON_ANNU_AMT
                          FROM HRA_FOUNDATION HF
                        WHERE HF.YEAR_YYYY      = P_YEAR_YYYY
                          AND HF.PERSON_ID      = P_PERSON_ID
                          AND HF.SOB_ID         = P_SOB_ID
                          AND HF.ORG_ID         = P_ORG_ID
                      ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.NATION_CODE   = P_NATION_CODE
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
              ) 
    LOOP
      --  ���ο��� ����   
      V_PER_ANNU_AMT := TRUNC(C1.PERSON_ANNU_AMT * (C1.PRIV_PENS_RATE / 100));
      IF C1.PRIV_PENS_LMT < V_PER_ANNU_AMT THEN
        V_PER_ANNU_AMT := C1.PRIV_PENS_LMT;
      END IF;
      
      --> ���ο�������    UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.PERS_ANNU_BANK_AMT = NVL(V_PER_ANNU_AMT, 0)
       WHERE HA.YEAR_YYYY         = P_YEAR_YYYY
         AND HA.PERSON_ID         = P_PERSON_ID
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
      ;
         
/*      UPDATE IFC_HA_PENS_SAVING HPS
         SET HPS.PS_DED_AMT = NVL(V_PER_ANNU_AMT, 0)
       WHERE HPS.PS_YYYY = I_YEAR_YYYY
         AND HPS.PERSON_NUMB = I_PERSON_NUMB
         AND HPS.PS_TYPE = '21';*/
      V_PER_ANNU_TMP := NVL(V_PER_ANNU_AMT, 0);
      FOR C1_1 IN ( SELECT HSI.YEAR_YYYY
                        , HSI.PERSON_ID
                        , HSI.SAVING_TYPE
                        , HSI.BANK_CODE
                        , HSI.ACCOUNT_NUM
                        , HSI.SAVING_AMOUNT
                        , HSI.SAVING_DED_AMOUNT    
                      FROM HRA_SAVING_INFO HSI
                     WHERE HSI.YEAR_YYYY      = P_YEAR_YYYY
                       AND HSI.PERSON_ID      = P_PERSON_ID
                       AND HSI.SOB_ID         = P_SOB_ID
                       AND HSI.ORG_ID         = P_ORG_ID
                       AND HSI.SAVING_TYPE    IN ('21')
                     ORDER BY HSI.SAVING_TYPE ASC
                  ) 
      LOOP
        IF C1_1.SAVING_DED_AMOUNT <= V_PER_ANNU_TMP THEN
          V_PER_ANNU_TMP := V_PER_ANNU_TMP - C1_1.SAVING_DED_AMOUNT;
          IF V_PER_ANNU_TMP < 0 THEN
            V_PER_ANNU_TMP := 0;
          END IF;
        ELSE
          BEGIN
            UPDATE HRA_SAVING_INFO HSI
               SET HSI.SAVING_DED_AMOUNT    = V_PER_ANNU_TMP
             WHERE HSI.YEAR_YYYY      = P_YEAR_YYYY
               AND HSI.PERSON_ID      = P_PERSON_ID
               AND HSI.SOB_ID         = P_SOB_ID
               AND HSI.ORG_ID         = P_ORG_ID
               AND HSI.SAVING_TYPE    = C1_1.SAVING_TYPE
               AND HSI.BANK_CODE      = C1_1.BANK_CODE
               AND HSI.ACCOUNT_NUM    = C1_1.ACCOUNT_NUM
            ;
          EXCEPTION
            WHEN OTHERS THEN
              DBMS_OUTPUT.PUT_LINE('HRA_SAVING_UPDATE_ERROR(PER) => ' || SUBSTR(SQLERRM, 1, 150));
              RETURN 0;
          END;
          V_PER_ANNU_TMP := 0;
        END IF;
      END LOOP C1_1;
    END LOOP C1;
    RETURN NVL(V_PER_ANNU_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END PER_ANNU_BANK_CAL;

  -- 11.2 ��������ҵ����, �������� ����;
  FUNCTION ANNU_BANK_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_ANNU_BANK_AMT               NUMBER := 0; -- ��������  
    V_ANNU_TMP                    NUMBER := 0;
  BEGIN
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.PENS_DED_RATE, 0) PENS_DED_RATE
                    , NVL(HIT.PENS_DED_LMT, 0) PENS_DED_LMT
                    --> ���� ����;
                    , NVL(HF1.ANNU_BANK_AMT, 0) ANNU_BANK_AMT
                  FROM HRA_INCOME_TAX_STANDARD HIT
                    , ( SELECT HF.YEAR_YYYY
                            , HF.SOB_ID
                            , HF.ORG_ID
                            , NVL(HF.ANNU_BANK_AMT, 0) ANNU_BANK_AMT
                          FROM HRA_FOUNDATION HF
                        WHERE HF.YEAR_YYYY    = P_YEAR_YYYY
                          AND HF.PERSON_ID    = P_PERSON_ID
                          AND HF.SOB_ID       = P_SOB_ID
                          AND HF.ORG_ID       = P_ORG_ID
                       ) HF1
                WHERE HIT.YEAR_YYYY       = HF1.YEAR_YYYY
                  AND HIT.SOB_ID          = HF1.SOB_ID
                  AND HIT.ORG_ID          = HF1.ORG_ID
                  AND HIT.NATION_CODE     = P_NATION_CODE
                  AND HIT.YEAR_YYYY       = P_YEAR_YYYY
                  AND HIT.SOB_ID          = P_SOB_ID
                  AND HIT.ORG_ID          = P_ORG_ID
              ) 
    LOOP
      --  �������� �ݾ�;
      V_ANNU_BANK_AMT := TRUNC(C1.ANNU_BANK_AMT * (C1.PENS_DED_RATE / 100));
      IF C1.PENS_DED_LMT < V_ANNU_BANK_AMT THEN
        V_ANNU_BANK_AMT := C1.PENS_DED_LMT;
      END IF;
    
      --> ��������    UPDATE;
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.ANNU_BANK_AMT = NVL(V_ANNU_BANK_AMT, 0)
      WHERE HA.YEAR_YYYY      = P_YEAR_YYYY
        AND HA.PERSON_ID      = P_PERSON_ID
        AND HA.SOB_ID         = P_SOB_ID
        AND HA.ORG_ID         = P_ORG_ID
      ;

      V_ANNU_TMP := NVL(V_ANNU_BANK_AMT, 0);
      FOR C1_1 IN ( SELECT HSI.YEAR_YYYY
                        , HSI.PERSON_ID
                        , HSI.SAVING_TYPE
                        , HSI.BANK_CODE
                        , HSI.ACCOUNT_NUM
                        , HSI.SAVING_AMOUNT
                        , HSI.SAVING_DED_AMOUNT    
                      FROM HRA_SAVING_INFO HSI
                     WHERE HSI.YEAR_YYYY      = P_YEAR_YYYY
                       AND HSI.PERSON_ID      = P_PERSON_ID
                       AND HSI.SOB_ID         = P_SOB_ID
                       AND HSI.ORG_ID         = P_ORG_ID
                       AND HSI.SAVING_TYPE    IN ('22')
                     ORDER BY HSI.SAVING_TYPE ASC
                   ) 
      LOOP
        IF C1_1.SAVING_DED_AMOUNT <= V_ANNU_TMP THEN
          V_ANNU_TMP := V_ANNU_TMP - C1_1.SAVING_DED_AMOUNT;
          IF V_ANNU_TMP < 0 THEN
            V_ANNU_TMP := 0;
          END IF;
        ELSE
          BEGIN
            UPDATE HRA_SAVING_INFO HSI
               SET HSI.SAVING_DED_AMOUNT    = V_ANNU_TMP
             WHERE HSI.YEAR_YYYY      = P_YEAR_YYYY
               AND HSI.PERSON_ID      = P_PERSON_ID
               AND HSI.SOB_ID         = P_SOB_ID
               AND HSI.ORG_ID         = P_ORG_ID
               AND HSI.SAVING_TYPE    = C1_1.SAVING_TYPE
               AND HSI.BANK_CODE      = C1_1.BANK_CODE
               AND HSI.ACCOUNT_NUM    = C1_1.ACCOUNT_NUM
            ;            
          EXCEPTION
            WHEN OTHERS THEN
              DBMS_OUTPUT.PUT_LINE('UPDATE_SAVING_ERROR(ANNU) => ' || SUBSTR(SQLERRM, 1, 150));
              RETURN 0;
          END;
          V_ANNU_TMP := 0;
        END IF;
      END LOOP C1_1;
    END LOOP C1;
    RETURN NVL(V_ANNU_BANK_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END ANNU_BANK_CAL;

  -- 11.3 �������� ���� ;
  FUNCTION RETR_ANNU_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_RETR_ANNU_AMT NUMBER := 0; -- ������������;
  BEGIN
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.RETR_PENS_LMT, 0) RETR_PENS_LMT
                    --> �������� ����         
                    , NVL(HF1.RETR_ANNU_AMT, 0) RETR_ANNU_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  �������� �����ڷ�  ��ȸ  
                      SELECT HF.YEAR_YYYY
                          , HF.SOB_ID
                          , HF.ORG_ID
                          , HF.PERSON_ID
                          , NVL(HF.RETR_ANNU_AMT, 0) RETR_ANNU_AMT
                        FROM HRA_FOUNDATION HF
                      WHERE HF.YEAR_YYYY    = P_YEAR_YYYY
                        AND HF.PERSON_ID    = P_PERSON_ID
                        AND HF.SOB_ID       = P_SOB_ID
                        AND HF.ORG_ID       = P_ORG_ID
                     ) HF1
                WHERE HIT.YEAR_YYYY       = HF1.YEAR_YYYY
                  AND HIT.SOB_ID          = HF1.SOB_ID
                  AND HIT.ORG_ID          = HF1.ORG_ID
                  AND HIT.NATION_CODE     = P_NATION_CODE
                  AND HIT.YEAR_YYYY       = P_YEAR_YYYY
                  AND HIT.SOB_ID          = P_SOB_ID
                  AND HIT.ORG_ID          = P_ORG_ID
               ) 
    LOOP
      --  ������������ �ݾ�   
      IF C1.RETR_PENS_LMT < C1.RETR_ANNU_AMT THEN
        V_RETR_ANNU_AMT := C1.RETR_PENS_LMT;
      ELSE
        V_RETR_ANNU_AMT := C1.RETR_ANNU_AMT;
      END IF;
      -- ������������    UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.RETR_ANNU_AMT     = V_RETR_ANNU_AMT
       WHERE HA.YEAR_YYYY         = P_YEAR_YYYY
         AND HA.PERSON_ID         = P_PERSON_ID
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
      ;
         
      UPDATE HRA_SAVING_INFO HSI
         SET HSI.SAVING_DED_AMOUNT  = NVL(V_RETR_ANNU_AMT, 0)
       WHERE HSI.YEAR_YYYY        = P_YEAR_YYYY
         AND HSI.PERSON_ID        = P_PERSON_ID
         AND HSI.SOB_ID           = P_SOB_ID
         AND HSI.ORG_ID           = P_ORG_ID
         AND SUBSTR(HSI.SAVING_TYPE, 1, 1) = '1';
    END LOOP C1;
    RETURN NVL(V_RETR_ANNU_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END RETR_ANNU_CAL;

  -- 12. ������������;
  FUNCTION INVEST_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_INCOME_AMT        IN NUMBER
            ) RETURN NUMBER
  AS
    V_INVEST_AMT NUMBER := 0; -- �������� ���� 
    V_INVEST_LMT NUMBER := 0; -- ������������ �ѵ� 
  BEGIN
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.INVEST_RATE1, 0) INVEST_RATE1
                    , NVL(HIT.INVEST_LMT_RATE1, 0) INVEST_LMT_RATE1
                    , NVL(HIT.INVEST_RATE2, 0) INVEST_RATE2
                    , NVL(HIT.INVEST_LMT_RATE2, 0) INVEST_LMT_RATE2
                    --> �������� ���� ����           
                    , NVL(HF1.INVES_AMT, 0) INVES_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  �������� �����ڷ�  ��ȸ  
                      SELECT HF.YEAR_YYYY
                          , HF.SOB_ID
                          , HF.ORG_ID
                          , NVL(HF.INVES_AMT, 0) INVES_AMT
                        FROM HRA_FOUNDATION HF
                      WHERE HF.YEAR_YYYY    = P_YEAR_YYYY
                        AND HF.PERSON_ID    = P_PERSON_ID
                        AND HF.SOB_ID       = P_SOB_ID
                        AND HF.ORG_ID       = P_ORG_ID
                     ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID                  
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.NATION_CODE   = P_NATION_CODE
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
               ) 
    LOOP
      --  �������� ���� �ݾ�   
      V_INVEST_LMT := TRUNC(P_INCOME_AMT * (C1.INVEST_LMT_RATE2 / 100));
      V_INVEST_AMT := TRUNC(C1.INVES_AMT * (C1.INVEST_RATE2 / 100));
      IF V_INVEST_LMT < V_INVEST_AMT THEN
        V_INVEST_AMT := V_INVEST_LMT;
      END IF;
    
      --> �������� ����   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.INVES_AMT     = NVL(V_INVEST_AMT, 0)
       WHERE HA.YEAR_YYYY     = P_YEAR_YYYY
         AND HA.PERSON_ID     = P_PERSON_ID
         AND HA.SOB_ID        = P_SOB_ID
         AND HA.ORG_ID        = P_ORG_ID
      ;
    END LOOP C1;
    RETURN NVL(V_INVEST_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END INVEST_CAL;

  -- 14.1 ����û���������� ���Ծ� �ҵ����;
  FUNCTION HOUSE_APP_DEPOSIT_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_HOUSE_DED_AMT     IN NUMBER
            ) RETURN NUMBER
  AS
    V_HOUSE_APP_DEPOSIT_AMT       NUMBER := 0; -- ����û���������� ���Ծ� �ҵ����;
  BEGIN
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.HOUSE_APP_DEPOSIT_RATE, 0) HOUSE_APP_DEPOSIT_RATE
                    , NVL(HIT.HOUSE_APP_DEPOSIT_LMT, 0) HOUSE_APP_DEPOSIT_LMT
                    , NVL(HIT.HOUSE_AMT_LMT, 0) HOUSE_AMT_LMT
                    -- 
                    , NVL(HF1.HOUSE_APP_DEPOSIT_AMT, 0) HOUSE_APP_DEPOSIT_AMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  �������� �����ڷ�  ��ȸ  
                     SELECT HF.YEAR_YYYY
                         , HF.SOB_ID
                         , HF.ORG_ID
                         , NVL(HF.HOUSE_APP_DEPOSIT_AMT, 0) HOUSE_APP_DEPOSIT_AMT
                       FROM HRA_FOUNDATION HF
                      WHERE HF.YEAR_YYYY    = P_YEAR_YYYY
                        AND HF.PERSON_ID    = P_PERSON_ID
                        AND HF.SOB_ID       = P_SOB_ID
                        AND HF.ORG_ID       = P_ORG_ID
                     ) HF1
                WHERE HIT.YEAR_YYYY         = HF1.YEAR_YYYY
                  AND HIT.SOB_ID            = HF1.SOB_ID
                  AND HIT.ORG_ID            = HF1.ORG_ID
                  AND HIT.NATION_CODE       = P_NATION_CODE
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
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.HOUSE_APP_DEPOSIT_AMT = NVL(V_HOUSE_APP_DEPOSIT_AMT, 0)
       WHERE HA.YEAR_YYYY         = P_YEAR_YYYY
         AND HA.PERSON_ID         = P_PERSON_ID
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
      ;
    END LOOP C1;
    RETURN NVL(V_HOUSE_APP_DEPOSIT_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END HOUSE_APP_DEPOSIT_CAL;

  -- 13. �ſ�ī��� ����;
  FUNCTION CARD_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_TOTAL_PAY         IN NUMBER
            ) RETURN NUMBER
  AS
    V_CARD_LMT                    NUMBER := 0; -- �ſ�ī�� ��� �ѵ�;
    V_CHECK_CARD_LMT              NUMBER := 0; -- üũī�� ��� �ѵ�;
    V_CARD_AMT                    NUMBER := 0; -- �ſ�ī�� ����;
  
    V_OVER_AMT                    NUMBER := 0; -- �ʰ��ݾ�;
    
    V_TEST_33 NUMBER := 0;
    V_TEST_34 NUMBER := 0;
    V_TEST_35 NUMBER := 0;
  BEGIN
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.CARD_BAS_RATE, 0) CARD_BAS_RATE
                    , NVL(HIT.CARD_DED_RATE, 0) CARD_DED_RATE
                    , NVL(HIT.CHECK_CARD_DED_RATE, 0) CHECK_CARD_DED_RATE     -- üũī�� ��������(2010�������� �߰�);
                    , NVL(HIT.CARD_DED_LMT, 0) CARD_DED_LMT
                    , NVL(HIT.CARD_DED_LMT_RATE, 0) CARD_DED_LMT_RATE
                    --> �ſ�ī�� ��� ����
                    , NVL(HSF1.CREDIT_SUM, 0) CREDIT_SUM
                    , NVL(HSF1.CHECK_CREDIT_SUM, 0) CHECK_CREDIT_SUM
                 FROM HRA_INCOME_TAX_STANDARD HIT,
                       ( --  �ξ簡���ڷ�  ��ȸ  
                        SELECT HSF.YEAR_YYYY
                             , HSF.SOB_ID
                             , HSF.ORG_ID
                             , SUM(NVL(HSF.CREDIT_AMT, 0) +
                                    NVL(HSF.ETC_CREDIT_AMT, 0) +
                                    NVL(HSF.ACADE_GIRO_AMT, 0) +
                                    NVL(HSF.ETC_ACADE_GIRO_AMT, 0) +
                                    NVL(HSF.CASH_AMT, 0) +
                                    NVL(HSF.ETC_CASH_AMT, 0)) CREDIT_SUM
                             , SUM(NVL(HSF.CHECK_CREDIT_AMT, 0) +
                                    NVL(HSF.ETC_CHECK_CREDIT_AMT, 0)) CHECK_CREDIT_SUM
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
                  AND HIT.NATION_CODE     = P_NATION_CODE
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
      V_OVER_AMT := (C1.CREDIT_SUM + C1.CHECK_CREDIT_SUM) -
                    TRUNC(P_TOTAL_PAY * (C1.CARD_BAS_RATE / 100)); -- �ʰ��ݾ�;
      V_CARD_AMT := TRUNC((V_OVER_AMT * (C1.CREDIT_SUM /
                          (C1.CREDIT_SUM + C1.CHECK_CREDIT_SUM)) *
                          (C1.CARD_DED_RATE / 100)) +
                          (V_OVER_AMT * (C1.CHECK_CREDIT_SUM /
                          (C1.CREDIT_SUM + C1.CHECK_CREDIT_SUM)) *
                          (C1.CHECK_CARD_DED_RATE / 100))); -- �����ݾ�;
                          
/*      V_TEST_33 := (V_OVER_AMT * (C1.CREDIT_SUM /
                          (C1.CREDIT_SUM + C1.C_CREDIT_SUM)) *
                          C1.CARD_DED_RATE);
      V_TEST_34 := (V_OVER_AMT * (C1.C_CREDIT_SUM /
                          (C1.CREDIT_SUM + C1.C_CREDIT_SUM)) *
                          C1.C_CARD_DED_RATE);*/
    
      -- �ѱ޿��� ���� �ѵ�  
      V_CARD_LMT := TRUNC(P_TOTAL_PAY * (C1.CARD_DED_RATE / 100));
      IF C1.CARD_DED_LMT < V_CARD_LMT THEN
        V_CARD_LMT := C1.CARD_DED_LMT;
      END IF;
    
      -- �ſ�ī�� ���ݾ�  
      IF V_CARD_LMT < V_CARD_AMT THEN
        V_CARD_AMT := V_CARD_LMT;
      END IF;
    
      IF V_CARD_AMT < 0 THEN
        V_CARD_AMT := 0;
      END IF;
    
      --> �ſ�ī�� ����   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.CREDIT_AMT = NVL(V_CARD_AMT, 0)
       WHERE HA.YEAR_YYYY       = P_YEAR_YYYY
         AND HA.PERSON_ID       = P_PERSON_ID
         AND HA.SOB_ID          = P_SOB_ID
         AND HA.ORG_ID          = P_ORG_ID
      ;    
    END LOOP C1;  
    RETURN NVL(V_CARD_AMT, 0);  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END CARD_CAL;

  -- 14. �츮�����⿬;
  FUNCTION EMPL_STOCK_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_EMPL_STOCK_AMT              NUMBER := 0; -- �츮�����⿬��  
  BEGIN
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
                  AND HIT.NATION_CODE   = P_NATION_CODE
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
    RETURN NVL(V_EMPL_STOCK_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END EMPL_STOCK_CAL;

  -- 14-1. �ұ��/�һ���� �����αݿ� ���� �ҵ����;
  FUNCTION SMALL_CORPOR_DED_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_SMALL_CORPOR_DED_AMT NUMBER := 0;
  BEGIN
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
                  AND HIT.NATION_CODE   = P_NATION_CODE
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
    RETURN NVL(V_SMALL_CORPOR_DED_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END SMALL_CORPOR_DED_CAL;

  -- 14-2. ����ֽ�������ҵ����;
  FUNCTION LONG_STOCK_SAVING_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_LONG_STOCK_SAVING_AMT       NUMBER := 0;
    V_LONG_STOCK_SAVING_AMT1      NUMBER := 0;
    V_LONG_STOCK_SAVING_AMT2      NUMBER := 0;
    V_LONG_STOCK_SAVING_AMT3      NUMBER := 0;
  BEGIN
    FOR C1 IN ( SELECT HIT.YEAR_YYYY
                    , NVL(HIT.LONG_STOCK_SAVING_RATE_1, 0) LONG_STOCK_SAVING_RATE_1
                    , NVL(HIT.LONG_STOCK_SAVING_LMT_1, 0) LONG_STOCK_SAVING_LMT_1
                    , NVL(HIT.LONG_STOCK_SAVING_RATE_2, 0) LONG_STOCK_SAVING_RATE_2
                    , NVL(HIT.LONG_STOCK_SAVING_LMT_2, 0) LONG_STOCK_SAVING_LMT_2
                    , NVL(HIT.LONG_STOCK_SAVING_RATE_3, 0) LONG_STOCK_SAVING_RATE_3 
                    , NVL(HIT.LONG_STOCK_SAVING_LMT_3, 0) LONG_STOCK_SAVING_LMT_3
                    --> ����ֽ�������ҵ����;           
                    , NVL(HF1.LONG_STOCK_SAVING_AMT_1, 0) LONG_STOCK_SAVING_AMT_1
                    , NVL(HF1.LONG_STOCK_SAVING_AMT_2, 0) LONG_STOCK_SAVING_AMT_2
                    , NVL(HF1.LONG_STOCK_SAVING_AMT_3, 0) LONG_STOCK_SAVING_AMT_3
                 FROM HRA_INCOME_TAX_STANDARD HIT
                   , ( --  �������� �����ڷ�  ��ȸ  
                     SELECT HF.YEAR_YYYY
                         , HF.SOB_ID
                         , HF.ORG_ID
                         , HF.LONG_STOCK_SAVING_AMT_1
                         , HF.LONG_STOCK_SAVING_AMT_2
                         , HF.LONG_STOCK_SAVING_AMT_3
                       FROM HRA_FOUNDATION HF
                      WHERE HF.YEAR_YYYY    = P_YEAR_YYYY
                        AND HF.PERSON_ID    = P_PERSON_ID
                        AND HF.SOB_ID       = P_SOB_ID
                        AND HF.ORG_ID       = P_ORG_ID
                     ) HF1
                WHERE HIT.YEAR_YYYY     = HF1.YEAR_YYYY
                  AND HIT.SOB_ID        = HF1.SOB_ID
                  AND HIT.ORG_ID        = HF1.ORG_ID
                  AND HIT.NATION_CODE   = P_NATION_CODE
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
              ) 
    LOOP
      V_LONG_STOCK_SAVING_AMT  := 0;
      V_LONG_STOCK_SAVING_AMT1 := 0;
      V_LONG_STOCK_SAVING_AMT2 := 0;
      V_LONG_STOCK_SAVING_AMT3 := 0;
    
      --  ����ֽ�������ҵ���� 1����;
      V_LONG_STOCK_SAVING_AMT1 := C1.LONG_STOCK_SAVING_AMT_1;
      IF C1.LONG_STOCK_SAVING_LMT_1 < V_LONG_STOCK_SAVING_AMT1 THEN
        V_LONG_STOCK_SAVING_AMT1 := C1.LONG_STOCK_SAVING_LMT_1;
      END IF;
      V_LONG_STOCK_SAVING_AMT1 := TRUNC(V_LONG_STOCK_SAVING_AMT1 * (C1.LONG_STOCK_SAVING_RATE_1 / 100));
    
      --  ����ֽ�������ҵ���� 2����;
      V_LONG_STOCK_SAVING_AMT2 := C1.LONG_STOCK_SAVING_AMT_2;
      IF C1.LONG_STOCK_SAVING_LMT_2 < V_LONG_STOCK_SAVING_AMT2 THEN
        V_LONG_STOCK_SAVING_AMT2 := C1.LONG_STOCK_SAVING_LMT_2;
      END IF;
      V_LONG_STOCK_SAVING_AMT2 := TRUNC(V_LONG_STOCK_SAVING_AMT2 * (C1.LONG_STOCK_SAVING_RATE_2 / 100));
    
      --  ����ֽ�������ҵ���� 3����;
      V_LONG_STOCK_SAVING_AMT3 := C1.LONG_STOCK_SAVING_AMT_3;
      IF C1.LONG_STOCK_SAVING_LMT_3 < V_LONG_STOCK_SAVING_AMT3 THEN
        V_LONG_STOCK_SAVING_AMT3 := C1.LONG_STOCK_SAVING_LMT_3;
      END IF;
      V_LONG_STOCK_SAVING_AMT3 := TRUNC(V_LONG_STOCK_SAVING_AMT3 * (C1.LONG_STOCK_SAVING_RATE_3 / 100));
    
      -----> ����ֽ�������ҵ����   UPDATE 
      V_LONG_STOCK_SAVING_AMT := NVL(V_LONG_STOCK_SAVING_AMT1, 0) +
                                 NVL(V_LONG_STOCK_SAVING_AMT2, 0) +
                                 NVL(V_LONG_STOCK_SAVING_AMT3, 0);
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.LONG_STOCK_SAVING_AMT   = V_LONG_STOCK_SAVING_AMT
       WHERE HA.YEAR_YYYY         = P_YEAR_YYYY
         AND HA.PERSON_ID         = P_PERSON_ID
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
      ;         
    END LOOP C1;
    RETURN NVL(V_LONG_STOCK_SAVING_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END LONG_STOCK_SAVING_CAL;

  -- 15. ����ǥ�� ;
  FUNCTION COMP_TAX_CAL
            ( P_NATION_CODE       IN VARCHAR2
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
    BEGIN
      --> ���⼼�� ��ȸ  
      SELECT TR.TAX_RATE, TR.ACCUM_SUB_AMOUNT
        INTO V_TAX_RATE, V_ACCUM_AMT
        FROM HRA_TAX_RATE TR
          , HRM_COMMON HC
      WHERE TR.TAX_TYPE_ID              = HC.COMMON_ID
        AND TR.TAX_YYYY                 = P_YEAR_YYYY
        AND HC.CODE                     = '10'
        AND TR.SOB_ID                   = P_SOB_ID
        AND TR.ORG_ID                   = P_ORG_ID
        AND NVL(P_TAX_STD_AMT, 0)       BETWEEN TR.START_AMOUNT AND TR.END_AMOUNT
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_TAX_RATE  := 1;
        V_ACCUM_AMT := 0;
        DBMS_OUTPUT.PUT_LINE('COMP_TAX_CAL_ERROR_1 =>' || SUBSTR(SQLERRM, 1, 150));
        RETURN 0;
    END;
  
    --> ���⼼�� ���  
    V_COMP_TAX_AMT := 0;
    V_COMP_TAX_AMT := TRUNC(P_TAX_STD_AMT * (V_TAX_RATE / 100));
    V_COMP_TAX_AMT := V_COMP_TAX_AMT - V_ACCUM_AMT;
  
    IF V_COMP_TAX_AMT < 0 THEN
      V_COMP_TAX_AMT := 0;
    END IF;
    RETURN NVL(V_COMP_TAX_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END COMP_TAX_CAL;

  -- 16.1 �ٷμҵ漼�װ��� ;
  FUNCTION TAX_DED_INCOME_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_COMP_TAX_AMT      IN NUMBER
            ) RETURN NUMBER
  AS
    V_TAX_DED_AMT                 NUMBER := 0; -- �ٷμҵ� ���װ���
  BEGIN
    FOR C1 IN (SELECT HIT.YEAR_YYYY
                    , NVL(HIT.IN_TAX_BASE, 0) IN_TAX_BASE
                    , NVL(HIT.IN_TAX_STD_A, 0) IN_TAX_STD_A
                    , NVL(HIT.IN_TAX_RATE_A, 0) IN_TAX_RATE_A
                    , NVL(HIT.IN_TAX_STD_B, 0) IN_TAX_STD_B
                    , NVL(HIT.IN_TAX_RATE_B, 0) IN_TAX_RATE_B
                    , NVL(HIT.IN_TAX_BASE_B, 0) IN_TAX_BASE_B
                    , NVL(HIT.IN_TAX_LMT, 0) IN_TAX_LMT
                 FROM HRA_INCOME_TAX_STANDARD HIT
                WHERE HIT.NATION_CODE   = P_NATION_CODE
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
                  AND HIT.SOB_ID        = P_SOB_ID
                  AND HIT.ORG_ID        = P_ORG_ID
                ) 
    LOOP
      IF NVL(P_COMP_TAX_AMT, 0) <= NVL(C1.IN_TAX_STD_A, 0) THEN
        V_TAX_DED_AMT := TRUNC(P_COMP_TAX_AMT * (C1.IN_TAX_RATE_A / 100));
      ELSIF NVL(P_COMP_TAX_AMT, 0) >= NVL(C1.IN_TAX_STD_B, 0) THEN
        V_TAX_DED_AMT := NVL(P_COMP_TAX_AMT, 0) - NVL(C1.IN_TAX_BASE_B, 0);
        V_TAX_DED_AMT := TRUNC(V_TAX_DED_AMT * (NVL(C1.IN_TAX_RATE_B, 0) / 100));
        V_TAX_DED_AMT := NVL(C1.IN_TAX_BASE, 0) + NVL(V_TAX_DED_AMT, 0);
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
    RETURN NVL(V_TAX_DED_AMT, 0);  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END TAX_DED_INCOME_CAL;

  -- 16.2 �������� ���װ���;
  FUNCTION TAX_DED_TAXGROUP_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_COMP_TAX_AMT      IN NUMBER
            ) RETURN NUMBER
  AS
    V_TAX_DED_TAXGROUP_AMT        NUMBER := 0; -- �������հ����ݾ�  
  BEGIN
    FOR C1 IN (SELECT HIT.YEAR_YYYY
                   , NVL(HIT.TAX_ASSO_RATE, 0) TAX_ASSO_RATE
                 FROM HRA_INCOME_TAX_STANDARD HIT
                WHERE HIT.NATION_CODE   = P_NATION_CODE
                  AND HIT.YEAR_YYYY     = P_YEAR_YYYY
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
    RETURN NVL(V_TAX_DED_TAXGROUP_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END TAX_DED_TAXGROUP_CAL;

  -- 16.3 �����ڱ����Ա� ���װ���;
  FUNCTION HOUSE_DEBT_BEN_CAL
            ( P_NATION_CODE       IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_REAL_TAX          IN NUMBER
            ) RETURN NUMBER
  AS
    V_HOUSE_DEBT_BEN_AMT          NUMBER := 0;
  BEGIN
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
                  AND HIT.NATION_CODE   = P_NATION_CODE
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
    
      -----> �ٷμҵ� ����   UPDATE 
      UPDATE HRA_YEAR_ADJUSTMENT HA
         SET HA.TAX_DED_HOUSE_DEBT_AMT  = NVL(V_HOUSE_DEBT_BEN_AMT, 0),
             HA.FIX_SP_TAX_AMT          = TRUNC(V_HOUSE_DEBT_BEN_AMT / (C1.SP_TAX_RATE / 100), -1)
       WHERE HA.YEAR_YYYY         = P_YEAR_YYYY
         AND HA.PERSON_ID         = P_PERSON_ID
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
       ;
    END LOOP C1;
    RETURN NVL(V_HOUSE_DEBT_BEN_AMT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END HOUSE_DEBT_BEN_CAL;

END HRA_YEAR_ADJUST_SET_G_2010;
/
