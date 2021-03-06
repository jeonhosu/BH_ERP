/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_OT_MANAGER
/* Description  : 儡诀/漂辟 包府 - 包府流 
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2013  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRD_OT_MANAGER              
( WORK_DATE                       DATE            NOT NULL,
  PERSON_ID                       NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  OT_TYPE_ID                      NUMBER          NOT NULL,
  OT_DATE_FR                      DATE            NOT NULL,
  OT_DATE_TO                      DATE            NOT NULL,
  DESCRIPTION                     VARCHAR2(3000)  ,  
  STATUS_FLAG                     VARCHAR2(2)     DEFAULT 'N' NOT NULL,
  APPROVAL_YN                     VARCHAR2(2)     DEFAULT 'N' NOT NULL,
  APPROVAL_DATE                   DATE            ,
  APPROVAL_PERSON_ID              NUMBER          ,
  CONFIRMED_YN                    VARCHAR2(2)     DEFAULT 'N' NOT NULL,
  CONFIRMED_DATE                  DATE            ,
  CONFIRMED_PERSON_ID             NUMBER          ,
  TRANSFER_YN                     VARCHAR2(2)     DEFAULT 'N' NOT NULL,
  TRANSFER_DATE                   DATE            ,
  TRANSFER_PERSON_ID              NUMBER          ,
  REJECT_DESC	                    VARCHAR2(3000)  ,
  REJECT_YN		                    VARCHAR2(2)     DEFAULT 'N',
  REJECT_DATE	                    DATE	          ,
  REJECT_PERSON_ID	              NUMBER	        ,
  PAY_YYYYMM		                  VARCHAR2(7)	    , 
  WAGE_TYPE		                    VARCHAR2(4)     ,
  ADD_ALLOWANCE_ID		            NUMBER	        ,
  OT_AMOUNT		                    NUMBER	        ,
  AMT_CREATE_DATE		              DATE	          ,
  AMT_CREATE_PERSON_ID		        NUMBER	        ,
  DUTY_ID                         NUMBER          ,
  HOLY_TYPE                       VARCHAR2(4)     ,
  OPEN_TIME		                    DATE	          ,
  CLOSE_TIME		                  DATE	          ,
  REAL_OT_TIME		                NUMBER	        ,
  LEAVE_TIME                      NUMBER          ,
  ATTRIBUTE_A                     VARCHAR2(150)   ,
  ATTRIBUTE_B                     VARCHAR2(150)   ,
  ATTRIBUTE_C                     VARCHAR2(150)   ,
  ATTRIBUTE_D                     VARCHAR2(150)   ,
  ATTRIBUTE_E                     VARCHAR2(150)   ,
  ATTRIBUTE_1                     NUMBER          ,
  ATTRIBUTE_2                     NUMBER          ,
  ATTRIBUTE_3                     NUMBER          ,       
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRD_OT_MANAGER IS '包府流 儡诀/漂辟 包府';
COMMENT ON COLUMN HRD_OT_MANAGER.WORK_DATE IS '辟公老磊';
COMMENT ON COLUMN HRD_OT_MANAGER.PERSON_ID IS '荤盔ID';
COMMENT ON COLUMN HRD_OT_MANAGER.OT_TYPE_ID IS '儡诀/漂辟 备盒 ID';
COMMENT ON COLUMN HRD_OT_MANAGER.OT_DATE_FR IS '儡诀/漂辟 矫累老矫';
COMMENT ON COLUMN HRD_OT_MANAGER.OT_DATE_TO IS '儡诀/漂辟 辆丰老矫';
COMMENT ON COLUMN HRD_OT_MANAGER.DESCRIPTION IS '利夸';
COMMENT ON COLUMN HRD_OT_MANAGER.STATUS_FLAG IS '惑怕(N-固铰牢, C-犬沥, I-鞭咯傈价)';
COMMENT ON COLUMN HRD_OT_MANAGER.APPROVAL_YN IS '泅诀 铰牢咯何';
COMMENT ON COLUMN HRD_OT_MANAGER.APPROVAL_DATE IS '泅诀 铰牢老矫';
COMMENT ON COLUMN HRD_OT_MANAGER.APPROVAL_PERSON_ID IS '泅诀 铰牢贸府磊';
COMMENT ON COLUMN HRD_OT_MANAGER.CONFIRMED_YN IS '铰牢咯何';
COMMENT ON COLUMN HRD_OT_MANAGER.CONFIRMED_DATE IS '铰牢老矫';
COMMENT ON COLUMN HRD_OT_MANAGER.CONFIRMED_PERSON_ID IS '铰牢贸府磊';
COMMENT ON COLUMN HRD_OT_MANAGER.TRANSFER_YN IS '鞭咯傈价咯何';
COMMENT ON COLUMN HRD_OT_MANAGER.TRANSFER_DATE IS '鞭咯傈价老矫';
COMMENT ON COLUMN HRD_OT_MANAGER.TRANSFER_PERSON_ID IS '鞭咯傈价贸府磊';
COMMENT ON COLUMN HRD_OT_MANAGER.REJECT_DESC IS '馆妨荤蜡';
COMMENT ON COLUMN HRD_OT_MANAGER.REJECT_YN IS '馆妨 铰牢咯何';
COMMENT ON COLUMN HRD_OT_MANAGER.REJECT_DATE IS '馆妨 铰牢老矫';
COMMENT ON COLUMN HRD_OT_MANAGER.REJECT_PERSON_ID IS '馆妨 铰牢贸府磊';
COMMENT ON COLUMN HRD_OT_MANAGER.PAY_YYYYMM IS '鞭惑咯斥岿';
COMMENT ON COLUMN HRD_OT_MANAGER.WAGE_TYPE IS '瘤鞭备盒';
COMMENT ON COLUMN HRD_OT_MANAGER.ADD_ALLOWANCE_ID IS '眠啊瘤鞭ID';
COMMENT ON COLUMN HRD_OT_MANAGER.OT_AMOUNT IS '儡诀 陛咀';
COMMENT ON COLUMN HRD_OT_MANAGER.AMT_CREATE_DATE IS '儡诀陛咀 魂免老矫';
COMMENT ON COLUMN HRD_OT_MANAGER.AMT_CREATE_PERSON_ID IS '儡诀陛咀 魂免磊';
COMMENT ON COLUMN HRD_OT_MANAGER.DUTY_ID IS '辟怕ID';
COMMENT ON COLUMN HRD_OT_MANAGER.HOLY_TYPE IS '辟公备盒';
COMMENT ON COLUMN HRD_OT_MANAGER.OPEN_TIME IS '免辟矫埃';
COMMENT ON COLUMN HRD_OT_MANAGER.CLOSE_TIME IS '硼辟矫埃';
COMMENT ON COLUMN HRD_OT_MANAGER.REAL_OT_TIME IS '儡诀矫埃';
COMMENT ON COLUMN HRD_OT_MANAGER.LEAVE_TIME IS '寇免矫埃';
COMMENT ON COLUMN HRD_OT_MANAGER.CREATION_DATE  IS '积己老磊';
COMMENT ON COLUMN HRD_OT_MANAGER.CREATED_BY IS '积己磊';
COMMENT ON COLUMN HRD_OT_MANAGER.LAST_UPDATE_DATE IS '弥辆荐沥老磊';
COMMENT ON COLUMN HRD_OT_MANAGER.LAST_UPDATED_BY IS '弥辆荐沥磊';

-- CREATE INDEX.
ALTER TABLE HRD_OT_MANAGER ADD CONSTRAINTS HRD_OT_MANAGER_PK PRIMARY KEY(WORK_DATE, PERSON_ID, SOB_ID, ORG_ID, OT_TYPE_ID);

-- ANALYZE.
ANALYZE TABLE HRD_OT_MANAGER COMPUTE STATISTICS;
ANALYZE INDEX HRD_OT_MANAGER_PK COMPUTE STATISTICS;
