CREATE OR REPLACE PROCEDURE FI_SLIP_LINE_P

(   P_GB                           IN VARCHAR2                ,
    P_SLIP_LINE_ID                      IN  FI_SLIP_LINE.SLIP_LINE_ID%TYPE,
    P_SLIP_DATE                         IN  FI_SLIP_LINE.SLIP_DATE%TYPE,
    P_SLIP_NUM                          IN  FI_SLIP_LINE.SLIP_NUM%TYPE,
    P_SLIP_LINE_SEQ                     IN  FI_SLIP_LINE.SLIP_LINE_SEQ%TYPE,
    P_SLIP_HEADER_ID                    IN  FI_SLIP_LINE.SLIP_HEADER_ID%TYPE,
    P_SOB_ID                            IN  FI_SLIP_LINE.SOB_ID%TYPE,
    P_ORG_ID                            IN  FI_SLIP_LINE.ORG_ID%TYPE,
    P_DEPT_ID                           IN  FI_SLIP_LINE.DEPT_ID%TYPE,
    P_PERSON_ID                         IN  FI_SLIP_LINE.PERSON_ID%TYPE,
    P_BUDGET_DEPT_ID                    IN  FI_SLIP_LINE.BUDGET_DEPT_ID%TYPE,
    P_ACCOUNT_BOOK_ID                   IN  FI_SLIP_LINE.ACCOUNT_BOOK_ID%TYPE,
    P_SLIP_TYPE                         IN  FI_SLIP_LINE.SLIP_TYPE%TYPE,
    P_PERIOD_NAME                       IN  FI_SLIP_LINE.PERIOD_NAME%TYPE,
    P_CONFIRM_YN                        IN  FI_SLIP_LINE.CONFIRM_YN%TYPE,
    P_CONFIRM_DATE                      IN  FI_SLIP_LINE.CONFIRM_DATE%TYPE,
    P_CONFIRM_PERSON_ID                 IN  FI_SLIP_LINE.CONFIRM_PERSON_ID%TYPE,
    P_GL_DATE                           IN  FI_SLIP_LINE.GL_DATE%TYPE,
    P_GL_NUM                            IN  FI_SLIP_LINE.GL_NUM%TYPE,
    P_CUSTOMER_ID                       IN  FI_SLIP_LINE.CUSTOMER_ID%TYPE,
    P_ACCOUNT_CONTROL_ID                IN  FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE,
    P_ACCOUNT_CODE                      IN  FI_SLIP_LINE.ACCOUNT_CODE%TYPE,
    --P_COST_CENTER_ID                    IN  FI_SLIP_LINE.COST_CENTER_ID%TYPE,
    P_ACCOUNT_DR_CR                     IN  FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE,
    P_GL_AMOUNT                         IN  FI_SLIP_LINE.GL_AMOUNT%TYPE,
    P_CURRENCY_CODE                     IN  FI_SLIP_LINE.CURRENCY_CODE%TYPE,
    P_EXCHANGE_RATE                     IN  FI_SLIP_LINE.EXCHANGE_RATE%TYPE,
    P_GL_CURRENCY_AMOUNT                IN  FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE,
    P_BANK_ACCOUNT_ID                   IN  FI_SLIP_LINE.BANK_ACCOUNT_ID%TYPE,
    P_MANAGEMENT1                       IN  FI_SLIP_LINE.MANAGEMENT1%TYPE,
    P_MANAGEMENT2                       IN  FI_SLIP_LINE.MANAGEMENT2%TYPE,
    P_REFER1                            IN  FI_SLIP_LINE.REFER1%TYPE,
    P_REFER2                            IN  FI_SLIP_LINE.REFER2%TYPE,
    P_REFER3                            IN  FI_SLIP_LINE.REFER3%TYPE,
    P_REFER4                            IN  FI_SLIP_LINE.REFER4%TYPE,
    P_REFER5                            IN  FI_SLIP_LINE.REFER5%TYPE,
    P_REFER6                            IN  FI_SLIP_LINE.REFER6%TYPE,
    P_REFER7                            IN  FI_SLIP_LINE.REFER7%TYPE,
    P_REFER8                            IN  FI_SLIP_LINE.REFER8%TYPE,
    P_REFER9                            IN  FI_SLIP_LINE.REFER9%TYPE,
    P_REFER10                           IN  FI_SLIP_LINE.REFER10%TYPE,
    P_REFER11                           IN  FI_SLIP_LINE.REFER11%TYPE,
    P_REFER12                           IN  FI_SLIP_LINE.REFER12%TYPE,
    P_VOUCH_CODE                        IN  FI_SLIP_LINE.VOUCH_CODE%TYPE,
    P_REFER_RATE                        IN  FI_SLIP_LINE.REFER_RATE%TYPE,
    P_REFER_AMOUNT                      IN  FI_SLIP_LINE.REFER_AMOUNT%TYPE,
    P_REFER_DATE1                       IN  FI_SLIP_LINE.REFER_DATE1%TYPE,
    P_REFER_DATE2                       IN  FI_SLIP_LINE.REFER_DATE2%TYPE,
    P_REMARK                            IN  FI_SLIP_LINE.REMARK%TYPE,
    P_UNLIQUIDATE_SLIP_HEADER_ID        IN  FI_SLIP_LINE.UNLIQUIDATE_SLIP_HEADER_ID%TYPE,
    P_UNLIQUIDATE_SLIP_LINE_ID          IN  FI_SLIP_LINE.UNLIQUIDATE_SLIP_LINE_ID%TYPE,
    P_FUND_CODE                         IN  FI_SLIP_LINE.FUND_CODE%TYPE,
    P_LINE_TYPE                         IN  FI_SLIP_LINE.LINE_TYPE%TYPE,
    P_CLOSED_YN                         IN  FI_SLIP_LINE.CLOSED_YN%TYPE,
    P_CLOSED_DATE                       IN  FI_SLIP_LINE.CLOSED_DATE%TYPE,
    P_CLOSED_PERSON_ID                  IN  FI_SLIP_LINE.CLOSED_PERSON_ID%TYPE,
    P_SOURCE_TABLE                      IN  FI_SLIP_LINE.SOURCE_TABLE%TYPE,
    P_SOURCE_HEADER_ID                  IN  FI_SLIP_LINE.SOURCE_HEADER_ID%TYPE,
    P_SOURCE_LINE_ID                    IN  FI_SLIP_LINE.SOURCE_LINE_ID%TYPE,
    P_CREATION_DATE                     IN  FI_SLIP_LINE.CREATION_DATE%TYPE,
    P_CREATED_BY                        IN  FI_SLIP_LINE.CREATED_BY%TYPE,
    P_LAST_UPDATE_DATE                  IN  FI_SLIP_LINE.LAST_UPDATE_DATE%TYPE,
    P_LAST_UPDATED_BY                   IN  FI_SLIP_LINE.LAST_UPDATED_BY%TYPE,
    P_LOAN_NUM                          IN  FI_LOAN_MASTER.LOAN_NUM%TYPE

) AS

    V_DRCR              FI_ACCOUNT_CONTROL.ACCOUNT_DR_CR%TYPE;          -- parameter�� �Ѱܹ��� ������ ���뱸��
    V_MICH_FLAG         FI_ACCOUNT_CONTROL.ACCOUNT_MICH_YN%TYPE;        -- �����������������
    V_ACCREM_FLAG       FI_ACCOUNT_CONTROL.ACCOUNT_ENABLED_FLAG%TYPE;   -- �����ܾװ�������
    V_ACCOUNT_FLAG      FI_ACCOUNT_CONTROL.BANK_ACCOUNT_FLAG%TYPE;      -- ������°�������, �����ܾװ�������
    V_CURR_FLAG         FI_ACCOUNT_CONTROL.CURRENCY_ENABLED_FLAG%TYPE;  -- ��ȭ��������
    V_VNDR_FLAG         FI_ACCOUNT_CONTROL.CUSTOMER_ENABLED_FLAG%TYPE;  -- �ŷ���������������, �ŷ�ó�ܾװ�������
    V_VAT_FLAG          FI_ACCOUNT_CONTROL.VAT_ENABLED_FLAG%TYPE;       -- �ΰ�����������
    V_MANA_CODE         FI_ACCOUNT_CONTROL.ACCOUNT_GL_ID%TYPE;          -- ����������� �ڵ��ȣ
    V_ACCOUNT_CLASS     FI_COMMON.VALUE1%TYPE;       -- ����Ÿ�� �ڵ��ȣ ����,���޾�����..
    V_EXIST_YN          FI_SLIP_LINE.CONFIRM_YN%TYPE;                   -- �̿�Data Check Y/N

    -- ������ ������ ����.
    V_INTER_RATE        NUMBER;
    V_DUE_DATE          DATE;
    V_DEPOSIT_AMOUNT    NUMBER;
    V_MONTH_AMOUNT      NUMBER;
    
