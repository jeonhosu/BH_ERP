CREATE OR REPLACE PACKAGE HRF_FOOD_COUPON_G
AS

-- 식권 사용수 조회.
  PROCEDURE SELECT_FOOD_COUPON
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_START_DATE                        IN HRF_FOOD_COUPON.FOOD_DATE%TYPE
            , W_END_DATE                          IN HRF_FOOD_COUPON.FOOD_DATE%TYPE
            , W_DEVICE_ID                         IN HRF_FOOD_COUPON.DEVICE_ID%TYPE
						, W_CORP_ID                           IN HRF_FOOD_COUPON.CORP_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_COUPON.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_COUPON.ORG_ID%TYPE
            , W_USER_ID                           IN HRF_FOOD_COUPON.CREATED_BY%TYPE
            );

-- 식권사용수 삽입.
  PROCEDURE INSERT_FOOD_COUPON
            ( P_FOOD_DATE        IN HRF_FOOD_COUPON.FOOD_DATE%TYPE
            , P_DEVICE_ID        IN HRF_FOOD_COUPON.DEVICE_ID%TYPE
            , P_CORP_ID          IN HRF_FOOD_COUPON.CORP_ID%TYPE
            , P_FOOD_COUNT       OUT HRF_FOOD_COUPON.FOOD_COUNT%TYPE
            , P_FOOD_1_COUNT     IN HRF_FOOD_COUPON.FOOD_1_COUNT%TYPE
            , P_FOOD_2_COUNT     IN HRF_FOOD_COUPON.FOOD_2_COUNT%TYPE
            , P_FOOD_3_COUNT     IN HRF_FOOD_COUPON.FOOD_3_COUNT%TYPE
            , P_FOOD_4_COUNT     IN HRF_FOOD_COUPON.FOOD_4_COUNT%TYPE
            , P_SNACK_1_COUNT    IN HRF_FOOD_COUPON.SNACK_1_COUNT%TYPE
            , P_SNACK_2_COUNT    IN HRF_FOOD_COUPON.SNACK_2_COUNT%TYPE
            , P_SNACK_3_COUNT    IN HRF_FOOD_COUPON.SNACK_3_COUNT%TYPE
            , P_SNACK_4_COUNT    IN HRF_FOOD_COUPON.SNACK_4_COUNT%TYPE
            , P_DESCRIPTION      IN HRF_FOOD_COUPON.DESCRIPTION%TYPE
            , P_SOB_ID           IN HRF_FOOD_COUPON.SOB_ID%TYPE
            , P_ORG_ID           IN HRF_FOOD_COUPON.ORG_ID%TYPE
            , P_USER_ID          IN HRF_FOOD_COUPON.CREATED_BY%TYPE
            );

-- 식권사용수 수정.
  PROCEDURE UPDATE_FOOD_COUPON
            ( W_FOOD_DATE        IN HRF_FOOD_COUPON.FOOD_DATE%TYPE
            , W_DEVICE_ID        IN HRF_FOOD_COUPON.DEVICE_ID%TYPE
            , W_CORP_ID          IN HRF_FOOD_COUPON.CORP_ID%TYPE
            , P_FOOD_COUNT       OUT HRF_FOOD_COUPON.FOOD_COUNT%TYPE
            , P_FOOD_1_COUNT     IN HRF_FOOD_COUPON.FOOD_1_COUNT%TYPE
            , P_FOOD_2_COUNT     IN HRF_FOOD_COUPON.FOOD_2_COUNT%TYPE
            , P_FOOD_3_COUNT     IN HRF_FOOD_COUPON.FOOD_3_COUNT%TYPE
            , P_FOOD_4_COUNT     IN HRF_FOOD_COUPON.FOOD_4_COUNT%TYPE
            , P_SNACK_1_COUNT    IN HRF_FOOD_COUPON.SNACK_1_COUNT%TYPE
            , P_SNACK_2_COUNT    IN HRF_FOOD_COUPON.SNACK_2_COUNT%TYPE
            , P_SNACK_3_COUNT    IN HRF_FOOD_COUPON.SNACK_3_COUNT%TYPE
            , P_SNACK_4_COUNT    IN HRF_FOOD_COUPON.SNACK_4_COUNT%TYPE
            , P_DESCRIPTION      IN HRF_FOOD_COUPON.DESCRIPTION%TYPE
            , W_SOB_ID           IN HRF_FOOD_COUPON.SOB_ID%TYPE
            , W_ORG_ID           IN HRF_FOOD_COUPON.ORG_ID%TYPE
            , P_USER_ID          IN HRF_FOOD_COUPON.CREATED_BY%TYPE
            );

