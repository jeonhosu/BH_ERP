CREATE OR REPLACE PACKAGE FI_FORM_G
AS

-- 재무제표양식관리 HEADER.
  PROCEDURE SELECT_FORM_H
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_FORM_TYPE_ID         IN FI_FORM_HEADER.FORM_TYPE_ID%TYPE
            , W_ITEM_LEVEL           IN FI_FORM_HEADER.ITEM_LEVEL%TYPE
            , W_ITEM_NAME            IN FI_FORM_HEADER.FORM_ITEM_NAME%TYPE
            , W_SOB_ID               IN FI_FORM_HEADER.SOB_ID%TYPE
            , W_ORG_ID               IN FI_FORM_HEADER.ORG_ID%TYPE
            );

-- 재무제표양식 헤더 삽입.
  PROCEDURE INSERT_FORM_H
            ( P_FORM_HEADER_ID      OUT FI_FORM_HEADER.FORM_HEADER_ID%TYPE
            , P_FORM_TYPE_ID        IN FI_FORM_HEADER.FORM_TYPE_ID%TYPE
            , P_SOB_ID              IN FI_FORM_HEADER.SOB_ID%TYPE
            , P_ORG_ID              IN FI_FORM_HEADER.ORG_ID%TYPE
            , P_FORM_ITEM_CODE      IN FI_FORM_HEADER.FORM_ITEM_CODE%TYPE
            , P_FORM_ITEM_NAME      IN FI_FORM_HEADER.FORM_ITEM_NAME%TYPE
            , P_SORT_SEQ            IN FI_FORM_HEADER.SORT_SEQ%TYPE
            , P_ITEM_LEVEL          IN FI_FORM_HEADER.ITEM_LEVEL%TYPE
            , P_COLUMN_POSITION_NUM IN FI_FORM_HEADER.COLUMN_POSITION_NUM%TYPE
            , P_ACCOUNT_DR_CR       IN FI_FORM_HEADER.ACCOUNT_DR_CR%TYPE
            , P_MINUS_SIGN_DISPLAY  IN FI_FORM_HEADER.MINUS_SIGN_DISPLAY%TYPE
            , P_DISPLAY_YN          IN FI_FORM_HEADER.DISPLAY_YN%TYPE
            , P_AMOUNT_PRINT_YN     IN FI_FORM_HEADER.AMOUNT_PRINT_YN%TYPE
            , P_UNDER_LINE_YN       IN FI_FORM_HEADER.UNDER_LINE_YN%TYPE
            , P_ENABLED_FLAG        IN FI_FORM_HEADER.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR   IN FI_FORM_HEADER.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO   IN FI_FORM_HEADER.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID             IN FI_FORM_HEADER.CREATED_BY%TYPE
            , P_FORM_ITEM_TYPE      IN FI_FORM_HEADER.FORM_ITEM_TYPE%TYPE
            , P_FORM_ITEM_CLASS     IN FI_FORM_HEADER.FORM_ITEM_CLASS%TYPE
            , P_RELATE_HEADER_ID    IN FI_FORM_HEADER.RELATE_HEADER_ID%TYPE
            );

-- 재무제표양식 헤더 수정.
  PROCEDURE UPDATE_FORM_H
            ( W_FORM_HEADER_ID      IN FI_FORM_HEADER.FORM_HEADER_ID%TYPE
            , W_SOB_ID              IN FI_FORM_HEADER.SOB_ID%TYPE
            , P_FORM_ITEM_NAME      IN FI_FORM_HEADER.FORM_ITEM_NAME%TYPE
            , P_SORT_SEQ            IN FI_FORM_HEADER.SORT_SEQ%TYPE
            , P_ITEM_LEVEL          IN FI_FORM_HEADER.ITEM_LEVEL%TYPE
            , P_COLUMN_POSITION_NUM IN FI_FORM_HEADER.COLUMN_POSITION_NUM%TYPE
            , P_ACCOUNT_DR_CR       IN FI_FORM_HEADER.ACCOUNT_DR_CR%TYPE
            , P_MINUS_SIGN_DISPLAY  IN FI_FORM_HEADER.MINUS_SIGN_DISPLAY%TYPE
            , P_DISPLAY_YN          IN FI_FORM_HEADER.DISPLAY_YN%TYPE
            , P_AMOUNT_PRINT_YN     IN FI_FORM_HEADER.AMOUNT_PRINT_YN%TYPE
            , P_UNDER_LINE_YN       IN FI_FORM_HEADER.UNDER_LINE_YN%TYPE
            , P_ENABLED_FLAG        IN FI_FORM_HEADER.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR   IN FI_FORM_HEADER.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO   IN FI_FORM_HEADER.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID             IN FI_FORM_HEADER.CREATED_BY%TYPE
            , P_FORM_ITEM_TYPE      IN FI_FORM_HEADER.FORM_ITEM_TYPE%TYPE
            , P_FORM_ITEM_CLASS     IN FI_FORM_HEADER.FORM_ITEM_CLASS%TYPE
            , P_RELATE_HEADER_ID    IN FI_FORM_HEADER.RELATE_HEADER_ID%TYPE
            );

-- 재무제표양식 헤더 삭제.
  PROCEDURE DELETE_FORM_H
            ( W_FORM_HEADER_ID      IN FI_FORM_HEADER.FORM_HEADER_ID%TYPE
            );
            
---------------------------------------------------------------------------------------------------
-- 재무제표 보고서 양식 라인 조회.
  PROCEDURE SELECT_FORM_L
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_FORM_HEADER_ID       IN FI_FORM_LINE.FORM_HEADER_ID%TYPE
            , W_SOB_ID               IN FI_FORM_LINE.SOB_ID%TYPE
            , W_ORG_ID               IN FI_FORM_LINE.ORG_ID%TYPE
            );

