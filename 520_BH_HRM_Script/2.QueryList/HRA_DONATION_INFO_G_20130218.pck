CREATE OR REPLACE PACKAGE HRA_DONATION_INFO_G AS

  /*======================================================================/
       ++ 기부금 명세서 관리 ++
  /======================================================================*/
  PROCEDURE SELECT_DONATION_INFO
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

-- 삽입 : 기부금 명세서.
  PROCEDURE INSERT_DONATION_INFO
            ( P_DONATION_INFO_ID OUT HRA_DONATION_INFO.DONATION_INFO_ID%TYPE
            , P_YEAR_YYYY        IN HRA_DONATION_INFO.YEAR_YYYY%TYPE
            , P_PERSON_ID        IN HRA_DONATION_INFO.PERSON_ID%TYPE
            , P_SOB_ID           IN HRA_DONATION_INFO.SOB_ID%TYPE
            , P_ORG_ID           IN HRA_DONATION_INFO.ORG_ID%TYPE
            , P_DONA_TYPE        IN HRA_DONATION_INFO.DONA_TYPE%TYPE
            , P_FAMILY_NAME      IN HRA_DONATION_INFO.FAMILY_NAME%TYPE
            , P_REPRE_NUM        IN HRA_DONATION_INFO.REPRE_NUM%TYPE
            , P_RELATION_CODE    IN HRA_DONATION_INFO.RELATION_CODE%TYPE
            , P_CORP_NAME        IN HRA_DONATION_INFO.CORP_NAME%TYPE
            , P_CORP_TAX_REG_NO  IN HRA_DONATION_INFO.CORP_TAX_REG_NO%TYPE
            , P_DONA_DATE        IN HRA_DONATION_INFO.DONA_DATE%TYPE
            , P_SUB_DESCRIPTION  IN HRA_DONATION_INFO.SUB_DESCRIPTION%TYPE
            , P_DONA_COUNT       IN HRA_DONATION_INFO.DONA_COUNT%TYPE
            , P_DONA_AMT         IN HRA_DONATION_INFO.DONA_AMT%TYPE
            , P_DONA_BILL_NUM    IN HRA_DONATION_INFO.DONA_BILL_NUM%TYPE
            , P_DESCRIPTION      IN HRA_DONATION_INFO.DESCRIPTION%TYPE
            , P_USER_ID          IN HRA_DONATION_INFO.CREATED_BY%TYPE
            );

-- 수정 : 기부금 명세서.
  PROCEDURE UPDATE_DONATION_INFO
            ( W_DONATION_INFO_ID IN HRA_DONATION_INFO.DONATION_INFO_ID%TYPE
            , P_YEAR_YYYY        IN HRA_DONATION_INFO.YEAR_YYYY%TYPE
            , P_PERSON_ID        IN HRA_DONATION_INFO.PERSON_ID%TYPE
            , P_SOB_ID           IN HRA_DONATION_INFO.SOB_ID%TYPE
            , P_ORG_ID           IN HRA_DONATION_INFO.ORG_ID%TYPE
            , P_DONA_TYPE        IN HRA_DONATION_INFO.DONA_TYPE%TYPE
            , P_FAMILY_NAME      IN HRA_DONATION_INFO.FAMILY_NAME%TYPE
            , P_REPRE_NUM        IN HRA_DONATION_INFO.REPRE_NUM%TYPE
            , P_RELATION_CODE    IN HRA_DONATION_INFO.RELATION_CODE%TYPE
            , P_CORP_NAME        IN HRA_DONATION_INFO.CORP_NAME%TYPE
            , P_CORP_TAX_REG_NO  IN HRA_DONATION_INFO.CORP_TAX_REG_NO%TYPE
            , P_DONA_DATE        IN HRA_DONATION_INFO.DONA_DATE%TYPE
            , P_SUB_DESCRIPTION  IN HRA_DONATION_INFO.SUB_DESCRIPTION%TYPE
            , P_DONA_COUNT       IN HRA_DONATION_INFO.DONA_COUNT%TYPE
            , P_DONA_AMT         IN HRA_DONATION_INFO.DONA_AMT%TYPE
            , P_DONA_BILL_NUM    IN HRA_DONATION_INFO.DONA_BILL_NUM%TYPE
            , P_DESCRIPTION      IN HRA_DONATION_INFO.DESCRIPTION%TYPE
            , P_USER_ID          IN HRA_DONATION_INFO.CREATED_BY%TYPE
            );

-- 삭제 : 기부금 명세서.
  PROCEDURE DELETE_DONATION_INFO
            ( W_DONATION_INFO_ID IN HRA_DONATION_INFO.DONATION_INFO_ID%TYPE
            );
            
  /*======================================================================/
       ++ 기부금 조정 명세서 관리 ++
  /======================================================================*/
  PROCEDURE SELECT_DONATION_ADJUSTMENT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

