CREATE OR REPLACE PACKAGE HRD_PERIOD_TOTAL_G
AS

-- �Ⱓ���� ��Ȳ : �׸� ��ȸ.
  PROCEDURE SELECT_PERIOD_TOTAL_SPREAD
            ( P_CURSOR              OUT TYPES.TCURSOR
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE
            , P_WORK_CORP_ID        IN  NUMBER
            , P_CORP_ID             IN  NUMBER
            , P_JOB_CATEGORY_ID     IN  NUMBER
            , P_DEPT_ID             IN  NUMBER
            , P_FLOOR_ID            IN  NUMBER            
            , P_PERSON_ID           IN  NUMBER
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            );
            
-- �Ⱓ���� ���� MAIN.
  PROCEDURE SET_MAIN
            ( P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE
            , P_WORK_CORP_ID        IN  NUMBER
            , P_CORP_ID             IN  NUMBER
            , P_JOB_CATEGORY_ID     IN  NUMBER
            , P_DEPT_ID             IN  NUMBER
            , P_FLOOR_ID            IN  NUMBER            
            , P_PERSON_ID           IN  NUMBER
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            , O_STATUS              OUT VARCHAR2
            , O_MESSAGE             OUT VARCHAR2
            );

-- �Ⱓ���� ���� ó��.
  PROCEDURE PERIOD_TOTAL_GO
            ( P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE
            , P_WORK_CORP_ID        IN  NUMBER
            , P_CORP_ID             IN  NUMBER
            , P_JOB_CATEGORY_ID     IN  NUMBER
            , P_DEPT_ID             IN  NUMBER
            , P_FLOOR_ID            IN  NUMBER            
            , P_PERSON_ID           IN  NUMBER
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            , O_STATUS              OUT VARCHAR2
            , O_MESSAGE             OUT VARCHAR2
            );

-- �Ⱓ���� �ܾ� ���� ó��.
  PROCEDURE PERIOD_TOTAL_OT_GO
            ( P_PERSON_ID           IN  NUMBER
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE            
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            , O_STATUS              OUT VARCHAR2
            , O_MESSAGE             OUT VARCHAR2
            );

-- �Ⱓ���� ���� ���� ó��.
  PROCEDURE PERIOD_TOTAL_DUTY_GO
            ( P_PERSON_ID           IN  NUMBER
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE            
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            , O_STATUS              OUT VARCHAR2
            , O_MESSAGE             OUT VARCHAR2
            );

-- �Ⱓ���� ���ް��� ��� : �Ի����ڿ� ���� ���ް��� ���.
  FUNCTION JOIN_DATE_WEEK_DED_F
            ( P_PERSON_ID           IN  NUMBER
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE            
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            ) RETURN NUMBER;

-- ����/���� 4H �̻��ڿ� ���� ���ް��� ���.
  FUNCTION LATE_TIME_WEEK_DED_F
            ( P_PERSON_ID           IN  NUMBER
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE            
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            ) RETURN NUMBER;

-- �Ⱓ���� ���ް��� ���.
  FUNCTION PERIOD_TOTAL_WEEK_DED_F
            ( P_PERSON_ID           IN  NUMBER
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE            
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            ) RETURN NUMBER;

-- �Ⱓ���� ���ް��� ��� : �Ի����ڿ� ���� ���ް��� ���.
  FUNCTION ROOKIE_WEEK_DED_F
            ( P_PERSON_ID           IN  NUMBER
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE            
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            ) RETURN NUMBER;

-- �Ⱓ���� ���ް��� ���.
  FUNCTION MONTH_WEEK_DED_F
            ( P_PERSON_ID           IN  NUMBER
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE            
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            ) RETURN NUMBER;


---------------------------------------------------------------------------------------------------
-- TOT_DED_COUNT ==> CAL.
  PROCEDURE TOT_DED_COUNT_P
            ( P_PERSON_ID           IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE            
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_LATE_DED_COUNT      IN  NUMBER
            , P_WEEKLY_DED_COUNT    IN  NUMBER
            , O_TOTAL_DED_COUNT     OUT NUMBER
            , O_PAY_DAY             OUT NUMBER
            );

-- �����ϼ�.
  FUNCTION NON_PAY_DAY_F
            ( P_PERSON_ID           IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE            
            , P_CONNECT_PERSON_ID   IN  NUMBER
            ) RETURN NUMBER;

---------------------------------------------------------------------------------------------------
  PROCEDURE SAVE_OT_TIME
            ( P_PERSON_ID               IN  NUMBER
            , P_OT_TYPE                 IN  VARCHAR2
            , P_OT_TIME                 IN  NUMBER
            , P_SOB_ID                  IN  NUMBER
            , P_ORG_ID                  IN  NUMBER
            , P_USER_ID                 IN  NUMBER
            );

END HRD_PERIOD_TOTAL_G;
/
CREATE OR REPLACE PACKAGE BODY HRD_PERIOD_TOTAL_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_PERIOD_TOTAL_G
/* DESCRIPTION  : ������ ����.
/* REFERENCE BY :
/* PROGRAM HISTORY : �ű� ����
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
  C_LEAVE_TIME       CONSTANT HRD_DAY_LEAVE_OT.OT_TYPE%TYPE := '11';       -- ����ð�.
  C_LATE_TIME        CONSTANT HRD_DAY_LEAVE_OT.OT_TYPE%TYPE := '12';       -- ����/����.
  C_REST_TIME        CONSTANT HRD_DAY_LEAVE_OT.OT_TYPE%TYPE := '13';       -- �޽Ŀ���.
  C_OVER_TIME        CONSTANT HRD_DAY_LEAVE_OT.OT_TYPE%TYPE := '14';       -- ����.
  C_HOLIDAY_TIME     CONSTANT HRD_DAY_LEAVE_OT.OT_TYPE%TYPE := '15';       -- ���ϱٷ�.
  C_NIGHT_TIME       CONSTANT HRD_DAY_LEAVE_OT.OT_TYPE%TYPE := '16';       -- �߰��ٷ�.
  C_NIGHT_BONUS_TIME CONSTANT HRD_DAY_LEAVE_OT.OT_TYPE%TYPE := '17';       -- �߰�����.
  C_HOLIDAY_OT       CONSTANT HRD_DAY_LEAVE_OT.OT_TYPE%TYPE := '18';       -- ���Ͽ���.

-- �Ⱓ���� ��Ȳ : �׸� ��ȸ.
  PROCEDURE SELECT_PERIOD_TOTAL_SPREAD
            ( P_CURSOR              OUT TYPES.TCURSOR
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE
            , P_WORK_CORP_ID        IN  NUMBER
            , P_CORP_ID             IN  NUMBER
            , P_JOB_CATEGORY_ID     IN  NUMBER
            , P_DEPT_ID             IN  NUMBER
            , P_FLOOR_ID            IN  NUMBER            
            , P_PERSON_ID           IN  NUMBER
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            )
  AS
    V_STATUS              VARCHAR2(4);
    V_MESSAGE             VARCHAR2(300);
      
  BEGIN
    -- �Ⱓ�� ���°� ���� ������ ���� --
    SET_MAIN
      ( P_PERIOD_DATE_FR      => P_PERIOD_DATE_FR
      , P_PERIOD_DATE_TO      => P_PERIOD_DATE_TO
      , P_WORK_CORP_ID        => P_WORK_CORP_ID
      , P_CORP_ID             => P_CORP_ID
      , P_JOB_CATEGORY_ID     => P_JOB_CATEGORY_ID
      , P_DEPT_ID             => P_DEPT_ID
      , P_FLOOR_ID            => P_FLOOR_ID          
      , P_PERSON_ID           => P_PERSON_ID
      , P_CONNECT_PERSON_ID   => P_CONNECT_PERSON_ID
      , P_SOB_ID              => P_SOB_ID
      , P_ORG_ID              => P_ORG_ID
      , P_USER_ID             => GET_USER_ID_F
      , O_STATUS              => V_STATUS
      , O_MESSAGE             => V_MESSAGE
      );
    IF V_STATUS = 'F' THEN
      RAISE_APPLICATION_ERROR(-20001, V_MESSAGE);
      RETURN;
    END IF;
      
    OPEN P_CURSOR FOR
      SELECT PM.PERSON_ID
           , PM.NAME
           , PM.PERSON_NUM
           , T2.FLOOR_NAME
           , MT.HOLIDAY_IN_COUNT
           , MT.LATE_DED_COUNT
           , MT.WEEKLY_DED_COUNT
           , MT.CHANGE_DED_COUNT
           , MT.HOLY_0_COUNT
           , MT.HOLY_1_COUNT
           , MT.HOLY_2_COUNT
           , MT.HOLY_3_COUNT
           , MT.TOTAL_DAY
           , MT.TOTAL_ATT_DAY
           , MT.TOTAL_DED_DAY
           , MT.PAY_DAY
           , MTO.LEAVE_TIME
           , MTO.LATE_TIME
           , MTO.REST_TIME
           , MTO.OVER_TIME
           , MTO.HOLIDAY_TIME
           , MTO.HOLYDAY_OT_TIME
           , MTO.NIGHT_BONUS_TIME
           , MTO.NIGHT_TIME
           , MTD.DUTY_00       -- ���.
           , MTD.DUTY_11       -- ���.
           , MTD.DUTY_54       -- �����ް�.
           , MTD.DUTY_55       -- �����ް�.
           , MTD.UNPAID_COUNT  -- �������ϼ�.
           , T2.DEPT_CODE
           , T2.DEPT_NAME
           , T1.POST_NAME
           , T1.JOB_CATEGORY_NAME
           , PM.JOIN_DATE
           , PM.RETIRE_DATE
        FROM HRM_PERSON_MASTER        PM
           , HRD_PERIOD_TOTAL_GT      MT
           , HRD_PERIOD_TOTAL_OT_V    MTO
           , HRD_PERIOD_TOTAL_DUTY_V  MTD
           , (-- ���� �λ系��.
              SELECT HL.PERSON_ID
                  , HL.DEPT_ID
                  , HL.POST_ID
                  , PC.POST_CODE
                  , PC.POST_NAME
                  , PC.SORT_NUM AS POST_SORT_NUM
                  , HL.JOB_CATEGORY_ID AS JOB_CATEGORY_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                  , HL.FLOOR_ID
                FROM HRM_HISTORY_LINE   HL  
                  , HRM_POST_CODE_V     PC
              WHERE HL.POST_ID          = PC.POST_ID                
                AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                              FROM HRM_HISTORY_LINE S_HL
                                             WHERE S_HL.CHARGE_DATE     <= P_PERIOD_DATE_TO
                                               AND S_HL.PERSON_ID       = HL.PERSON_ID
                                             GROUP BY S_HL.PERSON_ID
                                           )
             ) T1
           , ( -- ���� �λ系��.
               SELECT PH.PERSON_ID
                    , PH.FLOOR_ID
                    , HF.FLOOR_CODE
                    , HF.FLOOR_NAME
                    , HF.SORT_NUM AS FLOOR_SORT_NUM
                    , PH.DEPT_ID
                    , DM.DEPT_CODE
                    , DM.DEPT_NAME
                    , DM.DEPT_SORT_NUM
                    , PH.WORK_TYPE_ID
                 FROM HRD_PERSON_HISTORY PH
                   , HRM_DEPT_MASTER     DM
                   , HRM_FLOOR_V         HF
                WHERE PH.DEPT_ID            = DM.DEPT_ID
                  AND PH.FLOOR_ID           = HF.FLOOR_ID
                  AND PH.SOB_ID             = P_SOB_ID
                  AND PH.ORG_ID             = P_ORG_ID
                  AND PH.EFFECTIVE_DATE_FR  <=  P_PERIOD_DATE_TO
                  AND PH.EFFECTIVE_DATE_TO  >=  P_PERIOD_DATE_TO                 
              ) T2 
        WHERE PM.PERSON_ID          = MT.PERSON_ID
          AND MT.PERSON_ID          = MTO.PERSON_ID(+)
          AND MT.PERSON_ID          = MTD.PERSON_ID(+)
          AND PM.PERSON_ID          = T1.PERSON_ID
          AND PM.PERSON_ID          = T2.PERSON_ID
          AND PM.PERSON_ID          = NVL(P_PERSON_ID, PM.PERSON_ID)
          AND PM.WORK_CORP_ID       = NVL(P_WORK_CORP_ID, PM.WORK_CORP_ID)
          AND PM.CORP_ID            = NVL(P_CORP_ID, PM.CORP_ID)
          AND MT.SOB_ID             = P_SOB_ID
          AND MT.ORG_ID             = P_ORG_ID
          AND ((P_DEPT_ID           IS NULL AND 1 = 1)
          OR   (P_DEPT_ID           IS NOT NULL AND T1.DEPT_ID = P_DEPT_ID))
          AND ((P_FLOOR_ID          IS NULL AND 1 = 1)
          OR   (P_FLOOR_ID          IS NOT NULL AND T2.FLOOR_ID = P_FLOOR_ID))
          AND ((P_JOB_CATEGORY_ID   IS NULL AND 1 = 1)
          OR   (P_JOB_CATEGORY_ID   IS NOT NULL AND T1.JOB_CATEGORY_ID = P_JOB_CATEGORY_ID))
        ORDER BY T2.FLOOR_SORT_NUM, T2.FLOOR_CODE, T1.POST_SORT_NUM, T1.POST_CODE, PM.PERSON_NUM
        ;
  END SELECT_PERIOD_TOTAL_SPREAD;
  

-- �Ⱓ���� ���� MAIN.
  PROCEDURE SET_MAIN
            ( P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE
            , P_WORK_CORP_ID        IN  NUMBER
            , P_CORP_ID             IN  NUMBER
            , P_JOB_CATEGORY_ID     IN  NUMBER
            , P_DEPT_ID             IN  NUMBER
            , P_FLOOR_ID            IN  NUMBER            
            , P_PERSON_ID           IN  NUMBER
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            , O_STATUS              OUT VARCHAR2
            , O_MESSAGE             OUT VARCHAR2
            )
  AS
    V_MONTH_START_DATE                            HRD_DAY_LEAVE.WORK_DATE%TYPE;   -- MONTH_START_DATE.
    V_MONTH_END_DATE                              HRD_DAY_LEAVE.WORK_DATE%TYPE;   -- MONTH_END_DATE.
    V_CAP_C                                       VARCHAR2(1) := 'N';
  BEGIN
    O_STATUS := 'F';
    
    /*-- ó�� ����üũ --
    BEGIN
      V_CAP_C := HRM_MANAGER_G.USER_CAP_F
                   ( P_WORK_CORP_ID
                   , P_PERIOD_DATE_FR
                   , P_PERIOD_DATE_TO
                   , '20'
                   , P_CONNECT_PERSON_ID
                   , P_SOB_ID
                   , P_ORG_ID);
    EXCEPTION WHEN OTHERS THEN
      V_CAP_C := 'N';
    END;
    IF V_CAP_C <> 'C' THEN
      O_STATUS := 'F';
      O_MESSAGE := ERRNUMS.Approval_Nothing_Code || ' ' || ERRNUMS.Approval_Nothing_Desc;
      RETURN;
    END IF;*/

    -- �����ڷ� DELETE.
    BEGIN
      -- �Ⱓ���� �ܾ� ����.
      DELETE FROM HRD_PERIOD_TOTAL_OT_GT MTO;

      -- �Ⱓ ���� ���� ����.
      DELETE FROM HRD_PERIOD_TOTAL_DUTY_GT MTD;

      -- ���ް��� ���� : ���� ����.
      
      -- ������ ����.
      DELETE FROM HRD_PERIOD_TOTAL_GT MT;
      
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;
    -- ������ ���� ó�� ���ν��� ȣ��.
    PERIOD_TOTAL_GO
      ( P_PERIOD_DATE_FR      => P_PERIOD_DATE_FR
      , P_PERIOD_DATE_TO      => P_PERIOD_DATE_TO
      , P_WORK_CORP_ID        => P_WORK_CORP_ID
      , P_CORP_ID             => P_CORP_ID
      , P_JOB_CATEGORY_ID     => P_JOB_CATEGORY_ID
      , P_DEPT_ID             => P_DEPT_ID
      , P_FLOOR_ID            => P_FLOOR_ID          
      , P_PERSON_ID           => P_PERSON_ID
      , P_CONNECT_PERSON_ID   => P_CONNECT_PERSON_ID
      , P_SOB_ID              => P_SOB_ID
      , P_ORG_ID              => P_ORG_ID
      , P_USER_ID             => P_USER_ID
      , O_STATUS              => O_STATUS
      , O_MESSAGE             => O_MESSAGE
      );
    IF O_STATUS = 'F' THEN
      RETURN;
    END IF;
    
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10060', NULL);
  END SET_MAIN;

