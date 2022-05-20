/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_DONATION_INFO
/* Description  : 연말정산 기부금 내역..
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRA_DONATION_INFO
( YEAR_YYYY                       VARCHAR2(4)   NOT NULL,            
  PERSON_ID                       NUMBER        NOT NULL,                 
  SEQ_NUM                         NUMBER        NOT NULL,                 
  RELATION_CODE                   VARCHAR2(2)   NOT NULL,            
  FAMILY_NAME                     VARCHAR2(50)  ,                    
  REPRE_NUM                       VARCHAR2(14)  ,                     
  DONA_DATE                       DATE          ,                            
  DONA_TYPE                       VARCHAR2(2)   ,                     
  SUB_DESCRIPTION                 VARCHAR2(100) ,                   
  COMP_NUM                        VARCHAR2(15)  ,                    
  COMP_NAME                       VARCHAR2(100) ,                   
  DONA_AMT                        NUMBER        ,                          
  DONA_BILL_NUM                   NUMBER        ,                          
  DESCRIPTION                     VARCHAR2(100) ,                   
  ATTRIBUTE1                      VARCHAR2(100) ,                   
  ATTRIBUTE2                      VARCHAR2(100) ,                   
  ATTRIBUTE3                      VARCHAR2(100) ,                   
  ATTRIBUTE4                      VARCHAR2(100) ,                   
  ATTRIBUTE5                      VARCHAR2(100) ,                   
  CREATION_DATE                   DATE          NOT NULL,                   
  CREATED_BY                      NUMBER        NOT NULL,                 
  LAST_UPDATE_DATE                DATE          NOT NULL,                   
  LAST_UPDATED_BY                 NUMBER        NOT NULL
) TABLESPACE FCM_TS_DATA;

--> COMMET 설정 
COMMENT ON COLUMN HRA_DONATION_INFO.YEAR_YYYY IS '정산년도';
COMMENT ON COLUMN HRA_DONATION_INFO.PERSON_ID IS '사원번호';  
COMMENT ON COLUMN HRA_DONATION_INFO.SEQ_NUM IS '일련번호';
COMMENT ON COLUMN HRA_DONATION_INFO.RELATION_CODE IS '관계코드';
COMMENT ON COLUMN HRA_DONATION_INFO.FAMILY_NAME IS '성명';
COMMENT ON COLUMN HRA_DONATION_INFO.REPRE_NUM IS '주민번호';
COMMENT ON COLUMN HRA_DONATION_INFO.DONA_DATE IS '기부일자';
COMMENT ON COLUMN HRA_DONATION_INFO.DONA_TYPE IS '기부금 종류';
COMMENT ON COLUMN HRA_DONATION_INFO.SUB_DESCRIPTION IS '과목';
COMMENT ON COLUMN HRA_DONATION_INFO.COMP_NUM IS '사업자등록번호';
COMMENT ON COLUMN HRA_DONATION_INFO.COMP_NAME IS '사업자명';
COMMENT ON COLUMN HRA_DONATION_INFO.DONA_AMT IS '기부금';
COMMENT ON COLUMN HRA_DONATION_INFO.DONA_BILL_NUM IS '기부영수증 일련번호';
COMMENT ON COLUMN HRA_DONATION_INFO.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRA_DONATION_INFO.CREATION_DATE IS '생성일자';
COMMENT ON COLUMN HRA_DONATION_INFO.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRA_DONATION_INFO.LAST_UPDATE_DATE IS '최종 수정일시';
COMMENT ON COLUMN HRA_DONATION_INFO.LAST_UPDATED_BY IS '최종 수정자';

--> 인덱스 생성.                                                                                                                           
CREATE UNIQUE INDEX HRA_DONATION_INFO_U1 ON HRA_DONATION_INFO(YEAR_YYYY, PERSON_ID, SEQ_NUM) TABLESPACE FCM_TS_IDX;

--> ANALYZE TABLE/INDEX;
ANALYZE TABLE HRA_DONATION_INFO COMPUTE STATISTICS;
ANALYZE INDEX HRA_DONATION_INFO_U1 COMPUTE STATISTICS;