-- 재무제표 보고서 양식 라인 삽입.
  PROCEDURE INSERT_FORM_L
            ( P_FORM_LINE_ID            OUT FI_FORM_LINE.FORM_LINE_ID%TYPE
            , P_SOB_ID                  IN FI_FORM_LINE.SOB_ID%TYPE
            , P_ORG_ID                  IN FI_FORM_LINE.ORG_ID%TYPE
            , P_FORM_HEADER_ID          IN FI_FORM_LINE.FORM_HEADER_ID%TYPE
            , P_JOIN_LINE_CONTROL_ID    IN FI_FORM_LINE.JOIN_LINE_CONTROL_ID%TYPE
            , P_ITEM_SIGN_SHOW          IN FI_FORM_LINE.ITEM_SIGN_SHOW%TYPE
            , P_ENABLED_FLAG            IN FI_FORM_LINE.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR       IN FI_FORM_LINE.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO       IN FI_FORM_LINE.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID                 IN FI_FORM_LINE.CREATED_BY%TYPE
            );

-- 재무제표 보고서 양식 라인 수정.
  PROCEDURE UPDATE_FORM_L
            ( W_FORM_LINE_ID            IN FI_FORM_LINE.FORM_LINE_ID%TYPE
            , P_SOB_ID                  IN FI_FORM_LINE.SOB_ID%TYPE
            , P_FORM_HEADER_ID          IN FI_FORM_LINE.FORM_HEADER_ID%TYPE
            , P_JOIN_LINE_CONTROL_ID    IN FI_FORM_LINE.JOIN_LINE_CONTROL_ID%TYPE
            , P_ITEM_SIGN_SHOW          IN FI_FORM_LINE.ITEM_SIGN_SHOW%TYPE
            , P_ENABLED_FLAG            IN FI_FORM_LINE.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR       IN FI_FORM_LINE.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO       IN FI_FORM_LINE.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID                 IN FI_FORM_LINE.CREATED_BY%TYPE
            );

-- 재무제표 보고서 양식 라인 삭제.
  PROCEDURE DELETE_FORM_L
            ( W_FORM_LINE_ID            IN FI_FORM_LINE.FORM_LINE_ID%TYPE
            );

-- 재무제표양식관리 조회.
  PROCEDURE SELECT_FORM
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_FORM_TYPE_ID         IN FI_FORM_HEADER.FORM_TYPE_ID%TYPE
            , W_SOB_ID               IN FI_FORM_HEADER.SOB_ID%TYPE
            , W_ORG_ID               IN FI_FORM_HEADER.ORG_ID%TYPE
            );

-- 재무제표양식관리 - 누락 계정 체크.
  PROCEDURE SELECT_MISS_ACCOUNT
            ( P_CURSOR2              OUT TYPES.TCURSOR2
            , W_FORM_TYPE_ID         IN FI_FORM_HEADER.FORM_TYPE_ID%TYPE
            , W_SOB_ID               IN FI_FORM_HEADER.SOB_ID%TYPE
            , W_ORG_ID               IN FI_FORM_HEADER.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 보고서 양식 레벨별 항목 LOOKUP.
  PROCEDURE LU_FORM_ITEM_LEVEL
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_FORM_HEADER.SOB_ID%TYPE
            , W_FORM_TYPE_ID         IN FI_FORM_HEADER.FORM_TYPE_ID%TYPE
            , W_ITEM_LEVEL           IN FI_FORM_HEADER.ITEM_LEVEL%TYPE
            , W_ENABLED_YN           IN FI_AUTO_JOURNAL_HEADER.ENABLED_FLAG%TYPE
            );

-- 보고서 양식 관련항목 LOOKUP.
  PROCEDURE LU_RELATE_FORM_ITEM
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_FORM_HEADER.SOB_ID%TYPE
            , W_FORM_TYPE_ID         IN FI_FORM_HEADER.FORM_TYPE_ID%TYPE
            , W_ITEM_LEVEL           IN FI_FORM_HEADER.ITEM_LEVEL%TYPE
            , W_ENABLED_YN           IN FI_AUTO_JOURNAL_HEADER.ENABLED_FLAG%TYPE
            );
            
---------------------------------------------------------------------------------------------------
-- HEADER iTEM의 LAST_LEVEL CHECK.
  FUNCTION LAST_LEVEL_CHECK_F
            ( W_FORM_TYPE_ID         IN FI_FORM_HEADER.FORM_TYPE_ID%TYPE            
            , W_SOB_ID               IN FI_FORM_HEADER.SOB_ID%TYPE
            , W_ITEM_LEVEL           IN FI_FORM_HEADER.ITEM_LEVEL%TYPE
            ) RETURN VARCHAR2;
            
-- 보고서 양식 항목코드 RETURN.
  FUNCTION FORM_ITEM_CODE_F
            ( W_FORM_HEADER_ID       IN FI_FORM_HEADER.FORM_HEADER_ID%TYPE
            , W_SOB_ID               IN FI_FORM_HEADER.SOB_ID%TYPE
            ) RETURN VARCHAR2;
            
-- 보고서 양식 항목명 RETURN.
  FUNCTION FORM_ITEM_NAME_F
            ( W_FORM_HEADER_ID       IN FI_FORM_HEADER.FORM_HEADER_ID%TYPE
            , W_SOB_ID               IN FI_FORM_HEADER.SOB_ID%TYPE
            ) RETURN VARCHAR2;

