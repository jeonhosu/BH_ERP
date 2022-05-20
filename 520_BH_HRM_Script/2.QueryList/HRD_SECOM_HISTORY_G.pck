CREATE OR REPLACE PACKAGE HRD_SECOM_HISTORY_G
AS

-- 세콤 자료 조회.
  PROCEDURE DATA_SECOM_HISTORY
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_MODULE_TYPE                       IN VARCHAR2
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_NAME                              IN VARCHAR2
            , W_SOB_ID                            IN HRD_SECOM_HISTORY.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_SECOM_HISTORY.ORG_ID%TYPE
            );
           

---------------------------------------------------------------------------------------------------
-- 기존 자료수 체크.
  PROCEDURE SECOM_HISTORY_COUNT
            ( W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN HRD_SECOM_HISTORY.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_SECOM_HISTORY.ORG_ID%TYPE
            , O_COUNT                             OUT NUMBER
            );
            
-- SECOM HISTORY 자료 --> 출퇴근 INTERFACE TABLE에 이첩.
  PROCEDURE SET_INTERFACE
            ( W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
            , W_SOB_ID                            IN HRD_SECOM_HISTORY.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_SECOM_HISTORY.ORG_ID%TYPE
            , W_MODULE_TYPE                       IN VARCHAR2
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , P_USER_ID                           IN NUMBER
            , O_MESSAGE                           OUT VARCHAR2
            );

-- 임시 세콤 자료 조회.
  PROCEDURE TEMP_SECOM_HISTORY_SELECT
            ( P_CURSOR2                           OUT TYPES.TCURSOR2
            , W_SOB_ID                            IN HRD_SECOM_HISTORY.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_SECOM_HISTORY.ORG_ID%TYPE
            );
            
-- 세콤 자료 INSERT. 
  PROCEDURE SECOM_HISTORY_INSERT
            ( P_ATIME           IN HRD_SECOM_HISTORY.ATIME%TYPE
            , P_ID_SEQ          IN HRD_SECOM_HISTORY.ID_SEQ%TYPE
            , P_EQCODE_A        IN HRD_SECOM_HISTORY.EQCODE_A%TYPE
            , P_MASTER_A        IN HRD_SECOM_HISTORY.MASTER_A%TYPE
            , P_LOCAL_A         IN HRD_SECOM_HISTORY.LOCAL_A%TYPE
            , P_POINT_A         IN HRD_SECOM_HISTORY.POINT_A%TYPE
            , P_LOOP_A          IN HRD_SECOM_HISTORY.LOOP_A%TYPE
            , P_EQNAME          IN HRD_SECOM_HISTORY.EQNAME%TYPE
            , P_STATE           IN HRD_SECOM_HISTORY.STATE%TYPE
            , P_PARAM_A         IN HRD_SECOM_HISTORY.PARAM_A%TYPE
            , P_USER_A          IN HRD_SECOM_HISTORY.USER_A%TYPE
            , P_CONTENT_A       IN HRD_SECOM_HISTORY.CONTENT_A%TYPE
            , P_ACK             IN HRD_SECOM_HISTORY.ACK%TYPE
            , P_ACKUSER         IN HRD_SECOM_HISTORY.ACKUSER%TYPE
            , P_ACKCONTENT      IN HRD_SECOM_HISTORY.ACKCONTENT%TYPE
            , P_ACKTIME         IN HRD_SECOM_HISTORY.ACKTIME%TYPE
            , P_TRANSFER        IN HRD_SECOM_HISTORY.TRANSFER%TYPE
            , P_MODE_A          IN HRD_SECOM_HISTORY.MODE_A%TYPE
            , P_SOB_ID          IN HRD_SECOM_HISTORY.SOB_ID%TYPE
            , P_ORG_ID          IN HRD_SECOM_HISTORY.ORG_ID%TYPE
            , P_CREATION_DATE   IN HRD_SECOM_HISTORY.CREATION_DATE%TYPE
            , P_USER_ID         IN HRD_SECOM_HISTORY.CREATED_BY%TYPE 
            );

-- 기존 자료수 체크.
  PROCEDURE SECOM_HISTORY_DELETE
            ( W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN HRD_SECOM_HISTORY.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_SECOM_HISTORY.ORG_ID%TYPE
            );
            
