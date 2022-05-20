CREATE OR REPLACE PACKAGE HRD_HOLY_TYPE_G
AS

-- 근무변경신청 조회[2011-12-27]수정
   PROCEDURE DATA_SELECT
           ( P_CURSOR             OUT TYPES.TCURSOR
           , W_CORP_ID            IN  HRD_HOLY_TYPE.CORP_ID%TYPE
           , W_START_DATE         IN  HRD_HOLY_TYPE.START_DATE%TYPE
           , W_END_DATE           IN  HRD_HOLY_TYPE.END_DATE%TYPE
           , W_APPROVE_STATUS     IN  HRD_HOLY_TYPE.APPROVE_STATUS%TYPE
           , W_FLOOR_ID           IN  HRM_COMMON.COMMON_ID%TYPE
           , W_PERSON_ID          IN  HRD_HOLY_TYPE.PERSON_ID%TYPE
           , W_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
           , W_SOB_ID             IN  HRD_HOLY_TYPE.SOB_ID%TYPE
           , W_ORG_ID             IN  HRD_HOLY_TYPE.ORG_ID%TYPE
           );

-- DATA INSERT.
  PROCEDURE DATA_INSERT
            ( P_HOLY_TYPE_ID OUT HRD_HOLY_TYPE.HOLY_TYPE_ID%TYPE
            , P_PERSON_ID    IN HRD_HOLY_TYPE.PERSON_ID%TYPE
            , P_START_DATE   IN HRD_HOLY_TYPE.START_DATE%TYPE
            , P_END_DATE     IN HRD_HOLY_TYPE.END_DATE%TYPE
            , P_HOLY_TYPE    IN HRD_HOLY_TYPE.HOLY_TYPE%TYPE
            , P_DESCRIPTION         IN HRD_HOLY_TYPE.DESCRIPTION%TYPE
            , P_SOB_ID       IN HRD_HOLY_TYPE.SOB_ID%TYPE
            , P_ORG_ID       IN HRD_HOLY_TYPE.ORG_ID%TYPE
            , P_USER_ID      IN HRD_HOLY_TYPE.CREATED_BY%TYPE
            , O_APPROVE_STATUS  OUT HRD_HOLY_TYPE.APPROVE_STATUS%TYPE
            , O_APPROVE_STATUS_NAME  OUT VARCHAR2
            );

-- DATA UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_HOLY_TYPE_ID        IN HRD_HOLY_TYPE.HOLY_TYPE_ID%TYPE
            , P_PERSON_ID           IN HRD_HOLY_TYPE.PERSON_ID%TYPE
            , P_START_DATE          IN HRD_HOLY_TYPE.START_DATE%TYPE
            , P_END_DATE            IN HRD_HOLY_TYPE.END_DATE%TYPE
            , P_HOLY_TYPE           IN HRD_HOLY_TYPE.HOLY_TYPE%TYPE
            , P_DESCRIPTION         IN HRD_HOLY_TYPE.DESCRIPTION%TYPE
            , P_SOB_ID              IN HRD_HOLY_TYPE.SOB_ID%TYPE
            , P_ORG_ID              IN HRD_HOLY_TYPE.ORG_ID%TYPE
            , P_USER_ID             IN HRD_HOLY_TYPE.CREATED_BY%TYPE
            );

-- DATA DELETE.
  PROCEDURE DATA_DELETE
            ( W_HOLY_TYPE_ID       IN HRD_HOLY_TYPE.HOLY_TYPE_ID%TYPE
            );

-- DATA UPDATE REQUEST.
  PROCEDURE DATA_UPDATE_REQUEST
            ( W_HOLY_TYPE_ID       IN HRD_HOLY_TYPE.HOLY_TYPE_ID%TYPE
            , O_APPROVE_STATUS     OUT VARCHAR2
            , O_APPROVE_STATUS_NAME    OUT VARCHAR2
            );
            
-- DATA UPDATE - STEP APPROVE.
  PROCEDURE DATA_UPDATE_APPROVE
            ( W_HOLY_TYPE_ID       IN HRD_HOLY_TYPE.HOLY_TYPE_ID%TYPE
            , P_APPROVE_STATUS     IN HRD_HOLY_TYPE.APPROVE_STATUS%TYPE
            , P_CHECK_YN           IN VARCHAR2
            , P_CONNECT_PERSON_ID  IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , P_APPROVE_FLAG       IN VARCHAR2
            , P_SOB_ID             IN HRD_HOLY_TYPE.SOB_ID%TYPE
            , P_ORG_ID             IN HRD_HOLY_TYPE.ORG_ID%TYPE
            , P_USER_ID            IN HRD_HOLY_TYPE.CREATED_BY%TYPE
            );

