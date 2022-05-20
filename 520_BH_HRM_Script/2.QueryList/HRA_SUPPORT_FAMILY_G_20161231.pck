CREATE OR REPLACE PACKAGE HRA_SUPPORT_FAMILY_G AS

  /*======================================================================/
       ++ 연말정산 부양가족 관계.
  /======================================================================*/
-- 부양가족 인적사항.
  PROCEDURE SELECT_SUPPORT_FAMILY
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN VARCHAR2
            , P_STD_YYYYMM        IN VARCHAR2  
            , P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

-- 부양가족 사용금액.
  PROCEDURE SELECT_FAMILY_AMOUNT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , P_YEAR_YYYY         IN VARCHAR2
            , P_STD_YYYYMM        IN VARCHAR2
            , P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

                        
/*======================================================================/
   ++ 연말정산 부양가족 관계 생성.
/======================================================================*/
  PROCEDURE CREATE_SUPPORT_FAMILY
            ( P_YEAR_YYYY         IN VARCHAR2
            , P_STD_YYYYMM        IN VARCHAR2 
            , P_CORP_ID           IN NUMBER
            , P_YEAR_EMPLOYE_TYPE IN VARCHAR2 DEFAULT NULL 
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );
            
-- 삭제 : 부양가족 인적사항.
  PROCEDURE DELETE_SUPPORT_FAMILY
            ( W_PERSON_ID  IN  HRA_SUPPORT_FAMILY.PERSON_ID%TYPE
            , W_REPRE_NUM  IN  HRA_SUPPORT_FAMILY.REPRE_NUM%TYPE
            , W_SOB_ID     IN  HRA_SUPPORT_FAMILY.SOB_ID%TYPE
            , W_ORG_ID     IN  HRA_SUPPORT_FAMILY.ORG_ID%TYPE
            , W_YEAR_YYYY  IN  HRA_SUPPORT_FAMILY.YEAR_YYYY%TYPE
            );

-- 동기화 부양가족 기본공제 체크시 추가공제 동기화 리턴 
  PROCEDURE INIT_SUPPORT_FAMILY_YN_P
            ( W_PERSON_ID                       IN  HRA_SUPPORT_FAMILY.PERSON_ID%TYPE
            , W_REPRE_NUM                       IN  HRA_SUPPORT_FAMILY.REPRE_NUM%TYPE
            , W_SOB_ID                          IN  HRA_SUPPORT_FAMILY.SOB_ID%TYPE
            , W_ORG_ID                          IN  HRA_SUPPORT_FAMILY.ORG_ID%TYPE
            , W_YEAR_YYYY                       IN  HRA_SUPPORT_FAMILY.YEAR_YYYY%TYPE
            , W_YEAR_RELATION_CODE              IN  HRA_SUPPORT_FAMILY.RELATION_CODE%TYPE
            , W_BASE_YN                         IN  HRA_SUPPORT_FAMILY.BASE_YN%TYPE
            , O_SPOUSE_YN                       OUT HRA_SUPPORT_FAMILY.SPOUSE_YN%TYPE
            , O_OLD_YN                          OUT HRA_SUPPORT_FAMILY.OLD_YN%TYPE
            , O_OLD1_YN                         OUT HRA_SUPPORT_FAMILY.OLD1_YN%TYPE
            , O_CHILD_YN                        OUT HRA_SUPPORT_FAMILY.CHILD_YN%TYPE
            , O_BIRTH_YN                        OUT HRA_SUPPORT_FAMILY.BIRTH_YN%TYPE
            );
            
-- 검증 : 부양가족 인적사항 대상여부 체크.
  PROCEDURE CHECK_SUPPORT_FAMILY_P
            ( W_PERSON_ID                       IN  HRA_SUPPORT_FAMILY.PERSON_ID%TYPE
            , W_REPRE_NUM                       IN  HRA_SUPPORT_FAMILY.REPRE_NUM%TYPE
            , W_SOB_ID                          IN  HRA_SUPPORT_FAMILY.SOB_ID%TYPE
            , W_ORG_ID                          IN  HRA_SUPPORT_FAMILY.ORG_ID%TYPE
            , W_YEAR_YYYY                       IN  HRA_SUPPORT_FAMILY.YEAR_YYYY%TYPE
            , P_YEAR_RELATION_CODE              IN  HRA_SUPPORT_FAMILY.RELATION_CODE%TYPE
            , P_BASE_YN                         IN  HRA_SUPPORT_FAMILY.BASE_YN%TYPE
            , P_BASE_LIVING_YN                  IN  HRA_SUPPORT_FAMILY.BASE_LIVING_YN%TYPE 
            , P_SPOUSE_YN                       IN  HRA_SUPPORT_FAMILY.SPOUSE_YN%TYPE
            , P_OLD_YN                          IN  HRA_SUPPORT_FAMILY.OLD_YN%TYPE
            , P_OLD1_YN                         IN  HRA_SUPPORT_FAMILY.OLD1_YN%TYPE
            , P_WOMAN_YN                        IN  HRA_SUPPORT_FAMILY.WOMAN_YN%TYPE 
            , P_SINGLE_PARENT_DED_YN            IN  HRA_SUPPORT_FAMILY.SINGLE_PARENT_DED_YN%TYPE 
            , P_CHILD_YN                        IN  HRA_SUPPORT_FAMILY.CHILD_YN%TYPE
            , P_BIRTH_YN                        IN  HRA_SUPPORT_FAMILY.BIRTH_YN%TYPE
            , P_DISABILITY_YN                   IN  HRA_SUPPORT_FAMILY.DISABILITY_YN%TYPE 
            , P_DISABILITY_CODE                 IN  HRA_SUPPORT_FAMILY.DISABILITY_CODE%TYPE 
            , O_STATUS                          OUT VARCHAR2
            , O_MESSAGE                         OUT VARCHAR2
            );
            
-- 웹 시스템 검증 : 부양가족 인적사항 대상여부 체크.
  PROCEDURE WEB_CHECK_SUPPORT_FAMILY_P
            ( W_PERSON_ID                       IN  HRA_SUPPORT_FAMILY.PERSON_ID%TYPE
            , W_REPRE_NUM                       IN  HRA_SUPPORT_FAMILY.REPRE_NUM%TYPE
            , W_SOB_ID                          IN  HRA_SUPPORT_FAMILY.SOB_ID%TYPE
            , W_ORG_ID                          IN  HRA_SUPPORT_FAMILY.ORG_ID%TYPE
            , W_YEAR_YYYY                       IN  HRA_SUPPORT_FAMILY.YEAR_YYYY%TYPE
            , P_FAMILY_RELATION_CODE            IN  VARCHAR2 
            , P_BASE_YN                         IN  HRA_SUPPORT_FAMILY.BASE_YN%TYPE
            , P_BASE_LIVING_YN                  IN  HRA_SUPPORT_FAMILY.BASE_LIVING_YN%TYPE 
            , P_SPOUSE_YN                       IN  HRA_SUPPORT_FAMILY.SPOUSE_YN%TYPE
            , P_OLD_YN                          IN  HRA_SUPPORT_FAMILY.OLD_YN%TYPE
            , P_OLD1_YN                         IN  HRA_SUPPORT_FAMILY.OLD1_YN%TYPE
            , P_WOMAN_YN                        IN  HRA_SUPPORT_FAMILY.WOMAN_YN%TYPE 
            , P_SINGLE_PARENT_DED_YN            IN  HRA_SUPPORT_FAMILY.SINGLE_PARENT_DED_YN%TYPE 
            , P_CHILD_YN                        IN  HRA_SUPPORT_FAMILY.CHILD_YN%TYPE
            , P_BIRTH_YN                        IN  HRA_SUPPORT_FAMILY.BIRTH_YN%TYPE
            , P_DISABILITY_YN                   IN  HRA_SUPPORT_FAMILY.DISABILITY_YN%TYPE 
            , P_DISABILITY_CODE                 IN  HRA_SUPPORT_FAMILY.DISABILITY_CODE%TYPE 
            , O_STATUS                          OUT VARCHAR2
            , O_MESSAGE                         OUT VARCHAR2
            );            
            
-- 수정 : 부양가족 인적사항.
  PROCEDURE UPDATE_SUPPORT_FAMILY
            ( W_PERSON_ID                       IN  HRA_SUPPORT_FAMILY.PERSON_ID%TYPE
            , W_REPRE_NUM                       IN  HRA_SUPPORT_FAMILY.REPRE_NUM%TYPE
            , W_SOB_ID                          IN  HRA_SUPPORT_FAMILY.SOB_ID%TYPE
            , W_ORG_ID                          IN  HRA_SUPPORT_FAMILY.ORG_ID%TYPE
            , W_YEAR_YYYY                       IN  HRA_SUPPORT_FAMILY.YEAR_YYYY%TYPE
            , P_USER_ID                         IN  HRA_SUPPORT_FAMILY.LAST_UPDATED_BY%TYPE
            , P_YEAR_RELATION_CODE              IN  HRA_SUPPORT_FAMILY.RELATION_CODE%TYPE
            , P_FAMILY_NAME                     IN  HRA_SUPPORT_FAMILY.FAMILY_NAME%TYPE
            , P_BASE_YN                         IN  HRA_SUPPORT_FAMILY.BASE_YN%TYPE
            , P_BASE_LIVING_YN                  IN  HRA_SUPPORT_FAMILY.BASE_LIVING_YN%TYPE 
            , P_SUPPORT_YN                      IN  HRA_SUPPORT_FAMILY.SUPPORT_YN%TYPE
            , P_SPOUSE_YN                       IN  HRA_SUPPORT_FAMILY.SPOUSE_YN%TYPE
            , P_OLD_YN                          IN  HRA_SUPPORT_FAMILY.OLD_YN%TYPE
            , P_OLD1_YN                         IN  HRA_SUPPORT_FAMILY.OLD1_YN%TYPE
            , P_DISABILITY_YN                   IN  HRA_SUPPORT_FAMILY.DISABILITY_YN%TYPE 
            , P_DISABILITY_CODE                 IN  HRA_SUPPORT_FAMILY.DISABILITY_CODE%TYPE  
            , P_WOMAN_YN                        IN  HRA_SUPPORT_FAMILY.WOMAN_YN%TYPE
            , P_SINGLE_PARENT_DED_YN            IN  HRA_SUPPORT_FAMILY.SINGLE_PARENT_DED_YN%TYPE 
            , P_CHILD_YN                        IN  HRA_SUPPORT_FAMILY.CHILD_YN%TYPE
            , P_BIRTH_YN                        IN  HRA_SUPPORT_FAMILY.BIRTH_YN%TYPE
            , P_EDUCATION_TYPE                  IN  HRA_SUPPORT_FAMILY.EDUCATION_TYPE%TYPE
            );

-- 수정 : 부양가족 비용.
  PROCEDURE UPDATE_SUPPORT_AMOUNT
            ( W_PERSON_ID                       IN  HRA_SUPPORT_FAMILY.PERSON_ID%TYPE
            , W_REPRE_NUM                       IN  HRA_SUPPORT_FAMILY.REPRE_NUM%TYPE
            , W_SOB_ID                          IN  HRA_SUPPORT_FAMILY.SOB_ID%TYPE
            , W_ORG_ID                          IN  HRA_SUPPORT_FAMILY.ORG_ID%TYPE
            , W_YEAR_YYYY                       IN  HRA_SUPPORT_FAMILY.YEAR_YYYY%TYPE
            , P_USER_ID                         IN  HRA_SUPPORT_FAMILY.LAST_UPDATED_BY%TYPE
            , P_YEAR_RELATION_CODE              IN  HRA_SUPPORT_FAMILY.RELATION_CODE%TYPE
            , P_FAMILY_NAME                     IN  HRA_SUPPORT_FAMILY.FAMILY_NAME%TYPE
            , P_AMOUNT_TYPE                     IN  VARCHAR2
            , P_MEDIC_INSUR_AMT                 IN  HRA_SUPPORT_FAMILY.MEDIC_INSUR_AMT%TYPE 
            , P_MEDICAL_NANIM_AMT               IN  HRA_SUPPORT_FAMILY.MEDICAL_NANIM_AMT%TYPE 
            , P_INSURE_AMT                      IN  HRA_SUPPORT_FAMILY.INSURE_AMT%TYPE
            , P_DISABILITY_INSURE_AMT           IN  HRA_SUPPORT_FAMILY.DISABILITY_INSURE_AMT%TYPE
            , P_MEDICAL_AMT                     IN  HRA_SUPPORT_FAMILY.MEDICAL_AMT%TYPE
            , P_EDUCATION_AMT                   IN  HRA_SUPPORT_FAMILY.EDUCATION_AMT%TYPE
            , P_CREDIT_AMT                      IN  HRA_SUPPORT_FAMILY.CREDIT_AMT%TYPE
            , P_CHECK_CREDIT_AMT                IN  HRA_SUPPORT_FAMILY.CHECK_CREDIT_AMT%TYPE
            , P_CASH_AMT                        IN  HRA_SUPPORT_FAMILY.CASH_AMT%TYPE
            , P_ACADE_GIRO_AMT                  IN  HRA_SUPPORT_FAMILY.ACADE_GIRO_AMT%TYPE
            , P_TRAD_MARKET_AMT                 IN  HRA_SUPPORT_FAMILY.TRAD_MARKET_AMT%TYPE
            , P_PUBLIC_TRANSIT_AMT              IN  HRA_SUPPORT_FAMILY.PUBLIC_TRANSIT_AMT%TYPE 
            , P_DONAT_ALL                       IN  HRA_SUPPORT_FAMILY.DONAT_ALL%TYPE
            , P_DONAT_50P                       IN  HRA_SUPPORT_FAMILY.DONAT_50P%TYPE
            , P_DONAT_30P                       IN  HRA_SUPPORT_FAMILY.DONAT_30P%TYPE
            , P_DONAT_10P                       IN  HRA_SUPPORT_FAMILY.DONAT_10P%TYPE
            , P_DONAT_10P_RELIGION              IN  HRA_SUPPORT_FAMILY.DONAT_10P_RELIGION%TYPE
            , P_DONAT_POLI                      IN  HRA_SUPPORT_FAMILY.DONAT_POLI%TYPE
            , P_CREDIT_ALL_AMT_2013             IN  NUMBER DEFAULT NULL   -- 2013년 총사용액 
            , P_ADD_CREDIT_AMT_2013             IN  NUMBER DEFAULT NULL   -- 2013년 추가 사용액 
            , P_CREDIT_ALL_AMT_2014             IN  NUMBER DEFAULT NULL   -- 2014년 총사용액.
            , P_ADD_CREDIT_AMT_2014             IN  NUMBER DEFAULT NULL   -- 2014년 추가공제율사용분.
            , P_PRE_CREDIT_ALL_AMT              IN  NUMBER DEFAULT NULL   -- 전년도 총사용액 
            , P_PRE_ADD_CREDIT_AMT              IN  NUMBER DEFAULT NULL   -- 전년도 추가사용액 
            , P_PRE_SEC_CREDIT_AMT              IN  NUMBER DEFAULT NULL   -- 전년도 하반기 사용액.
            , P_ADD_CREDIT_AMT                  IN  NUMBER DEFAULT NULL   -- 당년도 추가사용액(상반기) 
            , P_ADD_SEC_CREDIT_AMT              IN  NUMBER DEFAULT NULL   -- 당년도 추가사용액(하반기) 
            );


/*======================================================================/
     ++ 연말정산 부양가족 내역 --> 인사 부양가족 내역으로 interface  
/======================================================================*/
  PROCEDURE INIT_SUPPORT_FAMILY
            ( O_STATUS            OUT VARCHAR2 
            , O_MESSAGE           OUT VARCHAR2 
            , P_CONNECT_PERSON_ID IN  NUMBER 
            , P_YEAR_YYYY         IN  VARCHAR2
            , P_PERSON_ID         IN  NUMBER
            , P_SOB_ID            IN  NUMBER
            , P_ORG_ID            IN  NUMBER
            );

/*======================================================================/
     ++ 전년도 신용카드 사용액 UPDATE 
/======================================================================*/
  PROCEDURE INIT_PRE_CREDIT_AMOUNT
            ( O_STATUS            OUT VARCHAR2 
            , O_MESSAGE           OUT VARCHAR2 
            , P_YEAR_YYYY         IN  VARCHAR2 
            , P_OPERATING_UNIT_ID IN  NUMBER DEFAULT NULL 
            , P_YEAR_EMPLOYE_TYPE IN  VARCHAR2 DEFAULT NULL 
            , P_DEPT_ID           IN  NUMBER DEFAULT NULL 
            , P_FLOOR_ID          IN  NUMBER DEFAULT NULL 
            , P_PERSON_ID         IN  NUMBER
            , P_SOB_ID            IN  NUMBER
            , P_ORG_ID            IN  NUMBER         
            );
                        
                        
/*======================================================================/
     ++ 전년도 신용카드등 전체 사용 금액 
/======================================================================*/
  FUNCTION GET_PRE_CREDIT_ALL_AMT_F
            ( P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_RELATION_CODE     IN VARCHAR2 
            , P_REPRE_NUM         IN VARCHAR2 
            ) RETURN NUMBER;
                        
/*======================================================================/
     ++ 전년도 추가공제 사용 금액 
/======================================================================*/
  FUNCTION GET_PRE_ADD_CREDIT_AMT_F
            ( P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_RELATION_CODE     IN VARCHAR2 
            , P_REPRE_NUM         IN VARCHAR2 
            ) RETURN NUMBER;
            
/*======================================================================/
     ++ 2013년도 추가공제 사용 금액 
/======================================================================*/
  FUNCTION GET_2013_CREDIT_ALL_AMT_F
            ( P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_REPRE_NUM         IN VARCHAR2 
            ) RETURN NUMBER;
            
  FUNCTION GET_2013_ADD_CREDIT_AMT_F
            ( P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_REPRE_NUM         IN VARCHAR2 
            ) RETURN NUMBER;            
                        

/*======================================================================/
     ++ 룩업 : 부양가족 사항.
/======================================================================*/
  PROCEDURE LU_SUPPORT_FAMILY
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

/*======================================================================/
     ++ 룩업 : 의료비 명세서 부양가족 사항.
/======================================================================*/
  PROCEDURE LU_SUPPORT_FAMILY_MEDIC
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );


/*======================================================================/
     ++ 룩업 : 가족 사항.
/======================================================================*/  
  PROCEDURE LU_FAMILY
            ( P_CURSOR3         OUT TYPES.TCURSOR3
            , W_PERSON_ID       IN  NUMBER
            );
            