-- ����� ���� �� ���� ó��.
  PROCEDURE PERIOD_TOTAL_GO
            ( P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE
            , P_WORK_CORP_ID        IN  NUMBER
            , P_CORP_ID             IN  NUMBER
            , P_JOB_CATEGORY_ID     IN  NUMBER
            , P_DEPT_ID             IN  NUMBER
            , P_FLOOR_ID            IN  NUMBER            
            , P_PERSON_ID           IN  NUMBER
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            , O_STATUS              OUT VARCHAR2
            , O_MESSAGE             OUT VARCHAR2
            )
  AS
  
    -- ������ ���� ��� CURSOR.
    CURSOR C_MONTH
           ( W_HOLY_0_DED_FLAG                    VARCHAR2
           )
    IS
    SELECT DL.PERSON_ID 
         , DL.WORK_CORP_ID, DL.CORP_ID, T1.DEPT_ID, T1.POST_ID
         , T1.JOB_CATEGORY_ID, T1.JOB_CATEGORY_CODE
         , T1.ORI_JOIN_DATE, T1.JOIN_DATE, T1.RETIRE_DATE
         , T1.PAY_TYPE
         , T1.EXCEPT_TYPE
         , SUM(DECODE(DL.HOLIDAY_CHECK, 'Y', 1, 0)) AS HOLIDAY_IN_COUNT
         , NVL(SUM(CASE
                     WHEN DC.DUTY_CODE IN('00', '51', '52', '53') AND DL.HOLY_TYPE = '0' THEN 1
                     WHEN DC.DUTY_CODE IN('52') THEN 1  -- ���� : ���������� ����ó��.
                     ELSE 0
                   END), 0) AS HOLY_0_COUNT
         , NVL(SUM(CASE
                     WHEN DC.DUTY_CODE IN('00', '51', '52', '53') AND DL.HOLY_TYPE = '1' THEN 1
                     ELSE 0
                   END), 0) AS HOLY_1_COUNT
         , NVL(SUM(CASE
                     WHEN DC.DUTY_CODE IN('51', '52', '53') THEN 0
                     WHEN DL.HOLY_TYPE = '2' THEN 1
                     ELSE 0
                   END), 0) AS HOLY_2_COUNT
         , NVL(SUM(CASE
                     WHEN DC.DUTY_CODE IN('51', '52', '53') THEN 0
                     WHEN DL.HOLY_TYPE = '3' THEN 1
                     ELSE 0
                   END), 0) AS HOLY_3_COUNT
         , NVL(SUM(DECODE(DC.WORK_YN, 'Y', 1, 0)), 0) AS TOTAL_ATT_DAY
         , NVL(SUM(CASE
                    WHEN DC.DUTY_CODE = '11' THEN 1
                    WHEN DC.NON_PAY_DAY_FLAG = 'Y' THEN 1
                    ELSE 0
                   END), 0) AS TOTAL_DED_DAY
      FROM HRD_DAY_LEAVE_V DL
         , HRM_DUTY_CODE_V DC
         , (-- ���� �λ系��.
            SELECT HL.PERSON_ID
                , HL.DEPT_ID
                , HL.POST_ID
                , NVL(HL.JOB_CATEGORY_ID, PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_ID
                , HRM_COMMON_G.GET_CODE_F(NVL(HL.JOB_CATEGORY_ID, PM.JOB_CATEGORY_ID), PM.SOB_ID, PM.ORG_ID) AS JOB_CATEGORY_CODE
                , NVL(S1.PAY_TYPE, '2') AS PAY_TYPE
                , HL.FLOOR_ID
                , PM.CORP_ID
                , PM.ORI_JOIN_DATE
                , PM.JOIN_DATE
                , PM.RETIRE_DATE
                , PM.SOB_ID
                , PM.ORG_ID
                , CASE
                    WHEN NVL(PM.RETIRE_DATE, P_PERIOD_DATE_TO) < P_PERIOD_DATE_TO THEN 'R'
                    WHEN P_PERIOD_DATE_FR < NVL(PM.JOIN_DATE, PM.ORI_JOIN_DATE) THEN 'I'
                    ELSE 'N'
                  END AS EXCEPT_TYPE
              FROM HRM_HISTORY_LINE HL
                , HRM_PERSON_MASTER PM
                , ( -- �޿�������.
                    SELECT PMH.PERSON_ID
                         , PMH.PAY_TYPE
                      FROM HRP_PAY_MASTER_HEADER PMH
                    WHERE PMH.CORP_ID         = P_WORK_CORP_ID  --
                      AND PMH.PERSON_ID       = NVL(P_PERSON_ID, PMH.PERSON_ID)
                      AND PMH.START_YYYYMM    <= TO_CHAR(P_PERIOD_DATE_TO, 'YYYY-MM')
                      AND PMH.END_YYYYMM      >= TO_CHAR(P_PERIOD_DATE_TO, 'YYYY-MM')
                      AND PMH.SOB_ID          = P_SOB_ID
                      AND PMH.ORG_ID          = P_ORG_ID
                  ) S1
            WHERE HL.PERSON_ID        = PM.PERSON_ID
              AND PM.PERSON_ID        = S1.PERSON_ID(+)
              AND HL.HISTORY_LINE_ID
                    IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                          FROM HRM_HISTORY_LINE S_HL
                         WHERE S_HL.CHARGE_DATE            <= P_PERIOD_DATE_TO
                           AND S_HL.PERSON_ID              = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       )
            ) T1
    WHERE DL.DUTY_ID                = DC.DUTY_ID
      AND DL.SOB_ID                 = DC.SOB_ID
      AND DL.ORG_ID                 = DC.ORG_ID
      AND DL.PERSON_ID              = T1.PERSON_ID
      AND DL.SOB_ID                 = T1.SOB_ID
      AND DL.ORG_ID                 = T1.ORG_ID
-- �ߵ� ��/������� ��� ������� ���̸� ����.
      AND DL.WORK_DATE              BETWEEN CASE
                                              WHEN T1.JOIN_DATE > P_PERIOD_DATE_FR THEN T1.JOIN_DATE
                                              ELSE P_PERIOD_DATE_FR
                                            END
                                        AND CASE
                                              WHEN T1.RETIRE_DATE IS NOT NULL AND T1.RETIRE_DATE < P_PERIOD_DATE_TO THEN T1.RETIRE_DATE
                                              ELSE P_PERIOD_DATE_TO
                                            END
      AND DL.PERSON_ID              = NVL(P_PERSON_ID, DL.PERSON_ID)
      AND DL.WORK_CORP_ID           = P_WORK_CORP_ID
      AND DL.SOB_ID                 = P_SOB_ID
      AND DL.ORG_ID                 = P_ORG_ID
      AND DL.CLOSED_YN              = 'Y'
      AND T1.FLOOR_ID               = NVL(P_FLOOR_ID, T1.FLOOR_ID)
      AND T1.DEPT_ID                = NVL(P_DEPT_ID, T1.DEPT_ID)
      AND T1.JOIN_DATE              <= P_PERIOD_DATE_TO
      AND (T1.RETIRE_DATE IS NULL OR T1.RETIRE_DATE >= P_PERIOD_DATE_FR)
      AND ((P_JOB_CATEGORY_ID      IS NULL
        AND 1                      = 1)
      OR  (P_JOB_CATEGORY_ID       IS NOT NULL
        AND T1.JOB_CATEGORY_ID     = P_JOB_CATEGORY_ID))
    GROUP BY DL.PERSON_ID
         , DL.WORK_CORP_ID
         , DL.CORP_ID
         , T1.DEPT_ID
         , T1.POST_ID
         , T1.JOB_CATEGORY_ID
         , T1.JOB_CATEGORY_CODE
         , T1.ORI_JOIN_DATE
         , T1.JOIN_DATE
         , T1.PAY_TYPE
         , T1.RETIRE_DATE
         , T1.EXCEPT_TYPE
    ;

    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_START_DATE        DATE;
    V_END_DATE          DATE;
    
    V_TOTAL_DAY         NUMBER := 0;
    V_LATE_DED_COUNT    NUMBER := 0; 
    V_WEEK_DED_COUNT    NUMBER := 0;     -- ���ް�����.
    V_TOTAL_DED_DAY     NUMBER := 0;   -- �Ѱ����ϼ�.

    V_STD_HOLY_0_COUNT  NUMBER := 0; 
    V_HOLY_0_DED_FLAG   VARCHAR2(10);
    V_LATE_DED_FLAG     VARCHAR2(10);
    V_LATE_STD_DAY      VARCHAR2(10);
  BEGIN
    
    -- HOLY_0 ���� ���.
    BEGIN
      SELECT NVL(MAX(CT.HOLY_0_FLAG), 'N') AS HOLY_0_FLAG
           , NVL(MAX(CT.LATE_DED_FLAG), 'N') AS LATE_DED_FLAG
           , NVL(MAX(CT.LATE_STD_DAY), 1) AS LATE_STD_DAY
        INTO V_HOLY_0_DED_FLAG
           , V_LATE_DED_FLAG
           , V_LATE_STD_DAY
        FROM HRM_CLOSING_TYPE_V CT
      WHERE CT.CLOSING_TYPE           = 'D2'
        AND CT.SOB_ID                 = P_SOB_ID
        AND CT.ORG_ID                 = P_ORG_ID
        AND CT.EFFECTIVE_DATE_FR      <= P_PERIOD_DATE_TO
        AND (CT.EFFECTIVE_DATE_TO IS NULL OR CT.EFFECTIVE_DATE_TO >= P_PERIOD_DATE_TO)
      GROUP BY CT.CLOSING_TYPE
      ;
    EXCEPTION WHEN OTHERS THEN
      V_HOLY_0_DED_FLAG := 'N';
    END;

