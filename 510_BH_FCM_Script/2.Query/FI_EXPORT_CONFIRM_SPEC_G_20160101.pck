CREATE OR REPLACE PACKAGE FI_EXPORT_CONFIRM_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_EXPORT_CONFIRM_SPEC_G
Description  : ��������� Ȯ�� �� ����߱�(��û)�� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : ��������� Ȯ�� �� ����߱�(��û)��
Program History :
    -.�ڷ� ���� �� :
      [�ŷ�����-����, ��������-��������]�� �ڷḦ �����Ͽ� ȭ�鿡 �����ְ�, �� �ٰ��ڷḦ �������� �۾��ڰ� 
      ���ʿ��� �ڷ�([����ȯ�ޱ޵����] �� ���Ե� �ڷ�)�� �����Ͽ� ���� �Ϸ�ȴ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-30   Leem Dong Ern(�ӵ���)
*****************************************************************************/





--�����ڷ����
--�޽��� : �����ڷḦ �����Ͻðڽ��ϱ�? �� ������ �ڷᰡ �ִ� ��� ���� �ڷᰡ �����ǰ� (��)�����˴ϴ�.
--FCM_10365, �ش� �Ű�Ⱓ�� �ڷ�� �����Ǿ� ������ �� �����ϴ�.
PROCEDURE CREATE_EXPORT_CONFIRM(
      W_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    , W_CREATED_BY          IN  FI_EXPORT_CONFIRM_SPEC.CREATED_BY%TYPE          --������
    , W_REPORT_DATE_FR      IN  DATE    --�Ű�Ⱓ_����
    , W_REPORT_DATE_TO      IN  DATE    --�Ű�Ⱓ_����     
);





--��ȸ
PROCEDURE LIST_EXPORT_CONFIRM(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --�������̵�(��>110)        
    , W_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
);






--grid�� �ű� �׸� �߰�
PROCEDURE INSERT_EXPORT_CONFIRM(
       P_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , P_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , P_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --�������̵�(��>110)        
    , P_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    --, P_SPEC_SERIAL         IN  FI_EXPORT_CONFIRM_SPEC.SPEC_SERIAL%TYPE         --�Ϸù�ȣ
    
    , P_EXPORT_DATE         IN  FI_EXPORT_CONFIRM_SPEC.EXPORT_DATE%TYPE         --��������
    , P_PURCHASE_NO         IN  FI_EXPORT_CONFIRM_SPEC.PURCHASE_NO%TYPE         --���Թ�ȣ
    , P_ITEM_NM             IN  FI_EXPORT_CONFIRM_SPEC.ITEM_NM%TYPE             --ǰ��
    , P_SUPPLY_AMT          IN  FI_EXPORT_CONFIRM_SPEC.SUPPLY_AMT%TYPE          --���ް���
    , P_CURRENCY_CODE       IN  FI_EXPORT_CONFIRM_SPEC.CURRENCY_CODE%TYPE       --��ȭ�ڵ�
    , P_CURRENCY_AMT        IN  FI_EXPORT_CONFIRM_SPEC.CURRENCY_AMT%TYPE        --��ȭ�ݾ�
    , P_REMARKS             IN  FI_EXPORT_CONFIRM_SPEC.REMARKS%TYPE             --���

    , P_CREATED_BY	        IN	FI_EXPORT_CONFIRM_SPEC.CREATED_BY%TYPE  --������
);





--grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_EXPORT_CONFIRM(
      W_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --�������̵�(��>110)        
    , W_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL         IN  FI_EXPORT_CONFIRM_SPEC.SPEC_SERIAL%TYPE         --�Ϸù�ȣ
    
    , P_EXPORT_DATE         IN  FI_EXPORT_CONFIRM_SPEC.EXPORT_DATE%TYPE         --��������
    , P_PURCHASE_NO         IN  FI_EXPORT_CONFIRM_SPEC.PURCHASE_NO%TYPE         --���Թ�ȣ
    , P_ITEM_NM             IN  FI_EXPORT_CONFIRM_SPEC.ITEM_NM%TYPE             --ǰ��
    , P_SUPPLY_AMT          IN  FI_EXPORT_CONFIRM_SPEC.SUPPLY_AMT%TYPE          --���ް���
    , P_CURRENCY_CODE       IN  FI_EXPORT_CONFIRM_SPEC.CURRENCY_CODE%TYPE       --��ȭ�ڵ�
    , P_CURRENCY_AMT        IN  FI_EXPORT_CONFIRM_SPEC.CURRENCY_AMT%TYPE        --��ȭ�ݾ�
    , P_REMARKS             IN  FI_EXPORT_CONFIRM_SPEC.REMARKS%TYPE             --���
    
    , P_LAST_UPDATED_BY     IN  FI_EXPORT_CONFIRM_SPEC.LAST_UPDATED_BY%TYPE     --������
);






