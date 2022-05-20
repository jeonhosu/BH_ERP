CREATE OR REPLACE PACKAGE FI_TR_DAILY_SUM_G
AS

  PROCEDURE TR_DAILY_SUM_1_SELECT
            ( P_CURSOR          OUT TYPES.TCURSOR
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            );

  PROCEDURE TR_DAILY_SUM_2_SELECT
            ( P_CURSOR          OUT TYPES.TCURSOR
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            );
                        
-- 현금/제예금 현황.
  PROCEDURE TR_DAILY_110_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            );
            
-- 정기 예적금 현황.
  PROCEDURE TR_DAILY_120_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            );

-- 받을어음 현황.
  PROCEDURE TR_DAILY_130_1_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            );

-- 지급어음 현황.
  PROCEDURE TR_DAILY_140_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            );

-- 차입금 내역 : 일반대출 현황.
  PROCEDURE TR_DAILY_210_1_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            );

-- 차입금 내역 : 한도대출 현황.
  PROCEDURE TR_DAILY_210_2_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            );

-- 차입금 내역 : 회전대 현황.
  PROCEDURE TR_DAILY_210_3_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            );

-- 차입금 내역 : 사채 현황.
  PROCEDURE TR_DAILY_210_4_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            );
            
-- 일일자금입/출금 내역.
  PROCEDURE TR_DAILY_SLIP_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            );

-- 자금이체 현황.
  PROCEDURE TR_DAILY_FUND_MOVE_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            );

  PROCEDURE TR_DAILY_PLAN_SUM_SELECT
            ( P_CURSOR          OUT TYPES.TCURSOR
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            );
            
-- 자금 계획 조회.
  PROCEDURE TR_DAILY_PLAN_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            );
-- 자금 계획 삽입.
  PROCEDURE TR_DAILY_PLAN_INSERT
          ( P_SOB_ID             IN FI_TR_DAILY_SUM.SOB_ID%TYPE
          , P_GL_DATE            IN FI_TR_DAILY_SUM.GL_DATE%TYPE
          , P_ACCOUNT_CONTROL_ID IN FI_TR_DAILY_SUM.ACCOUNT_CONTROL_ID%TYPE
          , P_ACCOUNT_CODE       IN FI_TR_DAILY_SUM.ACCOUNT_CODE%TYPE
          , P_ACCOUNT_DR_CR      IN VARCHAR2
          , P_CURRENCY_CODE      IN FI_TR_DAILY_SUM.CURRENCY_CODE%TYPE
          , P_GL_CURR_AMOUNT     IN FI_TR_DAILY_SUM.DR_CURR_AMOUNT%TYPE
          , P_GL_AMOUNT          IN FI_TR_DAILY_SUM.DR_AMOUNT%TYPE
          , P_DESCRIPTION        IN FI_TR_DAILY_SUM.DESCRIPTION%TYPE
          , P_BANK_CODE          IN FI_TR_DAILY_SUM.BANK_CODE%TYPE
          , P_LOAN_USE           IN FI_TR_DAILY_SUM.LOAN_USE%TYPE
          , P_LOAN_NUM           IN FI_TR_DAILY_SUM.LOAN_NUM%TYPE
          , P_TR_CATEGORY        IN FI_TR_DAILY_SUM.TR_CATEGORY%TYPE
          , P_TR_CLASS           IN FI_TR_DAILY_SUM.TR_CLASS%TYPE
          );

-- 회계계정관리 LOOKUP 조회 - 자금일보 관리 계정만.
  PROCEDURE LU_ACCOUNT_CONTROL
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_ACCOUNT_CONTROL.SOB_ID%TYPE
            , W_ENABLED_YN           IN FI_ACCOUNT_CONTROL.ENABLED_FLAG%TYPE
            );
            
-- 일일 자금현황 생성.
  PROCEDURE TR_DAILY_CREATE
            ( W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            , O_MESSAGE         OUT VARCHAR2
            );
            
