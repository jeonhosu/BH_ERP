CREATE OR REPLACE PACKAGE FI_ELEC_TAX_PUB_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_ELEC_TAX_PUB_G(���ڼ��ݰ�꼭_�߱ݼ��װ����Ű�)
Description  : ���ڼ��ݰ�꼭_�߱ݼ��װ����Ű� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : ���ڼ��ݰ�꼭_�߱ݼ��װ����Ű�
Program History :
    -. �� ����� ����ó�����ݰ�꼭�հ�ǥ ��� �ڷḦ ���� �� �۾��ؾ� �Ѵ�. 
       ���� : ����ó�����ݰ�꼭�հ�ǥ ����� ������ [����]�� ���� [����ڵ�Ϲ�ȣ �߱޹��� ��] ���� [�ż�] �׸��� ����
              �� ����� (8)���ڼ��ݰ�꼭 �߱ްǼ��� �⺻������ �����Ǳ� �����̴�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2012-01-02   Leem Dong Ern(�ӵ���)
*****************************************************************************/





--�����ڷ����
--�޽��� : �����ڷḦ �����Ͻðڽ��ϱ�? �� ������ �ڷᰡ �ִ� ��� ���� �ڷᰡ �����ǰ� (��)�����˴ϴ�.
--FCM_10365, �ش� �Ű�Ⱓ�� �ڷ�� �����Ǿ� ������ �� �����ϴ�.
PROCEDURE CREATE_ELEC_TAX_PUB(
      W_SOB_ID              IN  FI_ELEC_TAX_PUB.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_ELEC_TAX_PUB.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_ELEC_TAX_PUB.TAX_CODE%TYPE            --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_ELEC_TAX_PUB.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    , W_CREATED_BY          IN  FI_ELEC_TAX_PUB.CREATED_BY%TYPE          --������
    
    --�Ű�Ⱓ�� ȭ�鿡�� �� ���δ�. �Ű�Ⱓ������ �����ϸ� ���������� ������ ���� �̿��� ���̴�.
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����    
    
    , O_MESSAGE             OUT VARCHAR2    
);





--��ȸ
PROCEDURE LIST_ELEC_TAX_PUB(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ELEC_TAX_PUB.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_ELEC_TAX_PUB.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_ELEC_TAX_PUB.TAX_CODE%TYPE            --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_ELEC_TAX_PUB.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
);










--grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_ELEC_TAX_PUB(
      W_SOB_ID              IN  FI_ELEC_TAX_PUB.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_ELEC_TAX_PUB.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_ELEC_TAX_PUB.TAX_CODE%TYPE           --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_ELEC_TAX_PUB.VAT_MNG_SERIAL%TYPE     --�ΰ����Ű�Ⱓ���й�ȣ
    
    , P_DEDUCT_TAX          IN  FI_ELEC_TAX_PUB.DEDUCT_TAX%TYPE         --��_��������
    
    , P_LAST_UPDATED_BY     IN  FI_ELEC_TAX_PUB.LAST_UPDATED_BY%TYPE    --������
);







--�޼��� : �����, �����⵵, �Ű�Ⱓ����, �ۼ����ڴ� �ʼ��Դϴ�.(FCM_10438)
--         ����� �ڷᰡ �����ϴ�.(FCM_10439)
--���ڼ��ݰ�꼭_�߱ݼ��װ����Ű� ��¿�
PROCEDURE PRINT_ELEC_TAX_PUB(
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  NUMBER  --ȸ����̵�
    , W_ORG_ID      IN  NUMBER  --����ξ��̵� 
    , W_TAX_CODE    IN  VARCHAR2
    , W_CREATE_DATE IN  DATE    --�ۼ�����
    --, W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    --, W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����    
);





