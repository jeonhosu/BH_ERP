CREATE OR REPLACE PACKAGE FI_FORWARD_AMT_G
AS



/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FORWARD_AMT_G
Description  : �⸻�����̿��۾� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : 
Program History : �繫����ǥ�� �ݾ��� ����� �̿��� �ݾ��̴�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-12-16   Leem Dong Ern(�ӵ���)          
*****************************************************************************/




--�̿������ڷ����
PROCEDURE CREATE_FORWARD_AMT(
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --ȸ����̵�
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --����ξ��̵�
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --�����̿��⵵
    --, W_DEPT_ID         IN FI_FORWARD_AMT.DEPT_ID%TYPE      --���Ǻμ�
    , W_USER_ID       IN FI_FORWARD_AMT.PERSON_ID%TYPE    --������
    
    , O_MESSAGE         OUT VARCHAR2    --�����̿����� ��� �޽����� ȭ������ ��ȯ�Ѵ�.
);




--�����׸���� ������ �� �ִ� �����׸����� ���θ� �ľ��Ͽ� �ش��ϴ� �׸�� ���й��ڸ� �ѱ��.
--�� PROCEDURE�� [�����׸񺰿�����ȸ : FI_MANAGEMENT_LEDGER_G > UPD_MANAGEMENT_NM] ���α׷��� ���� ������ ���̴�.
--CREATE_FORWARD_AMT PROCEDURE���� ���������� ����Ѵ�.
FUNCTION MANAGEMENT_UPD_YN_F( 
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --ȸ����̵�
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --����ξ��̵�
    , W_COMMON_ID       IN FI_COMMON.COMMON_ID%TYPE         --�����ڵ� ID
) RETURN VARCHAR2;




--�����׸�� ����
--�� PROCEDURE�� [�����׸񺰿�����ȸ : FI_MANAGEMENT_LEDGER_G > UPD_MANAGEMENT_NM] ���α׷��� ���� ������ ���̴�.
--CREATE_FORWARD_AMT PROCEDURE���� ���������� ����Ѵ�.
PROCEDURE UPD_MANAGEMENT_NM(
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --ȸ����̵�
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --����ξ��̵�
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --�����̿��⵵
    
    --�����������̵�; �����ڵ带 ����ϴ� �Ͱ� ������ �;ȵ� ���ǻ� ���̵� �̿����� ���̴�.
    , W_ACCOUNT_CONTROL_ID  IN FI_FORWARD_AMT.ACCOUNT_CONTROL_ID%TYPE --�����������̵�
    
    , W_COLUMN              IN  VARCHAR2    --������ Į����
    , W_MANAGEMENT_GUBUN    IN  VARCHAR2    --�� �׸� �ִ� ���� �̿��Ͽ� [�����׸�_��]�� ���Ѵ�.
);









--�����̿��ݾ� ��ȸ(������)
PROCEDURE LIST_FORWARD_AMT_MST( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --ȸ����̵�
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --����ξ��̵�
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --�����̿��⵵
);





--�����̿��ݾ� ��ȸ(���׸�)
PROCEDURE LIST_FORWARD_AMT_DET( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --ȸ����̵�
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --����ξ��̵�
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --�����̿��⵵
);





--�����̿�����
--��ǥ ���̺� �����̿��ݾ��� INSERT�ϴ� ���̴�.
--��ǥ���� : BLS(�����ܾ�)

--����>��ǥ���̺� �ڷ� INSERT�ϴ� �Ϳ� ���� �ּ�
--�ϱ��� �Ϲ����� ��ǥ���� ����� ��������ǥ�����ϴ� �� ���� �����ϸ� �ȴ�.
--�Ϲ����� ��ǥ���� ����� �� �����̿��ڷḦ ��ǥ���̺� INSERT �ϴ� ������� �ణ�� ���� ���̰� �ִ�.
--�Ϲ����� ��ǥ �����ÿ��� ���ռ� üũ�� ���� FI_SLIP_G.INSERT_SLIP_HEADER �Ǵ� FI_SLIP_G.INSERT_SLIP_LINE�� PROCEDURE��
--ȣ��������, �����̿��ڷ� �����ÿ��� ��ǥ�� �ƴϱ⿡ ��ǥ���� 2 ���̺� �ش� �ڷḦ ���� INSERT�Ѵ�.
PROCEDURE CREATE_FORWARD_SLIP( 
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --ȸ����̵�
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --����ξ��̵�
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --�����̿��⵵
    
    , O_MESSAGE         OUT VARCHAR2    --�����̿����� ��� �޽����� ȭ������ ��ȯ�Ѵ�.
);






--��ǥ���̺�(FI_SLIP_HEADER, FI_SLIP_LINE)�� ��ϵ� �����̿��ڷ����
--����>�� ������ �� ������ ���� ������ �̿��ڷḸ�� �����Ѵ�. 
--�࿩ �� ������ �ƴ� �ٸ� ���(������ �ִ� �����ܾ׵�� ���α׷��� �̿�)���� �߰��� �̿��ڷ�� �������� �ʴ´�.
PROCEDURE DELETE_FORWARD_SLIP( 
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --ȸ���̵�
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --����ξ��̵�
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --�����̿��⵵
    , W_GL_NUM          IN FI_FORWARD_AMT.GL_NUM%TYPE       --ȸ���ȣ
    
    , O_MESSAGE         OUT VARCHAR2    --�����̿����� ��� �޽����� ȭ������ ��ȯ�Ѵ�.
);







END FI_FORWARD_AMT_G;
/
CREATE OR REPLACE PACKAGE BODY FI_FORWARD_AMT_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FORWARD_AMT_G
Description  : �⸻�����̿��۾� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : 
Program History : �繫����ǥ�� �ݾ��� ����� �̿��� �ݾ��̴�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-12-16   Leem Dong Ern(�ӵ���)          
*****************************************************************************/





--�̿������ڷ����
PROCEDURE CREATE_FORWARD_AMT(
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --ȸ����̵�
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --����ξ��̵�
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --�����̿��⵵
    --, W_DEPT_ID         IN FI_FORWARD_AMT.DEPT_ID%TYPE      --���Ǻμ�
    , W_USER_ID       IN FI_FORWARD_AMT.PERSON_ID%TYPE    --������
    
    , O_MESSAGE         OUT VARCHAR2    --�����̿����� ��� �޽����� ȭ������ ��ȯ�Ѵ�.
)


AS

REC_CREATE  EXCEPTION;


t_DEPT_ID       NUMBER; --���Ǻμ�
t_PERSON_ID     NUMBER; --������

V_SYSDATE       DATE := GET_LOCAL_DATE(W_SOB_ID);   --��������

t_ACCOUNT_CONTROL_ID    FI_FORWARD_AMT.ACCOUNT_CONTROL_ID%TYPE;	    --�����������̵�

t_REFER1_ID     FI_ACCOUNT_CONTROL.REFER1_ID%TYPE;	    --�����׸���̵�1
t_REFER2_ID     FI_ACCOUNT_CONTROL.REFER2_ID%TYPE;	    --�����׸���̵�2
t_REFER3_ID     FI_ACCOUNT_CONTROL.REFER3_ID%TYPE;	    --�����׸���̵�3
t_REFER4_ID     FI_ACCOUNT_CONTROL.REFER4_ID%TYPE;	    --�����׸���̵�4
t_REFER5_ID     FI_ACCOUNT_CONTROL.REFER5_ID%TYPE;	    --�����׸���̵�5
t_REFER6_ID     FI_ACCOUNT_CONTROL.REFER6_ID%TYPE;	    --�����׸���̵�6
t_REFER7_ID     FI_ACCOUNT_CONTROL.REFER7_ID%TYPE;	    --�����׸���̵�7
t_REFER8_ID     FI_ACCOUNT_CONTROL.REFER8_ID%TYPE;	    --�����׸���̵�8
t_REFER9_ID     FI_ACCOUNT_CONTROL.REFER9_ID%TYPE;	    --�����׸���̵�9
t_REFER10_ID    FI_ACCOUNT_CONTROL.REFER10_ID%TYPE;	--�����׸���̵�10
t_REFER11_ID    FI_ACCOUNT_CONTROL.REFER11_ID%TYPE;	--�����׸���̵�11
t_REFER12_ID    FI_ACCOUNT_CONTROL.REFER12_ID%TYPE;	--�����׸���̵�12
t_REFER13_ID    FI_ACCOUNT_CONTROL.REFER13_ID%TYPE;	--�����׸���̵�13
t_REFER14_ID    FI_ACCOUNT_CONTROL.REFER14_ID%TYPE;	--�����׸���̵�14
t_REFER15_ID    FI_ACCOUNT_CONTROL.REFER15_ID%TYPE;	--�����׸���̵�15 

t_MANAGEMENT_GUBUN  FI_COMMON.CODE_NAME%TYPE;	--�����ڵ�� 


--�Ʒ� �������� ��ó�������׿��� ���� ���� ������ �ÿ� ����Ѵ�.
TYPE TCURSOR IS REF CURSOR;
IS_TCURSOR TCURSOR;

t_THIS_NON_LAST_AMT     NUMBER  := 0;   --��������

t_CNT NUMBER  := 0;   --�̿������׿��� �ڷ� �ľ�


BEGIN



    --�����̿��ڷᰡ �̹� �����Ǿ� �ִٸ� �̿������ڷḦ ������ �� ����.
    --�����̿��ڷᰡ �̹� �����Ǿ� �ִ����� �ľ��Ѵ�.
    --�����̿��� �ڷῡ ��ǥ��ȣ�� �ִٴ� ���� �� ���ν����� ������ ��� �����̿��ڷᰡ �̹� �����Ǿ��ٴ� ���̴�.
    BEGIN
      SELECT COUNT(*)
      INTO t_CNT
      FROM FI_FORWARD_AMT
      WHERE SOB_ID = W_SOB_ID
          AND ORG_ID = W_ORG_ID
          AND FORWARD_YEAR = W_FORWARD_YEAR
          AND GL_NUM IS NOT NULL  ;
    EXCEPTION WHEN OTHERS THEN
      t_CNT := 0;
    END;


        
    IF t_CNT > 0 THEN
        --FCM_10430 : �� ������ �����̿� �ڷḦ ���� �� �۾��ٶ��ϴ�.
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10430', NULL); 
        RETURN;
        --FCM_10430 : �� ������ �����̿� �ڷḦ ���� �� �۾��ٶ��ϴ�.
        --O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10430', NULL);      
    END IF;




    --�����̿��Ϸ��� �⵵�� ���� �ڷḦ �����Ѵ�.
    DELETE FI_FORWARD_AMT
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FORWARD_YEAR = W_FORWARD_YEAR
    ;


--�� ������ �Ʒ� 1, 2���� ���� ����Ǵ� ������ ���ϱ� ���� �� �����̴�.
/*

SELECT
      ACCOUNT_CODE  --�����ڵ�
    , ACCOUNT_DESC  --������
    , ACCOUNT_DR_CR --���뱸��(0-��, 1-��)
    , ACCOUNT_CLASS_CODE    --����Ÿ��_�ڵ�
    , ACCOUNT_CLASS         --����Ÿ��_��
FROM
    (
        SELECT
              A.DET_ITEM_CODE AS ACCOUNT_CODE   --���׸��ڵ�  
            , C.ACCOUNT_DESC
            , C.ACCOUNT_DR_CR
            , CASE
                WHEN ( SELECT CODE FROM FI_COMMON WHERE COMMON_ID = C.ACCOUNT_CLASS_ID ) 
                        IN ('140', '150', '160', '170', '180') 
                        THEN ( SELECT CODE FROM FI_COMMON WHERE COMMON_ID = C.ACCOUNT_CLASS_ID ) 
                ELSE NULL
              END AS ACCOUNT_CLASS_CODE
            , FI_COMMON_G.ID_NAME_F(
                CASE
                    WHEN ( SELECT CODE FROM FI_COMMON WHERE COMMON_ID = C.ACCOUNT_CLASS_ID ) 
                        IN ('140', '150', '160', '170', '180') THEN C.ACCOUNT_CLASS_ID
                    ELSE NULL
                END
              ) AS ACCOUNT_CLASS    --����Ÿ��
        FROM FI_FORM_DET A, FI_FORM_MST B, 
            ( SELECT * FROM FI_ACCOUNT_CONTROL WHERE SOB_ID = 10 AND ORG_ID = 101) C
        WHERE B.SOB_ID = 10
            AND B.ORG_ID = 101
            AND B.FS_SET_ID = 1674  --�繫��ǥ��ļ�Ʈ
            AND B.FORM_TYPE_ID = 745    --�������
            AND B.ITEM_LEVEL = 
                    (
                        SELECT MAX(ITEM_LEVEL)
                        FROM FI_FORM_MST
                        WHERE SOB_ID = 10
                            AND ORG_ID = 101
                            AND FS_SET_ID = 1674  --�繫��ǥ��ļ�Ʈ
                            AND FORM_TYPE_ID = 745    --�������            
                    )    
            
            AND B.SOB_ID = A.SOB_ID(+)
            AND B.ORG_ID = A.ORG_ID(+)
            AND B.FS_SET_ID = A.FS_SET_ID(+)
            AND B.FORM_TYPE_ID = A.FORM_TYPE_ID(+)
            
            AND B.ITEM_CODE = A.ITEM_CODE
            AND A.DET_ITEM_CODE = C.ACCOUNT_CODE
    )
WHERE ACCOUNT_CLASS_CODE IS NULL 
    AND ACCOUNT_CODE NOT IN ('1111700', '2100700')
    OR ACCOUNT_CLASS_CODE != '150'
--����Ÿ���� [�����̿��� �ͼӰ���]�� ������ [�����̿��� ��ǥ����]���� �����Ǿ� �̿��ǹǷ� �̿��ڷῡ�� ������ ���̴�.
--���� [�ΰ���������, �ΰ�����ޱ�]�� �̿��� �ܾ��� ���� �� �� ���� �����ε�, �̿��� �� ������ �����׸����� ������ 
--�� ���� �����Ƿ� �����ߴ�.
ORDER BY ACCOUNT_CODE
*/



    --���Ǻμ�, ������ ����
    --�Ʒ��� SELECT������ ������ ������ ������ ������ �ִ� QUERY�� �״�� ����ߴ�.
    BEGIN
        SELECT EU.PERSON_ID, DM.M_DEPT_ID
        INTO t_PERSON_ID, t_DEPT_ID
        FROM EAPP_USER EU
          , HRM_PERSON_MASTER PM
          , HRM_DEPT_MAPPING DM
        WHERE EU.PERSON_ID  = PM.PERSON_ID(+)
        AND PM.DEPT_ID      = DM.HR_DEPT_ID(+)
        AND EU.USER_ID      = W_USER_ID
        AND EU.SOB_ID       = W_SOB_ID
        ;
    EXCEPTION 
        WHEN OTHERS THEN
            NULL;
    END;



