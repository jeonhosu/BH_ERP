CREATE OR REPLACE PACKAGE FI_TARIFF_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_TARIFF_SPEC_G
Description  : ����ȯ�ޱݵ���� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (����ȯ�ޱݵ����)
Program History :
    -.����>�� �ڷ�� �۾��ڰ� �ΰ���ġ���Ű�� �����Ͽ� ���� �Է��ϴ� �ڷ�� ��ǥ�ʹ� �����Ѵ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-19   Leem Dong Ern(�ӵ���)
*****************************************************************************/





--grid�� ��ȸ�Ǵ� �ڷ� ����
PROCEDURE LIST_TARIFF_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_TARIFF_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID                  IN  FI_TARIFF_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE                IN  FI_TARIFF_SPEC.TAX_CODE%TYPE              --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL          IN  FI_TARIFF_SPEC.VAT_MNG_SERIAL%TYPE        --�ΰ����Ű�Ⱓ���й�ȣ
);







--grid�� ��ȸ�Ǵ� �ڷ� �� �ݾ��ڷ�鿡 ���� �հ�
PROCEDURE SUM_TARIFF_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_TARIFF_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID                  IN  FI_TARIFF_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE                IN  FI_TARIFF_SPEC.TAX_CODE%TYPE              --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL          IN  FI_TARIFF_SPEC.VAT_MNG_SERIAL%TYPE        --�ΰ����Ű�Ⱓ���й�ȣ
);







--grid�� �ű� �׸� �߰�
PROCEDURE INSERT_TARIFF_SPEC(
      P_SOB_ID	            IN 	FI_TARIFF_SPEC.SOB_ID%TYPE	            --ȸ����̵�
    , P_ORG_ID	            IN 	FI_TARIFF_SPEC.ORG_ID%TYPE	            --����ξ��̵�
    , P_TAX_CODE	          IN 	FI_TARIFF_SPEC.TAX_CODE%TYPE            --�������̵�
    , P_VAT_MNG_SERIAL	    IN 	FI_TARIFF_SPEC.VAT_MNG_SERIAL%TYPE     --�ΰ����Ű�Ⱓ���й�ȣ
    --, P_SPEC_SERIAL	        IN 	FI_TARIFF_SPEC.SPEC_SERIAL%TYPE        --�Ϸù�ȣ
    
    , P_SUPPLY_DATE	        IN 	FI_TARIFF_SPEC.SUPPLY_DATE%TYPE     --��������
    , P_SUPPLY_AMT	        IN 	FI_TARIFF_SPEC.SUPPLY_AMT%TYPE      --���ޱݾ�
    , P_CORP_NAME	          IN 	FI_TARIFF_SPEC.CORP_NAME%TYPE       --��ü ��ȣ
    , P_VAT_NUMBER	        IN 	FI_TARIFF_SPEC.VAT_NUMBER%TYPE      --����ڵ�Ϲ�ȣ
    , P_LC_NO	              IN 	FI_TARIFF_SPEC.LC_NO%TYPE           --�����ſ����ȣ    
    , P_CREATED_BY	        IN	FI_TARIFF_SPEC.CREATED_BY%TYPE	    --������
);





--grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_TARIFF_SPEC(
      W_SOB_ID	            IN 	FI_TARIFF_SPEC.SOB_ID%TYPE	            --ȸ����̵�
    , W_ORG_ID	            IN 	FI_TARIFF_SPEC.ORG_ID%TYPE	            --����ξ��̵�
    , W_TAX_CODE	          IN 	FI_TARIFF_SPEC.TAX_CODE%TYPE            --�������̵�
    , W_VAT_MNG_SERIAL	    IN 	FI_TARIFF_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL	        IN 	FI_TARIFF_SPEC.SPEC_SERIAL%TYPE         --�Ϸù�ȣ
    
    , P_SUPPLY_DATE	        IN 	FI_TARIFF_SPEC.SUPPLY_DATE%TYPE         --��������
    , P_SUPPLY_AMT	        IN 	FI_TARIFF_SPEC.SUPPLY_AMT%TYPE          --���ޱݾ�
    , P_CORP_NAME	          IN 	FI_TARIFF_SPEC.CORP_NAME%TYPE           --��ü ��ȣ
    , P_VAT_NUMBER	        IN 	FI_TARIFF_SPEC.VAT_NUMBER%TYPE          --����ڵ�Ϲ�ȣ
    , P_LC_NO	              IN 	FI_TARIFF_SPEC.LC_NO%TYPE               --�����ſ����ȣ    
    , P_LAST_UPDATED_BY     IN  FI_TARIFF_SPEC.LAST_UPDATED_BY%TYPE     --������
);






