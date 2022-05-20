CREATE OR REPLACE TRIGGER FI_ACCOUNT_CONTROL_BT
BEFORE INSERT OR UPDATE OR DELETE ON FI_ACCOUNT_CONTROL
FOR EACH ROW

DECLARE

BEGIN
---------------------------------------------------------------------------------------------------
  IF INSERTING THEN
    IF :NEW.VAT_ENABLED_FLAG = 'Y' THEN
    -- �ΰ��� ����.
      FI_VAT_ACCOUNTS_G.SAVE_VAT_ACCOUNTS
        ( P_ACCOUNT_CONTROL_ID => :NEW.ACCOUNT_CONTROL_ID
        , P_ACCOUNT_CODE       => :NEW.ACCOUNT_CODE
        , P_SOB_ID             => :NEW.SOB_ID
        , P_VAT_ENABLED_FLAG   => :NEW.VAT_ENABLED_FLAG
        , P_ENABLED_FLAG       => :NEW.ENABLED_FLAG
        , P_USER_ID            => :NEW.CREATED_BY  
        );
    END IF;
    IF :NEW.BUDGET_ENABLED_FLAG = 'Y' THEN
    -- ������.
      FI_BUDGET_ACCOUNT_G.SAVE_BUDGET_ACCOUNT
        ( P_ACCOUNT_CONTROL_ID  => :NEW.ACCOUNT_CONTROL_ID
        , P_ACCOUNT_CODE        => :NEW.ACCOUNT_CODE
        , P_SOB_ID              => :NEW.SOB_ID
        , P_ORG_ID              => :NEW.ORG_ID
        , P_CONTROL_YN          => :NEW.BUDGET_CONTROL_FLAG
        , P_ENABLED_YN          => :NEW.BUDGET_ENABLED_FLAG
        , P_EFFECTIVE_DATE_FR   => :NEW.EFFECTIVE_DATE_FR
        , P_EFFECTIVE_DATE_TO   => :NEW.EFFECTIVE_DATE_TO
        , P_USER_ID             => :NEW.CREATED_BY 
        );
    END IF;
---------------------------------------------------------------------------------------------------
  ELSIF UPDATING THEN
    IF :OLD.VAT_ENABLED_FLAG <> :NEW.VAT_ENABLED_FLAG THEN
    -- �ΰ��� ���� ���� : �ΰ��� ���� => �ΰ��� �̰���.
    -- �ΰ��� ���� ���� : �ΰ��� �̰��� => �ΰ��� ����.
      FI_VAT_ACCOUNTS_G.SAVE_VAT_ACCOUNTS
        ( P_ACCOUNT_CONTROL_ID => :NEW.ACCOUNT_CONTROL_ID
        , P_ACCOUNT_CODE       => :NEW.ACCOUNT_CODE
        , P_SOB_ID             => :NEW.SOB_ID
        , P_VAT_ENABLED_FLAG   => :NEW.VAT_ENABLED_FLAG
        , P_ENABLED_FLAG       => :NEW.ENABLED_FLAG
        , P_USER_ID            => :NEW.CREATED_BY  
        );
    END IF;
    IF :OLD.BUDGET_ENABLED_FLAG <> :NEW.BUDGET_ENABLED_FLAG THEN
    -- ���� ��뺯�� -> ���� ��� => �̻��.
    -- ���� ��뺯�� : �̻�� => ���.
      FI_BUDGET_ACCOUNT_G.SAVE_BUDGET_ACCOUNT
        ( P_ACCOUNT_CONTROL_ID  => :NEW.ACCOUNT_CONTROL_ID
        , P_ACCOUNT_CODE        => :NEW.ACCOUNT_CODE
        , P_SOB_ID              => :NEW.SOB_ID
        , P_ORG_ID              => :NEW.ORG_ID
        , P_CONTROL_YN          => :NEW.BUDGET_CONTROL_FLAG
        , P_ENABLED_YN          => :NEW.BUDGET_ENABLED_FLAG
        , P_EFFECTIVE_DATE_FR   => :NEW.EFFECTIVE_DATE_FR
        , P_EFFECTIVE_DATE_TO   => :NEW.EFFECTIVE_DATE_TO
        , P_USER_ID             => :NEW.CREATED_BY 
        );
    END IF;
---------------------------------------------------------------------------------------------------
  ELSIF DELETING THEN
    IF :OLD.VAT_ENABLED_FLAG = 'Y' THEN
    -- �ΰ��� ����.
      FI_VAT_ACCOUNTS_G.SAVE_VAT_ACCOUNTS
        ( P_ACCOUNT_CONTROL_ID => :OLD.ACCOUNT_CONTROL_ID
        , P_ACCOUNT_CODE       => :OLD.ACCOUNT_CODE
        , P_SOB_ID             => :OLD.SOB_ID
        , P_VAT_ENABLED_FLAG   => 'N'
        , P_ENABLED_FLAG       => :OLD.ENABLED_FLAG
        , P_USER_ID            => :OLD.CREATED_BY  
        );
    END IF;
    IF :OLD.BUDGET_ENABLED_FLAG = 'Y' THEN
      FI_BUDGET_ACCOUNT_G.SAVE_BUDGET_ACCOUNT
        ( P_ACCOUNT_CONTROL_ID  => :OLD.ACCOUNT_CONTROL_ID
        , P_ACCOUNT_CODE        => :OLD.ACCOUNT_CODE
        , P_SOB_ID              => :OLD.SOB_ID
        , P_ORG_ID              => :OLD.ORG_ID
        , P_CONTROL_YN          => :OLD.BUDGET_CONTROL_FLAG
        , P_ENABLED_YN          => 'N'
        , P_EFFECTIVE_DATE_FR   => :OLD.EFFECTIVE_DATE_FR
        , P_EFFECTIVE_DATE_TO   => :OLD.EFFECTIVE_DATE_TO
        , P_USER_ID             => :OLD.CREATED_BY 
        );
    END IF;
  END IF;
END;
/
