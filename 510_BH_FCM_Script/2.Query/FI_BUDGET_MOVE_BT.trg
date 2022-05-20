CREATE OR REPLACE TRIGGER FI_BUDGET_MOVE_BT
BEFORE INSERT OR UPDATE OR DELETE ON FI_BUDGET_MOVE
FOR EACH ROW
DECLARE

BEGIN
  IF INSERTING THEN
    IF :NEW.APPROVE_STATUS = 'C' THEN
    -- INSERT/승인 상태가 확정승인시 예산수립 반영.
      -- 1. FROM부서 예산 감액.
      FI_BUDGET_G.SAVE_BUDGET_CONFIRM
        ( W_GB => 'I'
        , W_BUDGET_TYPE => '31'
        , W_BUDGET_PERIOD => :NEW.BUDGET_PERIOD
        , W_DEPT_ID => :NEW.FROM_DEPT_ID
        , W_ACCOUNT_CONTROL_ID => :NEW.FROM_ACCOUNT_CONTROL_ID
        , W_SOB_ID => :NEW.SOB_ID
        , P_CREATE_SEQ => :NEW.CREATE_SEQ
        , P_BUDGET_PERIOD_FR => :NEW.BUDGET_PERIOD_FR
        , P_BUDGET_PERIOD_TO => :NEW.BUDGET_PERIOD_TO
        , P_START_DATE => :NEW.START_DATE
        , P_END_DATE => :NEW.END_DATE
        , P_AMOUNT => :NEW.AMOUNT * -1
        , P_USER_ID => :NEW.CREATED_BY        
        );
      -- 2. TO부서 예산 증액.
      FI_BUDGET_G.SAVE_BUDGET_CONFIRM
        ( W_GB => 'I'
        , W_BUDGET_TYPE => '31'
        , W_BUDGET_PERIOD => :NEW.BUDGET_PERIOD
        , W_DEPT_ID => :NEW.TO_DEPT_ID
        , W_ACCOUNT_CONTROL_ID => :NEW.TO_ACCOUNT_CONTROL_ID
        , W_SOB_ID => :NEW.SOB_ID
        , P_CREATE_SEQ => :NEW.CREATE_SEQ
        , P_BUDGET_PERIOD_FR => :NEW.BUDGET_PERIOD_FR
        , P_BUDGET_PERIOD_TO => :NEW.BUDGET_PERIOD_TO
        , P_START_DATE => :NEW.START_DATE
        , P_END_DATE => :NEW.END_DATE
        , P_AMOUNT => :NEW.AMOUNT
        , P_USER_ID => :NEW.CREATED_BY        
        );
    END IF;
  ELSIF UPDATING THEN
    IF :OLD.APPROVE_STATUS = 'C' THEN
    -- DELETE/기존 상태가 확정승인시 예산수립에서 감소 반영.
      -- 1. FROM부서 예산 증액.
      FI_BUDGET_G.SAVE_BUDGET_CONFIRM
        ( W_GB => 'D'
        , W_BUDGET_TYPE => '31'
        , W_BUDGET_PERIOD => :OLD.BUDGET_PERIOD
        , W_DEPT_ID => :OLD.FROM_DEPT_ID
        , W_ACCOUNT_CONTROL_ID => :OLD.FROM_ACCOUNT_CONTROL_ID
        , W_SOB_ID => :OLD.SOB_ID
        , P_CREATE_SEQ => :OLD.CREATE_SEQ
        , P_BUDGET_PERIOD_FR => :OLD.BUDGET_PERIOD_FR
        , P_BUDGET_PERIOD_TO => :OLD.BUDGET_PERIOD_TO
        , P_START_DATE => :OLD.START_DATE
        , P_END_DATE => :OLD.END_DATE
        , P_AMOUNT => :OLD.AMOUNT * -1
        , P_USER_ID => :OLD.CREATED_BY        
        );
      -- 2. TO부서 예산 김액.
      FI_BUDGET_G.SAVE_BUDGET_CONFIRM
        ( W_GB => 'D'
        , W_BUDGET_TYPE => '31'
        , W_BUDGET_PERIOD => :OLD.BUDGET_PERIOD
        , W_DEPT_ID => :OLD.TO_DEPT_ID
        , W_ACCOUNT_CONTROL_ID => :OLD.TO_ACCOUNT_CONTROL_ID
        , W_SOB_ID => :OLD.SOB_ID
        , P_CREATE_SEQ => :OLD.CREATE_SEQ
        , P_BUDGET_PERIOD_FR => :OLD.BUDGET_PERIOD_FR
        , P_BUDGET_PERIOD_TO => :OLD.BUDGET_PERIOD_TO
        , P_START_DATE => :OLD.START_DATE
        , P_END_DATE => :OLD.END_DATE
        , P_AMOUNT => :OLD.AMOUNT
        , P_USER_ID => :OLD.CREATED_BY        
        );
    END IF;
    IF :NEW.APPROVE_STATUS = 'C' THEN
    -- INSERT/승인 상태가 확정승인시 예산수립 반영.
      FI_BUDGET_G.SAVE_BUDGET_CONFIRM
        ( W_GB => 'I'
        , W_BUDGET_TYPE => '31'
        , W_BUDGET_PERIOD => :NEW.BUDGET_PERIOD
        , W_DEPT_ID => :NEW.FROM_DEPT_ID
        , W_ACCOUNT_CONTROL_ID => :NEW.FROM_ACCOUNT_CONTROL_ID
        , W_SOB_ID => :NEW.SOB_ID
        , P_CREATE_SEQ => :NEW.CREATE_SEQ
        , P_BUDGET_PERIOD_FR => :NEW.BUDGET_PERIOD_FR
        , P_BUDGET_PERIOD_TO => :NEW.BUDGET_PERIOD_TO
        , P_START_DATE => :NEW.START_DATE
        , P_END_DATE => :NEW.END_DATE
        , P_AMOUNT => :NEW.AMOUNT * -1
        , P_USER_ID => :NEW.CREATED_BY        
        );
      -- 2. TO부서 예산 증액.
      FI_BUDGET_G.SAVE_BUDGET_CONFIRM
        ( W_GB => 'I'
        , W_BUDGET_TYPE => '31'
        , W_BUDGET_PERIOD => :NEW.BUDGET_PERIOD
        , W_DEPT_ID => :NEW.TO_DEPT_ID
        , W_ACCOUNT_CONTROL_ID => :NEW.TO_ACCOUNT_CONTROL_ID
        , W_SOB_ID => :NEW.SOB_ID
        , P_CREATE_SEQ => :NEW.CREATE_SEQ
        , P_BUDGET_PERIOD_FR => :NEW.BUDGET_PERIOD_FR
        , P_BUDGET_PERIOD_TO => :NEW.BUDGET_PERIOD_TO
        , P_START_DATE => :NEW.START_DATE
        , P_END_DATE => :NEW.END_DATE
        , P_AMOUNT => :NEW.AMOUNT
        , P_USER_ID => :NEW.CREATED_BY        
        );
    END IF;
  ELSIF DELETING THEN
    IF :OLD.APPROVE_STATUS = 'C' THEN
    -- DELETE/기존 상태가 확정승인시 예산수립에서 감소 반영.
      -- 1. FROM부서 예산 증액.
      FI_BUDGET_G.SAVE_BUDGET_CONFIRM
        ( W_GB => 'D'
        , W_BUDGET_TYPE => '31'
        , W_BUDGET_PERIOD => :OLD.BUDGET_PERIOD
        , W_DEPT_ID => :OLD.FROM_DEPT_ID
        , W_ACCOUNT_CONTROL_ID => :OLD.FROM_ACCOUNT_CONTROL_ID
        , W_SOB_ID => :OLD.SOB_ID
        , P_CREATE_SEQ => :OLD.CREATE_SEQ
        , P_BUDGET_PERIOD_FR => :OLD.BUDGET_PERIOD_FR
        , P_BUDGET_PERIOD_TO => :OLD.BUDGET_PERIOD_TO
        , P_START_DATE => :OLD.START_DATE
        , P_END_DATE => :OLD.END_DATE
        , P_AMOUNT => :OLD.AMOUNT  * -1
        , P_USER_ID => :OLD.CREATED_BY        
        );
      -- 2. TO부서 예산 김액.
      FI_BUDGET_G.SAVE_BUDGET_CONFIRM
        ( W_GB => 'D'
        , W_BUDGET_TYPE => '31'
        , W_BUDGET_PERIOD => :OLD.BUDGET_PERIOD
        , W_DEPT_ID => :OLD.TO_DEPT_ID
        , W_ACCOUNT_CONTROL_ID => :OLD.TO_ACCOUNT_CONTROL_ID
        , W_SOB_ID => :OLD.SOB_ID
        , P_CREATE_SEQ => :OLD.CREATE_SEQ
        , P_BUDGET_PERIOD_FR => :OLD.BUDGET_PERIOD_FR
        , P_BUDGET_PERIOD_TO => :OLD.BUDGET_PERIOD_TO
        , P_START_DATE => :OLD.START_DATE
        , P_END_DATE => :OLD.END_DATE
        , P_AMOUNT => :OLD.AMOUNT
        , P_USER_ID => :OLD.CREATED_BY        
        );
    END IF;
  END IF;
END;
/
