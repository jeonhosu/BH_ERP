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

-- 자금 계획.
  PROCEDURE TR_DAILY_PLAN_SUM_SELECT
            ( P_CURSOR          OUT TYPES.TCURSOR
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            );

-- 자금 계획 인쇄 조회.
  PROCEDURE TR_DAILY_PLAN_PRINT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
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
            ( P_TR_DAILY_SUM_ID    OUT FI_TR_DAILY_SUM.TR_DAILY_SUM_ID%TYPE
            , P_SOB_ID             IN FI_TR_DAILY_SUM.SOB_ID%TYPE
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
            , P_FUND_MOVE          IN FI_TR_DAILY_SUM.FUND_MOVE%TYPE
            );

  PROCEDURE TR_DAILY_PLAN_UPDATE
            ( W_TR_DAILY_SUM_ID    IN FI_TR_DAILY_SUM.TR_DAILY_SUM_ID%TYPE
            , W_SOB_ID             IN FI_TR_DAILY_SUM.SOB_ID%TYPE
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
            , P_FUND_MOVE          IN FI_TR_DAILY_SUM.FUND_MOVE%TYPE 
            );

  PROCEDURE TR_DAILY_PLAN_DELETE
            ( W_TR_DAILY_SUM_ID    IN FI_TR_DAILY_SUM.TR_DAILY_SUM_ID%TYPE
            , W_SOB_ID             IN FI_TR_DAILY_SUM.SOB_ID%TYPE
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
           , CASE   
               WHEN GROUPING(FTC.TR_CATEGORY_NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10222', NULL)
               WHEN GROUPING(SX1.TR_MANAGE_NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL)
               ELSE SX1.TR_MANAGE_NAME
             END AS TR_MANAGE_NAME
           , DECODE(GROUPING(SX1.TR_MANAGE_NAME), 1, NULL, MAX(SX1.BANK_NAME)) AS BANK_NAME
           , SX1.CURRENCY_CODE
           , SUM(SX1.BEGIN_AMOUNT) AS BEGIN_AMOUNT
           , SUM(SX1.DR_AMOUNT) AS DR_AMOUNT
           , SUM(SX1.CR_AMOUNT) AS CR_AMOUNT
           , SUM(SX1.REMAIN_AMOUNT) AS REMAIN_AMOUNT
           , SUM(SX1.BEGIN_CURR_AMOUNT) AS BEGIN_CURR_AMOUNT
           , SUM(SX1.DR_CURR_AMOUNT) AS DR_CURR_AMOUNT
           , SUM(SX1.CR_CURR_AMOUNT) AS CR_CURR_AMOUNT
           , SUM(SX1.REMAIN_CURR_AMOUNT) AS REMAIN_CURR_AMOUNT
           , SX1.DESCRIPTION
        FROM FI_TR_CLASS_V TC
           , FI_TR_CATEGORY_V FTC
           , ( SELECT DS.TR_CLASS
                   , MA.TR_MANAGE_NAME
                   , DS.SOB_ID
                   , CASE
                       WHEN MA.TR_MANAGE_GROUP_CODE = '1110' THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10227', NULL)
                       ELSE FB.BANK_NAME || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10228', NULL)
                     END AS BANK_NAME
                   , DS.CURRENCY_CODE
                   , DS.BEGIN_AMOUNT
                   , DS.DR_AMOUNT
                   , DS.CR_AMOUNT
                   , DS.REMAIN_AMOUNT
                   , DS.BEGIN_CURR_AMOUNT
                   , DS.DR_CURR_AMOUNT
                   , DS.CR_CURR_AMOUNT
                   , DS.REMAIN_CURR_AMOUNT
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
                AND DS.TR_CATEGORY              = '10'
              UNION ALL
              SELECT '130' AS TR_CLASS 
                    , FI_COMMON_G.CODE_NAME_F('TR_MANAGE_ACCOUNT', '1602', LM.SOB_ID) AS TR_MANAGE_NAME
                    , LM.SOB_ID
                    , CASE
                         WHEN GROUPING(FB.BANK_CODE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL)
                         ELSE FB.BANK_NAME || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10228', NULL)
                       END AS BANK_NAME
                    , LM.CURRENCY_CODE
                    , SUM(NVL(LM.LIMIT_AMOUNT, 0) - NVL(SX3.REMAIN_AMOUNT, 0)) AS BEGIN_AMOUNT
                    , SUM(SX2.CR_AMOUNT) AS DR_AMOUNT
                    , SUM(SX2.DR_AMOUNT) AS CR_AMOUNT
                    , SUM(NVL(LM.LIMIT_AMOUNT, 0) - NVL(SX2.REMAIN_AMOUNT, 0)) AS REMAIN_AMOUNT
                    , SUM(NVL(LM.LIMIT_CURR_AMOUNT, 0) - NVL(SX3.REMAIN_CURR_AMOUNT, 0)) AS BEGIN_CURR_AMOUNT
                    , SUM(SX2.CR_CURR_AMOUNT) AS DR_CURR_AMOUNT
                    , SUM(SX2.DR_CURR_AMOUNT) AS CR_CURR_AMOUNT
                    , SUM(NVL(LM.LIMIT_CURR_AMOUNT, 0) - NVL(SX2.REMAIN_CURR_AMOUNT, 0)) AS REMAIN_CURR_AMOUNT
                    , NULL AS DESCRIPTION
                FROM FI_LOAN_MASTER LM
                  , FI_LOAN_USE_V LU
                  , FI_BANK FB
                  , ( -- 당일 발생.
                      SELECT DS.LOAN_USE
                           , DS.LOAN_NUM
                           , DS.SOB_ID
                           , DS.CURRENCY_CODE
                           , DS.BEGIN_AMOUNT
                           , DS.CR_AMOUNT AS DR_AMOUNT
                           , DS.DR_AMOUNT AS CR_AMOUNT
                           , DS.REMAIN_AMOUNT AS REMAIN_AMOUNT
                           , DS.BEGIN_CURR_AMOUNT
                           , DS.CR_CURR_AMOUNT AS DR_CURR_AMOUNT
                           , DS.DR_CURR_AMOUNT AS CR_CURR_AMOUNT
                           , DS.REMAIN_CURR_AMOUNT AS REMAIN_CURR_AMOUNT
                        FROM FI_TR_DAILY_SUM DS
                          , FI_TR_MANAGE_ACCOUNTE_V MA
                          , FI_LOAN_USE_V FU
                      WHERE DS.ACCOUNT_CODE             = MA.ACCOUNT_CODE
                        AND DS.SOB_ID                   = MA.SOB_ID
                        AND DS.LOAN_USE                 = FU.LOAN_USE_CODE
                        AND DS.SOB_ID                   = FU.SOB_ID
                        AND DS.TR_TYPE                  = 'SLIP'
                        AND DS.SOB_ID                   = W_SOB_ID
                        AND DS.GL_DATE                  = W_GL_DATE
                        AND MA.TR_CLASS                 = '210'
                    ) SX2
                  , ( -- 전일 발생.
                      SELECT DS.LOAN_USE
                           , DS.LOAN_NUM
                           , DS.SOB_ID
                           , DS.CURRENCY_CODE
                           , DS.BEGIN_AMOUNT
                           , DS.REMAIN_AMOUNT AS REMAIN_AMOUNT
                           , DS.BEGIN_CURR_AMOUNT
                           , DS.REMAIN_CURR_AMOUNT AS REMAIN_CURR_AMOUNT
                        FROM FI_TR_DAILY_SUM DS
                          , FI_TR_MANAGE_ACCOUNTE_V MA
                          , FI_LOAN_USE_V FU
                      WHERE DS.ACCOUNT_CODE             = MA.ACCOUNT_CODE
                        AND DS.SOB_ID                   = MA.SOB_ID
                        AND DS.LOAN_USE                 = FU.LOAN_USE_CODE
                        AND DS.SOB_ID                   = FU.SOB_ID
                        AND DS.TR_TYPE                  = 'SLIP'
                        AND DS.SOB_ID                   = W_SOB_ID
                        AND DS.GL_DATE                  = W_GL_DATE - 1
                        AND MA.TR_CLASS                 = '210'
                    ) SX3
              WHERE LM.LOAN_USE                 = LU.LOAN_USE_CODE
                AND LM.SOB_ID                   = LU.SOB_ID
                AND LM.LOAN_BANK_ID             = FB.BANK_ID(+)
                AND LM.LOAN_NUM                 = SX2.LOAN_NUM(+)
                AND LM.SOB_ID                   = SX2.SOB_ID(+)
                AND LM.LOAN_NUM                 = SX3.LOAN_NUM(+)
                AND LM.SOB_ID                   = SX3.SOB_ID(+)
                AND LU.LOAN_KIND_CODE           = '2'
              GROUP BY FB.BANK_CODE
                    , FB.BANK_NAME
                    , LM.SOB_ID
                    , LM.CURRENCY_CODE
             ) SX1
      WHERE TC.TR_CATEGORY              = FTC.TR_CATEGORY
        AND TC.SOB_ID                   = FTC.SOB_ID
        AND TC.TR_CLASS                 = SX1.TR_CLASS
        AND TC.SOB_ID                   = SX1.SOB_ID
      GROUP BY ROLLUP (( FTC.TR_CATEGORY_NAME
           , TC.TR_CLASS     
           , TC.TR_CLASS_NAME)
           , (SX1.TR_MANAGE_NAME
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
      SELECT TCV.TR_CATEGORY_NAME
           , TC.TR_CLASS_NAME
           , CASE 
               WHEN GROUPING(TCV.TR_CATEGORY_NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10229', NULL)
               WHEN GROUPING(SX1.TR_MANAGE_NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL)
               ELSE SX1.TR_MANAGE_NAME
             END AS TR_MANAGE_NAME
           , SX1.LOAN_USE_NAME AS BANK_NAME
           , SX1.CURRENCY_CODE
           , SUM(SX1.BEGIN_AMOUNT) AS BEGIN_AMOUNT
           , SUM(SX1.DR_AMOUNT) AS DR_AMOUNT
           , SUM(SX1.CR_AMOUNT) AS CR_AMOUNT
           , SUM(SX1.REMAIN_AMOUNT) AS REMAIN_AMOUNT
           , SUM(SX1.BEGIN_CURR_AMOUNT) AS BEGIN_CURR_AMOUNT
           , SUM(SX1.DR_CURR_AMOUNT) AS DR_CURR_AMOUNT
           , SUM(SX1.CR_CURR_AMOUNT) AS CR_CURR_AMOUNT
           , SUM(SX1.REMAIN_CURR_AMOUNT) AS REMAIN_CURR_AMOUNT
           , SX1.DESCRIPTION
          FROM FI_TR_CATEGORY_V TCV
           , FI_TR_CLASS_V TC
           , (SELECT LU.TR_CLASS_CODE
                  , FI_COMMON_G.CODE_NAME_F('LOAN_KIND', LU.LOAN_KIND_CODE, LU.SOB_ID) AS TR_MANAGE_NAME
                  , CASE
                      WHEN LU.LOAN_KIND_CODE = '3' AND LM.LOAN_USE <> '90' THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10140', NULL)
                      ELSE LU.LOAN_USE_NAME 
                    END AS LOAN_USE_NAME
                  , DS.SOB_ID
                  , DS.CURRENCY_CODE
                  , DS.BEGIN_AMOUNT
                  , DS.CR_AMOUNT AS DR_AMOUNT
                  , DS.DR_AMOUNT AS CR_AMOUNT
                  , DS.REMAIN_AMOUNT AS REMAIN_AMOUNT
                  , DS.BEGIN_CURR_AMOUNT
                  , DS.CR_CURR_AMOUNT AS DR_CURR_AMOUNT
                  , DS.DR_CURR_AMOUNT AS CR_CURR_AMOUNT
                  , DS.REMAIN_CURR_AMOUNT AS REMAIN_CURR_AMOUNT
                  , NULL AS DESCRIPTION
                  , DS.LOAN_USE
                FROM FI_TR_DAILY_SUM DS
                  , FI_TR_MANAGE_ACCOUNTE_V MA
                  , FI_LOAN_MASTER LM
                  , FI_LOAN_USE_V LU
              WHERE DS.ACCOUNT_CODE             = MA.ACCOUNT_CODE
                AND DS.SOB_ID                   = MA.SOB_ID
                AND DS.LOAN_NUM                 = LM.LOAN_NUM
                AND DS.SOB_ID                   = LM.SOB_ID
                AND LM.LOAN_USE                 = LU.LOAN_USE_CODE
                AND LM.SOB_ID                   = LU.SOB_ID
                AND DS.TR_TYPE                  = 'SLIP'
                AND DS.SOB_ID                   = W_SOB_ID
                AND DS.GL_DATE                  = W_GL_DATE
                AND MA.TR_CLASS                 IN('140', '210')
                AND LU.LOAN_KIND_CODE           IN ('3', '4')
            UNION ALL
            SELECT LU.TR_CLASS_CODE
                  , FI_COMMON_G.CODE_NAME_F('LOAN_KIND', LU.LOAN_KIND_CODE, LU.SOB_ID) AS TR_MANAGE_NAME
                  , CASE
                      WHEN DS.CURRENCY_CODE = 'KRW' THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10234', NULL)
                      ELSE EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10235', NULL)
                    END AS LOAN_USE_NAME
                  , DS.SOB_ID
                  , DS.CURRENCY_CODE
                  , DS.BEGIN_AMOUNT
                  , DS.CR_AMOUNT AS DR_AMOUNT
                  , DS.DR_AMOUNT AS CR_AMOUNT
                  , DS.REMAIN_AMOUNT AS REMAIN_AMOUNT
                  , DS.BEGIN_CURR_AMOUNT
                  , DS.CR_CURR_AMOUNT AS DR_CURR_AMOUNT
                  , DS.DR_CURR_AMOUNT AS CR_CURR_AMOUNT
                  , DS.REMAIN_CURR_AMOUNT AS REMAIN_CURR_AMOUNT
                  , NULL AS DESCRIPTION
                  , DS.LOAN_USE
                FROM FI_TR_DAILY_SUM DS
                  , FI_TR_MANAGE_ACCOUNTE_V MA
                  , FI_LOAN_MASTER LM
                  , FI_LOAN_USE_V LU
              WHERE DS.ACCOUNT_CODE             = MA.ACCOUNT_CODE
                AND DS.SOB_ID                   = MA.SOB_ID
                AND DS.LOAN_NUM                 = LM.LOAN_NUM
                AND DS.SOB_ID                   = LM.SOB_ID
                AND LM.LOAN_USE                 = LU.LOAN_USE_CODE
                AND LM.SOB_ID                   = LU.SOB_ID
                AND DS.TR_TYPE                  = 'SLIP'
                AND DS.SOB_ID                   = W_SOB_ID
                AND DS.GL_DATE                  = W_GL_DATE
                AND MA.TR_CLASS                 IN('140', '210')
                AND LU.LOAN_KIND_CODE           NOT IN ('3', '4')
              ORDER BY LOAN_USE
             ) SX1
      WHERE TCV.TR_CATEGORY             = TC.TR_CATEGORY
        AND TCV.SOB_ID                  = TC.SOB_ID
        AND TC.TR_CLASS                 = SX1.TR_CLASS_CODE
        AND TC.SOB_ID                   = SX1.SOB_ID
      GROUP BY ROLLUP (( TCV.TR_CATEGORY_NAME
           , TC.TR_CLASS     
           , TC.TR_CLASS_NAME)
           , (SX1.TR_MANAGE_NAME
           , SX1.LOAN_USE_NAME
           , SX1.CURRENCY_CODE
           , SX1.DESCRIPTION))
      ;
      
      /*SELECT TCV.TR_CATEGORY_NAME
           , TC.TR_CLASS_NAME
           , CASE 
               WHEN GROUPING(TCV.TR_CATEGORY_NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10229', NULL)
               WHEN GROUPING(SX1.TR_MANAGE_NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL)
               ELSE SX1.TR_MANAGE_NAME
             END AS TR_MANAGE_NAME
           , SX1.LOAN_USE_NAME AS BANK_NAME
           , SX1.CURRENCY_CODE
           , SUM(SX1.BEGIN_AMOUNT) AS BEGIN_AMOUNT
           , SUM(SX1.DR_AMOUNT) AS DR_AMOUNT
           , SUM(SX1.CR_AMOUNT) AS CR_AMOUNT
           , SUM(SX1.REMAIN_AMOUNT) AS REMAIN_AMOUNT
           , SUM(SX1.BEGIN_CURR_AMOUNT) AS BEGIN_CURR_AMOUNT
           , SUM(SX1.DR_CURR_AMOUNT) AS DR_CURR_AMOUNT
           , SUM(SX1.CR_CURR_AMOUNT) AS CR_CURR_AMOUNT
           , SUM(SX1.REMAIN_CURR_AMOUNT) AS REMAIN_CURR_AMOUNT
           , SX1.DESCRIPTION
          FROM FI_TR_CATEGORY_V TCV
           , FI_TR_CLASS_V TC
           , (SELECT LU.TR_CLASS_CODE
                  , FI_COMMON_G.CODE_NAME_F('LOAN_KIND', LU.LOAN_KIND_CODE, LU.SOB_ID) AS TR_MANAGE_NAME
                  , CASE
                      WHEN LU.LOAN_KIND_CODE = '3' AND LM.LOAN_USE <> '90' THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10140', NULL)
                      ELSE LU.LOAN_USE_NAME 
                    END AS LOAN_USE_NAME
                  , DS.SOB_ID
                  , DS.CURRENCY_CODE
                  , DS.BEGIN_AMOUNT
                  , DS.CR_AMOUNT AS DR_AMOUNT
                  , DS.DR_AMOUNT AS CR_AMOUNT
                  , DS.REMAIN_AMOUNT AS REMAIN_AMOUNT
                  , DS.BEGIN_CURR_AMOUNT
                  , DS.CR_CURR_AMOUNT AS DR_CURR_AMOUNT
                  , DS.DR_CURR_AMOUNT AS CR_CURR_AMOUNT
                  , DS.REMAIN_CURR_AMOUNT AS REMAIN_CURR_AMOUNT
                  , NULL AS DESCRIPTION
                FROM FI_TR_DAILY_SUM DS
                  , FI_TR_MANAGE_ACCOUNTE_V MA
                  , FI_LOAN_MASTER LM
                  , FI_LOAN_USE_V LU
              WHERE DS.ACCOUNT_CODE             = MA.ACCOUNT_CODE
                AND DS.SOB_ID                   = MA.SOB_ID
                AND DS.LOAN_NUM                 = LM.LOAN_NUM
                AND DS.SOB_ID                   = LM.SOB_ID
                AND LM.LOAN_USE                 = LU.LOAN_USE_CODE
                AND LM.SOB_ID                   = LU.SOB_ID
                AND DS.TR_TYPE                  = 'SLIP'
                AND DS.SOB_ID                   = W_SOB_ID
                AND DS.GL_DATE                  = W_GL_DATE
                AND MA.TR_CLASS                 IN('140', '210')
              ORDER BY LM.LOAN_USE  
             ) SX1
      WHERE TCV.TR_CATEGORY             = TC.TR_CATEGORY
        AND TCV.SOB_ID                  = TC.SOB_ID
        AND TC.TR_CLASS                 = SX1.TR_CLASS_CODE
        AND TC.SOB_ID                   = SX1.SOB_ID
      GROUP BY ROLLUP (( TCV.TR_CATEGORY_NAME
           , TC.TR_CLASS     
           , TC.TR_CLASS_NAME)
           , (SX1.TR_MANAGE_NAME
           , SX1.LOAN_USE_NAME
           , SX1.CURRENCY_CODE
           , SX1.DESCRIPTION))
      ;*/

  END TR_DAILY_SUM_2_SELECT;

-- 현금 예금현황.  
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
               WHEN MA.TR_MANAGE_GROUP_CODE = '1110' THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10227', NULL)
               ELSE FB.BANK_NAME
             END AS BANK_NAME
           , DECODE(BA.BANK_ACCOUNT_NUM, NULL, NULL, BA.BANK_ACCOUNT_NUM || '(' || FI_COMMON_G.CODE_NAME_F('ACCOUNT_TYPE', BA.ACCOUNT_TYPE, BA.SOB_ID) || ')') AS BANK_ACCOUNT_NUM
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
           , MA.TR_MANAGE_GROUP_CODE
           , FB.BANK_NAME
           , DECODE(BA.BANK_ACCOUNT_NUM, NULL, NULL, BA.BANK_ACCOUNT_NUM || '(' || FI_COMMON_G.CODE_NAME_F('ACCOUNT_TYPE', BA.ACCOUNT_TYPE, BA.SOB_ID) || ')')
           , DS.CURRENCY_CODE))
        ORDER BY MA.TR_MANAGE_CODE     
      ;
      
  END TR_DAILY_110_SELECT;  

-- 정기 예/적금 현황.
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
           , SUM(NVL(DM.DEPOSIT_AMOUNT, 0)) AS DEPOSIT_AMOUNT
           , TO_CHAR(NVL(DM.INTER_RATE, 0), 'FM999.00') AS INTER_RATE
           , DS.CURRENCY_CODE
           , SUM(DS.BEGIN_AMOUNT) AS BEGIN_AMOUNT
           , SUM(DS.DR_AMOUNT) AS DR_AMOUNT
           , SUM(DS.CR_AMOUNT) AS CR_AMOUNT
           , SUM(DS.REMAIN_AMOUNT) AS REMAIN_AMOUNT
           , SUM(DS.BEGIN_CURR_AMOUNT) AS BEGIN_CURR_AMOUNT
           , SUM(DS.DR_CURR_AMOUNT) AS DR_CURR_AMOUNT
           , SUM(DS.CR_CURR_AMOUNT) AS CR_CURR_AMOUNT
           , SUM(DS.REMAIN_CURR_AMOUNT) AS REMAIN_CURR_AMOUNT
           , TO_CHAR(DM.DUE_DATE, 'YYYY-MM-DD') AS DUE_DATE
           , SUM(NVL(DM.MONTH_AMOUNT, 0)) AS PAYMENT_AMOUNT
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
           , DS.CURRENCY_CODE
           , DM.DUE_DATE
           , DM.MONTH_AMOUNT))
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
           , SUM(NVL(SX3.DUE_0, 0)) AS DUE_0
           , SUM(NVL(SX3.DUE_1, 0)) AS DUE_1
           , SUM(NVL(SX3.DUE_2, 0)) AS DUE_2
           , SUM(NVL(SX3.DUE_3, 0)) AS DUE_3
        FROM FI_TR_DAILY_SUM DS
          , FI_TR_MANAGE_ACCOUNTE_V MA
          , FI_BANK FB
          , ( SELECT SX2.BANK_CODE
                   , SX2.SOB_ID
                   , SUM(CASE TRUNC(MONTHS_BETWEEN(SX2.DUE_DATE, SX2.GL_DATE))
                           WHEN 0 THEN SX2.REMAIN_AMOUNT
                           ELSE 0
                         END) AS DUE_0
                    , SUM(CASE TRUNC(MONTHS_BETWEEN(SX2.DUE_DATE, SX2.GL_DATE))
                           WHEN 1 THEN SX2.REMAIN_AMOUNT
                           ELSE 0
                         END) AS DUE_1  
                    , SUM(CASE TRUNC(MONTHS_BETWEEN(SX2.DUE_DATE, SX2.GL_DATE))
                           WHEN 2 THEN SX2.REMAIN_AMOUNT
                           ELSE 0
                         END) AS DUE_2
                    , SUM(CASE 
                           WHEN 2 < TRUNC(MONTHS_BETWEEN(SX2.DUE_DATE, SX2.GL_DATE)) THEN SX2.REMAIN_AMOUNT
                           ELSE 0
                         END) AS DUE_3
                FROM ( SELECT FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'BANK_SITE', SL.SOB_ID) AS BANK_CODE
                           , SL.SOB_ID
                           , SX1.BILL_NO
                           , MIN(SL.GL_DATE) AS GL_DATE
                           , MAX(TO_DATE(FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'DUE_DATE', SL.SOB_ID), 'YYYY-MM-DD')) AS DUE_DATE
                           , SUM((DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) * DECODE(AC.ACCOUNT_DR_CR, '1', 1, -1))
                             + (DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) * DECODE(AC.ACCOUNT_DR_CR, '2', 1, -1))) AS REMAIN_AMOUNT
                        FROM FI_SLIP_LINE SL
                          , FI_ACCOUNT_CONTROL AC
                          , ( SELECT SMI.SLIP_LINE_ID
                                   , SMI.MANAGEMENT_VALUE AS BILL_NO
                                FROM FI_SLIP_MANAGEMENT_ITEM SMI
                                  , FI_MANAGEMENT_CODE_V MC
                              WHERE SMI.MANAGEMENT_ID     = MC.MANAGEMENT_ID
                                AND MC.LOOKUP_TYPE        = 'BILL_NO'
                                AND SMI.MANAGEMENT_VALUE  IS NOT NULL
                            ) SX1
                          , FI_TR_MANAGE_ACCOUNTE_V MA
                      WHERE SL.ACCOUNT_CONTROL_ID     = AC.ACCOUNT_CONTROL_ID
                        AND SL.SLIP_LINE_ID           = SX1.SLIP_LINE_ID
                        AND SL.ACCOUNT_CODE           = MA.ACCOUNT_CODE
                        AND SL.SOB_ID                 = MA.SOB_ID
                        AND SL.SOB_ID                 = W_SOB_ID
                        AND SL.GL_DATE                <= W_GL_DATE
                        AND MA.TR_MANAGE_CODE         = 1601
                      GROUP BY FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'BANK_SITE', SL.SOB_ID)
                           , SL.SOB_ID
                           , SX1.BILL_NO
                     ) SX2
              WHERE SX2.REMAIN_AMOUNT <> 0 
              GROUP BY SX2.BANK_CODE
                   , SX2.SOB_ID
            ) SX3
      WHERE DS.ACCOUNT_CODE           = MA.ACCOUNT_CODE
        AND DS.SOB_ID                 = MA.SOB_ID
        AND DS.BANK_CODE              = FB.BANK_CODE(+)
        AND DS.SOB_ID                 = FB.SOB_ID(+)
        AND FB.BANK_CODE              = SX3.BANK_CODE(+)
        AND FB.SOB_ID                 = SX3.SOB_ID(+)
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
           , SUM(NVL(LM.LIMIT_AMOUNT, 0) - NVL(DS.REMAIN_AMOUNT/*LM.LOAN_AMOUNT*/, 0)) AS LIMIT_REMAIN_AMOUNT
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
    V_BASE_CURRENCY             VARCHAR2(20);
    
  BEGIN
    V_BASE_CURRENCY := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(W_SOB_ID);
    OPEN P_CURSOR1 FOR
      SELECT FB.BANK_CODE
           , DECODE(GROUPING(FB.BANK_CODE), 1, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL), FB.BANK_NAME) AS BANK_NAME
           , BA.BANK_ACCOUNT_NUM
           , LU.LOAN_USE_NAME
           , NVL(SX1.CURRENCY_CODE, LM.CURRENCY_CODE) AS CURRENCY_CODE
           , SUM(DECODE(LM.CURRENCY_CODE, V_BASE_CURRENCY, LM.LOAN_AMOUNT, LM.LOAN_CURR_AMOUNT)) AS LOAN_AMOUNT
           , SUM(SX1.BEGIN_AMOUNT) AS BEGIN_AMOUNT
           , SUM(SX1.DR_AMOUNT) AS DR_AMOUNT
           , SUM(SX1.CR_AMOUNT) AS CR_AMOUNT
           , SUM(SX1.REMAIN_AMOUNT) AS REMAIN_AMOUNT
           , SUM(LM.LOAN_CURR_AMOUNT) AS LOAN_CURR_AMOUNT
           , SUM(SX1.BEGIN_CURR_AMOUNT) AS BEGIN_CURR_AMOUNT
           , SUM(SX1.DR_CURR_AMOUNT) AS DR_CURR_AMOUNT
           , SUM(SX1.CR_CURR_AMOUNT) AS CR_CURR_AMOUNT
           , SUM(SX1.REMAIN_CURR_AMOUNT) AS REMAIN_CURR_AMOUNT
           , TO_CHAR(LM.ISSUE_DATE, 'YYYY-MM-DD') AS ISSUE_DATE
           , TO_CHAR(LM.DUE_DATE, 'YYYY-MM-DD') AS DUE_DATE
           , TO_CHAR(NVL(LM.INTER_RATE, 0), 'FM999.00') AS INTER_RATE
        FROM FI_LOAN_MASTER LM
          , FI_LOAN_USE_V LU
          , FI_BANK FB
          , FI_BANK_ACCOUNT BA
          , ( -- 당일 발생.
              SELECT DS.LOAN_USE
                   , DS.LOAN_NUM
                   , DS.SOB_ID
                   , DS.CURRENCY_CODE
                   , DS.BEGIN_AMOUNT
                   , DS.CR_AMOUNT AS DR_AMOUNT
                   , DS.DR_AMOUNT AS CR_AMOUNT
                   , DS.REMAIN_AMOUNT AS REMAIN_AMOUNT
                   , DS.BEGIN_CURR_AMOUNT
                   , DS.CR_CURR_AMOUNT AS DR_CURR_AMOUNT
                   , DS.DR_CURR_AMOUNT AS CR_CURR_AMOUNT
                   , DS.REMAIN_CURR_AMOUNT AS REMAIN_CURR_AMOUNT
                FROM FI_TR_DAILY_SUM DS
                  , FI_TR_MANAGE_ACCOUNTE_V MA
              WHERE DS.ACCOUNT_CODE             = MA.ACCOUNT_CODE
                AND DS.SOB_ID                   = MA.SOB_ID
                AND DS.TR_TYPE                  = 'SLIP'
                AND DS.SOB_ID                   = W_SOB_ID
                AND DS.GL_DATE                  = W_GL_DATE
                AND MA.TR_CLASS                 = '210'
            ) SX1
      WHERE LM.LOAN_USE                 = LU.LOAN_USE_CODE
        AND LM.SOB_ID                   = LU.SOB_ID
        AND LM.LOAN_BANK_ID             = FB.BANK_ID(+)
        AND LM.LOAN_BANK_ACCOUNT_ID     = BA.BANK_ACCOUNT_ID(+)
        AND LM.LOAN_NUM                 = SX1.LOAN_NUM(+)
        AND LM.SOB_ID                   = SX1.SOB_ID(+)
        AND LM.SOB_ID                   = W_SOB_ID
        AND LU.LOAN_KIND_CODE           = '1'
      GROUP BY ROLLUP ((FB.BANK_CODE
           , FB.BANK_NAME
           , NVL(SX1.CURRENCY_CODE, LM.CURRENCY_CODE)
           , BA.BANK_ACCOUNT_NUM
           , LU.LOAN_USE_NAME
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
           , NVL(SX1.CURRENCY_CODE, LM.L_CURRENCY_CODE) AS CURRENCY_CODE
           , SUM(LM.LIMIT_AMOUNT) AS LIMIT_AMOUNT
           , SUM(NVL(LM.LIMIT_AMOUNT, 0) - NVL(SX1.REMAIN_AMOUNT, 0)) AS LIMIT_REMAIN_AMOUNT
           , SUM(SX1.BEGIN_AMOUNT) AS BEGIN_AMOUNT
           , SUM(SX1.DR_AMOUNT) AS DR_AMOUNT
           , SUM(SX1.CR_AMOUNT) AS CR_AMOUNT
           , SUM(SX1.REMAIN_AMOUNT) AS REMAIN_AMOUNT
           , SUM(LM.LIMIT_CURR_AMOUNT) AS LIMIT_CURR_AMOUNT
           , SUM(NVL(LM.LIMIT_CURR_AMOUNT, 0) - NVL(SX1.REMAIN_CURR_AMOUNT, 0)) AS LIMIT_REMAIN_CURR_AMOUNT
           , SUM(SX1.BEGIN_CURR_AMOUNT) AS BEGIN_CURR_AMOUNT
           , SUM(SX1.DR_CURR_AMOUNT) AS DR_CURR_AMOUNT
           , SUM(SX1.CR_CURR_AMOUNT) AS CR_CURR_AMOUNT
           , SUM(SX1.REMAIN_CURR_AMOUNT) AS REMAIN_CURR_AMOUNT
           , TO_CHAR(LM.L_ISSUE_DATE, 'YYYY-MM-DD') AS ISSUE_DATE
           , TO_CHAR(LM.L_DUE_DATE, 'YYYY-MM-DD') AS DUE_DATE
           , TO_CHAR(NVL(LM.INTER_RATE, 0), 'FM999.00') AS INTER_RATE
        FROM FI_LOAN_MASTER LM
          , FI_LOAN_USE_V LU
          , FI_BANK FB
          , FI_BANK_ACCOUNT BA
          , ( -- 당일 발생.
              SELECT DS.LOAN_USE
                   , DS.LOAN_NUM
                   , DS.SOB_ID
                   , DS.CURRENCY_CODE
                   , DS.BEGIN_AMOUNT
                   , DS.CR_AMOUNT AS DR_AMOUNT
                   , DS.DR_AMOUNT AS CR_AMOUNT
                   , DS.REMAIN_AMOUNT AS REMAIN_AMOUNT
                   , DS.BEGIN_CURR_AMOUNT
                   , DS.CR_CURR_AMOUNT AS DR_CURR_AMOUNT
                   , DS.DR_CURR_AMOUNT AS CR_CURR_AMOUNT
                   , DS.REMAIN_CURR_AMOUNT AS REMAIN_CURR_AMOUNT
                FROM FI_TR_DAILY_SUM DS
                  , FI_TR_MANAGE_ACCOUNTE_V MA
                  , FI_LOAN_USE_V FU
              WHERE DS.ACCOUNT_CODE             = MA.ACCOUNT_CODE
                AND DS.SOB_ID                   = MA.SOB_ID
                AND DS.LOAN_USE                 = FU.LOAN_USE_CODE
                AND DS.SOB_ID                   = FU.SOB_ID
                AND DS.TR_TYPE                  = 'SLIP'
                AND DS.SOB_ID                   = W_SOB_ID
                AND DS.GL_DATE                  = W_GL_DATE
                AND MA.TR_CLASS                 = '210'
            ) SX1
      WHERE LM.LOAN_USE                 = LU.LOAN_USE_CODE
        AND LM.SOB_ID                   = LU.SOB_ID
        AND LM.LOAN_BANK_ID             = FB.BANK_ID(+)
        AND LM.LOAN_BANK_ACCOUNT_ID     = BA.BANK_ACCOUNT_ID(+)
        AND LM.LOAN_NUM                 = SX1.LOAN_NUM(+)
        AND LM.SOB_ID                   = SX1.SOB_ID(+)
        AND LU.LOAN_KIND_CODE           = '2'
      GROUP BY ROLLUP ((FB.BANK_CODE
           , FB.BANK_NAME
           , NVL(SX1.CURRENCY_CODE, LM.L_CURRENCY_CODE)
           , LU.LOAN_USE_NAME
           , LM.L_ISSUE_DATE
           , LM.L_DUE_DATE
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
           , NVL(SX1.CURRENCY_CODE, LM.L_CURRENCY_CODE) AS CURRENCY_CODE
           , SUM(LM.LIMIT_AMOUNT) AS LIMIT_AMOUNT
           , SUM(NVL(LM.LIMIT_AMOUNT, 0) - NVL(SX1.REMAIN_AMOUNT, 0)) AS LIMIT_REMAIN_AMOUNT
           , SUM(SX1.BEGIN_AMOUNT) AS BEGIN_AMOUNT
           , SUM(SX1.DR_AMOUNT) AS DR_AMOUNT
           , SUM(SX1.CR_AMOUNT) AS CR_AMOUNT
           , SUM(SX1.REMAIN_AMOUNT) AS REMAIN_AMOUNT
           , SUM(LM.LIMIT_CURR_AMOUNT) AS LIMIT_CURR_AMOUNT
           , SUM(NVL(LM.LIMIT_CURR_AMOUNT, 0) - NVL(SX1.REMAIN_CURR_AMOUNT, 0)) AS LIMIT_REMAIN_CURR_AMOUNT
           , SUM(SX1.BEGIN_CURR_AMOUNT) AS BEGIN_CURR_AMOUNT
           , SUM(SX1.DR_CURR_AMOUNT) AS DR_CURR_AMOUNT
           , SUM(SX1.CR_CURR_AMOUNT) AS CR_CURR_AMOUNT
           , SUM(SX1.REMAIN_CURR_AMOUNT) AS REMAIN_CURR_AMOUNT
           , TO_CHAR(LM.L_ISSUE_DATE, 'YYYY-MM-DD') AS ISSUE_DATE
           , TO_CHAR(LM.L_DUE_DATE, 'YYYY-MM-DD') AS DUE_DATE
           , TO_CHAR(NVL(LM.INTER_RATE, 0), 'FM999.00') AS INTER_RATE
        FROM FI_LOAN_MASTER LM
          , FI_LOAN_USE_V LU
          , FI_BANK FB
          , FI_BANK_ACCOUNT BA
          , ( -- 당일 발생.
              SELECT DS.LOAN_USE
                   , DS.LOAN_NUM
                   , DS.SOB_ID
                   , DS.CURRENCY_CODE
                   , DS.BEGIN_AMOUNT
                   , DS.CR_AMOUNT AS DR_AMOUNT
                   , DS.DR_AMOUNT AS CR_AMOUNT
                   , DS.REMAIN_AMOUNT AS REMAIN_AMOUNT
                   , DS.BEGIN_CURR_AMOUNT
                   , DS.CR_CURR_AMOUNT AS DR_CURR_AMOUNT
                   , DS.DR_CURR_AMOUNT AS CR_CURR_AMOUNT
                   , DS.REMAIN_CURR_AMOUNT AS REMAIN_CURR_AMOUNT
                FROM FI_TR_DAILY_SUM DS
                  , FI_TR_MANAGE_ACCOUNTE_V MA
              WHERE DS.ACCOUNT_CODE             = MA.ACCOUNT_CODE
                AND DS.SOB_ID                   = MA.SOB_ID
                AND DS.TR_TYPE                  = 'SLIP'
                AND DS.SOB_ID                   = W_SOB_ID
                AND DS.GL_DATE                  = W_GL_DATE
                AND MA.TR_CLASS                 = '210'
            ) SX1
      WHERE LM.LOAN_USE                 = LU.LOAN_USE_CODE
        AND LM.SOB_ID                   = LU.SOB_ID
        AND LM.LOAN_BANK_ID             = FB.BANK_ID(+)
        AND LM.LOAN_BANK_ACCOUNT_ID     = BA.BANK_ACCOUNT_ID(+)
        AND LM.LOAN_NUM                 = SX1.LOAN_NUM(+)
        AND LM.SOB_ID                   = SX1.SOB_ID(+)
        AND LU.LOAN_KIND_CODE           = '3'
      GROUP BY ROLLUP ((FB.BANK_CODE
           , FB.BANK_NAME
           , NVL(SX1.CURRENCY_CODE, LM.L_CURRENCY_CODE)
           , LU.LOAN_USE_NAME
           , LM.L_ISSUE_DATE
           , LM.L_DUE_DATE
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
    V_BASE_CURRENCY             VARCHAR2(20);
    
  BEGIN
    V_BASE_CURRENCY := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(W_SOB_ID);
    OPEN P_CURSOR1 FOR
      SELECT FB.BANK_CODE
           , DECODE(GROUPING(FB.BANK_CODE), 1, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL), FB.BANK_NAME) AS BANK_NAME
           , BA.BANK_ACCOUNT_NUM
           , LU.LOAN_USE_NAME
           , NVL(SX1.CURRENCY_CODE, LM.CURRENCY_CODE) AS CURRENCY_CODE
           , SUM(DECODE(LM.CURRENCY_CODE, V_BASE_CURRENCY, LM.LOAN_AMOUNT, LM.LOAN_CURR_AMOUNT)) AS LOAN_AMOUNT
           , SUM(SX1.BEGIN_AMOUNT) AS BEGIN_AMOUNT
           , SUM(SX1.DR_AMOUNT) AS DR_AMOUNT
           , SUM(SX1.CR_AMOUNT) AS CR_AMOUNT
           , SUM(SX1.REMAIN_AMOUNT) AS REMAIN_AMOUNT
           , SUM(LM.LOAN_CURR_AMOUNT) AS LOAN_CURR_AMOUNT
           , SUM(SX1.BEGIN_CURR_AMOUNT) AS BEGIN_CURR_AMOUNT
           , SUM(SX1.DR_CURR_AMOUNT) AS DR_CURR_AMOUNT
           , SUM(SX1.CR_CURR_AMOUNT) AS CR_CURR_AMOUNT
           , SUM(SX1.REMAIN_CURR_AMOUNT) AS REMAIN_CURR_AMOUNT
           , TO_CHAR(LM.ISSUE_DATE, 'YYYY-MM-DD') AS ISSUE_DATE
           , TO_CHAR(LM.DUE_DATE, 'YYYY-MM-DD') AS DUE_DATE
           , TO_CHAR(NVL(LM.INTER_RATE, 0), 'FM999.00') AS INTER_RATE
        FROM FI_LOAN_MASTER LM
          , FI_LOAN_USE_V LU
          , FI_BANK FB
          , FI_BANK_ACCOUNT BA
          , ( -- 당일 발생.
              SELECT DS.LOAN_USE
                   , DS.LOAN_NUM
                   , DS.SOB_ID
                   , DS.CURRENCY_CODE
                   , DS.BEGIN_AMOUNT
                   , DS.CR_AMOUNT AS DR_AMOUNT
                   , DS.DR_AMOUNT AS CR_AMOUNT
                   , DS.REMAIN_AMOUNT AS REMAIN_AMOUNT
                   , DS.BEGIN_CURR_AMOUNT
                   , DS.CR_CURR_AMOUNT AS DR_CURR_AMOUNT
                   , DS.DR_CURR_AMOUNT AS CR_CURR_AMOUNT
                   , DS.REMAIN_CURR_AMOUNT AS REMAIN_CURR_AMOUNT
                FROM FI_TR_DAILY_SUM DS
                  , FI_TR_MANAGE_ACCOUNTE_V MA
              WHERE DS.ACCOUNT_CODE             = MA.ACCOUNT_CODE
                AND DS.SOB_ID                   = MA.SOB_ID
                AND DS.TR_TYPE                  = 'SLIP'
                AND DS.SOB_ID                   = W_SOB_ID
                AND DS.GL_DATE                  = W_GL_DATE
                AND MA.TR_CLASS                 = '210'
            ) SX1
      WHERE LM.LOAN_USE                 = LU.LOAN_USE_CODE
        AND LM.SOB_ID                   = LU.SOB_ID
        AND LM.LOAN_BANK_ID             = FB.BANK_ID(+)
        AND LM.LOAN_BANK_ACCOUNT_ID     = BA.BANK_ACCOUNT_ID(+)
        AND LM.LOAN_NUM                 = SX1.LOAN_NUM(+)
        AND LM.SOB_ID                   = SX1.SOB_ID(+)
        AND LM.SOB_ID                   = W_SOB_ID
        AND LU.LOAN_KIND_CODE           = '4'
      GROUP BY ROLLUP ((FB.BANK_CODE
           , FB.BANK_NAME
           , NVL(SX1.CURRENCY_CODE, LM.CURRENCY_CODE)
           , BA.BANK_ACCOUNT_NUM
           , LU.LOAN_USE_NAME
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
                    WHEN SL.ACCOUNT_DR_CR = '1' AND GROUPING(SL.REMARK) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10214', NULL)
                    WHEN SL.ACCOUNT_DR_CR = '1' THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10212', NULL)
                    WHEN SL.ACCOUNT_DR_CR = '2' AND GROUPING(SL.REMARK) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10215', NULL)
                    WHEN SL.ACCOUNT_DR_CR = '2' THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10213', NULL)
                  END ACCOUNT_DR_CR_NAME
                , SL.REMARK
                , FI_COMMON_G.SUPP_CUST_CODE_NAME_F(FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'CUSTOMER', SL.SOB_ID), SL.SOB_ID) AS CUSTOMER_NAME 
                , FI_BANK_G.CODE_NAME_F(FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'BANK_SITE', SL.SOB_ID), SL.SOB_ID) AS BANK_NAME
                , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1110', SL.GL_AMOUNT, 0)) AS CASH_AMOUNT  -- 현금.
                , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1120', SL.GL_AMOUNT, 0)) AS ORDINARY_AMOUNT  -- 보통예금.
                , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1130', SL.GL_AMOUNT, 0)) AS ORDINARY_CURR_AMOUNT  -- 외화보통예금.
                , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1140', SL.GL_AMOUNT, 0)) AS DEPOSIT_AMOUNT       -- 정기적금
                , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1150', SL.GL_AMOUNT, 0)) AS BILL_AMOUNT          -- 어음.*/
              FROM FI_SLIP_LINE SL
                , FI_TR_MANAGE_ACCOUNTE_V MA
            WHERE SL.ACCOUNT_CODE             = MA.ACCOUNT_CODE
              AND SL.SOB_ID                   = MA.SOB_ID
              AND SL.GL_DATE                  = W_GL_DATE
              AND SL.SOB_ID                   = W_SOB_ID
              AND NOT EXISTS (SELECT 'X'
                                FROM FI_SLIP_MANAGEMENT_ITEM SM
                                  , FI_MANAGEMENT_CODE_V MC
                              WHERE SM.MANAGEMENT_ID      = MC.MANAGEMENT_ID
                                AND SM.SLIP_LINE_ID       = SL.SLIP_LINE_ID
                                AND SM.SOB_ID             = SL.SOB_ID
                                AND MC.LOOKUP_TYPE        = 'FUND_MOVE'
                                AND SM.MANAGEMENT_VALUE   IS NOT NULL
                             )
            GROUP BY ROLLUP((SL.ACCOUNT_DR_CR)
                 , (FI_BANK_G.CODE_NAME_F(FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'BANK_SITE', SL.SOB_ID), SL.SOB_ID)
                 , FI_COMMON_G.SUPP_CUST_CODE_NAME_F(FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'CUSTOMER', SL.SOB_ID), SL.SOB_ID) 
                 , SL.REMARK))
            ORDER BY SL.ACCOUNT_DR_CR

/*SELECT DECODE(GROUPING(SL.ACCOUNT_DR_CR), 1, 'Y', 'N') AS GROUPING_YN
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
            ORDER BY SL.ACCOUNT_DR_CR*/
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
                    WHEN SL.ACCOUNT_DR_CR = '1' AND GROUPING(SL.REMARK) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10214', NULL)
                    WHEN SL.ACCOUNT_DR_CR = '1' THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10212', NULL)
                    WHEN SL.ACCOUNT_DR_CR = '2' AND GROUPING(SL.REMARK) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10215', NULL)
                    WHEN SL.ACCOUNT_DR_CR = '2' THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10213', NULL)
                  END ACCOUNT_DR_CR_NAME
                , SL.REMARK
                , FI_COMMON_G.SUPP_CUST_CODE_NAME_F(FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'CUSTOMER', SL.SOB_ID), SL.SOB_ID) AS CUSTOMER_NAME 
                , FI_BANK_G.CODE_NAME_F(FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'BANK_SITE', SL.SOB_ID), SL.SOB_ID) AS BANK_NAME
                , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1110', SL.GL_AMOUNT, 0)) AS CASH_AMOUNT  -- 현금.
                , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1120', SL.GL_AMOUNT, 0)) AS ORDINARY_AMOUNT  -- 보통예금.
                , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1130', SL.GL_AMOUNT, 0)) AS ORDINARY_CURR_AMOUNT  -- 외화보통예금.
                , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1140', SL.GL_AMOUNT, 0)) AS DEPOSIT_AMOUNT       -- 정기적금
                , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1150', SL.GL_AMOUNT, 0)) AS BILL_AMOUNT          -- 어음.*/
              FROM FI_SLIP_LINE SL
                , FI_TR_MANAGE_ACCOUNTE_V MA
            WHERE SL.ACCOUNT_CODE             = MA.ACCOUNT_CODE
              AND SL.SOB_ID                   = MA.SOB_ID
              AND SL.GL_DATE                  = W_GL_DATE
              AND SL.SOB_ID                   = W_SOB_ID
              AND EXISTS (SELECT 'X'
                            FROM FI_SLIP_MANAGEMENT_ITEM SM
                              , FI_MANAGEMENT_CODE_V MC
                          WHERE SM.MANAGEMENT_ID      = MC.MANAGEMENT_ID
                            AND SM.SLIP_LINE_ID       = SL.SLIP_LINE_ID
                            AND SM.SOB_ID             = SL.SOB_ID
                            AND MC.LOOKUP_TYPE        = 'FUND_MOVE'
                            AND SM.MANAGEMENT_VALUE   IS NOT NULL
                         )
            GROUP BY ROLLUP((SL.ACCOUNT_DR_CR)
                 , (FI_BANK_G.CODE_NAME_F(FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'BANK_SITE', SL.SOB_ID), SL.SOB_ID)
                 , FI_COMMON_G.SUPP_CUST_CODE_NAME_F(FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'CUSTOMER', SL.SOB_ID), SL.SOB_ID) 
                 , SL.REMARK))
            ORDER BY SL.ACCOUNT_DR_CR
            
            /*SELECT DECODE(GROUPING(SL.ACCOUNT_DR_CR), 1, 'Y', 'N') AS GROUPING_YN
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
            ORDER BY SL.ACCOUNT_DR_CR*/
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
           , CASE
               WHEN GROUPING(FTC.TR_CATEGORY_NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10222', NULL)
               WHEN GROUPING(SX1.CURRENCY_CODE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL)
               ELSE SX1.TR_MANAGE_NAME
             END AS TR_MANAGE_NAME
           , CASE
               WHEN SX1.BANK_NAME IS NULL THEN DECODE(SX1.TR_CLASS, '110', EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10227', NULL), NULL)
               ELSE SX1.BANK_NAME
             END AS BANK_NAME
           , SX1.CURRENCY_CODE
           , SUM(SX1.BEGIN_AMOUNT) AS BEGIN_AMOUNT
           , SUM(SX1.DR_AMOUNT) AS DR_AMOUNT
           , SUM(SX1.CR_AMOUNT) AS CR_AMOUNT
           , SUM(SX1.REMAIN_AMOUNT) AS REMAIN_AMOUNT
           , SUM(SX1.DR_CURR_AMOUNT) AS DR_CURR_AMOUNT
           , SUM(SX1.CR_CURR_AMOUNT) AS CR_CURR_AMOUNT
           , SUM(SX1.REMAIN_CURR_AMOUNT) AS REMAIN_CURR_AMOUNT
           , SX1.DESCRIPTION
        FROM FI_TR_CLASS_V TC
           , FI_TR_CATEGORY_V FTC
           , (-- 현금/보통에금/외화예금. 
              SELECT DS.TR_CLASS
                   , MA.TR_MANAGE_NAME
                   , DS.SOB_ID
                   , FB.BANK_NAME
                   , DS.CURRENCY_CODE
                   , DS.REMAIN_AMOUNT AS BEGIN_AMOUNT
                   , 0 AS DR_AMOUNT
                   , 0 AS CR_AMOUNT
                   , DS.REMAIN_AMOUNT AS REMAIN_AMOUNT
                   , 0 AS DR_CURR_AMOUNT
                   , 0 AS CR_CURR_AMOUNT
                   , DS.REMAIN_CURR_AMOUNT
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
                AND DS.TR_CLASS                 = '110'
                /*AND DS.TR_CATEGORY             = '10'*/
              UNION ALL
              ---------
              SELECT DS.TR_CLASS
                   , MA.TR_MANAGE_NAME
                   , DS.SOB_ID
                   , FB.BANK_NAME
                   , DS.CURRENCY_CODE
                   , 0 AS BEGIN_AMOUNT
                   , DS.DR_AMOUNT AS DR_AMOUNT
                   , DS.CR_AMOUNT AS CR_AMOUNT
                   , DS.DR_AMOUNT - DS.CR_AMOUNT AS REMAIN_AMOUNT
                   , DS.DR_CURR_AMOUNT AS DR_CURR_AMOUNT
                   , DS.CR_CURR_AMOUNT AS CR_CURR_AMOUNT
                   , DS.DR_CURR_AMOUNT - DS.CR_CURR_AMOUNT AS REMAIN_CURR_AMOUNT
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
                /*AND DS.TR_CATEGORY             = '10'*/
                AND DS.TR_CLASS                 = '110'
              UNION ALL
              --정기예금/정기적금/받을어음.
              SELECT DS.TR_CLASS
                   , FI_COMMON_G.CODE_NAME_F('TR_CLASS', DS.TR_CLASS, DS.SOB_ID) AS TR_MANAGE_NAME
                   , DS.SOB_ID
                   , MA.TR_MANAGE_NAME AS BANK_NAME
                   , DS.CURRENCY_CODE
                   , SUM(DS.REMAIN_AMOUNT) AS BEGIN_AMOUNT
                   , 0 AS DR_AMOUNT
                   , 0 AS CR_AMOUNT
                   , SUM(DS.REMAIN_AMOUNT) AS REMAIN_AMOUNT
                   , 0 AS DR_CURR_AMOUNT
                   , 0 AS CR_CURR_AMOUNT
                   , SUM(DS.REMAIN_CURR_AMOUNT) AS REMAIN_CURR_AMOUNT
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
                AND DS.TR_CLASS                 IN('120', '130')
              GROUP BY DS.TR_CLASS
                   , FI_COMMON_G.CODE_NAME_F('TR_CLASS', DS.TR_CLASS, DS.SOB_ID)
                   , MA.TR_MANAGE_NAME
                   , DS.SOB_ID
                   , DS.CURRENCY_CODE
              UNION ALL
              ---------
              SELECT DS.TR_CLASS
                   , FI_COMMON_G.CODE_NAME_F('TR_CLASS', DS.TR_CLASS, DS.SOB_ID) AS TR_MANAGE_NAME
                   , DS.SOB_ID
                   , MA.TR_MANAGE_NAME AS BANK_NAME
                   , DS.CURRENCY_CODE
                   , 0 AS BEGIN_AMOUNT
                   , SUM(DS.DR_AMOUNT) AS DR_AMOUNT
                   , SUM(DS.CR_AMOUNT) AS CR_AMOUNT
                   , SUM(DS.DR_AMOUNT - DS.CR_AMOUNT) AS REMAIN_AMOUNT
                   , SUM(DS.DR_CURR_AMOUNT) AS DR_CURR_AMOUNT
                   , SUM(DS.CR_CURR_AMOUNT) AS CR_CURR_AMOUNT
                   , SUM(DS.DR_CURR_AMOUNT - DS.CR_CURR_AMOUNT) AS REMAIN_CURR_AMOUNT
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
                /*AND DS.TR_CATEGORY             = '10'*/
                AND DS.TR_CLASS                 IN('120', '130')
              GROUP BY DS.TR_CLASS
                   , FI_COMMON_G.CODE_NAME_F('TR_CLASS', DS.TR_CLASS, DS.SOB_ID)
                   , MA.TR_MANAGE_NAME
                   , DS.SOB_ID
                   , DS.CURRENCY_CODE
              UNION ALL
              --한도대출.
              SELECT '130' AS TR_CLASS 
                    , FI_COMMON_G.CODE_NAME_F('TR_CLASS', '130', LM.SOB_ID) AS TR_MANAGE_NAME
                    , LM.SOB_ID
                    , FI_COMMON_G.CODE_NAME_F('TR_MANAGE_ACCOUNT', '1602', LM.SOB_ID) AS BANK_NAME
                    , LM.CURRENCY_CODE
                    , SUM(NVL(LM.LIMIT_AMOUNT, 0) - NVL(SX3.REMAIN_AMOUNT, 0)) AS BEGIN_AMOUNT
                    , 0 AS DR_AMOUNT
                    , 0 AS CR_AMOUNT
                    , SUM(NVL(LM.LIMIT_AMOUNT, 0) - NVL(SX3.REMAIN_AMOUNT, 0)) AS REMAIN_AMOUNT
                    , 0 AS DR_CURR_AMOUNT
                    , 0 AS CR_CURR_AMOUNT
                    , SUM(NVL(LM.LIMIT_CURR_AMOUNT, 0) - NVL(SX3.REMAIN_CURR_AMOUNT, 0)) AS REMAIN_CURR_AMOUNT
                    , NULL AS DESCRIPTION
                FROM FI_LOAN_MASTER LM
                  , FI_LOAN_USE_V LU
                  , FI_BANK FB     
                  , ( -- 전일 발생.
                      SELECT DS.LOAN_USE
                           , DS.LOAN_NUM
                           , DS.SOB_ID
                           , DS.CURRENCY_CODE
                           , DS.BEGIN_AMOUNT
                           , DS.REMAIN_AMOUNT AS REMAIN_AMOUNT
                           , DS.BEGIN_CURR_AMOUNT
                           , DS.REMAIN_CURR_AMOUNT AS REMAIN_CURR_AMOUNT
                        FROM FI_TR_DAILY_SUM DS
                          , FI_TR_MANAGE_ACCOUNTE_V MA
                          , FI_LOAN_USE_V FU
                      WHERE DS.ACCOUNT_CODE             = MA.ACCOUNT_CODE
                        AND DS.SOB_ID                   = MA.SOB_ID
                        AND DS.LOAN_USE                 = FU.LOAN_USE_CODE
                        AND DS.SOB_ID                   = FU.SOB_ID
                        AND DS.TR_TYPE                  = 'SLIP'
                        AND DS.SOB_ID                   = W_SOB_ID
                        AND DS.GL_DATE                  = W_GL_DATE - 1
                        AND MA.TR_CLASS                 = '210'
                    ) SX3
              WHERE LM.LOAN_USE                 = LU.LOAN_USE_CODE
                AND LM.SOB_ID                   = LU.SOB_ID
                AND LM.LOAN_BANK_ID             = FB.BANK_ID(+)
                AND LM.LOAN_NUM                 = SX3.LOAN_NUM(+)
                AND LM.SOB_ID                   = SX3.SOB_ID(+)
                AND LU.LOAN_KIND_CODE           = '2'
              GROUP BY LM.SOB_ID
                    , LM.CURRENCY_CODE
             UNION ALL
              ---------
             SELECT '130' AS TR_CLASS
                   , FI_COMMON_G.CODE_NAME_F('TR_CLASS', '130', DS.SOB_ID) AS TR_MANAGE_NAME
                   , DS.SOB_ID
                   , FI_COMMON_G.CODE_NAME_F('TR_MANAGE_ACCOUNT', '1602', DS.SOB_ID) AS BANK_NAME
                   , DS.CURRENCY_CODE
                   , 0 AS BEGIN_AMOUNT
                   , SUM(DS.DR_AMOUNT) AS DR_AMOUNT  -- 금일상환.
                   , SUM(DS.CR_AMOUNT) AS CR_AMOUNT  -- 금일차입.
                   , SUM(NVL(DS.CR_AMOUNT, 0) - NVL(DS.DR_AMOUNT, 0)) * -1 AS REMAIN_AMOUNT
                   , SUM(DS.DR_CURR_AMOUNT) AS DR_CURR_AMOUNT  -- 금일상환.
                   , SUM(DS.CR_CURR_AMOUNT) AS CR_CURR_AMOUNT  -- 금일차입.
                   , SUM(NVL(DS.CR_CURR_AMOUNT, 0) - NVL(DS.DR_CURR_AMOUNT, 0)) * -1 AS REMAIN_CURR_AMOUNT
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
                AND LU.LOAN_KIND_CODE           = '2'
             GROUP BY DS.SOB_ID
                   , DS.CURRENCY_CODE              
             ) SX1
      WHERE TC.TR_CATEGORY              = FTC.TR_CATEGORY
        AND TC.SOB_ID                   = FTC.SOB_ID
        AND TC.TR_CLASS                 = SX1.TR_CLASS
        AND TC.SOB_ID                   = SX1.SOB_ID
      GROUP BY ROLLUP (( FTC.TR_CATEGORY_NAME
           , TC.TR_CLASS     
           , TC.TR_CLASS_NAME
           , SX1.TR_MANAGE_NAME)
           , (CASE
               WHEN SX1.BANK_NAME IS NULL THEN DECODE(SX1.TR_CLASS, '110', EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10227', NULL), NULL)
               ELSE SX1.BANK_NAME
             END
           , SX1.CURRENCY_CODE
           , SX1.DESCRIPTION))      
      ;

  END TR_DAILY_PLAN_SUM_SELECT;

-- 자금 계획 인쇄 조회.
  PROCEDURE TR_DAILY_PLAN_PRINT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT SX1.ACCOUNT_DR_CR
           , SX1.ACCOUNT_DR_CR_NAME           
           , CASE
               WHEN SX1.BANK_NAME IS NULL THEN DECODE(SX1.TR_CLASS, '110', EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10233', NULL), NULL)
               ELSE SX1.BANK_NAME
             END AS BANK_NAME          
           , SX1.REMARK
           , SX1.DEPOSIT_AMOUNT       -- 정기적금
           , SX1.BILL_AMOUNT          -- 어음.
        FROM 
          ( SELECT DECODE(GROUPING(DECODE(DS.DR_AMOUNT, 0, '2', '1')), 1, 'Y', 'N') AS GROUPING_YN
                 , 1 AS SORT_SEQ
                 , DECODE(DS.DR_AMOUNT, 0, '2', '1') AS ACCOUNT_DR_CR
                 , CASE
                     WHEN DECODE(DS.DR_AMOUNT, 0, '2', '1') = '1' AND GROUPING(FB.BANK_NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10214', NULL)
                     WHEN DECODE(DS.DR_AMOUNT, 0, '2', '1') = '1' THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10212', NULL)
                     WHEN DECODE(DS.DR_AMOUNT, 0, '2', '1') = '2' AND GROUPING(FB.BANK_NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10215', NULL)
                     WHEN DECODE(DS.DR_AMOUNT, 0, '2', '1') = '2' THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10213', NULL)
                   END ACCOUNT_DR_CR_NAME
                 , FB.BANK_NAME                 
                 , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1110', DECODE(DS.DR_AMOUNT, 0, DS.CR_AMOUNT, DS.DR_AMOUNT), 0) + 
                    DECODE(MA.TR_MANAGE_GROUP_CODE, '1120', DECODE(DS.DR_AMOUNT, 0, DS.CR_AMOUNT, DS.DR_AMOUNT), 0) +
                    DECODE(MA.TR_MANAGE_GROUP_CODE, '1130', DECODE(DS.DR_AMOUNT, 0, DS.CR_AMOUNT, DS.DR_AMOUNT), 0) + 
                    DECODE(MA.TR_MANAGE_GROUP_CODE, '1140', DECODE(DS.DR_AMOUNT, 0, DS.CR_AMOUNT, DS.DR_AMOUNT), 0)) AS DEPOSIT_AMOUNT       -- 현금.보통예금.외화보통예금.정기적금
                 , SUM(DECODE(MA.TR_MANAGE_GROUP_CODE, '1150', DECODE(DS.DR_AMOUNT, 0, DS.CR_AMOUNT, DS.DR_AMOUNT), 0)) AS BILL_AMOUNT          -- 어음.
                 , DS.DESCRIPTION AS REMARK
                 , DS.TR_CLASS
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
              AND MA.TR_MANAGE_GROUP_CODE     IS NOT NULL
              AND DS.FUND_MOVE                IS NULL          -- 자금이체 제외.
            GROUP BY ROLLUP((DECODE(DS.DR_AMOUNT, 0, '2', '1'))
                 , (FB.BANK_NAME     
                 , DS.DESCRIPTION
                 , DS.TR_CLASS))
            -------------------------------------------
            UNION ALL
            -------------------------------------------
            SELECT 'N' AS GROUPING_YN
                 , 2 AS SORT_SEQ
                 , DECODE(DS.DR_AMOUNT, 0, '2', '1') AS ACCOUNT_DR_CR                                    
                 , EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10230', NULL) ACCOUNT_DR_CR_NAME
                 , CASE
                     WHEN DECODE(DS.DR_AMOUNT, 0, '2', '1') = '1' THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10212', NULL)
                     WHEN DECODE(DS.DR_AMOUNT, 0, '2', '1') = '2' THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10213', NULL)
                   END AS BANK_NAME
                 , (DECODE(MA.TR_MANAGE_GROUP_CODE, '1110', DECODE(DS.DR_AMOUNT, 0, DS.CR_AMOUNT, DS.DR_AMOUNT), 0) + 
                    DECODE(MA.TR_MANAGE_GROUP_CODE, '1120', DECODE(DS.DR_AMOUNT, 0, DS.CR_AMOUNT, DS.DR_AMOUNT), 0) +
                    DECODE(MA.TR_MANAGE_GROUP_CODE, '1130', DECODE(DS.DR_AMOUNT, 0, DS.CR_AMOUNT, DS.DR_AMOUNT), 0) + 
                    DECODE(MA.TR_MANAGE_GROUP_CODE, '1140', DECODE(DS.DR_AMOUNT, 0, DS.CR_AMOUNT, DS.DR_AMOUNT), 0)) AS DEPOSIT_AMOUNT       -- 현금.보통예금.외화보통예금.정기적금
                 , (DECODE(MA.TR_MANAGE_GROUP_CODE, '1150', DECODE(DS.DR_AMOUNT, 0, DS.CR_AMOUNT, DS.DR_AMOUNT), 0)) AS BILL_AMOUNT          -- 어음.
                 , DS.DESCRIPTION AS REMARK
                 , DS.TR_CLASS
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
              AND MA.TR_MANAGE_GROUP_CODE     IS NOT NULL
              AND DS.FUND_MOVE                IS NOT NULL          -- 자금이체 제외.
            ORDER BY SORT_SEQ, ACCOUNT_DR_CR
          ) SX1
      WHERE SX1.GROUPING_YN             = 'N'
      ORDER BY SX1.SORT_SEQ
          , SX1.ACCOUNT_DR_CR
          , BANK_NAME
      ;
  END TR_DAILY_PLAN_PRINT;
  
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
           , DS.FUND_MOVE
           , FI_COMMON_G.CODE_NAME_F('FUND_MOVE', DS.FUND_MOVE, DS.SOB_ID) AS FUND_MOVE_NAME     
           , DS.LOAN_USE
           , FI_COMMON_G.CODE_NAME_F('LOAN_USE', DS.LOAN_USE, DS.SOB_ID) AS LOAN_USE_NAME
           , DS.LOAN_NUM
           , LM.LOAN_DESC
           , DS.TR_CATEGORY
           , DS.TR_CLASS 
           , DS.TR_DAILY_SUM_ID    
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
          ( P_TR_DAILY_SUM_ID    OUT FI_TR_DAILY_SUM.TR_DAILY_SUM_ID%TYPE
          , P_SOB_ID             IN FI_TR_DAILY_SUM.SOB_ID%TYPE
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
          , P_FUND_MOVE          IN FI_TR_DAILY_SUM.FUND_MOVE%TYPE
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
    
    SELECT FI_TR_DAILY_SUM_S1.NEXTVAL
      INTO P_TR_DAILY_SUM_ID
      FROM DUAL;
      
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
    , TR_CLASS
    , TR_DAILY_SUM_ID
    , FUND_MOVE
    ) VALUES
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
    , P_TR_CLASS
    , P_TR_DAILY_SUM_ID
    , P_FUND_MOVE
    );
  
  END TR_DAILY_PLAN_INSERT;

  PROCEDURE TR_DAILY_PLAN_UPDATE
            ( W_TR_DAILY_SUM_ID    IN FI_TR_DAILY_SUM.TR_DAILY_SUM_ID%TYPE
            , W_SOB_ID             IN FI_TR_DAILY_SUM.SOB_ID%TYPE
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
            , P_FUND_MOVE          IN FI_TR_DAILY_SUM.FUND_MOVE%TYPE 
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
    
    UPDATE FI_TR_DAILY_SUM DS
      SET DS.GL_DATE            = P_GL_DATE
        , DS.ACCOUNT_CONTROL_ID = P_ACCOUNT_CONTROL_ID
        , DS.ACCOUNT_CODE       = P_ACCOUNT_CODE
        , DS.CURRENCY_CODE      = P_CURRENCY_CODE
        , DR_CURR_AMOUNT        = V_DR_CURR_AMOUNT
        , CR_CURR_AMOUNT        = V_CR_CURR_AMOUNT
        , DR_AMOUNT             = V_DR_AMOUNT
        , CR_AMOUNT             = V_CR_AMOUNT
        , DESCRIPTION           = P_DESCRIPTION
        , BANK_CODE             = P_BANK_CODE
        , LOAN_USE              = P_LOAN_USE
        , LOAN_NUM              = P_LOAN_NUM
        , TR_CATEGORY           = P_TR_CATEGORY
        , TR_CLASS              = P_TR_CLASS
        , FUND_MOVE             = P_FUND_MOVE
    WHERE TR_DAILY_SUM_ID    = W_TR_DAILY_SUM_ID
      AND DS.TR_TYPE         = 'PLAN'
      AND SOB_ID             = W_SOB_ID
    ;

  END TR_DAILY_PLAN_UPDATE;

  PROCEDURE TR_DAILY_PLAN_DELETE
            ( W_TR_DAILY_SUM_ID    IN FI_TR_DAILY_SUM.TR_DAILY_SUM_ID%TYPE
            , W_SOB_ID             IN FI_TR_DAILY_SUM.SOB_ID%TYPE
            )
  AS
  BEGIN
    DELETE FI_TR_DAILY_SUM DS
    WHERE TR_DAILY_SUM_ID    = W_TR_DAILY_SUM_ID
      AND DS.TR_TYPE         = 'PLAN'
      AND SOB_ID             = W_SOB_ID
    ;
  END TR_DAILY_PLAN_DELETE;
  
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
                     , FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'BANK_SITE', SL.SOB_ID) AS BANK_SITE_CODE
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
                     , FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'BANK_SITE', SL.SOB_ID)
                     , FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'BANK_ACCOUNT', SL.SOB_ID)                                          
                     , FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'LOAN_USE', SL.SOB_ID)
                     , FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'LOAN_NUM', SL.SOB_ID)
                     , MA.TR_CATEGORY
                     , MA.TR_CLASS
                ORDER BY SL.ACCOUNT_CODE
               )
    LOOP
      IF C1.BANK_CODE IS NOT NULL THEN
        V_BANK_CODE := C1.BANK_CODE;
      ELSE
        V_BANK_CODE := C1.BANK_SITE_CODE;
      END IF;
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
        AND NVL(DS.LOAN_NUM, '-')           = NVL(C1.LOAN_NUM, '-')
          
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