-- 삽입 : 기부금 조정명세서.
  PROCEDURE INSERT_DONATION_ADJUSTMENT
            ( P_DONATION_ADJUSTMENT_ID OUT HRA_DONATION_ADJUSTMENT.DONATION_ADJUSTMENT_ID%TYPE
            , P_YEAR_YYYY              IN HRA_DONATION_ADJUSTMENT.YEAR_YYYY%TYPE
            , P_PERSON_ID              IN HRA_DONATION_ADJUSTMENT.PERSON_ID%TYPE
            , P_SOB_ID                 IN HRA_DONATION_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID                 IN HRA_DONATION_ADJUSTMENT.ORG_ID%TYPE
            , P_DONA_YYYY              IN HRA_DONATION_ADJUSTMENT.DONA_YYYY%TYPE
            , P_DONA_TYPE              IN HRA_DONATION_ADJUSTMENT.DONA_TYPE%TYPE
            , P_DONA_AMT               IN HRA_DONATION_ADJUSTMENT.DONA_AMT%TYPE
            , P_PRE_DONA_DED_AMT       IN HRA_DONATION_ADJUSTMENT.PRE_DONA_DED_AMT%TYPE
            , P_TOTAL_DONA_AMT         IN HRA_DONATION_ADJUSTMENT.TOTAL_DONA_AMT%TYPE
            , P_DONA_DED_AMT           IN HRA_DONATION_ADJUSTMENT.DONA_DED_AMT%TYPE
            , P_LAPSE_DONA_AMT         IN HRA_DONATION_ADJUSTMENT.LAPSE_DONA_AMT%TYPE
            , P_NEXT_DONA_AMT          IN HRA_DONATION_ADJUSTMENT.NEXT_DONA_AMT%TYPE
            , P_DESCRIPTION            IN HRA_DONATION_ADJUSTMENT.DESCRIPTION%TYPE
            , P_USER_ID                IN HRA_DONATION_ADJUSTMENT.CREATED_BY%TYPE
            );

-- 수정 : 기부금 조정명세서.
  PROCEDURE UPDATE_DONATION_ADJUSTMENT
            ( W_DONATION_ADJUSTMENT_ID IN HRA_DONATION_ADJUSTMENT.DONATION_ADJUSTMENT_ID%TYPE
            , P_YEAR_YYYY              IN HRA_DONATION_ADJUSTMENT.YEAR_YYYY%TYPE
            , P_PERSON_ID              IN HRA_DONATION_ADJUSTMENT.PERSON_ID%TYPE
            , P_SOB_ID                 IN HRA_DONATION_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID                 IN HRA_DONATION_ADJUSTMENT.ORG_ID%TYPE
            , P_DONA_YYYY              IN HRA_DONATION_ADJUSTMENT.DONA_YYYY%TYPE
            , P_DONA_TYPE              IN HRA_DONATION_ADJUSTMENT.DONA_TYPE%TYPE
            , P_DONA_AMT               IN HRA_DONATION_ADJUSTMENT.DONA_AMT%TYPE
            , P_PRE_DONA_DED_AMT       IN HRA_DONATION_ADJUSTMENT.PRE_DONA_DED_AMT%TYPE
            , P_TOTAL_DONA_AMT         IN HRA_DONATION_ADJUSTMENT.TOTAL_DONA_AMT%TYPE
            , P_DONA_DED_AMT           IN HRA_DONATION_ADJUSTMENT.DONA_DED_AMT%TYPE
            , P_LAPSE_DONA_AMT         IN HRA_DONATION_ADJUSTMENT.LAPSE_DONA_AMT%TYPE
            , P_NEXT_DONA_AMT          IN HRA_DONATION_ADJUSTMENT.NEXT_DONA_AMT%TYPE
            , P_DESCRIPTION            IN HRA_DONATION_ADJUSTMENT.DESCRIPTION%TYPE
            , P_USER_ID                IN HRA_DONATION_ADJUSTMENT.CREATED_BY%TYPE
            );

-- 삭제 : 기부금 조정명세서.
  PROCEDURE DELETE_DONATION_ADJUSTMENT
            ( W_DONATION_ADJUSTMENT_ID IN HRA_DONATION_ADJUSTMENT.DONATION_ADJUSTMENT_ID%TYPE
            );
            
  /*======================================================================/
       ++ 기부금 조정 명세서 생성 ++
  /======================================================================*/
  PROCEDURE SET_DONATION_ADJUSTMENT
            ( P_CORP_ID           IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );
            
END HRA_DONATION_INFO_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_DONATION_INFO_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_SUPPORT_FAMILY_G
/* Description  : 연말정산 기부금 관리 패키지
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
  /*======================================================================/
       ++ 기부금 명세서 관리 ++
  /======================================================================*/
  PROCEDURE SELECT_DONATION_INFO
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT DI.PERSON_ID
          , DI.DONA_TYPE
          , HRM_COMMON_G.CODE_NAME_F('DONATION_TYPE', DI.DONA_TYPE, DI.SOB_ID, DI.ORG_ID) AS DONA_DESC
          , DI.FAMILY_NAME
          , DI.REPRE_NUM
          , DI.RELATION_CODE
          , HRM_COMMON_G.CODE_NAME_F('YEAR_RELATION', DI.RELATION_CODE, DI.SOB_ID, DI.ORG_ID) AS RELATION_DESC
          , DI.CORP_NAME
          , DI.CORP_TAX_REG_NO
          , DI.DONA_DATE
          , DI.DONA_COUNT
          , DI.DONA_AMT
          , DI.DONA_BILL_NUM
          , DI.SUB_DESCRIPTION
          , DI.DONATION_INFO_ID
        FROM HRA_DONATION_INFO DI
          , HRM_PERSON_MASTER PM
      WHERE DI.PERSON_ID          = PM.PERSON_ID
        AND DI.YEAR_YYYY          = P_YEAR_YYYY
        AND DI.PERSON_ID          = P_PERSON_ID
        AND DI.SOB_ID             = P_SOB_ID
        AND DI.ORG_ID             = P_ORG_ID
      ORDER BY DI.DONA_TYPE
       ;
  END SELECT_DONATION_INFO;

