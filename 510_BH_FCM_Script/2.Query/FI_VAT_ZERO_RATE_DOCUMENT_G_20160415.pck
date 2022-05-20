CREATE OR REPLACE PACKAGE FI_VAT_ZERO_RATE_DOCUMENT_G
AS

-- VAT ������������� ��ȸ.
  PROCEDURE SELECT_ZERO_RATE_DOCUMENT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_SOB_ID            IN  FI_VAT_ZERO_RATE_DOCUMENT.SOB_ID%TYPE  --ȸ����̵�
            , W_ORG_ID            IN  FI_VAT_ZERO_RATE_DOCUMENT.ORG_ID%TYPE  --����ξ��̵�
            , W_TAX_CODE          IN  FI_VAT_ZERO_RATE_DOCUMENT.TAX_CODE%TYPE            --�������̵�(��>110)    
            , W_VAT_MNG_SERIAL    IN  FI_VAT_ZERO_RATE_DOCUMENT.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ 
            );


-- VAT ������������� �հ� �ݾ� UPDATE.
  PROCEDURE SET_SUM_ZERO_RATE_DOCUMENT
            ( W_SOB_ID            IN  FI_VAT_ZERO_RATE_DOCUMENT.SOB_ID%TYPE  --ȸ����̵�
            , W_ORG_ID            IN  FI_VAT_ZERO_RATE_DOCUMENT.ORG_ID%TYPE  --����ξ��̵�
            , W_TAX_CODE          IN  FI_VAT_ZERO_RATE_DOCUMENT.TAX_CODE%TYPE            --�������̵�(��>110)    
            , W_VAT_MNG_SERIAL    IN  FI_VAT_ZERO_RATE_DOCUMENT.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ 
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );


  --  ����� �������� �μ� -- 
  PROCEDURE PRINT_ZERO_RATE_DOCUMENT
            ( P_CURSOR          OUT TYPES.TCURSOR
            , W_SOB_ID          IN  NUMBER  --ȸ����̵�
            , W_ORG_ID          IN  NUMBER  --����ξ��̵� 
            , W_TAX_CODE        IN  VARCHAR2
            , W_VAT_MNG_SERIAL  IN  NUMBER
            , W_DEAL_DATE_FR    IN  DATE    --�ŷ��Ⱓ_����
            , W_DEAL_DATE_TO    IN  DATE    --�ŷ��Ⱓ_����    
            );
                        
