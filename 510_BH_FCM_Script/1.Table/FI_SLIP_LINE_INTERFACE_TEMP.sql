/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_SLIP_LINE_INTERFACE_TEMP
/* Description  : 전표 라인 인터페이스 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_SLIP_LINE_INTERFACE_TEMP
( SLIP_DATE                       DATE          NOT NULL,      -- 기표일자.
  SLIP_NUM                        VARCHAR2(30)  ,              -- 기표번호.
  SLIP_LINE_SEQ                   NUMBER        NOT NULL,      -- 기표행번호.
  HEADER_INTERFACE_ID             NUMBER        ,              -- 전표 HEADER 인터페이스 ID.    
  SOB_ID                          NUMBER        NOT NULL,      -- 회계조직.
  ORG_ID                          NUMBER        NOT NULL,      -- 사업부ID.  
  DEPT_ID                         NUMBER        ,              -- 발의부서.
  PERSON_ID                       NUMBER        ,              -- 발의자.
  BUDGET_DEPT_ID                  NUMBER        ,              -- 예산 부서.  
  PERSON_NUM                      VARCHAR2(20)  ,              -- 사원번호.
  ACCOUNT_BOOK_ID                 NUMBER        ,              -- 회계장부ID.
  SLIP_TYPE                       VARCHAR2(10)  NOT NULL,      -- 전표유형.
  JOURNAL_HEADER_ID               NUMBER        DEFAULT 0,     -- 자동분개유형 ID.
  ACCOUNT_CONTROL_ID              NUMBER        ,       
  ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL,
  ACCOUNT_DESC                    VARCHAR2(200) ,
  ACCOUNT_DR_CR                   VARCHAR2(2)   NOT NULL,     
  GL_AMOUNT                       NUMBER        DEFAULT 0, 
  CURRENCY_CODE                   VARCHAR2(10)  NOT NULL,      -- 통화.
  EXCHANGE_RATE                   NUMBER        DEFAULT 0,     -- 환율.
  GL_CURRENCY_AMOUNT              NUMBER        DEFAULT 0,     -- 외화금액.
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
  REFER10                         VARCHAR2(50)  ,               -- 참고항목코드10.
  REFER11                         VARCHAR2(50)  ,               -- 참고항목코드11.
  REFER12                         VARCHAR2(50)  ,               -- 참고항목코드12.  
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
  ATTRIUTE_5                      NUMBER
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE  FI_SLIP_LINE_INTERFACE_TEMP IS '회계전표(GL) LINE INTERFACE';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.SLIP_DATE IS '기표일자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.SLIP_NUM IS '기표번호';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.SLIP_LINE_SEQ IS '전표 라인번호';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.HEADER_INTERFACE_ID IS '전표 헤더 인터페이스 ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.DEPT_ID IS '발의부서';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.PERSON_ID IS '발의자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.BUDGET_DEPT_ID IS '예산부서';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.PERSON_NUM IS '사원번호';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.ACCOUNT_BOOK_ID IS '회계장부';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.SLIP_TYPE IS '전표유형';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.JOURNAL_HEADER_ID IS '자동분개유형 ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.ACCOUNT_CONTROL_ID IS '계정통제ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.ACCOUNT_DR_CR  IS '차대구분(0-차, 1-대)';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.GL_AMOUNT IS '전표 금액';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.GL_CURRENCY_AMOUNT IS '외화금액';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.MANAGEMENT1 IS '잔액관리항목1';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.MANAGEMENT2 IS '잔액관리항목2';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.REFER1 IS '참고항목1~9';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.VOUCH_CODE IS '증빙코드';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.REFER_RATE IS '관리율';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.REFER_AMOUNT IS '관리금액';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.REFER_DATE1 IS '관리일자1';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.REFER_DATE2 IS '관리일자2';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.REMARK IS '적요';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.TRANSFER_YN IS '분개 전송 Y/N';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.TRANSFER_DATE IS '분개 전송일자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.TRANSFER_PERSON_ID IS '분개 전송처리자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.CONFIRM_YN IS '승인여부';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.CONFIRM_DATE IS '승인일자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.CONFIRM_PERSON_ID IS '승인처리자';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.SOURCE_TABLE IS 'INTERFACE 소스테이블';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.SOURCE_HEADER_ID IS 'INTERFACE 소스 HEADER ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.SOURCE_LINE_ID IS 'INTERFACE 소스 LINE ID';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.FUND_CODE IS '자금코드';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.UNIT_PRICE IS '단가';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.UOM_CODE IS '단위';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.UOM_QUANTITY IS '수량';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.UOM_WEIGHT IS '중량';
COMMENT ON COLUMN APPS.FI_SLIP_LINE_INTERFACE_TEMP.INVENTORY_ITEM_ID IS 'Inventory Item ID';
          
CREATE INDEX FI_SLIP_LINE_INTERFACE_TEMP_N1 ON FI_SLIP_LINE_INTERFACE_TEMP(SOB_ID, SLIP_NUM) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_LINE_INTERFACE_TEMP_N2 ON FI_SLIP_LINE_INTERFACE_TEMP(SOB_ID, SLIP_DATE) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_SLIP_LINE_INTERFACE_TEMP_N3 ON FI_SLIP_LINE_INTERFACE_TEMP(HEADER_INTERFACE_ID) TABLESPACE FCM_TS_IDX;
