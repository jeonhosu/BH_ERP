/*
SELECT *
  FROM HRP_MONTH_PAYMENT_TEMP MP
WHERE MP.PAY_YYYYMM = &W_PAY_YYYYMM
  AND MP.WAGE_TYPE  = &W_WAGE_TYPE
FOR UPDATE
;

-- 급상여 기존자료 삭제.
DELETE FROM HRP_MONTH_PAYMENT MP
WHERE MP.PAY_YYYYMM = &W_PAY_YYYYMM
  AND MP.WAGE_TYPE  = &W_WAGE_TYPE
;

DELETE FROM HRP_MONTH_ALLOWANCE MP
WHERE MP.PAY_YYYYMM = &W_PAY_YYYYMM
  AND MP.WAGE_TYPE  = &W_WAGE_TYPE
;

DELETE FROM HRP_MONTH_DEDUCTION MP
WHERE MP.PAY_YYYYMM = &W_PAY_YYYYMM
  AND MP.WAGE_TYPE  = &W_WAGE_TYPE
;  
  
*/


DECLARE
  V_MONTH_PAYMENT_ID              NUMBER;
  V_SYSDATE                       DATE := TO_DATE('2011-12-08 10:18:18', 'YYYY-MM-DD HH24:MI:SS');
  
  V_PAY_AMOUNT                    NUMBER;
  V_DED_AMOUNT                    NUMBER;
  V_TOT_ALL_AMOUNT                NUMBER;
  V_TOT_DED_AMOUNT                NUMBER;
  V_REAL_AMOUNT                   NUMBER;
