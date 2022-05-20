CREATE OR REPLACE PACKAGE HRA_PREVIOUS_WORK_G
AS
----------------------------------------------------------------------------------------- 
-- ��� ��ȸ.
----------------------------------------------------------------------------------------- 
  PROCEDURE SELECT_PERSON
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN NUMBER
            , W_STD_YYYYMM        IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

-----------------------------------------------------------------------------------------      
-- �� 1 �����ٹ��� SELECT.
----------------------------------------------------------------------------------------- 
  PROCEDURE SELECT_PLACE_SEQ_ONE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
            , P_PERSON_ID         IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
            , P_SEQ_NUM           IN HRA_PREVIOUS_WORK.SEQ_NUM%TYPE
            , P_SOB_ID            IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
            );

----------------------------------------------------------------------------------------- 
-- �� 1 �����ٹ��� INSERT.
----------------------------------------------------------------------------------------- 
  PROCEDURE INSERT_PLACE_SEQ_ONE
            (  P_YEAR_YYYY            IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
             , P_SOB_ID               IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
             , P_ORG_ID               IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
             , P_PERSON_ID            IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
             , P_SEQ_NUM              IN HRA_PREVIOUS_WORK.SEQ_NUM%TYPE
             , P_COMPANY_NAME         IN HRA_PREVIOUS_WORK.COMPANY_NAME%TYPE
             , P_COMPANY_NUM          IN HRA_PREVIOUS_WORK.COMPANY_NUM%TYPE
             , P_JOIN_DATE            IN HRA_PREVIOUS_WORK.JOIN_DATE%TYPE
             , P_RETR_DATE            IN HRA_PREVIOUS_WORK.RETR_DATE%TYPE
             , P_LONG_YYYY            IN HRA_PREVIOUS_WORK.LONG_YYYY%TYPE
             , P_LONG_MONTH           IN HRA_PREVIOUS_WORK.LONG_MONTH%TYPE
             , P_PAY_TOTAL_AMT        IN HRA_PREVIOUS_WORK.PAY_TOTAL_AMT%TYPE
             , P_BONUS_TOTAL_AMT      IN HRA_PREVIOUS_WORK.BONUS_TOTAL_AMT%TYPE
             , P_ADD_BONUS_AMT        IN HRA_PREVIOUS_WORK.ADD_BONUS_AMT%TYPE
             , P_STOCK_BENE_AMT       IN HRA_PREVIOUS_WORK.STOCK_BENE_AMT%TYPE
             , P_ANNU_INSUR_AMT       IN HRA_PREVIOUS_WORK.ANNU_INSUR_AMT%TYPE
             , P_MEDIC_INSUR_AMT      IN HRA_PREVIOUS_WORK.MEDIC_INSUR_AMT%TYPE
             , P_HIRE_INSUR_AMT       IN HRA_PREVIOUS_WORK.HIRE_INSUR_AMT%TYPE
             , P_IN_TAX_AMT           IN HRA_PREVIOUS_WORK.IN_TAX_AMT%TYPE
             , P_LOCAL_TAX_AMT        IN HRA_PREVIOUS_WORK.LOCAL_TAX_AMT%TYPE
             , P_SP_TAX_AMT           IN HRA_PREVIOUS_WORK.SP_TAX_AMT%TYPE
             , P_USER_ID              IN HRA_PREVIOUS_WORK.CREATED_BY%TYPE
             , P_NT_FOREIGNER_AMT     IN HRA_PREVIOUS_WORK.NT_FOREIGNER_AMT%TYPE
             , P_NT_BIRTH_AMT         IN HRA_PREVIOUS_WORK.NT_BIRTH_AMT%TYPE
             , P_NT_OT_AMT            IN HRA_PREVIOUS_WORK.NT_OT_AMT%TYPE
             , P_NT_OUTSIDE_AMT       IN HRA_PREVIOUS_WORK.NT_OUTSIDE_AMT%TYPE
             , P_NT_CHILD_AMT         IN HRA_PREVIOUS_WORK.NT_CHILD_AMT%TYPE  --����/���ߵ� ����������.
             , P_NT_RESEARCH_AMT      IN HRA_PREVIOUS_WORK.NT_RESEARCH_AMT%TYPE  --������� ����������.
             , P_NT_COMPANY_AMT       IN HRA_PREVIOUS_WORK.NT_COMPANY_AMT%TYPE  --��� ����������.
             , P_NT_DISASTER_AMT      IN HRA_PREVIOUS_WORK.NT_DISASTER_AMT%TYPE  --���ذ��ú�.
             );
             
----------------------------------------------------------------------------------------- 
-- �� 1 �����ٹ��� UPDATE.
-----------------------------------------------------------------------------------------
  PROCEDURE UPDATE_PLACE_SEQ_ONE
           ( W_YEAR_YYYY            IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
           , W_SOB_ID               IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
           , W_ORG_ID               IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
           , W_PERSON_ID            IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
           , W_SEQ_NUM              IN HRA_PREVIOUS_WORK.SEQ_NUM%TYPE
           , P_COMPANY_NAME         IN HRA_PREVIOUS_WORK.COMPANY_NAME%TYPE
           , P_COMPANY_NUM          IN HRA_PREVIOUS_WORK.COMPANY_NUM%TYPE
           , P_JOIN_DATE            IN HRA_PREVIOUS_WORK.JOIN_DATE%TYPE
           , P_RETR_DATE            IN HRA_PREVIOUS_WORK.RETR_DATE%TYPE
           , P_LONG_YYYY            IN HRA_PREVIOUS_WORK.LONG_YYYY%TYPE
           , P_LONG_MONTH           IN HRA_PREVIOUS_WORK.LONG_MONTH%TYPE
           , P_PAY_TOTAL_AMT        IN HRA_PREVIOUS_WORK.PAY_TOTAL_AMT%TYPE
           , P_BONUS_TOTAL_AMT      IN HRA_PREVIOUS_WORK.BONUS_TOTAL_AMT%TYPE
           , P_ADD_BONUS_AMT        IN HRA_PREVIOUS_WORK.ADD_BONUS_AMT%TYPE
           , P_STOCK_BENE_AMT       IN HRA_PREVIOUS_WORK.STOCK_BENE_AMT%TYPE
           , P_ANNU_INSUR_AMT       IN HRA_PREVIOUS_WORK.ANNU_INSUR_AMT%TYPE
           , P_MEDIC_INSUR_AMT      IN HRA_PREVIOUS_WORK.MEDIC_INSUR_AMT%TYPE
           , P_HIRE_INSUR_AMT       IN HRA_PREVIOUS_WORK.HIRE_INSUR_AMT%TYPE
           , P_IN_TAX_AMT           IN HRA_PREVIOUS_WORK.IN_TAX_AMT%TYPE
           , P_LOCAL_TAX_AMT        IN HRA_PREVIOUS_WORK.LOCAL_TAX_AMT%TYPE
           , P_SP_TAX_AMT           IN HRA_PREVIOUS_WORK.SP_TAX_AMT%TYPE           
           , P_USER_ID              IN HRA_PREVIOUS_WORK.CREATED_BY%TYPE           
           , P_NT_FOREIGNER_AMT     IN HRA_PREVIOUS_WORK.NT_FOREIGNER_AMT%TYPE
           , P_NT_BIRTH_AMT         IN HRA_PREVIOUS_WORK.NT_BIRTH_AMT%TYPE
           , P_NT_OT_AMT            IN HRA_PREVIOUS_WORK.NT_OT_AMT%TYPE
           , P_NT_OUTSIDE_AMT       IN HRA_PREVIOUS_WORK.NT_OUTSIDE_AMT%TYPE
           , P_NT_CHILD_AMT         IN HRA_PREVIOUS_WORK.NT_CHILD_AMT%TYPE  --����/���ߵ� ����������.
           , P_NT_RESEARCH_AMT      IN HRA_PREVIOUS_WORK.NT_RESEARCH_AMT%TYPE  --������� ����������.
           , P_NT_COMPANY_AMT       IN HRA_PREVIOUS_WORK.NT_COMPANY_AMT%TYPE  --��� ����������.
           , P_NT_DISASTER_AMT      IN HRA_PREVIOUS_WORK.NT_DISASTER_AMT%TYPE  --���ذ��ú�.
           );
           
-----------------------------------------------------------------------------------------
-- �� 1 �����ٹ��� DELETE. 
-----------------------------------------------------------------------------------------           
  PROCEDURE DELETE_PLACE_SEQ_ONE
           ( W_YEAR_YYYY  HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
           , W_SOB_ID  HRA_PREVIOUS_WORK.SOB_ID%TYPE
           , W_ORG_ID  HRA_PREVIOUS_WORK.ORG_ID%TYPE
           , W_PERSON_ID  HRA_PREVIOUS_WORK.PERSON_ID%TYPE
           , W_SEQ_NUM  HRA_PREVIOUS_WORK.SEQ_NUM%TYPE 
           );  
                          
----------------------------------------------------------------------------------------- 
-- �� 2 �����ٹ��� SELECT.
----------------------------------------------------------------------------------------- 
  PROCEDURE SELECT_PLACE_SEQ_TWO
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
            , P_PERSON_ID         IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
            , P_SEQ_NUM           IN HRA_PREVIOUS_WORK.SEQ_NUM%TYPE
            , P_SOB_ID            IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
            );