-- 삽입 : 기부금 명세서.
  PROCEDURE INSERT_DONATION_INFO
            ( P_DONATION_INFO_ID OUT HRA_DONATION_INFO.DONATION_INFO_ID%TYPE
            , P_YEAR_YYYY        IN HRA_DONATION_INFO.YEAR_YYYY%TYPE
            , P_PERSON_ID        IN HRA_DONATION_INFO.PERSON_ID%TYPE
            , P_SOB_ID           IN HRA_DONATION_INFO.SOB_ID%TYPE
            , P_ORG_ID           IN HRA_DONATION_INFO.ORG_ID%TYPE
            , P_DONA_TYPE        IN HRA_DONATION_INFO.DONA_TYPE%TYPE
            , P_FAMILY_NAME      IN HRA_DONATION_INFO.FAMILY_NAME%TYPE
            , P_REPRE_NUM        IN HRA_DONATION_INFO.REPRE_NUM%TYPE
            , P_RELATION_CODE    IN HRA_DONATION_INFO.RELATION_CODE%TYPE
            , P_CORP_NAME        IN HRA_DONATION_INFO.CORP_NAME%TYPE
            , P_CORP_TAX_REG_NO  IN HRA_DONATION_INFO.CORP_TAX_REG_NO%TYPE
            , P_DONA_DATE        IN HRA_DONATION_INFO.DONA_DATE%TYPE
            , P_SUB_DESCRIPTION  IN HRA_DONATION_INFO.SUB_DESCRIPTION%TYPE
            , P_DONA_COUNT       IN HRA_DONATION_INFO.DONA_COUNT%TYPE
            , P_DONA_AMT         IN HRA_DONATION_INFO.DONA_AMT%TYPE
            , P_DONA_BILL_NUM    IN HRA_DONATION_INFO.DONA_BILL_NUM%TYPE
            , P_DESCRIPTION      IN HRA_DONATION_INFO.DESCRIPTION%TYPE
            , P_USER_ID          IN HRA_DONATION_INFO.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE             DATE  := GET_LOCAL_DATE(P_SOB_ID);
    V_BASE_YN             VARCHAR2(3);  -- 기본공제 여부 --
  BEGIN
    BEGIN
      SELECT NVL(SF.BASE_YN, 'N') AS BASE_YN
        INTO V_BASE_YN
        FROM HRA_SUPPORT_FAMILY SF
       WHERE SF.YEAR_YYYY    = P_YEAR_YYYY
         AND SF.PERSON_ID    = P_PERSON_ID
         AND SF.SOB_ID       = P_SOB_ID
         AND SF.ORG_ID       = P_ORG_ID
         AND SF.REPRE_NUM    = P_REPRE_NUM
      ;
    EXCEPTION WHEN OTHERS THEN
      V_BASE_YN := 'N';
    END;
    IF P_RELATION_CODE = '0' THEN
      V_BASE_YN := 'Y';
    END IF;
    IF V_BASE_YN != 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, '본인 또는 기본공제 대상자의 기부금에 대해서만 입력 가능합니다. 확인하세요.');
      RETURN;
    END IF;
    
    SELECT HRA_DONATION_INFO_S1.NEXTVAL
      INTO P_DONATION_INFO_ID
      FROM DUAL;

    INSERT INTO HRA_DONATION_INFO
    ( DONATION_INFO_ID
    , YEAR_YYYY 
    , PERSON_ID 
    , SOB_ID 
    , ORG_ID 
    , DONA_TYPE 
    , FAMILY_NAME 
    , REPRE_NUM 
    , RELATION_CODE 
    , CORP_NAME 
    , CORP_TAX_REG_NO 
    , DONA_DATE 
    , SUB_DESCRIPTION 
    , DONA_COUNT 
    , DONA_AMT 
    , DONA_BILL_NUM 
    , DESCRIPTION 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_DONATION_INFO_ID
    , P_YEAR_YYYY
    , P_PERSON_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_DONA_TYPE
    , P_FAMILY_NAME
    , P_REPRE_NUM
    , P_RELATION_CODE
    , P_CORP_NAME
    , P_CORP_TAX_REG_NO
    , P_DONA_DATE
    , P_SUB_DESCRIPTION
    , NVL(P_DONA_COUNT, 0)
    , NVL(P_DONA_AMT, 0)
    , P_DONA_BILL_NUM
    , P_DESCRIPTION
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  END INSERT_DONATION_INFO;

-- 수정 : 기부금 명세서.
  PROCEDURE UPDATE_DONATION_INFO
            ( W_DONATION_INFO_ID IN HRA_DONATION_INFO.DONATION_INFO_ID%TYPE
            , P_YEAR_YYYY        IN HRA_DONATION_INFO.YEAR_YYYY%TYPE
            , P_PERSON_ID        IN HRA_DONATION_INFO.PERSON_ID%TYPE
            , P_SOB_ID           IN HRA_DONATION_INFO.SOB_ID%TYPE
            , P_ORG_ID           IN HRA_DONATION_INFO.ORG_ID%TYPE
            , P_DONA_TYPE        IN HRA_DONATION_INFO.DONA_TYPE%TYPE
            , P_FAMILY_NAME      IN HRA_DONATION_INFO.FAMILY_NAME%TYPE
            , P_REPRE_NUM        IN HRA_DONATION_INFO.REPRE_NUM%TYPE
            , P_RELATION_CODE    IN HRA_DONATION_INFO.RELATION_CODE%TYPE
            , P_CORP_NAME        IN HRA_DONATION_INFO.CORP_NAME%TYPE
            , P_CORP_TAX_REG_NO  IN HRA_DONATION_INFO.CORP_TAX_REG_NO%TYPE
            , P_DONA_DATE        IN HRA_DONATION_INFO.DONA_DATE%TYPE
            , P_SUB_DESCRIPTION  IN HRA_DONATION_INFO.SUB_DESCRIPTION%TYPE
            , P_DONA_COUNT       IN HRA_DONATION_INFO.DONA_COUNT%TYPE
            , P_DONA_AMT         IN HRA_DONATION_INFO.DONA_AMT%TYPE
            , P_DONA_BILL_NUM    IN HRA_DONATION_INFO.DONA_BILL_NUM%TYPE
            , P_DESCRIPTION      IN HRA_DONATION_INFO.DESCRIPTION%TYPE
            , P_USER_ID          IN HRA_DONATION_INFO.CREATED_BY%TYPE
            )
  IS
    V_SYSDATE             DATE  := GET_LOCAL_DATE(P_SOB_ID);
    V_BASE_YN             VARCHAR2(3);  -- 기본공제 여부 --
  BEGIN
    BEGIN
      SELECT NVL(SF.BASE_YN, 'N') AS BASE_YN
        INTO V_BASE_YN
        FROM HRA_SUPPORT_FAMILY SF
       WHERE SF.YEAR_YYYY    = P_YEAR_YYYY
         AND SF.PERSON_ID    = P_PERSON_ID
         AND SF.SOB_ID       = P_SOB_ID
         AND SF.ORG_ID       = P_ORG_ID
         AND SF.REPRE_NUM    = P_REPRE_NUM
      ;
    EXCEPTION WHEN OTHERS THEN
      V_BASE_YN := 'N';
    END;
    IF P_RELATION_CODE = '0' THEN
      V_BASE_YN := 'Y';
    END IF;
    IF V_BASE_YN != 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, '본인 또는 기본공제 대상자의 기부금에 대해서만 입력 가능합니다. 확인하세요.');
      RETURN;
    END IF;
    
    UPDATE HRA_DONATION_INFO
      SET DONA_TYPE        = P_DONA_TYPE
        , FAMILY_NAME      = P_FAMILY_NAME
        , REPRE_NUM        = P_REPRE_NUM
        , RELATION_CODE    = P_RELATION_CODE
        , CORP_NAME        = P_CORP_NAME
        , CORP_TAX_REG_NO  = P_CORP_TAX_REG_NO
        , DONA_DATE        = P_DONA_DATE
        , SUB_DESCRIPTION  = P_SUB_DESCRIPTION
        , DONA_COUNT       = NVL(P_DONA_COUNT, 0)
        , DONA_AMT         = NVL(P_DONA_AMT, 0)
        , DONA_BILL_NUM    = P_DONA_BILL_NUM
        , DESCRIPTION      = P_DESCRIPTION
        , LAST_UPDATE_DATE = V_SYSDATE
        , LAST_UPDATED_BY  = P_USER_ID
    WHERE DONATION_INFO_ID = W_DONATION_INFO_ID;
  END UPDATE_DONATION_INFO;

