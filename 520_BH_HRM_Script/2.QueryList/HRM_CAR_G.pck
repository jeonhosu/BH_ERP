CREATE OR REPLACE PACKAGE HRM_CAR_G
AS

/******************************************************************************/
/* Project      : HRM ERP
/* Module       : 
/* Program Name : HRM_CAR_G
/* Description  : 차량관리
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 08-JUL-2013  Shin Sang Hee       Initialize
/******************************************************************************/

-- 차량유지 대상자 조회
  PROCEDURE SELECT_HRM_CAR( P_CURSOR            OUT TYPES.TCURSOR
                          , W_CORP_ID           IN HRM_PERSON_MASTER.CORP_ID%TYPE
                          , W_PERSON_ID         IN HRM_CAR.PERSON_ID%TYPE
                          , W_DEPT_ID           IN HRM_PERSON_MASTER.DEPT_ID%TYPE
                          , W_SOB_ID            IN HRM_CAR.SOB_ID%TYPE
						              , W_ORG_ID            IN HRM_CAR.ORG_ID%TYPE
                          , W_FLOOR_ID          IN HRM_PERSON_MASTER.FLOOR_ID%TYPE
                          , W_STD_DATE          IN HRM_CAR.EFFECTIVE_DATE_FR%TYPE
                          , W_ENABLE_FLAG       IN HRM_CAR.ENABLED_FLAG%TYPE
                          );

-- 차량유지 대상자 입력.
  PROCEDURE INSERT_HRM_CAR( O_CAR_NUMBER_ID     OUT HRM_CAR.CAR_NUMBER_ID%TYPE
                          , P_SOB_ID            IN HRM_CAR.SOB_ID%TYPE
						              , P_ORG_ID            IN HRM_CAR.ORG_ID%TYPE
                          , P_PERSON_ID         IN HRM_CAR.PERSON_ID%TYPE
                          , P_CAR_NUMBER        IN HRM_CAR.CAR_NUMBER%TYPE
                          , P_CAR_TYPE_ID       IN HRM_CAR.CAR_TYPE_ID%TYPE
                          , P_RELATION_ID       IN HRM_CAR.RELATION_ID%TYPE
                          , P_CAR_AMOUNT        IN HRM_CAR.CAR_AMOUNT%TYPE
                          , P_EPPECTIVE_DATE_FR IN HRM_CAR.EFFECTIVE_DATE_FR%TYPE
                          , P_EPPECTIVE_DATE_tO IN HRM_CAR.EFFECTIVE_DATE_TO%TYPE
                          , P_ENABLE_FLAG       IN HRM_CAR.ENABLED_FLAG%TYPE
                          , P_DESCRIPTION       IN HRM_CAR.DESCRIPTION%TYPE
                          , P_USER_ID           IN HRM_CAR.PERSON_ID%TYPE
                          );
                          
-- 차량유지 대상자 업데이트.
  PROCEDURE UPDATE_HRM_CAR( W_CAR_NUMBER_ID     IN HRM_CAR.CAR_NUMBER_ID%TYPE
                        , P_SOB_ID            IN HRM_CAR.SOB_ID%TYPE
                        , P_ORG_ID            IN HRM_CAR.ORG_ID%TYPE
                        , P_CAR_NUMBER        IN HRM_CAR.CAR_NUMBER%TYPE
                        , P_CAR_TYPE_ID       IN HRM_CAR.CAR_TYPE_ID%TYPE
                        , P_RELATION_ID       IN HRM_CAR.RELATION_ID%TYPE
                        , P_CAR_AMOUNT        IN HRM_CAR.CAR_AMOUNT%TYPE
                        , P_EFFECTIVE_DATE_FR IN HRM_CAR.EFFECTIVE_DATE_FR%TYPE
                        , P_EFFECTIVE_DATE_TO IN HRM_CAR.EFFECTIVE_DATE_TO%TYPE
                        , P_ENABLE_FLAG       IN HRM_CAR.ENABLED_FLAG%TYPE
                        , P_DESCRIPTION       IN HRM_CAR.DESCRIPTION%TYPE
                        , P_USER_ID           IN HRM_CAR.PERSON_ID%TYPE
                        );
                                                 
 -- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_PERSON_ID                         IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_POST_ID                           IN NUMBER
            , W_FLOOR_ID                          IN NUMBER
            , W_STD_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );
            
                                     
END HRM_CAR_G;
/
CREATE OR REPLACE PACKAGE BODY HRM_CAR_G
AS

/******************************************************************************/
/* Project      : HRM ERP
/* Module       : 
/* Program Name : HRM_CAR_G
/* Description  : 차량관리
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 08-JUL-2013  Shin Sang Hee       Initialize
/******************************************************************************/

