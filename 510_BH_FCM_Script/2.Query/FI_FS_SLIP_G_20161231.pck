CREATE OR REPLACE PACKAGE FI_FS_SLIP_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FS_SLIP_G
Description  : �繫��ǥ����(�հ��ܾ׽û�ǥ, ������������, ���Ͱ�꼭, �繫����ǥ_�����̿��ݾ� ���ҽ�)���� 
               ��ǥ�� �ٰ����� �ڷ� ���� �� �������� �̿��ϴ� ���� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : ������������, ���Ͱ�꼭, �繫����ǥ�� Package
Program History :

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-08-26   Leem Dong Ern(�ӵ���)          
*****************************************************************************/




--��ǥ�ڷ� ����(�̿� : ������������, ���Ͱ�꼭)
PROCEDURE CREATE_FS_SLIP( 
      P_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE     --ȸ����̵�
    , P_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE     --����ξ��̵�
    , P_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE  --�������ؼ�Ʈ���̵�    
    , P_FORM_TYPE_ID    IN  FI_FORM_MST.FS_SET_ID%TYPE  --�������ID
    , P_ITEM_LEVEL      IN  FI_FORM_MST.ITEM_LEVEL%TYPE --�׸񷹺�
    , P_PERIOD_FROM     IN  DATE    --��ȸ������
    , P_PERIOD_TO       IN  DATE    --��ȸ������
);





--�����̿��ڷ� ����(�繫����ǥ��)
--���� ������ �̿��ݾ��� �����Ѵ�.
PROCEDURE CREATE_FS_SLIP_BLS( 
      P_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE     --ȸ����̵�
    , P_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE     --����ξ��̵�
    , P_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE  --�������ؼ�Ʈ���̵�    
    , P_FORM_TYPE_ID    IN  FI_FORM_MST.FS_SET_ID%TYPE  --�������ID
    , P_ITEM_LEVEL      IN  FI_FORM_MST.ITEM_LEVEL%TYPE --�׸񷹺�
    , P_PERIOD_FROM     IN  VARCHAR2    --��ȸ���س�(��>2011)
);







--�����̿��ڷ� ����(�հ��ܾ׽û�ǥ��)
--����� �̿��ݾ��� �����Ѵ�.
PROCEDURE CREATE_FS_SLIP_BLS_TB( 
      P_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE     --ȸ����̵�
    , P_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE     --����ξ��̵�
    , P_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE  --�������ؼ�Ʈ���̵�    
    , P_FORM_TYPE_ID    IN  FI_FORM_MST.FS_SET_ID%TYPE  --�������ID
    , P_ITEM_LEVEL      IN  FI_FORM_MST.ITEM_LEVEL%TYPE --�׸񷹺�
    , P_PERIOD_FROM     IN  VARCHAR2    --��ȸ���س�(��>2011)
);






END FI_FS_SLIP_G;
/
CREATE OR REPLACE PACKAGE BODY FI_FS_SLIP_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FS_SLIP_G
Description  : �繫��ǥ����(�հ��ܾ׽û�ǥ, ������������, ���Ͱ�꼭, �繫����ǥ_�����̿��ݾ� ���ҽ�)���� 
               ��ǥ�� �ٰ����� �ڷ� ���� �� �������� �̿��ϴ� ���� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : ������������, ���Ͱ�꼭, �繫����ǥ�� Package
Program History :

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-08-26   Leem Dong Ern(�ӵ���)          
*****************************************************************************/



--��ǥ�ڷ� ����
PROCEDURE CREATE_FS_SLIP( 
      P_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE      --ȸ����̵�
    , P_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE      --����ξ��̵�
    , P_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE   --�������ؼ�Ʈ���̵�    
    , P_FORM_TYPE_ID    IN  FI_FORM_MST.FS_SET_ID%TYPE   --�������ID
    , P_ITEM_LEVEL      IN  FI_FORM_MST.ITEM_LEVEL%TYPE  --�׸񷹺�
    , P_PERIOD_FROM     IN  DATE    --��ȸ������
    , P_PERIOD_TO       IN  DATE    --��ȸ������
)

AS
  t_TEMP_AMT            NUMBER := 0;
