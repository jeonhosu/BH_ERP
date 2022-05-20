/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : EAPP_ADDRESS
/* Description  : 주소 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE EAPP_ADDRESS              
(ADDRESS_ID    	                              NUMBER NOT NULL,
  ADDRESS1	                                    VARCHAR2(100),
  ADDRESS2	                                    VARCHAR2(100),
  ADDRESS3	                                    VARCHAR2(100),
  ADDRESS4	                                    VARCHAR2(100),
  ISLAND_NAME	                               VARCHAR2(100),
  STRUCTURE_NAME                        VARCHAR2(100),
  ZIP_CODE	                                    VARCHAR2(20),
  ADDRESS	                                      VARCHAR2(150) NOT NULL,
  ATTRIBUTE1                                  VARCHAR2(100),
  ATTRIBUTE2                                  VARCHAR2(100),
  ATTRIBUTE3                                  VARCHAR2(100),
  ATTRIBUTE4                                  VARCHAR2(100),
  ATTRIBUTE5                                  VARCHAR2(100),
  CREATION_DATE                            DATE NOT NULL,
  CREATED_BY                                  NUMBER NOT NULL,
  LAST_UPDATE_DATE                       DATE NOT NULL,
  LAST_UPDATED_BY                         NUMBER NOT NULL
)
TABLESPACE EAPP_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN EAPP_ADDRESS.ADDRESS_ID IS '주소 일련번호';
COMMENT ON COLUMN EAPP_ADDRESS.ADDRESS1 IS '도/시';
COMMENT ON COLUMN EAPP_ADDRESS.ADDRESS2 IS '시/군/구';
COMMENT ON COLUMN EAPP_ADDRESS.ADDRESS3 IS '읍/면/동';
COMMENT ON COLUMN EAPP_ADDRESS.ADDRESS4 IS '리';
COMMENT ON COLUMN EAPP_ADDRESS.ISLAND_NAME IS '도서(섬)';
COMMENT ON COLUMN EAPP_ADDRESS.STRUCTURE_NAME IS '건축물/아파트명';
COMMENT ON COLUMN EAPP_ADDRESS.ZIP_CODE IS '우편번호';
COMMENT ON COLUMN EAPP_ADDRESS.ADDRESS IS '주소';
COMMENT ON COLUMN EAPP_ADDRESS.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN EAPP_ADDRESS.CREATED_BY IS '생성자';
COMMENT ON COLUMN EAPP_ADDRESS.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN EAPP_ADDRESS.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX EAPP_ADDRESS_U1 ON EAPP_ADDRESS(ADDRESS_ID) TABLESPACE EAPP_TS_IDX;
CREATE INDEX EAPP_ADDRESS_N1 ON EAPP_ADDRESS(ADDRESS3, ADDRESS4) TABLESPACE EAPP_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE EAPP_ADDRESS_S1;
CREATE SEQUENCE EAPP_ADDRESS_S1;

-- ANALYZE.
ANALYZE TABLE EAPP_ADDRESS COMPUTE STATISTICS;
ANALYZE INDEX EAPP_ADDRESS_U1 COMPUTE STATISTICS;
