CREATE OR REPLACE PACKAGE HRD_MAIL_SEND
AS
-- 메일 작성.
  PROCEDURE MAKE_MAIL
            ( P_GUBUN             IN VARCHAR2     -- A : 승인 요청, B : 1차 승인 완료.
            , P_SOURCE_TYPE       IN VARCHAR2     -- WORK : 출퇴근 등록, DUTY : 고정근태, OT : 연장근무, HOLY : 대체근무.
            , P_CORP_ID           IN NUMBER
            , P_REQ_PERSON_ID     IN NUMBER       -- 요청자.
            , P_WORK_DATE         IN DATE         -- 근무일자.
            , P_REQ_DATE          IN DATE         -- 요청일자.
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

-- 메일 발송.
  FUNCTION SEND_MAIL
            ( P_MAIL_FR           IN VARCHAR2
            , P_MAIL_TO           IN VARCHAR2
            , P_SUBJECT           IN VARCHAR2
            , P_CONTENT           IN VARCHAR2
            ) RETURN BOOLEAN;
            
END HRD_MAIL_SEND;
/
CREATE OR REPLACE PACKAGE BODY HRD_MAIL_SEND
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_MAIL_SEND
/* Description  : 근태 메일발송 관리 패키지
/*
/* Reference by : 임직원 정보 관리
/* Program History : 
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
  PROCEDURE MAKE_MAIL
            ( P_GUBUN             IN VARCHAR2     -- A : 승인 요청, B : 1차 승인 완료.
            , P_SOURCE_TYPE       IN VARCHAR2     -- WORK : 출퇴근 등록, DUTY : 고정근태, OT : 연장근무, HOLY : 대체근무.
            , P_CORP_ID           IN NUMBER
            , P_REQ_PERSON_ID     IN NUMBER       -- 요청자.
            , P_WORK_DATE         IN DATE         -- 근무일자.
            , P_REQ_DATE          IN DATE         -- 요청일자.
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
    V_REQ_PERSON_NAME             VARCHAR2(100);
    V_MAIL_FR                     VARCHAR2(200);    

    V_SUBJECT                     VARCHAR2(300);   -- 제목.
    V_CONTENT                     VARCHAR2(3000);  -- 이메일 내용.
    
    V_TEXT1                       VARCHAR2(300);   -- 상태.
    V_PROGRAM_NAME                VARCHAR2(100);   -- 승인 프로그램.    
  BEGIN
-- 요청자 정보.  
    BEGIN
      SELECT PM.DISPLAY_NAME, PM.EMAIL
        INTO V_REQ_PERSON_NAME, V_MAIL_FR
        FROM HRM_PERSON_MASTER PM
      WHERE PM.PERSON_ID          = P_REQ_PERSON_ID
      ;      
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10028', NULL) || '(' || P_REQ_PERSON_ID || ')');
    END;
-----------------------------------------------------------------------------------------------------------------------
---- 이메일 발송 프로그램 / 이메일 발송 상태 ----    
    IF P_SOURCE_TYPE = 'WORK' THEN
    -- 출퇴근.
      IF P_GUBUN = 'A' THEN
      -- 현업 승인 요청.
        V_SUBJECT := '출퇴근 등록 승인 요청';
        V_TEXT1 := V_SUBJECT || '이 접수 되었습니다';
        V_PROGRAM_NAME := '출퇴근 등록 승인';
      ELSIF P_GUBUN = 'A_OK' THEN
      -- 현업 승인.
        V_SUBJECT := '출퇴근 등록 승인 완료';
        V_TEXT1 := '출퇴근 등록 승인이 완료 되었습니다';
        V_PROGRAM_NAME := '출퇴근 등록 승인';
      ELSIF P_GUBUN = 'B_CANCEL' THEN
      -- 현업 승인 취소.
        V_SUBJECT := '출퇴근 등록 승인 취소';
        V_TEXT1 := '출퇴근 등록 승인이 취소 되었습니다';
        V_PROGRAM_NAME := '출퇴근 등록 승인';
      ELSIF P_GUBUN = 'RETURN' THEN
      -- 출퇴근 수정 반려.
        V_SUBJECT := '출퇴근 등록 반려 완료';
        V_TEXT1 := '출퇴근 수정 등록 사항이 반려 되었습니다';
        V_PROGRAM_NAME := '출퇴근 등록 승인';
      END IF;            
    ELSIF P_SOURCE_TYPE = 'DUTY' THEN
    -- 고정근태.
      IF P_GUBUN = 'A' THEN
      -- 현업 승인 요청.
        V_SUBJECT := '고정근태(휴가) 승인 요청';
        V_TEXT1 := V_SUBJECT || '이 접수 되었습니다';
        V_PROGRAM_NAME := '고정근태 승인';
      ELSIF P_GUBUN = 'A_OK' THEN
      -- 현업 승인.
        V_SUBJECT := '고정근태(휴가) 승인 완료';
        V_TEXT1 := '고정근태(휴가) 승인이 완료 되었습니다';
        V_PROGRAM_NAME := '고정근태 승인';
      ELSIF P_GUBUN = 'B_CANCEL' THEN
      -- 현업 승인 취소.
        V_SUBJECT := '고정근태(휴가) 승인 취소';
        V_TEXT1 := '고정근태(휴가) 승인이 취소 되었습니다';
        V_PROGRAM_NAME := '고정근태 승인';
      ELSIF P_GUBUN = 'RETURN' THEN
      -- 근태계 반려 처리.
        V_SUBJECT := '고정근태(휴가) 반려 완료';
        V_TEXT1 := '고정근태(휴가) 신청 사항이 반려 되었습니다';
        V_PROGRAM_NAME := '고정근태 승인';
      END IF;      
    ELSIF P_SOURCE_TYPE = 'OT' THEN
    -- 연장근무.
      IF P_GUBUN = 'A' THEN
      -- 현업 승인 요청.
        V_SUBJECT := '연장근무 승인 요청';
        V_TEXT1 := V_SUBJECT || '이 접수 되었습니다';
        V_PROGRAM_NAME := '연장근무 승인';
      ELSIF P_GUBUN = 'A_OK' THEN
      -- 현업 승인.
        V_SUBJECT := '연장근무 승인 완료';
        V_TEXT1 :='연장근무 승인이 완료 되었습니다';
        V_PROGRAM_NAME := '연장근무 승인';
      ELSIF P_GUBUN = 'B_CANCEL' THEN
      -- 현업 승인 취소.
        V_SUBJECT := '연장근무 승인 취소';
        V_TEXT1 := '연장근무 승인이 취소 되었습니다';
        V_PROGRAM_NAME := '연장근무 승인';
      ELSIF P_GUBUN = 'RETURN' THEN
      -- 출퇴근 수정 반려.
        V_SUBJECT := '연장근무 반려 완료';
        V_TEXT1 := '연장근무 등록 사항이 반려 되었습니다';
        V_PROGRAM_NAME := '연장근무 승인';
      END IF;
    ELSIF P_SOURCE_TYPE = 'HOLY' THEN
    -- 대체근무.
      IF P_GUBUN = 'A' THEN
      -- 현업 승인 요청.
        V_SUBJECT := '근무변경(대체근무) 승인 요청';
        V_TEXT1 := V_SUBJECT || '이 접수 되었습니다';
        V_PROGRAM_NAME := '근무변경 승인';
      ELSIF P_GUBUN = 'A_OK' THEN
      -- 현업 승인.
        V_SUBJECT := '근무변경(대체근무) 승인 완료';
        V_TEXT1 := '근무변경(대체근무) 승인이 완료 되었습니다';
        V_PROGRAM_NAME := '근무변경 승인';
      ELSIF P_GUBUN = 'B_CANCEL' THEN
      -- 현업 승인 취소.
        V_SUBJECT := '근무변경(대체근무) 승인 취소';
        V_TEXT1 := '근무변경(대체근무) 승인이 취소 되었습니다';
        V_PROGRAM_NAME := '근무변경 승인';
      ELSIF P_GUBUN = 'RETURN' THEN
      -- 대체근무 반려.
        V_SUBJECT := '근무변경 등록 반려 완료';
        V_TEXT1 := '근무변경 등록 사항이 반려 되었습니다';
        V_PROGRAM_NAME := '근무변경 승인';
      END IF;
    END IF;
    
    V_CONTENT := '<HTML><BODY><BR>' ||
               --  '<b>' ||
                 '<FONT color=BLACK size=2>안녕하세요.</font><br>'||
                 '<FONT color=BLACK size=2>' || V_REQ_PERSON_NAME || ' 님으로 부터 </font><br> ' ||
                 '<FONT color=BLACK size=2>' || V_TEXT1 || '</font><br><br>' ||
                 '<FONT color=BLACK size=2>[' || V_PROGRAM_NAME || '] 화면을 확인해 주시기 바랍니다</font><br><br>'||
                 '<FONT color=BLACK size=2>좋은 하루 되십시요.</font><br>'||
                 '<FONT color=BLACK size=2>감사합니다.</font><br><br>'||                                                  
/*                 '<TABLE class=text cellSpacing=1 cellPadding=1 bgColor=#0099ff border=0 >'||
                 '<TR bgColor=#eef0ff>'||chr(10)||
                 '<TD height=20 width = 100 align = middle><FONT color=BLUE size=2>STATUS</FONT></TD>'||chr(10)||
                 '<TD height=20 width = 300><FONT color=BLACK size=2>'||C_REQUEST_STATUS ||'</FONT></TD>'||chr(10)||
                 '<TR bgColor=#eef0ff>'||chr(10)||
                 '<TD height=20 width = 100 align = middle><FONT color=BLUE size=2>계약번호</FONT></TD>'||chr(10)||
                 '<TD height=20 width = 300><FONT color=BLACK size=2>'||C_CONTRACT_NUMBER||'</FONT></TD>'||chr(10)||
                 '<TR bgColor=#eef0ff>'||chr(10)||
                 '<TD height=20 width = 100 align = middle><FONT color=BLUE size=2>거래처명</FONT></TD>'||chr(10)||
                 '<TD height=20 width = 300><FONT color=BLACK size=2>'||C_CUST_NAME||'</FONT></TD>'||chr(10)||
                 '<TR bgColor=#eef0ff>'||chr(10)||
                 '<TD height=20 width = 100 align = middle><FONT color=BLUE size=2>프로젝트명</FONT></TD>'||chr(10)||
                 '<TD height=20 width = 300><FONT color=BLACK size=2>'||C_PROJECT_NAME||'</FONT></TD>'||chr(10)||
                 '<TR bgColor=#eef0ff>'||chr(10)||
                 '<TD height=20 width = 100 align = middle><FONT color=BLUE size=2>실수요자</FONT></TD>'||chr(10)||
                 '<TD height=20 width = 300><FONT color=BLACK size=2>'||C_REAL_USER ||'</FONT></TD>'||chr(10)||                         
                 '<TR bgColor=#eef0ff>'||chr(10)||
                 '<TD height=20 width = 100 align = middle><FONT color=BLUE size=2>승인요구일</FONT></TD>'||chr(10)||
                 '<TD height=20 width = 300><FONT color=BLACK size=2>'||C_DEAD_LINE||'</FONT></TD>'||chr(10)||
--                         '<TD height=20 width = 300><FONT color=BLACK size=2>'||TO_DATE(C_DEAD_LINE,'YYYY-MM-DD')||'</FONT></TD>'||chr(10)||
                 '<TR bgColor=#eef0ff>'||chr(10)||
                 '<TD height=20 width = 100 align = middle><FONT color=BLUE size=2>영업담당</FONT></TD>'||chr(10)||
                 '<TD height=20 width = 300><FONT color=BLACK size=2>'||C_SALES_PERSON ||'</FONT></TD>'||chr(10)||
                 '</td>' ||
                 '</tr>' ||
                 '</table>'||*/
/*                 '<FONT color=BLUE size=2>' || '<a href=''http://lgisdev02.lgis.com:8007/dev60cgi/f60cgi''>' ||'ERP SYSTEM 바로가기(CLICK)'||'</a>'||*/
                 '<br><br><br>'||
                 '<FONT color=BLACK size=2>문의사항은 인사 담당자에게 문의하시기 바랍니다.</font><br>'||
--                 '<FONT color=BLUE size=2>업무 담당자 : 금속 사업부 영업팀 ' || v_send_user_name || '</font><br>'||                         
                 '</pre></b>'||
                 '</html></body>'
                 ;
-----------------------------------------------------------------------------------------------------------------------
---- 이메일 수신자 조회 및 이메일 발송.
    IF P_SOURCE_TYPE = 'WORK' THEN    
    -- 출퇴근.
     /* raise_application_error(-20001, P_SOURCE_TYPE || '/' || p_gubun);*/
------>>
      IF P_GUBUN = 'A' THEN
      -- 승인처리.
        FOR R1 IN ( SELECT DM.MANAGER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID1) AS MANAGER1_EMAIL
                         , DM.MANAGER_ID2 
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID2) AS MANAGER2_EMAIL
                         , DM.APPROVER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID1) AS APPROVER1_EMAIL
                         , DM.APPROVER_ID2
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID2) AS APPROVER2_EMAIL
                      FROM HRD_DUTY_MANAGER DM
                    WHERE DM.CORP_ID         = P_CORP_ID
                      AND DM.SOB_ID          = P_SOB_ID
                      AND DM.ORG_ID          = P_ORG_ID
                      AND DM.USABLE          = 'Y'
                      AND DM.START_DATE      <= P_WORK_DATE
                      AND (DM.END_DATE IS NULL OR DM.END_DATE >= P_WORK_DATE)
                      AND DM.DUTY_CONTROL_ID IN 
                          ( SELECT DISTINCT PM.FLOOR_ID
                              FROM HRD_DAY_INTERFACE DI
                                , HRM_PERSON_MASTER PM
                            WHERE DI.PERSON_ID          = PM.PERSON_ID
                              AND PM.WORK_CORP_ID       = P_CORP_ID
                              AND DI.SOB_ID             = P_SOB_ID
                              AND DI.ORG_ID             = P_ORG_ID
                              AND DI.APPROVE_STATUS     = 'A'
                              AND DI.EMAIL_STATUS       = 'AR'
                              AND EXISTS (SELECT 'X'
                                            FROM HRD_DUTY_MANAGER DM
                                            WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                                             AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                                             AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                             AND P_REQ_PERSON_ID                  IN(DM.MANAGER_ID1, DM.MANAGER_ID2)
                                             AND DM.USABLE                        = 'Y'
                                             AND DM.START_DATE                    <= P_WORK_DATE
                                             AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                                             AND DM.SOB_ID                        = PM.SOB_ID
                                             AND DM.ORG_ID                        = PM.ORG_ID
                                         )
                          )
                  )
        LOOP      
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID1 AND R1.MANAGER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;          
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID2 AND R1.MANAGER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID1 AND R1.APPROVER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID2 AND R1.APPROVER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
        END LOOP R1;
        
        -- 메일 상태 변경.
        BEGIN
          UPDATE HRD_DAY_INTERFACE DI
            SET DI.EMAIL_STATUS   = 'AS'
          WHERE DI.CORP_ID        = P_CORP_ID
            AND DI.SOB_ID         = P_SOB_ID
            AND DI.ORG_ID         = P_ORG_ID
            AND DI.APPROVE_STATUS     = 'A'
            AND DI.EMAIL_STATUS       = 'AR'
            AND EXISTS 
                ( SELECT 'X'
                    FROM HRM_PERSON_MASTER PM
                  WHERE PM.PERSON_ID        = DI.PERSON_ID
                    AND EXISTS
                        ( SELECT 'X'
                            FROM HRD_DUTY_MANAGER DM
                          WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                           AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                           AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                           AND P_REQ_PERSON_ID                  IN(DM.MANAGER_ID1, DM.MANAGER_ID2)
                           AND DM.USABLE                        = 'Y'
                           AND DM.START_DATE                    <= P_WORK_DATE
                           AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                           AND DM.SOB_ID                        = PM.SOB_ID
                           AND DM.ORG_ID                        = PM.ORG_ID
                        )
                )
          ;
          COMMIT;
        EXCEPTION WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Mail Status Change Error : ' || SQLERRM);
        END;
