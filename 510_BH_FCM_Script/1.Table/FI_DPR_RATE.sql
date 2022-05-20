/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_DPR_RATE
/* Description  : 고정자산 감가상각율(정률)
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_DPR_RATE 
( DPR_TYPE                        VARCHAR2(10)    NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  PROGRESS_YEAR                   NUMBER          NOT NULL,
  DPR_RATE                        NUMBER          NOT NULL,
  REMARK                          VARCHAR2(200)   ,
  ATTRIBUTE_A                     VARCHAR2(200)   ,
  ATTRIBUTE_B                     VARCHAR2(200)   ,
  ATTRIBUTE_C                     VARCHAR2(200)   ,
  ATTRIBUTE_D                     VARCHAR2(200)   ,
  ATTRIBUTE_E                     VARCHAR2(200)   ,
  ATTRIBUTE_1                     NUMBER          ,
  ATTRIBUTE_2                     NUMBER          ,
  ATTRIBUTE_3                     NUMBER          ,
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          ,
  ENABLED_FLAG                    CHAR(1)         DEFAULT 'Y',
  EFFECTIVE_DATE_FR               DATE            NOT NULL,
  EFFECTIVE_DATE_TO               DATE            ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL   
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_DPR_RATE  IS '감가상각율 관리';
COMMENT ON COLUMN FI_DPR_RATE.DPR_TYPE IS '상각 타입';
COMMENT ON COLUMN FI_DPR_RATE.SOB_ID IS '회계조직';
COMMENT ON COLUMN FI_DPR_RATE.PROGRESS_YEAR IS '내용년수';
COMMENT ON COLUMN FI_DPR_RATE.DPR_RATE IS '상각율';
COMMENT ON COLUMN FI_DPR_RATE.REMARK IS '비고';
COMMENT ON COLUMN FI_DPR_RATE.ENABLED_FLAG IS '사용여부';
COMMENT ON COLUMN FI_DPR_RATE.EFFECTIVE_DATE_FR IS '적용 시작일자';
COMMENT ON COLUMN FI_DPR_RATE.EFFECTIVE_DATE_TO IS '적용 종료일자';
COMMENT ON COLUMN FI_DPR_RATE.CREATION_DATE IS '생성일자';
COMMENT ON COLUMN FI_DPR_RATE.CREATED_BY IS '생성자';
COMMENT ON COLUMN FI_DPR_RATE.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN FI_DPR_RATE.LAST_UPDATED_BY IS '최종수정자';

CREATE UNIQUE INDEX FI_DPR_RATE_PK ON 
  FI_DPR_RATE(DPR_TYPE, PROGRESS_YEAR, SOB_ID)
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
          
 ALTER TABLE FI_DPR_RATE ADD (                                  
  CONSTRAINT FI_DPR_RATE_PK PRIMARY KEY (DPR_TYPE, PROGRESS_YEAR, SOB_ID));

-- ANALYZE.
ANALYZE TABLE FI_DPR_RATE COMPUTE STATISTICS;
