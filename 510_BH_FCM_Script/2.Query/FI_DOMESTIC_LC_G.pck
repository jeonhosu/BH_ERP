CREATE OR REPLACE PACKAGE FI_DOMESTIC_LC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_DOMESTIC_LC_G(�����ſ��� ����Ȯ�μ� ���ڹ߱޸���)
Description  : �����ſ��� ����Ȯ�μ� ���ڹ߱޸��� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : �����ſ��� ����Ȯ�μ� ���ڹ߱޸���
Program History :
    *.����/�������� ���������� ���������� �ڷᰡ ���� �ڷ��̴�.
    *.������ �����ڵ忡 �ִ� ���� �̿��Ѵ�. VAT_DOMESTIC_LC[���ڹ߱޸���(�����ſ���)]
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2012-01-02   Leem Dong Ern(�ӵ���)
*****************************************************************************/





--�����ڷ����
--�޽��� : �����ڷḦ �����Ͻðڽ��ϱ�? �� ������ �ڷᰡ �ִ� ��� ���� �ڷᰡ �����ǰ� (��)�����˴ϴ�.
--FCM_10368, �����, �����⵵, �Ű�Ⱓ����, �ۼ�����, �ŷ��Ⱓ�� �ʼ��Դϴ�.
--FCM_10365, �ش� �Ű�Ⱓ�� �ڷ�� �����Ǿ� ������ �� �����ϴ�.
PROCEDURE CREATE_DOMESTIC_LC(
      W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE            --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    , W_CREATED_BY          IN  FI_DOMESTIC_LC.CREATED_BY%TYPE          --������
    , W_DEAL_DATE_FR        IN  DATE    --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�ŷ��Ⱓ_����    
    
    , O_MESSAGE             OUT VARCHAR2
);






--�����ȸ
PROCEDURE LIST_UP_DOMESTIC_LC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE            --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
);






--�ϴ���ȸ
PROCEDURE LIST_DOWN_DOMESTIC_LC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE            --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
);






--���� POPUP
PROCEDURE POPUP_DOMESTIC_LC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --����ξ��̵�
);








--grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_DOMESTIC_LC(
      W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE           --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE     --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL         IN  FI_DOMESTIC_LC.SPEC_SERIAL%TYPE        --�Ϸù�ȣ
    
    , P_VAT_DOMESTIC_LC_CD  IN  FI_DOMESTIC_LC.VAT_DOMESTIC_LC_CD%TYPE  --����
    , P_DOC_NO              IN  FI_DOMESTIC_LC.DOC_NO%TYPE              --������ȣ
    
    , P_LAST_UPDATED_BY     IN  FI_DOMESTIC_LC.LAST_UPDATED_BY%TYPE    --������
);




--grid�� ��ȸ�� �ڷ� DELETE
PROCEDURE DELETE_DOMESTIC_LC(
      W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE           --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE     --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL         IN  FI_DOMESTIC_LC.SPEC_SERIAL%TYPE        --�Ϸù�ȣ
);







--�޼��� : �����, �����⵵, �Ű�Ⱓ����, �ۼ�����, �ŷ��Ⱓ�� �ʼ��Դϴ�.(FCM_10368)
--         ����� �ڷᰡ �����ϴ�.(FCM_10439)
--���ڼ��ݰ�꼭_�߱ݼ��װ����Ű� ��¿�
PROCEDURE PRINT_DOMESTIC_LC(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  NUMBER  --ȸ����̵�
    , W_ORG_ID          IN  NUMBER  --����ξ��̵� 
    , W_TAX_CODE        IN  VARCHAR2
    , W_CREATE_DATE     IN  DATE    --�ۼ����� 
    , W_DEAL_DATE_FR    IN  DATE    --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO    IN  DATE    --�ŷ��Ⱓ_����    
);





END FI_DOMESTIC_LC_G;
/
CREATE OR REPLACE PACKAGE BODY FI_DOMESTIC_LC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_DOMESTIC_LC_G(�����ſ��� ����Ȯ�μ� ���ڹ߱޸���)
Description  : �����ſ��� ����Ȯ�μ� ���ڹ߱޸��� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : �����ſ��� ����Ȯ�μ� ���ڹ߱޸���
Program History :
    *.����/�������� ���������� ���������� �ڷᰡ ���� �ڷ��̴�.
    *.������ �����ڵ忡 �ִ� ���� �̿��Ѵ�. VAT_DOMESTIC_LC[���ڹ߱޸���(�����ſ���)]
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2012-01-02   Leem Dong Ern(�ӵ���)
*****************************************************************************/






