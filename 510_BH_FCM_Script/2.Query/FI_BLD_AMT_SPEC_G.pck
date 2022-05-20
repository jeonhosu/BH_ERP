CREATE OR REPLACE PACKAGE FI_BLD_AMT_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_BLD_AMT_SPEC_G
Description  : �ε����Ӵ���ް��׸��� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (�ε����Ӵ���ް��׸���)
Program History :
    -.����>�� �ڷ�� �۾��ڰ� �ΰ���ġ���Ű�� �����Ͽ� ���� �Է��ϴ� �ڷ�� ��ǥ�ʹ� �����Ѵ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-16   Leem Dong Ern(�ӵ���)
*****************************************************************************/





--grid�� ��ȸ�Ǵ� �ڷ� ����
PROCEDURE LIST_BLD_AMT_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_BLD_AMT_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID                  IN  FI_BLD_AMT_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE                IN  FI_BLD_AMT_SPEC.TAX_CODE%TYPE              --�������̵�(��>42)    
    , W_VAT_MNG_SERIAL          IN  FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE        --�ΰ����Ű�Ⱓ���й�ȣ
);







--grid�� ��ȸ�Ǵ� �ڷ� �� �ݾ��ڷ�鿡 ���� �հ�
PROCEDURE SUM_BLD_AMT_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_BLD_AMT_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID                  IN  FI_BLD_AMT_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE                IN  FI_BLD_AMT_SPEC.TAX_CODE%TYPE              --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL          IN  FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE        --�ΰ����Ű�Ⱓ���й�ȣ
);






--�Ӵ�Ⱓ�� ����������(�����Ӵ��), �Ӵ�Ⱓ_�Ӵ��, �Ӵ�Ⱓ_������ ���ؼ� �ѱ�.
PROCEDURE SET_TERM_AMT(
      W_IN_DATE     IN  FI_BLD_AMT_SPEC.IN_DATE%TYPE        --������
    , W_OUT_DATE    IN  FI_BLD_AMT_SPEC.OUT_DATE%TYPE       --�����
    , W_DEPOSIT     IN  FI_BLD_AMT_SPEC.DEPOSIT%TYPE        --������
    , W_MONTH_RENT  IN  FI_BLD_AMT_SPEC.MONTH_RENT%TYPE     --���Ӵ��
    , W_MONTN_FEE   IN  FI_BLD_AMT_SPEC.MONTN_FEE%TYPE      --��������
    , W_REGARD_RATE IN  FI_VAT_REPORT_MNG.REGARD_RATE%TYPE  --�����Ӵ������������
    
    , O_DEEMED_RENT OUT FI_BLD_AMT_SPEC.DEEMED_RENT%TYPE    --����������_�����Ӵ��
    , O_TERM_RENT   OUT FI_BLD_AMT_SPEC.TERM_RENT%TYPE      --�Ӵ�Ⱓ_�Ӵ��
    , O_TERM_FEE    OUT FI_BLD_AMT_SPEC.TERM_FEE%TYPE       --�Ӵ�Ⱓ_������
);










