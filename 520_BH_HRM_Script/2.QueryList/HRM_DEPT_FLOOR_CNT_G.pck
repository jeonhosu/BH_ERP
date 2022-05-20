CREATE OR REPLACE PACKAGE HRM_DEPT_FLOOR_CNT_G IS

 ---------------------------------
 --  부서 및 직종별  인원 현황  --
 ---------------------------------
 PROCEDURE SELECT_DEPT_PERSON_CNT  
         ( P_CURSOR                   OUT  TYPES.TCURSOR
         , W_CORP_ID                  IN NUMBER
         , W_STD_DATE                 IN DATE
         , W_SOB_ID                   IN NUMBER
      	 , W_ORG_ID                   IN NUMBER
         );

END HRM_DEPT_FLOOR_CNT_G;
/
CREATE OR REPLACE PACKAGE BODY HRM_DEPT_FLOOR_CNT_G IS

/******************************************************************************/
/* PROJECT      : FLEX ERP
/* MODULE       : HR
/* PROGRAM NAME : HRM_DEPT_PERSON_COUNT_G
/* DESCRIPTION  : 부서별 인원 현황
/*
/* REFERENCE BY :
/* PROGRAM HISTORY
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 04-MAY-2011  LEE SUN HEE       INITIALIZE
/******************************************************************************/

  PROCEDURE SELECT_DEPT_PERSON_CNT  
           ( P_CURSOR                   OUT  TYPES.TCURSOR
           , W_CORP_ID                  IN NUMBER
           , W_STD_DATE                 IN DATE
           , W_SOB_ID                   IN NUMBER
           , W_ORG_ID                   IN NUMBER
           )
  AS
  BEGIN
     OPEN P_CURSOR FOR
        SELECT CASE
                 WHEN GROUPING(DM.DEPT_CODE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL)
                 ELSE DM.DEPT_NAME
               END AS DEPT_NAME
             , HF.FLOOR_NAME
             , SUM(DECODE(JC.JOB_CATEGORY_CODE, '10', DECODE(PM.SEX_TYPE, 1, 1, 0), 0)) AS JOB_CATE_10_1
             , SUM(DECODE(JC.JOB_CATEGORY_CODE, '10', DECODE(PM.SEX_TYPE, 2, 1, 0), 0)) AS JOB_CATE_10_2
             , SUM(DECODE(JC.JOB_CATEGORY_CODE, '10', 0, DECODE(PM.SEX_TYPE, 1, 1, 0))) AS JOB_CATE_20_1
             , SUM(DECODE(JC.JOB_CATEGORY_CODE, '10', 0, DECODE(PM.SEX_TYPE, 2, 1, 0))) AS JOB_CATE_20_2
             , SUM(DECODE(PM.SEX_TYPE, 1, 1, 0)) AS PERSON_SEX_1
             , SUM(DECODE(PM.SEX_TYPE, 2, 1, 0)) AS PERSON_SEX_2
             , COUNT(PM.PERSON_ID) AS PERSON_COUNT
          FROM HRM_PERSON_MASTER PM
            , HRM_DEPT_MASTER DM
            , HRM_FLOOR_V HF
            , HRM_JOB_CATEGORY_CODE_V JC
        WHERE PM.DEPT_ID                  = DM.DEPT_ID
          AND PM.FLOOR_ID                 = HF.FLOOR_ID(+)
          AND PM.JOB_CATEGORY_ID          = JC.JOB_CATEGORY_ID(+)
          AND PM.CORP_ID                  = W_CORP_ID
          AND PM.SOB_ID                   = W_SOB_ID
          AND PM.ORG_ID                   = W_ORG_ID
          AND PM.ORI_JOIN_DATE            <= W_STD_DATE
          AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_STD_DATE)
        GROUP BY ROLLUP ((DM.DEPT_CODE
                        , DM.DEPT_NAME
                        , HF.FLOOR_NAME))
                        ;
     END SELECT_DEPT_PERSON_CNT;
END HRM_DEPT_FLOOR_CNT_G;
/
