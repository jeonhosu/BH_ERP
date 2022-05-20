CREATE OR REPLACE PACKAGE HRM_HISTORY_HEADER_G
AS

-- DATA_SELECT.
   PROCEDURE DATA_SELECT
           ( P_CURSOR             OUT TYPES.TCURSOR
           , W_HISTORY_HEADER_ID  IN  HRM_HISTORY_HEADER.HISTORY_HEADER_ID%TYPE
           , W_CORP_ID            IN  HRM_HISTORY_HEADER.CORP_ID%TYPE
           , W_CHARGE_START_DATE  IN  HRM_HISTORY_HEADER.CHARGE_DATE%TYPE
           , W_CHARGE_END_DATE    IN  HRM_HISTORY_HEADER.CHARGE_DATE%TYPE
           , W_CHARGE_ID          IN  HRM_HISTORY_HEADER.CHARGE_ID%TYPE
           , W_SOB_ID             IN  HRM_HISTORY_HEADER.SOB_ID%TYPE
           , W_ORG_ID             IN  HRM_HISTORY_HEADER.ORG_ID%TYPE
           );

-- DATA_INSERT.
  PROCEDURE DATA_INSERT
           ( P_CORP_ID                                         IN HRM_HISTORY_HEADER.CORP_ID%TYPE
      , P_CHARGE_DATE                                     IN HRM_HISTORY_HEADER.CHARGE_DATE%TYPE
      , P_CHARGE_ID                                       IN HRM_HISTORY_HEADER.CHARGE_ID%TYPE
      , P_DESCRIPTION                                     IN HRM_HISTORY_HEADER.DESCRIPTION%TYPE
      , P_RETIRE_YN                                       IN HRM_HISTORY_HEADER.ATTRIBUTE5%TYPE
      , P_SOB_ID                                          IN HRM_HISTORY_HEADER.SOB_ID%TYPE
      , P_ORG_ID                                          IN HRM_HISTORY_HEADER.ORG_ID%TYPE
      , P_USER_ID                                         IN HRM_HISTORY_HEADER.CREATED_BY%TYPE
      , O_HISTORY_HEADER_ID                               OUT HRM_HISTORY_HEADER.HISTORY_HEADER_ID%TYPE
      , O_HISTORY_NUM                                     OUT HRM_HISTORY_HEADER.HISTORY_NUM%TYPE
      , O_CORP_ID                                         OUT HRM_HISTORY_HEADER.CORP_ID%TYPE
      );

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE
           ( W_HISTORY_HEADER_ID                               IN HRM_HISTORY_HEADER.HISTORY_HEADER_ID%TYPE
      , P_DESCRIPTION                                     IN HRM_HISTORY_HEADER.DESCRIPTION%TYPE
      , P_USER_ID                                         IN HRM_HISTORY_HEADER.CREATED_BY%TYPE
      );

-- DATA_DELETE..
  PROCEDURE DATA_DELETE
           ( W_HISTORY_HEADER_ID                               IN HRM_HISTORY_HEADER.HISTORY_HEADER_ID%TYPE
      );
      
-- 최종인사발령인지 체크.
  FUNCTION LAST_HISTORY_CHECK
          ( W_HISTORY_HEADER_ID                               IN HRM_HISTORY_HEADER.HISTORY_HEADER_ID%TYPE
      ) RETURN VARCHAR2;      
  
-- LOOKUP (발령번호).
  PROCEDURE LU_HISTORY_NUM
           ( P_CURSOR                                          OUT TYPES.TCURSOR
      , W_CORP_ID                                         IN HRM_HISTORY_HEADER.CORP_ID%TYPE
      , W_CHARGE_START_DATE                               IN HRM_HISTORY_HEADER.CHARGE_DATE%TYPE
      , W_CHARGE_END_DATE                                 IN HRM_HISTORY_HEADER.CHARGE_DATE%TYPE
      , W_CHARGE_ID                                       IN HRM_HISTORY_HEADER.CHARGE_ID%TYPE
      , W_SOB_ID                                          IN HRM_HISTORY_HEADER.SOB_ID%TYPE
      , W_ORG_ID                                          IN HRM_HISTORY_HEADER.ORG_ID%TYPE
      );
  
END HRM_HISTORY_HEADER_G;

 
/
CREATE OR REPLACE PACKAGE BODY HRM_HISTORY_HEADER_G
AS

