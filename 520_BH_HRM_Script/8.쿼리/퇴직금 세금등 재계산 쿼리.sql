DECLARE
 
    V_SYSDATE                                     DATE := GET_LOCAL_DATE(&W_SOB_ID);
    
    V_TEMP_DATE                                   DATE;           -- �ӽ� ����.
    V_3RD_DAY_COUNT                               NUMBER;         -- 3���� ���ϼ� (�޿��ϼ�)
    V_3RD_DAY_COUNT2                              NUMBER;         -- 3���� ���ϼ� (�󿩿����ϼ�)
    V_CHANGE_DAY                                  NUMBER;         -- �����ϼ�.
    V_REAL_DAY                                    NUMBER;         -- ���� ����Ǵ� �ٹ��ϼ�
    V_RETR_AMOUNT                                 NUMBER;         -- ������
    V_TOTAL_RETR_AMOUNT                           NUMBER;         -- ��������
    V_REAL_AMOUNT                                 NUMBER;         -- ��������        
    V_INCOME_DED_AMOUNT                           NUMBER;         -- �����ҵ����
    V_LONG_DED_YEAR_AMOUNT                        NUMBER;         -- �ټӳ���� ���� �ҵ����    
    V_TAX_STD_AMOUNT                              NUMBER;         -- ����ǥ��
    
    V_TAX_STD_AMOUNT_1                            NUMBER;         -- ����ǥ�� �Ⱥ� 2012�� 12�� 31�� ���� (����ǥ�� / ����ټӿ��� * �� �ټӿ���)<2014 �߰�>  
    V_TAX_STD_AMOUNT_2                            NUMBER;         -- ����ǥ�� �Ⱥ� 2013�� 1�� 1�� ���� (����ǥ�� / ����ټӿ��� * �� �ټӿ���)<2014 �߰�>   
    
    V_AVG_TAX_STD_AMOUNT_1                        NUMBER;         -- ����հ���ǥ��
    V_AVG_COMP_TAX_AMOUNT_1                       NUMBER;         -- ����� ���⼼��
    V_COMP_TAX_AMOUNT_1                           NUMBER;         -- ���⼼��
    V_TAX_DED_AMOUNT_1                            NUMBER;         -- �����ҵ漼�װ���
    V_IN_TAX_AMOUNT_1                             NUMBER;         -- �ҵ漼
    V_LOCAL_TAX_AMOUNT_1                          NUMBER;         -- �ֹμ�
    
    V_AVG_TAX_STD_AMOUNT_2                        NUMBER;         -- ����հ���ǥ��
    V_CHG_TAX_STD_AMOUNT_2                        NUMBER;         -- ȯ�����ǥ��<2014 �߰�> 
    V_CHG_COMP_TAX_AMOUNT_2                       NUMBER;         -- ȯ����⼼��<2014 �߰�>  
    V_AVG_COMP_TAX_AMOUNT_2                       NUMBER;         -- ����� ���⼼��
    V_COMP_TAX_AMOUNT_2                           NUMBER;         -- ���⼼��
    V_TAX_DED_AMOUNT_2                            NUMBER;         -- �����ҵ漼�װ���
    V_IN_TAX_AMOUNT_2                             NUMBER;         -- �ҵ漼
    V_LOCAL_TAX_AMOUNT_2                          NUMBER;         -- �ֹμ�
    
    V_H_RETIRE_DATE_FR                            DATE;           -- ������ ���� ������.
    V_H_RETIRE_DATE_TO                            DATE;           -- ������ ���� ������.
    V_H_LONG_YEAR                                 NUMBER;         -- ������ �ټӳ��.
    V_H_PRE_LONG_YEAR                             NUMBER;         -- ���������� �ߵ����� ���� �ټӳ��.
    V_H_INCOME_DED_AMOUNT                         NUMBER;         -- �����ҵ����
    V_H_LONG_DED_YEAR_AMOUNT                      NUMBER;         -- �ټӳ���� ���� �ҵ����    
    V_H_TAX_STD_AMOUNT                            NUMBER;         -- ����ǥ��
    V_H_AVG_TAX_STD_AMOUNT                        NUMBER;         -- ����հ���ǥ��
    V_H_AVG_COMP_TAX_AMOUNT                       NUMBER;         -- ����� ���⼼��
    V_H_COMP_TAX_AMOUNT                           NUMBER;         -- ���⼼��
    V_H_TAX_DED_AMOUNT                            NUMBER;         -- �����ҵ漼�װ���
    V_H_IN_TAX_AMOUNT                             NUMBER;         -- �ҵ漼
    V_H_LOCAL_TAX_AMOUNT                          NUMBER;         -- �ֹμ�
    V_H_REAL_AMOUNT                               NUMBER;         -- ��������.
    
    V_REAL_TOTAL_AMOUNT                           NUMBER;         -- �� ��������.
    V_TEMP_AMOUNT                                 NUMBER;         -- �ӽ� ����.
    
  BEGIN
    
    --> ���������� ���� ���� ����
    FOR C1 IN (SELECT RA.ADJUSTMENT_ID
                    , RA.SOB_ID 
                    , RA.ORG_ID 
                    , RA.ADJUSTMENT_YYYY AS ADJUSTMENT_YYYY 
                    , RA.RETIRE_DATE_FR
                    , RA.RETIRE_DATE_TO
                    , NVL(RA.LONG_YEAR, 0) AS LONG_YEAR
                    , NVL(RA.LONG_MONTH, 0) AS LONG_MONTH
                    , NVL(RA.LONG_DAY, 0) AS LONG_DAY
                    , NVL(RA.TOTAL_PAY_AMOUNT, 0) AS TOTAL_PAY_AMOUNT
                    , NVL(RA.TOTAL_BONUS_AMOUNT, 0) AS TOTAL_BONUS_AMOUNT
                    , NVL(RA.YEAR_ALLOWANCE_AMOUNT, 0) AS YEAR_ALLOWANCE_AMOUNT
                    , NVL(RA.DAY_AVG_AMOUNT, 0) AS DAY_AVG_AMOUNT
                    , NVL(RA.RETIRE_AMOUNT, 0) AS RETIRE_AMOUNT
                    , NVL(RA.GLORY_AMOUNT, 0) AS GLORY_AMOUNT
                    , NVL(RA.RETIRE_TOTAL_AMOUNT, 0) AS RETIRE_TOTAL_AMOUNT
                    , NVL(RA.INCOME_DED_AMOUNT, 0) AS INCOME_DED_AMOUNT
                    , NVL(RA.LONG_DED_AMOUNT , 0) AS LONG_DED_AMOUNT
                    , NVL(RA.TAX_STD_AMOUNT, 0) AS TAX_STD_AMOUNT
                    , NVL(RA.AVG_TAX_STD_AMOUNT, 0) AS AVG_TAX_STD_AMOUNT
                    , NVL(RA.AVG_COMP_TAX_AMOUNT, 0) AS AVG_COMP_TAX_AMOUNT
                    , NVL(RA.COMP_TAX_AMOUNT, 0) AS COMP_TAX_AMOUNT
                    , NVL(RA.TAX_DED_AMOUNT, 0) AS TAX_DED_AMOUNT
                    , NVL(RA.INCOME_TAX_AMOUNT, 0) AS INCOME_TAX_AMOUNT
                    , NVL(RA.RESIDENT_TAX_AMOUNT, 0) AS RESIDENT_TAX_AMOUNT
                    , NVL(RA.RETIRE_CVS_AMOUNT, 0) AS RETIRE_CVS_AMOUNT
                    , NVL(RA.REAL_AMOUNT, 0) AS REAL_AMOUNT
                    , NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE) AS JOIN_DATE
                    , NVL(RA.HONORARY_AMOUNT, 0) AS HONORARY_AMOUNT
                    , NVL(RA.ETC_SUPP_AMOUNT, 0) AS ETC_SUPP_AMOUNT
                    , NVL(RA.ETC_DED_AMOUNT, 0) AS ETC_DED_AMOUNT
                    , NVL(RA.HEALTH_INSUR_AMOUNT, 0) AS HEALTH_INSUR_AMOUNT
                    , NVL(RA.LONG_YEAR_1, 0) AS LONG_YEAR_1
                    , NVL(RA.LONG_MONTH_1, 0) AS LONG_MONTH_1
                    , NVL(RA.LONG_DAY_1, 0) AS LONG_DAY_1
                    , NVL(RA.LONG_YEAR_2, 0) AS LONG_YEAR_2
                    , NVL(RA.LONG_MONTH_2, 0) AS LONG_MONTH_2
                    , NVL(RA.LONG_DAY_2, 0) AS LONG_DAY_2
                 FROM HRR_RETIRE_ADJUSTMENT RA
                   , HRM_PERSON_MASTER PM
               WHERE RA.PERSON_ID          = PM.PERSON_ID
                 AND RA.RETIRE_DATE_TO     >= '2014-01-01'
               )
    LOOP
      --> �ʱ�ȭ
      V_REAL_DAY := 0;                  -- ���� �ټ��ϼ�
      V_RETR_AMOUNT := 0;               -- ������
      V_TOTAL_RETR_AMOUNT := 0;         -- �������� �հ�
      
      V_INCOME_DED_AMOUNT := 0;         -- �����ҵ����
      V_LONG_DED_YEAR_AMOUNT := 0;      -- �ټӳ���� ���� �ҵ����
      V_TAX_STD_AMOUNT := 0;            -- ����ǥ��      
      V_TAX_STD_AMOUNT_1 := 0;          -- ����ǥ�� �Ⱥ� 2012�� 12�� 31�� ���� (����ǥ�� / ����ټӿ��� * �� �ټӿ���) 
      V_TAX_STD_AMOUNT_2 := 0;          -- ����ǥ�� �Ⱥ� 2013�� 1�� 1�� ���� (����ǥ�� / ����ټӿ��� * �� �ټӿ���) 
      
      V_AVG_TAX_STD_AMOUNT_1 := 0;      -- ����� ����ǥ��
      V_AVG_COMP_TAX_AMOUNT_1 := 0;     -- ����� ���⼼��
      V_COMP_TAX_AMOUNT_1 := 0;         -- ���⼼��
      V_TAX_DED_AMOUNT_1 := 0;          -- �����ҵ漼�װ���
      V_IN_TAX_AMOUNT_1 := 0;           -- �ҵ漼
      V_LOCAL_TAX_AMOUNT_1 := 0;        -- �ֹμ�
      
      V_AVG_TAX_STD_AMOUNT_2 := 0;      -- ����� ����ǥ��
      V_CHG_TAX_STD_AMOUNT_2 := 0;      -- ȯ�� ����ǥ��<2014 �߰�>  
      V_CHG_COMP_TAX_AMOUNT_2 := 0;     -- ȯ�� ���⼼��<2014 �߰�>  
      V_AVG_COMP_TAX_AMOUNT_2 := 0;     -- ����� ���⼼��
      V_COMP_TAX_AMOUNT_2 := 0;         -- ���⼼��
      V_TAX_DED_AMOUNT_2 := 0;          -- �����ҵ漼�װ���
      V_IN_TAX_AMOUNT_2 := 0;           -- �ҵ漼
      V_LOCAL_TAX_AMOUNT_2 := 0;        -- �ֹμ�
      
      V_REAL_AMOUNT := 0;               -- ��������
      V_REAL_TOTAL_AMOUNT                           := 0;         -- �� 
      
      --> ������ ���
      V_RETR_AMOUNT := NVL(C1.RETIRE_AMOUNT, 0);

      --> ��������
      V_TOTAL_RETR_AMOUNT := NVL(V_RETR_AMOUNT, 0) + NVL(C1.GLORY_AMOUNT, 0);

