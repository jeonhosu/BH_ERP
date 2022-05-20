CREATE OR REPLACE PACKAGE HRM_HISTORY_LINE_G
AS

-- DATA_SELECT.
   PROCEDURE DATA_SELECT
           ( P_CURSOR             OUT TYPES.TCURSOR
           , W_HISTORY_HEADER_ID  IN  HRM_HISTORY_LINE.HISTORY_HEADER_ID%TYPE
           , W_DEPT_ID            IN  HRM_HISTORY_LINE.DEPT_ID%TYPE
           , W_PERSON_ID          IN  HRM_HISTORY_LINE.PERSON_ID%TYPE
           );

-- DATA_INSERT.
  PROCEDURE DATA_INSERT
           ( P_HISTORY_HEADER_ID                   IN HRM_HISTORY_LINE.HISTORY_HEADER_ID%TYPE
          , P_HISTORY_NUM                         IN HRM_HISTORY_LINE.HISTORY_NUM%TYPE
          , P_PERSON_ID                           IN HRM_HISTORY_LINE.PERSON_ID%TYPE
          , P_CHARGE_DATE                         IN HRM_HISTORY_LINE.CHARGE_DATE%TYPE
          , P_CHARGE_ID                           IN HRM_HISTORY_LINE.CHARGE_ID%TYPE
          , P_RETIRE_ID                           IN HRM_HISTORY_LINE.RETIRE_ID%TYPE
          , P_OPERATING_UNIT_ID                   IN HRM_HISTORY_LINE.OPERATING_UNIT_ID%TYPE
          , P_DEPT_ID                             IN HRM_HISTORY_LINE.DEPT_ID%TYPE
          , P_JOB_CLASS_ID                        IN HRM_HISTORY_LINE.JOB_CLASS_ID%TYPE
          , P_JOB_ID                              IN HRM_HISTORY_LINE.JOB_ID%TYPE
          , P_POST_ID                             IN HRM_HISTORY_LINE.POST_ID%TYPE
          , P_OCPT_ID                             IN HRM_HISTORY_LINE.OCPT_ID%TYPE
          , P_ABIL_ID                             IN HRM_HISTORY_LINE.ABIL_ID%TYPE
          , P_PAY_GRADE_ID                        IN HRM_HISTORY_LINE.PAY_GRADE_ID%TYPE
          , P_JOB_CATEGORY_ID                     IN HRM_HISTORY_LINE.JOB_CATEGORY_ID%TYPE
          , P_FLOOR_ID                            IN HRM_HISTORY_LINE.FLOOR_ID%TYPE
          , P_PRE_OPERATING_UNIT_ID               IN HRM_HISTORY_LINE.PRE_OPERATING_UNIT_ID%TYPE
          , P_PRE_DEPT_ID                         IN HRM_HISTORY_LINE.PRE_DEPT_ID%TYPE
          , P_PRE_JOB_CLASS_ID                    IN HRM_HISTORY_LINE.PRE_JOB_CLASS_ID%TYPE
          , P_PRE_JOB_ID                          IN HRM_HISTORY_LINE.PRE_JOB_ID%TYPE
          , P_PRE_POST_ID                         IN HRM_HISTORY_LINE.PRE_POST_ID%TYPE
          , P_PRE_OCPT_ID                         IN HRM_HISTORY_LINE.PRE_OCPT_ID%TYPE
          , P_PRE_ABIL_ID                         IN HRM_HISTORY_LINE.PRE_ABIL_ID%TYPE
          , P_PRE_PAY_GRADE_ID                    IN HRM_HISTORY_LINE.PRE_PAY_GRADE_ID%TYPE
          , P_PRE_JOB_CATEGORY_ID                 IN HRM_HISTORY_LINE.PRE_JOB_CATEGORY_ID%TYPE
          , P_PRE_FLOOR_ID                        IN HRM_HISTORY_LINE.FLOOR_ID%TYPE
          , P_PRINT_YN                            IN HRM_HISTORY_LINE.PRINT_YN%TYPE
          , P_DESCRIPTION                         IN HRM_HISTORY_LINE.DESCRIPTION%TYPE
          , P_USER_ID                             IN HRM_HISTORY_LINE.CREATED_BY%TYPE
          , O_HISTORY_LINE_ID                     OUT HRM_HISTORY_LINE.HISTORY_LINE_ID%TYPE
          , P_INTERFACE_FLAG                      IN VARCHAR2 DEFAULT 'N'
          );

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE
           ( W_HISTORY_LINE_ID                     IN HRM_HISTORY_LINE.HISTORY_LINE_ID%TYPE
          , P_PERSON_ID                           IN HRM_HISTORY_LINE.PERSON_ID%TYPE
          , P_CHARGE_DATE                         IN HRM_HISTORY_LINE.CHARGE_DATE%TYPE
          , P_CHARGE_ID                           IN HRM_HISTORY_LINE.CHARGE_ID%TYPE
          , P_RETIRE_ID                           IN HRM_HISTORY_LINE.RETIRE_ID%TYPE
          , P_OPERATING_UNIT_ID                   IN HRM_HISTORY_LINE.OPERATING_UNIT_ID%TYPE
          , P_DEPT_ID                             IN HRM_HISTORY_LINE.DEPT_ID%TYPE
          , P_JOB_CLASS_ID                        IN HRM_HISTORY_LINE.JOB_CLASS_ID%TYPE
          , P_JOB_ID                              IN HRM_HISTORY_LINE.JOB_ID%TYPE
          , P_POST_ID                             IN HRM_HISTORY_LINE.POST_ID%TYPE
          , P_OCPT_ID                             IN HRM_HISTORY_LINE.OCPT_ID%TYPE
          , P_ABIL_ID                             IN HRM_HISTORY_LINE.ABIL_ID%TYPE
          , P_PAY_GRADE_ID                        IN HRM_HISTORY_LINE.PAY_GRADE_ID%TYPE
          , P_JOB_CATEGORY_ID                     IN HRM_HISTORY_LINE.JOB_CATEGORY_ID%TYPE
          , P_FLOOR_ID                            IN HRM_HISTORY_LINE.FLOOR_ID%TYPE
          , P_PRE_OPERATING_UNIT_ID               IN HRM_HISTORY_LINE.PRE_OPERATING_UNIT_ID%TYPE
          , P_PRE_DEPT_ID                         IN HRM_HISTORY_LINE.PRE_DEPT_ID%TYPE
          , P_PRE_JOB_CLASS_ID                    IN HRM_HISTORY_LINE.PRE_JOB_CLASS_ID%TYPE
          , P_PRE_JOB_ID                          IN HRM_HISTORY_LINE.PRE_JOB_ID%TYPE
          , P_PRE_POST_ID                         IN HRM_HISTORY_LINE.PRE_POST_ID%TYPE
          , P_PRE_OCPT_ID                         IN HRM_HISTORY_LINE.PRE_OCPT_ID%TYPE
          , P_PRE_ABIL_ID                         IN HRM_HISTORY_LINE.PRE_ABIL_ID%TYPE
          , P_PRE_PAY_GRADE_ID                    IN HRM_HISTORY_LINE.PRE_PAY_GRADE_ID%TYPE
          , P_PRE_JOB_CATEGORY_ID                 IN HRM_HISTORY_LINE.PRE_JOB_CATEGORY_ID%TYPE
          , P_PRE_FLOOR_ID                        IN HRM_HISTORY_LINE.FLOOR_ID%TYPE
          , P_PRINT_YN                            IN HRM_HISTORY_LINE.PRINT_YN%TYPE
          , P_DESCRIPTION                         IN HRM_HISTORY_LINE.DESCRIPTION%TYPE
          , P_USER_ID                             IN HRM_HISTORY_LINE.CREATED_BY%TYPE
          , P_INTERFACE_FLAG                      IN VARCHAR2 DEFAULT 'N'
          );
      
-- DATA_DELETE..
  PROCEDURE DATA_DELETE
           ( W_HISTORY_LINE_ID                     IN HRM_HISTORY_LINE.HISTORY_LINE_ID%TYPE
           , P_INTERFACE_FLAG                      IN VARCHAR2 DEFAULT 'N'
           );


----------------------------------------------------------------------------------------
-- 근태 작업장변경에서 데이터 변경시 인사발령 데이터 반영 --
  PROCEDURE INTERFACE_INSERT_HISTORY
           (  P_HISTORY_LINE_ID                     OUT HRM_HISTORY_LINE.HISTORY_LINE_ID%TYPE
            , P_PERSON_ID                           IN HRM_HISTORY_LINE.PERSON_ID%TYPE
            , P_SOB_ID                              IN NUMBER
            , P_ORG_ID                              IN NUMBER
            , P_CHARGE_DATE                         IN HRM_HISTORY_LINE.CHARGE_DATE%TYPE
            , P_CHARGE_ID                           IN HRM_HISTORY_LINE.CHARGE_ID%TYPE
            , P_RETIRE_ID                           IN HRM_HISTORY_LINE.RETIRE_ID%TYPE
            , P_OPERATING_UNIT_ID                   IN HRM_HISTORY_LINE.OPERATING_UNIT_ID%TYPE
            , P_DEPT_ID                             IN HRM_HISTORY_LINE.DEPT_ID%TYPE
            , P_JOB_CLASS_ID                        IN HRM_HISTORY_LINE.JOB_CLASS_ID%TYPE
            , P_JOB_ID                              IN HRM_HISTORY_LINE.JOB_ID%TYPE
            , P_POST_ID                             IN HRM_HISTORY_LINE.POST_ID%TYPE
            , P_OCPT_ID                             IN HRM_HISTORY_LINE.OCPT_ID%TYPE
            , P_ABIL_ID                             IN HRM_HISTORY_LINE.ABIL_ID%TYPE
            , P_PAY_GRADE_ID                        IN HRM_HISTORY_LINE.PAY_GRADE_ID%TYPE
            , P_JOB_CATEGORY_ID                     IN HRM_HISTORY_LINE.JOB_CATEGORY_ID%TYPE
            , P_FLOOR_ID                            IN HRM_HISTORY_LINE.FLOOR_ID%TYPE            
            , P_PRINT_YN                            IN HRM_HISTORY_LINE.PRINT_YN%TYPE
            , P_DESCRIPTION                         IN HRM_HISTORY_LINE.DESCRIPTION%TYPE
            , P_USER_ID                             IN HRM_HISTORY_LINE.CREATED_BY%TYPE
            , O_STATUS                              OUT VARCHAR2
            , O_MESSAGE                             OUT VARCHAR2
            );

