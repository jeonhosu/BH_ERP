CREATE OR REPLACE PACKAGE HRM_PERSON_MASTER_G
AS

-- PERSON SELECT.
  PROCEDURE DATA_SELECT
          ( P_CURSOR        OUT TYPES.TCURSOR
          , W_CORP_ID       IN NUMBER
          , W_DEPT_ID       IN NUMBER
          , W_EMPLOYE_TYPE  IN VARCHAR2
          , W_NAME          IN VARCHAR2
          , W_SOB_ID        IN NUMBER
          , W_ORG_ID        IN NUMBER
          );



-- PERSON DETAIL[2011-11-16]
   PROCEDURE DATA_SELECT_DETAIL
           ( P_CURSOR1       OUT TYPES.TCURSOR1
           , W_SOB_ID        IN  NUMBER
           , W_ORG_ID        IN  NUMBER
           , W_CORP_ID       IN  NUMBER
           , W_DEPT_ID       IN  NUMBER
           , W_FLOOR_ID      IN  NUMBER
           , W_EMPLOYE_TYPE  IN  VARCHAR2
           , W_NAME          IN  VARCHAR2
           , W_JOB_CATEGORY_ID  IN  NUMBER
           );


-- DISPATCH PERSON SELECT.
  PROCEDURE DISPATCH_SELECT
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN NUMBER
      , W_DEPT_ID                           IN NUMBER
      , W_EMPLOYE_TYPE                      IN VARCHAR2
      , W_NAME                              IN VARCHAR2
      , W_SOB_ID                            IN NUMBER
      , W_ORG_ID                            IN NUMBER
      );

-- DISPATCH PERSON SELECT DETAIL.
  PROCEDURE DISPATCH_SELECT_DETAIL
           ( P_CURSOR1                           OUT TYPES.TCURSOR1
      , W_WORK_CORP_ID                      IN NUMBER
      , W_DEPT_ID                           IN NUMBER
      , W_EMPLOYE_TYPE                      IN VARCHAR2
      , W_NAME                              IN VARCHAR2
      , W_SOB_ID                            IN NUMBER
      , W_ORG_ID                            IN NUMBER
      , W_DISPATCH_CORP_ID                  IN NUMBER
      );

-- EMPLOYEE PERSON.
  PROCEDURE DATA_SELECT_EMPLOYE
           ( P_CURSOR1                           OUT TYPES.TCURSOR1
      , W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
      , W_STD_DATE                          IN HRM_PERSON_MASTER.JOIN_DATE%TYPE
      , W_DEPT_ID                           IN HRM_PERSON_MASTER.DEPT_ID%TYPE
      , W_POST_ID                           IN HRM_PERSON_MASTER.POST_ID%TYPE
      , W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
      , W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
      , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
      );


-- 입퇴사자 현황 .
  PROCEDURE DATA_SELECT_JOIN_RETIRE
           ( P_CURSOR1                           OUT TYPES.TCURSOR1
      , W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
      , W_START_DATE                        IN HRM_PERSON_MASTER.JOIN_DATE%TYPE
      , W_END_DATE                          IN HRM_PERSON_MASTER.JOIN_DATE%TYPE
      , W_EMPLOYE_TYPE                      IN VARCHAR2
      , W_DEPT_ID                           IN HRM_PERSON_MASTER.DEPT_ID%TYPE
      , W_POST_ID                           IN HRM_PERSON_MASTER.POST_ID%TYPE
      , W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
      , W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
      , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
      );

-- PERSON DETAIL SELECT.
  PROCEDURE PERSON_DETAIL_SELECT
           ( P_CURSOR2                           OUT TYPES.TCURSOR2
      , W_CORP_ID                           IN NUMBER
      , W_DEPT_ID                           IN NUMBER
      , W_EMPLOYE_TYPE                      IN VARCHAR2
      , W_NAME                              IN VARCHAR2
      , W_SOB_ID                            IN NUMBER
      , W_ORG_ID                            IN NUMBER
      );

-- DATA_INSERT..
  PROCEDURE DATA_INSERT
           ( P_NAME                              IN VARCHAR2
      , P_NAME1                             IN VARCHAR2
      , P_NAME2                             IN VARCHAR2
      , P_CORP_ID                           IN NUMBER
      , P_OPERATING_UNIT_ID                 IN NUMBER
      , P_DEPT_ID                           IN NUMBER
      , P_NATION_ID                         IN NUMBER
      , P_WORK_AREA_ID                      IN NUMBER
      , P_WORK_TYPE_ID                      IN NUMBER
      , P_JOB_CLASS_ID                      IN NUMBER
      , P_JOB_ID                            IN NUMBER
      , P_POST_ID                           IN NUMBER
      , P_OCPT_ID                           IN NUMBER
      , P_ABIL_ID                           IN NUMBER
      , P_PAY_GRADE_ID                      IN NUMBER
      , P_REPRE_NUM                         IN VARCHAR2
      , P_SEX_TYPE                          IN VARCHAR2
      , P_BIRTHDAY                          IN DATE
      , P_BIRTHDAY_TYPE                     IN VARCHAR2
      , P_MARRY_YN                          IN VARCHAR2
      , P_MARRY_DATE                        IN DATE
      , P_JOIN_ID                           IN NUMBER
      , P_JOIN_ROUTE_ID                     IN NUMBER
      , P_ORI_JOIN_DATE                     IN DATE
      , P_JOIN_DATE                         IN DATE
      , P_PAY_DATE                          IN DATE
      , P_DEPT_DATE                         IN DATE
      , P_OFFICIALLY_DATE                   IN DATE
      , P_SHO_DATE                          IN DATE
      , P_EXPIRE_DATE                       IN DATE
      , P_PROMOTION_EXPECT_DATE             IN DATE
      , P_DIR_INDIR_TYPE                    IN VARCHAR2
      , P_EMPLOYE_TYPE                      IN VARCHAR2
      , P_LEGAL_ZIP_CODE                    IN VARCHAR2
      , P_LEGAL_ADDR1                       IN VARCHAR2
      , P_LEGAL_ADDR2                       IN VARCHAR2
      , P_PRSN_ZIP_CODE                     IN VARCHAR2
      , P_PRSN_ADDR1                        IN VARCHAR2
      , P_PRSN_ADDR2                        IN VARCHAR2
      , P_LIVE_ZIP_CODE                     IN VARCHAR2
      , P_LIVE_ADDR1                        IN VARCHAR2
      , P_LIVE_ADDR2                        IN VARCHAR2
      , P_TELEPHON_NO                       IN VARCHAR2
      , P_HP_PHONE_NO                       IN VARCHAR2
      , P_EMAIL                             IN VARCHAR2
      , P_RELIGION_ID                       IN NUMBER
      , P_END_SCH_ID                        IN NUMBER
      , P_HOBBY                             IN VARCHAR2
      , P_TALENT                            IN VARCHAR2
      , P_JOB_CATEGORY_ID                   IN NUMBER
      , P_FLOOR_ID                          IN NUMBER
      , P_COST_CENTER_ID                    IN NUMBER
      , P_IC_CARD_NO                        IN VARCHAR2
      , P_OLD_PERSON_NUM                    IN VARCHAR2
      , P_CORP_TYPE                         IN VARCHAR2
      , P_SOB_ID                            IN NUMBER
      , P_ORG_ID                            IN NUMBER
      , P_DESCRIPTION                       IN VARCHAR2
      --, P_LABOR_UNION_YN                    IN VARCHAR2
      , P_USER_ID                           IN NUMBER
      , P_PERSON_ID                         OUT NUMBER
      , P_PERSON_NUM                        OUT VARCHAR2
      , O_PERSON_ID                         OUT NUMBER
      , O_PERSON_NUM                        OUT VARCHAR2
      , O_NAME                              OUT VARCHAR2
      );

-- DATA_UPDATE..
  PROCEDURE DATA_UPDATE
           ( W_PERSON_ID                         IN NUMBER
      , P_NAME                              IN VARCHAR2
      , P_NAME1                             IN VARCHAR2
      , P_NAME2                             IN VARCHAR2
      , P_CORP_ID                           IN NUMBER
      , P_NATION_ID                         IN NUMBER
      , P_WORK_AREA_ID                      IN NUMBER
      , P_WORK_TYPE_ID                      IN NUMBER
      , P_REPRE_NUM                         IN VARCHAR2
      , P_SEX_TYPE                          IN VARCHAR2
      , P_BIRTHDAY                          IN DATE
      , P_BIRTHDAY_TYPE                     IN VARCHAR2
      , P_MARRY_YN                          IN VARCHAR2
      , P_MARRY_DATE                        IN DATE
      , P_JOIN_ID                           IN NUMBER
      , P_JOIN_ROUTE_ID                     IN NUMBER
      , P_ORI_JOIN_DATE                     IN DATE
      , P_JOIN_DATE                         IN DATE
      , P_PAY_DATE                          IN DATE
      , P_DEPT_DATE                         IN DATE
      , P_OFFICIALLY_DATE                   IN DATE
      , P_SHO_DATE                          IN DATE
      , P_EXPIRE_DATE                       IN DATE
      , P_PROMOTION_EXPECT_DATE             IN DATE
      , P_RETIRE_DATE                       IN DATE
      , P_RETIRE_ID                         IN NUMBER
      , P_DIR_INDIR_TYPE                    IN VARCHAR2
      , P_EMPLOYE_TYPE                      IN VARCHAR2
      , P_LEGAL_ZIP_CODE                    IN VARCHAR2
      , P_LEGAL_ADDR1                       IN VARCHAR2
      , P_LEGAL_ADDR2                       IN VARCHAR2
      , P_PRSN_ZIP_CODE                     IN VARCHAR2
      , P_PRSN_ADDR1                        IN VARCHAR2
      , P_PRSN_ADDR2                        IN VARCHAR2
      , P_LIVE_ZIP_CODE                     IN VARCHAR2
      , P_LIVE_ADDR1                        IN VARCHAR2
      , P_LIVE_ADDR2                        IN VARCHAR2
      , P_TELEPHON_NO                       IN VARCHAR2
      , P_HP_PHONE_NO                       IN VARCHAR2
      , P_EMAIL                             IN VARCHAR2
      , P_RELIGION_ID                       IN NUMBER
      , P_END_SCH_ID                        IN NUMBER
      , P_HOBBY                             IN VARCHAR2
      , P_TALENT                            IN VARCHAR2
      , P_COST_CENTER_ID                    IN NUMBER
      , P_IC_CARD_NO                        IN VARCHAR2
      , P_OLD_PERSON_NUM                    IN VARCHAR2
      , P_CORP_TYPE                         IN VARCHAR2
      , P_DESCRIPTION                       IN VARCHAR2
      --, P_LABOR_UNION_YN                    IN VARCHAR2
      , P_USER_ID                           IN NUMBER

            , P_OPERATING_UNIT_ID                 IN NUMBER
      , P_DEPT_ID                             IN NUMBER
      , P_JOB_CLASS_ID                      IN NUMBER
      , P_JOB_ID                            IN NUMBER
      , P_POST_ID                           IN NUMBER
      , P_OCPT_ID                           IN NUMBER
      , P_ABIL_ID                           IN NUMBER
      , P_PAY_GRADE_ID                      IN NUMBER
      , P_JOB_CATEGORY_ID                   IN NUMBER
      , P_FLOOR_ID                          IN NUMBER
      );


-- DISPATCH PERSON SELECT DETAIL[2011-11-14]수정
   PROCEDURE DISPATCH_DATA_DETAIL
           ( P_CURSOR            OUT TYPES.TCURSOR
           , W_SOB_ID            IN  HRM_PERSON_MASTER.SOB_ID%TYPE
           , W_ORG_ID            IN  HRM_PERSON_MASTER.ORG_ID%TYPE
           , W_EMPLOYE_TYPE      IN  HRM_PERSON_MASTER.EMPLOYE_TYPE%TYPE
           , W_WORK_CORP_ID      IN  HRM_PERSON_MASTER.WORK_CORP_ID%TYPE
           , W_DISPATCH_CORP_ID  IN  HRM_PERSON_MASTER.CORP_ID%TYPE
           , W_DEPT_ID           IN  HRM_PERSON_MASTER.DEPT_ID%TYPE
           , W_WORK_TYPE_ID      IN  HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
           , W_FLOOR_ID          IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
           , W_PERSON_NAME       IN  HRM_PERSON_MASTER.NAME%TYPE
           );


-- DISPATCH PERSON DATA_INSERT..
  PROCEDURE DISPATCH_DATA_INSERT
           ( P_PERSON_ID                         OUT NUMBER
            , P_PERSON_NUM                        OUT VARCHAR2
            , P_NAME                              IN VARCHAR2
      /*, P_NAME1                             IN VARCHAR2
      , P_NAME2                             IN VARCHAR2*/
      , P_CORP_ID                           IN NUMBER
      /*, P_OPERATING_UNIT_ID                 IN NUMBER*/
            , P_WORK_CORP_ID                      IN NUMBER
      , P_DEPT_ID                           IN NUMBER
      /*, P_NATION_ID                         IN NUMBER
      , P_WORK_AREA_ID                      IN NUMBER*/
      , P_WORK_TYPE_ID                      IN NUMBER
      , P_JOB_CLASS_ID                      IN NUMBER
      /*, P_JOB_ID                            IN NUMBER*/
      , P_POST_ID                           IN NUMBER
      /*, P_OCPT_ID                           IN NUMBER
      , P_ABIL_ID                           IN NUMBER*/
      , P_PAY_GRADE_ID                      IN NUMBER
      , P_REPRE_NUM                         IN VARCHAR2
      , P_SEX_TYPE                          IN VARCHAR2
      /*, P_BIRTHDAY                          IN DATE
      , P_BIRTHDAY_TYPE                     IN VARCHAR2
      , P_MARRY_YN                          IN VARCHAR2
      , P_MARRY_DATE                        IN DATE
      , P_JOIN_ID                           IN NUMBER
      , P_JOIN_ROUTE_ID                     IN NUMBER*/
      , P_ORI_JOIN_DATE                     IN DATE
      , P_JOIN_DATE                         IN DATE
      /*, P_PAY_DATE                          IN DATE
      , P_DEPT_DATE                         IN DATE
      , P_OFFICIALLY_DATE                   IN DATE
      , P_SHO_DATE                          IN DATE
      , P_EXPIRE_DATE                       IN DATE
      , P_PROMOTION_EXPECT_DATE             IN DATE
      , P_DIR_INDIR_TYPE                    IN VARCHAR2*/
      , P_EMPLOYE_TYPE                      IN VARCHAR2
      /*, P_LEGAL_ZIP_CODE                    IN VARCHAR2
      , P_LEGAL_ADDR1                       IN VARCHAR2
      , P_LEGAL_ADDR2                       IN VARCHAR2
      , P_PRSN_ZIP_CODE                     IN VARCHAR2
      , P_PRSN_ADDR1                        IN VARCHAR2
      , P_PRSN_ADDR2                        IN VARCHAR2
      , P_LIVE_ZIP_CODE                     IN VARCHAR2
      , P_LIVE_ADDR1                        IN VARCHAR2
      , P_LIVE_ADDR2                        IN VARCHAR2*/
      , P_TELEPHON_NO                       IN VARCHAR2
      , P_HP_PHONE_NO                       IN VARCHAR2
      /*, P_EMAIL                             IN VARCHAR2
      , P_RELIGION_ID                       IN NUMBER
      , P_END_SCH_ID                        IN NUMBER
      , P_HOBBY                             IN VARCHAR2
      , P_TALENT                            IN VARCHAR2*/
      , P_JOB_CATEGORY_ID                   IN NUMBER
      , P_FLOOR_ID                          IN NUMBER
      , P_COST_CENTER_ID                    IN NUMBER
      , P_IC_CARD_NO                        IN VARCHAR2
      /*, P_OLD_PERSON_NUM                    IN VARCHAR2*/
      , P_CORP_TYPE                         IN VARCHAR2
      , P_SOB_ID                            IN NUMBER
      , P_ORG_ID                            IN NUMBER
      /*, P_DESCRIPTION                       IN VARCHAR2*/
      , P_USER_ID                           IN NUMBER
      );

-- DISPATCH PERSON DATA_UPDATE..
  PROCEDURE DISPATCH_DATA_UPDATE
           ( W_PERSON_ID                         IN NUMBER
      , P_NAME                              IN VARCHAR2
      /*, P_NAME1                             IN VARCHAR2
      , P_NAME2                             IN VARCHAR2*/
      , P_CORP_ID                           IN NUMBER
            , P_WORK_CORP_ID                      IN NUMBER
       /*, P_OPERATING_UNIT_ID                 IN NUMBER*/
      , P_DEPT_ID                           IN NUMBER
      /*, P_NATION_ID                         IN NUMBER
      , P_WORK_AREA_ID                      IN NUMBER*/
      , P_WORK_TYPE_ID                      IN NUMBER
      , P_JOB_CLASS_ID                      IN NUMBER
      /*, P_JOB_ID                            IN NUMBER*/
      , P_POST_ID                           IN NUMBER
      /*, P_OCPT_ID                           IN NUMBER
      , P_ABIL_ID                           IN NUMBER*/
      , P_PAY_GRADE_ID                      IN NUMBER
      , P_REPRE_NUM                         IN VARCHAR2
      , P_SEX_TYPE                          IN VARCHAR2
      /*, P_BIRTHDAY                          IN DATE
      , P_BIRTHDAY_TYPE                     IN VARCHAR2
      , P_MARRY_YN                          IN VARCHAR2
      , P_MARRY_DATE                        IN DATE
      , P_JOIN_ID                           IN NUMBER
      , P_JOIN_ROUTE_ID                     IN NUMBER*/
      , P_ORI_JOIN_DATE                     IN DATE
      , P_JOIN_DATE                         IN DATE
      /*, P_PAY_DATE                          IN DATE
      , P_DEPT_DATE                         IN DATE
      , P_OFFICIALLY_DATE                   IN DATE
      , P_SHO_DATE                          IN DATE
      , P_EXPIRE_DATE                       IN DATE
      , P_PROMOTION_EXPECT_DATE             IN DATE*/
            , P_RETIRE_DATE                       IN DATE
            , P_RETIRE_ID                         IN NUMBER
      /*, P_DIR_INDIR_TYPE                    IN VARCHAR2*/
      , P_EMPLOYE_TYPE                      IN VARCHAR2
      /*, P_LEGAL_ZIP_CODE                    IN VARCHAR2
      , P_LEGAL_ADDR1                       IN VARCHAR2
      , P_LEGAL_ADDR2                       IN VARCHAR2
      , P_PRSN_ZIP_CODE                     IN VARCHAR2
      , P_PRSN_ADDR1                        IN VARCHAR2
      , P_PRSN_ADDR2                        IN VARCHAR2
      , P_LIVE_ZIP_CODE                     IN VARCHAR2
      , P_LIVE_ADDR1                        IN VARCHAR2
      , P_LIVE_ADDR2                        IN VARCHAR2*/
      , P_TELEPHON_NO                       IN VARCHAR2
      , P_HP_PHONE_NO                       IN VARCHAR2
      /*, P_EMAIL                             IN VARCHAR2
      , P_RELIGION_ID                       IN NUMBER
      , P_END_SCH_ID                        IN NUMBER
      , P_HOBBY                             IN VARCHAR2
      , P_TALENT                            IN VARCHAR2*/
      , P_JOB_CATEGORY_ID                   IN NUMBER
      , P_FLOOR_ID                          IN NUMBER
      , P_COST_CENTER_ID                    IN NUMBER
      , P_IC_CARD_NO                        IN VARCHAR2
      /*, P_OLD_PERSON_NUM                    IN VARCHAR2*/
      , P_CORP_TYPE                         IN VARCHAR2
      /*, P_SOB_ID                            IN NUMBER
      , P_ORG_ID                            IN NUMBER*/
      /*, P_DESCRIPTION                       IN VARCHAR2*/
      , P_USER_ID                           IN NUMBER
      );

-- SELECT PERSON INFOMATION.
  PROCEDURE SELECT_PERSON_S1
            ( P_CURSOR2                           OUT TYPES.TCURSOR2
            , W_CORP_ID                           IN NUMBER
            , W_PERSON_ID                         IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_STD_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );

-- SELECT PERSON INFOMATION.
  PROCEDURE SELECT_PERSON_S2
            ( P_CURSOR2                           OUT TYPES.TCURSOR2
            , W_CORP_ID                           IN NUMBER
            , W_NAME                              IN VARCHAR2
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );

-- SELECT PERSON INFOMATION.
  PROCEDURE SELECT_PERSON_S3
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_PERSON_ID                         IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_FLOOR_ID                          IN NUMBER
            , W_STD_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );

-- SELECT PERSON INFOMATION.
  PROCEDURE SELECT_PERSON_S4
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_CORP_ID                           IN NUMBER
						, W_PERSON_ID                         IN NUMBER
						, W_DEPT_ID                           IN NUMBER
            , W_FLOOR_ID                          IN NUMBER
						, W_STD_DATE                          IN DATE
						, W_SOB_ID                            IN NUMBER
						, W_ORG_ID                            IN NUMBER
						);

-- SELECT PERSON INFOMATION.
  PROCEDURE SELECT_PERSON_S5
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_CORP_ID                           IN NUMBER
						, W_PERSON_ID                         IN NUMBER
						, W_DEPT_ID                           IN NUMBER
            , W_FLOOR_ID                          IN NUMBER
						, W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
						, W_SOB_ID                            IN NUMBER
						, W_ORG_ID                            IN NUMBER
						);
            

-- 사원명부 조회 기가별 재직자 사원 조회[2011-11-15]
   PROCEDURE SELECT_DETAIL_PERSON_PERIOD
           ( P_CURSOR       OUT TYPES.TCURSOR
           , W_SOB_ID       IN  HRM_PERSON_MASTER.SOB_ID%TYPE
           , W_ORG_ID       IN  HRM_PERSON_MASTER.ORG_ID%TYPE
           , W_CORP_ID      IN  HRM_PERSON_MASTER.CORP_ID%TYPE
           , W_DEPT_ID      IN  HRM_PERSON_MASTER.DEPT_ID%TYPE
           , W_FLOOR_ID     IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
           , W_PERSON_NAME  IN  HRM_PERSON_MASTER.NAME%TYPE
           , W_DATE_START   IN  HRM_PERSON_MASTER.JOIN_DATE%TYPE
           , W_DATE_END     IN  HRM_PERSON_MASTER.RETIRE_DATE%TYPE
           );


-- 사원명부 조회.
  PROCEDURE SELECT_DETAIL_PERSON
            ( P_CURSOR2                           OUT TYPES.TCURSOR2
            , W_CORP_ID                           IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_FLOOR_ID                          IN NUMBER
            , W_STD_DATE                          IN DATE
            , W_NAME                              IN VARCHAR2
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );


  -- PERSON SIMPLE SELECT[2011-09-22]
  PROCEDURE SELECT_SIMPLE_PERSON( P_CURSOR        OUT TYPES.TCURSOR
                                , W_SOB_ID        IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                , W_ORG_ID        IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                , W_CORP_ID       IN  HRM_PERSON_MASTER.CORP_ID%TYPE
                                , W_DEPT_ID       IN  HRM_PERSON_MASTER.DEPT_ID%TYPE
                                , W_FLOOR_ID      IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
                                , W_WORK_TYPE_ID  IN  HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
                                , W_EMPLOYE_TYPE  IN  HRM_PERSON_MASTER.EMPLOYE_TYPE%TYPE
                                , W_PERSON_ID     IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                , W_PERSON_NAME   IN  HRM_PERSON_MASTER.NAME%TYPE
                                );

 
-- 연말정산 기초관리.
  PROCEDURE SELECT_PERSON_YEAR_ADJUST
	          ( P_CURSOR2                           OUT TYPES.TCURSOR2
						, W_CORP_ID                           IN NUMBER
						, W_PERSON_ID                         IN NUMBER
						, W_DEPT_ID                           IN NUMBER
						, W_STD_DATE                          IN DATE
						, P_SOB_ID                            IN NUMBER
						, P_ORG_ID                            IN NUMBER
						);

-- 연말정산 기초정보의 인적사항 변경.
  PROCEDURE DATA_UPDATE_YEAR_ADJUST
	          ( W_PERSON_ID          IN NUMBER
            , P_SOB_ID             IN NUMBER
            , P_ORG_ID             IN NUMBER
						, P_REPRE_NUM          IN VARCHAR2
            , P_RESIDENT_TYPE      IN VARCHAR2
            , P_NATION_ID          IN NUMBER
            , P_NATIONALITY_TYPE   IN VARCHAR2
            , P_FOREIGN_TAX_YN     IN VARCHAR2
            , P_HOUSEHOLD_TYPE     IN VARCHAR2
            , P_LIVE_ZIP_CODE      IN VARCHAR2
            , P_LIVE_ADDR1         IN VARCHAR2
            , P_LIVE_ADDR2         IN VARCHAR2
						, P_USER_ID            IN NUMBER
            );
            

-- 사원 ID를 가지고 이름 조회..
  FUNCTION NAME_F
          ( W_PERSON_ID                          IN NUMBER
          ) RETURN VARCHAR2;

-- 사원 이메일 주소 검색.
  FUNCTION EMAIL_F
            ( P_PERSON_ID         IN VARCHAR2
            ) RETURN VARCHAR2;

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_PERSON_ID                         IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_STD_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT1
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_PERSON_ID                         IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_STD_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            , W_CORP_TYPE                         IN VARCHAR2 DEFAULT NULL
            );

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT2
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_NAME                              IN VARCHAR2
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT3
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_NAME                              IN VARCHAR2
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            , W_CORP_TYPE                         IN VARCHAR2 DEFAULT NULL
            );

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT4
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_CORP_ID                           IN NUMBER
						, W_NAME                              IN VARCHAR2
						, W_DEPT_ID                           IN NUMBER
						, W_YYYYMM                            IN VARCHAR2
						, W_SOB_ID                            IN NUMBER
						, W_ORG_ID                            IN NUMBER
            , W_CORP_TYPE                         IN VARCHAR2 DEFAULT NULL
						);
            
-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_DUTY
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_WORK_TYPE_ID                      IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_DUTY_C
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_WORK_TYPE_ID                      IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_CONNECT_PERSON_ID                 IN NUMBER
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );

-- LOOKUP PERSON INFOMATION - CAPACITY.
  PROCEDURE LU_PERSON_DUTY_C1
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_WORK_TYPE_ID                      IN NUMBER
            , W_FLOOR_ID                          IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_CONNECT_PERSON_ID                 IN NUMBER
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );

-- LOOKUP PERSON 권한별 INFOMATION.
  PROCEDURE LU_PERSON_FI_C
           ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_NAME                              IN VARCHAR2
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            , W_CONNECT_PERSON_ID                 IN NUMBER
            );