BEGIN

    --���� �ڷ� ����
    DELETE FI_FS_SLIP;
    

    --���� �ڷ� ����
    INSERT INTO FI_FS_SLIP(
          ITEM_CODE     --�׸��ڵ�_�����ڵ�
        , ACCOUNT_CODE  --�����ڵ�
        , DR_AMT        --�����ݾ�
        , CR_AMT        --�뺯�ݾ�
    )
    SELECT  
          ITEM_CODE	        --�׸��ڵ�_�����ڵ�
        , DET_ITEM_CODE     --���׸��ڵ�
        , 0
        , 0
    FROM FI_FORM_DET A
    WHERE   SOB_ID          = P_SOB_ID
        AND ORG_ID          = P_ORG_ID
        AND FS_SET_ID       = P_FS_SET_ID
        AND FORM_TYPE_ID    = P_FORM_TYPE_ID
        AND ITEM_CODE IN
            (
                SELECT ITEM_CODE      
                FROM FI_FORM_MST
                WHERE   SOB_ID          = P_SOB_ID          --ȸ����̵�
                    AND ORG_ID          = P_ORG_ID          --����ξ��̵�
                    AND FS_SET_ID       = P_FS_SET_ID       --�������ؼ�Ʈ���̵�
                    AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --�������ID(�����ڵ�)
                    AND ITEM_LEVEL      = P_ITEM_LEVEL
            )
    ORDER BY ITEM_CODE, DET_ITEM_CODE;
    

    --�� ������ �����ݾ��� UPDATE�Ѵ�.
    FOR AMT_REC IN (
        SELECT ACCOUNT_CODE, NVL(SUM(GL_AMOUNT), 0) AS AMT
        FROM FI_SLIP_LINE
        WHERE SOB_ID = P_SOB_ID
            AND ORG_ID = P_ORG_ID
            
            --��ǥ�а��ڷῡ�� �ڷ� ���� �� ��ǥ������ '�����ܾ��̿�-BLS'�� '����ü�а�-CRJ'�� �����ϰ� ���Ѵ�.
            AND SLIP_TYPE NOT IN ('BLS', 'CRJ') 
            
            AND ACCOUNT_DR_CR = '1' --���뱸��(1-����,2-�뺯)
            AND GL_DATE BETWEEN P_PERIOD_FROM AND P_PERIOD_TO
            AND ACCOUNT_CODE IN ( SELECT ACCOUNT_CODE FROM FI_FS_SLIP )
        GROUP BY ACCOUNT_CODE
    ) LOOP
        BEGIN
          SELECT NVL(SUM(GL_AMOUNT), 0) AS AMT
            INTO t_TEMP_AMT
            FROM FI_SLIP_LINE
            WHERE SOB_ID          = P_SOB_ID
                AND ORG_ID        = P_ORG_ID
                
                --��ǥ�а��ڷῡ�� �ڷ� ���� �� ��ǥ������ '�����ܾ��̿�-BLS'�� '����ü�а�-CRJ'�� �����ϰ� ���Ѵ�.
                AND GL_NUM        = 'CL-20161231-00014'
                AND ACCOUNT_DR_CR = '1' --���뱸��(1-����,2-�뺯)
                AND GL_DATE       BETWEEN P_PERIOD_FROM AND P_PERIOD_TO
                AND ACCOUNT_CODE  = AMT_REC.ACCOUNT_CODE 
            ;
        EXCEPTION
          WHEN OTHERS THEN
            t_TEMP_AMT := 0;
        END;
        
        UPDATE FI_FS_SLIP
        SET DR_AMT = NVL(AMT_REC.AMT,0) + NVL(t_TEMP_AMT,0) 
        WHERE ACCOUNT_CODE = AMT_REC.ACCOUNT_CODE   ;

    END LOOP AMT_REC;      
    
    
    --�� ������ �뺯�ݾ��� UPDATE�Ѵ�.
    FOR AMT_REC IN (
        SELECT ACCOUNT_CODE, NVL(SUM(GL_AMOUNT), 0) AS AMT
        FROM FI_SLIP_LINE
        WHERE SOB_ID = P_SOB_ID
            AND ORG_ID = P_ORG_ID
            
            --��ǥ�а��ڷῡ�� �ڷ� ���� �� ��ǥ������ '�����ܾ��̿�-BLS'�� '����ü�а�-CRJ'�� �����ϰ� ���Ѵ�.
            AND SLIP_TYPE NOT IN ('BLS', 'CRJ') 
            
            AND ACCOUNT_DR_CR = '2' --���뱸��(1-����,2-�뺯)
            AND GL_DATE BETWEEN P_PERIOD_FROM AND P_PERIOD_TO
            AND ACCOUNT_CODE IN ( SELECT ACCOUNT_CODE FROM FI_FS_SLIP )
        GROUP BY ACCOUNT_CODE
    ) LOOP

        UPDATE FI_FS_SLIP
        SET CR_AMT = AMT_REC.AMT
        WHERE ACCOUNT_CODE = AMT_REC.ACCOUNT_CODE   ;

    END LOOP AMT_REC;      


    
    
    EXCEPTION
        WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');  

