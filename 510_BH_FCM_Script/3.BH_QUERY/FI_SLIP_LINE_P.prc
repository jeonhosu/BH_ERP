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

    V_DRCR              FI_ACCOUNT_CONTROL.ACCOUNT_DR_CR%TYPE;          -- parameter로 넘겨받은 계정의 차대구분
    V_MICH_FLAG         FI_ACCOUNT_CONTROL.ACCOUNT_MICH_YN%TYPE;        -- 미정산관리계정여부
    V_ACCREM_FLAG       FI_ACCOUNT_CONTROL.ACCOUNT_ENABLED_FLAG%TYPE;   -- 계정잔액관리여부
    V_ACCOUNT_FLAG      FI_ACCOUNT_CONTROL.BANK_ACCOUNT_FLAG%TYPE;      -- 은행계좌관리여부, 계좌잔액관리여부
    V_CURR_FLAG         FI_ACCOUNT_CONTROL.CURRENCY_ENABLED_FLAG%TYPE;  -- 외화계정여부
    V_VNDR_FLAG         FI_ACCOUNT_CONTROL.CUSTOMER_ENABLED_FLAG%TYPE;  -- 거래선관리계정여부, 거래처잔액관리여부
    V_VAT_FLAG          FI_ACCOUNT_CONTROL.VAT_ENABLED_FLAG%TYPE;       -- 부가세계정여부
    V_MANA_CODE         FI_ACCOUNT_CONTROL.ACCOUNT_GL_ID%TYPE;          -- 원장관리구분 코드번호
    V_ACCOUNT_CLASS     FI_COMMON.VALUE1%TYPE;       -- 계정타입 코드번호 어음,지급어음등..
    V_EXIST_YN          FI_SLIP_LINE.CONFIRM_YN%TYPE;                   -- 이월Data Check Y/N

    -- 예적금 마스터 적용.
    V_INTER_RATE        NUMBER;
    V_DUE_DATE          DATE;
    V_DEPOSIT_AMOUNT    NUMBER;
    V_MONTH_AMOUNT      NUMBER;
    