--grid�� �ű� �׸� �߰�
PROCEDURE INSERT_BLD_AMT_SPEC(
      P_SOB_ID	            IN 	FI_BLD_AMT_SPEC.SOB_ID%TYPE	            --ȸ����̵�
    , P_ORG_ID	            IN 	FI_BLD_AMT_SPEC.ORG_ID%TYPE	            --����ξ��̵�
    , P_TAX_CODE          	IN 	FI_BLD_AMT_SPEC.TAX_CODE%TYPE           --�������̵�
    , P_VAT_MNG_SERIAL	    IN 	FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE     --�ΰ����Ű�Ⱓ���й�ȣ
    , P_REAL_ESTATE_LOC	    IN 	FI_BLD_AMT_SPEC.REAL_ESTATE_LOC%TYPE    --�ε�����ġ
    , P_ADDRESS	            IN 	FI_BLD_AMT_SPEC.ADDRESS%TYPE            --��
    , P_VAT_GROUND_YN	      IN 	FI_BLD_AMT_SPEC.VAT_GROUND_YN%TYPE      --����_���Ͽ���
    , P_BLD_FLOOR	          IN 	FI_BLD_AMT_SPEC.BLD_FLOOR%TYPE          --��
    , P_ROOM	              IN 	FI_BLD_AMT_SPEC.ROOM%TYPE               --ȣ
    , P_LEND_AREA	          IN 	FI_BLD_AMT_SPEC.LEND_AREA%TYPE          --�Ӵ����
    , P_PURPOSE	            IN 	FI_BLD_AMT_SPEC.PURPOSE%TYPE            --�뵵
    , P_CORP_NAME	          IN 	FI_BLD_AMT_SPEC.CORP_NAME%TYPE          --��ü ��ȣ
    , P_VAT_NUMBER	        IN 	FI_BLD_AMT_SPEC.VAT_NUMBER%TYPE         --����ڵ�Ϲ�ȣ
    , P_IN_DATE	            IN 	FI_BLD_AMT_SPEC.IN_DATE%TYPE            --������
    , P_MODIFY_DATE	        IN 	FI_BLD_AMT_SPEC.MODIFY_DATE%TYPE        --������
    , P_OUT_DATE	          IN 	FI_BLD_AMT_SPEC.OUT_DATE%TYPE           --�����
    , P_DEPOSIT	            IN 	FI_BLD_AMT_SPEC.DEPOSIT%TYPE            --������
    , P_MONTH_RENT	        IN 	FI_BLD_AMT_SPEC.MONTH_RENT%TYPE         --���Ӵ��
    , P_MONTN_FEE	          IN 	FI_BLD_AMT_SPEC.MONTN_FEE%TYPE          --��������
    , P_DEEMED_RENT	        IN 	FI_BLD_AMT_SPEC.DEEMED_RENT%TYPE        --����������_�����Ӵ��
    , P_TERM_RENT	          IN 	FI_BLD_AMT_SPEC.TERM_RENT%TYPE          --�Ӵ�Ⱓ_�Ӵ��
    , P_TERM_FEE	          IN 	FI_BLD_AMT_SPEC.TERM_FEE%TYPE           --�Ӵ�Ⱓ_������    
    , P_CREATED_BY	        IN	FI_BLD_AMT_SPEC.CREATED_BY%TYPE	        --������
);





--grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_BLD_AMT_SPEC(
      W_SOB_ID	            IN 	FI_BLD_AMT_SPEC.SOB_ID%TYPE	            --ȸ����̵�
    , W_ORG_ID	            IN 	FI_BLD_AMT_SPEC.ORG_ID%TYPE	            --����ξ��̵�
    , W_TAX_CODE 	          IN  FI_BLD_AMT_SPEC.TAX_CODE%TYPE           --�������̵�
    , W_VAT_MNG_SERIAL	    IN 	FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE     --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL	        IN 	FI_BLD_AMT_SPEC.SPEC_SERIAL%TYPE        --�Ϸù�ȣ
    , P_REAL_ESTATE_LOC	    IN 	FI_BLD_AMT_SPEC.REAL_ESTATE_LOC%TYPE    --�ε�����ġ
    , P_ADDRESS	            IN 	FI_BLD_AMT_SPEC.ADDRESS%TYPE            --��
    , P_VAT_GROUND_YN	      IN 	FI_BLD_AMT_SPEC.VAT_GROUND_YN%TYPE      --����_���Ͽ���
    , P_BLD_FLOOR	          IN 	FI_BLD_AMT_SPEC.BLD_FLOOR%TYPE          --��
    , P_ROOM	              IN 	FI_BLD_AMT_SPEC.ROOM%TYPE               --ȣ
    , P_LEND_AREA	          IN 	FI_BLD_AMT_SPEC.LEND_AREA%TYPE          --�Ӵ����
    , P_PURPOSE	            IN 	FI_BLD_AMT_SPEC.PURPOSE%TYPE            --�뵵
    , P_CORP_NAME	          IN 	FI_BLD_AMT_SPEC.CORP_NAME%TYPE          --��ü ��ȣ
    , P_VAT_NUMBER	        IN 	FI_BLD_AMT_SPEC.VAT_NUMBER%TYPE         --����ڵ�Ϲ�ȣ
    , P_IN_DATE	            IN 	FI_BLD_AMT_SPEC.IN_DATE%TYPE            --������
    , P_MODIFY_DATE	        IN 	FI_BLD_AMT_SPEC.MODIFY_DATE%TYPE        --������
    , P_OUT_DATE	          IN 	FI_BLD_AMT_SPEC.OUT_DATE%TYPE           --�����
    , P_DEPOSIT	            IN 	FI_BLD_AMT_SPEC.DEPOSIT%TYPE            --������
    , P_MONTH_RENT	        IN 	FI_BLD_AMT_SPEC.MONTH_RENT%TYPE         --���Ӵ��
    , P_MONTN_FEE	          IN 	FI_BLD_AMT_SPEC.MONTN_FEE%TYPE          --��������
    , P_DEEMED_RENT	        IN 	FI_BLD_AMT_SPEC.DEEMED_RENT%TYPE        --����������_�����Ӵ��
    , P_TERM_RENT	          IN 	FI_BLD_AMT_SPEC.TERM_RENT%TYPE          --�Ӵ�Ⱓ_�Ӵ��
    , P_TERM_FEE	          IN 	FI_BLD_AMT_SPEC.TERM_FEE%TYPE           --�Ӵ�Ⱓ_������    
    , P_LAST_UPDATED_BY     IN  FI_BLD_AMT_SPEC.LAST_UPDATED_BY%TYPE    --������
);






--grid�� ��ȸ�� �ڷ� ����
PROCEDURE DELETE_BLD_AMT_SPEC(
      W_SOB_ID	            IN 	FI_BLD_AMT_SPEC.SOB_ID%TYPE	            --ȸ����̵�
    , W_ORG_ID	            IN 	FI_BLD_AMT_SPEC.ORG_ID%TYPE	            --����ξ��̵�
    , W_TAX_CODE	          IN 	FI_BLD_AMT_SPEC.TAX_CODE%TYPE           --�������̵�
    , W_VAT_MNG_SERIAL	    IN 	FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE     --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL	        IN 	FI_BLD_AMT_SPEC.SPEC_SERIAL%TYPE        --�Ϸù�ȣ
);






--�ε����Ӵ���ް��׸��� ��� ��¿�
PROCEDURE PRINT_BLD_AMT_SPEC(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID              IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE            IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --�������̵�(��>42)     
    
    --�Ʒ� �׸��� ��½� �ʼ��׸��̴�.
    , W_TAX_DATE_FR         IN  VARCHAR2    --�����Ⱓ_����
    , W_TAX_DATE_TO         IN  VARCHAR2    --�����Ⱓ_����
);





END FI_BLD_AMT_SPEC_G;
/
CREATE OR REPLACE PACKAGE BODY FI_BLD_AMT_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_BLD_AMT_SPEC_G
Description  : �ε����Ӵ���ް��׸��� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (�ε����Ӵ���ް��׸���)
Program History :
    -.����>�� �ڷ�� �۾��ڰ� �ΰ���ġ���Ű�� �����Ͽ� ���� �Է��ϴ� �ڷ�� ��ǥ�ʹ� �����Ѵ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-16   Leem Dong Ern(�ӵ���)
*****************************************************************************/






