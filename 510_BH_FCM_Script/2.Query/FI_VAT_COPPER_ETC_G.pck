CREATE OR REPLACE PACKAGE FI_VAT_COPPER_ETC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_VAT_COPPER_ETC_G
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
PROCEDURE LIST_COPPER_ETC_DETAIL(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_VAT_MNG_SERIAL      IN  NUMBER    --�Ű�Ⱓ_����
);


-- INSERT -- 
PROCEDURE INSERT_COPPER_ETC
          ( P_COPPER_ETC_ID     OUT FI_VAT_COPPER_ETC.COPPER_ETC_ID%TYPE
          , P_SOB_ID            IN FI_VAT_COPPER_ETC.SOB_ID%TYPE
          , P_ORG_ID            IN FI_VAT_COPPER_ETC.ORG_ID%TYPE
          , P_TAX_CODE          IN FI_VAT_COPPER_ETC.TAX_CODE%TYPE
          , P_VAT_MNG_SERIAL    IN FI_VAT_COPPER_ETC.VAT_MNG_SERIAL%TYPE
          , P_VAT_RECEIPT_TYPE  IN FI_VAT_COPPER_ETC.VAT_RECEIPT_TYPE%TYPE
          , P_SUPPLIER_ID       IN FI_VAT_COPPER_ETC.SUPPLIER_ID%TYPE
          , P_VAT_COUNT         IN FI_VAT_COPPER_ETC.VAT_COUNT%TYPE
          , P_ITEM_DESC         IN FI_VAT_COPPER_ETC.ITEM_DESC%TYPE
          , P_ITEM_QTY          IN FI_VAT_COPPER_ETC.ITEM_QTY%TYPE
          , P_ITEM_AMOUNT       IN FI_VAT_COPPER_ETC.ITEM_AMOUNT%TYPE
          , P_DEEMED_VAT_AMOUNT IN FI_VAT_COPPER_ETC.DEEMED_VAT_AMOUNT%TYPE
          , P_USER_ID           IN FI_VAT_COPPER_ETC.CREATED_BY%TYPE );

-- UPDATE -- 
PROCEDURE UPDATE_COPPER_ETC 
          ( W_COPPER_ETC_ID     IN FI_VAT_COPPER_ETC.COPPER_ETC_ID%TYPE
          , W_SOB_ID            IN FI_VAT_COPPER_ETC.SOB_ID%TYPE
          , W_ORG_ID            IN FI_VAT_COPPER_ETC.ORG_ID%TYPE
          , W_TAX_CODE          IN FI_VAT_COPPER_ETC.TAX_CODE%TYPE
          , W_VAT_MNG_SERIAL    IN FI_VAT_COPPER_ETC.VAT_MNG_SERIAL%TYPE
          , P_VAT_RECEIPT_TYPE  IN FI_VAT_COPPER_ETC.VAT_RECEIPT_TYPE%TYPE
          , P_SUPPLIER_ID       IN FI_VAT_COPPER_ETC.SUPPLIER_ID%TYPE
          , P_VAT_COUNT         IN FI_VAT_COPPER_ETC.VAT_COUNT%TYPE
          , P_ITEM_DESC         IN FI_VAT_COPPER_ETC.ITEM_DESC%TYPE
          , P_ITEM_QTY          IN FI_VAT_COPPER_ETC.ITEM_QTY%TYPE
          , P_ITEM_AMOUNT       IN FI_VAT_COPPER_ETC.ITEM_AMOUNT%TYPE
          , P_DEEMED_VAT_AMOUNT IN FI_VAT_COPPER_ETC.DEEMED_VAT_AMOUNT%TYPE
          , P_USER_ID           IN FI_VAT_COPPER_ETC.CREATED_BY%TYPE );


