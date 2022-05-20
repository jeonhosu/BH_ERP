CREATE OR REPLACE PACKAGE FI_DPR_EXPENSE_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_DPR_EXPENSE_G
Description  : 감가상각비현황 Package

Reference by : calling assmbly-program id(호출 프로그램) : (감가상각비현황)
Program History :
    참조>FI_DPR_EXPENSE(감가상각비현황) 테이블은 감가상각비현황 자료를 추출하기 위해 임시적으로 사용하는 테이블이다.

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-11-03   Leem Dong Ern(임동언)
*****************************************************************************/



--조회버튼을 클릭하면 CREATE_DPR_EXPENSE PROCEDURE를 실행해 기준자료를 추출 후 
--LIST_DPR_EXPENSE_SUM PROCEDURE를 이용해 집계자료가 조회된다.


--현황조회자료 추출
PROCEDURE CREATE_DPR_EXPENSE(
      W_SOB_ID          IN  FI_DPR_EXPENSE.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN  FI_DPR_EXPENSE.ORG_ID%TYPE          --사업부아이디
    , W_EXPENSE_TYPE    IN  FI_DPR_EXPENSE.EXPENSE_TYPE%TYPE    --경비구분
    , W_WPERIOD_FR      IN  VARCHAR2    --상각기간_시작(예>2011-01)
    , W_WPERIOD_TO      IN  VARCHAR2    --상각기간_종료(예>2011-12)
);







--집계 조회
PROCEDURE LIST_DPR_EXPENSE_SUM( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_DPR_EXPENSE.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN  FI_DPR_EXPENSE.ORG_ID%TYPE          --사업부아이디
    , W_EXPENSE_TYPE    IN  FI_DPR_EXPENSE.EXPENSE_TYPE%TYPE    --경비구분
    , W_WPERIOD_FR      IN  VARCHAR2    --상각기간_시작(예>2011-01)
    , W_WPERIOD_TO      IN  VARCHAR2    --상각기간_종료(예>2011-12)  
);







--상세내역 조회
PROCEDURE LIST_DPR_EXPENSE_DET( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DPR_EXPENSE.SOB_ID%TYPE              --회사아이디
    , W_ORG_ID              IN  FI_DPR_EXPENSE.ORG_ID%TYPE              --사업부아이디
    , W_ASSET_CATEGORY_ID   IN  FI_DPR_EXPENSE.ASSET_CATEGORY_ID%TYPE   --자산유형아이디
    , W_EXPENSE_TYPE        IN  FI_DPR_EXPENSE.EXPENSE_TYPE%TYPE        --경비구분
    , W_WPERIOD_FR          IN  VARCHAR2    --상각기간_시작(예>2011-01)
    , W_WPERIOD_TO          IN  VARCHAR2    --상각기간_종료(예>2011-12)  
);








--취득기간별자산내역 조회
PROCEDURE LIST_ACQUIRE_DPR_EXPENSE( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DPR_EXPENSE.SOB_ID%TYPE              --회사아이디
    , W_ORG_ID              IN  FI_DPR_EXPENSE.ORG_ID%TYPE              --사업부아이디
    , W_ASSET_CATEGORY_ID   IN  FI_DPR_EXPENSE.ASSET_CATEGORY_ID%TYPE   --자산유형아이디
    , W_EXPENSE_TYPE        IN  FI_DPR_EXPENSE.EXPENSE_TYPE%TYPE        --경비구분
    , W_WPERIOD_FR          IN  VARCHAR2    --상각기간_시작(예>2011-01)
    , W_WPERIOD_TO          IN  VARCHAR2    --상각기간_종료(예>2011-12)
    , W_ACQUIRE_FR          IN  DATE        --취득기간_시작(예>2011-01)
    , W_ACQUIRE_TO          IN  DATE        --취득기간_종료(예>2011-12)
);





END FI_DPR_EXPENSE_G;
/
CREATE OR REPLACE PACKAGE BODY FI_DPR_EXPENSE_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_DPR_EXPENSE_G
Description  : 감가상각비현황 Package

Reference by : calling assmbly-program id(호출 프로그램) : (감가상각비현황)
Program History :
    참조>FI_DPR_EXPENSE(감가상각비현황) 테이블은 감가상각비현황 자료를 추출하기 위해 임시적으로 사용하는 테이블이다.

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-11-03   Leem Dong Ern(임동언)
*****************************************************************************/





--현황조회자료 추출
PROCEDURE CREATE_DPR_EXPENSE(
      W_SOB_ID          IN  FI_DPR_EXPENSE.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN  FI_DPR_EXPENSE.ORG_ID%TYPE          --사업부아이디
    , W_EXPENSE_TYPE    IN  FI_DPR_EXPENSE.EXPENSE_TYPE%TYPE    --경비구분
    , W_WPERIOD_FR      IN  VARCHAR2    --상각기간_시작(예>2011-01)
    , W_WPERIOD_TO      IN  VARCHAR2    --상각기간_종료(예>2011-12)
)