END FI_FORM_G;


 
/
CREATE OR REPLACE PACKAGE BODY FI_FORM_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_FORM_G
/* Description  : 재무제표 보고서 양식 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 재무제표양식관리 HEADER.
  PROCEDURE SELECT_FORM_H
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_FORM_TYPE_ID         IN FI_FORM_HEADER.FORM_TYPE_ID%TYPE
            , W_ITEM_LEVEL           IN FI_FORM_HEADER.ITEM_LEVEL%TYPE
            , W_ITEM_NAME            IN FI_FORM_HEADER.FORM_ITEM_NAME%TYPE
            , W_SOB_ID               IN FI_FORM_HEADER.SOB_ID%TYPE
            , W_ORG_ID               IN FI_FORM_HEADER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT FH.FORM_HEADER_ID
           , FH.FORM_TYPE_ID
           , FH.SOB_ID
           , FH.FORM_ITEM_CODE
           , FH.FORM_ITEM_NAME
           , FH.SORT_SEQ
           , FH.ITEM_LEVEL
           , FH.LAST_LEVEL_YN
           , FH.COLUMN_POSITION_NUM
           , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', FH.ACCOUNT_DR_CR, FH.SOB_ID) AS ACCOUNT_DR_CR_NAME
           , FH.ACCOUNT_DR_CR
           , FH.MINUS_SIGN_DISPLAY
           , FH.FORM_ITEM_TYPE
           , FI_COMMON_G.CODE_NAME_F('FORM_ITEM_TYPE', FH.FORM_ITEM_TYPE, FH.SOB_ID) AS FORM_ITEM_TYPE_NAME
           , FH.FORM_ITEM_CLASS
           , FI_COMMON_G.CODE_NAME_F('FORM_ITEM_CLASS', FH.FORM_ITEM_CLASS, FH.SOB_ID) AS FORM_ITEM_CLASS_NAME
           , FH.RELATE_HEADER_ID
           , LTRIM(R_FH.FORM_ITEM_NAME) AS RELATE_HEADER_NAME
           , FH.DISPLAY_YN
           , FH.AMOUNT_PRINT_YN
           , FH.UNDER_LINE_YN
           , FH.ENABLED_FLAG
           , FH.EFFECTIVE_DATE_FR
           , FH.EFFECTIVE_DATE_TO
        FROM FI_FORM_HEADER FH
          , FI_FORM_HEADER R_FH
       WHERE FH.RELATE_HEADER_ID        = R_FH.FORM_HEADER_ID(+)
         AND FH.FORM_TYPE_ID            = W_FORM_TYPE_ID
         AND FH.ITEM_LEVEL              = NVL(W_ITEM_LEVEL, FH.ITEM_LEVEL)
         AND FH.FORM_ITEM_NAME          LIKE W_ITEM_NAME || '%'
         AND FH.SOB_ID                  = W_SOB_ID
      ORDER BY FH.SORT_SEQ
      ;

  END SELECT_FORM_H;

-- 재무제표양식 헤더 삽입.
  PROCEDURE INSERT_FORM_H
            ( P_FORM_HEADER_ID      OUT FI_FORM_HEADER.FORM_HEADER_ID%TYPE
            , P_FORM_TYPE_ID        IN FI_FORM_HEADER.FORM_TYPE_ID%TYPE
            , P_SOB_ID              IN FI_FORM_HEADER.SOB_ID%TYPE
            , P_ORG_ID              IN FI_FORM_HEADER.ORG_ID%TYPE
            , P_FORM_ITEM_CODE      IN FI_FORM_HEADER.FORM_ITEM_CODE%TYPE
            , P_FORM_ITEM_NAME      IN FI_FORM_HEADER.FORM_ITEM_NAME%TYPE
            , P_SORT_SEQ            IN FI_FORM_HEADER.SORT_SEQ%TYPE
            , P_ITEM_LEVEL          IN FI_FORM_HEADER.ITEM_LEVEL%TYPE
            , P_COLUMN_POSITION_NUM IN FI_FORM_HEADER.COLUMN_POSITION_NUM%TYPE
            , P_ACCOUNT_DR_CR       IN FI_FORM_HEADER.ACCOUNT_DR_CR%TYPE
            , P_MINUS_SIGN_DISPLAY  IN FI_FORM_HEADER.MINUS_SIGN_DISPLAY%TYPE
            , P_DISPLAY_YN          IN FI_FORM_HEADER.DISPLAY_YN%TYPE
            , P_AMOUNT_PRINT_YN     IN FI_FORM_HEADER.AMOUNT_PRINT_YN%TYPE
            , P_UNDER_LINE_YN       IN FI_FORM_HEADER.UNDER_LINE_YN%TYPE
            , P_ENABLED_FLAG        IN FI_FORM_HEADER.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR   IN FI_FORM_HEADER.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO   IN FI_FORM_HEADER.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID             IN FI_FORM_HEADER.CREATED_BY%TYPE
            , P_FORM_ITEM_TYPE      IN FI_FORM_HEADER.FORM_ITEM_TYPE%TYPE
            , P_FORM_ITEM_CLASS     IN FI_FORM_HEADER.FORM_ITEM_CLASS%TYPE
            , P_RELATE_HEADER_ID    IN FI_FORM_HEADER.RELATE_HEADER_ID%TYPE
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_LAST_LEVEL_YN     FI_FORM_HEADER.LAST_LEVEL_YN%TYPE;
    V_RECORD_COUNT      NUMBER := 0;

  BEGIN
    -- 동일한 전표유형/업무분류코드,업무구분,차대,계정 ID존재 체크.
    BEGIN
      SELECT COUNT(FH.FORM_TYPE_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_FORM_HEADER FH
       WHERE FH.SOB_ID                  = P_SOB_ID
         AND FH.FORM_TYPE_ID            = P_FORM_TYPE_ID
         AND FH.FORM_ITEM_CODE          = P_FORM_ITEM_CODE
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;

    -- 최종여부 체크.
    V_LAST_LEVEL_YN := LAST_LEVEL_CHECK_F ( W_FORM_TYPE_ID => P_FORM_TYPE_ID
                                          , W_SOB_ID => P_SOB_ID
                                          , W_ITEM_LEVEL => P_ITEM_LEVEL);

    SELECT FI_FORM_HEADER_S1.NEXTVAL
      INTO P_FORM_HEADER_ID
      FROM DUAL;

    INSERT INTO FI_FORM_HEADER
    ( FORM_HEADER_ID
    , FORM_TYPE_ID 
    , SOB_ID 
    , ORG_ID 
    , FORM_ITEM_CODE 
    , FORM_ITEM_NAME 
    , SORT_SEQ 
    , ITEM_LEVEL 
    , LAST_LEVEL_YN 
    , COLUMN_POSITION_NUM 
    , ACCOUNT_DR_CR 
    , MINUS_SIGN_DISPLAY 
    , DISPLAY_YN 
    , AMOUNT_PRINT_YN 
    , UNDER_LINE_YN 
    , ENABLED_FLAG 
    , EFFECTIVE_DATE_FR 
    , EFFECTIVE_DATE_TO 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY
    , FORM_ITEM_TYPE
    , FORM_ITEM_CLASS
    , RELATE_HEADER_ID)
    VALUES
    ( P_FORM_HEADER_ID
    , P_FORM_TYPE_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_FORM_ITEM_CODE
    , P_FORM_ITEM_NAME
    , P_SORT_SEQ
    , P_ITEM_LEVEL
    , V_LAST_LEVEL_YN
    , P_COLUMN_POSITION_NUM
    , P_ACCOUNT_DR_CR
    , P_MINUS_SIGN_DISPLAY
    , P_DISPLAY_YN
    , P_AMOUNT_PRINT_YN
    , P_UNDER_LINE_YN
    , P_ENABLED_FLAG
    , P_EFFECTIVE_DATE_FR
    , P_EFFECTIVE_DATE_TO
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID
    , P_FORM_ITEM_TYPE
    , P_FORM_ITEM_CLASS
    , P_RELATE_HEADER_ID );

  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END INSERT_FORM_H;

-- 재무제표양식 헤더 수정.
  PROCEDURE UPDATE_FORM_H
            ( W_FORM_HEADER_ID      IN FI_FORM_HEADER.FORM_HEADER_ID%TYPE
            , W_SOB_ID              IN FI_FORM_HEADER.SOB_ID%TYPE
            , P_FORM_ITEM_NAME      IN FI_FORM_HEADER.FORM_ITEM_NAME%TYPE
            , P_SORT_SEQ            IN FI_FORM_HEADER.SORT_SEQ%TYPE
            , P_ITEM_LEVEL          IN FI_FORM_HEADER.ITEM_LEVEL%TYPE
            , P_COLUMN_POSITION_NUM IN FI_FORM_HEADER.COLUMN_POSITION_NUM%TYPE
            , P_ACCOUNT_DR_CR       IN FI_FORM_HEADER.ACCOUNT_DR_CR%TYPE
            , P_MINUS_SIGN_DISPLAY  IN FI_FORM_HEADER.MINUS_SIGN_DISPLAY%TYPE
            , P_DISPLAY_YN          IN FI_FORM_HEADER.DISPLAY_YN%TYPE
            , P_AMOUNT_PRINT_YN     IN FI_FORM_HEADER.AMOUNT_PRINT_YN%TYPE
            , P_UNDER_LINE_YN       IN FI_FORM_HEADER.UNDER_LINE_YN%TYPE
            , P_ENABLED_FLAG        IN FI_FORM_HEADER.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR   IN FI_FORM_HEADER.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO   IN FI_FORM_HEADER.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID             IN FI_FORM_HEADER.CREATED_BY%TYPE
            , P_FORM_ITEM_TYPE      IN FI_FORM_HEADER.FORM_ITEM_TYPE%TYPE
            , P_FORM_ITEM_CLASS     IN FI_FORM_HEADER.FORM_ITEM_CLASS%TYPE
            , P_RELATE_HEADER_ID    IN FI_FORM_HEADER.RELATE_HEADER_ID%TYPE
            )
  AS
    V_SYSDATE                   DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_FORM_TYPE_ID              FI_FORM_HEADER.FORM_TYPE_ID%TYPE;
    V_LAST_LEVEL_YN             FI_FORM_HEADER.LAST_LEVEL_YN%TYPE;
    V_OLD_ITEM_LEVEL            FI_FORM_LINE.ITEM_LEVEL%TYPE;
    
  BEGIN
    -- 헤더의 ITEM LEVEL 조회.
    BEGIN
      SELECT FH.FORM_TYPE_ID 
        INTO V_FORM_TYPE_ID
        FROM FI_FORM_HEADER FH
       WHERE FH.FORM_HEADER_ID    = W_FORM_HEADER_ID
         AND FH.SOB_ID            = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_FORM_TYPE_ID := 0;
    END;
    
    -- 최종 레벨 체크.
    V_LAST_LEVEL_YN := LAST_LEVEL_CHECK_F (V_FORM_TYPE_ID, W_SOB_ID, P_ITEM_LEVEL);
    
    -- 헤더의 ITEM LEVEL 조회.
    BEGIN
      SELECT MAX(FL.ITEM_LEVEL) AS ITEM_LEVEL 
        INTO V_OLD_ITEM_LEVEL
        FROM FI_FORM_LINE FL
       WHERE FL.FORM_HEADER_ID    = W_FORM_HEADER_ID
         AND FL.SOB_ID            = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_OLD_ITEM_LEVEL := 0;
    END;
    IF P_ITEM_LEVEL <> V_OLD_ITEM_LEVEL THEN
      BEGIN
        UPDATE FI_FORM_LINE
          SET JOIN_LINE_CONTROL_ID    = -1
            , ITEM_LEVEL              = P_ITEM_LEVEL
            , LAST_LEVEL_YN           = V_LAST_LEVEL_YN
            , JOIN_ACCOUNT_CONTROL_ID = -1
            , JOIN_FORM_HEADER_ID     = -1
            , LAST_UPDATE_DATE        = V_SYSDATE
            , LAST_UPDATED_BY         = P_USER_ID
         WHERE FORM_HEADER_ID         = W_FORM_HEADER_ID;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
    END IF;
    UPDATE FI_FORM_HEADER
      SET FORM_ITEM_NAME      = P_FORM_ITEM_NAME
        , SORT_SEQ            = P_SORT_SEQ
        , ITEM_LEVEL          = P_ITEM_LEVEL
        , LAST_LEVEL_YN       = V_LAST_LEVEL_YN
        , COLUMN_POSITION_NUM = P_COLUMN_POSITION_NUM
        , ACCOUNT_DR_CR       = P_ACCOUNT_DR_CR
        , MINUS_SIGN_DISPLAY  = P_MINUS_SIGN_DISPLAY
        , DISPLAY_YN          = P_DISPLAY_YN
        , AMOUNT_PRINT_YN     = P_AMOUNT_PRINT_YN
        , UNDER_LINE_YN       = P_UNDER_LINE_YN
        , ENABLED_FLAG        = P_ENABLED_FLAG
        , EFFECTIVE_DATE_FR   = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO   = P_EFFECTIVE_DATE_TO
        , LAST_UPDATE_DATE    = V_SYSDATE
        , LAST_UPDATED_BY     = P_USER_ID
        , FORM_ITEM_TYPE      = P_FORM_ITEM_TYPE
        , FORM_ITEM_CLASS     = P_FORM_ITEM_CLASS
        , RELATE_HEADER_ID    = P_RELATE_HEADER_ID
      WHERE FORM_HEADER_ID    = W_FORM_HEADER_ID;

  END UPDATE_FORM_H;

-- 재무제표양식 헤더 삭제.
  PROCEDURE DELETE_FORM_H
            ( W_FORM_HEADER_ID      IN FI_FORM_HEADER.FORM_HEADER_ID%TYPE
            )
  AS
  BEGIN
    DELETE FI_FORM_HEADER
    WHERE FORM_HEADER_ID    = W_FORM_HEADER_ID;
      
  END DELETE_FORM_H;
  
---------------------------------------------------------------------------------------------------
-- 재무제표 보고서 양식 라인 조회.
  PROCEDURE SELECT_FORM_L
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_FORM_HEADER_ID       IN FI_FORM_LINE.FORM_HEADER_ID%TYPE
            , W_SOB_ID               IN FI_FORM_LINE.SOB_ID%TYPE
            , W_ORG_ID               IN FI_FORM_LINE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT FL.FORM_LINE_ID
           , FL.FORM_HEADER_ID
           , DECODE(FL.LAST_LEVEL_YN, 'Y', AC.ACCOUNT_DESC, J_FH.FORM_ITEM_NAME) AS JOIN_LINE_CONTROL_NAME
           , DECODE(FL.LAST_LEVEL_YN, 'Y', AC.ACCOUNT_CODE, J_FH.FORM_ITEM_CODE) AS JOIN_LINE_CONTROL_CODE
           , FL.JOIN_LINE_CONTROL_ID
           , FL.ITEM_SIGN_SHOW
           , FL.LAST_LEVEL_YN
           , FL.ENABLED_FLAG
           , FL.EFFECTIVE_DATE_FR
           , FL.EFFECTIVE_DATE_TO
           , FL.SOB_ID
        FROM FI_FORM_LINE FL    
          , FI_ACCOUNT_CONTROL AC
          , ( SELECT FH.FORM_HEADER_ID
                   , FH.FORM_ITEM_CODE
                   , FH.FORM_ITEM_NAME
                   , NVL(FH.ITEM_LEVEL, 0) + 1 AS ITEM_LEVEL
                FROM FI_FORM_HEADER FH
            ) J_FH
       WHERE FL.JOIN_ACCOUNT_CONTROL_ID = AC.ACCOUNT_CONTROL_ID(+)
         AND FL.JOIN_FORM_HEADER_ID     = J_FH.FORM_HEADER_ID(+)
         AND FL.FORM_HEADER_ID          = W_FORM_HEADER_ID
         AND FL.SOB_ID                  = W_SOB_ID
       ORDER BY 4
      ;

  END SELECT_FORM_L;

-- 재무제표 보고서 양식 라인 삽입.
  PROCEDURE INSERT_FORM_L
            ( P_FORM_LINE_ID            OUT FI_FORM_LINE.FORM_LINE_ID%TYPE
            , P_SOB_ID                  IN FI_FORM_LINE.SOB_ID%TYPE
            , P_ORG_ID                  IN FI_FORM_LINE.ORG_ID%TYPE
            , P_FORM_HEADER_ID          IN FI_FORM_LINE.FORM_HEADER_ID%TYPE
            , P_JOIN_LINE_CONTROL_ID    IN FI_FORM_LINE.JOIN_LINE_CONTROL_ID%TYPE
            , P_ITEM_SIGN_SHOW          IN FI_FORM_LINE.ITEM_SIGN_SHOW%TYPE
            , P_ENABLED_FLAG            IN FI_FORM_LINE.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR       IN FI_FORM_LINE.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO       IN FI_FORM_LINE.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID                 IN FI_FORM_LINE.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                   DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_ITEM_SIGN                 FI_FORM_LINE.ITEM_SIGN%TYPE;
    V_ITEM_LEVEL                FI_FORM_LINE.ITEM_LEVEL%TYPE;
    V_LAST_LEVEL_YN             FI_FORM_LINE.LAST_LEVEL_YN%TYPE;
    V_JOIN_ACCOUNT_CONTROL_ID   FI_FORM_LINE.JOIN_ACCOUNT_CONTROL_ID%TYPE := -1;
    V_JOIN_FORM_HEADER_ID       FI_FORM_LINE.JOIN_FORM_HEADER_ID%TYPE := -1;    
    V_RECORD_COUNT              NUMBER := 0;

  BEGIN
    -- 헤더의 ITEM LEVEL 조회.
    BEGIN
      SELECT FH.ITEM_LEVEL AS ITEM_LEVEL, FH.LAST_LEVEL_YN AS LAST_LEVEL_YN
        INTO V_ITEM_LEVEL, V_LAST_LEVEL_YN
        FROM FI_FORM_HEADER FH
       WHERE FH.FORM_HEADER_ID    = P_FORM_HEADER_ID
         AND FH.SOB_ID            = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, SQLERRM);
      RETURN;
    END;

    -- 동일한 자료 존재 체크.
    IF V_LAST_LEVEL_YN = 'Y' THEN
    -- 최하위 레벨 : 계정관리 항목.
      V_JOIN_ACCOUNT_CONTROL_ID := P_JOIN_LINE_CONTROL_ID;
      BEGIN
        SELECT COUNT(FL.FORM_LINE_ID) AS RECORD_COUNT
          INTO V_RECORD_COUNT
          FROM FI_FORM_LINE FL
         WHERE FL.SOB_ID                  = P_SOB_ID
           AND FL.FORM_HEADER_ID          = P_FORM_HEADER_ID
           AND FL.JOIN_LINE_CONTROL_ID    = P_JOIN_LINE_CONTROL_ID
           AND FL.ITEM_LEVEL              = V_ITEM_LEVEL
        ;
      EXCEPTION WHEN OTHERS THEN
        V_RECORD_COUNT := 0;
      END;
    ELSE
    -- 최하위 레벨을 제외한 보고서 양식 항목.
      V_JOIN_FORM_HEADER_ID := P_JOIN_LINE_CONTROL_ID;
      BEGIN
        SELECT COUNT(FL.FORM_LINE_ID) AS RECORD_COUNT
          INTO V_RECORD_COUNT
          FROM FI_FORM_LINE FL
         WHERE FL.SOB_ID                  = P_SOB_ID
           AND FL.FORM_HEADER_ID          = P_FORM_HEADER_ID
           AND FL.JOIN_LINE_CONTROL_ID    = P_JOIN_LINE_CONTROL_ID
           AND FL.ITEM_LEVEL              = V_ITEM_LEVEL
        ;
      EXCEPTION WHEN OTHERS THEN
        V_RECORD_COUNT := 0;
      END;
    END IF;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;
    
    IF P_ITEM_SIGN_SHOW = '-' THEN
      V_ITEM_SIGN := -1;
    ELSE
      V_ITEM_SIGN := 1;    
    END IF;
    
    SELECT FI_FORM_LINE_S1.NEXTVAL
      INTO P_FORM_LINE_ID
      FROM DUAL;

    INSERT INTO FI_FORM_LINE
    ( FORM_LINE_ID
    , SOB_ID 
    , ORG_ID 
    , FORM_HEADER_ID 
    , JOIN_LINE_CONTROL_ID 
    , ITEM_SIGN_SHOW 
    , ITEM_SIGN 
    , ITEM_LEVEL 
    , LAST_LEVEL_YN 
    , JOIN_ACCOUNT_CONTROL_ID 
    , JOIN_FORM_HEADER_ID 
    , ENABLED_FLAG 
    , EFFECTIVE_DATE_FR 
    , EFFECTIVE_DATE_TO 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_FORM_LINE_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_FORM_HEADER_ID
    , P_JOIN_LINE_CONTROL_ID
    , P_ITEM_SIGN_SHOW
    , V_ITEM_SIGN
    , V_ITEM_LEVEL
    , V_LAST_LEVEL_YN
    , V_JOIN_ACCOUNT_CONTROL_ID
    , V_JOIN_FORM_HEADER_ID
    , P_ENABLED_FLAG
    , P_EFFECTIVE_DATE_FR
    , P_EFFECTIVE_DATE_TO
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END INSERT_FORM_L;

-- 재무제표 보고서 양식 라인 수정.
  PROCEDURE UPDATE_FORM_L
            ( W_FORM_LINE_ID            IN FI_FORM_LINE.FORM_LINE_ID%TYPE
            , P_SOB_ID                  IN FI_FORM_LINE.SOB_ID%TYPE
            , P_FORM_HEADER_ID          IN FI_FORM_LINE.FORM_HEADER_ID%TYPE
            , P_JOIN_LINE_CONTROL_ID    IN FI_FORM_LINE.JOIN_LINE_CONTROL_ID%TYPE
            , P_ITEM_SIGN_SHOW          IN FI_FORM_LINE.ITEM_SIGN_SHOW%TYPE
            , P_ENABLED_FLAG            IN FI_FORM_LINE.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR       IN FI_FORM_LINE.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO       IN FI_FORM_LINE.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID                 IN FI_FORM_LINE.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                   DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_ITEM_SIGN                 FI_FORM_LINE.ITEM_SIGN%TYPE;
    V_ITEM_LEVEL                FI_FORM_LINE.ITEM_LEVEL%TYPE;    
    V_LAST_LEVEL_YN             FI_FORM_LINE.LAST_LEVEL_YN%TYPE;
    V_JOIN_ACCOUNT_CONTROL_ID   FI_FORM_LINE.JOIN_ACCOUNT_CONTROL_ID%TYPE := -1;
    V_JOIN_FORM_HEADER_ID       FI_FORM_LINE.JOIN_FORM_HEADER_ID%TYPE := -1;    
    
  BEGIN    
    --RAISE_APPLICATION_ERROR(-20001, 'P_FORM_HEADER_ID' || P_FORM_HEADER_ID || ', P_SOB_ID : ' || P_SOB_ID);
    -- 헤더의 ITEM LEVEL 조회.
    BEGIN
      SELECT FH.ITEM_LEVEL AS ITEM_LEVEL, FH.LAST_LEVEL_YN AS LAST_LEVEL_YN
        INTO V_ITEM_LEVEL, V_LAST_LEVEL_YN
        FROM FI_FORM_HEADER FH
       WHERE FH.FORM_HEADER_ID    = P_FORM_HEADER_ID
         AND FH.SOB_ID            = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN      
      RAISE_APPLICATION_ERROR(-20001, SQLERRM);
      RETURN;
    END;
/*RAISE_APPLICATION_ERROR(-20001, 'P_FORM_HEADER_ID' || P_FORM_HEADER_ID || ', V_ITEM_LEVEL : ' || V_ITEM_LEVEL);    */
    -- 동일한 자료 존재 체크.
    IF V_LAST_LEVEL_YN = 'Y' THEN
    -- 최하위 레벨 : 계정관리 항목.
      V_JOIN_ACCOUNT_CONTROL_ID := P_JOIN_LINE_CONTROL_ID;      
    ELSE
    -- 최하위 레벨을 제외한 보고서 양식 항목.
      V_JOIN_FORM_HEADER_ID := P_JOIN_LINE_CONTROL_ID;      
    END IF;
    
    IF P_ITEM_SIGN_SHOW = '-' THEN
      V_ITEM_SIGN := -1;
    ELSE
      V_ITEM_SIGN := 1;    
    END IF;
    
    UPDATE FI_FORM_LINE
      SET JOIN_LINE_CONTROL_ID    = P_JOIN_LINE_CONTROL_ID
        , ITEM_SIGN_SHOW          = P_ITEM_SIGN_SHOW
        , ITEM_SIGN               = V_ITEM_SIGN
        , ITEM_LEVEL              = V_ITEM_LEVEL
        , LAST_LEVEL_YN           = V_LAST_LEVEL_YN
        , JOIN_ACCOUNT_CONTROL_ID = V_JOIN_ACCOUNT_CONTROL_ID
        , JOIN_FORM_HEADER_ID     = V_JOIN_FORM_HEADER_ID
        , ENABLED_FLAG            = P_ENABLED_FLAG
        , EFFECTIVE_DATE_FR       = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO       = P_EFFECTIVE_DATE_TO
        , LAST_UPDATE_DATE        = V_SYSDATE
        , LAST_UPDATED_BY         = P_USER_ID
     WHERE FORM_LINE_ID           = W_FORM_LINE_ID;
  
  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END UPDATE_FORM_L;

