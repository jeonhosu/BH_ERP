/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRW_LOCAL_TAX_DOC
/* Description  : 주민세특별징수명세/납입서.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRW_LOCAL_TAX_DOC
( LOCAL_TAX_ID                    NUMBER          NOT NULL,
  LOCAL_TAX_NO                    VARCHAR2(20)    NOT NULL,
  CORP_ID                         NUMBER          NOT NULL,
  SOB_ID                          NUMBER          NOT NULL,
  ORG_ID                          NUMBER          NOT NULL,
  LOCAL_TAX_TYPE                  VARCHAR2(10)    NOT NULL,
  STD_YYYYMM                      VARCHAR2(8)     NOT NULL,
  PAY_YYYYMM                      VARCHAR2(8)     NOT NULL,
  SUBMIT_DATE                     DATE            ,
  PRE_LOCAL_TAX_NO                VARCHAR2(20)    ,
  PAY_SUPPLY_DATE                 DATE            ,
  TAX_OFFICER                     VARCHAR2(100)   ,
  CLOSED_YN                       VARCHAR2(2)     DEFAULT 'N',
  CLOSED_DATE                     DATE            ,
  CLOSED_PERSON_ID                NUMBER          ,
  A01_PERSON_CNT                  NUMBER          ,
  A01_STD_TAX_AMT                 NUMBER          ,
  A01_LOCAL_TAX_AMT               NUMBER          ,
  A02_PERSON_CNT                  NUMBER          ,
  A02_STD_TAX_AMT                 NUMBER          ,
  A02_LOCAL_TAX_AMT               NUMBER          ,
  A03_PERSON_CNT                  NUMBER          ,
  A03_STD_TAX_AMT                 NUMBER          ,
  A03_LOCAL_TAX_AMT               NUMBER          ,
  A04_PERSON_CNT                  NUMBER          ,
  A04_STD_TAX_AMT                 NUMBER          ,
  A04_LOCAL_TAX_AMT               NUMBER          ,
  A05_PERSON_CNT                  NUMBER          ,
  A05_STD_TAX_AMT                 NUMBER          ,
  A05_LOCAL_TAX_AMT               NUMBER          ,
  A06_PERSON_CNT                  NUMBER          ,
  A06_STD_TAX_AMT                 NUMBER          ,
  A06_LOCAL_TAX_AMT               NUMBER          ,
  A07_PERSON_CNT                  NUMBER          ,
  A07_STD_TAX_AMT                 NUMBER          ,
  A07_LOCAL_TAX_AMT               NUMBER          ,
  A08_PERSON_CNT                  NUMBER          ,
  A08_STD_TAX_AMT                 NUMBER          ,
  A08_LOCAL_TAX_AMT               NUMBER          ,
  A09_PERSON_CNT                  NUMBER          ,
  A09_STD_TAX_AMT                 NUMBER          ,
  A09_LOCAL_TAX_AMT               NUMBER          ,
  A10_PERSON_CNT                  NUMBER          ,
  A10_STD_TAX_AMT                 NUMBER          ,
  A10_LOCAL_TAX_AMT               NUMBER          ,
  A90_PERSON_CNT                  NUMBER          ,
  A90_STD_TAX_AMT                 NUMBER          ,
  A90_LOCAL_TAX_AMT               NUMBER          ,
  TOTAL_ADJUST_TAX_AMT            NUMBER          ,
  PAY_LOCAL_TAX_AMT               NUMBER          ,
  K10_TAX_AMT                     NUMBER          ,
  K20_TAX_AMT                     NUMBER          ,
  K30_TAX_AMT                     NUMBER          ,
  K40_TAX_AMT                     NUMBER          ,
  R10_TAX_AMT                     NUMBER          ,
  R20_TAX_AMT                     NUMBER          ,
  R30_TAX_AMT                     NUMBER          ,
  R40_TAX_AMT                     NUMBER          ,
  DESCRIPTION                     VARCHAR2(100)   ,
  ATTRIBUTE_1                     NUMBER          ,
  ATTRIBUTE_2                     NUMBER          ,
  ATTRIBUTE_3                     NUMBER          ,
  ATTRIBUTE_4                     NUMBER          ,
  ATTRIBUTE_5                     NUMBER          ,
  ATTRIBUTE_A                     NUMBER          ,
  ATTRIBUTE_B                     VARCHAR2(100)   ,
  ATTRIBUTE_C                     VARCHAR2(100)   ,
  ATTRIBUTE_D                     VARCHAR2(100)   ,
  ATTRIBUTE_E                     VARCHAR2(100)   ,
  CREATION_DATE                   DATE            NOT NULL,
  CREATED_BY                      NUMBER          NOT NULL,
  LAST_UPDATE_DATE                DATE            NOT NULL,
  LAST_UPDATED_BY                 NUMBER          NOT NULL
) TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON TABLE HRW_LOCAL_TAX_DOC IS '주민세관리';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID IS '신고서 ID';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.LOCAL_TAX_NO IS '문서번호';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.CORP_ID IS '업체ID';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.LOCAL_TAX_TYPE IS '신고구분';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.STD_YYYYMM IS '귀속년월';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.PAY_YYYYMM IS '지급년월';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.SUBMIT_DATE IS '제출일자';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.PRE_LOCAL_TAX_NO IS '전월문서';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.PAY_SUPPLY_DATE IS '급여지급일자';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.TAX_OFFICER IS '납입처';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.CLOSED_YN IS '마감구분';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.CLOSED_DATE IS '마감일자';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.CLOSED_PERSON_ID IS '마감처리자';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A01_PERSON_CNT IS '이자소득 인원수';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A01_STD_TAX_AMT IS '이자소득 과세표준';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A01_LOCAL_TAX_AMT IS '이자소득 지방소득세';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A02_PERSON_CNT IS '배당소득 인원수';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A02_STD_TAX_AMT IS '배당소득 과세표준';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A02_LOCAL_TAX_AMT IS '배당소득 지방소득세';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A03_PERSON_CNT IS '사업소득 인원수';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A03_STD_TAX_AMT IS '사업소득 과세표준';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A03_LOCAL_TAX_AMT IS '사업소득 지방소득세';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A04_PERSON_CNT IS '근로소득 인원수';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A04_STD_TAX_AMT IS '근로소득 과세표준';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A04_LOCAL_TAX_AMT IS '근로소득 지방소득세';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A05_PERSON_CNT IS '연금소득 인원수';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A05_STD_TAX_AMT IS '연금소득 과세표준';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A05_LOCAL_TAX_AMT IS '연금소득 지방소득세';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A06_PERSON_CNT IS '기타소득 인원수';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A06_STD_TAX_AMT IS '기타소득 과세표준';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A06_LOCAL_TAX_AMT IS '기타소득 지방소득세';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A07_PERSON_CNT IS '퇴직소득 인원수';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A07_STD_TAX_AMT IS '퇴직소득 과세표준';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A07_LOCAL_TAX_AMT IS '퇴직소득 지방소득세';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A08_PERSON_CNT IS '외국인으로부터받은소득 인원수';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A08_STD_TAX_AMT IS '외국인으로부터받은소득 과세표준';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A08_LOCAL_TAX_AMT IS '외국인으로부터받은소득 지방소득세';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A09_PERSON_CNT IS '법인세법 제98조 규정 인원수';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A09_STD_TAX_AMT IS '법인세법 제98조 규정 과세표준';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A09_LOCAL_TAX_AMT IS '법인세법 제98조 규정 지방소득';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A10_PERSON_CNT IS '소득세법 제119조 양도소득 인원수';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A10_STD_TAX_AMT IS '소득세법 제119조 양도소득 과세표준';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A10_LOCAL_TAX_AMT IS '소득세법 제119조 양도소득 지방소득세';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A90_PERSON_CNT IS '합계 인원수';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A90_STD_TAX_AMT IS '합계 과세표준';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.A90_LOCAL_TAX_AMT IS '합계 지방소득세';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.TOTAL_ADJUST_TAX_AMT IS '가감세액(조정액)';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.PAY_LOCAL_TAX_AMT IS '납부세액';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.K10_TAX_AMT IS '계속근무자-전월미환급세액';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.K20_TAX_AMT IS '계속근무자-당월발생환급액';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.K30_TAX_AMT IS '계속근무자-당월조정환급세액';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.K40_TAX_AMT IS '계속근무자-차월이월환급액';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.R10_TAX_AMT IS '중도퇴사연말정산환급액-전월미환급액';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.R20_TAX_AMT IS '중도퇴사연말정산환급액-당월발생환급액';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.R30_TAX_AMT IS '중도퇴사연말정산환급액-당월조정환급액';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.R40_TAX_AMT IS '중도퇴사연말정산환급액-차월이월환급액';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.CREATION_DATE  IS '생성일자';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRW_LOCAL_TAX_DOC.LAST_UPDATED_BY IS '최종수정자';

-- PK.
ALTER TABLE HRW_LOCAL_TAX_DOC ADD CONSTRAINTS HRW_LOCAL_TAX_DOC_PK PRIMARY KEY(LOCAL_TAX_ID);

CREATE UNIQUE INDEX HRW_LOCAL_TAX_DOC_U1 ON HRW_LOCAL_TAX_DOC(LOCAL_TAX_NO, CORP_ID, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;

-- SEQUENCE
CREATE SEQUENCE HRW_LOCAL_TAX_DOC_S1;
-- ANALYZE.
ANALYZE TABLE HRW_LOCAL_TAX_DOC COMPUTE STATISTICS;
ANALYZE INDEX HRW_LOCAL_TAX_DOC_U1 COMPUTE STATISTICS;