-- LOOKUP PERSON INFOMATION - HISTORY.
  PROCEDURE LU_PERSON_SELECT10
           ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_NAME                              IN VARCHAR2
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );


  -- LOOKUP PERSON INFOMATION[2011-08-18]
  PROCEDURE LU_PERSON_SELECT11
           ( P_CURSOR3        OUT TYPES.TCURSOR3
           , W_SOB_ID         IN  HRM_PERSON_MASTER.SOB_ID%TYPE
           , W_ORG_ID         IN  HRM_PERSON_MASTER.ORG_ID%TYPE
           , W_CORP_ID        IN  HRM_PERSON_MASTER.CORP_ID%TYPE
           , W_DEPT_ID        IN  HRM_PERSON_MASTER.DEPT_ID%TYPE
           );


  -- LOOKUP PERSON INFOMATION[2011-09-05]
  PROCEDURE LU_PERSON_SELECT12
           ( P_CURSOR1        OUT TYPES.TCURSOR1
           , W_SOB_ID         IN  HRM_PERSON_MASTER.SOB_ID%TYPE
           , W_ORG_ID         IN  HRM_PERSON_MASTER.ORG_ID%TYPE
           , W_START_DATE     IN  HRM_PERSON_MASTER.JOIN_DATE%TYPE
           , W_END_DATE       IN  HRM_PERSON_MASTER.JOIN_DATE%TYPE
           , W_CORP_ID        IN  HRM_PERSON_MASTER.CORP_ID%TYPE
           , W_FLOOR_ID       IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
           , W_WORK_TYPE_ID   IN  HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
           );

  -- LOOKUP PERSON INFOMATION[2011-11-03]
  PROCEDURE LU_PERSON_SELECT13
           ( P_CURSOR1        OUT TYPES.TCURSOR1
           , W_SOB_ID         IN  HRM_PERSON_MASTER.SOB_ID%TYPE
           , W_ORG_ID         IN  HRM_PERSON_MASTER.ORG_ID%TYPE
           );


-- LOOKUP PERSON INFOMATION[2011-12-14]추가
   PROCEDURE LU_PERSON_SELECT14
           ( P_CURSOR         OUT TYPES.TCURSOR
           , W_SOB_ID         IN  NUMBER
           , W_ORG_ID         IN  NUMBER
           );


-- LOOKUP PERSON INFOMATION[2011-12-14]추가
   PROCEDURE LU_PERSON_SELECT15
           ( P_CURSOR         OUT TYPES.TCURSOR
           , W_SOB_ID         IN  NUMBER
           , W_ORG_ID         IN  NUMBER
           , W_WORK_TYPE_ID   IN  NUMBER
           , W_DEPT_ID        IN  NUMBER
           , W_FLOOR_ID       IN  NUMBER
           , W_EMPLOYE        IN  VARCHAR2
           );


-- LOOKUP PERSON INFOMATION[2011-12-19]추가
   PROCEDURE LU_PERSON_SELECT16
           ( P_CURSOR         OUT TYPES.TCURSOR
           , W_SOB_ID         IN  NUMBER
           , W_ORG_ID         IN  NUMBER
           , W_WORK_DATE_TO   IN  DATE
           , W_WORK_TYPE_ID   IN  NUMBER
           , W_DEPT_ID        IN  NUMBER
           , W_FLOOR_ID       IN  NUMBER
           , W_EMPLOYE        IN  VARCHAR2
           );

-- LOOKUP PERSON INFOMATION[2012-03-02]추가
   PROCEDURE LU_PERSON_SELECT17
           ( P_CURSOR             OUT TYPES.TCURSOR
           , W_SOB_ID             IN  NUMBER
           , W_ORG_ID             IN  NUMBER
           , W_WORK_DATE_TO       IN  DATE
           , W_WORK_TYPE_ID       IN  NUMBER
           , W_DEPT_ID            IN  NUMBER
           , W_FLOOR_ID           IN  NUMBER
           , W_EMPLOYE            IN  VARCHAR2
           , W_CONNECT_PERSON_ID  IN NUMBER
           );


-- 사원 ID를 가지고 사원번호 조회..
  FUNCTION PERSON_NUMBER_F
          ( W_PERSON_ID  IN  NUMBER
          ) RETURN           VARCHAR2;


-- 사원 ID를 가지고 작업장 조회..
   FUNCTION PERSON_FLOOR_NAME_F
          ( W_PERSON_ID  IN  NUMBER
          ) RETURN           VARCHAR2;



-- DATA PRINT.
  PROCEDURE DATA_PRINT
	          ( P_CURSOR1                           OUT TYPES.TCURSOR1
						, W_CORP_ID                           IN NUMBER
						, W_DEPT_ID                           IN NUMBER
						, W_EMPLOYE_TYPE                      IN VARCHAR2
						, W_NAME                              IN VARCHAR2
						, W_SOB_ID                            IN NUMBER
						, W_ORG_ID                            IN NUMBER
						);
            
END HRM_PERSON_MASTER_G;
/
CREATE OR REPLACE PACKAGE BODY HRM_PERSON_MASTER_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_PERSON_MASTER_G
/* Description  : 인사내역 관리 패키지
/*
/* Reference by : 임직원 정보 관리
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/* 2011-05-27   Kim Dae Sung        Update
/******************************************************************************/

-- PERSON SELECT.
  PROCEDURE DATA_SELECT
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN NUMBER
      , W_DEPT_ID                           IN NUMBER
      , W_EMPLOYE_TYPE                      IN VARCHAR2
      , W_NAME                              IN VARCHAR2
      , W_SOB_ID                            IN NUMBER
      , W_ORG_ID                            IN NUMBER
      )
  AS
  BEGIN
    OPEN P_CURSOR FOR
        SELECT PM.PERSON_ID
            , PM.PERSON_NUM
            , PM.NAME
        FROM HRM_PERSON_MASTER PM
        WHERE PM.CORP_ID                                      = NVL(W_CORP_ID, PM.CORP_ID)
          AND PM.DEPT_ID                                      = NVL(W_DEPT_ID, PM.DEPT_ID)
          AND PM.NAME                                         LIKE W_NAME || '%'
          AND PM.EMPLOYE_TYPE                                 = NVL(W_EMPLOYE_TYPE, PM.EMPLOYE_TYPE)
     AND PM.SOB_ID                                       = W_SOB_ID
     AND PM.ORG_ID                                       = W_ORG_ID
     AND NOT EXISTS( SELECT 'X'
                      FROM HRM_CORP_MASTER CM
                    WHERE CM.CORP_ID        = PM.CORP_ID
                      AND CM.CORP_TYPE      IN('2', '3', '4', '5')
                  )
    ;

  END DATA_SELECT;


-- PERSON DETAIL[2011-11-16]
   PROCEDURE DATA_SELECT_DETAIL
           ( P_CURSOR1       OUT TYPES.TCURSOR1
           , W_SOB_ID        IN  NUMBER
           , W_ORG_ID        IN  NUMBER
           , W_CORP_ID       IN  NUMBER
           , W_DEPT_ID       IN  NUMBER
           , W_FLOOR_ID      IN  NUMBER
           , W_EMPLOYE_TYPE  IN  VARCHAR2
           , W_NAME          IN  VARCHAR2
           , W_JOB_CATEGORY_ID  IN  NUMBER
           )

   AS

   BEGIN

             OPEN P_CURSOR1 FOR
             SELECT PM.PERSON_ID O_PERSON_ID
                  , PM.PERSON_NUM O_PERSON_NUM
                  , PM.NAME O_NAME
                  , PM.PERSON_ID
                  , PM.PERSON_NUM
                  , PM.NAME
                  , PM.NAME1
                  , PM.NAME2
                  , PM.CORP_ID
                  , CM.CORP_NAME
                  , PM.OPERATING_UNIT_ID
                  , OU.OPERATING_UNIT_NAME
                  , PM.DEPT_ID
                  , DM.DEPT_CODE
                  , DM.DEPT_NAME
                  , PM.NATION_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.NATION_ID) NATION_NAME
                  , PM.WORK_AREA_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.WORK_AREA_ID) WORK_AREA_NAME
                  , PM.WORK_TYPE_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) WORK_TYPE_NAME
                  , PM.JOB_CLASS_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID) JOB_CLASS_NAME
                  , PM.JOB_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_ID) JOB_NAME
                  , PM.POST_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) POST_NAME
                  , PM.OCPT_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID) OCPT_NAME
                  , PM.ABIL_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.ABIL_ID) ABIL_NAME
                  , PM.PAY_GRADE_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.PAY_GRADE_ID) PAY_GRADE_NAME
                  , PM.REPRE_NUM
                  , PM.SEX_TYPE
                  , HRM_COMMON_G.CODE_NAME_F('SEX_TYPE', PM.SEX_TYPE, PM.SOB_ID, PM.ORG_ID) SEX_NAME
                  , PM.BIRTHDAY
                  , NVL(PM.BIRTHDAY_TYPE, 'N')BIRTHDAY_TYPE
                  , HRM_COMMON_G.CODE_NAME_F('BIRTHDAY_TYPE', PM.BIRTHDAY_TYPE, PM.SOB_ID, PM.ORG_ID) BIRTHDAY_TYPE_NAME
                  , PM.MARRY_YN
                  , PM.MARRY_DATE
                  , PM.JOIN_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.JOIN_ID) JOIN_NAME
                  , PM.JOIN_ROUTE_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.JOIN_ROUTE_ID) JOIN_ROUTE_NAME
                  , PM.ORI_JOIN_DATE
                  , PM.JOIN_DATE
                  , PM.PAY_DATE
                  , PM.DEPT_DATE
                  , PM.OFFICIALLY_DATE
                  , PM.SHO_DATE
                  , PM.EXPIRE_DATE
                  , PM.PROMOTION_EXPECT_DATE
                  , PM.RETIRE_DATE
                  , PM.RETIRE_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.RETIRE_ID) RETIRE_NAME
                  , PM.DIR_INDIR_TYPE
                  , HRM_COMMON_G.CODE_NAME_F('DIR_INDIR_TYPE', PM.DIR_INDIR_TYPE, PM.SOB_ID, PM.ORG_ID) DIR_INDIR_TYPE_NAME
                  , PM.EMPLOYE_TYPE
                  , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) EMPLOYE_TYPE_NAME
                  , PM.LEGAL_ZIP_CODE
                  , PM.LEGAL_ADDR1
                  , PM.LEGAL_ADDR2
                  , PM.PRSN_ZIP_CODE
                  , PM.PRSN_ADDR1
                  , PM.PRSN_ADDR2
                  , PM.LIVE_ZIP_CODE
                  , PM.LIVE_ADDR1
                  , PM.LIVE_ADDR2
                  , PM.TELEPHON_NO
                  , PM.HP_PHONE_NO
                  , PM.EMAIL
                  , PM.RELIGION_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.RELIGION_ID) RELIGION_NAME
                  , PM.END_SCH_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.END_SCH_ID) END_SCH_NAME
                  , PM.HOBBY
                  , PM.TALENT
                  , PM.JOB_CATEGORY_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) JOB_CATEGORY_NAME
                  , PM.FLOOR_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) FLOOR_NAME
                  , PM.COST_CENTER_ID
                  , HRM_COMMON_G.COST_CENTER_DESC_F(PM.COST_CENTER_ID) AS COST_CENTER
                  , PM.IC_CARD_NO
                  , PM.OLD_PERSON_NUM
                  , PM.CORP_TYPE
                  , PM.DESCRIPTION
                  , PM.LAST_UPDATE_DATE
                  , PM.LAST_UPDATED_BY
                  , PM.LABOR_UNION_YN
               FROM HRM_PERSON_MASTER  PM
                  , HRM_CORP_MASTER    CM
                  , HRM_OPERATING_UNIT OU
                  , HRM_DEPT_MASTER    DM
              WHERE PM.CORP_ID                          = CM.CORP_ID
                AND PM.OPERATING_UNIT_ID                = OU.OPERATING_UNIT_ID
                AND PM.DEPT_ID                          = DM.DEPT_ID
                AND PM.SOB_ID                           = W_SOB_ID
                AND PM.ORG_ID                           = W_ORG_ID
                AND PM.CORP_ID                          = NVL(W_CORP_ID, PM.CORP_ID)
                AND PM.DEPT_ID                          = NVL(W_DEPT_ID, PM.DEPT_ID)
                AND PM.FLOOR_ID                         = NVL(W_FLOOR_ID, PM.FLOOR_ID)
                AND PM.EMPLOYE_TYPE                     = NVL(W_EMPLOYE_TYPE, PM.EMPLOYE_TYPE)
                AND PM.NAME                               LIKE W_NAME || '%'
                AND PM.JOB_CATEGORY_ID                  = NVL(W_JOB_CATEGORY_ID, PM.JOB_CATEGORY_ID)
                AND NOT EXISTS( SELECT 'X'
                                  FROM HRM_CORP_MASTER  CM
                                 WHERE CM.CORP_ID       = PM.CORP_ID
                                   AND CM.CORP_TYPE     IN('2', '3', '4', '5')
                              )
           ORDER BY PM.PERSON_NUM
                  , PM.NAME
                  ;

   END DATA_SELECT_DETAIL;


-- DISPATCH PERSON SELECT.
  PROCEDURE DISPATCH_SELECT
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN NUMBER
      , W_DEPT_ID                           IN NUMBER
      , W_EMPLOYE_TYPE                      IN VARCHAR2
      , W_NAME                              IN VARCHAR2
      , W_SOB_ID                            IN NUMBER
      , W_ORG_ID                            IN NUMBER
      )
  AS
  BEGIN
    OPEN P_CURSOR FOR
        SELECT PM.PERSON_ID
            , PM.PERSON_NUM
            , PM.NAME
        FROM HRM_PERSON_MASTER PM
        WHERE PM.CORP_ID                                      = NVL(W_CORP_ID, PM.CORP_ID)
          AND PM.DEPT_ID                                      = NVL(W_DEPT_ID, PM.DEPT_ID)
          AND PM.NAME                                         LIKE W_NAME || '%'
          AND PM.EMPLOYE_TYPE                                 = NVL(W_EMPLOYE_TYPE, PM.EMPLOYE_TYPE)
     AND PM.SOB_ID                                       = W_SOB_ID
     AND PM.ORG_ID                                       = W_ORG_ID
     AND EXISTS( SELECT 'X'
                    FROM HRM_CORP_MASTER CM
                  WHERE CM.CORP_ID        = PM.CORP_ID
                    AND CM.CORP_TYPE      IN('2', '3', '4', '5')
                )
    ;

  END DISPATCH_SELECT;

-- DISPATCH PERSON SELECT DETAIL.
  PROCEDURE DISPATCH_SELECT_DETAIL
           ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_WORK_CORP_ID                      IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_EMPLOYE_TYPE                      IN VARCHAR2
            , W_NAME                              IN VARCHAR2
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            , W_DISPATCH_CORP_ID                  IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT PM.PERSON_ID
          , PM.PERSON_NUM
          , PM.NAME
          /*, PM.NAME1
          , PM.NAME2*/
          , PM.CORP_ID AS CORP_ID
          , CM.CORP_NAME
          , PM.WORK_CORP_ID AS WORK_CORP_ID
          , D_CM.CORP_NAME AS WORK_CORP_NAME
          /*, PM.OPERATING_UNIT_ID
          , OU.OPERATING_UNIT_NAME*/
          , PM.DEPT_ID
          , DM.DEPT_CODE
          , DM.DEPT_NAME
          /*, PM.NATION_ID
          , HRM_COMMON_G.ID_NAME_F(PM.NATION_ID) NATION_NAME
          , PM.WORK_AREA_ID
          , HRM_COMMON_G.ID_NAME_F(PM.WORK_AREA_ID) WORK_AREA_NAME*/
          , PM.WORK_TYPE_ID
          , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) WORK_TYPE_NAME
          , PM.JOB_CLASS_ID
          , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID) JOB_CLASS_NAME
          /*, PM.JOB_ID
          , HRM_COMMON_G.ID_NAME_F(PM.JOB_ID) JOB_NAME*/
          , PM.POST_ID
          , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) POST_NAME
          /*, PM.OCPT_ID
          , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID) OCPT_NAME
          , PM.ABIL_ID
          , HRM_COMMON_G.ID_NAME_F(PM.ABIL_ID) ABIL_NAME*/
          , PM.PAY_GRADE_ID
          , HRM_COMMON_G.ID_NAME_F(PM.PAY_GRADE_ID) PAY_GRADE_NAME
          , PM.REPRE_NUM
          , PM.SEX_TYPE
          , HRM_COMMON_G.CODE_NAME_F('SEX_TYPE', PM.SEX_TYPE, PM.SOB_ID, PM.ORG_ID) SEX_NAME
          /*, PM.BIRTHDAY
          , NVL(PM.BIRTHDAY_TYPE, 'N')BIRTHDAY_TYPE
          , HRM_COMMON_G.CODE_NAME_F('BIRTHDAY_TYPE', PM.BIRTHDAY_TYPE, PM.SOB_ID, PM.ORG_ID) BIRTHDAY_TYPE_NAME
          , PM.MARRY_YN
          , PM.MARRY_DATE
          , PM.JOIN_ID
          , HRM_COMMON_G.ID_NAME_F(PM.JOIN_ID) JOIN_NAME
          , PM.JOIN_ROUTE_ID
          , HRM_COMMON_G.ID_NAME_F(PM.JOIN_ROUTE_ID) JOIN_ROUTE_NAME*/
          , PM.ORI_JOIN_DATE
          , PM.JOIN_DATE
          /*, PM.PAY_DATE
          , PM.DEPT_DATE
          , PM.OFFICIALLY_DATE
          , PM.SHO_DATE
          , PM.EXPIRE_DATE
          , PM.PROMOTION_EXPECT_DATE*/
          , PM.RETIRE_DATE
          , PM.RETIRE_ID
          , HRM_COMMON_G.ID_NAME_F(PM.RETIRE_ID) RETIRE_NAME
          /*, PM.DIR_INDIR_TYPE
          , HRM_COMMON_G.CODE_NAME_F('DIR_INDIR_TYPE', PM.DIR_INDIR_TYPE, PM.SOB_ID, PM.ORG_ID) DIR_INDIR_TYPE_NAME*/
          , PM.EMPLOYE_TYPE
          , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) EMPLOYE_TYPE_NAME
          /*, PM.LEGAL_ZIP_CODE
          , PM.LEGAL_ADDR1
          , PM.LEGAL_ADDR2
          , PM.PRSN_ZIP_CODE
          , PM.PRSN_ADDR1
          , PM.PRSN_ADDR2
          , PM.LIVE_ZIP_CODE
          , PM.LIVE_ADDR1
          , PM.LIVE_ADDR2*/
          , PM.TELEPHON_NO
          , PM.HP_PHONE_NO
          /*, PM.EMAIL
          , PM.RELIGION_ID
          , HRM_COMMON_G.ID_NAME_F(PM.RELIGION_ID) RELIGION_NAME
          , PM.END_SCH_ID
          , HRM_COMMON_G.ID_NAME_F(PM.END_SCH_ID) END_SCH_NAME
          , PM.HOBBY
          , PM.TALENT*/
          , PM.JOB_CATEGORY_ID
          , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) JOB_CATEGORY_NAME
          , PM.FLOOR_ID
          , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) FLOOR_NAME
          , PM.COST_CENTER_ID
          , HRM_COMMON_G.COST_CENTER_DESC_F(PM.COST_CENTER_ID) AS COST_CENTER
          , PM.IC_CARD_NO
          /*, PM.OLD_PERSON_NUM*/
          , PM.CORP_TYPE
/*            , PD.SOB_ID
          , PD.ORG_ID*/
          /*, PM.DESCRIPTION
          , PM.LAST_UPDATE_DATE
          , PM.LAST_UPDATED_BY*/
        FROM HRM_PERSON_MASTER PM
          , HRM_CORP_MASTER CM
          , HRM_CORP_MASTER D_CM
          , HRM_OPERATING_UNIT OU
          , HRM_DEPT_MASTER DM
        WHERE PM.CORP_ID                          = CM.CORP_ID
          AND PM.WORK_CORP_ID                     = D_CM.CORP_ID
          AND PM.OPERATING_UNIT_ID                = OU.OPERATING_UNIT_ID(+)
          AND PM.DEPT_ID                          = DM.DEPT_ID(+)
          AND PM.WORK_CORP_ID                     = NVL(W_WORK_CORP_ID, PM.WORK_CORP_ID)
          AND PM.DEPT_ID                          = NVL(W_DEPT_ID, PM.DEPT_ID)
          AND PM.NAME                             LIKE W_NAME || '%'
          AND PM.EMPLOYE_TYPE                     = NVL(W_EMPLOYE_TYPE, PM.EMPLOYE_TYPE)
     AND PM.SOB_ID                           = W_SOB_ID
     AND PM.ORG_ID                           = W_ORG_ID
      AND PM.CORP_TYPE                       IN('2', '3', '4', '5')
      AND PM.CORP_ID                     = NVL(W_DISPATCH_CORP_ID, PM.CORP_ID)
     ORDER BY PM.PERSON_NUM, PM.NAME
        ;

  END DISPATCH_SELECT_DETAIL;


-- EMPLOYEE PERSON.
  PROCEDURE DATA_SELECT_EMPLOYE
           ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
            , W_STD_DATE                          IN HRM_PERSON_MASTER.JOIN_DATE%TYPE
            , W_DEPT_ID                           IN HRM_PERSON_MASTER.DEPT_ID%TYPE
            , W_POST_ID                           IN HRM_PERSON_MASTER.POST_ID%TYPE
            , W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            )
  AS
  BEGIN
   OPEN P_CURSOR1 FOR
    SELECT PM.PERSON_NUM
      , PM.NAME
      , PM.REPRE_NUM
      , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID) AS DEPT_NAM
      , HRM_COMMON_G.ID_NAME_F(PM.ABIL_ID) AS ABIL_NAME
      , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_NAME
      , HRM_COMMON_G.ID_NAME_F(PM.PAY_GRADE_ID) AS PAY_GRADE_NAME
      , PM.ORI_JOIN_DATE
      , PM.JOIN_DATE
      , PM.RETIRE_DATE
      , HRM_COMMON_DATE_G.YEAR_COUNT_F(PM.JOIN_DATE, NVL(PM.RETIRE_DATE, GET_LOCAL_DATE(PM.SOB_ID)), 'CEIL', 0) AS EMPLOYE_YEAR
    FROM HRM_PERSON_MASTER PM
    WHERE PM.CORP_ID               = NVL(W_CORP_ID, PM.CORP_ID)
     AND PM.PERSON_ID             = NVL(W_PERSON_ID, PM.PERSON_ID)
     AND PM.DEPT_ID               = NVL(W_DEPT_ID, PM.DEPT_ID)
     AND PM.POST_ID               = NVL(W_POST_ID, PM.POST_ID)
     AND PM.SOB_ID                = W_SOB_ID
     AND PM.ORG_ID                = W_ORG_ID
     AND PM.JOIN_DATE             <= W_STD_DATE
     AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_STD_DATE)
 ORDER BY PM.CORP_TYPE
        , PM.NAME
     ;

 END DATA_SELECT_EMPLOYE;