-- 차량유지 대상자 조회
  PROCEDURE SELECT_HRM_CAR( P_CURSOR            OUT TYPES.TCURSOR
                          , W_CORP_ID           IN HRM_PERSON_MASTER.CORP_ID%TYPE
                          , W_PERSON_ID         IN HRM_CAR.PERSON_ID%TYPE
                          , W_DEPT_ID           IN HRM_PERSON_MASTER.DEPT_ID%TYPE
                          , W_SOB_ID            IN HRM_CAR.SOB_ID%TYPE
						              , W_ORG_ID            IN HRM_CAR.ORG_ID%TYPE
                          , W_FLOOR_ID          IN HRM_PERSON_MASTER.FLOOR_ID%TYPE
                          , W_STD_DATE          IN HRM_CAR.EFFECTIVE_DATE_FR%TYPE
                          , W_ENABLE_FLAG       IN HRM_CAR.ENABLED_FLAG%TYPE
                          )
  AS 
  BEGIN
    OPEN P_CURSOR FOR
     SELECT HC.PERSON_ID
          , PM.NAME AS PERSON_NAME
          , PM.CORP_ID
          , PM.DEPT_ID
          , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID) AS DEPT_NAME
          , HC.CAR_NUMBER
          , HC.CAR_TYPE_ID
          , HRM_COMMON_G.ID_NAME_F(HC.CAR_TYPE_ID) AS CAR_TYPE_NAME
          , HC.RELATION_ID
          , HRM_COMMON_G.ID_NAME_F(HC.RELATION_ID) RELATION_NAME
          , HC.CAR_AMOUNT
          , HC.ENABLED_FLAG
          , HC.EFFECTIVE_DATE_FR
          , HC.EFFECTIVE_DATE_TO
          , HC.DESCRIPTION
          , PM.FLOOR_ID
          , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) FLOOR_NAME
          , PM.POST_ID
          , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_NAME
          , PM.JOIN_DATE
          , PM.HP_PHONE_NO
          , HC.CAR_NUMBER_ID
       FROM HRM_CAR           HC
          , HRM_PERSON_MASTER PM
      WHERE HC.PERSON_ID                        = PM.PERSON_ID
        AND PM.CORP_ID                          = W_CORP_ID
        AND HC.PERSON_ID                        = NVL(W_PERSON_ID, HC.PERSON_ID)
        AND PM.DEPT_ID                          = NVL(W_DEPT_ID, PM.DEPT_ID)
        AND PM.FLOOR_ID                         = NVL(W_FLOOR_ID, PM.FLOOR_ID)
        AND HC.SOB_ID                           = W_SOB_ID
        AND HC.ORG_ID                           = W_ORG_ID
        AND HC.EFFECTIVE_DATE_FR                <= W_STD_DATE
        AND HC.ENABLED_FLAG                     = NVL(W_ENABLE_FLAG, HC.ENABLED_FLAG)
   ORDER BY PM.DEPT_ID;
  END SELECT_HRM_CAR;
  
  
-- 차량유지 대상자 입력.
  PROCEDURE INSERT_HRM_CAR( O_CAR_NUMBER_ID     OUT HRM_CAR.CAR_NUMBER_ID%TYPE
                          , P_SOB_ID            IN HRM_CAR.SOB_ID%TYPE
						              , P_ORG_ID            IN HRM_CAR.ORG_ID%TYPE
                          , P_PERSON_ID         IN HRM_CAR.PERSON_ID%TYPE
                          , P_CAR_NUMBER        IN HRM_CAR.CAR_NUMBER%TYPE
                          , P_CAR_TYPE_ID       IN HRM_CAR.CAR_TYPE_ID%TYPE
                          , P_RELATION_ID       IN HRM_CAR.RELATION_ID%TYPE
                          , P_CAR_AMOUNT        IN HRM_CAR.CAR_AMOUNT%TYPE
                          , P_EPPECTIVE_DATE_FR IN HRM_CAR.EFFECTIVE_DATE_FR%TYPE
                          , P_EPPECTIVE_DATE_tO IN HRM_CAR.EFFECTIVE_DATE_TO%TYPE
                          , P_ENABLE_FLAG       IN HRM_CAR.ENABLED_FLAG%TYPE
                          , P_DESCRIPTION       IN HRM_CAR.DESCRIPTION%TYPE
                          , P_USER_ID           IN HRM_CAR.PERSON_ID%TYPE)
                          
  IS
   V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
   
  BEGIN
   SELECT HRM_CAR_S1.NEXTVAL
     INTO O_CAR_NUMBER_ID
     FROM DUAL;
     
  INSERT INTO HRM_CAR
            ( CAR_NUMBER_ID
            , SOB_ID
            , ORG_ID
            , PERSON_ID
            , CAR_NUMBER
            , CAR_TYPE_ID
            , RELATION_ID
            , CAR_AMOUNT
            , DESCRIPTION
            , EFFECTIVE_DATE_FR
            , EFFECTIVE_DATE_TO
            , ENABLED_FLAG
            , CREATION_DATE
            , CREATED_BY
            , LAST_UPDATE_DATE
            , LAST_UPDATED_BY 
            )
  VALUES
            ( O_CAR_NUMBER_ID
            , P_SOB_ID
            , P_ORG_ID
            , P_PERSON_ID 
            , P_CAR_NUMBER
            , P_CAR_TYPE_ID
            , P_RELATION_ID
            , P_CAR_AMOUNT
            , P_DESCRIPTION
            , P_EPPECTIVE_DATE_FR
            , P_EPPECTIVE_DATE_TO
            , P_ENABLE_FLAG
            , V_SYSDATE
            , P_USER_ID
            , V_SYSDATE
            , P_USER_ID
            );
  END INSERT_HRM_CAR;    

