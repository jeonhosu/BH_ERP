CREATE OR REPLACE PACKAGE HRR_RETIRE_ADJUSTMENT_SET_G
AS

/*==========================================================================/
     ==> �������� ���
       -. ������ �޿��� �ٽ� �����Ͽ� �ݿ�
       -. �󿩱��� �����޵� ������ �ݿ�
/==========================================================================*/
  PROCEDURE RETIRE_MAIN
            ( W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_TYPE%TYPE
            , W_RETIRE_DATE_FR                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_FR%TYPE
            , W_RETIRE_DATE_TO                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_TO%TYPE
            , W_RETIRE_CAL_TYPE                   IN VARCHAR2
            , W_CORP_ID                           IN HRR_RETIRE_ADJUSTMENT.CORP_ID%TYPE
            , W_PERSON_ID                         IN HRR_RETIRE_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRR_RETIRE_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRR_RETIRE_ADJUSTMENT.ORG_ID%TYPE
            , P_USER_ID                           IN HRR_RETIRE_ADJUSTMENT.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            );

/*==========================================================================/
     ==> ������ ���
       -. P_DAY_AVG_AMOUNT : ����� �ݾ�
       -. P_TOTAL_DAY : �ѱټ��ϼ�
/==========================================================================*/
  FUNCTION  RETR_AMOUNT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_DAY_AVG_AMOUNT          IN NUMBER
            , P_TOTAL_DAY               IN NUMBER            
            ) RETURN NUMBER;

/*==========================================================================/
     ==> �����ҵ���� ���   - 1
/==========================================================================*/
  FUNCTION  INCOME_SUBTRACT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_TOTAL_AMOUNT            IN NUMBER
            ) RETURN NUMBER;

/*==========================================================================/
     ==> �����ټӳ���� ���� ������ ����  - 2
/==========================================================================*/
  FUNCTION LONG_DED_YEAR_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_LONG_YEAR               IN NUMBER
            ) RETURN NUMBER;

/*==========================================================================/
     ==> �� ��� ���⼼�� ���   - 5
/==========================================================================*/
  FUNCTION AVG_TAX_AMOUNT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_AVG_TAX_STD_AMOUNT      IN NUMBER
            ) RETURN NUMBER;

/*==========================================================================/
     ==> �����ҵ���� ���  - 6
/==========================================================================*/
  FUNCTION TAX_SUBTRACT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_END_DATE                IN DATE
            , P_LONG_YEAR               IN NUMBER
            , P_TAX_AMOUNT              IN NUMBER
            ) RETURN NUMBER;

END HRR_RETIRE_ADJUSTMENT_SET_G;

 
/
CREATE OR REPLACE PACKAGE BODY HRR_RETIRE_ADJUSTMENT_SET_G
AS