------>>
      ELSIF P_GUBUN = 'A_OK' THEN
      -- 승인처리.
        FOR R1 IN ( SELECT DM.MANAGER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID1) AS MANAGER1_EMAIL
                         , DM.MANAGER_ID2 
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID2) AS MANAGER2_EMAIL
                         , DM.APPROVER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID1) AS APPROVER1_EMAIL
                         , DM.APPROVER_ID2
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID2) AS APPROVER2_EMAIL
                      FROM HRD_DUTY_MANAGER DM
                    WHERE DM.CORP_ID         = P_CORP_ID
                      AND DM.SOB_ID          = P_SOB_ID
                      AND DM.ORG_ID          = P_ORG_ID
                      AND DM.USABLE          = 'Y'
                      AND DM.START_DATE      <= P_WORK_DATE
                      AND (DM.END_DATE IS NULL OR DM.END_DATE >= P_WORK_DATE)
                      AND DM.DUTY_CONTROL_ID IN 
                          ( SELECT DISTINCT PM.FLOOR_ID
                              FROM HRD_DAY_INTERFACE DI
                                , HRM_PERSON_MASTER PM
                            WHERE DI.PERSON_ID          = PM.PERSON_ID
                              AND PM.WORK_CORP_ID       = P_CORP_ID
                              AND DI.SOB_ID             = P_SOB_ID
                              AND DI.ORG_ID             = P_ORG_ID
                              AND DI.APPROVE_STATUS     = 'B'
                              AND DI.EMAIL_STATUS       = 'AR'
                              AND EXISTS (SELECT 'X'
                                            FROM HRD_DUTY_MANAGER DM
                                            WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                                             AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                                             AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                             AND P_REQ_PERSON_ID                  IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                                             AND DM.USABLE                        = 'Y'
                                             AND DM.START_DATE                    <= P_WORK_DATE
                                             AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                                             AND DM.SOB_ID                        = PM.SOB_ID
                                             AND DM.ORG_ID                        = PM.ORG_ID
                                         )
                          )
                  )
        LOOP
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID1 AND R1.MANAGER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;          
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID2 AND R1.MANAGER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID1 AND R1.APPROVER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID2 AND R1.APPROVER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
        END LOOP R1;
        
        -- 메일 상태 변경.
        BEGIN
          UPDATE HRD_DAY_INTERFACE DI
            SET DI.EMAIL_STATUS   = 'AS'
          WHERE DI.CORP_ID        = P_CORP_ID
            AND DI.SOB_ID         = P_SOB_ID
            AND DI.ORG_ID         = P_ORG_ID
            AND DI.APPROVE_STATUS     = 'B'
            AND DI.EMAIL_STATUS       = 'AR'
            AND EXISTS 
                ( SELECT 'X'
                    FROM HRM_PERSON_MASTER PM
                  WHERE PM.PERSON_ID        = DI.PERSON_ID
                    AND EXISTS
                        ( SELECT 'X'
                            FROM HRD_DUTY_MANAGER DM
                          WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                           AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                           AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                           AND P_REQ_PERSON_ID                  IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                           AND DM.USABLE                        = 'Y'
                           AND DM.START_DATE                    <= P_WORK_DATE
                           AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                           AND DM.SOB_ID                        = PM.SOB_ID
                           AND DM.ORG_ID                        = PM.ORG_ID
                        )
                )
          ;
          COMMIT;
        EXCEPTION WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Mail Status Change Error : ' || SQLERRM);
        END;