END HRA_SUPPORT_FAMILY_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_SUPPORT_FAMILY_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_SUPPORT_FAMILY_G
/* Description  : 연말정산 부양가족 관리 패키지
/*
/* Reference by : 
/* Program History : 
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 부양가족 인적사항.
  PROCEDURE SELECT_SUPPORT_FAMILY
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN VARCHAR2
            , P_STD_YYYYMM        IN VARCHAR2         
            , P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
    V_STD_DATE          DATE := LAST_DAY(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'));
  BEGIN
    OPEN P_CURSOR FOR
      SELECT NVL(HSF1.STATUS, 'N') AS STATUS 
          , HRM_COMMON_G.CODE_NAME_F('YEAR_RELATION', '0', PM.SOB_ID, PM.ORG_ID) AS RELATION_NAME
          , PM.NAME AS FAMILY_NAME
          , PM.REPRE_NUM AS REPRE_NUM
          , EAPP_REGISTER_AGE_F(PM.REPRE_NUM, V_STD_DATE, 0) AS AGE
          , NVL(HSF1.BASE_YN, 'Y') AS BASE_YN
          , NVL(HSF1.BASE_LIVING_YN, 'N') AS BASE_LIVING_YN               -- 2013 추가 : 기초수급자 여부 -- 
          , NVL(HSF1.SUPPORT_YN, 'N') AS SUPPORT_YN
          , NVL(HSF1.SPOUSE_YN, 'N') AS SPOUSE_YN
          , NVL(HSF1.OLD_YN, 'N') AS OLD_YN
          , NVL(HSF1.OLD1_YN, 'N') AS OLD1_YN          
          , NVL(HSF1.WOMAN_YN, 'N') AS WOMAN_YN
          , NVL(HSF1.SINGLE_PARENT_DED_YN, 'N') AS SINGLE_PARENT_DED_YN  -- 2013 추가 : 한부모가족 여부 -- 
          , NVL(HSF1.CHILD_YN, 'N') AS CHILD_YN
          , NVL(HSF1.BIRTH_YN, 'N') AS BIRTH_YN
          , NVL(HSF1.DISABILITY_YN, 'N') AS DISABILITY_YN 
          , HSF1.DISABILITY_CODE
          , HSF1.DISABILITY_DESC           
          , NVL(HSF1.EDUCATION_TYPE, TO_CHAR(NULL)) EDUCATION_TYPE
          , NVL(HSF1.EDUCATION_NAME, TO_CHAR(NULL)) EDUCATION_NAME
          , NVL(HSF1.EDUCATION_AMOUNT_LMT, TO_CHAR(NULL)) EDUCATION_AMOUNT_LMT
          , '0' AS YEAR_RELATION_CODE
          , 1 SORT_NUM
          , P_YEAR_YYYY AS YEAR_YYYY
          , PM.PERSON_ID
        FROM HRM_PERSON_MASTER_V PM
          , ( -- 본인정보 체크 
            SELECT 'Y' AS STATUS
                , HSF.PERSON_ID
                , HSF.REPRE_NUM
                , HSF.BASE_YN
                , HSF.SUPPORT_YN
                , HSF.SPOUSE_YN
                , HSF.OLD_YN
                , HSF.OLD1_YN
                , HSF.DISABILITY_YN
                , HSF.DISABILITY_CODE
                , HRM_COMMON_G.CODE_NAME_F('YEAR_DISABILITY', HSF.DISABILITY_CODE, HSF.SOB_ID, HSF.ORG_ID) AS DISABILITY_DESC 
                , HSF.WOMAN_YN
                , HSF.SINGLE_PARENT_DED_YN   -- 2013 추가 : 한부모가족 여부 -- 
                , HSF.BASE_LIVING_YN         -- 2013 추가 : 기초수급자 여부 -- 
                , HSF.CHILD_YN
                , HSF.BIRTH_YN
                , NVL(HSF.EDUCATION_TYPE, TO_CHAR(NULL)) EDUCATION_TYPE
                , YEL.EDUCATION_NAME
                , YEL.AMOUNT_LMT AS EDUCATION_AMOUNT_LMT
              FROM HRA_SUPPORT_FAMILY_V HSF
                , HRM_YEAR_EDU_LMT_V YEL
             WHERE HSF.EDUCATION_TYPE     = YEL.EDUCATION_TYPE(+)
               AND HSF.SOB_ID             = YEL.SOB_ID(+)
               AND HSF.YEAR_YYYY          = P_YEAR_YYYY
               AND HSF.PERSON_ID          = P_PERSON_ID
               AND HSF.SOB_ID             = P_SOB_ID 
               AND HSF.RELATION_CODE      = '0'
            ) HSF1
       WHERE PM.PERSON_ID         = HSF1.PERSON_ID(+)
         AND PM.REPRE_NUM         = HSF1.REPRE_NUM(+)
         AND PM.PERSON_ID         = P_PERSON_ID
         AND PM.SOB_ID            = P_SOB_ID 
----------------------------------------------------         
      UNION 
      SELECT NVL(HSF1.STATUS, 'N') AS STATUS 
          , HR.RELATION_NAME AS RELATION_NAME
          , HF.FAMILY_NAME AS FAMILY_NAME
          , HF.REPRE_NUM AS REPRE_NUM
          , EAPP_REGISTER_AGE_F(HF.REPRE_NUM, V_STD_DATE, 0) AS AGE
          , NVL(HSF1.BASE_YN, 'N') BASE_YN
          , NVL(HSF1.BASE_LIVING_YN, 'N') AS BASE_LIVING_YN               -- 2013 추가 : 기초수급자 여부 -- 
          , NVL(HSF1.SUPPORT_YN, 'N') AS SUPPORT_YN
          , NVL(HSF1.SPOUSE_YN, 'N') AS SPOUSE_YN
          , NVL(HSF1.OLD_YN, 'N') AS OLD_YN
          , NVL(HSF1.OLD1_YN, 'N') AS OLD1_YN
          , NVL(HSF1.WOMAN_YN, 'N') AS WOMAN_YN
          , NVL(HSF1.SINGLE_PARENT_DED_YN, 'N') AS SINGLE_PARENT_DED_YN   -- 2013 추가 : 한부모가족 여부 -- 
          , NVL(HSF1.CHILD_YN, 'N') AS CHILD_YN
          , NVL(HSF1.BIRTH_YN, 'N') AS BIRTH_YN 
          , NVL(HSF1.DISABILITY_YN, 'N') AS DISABILITY_YN 
          , HSF1.DISABILITY_CODE
          , HSF1.DISABILITY_DESC           
          , NVL(HSF1.EDUCATION_TYPE, TO_CHAR(NULL)) EDUCATION_TYPE
          , NVL(HSF1.EDUCATION_NAME, TO_CHAR(NULL)) EDUCATION_NAME
          , NVL(HSF1.EDUCATION_AMOUNT_LMT, TO_CHAR(NULL)) EDUCATION_AMOUNT_LMT
          , HR.YEAR_RELATION_CODE AS YEAR_RELATION_CODE
          , 99 SORT_NUM
          , P_YEAR_YYYY AS YEAR_YYYY
          , HF.PERSON_ID            
        FROM HRM_FAMILY_V HF
          , HRM_RELATION_V HR
          , ( --> 연말정산 가족사항  
            SELECT 'Y' AS STATUS
                , HSF.YEAR_YYYY
                , HSF.PERSON_ID
                , HSF.REPRE_NUM
                , HSF.FAMILY_NAME
                , HSF.RELATION_CODE
                , HSF.BASE_YN
                , HSF.SUPPORT_YN
                , HSF.SPOUSE_YN
                , HSF.OLD_YN
                , HSF.OLD1_YN
                , HSF.DISABILITY_YN
                , HSF.DISABILITY_CODE
                , HRM_COMMON_G.CODE_NAME_F('YEAR_DISABILITY', HSF.DISABILITY_CODE, HSF.SOB_ID, HSF.ORG_ID) AS DISABILITY_DESC 
                , HSF.WOMAN_YN
                , HSF.SINGLE_PARENT_DED_YN   -- 한부모가족 여부 -- 
                , HSF.BASE_LIVING_YN         -- 2013 추가 : 기초수급자 여부 -- 
                , HSF.CHILD_YN
                , HSF.BIRTH_YN
                , NVL(HSF.EDUCATION_TYPE, TO_CHAR(NULL)) EDUCATION_TYPE
                , YEL.EDUCATION_NAME
                , YEL.AMOUNT_LMT AS EDUCATION_AMOUNT_LMT
              FROM HRA_SUPPORT_FAMILY_V HSF
                , HRM_YEAR_RELATION_V YRV
                , HRM_YEAR_EDU_LMT_V YEL
            WHERE HSF.RELATION_CODE      = YRV.YEAR_RELATION_CODE(+)
              AND HSF.SOB_ID             = YRV.SOB_ID(+)
              AND HSF.EDUCATION_TYPE     = YEL.EDUCATION_TYPE(+)
              AND HSF.SOB_ID             = YEL.SOB_ID(+)
              AND HSF.YEAR_YYYY          = P_YEAR_YYYY
              AND HSF.SOB_ID             = P_SOB_ID 
            ) HSF1
       WHERE HF.RELATION_ID       = HR.RELATION_ID
         AND HF.PERSON_ID         = HSF1.PERSON_ID(+)
         AND HF.REPRE_NUM         = HSF1.REPRE_NUM(+)
         AND HF.PERSON_ID         = P_PERSON_ID
       ORDER BY SORT_NUM, AGE DESC
       ;  
  END SELECT_SUPPORT_FAMILY;

-- 부양가족 사용금액.
  PROCEDURE SELECT_FAMILY_AMOUNT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , P_YEAR_YYYY         IN VARCHAR2
            , P_STD_YYYYMM        IN VARCHAR2  
            , P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
    V_STD_DATE          DATE := LAST_DAY(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'));
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT  CASE
                WHEN COUNT(SX1.FAMILY_NAME) OVER(PARTITION BY SX1.FAMILY_NAME ORDER BY SX1.SORT_NUM, SX1.AGE DESC, SX1.REPRE_NUM, SX1.FAMILY_NAME, SX1.AMOUNT_TYPE) > 1 THEN NULL
                ELSE SX1.FAMILY_NAME 
              END AS DIS_FAMILY_NAME
            , CASE
                WHEN COUNT(SX1.REPRE_NUM) OVER(PARTITION BY SX1.REPRE_NUM ORDER BY SX1.SORT_NUM, SX1.AGE DESC, SX1.REPRE_NUM, SX1.FAMILY_NAME, SX1.FAMILY_NAME, SX1.AMOUNT_TYPE) > 1 THEN NULL
                ELSE SX1.REPRE_NUM
              END AS DIS_REPRE_NUM
            , SX1.AMOUNT_TYPE
            , SX1.AMOUNT_TYPE_DESC
            , NVL(SX1.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT 
            , NVL(SX1.INSURE_AMT, 0) AS INSURE_AMT
            , NVL(SX1.DISABILITY_INSURE_AMT, 0) AS DISABILITY_INSURE_AMT
            , NVL(SX1.MEDICAL_AMT, 0) AS MEDICAL_AMT
            , NVL(SX1.MEDICAL_NANIM_AMT, 0) AS MEDICAL_NANIM_AMT
            , NVL(SX1.EDU_AMT, 0) AS EDU_AMT
            , NVL(SX1.CREDIT_AMT, 0) AS CREDIT_AMT
            , NVL(SX1.CHECK_CREDIT_AMT, 0) AS CHECK_CREDIT_AMT
            , NVL(SX1.CASH_AMT, 0) AS CASH_AMT
            , NVL(SX1.ACADE_GIRO_AMT, 0) AS ACADE_GIRO_AMT
            , NVL(SX1.TRAD_MARKET_AMT, 0) AS TRAD_MARKET_AMT
            , NVL(SX1.PUBLIC_TRANSIT_AMT, 0) AS PUBLIC_TRANSIT_AMT      -- 2013 추가 : 대중교통비 --  
            , NVL(SX1.CREDIT_ALL_AMT_2013,0) AS CREDIT_ALL_AMT_2013    -- 2013년도 총사용액 -- 
            , NVL(SX1.ADD_CREDIT_AMT_2013,0) AS ADD_CREDIT_AMT_2013    -- 2013년도 추가 공제분 --  
            , NVL(SX1.CREDIT_ALL_AMT_2014,0) AS CREDIT_ALL_AMT_2014    -- 2014년도 총사용액.
            , NVL(SX1.ADD_CREDIT_AMT_2014,0) AS ADD_CREDIT_AMT_2014    -- 2014년도 추가 공제분.
            , NVL(SX1.PRE_CREDIT_ALL_AMT,0) AS PRE_CREDIT_ALL_AMT      -- 전년도 총 사용액 -- 
            , NVL(SX1.PRE_ADD_CREDIT_AMT,0) AS PRE_ADD_CREDIT_AMT      -- 전년도 추가(상반기) 사용액 -- 
            , NVL(SX1.PRE_SEC_CREDIT_AMT,0) AS PRE_SEC_CREDIT_AMT      -- 전년도 하반기 사용액.
            , NVL(SX1.ADD_CREDIT_AMT,0) AS ADD_CREDIT_AMT              -- 당년도 상반기 추가 사용액 -- 
            , NVL(SX1.CREDIT_ALL_AMT,0) AS CREDIT_ALL_AMT              -- 당해년도 총사용액 --  
            , NVL(SX1.DONAT_POLI, 0) AS DONAT_POLI
            , NVL(SX1.DONAT_ALL, 0) AS DONAT_ALL
            , NVL(SX1.DONAT_50P, 0) AS DONAT_50P
            , NVL(SX1.DONAT_30P, 0) AS DONAT_30P
            , NVL(SX1.DONAT_10P, 0) AS DONAT_10P
            , NVL(SX1.DONAT_10P_RELIGION, 0) AS DONAT_10P_RELIGION
            , SX1.YEAR_RELATION_CODE
            , SX1.SORT_NUM
            , SX1.AGE
            , P_YEAR_YYYY AS YEAR_YYYY
            , SX1.FAMILY_NAME AS FAMILY_NAME
            , SX1.REPRE_NUM AS REPRE_NUM
            , SX1.PERSON_ID
        FROM ( SELECT PM.NAME AS FAMILY_NAME
                    , PM.REPRE_NUM AS REPRE_NUM
                    , 1 AS AMOUNT_TYPE
                    , '국세청' AS AMOUNT_TYPE_DESC
                    , NVL(HSF1.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT 
                    , NVL(HSF1.INSURE_AMT, 0) AS INSURE_AMT
                    , NVL(HSF1.DISABILITY_INSURE_AMT, 0) AS DISABILITY_INSURE_AMT
                    , NVL(HSF1.MEDICAL_AMT, 0) AS MEDICAL_AMT
                    , NVL(HSF1.MEDICAL_NANIM_AMT, 0) AS MEDICAL_NANIM_AMT 
                    , NVL(HSF1.EDUCATION_AMT, 0) AS EDU_AMT
                    , NVL(HSF1.CREDIT_AMT, 0) AS CREDIT_AMT
                    , NVL(HSF1.CHECK_CREDIT_AMT, 0) AS CHECK_CREDIT_AMT
                    , NVL(HSF1.CASH_AMT, 0) AS CASH_AMT
                    , NVL(HSF1.ACADE_GIRO_AMT, 0) AS ACADE_GIRO_AMT
                    , NVL(HSF1.TRAD_MARKET_AMT, 0) AS TRAD_MARKET_AMT
                    , NVL(HSF1.PUBLIC_TRANSIT_AMT, 0) AS PUBLIC_TRANSIT_AMT  -- 2013 추가 : 대중교통비 --  
                    , NVL(HSF1.DONAT_POLI, 0) AS DONAT_POLI
                    , NVL(HSF1.DONAT_ALL, 0) AS DONAT_ALL
                    , NVL(HSF1.DONAT_50P, 0) AS DONAT_50P
                    , NVL(HSF1.DONAT_30P, 0) AS DONAT_30P
                    , NVL(HSF1.DONAT_10P, 0) AS DONAT_10P
                    , NVL(HSF1.DONAT_10P_RELIGION, 0) AS DONAT_10P_RELIGION
                    , NVL(HSF1.CREDIT_ALL_AMT_2013,0) AS CREDIT_ALL_AMT_2013    -- 2013년도 총사용액 -- 
                    , NVL(HSF1.ADD_CREDIT_AMT_2013,0) AS ADD_CREDIT_AMT_2013    -- 2013년도 추가 공제분 --  
                    , NVL(HSF1.CREDIT_ALL_AMT_2014,0) AS CREDIT_ALL_AMT_2014    -- 2014년도 총사용액.
                    , NVL(HSF1.ADD_CREDIT_AMT_2014,0) AS ADD_CREDIT_AMT_2014    -- 2014년도 추가 공제분.
                    , NVL(HSF1.PRE_CREDIT_ALL_AMT,0) AS PRE_CREDIT_ALL_AMT      -- 전년도 총 사용액 -- 
                    , NVL(HSF1.PRE_ADD_CREDIT_AMT,0) AS PRE_ADD_CREDIT_AMT      -- 전년도 추가(상반기) 사용액 -- 
                    , NVL(HSF1.PRE_SEC_CREDIT_AMT,0) AS PRE_SEC_CREDIT_AMT      -- 전년도 하반기 사용액.
                    , NVL(HSF1.ADD_CREDIT_AMT,0) AS ADD_CREDIT_AMT              -- 당년도 상반기 추가 사용액 -- 
                    , NVL(HSF1.CREDIT_ALL_AMT,0) AS CREDIT_ALL_AMT              -- 당해년도 총사용액 -- 
                    , NVL(HSF1.ADD_SEC_CREDIT_AMT,0) AS ADD_SEC_CREDIT_AMT      -- 당해년도 하반기 추가 사용액 --  
                    , '0' AS YEAR_RELATION_CODE
                    , 0 AS SORT_NUM
                    , EAPP_REGISTER_AGE_F(PM.REPRE_NUM, V_STD_DATE, 0) AS AGE
                    , PM.PERSON_ID
                  FROM HRM_PERSON_MASTER_V PM
                    , (--> 연말정산 : 본인 비용 - 국세청.
                       SELECT HSF.PERSON_ID
                            , HSF.REPRE_NUM
                            , NVL(HSF.MEDIC_INSUR_AMT, 0) + NVL(HSF.HIRE_INSUR_AMT, 0) AS MEDIC_INSUR_AMT 
                            , HSF.INSURE_AMT
                            , HSF.DISABILITY_INSURE_AMT
                            , HSF.MEDICAL_AMT
                            , HSF.MEDICAL_NANIM_AMT 
                            , HSF.EDUCATION_AMT
                            , HSF.CREDIT_AMT
                            , HSF.CHECK_CREDIT_AMT
                            , HSF.ACADE_GIRO_AMT
                            , HSF.CASH_AMT
                            , HSF.TRAD_MARKET_AMT
                            , HSF.PUBLIC_TRANSIT_AMT  -- 2013 추가 : 대중교통비 --  
                            , HSF.DONAT_POLI
                            , HSF.DONAT_ALL
                            , HSF.DONAT_50P
                            , HSF.DONAT_30P
                            , HSF.DONAT_10P
                            , HSF.DONAT_10P_RELIGION
                            , HSF.CREDIT_ALL_AMT_2013    -- 2013년도 총사용액 -- 
                            , HSF.ADD_CREDIT_AMT_2013    -- 2013년도 추가 공제분 --  
                            , HSF.CREDIT_ALL_AMT_2014    -- 2014년도 총사용액.
                            , HSF.ADD_CREDIT_AMT_2014    -- 2014년도 추가 공제분.
                            , HSF.PRE_CREDIT_ALL_AMT     -- 전년도 총 사용액 -- 
                            , HSF.PRE_ADD_CREDIT_AMT     -- 전년도 추가(상반기) 사용액 -- 
                            , HSF.PRE_SEC_CREDIT_AMT     -- 전년도 하반기 사용액.
                            , HSF.ADD_CREDIT_AMT         -- 당년도 상반기 추가 사용액 -- 
                            , HSF.CREDIT_ALL_AMT         -- 당해년도 총사용액 -- 
                            , HSF.ADD_SEC_CREDIT_AMT     -- 당해년도 하반기 추가 사용액 -- 
                            , NVL(HSF.EDUCATION_TYPE, TO_CHAR(NULL)) EDUCATION_TYPE
                            , YEL.EDUCATION_NAME
                          FROM HRA_SUPPORT_FAMILY_V HSF
                            , HRM_YEAR_EDU_LMT_V YEL
                         WHERE HSF.EDUCATION_TYPE     = YEL.EDUCATION_TYPE(+)
                           AND HSF.SOB_ID             = YEL.SOB_ID(+)
                           AND HSF.YEAR_YYYY          = P_YEAR_YYYY
                           AND HSF.PERSON_ID          = P_PERSON_ID
                           AND HSF.SOB_ID             = P_SOB_ID
                           AND HSF.RELATION_CODE      = '0'
                         ) HSF1
                   WHERE PM.PERSON_ID         = HSF1.PERSON_ID(+)
                     AND PM.REPRE_NUM         = HSF1.REPRE_NUM(+)
                     AND PM.PERSON_ID         = P_PERSON_ID
                     AND PM.SOB_ID            = P_SOB_ID
                   --------------------------------------------------------------
                   UNION
                   SELECT PM.NAME AS FAMILY_NAME
                      , PM.REPRE_NUM AS REPRE_NUM
                      , 2 AS AMOUNT_TYPE
                      , '그 외' AS AMOUNT_TYPE_DESC
                      , HSF1.MEDIC_INSUR_AMT AS MEDIC_INSUR_AMT                                   
                      , HSF1.INSURE_AMT AS INSURE_AMT
                      , HSF1.DISABILITY_INSURE_AMT AS DISABILITY_INSURE_AMT
                      , HSF1.MEDICAL_AMT AS MEDICAL_AMT
                      , HSF1.MEDICAL_NANIM_AMT AS MEDICAL_NANIM_AMT 
                      , HSF1.EDUCATION_AMT AS EDU_AMT
                      , HSF1.CREDIT_AMT AS CREDIT_AMT
                      , HSF1.CHECK_CREDIT_AMT AS CHECK_CREDIT_AMT
                      , HSF1.CASH_AMT AS CASH_AMT
                      , HSF1.ACADE_GIRO_AMT AS ACADE_GIRO_AMT
                      , HSF1.TRAD_MARKET_AMT AS TRAD_MARKET_AMT
                      , HSF1.PUBLIC_TRANSIT_AMT AS PUBLIC_TRANSIT_AMT  -- 2013 추가 : 대중교통비 --  
                      , HSF1.DONAT_POLI AS DONAT_POLI
                      , HSF1.DONAT_ALL AS DONAT_ALL
                      , HSF1.DONAT_50P AS DONAT_50P
                      , HSF1.DONAT_30P AS DONAT_30P
                      , HSF1.DONAT_10P AS DONAT_10P
                      , HSF1.DONAT_10P_RELIGION AS DONAT_10P_RELIGION
                      , TO_NUMBER(NULL) AS CREDIT_ALL_AMT_2013    -- 2013년도 총사용액 -- 
                      , TO_NUMBER(NULL) AS ADD_CREDIT_AMT_2013    -- 2013년도 추가 공제분 --  
                      , TO_NUMBER(NULL) AS CREDIT_ALL_AMT_2014    -- 2014년도 총사용액.
                      , TO_NUMBER(NULL) AS ADD_CREDIT_AMT_2014    -- 2014년도 추가 공제분.
                      , TO_NUMBER(NULL) AS PRE_CREDIT_ALL_AMT      -- 전년도 총 사용액 -- 
                      , TO_NUMBER(NULL) AS PRE_ADD_CREDIT_AMT      -- 전년도 추가(상반기) 사용액 -- 
                      , TO_NUMBER(NULL) AS PRE_SEC_CREDIT_AMT      -- 전년도 하반기 사용액.
                      , TO_NUMBER(NULL) AS ADD_CREDIT_AMT          -- 당년도 상반기 추가 사용액 -- 
                      , TO_NUMBER(NULL) AS CREDIT_ALL_AMT          -- 당해년도 총사용액 -- 
                      , TO_NUMBER(NULL) AS ADD_SEC_CREDIT_AMT      -- 당해년도 하반기 추가 사용액 --  
                      , '0' AS YEAR_RELATION_CODE
                      , 1 AS SORT_NUM
                      , EAPP_REGISTER_AGE_F(PM.REPRE_NUM, V_STD_DATE, 0) AS AGE
                      , PM.PERSON_ID
                    FROM HRM_PERSON_MASTER_V PM
                      , (--> 연말정산 : 본인 비용 - 기타.
                         SELECT HSF.PERSON_ID
                            , HSF.REPRE_NUM
                            , NVL(HSF.ETC_MEDIC_INSUR_AMT, 0) + NVL(HSF.ETC_HIRE_INSUR_AMT, 0) AS MEDIC_INSUR_AMT  
                            , HSF.ETC_INSURE_AMT AS INSURE_AMT
                            , HSF.ETC_DISABILITY_INSURE_AMT AS DISABILITY_INSURE_AMT
                            , HSF.ETC_MEDICAL_AMT AS MEDICAL_AMT
                            , HSF.ETC_MEDICAL_NANIM_AMT AS MEDICAL_NANIM_AMT 
                            , HSF.ETC_EDUCATION_AMT AS EDUCATION_AMT
                            , HSF.ETC_CREDIT_AMT AS CREDIT_AMT
                            , HSF.ETC_CHECK_CREDIT_AMT AS CHECK_CREDIT_AMT
                            , HSF.ETC_ACADE_GIRO_AMT AS ACADE_GIRO_AMT
                            , HSF.ETC_CASH_AMT AS CASH_AMT
                            , HSF.ETC_TRAD_MARKET_AMT AS TRAD_MARKET_AMT
                            , HSF.ETC_PUBLIC_TRANSIT_AMT AS PUBLIC_TRANSIT_AMT  -- 2013 추가 : 대중교통비 --  
                            , HSF.ETC_DONAT_POLI AS DONAT_POLI
                            , HSF.ETC_DONAT_ALL AS DONAT_ALL
                            , HSF.ETC_DONAT_50P AS DONAT_50P
                            , HSF.ETC_DONAT_30P AS DONAT_30P
                            , HSF.ETC_DONAT_10P AS DONAT_10P
                            , HSF.ETC_DONAT_10P_RELIGION AS DONAT_10P_RELIGION
                            , HSF.ETC_PRE_CREDIT_ALL_AMT AS PRE_CREDIT_ALL_AMT
                            , HSF.ETC_PRE_ADD_CREDIT_AMT AS PRE_ADD_CREDIT_AMT
                            , HSF.ETC_ADD_CREDIT_AMT AS ADD_CREDIT_AMT 
                            , /*NVL(HSF.EDUCATION_TYPE, TO_CHAR(NULL))*/ NULL AS EDUCATION_TYPE
                            , /*YEL.EDUCATION_NAME*/ NULL AS EDUCATION_NAME
                          FROM HRA_SUPPORT_FAMILY_V HSF
                            /*, HRM_YEAR_EDU_LMT_V YEL*/
                         WHERE /*HSF.EDUCATION_TYPE     = YEL.EDUCATION_TYPE(+)
                           AND HSF.SOB_ID             = YEL.SOB_ID(+)
                           AND */HSF.YEAR_YYYY        = P_YEAR_YYYY
                           AND HSF.PERSON_ID          = P_PERSON_ID
                           AND HSF.SOB_ID             = P_SOB_ID
                           AND HSF.RELATION_CODE      = '0'
                        ) HSF1
                   WHERE PM.PERSON_ID         = HSF1.PERSON_ID(+)
                     AND PM.REPRE_NUM         = HSF1.REPRE_NUM(+)
                     AND PM.PERSON_ID         = P_PERSON_ID
                     AND PM.SOB_ID            = P_SOB_ID
                  ----------------------------------------------------
                  UNION
                  --> 연말정산 : 부양가족 비용 - 국세청.  
                  SELECT HF.FAMILY_NAME AS FAMILY_NAME
                      , HF.REPRE_NUM AS REPRE_NUM
                      , 1 AS AMOUNT_TYPE
                      , '국세청' AS AMOUNT_TYPE_DESC
                      , 0 AS MEDIC_INSUR_AMT   
                      , HSF1.INSURE_AMT AS INSURE_AMT
                      , HSF1.DISABILITY_INSURE_AMT AS DISABILITY_INSURE_AMT
                      , HSF1.MEDICAL_AMT AS MEDICAL_AMT
                      , HSF1.MEDICAL_NANIM_AMT AS MEDICAL_NANIM_AMT 
                      , HSF1.EDUCATION_AMT AS EDU_AMT
                      , HSF1.CREDIT_AMT AS CREDIT_AMT
                      , HSF1.CHECK_CREDIT_AMT AS CHECK_CREDIT_AMT
                      , HSF1.CASH_AMT AS CASH_AMT
                      , HSF1.ACADE_GIRO_AMT AS ACADE_GIRO_AMT
                      , HSF1.TRAD_MARKET_AMT AS TRAD_MARKET_AMT
                      , HSF1.PUBLIC_TRANSIT_AMT AS PUBLIC_TRANSIT_AMT  -- 2013 추가 : 대중교통비 --  
                      , HSF1.DONAT_POLI AS DONAT_POLI
                      , HSF1.DONAT_ALL AS DONAT_ALL
                      , HSF1.DONAT_50P AS DONAT_50P
                      , HSF1.DONAT_30P AS DONAT_30P
                      , HSF1.DONAT_10P AS DONAT_10P
                      , HSF1.DONAT_10P_RELIGION AS DONAT_10P_RELIGION
                      , TO_NUMBER(NULL) AS CREDIT_ALL_AMT_2013    -- 2013년도 총사용액 -- 
                      , TO_NUMBER(NULL) AS ADD_CREDIT_AMT_2013    -- 2013년도 추가 공제분 --  
                      , TO_NUMBER(NULL) AS CREDIT_ALL_AMT_2014    -- 2014년도 총사용액.
                      , TO_NUMBER(NULL) AS ADD_CREDIT_AMT_2014    -- 2014년도 추가 공제분.
                      , TO_NUMBER(NULL) AS PRE_CREDIT_ALL_AMT      -- 전년도 총 사용액 -- 
                      , TO_NUMBER(NULL) AS PRE_ADD_CREDIT_AMT      -- 전년도 추가(상반기) 사용액 -- 
                      , TO_NUMBER(NULL) AS PRE_SEC_CREDIT_AMT      -- 전년도 하반기 사용액.
                      , TO_NUMBER(NULL) AS ADD_CREDIT_AMT          -- 당년도 상반기 추가 사용액 -- 
                      , TO_NUMBER(NULL) AS CREDIT_ALL_AMT          -- 당해년도 총사용액 -- 
                      , TO_NUMBER(NULL) AS ADD_SEC_CREDIT_AMT      -- 당해년도 하반기 추가 사용액 --  
                      , HR.YEAR_RELATION_CODE AS YEAR_RELATION_CODE
                      , 99 AS SORT_NUM
                      , EAPP_REGISTER_AGE_F(HF.REPRE_NUM, V_STD_DATE, 0) AS AGE
                      , HF.PERSON_ID            
                    FROM HRM_FAMILY_V HF
                      , HRM_RELATION_V HR
                      , (SELECT HSF.PERSON_ID
                            , HSF.REPRE_NUM
                            , HSF.INSURE_AMT
                            , HSF.DISABILITY_INSURE_AMT
                            , HSF.MEDICAL_AMT 
                            , HSF.MEDICAL_NANIM_AMT 
                            , HSF.EDUCATION_AMT
                            , HSF.CREDIT_AMT
                            , HSF.CHECK_CREDIT_AMT
                            , HSF.ACADE_GIRO_AMT
                            , HSF.CASH_AMT
                            , HSF.TRAD_MARKET_AMT
                            , HSF.PUBLIC_TRANSIT_AMT AS PUBLIC_TRANSIT_AMT  -- 2013 추가 : 대중교통비 --  
                            , HSF.DONAT_POLI
                            , HSF.DONAT_ALL
                            , HSF.DONAT_50P
                            , HSF.DONAT_30P
                            , HSF.DONAT_10P
                            , HSF.DONAT_10P_RELIGION
                            , HSF.PRE_CREDIT_ALL_AMT
                            , HSF.PRE_ADD_CREDIT_AMT 
                            , HSF.ADD_CREDIT_AMT 
                            , NVL(HSF.EDUCATION_TYPE, TO_CHAR(NULL)) EDUCATION_TYPE
                            , YEL.EDUCATION_NAME
                          FROM HRA_SUPPORT_FAMILY_V HSF
                            , HRM_YEAR_EDU_LMT_V YEL
                        WHERE HSF.EDUCATION_TYPE     = YEL.EDUCATION_TYPE(+)
                          AND HSF.SOB_ID             = YEL.SOB_ID(+)
                          AND HSF.YEAR_YYYY          = P_YEAR_YYYY
                          AND HSF.PERSON_ID          = P_PERSON_ID
                          AND HSF.SOB_ID             = P_SOB_ID
                        ) HSF1
                   WHERE HF.RELATION_ID       = HR.RELATION_ID
                     AND HF.PERSON_ID         = HSF1.PERSON_ID(+)
                     AND HF.REPRE_NUM         = HSF1.REPRE_NUM(+)
                     AND HF.PERSON_ID         = P_PERSON_ID
            ----------------------------------------------------
                  UNION
                  --> 연말정산 : 부양가족 비용 - 기타.
                  SELECT HF.FAMILY_NAME AS FAMILY_NAME
                      , HF.REPRE_NUM AS REPRE_NUM
                      , 2 AS AMOUNT_TYPE
                      , '그 외' AS AMOUNT_TYPE_DESC 
                      , 0 AS MEDIC_INSUR_AMT  
                      , HSF1.INSURE_AMT AS INSURE_AMT
                      , HSF1.DISABILITY_INSURE_AMT AS DISABILITY_INSURE_AMT
                      , HSF1.MEDICAL_AMT AS MEDICAL_AMT 
                      , HSF1.MEDICAL_NANIM_AMT AS MEDICAL_NANIM_AMT 
                      , HSF1.EDUCATION_AMT AS EDU_AMT
                      , HSF1.CREDIT_AMT AS CREDIT_AMT
                      , HSF1.CHECK_CREDIT_AMT AS CHECK_CREDIT_AMT
                      , HSF1.CASH_AMT AS CASH_AMT
                      , HSF1.ACADE_GIRO_AMT AS ACADE_GIRO_AMT
                      , HSF1.TRAD_MARKET_AMT AS TRAD_MARKET_AMT
                      , HSF1.PUBLIC_TRANSIT_AMT AS PUBLIC_TRANSIT_AMT  -- 2013 추가 : 대중교통비 --  
                      , HSF1.DONAT_POLI AS DONAT_POLI
                      , HSF1.DONAT_ALL AS DONAT_ALL
                      , HSF1.DONAT_50P AS DONAT_50P
                      , HSF1.DONAT_30P AS DONAT_30P
                      , HSF1.DONAT_10P AS DONAT_10P
                      , HSF1.DONAT_10P_RELIGION AS DONAT_10P_RELIGION
                      , TO_NUMBER(NULL) AS CREDIT_ALL_AMT_2013    -- 2013년도 총사용액 -- 
                      , TO_NUMBER(NULL) AS ADD_CREDIT_AMT_2013    -- 2013년도 추가 공제분 --  
                      , TO_NUMBER(NULL) AS CREDIT_ALL_AMT_2014    -- 2014년도 총사용액.
                      , TO_NUMBER(NULL) AS ADD_CREDIT_AMT_2014    -- 2014년도 추가 공제분.
                      , TO_NUMBER(NULL) AS PRE_CREDIT_ALL_AMT      -- 전년도 총 사용액 -- 
                      , TO_NUMBER(NULL) AS PRE_ADD_CREDIT_AMT      -- 전년도 추가(상반기) 사용액 -- 
                      , TO_NUMBER(NULL) AS PRE_SEC_CREDIT_AMT      -- 전년도 하반기 사용액.
                      , TO_NUMBER(NULL) AS ADD_CREDIT_AMT          -- 당년도 상반기 추가 사용액 -- 
                      , TO_NUMBER(NULL) AS CREDIT_ALL_AMT          -- 당해년도 총사용액 -- 
                      , TO_NUMBER(NULL) AS ADD_SEC_CREDIT_AMT      -- 당해년도 하반기 추가 사용액 --  
                      , HR.YEAR_RELATION_CODE AS YEAR_RELATION_CODE
                      , 99 AS SORT_NUM
                      , EAPP_REGISTER_AGE_F(HF.REPRE_NUM, V_STD_DATE, 0) AS AGE
                      , HF.PERSON_ID            
                    FROM HRM_FAMILY_V HF
                      , HRM_RELATION_V HR
                      , (SELECT HSF.PERSON_ID
                            , HSF.REPRE_NUM
                            , HSF.ETC_INSURE_AMT AS INSURE_AMT
                            , HSF.ETC_DISABILITY_INSURE_AMT AS DISABILITY_INSURE_AMT
                            , HSF.ETC_MEDICAL_AMT AS MEDICAL_AMT
                            , HSF.ETC_MEDICAL_NANIM_AMT AS MEDICAL_NANIM_AMT 
                            , HSF.ETC_EDUCATION_AMT AS EDUCATION_AMT
                            , HSF.ETC_CREDIT_AMT AS CREDIT_AMT
                            , HSF.ETC_CHECK_CREDIT_AMT AS CHECK_CREDIT_AMT
                            , HSF.ETC_ACADE_GIRO_AMT AS ACADE_GIRO_AMT
                            , HSF.ETC_CASH_AMT AS CASH_AMT
                            , HSF.ETC_TRAD_MARKET_AMT AS TRAD_MARKET_AMT
                            , HSF.ETC_PUBLIC_TRANSIT_AMT AS PUBLIC_TRANSIT_AMT  -- 2013 추가 : 대중교통비 --  
                            , HSF.ETC_DONAT_POLI AS DONAT_POLI
                            , HSF.ETC_DONAT_ALL AS DONAT_ALL
                            , HSF.ETC_DONAT_50P AS DONAT_50P
                            , HSF.ETC_DONAT_30P AS DONAT_30P
                            , HSF.ETC_DONAT_10P AS DONAT_10P
                            , HSF.ETC_DONAT_10P_RELIGION AS DONAT_10P_RELIGION
                            , HSF.ETC_PRE_CREDIT_ALL_AMT AS PRE_CREDIT_ALL_AMT
                            , HSF.ETC_PRE_ADD_CREDIT_AMT AS PRE_ADD_CREDIT_AMT
                            , HSF.ETC_ADD_CREDIT_AMT AS ADD_CREDIT_AMT                             
                            , /*NVL(HSF.EDUCATION_TYPE, TO_CHAR(NULL))*/ NULL AS EDUCATION_TYPE
                            , /*YEL.EDUCATION_NAME*/ NULL AS EDUCATION_NAME
                          FROM HRA_SUPPORT_FAMILY_V HSF
                            /*, HRM_YEAR_EDU_LMT_V YEL*/
                        WHERE /*HSF.EDUCATION_TYPE     = YEL.EDUCATION_TYPE(+)
                          AND HSF.SOB_ID             = YEL.SOB_ID(+)
                          AND */HSF.YEAR_YYYY        = P_YEAR_YYYY
                          AND HSF.PERSON_ID          = P_PERSON_ID
                          AND HSF.SOB_ID             = P_SOB_ID
                        ) HSF1
                 WHERE HF.RELATION_ID       = HR.RELATION_ID
                   AND HF.PERSON_ID         = HSF1.PERSON_ID(+)
                   AND HF.REPRE_NUM         = HSF1.REPRE_NUM(+)
                   AND HF.PERSON_ID         = P_PERSON_ID
                -- 합계 --
                UNION
                ---------- 
                SELECT ' '  AS FAMILY_NAME
                    , ' ' AS REPRE_NUM
                    , 99 AS AMOUNT_TYPE
                    , '합계' AS AMOUNT_TYPE_DESC
                    , HSF1.MEDIC_INSUR_AMT AS MEDIC_INSUR_AMT   
                    , HSF1.INSURE_AMT AS INSURE_AMT
                    , HSF1.DISABILITY_INSURE_AMT AS DISABILITY_INSURE_AMT
                    , HSF1.MEDICAL_AMT AS MEDICAL_AMT
                    , HSF1.MEDICAL_NANIM_AMT AS MEDICAL_NANIM_AMT 
                    , HSF1.EDUCATION_AMT AS EDU_AMT
                    , HSF1.CREDIT_AMT AS CREDIT_AMT
                    , HSF1.CHECK_CREDIT_AMT AS CHECK_CREDIT_AMT
                    , HSF1.CASH_AMT AS CASH_AMT
                    , HSF1.ACADE_GIRO_AMT AS ACADE_GIRO_AMT
                    , HSF1.TRAD_MARKET_AMT AS TRAD_MARKET_AMT
                    , HSF1.PUBLIC_TRANSIT_AMT AS PUBLIC_TRANSIT_AMT  -- 2013 추가 : 대중교통비 --  
                    , HSF1.DONAT_POLI AS DONAT_POLI
                    , HSF1.DONAT_ALL AS DONAT_ALL
                    , HSF1.DONAT_50P AS DONAT_50P
                    , HSF1.DONAT_30P AS DONAT_30P
                    , HSF1.DONAT_10P AS DONAT_10P
                    , HSF1.DONAT_10P_RELIGION AS DONAT_10P_RELIGION
                    , NVL(HSF1.CREDIT_ALL_AMT_2013,0) AS CREDIT_ALL_AMT_2013    -- 2013년도 총사용액 -- 
                    , NVL(HSF1.ADD_CREDIT_AMT_2013,0) AS ADD_CREDIT_AMT_2013    -- 2013년도 추가 공제분 --  
                    , NVL(HSF1.CREDIT_ALL_AMT_2014,0) AS CREDIT_ALL_AMT_2014    -- 2014년도 총사용액.
                    , NVL(HSF1.ADD_CREDIT_AMT_2014,0) AS ADD_CREDIT_AMT_2014    -- 2014년도 추가 공제분.
                    , NVL(HSF1.PRE_CREDIT_ALL_AMT,0) AS PRE_CREDIT_ALL_AMT      -- 전년도 총 사용액 -- 
                    , NVL(HSF1.PRE_ADD_CREDIT_AMT,0) AS PRE_ADD_CREDIT_AMT      -- 전년도 추가(상반기) 사용액 -- 
                    , NVL(HSF1.PRE_SEC_CREDIT_AMT,0) AS PRE_SEC_CREDIT_AMT      -- 전년도 하반기 사용액.
                    , NVL(HSF1.ADD_CREDIT_AMT,0) AS ADD_CREDIT_AMT              -- 당년도 상반기 추가 사용액 -- 
                    , NVL(HSF1.CREDIT_ALL_AMT,0) AS CREDIT_ALL_AMT              -- 당해년도 총사용액 -- 
                    , NVL(HSF1.ADD_SEC_CREDIT_AMT,0) AS ADD_SEC_CREDIT_AMT      -- 당해년도 하반기 추가 사용액 --  
                    , ' ' AS YEAR_RELATION_CODE
                    , 999 AS SORT_NUM
                    , 0 AS AGE
                    , PM.PERSON_ID
                  FROM HRM_PERSON_MASTER_V PM
                    , (--> 연말정산 : 본인 및 부양가족 합계 비용.
                       SELECT HSF.PERSON_ID
                          , SUM(NVL(HSF.MEDIC_INSUR_AMT, 0) + NVL(HSF.HIRE_INSUR_AMT, 0) + 
                                NVL(HSF.ETC_MEDIC_INSUR_AMT, 0) + NVL(HSF.ETC_HIRE_INSUR_AMT, 0)) AS MEDIC_INSUR_AMT   
                          , SUM(NVL(HSF.INSURE_AMT , 0) + NVL(HSF.ETC_INSURE_AMT, 0)) AS INSURE_AMT
                          , SUM(NVL(HSF.DISABILITY_INSURE_AMT , 0) + NVL(HSF.ETC_DISABILITY_INSURE_AMT, 0)) AS DISABILITY_INSURE_AMT
                          , SUM(NVL(HSF.MEDICAL_AMT , 0) + NVL(HSF.ETC_MEDICAL_AMT, 0)) AS MEDICAL_AMT
                          , SUM(NVL(HSF.MEDICAL_NANIM_AMT,0) + NVL(HSF.ETC_MEDICAL_NANIM_AMT,0)) AS MEDICAL_NANIM_AMT
                          , SUM(NVL(HSF.EDUCATION_AMT , 0) + NVL(HSF.ETC_EDUCATION_AMT, 0)) AS EDUCATION_AMT
                          , SUM(NVL(HSF.CREDIT_AMT , 0) + NVL(HSF.ETC_CREDIT_AMT, 0)) AS CREDIT_AMT
                          , SUM(NVL(HSF.CHECK_CREDIT_AMT , 0) + NVL(HSF.ETC_CHECK_CREDIT_AMT, 0)) AS CHECK_CREDIT_AMT
                          , SUM(NVL(HSF.ACADE_GIRO_AMT , 0) + NVL(HSF.ETC_ACADE_GIRO_AMT, 0)) AS ACADE_GIRO_AMT
                          , SUM(NVL(HSF.CASH_AMT , 0) + NVL(HSF.ETC_CASH_AMT, 0)) AS CASH_AMT
                          , SUM(NVL(HSF.TRAD_MARKET_AMT , 0) + NVL(HSF.ETC_TRAD_MARKET_AMT, 0)) AS TRAD_MARKET_AMT
                          , SUM(NVL(HSF.PUBLIC_TRANSIT_AMT , 0) + NVL(HSF.ETC_PUBLIC_TRANSIT_AMT, 0)) AS PUBLIC_TRANSIT_AMT  -- 2013 추가 : 대중교통비 --  
                          , SUM(NVL(HSF.DONAT_POLI , 0) + NVL(HSF.ETC_DONAT_POLI, 0)) AS DONAT_POLI
                          , SUM(NVL(HSF.DONAT_ALL , 0) + NVL(HSF.ETC_DONAT_ALL, 0)) AS DONAT_ALL
                          , SUM(NVL(HSF.DONAT_50P , 0) + NVL(HSF.ETC_DONAT_50P, 0)) AS DONAT_50P
                          , SUM(NVL(HSF.DONAT_30P , 0) + NVL(HSF.ETC_DONAT_30P, 0)) AS DONAT_30P
                          , SUM(NVL(HSF.DONAT_10P , 0) + NVL(HSF.ETC_DONAT_10P, 0)) AS DONAT_10P
                          , SUM(NVL(HSF.DONAT_10P_RELIGION , 0) + NVL(HSF.ETC_DONAT_10P_RELIGION, 0)) AS DONAT_10P_RELIGION
                          , SUM(DECODE(HSF.RELATION_CODE, '0', NVL(HSF.CREDIT_ALL_AMT_2013, 0), 0)) AS CREDIT_ALL_AMT_2013    -- 2013년도 총사용액 -- 
                          , SUM(DECODE(HSF.RELATION_CODE, '0', NVL(HSF.ADD_CREDIT_AMT_2013, 0), 0)) AS ADD_CREDIT_AMT_2013    -- 2013년도 총 사용액 -- 
                          , SUM(DECODE(HSF.RELATION_CODE, '0', NVL(HSF.CREDIT_ALL_AMT_2014, 0), 0)) AS CREDIT_ALL_AMT_2014    -- 2014년도 총사용액 -- 
                          , SUM(DECODE(HSF.RELATION_CODE, '0', NVL(HSF.ADD_CREDIT_AMT_2014, 0), 0)) AS ADD_CREDIT_AMT_2014    -- 2014년도 총 사용액 -- 
                          , SUM(DECODE(HSF.RELATION_CODE, '0', NVL(HSF.PRE_CREDIT_ALL_AMT, 0), 0)) AS PRE_CREDIT_ALL_AMT      -- 전년도 총 사용액 -- 
                          , SUM(DECODE(HSF.RELATION_CODE, '0', NVL(HSF.PRE_ADD_CREDIT_AMT, 0), 0)) AS PRE_ADD_CREDIT_AMT      -- 전년도 상반기 공제분 --  
                          , SUM(DECODE(HSF.RELATION_CODE, '0', NVL(HSF.PRE_SEC_CREDIT_AMT, 0), 0)) AS PRE_SEC_CREDIT_AMT      -- 전년도 하반기 공제분 --  
                          , SUM(DECODE(HSF.RELATION_CODE, '0', NVL(HSF.ADD_CREDIT_AMT, 0), 0)) AS ADD_CREDIT_AMT              -- 당년도 상반기 추가 사용액 -- 
                          , SUM(DECODE(HSF.RELATION_CODE, '0', NVL(HSF.CREDIT_ALL_AMT, 0), 0)) AS CREDIT_ALL_AMT              -- 당해년도 총사용액 -- 
                          , SUM(DECODE(HSF.RELATION_CODE, '0', NVL(HSF.ADD_SEC_CREDIT_AMT, 0), 0)) AS ADD_SEC_CREDIT_AMT      -- 당해년도 하반기 추가 사용액 --  
                        FROM HRA_SUPPORT_FAMILY_V HSF
                       WHERE HSF.YEAR_YYYY          = P_YEAR_YYYY
                         AND HSF.PERSON_ID          = P_PERSON_ID
                         AND HSF.SOB_ID             = P_SOB_ID 
                       GROUP BY HSF.PERSON_ID
                      ) HSF1
                 WHERE PM.PERSON_ID         = HSF1.PERSON_ID(+)
                   AND PM.PERSON_ID         = P_PERSON_ID
                   AND PM.SOB_ID            = P_SOB_ID 
            ) SX1
      ORDER BY SX1.SORT_NUM, SX1.AGE DESC, SX1.FAMILY_NAME, SX1.AMOUNT_TYPE
      ;
  END SELECT_FAMILY_AMOUNT;

    
  /*======================================================================/
       ++ 연말정산 부양가족 관계 생성.
  /======================================================================*/
  PROCEDURE CREATE_SUPPORT_FAMILY
            ( P_YEAR_YYYY         IN VARCHAR2
            , P_STD_YYYYMM        IN VARCHAR2 
            , P_CORP_ID           IN NUMBER
            , P_YEAR_EMPLOYE_TYPE IN VARCHAR2 DEFAULT NULL 
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE        DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_LAST_DATE      DATE;  -- 연말일자 --
    V_RECORD_COUNT   NUMBER;
    
    V_PRE_YEAR_YYYY        VARCHAR2(4);         -- 전년도 -- 
    V_START_DATE     DATE;
    V_END_DATE       DATE;
    
    V_ENROLL_COUNT   NUMBER;
    V_UNENROLL_COUNT NUMBER;
  
    V_ERR_MSG VARCHAR2(300);
    
    V_REPRE_NUM_FLAG       VARCHAR2(2) := 'N';  -- 주민번호 검증 -- 
    V_BIRTHDAY             DATE;  -- 생일 
    V_ANCESTOR_MAN_AGE     NUMBER;
    V_ANCESTOR_WOMAN_AGE   NUMBER;
    V_DESCENDANT_MAN_AGE   NUMBER;
    V_DESCENDANT_WOMAN_AGE NUMBER;
    V_OLD_DED_AGE          NUMBER;
    V_OLD_DED_AGE1         NUMBER;
    V_CHILDREN_DED_AGE     NUMBER;
    V_BIRTH_DED_AGE        NUMBER;       
  BEGIN
    --> 초기화.
    O_STATUS := 'F';
    V_ENROLL_COUNT   := 0;
    V_UNENROLL_COUNT := 0;
    V_ERR_MSG        := NULL;

    V_START_DATE := TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'MONTH');
    V_END_DATE   := LAST_DAY(V_START_DATE);
    V_LAST_DATE := TO_DATE(P_YEAR_YYYY || '-12-31', 'YYYY-MM-DD');
    V_PRE_YEAR_YYYY := TO_CHAR(ADD_MONTHS(V_LAST_DATE, -12), 'YYYY');
                       
    --> 기준정보 조회;
    BEGIN
      SELECT HIT.ANCESTOR_MAN_AGE,
             HIT.ANCESTOR_WOMAN_AGE,
             HIT.DESCENDANT_MAN_AGE,
             HIT.DESCENDANT_WOMAN_AGE,
             HIT.OLD_DED_AGE,
             HIT.OLD_DED_AGE1,
             HIT.CHILDREN_DED_AGE,
             HIT.BIRTH_DED_AGE
        INTO V_ANCESTOR_MAN_AGE,
             V_ANCESTOR_WOMAN_AGE,
             V_DESCENDANT_MAN_AGE,
             V_DESCENDANT_WOMAN_AGE,
             V_OLD_DED_AGE,
             V_OLD_DED_AGE1,
             V_CHILDREN_DED_AGE,
             V_BIRTH_DED_AGE
        FROM HRA_INCOME_TAX_STANDARD HIT
       WHERE HIT.YEAR_YYYY        = P_YEAR_YYYY
         AND HIT.SOB_ID           = P_SOB_ID 
         ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10236', '&&VALUE:=Year adjustment standard data');
      RETURN;
    END;
  