-- 입퇴사자 현황 .
  PROCEDURE DATA_SELECT_JOIN_RETIRE
           ( P_CURSOR1                           OUT TYPES.TCURSOR1
      , W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
      , W_START_DATE                        IN HRM_PERSON_MASTER.JOIN_DATE%TYPE
      , W_END_DATE                          IN HRM_PERSON_MASTER.JOIN_DATE%TYPE
      , W_EMPLOYE_TYPE                      IN VARCHAR2
      , W_DEPT_ID                           IN HRM_PERSON_MASTER.DEPT_ID%TYPE
      , W_POST_ID                           IN HRM_PERSON_MASTER.POST_ID%TYPE
      , W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
      , W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
      , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
      )
  AS
 BEGIN
   OPEN P_CURSOR1 FOR
    SELECT PM.PERSON_NUM AS PERSON_NUMBER
      , PM.NAME AS PERSON_NAME
      , PM.REPRE_NUM
      , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID) AS DEPT_NAME
      , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID)       AS FLOOR_NAME
      , HRM_COMMON_G.ID_NAME_F(PM.ABIL_ID) AS ABIL_NAME
      , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_NAME
      , HRM_COMMON_G.ID_NAME_F(PM.PAY_GRADE_ID) AS PAY_GRADE_NAME
      , PM.ORI_JOIN_DATE
      , PM.JOIN_DATE
      , PM.RETIRE_DATE
      , HRM_COMMON_DATE_G.PERIOD_YYYY_MM_DD_F(PM.JOIN_DATE, NVL(PM.RETIRE_DATE, GET_LOCAL_DATE(PM.SOB_ID)), 0, 1) AS CONTINUE_YEAR
      , HRM_COMMON_G.ID_NAME_F(PM.END_SCH_ID) AS END_SCH_NAME
      , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID) AS CORP_NAME
    FROM HRM_PERSON_MASTER PM
    WHERE PM.CORP_ID               = NVL(W_CORP_ID, PM.CORP_ID)
     AND PM.PERSON_ID             = NVL(W_PERSON_ID, PM.PERSON_ID)
     AND PM.DEPT_ID               = NVL(W_DEPT_ID, PM.DEPT_ID)
     AND PM.POST_ID               = NVL(W_POST_ID, PM.POST_ID)
     AND PM.SOB_ID                = W_SOB_ID
     AND PM.ORG_ID                = W_ORG_ID
     AND DECODE(W_EMPLOYE_TYPE, '1', PM.JOIN_DATE, NVL(PM.RETIRE_DATE, W_END_DATE + 1))
                                      BETWEEN W_START_DATE AND W_END_DATE
 ORDER BY PM.CORP_TYPE
        , PM.NAME
     ;
 END DATA_SELECT_JOIN_RETIRE;

  -- PERSON DETAIL SELECT.
  PROCEDURE PERSON_DETAIL_SELECT
          ( P_CURSOR2                           OUT TYPES.TCURSOR2
          , W_CORP_ID                           IN NUMBER
          , W_DEPT_ID                           IN NUMBER
          , W_EMPLOYE_TYPE                      IN VARCHAR2
          , W_NAME                              IN VARCHAR2
          , W_SOB_ID                            IN NUMBER
          , W_ORG_ID                            IN NUMBER
          )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT PM.PERSON_ID
          , PM.PERSON_NUM
          , PM.NAME
          , PM.NAME1
          , PM.NAME2
          , PM.CORP_ID
          , CM.CORP_NAME
          , PM.OPERATING_UNIT_ID
          , OU.OPERATING_UNIT_NAME
          , PM.DEPT_ID
          , DM.DEPT_CODE
          , DM.DEPT_NAME
          , PM.NATION_ID
          , HRM_COMMON_G.ID_NAME_F(PM.NATION_ID) NATION_NAME
          , PM.WORK_AREA_ID
          , HRM_COMMON_G.ID_NAME_F(PM.WORK_AREA_ID) WORK_AREA_NAME
          , PM.WORK_TYPE_ID
          , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) WORK_TYPE_NAME
          , PM.JOB_CLASS_ID
          , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID) JOB_CLASS_NAME
          , PM.JOB_ID
          , HRM_COMMON_G.ID_NAME_F(PM.JOB_ID) JOB_NAME
          , PM.POST_ID
          , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) POST_NAME
          , PM.OCPT_ID
          , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID) OCPT_NAME
          , PM.ABIL_ID
          , HRM_COMMON_G.ID_NAME_F(PM.ABIL_ID) ABIL_NAME
          , PM.PAY_GRADE_ID
          , HRM_COMMON_G.ID_NAME_F(PM.PAY_GRADE_ID) PAY_GRADE_NAME
          , PM.REPRE_NUM
          , PM.SEX_TYPE
          , HRM_COMMON_G.CODE_NAME_F('SEX_TYPE', PM.SEX_TYPE, PM.SOB_ID, PM.ORG_ID) SEX_NAME
          , PM.BIRTHDAY
          , NVL(PM.BIRTHDAY_TYPE, 'N')BIRTHDAY_TYPE
          , HRM_COMMON_G.CODE_NAME_F('BIRTHDAY_TYPE', PM.BIRTHDAY_TYPE, PM.SOB_ID, PM.ORG_ID) BIRTHDAY_TYPE_NAME
          , PM.MARRY_YN
          , PM.MARRY_DATE
          , PM.JOIN_ID
          , HRM_COMMON_G.ID_NAME_F(PM.JOIN_ID) JOIN_NAME
          , PM.JOIN_ROUTE_ID
          , HRM_COMMON_G.ID_NAME_F(PM.JOIN_ROUTE_ID) JOIN_ROUTE_NAME
          , PM.ORI_JOIN_DATE
          , PM.JOIN_DATE
          , PM.PAY_DATE
          , PM.DEPT_DATE
          , PM.OFFICIALLY_DATE
          , PM.SHO_DATE
          , PM.EXPIRE_DATE
          , PM.PROMOTION_EXPECT_DATE
          , PM.RETIRE_DATE
          , PM.RETIRE_ID
          , HRM_COMMON_G.ID_NAME_F(PM.RETIRE_ID) RETIRE_NAME
          , PM.DIR_INDIR_TYPE
          , HRM_COMMON_G.CODE_NAME_F('DIR_INDIR_TYPE', PM.DIR_INDIR_TYPE, PM.SOB_ID, PM.ORG_ID) DIR_INDIR_TYPE_NAME
          , PM.EMPLOYE_TYPE
          , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) EMPLOYE_TYPE_NAME
          , PM.LEGAL_ZIP_CODE
          , PM.LEGAL_ADDR1
          , PM.LEGAL_ADDR2
          , PM.PRSN_ZIP_CODE
          , PM.PRSN_ADDR1
          , PM.PRSN_ADDR2
          , PM.LIVE_ZIP_CODE
          , PM.LIVE_ADDR1
          , PM.LIVE_ADDR2
          , PM.TELEPHON_NO
          , PM.HP_PHONE_NO
          , PM.EMAIL
          , PM.RELIGION_ID
          , HRM_COMMON_G.ID_NAME_F(PM.RELIGION_ID) RELIGION_NAME
          , PM.END_SCH_ID
          , HRM_COMMON_G.ID_NAME_F(PM.END_SCH_ID) END_SCH_NAME
          , PM.HOBBY
          , PM.TALENT
          , PM.JOB_CATEGORY_ID
          , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) JOB_CATEGORY_NAME
          , PM.FLOOR_ID
          , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) FLOOR_NAME
          , PM.COST_CENTER_ID
          , HRM_COMMON_G.COST_CENTER_DESC_F(PM.COST_CENTER_ID) AS COST_CENTER
          , PM.IC_CARD_NO
          , PM.OLD_PERSON_NUM
          , PM.CORP_TYPE
          , HRM_COMMON_G.CODE_NAME_F('CORP_TYPE', PM.CORP_TYPE, PM.SOB_ID, PM.ORG_ID) AS CORP_TYPE_NAME
          , PM.DESCRIPTION
          , EAPP_USER_G.USER_NAME_F(PM.LAST_UPDATED_BY) AS LAST_UPDATER
      FROM HRM_PERSON_MASTER  PM
         , HRM_CORP_MASTER    CM
         , HRM_OPERATING_UNIT OU
         , HRM_DEPT_MASTER    DM
      WHERE PM.CORP_ID                                    = CM.CORP_ID
        AND PM.OPERATING_UNIT_ID                          = OU.OPERATING_UNIT_ID(+)
        AND PM.DEPT_ID                                    = DM.DEPT_ID
        AND PM.CORP_ID                                    = NVL(W_CORP_ID, PM.CORP_ID)
        AND PM.DEPT_ID                                    = NVL(W_DEPT_ID, PM.DEPT_ID)
        AND PM.NAME                                       LIKE W_NAME || '%'
        AND PM.EMPLOYE_TYPE                               = NVL(W_EMPLOYE_TYPE, PM.EMPLOYE_TYPE)
        AND PM.SOB_ID                                     = W_SOB_ID
        AND PM.ORG_ID                                     = W_ORG_ID
      ORDER BY PM.PERSON_NUM, PM.NAME
      ;

  END PERSON_DETAIL_SELECT;

-- DATA_INSERT..
  PROCEDURE DATA_INSERT
           ( P_NAME                              IN VARCHAR2
      , P_NAME1                             IN VARCHAR2
      , P_NAME2                             IN VARCHAR2
      , P_CORP_ID                           IN NUMBER
      , P_OPERATING_UNIT_ID                 IN NUMBER
      , P_DEPT_ID                           IN NUMBER
      , P_NATION_ID                         IN NUMBER
      , P_WORK_AREA_ID                      IN NUMBER
      , P_WORK_TYPE_ID                      IN NUMBER
      , P_JOB_CLASS_ID                      IN NUMBER
      , P_JOB_ID                            IN NUMBER
      , P_POST_ID                           IN NUMBER
      , P_OCPT_ID                           IN NUMBER
      , P_ABIL_ID                           IN NUMBER
      , P_PAY_GRADE_ID                      IN NUMBER
      , P_REPRE_NUM                         IN VARCHAR2
      , P_SEX_TYPE                          IN VARCHAR2
      , P_BIRTHDAY                          IN DATE
      , P_BIRTHDAY_TYPE                     IN VARCHAR2
      , P_MARRY_YN                          IN VARCHAR2
      , P_MARRY_DATE                        IN DATE
      , P_JOIN_ID                           IN NUMBER
      , P_JOIN_ROUTE_ID                     IN NUMBER
      , P_ORI_JOIN_DATE                     IN DATE
      , P_JOIN_DATE                         IN DATE
      , P_PAY_DATE                          IN DATE
      , P_DEPT_DATE                         IN DATE
      , P_OFFICIALLY_DATE                   IN DATE
      , P_SHO_DATE                          IN DATE
      , P_EXPIRE_DATE                       IN DATE
      , P_PROMOTION_EXPECT_DATE             IN DATE
      , P_DIR_INDIR_TYPE                    IN VARCHAR2
      , P_EMPLOYE_TYPE                      IN VARCHAR2
      , P_LEGAL_ZIP_CODE                    IN VARCHAR2
      , P_LEGAL_ADDR1                       IN VARCHAR2
      , P_LEGAL_ADDR2                       IN VARCHAR2
      , P_PRSN_ZIP_CODE                     IN VARCHAR2
      , P_PRSN_ADDR1                        IN VARCHAR2
      , P_PRSN_ADDR2                        IN VARCHAR2
      , P_LIVE_ZIP_CODE                     IN VARCHAR2
      , P_LIVE_ADDR1                        IN VARCHAR2
      , P_LIVE_ADDR2                        IN VARCHAR2
      , P_TELEPHON_NO                       IN VARCHAR2
      , P_HP_PHONE_NO                       IN VARCHAR2
      , P_EMAIL                             IN VARCHAR2
      , P_RELIGION_ID                       IN NUMBER
      , P_END_SCH_ID                        IN NUMBER
      , P_HOBBY                             IN VARCHAR2
      , P_TALENT                            IN VARCHAR2
      , P_JOB_CATEGORY_ID                   IN NUMBER
      , P_FLOOR_ID                          IN NUMBER
      , P_COST_CENTER_ID                    IN NUMBER
      , P_IC_CARD_NO                        IN VARCHAR2
      , P_OLD_PERSON_NUM                    IN VARCHAR2
      , P_CORP_TYPE                         IN VARCHAR2
      , P_SOB_ID                            IN NUMBER
      , P_ORG_ID                            IN NUMBER
      , P_DESCRIPTION                       IN VARCHAR2
      --, P_LABOR_UNION_YN                    IN VARCHAR2
      , P_USER_ID                           IN NUMBER
      , P_PERSON_ID                         OUT NUMBER
      , P_PERSON_NUM                        OUT VARCHAR2
      , O_PERSON_ID                         OUT NUMBER
      , O_PERSON_NUM                        OUT VARCHAR2
      , O_NAME                              OUT VARCHAR2
      )
  AS
   N_SYSDATE                                     DATE;
    N_PERSON_ID                                   HRM_PERSON_MASTER.PERSON_ID%TYPE := 0;
    N_PERSON_SEQ                                  NUMBER := 0;
    V_YEAR                                        EAPP_CALENDAR_YEAR.YEAR_STRING%TYPE := NULL;
    V_PERSON_NUM                                  HRM_PERSON_MASTER.PERSON_NUM%TYPE := NULL;

    V_REPRE_NUM                                   VARCHAR2(20);  -- 주민번호.

    V_DUTY_CONTROL_YN                             VARCHAR2(2);
    V_WORK_DATE_FR                                DATE;
    V_WORK_DATE_TO                                DATE;
    V_MESSAGE                                     VARCHAR2(300);

  BEGIN
   N_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);

/*--------------------------------------------------------------------------------------*/
    IF P_SOB_ID = 10 THEN
    -- BH 사번 채계 : X(A - 2000년 이전 입사자, B- 2000년 이후 입사자) + XX(년도) + XXX(일련번호).
      V_YEAR := TO_CHAR(P_ORI_JOIN_DATE, 'YYYY');
      IF V_YEAR < '2000' THEN
        V_PERSON_NUM := 'A' || SUBSTR(V_YEAR, 3, 2) ;
        BEGIN
          SELECT NVL(TO_NUMBER(REPLACE(MAX(PM.PERSON_NUM), 'A', '')), 0) + 1 AS MAX_PERSON_NUM
            INTO N_PERSON_SEQ
            FROM HRM_PERSON_MASTER PM
          WHERE PM.SOB_ID                 = P_SOB_ID
            AND PM.ORG_ID                 = P_ORG_ID
            AND TO_CHAR(PM.ORI_JOIN_DATE, 'YYYY') = V_YEAR
            AND PM.CORP_TYPE              = '1'
          ;
        EXCEPTION WHEN OTHERS THEN
          N_PERSON_SEQ := 1;
        END;

        IF N_PERSON_SEQ = 1 THEN
          V_PERSON_NUM := V_PERSON_NUM || LPAD(TO_CHAR(N_PERSON_SEQ), 3, 0);
        ELSE
          V_PERSON_NUM := 'A' || LPAD(TO_CHAR(N_PERSON_SEQ), 5, 0);
        END IF;
      ELSE
        V_PERSON_NUM := 'B' || SUBSTR(V_YEAR, 3, 2) ;
        BEGIN
          SELECT NVL(TO_NUMBER(REPLACE(MAX(PM.PERSON_NUM), 'B', '')), 0) + 1 AS MAX_PERSON_NUM
            INTO N_PERSON_SEQ
            FROM HRM_PERSON_MASTER PM
          WHERE PM.SOB_ID                 = P_SOB_ID
            AND PM.ORG_ID                 = P_ORG_ID
            AND TO_CHAR(PM.ORI_JOIN_DATE, 'YYYY') = V_YEAR
            AND PM.CORP_TYPE              = '1'
            AND PM.PERSON_NUM             NOT IN('ERPTEST', 'DEV10707', 'SUP', 'IO393', 'IO419', 'IO806', 'IO831', 'IO844')
          ;
        EXCEPTION WHEN OTHERS THEN
          N_PERSON_SEQ := 1;
        END;

        IF N_PERSON_SEQ = 1 THEN
          V_PERSON_NUM := V_PERSON_NUM || LPAD(TO_CHAR(N_PERSON_SEQ), 3, 0);
        ELSE
          V_PERSON_NUM := 'B' || LPAD(TO_CHAR(N_PERSON_SEQ), 5, 0);
        END IF;
      END IF;
      IF V_PERSON_NUM IS NULL THEN
        P_PERSON_NUM := '-';
        RETURN;
      END IF;
    ELSE
    -- FLEXCOME 사번 채계 : XX(년도 2자리) + XX(월) + XX(일) +  XX(일련번호).
      V_YEAR := SUBSTR(TO_CHAR(N_SYSDATE, 'YYYY'), 3, 2);
      V_PERSON_NUM := TO_CHAR(N_SYSDATE, 'MMDD');
      BEGIN
        SELECT NVL(TO_NUMBER(REPLACE(MAX(PM.PERSON_NUM), 'O', '')), 0) + 1 AS MAX_PERSON_NUM
          INTO N_PERSON_SEQ
        FROM HRM_PERSON_MASTER PM
        WHERE PM.SOB_ID                 = P_SOB_ID
          AND PM.ORG_ID                 = P_ORG_ID
          AND PM.ORI_JOIN_DATE          = P_ORI_JOIN_DATE
        ;
      EXCEPTION WHEN OTHERS THEN
        N_PERSON_SEQ := 1;
      END;
      IF N_PERSON_SEQ = 1 THEN
        V_PERSON_NUM := REPLACE(V_YEAR || V_PERSON_NUM || LPAD(N_PERSON_SEQ, 2, 0), ' ', '');
      END IF;
      IF V_PERSON_NUM IS NULL THEN
        P_PERSON_NUM := '-';
        RETURN;
      END IF;

    END IF;
/*--------------------------------------------------------------------------------------*/
-- 주민번호 형식 적용.
    IF P_REPRE_NUM IS NULL THEN
      V_REPRE_NUM := NULL;
    ELSE
      V_REPRE_NUM := SUBSTR(RPAD(REPLACE(P_REPRE_NUM, '-', ''), 13, '*'), 1, 6) || '-' || SUBSTR(RPAD(REPLACE(P_REPRE_NUM, '-', ''), 13, '*'), 7, 13);
    END IF;
    
-- 사원ID 채번.
    SELECT HRM_PERSON_MASTER_S1.NEXTVAL
      INTO N_PERSON_ID
    FROM DUAL;
    IF N_PERSON_ID IS NULL THEN
      RETURN;
    END IF;

-- (신규 입사) - 인사발령 사항 저장 - TRIGGER 적용.
/*--------------------------------------------------------------------------------------*/
    INSERT INTO HRM_PERSON_MASTER
      (PERSON_ID, PERSON_NUM, NAME, NAME1, NAME2
      , CORP_ID, OPERATING_UNIT_ID, WORK_CORP_ID, DEPT_ID
      , NATION_ID, WORK_AREA_ID, WORK_TYPE_ID, JOB_CLASS_ID
      , JOB_ID, POST_ID, OCPT_ID, ABIL_ID
      , PAY_GRADE_ID, REPRE_NUM, SEX_TYPE
      , BIRTHDAY, BIRTHDAY_TYPE, MARRY_YN, MARRY_DATE
      , JOIN_ID, JOIN_ROUTE_ID
      , ORI_JOIN_DATE, JOIN_DATE, PAY_DATE, DEPT_DATE
      , OFFICIALLY_DATE, SHO_DATE, EXPIRE_DATE, PROMOTION_EXPECT_DATE
      , DIR_INDIR_TYPE, EMPLOYE_TYPE
      , LEGAL_ZIP_CODE, LEGAL_ADDR1, LEGAL_ADDR2
      , PRSN_ZIP_CODE, PRSN_ADDR1, PRSN_ADDR2
      , LIVE_ZIP_CODE, LIVE_ADDR1, LIVE_ADDR2
      , TELEPHON_NO, HP_PHONE_NO, EMAIL
      , RELIGION_ID, END_SCH_ID, HOBBY, TALENT
      , JOB_CATEGORY_ID, FLOOR_ID, COST_CENTER_ID
      , IC_CARD_NO, OLD_PERSON_NUM
      , CORP_TYPE, SOB_ID, ORG_ID, DISPLAY_NAME
      , DESCRIPTION/*, LABOR_UNION_YN*/
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
      ) VALUES
      (N_PERSON_ID, V_PERSON_NUM, P_NAME, P_NAME1, P_NAME2
      , P_CORP_ID, P_OPERATING_UNIT_ID, P_CORP_ID, P_DEPT_ID
      , P_NATION_ID, P_WORK_AREA_ID, P_WORK_TYPE_ID, P_JOB_CLASS_ID
      , P_JOB_ID, P_POST_ID, P_OCPT_ID, P_ABIL_ID
      , P_PAY_GRADE_ID, V_REPRE_NUM, P_SEX_TYPE
      , TRUNC(P_BIRTHDAY), P_BIRTHDAY_TYPE, NVL(P_MARRY_YN, 'N'), TRUNC(P_MARRY_DATE)
      , P_JOIN_ID, P_JOIN_ROUTE_ID
      , TRUNC(P_ORI_JOIN_DATE), TRUNC(P_JOIN_DATE), TRUNC(P_PAY_DATE), TRUNC(P_DEPT_DATE)
      , TRUNC(P_OFFICIALLY_DATE), TRUNC(P_SHO_DATE), TRUNC(P_EXPIRE_DATE), TRUNC(P_PROMOTION_EXPECT_DATE)
      , P_DIR_INDIR_TYPE, P_EMPLOYE_TYPE
      , P_LEGAL_ZIP_CODE, P_LEGAL_ADDR1, P_LEGAL_ADDR2
      , P_PRSN_ZIP_CODE, P_PRSN_ADDR1, P_PRSN_ADDR2
      , P_LIVE_ZIP_CODE, P_LIVE_ADDR1, P_LIVE_ADDR2
      , P_TELEPHON_NO, P_HP_PHONE_NO, P_EMAIL
      , P_RELIGION_ID, P_END_SCH_ID, P_HOBBY, P_TALENT
      , P_JOB_CATEGORY_ID, P_FLOOR_ID, P_COST_CENTER_ID
      , P_IC_CARD_NO, P_OLD_PERSON_NUM
      , P_CORP_TYPE, P_SOB_ID, P_ORG_ID, P_NAME || '(' || V_PERSON_NUM ||')'
      , P_DESCRIPTION/*, NVL(P_LABOR_UNION_YN, 'N')*/
      , N_SYSDATE, P_USER_ID, N_SYSDATE, P_USER_ID
      );

      P_PERSON_ID := N_PERSON_ID;
      P_PERSON_NUM := V_PERSON_NUM;
      O_PERSON_ID := N_PERSON_ID;
      O_PERSON_NUM := V_PERSON_NUM;
      O_NAME := P_NAME;

