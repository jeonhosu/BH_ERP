DECLARE

BEGIN

  FOR C1 IN ( SELECT AC.ACCOUNT_CONTROL_ID
                   , AC.ACCOUNT_CODE
                   , AC.SOB_ID
                   , AC.ORG_ID
                   , AC.BUDGET_CONTROL_FLAG
                   , AC.BUDGET_ENABLED_FLAG
                   , AC.EFFECTIVE_DATE_FR
                   , AC.EFFECTIVE_DATE_TO
                   , AC.CREATED_BY
                FROM FI_ACCOUNT_CONTROL AC
              WHERE AC.SOB_ID           = 20
                AND AC.BUDGET_ENABLED_FLAG  = 'Y'
            )
  LOOP
    FI_BUDGET_ACCOUNT_G.SAVE_BUDGET_ACCOUNT
            ( P_ACCOUNT_CONTROL_ID  => C1.ACCOUNT_CONTROL_ID
            , P_ACCOUNT_CODE        => C1.ACCOUNT_CODE
            , P_SOB_ID              => C1.SOB_ID
            , P_ORG_ID              => C1.ORG_ID
            , P_CONTROL_YN          => C1.BUDGET_CONTROL_FLAG
            , P_ENABLED_YN          => C1.BUDGET_ENABLED_FLAG
            , P_EFFECTIVE_DATE_FR   => C1.EFFECTIVE_DATE_FR
            , P_EFFECTIVE_DATE_TO   => C1.EFFECTIVE_DATE_TO
            , P_USER_ID             => C1.CREATED_BY 
            );
  END LOOP C1;
  
END;

SELECT *
  FROM FI_BUDGET_ACCOUNT
