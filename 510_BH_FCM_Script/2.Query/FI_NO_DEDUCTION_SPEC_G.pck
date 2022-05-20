CREATE OR REPLACE PACKAGE FI_NO_DEDUCTION_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_NO_DEDUCTION_SPEC_G
Description  : �����������Ҹ��Լ��׸��� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (�����������Ҹ��Լ��׸���)
Program History :
    -.�ڷ� ���� ���� : �ŷ�����-����, ��������-���Լ��׺Ұ���
      �̴� [���Ը�����]���α׷����� �ŷ������� �������� ���������� ���Լ��׺Ұ����� ��ȸ�� �ڷ�� ��ġ�Ѵ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-27   Leem Dong Ern(�ӵ���)
*****************************************************************************/


--�� ���� �ڷ� ���� --
PROCEDURE CREATE_NO_DEDUCTION(
      W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_���� 
);





--�� ���� �ڷ�
PROCEDURE LIST_NO_DEDUCTION(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_���� 
);







--�հ� �κ� ��ȸ
PROCEDURE SUM_NO_DEDUCTION(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����
);


-- �հ� �κ� ������Ʈ --
PROCEDURE UPDATE_NO_DEDUCTION
          ( W_TAX_CODE         IN FI_NO_DEDUCTION_SPEC.TAX_CODE%TYPE
          , W_SOB_ID           IN FI_NO_DEDUCTION_SPEC.SOB_ID%TYPE
          , W_ORG_ID           IN FI_NO_DEDUCTION_SPEC.ORG_ID%TYPE
          , W_VAT_DATE_FR      IN FI_NO_DEDUCTION_SPEC.VAT_DATE_FR%TYPE
          , W_VAT_DATE_TO      IN FI_NO_DEDUCTION_SPEC.VAT_DATE_TO%TYPE
          , W_NO_DED_TYPE      IN FI_NO_DEDUCTION_SPEC.NO_DED_TYPE%TYPE
          , W_NO_DED_CODE      IN FI_NO_DEDUCTION_SPEC.NO_DED_CODE%TYPE
          , P_NO_DED_DESC      IN FI_NO_DEDUCTION_SPEC.NO_DED_DESC%TYPE
          , P_VAT_COUNT        IN FI_NO_DEDUCTION_SPEC.VAT_COUNT%TYPE
          , P_GL_AMOUNT        IN FI_NO_DEDUCTION_SPEC.GL_AMOUNT%TYPE
          , P_VAT_AMOUNT       IN FI_NO_DEDUCTION_SPEC.VAT_AMOUNT%TYPE
          , P_SORT_NUM         IN FI_NO_DEDUCTION_SPEC.SORT_NUM%TYPE
          , P_REMARK           IN FI_NO_DEDUCTION_SPEC.REMARK%TYPE
          , P_USER_ID          IN FI_NO_DEDUCTION_SPEC.CREATED_BY%TYPE
          );




--������ 3.������Լ��� �Ⱥа�� ���� > 12.�Ѱ��ް��׵� �� ���� �ݾ�
PROCEDURE SUM_SUPPLY_AMT(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����
);






--�����������Ҹ��Լ��׸��� ��� ��¿�
PROCEDURE PRINT_NO_DEDUCTION_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)       
    , W_DEAL_DATE_FR        IN  DATE    --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�ŷ��Ⱓ_����  
);






END FI_NO_DEDUCTION_SPEC_G;
/
CREATE OR REPLACE PACKAGE BODY FI_NO_DEDUCTION_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_NO_DEDUCTION_SPEC_G
Description  : �����������Ҹ��Լ��׸��� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (�����������Ҹ��Լ��׸���)
Program History :
    -.�ڷ� ���� ���� : �ŷ�����-����, ��������-���Լ��׺Ұ���
      �̴� [���Ը�����]���α׷����� �ŷ������� �������� ���������� ���Լ��׺Ұ����� ��ȸ�� �ڷ�� ��ġ�Ѵ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-27   Leem Dong Ern(�ӵ���)
*****************************************************************************/



--�� ���� �ڷ� ���� --
PROCEDURE CREATE_NO_DEDUCTION(
      W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_���� 
    )
AS
  V_SYSDATE             DATE := GET_LOCAL_DATE(W_SOB_ID);
