create or replace package FI_BANKING_ACCOUNT_SUM_LIST_G is
--==============================================================================
-- Project      : FLEX ERP
-- Module       : FCMF
-- Program Name : FI_BANKING_ACCOUNT_SUM_LIST_G
-- Description  : 금융기관 계좌별 잔액 조회.
--
-- Reference by : 전표 라인정보는 FI_SLIP_G.SELECT_SLIP_LINE_ACCOUNT_ID에서 처리함.
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 26-NOV-2010  Sung Kil Te        Initialize
--==============================================================================
---------------------------------------------------------------------------------------------------
-- 전표 라인 조회.
  PROCEDURE SELECT_SLIP_LINE
            ( P_CURSOR1            OUT TYPES.TCURSOR1
            , W_SOB_ID             IN FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID             IN FI_SLIP_LINE.ORG_ID%TYPE
            , W_GL_DATE_FR         IN FI_SLIP_LINE.GL_DATE%TYPE
            , W_GL_DATE_TO         IN FI_SLIP_LINE.GL_DATE%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE
            , W_BANK_ACCOUNT_ID    IN FI_DAILY_BANK_ACCOUNT_SUM.BANK_ACCOUNT_ID%TYPE
            );

  PROCEDURE SELECT_BANKING_ACCOUNT_SUM
            ( P_CURSOR              OUT TYPES.TCURSOR
            , W_SOB_ID              IN FI_DAILY_BANK_ACCOUNT_SUM.SOB_ID%TYPE
            , W_ORG_ID              IN FI_DAILY_BANK_ACCOUNT_SUM.ORG_ID%TYPE
            , W_GL_DATE_FR          IN FI_DAILY_BANK_ACCOUNT_SUM.GL_DATE%TYPE
            , W_GL_DATE_TO          IN FI_DAILY_BANK_ACCOUNT_SUM.GL_DATE%TYPE
            , W_ACCOUNT_CODE        IN FI_DAILY_BANK_ACCOUNT_SUM.ACCOUNT_CODE%TYPE
            );


  PROCEDURE BANKING_ACCOUNT_SUM_SELECT1( P_CURSOR              OUT TYPES.TCURSOR
                                      , W_SOB_ID              IN  FI_DAILY_BANK_ACCOUNT_SUM.SOB_ID%TYPE
                                      , W_ORG_ID              IN  FI_DAILY_BANK_ACCOUNT_SUM.ORG_ID%TYPE
                                      , W_PERIOD_FROM         IN  FI_DAILY_BANK_ACCOUNT_SUM.GL_DATE%TYPE
                                      , W_PERIOD_TO           IN  FI_DAILY_BANK_ACCOUNT_SUM.GL_DATE%TYPE
                                      );

end FI_BANKING_ACCOUNT_SUM_LIST_G; 
/
create or replace package body FI_BANKING_ACCOUNT_SUM_LIST_G is
--==============================================================================
-- Project      : FLEX ERP
-- Module       : FCMF
-- Program Name : FI_BANKING_ACCOUNT_SUM_LIST_G
-- Description  : 금융기관 계좌별 잔액 조회.
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 26-NOV-2010  Sung Kil Te        Initialize
--==============================================================================