-- DATA_SELECT.
   PROCEDURE DATA_SELECT
           ( P_CURSOR             OUT TYPES.TCURSOR
           , W_HISTORY_HEADER_ID  IN  HRM_HISTORY_HEADER.HISTORY_HEADER_ID%TYPE
           , W_CORP_ID            IN  HRM_HISTORY_HEADER.CORP_ID%TYPE
           , W_CHARGE_START_DATE  IN  HRM_HISTORY_HEADER.CHARGE_DATE%TYPE
           , W_CHARGE_END_DATE    IN  HRM_HISTORY_HEADER.CHARGE_DATE%TYPE
           , W_CHARGE_ID          IN  HRM_HISTORY_HEADER.CHARGE_ID%TYPE
           , W_SOB_ID             IN  HRM_HISTORY_HEADER.SOB_ID%TYPE
           , W_ORG_ID             IN  HRM_HISTORY_HEADER.ORG_ID%TYPE
           )

   AS

   BEGIN

             OPEN P_CURSOR FOR
             SELECT HH.HISTORY_HEADER_ID
                  , HH.HISTORY_NUM
                  , HH.CORP_ID
                  , HH.CHARGE_DATE
                  , HH.CHARGE_ID
                  , CCV.CODE_NAME AS CHARGE_NAME
                  , HH.DESCRIPTION
                  , HH.ATTRIBUTE5 AS RETIRE_YN
                  , NVL(CCV.NEWCOMER_YN, 'N') AS NEWCOMER_YN
               FROM HRM_HISTORY_HEADER       HH
                  , HRM_CHARGE_CODE_V        CCV
              WHERE HH.CHARGE_ID          =  CCV.COMMON_ID
                AND HH.SOB_ID             =  CCV.SOB_ID
                AND HH.ORG_ID             =  CCV.ORG_ID
                AND HH.HISTORY_HEADER_ID  =  NVL(W_HISTORY_HEADER_ID, HH.HISTORY_HEADER_ID)
                AND HH.CORP_ID            =  NVL(W_CORP_ID, HH.CORP_ID)
                AND HH.CHARGE_DATE           BETWEEN W_CHARGE_START_DATE AND W_CHARGE_END_DATE
                AND HH.CHARGE_ID          =  NVL(W_CHARGE_ID, HH.CHARGE_ID)
                AND HH.SOB_ID             =  W_SOB_ID
                AND HH.ORG_ID             =  W_ORG_ID
           ORDER BY HH.HISTORY_NUM DESC
                  ;

   END DATA_SELECT;


-- DATA_INSERT.
  PROCEDURE DATA_INSERT
           ( P_CORP_ID                                         IN HRM_HISTORY_HEADER.CORP_ID%TYPE
          , P_CHARGE_DATE                                     IN HRM_HISTORY_HEADER.CHARGE_DATE%TYPE
          , P_CHARGE_ID                                       IN HRM_HISTORY_HEADER.CHARGE_ID%TYPE
          , P_DESCRIPTION                                     IN HRM_HISTORY_HEADER.DESCRIPTION%TYPE
          , P_RETIRE_YN                                       IN HRM_HISTORY_HEADER.ATTRIBUTE5%TYPE
          , P_SOB_ID                                          IN HRM_HISTORY_HEADER.SOB_ID%TYPE
          , P_ORG_ID                                          IN HRM_HISTORY_HEADER.ORG_ID%TYPE
          , P_USER_ID                                         IN HRM_HISTORY_HEADER.CREATED_BY%TYPE
          , O_HISTORY_HEADER_ID                               OUT HRM_HISTORY_HEADER.HISTORY_HEADER_ID%TYPE
          , O_HISTORY_NUM                                     OUT HRM_HISTORY_HEADER.HISTORY_NUM%TYPE
          , O_CORP_ID                                         OUT HRM_HISTORY_HEADER.CORP_ID%TYPE
          )
  AS
    D_SYSDATE                                                   HRM_HISTORY_HEADER.CHARGE_DATE%TYPE;
    N_HISTORY_HEADER_ID                                         HRM_HISTORY_HEADER.HISTORY_HEADER_ID%TYPE := 0;
    V_HISTORY_NUM                                               HRM_HISTORY_HEADER.HISTORY_NUM%TYPE := NULL;
    V_CHARGE_SEQ                                                HRM_HISTORY_HEADER.CHARGE_SEQ%TYPE := NULL;
    
    V_HISTORY_YEAR                                              HRM_HISTORY_HEADER.HISTORY_YEAR%TYPE := NULL;
    N_HISTORY_SEQ                                               HRM_HISTORY_HEADER.HISTORY_SEQ%TYPE := 0;
    
  BEGIN
   D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
  
