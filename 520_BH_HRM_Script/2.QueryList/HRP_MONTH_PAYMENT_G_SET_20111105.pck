CREATE OR REPLACE PACKAGE HRP_MONTH_PAYMENT_G
AS

-- ���޿� �ڷ� SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , W_PAY_YYYYMM                        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , W_DEPT_ID                           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , W_PAY_GRADE_ID                      IN HRP_MONTH_PAYMENT.PAY_GRADE_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            );
            
-- ���޿� �ڷ� SELECT
  PROCEDURE DATA_SELECT_SPREAD
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , W_PAY_YYYYMM                        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , W_DEPT_ID                           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , W_PAY_GRADE_ID                      IN HRP_MONTH_PAYMENT.PAY_GRADE_ID%TYPE
            , W_PAY_TYPE                          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_CONNECT_PERSON_ID                 IN NUMBER
            , W_SOB_ID                            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            );

-- ���޿� �ڷ� SELECT(�Ⱓ��)
  PROCEDURE SELECT_SPREAD_PERIOD
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , W_PAY_YYYYMM_FR                     IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_PAY_YYYYMM_TO                     IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , W_DEPT_ID                           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , W_PAY_GRADE_ID                      IN HRP_MONTH_PAYMENT.PAY_GRADE_ID%TYPE
            , W_PAY_TYPE                          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_CONNECT_PERSON_ID                 IN NUMBER
            , W_SOB_ID                            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            );


-- ���޿� �ڷ� ����.
  PROCEDURE MONTH_PAYMENT_INSERT
            ( P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE 
            );
            
-- ���޿� �ڷ� ����.
  PROCEDURE MONTH_PAYMENT_UPDATE
            ( W_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_DESCRIPTION       IN HRP_MONTH_PAYMENT.DESCRIPTION%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE 
            );
                          
---------------------------------------------------------------------------------------------------
-- �޻� ���޳��� ��ȸ / ���� / ����.
  PROCEDURE MONTH_ALLOWANCE_SELECT
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRP_MONTH_ALLOWANCE.CORP_ID%TYPE
            , W_PAY_YYYYMM                        IN HRP_MONTH_ALLOWANCE.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRP_MONTH_ALLOWANCE.WAGE_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_ALLOWANCE.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            );
            
-- ���޿� �����׸� INSERT
  PROCEDURE MONTH_ALLOWANCE_INSERT
            ( P_PERSON_ID        IN HRP_MONTH_ALLOWANCE.PERSON_ID%TYPE
            , P_PAY_YYYYMM       IN HRP_MONTH_ALLOWANCE.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE        IN HRP_MONTH_ALLOWANCE.WAGE_TYPE%TYPE
            , P_CORP_ID          IN HRP_MONTH_ALLOWANCE.CORP_ID%TYPE
            , P_ALLOWANCE_ID     IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT IN HRP_MONTH_ALLOWANCE.ALLOWANCE_AMOUNT%TYPE
            , P_MONTH_PAYMENT_ID IN HRP_MONTH_ALLOWANCE.MONTH_PAYMENT_ID%TYPE
            , P_SOB_ID           IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_ALLOWANCE.CREATED_BY%TYPE 
            );

-- ���޿� �����׸� UPDATE.
  PROCEDURE MONTH_ALLOWANCE_UPDATE
            ( W_MONTH_PAYMENT_ID IN HRP_MONTH_ALLOWANCE.MONTH_PAYMENT_ID%TYPE
            , W_ALLOWANCE_ID     IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT IN HRP_MONTH_ALLOWANCE.ALLOWANCE_AMOUNT%TYPE
            , W_SOB_ID           IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_ALLOWANCE.CREATED_BY%TYPE
            );

