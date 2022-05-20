/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_SLIP_HEADER_INTERFACE
/* Description  : 전표 헤더 정보.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_SLIP_HEADER_INTERFACE
( HEADER_INTERFACE_ID             NUMBER        NOT NULL,
  SLIP_DATE                       DATE          NOT NULL,      -- 기표일자.
  SLIP_NUM                        VARCHAR2(30)  NOT NULL,      -- 기표번호.
  SOB_ID                          NUMBER        NOT NULL,
  ORG_ID                          NUMBER        NOT NULL,
  DEPT_ID                         NUMBER        NOT NULL,      -- 발의부서.
  PERSON_ID                       NUMBER        NOT NULL,      -- 발의자.
  BUDGET_DEPT_ID                  NUMBER        ,              -- 예산 부서.
  ACCOUNT_BOOK_ID                 NUMBER        NOT NULL,      -- 회계장부ID.
  SLIP_TYPE                       VARCHAR2(10)  NOT NULL,      -- 전표유형.
  JOURNAL_HEADER_ID               NUMBER        DEFAULT 0,     -- 자동분개유형 ID.
  GL_DATE                         DATE          ,
  GL_NUM                          VARCHAR2(30)  ,
  GL_AMOUNT                       NUMBER        DEFAULT 0,     -- 전표금액.  
  CURRENCY_CODE                   VARCHAR2(10)  ,              -- 통화.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,     -- 환율.
  GL_CURRENCY_AMOUNT              NUMBER        DEFAULT 0,     -- 통화금액.  
  REQ_BANK_ACCOUNT_ID             NUMBER        ,              -- 은행계좌 ID
  REQ_PAYABLE_TYPE                VARCHAR2(10)  ,              -- 지급요청방법(현금, 어음...).
  REQ_PAYABLE_DATE                DATE          ,              -- 지급요청일
  REMARK                          VARCHAR2(150) ,              -- 적요
  SUB_REMARK                      VARCHAR2(150) ,              -- 금액 커맨트.
  SUBSTANCE                       NVARCHAR2(2000),             -- 내용.
  TRANSFER_YN                     CHAR(1)       DEFAULT 'N',   -- 분개 전송Y/N.
  TRANSFER_DATE                   DATE          ,              -- 분개 전송일자.
  TRANSFER_PERSON_ID              NUMBER        ,              -- 분개 전송처리자.
  CONFIRM_YN                      CHAR(1)       DEFAULT 'N',   -- 승인여부.
  CONFIRM_DATE                    DATE          ,              -- 승인일자.
  CONFIRM_PERSON_ID               NUMBER        ,              -- 승인자.    
  SOURCE_TABLE                    VARCHAR2(100) ,
  SOURCE_HEADER_ID                NUMBER        ,
  ATTRIUTE_A                      VARCHAR2(100) ,
  ATTRIUTE_B                      VARCHAR2(100) ,
  ATTRIUTE_C                      VARCHAR2(100) ,
  ATTRIUTE_D                      VARCHAR2(100) ,
  ATTRIUTE_E                      VARCHAR2(100) ,
  ATTRIUTE_1                      NUMBER        ,
  ATTRIUTE_2                      NUMBER        ,
  ATTRIUTE_3                      NUMBER        ,
  ATTRIUTE_4                      NUMBER        ,
  ATTRIUTE_5                      NUMBER        ,
  CREATION_DATE                   DATE          NOT NULL,      -- 생성자
  CREATED_BY                      NUMBER        NOT NULL,      -- 생성일
  LAST_UPDATE_DATE                DATE          NOT NULL,      -- 수정자
  LAST_UPDATED_BY                 NUMBER        NOT NULL       -- 수정일
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE FI_SLIP_HEADER_INTERFACE IS '전표 인터페이스 HEADER';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.HEADER_INTERFACE_ID IS '전표 헤더 인터페이스 ID';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.SLIP_DATE IS '기표일자';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.SLIP_NUM IS '기표번호';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.DEPT_ID IS '발의부서';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.PERSON_ID IS '발의자';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.BUDGET_DEPT_ID IS '예산부서';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.ACCOUNT_BOOK_ID IS '회계장부ID';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.SLIP_TYPE IS '전표유형';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.JOURNAL_HEADER_ID IS '자동분개유형ID';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.GL_AMOUNT IS '전표 금액';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.GL_CURRENCY_AMOUNT IS '통화금액';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.REQ_BANK_ACCOUNT_ID IS '공급사 은행계좌';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.REQ_PAYABLE_TYPE IS '지급 요청방법(현금, 어음...)';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.REQ_PAYABLE_DATE IS '지급 요청일';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.REMARK IS '적요';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.SUB_REMARK IS '금액 내용';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.SUBSTANCE IS '내용';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.TRANSFER_YN IS '분개 전송 Y/N';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.TRANSFER_DATE IS '분개 전송일자';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.TRANSFER_PERSON_ID IS '분개 전송처리자';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.CONFIRM_YN IS '승인여부';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.CONFIRM_DATE IS '승인일자';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.CONFIRM_PERSON_ID IS '승인처리자';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.SOURCE_TABLE IS 'INTERFACE 소스테이블';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.SOURCE_HEADER_ID IS 'INTERFACE 소스 HEADER ID';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.CREATION_DATE IS '생성자';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.CREATED_BY IS '생성일';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.LAST_UPDATE_DATE IS '수정자';
COMMENT ON COLUMN APPS.FI_SLIP_HEADER_INTERFACE.LAST_UPDATED_BY IS '수정일';

-- PRIMARY KEY
CREATE UNIQUE INDEX FI_SLIP_HEADER_INTERFACE_PK ON 
  FI_SLIP_HEADER_INTERFACE(HEADER_INTERFACE_ID)
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

ALTER TABLE FI_SLIP_HEADER_INTERFACE ADD ( 
  CONSTRAINT FI_SLIP_HEADER_INTERFACE_PK PRIMARY KEY ( HEADER_INTERFACE_ID ) 
        );
        
-- UNIQUE INDEX.
CREATE UNIQUE INDEX FI_SLIP_HEADER_INTERFACE_U1 ON FI_SLIP_HEADER_INTERFACE(SOB_ID, SLIP_NUM) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_HEADER_INTERFACE_N1 ON FI_SLIP_HEADER_INTERFACE(SOB_ID, SLIP_DATE) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE FI_SLIP_HEADER_INTERFACE_S1;
       
