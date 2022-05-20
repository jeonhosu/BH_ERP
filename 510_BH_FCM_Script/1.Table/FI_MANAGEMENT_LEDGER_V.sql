CREATE OR REPLACE VIEW FI_MANAGEMENT_LEDGER_V AS
SELECT
      A.ACCOUNT_CONTROL_ID                          -- ����ID
    , A.ACCOUNT_CODE                                --�����ڵ�
    , A.ACCOUNT_DR_CR                               --���뱸��(0-��, 1-��)
    , A.GL_DATE                                     --ȸ������
    , A.REMARK AS REMARKS                           --����
    , B.REFER1_ID AS MANAGEMENT_ID                  --�����׸�_���̵�
    , NVL(A.MANAGEMENT1, 'NONE') AS MANAGEMENT_VAL  --�����׸�_��    
    , A.GL_AMOUNT                                   --��ǥ�ݾ�
    , A.SLIP_HEADER_ID                              --��ǥ���ID
    , A.GL_NUM                                      --��ǥ��ȣ
    , A.SLIP_TYPE                                   --��ǥ����
    , A.SLIP_LINE_ID                                --��ǥ����ID
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --���������� �����׸� Į������ ���� �������� ���� Į���ӿ��� ��ǥ�ڷ��� �ش��ϴ� Į���� 
    --�ǹ̾��� ��(��> '')�� �ִ� ��찡 �־� �̷� �ڷḦ �����ϰ��� �� ��ġ�̴�.    
    AND B.REFER1_ID IS NOT NULL

UNION ALL

SELECT    
      A.ACCOUNT_CONTROL_ID                          -- ����ID
    , A.ACCOUNT_CODE                                --�����ڵ�
    , A.ACCOUNT_DR_CR                               --���뱸��(0-��, 1-��)
    , A.GL_DATE                                     --ȸ������
    , A.REMARK AS REMARKS                           --����
    , B.REFER2_ID AS MANAGEMENT_ID                  --�����׸�_���̵�
    , NVL(A.MANAGEMENT2, 'NONE') AS MANAGEMENT_VAL  --�����׸�_��
    , A.GL_AMOUNT                                   --��ǥ�ݾ�
    , A.SLIP_HEADER_ID                              --��ǥ���ID
    , A.GL_NUM                                      --��ǥ��ȣ
    , A.SLIP_TYPE                                   --��ǥ���� 
    , A.SLIP_LINE_ID                                --��ǥ����ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --���������� �����׸� Į������ ���� �������� ���� Į���ӿ��� ��ǥ�ڷ��� �ش��ϴ� Į���� 
    --�ǹ̾��� ��(��> '')�� �ִ� ��찡 �־� �̷� �ڷḦ �����ϰ��� �� ��ġ�̴�.    
    AND B.REFER2_ID IS NOT NULL

UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- ����ID
    , A.ACCOUNT_CODE                            --�����ڵ�
    , A.ACCOUNT_DR_CR                           --���뱸��(0-��, 1-��)
    , A.GL_DATE                                 --ȸ������
    , A.REMARK AS REMARKS                       --����
    , B.REFER3_ID AS MANAGEMENT_ID              --�����׸�_���̵�
    , NVL(A.REFER1, 'NONE') AS MANAGEMENT_VAL   --�����׸�_��
    , A.GL_AMOUNT                               --��ǥ�ݾ�
    , A.SLIP_HEADER_ID                          --��ǥ���ID
    , A.GL_NUM                                  --��ǥ��ȣ
    , A.SLIP_TYPE                               --��ǥ����
    , A.SLIP_LINE_ID                            --��ǥ����ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --���������� �����׸� Į������ ���� �������� ���� Į���ӿ��� ��ǥ�ڷ��� �ش��ϴ� Į���� 
    --�ǹ̾��� ��(��> '')�� �ִ� ��찡 �־� �̷� �ڷḦ �����ϰ��� �� ��ġ�̴�.    
    AND B.REFER3_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- ����ID
    , A.ACCOUNT_CODE                            --�����ڵ�
    , A.ACCOUNT_DR_CR                           --���뱸��(0-��, 1-��)
    , A.GL_DATE                                 --ȸ������
    , A.REMARK AS REMARKS                       --����
    , B.REFER4_ID AS MANAGEMENT_ID              --�����׸�_���̵�
    , NVL(A.REFER2, 'NONE') AS MANAGEMENT_VAL   --�����׸�_��
    , A.GL_AMOUNT                               --��ǥ�ݾ�
    , A.SLIP_HEADER_ID                          --��ǥ���ID
    , A.GL_NUM                                  --��ǥ��ȣ
    , A.SLIP_TYPE                               --��ǥ����
    , A.SLIP_LINE_ID                            --��ǥ����ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --���������� �����׸� Į������ ���� �������� ���� Į���ӿ��� ��ǥ�ڷ��� �ش��ϴ� Į���� 
    --�ǹ̾��� ��(��> '')�� �ִ� ��찡 �־� �̷� �ڷḦ �����ϰ��� �� ��ġ�̴�.    
    AND B.REFER4_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- ����ID
    , A.ACCOUNT_CODE                            --�����ڵ�
    , A.ACCOUNT_DR_CR                           --���뱸��(0-��, 1-��)
    , A.GL_DATE                                 --ȸ������
    , A.REMARK AS REMARKS                       --����
    , B.REFER5_ID AS MANAGEMENT_ID              --�����׸�_���̵�
    , NVL(A.REFER3, 'NONE') AS MANAGEMENT_VAL   --�����׸�_��
    , A.GL_AMOUNT                               --��ǥ�ݾ�
    , A.SLIP_HEADER_ID                          --��ǥ���ID
    , A.GL_NUM                                  --��ǥ��ȣ
    , A.SLIP_TYPE                               --��ǥ����
    , A.SLIP_LINE_ID                            --��ǥ����ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --���������� �����׸� Į������ ���� �������� ���� Į���ӿ��� ��ǥ�ڷ��� �ش��ϴ� Į���� 
    --�ǹ̾��� ��(��> '')�� �ִ� ��찡 �־� �̷� �ڷḦ �����ϰ��� �� ��ġ�̴�.    
    AND B.REFER5_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- ����ID
    , A.ACCOUNT_CODE                            --�����ڵ�
    , A.ACCOUNT_DR_CR                           --���뱸��(0-��, 1-��)
    , A.GL_DATE                                 --ȸ������
    , A.REMARK AS REMARKS                       --����
    , B.REFER6_ID AS MANAGEMENT_ID              --�����׸�_���̵�
    , NVL(A.REFER4, 'NONE') AS MANAGEMENT_VAL   --�����׸�_��
    , A.GL_AMOUNT                               --��ǥ�ݾ�
    , A.SLIP_HEADER_ID                          --��ǥ���ID
    , A.GL_NUM                                  --��ǥ��ȣ
    , A.SLIP_TYPE                               --��ǥ����
    , A.SLIP_LINE_ID                            --��ǥ����ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --���������� �����׸� Į������ ���� �������� ���� Į���ӿ��� ��ǥ�ڷ��� �ش��ϴ� Į���� 
    --�ǹ̾��� ��(��> '')�� �ִ� ��찡 �־� �̷� �ڷḦ �����ϰ��� �� ��ġ�̴�.    
    AND B.REFER6_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- ����ID
    , A.ACCOUNT_CODE                            --�����ڵ�
    , A.ACCOUNT_DR_CR                           --���뱸��(0-��, 1-��)
    , A.GL_DATE                                 --ȸ������
    , A.REMARK AS REMARKS                       --����
    , B.REFER7_ID AS MANAGEMENT_ID              --�����׸�_���̵�
    , NVL(A.REFER5, 'NONE') AS MANAGEMENT_VAL   --�����׸�_��
    , A.GL_AMOUNT                               --��ǥ�ݾ�
    , A.SLIP_HEADER_ID                          --��ǥ���ID
    , A.GL_NUM                                  --��ǥ��ȣ
    , A.SLIP_TYPE                               --��ǥ����
    , A.SLIP_LINE_ID                            --��ǥ����ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE 
    
    --���������� �����׸� Į������ ���� �������� ���� Į���ӿ��� ��ǥ�ڷ��� �ش��ϴ� Į���� 
    --�ǹ̾��� ��(��> '')�� �ִ� ��찡 �־� �̷� �ڷḦ �����ϰ��� �� ��ġ�̴�.    
    AND B.REFER7_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- ����ID
    , A.ACCOUNT_CODE                            --�����ڵ�
    , A.ACCOUNT_DR_CR                           --���뱸��(0-��, 1-��)
    , A.GL_DATE                                 --ȸ������
    , A.REMARK AS REMARKS                       --����
    , B.REFER8_ID AS MANAGEMENT_ID              --�����׸�_���̵�
    , NVL(A.REFER6, 'NONE') AS MANAGEMENT_VAL   --�����׸�_��
    , A.GL_AMOUNT                               --��ǥ�ݾ�
    , A.SLIP_HEADER_ID                          --��ǥ���ID
    , A.GL_NUM                                  --��ǥ��ȣ
    , A.SLIP_TYPE                               --��ǥ����
    , A.SLIP_LINE_ID                            --��ǥ����ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --���������� �����׸� Į������ ���� �������� ���� Į���ӿ��� ��ǥ�ڷ��� �ش��ϴ� Į���� 
    --�ǹ̾��� ��(��> '')�� �ִ� ��찡 �־� �̷� �ڷḦ �����ϰ��� �� ��ġ�̴�.    
    AND B.REFER8_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- ����ID
    , A.ACCOUNT_CODE                            --�����ڵ�
    , A.ACCOUNT_DR_CR                           --���뱸��(0-��, 1-��)
    , A.GL_DATE                                 --ȸ������
    , A.REMARK AS REMARKS                       --����
    , B.REFER9_ID AS MANAGEMENT_ID              --�����׸�_���̵�
    , NVL(A.REFER7, 'NONE') AS MANAGEMENT_VAL   --�����׸�_��
    , A.GL_AMOUNT                               --��ǥ�ݾ�
    , A.SLIP_HEADER_ID                          --��ǥ���ID
    , A.GL_NUM                                  --��ǥ��ȣ
    , A.SLIP_TYPE                               --��ǥ����
    , A.SLIP_LINE_ID                            --��ǥ����ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --���������� �����׸� Į������ ���� �������� ���� Į���ӿ��� ��ǥ�ڷ��� �ش��ϴ� Į���� 
    --�ǹ̾��� ��(��> '')�� �ִ� ��찡 �־� �̷� �ڷḦ �����ϰ��� �� ��ġ�̴�.    
    AND B.REFER9_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- ����ID
    , A.ACCOUNT_CODE                            --�����ڵ�
    , A.ACCOUNT_DR_CR                           --���뱸��(0-��, 1-��)
    , A.GL_DATE                                 --ȸ������
    , A.REMARK AS REMARKS                       --����
    , B.REFER10_ID AS MANAGEMENT_ID             --�����׸�_���̵�
    , NVL(A.REFER8, 'NONE') AS MANAGEMENT_VAL   --�����׸�_��
    , A.GL_AMOUNT                               --��ǥ�ݾ�
    , A.SLIP_HEADER_ID                          --��ǥ���ID
    , A.GL_NUM                                  --��ǥ��ȣ
    , A.SLIP_TYPE                               --��ǥ����
    , A.SLIP_LINE_ID                            --��ǥ����ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --���������� �����׸� Į������ ���� �������� ���� Į���ӿ��� ��ǥ�ڷ��� �ش��ϴ� Į���� 
    --�ǹ̾��� ��(��> '')�� �ִ� ��찡 �־� �̷� �ڷḦ �����ϰ��� �� ��ġ�̴�.    
    AND B.REFER10_ID IS NOT NULL

UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- ����ID
    , A.ACCOUNT_CODE                            --�����ڵ�
    , A.ACCOUNT_DR_CR                           --���뱸��(0-��, 1-��)
    , A.GL_DATE                                 --ȸ������
    , A.REMARK AS REMARKS                       --����
    , B.REFER11_ID AS MANAGEMENT_ID             --�����׸�_���̵�
    , NVL(A.REFER9, 'NONE') AS MANAGEMENT_VAL   --�����׸�_��
    , A.GL_AMOUNT                               --��ǥ�ݾ�
    , A.SLIP_HEADER_ID                          --��ǥ���ID
    , A.GL_NUM                                  --��ǥ��ȣ
    , A.SLIP_TYPE                               --��ǥ����
    , A.SLIP_LINE_ID                            --��ǥ����ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --���������� �����׸� Į������ ���� �������� ���� Į���ӿ��� ��ǥ�ڷ��� �ش��ϴ� Į���� 
    --�ǹ̾��� ��(��> '')�� �ִ� ��찡 �־� �̷� �ڷḦ �����ϰ��� �� ��ġ�̴�.    
    AND B.REFER11_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- ����ID
    , A.ACCOUNT_CODE                            --�����ڵ�
    , A.ACCOUNT_DR_CR                           --���뱸��(0-��, 1-��)
    , A.GL_DATE                                 --ȸ������
    , A.REMARK AS REMARKS                       --����
    , B.REFER12_ID AS MANAGEMENT_ID             --�����׸�_���̵�
    , NVL(A.REFER10, 'NONE') AS MANAGEMENT_VAL  --�����׸�_��
    , A.GL_AMOUNT                               --��ǥ�ݾ�
    , A.SLIP_HEADER_ID                          --��ǥ���ID
    , A.GL_NUM                                  --��ǥ��ȣ
    , A.SLIP_TYPE                               --��ǥ����
    , A.SLIP_LINE_ID                            --��ǥ����ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE 
    
    --���������� �����׸� Į������ ���� �������� ���� Į���ӿ��� ��ǥ�ڷ��� �ش��ϴ� Į���� 
    --�ǹ̾��� ��(��> '')�� �ִ� ��찡 �־� �̷� �ڷḦ �����ϰ��� �� ��ġ�̴�.     
    AND B.REFER12_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- ����ID
    , A.ACCOUNT_CODE                            --�����ڵ�
    , A.ACCOUNT_DR_CR                           --���뱸��(0-��, 1-��)
    , A.GL_DATE                                 --ȸ������
    , A.REMARK AS REMARKS                       --����
    , B.REFER13_ID AS MANAGEMENT_ID             --�����׸�_���̵�
    , NVL(A.REFER11, 'NONE') AS MANAGEMENT_VAL  --�����׸�_��
    , A.GL_AMOUNT                               --��ǥ�ݾ�
    , A.SLIP_HEADER_ID                          --��ǥ���ID
    , A.GL_NUM                                  --��ǥ��ȣ
    , A.SLIP_TYPE                               --��ǥ����
    , A.SLIP_LINE_ID                            --��ǥ����ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --���������� �����׸� Į������ ���� �������� ���� Į���ӿ��� ��ǥ�ڷ��� �ش��ϴ� Į���� 
    --�ǹ̾��� ��(��> '')�� �ִ� ��찡 �־� �̷� �ڷḦ �����ϰ��� �� ��ġ�̴�.    
    AND B.REFER13_ID IS NOT NULL

UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- ����ID
    , A.ACCOUNT_CODE                            --�����ڵ�
    , A.ACCOUNT_DR_CR                           --���뱸��(0-��, 1-��)
    , A.GL_DATE                                 --ȸ������
    , A.REMARK AS REMARKS                       --����
    , B.REFER14_ID AS MANAGEMENT_ID             --�����׸�_���̵�
    , NVL(A.REFER12, 'NONE') AS MANAGEMENT_VAL  --�����׸�_��
    , A.GL_AMOUNT                               --��ǥ�ݾ�
    , A.SLIP_HEADER_ID                          --��ǥ���ID
    , A.GL_NUM                                  --��ǥ��ȣ
    , A.SLIP_TYPE                               --��ǥ����
    , A.SLIP_LINE_ID                            --��ǥ����ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    
    --���������� �����׸� Į������ ���� �������� ���� Į���ӿ��� ��ǥ�ڷ��� �ش��ϴ� Į���� 
    --�ǹ̾��� ��(��> '')�� �ִ� ��찡 �־� �̷� �ڷḦ �����ϰ��� �� ��ġ�̴�.    
    AND B.REFER14_ID IS NOT NULL
    
UNION ALL

SELECT
      A.ACCOUNT_CONTROL_ID                          -- ����ID
    , A.ACCOUNT_CODE                            --�����ڵ�
    , A.ACCOUNT_DR_CR                           --���뱸��(0-��, 1-��)
    , A.GL_DATE                                 --ȸ������
    , A.REMARK AS REMARKS                       --����
    , B.REFER15_ID AS MANAGEMENT_ID             --�����׸�_���̵�
    , NVL(A.REFER13, 'NONE') AS MANAGEMENT_VAL  --�����׸�_��
    , A.GL_AMOUNT                               --��ǥ�ݾ�
    , A.SLIP_HEADER_ID                          --��ǥ���ID
    , A.GL_NUM                                  --��ǥ��ȣ
    , A.SLIP_TYPE                               --��ǥ����
    , A.SLIP_LINE_ID                            --��ǥ����ID    
FROM FI_SLIP_LINE A, FI_ACCOUNT_CONTROL B
WHERE A.SOB_ID = 10
    AND A.ORG_ID = 101
    AND A.ACCOUNT_CODE = B.ACCOUNT_CODE

    --���������� �����׸� Į������ ���� �������� ���� Į���ӿ��� ��ǥ�ڷ��� �ش��ϴ� Į���� 
    --�ǹ̾��� ��(��> '')�� �ִ� ��찡 �־� �̷� �ڷḦ �����ϰ��� �� ��ġ�̴�.
    AND B.REFER15_ID IS NOT NULL;
comment on table FI_MANAGEMENT_LEDGER_V is '�����׸񺰿�����ȸ';
