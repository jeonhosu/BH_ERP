CREATE OR REPLACE PACKAGE FI_DPR_G
AS
-- 감가상각비현황.
  PROCEDURE DPR_LIST_HEADER
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_FR         IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE
            , W_PERIOD_TO         IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE            
            , W_EXPENSE_TYPE      IN FI_ASSET_MASTER.EXPENSE_TYPE%TYPE
            , W_ASSET_TYPE        IN FI_ASSET_CATEGORY.ASSET_TYPE%TYPE            
            , W_DPR_TYPE          IN VARCHAR2
            , W_SOB_ID            IN FI_ASSET_DPR_HISTORY.SOB_ID%TYPE
            );

-- 감가상각비현황.
  PROCEDURE DPR_LIST_LINE
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_PERIOD_FR         IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE
            , W_PERIOD_TO         IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE            
            , W_ASSET_CATEGORY_ID IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
            , W_DPR_TYPE          IN VARCHAR2
            , W_SOB_ID            IN FI_ASSET_DPR_HISTORY.SOB_ID%TYPE
            );
            
-- 월별 감가상각비 현황.
  PROCEDURE DPR_MONTH
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_PERIOD_FR         IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE
            , W_PERIOD_TO         IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE            
            , W_EXPENSE_TYPE      IN FI_ASSET_MASTER.EXPENSE_TYPE%TYPE
            , W_ASSET_TYPE        IN FI_ASSET_CATEGORY.ASSET_TYPE%TYPE     
            , W_DPR_TYPE          IN VARCHAR2       
            , W_ACCOUNT_CODE_FR   IN VARCHAR2
            , W_ACCOUNT_CODE_TO   IN VARCHAR2
            , W_ASSET_CODE_FR     IN VARCHAR2
            , W_ASSET_CODE_TO     IN VARCHAR2
            , W_SOB_ID            IN FI_ASSET_DPR_HISTORY.SOB_ID%TYPE
            );

-- 고정자산명세서.
  PROCEDURE DPR_STATEMENT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_PERIOD_FR         IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE
            , W_PERIOD_TO         IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE            
            , W_DPR_TYPE          IN VARCHAR2       
            , W_ACCOUNT_CODE_FR   IN VARCHAR2
            , W_ACCOUNT_CODE_TO   IN VARCHAR2
            , W_ASSET_CODE_FR     IN VARCHAR2
            , W_ASSET_CODE_TO     IN VARCHAR2
            , W_SOB_ID            IN FI_ASSET_DPR_HISTORY.SOB_ID%TYPE
            );

-- 감가상각전표생성 조회.
  PROCEDURE DPR_SLIP
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_PERIOD_NAME       IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE
            , W_ASSET_CATEGORY_ID IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
            , W_DPR_TYPE          IN VARCHAR2
            , W_SOB_ID            IN FI_ASSET_DPR_HISTORY.SOB_ID%TYPE
            );

-- 감가상각전표생성 선택한 감가자료 SLIP_YN = 'S' 로 업데이트.
  PROCEDURE UPDATE_DPR_SLIP
            ( W_PERIOD_NAME       IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE
            , W_DPR_TYPE          IN VARCHAR2
            , W_ASSET_ID          IN FI_ASSET_MASTER.ASSET_ID%TYPE
            , P_SOB_ID            IN FI_ASSET_DPR_HISTORY.SOB_ID%TYPE
            , P_CHECK_YN          VARCHAR2
            );

-- 감가상각전표생성 MAIN  : 해당월 감가자료 SLIP_YN = 'S' 인 것만 조회해서 생성.
  PROCEDURE CREATE_DPR_SLIP
            ( W_PERIOD_NAME       IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE
            , W_ASSET_CATEGORY_ID IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
            , W_DPR_TYPE          IN VARCHAR2
            , P_SOB_ID            IN FI_ASSET_DPR_HISTORY.SOB_ID%TYPE
            , P_ORG_ID            IN FI_ASSET_DPR_HISTORY.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_MESSAGE           OUT VARCHAR2
            );

-- 감가상각전표생성  : 해당월 감가자료 SLIP_YN = 'S' 인 것만 조회해서 생성.
  PROCEDURE SET_DPR_SLIP_INSERT
            ( P_PERIOD_NAME       IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE
            , P_ASSET_CATEGORY_ID IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
            , P_DPR_TYPE          IN VARCHAR2
            , P_SOB_ID            IN FI_ASSET_DPR_HISTORY.SOB_ID%TYPE
            , P_ORG_ID            IN FI_ASSET_DPR_HISTORY.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_JOB_CATEGORY_CD   IN VARCHAR2
            , P_DEPT_ID           IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_MESSAGE           OUT VARCHAR2
            );
            