--�����ڷ����
--�޽��� : �����ڷḦ �����Ͻðڽ��ϱ�? �� ������ �ڷᰡ �ִ� ��� ���� �ڷᰡ �����ǰ� (��)�����˴ϴ�.
--FCM_10368, �����, �����⵵, �Ű�Ⱓ����, �ۼ�����, �ŷ��Ⱓ�� �ʼ��Դϴ�.
--FCM_10365, �ش� �Ű�Ⱓ�� �ڷ�� �����Ǿ� ������ �� �����ϴ�.
PROCEDURE CREATE_DOMESTIC_LC(
      W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE   --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    , W_CREATED_BY          IN  FI_DOMESTIC_LC.CREATED_BY%TYPE          --������
    , W_DEAL_DATE_FR        IN  DATE    --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�ŷ��Ⱓ_����  
    
    , O_MESSAGE             OUT VARCHAR2    
)

AS

REC_CLOSING_YN  EXCEPTION;

t_CLOSING_YN    FI_VAT_REPORT_MNG.CLOSING_YN%TYPE;  --��������
V_SYSDATE       DATE := GET_LOCAL_DATE(W_SOB_ID);

t_SPEC_SERIAL   FI_FOREIGN_CURRENCY_SPEC.SPEC_SERIAL%TYPE;  --�Ϸù�ȣ

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

        RAISE REC_CLOSING_YN;
        
        --RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10365', NULL));
    END IF;



    --������ �����ϴ� �ڷᰡ ���� ��� ��� �����Ѵ�.
    DELETE FI_DOMESTIC_LC
    WHERE   SOB_ID  = W_SOB_ID  --ȸ����̵�
        AND ORG_ID  = W_ORG_ID  --����ξ��̵�
        AND TAX_CODE = W_TAX_CODE                   --�������̵�
        AND VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL    --�ΰ����Ű�Ⱓ���й�ȣ
    ;    

    SELECT NVL(MAX(SPEC_SERIAL), 0) INTO t_SPEC_SERIAL FROM FI_DOMESTIC_LC;

    INSERT INTO FI_DOMESTIC_LC(
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�        
        , TAX_CODE       	--�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű�Ⱓ���й�ȣ
        
        , SPEC_SERIAL           --�Ϸù�ȣ
        , VAT_DOMESTIC_LC_CD    --����
        , DOC_NO                --������ȣ
        , PUB_DATE              --�߱���
        , VAT_NUMBER            --����ڵ�Ϲ�ȣ
        , SUPPLY_AMT            --�ݾ�
      
        , CREATION_DATE     --������
        , CREATED_BY	    --������
        , LAST_UPDATE_DATE  --������
        , LAST_UPDATED_BY	--������          
    )
    --�Ʒ� SELECT ���� ����/�������� ����κп� �����Ͽ� �� ������ �°� �Ϻ� ������ ���̴�.
    SELECT                     
          W_SOB_ID  --ȸ����̵�
        , W_ORG_ID  --����ξ��̵�
        , W_TAX_CODE                --�������̵�
        , W_VAT_MNG_SERIAL          --�ΰ����Ű�Ⱓ���й�ȣ
        
        , t_SPEC_SERIAL + ROWNUM        --�Ϸù�ȣ
        , '02' AS VAT_DOMESTIC_LC_CD    --����(01 : �����ſ���, 02:����Ȯ�μ�)
        , NULL AS DOC_NO                --������ȣ
        , A.REFER1 AS VAT_ISSUE_DATE    --�Ű��������     
        , B.TAX_REG_NO AS TAX_REG_NO    --����ڵ�Ϲ�ȣ

        --�Ʒ����� TRIM, REPLACE�� �� ������ ���� ���α׷��� ���ռ� ������ �ȵǾ� �ڷᰡ �� �� �ԷµȰ� �־�̴�.
        , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', '')) AS GL_AMOUNT     --���ް��� 
        
        , V_SYSDATE     --������
        , W_CREATED_BY  --������
        , V_SYSDATE     --������
        , W_CREATED_BY  --������     
    FROM FI_SLIP_LINE A
        , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --�ŷ�ó
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        AND A.REFER11 = W_TAX_CODE      --�����    
        AND A.ACCOUNT_CODE = '2100700'  --�ŷ�����(����)
        AND MANAGEMENT2 = 2 --��������(2:��������)    
        --AND TO_DATE(A.REFER1) BETWEEN to_date('20110401') AND to_date('20110630')   --�Ű��������
        AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
        AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)        
    ;
     
    
    --FCM_10112 : �ش� �۾��� ���������� �Ϸ��Ͽ����ϴ�.
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
    
        
    EXCEPTION 
        WHEN REC_CLOSING_YN THEN
    
            --FCM_10365, �ش� �Ű�Ⱓ�� �ڷ�� �����Ǿ� ������ �� �����ϴ�.
            O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10365', NULL);     

        WHEN OTHERS THEN
            ROLLBACK;
            
            O_MESSAGE := 'ERROR : ' || SQLCODE ||  ' => ' || SQLERRM;
            --DBMS_OUTPUT.PUT_LINE('------ �������ڵ尪�� ���� message : ' || SQLERRM);           