/*--------------------------------------------------------------------------------------*/
-- 근무계획 생성.(신규 입사). - 근태관리 업체 소속, 기존 생성 기록 있는 사람에 대해 적용.
    V_DUTY_CONTROL_YN := 'N';
    V_WORK_DATE_FR := NULL;
    V_WORK_DATE_TO := NULL;
    BEGIN
      SELECT CM.DUTY_CONTROL_YN
        INTO V_DUTY_CONTROL_YN
        FROM HRM_CORP_MASTER CM
      WHERE CM.CORP_ID        = P_CORP_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;

    BEGIN
      SELECT WC.WORK_DATE_FR, WC.WORK_DATE_TO
        INTO V_WORK_DATE_FR, V_WORK_DATE_TO
        FROM HRD_WORK_CALENDAR_SET WC
      WHERE WC.CORP_ID            = P_CORP_ID
        AND WC.WORK_PERIOD        = TO_CHAR(P_ORI_JOIN_DATE, 'YYYY-MM')
        AND WC.WORK_TYPE_ID       = P_WORK_TYPE_ID
        AND WC.CREATED_METHOD     = 'A'
        AND WC.SOB_ID             = P_SOB_ID
        AND WC.ORG_ID             = P_ORG_ID
        AND ROWNUM                <= 1 --< [2011-07-11] 추가
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;


    IF V_DUTY_CONTROL_YN = 'Y' AND V_WORK_DATE_FR IS NOT NULL AND V_WORK_DATE_TO IS NOT NULL THEN
      HRD_WORK_CALENDAR_G.WORKCAL_SET_TABLE
                        ( P_CORP_ID => P_CORP_ID
                        , P_WORK_PERIOD => TO_CHAR(P_ORI_JOIN_DATE, 'YYYY-MM')
                        , P_PERSON_ID => P_PERSON_ID
                        , P_FLOOR_ID => NULL
                        , P_WORK_TYPE_ID => P_WORK_TYPE_ID
                        , P_WORK_DATE_FR => V_WORK_DATE_FR
                        , P_WORK_DATE_TO => V_WORK_DATE_TO
                        , P_USER_ID => P_USER_ID
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        , O_MESSAGE => V_MESSAGE
                        , P_CREATE_TYPE => 'INSA'
                        );
    END IF;
    DBMS_OUTPUT.PUT_LINE('Work Calendar Create Message : ' || V_MESSAGE);

    -- HRD_PERSON_HISTORY 신규 추가[2011-07-19]
    HRD_PERSON_HISTORY_G.INSERT_PERSON_HISTORY
                             ( P_CORP_ID
                             , P_PERSON_ID
                             , P_JOIN_DATE
                             , P_FLOOR_ID
                             , P_WORK_TYPE_ID
                             , P_FLOOR_ID
                             , P_WORK_TYPE_ID
                             , 'NEW'
                             , P_SOB_ID
                             , P_ORG_ID
                             , P_USER_ID
                             , P_DEPT_ID
                             , P_DEPT_ID
                             );
    EXCEPTION
         WHEN OTHERS 
         THEN
              RAISE_APPLICATION_ERROR(-20011,  V_PERSON_NUM || CHR(10) || SQLERRM );
              RETURN;

  END DATA_INSERT;

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE
           ( W_PERSON_ID                         IN NUMBER
      , P_NAME                              IN VARCHAR2
      , P_NAME1                             IN VARCHAR2
      , P_NAME2                             IN VARCHAR2
      , P_CORP_ID                           IN NUMBER
      , P_NATION_ID                         IN NUMBER
      , P_WORK_AREA_ID                      IN NUMBER
      , P_WORK_TYPE_ID                      IN NUMBER
      , P_REPRE_NUM                         IN VARCHAR2
      , P_SEX_TYPE                          IN VARCHAR2
      , P_BIRTHDAY                          IN DATE
      , P_BIRTHDAY_TYPE                     IN VARCHAR2
      , P_MARRY_YN                          IN VARCHAR2
      , P_MARRY_DATE                        IN DATE
      , P_JOIN_ID                           IN NUMBER
      , P_JOIN_ROUTE_ID                     IN NUMBER
      , P_ORI_JOIN_DATE                     IN DATE
      , P_JOIN_DATE                         IN DATE
      , P_PAY_DATE                          IN DATE
      , P_DEPT_DATE                         IN DATE
      , P_OFFICIALLY_DATE                   IN DATE
      , P_SHO_DATE                          IN DATE
      , P_EXPIRE_DATE                       IN DATE
      , P_PROMOTION_EXPECT_DATE             IN DATE
      , P_RETIRE_DATE                       IN DATE
      , P_RETIRE_ID                         IN NUMBER
      , P_DIR_INDIR_TYPE                    IN VARCHAR2
      , P_EMPLOYE_TYPE                      IN VARCHAR2
      , P_LEGAL_ZIP_CODE                    IN VARCHAR2
      , P_LEGAL_ADDR1                       IN VARCHAR2
      , P_LEGAL_ADDR2                       IN VARCHAR2
      , P_PRSN_ZIP_CODE                     IN VARCHAR2
      , P_PRSN_ADDR1                        IN VARCHAR2
      , P_PRSN_ADDR2                        IN VARCHAR2
      , P_LIVE_ZIP_CODE                     IN VARCHAR2
      , P_LIVE_ADDR1                        IN VARCHAR2
      , P_LIVE_ADDR2                        IN VARCHAR2
      , P_TELEPHON_NO                       IN VARCHAR2
      , P_HP_PHONE_NO                       IN VARCHAR2
      , P_EMAIL                             IN VARCHAR2
      , P_RELIGION_ID                       IN NUMBER
      , P_END_SCH_ID                        IN NUMBER
      , P_HOBBY                             IN VARCHAR2
      , P_TALENT                            IN VARCHAR2
      , P_COST_CENTER_ID                    IN NUMBER
      , P_IC_CARD_NO                        IN VARCHAR2
      , P_OLD_PERSON_NUM                    IN VARCHAR2
      , P_CORP_TYPE                         IN VARCHAR2
      , P_DESCRIPTION                       IN VARCHAR2
      --, P_LABOR_UNION_YN                    IN VARCHAR2
      , P_USER_ID                           IN NUMBER

       , P_OPERATING_UNIT_ID                 IN NUMBER
      , P_DEPT_ID                             IN NUMBER
      , P_JOB_CLASS_ID                      IN NUMBER
      , P_JOB_ID                            IN NUMBER
      , P_POST_ID                           IN NUMBER
      , P_OCPT_ID                           IN NUMBER
      , P_ABIL_ID                           IN NUMBER
      , P_PAY_GRADE_ID                      IN NUMBER
      , P_JOB_CATEGORY_ID                   IN NUMBER
      , P_FLOOR_ID                          IN NUMBER
      )
  AS
    V_REPRE_NUM                                   VARCHAR2(20);  -- 주민번호.
  BEGIN
    -- 주민번호 형식 적용.
    IF P_REPRE_NUM IS NULL THEN
      V_REPRE_NUM := NULL;
    ELSE
      V_REPRE_NUM := SUBSTR(RPAD(REPLACE(P_REPRE_NUM, '-', ''), 13, '*'), 1, 6) || '-' || SUBSTR(RPAD(REPLACE(P_REPRE_NUM, '-', ''), 13, '*'), 7, 13);
    END IF;
    
      UPDATE HRM_PERSON_MASTER PM
      SET PM.NAME                                             = P_NAME
      , PM.NAME1                                              = P_NAME1
      , PM.NAME2                                              = P_NAME2
      , PM.CORP_ID                                            = P_CORP_ID
      , PM.NATION_ID                                          = P_NATION_ID
      , PM.WORK_AREA_ID                                       = P_WORK_AREA_ID
      --[2011-08-25], PM.WORK_TYPE_ID                                       = P_WORK_TYPE_ID

      , PM.REPRE_NUM                                          = V_REPRE_NUM
      , PM.SEX_TYPE                                           = P_SEX_TYPE
      , PM.BIRTHDAY                                           = TRUNC(P_BIRTHDAY)
      , PM.BIRTHDAY_TYPE                                      = P_BIRTHDAY_TYPE
      , PM.MARRY_YN                                           = P_MARRY_YN
      , PM.MARRY_DATE                                         = TRUNC(P_MARRY_DATE)
      , PM.JOIN_ID                                            = P_JOIN_ID
      , PM.JOIN_ROUTE_ID                                      = P_JOIN_ROUTE_ID
      , PM.ORI_JOIN_DATE                                      = TRUNC(P_ORI_JOIN_DATE)
      , PM.JOIN_DATE                                          = TRUNC(P_JOIN_DATE)
      , PM.PAY_DATE                                           = TRUNC(P_PAY_DATE)
      , PM.DEPT_DATE                                          = TRUNC(P_DEPT_DATE)
      , PM.OFFICIALLY_DATE                                    = TRUNC(P_OFFICIALLY_DATE)
      , PM.SHO_DATE                                           = TRUNC(P_SHO_DATE)
      , PM.EXPIRE_DATE                                        = TRUNC(P_EXPIRE_DATE)
      , PM.PROMOTION_EXPECT_DATE                              = TRUNC(P_PROMOTION_EXPECT_DATE)
            , PM.RETIRE_DATE                                        = TRUNC(P_RETIRE_DATE)
            , PM.RETIRE_ID                                          = P_RETIRE_ID
      , PM.DIR_INDIR_TYPE                                     = P_DIR_INDIR_TYPE
      , PM.EMPLOYE_TYPE                                       = P_EMPLOYE_TYPE
      , PM.LEGAL_ZIP_CODE                                     = P_LEGAL_ZIP_CODE
      , PM.LEGAL_ADDR1                                        = P_LEGAL_ADDR1
      , PM.LEGAL_ADDR2                                        = P_LEGAL_ADDR2
      , PM.PRSN_ZIP_CODE                                      = P_PRSN_ZIP_CODE
      , PM.PRSN_ADDR1                                         = P_PRSN_ADDR1
      , PM.PRSN_ADDR2                                         = P_PRSN_ADDR2
      , PM.LIVE_ZIP_CODE                                      = P_LIVE_ZIP_CODE
      , PM.LIVE_ADDR1                                         = P_LIVE_ADDR1
      , PM.LIVE_ADDR2                                         = P_LIVE_ADDR2
      , PM.TELEPHON_NO                                        = P_TELEPHON_NO
      , PM.HP_PHONE_NO                                        = P_HP_PHONE_NO
      , PM.EMAIL                                              = P_EMAIL
      , PM.RELIGION_ID                                        = P_RELIGION_ID
      , PM.END_SCH_ID                                         = P_END_SCH_ID
      , PM.HOBBY                                              = P_HOBBY
      , PM.TALENT                                             = P_TALENT
      , PM.COST_CENTER_ID                                     = P_COST_CENTER_ID
      , PM.IC_CARD_NO                                         = P_IC_CARD_NO
      , PM.OLD_PERSON_NUM                                     = P_OLD_PERSON_NUM
      , PM.CORP_TYPE                                          = P_CORP_TYPE
      , PM.DESCRIPTION                                        = P_DESCRIPTION
      --, PM.LABOR_UNION_YN                                     = NVL(P_LABOR_UNION_YN, 'N')
      , PM.LAST_UPDATE_DATE                                   = GET_LOCAL_DATE(PM.SOB_ID)
      , PM.LAST_UPDATED_BY                                    = P_USER_ID

      , PM.OPERATING_UNIT_ID                                  = P_OPERATING_UNIT_ID
      --[2011-11-28], PM.DEPT_ID                                            = P_DEPT_ID
      , PM.JOB_CLASS_ID                                       = P_JOB_CLASS_ID
      , PM.JOB_ID                                             = P_JOB_ID
      , PM.POST_ID                                            = P_POST_ID
      , PM.OCPT_ID                                            = P_OCPT_ID
      , PM.ABIL_ID                                            = P_ABIL_ID
      , PM.PAY_GRADE_ID                                       = P_PAY_GRADE_ID
      , PM.JOB_CATEGORY_ID                                    = P_JOB_CATEGORY_ID
      --[2011-08-25], PM.FLOOR_ID                                           = P_FLOOR_ID
      WHERE PM.PERSON_ID                                                = W_PERSON_ID
      ;


    -- 최종 인사발령사항 적용.
    BEGIN
      --UPDATE HRM_HISTORY_LINE HL
      --   SET HL.DEPT_ID          = P_DEPT_ID
      --     , HL.FLOOR_ID         = P_FLOOR_ID
      --     , HL.CHARGE_DATE      = TRUNC(P_JOIN_DATE)
      -- WHERE HL.PERSON_ID        = W_PERSON_ID
      --   AND HL.HISTORY_LINE_ID  = ( SELECT MAX(HL1.HISTORY_LINE_ID) AS HISTORY_LINE_ID
      --                                 FROM HRM_HISTORY_LINE HL1
      --                                WHERE HL1.PERSON_ID             = HL.PERSON_ID
      --                             )
      --;
      
      --[2011-11-28]
      UPDATE HRM_HISTORY_LINE HL
         SET HL.CHARGE_DATE      = TRUNC(P_JOIN_DATE)
       WHERE HL.PERSON_ID        = W_PERSON_ID
         AND HL.HISTORY_LINE_ID  = ( SELECT MAX(HL1.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                       FROM HRM_HISTORY_LINE HL1
                                      WHERE HL1.PERSON_ID             = HL.PERSON_ID
                                   )
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10180', NULL));
    END;


   --작업장 수정 [2011-08-03]
    BEGIN
          --[2011-08-25]UPDATE HRD_PERSON_HISTORY PH
          --   SET PH.FLOOR_ID          = P_FLOOR_ID
          --     , PH.PRE_FLOOR_ID      = PH.FLOOR_ID
          -- WHERE PH.PERSON_ID         = W_PERSON_ID
          --     ;


          UPDATE HRD_PERSON_HISTORY
             SET EFFECTIVE_DATE_FR  =  P_JOIN_DATE
           WHERE PERSON_ID          =  W_PERSON_ID
             AND EFFECTIVE_DATE_FR  =  (
                                        SELECT MIN(EFFECTIVE_DATE_FR)
                                          FROM HRD_PERSON_HISTORY
                                         WHERE PERSON_ID = W_PERSON_ID
                                        )
               ;


    EXCEPTION 
         WHEN OTHERS 
         THEN
              RAISE_APPLICATION_ERROR(-20001, SQLERRM);

    END;





   --LOGIN USER UNENABLED [2011-11-03]
    BEGIN
         IF P_RETIRE_DATE IS NOT NULL THEN
          UPDATE EAPP_USER U
             SET U.ENABLED_FLAG = 'N'
               , U.EFFECTIVE_DATE_TO = P_RETIRE_DATE
           WHERE U.PERSON_ID = W_PERSON_ID
               ;
         END IF;

    EXCEPTION 
         WHEN OTHERS 
         THEN
              RAISE_APPLICATION_ERROR(-20001, SQLERRM);

    END;





  END DATA_UPDATE;


-- DISPATCH PERSON SELECT DETAIL[2011-11-14]수정
   PROCEDURE DISPATCH_DATA_DETAIL
           ( P_CURSOR            OUT TYPES.TCURSOR
           , W_SOB_ID            IN  HRM_PERSON_MASTER.SOB_ID%TYPE
           , W_ORG_ID            IN  HRM_PERSON_MASTER.ORG_ID%TYPE
           , W_EMPLOYE_TYPE      IN  HRM_PERSON_MASTER.EMPLOYE_TYPE%TYPE
           , W_WORK_CORP_ID      IN  HRM_PERSON_MASTER.WORK_CORP_ID%TYPE
           , W_DISPATCH_CORP_ID  IN  HRM_PERSON_MASTER.CORP_ID%TYPE
           , W_DEPT_ID           IN  HRM_PERSON_MASTER.DEPT_ID%TYPE
           , W_WORK_TYPE_ID      IN  HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
           , W_FLOOR_ID          IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
           , W_PERSON_NAME       IN  HRM_PERSON_MASTER.NAME%TYPE
           )

   AS

   BEGIN
             OPEN P_CURSOR FOR
             SELECT PM.PERSON_ID
                  , PM.PERSON_NUM
                  , PM.NAME
                  , PM.CORP_ID AS CORP_ID
                  , CM.CORP_NAME
                  , PM.WORK_CORP_ID AS WORK_CORP_ID
                  , D_CM.CORP_NAME AS WORK_CORP_NAME
                  , PM.DEPT_ID
                  , DM.DEPT_CODE
                  , DM.DEPT_NAME
                  , PM.FLOOR_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) FLOOR_NAME
                  , PM.WORK_TYPE_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) WORK_TYPE_NAME
                  , PM.JOB_CLASS_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID) JOB_CLASS_NAME
                  , PM.JOB_CATEGORY_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) JOB_CATEGORY_NAME
                  , PM.POST_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) POST_NAME
                  , PM.REPRE_NUM
                  , PM.SEX_TYPE
                  , HRM_COMMON_G.CODE_NAME_F('SEX_TYPE', PM.SEX_TYPE, PM.SOB_ID, PM.ORG_ID) SEX_NAME
                  , PM.ORI_JOIN_DATE
                  , PM.JOIN_DATE
                  , PM.RETIRE_DATE
                  , PM.RETIRE_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.RETIRE_ID) RETIRE_NAME
                  , PM.EMPLOYE_TYPE
                  , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) EMPLOYE_TYPE_NAME
                  , PM.TELEPHON_NO
                  , PM.HP_PHONE_NO
                  , PM.COST_CENTER_ID
                  , HRM_COMMON_G.COST_CENTER_DESC_F(PM.COST_CENTER_ID) AS COST_CENTER
                  , PM.IC_CARD_NO
                  , PM.PAY_GRADE_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.PAY_GRADE_ID) PAY_GRADE_NAME
                  , PM.CORP_TYPE
               FROM HRM_PERSON_MASTER        PM
                  , HRM_CORP_MASTER          CM
                  , HRM_CORP_MASTER          D_CM
                  , HRM_OPERATING_UNIT       OU
                  , HRM_DEPT_MASTER          DM
              WHERE PM.CORP_ID             = CM.CORP_ID
                AND PM.WORK_CORP_ID        = D_CM.CORP_ID
                AND PM.OPERATING_UNIT_ID   = OU.OPERATING_UNIT_ID(+)
                AND PM.DEPT_ID             = DM.DEPT_ID(+)
                AND PM.CORP_TYPE           IN('2', '3', '4', '5')
                AND PM.SOB_ID              = W_SOB_ID
                AND PM.ORG_ID              = W_ORG_ID
                AND PM.EMPLOYE_TYPE        = NVL(W_EMPLOYE_TYPE, PM.EMPLOYE_TYPE)
                AND PM.WORK_CORP_ID        = NVL(W_WORK_CORP_ID, PM.WORK_CORP_ID)
                AND PM.CORP_ID             = NVL(W_DISPATCH_CORP_ID, PM.CORP_ID)
                AND PM.DEPT_ID             = NVL(W_DEPT_ID, PM.DEPT_ID)
                AND PM.WORK_TYPE_ID        = NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
                AND PM.FLOOR_ID            = NVL(W_FLOOR_ID, PM.FLOOR_ID)
                AND PM.NAME                  LIKE W_PERSON_NAME || '%'
           ORDER BY PM.PERSON_NUM
                  , PM.NAME
                  ;


   END DISPATCH_DATA_DETAIL;




-- DISPATCH PERSON DATA_INSERT..
  PROCEDURE DISPATCH_DATA_INSERT
           ( P_PERSON_ID                         OUT NUMBER
            , P_PERSON_NUM                        OUT VARCHAR2
            , P_NAME                              IN VARCHAR2
            /*, P_NAME1                             IN VARCHAR2
            , P_NAME2                             IN VARCHAR2*/
            , P_CORP_ID                           IN NUMBER
            /*, P_OPERATING_UNIT_ID                 IN NUMBER*/
            , P_WORK_CORP_ID                      IN NUMBER
            , P_DEPT_ID                           IN NUMBER
            /*, P_NATION_ID                         IN NUMBER
            , P_WORK_AREA_ID                      IN NUMBER*/
            , P_WORK_TYPE_ID                      IN NUMBER
            , P_JOB_CLASS_ID                      IN NUMBER
            /*, P_JOB_ID                            IN NUMBER*/
            , P_POST_ID                           IN NUMBER
            /*, P_OCPT_ID                           IN NUMBER
            , P_ABIL_ID                           IN NUMBER*/
            , P_PAY_GRADE_ID                      IN NUMBER
            , P_REPRE_NUM                         IN VARCHAR2
            , P_SEX_TYPE                          IN VARCHAR2
            /*, P_BIRTHDAY                          IN DATE
            , P_BIRTHDAY_TYPE                     IN VARCHAR2
            , P_MARRY_YN                          IN VARCHAR2
            , P_MARRY_DATE                        IN DATE
            , P_JOIN_ID                           IN NUMBER
            , P_JOIN_ROUTE_ID                     IN NUMBER*/
            , P_ORI_JOIN_DATE                     IN DATE
            , P_JOIN_DATE                         IN DATE
            /*, P_PAY_DATE                          IN DATE
            , P_DEPT_DATE                         IN DATE
            , P_OFFICIALLY_DATE                   IN DATE
            , P_SHO_DATE                          IN DATE
            , P_EXPIRE_DATE                       IN DATE
            , P_PROMOTION_EXPECT_DATE             IN DATE
            , P_DIR_INDIR_TYPE                    IN VARCHAR2*/
            , P_EMPLOYE_TYPE                      IN VARCHAR2
            /*, P_LEGAL_ZIP_CODE                    IN VARCHAR2
            , P_LEGAL_ADDR1                       IN VARCHAR2
            , P_LEGAL_ADDR2                       IN VARCHAR2
            , P_PRSN_ZIP_CODE                     IN VARCHAR2
            , P_PRSN_ADDR1                        IN VARCHAR2
            , P_PRSN_ADDR2                        IN VARCHAR2
            , P_LIVE_ZIP_CODE                     IN VARCHAR2
            , P_LIVE_ADDR1                        IN VARCHAR2
            , P_LIVE_ADDR2                        IN VARCHAR2*/
            , P_TELEPHON_NO                       IN VARCHAR2
            , P_HP_PHONE_NO                       IN VARCHAR2
            /*, P_EMAIL                             IN VARCHAR2
            , P_RELIGION_ID                       IN NUMBER
            , P_END_SCH_ID                        IN NUMBER
            , P_HOBBY                             IN VARCHAR2
            , P_TALENT                            IN VARCHAR2*/
            , P_JOB_CATEGORY_ID                   IN NUMBER
            , P_FLOOR_ID                          IN NUMBER
            , P_COST_CENTER_ID                    IN NUMBER
            , P_IC_CARD_NO                        IN VARCHAR2
            /*, P_OLD_PERSON_NUM                    IN VARCHAR2*/
            , P_CORP_TYPE                         IN VARCHAR2
            , P_SOB_ID                            IN NUMBER
            , P_ORG_ID                            IN NUMBER
            /*, P_DESCRIPTION                       IN VARCHAR2*/
            , P_USER_ID                           IN NUMBER
            )
  AS
    N_SYSDATE                                     DATE;
    N_PERSON_ID                                   HRM_PERSON_MASTER.PERSON_ID%TYPE := 0;
    N_PERSON_SEQ                                  NUMBER := 0;
    V_YEAR                                        EAPP_CALENDAR_YEAR.YEAR_STRING%TYPE := NULL;
    V_FIX_CHAR                                    VARCHAR2(2);
    V_PERSON_NUM                                  HRM_PERSON_MASTER.PERSON_NUM%TYPE := NULL;
    
    V_REPRE_NUM                                   VARCHAR2(20);  -- 주민번호.
    
    N_DEFAULT_POST_ID                             HRM_PERSON_MASTER.POST_ID%TYPE;
    N_DEFAULT_PAY_GRADE_ID                        HRM_PERSON_MASTER.PAY_GRADE_ID%TYPE;
    V_DUTY_CONTROL_YN                             VARCHAR2(2);
    V_WORK_DATE_FR                                DATE;
    V_WORK_DATE_TO                                DATE;
    V_MESSAGE                                     VARCHAR2(300);

  BEGIN
    N_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
    
/*--------------------------------------------------------------------------------------*/
    -- BH 사번 채계 : X(O - 2000년 이전 입사자, B- 2000년 이후 입사자, O-파견직) + XX(년도) + XXX(일련번호).
    V_YEAR := TO_CHAR(P_ORI_JOIN_DATE, 'YYYY');
    IF P_CORP_TYPE = '2' THEN
      V_FIX_CHAR := 'K';
    ELSIF P_CORP_TYPE = '3' THEN
      V_FIX_CHAR := 'P';
    ELSIF P_CORP_TYPE = '4' THEN
      V_FIX_CHAR := 'O';
    ELSIF P_CORP_TYPE = '5' THEN
      V_FIX_CHAR := 'S';
    END IF;
    
    -- 파견업체.
    IF V_YEAR < '2000' THEN
      V_PERSON_NUM := V_FIX_CHAR || SUBSTR(V_YEAR, 3, 2) ;
    ELSE
      V_PERSON_NUM := V_FIX_CHAR || SUBSTR(V_YEAR, 3, 2) ;
    END IF;

    BEGIN
      SELECT NVL(TO_NUMBER(REPLACE(MAX(PM.PERSON_NUM), V_FIX_CHAR, '')), 0) + 1 AS MAX_PERSON_NUM
        INTO N_PERSON_SEQ
        FROM HRM_PERSON_MASTER PM
      WHERE PM.SOB_ID                 = P_SOB_ID
        AND PM.ORG_ID                 = P_ORG_ID
        AND TO_CHAR(PM.ORI_JOIN_DATE, 'YYYY') = V_YEAR
        AND PM.CORP_TYPE              = P_CORP_TYPE  -- '4' : 전호수 수정.
      ;
    EXCEPTION WHEN OTHERS THEN
      N_PERSON_SEQ := 1;
    END;
    IF N_PERSON_SEQ = 1 THEN
      V_PERSON_NUM := V_PERSON_NUM || LPAD(TO_CHAR(N_PERSON_SEQ), 5, 0);
    ELSE
      V_PERSON_NUM := V_FIX_CHAR || LPAD(TO_CHAR(N_PERSON_SEQ), 7, 0);
    END IF;
    IF V_PERSON_NUM IS NULL THEN
      P_PERSON_NUM := '-';
      RETURN;
    END IF;
/*--------------------------------------------------------------------------------------*/
-- POST ID NULL 일경우 DEFAULT 값 적용.  -- CODE : 520
    N_DEFAULT_POST_ID := NULL;
    BEGIN
      N_DEFAULT_POST_ID := HRM_COMMON_G.GET_ID_F('POST', 'CODE = ''520''', P_SOB_ID, P_ORG_ID);
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
-- PAY GRADE ID NULL 일경우 DEFAULT 값 적용.  -- CODE : 8B
    N_DEFAULT_PAY_GRADE_ID := NULL;
    BEGIN
      N_DEFAULT_PAY_GRADE_ID := HRM_COMMON_G.GET_ID_F('PAY_GRADE', 'CODE = ''8B''', P_SOB_ID, P_ORG_ID);
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
/*--------------------------------------------------------------------------------------*/

-- 주민번호 형식 적용.
    IF P_REPRE_NUM IS NULL THEN
      V_REPRE_NUM := NULL;
    ELSE
      V_REPRE_NUM := SUBSTR(RPAD(REPLACE(P_REPRE_NUM, '-', ''), 13, '*'), 1, 6) || '-' || SUBSTR(RPAD(REPLACE(P_REPRE_NUM, '-', ''), 13, '*'), 7, 13);
    END IF;
    
    -- 일련번호 채번.
    SELECT HRM_PERSON_MASTER_S1.NEXTVAL
      INTO N_PERSON_ID
    FROM DUAL;
    IF N_PERSON_ID IS NULL THEN
      RETURN;
    END IF;

/*--------------------------------------------------------------------------------------*/
-- (신규 입사) - 인사발령 사항 저장 - TRIGGER 적용.
/*--------------------------------------------------------------------------------------*/
    INSERT INTO HRM_PERSON_MASTER
      ( PERSON_ID, PERSON_NUM, NAME/*, NAME1, NAME2*/
      , CORP_ID/*, OPERATING_UNIT_ID*/, WORK_CORP_ID, DEPT_ID
      /*, NATION_ID, WORK_AREA_ID*/, WORK_TYPE_ID, JOB_CLASS_ID
      /*, JOB_ID*/, POST_ID/*, OCPT_ID, ABIL_ID*/
      , PAY_GRADE_ID, REPRE_NUM, SEX_TYPE
      /*, BIRTHDAY, BIRTHDAY_TYPE, MARRY_YN, MARRY_DATE
      , JOIN_ID, JOIN_ROUTE_ID*/
      , ORI_JOIN_DATE, JOIN_DATE/*, PAY_DATE, DEPT_DATE
      , OFFICIALLY_DATE, SHO_DATE, EXPIRE_DATE, PROMOTION_EXPECT_DATE
      , DIR_INDIR_TYPE*/, EMPLOYE_TYPE
      /*, LEGAL_ZIP_CODE, LEGAL_ADDR1, LEGAL_ADDR2
      , PRSN_ZIP_CODE, PRSN_ADDR1, PRSN_ADDR2
      , LIVE_ZIP_CODE, LIVE_ADDR1, LIVE_ADDR2*/
      , TELEPHON_NO, HP_PHONE_NO/*, EMAIL
      , RELIGION_ID, END_SCH_ID, HOBBY, TALENT*/
      , JOB_CATEGORY_ID, FLOOR_ID, COST_CENTER_ID
      , IC_CARD_NO/*, OLD_PERSON_NUM*/
      , CORP_TYPE, SOB_ID, ORG_ID, DISPLAY_NAME
      /*, DESCRIPTION*/
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
      ) VALUES
      ( N_PERSON_ID, V_PERSON_NUM, P_NAME/*, P_NAME1, P_NAME2*/
      , P_CORP_ID/*, P_OPERATING_UNIT_ID*/, P_WORK_CORP_ID, P_DEPT_ID
      /*, P_NATION_ID, P_WORK_AREA_ID*/, P_WORK_TYPE_ID, P_JOB_CLASS_ID
      /*, P_JOB_ID*/, N_DEFAULT_POST_ID/*, P_OCPT_ID, P_ABIL_ID*/
      , N_DEFAULT_PAY_GRADE_ID, V_REPRE_NUM, P_SEX_TYPE
      /*, TRUNC(P_BIRTHDAY), P_BIRTHDAY_TYPE, NVL(P_MARRY_YN, 'N'), TRUNC(P_MARRY_DATE)
      , P_JOIN_ID, P_JOIN_ROUTE_ID*/
      , TRUNC(P_ORI_JOIN_DATE), TRUNC(P_JOIN_DATE)/*, TRUNC(P_PAY_DATE), TRUNC(P_DEPT_DATE)
      , TRUNC(P_OFFICIALLY_DATE), TRUNC(P_SHO_DATE), TRUNC(P_EXPIRE_DATE), TRUNC(P_PROMOTION_EXPECT_DATE)
      , P_DIR_INDIR_TYPE*/, P_EMPLOYE_TYPE
      /*, P_LEGAL_ZIP_CODE, P_LEGAL_ADDR1, P_LEGAL_ADDR2
      , P_PRSN_ZIP_CODE, P_PRSN_ADDR1, P_PRSN_ADDR2
      , P_LIVE_ZIP_CODE, P_LIVE_ADDR1, P_LIVE_ADDR2*/
      , P_TELEPHON_NO, P_HP_PHONE_NO/*, P_EMAIL
      , P_RELIGION_ID, P_END_SCH_ID, P_HOBBY, P_TALENT*/
      , P_JOB_CATEGORY_ID, P_FLOOR_ID, P_COST_CENTER_ID
      , P_IC_CARD_NO/*, P_OLD_PERSON_NUM*/
      , P_CORP_TYPE, P_SOB_ID, P_ORG_ID, P_NAME || '(' || V_PERSON_NUM ||')'
      /*, P_DESCRIPTION*/
      , N_SYSDATE, P_USER_ID, N_SYSDATE, P_USER_ID
      );

      P_PERSON_ID := N_PERSON_ID;
      P_PERSON_NUM := V_PERSON_NUM;

/*--------------------------------------------------------------------------------------*/
-- 근무계획 생성.(신규 입사). - 근태관리 업체 소속, 기존 생성 기록 있는 사람에 대해 적용.
    V_DUTY_CONTROL_YN := 'N';
    V_WORK_DATE_FR := NULL;
    V_WORK_DATE_TO := NULL;
    BEGIN
      SELECT CM.DUTY_CONTROL_YN
        INTO V_DUTY_CONTROL_YN
        FROM HRM_CORP_MASTER CM
      WHERE CM.CORP_ID        = P_WORK_CORP_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;


    BEGIN
      SELECT WC.WORK_DATE_FR, WC.WORK_DATE_TO
        INTO V_WORK_DATE_FR, V_WORK_DATE_TO
        FROM HRD_WORK_CALENDAR_SET WC
      WHERE WC.CORP_ID            = P_WORK_CORP_ID
        AND WC.WORK_PERIOD        = TO_CHAR(P_ORI_JOIN_DATE, 'YYYY-MM')
        AND WC.WORK_TYPE_ID       = P_WORK_TYPE_ID
        AND WC.CREATED_METHOD     = 'A'
        AND WC.SOB_ID             = P_SOB_ID
        AND WC.ORG_ID             = P_ORG_ID
        AND ROWNUM                <= 1 --< [2011-07-11] 추가
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;


    IF V_DUTY_CONTROL_YN = 'Y' AND V_WORK_DATE_FR IS NOT NULL AND V_WORK_DATE_TO IS NOT NULL THEN
      HRD_WORK_CALENDAR_G.WORKCAL_SET_TABLE
                        ( P_CORP_ID => P_WORK_CORP_ID
                        , P_WORK_PERIOD => TO_CHAR(P_ORI_JOIN_DATE, 'YYYY-MM')
                        , P_PERSON_ID => P_PERSON_ID
                        , P_FLOOR_ID => NULL
                        , P_WORK_TYPE_ID => P_WORK_TYPE_ID
                        , P_WORK_DATE_FR => V_WORK_DATE_FR
                        , P_WORK_DATE_TO => V_WORK_DATE_TO
                        , P_USER_ID => P_USER_ID
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        , O_MESSAGE => V_MESSAGE
                        , P_CREATE_TYPE => 'INSA'
                        );
    END IF;
    DBMS_OUTPUT.PUT_LINE('Work Calendar Create Message : ' || V_MESSAGE);

   -- HRD_PERSON_HISTORY 신규 추가[2011-07-19]
   HRD_PERSON_HISTORY_G.INSERT_PERSON_HISTORY
                             ( P_WORK_CORP_ID
                             , P_PERSON_ID
                             , P_JOIN_DATE
                             , P_FLOOR_ID
                             , P_WORK_TYPE_ID
                             , P_FLOOR_ID
                             , P_WORK_TYPE_ID
                             , 'NEW'
                             , P_SOB_ID
                             , P_ORG_ID
                             , P_USER_ID
                             , P_DEPT_ID
                             , P_DEPT_ID
                             );

  END DISPATCH_DATA_INSERT;

