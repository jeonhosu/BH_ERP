CREATE OR REPLACE PACKAGE FI_VAT_RECYCLING_ETC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_VAT_RECYCLING_ETC_G
Description  : ��Ȱ�����ڿ� �� �߰��ڵ��� ���Լ��� �����Ű�  Package

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
PROCEDURE CREATE_RECYCLING_ETC_DTL(
      O_STATUS              OUT VARCHAR2
    , O_MESSAGE             OUT VARCHAR2 
    , P_USER_ID             IN  NUMBER 
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_VAT_MNG_SERIAL      IN  NUMBER 
);

--��Ȱ�����ڿ� ���Լ��װ��� ���� �Ű� ����  --
PROCEDURE CREATE_RECYCLING_ETC(
      O_STATUS              OUT VARCHAR2
    , O_MESSAGE             OUT VARCHAR2 
    , P_USER_ID             IN  NUMBER 
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_VAT_MNG_SERIAL      IN  NUMBER 
);


--�� ���� �ڷ�
PROCEDURE LIST_RECYCLING_ETC_DTL(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_VAT_MNG_SERIAL      IN  NUMBER    --�Ű�Ⱓ_����
);


-- INSERT --
PROCEDURE INSERT_RECYCLING_ETC_DTL
          ( P_RECYCLING_ETC_DETAIL_ID OUT FI_VAT_RECYCLING_ETC_DETAIL.RECYCLING_ETC_DETAIL_ID%TYPE
          , P_SOB_ID                  IN FI_VAT_RECYCLING_ETC_DETAIL.SOB_ID%TYPE
          , P_ORG_ID                  IN FI_VAT_RECYCLING_ETC_DETAIL.ORG_ID%TYPE
          , P_TAX_CODE                IN FI_VAT_RECYCLING_ETC_DETAIL.TAX_CODE%TYPE
          , P_VAT_MNG_SERIAL          IN FI_VAT_RECYCLING_ETC_DETAIL.VAT_MNG_SERIAL%TYPE
          , P_VAT_RECEIPT_TYPE        IN FI_VAT_RECYCLING_ETC_DETAIL.VAT_RECEIPT_TYPE%TYPE
          , P_SUPPLIER_ID             IN FI_VAT_RECYCLING_ETC_DETAIL.SUPPLIER_ID%TYPE
          , P_VAT_COUNT               IN FI_VAT_RECYCLING_ETC_DETAIL.VAT_COUNT%TYPE
          , P_ITEM_DESC               IN FI_VAT_RECYCLING_ETC_DETAIL.ITEM_DESC%TYPE
          , P_ITEM_QTY                IN FI_VAT_RECYCLING_ETC_DETAIL.ITEM_QTY%TYPE
          , P_CAR_NUM                 IN FI_VAT_RECYCLING_ETC_DETAIL.CAR_NUM%TYPE 
          , P_CAR_BODY_NUM            IN FI_VAT_RECYCLING_ETC_DETAIL.CAR_BODY_NUM%TYPE 
          , P_ITEM_AMOUNT             IN FI_VAT_RECYCLING_ETC_DETAIL.ITEM_AMOUNT%TYPE
          , P_DEEMED_VAT_AMOUNT       IN FI_VAT_RECYCLING_ETC_DETAIL.DEEMED_VAT_AMOUNT%TYPE 
          , P_USER_ID                 IN FI_VAT_RECYCLING_ETC_DETAIL.CREATED_BY%TYPE );

-- UPDATE --
PROCEDURE UPDATE_RECYCLING_ETC_DTL
          ( W_RECYCLING_ETC_DETAIL_ID IN FI_VAT_RECYCLING_ETC_DETAIL.RECYCLING_ETC_DETAIL_ID%TYPE
          , W_SOB_ID                  IN FI_VAT_RECYCLING_ETC_DETAIL.SOB_ID%TYPE
          , W_ORG_ID                  IN FI_VAT_RECYCLING_ETC_DETAIL.ORG_ID%TYPE
          , W_TAX_CODE                IN FI_VAT_RECYCLING_ETC_DETAIL.TAX_CODE%TYPE
          , W_VAT_MNG_SERIAL          IN FI_VAT_RECYCLING_ETC_DETAIL.VAT_MNG_SERIAL%TYPE
          , P_VAT_RECEIPT_TYPE        IN FI_VAT_RECYCLING_ETC_DETAIL.VAT_RECEIPT_TYPE%TYPE
          , P_SUPPLIER_ID             IN FI_VAT_RECYCLING_ETC_DETAIL.SUPPLIER_ID%TYPE
          , P_VAT_COUNT               IN FI_VAT_RECYCLING_ETC_DETAIL.VAT_COUNT%TYPE
          , P_ITEM_DESC               IN FI_VAT_RECYCLING_ETC_DETAIL.ITEM_DESC%TYPE
          , P_ITEM_QTY                IN FI_VAT_RECYCLING_ETC_DETAIL.ITEM_QTY%TYPE
          , P_CAR_NUM                 IN FI_VAT_RECYCLING_ETC_DETAIL.CAR_NUM%TYPE 
          , P_CAR_BODY_NUM            IN FI_VAT_RECYCLING_ETC_DETAIL.CAR_BODY_NUM%TYPE 
          , P_ITEM_AMOUNT             IN FI_VAT_RECYCLING_ETC_DETAIL.ITEM_AMOUNT%TYPE
          , P_DEEMED_VAT_AMOUNT       IN FI_VAT_RECYCLING_ETC_DETAIL.DEEMED_VAT_AMOUNT%TYPE 
          , P_USER_ID                 IN FI_VAT_RECYCLING_ETC_DETAIL.CREATED_BY%TYPE );


-- DELETE --
PROCEDURE DELETE_RECYCLING_ETC_DTL
          ( W_RECYCLING_ETC_DETAIL_ID IN FI_VAT_RECYCLING_ETC_DETAIL.RECYCLING_ETC_DETAIL_ID%TYPE
          , W_SOB_ID                  IN FI_VAT_RECYCLING_ETC_DETAIL.SOB_ID%TYPE
          , W_ORG_ID                  IN FI_VAT_RECYCLING_ETC_DETAIL.ORG_ID%TYPE
          , W_TAX_CODE                IN FI_VAT_RECYCLING_ETC_DETAIL.TAX_CODE%TYPE
          , W_VAT_MNG_SERIAL          IN FI_VAT_RECYCLING_ETC_DETAIL.VAT_MNG_SERIAL%TYPE
          , P_USER_ID                 IN FI_VAT_RECYCLING_ETC_DETAIL.CREATED_BY%TYPE );