END FI_DPR_G;
/
CREATE OR REPLACE PACKAGE BODY FI_DPR_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_DPR_G
/* Description  : 감가상각비 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 감가상각비현황.
  PROCEDURE DPR_LIST_HEADER
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_FR         IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE
            , W_PERIOD_TO         IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE            
            , W_EXPENSE_TYPE      IN FI_ASSET_MASTER.EXPENSE_TYPE%TYPE
            , W_ASSET_TYPE        IN FI_ASSET_CATEGORY.ASSET_TYPE%TYPE            
            , W_DPR_TYPE          IN VARCHAR2
            , W_SOB_ID            IN FI_ASSET_DPR_HISTORY.SOB_ID%TYPE
            )
  AS
  BEGIN    
    OPEN P_CURSOR FOR
      SELECT AC.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , SUM(PX1.BEGIN_AMOUNT) BEGIN_AMOUNT
           , SUM(PX1.INCREASE_AMOUNT) INCREASE_AMOUNT
           , SUM(PX1.DECREASE_AMOUNT) DECREASE_AMOUNT
           , SUM(NVL(PX1.BEGIN_AMOUNT, 0) + NVL(PX1.INCREASE_AMOUNT, 0) - NVL(PX1.DECREASE_AMOUNT, 0)) AS ENDING_AMOUNT
           , SUM(PX1.BEGIN_DPR_AMOUNT) BEGIN_DPR_AMOUNT
           , SUM(PX1.INCREASE_DPR_AMOUNT) INCREASE_DPR_AMOUNT
           , SUM(PX1.DECREASE_DPR_AMOUNT) DECREASE_DPR_AMOUNT
           , SUM(NVL(PX1.BEGIN_DPR_AMOUNT, 0) + NVL(PX1.INCREASE_DPR_AMOUNT, 0) - NVL(PX1.DECREASE_DPR_AMOUNT, 0)) AS ENDING_DPR_AMOUNT
           , SUM(PX1.NOT_DPR_AMOUNT) NOT_DPR_AMOUNT
           , FAC.ASSET_CATEGORY_ID
        FROM FI_ASSET_CATEGORY FAC
           , FI_ACCOUNT_CONTROL AC
           , (SELECT AM.ASSET_CODE
                   , AM.ASSET_DESC
                   , CASE
                       WHEN TO_CHAR(AM.ACQUIRE_DATE, 'YYYY-MM') < W_PERIOD_FR THEN AM.AMOUNT + NVL(SX1.CE_BEGIN_AMOUNT, 0)
                       ELSE 0
                     END - NVL(SX1_1.CE_BEGIN_AMOUNT, 0) AS BEGIN_AMOUNT   -- 기초가액.
                   , CASE
                       WHEN TO_CHAR(AM.ACQUIRE_DATE, 'YYYY-MM') < W_PERIOD_FR THEN NVL(SX1.CE_INCREASE_AMOUNT, 0)
                       ELSE NVL(AM.AMOUNT, 0) + NVL(SX1.CE_INCREASE_AMOUNT, 0)
                     END AS INCREASE_AMOUNT  -- 당기증가액.                         
                   , NVL(SX1_1.CE_INCREASE_AMOUNT, 0) AS DECREASE_AMOUNT  -- 당기 감소액.
                   , NVL(SX2.BEGIN_DPR_AMOUNT, 0) AS BEGIN_DPR_AMOUNT
                   , NVL(SX3.INCREASE_DPR_AMOUNT, 0) AS INCREASE_DPR_AMOUNT
                   , NVL(SX4.DECREASE_DPR_AMOUNT, 0) AS DECREASE_DPR_AMOUNT
                   , NVL(SX5.NOT_DPR_AMOUNT, 0) AS NOT_DPR_AMOUNT
                   , AM.ASSET_CATEGORY_ID
                   , AM.SOB_ID
                FROM FI_ASSET_MASTER AM
                  , ( -- 자본적 지출 금액.
                    SELECT AH.ASSET_ID
                         , AH.SOB_ID
                         , SUM(CASE 
                                 WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < W_PERIOD_FR THEN AH.AMOUNT
                                 ELSE 0
                               END) AS CE_BEGIN_AMOUNT
                         , SUM(CASE 
                                 WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < W_PERIOD_FR THEN 0
                                 ELSE AH.AMOUNT
                               END) AS CE_INCREASE_AMOUNT
                      FROM FI_ASSET_HISTORY AH
                    WHERE AH.SOB_ID                   = W_SOB_ID
                      AND AH.CHARGE_DATE              <= LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM'))
                      AND EXISTS ( SELECT 'X'
                                     FROM FI_COMMON FC
                                   WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                                     AND FC.SOB_ID      = W_SOB_ID
                                     AND FC.CODE        = '10'
                                     AND FC.COMMON_ID   = AH.CHARGE_ID
                                 )
                    GROUP BY AH.ASSET_ID
                         , AH.SOB_ID
                    ) SX1
                  , ( -- 폐기/매각 금액.
                    SELECT AH.ASSET_ID
                         , AH.SOB_ID
                         , SUM(CASE 
                                 WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < W_PERIOD_FR THEN AH.AMOUNT
                                 ELSE 0
                               END) AS CE_BEGIN_AMOUNT
                         , SUM(CASE 
                                 WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < W_PERIOD_FR THEN 0
                                 ELSE AH.AMOUNT
                               END) AS CE_INCREASE_AMOUNT
                      FROM FI_ASSET_HISTORY AH
                    WHERE AH.SOB_ID                   = W_SOB_ID
                      AND AH.CHARGE_DATE              <= LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM'))
                      AND EXISTS ( SELECT 'X'
                                     FROM FI_COMMON FC
                                   WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                                     AND FC.SOB_ID      = W_SOB_ID
                                     AND FC.CODE        IN('90', '91')
                                     AND FC.COMMON_ID   = AH.CHARGE_ID
                                 )
                    GROUP BY AH.ASSET_ID
                         , AH.SOB_ID
                    ) SX1_1
                  , (-- 전기 충당금 누계액.
                    SELECT ADH.ASSET_ID
                         , ADH.ASSET_CATEGORY_ID
                         , ADH.SOB_ID
                         , MAX(ADH.DPR_SUM_AMOUNT) AS BEGIN_DPR_AMOUNT
                      FROM FI_ASSET_DPR_HISTORY ADH
                    WHERE ADH.PERIOD_NAME             < W_PERIOD_FR  --= TO_CHAR(ADD_MONTHS(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), -1), 'YYYY-MM')
                      AND ADH.DPR_TYPE                = W_DPR_TYPE
                      AND ADH.SOB_ID                  = W_SOB_ID
                    GROUP BY ADH.ASSET_ID
                         , ADH.ASSET_CATEGORY_ID
                         , ADH.SOB_ID  
                    ) SX2
                  , (-- 당기 감가상각비.
                    SELECT ADH.ASSET_ID
                         , ADH.ASSET_CATEGORY_ID
                         , ADH.SOB_ID
                         , SUM(ADH.DPR_AMOUNT) AS INCREASE_DPR_AMOUNT
                      FROM FI_ASSET_DPR_HISTORY ADH
                    WHERE ADH.PERIOD_NAME             BETWEEN W_PERIOD_FR AND W_PERIOD_TO
                      AND ADH.DPR_TYPE                = W_DPR_TYPE
                      AND ADH.SOB_ID                  = W_SOB_ID
                    GROUP BY ADH.ASSET_ID
                         , ADH.ASSET_CATEGORY_ID
                         , ADH.SOB_ID
                    ) SX3
                  , ( -- 당기 상각충당금 감소액.
                    SELECT AH.ASSET_ID
                         , AH.SOB_ID
                         , SUM(TRUNC(DECODE(W_DPR_TYPE, '20', AH.IFRS_DPR_SUM_DC_AMOUNT, AH.DPR_SUM_DC_AMOUNT))) AS DECREASE_DPR_AMOUNT
                      FROM FI_ASSET_HISTORY AH
                    WHERE AH.CHARGE_DATE    BETWEEN TO_DATE(W_PERIOD_FR || '-01', 'YYYY-MM-DD') AND LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM'))
                      AND AH.SOB_ID         = W_SOB_ID
                      AND EXISTS  ( SELECT 'X'
                                      FROM FI_COMMON FC
                                    WHERE FC.COMMON_ID      = AH.CHARGE_ID
                                      AND FC.SOB_ID         = AH.SOB_ID
                                      AND FC.GROUP_CODE     = 'ASSET_CHARGE'
                                      AND FC.CODE           IN ('90', '91')
                                   )
                    GROUP BY AH.ASSET_ID
                         , AH.SOB_ID                         
                    ) SX4   
                  , (--  미상각잔액.
                    SELECT ADH.ASSET_ID
                         , ADH.SOB_ID
                         , ADH.UN_DPR_REMAIN_AMOUNT AS NOT_DPR_AMOUNT
                      FROM FI_ASSET_DPR_HISTORY ADH
                    WHERE ADH.DPR_TYPE                = W_DPR_TYPE
                      AND ADH.SOB_ID                  = W_SOB_ID
                      AND ADH.PERIOD_NAME             IN (SELECT MAX(DH.PERIOD_NAME)
                                                            FROM FI_ASSET_DPR_HISTORY DH
                                                          WHERE DH.PERIOD_NAME       <= W_PERIOD_TO
                                                            AND DH.ASSET_ID          = ADH.ASSET_ID
                                                            AND DH.DPR_TYPE          = ADH.DPR_TYPE 
                                                            AND DH.SOB_ID            = ADH.SOB_ID
                                                          )
                    ) SX5  
              WHERE AM.ASSET_ID                 = SX1.ASSET_ID(+)
                AND AM.SOB_ID                   = SX1.SOB_ID(+)
                AND AM.ASSET_ID                 = SX1_1.ASSET_ID(+)
                AND AM.SOB_ID                   = SX1_1.SOB_ID(+)
                AND AM.ASSET_ID                 = SX2.ASSET_ID(+)
                AND AM.SOB_ID                   = SX2.SOB_ID(+)
                AND AM.ASSET_ID                 = SX3.ASSET_ID(+)
                AND AM.SOB_ID                   = SX3.SOB_ID(+)
                AND AM.ASSET_ID                 = SX4.ASSET_ID(+)
                AND AM.SOB_ID                   = SX4.SOB_ID(+)
                AND AM.ASSET_ID                 = SX5.ASSET_ID(+)
                AND AM.SOB_ID                   = SX5.SOB_ID(+)
                AND AM.SOB_ID                   = W_SOB_ID
                AND AM.EXPENSE_TYPE             = NVL(W_EXPENSE_TYPE, AM.EXPENSE_TYPE)
                AND AM.ACQUIRE_DATE             <= LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM'))
                AND EXISTS ( SELECT 'X'
                               FROM FI_ASSET_DPR_HISTORY ADH
                             WHERE ADH.ASSET_ID     = AM.ASSET_ID
                               AND ADH.SOB_ID       = AM.SOB_ID
                               AND ADH.DPR_TYPE     = W_DPR_TYPE
                               AND (( ADH.UN_DPR_REMAIN_AMOUNT       > 0
                               AND ADH.PERIOD_NAME  IN (SELECT MAX(DH.PERIOD_NAME)
                                                          FROM FI_ASSET_DPR_HISTORY DH
                                                        WHERE DH.PERIOD_NAME        <= W_PERIOD_TO
                                                          AND DH.SOB_ID             = ADH.SOB_ID
                                                          AND DH.DPR_TYPE           = ADH.DPR_TYPE
                                                          AND DH.ASSET_ID           = ADH.ASSET_ID
                                                        )
                                    )
                                OR (ADH.UN_DPR_REMAIN_AMOUNT   = 0
                               AND EXISTS (SELECT 'X'
                                             FROM FI_ASSET_HISTORY AH
                                           WHERE AH.ASSET_ID       = ADH.ASSET_ID
                                             AND AH.SOB_ID         = ADH.SOB_ID
                                             AND AH.CHARGE_DATE    BETWEEN TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM')) 
                                                                       AND LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM'))
                                          )
                                    )))
             ) PX1   
      WHERE FAC.AST_ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
        AND FAC.ASSET_CATEGORY_ID       = PX1.ASSET_CATEGORY_ID
        AND FAC.SOB_ID                  = PX1.SOB_ID
        AND FAC.ASSET_TYPE              = NVL(W_ASSET_TYPE, FAC.ASSET_TYPE)
      GROUP BY AC.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , FAC.ASSET_CATEGORY_ID
      ;     

      /*SELECT  AC.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , SUM(CASE
               WHEN AM.ACQUIRE_DATE < TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), 'MONTH') THEN AM.AMOUNT + NVL(SX3.CE_P_AMOUNT, 0) -- 취득가액.
               ELSE 0
             END -
             CASE
               WHEN AM.DISUSE_DATE < TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), 'MONTH') THEN AM.AMOUNT  -- 폐기/양도.
               ELSE 0
             END) AS BEGIN_AMOUNT
           , SUM(CASE
               WHEN AM.ACQUIRE_DATE < TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), 'MONTH') THEN 0         -- 당기 증가.
               ELSE AM.AMOUNT + NVL(SX3.CE_AMOUNT, 0)
             END) AS INCREASE_AMOUNT
           , SUM(CASE
               WHEN AM.DISUSE_DATE >= TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), 'MONTH') THEN AM.AMOUNT      -- 당기 감소.
               ELSE 0
             END) AS DECREASE_AMOUNT 
           , SUM(CASE
               WHEN AM.ACQUIRE_DATE < TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), 'MONTH') THEN AM.AMOUNT  + NVL(SX3.CE_P_AMOUNT, 0)  -- 취득가액.
               ELSE 0
             END -
             CASE
               WHEN AM.DISUSE_DATE < TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), 'MONTH') THEN AM.AMOUNT  -- 폐기/양도.
               ELSE 0
             END +
             CASE
               WHEN AM.ACQUIRE_DATE < TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), 'MONTH') THEN 0         -- 당기 증가.
               ELSE AM.AMOUNT + NVL(SX3.CE_AMOUNT, 0)
             END -
              CASE
               WHEN AM.DISUSE_DATE >= TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), 'MONTH') THEN AM.AMOUNT      -- 당기 감소.
               ELSE 0
             END) AS ENDING_AMOUNT
           , SUM(SX1.DPR_SUM_AMOUNT) AS BEGIN_DPR_AMOUNT
           , SUM(SX2.DPR_AMOUNT) AS INCREASE_DPR_AMOUNT
           , SUM(SX4.DECREASE_DPR_AMOUNT) AS DECREASE_DPR_AMOUNT
           , SUM(SX2.ENDING_DPR_AMOUNT) AS ENDING_DPR_AMOUNT
           , SUM(SX2.NOT_DPR_AMOUNT) AS NOT_DPR_AMOUNT
           , AM.ASSET_CATEGORY_ID
        FROM FI_ASSET_MASTER AM
          , FI_ASSET_CATEGORY FAC
          , FI_ACCOUNT_CONTROL AC
          , (-- 전기추당금누계액.
            SELECT DH.ASSET_ID
                 , DH.SOB_ID
                 , DH.DPR_SUM_AMOUNT
              FROM FI_ASSET_DPR_HISTORY DH
            WHERE DH.PERIOD_NAME          = TO_CHAR(ADD_MONTHS(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), -1), 'YYYY-MM')
              AND DH.SOB_ID               = W_SOB_ID
              AND DH.DPR_TYPE             = W_DPR_TYPE
            ) SX1  
          , (-- 감가비.
            SELECT DH.ASSET_ID
                 , DH.SOB_ID
                 , SUM(DH.DPR_AMOUNT) AS DPR_AMOUNT
                 , MAX(DH.DPR_SUM_AMOUNT) AS ENDING_DPR_AMOUNT
                 , MAX(DH.UN_DPR_REMAIN_AMOUNT) AS NOT_DPR_AMOUNT
              FROM FI_ASSET_DPR_HISTORY DH
            WHERE DH.PERIOD_NAME          BETWEEN W_PERIOD_FR AND W_PERIOD_TO
              AND DH.SOB_ID               = W_SOB_ID
              AND DH.DPR_TYPE             = W_DPR_TYPE
            GROUP BY DH.ASSET_ID
                 , DH.SOB_ID
            ) SX2
          , ( -- 자본적 지출 금액.
            SELECT AH.ASSET_ID
                 , AH.SOB_ID
                 , NVL(SUM(CASE 
                             WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < W_PERIOD_FR THEN AH.AMOUNT
                             ELSE 0
                           END), 0) AS CE_P_AMOUNT
                 , NVL(SUM(CASE 
                             WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < W_PERIOD_FR THEN 0
                             ELSE AH.AMOUNT
                           END), 0) AS CE_AMOUNT
              FROM FI_ASSET_HISTORY AH
            WHERE AH.SOB_ID                   = W_SOB_ID
              AND EXISTS ( SELECT 'X'
                             FROM FI_COMMON FC
                           WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                             AND FC.SOB_ID      = W_SOB_ID
                             AND FC.CODE        = '10'
                             AND FC.COMMON_ID   = AH.CHARGE_ID
                         )
            GROUP BY AH.ASSET_ID
                 , AH.SOB_ID
            ) SX3 
          , ( -- 폐기/매각 금액.
            SELECT AH.ASSET_ID
                 , AH.SOB_ID
                 , NVL(SUM(ADH.DPR_AMOUNT), 0) AS DECREASE_DPR_AMOUNT
              FROM FI_ASSET_DPR_HISTORY ADH
                , FI_ASSET_HISTORY AH
            WHERE ADH.ASSET_ID                = AH.ASSET_ID
              AND ADH.SOB_ID                  = AH.SOB_ID
              AND AH.SOB_ID                   = W_SOB_ID
              AND EXISTS ( SELECT 'X'
                             FROM FI_COMMON FC
                           WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                             AND FC.SOB_ID      = W_SOB_ID
                             AND FC.CODE        IN('80', '90')
                             AND FC.COMMON_ID   = AH.CHARGE_ID
                         )
            GROUP BY AH.ASSET_ID
                 , AH.SOB_ID
            ) SX4   
      WHERE AM.ASSET_CATEGORY_ID        = FAC.ASSET_CATEGORY_ID
        AND FAC.AST_ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
        AND AM.ASSET_ID                 = SX1.ASSET_ID(+)
        AND AM.SOB_ID                   = SX1.SOB_ID(+)
        AND AM.ASSET_ID                 = SX2.ASSET_ID(+)
        AND AM.SOB_ID                   = SX2.SOB_ID(+)
        AND AM.ASSET_ID                 = SX3.ASSET_ID(+)
        AND AM.SOB_ID                   = SX3.SOB_ID(+)
        \*AND AM.ASSET_ID                 = SX4.ASSET_ID(+)
        AND AM.SOB_ID                   = SX4.SOB_ID(+)*\
        AND AM.SOB_ID                   = W_SOB_ID
        AND FAC.ASSET_TYPE              = NVL(W_ASSET_TYPE, FAC.ASSET_TYPE)
        AND AM.EXPENSE_TYPE             = NVL(W_EXPENSE_TYPE, AM.EXPENSE_TYPE)
      GROUP BY AC.ACCOUNT_CODE
            , AC.ACCOUNT_DESC   
            , AM.ASSET_CATEGORY_ID
      ;*/

  END DPR_LIST_HEADER;