BEGIN
  -- 1. ���Լ��� �Ұ��� ���� --
    FOR C1 IN ( SELECT    '10' AS NO_DED_TYPE
                        , CASE
                            WHEN GROUPING(B.CODE) = 1 THEN '99'
                            ELSE B.CODE
                          END AS NO_DED_CODE
                        , CASE
                            WHEN GROUPING(B.CODE) = 1 THEN '��                      ��'
                            ELSE B.CODE_NAME
                          END AS NO_DED_CODE_NAME                     --���Լ��� �Ұ��� ����
                        , SUM(CNT) AS CNT                      --�ż�
                        , SUM(T.GL_AMOUNT) AS GL_AMOUNT        --���ް���
                        , SUM(T.VAT_AMOUNT) AS VAT_AMOUNT      --���Լ���
                        , '' REMARKS                           --���
                        , CASE
                            WHEN GROUPING(B.CODE) = 1 THEN 99
                            ELSE B.SORT_NUM
                          END AS SORT_NUM                      --���ļ���
                        , DECODE(GROUPING(B.CODE), 1, 'Y', 'N') AS SUMMARY_FLAG
                    FROM
                        (
                        SELECT
                              CODE
                            , COUNT(*) AS CNT
                            , SUM(GL_AMOUNT) AS GL_AMOUNT
                            , SUM(VAT_AMOUNT) AS VAT_AMOUNT
                        FROM
                            (
                                SELECT
                                      A.SOB_ID
                                    , A.ORG_ID
                                    , A.REFER3 AS CODE --���������ڵ�
                                    , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --���ް���
                                    , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --����                 
                                FROM FI_SLIP_LINE A
                                WHERE A.SOB_ID = W_SOB_ID
                                    AND A.ORG_ID = W_ORG_ID
                                    
                                    --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
                                    AND A.ACCOUNT_CODE IN 
                                        (
                                            SELECT ACCOUNT_CODE
                                            FROM FI_ACCOUNT_CONTROL
                                            WHERE SOB_ID = W_SOB_ID 
                                              AND ORG_ID = W_ORG_ID 
                                              AND ACCOUNT_SET_ID = '10'
                                              AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
                                        )  --�ŷ�����(����/����) 
                                        
                                    AND A.MANAGEMENT2 = W_TAX_CODE              --�����
                                    AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                                    AND REFER1 = '3' --�������� : ���Լ��׺Ұ���
                            )
                        GROUP BY SOB_ID, ORG_ID, CODE
                        ) T,
                        (   --�� VIEW���� �����ڷḦ �����ϴ�.
                            SELECT CODE, CODE_NAME, SORT_NUM
                            FROM FI_COMMON
                            WHERE GROUP_CODE    = 'VAT_REASON' 
                              AND VALUE2        = '3' 
                              AND VALUE3        = 'Y'    
                              AND ENABLED_FLAG  = 'Y'
                              AND EFFECTIVE_DATE_FR <= W_DEAL_DATE_TO
                              AND (EFFECTIVE_DATE_TO >= W_DEAL_DATE_FR OR EFFECTIVE_DATE_TO IS NULL)
                        ) B
                    WHERE B.CODE = T.CODE(+)    
                GROUP BY ROLLUP(( B.CODE
                                , B.CODE_NAME                     --���Լ��� �Ұ��� ����
                                , B.SORT_NUM))    
                ORDER BY B.SORT_NUM   
                )
    LOOP
      MERGE INTO FI_NO_DEDUCTION_SPEC DS
      USING ( SELECT W_TAX_CODE AS TAX_CODE
                   , W_SOB_ID   AS SOB_ID
                   , W_ORG_ID   AS ORG_ID
                   , W_DEAL_DATE_FR AS VAT_DATE_FR
                   , W_DEAL_DATE_TO AS VAT_DATE_TO
                   , C1.NO_DED_TYPE AS NO_DED_TYPE
                   , C1.NO_DED_CODE AS NO_DED_CODE
                   , C1.NO_DED_CODE_NAME AS NO_DED_DESC
                   , C1.CNT         AS VAT_CNT
                   , C1.GL_AMOUNT   AS GL_AMOUNT
                   , C1.VAT_AMOUNT  AS VAT_AMOUNT
                   , C1.REMARKS     AS REMARK
                   , C1.SORT_NUM    AS SORT_NUM
                FROM DUAL
            ) SX1
      ON    ( DS.TAX_CODE         = SX1.TAX_CODE
          AND DS.SOB_ID           = SX1.SOB_ID
          AND DS.ORG_ID           = SX1.ORG_ID
          AND DS.VAT_DATE_FR      = SX1.VAT_DATE_FR
          AND DS.VAT_DATE_TO      = SX1.VAT_DATE_TO
          AND DS.NO_DED_TYPE      = SX1.NO_DED_TYPE
          AND DS.NO_DED_CODE      = SX1.NO_DED_CODE
            )
      WHEN MATCHED THEN
        UPDATE
           SET DS.NO_DED_DESC     = SX1.NO_DED_DESC
             , DS.VAT_COUNT       = NVL(SX1.VAT_CNT, 0)
             , DS.GL_AMOUNT       = NVL(SX1.GL_AMOUNT, 0)
             , DS.VAT_AMOUNT      = NVL(SX1.VAT_AMOUNT, 0)
             , DS.REMARK          = SX1.REMARK
             , DS.SORT_NUM        = NVL(SX1.SORT_NUM, 0)
             , DS.SUMMARY_FLAG    = NVL(C1.SUMMARY_FLAG, 'N') 
             , LAST_UPDATE_DATE   = V_SYSDATE
             , LAST_UPDATED_BY    = NVL(GET_USER_ID_F, -1)
      WHEN NOT MATCHED THEN
        INSERT 
        ( TAX_CODE 
        , SOB_ID 
        , ORG_ID 
        , VAT_DATE_FR
        , VAT_DATE_TO
        , NO_DED_TYPE 
        , NO_DED_CODE 
        , NO_DED_DESC 
        , VAT_COUNT 
        , GL_AMOUNT 
        , VAT_AMOUNT 
        , SORT_NUM 
        , REMARK 
        , SUMMARY_FLAG
        , CLOSED_YN 
        , CREATION_DATE 
        , CREATED_BY 
        , LAST_UPDATE_DATE 
        , LAST_UPDATED_BY 
        ) VALUES
        ( SX1.TAX_CODE 
        , SX1.SOB_ID 
        , SX1.ORG_ID 
        , SX1.VAT_DATE_FR
        , SX1.VAT_DATE_TO
        , SX1.NO_DED_TYPE 
        , SX1.NO_DED_CODE 
        , SX1.NO_DED_DESC
        , SX1.VAT_CNT 
        , SX1.GL_AMOUNT 
        , SX1.VAT_AMOUNT 
        , SX1.SORT_NUM 
        , SX1.REMARK 
        , NVL(C1.SUMMARY_FLAG, 'N') 
        , 'Y' -- CLOSED_YN 
        , V_SYSDATE --CREATION_DATE 
        , NVL(GET_USER_ID_F, -1) --CREATED_BY 
        , V_SYSDATE --LAST_UPDATE_DATE 
        , NVL(GET_USER_ID_F, -1) --LAST_UPDATED_BY 
        );     
    END LOOP C1;
                          
    -- 2. �Ⱥм��� ��� --
    FOR C1 IN (SELECT '20' AS NO_DED_TYPE                    
                    , B.NO_DED_CODE AS NO_DED_CODE
                    , ND.NO_DED_DESC AS NO_DED_DESC                     --���Լ��� �Ұ��� ����
                    , NULL AS VAT_CNT
                    , (B.GL_AMOUNT) AS GL_AMOUNT 
                    , (B.VAT_AMOUNT) AS VAT_AMOUNT 
                    , NULL AS REMARKS
                    , ND.SORT_NUM 
                    , NVL(B.SUMMARY_FLAG, 'N') AS SUMMARY_FLAG
                  FROM FI_VAT_NO_DED_V ND
                     , (SELECT  '110' AS NO_DED_CODE
                              , '3.������Լ��� �Ⱥа�� ����' AS NO_DED_CODE_NAME --����
                              , 0 AS GL_AMOUNT     --���ް���(�����)
                              , 0 AS VAT_AMOUNT    --����
                              , 'N' AS SUMMARY_FLAG
                        FROM DUAL  

                        UNION ALL

                        SELECT  '120' AS NO_DED_CODE
                              , '4.������Լ����� ���� ����' AS NO_DED_CODE_NAME --����
                              , 0 AS GL_AMOUNT     --���ް���(�����)
                              , 0 AS VAT_AMOUNT    --����
                              , 'N' AS SUMMARY_FLAG
                        FROM DUAL  

                        UNION ALL

                        SELECT  '130' AS NO_DED_CODE
                              , '5.���μ��� �Ǵ� ȯ�޼��� ���� ����' AS NO_DED_CODE_NAME --����
                              , 0 AS GL_AMOUNT     --���ް���(�����)
                              , 0 AS VAT_AMOUNT    --����
                              , 'N' AS SUMMARY_FLAG
                        FROM DUAL                          
                        
                        UNION ALL

                        SELECT  '990' AS NO_DED_CODE
                              , '�Ѱ�(�Ұ������Լ���, �Ⱥ�, ����, ����)' AS NO_DED_CODE_NAME --����
                              , 0 AS GL_AMOUNT     --���ް���(�����)
                              , 0 AS VAT_AMOUNT    --����\
                              , 'Y' AS SUMMARY_FLAG
                        FROM DUAL      
                        ) B
                 WHERE ND.NO_DED_CODE   = B.NO_DED_CODE(+)
                   AND ND.NO_DED_TYPE   = '20'
                   AND ND.ENABLED_FLAG  = 'Y'
            	     AND ND.EFFECTIVE_DATE_FR  <= W_DEAL_DATE_TO
                   AND (ND.EFFECTIVE_DATE_TO >= W_DEAL_DATE_FR OR ND.EFFECTIVE_DATE_TO IS NULL)
              )
    LOOP
      MERGE INTO FI_NO_DEDUCTION_SPEC DS
      USING ( SELECT W_TAX_CODE AS TAX_CODE
                   , W_SOB_ID   AS SOB_ID
                   , W_ORG_ID   AS ORG_ID
                   , W_DEAL_DATE_FR AS VAT_DATE_FR
                   , W_DEAL_DATE_TO AS VAT_DATE_TO
                   , C1.NO_DED_TYPE AS NO_DED_TYPE
                   , C1.NO_DED_CODE AS NO_DED_CODE
                   , C1.NO_DED_DESC AS NO_DED_DESC
                   , C1.VAT_CNT     AS VAT_CNT
                   , C1.GL_AMOUNT   AS GL_AMOUNT
                   , C1.VAT_AMOUNT  AS VAT_AMOUNT
                   , C1.REMARKS     AS REMARK
                   , C1.SORT_NUM    AS SORT_NUM
                FROM DUAL
            ) SX1
      ON    ( DS.TAX_CODE         = SX1.TAX_CODE
          AND DS.SOB_ID           = SX1.SOB_ID
          AND DS.ORG_ID           = SX1.ORG_ID
          AND DS.VAT_DATE_FR      = SX1.VAT_DATE_FR
          AND DS.VAT_DATE_TO      = SX1.VAT_DATE_TO
          AND DS.NO_DED_TYPE      = SX1.NO_DED_TYPE
          AND DS.NO_DED_CODE      = SX1.NO_DED_CODE
            )
      WHEN MATCHED THEN
        UPDATE
           SET DS.NO_DED_DESC     = SX1.NO_DED_DESC
             , DS.SORT_NUM        = NVL(SX1.SORT_NUM, 0)
             , DS.SUMMARY_FLAG    = NVL(C1.SUMMARY_FLAG, 'N') 
             , LAST_UPDATE_DATE   = V_SYSDATE
             , LAST_UPDATED_BY    = NVL(GET_USER_ID_F, -1)
      WHEN NOT MATCHED THEN
        INSERT 
        ( TAX_CODE 
        , SOB_ID 
        , ORG_ID 
        , VAT_DATE_FR
        , VAT_DATE_TO
        , NO_DED_TYPE 
        , NO_DED_CODE 
        , NO_DED_DESC 
        , VAT_COUNT 
        , GL_AMOUNT 
        , VAT_AMOUNT 
        , SORT_NUM 
        , REMARK 
        , SUMMARY_FLAG
        , CLOSED_YN 
        , CREATION_DATE 
        , CREATED_BY 
        , LAST_UPDATE_DATE 
        , LAST_UPDATED_BY 
        ) VALUES
        ( SX1.TAX_CODE 
        , SX1.SOB_ID 
        , SX1.ORG_ID 
        , SX1.VAT_DATE_FR
        , SX1.VAT_DATE_TO
        , SX1.NO_DED_TYPE 
        , SX1.NO_DED_CODE 
        , SX1.NO_DED_DESC
        , SX1.VAT_CNT 
        , SX1.GL_AMOUNT 
        , SX1.VAT_AMOUNT 
        , SX1.SORT_NUM 
        , SX1.REMARK 
        , NVL(C1.SUMMARY_FLAG, 'N') 
        , 'Y' -- CLOSED_YN 
        , V_SYSDATE --CREATION_DATE 
        , NVL(GET_USER_ID_F, -1) --CREATED_BY 
        , V_SYSDATE --LAST_UPDATE_DATE 
        , NVL(GET_USER_ID_F, -1) --LAST_UPDATED_BY 
        );    
    END LOOP C1;
    
    -- 3.1 �Ұ��� ���� : �����ϴ� �׸� ���� --
    DELETE FROM FI_NO_DEDUCTION_SPEC DS
     WHERE DS.TAX_CODE          = W_TAX_CODE
       AND DS.SOB_ID            = W_SOB_ID
       AND DS.ORG_ID            = W_ORG_ID
       AND DS.VAT_DATE_FR       = W_DEAL_DATE_FR
       AND DS.VAT_DATE_TO       = W_DEAL_DATE_TO  
       AND DS.NO_DED_TYPE       = '10'          
       AND DS.SUMMARY_FLAG      = 'N'
       AND NOT EXISTS
             (SELECT 'X'
                FROM FI_COMMON FC
              WHERE FC.GROUP_CODE    = 'VAT_REASON' 
                AND FC.VALUE2        = '3' 
                AND FC.VALUE3        = 'Y'    
                AND FC.CODE          = DS.NO_DED_CODE
                AND FC.SOB_ID        = DS.SOB_ID
                AND FC.ORG_ID        = DS.ORG_ID
                AND FC.ENABLED_FLAG  = 'Y'
                AND FC.EFFECTIVE_DATE_FR <= W_DEAL_DATE_TO
                AND (FC.EFFECTIVE_DATE_TO >= W_DEAL_DATE_FR OR FC.EFFECTIVE_DATE_TO IS NULL)
             )
    ;
    -- 3.2 �Ⱥа�곻�� : �����ϴ� �׸� ���� --
    DELETE FROM FI_NO_DEDUCTION_SPEC DS
     WHERE DS.TAX_CODE          = W_TAX_CODE
       AND DS.SOB_ID            = W_SOB_ID
       AND DS.ORG_ID            = W_ORG_ID
       AND DS.VAT_DATE_FR       = W_DEAL_DATE_FR
       AND DS.VAT_DATE_TO       = W_DEAL_DATE_TO  
       AND DS.NO_DED_TYPE       = '20' 
       AND DS.SUMMARY_FLAG      = 'N' 
       AND NOT EXISTS
             (SELECT 'X'
                FROM FI_VAT_NO_DED_V ND
              WHERE ND.NO_DED_TYPE   = DS.NO_DED_TYPE
                AND ND.NO_DED_CODE   = DS.NO_DED_CODE
                AND ND.SOB_ID        = DS.SOB_ID
                AND ND.ORG_ID        = DS.ORG_ID
                AND ND.ENABLED_FLAG  = 'Y'
                AND ND.EFFECTIVE_DATE_FR  <= W_DEAL_DATE_TO
                AND (ND.EFFECTIVE_DATE_TO >= W_DEAL_DATE_FR OR ND.EFFECTIVE_DATE_TO IS NULL)
             )
    ;
    
    -- 3. �Ѱ� ���� --
    UPDATE FI_NO_DEDUCTION_SPEC DS
      SET (DS.GL_AMOUNT
        , DS.VAT_AMOUNT
        , DS.LAST_UPDATE_DATE
        , DS.LAST_UPDATED_BY) =
          ( SELECT SUM(NVL(NDS.GL_AMOUNT, 0)) AS SUM_GL_AMOUNT
                 , SUM(NVL(NDS.VAT_AMOUNT, 0)) AS SUM_VAT_AMOUNT
                 , V_SYSDATE AS LAST_UPDATE_DATE 
                 , NVL(GET_USER_ID_F, -1) AS LAST_UPDATED_BY 
              FROM FI_NO_DEDUCTION_SPEC NDS
             WHERE NDS.TAX_CODE       = DS.TAX_CODE
               AND NDS.SOB_ID         = DS.SOB_ID
               AND NDS.ORG_ID         = DS.ORG_ID
               AND NDS.VAT_DATE_FR    = DS.VAT_DATE_FR
               AND NDS.VAT_DATE_TO    = DS.VAT_DATE_TO
               AND NDS.SUMMARY_FLAG   = 'N'
          )
     WHERE DS.TAX_CODE          = W_TAX_CODE
       AND DS.SOB_ID            = W_SOB_ID
       AND DS.ORG_ID            = W_ORG_ID
       AND DS.VAT_DATE_FR       = W_DEAL_DATE_FR
       AND DS.VAT_DATE_TO       = W_DEAL_DATE_TO
       AND DS.NO_DED_TYPE       = '20'
       AND DS.NO_DED_CODE       = '990'  -- �Ѱ�(�Ұ������Լ���, �Ⱥ�, ����, ����) 
    ;

