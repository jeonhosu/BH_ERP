CREATE OR REPLACE PACKAGE HRR_RETIRE_RESERVE_G
AS

-- �������� ��ȸ.
  PROCEDURE SELECT_RETIRE_RESERVE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN HRR_RETIRE_RESERVE.CORP_ID%TYPE
            , W_RESERVE_YYYYMM    IN HRR_RETIRE_RESERVE.RESERVE_YYYYMM%TYPE
            , W_DEPT_ID           IN HRR_RETIRE_RESERVE.DEPT_ID%TYPE
            , W_PERSON_ID         IN HRR_RETIRE_RESERVE.PERSON_ID%TYPE
            , W_SOB_ID            IN HRR_RETIRE_RESERVE.SOB_ID%TYPE
            , W_ORG_ID            IN HRR_RETIRE_RESERVE.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- �������� ����.
  PROCEDURE SET_RETIRE_RESERVE
            ( W_CORP_ID           IN HRR_RETIRE_RESERVE.CORP_ID%TYPE
            , W_RESERVE_YYYYMM    IN HRR_RETIRE_RESERVE.RESERVE_YYYYMM%TYPE
            , W_DEPT_ID           IN HRR_RETIRE_RESERVE.DEPT_ID%TYPE
            , W_PERSON_ID         IN HRR_RETIRE_RESERVE.PERSON_ID%TYPE
            , W_SOB_ID            IN HRR_RETIRE_RESERVE.SOB_ID%TYPE
            , W_ORG_ID            IN HRR_RETIRE_RESERVE.ORG_ID%TYPE
            , P_USER_ID           IN HRR_RETIRE_RESERVE.CREATED_BY%TYPE
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );
            