-- 근태 작업장변경에서 데이터 변경시 인사발령 데이터 반영 --
  PROCEDURE INTERFACE_UPDATE_HISTORY
           ( W_HISTORY_LINE_ID                     IN HRM_HISTORY_LINE.HISTORY_LINE_ID%TYPE
            , P_PERSON_ID                           IN HRM_HISTORY_LINE.PERSON_ID%TYPE
            , P_CHARGE_DATE                         IN HRM_HISTORY_LINE.CHARGE_DATE%TYPE
            , P_CHARGE_ID                           IN HRM_HISTORY_LINE.CHARGE_ID%TYPE
            , P_RETIRE_ID                           IN HRM_HISTORY_LINE.RETIRE_ID%TYPE
            , P_OPERATING_UNIT_ID                   IN HRM_HISTORY_LINE.OPERATING_UNIT_ID%TYPE
            , P_DEPT_ID                             IN HRM_HISTORY_LINE.DEPT_ID%TYPE
            , P_JOB_CLASS_ID                        IN HRM_HISTORY_LINE.JOB_CLASS_ID%TYPE
            , P_JOB_ID                              IN HRM_HISTORY_LINE.JOB_ID%TYPE
            , P_POST_ID                             IN HRM_HISTORY_LINE.POST_ID%TYPE
            , P_OCPT_ID                             IN HRM_HISTORY_LINE.OCPT_ID%TYPE
            , P_ABIL_ID                             IN HRM_HISTORY_LINE.ABIL_ID%TYPE
            , P_PAY_GRADE_ID                        IN HRM_HISTORY_LINE.PAY_GRADE_ID%TYPE
            , P_JOB_CATEGORY_ID                     IN HRM_HISTORY_LINE.JOB_CATEGORY_ID%TYPE
            , P_FLOOR_ID                            IN HRM_HISTORY_LINE.FLOOR_ID%TYPE            
            , P_PRINT_YN                            IN HRM_HISTORY_LINE.PRINT_YN%TYPE
            , P_DESCRIPTION                         IN HRM_HISTORY_LINE.DESCRIPTION%TYPE
            , P_USER_ID                             IN HRM_HISTORY_LINE.CREATED_BY%TYPE
            , O_STATUS                              OUT VARCHAR2
            , O_MESSAGE                             OUT VARCHAR2
            );
      
-- 근태 작업장 변경에서 인사발령 반영 --
  PROCEDURE INTERFACE_DELETE_HISTORY
           ( W_HISTORY_LINE_ID                     IN HRM_HISTORY_LINE.HISTORY_LINE_ID%TYPE
           , O_STATUS                              OUT VARCHAR2
           , O_MESSAGE                             OUT VARCHAR2
           );
           

-- 최종 발령사항인지 체크.
  FUNCTION LAST_HISTORY_CHECK
          ( W_PERSON_ID                            IN NUMBER
           , W_CHARGE_DATE                          IN DATE
           ) RETURN BOOLEAN;


-- 발령에 따른 재직구분 체크.
  FUNCTION CHARGE_EMPLOYE_TYPE
          ( P_CHARGE_ID                            IN NUMBER
           , W_CHARGE_DATE                          IN DATE
           ) RETURN VARCHAR2;

-- 개인의 발령사항 조회.
  PROCEDURE DATA_SELECT_PERSON
           (  P_CURSOR2                             OUT TYPES.TCURSOR2
            , W_PERSON_ID                           IN HRM_HISTORY_LINE.PERSON_ID%TYPE
            );
                  

-- 인쇄 : 개인의 발령사항 조회.
  PROCEDURE PRINT_PERSON_HISTORY
           (  P_CURSOR2                             OUT TYPES.TCURSOR2
            , W_PERSON_ID                           IN  HRM_HISTORY_LINE.PERSON_ID%TYPE
            , W_SOB_ID                              IN  NUMBER
            , W_ORG_ID                              IN  NUMBER
            );
            

-- [2011-12-22]추가
   PROCEDURE SELECT_DATA
           ( P_CURSOR             OUT TYPES.TCURSOR
           , W_HISTORY_HEADER_ID  IN  HRM_HISTORY_LINE.HISTORY_HEADER_ID%TYPE
           , W_CORP_ID            IN  HRM_HISTORY_HEADER.CORP_ID%TYPE
           , W_DEPT_ID            IN  HRM_HISTORY_LINE.DEPT_ID%TYPE
           , W_PERSON_ID          IN  HRM_HISTORY_LINE.PERSON_ID%TYPE
           );

-- 인사발령현황 
  PROCEDURE SELECT_HISTORY_CURRENT( P_CURSOR            OUT TYPES.TCURSOR
                                  , W_CORP_ID           IN  NUMBER
                                  , W_START_DATE        IN  DATE
                                  , W_END_DATE          IN  DATE
                                  , W_DEPT_ID           IN  NUMBER
                                  , W_FLOOR_ID          IN  NUMBER
                                  , W_PERSON_ID         IN  NUMBER
                                  , W_SOB_ID            IN  NUMBER
                                  , W_ORG_ID            IN  NUMBER);
                                  
END HRM_HISTORY_LINE_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRM_HISTORY_LINE_G
AS

-- DATA_SELECT.
   PROCEDURE DATA_SELECT
           ( P_CURSOR             OUT TYPES.TCURSOR
           , W_HISTORY_HEADER_ID  IN  HRM_HISTORY_LINE.HISTORY_HEADER_ID%TYPE
           , W_DEPT_ID            IN  HRM_HISTORY_LINE.DEPT_ID%TYPE
           , W_PERSON_ID          IN  HRM_HISTORY_LINE.PERSON_ID%TYPE
           )

   AS

   BEGIN
             OPEN P_CURSOR FOR
             SELECT HL.HISTORY_LINE_ID
                  , HL.HISTORY_HEADER_ID
                  , HL.HISTORY_NUM
                  , HL.PERSON_ID
                  , PM.NAME
                  , PM.PERSON_NUM
                  , HL.CHARGE_DATE
                  , HL.CHARGE_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.CHARGE_ID) AS CHARGE_NAME
                  , HL.DESCRIPTION
                  , HL.RETIRE_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.RETIRE_ID) AS RETIRE_NAME
                  -- 발령사항.
                  , HL.OPERATING_UNIT_ID
                  , HRM_OPERATING_UNIT_G.OPERATING_UNIT_NAME_F(HL.OPERATING_UNIT_ID) AS OPERATING_UNIT_NAME
                  , HL.DEPT_ID
                  , DM.DEPT_NAME
                  , HL.JOB_CLASS_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.JOB_CLASS_ID) AS JOB_CLASS_NAME
                  , HL.JOB_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.JOB_ID) AS JOB_NAME
                  , HL.POST_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
                  , HL.OCPT_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.OCPT_ID) AS OCPT_NAME
                  , HL.ABIL_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.ABIL_ID) AS ABIL_NAME
                  , HL.PAY_GRADE_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.PAY_GRADE_ID) AS PAY_GRADE_NAME
                  , HL.JOB_CATEGORY_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                  , HL.FLOOR_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.FLOOR_ID) AS FLOOR_NAME
                  -- 발령전 사항.
                  , HL.PRE_OPERATING_UNIT_ID
                  , HRM_OPERATING_UNIT_G.OPERATING_UNIT_NAME_F(HL.PRE_OPERATING_UNIT_ID) AS PRE_OPERATING_UNIT_NAME
                  , HL.PRE_DEPT_ID
                  , P_DM.DEPT_NAME AS PRE_DEPT_NAME
                  , HL.PRE_JOB_CLASS_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.PRE_JOB_CLASS_ID) AS PRE_JOB_CLASS_NAME
                  , HL.PRE_JOB_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.PRE_JOB_ID) AS PRE_JOB_NAME
                  , HL.PRE_POST_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.PRE_POST_ID) AS PRE_POST_NAME
                  , HL.PRE_OCPT_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.PRE_OCPT_ID) AS PRE_OCPT_NAME
                  , HL.PRE_ABIL_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.PRE_ABIL_ID) AS PRE_ABIL_NAME
                  , HL.PRE_PAY_GRADE_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.PRE_PAY_GRADE_ID) AS PRE_PAY_GRADE_NAME
                  , HL.PRE_JOB_CATEGORY_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.PRE_JOB_CATEGORY_ID) AS PRE_JOB_CATEGORY_NAME
                  , HL.PRE_FLOOR_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.PRE_FLOOR_ID) AS PRE_FLOOR_NAME
                  , HL.PRINT_YN
                  , PM.ORI_JOIN_DATE
                  , PM.RETIRE_DATE
               FROM HRM_HISTORY_LINE         HL
                  , HRM_PERSON_MASTER        PM
                  , HRM_DEPT_MASTER          DM
                  , HRM_DEPT_MASTER          P_DM
              WHERE HL.PERSON_ID          =  PM.PERSON_ID
                AND HL.DEPT_ID            =  DM.DEPT_ID
                AND HL.PRE_DEPT_ID        =  P_DM.DEPT_ID
                AND HL.HISTORY_HEADER_ID  =  NVL(W_HISTORY_HEADER_ID, HL.HISTORY_HEADER_ID)
                AND PM.DEPT_ID            =  NVL(W_DEPT_ID, PM.DEPT_ID)
                AND HL.PERSON_ID          =  NVL(W_PERSON_ID, HL.PERSON_ID)
           ORDER BY HL.CHARGE_DATE
                  , PM.NAME
                  , HL.CHARGE_ID
                  , HL.PERSON_ID
                  ;

   END DATA_SELECT;


