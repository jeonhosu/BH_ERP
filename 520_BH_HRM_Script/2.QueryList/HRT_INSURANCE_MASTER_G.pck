CREATE OR REPLACE PACKAGE HRT_INSURANCE_MASTER_G
AS

-- INSURANCE CHARGE SELECT
  PROCEDURE SELECT_INSUR_MASTER
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRT_INSURANCE_MASTER.CORP_ID%TYPE
            , W_INSUR_YYYYMM                      IN VARCHAR2
            , W_INSUR_TYPE                        IN HRT_INSURANCE_MASTER.INSUR_TYPE%TYPE
            , W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRT_INSURANCE_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRT_INSURANCE_MASTER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRT_INSURANCE_MASTER.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 보험관리-건강(보수월액), 국민(소득월액) 삽입.
  PROCEDURE INSERT_INSUR_MASTER
            ( P_PERSON_ID            IN HRT_INSURANCE_MASTER.PERSON_ID%TYPE
            , P_CORP_ID              IN HRT_INSURANCE_MASTER.CORP_ID%TYPE
            , P_INSUR_TYPE           IN HRT_INSURANCE_MASTER.INSUR_TYPE%TYPE
            , P_INSUR_YN             IN HRT_INSURANCE_MASTER.INSUR_YN%TYPE
            , P_INSUR_GRADE_STEP     IN HRT_INSURANCE_MASTER.INSUR_GRADE_STEP%TYPE
            , P_INSUR_AMOUNT         IN HRT_INSURANCE_MASTER.INSUR_AMOUNT%TYPE
            , P_CARE_INSUR_REDUCE_YN IN HRT_INSURANCE_MASTER.CARE_INSUR_REDUCE_YN%TYPE
            , P_GET_DATE             IN HRT_INSURANCE_MASTER.GET_DATE%TYPE
            , P_LOSS_DATE            IN HRT_INSURANCE_MASTER.LOSS_DATE%TYPE
            , P_INSUR_NO             IN HRT_INSURANCE_MASTER.INSUR_NO%TYPE
            , P_DESCRIPTION          IN HRT_INSURANCE_MASTER.DESCRIPTION%TYPE
            , P_SOB_ID               IN HRT_INSURANCE_MASTER.SOB_ID%TYPE
            , P_ORG_ID               IN HRT_INSURANCE_MASTER.ORG_ID%TYPE
            , P_USER_ID              IN HRT_INSURANCE_MASTER.CREATED_BY%TYPE 
            );

-- 보험관리-건강(보수월액), 국민(소득월액) 수정.
  PROCEDURE UPDATE_INSUR_MASTER
            ( W_PERSON_ID            IN HRT_INSURANCE_MASTER.PERSON_ID%TYPE
            , P_CORP_ID              IN HRT_INSURANCE_MASTER.CORP_ID%TYPE
            , P_INSUR_TYPE           IN HRT_INSURANCE_MASTER.INSUR_TYPE%TYPE
            , P_INSUR_YN             IN HRT_INSURANCE_MASTER.INSUR_YN%TYPE
            , P_INSUR_GRADE_STEP     IN HRT_INSURANCE_MASTER.INSUR_GRADE_STEP%TYPE
            , P_INSUR_AMOUNT         IN HRT_INSURANCE_MASTER.INSUR_AMOUNT%TYPE
            , P_CARE_INSUR_REDUCE_YN IN HRT_INSURANCE_MASTER.CARE_INSUR_REDUCE_YN%TYPE
            , P_GET_DATE             IN HRT_INSURANCE_MASTER.GET_DATE%TYPE
            , P_LOSS_DATE            IN HRT_INSURANCE_MASTER.LOSS_DATE%TYPE
            , P_INSUR_NO             IN HRT_INSURANCE_MASTER.INSUR_NO%TYPE
            , P_DESCRIPTION          IN HRT_INSURANCE_MASTER.DESCRIPTION%TYPE
            , P_SOB_ID               IN HRT_INSURANCE_MASTER.SOB_ID%TYPE
            , P_ORG_ID               IN HRT_INSURANCE_MASTER.ORG_ID%TYPE
            , P_USER_ID              IN HRT_INSURANCE_MASTER.CREATED_BY%TYPE 
            );