END HRR_RETIRE_RESERVE_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRR_RETIRE_RESERVE_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRR_RETIRE_RESERVE_G
/* DESCRIPTION  : ������������ ����.
/* REFERENCE BY :
/* PROGRAM HISTORY : �ű� ����
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- �������� ��ȸ.
  PROCEDURE SELECT_RETIRE_RESERVE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN HRR_RETIRE_RESERVE.CORP_ID%TYPE
            , W_RESERVE_YYYYMM    IN HRR_RETIRE_RESERVE.RESERVE_YYYYMM%TYPE
            , W_DEPT_ID           IN HRR_RETIRE_RESERVE.DEPT_ID%TYPE
            , W_PERSON_ID         IN HRR_RETIRE_RESERVE.PERSON_ID%TYPE
            , W_SOB_ID            IN HRR_RETIRE_RESERVE.SOB_ID%TYPE
            , W_ORG_ID            IN HRR_RETIRE_RESERVE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT DECODE(GROUPING(RR.RESERVE_YYYYMM), 1, 'Total', RR.RESERVE_YYYYMM) AS RESERVE_YYYYMM
           , DECODE(GROUPING(RR.RESERVE_YYYYMM), 1, TO_CHAR(COUNT(PM.PERSON_ID), 'FM999,999') || ' Person', PM.DISPLAY_NAME) AS DISPLAY_NAME
           , COUNT(PM.PERSON_ID) AS PERSON_COUNT
           , NVL(RR.DEPT_ID, NULL) AS DEPT_ID
           , HRM_DEPT_MASTER_G.DEPT_NAME_F(RR.DEPT_ID) AS DEPT_NAME
           , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
           , NVL(NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE), NULL) AS JOIN_DATE
           , NVL(PM.EXPIRE_DATE, NULL) AS EXPIRE_DATE
           , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE
           , NVL(RR.START_DATE, NULL) AS START_DATE
           , NVL(RR.END_DATE, NULL) AS END_DATE
           , NVL(RR.COST_CENTER_ID, NULL) AS COST_CENTER_CODE
           , '' AS COST_CENTER_NAME
           , SUM(RR.PREVIOUS_RETIRE_AMOUNT) AS PREVIOUS_RETIRE_AMOUNT
           , SUM(RR.THIS_RETIRE_AMOUNT) AS THIS_RETIRE_AMOUNT
           , SUM(RR.GAP_RETIRE_AMOUNT) AS GAP_RETIRE_AMOUNT
           , NVL(RR.TOTAL_PAY_AMOUNT, NULL) AS TOTAL_PAY_AMOUNT
           , NVL(RR.TOTAL_BONUS_AMOUNT, NULL) AS TOTAL_BONUS_AMOUNT
           , NVL(RR.YEAR_ALLOWANCE_AMOUNT, NULL) AS YEAR_ALLOWANCE_AMOUNT
           , NVL(RR.DAY_3RD_COUNT, NULL) AS DAY_3RD_COUNT
           , NVL(RR.DAY_AVG_AMOUNT, NULL) AS DAY_AVG_AMOUNT
           , NVL(RR.LONG_YEAR, NULL) AS LONG_YEAR
           , NVL(RR.LONG_DAY, NULL) AS LONG_DAY
           , NVL(RR.RETIRE_AMOUNT, NULL) AS RETIRE_AMOUNT
        FROM HRR_RETIRE_RESERVE RR
           , HRM_PERSON_MASTER PM
       WHERE RR.PERSON_ID               = PM.PERSON_ID
         AND RR.RESERVE_YYYYMM          = W_RESERVE_YYYYMM
         AND RR.CORP_ID                 = W_CORP_ID
         AND RR.SOB_ID                  = W_SOB_ID
         AND RR.ORG_ID                  = W_ORG_ID
         AND RR.PERSON_ID               = NVL(W_PERSON_ID, RR.PERSON_ID)
         AND RR.DEPT_ID                 = NVL(W_DEPT_ID, RR.DEPT_ID)
      GROUP BY ROLLUP((RR.RESERVE_YYYYMM
           , PM.DISPLAY_NAME
           , RR.DEPT_ID
           , HRM_DEPT_MASTER_G.DEPT_NAME_F(RR.DEPT_ID)
           , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID)
           , NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE)
           , PM.EXPIRE_DATE
           , PM.RETIRE_DATE
           , RR.START_DATE
           , RR.END_DATE
           , RR.COST_CENTER_ID
           , RR.TOTAL_PAY_AMOUNT
           , RR.TOTAL_BONUS_AMOUNT
           , RR.YEAR_ALLOWANCE_AMOUNT
           , RR.DAY_3RD_COUNT
           , RR.DAY_AVG_AMOUNT
           , RR.LONG_YEAR
           , RR.LONG_DAY     
           , RR.RETIRE_AMOUNT))
      ORDER BY RR.DEPT_ID, PM.DISPLAY_NAME
      ;

  END SELECT_RETIRE_RESERVE;

---------------------------------------------------------------------------------------------------
-- �������� ����.
  PROCEDURE SET_RETIRE_RESERVE
            ( W_CORP_ID           IN HRR_RETIRE_RESERVE.CORP_ID%TYPE
            , W_RESERVE_YYYYMM    IN HRR_RETIRE_RESERVE.RESERVE_YYYYMM%TYPE
            , W_DEPT_ID           IN HRR_RETIRE_RESERVE.DEPT_ID%TYPE
            , W_PERSON_ID         IN HRR_RETIRE_RESERVE.PERSON_ID%TYPE
            , W_SOB_ID            IN HRR_RETIRE_RESERVE.SOB_ID%TYPE
            , W_ORG_ID            IN HRR_RETIRE_RESERVE.ORG_ID%TYPE
            , P_USER_ID           IN HRR_RETIRE_RESERVE.CREATED_BY%TYPE
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE                     DATE  := GET_LOCAL_DATE(W_SOB_ID);
    V_PRE_YEAR_DATE               DATE;             -- ó�� ���� 1�� ���� ����(��� ���� ����).
    V_RETR_START_DATE             DATE;             -- ���� ��������;
    V_RETR_END_DATE               DATE;             -- ���� ��������;
    V_NEW_END_DATE                DATE;             -- ������ ��������.
    
    V_STD_DATE                    DATE;             -- ó�� ��������.
    V_STD_CALCULATE_MONTH         NUMBER;           -- ó�� ��� ���� ����.
    V_STD_MONTH                   NUMBER;           -- ���ؿ���.
    V_STD_PAY_MONTH               NUMBER;           -- ���� �޿�����.
    V_STD_BONUS_MONTH             NUMBER;           -- ���� �� ����.
    V_STD_MONTH_DAY               NUMBER;           -- ���� ���ϼ�.
    V_STD_YEAR_DAY                NUMBER;           -- ���� ���ϼ�. 
   
    V_PRE_PAY_YYYYMM              VARCHAR2(7);      -- ���� ó�� ���� ����.
    V_STR_PAY_YYYYMM              VARCHAR2(7);      -- �޿� ���۳��.
    V_STR_BONUS_YYYYMM            VARCHAR2(7);      -- �� ���۳��.

    V_TOTAL_AMOUNT                NUMBER;           -- ���հ�ݾ�;
    V_TOTAL_PAY_AMOUNT            NUMBER;           -- �޿��հ�;
    V_TOTAL_BONUS_AMOUNT          NUMBER;           -- �󿩱����հ�;
    V_YEAR_ALOWANCE_AMOUNT        NUMBER;           -- ����;
    V_DAY_AVG_AMOUNT              NUMBER;           -- ����վ�;
    
    V_3RD_DAY                     NUMBER;           -- 3���� ����ϼ�;
    V_LONG_YEAR                   NUMBER;           -- �ټӳ��;
    V_LONG_MONTH                  NUMBER;           -- �ټӿ���;
    V_LONG_DAY                    NUMBER;           -- �����ϼ�;
  
    V_RETIRE_AMOUNT               NUMBER;           -- �����;
    
  BEGIN
    O_STATUS := 'F';
--> ó�� �������� ����.
    V_STD_DATE := LAST_DAY(TO_DATE(W_RESERVE_YYYYMM, 'YYYY-MM'));
    
--> �ش� ����� ���� �ڷ� ����;
    BEGIN
      DELETE FROM HRR_RETIRE_RESERVE RR
      WHERE RR.CORP_ID          = W_CORP_ID
        AND RR.RESERVE_YYYYMM   = W_RESERVE_YYYYMM
        AND RR.DEPT_ID          = NVL(W_DEPT_ID, RR.DEPT_ID)
        AND RR.Person_Id        = NVL(W_PERSON_ID, RR.PERSON_ID)
        AND RR.SOB_ID           = W_SOB_ID
        AND RR.ORG_ID           = W_ORG_ID
      ;  
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Delete_Error => ' || SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;

--> �������� ó�� ���� .
    BEGIN
      SELECT RS.STD_CALCULATE_MONTH, RS.STD_MONTH, RS.PAY_MONTH, RS.BONUS_MONTH, RS.MONTH_DAY, RS.YEAR_DAY 
        INTO V_STD_CALCULATE_MONTH, V_STD_MONTH, V_STD_PAY_MONTH, V_STD_BONUS_MONTH, V_STD_MONTH_DAY, V_STD_YEAR_DAY
        FROM HRR_RETIRE_STANDARD RS
       WHERE RS.STD_YYYY          = TO_CHAR(V_STD_DATE, 'YYYY')
         AND RS.SOB_ID            = W_SOB_ID
         AND RS.ORG_ID            = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('3rd Standard Month Error =>' || SUBSTR(SQLERRM, 1, 150));
      V_STD_CALCULATE_MONTH := 12;
      V_STD_PAY_MONTH := 3;
      V_STD_BONUS_MONTH := 12;
      V_STD_MONTH_DAY := 30;
      V_STD_YEAR_DAY := 365;
    END;
  
--> �������� ����;      
    BEGIN
      SELECT ADD_MONTHS(V_STD_DATE, -V_STD_CALCULATE_MONTH) AS PRE_YEAR_DATE
          , TO_CHAR(ADD_MONTHS(V_STD_DATE, -1), 'YYYY-MM') AS PRE_PAY_YYYYMM        
          , TO_CHAR(ADD_MONTHS(V_STD_DATE, -(V_STD_PAY_MONTH - 1)), 'YYYY-MM') AS START_PAY_YYYYMM
          , TO_CHAR(ADD_MONTHS(V_STD_DATE, -(V_STD_BONUS_MONTH - 1)), 'YYYY-MM') AS START_BONUS_YYYYMM
          , V_STD_DATE AS END_DATE
        INTO V_PRE_YEAR_DATE
          , V_PRE_PAY_YYYYMM
          , V_STR_PAY_YYYYMM
          , V_STR_BONUS_YYYYMM
          , V_RETR_END_DATE
        FROM DUAL;

    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Reserve Date Term Error => ' || SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;

---> 3���� ����ϼ�;
    BEGIN
      V_3RD_DAY := HRM_COMMON_DATE_G.RETIRE_DATE_3RD_DAY(V_RETR_END_DATE, W_SOB_ID, W_ORG_ID);      
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := '3rd Average Day Error => ' || SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;

---------------------------------------------------------------------------------------------------
--> ���� ���� ���.
    FOR C1 IN (SELECT PM.PERSON_ID
                    , PM.NAME
                    , PM.CORP_ID
                    , PM.DEPT_ID
                    , PM.PAY_GRADE_ID
                    , PM.SOB_ID
                    , PM.ORG_ID                    
                    , NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE) AS JOIN_DATE
                    , PM.EXPIRE_DATE
                    , PM.COST_CENTER_ID
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.CORP_ID          = W_CORP_ID
                  AND PM.SOB_ID           = W_SOB_ID
                  AND PM.ORG_ID           = W_ORG_ID
                  AND PM.DEPT_ID          = NVL(W_DEPT_ID, PM.DEPT_ID)
                  AND PM.PERSON_ID        = NVL(W_PERSON_ID, PM.PERSON_ID)
                  AND NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE) <= V_PRE_YEAR_DATE
                  AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= V_STD_DATE)
              )
    LOOP
--> ���� �ʱ�ȭ;
      V_RETR_START_DATE             := NULL;        -- ���� ��������;
    
      V_TOTAL_AMOUNT                := 0;           -- ���հ�ݾ�;
      V_TOTAL_PAY_AMOUNT            := 0;           -- �޿��հ�;
      V_TOTAL_BONUS_AMOUNT          := 0;           -- �󿩱����հ�;
      V_YEAR_ALOWANCE_AMOUNT        := 0;           -- ����;
      V_DAY_AVG_AMOUNT              := 0;           -- ����վ�;

      V_LONG_YEAR                   := 0;           -- �ټӳ��;
      V_LONG_MONTH                  := 0;           -- �ټӿ���;
      V_LONG_DAY                    := 0;           -- �����ϼ�;

      V_RETIRE_AMOUNT               := 0;           -- �����;
                
--> �ߵ����� ���� üũ �� ���� �������� ����;
      BEGIN
        SELECT MAX(RA.RETIRE_DATE_TO) AS END_RETIRE_DATE_TO
          INTO V_RETR_START_DATE
          FROM HRR_RETIRE_ADJUSTMENT RA
        WHERE RA.ADJUSTMENT_TYPE     = 'M'
          AND RA.PERSON_ID           = C1.PERSON_ID
          AND RA.RETIRE_DATE_TO      < V_STD_DATE
        ;
      EXCEPTION WHEN OTHERS THEN
        V_RETR_START_DATE := NULL;
      END;
      IF V_RETR_START_DATE IS NULL THEN
        IF C1.EXPIRE_DATE IS NOT NULL AND C1.EXPIRE_DATE < V_STD_DATE THEN
          V_RETR_START_DATE := C1.EXPIRE_DATE;
        ELSE
          V_RETR_START_DATE := C1.JOIN_DATE;    
        END IF;        
      END IF;

--> ���� ��-���� ���� üũ�� ���� ���� �������ڿ� �Ϸ縦 ���� ����.
      V_NEW_END_DATE := V_RETR_END_DATE;
      IF TO_CHAR(V_RETR_START_DATE, 'MM-DD') = TO_CHAR(V_RETR_END_DATE, 'MM-DD') THEN
        V_NEW_END_DATE := V_RETR_END_DATE + 1;
      END IF;
      
--> �ټӳ��, �ټӿ���, �ټ��ϼ� ���  
      BEGIN
        V_LONG_YEAR := HRM_COMMON_DATE_G.YEAR_COUNT_F(V_RETR_START_DATE, V_NEW_END_DATE, 'CEIL');
        V_LONG_MONTH := HRM_COMMON_DATE_G.PERIOD_MONTH_F(V_RETR_START_DATE, V_NEW_END_DATE, 0, 0);
        V_LONG_DAY := HRM_COMMON_DATE_G.PERIOD_DAY_F(V_RETR_START_DATE, V_NEW_END_DATE, 1);        
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Long Calculate Error =>' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
      
--> �޿� ���.
      BEGIN
        SELECT SUM(MA.ALLOWANCE_AMOUNT) AS TOTAL_PAY_AMOUNT
          INTO V_TOTAL_PAY_AMOUNT
          FROM HRP_MONTH_PAYMENT MP
             , HRM_PERSON_MASTER PM
             , HRP_MONTH_ALLOWANCE MA
             , HRM_ALLOWANCE_V HAV
         WHERE MP.PERSON_ID               = PM.PERSON_ID
           AND MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID
           AND MA.ALLOWANCE_ID            = HAV.ALLOWANCE_ID
           AND MP.PAY_YYYYMM              BETWEEN V_STR_PAY_YYYYMM AND W_RESERVE_YYYYMM
           AND MP.WAGE_TYPE               = 'P1'  -- �޿�.
           AND MP.PERSON_ID               = C1.PERSON_ID
           AND MP.SOB_ID                  = C1.SOB_ID
           AND MP.ORG_ID                  = C1.ORG_ID
           AND HAV.RETIRE_YN              = 'Y'
           AND NOT EXISTS ( SELECT 'X'
                              FROM HRM_ALLOWANCE_V HA
                             WHERE HA.ALLOWANCE_ID    = MA.ALLOWANCE_ID
                               AND HA.ALLOWANCE_TYPE  IN('YEAR', 'BONUS')
                               AND HA.RETIRE_YN       = 'Y'
                               AND HA.ENABLED_FLAG    = 'Y'
                               AND HA.EFFECTIVE_DATE_FR <= LAST_DAY(V_STD_DATE)
                               AND (HA.EFFECTIVE_DATE_TO IS NULL OR HA.EFFECTIVE_DATE_TO >= TRUNC(V_STD_DATE, 'MONTH'))
                          )
        GROUP BY MP.PERSON_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_TOTAL_PAY_AMOUNT := 0;
      END;
--> ���� �ѱݾ�.
      V_TOTAL_AMOUNT := NVL(V_TOTAL_PAY_AMOUNT, 0);
      
--> �� ���.
      -- 1.�޿��� �󿩱� �׸� ����.
      BEGIN
        SELECT SUM(MA.ALLOWANCE_AMOUNT) AS TOTAL_PAY_AMOUNT
          INTO V_TOTAL_BONUS_AMOUNT
          FROM HRP_MONTH_PAYMENT MP
             , HRM_PERSON_MASTER PM
             , HRP_MONTH_ALLOWANCE MA
             , HRM_ALLOWANCE_V HAV
         WHERE MP.PERSON_ID               = PM.PERSON_ID
           AND MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID
           AND MA.ALLOWANCE_ID            = HAV.ALLOWANCE_ID
           AND MP.PAY_YYYYMM              BETWEEN V_STR_BONUS_YYYYMM AND W_RESERVE_YYYYMM
           AND MP.WAGE_TYPE               = 'P1'
           AND MP.PERSON_ID               = C1.PERSON_ID
           AND MP.SOB_ID                  = C1.SOB_ID
           AND MP.ORG_ID                  = C1.ORG_ID
           AND HAV.RETIRE_YN              = 'Y'
           AND EXISTS ( SELECT 'X'
                          FROM HRM_ALLOWANCE_V HA
                         WHERE HA.ALLOWANCE_ID    = MA.ALLOWANCE_ID
                           AND HA.ALLOWANCE_TYPE  IN('BONUS')
                           AND HA.RETIRE_YN       = 'Y'
                           AND HA.ENABLED_FLAG    = 'Y'
                           AND HA.EFFECTIVE_DATE_FR <= LAST_DAY(V_STD_DATE)
                           AND (HA.EFFECTIVE_DATE_TO IS NULL OR HA.EFFECTIVE_DATE_TO >= TRUNC(V_STD_DATE, 'MONTH'))
                      )
        GROUP BY MP.PERSON_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_TOTAL_BONUS_AMOUNT := 0;
      END;
      -- 2. �� �׸�.
      BEGIN
        SELECT NVL(V_TOTAL_BONUS_AMOUNT, 0) + NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS TOTAL_PAY_AMOUNT
          INTO V_TOTAL_BONUS_AMOUNT
          FROM HRP_MONTH_PAYMENT MP
             , HRM_PERSON_MASTER PM
             , HRP_MONTH_ALLOWANCE MA
             , HRM_ALLOWANCE_V HAV
         WHERE MP.PERSON_ID               = PM.PERSON_ID
           AND MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID
           AND MA.ALLOWANCE_ID            = HAV.ALLOWANCE_ID
           AND MP.PAY_YYYYMM              BETWEEN V_STR_BONUS_YYYYMM AND W_RESERVE_YYYYMM
           AND MP.WAGE_TYPE               IN('P2', 'P3', 'P5')  -- �����, ������, Ư����.
           AND MP.PERSON_ID               = C1.PERSON_ID
           AND MP.SOB_ID                  = C1.SOB_ID
           AND MP.ORG_ID                  = C1.ORG_ID
           AND HAV.RETIRE_YN              = 'Y'
        GROUP BY MP.PERSON_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_TOTAL_BONUS_AMOUNT := 0;
      END;
--> ���� �ѱݾ�.
      IF NVL(V_STD_BONUS_MONTH, 0) = 0 THEN
        V_STD_BONUS_MONTH := 12;
      END IF;
      IF NVL(V_STD_MONTH, 0) = 0 THEN
        V_STD_MONTH := 3;        
      END IF;
      V_TOTAL_AMOUNT := NVL(V_TOTAL_AMOUNT, 0) + TRUNC(NVL(V_TOTAL_BONUS_AMOUNT, 0) / NVL(V_STD_BONUS_MONTH ,0) * V_STD_MONTH);
      
--> �����հ�
      BEGIN
        SELECT SUM(MA.ALLOWANCE_AMOUNT) AS TOTAL_PAY_AMOUNT
          INTO V_YEAR_ALOWANCE_AMOUNT
          FROM HRP_MONTH_PAYMENT MP
             , HRM_PERSON_MASTER PM
             , HRP_MONTH_ALLOWANCE MA
             , HRM_ALLOWANCE_V HAV
         WHERE MP.PERSON_ID               = PM.PERSON_ID
           AND MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID
           AND MA.ALLOWANCE_ID            = HAV.ALLOWANCE_ID
           AND MP.PAY_YYYYMM              = SUBSTR(W_RESERVE_YYYYMM, 1, 4) || '-01'
           AND MP.PERSON_ID               = C1.PERSON_ID
           AND MP.SOB_ID                  = C1.SOB_ID
           AND MP.ORG_ID                  = C1.ORG_ID
           AND HAV.RETIRE_YN              = 'Y'
           AND EXISTS ( SELECT 'X'
                          FROM HRM_ALLOWANCE_V HA
                         WHERE HA.ALLOWANCE_ID    = MA.ALLOWANCE_ID
                           AND HA.ALLOWANCE_TYPE  IN('YEAR')
                           AND HA.RETIRE_YN       = 'Y'
                           AND HA.ENABLED_FLAG    = 'Y'
                           AND HA.EFFECTIVE_DATE_FR <= LAST_DAY(V_STD_DATE)
                           AND (HA.EFFECTIVE_DATE_TO IS NULL OR HA.EFFECTIVE_DATE_TO >= TRUNC(V_STD_DATE, 'MONTH'))
                      )
        GROUP BY MP.PERSON_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_YEAR_ALOWANCE_AMOUNT := 0;
      END;
--> ���� �ѱݾ�.      
      IF NVL(V_STD_BONUS_MONTH, 0) = 0 THEN
        V_STD_BONUS_MONTH := 12;
      END IF;
      IF NVL(V_STD_MONTH, 0) = 0 THEN
        V_STD_MONTH := 3;        
      END IF;
      V_TOTAL_AMOUNT := NVL(V_TOTAL_AMOUNT, 0) + TRUNC(NVL(V_YEAR_ALOWANCE_AMOUNT, 0) / V_STD_BONUS_MONTH * V_STD_MONTH);
      
      --> ����վ� ����;
      BEGIN
        V_DAY_AVG_AMOUNT := TRUNC(V_TOTAL_AMOUNT / V_3RD_DAY);
      EXCEPTION WHEN OTHERS THEN
        V_DAY_AVG_AMOUNT := 0;
      END;  

--> ������ ���(����վ� * 30 * �ѱٹ��ϼ� / 365);
      BEGIN
        V_RETIRE_AMOUNT := V_DAY_AVG_AMOUNT * V_STD_MONTH_DAY * V_LONG_DAY / V_STD_YEAR_DAY;
        V_RETIRE_AMOUNT := HRM_COMMON_G.DECIMAL_F(W_SOB_ID, W_ORG_ID, V_RETIRE_AMOUNT, 'RETIRE_RESERVE');
                  
        --> �������� ����;
        INSERT INTO HRR_RETIRE_RESERVE
        (PERSON_ID, RESERVE_YYYYMM, CORP_ID, DEPT_ID, PAY_GRADE_ID, COST_CENTER_ID
        , JOIN_DATE, EXPIRE_DATE, START_DATE, END_DATE
        , TOTAL_PAY_AMOUNT, TOTAL_BONUS_AMOUNT, YEAR_ALLOWANCE_AMOUNT
        , LONG_YEAR, LONG_MONTH, LONG_DAY
        , DAY_3RD_COUNT, DAY_AVG_AMOUNT, RETIRE_AMOUNT
        , PREVIOUS_RETIRE_AMOUNT, THIS_RETIRE_AMOUNT, GAP_RETIRE_AMOUNT
        , SOB_ID, ORG_ID
        , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
        ) VALUES
        (C1.PERSON_ID, W_RESERVE_YYYYMM, C1.CORP_ID, C1.DEPT_ID, C1.PAY_GRADE_ID, C1.COST_CENTER_ID
        , C1.JOIN_DATE, C1.EXPIRE_DATE, V_RETR_START_DATE, V_RETR_END_DATE
        , V_TOTAL_PAY_AMOUNT, V_TOTAL_BONUS_AMOUNT, V_YEAR_ALOWANCE_AMOUNT
        , V_LONG_YEAR, V_LONG_MONTH, V_LONG_DAY
        , V_3RD_DAY, V_DAY_AVG_AMOUNT, V_RETIRE_AMOUNT
        , 0, V_RETIRE_AMOUNT, 0
        , C1.SOB_ID, C1.ORG_ID
        , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
        );

--> ���� �������� UPDATE;
        UPDATE HRR_RETIRE_RESERVE HRR
          SET ( HRR.PREVIOUS_RETIRE_AMOUNT
              , HRR.GAP_RETIRE_AMOUNT)
              = ( SELECT NVL(HRR1.THIS_RETIRE_AMOUNT, 0)
                       , NVL(HRR.THIS_RETIRE_AMOUNT, 0) - NVL(HRR1.THIS_RETIRE_AMOUNT, 0) AS GAP_RETIRE_AMOUNT
                    FROM HRR_RETIRE_RESERVE HRR1
                   WHERE HRR1.RESERVE_YYYYMM  = V_PRE_PAY_YYYYMM
                     AND HRR1.PERSON_ID       = HRR.PERSON_ID
                     AND HRR1.CORP_ID         = HRR.CORP_ID
                     AND HRR1.SOB_ID          = HRR.SOB_ID
                     AND HRR1.ORG_ID          = HRR.ORG_ID
                )
        WHERE HRR.RESERVE_YYYYMM  = W_RESERVE_YYYYMM
          AND HRR.PERSON_ID       = C1.PERSON_ID
          AND HRR.CORP_ID         = C1.CORP_ID
          AND HRR.SOB_ID          = C1.SOB_ID
          AND HRR.ORG_ID          = C1.ORG_ID
        ;
      END;               

    END LOOP C1;             
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);    
  END SET_RETIRE_RESERVE;
  
END HRR_RETIRE_RESERVE_G;
/
