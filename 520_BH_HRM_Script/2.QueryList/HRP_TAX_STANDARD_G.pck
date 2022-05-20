CREATE OR REPLACE PACKAGE HRP_TAX_STANDARD_G
AS

-- 갑근세 조견표 조회.
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_STD_DATE                          IN HRP_TAX_STANDARD.START_DATE%TYPE
            , W_SOB_ID                            IN HRP_TAX_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_TAX_STANDARD.ORG_ID%TYPE
            );

-- 갑근세 조견표 삽입.
  PROCEDURE DATA_INSERT
            ( P_START_DATE                        IN HRP_TAX_STANDARD.START_DATE%TYPE
            , P_END_DATE                          IN HRP_TAX_STANDARD.END_DATE%TYPE
            , P_BEGIN_AMOUNT                      IN HRP_TAX_STANDARD.BEGIN_AMOUNT%TYPE
            , P_END_AMOUNT                        IN HRP_TAX_STANDARD.END_AMOUNT%TYPE
            , P_SUPP_NUM1                         IN HRP_TAX_STANDARD.SUPP_NUM10%TYPE
            , P_SUPP_NUM2                         IN HRP_TAX_STANDARD.SUPP_NUM2%TYPE
            , P_SUPP_NUM3                         IN HRP_TAX_STANDARD.SUPP_NUM3%TYPE
            , P_SUPP_NUM4                         IN HRP_TAX_STANDARD.SUPP_NUM4%TYPE
            , P_SUPP_NUM5                         IN HRP_TAX_STANDARD.SUPP_NUM5%TYPE
            , P_SUPP_NUM6                         IN HRP_TAX_STANDARD.SUPP_NUM6%TYPE
            , P_SUPP_NUM7                         IN HRP_TAX_STANDARD.SUPP_NUM7%TYPE
            , P_SUPP_NUM8                         IN HRP_TAX_STANDARD.SUPP_NUM8%TYPE
            , P_SUPP_NUM9                         IN HRP_TAX_STANDARD.SUPP_NUM9%TYPE 
            , P_SUPP_NUM10                        IN HRP_TAX_STANDARD.SUPP_NUM10%TYPE
            , P_SUPP_NUM11                        IN HRP_TAX_STANDARD.SUPP_NUM11%TYPE
            , P_DESCRIPTION                       IN HRP_TAX_STANDARD.DESCRIPTION%TYPE
            , P_SOB_ID                            IN HRP_TAX_STANDARD.SOB_ID%TYPE
            , P_ORG_ID                            IN HRP_TAX_STANDARD.ORG_ID%TYPE
            , P_USER_ID                           IN HRP_TAX_STANDARD.CREATED_BY%TYPE
            );

-- 갑근세 조견표 수정.
  PROCEDURE DATA_UPDATE
            ( W_START_DATE                        IN HRP_TAX_STANDARD.START_DATE%TYPE
            , W_END_DATE                          IN HRP_TAX_STANDARD.END_DATE%TYPE
            , W_BEGIN_AMOUNT                      IN HRP_TAX_STANDARD.BEGIN_AMOUNT%TYPE
            , W_END_AMOUNT                        IN HRP_TAX_STANDARD.END_AMOUNT%TYPE
            , W_SOB_ID                            IN HRP_TAX_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_TAX_STANDARD.ORG_ID%TYPE
            , P_SUPP_NUM1                         IN HRP_TAX_STANDARD.SUPP_NUM10%TYPE
            , P_SUPP_NUM2                         IN HRP_TAX_STANDARD.SUPP_NUM2%TYPE
            , P_SUPP_NUM3                         IN HRP_TAX_STANDARD.SUPP_NUM3%TYPE
            , P_SUPP_NUM4                         IN HRP_TAX_STANDARD.SUPP_NUM4%TYPE
            , P_SUPP_NUM5                         IN HRP_TAX_STANDARD.SUPP_NUM5%TYPE
            , P_SUPP_NUM6                         IN HRP_TAX_STANDARD.SUPP_NUM6%TYPE
            , P_SUPP_NUM7                         IN HRP_TAX_STANDARD.SUPP_NUM7%TYPE
            , P_SUPP_NUM8                         IN HRP_TAX_STANDARD.SUPP_NUM8%TYPE
            , P_SUPP_NUM9                         IN HRP_TAX_STANDARD.SUPP_NUM9%TYPE 
            , P_SUPP_NUM10                        IN HRP_TAX_STANDARD.SUPP_NUM10%TYPE
            , P_SUPP_NUM11                        IN HRP_TAX_STANDARD.SUPP_NUM11%TYPE
            , P_DESCRIPTION                       IN HRP_TAX_STANDARD.DESCRIPTION%TYPE
            , P_USER_ID                           IN HRP_TAX_STANDARD.CREATED_BY%TYPE
            );
            