-- 감가상각비현황.
  PROCEDURE DPR_LIST_LINE
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_PERIOD_FR         IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE
            , W_PERIOD_TO         IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE            
            , W_ASSET_CATEGORY_ID IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
            , W_DPR_TYPE          IN VARCHAR2
            , W_SOB_ID            IN FI_ASSET_DPR_HISTORY.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT PX1.ASSET_CODE
           , PX1.ASSET_DESC
           , PX1.BEGIN_AMOUNT
           , PX1.INCREASE_AMOUNT
           , PX1.DECREASE_AMOUNT
           , NVL(PX1.BEGIN_AMOUNT, 0) + NVL(PX1.INCREASE_AMOUNT, 0) - NVL(PX1.DECREASE_AMOUNT, 0) AS ENDING_AMOUNT
           , PX1.BEGIN_DPR_AMOUNT
           , PX1.INCREASE_DPR_AMOUNT
           , PX1.DECREASE_DPR_AMOUNT
           , NVL(PX1.BEGIN_DPR_AMOUNT, 0) + NVL(PX1.INCREASE_DPR_AMOUNT, 0) - NVL(PX1.DECREASE_DPR_AMOUNT, 0) AS ENDING_DPR_AMOUNT
           , PX1.NOT_DPR_AMOUNT
           , FAC.ASSET_CATEGORY_ID
        FROM FI_ASSET_CATEGORY FAC
           , (SELECT AM.ASSET_CODE
                   , AM.ASSET_DESC
                   , CASE
                       WHEN TO_CHAR(AM.ACQUIRE_DATE, 'YYYY-MM') < W_PERIOD_FR THEN AM.AMOUNT + NVL(SX1.CE_BEGIN_AMOUNT, 0)
                       ELSE 0
                     END - NVL(SX1_1.CE_BEGIN_AMOUNT, 0) AS BEGIN_AMOUNT   -- 기초가액.
                   , CASE
                       WHEN TO_CHAR(AM.ACQUIRE_DATE, 'YYYY-MM') < W_PERIOD_FR THEN NVL(SX1.CE_INCREASE_AMOUNT, 0)
                       ELSE NVL(AM.AMOUNT, 0) + NVL(SX1.CE_INCREASE_AMOUNT, 0)
                     END AS INCREASE_AMOUNT  -- 당기증가액.                         
                   , NVL(SX1_1.CE_INCREASE_AMOUNT, 0) AS DECREASE_AMOUNT  -- 당기 감소액.
                   , NVL(SX2.BEGIN_DPR_AMOUNT, 0) AS BEGIN_DPR_AMOUNT
                   , NVL(SX3.INCREASE_DPR_AMOUNT, 0) AS INCREASE_DPR_AMOUNT
                   , NVL(SX4.DECREASE_DPR_AMOUNT, 0) AS DECREASE_DPR_AMOUNT
                   , NVL(SX5.NOT_DPR_AMOUNT, 0) AS NOT_DPR_AMOUNT
                   , AM.ASSET_CATEGORY_ID
                   , AM.SOB_ID
                FROM FI_ASSET_MASTER AM
                  , ( -- 자본적 지출 금액.
                    SELECT AH.ASSET_ID
                         , AH.SOB_ID
                         , SUM(CASE 
                                 WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < W_PERIOD_FR THEN AH.AMOUNT
                                 ELSE 0
                               END) AS CE_BEGIN_AMOUNT
                         , SUM(CASE 
                                 WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < W_PERIOD_FR THEN 0
                                 ELSE AH.AMOUNT
                               END) AS CE_INCREASE_AMOUNT
                      FROM FI_ASSET_HISTORY AH
                    WHERE AH.SOB_ID                   = W_SOB_ID
                      AND AH.CHARGE_DATE              <= LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM'))
                      AND EXISTS ( SELECT 'X'
                                     FROM FI_COMMON FC
                                   WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                                     AND FC.SOB_ID      = W_SOB_ID
                                     AND FC.CODE        = '10'
                                     AND FC.COMMON_ID   = AH.CHARGE_ID
                                 )
                    GROUP BY AH.ASSET_ID
                         , AH.SOB_ID
                    ) SX1
                  , ( -- 폐기/매각 금액.
                    SELECT AH.ASSET_ID
                         , AH.SOB_ID
                         , SUM(CASE 
                                 WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < W_PERIOD_FR THEN AH.AMOUNT
                                 ELSE 0
                               END) AS CE_BEGIN_AMOUNT
                         , SUM(CASE 
                                 WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < W_PERIOD_FR THEN 0
                                 ELSE AH.AMOUNT
                               END) AS CE_INCREASE_AMOUNT
                      FROM FI_ASSET_HISTORY AH
                    WHERE AH.SOB_ID                   = W_SOB_ID
                      AND AH.CHARGE_DATE              <= LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM'))
                      AND EXISTS ( SELECT 'X'
                                     FROM FI_COMMON FC
                                   WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                                     AND FC.SOB_ID      = W_SOB_ID
                                     AND FC.CODE        IN('90', '91')
                                     AND FC.COMMON_ID   = AH.CHARGE_ID
                                 )
                    GROUP BY AH.ASSET_ID
                         , AH.SOB_ID
                    ) SX1_1
                  , (-- 전기 충당금 누계액.
                    SELECT ADH.ASSET_ID
                         , ADH.ASSET_CATEGORY_ID
                         , ADH.SOB_ID
                         , MAX(ADH.DPR_SUM_AMOUNT) AS BEGIN_DPR_AMOUNT
                      FROM FI_ASSET_DPR_HISTORY ADH
                    WHERE ADH.PERIOD_NAME             < W_PERIOD_FR  --= TO_CHAR(ADD_MONTHS(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), -1), 'YYYY-MM')
                      AND ADH.DPR_TYPE                = W_DPR_TYPE
                      AND ADH.SOB_ID                  = W_SOB_ID
                    GROUP BY ADH.ASSET_ID
                         , ADH.ASSET_CATEGORY_ID
                         , ADH.SOB_ID  
                    ) SX2
                  , (-- 당기 감가상각비.
                    SELECT ADH.ASSET_ID
                         , ADH.ASSET_CATEGORY_ID
                         , ADH.SOB_ID
                         , SUM(ADH.DPR_AMOUNT) AS INCREASE_DPR_AMOUNT
                      FROM FI_ASSET_DPR_HISTORY ADH
                    WHERE ADH.PERIOD_NAME             BETWEEN W_PERIOD_FR AND W_PERIOD_TO
                      AND ADH.DPR_TYPE                = W_DPR_TYPE
                      AND ADH.SOB_ID                  = W_SOB_ID
                    GROUP BY ADH.ASSET_ID
                         , ADH.ASSET_CATEGORY_ID
                         , ADH.SOB_ID
                    ) SX3
                  , ( -- 당기 상각충당금 감소액.
                    SELECT AH.ASSET_ID
                         , AH.SOB_ID
                         , SUM(TRUNC(DECODE(W_DPR_TYPE, '20', AH.IFRS_DPR_SUM_DC_AMOUNT, AH.DPR_SUM_DC_AMOUNT))) AS DECREASE_DPR_AMOUNT
                      FROM FI_ASSET_HISTORY AH
                    WHERE AH.CHARGE_DATE    BETWEEN TO_DATE(W_PERIOD_FR || '-01', 'YYYY-MM-DD') AND LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM'))
                      AND AH.SOB_ID         = W_SOB_ID
                      AND EXISTS  ( SELECT 'X'
                                      FROM FI_COMMON FC
                                    WHERE FC.COMMON_ID      = AH.CHARGE_ID
                                      AND FC.SOB_ID         = AH.SOB_ID
                                      AND FC.GROUP_CODE     = 'ASSET_CHARGE'
                                      AND FC.CODE           IN ('90', '91')
                                   )
                    GROUP BY AH.ASSET_ID
                         , AH.SOB_ID
                    ) SX4   
                  , (--  미상각잔액.
                    SELECT ADH.ASSET_ID
                         , ADH.SOB_ID
                         , ADH.UN_DPR_REMAIN_AMOUNT AS NOT_DPR_AMOUNT
                      FROM FI_ASSET_DPR_HISTORY ADH
                    WHERE ADH.DPR_TYPE                = W_DPR_TYPE
                      AND ADH.SOB_ID                  = W_SOB_ID
                      AND ADH.PERIOD_NAME             IN (SELECT MAX(DH.PERIOD_NAME)
                                                            FROM FI_ASSET_DPR_HISTORY DH
                                                          WHERE DH.PERIOD_NAME       <= W_PERIOD_TO
                                                            AND DH.ASSET_ID          = ADH.ASSET_ID
                                                            AND DH.DPR_TYPE          = ADH.DPR_TYPE 
                                                            AND DH.SOB_ID            = ADH.SOB_ID
                                                          )
                    ) SX5  
              WHERE AM.ASSET_ID                 = SX1.ASSET_ID(+)
                AND AM.SOB_ID                   = SX1.SOB_ID(+)
                AND AM.ASSET_ID                 = SX1_1.ASSET_ID(+)
                AND AM.SOB_ID                   = SX1_1.SOB_ID(+)
                AND AM.ASSET_ID                 = SX2.ASSET_ID(+)
                AND AM.SOB_ID                   = SX2.SOB_ID(+)
                AND AM.ASSET_ID                 = SX3.ASSET_ID(+)
                AND AM.SOB_ID                   = SX3.SOB_ID(+)
                AND AM.ASSET_ID                 = SX4.ASSET_ID(+)
                AND AM.SOB_ID                   = SX4.SOB_ID(+)
                AND AM.ASSET_ID                 = SX5.ASSET_ID(+)
                AND AM.SOB_ID                   = SX5.SOB_ID(+)
                AND AM.SOB_ID                   = W_SOB_ID
                AND AM.ACQUIRE_DATE             <= LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM'))
                AND EXISTS ( SELECT 'X'
                               FROM FI_ASSET_DPR_HISTORY ADH
                             WHERE ADH.ASSET_ID     = AM.ASSET_ID
                               AND ADH.SOB_ID       = AM.SOB_ID
                               AND ADH.DPR_TYPE     = W_DPR_TYPE
                               AND (( ADH.UN_DPR_REMAIN_AMOUNT       > 0
                               AND ADH.PERIOD_NAME  IN (SELECT MAX(DH.PERIOD_NAME)
                                                          FROM FI_ASSET_DPR_HISTORY DH
                                                        WHERE DH.PERIOD_NAME        <= W_PERIOD_TO
                                                          AND DH.SOB_ID             = ADH.SOB_ID
                                                          AND DH.DPR_TYPE           = ADH.DPR_TYPE
                                                          AND DH.ASSET_ID           = ADH.ASSET_ID
                                                        )
                                    )
                                OR (ADH.UN_DPR_REMAIN_AMOUNT   = 0
                               AND EXISTS (SELECT 'X'
                                             FROM FI_ASSET_HISTORY AH
                                           WHERE AH.ASSET_ID       = ADH.ASSET_ID
                                             AND AH.SOB_ID         = ADH.SOB_ID
                                             AND AH.CHARGE_DATE    BETWEEN TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM')) 
                                                                       AND LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM'))
                                          )
                                    )))
             ) PX1   
      WHERE FAC.ASSET_CATEGORY_ID       = PX1.ASSET_CATEGORY_ID
        AND FAC.SOB_ID                  = PX1.SOB_ID
        AND FAC.ASSET_CATEGORY_ID       = W_ASSET_CATEGORY_ID
      ORDER BY PX1.ASSET_CODE
      ;     

      /*SELECT  AM.ASSET_CODE
           , AM.ASSET_DESC
           , SUM(CASE
               WHEN AM.ACQUIRE_DATE < TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), 'MONTH') THEN AM.AMOUNT + NVL(SX3.CE_P_AMOUNT, 0) -- 취득가액.
               ELSE 0
             END -
             CASE
               WHEN AM.DISUSE_DATE < TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), 'MONTH') THEN AM.AMOUNT  -- 폐기/양도.
               ELSE 0
             END) AS BEGIN_AMOUNT
           , SUM(CASE
               WHEN AM.ACQUIRE_DATE < TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), 'MONTH') THEN 0         -- 당기 증가.
               ELSE AM.AMOUNT + NVL(SX3.CE_AMOUNT, 0)
             END) AS INCREASE_AMOUNT
           , SUM(CASE
               WHEN AM.DISUSE_DATE >= TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), 'MONTH') THEN AM.AMOUNT      -- 당기 감소.
               ELSE 0
             END) AS DECREASE_AMOUNT 
           , SUM(CASE
               WHEN AM.ACQUIRE_DATE < TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), 'MONTH') THEN AM.AMOUNT + NVL(SX3.CE_P_AMOUNT, 0) -- 취득가액.
               ELSE 0
             END -
             CASE
               WHEN AM.DISUSE_DATE < TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), 'MONTH') THEN AM.AMOUNT  -- 폐기/양도.
               ELSE 0
             END +
             CASE
               WHEN AM.ACQUIRE_DATE < TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), 'MONTH') THEN 0         -- 당기 증가.
               ELSE AM.AMOUNT + NVL(SX3.CE_AMOUNT, 0)
             END -
              CASE
               WHEN AM.DISUSE_DATE >= TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), 'MONTH') THEN AM.AMOUNT      -- 당기 감소.
               ELSE 0
             END) AS ENDING_AMOUNT
           , SUM(SX1.DPR_SUM_AMOUNT) AS BEGIN_DPR_AMOUNT
           , SUM(SX2.DPR_AMOUNT) AS INCREASE_DPR_AMOUNT
           , SUM(SX2.DECREASE_DPR_AMOUNT) AS DECREASE_DPR_AMOUNT
           , SUM(SX2.ENDING_DPR_AMOUNT) AS ENDING_DPR_AMOUNT
           , SUM(SX2.NOT_DPR_AMOUNT) AS NOT_DPR_AMOUNT           
           , AM.ASSET_CATEGORY_ID
        FROM FI_ASSET_MASTER AM
          , (-- 전기추당금누계액.
            SELECT DH.ASSET_ID
                 , DH.SOB_ID
                 , DH.DPR_SUM_AMOUNT
              FROM FI_ASSET_DPR_HISTORY DH
            WHERE DH.PERIOD_NAME          = TO_CHAR(ADD_MONTHS(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), -1), 'YYYY-MM')
              AND DH.SOB_ID               = W_SOB_ID
              AND DH.DPR_TYPE             = W_DPR_TYPE
            ) SX1  
          , (-- 감가비비.
            SELECT DH.ASSET_ID
                 , DH.SOB_ID
                 , SUM(DH.DPR_AMOUNT) AS DPR_AMOUNT
                 , 0 AS DECREASE_DPR_AMOUNT
                 , MAX(DH.DPR_SUM_AMOUNT) AS ENDING_DPR_AMOUNT
                 , MAX(DH.UN_DPR_REMAIN_AMOUNT) AS NOT_DPR_AMOUNT
              FROM FI_ASSET_DPR_HISTORY DH
            WHERE DH.PERIOD_NAME          BETWEEN W_PERIOD_FR AND W_PERIOD_TO
              AND DH.SOB_ID               = W_SOB_ID
              AND DH.DPR_TYPE             = W_DPR_TYPE
            GROUP BY DH.ASSET_ID
                 , DH.SOB_ID
            ) SX2
          , ( -- 자본적 지출 금액.
            SELECT AH.ASSET_ID
                 , AH.SOB_ID
                 , NVL(SUM(CASE 
                             WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < W_PERIOD_FR THEN AH.AMOUNT
                             ELSE 0
                           END), 0) AS CE_P_AMOUNT
                 , NVL(SUM(CASE 
                             WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < W_PERIOD_FR THEN 0
                             ELSE AH.AMOUNT
                           END), 0) AS CE_AMOUNT
              FROM FI_ASSET_HISTORY AH
            WHERE AH.SOB_ID                   = W_SOB_ID
              AND EXISTS ( SELECT 'X'
                             FROM FI_COMMON FC
                           WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                             AND FC.SOB_ID      = W_SOB_ID
                             AND FC.CODE        = '10'
                             AND FC.COMMON_ID   = AH.CHARGE_ID
                         )
            GROUP BY AH.ASSET_ID
                 , AH.SOB_ID
            ) SX3 
      WHERE AM.ASSET_ID                 = SX1.ASSET_ID(+)
        AND AM.SOB_ID                   = SX1.SOB_ID(+)
        AND AM.ASSET_ID                 = SX2.ASSET_ID(+)
        AND AM.SOB_ID                   = SX2.SOB_ID(+)
        AND AM.ASSET_ID                 = SX3.ASSET_ID(+)
        AND AM.SOB_ID                   = SX3.SOB_ID(+)
        AND AM.SOB_ID                   = W_SOB_ID
        AND AM.ASSET_CATEGORY_ID        = W_ASSET_CATEGORY_ID
      GROUP BY AM.ASSET_CODE
           , AM.ASSET_DESC
           , AM.ASSET_CATEGORY_ID
      ;*/
  END DPR_LIST_LINE;
  