-- 트리거에서 호출하는 프로시져.
  PROCEDURE WORK_CALENDAR_UPDATE
            ( P_GB                 IN VARCHAR2
            , P_HOLY_TYPE_ID       IN NUMBER
            , P_PERSON_ID          IN NUMBER
            , P_START_DATE         IN DATE
            , P_END_DATE           IN DATE
            , P_HOLY_TYPE          IN VARCHAR2
            , P_SOB_ID             IN NUMBER
            , P_ORG_ID             IN NUMBER
            , P_USER_ID            IN NUMBER
            );
            
END HRD_HOLY_TYPE_G;
/
CREATE OR REPLACE PACKAGE BODY HRD_HOLY_TYPE_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_HOLY_TYPE_G
/* DESCRIPTION  : 근무 신청/승인관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/



-- 근무변경신청 조회[2011-12-27]수정
   PROCEDURE DATA_SELECT
           ( P_CURSOR             OUT TYPES.TCURSOR
           , W_CORP_ID            IN  HRD_HOLY_TYPE.CORP_ID%TYPE
           , W_START_DATE         IN  HRD_HOLY_TYPE.START_DATE%TYPE
           , W_END_DATE           IN  HRD_HOLY_TYPE.END_DATE%TYPE
           , W_APPROVE_STATUS     IN  HRD_HOLY_TYPE.APPROVE_STATUS%TYPE
           , W_FLOOR_ID           IN  HRM_COMMON.COMMON_ID%TYPE
           , W_PERSON_ID          IN  HRD_HOLY_TYPE.PERSON_ID%TYPE
           , W_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
           , W_SOB_ID             IN  HRD_HOLY_TYPE.SOB_ID%TYPE
           , W_ORG_ID             IN  HRD_HOLY_TYPE.ORG_ID%TYPE
           )

   AS

             V_CONNECT_PERSON_ID      HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

   BEGIN

             -- 근태권한 설정.
             IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => W_CORP_ID
                                        , W_START_DATE  => W_START_DATE
                                        , W_END_DATE    => W_END_DATE
                                        , W_MODULE_CODE => '20'
                                        , W_PERSON_ID   => W_CONNECT_PERSON_ID
                                        , W_SOB_ID      => W_SOB_ID
                                        , W_ORG_ID      => W_ORG_ID) = 'C' THEN
                V_CONNECT_PERSON_ID := NULL;
             ELSE
                V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
             END IF;

             IF W_APPROVE_STATUS IN('A') THEN
                V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
             END IF;

             OPEN P_CURSOR FOR
             SELECT HT.PERSON_ID
                  , PM.NAME
                  , PM.PERSON_NUM
                  --, HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
                  , HRM_COMMON_G.ID_NAME_F(HT.FLOOR_ID) AS FLOOR_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)  AS POST_NAME
                  , HT.CORP_ID
                  , HT.HOLY_TYPE
                  , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', HT.HOLY_TYPE, HT.SOB_ID, HT.ORG_ID) AS HOLY_TYPE_NAME
                  , TRUNC(HT.START_DATE) AS START_DATE
                  , TRUNC(HT.END_DATE)   AS END_DATE
                  , HT.DESCRIPTION
                  , 'N'                  AS APPROVE_YN
                  , HT.APPROVE_STATUS
                  , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', HT.APPROVE_STATUS, HT.SOB_ID, HT.ORG_ID) AS APPROVE_STATUS_NAME
                  , HRM_PERSON_MASTER_G.NAME_F(HT.APPROVED_PERSON_ID)  AS APPROVERD_PERSON_NAME
                  , HRM_PERSON_MASTER_G.NAME_F(HT.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                  , HT.HOLY_TYPE_ID
                  , WT.WORK_TYPE_GROUP
               FROM(SELECT S_HT.HOLY_TYPE_ID
                         , S_HT.PERSON_ID
                         , S_HT.START_DATE
                         , S_HT.END_DATE
                         , S_HT.CORP_ID
                         , S_HT.WORK_CORP_ID
                         , S_HT.HOLY_TYPE
                         , S_HT.APPROVED_YN
                         , S_HT.APPROVED_DATE
                         , S_HT.APPROVED_PERSON_ID
                         , S_HT.CONFIRMED_YN
                         , S_HT.CONFIRMED_DATE
                         , S_HT.CONFIRMED_PERSON_ID
                         , S_HT.APPROVE_STATUS
                         , S_HT.CALENDAR_TRAN_YN
                         , S_HT.DESCRIPTION
                         , S_HT.ATTRIBUTE1
                         , S_HT.ATTRIBUTE2
                         , S_HT.ATTRIBUTE3
                         , S_HT.ATTRIBUTE4
                         , S_HT.ATTRIBUTE5
                         , S_HT.SOB_ID
                         , S_HT.ORG_ID
                         , S_HT.CREATION_DATE
                         , S_HT.CREATED_BY
                         , S_HT.LAST_UPDATE_DATE
                         , S_HT.LAST_UPDATED_BY
                         , S_HT.EMAIL_STATUS
                         , S_HT.REJECT_REMARK
                         ,(SELECT S_PH.FLOOR_ID
                             FROM HRD_PERSON_HISTORY        S_PH
                            WHERE S_PH.PERSON_ID          = S_HT.PERSON_ID
                              AND S_PH.EFFECTIVE_DATE_FR <= S_HT.END_DATE
                              AND S_PH.EFFECTIVE_DATE_TO >= S_HT.END_DATE
                              AND ROWNUM = 1) AS FLOOR_ID
                         ,(SELECT S_PH.WORK_TYPE_ID
                             FROM HRD_PERSON_HISTORY        S_PH
                            WHERE S_PH.PERSON_ID          = S_HT.PERSON_ID
                              AND S_PH.EFFECTIVE_DATE_FR <= S_HT.END_DATE
                              AND S_PH.EFFECTIVE_DATE_TO >= S_HT.END_DATE
                              AND ROWNUM = 1) AS WORK_TYPE_ID
                         ,(SELECT S_PH.DEPT_ID
                             FROM HRD_PERSON_HISTORY        S_PH
                            WHERE S_PH.PERSON_ID          = S_HT.PERSON_ID
                              AND S_PH.EFFECTIVE_DATE_FR <= S_HT.END_DATE
                              AND S_PH.EFFECTIVE_DATE_TO >= S_HT.END_DATE
                              AND ROWNUM = 1) AS DEPT_ID
                      FROM HRD_HOLY_TYPE S_HT
                   ) HT
                  , HRM_PERSON_MASTER PM
                  ,(-- 시점 인사내역.
                    SELECT HL.PERSON_ID
                         , HL.POST_ID
                         , HL.JOB_CATEGORY_ID
                         , HL.JOB_CLASS_ID
                         , HL.OCPT_ID
                      FROM HRM_HISTORY_LINE HL
                     WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                      FROM HRM_HISTORY_LINE      S_HL
                                                     WHERE S_HL.PERSON_ID     =  HL.PERSON_ID
                                                       AND S_HL.CHARGE_DATE  <=  W_END_DATE
                                                  GROUP BY S_HL.PERSON_ID
                                                  )
                   ) T1
                  ,(-- 시점 인사내역.
                    SELECT PH.PERSON_ID
                         , PH.FLOOR_ID
                         , PH.WORK_TYPE_ID
                         , PH.DEPT_ID
                      FROM HRD_PERSON_HISTORY        PH
                     WHERE PH.EFFECTIVE_DATE_FR  <=  W_END_DATE
                       AND PH.EFFECTIVE_DATE_TO  >=  W_END_DATE
                   ) T2
                  , HRM_WORK_TYPE_V WT
              WHERE HT.PERSON_ID                       =  PM.PERSON_ID
                AND HT.SOB_ID                          =  PM.SOB_ID
                AND HT.ORG_ID                          =  PM.ORG_ID
                AND PM.PERSON_ID                       =  T1.PERSON_ID
                AND PM.PERSON_ID                       =  T2.PERSON_ID
                AND PM.WORK_TYPE_ID                    =  WT.WORK_TYPE_ID
                AND TRUNC(HT.START_DATE)              <=  W_END_DATE
                AND TRUNC(HT.END_DATE)                >=  W_START_DATE
                AND HT.PERSON_ID                       =  NVL(W_PERSON_ID, HT.PERSON_ID)
                --AND T2.FLOOR_ID                        =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                AND HT.FLOOR_ID                        =  NVL(W_FLOOR_ID, HT.FLOOR_ID)
                AND HT.WORK_CORP_ID                    =  W_CORP_ID
                AND HT.SOB_ID                          =  W_SOB_ID
                AND HT.ORG_ID                          =  W_ORG_ID
                AND HT.APPROVE_STATUS                  =  NVL(W_APPROVE_STATUS, HT.APPROVE_STATUS)
                AND EXISTS (SELECT 'X'
                              FROM HRD_DUTY_MANAGER       DM
                             WHERE DM.CORP_ID          =  HT.WORK_CORP_ID -- HT.CORP_ID[2011-06-28]수정
                               AND DM.DUTY_CONTROL_ID  =  T2.FLOOR_ID
                               AND DM.WORK_TYPE_ID     =  DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
                               AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
                               AND DM.SOB_ID           =  HT.SOB_ID
                               AND DM.ORG_ID           =  HT.ORG_ID
                           )
             ;

   END DATA_SELECT;





-- DATA INSERT.
  PROCEDURE DATA_INSERT
            ( P_HOLY_TYPE_ID OUT HRD_HOLY_TYPE.HOLY_TYPE_ID%TYPE
            , P_PERSON_ID    IN HRD_HOLY_TYPE.PERSON_ID%TYPE
            , P_START_DATE   IN HRD_HOLY_TYPE.START_DATE%TYPE
            , P_END_DATE     IN HRD_HOLY_TYPE.END_DATE%TYPE
            , P_HOLY_TYPE    IN HRD_HOLY_TYPE.HOLY_TYPE%TYPE
            , P_DESCRIPTION         IN HRD_HOLY_TYPE.DESCRIPTION%TYPE
            , P_SOB_ID       IN HRD_HOLY_TYPE.SOB_ID%TYPE
            , P_ORG_ID       IN HRD_HOLY_TYPE.ORG_ID%TYPE
            , P_USER_ID      IN HRD_HOLY_TYPE.CREATED_BY%TYPE
            , O_APPROVE_STATUS  OUT HRD_HOLY_TYPE.APPROVE_STATUS%TYPE
            , O_APPROVE_STATUS_NAME  OUT VARCHAR2
            )
  AS
   V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_CORP_ID         NUMBER;
    V_WORK_CORP_ID    NUMBER;

  BEGIN
    BEGIN
      SELECT PM.CORP_ID, PM.WORK_CORP_ID
        INTO V_CORP_ID, V_WORK_CORP_ID
        FROM HRM_PERSON_MASTER PM
      WHERE PM.PERSON_ID        = P_PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CORP_ID := 0;
      V_WORK_CORP_ID := 0;
    END;
    SELECT HRD_HOLY_TYPE_S1.NEXTVAL
      INTO P_HOLY_TYPE_ID
      FROM DUAL;

    INSERT INTO HRD_HOLY_TYPE
    ( HOLY_TYPE_ID
    , PERSON_ID
    , START_DATE
    , END_DATE
    , CORP_ID
    , WORK_CORP_ID
    , HOLY_TYPE
    , DESCRIPTION
    , SOB_ID
    , ORG_ID
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY )
    VALUES
    ( P_HOLY_TYPE_ID
    , P_PERSON_ID
    , P_START_DATE
    , P_END_DATE
    , V_CORP_ID
    , V_WORK_CORP_ID
    , P_HOLY_TYPE
    , P_DESCRIPTION
    , P_SOB_ID
    , P_ORG_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );

    BEGIN
      SELECT HT.APPROVE_STATUS
          , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', HT.APPROVE_STATUS, HT.SOB_ID, HT.ORG_ID) AS APPROVE_STATUS_NAME
        INTO O_APPROVE_STATUS
          , O_APPROVE_STATUS_NAME
        FROM HRD_HOLY_TYPE HT
      WHERE HT.HOLY_TYPE_ID     = P_HOLY_TYPE_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_APPROVE_STATUS := 'N';
      O_APPROVE_STATUS_NAME := '승인미요청';
    END;
  END DATA_INSERT;

-- DATA UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_HOLY_TYPE_ID        IN HRD_HOLY_TYPE.HOLY_TYPE_ID%TYPE
            , P_PERSON_ID           IN HRD_HOLY_TYPE.PERSON_ID%TYPE
            , P_START_DATE          IN HRD_HOLY_TYPE.START_DATE%TYPE
            , P_END_DATE            IN HRD_HOLY_TYPE.END_DATE%TYPE
            , P_HOLY_TYPE           IN HRD_HOLY_TYPE.HOLY_TYPE%TYPE
            , P_DESCRIPTION         IN HRD_HOLY_TYPE.DESCRIPTION%TYPE
            , P_SOB_ID              IN HRD_HOLY_TYPE.SOB_ID%TYPE
            , P_ORG_ID              IN HRD_HOLY_TYPE.ORG_ID%TYPE
            , P_USER_ID             IN HRD_HOLY_TYPE.CREATED_BY%TYPE
            )
  AS
   V_APPROVE_STATUS                HRD_DUTY_PERIOD.APPROVE_STATUS%TYPE := 'N';
   V_SYSDATE                       DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_CORP_ID         NUMBER;
    V_WORK_CORP_ID    NUMBER;


  BEGIN
    BEGIN
      SELECT PM.CORP_ID, PM.WORK_CORP_ID
        INTO V_CORP_ID, V_WORK_CORP_ID
        FROM HRM_PERSON_MASTER PM
      WHERE PM.PERSON_ID        = P_PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CORP_ID := 0;
      V_WORK_CORP_ID := 0;
    END;
   BEGIN
    SELECT HT.APPROVE_STATUS
        INTO V_APPROVE_STATUS
        FROM HRD_HOLY_TYPE HT
      WHERE HT.HOLY_TYPE_ID           = W_HOLY_TYPE_ID
      ;
  EXCEPTION WHEN OTHERS THEN
    V_APPROVE_STATUS := 'N';
  END;
  IF V_APPROVE_STATUS NOT IN('N', 'A') THEN
    RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=수정'));
   RETURN;
  END IF;

    UPDATE HRD_HOLY_TYPE
      SET PERSON_ID         = P_PERSON_ID
      , START_DATE          = P_START_DATE
      , END_DATE            = P_END_DATE
      , CORP_ID             = V_CORP_ID
      , WORK_CORP_ID        = V_WORK_CORP_ID
      , HOLY_TYPE           = P_HOLY_TYPE
      , DESCRIPTION         = P_DESCRIPTION
      , LAST_UPDATE_DATE    = V_SYSDATE
      , LAST_UPDATED_BY     = P_USER_ID
    WHERE HOLY_TYPE_ID      = W_HOLY_TYPE_ID
  ;

  END DATA_UPDATE;

-- DATA DELETE.
  PROCEDURE DATA_DELETE
           ( W_HOLY_TYPE_ID       IN HRD_HOLY_TYPE.HOLY_TYPE_ID%TYPE
      )
  AS
    V_APPROVE_STATUS               HRD_HOLY_TYPE.APPROVE_STATUS%TYPE := 'N';

 BEGIN
   BEGIN
    SELECT HT.APPROVE_STATUS
        INTO V_APPROVE_STATUS
        FROM HRD_HOLY_TYPE HT
      WHERE HT.HOLY_TYPE_ID           = W_HOLY_TYPE_ID
      ;
  EXCEPTION WHEN OTHERS THEN
    V_APPROVE_STATUS := 'N';
  END;
  IF V_APPROVE_STATUS NOT IN('A', 'N') THEN
    RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10029', '&&VALUE:=해당 자료'));
  END IF;

  DELETE HRD_HOLY_TYPE HT
  WHERE HT.HOLY_TYPE_ID           = W_HOLY_TYPE_ID
  ;
  END DATA_DELETE;

-- DATA UPDATE REQUEST.
  PROCEDURE DATA_UPDATE_REQUEST
            ( W_HOLY_TYPE_ID       IN HRD_HOLY_TYPE.HOLY_TYPE_ID%TYPE
            , O_APPROVE_STATUS     OUT VARCHAR2
            , O_APPROVE_STATUS_NAME    OUT VARCHAR2
            )
  AS
    V_APPROVE_STATUS              VARCHAR2(1);

  BEGIN
    BEGIN
    SELECT HT.APPROVE_STATUS
     INTO V_APPROVE_STATUS
   FROM HRD_HOLY_TYPE HT
   WHERE HT.HOLY_TYPE_ID       = W_HOLY_TYPE_ID
   ;
  EXCEPTION WHEN OTHERS THEN
    V_APPROVE_STATUS := 'N';
  END;
  IF V_APPROVE_STATUS NOT IN('A', 'N') THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=Approval Request(승인요청)'));
    END IF;

    UPDATE HRD_HOLY_TYPE HT
      SET HT.APPROVE_STATUS     = 'A'
        , HT.EMAIL_STATUS       = 'AR'
    WHERE HT.HOLY_TYPE_ID       = W_HOLY_TYPE_ID
    ;

    O_APPROVE_STATUS := 'A';
    BEGIN
      SELECT HAS.APPROVE_STEP_NAME
        INTO O_APPROVE_STATUS_NAME
        FROM HRM_APPROVE_STATUS_V HAS
      WHERE HAS.APPROVE_STEP        = O_APPROVE_STATUS
        AND ROWNUM                  <= 1
      ;
    EXCEPTION
      WHEN OTHERS THEN
        O_APPROVE_STATUS_NAME := '미승인';
    END;
  END DATA_UPDATE_REQUEST;


-- DATA UPDATE - STEP APPROVE.
   PROCEDURE DATA_UPDATE_APPROVE
           ( W_HOLY_TYPE_ID       IN  HRD_HOLY_TYPE.HOLY_TYPE_ID%TYPE
           , P_APPROVE_STATUS     IN  HRD_HOLY_TYPE.APPROVE_STATUS%TYPE
           , P_CHECK_YN           IN  VARCHAR2
           , P_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
           , P_APPROVE_FLAG       IN  VARCHAR2
           , P_SOB_ID             IN  HRD_HOLY_TYPE.SOB_ID%TYPE
           , P_ORG_ID             IN  HRD_HOLY_TYPE.ORG_ID%TYPE
           , P_USER_ID            IN  HRD_HOLY_TYPE.CREATED_BY%TYPE
           )

   AS

             V_APPROVE_STATUS         VARCHAR2(10) := 'N';
             V_CAP_B                  VARCHAR2(1)  := 'N';
             V_CAP_C                  VARCHAR2(1)  := 'N';

   BEGIN
         BEGIN
              SELECT HRM_MANAGER_G.USER_CAP_F(PM.WORK_CORP_ID --< PM.CORP_ID [2011-06-28] 수정
                                             , TRUNC(HT.START_DATE)
                                             , TRUNC(HT.END_DATE)
                                             , '20'
                                             , P_CONNECT_PERSON_ID
                                             , P_SOB_ID
                                             , P_ORG_ID
                                             ) AS CAP_C
                   , HRD_DUTY_MANAGER_G.APPROVER_CAP_F( NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                                                      , P_CONNECT_PERSON_ID
                                                      , P_SOB_ID
                                                      , P_ORG_ID
                                                      ) AS CAP_B
                INTO V_CAP_C
                   , V_CAP_B
                FROM HRD_HOLY_TYPE HT
                   , HRM_PERSON_MASTER PM
                   ,(-- 시점 인사내역.
                     SELECT HL.PERSON_ID
                          , HL.POST_ID
                          , HL.JOB_CATEGORY_ID
                          , HL.JOB_CLASS_ID
                          , HL.OCPT_ID
                       FROM HRM_HISTORY_LINE HL
                      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                       FROM HRM_HISTORY_LINE      S_HL
                                                      WHERE S_HL.PERSON_ID     =  HL.PERSON_ID
                                                        AND S_HL.CHARGE_DATE  <= (SELECT TRUNC(HT1.END_DATE) AS END_DATE
                                                                                    FROM HRD_HOLY_TYPE          HT1
                                                                                   WHERE HT1.HOLY_TYPE_ID     = W_HOLY_TYPE_ID
                                                                                  )
                                                   GROUP BY S_HL.PERSON_ID
                                                   )
                    ) T1
                   ,(-- 시점 인사내역.
                     SELECT PH.PERSON_ID
                          , PH.FLOOR_ID
                          , PH.DEPT_ID
                          , PH.WORK_TYPE_ID
                       FROM HRD_PERSON_HISTORY        PH
                      WHERE PH.EFFECTIVE_DATE_FR  <=  ( SELECT TRUNC(HT1.END_DATE) END_DATE
                                                          FROM HRD_HOLY_TYPE       HT1
                                                         WHERE HT1.HOLY_TYPE_ID  = W_HOLY_TYPE_ID
                                                      )
                        AND PH.EFFECTIVE_DATE_TO  >=  ( SELECT TRUNC(HT1.END_DATE) END_DATE
                                                          FROM HRD_HOLY_TYPE       HT1
                                                         WHERE HT1.HOLY_TYPE_ID  = W_HOLY_TYPE_ID
                                                      )
                    ) T2
               WHERE HT.PERSON_ID          = PM.PERSON_ID
                 AND HT.SOB_ID             = PM.SOB_ID
                 AND HT.ORG_ID             = PM.ORG_ID
                 AND PM.PERSON_ID          = T1.PERSON_ID
                 AND PM.PERSON_ID          = T2.PERSON_ID
                 AND HT.HOLY_TYPE_ID       = W_HOLY_TYPE_ID
                   ;

         EXCEPTION
              WHEN OTHERS
              THEN
                   V_CAP_B := 'N';
                   V_CAP_C := 'N';
         END;

         IF P_CHECK_YN = 'N' THEN
            NULL;
         ELSIF P_APPROVE_STATUS = 'A' AND P_APPROVE_FLAG = 'OK' THEN
            -- 미승인 --> 1차 승인 : 승인.
            IF V_CAP_B <> 'Y' THEN
               RAISE ERRNUMS.Approval_Nothing;
            END IF;

            UPDATE HRD_HOLY_TYPE HT
             SET HT.APPROVED_YN            = DECODE(P_CHECK_YN, 'Y', 'Y', HT.APPROVED_YN)
               , HT.APPROVED_DATE          = DECODE(P_CHECK_YN, 'Y', GET_LOCAL_DATE(HT.SOB_ID), HT.APPROVED_DATE)
               --, HT.APPROVED_PERSON_ID     = DECODE(P_CHECK_YN, 'Y', P_CONNECT_PERSON_ID, HT.APPROVED_PERSON_ID)
               , HT.APPROVED_PERSON_ID     = P_CONNECT_PERSON_ID
               , HT.APPROVE_STATUS         = DECODE(P_CHECK_YN, 'Y', 'B', HT.APPROVE_STATUS)
               , HT.EMAIL_STATUS           = 'AR'
               , HT.LAST_UPDATE_DATE       = GET_LOCAL_DATE(HT.SOB_ID)
               , HT.LAST_UPDATED_BY        = P_USER_ID
               , HT.ATTRIBUTE1             = P_CONNECT_PERSON_ID
           WHERE HT.HOLY_TYPE_ID           = W_HOLY_TYPE_ID
               ;

         ELSIF P_APPROVE_STATUS = 'B' AND P_APPROVE_FLAG = 'CANCEL' THEN
            -- 1차 승인 --> 미승인 : 승인 취소.
            IF V_CAP_B <> 'Y' THEN
               RAISE ERRNUMS.Approval_Nothing;
            END IF;

            BEGIN
                  -- 현재 상태.
                  SELECT HT.APPROVE_STATUS
                    INTO V_APPROVE_STATUS
                    FROM HRD_HOLY_TYPE     HT
                   WHERE HT.HOLY_TYPE_ID = W_HOLY_TYPE_ID
                       ;

            EXCEPTION
                 WHEN OTHERS
                 THEN
                      V_APPROVE_STATUS := 'N';
            END;

            IF V_APPROVE_STATUS <> 'B' THEN
               -- 1ST 승인단계가 아니면 오류 발생.
               RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', ':=취소'));
               RETURN;
            END IF;

            UPDATE HRD_HOLY_TYPE HT
               SET HT.APPROVED_YN           = DECODE(P_CHECK_YN, 'Y', 'N', HT.APPROVED_YN)
                 , HT.APPROVED_DATE         = DECODE(P_CHECK_YN, 'Y', NULL, HT.APPROVED_DATE)
                 --, HT.APPROVED_PERSON_ID    = DECODE(P_CHECK_YN, 'Y', NULL, HT.APPROVED_PERSON_ID)
                 , HT.APPROVE_STATUS        = DECODE(P_CHECK_YN, 'Y', 'A', HT.APPROVE_STATUS)
                 , HT.EMAIL_STATUS          = 'BR'
                 , HT.LAST_UPDATE_DATE      = GET_LOCAL_DATE(HT.SOB_ID)
                 , HT.LAST_UPDATED_BY       = P_USER_ID
                 , HT.ATTRIBUTE1            = HT.APPROVED_PERSON_ID
             WHERE HT.HOLY_TYPE_ID          = W_HOLY_TYPE_ID
                 ;

         ELSIF P_APPROVE_STATUS = 'B' AND P_APPROVE_FLAG = 'OK' AND V_CAP_C = 'C' THEN
            -- 1차 승인  --> 인사 승인: 승인.
            IF V_CAP_C <> 'C' THEN
               RAISE ERRNUMS.Approval_Nothing;
            END IF;

            UPDATE HRD_HOLY_TYPE HT
              SET HT.CONFIRMED_YN           = DECODE(P_CHECK_YN, 'Y', 'Y', HT.CONFIRMED_YN)
                , HT.CONFIRMED_DATE         = DECODE(P_CHECK_YN, 'Y', GET_LOCAL_DATE(HT.SOB_ID), HT.CONFIRMED_DATE)
                --, HT.CONFIRMED_PERSON_ID    = DECODE(P_CHECK_YN, 'Y', P_CONNECT_PERSON_ID, HT.CONFIRMED_PERSON_ID)
                , HT.CONFIRMED_PERSON_ID    = P_CONNECT_PERSON_ID
                , HT.APPROVE_STATUS         = DECODE(P_CHECK_YN, 'Y', 'C', HT.APPROVE_STATUS)
                , HT.LAST_UPDATE_DATE       = GET_LOCAL_DATE(HT.SOB_ID)
                , HT.LAST_UPDATED_BY        = P_USER_ID
                , HT.ATTRIBUTE2             = P_CONNECT_PERSON_ID
            WHERE HT.HOLY_TYPE_ID           = W_HOLY_TYPE_ID
                ;
         ELSIF P_APPROVE_STATUS = 'C' AND P_APPROVE_FLAG = 'CANCEL' AND V_CAP_C = 'C' THEN
            -- 확정 승인 --> 1차 승인 : 승인 취소.
            IF V_CAP_C <> 'C' THEN
               RAISE ERRNUMS.Approval_Nothing;
            END IF;

            UPDATE HRD_HOLY_TYPE HT
               SET HT.CONFIRMED_YN           = DECODE(P_CHECK_YN, 'Y', 'N', HT.CONFIRMED_YN)
                 , HT.CONFIRMED_DATE         = DECODE(P_CHECK_YN, 'Y', NULL, HT.CONFIRMED_DATE)
                 --, HT.CONFIRMED_PERSON_ID    = DECODE(P_CHECK_YN, 'Y', NULL, HT.CONFIRMED_PERSON_ID)
                 , HT.APPROVE_STATUS         = DECODE(P_CHECK_YN, 'Y', 'B', HT.APPROVE_STATUS)
                 , HT.LAST_UPDATE_DATE       = GET_LOCAL_DATE(HT.SOB_ID)
                 , HT.LAST_UPDATED_BY        = P_USER_ID
                 , HT.ATTRIBUTE2             = HT.CONFIRMED_PERSON_ID
             WHERE HT.HOLY_TYPE_ID           = W_HOLY_TYPE_ID
                 ;
         ELSE
            -- 승인단계 선택 안함.
            RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10043', ':=승인상태:=승인상태를 선택후 다시 처리하세요'));
            RETURN;
         END IF;

         COMMIT;

         EXCEPTION
              WHEN ERRNUMS.Approval_Nothing
              THEN
                   RAISE_APPLICATION_ERROR(ERRNUMS.Approval_Nothing_Code, ERRNUMS.Approval_Nothing_Desc);

  END DATA_UPDATE_APPROVE;


-- 트리거에서 호출하는 프로시져.
   PROCEDURE WORK_CALENDAR_UPDATE
           ( P_GB            IN  VARCHAR2
           , P_HOLY_TYPE_ID  IN  NUMBER
           , P_PERSON_ID     IN  NUMBER
           , P_START_DATE    IN  DATE
           , P_END_DATE      IN  DATE
           , P_HOLY_TYPE     IN  VARCHAR2
           , P_SOB_ID        IN  NUMBER
           , P_ORG_ID        IN  NUMBER
           , P_USER_ID       IN  NUMBER
           )

   AS

   BEGIN

             IF P_GB = 'I' THEN
                UPDATE HRD_WORK_CALENDAR WC
                  SET WC.DUTY_ID    =  CASE
                                           WHEN P_HOLY_TYPE IN('1') THEN HRM_COMMON_G.GET_ID_F('DUTY', ' CODE = ''51''', P_SOB_ID, P_ORG_ID)  -- 유휴.
                                           WHEN P_HOLY_TYPE IN('0') THEN HRM_COMMON_G.GET_ID_F('DUTY', ' CODE = ''52''', P_SOB_ID, P_ORG_ID)  -- 무휴.
                                           ELSE HRM_COMMON_G.GET_ID_F('DUTY', ' CODE = ''00''', P_SOB_ID, P_ORG_ID)                           -- 그외.
                                       END
                    , WC.HOLY_TYPE  =  P_HOLY_TYPE
                    , WC.ATTRIBUTE4 =  WC.HOLY_TYPE
                WHERE WC.PERSON_ID  =  P_PERSON_ID
                  AND WC.WORK_DATE     BETWEEN P_START_DATE AND P_END_DATE
                ;
             ELSE
                UPDATE HRD_WORK_CALENDAR WC
                  SET WC.DUTY_ID    =  CASE
                                            WHEN WC.ATTRIBUTE4 IN('1') THEN HRM_COMMON_G.GET_ID_F('DUTY', ' CODE = ''51''', P_SOB_ID, P_ORG_ID)  -- 유휴.
                                            WHEN WC.ATTRIBUTE4 IN('0') THEN HRM_COMMON_G.GET_ID_F('DUTY', ' CODE = ''52''', P_SOB_ID, P_ORG_ID)  -- 무휴.
                                            ELSE HRM_COMMON_G.GET_ID_F('DUTY', ' CODE = ''00''', P_SOB_ID, P_ORG_ID)                             -- 그외.
                                       END
                    , WC.HOLY_TYPE  =  WC.ATTRIBUTE4
                WHERE WC.PERSON_ID  =  P_PERSON_ID
                  AND WC.WORK_DATE     BETWEEN P_START_DATE AND P_END_DATE
                ;
             END IF;

             /*=========================================================================================/
                --> OPEN 시간 CLOSE 시간 설정
             /=========================================================================================*/
             UPDATE HRD_WORK_CALENDAR WC
                SET(WC.OPEN_TIME
                  , WC.CLOSE_TIME
                   ) =
                       (SELECT TO_DATE(TO_CHAR(WC.WORK_DATE, 'YYYY-MM-DD') || '-' || WIT.I_TIME, 'YYYY-MM-DD HH24:MI') + WIT.I_ADD_DAYS AS OPEN_TIME
                             , TO_DATE(TO_CHAR(WC.WORK_DATE, 'YYYY-MM-DD') || '-' || WIT.O_TIME, 'YYYY-MM-DD HH24:MI') + WIT.O_ADD_DAYS AS OPEN_TIME
                          FROM HRM_WORK_IO_TIME_V WIT
                         WHERE WIT.WORK_TYPE          = WC.ATTRIBUTE5             -- WORK_TYPE.
                           AND WIT.HOLY_TYPE          = WC.HOLY_TYPE
                           AND WIT.ENABLED_FLAG       = 'Y'
                           AND WIT.EFFECTIVE_DATE_FR <= WC.WORK_DATE
                           AND(WIT.EFFECTIVE_DATE_TO    IS NULL
                            OR WIT.EFFECTIVE_DATE_TO >= WC.WORK_DATE
                              )
                           AND WIT.SOB_ID             = WC.SOB_ID
                           AND WIT.ORG_ID             = WC.ORG_ID
                       )
             WHERE WC.WORK_DATE  BETWEEN P_START_DATE AND P_END_DATE
               AND WC.SOB_ID  =  P_SOB_ID
               AND WC.ORG_ID  =  P_ORG_ID
              ;

   END WORK_CALENDAR_UPDATE;


END HRD_HOLY_TYPE_G;
/