----------------------------------------------------------------------------------------- 
-- �� 2 �����ٹ��� INSERT.
----------------------------------------------------------------------------------------- 
  PROCEDURE INSERT_PLACE_SEQ_TWO
            (  P_YEAR_YYYY            IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
             , P_SOB_ID               IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
             , P_ORG_ID               IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
             , P_PERSON_ID            IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
             , P_SEQ_NUM              IN HRA_PREVIOUS_WORK.SEQ_NUM%TYPE
             , P_COMPANY_NAME         IN HRA_PREVIOUS_WORK.COMPANY_NAME%TYPE
             , P_COMPANY_NUM          IN HRA_PREVIOUS_WORK.COMPANY_NUM%TYPE
             , P_JOIN_DATE            IN HRA_PREVIOUS_WORK.JOIN_DATE%TYPE
             , P_RETR_DATE            IN HRA_PREVIOUS_WORK.RETR_DATE%TYPE
             , P_LONG_YYYY            IN HRA_PREVIOUS_WORK.LONG_YYYY%TYPE
             , P_LONG_MONTH           IN HRA_PREVIOUS_WORK.LONG_MONTH%TYPE
             , P_PAY_TOTAL_AMT        IN HRA_PREVIOUS_WORK.PAY_TOTAL_AMT%TYPE
             , P_BONUS_TOTAL_AMT      IN HRA_PREVIOUS_WORK.BONUS_TOTAL_AMT%TYPE
             , P_ADD_BONUS_AMT        IN HRA_PREVIOUS_WORK.ADD_BONUS_AMT%TYPE
             , P_STOCK_BENE_AMT       IN HRA_PREVIOUS_WORK.STOCK_BENE_AMT%TYPE
             , P_ANNU_INSUR_AMT       IN HRA_PREVIOUS_WORK.ANNU_INSUR_AMT%TYPE
             , P_MEDIC_INSUR_AMT      IN HRA_PREVIOUS_WORK.MEDIC_INSUR_AMT%TYPE
             , P_HIRE_INSUR_AMT       IN HRA_PREVIOUS_WORK.HIRE_INSUR_AMT%TYPE
             , P_IN_TAX_AMT           IN HRA_PREVIOUS_WORK.IN_TAX_AMT%TYPE
             , P_LOCAL_TAX_AMT        IN HRA_PREVIOUS_WORK.LOCAL_TAX_AMT%TYPE
             , P_SP_TAX_AMT           IN HRA_PREVIOUS_WORK.SP_TAX_AMT%TYPE
             , P_USER_ID              IN HRA_PREVIOUS_WORK.CREATED_BY%TYPE
             , P_NT_FOREIGNER_AMT     IN HRA_PREVIOUS_WORK.NT_FOREIGNER_AMT%TYPE
             , P_NT_BIRTH_AMT         IN HRA_PREVIOUS_WORK.NT_BIRTH_AMT%TYPE
             , P_NT_OT_AMT            IN HRA_PREVIOUS_WORK.NT_OT_AMT%TYPE
             , P_NT_OUTSIDE_AMT       IN HRA_PREVIOUS_WORK.NT_OUTSIDE_AMT%TYPE
             , P_NT_CHILD_AMT         IN HRA_PREVIOUS_WORK.NT_CHILD_AMT%TYPE  --����/���ߵ� ����������.
             , P_NT_RESEARCH_AMT      IN HRA_PREVIOUS_WORK.NT_RESEARCH_AMT%TYPE  --������� ����������.
             , P_NT_COMPANY_AMT       IN HRA_PREVIOUS_WORK.NT_COMPANY_AMT%TYPE  --��� ����������.
             , P_NT_DISASTER_AMT      IN HRA_PREVIOUS_WORK.NT_DISASTER_AMT%TYPE  --���ذ��ú�.
             );
             
----------------------------------------------------------------------------------------- 
-- �� 2 �����ٹ��� UPDATE.
-----------------------------------------------------------------------------------------
  PROCEDURE UPDATE_PLACE_SEQ_TWO
           ( W_YEAR_YYYY            IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
           , W_SOB_ID               IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
           , W_ORG_ID               IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
           , W_PERSON_ID            IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
           , W_SEQ_NUM              IN HRA_PREVIOUS_WORK.SEQ_NUM%TYPE
           , P_COMPANY_NAME         IN HRA_PREVIOUS_WORK.COMPANY_NAME%TYPE
           , P_COMPANY_NUM          IN HRA_PREVIOUS_WORK.COMPANY_NUM%TYPE
           , P_JOIN_DATE            IN HRA_PREVIOUS_WORK.JOIN_DATE%TYPE
           , P_RETR_DATE            IN HRA_PREVIOUS_WORK.RETR_DATE%TYPE
           , P_LONG_YYYY            IN HRA_PREVIOUS_WORK.LONG_YYYY%TYPE
           , P_LONG_MONTH           IN HRA_PREVIOUS_WORK.LONG_MONTH%TYPE
           , P_PAY_TOTAL_AMT        IN HRA_PREVIOUS_WORK.PAY_TOTAL_AMT%TYPE
           , P_BONUS_TOTAL_AMT      IN HRA_PREVIOUS_WORK.BONUS_TOTAL_AMT%TYPE
           , P_ADD_BONUS_AMT        IN HRA_PREVIOUS_WORK.ADD_BONUS_AMT%TYPE
           , P_STOCK_BENE_AMT       IN HRA_PREVIOUS_WORK.STOCK_BENE_AMT%TYPE
           , P_ANNU_INSUR_AMT       IN HRA_PREVIOUS_WORK.ANNU_INSUR_AMT%TYPE
           , P_MEDIC_INSUR_AMT      IN HRA_PREVIOUS_WORK.MEDIC_INSUR_AMT%TYPE
           , P_HIRE_INSUR_AMT       IN HRA_PREVIOUS_WORK.HIRE_INSUR_AMT%TYPE
           , P_IN_TAX_AMT           IN HRA_PREVIOUS_WORK.IN_TAX_AMT%TYPE
           , P_LOCAL_TAX_AMT        IN HRA_PREVIOUS_WORK.LOCAL_TAX_AMT%TYPE
           , P_SP_TAX_AMT           IN HRA_PREVIOUS_WORK.SP_TAX_AMT%TYPE           
           , P_USER_ID              IN HRA_PREVIOUS_WORK.CREATED_BY%TYPE           
           , P_NT_FOREIGNER_AMT     IN HRA_PREVIOUS_WORK.NT_FOREIGNER_AMT%TYPE
           , P_NT_BIRTH_AMT         IN HRA_PREVIOUS_WORK.NT_BIRTH_AMT%TYPE
           , P_NT_OT_AMT            IN HRA_PREVIOUS_WORK.NT_OT_AMT%TYPE
           , P_NT_OUTSIDE_AMT       IN HRA_PREVIOUS_WORK.NT_OUTSIDE_AMT%TYPE
           , P_NT_CHILD_AMT         IN HRA_PREVIOUS_WORK.NT_CHILD_AMT%TYPE  --����/���ߵ� ����������.
           , P_NT_RESEARCH_AMT      IN HRA_PREVIOUS_WORK.NT_RESEARCH_AMT%TYPE  --������� ����������.
           , P_NT_COMPANY_AMT       IN HRA_PREVIOUS_WORK.NT_COMPANY_AMT%TYPE  --��� ����������.
           , P_NT_DISASTER_AMT      IN HRA_PREVIOUS_WORK.NT_DISASTER_AMT%TYPE  --���ذ��ú�.
           );
           
-----------------------------------------------------------------------------------------
-- �� 2 �����ٹ��� DELETE. 
-----------------------------------------------------------------------------------------           
  PROCEDURE DELETE_PLACE_SEQ_TWO
           ( W_YEAR_YYYY  HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
           , W_SOB_ID  HRA_PREVIOUS_WORK.SOB_ID%TYPE
           , W_ORG_ID  HRA_PREVIOUS_WORK.ORG_ID%TYPE
           , W_PERSON_ID  HRA_PREVIOUS_WORK.PERSON_ID%TYPE
           , W_SEQ_NUM  HRA_PREVIOUS_WORK.SEQ_NUM%TYPE 
           );   

-----------------------------------------------------------------------------------------
-- �����ٹ��� ���� ��ȸ
-----------------------------------------------------------------------------------------
  PROCEDURE SELECT_PREVIOUST_WORK
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
            , P_PERSON_ID         IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
            , P_SOB_ID            IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
            );

----------------------------------------------------------------------------------------- 
-- �����ٹ��� INSERT.
----------------------------------------------------------------------------------------- 
  PROCEDURE INSERT_PREVIOUST_WORK
            ( P_YEAR_YYYY                  IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
             , P_SOB_ID                    IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
             , P_ORG_ID                    IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
             , P_PERSON_ID                 IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
             , P_SEQ_NUM                   IN HRA_PREVIOUS_WORK.SEQ_NUM%TYPE
             , P_COMPANY_NAME              IN HRA_PREVIOUS_WORK.COMPANY_NAME%TYPE
             , P_COMPANY_NUM               IN HRA_PREVIOUS_WORK.COMPANY_NUM%TYPE
             , P_JOIN_DATE                 IN HRA_PREVIOUS_WORK.JOIN_DATE%TYPE
             , P_RETR_DATE                 IN HRA_PREVIOUS_WORK.RETR_DATE%TYPE
             , P_LONG_YYYY                 IN HRA_PREVIOUS_WORK.LONG_YYYY%TYPE
             , P_LONG_MONTH                IN HRA_PREVIOUS_WORK.LONG_MONTH%TYPE
             , P_PAY_TOTAL_AMT             IN HRA_PREVIOUS_WORK.PAY_TOTAL_AMT%TYPE
             , P_BONUS_TOTAL_AMT           IN HRA_PREVIOUS_WORK.BONUS_TOTAL_AMT%TYPE
             , P_ADD_BONUS_AMT             IN HRA_PREVIOUS_WORK.ADD_BONUS_AMT%TYPE
             , P_STOCK_BENE_AMT            IN HRA_PREVIOUS_WORK.STOCK_BENE_AMT%TYPE
             , P_ANNU_INSUR_AMT            IN HRA_PREVIOUS_WORK.ANNU_INSUR_AMT%TYPE
             , P_MEDIC_INSUR_AMT           IN HRA_PREVIOUS_WORK.MEDIC_INSUR_AMT%TYPE
             , P_HIRE_INSUR_AMT            IN HRA_PREVIOUS_WORK.HIRE_INSUR_AMT%TYPE
             , P_IN_TAX_AMT                IN HRA_PREVIOUS_WORK.IN_TAX_AMT%TYPE
             , P_LOCAL_TAX_AMT             IN HRA_PREVIOUS_WORK.LOCAL_TAX_AMT%TYPE
             , P_SP_TAX_AMT                IN HRA_PREVIOUS_WORK.SP_TAX_AMT%TYPE
             , P_USER_ID                   IN HRA_PREVIOUS_WORK.CREATED_BY%TYPE
             , P_NT_FOREIGNER_AMT          IN HRA_PREVIOUS_WORK.NT_FOREIGNER_AMT%TYPE
             , P_NT_BIRTH_AMT              IN HRA_PREVIOUS_WORK.NT_BIRTH_AMT%TYPE
             , P_NT_OT_AMT                 IN HRA_PREVIOUS_WORK.NT_OT_AMT%TYPE
             , P_NT_OUTSIDE_AMT            IN HRA_PREVIOUS_WORK.NT_OUTSIDE_AMT%TYPE
             , P_NT_CHILD_AMT              IN HRA_PREVIOUS_WORK.NT_CHILD_AMT%TYPE             --����/���ߵ� ����������.
             , P_NT_RESEARCH_AMT           IN HRA_PREVIOUS_WORK.NT_RESEARCH_AMT%TYPE          --������� ����������.
             , P_NT_COMPANY_AMT            IN HRA_PREVIOUS_WORK.NT_COMPANY_AMT%TYPE           --��� ����������.
             , P_NT_DISASTER_AMT           IN HRA_PREVIOUS_WORK.NT_DISASTER_AMT%TYPE          --���ذ��ú�.
             , P_OFFICERS_RETIRE_OVER_AMT  IN HRA_PREVIOUS_WORK.OFFICERS_RETIRE_OVER_AMT%TYPE -- 2013-�ӿ������ҵ�ݾ� �ѵ��ʰ���
             , P_RD_SMALL_BUSINESS_AMT     IN HRA_PREVIOUS_WORK.RD_SMALL_BUSINESS_AMT%TYPE    -- �߼ұ���� ����ϴ� û�⿡ ���� �ҵ漼 ����ݾ�
             );
             
