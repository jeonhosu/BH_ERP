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
            , W_PAY_DATE_TO                       IN HRR_RETIRE_ADJUSTMENT.PAY_DATE_TO%TYPE
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
     ==> �������� ��� 
       -. 2012�⵵ ���� ���� 
       -. ������ �޿��� �ٽ� �����Ͽ� �ݿ�
       -. �󿩱��� �����޵� ������ �ݿ�
/==========================================================================*/
  PROCEDURE CAL_RETIRE_2012
            ( W_ADJUSTMENT_ID                     IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_ID%TYPE
            , W_RETR_YYYY                         IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_YYYY%TYPE
            , W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_TYPE%TYPE
            , W_RETIRE_DATE_FR                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_FR%TYPE
            , W_RETIRE_DATE_TO                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_TO%TYPE
            , W_PAY_DATE_TO                       IN HRR_RETIRE_ADJUSTMENT.PAY_DATE_TO%TYPE
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
     ==> �������� ��� 
       -. 2013�⵵ ���� ���� 
       -. ������ �޿��� �ٽ� �����Ͽ� �ݿ�
       -. �󿩱��� �����޵� ������ �ݿ�
/==========================================================================*/
  PROCEDURE CAL_RETIRE_2013
            ( W_ADJUSTMENT_ID                     IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_ID%TYPE
            , W_RETR_YYYY                         IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_YYYY%TYPE
            , W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_TYPE%TYPE
            , W_REAL_LONG_YEAR                    IN NUMBER 
            , W_RETIRE_DATE_FR                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_FR%TYPE
            , W_RETIRE_DATE_TO                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_TO%TYPE
            , W_PAY_DATE_TO                       IN HRR_RETIRE_ADJUSTMENT.PAY_DATE_TO%TYPE
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
            , W_PAY_DATE_TO                       IN HRR_RETIRE_ADJUSTMENT.PAY_DATE_TO%TYPE
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
    V_REAL_LONG_YEAR                              NUMBER := 0;    -- �Ǳټӳ��(1�� �̸����� ��� �޻󿩰�� ���ϱ� ����) 
  BEGIN
    O_STATUS := 'F';
    --> �����⵵ ���
    BEGIN
      V_RETR_YYYY := TO_CHAR(W_RETIRE_DATE_TO, 'YYYY');
    EXCEPTION WHEN OTHERS THEN
      V_RETR_YYYY := TO_CHAR(GET_LOCAL_DATE(W_SOB_ID), 'YYYY');
    END;

-- �ش� ������ �Ի�/������� ��ȸ -- 
    BEGIN
      SELECT HRM_COMMON_DATE_G.PERIOD_YEAR_F(PM.JOIN_DATE, (NVL(PM.RETIRE_DATE, W_RETIRE_DATE_TO) + 1), 'TRUNC') AS REAL_LONG_YEAR 
        INTO V_REAL_LONG_YEAR
        FROM HRM_PERSON_MASTER PM
       WHERE PM.PERSON_ID         = W_PERSON_ID
         AND PM.SOB_ID            = W_SOB_ID
         AND PM.ORG_ID            = W_ORG_ID 
       ;
    EXCEPTION
      WHEN OTHERS THEN
        V_REAL_LONG_YEAR := 0;
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
          , RETIRE_DATE_FR, RETIRE_DATE_TO, PAY_DATE_TO
          , COST_CENTER_ID
          , SOB_ID, ORG_ID
          , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
          , OFFICER_YN)
          ( SELECT HRR_RETIRE_ADJUSTMENT_S1.NEXTVAL
                , W_ADJUSTMENT_TYPE, V_RETR_YYYY, PM.PERSON_ID, PM.CORP_ID
                , TRUNC(W_RETIRE_DATE_FR), TRUNC(W_RETIRE_DATE_TO), TRUNC(W_PAY_DATE_TO)
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
    
    -- �⵵�� �����ݰ�� ���μ��� ���� ���� --
    IF V_RETR_YYYY < '2013' THEN
      -- 2012�⵵ ����. 
      CAL_RETIRE_2012
        ( W_ADJUSTMENT_ID        => V_ADJUSTMENT_ID 
        , W_RETR_YYYY            => V_RETR_YYYY 
        , W_ADJUSTMENT_TYPE      => W_ADJUSTMENT_TYPE
        , W_RETIRE_DATE_FR       => W_RETIRE_DATE_FR
        , W_RETIRE_DATE_TO       => W_RETIRE_DATE_TO
        , W_PAY_DATE_TO          => W_PAY_DATE_TO
        , W_RETIRE_CAL_TYPE      => W_RETIRE_CAL_TYPE
        , W_CORP_ID              => W_CORP_ID
        , W_PERSON_ID            => W_PERSON_ID
        , W_SOB_ID               => W_SOB_ID
        , W_ORG_ID               => W_ORG_ID
        , P_USER_ID              => P_USER_ID
        , O_STATUS               => O_STATUS
        , O_MESSAGE              => O_MESSAGE
        );
        
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;    
    ELSE
      -- 2013�⵵ ����.
      CAL_RETIRE_2013
        ( W_ADJUSTMENT_ID        => V_ADJUSTMENT_ID 
        , W_RETR_YYYY            => V_RETR_YYYY 
        , W_ADJUSTMENT_TYPE      => W_ADJUSTMENT_TYPE
        , W_REAL_LONG_YEAR       => V_REAL_LONG_YEAR
        , W_RETIRE_DATE_FR       => W_RETIRE_DATE_FR
        , W_RETIRE_DATE_TO       => W_RETIRE_DATE_TO
        , W_PAY_DATE_TO          => W_PAY_DATE_TO
        , W_RETIRE_CAL_TYPE      => W_RETIRE_CAL_TYPE
        , W_CORP_ID              => W_CORP_ID
        , W_PERSON_ID            => W_PERSON_ID
        , W_SOB_ID               => W_SOB_ID
        , W_ORG_ID               => W_ORG_ID
        , P_USER_ID              => P_USER_ID
        , O_STATUS               => O_STATUS
        , O_MESSAGE              => O_MESSAGE
        );
        
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
    END IF;    
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END RETIRE_MAIN;



/*==========================================================================/
     ==> �������� ��� 
       -. 2012�⵵ ���� ���� 
       -. ������ �޿��� �ٽ� �����Ͽ� �ݿ�
       -. �󿩱��� �����޵� ������ �ݿ�
/==========================================================================*/
  PROCEDURE CAL_RETIRE_2012
            ( W_ADJUSTMENT_ID                     IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_ID%TYPE
            , W_RETR_YYYY                         IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_YYYY%TYPE
            , W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_TYPE%TYPE
            , W_RETIRE_DATE_FR                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_FR%TYPE
            , W_RETIRE_DATE_TO                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_TO%TYPE
            , W_PAY_DATE_TO                       IN HRR_RETIRE_ADJUSTMENT.PAY_DATE_TO%TYPE
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
    V_RECORD_COUNT                                NUMBER := 0;
    
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
    
    --. �ſ� ���� ����� ��� 3���� ���� 1�� ���� �׿ܿ��� ADD_MONTHS(������, -3)
    V_3RD_DAY_COUNT  := HRM_COMMON_DATE_G.RETIRE_DATE_3RD_DAY(W_RETIRE_DATE_TO, W_SOB_ID, W_ORG_ID);
    V_3RD_DAY_COUNT2 := V_3RD_DAY_COUNT;

    --> �����ϼ� ����.
    BEGIN
      SELECT RA.DED_DAY * -1 AS DED_DAY
        INTO V_CHANGE_DAY
        FROM HRR_RETIRE_ADJUSTMENT RA
       WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CHANGE_DAY := 0;
    END;
    
    --> 1.3 �ټӳ��, �ټӿ���, �ټ��ϼ� ���
    BEGIN
      UPDATE HRR_RETIRE_ADJUSTMENT RA
        SET RA.LONG_YEAR = HRM_COMMON_DATE_G.PERIOD_YEAR_F(W_RETIRE_DATE_FR, (W_RETIRE_DATE_TO + NVL(V_CHANGE_DAY, 0)), 'CEIL')
          , RA.LONG_MONTH = HRM_COMMON_DATE_G.PERIOD_MONTH_F(W_RETIRE_DATE_FR, (W_RETIRE_DATE_TO + NVL(V_CHANGE_DAY, 0)), 'CEIL')
          , RA.LONG_DAY = HRM_COMMON_DATE_G.PERIOD_DAY_F(W_RETIRE_DATE_FR, (W_RETIRE_DATE_TO + NVL(V_CHANGE_DAY, 0)), 1)        
          , RA.DAY_3RD_COUNT      = V_3RD_DAY_COUNT
      WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Long Period Calculation Error : ' || SUBSTR(SQLERRM, 1, 150);
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
      RETURN;
    END;
    
--> 3���� �޿� ���-
    IF W_RETIRE_CAL_TYPE = 'NEW' THEN
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
                              , P_WAGE_TYPE => 'P1'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1�� �� �� ���-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
                              , P_WAGE_TYPE => 'P2'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1�� ������ �� ���-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
                              , P_WAGE_TYPE => 'P3'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1�� Ư���� �� ���-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
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
        WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Year Amount Calculation Error : ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
        ROLLBACK;
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
        WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Pay Calculation Error : ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
        ROLLBACK;
        RETURN;
      END;

       --> ����ձݾ� ����
       UPDATE HRR_RETIRE_ADJUSTMENT RA
         SET RA.DAY_AVG_AMOUNT = TRUNC((RA.TOTAL_PAY_AMOUNT / DECODE(V_3RD_DAY_COUNT, 0, 1, V_3RD_DAY_COUNT)) 
                                    + ((RA.TOTAL_BONUS_AMOUNT + RA.YEAR_ALLOWANCE_AMOUNT) / 4 / DECODE(V_3RD_DAY_COUNT2, 0, 1, V_3RD_DAY_COUNT2)))
       WHERE RA.ADJUSTMENT_ID     = W_ADJUSTMENT_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Day Avg Amount Error : ' || SQLERRM;      
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
    END;
    /*
    --> ��Ÿ����/��Ÿ���� UPDATE.
    BEGIN
      -- ��Ÿ����/���� UPDATE --
      UPDATE HRR_RETIRE_ADJUSTMENT RA
         SET (RA.ETC_SUPP_AMOUNT
            , RA.ETC_DED_AMOUNT
              ) =
              ( SELECT NVL(SUM(DECODE(EA.ALLOWANCE_TYPE, 'A', EA.ALLOWANCE_AMOUNT, 0)), 0) AS ETC_SUPP_AMOUNT
                     , NVL(SUM(DECODE(EA.ALLOWANCE_TYPE, 'D', EA.ALLOWANCE_AMOUNT, 0)), 0) AS ETC_DED_AMOUNT
                  FROM HRR_ETC_ALLOWANCE EA
                 WHERE EA.ADJUSTMENT_ID  = RA.ADJUSTMENT_ID
              )
       WHERE RA.ADJUSTMENT_ID       = W_ADJUSTMENT_ID
         AND EXISTS
               ( SELECT 'X'
                   FROM HRR_ETC_ALLOWANCE EA
                  WHERE EA.ADJUSTMENT_ID  = RA.ADJUSTMENT_ID
               )
       ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;*/
    
    --> ���������� ���� ���� ����
    FOR C1 IN (SELECT RA.RETIRE_DATE_FR
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
                 FROM HRR_RETIRE_ADJUSTMENT RA
                   , HRM_PERSON_MASTER PM
               WHERE RA.PERSON_ID          = PM.PERSON_ID
                 AND RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
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
      V_REAL_DAY := NVL(C1.LONG_DAY, 0);
      V_RETR_AMOUNT := NVL(RETR_AMOUNT_F(W_RETR_YYYY , W_SOB_ID, W_ORG_ID, C1.DAY_AVG_AMOUNT, V_REAL_DAY), 0);

      --> ��������
      V_TOTAL_RETR_AMOUNT := V_RETR_AMOUNT + NVL(C1.GLORY_AMOUNT, 0);

---------------------------------------------------------------------------------------------------
      --> �����ٷμҵ� ����
      V_INCOME_DED_AMOUNT := INCOME_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_TOTAL_RETR_AMOUNT);

      --> �ټӿ� ���� �ҵ����
      V_LONG_DED_YEAR_AMOUNT := LONG_DED_YEAR_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.LONG_YEAR);

      --> ���� ǥ��
      V_TAX_STD_AMOUNT := V_TOTAL_RETR_AMOUNT - V_INCOME_DED_AMOUNT - V_LONG_DED_YEAR_AMOUNT;
      IF V_TAX_STD_AMOUNT < 0 THEN
        V_TAX_STD_AMOUNT := 0;
      END IF;

      --> ����� ����ǥ��
      V_AVG_TAX_STD_AMOUNT := TRUNC(V_TAX_STD_AMOUNT / C1.LONG_YEAR);

      --> ���⼼��
      V_AVG_COMP_TAX_AMOUNT := AVG_TAX_AMOUNT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_AVG_TAX_STD_AMOUNT);

      --> ���⼼��
      V_COMP_TAX_AMOUNT := V_AVG_COMP_TAX_AMOUNT * C1.LONG_YEAR;

      --> �ҵ漼�װ���
      V_TAX_DED_AMOUNT := TAX_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.RETIRE_DATE_TO, V_COMP_TAX_AMOUNT, C1.LONG_YEAR);

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
        V_H_INCOME_DED_AMOUNT := INCOME_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.HONORARY_AMOUNT);

        --> 5.3.1 �ټӿ� ���� �ҵ����(��ü �ټӿ� ���� �ݾ�).
        V_H_LONG_DED_YEAR_AMOUNT := LONG_DED_YEAR_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_LONG_YEAR);
        --> 5.3.2 �ټӺ��� �ߵ����� ���������� �ټ� �ҵ����.
        V_TEMP_AMOUNT := 0;
        V_TEMP_AMOUNT := LONG_DED_YEAR_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_PRE_LONG_YEAR);
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
        V_H_AVG_COMP_TAX_AMOUNT := AVG_TAX_AMOUNT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_AVG_TAX_STD_AMOUNT);

        --> ���⼼��
        V_H_COMP_TAX_AMOUNT := V_H_AVG_COMP_TAX_AMOUNT * V_H_LONG_YEAR;

        --> �ҵ漼�װ���
        V_H_TAX_DED_AMOUNT := TAX_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.RETIRE_DATE_TO, V_H_COMP_TAX_AMOUNT, V_H_LONG_YEAR);

        --> �ҵ漼
        V_H_IN_TAX_AMOUNT := TRUNC(NVL(V_H_COMP_TAX_AMOUNT, 0) - NVL(V_H_TAX_DED_AMOUNT, 0), -1);   -- ������ ����
        IF V_H_IN_TAX_AMOUNT < 0 THEN
          V_H_IN_TAX_AMOUNT := 0;
        END IF;

        --> �ֹμ�
        V_H_LOCAL_TAX_AMOUNT := TRUNC(V_H_IN_TAX_AMOUNT * 0.1, -1);   -- ������ ����
        
        -- �����޾�.
        V_H_REAL_AMOUNT := NVL(C1.HONORARY_AMOUNT, 0) - NVL(V_H_IN_TAX_AMOUNT, 0) - NVL(V_H_LOCAL_TAX_AMOUNT, 0);
        IF V_H_REAL_AMOUNT < 0 THEN
          V_H_REAL_AMOUNT := 0;
        END IF;
        
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
          , RA.AVG_TAX_STD_AMOUNT_1   = V_AVG_TAX_STD_AMOUNT
          , RA.AVG_COMP_TAX_AMOUNT_1  = V_AVG_COMP_TAX_AMOUNT
          , RA.COMP_TAX_AMOUNT_1      = V_COMP_TAX_AMOUNT
          , RA.TAX_DED_AMOUNT_1       = V_TAX_DED_AMOUNT
          , RA.INCOME_TAX_AMOUNT_1    = V_IN_TAX_AMOUNT
          , RA.RESIDENT_TAX_AMOUNT_1  = V_LOCAL_TAX_AMOUNT
          , RA.AVG_TAX_STD_AMOUNT_2   = 0 
          , RA.AVG_COMP_TAX_AMOUNT_2  = 0 
          , RA.COMP_TAX_AMOUNT_2      = 0 
          , RA.TAX_DED_AMOUNT_2       = 0 
          , RA.INCOME_TAX_AMOUNT_2    = 0 
          , RA.RESIDENT_TAX_AMOUNT_2  = 0 
      WHERE RA.ADJUSTMENT_ID          = W_ADJUSTMENT_ID
      ;
    END LOOP C1;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END CAL_RETIRE_2012;            