-- ���޿� �����׸� Delete.
  PROCEDURE MONTH_ALLOWANCE_DELETE
            ( W_MONTH_PAYMENT_ID IN HRP_MONTH_ALLOWANCE.MONTH_PAYMENT_ID%TYPE
            , W_ALLOWANCE_ID     IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , W_SOB_ID           IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- �޻� �������� ��ȸ / ���� / ����.
  PROCEDURE MONTH_DEDUCTION_SELECT
            ( P_CURSOR2                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , W_PAY_YYYYMM                        IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            );
            
-- ���޿� �����׸� INSERT
  PROCEDURE MONTH_DEDUCTION_INSERT
            ( P_PERSON_ID        IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , P_PAY_YYYYMM       IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE        IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , P_CORP_ID          IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , P_DEDUCTION_ID     IN HRP_MONTH_DEDUCTION.DEDUCTION_ID%TYPE
            , P_DEDUCTION_AMOUNT IN HRP_MONTH_DEDUCTION.DEDUCTION_AMOUNT%TYPE
            , P_MONTH_PAYMENT_ID IN HRP_MONTH_DEDUCTION.MONTH_PAYMENT_ID%TYPE
            , P_SOB_ID           IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_DEDUCTION.CREATED_BY%TYPE 
            );

-- ���޿� �����׸� UPDATE.
  PROCEDURE MONTH_DEDUCTION_UPDATE
            ( W_MONTH_PAYMENT_ID IN HRP_MONTH_DEDUCTION.MONTH_PAYMENT_ID%TYPE
            , W_DEDUCTION_ID     IN HRP_MONTH_DEDUCTION.DEDUCTION_ID%TYPE
            , P_DEDUCTION_AMOUNT IN HRP_MONTH_DEDUCTION.DEDUCTION_AMOUNT%TYPE
            , W_SOB_ID           IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_DEDUCTION.CREATED_BY%TYPE
            );

-- ���޿� �����׸� Delete.
  PROCEDURE MONTH_DEDUCTION_DELETE
            ( W_MONTH_PAYMENT_ID IN HRP_MONTH_DEDUCTION.MONTH_PAYMENT_ID%TYPE
            , W_DEDUCTION_ID     IN HRP_MONTH_DEDUCTION.DEDUCTION_ID%TYPE
            , W_SOB_ID           IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            );       

-- ���� �ٽ� ���.
  PROCEDURE TAX_UPDATE
            ( P_PAY_YYYYMM       IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE        IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , P_CORP_ID          IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , P_PERSON_ID        IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , P_SOB_ID           IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_DEDUCTION.CREATED_BY%TYPE 
            );
            
-- ����/���� �հ� ó��.
  PROCEDURE PAYMENT_SUMMARY_UPDATE
            ( P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            );
            
END HRP_MONTH_PAYMENT_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRP_MONTH_PAYMENT_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRP_MONTH_PAYMENT_G
/* DESCRIPTION  : �޻� ���� ����.
/* REFERENCE BY :
/* PROGRAM HISTORY : �ű� ����
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- MONTH PAYMEHNT SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , W_PAY_YYYYMM                        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , W_DEPT_ID                           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , W_PAY_GRADE_ID                      IN HRP_MONTH_PAYMENT.PAY_GRADE_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT MP.PAY_YYYYMM
           , HRM_DEPT_MASTER_G.DEPT_NAME_F(MP.DEPT_ID) AS DEPT_NAME
           , HRM_COMMON_G.ID_NAME_F(MP.POST_ID) AS POST_NAME
           , HRM_COMMON_G.ID_NAME_F(MP.PAY_GRADE_ID) AS PAY_GRADE_NAME
           , MP.WAGE_TYPE
           , HRM_COMMON_G.CODE_NAME_F('CLOSING_TYPE', MP.WAGE_TYPE, MP.SOB_ID, MP.ORG_ID) AS WAGE_TYPE_NAME
           , PM.DISPLAY_NAME AS NAME
           , PM.PERSON_NUM           
           , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', MP.PAY_TYPE, MP.SOB_ID, MP.ORG_ID) AS PAY_TYPE_NAME
           , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', MP.EMPLOYE_TYPE, MP.SOB_ID, MP.ORG_ID) AS EMPLOYE_TYPE_NAME
           , PM.ORI_JOIN_DATE
           , PM.JOIN_DATE
           , PM.PAY_DATE           
           , PM.RETIRE_DATE
           , MP.EXCEPT_TYPE
           , MP.SUPPLY_DATE
           , MP.STANDARD_DATE
           , MP.PAY_DAY
           , MP.DED_PERSON_COUNT
           , NVL(SX1.BASE_AMOUNT, 0) AS BASE_AMOUNT
           , NVL(MP.GENERAL_HOURLY_AMOUNT, 0) AS GENERAL_HOURLY_AMOUNT
           , MP.PAY_AMOUNT
           , MP.DED_PAY_AMOUNT
           , MP.BONUS_AMOUNT
           , MP.DED_BONUS_AMOUNT
           , MP.TOT_SUPPLY_AMOUNT
           , MP.TOT_DED_AMOUNT
           , MP.REAL_AMOUNT
           , MP.DESCRIPTION 
           , MP.SOB_ID
           , MP.ORG_ID
           , MP.PERSON_ID
           , MP.MONTH_PAYMENT_ID
           , PM.CORP_ID
           , EAPP_USER_G.USER_NAME_F(MP.LAST_UPDATED_BY) AS LAST_UPDATE_PERSON
        FROM HRP_MONTH_PAYMENT MP
          , HRM_PERSON_MASTER PM
          , ( SELECT PMH.PERSON_ID
                   , PMH.SOB_ID
                   , PMH.ORG_ID
                   , PML.ALLOWANCE_AMOUNT AS BASE_AMOUNT
                FROM HRP_PAY_MASTER_HEADER PMH
                  , HRP_PAY_MASTER_LINE PML
                  , HRM_ALLOWANCE_V HA
              WHERE PMH.PAY_HEADER_ID   = PML.PAY_HEADER_ID 
                AND PML.ALLOWANCE_ID    = HA.ALLOWANCE_ID
                AND PMH.START_YYYYMM    <= W_PAY_YYYYMM
                AND PMH.END_YYYYMM      >= W_PAY_YYYYMM
                AND PMH.CORP_ID         = W_CORP_ID
                AND PMH.PERSON_ID       = NVL(W_PERSON_ID, PMH.PERSON_ID)
                AND PMH.SOB_ID          = W_SOB_ID
                AND PMH.ORG_ID          = W_ORG_ID
                AND HA.ALLOWANCE_CODE   = 'A01'  -- �⺻��.
             ) SX1
      WHERE PM.PERSON_ID        = MP.PERSON_ID
        AND MP.PERSON_ID        = SX1.PERSON_ID(+)
        AND MP.CORP_ID          = W_CORP_ID
        AND MP.PAY_YYYYMM       = W_PAY_YYYYMM
        AND MP.WAGE_TYPE        = W_WAGE_TYPE
        AND MP.PERSON_ID        = NVL(W_PERSON_ID, MP.PERSON_ID)
        AND MP.DEPT_ID          = NVL(W_DEPT_ID, MP.DEPT_ID)
        AND MP.PAY_GRADE_ID     = NVL(W_PAY_GRADE_ID, MP.PAY_GRADE_ID)
        AND MP.SOB_ID           = W_SOB_ID
        AND MP.ORG_ID           = W_ORG_ID
      ORDER BY MP.DEPT_ID, MP.POST_ID, MP.PERSON_ID
      ;

  END DATA_SELECT;

-- ���޿� �ڷ� SELECT
  PROCEDURE DATA_SELECT_SPREAD
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , W_PAY_YYYYMM                        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , W_DEPT_ID                           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , W_PAY_GRADE_ID                      IN HRP_MONTH_PAYMENT.PAY_GRADE_ID%TYPE
            , W_PAY_TYPE                          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_CONNECT_PERSON_ID                 IN NUMBER
            , W_SOB_ID                            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            )
  AS
    V_DUTY_TYPE                   VARCHAR2(10);
    V_START_DATE                  DATE;
    V_END_DATE                    DATE;
    
  BEGIN
    V_DUTY_TYPE := 'D2';
    HRP_PAYMENT_G_SET.PAYMENT_TERM
                      ( W_PAY_YYYYMM => W_PAY_YYYYMM
                      , W_WAGE_TYPE => W_WAGE_TYPE
                      , W_PAY_TYPE => '1'
                      , W_SOB_ID => W_SOB_ID
                      , W_ORG_ID => W_ORG_ID
                      , O_START_DATE => V_START_DATE
                      , O_END_DATE => V_END_DATE
                      );
                      
    OPEN P_CURSOR1 FOR
      SELECT  CASE
               WHEN GROUPING(DM.DEPT_CODE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL)
               WHEN GROUPING(PM.NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10217', NULL)
               ELSE PM.NAME
             END AS NAME
          , CASE
               WHEN GROUPING(DM.DEPT_CODE) = 1 THEN TO_CHAR(COUNT(MP.PERSON_ID)) || '��'
               WHEN GROUPING(PM.NAME) = 1 THEN TO_CHAR(COUNT(MP.PERSON_ID)) || '��'
               ELSE PM.PERSON_NUM
             END AS PERSON_NUM
           , MP.PAY_YYYYMM
           , MP.WAGE_TYPE
           , HRM_COMMON_G.CODE_NAME_F('CLOSING_TYPE', MP.WAGE_TYPE, MP.SOB_ID, MP.ORG_ID) AS WAGE_TYPE_NAME           
           , DECODE(GROUPING(PM.NAME), 1, TO_CHAR(NULL), DM.DEPT_CODE) AS DEPT_CODE
           , DECODE(GROUPING(PM.NAME), 1, TO_CHAR(NULL), DM.DEPT_NAME) AS DEPT_NAME
           , PC.POST_NAME AS POST_NAME
           , MP.PAY_TYPE
           , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', MP.PAY_TYPE, MP.SOB_ID, MP.ORG_ID) AS PAY_TYPE_NAME
           , HRM_COMMON_G.ID_NAME_F(MP.PAY_GRADE_ID) AS PAY_GRADE_NAME
           , TO_CHAR(PM.ORI_JOIN_DATE, 'YYYY-MM-DD') AS ORI_JOIN_DATE
           , TO_CHAR(PM.JOIN_DATE, 'YYYY-MM-DD') AS JOIN_DATE
           , TO_CHAR(PM.PAY_DATE, 'YYYY-MM-DD') AS PAY_DATE
           , TO_CHAR(PM.RETIRE_DATE, 'YYYY-MM-DD') AS RETIRE_DATE
           , TO_CHAR(MP.SUPPLY_DATE, 'YYYY-MM-DD') AS SUPPLY_DATE
           , TO_CHAR(MP.STANDARD_DATE, 'YYYY-MM-DD') AS STANDARD_DATE
           , TO_CHAR(MP.PAY_RATE) AS PAY_RATE
           , TO_CHAR(MP.GRADE_STEP) AS GRADE_STEP
           , TO_CHAR(MP.LONG_YEAR) AS LONG_YEAR
           , SUM(/*CASE 
                  WHEN MP.PAY_TYPE IN('1', '3') THEN */HRP_PAYMENT_G_SET.BASIC_AMOUNT_F(MP.PAY_YYYYMM, MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID)
                  /*ELSE 0
                 END*/) AS BAISC_AMOUNT
           , SUM(CASE 
                  WHEN MP.PAY_TYPE IN('2') THEN HRP_PAYMENT_G_SET.BASIC_AMOUNT_F(MP.PAY_YYYYMM, MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID)
                  ELSE 0
                 END) AS BAISC_DAILY_AMOUNT
           , SUM(CASE 
                  WHEN MP.PAY_TYPE IN('4') THEN HRP_PAYMENT_G_SET.BASIC_AMOUNT_F(MP.PAY_YYYYMM, MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID)
                  ELSE 0
                 END) AS BAISC_TIME_AMOUNT
           , SUM(MP.GENERAL_HOURLY_AMOUNT) AS GENERAL_HOURLY_PAY_AMOUNT
           , SUM(MA.A01) AS A01               -- �⺻��.
           , SUM(MA.A02) AS A02               -- ��å����.
           , SUM(MA.A03) AS A03               -- �ټӼ���.
           , 0 /*SUM(MA.A04)*/ AS A04               -- ����������.
           , SUM(MA.A05) AS A05               -- ���X
           , SUM(MA.A06) AS A06               -- �ڰݼ���.
           , SUM(NVL(MA.A07, 0) + NVL(MA.A04, 0) + NVL(MA.A16, 0) + NVL(MA.A24, 0)) AS A07               -- ��Ÿ����.
           , SUM(MA.A08) AS A08               -- ��������.
           , SUM(MA.A09) AS A09               -- �󿩱�.
           , SUM(MA.A10) AS A10               -- �����ұ޺�.
           , SUM(MA.A11) AS A11               -- �ð��ܼ���.
           , SUM(MA.A12) AS A12               -- ����ٷμ���.
           , SUM(MA.A13) AS A13               -- �߰��ٷμ���.
           , SUM(NVL(MA.A14, 0) + NVL(MA.A28, 0) + NVL(MA.A35, 0)) AS A14 -- Ư�ټ���(Ư�ټ��� + ���ޱٹ����� + ������Ư��).
           , SUM(MA.A15) AS A15               -- �ؿ������.
           , 0 /*SUM(MA.A16)*/ AS A16               -- Ư����.
           , SUM(MA.A17) AS A17               -- ������������.
           , SUM(MA.A18) AS A18               -- ��������.
           , SUM(MA.A19) AS A19               -- ���X
           , SUM(MA.A20) AS A20               -- ���X
           , SUM(MA.A21) AS A21               -- ���X
           , SUM(MA.A22) AS A22               -- ��ٰ���.
           , SUM(MA.A23) AS A23               -- ���X
           , 0 /*SUM(MA.A24)*/ AS A24               -- �ڱⰳ�߼���.
           , SUM(MA.A25) AS A25               -- ����������.
           , SUM(MA.A26) AS A26               -- ���X.
           , SUM(MA.A27) AS A27               -- ���X
           , 0 /*SUM(MA.A28)*/ AS A28               -- ���ޱٹ��ݷ���.
           , SUM(MA.A29) AS A29               -- ���X
           , SUM(MA.A30) AS A30               -- ���X
           , SUM(MA.A31) AS A31  -- ��������.
           , SUM(MA.A32) AS A32               -- �߰��������.
           , SUM(MA.A33) AS A33               -- ���ټ���.
           , SUM(MA.A34) AS A34
           , 0 /*SUM(MA.A35)*/ AS A35
           , SUM(MA.A36) AS A36
           , SUM(MA.A37) AS A37
           , SUM(MA.A38) AS A38
           , SUM(MA.A39) AS A39
           , SUM(MP.TOT_SUPPLY_AMOUNT) AS TOT_SUPPLY_AMOUNT
           -- ���� �׸�.
           , SUM(MD.D01) AS D01                -- �ҵ漼.
           , SUM(MD.D02) AS D02                -- �ֹμ�.
           , SUM(MD.D03) AS D03                -- ���ο���.
           , SUM(MD.D04) AS D04                -- ��뺸��.
           , SUM(MD.D05) AS D05                -- �ǰ�����.
           , SUM(MD.D06) AS D06                -- ����纸��.
           , SUM(MD.D07) AS D07                -- �ǰ����������.
           , SUM(MD.D08) AS D08                -- ���ο��������.
           , SUM(MD.D09) AS D09                -- ����纸�������.
           , SUM(MD.D10) AS D10                -- ���������.
           , SUM(MD.D11) AS D11                -- �Ǻ���.
           , SUM(MD.D12) AS D12                -- ������߱޺�.
           , SUM(MD.D13) AS D13                -- ������.
           , SUM(MD.D14) AS D14                -- ��Ÿ����
           , SUM(MD.D15) AS D15                -- ����ҵ漼.
           , SUM(MD.D16) AS D16                -- �����ֹμ�.
           , SUM(MD.D17) AS D17                -- �����Ư��.
           , SUM(MD.D18) AS D18                --  
           , SUM(MD.D19) AS D19                -- 
           , SUM(MD.D20) AS D20                -- 
           , SUM(MD.D21) AS D21                -- �ſ뺸�������.
           , SUM(MD.D22) AS D22
           , SUM(MD.D23) AS D23
           , SUM(MD.D24) AS D24
           , SUM(MD.D25) AS D25
           , SUM(MD.D26) AS D26
           , SUM(MD.D27) AS D27
           , SUM(MD.D28) AS D28
           , SUM(MD.D29) AS D29
           , SUM(MP.TOT_DED_AMOUNT) AS TOT_DED_AMOUNT 
           , SUM(MP.REAL_AMOUNT) AS REAL_AMOUNT
           /*-- ��� ����.
           , SUM(DX1.TOTAL_ATT_DAY) AS TOTAL_ATT_DAY              -- ����ٹ�.
           , SUM(DX1.DUTY_30) AS DUTY_30                          -- ����.
           , SUM(DX1.S_HOLY_1_COUNT) AS S_HOLY_1_COUNT            -- ����.
           , SUM(DX1.HOLY_1_COUNT) AS HOLY_1_COUNT                -- ����.
           , SUM(DX1.HOLY_0_COUNT) AS HOLY_0_COUNT                -- ����.
           , SUM(DX1.TOT_DED_COUNT) AS TOT_DED_COUNT              -- �̱ٹ�.
           , SUM(DX1.WEEKLY_DED_COUNT) AS WEEKLY_DED_COUNT        -- ������.
           , SUM(CASE 
                   WHEN MP.PAY_TYPE IN('1', '3') THEN 0
                   ELSE DX1.LATE_TIME 
                 END) AS LATE_TIME                      -- ���°���(����/����).
           , SUM(DX1.OVER_TIME) AS OVER_TIME                      -- ����.
           , SUM(DX1.NIGHT_BONUS_TIME) AS NIGHT_BONUS_TIME        -- �߰�.
           , SUM(CASE 
                   WHEN MP.PAY_TYPE IN('1', '3') THEN 0
                   ELSE DX1.HOLY_1_TIME
                 END) AS HOLY_1_TIME                  -- ���� �ٹ�.
           , SUM(CASE 
                   WHEN MP.PAY_TYPE IN('1', '3') THEN 0
                   ELSE DX1.HOLY_1_OT 
                 END) AS HOLY_1_OT                      -- ���� ����.
           , SUM(CASE 
                   WHEN MP.PAY_TYPE IN('1', '3') THEN 0
                   ELSE DX1.HOLY_1_NIGHT 
                 END) AS HOLY_1_NIGHT                -- ���� �߰�.*/
        FROM HRP_MONTH_PAYMENT MP
          , HRM_DEPT_MASTER DM
          , HRM_POST_CODE_V PC
          , HRM_PERSON_MASTER PM
          , (-- ���� �λ系��.
							SELECT HL.PERSON_ID
									, HL.DEPT_ID
									, HL.POST_ID
									, HL.JOB_CATEGORY_ID
									, HL.FLOOR_ID
								FROM HRM_HISTORY_LINE HL
							WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
																							FROM HRM_HISTORY_LINE S_HL
																						 WHERE S_HL.CHARGE_DATE            <= V_END_DATE
																							 AND S_HL.PERSON_ID              = HL.PERSON_ID
																						 GROUP BY S_HL.PERSON_ID
																					 )
							) T1
          , HRM_FLOOR_V HF
          , HRP_MONTH_ALLOWANCE_V MA
          , HRP_MONTH_DEDUCTION_V MD
          , (SELECT MT.PERSON_ID
                 , MT.TOTAL_ATT_DAY      -- ����ٹ�.
                 , MTD.DUTY_30 AS DUTY_30   -- ����.
                 , HRD_WORK_CALENDAR_G.HOLY_1_COUNT_F(MT.PERSON_ID,V_START_DATE, V_END_DATE, MT.SOB_ID, MT.ORG_ID) AS S_HOLY_1_COUNT   -- ����.
                 , HRD_HOLIDAY_CALENDAR_G.HOLIDAY_COUNT(V_START_DATE, V_END_DATE, MT.PERSON_ID, MT.SOB_ID, MT.ORG_ID) AS HOLY_1_COUNT   -- ����.
                 , MT.HOLY_0_COUNT                                    -- ����.
                 , MT.LATE_DED_COUNT                                  -- ���°��� Ƚ��.
                 , NVL(MT.TOTAL_DED_DAY, 0) - NVL(MT.WEEKLY_DED_COUNT, 0) AS TOT_DED_COUNT               -- �̱ٹ�.
                 , MT.WEEKLY_DED_COUNT                                                                   -- ������.
                 , NVL(MTO.LEAVE_TIME, 0) + NVL(MTO.LATE_TIME, 0) AS LATE_TIME  -- ���°���(����/����).
                 , CASE
                     WHEN JCC.JOB_CATEGORY_CODE IN('10') THEN NVL(MTO.OVER_TIME, 0)
                     ELSE NVL(MTO.REST_TIME, 0) + NVL(MTO.OVER_TIME, 0) + NVL(MTO.NIGHT_TIME, 0)
                   END AS OVER_TIME   -- ����.
                 , CASE
                     WHEN JCC.JOB_CATEGORY_CODE IN('10') THEN NVL(MTO.NIGHT_TIME, 0)
                     ELSE NVL(MTO.NIGHT_BONUS_TIME, 0)
                   END AS NIGHT_BONUS_TIME   -- �߰�.
                 , CASE
                     WHEN JCC.JOB_CATEGORY_CODE IN('10') THEN 0
                     ELSE NVL(MTO.HOLIDAY_TIME, 0)
                   END AS HOLY_1_TIME            -- ���� �ٹ�.
                 , CASE
                     WHEN JCC.JOB_CATEGORY_CODE IN('10') THEN 0
                     ELSE NVL(MTO.HOLYDAY_OT_TIME, 0)
                   END AS HOLY_1_OT                 -- ���� ����.
                 , 0 AS HOLY_1_NIGHT           -- ���� �߰�.
              FROM HRD_MONTH_TOTAL MT
                , HRM_JOB_CATEGORY_CODE_V JCC
                , HRD_MONTH_TOTAL_OT_V MTO
                , HRD_MONTH_TOTAL_DUTY_V MTD
            WHERE MT.JOB_CATEGORY_ID         = JCC.JOB_CATEGORY_ID
              AND MT.MONTH_TOTAL_ID           = MTO.MONTH_TOTAL_ID(+)
              AND MT.MONTH_TOTAL_ID           = MTD.MONTH_TOTAL_ID(+)
              AND MT.DUTY_TYPE               = V_DUTY_TYPE
              AND MT.DUTY_YYYYMM             = W_PAY_YYYYMM
              AND MT.PERSON_ID               = NVL(W_PERSON_ID, MT.PERSON_ID)
              AND MT.CORP_ID                 = W_CORP_ID
              AND MT.SOB_ID                  = W_SOB_ID
              AND MT.ORG_ID                  = W_ORG_ID
            ) DX1
       WHERE MP.DEPT_ID                 = DM.DEPT_ID
         AND MP.POST_ID                 = PC.POST_ID
         AND MP.PERSON_ID               = PM.PERSON_ID
         AND PM.PERSON_ID               = T1.PERSON_ID
         AND T1.FLOOR_ID                = HF.FLOOR_ID(+)
         AND MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID(+)
         AND MP.MONTH_PAYMENT_ID        = MD.MONTH_PAYMENT_ID(+)
         AND MP.PERSON_ID               = DX1.PERSON_ID(+)
         AND MP.PERSON_ID               = NVL(W_PERSON_ID, MP.PERSON_ID)
         AND MP.PAY_YYYYMM              = W_PAY_YYYYMM
         AND MP.WAGE_TYPE               = NVL(W_WAGE_TYPE, MP.WAGE_TYPE)
         AND MP.CORP_ID                 = W_CORP_ID
         AND MP.DEPT_ID                 = NVL(W_DEPT_ID, MP.DEPT_ID)
         AND MP.PAY_GRADE_ID            = NVL(W_PAY_GRADE_ID, MP.PAY_GRADE_ID)
         AND MP.PAY_TYPE                = NVL(W_PAY_TYPE, MP.PAY_TYPE)
         AND MP.SOB_ID                  = W_SOB_ID
         AND MP.ORG_ID                  = W_ORG_ID 
         AND (MP.TOT_SUPPLY_AMOUNT      <> 0
           OR MP.TOT_DED_AMOUNT         <> 0)
      GROUP BY ROLLUP ((DM.DEPT_SORT_NUM
           , DM.DEPT_CODE
           , DM.DEPT_NAME)
           , (PC.SORT_NUM
           , PC.POST_CODE
           , PC.POST_NAME
           , PM.PERSON_NUM
           , PM.NAME           
           , MP.PAY_YYYYMM
           , MP.WAGE_TYPE
           , HRM_COMMON_G.CODE_NAME_F('CLOSING_TYPE', MP.WAGE_TYPE, MP.SOB_ID, MP.ORG_ID)
           , MP.PAY_TYPE
           , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', MP.PAY_TYPE, MP.SOB_ID, MP.ORG_ID)
           , HRM_COMMON_G.ID_NAME_F(MP.PAY_GRADE_ID)
           , PM.ORI_JOIN_DATE
           , PM.JOIN_DATE
           , PM.PAY_DATE
           , PM.RETIRE_DATE
           , MP.DIR_INDIR_TYPE
           , MP.SUPPLY_DATE
           , MP.STANDARD_DATE
           , MP.PAY_RATE
           , MP.GRADE_STEP
           , MP.LONG_YEAR))
      ;
  
  END DATA_SELECT_SPREAD;

