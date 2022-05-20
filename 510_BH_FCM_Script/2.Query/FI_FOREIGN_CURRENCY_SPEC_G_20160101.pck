CREATE OR REPLACE PACKAGE FI_FOREIGN_CURRENCY_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FOREIGN_CURRENCY_SPEC_G
Description  : ��ȭȹ����� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : ��ȭȹ�����
Program History :
    -.�ڷ� ���� �� : �ŷ�����-����, ��������-������ �ڷ� �� ����Ű��ȣ�� ���� �ڷ��̴�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-10-04   Leem Dong Ern(�ӵ���)
*****************************************************************************/





--�����ڷ����
--�޽��� : �����ڷḦ �����Ͻðڽ��ϱ�? �� ������ �ڷᰡ �ִ� ��� ���� �ڷᰡ �����ǰ� (��)�����˴ϴ�.
--FCM_10365, �ش� �Ű�Ⱓ�� �ڷ�� �����Ǿ� ������ �� �����ϴ�.
PROCEDURE CREATE_FOREIGN_CURRENCY_SPEC(
      W_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    , W_CREATED_BY          IN  FI_FOREIGN_CURRENCY_SPEC.CREATED_BY%TYPE          --������
    , W_REPORT_DATE_FR      IN  DATE    --�Ű�Ⱓ_����
    , W_REPORT_DATE_TO      IN  DATE    --�Ű�Ⱓ_����    
);





--��ȸ
PROCEDURE LIST_FOREIGN_CURRENCY_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
);






--grid�� �ű� �׸� �߰�
PROCEDURE INSERT_FOREIGN_CURRENCY_SPEC(
      P_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , P_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , P_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --�������̵�(��>110)        
    , P_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    --, P_SPEC_SERIAL         IN  FI_FOREIGN_CURRENCY_SPEC.SPEC_SERIAL%TYPE         --�Ϸù�ȣ
    
    , P_SUPPLY_DATE         IN  FI_FOREIGN_CURRENCY_SPEC.SUPPLY_DATE%TYPE   --��������
    , P_CORP_NAME           IN  FI_FOREIGN_CURRENCY_SPEC.CORP_NAME%TYPE     --��ȣ�׼���
    , P_COUNTRY_NM          IN  FI_FOREIGN_CURRENCY_SPEC.COUNTRY_NM%TYPE    --����
    , P_GUBUN_ITEM          IN  FI_FOREIGN_CURRENCY_SPEC.GUBUN_ITEM%TYPE    --����_��ȭ
    , P_GUBUN_PERSON        IN  FI_FOREIGN_CURRENCY_SPEC.GUBUN_PERSON%TYPE  --����_�뿪
    , P_ITEM_NM             IN  FI_FOREIGN_CURRENCY_SPEC.ITEM_NM%TYPE       --��ȭ��Ī
    , P_ITEM_CNT            IN  FI_FOREIGN_CURRENCY_SPEC.ITEM_CNT%TYPE      --����
    , P_UNIT                IN  FI_FOREIGN_CURRENCY_SPEC.UNIT%TYPE          --����
    , P_PRICE               IN  FI_FOREIGN_CURRENCY_SPEC.PRICE%TYPE         --�ܰ�
    , P_SUPPLY_AMT          IN  FI_FOREIGN_CURRENCY_SPEC.SUPPLY_AMT%TYPE    --���ޱݾ�

    , P_CREATED_BY	        IN	FI_FOREIGN_CURRENCY_SPEC.CREATED_BY%TYPE  --������
);





--grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_FOREIGN_CURRENCY_SPEC(
      W_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --�������̵�(��>110)        
    , W_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL         IN  FI_FOREIGN_CURRENCY_SPEC.SPEC_SERIAL%TYPE         --�Ϸù�ȣ
    
    , P_SUPPLY_DATE         IN  FI_FOREIGN_CURRENCY_SPEC.SUPPLY_DATE%TYPE   --��������
    , P_CORP_NAME           IN  FI_FOREIGN_CURRENCY_SPEC.CORP_NAME%TYPE     --��ȣ�׼���
    , P_COUNTRY_NM          IN  FI_FOREIGN_CURRENCY_SPEC.COUNTRY_NM%TYPE    --����
    , P_GUBUN_ITEM          IN  FI_FOREIGN_CURRENCY_SPEC.GUBUN_ITEM%TYPE    --����_��ȭ
    , P_GUBUN_PERSON        IN  FI_FOREIGN_CURRENCY_SPEC.GUBUN_PERSON%TYPE  --����_�뿪
    , P_ITEM_NM             IN  FI_FOREIGN_CURRENCY_SPEC.ITEM_NM%TYPE       --��ȭ��Ī
    , P_ITEM_CNT            IN  FI_FOREIGN_CURRENCY_SPEC.ITEM_CNT%TYPE      --����
    , P_UNIT                IN  FI_FOREIGN_CURRENCY_SPEC.UNIT%TYPE          --����
    , P_PRICE               IN  FI_FOREIGN_CURRENCY_SPEC.PRICE%TYPE         --�ܰ�
    , P_SUPPLY_AMT          IN  FI_FOREIGN_CURRENCY_SPEC.SUPPLY_AMT%TYPE    --���ޱݾ�
    
    , P_LAST_UPDATED_BY     IN  FI_FOREIGN_CURRENCY_SPEC.LAST_UPDATED_BY%TYPE     --������
);






--grid�� ��ȸ�� �ڷ� ����
PROCEDURE DELETE_FOREIGN_CURRENCY_SPEC(
      W_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --�������̵�(��>110)        
    , W_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL         IN  FI_FOREIGN_CURRENCY_SPEC.SPEC_SERIAL%TYPE         --�Ϸù�ȣ
);






--��ȭȹ����� ��� ��¿�
PROCEDURE PRINT_FOREIGN_CURRENCY_SPEC(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��>110)         
);





END FI_FOREIGN_CURRENCY_SPEC_G;
/
CREATE OR REPLACE PACKAGE BODY FI_FOREIGN_CURRENCY_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FOREIGN_CURRENCY_SPEC_G
Description  : ��ȭȹ����� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : ��ȭȹ�����
Program History :
    -.�ڷ� ���� �� : �ŷ�����-����, ��������-������ �ڷ� �� ����Ű��ȣ�� ���� �ڷ��̴�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-10-04   Leem Dong Ern(�ӵ���)
*****************************************************************************/






--�����ڷ����
PROCEDURE CREATE_FOREIGN_CURRENCY_SPEC(
      W_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    , W_CREATED_BY          IN  FI_FOREIGN_CURRENCY_SPEC.CREATED_BY%TYPE          --������
    , W_REPORT_DATE_FR      IN  DATE    --�Ű�Ⱓ_����
    , W_REPORT_DATE_TO      IN  DATE    --�Ű�Ⱓ_����     
)

AS

t_CLOSING_YN    FI_VAT_REPORT_MNG.CLOSING_YN%TYPE;  --��������
t_SPEC_SERIAL   FI_FOREIGN_CURRENCY_SPEC.SPEC_SERIAL%TYPE;  --�Ϸù�ȣ
V_SYSDATE       DATE := GET_LOCAL_DATE(W_SOB_ID);