--1.�Ϲ����� ���
  BEGIN
    INSERT INTO FI_FORWARD_AMT(
          FORWARD_YEAR	        --�����̿��⵵
        , SOB_ID	            --ȸ����̵�
        , ORG_ID	            --����ξ��̵�
        --, SLIP_HEADER_ID	    --��ǥ������̵�
        , GL_DATE	            --ȸ������
        --, GL_NUM	            --ȸ���ȣ
        , DEPT_ID	            --���Ǻμ�
        , PERSON_ID	            --������
        , SLIP_TYPE	            --��ǥ����
        , ACCOUNT_CONTROL_ID    --�����������̵�
        , ACCOUNT_CODE	        --�����ڵ�
        , ACCOUNT_DR_CR	        --���뱸��(0-��, 1-��)
        , GL_AMOUNT	            --�̿��ݾ�
        , CURRENCY_CODE	        --��ȭ
        , EXCHANGE_RATE	        --ȯ��
        , GL_CURRENCY_AMOUNT	--��ȭ�ݾ�
        , MANAGEMENT1	        --�����׸�1
        , MANAGEMENT2	        --�����׸�2
        , REFER1	            --�����׸�3
        , REFER2	            --�����׸�4
        , REFER3	            --�����׸�5
        , REFER4	            --�����׸�6
        , REFER5	            --�����׸�7
        , REFER6	            --�����׸�8
        , REFER7	            --�����׸�9
        , REFER8	            --�����׸�10
        , REFER9	            --�����׸�11
        , REFER10	            --�����׸�12
        , REFER11	            --�����׸�13
        , REFER12	            --�����׸�14
        , REFER13	            --�����׸�15
        , REMARK	            --����
        , CREATION_DATE	        --������
        , CREATED_BY	        --������
        , LAST_UPDATE_DATE	    --������
        , LAST_UPDATED_BY	    --������    
    )
    SELECT
          W_FORWARD_YEAR AS FORWARD_YEAR    --�����̿��⵵
        , W_SOB_ID AS SOB_ID    --ȸ����̵�
        , W_ORG_ID AS ORG_ID    --����ξ��̵�
        , TO_DATE(W_FORWARD_YEAR + 1 || '0101') AS GL_DATE  --ȸ������
        , t_DEPT_ID --���Ǻμ�
        , t_PERSON_ID AS PERSON_ID  --������
        , 'BLS' AS SLIP_TYPE    --��ǥ����(�����ܾ�)
        , MIN(B.ACCOUNT_CONTROL_ID) AS ACCOUNT_CONTROL_ID   --�����������̵�
        , A.ACCOUNT_CODE    --�����ڵ�
        , MIN(B.ACCOUNT_DR_CR) AS ACCOUNT_DR_CR --���뱸��(0-��, 1-��)
        
        , CASE MIN(B.ACCOUNT_DR_CR)  --������ ���뱸�� �Ӽ���
            WHEN '1' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) --�����̸�
            WHEN '2' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) --�뺯�̸�
          END REMAIN_AMT    --�̿��ݾ�
          
        , 'KRW' AS CURRENCY_CODE --��ȭ
        , 0 AS EXCHANGE_RATE    --ȯ��
        , 0 AS GL_CURRENCY_AMOUNT   --��ȭ�ݾ�
        , A.MANAGEMENT1 --�����׸�1
        , A.MANAGEMENT2 --�����׸�2
        , A.REFER1  --�����׸�3
        , A.REFER2  --�����׸�4
        , A.REFER3  --�����׸�5
        , A.REFER4  --�����׸�6
        , A.REFER5  --�����׸�7
        , A.REFER6  --�����׸�8
        , A.REFER7  --�����׸�9
        , A.REFER8  --�����׸�10
        , A.REFER9  --�����׸�11
        , A.REFER10 --�����׸�12
        , A.REFER11 --�����׸�13
        , A.REFER12 --�����׸�14
        , A.REFER13 --�����׸�15
        , W_FORWARD_YEAR || '�⵵ �⸻�ܾ� �����̿� [' || A.ACCOUNT_CODE || '-' || MIN(B.ACCOUNT_DESC) || ' ]' AS REMARK  --����
        , V_SYSDATE AS CREATION_DATE	--������
        , t_PERSON_ID AS CREATED_BY	--������
        , V_SYSDATE AS LAST_UPDATE_DATE	--������
        , t_PERSON_ID AS LAST_UPDATED_BY	--������ 
    FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID
        AND A.GL_DATE BETWEEN TO_DATE(W_FORWARD_YEAR || '01', 'YYYYMM') AND LAST_DAY(TO_DATE(W_FORWARD_YEAR || '12', 'YYYYMM'))

        --�� ���� �ּ����� ó���� ������ ���� �������� ������ �׽�Ʈ�� �� �ʿ䰡 ���� ��츦 ����ϱ� �����̴�.
        --AND A.ACCOUNT_CODE = '1110900'            
        AND A.ACCOUNT_CODE IN
            (
                SELECT ACCOUNT_CODE  --�����ڵ�
                FROM
                    (   --�⺻����̴�.
                        SELECT
                              A.DET_ITEM_CODE AS ACCOUNT_CODE   --���׸��ڵ�  
                            , C.ACCOUNT_DESC
                            , CASE
                                WHEN ( SELECT CODE FROM FI_COMMON WHERE COMMON_ID = C.ACCOUNT_CLASS_ID ) 
                                        IN ('140', '150', '160', '170', '180') 
                                        THEN ( SELECT CODE FROM FI_COMMON WHERE COMMON_ID = C.ACCOUNT_CLASS_ID ) 
                                ELSE NULL
                              END AS ACCOUNT_CLASS_CODE
                            , FI_COMMON_G.ID_NAME_F(
                                CASE
                                    WHEN ( SELECT CODE FROM FI_COMMON WHERE COMMON_ID = C.ACCOUNT_CLASS_ID ) 
                                        IN ('140', '150', '160', '170', '180') THEN C.ACCOUNT_CLASS_ID
                                    ELSE NULL
                                END
                              ) AS ACCOUNT_CLASS    --����Ÿ��
                        FROM FI_FORM_DET A, FI_FORM_MST B, 
                            ( SELECT * FROM FI_ACCOUNT_CONTROL WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID) C
                        WHERE B.SOB_ID = W_SOB_ID
                            AND B.ORG_ID = W_ORG_ID
                            AND B.FS_SET_ID = 1674  --�繫��ǥ��ļ�Ʈ(K-GAAP)
                            AND B.FORM_TYPE_ID = 745    --�������(�繫����ǥ)
                            AND B.ITEM_LEVEL = 
                                    (
                                        SELECT MAX(ITEM_LEVEL)
                                        FROM FI_FORM_MST
                                        WHERE SOB_ID = W_SOB_ID
                                            AND ORG_ID = W_ORG_ID
                                            AND FS_SET_ID = 1674  --�繫��ǥ��ļ�Ʈ(K-GAAP)
                                            AND FORM_TYPE_ID = 745    --�������(�繫����ǥ)            
                                    )    
                            
                            AND B.SOB_ID = A.SOB_ID(+)
                            AND B.ORG_ID = A.ORG_ID(+)
                            AND B.FS_SET_ID = A.FS_SET_ID(+)
                            AND B.FORM_TYPE_ID = A.FORM_TYPE_ID(+)
                            
                            AND B.ITEM_CODE = A.ITEM_CODE
                            AND A.DET_ITEM_CODE = C.ACCOUNT_CODE
                    )
                WHERE ACCOUNT_CLASS_CODE IS NULL                
                    AND ACCOUNT_CODE NOT IN ('1111700', '2100700')  --[�ΰ���������, �ΰ�����ޱ�] ��������       
            )
              
        AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    GROUP BY A.ACCOUNT_CODE
        , A.MANAGEMENT1
        , A.MANAGEMENT2
        , A.REFER1
        , A.REFER2
        , A.REFER3
        , A.REFER4
        , A.REFER5
        , A.REFER6
        , A.REFER7
        , A.REFER8
        , A.REFER9
        , A.REFER10
        , A.REFER11
        , A.REFER12
        , A.REFER13        
    ;   
  EXCEPTION WHEN OTHERS THEN
            ROLLBACK;

            --FCM_10433 : �̿������ڷ� �����۾� �� ������ �߻��߽��ϴ�.
            O_MESSAGE := '1.' || SQLERRM;
            RETURN;
  END;


--2.Ư���� ���[����Ÿ���� �ִ� ���]

--2-1. 160 : �����̿��� �ܾ׸�
  BEGIN
    INSERT INTO FI_FORWARD_AMT(
          FORWARD_YEAR	        --�����̿��⵵
        , SOB_ID	            --ȸ����̵�
        , ORG_ID	            --����ξ��̵�
        --, SLIP_HEADER_ID	    --��ǥ������̵�
        , GL_DATE	            --ȸ������
        --, GL_NUM	            --ȸ���ȣ
        , DEPT_ID	            --���Ǻμ�
        , PERSON_ID	            --������
        , SLIP_TYPE	            --��ǥ����
        , ACCOUNT_CONTROL_ID    --�����������̵�
        , ACCOUNT_CODE	        --�����ڵ�
        , ACCOUNT_DR_CR	        --���뱸��(0-��, 1-��)
        , GL_AMOUNT	            --�̿��ݾ�
        , CURRENCY_CODE	        --��ȭ
        , EXCHANGE_RATE	        --ȯ��
        , GL_CURRENCY_AMOUNT	--��ȭ�ݾ�
        , MANAGEMENT1	        --�����׸�1
        , MANAGEMENT2	        --�����׸�2
        , REFER1	            --�����׸�3
        , REFER2	            --�����׸�4
        , REFER3	            --�����׸�5
        , REFER4	            --�����׸�6
        , REFER5	            --�����׸�7
        , REFER6	            --�����׸�8
        , REFER7	            --�����׸�9
        , REFER8	            --�����׸�10
        , REFER9	            --�����׸�11
        , REFER10	            --�����׸�12
        , REFER11	            --�����׸�13
        , REFER12	            --�����׸�14
        , REFER13	            --�����׸�15
        , REMARK	            --����
        , CREATION_DATE	        --������
        , CREATED_BY	        --������
        , LAST_UPDATE_DATE	    --������
        , LAST_UPDATED_BY	    --������    
    )
    SELECT
          W_FORWARD_YEAR AS FORWARD_YEAR    --�����̿��⵵
        , W_SOB_ID AS SOB_ID    --ȸ����̵�
        , W_ORG_ID AS ORG_ID    --����ξ��̵�
        , TO_DATE(W_FORWARD_YEAR + 1 || '0101') AS GL_DATE  --ȸ������
        , t_DEPT_ID --���Ǻμ�
        , t_PERSON_ID AS PERSON_ID  --������
        , 'BLS' AS SLIP_TYPE    --��ǥ����(�����ܾ�)
        , MIN(B.ACCOUNT_CONTROL_ID) AS ACCOUNT_CONTROL_ID   --�����������̵�
        , A.ACCOUNT_CODE    --�����ڵ�
        , MIN(B.ACCOUNT_DR_CR) AS ACCOUNT_DR_CR --���뱸��(0-��, 1-��)
        
        , CASE MIN(B.ACCOUNT_DR_CR)  --������ ���뱸�� �Ӽ���
            WHEN '1' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) --�����̸�
            WHEN '2' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) --�뺯�̸�
          END REMAIN_AMT    --�̿��ݾ�
          
        , 'KRW' AS CURRENCY_CODE --��ȭ
        , 0 AS EXCHANGE_RATE    --ȯ��
        , 0 AS GL_CURRENCY_AMOUNT   --��ȭ�ݾ�
        
        , NULL AS MANAGEMENT1 --�����׸�1
        , NULL AS MANAGEMENT2 --�����׸�2
        , NULL AS REFER1  --�����׸�3
        , NULL AS REFER2  --�����׸�4
        , NULL AS REFER3  --�����׸�5
        , NULL AS REFER4  --�����׸�6
        , NULL AS REFER5  --�����׸�7
        , NULL AS REFER6  --�����׸�8
        , NULL AS REFER7  --�����׸�9
        , NULL AS REFER8  --�����׸�10
        , NULL AS REFER9  --�����׸�11
        , NULL AS REFER10 --�����׸�12
        , NULL AS REFER11 --�����׸�13
        , NULL AS REFER12 --�����׸�14
        , NULL AS REFER13 --�����׸�15    
        
        , W_FORWARD_YEAR || '�⵵ �⸻�ܾ� �����̿� [' || A.ACCOUNT_CODE || '-' || MIN(B.ACCOUNT_DESC) || ' ]' AS REMARK  --����
        , V_SYSDATE AS CREATION_DATE	--������
        , t_PERSON_ID AS CREATED_BY	--������
        , V_SYSDATE AS LAST_UPDATE_DATE	--������
        , t_PERSON_ID AS LAST_UPDATED_BY	--������ 
    FROM FI_SLIP_LINE A ,
        (
            SELECT * 
            FROM FI_ACCOUNT_CONTROL 
            WHERE SOB_ID = W_SOB_ID 
                AND ORG_ID = W_ORG_ID 
                AND ACCOUNT_CLASS_ID IN
                    (
                        SELECT COMMON_ID
                        FROM FI_COMMON 
                        WHERE SOB_ID = W_SOB_ID 
                            AND ORG_ID = W_ORG_ID 
                            AND GROUP_CODE = 'ACCOUNT_CLASS'
                            AND CODE = '160'   --160(�����̿��� �ܾ׸�)                
                    )
        ) B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID        
        AND A.GL_DATE BETWEEN TO_DATE(W_FORWARD_YEAR || '01', 'YYYYMM') AND LAST_DAY(TO_DATE(W_FORWARD_YEAR || '12', 'YYYYMM'))
        
        --AND A.ACCOUNT_CODE = '1110100'
        AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    GROUP BY A.ACCOUNT_CODE
    ;   
  EXCEPTION WHEN OTHERS THEN
            ROLLBACK;

            --FCM_10433 : �̿������ڷ� �����۾� �� ������ �߻��߽��ϴ�.
            O_MESSAGE := '2.' || SQLERRM;
            RETURN;
  END;

