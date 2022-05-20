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
CREATE GLOBAL TEMPORARY TABLE FI_BALANCE_FS_GT
( HEADER_ID                 NUMBER
, HEADER_CODE               VARCHAR2(20)
, LINE_HEADER_ID            NUMBER
, LINE_HEADER_CODE          VARCHAR2(20)
, LINE_ID                   NUMBER
, ITEM_LEVEL                NUMBER
, SOB_ID                    NUMBER
, ORG_ID                    NUMBER
, BEFORE_DR_AMOUNT          NUMBER DEFAULT 0
, BEFORE_CR_AMOUNT          NUMBER DEFAULT 0
, THIS_DR_AMOUNT            NUMBER DEFAULT 0
, THIS_CR_AMOUNT            NUMBER DEFAULT 0
, REMAIN_DR_AMOUNT          NUMBER DEFAULT 0
, REMAIN_CR_AMOUNT          NUMBER DEFAULT 0
, CREATION_DATE             DATE
, CREATED_BY                NUMBER
) ON COMMIT PRESERVE ROWS;


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
