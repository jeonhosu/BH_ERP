CREATE OR REPLACE PACKAGE GL_ACCOUNT_SET_G
AS

-- 회계 계정관리 조회.
  PROCEDURE SELECT_ACCOUNT_SET
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_ACCOUNT_SET_NAME     IN GL_ACCOUNT_SET.ACCOUNT_SET_NAME%TYPE
            , W_SOB_ID               IN GL_ACCOUNT_SET.SOB_ID%TYPE
            , W_ORG_ID               IN GL_ACCOUNT_SET.SOB_ID%TYPE
            );

-- 회계 계정관리 삽입.
  PROCEDURE INSERT_ACCOUNT_SET
            ( P_ACCOUNT_SET_ID   IN GL_ACCOUNT_SET.ACCOUNT_SET_ID%TYPE
            , P_ACCOUNT_SET_CODE IN GL_ACCOUNT_SET.ACCOUNT_SET_CODE%TYPE
            , P_ACCOUNT_SET_NAME IN GL_ACCOUNT_SET.ACCOUNT_SET_NAME%TYPE
            , P_ACCOUNT_LEVEL    IN GL_ACCOUNT_SET.ACCOUNT_LEVEL%TYPE
            , P_SOB_ID           IN GL_ACCOUNT_SET.SOB_ID%TYPE
            , P_ORG_ID           IN GL_ACCOUNT_SET.SOB_ID%TYPE
            , P_USER_ID          IN GL_ACCOUNT_SET.CREATED_BY%TYPE
            );

-- 회계 계정관리 수정.
  PROCEDURE UPDATE_ACCOUNT_SET
            ( W_ACCOUNT_SET_ID   IN GL_ACCOUNT_SET.ACCOUNT_SET_ID%TYPE
            , P_ACCOUNT_SET_NAME IN GL_ACCOUNT_SET.ACCOUNT_SET_NAME%TYPE
            , P_ACCOUNT_LEVEL    IN GL_ACCOUNT_SET.ACCOUNT_LEVEL%TYPE
            , P_USER_ID          IN GL_ACCOUNT_SET.CREATED_BY%TYPE
            );
            
-- Lookup : 회계계정관리 조회.
  PROCEDURE LU_ACCOUNT_SET
            ( P_CURSOR3         OUT TYPES.TCURSOR3
            );                       

END GL_ACCOUNT_SET_G;
/
CREATE OR REPLACE PACKAGE BODY GL_ACCOUNT_SET_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : GL_ACCOUNT_SET_G
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
            , W_ACCOUNT_SET_NAME     IN GL_ACCOUNT_SET.ACCOUNT_SET_NAME%TYPE
            , W_SOB_ID               IN GL_ACCOUNT_SET.SOB_ID%TYPE
            , W_ORG_ID               IN GL_ACCOUNT_SET.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT GAS.ACCOUNT_SET_ID
           , GAS.ACCOUNT_SET_CODE
           , GAS.ACCOUNT_SET_NAME
           , GAS.ACCOUNT_LEVEL
           , GAS.SOB_ID
           , SOB.SOB_DESCRIPTION
        FROM GL_ACCOUNT_SET GAS
          , EAPP_SET_OF_BOOKS_TLV SOB
       WHERE GAS.SOB_ID                 = SOB.SOB_ID
         AND GAS.ACCOUNT_SET_NAME       LIKE W_ACCOUNT_SET_NAME || '%'
         AND GAS.SOB_ID                 = W_SOB_ID
--         AND GAS.ORG_ID                 = W_ORG_ID
      ;

  END SELECT_ACCOUNT_SET;

-- 회계 계정관리 삽입.
  PROCEDURE INSERT_ACCOUNT_SET
            ( P_ACCOUNT_SET_ID   IN GL_ACCOUNT_SET.ACCOUNT_SET_ID%TYPE
            , P_ACCOUNT_SET_CODE IN GL_ACCOUNT_SET.ACCOUNT_SET_CODE%TYPE
            , P_ACCOUNT_SET_NAME IN GL_ACCOUNT_SET.ACCOUNT_SET_NAME%TYPE
            , P_ACCOUNT_LEVEL    IN GL_ACCOUNT_SET.ACCOUNT_LEVEL%TYPE
            , P_SOB_ID           IN GL_ACCOUNT_SET.SOB_ID%TYPE
            , P_ORG_ID           IN GL_ACCOUNT_SET.SOB_ID%TYPE
            , P_USER_ID          IN GL_ACCOUNT_SET.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                    GL_ACCOUNT_SET.CREATION_DATE%TYPE;
    V_RECORD_COUNT               NUMBER := 0;
    
  BEGIN
    V_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT := 0;
    BEGIN
      SELECT COUNT(GAS.ACCOUNT_SET_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM GL_ACCOUNT_SET GAS
       WHERE (GAS.ACCOUNT_SET_ID   = P_ACCOUNT_SET_ID
          OR GAS.ACCOUNT_SET_CODE  = P_ACCOUNT_SET_CODE)
/*         AND GAS.SOB_ID            = P_SOB_ID
         AND GAS.ORG_ID            = P_ORG_ID*/
      ;    
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT > 0 THEN
     RAISE ERRNUMS.Exist_Data;
    END IF;
    
    INSERT INTO GL_ACCOUNT_SET
    ( ACCOUNT_SET_ID
    , ACCOUNT_SET_CODE 
    , ACCOUNT_SET_NAME 
    , ACCOUNT_LEVEL 
    , SOB_ID 
    , ORG_ID
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_ACCOUNT_SET_ID
    , P_ACCOUNT_SET_CODE
    , P_ACCOUNT_SET_NAME
    , P_ACCOUNT_LEVEL
    , P_SOB_ID
    , P_ORG_ID
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
            ( W_ACCOUNT_SET_ID   IN GL_ACCOUNT_SET.ACCOUNT_SET_ID%TYPE
            , P_ACCOUNT_SET_NAME IN GL_ACCOUNT_SET.ACCOUNT_SET_NAME%TYPE
            , P_ACCOUNT_LEVEL    IN GL_ACCOUNT_SET.ACCOUNT_LEVEL%TYPE
            , P_USER_ID          IN GL_ACCOUNT_SET.CREATED_BY%TYPE
            )
  AS
  BEGIN
    UPDATE GL_ACCOUNT_SET
      SET ACCOUNT_SET_NAME = P_ACCOUNT_SET_NAME
        , ACCOUNT_LEVEL    = P_ACCOUNT_LEVEL
        , LAST_UPDATE_DATE = GET_LOCAL_DATE(SOB_ID)
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
        FROM GL_ACCOUNT_SET GAS
      ;
      
  END LU_ACCOUNT_SET;
  
END GL_ACCOUNT_SET_G;
/