END FI_VAT_ZERO_RATE_DOCUMENT_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_ZERO_RATE_DOCUMENT_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_VAT_ZERO_RATE_DOCUMENT_G
/* Description  : ������ ������� ����.
/*
/* Reference by : ������ ÷�μ� ������ ������ ��������� �հ� �ݾ��� SAVE�Ѵ�.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- VAT ������������� ��ȸ.
  PROCEDURE SELECT_ZERO_RATE_DOCUMENT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_SOB_ID            IN  FI_VAT_ZERO_RATE_DOCUMENT.SOB_ID%TYPE  --ȸ����̵�
            , W_ORG_ID            IN  FI_VAT_ZERO_RATE_DOCUMENT.ORG_ID%TYPE  --����ξ��̵�
            , W_TAX_CODE          IN  FI_VAT_ZERO_RATE_DOCUMENT.TAX_CODE%TYPE            --�������̵�(��>110)    
            , W_VAT_MNG_SERIAL    IN  FI_VAT_ZERO_RATE_DOCUMENT.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ 
            )
  AS
    V_STATUS            VARCHAR2(2);
    V_MESSAGE           VARCHAR2(500);
  BEGIN
    SET_SUM_ZERO_RATE_DOCUMENT
      ( W_SOB_ID            => W_SOB_ID
      , W_ORG_ID            => W_ORG_ID
      , W_TAX_CODE          => W_TAX_CODE
      , W_VAT_MNG_SERIAL    => W_VAT_MNG_SERIAL
      , O_STATUS            => V_STATUS      
      , O_MESSAGE           => V_MESSAGE
      );
    IF V_STATUS = 'F' THEN
      RAISE_APPLICATION_ERROR(-20001, W_TAX_CODE || '-' ||  V_MESSAGE);
      RETURN;
    END IF;
              
    OPEN P_CURSOR FOR
      SELECT ZRD.V_11_01_01_1     -- ��������(������� ����) 
           , ZRD.V_11_01_01_2     -- �߰蹫��/��Ź�Ǹ�/�ܱ��ε� �Ǵ� ��Ź�������� ����� ���� 
           , ZRD.V_11_01_01_3     -- �����ſ���/����Ȯ�μ��� ���Ͽ� �����ϴ� ��ȭ 
           , ZRD.V_11_01_01_4     -- �ѱ��������´� �� �ѱ����������Ƿ���ܿ� �����ϴ� �ؿܹ���� ��ȭ 
           , ZRD.V_11_01_01_5     -- ��Ź�������� ��������� �����ϴ� ��ȭ 
           , ZRD.V_11_01_02_1     -- ���ܿ��� �����ϴ� �뿪 
           , ZRD.V_11_01_03_1     -- ����/�װ��⿡ ���� �ܱ�����뿪 
           , ZRD.V_11_01_03_2     -- �������տ�۰�࿡ ���� �ܱ�����뿪 
           , ZRD.V_11_01_04_1     -- �������� �������/�ܱ����ο��� ���޵Ǵ� ��ȭ �Ǵ� �뿪 
           , ZRD.V_11_01_04_2     -- ������ȭ�Ӱ����뿪 
           , ZRD.V_11_01_04_3     -- �ܱ����� ����/�װ��� � �����ϴ� ��ȭ �Ǵ� �뿪  
           , ZRD.V_11_01_04_4     -- ���� ���� �ܱ�����/������/�������հ� �̿� ���ϴ� �����ⱸ, �������ձ� �Ǵ� �̱������� �����ϴ� ��ȭ �Ǵ� �뿪 
           , ZRD.V_11_01_04_5     -- ����������� ���� �Ϲݿ������ �Ǵ� �ܱ������� �������ǰ �Ǹž��ڰ� �ܱ��ΰ��������� �����ϴ� �����˼� �뿪 �Ǵ� �������ǰ 
           , ZRD.V_11_01_04_6     -- �ܱ��������Ǹ��� �Ǵ� ���ѿܱ����� ���� ���� �������������� �����ϴ� ��ȭ �Ǵ� �뿪 
           , ZRD.V_11_01_04_7     -- �ܱ��� ��� �����ϴ� ��ȭ �Ǵ� �뿪 
           , ZRD.V_11_01_04_8     -- �ܱ���ȯ�� ��ġ�뿪 
           , ZRD.V_SUM_AMT        -- �ΰ���ġ������ ���� ������ ���� ���޽��� �հ� 
           , ZRD.T_105_01_01_1    -- ����������� �� ���δ� � �����ϴ� ������ 
           , ZRD.T_105_01_03_1    -- ����ö���Ǽ��뿪 
           , ZRD.T_105_01_03_2    -- ����/������ġ��ü�� �����ϴ� ��ȸ��ݽü��� 
           , ZRD.T_105_01_04_1    -- ����ο� ���屸 �� ����ο� ������ű�� �� 
           , ZRD.T_105_01_05_1    -- ��/��� ��� �����ϴ� �����/������/�Ӿ��� �Ǵ� ����� ������ 
           , ZRD.T_107_00_00_0    -- �ܱ��ΰ����� ��� �����ϴ� ��ȭ 
           , ZRD.T_121_13_00_0    -- ����Ư����ġ�� �鼼ǰ�Ǹ��忡�� �Ǹ��ϰų� ����Ư����ġ�� �鼼ǰ�Ǹ��忡 �����ϴ� ��ǰ 
           , ZRD.T_SUM_AMT        -- ��Ư�� �� �� ���� ������ ���� ������ ���� ���޽��� �հ� 
           , ZRD.TOTAL_AMT        -- ������ ���� ���޽��� �� �հ� 
           , ZRD.TAX_CODE
           , ZRD.VAT_MNG_SERIAL
           , ZRD.T_105_01_01_1_1  -- ���δ���޼����� 
           , ZRD.T_105_01_05_1_1  -- ��ο��� �����ϴ� ���������� 
        FROM FI_VAT_ZERO_RATE_DOCUMENT ZRD
      WHERE ZRD.TAX_CODE          = W_TAX_CODE
        AND ZRD.VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL
        AND ZRD.SOB_ID            = W_SOB_ID
        AND ZRD.ORG_ID            = W_ORG_ID
      ;
  END SELECT_ZERO_RATE_DOCUMENT;


-- VAT ������������� �հ� �ݾ� UPDATE.
  PROCEDURE SET_SUM_ZERO_RATE_DOCUMENT
            ( W_SOB_ID            IN  FI_VAT_ZERO_RATE_DOCUMENT.SOB_ID%TYPE  --ȸ����̵�
            , W_ORG_ID            IN  FI_VAT_ZERO_RATE_DOCUMENT.ORG_ID%TYPE  --����ξ��̵�
            , W_TAX_CODE          IN  FI_VAT_ZERO_RATE_DOCUMENT.TAX_CODE%TYPE            --�������̵�(��>110)    
            , W_VAT_MNG_SERIAL    IN  FI_VAT_ZERO_RATE_DOCUMENT.VAT_MNG_SERIAL%TYPE      --�ΰ����Ű�Ⱓ���й�ȣ 
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_USER_ID           NUMBER := GET_USER_ID_F;
  BEGIN
    O_STATUS := 'F';
    
    -- 0. �ʱ�ȭ --
    UPDATE FI_VAT_ZERO_RATE_DOCUMENT ZRD
       SET ZRD.V_11_01_01_1       = 0
         , ZRD.V_11_01_01_2       = 0
         , ZRD.V_11_01_01_3       = 0
         , ZRD.V_11_01_01_4       = 0
         , ZRD.V_11_01_01_5       = 0
         , ZRD.V_11_01_02_1       = 0
         , ZRD.V_11_01_03_1       = 0
         , ZRD.V_11_01_03_2       = 0
         , ZRD.V_11_01_04_1       = 0
         , ZRD.V_11_01_04_2       = 0
         , ZRD.V_11_01_04_3       = 0
         , ZRD.V_11_01_04_4       = 0
         , ZRD.V_11_01_04_5       = 0
         , ZRD.V_11_01_04_6       = 0
         , ZRD.V_11_01_04_7       = 0
         , ZRD.V_11_01_04_8       = 0
         , ZRD.V_SUM_AMT          = 0
         , ZRD.T_105_01_01_1      = 0
         , ZRD.T_105_01_03_1      = 0
         , ZRD.T_105_01_03_2      = 0
         , ZRD.T_105_01_04_1      = 0
         , ZRD.T_105_01_05_1      = 0
         , ZRD.T_107_00_00_0      = 0
         , ZRD.T_121_13_00_0      = 0
         , ZRD.T_SUM_AMT          = 0
         , ZRD.TOTAL_AMT          = 0
      WHERE ZRD.TAX_CODE          = W_TAX_CODE
        AND ZRD.VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL
        AND ZRD.SOB_ID            = W_SOB_ID
        AND ZRD.ORG_ID            = W_ORG_ID
    ;
    
    -- 1.��������(������� ����) --
    -- 1.1. ����������� --
    MERGE INTO FI_VAT_ZERO_RATE_DOCUMENT ZRD
    USING( SELECT W_SOB_ID AS SOB_ID	        --ȸ����̵�
                , W_ORG_ID AS ORG_ID	        --����ξ��̵�
                , W_TAX_CODE AS TAX_CODE      	--�������̵�
                , W_VAT_MNG_SERIAL AS VAT_MNG_SERIAL	--�ΰ����Ű�Ⱓ���й�ȣ
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS BASE_AMOUNT     --��ȭ; ���ް���            
          FROM FI_SLIP_LINE   A
             , FI_SLIP_HEADER B
          WHERE   A.SLIP_HEADER_ID = B.SLIP_HEADER_ID
              AND A.SOB_ID = W_SOB_ID
              AND A.ORG_ID = W_ORG_ID 
              AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����
              AND MANAGEMENT2 = '3'           --�������� : ����
              AND A.REFER11 = W_TAX_CODE      --�����(����/������� ������� �ƴ� ȸ�� �ڷῡ �Ϲ������� ���Ǵ� �������)
              AND EXISTS
                      ( SELECT 'X'
                          FROM FI_VAT_REPORT_MNG VRM
                         WHERE VRM.SOB_ID          = A.SOB_ID
                           AND VRM.ORG_ID          = A.ORG_ID
                           AND VRM.TAX_CODE        = A.REFER11
                           AND VRM.VAT_MNG_SERIAL  = W_VAT_MNG_SERIAL
                           AND TO_DATE(A.REFER1)   BETWEEN VRM.TAX_TERM_FR AND VRM.TAX_TERM_TO
                       )  
          ) SX1
      ON  ( ZRD.TAX_CODE          = SX1.TAX_CODE
        AND ZRD.VAT_MNG_SERIAL    = SX1.VAT_MNG_SERIAL
        AND ZRD.SOB_ID            = SX1.SOB_ID  
        AND ZRD.ORG_ID            = SX1.ORG_ID        
          )
    WHEN MATCHED THEN
      UPDATE 
         SET ZRD.V_11_01_01_1     = NVL(ZRD.V_11_01_01_1, 0) + NVL(SX1.BASE_AMOUNT, 0)
    WHEN NOT MATCHED THEN
      INSERT 
      ( TAX_CODE
      , VAT_MNG_SERIAL  
      , SOB_ID 
      , ORG_ID 
      , V_11_01_01_1 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( W_TAX_CODE
      , W_VAT_MNG_SERIAL
      , W_SOB_ID 
      , W_ORG_ID 
      , NVL(SX1.BASE_AMOUNT, 0)  -- V_11_01_01_1 
      , V_SYSDATE                -- CREATION_DATE 
      , V_USER_ID                -- CREATED_BY 
      , V_SYSDATE                -- LAST_UPDATE_DATE 
      , V_USER_ID                -- LAST_UPDATED_BY 
      )
    ;           
    
    /*-- 2 �߰蹫��/��Ź�Ǹ�/�ܱ��ε� �Ǵ� ��Ź������������� ���� --
    -- 2.1 ��ȭȹ����� -- 
    MERGE INTO FI_VAT_ZERO_RATE_DOCUMENT ZRD
    USING(SELECT
                  SOB_ID	        --ȸ����̵�
                , ORG_ID	        --����ξ��̵�
                , TAX_CODE	      --�������̵�
                , VAT_MNG_SERIAL	--�ΰ����Ű�Ⱓ���й�ȣ
                , SUM(NVL(SUPPLY_AMT, 0)) AS BASE_AMOUNT	    --���ް���               
            FROM FI_FOREIGN_CURRENCY_SPEC
            WHERE SOB_ID = W_SOB_ID
              AND ORG_ID = W_ORG_ID
              AND TAX_CODE = W_TAX_CODE
              AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL                
           GROUP BY SOB_ID	        --ȸ����̵�
                  , ORG_ID	        --����ξ��̵�
                  , TAX_CODE	      --�������̵�
                  , VAT_MNG_SERIAL	--�ΰ����Ű�Ⱓ���й�ȣ
          ) SX1
      ON  ( ZRD.TAX_CODE          = SX1.TAX_CODE
        AND ZRD.VAT_MNG_SERIAL    = SX1.VAT_MNG_SERIAL
        AND ZRD.SOB_ID            = SX1.SOB_ID  
        AND ZRD.ORG_ID            = SX1.ORG_ID        
          )
    WHEN MATCHED THEN
      UPDATE 
         SET ZRD.V_11_01_01_2     = NVL(ZRD.V_11_01_01_2, 0) + NVL(SX1.BASE_AMOUNT, 0)
    WHEN NOT MATCHED THEN
      INSERT 
      ( TAX_CODE
      , VAT_MNG_SERIAL  
      , SOB_ID 
      , ORG_ID 
      , V_11_01_01_2 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( W_TAX_CODE
      , W_VAT_MNG_SERIAL
      , W_SOB_ID 
      , W_ORG_ID 
      , NVL(SX1.BASE_AMOUNT, 0)  -- V_11_01_01_2 
      , V_SYSDATE                -- CREATION_DATE 
      , V_USER_ID                -- CREATED_BY 
      , V_SYSDATE                -- LAST_UPDATE_DATE 
      , V_USER_ID                -- LAST_UPDATED_BY 
      )
    ;     */  
        
    -- 3 �����ſ���/����Ȯ�μ��� ���Ͽ� �����ϴ� ��ȭ 
    -- 3.1 ������÷�μ��� --
    MERGE INTO FI_VAT_ZERO_RATE_DOCUMENT ZRD
    USING(SELECT 
                  SOB_ID            --ȸ����̵�
                , ORG_ID            --����ξ��̵�
                , TAX_CODE          --�������̵�
                , VAT_MNG_SERIAL    --�ΰ����Ű�Ⱓ���й�ȣ
                , SUM(NVL(SUBMIT_KOREAN_AMT, 0)) AS BASE_AMOUNT     --��������ȭ                
            FROM FI_ZERO_TAX_SPEC ZTS
            WHERE ZTS.SOB_ID = W_SOB_ID
              AND ZTS.ORG_ID = W_ORG_ID
              AND ZTS.TAX_CODE = W_TAX_CODE
              AND ZTS.VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
              AND EXISTS
                    ( SELECT 'X'
                        FROM FI_VAT_REPORT_MNG VRM
                       WHERE VRM.SOB_ID          = ZTS.SOB_ID
                         AND VRM.ORG_ID          = ZTS.ORG_ID
                         AND VRM.TAX_CODE        = ZTS.TAX_CODE
                         AND VRM.VAT_MNG_SERIAL  = ZTS.VAT_MNG_SERIAL
                    )
           GROUP BY SOB_ID            --ȸ����̵�
                  , ORG_ID            --����ξ��̵�
                  , TAX_CODE          --�������̵�
                  , VAT_MNG_SERIAL    --�ΰ����Ű�Ⱓ���й�ȣ
          ) SX1
      ON  ( ZRD.TAX_CODE          = SX1.TAX_CODE
        AND ZRD.VAT_MNG_SERIAL    = SX1.VAT_MNG_SERIAL
        AND ZRD.SOB_ID            = SX1.SOB_ID  
        AND ZRD.ORG_ID            = SX1.ORG_ID        
          )
    WHEN MATCHED THEN
      UPDATE 
         SET ZRD.V_11_01_01_3     = NVL(ZRD.V_11_01_01_3, 0) + NVL(SX1.BASE_AMOUNT, 0)
    WHEN NOT MATCHED THEN
      INSERT 
      ( TAX_CODE
      , VAT_MNG_SERIAL  
      , SOB_ID 
      , ORG_ID 
      , V_11_01_01_3 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( W_TAX_CODE
      , W_VAT_MNG_SERIAL
      , W_SOB_ID 
      , W_ORG_ID 
      , NVL(SX1.BASE_AMOUNT, 0)  -- V_11_01_01_3 
      , V_SYSDATE                -- CREATION_DATE 
      , V_USER_ID                -- CREATED_BY 
      , V_SYSDATE                -- LAST_UPDATE_DATE 
      , V_USER_ID                -- LAST_UPDATED_BY 
      )
    ;        
    
    /*-- 3.2 �����ſ��� --
    MERGE INTO FI_VAT_ZERO_RATE_DOCUMENT ZRD
    USING( SELECT
                  SOB_ID	            --ȸ����̵�
                , ORG_ID	            --����ξ��̵�
                , TAX_CODE	    --�������̵�
                , VAT_MNG_SERIAL	    --�ΰ����Ű�Ⱓ���й�ȣ
                , SUM(NVL(SUPPLY_AMT, 0)) AS BASE_AMOUNT	        --�ݾ�
            FROM FI_DOMESTIC_LC       
            WHERE SOB_ID = W_SOB_ID
              AND ORG_ID = W_ORG_ID
              AND TAX_CODE = W_TAX_CODE               --�������̵�
              AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --�ΰ����Ű�Ⱓ���й�ȣ                  
           GROUP BY SOB_ID            --ȸ����̵�
                  , ORG_ID            --����ξ��̵�
                  , TAX_CODE          --�������̵�
                  , VAT_MNG_SERIAL    --�ΰ����Ű�Ⱓ���й�ȣ                          
          ) SX1
      ON  ( ZRD.TAX_CODE          = SX1.TAX_CODE
        AND ZRD.VAT_MNG_SERIAL    = SX1.VAT_MNG_SERIAL
        AND ZRD.SOB_ID            = SX1.SOB_ID  
        AND ZRD.ORG_ID            = SX1.ORG_ID        
          )
    WHEN MATCHED THEN
      UPDATE 
         SET ZRD.V_11_01_01_3     = NVL(ZRD.V_11_01_01_3, 0) + NVL(SX1.BASE_AMOUNT, 0)
    WHEN NOT MATCHED THEN
      INSERT 
      ( TAX_CODE
      , VAT_MNG_SERIAL  
      , SOB_ID 
      , ORG_ID 
      , V_11_01_01_3 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( W_TAX_CODE
      , W_VAT_MNG_SERIAL
      , W_SOB_ID 
      , W_ORG_ID 
      , NVL(SX1.BASE_AMOUNT, 0)  -- V_11_01_01_3 
      , V_SYSDATE                -- CREATION_DATE 
      , V_USER_ID                -- CREATED_BY 
      , V_SYSDATE                -- LAST_UPDATE_DATE 
      , V_USER_ID                -- LAST_UPDATED_BY 
      )
    ;   */    
    
    -- ������ ������� �հ� �ݾ� ��� --
    UPDATE FI_VAT_ZERO_RATE_DOCUMENT ZRD
       SET ZRD.V_SUM_AMT    = NVL(ZRD.V_11_01_01_1, 0) + 
                              NVL(ZRD.V_11_01_01_2 , 0) + 
                              NVL(ZRD.V_11_01_01_3 , 0) + 
                              NVL(ZRD.V_11_01_01_4 , 0) + 
                              NVL(ZRD.V_11_01_01_5 , 0) + 
                              NVL(ZRD.V_11_01_02_1 , 0) + 
                              NVL(ZRD.V_11_01_03_1 , 0) + 
                              NVL(ZRD.V_11_01_03_2 , 0) + 
                              NVL(ZRD.V_11_01_04_1 , 0) + 
                              NVL(ZRD.V_11_01_04_2 , 0) + 
                              NVL(ZRD.V_11_01_04_3 , 0) + 
                              NVL(ZRD.V_11_01_04_4 , 0) + 
                              NVL(ZRD.V_11_01_04_5 , 0) + 
                              NVL(ZRD.V_11_01_04_6 , 0) + 
                              NVL(ZRD.V_11_01_04_7 , 0) + 
                              NVL(ZRD.V_11_01_04_8 , 0)
         , ZRD.T_SUM_AMT    = NVL(ZRD.T_105_01_01_1, 0) + 
                              NVL(ZRD.T_105_01_03_1 , 0) + 
                              NVL(ZRD.T_105_01_03_2 , 0) + 
                              NVL(ZRD.T_105_01_04_1 , 0) + 
                              NVL(ZRD.T_105_01_05_1 , 0) + 
                              NVL(ZRD.T_107_00_00_0 , 0) + 
                              NVL(ZRD.T_121_13_00_0 , 0)
         , ZRD.TOTAL_AMT    = NVL(ZRD.V_11_01_01_1, 0) + 
                              NVL(ZRD.V_11_01_01_2 , 0) + 
                              NVL(ZRD.V_11_01_01_3 , 0) + 
                              NVL(ZRD.V_11_01_01_4 , 0) + 
                              NVL(ZRD.V_11_01_01_5 , 0) + 
                              NVL(ZRD.V_11_01_02_1 , 0) + 
                              NVL(ZRD.V_11_01_03_1 , 0) + 
                              NVL(ZRD.V_11_01_03_2 , 0) + 
                              NVL(ZRD.V_11_01_04_1 , 0) + 
                              NVL(ZRD.V_11_01_04_2 , 0) + 
                              NVL(ZRD.V_11_01_04_3 , 0) + 
                              NVL(ZRD.V_11_01_04_4 , 0) + 
                              NVL(ZRD.V_11_01_04_5 , 0) + 
                              NVL(ZRD.V_11_01_04_6 , 0) + 
                              NVL(ZRD.V_11_01_04_7 , 0) + 
                              NVL(ZRD.V_11_01_04_8 , 0) +
                              NVL(ZRD.T_105_01_01_1, 0) + 
                              NVL(ZRD.T_105_01_03_1 , 0) + 
                              NVL(ZRD.T_105_01_03_2 , 0) + 
                              NVL(ZRD.T_105_01_04_1 , 0) + 
                              NVL(ZRD.T_105_01_05_1 , 0) + 
                              NVL(ZRD.T_107_00_00_0 , 0) + 
                              NVL(ZRD.T_121_13_00_0 , 0)
     WHERE ZRD.SOB_ID = W_SOB_ID
       AND ZRD.ORG_ID = W_ORG_ID
       AND ZRD.TAX_CODE = W_TAX_CODE               --�������̵�
       AND ZRD.VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --�ΰ����Ű�Ⱓ���й�ȣ      
    ;
    
    O_STATUS := 'S';
  EXCEPTION WHEN OTHERS THEN
    O_STATUS := 'F';
    O_MESSAGE := 'Creation Data Error : ' || SUBSTR(SQLERRM, 1, 150);
  END SET_SUM_ZERO_RATE_DOCUMENT;




  --  ����� �������� �μ� -- 
  PROCEDURE PRINT_ZERO_RATE_DOCUMENT
            ( P_CURSOR          OUT TYPES.TCURSOR
            , W_SOB_ID          IN  NUMBER  --ȸ����̵�
            , W_ORG_ID          IN  NUMBER  --����ξ��̵� 
            , W_TAX_CODE        IN  VARCHAR2
            , W_VAT_MNG_SERIAL  IN  NUMBER
            , W_DEAL_DATE_FR    IN  DATE    --�ŷ��Ⱓ_����
            , W_DEAL_DATE_TO    IN  DATE    --�ŷ��Ⱓ_����    
            )

  AS
    V_FY                VARCHAR2(4);
    V_VAT_REPORT_TURN   VARCHAR2(70);
    V_VAT_REPORT_GB     VARCHAR2(70);
  BEGIN
    BEGIN
      SELECT VRM.FY 
           , VRM.VAT_REPORT_TURN 
           , VRM.VAT_REPORT_GB 
        INTO V_FY
           , V_VAT_REPORT_TURN 
           , V_VAT_REPORT_GB 
        FROM FI_VAT_REPORT_MNG VRM
       WHERE VRM.SOB_ID         = W_SOB_ID
         AND VRM.ORG_ID         = W_ORG_ID
         AND VRM.TAX_CODE       = W_TAX_CODE
         AND VRM.VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
      ;
    EXCEPTION WHEN OTHERS THEN
      V_FY := TO_CHAR(W_DEAL_DATE_TO, 'YYYY');
      IF TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'MM')) <= 6 THEN
        V_VAT_REPORT_TURN := '01';
      ELSE
        V_VAT_REPORT_TURN := '02';
      END IF;
      IF TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'MM')) IN(3, 9) THEN
        V_VAT_REPORT_GB := '01';
      ELSE
        V_VAT_REPORT_GB := '02';
      END IF;
    END;            
    
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
          /*, TO_CHAR(W_CREATE_DATE, 'YYYY') || '�� ' 
            || TO_NUMBER(TO_CHAR(W_CREATE_DATE, 'MM')) || '�� ' 
            || TO_NUMBER(TO_CHAR(W_CREATE_DATE, 'DD')) || '��'  AS CREATE_DATE   --�ۼ����� 
          , TO_CHAR(TO_DATE('20110630'), 'YYYY')  || ' ��  '
            || TO_NUMBER(TO_CHAR(TO_DATE('20110401'), 'MM')) || '��  ' || TO_NUMBER(TO_CHAR(TO_DATE('20110401'), 'DD'))  || '��  ~  '
            || TO_NUMBER(TO_CHAR(TO_DATE('20110630'), 'MM')) || '��  ' || TO_NUMBER(TO_CHAR(TO_DATE('20110630'), 'DD')) || '�� ' AS DEAL_TERM    --�ŷ��Ⱓ*/
          , '(   ' || V_FY || '  ��   �� ' ||  
            V_VAT_REPORT_TURN || '  ��  ' ||  
            CASE
              WHEN V_VAT_REPORT_GB = '01' THEN '[ V ] ����   [   ] Ȯ��   )' 
              ELSE '[   ] ����   [ V ] Ȯ��   )' 
            END AS FISCAL_TITLE   --�ΰ���ġ���Ű���          
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
          AND B.ENABLED_FLAG          = 'Y'
          AND (B.DEFAULT_FLAG         = 'Y'
          OR   ROWNUM                 <= 1)
          ;
  END PRINT_ZERO_RATE_DOCUMENT;

  
END FI_VAT_ZERO_RATE_DOCUMENT_G;
/