/*==========================================================================/
     ==> �������� ���
       -. ������ �޿��� �ٽ� �����Ͽ� �ݿ�
       -. �󿩱��� �����޵� ������ �ݿ�
       1. �����ҵ���� ���(INCOME_SUBTRACT)   V
       2. �ٷμҵ���� ���(CONTINUOUS_YEAR)   V
       3. �����ҵ������(�����ҵ���� + �ٷμҵ����)   V
       4. ����ǥ��(������ - �����ҵ������)   V
       5. ���⼼��(CAL_TAX)
       6. �����ҵ漼�װ���() - ����
       7. �ҵ漼 �� �ֹμ�(�ҵ漼 * 0.1) ���

/==========================================================================*/
  PROCEDURE RETIRE_MAIN
            ( W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_TYPE%TYPE
            , W_RETIRE_DATE_FR                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_FR%TYPE
            , W_RETIRE_DATE_TO                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_TO%TYPE
            , W_RETIRE_CAL_TYPE                   IN VARCHAR2
            , W_CORP_ID                           IN HRR_RETIRE_ADJUSTMENT.CORP_ID%TYPE
            , W_PERSON_ID                         IN HRR_RETIRE_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRR_RETIRE_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRR_RETIRE_ADJUSTMENT.ORG_ID%TYPE
            , P_USER_ID                           IN HRR_RETIRE_ADJUSTMENT.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    V_SYSDATE                                     DATE := GET_LOCAL_DATE(W_SOB_ID);

    V_ADJUSTMENT_ID                               NUMBER;         -- �������� ID
    V_RETR_YYYY                                   VARCHAR2(4);    -- �����⵵
    V_3RD_DAY_COUNT                               NUMBER;         -- 3���� ���ϼ� (�޿��ϼ�)
    V_3RD_DAY_COUNT2                              NUMBER;         -- 3���� ���ϼ� (�󿩿����ϼ�)
    V_REAL_DAY                                    NUMBER;         -- ���� ����Ǵ� �ٹ��ϼ�
    V_RETR_AMOUNT                                 NUMBER;         -- ������
    V_TOTAL_RETR_AMOUNT                           NUMBER;         -- ��������
    V_REAL_AMOUNT                                 NUMBER;         -- ��������        
    V_INCOME_DED_AMOUNT                           NUMBER;         -- �����ҵ����
    V_LONG_DED_YEAR_AMOUNT                        NUMBER;         -- �ټӳ���� ���� �ҵ����
    V_TAX_STD_AMOUNT                              NUMBER;         -- ����ǥ��
    V_AVG_TAX_STD_AMOUNT                          NUMBER;         -- ����հ���ǥ��
    V_AVG_COMP_TAX_AMOUNT                         NUMBER;         -- ����� ���⼼��
    V_COMP_TAX_AMOUNT                             NUMBER;         -- ���⼼��
    V_TAX_DED_AMOUNT                              NUMBER;         -- �����ҵ漼�װ���
    V_IN_TAX_AMOUNT                               NUMBER;         -- �ҵ漼
    V_LOCAL_TAX_AMOUNT                            NUMBER;         -- �ֹμ�
    
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
    O_STATUS := 'F';
    --> �����⵵ ���
    BEGIN
      V_RETR_YYYY := TO_CHAR(W_RETIRE_DATE_TO, 'YYYY');
    EXCEPTION WHEN OTHERS THEN
      V_RETR_YYYY := TO_CHAR(GET_LOCAL_DATE(W_SOB_ID), 'YYYY');
    END;

-----------------------------------------------------------
    --> ������ ó���� �������� ID ��ȸ(���� �Ⱓ�� ����)
    V_ADJUSTMENT_ID := 0;
    BEGIN
      SELECT RA.ADJUSTMENT_ID
        INTO V_ADJUSTMENT_ID
        FROM HRR_RETIRE_ADJUSTMENT RA
      WHERE RA.ADJUSTMENT_TYPE    = W_ADJUSTMENT_TYPE
        AND RA.PERSON_ID          = W_PERSON_ID
        AND RA.CORP_ID            = W_CORP_ID
        AND RA.RETIRE_DATE_FR     = W_RETIRE_DATE_FR
        AND RA.RETIRE_DATE_TO     = W_RETIRE_DATE_TO
        AND RA.SOB_ID             = W_SOB_ID
        AND RA.ORG_ID             = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ADJUSTMENT_ID := -1;
    END;

    IF HRR_RETIRE_ADJUSTMENT_G.CLOSE_CHECK_F(V_ADJUSTMENT_ID) = 'Y' THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10168');
      RETURN;
    END IF;
    
    IF V_ADJUSTMENT_ID = 0 OR V_ADJUSTMENT_ID = -1 THEN
    --> 1.1 �ű� ����
      BEGIN
          INSERT INTO HRR_RETIRE_ADJUSTMENT
          ( ADJUSTMENT_ID 
          , ADJUSTMENT_TYPE, ADJUSTMENT_YYYY, PERSON_ID , CORP_ID 
          , RETIRE_DATE_FR, RETIRE_DATE_TO
          , COST_CENTER_ID
          , SOB_ID, ORG_ID
          , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
          , OFFICER_YN)
          ( SELECT HRR_RETIRE_ADJUSTMENT_S1.NEXTVAL
                , W_ADJUSTMENT_TYPE, V_RETR_YYYY, PM.PERSON_ID, PM.CORP_ID
                , W_RETIRE_DATE_FR, W_RETIRE_DATE_TO
                , PM.COST_CENTER_ID
                , W_SOB_ID, W_ORG_ID
                , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
                , NVL(T1.OFFICER_YN, 'N') AS OFFICER_YN
              FROM HRM_PERSON_MASTER PM
                 , (-- ���� �λ系��.
                  SELECT HL.PERSON_ID
                      , HL.DEPT_ID
                      , HL.POST_ID
                      , PC.OFFICER_YN
                      , HL.JOB_CATEGORY_ID
                      , HL.FLOOR_ID    
                    FROM HRM_HISTORY_LINE HL  
                       , HRM_POST_CODE_V  PC
                  WHERE HL.POST_ID          = PC.POST_ID
                    AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                  FROM HRM_HISTORY_LINE S_HL
                                                 WHERE S_HL.CHARGE_DATE            <= TRUNC(W_RETIRE_DATE_TO)
                                                   AND S_HL.PERSON_ID              = HL.PERSON_ID
                                                 GROUP BY S_HL.PERSON_ID
                                               )
                  ) T1
            WHERE PM.PERSON_ID    = T1.PERSON_ID
              AND PM.PERSON_ID    = W_PERSON_ID
          );
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Person Infomation Error =>' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    END IF;

--. �ſ� ���� ����� ��� 3���� ���� 1�� ���� �׿ܿ��� ADD_MONTHS(������, -3)
    V_3RD_DAY_COUNT  := HRM_COMMON_DATE_G.RETIRE_DATE_3RD_DAY(W_RETIRE_DATE_TO, W_SOB_ID, W_ORG_ID);
    V_3RD_DAY_COUNT2 := V_3RD_DAY_COUNT;

    --> 1.2 �ټӳ��, �ټӿ���, �ټ��ϼ� ���
    BEGIN
      UPDATE HRR_RETIRE_ADJUSTMENT RA
      SET RA.LONG_YEAR = HRM_COMMON_DATE_G.PERIOD_YEAR_F(W_RETIRE_DATE_FR, W_RETIRE_DATE_TO, 'CEIL')
        , RA.LONG_MONTH = HRM_COMMON_DATE_G.PERIOD_MONTH_F(W_RETIRE_DATE_FR, W_RETIRE_DATE_TO, 'CEIL')
        , RA.LONG_DAY = HRM_COMMON_DATE_G.PERIOD_DAY_F(W_RETIRE_DATE_FR, W_RETIRE_DATE_TO, 1)        
        , RA.DAY_3RD_COUNT = V_3RD_DAY_COUNT
      WHERE RA.ADJUSTMENT_ID      = V_ADJUSTMENT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Long Period Calculation Error : ' || SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;