-- DATA_INSERT.
  PROCEDURE DATA_INSERT
           ( P_HISTORY_HEADER_ID                   IN HRM_HISTORY_LINE.HISTORY_HEADER_ID%TYPE
          , P_HISTORY_NUM                         IN HRM_HISTORY_LINE.HISTORY_NUM%TYPE
          , P_PERSON_ID                           IN HRM_HISTORY_LINE.PERSON_ID%TYPE
          , P_CHARGE_DATE                         IN HRM_HISTORY_LINE.CHARGE_DATE%TYPE
          , P_CHARGE_ID                           IN HRM_HISTORY_LINE.CHARGE_ID%TYPE
          , P_RETIRE_ID                           IN HRM_HISTORY_LINE.RETIRE_ID%TYPE
          , P_OPERATING_UNIT_ID                   IN HRM_HISTORY_LINE.OPERATING_UNIT_ID%TYPE
          , P_DEPT_ID                             IN HRM_HISTORY_LINE.DEPT_ID%TYPE
          , P_JOB_CLASS_ID                        IN HRM_HISTORY_LINE.JOB_CLASS_ID%TYPE
          , P_JOB_ID                              IN HRM_HISTORY_LINE.JOB_ID%TYPE
          , P_POST_ID                             IN HRM_HISTORY_LINE.POST_ID%TYPE
          , P_OCPT_ID                             IN HRM_HISTORY_LINE.OCPT_ID%TYPE
          , P_ABIL_ID                             IN HRM_HISTORY_LINE.ABIL_ID%TYPE
          , P_PAY_GRADE_ID                        IN HRM_HISTORY_LINE.PAY_GRADE_ID%TYPE
          , P_JOB_CATEGORY_ID                     IN HRM_HISTORY_LINE.JOB_CATEGORY_ID%TYPE
          , P_FLOOR_ID                            IN HRM_HISTORY_LINE.FLOOR_ID%TYPE
          , P_PRE_OPERATING_UNIT_ID               IN HRM_HISTORY_LINE.PRE_OPERATING_UNIT_ID%TYPE
          , P_PRE_DEPT_ID                         IN HRM_HISTORY_LINE.PRE_DEPT_ID%TYPE
          , P_PRE_JOB_CLASS_ID                    IN HRM_HISTORY_LINE.PRE_JOB_CLASS_ID%TYPE
          , P_PRE_JOB_ID                          IN HRM_HISTORY_LINE.PRE_JOB_ID%TYPE
          , P_PRE_POST_ID                         IN HRM_HISTORY_LINE.PRE_POST_ID%TYPE
          , P_PRE_OCPT_ID                         IN HRM_HISTORY_LINE.PRE_OCPT_ID%TYPE
          , P_PRE_ABIL_ID                         IN HRM_HISTORY_LINE.PRE_ABIL_ID%TYPE
          , P_PRE_PAY_GRADE_ID                    IN HRM_HISTORY_LINE.PRE_PAY_GRADE_ID%TYPE
          , P_PRE_JOB_CATEGORY_ID                 IN HRM_HISTORY_LINE.PRE_JOB_CATEGORY_ID%TYPE
          , P_PRE_FLOOR_ID                        IN HRM_HISTORY_LINE.FLOOR_ID%TYPE
          , P_PRINT_YN                            IN HRM_HISTORY_LINE.PRINT_YN%TYPE
          , P_DESCRIPTION                         IN HRM_HISTORY_LINE.DESCRIPTION%TYPE
          , P_USER_ID                             IN HRM_HISTORY_LINE.CREATED_BY%TYPE
          , O_HISTORY_LINE_ID                     OUT HRM_HISTORY_LINE.HISTORY_LINE_ID%TYPE
          , P_INTERFACE_FLAG                      IN VARCHAR2 DEFAULT 'N'  -- 작업장변경에서 데이터 제어하는지 체크  -- 
          )
  AS
    N_HISTORY_LINE_ID                     NUMBER := 0;
    V_CHARGE_DATE                         HRM_HISTORY_LINE.CHARGE_DATE%TYPE;
    V_CHARGE_ID                           HRM_HISTORY_LINE.CHARGE_ID%TYPE; 
    V_SOB_ID                              NUMBER;
    V_ORG_ID                              NUMBER;
    
    V_STATUS                              VARCHAR2(2);
  BEGIN
    V_CHARGE_DATE := P_CHARGE_DATE;
    V_CHARGE_ID   := P_CHARGE_ID;
    BEGIN
      SELECT HH.CHARGE_DATE
           , HH.CHARGE_ID
           , HH.SOB_ID
           , HH.ORG_ID
        INTO V_CHARGE_DATE
           , V_CHARGE_ID
           , V_SOB_ID
           , V_ORG_ID
        FROM HRM_HISTORY_HEADER HH
       WHERE HH.HISTORY_HEADER_ID   = P_HISTORY_HEADER_ID
      ;  
    EXCEPTION WHEN OTHERS THEN
      V_CHARGE_DATE := P_CHARGE_DATE;
      V_CHARGE_ID   := P_CHARGE_ID;
      V_SOB_ID      := 10;
      V_ORG_ID      := 101;
    END;
    
    SELECT HRM_HISTORY_LINE_S1.NEXTVAL
     INTO N_HISTORY_LINE_ID
    FROM DUAL;
    
    -- 인사발령 사항.
    INSERT INTO HRM_HISTORY_LINE
    (HISTORY_LINE_ID
    , HISTORY_HEADER_ID, HISTORY_NUM
    , PERSON_ID, CHARGE_DATE, CHARGE_ID, RETIRE_ID
    -- 발령사항.
    , OPERATING_UNIT_ID, DEPT_ID, JOB_CLASS_ID
    , JOB_ID, POST_ID, OCPT_ID
    , ABIL_ID, PAY_GRADE_ID, JOB_CATEGORY_ID, FLOOR_ID
    -- 발령전 사항.
    , PRE_OPERATING_UNIT_ID, PRE_DEPT_ID, PRE_JOB_CLASS_ID
    , PRE_JOB_ID, PRE_POST_ID, PRE_OCPT_ID
    , PRE_ABIL_ID, PRE_PAY_GRADE_ID, PRE_JOB_CATEGORY_ID, PRE_FLOOR_ID
    , PRINT_YN
    , DESCRIPTION
    , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
    ) VALUES
    ( N_HISTORY_LINE_ID
    , P_HISTORY_HEADER_ID, P_HISTORY_NUM
    , P_PERSON_ID, TRUNC(V_CHARGE_DATE), V_CHARGE_ID, P_RETIRE_ID
    -- 발령사항.
    , P_OPERATING_UNIT_ID, P_DEPT_ID, P_JOB_CLASS_ID
    , P_JOB_ID, P_POST_ID, P_OCPT_ID
    , P_ABIL_ID, P_PAY_GRADE_ID, P_JOB_CATEGORY_ID, P_FLOOR_ID
    -- 발령전 사항.
    , P_PRE_OPERATING_UNIT_ID, P_PRE_DEPT_ID, P_PRE_JOB_CLASS_ID
    , P_PRE_JOB_ID, P_PRE_POST_ID, P_PRE_OCPT_ID
    , P_PRE_ABIL_ID, P_PRE_PAY_GRADE_ID, P_PRE_JOB_CATEGORY_ID, P_PRE_FLOOR_ID
    , P_PRINT_YN
    , P_DESCRIPTION
    , SYSDATE, P_USER_ID, SYSDATE, P_USER_ID
    );    
    O_HISTORY_LINE_ID := N_HISTORY_LINE_ID;
    
    -- [2013-07-28 전호수 추가 - 조선미S 요청 ]근태작업장 및 교대유형 변경 반영 --
    -- [작업장 및 부서변경시만 반영함] --
    IF NVL(P_INTERFACE_FLAG, 'N') != 'Y' AND (P_FLOOR_ID != P_PRE_FLOOR_ID OR P_DEPT_ID != P_PRE_DEPT_ID) THEN
      HRD_PERSON_HISTORY_G.INTERFACE_PERSON_HISTORY
        ( P_CHARGE_DATE       => TRUNC(V_CHARGE_DATE)
        , P_PERSON_ID         => P_PERSON_ID
        , P_DEPT_ID           => P_DEPT_ID
        , P_FLOOR_ID          => P_FLOOR_ID
        , P_DESCRIPTION       => P_DESCRIPTION
        , P_SOB_ID            => V_SOB_ID
        , P_ORG_ID            => V_ORG_ID
        , P_USER_ID           => P_USER_ID
        , P_HISTORY_LINE_ID   => O_HISTORY_LINE_ID
        , O_STATUS            => V_STATUS
        );
    END IF;    
    
    -- 인사내역 반영.
		UPDATE HRM_PERSON_MASTER PM
			SET PM.OPERATING_UNIT_ID                                 = P_OPERATING_UNIT_ID
				, PM.DEPT_ID                                           = P_DEPT_ID
				, PM.JOB_CLASS_ID                                      = P_JOB_CLASS_ID
				, PM.JOB_ID                                            = P_JOB_ID
				, PM.POST_ID                                           = P_POST_ID
				, PM.OCPT_ID                                           = P_OCPT_ID
				, PM.ABIL_ID                                           = P_ABIL_ID
				, PM.PAY_GRADE_ID                                      = P_PAY_GRADE_ID
				, PM.JOB_CATEGORY_ID                                   = P_JOB_CATEGORY_ID
				, PM.FLOOR_ID                                          = P_FLOOR_ID
		WHERE PM.PERSON_ID                                         = P_PERSON_ID
		; 
    
  END DATA_INSERT;

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE
           ( W_HISTORY_LINE_ID                     IN HRM_HISTORY_LINE.HISTORY_LINE_ID%TYPE
            , P_PERSON_ID                           IN HRM_HISTORY_LINE.PERSON_ID%TYPE
            , P_CHARGE_DATE                         IN HRM_HISTORY_LINE.CHARGE_DATE%TYPE
            , P_CHARGE_ID                           IN HRM_HISTORY_LINE.CHARGE_ID%TYPE
            , P_RETIRE_ID                           IN HRM_HISTORY_LINE.RETIRE_ID%TYPE
            , P_OPERATING_UNIT_ID                   IN HRM_HISTORY_LINE.OPERATING_UNIT_ID%TYPE
            , P_DEPT_ID                             IN HRM_HISTORY_LINE.DEPT_ID%TYPE
            , P_JOB_CLASS_ID                        IN HRM_HISTORY_LINE.JOB_CLASS_ID%TYPE
            , P_JOB_ID                              IN HRM_HISTORY_LINE.JOB_ID%TYPE
            , P_POST_ID                             IN HRM_HISTORY_LINE.POST_ID%TYPE
            , P_OCPT_ID                             IN HRM_HISTORY_LINE.OCPT_ID%TYPE
            , P_ABIL_ID                             IN HRM_HISTORY_LINE.ABIL_ID%TYPE
            , P_PAY_GRADE_ID                        IN HRM_HISTORY_LINE.PAY_GRADE_ID%TYPE
            , P_JOB_CATEGORY_ID                     IN HRM_HISTORY_LINE.JOB_CATEGORY_ID%TYPE
            , P_FLOOR_ID                            IN HRM_HISTORY_LINE.FLOOR_ID%TYPE
            , P_PRE_OPERATING_UNIT_ID               IN HRM_HISTORY_LINE.PRE_OPERATING_UNIT_ID%TYPE
            , P_PRE_DEPT_ID                         IN HRM_HISTORY_LINE.PRE_DEPT_ID%TYPE
            , P_PRE_JOB_CLASS_ID                    IN HRM_HISTORY_LINE.PRE_JOB_CLASS_ID%TYPE
            , P_PRE_JOB_ID                          IN HRM_HISTORY_LINE.PRE_JOB_ID%TYPE
            , P_PRE_POST_ID                         IN HRM_HISTORY_LINE.PRE_POST_ID%TYPE
            , P_PRE_OCPT_ID                         IN HRM_HISTORY_LINE.PRE_OCPT_ID%TYPE
            , P_PRE_ABIL_ID                         IN HRM_HISTORY_LINE.PRE_ABIL_ID%TYPE
            , P_PRE_PAY_GRADE_ID                    IN HRM_HISTORY_LINE.PRE_PAY_GRADE_ID%TYPE
            , P_PRE_JOB_CATEGORY_ID                 IN HRM_HISTORY_LINE.PRE_JOB_CATEGORY_ID%TYPE
            , P_PRE_FLOOR_ID                        IN HRM_HISTORY_LINE.FLOOR_ID%TYPE
            , P_PRINT_YN                            IN HRM_HISTORY_LINE.PRINT_YN%TYPE
            , P_DESCRIPTION                         IN HRM_HISTORY_LINE.DESCRIPTION%TYPE
            , P_USER_ID                             IN HRM_HISTORY_LINE.CREATED_BY%TYPE
            , P_INTERFACE_FLAG                      IN VARCHAR2 DEFAULT 'N'  -- 작업장변경에서 데이터 제어하는지 체크  -- 
            )
  AS
    V_CHARGE_DATE                         HRM_HISTORY_LINE.CHARGE_DATE%TYPE;
    V_CHARGE_ID                           HRM_HISTORY_LINE.CHARGE_ID%TYPE; 
    
    V_SOB_ID                              NUMBER;
    V_ORG_ID                              NUMBER;
    
    V_STATUS                              VARCHAR2(2);
  BEGIN
    V_CHARGE_DATE := P_CHARGE_DATE;
    V_CHARGE_ID   := P_CHARGE_ID;
    BEGIN
      SELECT HH.CHARGE_DATE
           , HH.CHARGE_ID
           , HH.SOB_ID
           , HH.ORG_ID
        INTO V_CHARGE_DATE
           , V_CHARGE_ID
           , V_SOB_ID
           , V_ORG_ID
        FROM HRM_HISTORY_HEADER HH
           , HRM_HISTORY_LINE   HL
       WHERE HH.HISTORY_HEADER_ID   = HL.HISTORY_HEADER_ID
         AND HL.HISTORY_LINE_ID     = W_HISTORY_LINE_ID
      ;  
    EXCEPTION WHEN OTHERS THEN
      V_CHARGE_DATE := P_CHARGE_DATE;
      V_CHARGE_ID   := P_CHARGE_ID;
      V_SOB_ID      := 10;
      V_ORG_ID      := 101;
    END;
    
    -- 최종 발령 인지 체크 -- 
    IF HRM_HISTORY_LINE_G.LAST_HISTORY_CHECK(P_PERSON_ID, P_CHARGE_DATE) = FALSE THEN
     RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10030', NULL));
     RETURN;
    END IF;
    
    -- 인사발령 사항.
    UPDATE HRM_HISTORY_LINE HL
     SET HL.PERSON_ID                                                = P_PERSON_ID
      , HL.CHARGE_DATE                                              = TRUNC(V_CHARGE_DATE)
      , HL.CHARGE_ID                                                = V_CHARGE_ID
      , HL.RETIRE_ID                                                = P_RETIRE_ID
      -- 발령사항.
      , HL.OPERATING_UNIT_ID                                        = P_OPERATING_UNIT_ID
      , HL.DEPT_ID                                                  = P_DEPT_ID
      , HL.JOB_CLASS_ID                                             = P_JOB_CLASS_ID
      , HL.JOB_ID                                                   = P_JOB_ID
      , HL.POST_ID                                                  = P_POST_ID
      , HL.OCPT_ID                                                  = P_OCPT_ID
      , HL.ABIL_ID                                                  = P_ABIL_ID
      , HL.PAY_GRADE_ID                                             = P_PAY_GRADE_ID
      , HL.JOB_CATEGORY_ID                                          = P_JOB_CATEGORY_ID
      , HL.FLOOR_ID                                                 = P_FLOOR_ID
      -- 발령전 사항.
      , HL.PRE_OPERATING_UNIT_ID                                    = P_PRE_OPERATING_UNIT_ID
      , HL.PRE_DEPT_ID                                              = P_PRE_DEPT_ID
      , HL.PRE_JOB_CLASS_ID                                         = P_PRE_JOB_CLASS_ID
      , HL.PRE_JOB_ID                                               = P_PRE_JOB_ID
      , HL.PRE_POST_ID                                              = P_PRE_POST_ID
      , HL.PRE_OCPT_ID                                              = P_PRE_OCPT_ID
      , HL.PRE_ABIL_ID                                              = P_PRE_ABIL_ID
      , HL.PRE_PAY_GRADE_ID                                         = P_PRE_PAY_GRADE_ID
      , HL.PRE_JOB_CATEGORY_ID                                      = P_PRE_JOB_CATEGORY_ID
      , HL.PRE_FLOOR_ID                                             = P_PRE_FLOOR_ID
      , HL.PRINT_YN                                                 = P_PRINT_YN
      , HL.DESCRIPTION                                              = P_DESCRIPTION
      , HL.LAST_UPDATE_DATE                                         = SYSDATE
      , HL.LAST_UPDATED_BY                                          = P_USER_ID
    WHERE HL.HISTORY_LINE_ID                                          = W_HISTORY_LINE_ID
    ;
    
    -- [2013-07-28 전호수 추가 - 조선미S 요청 ]근태작업장 및 교대유형 변경 반영 --
    -- [작업장 및 부서변경시만 반영함] --
    IF NVL(P_INTERFACE_FLAG, 'N') != 'Y' AND (P_FLOOR_ID != P_PRE_FLOOR_ID OR P_DEPT_ID != P_PRE_DEPT_ID) THEN
      HRD_PERSON_HISTORY_G.INTERFACE_PERSON_HISTORY
        ( P_CHARGE_DATE       => TRUNC(V_CHARGE_DATE)
        , P_PERSON_ID         => P_PERSON_ID
        , P_DEPT_ID           => P_DEPT_ID
        , P_FLOOR_ID          => P_FLOOR_ID
        , P_DESCRIPTION       => P_DESCRIPTION
        , P_SOB_ID            => V_SOB_ID
        , P_ORG_ID            => V_ORG_ID
        , P_USER_ID           => P_USER_ID
        , P_HISTORY_LINE_ID   => W_HISTORY_LINE_ID
        , O_STATUS            => V_STATUS
        );
    END IF; 
    
    -- 인사내역 반영.
		UPDATE HRM_PERSON_MASTER PM
			SET PM.OPERATING_UNIT_ID                                      = P_OPERATING_UNIT_ID
				, PM.DEPT_ID                                                = P_DEPT_ID
				, PM.JOB_CLASS_ID                                           = P_JOB_CLASS_ID
				, PM.JOB_ID                                                 = P_JOB_ID
				, PM.POST_ID                                                = P_POST_ID
				, PM.OCPT_ID                                                = P_OCPT_ID
				, PM.ABIL_ID                                                = P_ABIL_ID
				, PM.PAY_GRADE_ID                                           = P_PAY_GRADE_ID
				, PM.JOB_CATEGORY_ID                                        = P_JOB_CATEGORY_ID
				, PM.FLOOR_ID                                               = P_FLOOR_ID
		WHERE PM.PERSON_ID                                              = P_PERSON_ID
		;
  END DATA_UPDATE;