END CREATE_NO_DEDUCTION;




--�� ���� �ڷ�
PROCEDURE LIST_NO_DEDUCTION(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)  
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_���� 
)

AS

BEGIN
    
    CREATE_NO_DEDUCTION(
        W_SOB_ID              => W_SOB_ID
      , W_ORG_ID              => W_ORG_ID
      , W_TAX_CODE            => W_TAX_CODE
      , W_DEAL_DATE_FR        => W_DEAL_DATE_FR
      , W_DEAL_DATE_TO        => W_DEAL_DATE_TO 
      );
    
    OPEN P_CURSOR FOR
      SELECT DS.NO_DED_DESC
           , DS.VAT_COUNT
           , DS.GL_AMOUNT
           , DS.VAT_AMOUNT
           , DS.REMARK
           , DS.SORT_NUM
           , DS.NO_DED_CODE
           , DS.NO_DED_TYPE
        FROM FI_NO_DEDUCTION_SPEC DS
       WHERE DS.TAX_CODE          = W_TAX_CODE
         AND DS.SOB_ID            = W_SOB_ID
         AND DS.ORG_ID            = W_ORG_ID
         AND DS.VAT_DATE_FR       = W_DEAL_DATE_FR
         AND DS.VAT_DATE_TO       = W_DEAL_DATE_TO
         AND DS.NO_DED_TYPE       = '10'
      ORDER BY DS.SORT_NUM
      ;
    /*SELECT
          B.CODE_NAME   --���Լ��� �Ұ��� ����
        , CNT           --�ż�
        , T.GL_AMOUNT   --���ް���
        , T.VAT_AMOUNT  --���Լ���
        , '' REMARKS    --���
        , B.SORT_NUM    --���ļ���
    FROM
        (
        SELECT
              CODE
            , COUNT(*) AS CNT
            , SUM(GL_AMOUNT) AS GL_AMOUNT
            , SUM(VAT_AMOUNT) AS VAT_AMOUNT
        FROM
            (
                SELECT
                      A.SOB_ID
                    , A.ORG_ID
                    , A.REFER3 AS CODE --���������ڵ�
                    , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --���ް���
                    , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --����                 
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID
                    
                    --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
                    AND A.ACCOUNT_CODE IN 
                        (
                            SELECT ACCOUNT_CODE
                            FROM FI_ACCOUNT_CONTROL
                            WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                                AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
                        )  --�ŷ�����(����/����) 
                        
                    AND A.MANAGEMENT2 = W_TAX_CODE              --�����
                    AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                    AND REFER1 = '3' --�������� : ���Լ��׺Ұ���
            )
        GROUP BY SOB_ID, ORG_ID, CODE
        ) T,
        (   --�� VIEW���� �����ڷḦ �����ϴ�.
            SELECT CODE, CODE_NAME, SORT_NUM
            FROM FI_COMMON
            WHERE GROUP_CODE = 'VAT_REASON' AND VALUE2 = '3' AND VALUE3 = 'Y'    
        ) B
    WHERE B.CODE = T.CODE(+)    
        
    UNION ALL    

    SELECT
         '��                      ��' CODE_NAME
        , COUNT(*) AS CNT
        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --���� 
        , '' REMARKS    
        , 99 SORT_NUM
    FROM FI_SLIP_LINE A
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        
        --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
        AND A.ACCOUNT_CODE IN 
            (
                SELECT ACCOUNT_CODE
                FROM FI_ACCOUNT_CONTROL
                WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                    AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
            )  --�ŷ�����(����/����)    
        
        AND A.MANAGEMENT2 = W_TAX_CODE              --�����
        AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
        AND REFER1 = '3' --��������
    ORDER BY SORT_NUM   ;*/
    