--> 3���� �޿� ��� : �ű԰��ø� ����.-
    IF W_RETIRE_CAL_TYPE = 'NEW' THEN
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => V_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_RETIRE_DATE_TO
                              , P_WAGE_TYPE => 'P1'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1�� �� �� ���-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => V_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_RETIRE_DATE_TO
                              , P_WAGE_TYPE => 'P2'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1�� ������ �� ���-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => V_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_RETIRE_DATE_TO
                              , P_WAGE_TYPE => 'P3'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1�� Ư���� �� ���-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => V_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_RETIRE_DATE_TO
                              , P_WAGE_TYPE => 'P5'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );                              
      --> �����հ�.
      BEGIN
        UPDATE HRR_RETIRE_ADJUSTMENT RA
          SET (RA.YEAR_ALLOWANCE_AMOUNT)
            = NVL(
              ( SELECT NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS YEAR_ALLOWANCE_AMOUNT
                  FROM HRP_MONTH_PAYMENT MP
                   , HRP_MONTH_ALLOWANCE MA
                   , HRM_ALLOWANCE_V HA
                WHERE MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID
                  AND MA.ALLOWANCE_ID            = HA.ALLOWANCE_ID
                  AND MP.PAY_YYYYMM              = TO_CHAR(TRUNC(RA.RETIRE_DATE_TO, 'YEAR'), 'YYYY-MM')
                  AND MP.PERSON_ID               = RA.PERSON_ID
                  AND MP.SOB_ID                  = RA.SOB_ID
                  AND MP.ORG_ID                  = RA.ORG_ID
                  AND HA.ALLOWANCE_TYPE          IN('YEAR')
                  AND HA.RETIRE_YN               = 'Y'
                GROUP BY MP.PERSON_ID
               ), 0)
        WHERE RA.ADJUSTMENT_ID      = V_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Year Amount Calculation Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    END IF;
    
    BEGIN
      --> ��/�� ���� ���.
      BEGIN
        UPDATE HRR_RETIRE_ADJUSTMENT RA
          SET (RA.TOTAL_PAY_AMOUNT, RA.TOTAL_BONUS_AMOUNT)
            = (SELECT NVL(SUM(DECODE(RAP.WAGE_TYPE, 'P1', RAP.TOTAL_AMOUNT, 0)), 0) AS PAY_TOTAL_AMOUNT
                   , NVL(SUM(CASE
                               WHEN RAP.WAGE_TYPE IN('P2', 'P3', 'P5') THEN RAP.TOTAL_AMOUNT
                               ELSE 0
                             END), 0) AS BONUS_TOTAL_AMOUNT
                FROM HRR_RETIRE_ADJUSTMENT_PAYMENT RAP
               WHERE RAP.ADJUSTMENT_ID          = RA.ADJUSTMENT_ID
                 AND RAP.WAGE_TYPE              IN('P1', 'P2', 'P3', 'P5')    -- P1-�޿�, P2-��, P3-������, P5-Ư����.
               ) 
        WHERE RA.ADJUSTMENT_ID      = V_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Pay Calculation Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;

       --> ����ձݾ� ����
       UPDATE HRR_RETIRE_ADJUSTMENT RA
         SET RA.DAY_AVG_AMOUNT = TRUNC((RA.TOTAL_PAY_AMOUNT / DECODE(V_3RD_DAY_COUNT, 0, 1, V_3RD_DAY_COUNT)) 
                                    + ((RA.TOTAL_BONUS_AMOUNT + RA.YEAR_ALLOWANCE_AMOUNT) / 4 / DECODE(V_3RD_DAY_COUNT2, 0, 1, V_3RD_DAY_COUNT2)))
       WHERE RA.ADJUSTMENT_ID     = V_ADJUSTMENT_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Day Avg Amount Error : ' || SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;
    
    --> ���������� ���� ���� ����
    FOR C1 IN (SELECT RA.RETIRE_DATE_FR
                    , RA.RETIRE_DATE_TO
                    , NVL(RA.LONG_YEAR, 0) AS LONG_YEAR
                    , NVL(RA.LONG_MONTH, 0) AS LONG_MONTH
                    , NVL(RA.LONG_DAY, 0) AS LONG_DAY
                    , NVL(RA.DED_DAY, 0) AS DED_DAY
                    , NVL(RA.TOTAL_PAY_AMOUNT, 0) AS TOTAL_PAY_AMOUNT
                    , NVL(RA.TOTAL_BONUS_AMOUNT, 0) AS TOTAL_BONUS_AMOUNT
                    , NVL(RA.YEAR_ALLOWANCE_AMOUNT, 0) AS YEAR_ALLOWANCE_AMOUNT
                    , NVL(RA.DAY_AVG_AMOUNT, 0) AS DAY_AVG_AMOUNT
                    , NVL(RA.RETIRE_AMOUNT, 0) AS RETIRE_AMOUNT
                    , NVL(RA.GLORY_AMOUNT, 0) AS GLORY_AMOUNT
                    , NVL(RA.ETC_SUPP_AMOUNT, 0) AS ETC_SUPP_AMOUNT
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
                    , NVL(RA.ETC_DED_AMOUNT, 0) AS ETC_DED_AMOUNT
                    , NVL(RA.RETIRE_CVS_AMOUNT, 0) AS RETIRE_CVS_AMOUNT
                    , NVL(RA.REAL_AMOUNT, 0) AS REAL_AMOUNT
                    , NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE) AS JOIN_DATE
                    , NVL(RA.HONORARY_AMOUNT, 0) AS HONORARY_AMOUNT
                 FROM HRR_RETIRE_ADJUSTMENT RA
                   , HRM_PERSON_MASTER PM
               WHERE RA.PERSON_ID          = PM.PERSON_ID
                 AND RA.ADJUSTMENT_ID      = V_ADJUSTMENT_ID
               )
    LOOP
      --> �ʱ�ȭ
      V_REAL_DAY := 0;                  -- ���� �ټ��ϼ�
      V_RETR_AMOUNT := 0;               -- ������
      V_TOTAL_RETR_AMOUNT := 0;         -- �������� �հ�
      
      V_INCOME_DED_AMOUNT := 0;            -- �����ҵ����
      V_LONG_DED_YEAR_AMOUNT := 0;   -- �ټӳ���� ���� �ҵ����
      V_TAX_STD_AMOUNT := 0;               -- ����ǥ��
      V_AVG_TAX_STD_AMOUNT := 0;           -- ����� ����ǥ��
      V_AVG_COMP_TAX_AMOUNT := 0;          -- ����� ���⼼��
      V_COMP_TAX_AMOUNT := 0;              -- ���⼼��
      V_TAX_DED_AMOUNT := 0;               -- �����ҵ漼�װ���
      V_IN_TAX_AMOUNT := 0;                -- �ҵ漼
      V_LOCAL_TAX_AMOUNT := 0;             -- �ֹμ�
      V_REAL_AMOUNT := 0;          -- ��������

      V_H_RETIRE_DATE_FR                            := NULL;      -- ������ ���� ������.   
      V_H_RETIRE_DATE_TO                            := NULL;      -- ������ ���� ������.
      V_H_LONG_YEAR                                 := 0;         -- ������ �ټӳ��.
      V_H_LONG_DED_YEAR_AMOUNT                      := 0;
      V_H_INCOME_DED_AMOUNT                         := 0;         -- �����ҵ����
      V_H_LONG_DED_YEAR_AMOUNT                      := 0;         -- �ټӳ���� ���� �ҵ����
      V_H_TAX_STD_AMOUNT                            := 0;         -- ����ǥ��
      V_H_AVG_TAX_STD_AMOUNT                        := 0;         -- ����հ���ǥ��
      V_H_AVG_COMP_TAX_AMOUNT                       := 0;         -- ����� ���⼼��
      V_H_COMP_TAX_AMOUNT                           := 0;         -- ���⼼��
      V_H_TAX_DED_AMOUNT                            := 0;         -- �����ҵ漼�װ���
      V_H_IN_TAX_AMOUNT                             := 0;         -- �ҵ漼
      V_H_LOCAL_TAX_AMOUNT                          := 0;         -- �ֹμ�
      V_H_REAL_AMOUNT                               := 0;         -- ��������.
      
      V_REAL_TOTAL_AMOUNT                           := 0;         -- �� 
      
      --> ������ ���
      V_REAL_DAY := NVL(C1.LONG_DAY, 0) - NVL(C1.DED_DAY, 0);
      
          -- ���ݰ�길 ó���� ��� ���� ����.
      IF W_RETIRE_CAL_TYPE <> 'TAX' THEN
        V_RETR_AMOUNT := RETR_AMOUNT_F(V_RETR_YYYY , W_SOB_ID, W_ORG_ID, C1.DAY_AVG_AMOUNT, V_REAL_DAY);
      ELSE
        V_RETR_AMOUNT := NVL(C1.RETIRE_AMOUNT, 0);  
      END IF;
      --> ��������
      V_TOTAL_RETR_AMOUNT := V_RETR_AMOUNT + NVL(C1.GLORY_AMOUNT, 0) + NVL(C1.ETC_SUPP_AMOUNT, 0);