/*--------------------------------------------------------------------------------------*/
-- 기존 발령번호 존재 여부 체크. --> 존재하면 기존 발령번호 적용.
    BEGIN
      SELECT HH.HISTORY_HEADER_ID, HH.HISTORY_NUM
        INTO N_HISTORY_HEADER_ID, V_HISTORY_NUM
        FROM HRM_HISTORY_HEADER HH
       WHERE HH.CHARGE_ID                           = P_CHARGE_ID 
         AND HH.CHARGE_DATE                         = P_CHARGE_DATE
     AND HH.SOB_ID                              = P_SOB_ID
     AND HH.ORG_ID                              = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      N_HISTORY_HEADER_ID := 0;
      V_HISTORY_NUM := NULL;
    END;
/*--------------------------------------------------------------------------------------*/
    IF V_HISTORY_NUM IS NULL THEN
      -- HISTORY HEADER ID 채번.
      SELECT HRM_HISTORY_HEADER_S1.NEXTVAL
        INTO N_HISTORY_HEADER_ID
      FROM DUAL;
      
      -- 발령순서 채번 --
      V_CHARGE_SEQ := HRM_MASTER_NUM_G.MASTER_NUM_F
                        ( W_MASTER_TYPE   => 'CHARGE_SEQ' 
                        , W_SOB_ID        => P_SOB_ID 
                        , W_ORG_ID        => P_ORG_ID  
                        , P_STD_DATE      => P_CHARGE_DATE
                        , P_USER_ID       => P_USER_ID 
                        );
                        
      -- 발령번호 채번 --
      V_HISTORY_YEAR := TO_CHAR(P_CHARGE_DATE, 'YYYY');
      BEGIN
        SELECT NVL(MAX(HH.HISTORY_SEQ), 0) + 1 NEW_HISTORY_SEQ
          INTO N_HISTORY_SEQ
        FROM HRM_HISTORY_HEADER HH
        WHERE HH.HISTORY_YEAR       = V_HISTORY_YEAR
          AND HH.SOB_ID             = P_SOB_ID
          AND HH.ORG_ID             = P_ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        N_HISTORY_SEQ := 1;
      END;
      -- HISTORY NUM 채번.
      V_HISTORY_NUM := V_HISTORY_YEAR || '-' ||LPAD(N_HISTORY_SEQ, 5, 0);
      
      INSERT INTO HRM_HISTORY_HEADER
      (HISTORY_HEADER_ID, HISTORY_NUM
      , CORP_ID, CHARGE_DATE, CHARGE_ID
      , CHARGE_SEQ
      , DESCRIPTION
      , ATTRIBUTE5
      , HISTORY_YEAR, HISTORY_SEQ
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
      ) VALUES
      (N_HISTORY_HEADER_ID, V_HISTORY_NUM
      , P_CORP_ID, TRUNC(P_CHARGE_DATE), P_CHARGE_ID
      , V_CHARGE_SEQ
      , P_DESCRIPTION
      , P_RETIRE_YN
      , V_HISTORY_YEAR, N_HISTORY_SEQ
      , P_SOB_ID, P_ORG_ID
      , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
      );
    END IF;
/*--------------------------------------------------------------------------------------*/
    O_HISTORY_HEADER_ID := N_HISTORY_HEADER_ID;
    O_HISTORY_NUM := V_HISTORY_NUM;
    O_CORP_ID := P_CORP_ID;
    
  END DATA_INSERT;

-- DATA_UPDATE.
   PROCEDURE DATA_UPDATE
           ( W_HISTORY_HEADER_ID  IN  HRM_HISTORY_HEADER.HISTORY_HEADER_ID%TYPE
           , P_DESCRIPTION                                     IN HRM_HISTORY_HEADER.DESCRIPTION%TYPE
           , P_USER_ID                                         IN HRM_HISTORY_HEADER.CREATED_BY%TYPE
           )

   AS

   BEGIN
             --[FCM_10030]해당 발령사항은 수정/삭제 할 수 없습니다.
             IF HRM_HISTORY_HEADER_G.LAST_HISTORY_CHECK(W_HISTORY_HEADER_ID) = 'N' THEN
                RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10030', NULL));
                RETURN;
             END IF;
  
             UPDATE HRM_HISTORY_HEADER HH
                SET HH.DESCRIPTION       =  P_DESCRIPTION
                  , HH.LAST_UPDATE_DATE  =  SYSDATE
                  , HH.LAST_UPDATED_BY   =  P_USER_ID
              WHERE HH.HISTORY_HEADER_ID =  W_HISTORY_HEADER_ID
                  ;

   END DATA_UPDATE;

