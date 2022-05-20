CREATE OR REPLACE PACKAGE FI_VAT_E_FILE_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_VAT_E_FILE_G
Description  : ���ڽŰ����ϻ��� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : ���ڽŰ����ϻ���
Program History :
    -.�ΰ���ġ�� ���� ��� �ڷ���� ����(�ΰ����Ű��� ����) �� �۾��Ѵ�. �۾������� ���� �������� �Ѵ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-10-10   Leem Dong Ern(�ӵ���)
*****************************************************************************/


--��������
g_SOB_ID            FI_VAT_E_FILE.SOB_ID%TYPE;              --ȸ����̵�
g_ORG_ID            FI_VAT_E_FILE.ORG_ID%TYPE;              --����ξ��̵�
g_VAT_MNG_SERIAL    FI_VAT_E_FILE.VAT_MNG_SERIAL%TYPE;      --�ΰ����Ű��Ⱓ���й�ȣ
g_CREATED_BY        FI_VAT_E_FILE.CREATED_BY%TYPE;          --������
g_TAX_CODE          FI_VAT_E_FILE.TAX_CODE%TYPE;            --�������̵�(��>110)
g_REPORT_DOC        FI_VAT_E_FILE.REPORT_DOC%TYPE;          --�Ű�������
g_REPORT_CONTENT    FI_VAT_E_FILE.REPORT_CONTENT%TYPE;      --�Ű�����
g_SPEC_SERIAL       FI_VAT_E_FILE.SPEC_SERIAL%TYPE;         --�Ϸù�ȣ

g_SYSDATE           DATE;
g_BUSINESS_ITEM_30  VARCHAR2(100) := NULL;  --����
g_BUSINESS_TYPE_50  VARCHAR2(100) := NULL;  --����
g_ATTRIBUTE1        VARCHAR2(100) := NULL;  --�����ڵ� 



--�Ű�������
--�޽��� : �����ڷḦ �����Ͻðڽ��ϱ�? �� ������ �ڷᰡ �ִ� ��� ���� �ڷᰡ �����ǰ� (��)�����˴ϴ�.
--FCM_10365, �ش� �Ű��Ⱓ�� �ڷ�� �����Ǿ� ������ �� �����ϴ�.
PROCEDURE CREATE_VAT_E_FILE(
      W_SOB_ID              IN  FI_VAT_E_FILE.SOB_ID%TYPE           --ȸ����̵�
    , W_ORG_ID              IN  FI_VAT_E_FILE.ORG_ID%TYPE           --����ξ��̵�
    , W_TAX_CODE            IN  FI_VAT_E_FILE.TAX_CODE%TYPE         --�������̵�(��>110)     
    , W_VAT_MNG_SERIAL      IN  FI_VAT_E_FILE.VAT_MNG_SERIAL%TYPE   --�ΰ����Ű��Ⱓ���й�ȣ
    --, W_VAT_MAKE_GB         IN  FI_VAT_E_FILE.VAT_MAKE_GB%TYPE      --�ŽŰ�����(01 : ����Ű�)
    , W_CREATE_DATE         IN  DATE    --�ۼ�����
    , W_ISSUE_DATE_FR       IN  DATE    --�����Ⱓ_����
    , W_ISSUE_DATE_TO       IN  DATE    --�����Ⱓ_����     
    , W_CREATED_BY          IN  FI_VAT_E_FILE.CREATED_BY%TYPE       --������   
);





--FI_VAT_E_FILE �ڷ� INSERT
PROCEDURE INSERT_VAT_E_FILE(
      P_REPORT_DOC      IN  FI_VAT_E_FILE.REPORT_DOC%TYPE       --�Ű�������
    , P_REPORT_CONTENT  IN  FI_VAT_E_FILE.REPORT_CONTENT%TYPE   --�Ű�����    
);






--1-3. [�ΰ���ġ�����Աݾ׵�(����ǥ�ظ���, �鼼���Աݾ�)] �ڷ� INSERT
PROCEDURE INSERT_1_4(
      W_AMT         IN  NUMBER      --�ݾ�
    , W_AMT_KIND    IN  VARCHAR2    --���Աݾ���������  
);








--���ڽŰ� ���� ������ ���õǴ� �ΰ����Ű��� ���� ��ȸ ; 1��° �� ��ȸ
PROCEDURE LIST_VAT_E_FILE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_SURTAX_CARD.TAX_CODE%TYPE            --�������̵�(��>110)         
    , W_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű��Ⱓ���й�ȣ
    , W_VAT_MAKE_GB         IN  FI_SURTAX_CARD.VAT_MAKE_GB%TYPE DEFAULT '01'    --�Ű�����(01 : ����Ű�)
);






--���ڽŰ����� ������ �ʿ��� �ΰ����Ű��� �ڷḦ �����Ѵ�. ; 1�� ° �� ����
PROCEDURE UPDATE_SURTAX_CARD(
      W_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE              --ȸ����̵�
    , W_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE              --����ξ��̵�
    , W_TAX_CODE            IN  FI_SURTAX_CARD.TAX_CODE%TYPE            --�������̵�(��>110)       
    , W_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű��Ⱓ���й�ȣ
    , W_SPEC_SERIAL         IN  FI_SURTAX_CARD.SPEC_SERIAL%TYPE         --�Ϸù�ȣ    
    
    , P_TITLE_14	        IN	FI_SURTAX_CARD.TITLE_14%TYPE	        --�ۼ�����
    , P_DEAL_BANK	        IN	FI_SURTAX_CARD.DEAL_BANK%TYPE	        --�ŷ�����
    , P_DEAL_BANK_CD	    IN	FI_SURTAX_CARD.DEAL_BANK_CD%TYPE	    --�ŷ������ڵ�
    , P_DEAL_BRANCH	        IN	FI_SURTAX_CARD.DEAL_BRANCH%TYPE	        --�ŷ�����
    , P_DEAL_BRANCH_ID	    IN	FI_SURTAX_CARD.DEAL_BRANCH_ID%TYPE	    --�ŷ������ڵ�
    , P_ACC_NO	            IN	FI_SURTAX_CARD.ACC_NO%TYPE	            --���¹�ȣ
    , P_HOMETAX_USERID	    IN	FI_SURTAX_CARD.HOMETAX_USERID%TYPE	    --Ȩ�ý�_����ھ��̵�
    , P_VAT_PRESENTER_GB	IN	FI_SURTAX_CARD.VAT_PRESENTER_GB%TYPE    --�����ڱ���
    , P_VAT_LEVIER_GB	    IN	FI_SURTAX_CARD.VAT_LEVIER_GB%TYPE	    --�Ϲݰ����ڱ���
    , P_VAT_REFUND_GB	    IN	FI_SURTAX_CARD.VAT_REFUND_GB%TYPE	    --ȯ�ޱ���
    , P_TITLE_10	        IN	FI_SURTAX_CARD.TITLE_10%TYPE	        --���ڿ����ּ�

    , P_E_FILE_SURTAX_YN	    IN  FI_SURTAX_CARD.E_FILE_SURTAX_YN%TYPE        --���ڽŰ����ϻ�����󿩺�_�ΰ����Ű���
    , P_E_FILE_ZERO_YN	        IN  FI_SURTAX_CARD.E_FILE_ZERO_YN%TYPE          --���ڽŰ����ϻ�����󿩺�_������÷�μ������������
    , P_E_FILE_REAL_ESTATE_YN   IN  FI_SURTAX_CARD.E_FILE_REAL_ESTATE_YN%TYPE   --���ڽŰ����ϻ�����󿩺�_�ε����Ӵ���ް��׸�����
    , P_E_FILE_BLD_YN	        IN  FI_SURTAX_CARD.E_FILE_BLD_YN%TYPE           --���ڽŰ����ϻ�����󿩺�_�ǹ�������ڻ���������
    , P_E_FILE_NO_DEDUCTION_YN	IN  FI_SURTAX_CARD.E_FILE_NO_DEDUCTION_YN%TYPE  --���ڽŰ����ϻ�����󿩺�_�����������Ҹ��Լ��׸�����
    , P_E_FILE_SUM_VAT_YN	    IN  FI_SURTAX_CARD.E_FILE_SUM_VAT_YN%TYPE       --���ڽð����ϻ�����󿩺�_���ݰ�꼭�հ�ǥ
    , P_E_FILE_SUM_CALC_YN	    IN  FI_SURTAX_CARD.E_FILE_SUM_CALC_YN%TYPE      --���ڽŰ����ϻ�����󿩺�_��꼭�հ�ǥ
    , P_E_FILE_EXPORT_YN	    IN  FI_SURTAX_CARD.E_FILE_EXPORT_YN%TYPE        --���ڽŰ����ϻ�����󿩺�_�������������
    , P_E_FILE_GET_YN	        IN  FI_SURTAX_CARD.E_FILE_GET_YN%TYPE           --���ڽŰ����ϻ�����󿩺�_�ſ�ī�������ǥ����������    
    , P_E_FILE_TAX_PUB_YN	    IN  FI_SURTAX_CARD.E_FILE_TAX_PUB_YN%TYPE       --���ڽŰ����ϻ�����󿩺�_���ڼ��ݰ�꼭�߱޼��װ����Ű���
    , P_E_FILE_DOMESTIC_LC_YN   IN  FI_SURTAX_CARD.E_FILE_DOMESTIC_LC_YN%TYPE   --���ڽŰ����ϻ�����󿩺�_�����ſ��屸��Ȯ�μ����ڹ߱޸�����
    , P_E_FILE_COPPER_ETC_YN    IN  FI_SURTAX_CARD.E_FILE_COPPER_ETC_YN%TYPE    -- ���ڽŰ����ϻ�����󿩺�_������ũ������Լ��װ����Ű��� 
    , P_E_FILE_RECYCLING_ETC_YN IN  FI_SURTAX_CARD.E_FILE_RECYCLING_ETC_YN%TYPE -- ���ڽŰ����ϻ�����󿩺�_��Ȱ�����ڿ����߰��ڵ������Լ��װ����Ű���    
    , P_LAST_UPDATED_BY     IN  FI_SURTAX_CARD.LAST_UPDATED_BY%TYPE     --������
);






--���ڽŰ����� �ٿ�ε�; 2��° �� ��ȸ
PROCEDURE FILE_DOWN_VAT_E_FILE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_VAT_E_FILE.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_VAT_E_FILE.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_VAT_E_FILE.TAX_CODE%TYPE            --�������̵�(��>110)         
    , W_VAT_MNG_SERIAL      IN  FI_VAT_E_FILE.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű��Ⱓ���й�ȣ
    , W_VAT_MAKE_GB         IN  FI_VAT_E_FILE.VAT_MAKE_GB%TYPE DEFAULT '01'    --�Ű�����(01 : ����Ű�)
);




END FI_VAT_E_FILE_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_E_FILE_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_VAT_E_FILE_G
Description  : ���ڽŰ����ϻ��� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : ���ڽŰ����ϻ���
Program History :
    -.�ΰ���ġ�� ���� ��� �ڷ���� ����(�ΰ����Ű��� ����) �� �۾��Ѵ�. �۾������� ���� �������� �Ѵ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-10-10   Leem Dong Ern(�ӵ���)
*****************************************************************************/






--�Ű�������
--�޽��� : �����ڷḦ �����Ͻðڽ��ϱ�? �� ������ �ڷᰡ �ִ� ��� ���� �ڷᰡ �����ǰ� (��)�����˴ϴ�.
--FCM_10365, �ش� �Ű��Ⱓ�� �ڷ�� �����Ǿ� ������ �� �����ϴ�.
PROCEDURE CREATE_VAT_E_FILE(
      W_SOB_ID              IN  FI_VAT_E_FILE.SOB_ID%TYPE           --ȸ����̵�
    , W_ORG_ID              IN  FI_VAT_E_FILE.ORG_ID%TYPE           --����ξ��̵�
    , W_TAX_CODE            IN  FI_VAT_E_FILE.TAX_CODE%TYPE         --�������̵�(��>110)     
    , W_VAT_MNG_SERIAL      IN  FI_VAT_E_FILE.VAT_MNG_SERIAL%TYPE   --�ΰ����Ű��Ⱓ���й�ȣ
    --, W_VAT_MAKE_GB         IN  FI_VAT_E_FILE.VAT_MAKE_GB%TYPE      --�ŽŰ�����(01 : ����Ű�)
    , W_CREATE_DATE         IN  DATE    --�ۼ�����
    , W_ISSUE_DATE_FR       IN  DATE    --�����Ⱓ_����
    , W_ISSUE_DATE_TO       IN  DATE    --�����Ⱓ_����     
    , W_CREATED_BY          IN  FI_VAT_E_FILE.CREATED_BY%TYPE       --������   
)

AS

t_CLOSING_YN        FI_VAT_REPORT_MNG.CLOSING_YN%TYPE;  --��������

--�������� ���Ǵ� �ڷḦ �ӽú����� �����Ѵ�.
t_LEGAL_NUMBER      VARCHAR2(100) := NULL;   --�ֹ�(����)��Ϲ�ȣ
t_VAT_NUMBER_13     VARCHAR2(100) := NULL;   --����ڵ�Ϲ�ȣ, ���̰� 13�ڸ� ��
t_VAT_NUMBER_10     VARCHAR2(100) := NULL;   --����ڵ�Ϲ�ȣ, ���̰� 10�ڸ� ��
t_CORP_NAME_30      VARCHAR2(100) := NULL;   --��ȣ(���θ�)
t_PRESIDENT_NAME_30 VARCHAR2(100) := NULL;   --����(��ǥ��), ���̰� 30�ڸ� ��
t_PRESIDENT_NAME_15 VARCHAR2(100) := NULL;   --����(��ǥ��), ���̰� 15�ڸ� ��
t_LOCATION_70       VARCHAR2(100) := NULL;   --����������, ���̰� 70�ڸ� ��
t_LOCATION_45       VARCHAR2(100) := NULL;   --����������, ���̰� 45�ڸ� ��
t_REPORT_FR         VARCHAR2(100) := NULL;    --�����Ⱓ_����
t_REPORT_TO         VARCHAR2(100) := NULL;    --�����Ⱓ_����
t_TAX_YEAR          VARCHAR2(4)   := NULL;    -- �����Ⱓ_�⵵ 
t_TAX_TERM          VARCHAR2(100) := NULL;    --�����Ⱓ_���
t_REPORT_DEGREE     VARCHAR2(100) := NULL;    --�Ű�����
t_VAT_TEL           VARCHAR2(100) := NULL;    --�������ϼ��Ͽ� ��ȭ��ȣ
t_ZIP_CODE          VARCHAR2(100) := NULL;    --������ȣ
t_TAX_OFFICE_CODE     HRM_OPERATING_UNIT.TAX_OFFICE_CODE%TYPE;    --���Ҽ������ڵ�
t_GENERALLY_TAX_CODE  HRM_OPERATING_UNIT.GENERALLY_TAX_CODE%TYPE; -- �Ѱ����ν��ι�ȣ  
t_TOT_REAL_VAT_AMOUNT NUMBER := 0;                                -- ������������ ���� 

--���ڽŰ�������ϻ�������� �Ǵ� �������� �ľ��Ѵ�.
t_E_FILE_SURTAX_YN	        FI_SURTAX_CARD.E_FILE_SURTAX_YN%TYPE;       --���ڽŰ����ϻ�����󿩺�_�ΰ����Ű���
t_E_FILE_ZERO_YN	          FI_SURTAX_CARD.E_FILE_ZERO_YN%TYPE;         --���ڽŰ����ϻ�����󿩺�_������÷�μ������������
t_E_FILE_REAL_ESTATE_YN	    FI_SURTAX_CARD.E_FILE_REAL_ESTATE_YN%TYPE;  --���ڽŰ����ϻ�����󿩺�_�ε����Ӵ���ް��׸�����
t_E_FILE_BLD_YN	            FI_SURTAX_CARD.E_FILE_BLD_YN%TYPE;          --���ڽŰ����ϻ�����󿩺�_�ǹ�������ڻ���������
t_E_FILE_NO_DEDUCTION_YN	  FI_SURTAX_CARD.E_FILE_NO_DEDUCTION_YN%TYPE; --���ڽŰ����ϻ�����󿩺�_�����������Ҹ��Լ��׸�����
t_E_FILE_SUM_VAT_YN	        FI_SURTAX_CARD.E_FILE_SUM_VAT_YN%TYPE;      --���ڽð����ϻ�����󿩺�_���ݰ�꼭�հ�ǥ
t_E_FILE_SUM_CALC_YN	      FI_SURTAX_CARD.E_FILE_SUM_CALC_YN%TYPE;     --���ڽŰ����ϻ�����󿩺�_��꼭�հ�ǥ
t_E_FILE_EXPORT_YN	        FI_SURTAX_CARD.E_FILE_EXPORT_YN%TYPE;       --���ڽŰ����ϻ�����󿩺�_�������������
t_E_FILE_GET_YN	            FI_SURTAX_CARD.E_FILE_GET_YN%TYPE;          --���ڽŰ����ϻ�����󿩺�_�ſ�ī�������ǥ����������
t_E_FILE_TAX_PUB_YN	        FI_SURTAX_CARD.E_FILE_TAX_PUB_YN%TYPE;      --���ڽŰ����ϻ�����󿩺�_���ڼ��ݰ�꼭�߱޼��װ����Ű���
t_E_FILE_DOMESTIC_LC_YN     FI_SURTAX_CARD.E_FILE_DOMESTIC_LC_YN%TYPE;  --���ڽŰ����ϻ�����󿩺�_�����ſ��屸��Ȯ�μ����ڹ߱޸�����
t_E_FILE_COPPER_ETC_YN      FI_SURTAX_CARD.E_FILE_COPPER_ETC_YN%TYPE;     -- ���ڽŰ����ϻ�����󿩺�_������ũ������Լ��װ�����û�� 
t_E_FILE_RECYCLING_ETC_YN   FI_SURTAX_CARD.E_FILE_RECYCLING_ETC_YN%TYPE;  -- ���ڽŰ����ϻ�����󿩺�_��Ȱ�����ڿ����߰��ڵ������Լ��װ����Ű���  

t_COL26_3   FI_SURTAX_CARD.COL26_3%TYPE;  --����ǥ��_�ݾ�1
t_COL27_3   FI_SURTAX_CARD.COL27_3%TYPE;  --����ǥ��_�ݾ�2
t_COL28_3   FI_SURTAX_CARD.COL28_3%TYPE;  --����ǥ��_�ݾ�3
t_COL29_3   FI_SURTAX_CARD.COL29_3%TYPE;  --����ǥ��_�ݾ�4
t_COL19_2   FI_SURTAX_CARD.COL19_2%TYPE;  --�ſ�ī�������ǥ����������
t_COL18_2   FI_SURTAX_CARD.COL18_2%TYPE;  --��Ÿ�氨��������
t_COL69_3   FI_SURTAX_CARD.COL69_3%TYPE;  --�鼼������Աݾ�_�ݾ�1
t_COL70_3   FI_SURTAX_CARD.COL70_3%TYPE;  --�鼼������Աݾ�_�ݾ�2
t_COL71_3   FI_SURTAX_CARD.COL71_3%TYPE;  --�鼼������Աݾ�_�ݾ�3

--�ǹ�������ڻ��������� �Ǽ�, �ݾ�, �հ�
t_5_CNT NUMBER(11) := 0;
t_5_AMT NUMBER(13) := 0;
t_5_TAX NUMBER(13) := 0;
t_6_CNT NUMBER(11) := 0;
t_6_AMT NUMBER(13) := 0;
t_6_TAX NUMBER(13) := 0;
t_7_CNT NUMBER(11) := 0;
t_7_AMT NUMBER(13) := 0;
t_7_TAX NUMBER(13) := 0;
t_8_CNT NUMBER(11) := 0;
t_8_AMT NUMBER(13) := 0;
t_8_TAX NUMBER(13) := 0;
t_9_CNT NUMBER(11) := 0;
t_9_AMT NUMBER(13) := 0;
t_9_TAX NUMBER(13) := 0;

--�������������
t_EXP_SUM_CNT   NUMBER(7) := 0;
t_EXP_SUM_FOR   NUMBER(15,2) := 0.00;
t_EXP_SUM_KOR   NUMBER(15) := 0;
t_EXP_ITEM_CNT  NUMBER(7) := 0;
t_EXP_ITEM_FOR  NUMBER(15,2) := 0.00;
t_EXP_ITEM_KOR  NUMBER(15) := 0;
t_EXP_OTHER_CNT NUMBER(7) := 0;
t_EXP_OTHER_FOR NUMBER(15,2) := 0.00;
t_EXP_OTHER_KOR NUMBER(15) := 0;

t_SEQ           NUMBER(10) := 0;    --[�ſ�ī��� ���Գ��� �հ�(Tail Record)] ���������� �����.

t_CASH_CNT NUMBER := 0;

BEGIN
    --�������� �� ����
    g_SYSDATE           := GET_LOCAL_DATE(W_SOB_ID);
    g_SOB_ID            := W_SOB_ID;            --ȸ����̵�
    g_ORG_ID            := W_ORG_ID;            --����ξ��̵�
    g_VAT_MNG_SERIAL    := W_VAT_MNG_SERIAL;    --�ΰ����Ű��Ⱓ���й�ȣ
    g_CREATED_BY        := W_CREATED_BY;        --������
    g_TAX_CODE          := W_TAX_CODE;          --�������̵�(��>110)


    --�ش� �Ű��Ⱓ�� �������θ� �ľ��Ѵ�.
    SELECT CLOSING_YN
    INTO t_CLOSING_YN
    FROM FI_VAT_REPORT_MNG
    WHERE   SOB_ID  = W_SOB_ID  --ȸ����̵�
        AND ORG_ID  = W_ORG_ID  --����ξ��̵�
        AND TAX_CODE = W_TAX_CODE                   --�������̵�
        AND VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL    --�ΰ����Ű��Ⱓ���й�ȣ
    ;    
    
    --FCM_10365, �ش� �Ű��Ⱓ�� �ڷ�� �����Ǿ� ������ �� �����ϴ�.
    IF t_CLOSING_YN = 'Y' THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10365', NULL));
    END IF;



    --������ �����ϴ� �ڷᰡ ���� ��� ��� �����Ѵ�.
    DELETE FI_VAT_E_FILE
    WHERE   SOB_ID  = W_SOB_ID  --ȸ����̵�
        AND ORG_ID  = W_ORG_ID  --����ξ��̵�
        AND TAX_CODE            = W_TAX_CODE   --�������̵�
        AND VAT_MNG_SERIAL      = W_VAT_MNG_SERIAL      --�ΰ����Ű��Ⱓ���й�ȣ
        AND VAT_MAKE_GB         = '01'         --�Ű�����
    ;
    
        
    --�������� ���Ǵ� �ڷḦ �ӽú����� �����Ѵ�.

    SELECT
          RPAD(REPLACE(A.LEGAL_NUMBER, '-', ''), 13, ' ') AS LEGAL_NUMBER   --�ֹ�(����)��Ϲ�ȣ('-'�����Ѱ�)           
        , RPAD(REPLACE(B.VAT_NUMBER, '-', ''), 13, ' ') AS VAT_NUMBER_13       --����ڵ�Ϲ�ȣ('-'�����Ѱ�) 
        , RPAD(REPLACE(B.VAT_NUMBER, '-', ''), 10, ' ') AS VAT_NUMBER_10       --����ڵ�Ϲ�ȣ('-'�����Ѱ�) 
        , RPAD(A.CORP_NAME, 30, ' ')        --��ȣ(���θ�)      
        , RPAD(A.PRESIDENT_NAME, 30, ' ')   --����(��ǥ��)
        , RPAD(A.PRESIDENT_NAME, 15, ' ')   --����(��ǥ��)
        , RPAD(B.ADDR1 || ' ' || B.ADDR2, 70, ' ')  --����������
        , RPAD(B.ADDR1 || ' ' || B.ADDR2, 45, ' ')  --����������
        , RPAD(B.BUSINESS_ITEM, 30, ' ')    --����       
        , RPAD(B.BUSINESS_TYPE, 50, ' ')    --����         
        , RPAD(B.ATTRIBUTE1, 7, ' ')        --�����ڵ�     
        , TO_CHAR(W_ISSUE_DATE_FR, 'YYYYMMDD') AS REPORT_FR    --�Ű��Ⱓ_����
        , TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMMDD') AS REPORT_TO    --�Ű��Ⱓ_���� 
        , TO_CHAR(W_ISSUE_DATE_TO, 'YYYY') AS TAX_YEAR         -- �Ű��⵵ 
        , TO_CHAR(W_ISSUE_DATE_TO, 'YYYY') || 
            CASE 
                WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') <= '06' THEN '01'
                WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') <= '12' THEN '02'
            END AS TAX_TERM -- �����Ⱓ_���
        , LPAD(CASE 
               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '07') THEN '1'
               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('02', '08') THEN '2'
               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('03', '09') THEN '3'
               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '10') THEN '4'
               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('05', '11') THEN '5'
               WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('06', '12') THEN '6'
          END, 4, '0') AS REPORT_DEGREE   -- �Ű�����
        , RPAD(A.ATTRIBUTE1, 4, ' ') || RPAD(A.ATTRIBUTE2, 4, ' ') || RPAD(A.ATTRIBUTE3, 7, ' ') AS VAT_TEL --�������ϼ��Ͽ� ��ȭ��ȣ
        , B.ZIP_CODE                        --������ȣ
        , RPAD(B.TAX_OFFICE_CODE, 3, ' ')   --���Ҽ������ڵ�
        , B.GENERALLY_TAX_CODE              -- �Ѱ����ν��ι�ȣ  
        --, A.TEL_NUMBER                          --��ȭ��ȣ
        --, B.TAX_OFFICE_NAME --���Ҽ�����        
    INTO
          t_LEGAL_NUMBER        --�ֹ�(����)��Ϲ�ȣ          
        , t_VAT_NUMBER_13       --����ڵ�Ϲ�ȣ
        , t_VAT_NUMBER_10       --����ڵ�Ϲ�ȣ        
        , t_CORP_NAME_30        --��ȣ(���θ�)        
        , t_PRESIDENT_NAME_30   --����(��ǥ��)
        , t_PRESIDENT_NAME_15   --����(��ǥ��) 
        , t_LOCATION_70         --���������� 
        , t_LOCATION_45         --����������
        , g_BUSINESS_ITEM_30    --����         
        , g_BUSINESS_TYPE_50    --����
        , g_ATTRIBUTE1          --�����ڵ� 
        , t_REPORT_FR           --�����Ⱓ_����
        , t_REPORT_TO           --�����Ⱓ_����
        , t_TAX_YEAR            -- �����Ⱓ_�⵵ 
        , t_TAX_TERM            --�����Ⱓ_���
        , t_REPORT_DEGREE       --�Ű�����
        , t_VAT_TEL             --�������ϼ��Ͽ� ��ȭ��ȣ
        , t_ZIP_CODE            --������ȣ
        , t_TAX_OFFICE_CODE     --���Ҽ������ڵ�
        , t_GENERALLY_TAX_CODE  -- �Ѱ����ν��ι�ȣ 
    FROM HRM_CORP_MASTER A
       , HRM_OPERATING_UNIT B
       , ( SELECT FC.CODE AS TAX_CODE
                , FC.CODE_NAME AS TAX_DESC
                , REPLACE(FC.VALUE1, '-', '') AS VAT_NUMBER
             FROM FI_COMMON FC
            WHERE FC.GROUP_CODE     = 'TAX_CODE'
              AND FC.SOB_ID         = W_SOB_ID
              AND FC.ORG_ID         = W_ORG_ID
              AND FC.CODE           = W_TAX_CODE
          ) SX1
    WHERE A.CORP_ID = B.CORP_ID
        AND REPLACE(B.VAT_NUMBER, '-', '')    = SX1.VAT_NUMBER
        AND A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID
        AND A.ENABLED_FLAG          = 'Y'
        AND B.USABLE                = 'Y'
        AND (B.DEFAULT_FLAG         = 'Y'
        OR   ROWNUM                 <= 1);
        
    
    
    --���ڽŰ�������ϻ�������� �Ǵ� �������� �ľ��Ѵ�.
    --�ľ��� ����� ���� ��������� ���������� ���ڽŰ����Ϸ� �����ϱ� �����̴�.
    SELECT
          E_FILE_SURTAX_YN          --���ڽŰ����ϻ�����󿩺�_�ΰ����Ű���
        , E_FILE_ZERO_YN            --���ڽŰ����ϻ�����󿩺�_������÷�μ������������
        , E_FILE_REAL_ESTATE_YN     --���ڽŰ����ϻ�����󿩺�_�ε����Ӵ���ް��׸�����
        , E_FILE_BLD_YN             --���ڽŰ����ϻ�����󿩺�_�ǹ�������ڻ���������
        , E_FILE_NO_DEDUCTION_YN    --���ڽŰ����ϻ�����󿩺�_�����������Ҹ��Լ��׸�����
        , E_FILE_SUM_VAT_YN         --���ڽð����ϻ�����󿩺�_���ݰ�꼭�հ�ǥ
        , E_FILE_SUM_CALC_YN        --���ڽŰ����ϻ�����󿩺�_��꼭�հ�ǥ
        , E_FILE_EXPORT_YN          --���ڽŰ����ϻ�����󿩺�_�������������
        , E_FILE_GET_YN             --���ڽŰ����ϻ�����󿩺�_�ſ�ī�������ǥ����������
        , E_FILE_TAX_PUB_YN         --���ڽŰ����ϻ�����󿩺�_���ڼ��ݰ�꼭�߱޼��װ����Ű���
        , E_FILE_DOMESTIC_LC_YN     --���ڽŰ����ϻ�����󿩺�_�����ſ��屸��Ȯ�μ����ڹ߱޸�����         
        , E_FILE_COPPER_ETC_YN
        , E_FILE_RECYCLING_ETC_YN 
        
        , NVL(( SELECT SUM(FSC.COL25) AS COL25
                  FROM FI_SURTAX_CARD    FSC
                     , FI_VAT_REPORT_MNG VRM
                 WHERE FSC.VAT_MNG_SERIAL       = VRM.VAT_MNG_SERIAL
                   AND FSC.SOB_ID               = SC.SOB_ID
                   AND FSC.ORG_ID               = SC.ORG_ID
                   AND FSC.LAST_FLAG            = 'Y'
                   AND FSC.VAT_LEVIER_GB        IN('2', '3')       -- �Ѱ�����(��),(��) �����  
                   AND 1                       = DECODE(SC.VAT_LEVIER_GB, '2', 1, 2)
                   AND EXISTS
                         ( SELECT 'X'
                             FROM FI_VAT_REPORT_MNG RM
                            WHERE RM.SOB_ID            = VRM.SOB_ID
                              AND RM.ORG_ID            = VRM.ORG_ID
                              AND RM.FY                = VRM.FY
                              AND RM.VAT_REPORT_TURN   = VRM.VAT_REPORT_TURN
                              AND RM.VAT_REPORT_GB     = VRM.VAT_REPORT_GB
                              AND RM.TAX_CODE          = SC.TAX_CODE
                              AND RM.VAT_MNG_SERIAL    = SC.VAT_MNG_SERIAL
                         )), 0) AS TOT_REAL_VAT_AMOUNT    -- �Ѱ����λ���� ����(ȯ��)�� ����
    INTO
          t_E_FILE_SURTAX_YN        --���ڽŰ����ϻ�����󿩺�_�ΰ����Ű���
        , t_E_FILE_ZERO_YN          --���ڽŰ����ϻ�����󿩺�_������÷�μ������������
        , t_E_FILE_REAL_ESTATE_YN   --���ڽŰ����ϻ�����󿩺�_�ε����Ӵ���ް��׸�����
        , t_E_FILE_BLD_YN           --���ڽŰ����ϻ�����󿩺�_�ǹ�������ڻ���������
        , t_E_FILE_NO_DEDUCTION_YN  --���ڽŰ����ϻ�����󿩺�_�����������Ҹ��Լ��׸�����
        , t_E_FILE_SUM_VAT_YN       --���ڽð����ϻ�����󿩺�_���ݰ�꼭�հ�ǥ
        , t_E_FILE_SUM_CALC_YN      --���ڽŰ����ϻ�����󿩺�_��꼭�հ�ǥ
        , t_E_FILE_EXPORT_YN        --���ڽŰ����ϻ�����󿩺�_�������������
        , t_E_FILE_GET_YN           --���ڽŰ����ϻ�����󿩺�_�ſ�ī�������ǥ����������        
        , t_E_FILE_TAX_PUB_YN       --���ڽŰ����ϻ�����󿩺�_���ڼ��ݰ�꼭�߱޼��װ����Ű���
        , t_E_FILE_DOMESTIC_LC_YN   --���ڽŰ����ϻ�����󿩺�_�����ſ��屸��Ȯ�μ����ڹ߱޸�����     
        , t_E_FILE_COPPER_ETC_YN    -- ���ڽŰ����ϻ�����󿩺�_������ũ������Լ��װ�����û�� 
        , t_E_FILE_RECYCLING_ETC_YN 
           
        , t_TOT_REAL_VAT_AMOUNT     -- �����������Ҽ���  
    FROM FI_SURTAX_CARD SC   
    WHERE   SOB_ID  = W_SOB_ID  --ȸ����̵�
        AND ORG_ID  = W_ORG_ID  --����ξ��̵�
        AND TAX_CODE            = W_TAX_CODE            --�������̵�
        AND VAT_MNG_SERIAL      = W_VAT_MNG_SERIAL      --�ΰ����Ű��Ⱓ���й�ȣ
        AND VAT_MAKE_GB         = '01'         --�Ű�����(01 : ����Ű�)
    ;