--�հ� �κ� ��ȸ
PROCEDURE SUM_RECYCLING_ETC(
      P_CURSOR1             OUT TYPES.TCURSOR1
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_VAT_MNG_SERIAL      IN  NUMBER    --�Ű�Ⱓ_����
);


--��Ȱ�����ڿ� ���Լ��װ��� ���� �Ű��� -- 
PROCEDURE LIST_RECYCLING_ETC_REPORT(
      P_CURSOR1             OUT TYPES.TCURSOR1
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_VAT_MNG_SERIAL      IN  NUMBER    --�Ű�Ⱓ_����
);


-- SAVE : ��Ȱ�����ڿ� ���Լ��װ��� ���� �Ű��� -- 
PROCEDURE UPDATE_RECYCLING_ETC
          ( W_RECYCLING_ETC_ID          IN FI_VAT_RECYCLING_ETC.RECYCLING_ETC_ID%TYPE
          , P_SOB_ID                    IN FI_VAT_RECYCLING_ETC.SOB_ID%TYPE
          , P_ORG_ID                    IN FI_VAT_RECYCLING_ETC.ORG_ID%TYPE
          , P_TAX_CODE                  IN FI_VAT_RECYCLING_ETC.TAX_CODE%TYPE
          , P_VAT_MNG_SERIAL            IN FI_VAT_RECYCLING_ETC.VAT_MNG_SERIAL%TYPE
          , P_SALES_PRE_AMOUNT          IN FI_VAT_RECYCLING_ETC.SALES_PRE_AMOUNT%TYPE
          , P_SALES_FIX_AMOUNT          IN FI_VAT_RECYCLING_ETC.SALES_FIX_AMOUNT%TYPE
          , P_LIMIT_RATE_NUMERATOR      IN FI_VAT_RECYCLING_ETC.LIMIT_RATE_NUMERATOR%TYPE
          , P_LIMIT_RATE_DENOMINATOR    IN FI_VAT_RECYCLING_ETC.LIMIT_RATE_DENOMINATOR%TYPE
          , P_PURCHASES_TAX_BILL_AMOUNT IN FI_VAT_RECYCLING_ETC.PURCHASES_TAX_BILL_AMOUNT%TYPE
          , P_PURCHASES_BILL_AMOUNT     IN FI_VAT_RECYCLING_ETC.PURCHASES_BILL_AMOUNT%TYPE
          , P_DED_RATE_NUMERATOR        IN FI_VAT_RECYCLING_ETC.DED_RATE_NUMERATOR%TYPE
          , P_DED_RATE_DENOMINATOR      IN FI_VAT_RECYCLING_ETC.DED_RATE_DENOMINATOR%TYPE
          , P_DED_PRE_QUARTER_AMOUNT    IN FI_VAT_RECYCLING_ETC.DED_PRE_QUARTER_AMOUNT%TYPE
          , P_DED_PRE_MONTHLY_AMOUNT    IN FI_VAT_RECYCLING_ETC.DED_PRE_MONTHLY_AMOUNT%TYPE
          , P_USER_ID                   IN FI_VAT_RECYCLING_ETC.CREATED_BY%TYPE );
                                 
                       
-- �μ� �ڷ� : ������ ����� �� ���� �ڷ�
PROCEDURE PRINT_RECYCLING_ETC(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_VAT_MNG_SERIAL      IN  NUMBER    --�Ű�Ⱓ_����
);


--������ũ���� ���Լ��� �����Ű� ��� ��¿�
PROCEDURE PRINT_RECYCLING_ETC_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����
);






END FI_VAT_RECYCLING_ETC_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_RECYCLING_ETC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_VAT_RECYCLING_ETC_G
Description  : ��Ȱ�����ڿ� �� �߰��ڵ��� ���Լ��� �����Ű�  Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (��Ȱ�����ڿ� �� �߰��ڵ��� ���Լ��� �����Ű�)
Program History :
    -.�ڷ� ���� ���� : ���� �Է�
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-27   Leem Dong Ern(�ӵ���)
*****************************************************************************/



--�� ���� �ڷ� ���� --
PROCEDURE CREATE_RECYCLING_ETC_DTL(
      O_STATUS              OUT VARCHAR2
    , O_MESSAGE             OUT VARCHAR2 
    , P_USER_ID             IN  NUMBER 
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_VAT_MNG_SERIAL      IN  NUMBER 
    )
AS
  V_SYSDATE                 DATE := GET_LOCAL_DATE(W_SOB_ID);
  t_CLOSING_YN              VARCHAR2(4) := 'N';
  t_RECYCLING_ETC_DETAIL_ID NUMBER;
BEGIN
  O_STATUS := 'F';
  IF W_TAX_CODE IS NULL THEN
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10007');
    RETURN;
  END IF;

  IF W_VAT_MNG_SERIAL IS NULL THEN
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10396');
    RETURN;
  END IF;