----------------------------------------------------------------------------------------- 
-- �����ٹ��� UPDATE.
-----------------------------------------------------------------------------------------
  PROCEDURE UPDATE_PREVIOUST_WORK
           ( W_YEAR_YYYY                 IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
           , W_SOB_ID                    IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
           , W_ORG_ID                    IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
           , W_PERSON_ID                 IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
           , W_SEQ_NUM                   IN HRA_PREVIOUS_WORK.SEQ_NUM%TYPE
           , P_COMPANY_NAME              IN HRA_PREVIOUS_WORK.COMPANY_NAME%TYPE
           , P_COMPANY_NUM               IN HRA_PREVIOUS_WORK.COMPANY_NUM%TYPE
           , P_JOIN_DATE                 IN HRA_PREVIOUS_WORK.JOIN_DATE%TYPE
           , P_RETR_DATE                 IN HRA_PREVIOUS_WORK.RETR_DATE%TYPE
           , P_LONG_YYYY                 IN HRA_PREVIOUS_WORK.LONG_YYYY%TYPE
           , P_LONG_MONTH                IN HRA_PREVIOUS_WORK.LONG_MONTH%TYPE
           , P_PAY_TOTAL_AMT             IN HRA_PREVIOUS_WORK.PAY_TOTAL_AMT%TYPE
           , P_BONUS_TOTAL_AMT           IN HRA_PREVIOUS_WORK.BONUS_TOTAL_AMT%TYPE
           , P_ADD_BONUS_AMT             IN HRA_PREVIOUS_WORK.ADD_BONUS_AMT%TYPE
           , P_STOCK_BENE_AMT            IN HRA_PREVIOUS_WORK.STOCK_BENE_AMT%TYPE
           , P_ANNU_INSUR_AMT            IN HRA_PREVIOUS_WORK.ANNU_INSUR_AMT%TYPE
           , P_MEDIC_INSUR_AMT           IN HRA_PREVIOUS_WORK.MEDIC_INSUR_AMT%TYPE
           , P_HIRE_INSUR_AMT            IN HRA_PREVIOUS_WORK.HIRE_INSUR_AMT%TYPE
           , P_IN_TAX_AMT                IN HRA_PREVIOUS_WORK.IN_TAX_AMT%TYPE
           , P_LOCAL_TAX_AMT             IN HRA_PREVIOUS_WORK.LOCAL_TAX_AMT%TYPE
           , P_SP_TAX_AMT                IN HRA_PREVIOUS_WORK.SP_TAX_AMT%TYPE           
           , P_USER_ID                   IN HRA_PREVIOUS_WORK.CREATED_BY%TYPE           
           , P_NT_FOREIGNER_AMT          IN HRA_PREVIOUS_WORK.NT_FOREIGNER_AMT%TYPE
           , P_NT_BIRTH_AMT              IN HRA_PREVIOUS_WORK.NT_BIRTH_AMT%TYPE
           , P_NT_OT_AMT                 IN HRA_PREVIOUS_WORK.NT_OT_AMT%TYPE
           , P_NT_OUTSIDE_AMT            IN HRA_PREVIOUS_WORK.NT_OUTSIDE_AMT%TYPE
           , P_NT_CHILD_AMT              IN HRA_PREVIOUS_WORK.NT_CHILD_AMT%TYPE  --����/���ߵ� ����������.
           , P_NT_RESEARCH_AMT           IN HRA_PREVIOUS_WORK.NT_RESEARCH_AMT%TYPE  --������� ����������.
           , P_NT_COMPANY_AMT            IN HRA_PREVIOUS_WORK.NT_COMPANY_AMT%TYPE  --��� ����������.
           , P_NT_DISASTER_AMT           IN HRA_PREVIOUS_WORK.NT_DISASTER_AMT%TYPE  --���ذ��ú�.
           , P_OFFICERS_RETIRE_OVER_AMT  IN HRA_PREVIOUS_WORK.OFFICERS_RETIRE_OVER_AMT%TYPE -- 2013-�ӿ������ҵ�ݾ� �ѵ��ʰ���
           , P_RD_SMALL_BUSINESS_AMT     IN HRA_PREVIOUS_WORK.RD_SMALL_BUSINESS_AMT%TYPE    -- �߼ұ���� ����ϴ� û�⿡ ���� �ҵ漼 ����ݾ�
           );
           
-----------------------------------------------------------------------------------------
-- �����ٹ��� DELETE. 
-----------------------------------------------------------------------------------------           
  PROCEDURE DELETE_PREVIOUST_WORK
           ( W_YEAR_YYYY  HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
           , W_SOB_ID  HRA_PREVIOUS_WORK.SOB_ID%TYPE
           , W_ORG_ID  HRA_PREVIOUS_WORK.ORG_ID%TYPE
           , W_PERSON_ID  HRA_PREVIOUS_WORK.PERSON_ID%TYPE
           , W_SEQ_NUM  HRA_PREVIOUS_WORK.SEQ_NUM%TYPE 
           );  

-----------------------------------------------------------------------------------------
-- ������ �ѹ� ������.
-----------------------------------------------------------------------------------------
  PROCEDURE GET_SEQ_NUMBER
            ( O_SEQ_NUMBER        OUT HRA_PREVIOUS_WORK.SEQ_NUM%TYPE
            , P_SOB_ID            IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
            , P_YEAR_YYYY         IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
            , P_PERSON_ID         IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
            );      
                  
END HRA_PREVIOUS_WORK_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_PREVIOUS_WORK_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRA_PREVIOUS_WORK_G
/* Description  : �����ٹ��� ���� ���� ��Ű��
/*
/* Reference by : �����ٹ��� ����
/* Program History : 
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 18-FAB-2011  Lee Sun Hee        Initialize
/******************************************************************************/

-----------------------------------------------------------------------------------------
-- �����ȸ.
-----------------------------------------------------------------------------------------
  PROCEDURE SELECT_PERSON
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN NUMBER
            , W_STD_YYYYMM        IN VARCHAR2
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS 
    V_STD_DATE          DATE := LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'));
  BEGIN
    OPEN P_CURSOR FOR
      SELECT TO_CHAR(V_STD_DATE, 'YYYY') AS PERIOD_YEAR
           , PM.NAME
           , PM.PERSON_NUM
           , PM.NAME || '(' ||PM.PERSON_NUM || ')' AS INFO
           , PM.REPRE_NUM
           , EAPP_REGISTER_AGE_F(PM.REPRE_NUM, V_STD_DATE, 0) AS AGE_NUM
           , DM.DEPT_NAME
           , DM.DEPT_CODE          
           , PM.ORI_JOIN_DATE
           , PM.RETIRE_DATE
           , PM.PERSON_ID
           , PM.CORP_ID
        FROM HRM_PERSON_MASTER PM
          , HRM_DEPT_MASTER DM
      WHERE PM.DEPT_ID                  = DM.DEPT_ID
        AND PM.CORP_ID                  = P_CORP_ID
        AND PM.SOB_ID                   = P_SOB_ID
        AND PM.ORG_ID                   = P_ORG_ID
        AND PM.JOIN_DATE                >= TRUNC(V_STD_DATE, 'YEAR')  -- ���س⵵ ���� �Ի��� 
        
        AND ((P_PERSON_ID               IS NULL AND 1 = 1)
        OR   (P_PERSON_ID               IS NOT NULL AND PM.PERSON_ID = P_PERSON_ID))
        ORDER BY PM.PERSON_NUM
      ;
  END SELECT_PERSON;
  
-----------------------------------------------------------------------------------------
-- �� 1 �����ٹ��� SELECT.
-----------------------------------------------------------------------------------------
  PROCEDURE SELECT_PLACE_SEQ_ONE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
            , P_PERSON_ID         IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
            , P_SEQ_NUM           IN HRA_PREVIOUS_WORK.SEQ_NUM%TYPE
            , P_SOB_ID            IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
            )
  AS 
  BEGIN
    OPEN P_CURSOR FOR
      SELECT   PW.SEQ_NUM         --���ٹ��� �Ϸù�ȣ.
             , PW.COMPANY_NAME    --��ü��.
             , PW.COMPANY_NUM     --����ڹ�ȣ.
             , PW.JOIN_DATE       --�Ի�����.
             , PW.RETR_DATE       --�������.
             , PW.LONG_YYYY       --�ټӳ��.
             , PW.LONG_MONTH      --�ټӿ���.
             , PW.PAY_TOTAL_AMT   --�ѱ޿���.
             , PW.BONUS_TOTAL_AMT --�ѻ󿩾�.
             , PW.ADD_BONUS_AMT   --�����󿩾�.
             , PW.STOCK_BENE_AMT  --�ֽĸż����ñ�����.
             , PW.NT_OUTSIDE_AMT  --���ܱٷμҵ�.
             , PW.NT_OT_AMT       --�߰��ٷμ���.
             , PW.NT_BIRTH_AMT    --��꺸������.
             , PW.NT_FOREIGNER_AMT--�ܱ��αٷ���.
             , PW.NT_CHILD_AMT    --����/���ߵ� ����������.
             , PW.NT_RESEARCH_AMT --������� ����������.
             , PW.NT_COMPANY_AMT  --��� ����������.
             , PW.NT_DISASTER_AMT --���ذ��ú�.
             , PW.MEDIC_INSUR_AMT --�ǰ�����.
             , PW.HIRE_INSUR_AMT  --��뺸��.
             , PW.ANNU_INSUR_AMT  --���ο���.
             , PW.IN_TAX_AMT      --�ҵ漼.
             , PW.LOCAL_TAX_AMT   --�ֹμ�.
             , PW.SP_TAX_AMT      --��Ư��.
      FROM HRA_PREVIOUS_WORK PW
     WHERE PW.YEAR_YYYY     =    P_YEAR_YYYY
       AND PW.PERSON_ID     =    P_PERSON_ID
       AND PW.SEQ_NUM       =    P_SEQ_NUM
       AND PW.SOB_ID        =    P_SOB_ID
       AND PW.ORG_ID        =    P_ORG_ID    
       ;
      
  END SELECT_PLACE_SEQ_ONE;
  
