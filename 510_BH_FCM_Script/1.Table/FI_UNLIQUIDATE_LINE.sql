/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_UNLIQUIDATE_LINE
/* Description  : 미청산 반제 전표 상세
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_UNLIQUIDATE_LINE 
( SLIP_LINE_ID                    NUMBER        NOT NULL,      -- 전표 라인ID.
  SOB_ID                          NUMBER        NOT NULL,      -- 회계조직.
  ORG_ID                          NUMBER        NOT NULL,      -- 사업부ID.
  LIQUIDATE_SLIP_LINE_ID          NUMBER        NOT NULL,      -- 반제전표 라인ID.
  PERIOD_NAME                     VARCHAR2(10)  NOT NULL,      -- 회계년월.
  UNLIQUIDATE_TYPE                CHAR(1)       DEFAULT '1',   -- 반제형태 1:정상  0:상계반제Data  (추가)
  GL_DATE                         DATE          ,              -- 회계일자.
  GL_NUM                          VARCHAR2(30)  ,              -- 회계번호
  ACCOUNT_BOOK_ID                 NUMBER        NOT NULL,      -- 회계장부ID.
  SLIP_TYPE                       VARCHAR2(10)  NOT NULL,      -- 전표유형.    
  ACCOUNT_CONTROL_ID              NUMBER        NOT NULL,       
  ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL,    
  ACCOUNT_DR_CR                   VARCHAR2(2)   NOT NULL,     
  CUSTOMER_ID                     NUMBER        ,              -- 거래처ID.
  GL_AMOUNT                       NUMBER        DEFAULT 0, 
  CURRENCY_CODE                   VARCHAR2(10)  ,              -- 통화.
  EXCHANGE_RATE                   NUMBER        ,              -- 환율.
  GL_CURRENCY_AMOUNT              NUMBER        ,              -- 외화금액.
  MANAGEMENT1                     VARCHAR2(50)  ,
  MANAGEMENT2                     VARCHAR2(50)  ,
  REFER_DATE1                     DATE          ,              -- 관리일자코드1.
  REFER_DATE2                     DATE          ,              -- 관리일자코드2.
  REMARK                          VARCHAR2(100) ,              -- 적요.
  CREATION_DATE                   DATE          NOT NULL,  
  CREATED_BY                      NUMBER        NOT NULL,   
  LAST_UPDATE_DATE                DATE          NOT NULL,   
  LAST_UPDATED_BY                 NUMBER        NOT NULL   
) TABLESPACE FCM_TS_DATA ;

COMMENT ON TABLE FI_UNLIQUIDATE_LINE IS '미청산 반제전표 상세';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.SLIP_LINE_ID IS '전표 라인 ID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.UNLIQUIDATE_TYPE IS '반제형태 1-정상, 2-상계반제';
/*
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.SLIP_LINE_SEQ IS '전표 라인 번호';*/
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.LIQUIDATE_SLIP_LINE_ID IS '반제전표 라인 ID';
/*COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.LIQUIDATE_SLIP_HEADER_ID IS '반제전표 헤더 ID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.LIQUIDATE_SLIP_LINE_SEQ IS '반제전표 라인 번호';*/
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.GL_DATE IS '회계일자';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.GL_NUM IS '회계 전표번호';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.ACCOUNT_BOOK_ID IS '회계장부';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.SLIP_TYPE IS '전표유형';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.ACCOUNT_CONTROL_ID IS '계정통제ID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.ACCOUNT_CODE IS '계정코드';
--COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.COST_CENTER_ID IS '원가ID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.ACCOUNT_DR_CR IS '차대구분(1-차, 2-대)';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.CUSTOMER_ID IS '거래처ID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.GL_AMOUNT IS '발생금액';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.GL_CURRENCY_AMOUNT IS '외화금액';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.REFER_DATE1 IS '관리일자1';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.REFER_DATE2 IS '관리일자2';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_LINE.REMARK IS '적요';

CREATE UNIQUE INDEX FI_UNLIQUIDATE_LINE_PK ON 
  FI_UNLIQUIDATE_LINE(SLIP_LINE_ID, SOB_ID, LIQUIDATE_SLIP_LINE_ID)
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

ALTER TABLE FI_UNLIQUIDATE_LINE ADD ( 
  CONSTRAINT FI_UNLIQUIDATE_LINE_PK PRIMARY KEY ( SLIP_LINE_ID, SOB_ID, LIQUIDATE_SLIP_LINE_ID ) 
        );
        
CREATE INDEX FI_UNLIQUIDATE_LINE_N1 ON FI_UNLIQUIDATE_LINE(SOB_ID, GL_DATE, GL_NUM) TABLESPACE FCM_TS_IDX;
