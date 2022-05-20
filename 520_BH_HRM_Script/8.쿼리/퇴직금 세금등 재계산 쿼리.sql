DECLARE
 
    V_SYSDATE                                     DATE := GET_LOCAL_DATE(&W_SOB_ID);
    
    V_TEMP_DATE                                   DATE;           -- 임시 일자.
    V_3RD_DAY_COUNT                               NUMBER;         -- 3개월 총일수 (급여일수)
    V_3RD_DAY_COUNT2                              NUMBER;         -- 3개월 총일수 (상여연차일수)
    V_CHANGE_DAY                                  NUMBER;         -- 가감일수.
    V_REAL_DAY                                    NUMBER;         -- 실제 적용되는 근무일수
    V_RETR_AMOUNT                                 NUMBER;         -- 퇴직금
    V_TOTAL_RETR_AMOUNT                           NUMBER;         -- 총퇴직금
    V_REAL_AMOUNT                                 NUMBER;         -- 실퇴직금        
    V_INCOME_DED_AMOUNT                           NUMBER;         -- 퇴직소득공제
    V_LONG_DED_YEAR_AMOUNT                        NUMBER;         -- 근속년수에 따른 소득공제    
    V_TAX_STD_AMOUNT                              NUMBER;         -- 과세표준
    
    V_TAX_STD_AMOUNT_1                            NUMBER;         -- 과세표준 안부 2012년 12월 31일 이전 (과세표준 / 정산근속연수 * 각 근속연수)<2014 추가>  
    V_TAX_STD_AMOUNT_2                            NUMBER;         -- 과세표준 안부 2013년 1월 1일 이후 (과세표준 / 정산근속연수 * 각 근속연수)<2014 추가>   
    
    V_AVG_TAX_STD_AMOUNT_1                        NUMBER;         -- 년평균과세표준
    V_AVG_COMP_TAX_AMOUNT_1                       NUMBER;         -- 년평균 산출세액
    V_COMP_TAX_AMOUNT_1                           NUMBER;         -- 산출세액
    V_TAX_DED_AMOUNT_1                            NUMBER;         -- 퇴직소득세액공제
    V_IN_TAX_AMOUNT_1                             NUMBER;         -- 소득세
    V_LOCAL_TAX_AMOUNT_1                          NUMBER;         -- 주민세
    
    V_AVG_TAX_STD_AMOUNT_2                        NUMBER;         -- 년평균과세표준
    V_CHG_TAX_STD_AMOUNT_2                        NUMBER;         -- 환산과세표준<2014 추가> 
    V_CHG_COMP_TAX_AMOUNT_2                       NUMBER;         -- 환산산출세액<2014 추가>  
    V_AVG_COMP_TAX_AMOUNT_2                       NUMBER;         -- 년평균 산출세액
    V_COMP_TAX_AMOUNT_2                           NUMBER;         -- 산출세액
    V_TAX_DED_AMOUNT_2                            NUMBER;         -- 퇴직소득세액공제
    V_IN_TAX_AMOUNT_2                             NUMBER;         -- 소득세
    V_LOCAL_TAX_AMOUNT_2                          NUMBER;         -- 주민세
    
    V_H_RETIRE_DATE_FR                            DATE;           -- 명예퇴직 정산 시작일.
    V_H_RETIRE_DATE_TO                            DATE;           -- 명예퇴직 정산 종료일.
    V_H_LONG_YEAR                                 NUMBER;         -- 명예퇴직 근속년수.
    V_H_PRE_LONG_YEAR                             NUMBER;         -- 명예퇴직부터 중도정산 이전 근속년수.
    V_H_INCOME_DED_AMOUNT                         NUMBER;         -- 퇴직소득공제
    V_H_LONG_DED_YEAR_AMOUNT                      NUMBER;         -- 근속년수에 따른 소득공제    
    V_H_TAX_STD_AMOUNT                            NUMBER;         -- 과세표준
    V_H_AVG_TAX_STD_AMOUNT                        NUMBER;         -- 년평균과세표준
    V_H_AVG_COMP_TAX_AMOUNT                       NUMBER;         -- 년평균 산출세액
    V_H_COMP_TAX_AMOUNT                           NUMBER;         -- 산출세액
    V_H_TAX_DED_AMOUNT                            NUMBER;         -- 퇴직소득세액공제
    V_H_IN_TAX_AMOUNT                             NUMBER;         -- 소득세
    V_H_LOCAL_TAX_AMOUNT                          NUMBER;         -- 주민세
    V_H_REAL_AMOUNT                               NUMBER;         -- 명예퇴직금.
    
    V_REAL_TOTAL_AMOUNT                           NUMBER;         -- 실 총퇴직금.
    V_TEMP_AMOUNT                                 NUMBER;         -- 임시 변수.
    
  BEGIN
    
    --> 퇴직정산을 위한 기초 정보
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
      --> 초기화
      V_REAL_DAY := 0;                  -- 실제 근속일수
      V_RETR_AMOUNT := 0;               -- 퇴직금
      V_TOTAL_RETR_AMOUNT := 0;         -- 총퇴직금 합계
      
      V_INCOME_DED_AMOUNT := 0;         -- 퇴직소득공제
      V_LONG_DED_YEAR_AMOUNT := 0;      -- 근속년수에 따른 소득공제
      V_TAX_STD_AMOUNT := 0;            -- 과세표준      
      V_TAX_STD_AMOUNT_1 := 0;          -- 과세표준 안부 2012년 12월 31일 이전 (과세표준 / 정산근속연수 * 각 근속연수) 
      V_TAX_STD_AMOUNT_2 := 0;          -- 과세표준 안부 2013년 1월 1일 이후 (과세표준 / 정산근속연수 * 각 근속연수) 
      
      V_AVG_TAX_STD_AMOUNT_1 := 0;      -- 년평균 과세표준
      V_AVG_COMP_TAX_AMOUNT_1 := 0;     -- 년평균 산출세액
      V_COMP_TAX_AMOUNT_1 := 0;         -- 산출세액
      V_TAX_DED_AMOUNT_1 := 0;          -- 퇴직소득세액공제
      V_IN_TAX_AMOUNT_1 := 0;           -- 소득세
      V_LOCAL_TAX_AMOUNT_1 := 0;        -- 주민세
      
      V_AVG_TAX_STD_AMOUNT_2 := 0;      -- 년평균 과세표준
      V_CHG_TAX_STD_AMOUNT_2 := 0;      -- 환산 과세표준<2014 추가>  
      V_CHG_COMP_TAX_AMOUNT_2 := 0;     -- 환산 산출세액<2014 추가>  
      V_AVG_COMP_TAX_AMOUNT_2 := 0;     -- 년평균 산출세액
      V_COMP_TAX_AMOUNT_2 := 0;         -- 산출세액
      V_TAX_DED_AMOUNT_2 := 0;          -- 퇴직소득세액공제
      V_IN_TAX_AMOUNT_2 := 0;           -- 소득세
      V_LOCAL_TAX_AMOUNT_2 := 0;        -- 주민세
      
      V_REAL_AMOUNT := 0;               -- 실퇴직금
      V_REAL_TOTAL_AMOUNT                           := 0;         -- 실 
      
      --> 퇴직금 계산
      V_RETR_AMOUNT := NVL(C1.RETIRE_AMOUNT, 0);

      --> 총퇴직금
      V_TOTAL_RETR_AMOUNT := NVL(V_RETR_AMOUNT, 0) + NVL(C1.GLORY_AMOUNT, 0);

