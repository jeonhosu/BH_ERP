/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_PERSON_DISPATCH
/* Description  : 인사내역 관리
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
CREATE TABLE HRM_PERSON_DISPATCH							
(PERSON_ID                                                NUMBER NOT NULL,
  PERSON_NUM		                                          VARCHAR2(100) NOT NULL, 
  NAME		                                                VARCHAR2(100) NOT NULL, 
  NAME1		                                                VARCHAR2(100),
  NAME2		                                                VARCHAR2(100),
  CORP_ID		                                              NUMBER,
  DISPATCH_CORP_ID                                        NUMBER,
  OPERATING_UNIT_ID                                       NUMBER,
  DEPT_ID 		                                            NUMBER,
  NATION_ID		                                            NUMBER,
  WORK_AREA_ID                                            NUMBER,
  WORK_TYPE_ID		                                        NUMBER,
  JOB_CLASS_ID                                            NUMBER,
  JOB_ID		                                              NUMBER,
  POST_ID		                                              NUMBER,
  OCPT_ID		                                              NUMBER,
  ABIL_ID		                                              NUMBER,
  PAY_GRADE_ID		                                        NUMBER,
  REPRE_NUM		                                            VARCHAR2(30),
  SEX_TYPE		                                            VARCHAR2(1),
  BIRTHDAY		                                            DATE,
  BIRTHDAY_TYPE		                                        VARCHAR2(1),
  MARRY_YN		                                            VARCHAR2(1),
  MARRY_DATE		                                          DATE,
  JOIN_ID		                                              NUMBER,
  JOIN_ROUTE_ID	                                          NUMBER,
  ORI_JOIN_DATE		                                        DATE,
  JOIN_DATE		                                            DATE,
  PAY_DATE		                                            DATE,
  DEPT_DATE		                                            DATE,
  OFFICIALLY_DATE	                                        DATE,
  SHO_DATE		                                            DATE,
  EXPIRE_DATE		                                          DATE,
  PROMOTION_EXPECT_DATE	                                  DATE,
  RETIRE_DATE		                                          DATE,
  RETIRE_ID		                                            NUMBER,
  DIR_INDIR_TYPE		                                      VARCHAR2(2),
  EMPLOYE_TYPE                                            VARCHAR2(2),
  LEGAL_ZIP_CODE		                                      VARCHAR2(30),
  LEGAL_ADDR1	                                            VARCHAR2(150),
  LEGAL_ADDR2	                                            VARCHAR2(150),
  PRSN_ZIP_CODE		                                        VARCHAR2(30),
  PRSN_ADDR1		                                          VARCHAR2(150),
  PRSN_ADDR2		                                          VARCHAR2(150),
  LIVE_ZIP_CODE		                                        VARCHAR2(30),
  LIVE_ADDR1		                                          VARCHAR2(150),
  LIVE_ADDR2		                                          VARCHAR2(150),
  TELEPHON_NO		                                          VARCHAR2(30),
  HP_PHONE_NO		                                          VARCHAR2(30),
  EMAIL		                                                VARCHAR2(150),
  RELIGION_ID		                                          NUMBER,
  END_SCH_ID		                                          NUMBER,
  HOBBY			                                              VARCHAR2(150),
  TALENT			                                            VARCHAR2(150),
  JOB_CATEGORY_ID	                                        NUMBER,
	FLOOR_ID                                                NUMBER,
  DUTY_CONTROL_ID		                                      NUMBER,
  COST_CENTER_ID                                          NUMBER,
  IC_CARD_NO		                                          VARCHAR2(50),
  OLD_PERSON_NUM		                                      VARCHAR2(50),
  CORP_TYPE                                               VARCHAR2(2),
  SOB_ID                                                  NUMBER NOT NULL,
  ORG_ID                                                  NUMBER NOT NULL,
  DISPLAY_NAME                                            VARCHAR2(100),
  DESCRIPTION                                             VARCHAR2(100),
  ATTRIBUTE1                                              VARCHAR2(100),
  ATTRIBUTE2                                              VARCHAR2(100),
  ATTRIBUTE3                                              VARCHAR2(100),
  ATTRIBUTE4                                              VARCHAR2(100),
  ATTRIBUTE5                                              VARCHAR2(100),
  CREATION_DATE                                           DATE NOT NULL,
  CREATED_BY                                              NUMBER NOT NULL,
  LAST_UPDATE_DATE                                        DATE NOT NULL,
  LAST_UPDATED_BY                                         NUMBER NOT NULL
)
 TABLESPACE FCM_TS_DATA;

-- Add comments to the columns 
COMMENT ON COLUMN HRM_PERSON_DISPATCH.PERSON_ID IS '사원ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.PERSON_NUM IS '사원번호';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.NAME IS '한글성명';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.NAME1 IS '영어성명';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.NAME2 IS '한자';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.CORP_ID IS '근무 업체ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.CORP_ID IS '파견 업체ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.OPERATING_UNIT_ID IS '사업자ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.DEPT_ID IS '부서 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.NATION_ID IS '국가 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.WORK_AREA_ID IS '근무지 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.WORK_TYPE_ID IS '교대유형 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.JOB_CLASS_ID IS '직군 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.JOB_ID IS '직종 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.POST_ID IS '직위 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.OCPT_ID IS '직무 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.ABIL_ID IS '직책 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.PAY_GRADE_ID IS '직급 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.REPRE_NUM IS '주민번호';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.SEX_TYPE IS '성별';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.BIRTHDAY IS '생년월일';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.BIRTHDAY_TYPE IS '음양구분';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.MARRY_YN IS '결혼여부';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.MARRY_DATE IS '결혼기념일';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.JOIN_ID IS '입사구분 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.JOIN_ROUTE_ID IS '입사경로 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.ORI_JOIN_DATE IS '그룹입사일자';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.JOIN_DATE IS '입사일자';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.PAY_DATE IS '정규입사일';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.DEPT_DATE IS '발령일자';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.OFFICIALLY_DATE IS '승진일자';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.SHO_DATE IS '승호일자';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.EXPIRE_DATE IS '중도정산일자';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.PROMOTION_EXPECT_DATE IS '승진예상일자';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.RETIRE_DATE IS '퇴직일자';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.RETIRE_ID IS '휴퇴직사유 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.DIR_INDIR_TYPE IS '직간접구분 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.EMPLOYE_TYPE IS '재직/휴직/퇴직 구분 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.LEGAL_ZIP_CODE IS '본적지 우편번호';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.LEGAL_ADDR1 IS '본적지 주소1';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.LEGAL_ADDR2 IS '본적지 주소2';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.PRSN_ZIP_CODE IS '현우편번호';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.PRSN_ADDR1 IS '현주소1';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.PRSN_ADDR2 IS '현주소2';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.LIVE_ZIP_CODE IS '거주지 우편번호';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.LIVE_ADDR1 IS '거주지 주소1';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.LIVE_ADDR2 IS '거주지 주소2';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.TELEPHON_NO IS '전화번호';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.HP_PHONE_NO IS '휴대폰번호';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.EMAIL IS '이메일주소';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.RELIGION_ID IS '종교 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.END_SCH_ID IS '최종학력';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.HOBBY IS '취미';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.TALENT IS '특기';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.JOB_CATEGORY_ID IS '직구분 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.FLOOR_ID IS '작업장ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.DUTY_CONTROL_ID IS '근태관리단위 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.COST_CENTER_ID IS '원가 ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.IC_CARD_NO IS '출입카드번호';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.OLD_PERSON_NUM IS '구 사원번호';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.CORP_TYPE IS '업체타입(1-자사,2-외주,3-소사)';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.SOB_ID IS '회계 업체ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.ORG_ID IS '물류 조직ID';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.DISPLAY_NAME IS '표시 성명';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.DESCRIPTION IS '비고';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.CREATION_DATE	IS '생성일자';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.CREATED_BY IS '생성자';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.LAST_UPDATE_DATE IS '최종수정일자';
COMMENT ON COLUMN HRM_PERSON_DISPATCH.LAST_UPDATED_BY IS '최종수정자';

-- CREATE INDEX.
CREATE UNIQUE INDEX HRM_PERSON_DISPATCH_U1 ON HRM_PERSON_DISPATCH(PERSON_ID) TABLESPACE FCM_TS_IDX;
CREATE UNIQUE INDEX HRM_PERSON_DISPATCH_U2 ON HRM_PERSON_DISPATCH(PERSON_NUM, SOB_ID, ORG_ID) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRM_PERSON_DISPATCH_N1 ON HRM_PERSON_DISPATCH(CORP_ID, DEPT_ID, NAME) TABLESPACE FCM_TS_IDX;
CREATE INDEX HRM_PERSON_DISPATCH_N3 ON HRM_PERSON_DISPATCH(REPLACE(REPRE_NUM, '-', '')) TABLESPACE FCM_TS_IDX;

-- ANALYZE.
ANALYZE TABLE HRM_PERSON_DISPATCH COMPUTE STATISTICS;
ANALYZE INDEX HRM_PERSON_DISPATCH_U1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_PERSON_DISPATCH_U2 COMPUTE STATISTICS;
ANALYZE INDEX HRM_PERSON_DISPATCH_N1 COMPUTE STATISTICS;
ANALYZE INDEX HRM_PERSON_DISPATCH_N3 COMPUTE STATISTICS;