-- 갑근세 조견표 삭제.
  PROCEDURE DATA_DELETE
            ( W_START_DATE                        IN HRP_TAX_STANDARD.START_DATE%TYPE
            , W_END_DATE                          IN HRP_TAX_STANDARD.END_DATE%TYPE
            , W_BEGIN_AMOUNT                      IN HRP_TAX_STANDARD.BEGIN_AMOUNT%TYPE
            , W_END_AMOUNT                        IN HRP_TAX_STANDARD.END_AMOUNT%TYPE
            , W_SOB_ID                            IN HRP_TAX_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_TAX_STANDARD.ORG_ID%TYPE
            );            

END HRP_TAX_STANDARD_G;
/
CREATE OR REPLACE PACKAGE BODY HRP_TAX_STANDARD_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRP_TAX_STANDARD_G
/* Description  : 갑근세 조견표 관리.
/*
/* Reference by : 
/* Program History : 
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 갑근세 조견표 조회.
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_STD_DATE                          IN HRP_TAX_STANDARD.START_DATE%TYPE
            , W_SOB_ID                            IN HRP_TAX_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_TAX_STANDARD.ORG_ID%TYPE
            )
  AS
  BEGIN
     OPEN P_CURSOR FOR
        SELECT TS.START_DATE
            , TS.END_DATE
            , TS.BEGIN_AMOUNT
            , TS.END_AMOUNT
            , TS.SUPP_NUM1
            , TS.SUPP_NUM2
            , TS.SUPP_NUM3
            , TS.SUPP_NUM4
            , TS.SUPP_NUM5
            , TS.SUPP_NUM6
            , TS.SUPP_NUM7
            , TS.SUPP_NUM8
            , TS.SUPP_NUM9
            , TS.SUPP_NUM10
            , TS.SUPP_NUM11
            , TS.DESCRIPTION
        FROM HRP_TAX_STANDARD TS
        WHERE TS.START_DATE                                 <= W_STD_DATE
          AND (TS.END_DATE IS NULL OR TS.END_DATE           >= W_STD_DATE)
					AND TS.SOB_ID                                     = W_SOB_ID
					AND TS.ORG_ID                                     = W_ORG_ID
        ;

  END DATA_SELECT;


-- 갑근세 조견표 삽입.
  PROCEDURE DATA_INSERT
            ( P_START_DATE                        IN HRP_TAX_STANDARD.START_DATE%TYPE
            , P_END_DATE                          IN HRP_TAX_STANDARD.END_DATE%TYPE
            , P_BEGIN_AMOUNT                      IN HRP_TAX_STANDARD.BEGIN_AMOUNT%TYPE
            , P_END_AMOUNT                        IN HRP_TAX_STANDARD.END_AMOUNT%TYPE
            , P_SUPP_NUM1                         IN HRP_TAX_STANDARD.SUPP_NUM10%TYPE
            , P_SUPP_NUM2                         IN HRP_TAX_STANDARD.SUPP_NUM2%TYPE
            , P_SUPP_NUM3                         IN HRP_TAX_STANDARD.SUPP_NUM3%TYPE
            , P_SUPP_NUM4                         IN HRP_TAX_STANDARD.SUPP_NUM4%TYPE
            , P_SUPP_NUM5                         IN HRP_TAX_STANDARD.SUPP_NUM5%TYPE
            , P_SUPP_NUM6                         IN HRP_TAX_STANDARD.SUPP_NUM6%TYPE
            , P_SUPP_NUM7                         IN HRP_TAX_STANDARD.SUPP_NUM7%TYPE
            , P_SUPP_NUM8                         IN HRP_TAX_STANDARD.SUPP_NUM8%TYPE
            , P_SUPP_NUM9                         IN HRP_TAX_STANDARD.SUPP_NUM9%TYPE 
            , P_SUPP_NUM10                        IN HRP_TAX_STANDARD.SUPP_NUM10%TYPE
            , P_SUPP_NUM11                        IN HRP_TAX_STANDARD.SUPP_NUM11%TYPE
            , P_DESCRIPTION                       IN HRP_TAX_STANDARD.DESCRIPTION%TYPE
            , P_SOB_ID                            IN HRP_TAX_STANDARD.SOB_ID%TYPE
            , P_ORG_ID                            IN HRP_TAX_STANDARD.ORG_ID%TYPE
            , P_USER_ID                           IN HRP_TAX_STANDARD.CREATED_BY%TYPE
            )
  AS
	  D_SYSDATE                                     DATE;
		V_END_DATE                                    HRP_TAX_STANDARD.END_DATE%TYPE;
    V_RECORD_COUNT                                NUMBER := 0;
    
  BEGIN
	  D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
		V_END_DATE := TO_DATE('2999-12-31');
    
    BEGIN
      SELECT COUNT(*) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRP_TAX_STANDARD TS
       WHERE TS.START_DATE                                 <= P_START_DATE
         AND (TS.END_DATE IS NULL OR TS.END_DATE           >= P_START_DATE)
         AND TS.SOB_ID                                     = P_SOB_ID
         AND TS.ORG_ID                                     = P_ORG_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT > 0 THEN
      UPDATE HRP_TAX_STANDARD TS
        SET TS.END_DATE       = P_START_DATE - 1
        WHERE TS.START_DATE                           <= P_START_DATE
          AND (TS.END_DATE IS NULL OR TS.END_DATE     >= P_START_DATE)
          AND TS.BEGIN_AMOUNT                         = P_BEGIN_AMOUNT
          AND TS.END_AMOUNT                           = P_END_AMOUNT          
          AND TS.SOB_ID                               = P_SOB_ID
          AND TS.ORG_ID                               = P_ORG_ID
        ;
    END IF;
    
		INSERT INTO HRP_TAX_STANDARD
		(START_DATE, END_DATE, BEGIN_AMOUNT, END_AMOUNT
		, SUPP_NUM1, SUPP_NUM2, SUPP_NUM3, SUPP_NUM4, SUPP_NUM5
		, SUPP_NUM6, SUPP_NUM7, SUPP_NUM8, SUPP_NUM9, SUPP_NUM10
		, SUPP_NUM11
		, DESCRIPTION
		, SOB_ID, ORG_ID
		, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
		) VALUES
		(P_START_DATE, V_END_DATE, P_BEGIN_AMOUNT, P_END_AMOUNT
		, P_SUPP_NUM1, P_SUPP_NUM2, P_SUPP_NUM3, P_SUPP_NUM4, P_SUPP_NUM5
		, P_SUPP_NUM6, P_SUPP_NUM7, P_SUPP_NUM8, P_SUPP_NUM9, P_SUPP_NUM10
		, P_SUPP_NUM11
		, P_DESCRIPTION
		, P_SOB_ID, P_ORG_ID
		, D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
		);
		COMMIT;

  END DATA_INSERT;

-- 갑근세 조견표 수정.
  PROCEDURE DATA_UPDATE
            ( W_START_DATE                        IN HRP_TAX_STANDARD.START_DATE%TYPE
            , W_END_DATE                          IN HRP_TAX_STANDARD.END_DATE%TYPE
            , W_BEGIN_AMOUNT                      IN HRP_TAX_STANDARD.BEGIN_AMOUNT%TYPE
            , W_END_AMOUNT                        IN HRP_TAX_STANDARD.END_AMOUNT%TYPE
            , W_SOB_ID                            IN HRP_TAX_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_TAX_STANDARD.ORG_ID%TYPE
            , P_SUPP_NUM1                         IN HRP_TAX_STANDARD.SUPP_NUM10%TYPE
            , P_SUPP_NUM2                         IN HRP_TAX_STANDARD.SUPP_NUM2%TYPE
            , P_SUPP_NUM3                         IN HRP_TAX_STANDARD.SUPP_NUM3%TYPE
            , P_SUPP_NUM4                         IN HRP_TAX_STANDARD.SUPP_NUM4%TYPE
            , P_SUPP_NUM5                         IN HRP_TAX_STANDARD.SUPP_NUM5%TYPE
            , P_SUPP_NUM6                         IN HRP_TAX_STANDARD.SUPP_NUM6%TYPE
            , P_SUPP_NUM7                         IN HRP_TAX_STANDARD.SUPP_NUM7%TYPE
            , P_SUPP_NUM8                         IN HRP_TAX_STANDARD.SUPP_NUM8%TYPE
            , P_SUPP_NUM9                         IN HRP_TAX_STANDARD.SUPP_NUM9%TYPE 
            , P_SUPP_NUM10                        IN HRP_TAX_STANDARD.SUPP_NUM10%TYPE
            , P_SUPP_NUM11                        IN HRP_TAX_STANDARD.SUPP_NUM11%TYPE
            , P_DESCRIPTION                       IN HRP_TAX_STANDARD.DESCRIPTION%TYPE
            , P_USER_ID                           IN HRP_TAX_STANDARD.CREATED_BY%TYPE
            )
  AS
  BEGIN
    UPDATE HRP_TAX_STANDARD TS
        SET   TS.SUPP_NUM1                        = P_SUPP_NUM1
            , TS.SUPP_NUM2                        = P_SUPP_NUM2
            , TS.SUPP_NUM3                        = P_SUPP_NUM3
            , TS.SUPP_NUM4                        = P_SUPP_NUM4
            , TS.SUPP_NUM5                        = P_SUPP_NUM5
            , TS.SUPP_NUM6                        = P_SUPP_NUM6
            , TS.SUPP_NUM7                        = P_SUPP_NUM7
            , TS.SUPP_NUM8                        = P_SUPP_NUM8
            , TS.SUPP_NUM9                        = P_SUPP_NUM9
            , TS.SUPP_NUM10                       = P_SUPP_NUM10
            , TS.SUPP_NUM11                       = P_SUPP_NUM11
            , TS.DESCRIPTION                      = P_DESCRIPTION
            , TS.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(TS.SOB_ID)
            , TS.LAST_UPDATED_BY                  = P_USER_ID
    WHERE TS.START_DATE                           = W_START_DATE
      AND TS.END_DATE                             = W_END_DATE
      AND TS.BEGIN_AMOUNT                         = W_BEGIN_AMOUNT
      AND TS.END_AMOUNT                           = W_END_AMOUNT          
			AND TS.SOB_ID                               = W_SOB_ID
			AND TS.ORG_ID                               = W_ORG_ID
    ;
    COMMIT;

  END DATA_UPDATE;

-- 갑근세 조견표 삭제.
  PROCEDURE DATA_DELETE
            ( W_START_DATE                        IN HRP_TAX_STANDARD.START_DATE%TYPE
            , W_END_DATE                          IN HRP_TAX_STANDARD.END_DATE%TYPE
            , W_BEGIN_AMOUNT                      IN HRP_TAX_STANDARD.BEGIN_AMOUNT%TYPE
            , W_END_AMOUNT                        IN HRP_TAX_STANDARD.END_AMOUNT%TYPE
            , W_SOB_ID                            IN HRP_TAX_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_TAX_STANDARD.ORG_ID%TYPE
            )
  AS
  BEGIN
    DELETE HRP_TAX_STANDARD TS
    WHERE TS.START_DATE                           = W_START_DATE
      AND TS.END_DATE                             = W_END_DATE
      AND TS.BEGIN_AMOUNT                         = W_BEGIN_AMOUNT
      AND TS.END_AMOUNT                           = W_END_AMOUNT          
			AND TS.SOB_ID                               = W_SOB_ID
			AND TS.ORG_ID                               = W_ORG_ID
    ;
    COMMIT;
  
  END DATA_DELETE;

END HRP_TAX_STANDARD_G;
/