---------------------------------------------------------------------------------------------------
-- 건강보험/국민연금 계산.
  FUNCTION INSUR_AMOUNT_F
            ( P_INSUR_YYYYMM      IN VARCHAR2
            , P_PERSON_ID         IN HRT_INSURANCE_MASTER.PERSON_ID%TYPE
            , P_INSUR_TYPE        IN HRT_INSURANCE_MASTER.INSUR_TYPE%TYPE
            , P_SOB_ID            IN HRT_INSURANCE_MASTER.SOB_ID%TYPE
            , P_ORG_ID            IN HRT_INSURANCE_MASTER.ORG_ID%TYPE
            ) RETURN NUMBER;
            
-- 요양보험료 계산.
  FUNCTION CARE_INSUR_AMOUNT_F
            ( P_INSUR_YYYYMM         IN VARCHAR2
            , P_PERSON_ID            IN HRT_INSURANCE_MASTER.PERSON_ID%TYPE
            , P_SOB_ID               IN HRT_INSURANCE_MASTER.SOB_ID%TYPE
            , P_ORG_ID               IN HRT_INSURANCE_MASTER.ORG_ID%TYPE
            ) RETURN NUMBER;

END HRT_INSURANCE_MASTER_G;
/
CREATE OR REPLACE PACKAGE BODY HRT_INSURANCE_MASTER_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRT_INSURANCE_MASTER_G
/* DESCRIPTION  : 보험관리 - 보수월액/소득월액 기준.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- INSURANCE CHARGE SELECT
  PROCEDURE SELECT_INSUR_MASTER
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRT_INSURANCE_MASTER.CORP_ID%TYPE
            , W_INSUR_YYYYMM                      IN VARCHAR2
            , W_INSUR_TYPE                        IN HRT_INSURANCE_MASTER.INSUR_TYPE%TYPE
            , W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRT_INSURANCE_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRT_INSURANCE_MASTER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRT_INSURANCE_MASTER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT PM.PERSON_NUM
           , PM.NAME
           , DM.DEPT_NAME AS DEPT_NAME
           , PC.POST_NAME AS POST_NAME
           , PM.ORI_JOIN_DATE
           , PM.JOIN_DATE
           , PM.RETIRE_DATE
           , PM.PERSON_ID
           , PM.CORP_ID
           , NVL(T1.INSUR_YN, 'N') AS INSUR_YN
           , T1.INSUR_GRADE_STEP
           , T1.INSUR_AMOUNT
           , T1.CHARGE_AMOUNT AS CHARGE_AMOUNT
           , T1.CARE_CHARGE_AMOUNT
           , NVL(T1.CHARGE_AMOUNT, 0) + NVL(T1.CARE_CHARGE_AMOUNT, 0) AS TOTAL_INSUR_AMOUNT
           , T1.CARE_INSUR_REDUCE_YN
           , T1.GET_DATE
           , T1.LOSS_DATE
           , T1.INSUR_NO
           , T1.DESCRIPTION
           , NVL(T1.INSUR_TYPE, W_INSUR_TYPE) AS INSUR_TYPE
        FROM HRM_HISTORY_LINE HL
          , HRM_PERSON_MASTER PM
          , HRM_DEPT_MASTER DM
          , HRM_POST_CODE_V PC
          , (-- 보험관리.
            SELECT IM.PERSON_ID
                 , IM.CORP_ID
                 , IM.INSUR_TYPE
                 , IM.INSUR_YN
                 , IM.INSUR_GRADE_STEP
                 , IM.INSUR_AMOUNT
                 , INSUR_AMOUNT_F(W_INSUR_YYYYMM, IM.PERSON_ID, IM.INSUR_TYPE, IM.SOB_ID, IM.ORG_ID) AS CHARGE_AMOUNT
                 , CASE
                     WHEN IM.INSUR_TYPE = 'M' THEN CARE_INSUR_AMOUNT_F(W_INSUR_YYYYMM, IM.PERSON_ID, IM.SOB_ID, IM.ORG_ID)
                     ELSE 0
                   END AS CARE_CHARGE_AMOUNT
                 , IM.CARE_INSUR_REDUCE_YN
                 , IM.GET_DATE
                 , IM.LOSS_DATE
                 , IM.INSUR_NO
                 , IM.DESCRIPTION
              FROM HRT_INSURANCE_MASTER IM
             WHERE IM.CORP_ID               = NVL(W_CORP_ID, IM.CORP_ID)
               AND IM.PERSON_ID             = NVL(W_PERSON_ID, IM.PERSON_ID)
               AND IM.INSUR_TYPE            = W_INSUR_TYPE
               AND IM.SOB_ID                = W_SOB_ID
               AND IM.ORG_ID                = W_ORG_ID
            )T1
      WHERE HL.PERSON_ID        = PM.PERSON_ID
        AND HL.DEPT_ID          = DM.DEPT_ID
        AND HL.POST_ID          = PC.POST_ID(+)
        AND PM.PERSON_ID        = T1.PERSON_ID(+)
        AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                      FROM HRM_HISTORY_LINE S_HL
                                     WHERE S_HL.CHARGE_DATE            <= LAST_DAY(TO_DATE(W_INSUR_YYYYMM, 'YYYY-MM'))
                                       AND S_HL.PERSON_ID              = HL.PERSON_ID
                                     GROUP BY S_HL.PERSON_ID
                                   )
        AND PM.CORP_ID          = NVL(W_CORP_ID, PM.CORP_ID)
        AND PM.PERSON_ID        = NVL(W_PERSON_ID, PM.PERSON_ID)
        AND HL.DEPT_ID          = NVL(W_DEPT_ID, HL.DEPT_ID)
        AND PM.ORI_JOIN_DATE    <= LAST_DAY(TO_DATE(W_INSUR_YYYYMM, 'YYYY-MM'))
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= TRUNC(TO_DATE(W_INSUR_YYYYMM, 'YYYY-MM'), 'MONTH'))
        AND PM.SOB_ID           = W_SOB_ID
        AND PM.ORG_ID           = W_ORG_ID
        AND PM.CORP_TYPE        != '1'  -- 자사 제외.
      ORDER BY DM.DEPT_CODE, PC.POST_CODE, PM.PERSON_NUM
      ;
  END SELECT_INSUR_MASTER;

---------------------------------------------------------------------------------------------------
-- 보험관리-건강(보수월액), 국민(소득월액) 삽입.
  PROCEDURE INSERT_INSUR_MASTER
            ( P_PERSON_ID            IN HRT_INSURANCE_MASTER.PERSON_ID%TYPE
            , P_CORP_ID              IN HRT_INSURANCE_MASTER.CORP_ID%TYPE
            , P_INSUR_TYPE           IN HRT_INSURANCE_MASTER.INSUR_TYPE%TYPE
            , P_INSUR_YN             IN HRT_INSURANCE_MASTER.INSUR_YN%TYPE
            , P_INSUR_GRADE_STEP     IN HRT_INSURANCE_MASTER.INSUR_GRADE_STEP%TYPE
            , P_INSUR_AMOUNT         IN HRT_INSURANCE_MASTER.INSUR_AMOUNT%TYPE
            , P_CARE_INSUR_REDUCE_YN IN HRT_INSURANCE_MASTER.CARE_INSUR_REDUCE_YN%TYPE
            , P_GET_DATE             IN HRT_INSURANCE_MASTER.GET_DATE%TYPE
            , P_LOSS_DATE            IN HRT_INSURANCE_MASTER.LOSS_DATE%TYPE
            , P_INSUR_NO             IN HRT_INSURANCE_MASTER.INSUR_NO%TYPE
            , P_DESCRIPTION          IN HRT_INSURANCE_MASTER.DESCRIPTION%TYPE
            , P_SOB_ID               IN HRT_INSURANCE_MASTER.SOB_ID%TYPE
            , P_ORG_ID               IN HRT_INSURANCE_MASTER.ORG_ID%TYPE
            , P_USER_ID              IN HRT_INSURANCE_MASTER.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    INSERT INTO HRT_INSURANCE_MASTER
    ( PERSON_ID
    , CORP_ID 
    , INSUR_TYPE 
    , INSUR_YN 
    , INSUR_GRADE_STEP 
    , INSUR_AMOUNT 
    , CARE_INSUR_REDUCE_YN 
    , GET_DATE 
    , LOSS_DATE 
    , INSUR_NO 
    , DESCRIPTION 
    , SOB_ID 
    , ORG_ID 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_PERSON_ID
    , P_CORP_ID
    , P_INSUR_TYPE
    , NVL(P_INSUR_YN, 'N')
    , P_INSUR_GRADE_STEP
    , P_INSUR_AMOUNT
    , NVL(P_CARE_INSUR_REDUCE_YN, 'N')
    , P_GET_DATE
    , P_LOSS_DATE
    , P_INSUR_NO
    , P_DESCRIPTION
    , P_SOB_ID
    , P_ORG_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  END INSERT_INSUR_MASTER;

-- 보험관리-건강(보수월액), 국민(소득월액) 수정.
  PROCEDURE UPDATE_INSUR_MASTER
            ( W_PERSON_ID            IN HRT_INSURANCE_MASTER.PERSON_ID%TYPE
            , P_CORP_ID              IN HRT_INSURANCE_MASTER.CORP_ID%TYPE
            , P_INSUR_TYPE           IN HRT_INSURANCE_MASTER.INSUR_TYPE%TYPE
            , P_INSUR_YN             IN HRT_INSURANCE_MASTER.INSUR_YN%TYPE
            , P_INSUR_GRADE_STEP     IN HRT_INSURANCE_MASTER.INSUR_GRADE_STEP%TYPE
            , P_INSUR_AMOUNT         IN HRT_INSURANCE_MASTER.INSUR_AMOUNT%TYPE
            , P_CARE_INSUR_REDUCE_YN IN HRT_INSURANCE_MASTER.CARE_INSUR_REDUCE_YN%TYPE
            , P_GET_DATE             IN HRT_INSURANCE_MASTER.GET_DATE%TYPE
            , P_LOSS_DATE            IN HRT_INSURANCE_MASTER.LOSS_DATE%TYPE
            , P_INSUR_NO             IN HRT_INSURANCE_MASTER.INSUR_NO%TYPE
            , P_DESCRIPTION          IN HRT_INSURANCE_MASTER.DESCRIPTION%TYPE
            , P_SOB_ID               IN HRT_INSURANCE_MASTER.SOB_ID%TYPE
            , P_ORG_ID               IN HRT_INSURANCE_MASTER.ORG_ID%TYPE
            , P_USER_ID              IN HRT_INSURANCE_MASTER.CREATED_BY%TYPE 
            )
  AS
   V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN

      UPDATE HRT_INSURANCE_MASTER
        SET INSUR_YN             = NVL(P_INSUR_YN, 'N')
          , INSUR_GRADE_STEP     = P_INSUR_GRADE_STEP
          , INSUR_AMOUNT         = P_INSUR_AMOUNT
          , CARE_INSUR_REDUCE_YN = NVL(P_CARE_INSUR_REDUCE_YN, 'N')
          , GET_DATE             = P_GET_DATE
          , LOSS_DATE            = P_LOSS_DATE
          , INSUR_NO             = P_INSUR_NO
          , DESCRIPTION          = P_DESCRIPTION
          , SOB_ID               = P_SOB_ID
          , ORG_ID               = P_ORG_ID
          , LAST_UPDATE_DATE     = V_SYSDATE
          , LAST_UPDATED_BY      = P_USER_ID
      WHERE PERSON_ID            = W_PERSON_ID
        AND CORP_ID              = P_CORP_ID
        AND INSUR_TYPE           = P_INSUR_TYPE
        AND SOB_ID               = P_SOB_ID
        AND ORG_ID               = P_ORG_ID
      ;

      IF (SQL%NOTFOUND) THEN
        INSERT_INSUR_MASTER
            ( W_PERSON_ID
            , P_CORP_ID
            , P_INSUR_TYPE
            , P_INSUR_YN
            , P_INSUR_GRADE_STEP
            , P_INSUR_AMOUNT
            , P_CARE_INSUR_REDUCE_YN
            , P_GET_DATE
            , P_LOSS_DATE
            , P_INSUR_NO
            , P_DESCRIPTION
            , P_SOB_ID
            , P_ORG_ID
            , P_USER_ID 
            );
      END IF;

  END UPDATE_INSUR_MASTER;

---------------------------------------------------------------------------------------------------
-- 건강보험/국민연금 계산 - 건강보험료는 건강보험료 + 요양보험료 금액임.
  FUNCTION INSUR_AMOUNT_F
            ( P_INSUR_YYYYMM      IN VARCHAR2
            , P_PERSON_ID         IN HRT_INSURANCE_MASTER.PERSON_ID%TYPE
            , P_INSUR_TYPE        IN HRT_INSURANCE_MASTER.INSUR_TYPE%TYPE
            , P_SOB_ID            IN HRT_INSURANCE_MASTER.SOB_ID%TYPE
            , P_ORG_ID            IN HRT_INSURANCE_MASTER.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_GENERAL_AMOUNT NUMBER := 0;  -- 보수(소득)월금액.
    V_NUMBER_LEVEL   NUMBER := 0;  -- 단수처리 단위.
    V_INSUR_AMOUNT   NUMBER := 0;  -- 산출 보험료.
  BEGIN
    BEGIN    
      SELECT IM.INSUR_AMOUNT
        INTO V_GENERAL_AMOUNT
        FROM HRT_INSURANCE_MASTER IM
      WHERE IM.PERSON_ID          = P_PERSON_ID
        AND IM.INSUR_TYPE         = P_INSUR_TYPE
        AND IM.INSUR_YN           = 'Y'
        AND IM.SOB_ID             = P_SOB_ID
        AND IM.ORG_ID             = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_GENERAL_AMOUNT := -1;  
    END;
    
    -- 금액구분 : 10 - 기준금액, 20-보수(소득)월금액.
    -- NUMBER_LEVEL_TYPE : 10-0, 11-10, 12-100, 13-1000
    -- NUMBER_CAL_TYPE : 10-내림, 20-반올림, 30-올림.
    FOR C1 IN (SELECT HIS.PERSON_RATE
                     , HIS.AMOUNT_TYPE
                     , HIS.STD_AMOUNT
                     , HIS.NUMBER_LEVEL_TYPE
                     , NL.NUMBER_LEVEL
                     , HIS.NUMBER_CAL_TYPE
                  FROM HRP_INSURANCE_STANDARD HIS
                    , HRM_NUMBER_LEVEL_V NL
                WHERE HIS.NUMBER_LEVEL_TYPE = NL.NUMBER_LEVEL_TYPE
                  AND HIS.SOB_ID            = NL.SOB_ID
                  AND HIS.ORG_ID            = NL.ORG_ID
                  AND HIS.INSUR_TYPE        = P_INSUR_TYPE
                  AND HIS.SOB_ID            = P_SOB_ID
                  AND HIS.ORG_ID            = P_ORG_ID
                  AND (HIS.INSUR_YYYYMM_FR   <= P_INSUR_YYYYMM
                  AND HIS.INSUR_YYYYMM_TO   >= P_INSUR_YYYYMM)
                  AND (HIS.START_AMOUNT      <= V_GENERAL_AMOUNT
                  AND HIS.END_AMOUNT        >= V_GENERAL_AMOUNT)
                  AND ROWNUM                <= 1
               )
    LOOP
      -- 보험료 산출.
      IF C1.AMOUNT_TYPE = '20' THEN
        -- 보수(소득)월금액.
        V_INSUR_AMOUNT := NVL(V_GENERAL_AMOUNT, 0) * (C1.PERSON_RATE / 100);
      ELSE
      -- 기준금액.
        V_INSUR_AMOUNT := NVL(C1.STD_AMOUNT, 0) * (C1.PERSON_RATE / 100);      
      END IF;
      
      -- 단수처리 단위.
      V_NUMBER_LEVEL := (LENGTH(ABS(C1.NUMBER_LEVEL)) - 1) * SIGN(C1.NUMBER_LEVEL);
      
      -- 단수처리.
      SELECT CASE
               WHEN C1.NUMBER_CAL_TYPE = '10' THEN TRUNC(V_INSUR_AMOUNT, -V_NUMBER_LEVEL)
               WHEN C1.NUMBER_CAL_TYPE = '30' THEN CEIL(V_INSUR_AMOUNT)
               ELSE ROUND(V_INSUR_AMOUNT, -V_NUMBER_LEVEL)
             END AS INSUR_AMOUNT_F
        INTO V_INSUR_AMOUNT
        FROM DUAL;
    END LOOP C1;
    RETURN V_INSUR_AMOUNT;
  END INSUR_AMOUNT_F;
            
-- 요양보험료 계산.
  FUNCTION CARE_INSUR_AMOUNT_F
            ( P_INSUR_YYYYMM         IN VARCHAR2
            , P_PERSON_ID            IN HRT_INSURANCE_MASTER.PERSON_ID%TYPE
            , P_SOB_ID               IN HRT_INSURANCE_MASTER.SOB_ID%TYPE
            , P_ORG_ID               IN HRT_INSURANCE_MASTER.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_CARE_INSUR_AMOUNT NUMBER := 0;
    V_INSUR_AMOUNT      NUMBER := 0;
    V_CARE_INSUR_REDUCE_YN  VARCHAR2(2) := 'N';  -- 요양보험경감 여부.
  BEGIN 
    BEGIN    
      SELECT NVL(IM.CARE_INSUR_REDUCE_YN, 'N') AS CARE_INSUR_REDUCE_YN
        INTO V_CARE_INSUR_REDUCE_YN
        FROM HRT_INSURANCE_MASTER IM
      WHERE IM.PERSON_ID          = P_PERSON_ID
        AND IM.INSUR_TYPE         = 'M'
        AND IM.INSUR_YN           = 'Y'
        AND IM.SOB_ID             = P_SOB_ID
        AND IM.ORG_ID             = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CARE_INSUR_REDUCE_YN := 'N';  
    END;
    
    -- 건강보험료.
    V_INSUR_AMOUNT := INSUR_AMOUNT_F(P_INSUR_YYYYMM, P_PERSON_ID, 'M', P_SOB_ID, P_ORG_ID);
    
    -- NUMBER_LEVEL_TYPE : 10-0, 11-10, 12-100, 13-1000
    -- NUMBER_CAL_TYPE : 10-내림, 20-반올림, 30-올림.
    FOR C1 IN (SELECT IR.INSUR_RATE
                    , IR.REDUCE_RATE
                  FROM HRM_INSUR_RATE_V IR
                WHERE IR.INSUR_TYPE     = 'CI'  -- CARE INSURANCE : 요양보험.
                  AND IR.SOB_ID         = P_SOB_ID
                  AND IR.ORG_ID         = P_ORG_ID
                  AND IR.ENABLED_FLAG   = 'Y'
                  AND IR.EFFECTIVE_DATE_FR  <= LAST_DAY(TO_DATE(P_INSUR_YYYYMM, 'YYYY-MM'))
                  AND (IR.EFFECTIVE_DATE_TO IS NULL OR IR.EFFECTIVE_DATE_TO >= TRUNC(TO_DATE(P_INSUR_YYYYMM, 'YYYY-MM'), 'MONTH'))
                  AND ROWNUM            <= 1
               )
    LOOP
      -- 보험료 산출.
      V_CARE_INSUR_AMOUNT := NVL(V_INSUR_AMOUNT, 0) * (C1.INSUR_RATE / 100);
      IF V_CARE_INSUR_REDUCE_YN = 'Y' THEN
        V_CARE_INSUR_AMOUNT := NVL(V_CARE_INSUR_AMOUNT, 0) * ( C1.REDUCE_RATE / 100);  
      END IF;
      
      -- 단수처리.
      V_CARE_INSUR_AMOUNT := TRUNC(V_CARE_INSUR_AMOUNT, -1);
    END LOOP C1;
    RETURN V_CARE_INSUR_AMOUNT;    
  END CARE_INSUR_AMOUNT_F;
  
END HRT_INSURANCE_MASTER_G;
/