-- ���޿� �ڷ� SELECT(�Ⱓ��)
  PROCEDURE SELECT_SPREAD_PERIOD
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , W_PAY_YYYYMM_FR                     IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_PAY_YYYYMM_TO                     IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , W_DEPT_ID                           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , W_PAY_GRADE_ID                      IN HRP_MONTH_PAYMENT.PAY_GRADE_ID%TYPE
            , W_PAY_TYPE                          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_CONNECT_PERSON_ID                 IN NUMBER
            , W_SOB_ID                            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            )
  AS
    V_DUTY_TYPE                   VARCHAR2(10);
  BEGIN
    V_DUTY_TYPE := 'D2';
    OPEN P_CURSOR1 FOR
      SELECT CASE
               WHEN GROUPING(DM.DEPT_CODE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL)
               WHEN GROUPING(PM.NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10217', NULL)
               ELSE PM.NAME
             END AS NAME
           , DECODE(GROUPING(PM.NAME), 1, TO_CHAR(COUNT(PM.PERSON_NUM), 'FM999,999,999') || '��', PM.PERSON_NUM) AS PERSON_NUM
           , DECODE(GROUPING(PM.NAME), 1, TO_CHAR(NULL), MP.PAY_YYYYMM) AS PAY_YYYYMM
           , MP.WAGE_TYPE
           , HRM_COMMON_G.CODE_NAME_F('CLOSING_TYPE', MP.WAGE_TYPE, MP.SOB_ID, MP.ORG_ID) AS WAGE_TYPE_NAME           
           , DECODE(GROUPING(PM.NAME), 1, TO_CHAR(NULL), DM.DEPT_CODE) AS DEPT_CODE
           , DECODE(GROUPING(PM.NAME), 1, TO_CHAR(NULL), DM.DEPT_NAME) AS DEPT_NAME
           , HF.FLOOR_NAME
           , PC.POST_NAME AS POST_NAME
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
           , SUM(CASE 
                  WHEN MP.PAY_TYPE IN('1', '3') THEN HRP_PAYMENT_G_SET.BASIC_AMOUNT_F(MP.PAY_YYYYMM, MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID)
                  ELSE 0
                 END) AS BAISC_AMOUNT
           , SUM(CASE 
                  WHEN MP.PAY_TYPE IN('2') THEN HRP_PAYMENT_G_SET.BASIC_AMOUNT_F(MP.PAY_YYYYMM, MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID)
                  ELSE 0
                 END) AS BAISC_DAILY_AMOUNT
           , SUM(CASE 
                  WHEN MP.PAY_TYPE IN('4') THEN HRP_PAYMENT_G_SET.BASIC_AMOUNT_F(MP.PAY_YYYYMM, MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID)
                  ELSE 0
                 END) AS BAISC_TIME_AMOUNT
           , SUM(MP.GENERAL_HOURLY_AMOUNT) AS GENERAL_HOURLY_PAY_AMOUNT
           , SUM(NVL(MP.TOT_SUPPLY_AMOUNT, 0) - 
                 CASE
                    WHEN MP.TOT_SUPPLY_AMOUNT <= 1000000 THEN MA.TAX_FREE_OT
                    ELSE 0
                  END - 
                 NVL(MA.TAX_FREE_ETC, 0)
                ) AS TAX_TOT_SUPPLY_AMOUNT
           , SUM( CASE
                    WHEN MP.TOT_SUPPLY_AMOUNT <= 1000000 THEN MA.TAX_FREE_OT
                    ELSE 0
                  END) AS TAX_FREE_OT
           , SUM(MA.TAX_FREE_ETC) AS TAX_FREE_ETC
           -- �����׸�.
           , SUM(MA.A01) AS A01               -- �⺻��.
           , SUM(MA.A02) AS A02               -- ��å����.
           , SUM(MA.A03) AS A03               -- �ټӼ���.
           , 0 /*SUM(MA.A04)*/ AS A04               -- ����������.
           , SUM(MA.A05) AS A05               -- ���X
           , SUM(MA.A06) AS A06               -- �ڰݼ���.
           , SUM(NVL(MA.A07, 0) + NVL(MA.A04, 0) + NVL(MA.A16, 0) + NVL(MA.A24, 0)) AS A07               -- ��Ÿ����.
           , SUM(MA.A08) AS A08               -- ��������.
           , SUM(MA.A09) AS A09               -- �󿩱�.
           , SUM(MA.A10) AS A10               -- �����ұ޺�.
           , SUM(MA.A11) AS A11               -- �ð��ܼ���.
           , SUM(MA.A12) AS A12               -- ����ٷμ���.
           , SUM(MA.A13) AS A13               -- �߰��ٷμ���.
           , SUM(NVL(MA.A14, 0) + NVL(MA.A28, 0) + NVL(MA.A35, 0)) AS A14 -- Ư�ټ���(Ư�ټ��� + ���ޱٹ����� + ������Ư��).
           , SUM(MA.A15) AS A15               -- �ؿ������.
           , 0 /*SUM(MA.A16)*/ AS A16               -- Ư����.
           , SUM(MA.A17) AS A17               -- ������������.
           , SUM(MA.A18) AS A18               -- ��������.
           , SUM(MA.A19) AS A19               -- ���X
           , SUM(MA.A20) AS A20               -- ���X
           , SUM(MA.A21) AS A21               -- ���X
           , SUM(MA.A22) AS A22               -- ��ٰ���.
           , SUM(MA.A23) AS A23               -- ���X
           , 0 /*SUM(MA.A24)*/ AS A24               -- �ڱⰳ�߼���.
           , SUM(MA.A25) AS A25               -- ����������.
           , SUM(MA.A26) AS A26               -- ���X.
           , SUM(MA.A27) AS A27               -- ���X
           , 0 /*SUM(MA.A28)*/ AS A28               -- ���ޱٹ��ݷ���.
           , SUM(MA.A29) AS A29               -- ���X
           , SUM(MA.A30) AS A30               -- ���X
           , SUM(MA.A31) AS A31  -- ��������.
           , SUM(MA.A32) AS A32               -- �߰��������.
           , SUM(MA.A33) AS A33               -- ���ټ���.
           , SUM(MA.A34) AS A34
           , 0 /*SUM(MA.A35)*/ AS A35
           , SUM(MA.A36) AS A36
           , SUM(MA.A37) AS A37
           , SUM(MA.A38) AS A38
           , SUM(MA.A39) AS A39
           , SUM(MP.TOT_SUPPLY_AMOUNT) AS TOT_SUPPLY_AMOUNT
           -- ���� �׸�.
           , SUM(MD.D01) AS D01                -- �ҵ漼.
           , SUM(MD.D02) AS D02                -- �ֹμ�.
           , SUM(MD.D03) AS D03                -- ���ο���.
           , SUM(MD.D04) AS D04                -- ��뺸��.
           , SUM(MD.D05) AS D05                -- �ǰ�����.
           , SUM(MD.D06) AS D06                -- ���X
           , SUM(MD.D07) AS D07                -- �ǰ����������.
           , SUM(MD.D08) AS D08                -- ���ο��������.
           , SUM(MD.D09) AS D09                -- ���ұ�.
           , SUM(MD.D10) AS D10                -- ���������.
           , SUM(MD.D11) AS D11                -- �Ǻ���.
           , SUM(MD.D12) AS D12                -- ������߱޺�.
           , SUM(MD.D13) AS D13                -- ������
           , SUM(MD.D14) AS D14                -- ��Ÿ����.
           , SUM(MD.D15) AS D15                -- ����ҵ漼.
           , SUM(MD.D16) AS D16                -- �����ֹμ�.
           , SUM(MD.D17) AS D17                -- �����Ư��.
           , SUM(MD.D18) AS D18                -- 
           , SUM(MD.D19) AS D19                -- 
           , SUM(MD.D20) AS D20                -- 
           , SUM(MD.D21) AS D21                -- �ſ뺸�������.
           , SUM(MD.D22) AS D22
           , SUM(MD.D23) AS D23                
           , SUM(MD.D24) AS D24
           , SUM(MD.D25) AS D25
           , SUM(MD.D26) AS D26
           , SUM(MD.D27) AS D27
           , SUM(MD.D28) AS D28
           , SUM(MD.D29) AS D29
           , SUM(MP.TOT_DED_AMOUNT) AS TOT_DED_AMOUNT 
           , SUM(MP.REAL_AMOUNT) AS REAL_AMOUNT
           , SUM(DX1.TOTAL_ATT_DAY) AS TOTAL_ATT_DAY              -- ����ٹ�.
           , SUM(DX1.DUTY_30) AS DUTY_30                          -- ����.
           , SUM(DX1.S_HOLY_1_COUNT) AS S_HOLY_1_COUNT            -- ����.
           , SUM(DX1.HOLY_1_COUNT) AS HOLY_1_COUNT                -- ����.
           , SUM(DX1.HOLY_0_COUNT) AS HOLY_0_COUNT                -- ����.
           , SUM(DX1.TOT_DED_COUNT) AS TOT_DED_COUNT              -- �̱ٹ�.
           , SUM(DX1.WEEKLY_DED_COUNT) AS WEEKLY_DED_COUNT        -- ������.
           , SUM(CASE 
                   WHEN MP.PAY_TYPE IN('1', '3') THEN 0
                   ELSE DX1.LATE_TIME 
                 END) AS LATE_TIME                      -- ���°���(����/����).
           , SUM(DX1.OVER_TIME) AS OVER_TIME                      -- ����.
           , SUM(DX1.NIGHT_BONUS_TIME) AS NIGHT_BONUS_TIME        -- �߰�.
           , SUM(CASE 
                   WHEN MP.PAY_TYPE IN('1', '3') THEN 0
                   ELSE DX1.HOLY_1_TIME
                 END) AS HOLY_1_TIME                  -- ���� �ٹ�.
           , SUM(CASE 
                   WHEN MP.PAY_TYPE IN('1', '3') THEN 0
                   ELSE DX1.HOLY_1_OT 
                 END) AS HOLY_1_OT                      -- ���� ����.
           , SUM(CASE 
                   WHEN MP.PAY_TYPE IN('1', '3') THEN 0
                   ELSE DX1.HOLY_1_NIGHT 
                 END) AS HOLY_1_NIGHT                -- ���� �߰�.
        FROM HRP_MONTH_PAYMENT MP        
          , HRM_DEPT_MASTER DM
          , HRM_POST_CODE_V PC
          , HRM_PERSON_MASTER PM
          , (-- ���� �λ系��.
							SELECT HL.PERSON_ID
									, HL.DEPT_ID
									, HL.POST_ID
									, HL.JOB_CATEGORY_ID
									, HL.FLOOR_ID
								FROM HRM_HISTORY_LINE HL
							WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
																							FROM HRM_HISTORY_LINE S_HL
																						 WHERE S_HL.CHARGE_DATE            <= LAST_DAY(TO_DATE(W_PAY_YYYYMM_TO, 'YYYY-MM'))
																							 AND S_HL.PERSON_ID              = HL.PERSON_ID
																						 GROUP BY S_HL.PERSON_ID
																					 )
							) T1
          , HRM_FLOOR_V HF
          , HRP_MONTH_ALLOWANCE_V MA
          , HRP_MONTH_DEDUCTION_V MD
          , (SELECT MT.DUTY_YYYYMM 
                 , MT.PERSON_ID
                 , MT.TOTAL_ATT_DAY      -- ����ٹ�.
                 , MTD.DUTY_30 AS DUTY_30   -- ����.
                 , HRP_PAYMENT_G.MONTH_HOLY_COUNT_F(MT.PERSON_ID, MT.DUTY_YYYYMM, W_WAGE_TYPE, '1', MT.SOB_ID, MT.ORG_ID) AS S_HOLY_1_COUNT   -- ����.
                 , HRD_HOLIDAY_CALENDAR_G.HOLIDAY_COUNT(TRUNC(TO_DATE(MT.DUTY_YYYYMM, 'YYYY-MM'), 'MONTH'), LAST_DAY(TO_DATE(MT.DUTY_YYYYMM, 'YYYY-MM')), MT.PERSON_ID, MT.SOB_ID, MT.ORG_ID) AS HOLY_1_COUNT   -- ����.
                 , MT.HOLY_0_COUNT                                    -- ����.
                 , MT.LATE_DED_COUNT                                  -- ���°��� Ƚ��.
                 , NVL(MT.TOTAL_DED_DAY, 0) - NVL(MT.WEEKLY_DED_COUNT, 0) AS TOT_DED_COUNT               -- �̱ٹ�.
                 , MT.WEEKLY_DED_COUNT                                                                   -- ������.
                 , NVL(MTO.LEAVE_TIME, 0) + NVL(MTO.LATE_TIME, 0) AS LATE_TIME  -- ���°���(����/����).
                 , CASE
                     WHEN JCC.JOB_CATEGORY_CODE IN('10') THEN NVL(MTO.OVER_TIME, 0)
                     ELSE NVL(MTO.REST_TIME, 0) + NVL(MTO.OVER_TIME, 0) + NVL(MTO.NIGHT_TIME, 0)
                   END AS OVER_TIME   -- ����.
                 , CASE
                     WHEN JCC.JOB_CATEGORY_CODE IN('10') THEN NVL(MTO.NIGHT_TIME, 0)
                     ELSE NVL(MTO.NIGHT_BONUS_TIME, 0)
                   END AS NIGHT_BONUS_TIME   -- �߰�.
                 , CASE
                     WHEN JCC.JOB_CATEGORY_CODE IN('10') THEN 0
                     ELSE NVL(MTO.HOLIDAY_TIME, 0)
                   END AS HOLY_1_TIME            -- ���� �ٹ�.
                 , CASE
                     WHEN JCC.JOB_CATEGORY_CODE IN('10') THEN 0
                     ELSE NVL(MTO.HOLYDAY_OT_TIME, 0)
                   END AS HOLY_1_OT                 -- ���� ����.
                 , 0 AS HOLY_1_NIGHT           -- ���� �߰�.
              FROM HRD_MONTH_TOTAL MT
                , HRM_JOB_CATEGORY_CODE_V JCC
                , HRD_MONTH_TOTAL_OT_V MTO
                , HRD_MONTH_TOTAL_DUTY_V MTD
            WHERE MT.JOB_CATEGORY_ID         = JCC.JOB_CATEGORY_ID            
              AND MT.MONTH_TOTAL_ID          = MTO.MONTH_TOTAL_ID(+)
              AND MT.MONTH_TOTAL_ID          = MTD.MONTH_TOTAL_ID(+)
              AND MT.DUTY_TYPE               = V_DUTY_TYPE
              AND MT.DUTY_YYYYMM             BETWEEN W_PAY_YYYYMM_FR AND W_PAY_YYYYMM_TO
              AND MT.PERSON_ID               = NVL(W_PERSON_ID, MT.PERSON_ID)
              AND MT.CORP_ID                 = W_CORP_ID
              AND MT.SOB_ID                  = W_SOB_ID
              AND MT.ORG_ID                  = W_ORG_ID
            ) DX1
       WHERE MP.DEPT_ID                 = DM.DEPT_ID
         AND MP.POST_ID                 = PC.POST_ID
         AND MP.PERSON_ID               = PM.PERSON_ID
         AND PM.PERSON_ID               = T1.PERSON_ID
         AND T1.FLOOR_ID                = HF.FLOOR_ID
         AND MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID(+)
         AND MP.MONTH_PAYMENT_ID        = MD.MONTH_PAYMENT_ID(+)
         AND MP.PAY_YYYYMM              = DX1.DUTY_YYYYMM(+)
         AND MP.PERSON_ID               = DX1.PERSON_ID(+)
         AND MP.PERSON_ID               = NVL(W_PERSON_ID, MP.PERSON_ID)
         AND MP.PAY_YYYYMM              BETWEEN W_PAY_YYYYMM_FR AND W_PAY_YYYYMM_TO
         AND MP.WAGE_TYPE               = NVL(W_WAGE_TYPE, MP.WAGE_TYPE)
         AND MP.CORP_ID                 = W_CORP_ID
         AND MP.DEPT_ID                 = NVL(W_DEPT_ID, MP.DEPT_ID)
         AND MP.PAY_GRADE_ID            = NVL(W_PAY_GRADE_ID, MP.PAY_GRADE_ID)
         AND MP.PAY_TYPE                = NVL(W_PAY_TYPE, MP.PAY_TYPE)
         AND MP.SOB_ID                  = W_SOB_ID
         AND MP.ORG_ID                  = W_ORG_ID 
         AND (MP.TOT_SUPPLY_AMOUNT      <> 0
           OR MP.TOT_DED_AMOUNT         <> 0)
      GROUP BY ROLLUP((MP.PAY_YYYYMM
           , MP.WAGE_TYPE
           , DM.DEPT_CODE
           , DM.DEPT_NAME)
           , (HF.FLOOR_CODE
           , PC.POST_CODE
           , HF.FLOOR_NAME
           , PC.POST_NAME
           , PM.NAME
           , PM.PERSON_NUM           
           , HRM_COMMON_G.CODE_NAME_F('CLOSING_TYPE', MP.WAGE_TYPE, MP.SOB_ID, MP.ORG_ID)
           , MP.PAY_TYPE
           , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', MP.PAY_TYPE, MP.SOB_ID, MP.ORG_ID)
           , HRM_COMMON_G.ID_NAME_F(MP.PAY_GRADE_ID)
           , PM.ORI_JOIN_DATE
           , PM.JOIN_DATE
           , PM.PAY_DATE
           , PM.RETIRE_DATE
           , MP.DIR_INDIR_TYPE
           , MP.SUPPLY_DATE
           , MP.STANDARD_DATE
           , MP.PAY_RATE
           , MP.GRADE_STEP
           , MP.LONG_YEAR
           ))
      ;
  END SELECT_SPREAD_PERIOD;
  
    