AS

t_ASSET_ID      FI_DPR_EXPENSE.ASSET_ID%TYPE;       --자산아이디
t_AMT_SIGN      VARCHAR2(2);
t_THIS_DPR_AMT  FI_DPR_EXPENSE.THIS_DPR_AMT%TYPE;   --당기감가상각비

BEGIN

    --기존 자료를 삭제한다.
    DELETE FI_DPR_EXPENSE;
    
    --기초 자료를 생성한다.
    INSERT INTO FI_DPR_EXPENSE(
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디
        , ASSET_CATEGORY_ID	--자산유형아이디
        , ASSET_ID	        --자산아이디
        , ASSET_CODE	    --자산코드
        , ASSET_DESC	    --자산명
        , EXPENSE_TYPE	    --경비구분
        , START_AMT	        --기초가액
        , THIS_INC	        --당기증가액
        , THIS_DEC	        --당기감소액
        , END_AMT	        --기말잔액
        , PRE_ALLOWANCES_ACCU   --전기충당금누계액
        , THIS_DPR_AMT	        --당기감가상각비
        , PRE_ALLOWANCES_DEC	--전기충당금감소액
        , DPR_ACCUMULATE_AMT	--감가상각누계액
        , BOOK_VALUE	        --미상각잔액    
    )
    SELECT
          SOB_ID  --회사아이디
        , ORG_ID  --사업부아이디
        , ASSET_CATEGORY_ID     --자산유형아이디
        , ASSET_ID              --자산아이디
        , ASSET_CODE            --자산코드
        , ASSET_DESC            --자산명
        , EXPENSE_TYPE          --경비구분
        
        --자산취득일자가 조회시작월 이상이라면 그 자산은 당기에 취득한 것이므로 기초가액은 '0'이고 그 외 경우는 취득금액으로 설정한다.
        , CASE
            WHEN ACQUIRE_DATE >= TO_DATE(W_WPERIOD_FR, 'YYYY-MM') THEN 0
            ELSE AMOUNT --취득금액
          END AMOUNT    --기초가액  
          
        --자산취득일자가 조회기간 내이면 조회기간내에 자산을 취득한 것이므로 취득금액을 설정하고, 그 외 경우는 '0'으로 설정한다.
        , CASE
            WHEN ACQUIRE_DATE >= TO_DATE(W_WPERIOD_FR, 'YYYY-MM') AND ACQUIRE_DATE <= LAST_DAY(TO_DATE(W_WPERIOD_TO, 'YYYY-MM')) THEN AMOUNT    --취득금액
            ELSE 0
          END AMOUNT    --당기증가액      
        , 0             --당기감소액
        
        --자산취득일자가 조회종료시점 이하이면 조회기간 시점에서는 이미 취득된 자산이므로 취득금액을 설정하고, 그 외의 경우는 '0'으로 설정한다.
        , CASE
            WHEN ACQUIRE_DATE <= LAST_DAY(TO_DATE(W_WPERIOD_TO, 'YYYY-MM')) THEN AMOUNT    --취득금액
            ELSE 0
          END AMOUNT    --기말잔액           
        
        , 0         --전기충당금누계액
        , 0         --당기감가상각비
        , 0         --전기충당금감소액
        , 0         --감가상각누계액
        , 0         --미상각잔액
    FROM FI_ASSET_MASTER
    WHERE SOB_ID = W_SOB_ID   --회사아이디
        AND ORG_ID = W_ORG_ID    --사업부아이디
        AND EXPENSE_TYPE = NVL(W_EXPENSE_TYPE, EXPENSE_TYPE)
    ;
    
    



    --전기충당금누계액 보정
    --조회시작월 전월의 감가상각누계액을 설절한다.
    FOR REC_AMT_MODIFY IN (

        SELECT ASSET_ID, DPR_SUM_AMOUNT AS AMOUNT          --감가상각누계액
        FROM FI_ASSET_DPR_HISTORY
        WHERE SOB_ID = W_SOB_ID   --회사아이디
            AND ORG_ID = W_ORG_ID    --사업부아이디
            AND PERIOD_NAME = TO_CHAR(ADD_MONTHS(TO_DATE(W_WPERIOD_FR, 'YYYY-MM'), -1), 'YYYY-MM')
        
    ) LOOP
    
        UPDATE FI_DPR_EXPENSE
        SET PRE_ALLOWANCES_ACCU = REC_AMT_MODIFY.AMOUNT
        WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ;
           
    END LOOP REC_AMT_MODIFY;
    


    --기간전 상각완료된 자산의 전기충당금누계액 보정 : 마지막회차의 감가상각누계액을 설정한다.
    FOR REC_AMT_MODIFY IN (

        SELECT ASSET_ID
            , DPR_SUM_AMOUNT          --감가상각누계액
        FROM FI_ASSET_DPR_HISTORY
        WHERE SOB_ID = W_SOB_ID   --회사아이디
            AND ORG_ID = W_ORG_ID    --사업부아이디
            AND DISUSE_YN = 'Y' --마지막회차여부
            AND PERIOD_NAME < W_WPERIOD_FR
        
    ) LOOP
    
        UPDATE FI_DPR_EXPENSE
        SET   PRE_ALLOWANCES_ACCU = REC_AMT_MODIFY.DPR_SUM_AMOUNT   --전기충당금누계액
        WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ;
           
    END LOOP REC_AMT_MODIFY;


    
    
    --당기감가상각비 보정 : 조회기간내의 감가상각비의 합계로 설정한다.
    FOR REC_AMT_MODIFY IN (

        SELECT ASSET_ID, SUM(SOURCE_AMOUNT) AS AMOUNT   --(최종)감가상각비
        FROM FI_ASSET_DPR_HISTORY
        WHERE SOB_ID = W_SOB_ID   --회사아이디
            AND ORG_ID = W_ORG_ID    --사업부아이디
            AND PERIOD_NAME BETWEEN W_WPERIOD_FR AND W_WPERIOD_TO
        GROUP BY ASSET_ID
        
    ) LOOP
    
        UPDATE FI_DPR_EXPENSE
        SET THIS_DPR_AMT = REC_AMT_MODIFY.AMOUNT
        WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ;
           
    END LOOP REC_AMT_MODIFY;    




    --기초, 증가, 감소, 기말잔액에 영향을 미칠 자산변동내역 자료를 추출하여 해당 금액 변경.
    FOR REC_AMT_MODIFY IN (

        SELECT
              A.ASSET_ID    --자산아이디
            --, C.ASSET_CODE  --자산코드
            --, C.ASSET_DESC  --자산명
            , A.CHARGE_DATE --변경일자
            --, A.CHARGE_ID --변경사유아이디
            --, FI_COMMON_G.ID_NAME_F(A.CHARGE_ID) AS CHARGE_NM   --변경사유
            , A.AMOUNT    --(변동후)금액

            --조회기간 내 증/감 영향자료 여부
            --이 구분값에 의해 해당금액이 증/감 금액에 영향을 미칠지 또는 기초가액에 영향을 미칠지를 판단한다.
            , CASE  
                WHEN TO_CHAR(CHARGE_DATE, 'YYYY-MM') >= W_WPERIOD_FR AND TO_CHAR(CHARGE_DATE, 'YYYY-MM') <= W_WPERIOD_TO THEN 'Y'
                ELSE 'N'
              END INSIDE_REC
              
            , B.AMT_SIGN    --금액증감부호
        FROM FI_ASSET_HISTORY A
            , (--자산의 금액을 변동시키는 요소만 추출
                SELECT 
                      COMMON_ID --금액변동유무
                    , VALUE2 AS AMT_SIGN    --금액증감부호
                FROM FI_COMMON
                WHERE GROUP_CODE = 'ASSET_CHARGE'
                    AND VALUE1 = 'Y'               
            ) B
            --, FI_ASSET_MASTER C
        WHERE A.SOB_ID = W_SOB_ID   --회사아이디
            AND A.ORG_ID = W_ORG_ID    --사업부아이디 
            AND TO_CHAR(A.CHARGE_DATE, 'YYYY-MM') <= W_WPERIOD_TO   --변경일자
            
            AND A.CHARGE_ID = B.COMMON_ID
           -- AND A.ASSET_ID = C.ASSET_ID
        ORDER BY ASSET_ID, CHARGE_DATE 
        
    ) LOOP
        /*IF REC_AMT_MODIFY.ASSET_ID = 3296 THEN
          DBMS_OUTPUT.PUT_LINE(REC_AMT_MODIFY.CHARGE_DATE || '/' || REC_AMT_MODIFY.AMOUNT || '/' || REC_AMT_MODIFY.INSIDE_REC || '/' || REC_AMT_MODIFY.AMT_SIGN);  
        END IF;*/
        
        --조회조건에 해당하는 자료 중 특정 자상의 자산변동내역의 자료가 2건 이상이 발생된 경우 
        --전(2건 이상일 경우 앞의 자료) 자료가 매각 또는 폐기인 경우 
        --더 이상의 금액변동의 필요가 없다. 사실 이런 일은 있을 수 없는 일인데 혹시나 해서 처리한다.        
        --예>매각된 자료에 대해 매각일 후 자본적지출이 발생한 자료가 있을 수는 없다.        
        IF REC_AMT_MODIFY.ASSET_ID = t_ASSET_ID AND t_AMT_SIGN = 'N' THEN
            NULL;


