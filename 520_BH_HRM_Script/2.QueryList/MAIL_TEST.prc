CREATE OR REPLACE PROCEDURE MAIL_TEST
AS
  LV_SERVER       VARCHAR2(300) := 'smtp.gmail.com';
  LV_RCPT         VARCHAR2(300) := 'jeonlife@gmail.com';
  LV_FROM         VARCHAR2(300) := 'jeonlife@gmail.com';
  LV_SUBJECT      VARCHAR2(300) := 'UTL_SMTP 테스트';
  LV_MESSAGE      VARCHAR2(500) := '승인되었습니다. 승인해 주세요';
  LV_CONN         UTL_SMTP.CONNECTION;
BEGIN
  LV_CONN := UTL_SMTP.open_connection(LV_SERVER);
  UTL_SMTP.helo(LV_CONN, LV_SERVER);
  UTL_SMTP.mail(LV_CONN, LV_FROM);
  UTL_SMTP.rcpt(LV_CONN, LV_RCPT);
  UTL_SMTP.open_data(LV_CONN);
  UTL_SMTP.write_data(LV_CONN, 'SUBJECT:=?UTF-8?Q?' || 
                     UTL_RAW.cast_to_varchar2(UTL_ENCODE.quoted_printable_encode(UTL_RAW.cast_to_raw(LV_SUBJECT))) || 
                     '?=' || 
                     UTL_TCP.CRLF);
  UTL_SMTP.WRITE_DATA(lv_conn, 'MIME-version: 1.0' || UTL_TCP.CRLF);
  UTL_SMTP.WRITE_DATA(lv_conn, 'Content-Type: text/html;charset=utf-8' || UTL_TCP.CRLF);
  UTL_SMTP.WRITE_DATA(lv_conn, 'Content-Transfer-Encoding: quoted-printable '|| UTL_TCP.CRLF);
  UTL_SMTP.WRITE_DATA(lv_conn, 'Date: ' || TO_CHAR(SYSDATE, 'dd Mon yy hh24:mi:ss' ) ||' -0800 (GMT)' ||
  UTL_TCP.CRLF);
  UTL_SMTP.WRITE_DATA(lv_conn, 'From: ' || lv_from || UTL_TCP.CRLF);
  UTL_SMTP.WRITE_DATA(lv_conn, 'To: ' || lv_rcpt || UTL_TCP.CRLF);
  UTL_SMTP.WRITE_DATA(lv_conn, UTL_TCP.CRLF);
  UTL_SMTP.WRITE_RAW_DATA(lv_conn, UTL_ENCODE.QUOTED_PRINTABLE_ENCODE(UTL_RAW.CAST_TO_RAW
  (lv_message)));
  UTL_SMTP.WRITE_DATA(lv_conn, UTL_TCP.CRLF);
  UTL_SMTP.CLOSE_DATA(lv_conn);
  UTL_SMTP.QUIT(lv_conn);

END;
/