BEGIN
    --�ᱹ, �ϴ��� from���� �ִ� FI_ACCOUNT_CLASS_V�� ACCOUNT_CLASS_TYPE�� ���ϱ� ���� join�� ���ε�,
    --���� �̷��� �����ϰ� �� �ʿ䰡 ����. ��������ڵ带 ���ϵ� sub-query�� �����ϴ°� ���ؿ� �������̴�.
    BEGIN
        SELECT FAC.ACCOUNT_DR_CR,          FAC.ACCOUNT_MICH_YN,            -- ��/��                ��û��(Y/N)
               FAC.ACCOUNT_ENABLED_FLAG,   FAC.CURRENCY_ENABLED_FLAG,      -- �����ܾװ���(Y/N),   ��ȭ���°���(Y/N)
               FAC.CUSTOMER_ENABLED_FLAG,  FAC.VAT_ENABLED_FLAG,           -- �ŷ�ó����(Y/N),     �ΰ�������(Y/N)
               FAC.BANK_ACCOUNT_FLAG,      FAV.ACCOUNT_CLASS_TYPE,         -- ������°���(Y/N)    ����Class ID
              (SELECT CODE FROM FI_COMMON WHERE COMMON_ID = FAC.ACCOUNT_GL_ID AND SOB_ID = P_SOB_ID )  -- �����ڵ�, ��������ڵ�
         INTO  V_DRCR,                 V_MICH_FLAG,
               V_ACCREM_FLAG,          V_CURR_FLAG,
               V_VNDR_FLAG,            V_VAT_FLAG,
               V_ACCOUNT_FLAG,         V_ACCOUNT_CLASS,
               V_MANA_CODE
         FROM  FI_ACCOUNT_CONTROL  FAC,  FI_ACCOUNT_CLASS_V    FAV  --��������, �����з� view
        WHERE  FAC.ACCOUNT_CONTROL_ID   = P_ACCOUNT_CONTROL_ID
          AND  FAC.SOB_ID               = P_SOB_ID
          AND  FAC.ACCOUNT_CLASS_ID     = FAV.ACCOUNT_CLASS_ID(+)   --�����з����̵�
          AND  FAC.SOB_ID               = FAV.SOB_ID(+)
        ;
    
    --�Ʒ� EXCEPTION�� �� �� query���� nvló���ϸ� �ȴ�.
    EXCEPTION 
        WHEN OTHERS THEN
            V_DRCR := '3';  --�̷� ���� ������ ����� ȭ�鿡�� �����Ѵ�.
            V_MICH_FLAG := 'N';
            V_ACCREM_FLAG := 'N';
            V_CURR_FLAG := 'N';
            V_VNDR_FLAG := 'N';
            V_VAT_FLAG := 'N';
            V_ACCOUNT_FLAG := 'N';
            V_ACCOUNT_CLASS := 'N';
            V_MANA_CODE := '';
    END;
  
    /* FI_DAILY_SUM_P ��Ȱ :
       1. FI_DAILY_SUM(�Ѱ�������) data update or insert
       2. FI_DAILY_BANK_ACCOUNT_SUM(��������� ���º� ��������Ȳ) data update or insert
       3. FI_BANK_ACCOUNT(���ڰ��¹�ȣ������)���̺��� ���¹�ȣ�� ���� �ܾױݾ��� �����Ѵ�.     
    */
    --DBMS_OUTPUT.PUT_LINE ( 'START ' ||V_ACCREM_FLAG ||' ' ||P_GB );
    --RAISE_APPLICATION_ERROR(-20004, 'V_ACCREM_FLAG : �ϸ��� DATA ���� ����('||V_ACCREM_FLAG||' : '||SQLERRM||')');
    FI_DAILY_SUM_P(   SUBSTR(P_GB, 1, 1),              P_SOB_ID,
                    P_ORG_ID,                        P_GL_DATE,
                    P_PERIOD_NAME,                   P_ACCOUNT_CONTROL_ID,
                    P_ACCOUNT_CODE,                  P_ACCOUNT_DR_CR,
                    P_GL_AMOUNT,                     P_CURRENCY_CODE,
                    P_EXCHANGE_RATE,
                    P_GL_CURRENCY_AMOUNT,            P_BANK_ACCOUNT_ID,
                    P_ACCOUNT_BOOK_ID,
                    P_CREATION_DATE,                 P_CREATED_BY,
                    P_LAST_UPDATE_DATE,              P_LAST_UPDATED_BY  );


    --��������/������ ���� ������.
    --BH���� 'UNIT_PRICE'�� ����.
    BEGIN
        SELECT MAX(TO_DATE(DECODE(MC.LOOKUP_TYPE, 'DUE_DATE', SMI.MANAGEMENT_VALUE, NULL), 'YYYY-MM-DD')) AS DUE_DATE
             , MAX(TO_NUMBER(DECODE(MC.LOOKUP_TYPE, 'INTER_RATE', SMI.MANAGEMENT_VALUE, NULL))) AS INTER_RATE
             , MAX(TO_NUMBER(DECODE(MC.LOOKUP_TYPE, 'SUPPLY_AMOUNT', SMI.MANAGEMENT_VALUE, NULL))) AS DEPOSIT_AMOUNT
             , MAX(TO_NUMBER(DECODE(MC.LOOKUP_TYPE, 'UNIT_PRICE', SMI.MANAGEMENT_VALUE, NULL))) AS MONTH_AMOUNT
        INTO V_DUE_DATE, V_INTER_RATE, V_DEPOSIT_AMOUNT, V_MONTH_AMOUNT
        FROM FI_SLIP_MANAGEMENT_ITEM SMI, FI_MANAGEMENT_CODE_V MC
        WHERE SMI.MANAGEMENT_ID           = MC.MANAGEMENT_ID
          AND SMI.SLIP_LINE_ID            = P_SLIP_LINE_ID
          AND SMI.SOB_ID                  = P_SOB_ID
          AND MC.LOOKUP_TYPE              IN ('DUE_DATE', 'INTER_RATE', 'SUPPLY_AMOUNT', 'UNIT_PRICE')
        ;
    EXCEPTION
        --��ó�� EXCEPTIONó�� ��������, ������ nvló������.
        WHEN OTHERS THEN
            V_DUE_DATE := NULL;
            V_INTER_RATE := 0;
    END; 
  
  
    --�����ݸ����Ϳ� data insert or update
    --�׷���, �� ���� �³�?, ��ǥ�󼼿� ���� �߰��Ǿ��� �ؼ� ������ �����ݸ����Ϳ� data�� insert�ϴ°� �³�?
    FI_DEPOSIT_MASTER_G.DEPOSIT_SAVE( 
          SUBSTR(P_GB, 1, 1)
        , P_BANK_ACCOUNT_ID
        , P_ACCOUNT_CODE
        , P_SOB_ID
        , P_ORG_ID 
        , P_GL_DATE
        , NVL(V_DUE_DATE, P_GL_DATE)
        , P_CURRENCY_CODE
        , P_EXCHANGE_RATE
        , P_GL_CURRENCY_AMOUNT
        , P_GL_AMOUNT
        , 0
        , V_DEPOSIT_AMOUNT
        , 0
        , V_MONTH_AMOUNT
        , NVL(V_INTER_RATE, 0)
        , P_CREATED_BY
    );



    -- �ŷ�ó �ܾװ���
    IF  V_MICH_FLAG = 'Y' THEN  --��������������̸�
        
        --��ǥ�� ��ϵ� ��/�뺯 ���а��� ����������� ��/�뺯 ���а��� ���ٴ� ���� 
        --�ش� �ڷ�(�����곻��)�� �����ߴٴ� ���� �ǹ��Ѵ�.
        --������������� ��>��ȭ �ܻ�����, ��ȭ �̼���, ��ȭ������, �����ޱ�...
        IF V_DRCR = P_ACCOUNT_DR_CR THEN
            FI_UNLIQUIDATE_HEADER_P(  SUBSTR(P_GB, 1, 1),   V_MANA_CODE,
                                    P_SLIP_LINE_ID,  			P_SOB_ID,
                                    P_ORG_ID,  						P_PERIOD_NAME,
                                    P_GL_DATE,  					P_GL_NUM,
                                    P_ACCOUNT_BOOK_ID,  	P_SLIP_TYPE,
                                    P_ACCOUNT_CONTROL_ID, P_ACCOUNT_CODE,
                                    P_ACCOUNT_DR_CR,  		P_CUSTOMER_ID,
                                    P_GL_AMOUNT,  				P_CURRENCY_CODE,
                                    P_EXCHANGE_RATE,  		P_GL_CURRENCY_AMOUNT,
                                    P_MANAGEMENT1,  			P_MANAGEMENT2,
                                    P_REFER1,  		  	    P_REFER2,
                                    P_REFER3,  		  	    P_REFER4,
                                    P_REFER5,  		  	    P_REFER6,
                                    P_REFER7,  		  	    P_REFER8,
                                    P_REFER9,
                                    P_REFER_DATE1,  			P_REFER_DATE2,
                                    P_REMARK,  						P_CREATION_DATE,
                                    P_CREATED_BY,				  P_LAST_UPDATE_DATE,
                                    P_LAST_UPDATED_BY   );
        
        ELSE    --�����곻���� ����Ǿ��ٴ� ���̴�.
            FI_UNLIQUIDATE_LINE_P(  SUBSTR(P_GB, 1, 1),             V_MANA_CODE,
                                  P_SLIP_LINE_ID,                 P_SOB_ID,
                                  P_ORG_ID,                       P_PERIOD_NAME,
                                  P_GL_DATE,                      P_GL_NUM,
                                  P_UNLIQUIDATE_SLIP_LINE_ID,     P_ACCOUNT_BOOK_ID,
                                  P_SLIP_TYPE,                    P_ACCOUNT_CONTROL_ID,
                                  P_ACCOUNT_CODE,                 P_ACCOUNT_DR_CR,
                                  P_CUSTOMER_ID,                  P_GL_AMOUNT,
                                  P_CURRENCY_CODE,                P_EXCHANGE_RATE,
                                  P_GL_CURRENCY_AMOUNT,           P_MANAGEMENT1,
                                  P_MANAGEMENT2,
                                  P_REFER1,                       P_REFER2,
                                  P_REFER3,                       P_REFER4,
                                  P_REFER5,                       P_REFER6,
                                  P_REFER7,                       P_REFER8,
                                  P_REFER9,
                                  P_REFER_DATE1,
                                  P_REFER_DATE2,                  P_REMARK,
                                  P_CREATION_DATE,                P_CREATED_BY,
                                  P_LAST_UPDATE_DATE,             P_LAST_UPDATED_BY  );

        END IF;
    END IF; --IF  V_MICH_FLAG = 'Y' THEN


    --������ �����̴�.
    
    
    -- �ŷ�ó���ܾװ���
    -- DBMS_OUTPUT.PUT_LINE ( 'START ' ||V_VNDR_FLAG ||' ' ||P_GB );
    IF V_VNDR_FLAG   = 'Y' THEN
        -- ���� �հ�.
        FI_CUSTOMER_BALANCE_P(    SUBSTR(P_GB, 1, 1),             P_SOB_ID,
                                  P_ORG_ID,                       P_PERIOD_NAME,
                                  P_ACCOUNT_BOOK_ID,              P_ACCOUNT_CONTROL_ID,
                                  P_ACCOUNT_CODE,                 P_ACCOUNT_DR_CR,
                                  P_CUSTOMER_ID,                  P_GL_AMOUNT,
                                  P_CURRENCY_CODE,                P_GL_CURRENCY_AMOUNT,
                                  P_MANAGEMENT1,                  P_MANAGEMENT2,
                                  P_CREATION_DATE,                P_CREATED_BY,
                                  P_LAST_UPDATE_DATE,             P_LAST_UPDATED_BY  );

        -- �Ϻ� �հ�.
        FI_CUSTOMER_BALANCE_DAILY_P ( SUBSTR(P_GB, 1, 1)
                                    , P_SOB_ID
                                    , P_ORG_ID
                                    , P_GL_DATE
                                    , P_ACCOUNT_BOOK_ID
                                    , P_ACCOUNT_CONTROL_ID
                                    , P_ACCOUNT_CODE
                                    , P_ACCOUNT_DR_CR
                                    , P_CUSTOMER_ID
                                    , P_GL_AMOUNT
                                    , P_CURRENCY_CODE
                                    , P_GL_CURRENCY_AMOUNT
                                    , P_CREATION_DATE
                                    , P_CREATED_BY
                                    , P_LAST_UPDATE_DATE
                                    , P_LAST_UPDATED_BY
                                    );

    END IF; 



  -- �ΰ��� ����
  IF V_VAT_FLAG = 'Y' THEN

        FI_VAT_SUM_P (  SUBSTR(P_GB, 1, 1),        P_SLIP_LINE_ID,
                        P_SLIP_HEADER_ID,          P_SOB_ID,
                        P_ORG_ID,                  P_PERIOD_NAME,
                        P_GL_DATE,
                        P_GL_NUM,                  P_CUSTOMER_ID,
                        P_SLIP_TYPE,               P_ACCOUNT_CONTROL_ID,
                        P_ACCOUNT_CODE,            P_GL_AMOUNT,
                        P_MANAGEMENT1,             P_MANAGEMENT2,
                        P_REFER1,                  P_REFER2,
                        P_REFER3,                  P_REFER4,
                        P_REFER5,
                        P_VOUCH_CODE,              P_REFER_RATE,
                        P_REFER_AMOUNT,            P_REFER_DATE1  );

  END IF;



  -- ���޾����� ��� ACCOUNT_CLASS_TYPE = 'PAYABLE_NOTE'
  IF  V_ACCOUNT_CLASS = 'PAYABLE_NOTE' THEN

      FI_PAYABLE_BILL_P (   SUBSTR(P_GB, 1, 1),
                            P_SLIP_LINE_ID,          P_SOB_ID,
                            P_ORG_ID,                P_PERIOD_NAME,
                            P_GL_DATE,               P_GL_NUM,
                            P_ACCOUNT_BOOK_ID,       P_SLIP_TYPE,
                            P_ACCOUNT_CONTROL_ID,    P_ACCOUNT_CODE,
                            P_ACCOUNT_DR_CR,         P_CUSTOMER_ID,
                            P_GL_AMOUNT,             P_MANAGEMENT1,
                            P_MANAGEMENT2,           P_REFER1,
                            P_REFER2,                P_REFER3,
                            P_REFER_RATE,            P_REFER_AMOUNT,
                            P_REFER_DATE1,           P_REFER_DATE2,
                            P_REMARK,                P_CREATION_DATE,
                            P_CREATED_BY,            P_LAST_UPDATE_DATE,
                            P_LAST_UPDATED_BY );


  END IF;

