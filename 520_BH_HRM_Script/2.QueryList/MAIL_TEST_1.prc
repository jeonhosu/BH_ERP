CREATE OR REPLACE PROCEDURE MAIL_TEST_1(
pSender    VARCHAR2,
pRecipient VARCHAR2,
pSubject   VARCHAR2,
pMessage   VARCHAR2) IS

mailhost  CONSTANT VARCHAR2(30) := 'smtp.naver.com';   --// smtp server IP address
crlf      CONSTANT VARCHAR2(2):= CHR(13) || CHR(10);
mesg      VARCHAR2(1000);
mail_conn utl_smtp.connection;

BEGIN
   mail_conn := utl_smtp.open_connection(mailhost, 25);

   mesg := 'Date: ' ||
        TO_CHAR( SYSDATE, 'dd Mon yy hh24:mi:ss') || crlf ||
           'From: <'|| pSender ||'>' || crlf ||
           'Subject: '|| pSubject || crlf ||
           'To: '||pRecipient || crlf || '' || crlf || pMessage;

   utl_smtp.helo(mail_conn, mailhost);
   utl_smtp.mail(mail_conn, pSender);
   utl_smtp.rcpt(mail_conn, pRecipient);
   utl_smtp.data(mail_conn, mesg);
   utl_smtp.quit(mail_conn);
EXCEPTION

  WHEN OTHERS THEN
    NULL;
END MAIL_TEST_1;
/