--2-2. 170 : �����̿��� ��ȭ�ڵ庰��
  BEGIN
    INSERT INTO FI_FORWARD_AMT(
          FORWARD_YEAR	        --�����̿��⵵
        , SOB_ID	            --ȸ����̵�
        , ORG_ID	            --����ξ��̵�
        --, SLIP_HEADER_ID	    --��ǥ������̵�
        , GL_DATE	            --ȸ������
        --, GL_NUM	            --ȸ���ȣ
        , DEPT_ID	            --���Ǻμ�
        , PERSON_ID	            --������
        , SLIP_TYPE	            --��ǥ����
        , ACCOUNT_CONTROL_ID    --�����������̵�
        , ACCOUNT_CODE	        --�����ڵ�
        , ACCOUNT_DR_CR	        --���뱸��(0-��, 1-��)
        , GL_AMOUNT	            --�̿��ݾ�
        , CURRENCY_CODE	        --��ȭ
        , EXCHANGE_RATE	        --ȯ��
        , GL_CURRENCY_AMOUNT	--��ȭ�ݾ�
        , MANAGEMENT1	        --�����׸�1
        , MANAGEMENT2	        --�����׸�2
        , REFER1	            --�����׸�3
        , REFER2	            --�����׸�4
        , REFER3	            --�����׸�5
        , REFER4	            --�����׸�6
        , REFER5	            --�����׸�7
        , REFER6	            --�����׸�8
        , REFER7	            --�����׸�9
        , REFER8	            --�����׸�10
        , REFER9	            --�����׸�11
        , REFER10	            --�����׸�12
        , REFER11	            --�����׸�13
        , REFER12	            --�����׸�14
        , REFER13	            --�����׸�15
        , REMARK	            --����
        , CREATION_DATE	        --������
        , CREATED_BY	        --������
        , LAST_UPDATE_DATE	    --������
        , LAST_UPDATED_BY	    --������     
    )
    SELECT
          W_FORWARD_YEAR AS FORWARD_YEAR    --�����̿��⵵
        , W_SOB_ID AS SOB_ID    --ȸ����̵�
        , W_ORG_ID AS ORG_ID    --����ξ��̵�
        , TO_DATE(W_FORWARD_YEAR + 1 || '0101') AS GL_DATE  --ȸ������
        , t_DEPT_ID --���Ǻμ�
        , t_PERSON_ID AS PERSON_ID  --������
        , 'BLS' AS SLIP_TYPE    --��ǥ����(�����ܾ�)
        , MIN(B.ACCOUNT_CONTROL_ID) AS ACCOUNT_CONTROL_ID   --�����������̵�
        , A.ACCOUNT_CODE    --�����ڵ�
        , MIN(B.ACCOUNT_DR_CR) AS ACCOUNT_DR_CR --���뱸��(0-��, 1-��)
        
        , CASE MIN(B.ACCOUNT_DR_CR)  --������ ���뱸�� �Ӽ���
            WHEN '1' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) --�����̸�
            WHEN '2' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) --�뺯�̸�
          END REMAIN_AMT    --�̿��ݾ�
          
        , A.CURRENCY_CODE AS CURRENCY_CODE --��ȭ
        , 0 AS EXCHANGE_RATE    --ȯ��
        , 0 AS GL_CURRENCY_AMOUNT   --��ȭ�ݾ�
        
        , NULL AS MANAGEMENT1 --�����׸�1
        , NULL AS MANAGEMENT2 --�����׸�2
        , NULL AS REFER1  --�����׸�3
        , NULL AS REFER2  --�����׸�4
        , NULL AS REFER3  --�����׸�5
        , NULL AS REFER4  --�����׸�6
        , NULL AS REFER5  --�����׸�7
        , NULL AS REFER6  --�����׸�8
        , NULL AS REFER7  --�����׸�9
        , NULL AS REFER8  --�����׸�10
        , NULL AS REFER9  --�����׸�11
        , NULL AS REFER10 --�����׸�12
        , NULL AS REFER11 --�����׸�13
        , NULL AS REFER12 --�����׸�14
        , NULL AS REFER13 --�����׸�15    
        
        , W_FORWARD_YEAR || '�⵵ �⸻�ܾ� �����̿� [' || A.ACCOUNT_CODE || '-' || MIN(B.ACCOUNT_DESC) || ' ]' AS REMARK  --����
        , V_SYSDATE AS CREATION_DATE	--������
        , t_PERSON_ID AS CREATED_BY	--������
        , V_SYSDATE AS LAST_UPDATE_DATE	--������
        , t_PERSON_ID AS LAST_UPDATED_BY	--������ 
    FROM FI_SLIP_LINE A ,
        (
            SELECT * 
            FROM FI_ACCOUNT_CONTROL 
            WHERE SOB_ID = W_SOB_ID 
                AND ORG_ID = W_ORG_ID 
                AND ACCOUNT_CLASS_ID IN
                    (
                        SELECT COMMON_ID
                        FROM FI_COMMON 
                        WHERE SOB_ID = W_SOB_ID 
                            AND ORG_ID = W_ORG_ID 
                            AND GROUP_CODE = 'ACCOUNT_CLASS'
                            AND CODE = '170'   --170(�����̿��� ��ȭ�ڵ庰��)
                    )
        ) B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID        
        AND A.GL_DATE BETWEEN TO_DATE(W_FORWARD_YEAR || '01', 'YYYYMM') AND LAST_DAY(TO_DATE(W_FORWARD_YEAR || '12', 'YYYYMM'))
        
        --AND A.ACCOUNT_CODE = '1110200'
        AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    GROUP BY A.ACCOUNT_CODE, A.CURRENCY_CODE
    ;   
  EXCEPTION WHEN OTHERS THEN
            ROLLBACK;

            --FCM_10433 : �̿������ڷ� �����۾� �� ������ �߻��߽��ϴ�.
            O_MESSAGE := '3.' || SQLERRM;
            RETURN;
  END;



--2-3. 140 : �����̿��� ��ǥ����
  BEGIN
    --2-3-1.�� �������� �⺻ �ڷḦ �����,
    INSERT INTO FI_FORWARD_AMT(
          FORWARD_YEAR	        --�����̿��⵵
        , SOB_ID	            --ȸ����̵�
        , ORG_ID	            --����ξ��̵�
        --, SLIP_HEADER_ID	    --��ǥ������̵�
        , GL_DATE	            --ȸ������
        --, GL_NUM	            --ȸ���ȣ
        , DEPT_ID	            --���Ǻμ�
        , PERSON_ID	            --������
        , SLIP_TYPE	            --��ǥ����
        , ACCOUNT_CONTROL_ID    --�����������̵�
        , ACCOUNT_CODE	        --�����ڵ�
        , ACCOUNT_DR_CR	        --���뱸��(0-��, 1-��)
        , GL_AMOUNT	            --�̿��ݾ�
        , CURRENCY_CODE	        --��ȭ
        , EXCHANGE_RATE	        --ȯ��
        , GL_CURRENCY_AMOUNT	--��ȭ�ݾ�
        , MANAGEMENT1	        --�����׸�1
        , MANAGEMENT2	        --�����׸�2
        , REFER1	            --�����׸�3
        , REFER2	            --�����׸�4
        , REFER3	            --�����׸�5
        , REFER4	            --�����׸�6
        , REFER5	            --�����׸�7
        , REFER6	            --�����׸�8
        , REFER7	            --�����׸�9
        , REFER8	            --�����׸�10
        , REFER9	            --�����׸�11
        , REFER10	            --�����׸�12
        , REFER11	            --�����׸�13
        , REFER12	            --�����׸�14
        , REFER13	            --�����׸�15
        , REMARK	            --����
        , CREATION_DATE	        --������
        , CREATED_BY	        --������
        , LAST_UPDATE_DATE	    --������
        , LAST_UPDATED_BY	    --������     
    )
    SELECT
          W_FORWARD_YEAR AS FORWARD_YEAR    --�����̿��⵵
        , W_SOB_ID AS SOB_ID    --ȸ����̵�
        , W_ORG_ID AS ORG_ID    --����ξ��̵�
        , TO_DATE(W_FORWARD_YEAR + 1 || '0101') AS GL_DATE  --ȸ������
        , t_DEPT_ID --���Ǻμ�
        , t_PERSON_ID AS PERSON_ID  --������
        , 'BLS' AS SLIP_TYPE    --��ǥ����(�����ܾ�)
        , MIN(B.ACCOUNT_CONTROL_ID) AS ACCOUNT_CONTROL_ID   --�����������̵�
        , A.ACCOUNT_CODE    --�����ڵ�
        , (B.ACCOUNT_DR_CR) AS ACCOUNT_DR_CR --���뱸��(0-��, 1-��)
        
        , CASE (B.ACCOUNT_DR_CR)  --������ ���뱸�� �Ӽ���
            WHEN '1' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) --�����̸�
            WHEN '2' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) --�뺯�̸�
          END REMAIN_AMT    --�̿��ݾ�
          
        , 'KRW' AS CURRENCY_CODE --��ȭ
        , 0 AS EXCHANGE_RATE    --ȯ��
        , 0 AS GL_CURRENCY_AMOUNT   --��ȭ�ݾ�
        
        , NULL AS MANAGEMENT1 --�����׸�1
        , NULL AS MANAGEMENT2 --�����׸�2
        , NULL AS REFER1  --�����׸�3
        , NULL AS REFER2  --�����׸�4
        , NULL AS REFER3  --�����׸�5
        , NULL AS REFER4  --�����׸�6
        , NULL AS REFER5  --�����׸�7
        , NULL AS REFER6  --�����׸�8
        , NULL AS REFER7  --�����׸�9
        , NULL AS REFER8  --�����׸�10
        , NULL AS REFER9  --�����׸�11
        , NULL AS REFER10 --�����׸�12
        , NULL AS REFER11 --�����׸�13
        , NULL AS REFER12 --�����׸�14
        , NULL AS REFER13 --�����׸�15    
        
        , W_FORWARD_YEAR || '�⵵ �⸻�ܾ� �����̿� [' || A.ACCOUNT_CODE || '-' || MIN(B.ACCOUNT_DESC) || ' ]' AS REMARK  --����
        , V_SYSDATE AS CREATION_DATE	--������
        , t_PERSON_ID AS CREATED_BY	--������
        , V_SYSDATE AS LAST_UPDATE_DATE	--������
        , t_PERSON_ID AS LAST_UPDATED_BY	--������ 
    FROM FI_SLIP_LINE A ,
        (
            SELECT * 
            FROM FI_ACCOUNT_CONTROL 
            WHERE SOB_ID = W_SOB_ID 
                AND ORG_ID = W_ORG_ID 
                AND ACCOUNT_CLASS_ID IN
                    (
                        SELECT COMMON_ID
                        FROM FI_COMMON 
                        WHERE SOB_ID = W_SOB_ID 
                            AND ORG_ID = W_ORG_ID 
                            AND GROUP_CODE = 'ACCOUNT_CLASS'
                            AND CODE = '140'   --140(�����̿��� ��ǥ����)
                    )
        ) B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID        
        AND A.GL_DATE BETWEEN TO_DATE(W_FORWARD_YEAR || '01', 'YYYYMM') AND LAST_DAY(TO_DATE(W_FORWARD_YEAR || '12', 'YYYYMM'))
        
        --AND A.ACCOUNT_CODE = '1110100'
        AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    GROUP BY A.ACCOUNT_CODE
           , B.ACCOUNT_DR_CR
    ;   
   EXCEPTION WHEN OTHERS THEN
            ROLLBACK;

            --FCM_10433 : �̿������ڷ� �����۾� �� ������ �߻��߽��ϴ�.
            O_MESSAGE := '4.' || SQLERRM;
            RETURN;
  END;

    --2-3-2.�� �������� ���� ���� �����Ѵ�.
  BEGIN
    FOR UPD_AMT_MST IN (
        --����Ÿ���� [�����̿��� ��ǥ����]�� ������ �����Ѵ�.
        SELECT DISTINCT    -- ��ȣ�� �߰�(2013-02-18) : ������ ������ ���� �ߺ� �߻�)--
               A.ACCOUNT_CODE, A.ACCOUNT_DR_CR
        FROM FI_ACCOUNT_CONTROL A, FI_FORWARD_AMT B
        WHERE A.SOB_ID = W_SOB_ID 
            AND A.ORG_ID = W_ORG_ID 
            AND A.ACCOUNT_CLASS_ID IN
                (
                    SELECT COMMON_ID
                    FROM FI_COMMON 
                    WHERE SOB_ID = W_SOB_ID 
                        AND ORG_ID = W_ORG_ID 
                        AND GROUP_CODE = 'ACCOUNT_CLASS'
                        AND CODE = '140'   --140(�����̿��� ��ǥ����)
                )
            AND A.ACCOUNT_CODE = B.ACCOUNT_CODE    
    ) LOOP
    
        FOR UPD_AMT_DET IN (
            SELECT
                  A.ACCOUNT_CODE
                , (B.ACCOUNT_DR_CR) AS ACCOUNT_DR_CR      
                , CASE (B.ACCOUNT_DR_CR)  --������ ���뱸�� �Ӽ���
                    WHEN '1' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) --�����̸�
                    WHEN '2' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) --�뺯�̸�
                  END REMAIN_AMT    --�ܾ�
            FROM FI_SLIP_LINE A ,
                (
                    SELECT * 
                    FROM FI_ACCOUNT_CONTROL 
                    WHERE SOB_ID = W_SOB_ID 
                        AND ORG_ID = W_ORG_ID
                        
                        --����Ÿ���� [�����̿��� �ͼӰ���]�̸鼭
                        AND ACCOUNT_CLASS_ID IN
                            (
                                SELECT COMMON_ID
                                FROM FI_COMMON 
                                WHERE SOB_ID = W_SOB_ID 
                                    AND ORG_ID = W_ORG_ID 
                                    AND GROUP_CODE = 'ACCOUNT_CLASS'
                                    AND CODE = '150'   --150(�����̿��� �ͼӰ���)
                            )
                        
                        --���������� [�����̿��� ��ǥ����]�� ���
                        AND UP_ACCOUNT_CODE = UPD_AMT_MST.ACCOUNT_CODE

                ) B
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID
                AND A.GL_DATE BETWEEN TO_DATE(W_FORWARD_YEAR || '01', 'YYYYMM') AND LAST_DAY(TO_DATE(W_FORWARD_YEAR || '12', 'YYYYMM'))
                --AND A.ACCOUNT_CODE = '1110100'
                AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
            GROUP BY A.ACCOUNT_CODE 
                   , B.ACCOUNT_DR_CR
        ) LOOP
        
            IF UPD_AMT_MST.ACCOUNT_DR_CR = '1' THEN --[�����̿��� ��ǥ����]�� ������ '����' �����̸�
            
                IF UPD_AMT_DET.ACCOUNT_DR_CR = '1' THEN --[�����̿��� �ͼӰ���]�� ������ '����' �����̸�
                
                    UPDATE FI_FORWARD_AMT
                    SET GL_AMOUNT = GL_AMOUNT + UPD_AMT_DET.REMAIN_AMT
                    WHERE SOB_ID = W_SOB_ID
                        AND ORG_ID = W_ORG_ID
                        AND FORWARD_YEAR = W_FORWARD_YEAR
                        AND ACCOUNT_CODE = UPD_AMT_MST.ACCOUNT_CODE ;
                    
                ELSE    --[�����̿��� �ͼӰ���]�� ������ '�뺯' �����̸�
                
                    UPDATE FI_FORWARD_AMT
                    SET GL_AMOUNT = GL_AMOUNT - UPD_AMT_DET.REMAIN_AMT
                    WHERE SOB_ID = W_SOB_ID
                        AND ORG_ID = W_ORG_ID
                        AND FORWARD_YEAR = W_FORWARD_YEAR
                        AND ACCOUNT_CODE = UPD_AMT_MST.ACCOUNT_CODE ;                
                
                END IF;
            
            ELSE    --[�����̿��� ��ǥ����]�� ������ '�뺯' �����̸�
            
                IF UPD_AMT_DET.ACCOUNT_DR_CR = '1' THEN --[�����̿��� �ͼӰ���]�� ������ '����' �����̸�
                
                    UPDATE FI_FORWARD_AMT
                    SET GL_AMOUNT = GL_AMOUNT - UPD_AMT_DET.REMAIN_AMT
                    WHERE SOB_ID = W_SOB_ID
                        AND ORG_ID = W_ORG_ID
                        AND FORWARD_YEAR = W_FORWARD_YEAR
                        AND ACCOUNT_CODE = UPD_AMT_MST.ACCOUNT_CODE ;
                    
                ELSE    --[�����̿��� �ͼӰ���]�� ������ '�뺯' �����̸�
                
                    UPDATE FI_FORWARD_AMT
                    SET GL_AMOUNT = GL_AMOUNT + UPD_AMT_DET.REMAIN_AMT
                    WHERE SOB_ID = W_SOB_ID
                        AND ORG_ID = W_ORG_ID
                        AND FORWARD_YEAR = W_FORWARD_YEAR
                        AND ACCOUNT_CODE = UPD_AMT_MST.ACCOUNT_CODE ;                
                
                END IF;            
            
            END IF;
        
        END LOOP UPD_AMT_DET;

    
    END LOOP UPD_AMT_MST;
  EXCEPTION WHEN OTHERS THEN
            ROLLBACK;

            --FCM_10433 : �̿������ڷ� �����۾� �� ������ �߻��߽��ϴ�.
            O_MESSAGE := '5.' ||  SQLERRM;
            RETURN;
  END;