------>> 
      ELSIF P_GUBUN = 'B_CANCEL' THEN
      -- 승인취소.
        /*raise_application_error(-20001, P_SOURCE_TYPE || '/' || p_gubun);*/
        FOR R1 IN ( SELECT DM.MANAGER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID1) AS MANAGER1_EMAIL
                         , DM.MANAGER_ID2 
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID2) AS MANAGER2_EMAIL
                         , DM.APPROVER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID1) AS APPROVER1_EMAIL
                         , DM.APPROVER_ID2
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID2) AS APPROVER2_EMAIL
                      FROM HRD_DUTY_MANAGER DM
                    WHERE DM.CORP_ID         = P_CORP_ID
                      AND DM.SOB_ID          = P_SOB_ID
                      AND DM.ORG_ID          = P_ORG_ID
                      AND DM.USABLE          = 'Y'
                      AND DM.START_DATE      <= P_WORK_DATE
                      AND (DM.END_DATE IS NULL OR DM.END_DATE >= P_WORK_DATE)
                      AND DM.DUTY_CONTROL_ID IN 
                          ( SELECT DISTINCT PM.FLOOR_ID
                              FROM HRD_DAY_INTERFACE DI
                                , HRM_PERSON_MASTER PM
                            WHERE DI.PERSON_ID          = PM.PERSON_ID
                              AND PM.WORK_CORP_ID       = P_CORP_ID
                              AND DI.SOB_ID             = P_SOB_ID
                              AND DI.ORG_ID             = P_ORG_ID
                              AND DI.APPROVE_STATUS     = 'A'
                              AND DI.EMAIL_STATUS       = 'BR'
                              AND EXISTS (SELECT 'X'
                                            FROM HRD_DUTY_MANAGER DM
                                            WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                                             AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                                             AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                             AND P_REQ_PERSON_ID                  IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                                             AND DM.USABLE                        = 'Y'
                                             AND DM.START_DATE                    <= P_WORK_DATE
                                             AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                                             AND DM.SOB_ID                        = PM.SOB_ID
                                             AND DM.ORG_ID                        = PM.ORG_ID
                                         )
                          )
                  )
        LOOP
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID1 AND R1.MANAGER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;          
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID2 AND R1.MANAGER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID1 AND R1.APPROVER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID2 AND R1.APPROVER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
        END LOOP R1;
        -- 메일 상태 변경.
        BEGIN
          UPDATE HRD_DAY_INTERFACE DI
            SET DI.EMAIL_STATUS   = 'BS'
          WHERE DI.CORP_ID        = P_CORP_ID
            AND DI.SOB_ID         = P_SOB_ID
            AND DI.ORG_ID         = P_ORG_ID
            AND DI.APPROVE_STATUS     = 'A'
            AND DI.EMAIL_STATUS       = 'BR'
            AND EXISTS 
                ( SELECT 'X'
                    FROM HRM_PERSON_MASTER PM
                  WHERE PM.PERSON_ID        = DI.PERSON_ID
                    AND EXISTS
                        ( SELECT 'X'
                            FROM HRD_DUTY_MANAGER DM
                          WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                           AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                           AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                           AND P_REQ_PERSON_ID                  IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                           AND DM.USABLE                        = 'Y'
                           AND DM.START_DATE                    <= P_WORK_DATE
                           AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                           AND DM.SOB_ID                        = PM.SOB_ID
                           AND DM.ORG_ID                        = PM.ORG_ID
                        )
                )
          ;
          COMMIT;
        EXCEPTION WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Mail Status Change Error : ' || SQLERRM);
        END;
------>> 
      ELSIF P_GUBUN = 'RETURN' THEN
      -- 반려처리.
        /*raise_application_error(-20001, P_SOURCE_TYPE || '/' || p_gubun);*/
        FOR R1 IN ( SELECT DM.MANAGER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID1) AS MANAGER1_EMAIL
                         , DM.MANAGER_ID2 
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID2) AS MANAGER2_EMAIL
                         , DM.APPROVER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID1) AS APPROVER1_EMAIL
                         , DM.APPROVER_ID2
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID2) AS APPROVER2_EMAIL
                      FROM HRD_DUTY_MANAGER DM
                    WHERE DM.CORP_ID         = P_CORP_ID
                      AND DM.SOB_ID          = P_SOB_ID
                      AND DM.ORG_ID          = P_ORG_ID
                      AND DM.USABLE          = 'Y'
                      AND DM.START_DATE      <= P_WORK_DATE
                      AND (DM.END_DATE IS NULL OR DM.END_DATE >= P_WORK_DATE)
                      AND DM.DUTY_CONTROL_ID IN 
                          ( SELECT DISTINCT PM.FLOOR_ID
                              FROM HRD_DAY_INTERFACE DI
                                , HRM_PERSON_MASTER PM
                            WHERE DI.PERSON_ID          = PM.PERSON_ID
                              AND PM.WORK_CORP_ID       = P_CORP_ID
                              AND DI.SOB_ID             = P_SOB_ID
                              AND DI.ORG_ID             = P_ORG_ID
                              AND DI.APPROVE_STATUS     = 'R'
                              AND DI.EMAIL_STATUS       = 'RR'
                              AND EXISTS (SELECT 'X'
                                            FROM HRD_DUTY_MANAGER DM
                                            WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                                             AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                                             AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                             AND P_REQ_PERSON_ID                  IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                                             AND DM.USABLE                        = 'Y'
                                             AND DM.START_DATE                    <= P_WORK_DATE
                                             AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                                             AND DM.SOB_ID                        = PM.SOB_ID
                                             AND DM.ORG_ID                        = PM.ORG_ID
                                         )
                          )
                  )
        LOOP
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID1 AND R1.MANAGER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;          
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID2 AND R1.MANAGER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID1 AND R1.APPROVER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID2 AND R1.APPROVER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
        END LOOP R1;
        -- 메일 상태 변경.
        BEGIN
          UPDATE HRD_DAY_INTERFACE DI
            SET DI.EMAIL_STATUS   = 'RS'
          WHERE DI.CORP_ID        = P_CORP_ID
            AND DI.SOB_ID         = P_SOB_ID
            AND DI.ORG_ID         = P_ORG_ID
            AND DI.APPROVE_STATUS     IN('R')
            AND DI.EMAIL_STATUS       = 'RR'
            AND EXISTS 
                ( SELECT 'X'
                    FROM HRM_PERSON_MASTER PM
                  WHERE PM.PERSON_ID        = DI.PERSON_ID
                    AND EXISTS
                        ( SELECT 'X'
                            FROM HRD_DUTY_MANAGER DM
                          WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                           AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                           AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                           AND P_REQ_PERSON_ID                  IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                           AND DM.USABLE                        = 'Y'
                           AND DM.START_DATE                    <= P_WORK_DATE
                           AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                           AND DM.SOB_ID                        = PM.SOB_ID
                           AND DM.ORG_ID                        = PM.ORG_ID
                        )
                )
          ;
          COMMIT;
        EXCEPTION WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Mail Status Change Error : ' || SQLERRM);
        END;
      END IF;
