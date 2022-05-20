CREATE OR REPLACE PACKAGE FI_ZERO_TAX_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_ZERO_TAX_SPEC_G
Description  : ������÷�μ���������� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : FCMF0873(������÷�μ����������)
Program History :
    -.����>�� �ڷ�� �۾��ڰ� �ΰ���ġ���Ű�� �����Ͽ� ���� �Է��ϴ� �ڷ�� ��ǥ�ʹ� �����Ѵ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-14   Leem Dong Ern(�ӵ���)
*****************************************************************************/






--������� �⺻�� ������
PROCEDURE SET_ZERO_TAX_RATE_REASON(
      W_SOB_ID                  IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE    --ȸ����̵�
    , W_ORG_ID                  IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE    --����ξ��̵�
    , O_ZERO_TAX_RATE_REASON_CD OUT VARCHAR2    --��������ڵ�
    , O_ZERO_TAX_RATE_REASON_NM OUT VARCHAR2    --�������  
);







--grid�� ��ȸ�Ǵ� �ڷ� ����
PROCEDURE LIST_ZERO_TAX_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID                  IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE                IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --�������̵�(��>42)    
    , W_VAT_MNG_SERIAL          IN  FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --�ΰ����Ű�Ⱓ���й�ȣ
    , W_ZERO_TAX_RATE_REASON    IN  FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --�������    
    , W_PUBLISH_DATE_FR         IN  FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE          --�߱ޱⰣ_����
    , W_PUBLISH_DATE_TO         IN  FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE          --�߱ޱⰣ_����
);







--grid�� ��ȸ�Ǵ� �ڷ� �� �ݾ��ڷ�鿡 ���� �հ�
PROCEDURE SUM_ZERO_TAX_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID                  IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE                IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --�������̵�(��>42)    
    , W_VAT_MNG_SERIAL          IN  FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --�ΰ����Ű�Ⱓ���й�ȣ
    , W_ZERO_TAX_RATE_REASON    IN  FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --�������    
    , W_PUBLISH_DATE_FR         IN  FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE          --�߱ޱⰣ_����
    , W_PUBLISH_DATE_TO         IN  FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE          --�߱ޱⰣ_����
);





--grid�� �ű� �׸� �߰�
PROCEDURE INSERT_ZERO_TAX_SPEC(
      P_SOB_ID	                IN 	FI_ZERO_TAX_SPEC.SOB_ID%TYPE	            --ȸ����̵�
    , P_ORG_ID	                IN 	FI_ZERO_TAX_SPEC.ORG_ID%TYPE	            --����ξ��̵�
    , P_TAX_CODE                IN 	FI_ZERO_TAX_SPEC.TAX_CODE%TYPE            --�������̵�   
    , P_VAT_MNG_SERIAL          IN 	FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --�ΰ����Ű�Ⱓ���й�ȣ
    , P_ZERO_TAX_RATE_REASON    IN 	FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --�������    
    , P_DOC_NAME	              IN 	FI_ZERO_TAX_SPEC.DOC_NAME%TYPE	            --������    
    , P_PUBLISHER	              IN 	FI_ZERO_TAX_SPEC.PUBLISHER%TYPE	            --�߱���    
    , P_PUBLISH_DATE	          IN	FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE	        --�߱�����    
    , P_SHIPPING_DATE	          IN	FI_ZERO_TAX_SPEC.SHIPPING_DATE%TYPE	        --��������    
    , P_CURRENCY_CODE           IN	FI_ZERO_TAX_SPEC.CURRENCY_CODE%TYPE	        --��ȭ�ڵ�    
    , P_EXCHANGE_RATE	          IN	FI_ZERO_TAX_SPEC.EXCHANGE_RATE%TYPE	        --ȯ��    
    , P_SUBMIT_FOREIGN_AMT	    IN	FI_ZERO_TAX_SPEC.SUBMIT_FOREIGN_AMT%TYPE    --��������ȭ    
    , P_SUBMIT_KOREAN_AMT	      IN	FI_ZERO_TAX_SPEC.SUBMIT_KOREAN_AMT%TYPE	    --��������ȭ    
    , P_REPORT_FOREIGN_AMT	    IN	FI_ZERO_TAX_SPEC.REPORT_FOREIGN_AMT%TYPE	--���Ű��ȭ
    , P_REPORT_KOREAN_AMT       IN	FI_ZERO_TAX_SPEC.REPORT_KOREAN_AMT%TYPE	    --���Ű��ȭ
    , P_CREATED_BY	            IN	FI_ZERO_TAX_SPEC.CREATED_BY%TYPE	        --������
);





--grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_ZERO_TAX_SPEC(
      W_SOB_ID	                IN 	FI_ZERO_TAX_SPEC.SOB_ID%TYPE	            --ȸ����̵�
    , W_ORG_ID	                IN 	FI_ZERO_TAX_SPEC.ORG_ID%TYPE	            --����ξ��̵�
    , W_TAX_CODE                IN 	FI_ZERO_TAX_SPEC.TAX_CODE%TYPE     --�������̵�
    , W_VAT_MNG_SERIAL          IN 	FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --�ΰ����Ű�Ⱓ���й�ȣ
    , W_ZERO_TAX_RATE_REASON    IN 	FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --�������    
    , W_SPEC_SERIAL             IN 	FI_ZERO_TAX_SPEC.SPEC_SERIAL%TYPE           --�Ϸù�ȣ
    , P_DOC_NAME	              IN 	FI_ZERO_TAX_SPEC.DOC_NAME%TYPE	            --������    
    , P_PUBLISHER	              IN 	FI_ZERO_TAX_SPEC.PUBLISHER%TYPE	            --�߱���    
    , P_PUBLISH_DATE	          IN	FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE	        --�߱�����    
    , P_SHIPPING_DATE	          IN	FI_ZERO_TAX_SPEC.SHIPPING_DATE%TYPE	        --��������    
    , P_CURRENCY_CODE           IN	FI_ZERO_TAX_SPEC.CURRENCY_CODE%TYPE	        --��ȭ�ڵ�    
    , P_EXCHANGE_RATE	          IN	FI_ZERO_TAX_SPEC.EXCHANGE_RATE%TYPE	        --ȯ��    
    , P_SUBMIT_FOREIGN_AMT	    IN	FI_ZERO_TAX_SPEC.SUBMIT_FOREIGN_AMT%TYPE    --��������ȭ    
    , P_SUBMIT_KOREAN_AMT	      IN	FI_ZERO_TAX_SPEC.SUBMIT_KOREAN_AMT%TYPE	    --��������ȭ    
    , P_REPORT_FOREIGN_AMT	    IN	FI_ZERO_TAX_SPEC.REPORT_FOREIGN_AMT%TYPE	--���Ű��ȭ
    , P_REPORT_KOREAN_AMT       IN	FI_ZERO_TAX_SPEC.REPORT_KOREAN_AMT%TYPE	    --���Ű��ȭ
    , P_LAST_UPDATED_BY         IN  FI_ZERO_TAX_SPEC.LAST_UPDATED_BY%TYPE       --������
);






--grid�� ��ȸ�� �ڷ� ����
PROCEDURE DELETE_ZERO_TAX_SPEC(
      W_SOB_ID	                IN 	FI_ZERO_TAX_SPEC.SOB_ID%TYPE	            --ȸ����̵�
    , W_ORG_ID	                IN 	FI_ZERO_TAX_SPEC.ORG_ID%TYPE	            --����ξ��̵�
    , W_TAX_CODE                IN 	FI_ZERO_TAX_SPEC.TAX_CODE%TYPE            --�������̵�
    , W_VAT_MNG_SERIAL          IN 	FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --�ΰ����Ű�Ⱓ���й�ȣ
    , W_ZERO_TAX_RATE_REASON    IN 	FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --�������     
    , W_SPEC_SERIAL             IN 	FI_ZERO_TAX_SPEC.SPEC_SERIAL%TYPE           --�Ϸù�ȣ
);