--grid�� ��ȸ�Ǵ� �ڷ� ����
PROCEDURE LIST_BLD_AMT_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_BLD_AMT_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID                  IN  FI_BLD_AMT_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE                IN  FI_BLD_AMT_SPEC.TAX_CODE%TYPE              --�������̵�(��>42)    
    , W_VAT_MNG_SERIAL          IN  FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE        --�ΰ����Ű�Ⱓ���й�ȣ
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�
        , TAX_CODE      	--�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű�Ⱓ���й�ȣ
        , FI_VAT_REPORT_MNG_G.VAT_MNG_SERIAL_F(VAT_MNG_SERIAL) AS VAT_REPORT_NM   --�Ű�Ⱓ���и�
        , SPEC_SERIAL	    --�Ϸù�ȣ
        
        --�Ӵ����
        , ADDRESS	        --��
        , REAL_ESTATE_LOC	--�ε�����ġ    
        , VAT_GROUND_YN	    --����_���Ͽ����ڵ�
        , FI_COMMON_G.CODE_NAME_F('VAT_GROUND_YN', VAT_GROUND_YN, SOB_ID, ORG_ID) AS VAT_GROUND_YN_NM     --����_���Ͽ���
        , BLD_FLOOR	--��
        , ROOM	    --ȣ
        , BLD_FLOOR || '��' AS PRINT_BLD_FLOOR   --��
        , ROOM || 'ȣ' AS PRINT_ROOM             --ȣ        
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
    ORDER BY SPEC_SERIAL    ; 


END LIST_BLD_AMT_SPEC;






--grid�� ��ȸ�Ǵ� �ڷ� �� �ݾ��ڷ�鿡 ���� �հ�
PROCEDURE SUM_BLD_AMT_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_BLD_AMT_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID                  IN  FI_BLD_AMT_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE                IN  FI_BLD_AMT_SPEC.TAX_CODE%TYPE              --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL          IN  FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE        --�ΰ����Ű�Ⱓ���й�ȣ
)

AS

BEGIN

    OPEN P_CURSOR FOR

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
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   ;


END SUM_BLD_AMT_SPEC;







--�Ӵ�Ⱓ�� ����������(�����Ӵ��), �Ӵ�Ⱓ_�Ӵ��, �Ӵ�Ⱓ_������ ���ؼ� �ѱ�.
PROCEDURE SET_TERM_AMT(
      W_IN_DATE     IN  FI_BLD_AMT_SPEC.IN_DATE%TYPE        --������
    , W_OUT_DATE    IN  FI_BLD_AMT_SPEC.OUT_DATE%TYPE       --�����
    , W_DEPOSIT     IN  FI_BLD_AMT_SPEC.DEPOSIT%TYPE        --������
    , W_MONTH_RENT  IN  FI_BLD_AMT_SPEC.MONTH_RENT%TYPE     --���Ӵ��
    , W_MONTN_FEE   IN  FI_BLD_AMT_SPEC.MONTN_FEE%TYPE      --��������
    , W_REGARD_RATE IN  FI_VAT_REPORT_MNG.REGARD_RATE%TYPE  --�����Ӵ������������
    
    , O_DEEMED_RENT OUT FI_BLD_AMT_SPEC.DEEMED_RENT%TYPE    --����������_�����Ӵ��
    , O_TERM_RENT   OUT FI_BLD_AMT_SPEC.TERM_RENT%TYPE      --�Ӵ�Ⱓ_�Ӵ��
    , O_TERM_FEE    OUT FI_BLD_AMT_SPEC.TERM_FEE%TYPE       --�Ӵ�Ⱓ_������
)

AS
    V_YEAR_DAY          NUMBER := 0;  -- ���ϼ�.
