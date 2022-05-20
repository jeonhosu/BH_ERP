CREATE OR REPLACE PACKAGE HRD_DAY_INTERFACE_PRINT_G
AS 

-------------------------------------------------------------------------------------------------------------
---- SELECT_DAY_INTERFACE_PRINT
-------------------------------------------------------------------------------------------------------------
  PROCEDURE SELECT_DAY_INTERFACE_PRINT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_WORK_DATE                         IN DATE
            , W_JOB_CATEGORY_ID                   IN HRM_COMMON.COMMON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            );       
            
-------------------------------------------------------------------------------------------------------------
---- UPDATE_DAY_INTERFACE_PRINT
-------------------------------------------------------------------------------------------------------------
  PROCEDURE UPDATE_DAY_INTERFACE_PRINT
            ( W_PERSON_ID              IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
            , W_WORK_DATE              IN HRD_DAY_INTERFACE.WORK_DATE%TYPE                                           
            , W_CORP_ID                IN HRD_DAY_INTERFACE.CORP_ID%TYPE                                           
            , W_SOB_ID                 IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                 IN HRD_DAY_INTERFACE.ORG_ID%TYPE                                           
            , P_T_DUTY_ID              IN HRD_DAY_INTERFACE.T_DUTY_ID%TYPE
            , P_T_DUTY_DESC            IN HRD_DAY_INTERFACE.T_DUTY_DESC%TYPE
            );    
                                            
END HRD_DAY_INTERFACE_PRINT_G;
/
CREATE OR REPLACE PACKAGE BODY HRD_DAY_INTERFACE_PRINT_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : HRD
/* PROGRAM NAME : HRD_DAY_INTERFACE_PRINT_G
/* DESCRIPTION  : 일일 근태 내역 인쇄 패키지.

/* REFERENCE BY : 일일 근태 내역 인쇄.
/* PROGRAM HISTORY : 
/*------------------------------------------------------------------------------
/*     DATE         IN CHARGE        DESCRIPTION
/*------------------------------------------------------------------------------
/* 2011-10-12      LEE SUN HEE       INITIALIZE
/******************************************************************************/