END CREATE_DOMESTIC_LC;









--�����ȸ
PROCEDURE LIST_UP_DOMESTIC_LC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE            --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          '(9) �հ� (10)+(11)'    AS GUBUN    --����
        , DECODE(COUNT(*), 0, NULL, COUNT(*)) AS CNT   --�Ǽ�
        , SUM(SUPPLY_AMT) AS TOTAL    --�ݾ�(��)
    FROM FI_DOMESTIC_LC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE               --�������̵�
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --�ΰ����Ű�Ⱓ���й�ȣ

    UNION ALL

    SELECT
          '(10) �� �� �� �� ��'    AS GUBUN    --����
        , DECODE(COUNT(*), 0, NULL, COUNT(*)) AS CNT   --�Ǽ�
        , SUM(SUPPLY_AMT) AS TOTAL    --�ݾ�(��)
    FROM FI_DOMESTIC_LC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE               --�������̵�
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --�ΰ����Ű�Ⱓ���й�ȣ
        AND VAT_DOMESTIC_LC_CD = '01'   --01 : �����ſ���

    UNION ALL

    SELECT
          '(11) �� �� Ȯ �� ��'    AS GUBUN    --����
        , DECODE(COUNT(*), 0, NULL, COUNT(*)) AS CNT   --�Ǽ�
        , SUM(SUPPLY_AMT) AS TOTAL    --�ݾ�(��)
    FROM FI_DOMESTIC_LC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE               --�������̵�
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --�ΰ����Ű�Ⱓ���й�ȣ
        AND VAT_DOMESTIC_LC_CD = '02'   --02 : ����Ȯ�μ�
    ; 

END LIST_UP_DOMESTIC_LC;








--�ϴ���ȸ
PROCEDURE LIST_DOWN_DOMESTIC_LC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE            --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
)

AS

BEGIN

    OPEN P_CURSOR FOR

    WITH T AS(
        SELECT
              SOB_ID	            --ȸ����̵�
            , ORG_ID	            --����ξ��̵�
            , TAX_CODE	    --�������̵�
            , VAT_MNG_SERIAL	    --�ΰ����Ű�Ⱓ���й�ȣ
            , SPEC_SERIAL	        --�Ϸù�ȣ            
            , VAT_DOMESTIC_LC_CD    --�����ڵ�
            , FI_COMMON_G.CODE_NAME_F('VAT_DOMESTIC_LC', VAT_DOMESTIC_LC_CD, SOB_ID, ORG_ID) AS VAT_DOMESTIC_LC_NM   --���и�            
            , DOC_NO	            --������ȣ
            , PUB_DATE	            --�߱���
            , VAT_NUMBER	        --����ڵ�Ϲ�ȣ
            , SUPPLY_AMT	        --�ݾ�
        FROM FI_DOMESTIC_LC       
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND TAX_CODE = W_TAX_CODE               --�������̵�
            AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --�ΰ����Ű�Ⱓ���й�ȣ
        ORDER BY VAT_DOMESTIC_LC_CD, PUB_DATE
    )
    SELECT
        ROWNUM AS SEQ
        , T.*
    FROM T
    ; 

END LIST_DOWN_DOMESTIC_LC;









--���� POPUP
PROCEDURE POPUP_DOMESTIC_LC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --����ξ��̵�
)

AS

BEGIN

    OPEN P_CURSOR FOR
    
    SELECT CODE, CODE_NAME
    FROM FI_COMMON
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID 
        AND GROUP_CODE = 'VAT_DOMESTIC_LC'
    ;    

END POPUP_DOMESTIC_LC;







--grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_DOMESTIC_LC(
      W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE           --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE     --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL         IN  FI_DOMESTIC_LC.SPEC_SERIAL%TYPE        --�Ϸù�ȣ
    
    , P_VAT_DOMESTIC_LC_CD  IN  FI_DOMESTIC_LC.VAT_DOMESTIC_LC_CD%TYPE  --����
    , P_DOC_NO              IN  FI_DOMESTIC_LC.DOC_NO%TYPE              --������ȣ
    
    , P_LAST_UPDATED_BY     IN  FI_DOMESTIC_LC.LAST_UPDATED_BY%TYPE    --������
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);