----> 본인자료 및 부양가족 내역 생성              
    FOR C1 IN ( SELECT HPM.PERSON_ID
                     , HPM.PERSON_NUM
                     , HPM.NAME
                     , HPM.REPRE_NUM
                     , CASE
                         WHEN SUBSTR(HPM.REPRE_NUM, 8, 1) IN('1', '3', '5', '7') THEN '1'
                         ELSE '2'
                       END AS SEX_CODE
                     , '0' AS YEAR_RELATION_CODE  -- 본인 --
                     , HPM.SOB_ID
                     , HPM.ORG_ID
                     , DECODE(HB.DISABLED_ID, NULL, 'N', 'Y') AS DISABILITY_YN
                     , NVL(HPM.HOUSEHOLD_TYPE, 'N') AS HOUSEHOLD_TYPE  -- 세대주여부.
                     
                     , NVL(( SELECT SF.DISABILITY_CODE
                               FROM HRA_SUPPORT_FAMILY_V SF
                              WHERE SF.YEAR_YYYY      = V_PRE_YEAR_YYYY
                                AND SF.SOB_ID         = HPM.SOB_ID
                                AND SF.PERSON_ID      = HPM.PERSON_ID
                                AND SF.REPRE_NUM      = HPM.REPRE_NUM
                                AND SF.RELATION_CODE  = '0'
                           ), NULL) AS OWN_DISABILITY_CODE             -- 장애인 코드  
                  FROM HRM_PERSON_MASTER_V HPM
                     , HRM_BODY            HB
                WHERE HPM.PERSON_ID           = HB.PERSON_ID(+)
                  AND HPM.CORP_ID             = P_CORP_ID
                  AND ((P_PERSON_ID           IS NULL AND 1 = 1)
                  OR   (P_PERSON_ID           IS NOT NULL AND HPM.PERSON_ID = P_PERSON_ID))
                  AND HPM.SOB_ID              = P_SOB_ID
                  AND HPM.JOIN_DATE           <= V_END_DATE
                  AND (HPM.RETIRE_DATE IS NULL OR HPM.RETIRE_DATE >= V_START_DATE)
                  
                  AND ((P_YEAR_EMPLOYE_TYPE   IS NULL AND 1 = 1)
                    OR (P_YEAR_EMPLOYE_TYPE   != '20' AND (HPM.RETIRE_DATE > V_END_DATE OR HPM.RETIRE_DATE IS NULL))
                    OR (P_YEAR_EMPLOYE_TYPE   = '20' AND (HPM.RETIRE_DATE BETWEEN V_START_DATE AND V_END_DATE)))
                    
                  AND NOT EXISTS
                        ( SELECT 'X'
                            FROM HRA_YEAR_ADJUSTMENT YA
                           WHERE YA.PERSON_ID   = HPM.PERSON_ID
                           
                             AND YA.YEAR_YYYY   = P_YEAR_YYYY
                             AND YA.CLOSED_FLAG = 'Y'
                        )
              )
    LOOP    
      IF HRA_YEAR_ADJUST_SET_G.GET_ADJUST_CLOSED_FLAG_F
          ( P_YEAR_YYYY         => P_YEAR_YYYY 
          , P_PERSON_ID         => C1.PERSON_ID
          , P_SOB_ID            => C1.SOB_ID 
          , P_ORG_ID            => C1.ORG_ID) = 'Y' THEN
        O_STATUS := 'F';
        O_MESSAGE := '해당 자료는 연말정산 계산이 완료/마감 되었습니다. 변경할 수 없습니다.';
        RETURN;  
      END IF;
      
      V_ERR_MSG := C1.NAME || '(' || C1.PERSON_NUM || ')';
      IF C1.REPRE_NUM IS NULL THEN
        V_UNENROLL_COUNT := NVL(V_UNENROLL_COUNT, 0) + 1;
      ELSE
        V_ENROLL_COUNT := NVL(V_ENROLL_COUNT, 0) + 1;
      END IF;
      
      ----> 부양가족 내역 삭제(인사-부양가족 삭제->정산-부양가족 삭제).
      DELETE FROM HRA_SUPPORT_FAMILY HSF
      WHERE HSF.YEAR_YYYY        = P_YEAR_YYYY
        AND HSF.PERSON_ID        = C1.PERSON_ID
        AND HSF.SOB_ID           = C1.SOB_ID
        AND HSF.RELATION_CODE    != '0'      
        AND HSF.WEB_INPUT_FLAG   = 'N'        -- WEB 입력이 아닌 자료만 삭제 --   
        AND NOT EXISTS
              ( SELECT 'X'
                  FROM HRM_FAMILY HF
                WHERE HF.PERSON_ID  = HSF.PERSON_ID
                  AND HF.REPRE_NUM  = HSF.REPRE_NUM
              )
      ;