-- DATA_DELETE..
  PROCEDURE DATA_DELETE
           ( W_HISTORY_LINE_ID                   IN HRM_HISTORY_LINE.HISTORY_LINE_ID%TYPE
           , P_INTERFACE_FLAG                    IN VARCHAR2 DEFAULT 'N'  -- 작업장변경에서 데이터 제어하는지 체크  -- 
           )
  AS
    N_PERSON_ID         NUMBER;
    D_CHARGE_DATE       DATE;
    V_NEWCOMER_YN       VARCHAR2(1);                   
    V_SOB_ID            NUMBER;
    V_ORG_ID            NUMBER;
    
    V_STATUS            VARCHAR2(10);
  BEGIN
    BEGIN
     SELECT HL.PERSON_ID
          , HH.CHARGE_DATE
          , NVL(CCV.NEWCOMER_YN, 'N') AS NEWCOMER_YN
          , HH.SOB_ID
          , HH.ORG_ID          
      INTO N_PERSON_ID
         , D_CHARGE_DATE
         , V_NEWCOMER_YN
         , V_SOB_ID
         , V_ORG_ID
     FROM HRM_HISTORY_HEADER HH
        , HRM_HISTORY_LINE   HL 
        , HRM_CHARGE_CODE_V  CCV
     WHERE HH.HISTORY_HEADER_ID         = HL.HISTORY_HEADER_ID
       AND HL.CHARGE_ID                 = CCV.COMMON_ID
       AND HL.HISTORY_LINE_ID           = W_HISTORY_LINE_ID
     ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, SUBSTR(SQLERRM, 1, 150));
      RETURN;
    END;
    -- 최종 발령 인지 체크 --
    --[FCM_10030]해당 발령사항은 수정/삭제 할 수 없습니다.
    IF N_PERSON_ID = -1 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10030', NULL));
     RETURN;
    ELSIF V_NEWCOMER_YN = 'Y' THEN
     RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10030', NULL));
     RETURN;
    ELSIF HRM_HISTORY_LINE_G.LAST_HISTORY_CHECK(N_PERSON_ID, D_CHARGE_DATE) = FALSE THEN
     RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10030', NULL));
     RETURN;
    END IF;
  
    BEGIN
     -- 인사마스터 복구.
     UPDATE HRM_PERSON_MASTER PM
      SET (PM.OPERATING_UNIT_ID, PM.DEPT_ID, PM.JOB_CLASS_ID
        , PM.JOB_ID, PM.POST_ID, PM.OCPT_ID
        , PM.ABIL_ID, PM.PAY_GRADE_ID, PM.JOB_CATEGORY_ID, PM.FLOOR_ID
        -- 퇴직 처리시 반영됨.
        , PM.EMPLOYE_TYPE, PM.RETIRE_DATE, PM.RETIRE_ID
        ) =
        ( SELECT HL.PRE_OPERATING_UNIT_ID, HL.PRE_DEPT_ID, HL.PRE_JOB_CLASS_ID
            , HL.PRE_JOB_ID, HL.PRE_POST_ID, HL.PRE_OCPT_ID
            , HL.PRE_ABIL_ID, HL.PRE_PAY_GRADE_ID, HL.PRE_JOB_CATEGORY_ID, HL.PRE_FLOOR_ID
            , '1', NULL, NULL 
         FROM HRM_HISTORY_LINE HL
         WHERE HL.HISTORY_LINE_ID                         = W_HISTORY_LINE_ID     
        )            
     WHERE EXISTS ( SELECT 'X'
              FROM HRM_HISTORY_LINE HL
             WHERE HL.HISTORY_LINE_ID                 = W_HISTORY_LINE_ID
              AND HL.PERSON_ID                       = PM.PERSON_ID
         )
     ;
     
     DELETE HRM_HISTORY_LINE HL
     WHERE HL.HISTORY_LINE_ID                                 = W_HISTORY_LINE_ID
     ;
      
     -- 근태 작업장변경 삭제 --
     IF NVL(P_INTERFACE_FLAG, 'N') != 'Y' THEN 
       HRD_PERSON_HISTORY_G.INTERFACE_DEL_PERSON_HISTORY
        ( P_CHARGE_DATE       => D_CHARGE_DATE
        , P_PERSON_ID         => N_PERSON_ID
        , P_SOB_ID            => V_SOB_ID
        , P_ORG_ID            => V_ORG_ID
        , P_USER_ID           => GET_USER_ID_F
        , P_HISTORY_LINE_ID   => W_HISTORY_LINE_ID
        , O_STATUS            => V_STATUS
        );
     END IF;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, SUBSTR(SQLERRM, 1, 150));
      RETURN;
    END; 
    
  END DATA_DELETE;


