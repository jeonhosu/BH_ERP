CREATE OR REPLACE PACKAGE ERRNUMS
IS
-- User Error.
  Insert_Error              EXCEPTION;
	Update_Error              EXCEPTION;
	Delete_Error              EXCEPTION;

-- SEQUENCE ERROR.
  Invalid_Sequence_ID       EXCEPTION;
	Invalid_Sequence_Code     CONSTANT NUMBER := -20101;
	Invalid_Sequence_Desc     CONSTANT VARCHAR2(300)
	        := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10041', NULL);
  PRAGMA EXCEPTION_INIT (Invalid_Sequence_ID, -20101);

-- Invalid Modify.
  Invalid_Modify            EXCEPTION;
  Invalid_Modify_Code       CONSTANT NUMBER := -20101;
  Invalid_Modify_DESC       CONSTANT VARCHAR2(300)
         := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=Modify(����)');
  PRAGMA EXCEPTION_INIT (Invalid_Modify, -20101);

-- Duty Not Found
  Duty_Not_Found            EXCEPTION;
  Duty_Not_Found_Code       constant Number := -20102;
  Duty_Not_Found_Desc       Constant Varchar2(300)
          := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10045', '&&VALUE:=���� �⺻��&&TEXT:=�����ڵ带 Ȯ���ϼ���');
  PRAGMA EXCEPTION_INIT (Duty_Not_Found, -20102);

-- Data Not Found.
  Data_Not_Found            EXCEPTION;
	Data_Not_Found_Code       CONSTANT NUMBER := -20102;
	Data_Not_Found_Desc       CONSTANT VARCHAR2(300)
	         := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10054', NULL);
  PRAGMA EXCEPTION_INIT (Data_Not_Found, -20102);

-- Data Closed.
  Data_Closed               EXCEPTION;
	Data_Closed_Code          Constant Number := -20103;
	Data_closed_Desc          Constant Varchar2(300)
	        := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10052', NULL);
  PRAGMA EXCEPTION_INIT (Data_Closed, -20103);

-- Data Transfer complete.
  Transfer_Completed        EXCEPTION;
	Transfer_Completed_Code   Constant Number := -20104;
	Transfer_Completed_Desc   Constant Varchar2(300)
	        := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10053', NULL);
  PRAGMA EXCEPTION_INIT (Transfer_Completed, -20104);

-- Food Time Error.
  Food_Time_Error           EXCEPTION;
	Food_Time_Error_Code      Constant Number := -20105;
	Food_Time_Error_Desc      Constant Varchar2(300)
	        := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10064', NULL);
  PRAGMA EXCEPTION_INIT (Food_Time_Error, -20105);

-- Exist Data Error.
  Exist_Data                EXCEPTION;
  Exist_Data_Code           Constant Number := -20106;
  Exist_Data_Desc           Constant Varchar2(300)
          := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90003', '&&FIELD_NAME:=Data(�ش� �ڷ�)');
  PRAGMA EXCEPTION_INIT (Exist_Data, -20106);

-- �������� ���� �ڷ� ����.
  Exist_Next_Data           Exception;
  Exist_Next_Code           Constant Number := -20001;
  Exist_Next_Desc           Constant Varchar2(300)
          := eapp_message_g.RETURN_TEXT_F(userenv_g.GET_TERRITORY_S_F, 'FCM_10150', null);
  pragma exception_init (Exist_Next_Data, -20001);

-- �����ڷ� ���� ����.
  Closed_Not_Create         EXCEPTION;
  Closed_Not_Create_Code    Constant Number := -20001;
  Closed_Not_Create_Desc    Constant Varchar2(300)
          := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10062', NULL);
  PRAGMA EXCEPTION_INIT (Closed_Not_Create, -20001);

-- Data Not Open.
  Data_Not_Opened           EXCEPTION;
  Data_Not_opened_Code      Constant Number := -20107;
  Data_Not_Opened_Desc      Constant Varchar2(300)
        := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10078', '&&VALUE:=Data(�ڷ�)');
  PRAGMA EXCEPTION_INIT (Data_Not_Opened, -20107);

-- � ȸ����� ����.
  Account_Book_Duplication  Exception;
  Account_Book_Duplication_Code Constant Number := -20001;
  Account_Book_Duplication_Desc Constant Varchar2(300)
        := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90003', '&&FIELD_NAME:=Operating Account Book(�ȸ�����)');
  PRAGMA EXCEPTION_INIT (Account_Book_Duplication, -20001);

-- ���α��� ����.
  Approval_Nothing          Exception;
  Approval_Nothing_Code     Constant Number := -20001;
  Approval_Nothing_Desc     Constant Varchar2(300)
        := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10009', '&&CAP:=Capacity(����)');
  PRAGMA EXCEPTION_INIT (Approval_Nothing, -20001);
  
-- �̹� ����ó����.
  Approve_OK                EXCEPTION;
  Approve_Code              Constant Number := -20001;
  Approve_Desc              Constant Varchar2(300)
    := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL);
  PRAGMA EXCEPTION_INIT (Approve_OK, -20001);

-- �����ڻ� ��������ڵ�.
  Asset_Charge              Exception;
  Asset_Charge_code         Constant Number := -20001;
  Asset_Charge_Desc         Constant Varchar2(300)
        := eapp_message_g.RETURN_TEXT_F(userenv_g.GET_TERRITORY_S_F, 'FCM_10224', null);
  pragma exception_init (Asset_Charge, -20001);

-- �����ڻ� ������� ����.
  Asset_DPR_Closed          Exception;
  Asset_DPR_Closed_Code     Constant Number := -20001;
  Asset_DRP_Closed_Desc     Constant Varchar2(300)
        := eapp_message_g.RETURN_TEXT_F(userenv_g.GET_TERRITORY_S_F, 'FCM_10225', null);
  pragma exception_init (Asset_DPR_Closed, -20001);
  
END ERRNUMS
; 
 
/