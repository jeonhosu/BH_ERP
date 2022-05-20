/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_ASSET_HISTORY
/* Description  : 감가상각 테이블
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_ASSET_HISTORY
( HISTORY_NUM                     VARCHAR2(20)    NOT NULL,
  CHARGE_DATE                     DATE            NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  ASSET_ID                        NUMBER          NOT NULL,
  CHARGE_ID                       NUMBER          NOT NULL,
  CURRENCY_CODE                   VARCHAR2(10)    ,
  EXCHANGE_RATE                   NUMBER          ,
  CURR_AMOUNT                     NUMBER          ,
  AMOUNT                          NUMBER          ,  
  QTY                             NUMBER          ,
  LOCATION_ID                     NUMBER          ,
  USE_DEPT_ID                     NUMBER          ,
  FIRST_USER                      VARCHAR2(100)   ,
  SECOND_USER                     VARCHAR2(100)   ,
  COST_CENTER_ID                  NUMBER          ,
  BF_AMOUNT                       NUMBER          ,
  BF_CURR_AMOUNT                  NUMBER          ,
  BF_QTY                          NUMBER          ,
  BF_LOCATION_ID                  NUMBER          ,
  BF_USE_DEPT_ID                  NUMBER          ,
  BF_FIRST_USER                   VARCHAR2(100)   ,
  BF_SECOND_USER                  VARCHAR2(100)   ,
  BF_COST_CENTER_ID               NUMBER          ,
  DESCRIPTION                     VARCHAR2(200)   ,
  DPR_SUM_AMOUNT                  NUMBER          DEFAULT 0,
  DPR_SUM_CURR_AMOUNT             NUMBER          DEFAULT 0,
  IFRS_DPR_SUM_AMOUNT             NUMBER          DEFAULT 0,
  IFRS_DPR_SUM_CURR_AMOUNT        NUMBER          DEFAULT 0,
  DPR_SUM_DC_AMOUNT               NUMBER          DEFAULT 0,
  IFRS_DPR_SUM_DC_AMOUNT          NUMBER          DEFAULT 0,
  CUSTOMER_ID                     NUMBER          ,
  TAX_ISSUE_DATE                  DATE            ,
  DISUSE_DATE                     DATE            ,
  REFER_SLIP_DATE                 DATE            ,
  REFER_SLIP_LINE_ID              NUMBER          ,
  REFER_REMARK                    VARCHAR2(200)   ,
  ACCOUNT_CONTROL_ID              NUMBER          ,
  GL_DATE                         DATE            ,
  SLIP_LINE_ID                    NUMBER,
  REMARK                          VARCHAR2(200)   ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL   
)TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_ASSET_HISTORY  IS '고정자산 변동내역';
COMMENT ON COLUMN FI_ASSET_HISTORY.HISTORY_NUM IS '자산변동번호';
COMMENT ON COLUMN FI_ASSET_HISTORY.CHARGE_DATE IS '변도일자';
COMMENT ON COLUMN FI_ASSET_HISTORY.ASSET_ID IS '고정자산 ID';
COMMENT ON COLUMN FI_ASSET_HISTORY.CHARGE_ID IS '변동사유';
COMMENT ON COLUMN FI_ASSET_HISTORY.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN FI_ASSET_HISTORY.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN FI_ASSET_HISTORY.AMOUNT IS '변동후 금액';
COMMENT ON COLUMN FI_ASSET_HISTORY.CURR_AMOUNT IS '변동후 금액(외화)';
COMMENT ON COLUMN FI_ASSET_HISTORY.QTY IS '변동후 수량';
COMMENT ON COLUMN FI_ASSET_HISTORY.LOCATION_ID IS '변동후 위치';
COMMENT ON COLUMN FI_ASSET_HISTORY.USE_DEPT_ID IS '사용 부서';
COMMENT ON COLUMN FI_ASSET_HISTORY.FIRST_USER IS '주 사용자';
COMMENT ON COLUMN FI_ASSET_HISTORY.SECOND_USER IS '부 사용자';
COMMENT ON COLUMN FI_ASSET_HISTORY.COST_CENTER_ID IS '변동후 코스트센터';
COMMENT ON COLUMN FI_ASSET_HISTORY.BF_AMOUNT IS '변동전 금액';
COMMENT ON COLUMN FI_ASSET_HISTORY.BF_CURR_AMOUNT IS '변동전 금액(외화)';
COMMENT ON COLUMN FI_ASSET_HISTORY.BF_QTY IS '변동전 수량';
COMMENT ON COLUMN FI_ASSET_HISTORY.BF_LOCATION_ID IS '변동전 위치ID';
COMMENT ON COLUMN FI_ASSET_HISTORY.BF_USE_DEPT_ID IS '사용 부서';
COMMENT ON COLUMN FI_ASSET_HISTORY.BF_FIRST_USER IS '주 사용자';
COMMENT ON COLUMN FI_ASSET_HISTORY.BF_SECOND_USER IS '부 사용자';
COMMENT ON COLUMN FI_ASSET_HISTORY.BF_COST_CENTER_ID IS '변동전 코스트센터';
COMMENT ON COLUMN FI_ASSET_HISTORY.DESCRIPTION IS '비고';
COMMENT ON COLUMN FI_ASSET_HISTORY.DPR_SUM_AMOUNT IS '상각누계금액';
COMMENT ON COLUMN FI_ASSET_HISTORY.DPR_SUM_CURR_AMOUNT IS '상각누계액(외화)';
COMMENT ON COLUMN FI_ASSET_HISTORY.IFRS_DPR_SUM_AMOUNT IS 'IFRS 상각누계액';
COMMENT ON COLUMN FI_ASSET_HISTORY.IFRS_DPR_SUM_CURR_AMOUNT IS 'IFRS 상각누계액(외화)';
COMMENT ON COLUMN FI_ASSET_HISTORY.DPR_SUM_DC_AMOUNT IS '충당금 감소액';
COMMENT ON COLUMN FI_ASSET_HISTORY.IFRS_DPR_SUM_DC_AMOUNT IS 'IFRS 충당금 감소액';
COMMENT ON COLUMN FI_ASSET_HISTORY.CUSTOMER_ID IS '매각 거래처ID';
COMMENT ON COLUMN FI_ASSET_HISTORY.TAX_ISSUE_DATE IS '세금계산서일자';
COMMENT ON COLUMN FI_ASSET_HISTORY.DISUSE_DATE IS '폐기일자';
COMMENT ON COLUMN FI_ASSET_HISTORY.REFER_SLIP_DATE IS '참고 전표일자';
COMMENT ON COLUMN FI_ASSET_HISTORY.REFER_SLIP_LINE_ID IS '참고 전표라인ID';
COMMENT ON COLUMN FI_ASSET_HISTORY.REFER_REMARK IS '참고 적요';
COMMENT ON COLUMN FI_ASSET_HISTORY.ACCOUNT_CONTROL_ID IS '계정ID';
COMMENT ON COLUMN FI_ASSET_HISTORY.GL_DATE IS '전표일자';
COMMENT ON COLUMN FI_ASSET_HISTORY.SLIP_LINE_ID IS '전표라인ID';
COMMENT ON COLUMN FI_ASSET_HISTORY.REMARK IS '전표 적요';
COMMENT ON COLUMN FI_ASSET_HISTORY.CREATION_DATE IS '생성일자';
COMMENT ON COLUMN FI_ASSET_HISTORY.CREATED_BY IS '생성자';
COMMENT ON COLUMN FI_ASSET_HISTORY.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN FI_ASSET_HISTORY.LAST_UPDATED_BY IS '최종수정자';

ALTER TABLE FI_ASSET_HISTORY ADD CONSTRAINT FI_ASSET_HISTORY_PK PRIMARY KEY (HISTORY_NUM);

CREATE INDEX FI_ASSET_HISTORY_N1 ON FI_ASSET_HISTORY(CHARGE_DATE, SOB_ID, CHARGE_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_ASSET_HISTORY_N2 ON FI_ASSET_HISTORY(ASSET_ID) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE FI_ASSET_HISTORY COMPUTE STATISTICS;
ANALYZE INDEX FI_ASSET_HISTORY_N1 COMPUTE STATISTICS;
ANALYZE INDEX FI_ASSET_HISTORY_N2 COMPUTE STATISTICS;