--조회조건 기간 내에 자산변동이 발생한 경우
        --조회조건 기간 내에 자본적지출이 발생된 경우라면 [당기증가액, 기말잔액]을 변경해준다.
        ELSIF REC_AMT_MODIFY.INSIDE_REC = 'Y' AND REC_AMT_MODIFY.AMT_SIGN = '+' THEN
            UPDATE FI_DPR_EXPENSE
            SET THIS_INC = NVL(THIS_INC, 0) + NVL(REC_AMT_MODIFY.AMOUNT, 0) --당기증가액
                , END_AMT = NVL(END_AMT, 0)+ NVL(REC_AMT_MODIFY.AMOUNT, 0) --기말잔액
            WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ;
            
        --조회조건 기간 내에 부분매각이 발생된 경우라면 
        ELSIF REC_AMT_MODIFY.INSIDE_REC = 'Y' AND REC_AMT_MODIFY.AMT_SIGN = '-' THEN
            --[당기감소액, 기말잔액]을 변경해준다.
            UPDATE FI_DPR_EXPENSE
            SET THIS_DEC = NVL(THIS_DEC, 0) + NVL(REC_AMT_MODIFY.AMOUNT, 0) --당기감소액
                , END_AMT = NVL(END_AMT, 0) - NVL(REC_AMT_MODIFY.AMOUNT, 0) --기말잔액
            WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ; 
            
            --[전기충당금감소액]을 변경해준다.
            UPDATE FI_DPR_EXPENSE
            SET PRE_ALLOWANCES_DEC = 
                    NVL((
                              SELECT (DPR_COUNT - 1) * SP_MNS_DPR_AMOUNT
                              FROM FI_ASSET_DPR_HISTORY
                              WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID
                                  AND PERIOD_NAME = TO_CHAR(ADD_MONTHS(REC_AMT_MODIFY.CHARGE_DATE, 1) , 'YYYY-MM')                    
                          ), 0)
            WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ; 
    
    
            
        --조회조건 기간 내에 매각 또는 폐기가 발생된 경우라면...
        --[당기감소액]에는 해당자산의 기초가액을 설정한다.
        --[기말잔액]은 매각 또는 폐기로 '0'이 된다.
        ELSIF REC_AMT_MODIFY.INSIDE_REC = 'Y' AND REC_AMT_MODIFY.AMT_SIGN = 'N' THEN

            --당기감가상각비 보정
            --일반적으로는 조회기간 내의 감가상각비의 합인데,
            --매각 또는 폐기가 발생된 자산의 경우 종료일을 매각 또는 변경이 발생된 월로 설정하여 구한다.
            BEGIN
              SELECT SUM(SOURCE_AMOUNT) AS AMOUNT   --(최종)감가상각비
              INTO t_THIS_DPR_AMT
              FROM FI_ASSET_DPR_HISTORY
              WHERE SOB_ID = W_SOB_ID   --회사아이디
                  AND ORG_ID = W_ORG_ID    --사업부아이디
                  AND ASSET_ID = REC_AMT_MODIFY.ASSET_ID
                  AND PERIOD_NAME BETWEEN W_WPERIOD_FR AND TO_CHAR(REC_AMT_MODIFY.CHARGE_DATE, 'YYYY-MM')
              GROUP BY ASSET_ID   ;
            EXCEPTION WHEN OTHERS THEN
              t_THIS_DPR_AMT := 0;
            END;
            
            /*-- 전호수 수정(2013-01-18) : 당기 취득자산중 자산변동 발생시 기말금액 계산 오류 --
            UPDATE FI_DPR_EXPENSE
            SET THIS_DEC = NVL(THIS_DEC, 0) + NVL(START_AMT, 0) --당기감소액
                , END_AMT = NVL(END_AMT, 0) - NVL(START_AMT, 0) --기말잔액
                , THIS_DPR_AMT = t_THIS_DPR_AMT --당기감가상각비
                
                --전기충당금감소액 = 전기충당금누계액 + 당기감가상각비
                --매각 또는 폐기가 발생됐으므로 감가상각 전 금액이 감소한다.
                , PRE_ALLOWANCES_DEC = NVL(PRE_ALLOWANCES_ACCU, 0) + NVL(t_THIS_DPR_AMT, 0)
            WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ;*/
            
            UPDATE FI_DPR_EXPENSE
            SET THIS_DEC = NVL(THIS_DEC, 0) + (NVL(THIS_INC, 0) + NVL(START_AMT, 0)) --당기감소액
                , END_AMT = NVL(END_AMT, 0) - (NVL(THIS_INC, 0) + NVL(START_AMT, 0)) --기말잔액
                , THIS_DPR_AMT = t_THIS_DPR_AMT --당기감가상각비
                
                --전기충당금감소액 = 전기충당금누계액 + 당기감가상각비
                --매각 또는 폐기가 발생됐으므로 감가상각 전 금액이 감소한다.
                , PRE_ALLOWANCES_DEC = NVL(PRE_ALLOWANCES_ACCU, 0) + NVL(t_THIS_DPR_AMT, 0)
            WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ;
            