-- ���޿� �ڷ� ����.
  PROCEDURE MONTH_PAYMENT_INSERT
            ( P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE 
            )
  AS
  BEGIN
    NULL;
    
  END MONTH_PAYMENT_INSERT;
  
-- ���޿� �ڷ� ����.
  PROCEDURE MONTH_PAYMENT_UPDATE
            ( W_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_DESCRIPTION       IN HRP_MONTH_PAYMENT.DESCRIPTION%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE 
            )
  AS
    V_CLOSE_FLAG                  VARCHAR2(2) := 'F';
        
    V_CORP_ID                     HRP_MONTH_PAYMENT.CORP_ID%TYPE;
    V_PAY_YYYYMM                  HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE;
    V_WAGE_TYPE                   HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE;
    V_SOB_ID                      HRP_MONTH_PAYMENT.SOB_ID%TYPE;
    V_ORG_ID                      HRP_MONTH_PAYMENT.ORG_ID%TYPE;
    
  BEGIN
    BEGIN
      SELECT MP.CORP_ID, MP.PAY_YYYYMM, MP.WAGE_TYPE, MP.SOB_ID, MP.ORG_ID
        INTO V_CORP_ID, V_PAY_YYYYMM, V_WAGE_TYPE, V_SOB_ID, V_ORG_ID
        FROM HRP_MONTH_PAYMENT MP
       WHERE MP.MONTH_PAYMENT_ID  = W_MONTH_PAYMENT_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      RAISE ERRNUMS.Data_Not_Found;
    END;
    
    V_CLOSE_FLAG := HRM_CLOSING_G.CLOSING_CHECK_W
                                  ( W_CORP_ID => V_CORP_ID
                                  , W_CLOSING_YYYYMM => V_PAY_YYYYMM
                                  , W_CLOSING_TYPE => V_WAGE_TYPE
                                  , W_SOB_ID => V_SOB_ID
                                  , W_ORG_ID => V_ORG_ID);
    IF V_CLOSE_FLAG = 'F' THEN
      RAISE ERRNUMS.Closed_Not_Create;
    ELSIF V_CLOSE_FLAG = 'Y' THEN
      RAISE ERRNUMS.Data_Closed;
    END IF;
                                            
    UPDATE HRP_MONTH_PAYMENT
      SET DESCRIPTION       = P_DESCRIPTION
        , LAST_UPDATE_DATE  = GET_LOCAL_DATE(SOB_ID)
        , LAST_UPDATED_BY   = P_USER_ID
    WHERE MONTH_PAYMENT_ID  = W_MONTH_PAYMENT_ID;
  
  EXCEPTION 
    WHEN ERRNUMS.Data_Not_Found THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_Found_Code, ERRNUMS.Data_Not_Found_Desc);
    WHEN ERRNUMS.Closed_Not_Create THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Closed_Not_Create_Code, ERRNUMS.Closed_Not_Create_Desc);
    WHEN ERRNUMS.Data_Closed THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
  END MONTH_PAYMENT_UPDATE;
   