--1.�ΰ���ġ�� �Ϲ� �� ���� �Ű���
IF t_E_FILE_SURTAX_YN = 'Y' THEN          --���ڽŰ����ϻ�����󿩺�_�ΰ����Ű���

    --1-1. [�Ű��� HEAD ���ڵ�]�� �Ű����� ����
    
    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO g_SPEC_SERIAL FROM FI_VAT_E_FILE;
    
    SELECT
        
           '11'             --1.�ڷᱸ�� 	    CHAR	2 [�ΰ���ġ�� �Ϲ� ��11��, ���� ��12�� ]        
        || 'V101'           --2.�����ڵ�	    CHAR	4 [�Ϲݻ���ڴ� ��V101', ���̻���ڴ� 'V102' ]        
        ||  t_VAT_NUMBER_13    --3.������ID	    CHAR	13 [����ڵ�Ϲ�ȣ]        
        || '41'             --4.���񱸺��ڵ�	CHAR	2   [��41�� �ΰ���ġ��]        
        || CASE 
                WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '07', '08', '09') THEN '3'  --�����Ű�
                WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '05', '06', '10', '11', '12') THEN '1'  --Ȯ���Ű�
           END                      --5.�Ű�����	        CHAR	1        
        || '8'                      --6.�����ڱ���	        CHAR	1   [ ��1�� ����, ��8�� ����]        
        || t_TAX_TERM               --7.�����Ⱓ_���(��)	CHAR	6
        || t_REPORT_DEGREE          --8.�Ű�����	        NUMBER	4
        || LPAD(1, 4, 0)            --9.������ȣ	        NUMBER	4   [] ��1�� ����Ű�?�����ĽŰ�,  ��2�̻� �����Ű� ?����û�� 
        || RPAD('bhflex', 20, ' ')  --10.�����ID	        CHAR	20  [Ȩ�ý��ý��ۿ� ��ϵ� �����(���� �Ǵ� �����븮��)�� ID]
        || t_LEGAL_NUMBER           --11.�����ڹ�ȣ	        CHAR	13      Null ��� [���ε�Ϲ�ȣ]
        || RPAD(' ', 30, ' ')       --12.�����븮�μ���	    CHAR	30  Null ���
        || RPAD(' ', 6, ' ')        --13.�����븮�ΰ�����ȣ	CHAR	6	106	space
        || RPAD(' ', 4, ' ')        --14.�����븮����ȭ��ȣ1(������ȣ)	CHAR	4	Null ���
        || RPAD(' ', 5, ' ')        --15.�����븮����ȭ��ȣ2(����)	    CHAR	5	Null ���
        || RPAD(' ', 5, ' ')        --16.�����븮����ȭ��ȣ3(������ȣ,�����������ѹ�ȣ)	CHAR	5	Null ���
        || t_CORP_NAME_30           --17.��ȣ(���θ�)	CHAR	30
        || t_PRESIDENT_NAME_30      --18.����(��ǥ�ڸ�)	CHAR	30
        || t_LOCATION_70            --19.����������	CHAR	70	Null ���
        || RPAD(' ', 14, ' ')       --20.�������ȭ��ȣ	CHAR	14	Null ���
        || t_LOCATION_70            --21.������ּ�	    CHAR	70	Null ���
        || RPAD(' ', 14, ' ')       --22.�������ȭ��ȣ	CHAR	14	Null ���
        || g_BUSINESS_ITEM_30       --23.���¸�	        CHAR	30
        || g_BUSINESS_TYPE_50       --24.�����	        CHAR	50
        || g_ATTRIBUTE1             --25.�����ڵ�	    CHAR	7
        || t_REPORT_FR              --26.�����Ⱓ(������)	    CHAR	8
        || t_REPORT_TO              --27.�����Ⱓ(������)	    CHAR	8
        || TO_CHAR(W_CREATE_DATE, 'YYYYMMDD')   --28.�ۼ�����	CHAR	8
        || '19990501'           --29.���������	            CHAR	8
        || 'N'                  --30.�����Ű�����	        CHAR	1   [��N�� : ���� , ��Y�� : ����]
        || RPAD(' ', 14, ' ')   --31.������޴���ȭ	        CHAR	14	Null ���
        || '9000'               --32.�������α׷��ڵ�	    CHAR	4   [9000 : ��Ÿ]
        || RPAD(' ', 10, ' ')   --33.�����븮�λ���ڹ�ȣ	CHAR	10	Null ���
        || RPAD(' ', 50, ' ')   --34.���ڸ����ּ�	        CHAR	50	Null ���
        || '100'                --35.�Ű����������ڵ�	    CHAR	3   [100 : �ϹݽŰ��� ����Ű�,���̽Ű��� ����Ű�]
        || RPAD(' ', 51, ' ')   --36.����	                CHAR	51
    INTO g_REPORT_CONTENT
    FROM DUAL;
    

    --1-1. �Ű��� HEAD ���ڵ�
    --���ĸ� : �ΰ���ġ��(�Ϲ�,���� ����), File : �ΰ���ġ��_���, ���� : 600
    INSERT INTO FI_VAT_E_FILE(
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�        
        , TAX_CODE      	--�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű��Ⱓ���й�ȣ
        , VAT_MAKE_GB	    --�Ű�����
        , SPEC_SERIAL	    --�Ϸù�ȣ

        , REPORT_DOC        --�Ű�������
        , REPORT_CONTENT    --�Ű�����
        
        , CREATION_DATE     --������
        , CREATED_BY	    --������
        , LAST_UPDATE_DATE  --������
        , LAST_UPDATED_BY	--������          
    )
    SELECT
          W_SOB_ID  --ȸ����̵�
        , W_ORG_ID  --����ξ��̵�
        , W_TAX_CODE                --�������̵�
        , W_VAT_MNG_SERIAL          --�ΰ����Ű��Ⱓ���й�ȣ
        , '01'	                    --�Ű�����
        , g_SPEC_SERIAL             --�Ϸù�ȣ 

        , '�Ű��� HEAD ���ڵ�'      --�Ű�������
        , g_REPORT_CONTENT          --�Ű�����
        
        , g_SYSDATE     --������
        , W_CREATED_BY  --������
        , g_SYSDATE     --������
        , W_CREATED_BY  --������         
    FROM DUAL   ;
    
    
    
    --1-2. [�ϹݽŰ��� ���ڵ�]�� �Ű����� ����
    --�ΰ����Ű����� �� ������ ��´�.
    
    g_REPORT_CONTENT := NULL;
        
    SELECT
           '17'      --1.�ڷᱸ��    CHAR	2   [�ΰ���ġ��_�Ϲ��� Data ���ۺκ� ��17��]
        || 'V101'    --2.�����ڵ�    CHAR	4
        || LPAD(REPLACE(LPAD(NVL(COL1_1, 0), 15, 0), '-', ''), 15, '-')	    --3.��ǥ�Ű��������ݰ�꼭�ݾ�	(1)	    NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL1_2, 0), 13, 0), '-', ''), 13, '-')	    --4.��ǥ�Ű��������ݰ�꼭����	(1)	    NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL4_1, 0), 13, 0), '-', ''), 13, '-')	    --5.��ǥ�Ű�������Ÿ�ݾ�	    (4)	    NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL4_2, 0), 13, 0), '-', ''), 13, '-')	    --6.��ǥ�Ű�������Ÿ����	    (4)	    NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL5_1, 0), 13, 0), '-', ''), 13, '-')	    --7.��ǥ�Ű��������ݰ�꼭�ݾ�	(5)	    NUMBER	13
        
        || LPAD(REPLACE(LPAD(NVL(COL6_1, 0), 15, 0), '-', ''), 15, '-')     --8.��ǥ�Ű�������Ÿ�ݾ�	    (6)	    NUMBER	15
        
        || LPAD(REPLACE(LPAD(NVL(COL31_1, 0), 13, 0), '-', ''), 13, '-')    --9.��ǥ�����������ݰ�꼭�ݾ�	(31)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL31_2, 0), 13, 0), '-', ''), 13, '-')	--10.��ǥ�����������ݰ�꼭����	(31)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL32_1, 0), 13, 0), '-', ''), 13, '-')	--11.��ǥ����������Ÿ�ݾ�	    (32)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL32_2, 0), 13, 0), '-', ''), 13, '-')	--12.��ǥ����������Ÿ����	    (32)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL33_1, 0), 13, 0), '-', ''), 13, '-')	--13.��ǥ�����������ݰ�꼭�ݾ�	(33)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL34_1, 0), 13, 0), '-', ''), 13, '-')	--14.��ǥ����������Ÿ�ݾ�	    (34)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL8_2, 0), 13, 0), '-', ''), 13, '-')	    --15.��ռ��װ�������	        (8)	    NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL10_1, 0), 15, 0), '-', ''), 15, '-')	--16.���Լ����Ϲݱݾ�	        (10)	NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL10_2, 0), 13, 0), '-', ''), 13, '-')	--17.���Լ����Ϲݼ���	        (10)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL11_1, 0), 13, 0), '-', ''), 13, '-')	--18.���Լ�������ڻ�ݾ�	    (11)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL11_2, 0), 13, 0), '-', ''), 13, '-')	--19.���Լ�������ڻ꼼��	    (11)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL39_1, 0), 13, 0), '-', ''), 13, '-')	--20.���Ա����ſ�ݾ�	        (39)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL39_2, 0), 13, 0), '-', ''), 13, '-')	--21.���Ա����ſ뼼��	        (39)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL41_1, 0), 13, 0), '-', ''), 13, '-')	--22.�����������Աݾ�	        (41)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL41_2, 0), 13, 0), '-', ''), 13, '-')	--23.�����������Լ���	        (41)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL42_1, 0), 13, 0), '-', ''), 13, '-')	--24.������Ȱ��ݾ�	            (42)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL42_2, 0), 13, 0), '-', ''), 13, '-')	--25.������Ȱ�뼼��	            (42)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL45_2, 0), 13, 0), '-', ''), 13, '-')	--26.����������Լ���	        (45)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL46_2, 0), 13, 0), '-', ''), 13, '-')	--27.���Ժ�����ռ���	        (46)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL15_1, 0), 15, 0), '-', ''), 15, '-')	--28.���Աݾ��հ�	            (15)	NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL15_2, 0), 13, 0), '-', ''), 13, '-')	--29.���Լ����հ�	            (15)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL49_1, 0), 13, 0), '-', ''), 13, '-')	--30.������Ը鼼����ݾ�	    (49)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL49_2, 0), 13, 0), '-', ''), 13, '-')	--31.������Ը鼼�������	    (49)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL48_1, 0), 13, 0), '-', ''), 13, '-')	--32.�Ұ������Աݾ�	            (48)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL48_2, 0), 13, 0), '-', ''), 13, '-')	--33.�Ұ������Լ���	            (48)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL50_2, 0), 13, 0), '-', ''), 13, '-')	--34.���ó�м���	            (50)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL17_1, 0), 15, 0), '-', ''), 15, '-')	--35.�������Աݾ�	            (17)	NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL17_2, 0), 13, 0), '-', ''), 13, '-')	--36.�������Լ���	            (��)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL_DA, 0), 13, 0), '-', ''), 13, '-')	    --37.����(ȯ��)����	            (��)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL58_1, 0), 13, 0), '-', ''), 13, '-')	--38.����ڵ�ϰ���ݾ�	        (58)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL58_2, 0), 13, 0), '-', ''), 13, '-')	--39.����ڵ�ϰ��꼼	        (58)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL63_1, 0), 13, 0), '-', ''), 13, '-')	--40.���ݰ�꼭�հ�ǥ����ݾ�	(63)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL63_2, 0), 13, 0), '-', ''), 13, '-')	--41.���ݰ�꼭�հ�ǥ���꼼	    (63)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL64_1, 0), 13, 0), '-', ''), 13, '-')	--42.�Ű��Ҽ��ǰ���ݾ�	        (64)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL64_2, 0), 13, 0), '-', ''), 13, '-')	--43.�Ű��Ҽ��ǰ��꼼��	        (64)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL66_1, 0), 13, 0), '-', ''), 13, '-')	--44.�������Ű�����ݾ�	        (66)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL66_2, 0), 13, 0), '-', ''), 13, '-')	--45.�������Ű����꼼	        (66)	NUMBER	13
        || LPAD(0, 13, 0)                                                   --46.�����ſ�����ݾ�	        (19)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL19_2, 0), 13, 0), '-', ''), 13, '-')	--47.�����ſ��������	        (19)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL22_2, 0), 13, 0), '-', ''), 13, '-')	--48.������������	            (��)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL21_2, 0), 13, 0), '-', ''), 13, '-')	--49.������ȯ�޼���	            (��)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL30, 0), 15, 0), '-', ''), 15, '-')	    --50.�������Աݾ��հ�	        (30)	NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL29_3, 0), 13, 0), '-', ''), 13, '-')	--51.�������Աݾ����ܱݾ�	    (29)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL72, 0), 15, 0), '-', ''), 15, '-')	    --52.�鼼���Աݾ��հ�	        (72)	NUMBER	    15
        || CASE
             WHEN NVL(COL25, 0) < 0 THEN NVL(VAT_REFUND_GB, ' ')
             ELSE ' '
           END                                                            --53.ȯ�ޱ���(�������Ͽ������Ҽ����� (-)�� ��츸 ����)  CHAR	1   Null ���  
        || LPAD(REPLACE(LPAD(NVL(COL54_2, 0), 13, 0), '-', ''), 13, '-')	--54.�ýû���ںΰ���ġ���氨����	(54)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL7_1, 0), 13, 0), '-', ''), 13, '-')	    --55.��ǥ�����Ű������бݾ�	        (7)	    NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL7_2, 0), 13, 0), '-', ''), 13, '-')	    --56.��ǥ�����Ű������м���	        (7)	    NUMBER	13
        || LPAD(0, 13, 0)                                                   --57.��ռ��װ����ݾ�	            (8)	    NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL14_1, 0), 13, 0), '-', ''), 13, '-')	--58.���Ա�Ÿ�����ݾ�	            (14)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL14_2, 0), 13, 0), '-', ''), 13, '-')	--59.���Ա�Ÿ��������	            (14)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL16_1, 0), 13, 0), '-', ''), 13, '-')	--60.���԰����������ұݾ�	        (16)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL16_2, 0), 13, 0), '-', ''), 13, '-')	--61.���԰����������Ҽ���	        (16)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL24_2, 0), 13, 0), '-', ''), 13, '-')	--62.���꼼��	                    (��)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL35_1, 0), 13, 0), '-', ''), 13, '-')	--63.��ǥ�����Ű������бݾ��հ�	    (35)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL35_2, 0), 13, 0), '-', ''), 13, '-')	--64.��ǥ�����Ű������м����հ�	    (35)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL47_1, 0), 13, 0), '-', ''), 13, '-')	--65.��Ÿ�������Աݾ��հ�	        (47)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL47_2, 0), 13, 0), '-', ''), 13, '-')	--66.��Ÿ�������Լ����հ�	        (47)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL50_1, 0), 13, 0), '-', ''), 13, '-')	--67.���ó�бݾ�	                (50)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL51_1, 0), 13, 0), '-', ''), 13, '-')	--68.���԰����������ұݾ��հ�	    (51)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL51_2, 0), 13, 0), '-', ''), 13, '-')	--69.���԰����������Ҽ����հ�	    (51)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL68_2, 0), 13, 0), '-', ''), 13, '-')	--70.���꼼���װ�	                (68)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL20_2, 0), 13, 0), '-', ''), 13, '-')	--71.�氨���װ�	                    (��)	NUMBER	13
        || LPAD(0, 13, 0)    --72.���ǽŰ�����ڰ氨����             NUMBER  13
        || LPAD(0, 13, 0)    --73.POS���� ����ڵ ���� �氨����   NUMBER  13
        || LPAD(REPLACE(LPAD(NVL(COL65_1, 0), 13, 0), '-', ''), 13, '-')	--74.���κҼ��ǰ���ݾ�	        (65)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL65_2, 0), 13, 0), '-', ''), 13, '-')	--75.���κҼ��ǰ��꼼��	        (65)	NUMBER	13
        || LPAD(0, 15, 0)    --76.�Ϲݰ�����ȯ�� ��������            NUMBER      15
        || LPAD(REPLACE(LPAD(NVL(COL18_2, 0), 15, 0), '-', ''), 15, '-')	--77.��Ÿ����_�氨����	        (18)	NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL9_1, 0), 15, 0), '-', ''), 15, '-')	    --78.����ǥ��	                (9)	    NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL25, 0), 15, 0), '-', ''), 15, '-')      --79.���������Ҽ���	            (25)	NUMBER	    15
        
        --�����ڵ�� ���¹�ȣ�� ��� �ְų� ��� ������ ����, �ϳ��� �����ϴ� ��� ����ó����
        || (
            SELECT RPAD(NVL(CODE, ' '), 3, ' ')
            FROM FI_COMMON 
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND GROUP_CODE = 'VAT_BANK_CODE'
                AND VALUE1 = DEAL_BANK_CD    
          ) --80.�����ڵ�(����ȯ�ޱ�)  CHAR	3   Null ���
        || RPAD(REPLACE(NVL(ACC_NO, ' '), '-', ''), 20, ' ')         --81.���¹�ȣ(����ȯ�ޱ�)    CHAR	20  Null ���
        
        || RPAD(NVL(t_GENERALLY_TAX_CODE, ' '), 7, ' ')                        --82.�Ѱ����ν��ι�ȣ        CHAR	7   Null ���
        || RPAD(NVL(DEAL_BRANCH, ' '), 30, ' ')                      --83.����������              CHAR	30  Null ���
        || LPAD(REPLACE(LPAD(COL9_2, 15, 0), '-', ''), 15, '-')      --84.���⼼��	(��)	      NUMBER	15
        || RPAD(NVL(TO_CHAR(CLOSURE_DATE, 'YYYYMMDD'), ' '), 8, ' ') --85.�������                CHAR	8   Null ���
        || RPAD(NVL(CLOSURE_REASON, ' '), 3, ' ')                    --86.�������                CHAR	3   Null ���    
        || 'N'   --87.������(����ǥ��)����  CHAR	1   Not Null    [����Ű�  :  N, �����ĽŰ� : Y]
        || LPAD(REPLACE(LPAD(NVL(COL73, 0), 15, 0), '-', ''), 15, '-')	    --88.��꼭 �߱ޱݾ�	            (73)	NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL74, 0), 15, 0), '-', ''), 15, '-')	    --89.��꼭 ����ݾ�	            (74)	NUMBER	    15    
        || LPAD(REPLACE(LPAD(NVL(COL12_1, 0), 13, 0), '-', ''), 13, '-')    --90.���Կ����Ű������ݾ�	        (12)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL12_2, 0), 13, 0), '-', ''), 13, '-')	--91.���Կ����Ű���������	        (12)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL36_1, 0), 13, 0), '-', ''), 13, '-')	--92.�������Լ��ݰ�꼭�����ݾ�	    (36)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL36_2, 0), 13, 0), '-', ''), 13, '-')	--93.�������Լ��ݰ�꼭��������	    (36)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL37_1, 0), 13, 0), '-', ''), 13, '-')	--94.�������Ա�Ÿ�����������ױݾ�	(37)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL37_2, 0), 13, 0), '-', ''), 13, '-')	--95.�������Ա�Ÿ�����������׼���	(37)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL38_1, 0), 13, 0), '-', ''), 13, '-')	--96.�������Դ����հ�ݾ�	        (38)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL38_2, 0), 13, 0), '-', ''), 13, '-')	--97.�������Դ����հ輼��	        (38)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL56_2, 0), 13, 0), '-', ''), 13, '-')	--98.��Ÿ�氨�������׸�����Ÿ����	(56)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL52_2, 0), 13, 0), '-', ''), 13, '-')	--99.���ڽŰ���������	            (52)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL55_2, 0), 13, 0), '-', ''), 13, '-')	--100.���ݿ���������ڰ�������	    (55)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(CASE
                                   WHEN SC.VAT_LEVIER_GB IN('2', '3') THEN t_TOT_REAL_VAT_AMOUNT
                                   ELSE SC.COL25
                                 END, 0), 15, 0), '-', ''), 15, '-')      --101.�����������Ҽ���                      NUMBER      15    [�������Ͽ������Ҽ���]
        || NVL(VAT_LEVIER_GB, '0')   --102.�Ϲݰ����ڱ��� CHAR    1 Not Null    [0 : ����ڴ����Ű�?�����ڰ� �ƴ� �Ϲ� �����]
        --|| '0'   --102.�Ϲݰ����ڱ��� CHAR    1 Not Null    [0 : ����ڴ����Ű�?�����ڰ� �ƴ� �Ϲ� �����]
        || '0'                       --103.����ȯ����ұ���    CHAR    1   [1:����ȯ�����, 0:�⺻��]
        || LPAD(REPLACE(LPAD(NVL(COL44_2, 0), 13, 0), '-', ''), 13, '-')	--104.���������ȯ���Լ���	            (44)	NUMBER	13 
        || LPAD(REPLACE(LPAD(NVL(COL67_1, 0), 13, 0), '-', ''), 13, '-')	--105.���ݸ����������������ݾ�	(67)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL67_2, 0), 13, 0), '-', ''), 13, '-')	--106.���ݸ���������������꼼��	(67)	NUMBER	13    
        || LPAD(REPLACE(LPAD(NVL(COL2_1, 0), 13, 0), '-', ''), 13, '-')	    --107.��ǥ�Ű����������ڹ���ݾ�	    (2)	    NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL2_2, 0), 13, 0), '-', ''), 13, '-')	    --108.��ǥ�Ű����������ڹ��༼��	    (2)	    NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL13_1, 0), 13, 0), '-', ''), 13, '-')	--109.���Ը����ڹ���ݾ�	            (13)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL13_2, 0), 13, 0), '-', ''), 13, '-')	--110.���Ը����ڹ��༼��	            (13)	NUMBER	13
        
        -- 2014.04.01 ���� -- 
        || CASE
             WHEN W_ISSUE_DATE_FR < TO_DATE('2014-01-01', 'YYYY-MM-DD') 
               THEN LPAD(REPLACE(LPAD(NVL(COL23_2, 0), 13, '0'), '-', ''), 13, '-')  -- 111.�����ݸ����ڳ���Ư�ʱⳳ�μ���. 
             ELSE LPAD(REPLACE(LPAD(NVL(SPECIAL_PAY_TAX_VAT, 0), 13, '0'), '-', ''), 13, '-')  -- 111.�����ڳ���Ư�ʱⳳ�μ���.  
            END  
        -- 2014.04.01 ���� -- 
        || CASE
             WHEN W_ISSUE_DATE_FR < TO_DATE('2014-01-01', 'YYYY-MM-DD') 
               THEN LPAD(REPLACE(LPAD(NVL(COL43_1, 0), 13, '0'), '-', ''), 13, '-')
             ELSE LPAD(REPLACE(LPAD(0, 13, '0'), '-', ''), 13, '-')
            END  -- 112.���԰����������Աݾ�.
        -- 2014.04.01 ���� -- 
        || CASE
             WHEN W_ISSUE_DATE_FR < TO_DATE('2014-01-01', 'YYYY-MM-DD') 
               THEN LPAD(REPLACE(LPAD(NVL(COL43_2, 0), 13, '0'), '-', ''), 13, '-')
             ELSE LPAD(REPLACE(LPAD(0, 13, '0'), '-', ''), 13, '-')
            END  -- 113.����.
        
        || LPAD(REPLACE(LPAD(NVL(COL60_1, 0), 13, 0), '-', ''), 13, '-')	--114.���ݰ�꼭�̹߱޵��ݾ�	    (60)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL60_2, 0), 13, 0), '-', ''), 13, '-')	--115.���ݰ�꼭�̹߱޵�꼼��	    (60)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL3_1, 0), 15, 0), '-', ''), 15, '-')	    --116.��ǥ�Ű��ſ�ī�����ݿ������ݾ�	(3)	    NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL3_2, 0), 15, 0), '-', ''), 15, '-')	    --117.��ǥ�Ű��ſ�ī�����ݿ���������	(3)	    NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL40_1, 0), 15, 0), '-', ''), 15, '-')	--118.���Խſ�����ڻ�ݾ�	            (40)	NUMBER	    15
        || LPAD(REPLACE(LPAD(NVL(COL40_2, 0), 15, 0), '-', ''), 15, '-')	--119.���Խſ�����ڻ꼼��	            (40)	NUMBER	    15       
        || LPAD(REPLACE(LPAD(NVL(COL53_2, 0), 13, 0), '-', ''), 13, '-')	--120.���ڼ��ݰ�꼭�߱޼��װ�������	(53)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL61_1, 0), 13, 0), '-', ''), 13, '-')	--121.���ڼ��ݰ�꼭�߱޸������۰���ݾ�_������15����	        (61)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL61_2, 0), 13, 0), '-', ''), 13, '-')	--122.���ڼ��ݰ�꼭�߱޸������۰��꼼��_������15����	        (61)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL71_3, 0), 13, 0), '-', ''), 13, '-')	--123.�鼼���Աݾ����ܱݾ�	                                    (71)	NUMBER	13   
        || LPAD(REPLACE(LPAD(NVL(COL62_1, 0), 13, 0), '-', ''), 13, '-')	--124.���ڼ��ݰ�꼭�߱޸������۰���ݾ�_�����Ⱓ������15����	(62)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL62_2, 0), 13, 0), '-', ''), 13, '-')	--125.���ڼ��ݰ�꼭�߱޸������۰��꼼��_�����Ⱓ������15����	(62)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL59_1, 0), 13, 0), '-', ''), 13, '-')	--126.���ݰ�꼭�����߱޵��ݾ�	(59)	NUMBER	13
        || LPAD(REPLACE(LPAD(NVL(COL59_2, 0), 13, 0), '-', ''), 13, '-')	--127.���ݰ�꼭�����߱޵�꼼��	(59)	NUMBER	13
        -- <2012��1�⿹�� �߰�>
        || CASE
             WHEN W_ISSUE_DATE_FR < TO_DATE('2014-01-01', 'YYYY-MM-DD') 
               THEN LPAD(REPLACE(LPAD(NVL(R_ORIGIN_PLACE_VAT, 0), 13, '0'), '-', ''), 13, '-')
             ELSE LPAD(REPLACE(LPAD(0, 13, '0'), '-', ''), 13, '-')
           END  -- 128.������Ȯ�μ��߱޼��װ���<2014.04.01����>.
        || LPAD(REPLACE(LPAD(NVL(A_TAX_RECEIVE_DELAY_AMT, 0), 13, '0'), '-', ''), 13, '-')  -- 129.���ݰ�꼭�������밡��ݾ�.
        || LPAD(REPLACE(LPAD(NVL(A_TAX_RECEIVE_DELAY_VAT, 0), 13, '0'), '-', ''), 13, '-')  -- 130.���ݰ�꼭�������밡�꼼��.
        -- 2013�⵵ 1�⿹�� �߰� --  
        || LPAD(REPLACE(LPAD(NVL(A_TAX_INV_SUM_BAD_AMT_1, 0), 15, '0'), '-', ''), 15, '-')  -- 131.���ݰ�꼭�հ�ǥ�������Ⱑ��ݾ�.   
        || LPAD(REPLACE(LPAD(NVL(A_TAX_INV_SUM_BAD_VAT_1, 0), 15, '0'), '-', ''), 15, '-') -- 132.���ݰ�꼭�հ�ǥ�������Ⱑ�꼼��.
        || LPAD(REPLACE(LPAD(NVL(A_REPORT_BAD_AMT_1, 0), 15, '0'), '-', ''), 15, '-') -- 133.�Ű��Ҽ��ǹ��Ű�(�Ϲ�)�ݾ�.
        || LPAD(REPLACE(LPAD(NVL(A_REPORT_BAD_VAT_1, 0), 15, '0'), '-', ''), 15, '-') -- 134.�Ű��Ҽ��ǹ��Ű�(�Ϲ�)����.
        || LPAD(REPLACE(LPAD(NVL(A_REPORT_BAD_AMT_2, 0), 15, '0'), '-', ''), 15, '-') -- 135.�Ű��Ҽ��ǹ��Ű�(�δ�)�ݾ�.
        || LPAD(REPLACE(LPAD(NVL(A_REPORT_BAD_VAT_2, 0), 15, '0'), '-', ''), 15, '-') -- 136.�Ű��Ҽ��ǹ��Ű�(�δ�)����.
        || LPAD(REPLACE(LPAD(NVL(A_REPORT_BAD_AMT_3, 0), 15, '0'), '-', ''), 15, '-') -- 137.�Ű��Ҽ��ǰ���/�ʰ�ȯ�޽Ű�(�Ϲ�)�ݾ�.
        || LPAD(REPLACE(LPAD(NVL(A_REPORT_BAD_VAT_3, 0), 15, '0'), '-', ''), 15, '-') -- 138.�Ű��Ҽ��ǰ���/�ʰ�ȯ�޽Ű�(�Ϲ�)����.
        || LPAD(REPLACE(LPAD(NVL(A_REPORT_BAD_AMT_4, 0), 15, '0'), '-', ''), 15, '-') -- 139.�Ű��Ҽ��ǰ���/�ʰ�ȯ�޽Ű�(�δ�)�ݾ�.
        || LPAD(REPLACE(LPAD(NVL(A_REPORT_BAD_VAT_4, 0), 15, '0'), '-', ''), 15, '-') -- 140.�Ű��Ҽ��ǰ���/�ʰ�ȯ�޽Ű�(�δ�)����.
        || LPAD(REPLACE(LPAD(NVL(A_REALTY_LEASE_UNREPORT_AMT, 0), 15, '0'), '-', ''), 15, '-') -- 141.�ε����Ӵ���ް��׸����� �Ҽ��ǰ���ݾ�.
        || LPAD(REPLACE(LPAD(NVL(A_REALTY_LEASE_UNREPORT_VAT, 0), 15, '0'), '-', ''), 15, '-') -- 142.�ε����Ӵ���ް��׸����� �Ҽ��ǰ��꼼��.
        
        -- 2014.1�⿹�� �߰� -- 
        ||  LPAD(REPLACE(LPAD(NVL(PROXY_PAY_TAX_VAT, 0), 13, '0'), '-', ''), 13, '-')  -- 143.���������� �븮���αⳳ�μ���.
        ||  LPAD(REPLACE(LPAD(NVL(E_FORE_TOUR_REFUND_VAT, 0), 13, '0'), '-', ''), 13, '-')  -- 144.�ܱ��ΰ������� ����ȯ�޼���.
        ||  LPAD(REPLACE(LPAD(NVL(A_MISS_DEAL_ACCOUNT_AMT, 0), 15, '0'), '-', ''), 15, '-')  -- 145.�����ڳ���Ư�ʰŷ����¹̻�밡���.
        ||  LPAD(REPLACE(LPAD(NVL(A_MISS_DEAL_ACCOUNT_VAT, 0), 15, '0'), '-', ''), 15, '-')  -- 146.�����ڳ���Ư�ʰŷ����¹̻�밡�꼼��.
        ||  LPAD(REPLACE(LPAD(NVL(A_DELAY_PAYMENT_AMT, 0), 15, '0'), '-', ''), 15, '-')  -- 147.�����ڳ���Ư�ʰŷ����������Աݰ���ݾ�.
        ||  LPAD(REPLACE(LPAD(NVL(A_DELAY_PAYMENT_VAT, 0), 15, '0'), '-', ''), 15, '-')  -- 141.�����ڳ���Ư�ʰŷ����������Աݰ��꼼��.
        || RPAD(' ', 81, ' ')  --128.����  CHAR    47
    INTO g_REPORT_CONTENT
    FROM FI_SURTAX_CARD SC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE       = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
        AND VAT_MAKE_GB = '01' --�Ű�����(01 : ����Ű�)
    ;


    --1-2. �ϹݽŰ��� ���ڵ�
    --���ĸ� : �Ϲݰ����� �ΰ���ġ�� �Ű���, File : �ΰ���ġ��_�Ϲ�, ���� : 1700
    
    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO g_SPEC_SERIAL FROM FI_VAT_E_FILE;

    INSERT INTO FI_VAT_E_FILE(
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�        
        , TAX_CODE      	--�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű��Ⱓ���й�ȣ
        , VAT_MAKE_GB	    --�Ű�����
        , SPEC_SERIAL	    --�Ϸù�ȣ

        , REPORT_DOC        --�Ű�������
        , REPORT_CONTENT    --�Ű�����
        
        , CREATION_DATE     --������
        , CREATED_BY	    --������
        , LAST_UPDATE_DATE  --������
        , LAST_UPDATED_BY	--������          
    )
    SELECT
          W_SOB_ID  --ȸ����̵�
        , W_ORG_ID  --����ξ��̵�
        , W_TAX_CODE                --�������̵�
        , W_VAT_MNG_SERIAL          --�ΰ����Ű��Ⱓ���й�ȣ
        , '01'	                    --�Ű�����
        , g_SPEC_SERIAL             --�Ϸù�ȣ 

        , '�ϹݽŰ��� ���ڵ�'       --�Ű�������
        , g_REPORT_CONTENT          --�Ű�����
        
        , g_SYSDATE     --������
        , W_CREATED_BY  --������
        , g_SYSDATE     --������
        , W_CREATED_BY  --������         
    FROM DUAL   ;



    --1-3. [�ΰ���ġ�����Աݾ׵�(����ǥ�ظ���, �鼼���Աݾ�)]�� �Ű����� ����
    --�ΰ���ġ���Ű���(�Ϲ�,����)�� ������ǥ�ظ�����,���鼼���Աݾס��� �Է��׸���Դϴ�.    

    SELECT
          COL26_3 --����ǥ��_�ݾ�1    ; ���Աݾ���������  : 1
        , COL27_3 --����ǥ��_�ݾ�2    ; ���Աݾ���������  : 1
        , COL28_3 --����ǥ��_�ݾ�3    ; ���Աݾ���������  : 1
        , COL29_3 --����ǥ��_�ݾ�4    ; ���Աݾ���������  : 2
        
        , COL19_2 --�ſ�ī�������ǥ����������    ; ���Աݾ���������  : 4
        , COL18_2 --��Ÿ�氨��������    ; ���Աݾ���������  : 7
        
        , COL69_3 --�鼼������Աݾ�_�ݾ�1    ; ���Աݾ���������  : 8
        , COL70_3 --�鼼������Աݾ�_�ݾ�2    ; ���Աݾ���������  : 8
        , COL71_3 --�鼼������Աݾ�_�ݾ�3    ; ���Աݾ���������  : E
    INTO t_COL26_3, t_COL27_3, t_COL28_3, t_COL29_3, t_COL19_2, t_COL18_2, t_COL69_3, t_COL70_3, t_COL71_3  
    FROM FI_SURTAX_CARD
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE       = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
        AND VAT_MAKE_GB = '01' --�Ű�����(01 : ����Ű�)
    ;    
    
    
    IF t_COL26_3 IS NOT NULL THEN
        INSERT_1_4(t_COL26_3, '1');
    END IF;
    
    IF t_COL27_3 IS NOT NULL THEN
        INSERT_1_4(t_COL27_3, '1');
    END IF;

    IF t_COL28_3 IS NOT NULL THEN
        INSERT_1_4(t_COL28_3, '1');
    END IF;

    IF t_COL29_3 IS NOT NULL AND t_COL29_3 != 0 THEN
        INSERT_1_4(t_COL29_3, '2');
    END IF;

    IF t_COL19_2 IS NOT NULL THEN
        INSERT_1_4(t_COL19_2, '4');
    END IF;

    IF t_COL18_2 IS NOT NULL THEN
        INSERT_1_4(t_COL18_2, '7');
    END IF;

    IF t_COL69_3 IS NOT NULL AND t_COL69_3 != 0 THEN
        INSERT_1_4(t_COL69_3, '8');
    END IF;

    IF t_COL70_3 IS NOT NULL AND t_COL70_3 != 0 THEN
        INSERT_1_4(t_COL70_3, '8');
    END IF;

    IF t_COL71_3 IS NOT NULL AND t_COL71_3 != 0 THEN
        INSERT_1_4(t_COL71_3, 'E');
    END IF;    

