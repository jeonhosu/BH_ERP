CREATE OR REPLACE PACKAGE FI_ACCOUNT_SET_G
AS

-- 회계 계정관리 조회.
  PROCEDURE SELECT_ACCOUNT_SET
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_ACCOUNT_SET_ID       IN FI_ACCOUNT_SET.ACCOUNT_SET_ID%TYPE
            );

-- 회계 계정관리 삽입.
  PROCEDURE INSERT_ACCOUNT_SET
            ( P_ACCOUNT_SET_ID   IN FI_ACCOUNT_SET.ACCOUNT_SET_ID%TYPE
            , P_ACCOUNT_SET_CODE IN FI_ACCOUNT_SET.ACCOUNT_SET_CODE%TYPE
            , P_ACCOUNT_SET_NAME IN FI_ACCOUNT_SET.ACCOUNT_SET_NAME%TYPE
            , P_ACCOUNT_LEVEL    IN FI_ACCOUNT_SET.ACCOUNT_LEVEL%TYPE
            , P_USER_ID          IN FI_ACCOUNT_SET.CREATED_BY%TYPE
            , P_SOB_ID           IN NUMBER
            );

-- 회계 계정관리 수정.
  PROCEDURE UPDATE_ACCOUNT_SET
            ( W_ACCOUNT_SET_ID   IN FI_ACCOUNT_SET.ACCOUNT_SET_ID%TYPE
            , P_ACCOUNT_SET_NAME IN FI_ACCOUNT_SET.ACCOUNT_SET_NAME%TYPE
            , P_ACCOUNT_LEVEL    IN FI_ACCOUNT_SET.ACCOUNT_LEVEL%TYPE
            , P_USER_ID          IN FI_ACCOUNT_SET.CREATED_BY%TYPE
            , P_SOB_ID           IN NUMBER
            );
            
-- Lookup : 회계계정관리 조회.
  PROCEDURE LU_ACCOUNT_SET
            ( P_CURSOR3         OUT TYPES.TCURSOR3
            );                       

END FI_ACCOUNT_SET_G;
/
CREATE OR REPLACE PACKAGE BODY FI_ACCOUNT_SET_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_ACCOUNT_SET_G
/* Description  : 회계 계정 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 회계 계정관리 조회.
  PROCEDURE SELECT_ACCOUNT_SET
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_ACCOUNT_SET_ID       IN FI_ACCOUNT_SET.ACCOUNT_SET_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT GAS.ACCOUNT_SET_ID
           , GAS.ACCOUNT_SET_CODE
           , GAS.ACCOUNT_SET_NAME
           , GAS.ACCOUNT_LEVEL
        FROM FI_ACCOUNT_SET GAS
       WHERE GAS.ACCOUNT_SET_ID     = W_ACCOUNT_SET_ID
      ;

  END SELECT_ACCOUNT_SET;

-- 회계 계정관리 삽입.
  PROCEDURE INSERT_ACCOUNT_SET
            ( P_ACCOUNT_SET_ID   IN FI_ACCOUNT_SET.ACCOUNT_SET_ID%TYPE
            , P_ACCOUNT_SET_CODE IN FI_ACCOUNT_SET.ACCOUNT_SET_CODE%TYPE
            , P_ACCOUNT_SET_NAME IN FI_ACCOUNT_SET.ACCOUNT_SET_NAME%TYPE
            , P_ACCOUNT_LEVEL    IN FI_ACCOUNT_SET.ACCOUNT_LEVEL%TYPE
            , P_USER_ID          IN FI_ACCOUNT_SET.CREATED_BY%TYPE
            , P_SOB_ID           IN NUMBER
            )
  AS
    V_SYSDATE                    FI_ACCOUNT_SET.CREATION_DATE%TYPE;
    V_RECORD_COUNT               NUMBER := 0;
    
  BEGIN
    V_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT := 0;
    BEGIN
      SELECT COUNT(GAS.ACCOUNT_SET_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_ACCOUNT_SET GAS
       WHERE (GAS.ACCOUNT_SET_ID   = P_ACCOUNT_SET_ID
          OR GAS.ACCOUNT_SET_CODE  = P_ACCOUNT_SET_CODE)
      ;    
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT > 0 THEN
     RAISE ERRNUMS.Exist_Data;
    END IF;
    
    INSERT INTO FI_ACCOUNT_SET
    ( ACCOUNT_SET_ID
    , ACCOUNT_SET_CODE 
    , ACCOUNT_SET_NAME 
    , ACCOUNT_LEVEL 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_ACCOUNT_SET_ID
    , P_ACCOUNT_SET_CODE
    , P_ACCOUNT_SET_NAME
    , P_ACCOUNT_LEVEL
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
 
  EXCEPTION 
    WHEN ERRNUMS.Exist_Data THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END INSERT_ACCOUNT_SET;

-- 회계 계정관리 수정.
  PROCEDURE UPDATE_ACCOUNT_SET
            ( W_ACCOUNT_SET_ID   IN FI_ACCOUNT_SET.ACCOUNT_SET_ID%TYPE
            , P_ACCOUNT_SET_NAME IN FI_ACCOUNT_SET.ACCOUNT_SET_NAME%TYPE
            , P_ACCOUNT_LEVEL    IN FI_ACCOUNT_SET.ACCOUNT_LEVEL%TYPE
            , P_USER_ID          IN FI_ACCOUNT_SET.CREATED_BY%TYPE
            , P_SOB_ID           IN NUMBER
            )
  AS
  BEGIN
    UPDATE FI_ACCOUNT_SET
      SET ACCOUNT_SET_NAME = P_ACCOUNT_SET_NAME
        , ACCOUNT_LEVEL    = P_ACCOUNT_LEVEL
        , LAST_UPDATE_DATE = GET_LOCAL_DATE(P_SOB_ID)
        , LAST_UPDATED_BY  = P_USER_ID
    WHERE ACCOUNT_SET_ID   = W_ACCOUNT_SET_ID
    ;
    
  END UPDATE_ACCOUNT_SET;

-- Lookup : 회계계정관리 조회.
  PROCEDURE LU_ACCOUNT_SET
            ( P_CURSOR3         OUT TYPES.TCURSOR3
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT GAS.ACCOUNT_SET_NAME
           , GAS.ACCOUNT_SET_CODE
           , GAS.ACCOUNT_LEVEL
           , GAS.ACCOUNT_SET_ID
        FROM FI_ACCOUNT_SET GAS
      ;
      
  END LU_ACCOUNT_SET;
  
END FI_ACCOUNT_SET_G;
/