--�Ű�Ⱓ �������� ��ȯ
  t_CLOSING_YN := FI_VAT_REPORT_MNG_G.VAT_CLOSED_FLAG
                                           ( W_SOB_ID              => W_SOB_ID  --ȸ����̵�
                                            , W_ORG_ID              => W_ORG_ID   --����ξ��̵�
                                            , W_TAX_CODE            => W_TAX_CODE            --�������̵�(��>110)
                                            , W_VAT_MNG_SERIAL      => W_VAT_MNG_SERIAL      --�ΰ����Ű�Ⱓ���й�ȣ
                                            );
  IF t_CLOSING_YN = 'Y' THEN
    O_MESSAGE := 'Vat Period Status : ' || EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10052');
    RETURN;
  END IF;
  -- 1. ��ǥ �ڷ� COPY : ���� ��� ����  --
  
  -- 2. ������ũ���� ���Լ��� �����Ű� �ڷ� COPY -- 
  -- 2.1 �����ڷ� ���� 
  BEGIN
    DELETE FROM FI_VAT_RECYCLING_ETC_DETAIL RED
    WHERE RED.SOB_ID                = W_SOB_ID
      AND RED.ORG_ID                = W_ORG_ID
      AND RED.TAX_CODE              = W_TAX_CODE
      AND RED.VAT_MNG_SERIAL        = W_VAT_MNG_SERIAL
      AND RED.COPPER_ETC_ID         IS NOT NULL
    ;
  EXCEPTION WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Update Error : ' || SQLERRM);
  END;
  
  -- 2.2 ������ ����   
  FOR C1 IN ( SELECT CE.COPPER_ETC_ID
                   , CE.VAT_RECEIPT_TYPE
                   , CE.SUPPLIER_ID
                   , FAS.SUPPLIER_CODE
                   , FAS.SUPPLIER_SHORT_NAME AS SUPPLIER_NAME 
                   , FAS.TAX_REG_NO 
                   , CE.VAT_COUNT
                   , CE.ITEM_DESC
                   , CE.ITEM_QTY 
                   , CE.ITEM_AMOUNT
                   , CE.DEEMED_VAT_AMOUNT  
                FROM FI_VAT_COPPER_ETC CE
                   , AP_SUPPLIER       FAS
               WHERE CE.SUPPLIER_ID       = FAS.SUPPLIER_ID
                 AND CE.TAX_CODE          = W_TAX_CODE
                 AND CE.SOB_ID            = W_SOB_ID
                 AND CE.ORG_ID            = W_ORG_ID
                 AND CE.VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL 
              ORDER BY CE.VAT_RECEIPT_TYPE, FAS.SUPPLIER_CODE  
            )
  LOOP
    SELECT FI_VAT_RECYCLING_ETC_DTL_S1.NEXTVAL 
      INTO t_RECYCLING_ETC_DETAIL_ID
      FROM DUAL;
      
    BEGIN
      INSERT INTO FI_VAT_RECYCLING_ETC_DETAIL
      ( RECYCLING_ETC_DETAIL_ID
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
      , LAST_UPDATED_BY
      , COPPER_ETC_ID )
      VALUES
      ( t_RECYCLING_ETC_DETAIL_ID
      , W_SOB_ID
      , W_ORG_ID
      , W_TAX_CODE
      , W_VAT_MNG_SERIAL
      , C1.VAT_RECEIPT_TYPE
      , C1.SUPPLIER_ID
      , C1.VAT_COUNT
      , C1.ITEM_DESC
      , C1.ITEM_QTY
      , C1.ITEM_AMOUNT
      , C1.DEEMED_VAT_AMOUNT 
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID 
      , C1.COPPER_ETC_ID);
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Insert Error : ' || SQLERRM;
      RETURN;
    END;
  END LOOP C1;
  
  -- 3. ��Ȱ�����ڿ� ���Լ��װ��� ���� �Ű� ���� 
  CREATE_RECYCLING_ETC(
      O_STATUS              => O_STATUS 
    , O_MESSAGE             => O_MESSAGE  
    , P_USER_ID             => P_USER_ID 
    , W_SOB_ID              => W_SOB_ID   --ȸ����̵�
    , W_ORG_ID              => W_ORG_ID   --����ξ��̵�
    , W_TAX_CODE            => W_TAX_CODE --�������̵�(��> 110)
    , W_VAT_MNG_SERIAL      => W_VAT_MNG_SERIAL 
    );  
  
  O_STATUS := 'S';
END CREATE_RECYCLING_ETC_DTL;

--��Ȱ�����ڿ� ���Լ��װ��� ���� �Ű� ����  --
PROCEDURE CREATE_RECYCLING_ETC(
      O_STATUS              OUT VARCHAR2
    , O_MESSAGE             OUT VARCHAR2 
    , P_USER_ID             IN  NUMBER 
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_VAT_MNG_SERIAL      IN  NUMBER 
)
AS
  V_SYSDATE                 DATE := GET_LOCAL_DATE(W_SOB_ID);