END FI_ELEC_TAX_PUB_G;
/
CREATE OR REPLACE PACKAGE BODY FI_ELEC_TAX_PUB_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_ELEC_TAX_PUB_G(���ڼ��ݰ�꼭_�߱ݼ��װ����Ű�)
Description  : ���ڼ��ݰ�꼭_�߱ݼ��װ����Ű� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : ���ڼ��ݰ�꼭_�߱ݼ��װ����Ű�
Program History :
    -. �� ����� ����ó�����ݰ�꼭�հ�ǥ ��� �ڷḦ ���� �� �۾��ؾ� �Ѵ�. 
       ���� : ����ó�����ݰ�꼭�հ�ǥ ����� ������ [����]�� ���� [����ڵ�Ϲ�ȣ �߱޹��� ��] ���� [�ż�] �׸��� ����
              �� ����� (8)���ڼ��ݰ�꼭 �߱ްǼ��� �⺻������ �����Ǳ� �����̴�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2012-01-02   Leem Dong Ern(�ӵ���)
*****************************************************************************/






--�����ڷ����
PROCEDURE CREATE_ELEC_TAX_PUB(
      W_SOB_ID              IN  FI_ELEC_TAX_PUB.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_ELEC_TAX_PUB.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_ELEC_TAX_PUB.TAX_CODE%TYPE            --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_ELEC_TAX_PUB.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
    , W_CREATED_BY          IN  FI_ELEC_TAX_PUB.CREATED_BY%TYPE          --������
    
    --�Ű�Ⱓ�� ȭ�鿡�� �� ���δ�. �Ű�Ⱓ������ �����ϸ� ���������� ������ ���� �̿��� ���̴�.
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����    
    
    , O_MESSAGE             OUT VARCHAR2    
)

AS

REC_CLOSING_YN  EXCEPTION;

t_CLOSING_YN    FI_VAT_REPORT_MNG.CLOSING_YN%TYPE;  --��������
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
        RAISE REC_CLOSING_YN;
        --RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10365', NULL));
    END IF;



    --������ �����ϴ� �ڷᰡ ���� ��� ��� �����Ѵ�.
    DELETE FI_ELEC_TAX_PUB
    WHERE   SOB_ID  = W_SOB_ID  --ȸ����̵�
        AND ORG_ID  = W_ORG_ID  --����ξ��̵�
        AND TAX_CODE = W_TAX_CODE                   --�������̵�
        AND VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL    --�ΰ����Ű�Ⱓ���й�ȣ
    ;    


    INSERT INTO FI_ELEC_TAX_PUB(
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�        
        , TAX_CODE	      --�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű�Ⱓ���й�ȣ
        
        , ELEC_TAX_PUB_CNT  --���ڼ��ݰ�꼭_�߱ްǼ�
      
        , CREATION_DATE     --������
        , CREATED_BY	    --������
        , LAST_UPDATE_DATE  --������
        , LAST_UPDATED_BY	--������          
    )
    --�Ʒ� SELECT ���� [FI_SUM_VAT_TAX_G.UP_SUM_VAT_TAX > ELSIF W_AP_AR_GB = '2' THEN   --����]�� PACKAGE�� ���� 
    --�����Ͽ� �� ������ �°� �Ϻ� ������ ���̴�.
    SELECT
          W_SOB_ID  --ȸ����̵�
        , W_ORG_ID  --����ξ��̵�
        , W_TAX_CODE                --�������̵�
        , W_VAT_MNG_SERIAL          --�ΰ����Ű�Ⱓ���й�ȣ
        
        , NVL(SUM(CNT), 0) AS ELEC_TAX_PUB_CNT  --���ڼ��ݰ�꼭_�߱ްǼ� 
        
        , V_SYSDATE     --������
        , W_CREATED_BY  --������
        , V_SYSDATE     --������
        , W_CREATED_BY  --������         
    FROM
        (
            SELECT             
                  A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                , COUNT(*) AS CNT --�ż�
            FROM FI_SLIP_LINE A
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID 
                AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����, �ΰ���������(2100700)
                AND A.REFER11 = W_TAX_CODE      --�����
                --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                AND A.MANAGEMENT2 IN ('1', '2')  --��������
                AND TRIM(NVL(A.REFER7, 'N')) = 'Y'   --���ڼ��ݰ�꼭����
            GROUP BY  A.MANAGEMENT1 
        )
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

END CREATE_ELEC_TAX_PUB;






