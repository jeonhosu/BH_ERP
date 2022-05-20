/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_OT_MANAGER
/* Description  : 잔업/특근 관리 - 관리직 
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
COMMENT ON TABLE HRD_OT_MANAGER IS '관리직 잔업/특근 관리';
COMMENT ON COLUMN HRD_OT_MANAGER.WORK_DATE IS '근무일자';
COMMENT ON COLUMN HRD_OT_MANAGER.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRD_OT_MANAGER.OT_TYPE_ID IS '잔업/특근 구분 ID';
COMMENT ON COLUMN HRD_OT_MANAGER.OT_DATE_FR IS '잔업/특근 시작일시';
COMMENT ON COLUMN HRD_OT_MANAGER.OT_DATE_TO IS '잔업/특근 종료일시';
COMMENT ON COLUMN HRD_OT_MANAGER.DESCRIPTION IS '적요';
COMMENT ON COLUMN HRD_OT_MANAGER.STATUS_FLAG IS '상태(N-미승인, C-확정, I-급여전송)';
COMMENT ON COLUMN HRD_OT_MANAGER.APPROVAL_YN IS '현업 승인여부';
COMMENT ON COLUMN HRD_OT_MANAGER.APPROVAL_DATE IS '현업 승인일시';
COMMENT ON COLUMN HRD_OT_MANAGER.APPROVAL_PERSON_ID IS '현업 승인처리자';
COMMENT ON COLUMN HRD_OT_MANAGER.CONFIRMED_YN IS '승인여부';
COMMENT ON COLUMN HRD_OT_MANAGER.CONFIRMED_DATE IS '승인일시';
COMMENT ON COLUMN HRD_OT_MANAGER.CONFIRMED_PERSON_ID IS '승인처리자';
COMMENT ON COLUMN HRD_OT_MANAGER.TRANSFER_YN IS '급여전송여부';
COMMENT ON COLUMN HRD_OT_MANAGER.TRANSFER_DATE IS '급여전송일시';
COMMENT ON COLUMN HRD_OT_MANAGER.TRANSFER_PERSON_ID IS '급여전송처리자';
COMMENT ON COLUMN HRD_OT_MANAGER.REJECT_DESC IS '반려사유';
COMMENT ON COLUMN HRD_OT_MANAGER.REJECT_YN IS '반려 승인여부';
COMMENT ON COLUMN HRD_OT_MANAGER.REJECT_DATE IS '반려 승인일시';
COMMENT ON COLUMN HRD_OT_MANAGER.REJECT_PERSON_ID IS '반려 승인처리자';
COMMENT ON COLUMN HRD_OT_MANAGER.PAY_YYYYMM IS '급상여년월';
COMMENT ON COLUMN HRD_OT_MANAGER.WAGE_TYPE IS '지급구분';
COMMENT ON COLUMN HRD_OT_MANAGER.ADD_ALLOWANCE_ID IS '추가지급ID';
COMMENT ON COLUMN HRD_OT_MANAGER.OT_AMOUNT IS '잔업 금액';
COMMENT ON COLUMN HRD_OT_MANAGER.AMT_CREATE_DATE IS '잔업금액 산출일시';
COMMENT ON COLUMN HRD_OT_MANAGER.AMT_CREATE_PERSON_ID IS '잔업금액 산출자';
COMMENT ON COLUMN HRD_OT_MANAGER.DUTY_ID IS '근태ID';
COMMENT ON COLUMN HRD_OT_MANAGER.HOLY_TYPE IS '근무구분';
COMMENT ON COLUMN HRD_OT_MANAGER.OPEN_TIME IS '출근시간';
COMMENT ON COLUMN HRD_OT_MANAGER.CLOSE_TIME IS '퇴근시간';
COMMENT ON COLUMN HRD_OT_MANAGER.REAL_OT_TIME IS '잔업시간';
COMMENT ON COLUMN HRD_OT_MANAGER.LEAVE_TIME IS '외출시간';
COMMENT ON COLUMN HRD_OT_MANAGER.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRD_OT_MANAGER.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRD_OT_MANAGER.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRD_OT_MANAGER.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
ALTER TABLE HRD_OT_MANAGER ADD CONSTRAINTS HRD_OT_MANAGER_PK PRIMARY KEY(WORK_DATE, PERSON_ID, SOB_ID, ORG_ID, OT_TYPE_ID);

-- ANALYZE.
ANALYZE TABLE HRD_OT_MANAGER COMPUTE STATISTICS;
ANALYZE INDEX HRD_OT_MANAGER_PK COMPUTE STATISTICS;
