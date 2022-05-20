CREATE OR REPLACE PACKAGE FI_VAT_REPORT_MNG_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_VAT_REPORT_MNG_G
Description  : �ΰ���ġ���������� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : FCMF0871(�ΰ�����������)
Program History :
    -.�ΰ���ġ�� �Ű�Ⱓ �� �ε����Ӵ���ް��׸����� �����Ӵ��������, �������ε��� �ڷḦ �����Ѵ�.
    -.�ش� �Ű�Ⱓ�� �����Ǹ� �ΰ����������� ��� �޴����� �ڷ��� ������ �Ұ��ϴ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-15   Leem Dong Ern(�ӵ���)
*****************************************************************************/






--�⺻ ����� ����; �ΰ���ġ�������� ��� �޴����� �������� ����Ѵ�.
PROCEDURE SET_TAX_CODE(
      W_SOB_ID              IN  NUMBER                --ȸ����̵�
    , W_ORG_ID              IN  NUMBER                --����ξ��̵�
    , O_TAX_CODE            OUT VARCHAR2              --(�����)���̵� 
    , O_TAX_DESC            OUT VARCHAR2              --������; ���θ� 
    );






--����� �˾� ; �ΰ���ġ�������� ��� �޴����� �������� ����Ѵ�.
PROCEDURE POP_TAX_CODE(
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_VAT_REPORT_MNG.SOB_ID%TYPE   --ȸ����̵�
    , W_ORG_ID  IN  FI_VAT_REPORT_MNG.ORG_ID%TYPE   --����ξ��̵�
);









--�ΰ���ġ�������� ��κ� �޴����� ����ϴ� �Ű�Ⱓ���� �˾� �ڷ�
PROCEDURE POP_VAT_REPORT_MNG(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_VAT_REPORT_MNG.SOB_ID%TYPE               --ȸ����̵�
    , W_ORG_ID              IN  FI_VAT_REPORT_MNG.ORG_ID%TYPE               --����ξ��̵�
    , W_TAX_CODE            IN  FI_VAT_REPORT_MNG.TAX_CODE%TYPE             --�������̵�
    , W_FY                  IN  FI_VAT_REPORT_MNG.FY%TYPE                   --ȸ��⵵
);










--grid�� ��ȸ�Ǵ� �ڷ� ����
PROCEDURE LIST_VAT_REPORT_MNG(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_VAT_REPORT_MNG.SOB_ID%TYPE            --ȸ����̵�
    , W_ORG_ID              IN  FI_VAT_REPORT_MNG.ORG_ID%TYPE            --����ξ��̵�
    , W_TAX_CODE            IN  FI_VAT_REPORT_MNG.TAX_CODE%TYPE          --������ڵ�(��>110)
    , W_FY                  IN  FI_VAT_REPORT_MNG.FY%TYPE                --ȸ��⵵
);





--grid�� �ű� �׸� �߰�
PROCEDURE INSERT_VAT_REPORT_MNG(
      P_SOB_ID	            IN 	FI_VAT_REPORT_MNG.SOB_ID%TYPE	            --ȸ����̵�
    , P_ORG_ID	            IN 	FI_VAT_REPORT_MNG.ORG_ID%TYPE	            --����ξ��̵�
    , P_TAX_CODE            IN 	FI_VAT_REPORT_MNG.TAX_CODE%TYPE           --������ڵ�.
    , P_FY	                IN 	FI_VAT_REPORT_MNG.FY%TYPE	                --ȸ��⵵        
    , P_VAT_REPORT_TURN	    IN	FI_VAT_REPORT_MNG.VAT_REPORT_TURN%TYPE	    --�Ű����ڵ�        
    , P_VAT_REPORT_GB	      IN	FI_VAT_REPORT_MNG.VAT_REPORT_GB%TYPE	    --�Ű����ڵ�        
    , P_TAX_TERM_FR         IN	FI_VAT_REPORT_MNG.TAX_TERM_FR%TYPE	        --�����Ⱓ_����        
    , P_TAX_TERM_TO	        IN	FI_VAT_REPORT_MNG.TAX_TERM_TO%TYPE	        --�����Ⱓ_����        
    , P_VAT_REPORT_NM	      IN	FI_VAT_REPORT_MNG.VAT_REPORT_NM%TYPE        --�ΰ����Ű�Ⱓ���и�     
    , P_REGARD_RATE	        IN	FI_VAT_REPORT_MNG.REGARD_RATE%TYPE	        --�����Ӵ������������        
    , P_CLOSING_YN	        IN	FI_VAT_REPORT_MNG.CLOSING_YN%TYPE	        --��������
    , P_CREATED_BY	        IN	FI_VAT_REPORT_MNG.CREATED_BY%TYPE	        --������
);





--grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_VAT_REPORT_MNG(
      P_SOB_ID	            IN 	FI_VAT_REPORT_MNG.SOB_ID%TYPE	            --ȸ����̵�
    , P_ORG_ID	            IN 	FI_VAT_REPORT_MNG.ORG_ID%TYPE	            --����ξ��̵�
    , P_TAX_CODE            IN 	FI_VAT_REPORT_MNG.TAX_CODE%TYPE           --������ڵ�.
    , P_VAT_MNG_SERIAL      IN 	FI_VAT_REPORT_MNG.VAT_MNG_SERIAL%TYPE       --�ΰ����Ű�Ⱓ���й�ȣ
    , P_FY	                IN 	FI_VAT_REPORT_MNG.FY%TYPE	                --ȸ��⵵        
    , P_VAT_REPORT_TURN	    IN	FI_VAT_REPORT_MNG.VAT_REPORT_TURN%TYPE	    --�Ű����ڵ�        
    , P_VAT_REPORT_GB	      IN	FI_VAT_REPORT_MNG.VAT_REPORT_GB%TYPE	    --�Ű����ڵ�        
    , P_TAX_TERM_FR         IN	FI_VAT_REPORT_MNG.TAX_TERM_FR%TYPE	        --�����Ⱓ_����        
    , P_TAX_TERM_TO	        IN	FI_VAT_REPORT_MNG.TAX_TERM_TO%TYPE	        --�����Ⱓ_����        
    , P_VAT_REPORT_NM	      IN	FI_VAT_REPORT_MNG.VAT_REPORT_NM%TYPE        --�ΰ����Ű�Ⱓ���и�     
    , P_REGARD_RATE	        IN	FI_VAT_REPORT_MNG.REGARD_RATE%TYPE	        --�����Ӵ������������        
    , P_CLOSING_YN	        IN	FI_VAT_REPORT_MNG.CLOSING_YN%TYPE	        --��������
    , P_LAST_UPDATED_BY     IN  FI_VAT_REPORT_MNG.LAST_UPDATED_BY%TYPE       --������
);






--grid�� ��ȸ�� �ڷ� ����
PROCEDURE DELETE_VAT_REPORT_MNG(
      P_SOB_ID	            IN 	FI_VAT_REPORT_MNG.SOB_ID%TYPE	            --ȸ����̵�
    , P_ORG_ID	            IN 	FI_VAT_REPORT_MNG.ORG_ID%TYPE	            --����ξ��̵�
    , P_TAX_CODE            IN 	FI_VAT_REPORT_MNG.TAX_CODE%TYPE           --������ڵ�.    
    , P_VAT_MNG_SERIAL      IN 	FI_VAT_REPORT_MNG.VAT_MNG_SERIAL%TYPE       --�ΰ����Ű�Ⱓ���й�ȣ
);







--�Ű�Ⱓ���� �� ��ȯ
FUNCTION VAT_MNG_SERIAL_F(
      P_VAT_MNG_SERIAL  IN FI_VAT_REPORT_MNG.VAT_MNG_SERIAL%TYPE    --�ΰ����Ű�Ⱓ���й�ȣ  
) RETURN VARCHAR2;



--�Ű�Ⱓ �������� ��ȯ 
FUNCTION VAT_CLOSED_FLAG(
      W_SOB_ID              IN  FI_VAT_REPORT_MNG.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_VAT_REPORT_MNG.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_VAT_REPORT_MNG.TAX_CODE%TYPE            --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_VAT_REPORT_MNG.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ     
) RETURN VARCHAR2;