--2-4. 180 : �����̿��� �ŷ�ó�θ�
--�� ����Ÿ���� �� ��ǥ�� ������ [��������]���� �����̴�.
--�� ������ �Ϲ����� ���ó�� �����׸񺰷� �̿��ڷḦ �����ϸ� �� ������ �Ӽ�[����������.]�� ���� �ʼ������׸��� �Ϻ� �ڷᰡ ����
--INSERT�Ϸ��� FI_SLIP_LINE ���̺� �ڷḦ INSERT �� �� ���� ��� ���� �߻��Ѵ�.
--����>�� ������ ��ó�� ó���� ������, ����� ��ó�� �ϴ°��� ������ �ʴ�. �� ������ �����̿��� �ܼ��� �ݾ��� �̿��ϴ� ���̹Ƿ�
--�� ó�� �� ������ �ʼ� �����׸� ���� ������ �ʿ䰡 ����. �׷��� ���� ��ǥ�ʿ� TRIGGER�� �ɷ��־� ������ CHECK�� �ϱ� ������
--�Ұ����ϰ� [180 : �����̿��� �ŷ�ó�θ�] �̷��� ����Ÿ���� ����� �� ���̴�.

  BEGIN
    INSERT INTO FI_FORWARD_AMT(
          FORWARD_YEAR	        --�����̿��⵵
        , SOB_ID	            --ȸ����̵�
        , ORG_ID	            --����ξ��̵�
        --, SLIP_HEADER_ID	    --��ǥ������̵�
        , GL_DATE	            --ȸ������
        --, GL_NUM	            --ȸ���ȣ
        , DEPT_ID	            --���Ǻμ�
        , PERSON_ID	            --������
        , SLIP_TYPE	            --��ǥ����
        , ACCOUNT_CONTROL_ID    --�����������̵�
        , ACCOUNT_CODE	        --�����ڵ�
        , ACCOUNT_DR_CR	        --���뱸��(0-��, 1-��)
        , GL_AMOUNT	            --�̿��ݾ�
        , CURRENCY_CODE	        --��ȭ
        , EXCHANGE_RATE	        --ȯ��
        , GL_CURRENCY_AMOUNT	--��ȭ�ݾ�
        , MANAGEMENT1	        --�����׸�1
        , MANAGEMENT2	        --�����׸�2
        , REFER1	            --�����׸�3
        , REFER2	            --�����׸�4
        , REFER3	            --�����׸�5
        , REFER4	            --�����׸�6
        , REFER5	            --�����׸�7
        , REFER6	            --�����׸�8
        , REFER7	            --�����׸�9
        , REFER8	            --�����׸�10
        , REFER9	            --�����׸�11
        , REFER10	            --�����׸�12
        , REFER11	            --�����׸�13
        , REFER12	            --�����׸�14
        , REFER13	            --�����׸�15
        , REMARK	            --����
        , CREATION_DATE	        --������
        , CREATED_BY	        --������
        , LAST_UPDATE_DATE	    --������
        , LAST_UPDATED_BY	    --������     
    )
    SELECT
          W_FORWARD_YEAR AS FORWARD_YEAR    --�����̿��⵵
        , W_SOB_ID AS SOB_ID    --ȸ����̵�
        , W_ORG_ID AS ORG_ID    --����ξ��̵�
        , TO_DATE(W_FORWARD_YEAR + 1 || '0101') AS GL_DATE  --ȸ������
        , t_DEPT_ID --���Ǻμ�
        , t_PERSON_ID AS PERSON_ID  --������
        , 'BLS' AS SLIP_TYPE    --��ǥ����(�����ܾ�)
        , MIN(B.ACCOUNT_CONTROL_ID) AS ACCOUNT_CONTROL_ID   --�����������̵�
        , A.ACCOUNT_CODE    --�����ڵ�
        , MIN(B.ACCOUNT_DR_CR) AS ACCOUNT_DR_CR --���뱸��(0-��, 1-��)
        
        , CASE MIN(B.ACCOUNT_DR_CR)  --������ ���뱸�� �Ӽ���
            WHEN '1' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) --�����̸�
            WHEN '2' THEN NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 2, A.GL_AMOUNT, 0)), 0) - NVL(SUM(DECODE(A.ACCOUNT_DR_CR, 1, A.GL_AMOUNT, 0)), 0) --�뺯�̸�
          END REMAIN_AMT    --�̿��ݾ�
          
        , 'KRW' AS CURRENCY_CODE --��ȭ
        , 0 AS EXCHANGE_RATE    --ȯ��
        , 0 AS GL_CURRENCY_AMOUNT   --��ȭ�ݾ�
        
        , A.MANAGEMENT1 --�����׸�1
        , MIN(A.MANAGEMENT2) --�����׸�2
        , MIN(A.REFER1)  --�����׸�3
        , MIN(A.REFER2)  --�����׸�4
        , MIN(A.REFER3)  --�����׸�5
        , MIN(A.REFER4)  --�����׸�6
        , MIN(A.REFER5)  --�����׸�7
        , MIN(A.REFER6)  --�����׸�8
        , MIN(A.REFER7)  --�����׸�9
        , MIN(A.REFER8)  --�����׸�10
        , MIN(A.REFER9)  --�����׸�11
        , MIN(A.REFER10) --�����׸�12
        , MIN(A.REFER11) --�����׸�13
        , MIN(A.REFER12) --�����׸�14
        , MIN(A.REFER13) --�����׸�15         
        
        , W_FORWARD_YEAR || '�⵵ �⸻�ܾ� �����̿� [' || A.ACCOUNT_CODE || '-' || MIN(B.ACCOUNT_DESC) || ' ]' AS REMARK  --����
        , V_SYSDATE AS CREATION_DATE	--������
        , t_PERSON_ID AS CREATED_BY	--������
        , V_SYSDATE AS LAST_UPDATE_DATE	--������
        , t_PERSON_ID AS LAST_UPDATED_BY	--������ 
    FROM FI_SLIP_LINE A ,
        (
            SELECT * 
            FROM FI_ACCOUNT_CONTROL 
            WHERE SOB_ID = W_SOB_ID 
                AND ORG_ID = W_ORG_ID 
                AND ACCOUNT_CLASS_ID IN
                    (
                        SELECT COMMON_ID
                        FROM FI_COMMON 
                        WHERE SOB_ID = W_SOB_ID 
                            AND ORG_ID = W_ORG_ID 
                            AND GROUP_CODE = 'ACCOUNT_CLASS'
                            AND CODE = '180'   --180(�����̿��� �ŷ�ó�θ�)
                    )
        ) B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID        
        AND A.GL_DATE BETWEEN TO_DATE(W_FORWARD_YEAR || '01', 'YYYYMM') AND LAST_DAY(TO_DATE(W_FORWARD_YEAR || '12', 'YYYYMM'))
        
        --AND A.ACCOUNT_CODE = '1110700'
        AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    GROUP BY A.ACCOUNT_CODE, A.MANAGEMENT1
    ;   
  EXCEPTION WHEN OTHERS THEN
            ROLLBACK;

            --FCM_10433 : �̿������ڷ� �����۾� �� ������ �߻��߽��ϴ�.
            O_MESSAGE := '6.' ||  SQLERRM;
            RETURN;
  END;







--3.����� �̿��ݾ��� '0'�� �ڷḦ �����Ѵ�.
    DELETE FI_FORWARD_AMT
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FORWARD_YEAR = W_FORWARD_YEAR
        AND GL_AMOUNT = 0
    ;    


--4.����� �ڷ� �� �̿��ݾ��� ������, �ջ��� ���� ��� �ܾ��� '0'�� �ڷḦ �����Ѵ�.
    DELETE FI_FORWARD_AMT
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FORWARD_YEAR = W_FORWARD_YEAR
        AND ACCOUNT_CODE IN (
            SELECT ACCOUNT_CODE
            FROM FI_FORWARD_AMT
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR
            GROUP BY ACCOUNT_CODE
            HAVING SUM(GL_AMOUNT)  = 0
            )
    ; 