---------------------------------------------------------------------------------------------------
-- �޻� ���޳��� ��ȸ / ���� / ����.
  PROCEDURE MONTH_ALLOWANCE_SELECT
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRP_MONTH_ALLOWANCE.CORP_ID%TYPE
            , W_PAY_YYYYMM                        IN HRP_MONTH_ALLOWANCE.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRP_MONTH_ALLOWANCE.WAGE_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_ALLOWANCE.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT MA.PERSON_ID
           , MA.PAY_YYYYMM
           , MA.WAGE_TYPE
           , MA.CORP_ID
           , MA.ALLOWANCE_ID
           , HA.ALLOWANCE_NAME AS ALLOWANCE_NAME
           , MA.ALLOWANCE_AMOUNT
           , MA.MONTH_PAYMENT_ID
           , MA.CREATED_FLAG
        FROM HRP_MONTH_ALLOWANCE MA
          , HRM_ALLOWANCE_V HA
       WHERE MA.ALLOWANCE_ID            = HA.ALLOWANCE_ID
         AND MA.CORP_ID                 = W_CORP_ID
         AND MA.PAY_YYYYMM              = W_PAY_YYYYMM
         AND MA.WAGE_TYPE               = W_WAGE_TYPE
         AND MA.PERSON_ID               = W_PERSON_ID   
         AND MA.SOB_ID                  = W_SOB_ID
         AND MA.ORG_ID                  = W_ORG_ID
       ORDER BY HA.SORT_NUM, HA.ALLOWANCE_CODE
     ;
     
  END MONTH_ALLOWANCE_SELECT;
  