END CREATE_FS_SLIP;






--�����̿��ڷ� ����(�繫����ǥ��)
--���� ������ �̿��ݾ��� �����Ѵ�.
PROCEDURE CREATE_FS_SLIP_BLS( 
      P_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE     --ȸ����̵�
    , P_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE     --����ξ��̵�
    , P_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE  --�������ؼ�Ʈ���̵�    
    , P_FORM_TYPE_ID    IN  FI_FORM_MST.FS_SET_ID%TYPE  --�������ID
    , P_ITEM_LEVEL      IN  FI_FORM_MST.ITEM_LEVEL%TYPE --�׸񷹺�
    , P_PERIOD_FROM     IN  VARCHAR2    --��ȸ���س�(��>2011)
)

AS

BEGIN

    --���� �ڷ� ����
    DELETE FI_FS_SLIP;
    

    --���� �ڷ� ����
    INSERT INTO FI_FS_SLIP(
          ITEM_CODE     --�׸��ڵ�_�����ڵ�
        , ACCOUNT_CODE  --�����ڵ�
        , DR_AMT        --���(��>2011)�� �����̿��ݾ�
        , CR_AMT        --����(��>2010)�� �����̿��ݾ�
    )
    SELECT  
          ITEM_CODE	        --�׸��ڵ�_�����ڵ�
        , DET_ITEM_CODE     --���׸��ڵ�
        , 0
        , 0
    FROM FI_FORM_DET A
    WHERE   SOB_ID          = P_SOB_ID
        AND ORG_ID          = P_ORG_ID
        AND FS_SET_ID       = P_FS_SET_ID
        AND FORM_TYPE_ID    = P_FORM_TYPE_ID
        AND ITEM_CODE IN
            (
                SELECT ITEM_CODE      
                FROM FI_FORM_MST
                WHERE   SOB_ID          = P_SOB_ID          --ȸ����̵�
                    AND ORG_ID          = P_ORG_ID          --����ξ��̵�
                    AND FS_SET_ID       = P_FS_SET_ID       --�������ؼ�Ʈ���̵�
                    AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --�������ID(�����ڵ�)
                    AND ITEM_LEVEL      = P_ITEM_LEVEL
            )
    ORDER BY ITEM_CODE, DET_ITEM_CODE;
    
    --���(��>2011)�� �����̿��ݾ��� �����Ѵ�.
    FOR AMT_REC IN (
        SELECT ACCOUNT_CODE, NVL(SUM(GL_AMOUNT), 0) AS AMT
        FROM FI_SLIP_LINE
        WHERE SOB_ID = P_SOB_ID
            AND ORG_ID = P_ORG_ID
            AND SLIP_TYPE LIKE 'BLS%'
            AND GL_DATE = TRUNC(TO_DATE(P_PERIOD_FROM, 'YYYY'), 'YEAR')
            AND ACCOUNT_CODE IN (   SELECT ACCOUNT_CODE FROM FI_FS_SLIP    )
        GROUP BY ACCOUNT_CODE
    ) LOOP

        UPDATE FI_FS_SLIP
        SET DR_AMT = AMT_REC.AMT
        WHERE ACCOUNT_CODE = AMT_REC.ACCOUNT_CODE   ;

    END LOOP AMT_REC;
    
    
    --����(��>2010)�� �����̿��ݾ��� �����Ѵ�.
    FOR AMT_REC IN (
        SELECT ACCOUNT_CODE, NVL(SUM(GL_AMOUNT), 0) AS AMT
        FROM FI_SLIP_LINE
        WHERE SOB_ID = P_SOB_ID
            AND ORG_ID = P_ORG_ID
            AND SLIP_TYPE LIKE 'BLS%'
            AND GL_DATE = TRUNC(TO_DATE(P_PERIOD_FROM - 1, 'YYYY'), 'YEAR')
            AND ACCOUNT_CODE IN (   SELECT ACCOUNT_CODE FROM FI_FS_SLIP    )
        GROUP BY ACCOUNT_CODE
    ) LOOP

        UPDATE FI_FS_SLIP
        SET CR_AMT = AMT_REC.AMT
        WHERE ACCOUNT_CODE = AMT_REC.ACCOUNT_CODE   ;

    END LOOP AMT_REC;    
 
    
    EXCEPTION
        WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');  