-- 삭제 : 기부금 명세서.
  PROCEDURE DELETE_DONATION_INFO
            ( W_DONATION_INFO_ID IN HRA_DONATION_INFO.DONATION_INFO_ID%TYPE
            )
  AS
  BEGIN
    DELETE FROM HRA_DONATION_INFO
    WHERE DONATION_INFO_ID = W_DONATION_INFO_ID;
  END DELETE_DONATION_INFO;


  /*======================================================================/
       ++ 기부금 조정 명세서 관리 ++
  /======================================================================*/
  PROCEDURE SELECT_DONATION_ADJUSTMENT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT DA.PERSON_ID
          , DA.DONA_TYPE
          , HRM_COMMON_G.CODE_NAME_F('DONATION_TYPE', DA.DONA_TYPE, DA.SOB_ID, DA.ORG_ID) AS DONA_DESC
          , DA.DONA_YYYY
          , DA.DONA_AMT AS DONA_AMT
          , DA.PRE_DONA_DED_AMT AS PRE_DONA_DED_AMT
          , DA.TOTAL_DONA_AMT AS TOTAL_DONA_AMT
          , DA.DONA_DED_AMT AS DONA_DED_AMT
          , DA.LAPSE_DONA_AMT AS LAPSE_DONA_AMT
          , DA.NEXT_DONA_AMT AS NEXT_DONA_AMT
          , DA.DONATION_ADJUSTMENT_ID
        FROM HRA_DONATION_ADJUSTMENT DA
      WHERE DA.YEAR_YYYY          = P_YEAR_YYYY
        AND DA.PERSON_ID          = P_PERSON_ID
        AND DA.SOB_ID             = P_SOB_ID
        AND DA.ORG_ID             = P_ORG_ID
      ORDER BY DA.DONA_TYPE, DA.DONA_YYYY
      ;
  END SELECT_DONATION_ADJUSTMENT;