END LIST_NO_DEDUCTION;








--�հ� �κ� ��ȸ
PROCEDURE SUM_NO_DEDUCTION(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����
)

AS

BEGIN

    OPEN P_CURSOR FOR
      SELECT DS.NO_DED_DESC
             , DS.GL_AMOUNT
             , DS.VAT_AMOUNT
             , DS.REMARK
             , DS.SORT_NUM
             , DS.NO_DED_CODE
             , DS.NO_DED_TYPE
          FROM FI_NO_DEDUCTION_SPEC DS
         WHERE DS.TAX_CODE          = W_TAX_CODE
           AND DS.SOB_ID            = W_SOB_ID
           AND DS.ORG_ID            = W_ORG_ID
           AND DS.VAT_DATE_FR       = W_DEAL_DATE_FR
           AND DS.VAT_DATE_TO       = W_DEAL_DATE_TO
           AND DS.NO_DED_TYPE       = '20'
        ORDER BY DS.SORT_NUM
        ;
        
    /*SELECT 
          '3.������Լ��� �Ⱥа�� ����' AS GUBUN --����
        , 0 AS GL_AMOUNT     --���ް���(�����)
        , 0 AS VAT_AMOUNT    --����
    FROM DUAL  

    UNION ALL

    SELECT 
          '4.������Լ����� ���� ����' AS GUBUN --����
        , 0 AS GL_AMOUNT     --���ް���(�����)
        , 0 AS VAT_AMOUNT    --����
    FROM DUAL  

    UNION ALL

    SELECT 
          '5.���μ��� �Ǵ� ȯ�޼��� ���� ����' AS GUBUN --����
        , 0 AS GL_AMOUNT     --���ް���(�����)
        , 0 AS VAT_AMOUNT    --����
    FROM DUAL  

    UNION ALL

    SELECT
          '�Ѱ�(�Ұ������Լ���, �Ⱥ�, ����, ����)' AS GUBUN --����
        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���(�����)
        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����                 
    FROM FI_SLIP_LINE A
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID
        
        --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
        AND A.ACCOUNT_CODE IN 
            (
                SELECT ACCOUNT_CODE
                FROM FI_ACCOUNT_CONTROL
                WHERE SOB_ID = W_SOB_ID and ORG_ID = W_ORG_ID and ACCOUNT_SET_ID = '10'
                    AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�
            )  --�ŷ�����(����/����) 
            
        AND A.MANAGEMENT2 = W_TAX_CODE              --�����
        AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
        AND REFER1 = '3' --��������
        ;*/