END FI_TR_DAILY_SUM_G;


 
/
CREATE OR REPLACE PACKAGE BODY FI_TR_DAILY_SUM_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_TR_DAILY_SUM_G
/* Description  : 일일자금일보 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 자금현황.
  PROCEDURE TR_DAILY_SUM_1_SELECT
            ( P_CURSOR          OUT TYPES.TCURSOR
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT FTC.TR_CATEGORY_NAME
           , TC.TR_CLASS_NAME
           , DECODE(GROUPING(SX1.TR_MANAGE_NAME), 1, '총가용자금', SX1.TR_MANAGE_NAME) AS TR_MANAGE_NAME
           , SX1.BANK_NAME
           , SX1.CURRENCY_CODE
           , SUM(SX1.BEGIN_AMOUNT) AS BEGIN_AMOUNT
           , SUM(SX1.DR_AMOUNT) AS DR_AMOUNT
           , SUM(SX1.CR_AMOUNT) AS CR_AMOUNT
           , SUM(SX1.REMAIN_AMOUNT) AS REMAIN_AMOUNT
           , SX1.DESCRIPTION
        FROM FI_TR_CLASS_V TC
           , FI_TR_CATEGORY_V FTC
           , ( SELECT DS.TR_CLASS
                   , MA.TR_MANAGE_NAME
                   , DS.SOB_ID
                   , FB.BANK_NAME
                   , DS.CURRENCY_CODE
                   , DS.BEGIN_AMOUNT
                   , DS.DR_AMOUNT
                   , DS.CR_AMOUNT
                   , DS.REMAIN_AMOUNT
                   , NULL AS DESCRIPTION
                FROM FI_TR_DAILY_SUM DS
                  , FI_TR_MANAGE_ACCOUNTE_V MA 
                  , FI_BANK FB
              WHERE DS.ACCOUNT_CODE             = MA.ACCOUNT_CODE
                AND DS.SOB_ID                   = MA.SOB_ID
                AND DS.BANK_CODE                = FB.BANK_CODE(+)
                AND DS.SOB_ID                   = FB.SOB_ID(+)
                AND DS.TR_TYPE                  = 'SLIP'
                AND DS.SOB_ID                   = W_SOB_ID
                AND DS.GL_DATE                  = W_GL_DATE
                AND DS.TR_CATEGORY             = '10'
              UNION ALL
              SELECT '130' AS TR_CLASS
                   , FI_COMMON_G.CODE_NAME_F('TR_MANAGE_ACCOUNT', '1602', DS.SOB_ID) AS TR_MANAGE_NAME
                   , DS.SOB_ID
                   , DECODE(GROUPING(FB.BANK_CODE), 1, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL), FB.BANK_NAME) AS BANK_NAME           
                   , DS.CURRENCY_CODE
                   , SUM(NVL(LM.LOAN_AMOUNT, 0) - NVL(DS.BEGIN_AMOUNT, 0)) AS BEGIN_AMOUNT
                   , SUM(DS.DR_AMOUNT) AS DR_AMOUNT  -- 금일상환.
                   , SUM(DS.CR_AMOUNT) AS CR_AMOUNT  -- 금일차입.
                   , SUM(NVL(LM.LOAN_AMOUNT, 0) - NVL(DS.BEGIN_AMOUNT, 0) - NVL(DS.DR_AMOUNT, 0) + NVL(DS.CR_AMOUNT, 0)) AS REMAIN_AMOUNT
                   , NULL AS DESCRIPTION
                FROM FI_TR_DAILY_SUM DS
                  , FI_TR_MANAGE_ACCOUNTE_V MA
                  , FI_LOAN_USE_V LU
                  , FI_BANK FB
                  , FI_LOAN_MASTER LM
              WHERE DS.ACCOUNT_CODE           = MA.ACCOUNT_CODE
                AND DS.SOB_ID                   = MA.SOB_ID
                AND DS.LOAN_USE                 = LU.LOAN_USE_CODE
                AND DS.SOB_ID                   = LU.SOB_ID
                AND DS.BANK_CODE                = FB.BANK_CODE(+)
                AND DS.SOB_ID                   = FB.SOB_ID(+)
                AND DS.LOAN_NUM                 = LM.LOAN_NUM(+)
                AND DS.SOB_ID                   = LM.SOB_ID(+)
                AND DS.TR_TYPE                  = 'SLIP'
                AND DS.SOB_ID                   = W_SOB_ID
                AND DS.GL_DATE                  = W_GL_DATE
                AND MA.TR_CLASS                 = '210'
                AND LU.TR_LOAN_TYPE             = '2'
             GROUP BY FI_COMMON_G.CODE_NAME_F('TR_MANAGE_ACCOUNT', '1602', DS.SOB_ID)
                   , DS.SOB_ID
                   , FB.BANK_CODE
                   , FB.BANK_NAME
                   , DS.CURRENCY_CODE       
             ) SX1
      WHERE TC.TR_CATEGORY              = FTC.TR_CATEGORY
        AND TC.SOB_ID                   = FTC.SOB_ID
        AND TC.TR_CLASS                 = SX1.TR_CLASS
        AND TC.SOB_ID                   = SX1.SOB_ID
      GROUP BY ROLLUP (( FTC.TR_CATEGORY_NAME
           , TC.TR_CLASS     
           , TC.TR_CLASS_NAME
           , SX1.TR_MANAGE_NAME
           , SX1.BANK_NAME
           , SX1.CURRENCY_CODE
           , SX1.DESCRIPTION))      
      ;

  END TR_DAILY_SUM_1_SELECT;

-- 금융채무.
  PROCEDURE TR_DAILY_SUM_2_SELECT
            ( P_CURSOR          OUT TYPES.TCURSOR
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT FTC.TR_CATEGORY_NAME
           , TC.TR_CLASS_NAME
           , DECODE(GROUPING(SX1.TR_MANAGE_NAME), 1, '총금융부채', SX1.TR_MANAGE_NAME) AS TR_MANAGE_NAME
           , SX1.LOAN_USE_NAME AS BANK_NAME
           , SX1.CURRENCY_CODE
           , SUM(SX1.BEGIN_AMOUNT) AS BEGIN_AMOUNT
           , SUM(SX1.DR_AMOUNT) AS DR_AMOUNT
           , SUM(SX1.CR_AMOUNT) AS CR_AMOUNT
           , SUM(SX1.REMAIN_AMOUNT) AS REMAIN_AMOUNT
           , SX1.DESCRIPTION
          FROM FI_TR_CLASS_V TC
           , FI_TR_CATEGORY_V FTC
           , (SELECT  DS.TR_CLASS AS TR_CLASS
                   , DS.SOB_ID
                   , MA.TR_MANAGE_NAME
                   ,  LU.LOAN_USE_NAME AS LOAN_USE_NAME
                   , DS.CURRENCY_CODE
                   , NVL(LM.LOAN_AMOUNT, 0) - NVL(DS.BEGIN_AMOUNT, 0) AS BEGIN_AMOUNT
                   , DS.DR_AMOUNT AS DR_AMOUNT  -- 금일상환.
                   , DS.CR_AMOUNT AS CR_AMOUNT  -- 금일차입.
                   , NVL(LM.LOAN_AMOUNT, 0) - NVL(DS.BEGIN_AMOUNT, 0) - NVL(DS.DR_AMOUNT, 0) + NVL(DS.CR_AMOUNT, 0) AS REMAIN_AMOUNT
                   , NULL AS DESCRIPTION
                FROM FI_TR_DAILY_SUM DS
                  , FI_TR_MANAGE_ACCOUNTE_V MA
                  , FI_LOAN_USE_V LU
                  , FI_BANK FB
                  , FI_LOAN_MASTER LM
              WHERE DS.ACCOUNT_CODE           = MA.ACCOUNT_CODE
                AND DS.SOB_ID                   = MA.SOB_ID
                AND DS.LOAN_USE                 = LU.LOAN_USE_CODE
                AND DS.SOB_ID                   = LU.SOB_ID
                AND DS.BANK_CODE                = FB.BANK_CODE(+)
                AND DS.SOB_ID                   = FB.SOB_ID(+)
                AND DS.LOAN_NUM                 = LM.LOAN_NUM(+)
                AND DS.SOB_ID                   = LM.SOB_ID(+)
                AND DS.TR_TYPE                  = 'SLIP'
                AND DS.SOB_ID                   = W_SOB_ID
                AND DS.GL_DATE                  = W_GL_DATE
                AND MA.TR_CLASS                 = '210'
             ) SX1
      WHERE TC.TR_CATEGORY              = FTC.TR_CATEGORY
        AND TC.SOB_ID                   = FTC.SOB_ID
        AND TC.TR_CLASS                 = SX1.TR_CLASS
        AND TC.SOB_ID                   = SX1.SOB_ID
      GROUP BY ROLLUP (( FTC.TR_CATEGORY_NAME
           , TC.TR_CLASS     
           , TC.TR_CLASS_NAME
           , SX1.TR_MANAGE_NAME
           , SX1.LOAN_USE_NAME
           , SX1.CURRENCY_CODE
           , SX1.DESCRIPTION))
      ;

  END TR_DAILY_SUM_2_SELECT;
  
  PROCEDURE TR_DAILY_110_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT CASE
               WHEN GROUPING(MA.TR_MANAGE_CODE) = 1 THEN NULL
               WHEN GROUPING(MA.TR_MANAGE_NAME) = 1 THEN NULL
               ELSE MA.TR_MANAGE_NAME
             END AS TR_MANAGE_NAME       
           , CASE
               WHEN GROUPING(MA.TR_MANAGE_CODE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL)
               WHEN GROUPING(MA.TR_MANAGE_NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL)
               ELSE FB.BANK_NAME
             END AS BANK_NAME
           , BA.BANK_ACCOUNT_NUM || '(' || FI_COMMON_G.CODE_NAME_F('ACCOUNT_TYPE', BA.ACCOUNT_TYPE, BA.SOB_ID) || ')' AS BANK_ACCOUNT_NUM
           , DS.CURRENCY_CODE
           , SUM(DS.BEGIN_AMOUNT) AS BEGIN_AMOUNT
           , SUM(DS.DR_AMOUNT) AS DR_AMOUNT
           , SUM(DS.CR_AMOUNT) AS CR_AMOUNT
           , SUM(DS.REMAIN_AMOUNT) AS REMAIN_AMOUNT
           , SUM(DS.BEGIN_CURR_AMOUNT) AS BEGIN_CURR_AMOUNT
           , SUM(DS.DR_CURR_AMOUNT) AS DR_CURR_AMOUNT
           , SUM(DS.CR_CURR_AMOUNT) AS CR_CURR_AMOUNT
           , SUM(DS.REMAIN_CURR_AMOUNT) AS REMAIN_CURR_AMOUNT
        FROM FI_TR_DAILY_SUM DS
          , FI_TR_MANAGE_ACCOUNTE_V MA
          , FI_BANK_ACCOUNT BA
          , FI_BANK FB
        WHERE DS.ACCOUNT_CODE             = MA.ACCOUNT_CODE
        AND DS.SOB_ID                   = MA.SOB_ID
        AND DS.BANK_ACCOUNT_CODE        = BA.BANK_ACCOUNT_CODE(+)
        AND DS.SOB_ID                   = BA.SOB_ID(+)
        AND BA.BANK_ID                  = FB.BANK_ID(+)
        AND DS.TR_TYPE                  = 'SLIP'
        AND DS.SOB_ID                   = W_SOB_ID
        AND DS.GL_DATE                  = W_GL_DATE
        AND DS.TR_CLASS                 = 110   --운영자금.
        GROUP BY ROLLUP((MA.TR_MANAGE_CODE)
           , (MA.TR_MANAGE_NAME
           , FB.BANK_NAME
           , BA.BANK_ACCOUNT_NUM || '(' || FI_COMMON_G.CODE_NAME_F('ACCOUNT_TYPE', BA.ACCOUNT_TYPE, BA.SOB_ID) || ')'
           , DS.CURRENCY_CODE))
        ORDER BY MA.TR_MANAGE_CODE     
      ;
      
  END TR_DAILY_110_SELECT;  

  PROCEDURE TR_DAILY_120_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT CASE
               WHEN GROUPING(MA.TR_MANAGE_NAME) = 1 THEN NULL
               WHEN GROUPING(FB.BANK_NAME) = 1 THEN NULL
               ELSE MA.TR_MANAGE_NAME
             END AS TR_MANAGE_NAME       
           , CASE
               WHEN GROUPING(MA.TR_MANAGE_NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL)
               WHEN GROUPING(FB.BANK_NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL)
               ELSE FB.BANK_NAME
             END AS BANK_NAME
           , BA.BANK_ACCOUNT_NUM || '(' || FI_COMMON_G.CODE_NAME_F('ACCOUNT_TYPE', BA.ACCOUNT_TYPE, BA.SOB_ID) || ')' AS BANK_ACCOUNT_NUM
           , NVL(DM.DEPOSIT_AMOUNT, 0) AS DEPOSIT_AMOUNT
           , NVL(DM.INTER_RATE, 0) AS INTER_RATE
           , SUM(DS.BEGIN_AMOUNT) AS BEGIN_AMOUNT
           , SUM(DS.DR_AMOUNT) AS DR_AMOUNT
           , SUM(DS.CR_AMOUNT) AS CR_AMOUNT
           , SUM(DS.REMAIN_AMOUNT) AS REMAIN_AMOUNT
           , SUM(DS.BEGIN_CURR_AMOUNT) AS BEGIN_CURR_AMOUNT
           , SUM(DS.DR_CURR_AMOUNT) AS DR_CURR_AMOUNT
           , SUM(DS.CR_CURR_AMOUNT) AS CR_CURR_AMOUNT
           , SUM(DS.REMAIN_CURR_AMOUNT) AS REMAIN_CURR_AMOUNT
           , TO_CHAR(DM.DUE_DATE, 'YYYY-MM-DD') AS DUE_DATE
           , NVL(DM.PAYMENT_AMOUNT, 0) AS PAYMENT_AMOUNT
        FROM FI_TR_DAILY_SUM DS
          , FI_TR_MANAGE_ACCOUNTE_V MA
          , FI_BANK_ACCOUNT BA
          , FI_BANK FB
          , FI_DEPOSIT_MASTER DM
        WHERE DS.ACCOUNT_CODE           = MA.ACCOUNT_CODE
        AND DS.SOB_ID                   = MA.SOB_ID
        AND DS.BANK_ACCOUNT_CODE        = BA.BANK_ACCOUNT_CODE(+)
        AND DS.SOB_ID                   = BA.SOB_ID(+)
        AND BA.BANK_ID                  = FB.BANK_ID(+)
        AND BA.BANK_ACCOUNT_ID          = DM.BANK_ACCOUNT_ID(+)
        AND DS.TR_TYPE                  = 'SLIP'
        AND DS.SOB_ID                   = W_SOB_ID
        AND DS.GL_DATE                  = W_GL_DATE
        AND DS.TR_CLASS                 = 120   --운영자금.
        GROUP BY ROLLUP((MA.TR_MANAGE_NAME)
           , (FB.BANK_NAME
           , BA.BANK_ACCOUNT_NUM || '(' || FI_COMMON_G.CODE_NAME_F('ACCOUNT_TYPE', BA.ACCOUNT_TYPE, BA.SOB_ID) || ')'
           , DM.DEPOSIT_AMOUNT
           , DM.INTER_RATE
           , DM.DUE_DATE
           , DM.PAYMENT_AMOUNT))
        ORDER BY MA.TR_MANAGE_NAME, FB.BANK_NAME
        ;
  
  END TR_DAILY_120_SELECT;

-- 받을어음 현황.
  PROCEDURE TR_DAILY_130_1_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT FB.BANK_CODE
           , DECODE(GROUPING(FB.BANK_CODE), 1, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL), FB.BANK_NAME) AS BANK_NAME
           , SUM(DS.BEGIN_AMOUNT) AS BEGIN_AMOUNT
           , SUM(DS.DR_AMOUNT) AS DR_AMOUNT
           , SUM(DS.CR_AMOUNT) AS CR_AMOUNT
           , SUM(DS.REMAIN_AMOUNT) AS REMAIN_AMOUNT
           , SUM(NVL(SX1.DUE_0, 0)) AS DUE_0
           , SUM(NVL(SX1.DUE_1, 0)) AS DUE_1
           , SUM(NVL(SX1.DUE_2, 0)) AS DUE_2
           , SUM(NVL(SX1.DUE_3, 0)) AS DUE_3
        FROM FI_TR_DAILY_SUM DS
          , FI_TR_MANAGE_ACCOUNTE_V MA
          , FI_BANK FB
          , (SELECT FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'BANK', SL.SOB_ID) AS BANK_CODE
                 , SL.SOB_ID
                 , SUM(CASE TRUNC(MONTHS_BETWEEN(TO_DATE(FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'DUE_DATE', SL.SOB_ID), 'YYYY-MM-DD'), SL.GL_DATE))
                         WHEN 0 THEN SL.GL_AMOUNT
                         ELSE 0
                       END) AS DUE_0
                 , SUM(CASE TRUNC(MONTHS_BETWEEN(TO_DATE(FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'DUE_DATE', SL.SOB_ID), 'YYYY-MM-DD'), SL.GL_DATE))
                         WHEN 1 THEN SL.GL_AMOUNT
                         ELSE 0
                       END) AS DUE_1  
                 , SUM(CASE TRUNC(MONTHS_BETWEEN(TO_DATE(FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'DUE_DATE', SL.SOB_ID), 'YYYY-MM-DD'), SL.GL_DATE))
                         WHEN 2 THEN SL.GL_AMOUNT
                         ELSE 0
                       END) AS DUE_2
                 , SUM(CASE 
                         WHEN 2 < TRUNC(MONTHS_BETWEEN(TO_DATE(FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'DUE_DATE', SL.SOB_ID), 'YYYY-MM-DD'), SL.GL_DATE)) THEN SL.GL_AMOUNT
                         ELSE 0
                       END) AS DUE_3
              FROM FI_SLIP_LINE SL
                , FI_TR_MANAGE_ACCOUNTE_V MA
            WHERE SL.ACCOUNT_CODE           = MA.ACCOUNT_CODE
              AND SL.SOB_ID                 = MA.SOB_ID
              AND SL.SOB_ID                 = W_SOB_ID
              AND SL.GL_DATE                = W_GL_DATE
              AND MA.TR_MANAGE_CODE         = 1601
            GROUP BY FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'BANK', SL.SOB_ID)
              , SL.SOB_ID
            ) SX1
      WHERE DS.ACCOUNT_CODE           = MA.ACCOUNT_CODE
        AND DS.SOB_ID                 = MA.SOB_ID
        AND DS.BANK_CODE              = FB.BANK_CODE(+)
        AND DS.SOB_ID                 = FB.SOB_ID(+)
        AND DS.BANK_CODE              = SX1.BANK_CODE(+)
        AND DS.SOB_ID                 = SX1.SOB_ID(+)
        AND DS.TR_TYPE                = 'SLIP'
        AND DS.SOB_ID                 = W_SOB_ID
        AND DS.GL_DATE                = W_GL_DATE
        AND MA.TR_MANAGE_CODE           = 1601
      GROUP BY ROLLUP((FB.BANK_CODE
                   , FB.BANK_NAME))
      ;
  
  END TR_DAILY_130_1_SELECT;
              
-- 지급어음 현황.
  PROCEDURE TR_DAILY_140_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT FB.BANK_CODE
           , DECODE(GROUPING(FB.BANK_CODE), 1, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL), FB.BANK_NAME) AS BANK_NAME
           , TO_CHAR(LM.L_DUE_DATE, 'YYYY-MM-DD') AS DUE_DATE
           , SUM(LM.LIMIT_AMOUNT) AS LIMIT_AMOUNT
           , SUM(NVL(LM.LIMIT_AMOUNT, 0) - NVL(LM.LOAN_AMOUNT, 0)) AS LIMIT_REMAIN_AMOUNT
           , SUM(DS.BEGIN_AMOUNT) AS BEGIN_AMOUNT
           , SUM(DS.CR_AMOUNT) AS DR_AMOUNT
           , SUM(DS.DR_AMOUNT) AS CR_AMOUNT
           , SUM(DS.REMAIN_AMOUNT) AS REMAIN_AMOUNT
           , NULL AS DESCRIPTION
        FROM FI_TR_DAILY_SUM DS
          , FI_TR_MANAGE_ACCOUNTE_V MA
          , FI_BANK FB   
          , FI_LOAN_MASTER LM
      WHERE DS.ACCOUNT_CODE           = MA.ACCOUNT_CODE
        AND DS.SOB_ID                   = MA.SOB_ID
        AND DS.BANK_CODE                = FB.BANK_CODE(+)
        AND DS.SOB_ID                   = FB.SOB_ID(+)
        AND DS.LOAN_NUM                 = LM.LOAN_NUM(+)
        AND DS.SOB_ID                   = LM.SOB_ID(+)
        AND DS.TR_TYPE                  = 'SLIP'
        AND DS.SOB_ID                   = W_SOB_ID
        AND DS.GL_DATE                  = W_GL_DATE
        AND MA.TR_MANAGE_CODE           = 1701
      GROUP BY ROLLUP((FB.BANK_CODE
           , FB.BANK_NAME
           , TO_CHAR(LM.L_DUE_DATE, 'YYYY-MM-DD')))  
      ;
      
  END TR_DAILY_140_SELECT;
  
-- 차입금 내역 : 일반대출 현황.
  PROCEDURE TR_DAILY_210_1_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT FB.BANK_CODE
           , DECODE(GROUPING(FB.BANK_CODE), 1, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL), FB.BANK_NAME) AS BANK_NAME
           , BA.BANK_ACCOUNT_NUM
           , LU.LOAN_USE_NAME
           , SUM(NVL(LM.LOAN_AMOUNT, 0)) AS LOAN_AMOUNT
           , SUM(NVL(LM.LOAN_AMOUNT, 0) - NVL(DS.BEGIN_AMOUNT, 0)) AS BEGIN_AMOUNT
           , /*SUM(DS.CR_AMOUNT)*/ 0 AS DR_AMOUNT  -- 금일차입.
           , SUM(DS.DR_AMOUNT) AS CR_AMOUNT  -- 금일상환.
           , SUM(NVL(LM.LOAN_AMOUNT, 0) - NVL(DS.BEGIN_AMOUNT, 0) - NVL(DS.DR_AMOUNT, 0) /*+ NVL(DS.CR_AMOUNT, 0)*/) AS REMAIN_AMOUNT           
           , SUM(NVL(LM.LOAN_CURR_AMOUNT, 0)) AS LOAN_CURR_AMOUNT
           , SUM(NVL(LM.LOAN_CURR_AMOUNT, 0) - NVL(DS.BEGIN_CURR_AMOUNT, 0)) AS BEGIN_CURR_AMOUNT
           , /*SUM(DS.CR_CURR_AMOUNT)*/0 AS DR_CURR_AMOUNT  -- 금일차입.
           , SUM(DS.DR_CURR_AMOUNT) AS CR_CURR_AMOUNT  -- 금일상환.
           , SUM(NVL(LM.LOAN_CURR_AMOUNT, 0) - NVL(DS.BEGIN_CURR_AMOUNT, 0) - NVL(DS.DR_CURR_AMOUNT, 0)/* + NVL(DS.CR_CURR_AMOUNT, 0)*/) AS REMAIN_CURR_AMOUNT
           , TO_CHAR(LM.ISSUE_DATE, 'YYYY-MM-DD') AS ISSUE_DATE
           , TO_CHAR(LM.DUE_DATE, 'YYYY-MM-DD') AS DUE_DATE
           , TO_CHAR(LM.INTER_RATE) AS INTER_RATE
        FROM FI_TR_DAILY_SUM DS
          , FI_TR_MANAGE_ACCOUNTE_V MA
          , FI_LOAN_USE_V LU
          , FI_BANK_ACCOUNT BA
          , FI_BANK FB
          , FI_LOAN_MASTER LM
      WHERE DS.ACCOUNT_CODE           = MA.ACCOUNT_CODE
        AND DS.SOB_ID                   = MA.SOB_ID
        AND DS.LOAN_USE                 = LU.LOAN_USE_CODE
        AND DS.SOB_ID                   = LU.SOB_ID
        AND DS.BANK_ACCOUNT_CODE        = BA.BANK_ACCOUNT_CODE(+)
        AND DS.SOB_ID                   = BA.SOB_ID(+)
        AND DS.BANK_CODE                = FB.BANK_CODE(+)
        AND DS.SOB_ID                   = FB.SOB_ID(+)
        AND DS.LOAN_NUM                 = LM.LOAN_NUM(+)
        AND DS.SOB_ID                   = LM.SOB_ID(+)
        AND DS.TR_TYPE                  = 'SLIP'
        AND DS.SOB_ID                   = W_SOB_ID
        AND DS.GL_DATE                  = W_GL_DATE
        AND MA.TR_CLASS                 = '210'
        AND LU.TR_LOAN_TYPE             = '1'
      GROUP BY ROLLUP((FB.BANK_CODE
           , FB.BANK_NAME
           , LU.LOAN_USE_NAME
           , BA.BANK_ACCOUNT_NUM
           , LM.ISSUE_DATE
           , LM.DUE_DATE
           , LM.INTER_RATE))
      ;
      
  END TR_DAILY_210_1_SELECT;

