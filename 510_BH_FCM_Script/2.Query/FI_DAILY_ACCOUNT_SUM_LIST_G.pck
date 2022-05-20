create or replace package FI_DAILY_ACCOUNT_SUM_LIST_G is
--==============================================================================
-- Project      : FLEX ERP
-- Module       : FCMF
-- Program Name : FI_DAILY_ACCOUNT_SUM_LIST_G
-- Description  : Packing Box Define
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 27-NOV-2010  Sung Kil Te        Initialize
--==============================================================================

  PROCEDURE DAILY_ACCOUNT_SUM_SELECT1
            ( P_CURSOR                OUT TYPES.TCURSOR
            , W_SOB_ID                IN  FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID                IN  FI_SLIP_LINE.ORG_ID%TYPE
            , W_PERIOD_FROM           IN  FI_SLIP_LINE.GL_DATE%TYPE
            , W_PERIOD_TO             IN  FI_SLIP_LINE.GL_DATE%TYPE
            );

end FI_DAILY_ACCOUNT_SUM_LIST_G; 

 
/
create or replace package body FI_DAILY_ACCOUNT_SUM_LIST_G is
--==============================================================================
-- Project      : FLEX ERP
-- Module       : FCMF
-- Program Name : FI_DAILY_ACCOUNT_SUM_LIST_G
-- Description  : Packing Box Define
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 27-NOV-2010  Sung Kil Te        Initialize
--==============================================================================


  PROCEDURE DAILY_ACCOUNT_SUM_SELECT1( P_CURSOR                OUT TYPES.TCURSOR
                                    , W_SOB_ID                IN  FI_SLIP_LINE.SOB_ID%TYPE
                                    , W_ORG_ID                IN  FI_SLIP_LINE.ORG_ID%TYPE
                                    , W_PERIOD_FROM           IN  FI_SLIP_LINE.GL_DATE%TYPE
                                    , W_PERIOD_TO             IN  FI_SLIP_LINE.GL_DATE%TYPE
                                    )

  IS

  BEGIN
    OPEN P_CURSOR FOR
      SELECT DECODE(GROUPING_ID(SLI.GL_DATE, SLI.ACCOUNT_CODE, FAC.ACCOUNT_DESC), 3, '합계', 7, '총계', TO_CHAR(SLI.GL_DATE, 'YYYY-MM-DD')) AS GL_DATE -- 회계일자(Account Date)
           , SUM(DECODE(SLI.ACCOUNT_DR_CR, '1', SLI.GL_AMOUNT, 0))  AS DR_AMOUNT     -- 차변금액( Debit Amount)
           , SLI.ACCOUNT_CODE                                   AS ACCOUNT_CODE  -- 계정코드(Account Code)
           , FAC.ACCOUNT_DESC                                   AS ACCOUNT_DESC  -- 계정명(Account Name)
           , SUM(DECODE(SLI.ACCOUNT_DR_CR, '2', SLI.GL_AMOUNT, 0))  AS CR_AMOUNT     -- 대변금액(Credit Amount)
        FROM FI_SLIP_LINE                SLI
           , FI_SLIP_HEADER              SHI
           , FI_ACCOUNT_CONTROL          FAC
       WHERE SLI.SLIP_HEADER_ID       = SHI.SLIP_HEADER_ID
         AND SLI.SOB_ID               = SHI.SOB_ID
         AND FAC.ACCOUNT_CONTROL_ID   =  SLI.ACCOUNT_CONTROL_ID
         AND FAC.SOB_ID               =  SLI.SOB_ID
         AND SLI.CONFIRM_YN           =  'Y'
         AND SLI.SOB_ID               =  W_SOB_ID
         AND SLI.GL_DATE                 BETWEEN W_PERIOD_FROM AND W_PERIOD_TO
      GROUP BY ROLLUP( (SLI.GL_DATE)
                   , (SLI.ACCOUNT_CODE, FAC.ACCOUNT_DESC)
                   )
           ;

  END;


end FI_DAILY_ACCOUNT_SUM_LIST_G; 
/
