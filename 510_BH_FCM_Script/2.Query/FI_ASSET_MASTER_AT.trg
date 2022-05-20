CREATE OR REPLACE TRIGGER FI_ASSET_MASTER_AT
AFTER INSERT OR UPDATE OR DELETE ON FI_ASSET_MASTER
FOR EACH ROW

DECLARE

BEGIN
  IF INSERTING THEN
  -- INSERT --
    FI_ASSET_MASTER_T_G.AFTER_DPR_HISTORY_INSERT
                ( :NEW.ASSET_ID
                , :NEW.ASSET_CATEGORY_ID
                , :NEW.ACQUIRE_DATE
                , :NEW.CURR_AMOUNT
                , :NEW.AMOUNT
                , :NEW.DPR_METHOD_TYPE
                , :NEW.DPR_PROGRESS_YEAR
                , :NEW.RESIDUAL_AMOUNT
                , :NEW.SOB_ID
                , :NEW.ORG_ID
                , :NEW.CREATED_BY
                , :NEW.DPR_YN
                , :NEW.ASSET_STATUS_CODE
                );
            
  ELSIF UPDATING THEN
  -- UPDATE --
    FI_ASSET_MASTER_T_G.AFTER_DPR_HISTORY_DELETE (:OLD.ASSET_ID, :OLD.SOB_ID, :OLD.ORG_ID);
    FI_ASSET_MASTER_T_G.AFTER_DPR_HISTORY_INSERT
                ( :NEW.ASSET_ID
                , :NEW.ASSET_CATEGORY_ID
                , :NEW.ACQUIRE_DATE
                , :NEW.CURR_AMOUNT
                , :NEW.AMOUNT
                , :NEW.DPR_METHOD_TYPE
                , :NEW.DPR_PROGRESS_YEAR
                , :NEW.RESIDUAL_AMOUNT
                , :NEW.SOB_ID
                , :NEW.ORG_ID
                , :NEW.CREATED_BY
                , :NEW.DPR_YN
                , :NEW.ASSET_STATUS_CODE
                );

  ELSIF DELETING THEN
  -- DELETE --
    FI_ASSET_MASTER_T_G.AFTER_DPR_HISTORY_DELETE(:OLD.ASSET_ID, :OLD.SOB_ID, :OLD.ORG_ID);

  END IF;

END FI_ASSET_MASTER_AT;
/