-- 재무제표 보고서 양식 라인 삭제.
  PROCEDURE DELETE_FORM_L
            ( W_FORM_LINE_ID            IN FI_FORM_LINE.FORM_LINE_ID%TYPE
            )
  AS
  BEGIN
    DELETE FI_FORM_LINE
    WHERE FORM_LINE_ID           = W_FORM_LINE_ID;
    
  END DELETE_FORM_L;

-- 재무제표양식관리 조회.
  PROCEDURE SELECT_FORM
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_FORM_TYPE_ID         IN FI_FORM_HEADER.FORM_TYPE_ID%TYPE
            , W_SOB_ID               IN FI_FORM_HEADER.SOB_ID%TYPE
            , W_ORG_ID               IN FI_FORM_HEADER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT FH.FORM_ITEM_CODE
          , FH.FORM_ITEM_NAME
          , FH.SORT_SEQ
          , FH.ITEM_LEVEL
          , FH.COLUMN_POSITION_NUM
          , FH.ACCOUNT_DR_CR
          , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', FH.ACCOUNT_DR_CR, FH.SOB_ID) AS ACCOUNT_DR_CR_NUMBER
          , FH.MINUS_SIGN_DISPLAY
          , FH.DISPLAY_YN
          , FH.AMOUNT_PRINT_YN
          , FH.UNDER_LINE_YN
          , FH.ENABLED_FLAG
          , FH.EFFECTIVE_DATE_FR
          , FH.EFFECTIVE_DATE_TO
        FROM FI_FORM_HEADER FH
      WHERE FH.FORM_TYPE_ID           = W_FORM_TYPE_ID
        AND FH.SOB_ID                 = W_SOB_ID
      ORDER BY FH.SORT_SEQ
      ;
  END SELECT_FORM;