--grid�� ��ȸ�� �ڷ� ����
PROCEDURE DELETE_EXPORT_CONFIRM(
      W_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --�������̵�(��>110)        
    , W_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL         IN  FI_EXPORT_CONFIRM_SPEC.SPEC_SERIAL%TYPE         --�Ϸù�ȣ
);






--��������� Ȯ�� �� ����߱�(��û)�� ��� ��¿�
PROCEDURE PRINT_EXPORT_CONFIRM(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2 --�������̵�(��>110)      
);





END FI_EXPORT_CONFIRM_SPEC_G;
/
CREATE OR REPLACE PACKAGE BODY FI_EXPORT_CONFIRM_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_EXPORT_CONFIRM_G
Description  : ��������� Ȯ�� �� ����߱�(��û)�� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : ��������� Ȯ�� �� ����߱�(��û)��
Program History :
    -.�ڷ� ���� �� :
      [�ŷ�����-����, ��������-��������]�� �ڷḦ �����Ͽ� ȭ�鿡 �����ְ�, �� �ٰ��ڷḦ �������� �۾��ڰ� 
      ���ʿ��� �ڷ�([����ȯ�ޱ޵����] �� ���Ե� �ڷ�)�� �����Ͽ� ���� �Ϸ�ȴ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-30   Leem Dong Ern(�ӵ���)
*****************************************************************************/






--�����ڷ����
PROCEDURE CREATE_EXPORT_CONFIRM(
      W_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    , W_CREATED_BY          IN  FI_EXPORT_CONFIRM_SPEC.CREATED_BY%TYPE          --������
    , W_REPORT_DATE_FR      IN  DATE    --�Ű�Ⱓ_����
    , W_REPORT_DATE_TO      IN  DATE    --�Ű�Ⱓ_����     
)

AS

t_CLOSING_YN    FI_VAT_REPORT_MNG.CLOSING_YN%TYPE;  --��������
t_SPEC_SERIAL   FI_EXPORT_CONFIRM_SPEC.SPEC_SERIAL%TYPE;  --�Ϸù�ȣ
V_SYSDATE       DATE := GET_LOCAL_DATE(W_SOB_ID);