-- DISPATCH PERSON DATA_UPDATE..
  PROCEDURE DISPATCH_DATA_UPDATE
           ( W_PERSON_ID                         IN NUMBER
      , P_NAME                              IN VARCHAR2
      /*, P_NAME1                             IN VARCHAR2
      , P_NAME2                             IN VARCHAR2*/
      , P_CORP_ID                           IN NUMBER
            , P_WORK_CORP_ID                      IN NUMBER
       /*, P_OPERATING_UNIT_ID                 IN NUMBER*/
      , P_DEPT_ID                           IN NUMBER
      /*, P_NATION_ID                         IN NUMBER
      , P_WORK_AREA_ID                      IN NUMBER*/
      , P_WORK_TYPE_ID                      IN NUMBER
      , P_JOB_CLASS_ID                      IN NUMBER
      /*, P_JOB_ID                            IN NUMBER*/
      , P_POST_ID                           IN NUMBER
      /*, P_OCPT_ID                           IN NUMBER
      , P_ABIL_ID                           IN NUMBER*/
      , P_PAY_GRADE_ID                      IN NUMBER
      , P_REPRE_NUM                         IN VARCHAR2
      , P_SEX_TYPE                          IN VARCHAR2
      /*, P_BIRTHDAY                          IN DATE
      , P_BIRTHDAY_TYPE                     IN VARCHAR2
      , P_MARRY_YN                          IN VARCHAR2
      , P_MARRY_DATE                        IN DATE
      , P_JOIN_ID                           IN NUMBER
      , P_JOIN_ROUTE_ID                     IN NUMBER*/
      , P_ORI_JOIN_DATE                     IN DATE
      , P_JOIN_DATE                         IN DATE
      /*, P_PAY_DATE                          IN DATE
      , P_DEPT_DATE                         IN DATE
      , P_OFFICIALLY_DATE                   IN DATE
      , P_SHO_DATE                          IN DATE
      , P_EXPIRE_DATE                       IN DATE
      , P_PROMOTION_EXPECT_DATE             IN DATE*/
            , P_RETIRE_DATE                       IN DATE
            , P_RETIRE_ID                         IN NUMBER
      /*, P_DIR_INDIR_TYPE                    IN VARCHAR2*/
      , P_EMPLOYE_TYPE                      IN VARCHAR2
      /*, P_LEGAL_ZIP_CODE                    IN VARCHAR2
      , P_LEGAL_ADDR1                       IN VARCHAR2
      , P_LEGAL_ADDR2                       IN VARCHAR2
      , P_PRSN_ZIP_CODE                     IN VARCHAR2
      , P_PRSN_ADDR1                        IN VARCHAR2
      , P_PRSN_ADDR2                        IN VARCHAR2
      , P_LIVE_ZIP_CODE                     IN VARCHAR2
      , P_LIVE_ADDR1                        IN VARCHAR2
      , P_LIVE_ADDR2                        IN VARCHAR2*/
      , P_TELEPHON_NO                       IN VARCHAR2
      , P_HP_PHONE_NO                       IN VARCHAR2
      /*, P_EMAIL                             IN VARCHAR2
      , P_RELIGION_ID                       IN NUMBER
      , P_END_SCH_ID                        IN NUMBER
      , P_HOBBY                             IN VARCHAR2
      , P_TALENT                            IN VARCHAR2*/
      , P_JOB_CATEGORY_ID                   IN NUMBER
      , P_FLOOR_ID                          IN NUMBER
      , P_COST_CENTER_ID                    IN NUMBER
      , P_IC_CARD_NO                        IN VARCHAR2
      /*, P_OLD_PERSON_NUM                    IN VARCHAR2*/
      , P_CORP_TYPE                         IN VARCHAR2
      /*, P_SOB_ID                            IN NUMBER
      , P_ORG_ID                            IN NUMBER
      , P_DESCRIPTION                       IN VARCHAR2*/
      , P_USER_ID                           IN NUMBER
      )
  AS
    V_REPRE_NUM                                   VARCHAR2(20);  -- 주민번호.
  BEGIN
    -- 주민번호 형식 적용.
    IF P_REPRE_NUM IS NULL THEN
      V_REPRE_NUM := NULL;
    ELSE
      V_REPRE_NUM := SUBSTR(RPAD(REPLACE(P_REPRE_NUM, '-', ''), 13, '*'), 1, 6) || '-' || SUBSTR(RPAD(REPLACE(P_REPRE_NUM, '-', ''), 13, '*'), 7, 13);
    END IF;
    
    UPDATE HRM_PERSON_MASTER PM
      SET     PM.NAME                                               = P_NAME
           /* , PM.NAME1                                              = P_NAME1
            , PM.NAME2                                              = P_NAME2*/
            , PM.CORP_ID                                            = P_CORP_ID
            , PM.WORK_CORP_ID                                       = P_WORK_CORP_ID
            /*, PM.NATION_ID                                          = P_NATION_ID
            , PM.WORK_AREA_ID                                       = P_WORK_AREA_ID*/
            --[2011-08-25], PM.WORK_TYPE_ID                                       = P_WORK_TYPE_ID
            , PM.REPRE_NUM                                          = V_REPRE_NUM
            , PM.SEX_TYPE                                           = P_SEX_TYPE
            /*, PM.BIRTHDAY                                           = TRUNC(P_BIRTHDAY)
            , PM.BIRTHDAY_TYPE                                      = P_BIRTHDAY_TYPE
            , PM.MARRY_YN                                           = P_MARRY_YN
            , PM.MARRY_DATE                                         = TRUNC(P_MARRY_DATE)
            , PM.JOIN_ID                                            = P_JOIN_ID
            , PM.JOIN_ROUTE_ID                                      = P_JOIN_ROUTE_ID*/
            , PM.ORI_JOIN_DATE                                      = TRUNC(P_ORI_JOIN_DATE)
            , PM.JOIN_DATE                                          = TRUNC(P_JOIN_DATE)
            , PM.RETIRE_DATE                                        = TRUNC(P_RETIRE_DATE)
            , PM.RETIRE_ID                                          = P_RETIRE_ID
            /*, PM.PAY_DATE                                           = TRUNC(P_PAY_DATE)
            , PM.DEPT_DATE                                          = TRUNC(P_DEPT_DATE)
            , PM.OFFICIALLY_DATE                                    = TRUNC(P_OFFICIALLY_DATE)
            , PM.SHO_DATE                                           = TRUNC(P_SHO_DATE)
            , PM.EXPIRE_DATE                                        = TRUNC(P_EXPIRE_DATE)
            , PM.PROMOTION_EXPECT_DATE                              = TRUNC(P_PROMOTION_EXPECT_DATE)
            , PM.DIR_INDIR_TYPE                                     = P_DIR_INDIR_TYPE*/
            , PM.EMPLOYE_TYPE                                       = P_EMPLOYE_TYPE
            /*, PM.LEGAL_ZIP_CODE                                     = P_LEGAL_ZIP_CODE
            , PM.LEGAL_ADDR1                                        = P_LEGAL_ADDR1
            , PM.LEGAL_ADDR2                                        = P_LEGAL_ADDR2
            , PM.PRSN_ZIP_CODE                                      = P_PRSN_ZIP_CODE
            , PM.PRSN_ADDR1                                         = P_PRSN_ADDR1
            , PM.PRSN_ADDR2                                         = P_PRSN_ADDR2
            , PM.LIVE_ZIP_CODE                                      = P_LIVE_ZIP_CODE
            , PM.LIVE_ADDR1                                         = P_LIVE_ADDR1
            , PM.LIVE_ADDR2                                         = P_LIVE_ADDR2*/
            , PM.TELEPHON_NO                                        = P_TELEPHON_NO
            , PM.HP_PHONE_NO                                        = P_HP_PHONE_NO
            /*, PM.EMAIL                                              = P_EMAIL
            , PM.RELIGION_ID                                        = P_RELIGION_ID
            , PM.END_SCH_ID                                         = P_END_SCH_ID
            , PM.HOBBY                                              = P_HOBBY
            , PM.TALENT                                             = P_TALENT*/
            , PM.COST_CENTER_ID                                     = P_COST_CENTER_ID
            , PM.IC_CARD_NO                                         = P_IC_CARD_NO
            /*, PM.OLD_PERSON_NUM                                     = P_OLD_PERSON_NUM
            , PM.CORP_TYPE                                          = '4'                                      -- CORP_TYPE.
            , PM.DESCRIPTION                                        = P_DESCRIPTION*/
            , PM.LAST_UPDATE_DATE                                   = GET_LOCAL_DATE(PM.SOB_ID)
            , PM.LAST_UPDATED_BY                                    = P_USER_ID
            /*, PM.OPERATING_UNIT_ID                                  = P_OPERATING_UNIT_ID*/
            --[2011-11-28], PM.DEPT_ID                                            = P_DEPT_ID
            , PM.JOB_CLASS_ID                                       = P_JOB_CLASS_ID
            /*, PM.JOB_ID                                             = P_JOB_ID
            , PM.POST_ID                                            = P_POST_ID   --[2011-06-28] 수정시 NULL 값 들어감.
            , PM.OCPT_ID                                            = P_OCPT_ID
            , PM.ABIL_ID                                            = P_ABIL_ID
            , PM.PAY_GRADE_ID                                       = P_PAY_GRADE_ID*/
            , PM.JOB_CATEGORY_ID                                    = P_JOB_CATEGORY_ID
            --[2011-08-25], PM.FLOOR_ID                                           = P_FLOOR_ID
      WHERE PM.PERSON_ID                                            = W_PERSON_ID
      ;

    -- 최종 인사발령사항 적용.
    BEGIN
      --UPDATE HRM_HISTORY_LINE HL
      --   SET HL.DEPT_ID          = P_DEPT_ID
      --     , HL.FLOOR_ID         = P_FLOOR_ID
      --     , HL.CHARGE_DATE      = TRUNC(P_JOIN_DATE)
      -- WHERE HL.PERSON_ID        = W_PERSON_ID
      --   AND HL.HISTORY_LINE_ID  = ( SELECT MAX(HL1.HISTORY_LINE_ID) AS HISTORY_LINE_ID
      --                                 FROM HRM_HISTORY_LINE HL1
      --                                WHERE HL1.PERSON_ID             = HL.PERSON_ID
      --                             )
      --;
      
      --[2011-11-28]
      UPDATE HRM_HISTORY_LINE HL
         SET HL.CHARGE_DATE      = TRUNC(P_JOIN_DATE)
           , HL.JOB_CATEGORY_ID  = P_JOB_CATEGORY_ID
           , HL.JOB_CLASS_ID     = P_JOB_CLASS_ID
       WHERE HL.PERSON_ID        = W_PERSON_ID
         AND HL.HISTORY_LINE_ID  = ( SELECT MAX(HL1.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                       FROM HRM_HISTORY_LINE HL1
                                      WHERE HL1.PERSON_ID             = HL.PERSON_ID
                                   )
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10180', NULL));
    END;


   --작업장 수정 [2011-08-03]
    BEGIN
          --[2011-08-25]UPDATE HRD_PERSON_HISTORY PH
          --   SET PH.FLOOR_ID          = P_FLOOR_ID
          --     , PH.PRE_FLOOR_ID      = PH.FLOOR_ID
          -- WHERE PH.PERSON_ID         = W_PERSON_ID
          --     ;


          UPDATE HRD_PERSON_HISTORY
             SET EFFECTIVE_DATE_FR  =  P_JOIN_DATE
           WHERE PERSON_ID          =  W_PERSON_ID
             AND EFFECTIVE_DATE_FR  =  (
                                        SELECT MIN(EFFECTIVE_DATE_FR)
                                          FROM HRD_PERSON_HISTORY
                                         WHERE PERSON_ID = W_PERSON_ID
                                        )
               ;


    EXCEPTION 
         WHEN OTHERS 
         THEN
              RAISE_APPLICATION_ERROR(-20001, SQLERRM);

    END;





   --LOGIN USER UNENABLED [2011-11-03]
    BEGIN
         IF P_RETIRE_DATE IS NOT NULL THEN
          UPDATE EAPP_USER U
             SET U.ENABLED_FLAG = 'N'
               , U.EFFECTIVE_DATE_TO = P_RETIRE_DATE
           WHERE U.PERSON_ID = W_PERSON_ID
               ;
         END IF;

    EXCEPTION 
         WHEN OTHERS 
         THEN
              RAISE_APPLICATION_ERROR(-20001, SQLERRM);

    END;


  END DISPATCH_DATA_UPDATE;

-- SELECT PERSON INFOMATION.
  PROCEDURE SELECT_PERSON_S1
           ( P_CURSOR2                           OUT TYPES.TCURSOR2
      , W_CORP_ID                           IN NUMBER
      , W_PERSON_ID                         IN NUMBER
      , W_DEPT_ID                           IN NUMBER
      , W_STD_DATE                          IN DATE
      , W_SOB_ID                            IN NUMBER
      , W_ORG_ID                            IN NUMBER
      )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
   SELECT PM.NAME AS NAME
     , PM.PERSON_NUM
     , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID) AS CORP_NAME
     , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
     , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME
     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) AS EMPLOYE_TYPE_NAME
     , PM.ORI_JOIN_DATE
     , PM.JOIN_DATE
     , PM.RETIRE_DATE
     , PM.PERSON_ID
     , PM.CORP_ID
     , PM.DEPT_ID
     , PM.POST_ID
     , PM.PAY_GRADE_ID
   FROM HRM_PERSON_MASTER PM
     , (-- 시점 인사내역.
      SELECT HL.PERSON_ID
        , HL.DEPT_ID
        , HL.POST_ID
        , HL.PAY_GRADE_ID
        , HL.JOB_CATEGORY_ID
        , HL.FLOOR_ID
      FROM HRM_HISTORY_LINE HL
      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                      FROM HRM_HISTORY_LINE S_HL
                      WHERE S_HL.CHARGE_DATE            <= W_STD_DATE
                        AND S_HL.PERSON_ID              = HL.PERSON_ID
                      GROUP BY S_HL.PERSON_ID
                     )
     ) T1
   WHERE PM.PERSON_ID                               = T1.PERSON_ID
    AND PM.CORP_ID                                 = NVL(W_CORP_ID, PM.CORP_ID)
    AND PM.PERSON_ID                               = NVL(W_PERSON_ID, PM.PERSON_ID)
    AND T1.DEPT_ID                                 = NVL(W_DEPT_ID, T1.DEPT_ID)
    AND PM.ORI_JOIN_DATE                           <= W_STD_DATE
    AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_STD_DATE)
    AND PM.SOB_ID                                  = W_SOB_ID
    AND PM.ORG_ID                                  = W_ORG_ID
   ;
  END SELECT_PERSON_S1;

-- SELECT PERSON INFOMATION.
  PROCEDURE SELECT_PERSON_S2
           ( P_CURSOR2                           OUT TYPES.TCURSOR2
      , W_CORP_ID                           IN NUMBER
      , W_NAME                              IN VARCHAR2
      , W_DEPT_ID                           IN NUMBER
      , W_START_DATE                        IN DATE
      , W_END_DATE                          IN DATE
      , W_SOB_ID                            IN NUMBER
      , W_ORG_ID                            IN NUMBER
      )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
   SELECT PM.NAME AS NAME
     , PM.PERSON_NUM
     , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID) AS CORP_NAME
     , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
     , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME
     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) AS EMPLOYE_TYPE_NAME
     , PM.ORI_JOIN_DATE
     , PM.JOIN_DATE
     , PM.RETIRE_DATE
     , PM.PERSON_ID
     , PM.CORP_ID
     , PM.DEPT_ID
     , PM.POST_ID
     , PM.PAY_GRADE_ID
   FROM HRM_PERSON_MASTER PM
    , (-- 시점 인사내역.
      SELECT HL.PERSON_ID
        , HL.DEPT_ID
        , HL.POST_ID
        , HL.PAY_GRADE_ID
        , HL.JOB_CATEGORY_ID
        , HL.FLOOR_ID
      FROM HRM_HISTORY_LINE HL
      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                      FROM HRM_HISTORY_LINE S_HL
                      WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                        AND S_HL.PERSON_ID              = HL.PERSON_ID
                      GROUP BY S_HL.PERSON_ID
                     )
     ) T1
   WHERE PM.PERSON_ID                               = T1.PERSON_ID
    AND PM.CORP_ID                                 = NVL(W_CORP_ID, PM.CORP_ID)
    AND PM.NAME                                    = NVL(W_NAME, PM.NAME)
    AND T1.DEPT_ID                                 = NVL(W_DEPT_ID, T1.DEPT_ID)
    AND PM.ORI_JOIN_DATE                           <= W_END_DATE
    AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_START_DATE)
    AND PM.SOB_ID                                  = W_SOB_ID
    AND PM.ORG_ID                                  = W_ORG_ID
   ;

  END SELECT_PERSON_S2;

-- SELECT PERSON INFOMATION.
  PROCEDURE SELECT_PERSON_S3
           ( P_CURSOR3                           OUT TYPES.TCURSOR3
      , W_CORP_ID                           IN NUMBER
      , W_PERSON_ID                         IN NUMBER
      , W_DEPT_ID                           IN NUMBER
            , W_FLOOR_ID                          IN NUMBER
      , W_STD_DATE                          IN DATE
      , W_SOB_ID                            IN NUMBER
      , W_ORG_ID                            IN NUMBER
      )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
   SELECT PM.NAME AS NAME
     , PM.PERSON_NUM
     , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID) AS CORP_NAME
     , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
          , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
     , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME
     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) AS EMPLOYE_TYPE_NAME
     , PM.ORI_JOIN_DATE
     , PM.JOIN_DATE
     , PM.RETIRE_DATE
          , PM.REPRE_NUM
          , EAPP_REGISTER_AGE_F(PM.REPRE_NUM, W_STD_DATE, 0) AS AGE
     , PM.PERSON_ID
     , PM.CORP_ID
     , T1.DEPT_ID
          , T2.FLOOR_ID
     , T1.POST_ID
     , T1.PAY_GRADE_ID
   FROM HRM_PERSON_MASTER PM
     , (-- 시점 인사내역.
      SELECT HL.PERSON_ID
        , HL.DEPT_ID
        , HL.POST_ID
        , HL.PAY_GRADE_ID
        , HL.JOB_CATEGORY_ID
      FROM HRM_HISTORY_LINE HL
      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                      FROM HRM_HISTORY_LINE S_HL
                      WHERE S_HL.CHARGE_DATE            <= W_STD_DATE
                        AND S_HL.PERSON_ID              = HL.PERSON_ID
                      GROUP BY S_HL.PERSON_ID
                     )
     ) T1
               , (-- 시점 인사내역.
                  SELECT PH.PERSON_ID
                       , PH.FLOOR_ID
                    FROM HRD_PERSON_HISTORY        PH
                   WHERE PH.EFFECTIVE_DATE_FR  <=  W_STD_DATE
                     AND PH.EFFECTIVE_DATE_TO  >=  W_STD_DATE
                 ) T2
   WHERE PM.PERSON_ID                               = T1.PERSON_ID
    AND PM.PERSON_ID                               = T2.PERSON_ID
    AND PM.CORP_ID                                 = NVL(W_CORP_ID, PM.CORP_ID)
    AND PM.PERSON_ID                               = NVL(W_PERSON_ID, PM.PERSON_ID)
    AND T1.DEPT_ID                                 = NVL(W_DEPT_ID, T1.DEPT_ID)
        AND T2.FLOOR_ID                                = NVL(W_FLOOR_ID, T2.FLOOR_ID)
    AND PM.ORI_JOIN_DATE                           <= W_STD_DATE
    AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_STD_DATE)
    AND PM.SOB_ID                                  = W_SOB_ID
    AND PM.ORG_ID                                  = W_ORG_ID
   ;
  END SELECT_PERSON_S3;


-- SELECT PERSON INFOMATION.
  PROCEDURE SELECT_PERSON_S4
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_PERSON_ID                         IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_FLOOR_ID                          IN NUMBER
            , W_STD_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT PM.NAME AS NAME
          , PM.PERSON_NUM
          , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID) AS CORP_NAME
          , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.FLOOR_ID) AS FLOOR_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME  
          , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) AS EMPLOYE_TYPE_NAME
          , PM.ORI_JOIN_DATE
          , PM.JOIN_DATE
          , PM.RETIRE_DATE
          , PM.REPRE_NUM
          , EAPP_REGISTER_AGE_F(PM.REPRE_NUM, W_STD_DATE, 0) AS AGE
          , PM.PERSON_ID
          , PM.CORP_ID
          , T1.DEPT_ID
          , T1.FLOOR_ID
          , T1.POST_ID
          , T1.PAY_GRADE_ID
      FROM HRM_PERSON_MASTER PM
        , (-- 시점 인사내역.
            SELECT HL.PERSON_ID
                , HL.DEPT_ID
                , HL.POST_ID
                , HL.PAY_GRADE_ID
                , HL.JOB_CATEGORY_ID
                , HL.FLOOR_ID    
            FROM HRM_HISTORY_LINE HL  
            WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                            FROM HRM_HISTORY_LINE S_HL
                                           WHERE S_HL.CHARGE_DATE            <= W_STD_DATE
                                             AND S_HL.PERSON_ID              = HL.PERSON_ID
                                           GROUP BY S_HL.PERSON_ID
                                         )
          ) T1
      WHERE PM.PERSON_ID                               = T1.PERSON_ID
        AND PM.CORP_ID                                 = NVL(W_CORP_ID, PM.CORP_ID)
        AND PM.PERSON_ID                               = NVL(W_PERSON_ID, PM.PERSON_ID)
        AND T1.DEPT_ID                                 = NVL(W_DEPT_ID, T1.DEPT_ID)
        AND T1.FLOOR_ID                                = NVL(W_FLOOR_ID, T1.FLOOR_ID)
        AND PM.ORI_JOIN_DATE                           <= LAST_DAY(W_STD_DATE)
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= TRUNC(W_STD_DATE, 'MONTH'))
        AND PM.SOB_ID                                  = W_SOB_ID
        AND PM.ORG_ID                                  = W_ORG_ID
      ;
  END SELECT_PERSON_S4;

-- SELECT PERSON INFOMATION.
  PROCEDURE SELECT_PERSON_S5
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_CORP_ID                           IN NUMBER
						, W_PERSON_ID                         IN NUMBER
						, W_DEPT_ID                           IN NUMBER
            , W_FLOOR_ID                          IN NUMBER
						, W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
						, W_SOB_ID                            IN NUMBER
						, W_ORG_ID                            IN NUMBER
						)
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT PM.NAME AS NAME
          , PM.PERSON_NUM
          , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID) AS CORP_NAME
          , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.FLOOR_ID) AS FLOOR_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME  
          , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) AS EMPLOYE_TYPE_NAME
          , PM.ORI_JOIN_DATE
          , PM.JOIN_DATE
          , PM.RETIRE_DATE
          , PM.REPRE_NUM
          , EAPP_REGISTER_AGE_F(PM.REPRE_NUM, W_END_DATE, 0) AS AGE
          , PM.PERSON_ID
          , PM.CORP_ID
          , T1.DEPT_ID
          , T1.FLOOR_ID
          , T1.POST_ID
          , T1.PAY_GRADE_ID
      FROM HRM_PERSON_MASTER PM
        , (-- 시점 인사내역.
            SELECT HL.PERSON_ID
                , HL.DEPT_ID
                , HL.POST_ID
                , HL.PAY_GRADE_ID
                , HL.JOB_CATEGORY_ID
                , HL.FLOOR_ID    
            FROM HRM_HISTORY_LINE HL  
            WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                            FROM HRM_HISTORY_LINE S_HL
                                           WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                                             AND S_HL.PERSON_ID              = HL.PERSON_ID
                                           GROUP BY S_HL.PERSON_ID
                                         )
          ) T1
      WHERE PM.PERSON_ID                               = T1.PERSON_ID
        AND PM.CORP_ID                                 = NVL(W_CORP_ID, PM.CORP_ID)
        AND PM.PERSON_ID                               = NVL(W_PERSON_ID, PM.PERSON_ID)
        AND T1.DEPT_ID                                 = NVL(W_DEPT_ID, T1.DEPT_ID)
        AND T1.FLOOR_ID                                = NVL(W_FLOOR_ID, T1.FLOOR_ID)
        AND PM.ORI_JOIN_DATE                           <= W_END_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_START_DATE)
        AND PM.SOB_ID                                  = W_SOB_ID
        AND PM.ORG_ID                                  = W_ORG_ID
      ;
  END SELECT_PERSON_S5;
  