-- 재무제표양식관리 - 누락 계정 체크.
  PROCEDURE SELECT_MISS_ACCOUNT
            ( P_CURSOR2              OUT TYPES.TCURSOR2
            , W_FORM_TYPE_ID         IN FI_FORM_HEADER.FORM_TYPE_ID%TYPE
            , W_SOB_ID               IN FI_FORM_HEADER.SOB_ID%TYPE
            , W_ORG_ID               IN FI_FORM_HEADER.ORG_ID%TYPE
            )
  AS
    V_FORM_TYPE                      VARCHAR2(10);
  BEGIN
    BEGIN
      SELECT FT.FORM_TYPE
        INTO V_FORM_TYPE
        FROM FI_FORM_TYPE_V FT
      WHERE FT.FORM_TYPE_ID       = W_FORM_TYPE_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_FORM_TYPE := '-';
    END;
    OPEN P_CURSOR2 FOR
      SELECT AC.ACCOUNT_CONTROL_ID
           , AC.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , AC.ACCOUNT_DR_CR
           , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', AC.ACCOUNT_DR_CR, AC.SOB_ID) AS ACCOUNT_DR_CR_NAME
           , AC.ACCOUNT_FS_TYPE
           , FI_COMMON_G.CODE_NAME_F('FORM_TYPE', AC.ACCOUNT_FS_TYPE, AC.SOB_ID) AS ACCOUNT_FS_TYPE_NAME
           , AC.ENABLED_FLAG
           , AC.EFFECTIVE_DATE_FR
           , AC.EFFECTIVE_DATE_TO
        FROM FI_ACCOUNT_CONTROL AC
          , FI_FORM_TYPE_V FT
      WHERE AC.ACCOUNT_FS_TYPE      = FT.FORM_TYPE
        AND AC.SOB_ID               = FT.SOB_ID
        AND AC.SOB_ID               = W_SOB_ID
        AND AC.ORG_ID               = W_ORG_ID  
        AND AC.ACCOUNT_SET_ID       = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_SET_F(W_SOB_ID)
        AND FT.FORM_TYPE_ID         = DECODE(V_FORM_TYPE, '1001', FT.FORM_TYPE_ID, W_FORM_TYPE_ID)  -- 시산표 일경우 전체 계정 적용 위해.
        AND NOT EXISTS (SELECT 'X'
                          FROM FI_FORM_HEADER FH
                            , FI_FORM_LINE FL
                        WHERE FH.FORM_HEADER_ID       = FL.FORM_HEADER_ID
                          AND FL.JOIN_ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
                          AND FH.SOB_ID               = AC.SOB_ID
                          AND FH.ORG_ID               = AC.ORG_ID
                          AND FH.FORM_TYPE_ID         = W_FORM_TYPE_ID
                          AND FL.LAST_LEVEL_YN        = 'Y'
                       )
      ORDER BY AC.ACCOUNT_CODE
      ;
  END SELECT_MISS_ACCOUNT;
    