-- ���޿� �����׸� INSERT
  PROCEDURE MONTH_ALLOWANCE_INSERT
            ( P_PERSON_ID        IN HRP_MONTH_ALLOWANCE.PERSON_ID%TYPE
            , P_PAY_YYYYMM       IN HRP_MONTH_ALLOWANCE.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE        IN HRP_MONTH_ALLOWANCE.WAGE_TYPE%TYPE
            , P_CORP_ID          IN HRP_MONTH_ALLOWANCE.CORP_ID%TYPE
            , P_ALLOWANCE_ID     IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT IN HRP_MONTH_ALLOWANCE.ALLOWANCE_AMOUNT%TYPE
            , P_MONTH_PAYMENT_ID IN HRP_MONTH_ALLOWANCE.MONTH_PAYMENT_ID%TYPE
            , P_SOB_ID           IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_ALLOWANCE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_CLOSE_FLAG                  VARCHAR2(2) := 'F';
    V_RECORD_COUNT                NUMBER := 0;
  BEGIN
    V_CLOSE_FLAG := HRM_CLOSING_G.CLOSING_CHECK_W
                                  ( W_CORP_ID => P_CORP_ID
                                  , W_CLOSING_YYYYMM => P_PAY_YYYYMM
                                  , W_CLOSING_TYPE => P_WAGE_TYPE
                                  , W_SOB_ID => P_SOB_ID
                                  , W_ORG_ID => P_ORG_ID);
    IF V_CLOSE_FLAG = 'F' THEN
      RAISE ERRNUMS.Closed_Not_Create;
    ELSIF V_CLOSE_FLAG = 'Y' THEN
      RAISE ERRNUMS.Data_Closed;
    END IF;
    
    BEGIN
      SELECT COUNT(MA.ALLOWANCE_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRP_MONTH_ALLOWANCE MA
       WHERE MA.CORP_ID                 = P_CORP_ID
         AND MA.PAY_YYYYMM              = P_PAY_YYYYMM
         AND MA.WAGE_TYPE               = P_WAGE_TYPE         
         AND MA.PERSON_ID               = P_PERSON_ID
         AND MA.ALLOWANCE_ID            = P_ALLOWANCE_ID   
         AND MA.SOB_ID                  = P_SOB_ID
         AND MA.ORG_ID                  = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE ERRNUMS.Exist_Data;
    END;

    INSERT INTO HRP_MONTH_ALLOWANCE
    ( PERSON_ID
    , PAY_YYYYMM 
    , WAGE_TYPE 
    , CORP_ID 
    , ALLOWANCE_ID 
    , ALLOWANCE_AMOUNT 
    , MONTH_PAYMENT_ID 
    , SOB_ID 
    , ORG_ID 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_PERSON_ID
    , P_PAY_YYYYMM
    , P_WAGE_TYPE
    , P_CORP_ID
    , P_ALLOWANCE_ID
    , P_ALLOWANCE_AMOUNT
    , P_MONTH_PAYMENT_ID
    , P_SOB_ID
    , P_ORG_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
    
    -- TAX-UPATE --
    TAX_UPDATE
            ( P_PAY_YYYYMM       => P_PAY_YYYYMM
            , P_WAGE_TYPE        => P_WAGE_TYPE
            , P_CORP_ID          => P_CORP_ID
            , P_PERSON_ID        => P_PERSON_ID
            , P_SOB_ID           => P_SOB_ID
            , P_ORG_ID           => P_ORG_ID
            , P_USER_ID          => P_USER_ID 
            );
            
    -- �հ�.
    PAYMENT_SUMMARY_UPDATE
            ( P_MONTH_PAYMENT_ID  => P_MONTH_PAYMENT_ID
            , P_CORP_ID           => P_CORP_ID
            , P_PAY_YYYYMM        => P_PAY_YYYYMM
            , P_WAGE_TYPE         => P_WAGE_TYPE
            , P_PERSON_ID         => P_PERSON_ID
            , P_SOB_ID            => P_SOB_ID
            , P_ORG_ID            => P_ORG_ID
            );
            
  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
    WHEN ERRNUMS.Data_Not_Found THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_Found_Code, ERRNUMS.Data_Not_Found_Desc);
    WHEN ERRNUMS.Closed_Not_Create THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Closed_Not_Create_Code, ERRNUMS.Closed_Not_Create_Desc);
    WHEN ERRNUMS.Data_Closed THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
  END MONTH_ALLOWANCE_INSERT;

-- ���޿� �����׸� UPDATE.
  PROCEDURE MONTH_ALLOWANCE_UPDATE
            ( W_MONTH_PAYMENT_ID IN HRP_MONTH_ALLOWANCE.MONTH_PAYMENT_ID%TYPE
            , W_ALLOWANCE_ID     IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT IN HRP_MONTH_ALLOWANCE.ALLOWANCE_AMOUNT%TYPE
            , W_SOB_ID           IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_ALLOWANCE.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_CLOSE_FLAG                  VARCHAR2(2) := 'F';
    V_CORP_ID                     HRP_MONTH_PAYMENT.CORP_ID%TYPE;
    V_PAY_YYYYMM                  HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE;
    V_WAGE_TYPE                   HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE;
    V_PERSON_ID                   HRP_MONTH_PAYMENT.PERSON_ID%TYPE;
  BEGIN
    BEGIN
      SELECT MP.CORP_ID, MP.PAY_YYYYMM, MP.WAGE_TYPE, MP.PERSON_ID
        INTO V_CORP_ID, V_PAY_YYYYMM, V_WAGE_TYPE, V_PERSON_ID        
        FROM HRP_MONTH_PAYMENT MP
       WHERE MP.MONTH_PAYMENT_ID  = W_MONTH_PAYMENT_ID
         AND MP.SOB_ID            = W_SOB_ID
         AND MP.ORG_ID            = W_ORG_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      RAISE ERRNUMS.Data_Not_Found;
    END;
    
    V_CLOSE_FLAG := HRM_CLOSING_G.CLOSING_CHECK_W
                                  ( W_CORP_ID => V_CORP_ID
                                  , W_CLOSING_YYYYMM => V_PAY_YYYYMM
                                  , W_CLOSING_TYPE => V_WAGE_TYPE
                                  , W_SOB_ID => W_SOB_ID
                                  , W_ORG_ID => W_ORG_ID);
    IF V_CLOSE_FLAG = 'F' THEN
      RAISE ERRNUMS.Closed_Not_Create;
    ELSIF V_CLOSE_FLAG = 'Y' THEN
      RAISE ERRNUMS.Data_Closed;
    END IF;
    
    UPDATE HRP_MONTH_ALLOWANCE MA
      SET MA.ALLOWANCE_AMOUNT = P_ALLOWANCE_AMOUNT
        , MA.LAST_UPDATE_DATE = V_SYSDATE
        , MA.LAST_UPDATED_BY  = P_USER_ID
     WHERE MA.MONTH_PAYMENT_ID        = W_MONTH_PAYMENT_ID
       AND MA.ALLOWANCE_ID            = W_ALLOWANCE_ID
       AND MA.SOB_ID                  = W_SOB_ID
       AND MA.ORG_ID                  = W_ORG_ID
    ;
        
    -- TAX-UPATE --
    TAX_UPDATE
            ( P_PAY_YYYYMM       => V_PAY_YYYYMM
            , P_WAGE_TYPE        => V_WAGE_TYPE
            , P_CORP_ID          => V_CORP_ID
            , P_PERSON_ID        => V_PERSON_ID
            , P_SOB_ID           => W_SOB_ID
            , P_ORG_ID           => W_ORG_ID
            , P_USER_ID          => P_USER_ID 
            );
            
    -- �հ�.
    PAYMENT_SUMMARY_UPDATE
            ( P_MONTH_PAYMENT_ID  => W_MONTH_PAYMENT_ID
            , P_CORP_ID           => V_CORP_ID
            , P_PAY_YYYYMM        => V_PAY_YYYYMM
            , P_WAGE_TYPE         => V_WAGE_TYPE
            , P_PERSON_ID         => V_PERSON_ID
            , P_SOB_ID            => W_SOB_ID
            , P_ORG_ID            => W_ORG_ID
            );
            
  EXCEPTION 
    WHEN ERRNUMS.Data_Not_Found THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_Found_Code, ERRNUMS.Data_Not_Found_Desc);
    WHEN ERRNUMS.Closed_Not_Create THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Closed_Not_Create_Code, ERRNUMS.Closed_Not_Create_Desc);
    WHEN ERRNUMS.Data_Closed THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
  END MONTH_ALLOWANCE_UPDATE;

