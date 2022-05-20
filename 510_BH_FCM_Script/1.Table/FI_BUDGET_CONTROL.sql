/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BUDGET_CONTROL
/* Description  : 월별 예산 권한  내역.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE FI_BUDGET_CONTROL
( DEPT_ID                         NUMBER        NOT NULL
, CAPACITY_LEVEL                  VARCHAR2(2)   NOT NULL
, PERSON_ID                       NUMBER
, SOB_ID                          NUMBER        NOT NULL
, ORG_ID                          NUMBER        NOT NULL
, SLIP_YN                         CHAR(1)       DEFAULT 'N'
, BASE_YN                         CHAR(1)       DEFAULT 'N'
, ADD_YN                          CHAR(1)       DEFAULT 'N'
, MOVE_YN                         CHAR(1)       DEFAULT 'N'
, DESCRIPTION                     VARCHAR2(100)
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
, CREATION_DATE                   DATE NOT NULL
, CREATED_BY                      NUMBER NOT NULL
, LAST_UPDATE_DATE                DATE NOT NULL
, LAST_UPDATED_BY                 NUMBER NOT NULL
) TABLESPACE FCM_TS_DATA;

--> COMMENT.
COMMENT ON TABLE FI_BUDGET_CONTROL IS '예산사용자-발의부서 관리';
COMMENT ON COLUMN FI_BUDGET_CONTROL.DEPT_ID IS '발의부서ID';
COMMENT ON COLUMN FI_BUDGET_CONTROL.PERSON_ID IS '사원ID';
COMMENT ON COLUMN FI_BUDGET_CONTROL.CAPACITY_LEVEL IS '예산 권한(APPROVE_STATUS)';
COMMENT ON COLUMN FI_BUDGET_CONTROL.SLIP_YN IS '전표 등록 가능 여부';
COMMENT ON COLUMN FI_BUDGET_CONTROL.BASE_YN IS '기초예산 등록가능 여부';
COMMENT ON COLUMN FI_BUDGET_CONTROL.ADD_YN IS '추가예산 등록가능 여부';
COMMENT ON COLUMN FI_BUDGET_CONTROL.MOVE_YN IS '전용예산 등록가능 여부';
COMMENT ON COLUMN FI_BUDGET_CONTROL.EFFECTIVE_DATE_FR IS '적용 시작일자';
COMMENT ON COLUMN FI_BUDGET_CONTROL.EFFECTIVE_DATE_TO IS '적용 종료일자';

--> CREATE INDEX.
ALTER TABLE FI_BUDGET_CONTROL ADD
  CONSTRAINT FI_BUDGET_CONTROL_PK PRIMARY KEY (DEPT_ID, CAPACITY_LEVEL, PERSON_ID, SOB_ID);

CREATE INDEX FI_BUDGET_CONTROL_N1 ON FI_BUDGET_CONTROL(CAPACITY_LEVEL, PERSON_ID, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO)
  TABLESPACE FCM_TS_IDX;
CREATE INDEX FI_BUDGET_CONTROL_N2 ON FI_BUDGET_CONTROL(PERSON_ID, EFFECTIVE_DATE_FR, EFFECTIVE_DATE_TO)
  TABLESPACE FCM_TS_IDX;  