-- 삽입 : 기부금 조정명세서.
  PROCEDURE INSERT_DONATION_ADJUSTMENT
            ( P_DONATION_ADJUSTMENT_ID OUT HRA_DONATION_ADJUSTMENT.DONATION_ADJUSTMENT_ID%TYPE
            , P_YEAR_YYYY              IN HRA_DONATION_ADJUSTMENT.YEAR_YYYY%TYPE
            , P_PERSON_ID              IN HRA_DONATION_ADJUSTMENT.PERSON_ID%TYPE
            , P_SOB_ID                 IN HRA_DONATION_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID                 IN HRA_DONATION_ADJUSTMENT.ORG_ID%TYPE
            , P_DONA_YYYY              IN HRA_DONATION_ADJUSTMENT.DONA_YYYY%TYPE
            , P_DONA_TYPE              IN HRA_DONATION_ADJUSTMENT.DONA_TYPE%TYPE
            , P_DONA_AMT               IN HRA_DONATION_ADJUSTMENT.DONA_AMT%TYPE
            , P_PRE_DONA_DED_AMT       IN HRA_DONATION_ADJUSTMENT.PRE_DONA_DED_AMT%TYPE
            , P_TOTAL_DONA_AMT         IN HRA_DONATION_ADJUSTMENT.TOTAL_DONA_AMT%TYPE
            , P_DONA_DED_AMT           IN HRA_DONATION_ADJUSTMENT.DONA_DED_AMT%TYPE
            , P_LAPSE_DONA_AMT         IN HRA_DONATION_ADJUSTMENT.LAPSE_DONA_AMT%TYPE
            , P_NEXT_DONA_AMT          IN HRA_DONATION_ADJUSTMENT.NEXT_DONA_AMT%TYPE
            , P_DESCRIPTION            IN HRA_DONATION_ADJUSTMENT.DESCRIPTION%TYPE
            , P_USER_ID                IN HRA_DONATION_ADJUSTMENT.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    
    V_ADJUST_YEAR_COUNT         HRA_DONATION_ADJUSTMENT.ADJUST_YEAR_COUNT%TYPE := 0;
    V_AVAILABLE_YEAR            NUMBER := 0;
  BEGIN
    -- 일반적인 검증 --
    IF P_YEAR_YYYY IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('EAPP_10068'));
      RETURN;  
    END IF;
    IF P_PERSON_ID IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10028'));
      RETURN;  
    END IF;
    IF P_DONA_YYYY IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, '기부년도가 정확하지 않습니다. 확인하세요');
      RETURN;  
    END IF;
    IF P_DONA_TYPE IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, '기부금 유형이 정확하지 않습니다. 확인하세요');
      RETURN;  
    END IF;
    
    IF P_DONA_YYYY = P_YEAR_YYYY THEN
      -- 당해년도 기부금은 검증 안함.
      NULL;
    ELSE
      -- 기부년도 검증 --
      BEGIN
        SELECT DT.AVAILABLE_YEAR
          INTO V_AVAILABLE_YEAR
          FROM HRM_DONATION_TYPE_V DT
        WHERE DT.DONATION_TYPE      = P_DONA_TYPE
          AND DT.SOB_ID             = P_SOB_ID
          AND DT.ORG_ID             = P_ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_AVAILABLE_YEAR := 0;
      END;
      IF TO_NUMBER(P_DONA_YYYY) < (TO_NUMBER(P_YEAR_YYYY) - V_AVAILABLE_YEAR) THEN
        RAISE_APPLICATION_ERROR(-20001, '기부금 이월공제 년도 범위를 벗어났습니다. 확인하세요');
        RETURN; 
      END IF;
    END IF;
    -- 금액 상관관계 검증 --
    --1.기부금액 - 전년도공제금액 = 공제대상금액.
    IF(NVL(P_DONA_AMT, 0) - NVL(P_PRE_DONA_DED_AMT, 0)) <> NVL(P_TOTAL_DONA_AMT, 0) THEN
      RAISE_APPLICATION_ERROR(-20001, '[공제대상금액 = 기부금액 - 전년까지 공제된 기부금액]과 같아야 합니다.');
      RETURN; 
    END IF;
    --2.해당년도 공제금액.
    IF NVL(P_TOTAL_DONA_AMT, 0) < NVL(P_DONA_DED_AMT, 0) THEN
      RAISE_APPLICATION_ERROR(-20001, '해당년도 공제금액은 공제대상금액보다 클수는 없습니다.');
      RETURN; 
    END IF;
    /*--2.공제대상금액 = 해당년도공제금액 + 소멸금액 + 이월금액.
    IF NVL(P_TOTAL_DONA_AMT, 0) <> (NVL(P_DONA_DED_AMT, 0) + NVL(P_LAPSE_DONA_AMT, 0) + NVL(V_ADJUST_YEAR_COUNT, 0)) THEN
      RAISE_APPLICATION_ERROR(-20001, '[해당년도 공제액 = 해당년도공제금액 + 소멸금액 + 이월금액]과 같아야 합니다.');
      RETURN; 
    END IF;*/
    
    SELECT HRA_DONATION_ADJUSTMENT_S1.NEXTVAL
      INTO P_DONATION_ADJUSTMENT_ID
      FROM DUAL;

    INSERT INTO HRA_DONATION_ADJUSTMENT
    ( DONATION_ADJUSTMENT_ID
    , YEAR_YYYY 
    , PERSON_ID 
    , SOB_ID 
    , ORG_ID 
    , DONA_YYYY 
    , DONA_TYPE 
    , DONA_AMT 
    , PRE_DONA_DED_AMT 
    , TOTAL_DONA_AMT 
    , DONA_DED_AMT 
    , LAPSE_DONA_AMT 
    , NEXT_DONA_AMT 
    , ADJUST_YEAR_COUNT 
    , DESCRIPTION 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_DONATION_ADJUSTMENT_ID
    , P_YEAR_YYYY
    , P_PERSON_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_DONA_YYYY
    , P_DONA_TYPE
    , NVL(P_DONA_AMT, 0)
    , NVL(P_PRE_DONA_DED_AMT, 0)
    , NVL(P_TOTAL_DONA_AMT, 0)
    , NVL(P_DONA_DED_AMT, 0)
    , NVL(P_LAPSE_DONA_AMT, 0)
    , NVL(P_NEXT_DONA_AMT, 0)
    , NVL(V_ADJUST_YEAR_COUNT, 0)
    , P_DESCRIPTION
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  END INSERT_DONATION_ADJUSTMENT;

-- 수정 : 기부금 조정명세서.
  PROCEDURE UPDATE_DONATION_ADJUSTMENT
            ( W_DONATION_ADJUSTMENT_ID IN HRA_DONATION_ADJUSTMENT.DONATION_ADJUSTMENT_ID%TYPE
            , P_YEAR_YYYY              IN HRA_DONATION_ADJUSTMENT.YEAR_YYYY%TYPE
            , P_PERSON_ID              IN HRA_DONATION_ADJUSTMENT.PERSON_ID%TYPE
            , P_SOB_ID                 IN HRA_DONATION_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID                 IN HRA_DONATION_ADJUSTMENT.ORG_ID%TYPE
            , P_DONA_YYYY              IN HRA_DONATION_ADJUSTMENT.DONA_YYYY%TYPE
            , P_DONA_TYPE              IN HRA_DONATION_ADJUSTMENT.DONA_TYPE%TYPE
            , P_DONA_AMT               IN HRA_DONATION_ADJUSTMENT.DONA_AMT%TYPE
            , P_PRE_DONA_DED_AMT       IN HRA_DONATION_ADJUSTMENT.PRE_DONA_DED_AMT%TYPE
            , P_TOTAL_DONA_AMT         IN HRA_DONATION_ADJUSTMENT.TOTAL_DONA_AMT%TYPE
            , P_DONA_DED_AMT           IN HRA_DONATION_ADJUSTMENT.DONA_DED_AMT%TYPE
            , P_LAPSE_DONA_AMT         IN HRA_DONATION_ADJUSTMENT.LAPSE_DONA_AMT%TYPE
            , P_NEXT_DONA_AMT          IN HRA_DONATION_ADJUSTMENT.NEXT_DONA_AMT%TYPE
            , P_DESCRIPTION            IN HRA_DONATION_ADJUSTMENT.DESCRIPTION%TYPE
            , P_USER_ID                IN HRA_DONATION_ADJUSTMENT.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    
    V_ADJUST_YEAR_COUNT         HRA_DONATION_ADJUSTMENT.ADJUST_YEAR_COUNT%TYPE := 0;
    V_AVAILABLE_YEAR            NUMBER := 0;
  BEGIN
    -- 일반적인 검증 --
    IF P_YEAR_YYYY IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('EAPP_10068'));
      RETURN;  
    END IF;
    IF P_PERSON_ID IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10028'));
      RETURN;  
    END IF;
    IF P_DONA_YYYY IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, '기부년도가 정확하지 않습니다. 확인하세요');
      RETURN;  
    END IF;
    IF P_DONA_TYPE IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, '기부금 유형이 정확하지 않습니다. 확인하세요');
      RETURN;  
    END IF;
    
    IF P_DONA_YYYY = P_YEAR_YYYY THEN
      -- 당해년도 기부금은 검증 안함.
      NULL;
    ELSE
      -- 기부년도 검증 --
      BEGIN
        SELECT DT.AVAILABLE_YEAR
          INTO V_AVAILABLE_YEAR
          FROM HRM_DONATION_TYPE_V DT
        WHERE DT.DONATION_TYPE      = P_DONA_TYPE
          AND DT.SOB_ID             = P_SOB_ID
          AND DT.ORG_ID             = P_ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_AVAILABLE_YEAR := 0;
      END;
      IF TO_NUMBER(P_DONA_YYYY) < (TO_NUMBER(P_YEAR_YYYY) - V_AVAILABLE_YEAR) THEN
        RAISE_APPLICATION_ERROR(-20001, '기부금 이월공제 년도 범위를 벗어났습니다. 확인하세요');
        RETURN; 
      END IF;
    END IF;
    -- 금액 상관관계 검증 --
    --1.기부금액 - 전년도공제금액 = 공제대상금액.
    IF(NVL(P_DONA_AMT, 0) - NVL(P_PRE_DONA_DED_AMT, 0)) <> NVL(P_TOTAL_DONA_AMT, 0) THEN
      RAISE_APPLICATION_ERROR(-20001, '[공제대상금액 = 기부금액 - 전년까지 공제된 기부금액]과 같아야 합니다.');
      RETURN; 
    END IF;
    --2.해당년도 공제금액.
    IF NVL(P_TOTAL_DONA_AMT, 0) < NVL(P_DONA_DED_AMT, 0) THEN
      RAISE_APPLICATION_ERROR(-20001, '해당년도 공제금액은 공제대상금액보다 클수는 없습니다.');
      RETURN; 
    END IF;
    /*--2.공제대상금액 = 해당년도공제금액 + 소멸금액 + 이월금액.
    IF NVL(P_TOTAL_DONA_AMT, 0) <> (NVL(P_DONA_DED_AMT, 0) + NVL(P_LAPSE_DONA_AMT, 0) + NVL(V_ADJUST_YEAR_COUNT, 0)) THEN
      RAISE_APPLICATION_ERROR(-20001, '[공제대상 금액 = 해당년도공제금액 + 소멸금액 + 이월금액]과 같아야 합니다.');
      RETURN; 
    END IF;*/
    
    -- 금액 상관관계 검증 필요.
    UPDATE HRA_DONATION_ADJUSTMENT
      SET DONA_YYYY              = P_DONA_YYYY
        , DONA_TYPE              = P_DONA_TYPE
        , DONA_AMT               = NVL(P_DONA_AMT, 0)
        , PRE_DONA_DED_AMT       = NVL(P_PRE_DONA_DED_AMT, 0)
        , TOTAL_DONA_AMT         = NVL(P_TOTAL_DONA_AMT, 0)
        , DONA_DED_AMT           = NVL(P_DONA_DED_AMT, 0)
        , LAPSE_DONA_AMT         = NVL(P_LAPSE_DONA_AMT, 0)
        , NEXT_DONA_AMT          = NVL(P_NEXT_DONA_AMT, 0)
        , ADJUST_YEAR_COUNT      = NVL(V_ADJUST_YEAR_COUNT, 0)
        , DESCRIPTION            = P_DESCRIPTION
        , LAST_UPDATE_DATE       = V_SYSDATE
        , LAST_UPDATED_BY        = P_USER_ID
    WHERE DONATION_ADJUSTMENT_ID = W_DONATION_ADJUSTMENT_ID;
  END UPDATE_DONATION_ADJUSTMENT;