-------> 기존 자료 체크        
      V_RECORD_COUNT := 0;
      BEGIN
        SELECT COUNT(DISTINCT HSF.PERSON_ID) AS COUNT
          INTO V_RECORD_COUNT
          FROM HRA_SUPPORT_FAMILY HSF
        WHERE HSF.YEAR_YYYY       = P_YEAR_YYYY
          AND HSF.PERSON_ID       = C1.PERSON_ID
          AND HSF.RELATION_CODE   = '0'
        ;
      EXCEPTION WHEN OTHERS THEN
        V_RECORD_COUNT := 0;
      END;
      IF V_RECORD_COUNT = 0 THEN
        --> 본인 
        INSERT INTO HRA_SUPPORT_FAMILY
          ( YEAR_YYYY
          , SOB_ID
          , ORG_ID  
          , PERSON_ID
          , REPRE_NUM
          , RELATION_CODE
          , FAMILY_NAME
          , BASE_YN
          , INCOME_DED_YN
          , SPOUSE_YN
          , OLD_YN
          , OLD1_YN
          , DISABILITY_YN
          , WOMAN_YN
          , CHILD_YN
          , BIRTH_YN -- 출생/입양;
          , DISABILITY_CODE
          , CREATION_DATE
          , CREATED_BY
          , LAST_UPDATE_DATE
          , LAST_UPDATED_BY
          ) VALUES
          ( P_YEAR_YYYY
          , P_SOB_ID
          , P_ORG_ID
          , C1.PERSON_ID
          , ENCRYPT_F(C1.REPRE_NUM)
          , C1.YEAR_RELATION_CODE
          , C1.NAME
          , 'Y'                 --BASE_YN
          , 'Y'                 --INCOME_YN
          , 'N'                 --SPOUSE_YN
          , 'N'/*CASE
              WHEN EAPP_REGISTER_AGE_F(C1.REPRE_NUM, V_LAST_DATE, 0) BETWEEN V_OLD_DED_AGE AND V_OLD_DED_AGE1 - 1 THEN 'Y'
              ELSE 'N'
            END*/                 --OLD_YN
          , CASE
              WHEN V_END_DATE < V_LAST_DATE THEN 'N'
              WHEN EAPP_REGISTER_AGE_F(C1.REPRE_NUM, V_LAST_DATE, 0) >= V_OLD_DED_AGE1 THEN 'Y'
              ELSE 'N'
            END                 --OLD1_YN            
          , CASE
              WHEN V_END_DATE < V_LAST_DATE THEN 'N'
              WHEN C1.OWN_DISABILITY_CODE IS NULL THEN 'N' 
              ELSE NVL(C1.DISABILITY_YN, 'N') 
            END   --DEFORM_YN
          , 'N'                 --WOMAN_YN
          , 'N'                 --CHILD_YN
          , 'N'                 --BIRTH_YN
          , CASE
              WHEN V_END_DATE < V_LAST_DATE THEN 'N'
              ELSE C1.OWN_DISABILITY_CODE
            END       -- 장애인 코드  
          , V_SYSDATE
          , P_USER_ID
          , V_SYSDATE
          , P_USER_ID
          );
      ELSE
        UPDATE HRA_SUPPORT_FAMILY SF
           SET SF.FAMILY_NAME         = C1.NAME
             , SF.REPRE_NUM           = ENCRYPT_F(C1.REPRE_NUM)  
         WHERE SF.YEAR_YYYY     = P_YEAR_YYYY
           AND SF.PERSON_ID     = C1.PERSON_ID
           AND SF.RELATION_CODE = '0'
        ;
      END IF;
      -- 신용카드 금액 동기화.
      INIT_PRE_CREDIT_AMOUNT
        ( O_STATUS            => O_STATUS 
        , O_MESSAGE           => O_MESSAGE  
        , P_YEAR_YYYY         => P_YEAR_YYYY 
        , P_OPERATING_UNIT_ID => NULL 
        , P_YEAR_EMPLOYE_TYPE => NULL  
        , P_DEPT_ID           => NULL 
        , P_FLOOR_ID          => NULL 
        , P_PERSON_ID         => C1.PERSON_ID 
        , P_SOB_ID            => P_SOB_ID 
        , P_ORG_ID            => P_ORG_ID   
        );
       
      ----> 부양가족 내역 생성            
      FOR C11 IN (SELECT HF.PERSON_ID
                       , HF.REPRE_NUM
                       , HF.FAMILY_NAME
                       , HR.YEAR_RELATION_CODE
                       , HR.RELATION_CODE
                       , CASE
                           WHEN SUBSTR(REPLACE(HF.REPRE_NUM, '-', ''), 7, 1) IN('1', '3', '5', '7') THEN '1'
                           ELSE '2'
                         END AS SEX_CODE                         
                       , HF.DEFORM_YN   AS DISABILITY_YN
                       , HF.DISABILITY_CODE AS DISABILITY_CODE             -- 장애인 코드 
                  FROM HRM_FAMILY_V HF
                     , HRM_RELATION_V HR
                  WHERE HF.RELATION_ID              = HR.RELATION_ID
                    AND HF.PERSON_ID                = C1.PERSON_ID
                    AND 1                           = CASE
                                                        WHEN V_END_DATE = V_LAST_DATE THEN 1
                                                        ELSE 0
                                                      END
                 )
      LOOP
        V_BIRTHDAY             := NULL;  -- 생일 
-------> 주민번호 체크.
        IF EAPP_NUM_DIGIT_CHECKER_G.CHECK_REPRE_NUM_F(C11.REPRE_NUM) = 'N' THEN
          V_UNENROLL_COUNT := NVL(V_UNENROLL_COUNT, 0) + 1;         
        ELSE
          -- 정산년도 이후 출생자는 제외하기 위해 생년월일 생성 --          
          IF SUBSTR(REPLACE(C11.REPRE_NUM, '-', ''), 7, 1) IN('1', '2', '5', '6') THEN
            V_BIRTHDAY := TO_DATE('19' || SUBSTR(C11.REPRE_NUM, 1, 6), 'YYYYMMDD');
          ELSE
            V_BIRTHDAY := TO_DATE('20' || SUBSTR(C11.REPRE_NUM, 1, 6), 'YYYYMMDD');
          END IF;
          IF V_LAST_DATE < V_BIRTHDAY THEN
            -- 정산년도 이후 출생자는 제외       
            V_UNENROLL_COUNT := NVL(V_UNENROLL_COUNT, 0) + 1;  
          ELSE
            V_ENROLL_COUNT := V_ENROLL_COUNT + 1;
-------> 기존 자료 체크 
            V_RECORD_COUNT := 0;
            BEGIN
              SELECT COUNT(DISTINCT HSF.PERSON_ID) AS COUNT
                INTO V_RECORD_COUNT
                FROM HRA_SUPPORT_FAMILY_V HSF
              WHERE HSF.YEAR_YYYY     = P_YEAR_YYYY
                AND HSF.PERSON_ID     = C11.PERSON_ID
                AND HSF.REPRE_NUM     = C11.REPRE_NUM
              ;
            EXCEPTION WHEN OTHERS THEN
              V_RECORD_COUNT := 0;
            END;      
            IF V_RECORD_COUNT = 0 THEN
            --> 부양가족 내역(기본공제, 소득공제,부양여부는 동일함;)
              INSERT INTO HRA_SUPPORT_FAMILY
              ( YEAR_YYYY
              , SOB_ID
              , ORG_ID  
              , PERSON_ID
              , REPRE_NUM
              , RELATION_CODE
              , FAMILY_NAME
              , BASE_YN
              , INCOME_DED_YN
              , SPOUSE_YN
              , OLD_YN
              , OLD1_YN
              , DISABILITY_YN
              , WOMAN_YN
              , CHILD_YN
              , BIRTH_YN -- 출생/입양;
              , DISABILITY_CODE
              , CREATION_DATE
              , CREATED_BY
              , LAST_UPDATE_DATE
              , LAST_UPDATED_BY
              ) VALUES
              ( P_YEAR_YYYY
              , P_SOB_ID
              , P_ORG_ID
              , C11.PERSON_ID
              , ENCRYPT_F(C11.REPRE_NUM)
              , C11.YEAR_RELATION_CODE
              , C11.FAMILY_NAME
              , CASE
                  WHEN EAPP_REGISTER_AGE_F(C11.REPRE_NUM, V_LAST_DATE, 0) <= V_DESCENDANT_MAN_AGE AND C11.SEX_CODE = '1' THEN 'Y'
                  WHEN EAPP_REGISTER_AGE_F(C11.REPRE_NUM, V_LAST_DATE, 0) <= V_DESCENDANT_WOMAN_AGE AND C11.SEX_CODE = '2' THEN 'Y'
                  WHEN EAPP_REGISTER_AGE_F(C11.REPRE_NUM, V_LAST_DATE, 0) >= V_ANCESTOR_MAN_AGE AND C11.SEX_CODE = '1' THEN 'Y'
                  WHEN EAPP_REGISTER_AGE_F(C11.REPRE_NUM, V_LAST_DATE, 0) >= V_ANCESTOR_WOMAN_AGE AND C11.SEX_CODE = '2' THEN 'Y'
                  ELSE 'N'
                END                 -- BASE_YN
              , CASE
                  WHEN EAPP_REGISTER_AGE_F(C11.REPRE_NUM, V_LAST_DATE, 0) <= V_DESCENDANT_MAN_AGE AND C11.SEX_CODE = '1' THEN 'Y'
                  WHEN EAPP_REGISTER_AGE_F(C11.REPRE_NUM, V_LAST_DATE, 0) <= V_DESCENDANT_WOMAN_AGE AND C11.SEX_CODE = '2' THEN 'Y'
                  WHEN EAPP_REGISTER_AGE_F(C11.REPRE_NUM, V_LAST_DATE, 0) >= V_ANCESTOR_MAN_AGE AND C11.SEX_CODE = '1' THEN 'Y'
                  WHEN EAPP_REGISTER_AGE_F(C11.REPRE_NUM, V_LAST_DATE, 0) >= V_ANCESTOR_WOMAN_AGE AND C11.SEX_CODE = '2' THEN 'Y'
                  ELSE 'N'
                END                --INCOME_YN
              , 'N'                 --SPOUSE_YN
              , 'N'  /*CASE
                  WHEN EAPP_REGISTER_AGE_F(C11.REPRE_NUM, V_LAST_DATE, 0) BETWEEN V_OLD_DED_AGE AND V_OLD_DED_AGE1 - 1 THEN 'Y'
                  ELSE 'N'
                END*/               --OLD_YN
              , CASE
                  WHEN EAPP_REGISTER_AGE_F(C11.REPRE_NUM, V_LAST_DATE, 0) >= V_OLD_DED_AGE1 THEN 'Y'
                  ELSE 'N'
                END                --OLD1_YN
              , CASE
                  WHEN C11.DISABILITY_CODE IS NULL THEN 'N' 
                  ELSE NVL(C11.DISABILITY_YN, 'N') 
                END                 --DEFORM_YN
              , 'N'                 --WOMAN_YN
              , CASE
                  WHEN EAPP_REGISTER_AGE_F(C11.REPRE_NUM, V_LAST_DATE, 0) <= V_CHILDREN_DED_AGE THEN 'Y'
                  ELSE 'N'
                END                 --CHILD_YN
              , CASE
                  WHEN EAPP_REGISTER_AGE_F(C11.REPRE_NUM, V_LAST_DATE, 0) <= V_BIRTH_DED_AGE THEN 'Y'
                  ELSE 'N'
                END                 --BIRTH_YN(RELATION_CODE = 90 : 위탁아동);
              , C11.DISABILITY_CODE -- DISABILITY_CODE 
              , V_SYSDATE
              , P_USER_ID
              , V_SYSDATE
              , P_USER_ID
              );           
            ELSE
              UPDATE HRA_SUPPORT_FAMILY SF
                 SET SF.RELATION_CODE = C11.YEAR_RELATION_CODE
                   , SF.FAMILY_NAME   = C11.FAMILY_NAME
               WHERE SF.YEAR_YYYY     = P_YEAR_YYYY
                AND SF.PERSON_ID      = C11.PERSON_ID
                AND SF.REPRE_NUM      = ENCRYPT_F(C11.REPRE_NUM)
              ;
            END IF;
          END IF;
        END IF;
      END LOOP;
--------------> 부양가족에 대한 LOOP
      -- 부녀세대 FLAG UPDATE --
      IF C1.SEX_CODE = '2' THEN
        -- 1. 배우자가 있는 여성.
        V_RECORD_COUNT := 0;
        BEGIN
          SELECT COUNT(SF.PERSON_ID) AS RECORD_COUNT
            INTO V_RECORD_COUNT
            FROM HRA_SUPPORT_FAMILY SF
           WHERE SF.YEAR_YYYY     = P_YEAR_YYYY
             AND SF.SOB_ID        = C1.SOB_ID
             AND SF.PERSON_ID     = C1.PERSON_ID
             AND SF.RELATION_CODE = '3'
          ;
        EXCEPTION WHEN OTHERS THEN
          V_RECORD_COUNT := 0;
        END;
        IF V_RECORD_COUNT > 0 THEN
          UPDATE HRA_SUPPORT_FAMILY SF
             SET SF.WOMAN_YN        = 'Y'
           WHERE SF.YEAR_YYYY     = P_YEAR_YYYY
             AND SF.SOB_ID        = C1.SOB_ID
             AND SF.PERSON_ID     = C1.PERSON_ID
             AND SF.RELATION_CODE = '0'
          ;
        END IF;
        
        -- 2. 부양가족이 있는 세대주.
        BEGIN
          SELECT COUNT(SF.PERSON_ID) AS RECORD_COUNT
            INTO V_RECORD_COUNT
            FROM HRA_SUPPORT_FAMILY SF
           WHERE SF.YEAR_YYYY     = P_YEAR_YYYY
             AND SF.SOB_ID        = C1.SOB_ID
             AND SF.PERSON_ID     = C1.PERSON_ID
             AND SF.RELATION_CODE NOT IN('0', '3')
          ;
        EXCEPTION WHEN OTHERS THEN
          V_RECORD_COUNT := 0;
        END;
        IF V_RECORD_COUNT > 0 AND C1.HOUSEHOLD_TYPE = '1' THEN
          UPDATE HRA_SUPPORT_FAMILY SF
             SET SF.WOMAN_YN        = 'Y'
           WHERE SF.YEAR_YYYY     = P_YEAR_YYYY
             AND SF.SOB_ID        = C1.SOB_ID
             AND SF.PERSON_ID     = C1.PERSON_ID
             AND SF.RELATION_CODE = '0'
          ;
        END IF;
      END IF;   
    END LOOP;
-----------> 개인 대한 LOOP
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10237'
                   , '&&COUNT1:=' || TO_CHAR(V_UNENROLL_COUNT, 'FM999,999') || '&&COUNT2:=' ||TO_CHAR(V_ENROLL_COUNT, 'FM999,999,999')); 
  EXCEPTION WHEN OTHERS THEN
    O_STATUS := 'F';
    O_MESSAGE := 'Support Faimly Enroll Error(부양가족 등록 오류) : (' || SUBSTR(SQLERRM, 1, 200) || ')';
  END CREATE_SUPPORT_FAMILY;