-- 사원명부 조회 기가별 재직자 사원 조회[2011-11-15]
   PROCEDURE SELECT_DETAIL_PERSON_PERIOD
           ( P_CURSOR       OUT TYPES.TCURSOR
           , W_SOB_ID       IN  HRM_PERSON_MASTER.SOB_ID%TYPE
           , W_ORG_ID       IN  HRM_PERSON_MASTER.ORG_ID%TYPE
           , W_CORP_ID      IN  HRM_PERSON_MASTER.CORP_ID%TYPE
           , W_DEPT_ID      IN  HRM_PERSON_MASTER.DEPT_ID%TYPE
           , W_FLOOR_ID     IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
           , W_PERSON_NAME  IN  HRM_PERSON_MASTER.NAME%TYPE
           , W_DATE_START   IN  HRM_PERSON_MASTER.JOIN_DATE%TYPE
           , W_DATE_END     IN  HRM_PERSON_MASTER.RETIRE_DATE%TYPE
           )

   AS

   BEGIN
             OPEN P_CURSOR FOR
             SELECT PM.PERSON_ID
                  , PM.PERSON_NUM
                  , PM.NAME
                  , PM.NAME1
                  , PM.NAME2
                  , PM.NATION_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.NATION_ID) AS  NATION_NAME
                  , PM.CORP_ID
                  , CM.CORP_NAME
                  , PM.OPERATING_UNIT_ID
                  , OU.OPERATING_UNIT_NAME
                  , PM.DEPT_ID
                  --, DM.DEPT_NAME
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID) AS DEPT_NAME
                  , PM.FLOOR_ID
                  , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS  FLOOR_NAME
                  , PM.OCPT_ID
                  , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID) AS  OCPT_NAME
                  , PM.WORK_TYPE_ID
                  , HRM_COMMON_G.ID_NAME_F(T2.WORK_TYPE_ID) AS  WORK_TYPE_NAME
                  , PM.JOB_CATEGORY_ID
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS  JOB_CATEGORY_NAME
                  , PM.JOB_CLASS_ID
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID) AS  JOB_CLASS_NAME
                  , PM.JOB_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_ID) AS  JOB_NAME
                  , PM.POST_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS  POST_NAME
                  , PM.ABIL_ID
                  , HRM_COMMON_G.ID_NAME_F(T1.ABIL_ID) AS  ABIL_NAME
                  , PM.PAY_GRADE_ID
                  , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS  PAY_GRADE_NAME
                  , PM.COST_CENTER_ID
                  , HRM_COMMON_G.COST_CENTER_DESC_F(PM.COST_CENTER_ID) AS COST_CENTER
                  , PM.EMPLOYE_TYPE
                  , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS  EMPLOYE_TYPE_NAME
                  , PM.CORP_TYPE
                  , HRM_COMMON_G.CODE_NAME_F('CORP_TYPE', PM.CORP_TYPE, PM.SOB_ID, PM.ORG_ID) AS CORP_TYPE_NAME
                  , PM.WORK_AREA_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.WORK_AREA_ID) AS  WORK_AREA_NAME
                  , PM.REPRE_NUM
                  , PM.SEX_TYPE
                  , HRM_COMMON_G.CODE_NAME_F('SEX_TYPE', PM.SEX_TYPE, PM.SOB_ID, PM.ORG_ID) AS  SEX_NAME
                  , PM.BIRTHDAY
                  , NVL(PM.BIRTHDAY_TYPE, 'N') AS BIRTHDAY_TYPE
                  , HRM_COMMON_G.CODE_NAME_F('BIRTHDAY_TYPE', PM.BIRTHDAY_TYPE, PM.SOB_ID, PM.ORG_ID) AS  BIRTHDAY_TYPE_NAME
                  , PM.MARRY_YN
                  , PM.MARRY_DATE
                  , PM.JOIN_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.JOIN_ID) AS  JOIN_NAME
                  , PM.JOIN_ROUTE_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.JOIN_ROUTE_ID) AS  JOIN_ROUTE_NAME
                  , PM.ORI_JOIN_DATE
                  , PM.JOIN_DATE
                  , PM.PAY_DATE
                  , PM.DEPT_DATE
                  , PM.OFFICIALLY_DATE
                  , PM.SHO_DATE
                  , PM.EXPIRE_DATE
                  , PM.PROMOTION_EXPECT_DATE
                  , PM.RETIRE_DATE
                  , PM.RETIRE_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.RETIRE_ID) AS  RETIRE_NAME
                  , PM.DIR_INDIR_TYPE
                  , HRM_COMMON_G.CODE_NAME_F('DIR_INDIR_TYPE', PM.DIR_INDIR_TYPE, PM.SOB_ID, PM.ORG_ID) AS  DIR_INDIR_TYPE_NAME
                  , PM.LEGAL_ZIP_CODE
                  , PM.LEGAL_ADDR1
                  , PM.LEGAL_ADDR2
                  , PM.PRSN_ZIP_CODE
                  , PM.PRSN_ADDR1
                  , PM.PRSN_ADDR2
                  , PM.LIVE_ZIP_CODE
                  , PM.LIVE_ADDR1
                  , PM.LIVE_ADDR2
                  , PM.TELEPHON_NO
                  , PM.HP_PHONE_NO
                  , PM.EMAIL
                  , PM.RELIGION_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.RELIGION_ID) AS  RELIGION_NAME
                  , PM.END_SCH_ID
                  , HRM_COMMON_G.ID_NAME_F(PM.END_SCH_ID) AS  END_SCH_NAME
                  , PM.HOBBY
                  , PM.TALENT
                  , PM.IC_CARD_NO
                  , PM.OLD_PERSON_NUM
                  , PM.DESCRIPTION
                  , EAPP_USER_G.USER_NAME_F(PM.LAST_UPDATED_BY) AS LAST_UPDATER
               FROM HRM_PERSON_MASTER         PM
                  , HRM_CORP_MASTER           CM
                  , HRM_OPERATING_UNIT        OU
                  , HRM_DEPT_MASTER           DM
             , (-- 시점 인사내역.
                SELECT HL.PERSON_ID
                     , HL.POST_ID
                     , HL.PAY_GRADE_ID
                     , HL.JOB_CATEGORY_ID
                     , HL.JOB_CLASS_ID
                     , HL.OCPT_ID
                     , HL.ABIL_ID
                  FROM HRM_HISTORY_LINE HL
                 WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                  FROM HRM_HISTORY_LINE S_HL
                                                 WHERE S_HL.CHARGE_DATE    <= W_DATE_END
                                                   AND S_HL.PERSON_ID       = HL.PERSON_ID
                                              GROUP BY S_HL.PERSON_ID
                                              )
               ) T1
             , (-- 시점 인사내역.
                SELECT PH.PERSON_ID
                     , PH.FLOOR_ID
                     , PH.WORK_TYPE_ID
                     , PH.DEPT_ID
                  FROM HRD_PERSON_HISTORY        PH
                 WHERE PH.EFFECTIVE_DATE_FR  <=  W_DATE_END
                   AND PH.EFFECTIVE_DATE_TO  >=  W_DATE_END
               ) T2
              WHERE PM.CORP_ID             =  CM.CORP_ID
                AND PM.OPERATING_UNIT_ID   =  OU.OPERATING_UNIT_ID(+)
                AND PM.DEPT_ID             =  DM.DEPT_ID
                AND PM.PERSON_ID           =  T1.PERSON_ID
                AND PM.PERSON_ID           =  T2.PERSON_ID
                AND PM.SOB_ID              =  W_SOB_ID
                AND PM.ORG_ID              =  W_ORG_ID
                AND PM.CORP_ID             =  NVL(W_CORP_ID,  PM.CORP_ID)
                AND PM.DEPT_ID             =  NVL(W_DEPT_ID,  PM.DEPT_ID)
                AND PM.FLOOR_ID            =  NVL(W_FLOOR_ID, PM.FLOOR_ID)
                AND PM.NAME                   LIKE W_PERSON_NAME || '%'
                AND PM.ORI_JOIN_DATE      <=  W_DATE_END
                AND NOT EXISTS (SELECT 'X'
                                  FROM HRM_PERSON_MASTER  S_PM
                                 WHERE S_PM.PERSON_ID   = PM.PERSON_ID
                                   AND S_PM.RETIRE_DATE < W_DATE_START
                               )
           ORDER BY PM.PERSON_NUM
                  , PM.NAME
                  ;

   END SELECT_DETAIL_PERSON_PERIOD;



-- 사원명부 조회.
  PROCEDURE SELECT_DETAIL_PERSON
            ( P_CURSOR2                           OUT TYPES.TCURSOR2
            , W_CORP_ID                           IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_FLOOR_ID                          IN NUMBER
            , W_STD_DATE                          IN DATE
            , W_NAME                              IN VARCHAR2
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            )

  AS

  BEGIN
        OPEN P_CURSOR2 FOR
        SELECT PM.PERSON_ID
             , PM.PERSON_NUM
             , PM.NAME
             , PM.NAME1
             , PM.NAME2
             , PM.NATION_ID
             , HRM_COMMON_G.ID_NAME_F(PM.NATION_ID) NATION_NAME
             , PM.CORP_ID
             , CM.CORP_NAME
             , PM.OPERATING_UNIT_ID
             , OU.OPERATING_UNIT_NAME
             , PM.DEPT_ID
             --, DM.DEPT_NAME
             , HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID) AS DEPT_NAME
             , PM.FLOOR_ID
             , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS  FLOOR_NAME
             , PM.OCPT_ID
             , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID) AS  OCPT_NAME
             , PM.WORK_TYPE_ID
             , HRM_COMMON_G.ID_NAME_F(T2.WORK_TYPE_ID) AS  WORK_TYPE_NAME
             , PM.JOB_CATEGORY_ID
             , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS  JOB_CATEGORY_NAME
             , PM.JOB_CLASS_ID
             , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID) AS  JOB_CLASS_NAME
             , PM.JOB_ID
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_ID) AS  JOB_NAME
             , PM.POST_ID
             , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS  POST_NAME
             , PM.ABIL_ID
             , HRM_COMMON_G.ID_NAME_F(T1.ABIL_ID) AS  ABIL_NAME
             , PM.PAY_GRADE_ID
             , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS  PAY_GRADE_NAME
             , PM.COST_CENTER_ID
             , HRM_COMMON_G.COST_CENTER_DESC_F(PM.COST_CENTER_ID) AS COST_CENTER
             , PM.EMPLOYE_TYPE
             , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS  EMPLOYE_TYPE_NAME
             , PM.CORP_TYPE
             , HRM_COMMON_G.CODE_NAME_F('CORP_TYPE', PM.CORP_TYPE, PM.SOB_ID, PM.ORG_ID) AS CORP_TYPE_NAME
             , PM.WORK_AREA_ID
             , HRM_COMMON_G.ID_NAME_F(PM.WORK_AREA_ID) AS  WORK_AREA_NAME
             , PM.REPRE_NUM
             , PM.SEX_TYPE
             , HRM_COMMON_G.CODE_NAME_F('SEX_TYPE', PM.SEX_TYPE, PM.SOB_ID, PM.ORG_ID) AS  SEX_NAME
             , PM.BIRTHDAY
             , NVL(PM.BIRTHDAY_TYPE, 'N')  AS BIRTHDAY_TYPE
             , HRM_COMMON_G.CODE_NAME_F('BIRTHDAY_TYPE', PM.BIRTHDAY_TYPE, PM.SOB_ID, PM.ORG_ID) AS  BIRTHDAY_TYPE_NAME
             , PM.MARRY_YN
             , PM.MARRY_DATE
             , PM.JOIN_ID
             , HRM_COMMON_G.ID_NAME_F(PM.JOIN_ID) AS  JOIN_NAME
             , PM.JOIN_ROUTE_ID
             , HRM_COMMON_G.ID_NAME_F(PM.JOIN_ROUTE_ID) AS  JOIN_ROUTE_NAME
             , PM.ORI_JOIN_DATE
             , PM.JOIN_DATE
             , PM.PAY_DATE
             , PM.DEPT_DATE
             , PM.OFFICIALLY_DATE
             , PM.SHO_DATE
             , PM.EXPIRE_DATE
             , PM.PROMOTION_EXPECT_DATE
             , PM.RETIRE_DATE
             , PM.RETIRE_ID
             , HRM_COMMON_G.ID_NAME_F(PM.RETIRE_ID) AS  RETIRE_NAME
             , PM.DIR_INDIR_TYPE
             , HRM_COMMON_G.CODE_NAME_F('DIR_INDIR_TYPE', PM.DIR_INDIR_TYPE, PM.SOB_ID, PM.ORG_ID) AS  DIR_INDIR_TYPE_NAME
             , PM.LEGAL_ZIP_CODE
             , PM.LEGAL_ADDR1
             , PM.LEGAL_ADDR2
             , PM.PRSN_ZIP_CODE
             , PM.PRSN_ADDR1
             , PM.PRSN_ADDR2
             , PM.LIVE_ZIP_CODE
             , PM.LIVE_ADDR1
             , PM.LIVE_ADDR2
             , PM.TELEPHON_NO
             , PM.HP_PHONE_NO
             , PM.EMAIL
             , PM.RELIGION_ID
             , HRM_COMMON_G.ID_NAME_F(PM.RELIGION_ID) AS  RELIGION_NAME
             , PM.END_SCH_ID
             , HRM_COMMON_G.ID_NAME_F(PM.END_SCH_ID) AS  END_SCH_NAME
             , PM.HOBBY
             , PM.TALENT
             , PM.IC_CARD_NO
             , PM.OLD_PERSON_NUM
             , PM.DESCRIPTION
             , EAPP_USER_G.USER_NAME_F(PM.LAST_UPDATED_BY) AS LAST_UPDATER
          FROM HRM_PERSON_MASTER  PM
             , HRM_CORP_MASTER    CM
             , HRM_OPERATING_UNIT OU
             , HRM_DEPT_MASTER    DM
             , (-- 시점 인사내역.
                SELECT HL.PERSON_ID
                     , HL.POST_ID
                     , HL.PAY_GRADE_ID
                     , HL.JOB_CATEGORY_ID
                     , HL.JOB_CLASS_ID
                     , HL.OCPT_ID
                     , HL.ABIL_ID
                  FROM HRM_HISTORY_LINE HL
                 WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                  FROM HRM_HISTORY_LINE S_HL
                                                 WHERE S_HL.CHARGE_DATE    <= W_STD_DATE
                                                   AND S_HL.PERSON_ID       = HL.PERSON_ID
                                              GROUP BY S_HL.PERSON_ID
                                              )
               ) T1
             , (-- 시점 인사내역.
                SELECT PH.PERSON_ID
                     , PH.FLOOR_ID
                     , PH.WORK_TYPE_ID
                     , PH.DEPT_ID
                  FROM HRD_PERSON_HISTORY        PH
                 WHERE PH.EFFECTIVE_DATE_FR  <=  W_STD_DATE
                   AND PH.EFFECTIVE_DATE_TO  >=  W_STD_DATE
               ) T2
         WHERE PM.CORP_ID                                    = CM.CORP_ID
           AND PM.OPERATING_UNIT_ID                          = OU.OPERATING_UNIT_ID(+)
           AND PM.DEPT_ID                                    = DM.DEPT_ID
           AND PM.PERSON_ID                                  = T1.PERSON_ID
           AND PM.PERSON_ID                                  = T2.PERSON_ID
           AND PM.CORP_ID                                    = NVL(W_CORP_ID, PM.CORP_ID)
           AND PM.DEPT_ID                                    = NVL(W_DEPT_ID, PM.DEPT_ID)
           AND PM.FLOOR_ID                                   = NVL(W_FLOOR_ID, PM.FLOOR_ID)
           AND PM.NAME                                         LIKE W_NAME || '%'
           AND PM.ORI_JOIN_DATE                              <= W_STD_DATE
           AND(PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE      >= W_STD_DATE)
           AND PM.SOB_ID                                     = W_SOB_ID
           AND PM.ORG_ID                                     = W_ORG_ID
      ORDER BY PM.PERSON_NUM
             , PM.NAME
             ;

  END SELECT_DETAIL_PERSON;



  -- PERSON SIMPLE SELECT[2011-09-22]
  PROCEDURE SELECT_SIMPLE_PERSON( P_CURSOR        OUT TYPES.TCURSOR
                                , W_SOB_ID        IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                , W_ORG_ID        IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                , W_CORP_ID       IN  HRM_PERSON_MASTER.CORP_ID%TYPE
                                , W_DEPT_ID       IN  HRM_PERSON_MASTER.DEPT_ID%TYPE
                                , W_FLOOR_ID      IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
                                , W_WORK_TYPE_ID  IN  HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
                                , W_EMPLOYE_TYPE  IN  HRM_PERSON_MASTER.EMPLOYE_TYPE%TYPE
                                , W_PERSON_ID     IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                , W_PERSON_NAME   IN  HRM_PERSON_MASTER.NAME%TYPE
                                )

  AS

  BEGIN
        OPEN P_CURSOR FOR
        SELECT HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_NUM                              AS PERSON_NUMBER
             , PM.NAME                                    AS PERSON_NAME
             , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
             , HRM_COMMON_G.ID_NAME_F(WT.WORK_TYPE_ID)    AS WORK_TYPE
             , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)  AS CORP_NAME
             , HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID)  AS DEPT_NAME
             , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
             , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
             , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
             , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
             , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID)    AS PAY_GRADE_NAME
             , HRM_COMMON_G.ID_NAME_F(PM.RETIRE_ID)       AS RETIRE_NAME
             , WT.WORK_TYPE_GROUP
             , WT.WORK_TYPE_ID
             , T1.JOB_CATEGORY_ID
             , PM.FLOOR_ID
             , PM.CORP_ID
             , PM.SOB_ID
             , PM.ORG_ID
             , PM.PERSON_ID
          FROM HRM_PERSON_MASTER PM
             , (-- 시점 인사내역.
                SELECT HL.PERSON_ID
                     , HL.POST_ID
                     , HL.PAY_GRADE_ID
                     , HL.JOB_CATEGORY_ID
                     , HL.JOB_CLASS_ID
                     , HL.OCPT_ID
                  FROM HRM_HISTORY_LINE HL
                 WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                  FROM HRM_HISTORY_LINE S_HL
                                                 WHERE S_HL.CHARGE_DATE    <= SYSDATE
                                                   AND S_HL.PERSON_ID       = HL.PERSON_ID
                                              GROUP BY S_HL.PERSON_ID
                                              )
               ) T1
             , (-- 시점 인사내역.
                SELECT PH.PERSON_ID
                     , PH.FLOOR_ID
                     , PH.WORK_TYPE_ID
                     , PH.DEPT_ID
                  FROM HRD_PERSON_HISTORY        PH
                 WHERE PH.EFFECTIVE_DATE_FR  <=  SYSDATE
                   AND PH.EFFECTIVE_DATE_TO  >=  SYSDATE
               ) T2
             , HRM_WORK_TYPE_V WT
         WHERE PM.PERSON_ID                   = T1.PERSON_ID
           AND PM.PERSON_ID                   = T2.PERSON_ID
           AND T2.WORK_TYPE_ID                = WT.WORK_TYPE_ID
           AND PM.SOB_ID                      = W_SOB_ID
           AND PM.ORG_ID                      = W_ORG_ID
           AND PM.CORP_ID                     = NVL(W_CORP_ID, PM.CORP_ID)
           AND PM.DEPT_ID                     = NVL(W_DEPT_ID, PM.DEPT_ID)
           AND PM.FLOOR_ID                    = NVL(W_FLOOR_ID, PM.FLOOR_ID)
           AND PM.WORK_TYPE_ID                = NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
           AND PM.PERSON_ID                   = NVL(W_PERSON_ID, PM.PERSON_ID)
           AND PM.EMPLOYE_TYPE                = NVL(W_EMPLOYE_TYPE, PM.EMPLOYE_TYPE)
           AND PM.NAME                          LIKE W_PERSON_NAME || '%'
      ORDER BY PM.CORP_TYPE, PM.NAME
             ;

  END SELECT_SIMPLE_PERSON;

-- 연말정산 기초관리.
  PROCEDURE SELECT_PERSON_YEAR_ADJUST
	          ( P_CURSOR2                           OUT TYPES.TCURSOR2
						, W_CORP_ID                           IN NUMBER
						, W_PERSON_ID                         IN NUMBER
						, W_DEPT_ID                           IN NUMBER
						, W_STD_DATE                          IN DATE
						, P_SOB_ID                            IN NUMBER
						, P_ORG_ID                            IN NUMBER
						)
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT PM.NAME AS NAME
          , PM.PERSON_NUM
          , PM.CORP_ID
          , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID) AS CORP_NAME
          , T1.DEPT_NAME AS DEPT_NAME
          , T1.POST_NAME AS POST_NAME
          , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
          , CASE 
              WHEN TO_DATE(TO_CHAR(W_STD_DATE, 'YYYY') || '-01-01', 'YYYY-MM-DD') <= PM.JOIN_DATE THEN PM.JOIN_DATE
              ELSE TO_DATE(TO_CHAR(W_STD_DATE, 'YYYY') || '-01-01', 'YYYY-MM-DD')
            END AS ADJUST_DATE_FR
          , CASE 
              WHEN PM.RETIRE_DATE IS NULL THEN TO_DATE(TO_CHAR(W_STD_DATE, 'YYYY') || '-12-31', 'YYYY-MM-DD')
              WHEN PM.RETIRE_DATE <= TO_DATE(TO_CHAR(W_STD_DATE, 'YYYY') || '-12-31', 'YYYY-MM-DD') THEN PM.RETIRE_DATE
              ELSE TO_DATE(TO_CHAR(W_STD_DATE, 'YYYY') || '-12-31', 'YYYY-MM-DD')
            END AS ADJUST_DATE_TO
          , PM.REPRE_NUM
          , PM.RESIDENT_TYPE       -- 거주구분.
          , HRM_COMMON_G.CODE_NAME_F('RESIDENT_TYPE', PM.RESIDENT_TYPE, PM.SOB_ID, PM.ORG_ID) AS RESIDENT_NAME
          , PM.NATION_ID
          , HRM_COMMON_G.ID_NAME_F(PM.NATION_ID) AS NATION_NAME
          , PM.NATIONALITY_TYPE    -- 내외국인구분.
          , HRM_COMMON_G.CODE_NAME_F('NATIONALITY_TYPE', PM.NATIONALITY_TYPE, PM.SOB_ID, PM.ORG_ID) AS NATIONALITY_NAME
          , PM.FOREIGN_TAX_YN      -- 외국인단일세율구분.
          , PM.HOUSEHOLD_TYPE      -- 세대주구분.
          , HRM_COMMON_G.CODE_NAME_F('HOUSEHOLD_TYPE', PM.HOUSEHOLD_TYPE, PM.SOB_ID, PM.ORG_ID) AS HOUSEHOLD_NAME
          , PM.LIVE_ZIP_CODE
          , PM.LIVE_ADDR1
          , PM.LIVE_ADDR2
          , PM.PERSON_ID
          , TO_CHAR(W_STD_DATE, 'YYYY') AS ADJUST_YYYY
      FROM HRM_PERSON_MASTER PM
        , (-- 시점 인사내역.
            SELECT HL.PERSON_ID
                , HL.DEPT_ID
                , DM.DEPT_CODE
                , DM.DEPT_NAME
                , HL.POST_ID
                , PC.POST_NAME
                , PC.SORT_NUM AS POST_SORT_NUM
                , HL.PAY_GRADE_ID
                , HL.JOB_CATEGORY_ID
                , HL.FLOOR_ID    
            FROM HRM_HISTORY_LINE HL  
              , HRM_DEPT_MASTER DM
              , HRM_POST_CODE_V PC
            WHERE HL.DEPT_ID          = DM.DEPT_ID
              AND HL.POST_ID          = PC.POST_ID
              AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                            FROM HRM_HISTORY_LINE S_HL
                                           WHERE S_HL.CHARGE_DATE            <= W_STD_DATE
                                             AND S_HL.PERSON_ID              = HL.PERSON_ID
                                           GROUP BY S_HL.PERSON_ID
                                         )
          ) T1
      WHERE PM.PERSON_ID              = T1.PERSON_ID
        AND PM.CORP_ID                = NVL(W_CORP_ID, PM.CORP_ID)
        AND PM.PERSON_ID              = NVL(W_PERSON_ID, PM.PERSON_ID)
        AND T1.DEPT_ID                = NVL(W_DEPT_ID, T1.DEPT_ID)
        AND PM.ORI_JOIN_DATE          <= W_STD_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= TRUNC(W_STD_DATE, 'MONTH'))
        AND PM.SOB_ID                 = P_SOB_ID
        AND PM.ORG_ID                 = P_ORG_ID
      ORDER BY T1.DEPT_CODE, T1.POST_SORT_NUM
      ;
  END SELECT_PERSON_YEAR_ADJUST;
  
-- 연말정산 기초정보의 인적사항 변경.
  PROCEDURE DATA_UPDATE_YEAR_ADJUST
	          ( W_PERSON_ID          IN NUMBER
            , P_SOB_ID             IN NUMBER
            , P_ORG_ID             IN NUMBER
						, P_REPRE_NUM          IN VARCHAR2
            , P_RESIDENT_TYPE      IN VARCHAR2
            , P_NATION_ID          IN NUMBER
            , P_NATIONALITY_TYPE   IN VARCHAR2
            , P_FOREIGN_TAX_YN     IN VARCHAR2
            , P_HOUSEHOLD_TYPE     IN VARCHAR2
            , P_LIVE_ZIP_CODE      IN VARCHAR2
            , P_LIVE_ADDR1         IN VARCHAR2
            , P_LIVE_ADDR2         IN VARCHAR2
						, P_USER_ID            IN NUMBER
						)
  AS
    V_REPRE_NUM                    VARCHAR2(20);  -- 주민번호.
  BEGIN
    -- 주민번호 형식 적용.
    IF P_REPRE_NUM IS NULL THEN
      V_REPRE_NUM := NULL;
    ELSE
      V_REPRE_NUM := SUBSTR(RPAD(REPLACE(P_REPRE_NUM, '-', ''), 13, '*'), 1, 6) || '-' || SUBSTR(RPAD(REPLACE(P_REPRE_NUM, '-', ''), 13, '*'), 7, 13);
    END IF;
    
    UPDATE HRM_PERSON_MASTER PM
      SET   PM.REPRE_NUM          = V_REPRE_NUM
          , PM.RESIDENT_TYPE      = P_RESIDENT_TYPE
          , PM.NATION_ID          = P_NATION_ID
          , PM.NATIONALITY_TYPE   = P_NATIONALITY_TYPE
          , PM.FOREIGN_TAX_YN     = NVL(P_FOREIGN_TAX_YN, 'N')
          , PM.HOUSEHOLD_TYPE     = P_HOUSEHOLD_TYPE
          , PM.LIVE_ZIP_CODE      = P_LIVE_ZIP_CODE
          , PM.LIVE_ADDR1         = P_LIVE_ADDR1
          , PM.LIVE_ADDR2         = P_LIVE_ADDR2
          , PM.LAST_UPDATE_DATE   = GET_LOCAL_DATE(PM.SOB_ID)
          , PM.LAST_UPDATED_BY    = P_USER_ID
    WHERE PM.PERSON_ID            = W_PERSON_ID
    ; 
  END DATA_UPDATE_YEAR_ADJUST;
  

-- 사원 ID를 가지고 이름 조회..
  FUNCTION NAME_F
          ( W_PERSON_ID                          IN NUMBER
      ) RETURN VARCHAR2
  AS
   V_NAME                                        VARCHAR2(100);

  BEGIN
    BEGIN
      SELECT PM.NAME
        INTO V_NAME
        FROM HRM_PERSON_MASTER PM
      WHERE PM.PERSON_ID                                      = W_PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_NAME := NULL;
    END;

    RETURN V_NAME;

 END NAME_F;