--5.��ó�������׿��ݿ� �������� �ݾ��� �������ش�.
--�� �κ��� ���� �繫����ǥ�� ���� �����ϴ�.

    --5-1.��ó�������׿��� ���� ���� �����Ѵ�.
    --�̷��� ���Ƿ� ���� �����ϴ� ������ ���������� ��ó�������׿��� �������� ��ǥ ����� ���� �ʱ� �����̴�.
    --���� ������ ����̿�(�ų� ���� �ϴ� �̿��۾��� ���Ѵ�.) �ÿ��� ��ó�������׿��� ������ ���� �����ؼ� �̿��ؾ� �Ѵ�.

    --���Ͱ�꼭 ���̺��� ����� �������� �ڷḦ �����´�. 
    FI_FS_IS_PARADE_G.LIST_IS(
          IS_TCURSOR
        , W_SOB_ID          --ȸ����̵�
        , W_ORG_ID          --����ξ��̵�
        , 2472              --�������ؼ�Ʈ���̵�
        , W_FORWARD_YEAR    --����
        , 'M'               --�ڷᱸ��(M : ��, Q : �б�, H : �ݱ�, Y : ��)
        , 'M01'             --��ȸ ���ۿ�(��> M01 : 1���ΰ��)
        , 'M12'             --��ȸ �����(��> M12 : 12���ΰ��)  
    );
    
    BEGIN   
      SELECT LAST_LEVEL_AMT_SUM
      INTO t_THIS_NON_LAST_AMT
      FROM FI_FS_IS_PARADE
      WHERE ITEM_CODE = '15';
    EXCEPTION WHEN OTHERS THEN
      t_THIS_NON_LAST_AMT := 0;
    END;

    --��ó�������׿���(���� : 3500100) ���� �����Ѵ�.    
    MERGE INTO FI_FORWARD_AMT FA
    USING( SELECT A.ACCOUNT_CONTROL_ID
                , A.ACCOUNT_CODE     
                , A.ACCOUNT_DESC
                , A.ACCOUNT_DR_CR           
                , A.SOB_ID
                , A.ORG_ID
                , NVL(t_THIS_NON_LAST_AMT, 0) AS t_THIS_NON_LAST_AMT
             FROM FI_ACCOUNT_CONTROL A
            WHERE A.ACCOUNT_CODE     = '3500100'
              AND A.SOB_ID           = W_SOB_ID
              AND A.ORG_ID           = W_ORG_ID
          ) SX1
    ON ( FA.ACCOUNT_CONTROL_ID       = SX1.ACCOUNT_CONTROL_ID
      AND FA.SOB_ID                  = SX1.SOB_ID
      AND FA.ORG_ID                  = SX1.ORG_ID 
       )
    WHEN MATCHED THEN
      UPDATE 
      SET FA.GL_AMOUNT = NVL(FA.GL_AMOUNT, 0) + NVL(t_THIS_NON_LAST_AMT, 0)
      
    WHEN NOT MATCHED THEN
      INSERT  
      (   FORWARD_YEAR	        --�����̿��⵵
        , SOB_ID	            --ȸ����̵�
        , ORG_ID	            --����ξ��̵�
        --, SLIP_HEADER_ID	    --��ǥ������̵�
        , GL_DATE	            --ȸ������
        --, GL_NUM	            --ȸ���ȣ
        , DEPT_ID	            --���Ǻμ�
        , PERSON_ID	            --������
        , SLIP_TYPE	            --��ǥ����
        , ACCOUNT_CONTROL_ID    --�����������̵�
        , ACCOUNT_CODE	        --�����ڵ�
        , ACCOUNT_DR_CR	        --���뱸��(0-��, 1-��)
        , GL_AMOUNT	            --�̿��ݾ�
        , CURRENCY_CODE	        --��ȭ
        , EXCHANGE_RATE	        --ȯ��
        , GL_CURRENCY_AMOUNT	--��ȭ�ݾ�
        , MANAGEMENT1	        --�����׸�1
        , MANAGEMENT2	        --�����׸�2
        , REFER1	            --�����׸�3
        , REFER2	            --�����׸�4
        , REFER3	            --�����׸�5
        , REFER4	            --�����׸�6
        , REFER5	            --�����׸�7
        , REFER6	            --�����׸�8
        , REFER7	            --�����׸�9
        , REFER8	            --�����׸�10
        , REFER9	            --�����׸�11
        , REFER10	            --�����׸�12
        , REFER11	            --�����׸�13
        , REFER12	            --�����׸�14
        , REFER13	            --�����׸�15
        , REMARK	            --����
        , CREATION_DATE	        --������
        , CREATED_BY	        --������
        , LAST_UPDATE_DATE	    --������
        , LAST_UPDATED_BY	    --������    
    ) VALUES
    (
          W_FORWARD_YEAR   --�����̿��⵵
        , W_SOB_ID         --ȸ����̵�
        , W_ORG_ID         --����ξ��̵�
        , TO_DATE(W_FORWARD_YEAR + 1 || '0101')  --ȸ������
        , t_DEPT_ID                              --���Ǻμ�
        , t_PERSON_ID                            	--������
        , 'BLS'                                   --��ǥ����(�����ܾ�)
        , SX1.ACCOUNT_CONTROL_ID                  --�����������̵�
        , SX1.ACCOUNT_CODE                        --�����ڵ�
        , SX1.ACCOUNT_DR_CR                       --���뱸��(0-��, 1-��)
        
        , CASE SX1.ACCOUNT_DR_CR                  --������ ���뱸�� �Ӽ���
            WHEN '1' THEN NVL(t_THIS_NON_LAST_AMT, 0) --�����̸�
            WHEN '2' THEN NVL(t_THIS_NON_LAST_AMT, 0) --�뺯�̸�
          END                                      --�̿��ݾ�
          
        , 'KRW'                                    --��ȭ
        , 0                                        --ȯ��
        , 0                                        --��ȭ�ݾ�
        , NULL                                     --�����׸�1
        , NULL                                     --�����׸�2
        , NULL                                     --�����׸�3
        , NULL                                     --�����׸�4
        , NULL --AS REFER3  --�����׸�5
        , NULL --AS REFER4  --�����׸�6
        , NULL --AS REFER5  --�����׸�7
        , NULL --AS REFER6  --�����׸�8
        , NULL --AS REFER7  --�����׸�9
        , NULL --AS REFER8  --�����׸�10
        , NULL --AS REFER9  --�����׸�11
        , NULL --AS REFER10 --�����׸�12
        , NULL --AS REFER11 --�����׸�13
        , NULL --AS REFER12 --�����׸�14
        , NULL --AS REFER13 --�����׸�15
        , W_FORWARD_YEAR || '�⵵ �⸻�ܾ� �����̿� [' || SX1.ACCOUNT_CODE || '-' || SX1.ACCOUNT_DESC || ' ]' --AS REMARK  --����
        , V_SYSDATE --AS CREATION_DATE	--������
        , t_PERSON_ID --AS CREATED_BY	--������
        , V_SYSDATE --AS LAST_UPDATE_DATE	--������
        , t_PERSON_ID --AS LAST_UPDATED_BY	--������ 
     )   
    ;
    


    --5-2.��ó�������׿���(���� : 3500100) ���������� �̿������׿���(���� : 3500300) ������������ �������ش�.
    --����>�̿��� �̿������׿��� ������ ��ó�������׿��� ���������� ��ü��ǥ �Է��� ���� ��ü�ȴ�.
    
    --�����̿��� ���� ������ �ڷ� �� �̿������׿���(���� : 3500300)�� �ڷᰡ ������ �ش� ������ �ݾ��� �����ϰ�
    --������ ��ó�������׿���(���� : 3500100) ���������� �̿������׿���(���� : 3500300) ������������ �������ش�.
    SELECT COUNT(*)
    INTO t_CNT
    FROM FI_FORWARD_AMT
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FORWARD_YEAR = W_FORWARD_YEAR
        AND ACCOUNT_CODE = '3500300' ;    
    
    IF t_CNT > 0 THEN
        UPDATE FI_FORWARD_AMT
        SET GL_AMOUNT = NVL(GL_AMOUNT, 0) + 
                NVL((SELECT SUM(GL_AMOUNT)
                        FROM FI_FORWARD_AMT
                        WHERE SOB_ID = W_SOB_ID
                            AND ORG_ID = W_ORG_ID
                            AND FORWARD_YEAR = W_FORWARD_YEAR
                            AND ACCOUNT_CODE = '3500100'
                    ), 0)
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND FORWARD_YEAR = W_FORWARD_YEAR
            AND ACCOUNT_CODE = '3500300' ; 
        
        --��ó�������׿���(���� : 3500100) ���� �ڷḦ �����.
        DELETE FI_FORWARD_AMT
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND FORWARD_YEAR = W_FORWARD_YEAR
            AND ACCOUNT_CODE = '3500100' ;            
    ELSE
        UPDATE FI_FORWARD_AMT
        SET ACCOUNT_CODE = '3500300'
            , ACCOUNT_CONTROL_ID = 
                    (
                        SELECT ACCOUNT_CONTROL_ID
                        FROM FI_ACCOUNT_CONTROL
                        WHERE SOB_ID = W_SOB_ID
                            AND ORG_ID = W_ORG_ID
                            AND ACCOUNT_SET_ID = 10
                            AND ACCOUNT_CODE = '3500300'                    
                    )
            , REMARK = W_FORWARD_YEAR || '�⵵ �⸻�ܾ� �����̿� [3500300-�̿������׿��� ]'   --����
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND FORWARD_YEAR = W_FORWARD_YEAR
            AND ACCOUNT_CODE = '3500100' ;  

    END IF;
    
    





--6.�������� UPDATE   
--�� �κ��� ��� �����̿��� �Կ��� ������ ����.
--�׷����� �� �κ��� ó�����ִ� ������ ���α׷����� �ڷ� Ȯ�� �� �� �� ���ϰ� ���� ���ؼ��̴�.

    t_ACCOUNT_CONTROL_ID := NULL;
    
    FOR REC_MANAGEMENT_NM IN (
        SELECT ACCOUNT_CONTROL_ID
        FROM FI_FORWARD_AMT
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND FORWARD_YEAR = W_FORWARD_YEAR
        ORDER BY ACCOUNT_CODE
    ) LOOP
        
        
        --DBMS_OUTPUT.PUT_LINE(REC_MANAGEMENT_NM.ACCOUNT_CONTROL_ID);
        
        
        --������ �̹� ó���� �����̶�� SKIP�Ѵ�.
        IF t_ACCOUNT_CONTROL_ID = REC_MANAGEMENT_NM.ACCOUNT_CONTROL_ID THEN
        
            NULL;
            
        ELSE
        
            t_ACCOUNT_CONTROL_ID := REC_MANAGEMENT_NM.ACCOUNT_CONTROL_ID;
                
            SELECT 
                  REFER1_ID	    --�����׸���̵�1
                , REFER2_ID	    --�����׸���̵�2
                , REFER3_ID	    --�����׸���̵�3
                , REFER4_ID	    --�����׸���̵�4
                , REFER5_ID	    --�����׸���̵�5
                , REFER6_ID	    --�����׸���̵�6
                , REFER7_ID	    --�����׸���̵�7
                , REFER8_ID	    --�����׸���̵�8
                , REFER9_ID	    --�����׸���̵�9
                , REFER10_ID	--�����׸���̵�10
                , REFER11_ID	--�����׸���̵�11
                , REFER12_ID	--�����׸���̵�12
                , REFER13_ID	--�����׸���̵�13
                , REFER14_ID	--�����׸���̵�14
                , REFER15_ID	--�����׸���̵�15
            INTO
                  t_REFER1_ID	--�����׸���̵�1
                , t_REFER2_ID	--�����׸���̵�2
                , t_REFER3_ID	--�����׸���̵�3
                , t_REFER4_ID	--�����׸���̵�4
                , t_REFER5_ID	--�����׸���̵�5
                , t_REFER6_ID	--�����׸���̵�6
                , t_REFER7_ID	--�����׸���̵�7
                , t_REFER8_ID	--�����׸���̵�8
                , t_REFER9_ID   --�����׸���̵�9
                , t_REFER10_ID	--�����׸���̵�10
                , t_REFER11_ID	--�����׸���̵�11
                , t_REFER12_ID	--�����׸���̵�12
                , t_REFER13_ID	--�����׸���̵�13
                , t_REFER14_ID	--�����׸���̵�14
                , t_REFER15_ID	--�����׸���̵�15         
            FROM FI_ACCOUNT_CONTROL
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND ACCOUNT_SET_ID = 10
                AND ACCOUNT_CONTROL_ID = t_ACCOUNT_CONTROL_ID
            ;
                           
            --�����׸� 1~15�� ���� �Ʒ��� ������ ������ IF���� 15�� �ݺ��ȴ�.
            --�����׸�1��
            IF t_REFER1_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER1_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'MANAGEMENT1', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;
            END IF;


            --�����׸�2��
            IF t_REFER2_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER2_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'MANAGEMENT2', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;
            
            --�����׸�3��
            IF t_REFER3_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER3_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER1', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;            
            
            --�����׸�4��
            IF t_REFER4_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER4_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER2', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;
            
            --�����׸�5��
            IF t_REFER5_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER5_ID);               
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER3', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF; 
            
            --�����׸�6��
            IF t_REFER6_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER6_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER4', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;
            
            --�����׸�7��
            IF t_REFER7_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER7_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER5', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;
            
            --�����׸�8��
            IF t_REFER8_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER8_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER6', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;
            
            --�����׸�9��
            IF t_REFER9_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER9_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER7', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF; 
            
            --�����׸�10��
            IF t_REFER10_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER10_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER8', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;
            
            --�����׸�11��
            IF t_REFER11_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER11_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER9', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;
            
            --�����׸�12��
            IF t_REFER12_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER12_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER10', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF; 
            
            --�����׸�13��
            IF t_REFER13_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER13_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER11', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF; 
            
            --�����׸�14��
            IF t_REFER14_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER14_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER12', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;            
            
            --�����׸�15��
            IF t_REFER15_ID IS NOT NULL THEN
                t_MANAGEMENT_GUBUN := MANAGEMENT_UPD_YN_F(W_SOB_ID, W_ORG_ID, t_REFER15_ID);
                
                IF t_MANAGEMENT_GUBUN = 'NONE' THEN
                    NULL;
                ELSE
                    UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_FORWARD_YEAR, t_ACCOUNT_CONTROL_ID, 'REFER13', t_MANAGEMENT_GUBUN);
                END IF;
            ELSE
                NULL;                
            END IF;
   
        END IF;   
      
    END LOOP REC_MANAGEMENT_NM;



    --FCM_10432 : �̿������ڷ� �����۾��� ���������� �Ϸ�Ǿ����ϴ�.
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10432', NULL);   