-- DELETE -- 
PROCEDURE DELETE_COPPER_ETC 
          ( W_COPPER_ETC_ID     IN FI_VAT_COPPER_ETC.COPPER_ETC_ID%TYPE
          , W_SOB_ID            IN FI_VAT_COPPER_ETC.SOB_ID%TYPE
          , W_ORG_ID            IN FI_VAT_COPPER_ETC.ORG_ID%TYPE
          , W_TAX_CODE          IN FI_VAT_COPPER_ETC.TAX_CODE%TYPE
          , W_VAT_MNG_SERIAL    IN FI_VAT_COPPER_ETC.VAT_MNG_SERIAL%TYPE
          , P_USER_ID           IN FI_VAT_COPPER_ETC.CREATED_BY%TYPE );
          
          
          
--�հ� �κ� ��ȸ
PROCEDURE SUM_COPPER_ETC(
      P_CURSOR1             OUT TYPES.TCURSOR1
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_VAT_MNG_SERIAL      IN  NUMBER    --�Ű�Ⱓ_����
);



-- �μ� �ڷ� : ������ ����� �� ���� �ڷ�
PROCEDURE PRINT_COPPER_ETC(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_VAT_MNG_SERIAL      IN  NUMBER    --�Ű�Ⱓ_����
);


--������ũ���� ���Լ��� �����Ű� ��� ��¿�
PROCEDURE PRINT_COPPER_ETC_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����
);






END FI_VAT_COPPER_ETC_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_COPPER_ETC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_VAT_COPPER_ETC_G
Description  : ���� ��ũ���� ���Լ��� �����Ű� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (���� ��ũ���� ���Լ��� �����Ű�)
Program History :
    -.�ڷ� ���� ���� : ���� �Է� 
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
PROCEDURE LIST_COPPER_ETC_DETAIL(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_VAT_MNG_SERIAL      IN  NUMBER    --�Ű�Ⱓ_����
)

AS

BEGIN
   OPEN P_CURSOR FOR
      SELECT CE.COPPER_ETC_ID
           , CE.VAT_RECEIPT_TYPE
           , RT.VAT_RECEIPT_DESC 
           , CE.SUPPLIER_ID
           , FAS.SUPPLIER_CODE
           , FAS.SUPPLIER_SHORT_NAME AS SUPPLIER_NAME 
           , FAS.TAX_REG_NO 
           , CE.VAT_COUNT
           , CE.ITEM_DESC
           , CE.ITEM_QTY 
           , CE.ITEM_AMOUNT
           , CE.DEEMED_VAT_AMOUNT  
           , RT.NUMERATOR     -- ���������� ���� 
           , RT.DENOMINATOR   -- ���������� �и� 
        FROM FI_VAT_COPPER_ETC CE
           , AP_SUPPLIER       FAS
           , ( SELECT FC.SOB_ID 
                    , FC.ORG_ID 
                    , FC.CODE AS VAT_RECEIPT_TYPE 
                    , FC.CODE_NAME AS VAT_RECEIPT_DESC
                    , FC.VALUE1 AS NUMERATOR 
                    , FC.VALUE2 AS DENOMINATOR 
                 FROM FI_COMMON FC
                WHERE FC.GROUP_CODE  = 'VAT_RECEIPT_TYPE'
                  AND FC.SOB_ID      = W_SOB_ID
                  AND FC.ORG_ID      = W_ORG_ID
             ) RT
       WHERE CE.SUPPLIER_ID       = FAS.SUPPLIER_ID
         AND CE.VAT_RECEIPT_TYPE  = RT.VAT_RECEIPT_TYPE
         AND CE.SOB_ID            = RT.SOB_ID
         AND CE.ORG_ID            = RT.ORG_ID    
         AND CE.TAX_CODE          = W_TAX_CODE
         AND CE.SOB_ID            = W_SOB_ID
         AND CE.ORG_ID            = W_ORG_ID
         AND CE.VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL 
      ORDER BY CE.VAT_RECEIPT_TYPE, FAS.SUPPLIER_CODE  
      ;
END LIST_COPPER_ETC_DETAIL;


