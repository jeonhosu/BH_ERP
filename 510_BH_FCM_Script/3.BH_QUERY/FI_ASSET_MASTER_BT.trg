CREATE OR REPLACE TRIGGER FI_ASSET_MASTER_BT
BEFORE INSERT OR UPDATE OR DELETE ON FI_ASSET_MASTER
FOR EACH ROW

DECLARE
  V_DPR_COUNT                     NUMBER;
BEGIN
  IF INSERTING THEN
  -- INSERT --
    
    /* -- 일괄 업로드시만 적용해야 함.
    SELECT FI_ASSET_MASTER_S1.NEXTVAL
      INTO :NEW.ASSET_ID
      FROM DUAL;
    
    :NEW.ASSET_CODE := FI_DOCUMENT_NUM_G.DOCUMENT_NUM_F('DP', :NEW.SOB_ID, :NEW.REGISTER_DATE, :NEW.CREATED_BY);
    */
    
    -- 감가 상태 표시.
    IF :NEW.DPR_YN = 'Y' THEN
      :NEW.DPR_STATUS_CODE := '10';
    END IF;
    IF :NEW.IFRS_DPR_YN = 'Y' THEN
      :NEW.IFRS_DPR_STATUS_CODE := '10';    
    END IF;
    
    FI_ASSET_MASTER_T_G.AFTER_DPR_HISTORY_INSERT
                ( :NEW.ASSET_ID
                , :NEW.ASSET_CATEGORY_ID
                , :NEW.ACQUIRE_DATE
                , :NEW.CURR_AMOUNT
                , :NEW.AMOUNT
                , :NEW.DPR_METHOD_TYPE
                , :NEW.DPR_PROGRESS_YEAR
                , :NEW.RESIDUAL_AMOUNT
                , :NEW.IFRS_DPR_METHOD_TYPE
                , :NEW.IFRS_PROGRESS_YEAR
                , :NEW.IFRS_RESIDUAL_AMOUNT
                , :NEW.SOB_ID
                , :NEW.ORG_ID
                , :NEW.CREATED_BY
                , :NEW.DPR_YN
                , :NEW.ASSET_STATUS_CODE
                , :NEW.ATTRIBUTE_1
                );
            
  ELSIF UPDATING THEN
  -- UPDATE --
    -- 취득일자/상각금액이 변경되었을 경우만 처리.
    IF :OLD.ACQUIRE_DATE <> :NEW.ACQUIRE_DATE OR :OLD.AMOUNT <> :NEW.AMOUNT THEN
      -- 감가 처리가 진행되었을 경우 취득일자/취득금/감가상각방법/내용년수는 수정 불가.
      BEGIN
        SELECT COUNT(ADH.ASSET_ID)
          INTO V_DPR_COUNT
          FROM FI_ASSET_DPR_HISTORY ADH
        WHERE ADH.ASSET_ID          = :NEW.ASSET_ID
          AND ADH.ASSET_MASTER_YN   = 'Y'
        ;
      EXCEPTION WHEN OTHERS THEN
        V_DPR_COUNT := 0;
      END;
      IF V_DPR_COUNT > 0 AND 
        (:OLD.ACQUIRE_DATE <> :NEW.ACQUIRE_DATE OR :OLD.AMOUNT <> :NEW.AMOUNT 
        OR :OLD.DPR_METHOD_TYPE <> :NEW.DPR_METHOD_TYPE OR :OLD.DPR_PROGRESS_YEAR <> :NEW.DPR_PROGRESS_YEAR 
        OR :OLD.IFRS_DPR_METHOD_TYPE <> :NEW.IFRS_DPR_METHOD_TYPE OR :OLD.IFRS_PROGRESS_YEAR <> :NEW.IFRS_PROGRESS_YEAR) THEN
        RAISE_APPLICATION_ERROR(ERRNUMS.Asset_DPR_Closed_Code, ERRNUMS.Asset_DRP_Closed_Desc);
        RETURN;
      END IF;
      IF V_DPR_COUNT = 0 THEN 
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
                    , :NEW.IFRS_DPR_METHOD_TYPE
                    , :NEW.IFRS_PROGRESS_YEAR
                    , :NEW.IFRS_RESIDUAL_AMOUNT
                    , :NEW.SOB_ID
                    , :NEW.ORG_ID
                    , :NEW.CREATED_BY
                    , :NEW.DPR_YN
                    , :NEW.ASSET_STATUS_CODE
                    , :NEW.ATTRIBUTE_1
                    );
      END IF;
    END IF;
  ELSIF DELETING THEN
  -- DELETE --
    -- 감가 처리가 진행되었을 경우 취득일자/취득금/감가상각방법/내용년수는 수정 불가.
    BEGIN
      SELECT COUNT(ADH.ASSET_ID)
        INTO V_DPR_COUNT
        FROM FI_ASSET_DPR_HISTORY ADH
      WHERE ADH.ASSET_ID          = :NEW.ASSET_ID
        AND ADH.ASSET_MASTER_YN   = 'Y'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_DPR_COUNT := 0;
    END;
    IF V_DPR_COUNT > 0 THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Asset_DPR_Closed_Code, ERRNUMS.Asset_DRP_Closed_Desc);
      RETURN;
    END IF;
    FI_ASSET_MASTER_T_G.AFTER_DPR_HISTORY_DELETE(:OLD.ASSET_ID, :OLD.SOB_ID, :OLD.ORG_ID);
    
  END IF;

END FI_ASSET_MASTER_AT;
/