BEGIN
    BEGIN
      V_YEAR_DAY := HRM_COMMON_DATE_G.PERIOD_DAY_F(TRUNC(W_IN_DATE, 'YEAR'), LAST_DAY(TO_DATE(TO_CHAR(W_IN_DATE, 'YYYY') || '-12-31', 'YYYY-MM-DD')), 1);
    EXCEPTION WHEN OTHERS THEN
      V_YEAR_DAY                := 365;
    END;
    
    SELECT     
        --  W_IN_DATE AS IN_DATE	    --�Ӵ�Ⱓ_������
        --, W_OUT_DATE AS OUT_DATE	    --�Ӵ�Ⱓ_�����
        --, TRUNC(W_OUT_DATE - W_IN_DATE) + 1 AS DATE_TERM    --2��¥ ������ ���� ��
        --, TRUNC(MONTHS_BETWEEN(W_OUT_DATE + 1, W_IN_DATE)) AS MM_TERM   --2��¥ ������ ���� ��
        
        --, W_DEPOSIT AS DEPOSIT	    --������
        --, W_MONTH_RENT AS MONTH_RENT	--����
        --, W_MONTN_FEE  AS MONTN_FEE	    --��������
        
        --�Ӵ����Աݾ�(����ǥ��)
          TRUNC(W_DEPOSIT * (W_REGARD_RATE / 100) * ( (TRUNC(W_OUT_DATE - W_IN_DATE) + 1) / V_YEAR_DAY ))  AS DEEMED_RENT	--����������(�����Ӵ��)
        , W_MONTH_RENT * TRUNC(MONTHS_BETWEEN(W_OUT_DATE + 1, W_IN_DATE)) AS TERM_RENT	    --�Ӵ�Ⱓ_�Ӵ��
        , W_MONTN_FEE * TRUNC(MONTHS_BETWEEN(W_OUT_DATE + 1, W_IN_DATE)) AS TERM_FEE	    --�Ӵ�Ⱓ_������
    INTO O_DEEMED_RENT, O_TERM_RENT, O_TERM_FEE
    FROM DUAL
    ; 

END SET_TERM_AMT;







--grid�� �ű� �׸� �߰�
PROCEDURE INSERT_BLD_AMT_SPEC(
      P_SOB_ID	            IN 	FI_BLD_AMT_SPEC.SOB_ID%TYPE	            --ȸ����̵�
    , P_ORG_ID	            IN 	FI_BLD_AMT_SPEC.ORG_ID%TYPE	            --����ξ��̵�
    , P_TAX_CODE          	IN 	FI_BLD_AMT_SPEC.TAX_CODE%TYPE           --�������̵�
    , P_VAT_MNG_SERIAL	    IN 	FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE     --�ΰ����Ű�Ⱓ���й�ȣ
    , P_REAL_ESTATE_LOC	    IN 	FI_BLD_AMT_SPEC.REAL_ESTATE_LOC%TYPE    --�ε�����ġ
    , P_ADDRESS	            IN 	FI_BLD_AMT_SPEC.ADDRESS%TYPE            --��
    , P_VAT_GROUND_YN	      IN 	FI_BLD_AMT_SPEC.VAT_GROUND_YN%TYPE      --����_���Ͽ���
    , P_BLD_FLOOR	          IN 	FI_BLD_AMT_SPEC.BLD_FLOOR%TYPE          --��
    , P_ROOM	              IN 	FI_BLD_AMT_SPEC.ROOM%TYPE               --ȣ
    , P_LEND_AREA	          IN 	FI_BLD_AMT_SPEC.LEND_AREA%TYPE          --�Ӵ����
    , P_PURPOSE	            IN 	FI_BLD_AMT_SPEC.PURPOSE%TYPE            --�뵵
    , P_CORP_NAME	          IN 	FI_BLD_AMT_SPEC.CORP_NAME%TYPE          --��ü ��ȣ
    , P_VAT_NUMBER	        IN 	FI_BLD_AMT_SPEC.VAT_NUMBER%TYPE         --����ڵ�Ϲ�ȣ
    , P_IN_DATE	            IN 	FI_BLD_AMT_SPEC.IN_DATE%TYPE            --������
    , P_MODIFY_DATE	        IN 	FI_BLD_AMT_SPEC.MODIFY_DATE%TYPE        --������
    , P_OUT_DATE	          IN 	FI_BLD_AMT_SPEC.OUT_DATE%TYPE           --�����
    , P_DEPOSIT	            IN 	FI_BLD_AMT_SPEC.DEPOSIT%TYPE            --������
    , P_MONTH_RENT	        IN 	FI_BLD_AMT_SPEC.MONTH_RENT%TYPE         --���Ӵ��
    , P_MONTN_FEE	          IN 	FI_BLD_AMT_SPEC.MONTN_FEE%TYPE          --��������
    , P_DEEMED_RENT	        IN 	FI_BLD_AMT_SPEC.DEEMED_RENT%TYPE        --����������_�����Ӵ��
    , P_TERM_RENT	          IN 	FI_BLD_AMT_SPEC.TERM_RENT%TYPE          --�Ӵ�Ⱓ_�Ӵ��
    , P_TERM_FEE	          IN 	FI_BLD_AMT_SPEC.TERM_FEE%TYPE           --�Ӵ�Ⱓ_������    
    , P_CREATED_BY	        IN	FI_BLD_AMT_SPEC.CREATED_BY%TYPE	        --������
)