----------------------------------------------------------------------------------------
-- 근태 작업장변경에서 데이터 변경시 인사발령 데이터 반영 --
  PROCEDURE INTERFACE_INSERT_HISTORY
           (  P_HISTORY_LINE_ID                     OUT HRM_HISTORY_LINE.HISTORY_LINE_ID%TYPE
            , P_PERSON_ID                           IN HRM_HISTORY_LINE.PERSON_ID%TYPE
            , P_SOB_ID                              IN NUMBER
            , P_ORG_ID                              IN NUMBER
            , P_CHARGE_DATE                         IN HRM_HISTORY_LINE.CHARGE_DATE%TYPE
            , P_CHARGE_ID                           IN HRM_HISTORY_LINE.CHARGE_ID%TYPE
            , P_RETIRE_ID                           IN HRM_HISTORY_LINE.RETIRE_ID%TYPE
            , P_OPERATING_UNIT_ID                   IN HRM_HISTORY_LINE.OPERATING_UNIT_ID%TYPE
            , P_DEPT_ID                             IN HRM_HISTORY_LINE.DEPT_ID%TYPE
            , P_JOB_CLASS_ID                        IN HRM_HISTORY_LINE.JOB_CLASS_ID%TYPE
            , P_JOB_ID                              IN HRM_HISTORY_LINE.JOB_ID%TYPE
            , P_POST_ID                             IN HRM_HISTORY_LINE.POST_ID%TYPE
            , P_OCPT_ID                             IN HRM_HISTORY_LINE.OCPT_ID%TYPE
            , P_ABIL_ID                             IN HRM_HISTORY_LINE.ABIL_ID%TYPE
            , P_PAY_GRADE_ID                        IN HRM_HISTORY_LINE.PAY_GRADE_ID%TYPE
            , P_JOB_CATEGORY_ID                     IN HRM_HISTORY_LINE.JOB_CATEGORY_ID%TYPE
            , P_FLOOR_ID                            IN HRM_HISTORY_LINE.FLOOR_ID%TYPE            
            , P_PRINT_YN                            IN HRM_HISTORY_LINE.PRINT_YN%TYPE
            , P_DESCRIPTION                         IN HRM_HISTORY_LINE.DESCRIPTION%TYPE
            , P_USER_ID                             IN HRM_HISTORY_LINE.CREATED_BY%TYPE
            , O_STATUS                              OUT VARCHAR2
            , O_MESSAGE                             OUT VARCHAR2
            )
  AS
    V_HISTORY_HEADER_ID     NUMBER;
    V_HISTORY_NUM           VARCHAR2(30);
    
    V_CORP_ID               NUMBER;
    V_PRE_OPERATING_UNIT_ID NUMBER;
    V_PRE_DEPT_ID           NUMBER;
    V_PRE_JOB_CLASS_ID      NUMBER;
    V_PRE_JOB_ID            NUMBER;
    V_PRE_POST_ID           NUMBER;
    V_PRE_OCPT_ID           NUMBER;
    V_PRE_ABIL_ID           NUMBER;
    V_PRE_PAY_GRADE_ID      NUMBER;
    V_PRE_JOB_CATEGORY_ID   NUMBER;
    V_PRE_FLOOR_ID          NUMBER;      
  BEGIN
    O_STATUS := 'F';   
    -- 변경전 데이터 조회 --
    BEGIN
      SELECT PM.CORP_ID
           , PM.OPERATING_UNIT_ID
           , PM.DEPT_ID
           , PM.JOB_CLASS_ID
           , PM.JOB_ID
           , PM.POST_ID
           , PM.OCPT_ID
           , PM.ABIL_ID
           , PM.PAY_GRADE_ID
           , PM.JOB_CATEGORY_ID
           , PM.FLOOR_ID
        INTO V_CORP_ID
           , V_PRE_OPERATING_UNIT_ID
           , V_PRE_DEPT_ID
           , V_PRE_JOB_CLASS_ID
           , V_PRE_JOB_ID
           , V_PRE_POST_ID
           , V_PRE_OCPT_ID
           , V_PRE_ABIL_ID
           , V_PRE_PAY_GRADE_ID
           , V_PRE_JOB_CATEGORY_ID
           , V_PRE_FLOOR_ID
        FROM HRM_PERSON_MASTER PM
       WHERE PM.PERSON_ID         = P_PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Not found Data. Person Master not exists';
      RETURN;
    END;
    
    BEGIN
      SELECT HH.HISTORY_HEADER_ID
           , HH.HISTORY_NUM
        INTO V_HISTORY_HEADER_ID
           , V_HISTORY_NUM
        FROM HRM_HISTORY_HEADER HH
       WHERE HH.CORP_ID           = V_CORP_ID
         AND HH.CHARGE_DATE       = P_CHARGE_DATE
         AND HH.CHARGE_ID         = P_CHARGE_ID         
         AND HH.SOB_ID            = P_SOB_ID
         AND HH.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_HISTORY_HEADER_ID := NULL;
      V_HISTORY_NUM       := NULL;
    END;
    
    -- HISTORY HEADER 없으면 INSERT --
    IF V_HISTORY_HEADER_ID IS NULL THEN
      HRM_HISTORY_HEADER_G.DATA_INSERT
        ( P_CORP_ID                 => V_CORP_ID
        , P_CHARGE_DATE             => P_CHARGE_DATE
        , P_CHARGE_ID               => P_CHARGE_ID
        , P_DESCRIPTION             => '근태 작업장 변경' 
        , P_RETIRE_YN               => 'N'
        , P_SOB_ID                  => P_SOB_ID        
        , P_ORG_ID                  => P_ORG_ID
        , P_USER_ID                 => P_USER_ID
        , O_HISTORY_HEADER_ID       => V_HISTORY_HEADER_ID
        , O_HISTORY_NUM             => V_HISTORY_NUM
        , O_CORP_ID                 => V_CORP_ID
        );
    END IF;
    
    HRM_HISTORY_LINE_G.DATA_INSERT
      ( P_HISTORY_HEADER_ID             => V_HISTORY_HEADER_ID
      , P_HISTORY_NUM                   => V_HISTORY_NUM
      , P_PERSON_ID                     => P_PERSON_ID
      , P_CHARGE_DATE                   => P_CHARGE_DATE
      , P_CHARGE_ID                     => P_CHARGE_ID
      , P_RETIRE_ID                     => P_RETIRE_ID
      , P_OPERATING_UNIT_ID             => NVL(P_OPERATING_UNIT_ID, V_PRE_OPERATING_UNIT_ID)
      , P_DEPT_ID                       => NVL(P_DEPT_ID, V_PRE_DEPT_ID)
      , P_JOB_CLASS_ID                  => NVL(P_JOB_CLASS_ID, V_PRE_JOB_CLASS_ID)
      , P_JOB_ID                        => NVL(P_JOB_ID, V_PRE_JOB_ID)
      , P_POST_ID                       => NVL(P_POST_ID, V_PRE_POST_ID)
      , P_OCPT_ID                       => NVL(P_OCPT_ID, V_PRE_OCPT_ID)
      , P_ABIL_ID                       => NVL(P_ABIL_ID, V_PRE_ABIL_ID)
      , P_PAY_GRADE_ID                  => NVL(P_PAY_GRADE_ID, V_PRE_PAY_GRADE_ID)
      , P_JOB_CATEGORY_ID               => NVL(P_JOB_CATEGORY_ID, V_PRE_JOB_CATEGORY_ID)
      , P_FLOOR_ID                      => NVL(P_FLOOR_ID, V_PRE_FLOOR_ID)
      , P_PRE_OPERATING_UNIT_ID         => V_PRE_OPERATING_UNIT_ID
      , P_PRE_DEPT_ID                   => V_PRE_DEPT_ID
      , P_PRE_JOB_CLASS_ID              => V_PRE_JOB_CLASS_ID
      , P_PRE_JOB_ID                    => V_PRE_JOB_ID
      , P_PRE_POST_ID                   => V_PRE_POST_ID
      , P_PRE_OCPT_ID                   => V_PRE_OCPT_ID
      , P_PRE_ABIL_ID                   => V_PRE_ABIL_ID
      , P_PRE_PAY_GRADE_ID              => V_PRE_PAY_GRADE_ID
      , P_PRE_JOB_CATEGORY_ID           => V_PRE_JOB_CATEGORY_ID
      , P_PRE_FLOOR_ID                  => V_PRE_FLOOR_ID
      , P_PRINT_YN                      => P_PRINT_YN
      , P_DESCRIPTION                   => P_DESCRIPTION
      , P_USER_ID                       => P_USER_ID
      , O_HISTORY_LINE_ID               => P_HISTORY_LINE_ID
      , P_INTERFACE_FLAG                => 'Y'  -- 작업장변경에서 데이터 제어하는지 체크  -- 
      );
    
    O_STATUS := 'S';          
  END INTERFACE_INSERT_HISTORY;