BEGIN
  O_STATUS := 'F';
  
  BEGIN
    UPDATE FI_VAT_RECYCLING_ETC RE
       SET RE.PURCHASES_TAX_BILL_AMOUNT   = 0 
         , RE.PURCHASES_BILL_AMOUNT       = 0 
         , RE.DED_PRE_QUARTER_AMOUNT      = 0 
         , RE.DED_PRE_MONTHLY_AMOUNT      = 0
      WHERE RE.TAX_CODE           = W_TAX_CODE
        AND RE.SOB_ID             = W_SOB_ID
        AND RE.ORG_ID             = W_ORG_ID
        AND RE.VAT_MNG_SERIAL     = W_VAT_MNG_SERIAL
      ;
  EXCEPTION 
    WHEN OTHERS THEN
      NULL;
  END;  
  
  MERGE INTO FI_VAT_RECYCLING_ETC RE
  USING ( SELECT RED.SOB_ID 
               , RED.ORG_ID 
               , RED.TAX_CODE 
               , RED.VAT_MNG_SERIAL 
               , SUM(DECODE(RED.VAT_RECEIPT_TYPE, '30', RED.ITEM_AMOUNT, 0)) AS SUM_TAX_BILL_AMOUNT
               , SUM(DECODE(RED.VAT_RECEIPT_TYPE, '30', 0, RED.ITEM_AMOUNT)) AS SUM_BILL_AMOUNT
            FROM FI_VAT_RECYCLING_ETC_DETAIL RED
               , AP_SUPPLIER                 FAS
           WHERE RED.SUPPLIER_ID        = FAS.SUPPLIER_ID
             AND RED.TAX_CODE           = W_TAX_CODE
             AND RED.SOB_ID             = W_SOB_ID
             AND RED.ORG_ID             = W_ORG_ID
             AND RED.VAT_MNG_SERIAL     = W_VAT_MNG_SERIAL
           GROUP BY RED.SOB_ID 
               , RED.ORG_ID 
               , RED.TAX_CODE 
               , RED.VAT_MNG_SERIAL 
        ) SX
  ON    (RE.SOB_ID          = SX.SOB_ID 
     AND RE.ORG_ID          = SX.ORG_ID 
     AND RE.TAX_CODE        = SX.TAX_CODE 
     AND RE.VAT_MNG_SERIAL  = SX.VAT_MNG_SERIAL 
        )
  WHEN MATCHED THEN
    UPDATE 
       SET  LIMIT_RATE                   = CASE
                                             WHEN NVL(LIMIT_RATE_DENOMINATOR, 0) = 0 THEN 0
                                             ELSE TRUNC(NVL(LIMIT_RATE_NUMERATOR, 0) / NVL(LIMIT_RATE_DENOMINATOR, 0))
                                           END  --LIMIT_RATE 
          , PURCHASES_TAX_BILL_AMOUNT    = NVL(SX.SUM_TAX_BILL_AMOUNT, 0)
          , PURCHASES_BILL_AMOUNT        = NVL(SX.SUM_BILL_AMOUNT, 0)
          , DED_RATE                     = CASE
                                             WHEN NVL(DED_RATE_DENOMINATOR, 0) = 0 THEN 0
                                             ELSE TRUNC(NVL(DED_RATE_NUMERATOR, 0) / NVL(DED_RATE_DENOMINATOR, 0))
                                           END  -- DED_RATE  
  WHEN NOT MATCHED THEN
    INSERT
    ( RECYCLING_ETC_ID 
    , SOB_ID 
    , ORG_ID 
    , TAX_CODE 
    , VAT_MNG_SERIAL 
    , SALES_PRE_AMOUNT 
    , SALES_FIX_AMOUNT 
    , LIMIT_RATE_NUMERATOR
    , LIMIT_RATE_DENOMINATOR 
    , LIMIT_RATE 
    , LIMIT_AMOUNT 
    , PURCHASES_TAX_BILL_AMOUNT 
    , PURCHASES_BILL_AMOUNT 
    , DED_RANGE_AMOUNT 
    , DED_TARGET_AMOUNT 
    , DED_RATE_NUMERATOR 
    , DED_RATE_DENOMINATOR 
    , DED_RATE
    , DED_VAT_AMOUNT 
    , DED_PRE_QUARTER_AMOUNT 
    , DED_PRE_MONTHLY_AMOUNT 
    , FIX_VAT_AMOUNT 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY 
    
    ) VALUES
    ( FI_VAT_RECYCLING_ETC_S1.NEXTVAL
    , SX.SOB_ID
    , SX.ORG_ID 
    , SX.TAX_CODE 
    , SX.VAT_MNG_SERIAL
    , 0  -- SALES_PRE_AMOUNT 
    , 0  --SALES_FIX_AMOUNT 
    , 80  -- LIMIT_RATE_NUMERATOR 
    , 100 -- LILMIT_RATE_DENOMINATOR 
    , TRUNC(80/100)  --LIMIT_RATE 
    , 0  --LIMIT_AMOUNT 
    , NVL(SX.SUM_TAX_BILL_AMOUNT, 0)  -- PURCHASES_TAX_BILL_AMOUNT 
    , NVL(SX.SUM_BILL_AMOUNT, 0)      -- PURCHASES_BILL_AMOUNT 
    , 0  --DED_RANGE_AMOUNT 
    , 0  --DED_TARGET_AMOUNT 
    , 5  --DED_RATE_NUMERATOR 
    , 105  --DED_RATE_DENOMINATOR 
    , TRUNC(5/105)  -- DED_RATE 
    , 0  --DED_VAT_AMOUNT 
    , 0  --DED_PRE_QUARTER_AMOUNT 
    , 0  --DED_PRE_MONTHLY_AMOUNT 
    , 0  --FIX_VAT_AMOUNT 
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID
    )
  ;
  
  -- (12)���� �ѵ� ��� -- 
  BEGIN
    UPDATE FI_VAT_RECYCLING_ETC RE
       SET RE.LIMIT_AMOUNT        = CASE
                                      WHEN NVL(RE.LIMIT_RATE_DENOMINATOR, 0) = 0 THEN 0
                                      ELSE TRUNC((NVL(RE.SALES_PRE_AMOUNT, 0) + NVL(RE.SALES_FIX_AMOUNT, 0)) * 
                                                 (NVL(RE.LIMIT_RATE_NUMERATOR, 0) / NVL(RE.LIMIT_RATE_DENOMINATOR, 0)))
                                    END
     WHERE RE.TAX_CODE            = W_TAX_CODE
       AND RE.SOB_ID              = W_SOB_ID
       AND RE.ORG_ID              = W_ORG_ID
       AND RE.VAT_MNG_SERIAL      = W_VAT_MNG_SERIAL
     ;
  EXCEPTION 
    WHEN OTHERS THEN
      O_MESSAGE := '(12) Limit Amount Error : ' || SQLERRM;
      RETURN;
  END;
  
  -- (16) �������ɱݾ� ��� (12-14) -- 
  BEGIN
    UPDATE FI_VAT_RECYCLING_ETC RE
       SET RE.DED_RANGE_AMOUNT    = CASE
                                      WHEN NVL(RE.LIMIT_AMOUNT, 0) - NVL(RE.PURCHASES_TAX_BILL_AMOUNT, 0) <= 0 THEN 0
                                      ELSE NVL(RE.LIMIT_AMOUNT, 0) - NVL(RE.PURCHASES_TAX_BILL_AMOUNT, 0)
                                    END
     WHERE RE.TAX_CODE            = W_TAX_CODE
       AND RE.SOB_ID              = W_SOB_ID
       AND RE.ORG_ID              = W_ORG_ID
       AND RE.VAT_MNG_SERIAL      = W_VAT_MNG_SERIAL
     ;
  EXCEPTION 
    WHEN OTHERS THEN
      O_MESSAGE := '(16) DED_RANGE_AMOUNT Error : ' || SQLERRM;
      RETURN;
  END;
  
  -- (17) �������ɱݾ� ��� (15��16�� �ݾ��� ���� �ݾ�) -- 
  BEGIN
    UPDATE FI_VAT_RECYCLING_ETC RE
       SET RE.DED_TARGET_AMOUNT   = CASE
                                      WHEN NVL(RE.PURCHASES_BILL_AMOUNT, 0) > NVL(RE.DED_RANGE_AMOUNT, 0) THEN NVL(RE.DED_RANGE_AMOUNT, 0)
                                      ELSE NVL(RE.PURCHASES_BILL_AMOUNT, 0) 
                                    END
     WHERE RE.TAX_CODE            = W_TAX_CODE
       AND RE.SOB_ID              = W_SOB_ID
       AND RE.ORG_ID              = W_ORG_ID
       AND RE.VAT_MNG_SERIAL      = W_VAT_MNG_SERIAL
     ;
  EXCEPTION 
    WHEN OTHERS THEN
      O_MESSAGE := '(17) DED_TARGET_AMOUNT Error : ' || SQLERRM;
      RETURN;
  END;
  
  -- (19) ������� ���� ��� (17 * ������(18)) -- 
  BEGIN
    UPDATE FI_VAT_RECYCLING_ETC RE
       SET RE.DED_VAT_AMOUNT      = CASE
                                      WHEN NVL(RE.DED_RATE_DENOMINATOR, 0) = 0 THEN 0 
                                      ELSE TRUNC( NVL(RE.DED_TARGET_AMOUNT, 0) * 
                                                 (NVL(RE.DED_RATE_NUMERATOR, 0) / NVL(RE.DED_RATE_DENOMINATOR, 0)))
                                    END
     WHERE RE.TAX_CODE            = W_TAX_CODE
       AND RE.SOB_ID              = W_SOB_ID
       AND RE.ORG_ID              = W_ORG_ID
       AND RE.VAT_MNG_SERIAL      = W_VAT_MNG_SERIAL
     ;
  EXCEPTION 
    WHEN OTHERS THEN
      O_MESSAGE := '(17) DED_TARGET_AMOUNT Error : ' || SQLERRM;
      RETURN;
  END;
  
  -- (23) ����(����)�� ����(19-20)-- 
  BEGIN
    UPDATE FI_VAT_RECYCLING_ETC RE
       SET RE.FIX_VAT_AMOUNT      = NVL(RE.DED_VAT_AMOUNT, 0) - (NVL(RE.DED_PRE_QUARTER_AMOUNT, 0) + NVL(RE.DED_PRE_MONTHLY_AMOUNT, 0))
     WHERE RE.TAX_CODE            = W_TAX_CODE
       AND RE.SOB_ID              = W_SOB_ID
       AND RE.ORG_ID              = W_ORG_ID
       AND RE.VAT_MNG_SERIAL      = W_VAT_MNG_SERIAL
     ;
  EXCEPTION 
    WHEN OTHERS THEN
      O_MESSAGE := '(17) DED_TARGET_AMOUNT Error : ' || SQLERRM;
      RETURN;
  END;
  
  O_STATUS := 'S';