-----------------------------------------------------------------------------------------
-- �� 1 �����ٹ��� INSERT.
-----------------------------------------------------------------------------------------
  PROCEDURE INSERT_PLACE_SEQ_ONE
            ( P_YEAR_YYYY            IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
             , P_SOB_ID               IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
             , P_ORG_ID               IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
             , P_PERSON_ID            IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
             , P_SEQ_NUM              IN HRA_PREVIOUS_WORK.SEQ_NUM%TYPE
             , P_COMPANY_NAME         IN HRA_PREVIOUS_WORK.COMPANY_NAME%TYPE
             , P_COMPANY_NUM          IN HRA_PREVIOUS_WORK.COMPANY_NUM%TYPE
             , P_JOIN_DATE            IN HRA_PREVIOUS_WORK.JOIN_DATE%TYPE
             , P_RETR_DATE            IN HRA_PREVIOUS_WORK.RETR_DATE%TYPE
             , P_LONG_YYYY            IN HRA_PREVIOUS_WORK.LONG_YYYY%TYPE
             , P_LONG_MONTH           IN HRA_PREVIOUS_WORK.LONG_MONTH%TYPE
             , P_PAY_TOTAL_AMT        IN HRA_PREVIOUS_WORK.PAY_TOTAL_AMT%TYPE
             , P_BONUS_TOTAL_AMT      IN HRA_PREVIOUS_WORK.BONUS_TOTAL_AMT%TYPE
             , P_ADD_BONUS_AMT        IN HRA_PREVIOUS_WORK.ADD_BONUS_AMT%TYPE
             , P_STOCK_BENE_AMT       IN HRA_PREVIOUS_WORK.STOCK_BENE_AMT%TYPE
             , P_ANNU_INSUR_AMT       IN HRA_PREVIOUS_WORK.ANNU_INSUR_AMT%TYPE
             , P_MEDIC_INSUR_AMT      IN HRA_PREVIOUS_WORK.MEDIC_INSUR_AMT%TYPE
             , P_HIRE_INSUR_AMT       IN HRA_PREVIOUS_WORK.HIRE_INSUR_AMT%TYPE
             , P_IN_TAX_AMT           IN HRA_PREVIOUS_WORK.IN_TAX_AMT%TYPE
             , P_LOCAL_TAX_AMT        IN HRA_PREVIOUS_WORK.LOCAL_TAX_AMT%TYPE
             , P_SP_TAX_AMT           IN HRA_PREVIOUS_WORK.SP_TAX_AMT%TYPE
             , P_USER_ID              IN HRA_PREVIOUS_WORK.CREATED_BY%TYPE
             , P_NT_FOREIGNER_AMT     IN HRA_PREVIOUS_WORK.NT_FOREIGNER_AMT%TYPE
             , P_NT_BIRTH_AMT         IN HRA_PREVIOUS_WORK.NT_BIRTH_AMT%TYPE
             , P_NT_OT_AMT            IN HRA_PREVIOUS_WORK.NT_OT_AMT%TYPE
             , P_NT_OUTSIDE_AMT       IN HRA_PREVIOUS_WORK.NT_OUTSIDE_AMT%TYPE
             , P_NT_CHILD_AMT         IN HRA_PREVIOUS_WORK.NT_CHILD_AMT%TYPE  --����/���ߵ� ����������.
             , P_NT_RESEARCH_AMT      IN HRA_PREVIOUS_WORK.NT_RESEARCH_AMT%TYPE  --������� ����������.
             , P_NT_COMPANY_AMT       IN HRA_PREVIOUS_WORK.NT_COMPANY_AMT%TYPE  --��� ����������.
             , P_NT_DISASTER_AMT      IN HRA_PREVIOUS_WORK.NT_DISASTER_AMT%TYPE  --���ذ��ú�.
             )
  AS
    V_SYSDATE                         DATE := GET_LOCAL_DATE(P_SOB_ID);
   
  BEGIN
   
  INSERT INTO HRA_PREVIOUS_WORK
  (  YEAR_YYYY
   , SOB_ID 
   , ORG_ID 
   , PERSON_ID 
   , SEQ_NUM 
   , COMPANY_NAME 
   , COMPANY_NUM 
   , JOIN_DATE 
   , RETR_DATE 
   , LONG_YYYY 
   , LONG_MONTH 
   , PAY_TOTAL_AMT 
   , BONUS_TOTAL_AMT 
   , ADD_BONUS_AMT 
   , STOCK_BENE_AMT 
   , ANNU_INSUR_AMT 
   , MEDIC_INSUR_AMT 
   , HIRE_INSUR_AMT 
   , IN_TAX_AMT 
   , LOCAL_TAX_AMT 
   , SP_TAX_AMT 
   , CREATION_DATE 
   , CREATED_BY 
   , LAST_UPDATE_DATE 
   , LAST_UPDATED_BY 
   , NT_FOREIGNER_AMT 
   , NT_BIRTH_AMT 
   , NT_OT_AMT 
   , NT_OUTSIDE_AMT
   , NT_CHILD_AMT  --����/���ߵ� ����������.
   , NT_RESEARCH_AMT --������� ����������.
   , NT_COMPANY_AMT  --��� ����������.
   , NT_DISASTER_AMT  -- ���غ�.
   ) VALUES 
   ( P_YEAR_YYYY
   , P_SOB_ID
   , P_ORG_ID
   , P_PERSON_ID
   , P_SEQ_NUM
   , P_COMPANY_NAME
   , P_COMPANY_NUM
   , P_JOIN_DATE
   , P_RETR_DATE
   , P_LONG_YYYY
   , P_LONG_MONTH
   , NVL(P_PAY_TOTAL_AMT, 0)
   , NVL(P_BONUS_TOTAL_AMT, 0)
   , NVL(P_ADD_BONUS_AMT, 0)
   , NVL(P_STOCK_BENE_AMT, 0)
   , NVL(P_ANNU_INSUR_AMT, 0)
   , NVL(P_MEDIC_INSUR_AMT, 0)
   , NVL(P_HIRE_INSUR_AMT, 0)
   , NVL(P_IN_TAX_AMT, 0)
   , NVL(P_LOCAL_TAX_AMT, 0)
   , NVL(P_SP_TAX_AMT, 0)
   , V_SYSDATE
   , P_USER_ID
   , V_SYSDATE
   , P_USER_ID
   , NVL(P_NT_FOREIGNER_AMT, 0)
   , NVL(P_NT_BIRTH_AMT, 0)
   , NVL(P_NT_OT_AMT, 0)
   , NVL(P_NT_OUTSIDE_AMT, 0)
   , NVL(P_NT_CHILD_AMT, 0)  --����/���ߵ� ����������.
   , NVL(P_NT_RESEARCH_AMT, 0) --������� ����������.
   , NVL(P_NT_COMPANY_AMT, 0)  --��� ����������.
   , NVL(P_NT_DISASTER_AMT, 0)  -- ���غ�.
   );

  END INSERT_PLACE_SEQ_ONE;

