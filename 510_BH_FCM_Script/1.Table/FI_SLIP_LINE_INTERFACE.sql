/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_SLIP_LINE_INTERFACE
/* Description  : 전표 라인 인터페이스 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_SLIP_LINE_INTERFACE 
( LINE_INTERFACE_ID               NUMBER        NOT NULL,      -- 전표 라인 인터페이스 ID.
  SLIP_DATE                       DATE          NOT NULL,      -- 기표일자.
  SLIP_NUM                        VARCHAR2(30)  NOT NULL,      -- 기표번호.
  SLIP_LINE_SEQ                   NUMBER        NOT NULL,      -- 기표행번호.
  HEADER_INTERFACE_ID             NUMBER        NOT NULL,      -- 전표 HEADER 인터페이스 ID.    
  SOB_ID                          NUMBER        NOT NULL,      -- 회계조직.
  ORG_ID                          NUMBER        NOT NULL,      -- 사업부ID.  
  DEPT_ID                         NUMBER        NOT NULL,      -- 발의부서.
  PERSON_ID                       NUMBER        NOT NULL,      -- 발의자.
  BUDGET_DEPT_ID                  NUMBER        ,              -- 예산 부서.  
  ACCOUNT_BOOK_ID                 NUMBER        NOT NULL,      -- 회계장부ID.
  SLIP_TYPE                       VARCHAR2(10)  NOT NULL,      -- 전표유형.
  JOURNAL_HEADER_ID               NUMBER        DEFAULT 0,     -- 자동분개유형 ID.
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
  REFER9                          VARCHAR2(50)  ,               -- 참고항목코드9.
  VOUCH_CODE                      VARCHAR2(50)  ,               -- 증빙서류 ID.
  REFER_RATE                      NUMBER        ,               -- 관리율코드.
  REFER_AMOUNT                    NUMBER        ,               -- 관리금액코드.
  REFER_DATE1                     DATE          ,               -- 관리일자코드1.
  REFER_DATE2                     DATE          ,               -- 관리일자코드2 .   
  REMARK                          VARCHAR2(100) ,               -- 적요.
  FUND_CODE                       VARCHAR2(10)  ,               -- 자금코드(FUND_CODE).
  UNIT_PRICE                      NUMBER        DEFAULT 0,      -- 단가.
  UOM_CODE                        VARCHAR2(10)  ,               -- UOM.
  UOM_QUANTITY                    NUMBER        DEFAULT 0,      -- 수량.
  UOM_WEIGHT                      NUMBER        DEFAULT 0,      -- 중량.
  INVENTORY_ITEM_ID               NUMBER        ,               -- INTEM ID.
  TRANSFER_YN                     CHAR(1)       DEFAULT 'N',    -- 분개 전송Y/N.
  TRANSFER_DATE                   DATE          ,               -- 분개 전송일자.
  TRANSFER_PERSON_ID              NUMBER        ,               -- 분개 전송처리자.
  CONFIRM_YN                      CHAR(1)       DEFAULT 'N',    -- 승인여부.
  CONFIRM_DATE                    DATE          ,               -- 승인일자.
  CONFIRM_PERSON_ID               NUMBER        ,               -- 승인자.    
  SOURCE_TABLE                    VARCHAR2(100) ,
  SOURCE_HEADER_ID                NUMBER        ,
  SOURCE_LINE_ID                  NUMBER        ,  
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
  CREATION_DATE                   DATE          NOT NULL,      -- 생성자.
  CREATED_BY                      NUMBER        NOT NULL,      -- 생성일.
  LAST_UPDATE_DATE                DATE          NOT NULL,      -- 수정자.
  LAST_UPDATED_BY                 NUMBER        NOT NULL       -- 수정일.
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE  FI_SLIP_LINE_INTERFACE IS '전표 LINE INTERFACE';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.LINE_INTERFACE_ID IS '전표 라인 ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.SLIP_DATE IS '기표일자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.SLIP_NUM IS '기표번호';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.SLIP_LINE_SEQ IS '전표 라인번호';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.HEADER_INTERFACE_ID IS '전표 헤더 인터페이스 ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.DEPT_ID IS '발의부서';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.PERSON_ID IS '발의자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.BUDGET_DEPT_ID IS '예산부서';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.ACCOUNT_BOOK_ID IS '회계장부';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.SLIP_TYPE IS '전표유형';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.JOURNAL_HEADER_ID IS '자동분개유형 ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.CUSTOMER_ID IS '거래처ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.ACCOUNT_CONTROL_ID IS '계정통제ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.COST_CENTER_ID IS '원가코드';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.ACCOUNT_DR_CR  IS '차대구분(0-차, 1-대)';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.GL_AMOUNT IS '전표 금액';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.GL_CURRENCY_AMOUNT IS '외화금액';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.BANK_ACCOUNT_ID IS '계좌ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.MANAGEMENT1 IS '잔액관리항목1';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.MANAGEMENT2 IS '잔액관리항목2';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.REFER1 IS '참고항목1~9';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.VOUCH_CODE IS '증빙코드';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.REFER_RATE IS '관리율';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.REFER_AMOUNT IS '관리금액';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.REFER_DATE1 IS '관리일자1';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.REFER_DATE2 IS '관리일자2';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.REMARK IS '적요';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.TRANSFER_YN IS '분개 전송 Y/N';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.TRANSFER_DATE IS '분개 전송일자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.TRANSFER_PERSON_ID IS '분개 전송처리자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.CONFIRM_YN IS '승인여부';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.CONFIRM_DATE IS '승인일자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.CONFIRM_PERSON_ID IS '승인처리자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.SOURCE_TABLE IS 'INTERFACE 소스테이블';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.SOURCE_HEADER_ID IS 'INTERFACE 소스 HEADER ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.SOURCE_LINE_ID IS 'INTERFACE 소스 LINE ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.FUND_CODE IS '자금코드';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.UNIT_PRICE IS '단가';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.UOM_CODE IS '단위';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.UOM_QUANTITY IS '수량';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.UOM_WEIGHT IS '중량';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.INVENTORY_ITEM_ID IS 'Inventory Item ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.CREATION_DATE IS '생성자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.CREATED_BY IS '생성일';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.LAST_UPDATE_DATE IS '수정자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE.LAST_UPDATED_BY IS '수정일';

CREATE UNIQUE INDEX FI_SLIP_LINE_INTERFACE_PK ON 
  FI_SLIP_LINE_INTERFACE(LINE_INTERFACE_ID)
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
          
ALTER TABLE FI_SLIP_LINE_INTERFACE ADD ( 
  CONSTRAINT FI_SLIP_LINE_INTERFACE_PK PRIMARY KEY (LINE_INTERFACE_ID)
          );
          
CREATE INDEX FI_SLIP_LINE_INTERFACE_N1 ON FI_SLIP_LINE_INTERFACE(SOB_ID, SLIP_NUM) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_LINE_INTERFACE_N2 ON FI_SLIP_LINE_INTERFACE(SOB_ID, SLIP_DATE) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_LINE_INTERFACE_N3 ON FI_SLIP_LINE_INTERFACE(HEADER_INTERFACE_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE FI_SLIP_LINE_INTERFACE_S1;
       