-- 월별 감가상각비 현황.
  PROCEDURE DPR_MONTH
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_PERIOD_FR         IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE
            , W_PERIOD_TO         IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE            
            , W_EXPENSE_TYPE      IN FI_ASSET_MASTER.EXPENSE_TYPE%TYPE
            , W_ASSET_TYPE        IN FI_ASSET_CATEGORY.ASSET_TYPE%TYPE     
            , W_DPR_TYPE          IN VARCHAR2       
            , W_ACCOUNT_CODE_FR   IN VARCHAR2
            , W_ACCOUNT_CODE_TO   IN VARCHAR2
            , W_ASSET_CODE_FR     IN VARCHAR2
            , W_ASSET_CODE_TO     IN VARCHAR2
            , W_SOB_ID            IN FI_ASSET_DPR_HISTORY.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT AM.EXPENSE_TYPE
           , CASE
               WHEN GROUPING(AM.EXPENSE_TYPE) = 1 THEN '총누계'
               WHEN GROUPING(AC.ACCOUNT_CODE) = 1 THEN '소계'
               ELSE FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', AM.EXPENSE_TYPE, AM.SOB_ID) 
             END AS EXPENSE_TYPE_NAME
           , AC.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , AM.ASSET_CODE
           , AM.ASSET_DESC
           , SUM(DECODE(SUBSTR(ADH.PERIOD_NAME, 6, 2), '01', ADH.DPR_AMOUNT, 0)) AS DPR_AMOUNT_1
           , SUM(DECODE(SUBSTR(ADH.PERIOD_NAME, 6, 2), '02', ADH.DPR_AMOUNT, 0)) AS DPR_AMOUNT_2     
           , SUM(DECODE(SUBSTR(ADH.PERIOD_NAME, 6, 2), '03', ADH.DPR_AMOUNT, 0)) AS DPR_AMOUNT_3
           , SUM(DECODE(SUBSTR(ADH.PERIOD_NAME, 6, 2), '04', ADH.DPR_AMOUNT, 0)) AS DPR_AMOUNT_4
           , SUM(DECODE(SUBSTR(ADH.PERIOD_NAME, 6, 2), '05', ADH.DPR_AMOUNT, 0)) AS DPR_AMOUNT_5
           , SUM(DECODE(SUBSTR(ADH.PERIOD_NAME, 6, 2), '06', ADH.DPR_AMOUNT, 0)) AS DPR_AMOUNT_6
           , SUM(DECODE(SUBSTR(ADH.PERIOD_NAME, 6, 2), '07', ADH.DPR_AMOUNT, 0)) AS DPR_AMOUNT_7
           , SUM(DECODE(SUBSTR(ADH.PERIOD_NAME, 6, 2), '08', ADH.DPR_AMOUNT, 0)) AS DPR_AMOUNT_8
           , SUM(DECODE(SUBSTR(ADH.PERIOD_NAME, 6, 2), '09', ADH.DPR_AMOUNT, 0)) AS DPR_AMOUNT_9
           , SUM(DECODE(SUBSTR(ADH.PERIOD_NAME, 6, 2), '10', ADH.DPR_AMOUNT, 0)) AS DPR_AMOUNT_10
           , SUM(DECODE(SUBSTR(ADH.PERIOD_NAME, 6, 2), '11', ADH.DPR_AMOUNT, 0)) AS DPR_AMOUNT_11
           , SUM(DECODE(SUBSTR(ADH.PERIOD_NAME, 6, 2), '12', ADH.DPR_AMOUNT, 0)) AS DPR_AMOUNT_12
           , SUM(ADH.DPR_AMOUNT) AS DPR_SUM_AMOUNT
        FROM FI_ASSET_MASTER AM
          , FI_ASSET_CATEGORY FAC
          , FI_ACCOUNT_CONTROL AC
          , FI_ASSET_DPR_HISTORY ADH
      WHERE AM.ASSET_CATEGORY_ID        = FAC.ASSET_CATEGORY_ID
        AND FAC.AST_ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
        AND AM.ASSET_ID                 = ADH.ASSET_ID  
        AND AM.ASSET_CODE               BETWEEN NVL(W_ASSET_CODE_FR, AM.ASSET_CODE) AND NVL(W_ASSET_CODE_TO, AM.ASSET_CODE)
        AND AM.SOB_ID                   = W_SOB_ID
        AND ADH.PERIOD_NAME             BETWEEN W_PERIOD_FR AND W_PERIOD_TO
        AND ADH.DPR_TYPE                = W_DPR_TYPE
        AND AM.EXPENSE_TYPE             = NVL(W_EXPENSE_TYPE, AM.EXPENSE_TYPE)
        AND FAC.ASSET_TYPE              = NVL(W_ASSET_TYPE, FAC.ASSET_TYPE) 
        AND AC.ACCOUNT_CODE             BETWEEN NVL(W_ACCOUNT_CODE_FR, AC.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, AC.ACCOUNT_CODE)
      GROUP BY ROLLUP((AM.EXPENSE_TYPE
           , FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', AM.EXPENSE_TYPE, AM.SOB_ID))
           , (AC.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , AM.ASSET_CODE
           , AM.ASSET_DESC))
      ORDER BY AM.EXPENSE_TYPE
      ;

  END DPR_MONTH;

-- 고정자산명세서.
  PROCEDURE DPR_STATEMENT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_PERIOD_FR         IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE
            , W_PERIOD_TO         IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE            
            , W_DPR_TYPE          IN VARCHAR2       
            , W_ACCOUNT_CODE_FR   IN VARCHAR2
            , W_ACCOUNT_CODE_TO   IN VARCHAR2
            , W_ASSET_CODE_FR     IN VARCHAR2
            , W_ASSET_CODE_TO     IN VARCHAR2
            , W_SOB_ID            IN FI_ASSET_DPR_HISTORY.SOB_ID%TYPE
            )
  AS
    V_PERIOD_FR                   FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE;
    V_PERIOD_TO                   FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE;           

  BEGIN
    V_PERIOD_FR := TO_CHAR(TRUNC(GET_LOCAL_DATE(W_SOB_ID), 'YEAR'), 'YYYY-MM');
    V_PERIOD_TO := TO_CHAR(GET_LOCAL_DATE(W_SOB_ID), 'YYYY-MM');
    
    /*BEGIN
      DELETE FROM FI_ASSET_DPR_HISTORY_GT;
      
      INSERT INTO FI_ASSET_DPR_HISTORY_GT
      SELECT SX1.HISTORY_NUM_SEQ
           , SX1.ASSET_ID
           , SX1.SOB_ID
           , SX1.ASSET_CATEGORY_ID
           , SX1.PERIOD_NAME
           , SX1.DPR_AMOUNT AS DPR_AMOUNT
        FROM ( 
              SELECT DHL.ASSET_ID
                   , DHL.SOB_ID
                   , DHL.ASSET_CATEGORY_ID
                   , DHL.PERIOD_NAME
                   , DHL.DPR_AMOUNT AS DPR_AMOUNT
                   , DHL.HISTORY_NUM_SEQ
                FROM FI_ASSET_DPR_HISTORY_LOG DHL
              WHERE DHL.PERIOD_NAME             <= W_PERIOD_TO
                AND DHL.DPR_TYPE                = W_DPR_TYPE
                AND DHL.SOB_ID                  = W_SOB_ID
              ----------------------------------
              UNION ALL
              ----------------------------------
              SELECT DH.ASSET_ID
                   , DH.SOB_ID
                   , DH.ASSET_CATEGORY_ID
                   , DH.PERIOD_NAME
                   , DH.DPR_AMOUNT AS DPR_AMOUNT
                   , 999 AS HISTORY_NUM_SEQ     
                FROM FI_ASSET_DPR_HISTORY DH
              WHERE DH.PERIOD_NAME              <= W_PERIOD_TO
                AND DH.DPR_TYPE                 = W_DPR_TYPE
                AND DH.SOB_ID                   = W_SOB_ID
                AND EXISTS (SELECT 'X'
                              FROM FI_ASSET_DPR_HISTORY_LOG DHL
                            WHERE DHL.ASSET_ID        = DH.ASSET_ID
                              AND DHL.SOB_ID          = DH.SOB_ID
                              AND DHL.DPR_TYPE        = DH.DPR_TYPE
                              AND DHL.PERIOD_NAME     = DH.PERIOD_NAME
                              AND DHL.HISTORY_NUM_SEQ IN (SELECT MAX(DHL.HISTORY_NUM_SEQ) AS HISTORY_NUM_SEQ
                                                             FROM FI_ASSET_DPR_HISTORY_LOG DHL1
                                                          WHERE DHL1.ASSET_ID       = DHL.ASSET_ID
                                                            AND DHL1.SOB_ID         = DHL.SOB_ID
                                                            AND DHL1.DPR_TYPE       = DHL.DPR_TYPE
                                                            AND DHL1.PERIOD_NAME    = DHL.PERIOD_NAME
                                                         )
                           )
              ) SX1
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;      
    END;*/
    
    OPEN P_CURSOR1 FOR
      SELECT AC.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , PX1.ASSET_CODE
           , PX1.ASSET_DESC
           , PX1.ACQUIRE_DATE
           , PX1.DPR_PROGRESS_YEAR
           , PX1.DPR_RATE
           , PX1.QTY
           , (PX1.BEGIN_AMOUNT) BEGIN_AMOUNT
           , (PX1.INCREASE_AMOUNT) INCREASE_AMOUNT
           , (PX1.DECREASE_AMOUNT) DECREASE_AMOUNT
           , (NVL(PX1.BEGIN_AMOUNT, 0) + NVL(PX1.INCREASE_AMOUNT, 0) - NVL(PX1.DECREASE_AMOUNT, 0)) AS ENDING_AMOUNT
           , (PX1.BEGIN_DPR_AMOUNT) BEGIN_DPR_SUM
           , (PX1.INCREASE_DPR_AMOUNT) INCREASE_DPR_AMOUNT
           , (PX1.DECREASE_DPR_AMOUNT) DECREASE_DPR_AMOUNT
           , (NVL(PX1.BEGIN_DPR_AMOUNT, 0) + NVL(PX1.INCREASE_DPR_AMOUNT, 0) - NVL(PX1.DECREASE_DPR_AMOUNT, 0)) AS ENDING_DPR_AMOUNT
           , (PX1.NOT_DPR_AMOUNT) ENDING_BOOK_AMOUNT
           , PX1.DPR_METHOD_TYPE_NAME
           , PX1.MANAGE_DEPT_NAME
        FROM FI_ASSET_CATEGORY FAC
           , FI_ACCOUNT_CONTROL AC
           , (SELECT AM.ASSET_CODE
                   , AM.ASSET_DESC
                   , AM.ACQUIRE_DATE
                   , CASE
                       WHEN W_DPR_TYPE = '20' THEN AM.IFRS_PROGRESS_YEAR
                       ELSE AM.DPR_PROGRESS_YEAR
                     END AS DPR_PROGRESS_YEAR
                   , CASE
                       WHEN W_DPR_TYPE = '20' THEN CASE 
                                                      WHEN AM.IFRS_DPR_METHOD_TYPE = '1' THEN TRUNC(1 / AM.IFRS_PROGRESS_YEAR, 4)
                                                      ELSE (SELECT FDR.DPR_RATE FROM FI_DPR_RATE FDR WHERE FDR.DPR_TYPE = '20' AND FDR.PROGRESS_YEAR = AM.IFRS_PROGRESS_YEAR AND FDR.SOB_ID = AM.SOB_ID)
                                                    END
                       ELSE CASE 
                              WHEN AM.DPR_METHOD_TYPE = '1' THEN TRUNC(1 / AM.DPR_PROGRESS_YEAR, 4)
                              ELSE (SELECT FDR.DPR_RATE FROM FI_DPR_RATE FDR WHERE FDR.DPR_TYPE = '10' AND FDR.PROGRESS_YEAR = AM.DPR_PROGRESS_YEAR AND FDR.SOB_ID = AM.SOB_ID)
                            END
                     END AS DPR_RATE
                   , AM.QTY
                   , CASE
                       WHEN TO_CHAR(AM.ACQUIRE_DATE, 'YYYY-MM') < V_PERIOD_FR THEN AM.AMOUNT + NVL(SX1.CE_BEGIN_AMOUNT, 0)
                       ELSE 0
                     END - NVL(SX1_1.CE_BEGIN_AMOUNT, 0)
                     /*CASE
                       WHEN AM.DISUSE_DATE IS NOT NULL AND TO_CHAR(AM.DISUSE_DATE, 'YYYY-MM') < V_PERIOD_FR THEN NVL(AM.AMOUNT, 0) + NVL(SX1.CE_BEGIN_AMOUNT, 0)
                       ELSE 0 
                     END*/ AS BEGIN_AMOUNT   -- 기초가액.
                   , CASE
                       WHEN TO_CHAR(AM.ACQUIRE_DATE, 'YYYY-MM') < V_PERIOD_FR THEN NVL(SX1.CE_INCREASE_AMOUNT, 0)
                       ELSE NVL(AM.AMOUNT, 0) + NVL(SX1.CE_INCREASE_AMOUNT, 0)
                     END AS INCREASE_AMOUNT  -- 당기증가액.                         
                   , /*CASE
                       WHEN AM.DISUSE_DATE IS NOT NULL AND TO_CHAR(AM.DISUSE_DATE, 'YYYY-MM') >= V_PERIOD_FR THEN AM.AMOUNT + NVL(SX1.CE_BEGIN_AMOUNT, 0) + NVL(SX1.CE_INCREASE_AMOUNT, 0)
                       ELSE 0 
                     END*/NVL(SX1_1.CE_INCREASE_AMOUNT, 0) AS DECREASE_AMOUNT  -- 당기 감소액.
                   , NVL(SX2.BEGIN_DPR_AMOUNT, 0) AS BEGIN_DPR_AMOUNT
                   , NVL(SX3.INCREASE_DPR_AMOUNT, 0) AS INCREASE_DPR_AMOUNT
                   , NVL(SX4.DECREASE_DPR_AMOUNT, 0) AS DECREASE_DPR_AMOUNT
                   , NVL(SX5.NOT_DPR_AMOUNT, 0) AS NOT_DPR_AMOUNT
                   , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', AM.DPR_METHOD_TYPE, AM.SOB_ID) AS DPR_METHOD_TYPE_NAME
                   , FI_DEPT_MASTER_G.DEPT_NAME_F(AM.MANAGE_DEPT_ID) AS MANAGE_DEPT_NAME
                   , AM.ASSET_CATEGORY_ID
                   , AM.SOB_ID                   
                FROM FI_ASSET_MASTER AM
                  , ( -- 자본적 지출 금액.
                    SELECT AH.ASSET_ID
                         , AH.SOB_ID
                         , SUM(CASE 
                                 WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < V_PERIOD_FR THEN AH.AMOUNT
                                 ELSE 0
                               END) AS CE_BEGIN_AMOUNT
                         , SUM(CASE 
                                 WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < V_PERIOD_FR THEN 0
                                 ELSE AH.AMOUNT
                               END) AS CE_INCREASE_AMOUNT
                      FROM FI_ASSET_HISTORY AH
                    WHERE AH.SOB_ID                   = W_SOB_ID
                      AND EXISTS ( SELECT 'X'
                                     FROM FI_COMMON FC
                                   WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                                     AND FC.SOB_ID      = W_SOB_ID
                                     AND FC.CODE        = '10'
                                     AND FC.COMMON_ID   = AH.CHARGE_ID
                                 )
                    GROUP BY AH.ASSET_ID
                         , AH.SOB_ID
                    ) SX1
                  , ( -- 폐기/매각 금액.
                    SELECT AH.ASSET_ID
                         , AH.SOB_ID
                         , SUM(CASE 
                                 WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < W_PERIOD_FR THEN AH.AMOUNT
                                 ELSE 0
                               END) AS CE_BEGIN_AMOUNT
                         , SUM(CASE 
                                 WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < W_PERIOD_FR THEN 0
                                 ELSE AH.AMOUNT
                               END) AS CE_INCREASE_AMOUNT
                      FROM FI_ASSET_HISTORY AH
                    WHERE AH.SOB_ID                   = W_SOB_ID
                      AND AH.CHARGE_DATE              <= LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM'))
                      AND EXISTS ( SELECT 'X'
                                     FROM FI_COMMON FC
                                   WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                                     AND FC.SOB_ID      = W_SOB_ID
                                     AND FC.CODE        IN('90', '91')
                                     AND FC.COMMON_ID   = AH.CHARGE_ID
                                 )
                    GROUP BY AH.ASSET_ID
                         , AH.SOB_ID
                    ) SX1_1
                  , (-- 전기 충당금 누계액.
                    SELECT ADH.ASSET_ID
                         , ADH.ASSET_CATEGORY_ID
                         , ADH.SOB_ID
                         , MAX(ADH.DPR_SUM_AMOUNT) AS BEGIN_DPR_AMOUNT
                      FROM FI_ASSET_DPR_HISTORY ADH
                    WHERE ADH.PERIOD_NAME             < V_PERIOD_FR --= TO_CHAR(ADD_MONTHS(TO_DATE(V_PERIOD_FR, 'YYYY-MM'), -1), 'YYYY-MM')
                      AND ADH.DPR_TYPE                = W_DPR_TYPE
                      AND ADH.SOB_ID                  = W_SOB_ID
                    GROUP BY ADH.ASSET_ID
                         , ADH.ASSET_CATEGORY_ID
                         , ADH.SOB_ID  
                    ) SX2
                  , (-- 당기 감가상각비.
                    SELECT ADH.ASSET_ID
                         , ADH.ASSET_CATEGORY_ID
                         , ADH.SOB_ID
                         , SUM(ADH.DPR_AMOUNT) AS INCREASE_DPR_AMOUNT
                      FROM FI_ASSET_DPR_HISTORY ADH
                    WHERE ADH.PERIOD_NAME             BETWEEN V_PERIOD_FR AND V_PERIOD_TO
                      AND ADH.DPR_TYPE                = W_DPR_TYPE
                      AND ADH.SOB_ID                  = W_SOB_ID
                    GROUP BY ADH.ASSET_ID
                         , ADH.ASSET_CATEGORY_ID
                         , ADH.SOB_ID
                    ) SX3
                  , ( -- 당기 상각충당금 감소액.
                    SELECT AH.ASSET_ID
                         , AH.SOB_ID
                         , SUM(TRUNC(DECODE(W_DPR_TYPE, '20', AH.IFRS_DPR_SUM_DC_AMOUNT, AH.DPR_SUM_DC_AMOUNT))) AS DECREASE_DPR_AMOUNT
                      FROM FI_ASSET_HISTORY AH
                    WHERE AH.CHARGE_DATE    BETWEEN TO_DATE(V_PERIOD_FR || '-01', 'YYYY-MM-DD') AND LAST_DAY(TO_DATE(V_PERIOD_TO, 'YYYY-MM'))
                      AND AH.SOB_ID         = W_SOB_ID
                      AND EXISTS  ( SELECT 'X'
                                      FROM FI_COMMON FC
                                    WHERE FC.COMMON_ID      = AH.CHARGE_ID
                                      AND FC.SOB_ID         = AH.SOB_ID
                                      AND FC.GROUP_CODE     = 'ASSET_CHARGE'
                                      AND FC.CODE           IN ('90', '91')
                                   )
                    GROUP BY AH.ASSET_ID
                         , AH.SOB_ID
                    ) SX4   
                  , (--  미상각잔액.
                    SELECT ADH.ASSET_ID
                         , ADH.SOB_ID
                         , ADH.UN_DPR_REMAIN_AMOUNT AS NOT_DPR_AMOUNT
                      FROM FI_ASSET_DPR_HISTORY ADH
                    WHERE ADH.DPR_TYPE                = W_DPR_TYPE
                      AND ADH.SOB_ID                  = W_SOB_ID
                      AND ADH.PERIOD_NAME             IN (SELECT MAX(DH.PERIOD_NAME)
                                                            FROM FI_ASSET_DPR_HISTORY DH
                                                          WHERE DH.PERIOD_NAME       <= V_PERIOD_TO
                                                            AND DH.ASSET_ID          = ADH.ASSET_ID
                                                            AND DH.DPR_TYPE          = ADH.DPR_TYPE 
                                                            AND DH.SOB_ID            = ADH.SOB_ID
                                                          )
                    ) SX5  
              WHERE AM.ASSET_ID                 = SX1.ASSET_ID(+)
                AND AM.SOB_ID                   = SX1.SOB_ID(+)
                AND AM.ASSET_ID                 = SX1_1.ASSET_ID(+)
                AND AM.SOB_ID                   = SX1_1.SOB_ID(+)
                AND AM.ASSET_ID                 = SX2.ASSET_ID(+)
                AND AM.SOB_ID                   = SX2.SOB_ID(+)
                AND AM.ASSET_ID                 = SX3.ASSET_ID(+)
                AND AM.SOB_ID                   = SX3.SOB_ID(+)
                AND AM.ASSET_ID                 = SX4.ASSET_ID(+)
                AND AM.SOB_ID                   = SX4.SOB_ID(+)
                AND AM.ASSET_ID                 = SX5.ASSET_ID(+)
                AND AM.SOB_ID                   = SX5.SOB_ID(+)
                AND AM.ASSET_CODE               BETWEEN NVL(W_ASSET_CODE_FR, AM.ASSET_CODE) AND NVL(W_ASSET_CODE_TO, AM.ASSET_CODE)
                AND AM.SOB_ID                   = W_SOB_ID
                AND AM.ACQUIRE_DATE             >= TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM'))
                AND AM.ACQUIRE_DATE             <= LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM'))
             ) PX1   
      WHERE FAC.AST_ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
        AND FAC.ASSET_CATEGORY_ID       = PX1.ASSET_CATEGORY_ID
        AND FAC.SOB_ID                  = PX1.SOB_ID
        AND AC.ACCOUNT_CODE             BETWEEN NVL(W_ACCOUNT_CODE_FR, AC.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, AC.ACCOUNT_CODE)
      ;
      /*SELECT AC.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , AM.ASSET_CODE
           , AM.ASSET_DESC
           , AM.ACQUIRE_DATE
           , AM.DPR_PROGRESS_YEAR
           , CASE
               WHEN AM.DPR_METHOD_TYPE = '1' THEN TRUNC(1/AM.DPR_PROGRESS_YEAR, 3)
               ELSE DR.DPR_RATE
             END AS DPR_RATE
           , AM.QTY
           , 0 AS BEGIN_AMOUNT
           , AM.AMOUNT AS INCREASE_AMOUNT
           , 0 AS DECREASE_AMOUNT
           , AM.AMOUNT + NVL(SX3.CE_AMOUNT, 0) AS ENDING_AMOUNT
           , NVL(SX1.DPR_SUM_AMOUNT, 0) AS BEGIN_DPR_SUM
           , NVL(ADH.DPR_AMOUNT, 0) AS INCREASE_DPR_AMOUNT
           , 0 AS DECREASE_DPR_AMOUNT
           , NVL(ADH.ENDING_DPR_AMOUNT, 0) AS ENDING_DPR_AMOUNT
           , NVL(ADH.NOT_DPR_AMOUNT, 0) AS ENDING_BOOK_AMOUNT
           , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', AM.DPR_METHOD_TYPE, AM.SOB_ID) AS DPR_METHOD_TYPE_NAME
           , FI_DEPT_MASTER_G.DEPT_NAME_F(AM.MANAGE_DEPT_ID) AS MANAGE_DEPT_NAME
        FROM FI_ASSET_MASTER AM
          , FI_ASSET_CATEGORY FAC
          , FI_ACCOUNT_CONTROL AC
          , ( SELECT FDR.SOB_ID                              
                   , FDR.PROGRESS_YEAR
                   , FDR.DPR_RATE
                FROM FI_DPR_RATE FDR
              WHERE FDR.DPR_TYPE        = W_DPR_TYPE
                AND FDR.SOB_ID          = W_SOB_ID
            ) DR
          , ( SELECT FADH.ASSET_ID      
                   , FADH.SOB_ID
                   , SUM(FADH.DPR_AMOUNT) AS DPR_AMOUNT
                   , MAX(FADH.DPR_SUM_AMOUNT) AS ENDING_DPR_AMOUNT
                   , MAX(FADH.UN_DPR_REMAIN_AMOUNT) AS NOT_DPR_AMOUNT
                FROM FI_ASSET_DPR_HISTORY FADH
              WHERE FADH.DPR_TYPE       = W_DPR_TYPE
                AND FADH.SOB_ID         = W_SOB_ID
                AND FADH.PERIOD_NAME    BETWEEN W_PERIOD_FR AND W_PERIOD_TO
              GROUP BY FADH.ASSET_ID      
                   , FADH.SOB_ID
            ) ADH
          , (-- 전기추당금누계액.
            SELECT DH.ASSET_ID
                 , DH.SOB_ID
                 , DH.DPR_SUM_AMOUNT
              FROM FI_ASSET_DPR_HISTORY DH
            WHERE DH.PERIOD_NAME          = TO_CHAR(ADD_MONTHS(TO_DATE(W_PERIOD_FR, 'YYYY-MM'), -1), 'YYYY-MM')
              AND DH.SOB_ID               = W_SOB_ID
              AND DH.DPR_TYPE             = W_DPR_TYPE
            ) SX1
          , ( -- 자본적 지출 금액.
            SELECT AH.ASSET_ID
                 , AH.SOB_ID
                 , NVL(SUM(AH.AMOUNT), 0) AS CE_AMOUNT
              FROM FI_ASSET_HISTORY AH
            WHERE AH.SOB_ID                   = W_SOB_ID
              AND EXISTS ( SELECT 'X'
                             FROM FI_COMMON FC
                           WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                             AND FC.SOB_ID      = W_SOB_ID
                             AND FC.CODE        = '10'
                             AND FC.COMMON_ID   = AH.CHARGE_ID
                         )
            GROUP BY AH.ASSET_ID
                 , AH.SOB_ID
            ) SX3     
      WHERE AM.ASSET_CATEGORY_ID        = FAC.ASSET_CATEGORY_ID
        AND FAC.AST_ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
        AND AM.SOB_ID                   = DR.SOB_ID(+)
        AND AM.DPR_PROGRESS_YEAR        = DR.PROGRESS_YEAR(+)
        AND AM.ASSET_ID                 = ADH.ASSET_ID(+)
        AND AM.ASSET_ID                 = SX1.ASSET_ID(+)
        AND AM.SOB_ID                   = SX1.SOB_ID(+)
        AND AM.ASSET_ID                 = SX3.ASSET_ID(+)
        AND AM.SOB_ID                   = SX3.SOB_ID(+)
        AND AM.ASSET_CODE               BETWEEN NVL(W_ASSET_CODE_FR, AM.ASSET_CODE) AND NVL(W_ASSET_CODE_TO, AM.ASSET_CODE)
        AND AM.SOB_ID                   = W_SOB_ID
        AND AM.ACQUIRE_DATE             >= TRUNC(TO_DATE(W_PERIOD_FR, 'YYYY-MM'))
        AND AM.ACQUIRE_DATE             <= LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM'))
        AND AC.ACCOUNT_CODE             BETWEEN NVL(W_ACCOUNT_CODE_FR, AC.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, AC.ACCOUNT_CODE)
      ;*/
      
  END DPR_STATEMENT;

