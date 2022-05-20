/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BUDGET_ADD
/* Description  : 월별 예산 신청 내역.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BUDGET_ADD
( BUDGET_TYPE                     VARCHAR2(5)   NOT NULL
, BUDGET_PERIOD                   VARCHAR2(10)  NOT NULL
, DEPT_ID                         NUMBER        NOT NULL
, ACCOUNT_CONTROL_ID              NUMBER        NOT NULL
, ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL
, SOB_ID                          NUMBER        NOT NULL
, ORG_ID                          NUMBER        NOT NULL
, CREATE_SEQ                      NUMBER        NOT NULL
, BUDGET_PERIOD_FR                VARCHAR2(10)  NOT NULL
, BUDGET_PERIOD_TO                VARCHAR2(10)  NOT NULL
, START_DATE                      DATE          NOT NULL
, END_DATE                        DATE          NOT NULL
, SAVE_SEQ                        NUMBER        DEFAULT 1
, AMOUNT                          NUMBER        DEFAULT 0
, CAUSE_ID                        NUMBER        NOT NULL
, LAST_YN                         CHAR(1)       DEFAULT 'Y'
, APPROVED_YN                     CHAR(1)       DEFAULT 'N'
, APPROVED_DATE                   DATE
, APPROVED_PERSON_ID              NUMBER
, CONFIRMED_YN                    CHAR(1)       DEFAULT 'N'
, CONFIRMED_DATE                  DATE
, CONFIRMED_PERSON_ID             NUMBER
, CLOSED_YN                       CHAR(1)       DEFAULT 'N'
, CLOSED_DATE                     DATE
, CLOSED_PERSON_ID                NUMBER
, APPROVE_STATUS                  VARCHAR2(5)   DEFAULT 'N'
, EMAIL_STATUS                    VARCHAR2(5)
, DESCRIPTION                     VARCHAR2(100)
, REJECT_REMARK                   VARCHAR2(100)
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
COMMENT ON TABLE FI_BUDGET_ADD IS '예산 신청(증액/감액/추가) 관리';
COMMENT ON COLUMN FI_BUDGET_ADD.BUDGET_TYPE IS '추가예산타입(BUDGET_TYPE):1-기초예산, 2-예산증액,3-감액예산';
COMMENT ON COLUMN FI_BUDGET_ADD.BUDGET_PERIOD IS '예산적용년월';
COMMENT ON COLUMN FI_BUDGET_ADD.DEPT_ID IS '발의부서';
COMMENT ON COLUMN FI_BUDGET_ADD.ACCOUNT_CONTROL_ID IS '계정(세목)관리 ID';
COMMENT ON COLUMN FI_BUDGET_ADD.ACCOUNT_CODE IS '계정(세목) 코드';
COMMENT ON COLUMN FI_BUDGET_ADD.CREATE_SEQ IS '생성 일련번호';
COMMENT ON COLUMN FI_BUDGET_ADD.BUDGET_PERIOD_FR IS '예산 적용 시작년월';
COMMENT ON COLUMN FI_BUDGET_ADD.BUDGET_PERIOD_TO IS '예산 적용 종료년월';
COMMENT ON COLUMN FI_BUDGET_ADD.START_DATE IS '예산 적용일자-예산적용 시작년월의 1일';
COMMENT ON COLUMN FI_BUDGET_ADD.END_DATE IS '예산 종료일자->예산적용 종료년월의 말일';
COMMENT ON COLUMN FI_BUDGET_ADD.SAVE_SEQ IS '수정 일련번호';
COMMENT ON COLUMN FI_BUDGET_ADD.AMOUNT IS '예산금액';
COMMENT ON COLUMN FI_BUDGET_ADD.CAUSE_ID IS '예산추가사유(BUDGET_CAUSE)';
COMMENT ON COLUMN FI_BUDGET_ADD.LAST_YN IS '최종자료 Y/N';
COMMENT ON COLUMN FI_BUDGET_ADD.APPROVED_YN IS '승인여부';
COMMENT ON COLUMN FI_BUDGET_ADD.APPROVED_DATE IS '승인일자';
COMMENT ON COLUMN FI_BUDGET_ADD.APPROVED_PERSON_ID IS '승인 처리자';
COMMENT ON COLUMN FI_BUDGET_ADD.CONFIRMED_YN IS '확정승인 여부';
COMMENT ON COLUMN FI_BUDGET_ADD.CONFIRMED_DATE IS '확정승인 일자';
COMMENT ON COLUMN FI_BUDGET_ADD.CONFIRMED_PERSON_ID IS '확정승인 처리자';
COMMENT ON COLUMN FI_BUDGET_ADD.APPROVE_STATUS IS '최종승인상태';
COMMENT ON COLUMN FI_BUDGET_ADD.CLOSED_YN IS '마감여부';
COMMENT ON COLUMN FI_BUDGET_ADD.CLOSED_DATE IS '마감일자';
COMMENT ON COLUMN FI_BUDGET_ADD.CLOSED_PERSON_ID IS '마감처리자';
COMMENT ON COLUMN FI_BUDGET_ADD.EMAIL_STATUS IS 'EMAIL 발송여부(N-미발송,AR/BR-발송준비,AS/BS-발송완료)';

--> CREATE INDEX.
ALTER TABLE FI_BUDGET_ADD ADD CONSTRAINT FI_BUDGET_ADD_PK PRIMARY KEY (BUDGET_TYPE, BUDGET_PERIOD, DEPT_ID, ACCOUNT_CONTROL_ID, SOB_ID, SAVE_SEQ);
CREATE INDEX FI_BUDGET_ADD_N1 ON FI_BUDGET_ADD(BUDGET_TYPE, BUDGET_PERIOD, DEPT_ID, ACCOUNT_CONTROL_ID, LAST_YN, SOB_ID)
  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BUDGET_ADD_N2 ON FI_BUDGET_ADD(BUDGET_TYPE, BUDGET_PERIOD, DEPT_ID, ACCOUNT_CONTROL_ID, APPROVE_STATUS, LAST_YN, SOB_ID)
  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BUDGET_ADD_N3 ON FI_BUDGET_ADD(BUDGET_TYPE, BUDGET_PERIOD, DEPT_ID, ACCOUNT_CONTROL_ID, APPROVE_STATUS, EMAIL_STATUS, LAST_YN, SOB_ID)
  TABLESPACE FCM_TS_IDX;