/*==========================================================================/
     ==> �������� ��� 
       -. 2013�⵵ ���� ���� 
       -. ������ �޿��� �ٽ� �����Ͽ� �ݿ�
       -. �󿩱��� �����޵� ������ �ݿ�
/==========================================================================*/
  PROCEDURE CAL_RETIRE_2013
            ( W_ADJUSTMENT_ID                     IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_ID%TYPE
            , W_RETR_YYYY                         IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_YYYY%TYPE
            , W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_TYPE%TYPE
            , W_REAL_LONG_YEAR                    IN NUMBER 
            , W_RETIRE_DATE_FR                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_FR%TYPE
            , W_RETIRE_DATE_TO                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_TO%TYPE
            , W_PAY_DATE_TO                       IN HRR_RETIRE_ADJUSTMENT.PAY_DATE_TO%TYPE
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
    O_STATUS := 'F';
    
--. �ſ� ���� ����� ��� 3���� ���� 1�� ���� �׿ܿ��� ADD_MONTHS(������, -3)
    IF W_RETIRE_CAL_TYPE = 'NEW' THEN
      V_3RD_DAY_COUNT  := HRM_COMMON_DATE_G.RETIRE_DATE_3RD_DAY(W_RETIRE_DATE_TO, W_SOB_ID, W_ORG_ID);
      V_3RD_DAY_COUNT2 := V_3RD_DAY_COUNT;
    ELSE
      BEGIN
        SELECT RA.DAY_3RD_COUNT
          INTO V_3RD_DAY_COUNT
          FROM HRR_RETIRE_ADJUSTMENT RA
        WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_3RD_DAY_COUNT  := HRM_COMMON_DATE_G.RETIRE_DATE_3RD_DAY(W_RETIRE_DATE_TO, W_SOB_ID, W_ORG_ID);
      END;  
      V_3RD_DAY_COUNT2 := V_3RD_DAY_COUNT;
    END IF;
    
    --> �����ϼ� ����.
    BEGIN
      SELECT RA.DED_DAY * -1 AS DED_DAY
        INTO V_CHANGE_DAY
        FROM HRR_RETIRE_ADJUSTMENT RA
       WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CHANGE_DAY := 0;
    END;
    
    --> 1.3 �ټӳ��, �ټӿ���, �ټ��ϼ� ���  
    BEGIN
      UPDATE HRR_RETIRE_ADJUSTMENT RA
      SET RA.LONG_YEAR   = HRM_COMMON_DATE_G.PERIOD_YEAR_F(W_RETIRE_DATE_FR, (W_RETIRE_DATE_TO + NVL(V_CHANGE_DAY, 0)), 'CEIL')
        , RA.LONG_MONTH  = HRM_COMMON_DATE_G.PERIOD_MONTH_F(W_RETIRE_DATE_FR, (W_RETIRE_DATE_TO + NVL(V_CHANGE_DAY, 0)), 'CEIL')
        , RA.LONG_DAY    = HRM_COMMON_DATE_G.PERIOD_DAY_F(W_RETIRE_DATE_FR, (W_RETIRE_DATE_TO + NVL(V_CHANGE_DAY, 0)), 1)        
        , RA.DAY_3RD_COUNT = V_3RD_DAY_COUNT
      WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Long Period Calculation Error : ' || SUBSTR(SQLERRM, 1, 150);
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
      RETURN;
    END;
    
    --> 1.3.1 2012�⵵ ������ �ټӳ��, �ټӿ���, �ټ��ϼ� ���  
    V_TEMP_DATE := TO_DATE('2012-12-31', 'YYYY-MM-DD');
    IF W_RETIRE_DATE_FR <= V_TEMP_DATE THEN
      IF W_RETIRE_DATE_TO < V_TEMP_DATE THEN
        V_TEMP_DATE := W_RETIRE_DATE_TO;  
      END IF;    
      BEGIN
        UPDATE HRR_RETIRE_ADJUSTMENT RA
          SET RA.LONG_YEAR_1  = HRM_COMMON_DATE_G.PERIOD_YEAR_F(W_RETIRE_DATE_FR, V_TEMP_DATE, 'CEIL')
            , RA.LONG_MONTH_1 = HRM_COMMON_DATE_G.PERIOD_MONTH_F(W_RETIRE_DATE_FR, V_TEMP_DATE, 'CEIL')
            , RA.LONG_DAY_1   = HRM_COMMON_DATE_G.PERIOD_DAY_F(W_RETIRE_DATE_FR, V_TEMP_DATE, 1)        
        WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := '1.3.1 Long Period Calculation Error : ' || SUBSTR(SQLERRM, 1, 150);
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
        RETURN;
      END;
    END IF;
    
    --> 1.3.2 2013�⵵ ������ �ټӳ��, �ټӿ���, �ټ��ϼ� ���  
    V_TEMP_DATE := TO_DATE('2013-01-01', 'YYYY-MM-DD');
    IF V_TEMP_DATE <= W_RETIRE_DATE_FR THEN
      V_TEMP_DATE := W_RETIRE_DATE_FR; 
    END IF;      
    BEGIN
      UPDATE HRR_RETIRE_ADJUSTMENT RA
      SET RA.LONG_YEAR_2  = NVL(RA.LONG_YEAR, 0) - NVL(RA.LONG_YEAR_1 ,0) 
        , RA.LONG_MONTH_2 = HRM_COMMON_DATE_G.PERIOD_MONTH_F(V_TEMP_DATE, W_RETIRE_DATE_TO, 'CEIL')
        , RA.LONG_DAY_2   = HRM_COMMON_DATE_G.PERIOD_DAY_F(V_TEMP_DATE, W_RETIRE_DATE_TO, 1)        
      WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
      ;
      /* -- 2014.7.16 ��ȣ�� �ּ� -- 
      UPDATE HRR_RETIRE_ADJUSTMENT RA
      SET RA.LONG_YEAR_2 = HRM_COMMON_DATE_G.PERIOD_YEAR_F(V_TEMP_DATE, W_RETIRE_DATE_TO , 'CEIL')
        , RA.LONG_MONTH_2 = HRM_COMMON_DATE_G.PERIOD_MONTH_F(V_TEMP_DATE, W_RETIRE_DATE_TO, 'CEIL')
        , RA.LONG_DAY_2 = HRM_COMMON_DATE_G.PERIOD_DAY_F(V_TEMP_DATE, W_RETIRE_DATE_TO, 1)        
      WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
      ;*/
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := '1.3.2 Long Period Calculation Error : ' || SUBSTR(SQLERRM, 1, 150);
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
      RETURN;
    END;
    
--> 3���� �޿� ��� : 1�� �̸��ڵ� ���ǰ� ���� --
    IF W_RETIRE_CAL_TYPE = 'NEW' THEN
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
                              , P_WAGE_TYPE => 'P1'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1�� �� �� ���-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
                              , P_WAGE_TYPE => 'P2'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1�� ������ �� ���-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
                              , P_WAGE_TYPE => 'P3'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1�� Ư���� �� ���-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
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
        WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Year Amount Calculation Error : ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
        ROLLBACK;
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
        WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Pay Calculation Error : ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
        ROLLBACK;
        RETURN;
      END;

       --> ����ձݾ� ����
       UPDATE HRR_RETIRE_ADJUSTMENT RA
         SET RA.DAY_AVG_AMOUNT = TRUNC((RA.TOTAL_PAY_AMOUNT / DECODE(V_3RD_DAY_COUNT, 0, 1, V_3RD_DAY_COUNT)) 
                                    + ((RA.TOTAL_BONUS_AMOUNT + RA.YEAR_ALLOWANCE_AMOUNT) / 4 / DECODE(V_3RD_DAY_COUNT2, 0, 1, V_3RD_DAY_COUNT2)))
       WHERE RA.ADJUSTMENT_ID     = W_ADJUSTMENT_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Day Avg Amount Error : ' || SQLERRM;      
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
    END;
    /*
    --> ��Ÿ����/��Ÿ���� UPDATE.
    BEGIN
      -- ��Ÿ����/���� UPDATE --
      UPDATE HRR_RETIRE_ADJUSTMENT RA
         SET (RA.ETC_SUPP_AMOUNT
            , RA.ETC_DED_AMOUNT
              ) =
              ( SELECT NVL(SUM(DECODE(EA.ALLOWANCE_TYPE, 'A', EA.ALLOWANCE_AMOUNT, 0)), 0) AS ETC_SUPP_AMOUNT
                     , NVL(SUM(DECODE(EA.ALLOWANCE_TYPE, 'D', EA.ALLOWANCE_AMOUNT, 0)), 0) AS ETC_DED_AMOUNT
                  FROM HRR_ETC_ALLOWANCE EA
                 WHERE EA.ADJUSTMENT_ID  = RA.ADJUSTMENT_ID
              )
       WHERE RA.ADJUSTMENT_ID       = W_ADJUSTMENT_ID
         AND EXISTS
               ( SELECT 'X'
                   FROM HRR_ETC_ALLOWANCE EA
                  WHERE EA.ADJUSTMENT_ID  = RA.ADJUSTMENT_ID
               )
       ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;*/
    
    --> ���������� ���� ���� ����
    FOR C1 IN (SELECT RA.RETIRE_DATE_FR
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
                 AND RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
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

      V_H_RETIRE_DATE_FR                            := NULL;      -- ������ ���� ������.   
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
      V_REAL_DAY := NVL(C1.LONG_DAY, 0);
      V_RETR_AMOUNT := NVL(RETR_AMOUNT_F(W_RETR_YYYY , W_SOB_ID, W_ORG_ID, C1.DAY_AVG_AMOUNT, V_REAL_DAY), 0);

      --> ��������
      V_TOTAL_RETR_AMOUNT := V_RETR_AMOUNT + NVL(C1.GLORY_AMOUNT, 0) + NVL(C1.ETC_SUPP_AMOUNT, 0);

---------------------------------------------------------------------------------------------------
      --> �����ٷμҵ� ����
      V_INCOME_DED_AMOUNT := INCOME_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_TOTAL_RETR_AMOUNT);

      --> �ټӿ� ���� �ҵ����
      V_LONG_DED_YEAR_AMOUNT := LONG_DED_YEAR_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.LONG_YEAR);

      --> ���� ǥ��
      V_TAX_STD_AMOUNT := NVL(V_TOTAL_RETR_AMOUNT, 0) - NVL(V_INCOME_DED_AMOUNT, 0) - NVL(V_LONG_DED_YEAR_AMOUNT, 0);
      IF V_TAX_STD_AMOUNT < 0 THEN
        V_TAX_STD_AMOUNT := 0;
      END IF;
      
      --> ����ǥ�� �Ⱥ� 
      V_TAX_STD_AMOUNT_1 := TRUNC(V_TAX_STD_AMOUNT / (NVL(C1.LONG_YEAR_1, 0) + NVL(C1.LONG_YEAR_2, 0)) * NVL(C1.LONG_YEAR_1, 0));
      V_TAX_STD_AMOUNT_2 := V_TAX_STD_AMOUNT - V_TAX_STD_AMOUNT_1;
      IF V_TAX_STD_AMOUNT != V_TAX_STD_AMOUNT_1 + V_TAX_STD_AMOUNT_2 THEN
        O_STATUS := 'F';
        O_MESSAGE := 'Tax STD Division Amount Error : ' || SUBSTR(SQLERRM, 1, 150);       
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
            O_STATUS := 'F';
            O_MESSAGE := 'Avg Tax STD Amount Error : ' || SUBSTR(SQLERRM, 1, 150);       
            RETURN;
        END;

        --> ���⼼��
        V_AVG_COMP_TAX_AMOUNT_1 := AVG_TAX_AMOUNT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_AVG_TAX_STD_AMOUNT_1);

        --> ���⼼��
        V_COMP_TAX_AMOUNT_1 := TRUNC(V_AVG_COMP_TAX_AMOUNT_1 * C1.LONG_YEAR_1);

        --> �ҵ漼�װ���
        V_TAX_DED_AMOUNT_1 := TAX_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.RETIRE_DATE_TO, V_COMP_TAX_AMOUNT_1, C1.LONG_YEAR_1);

        --> �ҵ漼
        V_IN_TAX_AMOUNT_1 := TRUNC(NVL(V_COMP_TAX_AMOUNT_1, 0) - NVL(V_TAX_DED_AMOUNT_1, 0));   -- ������ ����
        IF V_IN_TAX_AMOUNT_1 < 0 THEN
          V_IN_TAX_AMOUNT_1 := 0;
        END IF;

        --> �ֹμ�
        V_LOCAL_TAX_AMOUNT_1 := TRUNC(V_IN_TAX_AMOUNT_1 * (TAX_RATE_F('RESIDENT', W_SOB_ID, W_ORG_ID) / 100));   -- ������ ����
      END IF;
      
      IF NVL(C1.LONG_YEAR_2, 0) > 0 THEN
        -- 2103�⵵ ���� ���� ��� --
        BEGIN
          --> ����� ����ǥ��(�������ڱ��� �ټӳ�� ����)  
          -- 13�⵵ ����ǥ�� �ݾ� ���� --
          --> (�Ⱥа���ǥ�� / �ټӿ���)  
          V_AVG_TAX_STD_AMOUNT_2 := TRUNC(NVL(V_TAX_STD_AMOUNT_2, 0) / NVL(C1.LONG_YEAR_2, 0));
        EXCEPTION 
          WHEN OTHERS THEN
            O_STATUS := 'F';
            O_MESSAGE := 'Avg Tax STD Amount Error : ' || SUBSTR(SQLERRM, 1, 150);       
            RETURN;
        END;
        
        --> ȯ�� ����ǥ��(����հ���ǥ�� * 5)  
        V_CHG_TAX_STD_AMOUNT_2 := V_AVG_TAX_STD_AMOUNT_2 * 5;
        
        --> ȯ����⼼��(ȯ�����ǥ�� * ����)  
        V_CHG_COMP_TAX_AMOUNT_2 := AVG_TAX_AMOUNT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_CHG_TAX_STD_AMOUNT_2);
        
        --> ����ջ��⼼��(ȯ����⼼�� / 5)
        V_AVG_COMP_TAX_AMOUNT_2 := TRUNC(V_CHG_COMP_TAX_AMOUNT_2 / 5);

        --> �ҵ漼�װ���
        V_TAX_DED_AMOUNT_2 := TAX_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.RETIRE_DATE_TO, V_AVG_COMP_TAX_AMOUNT_2, C1.LONG_YEAR_2);

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
        V_LOCAL_TAX_AMOUNT_2 := TRUNC(V_IN_TAX_AMOUNT_2 * (TAX_RATE_F('RESIDENT', W_SOB_ID, W_ORG_ID) / 100));   -- ������ ����
      END IF;
      
      -- �����޾� ��� -- 
      --> �����޾� (�������� - �ֹμ� - �ҵ漼 - ��Ÿ���� - ������ȯ��)
      V_REAL_AMOUNT := NVL(V_REAL_AMOUNT, 0) - TRUNC(NVL(V_IN_TAX_AMOUNT_1, 0) + NVL(V_IN_TAX_AMOUNT_2, 0), -1) 
                                             - TRUNC(NVL(V_LOCAL_TAX_AMOUNT_1, 0) + NVL(V_LOCAL_TAX_AMOUNT_2, 0), -1);
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
        V_H_INCOME_DED_AMOUNT := INCOME_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.HONORARY_AMOUNT);

        --> 5.3.1 �ټӿ� ���� �ҵ����(��ü �ټӿ� ���� �ݾ�).
        V_H_LONG_DED_YEAR_AMOUNT := LONG_DED_YEAR_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_LONG_YEAR);
        --> 5.3.2 �ټӺ��� �ߵ����� ���������� �ټ� �ҵ����.
        V_TEMP_AMOUNT := 0;
        V_TEMP_AMOUNT := LONG_DED_YEAR_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_PRE_LONG_YEAR);
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
        V_H_AVG_COMP_TAX_AMOUNT := AVG_TAX_AMOUNT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_AVG_TAX_STD_AMOUNT);

        --> ���⼼��
        V_H_COMP_TAX_AMOUNT := V_H_AVG_COMP_TAX_AMOUNT * V_H_LONG_YEAR;

        --> �ҵ漼�װ���
        V_H_TAX_DED_AMOUNT := TAX_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.RETIRE_DATE_TO, V_H_COMP_TAX_AMOUNT, V_H_LONG_YEAR);

        --> �ҵ漼
        V_H_IN_TAX_AMOUNT := TRUNC(NVL(V_H_COMP_TAX_AMOUNT, 0) - NVL(V_H_TAX_DED_AMOUNT, 0), -1);   -- ������ ����
        IF V_H_IN_TAX_AMOUNT < 0 THEN
          V_H_IN_TAX_AMOUNT := 0;
        END IF;

        --> �ֹμ�
        V_H_LOCAL_TAX_AMOUNT := TRUNC(V_H_IN_TAX_AMOUNT * 0.1, -1);   -- ������ ����
        
        -- �����޾�.
        V_H_REAL_AMOUNT := NVL(C1.HONORARY_AMOUNT, 0) - TRUNC(NVL(V_H_IN_TAX_AMOUNT, 0), -1) - TRUNC(NVL(V_H_LOCAL_TAX_AMOUNT, 0), -1);
        IF V_H_REAL_AMOUNT < 0 THEN
          V_H_REAL_AMOUNT := 0;
        END IF;
        
      END IF;