-- 전표 라인 조회.
  PROCEDURE SELECT_SLIP_LINE
            ( P_CURSOR1            OUT TYPES.TCURSOR1
            , W_SOB_ID             IN FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID             IN FI_SLIP_LINE.ORG_ID%TYPE
            , W_GL_DATE_FR         IN FI_SLIP_LINE.GL_DATE%TYPE
            , W_GL_DATE_TO         IN FI_SLIP_LINE.GL_DATE%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE
            , W_BANK_ACCOUNT_ID    IN FI_DAILY_BANK_ACCOUNT_SUM.BANK_ACCOUNT_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT SL.GL_DATE
           , SL.SLIP_NUM
           , SL.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , NULL AS CUSTOMER_NAME  -- SMV.CUSTOMER_NAME
           , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) AS DR_AMOUNT
           , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) AS CR_AMOUNT
           , SL.REMARK
           , SL.ACCOUNT_CONTROL_ID
           , SL.SLIP_HEADER_ID
        FROM FI_SLIP_LINE SL
          , FI_ACCOUNT_CONTROL AC
          , FI_SLIP_MGMT_VENDOR_V SMV
          , FI_SLIP_MGMT_BANK_ACCOUNT_V MBA
      WHERE SL.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
        AND SL.SLIP_LINE_ID             = SMV.SLIP_LINE_ID(+)
        AND SL.SLIP_LINE_ID             = MBA.SLIP_LINE_ID
        AND SL.GL_DATE                  BETWEEN W_GL_DATE_FR AND W_GL_DATE_TO
        AND SL.ACCOUNT_CONTROL_ID       = W_ACCOUNT_CONTROL_ID
        AND SL.SOB_ID                   = W_SOB_ID
        AND MBA.BANK_ACCOUNT_ID         = W_BANK_ACCOUNT_ID
      ORDER BY SL.GL_DATE
      ;

  END SELECT_SLIP_LINE;

  PROCEDURE SELECT_BANKING_ACCOUNT_SUM
            ( P_CURSOR              OUT TYPES.TCURSOR
            , W_SOB_ID              IN FI_DAILY_BANK_ACCOUNT_SUM.SOB_ID%TYPE
            , W_ORG_ID              IN FI_DAILY_BANK_ACCOUNT_SUM.ORG_ID%TYPE
            , W_GL_DATE_FR          IN FI_DAILY_BANK_ACCOUNT_SUM.GL_DATE%TYPE
            , W_GL_DATE_TO          IN FI_DAILY_BANK_ACCOUNT_SUM.GL_DATE%TYPE
            , W_ACCOUNT_CODE        IN FI_DAILY_BANK_ACCOUNT_SUM.ACCOUNT_CODE%TYPE
            )
  AS
  BEGIN
    BEGIN
      -- 이월자료 생성.
      DELETE FROM FI_BALANCE_OVER_GT
      ;

      -- 이월 잔액 산출.
      INSERT INTO FI_BALANCE_OVER_GT
      ( ACCOUNT_CODE
      , ACCOUNT_DESC
      , REMARK
      , REMAIN_AMOUNT
      , BANK_ACCOUNT_ID
      , ACCOUNT_CONTROL_ID
      )
      SELECT FAC.ACCOUNT_CODE
           , FAC.ACCOUNT_DESC
           , EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10165', NULL) AS REMARK
           , NVL(SUM(PX1.BEFORE_AMOUNT), 0) AS BEFORE_AMOUNT
           , PX1.BANK_ACCOUNT_ID
           , FAC.ACCOUNT_CONTROL_ID
        FROM FI_ACCOUNT_CONTROL FAC
          , ( SELECT DBA.ACCOUNT_CONTROL_ID
                   , DBA.ACCOUNT_CODE
                   , AC.ACCOUNT_DR_CR      -- 잔액 구분.
                   , DBA.BANK_ACCOUNT_ID
                   , CASE
                       WHEN AC.ACCOUNT_DR_CR = '1' THEN NVL(DBA.DR_AMOUNT, 0) - NVL(DBA.CR_AMOUNT, 0)
                       WHEN AC.ACCOUNT_DR_CR = '2' THEN NVL(DBA.CR_AMOUNT, 0) - NVL(DBA.DR_AMOUNT, 0)
                     END  AS BEFORE_AMOUNT
                FROM FI_DAILY_BANK_ACCOUNT_SUM  DBA
                  , FI_ACCOUNT_CONTROL AC
               WHERE DBA.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
                 AND DBA.GL_DATE               = TRUNC(W_GL_DATE_FR, 'MONTH')
                 AND DBA.GL_DATE_SEQ           = 0
                 AND DBA.SOB_ID                = W_SOB_ID
                 AND DBA.ACCOUNT_CODE          = NVL(W_ACCOUNT_CODE, DBA.ACCOUNT_CODE)
              UNION ALL
              -- 1일 ~ 시작(GL_DATE_FR-1) 전일까지의 잔액금액 계산.
              SELECT DBA.ACCOUNT_CONTROL_ID
                   , DBA.ACCOUNT_CODE
                   , AC.ACCOUNT_DR_CR
                   , DBA.BANK_ACCOUNT_ID
                   , CASE
                       WHEN AC.ACCOUNT_DR_CR = '1' THEN NVL(DBA.DR_AMOUNT, 0) - NVL(DBA.CR_AMOUNT, 0)
                       WHEN AC.ACCOUNT_DR_CR = '2' THEN NVL(DBA.CR_AMOUNT, 0) - NVL(DBA.DR_AMOUNT, 0)
                     END AS BEFORE_AMOUNT
                FROM FI_DAILY_BANK_ACCOUNT_SUM  DBA
                  , FI_ACCOUNT_CONTROL AC
               WHERE DBA.ACCOUNT_CONTROL_ID   = AC.ACCOUNT_CONTROL_ID
                 AND DBA.SOB_ID               = W_SOB_ID
                 AND DBA.GL_DATE              BETWEEN TRUNC(W_GL_DATE_FR, 'MONTH') AND W_GL_DATE_FR - 1
                 AND DBA.GL_DATE_SEQ          = 1
                 AND DBA.ACCOUNT_BOOK_ID      = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(W_SOB_ID)
                 AND DBA.ACCOUNT_CODE         = NVL(W_ACCOUNT_CODE, DBA.ACCOUNT_CODE)
              ) PX1
      WHERE FAC.ACCOUNT_CONTROL_ID            = PX1.ACCOUNT_CONTROL_ID(+)
        AND FAC.ACCOUNT_CODE                  = NVL(W_ACCOUNT_CODE, FAC.ACCOUNT_CODE)
      GROUP BY FAC.ACCOUNT_CONTROL_ID
           , FAC.ACCOUNT_CODE
           , FAC.ACCOUNT_DESC
           , PX1.BANK_ACCOUNT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;

    OPEN P_CURSOR FOR
      SELECT FI_COMMON_G.CODE_NAME_F('BANK_TYPE', FB.BANK_TYPE, FB.SOB_ID) AS BANK_TYPE_NAME
           , BA.BANK_ACCOUNT_NAME
           , BA.BANK_ACCOUNT_NUM
           , AC.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , BA.CURRENCY_CODE
           , NVL(SUM(SX1.BEF_DR_AMOUNT), 0) AS BEF_DR_AMOUNT       --이월원화 (Before Amount)
           , NVL(SUM(SX1.BEF_DR_CURR_AMOUNT), 0) AS BEF_DR_CURR_AMOUNT  --이월외화(Before Currency Amount)
           , NVL(SUM(SX1.DR_AMOUNT), 0) AS DR_AMOUNT          --당월차변(This Debit Amount)
           , NVL(SUM(SX1.CR_AMOUNT), 0) AS CR_AMOUNT           --당월차변외화(This Currency Debit Amount)
           , NVL(SUM(SX1.DR_CURR_AMOUNT), 0) AS DR_CURR_AMOUNT      --당월대변(This Credit Amount)
           , NVL(SUM(SX1.CR_CURR_AMOUNT), 0) AS CR_CURR_AMOUNT      --당월대변외화(This Currency Credit Amount)
           , NVL(SUM(NVL(SX1.BEF_DR_AMOUNT, 0) + NVL(SX1.REMAIN_AMOUNT, 0)), 0) AS REMAIN_AMOUNT       --잔액금액(원화) Remain Aamount )
           , NVL(SUM(SX1.REMAIN_CURR_AMOUNT), 0) AS REMAIN_CURR_AMOUNT  --잔액금액(외화) Remain Currency Amount)
           , AC.ACCOUNT_CONTROL_ID
           , BA.BANK_ACCOUNT_ID
        FROM FI_ACCOUNT_CONTROL AC
           , FI_BANK_ACCOUNT BA
           , FI_BANK FB
           , ( SELECT BOG.ACCOUNT_CONTROL_ID
                   , BOG.BANK_ACCOUNT_ID
                   , NVL(BOG.REMAIN_AMOUNT, 0) AS BEF_DR_AMOUNT       --이월원화 (Before Amount)
                   , 0 AS BEF_DR_CURR_AMOUNT  --이월외화(Before Currency Amount)
                   , 0 AS DR_AMOUNT           --당월차변(This Debit Amount)
                   , 0 AS CR_AMOUNT           --당월차변외화(This Currency Debit Amount)
                   , 0 AS DR_CURR_AMOUNT      --당월대변(This Credit Amount)
                   , 0 AS CR_CURR_AMOUNT      --당월대변외화(This Currency Credit Amount)
                   , 0 AS REMAIN_AMOUNT       --잔액금액(원화) Remain Aamount )
                   , 0 AS REMAIN_CURR_AMOUNT  --잔액금액(외화) Remain Currency Amount)
                FROM FI_BALANCE_OVER_GT BOG
               WHERE BOG.ACCOUNT_CODE           = NVL(W_ACCOUNT_CODE, BOG.ACCOUNT_CODE)
               ---------
               UNION ALL
               ---------
               SELECT DBA.ACCOUNT_CONTROL_ID
                   , DBA.BANK_ACCOUNT_ID
                   , 0 AS BEF_DR_AMOUNT       --이월원화 (Before Amount)
                   , SUM(DECODE(DBA.GL_DATE_SEQ, 0, DBA.DR_CURR_AMOUNT, 0))
                     - SUM(DECODE(DBA.GL_DATE_SEQ, 0, DBA.CR_CURR_AMOUNT, 0)) AS BEF_DR_CURR_AMOUNT  --이월외화(Before Currency Amount)
                   , SUM(DECODE(DBA.GL_DATE_SEQ, 0, 0, DBA.DR_AMOUNT)) AS DR_AMOUNT           --당월차변(This Debit Amount)
                   , SUM(DECODE(DBA.GL_DATE_SEQ, 0, 0, DBA.CR_AMOUNT)) AS CR_AMOUNT           --당월차변외화(This Currency Debit Amount)
                   , SUM(DECODE(DBA.GL_DATE_SEQ, 0, 0, DBA.DR_CURR_AMOUNT)) AS DR_CURR_AMOUNT      --당월대변(This Credit Amount)
                   , SUM(DECODE(DBA.GL_DATE_SEQ, 0, 0, DBA.CR_CURR_AMOUNT)) AS CR_CURR_AMOUNT      --당월대변외화(This Currency Credit Amount)
                   , SUM(DECODE(DBA.GL_DATE_SEQ, 0, DBA.DR_AMOUNT, 0))
                      + SUM(DECODE(DBA.GL_DATE_SEQ, 0, 0, DBA.DR_AMOUNT))
                      - (SUM(DECODE(DBA.GL_DATE_SEQ, 0, DBA.CR_AMOUNT, 0))
                      + SUM(DECODE(DBA.GL_DATE_SEQ, 0, 0, DBA.CR_AMOUNT))) AS REMAIN_AMOUNT       --잔액금액(원화) Remain Aamount )
                   , SUM(DECODE(DBA.GL_DATE_SEQ, 0, DBA.DR_CURR_AMOUNT, 0))
                      + SUM(DECODE(DBA.GL_DATE_SEQ, 0, 0, DBA.DR_CURR_AMOUNT))
                      - (SUM(DECODE(DBA.GL_DATE_SEQ, 0, DBA.CR_CURR_AMOUNT, 0))
                      + SUM(DECODE(DBA.GL_DATE_SEQ, 0, 0, DBA.CR_CURR_AMOUNT))) AS  REMAIN_CURR_AMOUNT  --잔액금액(외화) Remain Currency Amount)
                FROM FI_DAILY_BANK_ACCOUNT_SUM  DBA
               WHERE DBA.SOB_ID                 = W_SOB_ID
                 AND DBA.GL_DATE                BETWEEN W_GL_DATE_FR   AND W_GL_DATE_TO
                 AND DBA.GL_DATE_SEQ            = 1
                 AND DBA.ACCOUNT_CODE           = NVL(W_ACCOUNT_CODE, DBA.ACCOUNT_CODE)
              GROUP BY DBA.ACCOUNT_CONTROL_ID
                   , DBA.BANK_ACCOUNT_ID
             ) SX1
      WHERE SX1.ACCOUNT_CONTROL_ID            = AC.ACCOUNT_CONTROL_ID
        AND SX1.BANK_ACCOUNT_ID               = BA.BANK_ACCOUNT_ID
        AND BA.BANK_ID                        = FB.BANK_ID
        AND AC.ACCOUNT_CODE                   = NVL(W_ACCOUNT_CODE, AC.ACCOUNT_CODE)
      GROUP BY FI_COMMON_G.CODE_NAME_F('BANK_TYPE', FB.BANK_TYPE, FB.SOB_ID)
           , BA.BANK_ACCOUNT_NAME
           , BA.BANK_ACCOUNT_NUM
           , AC.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , BA.CURRENCY_CODE
           , AC.ACCOUNT_CONTROL_ID
           , BA.BANK_ACCOUNT_ID
    ;

    /*OPEN P_CURSOR FOR
      SELECT FI_COMMON_G.CODE_NAME_F('BANK_TYPE', FB.BANK_TYPE, FB.SOB_ID) AS BANK_TYPE_NAME
           , BA.BANK_ACCOUNT_NAME
           , BA.BANK_ACCOUNT_NUM
           , AC.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , BA.CURRENCY_CODE
           , SUM(DECODE(DBA.GL_DATE_SEQ, 0, DBA.DR_AMOUNT, 0))
             - SUM(DECODE(DBA.GL_DATE_SEQ, 0, DBA.CR_AMOUNT, 0)) AS BEF_DR_AMOUNT       --이월원화 (Before Amount)
           , SUM(DECODE(DBA.GL_DATE_SEQ, 0, DBA.DR_CURR_AMOUNT, 0))
             - SUM(DECODE(DBA.GL_DATE_SEQ, 0, DBA.CR_CURR_AMOUNT, 0)) AS BEF_DR_CURR_AMOUNT  --이월외화(Before Currency Amount)
           , SUM(DECODE(DBA.GL_DATE_SEQ, 0, 0, DBA.DR_AMOUNT)) AS DR_AMOUNT           --당월차변(This Debit Amount)
           , SUM(DECODE(DBA.GL_DATE_SEQ, 0, 0, DBA.CR_AMOUNT)) AS CR_AMOUNT           --당월차변외화(This Currency Debit Amount)
           , SUM(DECODE(DBA.GL_DATE_SEQ, 0, 0, DBA.DR_CURR_AMOUNT)) AS DR_CURR_AMOUNT      --당월대변(This Credit Amount)
           , SUM(DECODE(DBA.GL_DATE_SEQ, 0, 0, DBA.CR_CURR_AMOUNT)) AS CR_CURR_AMOUNT      --당월대변외화(This Currency Credit Amount)
           , SUM(DECODE(DBA.GL_DATE_SEQ, 0, DBA.DR_AMOUNT, 0))
              + SUM(DECODE(DBA.GL_DATE_SEQ, 0, 0, DBA.DR_AMOUNT))
              - (SUM(DECODE(DBA.GL_DATE_SEQ, 0, DBA.CR_AMOUNT, 0))
              + SUM(DECODE(DBA.GL_DATE_SEQ, 0, 0, DBA.CR_AMOUNT))) AS REMARIN_AMOUNT       --잔액금액(원화) Remain Aamount )
           , SUM(DECODE(DBA.GL_DATE_SEQ, 0, DBA.DR_CURR_AMOUNT, 0))
              + SUM(DECODE(DBA.GL_DATE_SEQ, 0, 0, DBA.DR_CURR_AMOUNT))
              - (SUM(DECODE(DBA.GL_DATE_SEQ, 0, DBA.CR_CURR_AMOUNT, 0))
              + SUM(DECODE(DBA.GL_DATE_SEQ, 0, 0, DBA.CR_CURR_AMOUNT))) AS  REMAIN_CURR_AMOUNT  --잔액금액(외화) Remain Currency Amount)
        FROM FI_DAILY_BANK_ACCOUNT_SUM  DBA
           , FI_BANK_ACCOUNT            BA
           , FI_BANK                    FB
           , FI_ACCOUNT_CONTROL         AC
       WHERE DBA.BANK_ACCOUNT_ID        = BA.BANK_ACCOUNT_ID(+)
         AND BA.BANK_ID                 = FB.BANK_ID(+)
         AND DBA.ACCOUNT_CONTROL_ID     = AC.ACCOUNT_CONTROL_ID
         AND EXISTS ( SELECT 'X'
                        FROM FI_COMMON FC
                      WHERE FC.GROUP_CODE         = 'GL_TYPE'
                        AND FC.COMMON_ID          = AC.ACCOUNT_GL_ID
                        AND FC.SOB_ID             = AC.SOB_ID
                        AND FC.CODE               = '1004'              -- 1004:예적금원장관리항목
                    )
\*         AND FDBAS.ACCOUNT_CODE IN  (  SELECT FAC.ACCOUNT_CODE
                                          FROM FI_ACCOUNT_CONTROL    FAC
                                             , FI_COMMON             FC
                                         WHERE FAC.ACCOUNT_GL_ID  =  FC.COMMON_ID
                                           AND FAC.SOB_ID         =  FC.SOB_ID
                                           AND FC.CODE            = '1004'
                                     )*\
         AND DBA.SOB_ID                 =  W_SOB_ID
         AND DBA.GL_DATE                BETWEEN W_GL_DATE_FR   AND W_GL_DATE_TO
         AND DBA.ACCOUNT_CODE           = NVL(W_ACCOUNT_CODE, DBA.ACCOUNT_CODE)
    GROUP BY FI_COMMON_G.CODE_NAME_F('BANK_TYPE', FB.BANK_TYPE, FB.SOB_ID)
           , BA.BANK_ACCOUNT_NAME
           , BA.BANK_ACCOUNT_NUM
           , AC.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , BA.CURRENCY_CODE
    ;*/

  END SELECT_BANKING_ACCOUNT_SUM;


       PROCEDURE BANKING_ACCOUNT_SUM_SELECT1( P_CURSOR              OUT TYPES.TCURSOR
                                            , W_SOB_ID              IN  FI_DAILY_BANK_ACCOUNT_SUM.SOB_ID%TYPE
                                            , W_ORG_ID              IN  FI_DAILY_BANK_ACCOUNT_SUM.ORG_ID%TYPE
                                            , W_PERIOD_FROM         IN  FI_DAILY_BANK_ACCOUNT_SUM.GL_DATE%TYPE
                                            , W_PERIOD_TO           IN  FI_DAILY_BANK_ACCOUNT_SUM.GL_DATE%TYPE
                                            )

       IS

       BEGIN

                OPEN P_CURSOR FOR
                SELECT FCV.CODE_NAME                                                    AS  CODE_NAME           --유형(Bank Type)
                     , FBA.BANK_ACCOUNT_NUM                                             AS  BANK_ACCOUNT_NUM    --계좌번호(Bank Account Number)
                     , FAC.ACCOUNT_DESC                                                 AS  ACCOUNT_DESC        --계정명(Account Code Name)
                     , FBA.CURRENCY_CODE                                                AS  CURRENCY_CODE       --통화(Currency Code)
                     , SUM(DECODE(FDBAS.GL_DATE_SEQ,0, FDBAS.DR_AMOUNT,0))
                    -  SUM(DECODE(FDBAS.GL_DATE_SEQ,0, FDBAS.CR_AMOUNT,0))              AS  TOT_DR_AMOUNT       --이월원화 (Before Amount)

                     , SUM(DECODE(FDBAS.GL_DATE_SEQ,0, FDBAS.DR_CURR_AMOUNT,0))
                    -  SUM(DECODE(FDBAS.GL_DATE_SEQ,0, FDBAS.CR_CURR_AMOUNT,0))         AS  TOT_DR_CURR_AMOUNT  --이월외화(Before Currency Amount)

                     , SUM(DECODE(FDBAS.GL_DATE_SEQ,0, 0, FDBAS.DR_AMOUNT))             AS  DR_AMOUNT           --당월차변(This Debit Amount)
                     , SUM(DECODE(FDBAS.GL_DATE_SEQ,0, 0, FDBAS.CR_AMOUNT))             AS  CR_AMOUNT           --당월차변외화(This Currency Debit Amount)
                     , SUM(DECODE(FDBAS.GL_DATE_SEQ,0, 0, FDBAS.DR_CURR_AMOUNT))        AS  DR_CURR_AMOUNT      --당월대변(This Credit Amount)
                     , SUM(DECODE(FDBAS.GL_DATE_SEQ,0, 0, FDBAS.CR_CURR_AMOUNT))        AS  CR_CURR_AMOUNT      --당월대변외화(This Currency Credit Amount)

                     , SUM(DECODE(FDBAS.GL_DATE_SEQ,0, FDBAS.DR_AMOUNT,0))
                    +  SUM(DECODE(FDBAS.GL_DATE_SEQ,0, 0, FDBAS.DR_AMOUNT))
                    - (SUM(DECODE(FDBAS.GL_DATE_SEQ,0, FDBAS.CR_AMOUNT,0))
                    +  SUM(DECODE(FDBAS.GL_DATE_SEQ,0, 0, FDBAS.CR_AMOUNT)))            AS REMARIN_AMOUNT       --잔액금액(원화) Remain Aamount )

                     , SUM(DECODE(FDBAS.GL_DATE_SEQ,0, FDBAS.DR_CURR_AMOUNT,0))
                    +  SUM(DECODE(FDBAS.GL_DATE_SEQ,0, 0, FDBAS.DR_CURR_AMOUNT))
                    - (SUM(DECODE(FDBAS.GL_DATE_SEQ,0, FDBAS.CR_CURR_AMOUNT,0))
                    +  SUM(DECODE(FDBAS.GL_DATE_SEQ,0, 0, FDBAS.CR_CURR_AMOUNT)))       AS  REMAIN_CURR_AMOUNT  --잔액금액(외화) Remain Currency Amount)
                  FROM FI_DAILY_BANK_ACCOUNT_SUM  FDBAS
                     , FI_BANK_ACCOUNT            FBA
                     , FI_BANK                    FB
                     , FI_ACCOUNT_CONTROL         FAC
                     ,(SELECT FC.CODE
                            , FC.CODE_NAME
                            , FC.SOB_ID
                         FROM FI_COMMON           FC
                        WHERE FC.GROUP_CODE    = 'BANK_TYPE'
                          AND FC.SOB_ID        =  W_SOB_ID
                      )                           FCV    --금융기관유형(1:은행 2:단자 3:리스..)
                 WHERE FBA.BANK_ACCOUNT_ID(+)  =  FDBAS.BANK_ACCOUNT_ID
                   AND FB.BANK_ID(+)           =  FBA.BANK_ID
                   AND FAC.ACCOUNT_CODE(+)     =  FDBAS.ACCOUNT_CODE
                   AND FCV.CODE(+)             =  FB.BANK_TYPE
                   AND FBA.SOB_ID(+)           =  FDBAS.SOB_ID
                   AND FB.SOB_ID(+)            =  FBA.SOB_ID
                   AND FAC.SOB_ID(+)           =  FDBAS.SOB_ID
                   AND FCV.SOB_ID(+)           =  FB.SOB_ID
                   /*AND FDBAS.ACCOUNT_CODE IN  (  SELECT FAC.ACCOUNT_CODE
                                                    FROM FI_ACCOUNT_CONTROL    FAC
                                                       , FI_COMMON             FC
                                                   WHERE FAC.ACCOUNT_GL_ID  =  FC.COMMON_ID
                                                     AND FAC.SOB_ID         =  FC.SOB_ID
                                                     AND FC.CODE            = '1004'
                                               )  -- 1004:예적금원장관리항목*/
                   AND FDBAS.SOB_ID            =  W_SOB_ID
                   AND FDBAS.GL_DATE      BETWEEN W_PERIOD_FROM   AND  W_PERIOD_TO
              GROUP BY FCV.CODE_NAME
                     , FBA.BANK_ACCOUNT_NUM
                     , FAC.ACCOUNT_DESC
                     , FBA.CURRENCY_CODE
                     ;


       END;


end FI_BANKING_ACCOUNT_SUM_LIST_G; 
/