--������÷�μ���������� ���� ��� ��¿�
PROCEDURE PRINT_ZERO_TAX_SPEC_TITLE(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID                  IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE                IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --�������̵�(��>42)
    , W_ZERO_TAX_RATE_REASON    IN 	FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --�������      
    
    --�Ʒ� �׸��� ��½� �ʼ��׸��̴�.
    , W_DEAL_DATE_FR            IN  DATE    --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO            IN  DATE    --�ŷ��Ⱓ_����
    , W_CREATE_DATE             IN  DATE    --�ۼ�����
);






END FI_ZERO_TAX_SPEC_G;
/
CREATE OR REPLACE PACKAGE BODY FI_ZERO_TAX_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_ZERO_TAX_SPEC_G
Description  : ������÷�μ���������� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : FCMF0873(������÷�μ����������)
Program History :
    -.����>�� �ڷ�� �۾��ڰ� �ΰ���ġ���Ű�� �����Ͽ� ���� �Է��ϴ� �ڷ�� ��ǥ�ʹ� �����Ѵ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-14   Leem Dong Ern(�ӵ���)
*****************************************************************************/






--������� �⺻�� ������
PROCEDURE SET_ZERO_TAX_RATE_REASON(
      W_SOB_ID                  IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE    --ȸ����̵�
    , W_ORG_ID                  IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE    --����ξ��̵�
    , O_ZERO_TAX_RATE_REASON_CD OUT VARCHAR2    --��������ڵ�
    , O_ZERO_TAX_RATE_REASON_NM OUT VARCHAR2    --�������   
)

AS

BEGIN

    SELECT
        '02', FI_COMMON_G.CODE_NAME_F('ZERO_TAX_RATE_REASON', '02', W_SOB_ID, W_ORG_ID) AS VAT_TYPE_NAME
    INTO O_ZERO_TAX_RATE_REASON_CD, O_ZERO_TAX_RATE_REASON_NM
    FROM DUAL;

END SET_ZERO_TAX_RATE_REASON;








--grid�� ��ȸ�Ǵ� �ڷ� ����
PROCEDURE LIST_ZERO_TAX_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID                  IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE                IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --�������̵�(��>42)    
    , W_VAT_MNG_SERIAL          IN  FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --�ΰ����Ű�Ⱓ���й�ȣ
    , W_ZERO_TAX_RATE_REASON    IN  FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --�������    
    , W_PUBLISH_DATE_FR         IN  FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE          --�߱ޱⰣ_����
    , W_PUBLISH_DATE_TO         IN  FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE          --�߱ޱⰣ_����
)

AS

