CREATE OR REPLACE PACKAGE FI_DPR_SPEC_G
AS

-- �������ڻ� ��泻��
  PROCEDURE SELECT_DPR_ASSET
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_SLIP_LINE_ID         IN FI_DPR_SPEC.SLIP_LINE_ID%TYPE
            , W_SOB_ID               IN FI_DPR_SPEC.SOB_ID%TYPE
            , W_ORG_ID               IN FI_DPR_SPEC.ORG_ID%TYPE
            );

-- �������ڻ� ��泻�� ����.
  PROCEDURE SAVE_DPR_SPEC
            ( P_SOB_ID          IN FI_DPR_SPEC.SOB_ID%TYPE
            , P_ORG_ID          IN FI_DPR_SPEC.ORG_ID%TYPE
            , P_SLIP_LINE_ID    IN FI_DPR_SPEC.SLIP_LINE_ID%TYPE
            , P_DPR_ASSET_GB_ID IN FI_DPR_SPEC.DPR_ASSET_GB_ID%TYPE
            , P_SPEC_CONTENTS   IN FI_DPR_SPEC.SPEC_CONTENTS%TYPE
            , P_SUP_AMOUNT      IN FI_DPR_SPEC.SUP_AMOUNT%TYPE
            , P_SURTAX          IN FI_DPR_SPEC.SURTAX%TYPE
            , P_ASSET_CNT       IN FI_DPR_SPEC.ASSET_CNT%TYPE
            , P_USER_ID         IN FI_DPR_SPEC.CREATED_BY%TYPE 
            );

-- �������ڻ� ��泻�� �ݾ� ����.
  PROCEDURE DPR_ASSET_AMOUNT_P
            ( W_SLIP_LINE_ID         IN FI_DPR_SPEC.SLIP_LINE_ID%TYPE
            , W_SOB_ID               IN FI_DPR_SPEC.SOB_ID%TYPE
            , W_ORG_ID               IN FI_DPR_SPEC.ORG_ID%TYPE
            , O_SUP_AMOUNT           OUT FI_DPR_SPEC.SUP_AMOUNT%TYPE
            , O_SURTAX               OUT FI_DPR_SPEC.SURTAX%TYPE
            );
            











--�ϱ���Ͱ� [�ǹ�������ڻ�������] ���α׷����� ����ϱ� ���� �ӵ����� �ۼ��� ���ν��� ���̴�.

--�������ڻ� ��泻�� �հ� : LIST_BUILDING_DPR_SPEC_MST
--�������ڻ� ��泻�� �� : LIST_BUILDING_DPR_SPEC_DET
--���� : UPDATE_BUILDING_DPR_SPEC
--�ǹ�������ڻ������� ��� ��¿� : PRINT_BUILDING_DPR_SPEC_TITLE




--�������ڻ� ��泻�� �հ�
PROCEDURE LIST_BUILDING_DPR_SPEC_MST( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_DPR_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID          IN  FI_DPR_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE        IN  VARCHAR2                 --�����(��>'110')
    , W_ISSUE_DATE_FR   IN  DATE                     --�Ű�Ⱓ_����
    , W_ISSUE_DATE_TO   IN  DATE                     --�Ű�Ⱓ_����
);






--�������ڻ� ��泻�� ��
PROCEDURE LIST_BUILDING_DPR_SPEC_DET( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_DPR_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID          IN  FI_DPR_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE        IN  VARCHAR2                 --�����(��>'110')
    , W_ISSUE_DATE_FR   IN  DATE                     --�Ű�Ⱓ_����
    , W_ISSUE_DATE_TO   IN  DATE                     --�Ű�Ⱓ_����
);