---------------------------------------------------------------------------------------------------
    -- ������ ���� ���� �� INSERT.
    FOR C1 IN C_MONTH( W_HOLY_0_DED_FLAG => V_HOLY_0_DED_FLAG)
    LOOP
      -- ���� �������ϼ�.
      V_STD_HOLY_0_COUNT := 0;
      BEGIN
        SELECT COUNT(WC.HOLY_TYPE) AS HOLY_0_COUNT
          INTO V_STD_HOLY_0_COUNT
          FROM HRD_WORK_CALENDAR WC
        WHERE WC.WORK_DATE              BETWEEN P_PERIOD_DATE_FR AND P_PERIOD_DATE_TO
          AND WC.PERSON_ID              = C1.PERSON_ID
          AND WC.SOB_ID                 = P_SOB_ID
          AND WC.ORG_ID                 = P_ORG_ID
          AND WC.HOLY_TYPE              = '0'
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;

      -- ����翡 ���� ����/�������� ����.
      SELECT CASE
               WHEN C1.JOIN_DATE > P_PERIOD_DATE_FR THEN C1.JOIN_DATE
               ELSE P_PERIOD_DATE_FR
             END AS START_DATE
           , CASE
               WHEN C1.RETIRE_DATE IS NOT NULL AND C1.RETIRE_DATE < P_PERIOD_DATE_TO THEN C1.RETIRE_DATE
               ELSE P_PERIOD_DATE_TO
             END AS END_DATE
        INTO V_START_DATE, V_END_DATE
        FROM DUAL
        ;
      -- �� ���ϼ�.
      V_TOTAL_DAY := 0;
      V_TOTAL_DAY := V_END_DATE - V_START_DATE + 1;
      IF V_TOTAL_DAY < 0 THEN
        V_TOTAL_DAY := 0;
      END IF;