-- ���޿� �����׸� Delete.
  PROCEDURE MONTH_ALLOWANCE_DELETE
            ( W_MONTH_PAYMENT_ID IN HRP_MONTH_ALLOWANCE.MONTH_PAYMENT_ID%TYPE
            , W_ALLOWANCE_ID     IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , W_SOB_ID           IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            )
  AS
    V_CLOSE_FLAG                  VARCHAR2(2) := 'F';
    V_CORP_ID                     HRP_MONTH_PAYMENT.CORP_ID%TYPE;
    V_PAY_YYYYMM                  HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE;
    V_WAGE_TYPE                   HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE;
    V_PERSON_ID                   HRP_MONTH_PAYMENT.PERSON_ID%TYPE;
    V_SOB_ID                      HRP_MONTH_PAYMENT.SOB_ID%TYPE;
    V_ORG_ID                      HRP_MONTH_PAYMENT.ORG_ID%TYPE;
    V_USER_ID                     HRP_MONTH_PAYMENT.CREATED_BY%TYPE;
  BEGIN
    BEGIN
      SELECT MP.CORP_ID, MP.PAY_YYYYMM, MP.WAGE_TYPE, MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID, MP.CREATED_BY
        INTO V_CORP_ID, V_PAY_YYYYMM, V_WAGE_TYPE, V_PERSON_ID, V_SOB_ID, V_ORG_ID, V_USER_ID
        FROM HRP_MONTH_PAYMENT MP
       WHERE MP.MONTH_PAYMENT_ID  = W_MONTH_PAYMENT_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      RAISE ERRNUMS.Data_Not_Found;
    END;
    
    V_CLOSE_FLAG := HRM_CLOSING_G.CLOSING_CHECK_W
                                  ( W_CORP_ID => V_CORP_ID
                                  , W_CLOSING_YYYYMM => V_PAY_YYYYMM
                                  , W_CLOSING_TYPE => V_WAGE_TYPE
                                  , W_SOB_ID => V_SOB_ID
                                  , W_ORG_ID => V_ORG_ID);
    IF V_CLOSE_FLAG = 'F' THEN
      RAISE ERRNUMS.Closed_Not_Create;
    ELSIF V_CLOSE_FLAG = 'Y' THEN
      RAISE ERRNUMS.Data_Closed;
    END IF;
    
    DELETE HRP_MONTH_ALLOWANCE MA
       WHERE MA.MONTH_PAYMENT_ID        = W_MONTH_PAYMENT_ID
         AND MA.ALLOWANCE_ID            = W_ALLOWANCE_ID
         AND MA.SOB_ID                  = W_SOB_ID
         AND MA.ORG_ID                  = W_ORG_ID
    ;
    
    -- TAX UPDATE --
    TAX_UPDATE
            ( P_PAY_YYYYMM       => V_PAY_YYYYMM
            , P_WAGE_TYPE        => V_WAGE_TYPE
            , P_CORP_ID          => V_CORP_ID
            , P_PERSON_ID        => V_PERSON_ID
            , P_SOB_ID           => V_SOB_ID
            , P_ORG_ID           => V_ORG_ID
            , P_USER_ID          => V_USER_ID 
            );
    -- �հ�.
    PAYMENT_SUMMARY_UPDATE
            ( P_MONTH_PAYMENT_ID  => W_MONTH_PAYMENT_ID
            , P_CORP_ID           => V_CORP_ID
            , P_PAY_YYYYMM        => V_PAY_YYYYMM
            , P_WAGE_TYPE         => V_WAGE_TYPE
            , P_PERSON_ID         => V_PERSON_ID
            , P_SOB_ID            => W_SOB_ID
            , P_ORG_ID            => W_ORG_ID
            );
  EXCEPTION 
    WHEN ERRNUMS.Data_Not_Found THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_Found_Code, ERRNUMS.Data_Not_Found_Desc);
    WHEN ERRNUMS.Closed_Not_Create THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Closed_Not_Create_Code, ERRNUMS.Closed_Not_Create_Desc);
    WHEN ERRNUMS.Data_Closed THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
  END MONTH_ALLOWANCE_DELETE;

---------------------------------------------------------------------------------------------------
-- �޻� �������� ��ȸ / ���� / ����.
  PROCEDURE MONTH_DEDUCTION_SELECT
            ( P_CURSOR2                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , W_PAY_YYYYMM                        IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT MD.PERSON_ID
           , MD.PAY_YYYYMM
           , MD.WAGE_TYPE
           , MD.CORP_ID
           , MD.DEDUCTION_ID
           , HD.DEDUCTION_NAME AS DEDUCTION_NAME
           , MD.DEDUCTION_AMOUNT
           , MD.MONTH_PAYMENT_ID
           , MD.CREATED_FLAG
        FROM HRP_MONTH_DEDUCTION MD
          , HRM_DEDUCTION_V HD
       WHERE MD.DEDUCTION_ID            = HD.DEDUCTION_ID
         AND MD.CORP_ID                 = W_CORP_ID
         AND MD.PAY_YYYYMM              = W_PAY_YYYYMM
         AND MD.WAGE_TYPE               = W_WAGE_TYPE
         AND MD.PERSON_ID               = W_PERSON_ID   
         AND MD.SOB_ID                  = W_SOB_ID
         AND MD.ORG_ID                  = W_ORG_ID
       ORDER BY HD.SORT_NUM, HD.DEDUCTION_CODE
     ;
  
  END MONTH_DEDUCTION_SELECT;
              
-- ���޿� �����׸� INSERT
  PROCEDURE MONTH_DEDUCTION_INSERT
            ( P_PERSON_ID        IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , P_PAY_YYYYMM       IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE        IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , P_CORP_ID          IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , P_DEDUCTION_ID     IN HRP_MONTH_DEDUCTION.DEDUCTION_ID%TYPE
            , P_DEDUCTION_AMOUNT IN HRP_MONTH_DEDUCTION.DEDUCTION_AMOUNT%TYPE
            , P_MONTH_PAYMENT_ID IN HRP_MONTH_DEDUCTION.MONTH_PAYMENT_ID%TYPE
            , P_SOB_ID           IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_DEDUCTION.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_CLOSE_FLAG                  VARCHAR2(2) := 'F';
    V_RECORD_COUNT                NUMBER := 0;
    
  BEGIN
    V_CLOSE_FLAG := HRM_CLOSING_G.CLOSING_CHECK_W
                                  ( W_CORP_ID => P_CORP_ID
                                  , W_CLOSING_YYYYMM => P_PAY_YYYYMM
                                  , W_CLOSING_TYPE => P_WAGE_TYPE
                                  , W_SOB_ID => P_SOB_ID
                                  , W_ORG_ID => P_ORG_ID);
    IF V_CLOSE_FLAG = 'F' THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Closed_Not_Create_Code, ERRNUMS.Closed_Not_Create_Desc);
      RETURN;
    ELSIF V_CLOSE_FLAG = 'Y' THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
      RETURN;
    END IF;
    
    BEGIN
      SELECT COUNT(MD.DEDUCTION_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRP_MONTH_DEDUCTION MD
       WHERE MD.CORP_ID                 = P_CORP_ID
         AND MD.PAY_YYYYMM              = P_PAY_YYYYMM
         AND MD.WAGE_TYPE               = P_WAGE_TYPE
         AND MD.PERSON_ID               = P_PERSON_ID   
         AND MD.DEDUCTION_ID            = P_DEDUCTION_ID
         AND MD.SOB_ID                  = P_SOB_ID
         AND MD.ORG_ID                  = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);  
      RETURN;
    END;

    INSERT INTO HRP_MONTH_DEDUCTION
    ( PERSON_ID
    , PAY_YYYYMM 
    , WAGE_TYPE 
    , CORP_ID 
    , DEDUCTION_ID 
    , DEDUCTION_AMOUNT 
    , MONTH_PAYMENT_ID 
    , SOB_ID 
    , ORG_ID 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_PERSON_ID
    , P_PAY_YYYYMM
    , P_WAGE_TYPE
    , P_CORP_ID
    , P_DEDUCTION_ID
    , P_DEDUCTION_AMOUNT
    , P_MONTH_PAYMENT_ID
    , P_SOB_ID
    , P_ORG_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
    
    -- �հ�.
    PAYMENT_SUMMARY_UPDATE
            ( P_MONTH_PAYMENT_ID  => P_MONTH_PAYMENT_ID
            , P_CORP_ID           => P_CORP_ID
            , P_PAY_YYYYMM        => P_PAY_YYYYMM
            , P_WAGE_TYPE         => P_WAGE_TYPE
            , P_PERSON_ID         => P_PERSON_ID
            , P_SOB_ID            => P_SOB_ID
            , P_ORG_ID            => P_ORG_ID
            );
  END MONTH_DEDUCTION_INSERT;

-- ���޿� �����׸� UPDATE.
  PROCEDURE MONTH_DEDUCTION_UPDATE
            ( W_MONTH_PAYMENT_ID IN HRP_MONTH_DEDUCTION.MONTH_PAYMENT_ID%TYPE
            , W_DEDUCTION_ID     IN HRP_MONTH_DEDUCTION.DEDUCTION_ID%TYPE
            , P_DEDUCTION_AMOUNT IN HRP_MONTH_DEDUCTION.DEDUCTION_AMOUNT%TYPE
            , W_SOB_ID           IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_DEDUCTION.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_CLOSE_FLAG                  VARCHAR2(2) := 'F';
    V_CORP_ID                     HRP_MONTH_PAYMENT.CORP_ID%TYPE;
    V_PAY_YYYYMM                  HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE;
    V_WAGE_TYPE                   HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE;
    V_PERSON_ID                   HRP_MONTH_PAYMENT.PERSON_ID%TYPE;
    
  BEGIN
    BEGIN
      SELECT MP.CORP_ID, MP.PAY_YYYYMM, MP.WAGE_TYPE, MP.PERSON_ID
        INTO V_CORP_ID, V_PAY_YYYYMM, V_WAGE_TYPE, V_PERSON_ID
        FROM HRP_MONTH_PAYMENT MP
       WHERE MP.MONTH_PAYMENT_ID  = W_MONTH_PAYMENT_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_Found_Code, ERRNUMS.Data_Not_Found_Desc);
      RETURN;
    END;
    
    V_CLOSE_FLAG := HRM_CLOSING_G.CLOSING_CHECK_W
                                  ( W_CORP_ID => V_CORP_ID
                                  , W_CLOSING_YYYYMM => V_PAY_YYYYMM
                                  , W_CLOSING_TYPE => V_WAGE_TYPE
                                  , W_SOB_ID => W_SOB_ID
                                  , W_ORG_ID => W_ORG_ID);
    IF V_CLOSE_FLAG = 'F' THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Closed_Not_Create_Code, ERRNUMS.Closed_Not_Create_Desc);
      RETURN;
    ELSIF V_CLOSE_FLAG = 'Y' THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
      RETURN;
    END IF;
    
    UPDATE HRP_MONTH_DEDUCTION MD
      SET MD.DEDUCTION_AMOUNT = P_DEDUCTION_AMOUNT
        , MD.LAST_UPDATE_DATE = V_SYSDATE
        , MD.LAST_UPDATED_BY  = P_USER_ID
     WHERE MD.MONTH_PAYMENT_ID        = W_MONTH_PAYMENT_ID
       AND MD.DEDUCTION_ID            = W_DEDUCTION_ID
       AND MD.SOB_ID                  = W_SOB_ID
       AND MD.ORG_ID                  = W_ORG_ID
    ;
    
    -- �հ�.
    PAYMENT_SUMMARY_UPDATE
            ( P_MONTH_PAYMENT_ID  => W_MONTH_PAYMENT_ID
            , P_CORP_ID           => V_CORP_ID
            , P_PAY_YYYYMM        => V_PAY_YYYYMM
            , P_WAGE_TYPE         => V_WAGE_TYPE
            , P_PERSON_ID         => V_PERSON_ID
            , P_SOB_ID            => W_SOB_ID
            , P_ORG_ID            => W_ORG_ID
            );      
  END MONTH_DEDUCTION_UPDATE;

-- ���޿� �����׸� Delete.
  PROCEDURE MONTH_DEDUCTION_DELETE
            ( W_MONTH_PAYMENT_ID IN HRP_MONTH_DEDUCTION.MONTH_PAYMENT_ID%TYPE
            , W_DEDUCTION_ID     IN HRP_MONTH_DEDUCTION.DEDUCTION_ID%TYPE
            , W_SOB_ID           IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            )
  AS
    V_CLOSE_FLAG                  VARCHAR2(2) := 'F';
    V_CORP_ID                     HRP_MONTH_PAYMENT.CORP_ID%TYPE;
    V_PAY_YYYYMM                  HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE;
    V_WAGE_TYPE                   HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE;
    V_PERSON_ID                   HRP_MONTH_PAYMENT.PERSON_ID%TYPE;
    V_SOB_ID                      HRP_MONTH_PAYMENT.SOB_ID%TYPE;
    V_ORG_ID                      HRP_MONTH_PAYMENT.ORG_ID%TYPE;
    V_USER_ID                     HRP_MONTH_PAYMENT.CREATED_BY%TYPE;
  BEGIN
    BEGIN
      SELECT MP.CORP_ID, MP.PAY_YYYYMM, MP.WAGE_TYPE, MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID, MP.CREATED_BY
        INTO V_CORP_ID, V_PAY_YYYYMM, V_WAGE_TYPE, V_PERSON_ID, V_SOB_ID, V_ORG_ID, V_USER_ID
        FROM HRP_MONTH_PAYMENT MP
       WHERE MP.MONTH_PAYMENT_ID  = W_MONTH_PAYMENT_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_Found_Code, ERRNUMS.Data_Not_Found_Desc);
      RETURN;
    END;
    
    V_CLOSE_FLAG := HRM_CLOSING_G.CLOSING_CHECK_W
                                  ( W_CORP_ID => V_CORP_ID
                                  , W_CLOSING_YYYYMM => V_PAY_YYYYMM
                                  , W_CLOSING_TYPE => V_WAGE_TYPE
                                  , W_SOB_ID => V_SOB_ID
                                  , W_ORG_ID => V_ORG_ID);
    IF V_CLOSE_FLAG = 'F' THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Closed_Not_Create_Code, ERRNUMS.Closed_Not_Create_Desc);
      RETURN;
    ELSIF V_CLOSE_FLAG = 'Y' THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
      RETURN;
    END IF;
    
    DELETE HRP_MONTH_DEDUCTION MD
       WHERE MD.MONTH_PAYMENT_ID        = W_MONTH_PAYMENT_ID
         AND MD.DEDUCTION_ID            = W_DEDUCTION_ID
         AND MD.SOB_ID                  = W_SOB_ID
         AND MD.ORG_ID                  = W_ORG_ID
      ;
    
    -- �հ�.
    PAYMENT_SUMMARY_UPDATE
            ( P_MONTH_PAYMENT_ID  => W_MONTH_PAYMENT_ID
            , P_CORP_ID           => V_CORP_ID
            , P_PAY_YYYYMM        => V_PAY_YYYYMM
            , P_WAGE_TYPE         => V_WAGE_TYPE
            , P_PERSON_ID         => V_PERSON_ID
            , P_SOB_ID            => W_SOB_ID
            , P_ORG_ID            => W_ORG_ID
            );
  END MONTH_DEDUCTION_DELETE;   

