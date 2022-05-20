CREATE OR REPLACE PACKAGE HRP_INSURANCE_CHARGE_G
AS

-- INSURANCE CHARGE SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_INSURANCE_CHARGE.CORP_ID%TYPE
            , W_STD_DATE                          IN HRM_PERSON_MASTER.JOIN_DATE%TYPE
            , W_INSUR_TYPE                        IN HRP_INSURANCE_CHARGE.INSUR_TYPE%TYPE
            , W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRP_INSURANCE_CHARGE.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_INSURANCE_CHARGE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_INSURANCE_CHARGE.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- INSURANCE CHARGE_INSERT
  PROCEDURE INSUR_CHARGE_INSERT
            ( P_PERSON_ID         IN HRP_INSURANCE_CHARGE.PERSON_ID%TYPE
            , P_CORP_ID           IN HRP_INSURANCE_CHARGE.CORP_ID%TYPE
            , P_INSUR_TYPE        IN HRP_INSURANCE_CHARGE.INSUR_TYPE%TYPE
            , P_INSUR_YN          IN HRP_INSURANCE_CHARGE.INSUR_YN%TYPE
            , P_INSUR_NO          IN HRP_INSURANCE_CHARGE.INSUR_NO%TYPE
            , P_INSUR_GRADE_STEP  IN HRP_INSURANCE_CHARGE.INSUR_GRADE_STEP%TYPE
            , P_CORP_INSUR_AMOUNT       IN HRP_INSURANCE_CHARGE.CORP_INSUR_AMOUNT%TYPE
            , P_CORP_INSUR_ADD_AMOUNT   IN HRP_INSURANCE_CHARGE.CORP_INSUR_ADD_AMOUNT%TYPE
            , P_PERSON_INSUR_AMOUNT     IN HRP_INSURANCE_CHARGE.PERSON_INSUR_AMOUNT%TYPE
            , P_PERSON_INSUR_ADD_AMOUNT IN HRP_INSURANCE_CHARGE.PERSON_INSUR_ADD_AMOUNT%TYPE
            , P_DESCRIPTION       IN HRP_INSURANCE_CHARGE.DESCRIPTION%TYPE
            , P_GET_DATE          IN HRP_INSURANCE_CHARGE.GET_DATE%TYPE
            , P_LOSS_DATE         IN HRP_INSURANCE_CHARGE.LOSS_DATE%TYPE
            , P_SOB_ID            IN HRP_INSURANCE_CHARGE.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_INSURANCE_CHARGE.ORG_ID%TYPE
            , P_USER_ID           IN HRP_INSURANCE_CHARGE.CREATED_BY%TYPE 
            );

-- INSURANCE CHARGE_UPDATE.
  PROCEDURE INSUR_CHARGE_UPDATE
            ( W_PERSON_ID         IN HRP_INSURANCE_CHARGE.PERSON_ID%TYPE
            , W_CORP_ID           IN HRP_INSURANCE_CHARGE.CORP_ID%TYPE
            , W_INSUR_TYPE        IN HRP_INSURANCE_CHARGE.INSUR_TYPE%TYPE
            , W_SOB_ID            IN HRP_INSURANCE_CHARGE.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_INSURANCE_CHARGE.ORG_ID%TYPE
            , P_INSUR_YN          IN HRP_INSURANCE_CHARGE.INSUR_YN%TYPE            
            , P_INSUR_NO          IN HRP_INSURANCE_CHARGE.INSUR_NO%TYPE
            , P_INSUR_GRADE_STEP  IN HRP_INSURANCE_CHARGE.INSUR_GRADE_STEP%TYPE
            , P_CORP_INSUR_AMOUNT       IN HRP_INSURANCE_CHARGE.CORP_INSUR_AMOUNT%TYPE
            , P_CORP_INSUR_ADD_AMOUNT   IN HRP_INSURANCE_CHARGE.CORP_INSUR_ADD_AMOUNT%TYPE
            , P_PERSON_INSUR_AMOUNT     IN HRP_INSURANCE_CHARGE.PERSON_INSUR_AMOUNT%TYPE
            , P_PERSON_INSUR_ADD_AMOUNT IN HRP_INSURANCE_CHARGE.PERSON_INSUR_ADD_AMOUNT%TYPE
            , P_DESCRIPTION       IN HRP_INSURANCE_CHARGE.DESCRIPTION%TYPE
            , P_GET_DATE          IN HRP_INSURANCE_CHARGE.GET_DATE%TYPE
            , P_LOSS_DATE         IN HRP_INSURANCE_CHARGE.LOSS_DATE%TYPE
            , P_USER_ID           IN HRP_INSURANCE_CHARGE.CREATED_BY%TYPE 
            );
            
