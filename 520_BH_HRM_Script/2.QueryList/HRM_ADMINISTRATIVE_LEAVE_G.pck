CREATE OR REPLACE PACKAGE HRM_ADMINISTRATIVE_LEAVE_G
AS

-- 휴직자 조회.
  PROCEDURE SELECT_ADMINISTRATIVE_LEAVE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN  NUMBER
            , W_STD_DATE          IN  DATE
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_PERSON_ID         IN  NUMBER
            , W_ALL_YN            IN  VARCHAR2
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );

-- 휴직자 INSERT.
  PROCEDURE INSERT_ADMINISTRATIVE_LEAVE
            ( P_ADMINISTRATIVE_LEAVE_ID OUT HRM_ADMINISTRATIVE_LEAVE.ADMINISTRATIVE_LEAVE_ID%TYPE
            , P_PERSON_ID               IN  HRM_ADMINISTRATIVE_LEAVE.PERSON_ID%TYPE
            , P_SOB_ID                  IN  HRM_ADMINISTRATIVE_LEAVE.SOB_ID%TYPE
            , P_ORG_ID                  IN  HRM_ADMINISTRATIVE_LEAVE.ORG_ID%TYPE
            , P_START_DATE              IN  HRM_ADMINISTRATIVE_LEAVE.START_DATE%TYPE
            , P_END_DATE                IN  HRM_ADMINISTRATIVE_LEAVE.END_DATE%TYPE
            , P_REMARK                  IN  HRM_ADMINISTRATIVE_LEAVE.REMARK%TYPE
            , P_DESCRIPTION             IN  HRM_ADMINISTRATIVE_LEAVE.DESCRIPTION%TYPE
            , P_USER_ID                 IN  HRM_ADMINISTRATIVE_LEAVE.CREATED_BY%TYPE
            );

-- 휴직자 UDPATE.
  PROCEDURE UPDATE_ADMINISTRATIVE_LEAVE
            ( W_ADMINISTRATIVE_LEAVE_ID IN HRM_ADMINISTRATIVE_LEAVE.ADMINISTRATIVE_LEAVE_ID%TYPE
            , P_PERSON_ID               IN HRM_ADMINISTRATIVE_LEAVE.PERSON_ID%TYPE
            , P_SOB_ID                  IN HRM_ADMINISTRATIVE_LEAVE.SOB_ID%TYPE
            , P_ORG_ID                  IN HRM_ADMINISTRATIVE_LEAVE.ORG_ID%TYPE
            , P_START_DATE              IN HRM_ADMINISTRATIVE_LEAVE.START_DATE%TYPE
            , P_END_DATE                IN HRM_ADMINISTRATIVE_LEAVE.END_DATE%TYPE
            , P_REMARK                  IN HRM_ADMINISTRATIVE_LEAVE.REMARK%TYPE
            , P_DESCRIPTION             IN HRM_ADMINISTRATIVE_LEAVE.DESCRIPTION%TYPE
            , P_USER_ID                 IN HRM_ADMINISTRATIVE_LEAVE.CREATED_BY%TYPE 
            );

-- 휴직자 DELETE.
  PROCEDURE DELETE_ADMINISTRATIVE_LEAVE
            ( W_ADMINISTRATIVE_LEAVE_ID IN HRM_ADMINISTRATIVE_LEAVE.ADMINISTRATIVE_LEAVE_ID%TYPE
            , P_SOB_ID                  IN HRM_ADMINISTRATIVE_LEAVE.SOB_ID%TYPE
            , P_ORG_ID                  IN HRM_ADMINISTRATIVE_LEAVE.ORG_ID%TYPE
            , P_USER_ID                 IN HRM_ADMINISTRATIVE_LEAVE.CREATED_BY%TYPE 
            );


-- 기간별 휴직자 조회.
  PROCEDURE SELECT_ADMINI_LEAVE_PERIOD
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN  NUMBER
            , W_STAT_DATE         IN  DATE
            , W_END_DATE          IN  DATE
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_PERSON_ID         IN  NUMBER
            , W_EMPLOYE_YN        IN  VARCHAR2
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );

-- 해당 직원 :  휴직자 여부 체크.
  FUNCTION CHECK_ADMINISTRATIVE_LEAVE_F
            ( W_STD_DATE          IN  DATE
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            ) RETURN VARCHAR2;
                        
