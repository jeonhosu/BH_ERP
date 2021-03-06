CREATE OR REPLACE TRIGGER FI_SLIP_LINE_INTERFACE_T
AFTER INSERT OR UPDATE OR DELETE ON FI_SLIP_LINE_INTERFACE 
FOR EACH ROW
  DECLARE
  
  BEGIN
    IF INSERTING THEN
      -- 삽입시.
      BEGIN
      -- 예산 반영.
        UPDATE FI_BUDGET FB
          SET FB.REMAIN_AMOUNT = (NVL(FB.BASE_AMOUNT, 0) + NVL(FB.ADD_AMOUNT, 0) + NVL(FB.MOVE_AMOUNT, 0) + NVL(FB.NEXT_AMOUNT, 0)) 
                                 - (NVL(FB.USE_AMOUNT, 0) + NVL(:NEW.GL_AMOUNT, 0))
        WHERE FB.BUDGET_PERIOD    = GL_FISCAL_PERIOD_G.PERIOD_NAME_F(FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(:NEW.SOB_ID), :NEW.SLIP_DATE, :NEW.SOB_ID, :NEW.ORG_ID)
          AND EXISTS (SELECT 'X'
                        FROM HRM_PERSON_MASTER PM
                          , HRM_DEPT_MAPPING DM
                      WHERE PM.DEPT_ID      = DM.HR_DEPT_ID
                        AND PM.SOB_ID       = DM.SOB_ID
                        AND PM.ORG_ID       = DM.ORG_ID
                        AND PM.DEPT_ID      = FB.DEPT_ID
                        AND PM.PERSON_ID    = :NEW.PERSON_ID
                        AND PM.SOB_ID       = :NEW.SOB_ID
                        AND PM.ORG_ID       = :NEW.ORG_ID
                        AND DM.MODULE_TYPE  = 'FCM'
                     )
        ;
      EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, EAAP_MESSAGE_G(USERENV_G.GET_TERRITORY_S_F, 'FCM_10181', NULL);
      END;
    ELSIF UPDATING THEN
      -- 수정시.
      BEGIN
      -- 기존에 사용된 예산 원상복귀.
        UPDATE FI_BUDGET FB
          SET FB.USE_AMOUNT    = NVL(FB.USE_AMOUNT, 0) - NVL(:OLD.GL_AMOUNT, 0)
            , FB.REMAIN_AMOUNT =  NVL(FB.REMAIN_AMOUNT, 0)) + NVL(:OLD.GL_AMOUNT, 0))
        WHERE FB.BUDGET_PERIOD    = GL_FISCAL_PERIOD_G.PERIOD_NAME_F(FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(:OLD.SOB_ID), :OLD.SLIP_DATE, :OLD.SOB_ID, :OLD.ORG_ID)
          AND EXISTS (SELECT 'X'
                        FROM HRM_PERSON_MASTER PM
                          , HRM_DEPT_MAPPING DM
                      WHERE PM.DEPT_ID      = DM.HR_DEPT_ID
                        AND PM.SOB_ID       = DM.SOB_ID
                        AND PM.ORG_ID       = DM.ORG_ID
                        AND PM.DEPT_ID      = FB.DEPT_ID
                        AND PM.PERSON_ID    = :OLD.PERSON_ID
                        AND PM.SOB_ID       = :OLD.SOB_ID
                        AND PM.ORG_ID       = :OLD.ORG_ID
                        AND DM.MODULE_TYPE  = 'FCM'
                     )
        ;
      EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, EAAP_MESSAGE_G(USERENV_G.GET_TERRITORY_S_F, 'FCM_10181', NULL);
      END;
      BEGIN
      -- 예산 반영.
        UPDATE FI_BUDGET FB
          SET FB.REMAIN_AMOUNT = (NVL(FB.BASE_AMOUNT, 0) + NVL(FB.ADD_AMOUNT, 0) + NVL(FB.MOVE_AMOUNT, 0) + NVL(FB.NEXT_AMOUNT, 0)) 
                                 - (NVL(FB.USE_AMOUNT, 0) + NVL(:NEW.GL_AMOUNT, 0))
        WHERE FB.BUDGET_PERIOD    = GL_FISCAL_PERIOD_G.PERIOD_NAME_F(FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(:NEW.SOB_ID), :NEW.SLIP_DATE, :NEW.SOB_ID, :NEW.ORG_ID)
          AND EXISTS (SELECT 'X'
                        FROM HRM_PERSON_MASTER PM
                          , HRM_DEPT_MAPPING DM
                      WHERE PM.DEPT_ID      = DM.HR_DEPT_ID
                        AND PM.SOB_ID       = DM.SOB_ID
                        AND PM.ORG_ID       = DM.ORG_ID
                        AND PM.DEPT_ID      = FB.DEPT_ID
                        AND PM.PERSON_ID    = :NEW.PERSON_ID
                        AND PM.SOB_ID       = :NEW.SOB_ID
                        AND PM.ORG_ID       = :NEW.ORG_ID
                        AND DM.MODULE_TYPE  = 'FCM'
                     )
        ;
      EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, EAAP_MESSAGE_G(USERENV_G.GET_TERRITORY_S_F, 'FCM_10181', NULL);
      END;
    ELSIF DELETING THEN
      -- 삭제시.
      BEGIN
      -- 예산 반영.
        UPDATE FI_BUDGET FB
          SET FB.USE_AMOUNT    = NVL(FB.USE_AMOUNT, 0) - NVL(:OLD.GL_AMOUNT, 0)
            , FB.REMAIN_AMOUNT =  NVL(FB.REMAIN_AMOUNT, 0)) + NVL(:OLD.GL_AMOUNT, 0))
        WHERE FB.BUDGET_PERIOD    = GL_FISCAL_PERIOD_G.PERIOD_NAME_F(FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(:OLD.SOB_ID), :OLD.SLIP_DATE, :OLD.SOB_ID, :OLD.ORG_ID)
          AND EXISTS (SELECT 'X'
                        FROM HRM_PERSON_MASTER PM
                          , HRM_DEPT_MAPPING DM
                      WHERE PM.DEPT_ID      = DM.HR_DEPT_ID
                        AND PM.SOB_ID       = DM.SOB_ID
                        AND PM.ORG_ID       = DM.ORG_ID
                        AND PM.DEPT_ID      = FB.DEPT_ID
                        AND PM.PERSON_ID    = :OLD.PERSON_ID
                        AND PM.SOB_ID       = :OLD.SOB_ID
                        AND PM.ORG_ID       = :OLD.ORG_ID
                        AND DM.MODULE_TYPE  = 'FCM'
                     )
        ;
      EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, EAAP_MESSAGE_G(USERENV_G.GET_TERRITORY_S_F, 'FCM_10181', NULL);
      END;
    END IF;
  
  END FI_SLIP_LINE_INTERFACE_T;
