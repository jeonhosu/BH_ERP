/*
select *
  from fi_asset_master_cg x
 where x.asset_code    = 'B000000181'
 ;

select *
  from fi_asset_history x
 where x.asset_id       = 405
for update 
 ; 
 
SELECT *
  FROM FI_ASSET_DPR_HISTORY X
 WHERE X.ASSET_ID           = 177
ORDER BY X.PERIOD_NAME 
for update
;

-- ������ �ں��� ����ݾ� �� ����� �̻��ܾ� UPDATE -- 
UPDATE FI_ASSET_DPR_HISTORY ADH
   SET ADH.REMARK                 = NULL
 WHERE ADH.ASSET_ID               = 3513
;

-- ������ �ں��� ����ݾ� �� ����� �̻��ܾ� UPDATE -- 
UPDATE FI_ASSET_DPR_HISTORY ADH
   SET ADH.SOURCE_AMOUNT          = NVL(ADH.SOURCE_AMOUNT, 0) - NVL(ADH.SP_DPR_AMOUNT, 0)
     , ADH.SP_DPR_AMOUNT          = 0
 WHERE ADH.ASSET_ID               = 3513
;
 
*/
DECLARE
      P_SOB_ID                  NUMBER := 10;
      P_ORG_ID                  NUMBER := 101;
      P_ASSET_ID                NUMBER := 3513;
      
      P_ASSET_CATEGORY_ID       NUMBER;      
      P_DPR_METHOD_TYPE         VARCHAR2(2) := '1';  -- ���׹�.
      P_COST_CENTER_ID          NUMBER;              --�������̵�
    
      P_ACQUIRE_DATE            DATE;                --������� 
      P_IFRS_PROGRESS_YEAR      NUMBER;              --(IFRS)������
      P_AMOUNT                  NUMBER;              --���ݾ� 
      P_IFRS_RESIDUAL_AMOUNT    NUMBER;              --(IFRS)��������    
    
      P_CREATED_BY              NUMBER;              --������     

      t_DPR_COUNT         NUMBER;        --��ȸ��
      t_PERIOD_NAME       VARCHAR2(10);      --�󰢳��
      t_DPR_AMOUNT        NUMBER;       --(����)�����󰢺�
      t_DPR_SUM_AMOUNT    NUMBER;   --�����󰢴����
      t_DISUSE_YN         VARCHAR2(5);        --������ȸ������

      V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);

