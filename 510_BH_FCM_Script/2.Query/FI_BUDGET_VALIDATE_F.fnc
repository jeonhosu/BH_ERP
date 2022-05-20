CREATE OR REPLACE FUNCTION FI_BUDGET_VALIDATE_F
                            ( W_GL_DATE               IN DATE
                            , W_PERSON_ID             IN NUMBER
                            , W_ACCOUNT_CONTROL_ID    IN NUMBER
                            , W_GL_AMOUNT             IN NUMBER
                            , W_SOB_ID                IN NUMBER
                            , W_ORG_ID                IN NUMBER
                            ) RETURN VARCHAR2
AS
  V_BUDGET_CHECK_YN         VARCHAR2(1) := 'N';       -- 예산통제 여부(계정 설정값).
  V_VALIDATE_YN             VARCHAR2(1) := 'N';       -- 예산검증 : Y - 성공, N - 실패.
  V_DEPT_ID                 NUMBER := NULL;           -- 예산부서.
  V_REMAIN_AMOUNT           NUMBER := -1;              -- 예산 잔액.

BEGIN
  -- 예산통제 여부 체크.
  BEGIN
    SELECT NVL(AC.BUDGET_CONTROL_FLAG, 'N') AS BUDGET_CONTROL_FLAG
      INTO V_BUDGET_CHECK_YN
      FROM FI_ACCOUNT_CONTROL AC
    WHERE AC.ACCOUNT_CONTROL_ID     = W_ACCOUNT_CONTROL_ID
      AND AC.SOB_ID                 = W_SOB_ID
      AND AC.ENABLED_FLAG           = 'Y'
      AND AC.EFFECTIVE_DATE_FR      <= W_GL_DATE
      AND (AC.EFFECTIVE_DATE_TO IS NULL OR AC.EFFECTIVE_DATE_TO >= W_GL_DATE)
    ;
  EXCEPTION WHEN OTHERS THEN
    V_BUDGET_CHECK_YN := 'N';
  END;
  IF V_BUDGET_CHECK_YN = 'N' THEN
    V_VALIDATE_YN := 'Y';
    RETURN V_VALIDATE_YN;
  END IF;

---------------------------------------------------------------------------------------------------
-- 예산통제 체크.
  V_VALIDATE_YN := 'N';
  BEGIN
    SELECT DM.M_DEPT_ID
      INTO V_DEPT_ID
      FROM HRM_PERSON_MASTER PM
        , HRM_DEPT_MAPPING DM
    WHERE PM.DEPT_ID          = DM.HR_DEPT_ID
      AND PM.SOB_ID           = DM.SOB_ID
      AND PM.ORG_ID           = DM.ORG_ID
      AND PM.PERSON_ID        = W_PERSON_ID
      AND PM.SOB_ID           = W_SOB_ID
      AND PM.ORG_ID           = W_ORG_ID
      AND DM.MODULE_TYPE      = 'FCM'
    ;
  EXCEPTION WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10183', NULL));
  END;

  BEGIN
    SELECT NVL(FB.REMAIN_AMOUNT, 0) - NVL(W_GL_AMOUNT, 0)
      INTO V_REMAIN_AMOUNT
      FROM FI_BUDGET FB
    WHERE (FB.START_DATE        <= W_GL_DATE
      AND FB.END_DATE           >= W_GL_DATE)
      AND FB.DEPT_ID            = V_DEPT_ID
      AND FB.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
      AND FB.SOB_ID             = W_SOB_ID
    ;
  EXCEPTION WHEN OTHERS THEN
    V_REMAIN_AMOUNT := -1;
  END;
  IF V_REMAIN_AMOUNT > -1 THEN
    V_VALIDATE_YN := 'Y';  
  END IF;
  
  V_VALIDATE_YN := 'Y';  
  RETURN V_VALIDATE_YN;

END FI_BUDGET_VALIDATE_F;
/