END IF; --IF t_E_FILE_SURTAX_YN = 'Y' THEN          --���ڽŰ����ϻ�����󿩺�_�ΰ����Ű���




--2.÷�μ���

IF t_E_FILE_ZERO_YN = 'Y' THEN          --���ڽŰ����ϻ�����󿩺�_������÷�μ������������

    --2-3.������÷�μ������������
    --���ĸ� : ������÷�μ������������ , File : ������÷�μ������������, ���� : 250
    
    FOR REC_2_3 IN (
        SELECT
               '17'                  --1.�ڷᱸ��		 CHAR	2
            || 'V106'                --2.�����ڵ�        CHAR	4 
            || ZERO_TAX_RATE_REASON  --3.��������ڵ�    CHAR	2            
            || RPAD(FI_COMMON_G.CODE_NAME_F('ZERO_TAX_RATE_REASON', ZERO_TAX_RATE_REASON, SOB_ID, ORG_ID), 60, ' ') --4.�������    CHAR    60
            || LPAD(ROWNUM, 6, 0)        --5.�Ϸù�ȣ    (9)     CHAR	6    
            || RPAD(DOC_NAME, 40, ' ')   --6.������	    (10)	CHAR	40
            || RPAD(PUBLISHER, 20, ' ')  --7.�߱���	    (11)	CHAR	20       
            || TO_CHAR(PUBLISH_DATE, 'YYYYMMDD')    --8.�߱�����	(12)	CHAR	8
            || TO_CHAR(SHIPPING_DATE, 'YYYYMMDD')   --9.��������	(13)	CHAR	8
            || CURRENCY_CODE             --10.������ȭ�ڵ�	(14)	CHAR	3    
            || LPAD(REPLACE(TO_CHAR(NVL(EXCHANGE_RATE, 0), 'FM99999.0000'), '.', ''), 9, 0)              --11.ȯ��	(15)	NUMBER	9,4    
            || CASE
                  WHEN NVL(SUBMIT_FOREIGN_AMT, 0) < 0 
                    THEN '-' || LPAD(REPLACE(TO_CHAR(ABS(NVL(SUBMIT_FOREIGN_AMT, 0)), 'FM9999999999999.00'), '.', ''), 14, 0)
                  ELSE LPAD(REPLACE(TO_CHAR(NVL(SUBMIT_FOREIGN_AMT, 0), 'FM9999999999999.00'), '.', ''), 15, 0)
               END  --12.�������ݾ�(��ȭ)	(16)	NUMBER	15,2
            || CASE
                  WHEN NVL(SUBMIT_KOREAN_AMT, 0) < 0 
                    THEN '-' || LPAD(ABS(NVL(SUBMIT_KOREAN_AMT, 0)), 14, 0)
                  ELSE LPAD(NVL(SUBMIT_KOREAN_AMT, 0), 15, 0)                                                    
               END  --13.�������ݾ�(��ȭ)	(17)	NUMBER	15    
            || CASE
                  WHEN NVL(REPORT_FOREIGN_AMT, 0) < 0
                    THEN '-' || LPAD(REPLACE(TO_CHAR(ABS(NVL(REPORT_FOREIGN_AMT, 0)), 'FM9999999999999.00'), '.', ''), 14, 0)  
                  ELSE LPAD(REPLACE(TO_CHAR(NVL(REPORT_FOREIGN_AMT, 0), 'FM9999999999999.00'), '.', ''), 15, 0)  
               END  --14,���Ű��ش��(��ȭ)	(18)	NUMBER	15,2
            || CASE
                  WHEN NVL(REPORT_KOREAN_AMT, 0) < 0 
                    THEN '-' || LPAD(ABS(NVL(REPORT_KOREAN_AMT, 0)), 14, 0)
                  ELSE LPAD(NVL(REPORT_KOREAN_AMT, 0), 15, 0)
               END  --15.���Ű��ش��(��ȭ)	(19)	NUMBER	15
            || RPAD(' ', 28, ' ')    --16.����		CHAR	28
            AS REC
        FROM
            (
                SELECT 
                      SOB_ID            --ȸ����̵�
                    , ORG_ID            --����ξ��̵�
                    , TAX_CODE          --�������̵�
                    , VAT_MNG_SERIAL    --�ΰ����Ű��Ⱓ���й�ȣ
                    , FI_VAT_REPORT_MNG_G.VAT_MNG_SERIAL_F(VAT_MNG_SERIAL) AS VAT_REPORT_NM   --�Ű��Ⱓ���и�
                    , ZERO_TAX_RATE_REASON  --�������
                    , SPEC_SERIAL           --�Ϸù�ȣ
                    , DOC_NAME              --������
                    , PUBLISHER             --�߱���
                    , PUBLISH_DATE          --�߱�����
                    , SHIPPING_DATE         --��������        
                    , CURRENCY_CODE         --��ȭ
                    , EXCHANGE_RATE         --ȯ��
                    , SUBMIT_FOREIGN_AMT    --��������ȭ
                    , SUBMIT_KOREAN_AMT     --��������ȭ
                    , REPORT_FOREIGN_AMT    --���Ű���ȭ
                    , REPORT_KOREAN_AMT     --���Ű���ȭ
                FROM FI_ZERO_TAX_SPEC
                WHERE SOB_ID = W_SOB_ID
                    AND ORG_ID = W_ORG_ID
                    AND TAX_CODE = W_TAX_CODE
                    AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
                ORDER BY PUBLISH_DATE, SHIPPING_DATE    
            ) T
    ) LOOP
            
        SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO g_SPEC_SERIAL FROM FI_VAT_E_FILE;

        INSERT INTO FI_VAT_E_FILE(
              SOB_ID	        --ȸ����̵�
            , ORG_ID	        --����ξ��̵�        
            , TAX_CODE      	--�������̵�
            , VAT_MNG_SERIAL	--�ΰ����Ű��Ⱓ���й�ȣ
            , VAT_MAKE_GB	    --�Ű�����
            , SPEC_SERIAL	    --�Ϸù�ȣ

            , REPORT_DOC        --�Ű�������
            , REPORT_CONTENT    --�Ű�����
            
            , CREATION_DATE     --������
            , CREATED_BY	    --������
            , LAST_UPDATE_DATE  --������
            , LAST_UPDATED_BY	--������          
        )
        SELECT
              W_SOB_ID  --ȸ����̵�
            , W_ORG_ID  --����ξ��̵�
            , W_TAX_CODE                --�������̵�
            , W_VAT_MNG_SERIAL          --�ΰ����Ű��Ⱓ���й�ȣ
            , '01'	                    --�Ű�����
            , g_SPEC_SERIAL             --�Ϸù�ȣ 

            , '������÷�μ������������'    --�Ű�������
            , REC_2_3.REC                   --�Ű�����
            
            , g_SYSDATE     --������
            , W_CREATED_BY  --������
            , g_SYSDATE     --������
            , W_CREATED_BY  --������         
        FROM DUAL   ;

    END LOOP REC_2_3;

END IF;    --IF t_E_FILE_ZERO_YN = 'Y' THEN          --���ڽŰ����ϻ�����󿩺�_������÷�μ������������




IF t_E_FILE_REAL_ESTATE_YN = 'Y' THEN   --���ڽŰ����ϻ�����󿩺�_�ε����Ӵ���ް��׸�����

    --2-7.�ε����Ӵ���ް��׸�����
    --���ĸ� : �ε����Ӵ���ް��׸����� , File : �ε����Ӵ���ް��׸�����, ���� : 250
    
    g_REPORT_CONTENT := NULL;
    
    SELECT
           '17'                 --1.�ڷᱸ��		CHAR	2
        || 'V120'               --2.�����ڵ�        CHAR	4 
        || '000001'             --3.�Ϸù�ȣ����	CHAR	6   [?	����ڴ����������������� �ƴ� ��� ��000001���� ����]
        || RPAD(' ', 70, ' ')   --4.�ε��������	CHAR	70  Null ���
        || LPAD(NVL(DEPOSIT, 0), 15, 0)     --5.�Ӵ��೻�뺸�����հ�	    NUMBER	15
        || LPAD(NVL(MONTH_RENT, 0), 15, 0)  --6.�Ӵ��೻��������հ�	    NUMBER	15
        || LPAD(NVL(RENT_SUM, 0), 15, 0)    --7.�Ӵ����Աݾ��հ�	        NUMBER	15
        || LPAD(NVL(DEEMED_RENT, 0), 15, 0) --8.�Ӵ����Ժ����������հ�	NUMBER	15
        || LPAD(NVL(TAX_MM_FEE, 0), 15, 0)  --9.�Ӵ����Կ������հ�	    NUMBER	15
        || t_VAT_NUMBER_10                  --10.�Ӵ��λ���ڵ�Ϲ�ȣ	    CHAR	10
        || LPAD((SELECT COUNT(*)
                FROM FI_BLD_AMT_SPEC
                WHERE SOB_ID = W_SOB_ID
                    AND ORG_ID = W_ORG_ID
                    AND TAX_CODE = W_TAX_CODE
                    AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL)
           , 6, 0) --11.�Ӵ�Ǽ�	NUMBER	6
        || '0000'   --12.��������Ϸù�ȣ	CHAR	4   [����ڴ����������������� �ƴ� ��졮0000��������]
        || RPAD(' ', 73, ' ')    --16.����		CHAR	73
        AS REC
    INTO g_REPORT_CONTENT
    FROM
        (
        SELECT
            --�Ӵ�����೻�� �հ�
              NVL(SUM(DEPOSIT), 0) AS DEPOSIT   --��೻��_������
            , NVL(SUM(MONTH_RENT), 0) + NVL(SUM(MONTN_FEE), 0) AS MONTH_RENT   --��೻��_������
            
            --����ǥ�� �հ�
            , NVL(SUM(DEEMED_RENT), 0) AS DEEMED_RENT   --���Աݾ�_����������
            , NVL(SUM(TERM_RENT), 0) + NVL(SUM(TERM_FEE), 0) AS TAX_MM_FEE  --���Աݾ�_������
            , NVL(SUM(DEEMED_RENT), 0) + NVL(SUM(TERM_RENT), 0) + NVL(SUM(TERM_FEE), 0) AS RENT_SUM --���Աݾ�_�հ�(����ǥ��)          
        FROM FI_BLD_AMT_SPEC
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND TAX_CODE = W_TAX_CODE
            AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL 
        )   ;
        
    INSERT_VAT_E_FILE('�ε����Ӵ���ް��׸�����', g_REPORT_CONTENT);


    --���ĸ� : �ε����Ӵ���ް��׸����� , File : �ε����Ӵ���ް��׸���������, ���� : 250
    
    FOR REC_2_7 IN (
        SELECT
               '18'     --1.�ڷᱸ��		CHAR	2
            || 'V120'   --2.�����ڵ�        CHAR	4 
            || '000001' --3.�Ϸù�ȣ����	CHAR	6   [����ڴ����������������� �ƴ� ��� ��000001���� ����]
            || LPAD(ROWNUM, 6, '0')             --4.�Ϸù�ȣ	        CHAR	6
            || RPAD( CASE
                       WHEN VAT_GROUND_YN = '02' THEN 'B'
                       ELSE ''
                     END || BLD_FLOOR, 10, ' ')         --5.��	                CHAR	10
            || RPAD(NVL(ROOM, ' '), 10, ' ')    --6.ȣ��	            CHAR	10  Null ���
            || RPAD(LEND_AREA, 10, ' ')         --7.����	            CHAR	10
            || RPAD(CORP_NAME, 30, ' ')         --8.�����λ�ȣ(����)    CHAR	30
            || RPAD(REPLACE(VAT_NUMBER, '-', ''), 13, ' ')  --9.�����λ���ڵ�Ϲ�ȣ 	CHAR	13
            || TO_CHAR(IN_DATE, 'YYYYMMDD')     --10.�Ӵ���������	            CHAR	8   Null ���
            || TO_CHAR(OUT_DATE, 'YYYYMMDD')    --11.�Ӵ��������	            CHAR	8   Null ���
            || LPAD(DEPOSIT, 13, 0)             --12.�Ӵ��೻�뺸����	        NUMBER	13
            || LPAD(MM_FEE, 13, 0)              --13.�Ӵ��೻����Ӵ��	    NUMBER	13
            || LPAD(RENT_SUM, 13, 0)            --14.�Ӵ����Աݾװ�(����ǥ��)	NUMBER	13
            || LPAD(DEEMED_RENT, 13, 0)         --15.�Ӵ�Ẹ��������	        NUMBER	13
            || LPAD(TAX_MM_FEE, 13, 0)          --16.�Ӵ����Աݾ׿��Ӵ��	    NUMBER	13
--            || DECODE(VAT_GROUND_YN, '01', 'N', '02', 'Y')  --17.���Ͽ���	CHAR	1   [Y : ����,  N : ����]
            || ' '                              --17.���Ͽ���	null.
            || '0000'   --18.��������Ϸù�ȣ	CHAR	4   [����ڴ����������������� �ƴ� ��졮0000��������]
            || RPAD(SUBSTR(NVL(ADDRESS, ' '), 1, 30), 30, ' ')          --19.��	    CHAR	30  Null ���
            || RPAD(NVL(TO_CHAR(MODIFY_DATE, 'YYYYMMDD'), ' '), 8, ' ') --20.������	CHAR	8   Null ���    
            || RPAD(' ', 35, ' ')   --21.����	CHAR	35
            AS REC
        FROM
            (
                SELECT
                      SOB_ID	        --ȸ����̵�
                    , ORG_ID	        --����ξ��̵�
                    , TAX_CODE      	--�������̵�
                    , VAT_MNG_SERIAL	--�ΰ����Ű��Ⱓ���й�ȣ
                    , FI_VAT_REPORT_MNG_G.VAT_MNG_SERIAL_F(VAT_MNG_SERIAL) AS VAT_REPORT_NM   --�Ű��Ⱓ���и�
                    , SPEC_SERIAL	    --�Ϸù�ȣ
                    
                    --�Ӵ����
                    , ADDRESS	        --��
                    , REAL_ESTATE_LOC	--�ε�����ġ    
                    , VAT_GROUND_YN	    --����_���Ͽ����ڵ�
                    , FI_COMMON_G.CODE_NAME_F('VAT_GROUND_YN', VAT_GROUND_YN, SOB_ID, ORG_ID) AS VAT_GROUND_YN_NM     --����_���Ͽ���
                    , BLD_FLOOR	--��
                    , ROOM	    --ȣ     
                    , LEND_AREA	--�Ӵ����
                    , PURPOSE	--�뵵
                    
                    --�������������� �� �Ӵ�����೻��
                    , CORP_NAME	    --��ü ��ȣ
                    , VAT_NUMBER	--����ڵ�Ϲ�ȣ
                    , IN_DATE	    --�Ӵ�Ⱓ_������
                    , OUT_DATE	    --�Ӵ�Ⱓ_�����    
                    , MODIFY_DATE	--������
                    
                    , DEPOSIT	    --������
                    , MONTH_RENT	--����
                    , MONTN_FEE	    --��������
                    , NVL(MONTH_RENT, 0) + NVL(MONTN_FEE, 0) AS MM_FEE --���Ӵ��
                    
                    --�Ӵ����Աݾ�(����ǥ��)
                    , DEEMED_RENT	--����������(�����Ӵ��)
                    , TERM_RENT	    --�Ӵ�Ⱓ_�Ӵ��
                    , TERM_FEE	    --�Ӵ�Ⱓ_������
                    , NVL(TERM_RENT, 0) + NVL(TERM_FEE, 0) AS TAX_MM_FEE                        --���Ӵ��(��)
                    , NVL(DEEMED_RENT, 0) + NVL(TERM_RENT, 0) + NVL(TERM_FEE, 0) AS RENT_SUM    --�հ�
                FROM FI_BLD_AMT_SPEC
                WHERE SOB_ID = W_SOB_ID
                    AND ORG_ID = W_ORG_ID
                    AND TAX_CODE = W_TAX_CODE
                    AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
                ORDER BY SPEC_SERIAL    
            )
    ) LOOP
    
        INSERT_VAT_E_FILE('�ε����Ӵ���ް��׸���������', REC_2_7.REC);

    END LOOP REC_2_7;


END IF; --IF t_E_FILE_REAL_ESTATE_YN = 'Y' THEN   --���ڽŰ����ϻ�����󿩺�_�ε����Ӵ���ް��׸�����


-- 2013.10. 15 ��ȣ�� �߰� : �Ѱ����λ���� ����
-- ����庰 �ΰ���ġ������ǥ�� �� ���μ���(ȯ�޼���) �Ű������� -- 
-- �Ѱ����λ����(��) ������� ��츸 ���� -- 
    FOR REC_2_10 IN ( SELECT SC.SOB_ID
                           , SC.ORG_ID
                           , SC.TAX_CODE
                           , SC.VAT_MNG_SERIAL
                           , SC.VAT_LEVIER_GB
                           , VRM.FY
                           , VRM.VAT_REPORT_TURN
                           , VRM.VAT_REPORT_GB
                        FROM FI_SURTAX_CARD    SC
                           , FI_VAT_REPORT_MNG VRM
                       WHERE  SC.TAX_CODE             = VRM.TAX_CODE
                          AND SC.VAT_MNG_SERIAL       = VRM.VAT_MNG_SERIAL
                          AND SC.SOB_ID               = VRM.SOB_ID
                          AND SC.ORG_ID               = VRM.ORG_ID
                          AND SC.SOB_ID               = W_SOB_ID  --ȸ����̵�
                          AND SC.ORG_ID               = W_ORG_ID  --����ξ��̵�    
                          AND SC.TAX_CODE             = W_TAX_CODE
                          AND SC.VAT_MNG_SERIAL       = W_VAT_MNG_SERIAL
                          AND SC.VAT_MAKE_GB          = '01'         --�Ű�����(01 : ����Ű�)
                          AND SC.VAT_LEVIER_GB        = '2'          -- �Ѱ����λ����(��)�����    
                    )
    LOOP
      -- 10.1 ����庰 �ΰ���ġ������ǥ�� �� ���μ���(ȯ�޼���) �Ű�������  
      FOR REC_2_10_1 IN 
            ( SELECT '17'     --1.�ڷᱸ��		CHAR	2
                  || 'V115'   --2.�����ڵ�        CHAR	4 
                  || LPAD(REPLACE(LPAD(NVL(COL1_1, 0), 15, '0'), '-', ''), 15, '-')   -- ���� �����ݾ�  
                  || LPAD(REPLACE(LPAD(NVL(COL1_2, 0), 15, '0'), '-', ''), 15, '-')   -- ���� ��������
                  || LPAD(REPLACE(LPAD(NVL(COL5_1, 0), 15, 0), '-', ''), 15, '-')     -- ���� �����ݾ�  
                  || LPAD(REPLACE(LPAD(NVL(COL5_2, 0), 15, 0), '-', ''), 15, '-')     -- ���� �������� 
                  || LPAD(REPLACE(LPAD(NVL(COL17_1, 0), 15, 0), '-', ''), 15, '-')    -- ���� �����ݾ� 
                  || LPAD(REPLACE(LPAD(NVL(COL17_2, 0), 15, 0), '-', ''), 15, '-')    -- ���� �������� 
                  || LPAD(REPLACE(LPAD(NVL(COL41_1, 0), 15, 0), '-', ''), 15, '-')    -- ���� �����ݾ�  
                  || LPAD(REPLACE(LPAD(NVL(COL41_2, 0), 15, 0), '-', ''), 15, '-')    -- ���� ��������  
                  || LPAD(REPLACE(LPAD(NVL(COL24_2, 0), 15, 0), '-', ''), 15, '-')    -- ���꼼   
                  || LPAD(REPLACE(LPAD(NVL(COL20_2, 0), 15, 0), '-', ''), 15, '-')    -- �����հ� 
                  || LPAD(REPLACE(LPAD(NVL(COL25, 0), 15, 0), '-', ''), 15, '-')      -- ����(ȯ��)�����հ�   
                  || LPAD(REPLACE(LPAD(NVL(OUT_AMOUNT, 0), 15, 0), '-', ''), 15, '-') -- ���ΰŷ�(�ǸŸ���)������հ�    
                  || LPAD(REPLACE(LPAD(NVL(IN_AMOUNT, 0), 15, 0), '-', ''), 15, '-')  -- ���ΰŷ�(�ǸŸ���)���Ծ��հ�    
                  || RPAD(' ', 99, ' ')   --21.����	CHAR	35
                     AS REC
                FROM (SELECT SUM(NVL(SC.COL1_1 , 0) + NVL(SC.COL2_1, 0) + NVL(SC.COL3_1, 0) + NVL(SC.COL4_1, 0)) AS COL1_1   -- ���� �����ݾ�  
                           , SUM(NVL(SC.COL1_2 , 0) + NVL(SC.COL2_2, 0) + NVL(SC.COL3_2, 0) + NVL(SC.COL4_2, 0)) AS COL1_2   -- ���� ��������  
                           , SUM(NVL(SC.COL5_1  , 0) + NVL(SC.COL6_1 , 0)) AS COL5_1     -- ���� �����ݾ�  
                           , 0 AS COL5_2                                                 -- ���� ��������  
                           , SUM(NVL(SC.COL17_1, 0)) AS COL17_1                          -- ���� �����ݾ�  
                           , SUM(NVL(SC.COL17_2, 0)) AS COL17_2                          -- ���� ��������  
                           , SUM(NVL(SC.COL41_1, 0)) AS COL41_1                          -- ���� �����ݾ�  
                           , SUM(NVL(SC.COL41_2, 0)) AS COL41_2                          -- ���� ��������  
                           , SUM(NVL(SC.COL24_2, 0)) AS COL24_2                          -- ���꼼  
                           , SUM(NVL(SC.COL20_2, 0)) AS COL20_2                          -- �����հ� 
                           , SUM(NVL(SC.COL25, 0)) AS COL25                              -- ����(ȯ��)�����հ�  
                           , 0 AS OUT_AMOUNT                                             -- ���ΰŷ�(�ǸŸ���)������հ�    
                           , 0 AS IN_AMOUNT                                              -- ���ΰŷ�(�ǸŸ���)���Ծ��հ�  
                        FROM FI_SURTAX_CARD    SC
                           , FI_VAT_REPORT_MNG VRM
                       WHERE  SC.VAT_MNG_SERIAL       = VRM.VAT_MNG_SERIAL
                          AND SC.SOB_ID               = REC_2_10.SOB_ID  --ȸ����̵�
                          AND SC.ORG_ID               = REC_2_10.ORG_ID  --����ξ��̵�    
                          AND SC.LAST_FLAG            = 'Y'
                          AND SC.VAT_LEVIER_GB        IN('2', '3')       -- �Ѱ�����(��),(��) �����  
                          AND EXISTS
                                (SELECT 'X'
                                   FROM FI_VAT_REPORT_MNG RM
                                  WHERE RM.SOB_ID            = VRM.SOB_ID
                                    AND RM.ORG_ID            = VRM.ORG_ID
                                    AND RM.FY                = VRM.FY
                                    AND RM.VAT_REPORT_TURN   = VRM.VAT_REPORT_TURN
                                    AND RM.VAT_REPORT_GB     = VRM.VAT_REPORT_GB
                                    AND RM.TAX_CODE          = REC_2_10.TAX_CODE
                                    AND RM.VAT_MNG_SERIAL    = REC_2_10.VAT_MNG_SERIAL
                                )
                     )
            )   
      LOOP
        INSERT_VAT_E_FILE('����庰�ΰ���ġ������ǥ�ع׳��μ���(ȯ�޼���)�Ű�������', REC_2_10_1.REC);
      END LOOP REC_2_10_1;
      
      -- �� ���� ���� --
      FOR REC_2_10_1 IN 
            ( SELECT '18'     --1.�ڷᱸ��		CHAR	2
                  || 'V115'   --2.�����ڵ�        CHAR	4 
                  || RPAD(REPLACE(NVL(TITLE_4, ' '), '-', ''), 10, ' ')  -- ����ڵ�Ϲ�ȣ 
                  || RPAD(NVL(TITLE_9, ' '), 70, ' ')                    -- ����ڼ����� 
                  || LPAD(REPLACE(LPAD(NVL(COL1_1, 0), 15, '0'), '-', ''), 15, '-')   -- ���� �����ݾ�  
                  || LPAD(REPLACE(LPAD(NVL(COL1_2, 0), 13, '0'), '-', ''), 13, '-')   -- ���� ��������                          
                  || LPAD(REPLACE(LPAD(NVL(COL5_1, 0), 15, '0'), '-', ''), 15, '-')   -- ���� �����ݾ�  
                  || LPAD(REPLACE(LPAD(NVL(COL5_2, 0), 13, '0'), '-', ''), 13, '-')   -- ���� ��������  
                  || LPAD(REPLACE(LPAD(NVL(COL17_1, 0), 15, '0'), '-', ''), 15, '-')  -- ���� �����ݾ�  
                  || LPAD(REPLACE(LPAD(NVL(COL17_2, 0), 13, '0'), '-', ''), 13, '-')  -- ���� ��������  
                  || LPAD(REPLACE(LPAD(NVL(COL41_1, 0), 15, '0'), '-', ''), 15, '-')  -- ���� �����ݾ�  
                  || LPAD(REPLACE(LPAD(NVL(COL41_2, 0), 13, '0'), '-', ''), 13, '-')  -- ���� ��������  
                  || LPAD(REPLACE(LPAD(NVL(COL24_2, 0), 13, '0'), '-', ''), 13, '-')  -- ���꼼  
                  || LPAD(REPLACE(LPAD(NVL(COL20_2, 0), 15, '0'), '-', ''), 15, '-')  -- �����հ�  
                  || LPAD(REPLACE(LPAD(NVL(COL25, 0), 15, '0'), '-', ''), 15, '-')    -- ����(ȯ��)�����հ�    
                  || LPAD(REPLACE(LPAD(NVL(OUT_AMOUNT, 0), 15, '0'), '-', ''), 15, '-') -- ���ΰŷ�(�ǸŸ���)������հ�    
                  || LPAD(REPLACE(LPAD(NVL(IN_AMOUNT, 0), 15, '0'), '-', ''), 15, '-')  -- ���ΰŷ�(�ǸŸ���)���Ծ��հ�     
                  || RPAD(' ', 29, ' ')   --18.����	CHAR	
                     AS REC
                FROM (SELECT SC.TITLE_4  -- ����ڵ�Ϲ�ȣ  
                           , SC.TITLE_9  -- ����� �ּ�  
                           , (NVL(SC.COL1_1 , 0) + NVL(SC.COL2_1, 0) + NVL(SC.COL3_1, 0) + NVL(SC.COL4_1, 0)) AS COL1_1   -- ���� �����ݾ�  
                           , (NVL(SC.COL1_2 , 0) + NVL(SC.COL2_2, 0) + NVL(SC.COL3_2, 0) + NVL(SC.COL4_2, 0)) AS COL1_2   -- ���� ��������  
                           , (NVL(SC.COL5_1  , 0) + NVL(SC.COL6_1 , 0)) AS COL5_1     -- ���� �����ݾ�  
                           , 0 AS COL5_2                                              -- ���� ��������  
                           , (NVL(SC.COL17_1, 0)) AS COL17_1                          -- ���� �����ݾ�  
                           , (NVL(SC.COL17_2, 0)) AS COL17_2                          -- ���� ��������  
                           , (NVL(SC.COL41_1, 0)) AS COL41_1                          -- ���� �����ݾ�  
                           , (NVL(SC.COL41_2, 0)) AS COL41_2                          -- ���� ��������  
                           , (NVL(SC.COL24_2, 0)) AS COL24_2                          -- ���꼼  
                           , (NVL(SC.COL20_2, 0)) AS COL20_2                          -- �����հ� 
                           , (NVL(SC.COL25, 0)) AS COL25                              -- ����(ȯ��)�����հ�  
                           , 0 AS OUT_AMOUNT                                             -- ���ΰŷ�(�ǸŸ���)������հ�    
                           , 0 AS IN_AMOUNT                                              -- ���ΰŷ�(�ǸŸ���)���Ծ��հ�  
                        FROM FI_SURTAX_CARD    SC
                           , FI_VAT_REPORT_MNG VRM
                       WHERE  SC.VAT_MNG_SERIAL       = VRM.VAT_MNG_SERIAL
                          AND SC.SOB_ID               = REC_2_10.SOB_ID  --ȸ����̵�
                          AND SC.ORG_ID               = REC_2_10.ORG_ID  --����ξ��̵�    
                          AND SC.LAST_FLAG            = 'Y'
                          AND SC.VAT_LEVIER_GB        IN('2', '3')       -- �Ѱ�����(��),(��) �����  
                          AND EXISTS
                                (SELECT 'X'
                                   FROM FI_VAT_REPORT_MNG RM
                                  WHERE RM.SOB_ID            = VRM.SOB_ID
                                    AND RM.ORG_ID            = VRM.ORG_ID
                                    AND RM.FY                = VRM.FY
                                    AND RM.VAT_REPORT_TURN   = VRM.VAT_REPORT_TURN
                                    AND RM.VAT_REPORT_GB     = VRM.VAT_REPORT_GB
                                    AND RM.TAX_CODE          = REC_2_10.TAX_CODE
                                    AND RM.VAT_MNG_SERIAL    = REC_2_10.VAT_MNG_SERIAL
                                )
                     )
            )   
      LOOP
        INSERT_VAT_E_FILE('����庰�ΰ���ġ������ǥ�ع׳��μ���(ȯ�޼���)�Ű������� ���γ���', REC_2_10_1.REC);
      END LOOP REC_2_10_1;
    END LOOP REC_2_10;