---------------------------------------------------------------------------------------------------
      BEGIN
        -- ������ �������� ����.
        PERIOD_TOTAL_OT_GO
          ( P_PERSON_ID           => C1.PERSON_ID
          , P_PERIOD_DATE_FR      => P_PERIOD_DATE_FR
          , P_PERIOD_DATE_TO      => P_PERIOD_DATE_TO 
          , P_CONNECT_PERSON_ID   => P_CONNECT_PERSON_ID
          , P_SOB_ID              => P_SOB_ID
          , P_ORG_ID              => P_ORG_ID
          , P_USER_ID             => P_USER_ID
          , O_STATUS              => O_STATUS
          , O_MESSAGE             => O_MESSAGE 
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;

---------------------------------------------------------------------------------------------------
        -- ������ �������� ����.
        PERIOD_TOTAL_DUTY_GO
          ( P_PERSON_ID           => C1.PERSON_ID
          , P_PERIOD_DATE_FR      => P_PERIOD_DATE_FR
          , P_PERIOD_DATE_TO      => P_PERIOD_DATE_TO 
          , P_CONNECT_PERSON_ID   => P_CONNECT_PERSON_ID
          , P_SOB_ID              => P_SOB_ID
          , P_ORG_ID              => P_ORG_ID
          , P_USER_ID             => P_USER_ID
          , O_STATUS              => O_STATUS
          , O_MESSAGE             => O_MESSAGE 
          );

---------------------------------------------------------------------------------------------------
        /*-- ���ް����ϼ�
        IF C1.PAY_TYPE IN ('1', '3') OR C1.JOB_CATEGORY_CODE = '10' THEN
        -- ������/�������� ����.
          V_WEEK_DED_COUNT := 0;
        ELSE
          V_WEEK_DED_COUNT :=  MONTH_TOTAL_WEEK_DED_F
                                ( W_CORP_ID => C1.CORP_ID
                                , W_START_DATE => V_START_DATE
                                , W_END_DATE => V_END_DATE
                                , W_PERSON_ID => C1.PERSON_ID
                                , W_SOB_ID => W_SOB_ID
                                , W_ORG_ID => W_ORG_ID
                                , P_USER_ID => P_USER_ID
                                );
        END IF;

---------------------------------------------------------------------------------------------------
        -- ������� ���/����.
        V_LATE_DED_COUNT := 0;
        IF V_LATE_DED_FLAG = 'Y' THEN
          BEGIN
            SELECT COUNT(DLO.OT_TIME) AS LATE_COUNT
              INTO V_LATE_DED_COUNT
              FROM HRD_DAY_LEAVE DL
                , HRD_DAY_LEAVE_OT DLO
             WHERE DL.DAY_LEAVE_ID               = DLO.DAY_LEAVE_ID
               AND DL.PERSON_ID                  = C1.PERSON_ID
               AND DL.WORK_DATE                  BETWEEN V_START_DATE AND V_END_DATE
               AND DL.SOB_ID                     = P_SOB_ID
               AND DL.ORG_ID                     = P_ORG_ID
               AND DL.CLOSED_YN                  = 'Y'
               AND DLO.OT_TYPE                   = C_LATE_TIME
               AND DLO.OT_TIME                   <> 0
             ;
          EXCEPTION WHEN OTHERS THEN
            V_LATE_DED_COUNT := 0;
          END;

          BEGIN
            V_LATE_DED_COUNT := TRUNC(V_LATE_DED_COUNT / V_LATE_STD_DAY);
          EXCEPTION WHEN OTHERS THEN
            V_LATE_DED_COUNT := 0;
          END;
        END IF;*/

---------------------------------------------------------------------------------------------------
        -- �Ѱ����ϼ� : �������� ����.
        IF C1.PAY_TYPE IN ('1', '3') AND C1.JOB_CATEGORY_CODE = '10' THEN
        -- ������/�������� ����.
          V_TOTAL_DED_DAY := 0;
        ELSE
          V_TOTAL_DED_DAY := NVL(C1.TOTAL_DED_DAY, 0) + NVL(V_WEEK_DED_COUNT, 0);
        END IF;

        INSERT INTO HRD_PERIOD_TOTAL_GT
        ( PERSON_ID
        , SOB_ID
        , ORG_ID
        , HOLIDAY_IN_COUNT
        , LATE_DED_COUNT
        , WEEKLY_DED_COUNT
        , HOLY_0_COUNT
        , HOLY_1_COUNT
        , HOLY_2_COUNT
        , HOLY_3_COUNT
        , TOTAL_DAY
        , TOTAL_ATT_DAY
        , TOTAL_DED_DAY
        , PAY_DAY
        , HOLY_0_DED_FLAG
        , STD_HOLY_0_COUNT
        )  VALUES
        ( C1.PERSON_ID
        , P_SOB_ID
        , P_ORG_ID
        , C1.HOLIDAY_IN_COUNT
        , V_LATE_DED_COUNT                             ---
        , V_WEEK_DED_COUNT
        , C1.HOLY_0_COUNT
        , C1.HOLY_1_COUNT
        , C1.HOLY_2_COUNT
        , C1.HOLY_3_COUNT
        , V_TOTAL_DAY                                   ---
        , C1.TOTAL_ATT_DAY
        , V_TOTAL_DED_DAY
        , CASE
            WHEN NVL(V_TOTAL_DAY, 0) - (NVL(V_TOTAL_DED_DAY, 0) + NVL(C1.HOLY_0_COUNT, 0)) < 0 THEN 0
            ELSE NVL(V_TOTAL_DAY, 0) - (NVL(V_TOTAL_DED_DAY, 0) + NVL(C1.HOLY_0_COUNT, 0))
          END
        , V_HOLY_0_DED_FLAG                            ---
        , V_STD_HOLY_0_COUNT        
        );
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
      END;
    END LOOP C1;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10060', NULL);
  END PERIOD_TOTAL_GO;

-- �Ⱓ���� �ܾ� ���� ó��.
  PROCEDURE PERIOD_TOTAL_OT_GO
            ( P_PERSON_ID           IN  NUMBER
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE            
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            , O_STATUS              OUT VARCHAR2
            , O_MESSAGE             OUT VARCHAR2
            )
  AS
    V_SYSDATE                   DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_LEAVE_TIME                NUMBER := 0;        -- ����ð� ����.
    V_LATE_TIME                 NUMBER := 0;        -- �����ð�.
    V_REST_TIME                 NUMBER := 0;        -- �޽Ŀ���.
    V_OVER_TIME                 NUMBER := 0;        -- ����ð�.
    V_HOLIDAY_TIME              NUMBER := 0;        -- ���ϱٷ�.
    V_HOLIDAY_OT_TIME           NUMBER := 0;        -- ���Ͽ���ٷ�.
    V_NIGHT_TIME                NUMBER := 0;        -- �߰��ٷ�.
    V_NIGHT_BONUS_TIME          NUMBER := 0;        -- �߰�����.

    V_TOT_LEAVE_TIME            NUMBER := 0;        -- ����ð� ����.
    V_TOT_LATE_TIME             NUMBER := 0;        -- �����ð�.
    V_TOT_REST_TIME             NUMBER := 0;        -- �޽Ŀ���.
    V_TOT_OVER_TIME             NUMBER := 0;        -- ����ð�.
    V_TOT_HOLIDAY_TIME          NUMBER := 0;        -- ���ϱٷ�.
    V_TOT_HOLIDAY_OT_TIME       NUMBER := 0;        -- ���Ͽ���ٷ�.
    V_TOT_NIGHT_TIME            NUMBER := 0;        -- �߰��ٷ�.
    V_TOT_NIGHT_BONUS_TIME      NUMBER := 0;        -- �߰�����.

  BEGIN
    O_STATUS := 'F';
    V_TOT_LEAVE_TIME            := 0;        -- ����ð� ����.
    V_TOT_LATE_TIME             := 0;        -- �����ð�.
    V_TOT_REST_TIME             := 0;        -- �޽Ŀ���.
    V_TOT_OVER_TIME             := 0;        -- ����ð�.
    V_TOT_HOLIDAY_TIME          := 0;        -- ���ϱٷ�.
    V_TOT_HOLIDAY_OT_TIME       := 0;        -- ���Ͽ���ٷ�.
    V_TOT_NIGHT_TIME            := 0;        -- �߰��ٷ�.
    V_TOT_NIGHT_BONUS_TIME      := 0;        -- �߰�����.
    FOR C1 IN ( SELECT DL.WORK_DATE
                     , DL.LEAVE_TIME
                     , DL.LATE_TIME
                     , DL.REST_TIME
                     , DL.OVER_TIME
                     , DL.HOLIDAY_TIME
                     , DL.HOLIDAY_OT_TIME
                     , DL.NIGHT_TIME
                     , DL.NIGHT_BONUS_TIME
                     , DL.PERSON_ID
                     , DL.WORK_CORP_ID
                     , DL.CORP_ID
                     , DL.SOB_ID
                     , DL.ORG_ID
                  FROM HRD_DAY_LEAVE_V1 DL
                    , HRM_JOB_CATEGORY_CODE_V JC
                 WHERE DL.JOB_CATEGORY_ID         = JC.JOB_CATEGORY_ID
                   AND DL.PERSON_ID               = P_PERSON_ID
                   AND DL.WORK_DATE               BETWEEN P_PERIOD_DATE_FR AND P_PERIOD_DATE_TO 
                   AND DL.SOB_ID                  = P_SOB_ID
                   AND DL.ORG_ID                  = P_ORG_ID
                   AND DL.CLOSED_YN               = 'Y'
                ORDER BY DL.PERSON_ID, DL.WORK_DATE
              )
    LOOP
      V_LEAVE_TIME        := 0;        -- ����ð� ����.
      V_LATE_TIME         := 0;        -- �����ð�.
      V_REST_TIME         := 0;        -- �޽Ŀ���.
      V_OVER_TIME         := 0;        -- ����ð�.
      V_HOLIDAY_TIME      := 0;        -- ���ϱٷ�.
      V_HOLIDAY_OT_TIME   := 0;        -- ���Ͽ���ٷ�.
      V_NIGHT_TIME        := 0;        -- �߰��ٷ�.
      V_NIGHT_BONUS_TIME  := 0;        -- �߰�����.

      -- �ܾ� ���� ����. --
      V_LEAVE_TIME        := C1.LEAVE_TIME;       -- ����ð� ����.
      V_LATE_TIME         := C1.LATE_TIME;        -- �����ð�.
      V_REST_TIME         := C1.REST_TIME;        -- �޽Ŀ���.
      V_OVER_TIME         := C1.OVER_TIME;        -- ����ð�.
      V_HOLIDAY_TIME      := C1.HOLIDAY_TIME;     -- ���ϱٷ�.
      V_HOLIDAY_OT_TIME   := C1.HOLIDAY_OT_TIME;  -- ���Ͽ���ٷ�.
      V_NIGHT_TIME        := C1.NIGHT_TIME;       -- �߰��ٷ�.
      V_NIGHT_BONUS_TIME  := C1.NIGHT_BONUS_TIME; -- �߰�����.

      -- ������ ������� ����(�޿�����)���� �׸�ŭ ���ҽ�Ű�� ���� �ð��� 0���� ����--
      IF NVL(V_LEAVE_TIME, 0) > 0 THEN
        IF NVL(V_LEAVE_TIME, 0) <= NVL(V_REST_TIME, 0) THEN
          V_REST_TIME := NVL(V_REST_TIME, 0) - NVL(V_LEAVE_TIME, 0);
          V_LEAVE_TIME := 0;
        ELSIF NVL(V_LEAVE_TIME, 0) <= (NVL(V_REST_TIME, 0) + NVL(V_HOLIDAY_OT_TIME, 0)) THEN
          V_HOLIDAY_OT_TIME := NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_REST_TIME, 0);
          V_HOLIDAY_OT_TIME := NVL(V_HOLIDAY_OT_TIME, 0) - NVL(V_LEAVE_TIME, 0);
          V_REST_TIME := 0;
          V_LEAVE_TIME := 0;
        ELSIF NVL(V_LEAVE_TIME, 0) <= (NVL(V_REST_TIME, 0)+ NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_HOLIDAY_TIME, 0)) THEN
          V_HOLIDAY_TIME := NVL(V_HOLIDAY_TIME, 0) + NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_REST_TIME, 0);
          V_HOLIDAY_TIME := NVL(V_HOLIDAY_TIME, 0) - NVL(V_LEAVE_TIME, 0);
          V_HOLIDAY_OT_TIME := 0;
          V_REST_TIME := 0;
          V_LEAVE_TIME := 0;
        ELSIF NVL(V_LEAVE_TIME, 0) <= (NVL(V_REST_TIME, 0)+ NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_HOLIDAY_TIME, 0) + NVL(V_OVER_TIME, 0)) THEN
          V_OVER_TIME := NVL(V_OVER_TIME, 0) + NVL(V_HOLIDAY_TIME, 0) + NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_REST_TIME, 0);
          V_OVER_TIME := NVL(V_OVER_TIME, 0) - NVL(V_LEAVE_TIME, 0);
          V_HOLIDAY_OT_TIME := 0;
          V_HOLIDAY_TIME := 0;
          V_REST_TIME := 0;
          V_LEAVE_TIME := 0;
        ELSE
          V_LEAVE_TIME := NVL(V_LEAVE_TIME, 0) - (NVL(V_OVER_TIME, 0) + NVL(V_HOLIDAY_TIME, 0) + NVL(V_HOLIDAY_OT_TIME, 0) + NVL(V_REST_TIME, 0));
          V_OVER_TIME := 0;
          V_REST_TIME := 0;
        END IF;
      END IF;
      -- ����/������ ������� ����(�޿�����)���� �׸�ŭ ���ҽ�Ű�� ����/���� �ð��� 0���� ����--
      IF NVL(V_LATE_TIME, 0) > 0 THEN
        IF NVL(V_LATE_TIME, 0) <= NVL(V_REST_TIME, 0) THEN
          V_REST_TIME := NVL(V_REST_TIME, 0) - NVL(V_LATE_TIME, 0);
          V_LATE_TIME := 0;
        ELSIF NVL(V_LATE_TIME, 0) <= (NVL(V_REST_TIME, 0) + NVL(V_OVER_TIME, 0)) THEN
          V_OVER_TIME := NVL(V_OVER_TIME, 0) + NVL(V_REST_TIME, 0);
          V_OVER_TIME := NVL(V_OVER_TIME, 0) -  NVL(V_LATE_TIME, 0);
          V_REST_TIME := 0;
          V_LATE_TIME := 0;
        ELSE
          V_LATE_TIME := NVL(V_LATE_TIME, 0) - (NVL(V_OVER_TIME, 0) + NVL(V_REST_TIME, 0));
          V_OVER_TIME := 0;
          V_REST_TIME := 0;
        END IF;
      END IF;

      -- �հ� --
      V_TOT_LEAVE_TIME        := NVL(V_TOT_LEAVE_TIME, 0) + NVL(V_LEAVE_TIME, 0);             -- ����ð� ����.
      V_TOT_LATE_TIME         := NVL(V_TOT_LATE_TIME, 0) + NVL(V_LATE_TIME, 0);               -- �����ð�.
      V_TOT_REST_TIME         := NVL(V_TOT_REST_TIME, 0) + NVL(V_REST_TIME, 0);               -- �޽Ŀ���.
      V_TOT_OVER_TIME         := NVL(V_TOT_OVER_TIME, 0) + NVL(V_OVER_TIME, 0);               -- ����ð�.
      V_TOT_HOLIDAY_TIME      := NVL(V_TOT_HOLIDAY_TIME, 0) + NVL(V_HOLIDAY_TIME, 0);         -- ���ϱٷ�.
      V_TOT_HOLIDAY_OT_TIME   := NVL(V_TOT_HOLIDAY_OT_TIME, 0) + NVL(V_HOLIDAY_OT_TIME, 0);   -- ���Ͽ���ٷ�.
      V_TOT_NIGHT_TIME        := NVL(V_TOT_NIGHT_TIME, 0) + NVL(V_NIGHT_TIME, 0);             -- �߰��ٷ�.
      V_TOT_NIGHT_BONUS_TIME  := NVL(V_TOT_NIGHT_BONUS_TIME, 0) + NVL(V_NIGHT_BONUS_TIME, 0); -- �߰�����.

    END LOOP C1;
    -- �ܾ��ð� �հ� ����.
    -- LEAVE_TIME.
    SAVE_OT_TIME
      ( P_PERSON_ID      => P_PERSON_ID
      , P_SOB_ID         => P_SOB_ID
      , P_ORG_ID         => P_ORG_ID
      , P_OT_TYPE        => C_LEAVE_TIME
      , P_OT_TIME        => V_TOT_LEAVE_TIME
      , P_USER_ID        => P_USER_ID
      );
    -- LATE_TIME.
    SAVE_OT_TIME
      ( P_PERSON_ID      => P_PERSON_ID
      , P_SOB_ID         => P_SOB_ID
      , P_ORG_ID         => P_ORG_ID
      , P_OT_TYPE        => C_LATE_TIME
      , P_OT_TIME        => V_TOT_LATE_TIME
      , P_USER_ID        => P_USER_ID
      );
    -- REST_TIME.
    SAVE_OT_TIME
      ( P_PERSON_ID      => P_PERSON_ID
      , P_SOB_ID         => P_SOB_ID
      , P_ORG_ID         => P_ORG_ID
      , P_OT_TYPE        => C_REST_TIME
      , P_OT_TIME        => V_TOT_REST_TIME
      , P_USER_ID        => P_USER_ID
      );
    -- OVER_TIME.
    SAVE_OT_TIME
      ( P_PERSON_ID      => P_PERSON_ID
      , P_SOB_ID         => P_SOB_ID
      , P_ORG_ID         => P_ORG_ID
      , P_OT_TYPE        => C_OVER_TIME
      , P_OT_TIME        => V_TOT_OVER_TIME
      , P_USER_ID        => P_USER_ID
      );
    -- HOLIDAY_TIME.
    SAVE_OT_TIME
      ( P_PERSON_ID      => P_PERSON_ID
      , P_SOB_ID         => P_SOB_ID
      , P_ORG_ID         => P_ORG_ID
      , P_OT_TYPE        => C_HOLIDAY_TIME
      , P_OT_TIME        => V_TOT_HOLIDAY_TIME
      , P_USER_ID        => P_USER_ID
      );
    -- HOLIDAY_OT_TIME.
    SAVE_OT_TIME
      ( P_PERSON_ID      => P_PERSON_ID
      , P_SOB_ID         => P_SOB_ID
      , P_ORG_ID         => P_ORG_ID
      , P_OT_TYPE        => C_HOLIDAY_OT
      , P_OT_TIME        => V_TOT_HOLIDAY_OT_TIME
      , P_USER_ID        => P_USER_ID
      );
    -- NIGHT_TIME.
    SAVE_OT_TIME
      ( P_PERSON_ID      => P_PERSON_ID
      , P_SOB_ID         => P_SOB_ID
      , P_ORG_ID         => P_ORG_ID
      , P_OT_TYPE        => C_NIGHT_TIME
      , P_OT_TIME        => V_TOT_NIGHT_TIME
      , P_USER_ID        => P_USER_ID
      );
    -- NIGHT_BONUS_TIME.
    SAVE_OT_TIME
      ( P_PERSON_ID      => P_PERSON_ID
      , P_SOB_ID         => P_SOB_ID
      , P_ORG_ID         => P_ORG_ID
      , P_OT_TYPE        => C_NIGHT_BONUS_TIME
      , P_OT_TIME        => V_TOT_NIGHT_BONUS_TIME
      , P_USER_ID        => P_USER_ID
      );
    O_STATUS := 'S';
    O_MESSAGE := 'OK';
  EXCEPTION WHEN OTHERS THEN
    O_STATUS := 'F';
    O_MESSAGE := 'OT Error : ' || SUBSTR(SQLERRM, 1, 150);
  END PERIOD_TOTAL_OT_GO;

-- �Ⱓ���� ���� ���� ó��.
  PROCEDURE PERIOD_TOTAL_DUTY_GO
            ( P_PERSON_ID           IN  NUMBER
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE            
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            , O_STATUS              OUT VARCHAR2
            , O_MESSAGE             OUT VARCHAR2
            )
  AS
    V_SYSDATE                 DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_HOLY_0_DUTY_ID          NUMBER := NULL;
    V_HOLY_1_DUTY_ID          NUMBER := NULL;
  BEGIN
    BEGIN
      SELECT MAX(DECODE(DC.ATTEND_FLAG, 'NH', DC.DUTY_ID, NULL)) AS HOLY_0_DUTY_ID
          , MAX(DECODE(DC.ATTEND_FLAG, 'H', DC.DUTY_ID, NULL)) AS HOLY_1_DUTY_ID
        INTO V_HOLY_0_DUTY_ID, V_HOLY_1_DUTY_ID
        FROM HRM_DUTY_CODE_V DC
      WHERE DC.SOB_ID             = P_SOB_ID
        AND DC.ORG_ID             = P_ORG_ID
        AND DC.ATTEND_FLAG        IN('H', 'NH')
        AND DC.EFFECTIVE_DATE_FR  <= P_PERIOD_DATE_TO
        AND (DC.EFFECTIVE_DATE_TO IS NULL OR DC.EFFECTIVE_DATE_TO >= P_PERIOD_DATE_FR)
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;

    INSERT INTO HRD_PERIOD_TOTAL_DUTY_GT
    ( PERSON_ID 
    , SOB_ID
    , ORG_ID
    , DUTY_ID
    , DUTY_COUNT
    )
    SELECT DL.PERSON_ID
         , DL.SOB_ID
         , DL.ORG_ID
         , CASE
             WHEN DL.HOLY_TYPE = '0' AND DC.ATTEND_FLAG IN('H', 'NH') THEN V_HOLY_0_DUTY_ID
             WHEN DL.HOLY_TYPE = '1' AND DC.ATTEND_FLAG IN('H', 'NH') THEN V_HOLY_1_DUTY_ID
             ELSE DL.DUTY_ID
           END DUTY_ID
         , SUM(DC.APPLY_DAY) AS DUTY_COUNT         
      FROM HRD_DAY_LEAVE_V DL
         , HRM_DUTY_CODE_V DC
    WHERE DL.DUTY_ID                = DC.DUTY_ID
      AND DL.SOB_ID                 = DC.SOB_ID
      AND DL.ORG_ID                 = DC.ORG_ID
      AND DL.WORK_DATE              BETWEEN P_PERIOD_DATE_FR AND P_PERIOD_DATE_TO
      AND DL.PERSON_ID              = P_PERSON_ID
      AND DL.SOB_ID                 = P_SOB_ID
      AND DL.ORG_ID                 = P_ORG_ID
      AND DL.CLOSED_YN              = 'Y'
    GROUP BY DL.PERSON_ID
           , DL.SOB_ID
           , DL.ORG_ID
           , CASE
               WHEN DL.HOLY_TYPE = '0' AND DC.ATTEND_FLAG IN('H', 'NH') THEN V_HOLY_0_DUTY_ID
               WHEN DL.HOLY_TYPE = '1' AND DC.ATTEND_FLAG IN('H', 'NH') THEN V_HOLY_1_DUTY_ID
               ELSE DL.DUTY_ID
             END
    ;

  END PERIOD_TOTAL_DUTY_GO;