-- 차입금 내역 : 한도대출 현황.
  PROCEDURE TR_DAILY_210_2_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT FB.BANK_CODE
           , DECODE(GROUPING(FB.BANK_CODE), 1, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL), FB.BANK_NAME) AS BANK_NAME
           , LU.LOAN_USE_NAME
           , SUM(NVL(LM.LIMIT_AMOUNT, 0)) AS LIMIT_AMOUNT
           , SUM(NVL(LM.LIMIT_AMOUNT, 0) - NVL(LM.LOAN_AMOUNT, 0)) AS LIMIT_REMAIN_AMOUNT
           , SUM(NVL(LM.LOAN_AMOUNT, 0) - NVL(DS.BEGIN_AMOUNT, 0)) AS BEGIN_AMOUNT
           , SUM(DS.CR_AMOUNT) AS DR_AMOUNT  -- 금일차입.
           , SUM(DS.DR_AMOUNT) AS CR_AMOUNT  -- 금일상환.
           , SUM(NVL(LM.LOAN_AMOUNT, 0) - NVL(DS.BEGIN_AMOUNT, 0) + NVL(DS.DR_AMOUNT, 0) - NVL(DS.CR_AMOUNT, 0)) AS REMAIN_AMOUNT                      
           , SUM(NVL(LM.LIMIT_CURR_AMOUNT, 0)) AS LIMIT_CURR_AMOUNT
           , SUM(NVL(LM.LIMIT_CURR_AMOUNT, 0) - NVL(LM.LOAN_CURR_AMOUNT, 0)) AS LIMIT_REMAIN_CURR_AMOUNT
           , SUM(NVL(LM.LOAN_CURR_AMOUNT, 0) - NVL(DS.BEGIN_CURR_AMOUNT, 0)) AS BEGIN_CURR_AMOUNT
           , SUM(DS.CR_CURR_AMOUNT) AS DR_CURR_AMOUNT  -- 금일차입.
           , SUM(DS.DR_CURR_AMOUNT) AS CR_CURR_AMOUNT  -- 금일상환.
           , SUM(NVL(LM.LOAN_CURR_AMOUNT, 0) - NVL(DS.BEGIN_CURR_AMOUNT, 0) + NVL(DS.DR_CURR_AMOUNT, 0) - NVL(DS.CR_CURR_AMOUNT, 0)) AS REMAIN_CURR_AMOUNT                      
           , TO_CHAR(LM.ISSUE_DATE, 'YYYY-MM-DD') AS ISSUE_DATE
           , TO_CHAR(LM.DUE_DATE, 'YYYY-MM-DD') AS DUE_DATE
           , TO_CHAR(LM.INTER_RATE) AS INTER_RATE
        FROM FI_TR_DAILY_SUM DS
          , FI_TR_MANAGE_ACCOUNTE_V MA
          , FI_LOAN_USE_V LU
          , FI_BANK FB
          , FI_LOAN_MASTER LM
      WHERE DS.ACCOUNT_CODE           = MA.ACCOUNT_CODE
        AND DS.SOB_ID                   = MA.SOB_ID
        AND DS.LOAN_USE                 = LU.LOAN_USE_CODE
        AND DS.SOB_ID                   = LU.SOB_ID
        AND DS.BANK_CODE                = FB.BANK_CODE(+)
        AND DS.SOB_ID                   = FB.SOB_ID(+)
        AND DS.LOAN_NUM                 = LM.LOAN_NUM(+)
        AND DS.SOB_ID                   = LM.SOB_ID(+)
        AND DS.TR_TYPE                  = 'SLIP'
        AND DS.SOB_ID                   = W_SOB_ID
        AND DS.GL_DATE                  = W_GL_DATE
        AND MA.TR_CLASS                 = '210'
        AND LU.TR_LOAN_TYPE             = '2'
      GROUP BY ROLLUP((FB.BANK_CODE
           , FB.BANK_NAME
           , LU.LOAN_USE_NAME
           , LM.ISSUE_DATE
           , LM.DUE_DATE
           , LM.INTER_RATE))
      ;
      
  END TR_DAILY_210_2_SELECT;


