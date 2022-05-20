CREATE OR REPLACE PACKAGE FI_DPR_RATE_G
AS

  PROCEDURE DPR_RATE_SELECT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_DPR_TYPE          IN FI_DPR_RATE.DPR_TYPE%TYPE
            , W_SOB_ID            IN FI_DPR_RATE.SOB_ID%TYPE
            , W_PROGRESS_YEAR     IN FI_DPR_RATE.PROGRESS_YEAR%TYPE
            );

  PROCEDURE DPR_RATE_INSERT
            ( P_DPR_TYPE          IN FI_DPR_RATE.DPR_TYPE%TYPE
            , P_SOB_ID            IN FI_DPR_RATE.SOB_ID%TYPE
            , P_ORG_ID            IN FI_DPR_RATE.ORG_ID%TYPE
            , P_PROGRESS_YEAR     IN FI_DPR_RATE.PROGRESS_YEAR%TYPE
            , P_DPR_RATE          IN FI_DPR_RATE.DPR_RATE%TYPE
            , P_REMARK            IN FI_DPR_RATE.REMARK%TYPE
            , P_ENABLED_FLAG      IN FI_DPR_RATE.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_DPR_RATE.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_DPR_RATE.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_DPR_RATE.CREATED_BY%TYPE 
            );

  PROCEDURE DPR_RATE_UPDATE
            ( W_DPR_TYPE          IN FI_DPR_RATE.DPR_TYPE%TYPE
            , W_SOB_ID            IN FI_DPR_RATE.SOB_ID%TYPE
            , W_PROGRESS_YEAR     IN FI_DPR_RATE.PROGRESS_YEAR%TYPE
            , P_DPR_RATE          IN FI_DPR_RATE.DPR_RATE%TYPE
            , P_REMARK            IN FI_DPR_RATE.REMARK%TYPE
            , P_ENABLED_FLAG      IN FI_DPR_RATE.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_DPR_RATE.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_DPR_RATE.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_DPR_RATE.CREATED_BY%TYPE 
            );
            
-- 감가율 리턴.
  FUNCTION DPR_RATE_F
            ( W_DPR_TYPE          IN FI_DPR_RATE.DPR_TYPE%TYPE
            , W_DPR_METHOD_TYPE   IN VARCHAR2
            , W_SOB_ID            IN FI_DPR_RATE.SOB_ID%TYPE
            , W_PROGRESS_YEAR     IN FI_DPR_RATE.PROGRESS_YEAR%TYPE
            ) RETURN NUMBER;

-- 감가율 리턴 프로시져.
  PROCEDURE DPR_RATE_P
            ( W_DPR_TYPE          IN FI_DPR_RATE.DPR_TYPE%TYPE
            , W_DPR_METHOD_TYPE   IN VARCHAR2
            , W_SOB_ID            IN FI_DPR_RATE.SOB_ID%TYPE
            , W_PROGRESS_YEAR     IN FI_DPR_RATE.PROGRESS_YEAR%TYPE
            , O_DPR_RATE          OUT NUMBER
            );
            