-- DATA_DELETE..
   PROCEDURE DATA_DELETE
           ( W_HISTORY_HEADER_ID  IN  HRM_HISTORY_HEADER.HISTORY_HEADER_ID%TYPE
           )

   AS

   BEGIN
             /*--[FCM_10030]해당 발령사항은 수정/삭제 할 수 없습니다.
             IF HRM_HISTORY_HEADER_G.LAST_HISTORY_CHECK(W_HISTORY_HEADER_ID) = 'N' THEN
                RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10030', NULL));
                RETURN;
             END IF;*/
             --삭제 하고자 하는 발령번호를 기준으로
             --큰 번호가 이미 존재하면 지울수가 없다.
  
             DELETE HRM_HISTORY_HEADER HH
              WHERE HH.HISTORY_HEADER_ID = W_HISTORY_HEADER_ID
                  ;

   END DATA_DELETE;

-- 최종인사발령인지 체크.
   FUNCTION LAST_HISTORY_CHECK
          ( W_HISTORY_HEADER_ID  IN  HRM_HISTORY_HEADER.HISTORY_HEADER_ID%TYPE
          ) RETURN VARCHAR2

   AS
            V_HISTORY_NUM            HRM_HISTORY_HEADER.HISTORY_NUM%TYPE;
            V_HISTORY_COUNT          NUMBER;
  
            V_RETURN_VALUE           VARCHAR2(10) := 'Y';
  
   BEGIN
            BEGIN
                 SELECT HH.HISTORY_NUM
                   INTO V_HISTORY_NUM
                   FROM HRM_HISTORY_HEADER     HH
                  WHERE HH.HISTORY_HEADER_ID = W_HISTORY_HEADER_ID
                      ;
            EXCEPTION WHEN OTHERS THEN
                      V_RETURN_VALUE := 'N';
            END;
   
            BEGIN
                 SELECT COUNT(HH.HISTORY_NUM) AS HISTORY_COIUNT
                   INTO V_HISTORY_COUNT
                   FROM HRM_HISTORY_HEADER HH
                  WHERE HH.HISTORY_NUM > V_HISTORY_NUM
                      ;
             EXCEPTION WHEN OTHERS THEN
                       V_HISTORY_COUNT := 0;
             END;
  
             IF V_HISTORY_COUNT > 0 THEN
                V_RETURN_VALUE := 'N';
             END IF;
             
             RETURN V_RETURN_VALUE;
  
   END LAST_HISTORY_CHECK;
 
-- LOOKUP (발령번호).
   PROCEDURE LU_HISTORY_NUM
           ( P_CURSOR              OUT TYPES.TCURSOR
           , W_CORP_ID             IN  HRM_HISTORY_HEADER.CORP_ID%TYPE
           , W_CHARGE_START_DATE   IN  HRM_HISTORY_HEADER.CHARGE_DATE%TYPE
           , W_CHARGE_END_DATE     IN  HRM_HISTORY_HEADER.CHARGE_DATE%TYPE
           , W_CHARGE_ID           IN  HRM_HISTORY_HEADER.CHARGE_ID%TYPE
           , W_SOB_ID              IN  HRM_HISTORY_HEADER.SOB_ID%TYPE
           , W_ORG_ID              IN  HRM_HISTORY_HEADER.ORG_ID%TYPE
           )

   AS

   BEGIN

             OPEN P_CURSOR FOR
             SELECT HH.HISTORY_NUM
                  , HRM_COMMON_G.ID_NAME_F(HH.CHARGE_ID) AS CHARGE_NAME
                  , HH.DESCRIPTION
                  , HH.HISTORY_HEADER_ID
               FROM HRM_HISTORY_HEADER HH
              WHERE HH.CORP_ID      = W_CORP_ID
                AND HH.CHARGE_DATE    BETWEEN W_CHARGE_START_DATE AND W_CHARGE_END_DATE
                AND HH.CHARGE_ID    = NVL(W_CHARGE_ID, HH.CHARGE_ID)
                AND HH.SOB_ID       = W_SOB_ID
                AND HH.ORG_ID       = W_ORG_ID
           ORDER BY HH.HISTORY_NUM
                  ;

   END LU_HISTORY_NUM;
    
END HRM_HISTORY_HEADER_G;
/
