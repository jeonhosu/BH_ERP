CREATE OR REPLACE FUNCTION GET_LOCAL_DATE(W_SOB_ID               NUMBER DEFAULT 0) RETURN DATE
AS
  D_SYSDATE                                                   DATE;

BEGIN
  D_SYSDATE := SYSDATE;

  RETURN D_SYSDATE;

END GET_LOCAL_DATE;
/