-----------------------------------------------------------------------------------------
-- �� 1 �����ٹ��� UPDATE.
-----------------------------------------------------------------------------------------
  PROCEDURE UPDATE_PLACE_SEQ_ONE
           ( W_YEAR_YYYY            IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
           , W_SOB_ID               IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
           , W_ORG_ID               IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
           , W_PERSON_ID            IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
           , W_SEQ_NUM              IN HRA_PREVIOUS_WORK.SEQ_NUM%TYPE
           , P_COMPANY_NAME         IN HRA_PREVIOUS_WORK.COMPANY_NAME%TYPE
           , P_COMPANY_NUM          IN HRA_PREVIOUS_WORK.COMPANY_NUM%TYPE
           , P_JOIN_DATE            IN HRA_PREVIOUS_WORK.JOIN_DATE%TYPE
           , P_RETR_DATE            IN HRA_PREVIOUS_WORK.RETR_DATE%TYPE
           , P_LONG_YYYY            IN HRA_PREVIOUS_WORK.LONG_YYYY%TYPE
           , P_LONG_MONTH           IN HRA_PREVIOUS_WORK.LONG_MONTH%TYPE
           , P_PAY_TOTAL_AMT        IN HRA_PREVIOUS_WORK.PAY_TOTAL_AMT%TYPE
           , P_BONUS_TOTAL_AMT      IN HRA_PREVIOUS_WORK.BONUS_TOTAL_AMT%TYPE
           , P_ADD_BONUS_AMT        IN HRA_PREVIOUS_WORK.ADD_BONUS_AMT%TYPE
           , P_STOCK_BENE_AMT       IN HRA_PREVIOUS_WORK.STOCK_BENE_AMT%TYPE
           , P_ANNU_INSUR_AMT       IN HRA_PREVIOUS_WORK.ANNU_INSUR_AMT%TYPE
           , P_MEDIC_INSUR_AMT      IN HRA_PREVIOUS_WORK.MEDIC_INSUR_AMT%TYPE
           , P_HIRE_INSUR_AMT       IN HRA_PREVIOUS_WORK.HIRE_INSUR_AMT%TYPE
           , P_IN_TAX_AMT           IN HRA_PREVIOUS_WORK.IN_TAX_AMT%TYPE
           , P_LOCAL_TAX_AMT        IN HRA_PREVIOUS_WORK.LOCAL_TAX_AMT%TYPE
           , P_SP_TAX_AMT           IN HRA_PREVIOUS_WORK.SP_TAX_AMT%TYPE           
           , P_USER_ID              IN HRA_PREVIOUS_WORK.CREATED_BY%TYPE           
           , P_NT_FOREIGNER_AMT     IN HRA_PREVIOUS_WORK.NT_FOREIGNER_AMT%TYPE
           , P_NT_BIRTH_AMT         IN HRA_PREVIOUS_WORK.NT_BIRTH_AMT%TYPE
           , P_NT_OT_AMT            IN HRA_PREVIOUS_WORK.NT_OT_AMT%TYPE
           , P_NT_OUTSIDE_AMT       IN HRA_PREVIOUS_WORK.NT_OUTSIDE_AMT%TYPE
           , P_NT_CHILD_AMT         IN HRA_PREVIOUS_WORK.NT_CHILD_AMT%TYPE  --����/���ߵ� ����������.
           , P_NT_RESEARCH_AMT      IN HRA_PREVIOUS_WORK.NT_RESEARCH_AMT%TYPE  --������� ����������.
           , P_NT_COMPANY_AMT       IN HRA_PREVIOUS_WORK.NT_COMPANY_AMT%TYPE  --��� ����������.
           , P_NT_DISASTER_AMT      IN HRA_PREVIOUS_WORK.NT_DISASTER_AMT%TYPE  --���ذ��ú�.
           )
  IS
       V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN

   UPDATE HRA_PREVIOUS_WORK
      SET COMPANY_NAME         = P_COMPANY_NAME
        , COMPANY_NUM          = P_COMPANY_NUM
        , JOIN_DATE            = P_JOIN_DATE
        , RETR_DATE            = P_RETR_DATE
        , LONG_YYYY            = P_LONG_YYYY
        , LONG_MONTH           = P_LONG_MONTH
        , PAY_TOTAL_AMT        = NVL(P_PAY_TOTAL_AMT, 0)
        , BONUS_TOTAL_AMT      = NVL(P_BONUS_TOTAL_AMT, 0)
        , ADD_BONUS_AMT        = NVL(P_ADD_BONUS_AMT, 0)
        , STOCK_BENE_AMT       = NVL(P_STOCK_BENE_AMT, 0)
        , ANNU_INSUR_AMT       = NVL(P_ANNU_INSUR_AMT, 0)
        , MEDIC_INSUR_AMT      = NVL(P_MEDIC_INSUR_AMT, 0)
        , HIRE_INSUR_AMT       = NVL(P_HIRE_INSUR_AMT, 0)
        , IN_TAX_AMT           = NVL(P_IN_TAX_AMT, 0)
        , LOCAL_TAX_AMT        = NVL(P_LOCAL_TAX_AMT, 0)
        , SP_TAX_AMT           = NVL(P_SP_TAX_AMT, 0)        
        , LAST_UPDATE_DATE     = V_SYSDATE
        , LAST_UPDATED_BY      = P_USER_ID        
        , NT_FOREIGNER_AMT     = NVL(P_NT_FOREIGNER_AMT, 0)
        , NT_BIRTH_AMT         = NVL(P_NT_BIRTH_AMT, 0)
        , NT_OT_AMT            = NVL(P_NT_OT_AMT, 0)
        , NT_OUTSIDE_AMT       = NVL(P_NT_OUTSIDE_AMT, 0)
        , NT_CHILD_AMT         = NVL(P_NT_CHILD_AMT, 0)
        , NT_RESEARCH_AMT      = NVL(P_NT_RESEARCH_AMT, 0)
        , NT_COMPANY_AMT       = NVL(P_NT_COMPANY_AMT, 0)
        , NT_DISASTER_AMT      = NVL(P_NT_DISASTER_AMT, 0)
    WHERE YEAR_YYYY      =    W_YEAR_YYYY
      AND SOB_ID         =    W_SOB_ID
      AND ORG_ID         =    W_ORG_ID 
      AND PERSON_ID      =    W_PERSON_ID
      AND SEQ_NUM        =    W_SEQ_NUM
  ;

  EXCEPTION WHEN OTHERS THEN
   BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'Error Message');
   END;

  END UPDATE_PLACE_SEQ_ONE;  

----------------------------------------------------------------------------------------- 
-- �� 1 �����ٹ��� DELETE.        
-----------------------------------------------------------------------------------------
  PROCEDURE DELETE_PLACE_SEQ_ONE
           ( W_YEAR_YYYY  HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
           , W_SOB_ID  HRA_PREVIOUS_WORK.SOB_ID%TYPE
           , W_ORG_ID  HRA_PREVIOUS_WORK.ORG_ID%TYPE
           , W_PERSON_ID  HRA_PREVIOUS_WORK.PERSON_ID%TYPE
           , W_SEQ_NUM  HRA_PREVIOUS_WORK.SEQ_NUM%TYPE )
  IS

  BEGIN

   DELETE HRA_PREVIOUS_WORK
    WHERE YEAR_YYYY = W_YEAR_YYYY
      AND SOB_ID = W_SOB_ID
      AND ORG_ID = W_ORG_ID
      AND PERSON_ID = W_PERSON_ID
      AND SEQ_NUM = W_SEQ_NUM;   

  EXCEPTION WHEN OTHERS THEN
   BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'Error Message');
   END;

  END DELETE_PLACE_SEQ_ONE;
           
-----------------------------------------------------------------------------------------
-- �� 2 �����ٹ��� SELECT.
-----------------------------------------------------------------------------------------
  PROCEDURE SELECT_PLACE_SEQ_TWO
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
            , P_PERSON_ID         IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
            , P_SEQ_NUM           IN HRA_PREVIOUS_WORK.SEQ_NUM%TYPE
            , P_SOB_ID            IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
            )
  AS 
  BEGIN
    OPEN P_CURSOR FOR
      SELECT   PW.SEQ_NUM         --���ٹ��� �Ϸù�ȣ.
             , PW.COMPANY_NAME    --��ü��.
             , PW.COMPANY_NUM     --����ڹ�ȣ.
             , PW.JOIN_DATE       --�Ի�����.
             , PW.RETR_DATE       --�������.
             , PW.LONG_YYYY       --�ټӳ��.
             , PW.LONG_MONTH      --�ټӿ���.
             , PW.PAY_TOTAL_AMT   --�ѱ޿���.
             , PW.BONUS_TOTAL_AMT --�ѻ󿩾�.
             , PW.ADD_BONUS_AMT   --�����󿩾�.
             , PW.STOCK_BENE_AMT  --�ֽĸż����ñ�����.
             , PW.NT_OUTSIDE_AMT  --���ܱٷμҵ�.
             , PW.NT_OT_AMT       --�߰��ٷμ���.
             , PW.NT_BIRTH_AMT    --��꺸������.
             , PW.NT_FOREIGNER_AMT--�ܱ��αٷ���.
             , PW.NT_CHILD_AMT    --����/���ߵ� ����������.
             , PW.NT_RESEARCH_AMT --������� ����������.
             , PW.NT_COMPANY_AMT  --��� ����������.
             , PW.NT_DISASTER_AMT --���ذ��ú�.
             , PW.MEDIC_INSUR_AMT --�ǰ�����.
             , PW.HIRE_INSUR_AMT  --��뺸��.
             , PW.ANNU_INSUR_AMT  --���ο���.
             , PW.IN_TAX_AMT      --�ҵ漼.
             , PW.LOCAL_TAX_AMT   --�ֹμ�.
             , PW.SP_TAX_AMT      --��Ư��.
      FROM HRA_PREVIOUS_WORK PW
     WHERE PW.YEAR_YYYY     =    P_YEAR_YYYY
       AND PW.PERSON_ID     =    P_PERSON_ID
       AND PW.SEQ_NUM       =    P_SEQ_NUM
       AND PW.SOB_ID        =    P_SOB_ID
       AND PW.ORG_ID        =    P_ORG_ID  
       ;
      
  END SELECT_PLACE_SEQ_TWO;

-----------------------------------------------------------------------------------------
-- �� 2 �����ٹ��� INSERT.
-----------------------------------------------------------------------------------------
  PROCEDURE INSERT_PLACE_SEQ_TWO
            ( P_YEAR_YYYY            IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
             , P_SOB_ID               IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
             , P_ORG_ID               IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
             , P_PERSON_ID            IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
             , P_SEQ_NUM              IN HRA_PREVIOUS_WORK.SEQ_NUM%TYPE
             , P_COMPANY_NAME         IN HRA_PREVIOUS_WORK.COMPANY_NAME%TYPE
             , P_COMPANY_NUM          IN HRA_PREVIOUS_WORK.COMPANY_NUM%TYPE
             , P_JOIN_DATE            IN HRA_PREVIOUS_WORK.JOIN_DATE%TYPE
             , P_RETR_DATE            IN HRA_PREVIOUS_WORK.RETR_DATE%TYPE
             , P_LONG_YYYY            IN HRA_PREVIOUS_WORK.LONG_YYYY%TYPE
             , P_LONG_MONTH           IN HRA_PREVIOUS_WORK.LONG_MONTH%TYPE
             , P_PAY_TOTAL_AMT        IN HRA_PREVIOUS_WORK.PAY_TOTAL_AMT%TYPE
             , P_BONUS_TOTAL_AMT      IN HRA_PREVIOUS_WORK.BONUS_TOTAL_AMT%TYPE
             , P_ADD_BONUS_AMT        IN HRA_PREVIOUS_WORK.ADD_BONUS_AMT%TYPE
             , P_STOCK_BENE_AMT       IN HRA_PREVIOUS_WORK.STOCK_BENE_AMT%TYPE
             , P_ANNU_INSUR_AMT       IN HRA_PREVIOUS_WORK.ANNU_INSUR_AMT%TYPE
             , P_MEDIC_INSUR_AMT      IN HRA_PREVIOUS_WORK.MEDIC_INSUR_AMT%TYPE
             , P_HIRE_INSUR_AMT       IN HRA_PREVIOUS_WORK.HIRE_INSUR_AMT%TYPE
             , P_IN_TAX_AMT           IN HRA_PREVIOUS_WORK.IN_TAX_AMT%TYPE
             , P_LOCAL_TAX_AMT        IN HRA_PREVIOUS_WORK.LOCAL_TAX_AMT%TYPE
             , P_SP_TAX_AMT           IN HRA_PREVIOUS_WORK.SP_TAX_AMT%TYPE
             , P_USER_ID              IN HRA_PREVIOUS_WORK.CREATED_BY%TYPE
             , P_NT_FOREIGNER_AMT     IN HRA_PREVIOUS_WORK.NT_FOREIGNER_AMT%TYPE
             , P_NT_BIRTH_AMT         IN HRA_PREVIOUS_WORK.NT_BIRTH_AMT%TYPE
             , P_NT_OT_AMT            IN HRA_PREVIOUS_WORK.NT_OT_AMT%TYPE
             , P_NT_OUTSIDE_AMT       IN HRA_PREVIOUS_WORK.NT_OUTSIDE_AMT%TYPE
             , P_NT_CHILD_AMT         IN HRA_PREVIOUS_WORK.NT_CHILD_AMT%TYPE  --����/���ߵ� ����������.
             , P_NT_RESEARCH_AMT      IN HRA_PREVIOUS_WORK.NT_RESEARCH_AMT%TYPE  --������� ����������.
             , P_NT_COMPANY_AMT       IN HRA_PREVIOUS_WORK.NT_COMPANY_AMT%TYPE  --��� ����������.
             , P_NT_DISASTER_AMT      IN HRA_PREVIOUS_WORK.NT_DISASTER_AMT%TYPE  --���ذ��ú�.
             )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN

  INSERT INTO HRA_PREVIOUS_WORK
  (  YEAR_YYYY
   , SOB_ID 
   , ORG_ID 
   , PERSON_ID 
   , SEQ_NUM 
   , COMPANY_NAME 
   , COMPANY_NUM 
   , JOIN_DATE 
   , RETR_DATE 
   , LONG_YYYY 
   , LONG_MONTH 
   , PAY_TOTAL_AMT 
   , BONUS_TOTAL_AMT 
   , ADD_BONUS_AMT 
   , STOCK_BENE_AMT 
   , ANNU_INSUR_AMT 
   , MEDIC_INSUR_AMT 
   , HIRE_INSUR_AMT 
   , IN_TAX_AMT 
   , LOCAL_TAX_AMT 
   , SP_TAX_AMT 
   , CREATION_DATE 
   , CREATED_BY 
   , LAST_UPDATE_DATE 
   , LAST_UPDATED_BY 
   , NT_FOREIGNER_AMT 
   , NT_BIRTH_AMT 
   , NT_OT_AMT 
   , NT_OUTSIDE_AMT
   , NT_CHILD_AMT  --����/���ߵ� ����������.
   , NT_RESEARCH_AMT --������� ����������.
   , NT_COMPANY_AMT  --��� ����������.
   , NT_DISASTER_AMT  -- ���غ�.
   ) VALUES 
   ( P_YEAR_YYYY
   , P_SOB_ID
   , P_ORG_ID
   , P_PERSON_ID
   , P_SEQ_NUM
   , P_COMPANY_NAME
   , P_COMPANY_NUM
   , P_JOIN_DATE
   , P_RETR_DATE
   , P_LONG_YYYY
   , P_LONG_MONTH
   , NVL(P_PAY_TOTAL_AMT, 0)
   , NVL(P_BONUS_TOTAL_AMT, 0)
   , NVL(P_ADD_BONUS_AMT, 0)
   , NVL(P_STOCK_BENE_AMT, 0)
   , NVL(P_ANNU_INSUR_AMT, 0)
   , NVL(P_MEDIC_INSUR_AMT, 0)
   , NVL(P_HIRE_INSUR_AMT, 0)
   , NVL(P_IN_TAX_AMT, 0)
   , NVL(P_LOCAL_TAX_AMT, 0)
   , NVL(P_SP_TAX_AMT, 0)
   , V_SYSDATE
   , P_USER_ID
   , V_SYSDATE
   , P_USER_ID
   , NVL(P_NT_FOREIGNER_AMT, 0)
   , NVL(P_NT_BIRTH_AMT, 0)
   , NVL(P_NT_OT_AMT, 0)
   , NVL(P_NT_OUTSIDE_AMT, 0)
   , NVL(P_NT_CHILD_AMT, 0)  --����/���ߵ� ����������.
   , NVL(P_NT_RESEARCH_AMT, 0) --������� ����������.
   , NVL(P_NT_COMPANY_AMT, 0)  --��� ����������.
   , NVL(P_NT_DISASTER_AMT, 0)  -- ���غ�.   
    );
    
  END INSERT_PLACE_SEQ_TWO;

