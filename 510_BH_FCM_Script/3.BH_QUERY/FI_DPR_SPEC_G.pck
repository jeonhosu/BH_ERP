CREATE OR REPLACE PACKAGE FI_DPR_SPEC_G
AS

-- 감가상각자산 취득내역
  PROCEDURE SELECT_DPR_ASSET
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_SLIP_LINE_ID         IN FI_DPR_SPEC.SLIP_LINE_ID%TYPE
            , W_SOB_ID               IN FI_DPR_SPEC.SOB_ID%TYPE
            , W_ORG_ID               IN FI_DPR_SPEC.ORG_ID%TYPE
            );

-- 감가상각자산 취득내역 저장.
  PROCEDURE SAVE_DPR_SPEC
            ( P_SOB_ID          IN FI_DPR_SPEC.SOB_ID%TYPE
            , P_ORG_ID          IN FI_DPR_SPEC.ORG_ID%TYPE
            , P_SLIP_LINE_ID    IN FI_DPR_SPEC.SLIP_LINE_ID%TYPE
            , P_DPR_ASSET_GB_ID IN FI_DPR_SPEC.DPR_ASSET_GB_ID%TYPE
            , P_SPEC_CONTENTS   IN FI_DPR_SPEC.SPEC_CONTENTS%TYPE
            , P_SUP_AMOUNT      IN FI_DPR_SPEC.SUP_AMOUNT%TYPE
            , P_SURTAX          IN FI_DPR_SPEC.SURTAX%TYPE
            , P_ASSET_CNT       IN FI_DPR_SPEC.ASSET_CNT%TYPE
            , P_USER_ID         IN FI_DPR_SPEC.CREATED_BY%TYPE 
            );

-- 감가상각자산 취득내역 금액 리턴.
  PROCEDURE DPR_ASSET_AMOUNT_P
            ( W_SLIP_LINE_ID         IN FI_DPR_SPEC.SLIP_LINE_ID%TYPE
            , W_SOB_ID               IN FI_DPR_SPEC.SOB_ID%TYPE
            , W_ORG_ID               IN FI_DPR_SPEC.ORG_ID%TYPE
            , O_SUP_AMOUNT           OUT FI_DPR_SPEC.SUP_AMOUNT%TYPE
            , O_SURTAX               OUT FI_DPR_SPEC.SURTAX%TYPE
            );
            