---------------------------------------------------------------------------------------------------
      --> �����ٷμҵ� ����
      V_INCOME_DED_AMOUNT := C1.INCOME_DED_AMOUNT;

      --> �ټӿ� ���� �ҵ����
      V_LONG_DED_YEAR_AMOUNT := C1.LONG_DED_AMOUNT;

      --> ���� ǥ��
      V_TAX_STD_AMOUNT := NVL(V_TOTAL_RETR_AMOUNT, 0) - NVL(V_INCOME_DED_AMOUNT, 0) - NVL(V_LONG_DED_YEAR_AMOUNT, 0);
      IF V_TAX_STD_AMOUNT < 0 THEN
        V_TAX_STD_AMOUNT := 0;
      END IF;
      
      --> ����ǥ�� �Ⱥ� 
      V_TAX_STD_AMOUNT_1 := TRUNC(V_TAX_STD_AMOUNT / (NVL(C1.LONG_YEAR_1, 0) + NVL(C1.LONG_YEAR_2, 0)) * NVL(C1.LONG_YEAR_1, 0));
      V_TAX_STD_AMOUNT_2 := V_TAX_STD_AMOUNT - V_TAX_STD_AMOUNT_1;
      IF V_TAX_STD_AMOUNT != V_TAX_STD_AMOUNT_1 + V_TAX_STD_AMOUNT_2 THEN
        DBMS_OUTPUT.PUT_LINE( 'Tax STD Division Amount Error : ' || SUBSTR(SQLERRM, 1, 150));       
        RETURN;
      END IF;
      
      -- �⵵�� �ҵ漼 ��� --
      V_REAL_AMOUNT := NVL(V_TOTAL_RETR_AMOUNT, 0);
      IF NVL(C1.LONG_YEAR_1, 0) > 0 THEN
        -- 2102�⵵ ���� ���� ��� --
        BEGIN
          --> ����� ����ǥ��(�������ڱ��� �ټӳ�� ����)  
          --> (����ǥ�� / (�ѱټӳ��) * 12�⵵���� �ټӳ��) / 12�⵵���� �ټӳ��  
          
          -- 12�⵵���� ����հ���ǥ�� �ݾ� ���  
          V_AVG_TAX_STD_AMOUNT_1 := TRUNC(V_TAX_STD_AMOUNT_1 / NVL(C1.LONG_YEAR_1, 0));
        EXCEPTION 
          WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Avg Tax STD Amount Error : ' || SUBSTR(SQLERRM, 1, 150));       
            RETURN;
        END;

        --> ���⼼��
        V_AVG_COMP_TAX_AMOUNT_1 := HRR_RETIRE_ADJUSTMENT_SET_G.AVG_TAX_AMOUNT_F(C1.ADJUSTMENT_YYYY, C1.SOB_ID, C1.ORG_ID, V_AVG_TAX_STD_AMOUNT_1);

        --> ���⼼��
        V_COMP_TAX_AMOUNT_1 := TRUNC(V_AVG_COMP_TAX_AMOUNT_1 * C1.LONG_YEAR_1);

        --> �ҵ漼�װ���
        V_TAX_DED_AMOUNT_1 := HRR_RETIRE_ADJUSTMENT_SET_G.TAX_SUBTRACT_F(C1.ADJUSTMENT_YYYY, C1.SOB_ID, C1.ORG_ID, C1.RETIRE_DATE_TO, V_COMP_TAX_AMOUNT_1, C1.LONG_YEAR_1);

        --> �ҵ漼
        V_IN_TAX_AMOUNT_1 := TRUNC(NVL(V_COMP_TAX_AMOUNT_1, 0) - NVL(V_TAX_DED_AMOUNT_1, 0));   -- ������ ����
        IF V_IN_TAX_AMOUNT_1 < 0 THEN
          V_IN_TAX_AMOUNT_1 := 0;
        END IF;

        --> �ֹμ�
        V_LOCAL_TAX_AMOUNT_1 := TRUNC(V_IN_TAX_AMOUNT_1 * 10 / 100);   -- ������ ����
      END IF;
      
      IF NVL(C1.LONG_YEAR_2, 0) > 0 THEN
        -- 2103�⵵ ���� ���� ��� --
        BEGIN
          --> ����� ����ǥ��(�������ڱ��� �ټӳ�� ����)  
          -- 13�⵵ ����ǥ�� �ݾ� ���� --
          --> (�Ⱥа���ǥ�� / �ټӿ���)  
          V_AVG_TAX_STD_AMOUNT_2 := NVL(V_TAX_STD_AMOUNT_2, 0) / NVL(C1.LONG_YEAR_2, 0);
        EXCEPTION 
          WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Avg Tax STD Amount Error : ' || SUBSTR(SQLERRM, 1, 150));       
            RETURN;
        END;
        
        --> ȯ�� ����ǥ��(����հ���ǥ�� * 5)  
        V_CHG_TAX_STD_AMOUNT_2 := V_AVG_TAX_STD_AMOUNT_2 * 5;
        
        --> ȯ����⼼��(ȯ�����ǥ�� * ����)  
        V_CHG_COMP_TAX_AMOUNT_2 := HRR_RETIRE_ADJUSTMENT_SET_G.AVG_TAX_AMOUNT_F(C1.ADJUSTMENT_YYYY, C1.SOB_ID, C1.ORG_ID, V_CHG_TAX_STD_AMOUNT_2);
        
        --> ����ջ��⼼��(ȯ����⼼�� / 5)
        V_AVG_COMP_TAX_AMOUNT_2 := TRUNC(V_CHG_COMP_TAX_AMOUNT_2 / 5);

        --> �ҵ漼�װ���
        V_TAX_DED_AMOUNT_2 := HRR_RETIRE_ADJUSTMENT_SET_G.TAX_SUBTRACT_F(C1.ADJUSTMENT_YYYY, C1.SOB_ID, C1.ORG_ID, C1.RETIRE_DATE_TO, V_AVG_COMP_TAX_AMOUNT_2, C1.LONG_YEAR_2);

        --> ���⼼��(����ջ��⼼�� * �ټӿ���) 
        V_COMP_TAX_AMOUNT_2 := TRUNC(V_AVG_COMP_TAX_AMOUNT_2 * C1.LONG_YEAR_2);
        
        --> �ҵ漼
        V_IN_TAX_AMOUNT_2 := TRUNC(NVL(V_COMP_TAX_AMOUNT_2, 0) - NVL(V_TAX_DED_AMOUNT_2, 0));   -- ������ ����
        
        -- 2013-07-13 START OF MODIFY --
        -- ��ȣ�� �߰� : ������ ����(2012��/2013�� ���Ұ������ ���� �ҵ漼 �հ�� ������ ���� �߻�) --
        V_TEMP_AMOUNT :=0;
        V_TEMP_AMOUNT := TRUNC((NVL(V_COMP_TAX_AMOUNT_1, 0) + NVL(V_COMP_TAX_AMOUNT_2, 0))) - 
                         (TRUNC(NVL(V_COMP_TAX_AMOUNT_1, 0)) + TRUNC(NVL(V_COMP_TAX_AMOUNT_2, 0)));
        IF NVL(V_TEMP_AMOUNT, 0) != 0 THEN
          V_IN_TAX_AMOUNT_2 := NVL(V_IN_TAX_AMOUNT_2, 0) + NVL(V_TEMP_AMOUNT, 0);
        END IF;
        --> 2013-07-13 END OF MODIFY  -- 
        IF V_IN_TAX_AMOUNT_2 < 0 THEN
          V_IN_TAX_AMOUNT_2 := 0;
        END IF;
        
        --> �ֹμ�
        V_LOCAL_TAX_AMOUNT_2 := TRUNC(V_IN_TAX_AMOUNT_2 * 10 / 100);   -- ������ ����
      END IF;
      
      -- �����޾� ��� -- 
      --> �����޾� (�������� - �ֹμ� - �ҵ漼 - ��Ÿ���� - ������ȯ��)
      V_REAL_AMOUNT := NVL(V_REAL_AMOUNT, 0) - TRUNC(NVL(V_IN_TAX_AMOUNT_1, 0) + NVL(V_IN_TAX_AMOUNT_2, 0), -1) 
                                             - TRUNC(NVL(V_LOCAL_TAX_AMOUNT_1, 0) + NVL(V_LOCAL_TAX_AMOUNT_2, 0), -1);
      IF V_REAL_AMOUNT < 0 THEN
        V_REAL_AMOUNT := 0;
      END IF;