END CREATE_FS_SLIP_BLS;










--�����̿��ڷ� ����(�հ��ܾ׽û�ǥ��)
--����� �̿��ݾ��� �����Ѵ�.
PROCEDURE CREATE_FS_SLIP_BLS_TB( 
      P_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE     --ȸ����̵�
    , P_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE     --����ξ��̵�
    , P_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE  --�������ؼ�Ʈ���̵�    
    , P_FORM_TYPE_ID    IN  FI_FORM_MST.FS_SET_ID%TYPE  --�������ID
    , P_ITEM_LEVEL      IN  FI_FORM_MST.ITEM_LEVEL%TYPE --�׸񷹺�
    , P_PERIOD_FROM     IN  VARCHAR2    --��ȸ���س�(��>2011)
)

AS

BEGIN

    --���� �ڷ� ����
    DELETE FI_FS_SLIP;
    

    --���� �ڷ� ����
    INSERT INTO FI_FS_SLIP(
          ITEM_CODE     --�׸��ڵ�_�����ڵ�
        , ACCOUNT_CODE  --�����ڵ�
        , DR_AMT        --���(��>2011)�� �����̿��ݾ�
    )
    SELECT  
          ITEM_CODE	        --�׸��ڵ�_�����ڵ�
        , DET_ITEM_CODE     --���׸��ڵ�
        , 0
    FROM FI_FORM_DET A
    WHERE   SOB_ID          = P_SOB_ID
        AND ORG_ID          = P_ORG_ID
        AND FS_SET_ID       = P_FS_SET_ID
        AND FORM_TYPE_ID    = P_FORM_TYPE_ID
        AND ITEM_CODE IN
            (
                SELECT ITEM_CODE      
                FROM FI_FORM_MST
                WHERE   SOB_ID          = P_SOB_ID          --ȸ����̵�
                    AND ORG_ID          = P_ORG_ID          --����ξ��̵�
                    AND FS_SET_ID       = P_FS_SET_ID       --�������ؼ�Ʈ���̵�
                    AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --�������ID(�����ڵ�)
                    AND ITEM_LEVEL      = P_ITEM_LEVEL
            )
    ORDER BY ITEM_CODE, DET_ITEM_CODE;
    
    --���(��>2011)�� �����̿��ݾ��� �����Ѵ�.
    FOR AMT_REC IN (
        SELECT ACCOUNT_CODE, NVL(SUM(GL_AMOUNT), 0) AS AMT
        FROM FI_SLIP_LINE
        WHERE SOB_ID = P_SOB_ID
            AND ORG_ID = P_ORG_ID
            AND SLIP_TYPE LIKE 'BLS%'
            AND GL_DATE = TRUNC(TO_DATE(P_PERIOD_FROM, 'YYYY'), 'YEAR')
            AND ACCOUNT_CODE IN (   SELECT ACCOUNT_CODE FROM FI_FS_SLIP    )
        GROUP BY ACCOUNT_CODE
    ) LOOP

        UPDATE FI_FS_SLIP
        SET DR_AMT = AMT_REC.AMT
        WHERE ACCOUNT_CODE = AMT_REC.ACCOUNT_CODE   ;

    END LOOP AMT_REC;   
 
    
    EXCEPTION
        WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');  

END CREATE_FS_SLIP_BLS_TB;




END FI_FS_SLIP_G;
/
