/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_MANAGEMENT_BALANCE_GT
/* Description  : 계정별 관리항목별 일자별 금액.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE GLOBAL TEMPORARY TABLE FI_MANAGEMENT_BALANCE_GT
( GL_DATE                     DATE          NOT NULL,  -- 회계일자.
  GL_DATE_SEQ                 NUMBER        DEFAULT 1,  -- 일자일련번호.
  SOB_ID                      NUMBER        NOT NULL,  -- 회사코드.
  ACCOUNT_CONTROL_ID          NUMBER        NOT NULL,  -- 계정관리ID. 
  ACCOUNT_CODE                VARCHAR2(20)  ,
  MANAGEMENT_ID               NUMBER        NOT NULL,  -- 관리항목 ID.    
  MANAGEMENT_CODE             VARCHAR2(10)  ,
  MANAGEMENT_VALUE            VARCHAR2(50)  NOT NULL,  -- 관리항목 값.
  DR_SUM                      NUMBER        DEFAULT 0, -- 차변합계.
  CR_SUM                      NUMBER        DEFAULT 0, -- 대변합계.
  REMAIN_SUM                  NUMBER        DEFAULT 0, -- 잔액  
  CURRENCY_CODE               VARCHAR2(10)  ,          -- 통화.
  DR_CURR_SUM                 NUMBER        DEFAULT 0, -- 차변(외화)합계.
  CR_CURR_SUM                 NUMBER        DEFAULT 0, -- 대변(외화)합계.
  REMAIN_CURR_SUM             NUMBER        DEFAULT 0, -- 잔액(외화).
  REMARK                      VARCHAR2(200)
) ON COMMIT PRESERVE ROWS;

CREATE INDEX FI_MANAGEMENT_BALANCE_GT_N1 ON FI_MANAGEMENT_BALANCE_GT(GL_DATE, GL_DATE_SEQ, SOB_ID, ACCOUNT_CONTROL_ID, MANAGEMENT_ID);
