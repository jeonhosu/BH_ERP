/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_DEPT_MAPPING
/* Description  : 부서마스터 맵핑관리 : 기표부서 - 발의부서 
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_DEPT_MAPPING
( DEPT_CODE                       VARCHAR2(30) NOT NULL,
  SOB_ID                          NUMBER       NOT NULL,
  ORG_ID                          NUMBER       NOT NULL,
  MAPPING_DEPT_CODE               VARCHAR(30)  ,
  MAPPING_DEPT_ALL                CHAR(1)      DEFAULT 'N',
  DESCRIPTION                     VARCHAR2(100), 
  ENABLED_FLAG                    CHAR(1)      ,
  EFFECTIVE_DATE_FR               DATE         NOT NULL,
  EFFECTIVE_DATE_TO               DATE         ,
  CREATION_DATE                   DATE         NOT NULL,
  CREATED_BY                      NUMBER       NOT NULL,
  LAST_UPDATE_DATE                DATE         NOT NULL,
  LAST_UPDATED_BY                 NUMBER       NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE FI_DEPT_MAPPING IS '부서 맵핑(기표부서 - 발의부서)';
COMMENT ON COLUMN FI_DEPT_MAPPING.SOB_ID IS '회사 ID';
COMMENT ON COLUMN FI_DEPT_MAPPING.DEPT_CODE IS '부서코드';
COMMENT ON COLUMN FI_DEPT_MAPPING.MAPPING_DEPT_CODE IS '발의부서코드';
COMMENT ON COLUMN FI_DEPT_MAPPING.MAPPING_DEPT_ALL IS '전체 YN';
COMMENT ON COLUMN FI_DEPT_MAPPING.ENABLED_FLAG IS '사용 여부';
COMMENT ON COLUMN FI_DEPT_MAPPING.EFFECTIVE_DATE_FR IS '시작일자';
COMMENT ON COLUMN FI_DEPT_MAPPING.EFFECTIVE_DATE_TO IS '종료일자';
COMMENT ON COLUMN FI_DEPT_MAPPING.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN FI_DEPT_MAPPING.CREATED_BY IS '생성자';
COMMENT ON COLUMN FI_DEPT_MAPPING.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN FI_DEPT_MAPPING.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX FI_DEPT_MAPPING_U1 ON FI_DEPT_MAPPING(DEPT_CODE, SOB_ID, MAPPING_DEPT_CODE) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_DEPT_MAPPING_N1 ON FI_DEPT_MAPPING(DEPT_CODE, SOB_ID, ENABLED_FLAG, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO) TABLESPACE FCM_TS_IDX;


-- ANALYZE.
ANALYZE TABLE FI_DEPT_MAPPING COMPUTE STATISTICS;
ANALYZE INDEX FI_DEPT_MAPPING_U1 COMPUTE STATISTICS;
ANALYZE INDEX FI_DEPT_MAPPING_N1 COMPUTE STATISTICS;