---------------------------------------------------------------------------------------------------
      --> 퇴직근로소득 산출
      V_INCOME_DED_AMOUNT := C1.INCOME_DED_AMOUNT;

      --> 근속에 따른 소득공제
      V_LONG_DED_YEAR_AMOUNT := C1.LONG_DED_AMOUNT;

      --> 과세 표준
      V_TAX_STD_AMOUNT := NVL(V_TOTAL_RETR_AMOUNT, 0) - NVL(V_INCOME_DED_AMOUNT, 0) - NVL(V_LONG_DED_YEAR_AMOUNT, 0);
      IF V_TAX_STD_AMOUNT < 0 THEN
        V_TAX_STD_AMOUNT := 0;
      END IF;
      
      --> 과세표준 안분 
      V_TAX_STD_AMOUNT_1 := TRUNC(V_TAX_STD_AMOUNT / (NVL(C1.LONG_YEAR_1, 0) + NVL(C1.LONG_YEAR_2, 0)) * NVL(C1.LONG_YEAR_1, 0));
      V_TAX_STD_AMOUNT_2 := V_TAX_STD_AMOUNT - V_TAX_STD_AMOUNT_1;
      IF V_TAX_STD_AMOUNT != V_TAX_STD_AMOUNT_1 + V_TAX_STD_AMOUNT_2 THEN
        DBMS_OUTPUT.PUT_LINE( 'Tax STD Division Amount Error : ' || SUBSTR(SQLERRM, 1, 150));       
        RETURN;
      END IF;
      
      -- 년도별 소득세 계산 --
      V_REAL_AMOUNT := NVL(V_TOTAL_RETR_AMOUNT, 0);
      IF NVL(C1.LONG_YEAR_1, 0) > 0 THEN
        -- 2102년도 까지 세액 계산 --
        BEGIN
          --> 년평균 과세표준(퇴직일자까지 근속년수 적용)  
          --> (과세표준 / (총근속년수) * 12년도까지 근속년수) / 12년도까지 근속년수  
          
          -- 12년도까지 년평균과세표준 금액 계산  
          V_AVG_TAX_STD_AMOUNT_1 := TRUNC(V_TAX_STD_AMOUNT_1 / NVL(C1.LONG_YEAR_1, 0));
        EXCEPTION 
          WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Avg Tax STD Amount Error : ' || SUBSTR(SQLERRM, 1, 150));       
            RETURN;
        END;

        --> 산출세액
        V_AVG_COMP_TAX_AMOUNT_1 := HRR_RETIRE_ADJUSTMENT_SET_G.AVG_TAX_AMOUNT_F(C1.ADJUSTMENT_YYYY, C1.SOB_ID, C1.ORG_ID, V_AVG_TAX_STD_AMOUNT_1);

        --> 산출세액
        V_COMP_TAX_AMOUNT_1 := TRUNC(V_AVG_COMP_TAX_AMOUNT_1 * C1.LONG_YEAR_1);

        --> 소득세액공제
        V_TAX_DED_AMOUNT_1 := HRR_RETIRE_ADJUSTMENT_SET_G.TAX_SUBTRACT_F(C1.ADJUSTMENT_YYYY, C1.SOB_ID, C1.ORG_ID, C1.RETIRE_DATE_TO, V_COMP_TAX_AMOUNT_1, C1.LONG_YEAR_1);

        --> 소득세
        V_IN_TAX_AMOUNT_1 := TRUNC(NVL(V_COMP_TAX_AMOUNT_1, 0) - NVL(V_TAX_DED_AMOUNT_1, 0));   -- 무조건 버림
        IF V_IN_TAX_AMOUNT_1 < 0 THEN
          V_IN_TAX_AMOUNT_1 := 0;
        END IF;

        --> 주민세
        V_LOCAL_TAX_AMOUNT_1 := TRUNC(V_IN_TAX_AMOUNT_1 * 10 / 100);   -- 무조건 버림
      END IF;
      
      IF NVL(C1.LONG_YEAR_2, 0) > 0 THEN
        -- 2103년도 부터 세액 계산 --
        BEGIN
          --> 년평균 과세표준(퇴직일자까지 근속년수 적용)  
          -- 13년도 과세표준 금액 산정 --
          --> (안분과세표준 / 근속연수)  
          V_AVG_TAX_STD_AMOUNT_2 := NVL(V_TAX_STD_AMOUNT_2, 0) / NVL(C1.LONG_YEAR_2, 0);
        EXCEPTION 
          WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Avg Tax STD Amount Error : ' || SUBSTR(SQLERRM, 1, 150));       
            RETURN;
        END;
        
        --> 환산 과세표준(연평균과세표준 * 5)  
        V_CHG_TAX_STD_AMOUNT_2 := V_AVG_TAX_STD_AMOUNT_2 * 5;
        
        --> 환산산출세액(환산과세표준 * 세율)  
        V_CHG_COMP_TAX_AMOUNT_2 := HRR_RETIRE_ADJUSTMENT_SET_G.AVG_TAX_AMOUNT_F(C1.ADJUSTMENT_YYYY, C1.SOB_ID, C1.ORG_ID, V_CHG_TAX_STD_AMOUNT_2);
        
        --> 연평균산출세액(환산산출세액 / 5)
        V_AVG_COMP_TAX_AMOUNT_2 := TRUNC(V_CHG_COMP_TAX_AMOUNT_2 / 5);

        --> 소득세액공제
        V_TAX_DED_AMOUNT_2 := HRR_RETIRE_ADJUSTMENT_SET_G.TAX_SUBTRACT_F(C1.ADJUSTMENT_YYYY, C1.SOB_ID, C1.ORG_ID, C1.RETIRE_DATE_TO, V_AVG_COMP_TAX_AMOUNT_2, C1.LONG_YEAR_2);

        --> 산출세액(연평균산출세액 * 근속연수) 
        V_COMP_TAX_AMOUNT_2 := TRUNC(V_AVG_COMP_TAX_AMOUNT_2 * C1.LONG_YEAR_2);
        
        --> 소득세
        V_IN_TAX_AMOUNT_2 := TRUNC(NVL(V_COMP_TAX_AMOUNT_2, 0) - NVL(V_TAX_DED_AMOUNT_2, 0));   -- 무조건 버림
        
        -- 2013-07-13 START OF MODIFY --
        -- 전호수 추가 : 원단위 보정(2012년/2013년 분할계산으로 인해 소득세 합계와 원단위 차액 발생) --
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
        
        --> 주민세
        V_LOCAL_TAX_AMOUNT_2 := TRUNC(V_IN_TAX_AMOUNT_2 * 10 / 100);   -- 무조건 버림
      END IF;
      
      -- 실지급액 계산 -- 
      --> 실지급액 (총퇴직금 - 주민세 - 소득세 - 기타공제 - 퇴직전환금)
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
      --> 퇴직금 적용  --
      UPDATE HRR_RETIRE_ADJUSTMENT RA
        SET RA.TAX_STD_AMOUNT         = V_TAX_STD_AMOUNT 
          , RA.TAX_STD_AMOUNT_1       = V_TAX_STD_AMOUNT_1  -- 전호수 추가 
          , RA.TAX_STD_AMOUNT_2       = V_TAX_STD_AMOUNT_2  -- 전호수 추가 
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
          
          , RA.CHG_TAX_STD_AMOUNT_2   = V_CHG_TAX_STD_AMOUNT_2  -- <2014 추가> 
          , RA.CHG_COMP_TAX_AMOUNT_2  = V_CHG_COMP_TAX_AMOUNT_2 -- <2014 추가> 
          
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