-- 사원 이메일 주소 검색.
  FUNCTION EMAIL_F
            ( P_PERSON_ID         IN VARCHAR2
            ) RETURN VARCHAR2
  AS
    V_EMAIL                       VARCHAR2(200);
  BEGIN
    BEGIN
      SELECT PM.EMAIL
        INTO V_EMAIL
        FROM HRM_PERSON_MASTER PM
      WHERE PM.PERSON_ID          = P_PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_EMAIL := NULL;
    END;
    RETURN V_EMAIL;
  END EMAIL_F;

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_PERSON_ID                         IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_STD_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT PM.NAME
       , PM.PERSON_NUM
       , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
       , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
       , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME
       , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
       , PM.ORI_JOIN_DATE
       , PM.JOIN_DATE
       , PM.RETIRE_DATE
       , PM.PERSON_ID
      FROM HRM_PERSON_MASTER PM
       , (-- 시점 인사내역.
        SELECT HL.PERSON_ID
          , HL.DEPT_ID
          , HL.POST_ID
          , HL.PAY_GRADE_ID
          , HL.JOB_CATEGORY_ID
          , HL.FLOOR_ID
        FROM HRM_HISTORY_LINE HL
        WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                        FROM HRM_HISTORY_LINE S_HL
                        WHERE S_HL.CHARGE_DATE            <= W_STD_DATE
                          AND S_HL.PERSON_ID              = HL.PERSON_ID
                        GROUP BY S_HL.PERSON_ID
                       )
       ) T1
      WHERE PM.PERSON_ID                               = T1.PERSON_ID
      AND PM.CORP_ID                                 = NVL(W_CORP_ID, PM.CORP_ID)
      AND PM.PERSON_ID                               = NVL(W_PERSON_ID, PM.PERSON_ID)
      AND T1.DEPT_ID                                 = NVL(W_DEPT_ID, T1.DEPT_ID)
      AND PM.ORI_JOIN_DATE                           <= W_STD_DATE
      AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= TRUNC(W_STD_DATE, 'MONTH'))
      AND PM.SOB_ID                                  = W_SOB_ID
      AND PM.ORG_ID                                  = W_ORG_ID
 ORDER BY PM.NAME
      ;

  END LU_PERSON_SELECT;

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT1
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_PERSON_ID                         IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_STD_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            , W_CORP_TYPE                         IN VARCHAR2 DEFAULT NULL
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT PM.NAME
         , PM.PERSON_NUM
         , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
         , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
         , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME
         , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
         , PM.ORI_JOIN_DATE
         , PM.JOIN_DATE
         , PM.RETIRE_DATE
         , PM.PERSON_ID
      FROM HRM_PERSON_MASTER PM
       , (-- 시점 인사내역.
        SELECT HL.PERSON_ID
          , HL.DEPT_ID
          , HL.POST_ID
          , HL.PAY_GRADE_ID
          , HL.JOB_CATEGORY_ID
          , HL.FLOOR_ID
        FROM HRM_HISTORY_LINE HL
        WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                        FROM HRM_HISTORY_LINE S_HL
                        WHERE S_HL.CHARGE_DATE            <= W_STD_DATE
                          AND S_HL.PERSON_ID              = HL.PERSON_ID
                        GROUP BY S_HL.PERSON_ID
                       )
       ) T1
      WHERE PM.PERSON_ID                               = T1.PERSON_ID
        --AND PM.CORP_ID                                 = NVL(W_CORP_ID, PM.CORP_ID)
        AND PM.PERSON_ID                               = NVL(W_PERSON_ID, PM.PERSON_ID)
        AND T1.DEPT_ID                                 = NVL(W_DEPT_ID, T1.DEPT_ID)
        AND PM.ORI_JOIN_DATE                           <= W_STD_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_STD_DATE)
        AND PM.SOB_ID                                  = W_SOB_ID
        AND PM.ORG_ID                                  = W_ORG_ID
        AND PM.CORP_TYPE                               = NVL(W_CORP_TYPE, PM.CORP_TYPE)
 ORDER BY PM.NAME
      ;

  END LU_PERSON_SELECT1;

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT2
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_NAME                              IN VARCHAR2
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT PM.NAME
         , PM.PERSON_NUM
         , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
         , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
         , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME
         , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
         , PM.ORI_JOIN_DATE
         , PM.JOIN_DATE
         , PM.RETIRE_DATE
         , PM.PERSON_ID
      FROM HRM_PERSON_MASTER PM
        , (-- 시점 인사내역.
          SELECT HL.PERSON_ID
            , HL.DEPT_ID
            , HL.POST_ID
            , HL.PAY_GRADE_ID
            , HL.JOB_CATEGORY_ID
            , HL.FLOOR_ID
          FROM HRM_HISTORY_LINE HL
          WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                          FROM HRM_HISTORY_LINE S_HL
                          WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                            AND S_HL.PERSON_ID              = HL.PERSON_ID
                          GROUP BY S_HL.PERSON_ID
                         )
         ) T1
      WHERE PM.PERSON_ID                               = T1.PERSON_ID
        AND PM.CORP_ID                                 = NVL(W_CORP_ID, PM.CORP_ID)
        AND PM.NAME                                    = NVL(W_NAME, PM.NAME)
        AND T1.DEPT_ID                                 = NVL(W_DEPT_ID, T1.DEPT_ID)
        AND PM.ORI_JOIN_DATE                           <= W_END_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_START_DATE)
        AND PM.SOB_ID                                  = W_SOB_ID
        AND PM.ORG_ID                                  = W_ORG_ID
 ORDER BY PM.NAME
        ;

  END LU_PERSON_SELECT2;


-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT3
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_NAME                              IN VARCHAR2
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            , W_CORP_TYPE                         IN VARCHAR2 DEFAULT NULL
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT PM.NAME AS NAME
         , PM.PERSON_NUM
         , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID) AS CORP_NAME
         , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
         , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
         , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME
         , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
         , PM.ORI_JOIN_DATE
         , PM.JOIN_DATE
         , PM.RETIRE_DATE
         , PM.PERSON_ID
         , PM.CORP_ID
         , PM.DEPT_ID
         , PM.POST_ID
         , PM.PAY_GRADE_ID
      FROM HRM_PERSON_MASTER PM
        , (-- 시점 인사내역.
          SELECT HL.PERSON_ID
            , HL.DEPT_ID
            , HL.POST_ID
            , HL.PAY_GRADE_ID
            , HL.JOB_CATEGORY_ID
            , HL.FLOOR_ID
          FROM HRM_HISTORY_LINE HL
          WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                          FROM HRM_HISTORY_LINE S_HL
                          WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                            AND S_HL.PERSON_ID              = HL.PERSON_ID
                          GROUP BY S_HL.PERSON_ID
                         )
         ) T1
      WHERE PM.PERSON_ID                               = T1.PERSON_ID
        AND PM.CORP_ID                                 = NVL(W_CORP_ID, PM.CORP_ID)
        AND PM.NAME                                    = NVL(W_NAME, PM.NAME)
        AND T1.DEPT_ID                                 = NVL(W_DEPT_ID, T1.DEPT_ID)
        AND PM.ORI_JOIN_DATE                           <= W_END_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_START_DATE)
        AND PM.SOB_ID                                  = W_SOB_ID
        AND PM.ORG_ID                                  = W_ORG_ID
        AND PM.CORP_TYPE                               = NVL(W_CORP_TYPE, PM.CORP_TYPE)
 ORDER BY PM.NAME
      ;

  END LU_PERSON_SELECT3;

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT4
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_CORP_ID                           IN NUMBER
						, W_NAME                              IN VARCHAR2
						, W_DEPT_ID                           IN NUMBER
						, W_YYYYMM                            IN VARCHAR2
						, W_SOB_ID                            IN NUMBER
						, W_ORG_ID                            IN NUMBER
            , W_CORP_TYPE                         IN VARCHAR2 DEFAULT NULL
						)
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT PM.NAME AS NAME
          , PM.PERSON_NUM
          , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID) AS CORP_NAME
          , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME  
          , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
          , PM.ORI_JOIN_DATE
          , PM.JOIN_DATE
          , PM.RETIRE_DATE
          , PM.PERSON_ID
          , PM.CORP_ID
          , PM.DEPT_ID
          , PM.POST_ID
          , PM.PAY_GRADE_ID
      FROM HRM_PERSON_MASTER PM
        , (-- 시점 인사내역.
            SELECT HL.PERSON_ID
                , HL.DEPT_ID
                , HL.POST_ID
                , HL.PAY_GRADE_ID
                , HL.JOB_CATEGORY_ID
                , HL.FLOOR_ID    
            FROM HRM_HISTORY_LINE HL  
            WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                            FROM HRM_HISTORY_LINE S_HL
                                           WHERE S_HL.CHARGE_DATE            <= LAST_DAY(TO_DATE(W_YYYYMM, 'YYYY-MM'))
                                             AND S_HL.PERSON_ID              = HL.PERSON_ID
                                           GROUP BY S_HL.PERSON_ID
                                         )
          ) T1
      WHERE PM.PERSON_ID                               = T1.PERSON_ID
        AND PM.CORP_ID                                 = NVL(W_CORP_ID, PM.CORP_ID)
        AND PM.NAME                                    = NVL(W_NAME, PM.NAME)
        AND T1.DEPT_ID                                 = NVL(W_DEPT_ID, T1.DEPT_ID)
        AND PM.ORI_JOIN_DATE                           <= LAST_DAY(TO_DATE(W_YYYYMM, 'YYYY-MM'))
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= TRUNC(TO_DATE(W_YYYYMM, 'YYYY-MM'), 'MONTH'))
        AND PM.CORP_TYPE                               = NVL(W_CORP_TYPE, PM.CORP_TYPE)
        AND PM.SOB_ID                                  = W_SOB_ID
        AND PM.ORG_ID                                  = W_ORG_ID
      ORDER BY PM.PERSON_NUM
      ;
  END LU_PERSON_SELECT4;
  
-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_DUTY
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_WORK_TYPE_ID                      IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            )
  AS
 BEGIN

   OPEN P_CURSOR3 FOR
   SELECT PM.NAME
     , PM.PERSON_NUM
     , HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID) AS DEPT_NAME
     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
     , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME
     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) EMPLOYE_TYPE_NAME
     , PM.ORI_JOIN_DATE
     , PM.JOIN_DATE
     , PM.RETIRE_DATE
     , PM.PERSON_ID
     , T1.JOB_CATEGORY_ID
     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
     , PM.FLOOR_ID
     , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
     , PM.CORP_ID
     , PM.SOB_ID
     , PM.ORG_ID
     , WT.WORK_TYPE_ID
     , WT.WORK_TYPE
     , WT.WORK_TYPE_NAME
     , WT.WORK_TYPE_GROUP
   FROM HRM_PERSON_MASTER PM
     , (-- 시점 인사내역.
      SELECT HL.PERSON_ID
                          , HL.POST_ID
                          , HL.JOB_CATEGORY_ID
                          , HL.JOB_CLASS_ID
                          , HL.OCPT_ID
                          , HL.PAY_GRADE_ID
      FROM HRM_HISTORY_LINE HL
      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                      FROM HRM_HISTORY_LINE S_HL
                      WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                        AND S_HL.PERSON_ID              = HL.PERSON_ID
                      GROUP BY S_HL.PERSON_ID
                     )
     ) T1
               , (-- 시점 인사내역.
                  SELECT PH.PERSON_ID
                       , PH.FLOOR_ID
                       , PH.DEPT_ID
                    FROM HRD_PERSON_HISTORY        PH
                   WHERE PH.EFFECTIVE_DATE_FR  <=  W_END_DATE
                     AND PH.EFFECTIVE_DATE_TO  >=  W_END_DATE
                 ) T2
    , HRM_WORK_TYPE_V WT
   WHERE PM.PERSON_ID                               = T1.PERSON_ID
    AND PM.PERSON_ID                               = T2.PERSON_ID
     AND PM.WORK_TYPE_ID                            = WT.WORK_TYPE_ID
    AND PM.WORK_CORP_ID                            = W_CORP_ID
    AND PM.WORK_TYPE_ID                            = NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
    AND T2.DEPT_ID                                 = NVL(W_DEPT_ID, T2.DEPT_ID)
    AND PM.ORI_JOIN_DATE                           <= W_END_DATE
    AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_START_DATE)
    AND PM.SOB_ID                                  = W_SOB_ID
    AND PM.ORG_ID                                  = W_ORG_ID
ORDER BY PM.NAME
   ;

 END LU_PERSON_DUTY;

-- LOOKUP PERSON INFOMATION - CAPACITY.
  PROCEDURE LU_PERSON_DUTY_C
           ( P_CURSOR3                           OUT TYPES.TCURSOR3
      , W_CORP_ID                           IN NUMBER
      , W_WORK_TYPE_ID                      IN NUMBER
      , W_DEPT_ID                           IN NUMBER
      , W_START_DATE                        IN DATE
      , W_END_DATE                          IN DATE
      , W_CONNECT_PERSON_ID                 IN NUMBER
      , W_SOB_ID                            IN NUMBER
      , W_ORG_ID                            IN NUMBER
      )
  AS
   V_CONNECT_PERSON_ID                                   HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

 BEGIN
   IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID
                             , W_START_DATE => W_START_DATE
                , W_END_DATE => W_END_DATE
                , W_MODULE_CODE => '20'
                , W_PERSON_ID => W_CONNECT_PERSON_ID
                , W_SOB_ID => W_SOB_ID
                , W_ORG_ID => W_ORG_ID) = 'C' THEN
    V_CONNECT_PERSON_ID := NULL;
  ELSE
    V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
  END IF;
--RAISE_APPLICATION_ERROR(-20001, 'START : ' || TO_CHAR(W_START_DATE, 'YYYY-MM-DD') || ', END : ' || TO_CHAR(W_END_DATE, 'YYYY-MM-DD'));
   OPEN P_CURSOR3 FOR
   SELECT PM.NAME
     , PM.PERSON_NUM
     , HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID) AS DEPT_NAME
     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
     , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME
     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) EMPLOYE_TYPE_NAME
     , PM.ORI_JOIN_DATE
     , PM.JOIN_DATE
     , PM.RETIRE_DATE
     , PM.PERSON_ID
     , T1.JOB_CATEGORY_ID
     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
     , PM.FLOOR_ID
     , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
     , PM.CORP_ID
     , PM.SOB_ID
     , PM.ORG_ID
     , WT.WORK_TYPE_ID
     , WT.WORK_TYPE
     , WT.WORK_TYPE_NAME
     , WT.WORK_TYPE_GROUP
   FROM HRM_PERSON_MASTER PM
     , (-- 시점 인사내역.
      SELECT HL.PERSON_ID
                          , HL.POST_ID
                          , HL.JOB_CATEGORY_ID
                          , HL.JOB_CLASS_ID
                          , HL.OCPT_ID
                          , HL.PAY_GRADE_ID
      FROM HRM_HISTORY_LINE HL
      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                      FROM HRM_HISTORY_LINE S_HL
                      WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                        AND S_HL.PERSON_ID              = HL.PERSON_ID
                      GROUP BY S_HL.PERSON_ID
                     )
     ) T1
               , (-- 시점 인사내역.
                  SELECT PH.PERSON_ID
                       , PH.FLOOR_ID
                       , PH.DEPT_ID
                    FROM HRD_PERSON_HISTORY        PH
                   WHERE PH.EFFECTIVE_DATE_FR  <=  W_END_DATE
                     AND PH.EFFECTIVE_DATE_TO  >=  W_END_DATE
                 ) T2
    , HRM_WORK_TYPE_V WT
   WHERE PM.PERSON_ID                               = T1.PERSON_ID
    AND PM.PERSON_ID                               = T2.PERSON_ID
     AND PM.WORK_TYPE_ID                            = WT.WORK_TYPE_ID
    AND PM.WORK_CORP_ID                            = W_CORP_ID
    AND PM.WORK_TYPE_ID                            = NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
    AND T2.DEPT_ID                                 = NVL(W_DEPT_ID, T2.DEPT_ID)
    AND PM.ORI_JOIN_DATE                           <= W_END_DATE
    AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_START_DATE)
    AND PM.SOB_ID                                  = W_SOB_ID
    AND PM.ORG_ID                                  = W_ORG_ID
    AND EXISTS (SELECT 'X'
                  FROM HRD_DUTY_MANAGER DM
            WHERE DM.CORP_ID                                 = PM.WORK_CORP_ID
             AND DM.DUTY_CONTROL_ID                         = T2.FLOOR_ID
            AND DM.WORK_TYPE_ID                            = DECODE(NVL(DM.WORK_TYPE_ID, 0), 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
            AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
            AND DM.SOB_ID                                  = PM.SOB_ID
            AND DM.ORG_ID                                  = PM.ORG_ID
          )
    ORDER BY HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)
           , PM.NAME
   ;

 END LU_PERSON_DUTY_C;

-- LOOKUP PERSON INFOMATION - CAPACITY.
  PROCEDURE LU_PERSON_DUTY_C1
           ( P_CURSOR3                           OUT TYPES.TCURSOR3
      , W_CORP_ID                           IN NUMBER
      , W_WORK_TYPE_ID                      IN NUMBER
      , W_FLOOR_ID                          IN NUMBER
      , W_START_DATE                        IN DATE
      , W_END_DATE                          IN DATE
      , W_CONNECT_PERSON_ID                 IN NUMBER
      , W_SOB_ID                            IN NUMBER
      , W_ORG_ID                            IN NUMBER
      )
  AS
   V_CONNECT_PERSON_ID                                   HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

 BEGIN
   IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID
                             , W_START_DATE => W_START_DATE
                , W_END_DATE => W_END_DATE
                , W_MODULE_CODE => '20'
                , W_PERSON_ID => W_CONNECT_PERSON_ID
                , W_SOB_ID => W_SOB_ID
                , W_ORG_ID => W_ORG_ID) = 'C' THEN
    V_CONNECT_PERSON_ID := NULL;
  ELSE
    V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
  END IF;

   OPEN P_CURSOR3 FOR
   SELECT PM.NAME
     , PM.PERSON_NUM
     , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
     --, HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME
     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID) AS PAY_GRADE_NAME
     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) EMPLOYE_TYPE_NAME
     , PM.ORI_JOIN_DATE
     , PM.JOIN_DATE
     , PM.RETIRE_DATE
     , PM.PERSON_ID
     , T1.JOB_CATEGORY_ID
     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
     , PM.FLOOR_ID
     , PM.CORP_ID
          , PM.WORK_CORP_ID
     , PM.SOB_ID
     , PM.ORG_ID
     , WT.WORK_TYPE_ID
     , WT.WORK_TYPE
     , WT.WORK_TYPE_NAME
     , WT.WORK_TYPE_GROUP
   FROM HRM_PERSON_MASTER PM
     , (-- 시점 인사내역.
      SELECT HL.PERSON_ID
        , HL.DEPT_ID
        , HL.POST_ID
        , HL.PAY_GRADE_ID
        , HL.JOB_CATEGORY_ID
        , HL.JOB_CLASS_ID
      FROM HRM_HISTORY_LINE HL
      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                      FROM HRM_HISTORY_LINE S_HL
                      WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                        AND S_HL.PERSON_ID              = HL.PERSON_ID
                      GROUP BY S_HL.PERSON_ID
                     )
     ) T1
               , (-- 시점 인사내역.
                  SELECT PH.PERSON_ID
                       , PH.FLOOR_ID
                    FROM HRD_PERSON_HISTORY        PH
                   WHERE PH.EFFECTIVE_DATE_FR  <=  W_END_DATE
                     AND PH.EFFECTIVE_DATE_TO  >=  W_END_DATE
                 ) T2
    , HRM_WORK_TYPE_V WT
   WHERE PM.PERSON_ID                               = T1.PERSON_ID
    AND PM.PERSON_ID                               = T2.PERSON_ID
     AND PM.WORK_TYPE_ID                            = WT.WORK_TYPE_ID
    AND PM.WORK_CORP_ID                            = W_CORP_ID
    AND PM.WORK_TYPE_ID                            = NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
    AND T2.FLOOR_ID                                = NVL(W_FLOOR_ID, T2.FLOOR_ID)
    AND PM.ORI_JOIN_DATE                           <= W_END_DATE
    AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_START_DATE)
    AND PM.SOB_ID                                  = W_SOB_ID
    AND PM.ORG_ID                                  = W_ORG_ID
    AND EXISTS (SELECT 'X'
                  FROM HRD_DUTY_MANAGER DM
            WHERE DM.CORP_ID                                 = PM.WORK_CORP_ID
             AND DM.DUTY_CONTROL_ID                         = T2.FLOOR_ID
            AND DM.WORK_TYPE_ID                            = DECODE(NVL(DM.WORK_TYPE_ID, 0), 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
            AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
            AND DM.SOB_ID                                  = PM.SOB_ID
            AND DM.ORG_ID                                  = PM.ORG_ID
          )
  ORDER BY HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)
         , PM.NAME
   ;

 END LU_PERSON_DUTY_C1;

-- LOOKUP PERSON 권한별 INFOMATION.
  PROCEDURE LU_PERSON_FI_C
           ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_NAME                              IN VARCHAR2
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            , W_CONNECT_PERSON_ID                 IN NUMBER
      )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
   SELECT PM.NAME
     , PM.PERSON_NUM
     , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID) AS DEPT_NAME
     , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_NAME
     , HRM_COMMON_G.ID_NAME_F(PM.PAY_GRADE_ID) AS PAY_GRADE_NAME
     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
     , PM.ORI_JOIN_DATE
     , PM.JOIN_DATE
     , PM.RETIRE_DATE
     , PM.PERSON_ID
   FROM HRM_PERSON_MASTER PM
   WHERE PM.CORP_ID                            = NVL(W_CORP_ID, PM.CORP_ID)
    AND PM.NAME                                = NVL(W_NAME, PM.NAME)
    AND PM.ORI_JOIN_DATE                       <= W_END_DATE
    AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_START_DATE)
    AND PM.SOB_ID                              = W_SOB_ID
    AND PM.ORG_ID                              = W_ORG_ID
    AND EXISTS 
              ( SELECT 'X'
                  FROM HRM_PERSON_MASTER PM1
                    , HRM_DEPT_MAPPING DM
                WHERE PM1.DEPT_ID        = DM.HR_DEPT_ID
                  AND PM1.SOB_ID         = DM.SOB_ID
                  AND PM1.DEPT_ID        = PM.DEPT_ID
                  AND PM1.SOB_ID         = PM.SOB_ID
                  AND PM1.ORG_ID         = PM.ORG_ID
                  AND DM.M_DEPT_ID       = NVL(W_DEPT_ID, DM.M_DEPT_ID)
                  AND PM1.PERSON_ID      = W_CONNECT_PERSON_ID
               )
   ;

  END LU_PERSON_FI_C;