BEGIN


    --�ش� �Ű�Ⱓ�� �������θ� �ľ��Ѵ�.
    SELECT CLOSING_YN
    INTO t_CLOSING_YN
    FROM FI_VAT_REPORT_MNG
    WHERE   SOB_ID  = W_SOB_ID  --ȸ����̵�
        AND ORG_ID  = W_ORG_ID  --����ξ��̵�
        AND TAX_CODE = W_TAX_CODE                   --�������̵�
        AND VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL    --�ΰ����Ű�Ⱓ���й�ȣ
    ;    
    
    --FCM_10365, �ش� �Ű�Ⱓ�� �ڷ�� �����Ǿ� ������ �� �����ϴ�.
    IF t_CLOSING_YN = 'Y' THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10365', NULL));
    END IF;



    --������ �����ϴ� �ڷᰡ ���� ��� ��� �����Ѵ�.
    DELETE FI_EXPORT_CONFIRM_SPEC
    WHERE   SOB_ID  = W_SOB_ID  --ȸ����̵�
        AND ORG_ID  = W_ORG_ID  --����ξ��̵�
        AND TAX_CODE = W_TAX_CODE                   --�������̵�
        AND VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL    --�ΰ����Ű�Ⱓ���й�ȣ
    ;
    
    
    SELECT NVL(MAX(SPEC_SERIAL), 0) INTO t_SPEC_SERIAL FROM FI_EXPORT_CONFIRM_SPEC;


    INSERT INTO FI_EXPORT_CONFIRM_SPEC(
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�        
        , TAX_CODE      	--�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű�Ⱓ���й�ȣ
        , SPEC_SERIAL	    --�Ϸù�ȣ
        , EXPORT_DATE	    --��������
        , PURCHASE_NO	    --���Թ�ȣ
        , ITEM_NM	        --ǰ��
        , SUPPLY_AMT	    --���ް���
        , CURRENCY_CODE	    --��ȭ�ڵ�
        , CURRENCY_AMT	    --��ȭ�ݾ�        
        , REMARKS	        --���        
        , CREATION_DATE     --������
        , CREATED_BY	    --������
        , LAST_UPDATE_DATE  --������
        , LAST_UPDATED_BY	--������          
    )
    SELECT
          W_SOB_ID  --ȸ����̵�
        , W_ORG_ID  --����ξ��̵�
        , W_TAX_CODE        --�������̵�
        , W_VAT_MNG_SERIAL  --�ΰ����Ű�Ⱓ���й�ȣ
        , t_SPEC_SERIAL + ROWNUM    --�Ϸù�ȣ
    
        , A.REFER1 AS EXPORT_DATE   --��������; �Ű��������
        , '' AS PURCHASE_NO    --���Թ�ȣ
        , A.REMARK AS ITEM_NM  --ǰ��, ��ǥ����
        , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', '')) AS GL_AMOUNT     --���ް���
        , DECODE(A.REFER3, NULL, 'USD', A.REFER3) AS CURRENCY_CODE --��ȭ�ڵ�
        , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS CURRENCY_AMOUNT     --��ȭ�ݾ�    
        , B.SUPP_CUST_NAME AS REMARKS             --���; �ŷ�ó�� 
        
        , V_SYSDATE     --������
        , W_CREATED_BY  --������
        , V_SYSDATE     --������
        , W_CREATED_BY  --������
    FROM FI_SLIP_LINE A
        , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --�ŷ�ó
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        
        --AND A.ACCOUNT_CODE = '2100700'  --�ŷ�����(����/����)
        AND A.ACCOUNT_CODE IN 
            (
                SELECT ACCOUNT_CODE
                FROM FI_ACCOUNT_CONTROL
                WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                    AND ACCOUNT_CLASS_ID = '1972'   --����Ÿ�� : �ΰ���������
            )  --�ŷ�����(����/����)             
        
        AND A.REFER11 = W_TAX_CODE                  --�����
        
        AND TO_DATE(A.REFER1) BETWEEN W_REPORT_DATE_FR AND W_REPORT_DATE_TO   --�Ű��������
        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű��������
        
        AND MANAGEMENT2 = '2'    --�������� : ��������    
        AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
    ;  


END CREATE_EXPORT_CONFIRM;