--grid�� ��ȸ�� �ڷ� ����
PROCEDURE DELETE_TARIFF_SPEC(
      W_SOB_ID	            IN 	FI_BLD_AMT_SPEC.SOB_ID%TYPE	            --ȸ����̵�
    , W_ORG_ID	            IN 	FI_BLD_AMT_SPEC.ORG_ID%TYPE	            --����ξ��̵�
    , W_TAX_CODE	          IN 	FI_BLD_AMT_SPEC.TAX_CODE%TYPE           --�������̵�
    , W_VAT_MNG_SERIAL	    IN 	FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE     --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL	        IN 	FI_BLD_AMT_SPEC.SPEC_SERIAL%TYPE        --�Ϸù�ȣ
);






--����ȯ�ޱݵ���� ��� ��¿�
PROCEDURE PRINT_TARIFF_SPEC(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID              IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE            IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --�������̵�(��>110)     
);





END FI_TARIFF_SPEC_G;
/
CREATE OR REPLACE PACKAGE BODY FI_TARIFF_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_TARIFF_SPEC_G
Description  : ����ȯ�ޱݵ���� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (����ȯ�ޱݵ����)
Program History :
    -.����>�� �ڷ�� �۾��ڰ� �ΰ���ġ���Ű�� �����Ͽ� ���� �Է��ϴ� �ڷ�� ��ǥ�ʹ� �����Ѵ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-19   Leem Dong Ern(�ӵ���)
*****************************************************************************/






--grid�� ��ȸ�Ǵ� �ڷ� ����
PROCEDURE LIST_TARIFF_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_TARIFF_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID                  IN  FI_TARIFF_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE                IN  FI_TARIFF_SPEC.TAX_CODE%TYPE              --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL          IN  FI_TARIFF_SPEC.VAT_MNG_SERIAL%TYPE        --�ΰ����Ű�Ⱓ���й�ȣ
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�
        , TAX_CODE	      --�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű�Ⱓ���й�ȣ
        , FI_VAT_REPORT_MNG_G.VAT_MNG_SERIAL_F(VAT_MNG_SERIAL) AS VAT_REPORT_NM   --�Ű�Ⱓ���и�
        , SPEC_SERIAL	    --�Ϸù�ȣ        
        
        , SUPPLY_DATE                               --��������
        , TO_CHAR(SUPPLY_DATE, 'YYYY') AS DATE_YEAR --��������_��
        , TO_CHAR(SUPPLY_DATE, 'MM') AS DATE_MM     --��������_��
        , TO_CHAR(SUPPLY_DATE, 'DD') AS DATE_DD     --��������_��
        , SUPPLY_AMT    --���ޱݾ�
        , CORP_NAME     --��ü ��ȣ
        , VAT_NUMBER    --����ڵ�Ϲ�ȣ
        , LC_NO         --�����ſ����ȣ       
    FROM FI_TARIFF_SPEC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE          
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
    ORDER BY SUPPLY_DATE, CORP_NAME   ; 


END LIST_TARIFF_SPEC;






