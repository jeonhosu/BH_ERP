/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BILL_MOVE
/* Description  : 어음 이동관리.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BILL_MOVE 
( BILL_NUM              VARCHAR2(30)  NOT NULL,       -- 어음번호.
  MOVE_SEQ              NUMBER        NOT NULL,       -- 일련번호.
  SOB_ID                NUMBER        NOT NULL,       
  ORG_ID                NUMBER        NOT NULL,
  MOVE_DATE             DATE          NOT NULL,       -- 변동일자.
  BILL_STATUS           VARCHAR2(10)  NOT NULL,       -- 어음상태.
  BILL_TYPE             VARCHAR2(10)  NOT NULL,       -- 어음종류(공통코드:BILL_TYPE,1:약속어음,2:가계수표,3:당좌수표,4:전자어음).
  DEPT_ID               NUMBER        NOT NULL,       -- 발생부서.
  PERSON_ID             NUMBER        NOT NULL,       -- 사용자ID.
  CUSTOMER_ID           NUMBER        NOT NULL,       -- 거래처코드.
  BILL_AMOUNT           NUMBER        DEFAULT 0,      -- 발생금액/할인금액.
  DC_INTEREST_RATE      NUMBER        DEFAULT 0,      -- 할인율.
  DC_TERM               NUMBER        DEFAULT 0,      -- 할인기간.
  DC_INTEREST_AMOUNT    NUMBER        DEFAULT 0,      -- 할인이자.
  PAYMENT_TYPE          VARCHAR2(10)  ,               -- 입금구분(공통코드:PAYMENT_TYPE ).
  BANK_ID               NUMBER        ,               -- 보관/수탁/할인 은행.
  BILL_GIVE_DEPT_ID     NUMBER        ,               -- 배서/입금부서.
  SLIP_DATE             DATE          ,               -- 전표일자.
  SLIP_HEADER_ID        NUMBER        ,               -- 전표 헤더 ID.
  SLIP_LINE_ID          NUMBER        ,               -- 전표 라인 ID.
  CREATION_DATE         DATE          NOT NULL,       -- 생성자.
  CREATED_BY            NUMBER        NOT NULL,       -- 생성일.
  LAST_UPDATE_DATE      DATE          NOT NULL,       -- 수정자.
  LAST_UPDATED_BY       NUMBER        NOT NULL        -- 수정일.
) TABLESPACE FCM_TS_DATA ;

COMMENT ON TABLE FI_BILL_MOVE IS '어음이동내역';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.BILL_NUM IS '어음번호';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.MOVE_SEQ IS '일련번호';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.MOVE_DATE IS '변동일자';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.BILL_STATUS IS '어음상태';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.BILL_TYPE IS '어음종류(공통코드:BILL_TYPE)';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.DEPT_ID IS '발생부서';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.PERSON_ID IS '사용자ID';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.CUSTOMER_ID IS '거래처';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.BILL_AMOUNT IS '발생금액/할인금액';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.DC_INTEREST_RATE IS '할인율';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.DC_TERM IS '할인기간';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.DC_INTEREST_AMOUNT IS '할인이자';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.PAYMENT_TYPE IS '입금구분(공통코드:PAYMENT_TYPE )';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.BANK_ID IS '보관/수탁/할인 은행';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.BILL_GIVE_DEPT_ID IS '배서입금부서';

COMMENT ON COLUMN APPS.FI_BILL_MOVE.SLIP_DATE IS '전표일자';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.SLIP_HEADER_ID IS '전표번호/할인(수탁)명세작성순번/이동통보서그룹번호';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.SLIP_LINE_ID IS '전표번호/할인(수탁)명세작성순번/이동통보서그룹번호';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.CREATION_DATE IS '생성자';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.CREATED_BY IS '생성일';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.LAST_UPDATE_DATE IS '수정자';
COMMENT ON COLUMN APPS.FI_BILL_MOVE.LAST_UPDATED_BY IS '수정일';

CREATE UNIQUE INDEX FI_BILL_MOVE_PK ON 
  FI_BILL_MOVE( BILL_NUM, MOVE_SEQ, SOB_ID)
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

ALTER TABLE FI_BILL_MOVE ADD ( 
  CONSTRAINT FI_BILL_MOVE_PK PRIMARY KEY ( BILL_NUM, MOVE_SEQ, SOB_ID )
        );
/*
CREATE INDEX FI_BILL_MOVE_N1 ON 
  FI_BILL_MOVE(MOVE_DATE, BILL_STATUS)  
  TABLESPACE  FCM_TS_IDX
  PCTFREE 10
  INITRANS 2
  MAXTRANS 255
  LOGGING
  STORAGE (
           INITIAL 64K
           MINEXTENTS 1
           MAXEXTENTS 2147483645
          );
*/