AS

V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
t_SPEC_SERIAL   FI_BLD_AMT_SPEC.SPEC_SERIAL%TYPE;

BEGIN

    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO t_SPEC_SERIAL FROM FI_BLD_AMT_SPEC;   --�Ϸù�ȣ

    INSERT INTO FI_BLD_AMT_SPEC(
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�
        , TAX_CODE	      --�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű�Ⱓ���й�ȣ
        , SPEC_SERIAL	    --�Ϸù�ȣ
        , REAL_ESTATE_LOC	--�ε�����ġ
        , ADDRESS	        --��
        , VAT_GROUND_YN	    --����_���Ͽ���
        , BLD_FLOOR	        --��
        , ROOM	            --ȣ
        , LEND_AREA	        --�Ӵ����
        , PURPOSE	        --�뵵
        , CORP_NAME	        --��ü ��ȣ
        , VAT_NUMBER	    --����ڵ�Ϲ�ȣ
        , IN_DATE	        --������
        , MODIFY_DATE	    --������
        , OUT_DATE	        --�����
        , DEPOSIT	        --������
        , MONTH_RENT	    --���Ӵ��
        , MONTN_FEE	        --��������
        , DEEMED_RENT	    --����������_�����Ӵ��
        , TERM_RENT	        --�Ӵ�Ⱓ_�Ӵ��
        , TERM_FEE	        --�Ӵ�Ⱓ_������
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
        , P_REAL_ESTATE_LOC	    --�ε�����ġ
        , P_ADDRESS	            --��
        , P_VAT_GROUND_YN	    --����_���Ͽ���
        , P_BLD_FLOOR	        --��
        , P_ROOM	            --ȣ
        , P_LEND_AREA	        --�Ӵ����
        , P_PURPOSE	            --�뵵
        , P_CORP_NAME	        --��ü ��ȣ
        , P_VAT_NUMBER	        --����ڵ�Ϲ�ȣ
        , P_IN_DATE	            --������
        , P_MODIFY_DATE	        --������
        , P_OUT_DATE	        --�����
        , P_DEPOSIT	            --������
        , P_MONTH_RENT	        --���Ӵ��
        , P_MONTN_FEE	        --��������
        , P_DEEMED_RENT	        --����������_�����Ӵ��
        , P_TERM_RENT	        --�Ӵ�Ⱓ_�Ӵ��
        , P_TERM_FEE	        --�Ӵ�Ⱓ_������        
        , V_SYSDATE             --������
        , P_CREATED_BY	        --������
        , V_SYSDATE             --������
        , P_CREATED_BY	        --������
    );

END INSERT_BLD_AMT_SPEC;







--grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_BLD_AMT_SPEC(
      W_SOB_ID	            IN 	FI_BLD_AMT_SPEC.SOB_ID%TYPE	            --ȸ����̵�
    , W_ORG_ID	            IN 	FI_BLD_AMT_SPEC.ORG_ID%TYPE	            --����ξ��̵�
    , W_TAX_CODE 	          IN  FI_BLD_AMT_SPEC.TAX_CODE%TYPE           --�������̵�
    , W_VAT_MNG_SERIAL	    IN 	FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE     --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL	        IN 	FI_BLD_AMT_SPEC.SPEC_SERIAL%TYPE        --�Ϸù�ȣ
    , P_REAL_ESTATE_LOC	    IN 	FI_BLD_AMT_SPEC.REAL_ESTATE_LOC%TYPE    --�ε�����ġ
    , P_ADDRESS	            IN 	FI_BLD_AMT_SPEC.ADDRESS%TYPE            --��
    , P_VAT_GROUND_YN	      IN 	FI_BLD_AMT_SPEC.VAT_GROUND_YN%TYPE      --����_���Ͽ���
    , P_BLD_FLOOR	          IN 	FI_BLD_AMT_SPEC.BLD_FLOOR%TYPE          --��
    , P_ROOM	              IN 	FI_BLD_AMT_SPEC.ROOM%TYPE               --ȣ
    , P_LEND_AREA	          IN 	FI_BLD_AMT_SPEC.LEND_AREA%TYPE          --�Ӵ����
    , P_PURPOSE	            IN 	FI_BLD_AMT_SPEC.PURPOSE%TYPE            --�뵵
    , P_CORP_NAME	          IN 	FI_BLD_AMT_SPEC.CORP_NAME%TYPE          --��ü ��ȣ
    , P_VAT_NUMBER	        IN 	FI_BLD_AMT_SPEC.VAT_NUMBER%TYPE         --����ڵ�Ϲ�ȣ
    , P_IN_DATE	            IN 	FI_BLD_AMT_SPEC.IN_DATE%TYPE            --������
    , P_MODIFY_DATE	        IN 	FI_BLD_AMT_SPEC.MODIFY_DATE%TYPE        --������
    , P_OUT_DATE	          IN 	FI_BLD_AMT_SPEC.OUT_DATE%TYPE           --�����
    , P_DEPOSIT	            IN 	FI_BLD_AMT_SPEC.DEPOSIT%TYPE            --������
    , P_MONTH_RENT	        IN 	FI_BLD_AMT_SPEC.MONTH_RENT%TYPE         --���Ӵ��
    , P_MONTN_FEE	          IN 	FI_BLD_AMT_SPEC.MONTN_FEE%TYPE          --��������
    , P_DEEMED_RENT	        IN 	FI_BLD_AMT_SPEC.DEEMED_RENT%TYPE        --����������_�����Ӵ��
    , P_TERM_RENT	          IN 	FI_BLD_AMT_SPEC.TERM_RENT%TYPE          --�Ӵ�Ⱓ_�Ӵ��
    , P_TERM_FEE	          IN 	FI_BLD_AMT_SPEC.TERM_FEE%TYPE           --�Ӵ�Ⱓ_������    
    , P_LAST_UPDATED_BY     IN  FI_BLD_AMT_SPEC.LAST_UPDATED_BY%TYPE    --������
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);

BEGIN

    UPDATE FI_BLD_AMT_SPEC
    SET
          REAL_ESTATE_LOC   = P_REAL_ESTATE_LOC --�ε�����ġ    
        , ADDRESS	        = P_ADDRESS	        --��    
        , VAT_GROUND_YN	    = P_VAT_GROUND_YN	--����_���Ͽ���    
        , BLD_FLOOR	        = P_BLD_FLOOR	    --��    
        , ROOM              = P_ROOM	        --ȣ    
        , LEND_AREA	        = P_LEND_AREA	    --�Ӵ����    
        , PURPOSE           = P_PURPOSE         --�뵵    
        , CORP_NAME	        = P_CORP_NAME	    --��ȣ    
        , VAT_NUMBER	    = P_VAT_NUMBER      --����ڵ�Ϲ�ȣ
        , IN_DATE           = P_IN_DATE	        --������        
        , MODIFY_DATE	    = P_MODIFY_DATE	    --������    
        , OUT_DATE	        = P_OUT_DATE	    --�����    
        , DEPOSIT           = P_DEPOSIT	        --������    
        , MONTH_RENT	    = P_MONTH_RENT	    --���Ӵ��    
        , MONTN_FEE         = P_MONTN_FEE       --��������    
        , DEEMED_RENT	    = P_DEEMED_RENT	    --����������_�����Ӵ��    
        , TERM_RENT	        = P_TERM_RENT       --�Ӵ�Ⱓ_�Ӵ��
        , TERM_FEE          = P_TERM_FEE	    --�Ӵ�Ⱓ_������                
        , LAST_UPDATE_DATE  = V_SYSDATE         --������
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY --������
    WHERE   SOB_ID                  = W_SOB_ID                  --ȸ����̵�
        AND ORG_ID                  = W_ORG_ID                  --����ξ��̵�
        AND TAX_CODE                = W_TAX_CODE                --�������̵�        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --�ΰ����Ű�Ⱓ���й�ȣ               
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --�Ϸù�ȣ
    ;