BEGIN
    BEGIN
      SELECT AM.ASSET_CATEGORY_ID
           , AM.COST_CENTER_ID
           , AM.ACQUIRE_DATE
           , AM.IFRS_PROGRESS_YEAR
           , AM.AMOUNT
           , AM.IFRS_RESIDUAL_AMOUNT
           , AM.LAST_UPDATED_BY
        INTO P_ASSET_CATEGORY_ID
           , P_COST_CENTER_ID
           , P_ACQUIRE_DATE
           , P_IFRS_PROGRESS_YEAR
           , P_AMOUNT
           , P_IFRS_RESIDUAL_AMOUNT
           , P_CREATED_BY
        FROM FI_ASSET_MASTER AM
       WHERE AM.ASSET_ID          = P_ASSET_ID
      ;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('�ڻ� ���� ��ȸ ���� : ' || SQLERRM);
        RETURN;  
    END;
    
    --��ȸ���� ���Ѵ�. ���� ��ȸ�� ��ŭ DATA�� INSERT�ȴ�.
    --��ȸ�� = ������ * 12
    SELECT P_IFRS_PROGRESS_YEAR * 12 
    INTO t_DPR_COUNT
    FROM DUAL;
    

    --�����󰢹��(1:���׹�, 2:������)
    IF P_DPR_METHOD_TYPE = '1' THEN --1:���׹�

        --�󰢱ݾ�(�����󰢺�)�� ���Ѵ�.
        --�����󰢺� = �����󰢴��ݾ�(���ݾ� - ��������) / ������
        SELECT ROUND( (P_AMOUNT - P_IFRS_RESIDUAL_AMOUNT) / t_DPR_COUNT, 0)
        INTO t_DPR_AMOUNT
        FROM DUAL   ;
        
        
        t_DISUSE_YN := 'N'; --������ȸ������
        
        
        --��ȸ�� ��ŭ DATA INSERT
        FOR DPR_CREATE IN 1..t_DPR_COUNT
        LOOP
        
            SELECT
                  TO_CHAR(ADD_MONTHS(P_ACQUIRE_DATE, DPR_CREATE - 1), 'YYYY-MM')
                , t_DPR_AMOUNT * DPR_CREATE
            INTO 
                  t_PERIOD_NAME     --�󰢳��
                , t_DPR_SUM_AMOUNT  --�����󰢴���� = �󰢱ݾ�(�����󰢺�) * ��ȸ�� = ��ȸ���� �����󰢴���� + ��ȸ���� �����󰢺�
            FROM DUAL   ;
                 
            
            --��, ������ ��ȸ���� ��� 
            --�����󰢺�� �ܼ������� �׼���  [�� ���Ϲ������ ���ϱ� ���� �Ʒ��� ������� ��ü�ߴ�.]
            --�����󰢴������ (���ݾ� - ������ġ)�� �ݾ��� �����ȴ�.
            IF DPR_CREATE = t_DPR_COUNT THEN            
                SELECT (P_AMOUNT - P_IFRS_RESIDUAL_AMOUNT) - (t_DPR_AMOUNT * (t_DPR_COUNT - 1)) --�����󰢺�
                    , P_AMOUNT -  P_IFRS_RESIDUAL_AMOUNT    --�����󰢴����
                INTO t_DPR_AMOUNT
                    , t_DPR_SUM_AMOUNT
                FROM DUAL   ;
                
                t_DISUSE_YN := 'Y'; --������ȸ������
            END IF;            
            
            -- ������ �ݿ� -- 
            MERGE INTO FI_ASSET_DPR_HISTORY ADH
              USING (SELECT P_SOB_ID AS SOB_ID           --ȸ����̵�
                          , P_ORG_ID AS ORG_ID           --����ξ��̵�
                          , P_ASSET_ID AS ASSET_ID       --�ڻ���̵�    
                          , P_DPR_METHOD_TYPE AS DPR_METHOD_TYPE   --�����󰢹��
                          , t_PERIOD_NAME AS PERIOD_NAME           --�󰢳��
                        FROM DUAL
                    ) SX1
              ON ( ADH.SOB_ID            = SX1.SOB_ID
                AND ADH.ORG_ID           = SX1.ORG_ID
                AND ADH.ASSET_ID         = SX1.ASSET_ID
                AND ADH.DPR_METHOD_TYPE   = SX1.DPR_METHOD_TYPE 
                AND ADH.PERIOD_NAME       = SX1.PERIOD_NAME 
                 )
            WHEN MATCHED THEN
              UPDATE 
                 SET DPR_AMOUNT            = t_DPR_AMOUNT          --(����)�����󰢺�
                   , SP_DPR_AMOUNT         = 0                     --�߰��󰢾�(��>�ں�������)
                   , SP_MNS_DPR_AMOUNT     = 0                     --�����󰢾�(��>�κиŰ�)
                   , SOURCE_AMOUNT         = t_DPR_AMOUNT          --(����)�����󰢺�
                   , DPR_SUM_AMOUNT        = t_DPR_SUM_AMOUNT              --�����󰢴����
                   , UN_DPR_REMAIN_AMOUNT  = P_AMOUNT - t_DPR_SUM_AMOUNT   --�̻��ܾ� = ���ݾ� - �����󰢴����
            WHEN NOT MATCHED THEN
              INSERT  
                ( 
                  SOB_ID            --ȸ����̵�
                , ORG_ID            --����ξ��̵�
                , ASSET_CATEGORY_ID --�ڻ��������̵�
                , ASSET_ID          --�ڻ���̵�    
                , COST_CENTER_ID    --�������̵�
                , DPR_METHOD_TYPE   --�����󰢹��
                , DPR_TYPE          --ȸ�豸��[20 : IFRS]        
                , DPR_YN            --�����󰢿���        
                , SLIP_YN           --��ǥ��������
                
                , DPR_COUNT             --��ȸ��    
                , PERIOD_NAME           --�󰢳��
                , DPR_AMOUNT            --(����)�����󰢺�
                , SP_DPR_AMOUNT         --�߰��󰢾�(��>�ں�������)
                , SP_MNS_DPR_AMOUNT     --�����󰢾�(��>�κиŰ�)
                , SOURCE_AMOUNT         --(����)�����󰢺�
                , DPR_SUM_AMOUNT        --�����󰢴����
                , UN_DPR_REMAIN_AMOUNT  --�̻��ܾ�
                , DISUSE_YN             --������ȸ������
                
                , CREATION_DATE     --��������
                , CREATED_BY        --������
                , LAST_UPDATE_DATE  --������������
                , LAST_UPDATED_BY   --���������� 
                )
                VALUES
                ( 
                  P_SOB_ID              --ȸ����̵�
                , P_ORG_ID              --����ξ��̵�
                , P_ASSET_CATEGORY_ID   --�ڻ��������̵�
                , P_ASSET_ID            --�ڻ���̵�    
                , P_COST_CENTER_ID      --�������̵�
                , P_DPR_METHOD_TYPE     --�����󰢹��
                , '20'                  --ȸ�豸��[20 : IFRS]        
                , 'N'                   --�����󰢿���        
                , 'N'                   --��ǥ��������
                
                , DPR_CREATE            --��ȸ��    
                , t_PERIOD_NAME         --�󰢳��
                , t_DPR_AMOUNT          --(����)�����󰢺�
                , 0                     --�߰��󰢾�(��>�ں�������)
                , 0                     --�����󰢾�(��>�κиŰ�)
                , t_DPR_AMOUNT          --(����)�����󰢺�
                , t_DPR_SUM_AMOUNT              --�����󰢴����
                , P_AMOUNT - t_DPR_SUM_AMOUNT   --�̻��ܾ� = ���ݾ� - �����󰢴����
                , t_DISUSE_YN           --������ȸ������
                
                , V_SYSDATE             --��������
                , P_CREATED_BY          --������
                , V_SYSDATE             --������������
                , P_CREATED_BY          --���������� 
               )   ;

        END LOOP DPR_CREATE;   

    ELSIF P_DPR_METHOD_TYPE = '2' THEN  --2:������

        NULL;     

    END IF;    

END;
