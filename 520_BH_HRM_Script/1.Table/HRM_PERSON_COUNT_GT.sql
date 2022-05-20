/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : 인원현황
/* Description  : 해당 기간에 대해 일자를 생성
/*
/* Reference by : TEMPORARY TABLE을 이용하여 처리.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/

--> INDEX 삭제 및 생성 <--
/*
CREATE INDEX IFC_HD_DAY_INTERFACE_GT_U1 ON IFC_HD_DAY_INTERFACE_GT(WORK_DATE, PERSON_NUMB);
     
--> 권한 설정 <--
GRANT ALL ON IFC_HD_DAY_INTERFACE_GT TO APPS WITH GRANT OPTION;


--> SYNONYM 생성
ACCEPT APPS_PWD PROMPT 'Please Enter Apps Password ==> ' HIDE
CONNECT APPS/&APPS_PWD;

DROP SYNONYM IFC_HD_DAY_INTERFACE_GT;

CREATE SYNONYM IFC_HD_DAY_INTERFACE_GT FOR IFC_HD_DAY_INTERFACE_GT;

*/
-------------------------------------------------------------------------------
CREATE GLOBAL TEMPORARY TABLE HRM_PERSON_COUNT_GT
  ( DEPT_ID                       NUMBER
  , WORK_CENTER_ID                NUMBER
  , SOB_ID                        NUMBER
  , ORG_ID                        NUMBER
  , START_DATE                    DATE  
  , END_DATE                      DATE  
  , WEEK_CODE                     NUMBER
  , VARCHAR_1                     VARCHAR2(150)
  , VARCHAR_2                     VARCHAR2(150)
  , VARCHAR_3                     VARCHAR2(150)
  , VARCHAR_4                     VARCHAR2(150)
  , VARCHAR_5                     VARCHAR2(150)
  , VARCHAR_6                     VARCHAR2(150)
  , VARCHAR_7                     VARCHAR2(150)
  , VARCHAR_8                     VARCHAR2(150)
  , VARCHAR_9                     VARCHAR2(150)
  , VARCHAR_10                    VARCHAR2(150)
  , NUM_1                         NUMBER
  , NUM_2                         NUMBER
  , NUM_3                         NUMBER
  , NUM_4                         NUMBER
  , NUM_5                         NUMBER
  , NUM_6                         NUMBER
  , NUM_7                         NUMBER
  , NUM_8                         NUMBER
  , NUM_9                         NUMBER
  , NUM_10                        NUMBER
  ) ON COMMIT PRESERVE ROWS;    
  -- ON COMMIT DELETE ROWS (COMMIT이 발생할 경우 바로 삭제);
  -- ON COMMIT PRESERVE ROWS (SESSION이 종료될때 삭제);