END CREATE_FORWARD_AMT;







--�����׸���� ������ �� �ִ� �����׸����� ���θ� �ľ��Ͽ� �ش��ϴ� �׸�� ���й��ڸ� �ѱ��.
--�� PROCEDURE�� [�����׸񺰿�����ȸ : FI_MANAGEMENT_LEDGER_G > UPD_MANAGEMENT_NM] ���α׷��� ���� ������ ���̴�.
--CREATE_FORWARD_AMT PROCEDURE���� ���������� ����Ѵ�.
FUNCTION MANAGEMENT_UPD_YN_F( 
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --ȸ����̵�
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --����ξ��̵�
    , W_COMMON_ID       IN FI_COMMON.COMMON_ID%TYPE         --�����ڵ� ID
) RETURN VARCHAR2

AS

t_DATA VARCHAR2(100) := 'NONE';

BEGIN
    
    SELECT VALUE3
    INTO t_DATA
    FROM FI_COMMON
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND GROUP_CODE = 'MANAGEMENT_CODE'
        AND ENABLED_FLAG = 'Y'
        AND VALUE3 IN 
                (
                      'BANK'            --�������(23)                [TABLE : FI_BANK]
                    , 'CUSTOMER'        --�ŷ�ó(01)                  [TABLE : FI_SUPP_CUST_V]
                    , 'BANK_ACCOUNT'    --���¹�ȣ(03)                [TABLE : FI_BANK_ACCOUNT]
                    , 'CREDIT_CARD'     --����ī��, ī���ȣ(02, 26)  [TABLE : FI_CREDIT_CARD]
                    , 'PERSON_NUM'      --���(11)                    [TABLE : HRM_PERSON_MASTER]
                    , 'DEPT'            --�μ�(08)                    [TABLE : FI_DEPT_MASTER]
                    , 'COSTCENTER'      --�����ڵ�(27)                [TABLE : CST_COST_CENTER]           


                    --����>����ó������
                    --����� ��ǥ �Է� �� �۾��ڰ� ���Ƿ� ���� �Է��ϵ��� �Ǿ� �ִµ� �̴� POPUP�� �̿��ؼ� �Է��ϵ��� ����Ǵ°� 
                    --���� ����̴�. ���� �����ҹٰ� �ƴ� �� ���Ƽ� ���д�.
                    , 'BILL_STATUS'             --����ó������(07)               [TABLE : FI_COMMON]
                    
                    , 'TAX_CODE'                --�����(10)                     [TABLE : FI_COMMON]
                    , 'VAT_REASON'              --�ΰ�����ޱ�_��������(12)      [TABLE : FI_COMMON]
                    , 'VAT_TYPE_AP'             --�ΰ�����ޱ�_��������(13)      [TABLE : FI_COMMON]
                    , 'VAT_TYPE_AR'             --�ΰ���������_��������(33)      [TABLE : FI_COMMON]
                    , 'SCHEDULE_REPORT_OMIT'    --�����Ű����п���(36)         [TABLE : FI_COMMON]
                    , 'MODIFY_TAX_REASON'       --�������ڼ��ݰ�꼭��������(37) [TABLE : FI_COMMON]
                    , 'OTHER_ACCOUNT_GB'        --Ÿ��������(38)                 [TABLE : FI_COMMON]            
                )
        AND COMMON_ID = W_COMMON_ID
    ;    
    
                
    RETURN t_DATA;
    
    
    --�Ʒ� ������ �ݵ�� �ʿ��ϴ�. SELECT ������ ��� �ڷᰡ ���� ����� ó���̴�.
    EXCEPTION WHEN NO_DATA_FOUND THEN
        RETURN 'NONE';

END MANAGEMENT_UPD_YN_F;









--�����׸�� ����
--�� PROCEDURE�� [�����׸񺰿�����ȸ : FI_MANAGEMENT_LEDGER_G > UPD_MANAGEMENT_NM] ���α׷��� ���� ������ ���̴�.
--CREATE_FORWARD_AMT PROCEDURE���� ���������� ����Ѵ�.
PROCEDURE UPD_MANAGEMENT_NM(
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --ȸ����̵�
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --����ξ��̵�
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --�����̿��⵵
    
    --�����������̵�; �����ڵ带 ����ϴ� �Ͱ� ������ ���ε� ���ǻ� ���̵� �̿����� ���̴�.
    , W_ACCOUNT_CONTROL_ID  IN FI_FORWARD_AMT.ACCOUNT_CONTROL_ID%TYPE --�����������̵�
    
    , W_COLUMN              IN  VARCHAR2    --������ Į����
    , W_MANAGEMENT_GUBUN    IN  VARCHAR2    --�� �׸� �ִ� ���� �̿��Ͽ� [�����׸�_��]�� ���Ѵ�.
)

AS

BEGIN
   

--���� ���ν��� : FI_ACCOUNT_CONTROL_G > LU_CONTROL_ITEM / LU_MANAGEMENT_ITEM
--�� 2 ���ν����� ������ �����ε�, �ĸ����͸� �ٸ����̴�.

    IF W_MANAGEMENT_GUBUN = 'BANK' THEN                 --�������(23)   [TABLE : FI_BANK]
      
        --�Ʒ� IF���� ���� �����ϴ�. ����, SET ������ ����� COLUMN��� IN-LINE VIEW���� COLUMN�� �ٲ���̴�.
        IF W_COLUMN = 'MANAGEMENT1' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT1_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.MANAGEMENT1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'MANAGEMENT2' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT2_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.MANAGEMENT2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER1' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER1_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER2' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER2_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER3' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER3_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER3
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER4' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER4_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER4
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER5' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER5_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER5
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER6' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER6_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER6
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER7' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER7_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER7
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER8' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER8_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER8
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER9' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER9_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER9
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER10' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER10_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER10
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER11' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER11_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER11
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER12' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER12_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER12
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER13' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER13_NM = (
                                    SELECT BANK_NAME
                                    FROM FI_BANK
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_GROUP != '-' 
                                        AND BANK_CODE = A.REFER13
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;                
        END IF;        
        
    ELSIF W_MANAGEMENT_GUBUN = 'CUSTOMER' THEN          --�ŷ�ó(01)   [TABLE : FI_SUPP_CUST_V]
        
        --�Ʒ� IF���� ���� �����ϴ�. ����, SET ������ ����� COLUMN��� IN-LINE VIEW���� COLUMN�� �ٲ���̴�.
        IF W_COLUMN = 'MANAGEMENT1' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT1_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.MANAGEMENT1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'MANAGEMENT2' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT2_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.MANAGEMENT2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER1' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER1_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER2' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER2_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER3' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER3_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER3
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER4' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER4_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER4
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER5' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER5_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER5
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER6' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER6_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER6
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER7' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER7_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER7
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER8' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER8_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER8
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER9' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER9_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER9
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER10' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER10_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER10
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER11' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER11_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER11
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER12' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER12_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER12
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER13' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER13_NM = (
                                    SELECT SUPP_CUST_NAME
                                    FROM FI_SUPP_CUST_V
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND SUPP_CUST_CODE = A.REFER13
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;                
        END IF;        
    
    ELSIF W_MANAGEMENT_GUBUN = 'BANK_ACCOUNT' THEN      --���¹�ȣ(03)  [TABLE : FI_BANK_ACCOUNT]
    
        --�Ʒ� IF���� ���� �����ϴ�. ����, SET ������ ����� COLUMN��� IN-LINE VIEW���� COLUMN�� �ٲ���̴�.
        IF W_COLUMN = 'MANAGEMENT1' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT1_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.MANAGEMENT1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'MANAGEMENT2' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT2_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.MANAGEMENT2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER1' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER1_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER2' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER2_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER3' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER3_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER3
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER4' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER4_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER4
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER5' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER5_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER5
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER6' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER6_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER6
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER7' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER7_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER7
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER8' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER8_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER8
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER9' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER9_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER9
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER10' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER10_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER10
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER11' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER11_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER11
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER12' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER12_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER12
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER13' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER13_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER13
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;                
        END IF;
       
    ELSIF W_MANAGEMENT_GUBUN = 'PAYABLE_BILL' THEN      --���޾�����ȣ(35)    [TABLE : FI_PAYABLE_BILL]

        NULL;   --�ڷᵵ ����, ���� ����Ȯ�Ͽ� ó�����Ѵ�.
    
    ELSIF W_MANAGEMENT_GUBUN = 'RECEIVABLE_BILL' THEN   --����������ȣ(21)    [TABLE : FI_BILL_MASTER, FI_BILL_STATUS_V]
    
        NULL;   --POPUP���� ó���ϴ� �ɷ� �Ǿ������� �ǻ��� ��ǥ��� �� ���� KEY-IN�Ѵ�.
    
    ELSIF W_MANAGEMENT_GUBUN = 'CREDIT_CARD' THEN       --����ī��, ī���ȣ(02, 26)  [TABLE : FI_CREDIT_CARD]
        
        --�Ʒ� IF���� ���� �����ϴ�. ����, SET ������ ����� COLUMN��� IN-LINE VIEW���� COLUMN�� �ٲ���̴�.
        IF W_COLUMN = 'MANAGEMENT1' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT1_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.MANAGEMENT1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'MANAGEMENT2' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT2_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.MANAGEMENT2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER1' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER1_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER2' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER2_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER3' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER3_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER3
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER4' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER4_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER4
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER5' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER5_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER5
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER6' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER6_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER6
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER7' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER7_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER7
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER8' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER8_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER8
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER9' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER9_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER9
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER10' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER10_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER10
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER11' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER11_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER11
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER12' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER12_NM = (
                                    SELECT CARD_NUM
                                    FROM FI_CREDIT_CARD
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND CARD_CODE = A.REFER12
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER13' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER13_NM = (
                                    SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                    FROM FI_BANK_ACCOUNT
                                    WHERE SOB_ID = W_SOB_ID
                                        AND ORG_ID = W_ORG_ID
                                        AND BANK_ACCOUNT_CODE = A.REFER13
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;                
        END IF;        

    ELSIF W_MANAGEMENT_GUBUN = 'PERSON_NUM' THEN        --���(11)    [TABLE : HRM_PERSON_MASTER]        
        
        --�Ʒ� IF���� ���� �����ϴ�. ����, SET ������ ����� COLUMN��� IN-LINE VIEW���� COLUMN�� �ٲ���̴�.
        IF W_COLUMN = 'MANAGEMENT1' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT1_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.MANAGEMENT1
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'MANAGEMENT2' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT2_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.MANAGEMENT2
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER1' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER1_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER1
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER2' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER2_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER2
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER3' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER3_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER3
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER4' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER4_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER4
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER5' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER5_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER5
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER6' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER6_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER6
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER7' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER7_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER7
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER8' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER8_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER8
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER9' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER9_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER9
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER10' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER10_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER10
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER11' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER11_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER11
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER12' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER12_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER12
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER13' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER13_NM = (
                                SELECT NAME
                                FROM HRM_PERSON_MASTER B
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CORP_TYPE = '1'
                                    AND PERSON_NUM = A.REFER13
                                    AND EXISTS (  SELECT 'X'
                                                  FROM HRM_CORP_MASTER
                                                  WHERE SOB_ID       = B.SOB_ID
                                                    AND ORG_ID       = B.ORG_ID
                                                    AND CORP_ID      = B.CORP_ID
                                                    AND DEFAULT_FLAG = 'Y'
                                             )
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;                
        END IF;         
        
    ELSIF W_MANAGEMENT_GUBUN = 'DEPT' THEN              --�μ�(08)    [TABLE : FI_DEPT_MASTER]        

        --�Ʒ� IF���� ���� �����ϴ�. ����, SET ������ ����� COLUMN��� IN-LINE VIEW���� COLUMN�� �ٲ���̴�.
        IF W_COLUMN = 'MANAGEMENT1' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT1_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.MANAGEMENT1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'MANAGEMENT2' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT2_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.MANAGEMENT2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER1' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER1_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER2' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER2_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER3' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER3_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER3
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER4' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER4_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER4
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER5' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER5_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER5
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER6' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER6_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER6
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER7' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER7_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER7
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER8' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER8_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER8
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER9' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER9_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER9
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER10' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER10_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER10
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER11' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER11_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER11
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER12' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER12_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER12
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER13' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER13_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.REFER13
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;                
        END IF;                

    ELSIF W_MANAGEMENT_GUBUN = 'COSTCENTER' THEN        --�����ڵ�(27)  [TABLE : CST_COST_CENTER]                

        --�Ʒ� IF���� ���� �����ϴ�. ����, SET ������ ����� COLUMN��� IN-LINE VIEW���� COLUMN�� �ٲ���̴�.
        IF W_COLUMN = 'MANAGEMENT1' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT1_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.MANAGEMENT1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'MANAGEMENT2' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT2_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.MANAGEMENT2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER1' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER1_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER2' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER2_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER3' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER3_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER3
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER4' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER4_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER4
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER5' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER5_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER5
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER6' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER6_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER6
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER7' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER7_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER7
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER8' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER8_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER8
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER9' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER9_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER9
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER10' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER10_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER10
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER11' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER11_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER11
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER12' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER12_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER12
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER13' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER13_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.REFER13
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;                
        END IF;           

    ELSIF W_MANAGEMENT_GUBUN = 'LC_NO' THEN             --L/C��ȣ(32) [TABLE : FI_LC_MASTER]
    
        NULL;   --L/C��ȣ ��ü�� �ǹ��ִ� �ڷ��� �� �̻��� ������ �ʿ���� �Ǵ��ߴ�.
    
    ELSE
        /*
            --����>����ó������
            --����� ��ǥ �Է� �� �۾��ڰ� ���Ƿ� ���� �Է��ϵ��� �Ǿ� �ִµ� �̴� POPUP�� �̿��ؼ� �Է��ϵ��� ����Ǵ°� 
            --���� ����̴�. ���� �����ҹٰ� �ƴ� �� ���Ƽ� ���д�.
            , 'BILL_STATUS'             --����ó������(07)               [TABLE : FI_COMMON]
            
            , 'TAX_CODE'                --�����(10)                     [TABLE : FI_COMMON]
            , 'VAT_REASON'              --�ΰ�����ޱ�_��������(12)      [TABLE : FI_COMMON]
            , 'VAT_TYPE_AP'             --�ΰ�����ޱ�_��������(13)      [TABLE : FI_COMMON]
            , 'VAT_TYPE_AR'             --�ΰ���������_��������(33)      [TABLE : FI_COMMON]
            , 'SCHEDULE_REPORT_OMIT'    --�����Ű����п���(36)         [TABLE : FI_COMMON]
            , 'MODIFY_TAX_REASON'       --�������ڼ��ݰ�꼭��������(37) [TABLE : FI_COMMON]
            , 'OTHER_ACCOUNT_GB'        --Ÿ��������(38)                 [TABLE : FI_COMMON]
        */               

        --�Ʒ� IF���� ���� �����ϴ�. ����, SET ������ ����� COLUMN��� IN-LINE VIEW���� COLUMN�� �ٲ���̴�.
        IF W_COLUMN = 'MANAGEMENT1' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT1_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.MANAGEMENT1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'MANAGEMENT2' THEN
            UPDATE FI_FORWARD_AMT A
            SET MANAGEMENT2_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.MANAGEMENT2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER1' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER1_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER1
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER2' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER2_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER2
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER3' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER3_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER3
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER4' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER4_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER4
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER5' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER5_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER5
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER6' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER6_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER6
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID; 
        ELSIF W_COLUMN = 'REFER7' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER7_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER7
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER8' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER8_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER8
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER9' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER9_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER9
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER10' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER10_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER10
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER11' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER11_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER11
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER12' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER12_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER12
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;
        ELSIF W_COLUMN = 'REFER13' THEN
            UPDATE FI_FORWARD_AMT A
            SET REFER13_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.REFER13
                                )
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID;                
        END IF;           
        
           
    END IF;
    