-- 삭제 : 부양가족 인적사항.
  PROCEDURE DELETE_SUPPORT_FAMILY
            ( W_PERSON_ID  IN  HRA_SUPPORT_FAMILY.PERSON_ID%TYPE
            , W_REPRE_NUM  IN  HRA_SUPPORT_FAMILY.REPRE_NUM%TYPE
            , W_SOB_ID     IN  HRA_SUPPORT_FAMILY.SOB_ID%TYPE
            , W_ORG_ID     IN  HRA_SUPPORT_FAMILY.ORG_ID%TYPE
            , W_YEAR_YYYY  IN  HRA_SUPPORT_FAMILY.YEAR_YYYY%TYPE
            )
  AS
    V_RELATION_CODE         VARCHAR2(10);
  BEGIN
    IF HRA_YEAR_ADJUST_SET_G.GET_ADJUST_CLOSED_FLAG_F
        ( P_YEAR_YYYY         => W_YEAR_YYYY 
        , P_PERSON_ID         => W_PERSON_ID
        , P_SOB_ID            => W_SOB_ID 
        , P_ORG_ID            => W_ORG_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, '해당 자료는 연말정산 계산이 완료/마감 되었습니다. 변경할 수 없습니다.');
      RETURN;  
    END IF;
    
    -- 본인 삭제 안되게 제어 -- 
    BEGIN
      SELECT SF.RELATION_CODE
        INTO V_RELATION_CODE
        FROM HRA_SUPPORT_FAMILY SF
      WHERE SF.SOB_ID     =  W_SOB_ID
        AND SF.PERSON_ID  =  W_PERSON_ID
        AND SF.REPRE_NUM  =  ENCRYPT_F(W_REPRE_NUM)
        AND SF.YEAR_YYYY  =  W_YEAR_YYYY
        ;
    EXCEPTION
      WHEN OTHERS THEN
        V_RELATION_CODE := '-';
    END;
    IF V_RELATION_CODE = '0' THEN
      RAISE_APPLICATION_ERROR(-20001, '부양가족내역의 본인자료는 삭제 할 수 없습니다. 확인하세요');
      RETURN; 
    END IF;
    
    DELETE HRA_SUPPORT_FAMILY
    WHERE SOB_ID     =  W_SOB_ID
      AND PERSON_ID  =  W_PERSON_ID
      AND REPRE_NUM  =  ENCRYPT_F(W_REPRE_NUM)
      AND YEAR_YYYY  =  W_YEAR_YYYY
    ;
  END DELETE_SUPPORT_FAMILY;

-- 동기화 부양가족 기본공제 체크시 추가공제 동기화 리턴 
  PROCEDURE INIT_SUPPORT_FAMILY_YN_P
            ( W_PERSON_ID                       IN  HRA_SUPPORT_FAMILY.PERSON_ID%TYPE
            , W_REPRE_NUM                       IN  HRA_SUPPORT_FAMILY.REPRE_NUM%TYPE
            , W_SOB_ID                          IN  HRA_SUPPORT_FAMILY.SOB_ID%TYPE
            , W_ORG_ID                          IN  HRA_SUPPORT_FAMILY.ORG_ID%TYPE
            , W_YEAR_YYYY                       IN  HRA_SUPPORT_FAMILY.YEAR_YYYY%TYPE
            , W_YEAR_RELATION_CODE              IN  HRA_SUPPORT_FAMILY.RELATION_CODE%TYPE
            , W_BASE_YN                         IN  HRA_SUPPORT_FAMILY.BASE_YN%TYPE
            , O_SPOUSE_YN                       OUT HRA_SUPPORT_FAMILY.SPOUSE_YN%TYPE
            , O_OLD_YN                          OUT HRA_SUPPORT_FAMILY.OLD_YN%TYPE
            , O_OLD1_YN                         OUT HRA_SUPPORT_FAMILY.OLD1_YN%TYPE
            , O_CHILD_YN                        OUT HRA_SUPPORT_FAMILY.CHILD_YN%TYPE
            , O_BIRTH_YN                        OUT HRA_SUPPORT_FAMILY.BIRTH_YN%TYPE
            )
  AS
    V_LAST_DATE      DATE;  -- 연말일자 --
    
    V_ANCESTOR_MAN_AGE     NUMBER;
    V_ANCESTOR_WOMAN_AGE   NUMBER;
    V_DESCENDANT_MAN_AGE   NUMBER;
    V_DESCENDANT_WOMAN_AGE NUMBER;
    V_OLD_DED_AGE          NUMBER;
    V_OLD_DED_AGE1         NUMBER;
    V_CHILDREN_DED_AGE     NUMBER;
    V_BIRTH_DED_AGE        NUMBER;    
  BEGIN
    --> 초기화.
    V_LAST_DATE := TO_DATE(W_YEAR_YYYY || '-12-31', 'YYYY-MM-DD');
    
    O_SPOUSE_YN := 'N'; 
    O_OLD_YN := 'N';       
    O_OLD1_YN := 'N';     
    O_CHILD_YN := 'N';   
    O_BIRTH_YN := 'N'; 
     
    --> 기준정보 조회;
    BEGIN
      SELECT HIT.ANCESTOR_MAN_AGE,
             HIT.ANCESTOR_WOMAN_AGE,
             HIT.DESCENDANT_MAN_AGE,
             HIT.DESCENDANT_WOMAN_AGE,
             HIT.OLD_DED_AGE,
             HIT.OLD_DED_AGE1,
             HIT.CHILDREN_DED_AGE,
             HIT.BIRTH_DED_AGE
        INTO V_ANCESTOR_MAN_AGE,
             V_ANCESTOR_WOMAN_AGE,
             V_DESCENDANT_MAN_AGE,
             V_DESCENDANT_WOMAN_AGE,
             V_OLD_DED_AGE,
             V_OLD_DED_AGE1,
             V_CHILDREN_DED_AGE,
             V_BIRTH_DED_AGE
        FROM HRA_INCOME_TAX_STANDARD HIT
       WHERE HIT.YEAR_YYYY        = W_YEAR_YYYY
         AND HIT.SOB_ID           = W_SOB_ID
         ;
    EXCEPTION WHEN OTHERS THEN
      V_ANCESTOR_MAN_AGE := 100000;
      V_ANCESTOR_WOMAN_AGE  := 100000;
      V_DESCENDANT_MAN_AGE  := 100000;
      V_DESCENDANT_WOMAN_AGE  := 100000; 
      V_OLD_DED_AGE  := 100000;
      V_OLD_DED_AGE1  := 100000;
      V_CHILDREN_DED_AGE := 100000;
      V_BIRTH_DED_AGE  := 100000;
    END;
    
    -- 배우자 공제 
    IF W_BASE_YN = 'Y' AND W_YEAR_RELATION_CODE = '3' THEN
      O_SPOUSE_YN := 'Y';
    ELSE
      O_SPOUSE_YN := 'N';
    END IF;
    
   /* -- 경로우대1 -- 
    IF W_BASE_YN = 'Y' THEN
      O_OLD_YN := 'N';  -- 사용안함 
    END IF;*/
    
    -- 경로우대2 -- 
    IF W_BASE_YN = 'Y' THEN
      IF EAPP_REGISTER_AGE_F(W_REPRE_NUM, V_LAST_DATE, 0) >= V_OLD_DED_AGE1 THEN 
        O_OLD1_YN := 'Y';  
      ELSE
        O_OLD1_YN := 'N';  
      END IF; 
    END IF;
    
    -- 자녀양육 -- 
    IF W_BASE_YN = 'Y' THEN
      IF EAPP_REGISTER_AGE_F(W_REPRE_NUM, V_LAST_DATE, 0) <= V_CHILDREN_DED_AGE THEN 
        O_CHILD_YN := 'Y';  
      ELSE
        O_CHILD_YN := 'N';  
      END IF; 
    END IF;
    
    -- 출생 -- 
    IF W_BASE_YN = 'Y' THEN
      IF EAPP_REGISTER_AGE_F(W_REPRE_NUM, V_LAST_DATE, 0) <= V_BIRTH_DED_AGE THEN 
        O_BIRTH_YN := 'Y';  
      ELSE
        O_BIRTH_YN := 'N';  
      END IF; 
    END IF;           
  END INIT_SUPPORT_FAMILY_YN_P;
  
  
-- 검증 : 부양가족 인적사항 대상여부 체크.
  PROCEDURE CHECK_SUPPORT_FAMILY_P
            ( W_PERSON_ID                       IN  HRA_SUPPORT_FAMILY.PERSON_ID%TYPE
            , W_REPRE_NUM                       IN  HRA_SUPPORT_FAMILY.REPRE_NUM%TYPE
            , W_SOB_ID                          IN  HRA_SUPPORT_FAMILY.SOB_ID%TYPE
            , W_ORG_ID                          IN  HRA_SUPPORT_FAMILY.ORG_ID%TYPE
            , W_YEAR_YYYY                       IN  HRA_SUPPORT_FAMILY.YEAR_YYYY%TYPE
            , P_YEAR_RELATION_CODE              IN  HRA_SUPPORT_FAMILY.RELATION_CODE%TYPE
            , P_BASE_YN                         IN  HRA_SUPPORT_FAMILY.BASE_YN%TYPE
            , P_BASE_LIVING_YN                  IN  HRA_SUPPORT_FAMILY.BASE_LIVING_YN%TYPE 
            , P_SPOUSE_YN                       IN  HRA_SUPPORT_FAMILY.SPOUSE_YN%TYPE
            , P_OLD_YN                          IN  HRA_SUPPORT_FAMILY.OLD_YN%TYPE
            , P_OLD1_YN                         IN  HRA_SUPPORT_FAMILY.OLD1_YN%TYPE
            , P_WOMAN_YN                        IN  HRA_SUPPORT_FAMILY.WOMAN_YN%TYPE 
            , P_SINGLE_PARENT_DED_YN            IN  HRA_SUPPORT_FAMILY.SINGLE_PARENT_DED_YN%TYPE 
            , P_CHILD_YN                        IN  HRA_SUPPORT_FAMILY.CHILD_YN%TYPE
            , P_BIRTH_YN                        IN  HRA_SUPPORT_FAMILY.BIRTH_YN%TYPE
            , P_DISABILITY_YN                   IN  HRA_SUPPORT_FAMILY.DISABILITY_YN%TYPE 
            , P_DISABILITY_CODE                 IN  HRA_SUPPORT_FAMILY.DISABILITY_CODE%TYPE 
            , O_STATUS                          OUT VARCHAR2
            , O_MESSAGE                         OUT VARCHAR2
            )
  AS
    V_RECORD_COUNT         NUMBER; 
    V_RESIDENT_TYPE        VARCHAR2(3);  -- 거주구분 --
    V_AGE                  NUMBER := 0;
    V_ANCESTOR_MAN_AGE     NUMBER;
    V_ANCESTOR_WOMAN_AGE   NUMBER;
    V_DESCENDANT_MAN_AGE   NUMBER;
    V_DESCENDANT_WOMAN_AGE NUMBER;
    V_OLD_DED_AGE          NUMBER;
    V_OLD_DED_AGE1         NUMBER;
    V_CHILDREN_DED_AGE     NUMBER;
    V_BIRTH_DED_AGE        NUMBER;
    V_SEX_CODE             VARCHAR2(3);
    
    V_LAST_DATE            DATE;  -- 정산 종료일(해당년도 마지막일자) 
    V_BIRTHDAY             DATE;  -- 출생년월일.
    
    V_BASE_YN              VARCHAR2(2) := 'N';
    V_SPOUSE_YN            VARCHAR2(2) := 'N';
    V_OLD_YN               VARCHAR2(2) := 'N';
    V_OLD1_YN              VARCHAR2(2) := 'N';
    V_DISABILITY_YN        VARCHAR2(2) := 'N';
    V_CHILD_YN             VARCHAR2(2) := 'N';
    V_BIRTH_YN             VARCHAR2(2) := 'N';
  BEGIN
    O_STATUS := 'F';
    V_LAST_DATE := TO_DATE(W_YEAR_YYYY || '-12-31', 'YYYY-MM-DD');
    
    --> 기준정보 조회;
    BEGIN
      SELECT HIT.ANCESTOR_MAN_AGE,
             HIT.ANCESTOR_WOMAN_AGE,
             HIT.DESCENDANT_MAN_AGE,
             HIT.DESCENDANT_WOMAN_AGE,
             HIT.OLD_DED_AGE,
             HIT.OLD_DED_AGE1,
             HIT.CHILDREN_DED_AGE,
             HIT.BIRTH_DED_AGE
        INTO V_ANCESTOR_MAN_AGE,
             V_ANCESTOR_WOMAN_AGE,
             V_DESCENDANT_MAN_AGE,
             V_DESCENDANT_WOMAN_AGE,
             V_OLD_DED_AGE,
             V_OLD_DED_AGE1,
             V_CHILDREN_DED_AGE,
             V_BIRTH_DED_AGE
        FROM HRA_INCOME_TAX_STANDARD HIT
       WHERE HIT.YEAR_YYYY        = W_YEAR_YYYY
         AND HIT.SOB_ID           = W_SOB_ID
         ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10236', '&&VALUE:=Year adjustment standard data');
      RETURN;
    END;