-- LOOKUP PERSON INFOMATION - HISTORY.
   PROCEDURE LU_PERSON_SELECT10
           ( P_CURSOR3                           OUT TYPES.TCURSOR3
           , W_CORP_ID                           IN NUMBER
           , W_NAME                              IN VARCHAR2
           , W_DEPT_ID                           IN NUMBER
           , W_START_DATE                        IN DATE
           , W_END_DATE                          IN DATE
           , W_SOB_ID                            IN NUMBER
           , W_ORG_ID                            IN NUMBER
           )

   AS

   BEGIN

    OPEN P_CURSOR3 FOR
      SELECT PM.NAME
          , PM.PERSON_NUM
          , PM.PERSON_ID
          , PM.ORI_JOIN_DATE
          , PM.JOIN_DATE
          , PM.RETIRE_DATE
          , PM.RETIRE_ID
          , HRM_COMMON_G.ID_NAME_F(PM.RETIRE_ID) AS RETIRE_NAME
          -- 발령후.
          , PM.OPERATING_UNIT_ID
          , OU.OPERATING_UNIT_NAME
          , PM.DEPT_ID
          , DM.DEPT_CODE
          , DM.DEPT_NAME
          , PM.JOB_CLASS_ID
          , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID) AS JOB_CLASS_NAME
          , PM.JOB_ID
          , HRM_COMMON_G.ID_NAME_F(PM.JOB_ID) AS JOB_NAME
          , PM.POST_ID
          , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_NAME
          , PM.OCPT_ID
          , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID) AS OCPT_NAME
          , PM.ABIL_ID
          , HRM_COMMON_G.ID_NAME_F(PM.ABIL_ID) AS ABIL_NAME
          , PM.PAY_GRADE_ID
          , HRM_COMMON_G.ID_NAME_F(PM.PAY_GRADE_ID) AS PAY_GRADE_NAME
          , PM.JOB_CATEGORY_ID
          , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
          , PM.FLOOR_ID
          , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_NAME
          -- 발령전.
          , PM.OPERATING_UNIT_ID AS P_OPERATING_UNIT_ID
          , OU.OPERATING_UNIT_NAME AS P_OPERATING_UNIT_NAME
          , PM.DEPT_ID AS P_DEPT_ID
          , DM.DEPT_CODE AS P_DEPT_CODE
          , DM.DEPT_NAME AS P_DEPT_NAME
          , PM.JOB_CLASS_ID AS P_JOB_CLASS_ID
          , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID) AS P_JOB_CLASS_NAME
          , PM.JOB_ID AS P_JOB_ID
          , HRM_COMMON_G.ID_NAME_F(PM.JOB_ID) AS P_JOB_NAME
          , PM.POST_ID AS P_POST_ID
          , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS P_POST_NAME
          , PM.OCPT_ID AS P_OCPT_ID
          , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID) AS P_OCPT_NAME
          , PM.ABIL_ID AS P_ABIL_ID
          , HRM_COMMON_G.ID_NAME_F(PM.ABIL_ID) AS P_ABIL_NAME
          , PM.PAY_GRADE_ID AS P_PAY_GRADE_ID
          , HRM_COMMON_G.ID_NAME_F(PM.PAY_GRADE_ID) AS P_PAY_GRADE_NAME
          , PM.JOB_CATEGORY_ID AS P_JOB_CATEGORY_ID
          , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS P_JOB_CATEGORY_NAME
          , PM.FLOOR_ID AS P_FLOOR_ID
          , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS P_FLOOR_NAME
       FROM HRM_PERSON_MASTER PM
          , HRM_OPERATING_UNIT OU
          , HRM_DEPT_MASTER DM
      WHERE PM.OPERATING_UNIT_ID                          = OU.OPERATING_UNIT_ID
        AND PM.DEPT_ID                                    = DM.DEPT_ID
        AND PM.CORP_ID                                    = NVL(W_CORP_ID, PM.CORP_ID)
        AND PM.DEPT_ID                                    = NVL(W_DEPT_ID, PM.DEPT_ID)
        AND PM.NAME                                       LIKE W_NAME || '%'
        AND PM.ORI_JOIN_DATE                              <= W_END_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE     >= W_START_DATE)
        AND PM.SOB_ID                                     = W_SOB_ID
        AND PM.ORG_ID                                     = W_ORG_ID
   ORDER BY PM.NAME
      ;

  END LU_PERSON_SELECT10;


       -- LOOKUP PERSON INFOMATION[2011-08-18]
       PROCEDURE LU_PERSON_SELECT11
               ( P_CURSOR3        OUT TYPES.TCURSOR3
               , W_SOB_ID         IN  HRM_PERSON_MASTER.SOB_ID%TYPE
               , W_ORG_ID         IN  HRM_PERSON_MASTER.ORG_ID%TYPE
               , W_CORP_ID        IN  HRM_PERSON_MASTER.CORP_ID%TYPE
               , W_DEPT_ID        IN  HRM_PERSON_MASTER.DEPT_ID%TYPE
               )

       AS

       BEGIN

                 OPEN P_CURSOR3 FOR
                 SELECT HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) AS EMPLOYE_TYPE_NAME
                      , PM.PERSON_NUM AS PERSON_NUMBER
                      , PM.NAME       AS PERSON_NAME
                      , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                      , HRM_COMMON_G.ID_NAME_F(WT.WORK_TYPE_ID)    AS WORK_TYPE
                      , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)  AS CORP_NAME
                      , HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID)  AS DEPT_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                      , PM.JOIN_DATE
                      , PM.RETIRE_DATE
                      , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                      , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID)         AS OCPT_NAME
                      , WT.WORK_TYPE_ID
                      , T1.JOB_CATEGORY_ID
                      , PM.FLOOR_ID
                      , PM.CORP_ID
                      , PM.SOB_ID
                      , PM.ORG_ID
                      , PM.PERSON_ID
                   FROM HRM_PERSON_MASTER PM
                      , (-- 시점 인사내역.
                         SELECT HL.PERSON_ID
                              , HL.POST_ID
                              , HL.PAY_GRADE_ID
                              , HL.JOB_CATEGORY_ID
                              , HL.JOB_CLASS_ID
                           FROM HRM_HISTORY_LINE HL
                          WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                           FROM HRM_HISTORY_LINE S_HL
                                                          WHERE S_HL.CHARGE_DATE    <= TRUNC(SYSDATE)
                                                            AND S_HL.PERSON_ID       = HL.PERSON_ID
                                                       GROUP BY S_HL.PERSON_ID
                                                       )
                        ) T1
                      , (-- 시점 인사내역.
                         SELECT PH.PERSON_ID
                              , PH.FLOOR_ID
                              , PH.DEPT_ID
                              , PH.WORK_TYPE_ID
                           FROM HRD_PERSON_HISTORY        PH
                          WHERE PH.EFFECTIVE_DATE_FR  <=  TRUNC(SYSDATE)
                            AND PH.EFFECTIVE_DATE_TO  >=  TRUNC(SYSDATE)
                        ) T2
                      , HRM_WORK_TYPE_V WT
                  WHERE PM.PERSON_ID                                = T1.PERSON_ID
                    AND PM.PERSON_ID                                = T2.PERSON_ID
                    AND PM.WORK_TYPE_ID                             = WT.WORK_TYPE_ID
                    AND PM.SOB_ID                                   = W_SOB_ID
                    AND PM.ORG_ID                                   = W_ORG_ID
                    AND PM.CORP_ID                                  = NVL(W_CORP_ID, PM.CORP_ID)
                    AND T2.DEPT_ID                                  = NVL(W_DEPT_ID, T2.DEPT_ID)
               ORDER BY PM.NAME
                      ;

      END LU_PERSON_SELECT11;


      -- LOOKUP PERSON INFOMATION[2011-09-05]
       PROCEDURE LU_PERSON_SELECT12
               ( P_CURSOR1        OUT TYPES.TCURSOR1
               , W_SOB_ID         IN  HRM_PERSON_MASTER.SOB_ID%TYPE
               , W_ORG_ID         IN  HRM_PERSON_MASTER.ORG_ID%TYPE
               , W_START_DATE     IN  HRM_PERSON_MASTER.JOIN_DATE%TYPE
               , W_END_DATE       IN  HRM_PERSON_MASTER.JOIN_DATE%TYPE
               , W_CORP_ID        IN  HRM_PERSON_MASTER.CORP_ID%TYPE
               , W_FLOOR_ID       IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
               , W_WORK_TYPE_ID   IN  HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
               )

       AS

       BEGIN

                 OPEN P_CURSOR1 FOR
                 SELECT PM.PERSON_NUM AS PERSON_NUMBER
                      , PM.NAME       AS PERSON_NAME
                      , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                      , HRM_COMMON_G.ID_NAME_F(WT.WORK_TYPE_ID)    AS WORK_TYPE
                      , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)  AS CORP_NAME
                      , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
                      , HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID)  AS DEPT_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                      , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID)         AS OCPT_NAME
                      , PM.JOIN_DATE
                      , PM.RETIRE_DATE
                      , WT.WORK_TYPE_GROUP
                      , WT.WORK_TYPE_ID
                      , T1.JOB_CATEGORY_ID
                      , PM.FLOOR_ID
                      , PM.CORP_ID
                      , PM.SOB_ID
                      , PM.ORG_ID
                      , PM.PERSON_ID
                   FROM HRM_PERSON_MASTER PM
                      , (-- 시점 인사내역.
                         SELECT HL.PERSON_ID
                              , HL.POST_ID
                              , HL.PAY_GRADE_ID
                              , HL.JOB_CATEGORY_ID
                              , HL.JOB_CLASS_ID
                           FROM HRM_HISTORY_LINE HL
                          WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                           FROM HRM_HISTORY_LINE S_HL
                                                          WHERE S_HL.CHARGE_DATE    <= W_END_DATE
                                                            AND S_HL.PERSON_ID       = HL.PERSON_ID
                                                       GROUP BY S_HL.PERSON_ID
                                                       )
                        ) T1
                      , (-- 시점 인사내역.
                         SELECT PH.PERSON_ID
                              , PH.FLOOR_ID
                              , PH.DEPT_ID
                              , PH.WORK_TYPE_ID
                           FROM HRD_PERSON_HISTORY        PH
                          WHERE PH.EFFECTIVE_DATE_FR  <=  W_END_DATE
                            AND PH.EFFECTIVE_DATE_TO  >=  W_END_DATE
                        ) T2
                      , HRM_WORK_TYPE_V WT
                  WHERE PM.PERSON_ID                   = T1.PERSON_ID
                    AND PM.PERSON_ID                   = T2.PERSON_ID
                    AND PM.WORK_TYPE_ID                = WT.WORK_TYPE_ID
                    AND PM.SOB_ID                      = W_SOB_ID
                    AND PM.ORG_ID                      = W_ORG_ID
                    AND PM.ORI_JOIN_DATE              <= W_END_DATE
                    AND(PM.RETIRE_DATE                   IS NULL 
                     OR PM.RETIRE_DATE                >= W_START_DATE)
                    AND PM.WORK_CORP_ID                = NVL(W_CORP_ID, PM.CORP_ID)
                    AND T2.FLOOR_ID                    = NVL(W_FLOOR_ID, T2.FLOOR_ID)
                    AND T2.WORK_TYPE_ID                = NVL(W_WORK_TYPE_ID, T2.WORK_TYPE_ID)
               ORDER BY PM.NAME
                      ;

      END LU_PERSON_SELECT12;


      -- LOOKUP PERSON INFOMATION[2011-11-03]
       PROCEDURE LU_PERSON_SELECT13
               ( P_CURSOR1        OUT TYPES.TCURSOR1
               , W_SOB_ID         IN  HRM_PERSON_MASTER.SOB_ID%TYPE
               , W_ORG_ID         IN  HRM_PERSON_MASTER.ORG_ID%TYPE
               )

       AS

       BEGIN

                 OPEN P_CURSOR1 FOR
                 SELECT PM.PERSON_NUM AS PERSON_NUMBER
                      , PM.NAME       AS PERSON_NAME
                      , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                      , HRM_COMMON_G.ID_NAME_F(WT.WORK_TYPE_ID)    AS WORK_TYPE
                      , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)  AS CORP_NAME
                      , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
                      , HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID)  AS DEPT_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                      , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID)         AS OCPT_NAME
                      , PM.JOIN_DATE
                      , PM.RETIRE_DATE
                      , WT.WORK_TYPE_GROUP
                      , WT.WORK_TYPE_ID
                      , T1.JOB_CATEGORY_ID
                      , PM.FLOOR_ID
                      , PM.CORP_ID
                      , PM.SOB_ID
                      , PM.ORG_ID
                      , PM.PERSON_ID
                   FROM HRM_PERSON_MASTER PM
                      , (-- 시점 인사내역.
                         SELECT HL.PERSON_ID
                              , HL.POST_ID
                              , HL.PAY_GRADE_ID
                              , HL.JOB_CATEGORY_ID
                              , HL.JOB_CLASS_ID
                           FROM HRM_HISTORY_LINE HL
                          WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                           FROM HRM_HISTORY_LINE      S_HL
                                                          WHERE S_HL.PERSON_ID     =  HL.PERSON_ID
                                                            AND S_HL.CHARGE_DATE  <=  SYSDATE
                                                       GROUP BY S_HL.PERSON_ID
                                                       )
                        ) T1
                      , (-- 시점 인사내역.
                         SELECT PH.PERSON_ID
                              , PH.FLOOR_ID
                              , PH.DEPT_ID
                              , PH.WORK_TYPE_ID
                           FROM HRD_PERSON_HISTORY       PH
                          WHERE PH.EFFECTIVE_DATE_FR  <=  SYSDATE
                            AND PH.EFFECTIVE_DATE_TO  >=  SYSDATE
                        ) T2
                      , HRM_WORK_TYPE_V WT
                  WHERE PM.PERSON_ID                   = T1.PERSON_ID
                    AND PM.PERSON_ID                   = T2.PERSON_ID
                    AND PM.WORK_TYPE_ID                = WT.WORK_TYPE_ID
                    AND PM.SOB_ID                      = W_SOB_ID
                    AND PM.ORG_ID                      = W_ORG_ID
               ORDER BY PM.NAME
                      ;

      END LU_PERSON_SELECT13;



-- LOOKUP PERSON INFOMATION[2011-12-14]추가
   PROCEDURE LU_PERSON_SELECT14
           ( P_CURSOR         OUT TYPES.TCURSOR
           , W_SOB_ID         IN  NUMBER
           , W_ORG_ID         IN  NUMBER
           )
 
   AS
 
   BEGIN
 
             OPEN P_CURSOR FOR
             SELECT HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) AS EMPLOYE_TYPE_NAME
                  , PM.PERSON_NUM                              AS PERSON_NUMBER
                  , PM.NAME                                    AS PERSON_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID)        AS FLOOR_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID)    AS WORK_TYPE
                  , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)  AS CORP_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.POST_ID)         AS POST_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.PAY_GRADE_ID)    AS PAY_GRADE_NAME
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID)  AS DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID)         AS OCPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                  , PM.JOIN_DATE                               AS JOIN_DATE
                  , PM.RETIRE_DATE                             AS RETIRE_DATE
                  , PM.WORK_TYPE_ID
                  , PM.JOB_CATEGORY_ID
                  , PM.FLOOR_ID
                  , PM.CORP_ID
                  , PM.DEPT_ID
                  , PM.SOB_ID
                  , PM.ORG_ID
                  , PM.PERSON_ID
               FROM HRM_PERSON_MASTER   PM
              WHERE PM.SOB_ID        =  W_SOB_ID
                AND PM.ORG_ID        =  W_ORG_ID
           ORDER BY PM.NAME
                  ;
 
  END LU_PERSON_SELECT14;


-- LOOKUP PERSON INFOMATION[2011-12-14]추가
   PROCEDURE LU_PERSON_SELECT15
           ( P_CURSOR         OUT TYPES.TCURSOR
           , W_SOB_ID         IN  NUMBER
           , W_ORG_ID         IN  NUMBER
           , W_WORK_TYPE_ID   IN  NUMBER
           , W_DEPT_ID        IN  NUMBER
           , W_FLOOR_ID       IN  NUMBER
           , W_EMPLOYE        IN  VARCHAR2
           )
 
   AS
 
   BEGIN
 
             OPEN P_CURSOR FOR
             SELECT HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) AS EMPLOYE_TYPE_NAME
                  , PM.PERSON_NUM                              AS PERSON_NUMBER
                  , PM.NAME                                    AS PERSON_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID)        AS FLOOR_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID)    AS WORK_TYPE
                  , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)  AS CORP_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.POST_ID)         AS POST_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.PAY_GRADE_ID)    AS PAY_GRADE_NAME
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID)  AS DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID)         AS OCPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                  , PM.JOIN_DATE                               AS JOIN_DATE
                  , PM.RETIRE_DATE                             AS RETIRE_DATE
                  , PM.WORK_TYPE_ID
                  , PM.JOB_CATEGORY_ID
                  , PM.FLOOR_ID
                  , PM.CORP_ID
                  , PM.DEPT_ID
                  , PM.SOB_ID
                  , PM.ORG_ID
                  , PM.PERSON_ID
               FROM HRM_PERSON_MASTER   PM
              WHERE PM.SOB_ID        =  W_SOB_ID
                AND PM.ORG_ID        =  W_ORG_ID
                AND PM.WORK_TYPE_ID  =  NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
                AND PM.DEPT_ID       =  NVL(W_DEPT_ID, PM.DEPT_ID)
                AND PM.FLOOR_ID      =  NVL(W_FLOOR_ID, PM.FLOOR_ID)
                AND PM.EMPLOYE_TYPE  =  NVL(W_EMPLOYE, PM.EMPLOYE_TYPE)
           ORDER BY PM.NAME
                  ;
 
  END LU_PERSON_SELECT15;



-- LOOKUP PERSON INFOMATION[2011-12-19]추가
   PROCEDURE LU_PERSON_SELECT16
           ( P_CURSOR         OUT TYPES.TCURSOR
           , W_SOB_ID         IN  NUMBER
           , W_ORG_ID         IN  NUMBER
           , W_WORK_DATE_TO   IN  DATE
           , W_WORK_TYPE_ID   IN  NUMBER
           , W_DEPT_ID        IN  NUMBER
           , W_FLOOR_ID       IN  NUMBER
           , W_EMPLOYE        IN  VARCHAR2
           )

   AS

   BEGIN

             OPEN P_CURSOR FOR
             SELECT HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) AS EMPLOYE_TYPE_NAME
                  , PM.PERSON_NUM                              AS PERSON_NUMBER
                  , PM.NAME                                    AS PERSON_NAME
                  , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                  , HRM_COMMON_G.ID_NAME_F(WT.WORK_TYPE_ID)    AS WORK_TYPE
                  , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)  AS CORP_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID)    AS PAY_GRADE_NAME
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID)  AS DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID)         AS OCPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                  , PM.JOIN_DATE                               AS JOIN_DATE
                  , PM.RETIRE_DATE                             AS RETIRE_DATE
                  , WT.WORK_TYPE_ID
                  , T1.JOB_CATEGORY_ID
                  , PM.FLOOR_ID
                  , PM.CORP_ID
                  , PM.DEPT_ID
                  , PM.SOB_ID
                  , PM.ORG_ID
                  , PM.PERSON_ID
               FROM HRM_PERSON_MASTER PM
                  , (-- 시점 인사내역.
                     SELECT HL.PERSON_ID
                          , HL.POST_ID
                          , HL.PAY_GRADE_ID
                          , HL.JOB_CATEGORY_ID
                          , HL.JOB_CLASS_ID
                       FROM HRM_HISTORY_LINE HL
                      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                       FROM HRM_HISTORY_LINE       S_HL
                                                      WHERE S_HL.PERSON_ID       = HL.PERSON_ID
                                                        AND S_HL.CHARGE_DATE    <= TRUNC(W_WORK_DATE_TO)
                                                   GROUP BY S_HL.PERSON_ID
                                                   )
                    ) T1
                  , (-- 시점 인사내역.
                     SELECT PH.PERSON_ID
                          , PH.FLOOR_ID
                          , PH.DEPT_ID
                          , PH.WORK_TYPE_ID
                       FROM HRD_PERSON_HISTORY        PH
                      WHERE PH.EFFECTIVE_DATE_FR  <=  TRUNC(W_WORK_DATE_TO)
                        AND PH.EFFECTIVE_DATE_TO  >=  TRUNC(W_WORK_DATE_TO)
                    ) T2
                  , HRM_WORK_TYPE_V     WT
              WHERE PM.PERSON_ID     =  T1.PERSON_ID
                AND PM.PERSON_ID     =  T2.PERSON_ID
                AND PM.WORK_TYPE_ID  =  WT.WORK_TYPE_ID
                AND PM.SOB_ID        =  W_SOB_ID
                AND PM.ORG_ID        =  W_ORG_ID
                AND PM.WORK_TYPE_ID  =  NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
                AND T2.DEPT_ID       =  NVL(W_DEPT_ID, T2.DEPT_ID)
                AND T2.FLOOR_ID      =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                AND PM.EMPLOYE_TYPE  =  NVL(W_EMPLOYE, PM.EMPLOYE_TYPE)
           ORDER BY PM.NAME
                  ;

  END LU_PERSON_SELECT16;

-- LOOKUP PERSON INFOMATION[2012-03-02]추가
   PROCEDURE LU_PERSON_SELECT17
           ( P_CURSOR             OUT TYPES.TCURSOR
           , W_SOB_ID             IN  NUMBER
           , W_ORG_ID             IN  NUMBER
           , W_WORK_DATE_TO       IN  DATE
           , W_WORK_TYPE_ID       IN  NUMBER
           , W_DEPT_ID            IN  NUMBER
           , W_FLOOR_ID           IN  NUMBER
           , W_EMPLOYE            IN  VARCHAR2
           , W_CONNECT_PERSON_ID  IN NUMBER
           )
  AS
    V_CONNECT_PERSON_ID           NUMBER;
  BEGIN
    IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => 65 --W_CORP_ID
                              , W_START_DATE => TRUNC(W_WORK_DATE_TO)
                              , W_END_DATE => TRUNC(W_WORK_DATE_TO)
                              , W_MODULE_CODE => '20'
                              , W_PERSON_ID => W_CONNECT_PERSON_ID
                              , W_SOB_ID => W_SOB_ID
                              , W_ORG_ID => W_ORG_ID) = 'C' THEN
      V_CONNECT_PERSON_ID := NULL;
    ELSE
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;
             OPEN P_CURSOR FOR
             SELECT HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) AS EMPLOYE_TYPE_NAME
                  , PM.PERSON_NUM                              AS PERSON_NUMBER
                  , PM.NAME                                    AS PERSON_NAME
                  , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                  , HRM_COMMON_G.ID_NAME_F(WT.WORK_TYPE_ID)    AS WORK_TYPE
                  , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)  AS CORP_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID)    AS PAY_GRADE_NAME
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID)  AS DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID)         AS OCPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                  , PM.JOIN_DATE                               AS JOIN_DATE
                  , PM.RETIRE_DATE                             AS RETIRE_DATE
                  , WT.WORK_TYPE_ID
                  , T1.JOB_CATEGORY_ID
                  , PM.FLOOR_ID
                  , PM.CORP_ID
                  , PM.DEPT_ID
                  , PM.SOB_ID
                  , PM.ORG_ID
                  , PM.PERSON_ID
               FROM HRM_PERSON_MASTER PM
                  , (-- 시점 인사내역.
                     SELECT HL.PERSON_ID
                          , HL.POST_ID
                          , HL.PAY_GRADE_ID
                          , HL.JOB_CATEGORY_ID
                          , HL.JOB_CLASS_ID
                       FROM HRM_HISTORY_LINE HL
                      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                       FROM HRM_HISTORY_LINE       S_HL
                                                      WHERE S_HL.PERSON_ID       = HL.PERSON_ID
                                                        AND S_HL.CHARGE_DATE    <= TRUNC(W_WORK_DATE_TO)
                                                   GROUP BY S_HL.PERSON_ID
                                                   )
                    ) T1
                  , (-- 시점 인사내역.
                     SELECT PH.PERSON_ID
                          , PH.FLOOR_ID
                          , PH.DEPT_ID
                          , PH.WORK_TYPE_ID
                       FROM HRD_PERSON_HISTORY        PH
                      WHERE PH.EFFECTIVE_DATE_FR  <=  TRUNC(W_WORK_DATE_TO)
                        AND PH.EFFECTIVE_DATE_TO  >=  TRUNC(W_WORK_DATE_TO)
                    ) T2
                  , HRM_WORK_TYPE_V     WT
              WHERE PM.PERSON_ID     =  T1.PERSON_ID
                AND PM.PERSON_ID     =  T2.PERSON_ID
                AND PM.WORK_TYPE_ID  =  WT.WORK_TYPE_ID
                AND PM.SOB_ID        =  W_SOB_ID
                AND PM.ORG_ID        =  W_ORG_ID
                AND PM.WORK_TYPE_ID  =  NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
                AND T2.DEPT_ID       =  NVL(W_DEPT_ID, T2.DEPT_ID)
                AND T2.FLOOR_ID      =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                AND PM.EMPLOYE_TYPE  =  NVL(W_EMPLOYE, PM.EMPLOYE_TYPE)
                AND EXISTS (SELECT 'X'
                              FROM HRD_DUTY_MANAGER DM
                            WHERE DM.CORP_ID                                = PM.WORK_CORP_ID
                              AND DM.DUTY_CONTROL_ID                        = T2.FLOOR_ID
                              AND DM.WORK_TYPE_ID                           = DECODE(NVL(DM.WORK_TYPE_ID, 0), 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
                              AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
                              AND DM.SOB_ID                                 = PM.SOB_ID
                              AND DM.ORG_ID                                 = PM.ORG_ID
                          )
           ORDER BY PM.NAME
                  ;
  
  END LU_PERSON_SELECT17;





-- 사원 ID를 가지고 사원번호 조회..
   FUNCTION PERSON_NUMBER_F
          ( W_PERSON_ID  IN  NUMBER
          ) RETURN           VARCHAR2
   AS

            V_PERSON_NUM     VARCHAR2(100);

   BEGIN
        BEGIN
             SELECT PM.PERSON_NUM
               INTO V_PERSON_NUM
               FROM HRM_PERSON_MASTER PM
              WHERE PM.PERSON_ID = W_PERSON_ID
                  ;
        EXCEPTION 
             WHEN OTHERS 
             THEN
                  V_PERSON_NUM := NULL;
        END;

    RETURN V_PERSON_NUM;

   END PERSON_NUMBER_F;





-- 사원 ID를 가지고 작업장 조회..
   FUNCTION PERSON_FLOOR_NAME_F
          ( W_PERSON_ID  IN  NUMBER
          ) RETURN           VARCHAR2
   AS

            V_FLOOR_NAME     VARCHAR2(100);

   BEGIN
        BEGIN
             SELECT HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID)
               INTO V_FLOOR_NAME
               FROM HRM_PERSON_MASTER PM
              WHERE PM.PERSON_ID = W_PERSON_ID
                  ;
        EXCEPTION 
             WHEN OTHERS 
             THEN
                  V_FLOOR_NAME := NULL;
        END;

    RETURN V_FLOOR_NAME;

   END PERSON_FLOOR_NAME_F;




-- DATA PRINT.
  PROCEDURE DATA_PRINT
	          ( P_CURSOR1                           OUT TYPES.TCURSOR1
						, W_CORP_ID                           IN NUMBER
						, W_DEPT_ID                           IN NUMBER
						, W_EMPLOYE_TYPE                      IN VARCHAR2
						, W_NAME                              IN VARCHAR2
						, W_SOB_ID                            IN NUMBER
						, W_ORG_ID                            IN NUMBER
						)
  AS
  BEGIN
     OPEN P_CURSOR1 FOR
        SELECT 'N' AS SELECT_CHECK_YN
            , PM.PERSON_ID O_PERSON_ID
            , PM.PERSON_NUM O_PERSON_NUM
            , PM.NAME O_NAME
            , PM.PERSON_ID
            , PM.PERSON_NUM
            , PM.NAME 
            , PM.NAME1 
            , PM.NAME2 
            , PM.CORP_ID
            , CM.CORP_NAME
            , PM.OPERATING_UNIT_ID
            , OU.OPERATING_UNIT_NAME 
            , PM.DEPT_ID
            , DM.DEPT_CODE
            , DM.DEPT_NAME
            , PM.NATION_ID 
            , HRM_COMMON_G.ID_NAME_F(PM.NATION_ID) NATION_NAME
            , PM.WORK_AREA_ID 
            , HRM_COMMON_G.ID_NAME_F(PM.WORK_AREA_ID) WORK_AREA_NAME
            , PM.WORK_TYPE_ID
            , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) WORK_TYPE_NAME
            , PM.JOB_CLASS_ID
            , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID) JOB_CLASS_NAME
            , PM.JOB_ID
            , HRM_COMMON_G.ID_NAME_F(PM.JOB_ID) JOB_NAME
            , PM.POST_ID
            , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) POST_NAME
            , PM.OCPT_ID
            , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID) OCPT_NAME
            , PM.ABIL_ID
            , HRM_COMMON_G.ID_NAME_F(PM.ABIL_ID) ABIL_NAME
            , PM.PAY_GRADE_ID
            , HRM_COMMON_G.ID_NAME_F(PM.PAY_GRADE_ID) PAY_GRADE_NAME
            , PM.REPRE_NUM
            , PM.SEX_TYPE
            , HRM_COMMON_G.CODE_NAME_F('SEX_TYPE', PM.SEX_TYPE, PM.SOB_ID, PM.ORG_ID) SEX_NAME
            , PM.BIRTHDAY
            , NVL(PM.BIRTHDAY_TYPE, 'N')BIRTHDAY_TYPE
            , HRM_COMMON_G.CODE_NAME_F('BIRTHDAY_TYPE', PM.BIRTHDAY_TYPE, PM.SOB_ID, PM.ORG_ID) BIRTHDAY_TYPE_NAME
            , PM.MARRY_YN
            , PM.MARRY_DATE
            , PM.JOIN_ID
            , HRM_COMMON_G.ID_NAME_F(PM.JOIN_ID) JOIN_NAME
            , PM.JOIN_ROUTE_ID
            , HRM_COMMON_G.ID_NAME_F(PM.JOIN_ROUTE_ID) JOIN_ROUTE_NAME
            , PM.ORI_JOIN_DATE
            , PM.JOIN_DATE
            , PM.PAY_DATE
            , PM.DEPT_DATE
            , PM.OFFICIALLY_DATE
            , PM.SHO_DATE
            , PM.EXPIRE_DATE
            , PM.PROMOTION_EXPECT_DATE
            , PM.RETIRE_DATE
            , PM.RETIRE_ID
            , HRM_COMMON_G.ID_NAME_F(PM.RETIRE_ID) RETIRE_NAME
            , PM.DIR_INDIR_TYPE
            , HRM_COMMON_G.CODE_NAME_F('DIR_INDIR_TYPE', PM.DIR_INDIR_TYPE, PM.SOB_ID, PM.ORG_ID) DIR_INDIR_TYPE_NAME
            , PM.EMPLOYE_TYPE
            , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) EMPLOYE_TYPE_NAME
            , PM.LEGAL_ZIP_CODE
            , PM.LEGAL_ADDR1
            , PM.LEGAL_ADDR2
            , PM.PRSN_ZIP_CODE
            , PM.PRSN_ADDR1
            , PM.PRSN_ADDR2
            , PM.LIVE_ZIP_CODE
            , PM.LIVE_ADDR1
            , PM.LIVE_ADDR2
            , PM.TELEPHON_NO
            , PM.HP_PHONE_NO
            , PM.EMAIL
            , PM.RELIGION_ID
            , HRM_COMMON_G.ID_NAME_F(PM.RELIGION_ID) RELIGION_NAME
            , PM.END_SCH_ID
            , HRM_COMMON_G.ID_NAME_F(PM.END_SCH_ID) END_SCH_NAME
            , PM.HOBBY
            , PM.TALENT
            , PM.JOB_CATEGORY_ID
            , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) JOB_CATEGORY_NAME
            , PM.FLOOR_ID
            , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) FLOOR_NAME
            , PM.COST_CENTER_ID
            , HRM_COMMON_G.COST_CENTER_DESC_F(PM.COST_CENTER_ID) AS COST_CENTER
            , PM.IC_CARD_NO
            , PM.OLD_PERSON_NUM
            , PM.CORP_TYPE
/*            , PM.SOB_ID
            , PM.ORG_ID*/
            , PM.DESCRIPTION
            , PM.LAST_UPDATE_DATE
            , PM.LAST_UPDATED_BY
            , PM.LABOR_UNION_YN
        FROM HRM_PERSON_MASTER PM
          , HRM_CORP_MASTER CM
          , HRM_OPERATING_UNIT OU
          , HRM_DEPT_MASTER DM
        WHERE PM.CORP_ID                                    = CM.CORP_ID  
          AND PM.OPERATING_UNIT_ID                          = OU.OPERATING_UNIT_ID
          AND PM.DEPT_ID                                    = DM.DEPT_ID
          AND PM.CORP_ID                                    = NVL(W_CORP_ID, PM.CORP_ID)
          AND PM.DEPT_ID                                    = NVL(W_DEPT_ID, PM.DEPT_ID)
          AND PM.NAME                                       LIKE W_NAME || '%'
          AND PM.EMPLOYE_TYPE                               = NVL(W_EMPLOYE_TYPE, PM.EMPLOYE_TYPE)
					AND PM.SOB_ID                                     = W_SOB_ID
					AND PM.ORG_ID                                     = W_ORG_ID
          AND NOT EXISTS( SELECT 'X'
                            FROM HRM_CORP_MASTER CM
                          WHERE CM.CORP_ID        = PM.CORP_ID
                            AND CM.CORP_TYPE      IN('2', '3', '4', '5')
                        )
			  ORDER BY PM.PERSON_NUM, PM.NAME;
          
  END DATA_PRINT;
  
END HRM_PERSON_MASTER_G;
/