END HRD_SECOM_HISTORY_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRD_SECOM_HISTORY_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_SECOM_HISTORY_G
/* DESCRIPTION  : 세콤 근태/식수 자료 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- 세콤 자료 조회.
  PROCEDURE DATA_SECOM_HISTORY
	          ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_MODULE_TYPE                       IN VARCHAR2
						, W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_NAME                              IN VARCHAR2
            , W_SOB_ID                            IN HRD_SECOM_HISTORY.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_SECOM_HISTORY.ORG_ID%TYPE
            )
  AS
    V_MODULE_TYPE                 VARCHAR2(10) := NULL; 
    
  BEGIN	
    IF W_MODULE_TYPE = 'A' THEN
      OPEN P_CURSOR FOR
        SELECT TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS') AS CHECK_DATE_TIME
             , TO_DATE(SH.A_DATE, 'YYYY-MM-DD') AS CHECK_DATE
             , TO_CHAR(TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS'), 'HH24:MI') AS CHECK_TIME
             , SH.ID_SEQ
             , SH.EQCODE_A
             , SH.MASTER_A
             , HDV.DEVICE_NAME
             , SH.LOCAL_A
             , SH.STATE
             , SSV.SECOM_STATUS_NAME
             , PM.NAME
             , SH.USER_A
             , SH.CONTENT_A             
             , SH.ACK
             , SH.ACKUSER
             , SH.ACKCONTENT
             , SH.ACKTIME
             , SH.TRANSFER
             , SH.MODE_A
             , SH.CREATION_DATE
             , EAPP_USER_G.USER_NAME_F(SH.CREATED_BY) AS CREATED_USER_NAME
          FROM HRD_SECOM_HISTORY SH 
            , HRM_DEVICE_V HDV
            , HRM_SECOM_STATUS_V SSV
            , HRM_PERSON_MASTER_V8 PM
         WHERE SH.MASTER_A                = HDV.SECOM_DEVICE_CODE(+)
           AND SH.SOB_ID                  = HDV.SOB_ID(+)
           AND SH.ORG_ID                  = HDV.ORG_ID(+)
           AND SH.STATE                   = SSV.SECOM_STATUS(+)
           AND SH.SOB_ID                  = SSV.SOB_ID(+)
           AND SH.ORG_ID                  = SSV.ORG_ID(+)
           AND SH.JUMIN_NUM               = PM.REPRE_NUM_1(+)
           AND SH.SOB_ID                  = PM.SOB_ID(+)
           AND SH.ORG_ID                  = PM.ORG_ID(+)
           AND SUBSTR(SH.ATIME, 1, 8)     BETWEEN TO_CHAR(W_START_DATE, 'YYYYMMDD') AND TO_CHAR(W_END_DATE, 'YYYYMMDD')
           AND SH.SOB_ID                  = W_SOB_ID
           AND SH.ORG_ID                  = W_ORG_ID
           AND NVL(SH.CONTENT_A, '%')     LIKE '%' || W_NAME || '%'
        ORDER BY TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS'), SH.ID_SEQ  
        ;
    ELSE 
      IF W_MODULE_TYPE = 'D' THEN 
        V_MODULE_TYPE := 'DUTY';
      ELSIF W_MODULE_TYPE = 'F' THEN
        V_MODULE_TYPE := 'FOOD';
      ELSE
        V_MODULE_TYPE := W_MODULE_TYPE;
      END IF;
            
      OPEN P_CURSOR FOR
        SELECT TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS') AS CHECK_DATE_TIME
             , TO_DATE(SH.A_DATE, 'YYYY-MM-DD') AS CHECK_DATE
             , TO_CHAR(TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS'), 'HH24:MI') AS CHECK_TIME
             , SH.ID_SEQ
             , SH.EQCODE_A
             , SH.MASTER_A
             , HDV.DEVICE_NAME
             , SH.LOCAL_A
             , SH.STATE
             , SSV.SECOM_STATUS_NAME
             , PM.NAME
             , SH.USER_A
             , SH.CONTENT_A             
             , SH.ACK
             , SH.ACKUSER
             , SH.ACKCONTENT
             , SH.ACKTIME
             , SH.TRANSFER
             , SH.MODE_A
             , SH.CREATION_DATE
             , EAPP_USER_G.USER_NAME_F(SH.CREATED_BY) AS CREATED_USER_NAME
          FROM HRD_SECOM_HISTORY SH 
            , HRM_DEVICE_V HDV
            , HRM_SECOM_STATUS_V SSV
            , HRM_PERSON_MASTER_V8 PM
         WHERE SH.MASTER_A                = HDV.SECOM_DEVICE_CODE(+)
           AND SH.SOB_ID                  = HDV.SOB_ID(+)
           AND SH.ORG_ID                  = HDV.ORG_ID(+)
           AND SH.STATE                   = SSV.SECOM_STATUS(+)
           AND SH.SOB_ID                  = SSV.SOB_ID(+)
           AND SH.ORG_ID                  = SSV.ORG_ID(+)
           AND SH.JUMIN_NUM               = PM.REPRE_NUM_1(+)
           AND SH.SOB_ID                  = PM.SOB_ID(+)
           AND SH.ORG_ID                  = PM.ORG_ID(+)
           AND SUBSTR(SH.ATIME, 1, 8)     BETWEEN TO_CHAR(W_START_DATE, 'YYYYMMDD') AND TO_CHAR(W_END_DATE, 'YYYYMMDD')
           AND SH.SOB_ID                  = W_SOB_ID
           AND SH.ORG_ID                  = W_ORG_ID
           AND NVL(SH.CONTENT_A, '%')     LIKE '%' || W_NAME || '%'
           AND EXISTS ( SELECT 'X'
                          FROM HRM_SECOM_STATUS_V SSV
                         WHERE SSV.SECOM_STATUS   = SH.STATE
                           AND SSV.SOB_ID         = SH.SOB_ID
                           AND SSV.ORG_ID         = SH.ORG_ID
                           AND SSV.MODULE_TYPE    = NVL(V_MODULE_TYPE, SSV.MODULE_TYPE)
                       )
        ORDER BY TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS'), SH.ID_SEQ  
        ;
      END IF;
      
  END DATA_SECOM_HISTORY;

---------------------------------------------------------------------------------------------------
-- 기존 자료수 체크.
  PROCEDURE SECOM_HISTORY_COUNT
            ( W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN HRD_SECOM_HISTORY.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_SECOM_HISTORY.ORG_ID%TYPE
            , O_COUNT                             OUT NUMBER
            )
  AS
  BEGIN
    BEGIN
      SELECT COUNT(SH.ATIME) AS RECORD_COUNT
        INTO O_COUNT
        FROM HRD_SECOM_HISTORY SH
       WHERE SUBSTR(SH.ATIME, 1, 8)     BETWEEN TO_CHAR(W_START_DATE, 'YYYYMMDD') AND TO_CHAR(W_END_DATE, 'YYYYMMDD')
         AND SH.SOB_ID                  = W_SOB_ID
         AND SH.ORG_ID                  = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_COUNT := 0;
    END;
    
  END SECOM_HISTORY_COUNT;
  
-- SECOM HISTORY 자료 --> 출퇴근 INTERFACE TABLE에 이첩.
  PROCEDURE SET_INTERFACE
            ( W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
            , W_SOB_ID                            IN HRD_SECOM_HISTORY.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_SECOM_HISTORY.ORG_ID%TYPE
            , W_MODULE_TYPE                       IN VARCHAR2
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , P_USER_ID                           IN NUMBER
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    V_SYSDATE                                     DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_ERROR_COUNT                                 NUMBER := 0;
    
  BEGIN
    -- 1. HRD_SECOM_HISTORY 정리.
    BEGIN
      UPDATE HRD_SECOM_HISTORY SH
         SET SH.A_DATE = SUBSTR(SH.ATIME, 1, 8)
           , SH.A_TIME = SUBSTR(SH.ATIME, 9, 6)
           , SH.JUMIN_NUM = CASE 
                              WHEN SUBSTR(SH.CONTENT_A, 1, 1) = '0' THEN SH.CONTENT_A
                              ELSE SUBSTR(SH.CONTENT_A, 1, 13)
                            END 
      WHERE SUBSTR(SH.ATIME, 1, 8) BETWEEN TO_CHAR(W_START_DATE, 'YYYYMMDD') AND TO_CHAR(W_END_DATE, 'YYYYMMDD')
        AND SH.SOB_ID                  = W_SOB_ID
        AND SH.ORG_ID                  = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := SQLERRM;
      RAISE ERRNUMS.Update_Error;
    END;
    COMMIT;
--DBMS_OUTPUT.PUT_LINE('START DATE : ' || TO_CHAR(W_START_DATE, 'YYYY-MM-DD') || ', END DATE : ' || TO_CHAR(W_END_DATE, 'YYYY-MM-DD'));

    -- 2 근태 : SECOM HISTORY --> HRD_ATTEND_INTERFACE TRANSFER.
    IF W_MODULE_TYPE IN ('A', 'D') THEN
      -- 2.1 자사 임직원 처리 --
      BEGIN
        DELETE FROM HRD_ATTEND_INTERFACE HAI
        WHERE HAI.IO_DATE           BETWEEN W_START_DATE AND W_END_DATE
          AND HAI.CREATED_FLAG      = 'I'
          AND EXISTS ( SELECT 'X'
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.PERSON_ID      = HAI.PERSON_ID
                          AND PM.ORI_JOIN_DATE  <= HAI.IO_DATE
                          AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= HAI.IO_DATE)
                          AND PM.WORK_CORP_ID   = W_CORP_ID
                          AND PM.SOB_ID         = W_SOB_ID
                          AND PM.ORG_ID         = W_ORG_ID
                      )
        ;
        
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := '2.1 Duty Delete Error : ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
        RAISE ERRNUMS.Delete_Error;  
      END;
      COMMIT;
      
      BEGIN        
        INSERT INTO HRD_ATTEND_INTERFACE
        SELECT DISTINCT NVL(HDV.DEVICE_ID, -1) AS DEVICE_ID
             , PM.PERSON_ID
             , SSV.CHECK_FLAG
             , TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS') AS CHECK_DATE_TIME
             , TO_DATE(SH.A_DATE, 'YYYY-MM-DD') AS CHECK_DATE
             , TO_CHAR(TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS'), 'HH24:MI') AS CHECK_TIME
             , 'I' AS CREATED_FLAG
             , PM.PERSON_NUM AS CARD_NUM
             , PM.SOB_ID
             , PM.ORG_ID
             , V_SYSDATE AS CREATION_DATE
             , P_USER_ID
             , V_SYSDATE AS LAST_UPDATE_DATE
             , P_USER_ID
          FROM HRD_SECOM_HISTORY SH 
            , ( SELECT HD.DEVICE_ID
                       , HD.SECOM_DEVICE_CODE
                       , HD.SOB_ID
                       , HD.ORG_ID
                    FROM HRM_DEVICE_V HD
                  WHERE HD.SOB_ID           = W_SOB_ID
                    AND HD.ORG_ID           = W_ORG_ID
              ) HDV
            , HRM_SECOM_STATUS_V SSV
            , HRM_PERSON_MASTER PM
         WHERE SH.MASTER_A                = HDV.SECOM_DEVICE_CODE(+)
           AND SH.SOB_ID                  = HDV.SOB_ID(+)
           AND SH.ORG_ID                  = HDV.ORG_ID(+)
           AND SH.STATE                   = SSV.SECOM_STATUS
           AND SH.SOB_ID                  = SSV.SOB_ID
           AND SH.ORG_ID                  = SSV.ORG_ID
           AND SH.JUMIN_NUM               = REPLACE(PM.REPRE_NUM, '-', '')
           AND SH.SOB_ID                  = PM.SOB_ID
           AND SH.ORG_ID                  = PM.ORG_ID
           AND PM.WORK_CORP_ID            = W_CORP_ID
           AND PM.SOB_ID                  = W_SOB_ID
           AND PM.ORG_ID                  = W_ORG_ID
           AND SH.STATE                   LIKE 'W%'
           AND PM.ORI_JOIN_DATE           <= TO_DATE(SH.A_DATE, 'YYYY-MM-DD')
           AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= TO_DATE(SH.A_DATE, 'YYYY-MM-DD'))
           AND SUBSTR(SH.ATIME, 1, 8)     BETWEEN TO_CHAR(W_START_DATE, 'YYYYMMDD') AND TO_CHAR(W_END_DATE, 'YYYYMMDD')
        ORDER BY TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS')   
        ;
      EXCEPTION WHEN OTHERS THEN
        V_ERROR_COUNT := V_ERROR_COUNT + 1;
        DBMS_OUTPUT.PUT_LINE('2.1 Duty Insert Error : ' || SQLERRM);
      END;
      
      -- 카드번호 등록자 처리 --
      FOR C1 IN ( SELECT PM.PERSON_ID
                       , PM.PERSON_NUM
                       , PM.OLD_PERSON_NUM AS CARD_NUM
                       , LENGTH(PM.OLD_PERSON_NUM) AS CARD_NUM_LENGTH
                       , PM.SOB_ID
                       , PM.ORG_ID
                    FROM HRM_PERSON_MASTER PM
                  WHERE PM.CORP_ID                  = W_CORP_ID
                    AND PM.SOB_ID                   = W_SOB_ID
                    AND PM.ORG_ID                   = W_ORG_ID
                    AND PM.JOIN_DATE                <= W_END_DATE
                    AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_START_DATE)
                    AND PM.OLD_PERSON_NUM           IS NOT NULL
                )
      LOOP
        BEGIN        
          INSERT INTO HRD_ATTEND_INTERFACE
          SELECT DISTINCT NVL(HDV.DEVICE_ID, -1) AS DEVICE_ID
               , C1.PERSON_ID
               , SSV.CHECK_FLAG
               , TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS') AS CHECK_DATE_TIME
               , TO_DATE(SH.A_DATE, 'YYYY-MM-DD') AS CHECK_DATE
               , TO_CHAR(TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS'), 'HH24:MI') AS CHECK_TIME
               , 'I' AS CREATED_FLAG
               , C1.PERSON_NUM AS CARD_NUM
               , C1.SOB_ID
               , C1.ORG_ID
               , V_SYSDATE AS CREATION_DATE
               , P_USER_ID
               , V_SYSDATE AS LAST_UPDATE_DATE
               , P_USER_ID
            FROM HRD_SECOM_HISTORY SH 
              , ( SELECT HD.DEVICE_ID
                       , HD.SECOM_DEVICE_CODE
                       , HD.SOB_ID
                       , HD.ORG_ID
                    FROM HRM_DEVICE_V HD
                  WHERE HD.SOB_ID           = W_SOB_ID
                    AND HD.ORG_ID           = W_ORG_ID
                ) HDV
              , HRM_SECOM_STATUS_V SSV
           WHERE SH.MASTER_A                = HDV.SECOM_DEVICE_CODE(+)
             AND SH.SOB_ID                  = HDV.SOB_ID(+)
             AND SH.ORG_ID                  = HDV.ORG_ID(+)
             AND SH.STATE                   = SSV.SECOM_STATUS
             AND SH.SOB_ID                  = SSV.SOB_ID
             AND SH.ORG_ID                  = SSV.ORG_ID
             AND SUBSTR(SH.JUMIN_NUM, 1, C1.CARD_NUM_LENGTH)  = C1.CARD_NUM
             AND SH.SOB_ID                  = W_SOB_ID
             AND SH.ORG_ID                  = W_ORG_ID
             AND SH.STATE                   LIKE 'W%'
             AND SUBSTR(SH.ATIME, 1, 8)     BETWEEN TO_CHAR(W_START_DATE, 'YYYYMMDD') AND TO_CHAR(W_END_DATE, 'YYYYMMDD')
          ORDER BY TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS')   
          ;
        EXCEPTION WHEN OTHERS THEN
          V_ERROR_COUNT := V_ERROR_COUNT + 1;
          DBMS_OUTPUT.PUT_LINE('2.1 Duty Insert Error : ' || SQLERRM);
        END;
      
      END LOOP C1;
      
      /*-- 2.3 파견직 처리 --
      BEGIN
        DELETE FROM HRD_ATTEND_INTERFACE HAI
        WHERE HAI.IO_DATE           BETWEEN W_START_DATE AND W_END_DATE
          AND HAI.CREATED_FLAG      = 'I'
          AND EXISTS ( SELECT 'X'
                         FROM HRM_PERSON_DISPATCH PD
                        WHERE PD.PERSON_ID      = HAI.PERSON_ID
                          AND PD.ORI_JOIN_DATE  <= HAI.IO_DATE
                          AND (PD.RETIRE_DATE IS NULL OR PD.RETIRE_DATE >= HAI.IO_DATE)
                          AND PD.CORP_ID        = W_CORP_ID
                          AND PD.SOB_ID         = W_SOB_ID
                          AND PD.ORG_ID         = W_ORG_ID
                      )
        ;
        
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := '2.3 Duty Delete Error : ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
        RAISE ERRNUMS.Delete_Error;  
      END;
      COMMIT;
      
      BEGIN        
        INSERT INTO HRD_ATTEND_INTERFACE
        SELECT DISTINCT HDV.DEVICE_ID
             , PD.PERSON_ID
             , SSV.CHECK_FLAG
             , TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS') AS CHECK_DATE_TIME
             , TO_DATE(SH.A_DATE, 'YYYY-MM-DD') AS CHECK_DATE
             , TO_CHAR(TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS'), 'HH24:MI') AS CHECK_TIME
             , 'I' AS CREATED_FLAG
             , PD.PERSON_NUM AS CARD_NUM
             , PD.SOB_ID
             , PD.ORG_ID
             , V_SYSDATE AS CREATION_DATE
             , P_USER_ID
             , V_SYSDATE AS LAST_UPDATE_DATE
             , P_USER_ID
          FROM HRD_SECOM_HISTORY SH 
            , HRM_DEVICE_V HDV
            , HRM_SECOM_STATUS_V SSV
            , HRM_PERSON_DISPATCH PD
         WHERE SH.MASTER_A                = HDV.SECOM_DEVICE_CODE
           AND SH.SOB_ID                  = HDV.SOB_ID
           AND SH.ORG_ID                  = HDV.ORG_ID
           AND SH.STATE                   = SSV.SECOM_STATUS
           AND SH.SOB_ID                  = SSV.SOB_ID
           AND SH.ORG_ID                  = SSV.ORG_ID
           AND SH.JUMIN_NUM               = REPLACE(PD.REPRE_NUM, '-', '')
           AND SH.SOB_ID                  = PD.SOB_ID
           AND SH.ORG_ID                  = PD.ORG_ID
           AND PD.CORP_ID                 = W_CORP_ID
           AND PD.SOB_ID                  = W_SOB_ID
           AND PD.ORG_ID                  = W_ORG_ID           
           AND PD.ORI_JOIN_DATE           <= TO_DATE(SH.A_DATE, 'YYYY-MM-DD')
           AND (PD.RETIRE_DATE IS NULL OR PD.RETIRE_DATE >= TO_DATE(SH.A_DATE, 'YYYY-MM-DD'))
           AND HDV.MODULE_TYPE            = 'DUTY'
           AND SUBSTR(SH.ATIME, 1, 8)     BETWEEN TO_CHAR(W_START_DATE, 'YYYYMMDD') AND TO_CHAR(W_END_DATE, 'YYYYMMDD')
        ORDER BY TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS')   
        ;
      EXCEPTION WHEN OTHERS THEN
        V_ERROR_COUNT := V_ERROR_COUNT + 1;
        DBMS_OUTPUT.PUT_LINE('2.3 Duty Insert Error : ' || SQLERRM);
      END;
      */
      COMMIT;      
    END IF;
    
    -- 3 사원 식수 : SECOM HISTORY --> HRF_FOOD_INTERFACE TRANSFER.
    IF W_MODULE_TYPE IN ('A', 'F') THEN
      -- 3.1 자사 임직원 처리 --
      BEGIN
        DELETE FROM HRF_FOOD_INTERFACE HFI
        WHERE HFI.FOOD_DATE         BETWEEN W_START_DATE AND W_END_DATE
          AND HFI.CREATED_FLAG      = 'I'
          AND EXISTS ( SELECT 'X'
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.PERSON_ID      = HFI.PERSON_ID
                          AND PM.ORI_JOIN_DATE  <= HFI.FOOD_DATE
                          AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= HFI.FOOD_DATE)
                          AND PM.WORK_CORP_ID   = W_CORP_ID
                          AND PM.SOB_ID         = W_SOB_ID
                          AND PM.ORG_ID         = W_ORG_ID
                      )
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := '3.1 Food Delete Error : ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
        RAISE ERRNUMS.Delete_Error;  
      END;
      
      BEGIN
        INSERT INTO HRF_FOOD_INTERFACE
        SELECT DISTINCT NVL(HDV.DEVICE_ID, -1) DEVICE_ID
             , PM.PERSON_ID
             , SSV.CHECK_FLAG
             , TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS') AS CHECK_DATE_TIME
             , TO_DATE(SH.A_DATE, 'YYYY-MM-DD') AS CHECK_DATE
             , TO_CHAR(TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS'), 'HH24:MI') AS CHECK_TIME
             , 'I' AS CREATED_FLAG
             , NULL AS CARD_NUM
             , 'P' AS CARD_TYPE
             , PM.SOB_ID
             , PM.ORG_ID
             , V_SYSDATE AS CREATION_DATE
             , P_USER_ID
             , V_SYSDATE AS LAST_UPDATE_DATE
             , P_USER_ID
          FROM HRD_SECOM_HISTORY SH 
            , ( SELECT HD.DEVICE_ID
                     , HD.SECOM_DEVICE_CODE
                     , HD.SOB_ID
                     , HD.ORG_ID
                  FROM HRM_DEVICE_V HD
                WHERE HD.SOB_ID           = W_SOB_ID
                  AND HD.ORG_ID           = W_ORG_ID
              ) HDV
            , HRM_SECOM_STATUS_V SSV
            , HRM_PERSON_MASTER PM
         WHERE SH.MASTER_A                = HDV.SECOM_DEVICE_CODE(+)
           AND SH.SOB_ID                  = HDV.SOB_ID(+)
           AND SH.ORG_ID                  = HDV.ORG_ID(+)
           AND SH.STATE                   = SSV.SECOM_STATUS
           AND SH.SOB_ID                  = SSV.SOB_ID
           AND SH.ORG_ID                  = SSV.ORG_ID
           AND SH.JUMIN_NUM               = REPLACE(PM.REPRE_NUM, '-', '')
           AND SH.SOB_ID                  = PM.SOB_ID
           AND SH.ORG_ID                  = PM.ORG_ID
           AND PM.WORK_CORP_ID            = W_CORP_ID
           AND PM.SOB_ID                  = W_SOB_ID
           AND PM.ORG_ID                  = W_ORG_ID
           AND SH.STATE                   LIKE 'F%'
           AND PM.ORI_JOIN_DATE           <= TO_DATE(SH.A_DATE, 'YYYY-MM-DD')
           AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= TO_DATE(SH.A_DATE, 'YYYY-MM-DD'))
           AND SUBSTR(SH.ATIME, 1, 8)     BETWEEN TO_CHAR(W_START_DATE, 'YYYYMMDD') AND TO_CHAR(W_END_DATE, 'YYYYMMDD')
        ORDER BY TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS')   
        ;
      EXCEPTION WHEN OTHERS THEN
        V_ERROR_COUNT := V_ERROR_COUNT + 1;
        DBMS_OUTPUT.PUT_LINE('3.1 Food Insert Error : ' || SQLERRM);
      END;
      
      -- 카드번호 등록자 처리 --
      FOR C1 IN ( SELECT PM.PERSON_ID
                       , PM.PERSON_NUM
                       , PM.OLD_PERSON_NUM AS CARD_NUM
                       , LENGTH(PM.OLD_PERSON_NUM) AS CARD_NUM_LENGTH
                       , PM.SOB_ID
                       , PM.ORG_ID
                    FROM HRM_PERSON_MASTER PM
                  WHERE PM.CORP_ID                  = W_CORP_ID
                    AND PM.SOB_ID                   = W_SOB_ID
                    AND PM.ORG_ID                   = W_ORG_ID
                    AND PM.JOIN_DATE                <= W_END_DATE
                    AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_START_DATE)
                    AND PM.OLD_PERSON_NUM           IS NOT NULL
                )
      LOOP
        BEGIN        
          INSERT INTO HRF_FOOD_INTERFACE
          SELECT DISTINCT NVL(HDV.DEVICE_ID, -1) DEVICE_ID
               , C1.PERSON_ID
               , SSV.CHECK_FLAG
               , TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS') AS CHECK_DATE_TIME
               , TO_DATE(SH.A_DATE, 'YYYY-MM-DD') AS CHECK_DATE
               , TO_CHAR(TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS'), 'HH24:MI') AS CHECK_TIME
               , 'I' AS CREATED_FLAG
               , NULL AS CARD_NUM
               , 'P' AS CARD_TYPE
               , C1.SOB_ID
               , C1.ORG_ID
               , V_SYSDATE AS CREATION_DATE
               , P_USER_ID
               , V_SYSDATE AS LAST_UPDATE_DATE
               , P_USER_ID
            FROM HRD_SECOM_HISTORY SH 
              , ( SELECT HD.DEVICE_ID
                       , HD.SECOM_DEVICE_CODE
                       , HD.SOB_ID
                       , HD.ORG_ID
                    FROM HRM_DEVICE_V HD
                  WHERE HD.SOB_ID           = W_SOB_ID
                    AND HD.ORG_ID           = W_ORG_ID
                ) HDV
              , HRM_SECOM_STATUS_V SSV
           WHERE SH.MASTER_A                = HDV.SECOM_DEVICE_CODE(+)
             AND SH.SOB_ID                  = HDV.SOB_ID(+)
             AND SH.ORG_ID                  = HDV.ORG_ID(+)
             AND SH.STATE                   = SSV.SECOM_STATUS
             AND SH.SOB_ID                  = SSV.SOB_ID
             AND SH.ORG_ID                  = SSV.ORG_ID
             AND SUBSTR(SH.JUMIN_NUM, 1, C1.CARD_NUM_LENGTH)  = C1.CARD_NUM
             AND SH.SOB_ID                  = W_SOB_ID
             AND SH.ORG_ID                  = W_ORG_ID
             AND SH.STATE                   LIKE 'W%'
             AND SUBSTR(SH.ATIME, 1, 8)     BETWEEN TO_CHAR(W_START_DATE, 'YYYYMMDD') AND TO_CHAR(W_END_DATE, 'YYYYMMDD')
          ORDER BY TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS')   
          ;
        EXCEPTION WHEN OTHERS THEN
          V_ERROR_COUNT := V_ERROR_COUNT + 1;
          DBMS_OUTPUT.PUT_LINE('2.1 Duty Insert Error : ' || SQLERRM);
        END;
      END LOOP C1;
      
      /*-- 3.3 파견직 처리 --
      BEGIN
        DELETE FROM HRF_FOOD_INTERFACE HFI
        WHERE HFI.FOOD_DATE         BETWEEN W_START_DATE AND W_END_DATE
          AND HFI.CREATED_FLAG      = 'I'
          AND EXISTS ( SELECT 'X'
                         FROM HRM_PERSON_DISPATCH PD
                        WHERE PD.PERSON_ID      = HFI.PERSON_ID
                          AND PD.ORI_JOIN_DATE  <= HFI.FOOD_DATE
                          AND (PD.RETIRE_DATE IS NULL OR PD.RETIRE_DATE >= HFI.FOOD_DATE)
                          AND PD.WORK_CORP_ID        = W_CORP_ID
                          AND PD.SOB_ID         = W_SOB_ID
                          AND PD.ORG_ID         = W_ORG_ID
                      )
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := '3.3 Food Delete Error : ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
        RAISE ERRNUMS.Delete_Error;  
      END;
      
      BEGIN
        INSERT INTO HRF_FOOD_INTERFACE
        SELECT DISTINCT HDV.DEVICE_ID
             , PD.PERSON_ID
             , SSV.CHECK_FLAG
             , TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS') AS CHECK_DATE_TIME
             , TO_DATE(SH.A_DATE, 'YYYY-MM-DD') AS CHECK_DATE
             , TO_CHAR(TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS'), 'HH24:MI') AS CHECK_TIME
             , 'I' AS CREATED_FLAG
             , NULL AS CARD_NUM
             , 'P' AS CARD_TYPE
             , PD.SOB_ID
             , PD.ORG_ID
             , V_SYSDATE AS CREATION_DATE
             , P_USER_ID
             , V_SYSDATE AS LAST_UPDATE_DATE
             , P_USER_ID
          FROM HRD_SECOM_HISTORY SH 
            , HRM_DEVICE_V HDV
            , HRM_SECOM_STATUS_V SSV
            , HRM_PERSON_DISPATCH PD
         WHERE SH.MASTER_A                = HDV.SECOM_DEVICE_CODE
           AND SH.SOB_ID                  = HDV.SOB_ID
           AND SH.ORG_ID                  = HDV.ORG_ID
           AND SH.STATE                   = SSV.SECOM_STATUS
           AND SH.SOB_ID                  = SSV.SOB_ID
           AND SH.ORG_ID                  = SSV.ORG_ID
           AND SH.JUMIN_NUM               = REPLACE(PD.REPRE_NUM, '-', '')    
           AND SH.SOB_ID                  = PD.SOB_ID
           AND SH.ORG_ID                  = PD.ORG_ID                      
           AND PD.WORK_CORP_ID                 = W_CORP_ID
           AND PD.SOB_ID                  = W_SOB_ID
           AND PD.ORG_ID                  = W_ORG_ID
           AND PD.ORI_JOIN_DATE           <= TO_DATE(SH.A_DATE, 'YYYY-MM-DD')
           AND (PD.RETIRE_DATE IS NULL OR PD.RETIRE_DATE >= TO_DATE(SH.A_DATE, 'YYYY-MM-DD'))
           AND HDV.MODULE_TYPE            = 'FOOD'
           AND SUBSTR(SH.ATIME, 1, 8)     BETWEEN TO_CHAR(W_START_DATE, 'YYYYMMDD') AND TO_CHAR(W_END_DATE, 'YYYYMMDD')
        ORDER BY TO_DATE(SH.ATIME, 'YYYY-MM-DD HH24:MI:SS')   
        ;
      EXCEPTION WHEN OTHERS THEN
        V_ERROR_COUNT := V_ERROR_COUNT + 1;
        DBMS_OUTPUT.PUT_LINE('3.3 Food Insert Error : ' || SQLERRM);
      END;*/
      COMMIT;
    END IF;
    
    IF V_ERROR_COUNT > 0 THEN      
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10113', '&&ERROR_COUNT:=' || TO_CHAR(V_ERROR_COUNT, 'FM999,999,999'));
    ELSE
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
    END IF;      
  EXCEPTION 
    WHEN ERRNUMS.Insert_Error THEN
      RAISE_APPLICATION_ERROR(-20001, O_MESSAGE);
    WHEN ERRNUMS.Update_Error THEN
      RAISE_APPLICATION_ERROR(-20001, O_MESSAGE);
    WHEN ERRNUMS.Delete_Error THEN
      RAISE_APPLICATION_ERROR(-20001, O_MESSAGE);
  END SET_INTERFACE;

-- 임시 세콤 자료 조회.
  PROCEDURE TEMP_SECOM_HISTORY_SELECT
            ( P_CURSOR2                           OUT TYPES.TCURSOR2
            , W_SOB_ID                            IN HRD_SECOM_HISTORY.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_SECOM_HISTORY.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT  ATIME
            , ID_SEQ 
            , EQCODE_A 
            , MASTER_A 
            , LOCAL_A 
            , POINT_A 
            , LOOP_A 
            , EQNAME 
            , STATE 
            , PARAM_A 
            , USER_A 
            , CONTENT_A 
            , ACK 
            , ACKUSER 
            , ACKCONTENT 
            , ACKTIME 
            , TRANSFER 
            , MODE_A 
        FROM HRD_SECOM_HISTORY SH
       WHERE SH.SOB_ID            = W_SOB_ID
         AND SH.ORG_ID            = W_ORG_ID
         AND ROWNUM <= 1
      ;
  END TEMP_SECOM_HISTORY_SELECT;
  
-- 세콤 자료 INSERT. 
  PROCEDURE SECOM_HISTORY_INSERT
            ( P_ATIME           IN HRD_SECOM_HISTORY.ATIME%TYPE
            , P_ID_SEQ          IN HRD_SECOM_HISTORY.ID_SEQ%TYPE
            , P_EQCODE_A        IN HRD_SECOM_HISTORY.EQCODE_A%TYPE
            , P_MASTER_A        IN HRD_SECOM_HISTORY.MASTER_A%TYPE
            , P_LOCAL_A         IN HRD_SECOM_HISTORY.LOCAL_A%TYPE
            , P_POINT_A         IN HRD_SECOM_HISTORY.POINT_A%TYPE
            , P_LOOP_A          IN HRD_SECOM_HISTORY.LOOP_A%TYPE
            , P_EQNAME          IN HRD_SECOM_HISTORY.EQNAME%TYPE
            , P_STATE           IN HRD_SECOM_HISTORY.STATE%TYPE
            , P_PARAM_A         IN HRD_SECOM_HISTORY.PARAM_A%TYPE
            , P_USER_A          IN HRD_SECOM_HISTORY.USER_A%TYPE
            , P_CONTENT_A       IN HRD_SECOM_HISTORY.CONTENT_A%TYPE
            , P_ACK             IN HRD_SECOM_HISTORY.ACK%TYPE
            , P_ACKUSER         IN HRD_SECOM_HISTORY.ACKUSER%TYPE
            , P_ACKCONTENT      IN HRD_SECOM_HISTORY.ACKCONTENT%TYPE
            , P_ACKTIME         IN HRD_SECOM_HISTORY.ACKTIME%TYPE
            , P_TRANSFER        IN HRD_SECOM_HISTORY.TRANSFER%TYPE
            , P_MODE_A          IN HRD_SECOM_HISTORY.MODE_A%TYPE
            , P_SOB_ID          IN HRD_SECOM_HISTORY.SOB_ID%TYPE
            , P_ORG_ID          IN HRD_SECOM_HISTORY.ORG_ID%TYPE
            , P_CREATION_DATE   IN HRD_SECOM_HISTORY.CREATION_DATE%TYPE
            , P_USER_ID         IN HRD_SECOM_HISTORY.CREATED_BY%TYPE 
            )
  AS
  BEGIN
    INSERT INTO HRD_SECOM_HISTORY
    ( ATIME
    , ID_SEQ 
    , EQCODE_A 
    , MASTER_A 
    , LOCAL_A 
    , POINT_A 
    , LOOP_A 
    , EQNAME 
    , STATE 
    , PARAM_A 
    , USER_A 
    , CONTENT_A 
    , ACK 
    , ACKUSER 
    , ACKCONTENT 
    , ACKTIME 
    , TRANSFER 
    , MODE_A 
    , SOB_ID
    , ORG_ID
    , CREATION_DATE 
    , CREATED_BY )
    VALUES
    ( P_ATIME
    , P_ID_SEQ
    , P_EQCODE_A
    , P_MASTER_A
    , P_LOCAL_A
    , P_POINT_A
    , P_LOOP_A
    , P_EQNAME
    , P_STATE
    , P_PARAM_A
    , P_USER_A
    , NVL(P_CONTENT_A, '-')
    , P_ACK
    , P_ACKUSER
    , P_ACKCONTENT
    , P_ACKTIME
    , P_TRANSFER
    , P_MODE_A
    , P_SOB_ID
    , P_ORG_ID
    , P_CREATION_DATE
    , P_USER_ID );    
    COMMIT;
    
  END SECOM_HISTORY_INSERT;

-- 기존 자료수 체크.
  PROCEDURE SECOM_HISTORY_DELETE
            ( W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN HRD_SECOM_HISTORY.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_SECOM_HISTORY.ORG_ID%TYPE
            )
  AS
  BEGIN
    -- 기존 자료 삭제.
    BEGIN
      DELETE HRD_SECOM_HISTORY SH
      WHERE SUBSTR(SH.ATIME, 1, 8) BETWEEN TO_CHAR(W_START_DATE, 'YYYYMMDD') AND TO_CHAR(W_END_DATE, 'YYYYMMDD')
        AND SH.SOB_ID             = W_SOB_ID
        AND SH.ORG_ID             = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE ERRNUMS.Update_Error;
    END;
    COMMIT;
  EXCEPTION 
    WHEN ERRNUMS.Delete_Error THEN
      RAISE_APPLICATION_ERROR(-20001, SQLERRM);
  END SECOM_HISTORY_DELETE;
    
END HRD_SECOM_HISTORY_G;
/