---------------------------------------------------------------------------------------------------
    ELSIF P_SOURCE_TYPE = 'DUTY' THEN
    -- 고정근태.
------>> 
      IF P_GUBUN = 'A' THEN
      -- 승인처리.
        FOR R1 IN ( SELECT DM.MANAGER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID1) AS MANAGER1_EMAIL
                         , DM.MANAGER_ID2 
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID2) AS MANAGER2_EMAIL
                         , DM.APPROVER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID1) AS APPROVER1_EMAIL
                         , DM.APPROVER_ID2
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID2) AS APPROVER2_EMAIL
                      FROM HRD_DUTY_MANAGER DM
                    WHERE DM.CORP_ID         = P_CORP_ID
                      AND DM.SOB_ID          = P_SOB_ID
                      AND DM.ORG_ID          = P_ORG_ID
                      AND DM.USABLE          = 'Y'
                      AND DM.START_DATE      <= P_WORK_DATE
                      AND (DM.END_DATE IS NULL OR DM.END_DATE >= P_WORK_DATE)
                      AND DM.DUTY_CONTROL_ID IN 
                          ( SELECT DISTINCT PM.FLOOR_ID
                              FROM HRD_DUTY_PERIOD DP
                                , HRM_PERSON_MASTER PM
                            WHERE DP.PERSON_ID          = PM.PERSON_ID
                              AND PM.WORK_CORP_ID       = P_CORP_ID
                              AND DP.SOB_ID             = P_SOB_ID
                              AND DP.ORG_ID             = P_ORG_ID
                              AND DP.APPROVE_STATUS     = 'A'
                              AND DP.EMAIL_STATUS       = 'AR'
                              AND EXISTS (SELECT 'X'
                                            FROM HRD_DUTY_MANAGER DM
                                            WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                                             AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                                             AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                             AND P_REQ_PERSON_ID                  IN(DM.MANAGER_ID1, DM.MANAGER_ID2)
                                             AND DM.USABLE                        = 'Y'
                                             AND DM.START_DATE                    <= P_WORK_DATE
                                             AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                                             AND DM.SOB_ID                        = PM.SOB_ID
                                             AND DM.ORG_ID                        = PM.ORG_ID
                                         )
                          )
                  )
        LOOP
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID1 AND R1.MANAGER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;          
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID2 AND R1.MANAGER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID1 AND R1.APPROVER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID2 AND R1.APPROVER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
        END LOOP R1;
        
        -- 메일 상태 변경.
        BEGIN
          UPDATE HRD_DUTY_PERIOD DP
            SET DP.EMAIL_STATUS   = 'AS'
          WHERE DP.CORP_ID        = P_CORP_ID
            AND DP.SOB_ID         = P_SOB_ID
            AND DP.ORG_ID         = P_ORG_ID
            AND DP.APPROVE_STATUS     = 'A'
            AND DP.EMAIL_STATUS       = 'AR'
            AND EXISTS 
                ( SELECT 'X'
                    FROM HRM_PERSON_MASTER PM
                  WHERE PM.PERSON_ID        = DP.PERSON_ID
                    AND EXISTS
                        ( SELECT 'X'
                            FROM HRD_DUTY_MANAGER DM
                          WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                           AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                           AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                           AND P_REQ_PERSON_ID                  IN(DM.MANAGER_ID1, DM.MANAGER_ID2)
                           AND DM.USABLE                        = 'Y'
                           AND DM.START_DATE                    <= P_WORK_DATE
                           AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                           AND DM.SOB_ID                        = PM.SOB_ID
                           AND DM.ORG_ID                        = PM.ORG_ID
                        )
                )
          ;
          COMMIT;
        EXCEPTION WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Mail Status Change Error : ' || SQLERRM);
        END;
------>> 
      ELSIF P_GUBUN = 'A_OK' THEN
      -- 승인처리.
        FOR R1 IN ( SELECT DM.MANAGER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID1) AS MANAGER1_EMAIL
                         , DM.MANAGER_ID2 
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID2) AS MANAGER2_EMAIL
                         , DM.APPROVER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID1) AS APPROVER1_EMAIL
                         , DM.APPROVER_ID2
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID2) AS APPROVER2_EMAIL
                      FROM HRD_DUTY_MANAGER DM
                    WHERE DM.CORP_ID         = P_CORP_ID
                      AND DM.SOB_ID          = P_SOB_ID
                      AND DM.ORG_ID          = P_ORG_ID
                      AND DM.USABLE          = 'Y'
                      AND DM.START_DATE      <= P_WORK_DATE
                      AND (DM.END_DATE IS NULL OR DM.END_DATE >= P_WORK_DATE)
                      AND DM.DUTY_CONTROL_ID IN 
                          ( SELECT DISTINCT PM.FLOOR_ID
                              FROM HRD_DUTY_PERIOD DP
                                , HRM_PERSON_MASTER PM
                            WHERE DP.PERSON_ID          = PM.PERSON_ID
                              AND PM.WORK_CORP_ID       = P_CORP_ID
                              AND DP.SOB_ID             = P_SOB_ID
                              AND DP.ORG_ID             = P_ORG_ID
                              AND DP.APPROVE_STATUS     = 'B'
                              AND DP.EMAIL_STATUS       = 'AR'
                              AND EXISTS (SELECT 'X'
                                            FROM HRD_DUTY_MANAGER DM
                                            WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                                             AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                                             AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                             AND P_REQ_PERSON_ID                  IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                                             AND DM.USABLE                        = 'Y'
                                             AND DM.START_DATE                    <= P_WORK_DATE
                                             AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                                             AND DM.SOB_ID                        = PM.SOB_ID
                                             AND DM.ORG_ID                        = PM.ORG_ID
                                         )
                          )
                  )
        LOOP
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID1 AND R1.MANAGER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;          
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID2 AND R1.MANAGER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID1 AND R1.APPROVER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID2 AND R1.APPROVER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
        END LOOP R1;
        
        -- 메일 상태 변경.
        BEGIN
          UPDATE HRD_DUTY_PERIOD DP
            SET DP.EMAIL_STATUS   = 'AS'
          WHERE DP.CORP_ID        = P_CORP_ID
            AND DP.SOB_ID         = P_SOB_ID
            AND DP.ORG_ID         = P_ORG_ID
            AND DP.APPROVE_STATUS     = 'B'
            AND DP.EMAIL_STATUS       = 'AR'
            AND EXISTS 
                ( SELECT 'X'
                    FROM HRM_PERSON_MASTER PM
                  WHERE PM.PERSON_ID        = DP.PERSON_ID
                    AND EXISTS
                        ( SELECT 'X'
                            FROM HRD_DUTY_MANAGER DM
                          WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                           AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                           AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                           AND P_REQ_PERSON_ID                  IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                           AND DM.USABLE                        = 'Y'
                           AND DM.START_DATE                    <= P_WORK_DATE
                           AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                           AND DM.SOB_ID                        = PM.SOB_ID
                           AND DM.ORG_ID                        = PM.ORG_ID
                        )
                )
          ;
          COMMIT;
        EXCEPTION WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Mail Status Change Error : ' || SQLERRM);
        END;