-- 식권사용수 삭제.
  PROCEDURE DELETE_FOOD_COUPON
            ( W_FOOD_DATE        IN HRF_FOOD_COUPON.FOOD_DATE%TYPE
            , W_DEVICE_ID        IN HRF_FOOD_COUPON.DEVICE_ID%TYPE
            , W_CORP_ID          IN HRF_FOOD_COUPON.CORP_ID%TYPE
            , W_SOB_ID           IN HRF_FOOD_COUPON.SOB_ID%TYPE
            , W_ORG_ID           IN HRF_FOOD_COUPON.ORG_ID%TYPE
            );
            
END HRF_FOOD_COUPON_G;
/
CREATE OR REPLACE PACKAGE BODY HRF_FOOD_COUPON_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRF_FOOD_COUPON_G
/* DESCRIPTION  : 식권관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- 식권 사용수 조회.
  PROCEDURE SELECT_FOOD_COUPON
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_START_DATE                        IN HRF_FOOD_COUPON.FOOD_DATE%TYPE
            , W_END_DATE                          IN HRF_FOOD_COUPON.FOOD_DATE%TYPE
            , W_DEVICE_ID                         IN HRF_FOOD_COUPON.DEVICE_ID%TYPE
						, W_CORP_ID                           IN HRF_FOOD_COUPON.CORP_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_COUPON.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_COUPON.ORG_ID%TYPE
            , W_USER_ID                           IN HRF_FOOD_COUPON.CREATED_BY%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT FC.FOOD_DATE
           , FC.DEVICE_ID
           , HRM_COMMON_G.ID_NAME_F(FC.DEVICE_ID) AS DEVICE_NAME
           , FC.CORP_ID
           , HRM_CORP_MASTER_G.CORP_NAME_F(FC.CORP_ID) AS CORP_NAME
           , FC.FOOD_COUNT
           , FC.FOOD_1_COUNT
           , FC.FOOD_2_COUNT
           , FC.FOOD_3_COUNT
           , FC.FOOD_4_COUNT
           , FC.SNACK_1_COUNT     
           , FC.SNACK_2_COUNT
           , FC.SNACK_3_COUNT
           , FC.SNACK_4_COUNT
           , FC.DESCRIPTION
           , FC.CLOSED_YN
           , FC.CLOSED_DATE
           , HRM_PERSON_MASTER_G.NAME_F(FC.CLOSED_PERSON_ID) AS CLOSED_PERSON_NAME
        FROM HRF_FOOD_COUPON FC
          , HRF_FOOD_MANAGER FM
       WHERE FC.DEVICE_ID             = FM.DEVICE_ID
         AND FC.FOOD_DATE             BETWEEN W_START_DATE AND W_END_DATE
         AND FC.DEVICE_ID             = NVL(W_DEVICE_ID, FC.DEVICE_ID)
         AND FC.CORP_ID               = NVL(W_CORP_ID, FC.CORP_ID)
         AND FC.SOB_ID                = W_SOB_ID
         AND FC.ORG_ID                = W_ORG_ID
         AND FM.USER_ID               = W_USER_ID
       ;
         
  END SELECT_FOOD_COUPON;

-- 식권사용수 삽입.
  PROCEDURE INSERT_FOOD_COUPON
            ( P_FOOD_DATE        IN HRF_FOOD_COUPON.FOOD_DATE%TYPE
            , P_DEVICE_ID        IN HRF_FOOD_COUPON.DEVICE_ID%TYPE
            , P_CORP_ID          IN HRF_FOOD_COUPON.CORP_ID%TYPE
            , P_FOOD_COUNT       OUT HRF_FOOD_COUPON.FOOD_COUNT%TYPE
            , P_FOOD_1_COUNT     IN HRF_FOOD_COUPON.FOOD_1_COUNT%TYPE
            , P_FOOD_2_COUNT     IN HRF_FOOD_COUPON.FOOD_2_COUNT%TYPE
            , P_FOOD_3_COUNT     IN HRF_FOOD_COUPON.FOOD_3_COUNT%TYPE
            , P_FOOD_4_COUNT     IN HRF_FOOD_COUPON.FOOD_4_COUNT%TYPE
            , P_SNACK_1_COUNT    IN HRF_FOOD_COUPON.SNACK_1_COUNT%TYPE
            , P_SNACK_2_COUNT    IN HRF_FOOD_COUPON.SNACK_2_COUNT%TYPE
            , P_SNACK_3_COUNT    IN HRF_FOOD_COUPON.SNACK_3_COUNT%TYPE
            , P_SNACK_4_COUNT    IN HRF_FOOD_COUPON.SNACK_4_COUNT%TYPE
            , P_DESCRIPTION      IN HRF_FOOD_COUPON.DESCRIPTION%TYPE
            , P_SOB_ID           IN HRF_FOOD_COUPON.SOB_ID%TYPE
            , P_ORG_ID           IN HRF_FOOD_COUPON.ORG_ID%TYPE
            , P_USER_ID          IN HRF_FOOD_COUPON.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT    NUMBER := 0;
    
  BEGIN
    BEGIN
      SELECT COUNT(FC.FOOD_DATE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRF_FOOD_COUPON FC
       WHERE FC.FOOD_DATE             = P_FOOD_DATE
         AND FC.DEVICE_ID             = P_DEVICE_ID
         AND FC.CORP_ID               = P_CORP_ID
         AND FC.SOB_ID                = P_SOB_ID
         AND FC.ORG_ID                = P_ORG_ID
       ;    
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT > 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;
    P_FOOD_COUNT := NVL(P_FOOD_1_COUNT, 0) + NVL(P_FOOD_2_COUNT, 0) + NVL(P_FOOD_3_COUNT, 0) + NVL(P_FOOD_4_COUNT, 0) + 
                    NVL(P_SNACK_1_COUNT, 0) + NVL(P_SNACK_2_COUNT, 0) + NVL(P_SNACK_3_COUNT, 0) + NVL(P_SNACK_4_COUNT, 0);
                    
    INSERT INTO HRF_FOOD_COUPON
    ( FOOD_DATE
    , DEVICE_ID 
    , CORP_ID 
    , FOOD_COUNT 
    , FOOD_1_COUNT 
    , FOOD_2_COUNT 
    , FOOD_3_COUNT 
    , FOOD_4_COUNT 
    , SNACK_1_COUNT 
    , SNACK_2_COUNT 
    , SNACK_3_COUNT 
    , SNACK_4_COUNT 
    , DESCRIPTION 
    , SOB_ID 
    , ORG_ID 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY 
    ) VALUES
    ( P_FOOD_DATE
    , P_DEVICE_ID
    , P_CORP_ID
    , P_FOOD_COUNT
    , P_FOOD_1_COUNT
    , P_FOOD_2_COUNT
    , P_FOOD_3_COUNT
    , P_FOOD_4_COUNT
    , P_SNACK_1_COUNT
    , P_SNACK_2_COUNT
    , P_SNACK_3_COUNT
    , P_SNACK_4_COUNT
    , P_DESCRIPTION
    , P_SOB_ID
    , P_ORG_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END INSERT_FOOD_COUPON;

-- 식권사용수 수정.
  PROCEDURE UPDATE_FOOD_COUPON
            ( W_FOOD_DATE        IN HRF_FOOD_COUPON.FOOD_DATE%TYPE
            , W_DEVICE_ID        IN HRF_FOOD_COUPON.DEVICE_ID%TYPE
            , W_CORP_ID          IN HRF_FOOD_COUPON.CORP_ID%TYPE
            , P_FOOD_COUNT       OUT HRF_FOOD_COUPON.FOOD_COUNT%TYPE
            , P_FOOD_1_COUNT     IN HRF_FOOD_COUPON.FOOD_1_COUNT%TYPE
            , P_FOOD_2_COUNT     IN HRF_FOOD_COUPON.FOOD_2_COUNT%TYPE
            , P_FOOD_3_COUNT     IN HRF_FOOD_COUPON.FOOD_3_COUNT%TYPE
            , P_FOOD_4_COUNT     IN HRF_FOOD_COUPON.FOOD_4_COUNT%TYPE
            , P_SNACK_1_COUNT    IN HRF_FOOD_COUPON.SNACK_1_COUNT%TYPE
            , P_SNACK_2_COUNT    IN HRF_FOOD_COUPON.SNACK_2_COUNT%TYPE
            , P_SNACK_3_COUNT    IN HRF_FOOD_COUPON.SNACK_3_COUNT%TYPE
            , P_SNACK_4_COUNT    IN HRF_FOOD_COUPON.SNACK_4_COUNT%TYPE
            , P_DESCRIPTION      IN HRF_FOOD_COUPON.DESCRIPTION%TYPE
            , W_SOB_ID           IN HRF_FOOD_COUPON.SOB_ID%TYPE
            , W_ORG_ID           IN HRF_FOOD_COUPON.ORG_ID%TYPE
            , P_USER_ID          IN HRF_FOOD_COUPON.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                    HRF_FOOD_COUPON.CREATION_DATE%TYPE;

  BEGIN
    P_FOOD_COUNT := NVL(P_FOOD_1_COUNT, 0) + NVL(P_FOOD_2_COUNT, 0) + NVL(P_FOOD_3_COUNT, 0) + NVL(P_FOOD_4_COUNT, 0) + 
                    NVL(P_SNACK_1_COUNT, 0) + NVL(P_SNACK_2_COUNT, 0) + NVL(P_SNACK_3_COUNT, 0) + NVL(P_SNACK_4_COUNT, 0);
    V_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
    
    UPDATE HRF_FOOD_COUPON
      SET FOOD_COUNT       = P_FOOD_COUNT
        , FOOD_1_COUNT     = P_FOOD_1_COUNT
        , FOOD_2_COUNT     = P_FOOD_2_COUNT
        , FOOD_3_COUNT     = P_FOOD_3_COUNT
        , FOOD_4_COUNT     = P_FOOD_4_COUNT
        , SNACK_1_COUNT    = P_SNACK_1_COUNT
        , SNACK_2_COUNT    = P_SNACK_2_COUNT
        , SNACK_3_COUNT    = P_SNACK_3_COUNT
        , SNACK_4_COUNT    = P_SNACK_4_COUNT
        , DESCRIPTION      = P_DESCRIPTION
        , LAST_UPDATE_DATE = V_SYSDATE
        , LAST_UPDATED_BY  = P_USER_ID
      WHERE FOOD_DATE        = W_FOOD_DATE
        AND DEVICE_ID        = W_DEVICE_ID
        AND CORP_ID          = W_CORP_ID
        AND SOB_ID           = W_SOB_ID
        AND ORG_ID           = W_ORG_ID
        ;
  END UPDATE_FOOD_COUPON;

-- 식권사용수 삭제.
  PROCEDURE DELETE_FOOD_COUPON
            ( W_FOOD_DATE        IN HRF_FOOD_COUPON.FOOD_DATE%TYPE
            , W_DEVICE_ID        IN HRF_FOOD_COUPON.DEVICE_ID%TYPE
            , W_CORP_ID          IN HRF_FOOD_COUPON.CORP_ID%TYPE
            , W_SOB_ID           IN HRF_FOOD_COUPON.SOB_ID%TYPE
            , W_ORG_ID           IN HRF_FOOD_COUPON.ORG_ID%TYPE
            )
  AS
    V_RECORD_COUNT    NUMBER := 0;
    
  BEGIN
    -- 마감된 자료는 삭제 못함.
    BEGIN
      SELECT COUNT(FC.FOOD_DATE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRF_FOOD_COUPON FC
       WHERE FC.FOOD_DATE             = W_FOOD_DATE
         AND FC.DEVICE_ID             = W_DEVICE_ID
         AND FC.CORP_ID               = W_CORP_ID
         AND FC.SOB_ID                = W_SOB_ID
         AND FC.ORG_ID                = W_ORG_ID
         AND FC.CLOSED_YN             = 'Y'
       ;    
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT > 0 THEN
      RAISE ERRNUMS.Data_Closed;
    END IF;
    DELETE FROM HRF_FOOD_COUPON
      WHERE FOOD_DATE        = W_FOOD_DATE
        AND DEVICE_ID        = W_DEVICE_ID
        AND CORP_ID          = W_CORP_ID
        AND SOB_ID           = W_SOB_ID
        AND ORG_ID           = W_ORG_ID
        ;
  
  EXCEPTION 
    WHEN ERRNUMS.Data_Closed THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
  END DELETE_FOOD_COUPON;
  
END HRF_FOOD_COUPON_G;
/
