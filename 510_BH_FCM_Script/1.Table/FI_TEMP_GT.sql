/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : 회계 임시테이블
/* Description  : 
/*
/* Reference by : TEMPORARY TABLE을 이용하여 처리.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE GLOBAL TEMPORARY TABLE FI_TEMP_GT
  ( TEMP_FLAG                         VARCHAR2(20)
  , VARCHAR_1                         VARCHAR2(100)
  , VARCHAR_2                         VARCHAR2(100)
  , VARCHAR_3                         VARCHAR2(100)
  , VARCHAR_4                         VARCHAR2(100)
  , VARCHAR_5                         VARCHAR2(100)
  , VARCHAR_6                         VARCHAR2(100)
  , VARCHAR_7                         VARCHAR2(100)
  , VARCHAR_8                         VARCHAR2(100)
  , VARCHAR_9                         VARCHAR2(100)
  , VARCHAR_10                        VARCHAR2(100)
  , VARCHAR_11                        VARCHAR2(100)
  , VARCHAR_12                        VARCHAR2(100)
  , VARCHAR_13                        VARCHAR2(100)
  , VARCHAR_14                        VARCHAR2(100)
  , VARCHAR_15                        VARCHAR2(100)
  , VARCHAR_16                        VARCHAR2(100)
  , VARCHAR_17                        VARCHAR2(100)
  , VARCHAR_18                        VARCHAR2(100)
  , VARCHAR_19                        VARCHAR2(100)
  , VARCHAR_20                        VARCHAR2(100)
  , NUM_1                             NUMBER
  , NUM_2                             NUMBER
  , NUM_3                             NUMBER
  , NUM_4                             NUMBER
  , NUM_5                             NUMBER
  , NUM_6                             NUMBER
  , NUM_7                             NUMBER
  , NUM_8                             NUMBER
  , NUM_9                             NUMBER
  , NUM_10                            NUMBER
  , SOB_ID                            NUMBER
  , ORG_ID                            NUMBER
  ) ON COMMIT PRESERVE ROWS;    