END CREATE_RECYCLING_ETC;



--�� ���� �ڷ�
PROCEDURE LIST_RECYCLING_ETC_DTL(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_VAT_MNG_SERIAL      IN  NUMBER    --�Ű�Ⱓ_����
)

AS

BEGIN
   OPEN P_CURSOR FOR
      SELECT RED.RECYCLING_ETC_DETAIL_ID
           , RED.VAT_RECEIPT_TYPE
           , RT.VAT_RECEIPT_DESC
           , RED.SUPPLIER_ID
           , FAS.SUPPLIER_CODE
           , FAS.SUPPLIER_SHORT_NAME AS SUPPLIER_NAME
           , FAS.TAX_REG_NO
           , RED.VAT_COUNT
           , RED.ITEM_DESC
           , RED.ITEM_QTY
           , RED.ITEM_AMOUNT
           , RED.DEEMED_VAT_AMOUNT 
           , RED.CAR_NUM
           , RED.CAR_BODY_NUM 
           , RT.NUMERATOR     -- ���������� ����
           , RT.DENOMINATOR   -- ���������� �и�
        FROM FI_VAT_RECYCLING_ETC_DETAIL RED
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
       WHERE RED.SUPPLIER_ID       = FAS.SUPPLIER_ID
         AND RED.VAT_RECEIPT_TYPE  = RT.VAT_RECEIPT_TYPE
         AND RED.SOB_ID            = RT.SOB_ID
         AND RED.ORG_ID            = RT.ORG_ID
         AND RED.TAX_CODE          = W_TAX_CODE
         AND RED.SOB_ID            = W_SOB_ID
         AND RED.ORG_ID            = W_ORG_ID
         AND RED.VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL
      ORDER BY RED.VAT_RECEIPT_TYPE, FAS.SUPPLIER_CODE
      ;
END LIST_RECYCLING_ETC_DTL;