--조회조건 기간 전에 자산변동이 발생한 경우
        --조회조건 기간 전에 자본적지출이 발생된 경우라면 [기초가액, 기말잔액]을 변경(증가)해준다.
        ELSIF REC_AMT_MODIFY.INSIDE_REC = 'N' AND REC_AMT_MODIFY.AMT_SIGN = '+' THEN
            UPDATE FI_DPR_EXPENSE
            SET START_AMT = NVL(START_AMT, 0) + NVL(REC_AMT_MODIFY.AMOUNT, 0)   --기초가액
                , END_AMT = NVL(END_AMT, 0) + NVL(REC_AMT_MODIFY.AMOUNT, 0)     --기말잔액
            WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ;
            
        --조회조건 기간 전에 부분매각이 발생된 경우라면 [기초가액, 기말잔액]을 변경(감소)해준다.
        ELSIF REC_AMT_MODIFY.INSIDE_REC = 'N' AND REC_AMT_MODIFY.AMT_SIGN = '-' THEN
            UPDATE FI_DPR_EXPENSE
            SET START_AMT = NVL(START_AMT, 0) - NVL(REC_AMT_MODIFY.AMOUNT, 0)   --기초가액
                , END_AMT = NVL(END_AMT, 0) - NVL(REC_AMT_MODIFY.AMOUNT, 0)     --기말잔액
            WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ;
            
        --조회조건 기간 전에 매각 또는 폐기가 발생된 경우라면 모든금액을 '0'으로 변경해준다.
        ELSIF REC_AMT_MODIFY.INSIDE_REC = 'N' AND REC_AMT_MODIFY.AMT_SIGN = 'N' THEN
            UPDATE FI_DPR_EXPENSE
            SET   START_AMT = 0             --기초가액
                , THIS_INC = 0              --당기증가액
                , THIS_DEC = 0              --당기감소액            
                , END_AMT = 0               --기말잔액
                , PRE_ALLOWANCES_ACCU = 0   --전기충당금누계액
                , THIS_DPR_AMT = 0          --당기감가상각비
                , PRE_ALLOWANCES_DEC = 0    --전기충당금감소액
                , DPR_ACCUMULATE_AMT = 0    --감가상각누계액
                , BOOK_VALUE = 0            --미상각잔액                
            WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ;

        END IF;
        
        t_ASSET_ID := REC_AMT_MODIFY.ASSET_ID;
        t_AMT_SIGN := REC_AMT_MODIFY.AMT_SIGN;        

    END LOOP REC_AMT_MODIFY;





    --감가상각누계액, 미상각잔액 보정
    --감가상각누계액 = 전기충당금누계액 + 당기감가상각비 - 전기충당금감소액
    --미상각잔액 = 기말잔액 - 감가상각누계액
    UPDATE FI_DPR_EXPENSE
    SET   DPR_ACCUMULATE_AMT = PRE_ALLOWANCES_ACCU + THIS_DPR_AMT - PRE_ALLOWANCES_DEC
        , BOOK_VALUE = END_AMT - (PRE_ALLOWANCES_ACCU + THIS_DPR_AMT  - PRE_ALLOWANCES_DEC)
    ;