---------------------------------------------------------------------------------------------------
      --> �����ٷμҵ� ����
      V_INCOME_DED_AMOUNT := INCOME_SUBTRACT_F(V_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_TOTAL_RETR_AMOUNT);

      --> �ټӿ� ���� �ҵ����
      V_LONG_DED_YEAR_AMOUNT := LONG_DED_YEAR_F(V_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.LONG_YEAR);

      --> ���� ǥ��
      V_TAX_STD_AMOUNT := V_TOTAL_RETR_AMOUNT - V_INCOME_DED_AMOUNT - V_LONG_DED_YEAR_AMOUNT;
      IF V_TAX_STD_AMOUNT < 0 THEN
        V_TAX_STD_AMOUNT := 0;
      END IF;

      --> ����� ����ǥ��
      V_AVG_TAX_STD_AMOUNT := TRUNC(V_TAX_STD_AMOUNT / C1.LONG_YEAR);

      --> ���⼼��
      V_AVG_COMP_TAX_AMOUNT := AVG_TAX_AMOUNT_F(V_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_AVG_TAX_STD_AMOUNT);

      --> ���⼼��
      V_COMP_TAX_AMOUNT := V_AVG_COMP_TAX_AMOUNT * C1.LONG_YEAR;

      --> �ҵ漼�װ���
      V_TAX_DED_AMOUNT := TAX_SUBTRACT_F(V_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.RETIRE_DATE_TO, V_COMP_TAX_AMOUNT, C1.LONG_YEAR);

      --> �ҵ漼
      V_IN_TAX_AMOUNT := TRUNC(V_COMP_TAX_AMOUNT - V_TAX_DED_AMOUNT, -1);   -- ������ ����
      IF V_IN_TAX_AMOUNT < 0 THEN
        V_IN_TAX_AMOUNT := 0;
      END IF;

      --> �ֹμ�
      V_LOCAL_TAX_AMOUNT := TRUNC(V_IN_TAX_AMOUNT * (TAX_RATE_F('RESIDENT', W_SOB_ID, W_ORG_ID) / 100), -1);   -- ������ ����

      --> �����޾� (�������� - �ֹμ� - �ҵ漼 - ��Ÿ���� - ������ȯ��)
      V_REAL_AMOUNT := V_TOTAL_RETR_AMOUNT - V_IN_TAX_AMOUNT - V_LOCAL_TAX_AMOUNT;
      IF V_REAL_AMOUNT < 0 THEN
        V_REAL_AMOUNT := 0;
      END IF;
      