IF t_E_FILE_BLD_YN = 'Y' THEN           --���ڽŰ����ϻ�����󿩺�_�ǹ�������ڻ���������

    --2-11.�ǹ�������ڻ���������
    --���ĸ� : �ǹ�������ڻ��������� , File : �ǹ�������ڻ���������, ���� : 200

    FOR REC_2_11 IN (
        SELECT
              9 AS DPR_ASSET_GB_ID  --[9]�� UNION ALL �� ������ �����ϱ� ���� ������ ���ڸ� �� ������ ���ٸ� �ǹ� ����.
            , 5 AS SEQ   --�������� �������ڻ����� ��ȣ
            , ' ��                      ��' AS DPR_ASSET_GB   --�������ڻ�����
            , TO_NUMBER(DECODE(SUM(ASSET_CNT), 0, NULL, SUM(ASSET_CNT))) AS ASSET_CNT       --�Ǽ�
            , TO_NUMBER(DECODE(SUM(SUP_AMOUNT), 0, NULL, SUM(SUP_AMOUNT))) AS SUP_AMOUNT    --���ް���
            , TO_NUMBER(DECODE(SUM(SURTAX), 0, NULL, SUM(SURTAX))) AS SURTAX                --�ΰ���         
        FROM FI_DPR_SPEC A
            , FI_SLIP_LINE B
            , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) C  --�ŷ�ó
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID     
            AND A.SLIP_LINE_ID = B.SLIP_LINE_ID
            AND B.MANAGEMENT2 = W_TAX_CODE           --�����
            AND B.MANAGEMENT1 = C.SUPP_CUST_CODE(+)
            --AND TO_DATE(B.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630') --�Ű���������
            AND TO_DATE(B.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO --�Ű���������

        UNION ALL

        SELECT
              A.DPR_ASSET_GB_ID
            , DECODE(A.DPR_ASSET_GB_ID, '1669', 6, '1670', 7, '1671', 8, '1672', 9) AS SEQ   --�������� �������ڻ����� ��ȣ
            , A.DPR_ASSET_GB    --�������ڻ�����
            , TO_NUMBER(DECODE(B.ASSET_CNT, 0, NULL, B.ASSET_CNT)) AS ASSET_CNT     --�Ǽ�
            , TO_NUMBER(DECODE(B.SUP_AMOUNT, 0, NULL, B.SUP_AMOUNT)) AS SUP_AMOUNT  --���ް���
            , TO_NUMBER(DECODE(B.SURTAX, 0, NULL, B.SURTAX)) AS SURTAX              --�ΰ���
        FROM
            (
                SELECT 
                      COMMON_ID AS DPR_ASSET_GB_ID  --�ǹ��������������_�ڻ걸�о��̵�
                    , VALUE1 AS DPR_ASSET_GB        --�������ڻ�����
                FROM FI_COMMON
                WHERE GROUP_CODE = 'DPR_ASSET_GB'
            ) A
            ,
            (
                SELECT 
                      DPR_ASSET_GB_ID               --�ǹ��������������_�ڻ걸�о��̵�
                    , NVL(SUM(ASSET_CNT), 0) AS ASSET_CNT   --�Ǽ�
                    , NVL(SUM(SUP_AMOUNT), 0) AS SUP_AMOUNT --���ް���
                    , NVL(SUM(SURTAX), 0) AS SURTAX         --�ΰ���
                FROM FI_DPR_SPEC A
                    , FI_SLIP_LINE B
                    , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) C  --�ŷ�ó
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID     
                    AND A.SLIP_LINE_ID = B.SLIP_LINE_ID
                    AND B.MANAGEMENT2 = W_TAX_CODE          --�����
                    AND B.MANAGEMENT1 = C.SUPP_CUST_CODE(+)
                    --AND TO_DATE(B.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630') --�Ű���������
                    AND TO_DATE(B.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO --�Ű���������
                GROUP BY DPR_ASSET_GB_ID
            ) B
        WHERE A.DPR_ASSET_GB_ID = B.DPR_ASSET_GB_ID(+)
        ORDER BY DPR_ASSET_GB_ID
    ) LOOP
     
        IF REC_2_11.SEQ  = 5 THEN   --��                      ��
            t_5_CNT := REC_2_11.ASSET_CNT;
            t_5_AMT := REC_2_11.SUP_AMOUNT;
            t_5_TAX := REC_2_11.SURTAX;
        ELSIF REC_2_11.SEQ  = 6 THEN --(1) ��  �� . ��  ��  ��
            t_6_CNT := REC_2_11.ASSET_CNT;
            t_6_AMT := REC_2_11.SUP_AMOUNT;
            t_6_TAX := REC_2_11.SURTAX;        
        ELSIF REC_2_11.SEQ  = 7 THEN --(2) ��    ��    ��    ġ
            t_7_CNT := REC_2_11.ASSET_CNT;
            t_7_AMT := REC_2_11.SUP_AMOUNT;
            t_7_TAX := REC_2_11.SURTAX;        
        ELSIF REC_2_11.SEQ  = 8 THEN --(3) ��  ��   ��  ��  ��
            t_8_CNT := REC_2_11.ASSET_CNT;
            t_8_AMT := REC_2_11.SUP_AMOUNT;
            t_8_TAX := REC_2_11.SURTAX;        
        ELSIF REC_2_11.SEQ  = 9 THEN --(4) ��Ÿ�������ڻ�
            t_9_CNT := REC_2_11.ASSET_CNT;
            t_9_AMT := REC_2_11.SUP_AMOUNT;
            t_9_TAX := REC_2_11.SURTAX;        
        END IF;
                
    END LOOP REC_2_11;
    


 
    g_REPORT_CONTENT := NULL;
    
    SELECT
           '17'                         --1.�ڷᱸ��		        CHAR	2
        || 'V149'                       --2.�����ڵ�                CHAR	4 
        || LPAD(NVL(t_5_CNT, 0), 11, 0) --3.�Ǽ�_�հ�_�����ڻ�	    NUMBER	11
        || LPAD(NVL(t_5_AMT, 0), 13, 0) --4.���ް���_�հ�_�����ڻ�	NUMBER	13
        || LPAD(NVL(t_5_TAX, 0), 13, 0) --5.����_�հ�_�����ڻ�	    NUMBER	13        
        || LPAD(NVL(t_6_CNT, 0), 11, 0) --6.�Ǽ�_�ǹ�_���๰	    NUMBER	11
        || LPAD(NVL(t_6_AMT, 0), 13, 0) --7.���ް���_�ǹ�_���๰	NUMBER	13
        || LPAD(NVL(t_6_TAX, 0), 13, 0) --8.����_�ǹ�_���๰	    NUMBER	13        
        || LPAD(NVL(t_7_CNT, 0), 11, 0) --9.�Ǽ�_�����ġ	        NUMBER	11
        || LPAD(NVL(t_7_AMT, 0), 13, 0) --10.���ް���_�����ġ	    NUMBER	13
        || LPAD(NVL(t_7_TAX, 0), 13, 0) --11.����_�����ġ	        NUMBER	13        
        || LPAD(NVL(t_8_CNT, 0), 11, 0) --12.�Ǽ�_������ݱ�	    NUMBER	11
        || LPAD(NVL(t_8_AMT, 0), 13, 0) --13.���ް���_������ݱ�	NUMBER	13
        || LPAD(NVL(t_8_TAX, 0), 13, 0) --14.����_������ݱ�	    NUMBER	13        
        || LPAD(NVL(t_9_CNT, 0), 11, 0) --15.�Ǽ�_��Ÿ������	    NUMBER	11
        || LPAD(NVL(t_9_AMT, 0), 13, 0) --16.���ް���_��Ÿ������	NUMBER	13
        || LPAD(NVL(t_9_TAX, 0), 13, 0) --17.����_��Ÿ������	    NUMBER	13
        || RPAD(' ', 9, ' ')            --18.����		            CHAR	9
        AS REC
    INTO g_REPORT_CONTENT
    FROM DUAL ;
        
    INSERT_VAT_E_FILE('�ǹ�������ڻ���������', g_REPORT_CONTENT);    


END IF; --IF t_E_FILE_BLD_YN = 'Y' THEN           --���ڽŰ����ϻ�����󿩺�_�ǹ�������ڻ���������



IF t_E_FILE_RECYCLING_ETC_YN = 'Y' THEN  -- 5) ��Ȱ�����ڿ� �� �߰��ڵ��� ���Լ��װ����Ű��� 
  
    --5-1.��Ȱ�����ڿ� �� �߰��ڵ��� ���Լ��װ����Ű��� 
    --���ĸ� : ��Ȱ�����ڿ� �� �߰��ڵ��� ���Լ��װ����Ű���  , File : ��Ȱ�����ڿ� �� �߰��ڵ��� ���Լ��װ����Ű��� , ���� : 400
    FOR REC_1 IN (SELECT '17'  --1.�ڷᱸ��	CHAR	2
                      || 'V147'   --2.�����ڵ�	CHAR	4
                      || LPAD(NVL(T1.TOT_SUPPLIER_COUNT, 0), 7, 0)  --3.����ó�� �հ� 
                      || LPAD(NVL(T1.TOT_VAT_COUNT, 0), 11, 0)    --4.�Ǽ� - �հ� 
                      || LPAD(REPLACE(LPAD(NVL(T1.TOT_ITEM_AMOUNT, 0), 15, '0'), '-', ''), 15, '-') --5.���ݾ� �հ� 	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.TOT_DEEMED_VAT_AMOUNT, 0), 15, '0'), '-', ''), 15, '-')  --6.���Լ��װ����� �հ� 	NUMBER	15
                      || LPAD(NVL(T1.SUPPLIER_COUNT_10, 0), 6, 0)  --7.����ó�� ������ 
                      || LPAD(NVL(T1.VAT_COUNT_10, 0), 11, 0)    --8.�Ǽ� - ������ 
                      || LPAD(REPLACE(LPAD(NVL(T1.ITEM_AMONT_10, 0), 15, '0'), '-', ''), 15, '-') --9.���ݾ� ������ 	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.DEEMED_VAT_AMOUNT_10, 0), 15, '0'), '-', ''), 15, '-')  --10.���Լ��װ����� ������ 	NUMBER	15
                      || LPAD(NVL(T1.SUPPLIER_COUNT_20, 0), 6, 0)  --11.����ó�� ��꼭  
                      || LPAD(NVL(T1.VAT_COUNT_20, 0), 11, 0)    --12.�Ǽ� - ��꼭 
                      || LPAD(REPLACE(LPAD(NVL(T1.ITEM_AMONT_20, 0), 15, '0'), '-', ''), 15, '-') --13.���ݾ� ��꼭 	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.DEEMED_VAT_AMOUNT_20, 0), 15, '0'), '-', ''), 15, '-')  --14.���Լ��װ����� ������ 	NUMBER	15
                      
                      || LPAD(REPLACE(LPAD(NVL(T1.SALES_SUM_AMOUNT, 0), 15, '0'), '-', ''), 15, '-')  --15.�հ� - ����� 	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.SALES_PRE_AMOUNT, 0), 15, '0'), '-', ''), 15, '-')  --16.������ - ���� 	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.SALES_FIX_AMOUNT, 0), 15, '0'), '-', ''), 15, '-')  --17.Ȯ���� - ���� 	NUMBER	15
                      
                      || LPAD(REPLACE(TO_CHAR(NVL(T1.LIMIT_RATE, 0), 'FM999.00'), '.', ''), 5, '0')  --18.�ѵ���	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.LIMIT_AMOUNT, 0), 15, '0'), '-', ''), 15, '-')  --19.�ѵ���	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.PURCHASES_SUM_AMOUNT, 0), 15, '0'), '-', ''), 15, '-')  --20.�հ�-�����Ծ�	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.PURCHASES_TAX_BILL_AMOUNT, 0), 15, '0'), '-', ''), 15, '-')  --21.���ݰ�꼭-�����Ծ� 	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.PURCHASES_BILL_AMOUNT, 0), 15, '0'), '-', ''), 15, '-')  --22.�������� �����Ծ� 	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.DED_RANGE_AMOUNT, 0), 15, '0'), '-', ''), 15, '-')  --23.���������ѱݾ� 	NUMBER	15
                      
                      || LPAD(REPLACE(LPAD(NVL(T1.DED_RATE_NUMERATOR, 0), 5, '0'), '-', ''), 5, '-')  --24.������ ���� 	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.DED_RATE_DENOMINATOR, 0), 5, '0'), '-', ''), 5, '-')  --25.������ �и� 	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.DED_TARGET_AMOUNT, 0), 15, '0'), '-', ''), 15, '-')  --26.�������ݾ� 	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.DED_VAT_AMOUNT, 0), 13, '0'), '-', ''), 13, '-')  --27.������󼼾� 	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.DED_PRE_VAT_AMOUNT, 0), 13, '0'), '-', ''), 13, '-')  --28.�հ� ������������ 	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.DED_PRE_QUARTER_AMOUNT, 0), 13, '0'), '-', ''), 13, '-')  --29.�����Ű��� �������� ����	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.DED_PRE_MONTHLY_AMOUNT, 0), 13, '0'), '-', ''), 13, '-')  --30.��������� ������������	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.FIX_VAT_AMOUNT, 0), 13, '0'), '-', ''), 13, '-')  --31.����(����)�Ҽ���	NUMBER	15
                      
                      || RPAD(' ', 37, ' ')   --13.����	CHAR	48
                         AS REC
                    FROM (SELECT SX1.TOT_SUPPLIER_COUNT
                               , SX1.TOT_VAT_COUNT
                               , SX1.TOT_ITEM_AMOUNT
                               , SX1.TOT_DEEMED_VAT_AMOUNT
                               , SX1.SUPPLIER_COUNT_10 
                               , SX1.VAT_COUNT_10
                               , SX1.ITEM_AMONT_10
                               , SX1.DEEMED_VAT_AMOUNT_10 
                               , SX1.SUPPLIER_COUNT_20 
                               , SX1.VAT_COUNT_20
                               , SX1.ITEM_AMONT_20
                               , SX1.DEEMED_VAT_AMOUNT_20 
                               , (NVL(RE.SALES_PRE_AMOUNT, 0) + NVL(RE.SALES_FIX_AMOUNT, 0)) AS SALES_SUM_AMOUNT  -- ����� �հ� 
                               , RE.SALES_PRE_AMOUNT 
                               , RE.SALES_FIX_AMOUNT 
                               , CASE
                                   WHEN NVL(RE.LIMIT_RATE_DENOMINATOR, 0) = 0 THEN 0
                                   ELSE TRUNC(NVL(RE.LIMIT_RATE_NUMERATOR, 0) /  NVL(RE.LIMIT_RATE_DENOMINATOR, 0), 2)
                                 END LIMIT_RATE 
                               , RE.LIMIT_AMOUNT 
                               , NVL(RE.PURCHASES_TAX_BILL_AMOUNT, 0) + NVL(RE.PURCHASES_BILL_AMOUNT, 0) AS PURCHASES_SUM_AMOUNT  -- �����Ծ� �հ� 
                               , RE.PURCHASES_TAX_BILL_AMOUNT 
                               , RE.PURCHASES_BILL_AMOUNT 
                               , RE.DED_RANGE_AMOUNT 
                               , RE.DED_TARGET_AMOUNT
                               , RE.DED_RATE_NUMERATOR 
                               , RE.DED_RATE_DENOMINATOR 
                               , RE.DED_VAT_AMOUNT   -- ������󼼾� 
                               , NVL(RE.DED_PRE_QUARTER_AMOUNT, 0) + NVL(RE.DED_PRE_MONTHLY_AMOUNT, 0) AS DED_PRE_VAT_AMOUNT  -- �̹� �������� ���� �հ� 
                               , RE.DED_PRE_QUARTER_AMOUNT 
                               , RE.DED_PRE_MONTHLY_AMOUNT 
                               , RE.FIX_VAT_AMOUNT  -- ����(����)�� ���� 
                            FROM FI_VAT_RECYCLING_ETC  RE
                               , ( SELECT  RED.SOB_ID 
                                         , RED.ORG_ID 
                                         , RED.TAX_CODE 
                                         , RED.VAT_MNG_SERIAL 
                                         , COUNT(RED.SUPPLIER_ID) AS TOT_SUPPLIER_COUNT
                                         , SUM(RED.VAT_COUNT) AS TOT_VAT_COUNT
                                         , SUM(RED.ITEM_AMOUNT) AS TOT_ITEM_AMOUNT
                                         , SUM(RED.DEEMED_VAT_AMOUNT) AS TOT_DEEMED_VAT_AMOUNT
                                         , SUM(DECODE(RED.VAT_RECEIPT_TYPE, '10', 1, 0)) AS SUPPLIER_COUNT_10 
                                         , SUM(DECODE(RED.VAT_RECEIPT_TYPE, '10', NVL(RED.VAT_COUNT, 0), 0)) AS VAT_COUNT_10
                                         , SUM(DECODE(RED.VAT_RECEIPT_TYPE, '10', NVL(RED.ITEM_AMOUNT, 0), 0)) AS ITEM_AMONT_10
                                         , SUM(DECODE(RED.VAT_RECEIPT_TYPE, '10', NVL(RED.DEEMED_VAT_AMOUNT, 0), 0)) AS DEEMED_VAT_AMOUNT_10 
                                         , SUM(DECODE(RED.VAT_RECEIPT_TYPE, '10', 0, 1)) AS SUPPLIER_COUNT_20 
                                         , SUM(DECODE(RED.VAT_RECEIPT_TYPE, '10', 0, NVL(RED.VAT_COUNT, 0))) AS VAT_COUNT_20
                                         , SUM(DECODE(RED.VAT_RECEIPT_TYPE, '10', 0, NVL(RED.ITEM_AMOUNT, 0))) AS ITEM_AMONT_20
                                         , SUM(DECODE(RED.VAT_RECEIPT_TYPE, '10', 0, NVL(RED.DEEMED_VAT_AMOUNT, 0))) AS DEEMED_VAT_AMOUNT_20 
                                    FROM FI_VAT_RECYCLING_ETC_DETAIL RED
                                   WHERE RED.TAX_CODE           = W_TAX_CODE
                                     AND RED.SOB_ID             = W_SOB_ID
                                     AND RED.ORG_ID             = W_ORG_ID
                                     AND RED.VAT_MNG_SERIAL     = W_VAT_MNG_SERIAL
                                     AND RED.VAT_RECEIPT_TYPE   IN('10', '20')  -- ������, ��꼭 ����и� ���� 
                                   GROUP BY RED.SOB_ID 
                                           , RED.ORG_ID 
                                           , RED.TAX_CODE 
                                           , RED.VAT_MNG_SERIAL 
                                   ) SX1
                           WHERE RE.SOB_ID                = SX1.SOB_ID 
                             AND RE.ORG_ID                = SX1.ORG_ID
                             AND RE.TAX_CODE              = SX1.TAX_CODE
                             AND RE.VAT_MNG_SERIAL        = SX1.VAT_MNG_SERIAL 
                             AND RE.TAX_CODE              = W_TAX_CODE
                             AND RE.SOB_ID                = W_SOB_ID
                             AND RE.ORG_ID                = W_ORG_ID
                             AND RE.VAT_MNG_SERIAL        = W_VAT_MNG_SERIAL 
                         ) T1
                  ) 
    LOOP
      INSERT_VAT_E_FILE('��Ȱ�����ڿ� �� �߰��ڵ��� ���Լ��װ����Ű���', REC_1.REC);   
      
      -- ��Ȱ�����ڿ� �� �߰��ڵ��� ���Լ��װ����Ű��� - ����   
      FOR REC_2 IN (SELECT '18'     -- �ڷᱸ�� 
                        || 'V147'   -- �����ڵ� 
                        || RPAD(ROWNUM, 6, '0')   --�Ϸù�ȣ 
                        || RPAD(NVL(T1.SUPPLIER_NAME, ' '), 60, ' ')  -- ��ȣ
                        || RPAD(REPLACE(T1.TAX_REG_NO, '-', ''), 13, ' ')  -- ����ڵ�Ϲ�ȣ 
                        || LPAD(NVL(T1.VAT_COUNT, 0), 11, 0)               -- �Ǽ�
                        || RPAD(NVL(T1.ITEM_DESC, ' '), 30, 0)             -- ǰ��  
                        || LPAD(NVL(T1.ITEM_QTY, 0), 11, 0)                -- ����  
                        || LPAD(NVL(T1.ITEM_AMOUNT, 0), 13, 0)                -- ���ݾ�  
                        || RPAD(NVL(T1.CAR_NUM, 0), 20, 0)             -- ������ȣ 
                        || LPAD(NVL(T1.CAR_BODY_NUM, 0), 17, 0)       -- �����ȣ 
                        || RPAD(' ', 13, ' ')   --14.����  CHAR  54
                        AS REC
                        , ROWNUM AS SEQ 
                    FROM  (
                              SELECT FAS.SUPPLIER_CODE
                                   , FAS.SUPPLIER_SHORT_NAME AS SUPPLIER_NAME 
                                   , FAS.TAX_REG_NO 
                                   , RED.VAT_COUNT
                                   , RED.ITEM_DESC
                                   , RED.ITEM_QTY 
                                   , RED.ITEM_AMOUNT
                                   , RED.CAR_NUM
                                   , RED.CAR_BODY_NUM 
                                FROM FI_VAT_RECYCLING_ETC_DETAIL RED 
                                   , AP_SUPPLIER                 FAS
                               WHERE RED.SUPPLIER_ID       = FAS.SUPPLIER_ID
                                 AND RED.TAX_CODE          = W_TAX_CODE
                                 AND RED.SOB_ID            = W_SOB_ID
                                 AND RED.ORG_ID            = W_ORG_ID
                                 AND RED.VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL 
                                 AND RED.VAT_RECEIPT_TYPE  = '10'    -- ������ ����и� -- 
                              ORDER BY FAS.SUPPLIER_CODE  
                          ) T1
                    ) 
      LOOP
        INSERT_VAT_E_FILE('��Ȱ�����ڿ� �� �߰��ڵ��� ���Լ��װ����Ű��� ����', REC_2.REC);    
      END LOOP REC_2;
    END LOOP REC_1;      
END IF;


IF t_E_FILE_NO_DEDUCTION_YN = 'Y' THEN  --���ڽŰ����ϻ�����󿩺�_�����������Ҹ��Լ��׸�����

    --2-12.�����������Ҹ��Լ��׸�����
    --���ĸ� : �����������Ҹ��Լ��׸����� , File : �����������Ҹ��Լ��׸�����, ���� : 200
    FOR REC_1 IN (SELECT '17'  --1.�ڷᱸ��	CHAR	2
                      || 'V153'   --2.�����ڵ�	CHAR	4
                      || LPAD(NVL(T1.VAT_COUNT, 0), 11, 0)  --3.�ż��հ�_���ݰ�꼭	NUMBER	11
                      || LPAD(REPLACE(LPAD(NVL(T1.GL_AMOUNT, 0), 15, '0'), '-', ''), 15, '-') --4.���ް����հ�_���ݰ�꼭	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.VAT_AMOUNT, 0), 15, '0'), '-', ''), 15, '-') --5.���Լ����հ�_���ݰ�꼭	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.SUPPLY_110_AMT, 0), 15, '0'), '-', ''), 15, '-')  --6.������԰��ް����հ�_�Ⱥа��	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.VAT_110_AMT, 0), 15, '0'), '-', ''), 15, '-')  --7.������Լ����հ�_�Ⱥа��	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.NO_VAT_110_AMT, 0), 15, '0'), '-', ''), 15, '-')  --8.�Ұ������Լ����հ�_�Ⱥа��	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.VAT_120_AMT, 0), 15, '0'), '-', ''), 15, '-')  --9.�Ұ������Լ����Ѿ��հ�_���곻��	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.PRE_VAT_120_AMT, 0), 15, '0'), '-', ''), 15, '-')  --10.��Ұ������Լ����հ�_���곻��	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.ADDITION_VAT_120_AMT, 0), 15, '0'), '-', ''), 15, '-')  --11.����/�������Լ����հ�_���곻��	NUMBER	15
                      || LPAD(REPLACE(LPAD(NVL(T1.ADDITION_VAT_130_AMT, 0), 15, '0'), '-', ''), 15, '-')  --12.����/�������Լ����հ�_��������	NUMBER	15
                      || RPAD(' ', 48, ' ')   --13.����	CHAR	48
                         AS REC
                    FROM (SELECT SUM(DECODE(DS.NO_DED_CODE, '99', NVL(DS.VAT_COUNT, 0), 0)) AS VAT_COUNT           -- 3.�ż��հ� ���ݰ�꼭  
                               , SUM(DECODE(DS.NO_DED_CODE, '99', NVL(DS.GL_AMOUNT, 0), 0)) AS GL_AMOUNT           -- 4.���ް����հ� ���ݰ�꼭  
                               , SUM(DECODE(DS.NO_DED_CODE, '99', NVL(DS.VAT_AMOUNT, 0), 0)) AS VAT_AMOUNT         -- 5.���Լ����հ� ���ݰ�꼭  
                               , SUM(DECODE(DS.NO_DED_CODE, '110', NVL(SX1.SUPPLY_AMT, 0), 0)) AS SUPPLY_110_AMT      -- 6.�Ұ������Լ����հ� �Ⱥа�� ���ް���    
                               , SUM(DECODE(DS.NO_DED_CODE, '110', NVL(SX1.VAT_AMT, 0), 0)) AS VAT_110_AMT            -- 7.�Ұ������Լ����հ� �Ⱥа�� ����  
                               , SUM(DECODE(DS.NO_DED_CODE, '110', NVL(SX1.NO_VAT_AMT, 0), 0)) AS NO_VAT_110_AMT      -- 8.�Ұ������Լ����հ� �Ⱥа�� �Ұ������Լ����� �հ�  
                               , SUM(DECODE(DS.NO_DED_CODE, '120', NVL(SX1.VAT_AMT, 0), 0)) AS VAT_120_AMT            -- 9.�Ұ������Լ����հ� ���곻�� ����     
                               , SUM(DECODE(DS.NO_DED_CODE, '120', NVL(SX1.PRE_VAT_AMT, 0), 0)) AS PRE_VAT_120_AMT    -- 10.�Ұ������Լ����հ� ���곻�� ��Ұ������Լ��� 
                               , SUM(DECODE(DS.NO_DED_CODE, '120', NVL(SX1.ADDITION_VAT_AMT, 0), 0)) AS ADDITION_VAT_120_AMT -- 11.�Ұ������Լ����հ� ���곻�� ���� �Ǵ� �����Ǵ� ���Լ���  
                               , SUM(DECODE(DS.NO_DED_CODE, '130', NVL(SX1.ADDITION_VAT_AMT, 0), 0)) AS ADDITION_VAT_130_AMT -- 12.�Ұ������Լ����հ� ���곻�� �����Ǵ� ���Լ����� �հ�    
                            FROM FI_NO_DEDUCTION_SPEC DS
                              , ( SELECT DA.TAX_CODE
                                       , DA.SOB_ID
                                       , DA.ORG_ID
                                       , DA.VAT_DATE_FR
                                       , DA.VAT_DATE_TO
                                       , DA.NO_DED_TYPE
                                       , DA.NO_DED_CODE
                                       , SUM(DA.SUPPLY_AMT) AS SUPPLY_AMT                   -- �����鼼���������� ���ް��� 
                                       , SUM(DA.VAT_AMT) AS VAT_AMT                         -- �����鼼����� �Ѱ�����Լ��� 
                                       , SUM(DA.TAX_SUPPLY_AMT) AS TAX_SUPPLY_AMT           -- �Ѱ��ް��׵� 
                                       , SUM(DA.NON_TAX_SUPPLY_AMT) AS NON_TAX_SUPPLY_AMT   -- �鼼���ް��׵� 
                                       , SUM(DA.NON_TAX_RATE) AS NON_TAX_RATE               -- �鼼������(%) 
                                       , SUM(DA.NO_VAT_AMT) AS NO_VAT_AMT                   -- �Ұ������Լ��� 
                                       , SUM(DA.PRE_VAT_AMT) AS PRE_VAT_AMT                 -- ��Ұ��� ���Լ��� 
                                       , SUM(DA.ADDITION_VAT_AMT) AS ADDITION_VAT_AMT       -- ����Ǵ°������Լ��� 
                                       , SUM(DA.ADJUST_SUPPLY_AMT) AS ADJUST_SUPPLY_AMT     -- �Ⱥ�/���� �� ���ް��� 
                                    FROM FI_NO_DEDUCTION_ADJUST DA
                                   WHERE DA.TAX_CODE      = W_TAX_CODE
                                     AND DA.SOB_ID        = W_SOB_ID
                                     AND DA.ORG_ID        = W_ORG_ID
                                     AND EXISTS
                                           ( SELECT 'X'
                                               FROM FI_VAT_REPORT_MNG RM
                                              WHERE RM.SOB_ID           = DA.SOB_ID
                                                AND RM.ORG_ID           = DA.ORG_ID
                                                AND RM.TAX_CODE         = DA.TAX_CODE
                                                AND RM.TAX_TERM_FR      = DA.VAT_DATE_FR
                                                AND RM.TAX_TERM_TO      = DA.VAT_DATE_TO
                                                AND RM.VAT_MNG_SERIAL   = W_VAT_MNG_SERIAL
                                           )
                                  GROUP BY DA.TAX_CODE
                                         , DA.SOB_ID
                                         , DA.ORG_ID
                                         , DA.VAT_DATE_FR
                                         , DA.VAT_DATE_TO
                                         , DA.NO_DED_TYPE
                                         , DA.NO_DED_CODE
                                ) SX1
                           WHERE DS.TAX_CODE              = SX1.TAX_CODE(+)
                             AND DS.SOB_ID                = SX1.SOB_ID(+)
                             AND DS.ORG_ID                = SX1.ORG_ID(+)
                             AND DS.VAT_DATE_FR           = SX1.VAT_DATE_FR(+)
                             AND DS.VAT_DATE_TO           = SX1.VAT_DATE_TO(+)
                             AND DS.NO_DED_TYPE           = SX1.NO_DED_TYPE(+)
                             AND DS.NO_DED_CODE           = SX1.NO_DED_CODE(+)
                             AND DS.TAX_CODE              = W_TAX_CODE
                             AND DS.SOB_ID                = W_SOB_ID
                             AND DS.ORG_ID                = W_ORG_ID
                             AND DS.NO_DED_TYPE           IN('10', '20')
                             AND DS.NO_DED_CODE           IN('99', '110', '120', '130')
                             AND EXISTS
                                   ( SELECT 'X'
                                       FROM FI_VAT_REPORT_MNG RM
                                      WHERE RM.SOB_ID           = DS.SOB_ID
                                        AND RM.ORG_ID           = DS.ORG_ID
                                        AND RM.TAX_CODE         = DS.TAX_CODE
                                        AND RM.TAX_TERM_FR      = DS.VAT_DATE_FR
                                        AND RM.TAX_TERM_TO      = DS.VAT_DATE_TO
                                        AND RM.VAT_MNG_SERIAL   = W_VAT_MNG_SERIAL
                                   )
                         ) T1
                  ) 
    LOOP
      INSERT_VAT_E_FILE('�����������Ҹ��Լ��׸�����', REC_1.REC);   
      
      -- �����������Ҹ��Լ��׸����� - ����   
      FOR REC_2 IN (SELECT '18'
                        || 'V153'
                        || LPAD(T1.E_FILE_CODE, 2, 0)                  -- �Ұ�����������  
                        || LPAD(NVL(DS.VAT_COUNT, 0), 11, 0)           -- �ż��հ� ���ݰ�꼭  
                        || LPAD(REPLACE(LPAD(NVL(DS.GL_AMOUNT, 0), 13, '0'), '-', ''), 13, '-')   -- 4.���ް����հ� ���ݰ�꼭  
                        || LPAD(REPLACE(LPAD(NVL(DS.VAT_AMOUNT, 0), 13, '0'), '-', ''), 13, '-')  -- 5.���Լ����հ� ���ݰ�꼭                               
                        || RPAD(' ', 55, ' ') AS REC
                      FROM FI_NO_DEDUCTION_SPEC DS
                         , ( SELECT FC.CODE AS NO_DED_CODE
                                  , FC.VALUE4 AS E_FILE_CODE
                                  , FC.SOB_ID
                                  , FC.ORG_ID
                               FROM FI_COMMON FC
                              WHERE FC.GROUP_CODE     = 'VAT_REASON'
                                AND FC.SOB_ID         = W_SOB_ID
                                AND FC.ORG_ID         = W_ORG_ID
                           ) T1
                     WHERE DS.NO_DED_CODE           = T1.NO_DED_CODE
                       AND DS.SOB_ID                = T1.SOB_ID
                       AND DS.ORG_ID                = T1.ORG_ID                       
                       AND DS.TAX_CODE              = W_TAX_CODE
                       AND DS.SOB_ID                = W_SOB_ID
                       AND DS.ORG_ID                = W_ORG_ID
                       AND DS.NO_DED_TYPE           IN('10')
                       AND DS.NO_DED_CODE           NOT IN('99')  -- �հ� ����  
                       AND DS.VAT_COUNT             != 0
                       AND EXISTS
                             ( SELECT 'X'
                                 FROM FI_VAT_REPORT_MNG RM
                                WHERE RM.SOB_ID           = DS.SOB_ID
                                  AND RM.ORG_ID           = DS.ORG_ID
                                  AND RM.TAX_CODE         = DS.TAX_CODE
                                  AND RM.TAX_TERM_FR      = DS.VAT_DATE_FR
                                  AND RM.TAX_TERM_TO      = DS.VAT_DATE_TO
                                  AND RM.VAT_MNG_SERIAL   = W_VAT_MNG_SERIAL
                             )
                    ORDER BY DS.SORT_NUM 
                    ) 
      LOOP
        INSERT_VAT_E_FILE('�����������Ҹ��Լ��׸����� ����', REC_2.REC);    
      END LOOP REC_2;
      
      -- �����������Ҹ��Լ��׸�����-������Լ��׾Ⱥа�곻��  
      FOR REC_2 IN (SELECT '19'
                        || 'V153'
                        || LPAD(ROWNUM, 6, 0)  -- �Ϸù�ȣ  
                        || LPAD(REPLACE(LPAD(NVL(DA.SUPPLY_AMT, 0), 13, '0'), '-', ''), 13, '-')   -- �����鼼���������� ���ް���  
                        || LPAD(REPLACE(LPAD(NVL(DA.VAT_AMT, 0), 13, '0'), '-', ''), 13, '-')      -- �����鼼����� �Ѱ�����Լ���                       
                        || LPAD(REPLACE(LPAD(REPLACE(TO_CHAR(NVL(DA.TAX_SUPPLY_AMT, 0), 'FM99999999999999999.00'), '.', ''), 15, '0'), '-', ''), 13, '-')  -- �Ѱ��ް��׵�                        
                        || LPAD(REPLACE(LPAD(REPLACE(TO_CHAR(NVL(DA.NON_TAX_SUPPLY_AMT, 0), 'FM99999999999999999.00'), '.', ''), 15, '0'), '-', ''), 13, '-')  -- �鼼���ް��׵�
                        || LPAD(REPLACE(LPAD(NVL(DA.NO_VAT_AMT, 0), 13, '0'), '-', ''), 13, '-')      -- �Ұ������Լ���  
                        || RPAD(' ', 19, ' ') AS REC                        
                      FROM FI_NO_DEDUCTION_ADJUST DA
                     WHERE DA.TAX_CODE      = W_TAX_CODE
                       AND DA.SOB_ID        = W_SOB_ID
                       AND DA.ORG_ID        = W_ORG_ID
                       AND DA.NO_DED_TYPE   = '20'
                       AND DA.NO_DED_CODE   = '110'
                       AND EXISTS
                             ( SELECT 'X'
                                 FROM FI_VAT_REPORT_MNG RM
                                WHERE RM.SOB_ID           = DA.SOB_ID
                                  AND RM.ORG_ID           = DA.ORG_ID
                                  AND RM.TAX_CODE         = DA.TAX_CODE
                                  AND RM.TAX_TERM_FR      = DA.VAT_DATE_FR
                                  AND RM.TAX_TERM_TO      = DA.VAT_DATE_TO
                                  AND RM.VAT_MNG_SERIAL   = W_VAT_MNG_SERIAL
                             )        
                    ) 
      LOOP
        INSERT_VAT_E_FILE('�����������Ҹ��Լ��׸�����-������Լ��׾Ⱥа�곻��', REC_2.REC);    
      END LOOP REC_2; 
      
      -- �����������Ҹ��Լ��׸�����-������Լ������곻��  
      FOR REC_2 IN (SELECT '20'
                        || 'V153'
                        || LPAD(ROWNUM, 6, 0)  -- �Ϸù�ȣ  
                        || LPAD(REPLACE(LPAD(NVL(DA.VAT_AMT, 0), 13, '0'), '-', ''), 13, '-')           -- �����鼼����� �Ѱ�����Լ��� 
                        || LPAD(REPLACE(LPAD(REPLACE(TO_CHAR(NVL(DA.NON_TAX_RATE, 0), 'FM999999.000000'), '.', ''), 11, '0'), '-', ''), 13, '-')      -- �鼼������(%)                         
                        || LPAD(REPLACE(LPAD(NVL(DA.NO_VAT_AMT, 0), 13, '0'), '-', ''), 13, '-')        -- �Ұ������Լ���                       
                        || LPAD(REPLACE(LPAD(NVL(DA.PRE_VAT_AMT, 0), 13, '0'), '-', ''), 13, '-')       -- ��Ұ��� ���Լ��� 
                        || LPAD(REPLACE(LPAD(NVL(DA.ADDITION_VAT_AMT, 0), 13, '0'), '-', ''), 13, '-')  -- ����Ǵ°������Լ���   
                        || RPAD(' ', 25, ' ') AS REC
                      FROM FI_NO_DEDUCTION_ADJUST DA
                     WHERE DA.TAX_CODE      = W_TAX_CODE
                       AND DA.SOB_ID        = W_SOB_ID
                       AND DA.ORG_ID        = W_ORG_ID
                       AND DA.NO_DED_TYPE   = '20'
                       AND DA.NO_DED_CODE   = '120'
                       AND EXISTS
                             ( SELECT 'X'
                                 FROM FI_VAT_REPORT_MNG RM
                                WHERE RM.SOB_ID           = DA.SOB_ID
                                  AND RM.ORG_ID           = DA.ORG_ID
                                  AND RM.TAX_CODE         = DA.TAX_CODE
                                  AND RM.TAX_TERM_FR      = DA.VAT_DATE_FR
                                  AND RM.TAX_TERM_TO      = DA.VAT_DATE_TO
                                  AND RM.VAT_MNG_SERIAL   = W_VAT_MNG_SERIAL
                             )        
                    ) 
      LOOP
        INSERT_VAT_E_FILE('�����������Ҹ��Լ��׸�����-������Լ������곻��', REC_2.REC);    
      END LOOP REC_2; 
      --���ĸ� : �����������Ҹ��Լ��׸����� , File : �����������Ҹ��Լ��׸�����_���μ���_ȯ�޼������곻��, ���� : 100  
      
    END LOOP REC_1;

