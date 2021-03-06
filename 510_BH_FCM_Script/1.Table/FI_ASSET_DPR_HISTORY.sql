/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_ASSET_DPR_HISTORY
/* Description  : 감가상각 테이블
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_ASSET_DPR_HISTORY
( PERIOD_NAME                     VARCHAR2(7)     NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  DPR_TYPE                        VARCHAR2(10)    NOT NULL,
  ASSET_ID                        NUMBER          NOT NULL,
  ASSET_CATEGORY_ID               NUMBER          NOT NULL,
  SOURCE_CURR_AMOUNT              NUMBER          DEFAULT 0,
  SOURCE_AMOUNT                   NUMBER          DEFAULT 0,
  SOURCE_ADD_CURR_AMOUNT          NUMBER          DEFAULT 0,
  SOURCE_ADD_AMOUNT               NUMBER          DEFAULT 0,  
  DPR_METHOD_TYPE                 VARCHAR2(10)    NOT NULL,
  DPR_PROGRESS_YEAR               NUMBER          DEFAULT 0,
  DPR_RATE                        NUMBER          DEFAULT 0,
  DPR_CURR_AMOUNT                 NUMBER          DEFAULT 0,
  DPR_AMOUNT                      NUMBER          DEFAULT 0,
  SP_DPR_CURR_AMOUNT              NUMBER          DEFAULT 0,
  SP_DPR_AMOUNT                   NUMBER          DEFAULT 0,
  DPR_COUNT                       NUMBER          DEFAULT 0,
  DPR_YEAR_CURR_AMOUNT            NUMBER          DEFAULT 0,
  DPR_YEAR_AMOUNT                 NUMBER          DEFAULT 0,
  DPR_SUM_CURR_AMOUNT             NUMBER          DEFAULT 0,
  DPR_SUM_AMOUNT                  NUMBER          DEFAULT 0,
  UN_DPR_REMAIN_CURR_AMOUNT       NUMBER          DEFAULT 0,
  UN_DPR_REMAIN_AMOUNT            NUMBER          DEFAULT 0,
  ASSET_MASTER_YN                 CHAR(1)         DEFAULT 'N',
  DISUSE_YN                       CHAR(1)         DEFAULT 'N',
  SLIP_YN                         CHAR(1)         DEFAULT 'N',  
  SLIP_DATE                       DATE            ,
  SLIP_HEADER_ID                  NUMBER          ,
  GL_NUM                          VARCHAR2(30)    ,
  SLIP_LINE_ID                    NUMBER          ,  
  REMARK                          VARCHAR2(200)   ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL   
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_ASSET_DPR_HISTORY  IS '고정자산 감가상각내역';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.PERIOD_NAME IS '상각년월';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.DPR_TYPE IS '상각구분(내부회계, IFRS)';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.ASSET_ID IS '고정자산 ID';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.ASSET_CATEGORY_ID IS '자산카테고리ID';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.SOURCE_CURR_AMOUNT IS '상각대상금액(외화)';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.SOURCE_AMOUNT IS '상각대상금액';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.SOURCE_ADD_CURR_AMOUNT IS '상각대상 추가금액(외화)';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.SOURCE_ADD_AMOUNT IS '상각대상추가금액';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.DPR_METHOD_TYPE IS '상각구분 1:정액,2:정율(DEPRE_METH)';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.DPR_PROGRESS_YEAR IS '내용년수';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.DPR_RATE IS '상각율';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.DPR_CURR_AMOUNT IS '상각금액(외화)';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.DPR_AMOUNT IS '상각금액';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.SP_DPR_CURR_AMOUNT IS '특별상각금액(외화)';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.SP_DPR_AMOUNT IS '특별상각금액';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.DPR_COUNT IS '상각횟수';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.DPR_YEAR_CURR_AMOUNT IS '년상각금액(외화)';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.DPR_YEAR_AMOUNT IS '년상각금액';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.DPR_SUM_CURR_AMOUNT IS '상각누계액(외화)';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.DPR_SUM_AMOUNT IS '년상각금액';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.UN_DPR_REMAIN_CURR_AMOUNT IS '미상각금액(외화)';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.UN_DPR_REMAIN_AMOUNT IS '미상각금액';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.ASSET_MASTER_YN IS '자산대장 반영Y/N';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.DISUSE_YN IS '폐기 Y/N';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.SLIP_YN IS '전표생성Y/N';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.SLIP_DATE IS '전표일자';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.SLIP_HEADER_ID IS '전표 헤더ID';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.GL_NUM IS '전표번호';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.SLIP_LINE_ID IS '전표라인ID';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.REMARK  IS  '적요';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.CREATION_DATE IS '생성일자';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.CREATED_BY IS '생성자';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY.LAST_UPDATED_BY IS '최종수정자';


CREATE UNIQUE INDEX FI_ASSET_DPR_HISTORY_PK ON 
  FI_ASSET_DPR_HISTORY(PERIOD_NAME, SOB_ID, DPR_TYPE, ASSET_ID)
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
          
 ALTER TABLE FI_ASSET_DPR_HISTORY ADD (                                  
  CONSTRAINT FI_ASSET_DPR_HISTORY_PK PRIMARY KEY (PERIOD_NAME, SOB_ID, DPR_TYPE, ASSET_ID));

CREATE INDEX FI_ASSET_DPR_HISTORY_N1 ON FI_ASSET_DPR_HISTORY(DPR_METHOD_TYPE, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_ASSET_DPR_HISTORY_N2 ON FI_ASSET_DPR_HISTORY(ASSET_CATEGORY_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE FI_ASSET_DPR_HISTORY COMPUTE STATISTICS;
ANALYZE INDEX FI_ASSET_DPR_HISTORY_N1 COMPUTE STATISTICS;
ANALYZE INDEX FI_ASSET_DPR_HISTORY_N2 COMPUTE STATISTICS;
