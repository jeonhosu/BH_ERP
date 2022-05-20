/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_SLIP_HEADER
/* Description  : 전표 헤더 정보.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_SLIP_HEADER 
( SLIP_HEADER_ID                  NUMBER        NOT NULL,
  SLIP_DATE                       DATE          NOT NULL,      -- 기표일자.
  SLIP_NUM                        VARCHAR2(30)  NOT NULL,      -- 기표번호.
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  DEPT_ID                         NUMBER        NOT NULL,      -- 발의부서.
  PERSON_ID                       NUMBER        NOT NULL,      -- 발의자.
  BUDGET_DEPT_ID                  NUMBER        ,              -- 예산 부서.
  ACCOUNT_BOOK_ID                 NUMBER        NOT NULL,      -- 회계장부ID.
  SLIP_TYPE                       VARCHAR2(10)  NOT NULL,      -- 전표유형.
  PERIOD_NAME                     VARCHAR2(10)  NOT NULL,      -- 회계년월.
  CONFIRM_YN                      CHAR(1)       DEFAULT 'N',   -- 승인여부.
  CONFIRM_DATE                    DATE          ,              -- 승인일자.
  CONFIRM_PERSON_ID               NUMBER        ,              -- 승인자.  
  CHANGE_COUNT                    NUMBER(3)     ,              -- 전표수정 차수.
  GL_DATE                         DATE          ,              -- 회계일자.
  GL_NUM                          VARCHAR2(30)  ,              -- 회계번호  
  GL_AMOUNT                       NUMBER        DEFAULT 0,     -- 전표금액.  
  CURRENCY_CODE                   VARCHAR2(10)  ,              -- 통화.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,     -- 환율.
  GL_CURRENCY_AMOUNT              NUMBER        DEFAULT 0,     -- 통화금액.  
  REQ_BANK_ACCOUNT_ID             NUMBER        ,              -- 은행계좌 ID
  REQ_PAYABLE_TYPE                VARCHAR2(10)  ,              -- 지급요청방법(현금, 어음...).
  REQ_PAYABLE_DATE                DATE          ,              -- 지급요청일
  REMARK                          VARCHAR2(150) ,              -- 적요
  CLOSED_YN                       CHAR(1)       DEFAULT 'N',   -- 승인여부.
  CLOSED_DATE                     DATE          ,              -- 승인일자.
  CLOSED_PERSON_ID                NUMBER        ,              -- 승인자.
  CREATED_TYPE                    VARCHAR2(50)  DEFAULT 'M',   -- 생성 구분
  SOURCE_TABLE                    VARCHAR2(100) ,       
  SOURCE_HEADER_ID                NUMBER        ,
  CREATION_DATE                   DATE          NOT NULL,      -- 생성자
  CREATED_BY                      NUMBER        NOT NULL,      -- 생성일
  LAST_UPDATE_DATE                DATE          NOT NULL,      -- 수정자
  LAST_UPDATED_BY                 NUMBER        NOT NULL       -- 수정일
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_SLIP_HEADER IS '전표 HEADER';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.SLIP_HEADER_ID IS '전표 헤더 ID';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.SLIP_DATE IS '기표일자';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.SLIP_NUM IS '기표번호';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.DEPT_ID IS '발의부서';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.PERSON_ID IS '발의자';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.BUDGET_DEPT_ID IS '예산부서';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.ACCOUNT_BOOK_ID IS '회계장부ID';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.SLIP_TYPE IS '전표유형';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.PERIOD_NAME IS '회계년월';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.CONFIRM_YN IS '승인여부';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.CONFIRM_DATE IS '승인일자';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.CONFIRM_PERSON_ID IS '승인처리자';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.CHANGE_COUNT IS '수정횟수';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.GL_DATE IS '회계일자';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.GL_NUM IS '회계번호';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.GL_AMOUNT IS '전표 금액';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.GL_CURRENCY_AMOUNT IS '통화금액';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.REQ_BANK_ACCOUNT_ID IS '공급사 은행계좌';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.REQ_PAYABLE_TYPE IS '지급 요청방법(현금, 어음...)';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.REQ_PAYABLE_DATE IS '지급 요청일';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.REMARK IS '적요';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.CLOSED_YN IS '마감여부';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.CLOSED_DATE IS '마감일자';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.CLOSED_PERSON_ID IS '마감처리자';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.CREATED_TYPE IS '생성구분(M:메뉴얼, I:INTERFACE)';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.SOURCE_TABLE IS 'INTERFACE 소스테이블';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.SOURCE_HEADER_ID IS 'INTERFACE 소스 HEADER ID';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.CREATION_DATE IS '생성자';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.CREATED_BY IS '생성일';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.LAST_UPDATE_DATE IS '수정자';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER.LAST_UPDATED_BY IS '수정일';

-- PRIMARY KEY
CREATE UNIQUE INDEX FI_SLIP_HEADER_PK ON 
  FI_SLIP_HEADER(SLIP_HEADER_ID)
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

ALTER TABLE FI_SLIP_HEADER ADD ( 
  CONSTRAINT FI_SLIP_HEADER_PK PRIMARY KEY ( SLIP_HEADER_ID ) 
        );
        
-- UNIQUE INDEX.
CREATE UNIQUE INDEX FI_SLIP_HEADER_U1 ON FI_SLIP_HEADER(SOB_ID, SLIP_NUM) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX FI_SLIP_HEADER_U2 ON FI_SLIP_HEADER(SOB_ID, GL_NUM) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_HEADER_N1 ON FI_SLIP_HEADER(SOB_ID, SLIP_DATE, SLIP_NUM) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_HEADER_N2 ON FI_SLIP_HEADER(SOB_ID, GL_DATE, GL_NUM) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
DROP SEQUENCE FI_SLIP_HEADER_S1;
CREATE SEQUENCE FI_SLIP_HEADER_S1;
       