------>> 
      ELSIF P_GUBUN = 'B_CANCEL' THEN
      -- 승인취소.
        FOR R1 IN ( SELECT DM.MANAGER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID1) AS MANAGER1_EMAIL
                         , DM.MANAGER_ID2 
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID2) AS MANAGER2_EMAIL
                         , DM.APPROVER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID1) AS APPROVER1_EMAIL
                         , DM.APPROVER_ID2
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID2) AS APPROVER2_EMAIL
                      FROM HRD_DUTY_MANAGER DM
                    WHERE DM.CORP_ID         = P_CORP_ID
                      AND DM.SOB_ID          = P_SOB_ID
                      AND DM.ORG_ID          = P_ORG_ID
                      AND DM.USABLE          = 'Y'
                      AND DM.START_DATE      <= P_WORK_DATE
                      AND (DM.END_DATE IS NULL OR DM.END_DATE >= P_WORK_DATE)
                      AND DM.DUTY_CONTROL_ID IN 
                          ( SELECT DISTINCT PM.FLOOR_ID
                              FROM HRD_DUTY_PERIOD DP
                                , HRM_PERSON_MASTER PM
                            WHERE DP.PERSON_ID          = PM.PERSON_ID
                              AND PM.WORK_CORP_ID       = P_CORP_ID
                              AND DP.SOB_ID             = P_SOB_ID
                              AND DP.ORG_ID             = P_ORG_ID
                              AND DP.APPROVE_STATUS     = 'A'
                              AND DP.EMAIL_STATUS       = 'BR'
                              AND EXISTS (SELECT 'X'
                                            FROM HRD_DUTY_MANAGER DM
                                            WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                                             AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                                             AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                             AND P_REQ_PERSON_ID                  IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                                             AND DM.USABLE                        = 'Y'
                                             AND DM.START_DATE                    <= P_WORK_DATE
                                             AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                                             AND DM.SOB_ID                        = PM.SOB_ID
                                             AND DM.ORG_ID                        = PM.ORG_ID
                                         )
                          )
                  )
        LOOP
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID1 AND R1.MANAGER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;          
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID2 AND R1.MANAGER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID1 AND R1.APPROVER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID2 AND R1.APPROVER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
        END LOOP R1;
        -- 메일 상태 변경.
        BEGIN
          UPDATE HRD_DUTY_PERIOD DP
            SET DP.EMAIL_STATUS   = 'BS'
          WHERE DP.CORP_ID        = P_CORP_ID
            AND DP.SOB_ID         = P_SOB_ID
            AND DP.ORG_ID         = P_ORG_ID
            AND DP.APPROVE_STATUS     = 'A'
            AND DP.EMAIL_STATUS       = 'BR'
            AND EXISTS 
                ( SELECT 'X'
                    FROM HRM_PERSON_MASTER PM
                  WHERE PM.PERSON_ID        = DP.PERSON_ID
                    AND EXISTS
                        ( SELECT 'X'
                            FROM HRD_DUTY_MANAGER DM
                          WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                           AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                           AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                           AND P_REQ_PERSON_ID                  IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                           AND DM.USABLE                        = 'Y'
                           AND DM.START_DATE                    <= P_WORK_DATE
                           AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                           AND DM.SOB_ID                        = PM.SOB_ID
                           AND DM.ORG_ID                        = PM.ORG_ID
                        )
                )
          ;
          COMMIT;
        EXCEPTION WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Mail Status Change Error : ' || SQLERRM);
        END;
------>> 
      ELSIF P_GUBUN = 'RETURN' THEN
      -- 반려처리.
        FOR R1 IN ( SELECT DM.MANAGER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID1) AS MANAGER1_EMAIL
                         , DM.MANAGER_ID2 
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID2) AS MANAGER2_EMAIL
                         , DM.APPROVER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID1) AS APPROVER1_EMAIL
                         , DM.APPROVER_ID2
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID2) AS APPROVER2_EMAIL
                      FROM HRD_DUTY_MANAGER DM
                    WHERE DM.CORP_ID         = P_CORP_ID
                      AND DM.SOB_ID          = P_SOB_ID
                      AND DM.ORG_ID          = P_ORG_ID
                      AND DM.USABLE          = 'Y'
                      AND DM.START_DATE      <= P_WORK_DATE
                      AND (DM.END_DATE IS NULL OR DM.END_DATE >= P_WORK_DATE)
                      AND DM.DUTY_CONTROL_ID IN 
                          ( SELECT DISTINCT PM.FLOOR_ID
                              FROM HRD_DUTY_PERIOD DP
                                , HRM_PERSON_MASTER PM
                            WHERE DP.PERSON_ID          = PM.PERSON_ID
                              AND PM.WORK_CORP_ID       = P_CORP_ID
                              AND DP.SOB_ID             = P_SOB_ID
                              AND DP.ORG_ID             = P_ORG_ID
                              AND DP.APPROVE_STATUS     IN('R')
                              AND DP.EMAIL_STATUS       = 'RR'
                              AND EXISTS (SELECT 'X'
                                            FROM HRD_DUTY_MANAGER DM
                                            WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                                             AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                                             AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                             AND P_REQ_PERSON_ID                  IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                                             AND DM.USABLE                        = 'Y'
                                             AND DM.START_DATE                    <= P_WORK_DATE
                                             AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                                             AND DM.SOB_ID                        = PM.SOB_ID
                                             AND DM.ORG_ID                        = PM.ORG_ID
                                         )
                          )
                  )
        LOOP
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID1 AND R1.MANAGER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;          
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID2 AND R1.MANAGER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID1 AND R1.APPROVER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID2 AND R1.APPROVER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
        END LOOP R1;
        
        -- 메일 상태 변경.
        BEGIN
          UPDATE HRD_DUTY_PERIOD DP
            SET DP.EMAIL_STATUS   = 'RS'
          WHERE DP.CORP_ID        = P_CORP_ID
            AND DP.SOB_ID         = P_SOB_ID
            AND DP.ORG_ID         = P_ORG_ID
            AND DP.APPROVE_STATUS     IN('R')
            AND DP.EMAIL_STATUS       = 'RR'
            AND EXISTS 
                ( SELECT 'X'
                    FROM HRM_PERSON_MASTER PM
                  WHERE PM.PERSON_ID        = DP.PERSON_ID
                    AND EXISTS
                        ( SELECT 'X'
                            FROM HRD_DUTY_MANAGER DM
                          WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                           AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                           AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                           AND P_REQ_PERSON_ID                  IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                           AND DM.USABLE                        = 'Y'
                           AND DM.START_DATE                    <= P_WORK_DATE
                           AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                           AND DM.SOB_ID                        = PM.SOB_ID
                           AND DM.ORG_ID                        = PM.ORG_ID
                        )
                )
          ;
          COMMIT;
        EXCEPTION WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Mail Status Change Error : ' || SQLERRM);
        END;
      END IF;
---------------------------------------------------------------------------------------------------      
    ELSIF P_SOURCE_TYPE = 'OT' THEN
    -- 연장근무.
------>> 
      IF P_GUBUN = 'A' THEN
      -- 승인처리.
        FOR R1 IN ( SELECT DM.MANAGER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID1) AS MANAGER1_EMAIL
                         , DM.MANAGER_ID2 
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID2) AS MANAGER2_EMAIL
                         , DM.APPROVER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID1) AS APPROVER1_EMAIL
                         , DM.APPROVER_ID2
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID2) AS APPROVER2_EMAIL
                      FROM HRD_DUTY_MANAGER DM
                    WHERE DM.CORP_ID         = P_CORP_ID
                      AND DM.SOB_ID          = P_SOB_ID
                      AND DM.ORG_ID          = P_ORG_ID
                      AND DM.USABLE          = 'Y'
                      AND DM.START_DATE      <= P_WORK_DATE
                      AND (DM.END_DATE IS NULL OR DM.END_DATE >= P_WORK_DATE)
                      AND EXISTS ( SELECT 'X'
                                     FROM HRD_OT_HEADER OH
                                   WHERE OH.DUTY_MANAGER_ID = DM.DUTY_MANAGER_ID
                                     AND OH.APPROVE_STATUS  = 'A'
                                     AND OH.EMAIL_STATUS    = 'AR'
                                     AND OH.REQ_PERSON_ID   = P_REQ_PERSON_ID
                                 )
                  )
        LOOP
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID1 AND R1.MANAGER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;          
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID2 AND R1.MANAGER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID1 AND R1.APPROVER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID2 AND R1.APPROVER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
        END LOOP R1;
        
        -- 메일 상태 변경.
        BEGIN
          UPDATE HRD_OT_HEADER OH
            SET OH.EMAIL_STATUS   = 'AS'
          WHERE OH.CORP_ID        = P_CORP_ID
            AND OH.SOB_ID         = P_SOB_ID
            AND OH.ORG_ID         = P_ORG_ID
            AND OH.APPROVE_STATUS = 'A'
            AND OH.EMAIL_STATUS   = 'AR'
            AND OH.REQ_PERSON_ID    = P_REQ_PERSON_ID
          ;
          COMMIT;
        EXCEPTION WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Mail Status Change Error : ' || SQLERRM);
        END;