------------------------------------------------------------------------------
-- 5. �� ������ ���.
      IF C1.HONORARY_AMOUNT > 0 THEN
        V_H_RETIRE_DATE_FR := C1.JOIN_DATE;
        V_H_RETIRE_DATE_TO := W_RETIRE_DATE_TO;
        
        --> 5.1 �ټӳ��
        BEGIN
          V_H_LONG_YEAR := HRM_COMMON_DATE_G.PERIOD_YEAR_F(V_H_RETIRE_DATE_FR, V_H_RETIRE_DATE_TO, 'CEIL');          
          IF V_H_RETIRE_DATE_FR = W_RETIRE_DATE_FR THEN
            V_H_PRE_LONG_YEAR := V_H_LONG_YEAR;
          ELSE
            V_H_PRE_LONG_YEAR := HRM_COMMON_DATE_G.PERIOD_YEAR_F(V_H_RETIRE_DATE_FR, W_RETIRE_DATE_FR - 1, 'CEIL');
          END IF;
        EXCEPTION WHEN OTHERS THEN
          O_MESSAGE := 'Honorary - Long Period Calculation Error : ' || SQLERRM;
          RETURN;
        END;

        --> �����ٷμҵ� ����
        V_H_INCOME_DED_AMOUNT := INCOME_SUBTRACT_F(V_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.HONORARY_AMOUNT);

        --> 5.3.1 �ټӿ� ���� �ҵ����(��ü �ټӿ� ���� �ݾ�).
        V_H_LONG_DED_YEAR_AMOUNT := LONG_DED_YEAR_F(V_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_LONG_YEAR);
        --> 5.3.2 �ټӺ��� �ߵ����� ���������� �ټ� �ҵ����.
        V_TEMP_AMOUNT := 0;
        V_TEMP_AMOUNT := LONG_DED_YEAR_F(V_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_PRE_LONG_YEAR);
        -- ���� �ټ� �ҵ�����ݾ�.
        V_H_LONG_DED_YEAR_AMOUNT := V_H_LONG_DED_YEAR_AMOUNT - V_TEMP_AMOUNT - V_LONG_DED_YEAR_AMOUNT;
        IF V_H_LONG_DED_YEAR_AMOUNT < 0 THEN
          V_H_LONG_DED_YEAR_AMOUNT := 0;
        END IF;
        
        --> ���� ǥ��
        V_H_TAX_STD_AMOUNT := C1.HONORARY_AMOUNT - V_H_INCOME_DED_AMOUNT - V_H_LONG_DED_YEAR_AMOUNT;
        IF V_H_TAX_STD_AMOUNT < 0 THEN
          V_H_TAX_STD_AMOUNT := 0;
        END IF;

        --> ����� ����ǥ��
        V_H_AVG_TAX_STD_AMOUNT := TRUNC(V_H_TAX_STD_AMOUNT / V_H_LONG_YEAR);

        --> ���⼼��
        V_H_AVG_COMP_TAX_AMOUNT := AVG_TAX_AMOUNT_F(V_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_AVG_TAX_STD_AMOUNT);

        --> ���⼼��
        V_H_COMP_TAX_AMOUNT := V_H_AVG_COMP_TAX_AMOUNT * V_H_LONG_YEAR;

        --> �ҵ漼�װ���
        V_H_TAX_DED_AMOUNT := TAX_SUBTRACT_F(V_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.RETIRE_DATE_TO, V_H_COMP_TAX_AMOUNT, V_H_LONG_YEAR);

        --> �ҵ漼
        V_H_IN_TAX_AMOUNT := TRUNC(V_H_COMP_TAX_AMOUNT - V_H_TAX_DED_AMOUNT, -1);   -- ������ ����
        IF V_H_IN_TAX_AMOUNT < 0 THEN
          V_H_IN_TAX_AMOUNT := 0;
        END IF;

        --> �ֹμ�
        V_H_LOCAL_TAX_AMOUNT := TRUNC(V_H_IN_TAX_AMOUNT * 0.1, -1);   -- ������ ����
        
        -- �����޾�.
        V_H_REAL_AMOUNT := C1.HONORARY_AMOUNT - V_H_IN_TAX_AMOUNT - V_H_LOCAL_TAX_AMOUNT;
        IF V_H_REAL_AMOUNT < 0 THEN
          V_H_REAL_AMOUNT := 0;
        END IF;
        
      END IF;