BEGIN

    OPEN P_CURSOR FOR
        
    WITH T AS(
        SELECT 
              SOB_ID            --ȸ����̵�
            , ORG_ID            --����ξ��̵�
            , TAX_CODE          --�������̵�
            , VAT_MNG_SERIAL    --�ΰ����Ű�Ⱓ���й�ȣ
            , FI_VAT_REPORT_MNG_G.VAT_MNG_SERIAL_F(VAT_MNG_SERIAL) AS VAT_REPORT_NM   --�Ű�Ⱓ���и�
            , ZERO_TAX_RATE_REASON  --�������
            , SPEC_SERIAL           --�Ϸù�ȣ
            , DOC_NAME              --������
            , PUBLISHER             --�߱���
            , PUBLISH_DATE          --�߱�����
            , SHIPPING_DATE         --��������        
            , TO_CHAR(PUBLISH_DATE, 'YYYY.MM.DD') AS PRINT_PUBLISH_DATE     --���_�߱�����
            , TO_CHAR(SHIPPING_DATE, 'YYYY.MM.DD') AS PRINT_SHIPPING_DATE   --���_��������
            , CURRENCY_CODE         --��ȭ
            , EXCHANGE_RATE         --ȯ��
            , SUBMIT_FOREIGN_AMT    --��������ȭ
            , SUBMIT_KOREAN_AMT     --��������ȭ
            , REPORT_FOREIGN_AMT    --���Ű��ȭ
            , REPORT_KOREAN_AMT     --���Ű��ȭ
        FROM FI_ZERO_TAX_SPEC
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND TAX_CODE = W_TAX_CODE
            AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
            AND ZERO_TAX_RATE_REASON = W_ZERO_TAX_RATE_REASON
            
            --AND PUBLISH_DATE BETWEEN TO_DATE('2011-04-01') AND TO_DATE('2011-06-30')
            AND PUBLISH_DATE BETWEEN NVL(W_PUBLISH_DATE_FR, PUBLISH_DATE) AND NVL(W_PUBLISH_DATE_TO, PUBLISH_DATE)
        ORDER BY PUBLISH_DATE, SHIPPING_DATE
    )
    SELECT 
        ROWNUM AS SEQ     --���_�Ϸù�ȣ
        , T.* 
    FROM T  ;   

END LIST_ZERO_TAX_SPEC;






--grid�� ��ȸ�Ǵ� �ڷ� �� �ݾ��ڷ�鿡 ���� �հ�
PROCEDURE SUM_ZERO_TAX_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID                  IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE                IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --�������̵�(��>42)    
    , W_VAT_MNG_SERIAL          IN  FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --�ΰ����Ű�Ⱓ���й�ȣ
    , W_ZERO_TAX_RATE_REASON    IN  FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --�������    
    , W_PUBLISH_DATE_FR         IN  FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE          --�߱ޱⰣ_����
    , W_PUBLISH_DATE_TO         IN  FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE          --�߱ޱⰣ_����
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          NVL(SUM(SUBMIT_FOREIGN_AMT), 0) AS SUBMIT_FOREIGN_AMT --��������ȭ
        , NVL(SUM(SUBMIT_KOREAN_AMT), 0) AS SUBMIT_KOREAN_AMT   --��������ȭ
        , NVL(SUM(REPORT_FOREIGN_AMT), 0) AS REPORT_FOREIGN_AMT --���Ű��ȭ
        , NVL(SUM(REPORT_KOREAN_AMT), 0) AS REPORT_KOREAN_AMT   --���Ű��ȭ
    FROM FI_ZERO_TAX_SPEC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
        AND ZERO_TAX_RATE_REASON = W_ZERO_TAX_RATE_REASON
        
        --AND PUBLISH_DATE BETWEEN TO_DATE('2011-04-01') AND TO_DATE('2011-06-30')
        AND PUBLISH_DATE BETWEEN NVL(W_PUBLISH_DATE_FR, PUBLISH_DATE) AND NVL(W_PUBLISH_DATE_TO, PUBLISH_DATE)
    ORDER BY PUBLISH_DATE, SHIPPING_DATE    ;   


END SUM_ZERO_TAX_SPEC;