-- 삭제 : 기부금 조정명세서.
  PROCEDURE DELETE_DONATION_ADJUSTMENT
            ( W_DONATION_ADJUSTMENT_ID IN HRA_DONATION_ADJUSTMENT.DONATION_ADJUSTMENT_ID%TYPE
            )
  AS
  BEGIN
    DELETE FROM HRA_DONATION_ADJUSTMENT
    WHERE DONATION_ADJUSTMENT_ID = W_DONATION_ADJUSTMENT_ID;
  END DELETE_DONATION_ADJUSTMENT;
  
            
  /*======================================================================/
       ++ 기부금 조정 명세서 생성 ++
  /======================================================================*/
  PROCEDURE SET_DONATION_ADJUSTMENT
            ( P_CORP_ID           IN VARCHAR2
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE                   DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_STD_DATE                  DATE;  -- 기준일자 --
    V_DONATION_ADJUSTMENT_ID    NUMBER;
  BEGIN
    O_STATUS := 'F';
    
    -- 처리 대상 산출을 위한 기준일자 : 연말 재직자에 대해서만 적용 --
    V_STD_DATE := TO_DATE(P_YEAR_YYYY || '-12-31', 'YYYY-MM-DD');
    
    -- 기존데이터 삭제.
    DELETE FROM HRA_DONATION_ADJUSTMENT DA
    WHERE DA.YEAR_YYYY        = P_YEAR_YYYY
      AND DA.PERSON_ID        = NVL(P_PERSON_ID, DA.PERSON_ID)
      AND DA.SOB_ID           = P_SOB_ID
      AND DA.ORG_ID           = P_ORG_ID
    ;
    -- 1. 기부금중 전년도 잔액금액 이월처리(기부금 조정명세서).
    FOR C1 IN ( SELECT DT.DONATION_TYPE
                    , DT.DONATION_TYPE_NAME
                    , NVL(DT.AVAILABLE_YEAR, 0) AS AVAILABLE_YEAR
                    , DT.SOB_ID
                    , DT.ORG_ID
                  FROM HRM_DONATION_TYPE_V DT
                WHERE DT.SOB_ID         = P_SOB_ID
                  AND DT.ORG_ID         = P_ORG_ID
                  AND DT.AVAILABLE_YEAR > 0           -- 이월가능한 기부유형만 처리.
                  AND DT.ENABLED_FLAG   = 'Y'
                  AND DT.EFFECTIVE_DATE_FR <= TO_DATE(P_YEAR_YYYY || '-12-31', 'YYYY-MM-DD')
                  AND (DT.EFFECTIVE_DATE_TO IS NULL OR DT.EFFECTIVE_DATE_TO >= TO_DATE(P_YEAR_YYYY || '-12-31', 'YYYY-MM-DD'))
                ORDER BY DT.DONATION_TYPE
              )
    LOOP
      FOR R1 IN ( SELECT P_YEAR_YYYY AS YEAR_YYYY
                      , DA.PERSON_ID
                      , DA.DONA_YYYY
                      , DA.DONA_TYPE
                      , DA.DONA_AMT
                      , SUM(DA.DONA_DED_AMT) AS DONA_DED_AMT
                    FROM HRA_DONATION_ADJUSTMENT DA
                       , HRM_PERSON_MASTER       PM
                  WHERE DA.PERSON_ID        = PM.PERSON_ID
                    AND DA.DONA_YYYY        < P_YEAR_YYYY
                    AND DA.DONA_YYYY        >= NVL(TO_NUMBER(P_YEAR_YYYY), 0) - NVL(C1.AVAILABLE_YEAR, 0)
                    AND DA.DONA_TYPE        = C1.DONATION_TYPE
                    AND DA.SOB_ID           = C1.SOB_ID
                    AND DA.ORG_ID           = C1.ORG_ID
                    AND DA.PERSON_ID        = NVL(P_PERSON_ID, DA.PERSON_ID)
                    AND PM.CORP_ID          = P_CORP_ID
                    AND PM.JOIN_DATE        <= V_STD_DATE
                    AND (PM.RETIRE_DATE     >= V_STD_DATE OR PM.RETIRE_DATE IS NULL)
                  GROUP BY DA.DONA_YYYY
                      , DA.PERSON_ID
                      , DA.DONA_TYPE
                      , DA.DONA_AMT
                  HAVING NVL(DA.DONA_AMT, 0) - NVL(SUM(DA.DONA_DED_AMT), 0) - NVL(SUM(DA.LAPSE_DONA_AMT), 0) > 0
                  ORDER BY DA.DONA_YYYY, DA.DONA_TYPE
                )
      LOOP
        SELECT HRA_DONATION_ADJUSTMENT_S1.NEXTVAL
          INTO V_DONATION_ADJUSTMENT_ID
          FROM DUAL;
          
        INSERT INTO HRA_DONATION_ADJUSTMENT DA
        ( DONATION_ADJUSTMENT_ID 
        , YEAR_YYYY 
        , PERSON_ID 
        , SOB_ID 
        , ORG_ID 
        , DONA_YYYY       
        , DONA_TYPE       
        , DONA_AMT
        , PRE_DONA_DED_AMT
        , TOTAL_DONA_AMT  
        , ADJUST_YEAR_COUNT
        , CREATION_DATE 
        , CREATED_BY 
        , LAST_UPDATE_DATE
        , LAST_UPDATED_BY 
        ) VALUES
        ( V_DONATION_ADJUSTMENT_ID 
        , R1.YEAR_YYYY
        , R1.PERSON_ID 
        , C1.SOB_ID 
        , C1.ORG_ID 
        , R1.DONA_YYYY
        , R1.DONA_TYPE       
        , NVL(R1.DONA_AMT, 0)
        , NVL(R1.DONA_DED_AMT, 0)
        , NVL(R1.DONA_AMT, 0) - NVL(R1.DONA_DED_AMT, 0)
        , NVL(TO_NUMBER(R1.YEAR_YYYY), 0) - NVL(TO_NUMBER(R1.DONA_YYYY), 0)
        , V_SYSDATE 
        , P_USER_ID 
        , V_SYSDATE 
        , P_USER_ID 
        );
      END LOOP R1;
    END LOOP C1;
    
    -- 2. 당해년도 기부금 이관처리(기부금 명세서).
    FOR C1 IN ( SELECT DI.YEAR_YYYY
                    , DI.PERSON_ID
                    , DI.SOB_ID
                    , DI.ORG_ID
                    , DI.DONA_TYPE
                    , HRM_COMMON_G.CODE_NAME_F('DONATION_TYPE', DI.DONA_TYPE, DI.SOB_ID, DI.ORG_ID) AS DONA_DESC
                    , SUM(DI.DONA_AMT) AS DONA_AMT
                  FROM HRA_DONATION_INFO DI
                WHERE DI.YEAR_YYYY      = P_YEAR_YYYY
                  AND DI.PERSON_ID      = NVL(P_PERSON_ID, DI.PERSON_ID)
                  AND DI.SOB_ID         = P_SOB_ID
                  AND DI.ORG_ID         = P_ORG_ID
                GROUP BY DI.YEAR_YYYY
                    , DI.PERSON_ID
                    , DI.SOB_ID
                    , DI.ORG_ID
                    , DI.DONA_TYPE
              )
    LOOP
      SELECT HRA_DONATION_ADJUSTMENT_S1.NEXTVAL
        INTO V_DONATION_ADJUSTMENT_ID
        FROM DUAL;
        
      INSERT INTO HRA_DONATION_ADJUSTMENT DA
      ( DONATION_ADJUSTMENT_ID 
      , YEAR_YYYY 
      , PERSON_ID 
      , SOB_ID 
      , ORG_ID 
      , DONA_YYYY       
      , DONA_TYPE       
      , DONA_AMT        
      , TOTAL_DONA_AMT  
      , ADJUST_YEAR_COUNT
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY 
      ) VALUES
      ( V_DONATION_ADJUSTMENT_ID 
      , C1.YEAR_YYYY 
      , C1.PERSON_ID 
      , C1.SOB_ID 
      , C1.ORG_ID 
      , C1.YEAR_YYYY           -- DONA_YYYY.
      , C1.DONA_TYPE       
      , NVL(C1.DONA_AMT, 0)
      , NVL(C1.DONA_AMT, 0)  
      , 0
      , V_SYSDATE 
      , P_USER_ID 
      , V_SYSDATE 
      , P_USER_ID 
      );
    END LOOP C1;    
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10112');
  EXCEPTION WHEN OTHERS THEN
    O_STATUS := 'F';
    O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
  END SET_DONATION_ADJUSTMENT;
  
END HRA_DONATION_INFO_G;
/