------------------------------------------------------------------------------      
      V_REAL_TOTAL_AMOUNT := V_REAL_AMOUNT + V_H_REAL_AMOUNT - C1.ETC_DED_AMOUNT - C1.RETIRE_CVS_AMOUNT;
      IF V_REAL_TOTAL_AMOUNT < 0 THEN
        V_REAL_TOTAL_AMOUNT := 0;
      END IF;

------------------------------------------------------------------------------
      --> ������ ����  --
      UPDATE HRR_RETIRE_ADJUSTMENT RA
        SET RA.RETIRE_AMOUNT          = V_RETR_AMOUNT
          , RA.RETIRE_TOTAL_AMOUNT    = V_TOTAL_RETR_AMOUNT
          , RA.INCOME_DED_AMOUNT      = V_INCOME_DED_AMOUNT
          , RA.LONG_DED_AMOUNT        = V_LONG_DED_YEAR_AMOUNT
          , RA.TAX_STD_AMOUNT         = V_TAX_STD_AMOUNT
          , RA.AVG_TAX_STD_AMOUNT     = V_AVG_TAX_STD_AMOUNT
          , RA.AVG_COMP_TAX_AMOUNT    = V_AVG_COMP_TAX_AMOUNT
          , RA.COMP_TAX_AMOUNT        = V_COMP_TAX_AMOUNT
          , RA.TAX_DED_AMOUNT         = V_TAX_DED_AMOUNT
          , RA.INCOME_TAX_AMOUNT      = V_IN_TAX_AMOUNT
          , RA.RESIDENT_TAX_AMOUNT    = V_LOCAL_TAX_AMOUNT
          , RA.REAL_AMOUNT            = V_REAL_AMOUNT
          , RA.H_RETIRE_DATE_FR       = V_H_RETIRE_DATE_FR
          , RA.H_RETIRE_DATE_TO       = V_H_RETIRE_DATE_TO
          , RA.H_LONG_YEAR            = V_H_LONG_YEAR
          , RA.H_INCOME_DED_AMOUNT    = V_H_INCOME_DED_AMOUNT
          , RA.H_LONG_DED_AMOUNT      = V_H_LONG_DED_YEAR_AMOUNT
          , RA.H_TAX_STD_AMOUNT       = V_H_TAX_STD_AMOUNT
          , RA.H_AVG_TAX_STD_AMOUNT   = V_H_AVG_TAX_STD_AMOUNT
          , RA.H_AVG_COMP_TAX_AMOUNT  = V_H_AVG_COMP_TAX_AMOUNT
          , RA.H_COMP_TAX_AMOUNT      = V_H_COMP_TAX_AMOUNT
          , RA.H_TAX_DED_AMOUNT       = V_H_TAX_DED_AMOUNT
          , RA.H_INCOME_TAX_AMOUNT    = V_H_IN_TAX_AMOUNT
          , RA.H_RESIDENT_TAX_AMOUNT  = V_H_LOCAL_TAX_AMOUNT
          , RA.H_REAL_AMOUNT          = V_H_REAL_AMOUNT
          , RA.REAL_TOTAL_AMOUNT      = V_REAL_TOTAL_AMOUNT
          , RA.LAST_UPDATE_DATE       = V_SYSDATE
          , RA.LAST_UPDATED_BY        = P_USER_ID
      WHERE RA.ADJUSTMENT_ID          = V_ADJUSTMENT_ID
      ;
    END LOOP C1;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END RETIRE_MAIN;