--grid�� �ű� �׸� �߰�
PROCEDURE INSERT_ZERO_TAX_SPEC(
      P_SOB_ID	                IN 	FI_ZERO_TAX_SPEC.SOB_ID%TYPE	            --ȸ����̵�
    , P_ORG_ID	                IN 	FI_ZERO_TAX_SPEC.ORG_ID%TYPE	            --����ξ��̵�
    , P_TAX_CODE                IN 	FI_ZERO_TAX_SPEC.TAX_CODE%TYPE            --�������̵�   
    , P_VAT_MNG_SERIAL          IN 	FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --�ΰ����Ű�Ⱓ���й�ȣ
    , P_ZERO_TAX_RATE_REASON    IN 	FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --�������    
    , P_DOC_NAME	              IN 	FI_ZERO_TAX_SPEC.DOC_NAME%TYPE	            --������    
    , P_PUBLISHER	              IN 	FI_ZERO_TAX_SPEC.PUBLISHER%TYPE	            --�߱���    
    , P_PUBLISH_DATE	          IN	FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE	        --�߱�����    
    , P_SHIPPING_DATE	          IN	FI_ZERO_TAX_SPEC.SHIPPING_DATE%TYPE	        --��������    
    , P_CURRENCY_CODE           IN	FI_ZERO_TAX_SPEC.CURRENCY_CODE%TYPE	        --��ȭ�ڵ�    
    , P_EXCHANGE_RATE	          IN	FI_ZERO_TAX_SPEC.EXCHANGE_RATE%TYPE	        --ȯ��    
    , P_SUBMIT_FOREIGN_AMT	    IN	FI_ZERO_TAX_SPEC.SUBMIT_FOREIGN_AMT%TYPE    --��������ȭ    
    , P_SUBMIT_KOREAN_AMT	      IN	FI_ZERO_TAX_SPEC.SUBMIT_KOREAN_AMT%TYPE	    --��������ȭ    
    , P_REPORT_FOREIGN_AMT	    IN	FI_ZERO_TAX_SPEC.REPORT_FOREIGN_AMT%TYPE	--���Ű��ȭ
    , P_REPORT_KOREAN_AMT       IN	FI_ZERO_TAX_SPEC.REPORT_KOREAN_AMT%TYPE	    --���Ű��ȭ
    , P_CREATED_BY	            IN	FI_ZERO_TAX_SPEC.CREATED_BY%TYPE	        --������
)

AS

V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
t_SPEC_SERIAL   FI_ZERO_TAX_SPEC.SPEC_SERIAL%TYPE;

BEGIN

    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO t_SPEC_SERIAL FROM FI_ZERO_TAX_SPEC;   --�Ϸù�ȣ

    INSERT INTO FI_ZERO_TAX_SPEC(
          SOB_ID	            --ȸ����̵�
        , ORG_ID	            --����ξ��̵�
        , TAX_CODE            --�������̵�        
        , VAT_MNG_SERIAL        --�ΰ����Ű�Ⱓ���й�ȣ
        , ZERO_TAX_RATE_REASON  --�������        
        , SPEC_SERIAL           --�Ϸù�ȣ
        , DOC_NAME	            --������    
        , PUBLISHER	            --�߱���    
        , PUBLISH_DATE	        --�߱�����    
        , SHIPPING_DATE	        --��������    
        , CURRENCY_CODE         --��ȭ�ڵ�    
        , EXCHANGE_RATE	        --ȯ��    
        , SUBMIT_FOREIGN_AMT    --��������ȭ    
        , SUBMIT_KOREAN_AMT	    --��������ȭ    
        , REPORT_FOREIGN_AMT	--���Ű��ȭ
        , REPORT_KOREAN_AMT     --���Ű��ȭ
        , CREATION_DATE         --������
        , CREATED_BY	        --������
        , LAST_UPDATE_DATE      --������
        , LAST_UPDATED_BY	    --������
    )
    VALUES(
          P_SOB_ID	                --ȸ����̵�
        , P_ORG_ID	                --����ξ��̵�
        , P_TAX_CODE                --�������̵� 
        , P_VAT_MNG_SERIAL          --�ΰ����Ű�Ⱓ���й�ȣ
        , P_ZERO_TAX_RATE_REASON    --�������        
        , t_SPEC_SERIAL             --�Ϸù�ȣ
        , P_DOC_NAME	            --������    
        , P_PUBLISHER	            --�߱���    
        , P_PUBLISH_DATE	        --�߱�����    
        , P_SHIPPING_DATE	        --��������    
        , P_CURRENCY_CODE           --��ȭ�ڵ�    
        , P_EXCHANGE_RATE	        --ȯ��    
        , P_SUBMIT_FOREIGN_AMT	    --��������ȭ    
        , P_SUBMIT_KOREAN_AMT	    --��������ȭ    
        , P_REPORT_FOREIGN_AMT	    --���Ű��ȭ
        , P_REPORT_KOREAN_AMT       --���Ű��ȭ
        , V_SYSDATE                 --������
        , P_CREATED_BY	            --������
        , V_SYSDATE                 --������
        , P_CREATED_BY	            --������
    );