------------------------------------------------------------------------------      
      V_REAL_TOTAL_AMOUNT := NVL(V_REAL_AMOUNT, 0) + NVL(V_H_REAL_AMOUNT, 0) + 
                             (NVL(C1.ETC_SUPP_AMOUNT, 0) - NVL(C1.ETC_DED_AMOUNT, 0)) - NVL(C1.RETIRE_CVS_AMOUNT, 0);
      IF V_REAL_TOTAL_AMOUNT < 0 THEN
        V_REAL_TOTAL_AMOUNT := 0;
      END IF;
            
------------------------------------------------------------------------------
      --> ������ ����  --
      UPDATE HRR_RETIRE_ADJUSTMENT RA
        SET RA.TAX_STD_AMOUNT         = V_TAX_STD_AMOUNT 
          , RA.TAX_STD_AMOUNT_1       = V_TAX_STD_AMOUNT_1  -- ��ȣ�� �߰� 
          , RA.TAX_STD_AMOUNT_2       = V_TAX_STD_AMOUNT_2  -- ��ȣ�� �߰� 
          , RA.AVG_TAX_STD_AMOUNT     = (NVL(V_AVG_TAX_STD_AMOUNT_1, 0) + NVL(V_AVG_TAX_STD_AMOUNT_2, 0)) 
          , RA.AVG_COMP_TAX_AMOUNT    = (NVL(V_AVG_COMP_TAX_AMOUNT_1, 0) + NVL(V_AVG_COMP_TAX_AMOUNT_2, 0)) 
          , RA.COMP_TAX_AMOUNT        = (NVL(V_COMP_TAX_AMOUNT_1, 0) + NVL(V_COMP_TAX_AMOUNT_2, 0)) 
          , RA.TAX_DED_AMOUNT         = (NVL(V_TAX_DED_AMOUNT_1, 0) + NVL(V_TAX_DED_AMOUNT_2, 0)) 
          , RA.INCOME_TAX_AMOUNT      = (NVL(V_IN_TAX_AMOUNT_1, 0) + NVL(V_IN_TAX_AMOUNT_2, 0)) 
          , RA.RESIDENT_TAX_AMOUNT    = (NVL(V_LOCAL_TAX_AMOUNT_1, 0) + NVL(V_LOCAL_TAX_AMOUNT_2, 0)) 
          , RA.REAL_AMOUNT            = V_REAL_AMOUNT
          , RA.REAL_TOTAL_AMOUNT      = V_REAL_TOTAL_AMOUNT
          , RA.LAST_UPDATE_DATE       = V_SYSDATE
          , RA.AVG_TAX_STD_AMOUNT_1   = V_AVG_TAX_STD_AMOUNT_1
          , RA.AVG_COMP_TAX_AMOUNT_1  = V_AVG_COMP_TAX_AMOUNT_1
          , RA.COMP_TAX_AMOUNT_1      = V_COMP_TAX_AMOUNT_1
          , RA.TAX_DED_AMOUNT_1       = V_TAX_DED_AMOUNT_1
          , RA.INCOME_TAX_AMOUNT_1    = V_IN_TAX_AMOUNT_1
          , RA.RESIDENT_TAX_AMOUNT_1  = V_LOCAL_TAX_AMOUNT_1
          , RA.AVG_TAX_STD_AMOUNT_2   = V_AVG_TAX_STD_AMOUNT_2 
          
          , RA.CHG_TAX_STD_AMOUNT_2   = V_CHG_TAX_STD_AMOUNT_2  -- <2014 �߰�> 
          , RA.CHG_COMP_TAX_AMOUNT_2  = V_CHG_COMP_TAX_AMOUNT_2 -- <2014 �߰�> 
          
          , RA.AVG_COMP_TAX_AMOUNT_2  = V_AVG_COMP_TAX_AMOUNT_2 
          , RA.COMP_TAX_AMOUNT_2      = V_COMP_TAX_AMOUNT_2 
          , RA.TAX_DED_AMOUNT_2       = V_TAX_DED_AMOUNT_2 
          , RA.INCOME_TAX_AMOUNT_2    = V_IN_TAX_AMOUNT_2 
          , RA.RESIDENT_TAX_AMOUNT_2  = V_LOCAL_TAX_AMOUNT_2 
      WHERE RA.ADJUSTMENT_ID          = C1.ADJUSTMENT_ID
      ;
    END LOOP C1;
  END;
  