-------------------------------------------------------------------------------------------------------------
---- SELECT_DAY_INTERFACE_PRINT
-------------------------------------------------------------------------------------------------------------
  PROCEDURE SELECT_DAY_INTERFACE_PRINT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_WORK_DATE                         IN DATE
            , W_JOB_CATEGORY_ID                   IN HRM_COMMON.COMMON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            )
  AS
    V_CONNECT_PERSON_ID   NUMBER := NULL;
   BEGIN
     BEGIN
       SELECT EU.PERSON_ID
         INTO V_CONNECT_PERSON_ID 
         FROM EAPP_USER EU
        WHERE EU.USER_ID  = GET_USER_ID_F
        ;
     EXCEPTION
       WHEN OTHERS THEN
         V_CONNECT_PERSON_ID := -1;
     END;
     
     IF V_CONNECT_PERSON_ID IS NULL OR V_CONNECT_PERSON_ID = -1 THEN
       V_CONNECT_PERSON_ID := -1;
     ELSE
        -- 근태권한 설정.
        IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     =>  W_CORP_ID
                                  , W_START_DATE   =>  TRUNC(W_WORK_DATE)
                                  , W_END_DATE     =>  TRUNC(W_WORK_DATE)
                                  , W_MODULE_CODE  =>  '20'
                                  , W_PERSON_ID    =>  V_CONNECT_PERSON_ID
                                  , W_SOB_ID       =>  W_SOB_ID
                                  , W_ORG_ID       =>  W_ORG_ID) = 'C' THEN
           V_CONNECT_PERSON_ID := NULL;
        ELSE
           NULL;
        END IF;
      END IF;
              
      OPEN P_CURSOR   FOR
        SELECT DI.WORK_CORP_ID CORP_ID                                -- 회사ID
              , DI.WORK_DATE                                      -- 근무일
              , T1.DEPT_2ND_CODE                                  -- 본부코드.
              , T1.DEPT_2ND_DESC                                  -- 본부명.
              , T1.DEPT_DESC AS DEPT_NAME                         -- 부서명
              , T1.FLOOR_CODE                                     -- 작업장코드.
              , T1.FLOOR_NAME AS FLOOR_NAME                       -- 작업장명
              , T1.POST_NAME AS POST_NAME                         -- 직위
              , DI.PERSON_ID                                      -- 직원ID
              , PM.NAME                                           -- 성명
              , T1.JOB_CATEGORY_ID                                -- 직구분ID
              , T1.JOB_CATEGORY_NAME                              -- 직구분
              , NVL(DI.T_DUTY_ID, DI.DUTY_ID) AS DUTY_ID          -- 근태ID
              , HRM_COMMON_G.ID_NAME_F(NVL(DI.T_DUTY_ID, DI.DUTY_ID)) AS DUTY_NAME   -- 근태
              , NVL(DI.T_DUTY_DESC, T2.DESCRIPTION) AS DESCRIPTION                     -- 비고
              , DI.HOLY_TYPE                                      -- 근무ID
              , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME --근무
              , CASE
                  WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
                  ELSE DI.OPEN_TIME
                END AS OPEN_TIME                                      -- 출근시간
              , CASE
                  WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, N_DI.CLOSE_TIME)
                  WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                  ELSE DI.CLOSE_TIME
                END AS CLOSE_TIME                                      -- 퇴근시간
              , CASE
                  WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
                  ELSE DI.OPEN_TIME1
                END AS OPEN_TIME1                                      -- 중출
              , CASE
                  WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                  ELSE DI.CLOSE_TIME1
                END AS CLOSE_TIME1                                      -- 중퇴
              , DI.NEXT_DAY_YN                                          -- 후일
              , DI.DANGJIK_YN                                           -- 당직
              , DI.ALL_NIGHT_YN                                         -- 철야
              , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_ID, NULL)) AS I_MODIFY_DESC  -- 출근 수정
              , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_ID, NULL)) AS O_MODIFY_DESC -- 퇴근 수정
              , TO_CHAR(CASE
                          WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
                          ELSE DI.OPEN_TIME
                        END, 'HH24:MI') AS IN_TIME                                      -- 출근시간
              , TO_CHAR(NVL(CASE
                              WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                              ELSE DI.CLOSE_TIME1
                            END
                          , CASE
                              WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, N_DI.CLOSE_TIME)
                              WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                              ELSE DI.CLOSE_TIME
                            END), 'HH24:MI') AS OUT_TIME                                      -- 퇴근시간
              , CASE
                  WHEN DI.PLAN_OPEN_TIME <
                       CASE
                         WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
                         ELSE DI.OPEN_TIME
                       END THEN '지각'
                  WHEN S_WC.DANGJIK_YN = 'Y' THEN NULL
                  WHEN DI.PLAN_CLOSE_TIME >
                       NVL( CASE
                              WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                              ELSE DI.CLOSE_TIME1
                            END
                          , CASE
                              WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, N_DI.CLOSE_TIME)
                              WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                              ELSE DI.CLOSE_TIME
                            END) THEN '조퇴'
                  ELSE NULL
                END AS LATE_DESC                                      -- 지각/조퇴 표시. 
        FROM  HRD_DAY_INTERFACE_V DI
            , HRM_PERSON_MASTER PM
            , (-- 시점 인사내역.
              SELECT HL.PERSON_ID
                  , HL.DEPT_ID
                  , DM.DEPT_2ND_CODE
                  , DM.DEPT_2ND_DESC
                  , DM.DEPT_CODE
                  , DM.DEPT_DESC
                  , DM.DEPT_SORT_NUM
                  , HL.POST_ID
                  , PC.POST_CODE
                  , PC.POST_NAME
                  , PC.SORT_NUM AS PC_SORT_NUM
                  , HL.JOB_CATEGORY_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                  , HL.FLOOR_ID 
                  , HF.FLOOR_CODE
                  , HF.FLOOR_NAME   
                  , HF.SORT_NUM AS HF_SORT_NUM
              FROM HRM_HISTORY_LINE HL  
                , HRM_DEPT_MASTER_V DM
                , HRM_FLOOR_V HF
                , HRM_POST_CODE_V PC
              WHERE HL.DEPT_ID          = DM.DEPT_ID
                AND HL.FLOOR_ID         = HF.FLOOR_ID
                AND HL.POST_ID          = PC.POST_ID
                AND HL.HISTORY_LINE_ID  
                      IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                            FROM HRM_HISTORY_LINE S_HL
                           WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
                             AND S_HL.PERSON_ID              = HL.PERSON_ID
                           GROUP BY S_HL.PERSON_ID
                         )
            ) T1 
          , HRD_DAY_MODIFY I_DM
          , HRD_DAY_MODIFY O_DM
          , (-- 전일 근무 정보 조회. 
              SELECT WC.WORK_DATE + 1 AS WORK_DATE
                   , WC.PERSON_ID
                   , WC.CORP_ID
                   , WC.SOB_ID
                   , WC.ORG_ID
                   , WC.HOLY_TYPE
                   , WC.DANGJIK_YN
                   , WC.ALL_NIGHT_YN
              FROM HRD_WORK_CALENDAR WC
              WHERE WC.WORK_DATE      = W_WORK_DATE - 1
                AND WC.WORK_CORP_ID   = W_CORP_ID
                AND WC.SOB_ID         = W_SOB_ID
                AND WC.ORG_ID         = W_ORG_ID
            ) S_WC
          , (-- 후일 근무 정보 조회. 
              SELECT DIT.WORK_DATE - 1 AS WORK_DATE
                   , DIT.PERSON_ID
                   , DIT.CORP_ID
                   , DIT.SOB_ID
                   , DIT.ORG_ID
                   , DIT.OPEN_TIME
                   , DIT.CLOSE_TIME
                   , DIT.OPEN_TIME1
                   , DIT.CLOSE_TIME1
              FROM HRD_DAY_INTERFACE DIT
              WHERE DIT.WORK_DATE     = W_WORK_DATE + 1
                AND DIT.WORK_CORP_ID  = W_CORP_ID
                AND DIT.SOB_ID        = W_SOB_ID
                AND DIT.ORG_ID        = W_ORG_ID
            ) N_DI 
          , ( SELECT DP.PERSON_ID
                   , W_WORK_DATE AS WORK_DATE
                   , DP.SOB_ID
                   , DP.ORG_ID
                   , DP.DESCRIPTION
                FROM HRD_DUTY_PERIOD DP
              WHERE W_WORK_DATE           BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                AND DP.CORP_ID            = W_CORP_ID
                AND DP.SOB_ID             = W_SOB_ID
                AND DP.ORG_ID             = W_ORG_ID
                AND DP.APPROVE_STATUS     = 'C'  -- 승인된 근태계.
             ) T2     
        WHERE DI.PERSON_ID                          = PM.PERSON_ID
          AND DI.WORK_CORP_ID                       = PM.WORK_CORP_ID
          AND DI.SOB_ID                             = PM.SOB_ID
          AND DI.ORG_ID                             = PM.ORG_ID        
          AND DI.PERSON_ID                          = I_DM.PERSON_ID(+)
          AND DI.WORK_DATE                          = I_DM.WORK_DATE(+)
          AND '1'                                   = I_DM.IO_FLAG(+)
          AND DI.PERSON_ID                          = O_DM.PERSON_ID(+)
          AND CASE
                WHEN DI.HOLY_TYPE = '3' THEN DI.WORK_DATE + 1
                WHEN DI.DANGJIK_YN = 'Y' THEN DI.WORK_DATE + 1
                WHEN DI.ALL_NIGHT_YN = 'Y' THEN DI.WORK_DATE + 1
                WHEN DI.NEXT_DAY_YN = 'Y' THEN DI.WORK_DATE + 1
                ELSE DI.WORK_DATE
              END                                   = O_DM.WORK_DATE(+)
          AND '2'                                   = O_DM.IO_FLAG(+)
          AND DI.WORK_DATE                          = S_WC.WORK_DATE(+)
          AND DI.PERSON_ID                          = S_WC.PERSON_ID(+)
          AND DI.SOB_ID                             = S_WC.SOB_ID(+)
          AND DI.ORG_ID                             = S_WC.ORG_ID(+)
          AND DI.WORK_DATE                          = N_DI.WORK_DATE(+)
          AND DI.PERSON_ID                          = N_DI.PERSON_ID(+)
          AND DI.SOB_ID                             = N_DI.SOB_ID(+)
          AND DI.ORG_ID                             = N_DI.ORG_ID(+)
          AND PM.PERSON_ID                          = T1.PERSON_ID
          AND DI.PERSON_ID                          = T2.PERSON_ID(+)
          AND DI.WORK_DATE                          = T2.WORK_DATE(+)
          AND DI.SOB_ID                             = T2.SOB_ID(+)
          AND DI.ORG_ID                             = T2.ORG_ID(+)
          AND DI.WORK_DATE                          = W_WORK_DATE
          AND DI.WORK_CORP_ID                       = W_CORP_ID
          AND DI.SOB_ID                             = W_SOB_ID
          AND DI.ORG_ID                             = W_ORG_ID
          AND T1.JOB_CATEGORY_ID                    = NVL(W_JOB_CATEGORY_ID, T1.JOB_CATEGORY_ID)
          AND PM.JOIN_DATE                          <= W_WORK_DATE
          AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_WORK_DATE)
          AND NOT EXISTS
                ( SELECT 'X'
                    FROM HRD_DUTY_EXCEPTION DE
                  WHERE DE.PERSON_ID    = DI.PERSON_ID
                    AND DE.SOB_ID       = DI.SOB_ID
                    AND DE.ORG_ID       = DI.ORG_ID
                    AND DE.EFFECTIVE_DATE_FR  <= DI.WORK_DATE
                    AND (DE.EFFECTIVE_DATE_TO IS NULL OR DE.EFFECTIVE_DATE_TO >= DI.WORK_DATE)
                )
          AND EXISTS 
                ( SELECT 'X'
                    FROM HRD_DUTY_MANAGER DM
                  WHERE DM.CORP_ID                          = PM.WORK_CORP_ID
                   AND DM.DUTY_CONTROL_ID                   = NVL(T1.FLOOR_ID, PM.FLOOR_ID)
                   --AND DM.WORK_TYPE_ID                      = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)                       
                   AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                   AND DM.START_DATE                        <= W_WORK_DATE
                   AND (DM.END_DATE IS NULL OR DM.END_DATE  >= W_WORK_DATE)
                   AND DM.SOB_ID                            = PM.SOB_ID
                   AND DM.ORG_ID                            = PM.ORG_ID
                )
          ORDER BY T1.DEPT_SORT_NUM, T1.DEPT_2ND_CODE, T1.FLOOR_CODE, T1.PC_SORT_NUM, PM.WORK_TYPE_ID, PM.PERSON_NUM
          ;
   END SELECT_DAY_INTERFACE_PRINT;
   