END INSERT_ZERO_TAX_SPEC;







--grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_ZERO_TAX_SPEC(
      W_SOB_ID	                IN 	FI_ZERO_TAX_SPEC.SOB_ID%TYPE	            --ȸ����̵�
    , W_ORG_ID	                IN 	FI_ZERO_TAX_SPEC.ORG_ID%TYPE	            --����ξ��̵�
    , W_TAX_CODE                IN 	FI_ZERO_TAX_SPEC.TAX_CODE%TYPE     --�������̵�
    , W_VAT_MNG_SERIAL          IN 	FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --�ΰ����Ű�Ⱓ���й�ȣ
    , W_ZERO_TAX_RATE_REASON    IN 	FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --�������    
    , W_SPEC_SERIAL             IN 	FI_ZERO_TAX_SPEC.SPEC_SERIAL%TYPE           --�Ϸù�ȣ
    , P_DOC_NAME	              IN 	FI_ZERO_TAX_SPEC.DOC_NAME%TYPE	            --������    
    , P_PUBLISHER	              IN 	FI_ZERO_TAX_SPEC.PUBLISHER%TYPE	            --�߱���    
    , P_PUBLISH_DATE	          IN	FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE	        --�߱�����    
    , P_SHIPPING_DATE	          IN	FI_ZERO_TAX_SPEC.SHIPPING_DATE%TYPE	        --��������    
    , P_CURRENCY_CODE           IN	FI_ZERO_TAX_SPEC.CURRENCY_CODE%TYPE	        --��ȭ�ڵ�    
    , P_EXCHANGE_RATE	          IN	FI_ZERO_TAX_SPEC.EXCHANGE_RATE%TYPE	        --ȯ��    
    , P_SUBMIT_FOREIGN_AMT	    IN	FI_ZERO_TAX_SPEC.SUBMIT_FOREIGN_AMT%TYPE    --��������ȭ    
    , P_SUBMIT_KOREAN_AMT	      IN	FI_ZERO_TAX_SPEC.SUBMIT_KOREAN_AMT%TYPE	    --��������ȭ    
    , P_REPORT_FOREIGN_AMT	    IN	FI_ZERO_TAX_SPEC.REPORT_FOREIGN_AMT%TYPE	--���Ű��ȭ
    , P_REPORT_KOREAN_AMT       IN	FI_ZERO_TAX_SPEC.REPORT_KOREAN_AMT%TYPE	    --���Ű��ȭ
    , P_LAST_UPDATED_BY         IN  FI_ZERO_TAX_SPEC.LAST_UPDATED_BY%TYPE       --������
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);

BEGIN

    UPDATE FI_ZERO_TAX_SPEC
    SET
          DOC_NAME	            = P_DOC_NAME	        --������    
        , PUBLISHER	            = P_PUBLISHER	        --�߱���    
        , PUBLISH_DATE	        = P_PUBLISH_DATE	    --�߱�����    
        , SHIPPING_DATE	        = P_SHIPPING_DATE	    --��������    
        , CURRENCY_CODE         = P_CURRENCY_CODE	    --��ȭ�ڵ�    
        , EXCHANGE_RATE	        = P_EXCHANGE_RATE	    --ȯ��    
        , SUBMIT_FOREIGN_AMT    = P_SUBMIT_FOREIGN_AMT  --��������ȭ    
        , SUBMIT_KOREAN_AMT	    = P_SUBMIT_KOREAN_AMT	--��������ȭ    
        , REPORT_FOREIGN_AMT	  = P_REPORT_FOREIGN_AMT  --���Ű��ȭ
        , REPORT_KOREAN_AMT     = P_REPORT_KOREAN_AMT	--���Ű��ȭ        
        , LAST_UPDATE_DATE      = V_SYSDATE             --������
        , LAST_UPDATED_BY       = P_LAST_UPDATED_BY     --������
    WHERE   SOB_ID                  = W_SOB_ID                  --ȸ����̵�
        AND ORG_ID                  = W_ORG_ID                  --����ξ��̵�
        AND TAX_CODE                = W_TAX_CODE                --�������̵�        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --�ΰ����Ű�Ⱓ���й�ȣ
        AND ZERO_TAX_RATE_REASON    = W_ZERO_TAX_RATE_REASON    --�������                
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --�Ϸù�ȣ
    ;