-------> 주민번호 체크.        
    V_BIRTHDAY := NULL;  -- 생일 
    IF EAPP_NUM_DIGIT_CHECKER_G.CHECK_REPRE_NUM_F(W_REPRE_NUM) = 'N' THEN
      O_MESSAGE := '부양가족의 주민번호(' || SUBSTR(W_REPRE_NUM, 1, 6) || ')가 잘못되었습니다. 주민번호를 확인하세요';
      RETURN;     
    ELSE
      -- 정산년도 이후 출생자는 제외하기 위해 생년월일 생성 --          
      IF SUBSTR(REPLACE(W_REPRE_NUM, '-', ''), 7, 1) IN('1', '2', '5', '6') THEN
        V_BIRTHDAY := TO_DATE('19' || SUBSTR(W_REPRE_NUM, 1, 6), 'YYYYMMDD');
      ELSE
        V_BIRTHDAY := TO_DATE('20' || SUBSTR(W_REPRE_NUM, 1, 6), 'YYYYMMDD');
      END IF;
      IF V_LAST_DATE < V_BIRTHDAY THEN
      -- 정산년도 이후 출생자는 기본공제 및 기타 공제항목 체크 불가 -- 
        IF NVL(P_BASE_YN, 'N') = 'Y' OR NVL(P_CHILD_YN, 'N') = 'Y' OR NVL(P_BIRTH_YN, 'N') = 'Y' OR NVL(P_DISABILITY_YN, 'N') = 'Y' THEN 
          O_MESSAGE := '부양가족의 주민번호(' || SUBSTR(W_REPRE_NUM, 1, 6) || ')는 정산년도 이후 출생자이므로 공제 신청을 할 수 없습니다.' || CHR(10) ||
                       '기본공제등 공제신청 내용을 선택해제 하시기 바랍니다.';
          RETURN;     
        END IF;
      END IF;
    END IF;
                 
    --> 근로자 본인이 아니면 관계코드 0 등록 불가 --
    BEGIN
      SELECT 'Y' AS BASE_YN 
        INTO V_BASE_YN
        FROM HRM_PERSON_MASTER  PM
       WHERE PM.PERSON_ID       = W_PERSON_ID
         AND PM.SOB_ID          = W_SOB_ID
         AND PM.REPRE_NUM       = ENCRYPT_F(W_REPRE_NUM)
      ;
    EXCEPTION WHEN OTHERS THEN
      V_BASE_YN := 'N'; 
    END;
    IF V_BASE_YN = 'N' AND P_YEAR_RELATION_CODE = '0' THEN
      O_MESSAGE := '0.근로자 본인이 아니면 관계코드는 본인을 선택할 수 없습니다.' || CHR(10) || LPAD(' ', 17, ' ') || '관계코드를 확인하세요.';
      RETURN;  
    END IF;
    IF P_BASE_YN = 'N' AND P_YEAR_RELATION_CODE = '0' THEN
      O_MESSAGE := '근로자 본인은 기본공제를 해제할 수 없습니다.' || CHR(10) || LPAD(' ', 17, ' ') || '기본공제를 체크하세요.';
      RETURN;  
    END IF;
    V_BASE_YN := 'N';
    
    --> 인사정보 조회 --
    BEGIN
      SELECT PM.RESIDENT_TYPE
           , NVL((SELECT SF.DISABILITY_YN
                    FROM HRA_SUPPORT_FAMILY SF
                   WHERE SF.YEAR_YYYY     = W_YEAR_YYYY
                     AND SF.SOB_ID        = PM.SOB_ID
                     AND SF.PERSON_ID     = PM.PERSON_ID
                     AND SF.REPRE_NUM     = ENCRYPT_F(W_REPRE_NUM)
                     AND ROWNUM           <= 1   
                 ), NULL) AS DISABILITY_YN
        INTO V_RESIDENT_TYPE
           , V_DISABILITY_YN
        FROM HRM_PERSON_MASTER  PM
       WHERE PM.PERSON_ID       = W_PERSON_ID
         AND PM.SOB_ID          = W_SOB_ID
         AND PM.JOIN_DATE       <= TO_DATE(W_YEAR_YYYY || '-12-31', 'YYYY-MM-DD')
         AND (PM.RETIRE_DATE    >= TO_DATE(W_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') OR PM.RETIRE_DATE IS NULL)
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RESIDENT_TYPE := '-1'; 
    END;
    IF V_RESIDENT_TYPE = '-1' THEN
      O_MESSAGE := '1.사원정보 조회 오류 - 부양가족 내역을 확인할 수 없습니다.' || CHR(10) || LPAD(' ', 17, ' ') || '부양가족을 생성하시기 바랍니다';
      RETURN;  
    END IF;
    
    IF P_DISABILITY_CODE IS NOT NULL THEN
      V_DISABILITY_YN := 'Y';
    ELSE
      BEGIN
        SELECT HF.DEFORM_YN AS DISABILITY_YN
          INTO V_DISABILITY_YN 
          FROM HRM_FAMILY HF
         WHERE HF.PERSON_ID     = W_PERSON_ID
           AND HF.REPRE_NUM     = ENCRYPT_F(W_REPRE_NUM)
           AND ROWNUM           <= 1  
         ; 
      EXCEPTION WHEN OTHERS THEN
        V_DISABILITY_YN := 'N';
      END;
    END IF; 
    
    -- 인적공제 체크 --
    BEGIN
      --> 나이계산 --
      V_AGE := EAPP_REGISTER_AGE_F(W_REPRE_NUM, TO_DATE(W_YEAR_YYYY || '-12-31', 'YYYY-MM-DD'), 0);
    EXCEPTION WHEN OTHERS THEN
      V_AGE := -1;
    END;
    IF V_AGE < 0 THEN
      O_MESSAGE := '주민번호 오류(나이계산 오류)입니다. 주민번호를 확인바랍니다.';
      RETURN;
    END IF;
    
    -- 성별 --
    BEGIN
      IF SUBSTR(W_REPRE_NUM, 8, 1) IN('1', '3', '5', '7') THEN
        V_SEX_CODE := '1';
      ELSE
        V_SEX_CODE := '2';
      END IF;
    EXCEPTION WHEN OTHERS THEN
      V_SEX_CODE := '1';
    END;
    
    -- 기본공제 --
    IF P_YEAR_RELATION_CODE IN('0') AND V_RESIDENT_TYPE != '1' THEN
      -- 비거주자(C7=‘2’)가 기본공제 여(‘1’)일때 본인(관계=‘0’)이 아니면 오류 --
      V_BASE_YN := 'N';
    ELSIF V_DISABILITY_YN = 'Y' THEN
      -- 장애인 나이제한 없음.
      V_BASE_YN := 'Y';
    ELSIF NVL(P_BASE_LIVING_YN, 'N') = 'Y' THEN
      -- 기초생활수급자 : 나이제한 없음  
      V_BASE_YN := 'Y';
    ELSIF P_YEAR_RELATION_CODE IN('0', '3') THEN
      V_BASE_YN := 'Y';
    ELSIF V_AGE <= V_DESCENDANT_MAN_AGE AND V_SEX_CODE = '1' THEN 
      V_BASE_YN := 'Y';
    ELSIF V_AGE <= V_DESCENDANT_WOMAN_AGE AND V_SEX_CODE = '2' THEN 
      V_BASE_YN := 'Y';
    ELSIF V_AGE >= V_ANCESTOR_MAN_AGE AND V_SEX_CODE = '1' THEN 
      V_BASE_YN := 'Y';
    ELSIF V_AGE >= V_ANCESTOR_WOMAN_AGE AND V_SEX_CODE = '2' THEN 
      V_BASE_YN := 'Y';
    ELSE
      V_BASE_YN := 'N';
    END IF;
    IF V_BASE_YN = 'N' AND P_BASE_YN = 'Y' THEN
      O_MESSAGE := '인적공제(기본) 대상자가 아닙니다. 확인바랍니다.';
      RETURN;
    END IF;
        
    -- 추가공제 --
    -- 배우자.
    IF P_YEAR_RELATION_CODE = '3' AND P_SPOUSE_YN = 'Y' THEN
      V_SPOUSE_YN := 'Y'; 
    ELSE
      V_SPOUSE_YN := 'N';
    END IF;
    IF V_SPOUSE_YN = 'N' AND NVL(P_SPOUSE_YN, 'N') = 'Y' THEN
      O_MESSAGE := '배우자 공제 대상자가 아닙니다. 확인바랍니다.';
      RETURN;
    END IF;
    
    -- 경로우대1.
    IF P_YEAR_RELATION_CODE IN('0') AND V_RESIDENT_TYPE != '1' THEN
      -- 비거주자(C7=‘2’)가 기본공제 여(‘1’)일때 본인(관계=‘0’)이 아니면 오류 --
      V_OLD_YN := 'N';
    ELSIF P_BASE_YN != 'Y' THEN
      -- 기본공제 대상자가 아니면 경로우대 X -- 
      V_OLD_YN := 'N';
    ELSIF V_AGE BETWEEN V_OLD_DED_AGE AND V_OLD_DED_AGE1 - 1 THEN
      V_OLD_YN := 'Y'; 
    ELSE
      V_OLD_YN := 'N';
    END IF;
    IF V_OLD_YN = 'N' AND NVL(P_OLD_YN, 'N') = 'Y' THEN
      O_MESSAGE := '추가공제(경로우대) 대상자가 아닙니다. 확인바랍니다.';
      RETURN;
    END IF;
    
    -- 경로우대2.
    IF P_YEAR_RELATION_CODE IN('0') AND V_RESIDENT_TYPE != '1' THEN
      -- 비거주자(C7=‘2’)가 기본공제 여(‘1’)일때 본인(관계=‘0’)이 아니면 오류 --
      V_OLD1_YN := 'N';
    ELSIF P_BASE_YN != 'Y' THEN
      -- 기본공제 대상자가 아니면 경로우대 X -- 
      V_OLD1_YN := 'N';
    ELSIF V_AGE >= V_OLD_DED_AGE1 THEN
      V_OLD1_YN := 'Y'; 
    ELSE
      V_OLD1_YN := 'N';
    END IF;
    IF V_OLD1_YN = 'N' AND NVL(P_OLD1_YN, 'N') = 'Y' THEN
      O_MESSAGE := '추가공제(경로우대) 대상자가 아닙니다. 확인바랍니다.';
      RETURN;
    END IF;
    
    -- 부녀자공제 --
    IF P_YEAR_RELATION_CODE NOT IN('0') AND NVL(P_WOMAN_YN, 'N') = 'Y'  THEN
      -- 비거주자(C7=‘2’)가 기본공제 여(‘1’)일때 본인(관계=‘0’)이 아니면 오류 --
      O_MESSAGE := '부녀자공제는 본인만 해당합니다.';
      RETURN;
    ELSIF V_SEX_CODE = '1' AND NVL(P_WOMAN_YN, 'N') = 'Y' THEN
      O_MESSAGE := '부녀자공제는 남성은 해당되지 않습니다.';
      RETURN;
    END IF;
    
    -- 부녀자 공제 VS 한부모공제 중복 신청시 오류 => 한부모 공제 우선 --
    IF NVL(P_WOMAN_YN, 'N') = 'Y' AND NVL(P_SINGLE_PARENT_DED_YN, 'N') = 'Y' THEN
      O_MESSAGE := '부녀자공제와 한부모가족공제는 중복 신청 할 수 없습니다. 한부모공제를 선택하세요';
      RETURN;
    END IF;
    
    -- 한부모가공제 --
    IF P_YEAR_RELATION_CODE NOT IN('0') AND NVL(P_SINGLE_PARENT_DED_YN, 'N') = 'Y'  THEN
      -- 비거주자(C7=‘2’)가 기본공제 여(‘1’)일때 본인(관계=‘0’)이 아니면 오류 --
      O_MESSAGE := '한부모가족공제는 본인만 해당합니다.';
      RETURN; 
    END IF;
    
    -- 자녀양육비.
    IF P_YEAR_RELATION_CODE IN('0') AND V_RESIDENT_TYPE != '1' THEN
      -- 비거주자(C7=‘2’)가 기본공제 여(‘1’)일때 본인(관계=‘0’)이 아니면 오류 --
      V_CHILD_YN := 'N';
    ELSIF V_AGE <= V_CHILDREN_DED_AGE THEN
      V_CHILD_YN := 'Y'; 
    ELSE
      V_CHILD_YN := 'N';
    END IF;
    IF V_CHILD_YN = 'N' AND NVL(P_CHILD_YN, 'N') = 'Y' THEN
      O_MESSAGE := '추가공제(자녀양육) 대상자가 아닙니다. 확인바랍니다.';
      RETURN;
    END IF;
    
    -- 출산양육.
    IF P_YEAR_RELATION_CODE IN('0') AND V_RESIDENT_TYPE != '1' THEN
      -- 비거주자(C7=‘2’)가 기본공제 여(‘1’)일때 본인(관계=‘0’)이 아니면 오류 --
      V_BIRTH_YN := 'N';
    ELSIF V_AGE <= V_BIRTH_DED_AGE THEN
      V_BIRTH_YN := 'Y'; 
    ELSE
      V_BIRTH_YN := 'N';
    END IF;
    IF V_BIRTH_YN = 'N' AND NVL(P_BIRTH_YN, 'N') = 'Y' THEN
      O_MESSAGE := '추가공제(출산양육) 대상자가 아닙니다. 확인바랍니다.';
      RETURN;
    END IF;
    -- 인적공제 검증 완료 --
    O_STATUS := 'S';
  END CHECK_SUPPORT_FAMILY_P;

-- 웹 시스템 검증 : 부양가족 인적사항 대상여부 체크.
  PROCEDURE WEB_CHECK_SUPPORT_FAMILY_P
            ( W_PERSON_ID                       IN  HRA_SUPPORT_FAMILY.PERSON_ID%TYPE
            , W_REPRE_NUM                       IN  HRA_SUPPORT_FAMILY.REPRE_NUM%TYPE
            , W_SOB_ID                          IN  HRA_SUPPORT_FAMILY.SOB_ID%TYPE
            , W_ORG_ID                          IN  HRA_SUPPORT_FAMILY.ORG_ID%TYPE
            , W_YEAR_YYYY                       IN  HRA_SUPPORT_FAMILY.YEAR_YYYY%TYPE
            , P_FAMILY_RELATION_CODE            IN  VARCHAR2 
            , P_BASE_YN                         IN  HRA_SUPPORT_FAMILY.BASE_YN%TYPE
            , P_BASE_LIVING_YN                  IN  HRA_SUPPORT_FAMILY.BASE_LIVING_YN%TYPE 
            , P_SPOUSE_YN                       IN  HRA_SUPPORT_FAMILY.SPOUSE_YN%TYPE
            , P_OLD_YN                          IN  HRA_SUPPORT_FAMILY.OLD_YN%TYPE
            , P_OLD1_YN                         IN  HRA_SUPPORT_FAMILY.OLD1_YN%TYPE
            , P_WOMAN_YN                        IN  HRA_SUPPORT_FAMILY.WOMAN_YN%TYPE 
            , P_SINGLE_PARENT_DED_YN            IN  HRA_SUPPORT_FAMILY.SINGLE_PARENT_DED_YN%TYPE 
            , P_CHILD_YN                        IN  HRA_SUPPORT_FAMILY.CHILD_YN%TYPE
            , P_BIRTH_YN                        IN  HRA_SUPPORT_FAMILY.BIRTH_YN%TYPE
            , P_DISABILITY_YN                   IN  HRA_SUPPORT_FAMILY.DISABILITY_YN%TYPE 
            , P_DISABILITY_CODE                 IN  HRA_SUPPORT_FAMILY.DISABILITY_CODE%TYPE 
            , O_STATUS                          OUT VARCHAR2
            , O_MESSAGE                         OUT VARCHAR2
            )
  AS
    V_YEAR_RELATION_CODE    HRA_SUPPORT_FAMILY.RELATION_CODE%TYPE;
  BEGIN
    BEGIN
      SELECT HR.YEAR_RELATION_CODE
        INTO V_YEAR_RELATION_CODE 
        FROM HRM_RELATION_V HR
       WHERE HR.RELATION_CODE       = P_FAMILY_RELATION_CODE
         AND HR.SOB_ID              = W_SOB_ID
         AND ROWNUM                 <= 1
       ;
    EXCEPTION
      WHEN OTHERS THEN
        V_YEAR_RELATION_CODE := '-';
    END;
    IF V_YEAR_RELATION_CODE = '-' THEN
      O_MESSAGE := '연말정산 관계코드를 찾을수 없습니다. 확인바랍니다.';
      RETURN;
    END IF;
    
    CHECK_SUPPORT_FAMILY_P
      ( W_PERSON_ID               => W_PERSON_ID 
      , W_REPRE_NUM               => W_REPRE_NUM
      , W_SOB_ID                  => W_SOB_ID
      , W_ORG_ID                  => W_ORG_ID
      , W_YEAR_YYYY               => W_YEAR_YYYY 
      , P_YEAR_RELATION_CODE      => V_YEAR_RELATION_CODE 
      , P_BASE_YN                 => P_BASE_YN 
      , P_BASE_LIVING_YN          => P_BASE_LIVING_YN  
      , P_SPOUSE_YN               => P_SPOUSE_YN 
      , P_OLD_YN                  => P_OLD_YN 
      , P_OLD1_YN                 => P_OLD1_YN 
      , P_WOMAN_YN                => P_WOMAN_YN 
      , P_SINGLE_PARENT_DED_YN    => P_SINGLE_PARENT_DED_YN  
      , P_CHILD_YN                => P_CHILD_YN 
      , P_BIRTH_YN                => P_BIRTH_YN
      , P_DISABILITY_YN           => P_DISABILITY_YN 
      , P_DISABILITY_CODE         => P_DISABILITY_CODE 
      , O_STATUS                  => O_STATUS 
      , O_MESSAGE                 => O_MESSAGE
      );
  END WEB_CHECK_SUPPORT_FAMILY_P;
  
    
-- 수정 : 부양가족 인적사항.
  PROCEDURE UPDATE_SUPPORT_FAMILY
            ( W_PERSON_ID                       IN  HRA_SUPPORT_FAMILY.PERSON_ID%TYPE
            , W_REPRE_NUM                       IN  HRA_SUPPORT_FAMILY.REPRE_NUM%TYPE
            , W_SOB_ID                          IN  HRA_SUPPORT_FAMILY.SOB_ID%TYPE
            , W_ORG_ID                          IN  HRA_SUPPORT_FAMILY.ORG_ID%TYPE
            , W_YEAR_YYYY                       IN  HRA_SUPPORT_FAMILY.YEAR_YYYY%TYPE
            , P_USER_ID                         IN  HRA_SUPPORT_FAMILY.LAST_UPDATED_BY%TYPE
            , P_YEAR_RELATION_CODE              IN  HRA_SUPPORT_FAMILY.RELATION_CODE%TYPE
            , P_FAMILY_NAME                     IN  HRA_SUPPORT_FAMILY.FAMILY_NAME%TYPE
            , P_BASE_YN                         IN  HRA_SUPPORT_FAMILY.BASE_YN%TYPE
            , P_BASE_LIVING_YN                  IN  HRA_SUPPORT_FAMILY.BASE_LIVING_YN%TYPE 
            , P_SUPPORT_YN                      IN  HRA_SUPPORT_FAMILY.SUPPORT_YN%TYPE
            , P_SPOUSE_YN                       IN  HRA_SUPPORT_FAMILY.SPOUSE_YN%TYPE
            , P_OLD_YN                          IN  HRA_SUPPORT_FAMILY.OLD_YN%TYPE
            , P_OLD1_YN                         IN  HRA_SUPPORT_FAMILY.OLD1_YN%TYPE
            , P_DISABILITY_YN                   IN  HRA_SUPPORT_FAMILY.DISABILITY_YN%TYPE 
            , P_DISABILITY_CODE                 IN  HRA_SUPPORT_FAMILY.DISABILITY_CODE%TYPE 
            , P_WOMAN_YN                        IN  HRA_SUPPORT_FAMILY.WOMAN_YN%TYPE
            , P_SINGLE_PARENT_DED_YN            IN  HRA_SUPPORT_FAMILY.SINGLE_PARENT_DED_YN%TYPE 
            , P_CHILD_YN                        IN  HRA_SUPPORT_FAMILY.CHILD_YN%TYPE
            , P_BIRTH_YN                        IN  HRA_SUPPORT_FAMILY.BIRTH_YN%TYPE
            , P_EDUCATION_TYPE                  IN  HRA_SUPPORT_FAMILY.EDUCATION_TYPE%TYPE
            )
  AS
    V_SYSDATE              DATE  := GET_LOCAL_DATE(W_SOB_ID);
    V_AMOUNT               NUMBER := 0;
  BEGIN    
    IF HRA_YEAR_ADJUST_SET_G.GET_ADJUST_CLOSED_FLAG_F
        ( P_YEAR_YYYY         => W_YEAR_YYYY 
        , P_PERSON_ID         => W_PERSON_ID
        , P_SOB_ID            => W_SOB_ID 
        , P_ORG_ID            => W_ORG_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, '해당 자료는 연말정산 계산이 완료/마감 되었습니다. 변경할 수 없습니다.');
      RETURN;  
    END IF;
    
    -- 부녀자공제 및 한부모공제 동시 입력 불가 --
    IF P_WOMAN_YN = 'Y' AND P_SINGLE_PARENT_DED_YN = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, '부녀자 공제와 한부모 공제는 중복 적용될 수 없습니다. 확인하세요');
      RETURN; 
    END IF;
    
    -- 교육비 금액이 등록된 부양가족은 교육비 구분을 null 값으로 처리할 수 없음 -- 
    V_AMOUNT := 0;
    BEGIN
      SELECT NVL(SF.EDUCATION_AMT, 0) + 
             NVL(SF.ETC_EDUCATION_AMT, 0) AS EDUCATION_AMT
        INTO V_AMOUNT
        FROM HRA_SUPPORT_FAMILY SF
       WHERE SF.SOB_ID              =  W_SOB_ID
         AND SF.PERSON_ID           =  W_PERSON_ID
         AND SF.REPRE_NUM           =  ENCRYPT_F(W_REPRE_NUM)
         AND SF.YEAR_YYYY           =  W_YEAR_YYYY
      ;
    EXCEPTION 
      WHEN OTHERS THEN
        V_AMOUNT := 0;
    END;
    IF V_AMOUNT != 0 AND P_EDUCATION_TYPE IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, '교육비 공제금액을 등록한 경우 교육비 구분은 필수항목입니다. 확인하세요');
      RETURN; 
    END IF;
       
    UPDATE HRA_SUPPORT_FAMILY
      SET BASE_YN                     =  CASE
                                           WHEN NVL(P_BASE_LIVING_YN, 'N') = 'Y' THEN 'Y'
                                           ELSE NVL(P_BASE_YN, 'N')
                                         END
        , BASE_LIVING_YN              =  NVL(P_BASE_LIVING_YN, 'N') 
        , SUPPORT_YN                  =  NVL(P_SUPPORT_YN, 'N')
        , SPOUSE_YN                   =  NVL(P_SPOUSE_YN, 'N')
        , OLD_YN                      =  NVL(P_OLD_YN, 'N')
        , OLD1_YN                     =  NVL(P_OLD1_YN, 'N')
        , DISABILITY_YN               =  NVL(P_DISABILITY_YN, 'N') 
        , DISABILITY_CODE             =  P_DISABILITY_CODE
        , WOMAN_YN                    =  NVL(P_WOMAN_YN, 'N')
        , SINGLE_PARENT_DED_YN        =  NVL(P_SINGLE_PARENT_DED_YN, 'N')
        , CHILD_YN                    =  NVL(P_CHILD_YN, 'N')
        , BIRTH_YN                    =  NVL(P_BIRTH_YN, 'N')
        , EDUCATION_TYPE              =  P_EDUCATION_TYPE
        , LAST_UPDATE_DATE            =  V_SYSDATE
        , LAST_UPDATED_BY             =  P_USER_ID
    WHERE SOB_ID                      =  W_SOB_ID
      AND PERSON_ID                   =  W_PERSON_ID
      AND REPRE_NUM                   =  ENCRYPT_F(W_REPRE_NUM)
      AND YEAR_YYYY                   =  W_YEAR_YYYY
    ;
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO HRA_SUPPORT_FAMILY
      ( YEAR_YYYY
      , SOB_ID
      , ORG_ID  
      , PERSON_ID
      , REPRE_NUM
      , RELATION_CODE
      , FAMILY_NAME
      , BASE_YN
      , BASE_LIVING_YN  
      , SPOUSE_YN
      , OLD_YN
      , OLD1_YN
      , DISABILITY_YN
      , DISABILITY_CODE  -- 2013년도 추가 
      , WOMAN_YN
      , SINGLE_PARENT_DED_YN
      , CHILD_YN
      , BIRTH_YN -- 출생/입양;
      , EDUCATION_TYPE
      , CREATION_DATE
      , CREATED_BY
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY
      ) VALUES
      ( W_YEAR_YYYY
      , W_SOB_ID
      , W_ORG_ID
      , W_PERSON_ID
      , ENCRYPT_F(W_REPRE_NUM)
      , P_YEAR_RELATION_CODE
      , P_FAMILY_NAME
      , CASE
          WHEN NVL(P_BASE_LIVING_YN, 'N') = 'Y' THEN 'Y'
          ELSE NVL(P_BASE_YN, 'N')
        END
      , NVL(P_BASE_LIVING_YN, 'N')   
      , NVL(P_SPOUSE_YN, 'N')
      , NVL(P_OLD_YN, 'N')
      , NVL(P_OLD1_YN, 'N')
      , NVL(P_DISABILITY_YN, 'N') 
      , P_DISABILITY_CODE 
      , NVL(P_WOMAN_YN, 'N')
      , NVL(P_SINGLE_PARENT_DED_YN, 'N') 
      , NVL(P_CHILD_YN, 'N')
      , NVL(P_BIRTH_YN, 'N')
      , P_EDUCATION_TYPE
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID
      );
    END IF;
  END UPDATE_SUPPORT_FAMILY;
  