-- 차입금 내역 : 회전대 현황.
  PROCEDURE TR_DAILY_210_3_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT FB.BANK_CODE
           , DECODE(GROUPING(FB.BANK_CODE), 1, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL), FB.BANK_NAME) AS BANK_NAME
           , LU.LOAN_USE_NAME
           , SUM(NVL(LM.LIMIT_AMOUNT, 0)) AS LIMIT_AMOUNT
           , SUM(NVL(LM.LIMIT_AMOUNT, 0) - NVL(LM.LOAN_AMOUNT, 0)) AS LIMIT_REMAIN_AMOUNT
           , SUM(NVL(LM.LOAN_AMOUNT, 0) - NVL(DS.BEGIN_AMOUNT, 0)) AS BEGIN_AMOUNT
           , SUM(DS.CR_AMOUNT) AS DR_AMOUNT  -- 금일차입.
           , SUM(DS.DR_AMOUNT) AS CR_AMOUNT  -- 금일상환.
           , SUM(NVL(LM.LOAN_AMOUNT, 0) - NVL(DS.BEGIN_AMOUNT, 0) - NVL(DS.DR_AMOUNT, 0) + NVL(DS.CR_AMOUNT, 0)) AS REMAIN_AMOUNT
           , SUM(NVL(LM.LIMIT_CURR_AMOUNT, 0)) AS LIMIT_CURR_AMOUNT
           , SUM(NVL(LM.LIMIT_CURR_AMOUNT, 0) - NVL(LM.LOAN_CURR_AMOUNT, 0)) AS LIMIT_REMAIN_CURR_AMOUNT
           , SUM(NVL(LM.LOAN_CURR_AMOUNT, 0) - NVL(DS.BEGIN_CURR_AMOUNT, 0)) AS BEGIN_CURR_AMOUNT
           , SUM(DS.CR_CURR_AMOUNT) AS DR_CURR_AMOUNT  -- 금일차입.
           , SUM(DS.DR_CURR_AMOUNT) AS CR_CURR_AMOUNT  -- 금일상환.
           , SUM(NVL(LM.LOAN_CURR_AMOUNT, 0) - NVL(DS.BEGIN_CURR_AMOUNT, 0) - NVL(DS.DR_CURR_AMOUNT, 0) + NVL(DS.CR_CURR_AMOUNT, 0)) AS REMAIN_CURR_AMOUNT
           , TO_CHAR(LM.ISSUE_DATE, 'YYYY-MM-DD') AS ISSUE_DATE
           , TO_CHAR(LM.DUE_DATE, 'YYYY-MM-DD') AS DUE_DATE
           , TO_CHAR(LM.INTER_RATE) AS INTER_RATE
        FROM FI_TR_DAILY_SUM DS
          , FI_TR_MANAGE_ACCOUNTE_V MA
          , FI_LOAN_USE_V LU
          , FI_BANK FB
          , FI_LOAN_MASTER LM
      WHERE DS.ACCOUNT_CODE           = MA.ACCOUNT_CODE
        AND DS.SOB_ID                   = MA.SOB_ID
        AND DS.LOAN_USE                 = LU.LOAN_USE_CODE
        AND DS.SOB_ID                   = LU.SOB_ID
        AND DS.BANK_CODE                = FB.BANK_CODE(+)
        AND DS.SOB_ID                   = FB.SOB_ID(+)
        AND DS.LOAN_NUM                 = LM.LOAN_NUM(+)
        AND DS.SOB_ID                   = LM.SOB_ID(+)
        AND DS.TR_TYPE                  = 'SLIP'
        AND DS.SOB_ID                   = W_SOB_ID
        AND DS.GL_DATE                  = W_GL_DATE
        AND MA.TR_CLASS                 = '210'
        AND LU.TR_LOAN_TYPE             = '3'
      GROUP BY ROLLUP((FB.BANK_CODE
           , FB.BANK_NAME
           , LU.LOAN_USE_NAME
           , LM.ISSUE_DATE
           , LM.DUE_DATE
           , LM.INTER_RATE))
      ;
      
  END TR_DAILY_210_3_SELECT;