--��ȸ
PROCEDURE LIST_EXPORT_CONFIRM(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --�������̵�(��>110)        
    , W_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�
        , TAX_CODE      	--�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű�Ⱓ���й�ȣ
        , SPEC_SERIAL	    --�Ϸù�ȣ
        , EXPORT_DATE	    --��������
        , PURCHASE_NO	    --���Թ�ȣ
        , ITEM_NM	        --ǰ��
        , SUPPLY_AMT	    --���ް���
        , CURRENCY_CODE	    --��ȭ�ڵ�
        , CURRENCY_AMT	    --��ȭ�ݾ�
        , REMARKS	        --���
        , '' AS COMPANY     --�ŷ�ó(ȭ�鿡�� �ŷ�ó �˾�ó���ϱ� ����)
        
        --��¿�
        , TO_CHAR(EXPORT_DATE, 'YYYY')  || '�� '
          || TO_NUMBER(TO_CHAR(EXPORT_DATE, 'MM')) || '�� ' 
          || TO_NUMBER(TO_CHAR(EXPORT_DATE, 'DD')) || '��' AS PRINT_EXPORT_DATE 	    --��������
        , '(' || DECODE(CURRENCY_CODE, 'USD', '$', 'JPY', '��', CURRENCY_CODE) 
          || CURRENCY_AMT || ')' AS EXPORT_OUTPUT  --�������        
    FROM FI_EXPORT_CONFIRM_SPEC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
    ORDER BY EXPORT_DATE   ; 


END LIST_EXPORT_CONFIRM;






--grid�� �ű� �׸� �߰�
PROCEDURE INSERT_EXPORT_CONFIRM(
      P_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , P_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , P_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --�������̵�(��>110)        
    , P_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    --, P_SPEC_SERIAL         IN  FI_EXPORT_CONFIRM_SPEC.SPEC_SERIAL%TYPE         --�Ϸù�ȣ
    
    , P_EXPORT_DATE         IN  FI_EXPORT_CONFIRM_SPEC.EXPORT_DATE%TYPE         --��������
    , P_PURCHASE_NO         IN  FI_EXPORT_CONFIRM_SPEC.PURCHASE_NO%TYPE         --���Թ�ȣ
    , P_ITEM_NM             IN  FI_EXPORT_CONFIRM_SPEC.ITEM_NM%TYPE             --ǰ��
    , P_SUPPLY_AMT          IN  FI_EXPORT_CONFIRM_SPEC.SUPPLY_AMT%TYPE          --���ް���
    , P_CURRENCY_CODE       IN  FI_EXPORT_CONFIRM_SPEC.CURRENCY_CODE%TYPE       --��ȭ�ڵ�
    , P_CURRENCY_AMT        IN  FI_EXPORT_CONFIRM_SPEC.CURRENCY_AMT%TYPE        --��ȭ�ݾ�
    , P_REMARKS             IN  FI_EXPORT_CONFIRM_SPEC.REMARKS%TYPE             --���

    , P_CREATED_BY	        IN	FI_EXPORT_CONFIRM_SPEC.CREATED_BY%TYPE  --������
)

AS

V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
t_SPEC_SERIAL   FI_EXPORT_CONFIRM_SPEC.SPEC_SERIAL%TYPE;

BEGIN

    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO t_SPEC_SERIAL FROM FI_EXPORT_CONFIRM_SPEC;   --�Ϸù�ȣ

    INSERT INTO FI_EXPORT_CONFIRM_SPEC(
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�
        , TAX_CODE      	--�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű�Ⱓ���й�ȣ
        , SPEC_SERIAL	    --�Ϸù�ȣ
        
        , EXPORT_DATE       --��������
        , PURCHASE_NO       --���Թ�ȣ
        , ITEM_NM           --ǰ��
        , SUPPLY_AMT        --���ް���
        , CURRENCY_CODE     --��ȭ�ڵ�
        , CURRENCY_AMT      --��ȭ�ݾ�
        , REMARKS           --���

        , CREATION_DATE     --������
        , CREATED_BY	    --������
        , LAST_UPDATE_DATE  --������
        , LAST_UPDATED_BY	--������
    )
    VALUES(
          P_SOB_ID	            --ȸ����̵�
        , P_ORG_ID	            --����ξ��̵�        
        , P_TAX_CODE            --�������̵�
        , P_VAT_MNG_SERIAL	    --�ΰ����Ű�Ⱓ���й�ȣ        
        , t_SPEC_SERIAL	        --�Ϸù�ȣ

        , P_EXPORT_DATE         --��������
        , P_PURCHASE_NO         --���Թ�ȣ
        , P_ITEM_NM             --ǰ��
        , P_SUPPLY_AMT          --���ް���
        , P_CURRENCY_CODE       --��ȭ�ڵ�
        , P_CURRENCY_AMT        --��ȭ�ݾ�
        , P_REMARKS             --���       
       
        , V_SYSDATE             --������
        , P_CREATED_BY	        --������
        , V_SYSDATE             --������
        , P_CREATED_BY	        --������
    );

END INSERT_EXPORT_CONFIRM;







--grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_EXPORT_CONFIRM(
      W_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --�������̵�(��>110)        
    , W_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL         IN  FI_EXPORT_CONFIRM_SPEC.SPEC_SERIAL%TYPE         --�Ϸù�ȣ
    
    , P_EXPORT_DATE         IN  FI_EXPORT_CONFIRM_SPEC.EXPORT_DATE%TYPE         --��������
    , P_PURCHASE_NO         IN  FI_EXPORT_CONFIRM_SPEC.PURCHASE_NO%TYPE         --���Թ�ȣ
    , P_ITEM_NM             IN  FI_EXPORT_CONFIRM_SPEC.ITEM_NM%TYPE             --ǰ��
    , P_SUPPLY_AMT          IN  FI_EXPORT_CONFIRM_SPEC.SUPPLY_AMT%TYPE          --���ް���
    , P_CURRENCY_CODE       IN  FI_EXPORT_CONFIRM_SPEC.CURRENCY_CODE%TYPE       --��ȭ�ڵ�
    , P_CURRENCY_AMT        IN  FI_EXPORT_CONFIRM_SPEC.CURRENCY_AMT%TYPE        --��ȭ�ݾ�
    , P_REMARKS             IN  FI_EXPORT_CONFIRM_SPEC.REMARKS%TYPE             --���
    
    , P_LAST_UPDATED_BY     IN  FI_EXPORT_CONFIRM_SPEC.LAST_UPDATED_BY%TYPE     --������
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);

BEGIN

    UPDATE FI_EXPORT_CONFIRM_SPEC
    SET
          EXPORT_DATE   = P_EXPORT_DATE --��������    
        , PURCHASE_NO	= P_PURCHASE_NO	--���Թ�ȣ
        , ITEM_NM	    = P_ITEM_NM	    --ǰ��
        , SUPPLY_AMT	= P_SUPPLY_AMT	--���ް���
        , CURRENCY_CODE	= P_CURRENCY_CODE   --��ȭ�ڵ�
        , CURRENCY_AMT	= P_CURRENCY_AMT	--��ȭ�ݾ�
        , REMARKS	    = P_REMARKS         --���
                   
        , LAST_UPDATE_DATE  = V_SYSDATE         --������
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY --������
    WHERE   SOB_ID                  = W_SOB_ID                  --ȸ����̵�
        AND ORG_ID                  = W_ORG_ID                  --����ξ��̵�
        AND TAX_CODE                = W_TAX_CODE                --�������̵�        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --�ΰ����Ű�Ⱓ���й�ȣ               
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --�Ϸù�ȣ
    ;

END UPDATE_EXPORT_CONFIRM;







--grid�� ��ȸ�� �ڷ� ����
PROCEDURE DELETE_EXPORT_CONFIRM(
      W_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --�������̵�(��>110)        
    , W_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL         IN  FI_EXPORT_CONFIRM_SPEC.SPEC_SERIAL%TYPE         --�Ϸù�ȣ
)

AS

BEGIN

    DELETE FI_EXPORT_CONFIRM_SPEC
    WHERE   SOB_ID                  = W_SOB_ID                  --ȸ����̵�
        AND ORG_ID                  = W_ORG_ID                  --����ξ��̵�
        AND TAX_CODE                = W_TAX_CODE                --�������̵�        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --�ΰ����Ű�Ⱓ���й�ȣ               
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --�Ϸù�ȣ
    ;

END DELETE_EXPORT_CONFIRM;







--��������� Ȯ�� �� ����߱�(��û)�� ��� ��¿�
PROCEDURE PRINT_EXPORT_CONFIRM(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2 --�������̵�(��>110)      
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          B.VAT_NUMBER  --����ڵ�Ϲ�ȣ
        , A.CORP_NAME   --��ȣ(���θ�)
        , '��ǥ�̻�  ' || A.PRESIDENT_NAME AS PRESIDENT_NAME   --����(��ǥ��)
        , B.ADDR1 || ' ' || B.ADDR2 AS LOCATION     --����������
        , A.TEL_NUMBER                              --��ȭ��ȣ
        , B.BUSINESS_ITEM || '(' || BUSINESS_TYPE || ')' AS BUSINESS    --����(����)                
        , B.BUSINESS_ITEM AS BUSINESS_ITEM    --����
        , B.BUSINESS_TYPE AS BUSINESS_TYPE    --����
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
        AND B.ENABLED_FLAG          = 'Y'
        AND (B.DEFAULT_FLAG         = 'Y'
        OR   ROWNUM                 <= 1)
        ;

END PRINT_EXPORT_CONFIRM;






END FI_EXPORT_CONFIRM_SPEC_G;
/
