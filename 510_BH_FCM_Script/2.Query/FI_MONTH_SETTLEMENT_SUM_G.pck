CREATE OR REPLACE PACKAGE FI_MONTH_SETTLEMENT_SUM_G
AS

-- 결산자료 생성.
  PROCEDURE MONTH_SETTLEMENT_SET
            ( W_PERIOD_NAME       IN FI_MONTH_SETTLEMENT_SUM.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_MONTH_SETTLEMENT_SUM.SOB_ID%TYPE
            , W_ORG_ID            IN FI_MONTH_SETTLEMENT_SUM.ORG_ID%TYPE
            , W_USER_ID           IN FI_MONTH_SETTLEMENT_SUM.CREATED_BY%TYPE
            );

END FI_MONTH_SETTLEMENT_SUM_G;
/
CREATE OR REPLACE PACKAGE BODY FI_MONTH_SETTLEMENT_SUM_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_MONTH_SETTLEMENT_SUM_G
/* Description  : 결산자료 생성 패키지.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 결산자료 생성.
  PROCEDURE MONTH_SETTLEMENT_SET
            ( W_PERIOD_NAME       IN FI_MONTH_SETTLEMENT_SUM.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_MONTH_SETTLEMENT_SUM.SOB_ID%TYPE
            , W_ORG_ID            IN FI_MONTH_SETTLEMENT_SUM.ORG_ID%TYPE
            , W_USER_ID           IN FI_MONTH_SETTLEMENT_SUM.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_GL_DATE_FR                  DATE;
    V_GL_DATE_TO                  DATE;
    
  BEGIN
    V_GL_DATE_FR := TRUNC(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'));
    V_GL_DATE_TO := LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'));
    IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, V_GL_DATE_FR, W_SOB_ID, W_ORG_ID) IN('C', 'N') THEN
      RAISE ERRNUMS.Data_Not_Opened;
    END IF;
    
    -- 해당월 결산자료 삭제.
    BEGIN
      DELETE FROM FI_MONTH_SETTLEMENT_SUM MSS
      WHERE MSS.PERIOD_NAME       = W_PERIOD_NAME 
        AND MSS.SOB_ID            = W_SOB_ID
      ;      
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Settlement Delete Error : ' || SUBSTR(SQLERRM, 1, 250));
    END;
    
    -- 항목생성.
    BEGIN
      INSERT INTO FI_MONTH_SETTLEMENT_SUM
      ( PERIOD_NAME
      , SOB_ID
      , ORG_ID
      , FORM_HEADER_ID
      , FORM_ITEM_LEVEL
      , FORM_ITEM_TYPE
      , FORM_ITEM_CLASS
      , CREATION_DATE
      , CREATED_BY
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY      
      )
      SELECT W_PERIOD_NAME AS PERIOD_NAME
          , W_SOB_ID AS SOB_ID
          , W_ORG_ID AS ORG_ID
          , FH.FORM_HEADER_ID
          , FH.ITEM_LEVEL
          , FH.FORM_ITEM_TYPE
          , FH.FORM_ITEM_CLASS
          , V_SYSDATE
          , W_USER_ID
          , V_SYSDATE
          , W_USER_ID
        FROM FI_FORM_HEADER FH
      WHERE FH.SOB_ID                 = W_SOB_ID
        AND FH.ENABLED_FLAG           = 'Y'
        AND FH.EFFECTIVE_DATE_FR      <= V_GL_DATE_TO
        AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_GL_DATE_FR)
        AND EXISTS ( SELECT 'X'
                       FROM FI_COMMON FC
                     WHERE FC.GROUP_CODE    = 'FORM_TYPE'
                       AND FC.COMMON_ID     = FH.FORM_TYPE_ID
                       AND FC.SOB_ID        = FH.SOB_ID
                       AND FC.CODE          = '9001'
                    )  
      ORDER BY FH.SORT_SEQ
        ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Settlement Item Insert Error : ' || SUBSTR(SQLERRM, 1, 250));
    END;
    
/*      -- 결산 자료 생성.
      SELECT &W_PERIOD_NAME AS PERIOD_NAME
          , &W_SOB_ID AS SOB_ID
          , &W_ORG_ID AS ORG_ID
          , FH.FORM_HEADER_ID
          , FH.ITEM_LEVEL
          , FH.FORM_ITEM_TYPE
          , FH.FORM_ITEM_CLASS
          , SYSDATE
          , &P_USER_ID
          , SYSDATE
          , &P_USER_ID
        FROM FI_FORM_HEADER FH
      WHERE FH.SOB_ID                 = &W_SOB_ID
        AND FH.ENABLED_FLAG           = 'Y'
        AND FH.EFFECTIVE_DATE_FR      <= LAST_DAY(TO_DATE(&W_PERIOD_NAME, 'YYYY-MM'))
        AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= TRUNC(TO_DATE(&W_PERIOD_NAME, 'YYYY-MM')))
        AND EXISTS ( SELECT 'X'
                       FROM FI_COMMON FC
                     WHERE FC.GROUP_CODE    = 'FORM_TYPE'
                       AND FC.COMMON_ID     = FH.FORM_TYPE_ID
                       AND FC.SOB_ID        = FH.SOB_ID
                       AND FC.CODE          = '9001'
                    )  
      ORDER BY FH.SORT_SEQ
      ;
*/
  EXCEPTION
    WHEN ERRNUMS.Data_Not_Opened THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_opened_Code, ERRNUMS.Data_Not_Opened_Desc);
  END MONTH_SETTLEMENT_SET;

END FI_MONTH_SETTLEMENT_SUM_G;
/