------>> 
      ELSIF P_GUBUN = 'A_OK' THEN
      -- 승인처리.
        FOR R1 IN ( SELECT DM.DUTY_MANAGER_ID
                         , DM.MANAGER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID1) AS MANAGER1_EMAIL
                         , DM.MANAGER_ID2 
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID2) AS MANAGER2_EMAIL
                         , DM.APPROVER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID1) AS APPROVER1_EMAIL
                         , DM.APPROVER_ID2
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID2) AS APPROVER2_EMAIL
                      FROM HRD_DUTY_MANAGER DM
                    WHERE DM.CORP_ID         = P_CORP_ID
                      AND DM.SOB_ID          = P_SOB_ID
                      AND DM.ORG_ID          = P_ORG_ID
                      AND DM.USABLE          = 'Y'
                      AND DM.START_DATE      <= P_WORK_DATE
                      AND (DM.END_DATE IS NULL OR DM.END_DATE >= P_WORK_DATE)
                      AND EXISTS ( SELECT 'X'
                                     FROM HRD_OT_HEADER OH
                                       , HRD_DUTY_MANAGER HDM
                                   WHERE OH.DUTY_MANAGER_ID = HDM.DUTY_MANAGER_ID
                                     AND OH.DUTY_MANAGER_ID = DM.DUTY_MANAGER_ID
                                     AND OH.APPROVE_STATUS  = 'B'
                                     AND OH.EMAIL_STATUS    = 'AR'
                                     AND P_REQ_PERSON_ID    IN (HDM.APPROVER_ID1, HDM.APPROVER_ID2)
                                     AND DM.START_DATE      <= P_WORK_DATE
                                     AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                                 )
                  )
        LOOP
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID1 AND R1.MANAGER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;          
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID2 AND R1.MANAGER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID1 AND R1.APPROVER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID2 AND R1.APPROVER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
        END LOOP R1;
        
        -- 메일 상태 변경.
        BEGIN
          UPDATE HRD_OT_HEADER OH
            SET OH.EMAIL_STATUS   = 'AS'
          WHERE OH.CORP_ID        = P_CORP_ID
            AND OH.SOB_ID         = P_SOB_ID
            AND OH.ORG_ID         = P_ORG_ID
            AND OH.APPROVE_STATUS = 'B'
            AND OH.EMAIL_STATUS   = 'AR'
            AND EXISTS( SELECT 'X'
                          FROM HRD_DUTY_MANAGER DM
                        WHERE DM.DUTY_MANAGER_ID        = OH.DUTY_MANAGER_ID
                          AND DM.SOB_ID                 = OH.SOB_ID
                          AND DM.ORG_ID                 = OH.ORG_ID
                          AND P_REQ_PERSON_ID           IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                          AND DM.USABLE                 = 'Y'
                          AND DM.START_DATE             <= P_WORK_DATE
                          AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                      )
          ;
          COMMIT;
        EXCEPTION WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Mail Status Change Error : ' || SQLERRM);
        END;
------>> 
      ELSIF P_GUBUN = 'B_CANCEL' THEN
      -- 승인취소.
        FOR R1 IN ( SELECT DM.DUTY_MANAGER_ID
                         , DM.MANAGER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID1) AS MANAGER1_EMAIL
                         , DM.MANAGER_ID2 
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID2) AS MANAGER2_EMAIL
                         , DM.APPROVER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID1) AS APPROVER1_EMAIL
                         , DM.APPROVER_ID2
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID2) AS APPROVER2_EMAIL
                      FROM HRD_DUTY_MANAGER DM
                    WHERE DM.CORP_ID         = P_CORP_ID
                      AND DM.SOB_ID          = P_SOB_ID
                      AND DM.ORG_ID          = P_ORG_ID
                      AND DM.USABLE          = 'Y'
                      AND DM.START_DATE      <= P_WORK_DATE
                      AND (DM.END_DATE IS NULL OR DM.END_DATE >= P_WORK_DATE)
                      AND EXISTS ( SELECT 'X'
                                     FROM HRD_OT_HEADER OH
                                       , HRD_DUTY_MANAGER HDM
                                   WHERE OH.DUTY_MANAGER_ID = HDM.DUTY_MANAGER_ID
                                     AND OH.DUTY_MANAGER_ID = DM.DUTY_MANAGER_ID
                                     AND OH.APPROVE_STATUS  = 'A'
                                     AND OH.EMAIL_STATUS    = 'BR'
                                     AND P_REQ_PERSON_ID    IN (HDM.APPROVER_ID1, HDM.APPROVER_ID2)
                                     AND DM.USABLE          = 'Y'
                                     AND DM.START_DATE      <= P_WORK_DATE
                                     AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                                 )
                  )
        LOOP
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID1 AND R1.MANAGER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;          
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID2 AND R1.MANAGER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID1 AND R1.APPROVER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID2 AND R1.APPROVER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
        END LOOP R1;
        -- 메일 상태 변경.
        BEGIN
          UPDATE HRD_OT_HEADER OH
            SET OH.EMAIL_STATUS   = 'BS'
          WHERE OH.CORP_ID        = P_CORP_ID
            AND OH.SOB_ID         = P_SOB_ID
            AND OH.ORG_ID         = P_ORG_ID
            AND OH.APPROVE_STATUS = 'A'
            AND OH.EMAIL_STATUS   = 'BR'
            AND EXISTS( SELECT 'X'
                          FROM HRD_DUTY_MANAGER DM
                        WHERE DM.DUTY_MANAGER_ID        = OH.DUTY_MANAGER_ID
                          AND DM.SOB_ID                 = OH.SOB_ID
                          AND DM.ORG_ID                 = OH.ORG_ID
                          AND P_REQ_PERSON_ID           IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                          AND DM.USABLE                 = 'Y'
                          AND DM.START_DATE             <= P_WORK_DATE
                          AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                      )
          ;
          COMMIT;
        EXCEPTION WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Mail Status Change Error : ' || SQLERRM);
        END;
------>> 
      ELSIF P_GUBUN = 'RETURN' THEN
      -- 연장근무 신청 반려.
        FOR R1 IN ( SELECT DM.DUTY_MANAGER_ID
                         , DM.MANAGER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID1) AS MANAGER1_EMAIL
                         , DM.MANAGER_ID2 
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID2) AS MANAGER2_EMAIL
                         , DM.APPROVER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID1) AS APPROVER1_EMAIL
                         , DM.APPROVER_ID2
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID2) AS APPROVER2_EMAIL
                      FROM HRD_DUTY_MANAGER DM
                    WHERE DM.CORP_ID         = P_CORP_ID
                      AND DM.SOB_ID          = P_SOB_ID
                      AND DM.ORG_ID          = P_ORG_ID
                      AND DM.USABLE          = 'Y'
                      AND DM.START_DATE      <= P_WORK_DATE
                      AND (DM.END_DATE IS NULL OR DM.END_DATE >= P_WORK_DATE)
                      AND EXISTS ( SELECT 'X'
                                     FROM HRD_OT_HEADER OH
                                       , HRD_DUTY_MANAGER HDM
                                   WHERE OH.DUTY_MANAGER_ID = HDM.DUTY_MANAGER_ID
                                     AND OH.DUTY_MANAGER_ID = DM.DUTY_MANAGER_ID
                                     AND OH.APPROVE_STATUS  = 'R'
                                     AND OH.EMAIL_STATUS    = 'RR'
                                     AND P_REQ_PERSON_ID    IN (HDM.APPROVER_ID1, HDM.APPROVER_ID2)
                                     AND DM.USABLE          = 'Y'
                                     AND DM.START_DATE      <= P_WORK_DATE
                                     AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                                 )
                  )
        LOOP
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID1 AND R1.MANAGER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;          
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID2 AND R1.MANAGER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID1 AND R1.APPROVER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID2 AND R1.APPROVER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
        END LOOP R1;
        -- 메일 상태 변경.
        BEGIN
          UPDATE HRD_OT_HEADER OH
            SET OH.EMAIL_STATUS   = 'RS'
          WHERE OH.CORP_ID        = P_CORP_ID
            AND OH.SOB_ID         = P_SOB_ID
            AND OH.ORG_ID         = P_ORG_ID
            AND OH.APPROVE_STATUS = 'R'
            AND OH.EMAIL_STATUS   = 'RR'
            AND EXISTS( SELECT 'X'
                          FROM HRD_DUTY_MANAGER DM
                        WHERE DM.DUTY_MANAGER_ID        = OH.DUTY_MANAGER_ID
                          AND DM.SOB_ID                 = OH.SOB_ID
                          AND DM.ORG_ID                 = OH.ORG_ID
                          AND P_REQ_PERSON_ID           IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                          AND DM.USABLE                 = 'Y'
                          AND DM.START_DATE             <= P_WORK_DATE
                          AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                      )
          ;
          COMMIT;
        EXCEPTION WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Mail Status Change Error : ' || SQLERRM);
        END;
      END IF;