END FI_DPR_RATE_G;
/
CREATE OR REPLACE PACKAGE BODY FI_DPR_RATE_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_DPR_RATE_G
/* Description  : 감가상각율 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
  PROCEDURE DPR_RATE_SELECT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_DPR_TYPE          IN FI_DPR_RATE.DPR_TYPE%TYPE
            , W_SOB_ID            IN FI_DPR_RATE.SOB_ID%TYPE
            , W_PROGRESS_YEAR     IN FI_DPR_RATE.PROGRESS_YEAR%TYPE
            
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT DR.DPR_TYPE
           , FI_COMMON_G.CODE_NAME_F('DPR_TYPE', DR.DPR_TYPE, DR.SOB_ID) AS DPR_TYPE_NAME
           , DR.PROGRESS_YEAR
           , DR.DPR_RATE
           , DR.REMARK
           , DR.ENABLED_FLAG
           , DR.EFFECTIVE_DATE_FR
           , DR.EFFECTIVE_DATE_TO
        FROM FI_DPR_RATE DR
      WHERE DR.DPR_TYPE               = NVL(W_DPR_TYPE, DR.DPR_TYPE)
        AND DR.SOB_ID                 = W_SOB_ID
        AND DR.PROGRESS_YEAR          = NVL(W_PROGRESS_YEAR, DR.PROGRESS_YEAR)
      ORDER BY DR.PROGRESS_YEAR
      ;

  END DPR_RATE_SELECT;

  PROCEDURE DPR_RATE_INSERT
            ( P_DPR_TYPE          IN FI_DPR_RATE.DPR_TYPE%TYPE
            , P_SOB_ID            IN FI_DPR_RATE.SOB_ID%TYPE
            , P_ORG_ID            IN FI_DPR_RATE.ORG_ID%TYPE
            , P_PROGRESS_YEAR     IN FI_DPR_RATE.PROGRESS_YEAR%TYPE
            , P_DPR_RATE          IN FI_DPR_RATE.DPR_RATE%TYPE
            , P_REMARK            IN FI_DPR_RATE.REMARK%TYPE
            , P_ENABLED_FLAG      IN FI_DPR_RATE.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_DPR_RATE.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_DPR_RATE.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_DPR_RATE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT    NUMBER := 0;
    
  BEGIN
    BEGIN
      SELECT COUNT(DR.PROGRESS_YEAR) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_DPR_RATE DR
      WHERE DPR_TYPE          = P_DPR_TYPE
        AND SOB_ID            = P_SOB_ID
        AND PROGRESS_YEAR     = P_PROGRESS_YEAR
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
      RETURN;
    END IF;
    
    INSERT INTO FI_DPR_RATE
    ( DPR_TYPE
    , SOB_ID 
    , ORG_ID 
    , PROGRESS_YEAR 
    , DPR_RATE 
    , REMARK 
    , ENABLED_FLAG 
    , EFFECTIVE_DATE_FR 
    , EFFECTIVE_DATE_TO 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_DPR_TYPE
    , P_SOB_ID
    , P_ORG_ID
    , P_PROGRESS_YEAR
    , P_DPR_RATE
    , P_REMARK
    , P_ENABLED_FLAG
    , P_EFFECTIVE_DATE_FR
    , P_EFFECTIVE_DATE_TO
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  
  END DPR_RATE_INSERT;

  PROCEDURE DPR_RATE_UPDATE
            ( W_DPR_TYPE          IN FI_DPR_RATE.DPR_TYPE%TYPE
            , W_SOB_ID            IN FI_DPR_RATE.SOB_ID%TYPE
            , W_PROGRESS_YEAR     IN FI_DPR_RATE.PROGRESS_YEAR%TYPE
            , P_DPR_RATE          IN FI_DPR_RATE.DPR_RATE%TYPE
            , P_REMARK            IN FI_DPR_RATE.REMARK%TYPE
            , P_ENABLED_FLAG      IN FI_DPR_RATE.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN FI_DPR_RATE.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN FI_DPR_RATE.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN FI_DPR_RATE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN

    UPDATE FI_DPR_RATE DR
      SET DPR_RATE          = P_DPR_RATE
        , REMARK            = P_REMARK
        , ENABLED_FLAG      = P_ENABLED_FLAG
        , EFFECTIVE_DATE_FR = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO = P_EFFECTIVE_DATE_TO
        , LAST_UPDATE_DATE  = V_SYSDATE
        , LAST_UPDATED_BY   = P_USER_ID
    WHERE DPR_TYPE          = W_DPR_TYPE
      AND SOB_ID            = W_SOB_ID
      AND PROGRESS_YEAR     = W_PROGRESS_YEAR
    ;
  
  
  END DPR_RATE_UPDATE;

-- 감가율 리턴.
  FUNCTION DPR_RATE_F
            ( W_DPR_TYPE          IN FI_DPR_RATE.DPR_TYPE%TYPE
            , W_DPR_METHOD_TYPE   IN VARCHAR2
            , W_SOB_ID            IN FI_DPR_RATE.SOB_ID%TYPE
            , W_PROGRESS_YEAR     IN FI_DPR_RATE.PROGRESS_YEAR%TYPE
            ) RETURN NUMBER
  AS
    V_DPR_RATE                    NUMBER;
    
  BEGIN
    IF W_DPR_METHOD_TYPE = '1' THEN
      V_DPR_RATE := TRUNC(1 / W_PROGRESS_YEAR, 3);
    ELSE
      BEGIN
        SELECT DR.DPR_RATE
          INTO V_DPR_RATE
          FROM FI_DPR_RATE DR
        WHERE DR.DPR_TYPE               = W_DPR_TYPE
          AND DR.SOB_ID                 = W_SOB_ID
          AND DR.PROGRESS_YEAR          = W_PROGRESS_YEAR
        ;
      EXCEPTION WHEN OTHERS THEN
        V_DPR_RATE := 0;
      END;
    END IF;
    RETURN V_DPR_RATE;
    
  END DPR_RATE_F;

-- 감가율 리턴 프로시져.
  PROCEDURE DPR_RATE_P
            ( W_DPR_TYPE          IN FI_DPR_RATE.DPR_TYPE%TYPE
            , W_DPR_METHOD_TYPE   IN VARCHAR2
            , W_SOB_ID            IN FI_DPR_RATE.SOB_ID%TYPE
            , W_PROGRESS_YEAR     IN FI_DPR_RATE.PROGRESS_YEAR%TYPE
            , O_DPR_RATE          OUT NUMBER
            )
  AS
  BEGIN
    O_DPR_RATE := DPR_RATE_F( W_DPR_TYPE
                            , W_DPR_METHOD_TYPE
                            , W_SOB_ID                            
                            , W_PROGRESS_YEAR
                            );
  END DPR_RATE_P;

END FI_DPR_RATE_G;
/