-----------------------------------------------------------------------------------------
-- �� 2 �����ٹ��� UPDATE.
-----------------------------------------------------------------------------------------
  PROCEDURE UPDATE_PLACE_SEQ_TWO
           ( W_YEAR_YYYY            IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
           , W_SOB_ID               IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
           , W_ORG_ID               IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
           , W_PERSON_ID            IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
           , W_SEQ_NUM              IN HRA_PREVIOUS_WORK.SEQ_NUM%TYPE
           , P_COMPANY_NAME         IN HRA_PREVIOUS_WORK.COMPANY_NAME%TYPE
           , P_COMPANY_NUM          IN HRA_PREVIOUS_WORK.COMPANY_NUM%TYPE
           , P_JOIN_DATE            IN HRA_PREVIOUS_WORK.JOIN_DATE%TYPE
           , P_RETR_DATE            IN HRA_PREVIOUS_WORK.RETR_DATE%TYPE
           , P_LONG_YYYY            IN HRA_PREVIOUS_WORK.LONG_YYYY%TYPE
           , P_LONG_MONTH           IN HRA_PREVIOUS_WORK.LONG_MONTH%TYPE
           , P_PAY_TOTAL_AMT        IN HRA_PREVIOUS_WORK.PAY_TOTAL_AMT%TYPE
           , P_BONUS_TOTAL_AMT      IN HRA_PREVIOUS_WORK.BONUS_TOTAL_AMT%TYPE
           , P_ADD_BONUS_AMT        IN HRA_PREVIOUS_WORK.ADD_BONUS_AMT%TYPE
           , P_STOCK_BENE_AMT       IN HRA_PREVIOUS_WORK.STOCK_BENE_AMT%TYPE
           , P_ANNU_INSUR_AMT       IN HRA_PREVIOUS_WORK.ANNU_INSUR_AMT%TYPE
           , P_MEDIC_INSUR_AMT      IN HRA_PREVIOUS_WORK.MEDIC_INSUR_AMT%TYPE
           , P_HIRE_INSUR_AMT       IN HRA_PREVIOUS_WORK.HIRE_INSUR_AMT%TYPE
           , P_IN_TAX_AMT           IN HRA_PREVIOUS_WORK.IN_TAX_AMT%TYPE
           , P_LOCAL_TAX_AMT        IN HRA_PREVIOUS_WORK.LOCAL_TAX_AMT%TYPE
           , P_SP_TAX_AMT           IN HRA_PREVIOUS_WORK.SP_TAX_AMT%TYPE           
           , P_USER_ID              IN HRA_PREVIOUS_WORK.CREATED_BY%TYPE           
           , P_NT_FOREIGNER_AMT     IN HRA_PREVIOUS_WORK.NT_FOREIGNER_AMT%TYPE
           , P_NT_BIRTH_AMT         IN HRA_PREVIOUS_WORK.NT_BIRTH_AMT%TYPE
           , P_NT_OT_AMT            IN HRA_PREVIOUS_WORK.NT_OT_AMT%TYPE
           , P_NT_OUTSIDE_AMT       IN HRA_PREVIOUS_WORK.NT_OUTSIDE_AMT%TYPE
           , P_NT_CHILD_AMT         IN HRA_PREVIOUS_WORK.NT_CHILD_AMT%TYPE  --����/���ߵ� ����������.
           , P_NT_RESEARCH_AMT      IN HRA_PREVIOUS_WORK.NT_RESEARCH_AMT%TYPE  --������� ����������.
           , P_NT_COMPANY_AMT       IN HRA_PREVIOUS_WORK.NT_COMPANY_AMT%TYPE  --��� ����������.
           , P_NT_DISASTER_AMT      IN HRA_PREVIOUS_WORK.NT_DISASTER_AMT%TYPE  --���ذ��ú�.
           )
  IS
       V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN

   UPDATE HRA_PREVIOUS_WORK
      SET COMPANY_NAME         = P_COMPANY_NAME
        , COMPANY_NUM          = P_COMPANY_NUM
        , JOIN_DATE            = P_JOIN_DATE
        , RETR_DATE            = P_RETR_DATE
        , LONG_YYYY            = P_LONG_YYYY
        , LONG_MONTH           = P_LONG_MONTH
        , PAY_TOTAL_AMT        = NVL(P_PAY_TOTAL_AMT, 0)
        , BONUS_TOTAL_AMT      = NVL(P_BONUS_TOTAL_AMT, 0)
        , ADD_BONUS_AMT        = NVL(P_ADD_BONUS_AMT, 0)
        , STOCK_BENE_AMT       = NVL(P_STOCK_BENE_AMT, 0)
        , ANNU_INSUR_AMT       = NVL(P_ANNU_INSUR_AMT, 0)
        , MEDIC_INSUR_AMT      = NVL(P_MEDIC_INSUR_AMT, 0)
        , HIRE_INSUR_AMT       = NVL(P_HIRE_INSUR_AMT, 0)
        , IN_TAX_AMT           = NVL(P_IN_TAX_AMT, 0)
        , LOCAL_TAX_AMT        = NVL(P_LOCAL_TAX_AMT, 0)
        , SP_TAX_AMT           = NVL(P_SP_TAX_AMT, 0)        
        , LAST_UPDATE_DATE     = V_SYSDATE
        , LAST_UPDATED_BY      = P_USER_ID        
        , NT_FOREIGNER_AMT     = NVL(P_NT_FOREIGNER_AMT, 0)
        , NT_BIRTH_AMT         = NVL(P_NT_BIRTH_AMT, 0)
        , NT_OT_AMT            = NVL(P_NT_OT_AMT, 0)
        , NT_OUTSIDE_AMT       = NVL(P_NT_OUTSIDE_AMT, 0)
        , NT_CHILD_AMT         = NVL(P_NT_CHILD_AMT, 0)
        , NT_RESEARCH_AMT      = NVL(P_NT_RESEARCH_AMT, 0)
        , NT_COMPANY_AMT       = NVL(P_NT_COMPANY_AMT, 0)
        , NT_DISASTER_AMT      = NVL(P_NT_DISASTER_AMT, 0)
    WHERE YEAR_YYYY      =    W_YEAR_YYYY
      AND SOB_ID         =    W_SOB_ID
      AND ORG_ID         =    W_ORG_ID 
      AND PERSON_ID      =    W_PERSON_ID
      AND SEQ_NUM        =    W_SEQ_NUM
  ;

  EXCEPTION WHEN OTHERS THEN
   BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'Error Message');
   END;

  END UPDATE_PLACE_SEQ_TWO; 

-----------------------------------------------------------------------------------------
-- �� 2 �����ٹ��� DELETE.        
-----------------------------------------------------------------------------------------
  PROCEDURE DELETE_PLACE_SEQ_TWO
          ( W_YEAR_YYYY  HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
          , W_SOB_ID  HRA_PREVIOUS_WORK.SOB_ID%TYPE
          , W_ORG_ID  HRA_PREVIOUS_WORK.ORG_ID%TYPE
          , W_PERSON_ID  HRA_PREVIOUS_WORK.PERSON_ID%TYPE
          , W_SEQ_NUM  HRA_PREVIOUS_WORK.SEQ_NUM%TYPE )
  IS

  BEGIN

   DELETE HRA_PREVIOUS_WORK
    WHERE YEAR_YYYY = W_YEAR_YYYY
      AND SOB_ID = W_SOB_ID
      AND ORG_ID = W_ORG_ID
      AND PERSON_ID = W_PERSON_ID
      AND SEQ_NUM = W_SEQ_NUM;   

  EXCEPTION WHEN OTHERS THEN
   BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'Error Message');
   END;

  END DELETE_PLACE_SEQ_TWO;