END UPDATE_BLD_AMT_SPEC;





--grid�� ��ȸ�� �ڷ� ����
PROCEDURE DELETE_BLD_AMT_SPEC(
      W_SOB_ID	            IN 	FI_BLD_AMT_SPEC.SOB_ID%TYPE	            --ȸ����̵�
    , W_ORG_ID	            IN 	FI_BLD_AMT_SPEC.ORG_ID%TYPE	            --����ξ��̵�
    , W_TAX_CODE	          IN 	FI_BLD_AMT_SPEC.TAX_CODE%TYPE           --�������̵�
    , W_VAT_MNG_SERIAL	    IN 	FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE     --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL	        IN 	FI_BLD_AMT_SPEC.SPEC_SERIAL%TYPE        --�Ϸù�ȣ
)

AS

BEGIN

    DELETE FI_BLD_AMT_SPEC
    WHERE   SOB_ID                  = W_SOB_ID                  --ȸ����̵�
        AND ORG_ID                  = W_ORG_ID                  --����ξ��̵�
        AND TAX_CODE                = W_TAX_CODE                --�������̵�        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --�ΰ����Ű�Ⱓ���й�ȣ               
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --�Ϸù�ȣ
    ;

END DELETE_BLD_AMT_SPEC;







--�ε����Ӵ���ް��׸��� ��� ��¿�
PROCEDURE PRINT_BLD_AMT_SPEC(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID              IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE            IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --�������̵�(��>42)     
    
    --�Ʒ� �׸��� ��½� �ʼ��׸��̴�.
    , W_TAX_DATE_FR         IN  VARCHAR2    --�����Ⱓ_����
    , W_TAX_DATE_TO         IN  VARCHAR2    --�����Ⱓ_����
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
        , LTRIM(SUBSTR(W_TAX_DATE_FR, 6, 2), '0') || ' ��  ~  ' || LTRIM(SUBSTR(W_TAX_DATE_TO, 6, 2), '0') || ' ��' AS TAX_TERM    --�����Ⱓ
        , '(   ' || SUBSTR(W_TAX_DATE_TO, 1, 4) || '  ��   ' ||  
          CASE
            WHEN LTRIM(SUBSTR(W_TAX_DATE_TO, 6, 2), '0') <= 6 THEN '1  ��   '
            ELSE '2  ��   '
          END
          ||
          CASE
            WHEN LTRIM(SUBSTR(W_TAX_DATE_TO, 6, 2), '0') <=  3 THEN '����   )'
            WHEN LTRIM(SUBSTR(W_TAX_DATE_TO, 6, 2), '0') <=  6 THEN 'Ȯ��   )'
            WHEN LTRIM(SUBSTR(W_TAX_DATE_TO, 6, 2), '0') <=  9 THEN '����   )'
            WHEN LTRIM(SUBSTR(W_TAX_DATE_TO, 6, 2), '0') <= 12 THEN 'Ȯ��   )'            
          END          
          AS FISCAL_YEAR   --�ΰ���ġ���Ű���
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
        OR   ROWNUM                 <= 1)
        ;
END PRINT_BLD_AMT_SPEC;






END FI_BLD_AMT_SPEC_G;
/