------------------------------------------------------------------------------      
      V_REAL_TOTAL_AMOUNT := NVL(V_REAL_AMOUNT, 0) + NVL(V_H_REAL_AMOUNT, 0) - 
                             NVL(C1.ETC_DED_AMOUNT, 0) - NVL(C1.HEALTH_INSUR_AMOUNT, 0) - 
                             NVL(C1.RETIRE_CVS_AMOUNT, 0);
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
          , RA.TAX_STD_AMOUNT_1       = V_TAX_STD_AMOUNT_1  -- ��ȣ�� �߰� 
          , RA.TAX_STD_AMOUNT_2       = V_TAX_STD_AMOUNT_2  -- ��ȣ�� �߰� 
          , RA.AVG_TAX_STD_AMOUNT     = (NVL(V_AVG_TAX_STD_AMOUNT_1, 0) + NVL(V_AVG_TAX_STD_AMOUNT_2, 0)) 
          , RA.AVG_COMP_TAX_AMOUNT    = (NVL(V_AVG_COMP_TAX_AMOUNT_1, 0) + NVL(V_AVG_COMP_TAX_AMOUNT_2, 0)) 
          , RA.COMP_TAX_AMOUNT        = (NVL(V_COMP_TAX_AMOUNT_1, 0) + NVL(V_COMP_TAX_AMOUNT_2, 0)) 
          , RA.TAX_DED_AMOUNT         = (NVL(V_TAX_DED_AMOUNT_1, 0) + NVL(V_TAX_DED_AMOUNT_2, 0)) 
          , RA.INCOME_TAX_AMOUNT      = (NVL(V_IN_TAX_AMOUNT_1, 0) + NVL(V_IN_TAX_AMOUNT_2, 0)) 
          , RA.RESIDENT_TAX_AMOUNT    = (NVL(V_LOCAL_TAX_AMOUNT_1, 0) + NVL(V_LOCAL_TAX_AMOUNT_2, 0)) 
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
      WHERE RA.ADJUSTMENT_ID          = W_ADJUSTMENT_ID
      ;
    END LOOP C1;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END CAL_RETIRE_2013;
            
            
            
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
    
    --V_SUBTRACT_AMOUNT := HRM_COMMON_G.DECIMAL_F(W_SOB_ID, W_ORG_ID, V_SUBTRACT_AMOUNT, 'RETIRE_AMOUNT');
    V_SUBTRACT_AMOUNT := ROUND(V_SUBTRACT_AMOUNT, 0);
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