END CREATE_DPR_EXPENSE;








--집계 조회
PROCEDURE LIST_DPR_EXPENSE_SUM( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_DPR_EXPENSE.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN  FI_DPR_EXPENSE.ORG_ID%TYPE          --사업부아이디
    , W_EXPENSE_TYPE    IN  FI_DPR_EXPENSE.EXPENSE_TYPE%TYPE    --경비구분
    , W_WPERIOD_FR      IN  VARCHAR2    --상각기간_시작(예>2011-01)
    , W_WPERIOD_TO      IN  VARCHAR2    --상각기간_종료(예>2011-12)  
)


AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          A.ASSET_CATEGORY_ID	--자산유형아이디
        , B.ASSET_CATEGORY_CODE --자산유형코드     
        , NVL(B.ASSET_CATEGORY_NAME, '<< 합계  >>') AS ASSET_CATEGORY_NAME --자산유형
        , NVL(FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', W_EXPENSE_TYPE, W_SOB_ID, W_ORG_ID), '전체') AS EXPENSE_TYPE_NM   --경비구분
        , A.START_AMT           --기초가액
        , A.THIS_INC            --당기증가액
        , A.THIS_DEC            --당기감소액
        , A.END_AMT             --기말잔액
        , A.PRE_ALLOWANCES_ACCU --전기충당금누계액
        , A.THIS_DPR_AMT        --당기감가상각비
        , A.PRE_ALLOWANCES_DEC  --전기충당금감소액
        , A.DPR_ACCUMULATE_AMT  --감가상각누계액
        , A.BOOK_VALUE          --미상각잔액
        , TO_CHAR(TO_DATE(W_WPERIOD_FR, 'YYYY-MM'), 'YYYY-MM-DD') AS WPERIOD_FR            --상각기간_시작일
        , TO_CHAR(LAST_DAY(TO_DATE(W_WPERIOD_TO, 'YYYY-MM')), 'YYYY-MM-DD') AS WPERIOD_TO  --상각기간_종료일
    FROM
        (
            SELECT
                  ASSET_CATEGORY_ID	            --자산유형아이디
                , SUM(START_AMT) AS	START_AMT   --기초가액
                , SUM(THIS_INC) AS THIS_INC     --당기증가액
                , SUM(THIS_DEC) AS THIS_DEC	    --당기감소액
                , SUM(END_AMT) AS END_AMT	    --기말잔액
                , SUM(PRE_ALLOWANCES_ACCU) AS PRE_ALLOWANCES_ACCU   --전기충당금누계액
                , SUM(THIS_DPR_AMT) AS THIS_DPR_AMT	                --당기감가상각비
                , SUM(PRE_ALLOWANCES_DEC) AS PRE_ALLOWANCES_DEC	    --전기충당금감소액
                , SUM(DPR_ACCUMULATE_AMT) AS DPR_ACCUMULATE_AMT	    --감가상각누계액
                , SUM(BOOK_VALUE) AS BOOK_VALUE	                    --미상각잔액 
            FROM FI_DPR_EXPENSE
            WHERE SOB_ID = W_SOB_ID     --회사아이디
                AND ORG_ID = W_ORG_ID   --사업부아이디
            GROUP BY ROLLUP(ASSET_CATEGORY_ID)
        ) A
        , ( SELECT
                 ASSET_CATEGORY_ID      --자산유형아이디
               , ASSET_CATEGORY_CODE    --자산유형코드
               , ASSET_CATEGORY_NAME    --자산유형
            FROM FI_ASSET_CATEGORY
            WHERE SOB_ID = W_SOB_ID       
          ) B
    WHERE A.ASSET_CATEGORY_ID = B.ASSET_CATEGORY_ID(+)
    ORDER BY B.ASSET_CATEGORY_CODE  ;

END LIST_DPR_EXPENSE_SUM;








--상세내역 조회
PROCEDURE LIST_DPR_EXPENSE_DET( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DPR_EXPENSE.SOB_ID%TYPE              --회사아이디
    , W_ORG_ID              IN  FI_DPR_EXPENSE.ORG_ID%TYPE              --사업부아이디
    , W_ASSET_CATEGORY_ID   IN  FI_DPR_EXPENSE.ASSET_CATEGORY_ID%TYPE   --자산유형아이디
    , W_EXPENSE_TYPE        IN  FI_DPR_EXPENSE.EXPENSE_TYPE%TYPE        --경비구분
    , W_WPERIOD_FR          IN  VARCHAR2    --상각기간_시작(예>2011-01)
    , W_WPERIOD_TO          IN  VARCHAR2    --상각기간_종료(예>2011-12)   
)


AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          A.ASSET_CATEGORY_ID	--자산유형아이디
        , B.ASSET_CATEGORY_CODE --자산유형코드
        , B.ASSET_CATEGORY_NAME --자산유형
        , NVL(FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', W_EXPENSE_TYPE, W_SOB_ID, W_ORG_ID), '전체') AS EXPENSE_TYPE_NM   --경비구분
        --, DECODE(GROUPING(ASSET_CODE), '0', NVL(FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', W_EXPENSE_TYPE, W_SOB_ID), '전체'), '<<  합계  >>') AS EXPENSE_TYPE_NM   --경비구분
        , A.ASSET_ID    --자산아이디
        , A.ASSET_CODE  --자산코드
        , A.ASSET_DESC  --자산명  
        
        , A.START_AMT        --기초가액
        , A.THIS_INC	        --당기증가액
        , A.THIS_DEC	        --당기감소액
        , A.END_AMT	        --기말잔액
        , A.PRE_ALLOWANCES_ACCU   --전기충당금누계액
        , A.THIS_DPR_AMT	        --당기감가상각비
        , A.PRE_ALLOWANCES_DEC	--전기충당금감소액
        , A.DPR_ACCUMULATE_AMT	--감가상각누계액
        , A.BOOK_VALUE	        --미상각잔액
     
/*
        , SUM(A.START_AMT) AS START_AMT        --기초가액
        , SUM(A.THIS_INC) AS THIS_INC	        --당기증가액
        , SUM(A.THIS_DEC) AS THIS_DEC	        --당기감소액
        , SUM(A.END_AMT) AS END_AMT	        --기말잔액
        , SUM(A.PRE_ALLOWANCES_ACCU) AS PRE_ALLOWANCES_ACCU   --전기충당금누계액
        , SUM(A.THIS_DPR_AMT) AS THIS_DPR_AMT	        --당기감가상각비
        , SUM(A.PRE_ALLOWANCES_DEC) AS PRE_ALLOWANCES_DEC	--전기충당금감소액
        , SUM(A.DPR_ACCUMULATE_AMT) AS DPR_ACCUMULATE_AMT	--감가상각누계액
        , SUM(A.BOOK_VALUE) AS BOOK_VALUE	        --미상각잔액        
*/        
        , TO_CHAR(TO_DATE(W_WPERIOD_FR, 'YYYY-MM'), 'YYYY-MM-DD') AS WPERIOD_FR            --상각기간_시작일
        , TO_CHAR(LAST_DAY(TO_DATE(W_WPERIOD_TO, 'YYYY-MM')), 'YYYY-MM-DD') AS WPERIOD_TO  --상각기간_종료일        
    FROM FI_DPR_EXPENSE A
        , ( SELECT
                 ASSET_CATEGORY_ID  --자산유형아이디
               , ASSET_CATEGORY_CODE    --자산유형코드
               , ASSET_CATEGORY_NAME    --자산유형
            FROM FI_ASSET_CATEGORY
            WHERE SOB_ID = W_SOB_ID   --회사아이디       
          ) B
    WHERE A.SOB_ID = W_SOB_ID   --회사아이디
        AND A.ORG_ID = W_ORG_ID    --사업부아이디
        AND A.ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID
        
        AND A.ASSET_CATEGORY_ID = B.ASSET_CATEGORY_ID
        AND A.BOOK_VALUE        != 0
    --GROUP BY ROLLUP((A.ASSET_CATEGORY_ID, B.ASSET_CATEGORY_CODE, B.ASSET_CATEGORY_NAME, ASSET_ID, ASSET_CODE, ASSET_DESC))    
    ORDER BY A.ASSET_CODE   ;

END LIST_DPR_EXPENSE_DET;









--취득기간별자산내역 조회
PROCEDURE LIST_ACQUIRE_DPR_EXPENSE( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DPR_EXPENSE.SOB_ID%TYPE              --회사아이디
    , W_ORG_ID              IN  FI_DPR_EXPENSE.ORG_ID%TYPE              --사업부아이디
    , W_ASSET_CATEGORY_ID   IN  FI_DPR_EXPENSE.ASSET_CATEGORY_ID%TYPE   --자산유형아이디
    , W_EXPENSE_TYPE        IN  FI_DPR_EXPENSE.EXPENSE_TYPE%TYPE        --경비구분
    , W_WPERIOD_FR          IN  VARCHAR2    --상각기간_시작(예>2011-01)
    , W_WPERIOD_TO          IN  VARCHAR2    --상각기간_종료(예>2011-12)
    , W_ACQUIRE_FR          IN  DATE        --취득기간_시작
    , W_ACQUIRE_TO          IN  DATE        --취득기간_종료
)

AS

BEGIN

    OPEN P_CURSOR FOR   

    SELECT
          A.ASSET_CATEGORY_ID	--자산유형아이디
        , B.ASSET_CATEGORY_CODE --자산유형코드
        , B.ASSET_CATEGORY_NAME --자산유형
        
        --, NVL(FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', A.EXPENSE_TYPE, A.SOB_ID, A.ORG_ID), '전체') AS EXPENSE_TYPE_NM   --경비구분
        , DECODE( GROUPING(ASSET_CATEGORY_CODE), '1', '', 
            DECODE(GROUPING(ASSET_CATEGORY_NAME), '0', 
                    NVL(FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', A.EXPENSE_TYPE, A.SOB_ID, A.ORG_ID), '')
                )
          ) AS EXPENSE_TYPE_NM   --경비구분
          
        , A.ASSET_ID            --자산아이디
        , A.ASSET_CODE          --자산코드
        
        --, A.ASSET_DESC          --자산명
        , DECODE(GROUPING(ASSET_CATEGORY_CODE), 1, '  << 누      계 >>', DECODE(ASSET_CATEGORY_NAME, NULL, '  [[ 합      계 ]]',  A.ASSET_DESC)) AS ASSET_DESC  --자산명
        
        , C.ACQUIRE_DATE        --취득일자
        , C.ASSET_STATUS_NM     --자산상태
        , C.IFRS_DPR_STATUS_NM  --상각상태
        
        , SUM(A.START_AMT) AS START_AMT --기초가액
        , SUM(A.THIS_INC) AS THIS_INC	--당기증가액
        , SUM(A.THIS_DEC) AS THIS_DEC	--당기감소액
        , SUM(A.END_AMT) AS END_AMT	    --기말잔액
        , SUM(A.PRE_ALLOWANCES_ACCU) AS PRE_ALLOWANCES_ACCU --전기충당금누계액
        , SUM(A.THIS_DPR_AMT) AS THIS_DPR_AMT	            --당기감가상각비
        , SUM(A.PRE_ALLOWANCES_DEC) AS PRE_ALLOWANCES_DEC	--전기충당금감소액
        , SUM(A.DPR_ACCUMULATE_AMT) AS DPR_ACCUMULATE_AMT	--감가상각누계액
        , SUM(A.BOOK_VALUE) AS BOOK_VALUE	                --미상각잔액  
        
        , C.CC_CODE                 --원가코드
        , C.CC_DESC                 --원가명
        , C.AMOUNT                  --취득금액    
        , C.IFRS_PROGRESS_YEAR      --내용년수
        , C.IFRS_RESIDUAL_AMOUNT    --잔존가액
        , C.MANAGE_DEPT_NM          --관리부서    
        , C.REMARK                  --비고    

        , W_ACQUIRE_FR AS ACQUIRE_FR    --취득기간_시작일
        , W_ACQUIRE_TO AS ACQUIRE_TO    --취득기간_종료일 
        , W_WPERIOD_FR AS PERIOD_FR     --상각기간_시작일
        , W_WPERIOD_TO AS PERIOD_TO     --상각기간_종료일  
    FROM FI_DPR_EXPENSE A
        , ( SELECT
                 ASSET_CATEGORY_ID  --자산유형아이디
               , ASSET_CATEGORY_CODE    --자산유형코드
               , ASSET_CATEGORY_NAME    --자산유형
            FROM FI_ASSET_CATEGORY
            WHERE SOB_ID = W_SOB_ID   --회사아이디       
          ) B
        , (
            SELECT
                  A.ASSET_CODE    --자산코드
                --, A.ASSET_STATUS_CODE  --자산상태
                , A.ACQUIRE_DATE   --취득일자
                , FI_COMMON_G.CODE_NAME_F('ASSET_STATUS', A.ASSET_STATUS_CODE, A.SOB_ID) AS ASSET_STATUS_NM  --자산상태
                , A.AMOUNT         --취득금액 
                --, A.COST_CENTER_ID --원가아이디
                , FI_COMMON_G.COST_CENTER_CODE_F(A.COST_CENTER_ID) AS CC_CODE  --원가코드
                , FI_COMMON_G.COST_CENTER_DESC_F(A.COST_CENTER_ID) AS CC_DESC  --원가명
                --, A.MANAGE_DEPT_ID --관리부서아이디
                , FI_DEPT_MASTER_G.DEPT_NAME_F(A.MANAGE_DEPT_ID) AS MANAGE_DEPT_NM --관리부서
                , A.REMARK --비고
                , A.IFRS_PROGRESS_YEAR --(IFRS)내용년수
                , A.IFRS_RESIDUAL_AMOUNT   --(IFRS)잔존가액
                --, A.IFRS_DPR_STATUS_CODE   --(IFRS)상각상태
                , FI_COMMON_G.CODE_NAME_F('DPR_STATUS', A.IFRS_DPR_STATUS_CODE, A.SOB_ID) AS IFRS_DPR_STATUS_NM  --(IFRS)상각상태
            FROM FI_ASSET_MASTER A
            WHERE A.ACQUIRE_DATE BETWEEN NVL(W_ACQUIRE_FR, A.ACQUIRE_DATE) AND NVL(W_ACQUIRE_TO, A.ACQUIRE_DATE)
        ) C
    WHERE A.SOB_ID = W_SOB_ID   --회사아이디
        AND A.ORG_ID = W_ORG_ID    --사업부아이디
        AND A.ASSET_CATEGORY_ID = NVL(W_ASSET_CATEGORY_ID, A.ASSET_CATEGORY_ID)
        
        AND A.ASSET_CATEGORY_ID = B.ASSET_CATEGORY_ID
        
        AND C.ASSET_CODE = A.ASSET_CODE
    GROUP BY ROLLUP(ASSET_CATEGORY_CODE, (A.ASSET_CATEGORY_ID, ASSET_CATEGORY_NAME, A.EXPENSE_TYPE, A.ASSET_ID, A.SOB_ID, A.ORG_ID, A.ASSET_CODE, ASSET_DESC, ACQUIRE_DATE, ASSET_STATUS_NM, IFRS_DPR_STATUS_NM, START_AMT, THIS_INC, THIS_DEC, END_AMT, PRE_ALLOWANCES_ACCU, THIS_DPR_AMT, PRE_ALLOWANCES_DEC, DPR_ACCUMULATE_AMT, BOOK_VALUE, CC_CODE, CC_DESC, AMOUNT, IFRS_PROGRESS_YEAR, IFRS_RESIDUAL_AMOUNT, MANAGE_DEPT_NM, REMARK))        
    ORDER BY ASSET_CATEGORY_CODE, ASSET_CODE   ;

END LIST_ACQUIRE_DPR_EXPENSE;








END FI_DPR_EXPENSE_G;
/