-- 차입금 내역 : 사채 현황.
  PROCEDURE TR_DAILY_210_4_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT FB.BANK_CODE
           , DECODE(GROUPING(FB.BANK_CODE), 1, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL), FB.BANK_NAME) AS BANK_NAME
           , BA.BANK_ACCOUNT_NUM
           , LU.LOAN_USE_NAME
           , SUM(NVL(LM.LOAN_AMOUNT, 0)) AS LOAN_AMOUNT
           , SUM(NVL(LM.LOAN_AMOUNT, 0) - NVL(DS.BEGIN_AMOUNT, 0)) AS BEGIN_AMOUNT
           , /*SUM(DS.CR_AMOUNT)*/ 0 AS DR_AMOUNT  -- 금일차입.
           , SUM(DS.DR_AMOUNT) AS CR_AMOUNT  -- 금일상환.
           , SUM(NVL(LM.LOAN_AMOUNT, 0) - NVL(DS.BEGIN_AMOUNT, 0) - NVL(DS.DR_AMOUNT, 0)/* + NVL(DS.CR_AMOUNT, 0)*/) AS REMAIN_AMOUNT
           , SUM(NVL(LM.LOAN_CURR_AMOUNT, 0)) AS LOAN_CURR_AMOUNT
           , SUM(NVL(LM.LOAN_CURR_AMOUNT, 0) - NVL(DS.BEGIN_CURR_AMOUNT, 0)) AS BEGIN_CURR_AMOUNT
           , /*SUM(DS.CR_CURR_AMOUNT)*/ 0 AS DR_CURR_AMOUNT  -- 금일차입.
           , SUM(DS.DR_CURR_AMOUNT) AS CR_CURR_AMOUNT  -- 금일상환.
           , SUM(NVL(LM.LOAN_CURR_AMOUNT, 0) - NVL(DS.BEGIN_CURR_AMOUNT, 0) - NVL(DS.DR_CURR_AMOUNT, 0)/* + NVL(DS.CR_CURR_AMOUNT, 0)*/) AS REMAIN_CURR_AMOUNT
           , TO_CHAR(LM.ISSUE_DATE, 'YYYY-MM-DD') AS ISSUE_DATE
           , TO_CHAR(LM.DUE_DATE, 'YYYY-MM-DD') AS DUE_DATE
           , TO_CHAR(LM.INTER_RATE) AS INTER_RATE
        FROM FI_TR_DAILY_SUM DS
          , FI_TR_MANAGE_ACCOUNTE_V MA
          , FI_LOAN_USE_V LU
          , FI_BANK_ACCOUNT BA
          , FI_BANK FB
          , FI_LOAN_MASTER LM
      WHERE DS.ACCOUNT_CODE           = MA.ACCOUNT_CODE
        AND DS.SOB_ID                   = MA.SOB_ID
        AND DS.LOAN_USE                 = LU.LOAN_USE_CODE
        AND DS.SOB_ID                   = LU.SOB_ID
        AND DS.BANK_ACCOUNT_CODE        = BA.BANK_ACCOUNT_CODE(+)
        AND DS.SOB_ID                   = BA.SOB_ID(+)
        AND DS.BANK_CODE                = FB.BANK_CODE(+)
        AND DS.SOB_ID                   = FB.SOB_ID(+)
        AND DS.LOAN_NUM                 = LM.LOAN_NUM(+)
        AND DS.SOB_ID                   = LM.SOB_ID(+)
        AND DS.TR_TYPE                  = 'SLIP'
        AND DS.SOB_ID                   = W_SOB_ID
        AND DS.GL_DATE                  = W_GL_DATE
        AND MA.TR_CLASS                 = '210'
        AND LU.TR_LOAN_TYPE             = '4'
      GROUP BY ROLLUP((FB.BANK_CODE
           , FB.BANK_NAME
           , LU.LOAN_USE_NAME
           , BA.BANK_ACCOUNT_NUM
           , LM.ISSUE_DATE
           , LM.DUE_DATE
           , LM.INTER_RATE))
      ;
      
  END TR_DAILY_210_4_SELECT;

-- 일일자금입/출금 내역.
  PROCEDURE TR_DAILY_SLIP_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT SX1.ACCOUNT_DR_CR
           , SX1.ACCOUNT_DR_CR_NAME
           , SX1.REMARK     
           , SX1.CUSTOMER_NAME 
           , SX1.BANK_NAME           
           , SX1.ORDINARY_AMOUNT  -- 보통예금.
           , SX1.ORDINARY_CURR_AMOUNT  -- 외화보통예금.
           , SX1.DEPOSIT_AMOUNT       -- 정기적금
           , SX1.BILL_AMOUNT          -- 어음.
           , SX1.CASH_AMOUNT  -- 현금.
        FROM 
          ( SELECT DECODE(GROUPING(SL.ACCOUNT_DR_CR), 1, 'Y', 'N') AS GROUPING_YN
                 , SL.ACCOUNT_DR_CR           
                 , CASE
                     WHEN SL.ACCOUNT_DR_CR = '1' AND GROUPING(FB.BANK_NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10214', NULL)
                     WHEN SL.ACCOUNT_DR_CR = '1' THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10212', NULL)
                     WHEN SL.ACCOUNT_DR_CR = '2' AND GROUPING(FB.BANK_NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10215', NULL)
                     WHEN SL.ACCOUNT_DR_CR = '2' THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10213', NULL)
                   END ACCOUNT_DR_CR_NAME
                 , SL.REMARK     
                 , FI_COMMON_G.SUPP_CUST_CODE_NAME_F(FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'CUSTOMER', SL.SOB_ID), SL.SOB_ID) AS CUSTOMER_NAME 
                 , FB.BANK_NAME
                 , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1110', SL.GL_AMOUNT, 0)) AS CASH_AMOUNT  -- 현금.
                 , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1120', SL.GL_AMOUNT, 0)) AS ORDINARY_AMOUNT  -- 보통예금.
                 , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1130', SL.GL_AMOUNT, 0)) AS ORDINARY_CURR_AMOUNT  -- 외화보통예금.
                 , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1140', SL.GL_AMOUNT, 0)) AS DEPOSIT_AMOUNT       -- 정기적금
                 , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1150', SL.GL_AMOUNT, 0)) AS BILL_AMOUNT          -- 어음.
              FROM FI_TR_DAILY_SUM DS
                , FI_SLIP_LINE SL
                , FI_TR_MANAGE_ACCOUNTE_V MA
                , FI_BANK FB
            WHERE DS.ACCOUNT_CONTROL_ID       = SL.ACCOUNT_CONTROL_ID
              AND DS.SOB_ID                   = SL.SOB_ID
              AND DS.GL_DATE                  = SL.GL_DATE
              AND DS.ACCOUNT_CODE             = MA.ACCOUNT_CODE
              AND DS.SOB_ID                   = MA.SOB_ID
              AND DS.BANK_CODE                = FB.BANK_CODE(+)
              AND DS.SOB_ID                   = FB.SOB_ID(+)
              AND DS.TR_TYPE                  = 'SLIP'
              AND DS.SOB_ID                   = W_SOB_ID
              AND DS.GL_DATE                  = W_GL_DATE
              AND MA.TR_MANAGE_GROUP_CODE     IS NOT NULL
              AND NOT EXISTS (SELECT 'X'
                                FROM FI_SLIP_MANAGEMENT_ITEM SM
                                  , FI_MANAGEMENT_CODE_V MC
                              WHERE SM.MANAGEMENT_ID      = MC.MANAGEMENT_ID
                                AND SM.SLIP_LINE_ID       = SL.SLIP_LINE_ID
                                AND SM.SOB_ID             = SL.SOB_ID
                                AND MC.LOOKUP_TYPE        = 'FUND_MOVE'
                             )
            GROUP BY ROLLUP((SL.ACCOUNT_DR_CR)
                 , (FB.BANK_NAME     
                 , FI_COMMON_G.SUPP_CUST_CODE_NAME_F(FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'CUSTOMER', SL.SOB_ID), SL.SOB_ID) 
                 , SL.REMARK))
            ORDER BY SL.ACCOUNT_DR_CR
          ) SX1
      WHERE SX1.GROUPING_YN             = 'N'
      ;
  
  END TR_DAILY_SLIP_SELECT;