/*  -- ���������� ��� ACCOUNT_CLASS_ID = 701
  -- �������� ���������
  -- �뺯�� ������ �������� ������� �Ǵ� ���ξ����� �����... �̶� FI_BILL_MASTER�� Update
  IF V_ACCOUNT_CLASS_ID = 701 THEN
      FI_RECEIVEABLE_BILL_P (   SUBSTR(P_GB, 1, 1),
                                P_SACODE,               P_DATE,
                                P_NO,                   P_SEQ,
                                P_SYSCODE,              P_ACTDATE,
                                P_ACTCODE,              P_ACCOUNT_DR_CR,
                                P_AMOUNT,
                                P_LEVEL1,               P_LEVEL2,
                                P_REFNO1,               P_REFNO2,
                                P_REFNO3,               P_REFNO4,
                                P_REFNO5,               P_VOUCH,
                                P_REFDATE1,             P_REFDATE2,
                                P_REFRATE,              P_REFAMT,
                                P_REMARK         );

  END IF;*/



  -- ���Ա� ��ȣ�� ������ ���.
  IF P_LOAN_NUM IS NOT NULL THEN
    FI_LOAN_MASTER_G.LOAN_MASTER_UPDATE_AMOUNT
                    ( P_GB => SUBSTR(P_GB, 1, 1)
                    , P_LOAN_NUM => P_LOAN_NUM
                    , P_SOB_ID => P_SOB_ID
                    , P_ORG_ID => P_ORG_ID
                    , P_GL_DATE => P_GL_DATE
                    , P_ACCOUNT_DR_CR => P_ACCOUNT_DR_CR
                    , P_GL_CURRENCY_AMOUNT => P_GL_CURRENCY_AMOUNT
                    , P_GL_AMOUNT => P_GL_AMOUNT
                    , P_USER_ID => P_CREATED_BY
                    );
  END IF;

END FI_SLIP_LINE_P;
/