END SUM_NO_DEDUCTION;


-- �հ� �κ� ������Ʈ --
PROCEDURE UPDATE_NO_DEDUCTION
          ( W_TAX_CODE         IN FI_NO_DEDUCTION_SPEC.TAX_CODE%TYPE
          , W_SOB_ID           IN FI_NO_DEDUCTION_SPEC.SOB_ID%TYPE
          , W_ORG_ID           IN FI_NO_DEDUCTION_SPEC.ORG_ID%TYPE
          , W_VAT_DATE_FR      IN FI_NO_DEDUCTION_SPEC.VAT_DATE_FR%TYPE
          , W_VAT_DATE_TO      IN FI_NO_DEDUCTION_SPEC.VAT_DATE_TO%TYPE
          , W_NO_DED_TYPE      IN FI_NO_DEDUCTION_SPEC.NO_DED_TYPE%TYPE
          , W_NO_DED_CODE      IN FI_NO_DEDUCTION_SPEC.NO_DED_CODE%TYPE
          , P_NO_DED_DESC      IN FI_NO_DEDUCTION_SPEC.NO_DED_DESC%TYPE
          , P_VAT_COUNT        IN FI_NO_DEDUCTION_SPEC.VAT_COUNT%TYPE
          , P_GL_AMOUNT        IN FI_NO_DEDUCTION_SPEC.GL_AMOUNT%TYPE
          , P_VAT_AMOUNT       IN FI_NO_DEDUCTION_SPEC.VAT_AMOUNT%TYPE
          , P_SORT_NUM         IN FI_NO_DEDUCTION_SPEC.SORT_NUM%TYPE
          , P_REMARK           IN FI_NO_DEDUCTION_SPEC.REMARK%TYPE
          , P_USER_ID          IN FI_NO_DEDUCTION_SPEC.CREATED_BY%TYPE
          )
