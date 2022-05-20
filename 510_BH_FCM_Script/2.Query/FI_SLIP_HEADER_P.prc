CREATE OR REPLACE PROCEDURE FI_SLIP_HEADER_P
                            ( P_TRIGGER_TYPE        IN VARCHAR2
                            , P_SLIP_HEADER_ID      IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
                            , P_SLIP_DATE           IN FI_SLIP_HEADER.SLIP_DATE%TYPE
                            , P_SLIP_NUM            IN FI_SLIP_HEADER.SLIP_NUM%TYPE
                            , P_SOB_ID              IN FI_SLIP_HEADER.SOB_ID%TYPE
                            , P_ORG_ID              IN FI_SLIP_HEADER.ORG_ID%TYPE
                            , P_DEPT_ID             IN FI_SLIP_HEADER.DEPT_ID%TYPE
                            , P_PERSON_ID           IN FI_SLIP_HEADER.PERSON_ID%TYPE
                            , P_BUDGET_DEPT_ID      IN FI_SLIP_HEADER.BUDGET_DEPT_ID%TYPE
                            , P_SLIP_TYPE           IN FI_SLIP_HEADER.SLIP_TYPE%TYPE
                            , P_GL_DATE             IN FI_SLIP_HEADER.GL_DATE%TYPE
                            , P_GL_NUM              IN FI_SLIP_HEADER.GL_NUM%TYPE
                            , P_REQ_BANK_ACCOUNT_ID IN FI_SLIP_HEADER.REQ_BANK_ACCOUNT_ID%TYPE
                            , P_REQ_PAYABLE_TYPE    IN FI_SLIP_HEADER.REQ_PAYABLE_TYPE%TYPE
                            , P_REQ_PAYABLE_DATE    IN FI_SLIP_HEADER.REQ_PAYABLE_DATE%TYPE
                            , P_REMARK              IN FI_SLIP_HEADER.REMARK%TYPE
                            , P_CREATE_DATE         IN FI_SLIP_HEADER.CREATION_DATE%TYPE
                            , P_CREATED_BY          IN FI_SLIP_HEADER.CREATED_BY%TYPE
                            , P_LAST_UPDATE_DATE    IN FI_SLIP_HEADER.LAST_UPDATE_DATE%TYPE
                            , P_LAST_UPDATED_BY     IN FI_SLIP_HEADER.LAST_UPDATED_BY%TYPE
                            , P_CREATED_TYPE        IN FI_SLIP_HEADER.CREATED_TYPE%TYPE DEFAULT 'M'
                            , P_SOURCE_TABLE        IN FI_SLIP_HEADER.SOURCE_TABLE%TYPE DEFAULT NULL
                            , P_SOURCE_HEADER_ID    IN FI_SLIP_HEADER.SOURCE_HEADER_ID%TYPE DEFAULT NULL
                            )
AS
BEGIN
  IF P_TRIGGER_TYPE = 'DD' THEN
  -- INTERFACE 자료 승인 취소.
    NULL;
    /*IF P_CREATED_TYPE = 'I' AND P_SOURCE_TABLE = 'FI_SLIP_HEADER_INTERFACE' AND P_SOURCE_HEADER_ID IS NOT NULL THEN
      BEGIN
        UPDATE FI_SLIP_HEADER_INTERFACE SHI
          SET SHI.CONFIRM_YN          = 'N'
            , SHI.CONFIRM_DATE        = NULL
            , SHI.CONFIRM_PERSON_ID   = NULL
        WHERE SHI.HEADER_INTERFACE_ID     = P_SOURCE_HEADER_ID
        ;

        UPDATE FI_SLIP_LINE_INTERFACE SLI
          SET SLI.CONFIRM_YN          = 'N'
            , SLI.CONFIRM_DATE        = NULL
            , SLI.CONFIRM_PERSON_ID   = NULL
        WHERE SLI.HEADER_INTERFACE_ID     = P_SOURCE_HEADER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Slip Interface Confirm Update Error : ' || SQLERRM);
      END;
    END IF;*/
  END IF;

END FI_SLIP_HEADER_P;
/