-- �Ⱓ���� ���ް��� ��� : �Ի����ڿ� ���� ���ް��� ���.
  FUNCTION JOIN_DATE_WEEK_DED_F
            ( P_PERSON_ID           IN  NUMBER
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE            
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            ) RETURN NUMBER
  AS
    V_ADD_DAY                     NUMBER := 0;
    V_CHECK_DAY                   NUMBER := 0;
    V_WEEK_DED_COUNT              NUMBER := 0;
  BEGIN
    BEGIN
      -- �ӽ����̺� ����.
      DELETE FROM HRD_WORK_DATE_GT WD
      WHERE WD.PERSON_ID            = P_PERSON_ID
        AND WD.SOB_ID               = P_SOB_ID
        AND WD.ORG_ID               = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    -- �ش� �Ⱓ�� �Ի��� ��ȸ.
    FOR C1 IN ( SELECT PM.JOIN_DATE AS WORK_DATE
                     , PM.PERSON_ID
                     , PM.WORK_CORP_ID
                     , PM.CORP_ID
                     , PM.SOB_ID
                     , PM.ORG_ID
                  FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID              = P_PERSON_ID
                  AND PM.SOB_ID                 = P_SOB_ID
                  AND PM.ORG_ID                 = P_ORG_ID
                  AND PM.JOIN_DATE              BETWEEN P_PERIOD_DATE_FR AND P_PERIOD_DATE_TO
               )
    LOOP
      V_ADD_DAY := 7;
      BEGIN
        SELECT CASE
                 WHEN WC.ATTRIBUTE5 IN ('32') THEN 6  -- ����, ���� ��.
                 ELSE 7
               END AS WORK_TYPE_GROUP
          INTO V_ADD_DAY
          FROM HRD_WORK_CALENDAR WC
        WHERE WC.WORK_DATE        = C1.WORK_DATE
          AND WC.PERSON_ID        = C1.PERSON_ID
          AND WC.SOB_ID           = C1.SOB_ID
          AND WC.ORG_ID           = C1.ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_ADD_DAY := 7;
      END;
      V_ADD_DAY := V_ADD_DAY  - 1;

      INSERT INTO HRD_WORK_DATE_GT
      ( WORK_DATE, OPEN_TIME, PERSON_ID
      , WORK_CORP_ID, CORP_ID
      , SOB_ID, ORG_ID
      )
      SELECT C1.WORK_DATE AS WORK_DATE  -- �߻�����.
          , MIN(SX1.WORK_DATE) AS DED_DATE  -- ���ް�������.
          , SX1.PERSON_ID
          , SX1.WORK_CORP_ID
          , SX1.CORP_ID
          , SX1.SOB_ID
          , SX1.ORG_ID
        FROM (SELECT ROWNUM AS ROW_NUM
                  , WC.WORK_DATE
                  , WC.PERSON_ID
                  , WC.WORK_CORP_ID
                  , WC.CORP_ID
                  , WC.SOB_ID
                  , WC.ORG_ID
                FROM HRD_WORK_CALENDAR WC
              WHERE WC.WORK_DATE            BETWEEN C1.WORK_DATE AND C1.WORK_DATE + V_ADD_DAY
                AND WC.PERSON_ID            = C1.PERSON_ID
                AND WC.SOB_ID               = C1.SOB_ID
                AND WC.ORG_ID               = C1.ORG_ID
                AND NOT EXISTS
                      ( SELECT 'X'
                          FROM HRD_HOLIDAY_CALENDAR HC
                        WHERE HC.WORK_DATE    = WC.WORK_DATE
                          AND HC.SOB_ID       = WC.SOB_ID
                          AND HC.ORG_ID       = WC.ORG_ID
                          /*AND HC.ALL_CHECK    = CASE
                                                  WHEN WC.ATTRIBUTE5 IN('32') THEN 'Y'
                                                  ELSE HC.ALL_CHECK
                                                END*/
                      )
                AND WC.HOLY_TYPE            IN '1'
                AND EXISTS
                      ( SELECT 'X'
                          FROM HRM_DUTY_CODE_V DC
                         WHERE DC.DUTY_ID   = NVL(WC.C_DUTY_ID1, NVL(WC.C_DUTY_ID, WC.DUTY_ID))
                           AND DC.DUTY_CODE IN('51')
                      )
              ORDER BY WC.WORK_DATE
             ) SX1
      WHERE SX1.ROW_NUM           <= 1
      GROUP BY SX1.PERSON_ID
          , SX1.WORK_CORP_ID
          , SX1.CORP_ID
          , SX1.SOB_ID
          , SX1.ORG_ID
      ;

      -- �Ի����ڿ� ������ �ٹ����ڿ� ���ؼ� �ٹ��ϼ��� üũ�Ͽ� �ش��ֿ� ���� ���ٿ��� üũ.
      BEGIN
        SELECT OPEN_TIME - WORK_DATE AS CHECK_DAY
          INTO V_CHECK_DAY
          FROM HRD_WORK_DATE_GT WD
        WHERE WD.WORK_DATE            = C1.WORK_DATE
          AND WD.PERSON_ID            = C1.PERSON_ID
          AND WD.SOB_ID               = C1.SOB_ID
          AND WD.ORG_ID               = C1.ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_CHECK_DAY := 0;
      END;

      -- �Ի����ڿ� ������ �ٹ����ڿ� ���ؼ� �ٹ��ϼ��� üũ�Ͽ� �ش��ֿ� ���� ���ٿ��� ���� ��� ���ް��� ���� ����.
      BEGIN
        DELETE FROM HRD_WORK_DATE_GT WD
        WHERE WD.WORK_DATE            = C1.WORK_DATE
          AND WD.PERSON_ID            = C1.PERSON_ID
          AND WD.SOB_ID               = C1.SOB_ID
          AND WD.ORG_ID               = C1.ORG_ID
          AND NVL(V_ADD_DAY, 0)       = NVL(V_CHECK_DAY, 1)
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
    END LOOP C1;

    -- ���ް��� ���̺� �ݿ�.
    FOR C1 IN ( SELECT DISTINCT MIN(WD.WORK_DATE) AS WORK_DATE, WD.OPEN_TIME AS DED_DATE  -- �ٹ�����, ��������.
                  FROM HRD_WORK_DATE_GT WD
                WHERE WD.WORK_DATE            BETWEEN P_PERIOD_DATE_FR AND P_PERIOD_DATE_TO   -- �ٹ����� ����.
                  AND WD.PERSON_ID            = P_PERSON_ID
                  AND WD.SOB_ID               = P_SOB_ID
                  AND WD.ORG_ID               = P_ORG_ID
                GROUP BY WD.OPEN_TIME
               )
    LOOP
      UPDATE HRD_WEEKLY_DED_GT WD
        SET WD.DED_DATE           = C1.DED_DATE
      WHERE WD.PERSON_ID          = P_PERSON_ID
        AND WD.WORK_DATE          = C1.WORK_DATE
        AND WD.SOB_ID             = P_SOB_ID
        AND WD.ORG_ID             = P_ORG_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO HRD_WEEKLY_DED_GT
        ( PERSON_ID
        , SOB_ID
        , ORG_ID
        , WORK_DATE
        , DED_DATE
        ) VALUES
        ( P_PERSON_ID
        , P_SOB_ID
        , P_ORG_ID
        , C1.WORK_DATE  -- �ٹ�����
        , C1.DED_DATE -- ��������.
        );
      END IF;
    END LOOP C1;

    -- ���ް����� RETURN.
    BEGIN
      SELECT COUNT(DISTINCT WORK_DATE) AS WEEK_DED_COUNT
        INTO V_WEEK_DED_COUNT
        FROM HRD_WORK_DATE_GT WD
      WHERE WD.WORK_DATE            BETWEEN P_PERIOD_DATE_FR AND P_PERIOD_DATE_TO
        AND WD.PERSON_ID            = P_PERSON_ID
        AND WD.SOB_ID               = P_SOB_ID
        AND WD.ORG_ID               = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_WEEK_DED_COUNT := 0;
    END;
    RETURN V_WEEK_DED_COUNT;
  END JOIN_DATE_WEEK_DED_F;