AS
  V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
BEGIN
  UPDATE FI_NO_DEDUCTION_SPEC DS
    SET DS.GL_AMOUNT        = P_GL_AMOUNT
      , DS.VAT_AMOUNT       = P_VAT_AMOUNT
      , DS.LAST_UPDATE_DATE = V_SYSDATE
      , DS.LAST_UPDATED_BY  = P_USER_ID
  WHERE DS.TAX_CODE         = W_TAX_CODE
    AND DS.SOB_ID           = W_SOB_ID
    AND DS.ORG_ID           = W_ORG_ID
    AND DS.VAT_DATE_FR      = W_VAT_DATE_FR
    AND DS.VAT_DATE_TO      = W_VAT_DATE_TO
    AND DS.NO_DED_TYPE      = W_NO_DED_TYPE
    AND DS.NO_DED_CODE      = W_NO_DED_CODE
  ;

  -- 3. �Ѱ� ���� --
  UPDATE FI_NO_DEDUCTION_SPEC DS
    SET (DS.GL_AMOUNT
      , DS.VAT_AMOUNT
      , DS.LAST_UPDATE_DATE
      , DS.LAST_UPDATED_BY) =
        ( SELECT SUM(NVL(NDS.GL_AMOUNT, 0)) AS SUM_GL_AMOUNT
               , SUM(NVL(NDS.VAT_AMOUNT, 0)) AS SUM_VAT_AMOUNT
               , V_SYSDATE AS LAST_UPDATE_DATE 
               , NVL(GET_USER_ID_F, -1) AS LAST_UPDATED_BY 
            FROM FI_NO_DEDUCTION_SPEC NDS
           WHERE NDS.TAX_CODE       = DS.TAX_CODE
             AND NDS.SOB_ID         = DS.SOB_ID
             AND NDS.ORG_ID         = DS.ORG_ID
             AND NDS.VAT_DATE_FR    = DS.VAT_DATE_FR
             AND NDS.VAT_DATE_TO    = DS.VAT_DATE_TO
             AND NDS.SUMMARY_FLAG   = 'N'
        )
   WHERE DS.TAX_CODE          = W_TAX_CODE
     AND DS.SOB_ID            = W_SOB_ID
     AND DS.ORG_ID            = W_ORG_ID
     AND DS.VAT_DATE_FR       = W_VAT_DATE_FR
     AND DS.VAT_DATE_TO       = W_VAT_DATE_TO
     AND DS.NO_DED_TYPE       = '20'
     AND DS.NO_DED_CODE       = '990'  -- �Ѱ�(�Ұ������Լ���, �Ⱥ�, ����, ����) 
  ;