---------------------------------------------------------------------------------------------------
-- PAYMENT - INSURANCE SELECT.
  PROCEDURE INSUR_PAYMENT
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , W_CORP_ID           IN HRP_INSURANCE_CHARGE.CORP_ID%TYPE
            , W_PERSON_ID         IN HRP_INSURANCE_CHARGE.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_INSURANCE_CHARGE.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_INSURANCE_CHARGE.ORG_ID%TYPE
            );  
                      
END HRP_INSURANCE_CHARGE_G;
/
CREATE OR REPLACE PACKAGE BODY HRP_INSURANCE_CHARGE_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRP_INSURANCE_CHARGE_G
/* DESCRIPTION  : 焊氰包府.
/* REFERENCE BY :
/* PROGRAM HISTORY : 脚痹 积己
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- INSURANCE CHARGE SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_INSURANCE_CHARGE.CORP_ID%TYPE
            , W_STD_DATE                          IN HRM_PERSON_MASTER.JOIN_DATE%TYPE
            , W_INSUR_TYPE                        IN HRP_INSURANCE_CHARGE.INSUR_TYPE%TYPE
            , W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRP_INSURANCE_CHARGE.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_INSURANCE_CHARGE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_INSURANCE_CHARGE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
           , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
           , PM.PERSON_NUM
           , PM.NAME
           , PM.ORI_JOIN_DATE
           , PM.JOIN_DATE
           , PM.RETIRE_DATE
           , PM.PERSON_ID 
           , PM.CORP_ID
           , NVL(T1.INSUR_YN, 'Y') AS INSUR_YN
           , T1.INSUR_NO
           , T1.INSUR_GRADE_STEP
           , T1.CORP_INSUR_AMOUNT
           , T1.CORP_INSUR_ADD_AMOUNT
           , T1.PERSON_INSUR_AMOUNT
           , T1.PERSON_INSUR_ADD_AMOUNT
           , T1.DESCRIPTION
           , T1.GET_DATE
           , T1.LOSS_DATE
           , W_INSUR_TYPE AS INSUR_TYPE
        FROM HRM_HISTORY_LINE HL  
          , HRM_PERSON_MASTER PM
          , (-- 焊氰包府.
            SELECT IC.PERSON_ID
                 , IC.CORP_ID
                 , IC.INSUR_YN
                 , IC.INSUR_NO
                 , IC.INSUR_GRADE_STEP
                 , IC.CORP_INSUR_AMOUNT
                 , IC.CORP_INSUR_ADD_AMOUNT
                 , IC.PERSON_INSUR_AMOUNT
                 , IC.PERSON_INSUR_ADD_AMOUNT
                 , IC.DESCRIPTION
                 , IC.GET_DATE
                 , IC.LOSS_DATE
                 , IC.SOB_ID
                 , IC.ORG_ID
              FROM HRP_INSURANCE_CHARGE IC
             WHERE IC.CORP_ID               = W_CORP_ID
               AND IC.PERSON_ID             = NVL(W_PERSON_ID, IC.PERSON_ID)
               AND IC.INSUR_TYPE            = W_INSUR_TYPE
               AND IC.SOB_ID                = W_SOB_ID
               AND IC.ORG_ID                = W_ORG_ID  
            )T1
      WHERE HL.PERSON_ID        = PM.PERSON_ID
        AND PM.PERSON_ID        = T1.PERSON_ID(+)
        AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                      FROM HRM_HISTORY_LINE S_HL
                                     WHERE S_HL.CHARGE_DATE            <= W_STD_DATE
                                       AND S_HL.PERSON_ID              = HL.PERSON_ID
                                     GROUP BY S_HL.PERSON_ID
                                   )
        AND PM.CORP_ID          = W_CORP_ID
        AND PM.PERSON_ID        = NVL(W_PERSON_ID, PM.PERSON_ID)
        AND HL.DEPT_ID          = NVL(W_DEPT_ID, HL.DEPT_ID)
        AND PM.ORI_JOIN_DATE    <= W_STD_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_STD_DATE)
        AND PM.SOB_ID           = W_SOB_ID
        AND PM.ORG_ID           = W_ORG_ID
      ORDER BY HL.DEPT_ID, HL.POST_ID, HL.PERSON_ID
      ;
      
  END DATA_SELECT;

---------------------------------------------------------------------------------------------------
-- INSURANCE CHARGE_INSERT
  PROCEDURE INSUR_CHARGE_INSERT
          ( P_PERSON_ID         IN HRP_INSURANCE_CHARGE.PERSON_ID%TYPE
          , P_CORP_ID           IN HRP_INSURANCE_CHARGE.CORP_ID%TYPE
          , P_INSUR_TYPE        IN HRP_INSURANCE_CHARGE.INSUR_TYPE%TYPE
          , P_INSUR_YN          IN HRP_INSURANCE_CHARGE.INSUR_YN%TYPE
          , P_INSUR_NO          IN HRP_INSURANCE_CHARGE.INSUR_NO%TYPE
          , P_INSUR_GRADE_STEP  IN HRP_INSURANCE_CHARGE.INSUR_GRADE_STEP%TYPE
          , P_CORP_INSUR_AMOUNT       IN HRP_INSURANCE_CHARGE.CORP_INSUR_AMOUNT%TYPE
          , P_CORP_INSUR_ADD_AMOUNT   IN HRP_INSURANCE_CHARGE.CORP_INSUR_ADD_AMOUNT%TYPE
          , P_PERSON_INSUR_AMOUNT     IN HRP_INSURANCE_CHARGE.PERSON_INSUR_AMOUNT%TYPE
          , P_PERSON_INSUR_ADD_AMOUNT IN HRP_INSURANCE_CHARGE.PERSON_INSUR_ADD_AMOUNT%TYPE
          , P_DESCRIPTION       IN HRP_INSURANCE_CHARGE.DESCRIPTION%TYPE
          , P_GET_DATE          IN HRP_INSURANCE_CHARGE.GET_DATE%TYPE
          , P_LOSS_DATE         IN HRP_INSURANCE_CHARGE.LOSS_DATE%TYPE
          , P_SOB_ID            IN HRP_INSURANCE_CHARGE.SOB_ID%TYPE
          , P_ORG_ID            IN HRP_INSURANCE_CHARGE.ORG_ID%TYPE
          , P_USER_ID           IN HRP_INSURANCE_CHARGE.CREATED_BY%TYPE 
          )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);

  BEGIN

      INSERT INTO HRP_INSURANCE_CHARGE
      ( PERSON_ID
      , CORP_ID 
      , INSUR_TYPE 
      , INSUR_YN 
      , INSUR_NO 
      , INSUR_GRADE_STEP 
      , CORP_INSUR_AMOUNT 
      , CORP_INSUR_ADD_AMOUNT 
      , PERSON_INSUR_AMOUNT 
      , PERSON_INSUR_ADD_AMOUNT
      , DESCRIPTION 
      , GET_DATE 
      , LOSS_DATE 
      , SOB_ID 
      , ORG_ID 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( P_PERSON_ID
      , P_CORP_ID
      , P_INSUR_TYPE
      , P_INSUR_YN
      , P_INSUR_NO
      , P_INSUR_GRADE_STEP
      , P_CORP_INSUR_AMOUNT
      , P_CORP_INSUR_ADD_AMOUNT
      , P_PERSON_INSUR_AMOUNT
      , P_PERSON_INSUR_ADD_AMOUNT
      , P_DESCRIPTION
      , P_GET_DATE
      , P_LOSS_DATE
      , P_SOB_ID
      , P_ORG_ID
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID 
      );
       
  END INSUR_CHARGE_INSERT;

-- INSURANCE CHARGE_UPDATE.
  PROCEDURE INSUR_CHARGE_UPDATE
            ( W_PERSON_ID         IN HRP_INSURANCE_CHARGE.PERSON_ID%TYPE
            , W_CORP_ID           IN HRP_INSURANCE_CHARGE.CORP_ID%TYPE
            , W_INSUR_TYPE        IN HRP_INSURANCE_CHARGE.INSUR_TYPE%TYPE
            , W_SOB_ID            IN HRP_INSURANCE_CHARGE.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_INSURANCE_CHARGE.ORG_ID%TYPE
            , P_INSUR_YN          IN HRP_INSURANCE_CHARGE.INSUR_YN%TYPE            
            , P_INSUR_NO          IN HRP_INSURANCE_CHARGE.INSUR_NO%TYPE
            , P_INSUR_GRADE_STEP  IN HRP_INSURANCE_CHARGE.INSUR_GRADE_STEP%TYPE
            , P_CORP_INSUR_AMOUNT       IN HRP_INSURANCE_CHARGE.CORP_INSUR_AMOUNT%TYPE
            , P_CORP_INSUR_ADD_AMOUNT   IN HRP_INSURANCE_CHARGE.CORP_INSUR_ADD_AMOUNT%TYPE
            , P_PERSON_INSUR_AMOUNT     IN HRP_INSURANCE_CHARGE.PERSON_INSUR_AMOUNT%TYPE
            , P_PERSON_INSUR_ADD_AMOUNT IN HRP_INSURANCE_CHARGE.PERSON_INSUR_ADD_AMOUNT%TYPE
            , P_DESCRIPTION       IN HRP_INSURANCE_CHARGE.DESCRIPTION%TYPE
            , P_GET_DATE          IN HRP_INSURANCE_CHARGE.GET_DATE%TYPE
            , P_LOSS_DATE         IN HRP_INSURANCE_CHARGE.LOSS_DATE%TYPE
            , P_USER_ID           IN HRP_INSURANCE_CHARGE.CREATED_BY%TYPE 
            )
  AS
   V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
   
  BEGIN
      
      UPDATE HRP_INSURANCE_CHARGE IC
        SET IC.INSUR_YN          = P_INSUR_YN
          , IC.INSUR_NO          = P_INSUR_NO
          , IC.INSUR_GRADE_STEP  = P_INSUR_GRADE_STEP
          , IC.CORP_INSUR_AMOUNT        = P_CORP_INSUR_AMOUNT
          , IC.CORP_INSUR_ADD_AMOUNT    = P_CORP_INSUR_ADD_AMOUNT
          , IC.PERSON_INSUR_AMOUNT      = P_PERSON_INSUR_AMOUNT
          , IC.PERSON_INSUR_ADD_AMOUNT  = P_PERSON_INSUR_ADD_AMOUNT
          , IC.DESCRIPTION       = P_DESCRIPTION
          , IC.GET_DATE          = P_GET_DATE
          , IC.LOSS_DATE         = P_LOSS_DATE
          , IC.LAST_UPDATE_DATE  = V_SYSDATE
          , IC.LAST_UPDATED_BY   = P_USER_ID
      WHERE IC.PERSON_ID         = W_PERSON_ID
        AND IC.CORP_ID           = W_CORP_ID
        AND IC.INSUR_TYPE        = W_INSUR_TYPE
        AND IC.SOB_ID            = W_SOB_ID
        AND IC.ORG_ID            = W_ORG_ID
      ;
      
      IF (SQL%NOTFOUND) THEN
        INSUR_CHARGE_INSERT( P_PERSON_ID => W_PERSON_ID
                           , P_CORP_ID => W_CORP_ID
                           , P_INSUR_TYPE => W_INSUR_TYPE
                           , P_INSUR_YN => P_INSUR_YN
                           , P_INSUR_NO => P_INSUR_NO
                           , P_INSUR_GRADE_STEP => P_INSUR_GRADE_STEP
                           , P_CORP_INSUR_AMOUNT => P_CORP_INSUR_AMOUNT
                           , P_CORP_INSUR_ADD_AMOUNT => P_CORP_INSUR_ADD_AMOUNT
                           , P_PERSON_INSUR_AMOUNT => P_PERSON_INSUR_AMOUNT
                           , P_PERSON_INSUR_ADD_AMOUNT => P_PERSON_INSUR_ADD_AMOUNT
                           , P_DESCRIPTION => P_DESCRIPTION
                           , P_GET_DATE => P_GET_DATE
                           , P_LOSS_DATE => P_LOSS_DATE
                           , P_SOB_ID => W_SOB_ID
                           , P_ORG_ID => W_ORG_ID
                           , P_USER_ID => P_USER_ID
                           );
      END IF;

  END INSUR_CHARGE_UPDATE;


---------------------------------------------------------------------------------------------------
-- PAYMENT - INSURANCE SELECT.
  PROCEDURE INSUR_PAYMENT
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , W_CORP_ID           IN HRP_INSURANCE_CHARGE.CORP_ID%TYPE
            , W_PERSON_ID         IN HRP_INSURANCE_CHARGE.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_INSURANCE_CHARGE.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_INSURANCE_CHARGE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT IC.PERSON_ID
           , IC.CORP_ID
           , IT.INSUR_TYPE_NAME 
           , NVL(IC.PERSON_INSUR_AMOUNT, 0) + NVL(IC.PERSON_INSUR_ADD_AMOUNT, 0) AS PENS_INSUR_AMOUNT
           , IC.INSUR_YN
        FROM HRP_INSURANCE_CHARGE IC
          , HRM_INSUR_TYPE_V IT
       WHERE IC.INSUR_TYPE            = IT.INSUR_TYPE
         AND IC.SOB_ID                = IT.SOB_ID
         AND IC.ORG_ID                = IC.ORG_ID
         AND IC.CORP_ID               = W_CORP_ID
         AND IC.PERSON_ID             = W_PERSON_ID
         AND IC.SOB_ID                = W_SOB_ID
         AND IC.ORG_ID                = W_ORG_ID
      ;
        
  END INSUR_PAYMENT;
  
END HRP_INSURANCE_CHARGE_G;
/
