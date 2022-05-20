/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BUDGET
/* Description  : 월별 예산 확정 내역.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BUDGET
( BUDGET_PERIOD                   VARCHAR2(10)  NOT NULL
, DEPT_ID                         NUMBER        NOT NULL
, ACCOUNT_CONTROL_ID              NUMBER        NOT NULL
, ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL
, SOB_ID                          NUMBER        NOT NULL
, ORG_ID                          NUMBER        NOT NULL
, BUDGET_PERIOD_FR                VARCHAR2(10)  NOT NULL
, BUDGET_PERIOD_TO                VARCHAR2(10)  NOT NULL
, START_DATE                      DATE          NOT NULL
, END_DATE                        DATE          NOT NULL
, PRE_NEXT_AMOUNT                 NUMBER        DEFAULT 0
, BASE_AMOUNT                     NUMBER        DEFAULT 0
, ADD_AMOUNT                      NUMBER        DEFAULT 0
, MOVE_AMOUNT                     NUMBER        DEFAULT 0
, NEXT_AMOUNT                     NUMBER        DEFAULT 0
, BASE_MONTH_YN                   CHAR(1)       DEFAULT 'N'
, MOVE_YN                         CHAR(1)       DEFAULT 'N'
, NEXT_YN                         CHAR(1)       DEFAULT 'N'
, ENABLED_YN                      CHAR(1)       DEFAULT 'Y'
, CLOSED_YN                       CHAR(1)       DEFAULT 'N'
, CLOSED_DATE                     DATE
, CLOSED_PERSON_ID                NUMBER
, USE_AMOUNT                      NUMBER        DEFAULT 0
, REMAIN_AMOUNT                   NUMBER        DEFAULT 0
, DESCRIPTION                     VARCHAR2(100)
, CREATE_SEQ                      NUMBER        NOT NULL
, ATTRIBUTE_A                     VARCHAR2(100)
, ATTRIBUTE_B                     VARCHAR2(100)
, ATTRIBUTE_C                     VARCHAR2(100)
, ATTRIBUTE_D                     VARCHAR2(100)
, ATTRIBUTE_E                     VARCHAR2(100)
, ATTRIBUTE_1                     NUMBER
, ATTRIBUTE_2                     NUMBER
, ATTRIBUTE_3                     NUMBER
, ATTRIBUTE_4                     NUMBER
, ATTRIBUTE_5                     NUMBER
, CREATION_DATE                   DATE          NOT NULL
, CREATED_BY                      NUMBER        NOT NULL
, LAST_UPDATE_DATE                DATE          NOT NULL
, LAST_UPDATED_BY                 NUMBER        NOT NULL
) TABLESPACE FCM_TS_DATA;

--> COMMENT.
COMMENT ON TABLE FI_BUDGET IS '예산수립관리';
COMMENT ON COLUMN FI_BUDGET.BUDGET_PERIOD IS '예산적용년월';
COMMENT ON COLUMN FI_BUDGET.DEPT_ID IS '발의부서';
COMMENT ON COLUMN FI_BUDGET.ACCOUNT_CONTROL_ID IS '계정관리 ID';
COMMENT ON COLUMN FI_BUDGET.ACCOUNT_CODE IS '계정 코드';
COMMENT ON COLUMN FI_BUDGET.BUDGET_PERIOD_FR IS '예산 적용 시작년월';
COMMENT ON COLUMN FI_BUDGET.BUDGET_PERIOD_TO IS '예산 적용 종료년월';
COMMENT ON COLUMN FI_BUDGET.START_DATE IS '예산 적용일자-예산적용 시작년월의 1일';
COMMENT ON COLUMN FI_BUDGET.END_DATE IS '예산 종료일자->예산적용 종료년월의 말일';
COMMENT ON COLUMN FI_BUDGET.PRE_NEXT_AMOUNT IS '이월 받은 예산금액';
COMMENT ON COLUMN FI_BUDGET.BASE_AMOUNT IS '초기예산금액';
COMMENT ON COLUMN FI_BUDGET.ADD_AMOUNT IS '추가예산금액';
COMMENT ON COLUMN FI_BUDGET.MOVE_AMOUNT IS '전용예산금액';
COMMENT ON COLUMN FI_BUDGET.NEXT_AMOUNT IS '이월한 예산금액';
COMMENT ON COLUMN FI_BUDGET.BASE_MONTH_YN IS '편성 예산년월 여부';
COMMENT ON COLUMN FI_BUDGET.MOVE_YN IS '예산전용 Y/N';
COMMENT ON COLUMN FI_BUDGET.NEXT_YN IS '잔액 이월여부 Y/N';
COMMENT ON COLUMN FI_BUDGET.ENABLED_YN IS '사용여부';
COMMENT ON COLUMN FI_BUDGET.CLOSED_YN IS '마감여부 Y/N';
COMMENT ON COLUMN FI_BUDGET.CLOSED_DATE IS '마감일자';
COMMENT ON COLUMN FI_BUDGET.CLOSED_PERSON_ID IS '마감처리자';
COMMENT ON COLUMN FI_BUDGET.USE_AMOUNT IS '사용 금액';
COMMENT ON COLUMN FI_BUDGET.REMAIN_AMOUNT IS '잔액';
COMMENT ON COLUMN FI_BUDGET.DESCRIPTION IS '비고';
COMMENT ON COLUMN FI_BUDGET.CREATE_SEQ IS '생성 일련번호'

--> CREATE INDEX.
ALTER TABLE FI_BUDGET ADD CONSTRAINT FI_BUDGET_PK PRIMARY KEY (BUDGET_PERIOD, DEPT_ID, ACCOUNT_CONTROL_ID, SOB_ID);
CREATE INDEX FI_BUDGET_N1 ON FI_BUDGET(DEPT_ID, ACCOUNT_CONTROL_ID, START_DATE, END_DATE, ENABLED_YN, SOB_ID)
  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BUDGET_N2 ON FI_BUDGET(BUDGET_PERIOD_FR, BUDGET_PERIOD_TO, DEPT_ID, ACCOUNT_CONTROL_ID, ENABLED_YN, SOB_ID)
  TABLESPACE FCM_TS_IDX;  
CREATE INDEX FI_BUDGET_N3 ON FI_BUDGET(BUDGET_PERIOD, DEPT_ID, ACCOUNT_CONTROL_ID, ENABLED_YN, MOVE_YN, SOB_ID)
  TABLESPACE FCM_TS_IDX;  
CREATE INDEX FI_BUDGET_N4 ON FI_BUDGET(BUDGET_PERIOD, DEPT_ID, ACCOUNT_CONTROL_ID, ENABLED_YN, NEXT_YN, SOB_ID)
  TABLESPACE FCM_TS_IDX;
  