-- INSERT -- 
PROCEDURE INSERT_COPPER_ETC
          ( P_COPPER_ETC_ID     OUT FI_VAT_COPPER_ETC.COPPER_ETC_ID%TYPE
          , P_SOB_ID            IN FI_VAT_COPPER_ETC.SOB_ID%TYPE
          , P_ORG_ID            IN FI_VAT_COPPER_ETC.ORG_ID%TYPE
          , P_TAX_CODE          IN FI_VAT_COPPER_ETC.TAX_CODE%TYPE
          , P_VAT_MNG_SERIAL    IN FI_VAT_COPPER_ETC.VAT_MNG_SERIAL%TYPE
          , P_VAT_RECEIPT_TYPE  IN FI_VAT_COPPER_ETC.VAT_RECEIPT_TYPE%TYPE
          , P_SUPPLIER_ID       IN FI_VAT_COPPER_ETC.SUPPLIER_ID%TYPE
          , P_VAT_COUNT         IN FI_VAT_COPPER_ETC.VAT_COUNT%TYPE
          , P_ITEM_DESC         IN FI_VAT_COPPER_ETC.ITEM_DESC%TYPE
          , P_ITEM_QTY          IN FI_VAT_COPPER_ETC.ITEM_QTY%TYPE
          , P_ITEM_AMOUNT       IN FI_VAT_COPPER_ETC.ITEM_AMOUNT%TYPE
          , P_DEEMED_VAT_AMOUNT IN FI_VAT_COPPER_ETC.DEEMED_VAT_AMOUNT%TYPE
          , P_USER_ID           IN FI_VAT_COPPER_ETC.CREATED_BY%TYPE )
AS
    V_SYSDATE             DATE := GET_LOCAL_DATE(P_SOB_ID);
    t_CLOSING_YN          VARCHAR2(4) := 'N';
    
    t_SUPPLIER_ID         NUMBER;