-- 근태 작업장변경에서 데이터 변경시 인사발령 데이터 반영 --
  PROCEDURE INTERFACE_UPDATE_HISTORY
           (  W_HISTORY_LINE_ID                     IN HRM_HISTORY_LINE.HISTORY_LINE_ID%TYPE
            , P_PERSON_ID                           IN HRM_HISTORY_LINE.PERSON_ID%TYPE
            , P_CHARGE_DATE                         IN HRM_HISTORY_LINE.CHARGE_DATE%TYPE
            , P_CHARGE_ID                           IN HRM_HISTORY_LINE.CHARGE_ID%TYPE
            , P_RETIRE_ID                           IN HRM_HISTORY_LINE.RETIRE_ID%TYPE
            , P_OPERATING_UNIT_ID                   IN HRM_HISTORY_LINE.OPERATING_UNIT_ID%TYPE
            , P_DEPT_ID                             IN HRM_HISTORY_LINE.DEPT_ID%TYPE
            , P_JOB_CLASS_ID                        IN HRM_HISTORY_LINE.JOB_CLASS_ID%TYPE
            , P_JOB_ID                              IN HRM_HISTORY_LINE.JOB_ID%TYPE
            , P_POST_ID                             IN HRM_HISTORY_LINE.POST_ID%TYPE
            , P_OCPT_ID                             IN HRM_HISTORY_LINE.OCPT_ID%TYPE
            , P_ABIL_ID                             IN HRM_HISTORY_LINE.ABIL_ID%TYPE
            , P_PAY_GRADE_ID                        IN HRM_HISTORY_LINE.PAY_GRADE_ID%TYPE
            , P_JOB_CATEGORY_ID                     IN HRM_HISTORY_LINE.JOB_CATEGORY_ID%TYPE
            , P_FLOOR_ID                            IN HRM_HISTORY_LINE.FLOOR_ID%TYPE            
            , P_PRINT_YN                            IN HRM_HISTORY_LINE.PRINT_YN%TYPE
            , P_DESCRIPTION                         IN HRM_HISTORY_LINE.DESCRIPTION%TYPE
            , P_USER_ID                             IN HRM_HISTORY_LINE.CREATED_BY%TYPE
            , O_STATUS                              OUT VARCHAR2
            , O_MESSAGE                             OUT VARCHAR2
            )
  AS
    V_PRE_OPERATING_UNIT_ID NUMBER;
    V_PRE_DEPT_ID           NUMBER;
    V_PRE_JOB_CLASS_ID      NUMBER;
    V_PRE_JOB_ID            NUMBER;
    V_PRE_POST_ID           NUMBER;
    V_PRE_OCPT_ID           NUMBER;
    V_PRE_ABIL_ID           NUMBER;
    V_PRE_PAY_GRADE_ID      NUMBER;
    V_PRE_JOB_CATEGORY_ID   NUMBER;
    V_PRE_FLOOR_ID          NUMBER;      
  BEGIN
    O_STATUS := 'F';   
    BEGIN
      SELECT -- 발령전 사항.
              HL.PRE_OPERATING_UNIT_ID
            , HL.PRE_DEPT_ID
            , HL.PRE_JOB_CLASS_ID
            , HL.PRE_JOB_ID
            , HL.PRE_POST_ID
            , HL.PRE_OCPT_ID
            , HL.PRE_ABIL_ID
            , HL.PRE_PAY_GRADE_ID
            , HL.PRE_JOB_CATEGORY_ID
            , HL.PRE_FLOOR_ID            
        INTO V_PRE_OPERATING_UNIT_ID
           , V_PRE_DEPT_ID
           , V_PRE_JOB_CLASS_ID
           , V_PRE_JOB_ID
           , V_PRE_POST_ID
           , V_PRE_OCPT_ID
           , V_PRE_ABIL_ID
           , V_PRE_PAY_GRADE_ID
           , V_PRE_JOB_CATEGORY_ID
           , V_PRE_FLOOR_ID
        FROM HRM_HISTORY_LINE      HL
       WHERE HL.HISTORY_LINE_ID    = W_HISTORY_LINE_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Not found Data. Person History not exists';
      RETURN;
    END;
    
    DATA_UPDATE
      ( W_HISTORY_LINE_ID           => W_HISTORY_LINE_ID
      , P_PERSON_ID                 => P_PERSON_ID
      , P_CHARGE_DATE               => P_CHARGE_DATE
      , P_CHARGE_ID                 => P_CHARGE_ID
      , P_RETIRE_ID                 => P_RETIRE_ID
      , P_OPERATING_UNIT_ID         => NVL(P_OPERATING_UNIT_ID, V_PRE_OPERATING_UNIT_ID)
      , P_DEPT_ID                   => NVL(P_DEPT_ID, V_PRE_DEPT_ID)
      , P_JOB_CLASS_ID              => NVL(P_JOB_CLASS_ID, V_PRE_JOB_CLASS_ID)
      , P_JOB_ID                    => NVL(P_JOB_ID, V_PRE_JOB_ID)
      , P_POST_ID                   => NVL(P_POST_ID, V_PRE_POST_ID)
      , P_OCPT_ID                   => NVL(P_OCPT_ID, V_PRE_OCPT_ID)
      , P_ABIL_ID                   => NVL(P_ABIL_ID, V_PRE_ABIL_ID)
      , P_PAY_GRADE_ID              => NVL(P_PAY_GRADE_ID, V_PRE_PAY_GRADE_ID)
      , P_JOB_CATEGORY_ID           => NVL(P_JOB_CATEGORY_ID, V_PRE_JOB_CATEGORY_ID)
      , P_FLOOR_ID                  => NVL(P_FLOOR_ID, V_PRE_FLOOR_ID)
      , P_PRE_OPERATING_UNIT_ID     => V_PRE_OPERATING_UNIT_ID
      , P_PRE_DEPT_ID               => V_PRE_DEPT_ID
      , P_PRE_JOB_CLASS_ID          => V_PRE_JOB_CLASS_ID
      , P_PRE_JOB_ID                => V_PRE_JOB_ID
      , P_PRE_POST_ID               => V_PRE_POST_ID
      , P_PRE_OCPT_ID               => V_PRE_OCPT_ID
      , P_PRE_ABIL_ID               => V_PRE_ABIL_ID
      , P_PRE_PAY_GRADE_ID          => V_PRE_PAY_GRADE_ID
      , P_PRE_JOB_CATEGORY_ID       => V_PRE_JOB_CATEGORY_ID
      , P_PRE_FLOOR_ID              => V_PRE_FLOOR_ID
      , P_PRINT_YN                  => 'Y'
      , P_DESCRIPTION               => P_DESCRIPTION
      , P_USER_ID                   => P_USER_ID
      , P_INTERFACE_FLAG            => 'Y'  -- 작업장변경에서 데이터 제어하는지 체크  -- 
      );
            
    O_STATUS := 'S';           
  END INTERFACE_UPDATE_HISTORY;
      
-- 근태 작업장 변경에서 인사발령 반영 --
  PROCEDURE INTERFACE_DELETE_HISTORY
           ( W_HISTORY_LINE_ID                     IN HRM_HISTORY_LINE.HISTORY_LINE_ID%TYPE
           , O_STATUS                              OUT VARCHAR2
           , O_MESSAGE                             OUT VARCHAR2
           )
  AS
  BEGIN
    O_STATUS := 'F';   
    DATA_DELETE
      ( W_HISTORY_LINE_ID           => W_HISTORY_LINE_ID
      , P_INTERFACE_FLAG            => 'Y' 
      );
    O_STATUS := 'S';   
  END INTERFACE_DELETE_HISTORY;
  
           
           
-- 최종 발령사항인지 체크.
  FUNCTION LAST_HISTORY_CHECK
          ( W_PERSON_ID                                       IN NUMBER
           , W_CHARGE_DATE                                     IN DATE) RETURN BOOLEAN
  AS
    V_RETURN_VALUE                                             BOOLEAN := FALSE;
    V_RECORD_COUNT                                             NUMBER := 0;
    
  BEGIN
    BEGIN
     SELECT  NVL(COUNT(HL.PERSON_ID), 0) AS HISTORY_NUM
      INTO V_RECORD_COUNT
     FROM HRM_HISTORY_LINE HL
     WHERE HL.PERSON_ID             = W_PERSON_ID
      AND HL.CHARGE_DATE            > W_CHARGE_DATE
     ;
    EXCEPTION WHEN OTHERS THEN
     V_RECORD_COUNT := 0;
    END;
        
    IF V_RECORD_COUNT > 0 THEN
    -- 최종 인사발령 아님.
     V_RETURN_VALUE := FALSE;
    ELSE
    -- 최종 인사발령 맞음.
     V_RETURN_VALUE := TRUE;
    END IF;
    RETURN V_RETURN_VALUE;
  
  END LAST_HISTORY_CHECK;
 
-- 발령에 따른 재직구분 체크.
  FUNCTION CHARGE_EMPLOYE_TYPE
          ( P_CHARGE_ID                                        IN NUMBER
           , W_CHARGE_DATE                                      IN DATE) RETURN VARCHAR2
  AS
   V_EMPLOE_TYPE                                               VARCHAR2(1) := '1';
  
 BEGIN
    -- 퇴직 처리인지 체크.
    BEGIN  
     SELECT DECODE(HC.VALUE1, 'Y', HC.VALUE3, '1') EMPLOE_TYPE
      INTO V_EMPLOE_TYPE
      FROM HRM_COMMON HC
      WHERE HC.COMMON_ID            = P_CHARGE_ID
        AND HC.GROUP_CODE           = 'CHARGE'
        AND HC.ENABLED_FLAG         = 'Y'
        AND HC.EFFECTIVE_DATE_FR    <= W_CHARGE_DATE
        AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO >= W_CHARGE_DATE)
     ;
    EXCEPTION WHEN OTHERS THEN
     V_EMPLOE_TYPE := '1';
    END;
    RETURN V_EMPLOE_TYPE;
   
 END CHARGE_EMPLOYE_TYPE; 

