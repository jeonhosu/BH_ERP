/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_CERTIFICATE
/* Description  : 증명서 발급 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_CERTIFICATE              
(PRINT_NUM	                                      VARCHAR2(10) NOT NULL,
  CORP_ID                                         NUMBER,                                                
  PRINT_DATE	                                    DATE,
  PERSON_ID	                                      NUMBER NOT NULL,
  CERT_TYPE_ID                                    NUMBER,
  PRINT_COUNT	                                    NUMBER,
  SEND_ORG	                                      VARCHAR2(100),
  DESCRIPTION                                     VARCHAR2(100),
  PRINT_YYYYMM	                                  VARCHAR2(6) NOT NULL,
  PRINT_SEQ	                                      NUMBER NOT NULL,
  ATTRIBUTE1                                      VARCHAR2(100),
  ATTRIBUTE2                                      VARCHAR2(100),
  ATTRIBUTE3                                      VARCHAR2(100),
  ATTRIBUTE4                                      VARCHAR2(100),
  ATTRIBUTE5                                      VARCHAR2(100),
	SOB_ID                                          NUMBER NOT NULL,
	ORG_ID                                          NUMBER NOT NULL,
  CREATION_DATE                                   DATE NOT NULL,
  CREATED_BY                                      NUMBER NOT NULL,
  LAST_UPDATE_DATE                                DATE NOT NULL,
  LAST_UPDATED_BY                                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_CERTIFICATE.PRINT_NUM IS '인쇄번호';
COMMENT ON COLUMN HRM_CERTIFICATE.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRM_CERTIFICATE.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRM_CERTIFICATE.PRINT_DATE IS '인쇄일자';
COMMENT ON COLUMN HRM_CERTIFICATE.CERT_TYPE_ID IS '증명서 종류 ID';
COMMENT ON COLUMN HRM_CERTIFICATE.PRINT_COUNT IS '인쇄매수';
COMMENT ON COLUMN HRM_CERTIFICATE.SEND_ORG IS '제출처';
COMMENT ON COLUMN HRM_CERTIFICATE.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRM_CERTIFICATE.PRINT_YYYYMM IS '발행년월';
COMMENT ON COLUMN HRM_CERTIFICATE.PRINT_SEQ IS '발행순서';
COMMENT ON COLUMN HRM_CERTIFICATE.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRM_CERTIFICATE.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_CERTIFICATE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_CERTIFICATE.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_CERTIFICATE_U1 ON HRM_CERTIFICATE(PRINT_NUM, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRM_CERTIFICATE_N1 ON HRM_CERTIFICATE(PRINT_YYYYMM, PRINT_SEQ) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRM_CERTIFICATE_N2 ON HRM_CERTIFICATE(CORP_ID, PRINT_DATE, PERSON_ID, CERT_TYPE_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRM_CERTIFICATE COMPUTE STATISTICS;
ANALYZE INDEX HRM_CERTIFICATE_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_CERTIFICATE_N1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_CERTIFICATE_N2 COMPUTE STATISTICS;