--�������ڻ� ��泻�� ���� �� ��ǥ�� �ڷ�(REFER10 : �����ڻ��ǥ, REFER11 : �����ڻ꼼��) ����
PROCEDURE UPDATE_BUILDING_DPR_SPEC( 
      P_SOB_ID          IN  FI_DPR_SPEC.SOB_ID%TYPE             --ȸ����̵�
    , P_ORG_ID          IN  FI_DPR_SPEC.ORG_ID%TYPE             --����ξ��̵�
    , P_SLIP_LINE_ID    IN  FI_DPR_SPEC.SLIP_LINE_ID%TYPE       --��ǥ���ξ��̵�
    , P_DPR_ASSET_GB_ID IN  FI_DPR_SPEC.DPR_ASSET_GB_ID%TYPE    --�ǹ������������_�ڻ걸��
    , P_SPEC_CONTENTS   IN  FI_DPR_SPEC.SPEC_CONTENTS%TYPE      --ǰ��׳���
    , P_SUP_AMOUNT      IN  FI_DPR_SPEC.SUP_AMOUNT%TYPE         --���ް���
    , P_SURTAX          IN  FI_DPR_SPEC.SURTAX%TYPE             --�ΰ���
    , P_ASSET_CNT       IN  FI_DPR_SPEC.ASSET_CNT%TYPE          --�ڻ�Ǽ�
    , P_LAST_UPDATED_BY IN  FI_DPR_SPEC.LAST_UPDATED_BY%TYPE    --������
);