BEGIN


    --�ش� �Ű�Ⱓ�� �������θ� �ľ��Ѵ�.
    SELECT CLOSING_YN
    INTO t_CLOSING_YN
    FROM FI_VAT_REPORT_MNG
    WHERE   SOB_ID  = W_SOB_ID  --ȸ����̵�
        AND ORG_ID  = W_ORG_ID  --����ξ��̵�
        AND TAX_CODE = W_TAX_CODE             --�������̵�
        AND VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL    --�ΰ����Ű�Ⱓ���й�ȣ
    ;    
    
    --FCM_10365, �ش� �Ű�Ⱓ�� �ڷ�� �����Ǿ� ������ �� �����ϴ�.
    IF t_CLOSING_YN = 'Y' THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10365', NULL));
    END IF;



    --������ �����ϴ� �ڷᰡ ���� ��� ��� �����Ѵ�.
    DELETE FI_FOREIGN_CURRENCY_SPEC
    WHERE   SOB_ID  = W_SOB_ID  --ȸ����̵�
        AND ORG_ID  = W_ORG_ID  --����ξ��̵�
        AND TAX_CODE = W_TAX_CODE --�������̵�
        AND VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL    --�ΰ����Ű�Ⱓ���й�ȣ
    ;
    
    
    SELECT NVL(MAX(SPEC_SERIAL), 0) INTO t_SPEC_SERIAL FROM FI_FOREIGN_CURRENCY_SPEC;


    INSERT INTO FI_FOREIGN_CURRENCY_SPEC(
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�        
        , TAX_CODE	      --�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű�Ⱓ���й�ȣ
        , SPEC_SERIAL	    --�Ϸù�ȣ        
        , SUPPLY_DATE	    --��������
        , CORP_NAME	        --��ȣ�׼���
        , COUNTRY_NM	    --����
        , GUBUN_ITEM	    --����_��ȭ
        , GUBUN_PERSON	    --����_�뿪
        , ITEM_NM	        --��ȭ��Ī
        , ITEM_CNT	        --����
        , UNIT	            --����
        , PRICE	            --�ܰ�
        , SUPPLY_AMT	    --���ޱݾ�        
        , CREATION_DATE     --������
        , CREATED_BY	    --������
        , LAST_UPDATE_DATE  --������
        , LAST_UPDATED_BY	--������          
    )
    SELECT
          W_SOB_ID  --ȸ����̵�
        , W_ORG_ID  --����ξ��̵�
        , W_TAX_CODE       --�������̵�
        , W_VAT_MNG_SERIAL          --�ΰ����Ű�Ⱓ���й�ȣ
        , t_SPEC_SERIAL + ROWNUM    --�Ϸù�ȣ
        
        , A.REFER1 AS SUPPLY_DATE               --��������; �Ű��������
        , B.SUPP_CUST_NAME AS CORP_NAME         --�ŷ�ó
        , C.COUNTRY_SHORT_NAME AS COUNTRY_NM    --����
        , 'Y' AS GUBUN_ITEM     --����_��ȭ
        , NULL AS GUBUN_PERSON  --����_�뿪
        , A.REMARK AS ITEM_NM   --��ȭ_��Ī, ��ǥ����    
        , 0 AS ITEM_CNT         --����
        , 'PCS' AS UNIT         --����
        , 0.00 AS PRICE         --�ܰ�
        , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', '')) AS GL_AMOUNT     --���ް���
    
        , V_SYSDATE     --������
        , W_CREATED_BY  --������
        , V_SYSDATE     --������
        , W_CREATED_BY  --������    
    FROM FI_SLIP_LINE A
        , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO, COUNTRY_CODE FROM FI_SUPP_CUST_V) B  --�ŷ�ó
        , (SELECT * FROM EAPP_COUNTRY) C
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
        
        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --�Ű��������
        AND TO_DATE(A.REFER1) BETWEEN W_REPORT_DATE_FR AND W_REPORT_DATE_TO   --�Ű��������
        
        --�ŷ�����-����, ��������-������ �ڷ� �� ����Ű��ȣ�� ���� �ڷ��̴�.
        AND MANAGEMENT2 = '3'    --�������� : ����    
        AND (A.REFER4 IS NULL OR TRIM(A.REFER4) = '')
        
        AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
        AND B.COUNTRY_CODE = C.COUNTRY_CODE(+) 
        ;


END CREATE_FOREIGN_CURRENCY_SPEC;






--��ȸ
PROCEDURE LIST_FOREIGN_CURRENCY_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --�������̵�(��>110)        
    , W_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�
        , TAX_CODE	      --�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű�Ⱓ���й�ȣ
        , SPEC_SERIAL	    --�Ϸù�ȣ
        , SUPPLY_DATE	    --��������
        , CORP_NAME	        --��ȣ�׼���
        , COUNTRY_NM	    --����
        , GUBUN_ITEM	    --����_��ȭ
        , GUBUN_PERSON	    --����_�뿪
        , ITEM_NM	        --��Ī
        , ITEM_CNT	        --����
        , UNIT	            --����
        , PRICE	            --�ܰ�
        , SUPPLY_AMT	    --���ް���        

        --��¿�
        , TO_CHAR(SUPPLY_DATE, 'YYYY') AS PRINT_YEAR
        , TO_NUMBER(TO_CHAR(SUPPLY_DATE, 'MM')) AS PRINT_MONTH
        , TO_NUMBER(TO_CHAR(SUPPLY_DATE, 'DD')) AS PRINT_DATE       
    FROM FI_FOREIGN_CURRENCY_SPEC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
    ORDER BY SUPPLY_DATE   
    ; 


