/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : ��¥���� �ӽ� ���̺�
/* Description  : �ش� �Ⱓ�� ���� ���ڸ� ����
/*
/* Reference by : TEMPORARY TABLE�� �̿��Ͽ� ó��.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/

--> INDEX ���� �� ���� <--
/*
CREATE INDEX IFC_HD_DAY_INTERFACE_GT_U1 ON IFC_HD_DAY_INTERFACE_GT(WORK_DATE, PERSON_NUMB);
     
--> ���� ���� <--
GRANT ALL ON IFC_HD_DAY_INTERFACE_GT TO APPS WITH GRANT OPTION;


--> SYNONYM ����
ACCEPT APPS_PWD PROMPT 'Please Enter Apps Password ==> ' HIDE
CONNECT APPS/&APPS_PWD;

DROP SYNONYM IFC_HD_DAY_INTERFACE_GT;

CREATE SYNONYM IFC_HD_DAY_INTERFACE_GT FOR IFC_HD_DAY_INTERFACE_GT;

*/
-------------------------------------------------------------------------------
CREATE GLOBAL TEMPORARY TABLE HRD_WORK_DATE_GT
  ( WORK_DATE                                     DATE NOT NULL
  , PERSON_ID                                     NUMBER
  , WORK_CORP_ID                                  NUMBER
	, CORP_ID                                       NUMBER
	, WORK_YYYYMM                                   VARCHAR2(7)
	, WORK_WEEK                                     VARCHAR2(10)
	, HOLIDAY_CHECK                                 VARCHAR2(2)
	, WORK_TYPE_ID                                  NUMBER
	, WORK_TYPE                                     VARCHAR2(5)  
	, DUTY_ID                                       NUMBER
  , DUTY_CODE                                     VARCHAR2(10)
	, HOLY_TYPE                                     VARCHAR2(2)
	, OPEN_TIME                                     DATE
	, CLOSE_TIME                                    DATE	
	, SOB_ID                                        NUMBER
	, ORG_ID                                        NUMBER
  ) ON COMMIT PRESERVE ROWS;    
  -- ON COMMIT DELETE ROWS (COMMIT�� �߻��� ��� �ٷ� ����);
  -- ON COMMIT PRESERVE ROWS (SESSION�� ����ɶ� ����);