END UPD_MANAGEMENT_NM;








--�����̿��ݾ� ��ȸ(������)
PROCEDURE LIST_FORWARD_AMT_MST( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --ȸ����̵�
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --����ξ��̵�
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --�����̿��⵵
)

AS

BEGIN

    OPEN P_CURSOR FOR

    --�� ������ �ִ� MIN���� �����ռ��� ���ٸ� �ǹ̴� ����, GROUP BY���� ������ ������� ���� COLUMN���� ���� ������ ���̴�.
    SELECT
          W_FORWARD_YEAR AS FORWARD_YEAR  --�����̿��⵵
        , MIN(GL_DATE) AS GL_DATE   --�̿�����
        , ACCOUNT_CODE  --�����ڵ�
        , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F2(MIN(A.SOB_ID), MIN(A.ORG_ID), 10, A.ACCOUNT_CODE) AS ACCOUNT_NM  --������
        , DECODE(MIN(ACCOUNT_DR_CR), '1', '����', '2', '�뺯') AS ACCOUNT_DR_CR    --��������
        , SUM(GL_AMOUNT) AS GL_AMOUNT    --�̿��ݾ�
        , MIN(SLIP_TYPE) AS SLIP_TYPE --��ǥ����
        , FI_COMMON_G.CODE_NAME_F('SLIP_TYPE', MIN(SLIP_TYPE), MIN(SOB_ID), MIN(ORG_ID)) AS SLIP_TYPE_NM    --����
        , MIN(DEPT_ID) AS DEPT_ID   --���Ǻμ�
        , FI_DEPT_MASTER_G.DEPT_NAME_F(MIN(DEPT_ID)) AS DEPT_NAME   --�̿�ó���μ�(97 : �繫������Ʈ)
        , MIN(PERSON_ID) AS PERSON_ID --������
        , HRM_PERSON_MASTER_G.NAME_F(MIN(PERSON_ID)) AS PERSON_NAME   --�̿�ó����(269 : ����ö)
        , MIN(CREATION_DATE) AS CREATION_DATE   --�̿�ó����
    FROM FI_FORWARD_AMT A
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FORWARD_YEAR = W_FORWARD_YEAR
    GROUP BY FORWARD_YEAR, ACCOUNT_CODE
    ORDER BY ACCOUNT_CODE
    ;

END LIST_FORWARD_AMT_MST;









--�����̿��ݾ� ��ȸ(���׸�)
PROCEDURE LIST_FORWARD_AMT_DET( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --ȸ����̵�
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --����ξ��̵�
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --�����̿��⵵
)

AS

BEGIN

    --�� ������ �Ϻ� Į���� �ּ����� ó���� ������ 
    --������ FRAMEWORK�� ��Ȱġ ���Ͽ� �� Į������ �ּ�ó������ ������ ERROR�� �����̴�. ���ذ� �ȵ����� �׳� �Ѿ��.

    OPEN P_CURSOR FOR

    SELECT
          FORWARD_YEAR	--�����̿��⵵
        , TO_CHAR(GL_DATE, 'YYYY-MM-DD') AS GL_DATE	    --ȸ������
        , ACCOUNT_CODE	--�����ڵ�
        , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F2(SOB_ID, ORG_ID, 10, ACCOUNT_CODE) AS ACCOUNT_NM  --������
        , ACCOUNT_DR_CR	--���뱸��(0-��, 1-��)
        , DECODE(ACCOUNT_DR_CR, '1', '����', '2', '�뺯') AS ACCOUNT_DR_CR_NM    --��������       
        , SUM(GL_AMOUNT) AS GL_AMOUNT	--�̿��ݾ�       
        , CURRENCY_CODE	    --��ȭ            
        , MANAGEMENT1	    --�����׸�1
        , MANAGEMENT1_NM	--�����׸��1       
        , MANAGEMENT2	    --�����׸�2
        , MANAGEMENT2_NM    --�����׸��2
        , REFER1	        --�����׸�3
        , REFER1_NM	        --�����׸��3
        , REFER2	        --�����׸�4
        , REFER2_NM	        --�����׸��4
        , REFER3	        --�����׸�5
        , REFER3_NM	        --�����׸��5
        
        , REMARK	--����
        , SLIP_TYPE         --��ǥ����
        , FI_COMMON_G.CODE_NAME_F('SLIP_TYPE', SLIP_TYPE, SOB_ID, ORG_ID) AS SLIP_TYPE_NM    --����
        , TO_CHAR(CREATION_DATE, 'YYYY-MM-DD') AS CREATION_DATE     --�̿�ó����         
        --, DEPT_ID   --���Ǻμ�      
        , FI_DEPT_MASTER_G.DEPT_NAME_F(DEPT_ID) AS DEPT_NAME   --�̿�ó���μ�(97 : �繫������Ʈ)
        --, PERSON_ID --������
        , HRM_PERSON_MASTER_G.NAME_F(PERSON_ID) AS PERSON_NAME   --�̿�ó����(269 : ����ö)
  

        --, SOB_ID	            --ȸ����̵�
        --, ORG_ID	            --����ξ��̵�
        --, ACCOUNT_CONTROL_ID	--�����������̵�    
        , SLIP_HEADER_ID	    --��ǥ������̵�    
        , GL_NUM	            --ȸ���ȣ
        , EXCHANGE_RATE	        --ȯ��
        , GL_CURRENCY_AMOUNT    --��ȭ�ݾ�
        , REFER4	    --�����׸�6
        , REFER4_NM	    --�����׸��6
        , REFER5	    --�����׸�7
        , REFER5_NM	    --�����׸��7
        , REFER6	    --�����׸�8
        , REFER6_NM	    --�����׸��8
        , REFER7	    --�����׸�9
        , REFER7_NM	    --�����׸��9
        , REFER8	    --�����׸�10
        , REFER8_NM	    --�����׸��10
        , REFER9	    --�����׸�11
        , REFER9_NM	    --�����׸��11
        , REFER10	    --�����׸�12
        , REFER10_NM	--�����׸��12
        , REFER11	    --�����׸�13
        , REFER11_NM	--�����׸��13
        , REFER12	    --�����׸�14
        , REFER12_NM	--�����׸��14
        , REFER13	    --�����׸�15
        , REFER13_NM    --�����׸��15       
    FROM FI_FORWARD_AMT
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FORWARD_YEAR = W_FORWARD_YEAR               
    GROUP BY ROLLUP(ACCOUNT_CODE, (FORWARD_YEAR, GL_DATE, ACCOUNT_CONTROL_ID, ACCOUNT_DR_CR, CURRENCY_CODE, SLIP_TYPE 
                                   , CREATION_DATE, MANAGEMENT1, MANAGEMENT1_NM
                                   , MANAGEMENT2, MANAGEMENT2_NM, REFER1, REFER1_NM
                                   , REFER2, REFER2_NM, REFER3, REFER3_NM
                                   , REMARK
                                   , DEPT_ID, PERSON_ID, SOB_ID, ORG_ID, SLIP_HEADER_ID, GL_NUM, EXCHANGE_RATE
                                   , GL_CURRENCY_AMOUNT, REFER4, REFER4_NM, REFER5, REFER5_NM, REFER6, REFER6_NM
                                   , REFER7, REFER7_NM, REFER8, REFER8_NM, REFER9, REFER9_NM, REFER10, REFER10_NM
                                   , REFER11, REFER11_NM, REFER12, REFER12_NM, REFER13, REFER13_NM)
                    )
    ;              

END LIST_FORWARD_AMT_DET;










--�����̿�����
--��ǥ ���̺� �����̿��ݾ��� INSERT�ϴ� ���̴�.
--��ǥ���� : BLS(�����ܾ�)

--����>��ǥ���̺� �ڷ� INSERT�ϴ� �Ϳ� ���� �ּ�
--�ϱ��� �Ϲ����� ��ǥ���� ����� ��������ǥ�����ϴ� �� ���� �����ϸ� �ȴ�.
--�Ϲ����� ��ǥ���� ����� �� �����̿��ڷḦ ��ǥ���̺� INSERT �ϴ� ������� �ణ�� ���� ���̰� �ִ�.
--�Ϲ����� ��ǥ �����ÿ��� ���ռ� üũ�� ���� FI_SLIP_G.INSERT_SLIP_HEADER �Ǵ� FI_SLIP_G.INSERT_SLIP_LINE�� PROCEDURE��
--ȣ��������, �����̿��ڷ� �����ÿ��� ��ǥ�� �ƴϱ⿡ ��ǥ���� 2 ���̺� �ش� �ڷḦ ���� INSERT�Ѵ�.
PROCEDURE CREATE_FORWARD_SLIP( 
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --ȸ����̵�
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --����ξ��̵�
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --�����̿��⵵
    
    , O_MESSAGE         OUT VARCHAR2    --�����̿����� ��� �޽����� ȭ������ ��ȯ�Ѵ�.    
)

AS

t_CNT NUMBER  := 0;
t_SLIP_CNT NUMBER  := 0;

t_SLIP_HEADER_ID    FI_FORWARD_AMT.SLIP_HEADER_ID%TYPE;     --��ǥ������̵�
t_GL_NUM            FI_FORWARD_AMT.GL_NUM%TYPE;             --��ǥ��ȣ
t_GL_DATE           FI_FORWARD_AMT.GL_DATE%TYPE;            --ȸ������
t_PERSON_ID         FI_FORWARD_AMT.PERSON_ID%TYPE;          --������
t_PERIOD_NAME       FI_SLIP_HEADER.PERIOD_NAME%TYPE;        --ȸ����
t_ACCOUNT_BOOK_ID   FI_SLIP_HEADER.ACCOUNT_BOOK_ID%TYPE;    --ȸ����ξ��̵�

V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);       --��������

BEGIN

    --�����̿� ������ ���� �����ڷᰡ �����Ǿ� �ִ����� ������ �ľ��Ѵ�.
    SELECT COUNT(*)
    INTO t_CNT
    FROM FI_FORWARD_AMT
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FORWARD_YEAR = W_FORWARD_YEAR   ;
        
        
    --�����̿��ڷᰡ �̹� �����Ǿ� �ִ����� �ľ��Ѵ�.
    --�����̿��� �ڷῡ ��ǥ��ȣ�� �ִٴ� ���� �� ���ν����� ������ ��� �����̿��ڷᰡ �̹� �����Ǿ��ٴ� ���̴�.
    SELECT COUNT(*)
    INTO t_SLIP_CNT
    FROM FI_FORWARD_AMT
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FORWARD_YEAR = W_FORWARD_YEAR
        AND GL_NUM IS NOT NULL  ;


        
    IF t_CNT = 0 THEN
        --FCM_10424 : �����̿��� ���� �����ڷḦ ���� �� �����ϼ���.
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10424', NULL);  
    ELSIF t_SLIP_CNT > 0 THEN
        --FCM_10430 : �� ������ �����̿��ڷḦ ���� �� �۾��ٶ��ϴ�.
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10430', NULL);      
    ELSE
    
        BEGIN 

            --1.�����ڷ� ����
            
            /*
            ��ǥ�����ϴ� ���̶�� �Ʒ��� üũ�� �����ؼ� �ش� ȸ��Ⱓ�� �������� ������ ������ �߻���Ű�� �� ������ 
            �̿��ڷ�� ��ǥ���̺� �ڷḦ INSERT�ϴ� �� ������ ��ǥ�� �ƴϱ⿡ �̷� üũ�� �ϸ� �ȵȴ�.
            
            IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, P_SLIP_DATE, P_SOB_ID, P_ORG_ID) IN('C', 'N') THEN
                RAISE ERRNUMS.Data_Not_Opened;
            END IF;        
            */
                        
            
            --��ǥ������̵� ���Ѵ�.
            SELECT FI_SLIP_HEADER_S1.NEXTVAL
            INTO t_SLIP_HEADER_ID
            FROM DUAL;                       
               
           
            t_PERIOD_NAME := W_FORWARD_YEAR + 1 || '-01';   --ȸ����
            t_ACCOUNT_BOOK_ID := FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(W_SOB_ID);  --ȸ����ξ��̵�


            SELECT GL_DATE, PERSON_ID
            INTO t_GL_DATE, t_PERSON_ID
            FROM FI_FORWARD_AMT
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   
                AND ROWNUM = 1  ;             
            
            t_GL_NUM := FI_DOCUMENT_NUM_G.DOCUMENT_NUM_F('BL', W_SOB_ID, t_GL_DATE, t_PERSON_ID); --(ä����)��ǥ��ȣ
            


            --2.FI_FORWARD_AMT ���̺� �ڷ�(SLIP_HEADER_ID, GL_NUM) UPDATE
            UPDATE FI_FORWARD_AMT
            SET SLIP_HEADER_ID = t_SLIP_HEADER_ID
                , GL_NUM = t_GL_NUM
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   ;            



            --3.FI_SLIP_HEADER ���̺� �ڷ� INSERT
                           
            INSERT INTO FI_SLIP_HEADER( 
                  SLIP_HEADER_ID        --��ǥ������̵�
                , SLIP_DATE             --��ǥ����
                , SLIP_NUM              --��ǥ��ȣ
                , SOB_ID                --ȸ����̵�
                , ORG_ID                --����ξ��̵�
                , DEPT_ID               --���Ǻμ�
                , PERSON_ID             --������
                , BUDGET_DEPT_ID        --����μ�
                , ACCOUNT_BOOK_ID       --ȸ����ξ��̵�
                , SLIP_TYPE             --��ǥ����
                , PERIOD_NAME           --ȸ����
                , CONFIRM_YN            --���ο���
                , CONFIRM_DATE          --��������
                , CONFIRM_PERSON_ID     --����ó����
                , GL_DATE               --ȸ������
                , GL_NUM                --ȸ���ȣ
                , GL_AMOUNT             --��ǥ�ݾ�
                , CURRENCY_CODE         --��ȭ
                , REQ_BANK_ACCOUNT_ID   --���޻��������
                , REQ_PAYABLE_TYPE      --���޿�û���
                , REQ_PAYABLE_DATE      --���޿�û��
                , REMARK                --��ǥ����
                , CREATION_DATE         --������
                , CREATED_BY            --������
                , LAST_UPDATE_DATE      --������
                , LAST_UPDATED_BY       --������
            )
            SELECT
                  SLIP_HEADER_ID    --��ǥ������̵�
                , GL_DATE           --��ǥ����
                , GL_NUM            --��ǥ��ȣ
                , SOB_ID            --ȸ����̵�
                , ORG_ID            --����ξ��̵�
                , DEPT_ID           --���Ǻμ�
                , PERSON_ID         --������
                , NULL              --����μ�
                , t_ACCOUNT_BOOK_ID --ȸ����ξ��̵�
                , SLIP_TYPE         --��ǥ����
                , t_PERIOD_NAME     --ȸ����
                , 'Y'               --���ο���
                , GL_DATE           --��������
                , PERSON_ID         --����ó����
                , GL_DATE           --ȸ������
                , GL_NUM            --ȸ���ȣ
                , 0                 --��ǥ�ݾ�
                , 'KRW'             --��ȭ                
                , NULL              --���޻��������
                , NULL              --���޿�û���
                , NULL              --���޿�û��
                , W_FORWARD_YEAR || '�⵵ �⸻�ܾ� �����̿�'  --��ǥ����; 2011�⵵ �⸻�ܾ� �����̿�
                , V_SYSDATE         --������
                , PERSON_ID         --������
                , V_SYSDATE         --������
                , PERSON_ID         --������
            FROM FI_FORWARD_AMT
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR
                AND ROWNUM = 1  ;   
                --FI_FORWARD_AMT���̺� �ִ� ���� �ڷ� �� ������ 1���� �����ؼ� ��ǥ����� INSERT�ϱ� �����̴�.
                    

            --4.FI_SLIP_LINE ���̺� �ڷ� INSERT           

            INSERT INTO FI_SLIP_LINE( 
                  SLIP_LINE_ID          --��ǥ���ξ��̵�
                , SLIP_DATE             --��ǥ����
                , SLIP_NUM              --��ǥ��ȣ
                , SLIP_LINE_SEQ         --��ǥ���ι�ȣ
                , SLIP_HEADER_ID        --��ǥ������̵�
                , SOB_ID                --ȸ����̵�
                , ORG_ID                --����ξ��̵�
                , DEPT_ID               --���Ǻμ�
                , PERSON_ID             --������
                , ACCOUNT_BOOK_ID       --ȸ����ξ��̵�
                , SLIP_TYPE             --��ǥ����
                , PERIOD_NAME           --ȸ����
                , CONFIRM_YN            --���ο���
                , CONFIRM_DATE          --��������
                , CONFIRM_PERSON_ID     --����ó����
                , GL_DATE               --ȸ������
                , GL_NUM                --ȸ���ȣ
                , ACCOUNT_CONTROL_ID    --�����������̵�
                , ACCOUNT_CODE          --�����ڵ�
                , ACCOUNT_DR_CR         --���뱸��(0-��, 1-��)
                , GL_AMOUNT             --��ǥ�ݾ�
                , CURRENCY_CODE         --��ȭ
                , EXCHANGE_RATE         --ȯ��
                , GL_CURRENCY_AMOUNT    --��ȭ�ݾ�
                , MANAGEMENT1           --�����׸�1
                , MANAGEMENT2           --�����׸�2
                , REFER1                --�����׸�3
                , REFER2                --�����׸�4
                , REFER3                --�����׸�5
                , REFER4                --�����׸�6
                , REFER5                --�����׸�7
                , REFER6                --�����׸�8
                , REFER7                --�����׸�9
                , REFER8                --�����׸�10
                , REFER9                --�����׸�11
                , REFER10               --�����׸�12
                , REFER11               --�����׸�13
                , REFER12               --�����׸�14
                , REFER13               --�����׸�15
                , REMARK                --��ǥ����
                , UNLIQUIDATE_SLIP_HEADER_ID    --��û����ǥHEADER_ID
                , UNLIQUIDATE_SLIP_LINE_ID      --��û����ǥLINE_ID
                , CREATION_DATE     --������
                , CREATED_BY        --������
                , LAST_UPDATE_DATE  --������
                , LAST_UPDATED_BY   --������
            )
            SELECT
                  FI_SLIP_LINE_S1.NEXTVAL   --��ǥ���ξ��̵�
                , GL_DATE               --��ǥ����
                , GL_NUM                --��ǥ��ȣ
                , ROWNUM                --��ǥ���ι�ȣ
                , SLIP_HEADER_ID        --��ǥ������̵�
                , SOB_ID                --ȸ����̵�
                , ORG_ID                --����ξ��̵�
                , DEPT_ID               --���Ǻμ�
                , PERSON_ID             --������
                , t_ACCOUNT_BOOK_ID     --ȸ����ξ��̵�
                , SLIP_TYPE             --��ǥ����
                , t_PERIOD_NAME         --ȸ����
                , 'Y'                   --���ο���
                , GL_DATE               --��������
                , PERSON_ID             --����ó����
                , GL_DATE               --ȸ������
                , GL_NUM                --ȸ���ȣ
                , ACCOUNT_CONTROL_ID    --�����������̵�
                , ACCOUNT_CODE          --�����ڵ�
                , ACCOUNT_DR_CR         --���뱸��(0-��, 1-��)
                , GL_AMOUNT             --��ǥ�ݾ�
                , CURRENCY_CODE         --��ȭ
                , EXCHANGE_RATE         --ȯ��
                , GL_CURRENCY_AMOUNT    --��ȭ�ݾ�
                , MANAGEMENT1           --�����׸�1
                , MANAGEMENT2           --�����׸�2
                , REFER1                --�����׸�3
                , REFER2                --�����׸�4
                , REFER3                --�����׸�5
                , REFER4                --�����׸�6
                , REFER5                --�����׸�7
                , REFER6                --�����׸�8
                , REFER7                --�����׸�9
                , REFER8                --�����׸�10
                , REFER9                --�����׸�11
                , REFER10               --�����׸�12
                , REFER11               --�����׸�13
                , REFER12               --�����׸�14
                , REFER13               --�����׸�15
                , REMARK                --��ǥ����
                , NULL                  --��û����ǥHEADER_ID
                , NULL                  --��û����ǥLINE_ID
                , V_SYSDATE             --������
                , PERSON_ID             --������
                , V_SYSDATE             --������
                , PERSON_ID             --������                 
            FROM
                (
                    SELECT *
                    FROM FI_FORWARD_AMT
                    WHERE SOB_ID = W_SOB_ID
                        AND ORG_ID = W_ORG_ID
                        AND FORWARD_YEAR = W_FORWARD_YEAR
                    ORDER BY ACCOUNT_CODE
                )   ;    



            --FCM_10425 : �����̿��۾��� ���� ����Ǿ����ϴ�.
            O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10425', NULL);
            
        
        EXCEPTION WHEN OTHERS THEN
            ROLLBACK;
        
            --FCM_10429 : �����̿��۾� �� ������ �߻��߽��ϴ�.
            --O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10429', NULL);
            
            O_MESSAGE := SQLCODE || ' ;  ������ :  ' || SQLERRM;            
            --DBMS_OUTPUT.PUT_LINE('------ �������ڵ尪�� ���� message : ' || SQLERRM);
        END;  
        
    END IF;

END CREATE_FORWARD_SLIP;








--��ǥ���̺�(FI_SLIP_HEADER, FI_SLIP_LINE)�� ��ϵ� �����̿��ڷ����
--����>�� ������ �� ������ ���� ������ �̿��ڷḸ�� �����Ѵ�. 
--�࿩ �� ������ �ƴ� �ٸ� ���(������ �ִ� �����ܾ׵�� ���α׷�)���� �߰��� �̿��ڷ�� �������� �ʴ´�.
PROCEDURE DELETE_FORWARD_SLIP( 
      W_SOB_ID          IN FI_FORWARD_AMT.SOB_ID%TYPE       --ȸ����̵�
    , W_ORG_ID          IN FI_FORWARD_AMT.ORG_ID%TYPE       --����ξ��̵�
    , W_FORWARD_YEAR    IN FI_FORWARD_AMT.FORWARD_YEAR%TYPE --�����̿��⵵
    , W_GL_NUM          IN FI_FORWARD_AMT.GL_NUM%TYPE       --ȸ���ȣ
    
    , O_MESSAGE         OUT VARCHAR2    --�����̿����� ��� �޽����� ȭ������ ��ȯ�Ѵ�.
)

AS

t_CNT NUMBER  := 0;

BEGIN

    --�����̿��� �ڷ��� ���� ������ �ľ��Ѵ�.
    SELECT COUNT(*)
    INTO t_CNT
    FROM FI_SLIP_LINE
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND SLIP_TYPE = 'BLS'   --��ǥ���� ; BLS(�����ܾ�)
        AND PERIOD_NAME = W_FORWARD_YEAR + 1 || '-01'
        AND GL_NUM = W_GL_NUM    ;
        
     
        
    IF t_CNT = 0 THEN
        --FCM_10426 : ������ �����̿��� �ڷᰡ �������� �ʽ��ϴ�.
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10426', NULL);        
    ELSE
        BEGIN
    
            --1.��ǥ���̺�(FI_SLIP_HEADER, FI_SLIP_LINE)�� ��ϵ� �����̿��ڷḦ �����Ѵ�.
            DELETE FI_SLIP_HEADER
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND SLIP_TYPE = 'BLS'   --��ǥ���� ; BLS(�����ܾ�)
                AND PERIOD_NAME = W_FORWARD_YEAR + 1 || '-01'
                AND GL_NUM = W_GL_NUM    ; 
                
                
            DELETE FI_SLIP_LINE
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND SLIP_TYPE = 'BLS'   --��ǥ���� ; BLS(�����ܾ�)
                AND PERIOD_NAME = W_FORWARD_YEAR + 1 || '-01'
                AND GL_NUM = W_GL_NUM    ;
                
                
            --2.FI_FORWARD_AMT ���̺� �ڷ�(SLIP_HEADER_ID, GL_NUM) UPDATE
            UPDATE FI_FORWARD_AMT
            SET SLIP_HEADER_ID = NULL
                , GL_NUM = NULL
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND FORWARD_YEAR = W_FORWARD_YEAR   ;
                

            --FCM_10427 : �����̿��ڷḦ ���� �����Ͽ����ϴ�.
            O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10427', NULL);
            
        EXCEPTION WHEN OTHERS THEN
            --FCM_10428 : �����̿��ڷ� ���� �� ������ �߻��߽��ϴ�.
            O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10428', NULL);
        END;        
        
    END IF;

END DELETE_FORWARD_SLIP;







END FI_FORWARD_AMT_G;
/