END IF; --IF t_E_FILE_NO_DEDUCTION_YN = 'Y' THEN  --���ڽŰ����ϻ�����󿩺�_�����������Ҹ��Լ��׸�����






IF t_E_FILE_TAX_PUB_YN = 'Y' THEN          --���ڽŰ����ϻ�����󿩺�_���ڼ��ݰ�꼭�߱޼��װ����Ű���

    --2-24.���ڼ��ݰ�꼭 �߱޼��װ����Ű���
    --���ĸ� : ���ڼ��ݰ�꼭 �߱޼��װ����Ű��� , File : ���ڼ��ݰ�꼭 �߱޼��װ����Ű���, ���� : 100

    g_REPORT_CONTENT := NULL;            
    BEGIN
      SELECT
             '17'     --1.�ڷᱸ��    CHAR	2
          || 'V171'   --2.�����ڵ�	CHAR	4
          || LPAD(NVL(ELEC_TAX_PUB_CNT, 0), 7, 0)         --3.���ڼ��ݰ�꼭�߱ްǼ�	NUMBER	7
          || LPAD(NVL(ELEC_TAX_PUB_CNT * 200, 0), 13, 0)  --4.�������ɼ���	        NUMBER	13
          || LPAD(
                    CASE 
                      WHEN NVL(ELEC_TAX_PUB_CNT * 200, 0) < (1000000 - NVL(DEDUCT_TAX, 0)) THEN NVL(ELEC_TAX_PUB_CNT * 200, 0)
                      ELSE (1000000 - NVL(DEDUCT_TAX, 0))
                    END        
                  , 13, 0) --5.�ش��������	NUMBER	13
          || LPAD(NVL(DEDUCT_TAX, 0), 13, 0)              --6.���������	NUMBER	13
          || LPAD(1000000 - NVL(DEDUCT_TAX, 0), 13, 0)    --7.�ش�����Ⱓ�����ѵ���	NUMBER	13
          || RPAD(' ', 35, ' ')   --8.����	CHAR	35
      INTO g_REPORT_CONTENT
      FROM FI_ELEC_TAX_PUB
      WHERE SOB_ID = W_SOB_ID
          AND ORG_ID = W_ORG_ID
          AND TAX_CODE = W_TAX_CODE
          AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   ;    
    
      INSERT_VAT_E_FILE('���ڼ��ݰ�꼭 �߱޼��װ����Ű���', g_REPORT_CONTENT);
    
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
END IF;    --IF t_E_FILE_TAX_PUB_YN = 'Y' THEN          --���ڽŰ����ϻ�����󿩺�_���ڼ��ݰ�꼭�߱޼��װ����Ű���





IF t_E_FILE_DOMESTIC_LC_YN = 'Y' THEN   --���ڽŰ����ϻ�����󿩺�_�����ſ��屸��Ȯ�μ����ڹ߱޸�����

    --2-27.�����ſ��屸��Ȯ�μ����ڹ߱޸�����
    --���ĸ� : �����ſ��屸��Ȯ�μ����ڹ߱޸�����_�հ� , File : �����ſ��屸��Ȯ�μ����ڹ߱޸�����, ���� : 100

    g_REPORT_CONTENT := NULL;            
    BEGIN
      SELECT
             '17'     --1.�ڷᱸ��    CHAR	2
          || 'V174'   --2.�����ڵ�	CHAR	4
          || LPAD(A.CNT, 7, 0)    --3.�Ǽ�_�հ�	NUMBER	7
          || LPAD(A.TOTAL, 15, 0) --4.�ش�ݾ�_�հ�	NUMBER	15
          || LPAD(B.CNT, 7, 0)    --5.�����ſ���_�Ǽ�_�հ�	NUMBER	7
          || LPAD(B.TOTAL, 15, 0) --6.�����ſ���_�ݾ�_�հ�	NUMBER	15
          || LPAD(C.CNT, 7, 0)    --7.����Ȯ�μ�_�Ǽ�_�հ�	NUMBER	7
          || LPAD(C.TOTAL, 15, 0) --8.����Ȯ�μ�_�ݾ�_�հ�	NUMBER	15 
          || RPAD(' ', 28, ' ')   --9.����	CHAR	28
      INTO g_REPORT_CONTENT
      FROM
          (
              SELECT
                    COUNT(*) AS CNT   --�Ǽ�
                  , NVL(SUM(SUPPLY_AMT), 0) AS TOTAL    --�ݾ�(��)
              FROM FI_DOMESTIC_LC
              WHERE SOB_ID = W_SOB_ID
                  AND ORG_ID = W_ORG_ID
                  AND TAX_CODE = W_TAX_CODE               --�������̵�
                  AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --�ΰ����Ű��Ⱓ���й�ȣ
          ) A --�հ�
          ,
          (
              SELECT
                    COUNT(*) AS CNT   --�Ǽ�
                  , NVL(SUM(SUPPLY_AMT), 0) AS TOTAL    --�ݾ�(��)
              FROM FI_DOMESTIC_LC
              WHERE SOB_ID = W_SOB_ID
                  AND ORG_ID = W_ORG_ID
                  AND TAX_CODE = W_TAX_CODE               --�������̵�
                  AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --�ΰ����Ű��Ⱓ���й�ȣ
                  AND VAT_DOMESTIC_LC_CD = '01'   --01 : �����ſ���
          ) B --�����ſ���    
          ,
          (
              SELECT
                    COUNT(*) AS CNT   --�Ǽ�
                  , NVL(SUM(SUPPLY_AMT), 0) AS TOTAL    --�ݾ�(��)
              FROM FI_DOMESTIC_LC
              WHERE SOB_ID = W_SOB_ID
                  AND ORG_ID = W_ORG_ID
                  AND TAX_CODE = W_TAX_CODE               --�������̵�
                  AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --�ΰ����Ű��Ⱓ���й�ȣ
                  AND VAT_DOMESTIC_LC_CD = '02'   --02 : ����Ȯ�μ�
          ) C --����Ȯ�μ�   
      ;        
          
      INSERT_VAT_E_FILE('�����ſ��屸��Ȯ�μ����ڹ߱޸�����_�հ�', g_REPORT_CONTENT);
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    
    
    --���ĸ� : �����ſ��屸��Ȯ�μ����ڹ߱޸�����_���� , File : �����ſ��屸��Ȯ�μ����ڹ߱޸�����_����, ���� : 100
  
    FOR REC_2_27 IN (

        SELECT
               '18'     --1.�ڷᱸ��    CHAR	2
            || 'V174'   --2.�����ڵ�	CHAR	4
            || LPAD(ROWNUM, 6, 0)       --3.�Ϸù�ȣ	    NUMBER	6
            || VAT_DOMESTIC_LC_CD       --4.��������	CHAR	1
            || RPAD(DOC_NO, 35, ' ')    --5.������ȣ	CHAR	35
            || PUB_DATE	                --6.�߱�����	CHAR	8
            || VAT_NUMBER	            --7.���޹޴��� ����ڵ�Ϲ�ȣ	CHAR	10
            || LPAD(SUPPLY_AMT, 15, 0)  --8.�ݾ�	NUMBER	15
            || RPAD(' ', 19, ' ')       --9.����	CHAR	19
            AS REC
        FROM
            (
                SELECT
                      DECODE(VAT_DOMESTIC_LC_CD, '01', 'L', '02', 'A') AS VAT_DOMESTIC_LC_CD    --��������         
                    , DOC_NO    --������ȣ
                    , TO_CHAR(PUB_DATE, 'YYYYMMDD') AS PUB_DATE --�߱���
                    , RPAD(REPLACE(VAT_NUMBER, '-', ''), 10, ' ') AS VAT_NUMBER --����ڵ�Ϲ�ȣ
                    , SUPPLY_AMT    --�ݾ�
                FROM FI_DOMESTIC_LC       
                WHERE SOB_ID = W_SOB_ID
                    AND ORG_ID = W_ORG_ID
                    AND TAX_CODE = W_TAX_CODE               --�������̵�
                    AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --�ΰ����Ű��Ⱓ���й�ȣ
                ORDER BY VAT_DOMESTIC_LC_CD DESC, PUB_DATE
            )

    ) LOOP
    
        INSERT_VAT_E_FILE('�����ſ��屸��Ȯ�μ����ڹ߱޸�����_����', REC_2_27.REC);

    END LOOP REC_2_27;    

END IF;    --IF t_E_FILE_DOMESTIC_LC_YN = 'Y' THEN   --���ڽŰ����ϻ�����󿩺�_�����ſ��屸��Ȯ�μ����ڹ߱޸�����


IF t_E_FILE_ZERO_YN = 'Y' AND  W_ISSUE_DATE_FR >= TO_DATE('2013-07-01', 'YYYY-MM-DD') THEN
-- 203.07.15 ��ȣ�� �߰� --
  -- 31. ���������������.
  FOR C1 IN ( SELECT RPAD('17', 2, ' ') || -- �ڷᱸ�� 
                     RPAD('V177', 4, ' ') || -- �����ڵ�
                     LPAD(NVL(ZRD.V_11_01_01_1 , 0), 15, '0') || -- ��������(������� ����) 
                     LPAD(NVL(ZRD.V_11_01_01_2 , 0), 15, '0') || -- �߰蹫��/��Ź�Ǹ�/�ܱ��ε� �Ǵ� ��Ź�������� ����� ���� 
                     LPAD(NVL(ZRD.V_11_01_01_3 , 0), 15, '0') || -- �����ſ���/����Ȯ�μ��� ���Ͽ� �����ϴ� ��ȭ 
                     LPAD(NVL(ZRD.V_11_01_01_4 , 0), 15, '0') || -- �ѱ��������´� �� �ѱ����������Ƿ���ܿ� �����ϴ� �ؿܹ���� ��ȭ 
                     LPAD(NVL(ZRD.V_11_01_01_5 , 0), 15, '0') || -- ��Ź�������� ��������� �����ϴ� ��ȭ 
                     LPAD(NVL(ZRD.V_11_01_02_1 , 0), 15, '0') || -- ���ܿ��� �����ϴ� �뿪 
                     LPAD(NVL(ZRD.V_11_01_03_1 , 0), 15, '0') || -- ����/�װ��⿡ ���� �ܱ�����뿪 
                     LPAD(NVL(ZRD.V_11_01_03_2 , 0), 15, '0') || -- �������տ�۰�࿡ ���� �ܱ�����뿪 
                     LPAD(NVL(ZRD.V_11_01_04_1 , 0), 15, '0') || -- �������� �������/�ܱ����ο��� ���޵Ǵ� ��ȭ �Ǵ� �뿪 
                     LPAD(NVL(ZRD.V_11_01_04_2 , 0), 15, '0') || -- ������ȭ�Ӱ����뿪 
                     LPAD(NVL(ZRD.V_11_01_04_3 , 0), 15, '0') || -- �ܱ����� ����/�װ��� � �����ϴ� ��ȭ �Ǵ� �뿪 
                     LPAD(NVL(ZRD.V_11_01_04_4 , 0), 15, '0') || -- ���� ���� �ܱ�����/������/�������հ� �̿� ���ϴ� �����ⱸ, �������ձ� �Ǵ� �̱������� �����ϴ� ��ȭ �Ǵ� �뿪 
                     LPAD(NVL(ZRD.V_11_01_04_5 , 0), 15, '0') || -- ����������� ���� �Ϲݿ������ �Ǵ� �ܱ������� �������ǰ �Ǹž��ڰ� �ܱ��ΰ��������� �����ϴ� �����˼� �뿪 �Ǵ� �������ǰ 
                     LPAD(NVL(ZRD.V_11_01_04_6 , 0), 15, '0') || -- �ܱ��������Ǹ��� �Ǵ� ���ѿܱ����� ���� ���� �������������� �����ϴ� ��ȭ �Ǵ� �뿪 
                     LPAD(NVL(ZRD.V_11_01_04_7 , 0), 15, '0') || -- �ܱ��� ��� �����ϴ� ��ȭ �Ǵ� �뿪 
                     LPAD(NVL(ZRD.V_11_01_04_8 , 0), 15, '0') || -- �ܱ���ȯ�� ��ġ�뿪 
                     LPAD(NVL(ZRD.V_SUM_AMT , 0), 15, '0') || -- �ΰ���ġ������ ���� ������ ���� ���޽��� �հ� 
                     LPAD(NVL(ZRD.T_105_01_01_1 , 0), 15, '0') || -- ����������� �� ���δ� � �����ϴ� ������ 
                     LPAD(NVL(ZRD.T_105_01_03_1 , 0), 15, '0') || -- ����ö���Ǽ��뿪 
                     LPAD(NVL(ZRD.T_105_01_03_2 , 0), 15, '0') || -- ����/������ġ��ü�� �����ϴ� ��ȸ��ݽü��� 
                     LPAD(NVL(ZRD.T_105_01_04_1 , 0), 15, '0') || -- ����ο� ���屸 �� ����ο� ������ű�� �� 
                     LPAD(NVL(ZRD.T_105_01_05_1 , 0), 15, '0') || -- ��/��� ��� �����ϴ� �����/������/�Ӿ��� �Ǵ� ����� ������ 
                     LPAD(NVL(ZRD.T_107_00_00_0 , 0), 15, '0') || -- �ܱ��ΰ����� ��� �����ϴ� ��ȭ 
                     LPAD(NVL(ZRD.T_121_13_00_0 , 0), 15, '0') || -- ����Ư����ġ�� �鼼ǰ�Ǹ��忡�� �Ǹ��ϰų� ����Ư����ġ�� �鼼ǰ�Ǹ��忡 �����ϴ� ��ǰ 
                     LPAD(NVL(ZRD.T_SUM_AMT , 0), 15, '0') || -- ��Ư�� �� �� ���� ������ ���� ������ ���� ���޽��� �հ� 
                     LPAD(NVL(ZRD.TOTAL_AMT , 0), 15, '0') || -- ������ ���� ���޽��� �� �հ� 
                     RPAD(' ', 4, ' ') AS RECORD_FILE
                FROM FI_VAT_ZERO_RATE_DOCUMENT ZRD
              WHERE ZRD.TAX_CODE        = W_TAX_CODE
                AND ZRD.VAT_MNG_SERIAL  = W_VAT_MNG_SERIAL   --�ΰ����Ű��Ⱓ���й�ȣ 
                AND ZRD.SOB_ID          = W_SOB_ID
                AND ZRD.ORG_ID          = W_ORG_ID
              )
  LOOP
    INSERT_VAT_E_FILE('���������������', C1.RECORD_FILE);    
  END LOOP C1;
END IF;




--3.�����ü ���̺�



