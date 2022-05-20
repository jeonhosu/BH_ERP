/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FI
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
CREATE GLOBAL TEMPORARY TABLE FI_BALANCE_OVER_GT
( GL_DATE                     DATE                ,
  PERIOD_NAME                 VARCHAR2(10)        ,
  ACCOUNT_CONTROL_ID          NUMBER              ,
  ACCOUNT_CODE                VARCHAR2(20)        ,
  ACCOUNT_DESC                VARCHAR2(200)       ,
  ACCOUNT_DR_CR               VARCHAR2(1)         ,
  CURRENCY_CODE               VARCHAR2(20)        ,
  EXCHANGE_RATE               NUMBER DEFAULT 0    ,
  CURRENCY_AMOUNT             NUMBER DEFAULT 0    ,
  DR_CURRENCY_AMOUNT          NUMBER DEFAULT 0    ,
  CR_CURRENCY_AMOUNT          NUMBER DEFAULT 0    ,
  REMAIN_CURR_AMOUNT          NUMBER DEFAULT 0    ,
  GL_AMOUNT                   NUMBER DEFAULT 0    ,
  DR_GL_AMOUNT                NUMBER DEFAULT 0    ,
  CR_GL_AMOUNT                NUMBER DEFAULT 0    ,
  REMAIN_AMOUNT               NUMBER DEFAULT 0    ,  
  REMARK                      VARCHAR2(200)       ,
  CUSTOMER_ID                 NUMBER              ,
  BANK_ACCOUNT_ID             NUMBER              ,
  SOURCE_HEADER_ID            NUMBER              ,
  SOURCE_LINE_ID              NUMBER              ,
  MANAGEMENT1	                VARCHAR2(50)	      , 
  MANAGEMENT2	                VARCHAR2(50)	      ,
  REFER1	                    VARCHAR2(50)	      ,
  REFER2	                    VARCHAR2(50)	      ,		
  REFER3	                    VARCHAR2(50)	      ,		
  REFER4	                    VARCHAR2(50)	      ,
  REFER5	                    VARCHAR2(50)	      ,
  REFER6	                    VARCHAR2(50)	      ,
  REFER7	                    VARCHAR2(50)	      ,
  REFER8	                    VARCHAR2(50)	      ,
  REFER9	                    VARCHAR2(50)	      ,
  ATTRIBUTE_A                 VARCHAR2(100)       ,
  ATTRIBUTE_B                 VARCHAR2(100)       ,
  ATTRIBUTE_C                 VARCHAR2(100)       ,
  ATTRIBUTE_D                 VARCHAR2(100)       ,
  ATTRIBUTE_F                 VARCHAR2(100)       ,
  ATTRIBUTE_1                 NUMBER              ,
  ATTRIBUTE_2                 NUMBER              ,
  ATTRIBUTE_3                 NUMBER              ,
  ATTRIBUTE_4                 NUMBER              ,
  ATTRIBUTE_5                 NUMBER              ,
  SOB_ID                      NUMBER              ,
  ORG_ID                      NUMBER              ,
  IDENTIFICATION              VARCHAR2(100)         
) ON COMMIT PRESERVE ROWS;
  -- ON COMMIT DELETE ROWS (COMMIT이 발생할 경우 바로 삭제);
  -- ON COMMIT PRESERVE ROWS (SESSION이 종료될때 삭제);

CREATE INDEX FI_BALANCE_OVER_GT_N1 ON FI_BALANCE_OVER_GT(GL_DATE);
CREATE INDEX FI_BALANCE_OVER_GT_N2 ON FI_BALANCE_OVER_GT(ACCOUNT_CONTROL_ID);
CREATE INDEX FI_BALANCE_OVER_GT_N3 ON FI_BALANCE_OVER_GT(ACCOUNT_CODE);