END UPDATE_ZERO_TAX_SPEC;





--grid�� ��ȸ�� �ڷ� ����
PROCEDURE DELETE_ZERO_TAX_SPEC(
      W_SOB_ID	                IN 	FI_ZERO_TAX_SPEC.SOB_ID%TYPE	            --ȸ����̵�
    , W_ORG_ID	                IN 	FI_ZERO_TAX_SPEC.ORG_ID%TYPE	            --����ξ��̵�
    , W_TAX_CODE                IN 	FI_ZERO_TAX_SPEC.TAX_CODE%TYPE            --�������̵�
    , W_VAT_MNG_SERIAL          IN 	FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --�ΰ����Ű�Ⱓ���й�ȣ
    , W_ZERO_TAX_RATE_REASON    IN 	FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --�������     
    , W_SPEC_SERIAL             IN 	FI_ZERO_TAX_SPEC.SPEC_SERIAL%TYPE           --�Ϸù�ȣ
)

AS

BEGIN

    DELETE FI_ZERO_TAX_SPEC
    WHERE   SOB_ID                  = W_SOB_ID                  --ȸ����̵�
        AND ORG_ID                  = W_ORG_ID                  --����ξ��̵�
        AND TAX_CODE                = W_TAX_CODE                --�������̵�        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --�ΰ����Ű�Ⱓ���й�ȣ
        AND ZERO_TAX_RATE_REASON    = W_ZERO_TAX_RATE_REASON    --�������                
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --�Ϸù�ȣ
    ;

END DELETE_ZERO_TAX_SPEC;







--������÷�μ���������� ���� ��� ��¿�
PROCEDURE PRINT_ZERO_TAX_SPEC_TITLE(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID                  IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE                IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --�������̵�(��>42)
    , W_ZERO_TAX_RATE_REASON    IN 	FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --�������      
    
    --�Ʒ� �׸��� ��½� �ʼ��׸��̴�.
    , W_DEAL_DATE_FR            IN  DATE    --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO            IN  DATE    --�ŷ��Ⱓ_����
    , W_CREATE_DATE             IN  DATE    --�ۼ�����
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
        , B.ADDR1 || ' ' || B.ADDR2 || ' (  ' || A.TEL_NUMBER || '  ) ' AS LOCATION_TEL  --����������(��ȭ��ȣ)
        , TO_CHAR(W_DEAL_DATE_FR, 'YYYY.MM.DD') || ' ~ ' || TO_CHAR(W_DEAL_DATE_TO, 'YYYY.MM.DD') AS DEAL_TERM    --�ŷ��Ⱓ
        , TO_CHAR(W_CREATE_DATE, 'YYYY.MM.DD') AS CREATE_DATE   --�ۼ�����
        , FI_COMMON_G.CODE_NAME_F('ZERO_TAX_RATE_REASON', W_ZERO_TAX_RATE_REASON, A.SOB_ID, A.ORG_ID) AS VAT_TYPE_NAME     --�������
        , '(   ' || TO_CHAR(W_DEAL_DATE_TO, 'YYYY') || '  ��   ' ||  
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
END PRINT_ZERO_TAX_SPEC_TITLE;






END FI_ZERO_TAX_SPEC_G;
/