-----------------------------------------------------------------------------------------
-- �����ٹ��� ���� ��ȸ
-----------------------------------------------------------------------------------------
  PROCEDURE SELECT_PREVIOUST_WORK
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
            , P_PERSON_ID         IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
            , P_SOB_ID            IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
            )
  AS 
  BEGIN
    OPEN P_CURSOR FOR
      SELECT   PW.SEQ_NUM         --���ٹ��� �Ϸù�ȣ.
             , PW.COMPANY_NAME    --��ü��.
             , PW.COMPANY_NUM     --����ڹ�ȣ.
             , PW.JOIN_DATE       --�Ի�����.
             , PW.RETR_DATE       --�������.
             , PW.LONG_YYYY       --�ټӳ��.
             , PW.LONG_MONTH      --�ټӿ���.
             , PW.PAY_TOTAL_AMT   --�ѱ޿���.
             , PW.BONUS_TOTAL_AMT --�ѻ󿩾�.
             , PW.ADD_BONUS_AMT   --�����󿩾�.
             , PW.STOCK_BENE_AMT  --�ֽĸż����ñ�����.
             , PW.NT_OUTSIDE_AMT  --���ܱٷμҵ�.
             , PW.NT_OT_AMT       --�߰��ٷμ���.
             , PW.NT_BIRTH_AMT    --��꺸������.
             , PW.NT_FOREIGNER_AMT--�ܱ��αٷ���.
             , PW.NT_CHILD_AMT    --����/���ߵ� ����������.
             , PW.NT_RESEARCH_AMT --������� ����������.
             , PW.NT_COMPANY_AMT  --��� ����������.
             , PW.NT_DISASTER_AMT --���ذ��ú�.
             , PW.OFFICERS_RETIRE_OVER_AMT -- 2013-�ӿ������ҵ�ݾ� �ѵ��ʰ���
             , PW.RD_SMALL_BUSINESS_AMT    -- �߼ұ���� ����ϴ� û�⿡ ���� �ҵ漼 ����ݾ�
             , PW.MEDIC_INSUR_AMT --�ǰ�����.
             , PW.HIRE_INSUR_AMT  --��뺸��.
             , PW.ANNU_INSUR_AMT  --���ο���.
             , PW.IN_TAX_AMT      --�ҵ漼.
             , PW.LOCAL_TAX_AMT   --�ֹμ�.
             , PW.SP_TAX_AMT      --��Ư��.
             , PW.PERSON_ID
      FROM HRA_PREVIOUS_WORK PW
     WHERE PW.YEAR_YYYY     =    P_YEAR_YYYY
       AND PW.PERSON_ID     =    P_PERSON_ID
       AND PW.SOB_ID        =    P_SOB_ID
       AND PW.ORG_ID        =    P_ORG_ID    
  ORDER BY PW.SEQ_NUM
       ;
      
  END SELECT_PREVIOUST_WORK;
 
-----------------------------------------------------------------------------------------
-- �� 1 �����ٹ��� INSERT.
-----------------------------------------------------------------------------------------
  PROCEDURE INSERT_PREVIOUST_WORK
            ( P_YEAR_YYYY                  IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
             , P_SOB_ID                    IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
             , P_ORG_ID                    IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
             , P_PERSON_ID                 IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
             , P_SEQ_NUM                   IN HRA_PREVIOUS_WORK.SEQ_NUM%TYPE
             , P_COMPANY_NAME              IN HRA_PREVIOUS_WORK.COMPANY_NAME%TYPE
             , P_COMPANY_NUM               IN HRA_PREVIOUS_WORK.COMPANY_NUM%TYPE
             , P_JOIN_DATE                 IN HRA_PREVIOUS_WORK.JOIN_DATE%TYPE
             , P_RETR_DATE                 IN HRA_PREVIOUS_WORK.RETR_DATE%TYPE
             , P_LONG_YYYY                 IN HRA_PREVIOUS_WORK.LONG_YYYY%TYPE
             , P_LONG_MONTH                IN HRA_PREVIOUS_WORK.LONG_MONTH%TYPE
             , P_PAY_TOTAL_AMT             IN HRA_PREVIOUS_WORK.PAY_TOTAL_AMT%TYPE
             , P_BONUS_TOTAL_AMT           IN HRA_PREVIOUS_WORK.BONUS_TOTAL_AMT%TYPE
             , P_ADD_BONUS_AMT             IN HRA_PREVIOUS_WORK.ADD_BONUS_AMT%TYPE
             , P_STOCK_BENE_AMT            IN HRA_PREVIOUS_WORK.STOCK_BENE_AMT%TYPE
             , P_ANNU_INSUR_AMT            IN HRA_PREVIOUS_WORK.ANNU_INSUR_AMT%TYPE
             , P_MEDIC_INSUR_AMT           IN HRA_PREVIOUS_WORK.MEDIC_INSUR_AMT%TYPE
             , P_HIRE_INSUR_AMT            IN HRA_PREVIOUS_WORK.HIRE_INSUR_AMT%TYPE
             , P_IN_TAX_AMT                IN HRA_PREVIOUS_WORK.IN_TAX_AMT%TYPE
             , P_LOCAL_TAX_AMT             IN HRA_PREVIOUS_WORK.LOCAL_TAX_AMT%TYPE
             , P_SP_TAX_AMT                IN HRA_PREVIOUS_WORK.SP_TAX_AMT%TYPE
             , P_USER_ID                   IN HRA_PREVIOUS_WORK.CREATED_BY%TYPE
             , P_NT_FOREIGNER_AMT          IN HRA_PREVIOUS_WORK.NT_FOREIGNER_AMT%TYPE
             , P_NT_BIRTH_AMT              IN HRA_PREVIOUS_WORK.NT_BIRTH_AMT%TYPE
             , P_NT_OT_AMT                 IN HRA_PREVIOUS_WORK.NT_OT_AMT%TYPE
             , P_NT_OUTSIDE_AMT            IN HRA_PREVIOUS_WORK.NT_OUTSIDE_AMT%TYPE
             , P_NT_CHILD_AMT              IN HRA_PREVIOUS_WORK.NT_CHILD_AMT%TYPE             --����/���ߵ� ����������.
             , P_NT_RESEARCH_AMT           IN HRA_PREVIOUS_WORK.NT_RESEARCH_AMT%TYPE          --������� ����������.
             , P_NT_COMPANY_AMT            IN HRA_PREVIOUS_WORK.NT_COMPANY_AMT%TYPE           --��� ����������.
             , P_NT_DISASTER_AMT           IN HRA_PREVIOUS_WORK.NT_DISASTER_AMT%TYPE          --���ذ��ú�.
             , P_OFFICERS_RETIRE_OVER_AMT  IN HRA_PREVIOUS_WORK.OFFICERS_RETIRE_OVER_AMT%TYPE -- 2013-�ӿ������ҵ�ݾ� �ѵ��ʰ���
             , P_RD_SMALL_BUSINESS_AMT     IN HRA_PREVIOUS_WORK.RD_SMALL_BUSINESS_AMT%TYPE    -- �߼ұ���� ����ϴ� û�⿡ ���� �ҵ漼 ����ݾ�
             )
  AS
    V_SYSDATE                         DATE := GET_LOCAL_DATE(P_SOB_ID);
   
  BEGIN
   
  INSERT INTO HRA_PREVIOUS_WORK
  (  YEAR_YYYY
   , SOB_ID 
   , ORG_ID 
   , PERSON_ID 
   , SEQ_NUM 
   , COMPANY_NAME 
   , COMPANY_NUM 
   , JOIN_DATE 
   , RETR_DATE 
   , LONG_YYYY 
   , LONG_MONTH 
   , PAY_TOTAL_AMT 
   , BONUS_TOTAL_AMT 
   , ADD_BONUS_AMT 
   , STOCK_BENE_AMT 
   , ANNU_INSUR_AMT 
   , MEDIC_INSUR_AMT 
   , HIRE_INSUR_AMT 
   , IN_TAX_AMT 
   , LOCAL_TAX_AMT 
   , SP_TAX_AMT 
   , CREATION_DATE 
   , CREATED_BY 
   , LAST_UPDATE_DATE 
   , LAST_UPDATED_BY 
   , NT_FOREIGNER_AMT 
   , NT_BIRTH_AMT 
   , NT_OT_AMT 
   , NT_OUTSIDE_AMT
   , NT_CHILD_AMT                          --����/���ߵ� ����������.
   , NT_RESEARCH_AMT                       --������� ����������.
   , NT_COMPANY_AMT                        --��� ����������.
   , NT_DISASTER_AMT                       -- ���غ�.
   , OFFICERS_RETIRE_OVER_AMT              -- 2013-�ӿ������ҵ�ݾ� �ѵ��ʰ���
   , RD_SMALL_BUSINESS_AMT                 -- �߼ұ���� ����ϴ� û�⿡ ���� �ҵ漼 ����ݾ�
   ) VALUES 
   ( P_YEAR_YYYY
   , P_SOB_ID
   , P_ORG_ID
   , P_PERSON_ID
   , P_SEQ_NUM
   , P_COMPANY_NAME
   , P_COMPANY_NUM
   , P_JOIN_DATE
   , P_RETR_DATE
   , P_LONG_YYYY
   , P_LONG_MONTH
   , NVL(P_PAY_TOTAL_AMT, 0)
   , NVL(P_BONUS_TOTAL_AMT, 0)
   , NVL(P_ADD_BONUS_AMT, 0)
   , NVL(P_STOCK_BENE_AMT, 0)
   , NVL(P_ANNU_INSUR_AMT, 0)
   , NVL(P_MEDIC_INSUR_AMT, 0)
   , NVL(P_HIRE_INSUR_AMT, 0)
   , NVL(P_IN_TAX_AMT, 0)
   , NVL(P_LOCAL_TAX_AMT, 0)
   , NVL(P_SP_TAX_AMT, 0)
   , V_SYSDATE
   , P_USER_ID
   , V_SYSDATE
   , P_USER_ID
   , NVL(P_NT_FOREIGNER_AMT, 0)
   , NVL(P_NT_BIRTH_AMT, 0)
   , NVL(P_NT_OT_AMT, 0)
   , NVL(P_NT_OUTSIDE_AMT, 0)
   , NVL(P_NT_CHILD_AMT, 0)  --����/���ߵ� ����������.
   , NVL(P_NT_RESEARCH_AMT, 0) --������� ����������.
   , NVL(P_NT_COMPANY_AMT, 0)  --��� ����������.
   , NVL(P_NT_DISASTER_AMT, 0)  -- ���غ�.
   , NVL(P_OFFICERS_RETIRE_OVER_AMT, 0)
   , NVL(P_RD_SMALL_BUSINESS_AMT, 0)
   );

  END INSERT_PREVIOUST_WORK;