-- 자금이체 현황.
  PROCEDURE TR_DAILY_FUND_MOVE_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT SX1.ACCOUNT_DR_CR
           , SX1.ACCOUNT_DR_CR_NAME
           , SX1.REMARK     
           , SX1.CUSTOMER_NAME 
           , SX1.BANK_NAME           
           , SX1.ORDINARY_AMOUNT  -- 보통예금.
           , SX1.ORDINARY_CURR_AMOUNT  -- 외화보통예금.
           , SX1.DEPOSIT_AMOUNT       -- 정기적금
           , SX1.BILL_AMOUNT          -- 어음.
           , SX1.CASH_AMOUNT  -- 현금.
        FROM 
          ( SELECT DECODE(GROUPING(SL.ACCOUNT_DR_CR), 1, 'Y', 'N') AS GROUPING_YN
                 , SL.ACCOUNT_DR_CR           
                 , CASE
                     WHEN SL.ACCOUNT_DR_CR = '1' AND GROUPING(FB.BANK_NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10214', NULL)
                     WHEN SL.ACCOUNT_DR_CR = '1' THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10212', NULL)
                     WHEN SL.ACCOUNT_DR_CR = '2' AND GROUPING(FB.BANK_NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10215', NULL)
                     WHEN SL.ACCOUNT_DR_CR = '2' THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10213', NULL)
                   END ACCOUNT_DR_CR_NAME
                 , SL.REMARK     
                 , FI_COMMON_G.SUPP_CUST_CODE_NAME_F(FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'CUSTOMER', SL.SOB_ID), SL.SOB_ID) AS CUSTOMER_NAME 
                 , FB.BANK_NAME
                 , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1110', SL.GL_AMOUNT, 0)) AS CASH_AMOUNT  -- 현금.
                 , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1120', SL.GL_AMOUNT, 0)) AS ORDINARY_AMOUNT  -- 보통예금.
                 , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1130', SL.GL_AMOUNT, 0)) AS ORDINARY_CURR_AMOUNT  -- 외화보통예금.
                 , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1140', SL.GL_AMOUNT, 0)) AS DEPOSIT_AMOUNT       -- 정기적금
                 , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1150', SL.GL_AMOUNT, 0)) AS BILL_AMOUNT          -- 어음.
              FROM FI_TR_DAILY_SUM DS
                , FI_SLIP_LINE SL
                , FI_TR_MANAGE_ACCOUNTE_V MA
                , FI_BANK FB
            WHERE DS.ACCOUNT_CONTROL_ID       = SL.ACCOUNT_CONTROL_ID
              AND DS.SOB_ID                   = SL.SOB_ID
              AND DS.GL_DATE                  = SL.GL_DATE
              AND DS.ACCOUNT_CODE             = MA.ACCOUNT_CODE
              AND DS.SOB_ID                   = MA.SOB_ID
              AND DS.BANK_CODE                = FB.BANK_CODE(+)
              AND DS.SOB_ID                   = FB.SOB_ID(+)
              AND DS.TR_TYPE                  = 'SLIP'
              AND DS.SOB_ID                   = W_SOB_ID
              AND DS.GL_DATE                  = W_GL_DATE
              AND MA.TR_MANAGE_GROUP_CODE     IS NOT NULL
              AND EXISTS (SELECT 'X'
                            FROM FI_SLIP_MANAGEMENT_ITEM SM
                              , FI_MANAGEMENT_CODE_V MC
                          WHERE SM.MANAGEMENT_ID      = MC.MANAGEMENT_ID
                            AND SM.SLIP_LINE_ID       = SL.SLIP_LINE_ID
                            AND SM.SOB_ID             = SL.SOB_ID
                            AND MC.LOOKUP_TYPE        = 'FUND_MOVE'
                         )
            GROUP BY ROLLUP((SL.ACCOUNT_DR_CR)
                 , (FB.BANK_NAME     
                 , FI_COMMON_G.SUPP_CUST_CODE_NAME_F(FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'CUSTOMER', SL.SOB_ID), SL.SOB_ID) 
                 , SL.REMARK))
            ORDER BY SL.ACCOUNT_DR_CR
          ) SX1
      WHERE SX1.GROUPING_YN             = 'N'
      ;
      
  END TR_DAILY_FUND_MOVE_SELECT;

-- 자금 일계획현황.
  PROCEDURE TR_DAILY_PLAN_SUM_SELECT
            ( P_CURSOR          OUT TYPES.TCURSOR
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT FTC.TR_CATEGORY_NAME
           , TC.TR_CLASS_NAME
           , DECODE(GROUPING(SX1.TR_MANAGE_NAME), 1, '총가용자금', SX1.TR_MANAGE_NAME) AS TR_MANAGE_NAME
           , SX1.BANK_NAME
           , SX1.CURRENCY_CODE
           , SUM(SX1.BEGIN_AMOUNT) AS BEGIN_AMOUNT
           , SUM(SX1.DR_AMOUNT) AS DR_AMOUNT
           , SUM(SX1.CR_AMOUNT) AS CR_AMOUNT
           , SUM(SX1.REMAIN_AMOUNT) AS REMAIN_AMOUNT
           , SX1.DESCRIPTION
        FROM FI_TR_CLASS_V TC
           , FI_TR_CATEGORY_V FTC
           , ( SELECT DS.TR_CLASS
                   , MA.TR_MANAGE_NAME
                   , DS.SOB_ID
                   , FB.BANK_NAME
                   , DS.CURRENCY_CODE
                   , DS.REMAIN_AMOUNT AS BEGIN_AMOUNT
                   , 0 AS DR_AMOUNT
                   , 0 AS CR_AMOUNT
                   , DS.REMAIN_AMOUNT AS REMAIN_AMOUNT
                   , NULL AS DESCRIPTION
                FROM FI_TR_DAILY_SUM DS
                  , FI_TR_MANAGE_ACCOUNTE_V MA 
                  , FI_BANK FB
              WHERE DS.ACCOUNT_CODE             = MA.ACCOUNT_CODE
                AND DS.SOB_ID                   = MA.SOB_ID
                AND DS.BANK_CODE                = FB.BANK_CODE(+)
                AND DS.SOB_ID                   = FB.SOB_ID(+)
                AND DS.TR_TYPE                  = 'SLIP'
                AND DS.SOB_ID                   = W_SOB_ID
                AND DS.GL_DATE                  = W_GL_DATE - 1
                AND DS.TR_CATEGORY             = '10'
              UNION ALL
              SELECT DS.TR_CLASS
                   , MA.TR_MANAGE_NAME
                   , DS.SOB_ID
                   , FB.BANK_NAME
                   , DS.CURRENCY_CODE
                   , 0 AS BEGIN_AMOUNT
                   , DS.DR_AMOUNT AS DR_AMOUNT
                   , DS.CR_AMOUNT AS CR_AMOUNT
                   , DS.DR_AMOUNT - DS.CR_AMOUNT AS REMAIN_AMOUNT
                   , NULL AS DESCRIPTION
                FROM FI_TR_DAILY_SUM DS
                  , FI_TR_MANAGE_ACCOUNTE_V MA 
                  , FI_BANK FB
              WHERE DS.ACCOUNT_CODE             = MA.ACCOUNT_CODE
                AND DS.SOB_ID                   = MA.SOB_ID
                AND DS.BANK_CODE                = FB.BANK_CODE(+)
                AND DS.SOB_ID                   = FB.SOB_ID(+)
                AND DS.TR_TYPE                  = 'PLAN'
                AND DS.SOB_ID                   = W_SOB_ID
                AND DS.GL_DATE                  = W_GL_DATE
                AND DS.TR_CATEGORY             = '10'
              UNION ALL
              SELECT '130' AS TR_CLASS
                   , FI_COMMON_G.CODE_NAME_F('TR_MANAGE_ACCOUNT', '1602', DS.SOB_ID) AS TR_MANAGE_NAME
                   , DS.SOB_ID
                   , DECODE(GROUPING(FB.BANK_CODE), 1, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL), FB.BANK_NAME) AS BANK_NAME           
                   , DS.CURRENCY_CODE
                   , SUM(NVL(LM.LOAN_AMOUNT, 0) - NVL(DS.BEGIN_AMOUNT, 0) - NVL(DS.DR_AMOUNT, 0) + NVL(DS.CR_AMOUNT, 0)) AS BEGIN_AMOUNT
                   , 0 AS DR_AMOUNT  -- 금일상환.
                   , 0 AS CR_AMOUNT  -- 금일차입.
                   , SUM(NVL(LM.LOAN_AMOUNT, 0) - NVL(DS.BEGIN_AMOUNT, 0) - NVL(DS.DR_AMOUNT, 0) + NVL(DS.CR_AMOUNT, 0)) AS REMAIN_AMOUNT
                   , NULL AS DESCRIPTION
                FROM FI_TR_DAILY_SUM DS
                  , FI_TR_MANAGE_ACCOUNTE_V MA
                  , FI_LOAN_USE_V LU
                  , FI_BANK FB
                  , FI_LOAN_MASTER LM
              WHERE DS.ACCOUNT_CODE             = MA.ACCOUNT_CODE
                AND DS.SOB_ID                   = MA.SOB_ID
                AND DS.LOAN_USE                 = LU.LOAN_USE_CODE
                AND DS.SOB_ID                   = LU.SOB_ID
                AND DS.BANK_CODE                = FB.BANK_CODE(+)
                AND DS.SOB_ID                   = FB.SOB_ID(+)
                AND DS.LOAN_NUM                 = LM.LOAN_NUM(+)
                AND DS.SOB_ID                   = LM.SOB_ID(+)
                AND DS.TR_TYPE                  = 'SLIP'
                AND DS.SOB_ID                   = W_SOB_ID
                AND DS.GL_DATE                  = W_GL_DATE - 1
                AND MA.TR_CLASS                 = '210'
                AND LU.TR_LOAN_TYPE             = '2'
             GROUP BY FI_COMMON_G.CODE_NAME_F('TR_MANAGE_ACCOUNT', '1602', DS.SOB_ID)
                   , DS.SOB_ID
                   , FB.BANK_CODE
                   , FB.BANK_NAME
                   , DS.CURRENCY_CODE
             UNION ALL
             SELECT '130' AS TR_CLASS
                   , FI_COMMON_G.CODE_NAME_F('TR_MANAGE_ACCOUNT', '1602', DS.SOB_ID) AS TR_MANAGE_NAME
                   , DS.SOB_ID
                   , DECODE(GROUPING(FB.BANK_CODE), 1, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL), FB.BANK_NAME) AS BANK_NAME           
                   , DS.CURRENCY_CODE
                   , 0 AS BEGIN_AMOUNT
                   , SUM(DS.DR_AMOUNT) AS DR_AMOUNT  -- 금일상환.
                   , SUM(DS.CR_AMOUNT) AS CR_AMOUNT  -- 금일차입.
                   , SUM(NVL(DS.DR_AMOUNT, 0) - NVL(DS.CR_AMOUNT, 0)) AS REMAIN_AMOUNT
                   , NULL AS DESCRIPTION
                FROM FI_TR_DAILY_SUM DS
                  , FI_TR_MANAGE_ACCOUNTE_V MA
                  , FI_LOAN_USE_V LU
                  , FI_BANK FB
                  , FI_LOAN_MASTER LM
              WHERE DS.ACCOUNT_CODE           = MA.ACCOUNT_CODE
                AND DS.SOB_ID                   = MA.SOB_ID
                AND DS.LOAN_USE                 = LU.LOAN_USE_CODE
                AND DS.SOB_ID                   = LU.SOB_ID
                AND DS.BANK_CODE                = FB.BANK_CODE(+)
                AND DS.SOB_ID                   = FB.SOB_ID(+)
                AND DS.LOAN_NUM                 = LM.LOAN_NUM(+)
                AND DS.SOB_ID                   = LM.SOB_ID(+)
                AND DS.TR_TYPE                  = 'PLAN'
                AND DS.SOB_ID                   = W_SOB_ID
                AND DS.GL_DATE                  = W_GL_DATE
                AND MA.TR_CLASS                 = '210'
                AND LU.TR_LOAN_TYPE             = '2'
             GROUP BY FI_COMMON_G.CODE_NAME_F('TR_MANAGE_ACCOUNT', '1602', DS.SOB_ID)
                   , DS.SOB_ID
                   , FB.BANK_CODE
                   , FB.BANK_NAME
                   , DS.CURRENCY_CODE    
             ) SX1
      WHERE TC.TR_CATEGORY              = FTC.TR_CATEGORY
        AND TC.SOB_ID                   = FTC.SOB_ID
        AND TC.TR_CLASS                 = SX1.TR_CLASS
        AND TC.SOB_ID                   = SX1.SOB_ID
      GROUP BY ROLLUP (( FTC.TR_CATEGORY_NAME
           , TC.TR_CLASS     
           , TC.TR_CLASS_NAME
           , SX1.TR_MANAGE_NAME
           , SX1.BANK_NAME
           , SX1.CURRENCY_CODE
           , SX1.DESCRIPTION))      
      ;

  END TR_DAILY_PLAN_SUM_SELECT;
            