-- 개인의 발령사항 조회.
  PROCEDURE DATA_SELECT_PERSON
           ( P_CURSOR2                             OUT TYPES.TCURSOR2
            , W_PERSON_ID                           IN HRM_HISTORY_LINE.PERSON_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
        SELECT HL.HISTORY_LINE_ID
            , HL.HISTORY_HEADER_ID
            , HL.HISTORY_NUM
            , HL.PERSON_ID
            , PM.NAME
            , PM.PERSON_NUM
            , HL.CHARGE_DATE
            , HL.CHARGE_ID
            , HRM_COMMON_G.ID_NAME_F(HL.CHARGE_ID) AS CHARGE_NAME
            , HL.DESCRIPTION
            , HL.RETIRE_ID
            , HRM_COMMON_G.ID_NAME_F(HL.RETIRE_ID) AS RETIRE_NAME
            -- 발령사항.
            , HL.OPERATING_UNIT_ID
            , HRM_OPERATING_UNIT_G.OPERATING_UNIT_NAME_F(HL.OPERATING_UNIT_ID) AS OPERATING_UNIT_NAME
            , HL.DEPT_ID
            , DM.DEPT_NAME
            , HL.JOB_CLASS_ID
            , HRM_COMMON_G.ID_NAME_F(HL.JOB_CLASS_ID) AS JOB_CLASS_NAME
            , HL.JOB_ID
            , HRM_COMMON_G.ID_NAME_F(HL.JOB_ID) AS JOB_NAME
            , HL.POST_ID
            , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
            , HL.OCPT_ID
            , HRM_COMMON_G.ID_NAME_F(HL.OCPT_ID) AS OCPT_NAME
            , HL.ABIL_ID
            , HRM_COMMON_G.ID_NAME_F(HL.ABIL_ID) AS ABIL_NAME
            , HL.PAY_GRADE_ID
            , HRM_COMMON_G.ID_NAME_F(HL.PAY_GRADE_ID) AS PAY_GRADE_NAME
            , HL.JOB_CATEGORY_ID
            , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
            , HL.FLOOR_ID
            , HRM_COMMON_G.ID_NAME_F(HL.FLOOR_ID) AS FLOOR_NAME
            -- 발령전 사항.
            , HL.PRE_OPERATING_UNIT_ID
            , HRM_OPERATING_UNIT_G.OPERATING_UNIT_NAME_F(HL.PRE_OPERATING_UNIT_ID) AS PRE_OPERATING_UNIT_NAME
            , HL.PRE_DEPT_ID
            , P_DM.DEPT_NAME AS PRE_DEPT_NAME
            , HL.PRE_JOB_CLASS_ID
            , HRM_COMMON_G.ID_NAME_F(HL.PRE_JOB_CLASS_ID) AS PRE_JOB_CLASS_NAME
            , HL.PRE_JOB_ID
            , HRM_COMMON_G.ID_NAME_F(HL.PRE_JOB_ID) AS PRE_JOB_NAME
            , HL.PRE_POST_ID
            , HRM_COMMON_G.ID_NAME_F(HL.PRE_POST_ID) AS PRE_POST_NAME
            , HL.PRE_OCPT_ID
            , HRM_COMMON_G.ID_NAME_F(HL.PRE_OCPT_ID) AS PRE_OCPT_NAME
            , HL.PRE_ABIL_ID
            , HRM_COMMON_G.ID_NAME_F(HL.PRE_ABIL_ID) AS PRE_ABIL_NAME
            , HL.PRE_PAY_GRADE_ID
            , HRM_COMMON_G.ID_NAME_F(HL.PRE_PAY_GRADE_ID) AS PRE_PAY_GRADE_NAME
            , HL.PRE_JOB_CATEGORY_ID
            , HRM_COMMON_G.ID_NAME_F(HL.PRE_JOB_CATEGORY_ID) AS PRE_JOB_CATEGORY_NAME
            , HL.PRE_FLOOR_ID 
            , HRM_COMMON_G.ID_NAME_F(HL.PRE_FLOOR_ID) AS PRE_FLOOR_NAME
            , HL.PRINT_YN
            , PM.ORI_JOIN_DATE
            , PM.RETIRE_DATE
        FROM HRM_HISTORY_LINE HL
          , HRM_PERSON_MASTER PM
          , HRM_DEPT_MASTER DM
          , HRM_DEPT_MASTER P_DM
        WHERE HL.PERSON_ID                                                    = PM.PERSON_ID  
          AND HL.DEPT_ID                                                      = DM.DEPT_ID
          AND HL.PRE_DEPT_ID                                                  = P_DM.DEPT_ID
          AND HL.PERSON_ID                                                    = W_PERSON_ID
        ORDER BY HL.CHARGE_DATE, HL.CHARGE_ID, HL.PERSON_ID
        ;
  
  END DATA_SELECT_PERSON;


-- 인쇄 : 개인의 발령사항 조회.
  PROCEDURE PRINT_PERSON_HISTORY
           (  P_CURSOR2                             OUT TYPES.TCURSOR2
            , W_PERSON_ID                           IN  HRM_HISTORY_LINE.PERSON_ID%TYPE
            , W_SOB_ID                              IN  NUMBER
            , W_ORG_ID                              IN  NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT  SX1.HISTORY_NUM
            , SX1.PERSON_ID
            , SX1.NAME
            , SX1.PERSON_NUM
            , TO_CHAR(SX1.CHARGE_DATE, 'YYYY-MM-DD') AS CHARGE_DATE
            , SX1.CHARGE_NAME
            , SX1.DESCRIPTION
            , SX1.RETIRE_NAME
            -- 발령사항.
            , SX1.OPERATING_UNIT_NAME
            , SX1.DEPT_NAME
            , SX1.JOB_CLASS_NAME
            , SX1.JOB_NAME
            , SX1.POST_NAME
            , SX1.OCPT_NAME
            , SX1.ABIL_NAME
            , SX1.PAY_GRADE_NAME
            , SX1.JOB_CATEGORY_NAME
            , SX1.FLOOR_NAME
            -- 발령전 사항.
            , SX1.PRE_OPERATING_UNIT_NAME
            , SX1.PRE_DEPT_NAME
            , SX1.PRE_JOB_CLASS_NAME
            , SX1.PRE_JOB_NAME
            , SX1.PRE_POST_NAME
            , SX1.PRE_OCPT_NAME
            , SX1.PRE_ABIL_NAME
            , SX1.PRE_PAY_GRADE_NAME
            , SX1.PRE_JOB_CATEGORY_NAME
            , SX1.PRE_FLOOR_NAME
        FROM ( SELECT HL.HISTORY_LINE_ID
                    , HL.HISTORY_HEADER_ID
                    , HL.HISTORY_NUM
                    , HL.PERSON_ID
                    , PM.NAME
                    , PM.PERSON_NUM
                    , HL.CHARGE_DATE
                    , HL.CHARGE_ID
                    , HRM_COMMON_G.ID_NAME_F(HL.CHARGE_ID) AS CHARGE_NAME
                    , HL.DESCRIPTION
                    , HL.RETIRE_ID
                    , HRM_COMMON_G.ID_NAME_F(HL.RETIRE_ID) AS RETIRE_NAME
                    -- 발령사항.
                    , HL.OPERATING_UNIT_ID
                    , HRM_OPERATING_UNIT_G.OPERATING_UNIT_NAME_F(HL.OPERATING_UNIT_ID) AS OPERATING_UNIT_NAME
                    , HL.DEPT_ID
                    , DM.DEPT_NAME
                    , HL.JOB_CLASS_ID
                    , HRM_COMMON_G.ID_NAME_F(HL.JOB_CLASS_ID) AS JOB_CLASS_NAME
                    , HL.JOB_ID
                    , HRM_COMMON_G.ID_NAME_F(HL.JOB_ID) AS JOB_NAME
                    , HL.POST_ID
                    , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
                    , HL.OCPT_ID
                    , HRM_COMMON_G.ID_NAME_F(HL.OCPT_ID) AS OCPT_NAME
                    , HL.ABIL_ID
                    , HRM_COMMON_G.ID_NAME_F(HL.ABIL_ID) AS ABIL_NAME
                    , HL.PAY_GRADE_ID
                    , HRM_COMMON_G.ID_NAME_F(HL.PAY_GRADE_ID) AS PAY_GRADE_NAME
                    , HL.JOB_CATEGORY_ID
                    , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                    , HL.FLOOR_ID
                    , HRM_COMMON_G.ID_NAME_F(HL.FLOOR_ID) AS FLOOR_NAME
                    -- 발령전 사항.
                    , HL.PRE_OPERATING_UNIT_ID
                    , HRM_OPERATING_UNIT_G.OPERATING_UNIT_NAME_F(HL.PRE_OPERATING_UNIT_ID) AS PRE_OPERATING_UNIT_NAME
                    , HL.PRE_DEPT_ID
                    , P_DM.DEPT_NAME AS PRE_DEPT_NAME
                    , HL.PRE_JOB_CLASS_ID
                    , HRM_COMMON_G.ID_NAME_F(HL.PRE_JOB_CLASS_ID) AS PRE_JOB_CLASS_NAME
                    , HL.PRE_JOB_ID
                    , HRM_COMMON_G.ID_NAME_F(HL.PRE_JOB_ID) AS PRE_JOB_NAME
                    , HL.PRE_POST_ID
                    , HRM_COMMON_G.ID_NAME_F(HL.PRE_POST_ID) AS PRE_POST_NAME
                    , HL.PRE_OCPT_ID
                    , HRM_COMMON_G.ID_NAME_F(HL.PRE_OCPT_ID) AS PRE_OCPT_NAME
                    , HL.PRE_ABIL_ID
                    , HRM_COMMON_G.ID_NAME_F(HL.PRE_ABIL_ID) AS PRE_ABIL_NAME
                    , HL.PRE_PAY_GRADE_ID
                    , HRM_COMMON_G.ID_NAME_F(HL.PRE_PAY_GRADE_ID) AS PRE_PAY_GRADE_NAME
                    , HL.PRE_JOB_CATEGORY_ID
                    , HRM_COMMON_G.ID_NAME_F(HL.PRE_JOB_CATEGORY_ID) AS PRE_JOB_CATEGORY_NAME
                    , HL.PRE_FLOOR_ID 
                    , HRM_COMMON_G.ID_NAME_F(HL.PRE_FLOOR_ID) AS PRE_FLOOR_NAME
                    , HL.PRINT_YN
                    , PM.ORI_JOIN_DATE
                    , PM.RETIRE_DATE
                FROM HRM_HISTORY_LINE HL
                  , HRM_PERSON_MASTER PM
                  , HRM_DEPT_MASTER DM
                  , HRM_DEPT_MASTER P_DM
                WHERE HL.PERSON_ID                                                    = PM.PERSON_ID  
                  AND HL.DEPT_ID                                                      = DM.DEPT_ID
                  AND HL.PRE_DEPT_ID                                                  = P_DM.DEPT_ID
                  AND HL.PERSON_ID                                                    = W_PERSON_ID
                ORDER BY HL.CHARGE_DATE DESC, HL.CHARGE_ID
             ) SX1
      WHERE ROWNUM                <= 13   
        ;
  END PRINT_PERSON_HISTORY;
  


-- [2011-12-22]추가
   PROCEDURE SELECT_DATA
           ( P_CURSOR             OUT TYPES.TCURSOR
           , W_HISTORY_HEADER_ID  IN  HRM_HISTORY_LINE.HISTORY_HEADER_ID%TYPE
           , W_CORP_ID            IN  HRM_HISTORY_HEADER.CORP_ID%TYPE
           , W_DEPT_ID            IN  HRM_HISTORY_LINE.DEPT_ID%TYPE
           , W_PERSON_ID          IN  HRM_HISTORY_LINE.PERSON_ID%TYPE
           )

   AS

   BEGIN
             OPEN P_CURSOR FOR
             SELECT HL.HISTORY_LINE_ID
                  , HL.HISTORY_HEADER_ID
                  , HL.HISTORY_NUM
                  , HL.PERSON_ID
                  , PM.NAME
                  , PM.PERSON_NUM
                  , HL.CHARGE_DATE
                  , HL.CHARGE_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.CHARGE_ID) AS CHARGE_NAME
                  , HL.DESCRIPTION
                  , HL.RETIRE_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.RETIRE_ID) AS RETIRE_NAME
                  -- 발령사항.
                  , HL.OPERATING_UNIT_ID
                  , HRM_OPERATING_UNIT_G.OPERATING_UNIT_NAME_F(HL.OPERATING_UNIT_ID) AS OPERATING_UNIT_NAME
                  , HL.DEPT_ID
                  , DM.DEPT_NAME
                  , HL.JOB_CLASS_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.JOB_CLASS_ID) AS JOB_CLASS_NAME
                  , HL.JOB_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.JOB_ID) AS JOB_NAME
                  , HL.POST_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
                  , HL.OCPT_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.OCPT_ID) AS OCPT_NAME
                  , HL.ABIL_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.ABIL_ID) AS ABIL_NAME
                  , HL.PAY_GRADE_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.PAY_GRADE_ID) AS PAY_GRADE_NAME
                  , HL.JOB_CATEGORY_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                  , HL.FLOOR_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.FLOOR_ID) AS FLOOR_NAME
                  -- 발령전 사항.
                  , HL.PRE_OPERATING_UNIT_ID
                  , HRM_OPERATING_UNIT_G.OPERATING_UNIT_NAME_F(HL.PRE_OPERATING_UNIT_ID) AS PRE_OPERATING_UNIT_NAME
                  , HL.PRE_DEPT_ID
                  , P_DM.DEPT_NAME AS PRE_DEPT_NAME
                  , HL.PRE_JOB_CLASS_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.PRE_JOB_CLASS_ID) AS PRE_JOB_CLASS_NAME
                  , HL.PRE_JOB_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.PRE_JOB_ID) AS PRE_JOB_NAME
                  , HL.PRE_POST_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.PRE_POST_ID) AS PRE_POST_NAME
                  , HL.PRE_OCPT_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.PRE_OCPT_ID) AS PRE_OCPT_NAME
                  , HL.PRE_ABIL_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.PRE_ABIL_ID) AS PRE_ABIL_NAME
                  , HL.PRE_PAY_GRADE_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.PRE_PAY_GRADE_ID) AS PRE_PAY_GRADE_NAME
                  , HL.PRE_JOB_CATEGORY_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.PRE_JOB_CATEGORY_ID) AS PRE_JOB_CATEGORY_NAME
                  , HL.PRE_FLOOR_ID
                  , HRM_COMMON_G.ID_NAME_F(HL.PRE_FLOOR_ID) AS PRE_FLOOR_NAME
                  , HL.PRINT_YN
                  , PM.ORI_JOIN_DATE
                  , PM.RETIRE_DATE
               FROM HRM_HISTORY_LINE         HL
                  , HRM_PERSON_MASTER        PM
                  , HRM_DEPT_MASTER          DM
                  , HRM_DEPT_MASTER          P_DM
              WHERE HL.PERSON_ID          =  PM.PERSON_ID
                AND HL.DEPT_ID            =  DM.DEPT_ID
                AND HL.PRE_DEPT_ID        =  P_DM.DEPT_ID
                AND PM.CORP_ID            =  NVL(W_CORP_ID, PM.CORP_ID)
                AND HL.HISTORY_HEADER_ID  =  W_HISTORY_HEADER_ID
                AND PM.DEPT_ID            =  NVL(W_DEPT_ID, PM.DEPT_ID)
                AND HL.PERSON_ID          =  NVL(W_PERSON_ID, HL.PERSON_ID)
           ORDER BY HL.CHARGE_DATE
                  , PM.NAME
                  , HL.CHARGE_ID
                  , HL.PERSON_ID
                  ;

   END SELECT_DATA;