BEGIN

    UPDATE FI_DOMESTIC_LC
    SET
          VAT_DOMESTIC_LC_CD    = P_VAT_DOMESTIC_LC_CD  --����    
        , DOC_NO                = P_DOC_NO              --������ȣ
        
        , LAST_UPDATE_DATE      = V_SYSDATE             --������
        , LAST_UPDATED_BY       = P_LAST_UPDATED_BY     --������
    WHERE   SOB_ID              = W_SOB_ID              --ȸ����̵�
        AND ORG_ID              = W_ORG_ID              --����ξ��̵�
        AND TAX_CODE            = W_TAX_CODE            --�������̵�        
        AND VAT_MNG_SERIAL      = W_VAT_MNG_SERIAL      --�ΰ����Ű�Ⱓ���й�ȣ
        AND SPEC_SERIAL         = W_SPEC_SERIAL         --�Ϸù�ȣ
    ;

END UPDATE_DOMESTIC_LC;









--grid�� ��ȸ�� �ڷ� DELETE
PROCEDURE DELETE_DOMESTIC_LC(
      W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE           --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE     --�ΰ����Ű�Ⱓ���й�ȣ
    , W_SPEC_SERIAL         IN  FI_DOMESTIC_LC.SPEC_SERIAL%TYPE        --�Ϸù�ȣ
)

AS

BEGIN

    DELETE FI_DOMESTIC_LC
    WHERE   SOB_ID              = W_SOB_ID              --ȸ����̵�
        AND ORG_ID              = W_ORG_ID              --����ξ��̵�
        AND TAX_CODE            = W_TAX_CODE            --�������̵�        
        AND VAT_MNG_SERIAL      = W_VAT_MNG_SERIAL      --�ΰ����Ű�Ⱓ���й�ȣ
        AND SPEC_SERIAL         = W_SPEC_SERIAL         --�Ϸù�ȣ
    ;

END DELETE_DOMESTIC_LC;







--�޼��� : �����, �����⵵, �Ű�Ⱓ����, �ۼ�����, �ŷ��Ⱓ�� �ʼ��Դϴ�.(FCM_10368)
--         ����� �ڷᰡ �����ϴ�.(FCM_10439)
--���ڼ��ݰ�꼭_�߱ݼ��װ����Ű� ��¿�
PROCEDURE PRINT_DOMESTIC_LC(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  NUMBER  --ȸ����̵�
    , W_ORG_ID          IN  NUMBER  --����ξ��̵� 
    , W_TAX_CODE        IN  VARCHAR2
    , W_CREATE_DATE     IN  DATE    --�ۼ����� 
    , W_DEAL_DATE_FR    IN  DATE    --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO    IN  DATE    --�ŷ��Ⱓ_����    
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          B.VAT_NUMBER  --����ڵ�Ϲ�ȣ
        , A.CORP_NAME   --��ȣ(���θ�)
        , A.LEGAL_NUMBER                        --�ֹ�(����)��Ϲ�ȣ
        , A.PRESIDENT_NAME AS PRESIDENT_NAME   --����(��ǥ��)
        , B.ADDR1 || ' ' || B.ADDR2 AS LOCATION     --����������
        , A.TEL_NUMBER                              --��ȭ��ȣ
        , B.BUSINESS_ITEM || '(' || BUSINESS_TYPE || ')' AS BUSINESS    --����(����)                
        , B.BUSINESS_ITEM AS BUSINESS_ITEM    --����
        , B.BUSINESS_TYPE AS BUSINESS_TYPE    --����
        , B.TAX_OFFICE_NAME || ' ��������' AS TAX_OFFICE_NAME --���Ҽ�����
        , TO_CHAR(W_CREATE_DATE, 'YYYY') || '�� ' 
          || TO_NUMBER(TO_CHAR(W_CREATE_DATE, 'MM')) || '�� ' 
          || TO_NUMBER(TO_CHAR(W_CREATE_DATE, 'DD')) || '��'  AS CREATE_DATE   --�ۼ����� 
        , TO_CHAR(TO_DATE('20110630'), 'YYYY')  || ' ��  '
          || TO_NUMBER(TO_CHAR(TO_DATE('20110401'), 'MM')) || '��  ' || TO_NUMBER(TO_CHAR(TO_DATE('20110401'), 'DD'))  || '��  ~  '
          || TO_NUMBER(TO_CHAR(TO_DATE('20110630'), 'MM')) || '��  ' || TO_NUMBER(TO_CHAR(TO_DATE('20110630'), 'DD')) || '�� ' AS DEAL_TERM    --�ŷ��Ⱓ
        , '(   ' || TO_CHAR(W_DEAL_DATE_TO, 'YYYY') || '  ��   �� ' ||  
          CASE
            WHEN TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'MM')) <= 6 THEN '1'
            ELSE '2'
          END
          || '  ��   )' AS FISCAL_YEAR   --�ΰ���ġ���Ű���          
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
        
END PRINT_DOMESTIC_LC;






END FI_DOMESTIC_LC_G;
/
