/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_UNLIQUIDATE_HEADER
/* Description  : 미청산 전표 발생표제
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_UNLIQUIDATE_HEADER
( SLIP_LINE_ID                    NUMBER        NOT NULL,      -- 전표 라인ID.  
  SOB_ID                          NUMBER        NOT NULL,      -- 회계조직.
  ORG_ID                          NUMBER        NOT NULL,      -- 사업부ID.
  PERIOD_NAME                     VARCHAR2(10)  NOT NULL,      -- 회계년월.
  GL_DATE                         DATE          ,              -- 회계일자.
  GL_NUM                          VARCHAR2(30)  ,              -- 회계번호
  ACCOUNT_BOOK_ID                 NUMBER        NOT NULL,      -- 회계장부ID.
  SLIP_TYPE                       VARCHAR2(10)  NOT NULL,      -- 전표유형.    
  ACCOUNT_CONTROL_ID              NUMBER        NOT NULL,       
  ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL,       
  ACCOUNT_DR_CR                   VARCHAR2(2)   NOT NULL,     
  CUSTOMER_ID                     NUMBER        ,              -- 거래처 ID
  GL_AMOUNT                       NUMBER        DEFAULT 0, 
  CURRENCY_CODE                   VARCHAR2(10)  ,
  OLD_EXCHANGE_RATE               NUMBER        DEFAULT 0,
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,     -- 환율.
  GL_CURRENCY_AMOUNT              NUMBER        DEFAULT 0,     -- 외화금액.
  MANAGEMENT1                     VARCHAR2(50)  ,
  MANAGEMENT2                     VARCHAR2(50)  ,
  REFER1                          VARCHAR2(50)  ,	             -- 참고항목1~9.      (추가)
  REFER2                          VARCHAR2(50)  ,
  REFER3                          VARCHAR2(50)  ,
  REFER4                          VARCHAR2(50)  ,
  REFER5                          VARCHAR2(50)  ,
  REFER6                          VARCHAR2(50)  ,
  REFER7                          VARCHAR2(50)  ,
  REFER8                          VARCHAR2(50)  ,
  REFER9                          VARCHAR2(50)  ,
  REFER_DATE1                     DATE          ,              -- 관리일자코드1.
  REFER_DATE2                     DATE          ,              -- 관리일자코드2.
  V_REMAIN_AMOUNT                 NUMBER        DEFAULT 0,     -- 미반영 잔액
  V_REMAIN_CURRENCY_AMOUNT        NUMBER        DEFAULT 0,     -- 미반영 외화잔액.  
  GL_REMAIN_AMOUNT                NUMBER        DEFAULT 0,     -- 잔액
  GL_REMAIN_CURRENCY_AMOUNT       NUMBER        DEFAULT 0,     -- 외화잔액.    
  REMARK                          VARCHAR2(150) ,              -- 적요.
  SLIP_STATUS                     VARCHAR2(5)   DEFAULT 'N',   -- N 미반제, P-부분, V-미반영 반제, C-완료.
  CREATION_DATE                   DATE          NOT NULL,   
  CREATED_BY                      NUMBER        NOT NULL,   
  LAST_UPDATE_DATE                DATE          NOT NULL,   
  LAST_UPDATED_BY                 NUMBER        NOT NULL      
) TABLESPACE FCM_TS_DATA ;

COMMENT ON TABLE FI_UNLIQUIDATE_HEADER IS '미청산전표표제';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.SLIP_LINE_ID IS '전표 라인 ID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.GL_DATE IS '회계일자';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.GL_NUM IS '회계 전표번호';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.ACCOUNT_BOOK_ID IS '회계장부';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.SLIP_TYPE IS '전표유형';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.ACCOUNT_CONTROL_ID IS '계정통제ID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.ACCOUNT_CODE IS '계정코드';
--COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.COST_CENTER_ID IS '원가ID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.ACCOUNT_DR_CR IS '차대구분(1-차, 2-대)';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.CUSTOMER_ID IS '거래처ID';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.GL_AMOUNT IS '발생금액';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.GL_CURRENCY_AMOUNT IS '외화금액';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.REFER_DATE1 IS '관리일자1';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.REFER_DATE2 IS '관리일자2';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.V_REMAIN_AMOUNT IS '미반영 잔액';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.V_REMAIN_CURRENCY_AMOUNT IS '미반영 외화잔액';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.GL_REMAIN_AMOUNT IS '잔액';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.GL_REMAIN_CURRENCY_AMOUNT IS '외화잔액';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.REMARK IS '적요';
COMMENT ON COLUMN APPS.FI_UNLIQUIDATE_HEADER.SLIP_STATUS IS 'N 미반제, P-부분, V-미반영 반제, C-완료';

CREATE UNIQUE INDEX FI_UNLIQUIDATE_HEADER_PK ON 
  FI_UNLIQUIDATE_HEADER(SLIP_LINE_ID)
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

ALTER TABLE FI_UNLIQUIDATE_HEADER ADD ( 
  CONSTRAINT FI_UNLIQUIDATE_HEADER_PK PRIMARY KEY ( SLIP_LINE_ID ) 
        );
        
-- UNIQUE INDEX.
CREATE INDEX FI_UNLIQUIDATE_HEADERE_N1 ON FI_UNLIQUIDATE_HEADER(SOB_ID, GL_DATE, GL_NUM) TABLESPACE FCM_TS_IDX;
