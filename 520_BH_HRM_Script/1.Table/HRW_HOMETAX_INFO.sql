/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRW_HOMETAX_INFO
/* Description  : 전자신고 위한 홈택스 정보관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRW_HOMETAX_INFO
( CORP_ID                         NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  HOMETAX_ID                      VARCHAR2(100)   ,
  ENCRYPT_PWD                     VARCHAR2(50)    ,
  USER_DEPT                       VARCHAR2(100)   ,
  USER_NAME                       VARCHAR2(100)   ,
  USER_TEL_NUM                    VARCHAR2(20)    ,
  DESCRIPTION                     VARCHAR2(100)   ,
  ATTRIBUTE_1                     NUMBER          ,
  ATTRIBUTE_2                     NUMBER          ,
  ATTRIBUTE_3                     NUMBER          ,
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          ,
  ATTRIBUTE_A                     NUMBER          ,
  ATTRIBUTE_B                     VARCHAR2(100)   ,
  ATTRIBUTE_C                     VARCHAR2(100)   ,
  ATTRIBUTE_D                     VARCHAR2(100)   ,
  ATTRIBUTE_E                     VARCHAR2(100)   ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRW_HOMETAX_INFO IS '홈택스 및 암호화 비밀번호 정보관리';
COMMENT ON COLUMN HRW_HOMETAX_INFO.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRW_HOMETAX_INFO.HOMETAX_ID IS '홈택스ID';
COMMENT ON COLUMN HRW_HOMETAX_INFO.ENCRYPT_PWD IS '암호화 비밀번호';
COMMENT ON COLUMN HRW_HOMETAX_INFO.USER_DEPT IS '담당부서';
COMMENT ON COLUMN HRW_HOMETAX_INFO.USER_NAME IS '담당자명';
COMMENT ON COLUMN HRW_HOMETAX_INFO.USER_TEL_NUM IS '담당자 전화번호';
COMMENT ON COLUMN HRW_HOMETAX_INFO.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRW_HOMETAX_INFO.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRW_HOMETAX_INFO.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRW_HOMETAX_INFO.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRW_HOMETAX_INFO.LAST_UPDATED_BY IS '최종수정자';

-- PK.
ALTER TABLE HRW_HOMETAX_INFO ADD CONSTRAINTS HRW_HOMETAX_INFO_PK PRIMARY KEY(CORP_ID, SOB_ID);

-- ANALYZE.
ANALYZE TABLE HRW_HOMETAX_INFO COMPUTE STATISTICS;