BEGIN
  IF P_TAX_CODE IS NULL THEN
    RAISE_APPLICATION_ERROR(-2001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10007'));
    RETURN;
  END IF;
  
  IF P_VAT_MNG_SERIAL IS NULL THEN
    RAISE_APPLICATION_ERROR(-2001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10396'));
    RETURN;
  END IF;

--�Ű�Ⱓ �������� ��ȯ 
  t_CLOSING_YN := FI_VAT_REPORT_MNG_G.VAT_CLOSED_FLAG
                                       	  ( W_SOB_ID              => P_SOB_ID  --ȸ����̵�
                                          , W_ORG_ID              => P_ORG_ID   --����ξ��̵�
                                          , W_TAX_CODE            => P_TAX_CODE            --�������̵�(��>110)    
                                          , W_VAT_MNG_SERIAL      => P_VAT_MNG_SERIAL      --�ΰ����Ű�Ⱓ���й�ȣ     
                                          );
  IF t_CLOSING_YN = 'Y' THEN
    RAISE_APPLICATION_ERROR(-20001, 'Vat Period Status : ' || EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10052'));
    RETURN;
  END IF;
  
  BEGIN
    SELECT SC.SUPP_CUST_ID
      INTO t_SUPPLIER_ID
      FROM FI_SUPP_CUST_V SC
     WHERE SC.SUPP_CUST_ID      = P_SUPPLIER_ID
       AND SC.SUPP_CUST_TYPE    = 'S'  -- ����ó 
    ;
  EXCEPTION 
    WHEN OTHERS THEN
      t_SUPPLIER_ID := -1;
  END;
  IF t_SUPPLIER_ID < 0 THEN
    RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('EAPP_10071'));
    RETURN;
  END IF;
  
  
  SELECT FI_VAT_COPPER_ETC_S1.NEXTVAL
    INTO P_COPPER_ETC_ID
    FROM DUAL;
  
  BEGIN
    INSERT INTO FI_VAT_COPPER_ETC
    ( COPPER_ETC_ID
    , SOB_ID 
    , ORG_ID 
    , TAX_CODE 
    , VAT_MNG_SERIAL 
    , VAT_RECEIPT_TYPE 
    , SUPPLIER_ID 
    , VAT_COUNT 
    , ITEM_DESC 
    , ITEM_QTY 
    , ITEM_AMOUNT 
    , DEEMED_VAT_AMOUNT 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_COPPER_ETC_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_TAX_CODE
    , P_VAT_MNG_SERIAL
    , P_VAT_RECEIPT_TYPE
    , P_SUPPLIER_ID
    , P_VAT_COUNT
    , P_ITEM_DESC
    , P_ITEM_QTY
    , P_ITEM_AMOUNT
    , P_DEEMED_VAT_AMOUNT
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  EXCEPTION WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Insert Error : ' || SQLERRM);
  END;
END INSERT_COPPER_ETC;

-- UPDATE -- 
PROCEDURE UPDATE_COPPER_ETC 
          ( W_COPPER_ETC_ID     IN FI_VAT_COPPER_ETC.COPPER_ETC_ID%TYPE
          , W_SOB_ID            IN FI_VAT_COPPER_ETC.SOB_ID%TYPE
          , W_ORG_ID            IN FI_VAT_COPPER_ETC.ORG_ID%TYPE
          , W_TAX_CODE          IN FI_VAT_COPPER_ETC.TAX_CODE%TYPE
          , W_VAT_MNG_SERIAL    IN FI_VAT_COPPER_ETC.VAT_MNG_SERIAL%TYPE
          , P_VAT_RECEIPT_TYPE  IN FI_VAT_COPPER_ETC.VAT_RECEIPT_TYPE%TYPE
          , P_SUPPLIER_ID       IN FI_VAT_COPPER_ETC.SUPPLIER_ID%TYPE
          , P_VAT_COUNT         IN FI_VAT_COPPER_ETC.VAT_COUNT%TYPE
          , P_ITEM_DESC         IN FI_VAT_COPPER_ETC.ITEM_DESC%TYPE
          , P_ITEM_QTY          IN FI_VAT_COPPER_ETC.ITEM_QTY%TYPE
          , P_ITEM_AMOUNT       IN FI_VAT_COPPER_ETC.ITEM_AMOUNT%TYPE
          , P_DEEMED_VAT_AMOUNT IN FI_VAT_COPPER_ETC.DEEMED_VAT_AMOUNT%TYPE
          , P_USER_ID           IN FI_VAT_COPPER_ETC.CREATED_BY%TYPE )
AS
  V_SYSDATE             DATE := GET_LOCAL_DATE(W_SOB_ID);
  t_CLOSING_YN          VARCHAR2(4) := 'N';
  t_SUPPLIER_ID         NUMBER;
BEGIN
--�Ű�Ⱓ �������� ��ȯ 
  t_CLOSING_YN := FI_VAT_REPORT_MNG_G.VAT_CLOSED_FLAG
                                       	  ( W_SOB_ID              => W_SOB_ID  --ȸ����̵�
                                          , W_ORG_ID              => W_ORG_ID   --����ξ��̵�
                                          , W_TAX_CODE            => W_TAX_CODE            --�������̵�(��>110)    
                                          , W_VAT_MNG_SERIAL      => W_VAT_MNG_SERIAL      --�ΰ����Ű�Ⱓ���й�ȣ     
                                          );
  IF t_CLOSING_YN = 'Y' THEN
    RAISE_APPLICATION_ERROR(-20001, 'Vat Period Status : ' || EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10052'));
  END IF;
  
  BEGIN
    SELECT SC.SUPP_CUST_ID
      INTO t_SUPPLIER_ID
      FROM FI_SUPP_CUST_V SC
     WHERE SC.SUPP_CUST_ID      = P_SUPPLIER_ID
       AND SC.SUPP_CUST_TYPE    = 'S'  -- ����ó 
    ;
  EXCEPTION 
    WHEN OTHERS THEN
      t_SUPPLIER_ID := -1;
  END;
  IF t_SUPPLIER_ID < 0 THEN
    RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('EAPP_10071'));
    RETURN;
  END IF;
  
  BEGIN
    UPDATE FI_VAT_COPPER_ETC
      SET VAT_RECEIPT_TYPE  = P_VAT_RECEIPT_TYPE
        , SUPPLIER_ID       = P_SUPPLIER_ID
        , VAT_COUNT         = P_VAT_COUNT
        , ITEM_DESC         = P_ITEM_DESC
        , ITEM_QTY          = P_ITEM_QTY
        , ITEM_AMOUNT       = P_ITEM_AMOUNT
        , DEEMED_VAT_AMOUNT = P_DEEMED_VAT_AMOUNT
        , LAST_UPDATE_DATE  = V_SYSDATE
        , LAST_UPDATED_BY   = P_USER_ID
    WHERE COPPER_ETC_ID     = W_COPPER_ETC_ID;
  EXCEPTION WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Update Error : ' || SQLERRM);
  END;
END UPDATE_COPPER_ETC;

-- DELETE -- 
PROCEDURE DELETE_COPPER_ETC 
          ( W_COPPER_ETC_ID     IN FI_VAT_COPPER_ETC.COPPER_ETC_ID%TYPE
          , W_SOB_ID            IN FI_VAT_COPPER_ETC.SOB_ID%TYPE
          , W_ORG_ID            IN FI_VAT_COPPER_ETC.ORG_ID%TYPE
          , W_TAX_CODE          IN FI_VAT_COPPER_ETC.TAX_CODE%TYPE
          , W_VAT_MNG_SERIAL    IN FI_VAT_COPPER_ETC.VAT_MNG_SERIAL%TYPE
          , P_USER_ID           IN FI_VAT_COPPER_ETC.CREATED_BY%TYPE )
AS
  t_CLOSING_YN          VARCHAR2(4) := 'N';
BEGIN
  --�Ű�Ⱓ �������� ��ȯ 
  t_CLOSING_YN := FI_VAT_REPORT_MNG_G.VAT_CLOSED_FLAG
                                       	  ( W_SOB_ID              => W_SOB_ID  --ȸ����̵�
                                          , W_ORG_ID              => W_ORG_ID   --����ξ��̵�
                                          , W_TAX_CODE            => W_TAX_CODE            --�������̵�(��>110)    
                                          , W_VAT_MNG_SERIAL      => W_VAT_MNG_SERIAL      --�ΰ����Ű�Ⱓ���й�ȣ     
                                          );
  IF t_CLOSING_YN = 'Y' THEN
    RAISE_APPLICATION_ERROR(-20001, 'Vat Period Status : ' || EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10052'));
  END IF;
  
  BEGIN
    DELETE FROM FI_VAT_COPPER_ETC
    WHERE COPPER_ETC_ID     = W_COPPER_ETC_ID;
  EXCEPTION WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Update Error : ' || SQLERRM);
  END;
END DELETE_COPPER_ETC;



--�հ� �κ� ��ȸ
PROCEDURE SUM_COPPER_ETC(
      P_CURSOR1             OUT TYPES.TCURSOR1
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_VAT_MNG_SERIAL      IN  NUMBER    --�Ű�Ⱓ_����
)

AS

BEGIN
    OPEN P_CURSOR1 FOR
      SELECT 
             CASE
                WHEN GROUPING(CE.VAT_RECEIPT_TYPE) = 1 THEN '00'
                ELSE CE.VAT_RECEIPT_TYPE
             END AS VAT_RECEIPT_TYPE 
           , CASE
                WHEN GROUPING(CE.VAT_RECEIPT_TYPE) = 1 THEN '�� ��'
                ELSE FI_COMMON_G.CODE_NAME_F('VAT_RECEIPT_TYPE', CE.VAT_RECEIPT_TYPE, CE.SOB_ID, CE.ORG_ID) 
             END AS VAT_RECEIPT_DESC 
           , COUNT(CE.SUPPLIER_ID) AS SUPPLIER_COUNT
           , SUM(CE.VAT_COUNT) AS VAT_COUNT
           , SUM(CE.ITEM_QTY) AS ITEM_QTY  
           , SUM(CE.ITEM_AMOUNT) AS ITEM_AMOUNT
           , SUM(CE.DEEMED_VAT_AMOUNT) AS DEEMED_VAT_AMOUNT             
        FROM FI_VAT_COPPER_ETC CE
           , AP_SUPPLIER       FAS
       WHERE CE.SUPPLIER_ID       = FAS.SUPPLIER_ID  
         AND CE.TAX_CODE          = W_TAX_CODE
         AND CE.SOB_ID            = W_SOB_ID
         AND CE.ORG_ID            = W_ORG_ID
         AND CE.VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL 
       GROUP BY ROLLUP((CE.VAT_RECEIPT_TYPE
                      , FI_COMMON_G.CODE_NAME_F('VAT_RECEIPT_TYPE', CE.VAT_RECEIPT_TYPE, CE.SOB_ID, CE.ORG_ID)))
       ORDER BY VAT_RECEIPT_TYPE                
      ;
END SUM_COPPER_ETC;


-- �μ� �ڷ� : ������ ����� �� ���� �ڷ�
PROCEDURE PRINT_COPPER_ETC(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_VAT_MNG_SERIAL      IN  NUMBER    --�Ű�Ⱓ_����
)

AS

BEGIN
   OPEN P_CURSOR FOR
      SELECT TO_CHAR(ROWNUM, 'FM9999,999,999,999,999,999') AS SEQ  
           , FAS.SUPPLIER_SHORT_NAME AS SUPPLIER_NAME 
           , FAS.TAX_REG_NO 
           , TO_CHAR(CE.VAT_COUNT, 'FM9999,999,999,999,999,999') AS VAT_COUNT 
           , CE.ITEM_DESC
           , TO_CHAR(CE.ITEM_QTY, 'FM9999,999,999,999,999,999') AS ITEM_QTY 
           , TO_CHAR(CE.ITEM_AMOUNT, 'FM9999,999,999,999,999,999') AS ITEM_AMOUNT
           , TO_CHAR(CE.DEEMED_VAT_AMOUNT, 'FM9999,999,999,999,999,999') AS DEEMED_VAT_AMOUNT            
        FROM FI_VAT_COPPER_ETC CE
           , AP_SUPPLIER       FAS
       WHERE CE.SUPPLIER_ID       = FAS.SUPPLIER_ID  
         AND CE.TAX_CODE          = W_TAX_CODE
         AND CE.SOB_ID            = W_SOB_ID
         AND CE.ORG_ID            = W_ORG_ID
         AND CE.VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL 
         AND CE.VAT_RECEIPT_TYPE  = '10'
      ORDER BY CE.VAT_RECEIPT_TYPE, FAS.SUPPLIER_CODE  
      ;
END PRINT_COPPER_ETC;


--������ũ���� ���Լ��� �����Ű� ��� ��¿�
PROCEDURE PRINT_COPPER_ETC_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����
)

AS
  V_SYSDATE             DATE := GET_LOCAL_DATE(W_SOB_ID);
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
        , B.TAX_OFFICE_NAME || ' ��������' AS TAX_OFFICE_NAME --���Ҽ�����
        , TO_CHAR(V_SYSDATE, 'YYYY') || '�� ' 
          || TO_NUMBER(TO_CHAR(V_SYSDATE, 'MM')) || '�� ' 
          || TO_NUMBER(TO_CHAR(V_SYSDATE, 'DD')) || '��'  AS CREATE_DATE   --�ۼ����� 
        , A.CORP_NAME AS REPORTED_BY                          --�Ű��� 
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

END PRINT_COPPER_ETC_TITLE;


END FI_VAT_COPPER_ETC_G;
/
