/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BUDGET_PLAN_YEAR
/* Description  : 예산 책정 및 (년) 예산 수립 생성.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BUDGET_PLAN_YEAR
( BUDGET_YEAR                     VARCHAR2(4)   NOT NULL
, DEPT_ID                         NUMBER        NOT NULL
, ACCOUNT_CONTROL_ID              NUMBER        NOT NULL
, ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL
, SOB_ID                          NUMBER        NOT NULL
, ORG_ID                          NUMBER        NOT NULL
, SAVE_SEQ                        NUMBER        DEFAULT 1
, MONTH_AMOUNT                    NUMBER        DEFAULT 0
, YEAR_AMOUNT                     NUMBER        DEFAULT 0
, LAST_YN                         CHAR(1)       DEFAULT 'Y'
, CONFIRMED_YN                    CHAR(1)       DEFAULT 'N'
, CONFIRMED_DATE                  DATE
, CONFIRMED_PERSON_ID             NUMBER
, CLOSED_YN                       CHAR(1)       DEFAULT 'N'
, CLOSED_DATE                     DATE
, CLOSED_PERSON_ID                NUMBER
, APPROVE_STATUS                  VARCHAR2(5)   DEFAULT 'N'
, EMAIL_STATUS                    VARCHAR2(5)
, DESCRIPTION                     VARCHAR2(100)
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
COMMENT ON TABLE FI_BUDGET_PLAN_YEAR IS '년예산 책정';
COMMENT ON COLUMN FI_BUDGET_PLAN_YEAR.DEPT_ID IS '발의부서ID';
COMMENT ON COLUMN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID IS '계정통제ID';
COMMENT ON COLUMN FI_BUDGET_PLAN_YEAR.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN FI_BUDGET_PLAN_YEAR.SOB_ID IS '업체ID';
COMMENT ON COLUMN FI_BUDGET_PLAN_YEAR.SAVE_SEQ IS '수정 일련번호';
COMMENT ON COLUMN FI_BUDGET_PLAN_YEAR.MONTH_AMOUNT IS '월예산 금액';
COMMENT ON COLUMN FI_BUDGET_PLAN_YEAR.YEAR_AMOUNT IS '년예산 금액';
COMMENT ON COLUMN FI_BUDGET_PLAN_YEAR.LAST_YN IS '최종자료 여부';
COMMENT ON COLUMN FI_BUDGET_PLAN_YEAR.CONFIRMED_YN IS '예산 책정 확정 Y/N';
COMMENT ON COLUMN FI_BUDGET_PLAN_YEAR.CONFIRMED_DATE IS '예산 책정 확정일자';
COMMENT ON COLUMN FI_BUDGET_PLAN_YEAR.CONFIRMED_PERSON_ID IS '예산 책정확정 처리자';
COMMENT ON COLUMN FI_BUDGET_PLAN_YEAR.CLOSED_YN IS '예산 마감 확정 Y/N';
COMMENT ON COLUMN FI_BUDGET_PLAN_YEAR.CLOSED_DATE IS '예산 마감 확정 일자';
COMMENT ON COLUMN FI_BUDGET_PLAN_YEAR.CLOSED_PERSON_ID IS '예산 마감 확정 처리자';
COMMENT ON COLUMN FI_BUDGET_PLAN_YEAR.APPROVE_STATUS IS '승인 상태';
COMMENT ON COLUMN FI_BUDGET_PLAN_YEAR.EMAIL_STATUS IS 'EMAIL 발송여부(N-미발송,AR/BR-발송준비,AS/BS-발송완료)';
COMMENT ON COLUMN FI_BUDGET_PLAN_YEAR.DESCRIPTION IS '비고';

--> CREATE INDEX.
ALTER TABLE FI_BUDGET_PLAN_YEAR ADD CONSTRAINT FI_BUDGET_PLAN_YEAR_PK PRIMARY KEY (BUDGET_YEAR, DEPT_ID, ACCOUNT_CONTROL_ID, SOB_ID, SAVE_SEQ);

CREATE INDEX FI_BUDGET_PLAN_YEAR_N1 ON FI_BUDGET_PLAN_YEAR(BUDGET_YEAR, CLOSED_YN, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BUDGET_PLAN_YEAR_N2 ON FI_BUDGET_PLAN_YEAR(BUDGET_YEAR, CONFIRMED_YN, SOB_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BUDGET_PLAN_YEAR_N3 ON FI_BUDGET_PLAN_YEAR(BUDGET_YEAR, LAST_YN, SOB_ID) TABLESPACE FCM_TS_IDX;
