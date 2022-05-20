CREATE OR REPLACE TRIGGER FI_SLIP_LINE_INTERFACE_T
AFTER INSERT OR UPDATE OR DELETE ON APPS.FI_SLIP_LINE_INTERFACE FOR EACH ROW
DECLARE

BEGIN

  IF INSERTING THEN
  -- 삽입시.
    -- 예산 체크.
    IF 'N' = FI_BUDGET_VALIDATE_F ( W_GL_DATE => :NEW.SLIP_DATE
                                  , W_PERSON_ID => :NEW.PERSON_ID
                                  , W_ACCOUNT_CONTROL_ID => :NEW.ACCOUNT_CONTROL_ID
                                  , W_GL_AMOUNT => :NEW.GL_AMOUNT
                                  , W_SOB_ID => :NEW.SOB_ID
                                  , W_ORG_ID => :NEW.ORG_ID
                                  ) THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10185', NULL));
    END IF;
  ELSIF UPDATING THEN
  -- 수정시.
    -- 예산 체크.
    IF 'N' = FI_BUDGET_VALIDATE_F ( W_GL_DATE => :NEW.SLIP_DATE
                                  , W_PERSON_ID => :NEW.PERSON_ID
                                  , W_ACCOUNT_CONTROL_ID => :NEW.ACCOUNT_CONTROL_ID
                                  , W_GL_AMOUNT => :NEW.GL_AMOUNT
                                  , W_SOB_ID => :NEW.SOB_ID
                                  , W_ORG_ID => :NEW.ORG_ID
                                  ) THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10185', NULL));
    END IF;
  ELSIF DELETING THEN
  -- 삭제시.
    BEGIN
    -- 삭제 정보 로그 기록.
      INSERT INTO FI_SLIP_LINE_INTERFACE_LOG
      ( LINE_INTERFACE_ID
      , SLIP_DATE
      , SLIP_NUM
      , SLIP_LINE_SEQ
      , HEADER_INTERFACE_ID
      , SOB_ID
      , ORG_ID
      , DEPT_ID
      , PERSON_ID
      , BUDGET_DEPT_ID
      , ACCOUNT_BOOK_ID
      , SLIP_TYPE
      , JOURNAL_HEADER_ID
      , CUSTOMER_ID
      , ACCOUNT_CONTROL_ID
      , ACCOUNT_CODE
      , COST_CENTER_ID
      , ACCOUNT_DR_CR
      , GL_AMOUNT
      , CURRENCY_CODE
      , EXCHANGE_RATE
      , GL_CURRENCY_AMOUNT
      , BANK_ACCOUNT_ID
      , MANAGEMENT1
      , MANAGEMENT2
      , REFER1
      , REFER2
      , REFER3
      , REFER4
      , REFER5
      , REFER6
      , REFER7
      , REFER8
      , REFER9      
      , REFER10
      , REFER11
      , REFER12
      , VOUCH_CODE
      , REFER_RATE
      , REFER_AMOUNT
      , REFER_DATE1
      , REFER_DATE2
      , REMARK
      , FUND_CODE
      , UNIT_PRICE
      , UOM_CODE
      , UOM_QUANTITY
      , UOM_WEIGHT
      , INVENTORY_ITEM_ID
      , TRANSFER_YN
      , TRANSFER_DATE
      , TRANSFER_PERSON_ID
      , CONFIRM_YN
      , CONFIRM_DATE
      , CONFIRM_PERSON_ID
      , SOURCE_TABLE
      , SOURCE_HEADER_ID
      , SOURCE_LINE_ID
      , ATTRIUTE_A
      , ATTRIUTE_B
      , ATTRIUTE_C
      , ATTRIUTE_D
      , ATTRIUTE_E
      , ATTRIUTE_1
      , ATTRIUTE_2
      , ATTRIUTE_3
      , ATTRIUTE_4
      , ATTRIUTE_5
      , CREATION_DATE
      , CREATED_BY
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY )
      VALUES
      ( :OLD.LINE_INTERFACE_ID
      , :OLD.SLIP_DATE
      , :OLD.SLIP_NUM
      , :OLD.SLIP_LINE_SEQ
      , :OLD.HEADER_INTERFACE_ID
      , :OLD.SOB_ID
      , :OLD.ORG_ID
      , :OLD.DEPT_ID
      , :OLD.PERSON_ID
      , :OLD.BUDGET_DEPT_ID
      , :OLD.ACCOUNT_BOOK_ID
      , :OLD.SLIP_TYPE
      , :OLD.JOURNAL_HEADER_ID
      , :OLD.CUSTOMER_ID
      , :OLD.ACCOUNT_CONTROL_ID
      , :OLD.ACCOUNT_CODE
      , :OLD.COST_CENTER_ID
      , :OLD.ACCOUNT_DR_CR
      , :OLD.GL_AMOUNT
      , :OLD.CURRENCY_CODE
      , :OLD.EXCHANGE_RATE
      , :OLD.GL_CURRENCY_AMOUNT
      , :OLD.BANK_ACCOUNT_ID
      , :OLD.MANAGEMENT1
      , :OLD.MANAGEMENT2
      , :OLD.REFER1
      , :OLD.REFER2
      , :OLD.REFER3
      , :OLD.REFER4
      , :OLD.REFER5
      , :OLD.REFER6
      , :OLD.REFER7
      , :OLD.REFER8
      , :OLD.REFER9
      , :OLD.REFER10
      , :OLD.REFER11
      , :OLD.REFER12
      , :OLD.VOUCH_CODE
      , :OLD.REFER_RATE
      , :OLD.REFER_AMOUNT
      , :OLD.REFER_DATE1
      , :OLD.REFER_DATE2
      , :OLD.REMARK
      , :OLD.FUND_CODE
      , :OLD.UNIT_PRICE
      , :OLD.UOM_CODE
      , :OLD.UOM_QUANTITY
      , :OLD.UOM_WEIGHT
      , :OLD.INVENTORY_ITEM_ID
      , :OLD.TRANSFER_YN
      , :OLD.TRANSFER_DATE
      , :OLD.TRANSFER_PERSON_ID
      , :OLD.CONFIRM_YN
      , :OLD.CONFIRM_DATE
      , :OLD.CONFIRM_PERSON_ID
      , :OLD.SOURCE_TABLE
      , :OLD.SOURCE_HEADER_ID
      , :OLD.SOURCE_LINE_ID
      , :OLD.ATTRIUTE_A
      , :OLD.ATTRIUTE_B
      , :OLD.ATTRIUTE_C
      , :OLD.ATTRIUTE_D
      , :OLD.ATTRIUTE_E
      , :OLD.ATTRIUTE_1
      , :OLD.ATTRIUTE_2
      , :OLD.ATTRIUTE_3
      , :OLD.ATTRIUTE_4
      , :OLD.ATTRIUTE_5
      , :OLD.CREATION_DATE
      , :OLD.CREATED_BY
      , :OLD.LAST_UPDATE_DATE
      , :OLD.LAST_UPDATED_BY
      );
    END;
  END IF;

END FI_SLIP_LINE_INTERFACE_T;
/