/*
SELECT RA.ADJUSTMENT_ID
                    , PM.PERSON_NUM
                    , PM.NAME
                    , RA.RETIRE_DATE_FR
                    , RA.RETIRE_DATE_TO
                    , NVL(RA.LONG_YEAR, 0) AS LONG_YEAR
                    , NVL(RA.LONG_MONTH, 0) AS LONG_MONTH
                    , NVL(RA.LONG_DAY, 0) AS LONG_DAY
                    , NVL(RA.TOTAL_PAY_AMOUNT, 0) AS TOTAL_PAY_AMOUNT
                    , NVL(RA.TOTAL_BONUS_AMOUNT, 0) AS TOTAL_BONUS_AMOUNT
                    , NVL(RA.YEAR_ALLOWANCE_AMOUNT, 0) AS YEAR_ALLOWANCE_AMOUNT
                    , NVL(RA.DAY_AVG_AMOUNT, 0) AS DAY_AVG_AMOUNT
                    , NVL(RA.RETIRE_AMOUNT, 0) AS RETIRE_AMOUNT
                    , NVL(RA.GLORY_AMOUNT, 0) AS GLORY_AMOUNT
                    , NVL(RA.RETIRE_TOTAL_AMOUNT, 0) AS RETIRE_TOTAL_AMOUNT
                    , NVL(RA.INCOME_DED_AMOUNT, 0) AS INCOME_DED_AMOUNT
                    , NVL(RA.LONG_DED_AMOUNT , 0) AS LONG_DED_AMOUNT
                    , NVL(RA.TAX_STD_AMOUNT, 0) AS TAX_STD_AMOUNT
                    , NVL(RA.AVG_TAX_STD_AMOUNT, 0) AS AVG_TAX_STD_AMOUNT
                    , NVL(RA.AVG_COMP_TAX_AMOUNT, 0) AS AVG_COMP_TAX_AMOUNT
                    , NVL(RA.COMP_TAX_AMOUNT, 0) AS COMP_TAX_AMOUNT
                    , NVL(RA.TAX_DED_AMOUNT, 0) AS TAX_DED_AMOUNT
                    , NVL(RA.INCOME_TAX_AMOUNT, 0) AS INCOME_TAX_AMOUNT
                    , NVL(RA.RESIDENT_TAX_AMOUNT, 0) AS RESIDENT_TAX_AMOUNT
                    , NVL(RA.RETIRE_CVS_AMOUNT, 0) AS RETIRE_CVS_AMOUNT
                    , NVL(RA.REAL_AMOUNT, 0) AS REAL_AMOUNT
                    , NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE) AS JOIN_DATE
                    , NVL(RA.HONORARY_AMOUNT, 0) AS HONORARY_AMOUNT
                    , NVL(RA.ETC_SUPP_AMOUNT, 0) AS ETC_SUPP_AMOUNT
                    , NVL(RA.ETC_DED_AMOUNT, 0) AS ETC_DED_AMOUNT
                    , NVL(RA.HEALTH_INSUR_AMOUNT, 0) AS HEALTH_INSUR_AMOUNT
                    , NVL(RA.LONG_YEAR_1, 0) AS LONG_YEAR_1
                    , NVL(RA.LONG_MONTH_1, 0) AS LONG_MONTH_1
                    , NVL(RA.LONG_DAY_1, 0) AS LONG_DAY_1
                    , NVL(RA.LONG_YEAR_2, 0) AS LONG_YEAR_2
                    , NVL(RA.LONG_MONTH_2, 0) AS LONG_MONTH_2
                    , NVL(RA.LONG_DAY_2, 0) AS LONG_DAY_2
                    , RA.LAST_UPDATE_DATE 
                 FROM HRR_RETIRE_ADJUSTMENT RA
                   , HRM_PERSON_MASTER PM
               WHERE RA.PERSON_ID          = PM.PERSON_ID
                 AND RA.RETIRE_DATE_TO     >= '2014-01-01'
                 ;
                 */  
