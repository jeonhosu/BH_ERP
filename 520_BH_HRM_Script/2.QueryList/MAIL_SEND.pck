CREATE OR REPLACE PACKAGE MAIL_SEND
AS

-- 근태 신청 : 메일 발송.
  PROCEDURE DUTY_REQUEST
            ( P_REQ_PERSON_ID       IN NUMBER            
            , P_SOURCE_TYPE         IN VARCHAR2
            , P_WORK_DATE           IN DATE            
            , P_SOB_ID              IN NUMBER
            , P_ORG_ID              IN NUMBER
            );

-- 메일 발송.
  PROCEDURE MAIL_SENDING
            ( P_MAIL_TO             IN VARCHAR2
            , P_MAIL_FROM           IN VARCHAR2
            , P_SUBJECT             IN VARCHAR2
            , P_MESSAGE1            IN VARCHAR2
            , P_MESSAGE2            IN VARCHAR2
            );

END MAIL_SEND;
/
CREATE OR REPLACE PACKAGE BODY MAIL_SEND
AS

-- 근태 신청 : 메일 발송.
  PROCEDURE DUTY_REQUEST
            ( P_REQ_PERSON_ID       IN NUMBER            
            , P_SOURCE_TYPE         IN VARCHAR2
            , P_WORK_DATE           IN DATE            
            , P_SOB_ID              IN NUMBER
            , P_ORG_ID              IN NUMBER
            )
  AS
    V_MAIL_TO                       VARCHAR2(200);
    V_MAIL_FROM                     VARCHAR2(200);    
    V_SUBJECT                       VARCHAR2(300);
    V_MESSGAE1                      VARCHAR2(500);
    V_MESSAGE2                      VARCHAR2(500);
  BEGIN
    V_MAIL_TO := HRM_PERSON_MASTER_G.EMAIL_F(P_REQ_PERSON_ID);
    
    IF P_SOURCE_TYPE = 'WORK' THEN
    -- 출퇴근.
      V_SUBJECT := '';
    ELSIF P_SOURCE_TYPE = 'DUTY' THEN
    -- 고정근태.
      V_SUBJECT := '';      
    ELSIF P_SOURCE_TYPE = 'OT' THEN
    -- 연장근무.
      V_SUBJECT := '';
    ELSIF P_SOURCE_TYPE = 'HOLY' THEN
    -- 대체근무.
      V_SUBJECT := '';
    END IF;
    
    MAIL_SEND.MAIL_SENDING( V_MAIL_TO
                          , V_MAIL_FROM
                          , V_SUBJECT
                          , V_MESSGAE1
                          , V_MESSAGE2
                          );
    
  END DUTY_REQUEST;
  
-- 근태 관련 메일 발송.
  PROCEDURE MAIL_SENDING
            ( P_MAIL_TO             IN VARCHAR2
            , P_MAIL_FROM           IN VARCHAR2
            , P_SUBJECT             IN VARCHAR2
            , P_MESSAGE1            IN VARCHAR2
            , P_MESSAGE2            IN VARCHAR2
            )
  AS
    V_SERVER                        VARCHAR2(300) := 'mail.flexcom.co.kr';
    V_CONN                          UTL_SMTP.CONNECTION;
  BEGIN  
    V_CONN := UTL_SMTP.open_connection(V_SERVER, 25);
    UTL_SMTP.helo(V_CONN, V_SERVER);
    UTL_SMTP.mail(V_CONN, P_MAIL_FROM, NULL);
    UTL_SMTP.rcpt(V_CONN, P_MAIL_TO, NULL);
    UTL_SMTP.open_data(V_CONN);
    UTL_SMTP.WRITE_DATA(V_CONN, 'Content-Type: text/html;charset=utf-8' || UTL_TCP.CRLF);
    UTL_SMTP.write_data(V_CONN, 'SUBJECT:=?UTF-8?Q?' ||
                       UTL_RAW.cast_to_varchar2(UTL_ENCODE.quoted_printable_encode(UTL_RAW.cast_to_raw(P_SUBJECT))) ||
                       '?=' ||
                       UTL_TCP.CRLF);
    UTL_SMTP.WRITE_DATA(V_CONN, 'MIME-version: 1.0' || UTL_TCP.CRLF);
    UTL_SMTP.WRITE_DATA(V_CONN, 'Content-Type: text/html;charset=utf-8' || UTL_TCP.CRLF);
    UTL_SMTP.WRITE_DATA(V_CONN, 'Content-Transfer-Encoding: quoted-printable '|| UTL_TCP.CRLF);
    UTL_SMTP.WRITE_DATA(V_CONN, 'Date: ' || TO_CHAR(SYSDATE, 'dd Mon yy hh24:mi:ss' ) ||' -0800 (GMT)' || UTL_TCP.CRLF);
    UTL_SMTP.WRITE_DATA(V_CONN, 'From: ' || P_MAIL_FROM || UTL_TCP.CRLF);
    UTL_SMTP.WRITE_DATA(V_CONN, 'To: ' || P_MAIL_TO || UTL_TCP.CRLF);
    UTL_SMTP.WRITE_DATA(V_CONN, UTL_TCP.CRLF);
    UTL_SMTP.WRITE_RAW_DATA(V_CONN, UTL_ENCODE.QUOTED_PRINTABLE_ENCODE(UTL_RAW.CAST_TO_RAW(P_MESSAGE1)));
    UTL_SMTP.WRITE_DATA(V_CONN, CHR(10));
    UTL_SMTP.WRITE_RAW_DATA(V_CONN, UTL_ENCODE.QUOTED_PRINTABLE_ENCODE(UTL_RAW.CAST_TO_RAW(P_MESSAGE2)));
    UTL_SMTP.WRITE_DATA(V_CONN, UTL_TCP.CRLF);
    UTL_SMTP.CLOSE_DATA(V_CONN);
    UTL_SMTP.QUIT(V_CONN);
  END MAIL_SENDING;

END MAIL_SEND;
/