END UPDATE_NO_DEDUCTION;





--������ 3.������Լ��� �Ⱥа�� ���� > 12.�Ѱ��ް��׵� �� ���� �ݾ�
PROCEDURE SUM_SUPPLY_AMT(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
        SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���           
    FROM FI_SLIP_LINE A
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID
        
        --AND A.ACCOUNT_CODE = '2100700'    --�ŷ�����(����/����)
        AND A.ACCOUNT_CODE IN 
            (
                SELECT ACCOUNT_CODE
                FROM FI_ACCOUNT_CONTROL
                WHERE SOB_ID = W_SOB_ID and ORG_ID = W_ORG_ID and ACCOUNT_SET_ID = '10'
                    AND ACCOUNT_CLASS_ID = '1972'   --����Ÿ�� : �ΰ���������
            )  --�ŷ�����(����/����)
            
        AND A.REFER11 = W_TAX_CODE                  --�����
        AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
        AND MANAGEMENT2 IN ('1', '2', '3')  --��������(��������, ��������, ����)
        ;

END SUM_SUPPLY_AMT;





--�����������Ҹ��Լ��׸��� ��� ��¿�
PROCEDURE PRINT_NO_DEDUCTION_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)       
    , W_DEAL_DATE_FR        IN  DATE    --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�ŷ��Ⱓ_����
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
        , B.BUSINESS_ITEM   --����
        , B.BUSINESS_TYPE   --����(����)
        , B.BUSINESS_ITEM || '(' || B.BUSINESS_TYPE || ')' AS BUSINESS    --����(����)        
        , '(   ' || TO_CHAR(W_DEAL_DATE_TO, 'YYYY') || '  ��   ' ||  
          CASE
            WHEN TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'MM')) <= 6 THEN '1  ��   )'
            ELSE '2  ��   )'
          END FISCAL_YEAR   --�ΰ���ġ���Ű���
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

END PRINT_NO_DEDUCTION_TITLE;






END FI_NO_DEDUCTION_SPEC_G;
/