END FI_DPR_SPEC_G;
/
CREATE OR REPLACE PACKAGE BODY FI_DPR_SPEC_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_DPR_SPEC_G
/* Description  : 감가상각자산 취득내역.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 감가상각자산 취득내역
  PROCEDURE SELECT_DPR_ASSET
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_SLIP_LINE_ID         IN FI_DPR_SPEC.SLIP_LINE_ID%TYPE
            , W_SOB_ID               IN FI_DPR_SPEC.SOB_ID%TYPE
            , W_ORG_ID               IN FI_DPR_SPEC.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT DAG.DPR_ASSET_GB_NAME
           , FDS.SPEC_CONTENTS
           , FDS.SUP_AMOUNT
           , FDS.SURTAX
           , FDS.ASSET_CNT
           , DAG.DPR_ASSET_GB_ID
           , NVL(FDS.SLIP_LINE_ID, W_SLIP_LINE_ID) AS SLIP_LINE_ID
        FROM FI_DPR_ASSET_GB_V DAG
          , ( SELECT DS.SOB_ID
                   , DS.SLIP_LINE_ID
                   , DS.DPR_ASSET_GB_ID
                   , DS.SPEC_CONTENTS
                   , DS.SUP_AMOUNT
                   , DS.SURTAX
                   , DS.ASSET_CNT
                FROM FI_DPR_SPEC DS
              WHERE DS.SOB_ID           = W_SOB_ID
                AND DS.SLIP_LINE_ID     = W_SLIP_LINE_ID
            ) FDS
      WHERE DAG.DPR_ASSET_GB_ID         = FDS.DPR_ASSET_GB_ID(+)
        AND DAG.SOB_ID                  = FDS.SOB_ID(+)
        AND DAG.SOB_ID                  = W_SOB_ID
      ;
  END SELECT_DPR_ASSET;

-- 감가상각자산 취득내역 저장.
  PROCEDURE SAVE_DPR_SPEC
            ( P_SOB_ID          IN FI_DPR_SPEC.SOB_ID%TYPE
            , P_ORG_ID          IN FI_DPR_SPEC.ORG_ID%TYPE
            , P_SLIP_LINE_ID    IN FI_DPR_SPEC.SLIP_LINE_ID%TYPE
            , P_DPR_ASSET_GB_ID IN FI_DPR_SPEC.DPR_ASSET_GB_ID%TYPE
            , P_SPEC_CONTENTS   IN FI_DPR_SPEC.SPEC_CONTENTS%TYPE
            , P_SUP_AMOUNT      IN FI_DPR_SPEC.SUP_AMOUNT%TYPE
            , P_SURTAX          IN FI_DPR_SPEC.SURTAX%TYPE
            , P_ASSET_CNT       IN FI_DPR_SPEC.ASSET_CNT%TYPE
            , P_USER_ID         IN FI_DPR_SPEC.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN

    UPDATE FI_DPR_SPEC DS
      SET DS.SPEC_CONTENTS    = P_SPEC_CONTENTS
        , DS.SUP_AMOUNT       = NVL(P_SUP_AMOUNT, 0)
        , DS.SURTAX           = NVL(P_SURTAX, 0)
        , DS.ASSET_CNT        = NVL(P_ASSET_CNT, 0)
        , DS.LAST_UPDATE_DATE = V_SYSDATE
        , DS.LAST_UPDATED_BY  = P_USER_ID
    WHERE DS.SLIP_LINE_ID     = P_SLIP_LINE_ID
      AND DS.DPR_ASSET_GB_ID  = P_DPR_ASSET_GB_ID
      AND DS.SOB_ID           = P_SOB_ID
    ;
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO FI_DPR_SPEC
      ( SOB_ID
      , ORG_ID 
      , SLIP_LINE_ID 
      , DPR_ASSET_GB_ID 
      , SPEC_CONTENTS 
      , SUP_AMOUNT 
      , SURTAX 
      , ASSET_CNT 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY      
      ) VALUES
      ( P_SOB_ID
      , P_ORG_ID
      , P_SLIP_LINE_ID
      , P_DPR_ASSET_GB_ID
      , P_SPEC_CONTENTS
      , NVL(P_SUP_AMOUNT, 0)
      , NVL(P_SURTAX, 0)
      , NVL(P_ASSET_CNT, 0)
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID
      );
    END IF;
  END SAVE_DPR_SPEC;

-- 감가상각자산 취득내역 금액 리턴.
  PROCEDURE DPR_ASSET_AMOUNT_P
            ( W_SLIP_LINE_ID         IN FI_DPR_SPEC.SLIP_LINE_ID%TYPE
            , W_SOB_ID               IN FI_DPR_SPEC.SOB_ID%TYPE
            , W_ORG_ID               IN FI_DPR_SPEC.ORG_ID%TYPE
            , O_SUP_AMOUNT           OUT FI_DPR_SPEC.SUP_AMOUNT%TYPE
            , O_SURTAX               OUT FI_DPR_SPEC.SURTAX%TYPE
            )
  AS
  BEGIN
    BEGIN
      SELECT NVL(SUM(DS.SUP_AMOUNT), 0) AS SUP_AMOUNT
           , NVL(SUM(DS.SURTAX), 0) AS SURTAX
        INTO O_SUP_AMOUNT
           , O_SURTAX
        FROM FI_DPR_SPEC DS
      WHERE DS.SOB_ID           = W_SOB_ID
        AND DS.SLIP_LINE_ID     = W_SLIP_LINE_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_SUP_AMOUNT := 0;
      O_SURTAX := 0;
    END;
  END DPR_ASSET_AMOUNT_P;
  
END FI_DPR_SPEC_G;
/
