--2.�����ڷḦ �����Ѵ�.
DECLARE
  t_REMAIN_AMT  NUMBER := 0;
  t_LOOKUP_TYPE VARCHAR2(50);
BEGIN
    -- 2-0. �����ڷ� ����.
    DELETE FROM FI_MANAGEMENT_LEDGER_DETAIL;
    
    -- LOOKUP TYPE.
    BEGIN
      SELECT MC.LOOKUP_TYPE
        INTO t_LOOKUP_TYPE
        FROM FI_MANAGEMENT_CODE_V MC
      WHERE MC.MANAGEMENT_ID      = &W_MANAGEMENT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      t_LOOKUP_TYPE := NULL;
    END;
    
    FOR C1 IN ( SELECT AC.ACCOUNT_CONTROL_ID
                     , AC.ACCOUNT_CODE
                     , AC.ACCOUNT_DESC
                     , AC.ACCOUNT_DR_CR
                     , AC.SOB_ID
                  FROM FI_ACCOUNT_CONTROL AC
                WHERE AC.ACCOUNT_CODE     BETWEEN &W_ACCOUNT_CODE_FR AND &W_ACCOUNT_CODE_TO
                  AND AC.SOB_ID           = 10
                  AND AC.ENABLED_FLAG     = 'Y'
              )
    LOOP
        --2-1.�̿��ݾ� �����ڷ� ����
        INSERT INTO FI_MANAGEMENT_LEDGER_DETAIL(
              RET_SEQ           --��ȸ�Ϸù�ȣ
            , GL_DATE           --ȸ������
            , REMARKS           --����
            , DR_AMT            --����(�ݾ�)
            , CR_AMT            --�뺯(�ݾ�)
            , REMAIN_AMT        --�ܾ�
            , ACCOUNT_CODE      --�����ڵ�
            , ACCOUNT_DESC      --������
            , MANAGEMENT_CD     --�����׸��ڵ�
            , MANAGEMENT_NM     --�����׸��
            , SLIP_HEADER_ID    --��ǥ������̵�
            , GL_NUM            --��ǥ��ȣ
            , SLIP_LINE_ID      --��ǥ����ID
        )
        SELECT
              1     --��ȸ�Ϸù�ȣ
            , NULL  --ȸ������
            , '[�̿��ݾ�]' AS REMARKS   --����
            , NVL(SUM(DECODE(ACCOUNT_DR_CR, 1, GL_AMOUNT, 0)), 0) AS DR_AMT   --����
            , NVL(SUM(DECODE(ACCOUNT_DR_CR, 2, GL_AMOUNT, 0)), 0) AS CR_AMT   --�뺯
            , 0                 --�ܾ�       
            , NULL              --�����ڵ�
            , NULL              --������
            , NULL              --�����׸��ڵ�
            , NULL              --�����׸��
            , NULL              --��ǥ������̵�
            , NULL              --��ǥ��ȣ 
            , NULL              --��ǥ����ID
        FROM
            (
                SELECT ML.ACCOUNT_DR_CR, SUM(ML.GL_AMOUNT) AS GL_AMOUNT
                FROM FI_MANAGEMENT_LEDGER_V ML
                WHERE ML.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
                    AND ML.MANAGEMENT_ID    = &W_MANAGEMENT_ID
                    AND ((&W_MANAGEMENT_CD  IS NULL AND 1 = 1)
                    OR   (&W_MANAGEMENT_CD  IS NOT NULL AND ML.MANAGEMENT_VAL = &W_MANAGEMENT_CD))
                    AND ML.GL_DATE BETWEEN TO_DATE(TO_CHAR(&W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') 
                                   AND --�̿��ݾ� ��ȸ �������ڴ� 
                                      CASE 
                                          --��ȸ�Ⱓ�� �������� 1��1���̸� �ش���� 1�� 1��
                                          WHEN TO_CHAR(&W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN TO_DATE(TO_CHAR(&W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM')
                                          ELSE &W_DEAL_DATE_FR - 1    --�ƴϸ� �������� ����
                                      END
                    AND ML.SLIP_TYPE = --��ǥ������
                                      CASE 
                                          WHEN TO_CHAR(&W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN 'BLS' --��ȸ�Ⱓ�� �������� 1��1���̸� '�����ܾ�'��
                                          ELSE SLIP_TYPE   --��� ��ǥ����
                                      END
                GROUP BY MANAGEMENT_ID, ACCOUNT_DR_CR
            )   ;

        --2-2.��ȸ�Ⱓ �� �߻��� �ڷῡ ���� �����ڷ� ����
        INSERT INTO FI_MANAGEMENT_LEDGER_DETAIL(
              RET_SEQ           --��ȸ�Ϸù�ȣ
            , GL_DATE           --ȸ������
            , REMARKS           --����
            , DR_AMT            --����(�ݾ�)
            , CR_AMT            --�뺯(�ݾ�)
            , REMAIN_AMT        --�ܾ�
            , ACCOUNT_CODE      --�����ڵ�
            , ACCOUNT_DESC      --������
            , MANAGEMENT_CD     --�ŷ�ó�ڵ�
            , MANAGEMENT_NM     --�ŷ�ó��
            , SLIP_HEADER_ID    --��ǥ������̵�
            , GL_NUM            --��ǥ��ȣ
            , SLIP_LINE_ID      --��ǥ����ID
        )
        SELECT
              ROWNUM + 1 AS ROW_NUM    --��ȸ�Ϸù�ȣ
              
            --�� ȸ�����ڿ� 1�ʾ��� �����ش�.
            --���� : ���� ȸ�����ڿ� ���� GROUP BY ROOLUP�� ����Ǹ� ������ �޶����� ������ �ذ��ϱ� �����̴�.
            , GL_DATE + (ROWNUM + 1) / 24 / 60 / 60 AS GL_DATE       --ȸ������ 
            
            , REMARKS           --����
            , DR_AMT            --����
            , CR_AMT            --�뺯                                
            , 0 REMAIN_AMT      --�ܾ�
            , ACCOUNT_CODE      --�����ڵ�
            , ACCOUNT_DESC      --������
            , MANAGEMENT_VAL    --�����׸��ڵ�
            , NULL              --�ŷ�ó��
            , SLIP_HEADER_ID    --��ǥ������̵�            
            , GL_NUM            --��ǥ��ȣ
            , SLIP_LINE_ID      --��ǥ����ID                
        FROM
        (
            SELECT
                  ML.GL_DATE       --ȸ������
                , ML.REMARKS       --����
                , NVL(DECODE(ML.ACCOUNT_DR_CR, '1', ML.GL_AMOUNT, 0), 0) AS DR_AMT     --����
                , NVL(DECODE(ML.ACCOUNT_DR_CR, '2', ML.GL_AMOUNT, 0), 0) AS CR_AMT     --�뺯
                , C1.ACCOUNT_CODE
                , C1.ACCOUNT_DESC
                , ML.MANAGEMENT_VAL
                , ML.SLIP_HEADER_ID    --��ǥ������̵�
                , ML.GL_NUM            --��ǥ��ȣ
                , ML.SLIP_LINE_ID      --��ǥ����ID
            FROM FI_MANAGEMENT_LEDGER_V ML
            WHERE ML.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
              AND ML.MANAGEMENT_ID      = &W_MANAGEMENT_ID
              AND ((&W_MANAGEMENT_CD    IS NULL AND 1 = 1)
              OR   (&W_MANAGEMENT_CD    IS NOT NULL AND ML.MANAGEMENT_VAL = &W_MANAGEMENT_CD))
              AND ML.GL_DATE            BETWEEN &W_DEAL_DATE_FR AND &W_DEAL_DATE_TO
              AND ML.SLIP_TYPE          != 'BLS'  --��ǥ������ '�����ܾ�'�� �ƴѰ�
            ORDER BY ML.GL_DATE    
        )   ;                   

        --3.�ܾ��� �����Ѵ�.
        t_REMAIN_AMT := 0;
        FOR AMT_MODIFY IN (
            SELECT MLD.RET_SEQ, C1.ACCOUNT_DR_CR, MLD.DR_AMT, MLD.CR_AMT, MLD.REMAIN_AMT
              FROM FI_MANAGEMENT_LEDGER_DETAIL MLD
            ORDER BY RET_SEQ
        ) LOOP 
            
            UPDATE FI_MANAGEMENT_LEDGER_DETAIL ML
            SET ML.REMAIN_AMT = DECODE(AMT_MODIFY.ACCOUNT_DR_CR
                                    , '1', t_REMAIN_AMT + AMT_MODIFY.DR_AMT - AMT_MODIFY.CR_AMT
                                    , '2', t_REMAIN_AMT + AMT_MODIFY.CR_AMT - AMT_MODIFY.DR_AMT)
            WHERE ML.RET_SEQ = AMT_MODIFY.RET_SEQ    ;
            
            
            SELECT DECODE(AMT_MODIFY.ACCOUNT_DR_CR
                            , '1', t_REMAIN_AMT + AMT_MODIFY.DR_AMT - AMT_MODIFY.CR_AMT
                            , '2', t_REMAIN_AMT + AMT_MODIFY.CR_AMT - AMT_MODIFY.DR_AMT)
            INTO t_REMAIN_AMT
            FROM DUAL;        
               
        END LOOP AMT_MODIFY; 

        --��� �ڷῡ �ŷ�ó�ڷᰡ �ִٸ� �ŷ�ó�ڵ带 �����Ѵ�.
        UPDATE FI_MANAGEMENT_LEDGER_DETAIL T
        SET T.MANAGEMENT_NM = FI_ACCOUNT_CONTROL_G.ITEM_DESC_F(t_LOOKUP_TYPE, T.MANAGEMENT_CD, 10)
        WHERE GL_NUM IS NOT NULL    ;
    END LOOP C1;
    
END;
/*
    --5. �����ڷ� ��ȸ
    
    --OPEN P_CURSOR FOR

    SELECT
          '' BASE_MM        --ȸ����
        , GL_DATE           --ȸ������
        , REMARKS           --����
        , MANAGEMENT_CD     --�����׸��ڵ�
        , MANAGEMENT_NM     --�����׸��            
        , DR_AMT            --����(�ݾ�)
        , CR_AMT            --�뺯(�ݾ�)
        , REMAIN_AMT        --�ܾ�
        , ACCOUNT_CODE      --�����ڵ�
        , ACCOUNT_DESC      --������
        , SLIP_HEADER_ID    --��ǥ������̵�
        , GL_NUM            --��ǥ��ȣ
        , SLIP_LINE_ID      --��ǥ���ξ��̵�
    FROM FI_MANAGEMENT_LEDGER_DETAIL ML
    WHERE RET_SEQ = 1

    UNION ALL
    
    SELECT
          TO_CHAR(GL_DATE, 'YYYY-MM') AS BASE_MM
        , GL_DATE
        , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, '[ �� �� �� �� ]', DECODE(GROUPING(GL_DATE), 1, '[ ��    �� ]',  REMARKS)) AS REMARKS
        , MANAGEMENT_CD
        , MANAGEMENT_NM            
        , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, SUM(DR_AMT), DECODE(GROUPING(GL_DATE), 1, SUM(DR_AMT),  DR_AMT)) AS DR_AMT
        , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, SUM(CR_AMT), DECODE(GROUPING(GL_DATE), 1, SUM(CR_AMT),  CR_AMT)) AS CR_AMT 
        , REMAIN_AMT
        , ACCOUNT_CODE
        , ACCOUNT_DESC
        , SLIP_HEADER_ID
        , GL_NUM
        , SLIP_LINE_ID
    FROM FI_MANAGEMENT_LEDGER_DETAIL ML
    WHERE RET_SEQ > 1
    GROUP BY ROLLUP(TO_CHAR(GL_DATE, 'YYYY-MM'), 
          (GL_DATE, REMARKS, DR_AMT, CR_AMT, REMAIN_AMT, ACCOUNT_CODE, ACCOUNT_DESC, MANAGEMENT_CD, MANAGEMENT_NM, SLIP_HEADER_ID, GL_NUM, SLIP_LINE_ID))
    ;
    */
