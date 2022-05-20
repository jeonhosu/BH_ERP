DECLARE
  V_HEADER_ID       NUMBER;
  V_SLIP_NUM        VARCHAR2(50);
  V_MESSAGE         VARCHAR2(200);
BEGIN
  FOR C1 IN ( SELECT   'PAY' AS MODUE_TYPE
                     , SLT.SLIP_DATE
                     , SLT.SLIP_NUM
                     , SLT.SLIP_LINE_SEQ
                     , SLT.HEADER_INTERFACE_ID
                     , SLT.SOB_ID
                     , SLT.ORG_ID
                     , 39 AS DEPT_ID
                     , 269 AS PERSON_ID
                     , AC.ACCOUNT_CONTROL_ID
                     , SLT.ACCOUNT_CODE
                     , SLT.ACCOUNT_DR_CR     
                     , SLT.GL_AMOUNT AS GL_AMOUNT
                     , SLT.CURRENCY_CODE
                     , SLT.EXCHANGE_RATE EXCHANGE_RATE
                     , SLT.GL_CURRENCY_AMOUNT AS GL_CURRENCY_AMOUNT
                     , SLT.MANAGEMENT1
                     , SLT.MANAGEMENT2
                     , SLT.REFER1
                     , SLT.REFER2
                     , SLT.REFER3
                     , SLT.REFER4
                     , SLT.REFER5
                     , SLT.REFER6
                     , SLT.REFER7
                     , SLT.REFER8
                     , SLT.REFER9
                     , SLT.REFER10
                     , SLT.REFER11
                     , SLT.REFER12
                     , SLT.REMARK
                  FROM FI_SLIP_LINE_INTERFACE_TEMP SLT
                     , FI_ACCOUNT_CONTROL AC
                WHERE SLT.ACCOUNT_CODE              = AC.ACCOUNT_CODE
                  AND SLT.SOB_ID                    = AC.SOB_ID
                ORDER BY SLT.SLIP_LINE_SEQ
              )
  LOOP
    FI_SLIP_AUTO_INTERFACE_G.INSERT_SLIP_AUTO_INTERFACE
      ( P_MODULE_TYPE         => C1.MODUE_TYPE
      , P_SLIP_DATE           => C1.SLIP_DATE
      , P_SOB_ID              => C1.SOB_ID
      , P_ORG_ID              => C1.ORG_ID
      , P_DEPT_ID             => C1.DEPT_ID
      , P_PERSON_ID           => C1.PERSON_ID
      , P_BUDGET_DEPT_ID      => NULL
      , P_ACCOUNT_CODE        => C1.ACCOUNT_CODE
      , P_ACCOUNT_DR_CR       => C1.ACCOUNT_DR_CR
      , P_GL_AMOUNT           => C1.GL_AMOUNT
      , P_CURRENCY_CODE       => C1.CURRENCY_CODE
      , P_EXCHANGE_RATE       => C1.EXCHANGE_RATE
      , P_GL_CURRENCY_AMOUNT  => C1.GL_CURRENCY_AMOUNT
      , P_MANAGEMENT1         => C1.MANAGEMENT1
      , P_MANAGEMENT2         => C1.MANAGEMENT2
      , P_REFER1              => C1.REFER1
      , P_REFER2              => C1.REFER2
      , P_REFER3              => C1.REFER3
      , P_REFER4              => C1.REFER4
      , P_REFER5              => C1.REFER5
      , P_REFER6              => C1.REFER6
      , P_REFER7              => C1.REFER7
      , P_REFER8              => C1.REFER8
      , P_REFER9              => C1.REFER9
      , P_REFER10             => C1.REFER10
      , P_REFER11             => C1.REFER11
      , P_REFER12             => C1.REFER12
      , P_VOUCH_CODE          => NULL
      , P_REFER_RATE          => NULL
      , P_REFER_AMOUNT        => NULL
      , P_REFER_DATE1         => NULL
      , P_REFER_DATE2         => NULL
      , P_REMARK              => C1.REMARK
      , P_FUND_CODE           => NULL
      , P_UNIT_PRICE          => NULL
      , P_UOM_CODE            => NULL
      , P_QUANTITY            => NULL
      , P_WEIGHT              => NULL
      , P_USER_ID             => 100
      );  
  
  END LOOP C1;
  
  FI_SLIP_AUTO_INTERFACE_G.SET_SLIP_AUTO_INTERFACE
    (  P_MODULE_TYPE        => 'PAY'
    , P_SLIP_DATE           => TO_DATE('2011-07-31', 'YYYY-MM-DD')
    , P_SOB_ID              => 10
    , P_ORG_ID              => 101
    , P_USER_ID             => 100
    , O_HEADER_ID           => V_HEADER_ID
    , O_SLIP_NUM            => V_SLIP_NUM
    , O_MESSAGE             => V_MESSAGE
    );
  DBMS_OUTPUT.PUT_LINE('HEADER ID : ' || V_HEADER_ID || ', SLIP_NUM : ' || V_SLIP_NUM || ', MESSAGE : ' || V_MESSAGE);
END;


SELECT *
  FROM FI_SLIP_LINE_INTERFACE_TEMP
FOR UPDATE
;  