/*==========================================================================/
     ==> ������ ���
       -. P_DAY_AVG_AMOUNT : ����� �ݾ�
       -. P_TOTAL_DAY : �ѱټ��ϼ�
/==========================================================================*/
  FUNCTION RETR_AMOUNT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_DAY_AVG_AMOUNT          IN NUMBER
            , P_TOTAL_DAY               IN NUMBER            
            ) RETURN NUMBER
  AS
    V_RETR_AMOUNT                       NUMBER := 0;    -- ������

  BEGIN
    BEGIN
      SELECT NVL(P_DAY_AVG_AMOUNT, 0) * NVL(RS.MONTH_DAY, 0) * NVL(P_TOTAL_DAY, 0) / NVL(RS.YEAR_DAY, 365)
        INTO V_RETR_AMOUNT
        FROM HRR_RETIRE_STANDARD RS
      WHERE RS.STD_YYYY                 = W_STD_YYYY
        AND RS.SOB_ID                   = W_SOB_ID
        AND RS.ORG_ID                   = W_ORG_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      V_RETR_AMOUNT := 0;  
    END;
    
    --> ������ ��� (����ձݾ� * 30 * ���ϼ� / 365)
    V_RETR_AMOUNT := HRM_COMMON_G.DECIMAL_F(W_SOB_ID, W_ORG_ID, V_RETR_AMOUNT, 'RETIRE_AMOUNT');
    IF V_RETR_AMOUNT < 0 THEN
      V_RETR_AMOUNT := 0;
    END IF;
    RETURN V_RETR_AMOUNT;

  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('0.Retire Amount Cal Error : ' || SQLERRM);
    RETURN 0;
  END RETR_AMOUNT_F;

/*==========================================================================/
     ==> �����ҵ���� ��� -- 1
/==========================================================================*/
  FUNCTION  INCOME_SUBTRACT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_TOTAL_AMOUNT            IN NUMBER
            ) RETURN NUMBER
  AS
    V_SUBTRACT_AMOUNT                   NUMBER := 0;

  BEGIN
    BEGIN
      SELECT NVL(P_TOTAL_AMOUNT, 0) * (NVL(RS.INCOME_DEDUCTION_RATE, 0) / 100) AS INCOME_SUBTRACT
        INTO V_SUBTRACT_AMOUNT
        FROM HRR_RETIRE_STANDARD RS
      WHERE RS.STD_YYYY                 = W_STD_YYYY
        AND RS.SOB_ID                   = W_SOB_ID
        AND RS.ORG_ID                   = W_ORG_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      V_SUBTRACT_AMOUNT := 0;  
    END;
    
    --> ������ ��� (����ձݾ� * 30 * ���ϼ� / 365)
    V_SUBTRACT_AMOUNT := HRM_COMMON_G.DECIMAL_F(W_SOB_ID, W_ORG_ID, V_SUBTRACT_AMOUNT, 'RETIRE_AMOUNT');
    IF V_SUBTRACT_AMOUNT < 0 THEN
      V_SUBTRACT_AMOUNT := 0;
    END IF;
    RETURN V_SUBTRACT_AMOUNT;

  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('1.Income Subtract Cal Error : ' || SQLERRM);
    RETURN 0;
  END INCOME_SUBTRACT_F;

/*==========================================================================/
     ==> �����ټӳ���� ���� ������ ����  -- 2
/==========================================================================*/
  FUNCTION LONG_DED_YEAR_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_LONG_YEAR               IN NUMBER
            ) RETURN NUMBER
  AS
    V_SUBTRACT_AMOUNT                   NUMBER := 0;

  BEGIN
    BEGIN
      --> �ټӳ���� ���� ���� �ݾ�
      SELECT ((NVL(P_LONG_YEAR, 0) - NVL(CD.DED_YEAR, 0))* NVL(CD.DED_AMOUNT, 0)) + NVL(CD.DED_ADD_AMOUNT, 0) AS DED_YEAR
        INTO V_SUBTRACT_AMOUNT
      FROM HRR_CONTINUOUS_DEDUCTION CD
      WHERE CD.STD_YYYY           = W_STD_YYYY
        AND P_LONG_YEAR           BETWEEN CD.START_YEAR AND CD.END_YEAR
        AND CD.SOB_ID             = W_SOB_ID
        AND CD.ORG_ID             = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('2.1 Continuous Year Cal Error : ' || SQLERRM);
      RETURN 0;
    END;

    V_SUBTRACT_AMOUNT := HRM_COMMON_G.DECIMAL_F(W_SOB_ID, W_ORG_ID, V_SUBTRACT_AMOUNT, 'RETIRE_AMOUNT');
    IF V_SUBTRACT_AMOUNT < 0 THEN
      V_SUBTRACT_AMOUNT := 0;
    END IF;
--DBMS_OUTPUT.PUT_LINE('�ټӳ������=>' || V_SUBTRACT_AMT);
    RETURN V_SUBTRACT_AMOUNT;

  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('2.Continuous Year Cal Error : ' || SQLERRM);
    RETURN 0;
  END LONG_DED_YEAR_F;


/*==========================================================================/
     ==> ���⼼�� ���   - 5
/==========================================================================*/
  FUNCTION AVG_TAX_AMOUNT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_AVG_TAX_STD_AMOUNT      IN NUMBER
            ) RETURN NUMBER
  AS
    V_TAX_AMOUNT                        NUMBER := 0;

  BEGIN
    BEGIN
    --> ���⼼�� ��ȸ
      SELECT (NVL(P_AVG_TAX_STD_AMOUNT, 0) * (TR.TAX_RATE /  100)) - NVL(TR.ACCUM_SUB_AMOUNT, 0) AS TAX_AMOUNT
        INTO V_TAX_AMOUNT
        FROM HRA_TAX_RATE TR
          , HRM_COMMON HC
      WHERE TR.TAX_TYPE_ID      = HC.COMMON_ID
      AND TR.TAX_YYYY           = W_STD_YYYY
      AND TR.SOB_ID             = W_SOB_ID
      AND TR.ORG_ID             = W_ORG_ID
      AND HC.CODE               = '20'                               -- ��������.
      AND P_AVG_TAX_STD_AMOUNT  BETWEEN TR.START_AMOUNT AND TR.END_AMOUNT        
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('5.1 Tax Cal Error : ' || SQLERRM);
      RETURN 0;
    END;
