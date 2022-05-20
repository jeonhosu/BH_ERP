/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : EAPP
/* Program Name : 기초금액 산출 저장 임시 테이블.
/* Description  : 
/*
/* Reference by : TEMPORARY TABLE을 이용하여 처리.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE GLOBAL TEMPORARY TABLE EAPP_SESSION_INFO
( SESSION_ID                  NUMBER              ,
  USER_ID                     NUMBER              ,
  FORM_ID                     VARCHAR2(100)       ,
  ATTRIBUTE_A                 VARCHAR2(100)       ,
  ATTRIBUTE_B                 VARCHAR2(100)       ,
  ATTRIBUTE_C                 VARCHAR2(100)       ,
  ATTRIBUTE_D                 VARCHAR2(100)       ,
  ATTRIBUTE_F                 VARCHAR2(100)       ,
  ATTRIBUTE_1                 NUMBER              ,
  ATTRIBUTE_2                 NUMBER              ,
  ATTRIBUTE_3                 NUMBER              ,
  ATTRIBUTE_4                 NUMBER              ,
  ATTRIBUTE_5                 NUMBER              
) ON COMMIT PRESERVE ROWS ;

CREATE INDEX EAPP_SESSION_INFO_N1 ON EAPP_SESSION_INFO(SESSION_ID);