PROCEDURE UPDATE_HRM_CAR( W_CAR_NUMBER_ID     IN HRM_CAR.CAR_NUMBER_ID%TYPE
                        , P_SOB_ID            IN HRM_CAR.SOB_ID%TYPE
                        , P_ORG_ID            IN HRM_CAR.ORG_ID%TYPE
                        
                        , P_CAR_NUMBER        IN HRM_CAR.CAR_NUMBER%TYPE
                        , P_CAR_TYPE_ID       IN HRM_CAR.CAR_TYPE_ID%TYPE
                        , P_RELATION_ID       IN HRM_CAR.RELATION_ID%TYPE
                        , P_CAR_AMOUNT        IN HRM_CAR.CAR_AMOUNT%TYPE
                        , P_EFFECTIVE_DATE_FR IN HRM_CAR.EFFECTIVE_DATE_FR%TYPE
                        , P_EFFECTIVE_DATE_TO IN HRM_CAR.EFFECTIVE_DATE_TO%TYPE
                        , P_ENABLE_FLAG       IN HRM_CAR.ENABLED_FLAG%TYPE
                        , P_DESCRIPTION       IN HRM_CAR.DESCRIPTION%TYPE
                        , P_USER_ID           IN HRM_CAR.PERSON_ID%TYPE)

  AS
    V_SYSDATE                          DATE := GET_LOCAL_DATE(P_SOB_ID);   
    
  BEGIN 

   UPDATE HRM_CAR
       SET CAR_NUMBER                   = P_CAR_NUMBER
         , CAR_TYPE_ID                  = P_CAR_TYPE_ID
         , RELATION_ID                  = P_RELATION_ID
         , CAR_AMOUNT                   = P_CAR_AMOUNT
         , DESCRIPTION                  = P_DESCRIPTION
         , EFFECTIVE_DATE_FR            = P_EFFECTIVE_DATE_FR
         , EFFECTIVE_DATE_TO            = P_EFFECTIVE_DATE_TO
         , ENABLED_FLAG                 = P_ENABLE_FLAG
         , LAST_UPDATE_DATE             = V_SYSDATE
         , LAST_UPDATED_BY              = P_USER_ID 
     WHERE CAR_NUMBER_ID                = W_CAR_NUMBER_ID
       AND SOB_ID                       = P_SOB_ID
       AND ORG_ID                       = P_ORG_ID;
   
END UPDATE_HRM_CAR;    

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_PERSON_ID                         IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_POST_ID                           IN NUMBER
            , W_FLOOR_ID                          IN NUMBER
            , W_STD_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT PM.NAME AS NAME
          , PM.PERSON_NUM
          , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID) AS CORP_NAME
          , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.FLOOR_ID) AS FLOOR_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME  
          , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
          , PM.ORI_JOIN_DATE
          , PM.JOIN_DATE
          , PM.RETIRE_DATE
          , PM.PERSON_ID
          , PM.CORP_ID
          , PM.DEPT_ID
          , T1.FLOOR_ID
          , PM.POST_ID
          , PM.PAY_GRADE_ID
          , PM.HP_PHONE_NO
      FROM HRM_PERSON_MASTER PM
        , (-- 시점 인사내역.
            SELECT HL.PERSON_ID
                , HL.DEPT_ID
                , HL.POST_ID
                , HL.PAY_GRADE_ID
                , HL.JOB_CATEGORY_ID
                , HL.FLOOR_ID    
            FROM HRM_HISTORY_LINE HL
            WHERE ((W_DEPT_ID         IS NULL AND 1 = 1)
              OR   (W_DEPT_ID         IS NOT NULL AND HL.DEPT_ID = W_DEPT_ID))
              AND ((W_FLOOR_ID        IS NULL AND 1 = 1)
              OR   (W_FLOOR_ID        IS NOT NULL AND HL.FLOOR_ID = W_FLOOR_ID))
              AND ((W_POST_ID         IS NULL AND 1 = 1)
              OR   (W_POST_ID         IS NOT NULL AND HL.POST_ID = W_POST_ID))
              AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                            FROM HRM_HISTORY_LINE S_HL
                                           WHERE S_HL.CHARGE_DATE            <= W_STD_DATE
                                             AND S_HL.PERSON_ID              = HL.PERSON_ID
                                           GROUP BY S_HL.PERSON_ID
                                         )
          ) T1
      WHERE PM.PERSON_ID                               = T1.PERSON_ID
        AND PM.CORP_ID                                 = NVL(W_CORP_ID, PM.CORP_ID)
        AND PM.PERSON_ID                               = NVL(W_PERSON_ID, PM.PERSON_ID)
        AND PM.JOIN_DATE                               <= W_STD_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_STD_DATE)
        AND PM.SOB_ID                                  = W_SOB_ID
        AND PM.ORG_ID                                  = W_ORG_ID
      ;

  END LU_PERSON_SELECT;

 
END HRM_CAR_G;
/