-- 자금 계획 조회.
  PROCEDURE TR_DAILY_PLAN_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT DS.GL_DATE
           , DS.ACCOUNT_CONTROL_ID
           , DS.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , DECODE(NVL(DS.DR_AMOUNT, 0), 0, '2', '1') AS ACCOUNT_DR_CR
           , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', DECODE(NVL(DS.DR_AMOUNT, 0), 0, '2', '1'), DS.SOB_ID) AS ACCOUNT_DR_CR_NAME
           , DS.CURRENCY_CODE           
           , DECODE(NVL(DS.DR_AMOUNT, 0), 0, DS.CR_CURR_AMOUNT, DS.DR_CURR_AMOUNT) AS GL_CURR_AMOUNT
           , DECODE(NVL(DS.DR_AMOUNT, 0), 0, DS.CR_AMOUNT, DS.DR_AMOUNT) AS GL_AMOUNT
           , DS.DESCRIPTION
           , DS.BANK_CODE
           , FB.BANK_NAME           
           , DS.LOAN_USE
           , FI_COMMON_G.CODE_NAME_F('LOAN_USE', DS.LOAN_USE, DS.SOB_ID) AS LOAN_USE_NAME
           , DS.LOAN_NUM
           , LM.LOAN_DESC
           , DS.TR_CATEGORY
           , DS.TR_CLASS     
        FROM FI_TR_DAILY_SUM DS
          , FI_ACCOUNT_CONTROL AC
          , FI_BANK FB
          , FI_LOAN_MASTER LM
      WHERE DS.ACCOUNT_CONTROL_ID     = AC.ACCOUNT_CONTROL_ID
        AND DS.BANK_CODE              = FB.BANK_CODE(+)
        AND DS.SOB_ID                 = FB.SOB_ID(+)
        AND DS.LOAN_NUM               = LM.LOAN_NUM(+)
        AND DS.SOB_ID                 = LM.SOB_ID(+)
        AND DS.TR_TYPE                = 'PLAN'
        AND DS.SOB_ID                 = W_SOB_ID
        AND DS.GL_DATE                = W_GL_DATE
      ORDER BY DS.ACCOUNT_CODE
      ;
  
  END TR_DAILY_PLAN_SELECT;

-- 자금일보 삽입.
  PROCEDURE TR_DAILY_PLAN_INSERT
          ( P_SOB_ID             IN FI_TR_DAILY_SUM.SOB_ID%TYPE
          , P_GL_DATE            IN FI_TR_DAILY_SUM.GL_DATE%TYPE
          , P_ACCOUNT_CONTROL_ID IN FI_TR_DAILY_SUM.ACCOUNT_CONTROL_ID%TYPE
          , P_ACCOUNT_CODE       IN FI_TR_DAILY_SUM.ACCOUNT_CODE%TYPE
          , P_ACCOUNT_DR_CR      IN VARCHAR2
          , P_CURRENCY_CODE      IN FI_TR_DAILY_SUM.CURRENCY_CODE%TYPE
          , P_GL_CURR_AMOUNT     IN FI_TR_DAILY_SUM.DR_CURR_AMOUNT%TYPE
          , P_GL_AMOUNT          IN FI_TR_DAILY_SUM.DR_AMOUNT%TYPE
          , P_DESCRIPTION        IN FI_TR_DAILY_SUM.DESCRIPTION%TYPE
          , P_BANK_CODE          IN FI_TR_DAILY_SUM.BANK_CODE%TYPE
          , P_LOAN_USE           IN FI_TR_DAILY_SUM.LOAN_USE%TYPE
          , P_LOAN_NUM           IN FI_TR_DAILY_SUM.LOAN_NUM%TYPE
          , P_TR_CATEGORY        IN FI_TR_DAILY_SUM.TR_CATEGORY%TYPE
          , P_TR_CLASS           IN FI_TR_DAILY_SUM.TR_CLASS%TYPE
          )
  AS
    V_DR_CURR_AMOUNT             NUMBER := 0;
    V_CR_CURR_AMOUNT             NUMBER := 0;
    V_DR_AMOUNT                  NUMBER := 0;
    V_CR_AMOUNT                  NUMBER := 0;
    
  BEGIN
    IF P_ACCOUNT_DR_CR = '1' THEN
      V_DR_CURR_AMOUNT := P_GL_CURR_AMOUNT;
      V_DR_AMOUNT      := P_GL_AMOUNT;
    ELSE
      V_CR_CURR_AMOUNT := P_GL_CURR_AMOUNT;
      V_CR_AMOUNT      := P_GL_AMOUNT;
    END IF;
    
    INSERT INTO FI_TR_DAILY_SUM
    ( TR_TYPE
    , SOB_ID 
    , GL_DATE 
    , ACCOUNT_CONTROL_ID 
    , ACCOUNT_CODE 
    , CURRENCY_CODE 
    , DR_CURR_AMOUNT 
    , CR_CURR_AMOUNT 
    , DR_AMOUNT 
    , CR_AMOUNT 
    , DESCRIPTION 
    , BANK_CODE 
    , LOAN_USE 
    , LOAN_NUM 
    , TR_CATEGORY 
    , TR_CLASS )
    VALUES
    ( 'PLAN'
    , P_SOB_ID
    , P_GL_DATE
    , P_ACCOUNT_CONTROL_ID
    , P_ACCOUNT_CODE
    , P_CURRENCY_CODE
    , V_DR_CURR_AMOUNT
    , V_CR_CURR_AMOUNT
    , V_DR_AMOUNT
    , V_CR_AMOUNT
    , P_DESCRIPTION
    , P_BANK_CODE
    , P_LOAN_USE
    , P_LOAN_NUM
    , P_TR_CATEGORY
    , P_TR_CLASS);
  
  END TR_DAILY_PLAN_INSERT;
  
-- 회계계정관리 LOOKUP 조회 - 자금일보 관리 계정만.
  PROCEDURE LU_ACCOUNT_CONTROL
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_ACCOUNT_CONTROL.SOB_ID%TYPE
            , W_ENABLED_YN           IN FI_ACCOUNT_CONTROL.ENABLED_FLAG%TYPE
            )
  AS
    V_STD_DATE                       DATE := NULL;

  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    END IF;

    OPEN P_CURSOR3 FOR
      SELECT AC.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , AC.ACCOUNT_CONTROL_ID
           , MA.TR_CATEGORY
           , MA.TR_CLASS           
        FROM FI_ACCOUNT_CONTROL AC
          , FI_TR_MANAGE_ACCOUNTE_V MA
       WHERE AC.ACCOUNT_CODE            = MA.ACCOUNT_CODE
         AND AC.SOB_ID                  = MA.SOB_ID
         AND AC.ACCOUNT_SET_ID          = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_SET_F(W_SOB_ID)
         AND AC.SOB_ID                  = W_SOB_ID
         AND AC.ENABLED_FLAG            = DECODE(W_ENABLED_YN, 'Y', 'Y', AC.ENABLED_FLAG)
         AND AC.EFFECTIVE_DATE_FR       <= NVL(V_STD_DATE, AC.EFFECTIVE_DATE_FR)
         AND (AC.EFFECTIVE_DATE_TO IS NULL OR AC.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, AC.EFFECTIVE_DATE_TO))
      ORDER BY AC.ACCOUNT_CODE
      ;

  END  LU_ACCOUNT_CONTROL;
  