---------------------------------------------------------------------------------------------------
    ELSIF P_SOURCE_TYPE = 'HOLY' THEN
    -- 대체근무.
/*       raise_application_error(-20001, P_SOURCE_TYPE || '/' || p_gubun);*/
------>> 
      IF P_GUBUN = 'A' THEN
      -- 승인처리.
        FOR R1 IN ( SELECT DM.MANAGER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID1) AS MANAGER1_EMAIL
                         , DM.MANAGER_ID2 
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID2) AS MANAGER2_EMAIL
                         , DM.APPROVER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID1) AS APPROVER1_EMAIL
                         , DM.APPROVER_ID2
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID2) AS APPROVER2_EMAIL
                      FROM HRD_DUTY_MANAGER DM
                    WHERE DM.CORP_ID         = P_CORP_ID
                      AND DM.SOB_ID          = P_SOB_ID
                      AND DM.ORG_ID          = P_ORG_ID
                      AND DM.USABLE          = 'Y'
                      AND DM.START_DATE      <= P_WORK_DATE
                      AND (DM.END_DATE IS NULL OR DM.END_DATE >= P_WORK_DATE)
                      AND DM.DUTY_CONTROL_ID IN 
                          ( SELECT DISTINCT PM.FLOOR_ID
                              FROM HRD_HOLY_TYPE HT
                                , HRM_PERSON_MASTER PM
                            WHERE HT.PERSON_ID          = PM.PERSON_ID
                              AND PM.WORK_CORP_ID       = P_CORP_ID
                              AND HT.SOB_ID             = P_SOB_ID
                              AND HT.ORG_ID             = P_ORG_ID
                              AND HT.APPROVE_STATUS     = 'A'
                              AND HT.EMAIL_STATUS       = 'AR'
                              AND EXISTS (SELECT 'X'
                                            FROM HRD_DUTY_MANAGER DM
                                            WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                                             AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                                             AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                             AND P_REQ_PERSON_ID                  IN(DM.MANAGER_ID1, DM.MANAGER_ID2)
                                             AND DM.USABLE                        = 'Y'
                                             AND DM.START_DATE                    <= P_WORK_DATE
                                             AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                                             AND DM.SOB_ID                        = PM.SOB_ID
                                             AND DM.ORG_ID                        = PM.ORG_ID
                                         )
                          )
                  )
        LOOP      
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID1 AND R1.MANAGER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;          
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID2 AND R1.MANAGER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID1 AND R1.APPROVER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID2 AND R1.APPROVER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
        END LOOP R1;
        
        -- 메일 상태 변경.
        BEGIN
          UPDATE HRD_HOLY_TYPE HT
            SET HT.EMAIL_STATUS   = 'AS'
          WHERE HT.CORP_ID        = P_CORP_ID
            AND HT.SOB_ID         = P_SOB_ID
            AND HT.ORG_ID         = P_ORG_ID
            AND HT.APPROVE_STATUS     = 'A'
            AND HT.EMAIL_STATUS       = 'AR'
            AND EXISTS 
                ( SELECT 'X'
                    FROM HRM_PERSON_MASTER PM
                  WHERE PM.PERSON_ID        = HT.PERSON_ID
                    AND EXISTS
                        ( SELECT 'X'
                            FROM HRD_DUTY_MANAGER DM
                          WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                           AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                           AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                           AND P_REQ_PERSON_ID                  IN(DM.MANAGER_ID1, DM.MANAGER_ID2)
                           AND DM.USABLE                        = 'Y'
                           AND DM.START_DATE                    <= P_WORK_DATE
                           AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                           AND DM.SOB_ID                        = PM.SOB_ID
                           AND DM.ORG_ID                        = PM.ORG_ID
                        )
                )
          ;
          COMMIT;
        EXCEPTION WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Mail Status Change Error : ' || SQLERRM);
        END;
------>> 
      ELSIF P_GUBUN = 'A_OK' THEN
      -- 승인처리.
        FOR R1 IN ( SELECT DM.MANAGER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID1) AS MANAGER1_EMAIL
                         , DM.MANAGER_ID2 
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID2) AS MANAGER2_EMAIL
                         , DM.APPROVER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID1) AS APPROVER1_EMAIL
                         , DM.APPROVER_ID2
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID2) AS APPROVER2_EMAIL
                      FROM HRD_DUTY_MANAGER DM
                    WHERE DM.CORP_ID         = P_CORP_ID
                      AND DM.SOB_ID          = P_SOB_ID
                      AND DM.ORG_ID          = P_ORG_ID
                      AND DM.USABLE          = 'Y'
                      AND DM.START_DATE      <= P_WORK_DATE
                      AND (DM.END_DATE IS NULL OR DM.END_DATE >= P_WORK_DATE)
                      AND DM.DUTY_CONTROL_ID IN 
                          ( SELECT DISTINCT PM.FLOOR_ID
                              FROM HRD_HOLY_TYPE HT
                                , HRM_PERSON_MASTER PM
                            WHERE HT.PERSON_ID          = PM.PERSON_ID
                              AND PM.WORK_CORP_ID       = P_CORP_ID
                              AND HT.SOB_ID             = P_SOB_ID
                              AND HT.ORG_ID             = P_ORG_ID
                              AND HT.APPROVE_STATUS     = 'B'
                              AND HT.EMAIL_STATUS       = 'AR'
                              AND EXISTS (SELECT 'X'
                                            FROM HRD_DUTY_MANAGER DM
                                            WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                                             AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                                             AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                             AND P_REQ_PERSON_ID                  IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                                             AND DM.USABLE                        = 'Y'
                                             AND DM.START_DATE                    <= P_WORK_DATE
                                             AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                                             AND DM.SOB_ID                        = PM.SOB_ID
                                             AND DM.ORG_ID                        = PM.ORG_ID
                                         )
                          )
                  )
        LOOP
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID1 AND R1.MANAGER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;          
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID2 AND R1.MANAGER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID1 AND R1.APPROVER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID2 AND R1.APPROVER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
        END LOOP R1;
        
        -- 메일 상태 변경.
        BEGIN
          UPDATE HRD_HOLY_TYPE HT
            SET HT.EMAIL_STATUS   = 'AS'
          WHERE HT.CORP_ID        = P_CORP_ID
            AND HT.SOB_ID         = P_SOB_ID
            AND HT.ORG_ID         = P_ORG_ID
            AND HT.APPROVE_STATUS     = 'B'
            AND HT.EMAIL_STATUS       = 'AR'
            AND EXISTS 
                ( SELECT 'X'
                    FROM HRM_PERSON_MASTER PM
                  WHERE PM.PERSON_ID        = HT.PERSON_ID
                    AND EXISTS
                        ( SELECT 'X'
                            FROM HRD_DUTY_MANAGER DM
                          WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                           AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                           AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                           AND P_REQ_PERSON_ID                  IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                           AND DM.USABLE                        = 'Y'
                           AND DM.START_DATE                    <= P_WORK_DATE
                           AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                           AND DM.SOB_ID                        = PM.SOB_ID
                           AND DM.ORG_ID                        = PM.ORG_ID
                        )
                )
          ;
          COMMIT;
        EXCEPTION WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Mail Status Change Error : ' || SQLERRM);
        END;