IF t_E_FILE_SUM_VAT_YN = 'Y' THEN       --���ڽð����ϻ�����󿩺�_���ݰ�꼭�հ�ǥ

    --3-1.���ݰ�꼭�հ�ǥ
    --���ĸ� : ǥ��(Head Record)  ���� : 170
    
    g_REPORT_CONTENT := NULL;            

    SELECT
           '7'                  --1.�ڷᱸ��	        CHAR	1
        || t_VAT_NUMBER_10      --2.�����ڵ�Ϲ�ȣ	    NUMBER	10        
        || t_CORP_NAME_30       --3.�����ڻ�ȣ	        CHAR	30
        || t_PRESIDENT_NAME_15  --4.�����ڼ���	        CHAR	15
        || t_LOCATION_45        --5.�����ڻ���������	CHAR	45
        || RPAD(' ', 17, ' ')    --6.�����ھ���	        CHAR	17
        || RPAD(' ', 25, ' ')   --7.����������	        CHAR	25
        || RPAD(TO_CHAR(W_ISSUE_DATE_FR, 'YYMMDD') || TO_CHAR(W_ISSUE_DATE_TO, 'YYMMDD'), 12, ' ')  --8.�ŷ��Ⱓ	NUMBER	12
        || LPAD(TO_CHAR(W_CREATE_DATE, 'YYMMDD'), 6, 0)    --9.�ۼ�����	NUMBER	6        
        || RPAD(' ', 9, ' ')   --10.����	CHAR	9
    INTO g_REPORT_CONTENT
    FROM DUAL   ;
        
    INSERT_VAT_E_FILE('���ݰ�꼭�հ�ǥ ǥ��(Head Record)', g_REPORT_CONTENT);


    --���ĸ� : (���ڼ��ݰ�꼭 �̿ܺ�)�����ڷ�(Data Record)  ���� : 170
    
    FOR REC_4_1 IN (

        SELECT
                '1'                 --1.�ڷᱸ��	    CHAR	1
            || t_VAT_NUMBER_10      --2.�����ڵ�Ϲ�ȣ	NUMBER	10  Null ��� [����ڹ�ȣ]
            || LPAD(ROWNUM, 4, 0)   --3.�Ϸù�ȣ	    NUMBER	4
            || RPAD(REPLACE(NVL(TAX_REG_NO, ' '), '-', ''), 10, ' ')    --4.�ŷ��ڵ�Ϲ�ȣ	NUMBER	10  [����ڹ�ȣ]
            || RPAD(NVL(SUPPLIER_NAME, ' '), 30, ' ')                   --5.�ŷ��ڻ�ȣ	    CHAR	30  Null ���
            || RPAD(' ', 17, ' ')       --6.�ŷ��ھ���	    CHAR	17  SPACE
            || RPAD(' ', 25, ' ')       --7.�ŷ�������	    CHAR	25  SPACE
            || LPAD(COMPANY_CNT, 7, 0)  --8.���ݰ�꼭�ż�	NUMBER	7
            || LPAD(0, 2, 0)            --9.������	        NUMBER	2
            
            || LPAD(
                    CASE
                        WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                        ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                            CASE SUBSTR(GL_AMOUNT, -1, 1)
                                WHEN '1' THEN 'J'
                                WHEN '2' THEN 'K'
                                WHEN '3' THEN 'L'
                                WHEN '4' THEN 'M'
                                WHEN '5' THEN 'N'
                                WHEN '6' THEN 'O'
                                WHEN '7' THEN 'P'
                                WHEN '8' THEN 'Q'
                                WHEN '9' THEN 'R'
                                WHEN '0' THEN '}'
                            END
                    END
                  , 14, '0') --10.���ް���	NUMBER	14
            || LPAD(
                    CASE
                        WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                        ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                            CASE SUBSTR(VAT_AMOUNT, -1, 1)
                                WHEN '1' THEN 'J'
                                WHEN '2' THEN 'K'
                                WHEN '3' THEN 'L'
                                WHEN '4' THEN 'M'
                                WHEN '5' THEN 'N'
                                WHEN '6' THEN 'O'
                                WHEN '7' THEN 'P'
                                WHEN '8' THEN 'Q'
                                WHEN '9' THEN 'R'
                                WHEN '0' THEN '}'
                            END
                    END
                  , 13, '0') --11.����	NUMBER	13            
            
            || '0'      --12.�Ű����ַ��ڵ�(����)	NUMBER	1   [��Ÿ ������ ��쿡�� "0"�� ����]
            /*-- ��ȣ�� �ּ�(2013-07-15) 2013��1��Ȯ�� �� ���� --
            || '0'      --13.�ַ��ڵ�(�Ҹ�)	        NUMBER	1   [��Ÿ ������ ��쿡�� "0"�� ����] 
            */
            || ' '      --13.�ַ��ڵ�(�Ҹ�)	        NUMBER	1   [��Ÿ ������ ��쿡�� " "�� ����]
            || '7501'   --14.�ǹ�ȣ	                NUMBER	4
            || RPAD(' ', 3, ' ')    --15.���⼭	    NUMBER	3 Null ���
            || RPAD(' ', 28, ' ')   --16.����	    CHAR	28 
            AS REC
        FROM
            (
                SELECT
                      AA.SUPPLIER_CODE --�ŷ�ó�ڵ�
                    , B.TAX_REG_NO                    --����ڵ�Ϲ�ȣ      
                    , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --��ȣ(���θ�)      
                    , AA.COMPANY_CNT  --�ż�
                    
                    , AA.GL_AMOUNT     --���ް���
                    , AA.VAT_AMOUNT    --����        
                    
                    , B.PRESIDENT_NAME        --��ǥ�ڼ���
                    , B.BUSINESS_CONDITION    --����
                    , B.BUSINESS_ITEM         --����
                FROM
                    (
                        SELECT             
                              A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                            , COUNT(*) AS COMPANY_CNT --�ż�
                            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
                        FROM FI_SLIP_LINE A
                        WHERE A.SOB_ID = W_SOB_ID
                            AND A.ORG_ID = W_ORG_ID 
                            AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����, �ΰ���������(2100700)
                            AND A.REFER11 = W_TAX_CODE      --�����
                            --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������
                            AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű���������
                            AND A.MANAGEMENT2 IN ('1', '2')  --��������
                            AND TRIM(NVL(A.REFER7, 'N')) = 'N'   --���ڼ��ݰ�꼭����
                        GROUP BY  A.MANAGEMENT1 
                    ) AA
                    , ( SELECT 
                              SUPP_CUST_CODE        --�ڵ�
                            , SUPP_CUST_NAME        --��ȣ
                            , TAX_REG_NO            --����ڵ�Ϲ�ȣ
                            , PRESIDENT_NAME        --��ǥ�ڼ���
                            , BUSINESS_CONDITION    --����
                            , BUSINESS_ITEM         --����
                        FROM FI_SUPP_CUST_V) B  --�ŷ�ó    
                WHERE AA.SUPPLIER_CODE = B.SUPP_CUST_CODE(+)
                ORDER BY TAX_REG_NO        
            )

    ) LOOP
    
        INSERT_VAT_E_FILE('���ݰ�꼭�հ�ǥ (���ڼ��ݰ�꼭 �̿ܺ�)�����ڷ�(Data Record)', REC_4_1.REC);

    END LOOP REC_4_1;

    
    --���ĸ� : (���ڼ��ݰ�꼭 �̿ܺ�)�����հ�(Total Record)  ���� : 170

    g_REPORT_CONTENT := NULL;            

    SELECT
           '3'              --1.�ڷᱸ��	    CHAR	1
        || t_VAT_NUMBER_10  --2.�����ڵ�Ϲ�ȣ	NUMBER	10  Null ���
        
        --(�հ��)		
        || LPAD(COMPANY_CNT, 7, 0)  --3.�ŷ�ó��	    NUMBER	7
        || LPAD(TOT_RECORD, 7, 0)   --4.���ݰ�꼭�ż�	NUMBER	7
        || LPAD(
                CASE
                    WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                    ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                        CASE SUBSTR(GL_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 15, '0') --5.���ް���	NUMBER	15
        || LPAD(
                CASE
                    WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                    ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                        CASE SUBSTR(VAT_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 14, '0') --6.����	NUMBER	14
        
        --(����ڹ�ȣ�����)		    
        || LPAD(COMPANY_CNT, 7, 0)  --7.�ŷ�ó��	    NUMBER	7
        || LPAD(TOT_RECORD, 7, 0)   --8.���ݰ�꼭�ż�	NUMBER	7
        || LPAD(
                CASE
                    WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                    ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                        CASE SUBSTR(GL_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 15, '0') --9.���ް���	NUMBER	15
        || LPAD(
                CASE
                    WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                    ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                        CASE SUBSTR(VAT_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 14, '0') --10.����	NUMBER	14    
        
        --(�ֹι�ȣ�����)		
        || LPAD(0, 7, 0)    --11.�ŷ�ó��	    NUMBER	7
        || LPAD(0, 7, 0)    --12.���ݰ�꼭�ż�	NUMBER	7
        || LPAD(0, 15, 0)   --13.���ް���	    NUMBER	15
        || LPAD(0, 14, 0)   --14.����	        NUMBER	14
        
        || RPAD(' ', 30, ' ')   --15.����	CHAR	30
    INTO g_REPORT_CONTENT
    FROM
        (
            SELECT
                  COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --����ó��
                , NVL(SUM(CNT), 0) AS TOT_RECORD                --�ż�
                , NVL(SUM(GL_AMOUNT), 0) AS GL_AMOUNT       --���ް���
                , NVL(SUM(VAT_AMOUNT), 0) AS VAT_AMOUNT     --����                
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                        , COUNT(*) AS CNT --�ż�
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����, �ΰ���������(2100700)
                        AND A.REFER11 = W_TAX_CODE      --�����
                        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������
                        AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű���������
                        AND A.MANAGEMENT2 IN ('1', '2')  --��������
                        AND TRIM(NVL(A.REFER7, 'N')) = 'N'   --���ڼ��ݰ�꼭����
                    GROUP BY  A.MANAGEMENT1
                ) TC    
        )   ;
        
    INSERT_VAT_E_FILE('���ݰ�꼭�հ�ǥ (���ڼ��ݰ�꼭 �̿ܺ�)�����հ�(Total Record)', g_REPORT_CONTENT);



    --���ĸ� : ���ڼ��ݰ�꼭�� �����հ�(Total Record)  ���� : 170

    g_REPORT_CONTENT := NULL;            


    SELECT
           '5'              --1.�ڷᱸ��	    CHAR	1
        || t_VAT_NUMBER_10  --2.�����ڵ�Ϲ�ȣ	NUMBER	10  Null ���
        
        --(�հ��)		
        || LPAD(COMPANY_CNT, 7, 0)  --3.�ŷ�ó��	    NUMBER	7
        || LPAD(TOT_RECORD, 7, 0)   --4.���ݰ�꼭�ż�	NUMBER	7
        || LPAD(
                CASE
                    WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                    ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                        CASE SUBSTR(GL_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 15, '0') --5.���ް���	NUMBER	15
        || LPAD(
                CASE
                    WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                    ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                        CASE SUBSTR(VAT_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 14, '0') --6.����	NUMBER	14
        
        --(����ڹ�ȣ�����)		    
        || LPAD(COMPANY_CNT, 7, 0)  --7.�ŷ�ó��	    NUMBER	7
        || LPAD(TOT_RECORD, 7, 0)   --8.���ݰ�꼭�ż�	NUMBER	7
        || LPAD(
                CASE
                    WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                    ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                        CASE SUBSTR(GL_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 15, '0') --9.���ް���	NUMBER	15
        || LPAD(
                CASE
                    WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                    ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                        CASE SUBSTR(VAT_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 14, '0') --10.����	NUMBER	14    
        
        --(�ֹι�ȣ�����)		
        || LPAD(0, 7, 0)    --11.�ŷ�ó��	    NUMBER	7
        || LPAD(0, 7, 0)    --12.���ݰ�꼭�ż�	NUMBER	7
        || LPAD(0, 15, 0)   --13.���ް���	    NUMBER	15
        || LPAD(0, 14, 0)   --14.����	        NUMBER	14
        
        || RPAD(' ', 30, ' ')   --15.����	CHAR	30
    INTO g_REPORT_CONTENT
    FROM
        (
            SELECT
                  COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --����ó��
                , NVL(SUM(CNT), 0) AS TOT_RECORD                --�ż�
                , NVL(SUM(GL_AMOUNT), 0) AS GL_AMOUNT       --���ް���
                , NVL(SUM(VAT_AMOUNT), 0) AS VAT_AMOUNT     --����                
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                        , COUNT(*) AS CNT --�ż�
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����, �ΰ���������(2100700)
                        AND A.REFER11 = W_TAX_CODE      --�����
                        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������
                        AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű���������
                        AND A.MANAGEMENT2 IN ('1', '2')  --��������
                        AND TRIM(NVL(A.REFER7, 'N')) = 'Y'   --���ڼ��ݰ�꼭����
                    GROUP BY  A.MANAGEMENT1 
                ) TB  
        )   ;
        
    INSERT_VAT_E_FILE('���ݰ�꼭�հ�ǥ ���ڼ��ݰ�꼭�� �����հ�(Total Record)', g_REPORT_CONTENT);



    --���ĸ� : (���ڼ��ݰ�꼭 �̿ܺ�)�����ڷ�(Data Record)  ���� : 170
    
    FOR REC_4_2 IN (

        SELECT
                '2'                 --1.�ڷᱸ��	    CHAR	1
            || t_VAT_NUMBER_10      --2.�����ڵ�Ϲ�ȣ	NUMBER	10  Null ��� [����ڹ�ȣ]
            || LPAD(ROWNUM, 4, 0)   --3.�Ϸù�ȣ	    NUMBER	4
            || RPAD(REPLACE(NVL(TAX_REG_NO, ' '), '-', ''), 10, ' ')    --4.�ŷ��ڵ�Ϲ�ȣ	NUMBER	10  [����ڹ�ȣ]
            || RPAD(NVL(SUPPLIER_NAME, ' '), 30, ' ')                   --5.�ŷ��ڻ�ȣ	    CHAR	30  Null ���
            || RPAD(' ', 17, ' ')       --6.�ŷ��ھ���	    CHAR	17  SPACE
            || RPAD(' ', 25, ' ')       --7.�ŷ�������	    CHAR	25  SPACE
            || LPAD(COMPANY_CNT, 7, 0)  --8.���ݰ�꼭�ż�	NUMBER	7
            || LPAD(0, 2, 0)            --9.������	        NUMBER	2
            
            || LPAD(
                    CASE
                        WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                        ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                            CASE SUBSTR(GL_AMOUNT, -1, 1)
                                WHEN '1' THEN 'J'
                                WHEN '2' THEN 'K'
                                WHEN '3' THEN 'L'
                                WHEN '4' THEN 'M'
                                WHEN '5' THEN 'N'
                                WHEN '6' THEN 'O'
                                WHEN '7' THEN 'P'
                                WHEN '8' THEN 'Q'
                                WHEN '9' THEN 'R'
                                WHEN '0' THEN '}'
                            END
                    END
                  , 14, '0') --10.���ް���	NUMBER	14
            || LPAD(
                    CASE
                        WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                        ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                            CASE SUBSTR(VAT_AMOUNT, -1, 1)
                                WHEN '1' THEN 'J'
                                WHEN '2' THEN 'K'
                                WHEN '3' THEN 'L'
                                WHEN '4' THEN 'M'
                                WHEN '5' THEN 'N'
                                WHEN '6' THEN 'O'
                                WHEN '7' THEN 'P'
                                WHEN '8' THEN 'Q'
                                WHEN '9' THEN 'R'
                                WHEN '0' THEN '}'
                            END
                    END
                  , 13, '0') --11.����	NUMBER	13            
            
            || '0'      --12.�Ű����ַ��ڵ�(����)	NUMBER	1   [��Ÿ ������ ��쿡�� "0"�� ����]
            /*-- 20130715 ��ȣ���ּ� : 201307 1��Ȯ���� ���� --
            || '0'      --13.�ַ��ڵ�(�Ҹ�)	        NUMBER	1   [��Ÿ ������ ��쿡�� "0"�� ����]
            */
            || ' '      --13.�ַ��ڵ�(�Ҹ�)	        NUMBER	1   [��Ÿ ������ ��쿡�� " "�� ����]
            || '8501'   --14.�ǹ�ȣ	                NUMBER	4
            || RPAD(' ', 3, ' ')    --15.���⼭	    NUMBER	3 Null ���
            || RPAD(' ', 28, ' ')   --16.����	    CHAR	28 
            AS REC
        FROM
            (
                SELECT
                      AA.SUPPLIER_CODE --�ŷ�ó�ڵ�
                    , B.TAX_REG_NO                    --����ڵ�Ϲ�ȣ      
                    , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --��ȣ(���θ�)      
                    , AA.COMPANY_CNT  --�ż�
                    
                    , AA.GL_AMOUNT     --���ް���
                    , AA.VAT_AMOUNT    --����        
                    
                    , B.PRESIDENT_NAME        --��ǥ�ڼ���
                    , B.BUSINESS_CONDITION    --����
                    , B.BUSINESS_ITEM         --����        
                FROM
                    (
                    SELECT
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                        , COUNT(*) AS COMPANY_CNT           --�ż�     
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����     
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '1111700'  --�ŷ����� : ����, �ΰ�����ޱ�(1111700)
                        AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������
                        AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű���������
                        AND A.REFER1 IN ('1', '2', '3', '5', '9')  --��������
                        AND TRIM(NVL(A.REFER6, 'N')) = 'N'   --���ڼ��ݰ�꼭����
                    GROUP BY A.MANAGEMENT1
                    ) AA
                    , ( SELECT 
                              SUPP_CUST_CODE        --�ڵ�
                            , SUPP_CUST_NAME        --��ȣ
                            , TAX_REG_NO            --����ڵ�Ϲ�ȣ
                            , PRESIDENT_NAME        --��ǥ�ڼ���
                            , BUSINESS_CONDITION    --����
                            , BUSINESS_ITEM         --����
                        FROM FI_SUPP_CUST_V) B  --�ŷ�ó    
                WHERE AA.SUPPLIER_CODE = B.SUPP_CUST_CODE(+)
                ORDER BY TAX_REG_NO    
            )

    ) LOOP
    
        INSERT_VAT_E_FILE('���ݰ�꼭�հ�ǥ (���ڼ��ݰ�꼭 �̿ܺ�)�����ڷ�(Data Record)', REC_4_2.REC);

    END LOOP REC_4_2;



    --���ĸ� : (���ڼ��ݰ�꼭 �̿ܺ�)�����հ�(Total Record)  ���� : 170

    g_REPORT_CONTENT := NULL;            

    SELECT
           '4'              --1.�ڷᱸ��	    CHAR	1
        || t_VAT_NUMBER_10  --2.�����ڵ�Ϲ�ȣ	NUMBER	10  Null ���
        
        --(�հ��)		
        || LPAD(COMPANY_CNT, 7, 0)  --3.�ŷ�ó��	    NUMBER	7
        || LPAD(TOT_RECORD, 7, 0)   --4.���ݰ�꼭�ż�	NUMBER	7
        || LPAD(
                CASE
                    WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                    ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                        CASE SUBSTR(GL_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 15, '0') --5.���ް���	NUMBER	15
        || LPAD(
                CASE
                    WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                    ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                        CASE SUBSTR(VAT_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 14, '0') --6.����	NUMBER	14
        
        --(����ڹ�ȣ�����)		    
        || LPAD(COMPANY_CNT, 7, 0)  --7.�ŷ�ó��	    NUMBER	7
        || LPAD(TOT_RECORD, 7, 0)   --8.���ݰ�꼭�ż�	NUMBER	7
        || LPAD(
                CASE
                    WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                    ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                        CASE SUBSTR(GL_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 15, '0') --9.���ް���	NUMBER	15
        || LPAD(
                CASE
                    WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                    ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                        CASE SUBSTR(VAT_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 14, '0') --10.����	NUMBER	14    
        
        --(�ֹι�ȣ�����)		
        || LPAD(0, 7, 0)    --11.�ŷ�ó��	    NUMBER	7
        || LPAD(0, 7, 0)    --12.���ݰ�꼭�ż�	NUMBER	7
        || LPAD(0, 15, 0)   --13.���ް���	    NUMBER	15
        || LPAD(0, 14, 0)   --14.����	        NUMBER	14
        
        || RPAD(' ', 30, ' ')   --15.����	CHAR	30
    INTO g_REPORT_CONTENT
    FROM
        (


            SELECT
                  COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --����ó��
                , NVL(SUM(CNT), 0) AS TOT_RECORD                --�ż�
                , NVL(SUM(GL_AMOUNT), 0) AS GL_AMOUNT       --���ް���
                , NVL(SUM(VAT_AMOUNT), 0) AS VAT_AMOUNT     --����             
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                        , COUNT(*) AS CNT --�ż�
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '1111700'  --�ŷ����� : ����, �ΰ�����ޱ�(1111700)
                        AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������
                        AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű���������
                        AND A.REFER1 IN ('1', '2', '3', '5', '9')  --�������� 
                        AND TRIM(NVL(A.REFER6, 'N')) = 'N'   --���ڼ��ݰ�꼭����
                    GROUP BY  A.MANAGEMENT1  
                ) TC  
        )   ;
        
    INSERT_VAT_E_FILE('���ݰ�꼭�հ�ǥ (���ڼ��ݰ�꼭 �̿ܺ�)�����հ�(Total Record)', g_REPORT_CONTENT);



    --���ĸ� : ���ڼ��ݰ�꼭�� �����հ�(Total Record)  ���� : 170

    g_REPORT_CONTENT := NULL;            


    SELECT
           '6'              --1.�ڷᱸ��	    CHAR	1
        || t_VAT_NUMBER_10  --2.�����ڵ�Ϲ�ȣ	NUMBER	10  Null ���
        
        --(�հ��)		
        || LPAD(COMPANY_CNT, 7, 0)  --3.�ŷ�ó��	    NUMBER	7
        || LPAD(TOT_RECORD, 7, 0)   --4.���ݰ�꼭�ż�	NUMBER	7
        || LPAD(
                CASE
                    WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                    ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                        CASE SUBSTR(GL_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 15, '0') --5.���ް���	NUMBER	15
        || LPAD(
                CASE
                    WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                    ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                        CASE SUBSTR(VAT_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 14, '0') --6.����	NUMBER	14
        
        --(����ڹ�ȣ�����)		    
        || LPAD(COMPANY_CNT, 7, 0)  --7.�ŷ�ó��	    NUMBER	7
        || LPAD(TOT_RECORD, 7, 0)   --8.���ݰ�꼭�ż�	NUMBER	7
        || LPAD(
                CASE
                    WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                    ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                        CASE SUBSTR(GL_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 15, '0') --9.���ް���	NUMBER	15
        || LPAD(
                CASE
                    WHEN VAT_AMOUNT >= 0 THEN TO_CHAR(VAT_AMOUNT)
                    ELSE SUBSTRB(REPLACE(VAT_AMOUNT, '-', ''), 1, LENGTH(VAT_AMOUNT) - 2) ||
                        CASE SUBSTR(VAT_AMOUNT, -1, 1)
                            WHEN '1' THEN 'J'
                            WHEN '2' THEN 'K'
                            WHEN '3' THEN 'L'
                            WHEN '4' THEN 'M'
                            WHEN '5' THEN 'N'
                            WHEN '6' THEN 'O'
                            WHEN '7' THEN 'P'
                            WHEN '8' THEN 'Q'
                            WHEN '9' THEN 'R'
                            WHEN '0' THEN '}'
                        END
                END
              , 14, '0') --10.����	NUMBER	14    
        
        --(�ֹι�ȣ�����)		
        || LPAD(0, 7, 0)    --11.�ŷ�ó��	    NUMBER	7
        || LPAD(0, 7, 0)    --12.���ݰ�꼭�ż�	NUMBER	7
        || LPAD(0, 15, 0)   --13.���ް���	    NUMBER	15
        || LPAD(0, 14, 0)   --14.����	        NUMBER	14
        
        || RPAD(' ', 30, ' ')   --15.����	CHAR	30
    INTO g_REPORT_CONTENT
    FROM
        (
            SELECT
                  COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --����ó��
                , NVL(SUM(CNT), 0) AS TOT_RECORD                --�ż�
                , NVL(SUM(GL_AMOUNT), 0) AS GL_AMOUNT       --���ް���
                , NVL(SUM(VAT_AMOUNT), 0) AS VAT_AMOUNT     --����                 
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                        , COUNT(*) AS CNT --�ż�
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '1111700'  --�ŷ����� : ����, �ΰ�����ޱ�(1111700)
                        AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������
                        AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű���������
                        AND A.REFER1 IN ('1', '2', '3', '5', '9')  --�������� 
                        AND TRIM(NVL(A.REFER6, 'N')) = 'Y'   --���ڼ��ݰ�꼭����
                    GROUP BY  A.MANAGEMENT1   
                ) TB 
        )   ;
        
    INSERT_VAT_E_FILE('���ݰ�꼭�հ�ǥ ���ڼ��ݰ�꼭�� �����հ�(Total Record)', g_REPORT_CONTENT);


END IF; --IF t_E_FILE_SUM_VAT_YN = 'Y' THEN       --���ڽð����ϻ�����󿩺�_���ݰ�꼭�հ�ǥ



IF t_E_FILE_SUM_CALC_YN = 'Y' THEN      --���ڽŰ����ϻ�����󿩺�_��꼭�հ�ǥ

    --3-2.��꼭�հ�ǥ
    --���ĸ� : ������(�븮��)���ڵ� , ���� : 230

    g_REPORT_CONTENT := NULL;            

    SELECT
           'A'                  --1.���ڵ屸��	CHAR	1
        || t_TAX_OFFICE_CODE    --2.������	    CHAR	3   Null ���
        || TO_CHAR(W_CREATE_DATE, 'YYYYMMDD')    --3.��������	NUMBER	8
        || '2'   --4.�����ڱ���	NUMBER	1   [(1: �����븮��, 2: ����, 3:����) ]
        || RPAD(' ', 6, ' ')                    --5.�����븮�ΰ�����ȣ	CHAR	6   [�����븮���� �ƴ� ��쿡�� ����(space)���� ����]
        || t_VAT_NUMBER_10                      --6.����ڵ�Ϲ�ȣ	    CHAR	10
        || RPAD(t_CORP_NAME_30, 40, ' ')        --7.���θ�(��ȣ)	    CHAR	40
        || t_LEGAL_NUMBER                       --8.�ֹ�(����)��Ϲ�ȣ	CHAR	13
        || t_PRESIDENT_NAME_30                  --9.��ǥ��(����)	    CHAR	30
        || RPAD(NVL(t_ZIP_CODE, ' '), 10, ' ')  --10.������(������ȣ)�������ڵ�	CHAR	10  Null ���
        || t_LOCATION_70    --11.������(�ּ�)	CHAR	70
        || t_VAT_TEL        --12.��ȭ��ȣ	    CHAR	15
        
        --����ڴ� 1���̹Ƿ� ���Ƿ� 1�� �����Ѵ�.
        || LPAD(1, 5, 0)   --13.����Ǽ���	NUMBER	5   [�����ǹ���(�����) ��(B���ڵ��� ��)�� ����]
        
        || '101'                --14.������ѱ��ڵ�����	NUMBER	3
        || RPAD(' ', 15, ' ')   --15.����	            CHAR	15
    INTO g_REPORT_CONTENT
    FROM DUAL;
        
    INSERT_VAT_E_FILE('��꼭�հ�ǥ ������(�븮��)���ڵ�', g_REPORT_CONTENT);


    --���ĸ� : �����ǹ����������׷��ڵ� , ���� : 230


    g_REPORT_CONTENT := NULL;            

    SELECT
           'B'                                  --1.���ڵ屸��	    CHAR	1
        || t_TAX_OFFICE_CODE                    --2.������	        CHAR	3   Null ���
        || '000001'                             --3.�Ϸù�ȣ	    NUMBER	6
        || t_VAT_NUMBER_10                      --4.����ڵ�Ϲ�ȣ	CHAR	10
        || RPAD(t_CORP_NAME_30, 40, ' ')        --5.���θ�(��ȣ)	CHAR	40
        || t_PRESIDENT_NAME_30                  --6.��ǥ��(����)	CHAR	30
        || RPAD(NVL(t_ZIP_CODE, ' '), 10, ' ')  --7.�����(������ȣ)�������ڵ�	CHAR	10  Null ���
        || t_LOCATION_70                        --8.����������(�ּ�)	CHAR	70
        || RPAD(' ', 60, ' ')                   --9.����	            CHAR	60
    INTO g_REPORT_CONTENT
    FROM DUAL;
        
    INSERT_VAT_E_FILE('��꼭�հ�ǥ �����ǹ����������׷��ڵ�', g_REPORT_CONTENT);






    --����>�Ʒ� 2���� ������ �ڷᰡ ��� ������ �ʴ´�. 
    --    �̴� [������ �ʿ� ���� ÷�μ����� �������� �ʾƾ� �մϴ�. ]�ʹ� �� ������ �� �ٸ���. 
    --    �����꼭 �հ�ǥ�� ������ �ʿ䰡 ���� �� �ƴ϶� �ڷᰡ ��� �� ������̴�.
    
    --.���ĸ� : �����ǹ��ں����跹�ڵ�(����)  ���� : 230
    -- 2013-07-10 ��ȣ�� �߰� --    
    FOR REC_TAX IN (

        SELECT
               'C'  --1.���ڵ屸��	CHAR	1
            || '17' --2.�ڷᱸ��	NUMBER	2            
            ||  CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN ('01', '02', '03', '04', '05', '06') THEN '1'
                    ELSE '2'
                END --3.�ⱸ��	CHAR	1
            ||  CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '07', '08', '09') THEN '1'  -- �����Ű�
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '05', '06', '10', '11', '12') THEN '2'  -- Ȯ���Ű�
                END --4.�Ű�����	CHAR	1   [�����̸� 1, Ȯ���̸� 2]
            || t_TAX_OFFICE_CODE    --5.������	        CHAR	3   Null ���            
            || '000001'   --6.�Ϸù�ȣ	    NUMBER	6
            || t_VAT_NUMBER_10      --7.����ڵ�Ϲ�ȣ	CHAR	10
            || LPAD(t_TAX_YEAR, 4, '0')   -- �ͼӳ⵵ 
            || RPAD(t_REPORT_FR, 8, '0')  -- �ŷ��Ⱓ���۳���� 
            || RPAD(t_REPORT_TO, 8, '0')  -- �ŷ��Ⱓ��������
            || RPAD(TO_CHAR(W_CREATE_DATE, 'YYYYMMDD'), 8, '0')  -- �ۼ�����
            || LPAD(NVL(SX1.TOTAL_CUSTOMER_COUNT, 0), 6, '0')    -- 12.����ó���հ�  
            || LPAD(NVL(SX1.TOTAL_VAT_COUNT, 0), 6, '0')         -- 13.��꼭�ż��հ� 
            || LPAD(NVL(SX1.TOTAL_SIGN_AMOUNT, 0), 1, '0')       -- 14.����ݾ��հ�����ǥ�� 
            || LPAD(NVL(SX1.TOTAL_GL_AMOUNT, 0), 14, '0')        -- 15.����ݾ��հ� 
            || LPAD(NVL(SX1.CUSTOMER_COUNT, 0), 6, '0')          -- 16.����ڵ�Ϲ�ȣ����и���ó�� 
            || LPAD(NVL(SX1.CUSTOMER_VAT_COUNT, 0), 6, '0')      -- 17.����ڵ�Ϲ�ȣ ����� ����ݾ�����ǥ�� 
            || LPAD(NVL(SX1.CUSTOMER_SIGN_AMOUNT, 0), 1, '0')    -- 18.����ڵ�Ϲ�ȣ ����� ����ݾ�����ǥ��
            || LPAD(NVL(SX1.CUSTOMER_GL_AMOUNT, 0), 14, '0')     -- 19.����ڵ�Ϲ�ȣ����и���(����)�ݾ� 
            || LPAD(NVL(SX1.PERSON_COUNT, 0), 6, '0')            -- 20.�ֹι�ȣ����и���ó�� 
            || LPAD(NVL(SX1.PERSON_VAT_COUNT, 0), 6, '0')        -- 21.�ֹι�ȣ ����� ����ݾ�����ǥ�� 
            || LPAD(NVL(SX1.PERSON_SIGN_AMOUNT, 0), 1, '0')      -- 22.�ֹι�ȣ ����� ����ݾ�����ǥ��
            || LPAD(NVL(SX1.PERSON_GL_AMOUNT, 0), 14, '0')       -- 23.�ֹι�ȣ����и���(����)�ݾ�                            
            || RPAD(' ', 97, ' ') AS REC
        FROM
            (   SELECT  COUNT(DISTINCT A.MANAGEMENT1) AS TOTAL_CUSTOMER_COUNT    --�ŷ�ó�ڵ�
                      , COUNT(*) AS TOTAL_VAT_COUNT --�ż�
                      , CASE
                          WHEN SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''), '999999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.')) < 0 THEN '1'
                          ELSE '0'
                        END AS TOTAL_SIGN_AMOUNT
                      , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''), '999999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.')) AS TOTAL_GL_AMOUNT     --���ް���                    
                      
                      , COUNT(DISTINCT DECODE(SC.BUSINESS_TYPE_S, 'P', NULL, A.MANAGEMENT1)) AS CUSTOMER_COUNT    --�ŷ�ó�ڵ�
                      , SUM(DECODE(SC.BUSINESS_TYPE_S, 'P', 0, 1)) AS CUSTOMER_VAT_COUNT --�ż�
                      , CASE
                          WHEN SUM(DECODE(SC.BUSINESS_TYPE_S, 'P', 0, TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''), '999999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.'))) < 0 THEN '1'
                          ELSE '0'
                        END AS CUSTOMER_SIGN_AMOUNT
                      , SUM(DECODE(SC.BUSINESS_TYPE_S, 'P', 0, TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''), '999999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.'))) AS CUSTOMER_GL_AMOUNT     --���ް���   
                      
                      , COUNT(DISTINCT DECODE(SC.BUSINESS_TYPE_S, 'P', A.MANAGEMENT1, NULL)) AS PERSON_COUNT    --�ŷ�ó�ڵ�
                      , SUM(DECODE(SC.BUSINESS_TYPE_S, 'P', 1, 0)) AS PERSON_VAT_COUNT --�ż�
                      , CASE
                          WHEN SUM(DECODE(SC.BUSINESS_TYPE_S, 'P', TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''), '999999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.'), 0)) < 0 THEN '1'
                          ELSE '0'
                        END AS PERSON_SIGN_AMOUNT
                      , SUM(DECODE(SC.BUSINESS_TYPE_S, 'P', TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''), '999999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.'), 0)) AS PERSON_GL_AMOUNT     --���ް���   
                                             
                  FROM FI_SLIP_LINE A
                     , FI_SUPP_CUST_V SC
                  WHERE A.MANAGEMENT1  = SC.SUPP_CUST_CODE
                      AND A.SOB_ID = W_SOB_ID
                      AND A.ORG_ID = W_ORG_ID 
                      AND A.ACCOUNT_CODE = '2100700'  --�ŷ�����(����/����)TAX_CODE  --�����
                      AND A.REFER11 = W_TAX_CODE  --�����
                      AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű���������
                      AND A.MANAGEMENT2 = '4'  --�������� 
                      AND NVL(A.REFER7, 'N') != 'Y'  -- ���ڼ��ݰ�꼭  
                  HAVING COUNT(*) != 0
            ) SX1
    ) LOOP
    
        INSERT_VAT_E_FILE('�����ǹ��ں����跹�ڵ�(����)', REC_TAX.REC);

    END LOOP REC_TAX;
    
    
    --.���ĸ� : ����ó���ŷ��������ڵ�  ���� : 230
    -- 2013-07-10 ��ȣ�� �߰� --    
    FOR REC_TAX IN (

        SELECT
               'D'  --1.���ڵ屸��	CHAR	1
            || '17' --2.�ڷᱸ��	NUMBER	2            
            ||  CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN ('01', '02', '03', '04', '05', '06') THEN '1'
                    ELSE '2'
                END --3.�ⱸ��	CHAR	1
            ||  CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '07', '08', '09') THEN '1'  -- �����Ű�
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '05', '06', '10', '11', '12') THEN '2'  -- Ȯ���Ű�
                END --4.�Ű�����	CHAR	1   [�����̸� 1, Ȯ���̸� 2]
            || t_TAX_OFFICE_CODE    --5.������	        CHAR	3   Null ���            
            || LPAD(ROWNUM, 6, 0)   --6.�Ϸù�ȣ	    NUMBER	6
            || t_VAT_NUMBER_10      --7.����ڵ�Ϲ�ȣ	CHAR	10
            || RPAD(SX1.TAX_REG_NO, 10, ' ')  -- 8����ó����ڵ�Ϲ�ȣ 
            || RPAD(SX1.SUPP_CUST_NAME, 40, ' ')  -- 9����ó���θ� 
            || LPAD(NVL(SX1.VAT_COUNT, 0), 5, '0')         -- 10.��꼭�ż��հ� 
            || LPAD(NVL(SX1.SIGN_AMOUNT, 0), 1, '0')       -- 11.����ݾ��հ�����ǥ�� 
            || LPAD(NVL(SX1.GL_AMOUNT, 0), 14, '0')        -- 12.����ݾ��հ� 
            || RPAD(' ', 136, ' ') AS REC
        FROM
            (   SELECT   A.MANAGEMENT1 AS CUSTOMER_CODE    --�ŷ�ó�ڵ�
                      , REPLACE(SC.TAX_REG_NO, '-', '') AS TAX_REG_NO  -- ����ڹ�ȣ 
                      , SC.SUPP_CUST_NAME
                      , COUNT(*) AS VAT_COUNT --�ż�
                      , CASE
                          WHEN SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''), '999999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.')) < 0 THEN '1'
                          ELSE '0'
                        END AS SIGN_AMOUNT
                      , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''), '999999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.')) AS GL_AMOUNT     --���ް���                                                                 
                  FROM FI_SLIP_LINE A
                     , FI_SUPP_CUST_V SC
                  WHERE A.MANAGEMENT1  = SC.SUPP_CUST_CODE
                      AND A.SOB_ID = W_SOB_ID
                      AND A.ORG_ID = W_ORG_ID 
                      AND A.ACCOUNT_CODE = '2100700'  --�ŷ�����(����/����)TAX_CODE  --�����
                      AND A.REFER11 = W_TAX_CODE  --�����
                      AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű���������
                      AND A.MANAGEMENT2 = '4'  --�������� 
                      AND NVL(A.REFER7, 'N') != 'Y'  -- ���ڼ��ݰ�꼭 
                 GROUP BY A.MANAGEMENT1    --�ŷ�ó�ڵ�
                        , REPLACE(SC.TAX_REG_NO, '-', '')  -- ����ڹ�ȣ 
                        , SC.SUPP_CUST_NAME
                 HAVING COUNT(*) != 0
            ) SX1
    ) LOOP
    
        INSERT_VAT_E_FILE('����ó���ŷ��������ڵ�', REC_TAX.REC);

    END LOOP REC_TAX;


-- 2013-07-10 ��ȣ�� �߰� : ���ڰ�꼭 �������跹�ڵ�(����) �߰� --    
    --.���ĸ� : ����ó���ŷ��������ڵ�  ���� : 230
    FOR REC_TAX IN (

        SELECT
               'E'  --1.���ڵ屸��	CHAR	1
            || '17' --2.�ڷᱸ��	NUMBER	2            
            ||  CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN ('01', '02', '03', '04', '05', '06') THEN '1'
                    ELSE '2'
                END --3.�ⱸ��	CHAR	1
            ||  CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '07', '08', '09') THEN '1'  -- �����Ű�
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '05', '06', '10', '11', '12') THEN '2'  -- Ȯ���Ű�
                END --4.�Ű�����	CHAR	1   [�����̸� 1, Ȯ���̸� 2]
            || t_TAX_OFFICE_CODE    --5.������	        CHAR	3   Null ���            
            || LPAD(ROWNUM, 6, 0)   --6.�Ϸù�ȣ	    NUMBER	6
            || t_VAT_NUMBER_10      --7.����ڵ�Ϲ�ȣ	CHAR	10
            || LPAD(t_TAX_YEAR, 4, '0')   -- �ͼӳ⵵ 
            || RPAD(t_REPORT_FR, 8, '0')  -- �ŷ��Ⱓ���۳���� 
            || RPAD(t_REPORT_TO, 8, '0')  -- �ŷ��Ⱓ��������
            || RPAD(TO_CHAR(W_CREATE_DATE, 'YYYYMMDD'), 8, '0')  -- �ۼ�����
            || LPAD(NVL(SX1.TOTAL_CUSTOMER_COUNT, 0), 6, '0')    -- 12.����ó���հ�  
            || LPAD(NVL(SX1.TOTAL_VAT_COUNT, 0), 6, '0')         -- 13.��꼭�ż��հ� 
            || LPAD(NVL(SX1.TOTAL_SIGN_AMOUNT, 0), 1, '0')       -- 14.����ݾ��հ�����ǥ�� 
            || LPAD(NVL(SX1.TOTAL_GL_AMOUNT, 0), 14, '0')        -- 15.����ݾ��հ� 
            || LPAD(NVL(SX1.CUSTOMER_COUNT, 0), 6, '0')          -- 16.����ڵ�Ϲ�ȣ����и���ó�� 
            || LPAD(NVL(SX1.CUSTOMER_VAT_COUNT, 0), 6, '0')      -- 17.����ڵ�Ϲ�ȣ ����� ����ݾ�����ǥ�� 
            || LPAD(NVL(SX1.CUSTOMER_SIGN_AMOUNT, 0), 1, '0')    -- 18.����ڵ�Ϲ�ȣ ����� ����ݾ�����ǥ��
            || LPAD(NVL(SX1.CUSTOMER_GL_AMOUNT, 0), 14, '0')     -- 19.����ڵ�Ϲ�ȣ����и���(����)�ݾ� 
            || LPAD(NVL(SX1.PERSON_COUNT, 0), 6, '0')            -- 20.�ֹι�ȣ����и���ó�� 
            || LPAD(NVL(SX1.PERSON_VAT_COUNT, 0), 6, '0')        -- 21.�ֹι�ȣ ����� ����ݾ�����ǥ�� 
            || LPAD(NVL(SX1.PERSON_SIGN_AMOUNT, 0), 1, '0')      -- 22.�ֹι�ȣ ����� ����ݾ�����ǥ��
            || LPAD(NVL(SX1.PERSON_GL_AMOUNT, 0), 14, '0')       -- 23.�ֹι�ȣ����и���(����)�ݾ�                            
            || RPAD(' ', 97, ' ') AS REC
        FROM
            (   SELECT  COUNT(DISTINCT A.MANAGEMENT1) AS TOTAL_CUSTOMER_COUNT    --�ŷ�ó�ڵ�
                      , COUNT(*) AS TOTAL_VAT_COUNT --�ż�
                      , CASE
                          WHEN SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''), '999999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.')) < 0 THEN '1'
                          ELSE '0'
                        END AS TOTAL_SIGN_AMOUNT
                      , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''), '999999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.')) AS TOTAL_GL_AMOUNT     --���ް���                    
                      
                      , COUNT(DISTINCT DECODE(SC.BUSINESS_TYPE_S, 'P', NULL, A.MANAGEMENT1)) AS CUSTOMER_COUNT    --�ŷ�ó�ڵ�
                      , SUM(DECODE(SC.BUSINESS_TYPE_S, 'P', 0, 1)) AS CUSTOMER_VAT_COUNT --�ż�
                      , CASE
                          WHEN SUM(DECODE(SC.BUSINESS_TYPE_S, 'P', 0, TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''), '999999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.'))) < 0 THEN '1'
                          ELSE '0'
                        END AS CUSTOMER_SIGN_AMOUNT
                      , SUM(DECODE(SC.BUSINESS_TYPE_S, 'P', 0, TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''), '999999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.'))) AS CUSTOMER_GL_AMOUNT     --���ް���   
                      
                      , COUNT(DISTINCT DECODE(SC.BUSINESS_TYPE_S, 'P', A.MANAGEMENT1, NULL)) AS PERSON_COUNT    --�ŷ�ó�ڵ�
                      , SUM(DECODE(SC.BUSINESS_TYPE_S, 'P', 1, 0)) AS PERSON_VAT_COUNT --�ż�
                      , CASE
                          WHEN SUM(DECODE(SC.BUSINESS_TYPE_S, 'P', TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''), '999999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.'), 0)) < 0 THEN '1'
                          ELSE '0'
                        END AS PERSON_SIGN_AMOUNT
                      , SUM(DECODE(SC.BUSINESS_TYPE_S, 'P', TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''), '999999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.'), 0)) AS PERSON_GL_AMOUNT     --���ް���   
                                             
                  FROM FI_SLIP_LINE A
                     , FI_SUPP_CUST_V SC
                  WHERE A.MANAGEMENT1  = SC.SUPP_CUST_CODE
                      AND A.SOB_ID = W_SOB_ID
                      AND A.ORG_ID = W_ORG_ID 
                      AND A.ACCOUNT_CODE = '2100700'  --�ŷ�����(����/����)TAX_CODE  --�����
                      AND A.REFER11 = W_TAX_CODE  --�����
                      AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű���������
                      AND A.MANAGEMENT2 = '4'  --�������� 
                      AND NVL(A.REFER7, 'N') = 'Y'  -- ���ڼ��ݰ�꼭 
                  HAVING COUNT(*) != 0
            ) SX1
    ) LOOP
    
        INSERT_VAT_E_FILE('���ڰ�꼭 �������跹�ڵ�(����)', REC_TAX.REC);

    END LOOP REC_TAX;
    
    
    
    --.���ĸ� : �����ǹ��ں����跹�ڵ�(����)  ���� : 230

    g_REPORT_CONTENT := NULL;            

    SELECT
           'C'  --1.���ڵ屸��	CHAR	1
        || '18' --2.�ڷᱸ��	NUMBER	2
        ||  CASE 
                WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN ('01', '02', '03', '04', '05', '06') THEN '1'
                ELSE '2'
            END --3.�ⱸ��	CHAR	1
        ||  CASE 
                WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '07', '08', '09') THEN '1'  -- �����Ű�
                WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '05', '06', '10', '11', '12') THEN '2'  -- Ȯ���Ű�
            END --4.�Ű�����	CHAR	1   [�����̸� 1, Ȯ���̸� 2]
        || t_TAX_OFFICE_CODE    --5.������	        CHAR	3   Null ���
        || '000001'             --6.�Ϸù�ȣ	    NUMBER	6
        || t_VAT_NUMBER_10      --7.����ڵ�Ϲ�ȣ	CHAR	10
        || LPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYY'), 4, 0)     --8.�ͼӳ⵵	        NUMBER	4   Null ���
        || LPAD(TO_CHAR(W_ISSUE_DATE_FR, 'YYYYMMDD'), 8, 0) --9.�ŷ��Ⱓ���۳����	NUMBER	8   Null ���
        || LPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMMDD'), 8, 0) --10.�ŷ��Ⱓ��������	NUMBER	8   Null ���
        || LPAD(TO_CHAR(W_CREATE_DATE, 'YYYYMMDD'), 8, 0)   --11.�ۼ�����	        NUMBER	8   Null ���
        || LPAD(COMPANY_CNT, 6, 0)   --12.����ó���հ�	    NUMBER	6
        || LPAD(TOTAL_RECORD, 6, 0)  --13.��꼭�ż��հ�	NUMBER	6
        || CASE 
                WHEN GL_AMOUNT >= 0 THEN 0
                ELSE 1
           END                      --14.���Աݾ��հ�����ǥ��	NUMBER	1
        || LPAD(GL_AMOUNT, 14, 0)   --15.���Աݾ��հ�	        NUMBER	14
        || RPAD(' ', 151, ' ')      --16.����	                CHAR	151
    INTO g_REPORT_CONTENT
    FROM
        (
            SELECT
                  '��  ��' AS TITLE
                , COUNT(SUPPLIER_CODE) AS COMPANY_CNT --�ŷ�ó ��
                , NVL(SUM(CNT), 0) AS TOTAL_RECORD --�ż�
                , NVL(SUM(GL_AMOUNT), 0) AS GL_AMOUNT --���ް���
                , LENGTH(NVL(SUM(GL_AMOUNT), 0)) AS AMT_LEN   --��½� ����� ������, ���ް����� ����       
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                        , COUNT(*) AS CNT --�ż�
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
                        AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������
                        AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű���������
                        AND A.REFER1 = '4'  --�������� 
                        AND NVL(A.REFER6, 'N') != 'Y'   
                    GROUP BY  A.MANAGEMENT1 
                    HAVING COUNT(*) != 0
                ) AA     
        )   ;  
        
    INSERT_VAT_E_FILE('��꼭�հ�ǥ �����ǹ��ں����跹�ڵ�(����)', g_REPORT_CONTENT);



    --.���ĸ� : ����ó���ŷ��������ڵ�  ���� : 230

    FOR REC_TAX IN (

        SELECT
               'D'  --1.���ڵ屸��	CHAR	1
            || '18' --2.�ڷᱸ��	NUMBER	2            
            ||  CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN ('01', '02', '03', '04', '05', '06') THEN '1'
                    ELSE '2'
                END --3.�ⱸ��	CHAR	1
            ||  CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '07', '08', '09') THEN '1'  -- �����Ű�
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '05', '06', '10', '11', '12') THEN '2'  -- Ȯ���Ű�
                END --4.�Ű�����	CHAR	1   [�����̸� 1, Ȯ���̸� 2]
            || t_TAX_OFFICE_CODE    --5.������	        CHAR	3   Null ���            
            || LPAD(ROWNUM, 6, 0)   --6.�Ϸù�ȣ	    NUMBER	6
            || t_VAT_NUMBER_10      --7.����ڵ�Ϲ�ȣ	CHAR	10
            || RPAD(REPLACE(TAX_REG_NO, '-', ''), 10, ' ')  --8.����ó����ڵ�Ϲ�ȣ	CHAR	10
            || RPAD(SUPPLIER_NAME, 40, ' ')                 --9.����ó���θ�(��ȣ)	    CHAR	40
            || LPAD(COMPANY_CNT, 5, 0)                      --10.��꼭�ż�	            NUMBER	5
            || CASE 
                    WHEN GL_AMOUNT >= 0 THEN 0
                    ELSE 1
               END  --11.���Աݾ�����ǥ��	NUMBER	1
            --|| LPAD(GL_AMOUNT, 14, 0)   --12.���Աݾ�	NUMBER	14
            || LPAD(ABS(GL_AMOUNT), 14, 0)   --12.���Աݾ�	NUMBER	14
            || RPAD(' ', 136, ' ')      --13.����	    CHAR	136 
            AS REC
        FROM
            (
                SELECT
                      AA.SUPPLIER_CODE --�ŷ�ó�ڵ�
                    , B.TAX_REG_NO                    --����ڵ�Ϲ�ȣ      
                    , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --��ȣ(���θ�)      
                    , AA.COMPANY_CNT  --�ż�                 
                    , AA.GL_AMOUNT     --���ް���                    
                    , B.PRESIDENT_NAME        --��ǥ�ڼ���
                    , B.BUSINESS_CONDITION    --����
                    , B.BUSINESS_ITEM         --����
                FROM
                    (
                    SELECT
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                        , COUNT(*) AS COMPANY_CNT           --�ż�     
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���     
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '1111700'  --�ŷ����� : ����
                        AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������
                        AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű���������
                        AND A.REFER1 = '4'  --��������
                        AND NVL(A.REFER6, 'N') != 'Y'   
                    GROUP BY A.MANAGEMENT1
                    ) AA
                    , ( SELECT 
                              SUPP_CUST_CODE        --�ڵ�
                            , SUPP_CUST_NAME        --��ȣ
                            , TAX_REG_NO            --����ڵ�Ϲ�ȣ
                            , PRESIDENT_NAME        --��ǥ�ڼ���
                            , BUSINESS_CONDITION    --����
                            , BUSINESS_ITEM         --����
                        FROM FI_SUPP_CUST_V) B  --�ŷ�ó    
                WHERE AA.SUPPLIER_CODE = B.SUPP_CUST_CODE(+)
                ORDER BY TAX_REG_NO    
            )

    ) LOOP
    
        INSERT_VAT_E_FILE('��꼭�հ�ǥ ����ó���ŷ��������ڵ�', REC_TAX.REC);

    END LOOP REC_TAX;


    -- 2013-07-10 ��ȣ�� �߰� : ���ڰ�꼭 �������跹�ڵ�(����) �߰� --    
    --.���ĸ� : ����ó���ŷ��������ڵ�  ���� : 230

    FOR REC_TAX IN (

        SELECT
               'E'  --1.���ڵ屸��	CHAR	1
            || '18' --2.�ڷᱸ��	NUMBER	2            
            ||  CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN ('01', '02', '03', '04', '05', '06') THEN '1'
                    ELSE '2'
                END --3.�ⱸ��	CHAR	1
            ||  CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '07', '08', '09') THEN '1'  -- �����Ű�
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '05', '06', '10', '11', '12') THEN '2'  -- Ȯ���Ű�
                END --4.�Ű�����	CHAR	1   [�����̸� 1, Ȯ���̸� 2]
            || t_TAX_OFFICE_CODE    --5.������	        CHAR	3   Null ���            
            || LPAD(ROWNUM, 6, 0)   --6.�Ϸù�ȣ	    NUMBER	6
            || t_VAT_NUMBER_10      --7.����ڵ�Ϲ�ȣ	CHAR	10
            || LPAD(t_TAX_YEAR, 4, '0')   -- �ͼӳ⵵ 
            || RPAD(t_REPORT_FR, 8, '0')  -- �ŷ��Ⱓ���۳���� 
            || RPAD(t_REPORT_TO, 8, '0')  -- �ŷ��Ⱓ��������
            || RPAD(TO_CHAR(W_CREATE_DATE, 'YYYYMMDD'), 8, '0')  -- �ۼ�����
            || LPAD(NVL(SX1.SUPPLIER_COUNT, 0), 6, '0')          -- 12.����ó���հ�  
            || LPAD(NVL(SX1.CNT, 0), 6, '0')         -- 13.��꼭�ż��հ� 
            || LPAD(NVL(SX1.SIGN_FLAG, 0), 1, '0')       -- 14.���Աݾ��հ�����ǥ�� 
            || LPAD(NVL(SX1.GL_AMOUNT, 0), 14, '0')        -- 15.���Աݾ��հ�                           
            || RPAD(' ', 151, ' ') AS REC
        FROM
            ( SELECT             
                      COUNT(DISTINCT A.MANAGEMENT1) AS SUPPLIER_COUNT    --�ŷ�ó�ڵ�
                    , COUNT(*) AS CNT --�ż�
                    , CASE
                        WHEN SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''), '999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.')) < 0 THEN '1'
                        ELSE '0'
                      END SIGN_FLAG
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''), '999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.')) AS GL_AMOUNT     --���ް���
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
                    AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                    AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű���������
                    AND A.REFER1 = '4'  --��������  
                    AND NVL(A.REFER6, 'N') = 'Y'   
                HAVING COUNT(*) != 0                     
            ) SX1
    ) LOOP
    
        INSERT_VAT_E_FILE('���ڰ�꼭 �������跹�ڵ�', REC_TAX.REC);

    END LOOP REC_TAX;
    