END HRM_ADMINISTRATIVE_LEAVE_G;
/
CREATE OR REPLACE PACKAGE BODY HRM_ADMINISTRATIVE_LEAVE_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_ADMINISTRATIVE_LEAVE_G
/* Description  : 휴직자 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 휴직자 조회.
  PROCEDURE SELECT_ADMINISTRATIVE_LEAVE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN  NUMBER
            , W_STD_DATE          IN  DATE
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_PERSON_ID         IN  NUMBER
            , W_ALL_YN            IN  VARCHAR2
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
    V_STD_DATE                DATE;
  BEGIN
    IF W_ALL_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    ELSE
      V_STD_DATE := W_STD_DATE;
    END IF;
    OPEN P_CURSOR FOR
      SELECT AL.ADMINISTRATIVE_LEAVE_ID
           , AL.PERSON_ID
           , PM.NAME
           , PM.PERSON_NUM
           , AL.START_DATE
           , AL.END_DATE
           , AL.REMARK
           , AL.DESCRIPTION
           , DM.DEPT_NAME
           , HF.FLOOR_NAME
           , PC.POST_NAME
           , JC.JOB_CATEGORY_NAME
           , PM.JOIN_DATE
           , PM.RETIRE_DATE
        FROM HRM_ADMINISTRATIVE_LEAVE AL
           , HRM_PERSON_MASTER        PM
           , (-- 시점 인사내역.
              SELECT HL.PERSON_ID
                  , HL.DEPT_ID
                  , HL.POST_ID
                  , HL.JOB_CATEGORY_ID
                  , HL.FLOOR_ID    
              FROM HRM_HISTORY_LINE HL
              WHERE ((W_DEPT_ID         IS NULL AND 1 = 1)
                OR   (W_DEPT_ID         IS NOT NULL AND HL.DEPT_ID = W_DEPT_ID))
                AND ((W_FLOOR_ID        IS NULL AND 1 = 1)
                OR   (W_FLOOR_ID        IS NOT NULL AND HL.FLOOR_ID = W_FLOOR_ID))
                AND ((W_JOB_CATEGORY_ID IS NULL AND 1 = 1)
                OR   (W_JOB_CATEGORY_ID IS NOT NULL AND HL.JOB_CATEGORY_ID = W_JOB_CATEGORY_ID))
                AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                              FROM HRM_HISTORY_LINE S_HL
                                             WHERE S_HL.CHARGE_DATE     <= V_STD_DATE
                                               AND S_HL.PERSON_ID       = HL.PERSON_ID
                                             GROUP BY S_HL.PERSON_ID
                                           )
            ) T1 
          , HRM_DEPT_MASTER         DM
          , HRM_FLOOR_V             HF
          , HRM_POST_CODE_V         PC
          , HRM_JOB_CATEGORY_CODE_V JC
      WHERE AL.PERSON_ID          = PM.PERSON_ID
        AND AL.PERSON_ID          = T1.PERSON_ID
        AND T1.DEPT_ID            = DM.DEPT_ID(+)
        AND T1.FLOOR_ID           = HF.FLOOR_ID(+)
        AND T1.POST_ID            = PC.POST_ID(+)
        AND T1.JOB_CATEGORY_ID    = JC.JOB_CATEGORY_ID(+)
        AND PM.CORP_ID            = W_CORP_ID
        AND PM.PERSON_ID          = NVL(W_PERSON_ID, PM.PERSON_ID)
        AND PM.SOB_ID             = W_SOB_ID
        AND PM.ORG_ID             = W_ORG_ID
        AND AL.PERSON_ID          = NVL(W_PERSON_ID, AL.PERSON_ID)
        AND AL.SOB_ID             = W_SOB_ID
        AND AL.ORG_ID             = W_ORG_ID
        AND ((W_ALL_YN            = 'Y' AND 1 = 1)
        OR   (W_ALL_YN            != 'Y' 
        AND   AL.START_DATE       <= W_STD_DATE
        AND   (AL.END_DATE        >= W_STD_DATE OR AL.END_DATE IS NULL)))
      ORDER BY AL.START_DATE
      ;
  END SELECT_ADMINISTRATIVE_LEAVE;

-- 휴직자 INSERT.
  PROCEDURE INSERT_ADMINISTRATIVE_LEAVE
            ( P_ADMINISTRATIVE_LEAVE_ID OUT HRM_ADMINISTRATIVE_LEAVE.ADMINISTRATIVE_LEAVE_ID%TYPE
            , P_PERSON_ID               IN  HRM_ADMINISTRATIVE_LEAVE.PERSON_ID%TYPE
            , P_SOB_ID                  IN  HRM_ADMINISTRATIVE_LEAVE.SOB_ID%TYPE
            , P_ORG_ID                  IN  HRM_ADMINISTRATIVE_LEAVE.ORG_ID%TYPE
            , P_START_DATE              IN  HRM_ADMINISTRATIVE_LEAVE.START_DATE%TYPE
            , P_END_DATE                IN  HRM_ADMINISTRATIVE_LEAVE.END_DATE%TYPE
            , P_REMARK                  IN  HRM_ADMINISTRATIVE_LEAVE.REMARK%TYPE
            , P_DESCRIPTION             IN  HRM_ADMINISTRATIVE_LEAVE.DESCRIPTION%TYPE
            , P_USER_ID                 IN  HRM_ADMINISTRATIVE_LEAVE.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    SELECT HRM_ADMINISTRATIVE_LEAVE_S1.NEXTVAL
      INTO P_ADMINISTRATIVE_LEAVE_ID
      FROM DUAL;
      
    INSERT INTO HRM_ADMINISTRATIVE_LEAVE
    ( ADMINISTRATIVE_LEAVE_ID
    , PERSON_ID
    , SOB_ID 
    , ORG_ID 
    , START_DATE 
    , END_DATE 
    , REMARK 
    , DESCRIPTION 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY 
    ) VALUES
    ( P_ADMINISTRATIVE_LEAVE_ID
    , P_PERSON_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_START_DATE
    , P_END_DATE
    , P_REMARK
    , P_DESCRIPTION
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID 
    );
  END INSERT_ADMINISTRATIVE_LEAVE;

-- 휴직자 UDPATE.
  PROCEDURE UPDATE_ADMINISTRATIVE_LEAVE
            ( W_ADMINISTRATIVE_LEAVE_ID IN HRM_ADMINISTRATIVE_LEAVE.ADMINISTRATIVE_LEAVE_ID%TYPE
            , P_PERSON_ID               IN HRM_ADMINISTRATIVE_LEAVE.PERSON_ID%TYPE
            , P_SOB_ID                  IN HRM_ADMINISTRATIVE_LEAVE.SOB_ID%TYPE
            , P_ORG_ID                  IN HRM_ADMINISTRATIVE_LEAVE.ORG_ID%TYPE
            , P_START_DATE              IN HRM_ADMINISTRATIVE_LEAVE.START_DATE%TYPE
            , P_END_DATE                IN HRM_ADMINISTRATIVE_LEAVE.END_DATE%TYPE
            , P_REMARK                  IN HRM_ADMINISTRATIVE_LEAVE.REMARK%TYPE
            , P_DESCRIPTION             IN HRM_ADMINISTRATIVE_LEAVE.DESCRIPTION%TYPE
            , P_USER_ID                 IN HRM_ADMINISTRATIVE_LEAVE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN

    UPDATE HRM_ADMINISTRATIVE_LEAVE
      SET START_DATE              = P_START_DATE
        , END_DATE                = P_END_DATE
        , REMARK                  = P_REMARK
        , DESCRIPTION             = P_DESCRIPTION
        , LAST_UPDATE_DATE        = V_SYSDATE
        , LAST_UPDATED_BY         = P_USER_ID
    WHERE ADMINISTRATIVE_LEAVE_ID = W_ADMINISTRATIVE_LEAVE_ID;
  END UPDATE_ADMINISTRATIVE_LEAVE;

-- 휴직자 DELETE.
  PROCEDURE DELETE_ADMINISTRATIVE_LEAVE
            ( W_ADMINISTRATIVE_LEAVE_ID IN HRM_ADMINISTRATIVE_LEAVE.ADMINISTRATIVE_LEAVE_ID%TYPE
            , P_SOB_ID                  IN HRM_ADMINISTRATIVE_LEAVE.SOB_ID%TYPE
            , P_ORG_ID                  IN HRM_ADMINISTRATIVE_LEAVE.ORG_ID%TYPE
            , P_USER_ID                 IN HRM_ADMINISTRATIVE_LEAVE.CREATED_BY%TYPE 
            )
  AS
  BEGIN
    DELETE HRM_ADMINISTRATIVE_LEAVE
    WHERE ADMINISTRATIVE_LEAVE_ID = W_ADMINISTRATIVE_LEAVE_ID;
  END DELETE_ADMINISTRATIVE_LEAVE;


-- 기간별 휴직자 조회.
  PROCEDURE SELECT_ADMINI_LEAVE_PERIOD
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN  NUMBER
            , W_STAT_DATE         IN  DATE
            , W_END_DATE          IN  DATE
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_PERSON_ID         IN  NUMBER
            , W_EMPLOYE_YN        IN  VARCHAR2
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT  HAL.ADMINISTRATIVE_LEAVE_ID
           , HAL.PERSON_ID
           , HPM.PERSON_NUM
           , HPM.NAME
           , HAL.START_DATE
           , HAL.END_DATE
           , HAL.REMARK
           , HAL.DESCRIPTION
           , T1.DEPT_NAME
           , T1.FLOOR_NAME
           , T1.POST_NAME
           , T1.JOB_CATEGORY_NAME
           , HPM.JOIN_DATE
           , HPM.RETIRE_DATE
       FROM  HRM_PERSON_MASTER HPM
            ,HRM_ADMINISTRATIVE_LEAVE HAL
            ,(-- 시점 인사내역.
               SELECT HL.PERSON_ID
                    , HL.DEPT_ID
                    , HL.POST_ID
                    , HL.PAY_GRADE_ID
                    , HL.JOB_CATEGORY_ID
                    , HL.FLOOR_ID
                    , HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
                    , HRM_COMMON_G.ID_NAME_F(HL.FLOOR_ID) AS FLOOR_NAME
                    , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
                    , HRM_COMMON_G.ID_NAME_F(HL.PAY_GRADE_ID) AS PAY_GRADE_NAME  
                    , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                 FROM HRM_HISTORY_LINE HL  
                 WHERE ((W_DEPT_ID         IS NULL AND 1 = 1)
                   OR   (W_DEPT_ID         IS NOT NULL AND HL.DEPT_ID = W_DEPT_ID))
                   AND ((W_FLOOR_ID        IS NULL AND 1 = 1)
                   OR   (W_FLOOR_ID        IS NOT NULL AND HL.FLOOR_ID = W_FLOOR_ID))
                   AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                  FROM HRM_HISTORY_LINE S_HL
                                                 WHERE S_HL.CHARGE_DATE             <= W_END_DATE
                                                   AND S_HL.PERSON_ID              = HL.PERSON_ID
                                                 GROUP BY S_HL.PERSON_ID
                                               )
              ) T1
      WHERE HPM.PERSON_ID       = T1.PERSON_ID 
        AND HPM.CORP_ID         = W_CORP_ID
        AND HPM.PERSON_ID       = HAL.PERSON_ID
        AND HPM.SOB_ID          = W_SOB_ID
        AND HPM.ORG_ID          = W_ORG_ID
        AND HAL.PERSON_ID       = NVL(W_PERSON_ID, HAL.PERSON_ID)
        AND HAL.END_DATE        >= W_STAT_DATE
        AND HAL.START_DATE      <= W_END_DATE
        AND HPM.JOB_CATEGORY_ID  = NVL(W_JOB_CATEGORY_ID, HPM.JOB_CATEGORY_ID) 
        AND HPM.EMPLOYE_TYPE     = DECODE(W_EMPLOYE_YN,'Y','1',HPM.EMPLOYE_TYPE)
      ORDER BY HAL.START_DATE, HAL.ADMINISTRATIVE_LEAVE_ID
      ;
  END SELECT_ADMINI_LEAVE_PERIOD;

-- 해당 직원 :  휴직자 여부 체크.
  FUNCTION CHECK_ADMINISTRATIVE_LEAVE_F
            ( W_STD_DATE          IN  DATE
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            ) RETURN VARCHAR2
  AS
    V_EMPLOYEE_TYPE     VARCHAR2(3) := '1';
  BEGIN
    BEGIN
      SELECT '2' 
        INTO V_EMPLOYEE_TYPE
        FROM HRM_ADMINISTRATIVE_LEAVE AL
       WHERE AL.PERSON_ID         = W_PERSON_ID
         AND AL.START_DATE        <= W_STD_DATE
         AND (AL.END_DATE         >= W_STD_DATE OR AL.END_DATE IS NULL)
         AND ROWNUM               <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_EMPLOYEE_TYPE := '1';
    END;
    RETURN V_EMPLOYEE_TYPE;
  END CHECK_ADMINISTRATIVE_LEAVE_F;
  
END HRM_ADMINISTRATIVE_LEAVE_G;
/
