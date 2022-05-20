/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_SLIP_EXCEL_UPLOAD
/* Description  : 전표 EXCEL UPLOAD 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_SLIP_EXCEL_UPLOAD
( SLIP_DATE                       DATE          NOT NULL,      -- 기표일자.
  SLIP_NUM                        VARCHAR2(30)  NOT NULL,      -- 기표번호.
  SLIP_LINE_SEQ                   NUMBER        NOT NULL,      -- 기표행번호.
  SLIP_HEADER_ID                  NUMBER        ,              -- 전표 HEADER ID.    
  SOB_ID                          NUMBER        NOT NULL,      -- 회계조직.
  ORG_ID                          NUMBER        NOT NULL,      -- 사업부ID.  
  DEPT_CODE                       VARCHAR2(50)  ,              -- 발의부서.
  PERSON_NUM                      VARCHAR2(20)  ,              -- 사원번호.
  BUDGET_DEPT_CODE                VARCHAR2(50)  ,              -- 예산 부서.
  SLIP_TYPE                       VARCHAR2(10)  NOT NULL,      -- 전표유형.
  GL_DATE                         DATE          ,              -- 전표일자.
  GL_NUM                          VARCHAR2(30)  ,              -- 전표번호.
  HEADER_REMARK                   VARCHAR2(100) ,              -- 헤더 적요.
  ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL,      -- 계정코드.
  ACCOUNT_DESC                    VARCHAR2(200) ,              -- 계정명.
  ACCOUNT_DR_CR                   VARCHAR2(2)   NOT NULL,      -- 차/대.
  GL_AMOUNT                       NUMBER        DEFAULT 0,     -- 금액.
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
  SLIP_YN                         VARCHAR2(1)   DEFAULT 'N',    -- 전표생성여부.
  SLIP_PERSON_ID                  NUMBER        ,               -- 전표생성자. 
  USER_ID                         NUMBER        ,               -- 작업자ID.
  CREATED_DATE                    DATE          ,               
  ATTRIBUTE_A                     VARCHAR2(100) ,
  ATTRIBUTE_B                     VARCHAR2(100) ,
  ATTRIBUTE_C                     VARCHAR2(100) ,
  ATTRIBUTE_D                     VARCHAR2(100) ,
  ATTRIBUTE_E                     VARCHAR2(100) ,
  ATTRIBUTE_1                     NUMBER        ,
  ATTRIBUTE_2                     NUMBER        ,
  ATTRIBUTE_3                     NUMBER        ,
  ATTRIBUTE_4                     NUMBER        ,
  ATTRIBUTE_5                     NUMBER
) TABLESPACE FCM_TS_DATA;

COMMENT ON TABLE  FI_SLIP_EXCEL_UPLOAD IS '회계전표(GL) 업로드 관리 테이블';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.SLIP_DATE IS '기표일자';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.SLIP_NUM IS '기표번호';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.SLIP_LINE_SEQ IS '전표 라인번호';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.SLIP_HEADER_ID IS '전표 헤더 ID';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.DEPT_CODE IS '발의부서';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.PERSON_NUM IS '발의자';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.BUDGET_DEPT_CODE IS '예산부서';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.SLIP_TYPE IS '전표유형';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.HEADER_REMARK IS '헤더 적요';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.ACCOUNT_DR_CR  IS '차대구분(0-차, 1-대)';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.GL_AMOUNT IS '전표 금액';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.CURRENCY_CODE IS '통화';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.EXCHANGE_RATE IS '환율';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.GL_CURRENCY_AMOUNT IS '외화금액';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.MANAGEMENT1 IS '잔액관리항목1';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.MANAGEMENT2 IS '잔액관리항목2';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.REFER1 IS '참고항목1~12';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.VOUCH_CODE IS '증빙코드';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.REFER_RATE IS '관리율';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.REFER_AMOUNT IS '관리금액';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.REFER_DATE1 IS '관리일자1';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.REFER_DATE2 IS '관리일자2';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.REMARK IS '적요';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.FUND_CODE IS '자금코드';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.SLIP_YN IS '전표생성 여부';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.SLIP_PERSON_ID IS '전표생성 처리자';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.SLIP_YN IS '전표라인 구분';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.USER_ID IS '작업자 ID';
COMMENT ON COLUMN APPS.FI_SLIP_EXCEL_UPLOAD.CREATED_DATE IS '작업자 일시';