-- ����/���� 4H �̻��ڿ� ���� ���ް��� ���.
  FUNCTION LATE_TIME_WEEK_DED_F
            ( P_PERSON_ID           IN  NUMBER
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE            
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            ) RETURN NUMBER
  AS
    V_ADD_DAY                     NUMBER := 0;
    V_WEEK_DED_COUNT              NUMBER := 0;
  BEGIN
    BEGIN
      -- �ӽ����̺� ����.
      DELETE FROM HRD_WORK_DATE_GT WD
      WHERE WD.PERSON_ID            = P_PERSON_ID
        AND WD.SOB_ID               = P_SOB_ID
        AND WD.ORG_ID               = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;

    -- ����/����ð� 4H �̻�.
    FOR C1 IN ( SELECT DL.DUTY_ID
                     , DL.WORK_DATE
                     , DL.PERSON_ID
                     , DL.WORK_CORP_ID
                     , DL.CORP_ID
                     , DL.SOB_ID
                     , DL.ORG_ID
                  FROM HRD_DAY_LEAVE_V1 DL
                    , HRM_DUTY_CODE_V DC
                WHERE DL.DUTY_ID                = DC.DUTY_ID
                  AND DL.WORK_DATE              BETWEEN P_PERIOD_DATE_FR AND P_PERIOD_DATE_TO
                  AND DL.PERSON_ID              = P_PERSON_ID
                  AND DL.SOB_ID                 = P_SOB_ID
                  AND DL.ORG_ID                 = P_ORG_ID
                  AND (DC.DUTY_CODE             IN ('52', '53', '54')
                  OR DL.HOLY_TYPE               NOT IN('0', '1'))  -- ������ ����.
                  AND DL.CLOSED_YN              = 'Y'
                  AND ((NVL(DL.LATE_TIME, 0) + NVL(DL.LEAVE_TIME, 0)) > 4
                  AND ((NVL(DL.OVER_TIME, 0) + NVL(DL.REST_TIME, 0)) - (NVL(DL.LATE_TIME, 0) + NVL(DL.LEAVE_TIME, 0))) < 0)
               )
    LOOP
      V_ADD_DAY := 7;
      BEGIN
        SELECT CASE
                 WHEN WC.ATTRIBUTE5 IN ('32') THEN 6  -- ����, ���� ��.
                 ELSE 7
               END AS WORK_TYPE_GROUP
          INTO V_ADD_DAY
          FROM HRD_WORK_CALENDAR WC
        WHERE WC.WORK_DATE        = C1.WORK_DATE
          AND WC.PERSON_ID        = C1.PERSON_ID
          AND WC.SOB_ID           = C1.SOB_ID
          AND WC.ORG_ID           = C1.ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_ADD_DAY := 7;
      END;
      V_ADD_DAY := V_ADD_DAY  - 1;

      INSERT INTO HRD_WORK_DATE_GT
      ( WORK_DATE, OPEN_TIME, PERSON_ID
      , WORK_CORP_ID, CORP_ID
      , SOB_ID, ORG_ID
      )
      SELECT C1.WORK_DATE AS WORK_DATE  -- �߻�����.
          , MIN(SX1.WORK_DATE) AS DED_DATE  -- ���ް�������.
          , SX1.PERSON_ID
          , SX1.WORK_CORP_ID
          , SX1.CORP_ID
          , SX1.SOB_ID
          , SX1.ORG_ID
        FROM (SELECT ROWNUM AS ROW_NUM
                  , WC.WORK_DATE
                  , WC.PERSON_ID
                  , WC.WORK_CORP_ID
                  , WC.CORP_ID
                  , WC.SOB_ID
                  , WC.ORG_ID
                FROM HRD_WORK_CALENDAR WC
              WHERE WC.WORK_DATE            BETWEEN C1.WORK_DATE AND C1.WORK_DATE + V_ADD_DAY
                AND WC.PERSON_ID            = C1.PERSON_ID
                AND WC.SOB_ID               = C1.SOB_ID
                AND WC.ORG_ID               = C1.ORG_ID
                AND NOT EXISTS
                      ( SELECT 'X'
                          FROM HRD_HOLIDAY_CALENDAR HC
                        WHERE HC.WORK_DATE    = WC.WORK_DATE
                          AND HC.SOB_ID       = WC.SOB_ID
                          AND HC.ORG_ID       = WC.ORG_ID
                          /*AND HC.ALL_CHECK    = CASE
                                                  WHEN WC.ATTRIBUTE5 IN('32') THEN 'Y'
                                                  ELSE HC.ALL_CHECK
                                                END*/
                      )
                AND WC.HOLY_TYPE            IN '1'
                AND EXISTS
                      ( SELECT 'X'
                          FROM HRM_DUTY_CODE_V DC
                         WHERE DC.DUTY_ID   = NVL(WC.C_DUTY_ID1, NVL(WC.C_DUTY_ID, WC.DUTY_ID))
                           AND DC.DUTY_CODE IN('51')
                      )
              ORDER BY WC.WORK_DATE
             ) SX1
      WHERE SX1.ROW_NUM           <= 1
      GROUP BY SX1.PERSON_ID
          , SX1.WORK_CORP_ID
          , SX1.CORP_ID
          , SX1.SOB_ID
          , SX1.ORG_ID
      ;
    END LOOP C1;

    -- ���ް��� ���̺� �ݿ�.
    FOR C1 IN ( SELECT DISTINCT MIN(WD.WORK_DATE) AS WORK_DATE, WD.OPEN_TIME AS DED_DATE  -- �ٹ�����, ��������.
                  FROM HRD_WORK_DATE_GT WD
                WHERE WD.WORK_DATE            BETWEEN P_PERIOD_DATE_FR AND P_PERIOD_DATE_TO   -- �ٹ����� ����.
                  AND WD.PERSON_ID            = P_PERSON_ID
                  AND WD.SOB_ID               = P_SOB_ID
                  AND WD.ORG_ID               = P_ORG_ID
                GROUP BY WD.OPEN_TIME
               )
    LOOP
      UPDATE HRD_WEEKLY_DED_GT WD
        SET WD.DED_DATE           = C1.DED_DATE
      WHERE WD.PERSON_ID          = P_PERSON_ID
        AND WD.DED_DATE           = C1.DED_DATE
        AND WD.SOB_ID             = P_SOB_ID
        AND WD.ORG_ID             = P_ORG_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO HRD_WEEKLY_DED_GT
        ( PERSON_ID
        , SOB_ID
        , ORG_ID
        , WORK_DATE
        , DED_DATE
        ) VALUES
        ( P_PERSON_ID
        , P_SOB_ID
        , P_ORG_ID
        , C1.WORK_DATE  -- �ٹ�����
        , C1.DED_DATE -- ��������.
        );
      END IF;
    END LOOP C1;

    -- ���ް����� UPDATE.
    BEGIN
      SELECT COUNT(DISTINCT WORK_DATE) AS WEEK_DED_COUNT
        INTO V_WEEK_DED_COUNT
        FROM HRD_WEEKLY_DED_GT WD
      WHERE WD.DED_DATE             BETWEEN P_PERIOD_DATE_FR AND P_PERIOD_DATE_TO
        AND WD.PERSON_ID            = P_PERSON_ID
        AND WD.SOB_ID               = P_SOB_ID
        AND WD.ORG_ID               = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_WEEK_DED_COUNT := 0;
    END;
    RETURN V_WEEK_DED_COUNT;
  END LATE_TIME_WEEK_DED_F;

-- �Ⱓ���� ���ް��� ���.
  FUNCTION PERIOD_TOTAL_WEEK_DED_F
            ( P_PERSON_ID           IN  NUMBER
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE            
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            ) RETURN NUMBER
  AS
    V_ADD_DAY                     NUMBER := 0;
    V_WEEK_DED_COUNT              NUMBER := 0;
  BEGIN
---------------------------------------------------------------------------------------------------
--   �ű��Ի翡 ���� ���ް����ϼ�
    V_WEEK_DED_COUNT := JOIN_DATE_WEEK_DED_F
                          ( P_PERSON_ID           => P_PERSON_ID                         
                          , P_PERIOD_DATE_FR      => P_PERIOD_DATE_FR
                          , P_PERIOD_DATE_TO      => P_PERIOD_DATE_TO 
                          , P_CONNECT_PERSON_ID   => P_CONNECT_PERSON_ID
                          , P_SOB_ID              => P_SOB_ID
                          , P_ORG_ID              => P_ORG_ID
                          , P_USER_ID             => P_USER_ID
                          );

--   ����/���� 4H�̻� ���� ���ް����ϼ�
    V_WEEK_DED_COUNT := LATE_TIME_WEEK_DED_F
                          ( P_PERSON_ID           => P_PERSON_ID                         
                          , P_PERIOD_DATE_FR      => P_PERIOD_DATE_FR
                          , P_PERIOD_DATE_TO      => P_PERIOD_DATE_TO 
                          , P_CONNECT_PERSON_ID   => P_CONNECT_PERSON_ID
                          , P_SOB_ID              => P_SOB_ID
                          , P_ORG_ID              => P_ORG_ID
                          , P_USER_ID             => P_USER_ID
                          );

    BEGIN
      -- �ӽ����̺� ����.
      DELETE FROM HRD_WORK_DATE_GT WD
      WHERE WD.PERSON_ID            = P_PERSON_ID
        AND WD.SOB_ID               = P_SOB_ID
        AND WD.ORG_ID               = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;

    -- ������� UPDATE.
    FOR C1 IN ( SELECT DL.DUTY_ID
                     , DL.WORK_DATE
                     , DL.PERSON_ID
                     , DL.WORK_CORP_ID
                     , DL.CORP_ID
                     , DL.SOB_ID
                     , DL.ORG_ID
                  FROM HRD_DAY_LEAVE_V DL
                     , HRM_DUTY_CODE_V DC
                WHERE DL.DUTY_ID                = DC.DUTY_ID
                  AND DL.SOB_ID                 = DC.SOB_ID
                  AND DL.ORG_ID                 = DC.ORG_ID
                  AND DL.WORK_DATE              BETWEEN P_PERIOD_DATE_FR AND P_PERIOD_DATE_TO
                  AND DL.PERSON_ID              = P_PERSON_ID
                  AND DL.SOB_ID                 = P_SOB_ID
                  AND DL.ORG_ID                 = P_ORG_ID
                  AND DL.CLOSED_YN              = 'Y'
                  AND DC.DUTY_CODE              IN('11', '31', '54', '78', '95', '97')
               )
    LOOP
      V_ADD_DAY := 7;
      BEGIN
        SELECT CASE
                 WHEN WC.ATTRIBUTE5 IN ('32') THEN 6  -- ����, ���� ��.
                 ELSE 7
               END AS WORK_TYPE_GROUP
          INTO V_ADD_DAY
          FROM HRD_WORK_CALENDAR WC
        WHERE WC.WORK_DATE        = C1.WORK_DATE
          AND WC.PERSON_ID        = C1.PERSON_ID
          AND WC.SOB_ID           = C1.SOB_ID
          AND WC.ORG_ID           = C1.ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_ADD_DAY := 7;
      END;
      V_ADD_DAY := V_ADD_DAY  - 1;

      INSERT INTO HRD_WORK_DATE_GT
      ( WORK_DATE, OPEN_TIME, PERSON_ID
      , WORK_CORP_ID, CORP_ID
      , SOB_ID, ORG_ID
      )
      SELECT C1.WORK_DATE AS WORK_DATE  -- �߻�����.
          , MIN(SX1.WORK_DATE) AS DED_DATE  -- ���ް�������.
          , SX1.PERSON_ID
          , SX1.WORK_CORP_ID
          , SX1.CORP_ID
          , SX1.SOB_ID
          , SX1.ORG_ID
        FROM (SELECT ROWNUM AS ROW_NUM
                  , WC.WORK_DATE
                  , WC.PERSON_ID
                  , WC.WORK_CORP_ID
                  , WC.CORP_ID
                  , WC.SOB_ID
                  , WC.ORG_ID
                FROM HRD_WORK_CALENDAR WC
              WHERE WC.WORK_DATE            BETWEEN C1.WORK_DATE AND C1.WORK_DATE + V_ADD_DAY
                AND WC.PERSON_ID            = C1.PERSON_ID
                AND WC.SOB_ID               = C1.SOB_ID
                AND WC.ORG_ID               = C1.ORG_ID
                AND NOT EXISTS
                      ( SELECT 'X'
                          FROM HRD_HOLIDAY_CALENDAR HC
                        WHERE HC.WORK_DATE    = WC.WORK_DATE
                          AND HC.SOB_ID       = WC.SOB_ID
                          AND HC.ORG_ID       = WC.ORG_ID
                          /*AND HC.ALL_CHECK    = CASE
                                                  WHEN WC.ATTRIBUTE5 IN('32') THEN 'Y'
                                                  ELSE HC.ALL_CHECK
                                                END*/
                      )
                AND WC.HOLY_TYPE            IN '1'
                AND EXISTS
                      ( SELECT 'X'
                          FROM HRM_DUTY_CODE_V DC
                         WHERE DC.DUTY_ID   = NVL(WC.C_DUTY_ID1, NVL(WC.C_DUTY_ID, WC.DUTY_ID))
                           AND DC.DUTY_CODE IN('51')
                      )
              ORDER BY WC.WORK_DATE
             ) SX1
      WHERE SX1.ROW_NUM           <= 1
      GROUP BY SX1.PERSON_ID
          , SX1.WORK_CORP_ID
          , SX1.CORP_ID
          , SX1.SOB_ID
          , SX1.ORG_ID
      ;
    END LOOP C1;

    -- ���ް��� ���̺� �ݿ�.
    FOR C1 IN ( SELECT DISTINCT MIN(WD.WORK_DATE) AS WORK_DATE, WD.OPEN_TIME AS DED_DATE  -- �ٹ�����, ��������.
                  FROM HRD_WORK_DATE_GT WD
                WHERE WD.WORK_DATE            BETWEEN P_PERIOD_DATE_FR AND P_PERIOD_DATE_TO   -- �ٹ����� ����.
                  AND WD.PERSON_ID            = P_PERSON_ID
                  AND WD.SOB_ID               = P_SOB_ID
                  AND WD.ORG_ID               = P_ORG_ID
                GROUP BY WD.OPEN_TIME
               )
    LOOP
      UPDATE HRD_WEEKLY_DED_GT WD
        SET WD.DED_DATE           = C1.DED_DATE
      WHERE WD.PERSON_ID          = P_PERSON_ID
        AND WD.DED_DATE           = C1.DED_DATE
        AND WD.SOB_ID             = P_SOB_ID
        AND WD.ORG_ID             = P_ORG_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO HRD_WEEKLY_DED_GT
        ( PERSON_ID
        , SOB_ID
        , ORG_ID
        , WORK_DATE
        , DED_DATE
        ) VALUES
        ( P_PERSON_ID
        , P_SOB_ID
        , P_ORG_ID
        , C1.WORK_DATE  -- �ٹ�����
        , C1.DED_DATE -- ��������.
        );
      END IF;
    END LOOP C1;

    -- ���ް����� UPDATE.
    BEGIN
      SELECT COUNT(DISTINCT WORK_DATE) AS WEEK_DED_COUNT
        INTO V_WEEK_DED_COUNT
        FROM HRD_WEEKLY_DED_GT WD
      WHERE WD.DED_DATE             BETWEEN P_PERIOD_DATE_TO AND P_PERIOD_DATE_TO
        AND WD.PERSON_ID            = P_PERSON_ID
        AND WD.SOB_ID               = P_SOB_ID
        AND WD.ORG_ID               = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_WEEK_DED_COUNT := 0;
    END;
    RETURN V_WEEK_DED_COUNT;
  END PERIOD_TOTAL_WEEK_DED_F;