--grid�� ��ȸ�Ǵ� �ڷ� �� �ݾ��ڷ�鿡 ���� �հ�
PROCEDURE SUM_TARIFF_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_TARIFF_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID                  IN  FI_TARIFF_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE                IN  FI_TARIFF_SPEC.TAX_CODE%TYPE              --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL          IN  FI_TARIFF_SPEC.VAT_MNG_SERIAL%TYPE        --�ΰ����Ű�Ⱓ���й�ȣ
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          NVL(SUM(SUPPLY_AMT), 0) AS DEPOSIT   --���ޱݾ�        
    FROM FI_TARIFF_SPEC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   ;


END SUM_TARIFF_SPEC;








--grid�� �ű� �׸� �߰�
PROCEDURE INSERT_TARIFF_SPEC(
      P_SOB_ID	            IN 	FI_TARIFF_SPEC.SOB_ID%TYPE	            --ȸ����̵�
    , P_ORG_ID	            IN 	FI_TARIFF_SPEC.ORG_ID%TYPE	            --����ξ��̵�
    , P_TAX_CODE	          IN 	FI_TARIFF_SPEC.TAX_CODE%TYPE            --�������̵�
    , P_VAT_MNG_SERIAL	    IN 	FI_TARIFF_SPEC.VAT_MNG_SERIAL%TYPE     --�ΰ����Ű�Ⱓ���й�ȣ
    --, P_SPEC_SERIAL	        IN 	FI_TARIFF_SPEC.SPEC_SERIAL%TYPE        --�Ϸù�ȣ
    
    , P_SUPPLY_DATE	        IN 	FI_TARIFF_SPEC.SUPPLY_DATE%TYPE     --��������
    , P_SUPPLY_AMT	        IN 	FI_TARIFF_SPEC.SUPPLY_AMT%TYPE      --���ޱݾ�
    , P_CORP_NAME	          IN 	FI_TARIFF_SPEC.CORP_NAME%TYPE       --��ü ��ȣ
    , P_VAT_NUMBER	        IN 	FI_TARIFF_SPEC.VAT_NUMBER%TYPE      --����ڵ�Ϲ�ȣ
    , P_LC_NO	              IN 	FI_TARIFF_SPEC.LC_NO%TYPE           --�����ſ����ȣ    
    , P_CREATED_BY	        IN	FI_TARIFF_SPEC.CREATED_BY%TYPE	    --������
)

AS

V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
t_SPEC_SERIAL   FI_TARIFF_SPEC.SPEC_SERIAL%TYPE;

BEGIN

    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO t_SPEC_SERIAL FROM FI_TARIFF_SPEC;   --�Ϸù�ȣ

    INSERT INTO FI_TARIFF_SPEC(
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�
        , TAX_CODE	      --�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű�Ⱓ���й�ȣ
        , SPEC_SERIAL	    --�Ϸù�ȣ
        
        , SUPPLY_DATE       --��������
        , SUPPLY_AMT        --���ޱݾ�
        , CORP_NAME         --��ü ��ȣ
        , VAT_NUMBER        --����ڵ�Ϲ�ȣ
        , LC_NO             --�����ſ����ȣ

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

        , P_SUPPLY_DATE         --��������
        , P_SUPPLY_AMT          --���ޱݾ�
        , P_CORP_NAME           --��ü ��ȣ
        , P_VAT_NUMBER          --����ڵ�Ϲ�ȣ
        , P_LC_NO               --�����ſ����ȣ
       
        , V_SYSDATE             --������
        , P_CREATED_BY	        --������
        , V_SYSDATE             --������
        , P_CREATED_BY	        --������
    );

END INSERT_TARIFF_SPEC;







--grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_TARIFF_SPEC(
      W_SOB_ID	            IN 	FI_TARIFF_SPEC.SOB_ID%TYPE	            --ȸ����̵�
    , W_ORG_ID	            IN 	FI_TARIFF_SPEC.ORG_ID%TYPE	            --����ξ��̵�
    , W_TAX_CODE	          IN 	FI_TARIFF_SPEC.TAX_CODE%TYPE            --�������̵�
    , W_VAT_MNG_SERIAL	    IN 	FI_TARIFF_SPEC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL	        IN 	FI_TARIFF_SPEC.SPEC_SERIAL%TYPE         --�Ϸù�ȣ
    
    , P_SUPPLY_DATE	        IN 	FI_TARIFF_SPEC.SUPPLY_DATE%TYPE         --��������
    , P_SUPPLY_AMT	        IN 	FI_TARIFF_SPEC.SUPPLY_AMT%TYPE          --���ޱݾ�
    , P_CORP_NAME	          IN 	FI_TARIFF_SPEC.CORP_NAME%TYPE           --��ü ��ȣ
    , P_VAT_NUMBER	        IN 	FI_TARIFF_SPEC.VAT_NUMBER%TYPE          --����ڵ�Ϲ�ȣ
    , P_LC_NO	              IN 	FI_TARIFF_SPEC.LC_NO%TYPE               --�����ſ����ȣ    
    , P_LAST_UPDATED_BY     IN  FI_TARIFF_SPEC.LAST_UPDATED_BY%TYPE     --������
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);

BEGIN

    UPDATE FI_TARIFF_SPEC
    SET
          SUPPLY_DATE   = P_SUPPLY_DATE --��������    
        , SUPPLY_AMT	  = P_SUPPLY_AMT	--���ޱݾ�    
        , CORP_NAME	    = P_CORP_NAME	--��ü ��ȣ    
        , VAT_NUMBER	  = P_VAT_NUMBER	--����ڵ�Ϲ�ȣ    
        , LC_NO         = P_LC_NO	    --�����ſ����ȣ      
               
        , LAST_UPDATE_DATE  = V_SYSDATE         --������
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY --������
    WHERE   SOB_ID                  = W_SOB_ID                  --ȸ����̵�
        AND ORG_ID                  = W_ORG_ID                  --����ξ��̵�
        AND TAX_CODE                = W_TAX_CODE                --�������̵�        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --�ΰ����Ű�Ⱓ���й�ȣ               
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --�Ϸù�ȣ
    ;

END UPDATE_TARIFF_SPEC;





--grid�� ��ȸ�� �ڷ� ����
PROCEDURE DELETE_TARIFF_SPEC(
      W_SOB_ID	            IN 	FI_BLD_AMT_SPEC.SOB_ID%TYPE	            --ȸ����̵�
    , W_ORG_ID	            IN 	FI_BLD_AMT_SPEC.ORG_ID%TYPE	            --����ξ��̵�
    , W_TAX_CODE	          IN 	FI_BLD_AMT_SPEC.TAX_CODE%TYPE           --�������̵�
    , W_VAT_MNG_SERIAL	    IN 	FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE     --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL	        IN 	FI_BLD_AMT_SPEC.SPEC_SERIAL%TYPE        --�Ϸù�ȣ
)

AS

BEGIN

    DELETE FI_TARIFF_SPEC
    WHERE   SOB_ID                  = W_SOB_ID                  --ȸ����̵�
        AND ORG_ID                  = W_ORG_ID                  --����ξ��̵�
        AND TAX_CODE                = W_TAX_CODE                --�������̵�        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --�ΰ����Ű�Ⱓ���й�ȣ               
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --�Ϸù�ȣ
    ;

END DELETE_TARIFF_SPEC;







--����ȯ�ޱݵ���� ��� ��¿�
PROCEDURE PRINT_TARIFF_SPEC(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID              IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE            IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --�������̵�(��>110)     
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          B.VAT_NUMBER                          --����ڵ�Ϲ�ȣ
        , A.CORP_NAME                           --��ȣ(���θ�)
        , A.PRESIDENT_NAME                      --����(��ǥ��)
        , B.ADDR1 || ' ' || B.ADDR2 AS LOCATION --����������
        , A.TEL_NUMBER                          --��ȭ��ȣ
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
        OR   ROWNUM                 <= 1);


END PRINT_TARIFF_SPEC;






END FI_TARIFF_SPEC_G;
/