END IF; --IF t_E_FILE_SUM_CALC_YN = 'Y' THEN      --���ڽŰ����ϻ�����󿩺�_��꼭�հ�ǥ




IF t_E_FILE_EXPORT_YN = 'Y' THEN        --���ڽŰ����ϻ�����󿩺�_�������������

    --3-3.�������������
    --.���ĸ� : A ���ڵ�(ǥ��)   ���� : 180

    g_REPORT_CONTENT := NULL;            

    SELECT
           'A'  --1.�ڷᱸ��_ǥ��	CHAR	1
        || RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMM'), 6, ' ') --2.����Ű����(�ͼӳ��)	CHAR	6   [�ŷ��Ⱓ�� ������]
        || '3'              --3.�Ű�����	    CHAR	1   [3 �������� ��� 3]
        || t_VAT_NUMBER_10  --4.����ڵ�Ϲ�ȣ	CHAR	10
        || t_CORP_NAME_30   --5.���θ�(��ȣ)	CHAR	30
        || RPAD(t_PRESIDENT_NAME_30, 15, ' ')   --6.����(��ǥ�ڸ�)_����	CHAR	15
        || RPAD(t_LOCATION_70, 45, ' ')         --7.����������_����	CHAR	45
        || RPAD(g_BUSINESS_ITEM_30, 17, ' ')    --8.���¸�_����	        CHAR	17
        || RPAD(g_BUSINESS_TYPE_50, 25, ' ')    --9.�����_����	        CHAR	25        
        || RPAD(TO_CHAR(W_ISSUE_DATE_FR, 'YYYYMMDD'), 8, ' ')
        || RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMMDD'), 8, ' ')   --10.�ŷ��Ⱓ	CHAR	16  [�Ű��Ⱓ�� ù���� ��������]
        || RPAD(TO_CHAR(W_CREATE_DATE, 'YYYYMMDD'), 8, 0)       --11.�ۼ�����   CHAR	8                
        || RPAD(' ', 6, ' ')   --12.����	CHAR	6
    INTO g_REPORT_CONTENT
    FROM DUAL;
        
    INSERT_VAT_E_FILE('������������� A ���ڵ�(ǥ��)', g_REPORT_CONTENT);    


    
    --.���ĸ� : B ���ڵ�(�հ�)   ���� : 180

    FOR REC_EXPORT IN (

        SELECT
              '9' SEQ
            , '��             ��' AS GUBUN    --����
            , COUNT(*) AS DATA_CNT            --�Ǽ�
            , NVL(SUM(TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', ''))), 0) AS CURRENCY_AMOUNT   --��ȭ�ݾ�
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT --��ȭ�ݾ�
        FROM FI_SLIP_LINE A
        WHERE   A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����
            AND MANAGEMENT2 = '3'           --�������� : ����        
            AND A.REFER11 = W_TAX_CODE      --�����(����/������� ������� �ƴ� ȸ�� �ڷῡ �Ϲ������� ���Ǵ� �������)
            
            --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������
            AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO --�Ű���������

        UNION ALL

        SELECT
             '10' SEQ
            , '��  ��   ��  ȭ' AS GUBUN    --����
            , COUNT(*) AS DATA_CNT          --�Ǽ�
            , NVL(SUM(TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', ''))), 0) AS CURRENCY_AMOUNT   --��ȭ�ݾ�
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT --��ȭ�ݾ�
        FROM FI_SLIP_LINE A
        WHERE   A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����
            AND MANAGEMENT2 = '3'           --�������� : ���� 
            AND A.REFER4 IS NOT NULL
            AND A.REFER11 = W_TAX_CODE      --�����(����/������� ������� �ƴ� ȸ�� �ڷῡ �Ϲ������� ���Ǵ� �������)
            
            --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������
            AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO --�Ű���������

        UNION ALL

        SELECT
             '11' SEQ
            , '��Ÿ����������' AS GUBUN    --����
            , COUNT(*) AS DATA_CNT         --�Ǽ�
            , NVL(SUM(TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', ''))), 0) AS CURRENCY_AMOUNT   --��ȭ�ݾ�
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT --��ȭ�ݾ�
        FROM FI_SLIP_LINE A
        WHERE   A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����
            AND MANAGEMENT2 = '3'           --�������� : ����    
            AND A.REFER4 IS NULL
            AND A.REFER11 = W_TAX_CODE      --�����(����/������� ������� �ƴ� ȸ�� �ڷῡ �Ϲ������� ���Ǵ� �������)
            
            --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������
            AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO --�Ű���������
            
    ) LOOP

        IF REC_EXPORT.SEQ  = 9 THEN   --'��             ��'
            t_EXP_SUM_CNT := REC_EXPORT.DATA_CNT;
            t_EXP_SUM_FOR := REC_EXPORT.CURRENCY_AMOUNT;
            t_EXP_SUM_KOR := REC_EXPORT.GL_AMOUNT;
        ELSIF REC_EXPORT.SEQ  = 10 THEN --'��  ��   ��  ȭ'
            t_EXP_ITEM_CNT := REC_EXPORT.DATA_CNT;
            t_EXP_ITEM_FOR := REC_EXPORT.CURRENCY_AMOUNT;
            t_EXP_ITEM_KOR := REC_EXPORT.GL_AMOUNT;        
        ELSIF REC_EXPORT.SEQ  = 11 THEN --'��Ÿ����������'
            t_EXP_OTHER_CNT := REC_EXPORT.DATA_CNT;
            t_EXP_OTHER_FOR := REC_EXPORT.CURRENCY_AMOUNT;
            t_EXP_OTHER_KOR := REC_EXPORT.GL_AMOUNT;              
        END IF;
                
    END LOOP REC_EXPORT;
    

    g_REPORT_CONTENT := NULL;
    
    SELECT
           'B'  --1.�ڷᱸ��_�հ�	 CHAR	1
        || RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMM'), 6, ' ') --2.����Ű����(�ͼӳ��)	CHAR	6   [�ŷ��Ⱓ�� ������]
        || '3'              --3.�Ű�����	    CHAR	1   [3 �������� ��� 3]
        || t_VAT_NUMBER_10  --4.����ڵ�Ϲ�ȣ	CHAR	10               

        --������ ��� ��ƼŰ(Multi-Key) ����� �ؾ��ϴµ�, �׷����� ��� ó�����Ѵ�.
        || LPAD(NVL(t_EXP_SUM_CNT, 0), 7, 0)    --5.�Ǽ��հ�_����	 NUMBER	7
        || LPAD(REPLACE(TO_CHAR(NVL(t_EXP_SUM_FOR, 0), 'FM9999999999999.00'), '.', ''), 15, 0)  --6.��ȭ�ݾ�_�հ�	 NUMBER	15,2
        || LPAD(NVL(t_EXP_SUM_KOR, 0), 15, 0)   --7.��ȭ�ݾ�_�հ�	 NUMBER	15        
        || LPAD(NVL(t_EXP_ITEM_CNT, 0), 7, 0)    --8.�Ǽ�_��ȭ	 NUMBER	7
        || LPAD(REPLACE(TO_CHAR(NVL(t_EXP_ITEM_FOR, 0), 'FM9999999999999.00'), '.', ''), 15, 0)  --9.��ȭ�ݾ�_��ȭ	 NUMBER	15,2
        || LPAD(NVL(t_EXP_ITEM_KOR, 0), 15, 0)   --10.��ȭ�ݾ�_��ȭ	 NUMBER	15        
        || LPAD(NVL(t_EXP_OTHER_CNT, 0), 7, 0)    --11.�Ǽ�_��Ÿ	 NUMBER	7
        || LPAD(REPLACE(TO_CHAR(NVL(t_EXP_OTHER_FOR, 0), 'FM9999999999999.00'), '.', ''), 15, 0)  --12.��ȭ�ݾ�_��Ÿ	 NUMBER	15,2
        || LPAD(NVL(t_EXP_OTHER_KOR, 0), 15, 0)   --13.��ȭ�ݾ�_��Ÿ	 NUMBER	15
        
        || RPAD(' ', 51, ' ')    --14.�� ��	 CHAR	51
        AS REC
    INTO g_REPORT_CONTENT
    FROM DUAL ;
        
    INSERT_VAT_E_FILE('������������� B ���ڵ�(�հ�)', g_REPORT_CONTENT);   
    
    
    
    
    --.���ĸ� : C ���ڵ�(�ڷ�)   ���� : 180

    FOR REC_EXP_OUTPUT IN (

        SELECT
               'C'   --1.�ڷᱸ��_�ڷ�	 CHAR	 1
            || RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYYMM'), 6, ' ') --2.����Ű����(�ͼӳ��)	CHAR	6   [�ŷ��Ⱓ�� ������]
            || '3'              --3.�Ű�����	    CHAR	1   [3 �������� ��� 3]
            || t_VAT_NUMBER_10  --4.����ڵ�Ϲ�ȣ	CHAR	10             
            || LPAD(ROWNUM, 7, 0)                               --5.�����Ϸù�ȣ  CHAR    7
            || RPAD(REPLACE(EXPORT_NO, '-', ''), 15, ' ')       --6.����Ű���ȣ  CHAR    15
            || RPAD(REPLACE(VAT_ISSUE_DATE, '-', ''), 8, ' ')   --7.����(��)����  CHAR    8
            || RPAD(CURRENCY_CODE, 3, ' ')                      --8.������ȭ�ڵ�  CHAR    3
            || LPAD(REPLACE(EXCHANGE_RATE, '.', ''), 9, 0)      --9.ȯ    ��      NUMBER  9,4
            
            || LPAD(REPLACE(CURRENCY_AMOUNT, '.', ''), 15, 0)   --10.��ȭ�ݾ�     NUMBER  15,2
                       
            || LPAD(
                    CASE
                        WHEN GL_AMOUNT >= 0 THEN TO_CHAR(GL_AMOUNT)
                        ELSE SUBSTRB(REPLACE(GL_AMOUNT, '-', ''), 1, LENGTH(GL_AMOUNT) - 2) ||
                            CASE SUBSTR(GL_AMOUNT, -1, 1)
                                WHEN '1' THEN 'J'
                                WHEN '2' THEN 'K'
                                WHEN '3' THEN 'L'
                                WHEN '4' THEN 'M'
                                WHEN '5' THEN 'N'
                                WHEN '6' THEN 'O'
                                WHEN '7' THEN 'P'
                                WHEN '8' THEN 'Q'
                                WHEN '9' THEN 'R'
                                WHEN '0' THEN '}'
                            END
                    END
                  , 15, '0') --11.��ȭ�ݾ�	 NUMBER	 15


            || RPAD(' ', 90, ' ')       --12.��    ��	 CHAR	 90 
            AS REC
        FROM 
            (
                SELECT
                      A.REFER4 AS EXPORT_NO         --����Ű���ȣ 
                    , A.REFER1 AS VAT_ISSUE_DATE    --��(��)������ ; �Ű���������        
                    , A.REFER3 AS CURRENCY_CODE     --��ȭ�ڵ�
                    , TO_CHAR(TO_NUMBER(REPLACE(TRIM(A.REFER6), ',', '')), 'FM99999.0000') AS EXCHANGE_RATE     --ȯ��
                    , TO_CHAR(TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', '')), 'FM999999999999.00') AS CURRENCY_AMOUNT   --��ȭ�ݾ�
                    , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', '')) AS GL_AMOUNT     --��ȭ; ���ް���            
                FROM FI_SLIP_LINE A
                WHERE   A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����
                    AND MANAGEMENT2 = '3'           --�������� : ����
                    AND A.REFER4 IS NOT NULL
                    AND A.REFER11 = W_TAX_CODE      --�����(����/������� ������� �ƴ� ȸ�� �ڷῡ �Ϲ������� ���Ǵ� �������)
                    
                    --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������
                    AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO --�Ű���������        
                ORDER BY VAT_ISSUE_DATE            
            )

    ) LOOP
    
        INSERT_VAT_E_FILE('�������������  C ���ڵ�(�ڷ�)', REC_EXP_OUTPUT.REC);

    END LOOP REC_EXP_OUTPUT;


END IF; --IF t_E_FILE_EXPORT_YN = 'Y' THEN        --���ڽŰ����ϻ�����󿩺�_�������������



IF t_E_FILE_GET_YN = 'Y' THEN           --���ڽŰ����ϻ�����󿩺�_�ſ�ī�������ǥ����������

    --3-4.�ſ�ī�������ǥ����������(��,��)
    --.���ĸ� : ������ ��������(Header Record)   ���� : 140



    g_REPORT_CONTENT := NULL;
    
    SELECT
           'HL'   --1.���ڵ屸��	CHAR	2
        || RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYY'), 4, ' ') --2.�ͼӳ⵵	CHAR	4
        || RPAD(
                CASE 
                WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '04', '05', '06') THEN '1'
                ELSE '2'
                END
           , 1, ' ') --3.�ݱⱸ��	CHAR	1
        || RPAD(
                CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '07') THEN '1'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('02', '08') THEN '2'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('03', '09') THEN '3'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '10') THEN '4'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('05', '11') THEN '5'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('06', '12') THEN '6'
                END
           , 1, ' ') --4.�ݱ⳻������	CHAR	1                             
        || t_VAT_NUMBER_10                      --5.������(������)����ڵ�Ϲ�ȣ	CHAR	10
        || RPAD(t_CORP_NAME_30, 60, ' ')        --6.��ȣ(���θ�)	CHAR	60
        || t_PRESIDENT_NAME_30                  --7.����(��ǥ��)	CHAR	30
        || t_LEGAL_NUMBER                       --8.�ֹ�(����)��Ϲ�ȣ	CHAR	13
        || TO_CHAR(W_CREATE_DATE, 'YYYYMMDD')   --9.��������	CHAR	8
        || RPAD(' ', 11, ' ')                   --10.����	CHAR	11
        AS REC
    INTO g_REPORT_CONTENT
    FROM DUAL ;
        
    INSERT_VAT_E_FILE('�ſ�ī�������ǥ����������(��,��) ������ ��������(Header Record)', g_REPORT_CONTENT);   




    --.���ĸ� : �ſ�/����ī�� �� ����ļ���ī�� ������ǥ �������(Data Record)   ���� : 140
    
    --���ݿ������� �ڷ������� �Ǵ��Ѵ�.
    SELECT COUNT(*)
    INTO t_CASH_CNT
    FROM FI_SLIP_LINE A
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        
        --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
        AND A.ACCOUNT_CODE IN 
            (
                SELECT ACCOUNT_CODE
                FROM FI_ACCOUNT_CONTROL
                WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                    AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
            )  --�ŷ�����(����/����)     
        
        AND A.MANAGEMENT2 = W_TAX_CODE              --�����
        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������
        AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű���������
        AND REFER1 = '7'    --�������� : ���ݿ���������     
    ; 
    
    
    --��  IF���� �ִ� ������ �����ϴ� ���� UNION�ϴ��� ���ݿ����� �ڷḦ �����ϴ��� �ƴϳ��� ������ ���̴�.
    IF t_CASH_CNT > 0 THEN

        FOR REC_GET_OUTPUT IN (    

            SELECT
                 ROWNUM AS SEQ --�Ϸù�ȣ ; [�ſ�ī��� ���Գ��� �հ�(Tail Record)] ���������� �����.
               , 'DL'  --1.���ڵ屸��	CHAR	2
            || RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYY'), 4, ' ') --2.�ͼӳ⵵	CHAR	4
            || RPAD(
                    CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '04', '05', '06') THEN '1'
                    ELSE '2'
                    END
               , 1, ' ') --3.�ݱⱸ��	CHAR	1
            || RPAD(
                    CASE 
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '07') THEN '1'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('02', '08') THEN '2'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('03', '09') THEN '3'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '10') THEN '4'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('05', '11') THEN '5'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('06', '12') THEN '6'
                    END
               , 1, ' ') --4.�ݱ⳻������	CHAR	1 
               
                || t_VAT_NUMBER_10                              --5.������(������)����ڵ�Ϲ�ȣ	CHAR	10
                || CARD_GB                                      --6.ī�屸��	                    CHAR	1
                || RPAD(NVL(REPLACE(CARD_NUM, '-', ''), ' '), 20, ' ')    --7.ī��ȸ����ȣ	                CHAR	20
                || RPAD(REPLACE(TAX_REG_NO, '-', ''), 10, ' ')  --8.������(������)����ڵ�Ϲ�ȣ	CHAR	10
                || LPAD(CNT, 9, 0)                              --9.�ŷ��Ǽ�	                    NUMBER	9
                || RPAD(CASE WHEN GL_AMOUNT >= 0 THEN ' ' ELSE '-' END, 1, ' ')     --10.(���ް���)����ǥ��	CHAR	1
                || LPAD(GL_AMOUNT, 13, 0)                                           --11.���ް���	        NUMBER	13
                || RPAD(CASE WHEN VAT_AMOUNT >= 0 THEN ' ' ELSE '-' END, 1, ' ')    --12.(����)����ǥ��	    CHAR	1
                || LPAD(VAT_AMOUNT, 13, 0)                                          --13.����	            NUMBER	13
                || RPAD(' ', 54, ' ')   --14.����	CHAR	54
                AS REC
            FROM
            (

                SELECT 
                    '1' AS CARD_GB   --ī�屸�� : �ſ�ī�� �� ����ī�� �ڷ��� ��1��
                    , CARD_NUM      --ī��ȸ����ȣ
                    , TAX_REG_NO    --����ڵ�Ϲ�ȣ
                    , CNT           --�ŷ��Ǽ�
                    , GL_AMOUNT     --���ް���
                    , VAT_AMOUNT    --����
                FROM
                    (
                        SELECT        
                              CARD_NUM
                            , TAX_REG_NO
                            , COUNT(*) AS CNT
                            , NVL(SUM(GL_AMOUNT), 0) AS GL_AMOUNT
                            , NVL(SUM(VAT_AMOUNT), 0) AS VAT_AMOUNT
                        FROM
                        (
                            SELECT  
                                  FI_CREDIT_CARD_G.CARD_NUM_F(A.SOB_ID, A.REFER4, A.ORG_ID) AS CARD_NUM     --�ſ�ī���ȣ
                                , B.TAX_REG_NO AS TAX_REG_NO                    --����ڵ�Ϲ�ȣ   
                                , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --���ް���
                                , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --����          
                            FROM FI_SLIP_LINE A
                                , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --�ŷ�ó
                            WHERE A.SOB_ID = W_SOB_ID
                                AND A.ORG_ID = W_ORG_ID 
                                
                                --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
                                AND A.ACCOUNT_CODE IN 
                                    (
                                        SELECT ACCOUNT_CODE
                                        FROM FI_ACCOUNT_CONTROL
                                        WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                                            AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
                                    )  --�ŷ�����(����/����)     
                                
                                AND A.MANAGEMENT2 = W_TAX_CODE              --�����
                                --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������
                                AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű���������
                                AND REFER1 = '6'    --��������    
                                AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
                        )
                        GROUP BY CARD_NUM, TAX_REG_NO
                        ORDER BY CARD_NUM, TAX_REG_NO    
                    )

                UNION ALL
        
                SELECT
                      '2' AS CARD_GB   --ī�屸�� : ���ݿ����� �ŷ��ڷ��� ��2��
                    , ' ' AS CARD_NUM      --ī��ȸ����ȣ : ī�屸���� ��2��, ��3��,��4���̸� ����(Space)���� ä���.
                    , ' ' AS TAX_REG_NO    --������(������)����ڵ�Ϲ�ȣ : ī�屸���� ��2��, ��3��,��4���̸� ����(Space)���� ä���.
                    , COUNT(*) AS CNT  --�ż�
                    , NVL(SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))), 0) AS GL_AMOUNT     --���ް���
                    , NVL(SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))), 0) AS VAT_AMOUNT    --����      
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    
                    --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
                    AND A.ACCOUNT_CODE IN 
                        (
                            SELECT ACCOUNT_CODE
                            FROM FI_ACCOUNT_CONTROL
                            WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                                AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
                        )  --�ŷ�����(����/����)     
                    
                    AND A.MANAGEMENT2 = W_TAX_CODE              --�����
                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������
                    AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű���������
                    AND REFER1 = '7'    --�������� : ���ݿ���������   
            )

        ) LOOP
        
            t_SEQ := REC_GET_OUTPUT.SEQ; --LOOP�� ���� ������ ROW COUNT�� ��´�. ��, DATA RECORD�� ������ �ȴ�.
        
            INSERT_VAT_E_FILE('�ſ�ī�������ǥ����������  ������ǥ �������(Data Record)', REC_GET_OUTPUT.REC);

        END LOOP REC_GET_OUTPUT;   
        
    ELSE

        FOR REC_GET_OUTPUT IN (    

            SELECT
                 ROWNUM AS SEQ --�Ϸù�ȣ ; [�ſ�ī��� ���Գ��� �հ�(Tail Record)] ���������� �����.
               , 'DL'  --1.���ڵ屸��	CHAR	2
            || RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYY'), 4, ' ') --2.�ͼӳ⵵	CHAR	4
            || RPAD(
                    CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '04', '05', '06') THEN '1'
                    ELSE '2'
                    END
               , 1, ' ') --3.�ݱⱸ��	CHAR	1
            || RPAD(
                    CASE 
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '07') THEN '1'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('02', '08') THEN '2'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('03', '09') THEN '3'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '10') THEN '4'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('05', '11') THEN '5'
                        WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('06', '12') THEN '6'
                    END
               , 1, ' ') --4.�ݱ⳻������	CHAR	1 
               
                || t_VAT_NUMBER_10                              --5.������(������)����ڵ�Ϲ�ȣ	CHAR	10
                || CARD_GB                                      --6.ī�屸��	                    CHAR	1
                || RPAD(NVL(REPLACE(CARD_NUM, '-', ''), ' '), 20, ' ')    --7.ī��ȸ����ȣ	                CHAR	20
                || RPAD(REPLACE(TAX_REG_NO, '-', ''), 10, ' ')  --8.������(������)����ڵ�Ϲ�ȣ	CHAR	10
                || LPAD(CNT, 9, 0)                              --9.�ŷ��Ǽ�	                    NUMBER	9
                || RPAD(CASE WHEN GL_AMOUNT >= 0 THEN ' ' ELSE '-' END, 1, ' ')     --10.(���ް���)����ǥ��	CHAR	1
                || LPAD(GL_AMOUNT, 13, 0)                                           --11.���ް���	        NUMBER	13
                || RPAD(CASE WHEN VAT_AMOUNT >= 0 THEN ' ' ELSE '-' END, 1, ' ')    --12.(����)����ǥ��	    CHAR	1
                || LPAD(VAT_AMOUNT, 13, 0)                                          --13.����	            NUMBER	13
                || RPAD(' ', 54, ' ')   --14.����	CHAR	54
                AS REC
            FROM
            (

                SELECT 
                    '1' AS CARD_GB   --ī�屸�� : �ſ�ī�� �� ����ī�� �ڷ��� ��1��
                    , CARD_NUM      --ī��ȸ����ȣ
                    , TAX_REG_NO    --����ڵ�Ϲ�ȣ
                    , CNT           --�ŷ��Ǽ�
                    , GL_AMOUNT     --���ް���
                    , VAT_AMOUNT    --����
                FROM
                    (
                        SELECT        
                              CARD_NUM
                            , TAX_REG_NO
                            , COUNT(*) AS CNT
                            , NVL(SUM(GL_AMOUNT), 0) AS GL_AMOUNT
                            , NVL(SUM(VAT_AMOUNT), 0) AS VAT_AMOUNT
                        FROM
                        (
                            SELECT  
                                  FI_CREDIT_CARD_G.CARD_NUM_F(A.SOB_ID, A.REFER4, A.ORG_ID) AS CARD_NUM     --�ſ�ī���ȣ
                                , B.TAX_REG_NO AS TAX_REG_NO                    --����ڵ�Ϲ�ȣ   
                                , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --���ް���
                                , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --����          
                            FROM FI_SLIP_LINE A
                                , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --�ŷ�ó
                            WHERE A.SOB_ID = W_SOB_ID
                                AND A.ORG_ID = W_ORG_ID 
                                
                                --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
                                AND A.ACCOUNT_CODE IN 
                                    (
                                        SELECT ACCOUNT_CODE
                                        FROM FI_ACCOUNT_CONTROL
                                        WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                                            AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
                                    )  --�ŷ�����(����/����)     
                                
                                AND A.MANAGEMENT2 = W_TAX_CODE              --�����
                                --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������
                                AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű���������
                                AND REFER1 = '6'    --��������    
                                AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
                        )
                        GROUP BY CARD_NUM, TAX_REG_NO
                        ORDER BY CARD_NUM, TAX_REG_NO    
                    )

            )

        ) LOOP
        
            t_SEQ := REC_GET_OUTPUT.SEQ; --LOOP�� ���� ������ ROW COUNT�� ��´�. ��, DATA RECORD�� ������ �ȴ�.
        
            INSERT_VAT_E_FILE('�ſ�ī�������ǥ����������  ������ǥ �������(Data Record)', REC_GET_OUTPUT.REC);

        END LOOP REC_GET_OUTPUT;    
    
    END IF;
    
    






    --.���ĸ� : �ſ�ī��� ���Գ��� �հ�(Tail Record)   ���� : 140



    g_REPORT_CONTENT := NULL;
    
    SELECT    
           'TL'   --1.���ڵ屸��	CHAR	2
        || RPAD(TO_CHAR(W_ISSUE_DATE_TO, 'YYYY'), 4, ' ') --2.�ͼӳ⵵	CHAR	4
        || RPAD(
                CASE 
                WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '02', '03', '04', '05', '06') THEN '1'
                ELSE '2'
                END
           , 1, ' ') --3.�ݱⱸ��	CHAR	1
        || RPAD(
                CASE 
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('01', '07') THEN '1'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('02', '08') THEN '2'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('03', '09') THEN '3'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('04', '10') THEN '4'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('05', '11') THEN '5'
                    WHEN TO_CHAR(W_ISSUE_DATE_TO, 'MM') IN('06', '12') THEN '6'
                END
           , 1, ' ') --4.�ݱ⳻������	CHAR	1                             
        || t_VAT_NUMBER_10                      --5.������(������)����ڵ�Ϲ�ȣ	CHAR	10

        || LPAD(t_SEQ, 7, 0)    --6.DATA�Ǽ�	NUMBER	7
        || LPAD(COUNT(*), 9, 0) --7.�ŷ��Ǽ�    NUMBER	9
        || RPAD(CASE WHEN NVL(SUM(GL_AMOUNT), 0) >= 0 THEN ' ' ELSE '-' END, 1, ' ')     --8.(���ް���)����ǥ��	CHAR	1
        || LPAD(NVL(SUM(GL_AMOUNT), 0), 15, 0)                                           --9.���ް���	        NUMBER	15
        || RPAD(CASE WHEN NVL(SUM(VAT_AMOUNT), 0) >= 0 THEN ' ' ELSE '-' END, 1, ' ')    --10.(����)����ǥ��	CHAR	1
        || LPAD(NVL(SUM(VAT_AMOUNT), 0), 15, 0)                                          --11.����	            NUMBER	15
        
        || RPAD(' ', 74, ' ')   --12.����	CHAR	74
        AS REC
    INTO g_REPORT_CONTENT
    FROM
    (
        SELECT
              REFER1    --��������  
            , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --���ް���
            , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --����          
        FROM FI_SLIP_LINE A
            , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --�ŷ�ó
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            
            --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
            AND A.ACCOUNT_CODE IN 
                (
                    SELECT ACCOUNT_CODE
                    FROM FI_ACCOUNT_CONTROL
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
                )  --�ŷ�����(����/����)     
            
            AND A.MANAGEMENT2 = W_TAX_CODE              --�����
            --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű���������
            AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű���������
            AND REFER1 IN ('6', '7')    --�������� : ī�����, ���ݿ���������    
            AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
    )   ;
        
    INSERT_VAT_E_FILE('�ſ�ī�������ǥ����������(��,��) �ſ�ī��� ���Գ��� �հ�(Tail Record)', g_REPORT_CONTENT);   