END FI_VAT_REPORT_MNG_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_REPORT_MNG_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_VAT_REPORT_MNG_G
Description  : �ΰ���ġ���������� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : FCMF0871(�ΰ�����������)
Program History :
    -.�ΰ���ġ�� �Ű�Ⱓ �� �ε����Ӵ���ް��׸����� �����Ӵ��������, �������ε��� �ڷḦ �����Ѵ�.
    -.�ش� �Ű�Ⱓ�� �����Ǹ� �ΰ����������� ��� �޴����� �ڷ��� ������ �Ұ��ϴ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-15   Leem Dong Ern(�ӵ���)
*****************************************************************************/


--�⺻ ����� ����; �ΰ���ġ�������� ��� �޴����� �������� ����Ѵ�.
PROCEDURE SET_TAX_CODE(
      W_SOB_ID              IN  NUMBER                --ȸ����̵�
    , W_ORG_ID              IN  NUMBER                --����ξ��̵�
    , O_TAX_CODE            OUT VARCHAR2              --(�����)���̵�
    , O_TAX_DESC            OUT VARCHAR2              --������; ���θ� 
)

AS
  V_ID                  NUMBER;
BEGIN
    BEGIN
      FI_COMMON_G.DEFAULT_VALUE_GROUP('TAX_CODE', W_SOB_ID, W_ORG_ID, V_ID, O_TAX_CODE, O_TAX_DESC);
      /*
      SELECT
              FC.CODE AS TAX_CODE   --(�����)���̵�
            , FC.CODE_NAME AS TAX_NAME --(��)������
        INTO O_TAX_CODE
           , O_TAX_DESC
        FROM FI_COMMON FC
        WHERE FC.SOB_ID = W_SOB_ID
            AND FC.ORG_ID = W_ORG_ID
            AND FC.GROUP_CODE = 'TAX_CODE'
            AND 
            AND FC.ENABLED_FLAG   = 'Y'
            AND FC.EFFECTIVE_DATE_FR  <= V_SYSDATE
            AND (FC.EFFECTIVE_DATE_TO >= V_SYSDATE OR FC.EFFECTIVE_DATE_TO IS NULL)=
        ;*/
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
END SET_TAX_CODE;


--����� �˾� ; �ΰ���ġ�������� ��� �޴����� �������� ����Ѵ�.
PROCEDURE POP_TAX_CODE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_VAT_REPORT_MNG.SOB_ID%TYPE   --ȸ����̵�
    , W_ORG_ID  IN  FI_VAT_REPORT_MNG.ORG_ID%TYPE   --����ξ��̵�
)
AS
  V_SYSDATE             DATE := GET_LOCAL_DATE(W_SOB_ID);
BEGIN

    OPEN P_CURSOR FOR
    SELECT
          FC.CODE AS TAX_CODE   --(�����)���̵� 
        , FC.CODE_NAME AS TAX_DESC --(��)������ 
    FROM FI_COMMON FC
    WHERE FC.SOB_ID = W_SOB_ID
        AND FC.ORG_ID = W_ORG_ID
        AND FC.GROUP_CODE = 'TAX_CODE'
        AND FC.ENABLED_FLAG   = 'Y'
        AND FC.EFFECTIVE_DATE_FR  <= V_SYSDATE
        AND (FC.EFFECTIVE_DATE_TO >= V_SYSDATE OR FC.EFFECTIVE_DATE_TO IS NULL)
    ;
END POP_TAX_CODE;