-- 수정 : 부양가족 비용.
  PROCEDURE UPDATE_SUPPORT_AMOUNT
            ( W_PERSON_ID                       IN  HRA_SUPPORT_FAMILY.PERSON_ID%TYPE
            , W_REPRE_NUM                       IN  HRA_SUPPORT_FAMILY.REPRE_NUM%TYPE
            , W_SOB_ID                          IN  HRA_SUPPORT_FAMILY.SOB_ID%TYPE
            , W_ORG_ID                          IN  HRA_SUPPORT_FAMILY.ORG_ID%TYPE
            , W_YEAR_YYYY                       IN  HRA_SUPPORT_FAMILY.YEAR_YYYY%TYPE
            , P_USER_ID                         IN  HRA_SUPPORT_FAMILY.LAST_UPDATED_BY%TYPE
            , P_YEAR_RELATION_CODE              IN  HRA_SUPPORT_FAMILY.RELATION_CODE%TYPE
            , P_FAMILY_NAME                     IN  HRA_SUPPORT_FAMILY.FAMILY_NAME%TYPE
            , P_AMOUNT_TYPE                     IN  VARCHAR2
            , P_MEDIC_INSUR_AMT                 IN  HRA_SUPPORT_FAMILY.MEDIC_INSUR_AMT%TYPE 
            , P_MEDICAL_NANIM_AMT               IN  HRA_SUPPORT_FAMILY.MEDICAL_NANIM_AMT%TYPE 
            , P_INSURE_AMT                      IN  HRA_SUPPORT_FAMILY.INSURE_AMT%TYPE
            , P_DISABILITY_INSURE_AMT           IN  HRA_SUPPORT_FAMILY.DISABILITY_INSURE_AMT%TYPE
            , P_MEDICAL_AMT                     IN  HRA_SUPPORT_FAMILY.MEDICAL_AMT%TYPE
            , P_EDUCATION_AMT                   IN  HRA_SUPPORT_FAMILY.EDUCATION_AMT%TYPE
            , P_CREDIT_AMT                      IN  HRA_SUPPORT_FAMILY.CREDIT_AMT%TYPE
            , P_CHECK_CREDIT_AMT                IN  HRA_SUPPORT_FAMILY.CHECK_CREDIT_AMT%TYPE
            , P_CASH_AMT                        IN  HRA_SUPPORT_FAMILY.CASH_AMT%TYPE
            , P_ACADE_GIRO_AMT                  IN  HRA_SUPPORT_FAMILY.ACADE_GIRO_AMT%TYPE
            , P_TRAD_MARKET_AMT                 IN  HRA_SUPPORT_FAMILY.TRAD_MARKET_AMT%TYPE
            , P_PUBLIC_TRANSIT_AMT              IN  HRA_SUPPORT_FAMILY.PUBLIC_TRANSIT_AMT%TYPE 
            , P_DONAT_ALL                       IN  HRA_SUPPORT_FAMILY.DONAT_ALL%TYPE
            , P_DONAT_50P                       IN  HRA_SUPPORT_FAMILY.DONAT_50P%TYPE
            , P_DONAT_30P                       IN  HRA_SUPPORT_FAMILY.DONAT_30P%TYPE
            , P_DONAT_10P                       IN  HRA_SUPPORT_FAMILY.DONAT_10P%TYPE
            , P_DONAT_10P_RELIGION              IN  HRA_SUPPORT_FAMILY.DONAT_10P_RELIGION%TYPE
            , P_DONAT_POLI                      IN  HRA_SUPPORT_FAMILY.DONAT_POLI%TYPE
            , P_CREDIT_ALL_AMT_2013             IN  NUMBER DEFAULT NULL   -- 2013년 총사용액 
            , P_ADD_CREDIT_AMT_2013             IN  NUMBER DEFAULT NULL   -- 2013년 추가 사용액 
            , P_CREDIT_ALL_AMT_2014             IN  NUMBER DEFAULT NULL   -- 2014년 총사용액.
            , P_ADD_CREDIT_AMT_2014             IN  NUMBER DEFAULT NULL   -- 2014년 추가공제율사용분.
            , P_PRE_CREDIT_ALL_AMT              IN  NUMBER DEFAULT NULL   -- 전년도 총사용액 
            , P_PRE_ADD_CREDIT_AMT              IN  NUMBER DEFAULT NULL   -- 전년도 추가사용액 
            , P_PRE_SEC_CREDIT_AMT              IN  NUMBER DEFAULT NULL   -- 전년도 하반기 사용액.
            , P_ADD_CREDIT_AMT                  IN  NUMBER DEFAULT NULL   -- 당년도 추가사용액(상반기) 
            , P_ADD_SEC_CREDIT_AMT              IN  NUMBER DEFAULT NULL   -- 당년도 추가사용액(하반기) 
            )
  IS
    V_SYSDATE                   DATE  := GET_LOCAL_DATE(W_SOB_ID);
    V_DISABILITY_FLAG           VARCHAR2(2);
    V_EDUCATION_TYPE            HRA_SUPPORT_FAMILY.EDUCATION_TYPE%TYPE;
    V_EDUCATION_AMT_LMT         NUMBER := 0;
  BEGIN
    IF HRA_YEAR_ADJUST_SET_G.GET_ADJUST_CLOSED_FLAG_F
        ( P_YEAR_YYYY         => W_YEAR_YYYY 
        , P_PERSON_ID         => W_PERSON_ID
        , P_SOB_ID            => W_SOB_ID 
        , P_ORG_ID            => W_ORG_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, '해당 자료는 연말정산 계산이 완료/마감 되었습니다. 변경할 수 없습니다.');
      RETURN;  
    END IF;
    
    BEGIN
      SELECT SF.EDUCATION_TYPE AS EDUCATION_TYPE 
           , TO_NUMBER(REPLACE(YEL.AMOUNT_LMT, ',', '')) AS EDUCATION_AMT_LMT  
           , NVL(SF.DISABILITY_YN, 'N') AS DISABILITY_YN   
        INTO V_EDUCATION_TYPE
           , V_EDUCATION_AMT_LMT
           , V_DISABILITY_FLAG
        FROM HRA_SUPPORT_FAMILY SF
          , HRM_YEAR_EDU_LMT_V YEL
      WHERE SF.EDUCATION_TYPE     = YEL.EDUCATION_TYPE(+)
        AND SF.SOB_ID             = YEL.SOB_ID(+)
        AND SF.SOB_ID             =  W_SOB_ID
        AND SF.PERSON_ID          =  W_PERSON_ID
        AND SF.REPRE_NUM          =  ENCRYPT_F(W_REPRE_NUM)
        AND SF.YEAR_YYYY          =  W_YEAR_YYYY
      ;
    EXCEPTION WHEN OTHERS THEN
      V_EDUCATION_TYPE := NULL;
      V_EDUCATION_AMT_LMT := 0;
      V_DISABILITY_FLAG := 'N';
    END;
    IF V_EDUCATION_TYPE IS NULL AND NVL(P_EDUCATION_AMT, 0) <> 0 THEN
      RAISE_APPLICATION_ERROR(-20001, '[교육비 구분]을 선택하지 않고 교육비를 입력했습니다. 확인하세요');
      RETURN; 
    END IF;
    
    -- 본인 이외 건강/고용보험료 입력시 오류 -- 
    IF P_YEAR_RELATION_CODE NOT IN('0') AND 
      (NVL(P_MEDIC_INSUR_AMT, 0)) != 0 THEN
      RAISE_APPLICATION_ERROR(-20001, '본인외에는 건강보험료, 고용보험료를 입력 할 수 없습니다. 확인하세요');
      RETURN; 
    END IF;
    
    -- 본인 이외 전년도 신용카드 금액 입력시 오류 -- 
    IF P_YEAR_RELATION_CODE NOT IN('0') AND 
      (NVL(P_PRE_CREDIT_ALL_AMT, 0) + NVL(P_PRE_ADD_CREDIT_AMT, 0) + NVL(P_ADD_CREDIT_AMT, 0)) != 0 THEN
      RAISE_APPLICATION_ERROR(-20001, '본인외에는 신용카드 추가공제 금액(전년도 사용액)을 입력 할 수 없습니다. 확인하세요');
      RETURN; 
    END IF;
    /*IF NVL(V_EDUCATION_AMT_LMT, 0) < NVL(P_EDUCATION_AMT, 0) THEN
      RAISE_APPLICATION_ERROR(-20001, '[교육비 한도]를 초과했습니다. 확인하세요');
      RETURN; 
    END IF;*/
    
    UPDATE HRA_SUPPORT_FAMILY SF
      SET SF.MEDIC_INSUR_AMT            =  DECODE(P_AMOUNT_TYPE, '1', NVL(P_MEDIC_INSUR_AMT, 0), SF.MEDIC_INSUR_AMT)
        , SF.ETC_MEDIC_INSUR_AMT        =  DECODE(P_AMOUNT_TYPE, '2', NVL(P_MEDIC_INSUR_AMT, 0), SF.ETC_MEDIC_INSUR_AMT)
        , SF.INSURE_AMT                 =  DECODE(P_AMOUNT_TYPE, '1', NVL(P_INSURE_AMT, 0), SF.INSURE_AMT)
        , SF.ETC_INSURE_AMT             =  DECODE(P_AMOUNT_TYPE, '2', NVL(P_INSURE_AMT, 0), SF.ETC_INSURE_AMT)
        , SF.DISABILITY_INSURE_AMT      =  DECODE(P_AMOUNT_TYPE, '1', NVL(P_DISABILITY_INSURE_AMT, 0), SF.DISABILITY_INSURE_AMT)
        , SF.ETC_DISABILITY_INSURE_AMT  =  DECODE(P_AMOUNT_TYPE, '2', NVL(P_DISABILITY_INSURE_AMT, 0), SF.ETC_DISABILITY_INSURE_AMT)
        , SF.MEDICAL_AMT                =  DECODE(P_AMOUNT_TYPE, '1', NVL(P_MEDICAL_AMT, 0), SF.MEDICAL_AMT)
        , SF.ETC_MEDICAL_AMT            =  DECODE(P_AMOUNT_TYPE, '2', NVL(P_MEDICAL_AMT, 0), SF.ETC_MEDICAL_AMT)
        , SF.MEDICAL_NANIM_AMT          =  DECODE(P_AMOUNT_TYPE, '1', NVL(P_MEDICAL_NANIM_AMT, 0), SF.MEDICAL_NANIM_AMT)
        , SF.ETC_MEDICAL_NANIM_AMT      =  DECODE(P_AMOUNT_TYPE, '2', NVL(P_MEDICAL_NANIM_AMT, 0), SF.ETC_MEDICAL_NANIM_AMT)
        , SF.EDUCATION_AMT              =  DECODE(P_AMOUNT_TYPE, '1', NVL(P_EDUCATION_AMT, 0), SF.EDUCATION_AMT)
        , SF.ETC_EDUCATION_AMT          =  DECODE(P_AMOUNT_TYPE, '2', NVL(P_EDUCATION_AMT, 0), SF.ETC_EDUCATION_AMT)
        , SF.CREDIT_AMT                 =  DECODE(P_AMOUNT_TYPE, '1', NVL(P_CREDIT_AMT, 0), SF.CREDIT_AMT)
        , SF.ETC_CREDIT_AMT             =  DECODE(P_AMOUNT_TYPE, '2', NVL(P_CREDIT_AMT, 0), SF.ETC_CREDIT_AMT)
        , SF.CHECK_CREDIT_AMT           =  DECODE(P_AMOUNT_TYPE, '1', NVL(P_CHECK_CREDIT_AMT, 0), SF.CHECK_CREDIT_AMT)
        , SF.ETC_CHECK_CREDIT_AMT       =  DECODE(P_AMOUNT_TYPE, '2', NVL(P_CHECK_CREDIT_AMT, 0), SF.ETC_CHECK_CREDIT_AMT)
        , SF.CASH_AMT                   =  DECODE(P_AMOUNT_TYPE, '1', NVL(P_CASH_AMT, 0), SF.CASH_AMT)
        , SF.ETC_CASH_AMT               =  DECODE(P_AMOUNT_TYPE, '2', NVL(P_CASH_AMT, 0), SF.ETC_CASH_AMT)
        , SF.ACADE_GIRO_AMT             =  DECODE(P_AMOUNT_TYPE, '1', NVL(P_ACADE_GIRO_AMT, 0), SF.ACADE_GIRO_AMT)
        , SF.ETC_ACADE_GIRO_AMT         =  DECODE(P_AMOUNT_TYPE, '2', NVL(P_ACADE_GIRO_AMT, 0), SF.ETC_ACADE_GIRO_AMT)
        , SF.TRAD_MARKET_AMT            =  DECODE(P_AMOUNT_TYPE, '1', NVL(P_TRAD_MARKET_AMT, 0), SF.TRAD_MARKET_AMT)
        , SF.ETC_TRAD_MARKET_AMT        =  DECODE(P_AMOUNT_TYPE, '2', NVL(P_TRAD_MARKET_AMT, 0), SF.ETC_TRAD_MARKET_AMT)
        , SF.PUBLIC_TRANSIT_AMT         =  DECODE(P_AMOUNT_TYPE, '1', NVL(P_PUBLIC_TRANSIT_AMT, 0), SF.PUBLIC_TRANSIT_AMT)      -- 2013 추가 -- 
        , SF.ETC_PUBLIC_TRANSIT_AMT     =  DECODE(P_AMOUNT_TYPE, '2', NVL(P_PUBLIC_TRANSIT_AMT, 0), SF.ETC_PUBLIC_TRANSIT_AMT)  -- 2013 추가 --            
        , SF.DONAT_ALL                  =  DECODE(P_AMOUNT_TYPE, '1', NVL(P_DONAT_ALL, 0), SF.DONAT_ALL)
        , SF.ETC_DONAT_ALL              =  DECODE(P_AMOUNT_TYPE, '2', NVL(P_DONAT_ALL, 0), SF.ETC_DONAT_ALL)
        , SF.DONAT_50P                  =  DECODE(P_AMOUNT_TYPE, '1', NVL(P_DONAT_50P, 0), SF.DONAT_50P)
        , SF.ETC_DONAT_50P              =  DECODE(P_AMOUNT_TYPE, '2', NVL(P_DONAT_50P, 0), SF.ETC_DONAT_50P)
        , SF.DONAT_30P                  =  DECODE(P_AMOUNT_TYPE, '1', NVL(P_DONAT_30P, 0), SF.DONAT_30P)
        , SF.ETC_DONAT_30P              =  DECODE(P_AMOUNT_TYPE, '2', NVL(P_DONAT_30P, 0), SF.ETC_DONAT_30P)
        , SF.DONAT_10P                  =  DECODE(P_AMOUNT_TYPE, '1', NVL(P_DONAT_10P, 0), SF.DONAT_10P)
        , SF.ETC_DONAT_10P              =  DECODE(P_AMOUNT_TYPE, '2', NVL(P_DONAT_10P, 0), SF.ETC_DONAT_10P)
        , SF.DONAT_10P_RELIGION         =  DECODE(P_AMOUNT_TYPE, '1', NVL(P_DONAT_10P_RELIGION, 0), SF.DONAT_10P_RELIGION)
        , SF.ETC_DONAT_10P_RELIGION     =  DECODE(P_AMOUNT_TYPE, '2', NVL(P_DONAT_10P_RELIGION, 0), SF.ETC_DONAT_10P_RELIGION)
        , SF.DONAT_POLI                 =  DECODE(P_AMOUNT_TYPE, '1', NVL(P_DONAT_POLI, 0), SF.DONAT_POLI)
        , SF.ETC_DONAT_POLI             =  DECODE(P_AMOUNT_TYPE, '2', NVL(P_DONAT_POLI, 0), SF.ETC_DONAT_POLI)
        , SF.CREDIT_ALL_AMT_2013        = DECODE(P_AMOUNT_TYPE, '1', NVL(P_CREDIT_ALL_AMT_2013, 0), SF.CREDIT_ALL_AMT_2013)   -- 2013년 총사용액 
        , SF.ADD_CREDIT_AMT_2013        = DECODE(P_AMOUNT_TYPE, '1', NVL(P_ADD_CREDIT_AMT_2013, 0), SF.ADD_CREDIT_AMT_2013)   -- 2013년 추가 사용액 
        , SF.CREDIT_ALL_AMT_2014        = DECODE(P_AMOUNT_TYPE, '1', NVL(P_CREDIT_ALL_AMT_2014, 0), SF.CREDIT_ALL_AMT_2014)   -- 2013년 총사용액 
        , SF.ADD_CREDIT_AMT_2014        = DECODE(P_AMOUNT_TYPE, '1', NVL(P_ADD_CREDIT_AMT_2014, 0), SF.ADD_CREDIT_AMT_2014)   -- 2013년 추가 사용액 
        , SF.PRE_CREDIT_ALL_AMT         = DECODE(P_AMOUNT_TYPE, '1', NVL(P_PRE_CREDIT_ALL_AMT, 0), SF.PRE_CREDIT_ALL_AMT)     -- 전년도 총사용액 
        , SF.PRE_ADD_CREDIT_AMT         = DECODE(P_AMOUNT_TYPE, '1', NVL(P_PRE_ADD_CREDIT_AMT, 0), SF.PRE_ADD_CREDIT_AMT)     -- 전년도 추가(상반기)사용액 
        , SF.PRE_SEC_CREDIT_AMT         = DECODE(P_AMOUNT_TYPE, '1', NVL(P_PRE_SEC_CREDIT_AMT, 0), SF.PRE_SEC_CREDIT_AMT)     -- 전년도 하반기사용액
        , SF.ADD_CREDIT_AMT             = DECODE(P_AMOUNT_TYPE, '1', NVL(P_ADD_CREDIT_AMT, 0), SF.ADD_CREDIT_AMT)             -- 당년도 추가사용액(상반기) 
        , SF.ADD_SEC_CREDIT_AMT         = DECODE(P_AMOUNT_TYPE, '1', NVL(P_ADD_SEC_CREDIT_AMT, 0), SF.ADD_SEC_CREDIT_AMT)     -- 당년도 추가사용액(하반기)
        , SF.LAST_UPDATE_DATE           =  V_SYSDATE
        , SF.LAST_UPDATED_BY            =  P_USER_ID
    WHERE SOB_ID                        =  W_SOB_ID
      AND PERSON_ID                     =  W_PERSON_ID
      AND REPRE_NUM                     =  ENCRYPT_F(W_REPRE_NUM)
      AND YEAR_YYYY                     =  W_YEAR_YYYY
    ;
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO HRA_SUPPORT_FAMILY
      ( YEAR_YYYY
      , SOB_ID
      , ORG_ID  
      , PERSON_ID
      , REPRE_NUM
      , RELATION_CODE
      , FAMILY_NAME
      , BASE_YN
      , MEDIC_INSUR_AMT 
      , ETC_MEDIC_INSUR_AMT 
      , INSURE_AMT                  
      , ETC_INSURE_AMT            
      , DISABILITY_INSURE_AMT     
      , ETC_DISABILITY_INSURE_AMT 
      , MEDICAL_AMT               
      , ETC_MEDICAL_AMT
      , MEDICAL_NANIM_AMT
      , ETC_MEDICAL_NANIM_AMT 
      , EDUCATION_AMT             
      , ETC_EDUCATION_AMT         
      , CREDIT_AMT                
      , ETC_CREDIT_AMT            
      , CHECK_CREDIT_AMT          
      , ETC_CHECK_CREDIT_AMT      
      , CASH_AMT                  
      , ETC_CASH_AMT              
      , ACADE_GIRO_AMT            
      , ETC_ACADE_GIRO_AMT        
      , TRAD_MARKET_AMT
      , ETC_TRAD_MARKET_AMT
      , PUBLIC_TRANSIT_AMT        -- 2013 추가 -- 
      , ETC_PUBLIC_TRANSIT_AMT    -- 2013 추가 -- 
      , DONAT_ALL                 
      , ETC_DONAT_ALL             
      , DONAT_50P                 
      , ETC_DONAT_50P             
      , DONAT_30P                 
      , ETC_DONAT_30P             
      , DONAT_10P                 
      , ETC_DONAT_10P             
      , DONAT_10P_RELIGION        
      , ETC_DONAT_10P_RELIGION
      , DONAT_POLI                
      , ETC_DONAT_POLI 
      , CREDIT_ALL_AMT_2013      -- 2013년 총사용액 
      , ADD_CREDIT_AMT_2013      -- 2013년 추가 사용액 
      , CREDIT_ALL_AMT_2014      -- 2014년 총사용액 
      , ADD_CREDIT_AMT_2014      -- 2014년 추가 사용액 
      , PRE_CREDIT_ALL_AMT       -- 전년도 총사용액 
      , PRE_ADD_CREDIT_AMT       -- 전년도 추가사용액 
      , PRE_SEC_CREDIT_AMT       -- 전년도 하반기 사용액.
      , ADD_CREDIT_AMT           -- 당년도 추가사용액(상반기) 
      , ADD_SEC_CREDIT_AMT       -- 당년도 추가사용액(하반기) 
      , CREATION_DATE
      , CREATED_BY
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY
      ) VALUES
      ( W_YEAR_YYYY
      , W_SOB_ID
      , W_ORG_ID
      , W_PERSON_ID
      , ENCRYPT_F(W_REPRE_NUM)
      , P_YEAR_RELATION_CODE
      , P_FAMILY_NAME
      , DECODE(P_YEAR_RELATION_CODE, '0', 'Y', 'N')
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_MEDIC_INSUR_AMT, 0), 0)
      , DECODE(P_AMOUNT_TYPE, '2', NVL(P_MEDIC_INSUR_AMT, 0), 0)      
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_INSURE_AMT, 0), 0)                            
      , DECODE(P_AMOUNT_TYPE, '2', NVL(P_INSURE_AMT, 0), 0)                      
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_DISABILITY_INSURE_AMT, 0), 0)    
      , DECODE(P_AMOUNT_TYPE, '2', NVL(P_DISABILITY_INSURE_AMT, 0), 0)
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_MEDICAL_AMT, 0), 0)                        
      , DECODE(P_AMOUNT_TYPE, '2', NVL(P_MEDICAL_AMT, 0), 0)    
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_MEDICAL_NANIM_AMT, 0), 0)                        
      , DECODE(P_AMOUNT_TYPE, '2', NVL(P_MEDICAL_NANIM_AMT, 0), 0)    
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_EDUCATION_AMT, 0), 0)                    
      , DECODE(P_AMOUNT_TYPE, '2', NVL(P_EDUCATION_AMT, 0), 0)                
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_CREDIT_AMT, 0), 0)                          
      , DECODE(P_AMOUNT_TYPE, '2', NVL(P_CREDIT_AMT, 0), 0)                      
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_CHECK_CREDIT_AMT, 0), 0)              
      , DECODE(P_AMOUNT_TYPE, '2', NVL(P_CHECK_CREDIT_AMT, 0), 0)          
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_CASH_AMT, 0), 0)                              
      , DECODE(P_AMOUNT_TYPE, '2', NVL(P_CASH_AMT, 0), 0)                          
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_ACADE_GIRO_AMT, 0), 0)                  
      , DECODE(P_AMOUNT_TYPE, '2', NVL(P_ACADE_GIRO_AMT, 0), 0)              
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_TRAD_MARKET_AMT, 0), 0)                  
      , DECODE(P_AMOUNT_TYPE, '2', NVL(P_TRAD_MARKET_AMT, 0), 0)       
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_PUBLIC_TRANSIT_AMT, 0), 0)   -- 2013 추가 --                 
      , DECODE(P_AMOUNT_TYPE, '2', NVL(P_PUBLIC_TRANSIT_AMT, 0), 0)   -- 2013 추가 --      
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_DONAT_ALL, 0), 0)                            
      , DECODE(P_AMOUNT_TYPE, '2', NVL(P_DONAT_ALL, 0), 0)                        
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_DONAT_50P, 0), 0)                            
      , DECODE(P_AMOUNT_TYPE, '2', NVL(P_DONAT_50P, 0), 0)                        
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_DONAT_30P, 0), 0)                            
      , DECODE(P_AMOUNT_TYPE, '2', NVL(P_DONAT_30P, 0), 0)                        
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_DONAT_10P, 0), 0)                            
      , DECODE(P_AMOUNT_TYPE, '2', NVL(P_DONAT_10P, 0), 0)                        
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_DONAT_10P_RELIGION, 0), 0)          
      , DECODE(P_AMOUNT_TYPE, '2', NVL(P_DONAT_10P_RELIGION, 0), 0)      
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_DONAT_POLI, 0), 0)                          
      , DECODE(P_AMOUNT_TYPE, '2', NVL(P_DONAT_POLI, 0), 0)
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_CREDIT_ALL_AMT_2013, 0), 0)      -- 2013년 총사용액                        
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_ADD_CREDIT_AMT_2013, 0), 0)      -- 전년도 총사용액 
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_CREDIT_ALL_AMT_2014, 0), 0)      -- 2013년 추가 사용액      
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_ADD_CREDIT_AMT_2014, 0), 0)      -- 당년도 추가사용액(상반기) 
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_PRE_CREDIT_ALL_AMT, 0), 0)       -- 전년도 추가사용액 
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_PRE_ADD_CREDIT_AMT, 0), 0)       -- 당년도 추가사용액(하반기)  
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_PRE_SEC_CREDIT_AMT, 0), 0)       -- 당년도 추가사용액(하반기)
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_ADD_CREDIT_AMT, 0), 0)           -- 당년도 추가사용액(하반기)
      , DECODE(P_AMOUNT_TYPE, '1', NVL(P_ADD_SEC_CREDIT_AMT, 0), 0)       -- 당년도 추가사용액(하반기) 
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID
      );
    END IF;
  END UPDATE_SUPPORT_AMOUNT;

