/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BUDGET_ACCOUNT
/* Description  : 예산계정 설정
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BUDGET_ACCOUNT
( ACCOUNT_CONTROL_ID              NUMBER        NOT NULL
, ACCOUNT_CODE                    VARCHAR2(20)  NOT NULL
, SOB_ID                          NUMBER        NOT NULL
, ORG_ID                          NUMBER        NOT NULL
, REPEAT_PERIOD_COUNT             NUMBER        DEFAULT 1
, CONTROL_YN                      CHAR(1)       DEFAULT 'Y'
, ADD_YN                          CHAR(1)       DEFAULT 'Y'
, MOVE_YN                         CHAR(1)       DEFAULT 'Y'
, NEXT_YN                         CHAR(1)       DEFAULT 'N'
, PO_YN                           CHAR(1)       DEFAULT 'N'
, DESCRIPTION                     VARCHAR2(100)
, ENABLED_YN                      CHAR(1)       DEFAULT 'Y'
, EFFECTIVE_DATE_FR               DATE          NOT NULL
, EFFECTIVE_DATE_TO               DATE
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
COMMENT ON TABLE FI_BUDGET_ACCOUNT IS '예산계정 관리';
COMMENT ON COLUMN FI_BUDGET_ACCOUNT.ACCOUNT_CONTROL_ID IS '계정통제ID';
COMMENT ON COLUMN FI_BUDGET_ACCOUNT.ACCOUNT_CODE IS '계정코드';
COMMENT ON COLUMN FI_BUDGET_ACCOUNT.SOB_ID IS '업체ID';
COMMENT ON COLUMN FI_BUDGET_ACCOUNT.REPEAT_PERIOD_COUNT IS '반복 기간수';
COMMENT ON COLUMN FI_BUDGET_ACCOUNT.CONTROL_YN IS '예산통제 Y/N';
COMMENT ON COLUMN FI_BUDGET_ACCOUNT.ADD_YN IS '예산추가 신청 Y/N';
COMMENT ON COLUMN FI_BUDGET_ACCOUNT.MOVE_YN IS '예산전용 신청 Y/N';
COMMENT ON COLUMN FI_BUDGET_ACCOUNT.NEXT_YN IS '예산이월 Y/N';
COMMENT ON COLUMN FI_BUDGET_ACCOUNT.PO_YN IS '구매발주 포함 Y/N';
COMMENT ON COLUMN FI_BUDGET_ACCOUNT.DESCRIPTION IS '비고';
COMMENT ON COLUMN FI_BUDGET_ACCOUNT.ENABLED_YN IS '예산사용 Y/N';
COMMENT ON COLUMN FI_BUDGET_ACCOUNT.EFFECTIVE_DATE_FR IS '적용 시작일자';
COMMENT ON COLUMN FI_BUDGET_ACCOUNT.EFFECTIVE_DATE_TO IS '적용 종료일자';

--> CREATE INDEX.
ALTER TABLE FI_BUDGET_ACCOUNT ADD CONSTRAINT FI_BUDGET_ACCOUNT_PK PRIMARY KEY (ACCOUNT_CONTROL_ID);

CREATE INDEX FI_BUDGET_ACCOUNT_N1 ON FI_BUDGET_ACCOUNT(ACCOUNT_CODE, SOB_ID, ENABLED_YN, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO)
  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BUDGET_ACCOUNT_N2 ON FI_BUDGET_ACCOUNT(ACCOUNT_CODE, SOB_ID, CONTROL_YN, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO)
  TABLESPACE FCM_TS_IDX;  
