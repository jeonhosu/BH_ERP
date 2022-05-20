CREATE OR REPLACE TRIGGER FI_SLIP_HEADER_T
AFTER INSERT OR UPDATE OR DELETE ON FI_SLIP_HEADER
FOR EACH ROW

DECLARE
  V_TRIGGER_TYPE                  VARCHAR2(2);
  
BEGIN
  IF DELETING THEN
    -- INTERFACE 데이터 => 승인 취소.
    V_TRIGGER_TYPE := 'DD';  
    
    FI_SLIP_HEADER_P( V_TRIGGER_TYPE
                    , :OLD.SLIP_HEADER_ID      , :OLD.SLIP_DATE 
                    , :OLD.SLIP_NUM            , :OLD.SOB_ID 
                    , :OLD.ORG_ID              , :OLD.DEPT_ID 
                    , :OLD.PERSON_ID           , :OLD.BUDGET_DEPT_ID 
                    , :OLD.SLIP_TYPE           , :OLD.GL_DATE 
                    , :OLD.GL_NUM              , :OLD.REQ_BANK_ACCOUNT_ID 
                    , :OLD.REQ_PAYABLE_TYPE    , :OLD.REQ_PAYABLE_DATE 
                    , :OLD.REMARK              
                    , :OLD.CREATION_DATE       , :OLD.CREATED_BY 
                    , :OLD.LAST_UPDATE_DATE    , :OLD.LAST_UPDATED_BY
                    , :OLD.CREATED_TYPE        , :OLD.SOURCE_TABLE 
                    , :OLD.SOURCE_HEADER_ID
                    );
                    
    BEGIN
      -- 로그 저장.    
      INSERT INTO FI_SLIP_HEADER_LOG
      ( SLIP_HEADER_ID          , SLIP_DATE 
      , SLIP_NUM                , SOB_ID 
      , ORG_ID                  , DEPT_ID 
      , PERSON_ID               , BUDGET_DEPT_ID 
      , ACCOUNT_BOOK_ID         , SLIP_TYPE 
      , PERIOD_NAME             , CONFIRM_YN
      , CONFIRM_DATE            , CONFIRM_PERSON_ID
      , CHANGE_COUNT            
      , GL_DATE                 , GL_NUM
      , GL_AMOUNT               , CURRENCY_CODE
      , EXCHANGE_RATE           , GL_CURRENCY_AMOUNT
      , REQ_BANK_ACCOUNT_ID     , REQ_PAYABLE_TYPE 
      , REQ_PAYABLE_DATE        , REMARK 
      , CLOSED_YN               , CLOSED_DATE
      , CLOSED_PERSON_ID
      , CREATED_TYPE            , SOURCE_TABLE
      , SOURCE_HEADER_ID        , CREATION_DATE 
      , CREATED_BY              , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( :OLD.SLIP_HEADER_ID          , :OLD.SLIP_DATE 
      , :OLD.SLIP_NUM                , :OLD.SOB_ID 
      , :OLD.ORG_ID                  , :OLD.DEPT_ID 
      , :OLD.PERSON_ID               , :OLD.BUDGET_DEPT_ID 
      , :OLD.ACCOUNT_BOOK_ID         , :OLD.SLIP_TYPE 
      , :OLD.PERIOD_NAME             , :OLD.CONFIRM_YN
      , :OLD.CONFIRM_DATE            , :OLD.CONFIRM_PERSON_ID
      , :OLD.CHANGE_COUNT            
      , :OLD.GL_DATE                 , :OLD.GL_NUM
      , :OLD.GL_AMOUNT               , :OLD.CURRENCY_CODE
      , :OLD.EXCHANGE_RATE           , :OLD.GL_CURRENCY_AMOUNT
      , :OLD.REQ_BANK_ACCOUNT_ID     , :OLD.REQ_PAYABLE_TYPE 
      , :OLD.REQ_PAYABLE_DATE        , :OLD.REMARK 
      , :OLD.CLOSED_YN               , :OLD.CLOSED_DATE
      , :OLD.CLOSED_PERSON_ID
      , :OLD.CREATED_TYPE            , :OLD.SOURCE_TABLE
      , :OLD.SOURCE_HEADER_ID        , :OLD.CREATION_DATE 
      , :OLD.CREATED_BY              , :OLD.LAST_UPDATE_DATE 
      , :OLD.LAST_UPDATED_BY 
      );
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'SLIP HEADER LOG INSERT ERROR : ' || SQLERRM );
    END;
    
  END IF;
END FI_SLIP_HEADER_T;
/