--�ǹ�������ڻ������� ��� ��¿�
PROCEDURE PRINT_BUILDING_DPR_SPEC_TITLE(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  NUMBER                --ȸ����̵�
    , W_ORG_ID                  IN  NUMBER                --����ξ��̵�
    , W_TAX_CODE                IN  VARCHAR2              --�������̵�(��>42) ; �����ϴµ� ������ �±⿡ ������ �ȴ´�.  
    
    --�Ʒ� �׸��� ��½� �ʼ��׸��̴�.
    , W_DEAL_DATE_FR            IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO            IN  DATE    --�Ű�Ⱓ_����
    , W_CREATE_DATE             IN  DATE    --�ۼ�����
);




            
END FI_DPR_SPEC_G;
/
CREATE OR REPLACE PACKAGE BODY FI_DPR_SPEC_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_DPR_SPEC_G
/* Description  : �������ڻ� ��泻��.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- �������ڻ� ��泻��
  PROCEDURE SELECT_DPR_ASSET
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_SLIP_LINE_ID         IN FI_DPR_SPEC.SLIP_LINE_ID%TYPE
            , W_SOB_ID               IN FI_DPR_SPEC.SOB_ID%TYPE
            , W_ORG_ID               IN FI_DPR_SPEC.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT DAG.DPR_ASSET_GB_NAME
           , FDS.SPEC_CONTENTS
           , FDS.SUP_AMOUNT
           , FDS.SURTAX
           , FDS.ASSET_CNT
           , DAG.DPR_ASSET_GB_ID
           , NVL(FDS.SLIP_LINE_ID, W_SLIP_LINE_ID) AS SLIP_LINE_ID
        FROM FI_DPR_ASSET_GB_V DAG
          , ( SELECT DS.SOB_ID
                   , DS.SLIP_LINE_ID
                   , DS.DPR_ASSET_GB_ID
                   , DS.SPEC_CONTENTS
                   , DS.SUP_AMOUNT
                   , DS.SURTAX
                   , DS.ASSET_CNT
                FROM FI_DPR_SPEC DS
              WHERE DS.SOB_ID           = W_SOB_ID
                AND DS.SLIP_LINE_ID     = W_SLIP_LINE_ID
            ) FDS
      WHERE DAG.DPR_ASSET_GB_ID         = FDS.DPR_ASSET_GB_ID(+)
        AND DAG.SOB_ID                  = FDS.SOB_ID(+)
        AND DAG.SOB_ID                  = W_SOB_ID
      ORDER BY DAG.DPR_ASSET_GB
      ;
  END SELECT_DPR_ASSET;

-- �������ڻ� ��泻�� ����.
  PROCEDURE SAVE_DPR_SPEC
            ( P_SOB_ID          IN FI_DPR_SPEC.SOB_ID%TYPE
            , P_ORG_ID          IN FI_DPR_SPEC.ORG_ID%TYPE
            , P_SLIP_LINE_ID    IN FI_DPR_SPEC.SLIP_LINE_ID%TYPE
            , P_DPR_ASSET_GB_ID IN FI_DPR_SPEC.DPR_ASSET_GB_ID%TYPE
            , P_SPEC_CONTENTS   IN FI_DPR_SPEC.SPEC_CONTENTS%TYPE
            , P_SUP_AMOUNT      IN FI_DPR_SPEC.SUP_AMOUNT%TYPE
            , P_SURTAX          IN FI_DPR_SPEC.SURTAX%TYPE
            , P_ASSET_CNT       IN FI_DPR_SPEC.ASSET_CNT%TYPE
            , P_USER_ID         IN FI_DPR_SPEC.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
   IF P_SPEC_CONTENTS IS NULL AND NVL(P_SUP_AMOUNT, -1) = -1 AND NVL(P_SURTAX, -1) = -1 AND NVL(P_ASSET_CNT, -1) = -1 THEN
      DELETE FROM FI_DPR_SPEC DS
      WHERE DS.SLIP_LINE_ID     = P_SLIP_LINE_ID
        AND DS.DPR_ASSET_GB_ID  = P_DPR_ASSET_GB_ID
        AND DS.SOB_ID           = P_SOB_ID
      ;    
    ELSE      
      UPDATE FI_DPR_SPEC DS
        SET DS.SPEC_CONTENTS    = P_SPEC_CONTENTS
          , DS.SUP_AMOUNT       = NVL(P_SUP_AMOUNT, 0)
          , DS.SURTAX           = NVL(P_SURTAX, 0)
          , DS.ASSET_CNT        = NVL(P_ASSET_CNT, 0)
          , DS.LAST_UPDATE_DATE = V_SYSDATE
          , DS.LAST_UPDATED_BY  = P_USER_ID
      WHERE DS.SLIP_LINE_ID     = P_SLIP_LINE_ID
        AND DS.DPR_ASSET_GB_ID  = P_DPR_ASSET_GB_ID
        AND DS.SOB_ID           = P_SOB_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO FI_DPR_SPEC
        ( SOB_ID
        , ORG_ID 
        , SLIP_LINE_ID 
        , DPR_ASSET_GB_ID 
        , SPEC_CONTENTS 
        , SUP_AMOUNT 
        , SURTAX 
        , ASSET_CNT 
        , CREATION_DATE 
        , CREATED_BY 
        , LAST_UPDATE_DATE 
        , LAST_UPDATED_BY      
        ) VALUES
        ( P_SOB_ID
        , P_ORG_ID
        , P_SLIP_LINE_ID
        , P_DPR_ASSET_GB_ID
        , P_SPEC_CONTENTS
        , NVL(P_SUP_AMOUNT, 0)
        , NVL(P_SURTAX, 0)
        , NVL(P_ASSET_CNT, 0)
        , V_SYSDATE
        , P_USER_ID
        , V_SYSDATE
        , P_USER_ID
        );
      END IF;
    END IF;
  END SAVE_DPR_SPEC;

-- �������ڻ� ��泻�� �ݾ� ����.
  PROCEDURE DPR_ASSET_AMOUNT_P
            ( W_SLIP_LINE_ID         IN FI_DPR_SPEC.SLIP_LINE_ID%TYPE
            , W_SOB_ID               IN FI_DPR_SPEC.SOB_ID%TYPE
            , W_ORG_ID               IN FI_DPR_SPEC.ORG_ID%TYPE
            , O_SUP_AMOUNT           OUT FI_DPR_SPEC.SUP_AMOUNT%TYPE
            , O_SURTAX               OUT FI_DPR_SPEC.SURTAX%TYPE
            )
  AS
  BEGIN
    BEGIN
      SELECT NVL(SUM(DS.SUP_AMOUNT), 0) AS SUP_AMOUNT
           , NVL(SUM(DS.SURTAX), 0) AS SURTAX
        INTO O_SUP_AMOUNT
           , O_SURTAX
        FROM FI_DPR_SPEC DS
      WHERE DS.SOB_ID           = W_SOB_ID
        AND DS.SLIP_LINE_ID     = W_SLIP_LINE_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_SUP_AMOUNT := 0;
      O_SURTAX := 0;
    END;
  END DPR_ASSET_AMOUNT_P;




















--�ϱ���Ͱ� [�ǹ�������ڻ�������] ���α׷����� ����ϱ� ���� �ӵ����� �ۼ��� ���ν��� ���̴�.

--�������ڻ� ��泻�� �հ� : LIST_BUILDING_DPR_SPEC_MST
--�������ڻ� ��泻�� �� : LIST_BUILDING_DPR_SPEC_DET
--���� : UPDATE_BUILDING_DPR_SPEC
--�ǹ�������ڻ������� ��� ��¿� : PRINT_BUILDING_DPR_SPEC_TITLE



--�������ڻ� ��泻�� �հ�
PROCEDURE LIST_BUILDING_DPR_SPEC_MST( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_DPR_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID          IN  FI_DPR_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE        IN  VARCHAR2                 --�����(��>'110')
    , W_ISSUE_DATE_FR   IN  DATE                     --�Ű�Ⱓ_����
    , W_ISSUE_DATE_TO   IN  DATE                     --�Ű�Ⱓ_����
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          9 AS DPR_ASSET_GB_ID  --[9]�� UNION ALL �� ������ �����ϱ� ���� ������ ���ڸ� �� ������ ���ٸ� �ǹ� ����.
        , 5 AS SEQ   --������ �������ڻ����� ��ȣ
        , ' ��                      ��' AS DPR_ASSET_GB   --�������ڻ�����
        , TO_NUMBER(DECODE(SUM(ASSET_CNT), 0, NULL, SUM(ASSET_CNT))) AS ASSET_CNT       --�Ǽ�
        , TO_NUMBER(DECODE(SUM(SUP_AMOUNT), 0, NULL, SUM(SUP_AMOUNT))) AS SUP_AMOUNT    --���ް���
        , TO_NUMBER(DECODE(SUM(SURTAX), 0, NULL, SUM(SURTAX))) AS SURTAX                --�ΰ���         
        , '' AS REMARKS                 --���
    --FROM / WHERE ���� [�������ڻ� ��泻�� �� PROCEDURE] ���� ����� 100% ����.
    FROM FI_DPR_SPEC A
        , FI_SLIP_LINE B
        , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) C  --�ŷ�ó
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID     
        AND A.SLIP_LINE_ID = B.SLIP_LINE_ID
        AND B.MANAGEMENT2 = W_TAX_CODE --�����
        AND B.MANAGEMENT1 = C.SUPP_CUST_CODE(+)
        AND TO_DATE(B.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO --�Ű��������

    UNION ALL

    SELECT
          A.DPR_ASSET_GB_ID
        , DECODE(A.DPR_ASSET_GB_ID, '1669', 6, '1670', 7, '1671', 8, '1672', 9) AS SEQ   --������ �������ڻ����� ��ȣ
        , A.DPR_ASSET_GB    --�������ڻ�����
        , TO_NUMBER(DECODE(B.ASSET_CNT, 0, NULL, B.ASSET_CNT)) AS ASSET_CNT     --�Ǽ�
        , TO_NUMBER(DECODE(B.SUP_AMOUNT, 0, NULL, B.SUP_AMOUNT)) AS SUP_AMOUNT  --���ް���
        , TO_NUMBER(DECODE(B.SURTAX, 0, NULL, B.SURTAX)) AS SURTAX              --�ΰ���
        , '' AS REMARKS --���
    FROM
        (
            SELECT 
                  COMMON_ID AS DPR_ASSET_GB_ID  --�ǹ������������_�ڻ걸�о��̵�
                , VALUE1 AS DPR_ASSET_GB        --�������ڻ�����
            FROM FI_COMMON
            WHERE GROUP_CODE = 'DPR_ASSET_GB'
        ) A
        ,
        (
            SELECT 
                  DPR_ASSET_GB_ID               --�ǹ������������_�ڻ걸�о��̵�
                , SUM(ASSET_CNT) AS ASSET_CNT   --�Ǽ�
                , SUM(SUP_AMOUNT) AS SUP_AMOUNT --���ް���
                , SUM(SURTAX) AS SURTAX         --�ΰ���
            --FROM / WHERE ���� [�������ڻ� ��泻�� �� PROCEDURE] ���� ����� 100% ����.
            FROM FI_DPR_SPEC A
                , FI_SLIP_LINE B
                , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) C  --�ŷ�ó
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID     
                AND A.SLIP_LINE_ID = B.SLIP_LINE_ID
                AND B.MANAGEMENT2 = W_TAX_CODE --�����
                AND B.MANAGEMENT1 = C.SUPP_CUST_CODE(+)
                AND TO_DATE(B.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO --�Ű��������                               
            GROUP BY DPR_ASSET_GB_ID
        ) B
    WHERE A.DPR_ASSET_GB_ID = B.DPR_ASSET_GB_ID(+)
    ORDER BY DPR_ASSET_GB_ID    ;


END LIST_BUILDING_DPR_SPEC_MST;








--�������ڻ� ��泻�� ��
PROCEDURE LIST_BUILDING_DPR_SPEC_DET( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_DPR_SPEC.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID          IN  FI_DPR_SPEC.ORG_ID%TYPE  --����ξ��̵�
    , W_TAX_CODE        IN  VARCHAR2                 --�����(��>'110')
    , W_ISSUE_DATE_FR   IN  DATE                     --�Ű�Ⱓ_����
    , W_ISSUE_DATE_TO   IN  DATE                     --�Ű�Ⱓ_����
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          A.SOB_ID          --ȸ����̵�
        , A.ORG_ID          --����ξ��̵�
        , A.SLIP_LINE_ID    --��ǥ���ξ��̵�    
        , A.DPR_ASSET_GB_ID --�ǹ������������_�ڻ걸�о��̵�
        
        , FI_COMMON_G.ID_NAME_F(A.DPR_ASSET_GB_ID) AS DPR_ASSET_GB  --�ǹ������������_�ڻ걸��
        , B.REFER2 AS VAT_ISSUE_DATE        --���޹�������; �Ű��������
        , B.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
        , C.SUPP_CUST_NAME AS SUPPLIER_NAME --�ŷ�ó��
        , C.TAX_REG_NO AS TAX_REG_NO        --����ڹ�ȣ
        , A.SPEC_CONTENTS   --ǰ��׳���
        , A.SUP_AMOUNT      --���ް���
        , A.SURTAX          --�ΰ���
        , A.ASSET_CNT       --�Ǽ�
    --FROM / WHERE ���� [�������ڻ� ��泻�� �հ� PROCEDURE] ���� ����� 100% ����.    
    FROM FI_DPR_SPEC A
        , FI_SLIP_LINE B
        , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) C  --�ŷ�ó
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID     
        AND A.SLIP_LINE_ID = B.SLIP_LINE_ID
        AND B.MANAGEMENT2 = W_TAX_CODE --�����
        AND B.MANAGEMENT1 = C.SUPP_CUST_CODE(+)
        AND TO_DATE(B.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO --�Ű�������� 
    ORDER BY VAT_ISSUE_DATE, DPR_ASSET_GB_ID    ;
    
       
END LIST_BUILDING_DPR_SPEC_DET;







--�������ڻ� ��泻�� ���� �� ��ǥ�� �ڷ�(REFER10 : �����ڻ��ǥ, REFER11 : �����ڻ꼼��) ����
PROCEDURE UPDATE_BUILDING_DPR_SPEC( 
      P_SOB_ID          IN  FI_DPR_SPEC.SOB_ID%TYPE             --ȸ����̵�
    , P_ORG_ID          IN  FI_DPR_SPEC.ORG_ID%TYPE             --����ξ��̵�
    , P_SLIP_LINE_ID    IN  FI_DPR_SPEC.SLIP_LINE_ID%TYPE       --��ǥ���ξ��̵�
    , P_DPR_ASSET_GB_ID IN  FI_DPR_SPEC.DPR_ASSET_GB_ID%TYPE    --�ǹ������������_�ڻ걸��
    , P_SPEC_CONTENTS   IN  FI_DPR_SPEC.SPEC_CONTENTS%TYPE      --ǰ��׳���
    , P_SUP_AMOUNT      IN  FI_DPR_SPEC.SUP_AMOUNT%TYPE         --���ް���
    , P_SURTAX          IN  FI_DPR_SPEC.SURTAX%TYPE             --�ΰ���
    , P_ASSET_CNT       IN  FI_DPR_SPEC.ASSET_CNT%TYPE          --�ڻ�Ǽ�
    , P_LAST_UPDATED_BY IN  FI_DPR_SPEC.LAST_UPDATED_BY%TYPE    --������
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);

BEGIN
 
    --1.FI_DPR_SPEC
    UPDATE FI_DPR_SPEC
    SET 
          SPEC_CONTENTS = P_SPEC_CONTENTS   --ǰ��׳���
        , SUP_AMOUNT    = P_SUP_AMOUNT      --���ް���
        , SURTAX        = P_SURTAX          --�ΰ���
        , ASSET_CNT     = P_ASSET_CNT       --�ڻ�Ǽ�
        , LAST_UPDATE_DATE  = V_SYSDATE
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY         
    WHERE SOB_ID = P_SOB_ID
        AND ORG_ID = P_ORG_ID
        AND SLIP_LINE_ID = P_SLIP_LINE_ID
        AND DPR_ASSET_GB_ID = P_DPR_ASSET_GB_ID ;   



    --2.FI_SLIP_LINE

    --REFER10 : �����ڻ��ǥ, REFER11 : �����ڻ꼼��
    UPDATE FI_SLIP_LINE
    SET (REFER10, REFER11) = 
        (
            SELECT SUM(SUP_AMOUNT), SUM(SURTAX)
            FROM FI_DPR_SPEC
            WHERE SOB_ID = P_SOB_ID
                AND ORG_ID = P_ORG_ID
                AND SLIP_LINE_ID = P_SLIP_LINE_ID
        )
    WHERE SLIP_LINE_ID = P_SLIP_LINE_ID ;



END UPDATE_BUILDING_DPR_SPEC;






--�ǹ�������ڻ������� ��� ��¿�
PROCEDURE PRINT_BUILDING_DPR_SPEC_TITLE(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  NUMBER                --ȸ����̵�
    , W_ORG_ID                  IN  NUMBER                --����ξ��̵�
    , W_TAX_CODE                IN  VARCHAR2              --�������̵�(��>42) ; �����ϴµ� ������ �±⿡ ������ �ȴ´�.  
    
    --�Ʒ� �׸��� ��½� �ʼ��׸��̴�.
    , W_DEAL_DATE_FR            IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO            IN  DATE    --�Ű�Ⱓ_����
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
        --, B.ADDR1 || ' ' || B.ADDR2 || ' (  ' || A.TEL_NUMBER || '  ) ' AS LOCATION_TEL  --����������(��ȭ��ȣ)
        , B.BUSINESS_ITEM    --����
        , B.BUSINESS_TYPE    --����        
        --, B.BUSINESS_ITEM || '(' || B.BUSINESS_TYPE || ')' AS BUSINESS    --����(����) 
        , B.TAX_OFFICE_NAME --���Ҽ�����

        --, TO_CHAR(W_CREATE_DATE, 'YYYY.MM.DD') AS CREATE_DATE   --�ۼ�����
        , TO_CHAR(W_CREATE_DATE, 'YYYY') || ' ��   ' ||
          TO_CHAR(W_CREATE_DATE, 'MM') || ' ��   ' ||
          TO_CHAR(W_CREATE_DATE, 'DD') || ' ��'  AS CREATE_DATE  --�ۼ�����
          
        --, TO_CHAR(W_DEAL_DATE_FR, 'YYYY.MM.DD') || ' ~ ' || TO_CHAR(W_DEAL_DATE_TO, 'YYYY.MM.DD') AS DEAL_TERM    --�Ű�Ⱓ                      
        , TO_CHAR(W_DEAL_DATE_TO, 'YYYY')  || ' ��   ' ||  
          CASE
            WHEN TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'MM')) <= 6 THEN '1 ��   (  '
            ELSE '2 ��   (  '
          END
          || TO_CHAR(W_DEAL_DATE_FR, 'MM') || ' ��  ' || TO_CHAR(W_DEAL_DATE_FR, 'DD')  || ' ��  ~  '
          || TO_CHAR(W_DEAL_DATE_TO, 'MM') || ' ��  ' || TO_CHAR(W_DEAL_DATE_TO, 'DD') || ' ��  )'
          AS FISCAL_YEAR   --�ΰ���ġ���Ű���             
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
        
END PRINT_BUILDING_DPR_SPEC_TITLE;






  
END FI_DPR_SPEC_G;
/