-- 감가상각전표생성 조회.
  PROCEDURE DPR_SLIP
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_PERIOD_NAME       IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE
            , W_ASSET_CATEGORY_ID IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
            , W_DPR_TYPE          IN VARCHAR2
            , W_SOB_ID            IN FI_ASSET_DPR_HISTORY.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT 'N' AS CHECK_YN
           , AC.ASSET_CATEGORY_NAME
           , AM.ASSET_CATEGORY_ID
           , FI_COMMON_G.CODE_NAME_F('DPR_TYPE', ADH.DPR_TYPE, ADH.SOB_ID) AS DPR_TYPE_DESC
           , ADH.DPR_TYPE
           , FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', AM.EXPENSE_TYPE, AM.SOB_ID) AS EXPENSE_TYPE_DESC
           , AM.EXPENSE_TYPE
           , FI_COMMON_G.COST_CENTER_CODE_F(AM.COST_CENTER_ID) AS CC_CODE
           , FI_COMMON_G.COST_CENTER_DESC_F(AM.COST_CENTER_ID) AS CC_DESC
           , AM.COST_CENTER_ID
           , ADH.PERIOD_NAME
           , AM.ASSET_CODE
           , AM.ASSET_DESC
           , SUM(ADH.DPR_AMOUNT) AS DPR_AMOUNT
           , ADH.GL_NUM
           , ADH.SLIP_YN
           , AM.ASSET_ID
           , ADH.SLIP_HEADER_ID
        FROM FI_ASSET_DPR_HISTORY ADH
          , FI_ASSET_MASTER AM
          , FI_ASSET_CATEGORY AC
      WHERE ADH.ASSET_ID                = AM.ASSET_ID
        AND ADH.SOB_ID                  = AM.SOB_ID
        AND AM.ASSET_CATEGORY_ID        = AC.ASSET_CATEGORY_ID
        AND AM.SOB_ID                   = AC.SOB_ID
        AND ADH.PERIOD_NAME             = W_PERIOD_NAME
        AND ADH.SOB_ID                  = W_SOB_ID
        AND ADH.DPR_TYPE                = W_DPR_TYPE
        AND AM.ASSET_CATEGORY_ID        = W_ASSET_CATEGORY_ID
        AND ADH.DPR_AMOUNT              <> 0
      GROUP BY AC.ASSET_CATEGORY_NAME
           , AM.ASSET_CATEGORY_ID
           , FI_COMMON_G.CODE_NAME_F('DPR_TYPE', ADH.DPR_TYPE, ADH.SOB_ID)
           , ADH.DPR_TYPE
           , FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', AM.EXPENSE_TYPE, AM.SOB_ID)
           , AM.EXPENSE_TYPE
           , FI_COMMON_G.COST_CENTER_CODE_F(AM.COST_CENTER_ID)
           , FI_COMMON_G.COST_CENTER_DESC_F(AM.COST_CENTER_ID)
           , AM.COST_CENTER_ID
           , ADH.PERIOD_NAME
           , AM.ASSET_CODE
           , AM.ASSET_DESC
           , ADH.GL_NUM
           , ADH.SLIP_YN
           , AM.ASSET_ID
           , ADH.SLIP_HEADER_ID
      ;
  END DPR_SLIP;