END LIST_FOREIGN_CURRENCY_SPEC;






--grid�� �ű� �׸� �߰�
PROCEDURE INSERT_FOREIGN_CURRENCY_SPEC(
      P_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , P_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , P_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --�������̵�(��>110)        
    , P_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    --, P_SPEC_SERIAL         IN  FI_FOREIGN_CURRENCY_SPEC.SPEC_SERIAL%TYPE         --�Ϸù�ȣ
    
    , P_SUPPLY_DATE         IN  FI_FOREIGN_CURRENCY_SPEC.SUPPLY_DATE%TYPE   --��������
    , P_CORP_NAME           IN  FI_FOREIGN_CURRENCY_SPEC.CORP_NAME%TYPE     --��ȣ�׼���
    , P_COUNTRY_NM          IN  FI_FOREIGN_CURRENCY_SPEC.COUNTRY_NM%TYPE    --����
    , P_GUBUN_ITEM          IN  FI_FOREIGN_CURRENCY_SPEC.GUBUN_ITEM%TYPE    --����_��ȭ
    , P_GUBUN_PERSON        IN  FI_FOREIGN_CURRENCY_SPEC.GUBUN_PERSON%TYPE  --����_�뿪
    , P_ITEM_NM             IN  FI_FOREIGN_CURRENCY_SPEC.ITEM_NM%TYPE       --��ȭ��Ī
    , P_ITEM_CNT            IN  FI_FOREIGN_CURRENCY_SPEC.ITEM_CNT%TYPE      --����
    , P_UNIT                IN  FI_FOREIGN_CURRENCY_SPEC.UNIT%TYPE          --����
    , P_PRICE               IN  FI_FOREIGN_CURRENCY_SPEC.PRICE%TYPE         --�ܰ�
    , P_SUPPLY_AMT          IN  FI_FOREIGN_CURRENCY_SPEC.SUPPLY_AMT%TYPE    --���ޱݾ�

    , P_CREATED_BY	        IN	FI_FOREIGN_CURRENCY_SPEC.CREATED_BY%TYPE  --������
)

AS

V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
t_SPEC_SERIAL   FI_FOREIGN_CURRENCY_SPEC.SPEC_SERIAL%TYPE;

BEGIN

    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO t_SPEC_SERIAL FROM FI_FOREIGN_CURRENCY_SPEC;   --�Ϸù�ȣ

    INSERT INTO FI_FOREIGN_CURRENCY_SPEC(
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�
        , TAX_CODE       	--�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű�Ⱓ���й�ȣ
        , SPEC_SERIAL	    --�Ϸù�ȣ
        
        , SUPPLY_DATE	    --��������
        , CORP_NAME	        --��ȣ�׼���
        , COUNTRY_NM	    --����
        , GUBUN_ITEM	    --����_��ȭ
        , GUBUN_PERSON	    --����_�뿪
        , ITEM_NM	        --��Ī
        , ITEM_CNT	        --����
        , UNIT	            --����
        , PRICE	            --�ܰ�
        , SUPPLY_AMT	    --���ް���  

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

        , P_SUPPLY_DATE	        --��������
        , P_CORP_NAME	        --��ȣ�׼���
        , P_COUNTRY_NM	        --����
        , P_GUBUN_ITEM	        --����_��ȭ
        , P_GUBUN_PERSON	    --����_�뿪
        , P_ITEM_NM	            --��Ī
        , P_ITEM_CNT	        --����
        , P_UNIT	            --����
        , P_PRICE	            --�ܰ�
        , P_SUPPLY_AMT	        --���ް���      
       
        , V_SYSDATE             --������
        , P_CREATED_BY	        --������
        , V_SYSDATE             --������
        , P_CREATED_BY	        --������
    );

END INSERT_FOREIGN_CURRENCY_SPEC;







--grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_FOREIGN_CURRENCY_SPEC(
      W_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --�������̵�(��>110)        
    , W_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL         IN  FI_FOREIGN_CURRENCY_SPEC.SPEC_SERIAL%TYPE         --�Ϸù�ȣ
    
    , P_SUPPLY_DATE         IN  FI_FOREIGN_CURRENCY_SPEC.SUPPLY_DATE%TYPE   --��������
    , P_CORP_NAME           IN  FI_FOREIGN_CURRENCY_SPEC.CORP_NAME%TYPE     --��ȣ�׼���
    , P_COUNTRY_NM          IN  FI_FOREIGN_CURRENCY_SPEC.COUNTRY_NM%TYPE    --����
    , P_GUBUN_ITEM          IN  FI_FOREIGN_CURRENCY_SPEC.GUBUN_ITEM%TYPE    --����_��ȭ
    , P_GUBUN_PERSON        IN  FI_FOREIGN_CURRENCY_SPEC.GUBUN_PERSON%TYPE  --����_�뿪
    , P_ITEM_NM             IN  FI_FOREIGN_CURRENCY_SPEC.ITEM_NM%TYPE       --��ȭ��Ī
    , P_ITEM_CNT            IN  FI_FOREIGN_CURRENCY_SPEC.ITEM_CNT%TYPE      --����
    , P_UNIT                IN  FI_FOREIGN_CURRENCY_SPEC.UNIT%TYPE          --����
    , P_PRICE               IN  FI_FOREIGN_CURRENCY_SPEC.PRICE%TYPE         --�ܰ�
    , P_SUPPLY_AMT          IN  FI_FOREIGN_CURRENCY_SPEC.SUPPLY_AMT%TYPE    --���ޱݾ�
    
    , P_LAST_UPDATED_BY     IN  FI_FOREIGN_CURRENCY_SPEC.LAST_UPDATED_BY%TYPE     --������
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);

BEGIN

    UPDATE FI_FOREIGN_CURRENCY_SPEC
    SET
          SUPPLY_DATE   = P_SUPPLY_DATE     --��������    
        , CORP_NAME	    = P_CORP_NAME	    --��ȣ�׼���
        , COUNTRY_NM	= P_COUNTRY_NM	    --����
        , GUBUN_ITEM	= P_GUBUN_ITEM	    --����_��ȭ
        , GUBUN_PERSON	= P_GUBUN_PERSON    --����_�뿪
        , ITEM_NM	    = P_ITEM_NM	        --��ȭ��Ī
        , ITEM_CNT	    = P_ITEM_CNT	    --����
        , UNIT	        = P_UNIT	        --����
        , PRICE	        = P_PRICE	        --�ܰ�
        , SUPPLY_AMT	= P_SUPPLY_AMT	    --���ޱݾ�
                  
        , LAST_UPDATE_DATE  = V_SYSDATE         --������
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY --������
    WHERE   SOB_ID                  = W_SOB_ID                  --ȸ����̵�
        AND ORG_ID                  = W_ORG_ID                  --����ξ��̵�
        AND TAX_CODE                = W_TAX_CODE                --�������̵�        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --�ΰ����Ű�Ⱓ���й�ȣ               
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --�Ϸù�ȣ
    ;

END UPDATE_FOREIGN_CURRENCY_SPEC;







--grid�� ��ȸ�� �ڷ� ����
PROCEDURE DELETE_FOREIGN_CURRENCY_SPEC(
      W_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --�������̵�(��>110)        
    , W_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL         IN  FI_FOREIGN_CURRENCY_SPEC.SPEC_SERIAL%TYPE         --�Ϸù�ȣ
)

AS

BEGIN

    DELETE FI_FOREIGN_CURRENCY_SPEC
    WHERE   SOB_ID                  = W_SOB_ID                  --ȸ����̵�
        AND ORG_ID                  = W_ORG_ID                  --����ξ��̵�
        AND TAX_CODE                = W_TAX_CODE                --�������̵�        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --�ΰ����Ű�Ⱓ���й�ȣ               
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --�Ϸù�ȣ
    ;

END DELETE_FOREIGN_CURRENCY_SPEC;







--��ȭȹ����� ��� ��¿�
PROCEDURE PRINT_FOREIGN_CURRENCY_SPEC(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��>110)      
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          B.VAT_NUMBER  --����ڵ�Ϲ�ȣ
        , A.CORP_NAME   --��ȣ(���θ�)
        , A.PRESIDENT_NAME AS PRESIDENT_NAME   --����(��ǥ��)
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

END PRINT_FOREIGN_CURRENCY_SPEC;






END FI_FOREIGN_CURRENCY_SPEC_G;
/
