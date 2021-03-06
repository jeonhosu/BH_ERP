/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRT_PAY_MASTER_HEADER
/* Description  : 급여마스터 HEADER 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRT_PAY_MASTER_HEADER              
( PAY_HEADER_ID                   NUMBER          NOT NULL,
  PERSON_ID	                      NUMBER          NOT NULL,
  CORP_ID                         NUMBER          NOT NULL,
  START_YYYYMM	                  VARCHAR2(7)     NOT NULL,
  END_YYYYMM	                    VARCHAR2(7)     DEFAULT '9999-12',
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  PRINT_TYPE	                    VARCHAR2(1)     NOT NULL,
  BANK_ID	                        NUMBER          ,
  BANK_ACCOUNTS	                  VARCHAR2(50)    ,
  PAY_TYPE                        VARCHAR2(2)     ,
  PAY_GRADE_ID	                  NUMBER          ,
  GRADE_STEP	                    NUMBER          ,
  CORP_CAR_YN	                    VARCHAR2(1)     DEFAULT 'N',
  PAY_PROVIDE_YN                  VARCHAR2(1)     DEFAULT 'Y',
  BONUS_PROVIDE_YN                VARCHAR2(1)     DEFAULT 'Y',
  YEAR_PROVIDE_YN                 VARCHAR2(1)     DEFAULT 'Y',
  HIRE_INSUR_YN	                  VARCHAR2(1)     DEFAULT 'Y',
  DED_FAMILY_COUNT	              NUMBER          DEFAULT 1,
  DED_CHILD_COUNT                 NUMBER          DEFAULT 0,
  LAST_YN                         VARCHAR2(1)     ,
  DESCRIPTION                     VARCHAR2(150)   ,
  ATTRIBUTE_A                     VARCHAR2(150)   ,
  ATTRIBUTE_B                     VARCHAR2(150)   ,
  ATTRIBUTE_C                     VARCHAR2(150)   ,
  ATTRIBUTE_D                     VARCHAR2(150)   ,
  ATTRIBUTE_E                     VARCHAR2(150)   ,
  ATTRIBUTE_1                     NUMBER          ,
  ATTRIBUTE_2                     NUMBER          ,
  ATTRIBUTE_3                     NUMBER          ,
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRT_PAY_MASTER_HEADER IS '급여마스터 HEADER 관리';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.PAY_HEADER_ID IS '급여마스터 헤더 ID';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.START_YYYYMM IS '시작년월';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.END_YYYYMM IS '종료년월';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.PRINT_TYPE IS '인쇄타입';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.BANK_ID IS '은행 ID';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.BANK_ACCOUNTS IS '계좌번호';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.PAY_TYPE IS '급여제 타입';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.PAY_GRADE_ID IS '직급 ID';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.GRADE_STEP IS '호봉';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.CORP_CAR_YN IS '회사차 지급';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.PAY_PROVIDE_YN IS '급여 지급';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.BONUS_PROVIDE_YN IS '상여금 지급';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.YEAR_PROVIDE_YN IS '년차수당 지급';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.HIRE_INSUR_YN IS '고용보험 적용';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.DED_FAMILY_COUNT IS '부양가족(본인)';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.DED_CHILD_COUNT IS '다자녀공제';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.LAST_YN IS '최종구분';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRT_PAY_MASTER_HEADER.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
ALTER TABLE HRT_PAY_MASTER_HEADER ADD CONSTRAINT HRT_PAY_MASTER_HEADER_PK PRIMARY KEY (PERSON_ID, CORP_ID, START_YYYYMM, END_YYYYMM, SOB_ID, ORG_ID);

CREATE UNIQUE INDEX HRT_PAY_MASTER_HEADER_U1 ON HRT_PAY_MASTER_HEADER(PAY_HEADER_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE.
CREATE SEQUENCE HRT_PAY_MASTER_HEADER_S1;

-- ANALYZE.
ANALYZE TABLE HRT_PAY_MASTER_HEADER COMPUTE STATISTICS;
ANALYZE INDEX HRT_PAY_MASTER_HEADER_U1 COMPUTE STATISTICS;