------>> 
      ELSIF P_GUBUN = 'B_CANCEL' THEN
      -- 승인취소.
        /*raise_application_error(-20001, P_SOURCE_TYPE || '/' || p_gubun);*/
        FOR R1 IN ( SELECT DM.MANAGER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID1) AS MANAGER1_EMAIL
                         , DM.MANAGER_ID2 
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID2) AS MANAGER2_EMAIL
                         , DM.APPROVER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID1) AS APPROVER1_EMAIL
                         , DM.APPROVER_ID2
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID2) AS APPROVER2_EMAIL
                      FROM HRD_DUTY_MANAGER DM
                    WHERE DM.CORP_ID         = P_CORP_ID
                      AND DM.SOB_ID          = P_SOB_ID
                      AND DM.ORG_ID          = P_ORG_ID
                      AND DM.USABLE          = 'Y'
                      AND DM.START_DATE      <= P_WORK_DATE
                      AND (DM.END_DATE IS NULL OR DM.END_DATE >= P_WORK_DATE)
                      AND DM.DUTY_CONTROL_ID IN 
                          ( SELECT DISTINCT PM.FLOOR_ID
                              FROM HRD_HOLY_TYPE HT
                                , HRM_PERSON_MASTER PM
                            WHERE HT.PERSON_ID          = PM.PERSON_ID
                              AND PM.WORK_CORP_ID       = P_CORP_ID
                              AND HT.SOB_ID             = P_SOB_ID
                              AND HT.ORG_ID             = P_ORG_ID
                              AND HT.APPROVE_STATUS     = 'A'
                              AND HT.EMAIL_STATUS       = 'BR'
                              AND EXISTS (SELECT 'X'
                                            FROM HRD_DUTY_MANAGER DM
                                            WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                                             AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                                             AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                             AND P_REQ_PERSON_ID                  IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                                             AND DM.USABLE                        = 'Y'
                                             AND DM.START_DATE                    <= P_WORK_DATE
                                             AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                                             AND DM.SOB_ID                        = PM.SOB_ID
                                             AND DM.ORG_ID                        = PM.ORG_ID
                                         )
                          )
                  )
        LOOP
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID1 AND R1.MANAGER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;          
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID2 AND R1.MANAGER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID1 AND R1.APPROVER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID2 AND R1.APPROVER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
        END LOOP R1;
        -- 메일 상태 변경.
        BEGIN
          UPDATE HRD_HOLY_TYPE HT
            SET HT.EMAIL_STATUS   = 'BS'
          WHERE HT.CORP_ID        = P_CORP_ID
            AND HT.SOB_ID         = P_SOB_ID
            AND HT.ORG_ID         = P_ORG_ID
            AND HT.APPROVE_STATUS     = 'A'
            AND HT.EMAIL_STATUS       = 'BR'
            AND EXISTS 
                ( SELECT 'X'
                    FROM HRM_PERSON_MASTER PM
                  WHERE PM.PERSON_ID        = HT.PERSON_ID
                    AND EXISTS
                        ( SELECT 'X'
                            FROM HRD_DUTY_MANAGER DM
                          WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                           AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                           AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                           AND P_REQ_PERSON_ID                  IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                           AND DM.USABLE                        = 'Y'
                           AND DM.START_DATE                    <= P_WORK_DATE
                           AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                           AND DM.SOB_ID                        = PM.SOB_ID
                           AND DM.ORG_ID                        = PM.ORG_ID
                        )
                )
          ;
          COMMIT;
        EXCEPTION WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Mail Status Change Error : ' || SQLERRM);
        END;
------>> 
      ELSIF P_GUBUN = 'RETURN' THEN
      -- 반려.
        FOR R1 IN ( SELECT DM.MANAGER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID1) AS MANAGER1_EMAIL
                         , DM.MANAGER_ID2 
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.MANAGER_ID2) AS MANAGER2_EMAIL
                         , DM.APPROVER_ID1
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID1) AS APPROVER1_EMAIL
                         , DM.APPROVER_ID2
                         , HRM_PERSON_MASTER_G.EMAIL_F(DM.APPROVER_ID2) AS APPROVER2_EMAIL
                      FROM HRD_DUTY_MANAGER DM
                    WHERE DM.CORP_ID         = P_CORP_ID
                      AND DM.SOB_ID          = P_SOB_ID
                      AND DM.ORG_ID          = P_ORG_ID
                      AND DM.USABLE          = 'Y'
                      AND DM.START_DATE      <= P_WORK_DATE
                      AND (DM.END_DATE IS NULL OR DM.END_DATE >= P_WORK_DATE)
                      AND DM.DUTY_CONTROL_ID IN 
                          ( SELECT DISTINCT PM.FLOOR_ID
                              FROM HRD_HOLY_TYPE HT
                                , HRM_PERSON_MASTER PM
                            WHERE HT.PERSON_ID          = PM.PERSON_ID
                              AND PM.WORK_CORP_ID       = P_CORP_ID
                              AND HT.SOB_ID             = P_SOB_ID
                              AND HT.ORG_ID             = P_ORG_ID
                              AND HT.APPROVE_STATUS     = 'R'
                              AND HT.EMAIL_STATUS       = 'RR'
                              AND EXISTS (SELECT 'X'
                                            FROM HRD_DUTY_MANAGER DM
                                            WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                                             AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                                             AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                             AND P_REQ_PERSON_ID                  IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                                             AND DM.USABLE                        = 'Y'
                                             AND DM.START_DATE                    <= P_WORK_DATE
                                             AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                                             AND DM.SOB_ID                        = PM.SOB_ID
                                             AND DM.ORG_ID                        = PM.ORG_ID
                                         )
                          )
                  )
        LOOP
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID1 AND R1.MANAGER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;          
          IF P_REQ_PERSON_ID <> R1.MANAGER_ID2 AND R1.MANAGER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.MANAGER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID1 AND R1.APPROVER1_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER1_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
          IF P_REQ_PERSON_ID <> R1.APPROVER_ID2 AND R1.APPROVER2_EMAIL IS NOT NULL THEN
            IF SEND_MAIL( V_MAIL_FR
                        , R1.APPROVER2_EMAIL
                        , V_SUBJECT
                        , V_CONTENT
                        ) = FALSE THEN
              DBMS_OUTPUT.PUT_LINE('E-MAIL SEND ERROR : ' || SQLERRM);
            END IF;
          END IF;
        END LOOP R1;
        -- 메일 상태 변경.
        BEGIN
          UPDATE HRD_HOLY_TYPE HT
            SET HT.EMAIL_STATUS   = 'RS'
          WHERE HT.CORP_ID        = P_CORP_ID
            AND HT.SOB_ID         = P_SOB_ID
            AND HT.ORG_ID         = P_ORG_ID
            AND HT.APPROVE_STATUS     = 'R'
            AND HT.EMAIL_STATUS       = 'RR'
            AND EXISTS 
                ( SELECT 'X'
                    FROM HRM_PERSON_MASTER PM
                  WHERE PM.PERSON_ID        = HT.PERSON_ID
                    AND EXISTS
                        ( SELECT 'X'
                            FROM HRD_DUTY_MANAGER DM
                          WHERE DM.CORP_ID                      = PM.WORK_CORP_ID
                           AND DM.DUTY_CONTROL_ID               = PM.FLOOR_ID
                           AND DM.WORK_TYPE_ID                  = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                           AND P_REQ_PERSON_ID                  IN(DM.APPROVER_ID1, DM.APPROVER_ID2)
                           AND DM.USABLE                        = 'Y'
                           AND DM.START_DATE                    <= P_WORK_DATE
                           AND (DM.END_DATE IS NULL OR DM.END_DATE  >= P_WORK_DATE)
                           AND DM.SOB_ID                        = PM.SOB_ID
                           AND DM.ORG_ID                        = PM.ORG_ID
                        )
                )
          ;
          COMMIT;
        EXCEPTION WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Mail Status Change Error : ' || SQLERRM);
        END;
      END IF;
    END IF;    
  END MAKE_MAIL;


-- 메일 발송.
  FUNCTION SEND_MAIL
            ( P_MAIL_FR           IN VARCHAR2
            , P_MAIL_TO           IN VARCHAR2
            , P_SUBJECT           IN VARCHAR2
            , P_CONTENT           IN VARCHAR2
            ) RETURN BOOLEAN            
  AS
    V_SMTP_SVR          VARCHAR2(100) := '211.168.59.111';
    V_CONN              UTL_SMTP.CONNECTION;
    
    PROCEDURE SEND_HEADER
              ( P_NAME            IN VARCHAR2
              , P_HEADER          IN VARCHAR2              
              )
    AS
    BEGIN
      UTL_SMTP.WRITE_RAW_DATA(V_CONN, UTL_RAW.CAST_TO_RAW(P_NAME || ': ' || P_HEADER || UTL_TCP.CRLF));
    END SEND_HEADER;
  BEGIN
    V_CONN := UTL_SMTP.open_connection(V_SMTP_SVR);
    
    UTL_SMTP.helo(V_CONN, V_SMTP_SVR);
    UTL_SMTP.mail(V_CONN, P_MAIL_FR);
    UTL_SMTP.rcpt(V_CONN, P_MAIL_TO);
    
    UTL_SMTP.open_data(V_CONN);
    SEND_HEADER('Content-Type', 'text/html');
    SEND_HEADER('MIME_Version', '1.0');
    SEND_HEADER('Content-Type', 'text/html;charset=utf-8');      -- iso-2022-kr
    SEND_HEADER('From', '"' || P_MAIL_FR || '" <' || P_MAIL_FR || '>');
    SEND_HEADER('To', '"' || P_MAIL_TO || '" <' || P_MAIL_TO || '>');
    SEND_HEADER('Subject', P_SUBJECT);
    
    utl_smtp.write_raw_data(v_conn, utl_raw.cast_to_raw(utl_tcp.CRLF || p_content));
    utl_smtp.close_data(v_conn);
    utl_smtp.quit(v_conn);
    
    return true;
  exception 
    when others then
      utl_smtp.quit(v_conn);
      return false;
  END SEND_MAIL;
  
END HRD_MAIL_SEND;
/
