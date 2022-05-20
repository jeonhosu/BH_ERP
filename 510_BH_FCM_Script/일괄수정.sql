DECLARE

BEGIN
  FOR C1 IN ( SELECT SL.SLIP_LINE_ID
                   , SL.SOB_ID                   
                   , SL.GL_DATE
                   , SL.ACCOUNT_CONTROL_ID
                   , SL.ACCOUNT_CODE
                   , SL.CURRENCY_CODE
                   , SL.GL_NUM
                FROM FI_SLIP_LINE SL
              WHERE SL.SOB_ID     = 20
            )
  LOOP
    DBMS_OUTPUT.put_line('GL DATE : ' || TO_CHAR(C1.GL_DATE, 'YYYY-MM-DD') || ', ACCOUNT_CONTROL_ID : ' || C1.ACCOUNT_CONTROL_ID || ', GL_NUM : ' || C1.GL_NUM || ', CURRENCY : ' || C1.CURRENCY_CODE);
    UPDATE FI_SLIP_LINE SL
      SET SL.BUDGET_DEPT_ID       = NULL
    WHERE SL.SLIP_LINE_ID         = C1.SLIP_LINE_ID
      AND SL.SOB_ID               = 20
    ;
  
  END LOOP C1;

END;