--��ȸ
PROCEDURE LIST_ELEC_TAX_PUB(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ELEC_TAX_PUB.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_ELEC_TAX_PUB.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_ELEC_TAX_PUB.TAX_CODE%TYPE            --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_ELEC_TAX_PUB.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�
        , TAX_CODE      	--�������̵�
        , VAT_MNG_SERIAL	--�ΰ����Ű�Ⱓ���й�ȣ
        
        --��.������󼼾�
        , ELEC_TAX_PUB_CNT  --���ڼ��ݰ�꼭_�߱ްǼ�
        , '200��' AS DED_AMT_PER  --�Ǵ� �����ݾ�
        , ELEC_TAX_PUB_CNT * 200 AS DED_ALLOW_TAX   --���� ���ɼ���
        , CASE 
            WHEN ELEC_TAX_PUB_CNT * 200 < 1000000 - NVL(DEDUCT_TAX, 0) THEN ELEC_TAX_PUB_CNT * 200
            ELSE 1000000 - NVL(DEDUCT_TAX, 0)
          END AS MIN_AMT    --�ش� ��������
          
        --��.���� �ѵ��� ���
        , '100����' AS YEAR_LIMIT   --���� �����ѵ���
        , DEDUCT_TAX    --��_��������
        , 1000000 - NVL(DEDUCT_TAX, 0) AS PERIOD_LIMIT_AMT   --�ش� �����Ⱓ �����ѵ���
        
    FROM FI_ELEC_TAX_PUB
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
    ; 


END LIST_ELEC_TAX_PUB;








--grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_ELEC_TAX_PUB(
      W_SOB_ID              IN  FI_ELEC_TAX_PUB.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_ELEC_TAX_PUB.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_ELEC_TAX_PUB.TAX_CODE%TYPE           --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_ELEC_TAX_PUB.VAT_MNG_SERIAL%TYPE     --�ΰ����Ű�Ⱓ���й�ȣ
    
    , P_DEDUCT_TAX          IN  FI_ELEC_TAX_PUB.DEDUCT_TAX%TYPE         --��_��������
    
    , P_LAST_UPDATED_BY     IN  FI_ELEC_TAX_PUB.LAST_UPDATED_BY%TYPE    --������
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);

BEGIN

    UPDATE FI_ELEC_TAX_PUB
    SET
          DEDUCT_TAX   = P_DEDUCT_TAX     --��_��������    
                  
        , LAST_UPDATE_DATE  = V_SYSDATE         --������
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY --������
    WHERE   SOB_ID                  = W_SOB_ID                  --ȸ����̵�
        AND ORG_ID                  = W_ORG_ID                  --����ξ��̵�
        AND TAX_CODE                = W_TAX_CODE                --�������̵�        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --�ΰ����Ű�Ⱓ���й�ȣ               
    ;

END UPDATE_ELEC_TAX_PUB;







--�޼��� : �����, �����⵵, �Ű�Ⱓ����, �ۼ����ڴ� �ʼ��Դϴ�.(FCM_10438)
--         ����� �ڷᰡ �����ϴ�.(FCM_10439)
--���ڼ��ݰ�꼭_�߱ݼ��װ����Ű� ��¿�
PROCEDURE PRINT_ELEC_TAX_PUB(
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  NUMBER  --ȸ����̵�
    , W_ORG_ID      IN  NUMBER  --����ξ��̵� 
    , W_TAX_CODE    IN  VARCHAR2
    , W_CREATE_DATE IN  DATE    --�ۼ�����
    --, W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    --, W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����    
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
          || TO_NUMBER(TO_CHAR(W_CREATE_DATE, 'DD')) || '�� '  AS CREATE_DATE   --�ۼ����� 
        --, TO_CHAR(TO_DATE('20110630'), 'YYYY')  || ' ��  '
        --  || TO_NUMBER(TO_CHAR(TO_DATE('20110401'), 'MM')) || '��  ' || TO_NUMBER(TO_CHAR(TO_DATE('20110401'), 'DD'))  || '��  ~  '
        --  || TO_NUMBER(TO_CHAR(TO_DATE('20110630'), 'MM')) || '��  ' || TO_NUMBER(TO_CHAR(TO_DATE('20110630'), 'DD')) || '�� ' AS DEAL_TERM    --�ŷ��Ⱓ          
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

END PRINT_ELEC_TAX_PUB;






END FI_ELEC_TAX_PUB_G;
/