--DBMS_OUTPUT.PUT_LINE('V_TAX_RATE -> ' || V_TAX_RATE || 'V_ACCU -> ' || V_ACCU);

    --> ���⼼�� ���
    V_TAX_AMOUNT := HRM_COMMON_G.DECIMAL_F(W_SOB_ID, W_ORG_ID, V_TAX_AMOUNT, 'RETIRE_AMOUNT');
    IF V_TAX_AMOUNT < 0 THEN
      V_TAX_AMOUNT := 0;
    END IF;
    RETURN V_TAX_AMOUNT;

  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('5.Tax Cal Error : ' || SQLERRM);
    RETURN 0;
  END AVG_TAX_AMOUNT_F;


/*==========================================================================/
     ==> �����ҵ���� ���  - 6
/==========================================================================*/
  FUNCTION TAX_SUBTRACT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_END_DATE                IN DATE
            , P_LONG_YEAR               IN NUMBER
            , P_TAX_AMOUNT              IN NUMBER
            ) RETURN NUMBER
  AS
    V_TAX_SUBTRACT_AMOUNT               NUMBER := 0;
    V_TAX_DEDUCTION_LMT_AMOUNT          NUMBER := 0;

  BEGIN
     --> �ʱ�ȭ
     V_TAX_SUBTRACT_AMOUNT := 0;

     IF P_END_DATE < TO_DATE('2003-01-01', 'YYYY-MM-DD') THEN
     --> 2003-01-01 ���� ����
       V_TAX_SUBTRACT_AMOUNT := P_TAX_AMOUNT * 0.5;

     ELSIF P_END_DATE BETWEEN TO_DATE('2003-01-01', 'YYYY-MM-DD') AND TO_DATE('2004-12-31', 'YYYY-MM-DD') THEN
     --> 2003-01-01  ~ 2004-12-31 ���� ����
       V_TAX_SUBTRACT_AMOUNT := P_TAX_AMOUNT * 0.25;

     ELSE
     --> 2005-01-01 ���� ����
       -- �������װ��� �ѵ� ���;
        BEGIN
          SELECT NVL(P_LONG_YEAR, 1) * NVL(RS.TAX_DEDUCTION_LMT, 0) AS TAX_DEDUCTION_LMT
            INTO V_TAX_DEDUCTION_LMT_AMOUNT
            FROM HRR_RETIRE_STANDARD RS
          WHERE RS.STD_YYYY       = W_STD_YYYY
            AND RS.SOB_ID         = W_SOB_ID
            AND RS.ORG_ID         = W_ORG_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          V_TAX_DEDUCTION_LMT_AMOUNT := 0;
          DBMS_OUTPUT.PUT_LINE('6.1Tax Deduction Limit Cal Error : ' || SQLERRM);
        END;

       -- �������װ����ݾ� ���;
        BEGIN
          SELECT NVL(P_TAX_AMOUNT, 0) * (RS.TAX_DEDUCTION_RATE / 100) AS TAX_DEDUCTION_LMT
            INTO V_TAX_SUBTRACT_AMOUNT
            FROM HRR_RETIRE_STANDARD RS
          WHERE RS.STD_YYYY       = W_STD_YYYY
            AND RS.SOB_ID         = W_SOB_ID
            AND RS.ORG_ID         = W_ORG_ID
          ;          
        EXCEPTION WHEN OTHERS THEN
          V_TAX_SUBTRACT_AMOUNT := 0;
          DBMS_OUTPUT.PUT_LINE('6.2Tax Deduction Limit Cal Error : ' || SQLERRM);
        END;

        -- �������װ����ݾ� �ѵ� üũ;
        IF V_TAX_DEDUCTION_LMT_AMOUNT < V_TAX_SUBTRACT_AMOUNT THEN
          V_TAX_SUBTRACT_AMOUNT := V_TAX_DEDUCTION_LMT_AMOUNT;
        END IF;
     END IF;

     V_TAX_SUBTRACT_AMOUNT := HRM_COMMON_G.DECIMAL_F(W_SOB_ID, W_ORG_ID, V_TAX_SUBTRACT_AMOUNT, 'RETIRE_AMOUNT');
     IF V_TAX_SUBTRACT_AMOUNT < 0 THEN
       V_TAX_SUBTRACT_AMOUNT := 0;
     END IF;
     RETURN V_TAX_SUBTRACT_AMOUNT;

  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('6.Tax Deduction Limit Cal Error : ' || SQLERRM);
    RETURN 0;
  END TAX_SUBTRACT_F;

END HRR_RETIRE_ADJUSTMENT_SET_G;
/