-- �Ⱓ���� ���ް��� ��� : �Ի����ڿ� ���� ���ް��� ���.
  FUNCTION ROOKIE_WEEK_DED_F
            ( P_PERSON_ID           IN  NUMBER
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE            
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            ) RETURN NUMBER
  AS
    V_WEEK_DED_COUNT              NUMBER := 0;
    V_WEEK_DATE_FR                DATE;  -- �� ��������--
    V_WEEK_DATE_TO                DATE;  -- �� �������� --

    V_ADD_DAY                     NUMBER := 0;
    V_CHECK_DAY                   NUMBER := 0;
  BEGIN
    /*BEGIN
      -- �ӽ����̺� ����.
      DELETE FROM HRD_WORK_DATE_GT WD
      WHERE WD.PERSON_ID            = P_PERSON_ID
        AND WD.SOB_ID               = P_SOB_ID
        AND WD.ORG_ID               = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    -- �ش� �Ⱓ�� �Ի��� ��ȸ.
    FOR C1 IN ( SELECT PM.JOIN_DATE AS WORK_DATE
                     , PM.PERSON_ID
                     , PM.WORK_CORP_ID
                     , PM.CORP_ID
                     , PM.SOB_ID
                     , PM.ORG_ID
                  FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID              = P_PERSON_ID
                  AND PM.SOB_ID                 = P_SOB_ID
                  AND PM.ORG_ID                 = P_ORG_ID
                  AND PM.JOIN_DATE              BETWEEN P_PERIOD_DATE_FR AND P_PERIOD_DATE_TO
               )
    LOOP
      -- �Ի��� ���� ������ ����/�������� ��ȸ --
      BEGIN
        SELECT DISTINCT
               T1.START_DATE
             , T1.END_DATE
          INTO V_WEEK_DATE_FR
             , V_WEEK_DATE_TO
          FROM (SELECT TO_CHAR((SX1.START_DATE + LEVEL * 7 - 7), 'W') AS WEEK_CODE
                     , TRUNC(SX1.START_DATE, 'IW') + LEVEL * 7 - 7 AS START_DATE
                     , (TRUNC(SX1.START_DATE, 'IW') + LEVEL * 7 - 7) + 6 AS END_DATE
                  FROM (SELECT P_PERIOD_DATE_FR AS START_DATE
                             , P_PERIOD_DATE_TO AS END_DATE
                          FROM DUAL
                       ) SX1
                CONNECT BY LEVEL - 1 <= TRUNC(SX1.END_DATE - SX1.START_DATE) / 7
                UNION ALL
                SELECT TO_CHAR(TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE(W_DUTY_YYYYMM, 'YYYY-MM')), 'W')) +
                       DECODE( TO_CHAR(TRUNC(TO_DATE(W_DUTY_YYYYMM, 'YYYY-MM'), 'MONTH'), 'D'), 1, 1, 0)) AS WEEK_CODE
                     , TRUNC(LAST_DAY(TO_DATE(W_DUTY_YYYYMM, 'YYYY-MM')), 'IW') AS START_DATE
                     , TRUNC(LAST_DAY(TO_DATE(W_DUTY_YYYYMM, 'YYYY-MM')), 'IW') + 6 AS END_DATE
                  FROM DUAL
                ) T1
        WHERE C1.WORK_DATE      BETWEEN T1.START_DATE AND T1.END_DATE
          AND ROWNUM            <= 1
        ;
      EXCEPTION WHEN OTHERS THEN
        RETURN -10;
      END;
      V_ADD_DAY := (V_WEEK_DATE_TO - V_WEEK_DATE_FR) + 1;

      INSERT INTO HRD_WORK_DATE_GT
      ( WORK_DATE, OPEN_TIME, PERSON_ID
      , WORK_CORP_ID, CORP_ID
      , SOB_ID, ORG_ID
      )
      SELECT C1.WORK_DATE AS WORK_DATE  -- �߻�����.
          , MIN(SX1.WORK_DATE) AS DED_DATE  -- ���ް�������.
          , SX1.PERSON_ID
          , SX1.WORK_CORP_ID
          , SX1.CORP_ID
          , SX1.SOB_ID
          , SX1.ORG_ID
        FROM (SELECT ROWNUM AS ROW_NUM
                  , WC.WORK_DATE
                  , WC.PERSON_ID
                  , WC.WORK_CORP_ID
                  , WC.CORP_ID
                  , WC.SOB_ID
                  , WC.ORG_ID
                  , NVL(WC.C_DUTY_ID1, NVL(WC.C_DUTY_ID, WC.DUTY_ID)) AS DUTY_ID
                FROM HRD_WORK_CALENDAR WC
              WHERE WC.PERSON_ID            = C1.PERSON_ID
                AND WC.SOB_ID               = C1.SOB_ID
                AND WC.ORG_ID               = C1.ORG_ID
                AND WC.HOLY_TYPE            IN '1'
                AND WC.WORK_DATE            IN ( SELECT MAX(HWC.WORK_DATE) AS WORK_DATE
                                                   FROM HRD_WORK_CALENDAR HWC
                                                  WHERE HWC.WORK_DATE   BETWEEN V_WEEK_DATE_FR AND V_WEEK_DATE_TO
                                                    AND HWC.PERSON_ID   = C1.PERSON_ID
                                                    AND HWC.SOB_ID      = C1.SOB_ID
                                                    AND HWC.ORG_ID      = C1.ORG_ID
                                                    AND HWC.HOLY_TYPE   = '1'
                                                    AND NOT EXISTS
                                                          ( SELECT 'X'
                                                              FROM HRD_HOLIDAY_CALENDAR HC
                                                            WHERE HC.WORK_DATE    = HWC.WORK_DATE
                                                              AND HC.SOB_ID       = HWC.SOB_ID
                                                              AND HC.ORG_ID       = HWC.ORG_ID
                                                              \*AND HC.ALL_CHECK    = CASE
                                                                                      WHEN HWC.ATTRIBUTE5 IN('32') THEN 'Y'
                                                                                      ELSE HC.ALL_CHECK
                                                                                    END*\
                                                          )
                                               )
                AND EXISTS
                      ( SELECT 'X'
                          FROM HRM_DUTY_CODE_V DC
                         WHERE DC.DUTY_ID   = NVL(WC.C_DUTY_ID1, NVL(WC.C_DUTY_ID, WC.DUTY_ID))
                           AND DC.DUTY_CODE IN('51', '53')
                      )
              ORDER BY WC.WORK_DATE
             ) SX1
      WHERE SX1.ROW_NUM           <= 1
      GROUP BY SX1.PERSON_ID
          , SX1.WORK_CORP_ID
          , SX1.CORP_ID
          , SX1.SOB_ID
          , SX1.ORG_ID
      ;

      -- �Ի����ڿ� ������ �ٹ����ڿ� ���ؼ� �ٹ��ϼ��� üũ�Ͽ� �ش��ֿ� ���� ���ٿ��� üũ.
      BEGIN
        SELECT OPEN_TIME - WORK_DATE AS CHECK_DAY
          INTO V_CHECK_DAY
          FROM HRD_WORK_DATE_GT WD
        WHERE WD.WORK_DATE            = C1.WORK_DATE
          AND WD.PERSON_ID            = C1.PERSON_ID
          AND WD.SOB_ID               = C1.SOB_ID
          AND WD.ORG_ID               = C1.ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_CHECK_DAY := 0;
      END;

      -- �Ի����ڿ� ������ �ٹ����ڿ� ���ؼ� �ٹ��ϼ��� üũ�Ͽ� �ش��ֿ� ���� ���ٿ��� ���� ��� ���ް��� ���� ����.
      BEGIN
        DELETE FROM HRD_WORK_DATE_GT WD
        WHERE WD.WORK_DATE            = C1.WORK_DATE
          AND WD.PERSON_ID            = C1.PERSON_ID
          AND WD.SOB_ID               = C1.SOB_ID
          AND WD.ORG_ID               = C1.ORG_ID
          AND NVL(V_ADD_DAY, 0)       = NVL(V_CHECK_DAY, 1)
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
    END LOOP C1;

    -- ���ް��� ���̺� �ݿ�.
    FOR C1 IN ( SELECT DISTINCT
                       MIN(WD.WORK_DATE) AS WORK_DATE
                     , WD.OPEN_TIME AS DED_DATE  -- �ٹ�����, ��������.
                  FROM HRD_WORK_DATE_GT WD
                WHERE WD.WORK_DATE            BETWEEN P_PERIOD_DATE_FR AND P_PERIOD_DATE_TO   -- �ٹ����� ����.
                  AND WD.PERSON_ID            = P_PERSON_ID
                  AND WD.SOB_ID               = P_SOB_ID
                  AND WD.ORG_ID               = P_ORG_ID
                GROUP BY WD.OPEN_TIME
               )
    LOOP
      UPDATE HRD_WEEKLY_DED_GT WD
        SET WD.DED_DATE           = C1.DED_DATE
      WHERE WD.PERSON_ID          = P_PERSON_ID
        AND WD.DED_DATE           = C1.DED_DATE
        AND WD.SOB_ID             = P_SOB_ID
        AND WD.ORG_ID             = P_ORG_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO HRD_WEEKLY_DED_GT
        ( PERSON_ID
        , SOB_ID
        , ORG_ID
        , WORK_DATE
        , DED_DATE
        ) VALUES
        ( P_PERSON_ID
        , P_SOB_ID
        , P_ORG_ID
        , C1.WORK_DATE  -- �ٹ�����
        , C1.DED_DATE -- ��������.
        );
      END IF;
    END LOOP C1;

    -- ���ް����� UPDATE.
    BEGIN
      SELECT COUNT(DISTINCT WORK_DATE) AS WEEK_DED_COUNT
        INTO V_WEEK_DED_COUNT
        FROM HRD_WORK_DATE_GT WD
      WHERE WD.WORK_DATE            BETWEEN P_PERIOD_DATE_FR AND P_PERIOD_DATE_TO
        AND WD.PERSON_ID            = P_PERSON_ID
        AND WD.SOB_ID               = P_SOB_ID
        AND WD.ORG_ID               = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_WEEK_DED_COUNT := 0;
    END;
    */
    RETURN V_WEEK_DED_COUNT;
  END ROOKIE_WEEK_DED_F;

-- �Ⱓ���� ���ް��� ���.
  FUNCTION MONTH_WEEK_DED_F
            ( P_PERSON_ID           IN  NUMBER
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE            
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_USER_ID             IN  NUMBER
            ) RETURN NUMBER
  AS
    V_WEEK_DED_COUNT              NUMBER := 0;
    V_WEEK_DATE_FR                DATE;  -- �� ��������--
    V_WEEK_DATE_TO                DATE;  -- �� �������� --

    V_ADD_DAY                     NUMBER := 0;
  BEGIN
