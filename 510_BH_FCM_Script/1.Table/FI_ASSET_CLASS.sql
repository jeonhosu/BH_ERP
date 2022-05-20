/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_ASSET_CLASS
/* Description  : 고정자산 CLASS.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_ASSET_CLASS 
( ASSET_CLASS_ID            NUMBER            NOT NULL,
  ASSET_CLASS_CODE          VARCHAR2(10)      NOT NULL,  
  SOB_ID                    NUMBER            NOT NULL,
  ASSET_CLASS_NAME          VARCHAR2(100)     ,
  ASSET_CLASS_SPEC          VARCHAR2(100)     ,
  ASSET_CLASS_USE           VARCHAR2(100)     ,
  ASSET_CATEGORY_ID         NUMBER            NOT NULL,
  REMARK                    VARCHAR2(150)     ,
  ATTRIBUTE_A               VARCHAR2(200)     ,
  ATTRIBUTE_B               VARCHAR2(200)     ,
  ATTRIBUTE_C               VARCHAR2(200)     ,
  ATTRIBUTE_D               VARCHAR2(200)     ,
  ATTRIBUTE_E               VARCHAR2(200)     ,
  ATTRIBUTE_1               NUMBER            ,
  ATTRIBUTE_2               NUMBER            ,
  ATTRIBUTE_3               NUMBER            ,
  ATTRIBUTE_4               NUMBER            ,
  ATTRIBUTE_5               NUMBER            ,
  ENABLED_FLAG              CHAR(1)           DEFAULT 'Y',
  EFFECTIVE_DATE_FR         DATE              NOT NULL,
  EFFECTIVE_DATE_TO         DATE              ,
  CREATION_DATE             DATE              NOT NULL,
  CREATED_BY                NUMBER            NOT NULL,
  LAST_UPDATE_DATE          DATE              NOT NULL,
  LAST_UPDATED_BY           NUMBER            NOT NULL  
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE APPS.FI_ASSET_CLASS  IS '고정자산_세부구분';
COMMENT ON COLUMN APPS.FI_ASSET_CLASS.ASSET_CLASS_ID IS '고정자산_세부구분ID';
COMMENT ON COLUMN APPS.FI_ASSET_CLASS.ASSET_CLASS_CODE IS '고정자산_구분CODE';
COMMENT ON COLUMN APPS.FI_ASSET_CLASS.SOB_ID IS '회계조직';
COMMENT ON COLUMN APPS.FI_ASSET_CLASS.ASSET_CLASS_NAME IS '자산명칭';
COMMENT ON COLUMN APPS.FI_ASSET_CLASS.ASSET_CLASS_SPEC IS '자산규격';
COMMENT ON COLUMN APPS.FI_ASSET_CLASS.ASSET_CLASS_USE IS '용도';
COMMENT ON COLUMN APPS.FI_ASSET_CLASS.ASSET_CATEGORY_ID IS '자산카테고리ID';
COMMENT ON COLUMN APPS.FI_ASSET_CLASS.CREATION_DATE IS '생성일자';
COMMENT ON COLUMN APPS.FI_ASSET_CLASS.CREATED_BY IS '생성자';
COMMENT ON COLUMN APPS.FI_ASSET_CLASS.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN APPS.FI_ASSET_CLASS.LAST_UPDATED_BY IS '최종수정자';


CREATE UNIQUE INDEX FI_ASSET_CLASS_PK ON 
  FI_ASSET_CLASS(ASSET_CLASS_CODE, SOB_ID)
  TABLESPACE FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  LOGGING
  STORAGE (
           INITIAL 64K
           MINEXTENTS 1
           MAXEXTENTS 2147483645
          );
          
 ALTER TABLE FI_ASSET_CLASS ADD (                                  
  CONSTRAINT FI_ASSET_CLASS_PK PRIMARY KEY (ASSET_CLASS_CODE, SOB_ID)
          );                                                    

CREATE UNIQUE INDEX FI_ASSET_CLASS_U1 ON FI_ASSET_CLASS(ASSET_CLASS_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE FI_ASSET_CLASS_S1;
CREATE SEQUENCE FI_ASSET_CLASS_S1;

-- ANALYZE.
ANALYZE TABLE APPS.FI_ASSET_CLASS COMPUTE STATISTICS;
ANALYZE INDEX FI_ASSET_CLASS_U1 COMPUTE STATISTICS;
