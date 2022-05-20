create or replace package FI_MONTH_ACCOUNT_SUM_LIST_G is
--==============================================================================
-- Project      : FLEX ERP
-- Module       : FCMF
-- Program Name : FI_MONTH_ACCOUNT_SUM_LIST_G
-- Description  : Packing Box Define
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 27-NOV-2010  Sung Kil Te        Initialize
--==============================================================================

       PROCEDURE MONTH_ACCOUNT_SUM_SELECT1( P_CURSOR                OUT TYPES.TCURSOR
                                          , W_SOB_ID                IN  FI_SLIP_LINE.SOB_ID%TYPE
                                          , W_ORG_ID                IN  FI_SLIP_LINE.ORG_ID%TYPE
                                          , W_PERIOD_FROM           IN  FI_SLIP_LINE.GL_DATE%TYPE
                                          , W_PERIOD_TO             IN  FI_SLIP_LINE.GL_DATE%TYPE
                                          );

end FI_MONTH_ACCOUNT_SUM_LIST_G;

 
/
create or replace package body FI_MONTH_ACCOUNT_SUM_LIST_G is
--==============================================================================
-- Project      : FLEX ERP
-- Module       : FCMF
-- Program Name : FI_MONTH_ACCOUNT_SUM_LIST_G
-- Description  : Packing Box Define
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 27-NOV-2010  Sung Kil Te        Initialize
--==============================================================================


       PROCEDURE MONTH_ACCOUNT_SUM_SELECT1( P_CURSOR                OUT TYPES.TCURSOR
                                          , W_SOB_ID                IN  FI_SLIP_LINE.SOB_ID%TYPE
                                          , W_ORG_ID                IN  FI_SLIP_LINE.ORG_ID%TYPE
                                          , W_PERIOD_FROM           IN  FI_SLIP_LINE.GL_DATE%TYPE
                                          , W_PERIOD_TO             IN  FI_SLIP_LINE.GL_DATE%TYPE
                                          )

       IS

       BEGIN

                OPEN P_CURSOR FOR
                SELECT SUM(FAS.DR_AMOUNT)                                                 AS  DR_AMOUNT     -- 차변금액(Debit Amount)
                     , DECODE(GROUPING_ID(FAS.ACCOUNT_DESC), 1, '총계', FAS.ACCOUNT_DESC) AS  ACCOUNT_CODE  -- 계정코드(Account Code)
                     , SUM(FAS.CR_AMOUNT)                                                 AS  CR_AMOUNT     -- 대변금액(Credit Amount)
                  FROM ( SELECT DECODE(SLI.ACCOUNT_DR_CR, '1', SLI.GL_AMOUNT, 0)          AS  DR_AMOUNT
                              , '[' || FAC.ACCOUNT_CODE || '] ' || FAC.ACCOUNT_DESC        AS  ACCOUNT_DESC
                              , DECODE(SLI.ACCOUNT_DR_CR, '2', SLI.GL_AMOUNT, 0)          AS  CR_AMOUNT
                           FROM FI_SLIP_LINE              SLI
                              , FI_SLIP_HEADER            SH
                              , FI_ACCOUNT_CONTROL        FAC
                          WHERE SLI.SLIP_HEADER_ID      = SH.SLIP_HEADER_ID
                            AND FAC.ACCOUNT_CONTROL_ID  = SLI.ACCOUNT_CONTROL_ID
                            AND FAC.SOB_ID              = SLI.SOB_ID
                            AND SLI.CONFIRM_YN          = 'Y'
                            AND SLI.SOB_ID              = W_SOB_ID
                            AND SLI.GL_DATE               BETWEEN W_PERIOD_FROM AND W_PERIOD_TO
                       ) FAS
              GROUP BY ROLLUP( FAS.ACCOUNT_DESC)
                     ;

       END;


end FI_MONTH_ACCOUNT_SUM_LIST_G;
/