-- 일일 자금현황 생성.
  PROCEDURE TR_DAILY_CREATE
            ( W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            , O_MESSAGE         OUT VARCHAR2
            )
  AS
    V_BANK_CODE                 VARCHAR2(20);
    
  BEGIN
    BEGIN
      DELETE FROM FI_TR_DAILY_SUM TD
      WHERE TD.TR_TYPE          = 'SLIP'
        AND TD.GL_DATE          = W_GL_DATE
        AND TD.SOB_ID           = W_SOB_ID            
      ;
    END;
    
    -- 기초 COPY.
    BEGIN
      INSERT INTO FI_TR_DAILY_SUM
      ( TR_TYPE, SOB_ID, GL_DATE
      , ACCOUNT_CONTROL_ID, ACCOUNT_CODE
      , CURRENCY_CODE, EXCHANGE_RATE
      , BEGIN_CURR_AMOUNT, BEGIN_AMOUNT
      , REMAIN_CURR_AMOUNT, REMAIN_AMOUNT
      , BANK_CODE, BANK_ACCOUNT_CODE
      , LOAN_USE, LOAN_NUM
      , TR_CATEGORY, TR_CLASS
      , CLOSED_YN
      )
      SELECT TDS.TR_TYPE
           , TDS.SOB_ID
           , W_GL_DATE
           , TDS.ACCOUNT_CONTROL_ID
           , TDS.ACCOUNT_CODE
           , TDS.CURRENCY_CODE
           , TDS.EXCHANGE_RATE
           , TDS.REMAIN_CURR_AMOUNT AS BEGIN_CURR_AMOUNT
           , TDS.REMAIN_AMOUNT AS BEGIN_AMOUNT
           , TDS.REMAIN_CURR_AMOUNT
           , TDS.REMAIN_AMOUNT
           , BANK_CODE
           , BANK_ACCOUNT_CODE
           , LOAN_USE
           , LOAN_NUM
           , TR_CATEGORY
           , TR_CLASS
           , 'N'     
        FROM FI_TR_DAILY_SUM TDS
      WHERE TDS.TR_TYPE                 = 'SLIP'
        AND TDS.SOB_ID                  = W_SOB_ID
        AND TDS.GL_DATE                 IN (SELECT MAX(DS.GL_DATE) AS GL_DATE
                                              FROM FI_TR_DAILY_SUM DS
                                            WHERE DS.TR_TYPE      = 'SLIP'
                                              AND DS.SOB_ID       = W_SOB_ID
                                              AND DS.GL_DATE      <= W_GL_DATE               
                                          )
      ;
    
    END;
    
    FOR C1 IN (SELECT 'SLIP' AS TR_TYPE
                     , SL.GL_DATE
                     , SL.SOB_ID
                     , SL.ACCOUNT_CONTROL_ID                     
                     , SL.ACCOUNT_CODE
                     , SL.CURRENCY_CODE
                     , MAX(SL.EXCHANGE_RATE) AS EXCHANGE_RATE
                     , SUM(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_CURRENCY_AMOUNT, 0)) AS DR_CURR_AMOUNT
                     , SUM(DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_CURRENCY_AMOUNT, 0)) AS CR_CURR_AMOUNT
                     , SUM(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)) AS DR_AMOUNT
                     , SUM(DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)) AS CR_AMOUNT
                     , SUM((DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_CURRENCY_AMOUNT, 0)
                        * DECODE(AC.ACCOUNT_DR_CR, '1', 1, -1)) +
                        (DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_CURRENCY_AMOUNT, 0)
                        * DECODE(AC.ACCOUNT_DR_CR, '2', 1, -1))) AS REMAIN_CURR_AMOUNT
                     , SUM((DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)
                        * DECODE(AC.ACCOUNT_DR_CR, '1', 1, -1)) +
                        (DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)
                        * DECODE(AC.ACCOUNT_DR_CR, '2', 1, -1))) AS REMAIN_AMOUNT
                     , FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'BANK', SL.SOB_ID) AS BANK_CODE
                     , FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'BANK_ACCOUNT', SL.SOB_ID) AS BANK_ACCOUNT_CODE                                          
                     , FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'LOAN_USE', SL.SOB_ID) AS LOAN_USE
                     , FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'LOAN_NUM', SL.SOB_ID) AS LOAN_NUM
                     , MA.TR_CATEGORY
                     , MA.TR_CLASS
                     , 'N' CLOSED_YN
                  FROM FI_SLIP_LINE SL
                    , FI_ACCOUNT_CONTROL AC
                    , ( SELECT FC.VALUE1 AS ACCOUNT_CODE
                            , FC.VALUE2 AS ACCOUNT_DESC
                            , FC.VALUE3 AS TR_CATEGORY
                            , FC.VALUE4 AS TR_CLASS
                            , FC.SOB_ID
                          FROM FI_COMMON FC
                        WHERE FC.GROUP_CODE   = 'TR_MANAGE_ACCOUNT'
                          AND FC.SOB_ID       = W_SOB_ID
                          AND FC.ENABLED_FLAG = 'Y'
                          AND FC.EFFECTIVE_DATE_FR    <= W_GL_DATE
                          AND (FC.EFFECTIVE_DATE_TO IS NULL OR FC.EFFECTIVE_DATE_TO >= W_GL_DATE)
                      ) MA
                WHERE SL.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
                  AND SL.SOB_ID                   = AC.SOB_ID                  
                  AND SL.ACCOUNT_CODE             = MA.ACCOUNT_CODE
                  AND SL.SOB_ID                   = MA.SOB_ID  
                  AND SL.GL_DATE                  = W_GL_DATE
                  AND SL.SOB_ID                   = W_SOB_ID  
                GROUP BY SL.GL_DATE
                     , SL.SOB_ID
                     , SL.ACCOUNT_CONTROL_ID                     
                     , SL.ACCOUNT_CODE
                     , SL.CURRENCY_CODE
                     , FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'BANK', SL.SOB_ID)
                     , FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'BANK_ACCOUNT', SL.SOB_ID)                                          
                     , FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'LOAN_USE', SL.SOB_ID)
                     , FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'LOAN_NUM', SL.SOB_ID)
                     , MA.TR_CATEGORY
                     , MA.TR_CLASS
                ORDER BY SL.ACCOUNT_CODE
               )
    LOOP
      V_BANK_CODE := C1.BANK_CODE;
      IF C1.BANK_CODE IS NULL THEN
        BEGIN
          SELECT FB.BANK_CODE
            INTO V_BANK_CODE
            FROM FI_BANK_ACCOUNT BA
              , FI_BANK FB
          WHERE BA.BANK_ID            = FB.BANK_ID
            AND BA.BANK_ACCOUNT_CODE  = C1.BANK_ACCOUNT_CODE
            AND BA.SOB_ID             = C1.SOB_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          V_BANK_CODE := C1.BANK_CODE;
        END;
      END IF;
      -- 자금현황.      
      UPDATE FI_TR_DAILY_SUM DS
        SET DS.DR_CURR_AMOUNT = NVL(C1.DR_CURR_AMOUNT, 0)
          , DS.CR_CURR_AMOUNT = NVL(C1.CR_CURR_AMOUNT, 0)
          , DS.DR_AMOUNT      = NVL(C1.DR_AMOUNT, 0)
          , DS.CR_AMOUNT      = NVL(C1.CR_AMOUNT, 0)
          , DS.REMAIN_CURR_AMOUNT = NVL(DS.BEGIN_CURR_AMOUNT, 0) + NVL(C1.REMAIN_CURR_AMOUNT, 0)
          , DS.REMAIN_AMOUNT  = NVL(DS.BEGIN_AMOUNT, 0) + NVL(C1.REMAIN_AMOUNT, 0)
      WHERE DS.TR_TYPE          = C1.TR_TYPE
        AND DS.SOB_ID           = C1.SOB_ID
        AND DS.GL_DATE          = C1.GL_DATE
        AND DS.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
        AND DS.CURRENCY_CODE      = C1.CURRENCY_CODE
        AND NVL(DS.BANK_CODE, '-')          = V_BANK_CODE
        AND NVL(DS.BANK_ACCOUNT_CODE, '-')  = NVL(C1.BANK_ACCOUNT_CODE, '-')
        AND NVL(DS.LOAN_USE, '-')           = NVL(C1.LOAN_USE, '-')
          
      ;        
      IF SQL%ROWCOUNT = 0 THEN      
        INSERT INTO FI_TR_DAILY_SUM
        ( TR_TYPE
        , SOB_ID
        , GL_DATE
        , ACCOUNT_CONTROL_ID
        , ACCOUNT_CODE           
        , CURRENCY_CODE
        , EXCHANGE_RATE
        , DR_CURR_AMOUNT
        , CR_CURR_AMOUNT
        , DR_AMOUNT
        , CR_AMOUNT
        , REMAIN_CURR_AMOUNT
        , REMAIN_AMOUNT
        , BANK_CODE
        , BANK_ACCOUNT_CODE      
        , LOAN_USE
        , LOAN_NUM
        , TR_CATEGORY
        , TR_CLASS
        , CLOSED_YN
        ) VALUES
        ( C1.TR_TYPE
        , C1.SOB_ID
        , C1.GL_DATE
        , C1.ACCOUNT_CONTROL_ID
        , C1.ACCOUNT_CODE
        , C1.CURRENCY_CODE
        , C1.EXCHANGE_RATE
        , NVL(C1.DR_CURR_AMOUNT, 0)
        , NVL(C1.CR_CURR_AMOUNT, 0)
        , NVL(C1.DR_AMOUNT, 0)
        , NVL(C1.CR_AMOUNT, 0)
        , NVL(C1.REMAIN_CURR_AMOUNT, 0)
        , NVL(C1.REMAIN_AMOUNT, 0)
        , V_BANK_CODE
        , C1.BANK_ACCOUNT_CODE
        , C1.LOAN_USE
        , C1.LOAN_NUM
        , C1.TR_CATEGORY
        , C1.TR_CLASS
        , C1.CLOSED_YN            
        );
      END IF;
    END LOOP C1;
    COMMIT;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END TR_DAILY_CREATE;
  
END FI_TR_DAILY_SUM_G;
/
