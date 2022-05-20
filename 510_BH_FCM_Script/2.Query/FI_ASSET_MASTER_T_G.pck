CREATE OR REPLACE PACKAGE FI_ASSET_MASTER_T_G
AS

  PROCEDURE AFTER_DPR_HISTORY_INSERT
            ( P_ASSET_ID            IN NUMBER
            , P_ASSET_CATEGORY_ID   IN NUMBER
            , P_ACQUIRE_DATE        IN DATE
            , P_CURR_AMOUNT         IN NUMBER
            , P_AMOUNT              IN NUMBER
            , P_DPR_METHOD_TYPE     IN VARCHAR2
            , P_DPR_PROGRESS_YEAR   IN NUMBER
            , P_RESIDUAL_AMOUNT     IN NUMBER
            , P_SOB_ID              IN NUMBER
            , P_ORG_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            , P_DPR_TYPE            IN VARCHAR2
            , P_DPR_YN              IN VARCHAR2
            , P_ASSET_STATUS_CODE   IN VARCHAR2
            , P_NEW_SOURCE_AMOUNT   IN NUMBER
            );

  PROCEDURE AFTER_DPR_HISTORY_DELETE
            ( P_ASSET_ID          IN NUMBER
            , P_DPR_TYPE          IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

END FI_ASSET_MASTER_T_G;
/
CREATE OR REPLACE PACKAGE BODY FI_ASSET_MASTER_T_G
AS

  PROCEDURE AFTER_DPR_HISTORY_INSERT
            ( P_ASSET_ID            IN NUMBER            
            , P_ASSET_CATEGORY_ID   IN NUMBER
            , P_ACQUIRE_DATE        IN DATE
            , P_CURR_AMOUNT         IN NUMBER
            , P_AMOUNT              IN NUMBER
            , P_DPR_METHOD_TYPE     IN VARCHAR2
            , P_DPR_PROGRESS_YEAR   IN NUMBER
            , P_RESIDUAL_AMOUNT     IN NUMBER
            , P_SOB_ID              IN NUMBER
            , P_ORG_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            , P_DPR_TYPE            IN VARCHAR2
            , P_DPR_YN              IN VARCHAR2
            , P_ASSET_STATUS_CODE   IN VARCHAR2
            , P_NEW_SOURCE_AMOUNT   IN NUMBER
            )
  AS
  BEGIN
    IF P_DPR_YN = 'Y' AND P_ASSET_STATUS_CODE = '10' THEN
      -- 감가상각 처리.
      FI_ASSET_DPR_HISTORY_SET_G.DPR_SET 
        ( P_ASSET_ID
        , P_ASSET_CATEGORY_ID
        , P_DPR_TYPE  -- 10 : 내부, 20 : IFRS.
        , P_ACQUIRE_DATE
        , P_CURR_AMOUNT
        , P_AMOUNT
        , P_DPR_METHOD_TYPE
        , P_DPR_PROGRESS_YEAR
        , P_RESIDUAL_AMOUNT
        , P_SOB_ID
        , P_ORG_ID
        , P_USER_ID
        , P_NEW_SOURCE_AMOUNT
        );
    END  IF;
  END AFTER_DPR_HISTORY_INSERT;

  PROCEDURE AFTER_DPR_HISTORY_DELETE
            ( P_ASSET_ID          IN NUMBER
            , P_DPR_TYPE          IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
  BEGIN
    DELETE FROM FI_ASSET_DPR_HISTORY ADH
    WHERE ADH.ASSET_ID            = P_ASSET_ID
      AND ADH.DPR_TYPE            = P_DPR_TYPE
      AND ADH.SOB_ID              = P_SOB_ID
    ;
  END AFTER_DPR_HISTORY_DELETE;

END FI_ASSET_MASTER_T_G;
/
