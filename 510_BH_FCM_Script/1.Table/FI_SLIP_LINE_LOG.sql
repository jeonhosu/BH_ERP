/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_SLIP_LINE_LOG
/* Description  : 전표 라인 로그 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_SLIP_LINE_LOG 
( SLIP_LINE_ID                    NUMBER        NOT NULL,      -- 전표 라인ID.
  SLIP_DATE                       DATE          NOT NULL,      -- 기표일자.
  SLIP_NUM                        VARCHAR2(30)  NOT NULL,      -- 기표번호.
  SLIP_LINE_SEQ                   NUMBER        NOT NULL,      -- 기표행번호.
  SLIP_HEADER_ID                  NUMBER        NOT NULL,      -- 전표 HEADER ID.    
  SOB_ID                          NUMBER        NOT NULL,      -- 회계조직.
  ORG_ID                          NUMBER        NOT NULL,      -- 사업부ID.  
  DEPT_ID                         NUMBER        NOT NULL,      -- 발의부서.
  PERSON_ID                       NUMBER        NOT NULL,      -- 발의자.
  BUDGET_DEPT_ID                  NUMBER        ,              -- 예산 부서.  
  ACCOUNT_BOOK_ID                 NUMBER        NOT NULL,      -- 회계장부ID.
  SLIP_TYPE                       VARCHAR2(10)  NOT NULL,      -- 전표유형.
  PERIOD_NAME                     VARCHAR2(10)  NOT NULL,      -- 회계년월.
  CONFIRM_YN                      CHAR(1)       DEFAULT 'N',   -- 승인여부.
  CONFIRM_DATE                    DATE          ,              -- 승인일자.
  CONFIRM_PERSON_ID               NUMBER        ,              -- 승인자.  
  GL_DATE                         DATE          ,              -- 회계일자.
  GL_NUM                          VARCHAR2(30)  ,              -- 회계번호.
  CUSTOMER_ID                     NUMBER        ,              -- 거래처ID
  ACCOUNT_CONTROL_ID              NUMBER        NOT NULL,       
  ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL,      
  COST_CENTER_ID                  NUMBER        ,     
  ACCOUNT_DR_CR                   VARCHAR2(2)   NOT NULL,     
  GL_AMOUNT                       NUMBER        DEFAULT 0, 
  CURRENCY_CODE                   VARCHAR2(10)  ,              -- 통화.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,     -- 환율.
  GL_CURRENCY_AMOUNT              NUMBER        DEFAULT 0,     -- 외화금액.
  BANK_ACCOUNT_ID                 NUMBER        ,              -- 계좌ID.
  MANAGEMENT1                     VARCHAR2(50)  ,               -- 잔액관리항목코드1.
  MANAGEMENT2                     VARCHAR2(50)  ,               -- 잔액관리항목코드2.
  REFER1                          VARCHAR2(50)  ,               -- 참고항목코드1.
  REFER2                          VARCHAR2(50)  ,               -- 참고항목코드2.
  REFER3                          VARCHAR2(50)  ,               -- 참고항목코드3.
  REFER4                          VARCHAR2(50)  ,               -- 참고항목코드4.
  REFER5                          VARCHAR2(50)  ,               -- 참고항목코드5.
  REFER6                          VARCHAR2(50)  ,               -- 참고항목코드6.
  REFER7                          VARCHAR2(50)  ,               -- 참고항목코드7.
  REFER8                          VARCHAR2(50)  ,               -- 참고항목코드8.
  REFER9                          VARCHAR2(50)  ,              -- 참고항목코드9.
  VOUCH_CODE                      VARCHAR2(50)  ,               -- 증빙서류 ID.
  REFER_RATE                      NUMBER        ,              -- 관리율코드.
  REFER_AMOUNT                    NUMBER        ,              -- 관리금액코드.
  REFER_DATE1                     DATE          ,              -- 관리일자코드1.
  REFER_DATE2                     DATE          ,              -- 관리일자코드2 .   
  REMARK                          VARCHAR2(100) ,              -- 적요.
  UNLIQUIDATE_SLIP_HEADER_ID      NUMBER        ,
  UNLIQUIDATE_SLIP_LINE_ID        NUMBER        ,
  FUND_CODE                       VARCHAR2(10)  ,              -- 자금코드(FUND_CODE).
  LINE_TYPE                       VARCHAR2(10)  ,  
  CLOSED_YN                       CHAR(1)       DEFAULT 'N',   -- 승인여부.
  CLOSED_DATE                     DATE          ,              -- 승인일자.
  CLOSED_PERSON_ID                NUMBER        ,              -- 승인자.
  SOURCE_TABLE                    VARCHAR2(100) ,
  SOURCE_HEADER_ID                NUMBER        ,
  SOURCE_LINE_ID                  NUMBER        ,  
  CREATION_DATE                   DATE          NOT NULL,      -- 생성자.
  CREATED_BY                      NUMBER        NOT NULL,      -- 생성일.
  LAST_UPDATE_DATE                DATE          NOT NULL,      -- 수정자.
  LAST_UPDATED_BY                 NUMBER        NOT NULL       -- 수정일.
  DELETED_DATE                    DATE          ,
  DELETED_BY                      NUMBER        
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE  FI_SLIP_LINE_LOG IS '회계전표(GL) LINE 삭제 로그';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.SLIP_LINE_ID IS '전표 라인 ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.SLIP_DATE IS '기표일자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.SLIP_NUM IS '기표번호';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.SLIP_LINE_SEQ IS '전표 라인번호';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.SLIP_HEADER_ID IS '전표 헤더 ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.DEPT_ID IS '발의부서';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.PERSON_ID IS '발의자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.BUDGET_DEPT_ID IS '예산부서';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.ACCOUNT_BOOK_ID IS '회계장부ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.SLIP_TYPE IS '전표유형';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.PERIOD_NAME IS '회계년월';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CONFIRM_YN IS '승인여부';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CONFIRM_DATE IS '승인일자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CONFIRM_PERSON_ID IS '승인처리자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.GL_DATE IS '회계일자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.GL_NUM IS '회계번호';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CUSTOMER_ID IS '거래처ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.ACCOUNT_CONTROL_ID IS '계정통제ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.COST_CENTER_ID IS '원가코드';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.ACCOUNT_DR_CR  IS '차대구분(0-차, 1-대)';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.GL_AMOUNT IS '전표 금액';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.GL_CURRENCY_AMOUNT IS '외화금액';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.BANK_ACCOUNT_ID IS '계좌ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.MANAGEMENT1 IS '잔액관리항목1';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.MANAGEMENT2 IS '잔액관리항목2';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.REFER1 IS '참고항목1~9';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.VOUCH_CODE IS '증빙코드';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.REFER_RATE IS '관리율';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.REFER_AMOUNT IS '관리금액';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.REFER_DATE1 IS '관리일자1';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.REFER_DATE2 IS '관리일자2';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.REMARK IS '적요';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.UNLIQUIDATE_SLIP_HEADER_ID IS '미청산 전표HEADER ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.UNLIQUIDATE_SLIP_LINE_ID IS '미청산 전표LINE ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.FUND_CODE IS '자금코드';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CLOSED_YN IS '마감여부';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CLOSED_DATE IS '마감일자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CLOSED_PERSON_ID IS '마감처리자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.SOURCE_TABLE IS 'INTERFACE 소스테이블';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.SOURCE_HEADER_ID IS 'INTERFACE 소스 HEADER ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.SOURCE_LINE_ID IS 'INTERFACE 소스 LINE ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CREATION_DATE IS '생성자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.CREATED_BY IS '생성일';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.LAST_UPDATE_DATE IS '수정자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.LAST_UPDATED_BY IS '수정일';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.DELETED_DATE IS '삭제일시';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_LOG.DELETED_BY IS '삭제자';
          
CREATE INDEX FI_SLIP_LINE_LOG_N1 ON FI_SLIP_LINE_LOG(SLIP_DATE, SLIP_NUM, SLIP_LINE_SEQ, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_LINE_LOG_N2 ON FI_SLIP_LINE_LOG(SOB_ID, GL_DATE, GL_NUM) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_LINE_LOG_N3 ON FI_SLIP_LINE_LOG(SLIP_HEADER_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_LINE_LOG_N4 ON FI_SLIP_LINE_LOG(SLIP_LINE_ID) TABLESPACE FCM_TS_IDX;
       
