-- CREATE TABLE
-- 내용년수 변경에 따른 추가 --  
CREATE TABLE FI_ASSET_DPR_HISTORY_CG
(
  PERIOD_NAME               VARCHAR2(7) NOT NULL,
  SOB_ID                    NUMBER NOT NULL,
  ORG_ID                    NUMBER NOT NULL,
  DPR_TYPE                  VARCHAR2(10) NOT NULL,
  ASSET_ID                  NUMBER NOT NULL,
  ASSET_CATEGORY_ID         NUMBER NOT NULL,
  SOURCE_CURR_AMOUNT        NUMBER DEFAULT 0,
  SOURCE_AMOUNT             NUMBER DEFAULT 0,
  SOURCE_ADD_CURR_AMOUNT    NUMBER DEFAULT 0,
  SOURCE_ADD_AMOUNT         NUMBER DEFAULT 0,
  DPR_METHOD_TYPE           VARCHAR2(10) NOT NULL,
  DPR_PROGRESS_YEAR         NUMBER DEFAULT 0,
  DPR_RATE                  NUMBER DEFAULT 0,
  DPR_CURR_AMOUNT           NUMBER DEFAULT 0,
  DPR_AMOUNT                NUMBER DEFAULT 0,
  SP_DPR_CURR_AMOUNT        NUMBER DEFAULT 0,
  SP_DPR_AMOUNT             NUMBER DEFAULT 0,
  DPR_COUNT                 NUMBER DEFAULT 0,
  DPR_YEAR_CURR_AMOUNT      NUMBER DEFAULT 0,
  DPR_YEAR_AMOUNT           NUMBER DEFAULT 0,
  DPR_SUM_CURR_AMOUNT       NUMBER DEFAULT 0,
  DPR_SUM_AMOUNT            NUMBER DEFAULT 0,
  UN_DPR_REMAIN_CURR_AMOUNT NUMBER DEFAULT 0,
  UN_DPR_REMAIN_AMOUNT      NUMBER DEFAULT 0,
  ASSET_MASTER_YN           CHAR(1) DEFAULT 'N',
  DISUSE_YN                 CHAR(1) DEFAULT 'N',
  SLIP_YN                   CHAR(1) DEFAULT 'N',
  SLIP_DATE                 DATE,
  SLIP_LINE_ID              NUMBER,
  REMARK                    VARCHAR2(200),
  CREATION_DATE             DATE NOT NULL,
  CREATED_BY                NUMBER NOT NULL,
  LAST_UPDATE_DATE          DATE NOT NULL,
  LAST_UPDATED_BY           NUMBER NOT NULL,
  SLIP_HEADER_ID            NUMBER,
  GL_NUM                    VARCHAR2(30),
  COST_CENTER_ID            NUMBER,
  DPR_YN                    VARCHAR2(1),
  SP_MNS_DPR_AMOUNT         NUMBER
)
TABLESPACE FCM_TS_DATA
  PCTFREE 10
  INITRANS 1
  MAXTRANS 255
  STORAGE
  (
    INITIAL 43M
    NEXT 1M
    MINEXTENTS 1
    MAXEXTENTS UNLIMITED
  );
-- ADD COMMENTS TO THE TABLE 
COMMENT ON TABLE FI_ASSET_DPR_HISTORY_CG
  IS '자산별감가상각스케쥴내역';
-- ADD COMMENTS TO THE COLUMNS 
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME
  IS '상각년월';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.SOB_ID
  IS '회사아이디';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.ORG_ID
  IS '사업부아이디';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.DPR_TYPE
  IS '회계구분';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.ASSET_ID
  IS '자산아이디';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.ASSET_CATEGORY_ID
  IS '자산유형아이디';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.SOURCE_CURR_AMOUNT
  IS '상각대상금액(외화)';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.SOURCE_AMOUNT
  IS '(최종)감가상각비';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.SOURCE_ADD_CURR_AMOUNT
  IS '상각대상 추가금액(외화)';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.SOURCE_ADD_AMOUNT
  IS '상각대상추가금액';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.DPR_METHOD_TYPE
  IS '감가상각방법';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.DPR_PROGRESS_YEAR
  IS '내용년수';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.DPR_RATE
  IS '상각율';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.DPR_CURR_AMOUNT
  IS '상각금액(외화)';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.DPR_AMOUNT
  IS '(최초)감가상각비';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.SP_DPR_CURR_AMOUNT
  IS '특별상각금액(외화)';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.SP_DPR_AMOUNT
  IS '추가상각액';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.DPR_COUNT
  IS '상각회차';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.DPR_YEAR_CURR_AMOUNT
  IS '년상각금액(외화)';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.DPR_YEAR_AMOUNT
  IS '년상각금액';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.DPR_SUM_CURR_AMOUNT
  IS '상각누계액(외화)';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.DPR_SUM_AMOUNT
  IS '감가상각누계액';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.UN_DPR_REMAIN_CURR_AMOUNT
  IS '미상각금액(외화)';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.UN_DPR_REMAIN_AMOUNT
  IS '미상각잔액';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.ASSET_MASTER_YN
  IS '자산대장 반영Y/N';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.DISUSE_YN
  IS '마지막회차여부';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.SLIP_YN
  IS '전표생성여부(Y/N)';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.SLIP_DATE
  IS '전표일자';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.SLIP_LINE_ID
  IS '전표라인ID';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.REMARK
  IS '비고';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.CREATION_DATE
  IS '생성일자';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.CREATED_BY
  IS '생성자';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.LAST_UPDATE_DATE
  IS '최종수정일자';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.LAST_UPDATED_BY
  IS '최종수정자';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.SLIP_HEADER_ID
  IS '전표 헤더ID';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.GL_NUM
  IS '전표번호';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.COST_CENTER_ID
  IS '원가아이디';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.DPR_YN
  IS '감가상각여부';
COMMENT ON COLUMN FI_ASSET_DPR_HISTORY_CG.SP_MNS_DPR_AMOUNT
  IS '차감상각액';
-- CREATE/RECREATE INDEXES 
CREATE INDEX FI_ASSET_DPR_HISTORY_CG_N1 ON FI_ASSET_DPR_HISTORY_CG (DPR_METHOD_TYPE, SOB_ID)
  TABLESPACE FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  STORAGE
  (
    INITIAL 4M
    NEXT 1M
    MINEXTENTS 1
    MAXEXTENTS UNLIMITED
  );
CREATE INDEX FI_ASSET_DPR_HISTORY_CG_N2 ON FI_ASSET_DPR_HISTORY_CG (ASSET_CATEGORY_ID)
  TABLESPACE FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  STORAGE
  (
    INITIAL 4M
    NEXT 1M
    MINEXTENTS 1
    MAXEXTENTS UNLIMITED
  );
-- CREATE/RECREATE PRIMARY, UNIQUE AND FOREIGN KEY CONSTRAINTS 
ALTER TABLE FI_ASSET_DPR_HISTORY_CG
  ADD CONSTRAINT FI_ASSET_DPR_HISTORY_CG_PK PRIMARY KEY (PERIOD_NAME, SOB_ID, DPR_TYPE, ASSET_ID)
  USING INDEX 
  TABLESPACE FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  STORAGE
  (
    INITIAL 7M
    NEXT 1M
    MINEXTENTS 1
    MAXEXTENTS UNLIMITED
  );