BEGIN
  
  FOR C1 IN ( SELECT PM.PERSON_ID
                   , PM.PERSON_NUM
                   , PM.NAME
                   , PT.PAY_YYYYMM
                   , PT.WAGE_TYPE
                   , PM.CORP_ID
                   , PM.DEPT_ID
                   , PM.POST_ID
                   , PM.OCPT_ID
                   , PM.ABIL_ID
                   , PM.JOB_CATEGORY_ID
                   , PT.PAY_TYPE
                   , PM.PAY_GRADE_ID
                   , NULL AS GRADE_STEP
                   , PM.COST_CENTER_ID 
                   , PM.DIR_INDIR_TYPE
                   , PM.EMPLOYE_TYPE
                   , CASE
                       WHEN TO_CHAR(PM.RETIRE_DATE, 'YYYY-MM') = PT.PAY_YYYYMM THEN 'R'
                       WHEN TO_CHAR(PM.ORI_JOIN_DATE, 'YYYY-MM') = PT.PAY_YYYYMM THEN 'I'
                       ELSE 'N'
                     END AS EXCEPT_TYPE
                   , DECODE(PM.PERSON_NUM, 'B01003', 'N', 'Y') AS HIRE_INSUR_YN
                   , ADD_MONTHS(TO_DATE(PT.PAY_YYYYMM || '-15', 'YYYY-MM-DD'), 1) AS SUPPLY_DATE
                   , LAST_DAY(TO_DATE(PT.PAY_YYYYMM || '-15', 'YYYY-MM-DD')) AS STD_DATE
                   , HRM_COMMON_DATE_G.YEAR_COUNT_F(PM.ORI_JOIN_DATE, LAST_DAY(TO_DATE(PT.PAY_YYYYMM || '-01', 'YYYY-MM-DD')), 'TRUNC') AS LONG_YEAR
                   , HRM_COMMON_DATE_G.PERIOD_MONTH_F(PM.ORI_JOIN_DATE, LAST_DAY(TO_DATE(PT.PAY_YYYYMM || '-01', 'YYYY-MM-DD')), 1, 0) AS LONG_MONTH
                   , HRP_PAYMENT_G_SET.GENERAL_HOURLY_PAY_AMOUNT_F(PT.PAY_YYYYMM, PM.PERSON_ID, PM.SOB_ID, PM.ORG_ID) AS GENERAL_HOURLY_AMOUNT
                   , LAST_DAY(TO_DATE(PT.PAY_YYYYMM || '-01', 'YYYY-MM-DD')) - TO_DATE(PT.PAY_YYYYMM || '-01', 'YYYY-MM-DD') AS PAY_DAY
                   , 50 AS PAY_RATE
                   , 1 AS DED_PERSON_COUNT
                   , CASE
                       WHEN PT.WAGE_TYPE IN ('P2', 'P3','P5') THEN 0
                       ELSE PT.TOT_SUPPLY_AMOUNT
                     END AS PAY_AMOUNT
                   , CASE
                       WHEN PT.WAGE_TYPE IN ('P2', 'P3','P5') THEN 0
                       ELSE PT.TOT_DED_AMOUNT
                     END AS DED_PAY_AMOUNT
                   , CASE
                       WHEN PT.WAGE_TYPE IN ('P2', 'P3','P5') THEN PT.TOT_SUPPLY_AMOUNT
                       ELSE 0
                     END AS BONUS_AMOUNT
                   , CASE
                       WHEN PT.WAGE_TYPE IN ('P2', 'P3','P5') THEN PT.TOT_DED_AMOUNT
                       ELSE 0
                     END AS DED_BONUS_AMOUNT
                   , PT.TOT_SUPPLY_AMOUNT 
                   , PT.TOT_DED_AMOUNT
                   , PT.REAL_AMOUNT
                   , A01, A02, A03, A04, A05
                   , A06, A07, A08, A09, A10
                   , A11, A12, A13, A14, A15
                   , A16, A17, A18, A19, A20
                   , A21, A22, A23, A24, A25
                   , A26, A27, A28, A29, A30
                   , A31, A32, A33, A34, A35
                   , D01, D02, D03, D04, D05
                   , D06, D07, D08, D09, D10
                   , D11, D12, D13, D14, D15
                   , D16, D17, D18, D19, D20
                   , D21, D22, D23, D24, D25
                   , NULL AS DESCRIPTION
                   , PM.SOB_ID, PM.ORG_ID
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT_TEMP PT
                  , ( SELECT PMH.PERSON_ID
                           , PMH.PAY_TYPE
                           , PMH.PAY_GRADE_ID
                           , PMH.HIRE_INSUR_YN
                        FROM HRP_PAY_MASTER_HEADER PMH
                      WHERE PMH.CORP_ID           = &W_CORP_ID
                        AND PMH.START_YYYYMM      <= '2011-09'
                        AND PMH.END_YYYYMM        >= '2011-09'
                        AND PMH.SOB_ID            = &W_SOB_ID
                        AND PMH.ORG_ID            = &W_ORG_ID
                    ) SX1
              WHERE PM.PERSON_NUM               = PT.PERSON_NUM
                AND PM.PERSON_ID                = SX1.PERSON_ID(+)
                AND PM.SOB_ID                   = &W_SOB_ID
                AND PM.ORG_ID                   = &W_ORG_ID
                AND PM.CORP_ID                  = &W_CORP_ID
                AND PT.WAGE_TYPE                = &W_WAGE_TYPE
                AND PT.PAY_YYYYMM               = &W_PAY_YYYYMM
              ORDER BY PT.PAY_YYYYMM, PT.WAGE_TYPE, PM.PERSON_NUM
             )
  LOOP    
    -- MONTH_PAYMENT_ID 채번 --
    BEGIN
      SELECT MP.MONTH_PAYMENT_ID
        INTO V_MONTH_PAYMENT_ID
        FROM HRP_MONTH_PAYMENT MP
      WHERE MP.PERSON_ID          = C1.PERSON_ID
        AND MP.PAY_YYYYMM         = C1.PAY_YYYYMM
        AND MP.WAGE_TYPE          = C1.WAGE_TYPE
        AND MP.CORP_ID            = C1.CORP_ID
        AND MP.SOB_ID             = C1.SOB_ID
        AND MP.ORG_ID             = C1.ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_MONTH_PAYMENT_ID := -1;
    END;
    DBMS_OUTPUT.PUT_LINE('NAME : ' || C1.NAME || '(' || C1.PERSON_ID || '), MONTH ID : ' || V_MONTH_PAYMENT_ID);
    -- 지급/공제 합계 저장.
    IF V_MONTH_PAYMENT_ID = -1 THEN
      SELECT HRP_MONTH_PAYMENT_S1.NEXTVAL
        INTO V_MONTH_PAYMENT_ID
        FROM DUAL;
                      
      BEGIN
        INSERT INTO HRP_MONTH_PAYMENT
        ( MONTH_PAYMENT_ID
        , PERSON_ID 
        , PAY_YYYYMM 
        , WAGE_TYPE 
        , CORP_ID 
        , DEPT_ID 
        , POST_ID 
        , OCPT_ID 
        , ABIL_ID 
        , JOB_CATEGORY_ID 
        , PAY_TYPE 
        , PAY_GRADE_ID 
        , GRADE_STEP 
        , COST_CENTER_ID 
        , DIR_INDIR_TYPE 
        , EMPLOYE_TYPE 
        , EXCEPT_TYPE 
        , HIRE_INSUR_YN
        , SUPPLY_DATE 
        , STANDARD_DATE 
        , LONG_YEAR
        , LONG_MONTH
        , PAY_DAY
        , DED_PERSON_COUNT
        , SOB_ID 
        , ORG_ID 
        , CREATION_DATE 
        , CREATED_BY 
        , LAST_UPDATE_DATE 
        , LAST_UPDATED_BY 
        ) VALUES
        ( V_MONTH_PAYMENT_ID
        , C1.PERSON_ID 
        , C1.PAY_YYYYMM
        , C1.WAGE_TYPE
        , C1.CORP_ID
        , C1.DEPT_ID 
        , C1.POST_ID
        , C1.OCPT_ID
        , C1.ABIL_ID
        , C1.JOB_CATEGORY_ID
        , C1.PAY_TYPE
        , C1.PAY_GRADE_ID
        , C1.GRADE_STEP
        , C1.COST_CENTER_ID
        , C1.DIR_INDIR_TYPE
        , C1.EMPLOYE_TYPE
        , C1.EXCEPT_TYPE
        , C1.HIRE_INSUR_YN
        , C1.SUPPLY_DATE
        , C1.STD_DATE
        , C1.LONG_YEAR
        , C1.LONG_MONTH
        , C1.PAY_DAY
        , NVL(C1.DED_PERSON_COUNT, 0)
        , C1.SOB_ID
        , C1.ORG_ID
        , V_SYSDATE
        , -1
        , V_SYSDATE
        , -1
        );
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('MONTH PAYMENT INSERT ERROR : ' || SQLERRM);
      END;
    ELSE
      BEGIN
        UPDATE HRP_MONTH_PAYMENT MP
          SET DEPT_ID            = C1.DEPT_ID
            , POST_ID            = C1.POST_ID
            , OCPT_ID            = C1.OCPT_ID            
            , ABIL_ID            = C1.ABIL_ID
            , JOB_CATEGORY_ID    = C1.JOB_CATEGORY_ID
            , PAY_TYPE           = C1.PAY_TYPE
            , PAY_GRADE_ID       = C1.PAY_GRADE_ID
            , GRADE_STEP         = C1.GRADE_STEP
            , COST_CENTER_ID     = C1.COST_CENTER_ID
            , DIR_INDIR_TYPE     = C1.DIR_INDIR_TYPE
            , EMPLOYE_TYPE       = C1.EMPLOYE_TYPE
            , EXCEPT_TYPE        = C1.EXCEPT_TYPE
            , HIRE_INSUR_YN      = C1.HIRE_INSUR_YN
            , SUPPLY_DATE        = C1.SUPPLY_DATE
            , STANDARD_DATE      = C1.STD_DATE
            , LONG_YEAR          = C1.LONG_YEAR
            , LONG_MONTH         = C1.LONG_MONTH
            , PAY_DAY            = C1.PAY_DAY
            , DED_PERSON_COUNT   = C1.DED_PERSON_COUNT
        WHERE MP.MONTH_PAYMENT_ID = V_MONTH_PAYMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('MONTH PAYMENT UPDATE ERROR : ' || SQLERRM);
      END;
    END IF;
    
    -- A01 - ALLOWANCE INSERT.
    IF NVL(C1.A01, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A01''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A01, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A02 - ALLOWANCE INSERT.
    IF NVL(C1.A02, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A02''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A02, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A03 - ALLOWANCE INSERT.
    IF NVL(C1.A03, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A03''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A03, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A04 - ALLOWANCE INSERT.
    IF NVL(C1.A04, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A04''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A04, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A05 - ALLOWANCE INSERT.
    IF NVL(C1.A05, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A05''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A05, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A06 - ALLOWANCE INSERT.
    IF NVL(C1.A06, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A06''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A06, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A07 - ALLOWANCE INSERT.
    IF NVL(C1.A07, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A07''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A07, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A08 - ALLOWANCE INSERT.
    IF NVL(C1.A08, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A08''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A08, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A09 - ALLOWANCE INSERT.
    IF NVL(C1.A09, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A09''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A09, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A10 - ALLOWANCE INSERT.
    IF NVL(C1.A10, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A10''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A10, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A11 - ALLOWANCE INSERT.
    IF NVL(C1.A11, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A11''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A11, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A12 - ALLOWANCE INSERT.
    IF NVL(C1.A12, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A12''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A12, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A13 - ALLOWANCE INSERT.
    IF NVL(C1.A13, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A13''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A13, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A14 - ALLOWANCE INSERT.
    IF NVL(C1.A14, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A14''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A14, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A15 - ALLOWANCE INSERT.
    IF NVL(C1.A15, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A15''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A15, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A16 - ALLOWANCE INSERT.
    IF NVL(C1.A16, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A16''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A16, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A17 - ALLOWANCE INSERT.
    IF NVL(C1.A17, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A17''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A17, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A18 - ALLOWANCE INSERT.
    IF NVL(C1.A18, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A18''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A18, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A19 - ALLOWANCE INSERT.
    IF NVL(C1.A19, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A19''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A19, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A20 - ALLOWANCE INSERT.
    IF NVL(C1.A20, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A20''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A20, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A21 - ALLOWANCE INSERT.
    IF NVL(C1.A21, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A21''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A21, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A22 - ALLOWANCE INSERT.
    IF NVL(C1.A22, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A22''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A22, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A23 - ALLOWANCE INSERT.
    IF NVL(C1.A23, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A23''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A23, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A24 - ALLOWANCE INSERT.
    IF NVL(C1.A24, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A24''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A24, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A25 - ALLOWANCE INSERT.
    IF NVL(C1.A25, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A25''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A25, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A26 - ALLOWANCE INSERT.
    IF NVL(C1.A26, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A26''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A26, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A27 - ALLOWANCE INSERT.
    IF NVL(C1.A27, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A27''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A27, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A28 - ALLOWANCE INSERT.
    IF NVL(C1.A28, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A28''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A28, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A29 - ALLOWANCE INSERT.
    IF NVL(C1.A29, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A29''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A29, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A30 - ALLOWANCE INSERT.
    IF NVL(C1.A30, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A30''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A30, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A31 - ALLOWANCE INSERT.
    IF NVL(C1.A31, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A31''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A31, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A32 - ALLOWANCE INSERT.
    IF NVL(C1.A32, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A32''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A32, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A33 - ALLOWANCE INSERT.
    IF NVL(C1.A33, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A33''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A33, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A34 - ALLOWANCE INSERT.
    IF NVL(C1.A34, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A34''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A34, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- A35 - ALLOWANCE INSERT.
    IF NVL(C1.A35, 0) <> 0 THEN
      HRP_PAYMENT_ALLOWANCE_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_ALLOWANCE_ID      => HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'CODE = ''A35''', C1.SOB_ID, C1.ORG_ID)
            , P_ALLOWANCE_AMOUNT  => NVL(C1.A35, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- 공제.
    -- D01 - DEDUCTION INSERT.
    IF NVL(C1.D01, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D01''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D01, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D02 - DEDUCTION INSERT.
    IF NVL(C1.D02, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D02''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D02, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D03 - DEDUCTION INSERT.
    IF NVL(C1.D03, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D03''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D03, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D04 - DEDUCTION INSERT.
    IF NVL(C1.D04, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D04''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D04, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D05 - DEDUCTION INSERT.
    IF NVL(C1.D05, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D05''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D05, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D06 - DEDUCTION INSERT.
    IF NVL(C1.D06, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D06''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D06, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D07 - DEDUCTION INSERT.
    IF NVL(C1.D07, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D07''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D07, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D08 - DEDUCTION INSERT.
    IF NVL(C1.D08, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D08''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D08, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D09 - DEDUCTION INSERT.
    IF NVL(C1.D09, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D09''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D09, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D10 - DEDUCTION INSERT.
    IF NVL(C1.D10, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D10''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D10, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D11 - DEDUCTION INSERT.
    IF NVL(C1.D11, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D11''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D11, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D12 - DEDUCTION INSERT.
    IF NVL(C1.D12, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D12''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D12, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D13 - DEDUCTION INSERT.
    IF NVL(C1.D13, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D13''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D13, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D14 - DEDUCTION INSERT.
    IF NVL(C1.D14, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D14''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D14, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D15 - DEDUCTION INSERT.
    IF NVL(C1.D15, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D15''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D15, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D16 - DEDUCTION INSERT.
    IF NVL(C1.D16, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D16''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D16, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D17 - DEDUCTION INSERT.
    IF NVL(C1.D17, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D17''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D17, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D18 - DEDUCTION INSERT.
    IF NVL(C1.D18, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D18''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D18, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D19 - DEDUCTION INSERT.
    IF NVL(C1.D19, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D19''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D19, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D20 - DEDUCTION INSERT.
    IF NVL(C1.D20, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D20''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D20, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D21 - DEDUCTION INSERT.
    IF NVL(C1.D21, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D21''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D21, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D22 - DEDUCTION INSERT.
    IF NVL(C1.D22, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D22''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D22, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D23 - DEDUCTION INSERT.
    IF NVL(C1.D23, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D23''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D23, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D24 - DEDUCTION INSERT.
    IF NVL(C1.D24, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D24''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D24, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    -- D25 - DEDUCTION INSERT.
    IF NVL(C1.D25, 0) <> 0 THEN
      HRP_PAYMENT_DEDUCTION_INSERT
            ( P_PERSON_ID         => C1.PERSON_ID
            , P_PAY_YYYYMM        => C1.PAY_YYYYMM
            , P_WAGE_TYPE         => C1.WAGE_TYPE
            , P_CORP_ID           => C1.CORP_ID
            , P_DEDUCTION_ID      => HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D25''', C1.SOB_ID, C1.ORG_ID)
            , P_DEDUCTION_AMOUNT  => NVL(C1.D25, 0)
            , P_MONTH_PAYMENT_ID  => V_MONTH_PAYMENT_ID
            , P_SOB_ID            => C1.SOB_ID
            , P_ORG_ID            => C1.ORG_ID
            , P_USER_ID           => -1
            , P_SYSDATE           => V_SYSDATE
            );
    END IF;
    
    V_PAY_AMOUNT := 0;
    V_TOT_ALL_AMOUNT := 0;
    V_TOT_DED_AMOUNT := 0;
    V_REAL_AMOUNT := 0;
    -- 지급 항목 합계 UPDATE --
    IF C1.WAGE_TYPE IN ('P2', 'P3', 'P5') THEN
    -- 상여.
      -- 지급 항목 합계 UPDATE --
      BEGIN
        SELECT NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS PAY_AMOUNT
             , NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS TOTAL_SUPPLY_AMOUNT
          INTO V_PAY_AMOUNT
             , V_TOT_ALL_AMOUNT
          FROM HRP_MONTH_ALLOWANCE MA
         WHERE MA.MONTH_PAYMENT_ID        = V_MONTH_PAYMENT_ID
        GROUP BY MA.MONTH_PAYMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_PAY_AMOUNT := 0;
        V_TOT_ALL_AMOUNT := 0;
      END;
      UPDATE HRP_MONTH_PAYMENT MP
        SET MP.BONUS_AMOUNT       = NVL(V_PAY_AMOUNT, 0)
          , MP.TOT_SUPPLY_AMOUNT  = NVL(V_TOT_ALL_AMOUNT, 0)
          , MP.REAL_AMOUNT        = NVL(V_TOT_ALL_AMOUNT, 0)
      WHERE MP.MONTH_PAYMENT_ID   = V_MONTH_PAYMENT_ID
      ;
        
      -- 공제 항목 합계 UPDATE --
      BEGIN
        SELECT NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS DED_PAY_AMOUNT
             , NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS TOTAL_DED_AMOUNT
          INTO V_DED_AMOUNT
             , V_TOT_DED_AMOUNT
          FROM HRP_MONTH_DEDUCTION MD
         WHERE MD.MONTH_PAYMENT_ID        = V_MONTH_PAYMENT_ID
        GROUP BY MD.MONTH_PAYMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_DED_AMOUNT := 0;
        V_TOT_DED_AMOUNT := 0;
      END;
      
      UPDATE HRP_MONTH_PAYMENT MP
        SET MP.DED_BONUS_AMOUNT           = NVL(V_DED_AMOUNT, 0)
          , MP.TOT_DED_AMOUNT             = NVL(V_TOT_DED_AMOUNT, 0)
          , MP.REAL_AMOUNT                = NVL(MP.TOT_SUPPLY_AMOUNT, 0) - NVL(V_TOT_DED_AMOUNT, 0)        
      WHERE MP.MONTH_PAYMENT_ID   = V_MONTH_PAYMENT_ID
      ;
    ELSE      
      BEGIN
        SELECT NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS PAY_AMOUNT
             , NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS TOTAL_SUPPLY_AMOUNT
          INTO V_PAY_AMOUNT
             , V_TOT_ALL_AMOUNT
          FROM HRP_MONTH_ALLOWANCE MA
         WHERE MA.MONTH_PAYMENT_ID        = V_MONTH_PAYMENT_ID
        GROUP BY MA.MONTH_PAYMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_PAY_AMOUNT := 0;
        V_TOT_ALL_AMOUNT := 0;
      END;
      UPDATE HRP_MONTH_PAYMENT MP
        SET MP.PAY_AMOUNT         = NVL(V_PAY_AMOUNT, 0)
          , MP.TOT_SUPPLY_AMOUNT  = NVL(V_TOT_ALL_AMOUNT, 0)
          , MP.REAL_AMOUNT        = NVL(V_TOT_ALL_AMOUNT, 0)
      WHERE MP.MONTH_PAYMENT_ID   = V_MONTH_PAYMENT_ID
      ;
        
      -- 공제 항목 합계 UPDATE --
      BEGIN
        SELECT NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS DED_PAY_AMOUNT
             , NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS TOTAL_DED_AMOUNT
          INTO V_DED_AMOUNT
             , V_TOT_DED_AMOUNT
          FROM HRP_MONTH_DEDUCTION MD
         WHERE MD.MONTH_PAYMENT_ID        = V_MONTH_PAYMENT_ID
        GROUP BY MD.MONTH_PAYMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_DED_AMOUNT := 0;
        V_TOT_DED_AMOUNT := 0;
      END;
      
      UPDATE HRP_MONTH_PAYMENT MP
        SET MP.DED_PAY_AMOUNT             = NVL(V_DED_AMOUNT, 0)
          , MP.TOT_DED_AMOUNT             = NVL(V_TOT_DED_AMOUNT, 0)
          , MP.REAL_AMOUNT                = NVL(MP.TOT_SUPPLY_AMOUNT, 0) - NVL(V_TOT_DED_AMOUNT, 0)        
      WHERE MP.MONTH_PAYMENT_ID   = V_MONTH_PAYMENT_ID
      ;
    END IF;
  END LOOP C1;

END;

/*
-- 지급내역 조회.
SELECT *
  FROM HRP_MONTH_PAYMENT MP
    , HRM_PERSON_MASTER PM
WHERE MP.PERSON_ID      = PM.PERSON_ID
  AND MP.PAY_YYYYMM     = &W_PAY_YYYYMM
  AND MP.WAGE_TYPE      = &W_WAGE_TYPE
;
  
SELECT MAX(MP.MONTH_PAYMENT_ID)
  FROM HRP_MONTH_PAYMENT MP
WHERE MP.PAY_YYYYMM < '2011-08'
  AND MP.SOB_ID     = 20
  AND MP.ORG_ID     = 201
;
 
SELECT PM.NAME       
           , PM.PERSON_NUM AS PERSON_NUM
           , MP.PAY_YYYYMM
           , MP.WAGE_TYPE
           , HRM_COMMON_G.CODE_NAME_F('CLOSING_TYPE', MP.WAGE_TYPE, MP.SOB_ID, MP.ORG_ID) AS WAGE_TYPE_NAME           
           , DM.DEPT_CODE AS DEPT_CODE
           , DM.DEPT_NAME AS DEPT_NAME
           , HRM_COMMON_G.ID_NAME_F(MP.POST_ID) AS POST_NAME
           , MP.PAY_TYPE
           , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', MP.PAY_TYPE, MP.SOB_ID, MP.ORG_ID) AS PAY_TYPE_NAME
           , HRM_COMMON_G.ID_NAME_F(MP.PAY_GRADE_ID) AS PAY_GRADE_NAME
           , TO_CHAR(PM.ORI_JOIN_DATE, 'YYYY-MM-DD') AS ORI_JOIN_DATE
           , TO_CHAR(PM.JOIN_DATE, 'YYYY-MM-DD') AS JOIN_DATE
           , TO_CHAR(PM.PAY_DATE, 'YYYY-MM-DD') AS PAY_DATE
           , TO_CHAR(PM.RETIRE_DATE, 'YYYY-MM-DD') AS RETIRE_DATE
           , MP.DIR_INDIR_TYPE
           , TO_CHAR(MP.SUPPLY_DATE, 'YYYY-MM-DD') AS SUPPLY_DATE
           , TO_CHAR(MP.STANDARD_DATE, 'YYYY-MM-DD') AS STANDARD_DATE
           , TO_CHAR(MP.PAY_RATE) AS PAY_RATE
           , TO_CHAR(MP.GRADE_STEP) AS GRADE_STEP
           , TO_CHAR(MP.LONG_YEAR) AS LONG_YEAR
           , (MA.A01) AS A01               -- ????.
           , (MA.A02) AS A02
           , (MA.A03) AS A03
           , (MA.A04) AS A04
           , (MA.A05) AS A05
           , (MA.A06) AS A06
           , (MA.A07) AS A07
           , (MA.A08) AS A08
           , (MA.A09) AS A09
           , (MA.A10) AS A10
           , (MA.A11) AS A11
           , (MA.A12) AS A12
           , (MA.A13) AS A13
           , (MA.A14) AS A14
           , (MA.A15) AS A15
           , (MA.A16) AS A16
           , (MA.A17) AS A17
           , (MA.A18) AS A18
           , (MA.A19) AS A19
           , (MA.A20) AS A20
           , (MA.A21) AS A21
           , (MA.A22) AS A22
           , (MA.A23) AS A23
           , (MA.A24) AS A24
           , (MA.A25) AS A25
           , (MA.A26) AS A26
           , (MA.A27) AS A27
           , (MA.A28) AS A28
           , (MA.A29) AS A29
           , (MA.A30) AS A30
           , (MA.A31) AS A31
           , (MA.A32) AS A32
           , (MA.A33) AS A33
           , (MA.A34) AS A34
           , (MA.A35) AS A35
           , (MA.A36) AS A36
           , (MA.A37) AS A37
           , (MA.A38) AS A38
           , (MA.A39) AS A39
           , (MP.TOT_SUPPLY_AMOUNT) AS TOT_SUPPLY_AMOUNT
           , (MD.D01) AS D01                -- ?? ??.
           , (MD.D02) AS D02
           , (MD.D03) AS D03
           , (MD.D04) AS D04
           , (MD.D05) AS D05
           , (MD.D06) AS D06
           , (MD.D07) AS D07
           , (MD.D08) AS D08
           , (MD.D09) AS D09
           , (MD.D10) AS D10
           , (MD.D11) AS D11
           , (MD.D12) AS D12
           , (MD.D13) AS D13
           , (MD.D14) AS D14
           , (MD.D15) AS D15
           , (MD.D16) AS D16
           , (MD.D17) AS D17
           , (MD.D18) AS D18
           , (MD.D19) AS D19
           , (MD.D20) AS D20
           , (MD.D21) AS D21
           , (MD.D22) AS D22
           , (MD.D23) AS D23
           , (MD.D24) AS D24
           , (MD.D25) AS D25
           , (MD.D26) AS D26
           , (MD.D27) AS D27
           , (MD.D28) AS D28
           , (MD.D29) AS D29
           , (MP.TOT_DED_AMOUNT) AS TOT_DED_AMOUNT 
           , (MP.REAL_AMOUNT) AS REAL_AMOUNT
        FROM HRP_MONTH_PAYMENT MP
          , HRM_DEPT_MASTER DM
          , HRM_PERSON_MASTER PM
          , HRP_MONTH_ALLOWANCE_V MA
          , HRP_MONTH_DEDUCTION_V MD
       WHERE MP.DEPT_ID                 = DM.DEPT_ID
         AND MP.PERSON_ID               = PM.PERSON_ID
         AND MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID(+)
         AND MP.MONTH_PAYMENT_ID        = MD.MONTH_PAYMENT_ID(+)
--         AND MP.PERSON_ID               = NVL(&W_PERSON_ID, MP.PERSON_ID)
         AND MP.PAY_YYYYMM              = &W_PAY_YYYYMM
         AND MP.WAGE_TYPE               = NVL(&W_WAGE_TYPE, MP.WAGE_TYPE)
--         AND MP.CORP_ID                 = &W_CORP_ID
--         AND MP.DEPT_ID                 = NVL(&W_DEPT_ID, MP.DEPT_ID)
--       AND MP.PAY_GRADE_ID            = NVL(&W_PAY_GRADE_ID, MP.PAY_GRADE_ID)
         AND MP.SOB_ID                  = &W_SOB_ID
         AND MP.ORG_ID                  = &W_ORG_ID 
      ;


  SELECT *
    FROM HRP_MONTH_PAYMENT MP
  WHERE MP.PAY_YYYYMM      = '2011-04'
    AND MP.WAGE_TYPE       = 'P2'
    ;      
    */