-- ���� �ٽ� ���.
  PROCEDURE TAX_UPDATE
            ( P_PAY_YYYYMM       IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE        IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , P_CORP_ID          IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , P_PERSON_ID        IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , P_SOB_ID           IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_DEDUCTION.CREATED_BY%TYPE 
            )
  AS
    V_TAX_DEDUCTION_ID            NUMBER;
    V_RESIDENT_DEDUCTION_ID       NUMBER;
    V_HIRE_DEDUCTION_ID           NUMBER;
  BEGIN
    -- �ҵ漼/�ֹμ�/��뺸�� ����ID ��ȸ--
    BEGIN
      SELECT MAX(DECODE(HD.DEDUCTION_TYPE, 'TAX', HD.DEDUCTION_ID, NULL)) AS TAX_DEDUCTION_ID
           , MAX(DECODE(HD.DEDUCTION_TYPE, 'RESIDENT', HD.DEDUCTION_ID, NULL)) AS RESIDENT_DEDUCTION_ID
           , MAX(DECODE(HD.DEDUCTION_TYPE, 'UI', HD.DEDUCTION_ID, NULL)) AS HIRE_DEDUCTION_ID
        INTO V_TAX_DEDUCTION_ID, V_RESIDENT_DEDUCTION_ID, V_HIRE_DEDUCTION_ID
        FROM HRM_DEDUCTION_V HD
       WHERE HD.DEDUCTION_TYPE    IN ('TAX', 'RESIDENT', 'UI')
         AND HD.SOB_ID            = P_SOB_ID
         AND HD.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Deduction ID(TAX) Error : '  || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10114', NULL));
    END;
    -- TAX/��뺸�� �ʱ�ȭ --
    BEGIN
      UPDATE HRP_MONTH_DEDUCTION MD
          SET MD.DEDUCTION_AMOUNT = 0
       WHERE MD.PERSON_ID         = P_PERSON_ID
         AND MD.PAY_YYYYMM        = P_PAY_YYYYMM
         AND MD.WAGE_TYPE         = P_WAGE_TYPE
         AND MD.CORP_ID           = P_CORP_ID
         AND MD.DEDUCTION_ID      IN(V_TAX_DEDUCTION_ID, V_RESIDENT_DEDUCTION_ID, V_HIRE_DEDUCTION_ID)
         AND MD.SOB_ID            = P_SOB_ID
         AND MD.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    
    IF P_WAGE_TYPE IN ('P2', 'P5') THEN
      -- �󿩱�.
      HRP_MONTH_BONUS_G_SET.TAX_CREATION
          ( P_CORP_ID           => P_CORP_ID
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_WAGE_TYPE         => P_WAGE_TYPE
          , P_PAY_TYPE          => NULL
          , P_DEPT_ID           => NULL
          , P_PERSON_ID         => P_PERSON_ID
          , P_EXCEPT_YN         => 'N'
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID
          );
      -- ��뺸��.
      HRP_MONTH_BONUS_G_SET.UNEMPLOYMENT_INSURANCE
          ( P_CORP_ID           => P_CORP_ID
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_WAGE_TYPE         => P_WAGE_TYPE
          , P_PAY_TYPE          => NULL
          , P_DEPT_ID           => NULL
          , P_PERSON_ID         => P_PERSON_ID
          , P_EXCEPT_YN         => 'N'
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID
          );
    ELSE
      -- �� �̿�.    
      HRP_MONTH_PAYMENT_G_SET.TAX_CREATION
          ( P_CORP_ID           => P_CORP_ID
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_WAGE_TYPE         => P_WAGE_TYPE
          , P_PAY_TYPE          => NULL
          , P_DEPT_ID           => NULL
          , P_PERSON_ID         => P_PERSON_ID
          , P_EXCEPT_YN         => 'N'
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID
          );
      -- ��뺸��.
      HRP_MONTH_PAYMENT_G_SET.UNEMPLOYMENT_INSURANCE
          ( P_CORP_ID           => P_CORP_ID
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_WAGE_TYPE         => P_WAGE_TYPE
          , P_PAY_TYPE          => NULL
          , P_DEPT_ID           => NULL
          , P_PERSON_ID         => P_PERSON_ID
          , P_EXCEPT_YN         => 'N'
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID
          );
    END IF;
  END TAX_UPDATE;
  
-- ����/���� �հ� ó��.
  PROCEDURE PAYMENT_SUMMARY_UPDATE
            ( P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            )
  AS    
  BEGIN
      -- ���� �׸� �հ� UPDATE --
      UPDATE HRP_MONTH_PAYMENT MP
        SET (MP.PAY_AMOUNT, MP.BONUS_AMOUNT, MP.TOT_SUPPLY_AMOUNT, MP.REAL_AMOUNT)
          = ( SELECT NVL(SUM(DECODE(MA.WAGE_TYPE, 'P1', MA.ALLOWANCE_AMOUNT, 0)), 0) AS PAY_AMOUNT
                   , NVL(SUM(DECODE(MA.WAGE_TYPE, 'P2', MA.ALLOWANCE_AMOUNT, 0)), 0) AS BONUS_AMOUNT
                   , NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS TOTAL_SUPPLY_AMOUNT
                   , NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS REAL_AMOUNT
                FROM HRP_MONTH_ALLOWANCE MA
               WHERE MA.MONTH_PAYMENT_ID        = MP.MONTH_PAYMENT_ID
              GROUP BY MA.MONTH_PAYMENT_ID
            )
      WHERE MP.MONTH_PAYMENT_ID   = P_MONTH_PAYMENT_ID
      ;
      
      -- ���� �׸� �հ� UPDATE --
      UPDATE HRP_MONTH_PAYMENT MP
        SET (MP.DED_PAY_AMOUNT, MP.DED_BONUS_AMOUNT, MP.TOT_DED_AMOUNT, MP.REAL_AMOUNT)
          = ( SELECT NVL(SUM(DECODE(MD.WAGE_TYPE, 'P1', MD.DEDUCTION_AMOUNT, 0)), 0) AS DED_PAY_AMOUNT
                   , NVL(SUM(DECODE(MD.WAGE_TYPE, 'P2', MD.DEDUCTION_AMOUNT, 0)), 0) AS DED_BONUS_AMOUNT
                   , NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS TOTAL_DED_AMOUNT
                   , NVL(MP.TOT_SUPPLY_AMOUNT, 0) - NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS REAL_AMOUNT
                FROM HRP_MONTH_DEDUCTION MD
               WHERE MD.MONTH_PAYMENT_ID        = MP.MONTH_PAYMENT_ID
              GROUP BY MD.MONTH_PAYMENT_ID
            )
      WHERE MP.MONTH_PAYMENT_ID   = P_MONTH_PAYMENT_ID
      ;
  
  END PAYMENT_SUMMARY_UPDATE;
  
END HRP_MONTH_PAYMENT_G;
/
