/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_OPERATING_UNIT
/* Description  : 사업장 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_OPERATING_UNIT
( CORP_ID	                                      NUMBER NOT NULL,
  OPERATING_UNIT_ID	                            NUMBER NOT NULL,
  OPERATING_UNIT_NAME	                          VARCHAR2(70),
  PRESIDENT_NAME	                              VARCHAR2(50),
  ZIP_CODE	                                    VARCHAR2(7),
  ADDR1	                                        VARCHAR2(80),
  ADDR2	                                        VARCHAR2(80),
  VAT_NUMBER	                                  VARCHAR2(20),
  TAX_OFFICE_CODE	                              VARCHAR2(5),
  TAX_OFFICE_NAME	                              VARCHAR2(50),
  BUSINESS_TYPE	                                VARCHAR2(50),
  BUSINESS_ITEM	                                VARCHAR2(50),
  ORG_SORT_NUM	                                NUMBER,
  TEL_NUMBER	                                  VARCHAR2(13),
  FAX_NUMBER	                                  VARCHAR2(13),
  HOMEPAGE_URL	                                VARCHAR2(100),
	DEFAULT_FLAG                                  VARCHAR2(1) DEFAULT 'N',
  ATTRIBUTE1	                                  VARCHAR2(100),
  ATTRIBUTE2	                                  VARCHAR2(100),
  ATTRIBUTE3                                    VARCHAR2(100),
  ATTRIBUTE4	                                  VARCHAR2(100),
  ATTRIBUTE5	                                  VARCHAR2(100),
  USABLE                                        VARCHAR2(1) NOT NULL,
  START_DATE                                    DATE NOT NULL,
  END_DATE                                      DATE,
	SOB_ID                                        NUMBER NOT NULL,
	ORG_ID                                        NUMBER NOT NULL,
  CREATION_DATE                                 DATE NOT NULL,
  CREATED_BY                                    NUMBER NOT NULL,
  LAST_UPDATE_DATE                              DATE NOT NULL,
  LAST_UPDATED_BY                               NUMBER NOT NULL
)
 TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_OPERATING_UNIT.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRM_OPERATING_UNIT.OPERATING_UNIT_ID IS '사업장 ID';
COMMENT ON COLUMN HRM_OPERATING_UNIT.OPERATING_UNIT_NAME IS '사업장 명';
COMMENT ON COLUMN HRM_OPERATING_UNIT.PRESIDENT_NAME IS '대표자';
COMMENT ON COLUMN HRM_OPERATING_UNIT.ZIP_CODE IS '우편번호';
COMMENT ON COLUMN HRM_OPERATING_UNIT.ADDR1 IS '주소1';
COMMENT ON COLUMN HRM_OPERATING_UNIT.ADDR2 IS '주소2';
COMMENT ON COLUMN HRM_OPERATING_UNIT.VAT_NUMBER IS '사업장번호';
COMMENT ON COLUMN HRM_OPERATING_UNIT.TAX_OFFICE_CODE IS '담당 세무서코드';
COMMENT ON COLUMN HRM_OPERATING_UNIT.TAX_OFFICE_NAME IS '담당 세무서명';
COMMENT ON COLUMN HRM_OPERATING_UNIT.BUSINESS_TYPE IS '업종';
COMMENT ON COLUMN HRM_OPERATING_UNIT.BUSINESS_ITEM IS '업태';
COMMENT ON COLUMN HRM_OPERATING_UNIT.TEL_NUMBER IS '회사 전화번호';
COMMENT ON COLUMN HRM_OPERATING_UNIT.FAX_NUMBER IS '팩스번호';
COMMENT ON COLUMN HRM_OPERATING_UNIT.HOMEPAGE_URL IS '홈페이지';
COMMENT ON COLUMN HRM_OPERATING_UNIT.DEFAULT_FLAG IS '기본';
COMMENT ON COLUMN HRM_OPERATING_UNIT.USABLE IS '사용 FLAG';
COMMENT ON COLUMN HRM_OPERATING_UNIT.START_DATE IS '시작일자';
COMMENT ON COLUMN HRM_OPERATING_UNIT.END_DATE IS '종료일자';
COMMENT ON COLUMN HRM_OPERATING_UNIT.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRM_OPERATING_UNIT.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_OPERATING_UNIT.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_OPERATING_UNIT.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_OPERATING_UNIT_U1 ON HRM_OPERATING_UNIT(OPERATING_UNIT_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRM_OPERATING_UNIT_U2 ON HRM_OPERATING_UNIT(CORP_ID, OPERATING_UNIT_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE;
DROP SEQUENCE HRM_OPERATING_UNIT_S1;
CREATE SEQUENCE HRM_OPERATING_UNIT_S1;

-- ANALYZE.
ANALYZE TABLE HRM_OPERATING_UNIT COMPUTE STATISTICS;
ANALYZE INDEX HRM_OPERATING_UNIT_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_OPERATING_UNIT_U2 COMPUTE STATISTICS;