BEGIN
    --결국, 하단의 from절에 있는 FI_ACCOUNT_CLASS_V는 ACCOUNT_CLASS_TYPE를 구하기 위해 join된 것인데,
    --굳이 이렇게 복잡하게 할 필요가 없다. 원장관리코드를 구하듯 sub-query로 구현하는게 이해에 직관적이다.
    BEGIN
        SELECT FAC.ACCOUNT_DR_CR,          FAC.ACCOUNT_MICH_YN,            -- 차/대                미청산(Y/N)
               FAC.ACCOUNT_ENABLED_FLAG,   FAC.CURRENCY_ENABLED_FLAG,      -- 계정잔액관리(Y/N),   외화계좌관리(Y/N)
               FAC.CUSTOMER_ENABLED_FLAG,  FAC.VAT_ENABLED_FLAG,           -- 거래처관리(Y/N),     부가세계정(Y/N)
               FAC.BANK_ACCOUNT_FLAG,      FAV.ACCOUNT_CLASS_TYPE,         -- 은행계좌관리(Y/N)    계정Class ID
              (SELECT CODE FROM FI_COMMON WHERE COMMON_ID = FAC.ACCOUNT_GL_ID AND SOB_ID = P_SOB_ID )  -- 관리코드, 원장관리코드
         INTO  V_DRCR,                 V_MICH_FLAG,
               V_ACCREM_FLAG,          V_CURR_FLAG,
               V_VNDR_FLAG,            V_VAT_FLAG,
               V_ACCOUNT_FLAG,         V_ACCOUNT_CLASS,
               V_MANA_CODE
         FROM  FI_ACCOUNT_CONTROL  FAC,  FI_ACCOUNT_CLASS_V    FAV  --계정과목, 계정분류 view
        WHERE  FAC.ACCOUNT_CONTROL_ID   = P_ACCOUNT_CONTROL_ID
          AND  FAC.SOB_ID               = P_SOB_ID
          AND  FAC.ACCOUNT_CLASS_ID     = FAV.ACCOUNT_CLASS_ID(+)   --계정분류아이디
          AND  FAC.SOB_ID               = FAV.SOB_ID(+)
        ;
    
    --아래 EXCEPTION도 위 본 query에서 nvl처리하면 된다.
    EXCEPTION 
        WHEN OTHERS THEN
            V_DRCR := '3';  --이런 값이 나오지 않토록 화면에서 제어한다.
            V_MICH_FLAG := 'N';
            V_ACCREM_FLAG := 'N';
            V_CURR_FLAG := 'N';
            V_VNDR_FLAG := 'N';
            V_VAT_FLAG := 'N';
            V_ACCOUNT_FLAG := 'N';
            V_ACCOUNT_CLASS := 'N';
            V_MANA_CODE := '';
    END;
  
    /* FI_DAILY_SUM_P 역활 :
       1. FI_DAILY_SUM(총계정원장) data update or insert
       2. FI_DAILY_BANK_ACCOUNT_SUM(금융기관별 계좌별 예적금현황) data update or insert
       3. FI_BANK_ACCOUNT(은핸계좌번호마스터)테이블의 계좌번호에 대해 잔액금액을 변경한다.     
    */
    --DBMS_OUTPUT.PUT_LINE ( 'START ' ||V_ACCREM_FLAG ||' ' ||P_GB );
    --RAISE_APPLICATION_ERROR(-20004, 'V_ACCREM_FLAG : 일마감 DATA 삭제 오류('||V_ACCREM_FLAG||' : '||SQLERRM||')');
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


    --만기일자/이자율 등을 추출함.
    --BH에는 'UNIT_PRICE'가 없다.
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
        --이처럼 EXCEPTION처리 하지말고, 위에서 nvl처리하자.
        WHEN OTHERS THEN
            V_DUE_DATE := NULL;
            V_INTER_RATE := 0;
    END; 
  
  
    --예적금마스터에 data insert or update
    --그런데, 이 논리가 맞나?, 전표상세에 행이 추가되었다 해서 무조건 예적금마스터에 data를 insert하는게 맞나?
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



    -- 거래처 잔액관리
    IF  V_MICH_FLAG = 'Y' THEN  --미정산관리계정이면
        
        --전표에 등록된 차/대변 구분값과 계정과목상의 차/대변 구분값이 같다는 것은 
        --해당 자료(미정산내역)이 증가했다는 것을 의미한다.
        --미정산관리계정 예>원화 외상매출금, 원화 미수금, 외화선수금, 미지급금...
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
        
        ELSE    --미정산내역이 정산되었다는 것이다.
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


    --여기할 차례이다.
    
    
    -- 거래처별잔액관리
    -- DBMS_OUTPUT.PUT_LINE ( 'START ' ||V_VNDR_FLAG ||' ' ||P_GB );
    IF V_VNDR_FLAG   = 'Y' THEN
        -- 월별 합계.
        FI_CUSTOMER_BALANCE_P(    SUBSTR(P_GB, 1, 1),             P_SOB_ID,
                                  P_ORG_ID,                       P_PERIOD_NAME,
                                  P_ACCOUNT_BOOK_ID,              P_ACCOUNT_CONTROL_ID,
                                  P_ACCOUNT_CODE,                 P_ACCOUNT_DR_CR,
                                  P_CUSTOMER_ID,                  P_GL_AMOUNT,
                                  P_CURRENCY_CODE,                P_GL_CURRENCY_AMOUNT,
                                  P_MANAGEMENT1,                  P_MANAGEMENT2,
                                  P_CREATION_DATE,                P_CREATED_BY,
                                  P_LAST_UPDATE_DATE,             P_LAST_UPDATED_BY  );

        -- 일별 합계.
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



  -- 부가세 계정
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



  -- 지급어음인 경우 ACCOUNT_CLASS_TYPE = 'PAYABLE_NOTE'
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

/*  -- 받을어음인 경우 ACCOUNT_CLASS_ID = 701
  -- 받을어음 만기결제시
  -- 대변에 어음이 있을경우는 만기결제 또는 할인어음인 경우임... 이때 FI_BILL_MASTER에 Update
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



  -- 차입금 번호가 존재할 경우.
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