-- INSERT --
PROCEDURE INSERT_RECYCLING_ETC_DTL
          ( P_RECYCLING_ETC_DETAIL_ID OUT FI_VAT_RECYCLING_ETC_DETAIL.RECYCLING_ETC_DETAIL_ID%TYPE
          , P_SOB_ID                  IN FI_VAT_RECYCLING_ETC_DETAIL.SOB_ID%TYPE
          , P_ORG_ID                  IN FI_VAT_RECYCLING_ETC_DETAIL.ORG_ID%TYPE
          , P_TAX_CODE                IN FI_VAT_RECYCLING_ETC_DETAIL.TAX_CODE%TYPE
          , P_VAT_MNG_SERIAL          IN FI_VAT_RECYCLING_ETC_DETAIL.VAT_MNG_SERIAL%TYPE
          , P_VAT_RECEIPT_TYPE        IN FI_VAT_RECYCLING_ETC_DETAIL.VAT_RECEIPT_TYPE%TYPE
          , P_SUPPLIER_ID             IN FI_VAT_RECYCLING_ETC_DETAIL.SUPPLIER_ID%TYPE
          , P_VAT_COUNT               IN FI_VAT_RECYCLING_ETC_DETAIL.VAT_COUNT%TYPE
          , P_ITEM_DESC               IN FI_VAT_RECYCLING_ETC_DETAIL.ITEM_DESC%TYPE
          , P_ITEM_QTY                IN FI_VAT_RECYCLING_ETC_DETAIL.ITEM_QTY%TYPE
          , P_CAR_NUM                 IN FI_VAT_RECYCLING_ETC_DETAIL.CAR_NUM%TYPE 
          , P_CAR_BODY_NUM            IN FI_VAT_RECYCLING_ETC_DETAIL.CAR_BODY_NUM%TYPE 
          , P_ITEM_AMOUNT             IN FI_VAT_RECYCLING_ETC_DETAIL.ITEM_AMOUNT%TYPE
          , P_DEEMED_VAT_AMOUNT       IN FI_VAT_RECYCLING_ETC_DETAIL.DEEMED_VAT_AMOUNT%TYPE 
          , P_USER_ID                 IN FI_VAT_RECYCLING_ETC_DETAIL.CREATED_BY%TYPE )
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
  
  SELECT FI_VAT_RECYCLING_ETC_DTL_S1.NEXTVAL
    INTO P_RECYCLING_ETC_DETAIL_ID
    FROM DUAL;

  BEGIN
    INSERT INTO FI_VAT_RECYCLING_ETC_DETAIL
    ( RECYCLING_ETC_DETAIL_ID
    , SOB_ID
    , ORG_ID
    , TAX_CODE
    , VAT_MNG_SERIAL
    , VAT_RECEIPT_TYPE
    , SUPPLIER_ID
    , VAT_COUNT
    , ITEM_DESC
    , ITEM_QTY
    , CAR_NUM
    , CAR_BODY_NUM 
    , ITEM_AMOUNT
    , DEEMED_VAT_AMOUNT
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY )
    VALUES
    ( P_RECYCLING_ETC_DETAIL_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_TAX_CODE
    , P_VAT_MNG_SERIAL
    , P_VAT_RECEIPT_TYPE
    , P_SUPPLIER_ID
    , P_VAT_COUNT
    , P_ITEM_DESC
    , P_ITEM_QTY
    , P_CAR_NUM
    , P_CAR_BODY_NUM 
    , P_ITEM_AMOUNT
    , P_DEEMED_VAT_AMOUNT
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  EXCEPTION WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Insert Error : ' || SQLERRM);
  END;
END INSERT_RECYCLING_ETC_DTL;

-- UPDATE --
PROCEDURE UPDATE_RECYCLING_ETC_DTL
          ( W_RECYCLING_ETC_DETAIL_ID IN FI_VAT_RECYCLING_ETC_DETAIL.RECYCLING_ETC_DETAIL_ID%TYPE
          , W_SOB_ID                  IN FI_VAT_RECYCLING_ETC_DETAIL.SOB_ID%TYPE
          , W_ORG_ID                  IN FI_VAT_RECYCLING_ETC_DETAIL.ORG_ID%TYPE
          , W_TAX_CODE                IN FI_VAT_RECYCLING_ETC_DETAIL.TAX_CODE%TYPE
          , W_VAT_MNG_SERIAL          IN FI_VAT_RECYCLING_ETC_DETAIL.VAT_MNG_SERIAL%TYPE
          , P_VAT_RECEIPT_TYPE        IN FI_VAT_RECYCLING_ETC_DETAIL.VAT_RECEIPT_TYPE%TYPE
          , P_SUPPLIER_ID             IN FI_VAT_RECYCLING_ETC_DETAIL.SUPPLIER_ID%TYPE
          , P_VAT_COUNT               IN FI_VAT_RECYCLING_ETC_DETAIL.VAT_COUNT%TYPE
          , P_ITEM_DESC               IN FI_VAT_RECYCLING_ETC_DETAIL.ITEM_DESC%TYPE
          , P_ITEM_QTY                IN FI_VAT_RECYCLING_ETC_DETAIL.ITEM_QTY%TYPE
          , P_CAR_NUM                 IN FI_VAT_RECYCLING_ETC_DETAIL.CAR_NUM%TYPE 
          , P_CAR_BODY_NUM            IN FI_VAT_RECYCLING_ETC_DETAIL.CAR_BODY_NUM%TYPE 
          , P_ITEM_AMOUNT             IN FI_VAT_RECYCLING_ETC_DETAIL.ITEM_AMOUNT%TYPE
          , P_DEEMED_VAT_AMOUNT       IN FI_VAT_RECYCLING_ETC_DETAIL.DEEMED_VAT_AMOUNT%TYPE 
          , P_USER_ID                 IN FI_VAT_RECYCLING_ETC_DETAIL.CREATED_BY%TYPE )
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
    UPDATE FI_VAT_RECYCLING_ETC_DETAIL
      SET VAT_RECEIPT_TYPE 	    = P_VAT_RECEIPT_TYPE
        , SUPPLIER_ID           = P_SUPPLIER_ID
        , VAT_COUNT             = P_VAT_COUNT
        , ITEM_DESC             = P_ITEM_DESC
        , ITEM_QTY              = P_ITEM_QTY
        , CAR_NUM               = P_CAR_NUM
        , CAR_BODY_NUM          = P_CAR_BODY_NUM 
        , ITEM_AMOUNT           = P_ITEM_AMOUNT
        , DEEMED_VAT_AMOUNT     = P_DEEMED_VAT_AMOUNT
        , LAST_UPDATE_DATE      = V_SYSDATE
        , LAST_UPDATED_BY       = P_USER_ID
    WHERE RECYCLING_ETC_DETAIL_ID   = W_RECYCLING_ETC_DETAIL_ID;
  EXCEPTION WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Update Error : ' || SQLERRM);
  END;
END UPDATE_RECYCLING_ETC_DTL;

-- DELETE --
PROCEDURE DELETE_RECYCLING_ETC_DTL
          ( W_RECYCLING_ETC_DETAIL_ID IN FI_VAT_RECYCLING_ETC_DETAIL.RECYCLING_ETC_DETAIL_ID%TYPE
          , W_SOB_ID                  IN FI_VAT_RECYCLING_ETC_DETAIL.SOB_ID%TYPE
          , W_ORG_ID                  IN FI_VAT_RECYCLING_ETC_DETAIL.ORG_ID%TYPE
          , W_TAX_CODE                IN FI_VAT_RECYCLING_ETC_DETAIL.TAX_CODE%TYPE
          , W_VAT_MNG_SERIAL          IN FI_VAT_RECYCLING_ETC_DETAIL.VAT_MNG_SERIAL%TYPE
          , P_USER_ID                 IN FI_VAT_RECYCLING_ETC_DETAIL.CREATED_BY%TYPE )
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
    DELETE FROM FI_VAT_RECYCLING_ETC_DETAIL
    WHERE RECYCLING_ETC_DETAIL_ID   = W_RECYCLING_ETC_DETAIL_ID;
  EXCEPTION WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Update Error : ' || SQLERRM);
  END;
END DELETE_RECYCLING_ETC_DTL;



--�հ� �κ� ��ȸ
PROCEDURE SUM_RECYCLING_ETC(
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
                WHEN GROUPING(RED.VAT_RECEIPT_TYPE) = 1 THEN '00'
                ELSE RED.VAT_RECEIPT_TYPE
             END AS VAT_RECEIPT_TYPE
           , CASE
                WHEN GROUPING(RED.VAT_RECEIPT_TYPE) = 1 THEN '�� ��'
                ELSE FI_COMMON_G.CODE_NAME_F('VAT_RECEIPT_TYPE', RED.VAT_RECEIPT_TYPE, RED.SOB_ID, RED.ORG_ID)
             END AS VAT_RECEIPT_DESC
           , COUNT(RED.SUPPLIER_ID) AS SUPPLIER_COUNT
           , SUM(RED.VAT_COUNT) AS VAT_COUNT
           , SUM(RED.ITEM_QTY) AS ITEM_QTY
           , SUM(RED.ITEM_AMOUNT) AS ITEM_AMOUNT
           , SUM(RED.DEEMED_VAT_AMOUNT) AS DEEMED_VAT_AMOUNT
        FROM FI_VAT_RECYCLING_ETC_DETAIL RED
           , AP_SUPPLIER                 FAS
       WHERE RED.SUPPLIER_ID        = FAS.SUPPLIER_ID
         AND RED.TAX_CODE           = W_TAX_CODE
         AND RED.SOB_ID             = W_SOB_ID
         AND RED.ORG_ID             = W_ORG_ID
         AND RED.VAT_MNG_SERIAL     = W_VAT_MNG_SERIAL
         AND RED.VAT_RECEIPT_TYPE   IN('10', '20')  -- ������, ��꼭 ����и� ���� 
       GROUP BY ROLLUP((RED.VAT_RECEIPT_TYPE
                      , FI_COMMON_G.CODE_NAME_F('VAT_RECEIPT_TYPE', RED.VAT_RECEIPT_TYPE, RED.SOB_ID, RED.ORG_ID)))
       ORDER BY VAT_RECEIPT_TYPE
      ;
END SUM_RECYCLING_ETC;


--�հ� �κ� ��ȸ
PROCEDURE LIST_RECYCLING_ETC_REPORT(
      P_CURSOR1             OUT TYPES.TCURSOR1
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    , W_VAT_MNG_SERIAL      IN  NUMBER    --�Ű�Ⱓ_����
)
AS
BEGIN
  OPEN P_CURSOR1 FOR
    SELECT RE.RECYCLING_ETC_ID 
         , NVL(RE.SALES_PRE_AMOUNT, 0) + NVL(RE.SALES_FIX_AMOUNT, 0) AS SALES_SUM_AMOUNT  -- ����� �հ� 
         , RE.SALES_PRE_AMOUNT 
         , RE.SALES_FIX_AMOUNT 
         , RE.LIMIT_RATE_NUMERATOR
         , RE.LIMIT_RATE_DENOMINATOR  
         , RE.LIMIT_AMOUNT 
         , NVL(RE.PURCHASES_TAX_BILL_AMOUNT, 0) + NVL(RE.PURCHASES_BILL_AMOUNT, 0) AS PURCHASES_SUM_AMOUNT  -- �����Ծ� �հ� 
         , RE.PURCHASES_TAX_BILL_AMOUNT 
         , RE.PURCHASES_BILL_AMOUNT 
         , RE.DED_RANGE_AMOUNT 
         , RE.DED_TARGET_AMOUNT 
         , RE.DED_RATE_NUMERATOR 
         , RE.DED_RATE_DENOMINATOR 
         , RE.DED_VAT_AMOUNT   -- ������󼼾� 
         , NVL(RE.DED_PRE_QUARTER_AMOUNT, 0) + NVL(RE.DED_PRE_MONTHLY_AMOUNT, 0) AS DED_PRE_VAT_AMOUNT  -- �̹� �������� ���� �հ� 
         , RE.DED_PRE_QUARTER_AMOUNT 
         , RE.DED_PRE_MONTHLY_AMOUNT 
         , RE.FIX_VAT_AMOUNT  -- ����(����)�� ���� 
      FROM FI_VAT_RECYCLING_ETC RE
     WHERE RE.SOB_ID              = W_SOB_ID
       AND RE.ORG_ID              = W_ORG_ID
       AND RE.TAX_CODE            = W_TAX_CODE
       AND RE.VAT_MNG_SERIAL      = W_VAT_MNG_SERIAL
   ;
END LIST_RECYCLING_ETC_REPORT;


-- SAVE : ��Ȱ�����ڿ� ���Լ��װ��� ���� �Ű��� -- 
PROCEDURE UPDATE_RECYCLING_ETC
          ( W_RECYCLING_ETC_ID          IN FI_VAT_RECYCLING_ETC.RECYCLING_ETC_ID%TYPE
          , P_SOB_ID                    IN FI_VAT_RECYCLING_ETC.SOB_ID%TYPE
          , P_ORG_ID                    IN FI_VAT_RECYCLING_ETC.ORG_ID%TYPE
          , P_TAX_CODE                  IN FI_VAT_RECYCLING_ETC.TAX_CODE%TYPE
          , P_VAT_MNG_SERIAL            IN FI_VAT_RECYCLING_ETC.VAT_MNG_SERIAL%TYPE
          , P_SALES_PRE_AMOUNT          IN FI_VAT_RECYCLING_ETC.SALES_PRE_AMOUNT%TYPE
          , P_SALES_FIX_AMOUNT          IN FI_VAT_RECYCLING_ETC.SALES_FIX_AMOUNT%TYPE
          , P_LIMIT_RATE_NUMERATOR      IN FI_VAT_RECYCLING_ETC.LIMIT_RATE_NUMERATOR%TYPE
          , P_LIMIT_RATE_DENOMINATOR    IN FI_VAT_RECYCLING_ETC.LIMIT_RATE_DENOMINATOR%TYPE
          , P_PURCHASES_TAX_BILL_AMOUNT IN FI_VAT_RECYCLING_ETC.PURCHASES_TAX_BILL_AMOUNT%TYPE
          , P_PURCHASES_BILL_AMOUNT     IN FI_VAT_RECYCLING_ETC.PURCHASES_BILL_AMOUNT%TYPE
          , P_DED_RATE_NUMERATOR        IN FI_VAT_RECYCLING_ETC.DED_RATE_NUMERATOR%TYPE
          , P_DED_RATE_DENOMINATOR      IN FI_VAT_RECYCLING_ETC.DED_RATE_DENOMINATOR%TYPE
          , P_DED_PRE_QUARTER_AMOUNT    IN FI_VAT_RECYCLING_ETC.DED_PRE_QUARTER_AMOUNT%TYPE
          , P_DED_PRE_MONTHLY_AMOUNT    IN FI_VAT_RECYCLING_ETC.DED_PRE_MONTHLY_AMOUNT%TYPE
          , P_USER_ID                   IN FI_VAT_RECYCLING_ETC.CREATED_BY%TYPE )
AS
  V_SYSDATE             DATE := GET_LOCAL_DATE(P_SOB_ID);
  V_STATUS              VARCHAR2(2) := 'F';
  V_MESSAGE             VARCHAR2(500);
BEGIN
  IF NVL(P_LIMIT_RATE_DENOMINATOR, 0)  = 0 THEN
    RAISE_APPLICATION_ERROR(-20001, '���� �ѵ������ ���� �ѵ��� �и�� 0�� �Է��� �� �����ϴ�. Ȯ���ϼ���.');  
    RETURN;
  END IF;
  IF NVL(P_DED_RATE_DENOMINATOR, 0)  = 0 THEN
    RAISE_APPLICATION_ERROR(-20001, '������󼼾��� ������ ����� ���� �и�� 0�� �Է��� �� �����ϴ�. Ȯ���ϼ���.');  
    RETURN;
  END IF;
  
  BEGIN
    UPDATE FI_VAT_RECYCLING_ETC
      SET SALES_PRE_AMOUNT          = NVL(P_SALES_PRE_AMOUNT, 0) 
        , SALES_FIX_AMOUNT          = NVL(P_SALES_FIX_AMOUNT, 0) 
        , LIMIT_RATE_NUMERATOR      = NVL(P_LIMIT_RATE_NUMERATOR, 0) 
        , LIMIT_RATE_DENOMINATOR    = NVL(P_LIMIT_RATE_DENOMINATOR, 0) 
        , PURCHASES_TAX_BILL_AMOUNT = NVL(P_PURCHASES_TAX_BILL_AMOUNT, 0) 
        , PURCHASES_BILL_AMOUNT     = NVL(P_PURCHASES_BILL_AMOUNT, 0) 
        , DED_RATE_NUMERATOR        = NVL(P_DED_RATE_NUMERATOR, 0) 
        , DED_RATE_DENOMINATOR      = NVL(P_DED_RATE_DENOMINATOR, 0) 
        , DED_PRE_QUARTER_AMOUNT    = NVL(P_DED_PRE_QUARTER_AMOUNT, 0) 
        , DED_PRE_MONTHLY_AMOUNT    = NVL(P_DED_PRE_MONTHLY_AMOUNT, 0) 
        , LAST_UPDATE_DATE          = V_SYSDATE
        , LAST_UPDATED_BY           = P_USER_ID
    WHERE RECYCLING_ETC_ID          = W_RECYCLING_ETC_ID;
  EXCEPTION WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Recycling Etc Update Error : ' || SQLERRM);
    RETURN;
  END;
  
  -- 3. ��Ȱ�����ڿ� ���Լ��װ��� ���� �Ű� ���� 
  CREATE_RECYCLING_ETC(
      O_STATUS              => V_STATUS 
    , O_MESSAGE             => V_MESSAGE  
    , P_USER_ID             => P_USER_ID 
    , W_SOB_ID              => P_SOB_ID   --ȸ����̵�
    , W_ORG_ID              => P_ORG_ID   --����ξ��̵�
    , W_TAX_CODE            => P_TAX_CODE --�������̵�(��> 110)
    , W_VAT_MNG_SERIAL      => P_VAT_MNG_SERIAL 
    );  
  IF V_STATUS = 'F' THEN
    RAISE_APPLICATION_ERROR(-20001,V_MESSAGE);
    RETURN;
  END IF;
END UPDATE_RECYCLING_ETC;



-- �μ� �ڷ� : ������ ����� �� ���� �ڷ�
PROCEDURE PRINT_RECYCLING_ETC(
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
           , TO_CHAR(RED.VAT_COUNT, 'FM9999,999,999,999,999,999') AS VAT_COUNT
           , RED.ITEM_DESC
           , TO_CHAR(RED.ITEM_QTY, 'FM9999,999,999,999,999,999') AS ITEM_QTY
           , RED.CAR_NUM
           , RED.CAR_BODY_NUM 
           , TO_CHAR(RED.ITEM_AMOUNT, 'FM9999,999,999,999,999,999') AS ITEM_AMOUNT           
        FROM FI_VAT_RECYCLING_ETC_DETAIL RED
           , AP_SUPPLIER                 FAS
       WHERE RED.SUPPLIER_ID        = FAS.SUPPLIER_ID
         AND RED.TAX_CODE           = W_TAX_CODE
         AND RED.SOB_ID             = W_SOB_ID
         AND RED.ORG_ID             = W_ORG_ID
         AND RED.VAT_MNG_SERIAL     = W_VAT_MNG_SERIAL
         AND RED.VAT_RECEIPT_TYPE   = '10'
      ORDER BY RED.VAT_RECEIPT_TYPE, FAS.SUPPLIER_CODE
      ;
END PRINT_RECYCLING_ETC;


--������ũ���� ���Լ��� �����Ű� ��� ��¿�
PROCEDURE PRINT_RECYCLING_ETC_TITLE(
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

END PRINT_RECYCLING_ETC_TITLE;



END FI_VAT_RECYCLING_ETC_G;
/