---------------------------------------------------------------------------------------------------
-- 보고서 양식 레벨별 항목 LOOKUP.
  PROCEDURE LU_FORM_ITEM_LEVEL
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_FORM_HEADER.SOB_ID%TYPE
            , W_FORM_TYPE_ID         IN FI_FORM_HEADER.FORM_TYPE_ID%TYPE
            , W_ITEM_LEVEL           IN FI_FORM_HEADER.ITEM_LEVEL%TYPE
            , W_ENABLED_YN           IN FI_AUTO_JOURNAL_HEADER.ENABLED_FLAG%TYPE
            )
  AS
    V_SYSDATE                        DATE := NULL;

  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_SYSDATE := NULL;
    ELSE
      V_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
    END IF;

    OPEN P_CURSOR3 FOR
      SELECT FH.FORM_ITEM_NAME
           , FH.FORM_ITEM_CODE
           , FH.FORM_HEADER_ID
           , FH.ITEM_LEVEL
        FROM FI_FORM_HEADER FH
       WHERE FH.SOB_ID           = W_SOB_ID
         AND FH.FORM_TYPE_ID     = W_FORM_TYPE_ID
         AND FH.ITEM_LEVEL       = (W_ITEM_LEVEL + 1)
         AND FH.ENABLED_FLAG     = DECODE(W_ENABLED_YN, 'Y', 'Y', FH.ENABLED_FLAG)
         AND FH.EFFECTIVE_DATE_FR  <= NVL(V_SYSDATE, FH.EFFECTIVE_DATE_FR)
         AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO  >= NVL(V_SYSDATE, FH.EFFECTIVE_DATE_TO))
     ORDER BY FH.SORT_SEQ
    ;

  END LU_FORM_ITEM_LEVEL;