-- 감가상각전표생성 선택한 감가자료 SLIP_YN = 'S' 로 업데이트.
  PROCEDURE UPDATE_DPR_SLIP
            ( W_PERIOD_NAME       IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE
            , W_DPR_TYPE          IN VARCHAR2
            , W_ASSET_ID          IN FI_ASSET_MASTER.ASSET_ID%TYPE
            , P_SOB_ID            IN FI_ASSET_DPR_HISTORY.SOB_ID%TYPE
            , P_CHECK_YN          VARCHAR2
            )
  AS
  BEGIN
    IF P_CHECK_YN = 'Y' THEN
      UPDATE FI_ASSET_DPR_HISTORY ADH
        SET ADH.SLIP_YN         = DECODE(P_CHECK_YN, 'Y', 'S', ADH.SLIP_YN)
      WHERE ADH.PERIOD_NAME         = W_PERIOD_NAME
        AND ADH.SOB_ID              = P_SOB_ID
        AND ADH.DPR_TYPE            = W_DPR_TYPE
        AND ADH.ASSET_ID            = W_ASSET_ID
      ;
    END IF;
  END UPDATE_DPR_SLIP;

-- 감가상각전표생성  : 해당월 감가자료 SLIP_YN = 'S' 인 것만 조회해서 생성.
  PROCEDURE CREATE_DPR_SLIP
            ( W_PERIOD_NAME       IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE
            , W_ASSET_CATEGORY_ID IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
            , W_DPR_TYPE          IN VARCHAR2
            , P_SOB_ID            IN FI_ASSET_DPR_HISTORY.SOB_ID%TYPE
            , P_ORG_ID            IN FI_ASSET_DPR_HISTORY.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_JOB_CATEGORY_CD       VARCHAR2(10);  -- 자동전표 유형.
    V_DEPT_ID               FI_SLIP_LINE.DEPT_ID%TYPE;
  BEGIN
    -- 작서부서.
    BEGIN
      SELECT FDM.DEPT_ID
        INTO V_DEPT_ID
        FROM HRM_PERSON_MASTER PM
          , HRM_DEPT_MASTER HDM
          , FI_DEPT_MASTER_MAPPING_V FDM
       WHERE PM.DEPT_ID                 = HDM.DEPT_ID
         AND HDM.DEPT_ID                = FDM.HR_DEPT_ID(+)
         AND HDM.CORP_ID                = FDM.HR_CORP_ID(+)
         AND HDM.SOB_ID                 = FDM.SOB_ID(+)
         AND PM.PERSON_ID               = P_CONNECT_PERSON_ID
         AND PM.SOB_ID                  = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10183', NULL));
    END;
       
    BEGIN
      /*-- 자동전표 설정 내역 --
      DP01	감가상각비 건물 자동전표
      DP02	감가상각비 기계장치 자동전표
      DP03	감가상각비 차량운반구 자동전표
      DP04	감가상각비 공구와기구 자동전표
      DP05	감가상각비 시설장치 자동전표
      DP06	감가상각비 비품 자동전표
      */
      -- 제조.
      SELECT CASE AC.ASSET_CATEGORY_CODE
               WHEN 'A' THEN 'DP01'       -- 감가상각비(건물)
               WHEN 'B' THEN 'DP02'       -- 감가상각비(기계장치)
               WHEN 'C' THEN 'DP03'       -- 감가상각비(차량운반구)
               WHEN 'D' THEN 'DP04'       -- 감가상각비(공구와기구)
               WHEN 'E' THEN 'DP05'       -- 감가상각비(시설장치)
               WHEN 'F' THEN 'DP06'       -- 감가상각비(비품)
             END AS V_JOB_CATEGORY_CD
        INTO V_JOB_CATEGORY_CD
        FROM FI_ASSET_CATEGORY AC
      WHERE AC.ASSET_CATEGORY_ID        = W_ASSET_CATEGORY_ID
         AND AC.SOB_ID                  = P_SOB_ID
      ;
      SET_DPR_SLIP_INSERT
        ( W_PERIOD_NAME
        , W_ASSET_CATEGORY_ID
        , W_DPR_TYPE
        , P_SOB_ID
        , P_ORG_ID
        , P_CONNECT_PERSON_ID
        , V_JOB_CATEGORY_CD
        , V_DEPT_ID
        , P_USER_ID
        , O_MESSAGE
        );
      
      /*-- 판관.
      SELECT CASE AC.ASSET_CATEGORY_CODE
               WHEN 'A' THEN 'DP02'       -- 감가상각비(건물-판관)
               WHEN 'B' THEN 'DP04'       -- 감가상각비(기계장치-판관)
               WHEN 'C' THEN 'DP06'       -- 감가상각비(차량운반구-판관)
               WHEN 'D' THEN 'DP08'       -- 감가상각비(공구와기구-판관)
               WHEN 'E' THEN 'DP10'       -- 감가상각비(시설장치-판관)
               WHEN 'F' THEN 'DP12'       -- 감가상각비(비품-판관)
             END AS V_JOB_CATEGORY_CD
        INTO V_JOB_CATEGORY_CD
        FROM FI_ASSET_CATEGORY AC
      WHERE AC.ASSET_CATEGORY_ID        = W_ASSET_CATEGORY_ID
         AND AC.SOB_ID                  = P_SOB_ID
      ;          
      SET_DPR_SLIP_INSERT
        ( W_PERIOD_NAME
        , W_ASSET_CATEGORY_ID
        , W_DPR_TYPE
        , P_SOB_ID
        , P_ORG_ID
        , P_CONNECT_PERSON_ID
        , V_JOB_CATEGORY_CD
        , V_DEPT_ID
        , '10'    -- 제조.
        , P_USER_ID
        , O_MESSAGE
        );*/
    EXCEPTION WHEN OTHERS THEN
      ROLLBACK;
      O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
    END;
    COMMIT;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END CREATE_DPR_SLIP;

-- 감가상각전표생성  : 해당월 감가자료 SLIP_YN = 'S' 인 것만 조회해서 생성.
  PROCEDURE SET_DPR_SLIP_INSERT
            ( P_PERIOD_NAME       IN FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE
            , P_ASSET_CATEGORY_ID IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
            , P_DPR_TYPE          IN VARCHAR2
            , P_SOB_ID            IN FI_ASSET_DPR_HISTORY.SOB_ID%TYPE
            , P_ORG_ID            IN FI_ASSET_DPR_HISTORY.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_JOB_CATEGORY_CD   IN VARCHAR2
            , P_DEPT_ID           IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SLIP_HEADER_ID        FI_SLIP_LINE.SLIP_HEADER_ID%TYPE;
    V_SLIP_LINE_ID          FI_SLIP_LINE.SLIP_LINE_ID%TYPE;
    V_SLIP_DATE             FI_SLIP_LINE.SLIP_DATE%TYPE;
    V_SLIP_NUM              FI_SLIP_LINE.SLIP_NUM%TYPE;

    V_SLIP_TYPE             FI_SLIP_LINE.SLIP_TYPE%TYPE;
    V_CURRENCY_CODE         FI_SLIP_LINE.CURRENCY_CODE%TYPE;
    V_CREATED_TYPE          FI_SLIP_HEADER.CREATED_TYPE%TYPE := 'I';
    V_SOURCE_TABLE          FI_SLIP_HEADER.SOURCE_TABLE%TYPE := 'FI_ASSET_DPR_HISTORY';
    V_SLIP_REMARKS          FI_SLIP_HEADER.REMARK%TYPE;
    V_GL_AMOUNT             FI_SLIP_LINE.GL_AMOUNT%TYPE;
  BEGIN
    V_SLIP_DATE := LAST_DAY(TO_DATE(P_PERIOD_NAME, 'YYYY-MM'));  -- 전표일자 : 해당월 말일자.
    V_SLIP_NUM := FI_DOCUMENT_NUM_G.DOCUMENT_NUM_F('GL', P_SOB_ID, V_SLIP_DATE, P_USER_ID);  -- 전표번호 채번.
    V_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID); -- 기본 통화.           
    V_SLIP_TYPE := 'DPR';    -- 전표유형 : 감가상각.
    
    BEGIN
      BEGIN
      -- 자동분개 설정 데이터 존재 체크.
        SELECT DISTINCT JM.SLIP_REMARKS
          INTO V_SLIP_REMARKS
          FROM FI_AUTO_JOURNAL_MST JM
            , FI_AUTO_JOURNAL_DET JD
        WHERE JM.JOB_CATEGORY_CD          = JD.JOB_CATEGORY_CD
          AND JM.SOB_ID                   = JD.SOB_ID
          AND JM.JOB_CATEGORY_CD          = P_JOB_CATEGORY_CD
          AND JM.SOB_ID                   = P_SOB_ID
          AND JD.ACCOUNT_DR_CR            = 1
          AND JM.ENABLED_FLAG             = 'Y'
          AND JD.ENABLED_FLAG             = 'Y'
        ;
      EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10304', NULL));
      END;
      
      -- 전표 헤더 생성.
      FI_SLIP_G.INSERT_SLIP_HEADER
        ( P_SLIP_HEADER_ID      => V_SLIP_HEADER_ID
        , P_SLIP_DATE           => V_SLIP_DATE
        , P_SLIP_NUM            => V_SLIP_NUM
        , P_SOB_ID              => P_SOB_ID
        , P_ORG_ID              => P_ORG_ID
        , P_DEPT_ID             => P_DEPT_ID
        , P_PERSON_ID           => P_CONNECT_PERSON_ID
        , P_BUDGET_DEPT_ID      => NULL
        , P_SLIP_TYPE           => V_SLIP_TYPE
        , P_GL_DATE             => V_SLIP_DATE
        , P_GL_NUM              => V_SLIP_NUM
        , P_REQ_BANK_ACCOUNT_ID => NULL
        , P_REQ_PAYABLE_TYPE    => NULL
        , P_REQ_PAYABLE_DATE    => NULL
        , P_REMARK              => V_SLIP_REMARKS
        , P_USER_ID             => P_USER_ID
        , P_CREATED_TYPE        => V_CREATED_TYPE
        , P_SOURCE_TABLE        => V_SOURCE_TABLE
        , P_SOURCE_HEADER_ID    => NULL
        );
      
      --> 전표 라인 생성 : 차변계정 <--  
      FOR C1 IN ( SELECT JM.SLIP_TYPE_CD
                       , JD.ACCOUNT_CONTROL_ID
                       , JD.ACCOUNT_CODE
                       , JD.ACCOUNT_DR_CR
                       , CASE SUBSTR(JD.ACCOUNT_CODE, 1, 2)
                           WHEN '51' THEN '20'  -- 제조.
                           WHEN '52' THEN '10'  -- 판관.
                           ELSE '00'
                         END AS EXPENSE_TYPE
                       , JD.SLIP_REMARKS
                    FROM FI_AUTO_JOURNAL_MST JM
                      , FI_AUTO_JOURNAL_DET JD
                  WHERE JM.JOB_CATEGORY_CD          = JD.JOB_CATEGORY_CD
                    AND JM.SOB_ID                   = JD.SOB_ID
                    AND JM.JOB_CATEGORY_CD          = P_JOB_CATEGORY_CD
                    AND JM.SOB_ID                   = P_SOB_ID
                    AND JD.ACCOUNT_DR_CR            = 1
                    AND JM.ENABLED_FLAG             = 'Y'
                    AND JD.ENABLED_FLAG             = 'Y'
                )
      LOOP  
        FOR R1 IN ( SELECT AC.ASSET_CATEGORY_NAME
                         , AC.ASSET_CATEGORY_ID
                         , FI_COMMON_G.CODE_NAME_F('DPR_TYPE', ADH.DPR_TYPE, ADH.SOB_ID) AS DPR_TYPE_DESC
                         , ADH.DPR_TYPE
                         , FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', AM.EXPENSE_TYPE, AM.SOB_ID) AS EXPENSE_TYPE_DESC
                         , AM.EXPENSE_TYPE
                         , FI_COMMON_G.COST_CENTER_CODE_F(AM.COST_CENTER_ID) AS CC_CODE
                         , FI_COMMON_G.COST_CENTER_DESC_F(AM.COST_CENTER_ID) AS CC_DESC
                         , ADH.PERIOD_NAME
                         , SUM(ADH.DPR_AMOUNT) AS DPR_AMOUNT
                         , ADH.SOB_ID
                      FROM FI_ASSET_DPR_HISTORY ADH
                        , FI_ASSET_MASTER AM
                        , FI_ASSET_CATEGORY AC
                    WHERE ADH.ASSET_ID                = AM.ASSET_ID
                      AND ADH.SOB_ID                  = AM.SOB_ID
                      AND AM.ASSET_CATEGORY_ID        = AC.ASSET_CATEGORY_ID
                      AND AM.SOB_ID                   = AC.SOB_ID
                      AND ADH.PERIOD_NAME             = P_PERIOD_NAME
                      AND ADH.SOB_ID                  = P_SOB_ID
                      AND ADH.DPR_TYPE                = P_DPR_TYPE
                      AND AM.EXPENSE_TYPE             = C1.EXPENSE_TYPE
                      AND AM.ASSET_CATEGORY_ID        = P_ASSET_CATEGORY_ID
                      AND ADH.DPR_AMOUNT              <> 0
                      AND ADH.SLIP_YN                 = 'S'
                    GROUP BY AC.ASSET_CATEGORY_NAME
                         , AC.ASSET_CATEGORY_ID
                         , FI_COMMON_G.CODE_NAME_F('DPR_TYPE', ADH.DPR_TYPE, ADH.SOB_ID)
                         , ADH.DPR_TYPE
                         , FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', AM.EXPENSE_TYPE, AM.SOB_ID)
                         , AM.EXPENSE_TYPE
                         , FI_COMMON_G.COST_CENTER_CODE_F(AM.COST_CENTER_ID)
                         , FI_COMMON_G.COST_CENTER_DESC_F(AM.COST_CENTER_ID)
                         , ADH.PERIOD_NAME
                         , ADH.SOB_ID
                  )
        LOOP
          FI_SLIP_G.INSERT_SLIP_LINE
            ( P_SLIP_LINE_ID               => V_SLIP_LINE_ID
            , P_SLIP_HEADER_ID             => V_SLIP_HEADER_ID
            , P_SOB_ID                     => P_SOB_ID
            , P_ORG_ID                     => P_ORG_ID
            , P_ACCOUNT_CONTROL_ID         => C1.ACCOUNT_CONTROL_ID
            , P_ACCOUNT_CODE               => C1.ACCOUNT_CODE
            , P_ACCOUNT_DR_CR              => C1.ACCOUNT_DR_CR
            , P_GL_AMOUNT                  => NVL(R1.DPR_AMOUNT, 0)
            , P_CURRENCY_CODE              => V_CURRENCY_CODE
            , P_EXCHANGE_RATE              => NULL
            , P_GL_CURRENCY_AMOUNT         => NULL
            , P_MANAGEMENT1                => R1.CC_CODE
            , P_MANAGEMENT2                => NULL
            , P_REFER1                     => NULL
            , P_REFER2                     => NULL
            , P_REFER3                     => NULL
            , P_REFER4                     => NULL
            , P_REFER5                     => NULL
            , P_REFER6                     => NULL
            , P_REFER7                     => NULL
            , P_REFER8                     => NULL
            , P_REFER9                     => NULL
            , P_REFER10                    => NULL
            , P_REFER11                    => NULL
            , P_REFER12                    => NULL
            , P_REMARK                     => C1.SLIP_REMARKS
            , P_UNLIQUIDATE_SLIP_HEADER_ID => NULL
            , P_UNLIQUIDATE_SLIP_LINE_ID   => NULL
            , P_USER_ID                    => P_USER_ID
            , P_LINE_TYPE                  => V_CREATED_TYPE
            , P_SOURCE_TABLE               => V_SOURCE_TABLE
            , P_SOURCE_HEADER_ID           => NULL
            , P_SOURCE_LINE_ID             => NULL
            );
          V_GL_AMOUNT := NVL(V_GL_AMOUNT, 0) + NVL(R1.DPR_AMOUNT, 0);  
          
          /* -- 자산대장 UPDATE */
          UPDATE FI_ASSET_MASTER AM
            SET AM.DPR_SUM_AMOUNT       = DECODE(R1.DPR_TYPE, '10', NVL(AM.DPR_SUM_AMOUNT, 0) + NVL(R1.DPR_AMOUNT, 0), AM.DPR_SUM_AMOUNT)
              , AM.DPR_TOTAL_COUNT      = DECODE(R1.DPR_TYPE, '10', NVL(AM.DPR_TOTAL_COUNT, 0) + 1, AM.DPR_TOTAL_COUNT)
              , AM.DPR_LAST_PERIOD      = DECODE(R1.DPR_TYPE, '10', R1.PERIOD_NAME, AM.DPR_LAST_PERIOD)
              , AM.IFRS_DPR_SUM_AMOUNT  = DECODE(R1.DPR_TYPE, '20', NVL(AM.IFRS_DPR_SUM_AMOUNT, 0) + NVL(R1.DPR_AMOUNT, 0), AM.IFRS_DPR_SUM_AMOUNT)
              , AM.IFRS_DPR_TOTAL_COUNT = DECODE(R1.DPR_TYPE, '20', NVL(AM.IFRS_DPR_TOTAL_COUNT, 0) + 1, AM.IFRS_DPR_TOTAL_COUNT)
              , AM.IFRS_DPR_LAST_PERIOD = DECODE(R1.DPR_TYPE, '20', R1.PERIOD_NAME, AM.IFRS_DPR_LAST_PERIOD)
          WHERE AM.SOB_ID             = R1.SOB_ID
            AND AM.EXPENSE_TYPE       = R1.EXPENSE_TYPE
            AND AM.ASSET_CATEGORY_ID  = R1.ASSET_CATEGORY_ID
            AND EXISTS
                  ( SELECT 'X'
                      FROM FI_ASSET_DPR_HISTORY ADH
                    WHERE ADH.ASSET_ID                = AM.ASSET_ID
                      AND ADH.SOB_ID                  = AM.SOB_ID
                      AND ADH.PERIOD_NAME             = R1.PERIOD_NAME
                      AND ADH.SOB_ID                  = R1.SOB_ID
                      AND ADH.DPR_TYPE                = R1.DPR_TYPE
                      AND ADH.DPR_AMOUNT              <> 0
                      AND ADH.SLIP_YN                 = 'S'
                  )
          ;
          
          /* -- 감가상각 HISTORY UPDATE */
          UPDATE FI_ASSET_DPR_HISTORY ADH
            SET ADH.ASSET_MASTER_YN   = 'Y'
              , ADH.SLIP_YN           = 'Y'
              , ADH.SLIP_DATE         = V_SLIP_DATE
              , ADH.SLIP_LINE_ID      = V_SLIP_LINE_ID
              , ADH.SLIP_HEADER_ID    = V_SLIP_HEADER_ID
              , ADH.GL_NUM            = V_SLIP_NUM      
          WHERE ADH.PERIOD_NAME       = R1.PERIOD_NAME
            AND ADH.SOB_ID            = R1.SOB_ID
            AND ADH.DPR_TYPE          = R1.DPR_TYPE
            AND ADH.ASSET_CATEGORY_ID = R1.ASSET_CATEGORY_ID
            AND ADH.DPR_AMOUNT        <> 0
            AND ADH.SLIP_YN           = 'S'
            AND EXISTS 
                  ( SELECT 'X'
                      FROM FI_ASSET_MASTER AM
                    WHERE AM.ASSET_ID     = ADH.ASSET_ID
                      AND AM.EXPENSE_TYPE = R1.EXPENSE_TYPE
                      AND AM.SOB_ID       = R1.SOB_ID
                  )
          ;       
        END LOOP R1;
      END LOOP C1;
      
      --> 전표 라인 생성 : 대변계정 <--  
      FOR C1 IN ( SELECT JM.SLIP_TYPE_CD
                       , JD.ACCOUNT_CONTROL_ID
                       , JD.ACCOUNT_CODE
                       , JD.ACCOUNT_DR_CR
                       , CASE SUBSTR(JD.ACCOUNT_CODE, 1, 2)
                           WHEN '51' THEN '20'  -- 제조.
                           WHEN '52' THEN '10'  -- 판관.
                           ELSE '00'
                         END AS EXPENSE_TYPE
                       , JD.SLIP_REMARKS
                    FROM FI_AUTO_JOURNAL_MST JM
                      , FI_AUTO_JOURNAL_DET JD
                  WHERE JM.JOB_CATEGORY_CD          = JD.JOB_CATEGORY_CD
                    AND JM.SOB_ID                   = JD.SOB_ID
                    AND JM.JOB_CATEGORY_CD          = P_JOB_CATEGORY_CD
                    AND JM.SOB_ID                   = P_SOB_ID
                    AND JD.ACCOUNT_DR_CR            = 2
                    AND JM.ENABLED_FLAG             = 'Y'
                    AND JD.ENABLED_FLAG             = 'Y'
                )
      LOOP  
        FI_SLIP_G.INSERT_SLIP_LINE
          ( P_SLIP_LINE_ID               => V_SLIP_LINE_ID
          , P_SLIP_HEADER_ID             => V_SLIP_HEADER_ID
          , P_SOB_ID                     => P_SOB_ID
          , P_ORG_ID                     => P_ORG_ID
          , P_ACCOUNT_CONTROL_ID         => C1.ACCOUNT_CONTROL_ID
          , P_ACCOUNT_CODE               => C1.ACCOUNT_CODE
          , P_ACCOUNT_DR_CR              => C1.ACCOUNT_DR_CR
          , P_GL_AMOUNT                  => NVL(V_GL_AMOUNT, 0)
          , P_CURRENCY_CODE              => V_CURRENCY_CODE
          , P_EXCHANGE_RATE              => NULL
          , P_GL_CURRENCY_AMOUNT         => NULL
          , P_MANAGEMENT1                => NULL
          , P_MANAGEMENT2                => NULL
          , P_REFER1                     => NULL
          , P_REFER2                     => NULL
          , P_REFER3                     => NULL
          , P_REFER4                     => NULL
          , P_REFER5                     => NULL
          , P_REFER6                     => NULL
          , P_REFER7                     => NULL
          , P_REFER8                     => NULL
          , P_REFER9                     => NULL
          , P_REFER10                    => NULL
          , P_REFER11                    => NULL
          , P_REFER12                    => NULL
          , P_REMARK                     => C1.SLIP_REMARKS
          , P_UNLIQUIDATE_SLIP_HEADER_ID => NULL
          , P_UNLIQUIDATE_SLIP_LINE_ID   => NULL
          , P_USER_ID                    => P_USER_ID
          , P_LINE_TYPE                  => V_CREATED_TYPE
          , P_SOURCE_TABLE               => V_SOURCE_TABLE
          , P_SOURCE_HEADER_ID           => NULL
          , P_SOURCE_LINE_ID             => NULL
          );
      END LOOP C1;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
    END;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END SET_DPR_SLIP_INSERT;
  
END FI_DPR_G;
/