-------------------------------------------------------------------------------------------------------------
---- UPDATE_DAY_INTERFACE_PRINT
-------------------------------------------------------------------------------------------------------------
  PROCEDURE UPDATE_DAY_INTERFACE_PRINT
            ( W_PERSON_ID              IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
            , W_WORK_DATE              IN HRD_DAY_INTERFACE.WORK_DATE%TYPE                                           
            , W_CORP_ID                IN HRD_DAY_INTERFACE.CORP_ID%TYPE                                           
            , W_SOB_ID                 IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                 IN HRD_DAY_INTERFACE.ORG_ID%TYPE                                           
            , P_T_DUTY_ID              IN HRD_DAY_INTERFACE.T_DUTY_ID%TYPE
            , P_T_DUTY_DESC            IN HRD_DAY_INTERFACE.T_DUTY_DESC%TYPE
            )
  IS
  BEGIN

   UPDATE HRD_DAY_INTERFACE
      SET T_DUTY_ID             = P_T_DUTY_ID
        , T_DUTY_DESC           = P_T_DUTY_DESC
    WHERE CORP_ID               = W_CORP_ID
      AND WORK_DATE             = W_WORK_DATE
      AND PERSON_ID             = W_PERSON_ID
      AND SOB_ID                = W_SOB_ID
      AND ORG_ID                = W_ORG_ID;
   
  /*EXCEPTION WHEN OTHERS THEN
   BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'Error Message');
   END;*/

  END UPDATE_DAY_INTERFACE_PRINT;    

END HRD_DAY_INTERFACE_PRINT_G;
/