-- 보고서 양식 관련항목 LOOKUP.
  PROCEDURE LU_RELATE_FORM_ITEM
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_FORM_HEADER.SOB_ID%TYPE
            , W_FORM_TYPE_ID         IN FI_FORM_HEADER.FORM_TYPE_ID%TYPE
            , W_ITEM_LEVEL           IN FI_FORM_HEADER.ITEM_LEVEL%TYPE
            , W_ENABLED_YN           IN FI_AUTO_JOURNAL_HEADER.ENABLED_FLAG%TYPE
            )
  AS
    V_SYSDATE                        DATE := NULL;
  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
    ELSE
      V_SYSDATE := NULL;
    END IF;

    OPEN P_CURSOR3 FOR
      SELECT LTRIM(FH.FORM_ITEM_NAME) AS FORM_ITEM_NAME
           , FH.FORM_ITEM_CODE
           , FH.FORM_HEADER_ID
           , FH.ITEM_LEVEL
        FROM FI_FORM_HEADER FH
       WHERE FH.SOB_ID           = W_SOB_ID
         AND FH.FORM_TYPE_ID     = W_FORM_TYPE_ID
         AND FH.ITEM_LEVEL       = W_ITEM_LEVEL
         AND FH.ENABLED_FLAG     = DECODE(W_ENABLED_YN, 'Y', 'Y', FH.ENABLED_FLAG)
         AND FH.EFFECTIVE_DATE_FR  <= NVL(V_SYSDATE, FH.EFFECTIVE_DATE_FR)
         AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO  >= NVL(V_SYSDATE, FH.EFFECTIVE_DATE_TO))
     ORDER BY FH.SORT_SEQ
    ;
  END LU_RELATE_FORM_ITEM;
  