END IF; --IF t_E_FILE_GET_YN = 'Y' THEN           --���ڽŰ����ϻ�����󿩺�_�ſ�ī�������ǥ����������



IF t_E_FILE_COPPER_ETC_YN = 'Y' THEN           --���ڽŰ����ϻ�����󿩺�_���� ��ũ���� ���Լ��� �����Ű��� 

    --3-4.�ſ�ī�������ǥ����������(��,��)
    --.���ĸ� : ������ ��������(Header Record)   ���� : 140



    g_REPORT_CONTENT := NULL;
    BEGIN
      SELECT '17'   -- �ڷᱸ�� 
          || 'V179'   -- �����ڵ� 
          || LPAD(NVL(T1.TOT_SUPPLIER_COUNT, 0), 7, 0)  -- ����ó�� �հ� 
          || LPAD(NVL(T1.TOT_VAT_COUNT, 0), 11, 0)           -- �Ǽ� �հ� 
          || LPAD(NVL(T1.TOT_ITEM_QTY, 0), 11, 0)             -- ���� �հ� 
          || LPAD(NVL(T1.TOT_ITEM_AMOUNT, 0), 15, 0)       -- ���ݾ� �հ� 
          || LPAD(NVL(T1.TOT_DEEMED_VAT_AMOUNT, 0), 15, 0)     -- �������Լ��� �հ�     
                     
          || LPAD(NVL(T1.RECEIPT_SUPPLIER_COUNT, 0), 6, 0)  -- ������ ����ó��  
          || LPAD(NVL(T1.RECEIPT_VAT_COUNT, 0), 11, 0)           -- ������ �Ǽ�  
          || LPAD(NVL(T1.RECEIPT_ITEM_QTY, 0), 11, 0)             -- ������ ����  
          || LPAD(NVL(T1.RECEIPT_ITEM_AMOUNT, 0), 15, 0)       -- ������ ���ݾ�  
          || LPAD(NVL(T1.RECEIPT_DEEMED_VAT_AMOUNT, 0), 15, 0)     -- ������ �������Լ���   
                        
          || LPAD(NVL(T1.BILL_SUPPLIER_COUNT, 0), 6, 0)  -- ��꼭 ����ó��  
          || LPAD(NVL(T1.BILL_VAT_COUNT, 0), 11, 0)           -- ��꼭 �Ǽ�  
          || LPAD(NVL(T1.BILL_ITEM_QTY, 0), 11, 0)             -- ��꼭 ����  
          || LPAD(NVL(T1.BILL_ITEM_AMOUNT, 0), 15, 0)       -- ��꼭 ���ݾ�  
          || LPAD(NVL(T1.BILL_DEEMED_VAT_AMOUNT, 0), 15, 0)     -- ��꼭 �������Լ���            
          || RPAD(' ', 19, ' ') AS HEADER
        INTO g_REPORT_CONTENT
        FROM ( SELECT  COUNT(CE.SUPPLIER_ID) AS TOT_SUPPLIER_COUNT  -- ����ó�� �հ� 
                     , SUM(CE.VAT_COUNT) AS TOT_VAT_COUNT           -- �Ǽ� �հ� 
                     , SUM(CE.ITEM_QTY) AS TOT_ITEM_QTY             -- ���� �հ� 
                     , SUM(CE.ITEM_AMOUNT) AS TOT_ITEM_AMOUNT       -- ���ݾ� �հ� 
                     , SUM(CE.DEEMED_VAT_AMOUNT) AS TOT_DEEMED_VAT_AMOUNT     -- �������Լ��� �հ�     
                     
                     , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', 1, 0)) AS RECEIPT_SUPPLIER_COUNT  -- ������ ����ó��  
                     , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', CE.VAT_COUNT, 0)) AS RECEIPT_VAT_COUNT           -- ������ �Ǽ�  
                     , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', CE.ITEM_QTY, 0)) AS RECEIPT_ITEM_QTY             -- ������ ����  
                     , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', CE.ITEM_AMOUNT, 0)) AS RECEIPT_ITEM_AMOUNT       -- ������ ���ݾ�  
                     , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', CE.DEEMED_VAT_AMOUNT, 0)) AS RECEIPT_DEEMED_VAT_AMOUNT     -- ������ �������Լ���   
                        
                     , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', 0, 1)) AS BILL_SUPPLIER_COUNT  -- ��꼭 ����ó��  
                     , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', 0, CE.VAT_COUNT)) AS BILL_VAT_COUNT           -- ��꼭 �Ǽ�  
                     , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', 0, CE.ITEM_QTY)) AS BILL_ITEM_QTY             -- ��꼭 ����  
                     , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', 0, CE.ITEM_AMOUNT)) AS BILL_ITEM_AMOUNT       -- ��꼭 ���ݾ�  
                     , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', 0, CE.DEEMED_VAT_AMOUNT)) AS BILL_DEEMED_VAT_AMOUNT     -- ��꼭 �������Լ���             
                  FROM FI_VAT_COPPER_ETC CE
                     , AP_SUPPLIER       FAS
                 WHERE CE.SUPPLIER_ID       = FAS.SUPPLIER_ID  
                   AND CE.TAX_CODE          = W_TAX_CODE
                   AND CE.SOB_ID            = W_SOB_ID
                   AND CE.ORG_ID            = W_ORG_ID
                   AND CE.VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL  
             ) T1  
       ;  
    EXCEPTION
      WHEN OTHERS THEN
        g_REPORT_CONTENT := NULL;
    END;
    INSERT_VAT_E_FILE('������ũ������Լ��װ����Ű��� �հ�', g_REPORT_CONTENT);   


    FOR REC_GET_OUTPUT IN (    

                SELECT '18'     -- �ڷᱸ�� 
                    || 'V179'   -- �����ڵ� 
                    || RPAD(ROWNUM, 6, '0')   --�Ϸù�ȣ 
                    || RPAD(NVL(T1.SUPPLIER_NAME, ' '), 60, ' ')  -- ��ȣ
                    || RPAD(REPLACE(T1.TAX_REG_NO, '-', ''), 13, ' ')  -- ����ڵ�Ϲ�ȣ 
                    || LPAD(NVL(T1.VAT_COUNT, 0), 11, 0)               -- �Ǽ�
                    || RPAD(NVL(T1.ITEM_DESC, ' '), 30, 0)             -- ǰ��  
                    || LPAD(NVL(T1.ITEM_QTY, 0), 11, 0)                -- ����  
                    || LPAD(NVL(T1.ITEM_AMOUNT, 0), 13, 0)             -- ���ݾ� 
                    || LPAD(NVL(T1.DEEMED_VAT_AMOUNT, 0), 13, 0)       -- �������Լ��� 
                    || RPAD(' ', 37, ' ')   --14.����	CHAR	54
                    AS REC
                    , ROWNUM AS SEQ 
                FROM  (
                          SELECT FAS.SUPPLIER_CODE
                               , FAS.SUPPLIER_SHORT_NAME AS SUPPLIER_NAME 
                               , FAS.TAX_REG_NO 
                               , CE.VAT_COUNT
                               , CE.ITEM_DESC
                               , CE.ITEM_QTY 
                               , CE.ITEM_AMOUNT
                               , CE.DEEMED_VAT_AMOUNT  
                            FROM FI_VAT_COPPER_ETC CE
                               , AP_SUPPLIER       FAS
                           WHERE CE.SUPPLIER_ID       = FAS.SUPPLIER_ID
                             AND CE.TAX_CODE          = W_TAX_CODE
                             AND CE.SOB_ID            = W_SOB_ID
                             AND CE.ORG_ID            = W_ORG_ID
                             AND CE.VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL 
                             AND CE.VAT_RECEIPT_TYPE  = '10'    -- ������ ����и� -- 
                          ORDER BY FAS.SUPPLIER_CODE  
                      ) T1

    ) LOOP
        
        t_SEQ := REC_GET_OUTPUT.SEQ; --LOOP�� ���� ������ ROW COUNT�� ��´�. ��, DATA RECORD�� ������ �ȴ�.
        
        INSERT_VAT_E_FILE('������ũ���� ���Լ��װ����Ű��� ����(Data Record)', REC_GET_OUTPUT.REC);

    END LOOP REC_GET_OUTPUT;    

END IF; --IF t_E_FILE_GET_YN = 'Y' THEN           --���ڽŰ����ϻ�����󿩺�_�ſ�ī�������ǥ����������




END CREATE_VAT_E_FILE;







--FI_VAT_E_FILE �ڷ� INSERT
PROCEDURE INSERT_VAT_E_FILE(
      P_REPORT_DOC      IN  FI_VAT_E_FILE.REPORT_DOC%TYPE       --�Ű�������
    , P_REPORT_CONTENT  IN  FI_VAT_E_FILE.REPORT_CONTENT%TYPE   --�Ű�����   
)

AS

BEGIN

    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO g_SPEC_SERIAL FROM FI_VAT_E_FILE;

    INSERT INTO FI_VAT_E_FILE(
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�        
        , TAX_CODE	      --�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű��Ⱓ���й�ȣ
        , VAT_MAKE_GB	    --�Ű�����
        , SPEC_SERIAL	    --�Ϸù�ȣ

        , REPORT_DOC        --�Ű�������
        , REPORT_CONTENT    --�Ű�����
        
        , CREATION_DATE     --������
        , CREATED_BY	    --������
        , LAST_UPDATE_DATE  --������
        , LAST_UPDATED_BY	--������          
    )
    SELECT
          g_SOB_ID              --ȸ����̵�
        , g_ORG_ID              --����ξ��̵�
        , g_TAX_CODE            --�������̵�
        , g_VAT_MNG_SERIAL      --�ΰ����Ű��Ⱓ���й�ȣ
        , '01'	                --�Ű�����
        , g_SPEC_SERIAL         --�Ϸù�ȣ 

        , P_REPORT_DOC          --�Ű�������
        , P_REPORT_CONTENT      --�Ű�����
        
        , g_SYSDATE     --������
        , g_CREATED_BY  --������
        , g_SYSDATE     --������
        , g_CREATED_BY  --������         
    FROM DUAL   ;

END INSERT_VAT_E_FILE;







--1-3. [�ΰ���ġ�����Աݾ׵�(����ǥ�ظ���, �鼼���Աݾ�)] �ڷ� INSERT
--���ĸ� : �ΰ���ġ�� ���Աݾ� ��(�Ϲ�,���� ����), File : �ΰ���ġ�����Աݾ�, ���� : 150
PROCEDURE INSERT_1_4(
      W_AMT         IN  NUMBER      --�ݾ�
    , W_AMT_KIND    IN  VARCHAR2    --���Աݾ���������  
)

AS

BEGIN
    
    g_REPORT_CONTENT := NULL;

    SELECT
           '15'                 --1.�ڷᱸ��	        CHAR	2	Not Null	[����Ű� : 15, 25]
        || 'V101'               --2.�����ڵ�	        CHAR	4	Not Null	[�Ϲ� V101, ���� V102 ]
        || W_AMT_KIND           --3.���Աݾ���������	CHAR	1   Not Null	[1,2,4,7,8,E]
        || g_BUSINESS_ITEM_30   --4.���¸�              CHAR	30 
        || g_BUSINESS_TYPE_50   --5.�����              CHAR	50
        || g_ATTRIBUTE1         --6.�����ڵ�            CHAR	7
        || LPAD(REPLACE(LPAD(NVL(W_AMT, 0), 15, 0), '-', ''), 15, '-')    --7.���Աݾ�	NUMBER	15
        || RPAD(' ', 41, ' ')   --8.����	CHAR	41
    INTO g_REPORT_CONTENT
    FROM DUAL;

    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO g_SPEC_SERIAL FROM FI_VAT_E_FILE;

    INSERT INTO FI_VAT_E_FILE(
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�        
        , TAX_CODE	      --�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű��Ⱓ���й�ȣ
        , VAT_MAKE_GB	    --�Ű�����
        , SPEC_SERIAL	    --�Ϸù�ȣ

        , REPORT_DOC        --�Ű�������
        , REPORT_CONTENT    --�Ű�����
        
        , CREATION_DATE     --������
        , CREATED_BY	    --������
        , LAST_UPDATE_DATE  --������
        , LAST_UPDATED_BY	--������          
    )
    SELECT
          g_SOB_ID  --ȸ����̵�
        , g_ORG_ID  --����ξ��̵�
        , g_TAX_CODE                --�������̵�
        , g_VAT_MNG_SERIAL          --�ΰ����Ű��Ⱓ���й�ȣ
        , '01'	                    --�Ű�����
        , g_SPEC_SERIAL             --�Ϸù�ȣ 

        , '�ΰ���ġ�����Աݾ׵�(����ǥ�ظ���, �鼼���Աݾ�)'       --�Ű�������
        , g_REPORT_CONTENT          --�Ű�����
        
        , g_SYSDATE     --������
        , g_CREATED_BY  --������
        , g_SYSDATE     --������
        , g_CREATED_BY  --������         
    FROM DUAL   ;

END INSERT_1_4;




--���ڽŰ� ���� ������ ���õǴ� �ΰ����Ű��� ���� ��ȸ
PROCEDURE LIST_VAT_E_FILE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_SURTAX_CARD.TAX_CODE%TYPE            --�������̵�(��>110)     
    , W_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű��Ⱓ���й�ȣ
    , W_VAT_MAKE_GB         IN  FI_SURTAX_CARD.VAT_MAKE_GB%TYPE DEFAULT '01'    --�Ű�����(01 : ����Ű�)
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�
        , TAX_CODE	      --�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű��Ⱓ���й�ȣ
        , SPEC_SERIAL	    --�Ϸù�ȣ
        
        --����>�����Ű��� ó���� �� �ֵ��� Ʋ�� ����� ���� �۾��� �������� �ʾҴ�.
        , VAT_MAKE_GB	    --�Ű�����(01 : ����Ű�, 02 : �����Ű�)
        
        , GUBUN_1	--�Ű�������_����
        , GUBUN_2	--�Ű�������_Ȯ��
        , GUBUN_3	--�Ű�������_�����İ���ǥ��
        , GUBUN_4	--�Ű�������_������������ȯ��                      
        , TITLE_2	--��ȣ
        , TITLE_3	--����        
        , TITLE_4	--����ڵ�Ϲ�ȣ        
        , TITLE_5	--���ε�Ϲ�ȣ
        , TITLE_6	--�������ȭ
        , TITLE_7	--�ּ�����ȭ
        , TITLE_8	--�޴���ȭ
        , TITLE_9	--������ּ�
        , TITLE_11	--����
        , TITLE_12	--����        
        , TITLE_13	--�����ڵ�        

        , TITLE_1_1	        --�Ű��Ⱓ_����
        , TITLE_1_2	        --�Ű��Ⱓ_����
        , TITLE_14	        --�ۼ�����
        , DEAL_BANK	        --�ŷ�����
        , DEAL_BANK_CD	    --�ŷ������ڵ�
        , DEAL_BRANCH	    --�ŷ�����
        , DEAL_BRANCH_ID	--�ŷ������ڵ�
        , ACC_NO	        --���¹�ȣ
        , HOMETAX_USERID	--Ȩ�ý�_����ھ��̵�
        , TITLE_10	        --���ڿ����ּ�
        
        , VAT_PRESENTER_GB  --�����ڱ���
        , FI_COMMON_G.CODE_NAME_F('VAT_PRESENTER_GB', VAT_PRESENTER_GB, SOB_ID, ORG_ID) AS VAT_PRESENTER_NM --�����ڱ���_��
        , VAT_LEVIER_GB	    --�Ϲݰ����ڱ���
        , FI_COMMON_G.CODE_NAME_F('VAT_LEVIER_GB', VAT_LEVIER_GB, SOB_ID, ORG_ID) AS VAT_LEVIER_NM          --�Ϲݰ����ڱ���_��
        , VAT_REFUND_GB	    --ȯ�ޱ���
        , FI_COMMON_G.CODE_NAME_F('VAT_REFUND_GB', VAT_REFUND_GB, SOB_ID, ORG_ID) AS VAT_REFUND_NM          --ȯ�ޱ���_��        
        
        --���ڽŰ����ϻ�������
        ,(        
            SELECT 
                CASE
                    WHEN COUNT(*) > 0 THEN 'Y'
                    ELSE 'N'
                END AS CREATE_YN
            FROM FI_VAT_E_FILE
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND TAX_CODE = W_TAX_CODE
                AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
                AND VAT_MAKE_GB = '01' 
        ) AS CREATE_YN  

        , E_FILE_SURTAX_YN          --���ڽŰ����ϻ�����󿩺�_�ΰ����Ű���
        , E_FILE_ZERO_YN            --���ڽŰ����ϻ�����󿩺�_������÷�μ������������
        , E_FILE_REAL_ESTATE_YN     --���ڽŰ����ϻ�����󿩺�_�ε����Ӵ���ް��׸�����
        , E_FILE_BLD_YN             --���ڽŰ����ϻ�����󿩺�_�ǹ�������ڻ���������
        , E_FILE_NO_DEDUCTION_YN    --���ڽŰ����ϻ�����󿩺�_�����������Ҹ��Լ��׸�����        
        , E_FILE_TAX_PUB_YN         --���ڽŰ����ϻ�����󿩺�_���ڼ��ݰ�꼭�߱޼��װ����Ű���
        , E_FILE_DOMESTIC_LC_YN     --���ڽŰ����ϻ�����󿩺�_�����ſ��屸��Ȯ�μ����ڹ߱޸�����                 
        , E_FILE_SUM_VAT_YN         --���ڽð����ϻ�����󿩺�_���ݰ�꼭�հ�ǥ
        , E_FILE_SUM_CALC_YN        --���ڽŰ����ϻ�����󿩺�_��꼭�հ�ǥ
        , E_FILE_EXPORT_YN          --���ڽŰ����ϻ�����󿩺�_�������������
        , E_FILE_GET_YN             --���ڽŰ����ϻ�����󿩺�_�ſ�ī�������ǥ���������� 
        , E_FILE_COPPER_ETC_YN      -- ���ڽŰ����ϻ�����󿩺�_������ũ������Լ��װ����Ű��� 
        , E_FILE_RECYCLING_ETC_YN   -- ���ڽŰ����ϻ�����󿩺�_��Ȱ�����ڿ����߰��ڵ������Լ��װ����Ű���
    FROM FI_SURTAX_CARD
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
        AND VAT_MAKE_GB = NVL(W_VAT_MAKE_GB, '01') --�Ű�����(01 : ����Ű�)
    ;


END LIST_VAT_E_FILE;







--���ڽŰ����� ������ �ʿ��� �ΰ����Ű��� �ڷḦ �����Ѵ�. ; 1�� ° �� ����
PROCEDURE UPDATE_SURTAX_CARD(
      W_SOB_ID              IN  FI_SURTAX_CARD.SOB_ID%TYPE              --ȸ����̵�
    , W_ORG_ID              IN  FI_SURTAX_CARD.ORG_ID%TYPE              --����ξ��̵�
    , W_TAX_CODE            IN  FI_SURTAX_CARD.TAX_CODE%TYPE            --�������̵�(��>110)       
    , W_VAT_MNG_SERIAL      IN  FI_SURTAX_CARD.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű��Ⱓ���й�ȣ
    , W_SPEC_SERIAL         IN  FI_SURTAX_CARD.SPEC_SERIAL%TYPE         --�Ϸù�ȣ    
    
    , P_TITLE_14	        IN	FI_SURTAX_CARD.TITLE_14%TYPE	        --�ۼ�����
    , P_DEAL_BANK	        IN	FI_SURTAX_CARD.DEAL_BANK%TYPE	        --�ŷ�����
    , P_DEAL_BANK_CD	    IN	FI_SURTAX_CARD.DEAL_BANK_CD%TYPE	    --�ŷ������ڵ�
    , P_DEAL_BRANCH	        IN	FI_SURTAX_CARD.DEAL_BRANCH%TYPE	        --�ŷ�����
    , P_DEAL_BRANCH_ID	    IN	FI_SURTAX_CARD.DEAL_BRANCH_ID%TYPE	    --�ŷ������ڵ�
    , P_ACC_NO	            IN	FI_SURTAX_CARD.ACC_NO%TYPE	            --���¹�ȣ
    , P_HOMETAX_USERID	    IN	FI_SURTAX_CARD.HOMETAX_USERID%TYPE	    --Ȩ�ý�_����ھ��̵�
    , P_VAT_PRESENTER_GB	IN	FI_SURTAX_CARD.VAT_PRESENTER_GB%TYPE    --�����ڱ���
    , P_VAT_LEVIER_GB	    IN	FI_SURTAX_CARD.VAT_LEVIER_GB%TYPE	    --�Ϲݰ����ڱ���
    , P_VAT_REFUND_GB	    IN	FI_SURTAX_CARD.VAT_REFUND_GB%TYPE	    --ȯ�ޱ���
    , P_TITLE_10	        IN	FI_SURTAX_CARD.TITLE_10%TYPE	        --���ڿ����ּ�

    , P_E_FILE_SURTAX_YN	    IN  FI_SURTAX_CARD.E_FILE_SURTAX_YN%TYPE        --���ڽŰ����ϻ�����󿩺�_�ΰ����Ű���
    , P_E_FILE_ZERO_YN	        IN  FI_SURTAX_CARD.E_FILE_ZERO_YN%TYPE          --���ڽŰ����ϻ�����󿩺�_������÷�μ������������
    , P_E_FILE_REAL_ESTATE_YN   IN  FI_SURTAX_CARD.E_FILE_REAL_ESTATE_YN%TYPE   --���ڽŰ����ϻ�����󿩺�_�ε����Ӵ���ް��׸�����
    , P_E_FILE_BLD_YN	        IN  FI_SURTAX_CARD.E_FILE_BLD_YN%TYPE           --���ڽŰ����ϻ�����󿩺�_�ǹ�������ڻ���������
    , P_E_FILE_NO_DEDUCTION_YN	IN  FI_SURTAX_CARD.E_FILE_NO_DEDUCTION_YN%TYPE  --���ڽŰ����ϻ�����󿩺�_�����������Ҹ��Լ��׸�����
    , P_E_FILE_SUM_VAT_YN	    IN  FI_SURTAX_CARD.E_FILE_SUM_VAT_YN%TYPE       --���ڽð����ϻ�����󿩺�_���ݰ�꼭�հ�ǥ
    , P_E_FILE_SUM_CALC_YN	    IN  FI_SURTAX_CARD.E_FILE_SUM_CALC_YN%TYPE      --���ڽŰ����ϻ�����󿩺�_��꼭�հ�ǥ
    , P_E_FILE_EXPORT_YN	    IN  FI_SURTAX_CARD.E_FILE_EXPORT_YN%TYPE        --���ڽŰ����ϻ�����󿩺�_�������������
    , P_E_FILE_GET_YN	        IN  FI_SURTAX_CARD.E_FILE_GET_YN%TYPE           --���ڽŰ����ϻ�����󿩺�_�ſ�ī�������ǥ����������    
    , P_E_FILE_TAX_PUB_YN	    IN  FI_SURTAX_CARD.E_FILE_TAX_PUB_YN%TYPE       --���ڽŰ����ϻ�����󿩺�_���ڼ��ݰ�꼭�߱޼��װ����Ű���
    , P_E_FILE_DOMESTIC_LC_YN   IN  FI_SURTAX_CARD.E_FILE_DOMESTIC_LC_YN%TYPE   --���ڽŰ����ϻ�����󿩺�_�����ſ��屸��Ȯ�μ����ڹ߱޸�����
    , P_E_FILE_COPPER_ETC_YN    IN  FI_SURTAX_CARD.E_FILE_COPPER_ETC_YN%TYPE    -- ���ڽŰ����ϻ�����󿩺�_������ũ������Լ��װ����Ű��� 
    , P_E_FILE_RECYCLING_ETC_YN IN  FI_SURTAX_CARD.E_FILE_RECYCLING_ETC_YN%TYPE -- ���ڽŰ����ϻ�����󿩺�_��Ȱ�����ڿ����߰��ڵ������Լ��װ����Ű��� 
    , P_LAST_UPDATED_BY     IN  FI_SURTAX_CARD.LAST_UPDATED_BY%TYPE     --������
)

AS

  V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
  t_COL25   NUMBER := 0;  -- �����Ͽ� ������ ���� 
BEGIN
    BEGIN
      SELECT NVL(SC.COL25, 0) AS COL25
        INTO t_COL25
        FROM FI_SURTAX_CARD SC
       WHERE SC.SOB_ID              = W_SOB_ID                  --ȸ����̵�
         AND SC.ORG_ID              = W_ORG_ID                  --����ξ��̵�
         AND SC.TAX_CODE            = W_TAX_CODE                --�������̵�        
         AND SC.VAT_MNG_SERIAL      = W_VAT_MNG_SERIAL          --�ΰ����Ű��Ⱓ���й�ȣ               
         AND SC.SPEC_SERIAL         = W_SPEC_SERIAL             --�Ϸù�ȣ
       ;
    EXCEPTION
      WHEN OTHERS THEN
        t_COL25 := 0;
    END;
    IF t_COL25 > 0 AND P_VAT_REFUND_GB IS NOT NULL  THEN
      RAISE_APPLICATION_ERROR(-20001, '�����Ͽ� ������ ������ �ִ� ��쿡�� ȯ�ޱ����� ������ �� �����ϴ�. Ȯ���ϼ���');
      RETURN;
    END IF;
    
    UPDATE FI_SURTAX_CARD
    SET
          TITLE_14	        = P_TITLE_14	        --�ۼ�����
        , DEAL_BANK	        = P_DEAL_BANK	        --�ŷ�����
        , DEAL_BANK_CD	    = P_DEAL_BANK_CD	    --�ŷ������ڵ�
        , DEAL_BRANCH	    = P_DEAL_BRANCH	        --�ŷ�����
        , DEAL_BRANCH_ID	= P_DEAL_BRANCH_ID	    --�ŷ������ڵ�
        , ACC_NO	        = P_ACC_NO	            --���¹�ȣ
        , HOMETAX_USERID	= P_HOMETAX_USERID	    --Ȩ�ý�_����ھ��̵�
        , VAT_PRESENTER_GB	= P_VAT_PRESENTER_GB    --�����ڱ���
        , VAT_LEVIER_GB	    = P_VAT_LEVIER_GB	    --�Ϲݰ����ڱ���
        , VAT_REFUND_GB	    = P_VAT_REFUND_GB	    --ȯ�ޱ���
        , TITLE_10	        = P_TITLE_10	        --���ڿ����ּ�

        , E_FILE_SURTAX_YN	        = P_E_FILE_SURTAX_YN        --���ڽŰ����ϻ�����󿩺�_�ΰ����Ű���
        , E_FILE_ZERO_YN	        = P_E_FILE_ZERO_YN          --���ڽŰ����ϻ�����󿩺�_������÷�μ������������
        , E_FILE_REAL_ESTATE_YN     = P_E_FILE_REAL_ESTATE_YN   --���ڽŰ����ϻ�����󿩺�_�ε����Ӵ���ް��׸�����
        , E_FILE_BLD_YN	            = P_E_FILE_BLD_YN           --���ڽŰ����ϻ�����󿩺�_�ǹ�������ڻ���������
        , E_FILE_NO_DEDUCTION_YN    = P_E_FILE_NO_DEDUCTION_YN  --���ڽŰ����ϻ�����󿩺�_�����������Ҹ��Լ��׸�����
        , E_FILE_SUM_VAT_YN	        = P_E_FILE_SUM_VAT_YN       --���ڽð����ϻ�����󿩺�_���ݰ�꼭�հ�ǥ
        , E_FILE_SUM_CALC_YN	    = P_E_FILE_SUM_CALC_YN      --���ڽŰ����ϻ�����󿩺�_��꼭�հ�ǥ
        , E_FILE_EXPORT_YN	        = P_E_FILE_EXPORT_YN        --���ڽŰ����ϻ�����󿩺�_�������������
        , E_FILE_GET_YN	            = P_E_FILE_GET_YN           --���ڽŰ����ϻ�����󿩺�_�ſ�ī�������ǥ����������        
        , E_FILE_TAX_PUB_YN	        = P_E_FILE_TAX_PUB_YN       --���ڽŰ����ϻ�����󿩺�_���ڼ��ݰ�꼭�߱޼��װ����Ű���
        , E_FILE_DOMESTIC_LC_YN     = P_E_FILE_DOMESTIC_LC_YN   --���ڽŰ����ϻ�����󿩺�_�����ſ��屸��Ȯ�μ����ڹ߱޸�����        
        , E_FILE_COPPER_ETC_YN      = P_E_FILE_COPPER_ETC_YN    -- ���ڽŰ����ϻ�����󿩺�_������ũ���� ���Լ��װ����Ű��� 
        , E_FILE_RECYCLING_ETC_YN   = P_E_FILE_RECYCLING_ETC_YN -- ���ڽŰ����ϻ�����󿩺�_��Ȱ�����ڿ����߰��ڵ������Լ��װ����Ű��� 
        
        , LAST_UPDATE_DATE          = V_SYSDATE         --������
        , LAST_UPDATED_BY           = P_LAST_UPDATED_BY --������
    WHERE   SOB_ID                  = W_SOB_ID                  --ȸ����̵�
        AND ORG_ID                  = W_ORG_ID                  --����ξ��̵�
        AND TAX_CODE                = W_TAX_CODE                --�������̵�        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --�ΰ����Ű��Ⱓ���й�ȣ               
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --�Ϸù�ȣ
    ;

END UPDATE_SURTAX_CARD;









--���ڽŰ����� �ٿ�ε�
PROCEDURE FILE_DOWN_VAT_E_FILE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_VAT_E_FILE.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_VAT_E_FILE.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_VAT_E_FILE.TAX_CODE%TYPE            --�������̵�(��>110)     
    , W_VAT_MNG_SERIAL      IN  FI_VAT_E_FILE.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű��Ⱓ���й�ȣ
    , W_VAT_MAKE_GB         IN  FI_VAT_E_FILE.VAT_MAKE_GB%TYPE DEFAULT '01'    --�Ű�����(01 : ����Ű�)
)

AS

t_CREATE_YN VARCHAR2(1);  --���ڽŰ����ϻ�������

BEGIN

/*
    --���ڽŰ����ϻ������� 
    BEGIN
    
        SELECT
            CASE
                WHEN COUNT(*) > 0 THEN 'Y'
                ELSE 'N'
            END AS CREATE_YN    
        INTO t_CREATE_YN
        FROM FI_VAT_E_FILE
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND TAX_CODE = W_TAX_CODE
            AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
            AND VAT_MAKE_GB = '01'  ;
            
        --FCM_10387, ������ �Ű��Ⱓ�� ���ڽŰ������� �����Ǿ� ���� �ʽ��ϴ�.
        IF t_CREATE_YN = 'N' THEN
            RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10387', NULL));
        END IF;            

    EXCEPTION
        WHEN OTHERS THEN
        --FCM_10387, ������ �Ű��Ⱓ�� ���ڽŰ������� �����Ǿ� ���� �ʽ��ϴ�.
        IF t_CREATE_YN = 'N' THEN
            RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10387', NULL));
        END IF;
    
    END;
*/    

    OPEN P_CURSOR FOR

    SELECT 
          VAT_MNG_SERIAL  --�ΰ����Ű��Ⱓ���й�ȣ
        , FI_VAT_REPORT_MNG_G.VAT_MNG_SERIAL_F(VAT_MNG_SERIAL) AS VAT_MNG_NM  --�Ű��Ⱓ����_��
        , VAT_MAKE_GB   --�Ű�����
        , FI_COMMON_G.CODE_NAME_F('VAT_MAKE_GB', VAT_MAKE_GB, SOB_ID, ORG_ID) AS VAT_MAKE_NM    --�Ű�����_��
        , SPEC_SERIAL       --�Ϸù�ȣ
        , REPORT_DOC        --�Ű�������
        , REPORT_CONTENT    --�Ű�����  [���ڽŰ����ϳ����ޱ� ��ư Ŭ������ �ô� �� Į������ �ٿ��Ͽ� ���Ϸ� �����Ѵ�.]
    FROM FI_VAT_E_FILE
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
        AND VAT_MAKE_GB = '01'
    ORDER BY SPEC_SERIAL    ;


END FILE_DOWN_VAT_E_FILE;








END FI_VAT_E_FILE_G;
/