--�ΰ���ġ�������� ��κ� �޴����� ����ϴ� �Ű�Ⱓ���� �˾� �ڷ�
PROCEDURE POP_VAT_REPORT_MNG(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_VAT_REPORT_MNG.SOB_ID%TYPE               --ȸ����̵�
    , W_ORG_ID              IN  FI_VAT_REPORT_MNG.ORG_ID%TYPE               --����ξ��̵�
    , W_TAX_CODE            IN  FI_VAT_REPORT_MNG.TAX_CODE%TYPE             --�������̵�
    , W_FY                  IN  FI_VAT_REPORT_MNG.FY%TYPE                   --ȸ��⵵
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          FY                --ȸ��⵵
        , VAT_MNG_SERIAL    --�ΰ����Ű�Ⱓ���й�ȣ
        , VAT_REPORT_NM     --�ΰ����Ű�Ⱓ���и�
        , TAX_TERM_FR       --�����Ⱓ_����
        , TAX_TERM_TO       --�����Ⱓ_����
        , TO_CHAR(TAX_TERM_FR, 'YYYY.MM.DD') || ' ~ ' || TO_CHAR(TAX_TERM_TO, 'YYYY.MM.DD') AS TAX_TERM      --�����Ⱓ
        , NVL(REGARD_RATE, 0) AS REGARD_RATE   --�����Ӵ������������
        , CLOSING_YN        --��������
        , TO_CHAR(TAX_TERM_FR, 'YYYY-MM') AS START_MM   --�����Ⱓ_���ۿ�
        , TO_CHAR(TAX_TERM_TO, 'YYYY-MM') AS END_MM   --�����Ⱓ_�����
    FROM FI_VAT_REPORT_MNG
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND FY = W_FY
    ORDER BY VAT_REPORT_NM  ;        


END POP_VAT_REPORT_MNG;



--grid�� ��ȸ�Ǵ� �ڷ� ����
PROCEDURE LIST_VAT_REPORT_MNG(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_VAT_REPORT_MNG.SOB_ID%TYPE            --ȸ����̵�
    , W_ORG_ID              IN  FI_VAT_REPORT_MNG.ORG_ID%TYPE            --����ξ��̵�
    , W_TAX_CODE            IN  FI_VAT_REPORT_MNG.TAX_CODE%TYPE          --������ڵ�(��>110)
    , W_FY                  IN  FI_VAT_REPORT_MNG.FY%TYPE                --ȸ��⵵
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID            --ȸ����̵�
        , ORG_ID            --����ξ��̵�
        , TAX_CODE          --�������̵�
        , VAT_MNG_SERIAL    --�ΰ����Ű�Ⱓ���й�ȣ
        , FY                --ȸ��⵵
        , VAT_REPORT_TURN   --�Ű����ڵ�        
        , FI_COMMON_G.CODE_NAME_F('VAT_REPORT_TURN', VAT_REPORT_TURN, SOB_ID, ORG_ID) AS VAT_REPORT_TURN_NM --�Ű���
        , VAT_REPORT_GB     --�Ű����ڵ�
        , FI_COMMON_G.CODE_NAME_F('VAT_REPORT_GB', VAT_REPORT_GB, SOB_ID, ORG_ID) AS VAT_REPORT_GB_NM   --�Ű���                
        , TAX_TERM_FR       --�����Ⱓ_����
        , TAX_TERM_TO       --�����Ⱓ_����
        , VAT_REPORT_NM     --�ΰ����Ű�Ⱓ���и�
        , REGARD_RATE       --�����Ӵ������������
        , CLOSING_YN        --��������
    FROM FI_VAT_REPORT_MNG
    WHERE SOB_ID = W_SOB_ID
      AND ORG_ID = W_ORG_ID
      AND TAX_CODE = W_TAX_CODE
      AND FY = NVL(W_FY, FY)
    ORDER BY FY DESC, VAT_REPORT_TURN, VAT_REPORT_GB ;   

END LIST_VAT_REPORT_MNG;


--grid�� �ű� �׸� �߰�
PROCEDURE INSERT_VAT_REPORT_MNG(
      P_SOB_ID	            IN 	FI_VAT_REPORT_MNG.SOB_ID%TYPE	            --ȸ����̵�
    , P_ORG_ID	            IN 	FI_VAT_REPORT_MNG.ORG_ID%TYPE	            --����ξ��̵�
    , P_TAX_CODE            IN 	FI_VAT_REPORT_MNG.TAX_CODE%TYPE           --������ڵ�.
    , P_FY	                IN 	FI_VAT_REPORT_MNG.FY%TYPE	                --ȸ��⵵        
    , P_VAT_REPORT_TURN	    IN	FI_VAT_REPORT_MNG.VAT_REPORT_TURN%TYPE	    --�Ű����ڵ�        
    , P_VAT_REPORT_GB	      IN	FI_VAT_REPORT_MNG.VAT_REPORT_GB%TYPE	    --�Ű����ڵ�        
    , P_TAX_TERM_FR         IN	FI_VAT_REPORT_MNG.TAX_TERM_FR%TYPE	        --�����Ⱓ_����        
    , P_TAX_TERM_TO	        IN	FI_VAT_REPORT_MNG.TAX_TERM_TO%TYPE	        --�����Ⱓ_����        
    , P_VAT_REPORT_NM	      IN	FI_VAT_REPORT_MNG.VAT_REPORT_NM%TYPE        --�ΰ����Ű�Ⱓ���и�     
    , P_REGARD_RATE	        IN	FI_VAT_REPORT_MNG.REGARD_RATE%TYPE	        --�����Ӵ������������        
    , P_CLOSING_YN	        IN	FI_VAT_REPORT_MNG.CLOSING_YN%TYPE	        --��������
    , P_CREATED_BY	        IN	FI_VAT_REPORT_MNG.CREATED_BY%TYPE	        --������
)

AS

V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
t_VAT_MNG_SERIAL    FI_VAT_REPORT_MNG.VAT_MNG_SERIAL%TYPE;

BEGIN

    SELECT NVL(MAX(VAT_MNG_SERIAL), 0) + 1 INTO t_VAT_MNG_SERIAL FROM FI_VAT_REPORT_MNG;   --�Ϸù�ȣ

    INSERT INTO FI_VAT_REPORT_MNG(
          SOB_ID	            --ȸ����̵�
        , ORG_ID	            --����ξ��̵�
        , TAX_CODE            --������ڵ�   
        , VAT_MNG_SERIAL	    --�ΰ����Ű�Ⱓ���й�ȣ        
        , FY	                --ȸ��⵵        
        , VAT_REPORT_TURN	    --�Ű����ڵ�        
        , VAT_REPORT_GB	        --�Ű����ڵ�        
        , TAX_TERM_FR           --�����Ⱓ_����        
        , TAX_TERM_TO	        --�����Ⱓ_����        
        , VAT_REPORT_NM	        --�ΰ����Ű�Ⱓ���и�     
        , REGARD_RATE	        --�����Ӵ������������        
        , CLOSING_YN	        --��������
        , CREATION_DATE         --������
        , CREATED_BY	        --������
        , LAST_UPDATE_DATE      --������
        , LAST_UPDATED_BY	    --������
    )
    VALUES(
          P_SOB_ID	            --ȸ����̵�
        , P_ORG_ID	            --����ξ��̵�
        , P_TAX_CODE            --������ڵ�      
        , t_VAT_MNG_SERIAL	    --�ΰ����Ű�Ⱓ���й�ȣ        
        , P_FY	                --ȸ��⵵        
        , P_VAT_REPORT_TURN	    --�Ű����ڵ�        
        , P_VAT_REPORT_GB	    --�Ű����ڵ�        
        , P_TAX_TERM_FR         --�����Ⱓ_����        
        , P_TAX_TERM_TO	        --�����Ⱓ_����        
        , P_VAT_REPORT_NM	    --�ΰ����Ű�Ⱓ���и�     
        , P_REGARD_RATE	        --�����Ӵ������������        
        , P_CLOSING_YN	        --��������
        , V_SYSDATE             --������
        , P_CREATED_BY	        --������
        , V_SYSDATE             --������
        , P_CREATED_BY	        --������
    );
    
    -- ����ó���� �ΰ��� �Ű��� �������� FLAG UPDATE -- 
    IF P_CLOSING_YN = 'Y' THEN
      BEGIN
        UPDATE FI_SURTAX_CARD SC
           SET SC.CLOSED_FLAG = 'Y'
         WHERE SOB_ID  = P_SOB_ID  --ȸ����̵�
           AND ORG_ID  = P_ORG_ID  --����ξ��̵�
           AND TAX_CODE   = P_TAX_CODE   --�������̵�
           AND VAT_MNG_SERIAL   = t_VAT_MNG_SERIAL      --�ΰ����Ű�Ⱓ���й�ȣ
        ;
     EXCEPTION WHEN OTHERS THEN
       NULL;
     END;
   END IF;
END INSERT_VAT_REPORT_MNG;


--grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_VAT_REPORT_MNG(
      P_SOB_ID	            IN 	FI_VAT_REPORT_MNG.SOB_ID%TYPE	            --ȸ����̵�
    , P_ORG_ID	            IN 	FI_VAT_REPORT_MNG.ORG_ID%TYPE	            --����ξ��̵�
    , P_TAX_CODE            IN 	FI_VAT_REPORT_MNG.TAX_CODE%TYPE           --������ڵ�.
    , P_VAT_MNG_SERIAL      IN 	FI_VAT_REPORT_MNG.VAT_MNG_SERIAL%TYPE       --�ΰ����Ű�Ⱓ���й�ȣ
    , P_FY	                IN 	FI_VAT_REPORT_MNG.FY%TYPE	                --ȸ��⵵        
    , P_VAT_REPORT_TURN	    IN	FI_VAT_REPORT_MNG.VAT_REPORT_TURN%TYPE	    --�Ű����ڵ�        
    , P_VAT_REPORT_GB	      IN	FI_VAT_REPORT_MNG.VAT_REPORT_GB%TYPE	    --�Ű����ڵ�        
    , P_TAX_TERM_FR         IN	FI_VAT_REPORT_MNG.TAX_TERM_FR%TYPE	        --�����Ⱓ_����        
    , P_TAX_TERM_TO	        IN	FI_VAT_REPORT_MNG.TAX_TERM_TO%TYPE	        --�����Ⱓ_����        
    , P_VAT_REPORT_NM	      IN	FI_VAT_REPORT_MNG.VAT_REPORT_NM%TYPE        --�ΰ����Ű�Ⱓ���и�     
    , P_REGARD_RATE	        IN	FI_VAT_REPORT_MNG.REGARD_RATE%TYPE	        --�����Ӵ������������        
    , P_CLOSING_YN	        IN	FI_VAT_REPORT_MNG.CLOSING_YN%TYPE	        --��������
    , P_LAST_UPDATED_BY     IN  FI_VAT_REPORT_MNG.LAST_UPDATED_BY%TYPE       --������
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);

BEGIN

    UPDATE FI_VAT_REPORT_MNG
    SET
          FY	              = P_FY	            --ȸ��⵵    
        , VAT_REPORT_TURN   = P_VAT_REPORT_TURN --�Ű����ڵ�    
        , VAT_REPORT_GB	    = P_VAT_REPORT_GB	--�Ű����ڵ�    
        , TAX_TERM_FR	      = P_TAX_TERM_FR	    --�����Ⱓ_����    
        , TAX_TERM_TO       = P_TAX_TERM_TO	    --�����Ⱓ_����    
        , VAT_REPORT_NM	    = P_VAT_REPORT_NM	--�ΰ����Ű�Ⱓ���и�    
        , REGARD_RATE       = P_REGARD_RATE     --�����Ӵ������������    
        , CLOSING_YN	      = P_CLOSING_YN	    --��������           
        , LAST_UPDATE_DATE  = V_SYSDATE         --������
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY --������
    WHERE   SOB_ID              = P_SOB_ID              --ȸ����̵�
        AND ORG_ID              = P_ORG_ID              --����ξ��̵�
        AND TAX_CODE            = P_TAX_CODE            --������ڵ� 
        AND VAT_MNG_SERIAL      = P_VAT_MNG_SERIAL      --�ΰ����Ű�Ⱓ���й�ȣ
    ;
   
    -- ����ó���� �ΰ��� �Ű��� �������� FLAG UPDATE -- 
    IF P_CLOSING_YN = 'Y' THEN
      BEGIN
        UPDATE FI_SURTAX_CARD SC
           SET SC.CLOSED_FLAG = 'Y'
         WHERE SOB_ID  = P_SOB_ID  --ȸ����̵�
           AND ORG_ID  = P_ORG_ID  --����ξ��̵�
           AND TAX_CODE   = P_TAX_CODE   --�������̵�
           AND VAT_MNG_SERIAL   = P_VAT_MNG_SERIAL      --�ΰ����Ű�Ⱓ���й�ȣ
        ;
     EXCEPTION WHEN OTHERS THEN
       NULL;
     END;
   END IF;
   
END UPDATE_VAT_REPORT_MNG;





--grid�� ��ȸ�� �ڷ� ����
PROCEDURE DELETE_VAT_REPORT_MNG(
      P_SOB_ID	            IN 	FI_VAT_REPORT_MNG.SOB_ID%TYPE	            --ȸ����̵�
    , P_ORG_ID	            IN 	FI_VAT_REPORT_MNG.ORG_ID%TYPE	            --����ξ��̵�
    , P_TAX_CODE            IN 	FI_VAT_REPORT_MNG.TAX_CODE%TYPE           --������ڵ�.    
    , P_VAT_MNG_SERIAL      IN 	FI_VAT_REPORT_MNG.VAT_MNG_SERIAL%TYPE       --�ΰ����Ű�Ⱓ���й�ȣ���й�ȣ
)

AS
  t_CLOSING_YN          VARCHAR2(2);
BEGIN
    t_CLOSING_YN := 'N';         
    BEGIN
      SELECT NVL(RM.CLOSING_YN, 'N') AS CLOSING_YN
        INTO t_CLOSING_YN
        FROM FI_VAT_REPORT_MNG RM
      WHERE   SOB_ID              = P_SOB_ID              --ȸ����̵�
          AND ORG_ID              = P_ORG_ID              --����ξ��̵�
          AND TAX_CODE            = P_TAX_CODE            --������ڵ� 
          AND VAT_MNG_SERIAL      = P_VAT_MNG_SERIAL      --�ΰ����Ű�Ⱓ���й�ȣ
      ;
    EXCEPTION WHEN OTHERS THEN
      t_CLOSING_YN := 'N';  
    END;
    
    DELETE FI_VAT_REPORT_MNG
    WHERE   SOB_ID              = P_SOB_ID              --ȸ����̵�
        AND ORG_ID              = P_ORG_ID              --����ξ��̵�
        AND TAX_CODE            = P_TAX_CODE            --������ڵ� 
        AND VAT_MNG_SERIAL      = P_VAT_MNG_SERIAL      --�ΰ����Ű�Ⱓ���й�ȣ
    ;
   
   -- ����ó���� �ΰ��� �Ű��� �������� FLAG UPDATE -- 
   IF t_CLOSING_YN = 'Y' THEN
     BEGIN
       UPDATE FI_SURTAX_CARD SC
          SET SC.CLOSED_FLAG = 'Y'
        WHERE SOB_ID  = P_SOB_ID  --ȸ����̵�
          AND ORG_ID  = P_ORG_ID  --����ξ��̵�
         AND TAX_CODE   = P_TAX_CODE   --�������̵�
          AND VAT_MNG_SERIAL   = P_VAT_MNG_SERIAL      --�ΰ����Ű�Ⱓ���й�ȣ
       ;
     EXCEPTION WHEN OTHERS THEN
       NULL;
     END;
   END IF;
   
END DELETE_VAT_REPORT_MNG;











--�Ű�Ⱓ���� �� ��ȯ
FUNCTION VAT_MNG_SERIAL_F(
      P_VAT_MNG_SERIAL  IN FI_VAT_REPORT_MNG.VAT_MNG_SERIAL%TYPE    --�ΰ����Ű�Ⱓ���й�ȣ  
) RETURN VARCHAR2

AS

t_VAT_REPORT_NM     FI_VAT_REPORT_MNG.VAT_REPORT_NM%TYPE;    --�ΰ����Ű�Ⱓ���и�

BEGIN

    SELECT VAT_REPORT_NM
    INTO t_VAT_REPORT_NM
    FROM FI_VAT_REPORT_MNG
    WHERE VAT_MNG_SERIAL = P_VAT_MNG_SERIAL ;
            
    RETURN t_VAT_REPORT_NM;


END VAT_MNG_SERIAL_F;



--�Ű�Ⱓ �������� ��ȯ 
FUNCTION VAT_CLOSED_FLAG(
      W_SOB_ID              IN  FI_VAT_REPORT_MNG.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID              IN  FI_VAT_REPORT_MNG.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE            IN  FI_VAT_REPORT_MNG.TAX_CODE%TYPE            --�������̵�(��>110)    
    , W_VAT_MNG_SERIAL      IN  FI_VAT_REPORT_MNG.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ     
) RETURN VARCHAR2
AS
  t_CLOSING_YN          VARCHAR2(2) := 'N';
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
  RETURN t_CLOSING_YN;
EXCEPTION WHEN OTHERS THEN
  t_CLOSING_YN := 'F';
  RETURN t_CLOSING_YN;
END;





END FI_VAT_REPORT_MNG_G;
/