-----------------------------------------------------------------------------------------
-- �� 1 �����ٹ��� UPDATE.
-----------------------------------------------------------------------------------------
  PROCEDURE UPDATE_PREVIOUST_WORK
           ( W_YEAR_YYYY                 IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
           , W_SOB_ID                    IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
           , W_ORG_ID                    IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
           , W_PERSON_ID                 IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
           , W_SEQ_NUM                   IN HRA_PREVIOUS_WORK.SEQ_NUM%TYPE
           , P_COMPANY_NAME              IN HRA_PREVIOUS_WORK.COMPANY_NAME%TYPE
           , P_COMPANY_NUM               IN HRA_PREVIOUS_WORK.COMPANY_NUM%TYPE
           , P_JOIN_DATE                 IN HRA_PREVIOUS_WORK.JOIN_DATE%TYPE
           , P_RETR_DATE                 IN HRA_PREVIOUS_WORK.RETR_DATE%TYPE
           , P_LONG_YYYY                 IN HRA_PREVIOUS_WORK.LONG_YYYY%TYPE
           , P_LONG_MONTH                IN HRA_PREVIOUS_WORK.LONG_MONTH%TYPE
           , P_PAY_TOTAL_AMT             IN HRA_PREVIOUS_WORK.PAY_TOTAL_AMT%TYPE
           , P_BONUS_TOTAL_AMT           IN HRA_PREVIOUS_WORK.BONUS_TOTAL_AMT%TYPE
           , P_ADD_BONUS_AMT             IN HRA_PREVIOUS_WORK.ADD_BONUS_AMT%TYPE
           , P_STOCK_BENE_AMT            IN HRA_PREVIOUS_WORK.STOCK_BENE_AMT%TYPE
           , P_ANNU_INSUR_AMT            IN HRA_PREVIOUS_WORK.ANNU_INSUR_AMT%TYPE
           , P_MEDIC_INSUR_AMT           IN HRA_PREVIOUS_WORK.MEDIC_INSUR_AMT%TYPE
           , P_HIRE_INSUR_AMT            IN HRA_PREVIOUS_WORK.HIRE_INSUR_AMT%TYPE
           , P_IN_TAX_AMT                IN HRA_PREVIOUS_WORK.IN_TAX_AMT%TYPE
           , P_LOCAL_TAX_AMT             IN HRA_PREVIOUS_WORK.LOCAL_TAX_AMT%TYPE
           , P_SP_TAX_AMT                IN HRA_PREVIOUS_WORK.SP_TAX_AMT%TYPE           
           , P_USER_ID                   IN HRA_PREVIOUS_WORK.CREATED_BY%TYPE           
           , P_NT_FOREIGNER_AMT          IN HRA_PREVIOUS_WORK.NT_FOREIGNER_AMT%TYPE
           , P_NT_BIRTH_AMT              IN HRA_PREVIOUS_WORK.NT_BIRTH_AMT%TYPE
           , P_NT_OT_AMT                 IN HRA_PREVIOUS_WORK.NT_OT_AMT%TYPE
           , P_NT_OUTSIDE_AMT            IN HRA_PREVIOUS_WORK.NT_OUTSIDE_AMT%TYPE
           , P_NT_CHILD_AMT              IN HRA_PREVIOUS_WORK.NT_CHILD_AMT%TYPE  --����/���ߵ� ����������.
           , P_NT_RESEARCH_AMT           IN HRA_PREVIOUS_WORK.NT_RESEARCH_AMT%TYPE  --������� ����������.
           , P_NT_COMPANY_AMT            IN HRA_PREVIOUS_WORK.NT_COMPANY_AMT%TYPE  --��� ����������.
           , P_NT_DISASTER_AMT           IN HRA_PREVIOUS_WORK.NT_DISASTER_AMT%TYPE  --���ذ��ú�.
           , P_OFFICERS_RETIRE_OVER_AMT  IN HRA_PREVIOUS_WORK.OFFICERS_RETIRE_OVER_AMT%TYPE -- 2013-�ӿ������ҵ�ݾ� �ѵ��ʰ���
           , P_RD_SMALL_BUSINESS_AMT     IN HRA_PREVIOUS_WORK.RD_SMALL_BUSINESS_AMT%TYPE    -- �߼ұ���� ����ϴ� û�⿡ ���� �ҵ漼 ����ݾ�
           )
  IS
       V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN

   UPDATE HRA_PREVIOUS_WORK
      SET COMPANY_NAME               = P_COMPANY_NAME
        , COMPANY_NUM                = P_COMPANY_NUM
        , JOIN_DATE                  = P_JOIN_DATE
        , RETR_DATE                  = P_RETR_DATE
        , LONG_YYYY                  = P_LONG_YYYY
        , LONG_MONTH                 = P_LONG_MONTH
        , PAY_TOTAL_AMT              = NVL(P_PAY_TOTAL_AMT, 0)
        , BONUS_TOTAL_AMT            = NVL(P_BONUS_TOTAL_AMT, 0)
        , ADD_BONUS_AMT              = NVL(P_ADD_BONUS_AMT, 0)
        , STOCK_BENE_AMT             = NVL(P_STOCK_BENE_AMT, 0)
        , ANNU_INSUR_AMT             = NVL(P_ANNU_INSUR_AMT, 0)
        , MEDIC_INSUR_AMT            = NVL(P_MEDIC_INSUR_AMT, 0)
        , HIRE_INSUR_AMT             = NVL(P_HIRE_INSUR_AMT, 0)
        , IN_TAX_AMT                 = NVL(P_IN_TAX_AMT, 0)
        , LOCAL_TAX_AMT              = NVL(P_LOCAL_TAX_AMT, 0)
        , SP_TAX_AMT                 = NVL(P_SP_TAX_AMT, 0)        
        , LAST_UPDATE_DATE           = V_SYSDATE
        , LAST_UPDATED_BY            = P_USER_ID        
        , NT_FOREIGNER_AMT           = NVL(P_NT_FOREIGNER_AMT, 0)
        , NT_BIRTH_AMT               = NVL(P_NT_BIRTH_AMT, 0)
        , NT_OT_AMT                  = NVL(P_NT_OT_AMT, 0)
        , NT_OUTSIDE_AMT             = NVL(P_NT_OUTSIDE_AMT, 0)
        , NT_CHILD_AMT               = NVL(P_NT_CHILD_AMT, 0)
        , NT_RESEARCH_AMT            = NVL(P_NT_RESEARCH_AMT, 0)
        , NT_COMPANY_AMT             = NVL(P_NT_COMPANY_AMT, 0)
        , NT_DISASTER_AMT            = NVL(P_NT_DISASTER_AMT, 0)
        , OFFICERS_RETIRE_OVER_AMT   = NVL(P_OFFICERS_RETIRE_OVER_AMT, 0)
        , RD_SMALL_BUSINESS_AMT      = NVL(P_RD_SMALL_BUSINESS_AMT, 0)
    WHERE YEAR_YYYY      =    W_YEAR_YYYY
      AND SOB_ID         =    W_SOB_ID
      AND ORG_ID         =    W_ORG_ID 
      AND PERSON_ID      =    W_PERSON_ID
      AND SEQ_NUM        =    W_SEQ_NUM
  ;

  EXCEPTION WHEN OTHERS THEN
   BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'Error Message');
   END;

  END UPDATE_PREVIOUST_WORK;  

----------------------------------------------------------------------------------------- 
-- �� 1 �����ٹ��� DELETE.        
-----------------------------------------------------------------------------------------
  PROCEDURE DELETE_PREVIOUST_WORK
           ( W_YEAR_YYYY  HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
           , W_SOB_ID  HRA_PREVIOUS_WORK.SOB_ID%TYPE
           , W_ORG_ID  HRA_PREVIOUS_WORK.ORG_ID%TYPE
           , W_PERSON_ID  HRA_PREVIOUS_WORK.PERSON_ID%TYPE
           , W_SEQ_NUM  HRA_PREVIOUS_WORK.SEQ_NUM%TYPE )
  IS

  BEGIN

   DELETE HRA_PREVIOUS_WORK
    WHERE YEAR_YYYY = W_YEAR_YYYY
      AND SOB_ID = W_SOB_ID
      AND ORG_ID = W_ORG_ID
      AND PERSON_ID = W_PERSON_ID
      AND SEQ_NUM = W_SEQ_NUM;   

  EXCEPTION WHEN OTHERS THEN
   BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'Error Message');
   END;

  END DELETE_PREVIOUST_WORK;

-----------------------------------------------------------------------------------------
--  ������ �ѹ� ������.
-----------------------------------------------------------------------------------------
  PROCEDURE GET_SEQ_NUMBER
            ( O_SEQ_NUMBER        OUT HRA_PREVIOUS_WORK.SEQ_NUM%TYPE
            , P_SOB_ID            IN HRA_PREVIOUS_WORK.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_PREVIOUS_WORK.ORG_ID%TYPE
            , P_YEAR_YYYY         IN HRA_PREVIOUS_WORK.YEAR_YYYY%TYPE
            , P_PERSON_ID         IN HRA_PREVIOUS_WORK.PERSON_ID%TYPE
            )
  AS

 BEGIN
      SELECT NVL(MAX(PW.SEQ_NUM), 0) + 1 AS NEXT_SEQ
        INTO O_SEQ_NUMBER
        FROM HRA_PREVIOUS_WORK PW
       WHERE PW.YEAR_YYYY     =    P_YEAR_YYYY
         AND PW.PERSON_ID     =    P_PERSON_ID
         AND PW.SOB_ID        =    P_SOB_ID
         AND PW.ORG_ID        =    P_ORG_ID  
      ;
    EXCEPTION WHEN OTHERS THEN
      O_SEQ_NUMBER := 1;
  
    
  END GET_SEQ_NUMBER;
    
       
END HRA_PREVIOUS_WORK_G;
/