-- 인사발령현황 
  PROCEDURE SELECT_HISTORY_CURRENT( P_CURSOR            OUT TYPES.TCURSOR
                                  , W_CORP_ID           IN  NUMBER
                                  , W_START_DATE        IN  DATE
                                  , W_END_DATE          IN  DATE
                                  , W_DEPT_ID           IN  NUMBER
                                  , W_FLOOR_ID          IN  NUMBER
                                  , W_PERSON_ID         IN  NUMBER
                                  , W_SOB_ID            IN  NUMBER
                                  , W_ORG_ID            IN  NUMBER)
  AS
  BEGIN
     OPEN P_CURSOR FOR
       SELECT HL.HISTORY_LINE_ID
            , HL.HISTORY_HEADER_ID
            , HL.HISTORY_NUM
            , HL.PERSON_ID
            , HPM.NAME
            , HPM.PERSON_NUM
            , HL.CHARGE_DATE
            , HL.CHARGE_ID
            , HRM_COMMON_G.ID_NAME_F(HL.CHARGE_ID) AS CHARGE_NAME
            , HL.DESCRIPTION
            
            -- 발령사항.
            , HL.OPERATING_UNIT_ID
            , HRM_OPERATING_UNIT_G.OPERATING_UNIT_NAME_F(HL.OPERATING_UNIT_ID) AS OPERATING_UNIT_NAME
            , HL.DEPT_ID
            , DM.DEPT_NAME
            , HL.JOB_CLASS_ID
            , HRM_COMMON_G.ID_NAME_F(HL.JOB_CLASS_ID) AS JOB_CLASS_NAME
            , HL.JOB_ID
            , HRM_COMMON_G.ID_NAME_F(HL.JOB_ID) AS JOB_NAME
            , HL.POST_ID
            , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
            , HL.OCPT_ID
            , HRM_COMMON_G.ID_NAME_F(HL.OCPT_ID) AS OCPT_NAME
            , HL.ABIL_ID
            , HRM_COMMON_G.ID_NAME_F(HL.ABIL_ID) AS ABIL_NAME
            , HL.PAY_GRADE_ID
            , HRM_COMMON_G.ID_NAME_F(HL.PAY_GRADE_ID) AS PAY_GRADE_NAME
            , HL.JOB_CATEGORY_ID
            , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
            , HL.FLOOR_ID
            , HRM_COMMON_G.ID_NAME_F(HL.FLOOR_ID) AS FLOOR_NAME
            -- 발령전 사항.
            , HL.PRE_OPERATING_UNIT_ID
            , HRM_OPERATING_UNIT_G.OPERATING_UNIT_NAME_F(HL.PRE_OPERATING_UNIT_ID) AS PRE_OPERATING_UNIT_NAME
            , HL.PRE_DEPT_ID
            , P_DM.DEPT_NAME AS PRE_DEPT_NAME
            , HL.PRE_JOB_CLASS_ID
            , HRM_COMMON_G.ID_NAME_F(HL.PRE_JOB_CLASS_ID) AS PRE_JOB_CLASS_NAME
            , HL.PRE_JOB_ID
            , HRM_COMMON_G.ID_NAME_F(HL.PRE_JOB_ID) AS PRE_JOB_NAME
            , HL.PRE_POST_ID
            , HRM_COMMON_G.ID_NAME_F(HL.PRE_POST_ID) AS PRE_POST_NAME
            , HL.PRE_OCPT_ID
            , HRM_COMMON_G.ID_NAME_F(HL.PRE_OCPT_ID) AS PRE_OCPT_NAME
            , HL.PRE_ABIL_ID
            , HRM_COMMON_G.ID_NAME_F(HL.PRE_ABIL_ID) AS PRE_ABIL_NAME
            , HL.PRE_PAY_GRADE_ID
            , HRM_COMMON_G.ID_NAME_F(HL.PRE_PAY_GRADE_ID) AS PRE_PAY_GRADE_NAME
            , HL.PRE_JOB_CATEGORY_ID
            , HRM_COMMON_G.ID_NAME_F(HL.PRE_JOB_CATEGORY_ID) AS PRE_JOB_CATEGORY_NAME
            , HL.PRE_FLOOR_ID 
            , HRM_COMMON_G.ID_NAME_F(HL.PRE_FLOOR_ID) AS PRE_FLOOR_NAME
            , HL.PRINT_YN
            , HPM.ORI_JOIN_DATE
            , HPM.RETIRE_DATE
            
            
            , HPM.RETIRE_ID
            , HRM_COMMON_G.ID_NAME_F(HPM.RETIRE_ID) AS RETIRE_NAME
        FROM HRM_HISTORY_LINE HL
          , HRM_PERSON_MASTER HPM
          , HRM_DEPT_MASTER DM
          , HRM_DEPT_MASTER P_DM
        WHERE HL.PERSON_ID                                                    = HPM.PERSON_ID  
          AND HL.DEPT_ID                                                      = DM.DEPT_ID
          AND HL.PRE_DEPT_ID                                                  = P_DM.DEPT_ID
         -- AND HL.HISTORY_HEADER_ID                                            = NVL(W_HISTORY_HEADER_ID, HL.HISTORY_HEADER_ID)
          AND HPM.DEPT_ID                                                      = NVL(W_DEPT_ID, HPM.DEPT_ID)
          AND HL.PERSON_ID                                                    = NVL(W_PERSON_ID, HL.PERSON_ID)
          AND HPM.PERSON_ID                                                   = HL.PERSON_ID
          AND HPM.CORP_ID                                                     = W_CORP_ID
          AND HPM.DEPT_ID                                                     = NVL(W_DEPT_ID, HPM.DEPT_ID)
          AND ((W_FLOOR_ID                                                    IS NULL AND 1 = 1)
           OR (W_FLOOR_ID                                                     IS NOT NULL AND HPM.FLOOR_ID = W_FLOOR_ID))
          AND HPM.SOB_ID                                                      = W_SOB_ID
          AND HPM.ORG_ID                                                      = W_ORG_ID
          AND HL.PERSON_ID                                                    = NVL(W_PERSON_ID, HL.PERSON_ID)
          AND HL.CHARGE_DATE                                                  >= W_START_DATE
          AND HL.CHARGE_DATE                                                  <= W_END_DATE
       --   AND (HPM.RETIRE_DATE                                                >= &W_STD_DATE OR HPM.RETIRE_DATE IS NULL)
        ORDER BY HL.CHARGE_DATE, HL.CHARGE_ID, HL.PERSON_ID
        ;

  END SELECT_HISTORY_CURRENT;
    
END HRM_HISTORY_LINE_G;
/