---------------------------------------------------------------------------------------------------
--   �ű��Ի翡 ���� ���ް����ϼ�
    V_WEEK_DED_COUNT := JOIN_DATE_WEEK_DED_F
                          ( P_PERSON_ID           => P_PERSON_ID
                          , P_PERIOD_DATE_FR      => P_PERIOD_DATE_FR
                          , P_PERIOD_DATE_TO      => P_PERIOD_DATE_TO 
                          , P_CONNECT_PERSON_ID   => P_CONNECT_PERSON_ID
                          , P_SOB_ID              => P_SOB_ID
                          , P_ORG_ID              => P_ORG_ID
                          , P_USER_ID             => P_USER_ID
                          );

    BEGIN
      -- �ӽ����̺� ����.
      DELETE FROM HRD_WORK_DATE_GT WD
      WHERE WD.PERSON_ID            = P_PERSON_ID
        AND WD.SOB_ID               = P_SOB_ID
        AND WD.ORG_ID               = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;

    -- ������� UPDATE.
    FOR C1 IN ( SELECT DL.DUTY_ID
                     , DL.WORK_DATE
                     , DL.PERSON_ID
                     , DL.WORK_CORP_ID
                     , DL.CORP_ID
                     , DL.SOB_ID
                     , DL.ORG_ID
                  FROM HRD_DAY_LEAVE_V DL
                     , HRM_DUTY_CODE_V DC
                WHERE DL.DUTY_ID                = DC.DUTY_ID
                  AND DL.SOB_ID                 = DC.SOB_ID
                  AND DL.ORG_ID                 = DC.ORG_ID
                  AND DL.WORK_DATE              BETWEEN P_PERIOD_DATE_FR AND P_PERIOD_DATE_TO
                  AND DL.PERSON_ID              = P_PERSON_ID
                  AND DL.SOB_ID                 = P_SOB_ID
                  AND DL.ORG_ID                 = P_ORG_ID
                  AND DL.CLOSED_YN              = 'Y'
                  AND DC.DUTY_CODE              IN('11', '31', '54', '78', '95', '97')
               )
    LOOP
      -- ����� ���� ������ ����/�������� ��ȸ --
      BEGIN
        SELECT DISTINCT
               T1.START_DATE
             , T1.END_DATE
          INTO V_WEEK_DATE_FR
             , V_WEEK_DATE_TO
          FROM (SELECT TO_CHAR((SX1.START_DATE + LEVEL * 7 - 7), 'W') AS WEEK_CODE
                     , TRUNC(SX1.START_DATE, 'IW') + LEVEL * 7 - 7 AS START_DATE
                     , (TRUNC(SX1.START_DATE, 'IW') + LEVEL * 7 - 7) + 6 AS END_DATE
                  FROM (SELECT P_PERIOD_DATE_FR AS START_DATE
                             , P_PERIOD_DATE_TO AS END_DATE
                          FROM DUAL
                       ) SX1
                CONNECT BY LEVEL - 1 <= TRUNC(SX1.END_DATE - SX1.START_DATE) / 7
                UNION ALL
                SELECT TO_CHAR(TO_NUMBER(TO_CHAR(LAST_DAY(P_PERIOD_DATE_TO), 'W')) +
                       DECODE( TO_CHAR(TRUNC(P_PERIOD_DATE_FR, 'MONTH'), 'D'), 1, 1, 0)) AS WEEK_CODE
                     , TRUNC(LAST_DAY(P_PERIOD_DATE_TO), 'IW') AS START_DATE
                     , TRUNC(LAST_DAY(P_PERIOD_DATE_TO), 'IW') + 6 AS END_DATE
                  FROM DUAL
                ) T1
        WHERE C1.WORK_DATE      BETWEEN T1.START_DATE AND T1.END_DATE
          AND ROWNUM            <= 1
        ;
      EXCEPTION WHEN OTHERS THEN
        RETURN -10;
      END;
      V_ADD_DAY := (V_WEEK_DATE_TO - V_WEEK_DATE_FR) + 1;

      INSERT INTO HRD_WORK_DATE_GT
      ( WORK_DATE, OPEN_TIME, PERSON_ID
      , WORK_CORP_ID, CORP_ID
      , SOB_ID, ORG_ID
      )
      SELECT C1.WORK_DATE AS WORK_DATE  -- �߻�����.
          , MIN(SX1.WORK_DATE) AS DED_DATE  -- ���ް�������.
          , SX1.PERSON_ID
          , SX1.WORK_CORP_ID
          , SX1.CORP_ID
          , SX1.SOB_ID
          , SX1.ORG_ID
        FROM (SELECT ROWNUM AS ROW_NUM
                  , WC.WORK_DATE
                  , WC.PERSON_ID
                  , WC.WORK_CORP_ID
                  , WC.CORP_ID
                  , WC.SOB_ID
                  , WC.ORG_ID
                  , NVL(WC.C_DUTY_ID1, NVL(WC.C_DUTY_ID, WC.DUTY_ID)) AS DUTY_ID
                FROM HRD_WORK_CALENDAR WC
              WHERE WC.PERSON_ID            = C1.PERSON_ID
                AND WC.SOB_ID               = C1.SOB_ID
                AND WC.ORG_ID               = C1.ORG_ID
                AND WC.HOLY_TYPE            IN '1'
                AND WC.WORK_DATE            IN ( SELECT MAX(HWC.WORK_DATE) AS WORK_DATE
                                                   FROM HRD_WORK_CALENDAR HWC
                                                  WHERE HWC.WORK_DATE   BETWEEN V_WEEK_DATE_FR AND V_WEEK_DATE_TO
                                                    AND HWC.PERSON_ID   = C1.PERSON_ID
                                                    AND HWC.SOB_ID      = C1.SOB_ID
                                                    AND HWC.ORG_ID      = C1.ORG_ID
                                                    AND HWC.HOLY_TYPE   = '1'
                                                    AND NOT EXISTS
                                                          ( SELECT 'X'
                                                              FROM HRD_HOLIDAY_CALENDAR HC
                                                            WHERE HC.WORK_DATE    = HWC.WORK_DATE
                                                              AND HC.SOB_ID       = HWC.SOB_ID
                                                              AND HC.ORG_ID       = HWC.ORG_ID
                                                              /*AND HC.ALL_CHECK    = CASE
                                                                                      WHEN HWC.ATTRIBUTE5 IN('32') THEN 'Y'
                                                                                      ELSE HC.ALL_CHECK
                                                                                    END*/
                                                          )
                                               )
                AND EXISTS
                      ( SELECT 'X'
                          FROM HRM_DUTY_CODE_V DC
                         WHERE DC.DUTY_ID   = NVL(WC.C_DUTY_ID1, NVL(WC.C_DUTY_ID, WC.DUTY_ID))
                           AND DC.DUTY_CODE IN('51', '53')
                      )
              ORDER BY WC.WORK_DATE
             ) SX1
      WHERE SX1.ROW_NUM           <= 1
      GROUP BY SX1.PERSON_ID
          , SX1.WORK_CORP_ID
          , SX1.CORP_ID
          , SX1.SOB_ID
          , SX1.ORG_ID
      ;
    END LOOP C1;

    -- ���ް��� ���̺� �ݿ�.
    FOR C1 IN ( SELECT DISTINCT
                       MIN(WD.WORK_DATE) AS WORK_DATE
                     , WD.OPEN_TIME AS DED_DATE  -- �ٹ�����, ��������.
                  FROM HRD_WORK_DATE_GT WD
                WHERE WD.WORK_DATE            BETWEEN P_PERIOD_DATE_FR AND P_PERIOD_DATE_TO   -- �ٹ����� ����.
                  AND WD.PERSON_ID            = P_PERSON_ID
                  AND WD.SOB_ID               = P_SOB_ID
                  AND WD.ORG_ID               = P_ORG_ID
                GROUP BY WD.OPEN_TIME
               )
    LOOP
      UPDATE HRD_WEEKLY_DED_GT WD
        SET WD.DED_DATE           = C1.DED_DATE
      WHERE WD.PERSON_ID          = P_PERSON_ID
        AND WD.DED_DATE           = C1.DED_DATE
        AND WD.SOB_ID             = P_SOB_ID
        AND WD.ORG_ID             = P_ORG_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO HRD_WEEKLY_DED_GT
        ( PERSON_ID
        , SOB_ID
        , ORG_ID
        , WORK_DATE
        , DED_DATE
        ) VALUES
        ( P_PERSON_ID
        , P_SOB_ID
        , P_ORG_ID
        , C1.WORK_DATE  -- �ٹ�����
        , C1.DED_DATE -- ��������.
        );
      END IF;
    END LOOP C1;

    -- ���ް����� UPDATE.
    BEGIN
      SELECT COUNT(DISTINCT WORK_DATE) AS WEEK_DED_COUNT
        INTO V_WEEK_DED_COUNT
        FROM HRD_WEEKLY_DED_GT WD
      WHERE WD.DED_DATE             BETWEEN P_PERIOD_DATE_FR AND P_PERIOD_DATE_TO
        AND WD.PERSON_ID            = P_PERSON_ID
        AND WD.SOB_ID               = P_SOB_ID
        AND WD.ORG_ID               = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_WEEK_DED_COUNT := 0;
    END;
    RETURN V_WEEK_DED_COUNT;
  END MONTH_WEEK_DED_F;


---------------------------------------------------------------------------------------------------
-- TOT_DED_COUNT ==> CAL.
  PROCEDURE TOT_DED_COUNT_P
            ( P_PERSON_ID           IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE            
            , P_CONNECT_PERSON_ID   IN  NUMBER
            , P_LATE_DED_COUNT      IN  NUMBER
            , P_WEEKLY_DED_COUNT    IN  NUMBER
            , O_TOTAL_DED_COUNT     OUT NUMBER
            , O_PAY_DAY             OUT NUMBER
            )
  AS
    V_TOTAL_DAY               NUMBER := 0;
    V_HOLY_0_COUNT            NUMBER := 0;
    V_TOTAL_DED_COUNT         NUMBER := 0;
    V_PAY_DAY                 NUMBER := 0;

  BEGIN
    BEGIN
      SELECT MT.TOTAL_DAY
           , DECODE(MT.HOLY_0_DED_FLAG, 'Y', MT.HOLY_0_COUNT, 0) AS HOLY_0_COUNT
        INTO V_TOTAL_DAY
           , V_HOLY_0_COUNT
        FROM HRD_PERIOD_TOTAL_GT MT
       WHERE MT.PERSON_ID         = P_PERSON_ID
         AND MT.SOB_ID            = P_SOB_ID
         AND MT.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_TOTAL_DAY := 0;
    END;
    V_TOTAL_DED_COUNT := NON_PAY_DAY_F( P_PERSON_ID  
                                      , P_SOB_ID     
                                      , P_ORG_ID     
                                      , P_PERIOD_DATE_FR   
                                      , P_PERIOD_DATE_TO               
                                      , P_CONNECT_PERSON_ID )
                       + NVL(P_LATE_DED_COUNT, 0) + NVL(P_WEEKLY_DED_COUNT, 0);
    IF V_TOTAL_DED_COUNT < 0 THEN
      V_TOTAL_DED_COUNT := 0;
    END IF;
    V_PAY_DAY := NVL(V_TOTAL_DAY, 0) - (NVL(V_TOTAL_DED_COUNT, 0) + NVL(V_HOLY_0_COUNT, 0));
    IF V_PAY_DAY < 0 THEN
      V_PAY_DAY := 0;
    END IF;

    -- RETURN.
    O_TOTAL_DED_COUNT := V_TOTAL_DED_COUNT;
    O_PAY_DAY := V_PAY_DAY;

  END TOT_DED_COUNT_P;

-- �����ϼ�.
  FUNCTION NON_PAY_DAY_F
            ( P_PERSON_ID           IN  NUMBER
            , P_SOB_ID              IN  NUMBER
            , P_ORG_ID              IN  NUMBER
            , P_PERIOD_DATE_FR      IN  DATE
            , P_PERIOD_DATE_TO      IN  DATE            
            , P_CONNECT_PERSON_ID   IN  NUMBER
            ) RETURN NUMBER
  AS
    V_NON_PAY_DAY             NUMBER := 0;
  BEGIN
    BEGIN
      SELECT NVL(MTS.DUTY_COUNT, 0) AS DAY_COUNT
        INTO V_NON_PAY_DAY
        FROM HRD_PERIOD_TOTAL_GT MT
          , HRD_PERIOD_TOTAL_DUTY_GT MTS
          , HRM_DUTY_CODE_V DC
      WHERE MT.PERSON_ID           = MTS.PERSON_ID
        AND MT.SOB_ID              = MTS.SOB_ID
        AND MT.ORG_ID              = MTS.ORG_ID
        AND MTS.DUTY_ID            = DC.DUTY_ID
        AND MT.PERSON_ID           = P_PERSON_ID
        AND MT.SOB_ID              = P_SOB_ID
        AND MT.ORG_ID              = P_ORG_ID
        AND (DC.NON_PAY_DAY_FLAG    = 'Y'
          OR DC.DUTY_CODE          = '11')
        AND DC.EFFECTIVE_DATE_FR   <= P_PERIOD_DATE_TO
        AND (DC.EFFECTIVE_DATE_TO IS NULL OR DC.EFFECTIVE_DATE_TO >= P_PERIOD_DATE_FR)
      ;
    EXCEPTION WHEN OTHERS THEN
      V_NON_PAY_DAY := 0;
    END;
    RETURN V_NON_PAY_DAY;
  END NON_PAY_DAY_F;

---------------------------------------------------------------------------------------------------
-- ����ٹ��ð� �հ� ����.
  PROCEDURE SAVE_OT_TIME
            ( P_PERSON_ID               IN  NUMBER
            , P_OT_TYPE                 IN  VARCHAR2
            , P_OT_TIME                 IN  NUMBER
            , P_SOB_ID                  IN  NUMBER
            , P_ORG_ID                  IN  NUMBER
            , P_USER_ID                 IN  NUMBER
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    IF NVL(P_OT_TIME, 0) <> 0 THEN
      -- ����ٹ��ð� INSERT.
      INSERT INTO HRD_PERIOD_TOTAL_OT_GT
      ( PERSON_ID
      , SOB_ID
      , ORG_ID
      , OT_TYPE
      , OT_TIME
      ) VALUES
      ( P_PERSON_ID
      , P_SOB_ID
      , P_ORG_ID
      , P_OT_TYPE
      , NVL(P_OT_TIME, 0)
      );
    END IF;
  END SAVE_OT_TIME;

END HRD_PERIOD_TOTAL_G;
/
