CREATE OR REPLACE PROCEDURE MAIL_SEND
          ( P_MAIL_TO             IN VARCHAR2
          , P_MAIL_FROM           IN VARCHAR2
          , P_SUBJECT             IN VARCHAR2
          , P_MESSAGE             IN VARCHAR2
          )
AS
  V_SERVER                        VARCHAR2(300) := 'mail.flexcom.co.kr';
  V_CONN                          UTL_SMTP.CONNECTION;
  
  V_MESSAGE_1                     VARCHAR2(300) := 'ERP 확인후 승인해 주시기 바랍니다';
BEGIN
  V_MESSAGE_1 := P_MESSAGE || UTL_TCP.CRLF || V_MESSAGE_1;
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
--  UTL_SMTP.WRITE_RAW_DATA(V_CONN, UTL_ENCODE.QUOTED_PRINTABLE_ENCODE(UTL_RAW.CAST_TO_RAW(P_MESSAGE)));
  UTL_SMTP.WRITE_RAW_DATA(V_CONN, UTL_ENCODE.QUOTED_PRINTABLE_ENCODE(UTL_RAW.CAST_TO_RAW(V_MESSAGE_1)));
  UTL_SMTP.WRITE_DATA(V_CONN, UTL_TCP.CRLF);
  UTL_SMTP.CLOSE_DATA(V_CONN);
  UTL_SMTP.QUIT(V_CONN);

EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.put_line(SQLERRM);
END;
/