/*======================================================================/
     ++ 연말정산 부양가족 내역 --> 인사 부양가족 내역으로 interface  
/======================================================================*/
  PROCEDURE INIT_SUPPORT_FAMILY
            ( O_STATUS            OUT VARCHAR2 
            , O_MESSAGE           OUT VARCHAR2 
            , P_CONNECT_PERSON_ID IN  NUMBER 
            , P_YEAR_YYYY         IN  VARCHAR2
            , P_PERSON_ID         IN  NUMBER
            , P_SOB_ID            IN  NUMBER
            , P_ORG_ID            IN  NUMBER
            )
  AS
    V_FAMILY_ID             NUMBER;
    V_USER_ID               NUMBER;
  BEGIN
    O_STATUS := 'F';
    
    BEGIN
      SELECT EU.USER_ID
        INTO V_USER_ID 
        FROM EAPP_USER EU
       WHERE EU.PERSON_ID   = P_CONNECT_PERSON_ID
       ;
    EXCEPTION
      WHEN OTHERS THEN
        V_USER_ID := -1;
    END;
    FOR C1 IN (SELECT SF.SOB_ID 
                    , SF.ORG_ID 
                    , SF.PERSON_ID 
                    , SF.FAMILY_NAME
                    , SF.REPRE_NUM 
                    , SF.FAMILY_RELATION_CODE 
                    , SF.RELATION_CODE
                    , HR.RELATION_ID 
                    , SF.BASE_YN
                    , SF.DISABILITY_YN 
                 FROM HRA_SUPPORT_FAMILY SF
                    , HRM_RELATION_V     HR 
                WHERE SF.FAMILY_RELATION_CODE = HR.RELATION_CODE
                  AND SF.SOB_ID               = HR.SOB_ID 
                  
                  AND SF.YEAR_YYYY       = P_YEAR_YYYY
                  AND SF.SOB_ID          = P_SOB_ID 
                  AND SF.PERSON_ID       = P_PERSON_ID   
                  AND SF.RELATION_CODE   != '0' -- 본인 제외 -- 
                  AND NOT EXISTS
                        ( SELECT 'X'
                            FROM HRM_FAMILY HF
                           WHERE HF.PERSON_ID   = SF.PERSON_ID
                             AND HF.RELATION_ID = HR.RELATION_ID
                             AND HF.FAMILY_NAME = SF.FAMILY_NAME         
                        )           
              )
    LOOP
      SELECT HRM_FAMILY_S1.NEXTVAL
        INTO V_FAMILY_ID 
        FROM DUAL;
          
      INSERT INTO HRM_FAMILY
      ( FAMILY_ID 
      , PERSON_ID 
      , FAMILY_NAME 
      , RELATION_ID 
      , REPRE_NUM 
      , LIVE_YN 
      , DEFORM_YN 
      , TAX_YN 
      , DESCRIPTION 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( V_FAMILY_ID 
      , C1.PERSON_ID 
      , C1.FAMILY_NAME 
      , C1.RELATION_ID 
      , C1.REPRE_NUM 
      , NVL(C1.BASE_YN, 'N')                 -- LIVE_YN 
      , NVL(C1.DISABILITY_YN, 'N')           -- DEFORM_YN
      , NVL(C1.BASE_YN, 'N')                 -- TAX_YN 
      , 'Support Family Interface'           -- DESCRIPTION 
      , SYSDATE                              -- CREATION_DATE 
      , V_USER_ID                            -- CREATED_BY 
      , SYSDATE                              -- LAST_UPDATE_DATE 
      , V_USER_ID                            -- LAST_UPDATED_BY 
      );    
    END LOOP C1; 
    O_STATUS := 'S';
  END INIT_SUPPORT_FAMILY;
            
/*======================================================================/
     ++ 전년도 신용카드 사용액 UPDATE 
/======================================================================*/
  PROCEDURE INIT_PRE_CREDIT_AMOUNT
            ( O_STATUS            OUT VARCHAR2 
            , O_MESSAGE           OUT VARCHAR2 
            , P_YEAR_YYYY         IN  VARCHAR2 
            , P_OPERATING_UNIT_ID IN  NUMBER DEFAULT NULL 
            , P_YEAR_EMPLOYE_TYPE IN  VARCHAR2 DEFAULT NULL 
            , P_DEPT_ID           IN  NUMBER DEFAULT NULL 
            , P_FLOOR_ID          IN  NUMBER DEFAULT NULL 
            , P_PERSON_ID         IN  NUMBER
            , P_SOB_ID            IN  NUMBER
            , P_ORG_ID            IN  NUMBER         
            )
  AS
    V_SYSDATE        DATE := GET_LOCAL_DATE(P_SOB_ID);
    
    V_LAST_DATE      DATE;  -- 연말일자 --
    V_PRE_YEAR_YYYY  VARCHAR2(4);
  BEGIN
    O_STATUS := 'F';
    IF HRA_YEAR_ADJUST_SET_G.GET_ADJUST_CLOSED_FLAG_F
        ( P_YEAR_YYYY         => P_YEAR_YYYY 
        , P_PERSON_ID         => P_PERSON_ID
        , P_SOB_ID            => P_SOB_ID 
        , P_ORG_ID            => P_ORG_ID) = 'Y' THEN
      O_STATUS := 'F';
      O_MESSAGE := '해당 자료는 연말정산 계산이 완료/마감 되었습니다. 변경할 수 없습니다.';
      RETURN;  
    END IF;
    
    V_LAST_DATE := TO_DATE(P_YEAR_YYYY || '-12-31', 'YYYY-MM-DD');
    V_PRE_YEAR_YYYY := TO_CHAR(TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') - 1, 'YYYY');
    FOR C1 IN ( SELECT HPM.PERSON_ID
                     , HPM.PERSON_NUM
                     , HPM.NAME
                     , HPM.REPRE_NUM
                     , '0' AS YEAR_RELATION_CODE  -- 본인 --
                     , HPM.SOB_ID
                     , P_ORG_ID AS ORG_ID
                     , SF.CREDIT_ALL_AMT_2013 
                     , SF.ADD_CREDIT_AMT_2013 
                     , NVL((SELECT SUM(S_SF.CREDIT_ALL_AMT) AS CREDIT_ALL_AMT 
                              FROM HRA_SUPPORT_FAMILY_V S_SF
                             WHERE S_SF.YEAR_YYYY   = '2014'
                               AND S_SF.SOB_ID      = HPM.SOB_ID
                               AND S_SF.PERSON_ID   = HPM.PERSON_ID
                               AND S_SF.RELATION_CODE = '0'
                           ),0) AS CREDIT_ALL_AMT_2014
                     , NVL((SELECT SUM((NVL(S_SF.ACADE_GIRO_AMT, 0) +
                                        NVL(S_SF.ETC_ACADE_GIRO_AMT, 0) +
                                        NVL(S_SF.CHECK_CREDIT_AMT, 0) +
                                        NVL(S_SF.ETC_CHECK_CREDIT_AMT, 0) +
                                        NVL(S_SF.CASH_AMT, 0) +
                                        NVL(S_SF.ETC_CASH_AMT, 0) +
                                        NVL(S_SF.TRAD_MARKET_AMT, 0) +
                                        NVL(S_SF.ETC_TRAD_MARKET_AMT, 0) +
                                        NVL(S_SF.PUBLIC_TRANSIT_AMT, 0) +
                                        NVL(S_SF.ETC_PUBLIC_TRANSIT_AMT, 0))) AS ADD_CREDIT_AMT 
                              FROM HRA_SUPPORT_FAMILY_V S_SF
                             WHERE S_SF.YEAR_YYYY   = '2014'
                               AND S_SF.SOB_ID      = HPM.SOB_ID
                               AND S_SF.PERSON_ID   = HPM.PERSON_ID
                               AND S_SF.RELATION_CODE = '0'
                           ),0) AS ADD_CREDIT_AMT_2014 
                     , NVL(SF.CREDIT_ALL_AMT,0) AS PRE_CREDIT_ALL_AMT
                     , NVL(SF.ADD_CREDIT_AMT,0) AS PRE_ADD_CREDIT_AMT
                     , NVL(SF.ADD_SEC_CREDIT_AMT,0) AS PRE_ADD_SEC_CREDIT_AMT
                  FROM HRM_PERSON_MASTER_V  HPM 
                     , HRA_SUPPORT_FAMILY_V SF 
                     , (-- 시점 인사내역.
                        SELECT HL.PERSON_ID
                            , HL.OPERATING_UNIT_ID 
                            , HL.DEPT_ID
                            , HL.FLOOR_ID  
                        FROM HRM_HISTORY_HEADER HH
                           , HRM_HISTORY_LINE   HL  
                        WHERE HH.HISTORY_HEADER_ID   = HL.HISTORY_HEADER_ID 
                          AND HH.CHARGE_SEQ          IN 
                                (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                    FROM HRM_HISTORY_HEADER S_HH
                                       , HRM_HISTORY_LINE   S_HL
                                   WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                     AND S_HH.CHARGE_DATE       <= V_LAST_DATE
                                     AND S_HL.PERSON_ID         = HL.PERSON_ID
                                   GROUP BY S_HL.PERSON_ID
                                 ) 
                      ) T1
                WHERE HPM.PERSON_ID           = SF.PERSON_ID 
                  AND HPM.PERSON_ID           = T1.PERSON_ID 
                  AND SF.YEAR_YYYY            = V_PRE_YEAR_YYYY
                  AND SF.SOB_ID               = P_SOB_ID 
                  AND SF.RELATION_CODE        = '0'
                  AND ((P_PERSON_ID           IS NULL AND 1 = 1)
                    OR (P_PERSON_ID           IS NOT NULL AND HPM.PERSON_ID = P_PERSON_ID))  
                  AND ((P_OPERATING_UNIT_ID   IS NULL AND 1 = 1)
                    OR (P_OPERATING_UNIT_ID   IS NOT NULL AND T1.OPERATING_UNIT_ID = P_OPERATING_UNIT_ID)) 
                  AND ((P_DEPT_ID             IS NULL AND 1 = 1)
                    OR (P_DEPT_ID             IS NOT NULL AND T1.DEPT_ID = P_DEPT_ID)) 
                  AND ((P_FLOOR_ID            IS NULL AND 1 = 1)
                    OR (P_FLOOR_ID            IS NOT NULL AND T1.FLOOR_ID = P_FLOOR_ID)) 
                  AND HPM.SOB_ID              = P_SOB_ID
                  AND HPM.JOIN_DATE           <= V_LAST_DATE
                  AND (HPM.RETIRE_DATE IS NULL OR HPM.RETIRE_DATE >= V_LAST_DATE)
                  AND ((P_YEAR_EMPLOYE_TYPE   IS NULL AND 1 = 1)
                    OR (P_YEAR_EMPLOYE_TYPE   != '20' AND (HPM.RETIRE_DATE > LAST_DAY(V_LAST_DATE) OR HPM.RETIRE_DATE IS NULL))
                    OR (P_YEAR_EMPLOYE_TYPE   = '20' AND (HPM.RETIRE_DATE BETWEEN TRUNC(V_LAST_DATE, 'MONTH') AND V_LAST_DATE)))
                  AND NOT EXISTS
                        ( SELECT 'X'
                            FROM HRA_FOUNDATION HF 
                           WHERE HF.PERSON_ID         = HPM.PERSON_ID
                             AND HF.SOB_ID            = HPM.SOB_ID 
                             AND HF.YEAR_YYYY         = P_YEAR_YYYY
                             AND HF.RECEIPT_FLAG      = 'Y'
                        )
                  AND NOT EXISTS
                        ( SELECT 'X'
                            FROM HRA_YEAR_ADJUSTMENT YA
                           WHERE YA.PERSON_ID         = HPM.PERSON_ID 
                             AND YA.SOB_ID            = HPM.SOB_ID 
                             AND YA.YEAR_YYYY         = P_YEAR_YYYY
                             AND YA.CLOSED_FLAG       = 'Y'
                        ) 
              )
    LOOP    
      UPDATE HRA_SUPPORT_FAMILY SF
         SET /*SF.CREDIT_ALL_AMT_2013     = NVL(C1.CREDIT_ALL_AMT_2013, 0)
           , SF.ADD_CREDIT_AMT_2013     = NVL(C1.ADD_CREDIT_AMT_2013, 0)
           , */SF.CREDIT_ALL_AMT_2014     = NVL(C1.CREDIT_ALL_AMT_2014, 0)
           , SF.ADD_CREDIT_AMT_2014     = NVL(C1.ADD_CREDIT_AMT_2014, 0) 
           , SF.PRE_CREDIT_ALL_AMT      = NVL(C1.PRE_CREDIT_ALL_AMT, 0) 
           /*, SF.PRE_ADD_CREDIT_AMT      = NVL(C1.PRE_ADD_CREDIT_AMT, 0)*/
           , SF.PRE_SEC_CREDIT_AMT      = NVL(C1.PRE_ADD_SEC_CREDIT_AMT, 0) 
       WHERE SF.YEAR_YYYY     = P_YEAR_YYYY
         AND SF.PERSON_ID     = C1.PERSON_ID
         AND SF.REPRE_NUM     = ENCRYPT_F(C1.REPRE_NUM) 
         AND SF.RELATION_CODE = C1.YEAR_RELATION_CODE
      ;
    END LOOP C1;
    O_STATUS := 'S';
  END INIT_PRE_CREDIT_AMOUNT;
  
    
/*======================================================================/
     ++ 전년도 신용카드등 전체 사용 금액 
/======================================================================*/
  FUNCTION GET_PRE_CREDIT_ALL_AMT_F
            ( P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_RELATION_CODE     IN VARCHAR2 
            , P_REPRE_NUM         IN VARCHAR2 
            ) RETURN NUMBER
  AS
    V_PRE_YEAR_YYYY         VARCHAR2(4);
    V_PRE_CREDIT_ALL_AMT    NUMBER := 0;
  BEGIN
    V_PRE_YEAR_YYYY := TO_CHAR(ADD_MONTHS(TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD'), -1), 'YYYY');  -- 전년도 
    BEGIN
      SELECT SUM(NVL(SF.CREDIT_AMT, 0) + NVL(SF.ETC_CREDIT_AMT, 0) + 
                 NVL(SF.CHECK_CREDIT_AMT, 0) + NVL(ETC_CHECK_CREDIT_AMT, 0) + 
                 NVL(SF.CASH_AMT, 0) + NVL(ETC_CASH_AMT, 0) + 
                 NVL(SF.ACADE_GIRO_AMT, 0) + NVL(ETC_ACADE_GIRO_AMT, 0) + 
                 NVL(SF.TRAD_MARKET_AMT, 0) + NVL(ETC_TRAD_MARKET_AMT, 0) + 
                 NVL(SF.PUBLIC_TRANSIT_AMT, 0) + NVL(ETC_PUBLIC_TRANSIT_AMT, 0)) AS PRE_CREDIT_ALL_AMT 
        INTO V_PRE_CREDIT_ALL_AMT 
        FROM HRA_SUPPORT_FAMILY_V SF
       WHERE SF.YEAR_YYYY         = V_PRE_YEAR_YYYY 
         AND SF.PERSON_ID         = P_PERSON_ID
         AND SF.SOB_ID            = P_SOB_ID 
         AND SF.RELATION_CODE     = '0'  -- P_RELATION_CODE
         AND SF.REPRE_NUM         = P_REPRE_NUM
       ;
    EXCEPTION
      WHEN OTHERS THEN
        V_PRE_CREDIT_ALL_AMT := 0; 
    END;
    RETURN V_PRE_CREDIT_ALL_AMT;
  END GET_PRE_CREDIT_ALL_AMT_F;
  
                        
/*======================================================================/
     ++ 전년도 추가공제 사용 금액 
/======================================================================*/
  FUNCTION GET_PRE_ADD_CREDIT_AMT_F
            ( P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_RELATION_CODE     IN VARCHAR2 
            , P_REPRE_NUM         IN VARCHAR2 
            ) RETURN NUMBER
  AS
    V_PRE_YEAR_YYYY         VARCHAR2(4);
    V_PRE_ADD_CREDIT_AMT    NUMBER := 0;
  BEGIN
    V_PRE_YEAR_YYYY := TO_CHAR(ADD_MONTHS(TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD'), -1), 'YYYY');  -- 전년도 
    BEGIN
      SELECT SUM(NVL(SF.CHECK_CREDIT_AMT, 0) + NVL(ETC_CHECK_CREDIT_AMT, 0) + 
                 NVL(SF.CASH_AMT, 0) + NVL(ETC_CASH_AMT, 0) + 
                 NVL(SF.ACADE_GIRO_AMT, 0) + NVL(ETC_ACADE_GIRO_AMT, 0) + 
                 NVL(SF.TRAD_MARKET_AMT, 0) + NVL(ETC_TRAD_MARKET_AMT, 0) + 
                 NVL(SF.PUBLIC_TRANSIT_AMT, 0) + NVL(ETC_PUBLIC_TRANSIT_AMT, 0)) AS PRE_CREDIT_ALL_AMT 
        INTO V_PRE_ADD_CREDIT_AMT 
        FROM HRA_SUPPORT_FAMILY_V SF
       WHERE SF.YEAR_YYYY         = V_PRE_YEAR_YYYY 
         AND SF.PERSON_ID         = P_PERSON_ID
         AND SF.SOB_ID            = P_SOB_ID 
         AND SF.RELATION_CODE     = '0'  -- P_RELATION_CODE 
         AND SF.REPRE_NUM         = P_REPRE_NUM
       ;
    EXCEPTION
      WHEN OTHERS THEN
        V_PRE_ADD_CREDIT_AMT := 0;
    END;
    
    V_PRE_ADD_CREDIT_AMT := NVL(V_PRE_ADD_CREDIT_AMT, 0);
    
    RETURN V_PRE_ADD_CREDIT_AMT;
  END GET_PRE_ADD_CREDIT_AMT_F;            

/*======================================================================/
     ++ 2013년도 신용카드 사용 금액 
/======================================================================*/
FUNCTION GET_2013_CREDIT_ALL_AMT_F
            ( P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_REPRE_NUM         IN VARCHAR2 
            ) RETURN NUMBER
  AS
    V_YEAR_YYYY             VARCHAR2(4) := '2013';
    V_ADD_CREDIT_AMT        NUMBER := 0;
  BEGIN
    BEGIN
      SELECT SUM(NVL(SF.CREDIT_AMT, 0) + NVL(SF.ETC_CREDIT_AMT, 0) + 
                 NVL(SF.CHECK_CREDIT_AMT, 0) + NVL(ETC_CHECK_CREDIT_AMT, 0) + 
                 NVL(SF.CASH_AMT, 0) + NVL(ETC_CASH_AMT, 0) + 
                 NVL(SF.ACADE_GIRO_AMT, 0) + NVL(ETC_ACADE_GIRO_AMT, 0) + 
                 NVL(SF.TRAD_MARKET_AMT, 0) + NVL(ETC_TRAD_MARKET_AMT, 0) + 
                 NVL(SF.PUBLIC_TRANSIT_AMT, 0) + NVL(ETC_PUBLIC_TRANSIT_AMT, 0)) AS PRE_CREDIT_ALL_AMT 
        INTO V_ADD_CREDIT_AMT 
        FROM HRA_SUPPORT_FAMILY_V SF
       WHERE SF.YEAR_YYYY         = V_YEAR_YYYY 
         AND SF.PERSON_ID         = P_PERSON_ID
         AND SF.SOB_ID            = P_SOB_ID 
         AND SF.RELATION_CODE     = '0'  -- P_RELATION_CODE
         AND SF.REPRE_NUM         = P_REPRE_NUM
       ;
    EXCEPTION
      WHEN OTHERS THEN
        V_ADD_CREDIT_AMT := 0; 
    END;
    RETURN V_ADD_CREDIT_AMT;
  END GET_2013_CREDIT_ALL_AMT_F;
  
  FUNCTION GET_2013_ADD_CREDIT_AMT_F
            ( P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_REPRE_NUM         IN VARCHAR2 
            ) RETURN NUMBER
  AS
    V_YEAR_YYYY             VARCHAR2(4) := '2013';
    V_ADD_CREDIT_AMT        NUMBER := 0;
  BEGIN
    BEGIN
      SELECT SUM(NVL(SF.CHECK_CREDIT_AMT, 0) + NVL(ETC_CHECK_CREDIT_AMT, 0) + 
                 NVL(SF.CASH_AMT, 0) + NVL(ETC_CASH_AMT, 0) + 
                 NVL(SF.ACADE_GIRO_AMT, 0) + NVL(ETC_ACADE_GIRO_AMT, 0) + 
                 NVL(SF.TRAD_MARKET_AMT, 0) + NVL(ETC_TRAD_MARKET_AMT, 0) + 
                 NVL(SF.PUBLIC_TRANSIT_AMT, 0) + NVL(ETC_PUBLIC_TRANSIT_AMT, 0)) AS PRE_CREDIT_ALL_AMT 
        INTO V_ADD_CREDIT_AMT 
        FROM HRA_SUPPORT_FAMILY_V SF
       WHERE SF.YEAR_YYYY         = V_YEAR_YYYY   -- 2013년도 -- 
         AND SF.PERSON_ID         = P_PERSON_ID
         AND SF.SOB_ID            = P_SOB_ID 
         AND SF.RELATION_CODE     = '0'  -- P_RELATION_CODE 
         AND SF.REPRE_NUM         = P_REPRE_NUM
       ;
    EXCEPTION
      WHEN OTHERS THEN
        V_ADD_CREDIT_AMT := 0;
    END;
    RETURN V_ADD_CREDIT_AMT;
  END GET_2013_ADD_CREDIT_AMT_F;
            
/*======================================================================/
     ++ 룩업 : 부양가족 사항.
/======================================================================*/
  PROCEDURE LU_SUPPORT_FAMILY
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT HSF.PERSON_ID
          , HSF.RELATION_CODE
          , HRM_COMMON_G.CODE_NAME_F('YEAR_RELATION', HSF.RELATION_CODE, HSF.SOB_ID, HSF.ORG_ID) AS RELATION_DESC
          , HSF.FAMILY_NAME
          , HSF.REPRE_NUM
          , CASE
              WHEN HSF.RELATION_CODE = '0' THEN '1'
              WHEN HSF.DISABILITY_YN = 'Y' THEN '1'
              WHEN HSF.OLD_YN = 'Y' THEN '1'
              WHEN HSF.OLD1_YN = 'Y' THEN '1'
              ELSE '2'
            END AS MEDIC_TYPE
          , HRM_COMMON_G.CODE_NAME_F('MEDIC_TYPE', CASE
                                                        WHEN HSF.RELATION_CODE = '0' THEN '1'
                                                        WHEN HSF.DISABILITY_YN = 'Y' THEN '1'
                                                        WHEN HSF.OLD_YN = 'Y' THEN '1'
                                                        WHEN HSF.OLD1_YN = 'Y' THEN '1'
                                                        ELSE '2'
                                                      END, HSF.SOB_ID, HSF.ORG_ID) AS MEDIC_TYPE_DESC
          , HSF.DISABILITY_YN
          , CASE
              WHEN HSF.OLD_YN = 'Y' THEN 'Y'
              WHEN HSF.OLD1_YN = 'Y' THEN 'Y'
              ELSE 'N'
            END OLD_YN
        FROM HRA_SUPPORT_FAMILY_V HSF
       WHERE HSF.YEAR_YYYY          = P_YEAR_YYYY
         AND HSF.PERSON_ID          = P_PERSON_ID
         AND HSF.SOB_ID             = P_SOB_ID
       ORDER BY HSF.RELATION_CODE
       ;
  END LU_SUPPORT_FAMILY;

/*======================================================================/
     ++ 룩업 : 의료비 명세서 부양가족 사항.
/======================================================================*/
  PROCEDURE LU_SUPPORT_FAMILY_MEDIC
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , P_YEAR_YYYY         IN VARCHAR2
            , P_PERSON_ID         IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
    V_STD_DATE          DATE := TO_DATE(P_YEAR_YYYY || '-12-31', 'YYYY-MM-DD');
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT HSF.PERSON_ID
          , HSF.RELATION_CODE
          , HRM_COMMON_G.CODE_NAME_F('YEAR_RELATION', HSF.RELATION_CODE, HSF.SOB_ID, HSF.ORG_ID) AS RELATION_DESC
          , HSF.FAMILY_NAME
          , HSF.REPRE_NUM
          , CASE
              WHEN HSF.RELATION_CODE = '0' THEN '1'
              WHEN HSF.DISABILITY_YN = 'Y' THEN '1'
              WHEN HSF.OLD_YN = 'Y' THEN '1'
              WHEN HSF.OLD1_YN = 'Y' THEN '1'
              WHEN EAPP_REGISTER_AGE_F(HSF.REPRE_NUM, V_STD_DATE, 0) >= 65 THEN '1' 
              ELSE '2'
            END AS MEDIC_TYPE
          , HRM_COMMON_G.CODE_NAME_F('MEDIC_TYPE', CASE
                                                        WHEN HSF.RELATION_CODE = '0' THEN '1'
                                                        WHEN HSF.DISABILITY_YN = 'Y' THEN '1'
                                                        WHEN HSF.OLD_YN = 'Y' THEN '1'
                                                        WHEN HSF.OLD1_YN = 'Y' THEN '1'
                                                        WHEN EAPP_REGISTER_AGE_F(HSF.REPRE_NUM, V_STD_DATE, 0) >= 65 THEN '1'
                                                        ELSE '2'
                                                      END, HSF.SOB_ID, HSF.ORG_ID) AS MEDIC_TYPE_DESC
          , HSF.DISABILITY_YN
          , CASE
              WHEN HSF.OLD_YN = 'Y' THEN 'Y'
              WHEN HSF.OLD1_YN = 'Y' THEN 'Y'
              ELSE 'N'
            END OLD_YN
        FROM HRA_SUPPORT_FAMILY_V HSF
       WHERE HSF.YEAR_YYYY          = P_YEAR_YYYY
         AND HSF.PERSON_ID          = P_PERSON_ID
         AND HSF.SOB_ID             = P_SOB_ID
       ORDER BY HSF.RELATION_CODE
       ;
  END LU_SUPPORT_FAMILY_MEDIC;            
            
/*======================================================================/
     ++ 룩업 : 가족 사항.
/======================================================================*/  
  PROCEDURE LU_FAMILY
            ( P_CURSOR3         OUT TYPES.TCURSOR3
            , W_PERSON_ID       IN  NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT  SX1.PERSON_ID
            , SX1.FAMILY_NAME
            , SX1.REPRE_NUM
            , SX1.YEAR_RELATION_CODE
            , SX1.YEAR_RELATION_NAME
          FROM (SELECT  HF.PERSON_ID
                      , HF.FAMILY_NAME
                      , HF.REPRE_NUM
                      , YR.YEAR_RELATION_CODE
                      , YR.YEAR_RELATION_NAME
                      , YR.SORT_NUM
                  FROM  HRM_FAMILY_V         HF
                      , HRM_RELATION_V       RV
                      , HRM_YEAR_RELATION_V  YR
                  WHERE HF.RELATION_ID         = RV.RELATION_ID
                    AND RV.YEAR_RELATION_CODE  = YR.YEAR_RELATION_CODE
                    AND RV.SOB_ID              = YR.SOB_ID
                    AND HF.PERSON_ID           = W_PERSON_ID
                  UNION ALL
                  SELECT  PM.PERSON_ID
                        , PM.NAME AS FAMILY_NAME
                        , PM.REPRE_NUM
                        , YR.YEAR_RELATION_CODE
                        , YR.YEAR_RELATION_NAME
                        , 0 AS SORT_NUM
                   FROM HRM_PERSON_MASTER_V  PM
                      , HRM_YEAR_RELATION_V  YR
                  WHERE  '0'                    = YR.YEAR_RELATION_CODE
                    AND PM.SOB_ID              = YR.SOB_ID
                    AND PM.PERSON_ID           = W_PERSON_ID
                ) SX1
        ORDER BY SX1.SORT_NUM
        ;  
  END LU_FAMILY;
    
END HRA_SUPPORT_FAMILY_G;
/