---------------------------------------------------------------------------------------------------
-- HEADER iTEM의 LAST_LEVEL CHECK.
  FUNCTION LAST_LEVEL_CHECK_F
            ( W_FORM_TYPE_ID         IN FI_FORM_HEADER.FORM_TYPE_ID%TYPE            
            , W_SOB_ID               IN FI_FORM_HEADER.SOB_ID%TYPE
            , W_ITEM_LEVEL           IN FI_FORM_HEADER.ITEM_LEVEL%TYPE
            ) RETURN VARCHAR2
  AS
    V_LAST_LEVEL                     NUMBER := 0;
    
  BEGIN
    -- 최종여부 체크.
    BEGIN
      SELECT FT.CONTROL_LEVEL
        INTO V_LAST_LEVEL
        FROM FI_FORM_TYPE_V FT
       WHERE FT.FORM_TYPE_ID      = W_FORM_TYPE_ID
         AND FT.SOB_ID            = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_LAST_LEVEL := 0;
    END;
    
    IF V_LAST_LEVEL = W_ITEM_LEVEL THEN
      RETURN 'Y';
    ELSE
      RETURN 'N';    
    END IF;
    
  END LAST_LEVEL_CHECK_F;
  
-- 보고서 양식 항목코드 RETURN.
  FUNCTION FORM_ITEM_CODE_F
            ( W_FORM_HEADER_ID       IN FI_FORM_HEADER.FORM_HEADER_ID%TYPE
            , W_SOB_ID               IN FI_FORM_HEADER.SOB_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                   FI_FORM_HEADER.FORM_ITEM_NAME%TYPE := NULL;

  BEGIN
    BEGIN
      SELECT FH.FORM_ITEM_CODE
        INTO V_RETURN_VALUE
        FROM FI_FORM_HEADER FH
       WHERE FH.FORM_HEADER_ID    = W_FORM_HEADER_ID
         AND FH.SOB_ID            = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    RETURN V_RETURN_VALUE;
  
  END FORM_ITEM_CODE_F;
  
-- 보고서 양식 항목명 RETURN.
  FUNCTION FORM_ITEM_NAME_F
            ( W_FORM_HEADER_ID       IN FI_FORM_HEADER.FORM_HEADER_ID%TYPE
            , W_SOB_ID               IN FI_FORM_HEADER.SOB_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                   FI_FORM_HEADER.FORM_ITEM_NAME%TYPE := NULL;

  BEGIN
    BEGIN
      SELECT FH.FORM_ITEM_NAME
        INTO V_RETURN_VALUE
        FROM FI_FORM_HEADER FH
       WHERE FH.FORM_HEADER_ID    = W_FORM_HEADER_ID
         AND FH.SOB_ID            = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    RETURN V_RETURN_VALUE;

  END FORM_ITEM_NAME_F;

END FI_FORM_G;
/
