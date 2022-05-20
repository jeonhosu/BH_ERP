CREATE OR REPLACE PACKAGE FI_FS_IS_PARADE_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FS_IS_PARADE_G
Description  : 손익계산서 Package

Reference by : calling assmbly-program id(호출 프로그램) : FCMF0762(손익계산서)
Program History :
    1.FI_FS_IS_PARADE 테이블은 GLOBAL TEMPORARY TABLE이다.
    2.손익계산서 구하는 절차
      1단계>최하위레벨의 금액을 구한다.
      2단계>최하위레벨이 아닌 항목들에 대한 금액을 구한다.
      3단계>손익계산서를 조회한다.      
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-08-31   Leem Dong Ern(임동언)          
*****************************************************************************/


t_FORM_TYPE_ID      FI_FORM_MST.FORM_TYPE_ID%TYPE;  --보고서양식ID(공통코드) 
t_LAST_ITEM_LEVEL   NUMBER := 0;    --조회된 자료 목록 중에서 최하위레벨을 구한다.
t_FORWARD_RAW_AMT   NUMBER := 0;    --전기이월된 원재료금액
t_FORWARD_LINE_AMT  NUMBER := 0;    --전기이월된 재공품금액
t_FS_SET_ID         FI_FORM_MST.FS_SET_ID%TYPE;  --보고서기준세트아이디




--손익계산서 grid에 조회되는 자료 추출
--이 프로시져를 호출하는 타 프로그램 : 손익계산서, 결산처리 > 결산분개
PROCEDURE LIST_IS( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE     --회사아이디
    , W_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE     --사업부아이디
    , W_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE  --보고서기준세트아이디
    , W_CLOSING_YEAR    IN  VARCHAR2                    --결산년(년 탭의 경우 종료기간에서 년만을 추출하여 넘긴다.)
    , W_DATA_GB         IN  VARCHAR2                    --자료구분(M : 월, Q : 분기, H : 반기, Y : 년)

    --종료월은 시작월보다 같거나 커야 합니다.
    , W_CLOSING_START   IN  VARCHAR2                    --조회 시작월(예> M01[1월인경우], Q01, H01 , 년의 경우 : 2011-01)
    , W_CLOSING_END     IN  VARCHAR2                    --조회 종료월(예> M06[6월인경우], Q03, H02 , 년의 경우 : 2011-09)    
);






--LIST_IS PROCEDURE와 동일한 것으로 자료구분이 월이 아닌 경우
--자료구분이 월인 경우 각 월의 기말상품재고액/기말제품재고액을 구해 
--자료구분이 분기, 반기, 년 인 경우의 기말상품재고액/기말제품재고액을 구하기 위함이다.
PROCEDURE LIST_IS_M_OTHER( 
      W_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE     --회사아이디
    , W_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE     --사업부아이디
    , W_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE  --보고서기준세트아이디
    , W_CLOSING_YEAR    IN  VARCHAR2                    --결산년
    , W_DATA_GB         IN  VARCHAR2                    --자료구분(M : 월)

    --종료월은 시작월보다 같거나 커야 합니다.
    , W_CLOSING_START   IN  VARCHAR2                    --조회 시작월(예> M01 : 1월인경우)
    , W_CLOSING_END     IN  VARCHAR2                    --조회 종료월(예> M12 : 12월인경우)
);





--해당월에 맞는 칼럼에 값을 UPDATE한다.
PROCEDURE UPDATE_AMT( 
      W_TERM        IN  VARCHAR2    --월
    , W_AMT         IN  NUMBER      --금액
    , W_ITEM_CODE   IN  FI_FS_IS_PARADE.ITEM_CODE%TYPE    --항목코드_계정코드
);






--재고자산기말자료를 구한다.
FUNCTION INVENTORY_DATA_F(
      W_DATA_GB IN VARCHAR2                 --C : 건수, A : 금액
    , W_SOB_ID  IN FI_FORM_MST.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID  IN FI_FORM_MST.ORG_ID%TYPE  --사업부아이디
    , W_PERIOD  IN VARCHAR2                 --조회기간(예>2011-12)
    
    --재고자산금액관리항목코드(402 : 기말상품, 302 : 기말제품)
    , W_FORM_ITEM_TYPE_CD   IN FI_CLOSING_ENDING_AMOUNT.FORM_ITEM_TYPE_CD%TYPE
) RETURN NUMBER;








--출력시 사용; 합잔, 제조, 손익, 재무상태표 4개 양식 공통
PROCEDURE PRINT_TITLE(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  GL_FISCAL_YEAR.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN  GL_FISCAL_YEAR.ORG_ID%TYPE          --사업부아이디
    , W_PERIOD_TO       IN VARCHAR2                             --조회기간_종료  
);




END FI_FS_IS_PARADE_G;
/
CREATE OR REPLACE PACKAGE BODY FI_FS_IS_PARADE_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FS_IS_PARADE_G
Description  : 손익계산서 Package

Reference by : calling assmbly-program id(호출 프로그램) : FCMF0762(손익계산서)
Program History :
    1.FI_FS_IS_PARADE 테이블은 GLOBAL TEMPORARY TABLE이다.
    2.손익계산서 구하는 절차
      1단계>최하위레벨의 금액을 구한다.
      2단계>최하위레벨이 아닌 항목들에 대한 금액을 구한다.
      3단계>손익계산서를 조회한다.      
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-08-31   Leem Dong Ern(임동언)          
*****************************************************************************/



--손익계산서 grid에 조회되는 자료 추출
--이 프로시져를 호출하는 타 프로그램 : 손익계산서, 결산처리 > 결산분개
PROCEDURE LIST_IS( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE     --회사아이디
    , W_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE     --사업부아이디
    , W_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE  --보고서기준세트아이디
    , W_CLOSING_YEAR    IN  VARCHAR2                    --결산년(년 탭의 경우 종료기간에서 년만을 추출하여 넘긴다.)
    , W_DATA_GB         IN  VARCHAR2                    --자료구분(M : 월, Q : 분기, H : 반기, Y : 년)

    --종료월은 시작월보다 같거나 커야 합니다.
    , W_CLOSING_START   IN  VARCHAR2                    --조회 시작월(예> M01[1월인경우], Q01, H01 , 년의 경우 : 2011-01)
    , W_CLOSING_END     IN  VARCHAR2                    --조회 종료월(예> M06[6월인경우], Q03, H02 , 년의 경우 : 2011-09) 
)

AS

t_CNT               NUMBER := 0;    --재고자산기말금액 자료존재 유무를 파악하기 위함.


t_TERM_START_M      VARCHAR2(2) := NULL;    --당기시작월
t_TERM_END_M        VARCHAR2(2) := NULL;    --당기종료월
t_REPEAT            VARCHAR2(2) := NULL;    --자료조회월
t_PERIOD_FROM       DATE;                   --당기시작일
t_PERIOD_TO         DATE;                   --당기종료일


t_REPEAT_MM        VARCHAR2(2) := NULL;    --재고자산기말금액 추출시 사용함.

t_WORK_MM           VARCHAR2(2) := NULL;    --년의 경우 사용함.
t_RECURSIVE_CNT     NUMBER  := 0;           --재고자산기말금액 추출을 위한 LOOP문 반복 회수


--당기의 의미 : [월]탭에서는 1월, 2월 등의 각 월을 의미하고, [분기]탭에서 1분기, 2분기 등을 의미하는 이런 식이다.
t_THIS_LAST_LEVEL_AMT       NUMBER  := 0;   --당기_최하위레벨항목금액

t_LAST_LEVEL_AMT_01         NUMBER  := 0;   --01월_최하위레벨항목금액
t_LAST_LEVEL_AMT_01_CALC    NUMBER  := 0;   --01월_최하위레벨항목금액 집계를 위한 변수
t_LAST_LEVEL_AMT_02         NUMBER  := 0;   --02월_최하위레벨항목금액
t_LAST_LEVEL_AMT_02_CALC    NUMBER  := 0;   --02월_최하위레벨항목금액 집계를 위한 변수
t_LAST_LEVEL_AMT_03         NUMBER  := 0;   --03월_최하위레벨항목금액
t_LAST_LEVEL_AMT_03_CALC    NUMBER  := 0;   --03월_최하위레벨항목금액 집계를 위한 변수        
t_LAST_LEVEL_AMT_04         NUMBER  := 0;   --04월_최하위레벨항목금액
t_LAST_LEVEL_AMT_04_CALC    NUMBER  := 0;   --04월_최하위레벨항목금액 집계를 위한 변수
t_LAST_LEVEL_AMT_05         NUMBER  := 0;   --05월_최하위레벨항목금액
t_LAST_LEVEL_AMT_05_CALC    NUMBER  := 0;   --05월_최하위레벨항목금액 집계를 위한 변수
t_LAST_LEVEL_AMT_06         NUMBER  := 0;   --06월_최하위레벨항목금액
t_LAST_LEVEL_AMT_06_CALC    NUMBER  := 0;   --06월_최하위레벨항목금액 집계를 위한 변수 
t_LAST_LEVEL_AMT_07         NUMBER  := 0;   --07월_최하위레벨항목금액
t_LAST_LEVEL_AMT_07_CALC    NUMBER  := 0;   --07월_최하위레벨항목금액 집계를 위한 변수
t_LAST_LEVEL_AMT_08         NUMBER  := 0;   --08월_최하위레벨항목금액
t_LAST_LEVEL_AMT_08_CALC    NUMBER  := 0;   --08월_최하위레벨항목금액 집계를 위한 변수
t_LAST_LEVEL_AMT_09         NUMBER  := 0;   --09월_최하위레벨항목금액
t_LAST_LEVEL_AMT_09_CALC    NUMBER  := 0;   --09월_최하위레벨항목금액 집계를 위한 변수 
t_LAST_LEVEL_AMT_10         NUMBER  := 0;   --10월_최하위레벨항목금액
t_LAST_LEVEL_AMT_10_CALC    NUMBER  := 0;   --10월_최하위레벨항목금액 집계를 위한 변수
t_LAST_LEVEL_AMT_11         NUMBER  := 0;   --11월_최하위레벨항목금액
t_LAST_LEVEL_AMT_11_CALC    NUMBER  := 0;   --11월_최하위레벨항목금액 집계를 위한 변수
t_LAST_LEVEL_AMT_12         NUMBER  := 0;   --12월_최하위레벨항목금액
t_LAST_LEVEL_AMT_12_CALC    NUMBER  := 0;   --12월_최하위레벨항목금액 집계를 위한 변수 

t_INVENTORY_AMOUNT      NUMBER := 0;   --재고자산 이월금액
t_TERM_END_AMT          NUMBER := 0;   --재고자산 기간말금액
t_TERM_END_AMT_NEXT     NUMBER := 0;   --재고자산 기간말금액(차기 기초제고액으로 설절하기 위함)
t_TERM_END_LINE_AMT     NUMBER := 0;   --재고자산 기말재공품재고액
t_TERM_END_LINE_AMT_0   NUMBER := 0;   --재고자산 기말재공품재고액이 0 인경우를 대비하여 사용.
t_TERM_END_RAW_AMT      NUMBER := 0;   --재고자산 원재료금액
t_MATERIAL_AMT          NUMBER := 0;   --기말원재료재고액 임시 저장
t_ITEM_COST             NUMBER := 0;   --당기제품제조원가 임시 저장


t_ITEM_CODE     FI_FS_IS_PARADE.ITEM_CODE%TYPE;      --항목코드_계정코드
t_ACCOUNT_DR_CR FI_FS_IS_PARADE.ACCOUNT_DR_CR%TYPE;  --차대구분(1-차변,2-대변)

--제조원가명세서의 당기제품제조원가를 추출하기 위한 CURSOR임.
TYPE TCURSOR IS REF CURSOR;
IS_TCURSOR TCURSOR;



--자료구분이 분기, 반기, 년 인 경우의 기말상품재고액/기말제품재고액을 구하기 위함이다.
t_ITEM_AMT_01   NUMBER := 0;   --기말상품재고액(01월)
t_ITEM_AMT_02   NUMBER := 0;   --기말상품재고액(02월)
t_ITEM_AMT_03   NUMBER := 0;   --기말상품재고액(03월)
t_ITEM_AMT_04   NUMBER := 0;   --기말상품재고액(04월)
t_ITEM_AMT_05   NUMBER := 0;   --기말상품재고액(05월)
t_ITEM_AMT_06   NUMBER := 0;   --기말상품재고액(06월)
t_ITEM_AMT_07   NUMBER := 0;   --기말상품재고액(07월)
t_ITEM_AMT_08   NUMBER := 0;   --기말상품재고액(08월)
t_ITEM_AMT_09   NUMBER := 0;   --기말상품재고액(09월)
t_ITEM_AMT_10   NUMBER := 0;   --기말상품재고액(10월)
t_ITEM_AMT_11   NUMBER := 0;   --기말상품재고액(11월)
t_ITEM_AMT_12   NUMBER := 0;   --기말상품재고액(12월)

t_PRODUCT_AMT_01   NUMBER := 0;   --기말제품재고액(01월)
t_PRODUCT_AMT_02   NUMBER := 0;   --기말제품재고액(02월)
t_PRODUCT_AMT_03   NUMBER := 0;   --기말제품재고액(03월)
t_PRODUCT_AMT_04   NUMBER := 0;   --기말제품재고액(04월)
t_PRODUCT_AMT_05   NUMBER := 0;   --기말제품재고액(05월)
t_PRODUCT_AMT_06   NUMBER := 0;   --기말제품재고액(06월)
t_PRODUCT_AMT_07   NUMBER := 0;   --기말제품재고액(07월)
t_PRODUCT_AMT_08   NUMBER := 0;   --기말제품재고액(08월)
t_PRODUCT_AMT_09   NUMBER := 0;   --기말제품재고액(09월)
t_PRODUCT_AMT_10   NUMBER := 0;   --기말제품재고액(10월)
t_PRODUCT_AMT_11   NUMBER := 0;   --기말제품재고액(11월)
t_PRODUCT_AMT_12   NUMBER := 0;   --기말제품재고액(12월)


t_ITEM_AMT_12_PRE       NUMBER := 0;   --전기_기말상품재고액(12월)
t_PRODUCT_AMT_12_PRE    NUMBER := 0;   --전기_기말제품재고액(12월)


BEGIN

--1단계>기준자료 설정, 기존 자료 삭제, 기본 틀 형성

    t_FORM_TYPE_ID := 746;   --손익계산서
    
    --제조원가명세서는 양식세트와 무관하게 공통으로 사용하는 것이므로 이를 보정한다.
    IF W_FS_SET_ID = 1674 THEN
        t_FS_SET_ID := W_FS_SET_ID;
    ELSE
        t_FS_SET_ID := 1674;
    END IF;
    


    --본 보고서를 추출하기 위한 작업년도에 해당하는 각 월의 재고자산기말금액 자료를 기본 값인 null로 선행적으로 INSERT해 놓는다.
    FI_CLOSING_ENDING_AMOUNT_G.CREATE_CLOSING_ENDING_AMOUNT(W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR);

        
    --손익계산서에 등록된 최하위레벨을 구한다.
    t_LAST_ITEM_LEVEL := FI_FORM_DET_G.LAST_ITEM_LEVEL_F(W_SOB_ID, W_ORG_ID, W_FS_SET_ID, t_FORM_TYPE_ID);  
    

    BEGIN
        --전기이월된 상품금액을 추출하여 기초상품재고액에 사용한다.
        t_FORWARD_RAW_AMT := 0;
        
        SELECT NVL(SUM(GL_AMOUNT), 0)
        INTO t_FORWARD_RAW_AMT
        FROM FI_SLIP_LINE
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND SLIP_TYPE = 'BLS'   --전표유형 : '기초잔액이월-BLS'
            AND PERIOD_NAME = W_CLOSING_YEAR || '-01'  --'2011-01'
            AND ACCOUNT_CODE IN('1120200', '1120201', '1120202', '1120203')    --1120200 : 상품
        ;              
        
                
        --전기이월된 제품금액을 추출하여 기초제품재고액에 사용한다.
        t_FORWARD_LINE_AMT := 0;
        
        SELECT NVL(SUM(GL_AMOUNT), 0)
        INTO t_FORWARD_LINE_AMT
        FROM FI_SLIP_LINE
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND SLIP_TYPE = 'BLS'   --전표유형 : '기초잔액이월-BLS'
            AND PERIOD_NAME = W_CLOSING_YEAR || '-01'  --'2011-01'
            AND ACCOUNT_CODE = '1120100'    --1120100 : 제품  
        ;
        
        EXCEPTION        
            WHEN OTHERS THEN
               --작업중 오류가 발생하였습니다. 확인바랍니다.
               RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');             
    END;      




    --LIST_IS PROCEDURE와 동일한 것으로 자료구분이 월이 아닌 경우
    --자료구분이 월인 경우 각 월의 기말상품재고액/기말제품재고액을 구해 
    --자료구분이 분기, 반기, 년 인 경우의 기말상품재고액/기말제품재고액을 구하기 위함이다.
    IF W_DATA_GB != 'M' THEN
        LIST_IS_M_OTHER(W_SOB_ID, W_ORG_ID, W_FS_SET_ID, W_CLOSING_YEAR, 'M', 'M01', 'M12');        
        
        SELECT 
              NVL(LAST_LEVEL_AMT_01, 0)
            , NVL(LAST_LEVEL_AMT_02, 0)
            , NVL(LAST_LEVEL_AMT_03, 0)
            , NVL(LAST_LEVEL_AMT_04, 0)
            , NVL(LAST_LEVEL_AMT_05, 0)
            , NVL(LAST_LEVEL_AMT_06, 0)
            , NVL(LAST_LEVEL_AMT_07, 0)
            , NVL(LAST_LEVEL_AMT_08, 0)
            , NVL(LAST_LEVEL_AMT_09, 0)
            , NVL(LAST_LEVEL_AMT_10, 0)
            , NVL(LAST_LEVEL_AMT_11, 0)
            , NVL(LAST_LEVEL_AMT_12, 0)
        INTO
              t_ITEM_AMT_01   --기말상품재고액(01월)
            , t_ITEM_AMT_02   --기말상품재고액(02월)
            , t_ITEM_AMT_03   --기말상품재고액(03월)
            , t_ITEM_AMT_04   --기말상품재고액(04월)
            , t_ITEM_AMT_05   --기말상품재고액(05월)
            , t_ITEM_AMT_06   --기말상품재고액(06월)
            , t_ITEM_AMT_07   --기말상품재고액(07월)
            , t_ITEM_AMT_08   --기말상품재고액(08월)
            , t_ITEM_AMT_09   --기말상품재고액(09월)
            , t_ITEM_AMT_10   --기말상품재고액(10월)
            , t_ITEM_AMT_11   --기말상품재고액(11월)
            , t_ITEM_AMT_12   --기말상품재고액(12월)        
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '5';  


        SELECT 
              NVL(LAST_LEVEL_AMT_01, 0)
            , NVL(LAST_LEVEL_AMT_02, 0)
            , NVL(LAST_LEVEL_AMT_03, 0)
            , NVL(LAST_LEVEL_AMT_04, 0)
            , NVL(LAST_LEVEL_AMT_05, 0)
            , NVL(LAST_LEVEL_AMT_06, 0)
            , NVL(LAST_LEVEL_AMT_07, 0)
            , NVL(LAST_LEVEL_AMT_08, 0)
            , NVL(LAST_LEVEL_AMT_09, 0)
            , NVL(LAST_LEVEL_AMT_10, 0)
            , NVL(LAST_LEVEL_AMT_11, 0)
            , NVL(LAST_LEVEL_AMT_12, 0)
        INTO
              t_PRODUCT_AMT_01   --기말제품재고액(01월)
            , t_PRODUCT_AMT_02   --기말제품재고액(02월)
            , t_PRODUCT_AMT_03   --기말제품재고액(03월)
            , t_PRODUCT_AMT_04   --기말제품재고액(04월)
            , t_PRODUCT_AMT_05   --기말제품재고액(05월)
            , t_PRODUCT_AMT_06   --기말제품재고액(06월)
            , t_PRODUCT_AMT_07   --기말제품재고액(07월)
            , t_PRODUCT_AMT_08   --기말제품재고액(08월)
            , t_PRODUCT_AMT_09   --기말제품재고액(09월)
            , t_PRODUCT_AMT_10   --기말제품재고액(10월)
            , t_PRODUCT_AMT_11   --기말제품재고액(11월)
            , t_PRODUCT_AMT_12   --기말제품재고액(12월)        
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '8';          
    END IF;
    


    --자료구분이 [년]인 경우 전기의 기말상품재고액, 기말제품재고액을 구하기 위함.
    IF W_DATA_GB = 'Y' THEN
        LIST_IS_M_OTHER(W_SOB_ID, W_ORG_ID, W_FS_SET_ID, TO_CHAR(W_CLOSING_YEAR - 1), 'M', 'M01', 'M12');        
        
        SELECT NVL(LAST_LEVEL_AMT_12, 0)
        INTO t_ITEM_AMT_12_PRE   --전기_기말상품재고액(12월)        
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '5';  


        SELECT NVL(LAST_LEVEL_AMT_12, 0)
        INTO t_PRODUCT_AMT_12_PRE   --전기_기말제품재고액(12월)        
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '8';          
    END IF;    





--월설정, 당기일설정, 전기일설정 논리는 제조원가명세서와 손익계산서가 같다.

    --월설정 : 자료구분(M : 월, Q : 분기, H : 반기, Y : 년)별 시작월과 종료월 설정
    IF    W_DATA_GB = 'M' THEN
        t_TERM_START_M  := SUBSTR(W_CLOSING_START, 2, 2);
        t_TERM_END_M    := SUBSTR(W_CLOSING_END, 2, 2);
    ELSIF W_DATA_GB = 'Q' THEN  
        t_TERM_START_M  := SUBSTR(W_CLOSING_START, 2, 2);
        t_TERM_END_M    := SUBSTR(W_CLOSING_END, 2, 2);        
    ELSIF W_DATA_GB = 'H' THEN
        t_TERM_START_M  := SUBSTR(W_CLOSING_START, 2, 2);
        t_TERM_END_M    := SUBSTR(W_CLOSING_END, 2, 2);         
    ELSIF W_DATA_GB = 'Y' THEN   
        t_TERM_START_M  := '01';    --당기
        t_TERM_END_M    := '02';    --전기   
    END IF;        



    --기존 자료를 삭제한다.
    DELETE FI_FS_IS_PARADE;


    --손익계산서를 조회하기 위한 기본틀을 만든다.
    INSERT INTO FI_FS_IS_PARADE(
          ITEM_NAME	            --출력항목명
          
        , LAST_LEVEL_AMT_SUM    --함계_최하위레벨항목금액
        , NON_LAST_AMT_SUM	    --합계_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_01	    --01월_최하위레벨항목금액_1분기, 상반기, 당기
        , NON_LAST_AMT_01	    --01월_최하위아닌레벨항목금액_1분기, 상반기, 당기
        , LAST_LEVEL_AMT_02	    --02월_최하위레벨항목금액_2분기, 하반기, 전기
        , NON_LAST_AMT_02	    --02월_최하위아닌레벨항목금액_2분기, 하반기, 전기
        , LAST_LEVEL_AMT_03	    --03월_최하위레벨항목금액_3분기
        , NON_LAST_AMT_03	    --03월_최하위아닌레벨항목금액_3분기
        , LAST_LEVEL_AMT_04	    --04월_최하위레벨항목금액_4분기
        , NON_LAST_AMT_04	    --04월_최하위아닌레벨항목금액_4분기
        , LAST_LEVEL_AMT_05	    --05월_최하위레벨항목금액
        , NON_LAST_AMT_05	    --05월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_06	    --06월_최하위레벨항목금액
        , NON_LAST_AMT_06	    --06월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_07	    --07월_최하위레벨항목금액
        , NON_LAST_AMT_07	    --07월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_08	    --08월_최하위레벨항목금액
        , NON_LAST_AMT_08	    --08월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_09	    --09월_최하위레벨항목금액
        , NON_LAST_AMT_09	    --09월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_10	    --10월_최하위레벨항목금액
        , NON_LAST_AMT_10	    --10월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_11	    --11월_최하위레벨항목금액
        , NON_LAST_AMT_11	    --11월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_12	    --12월_최하위레벨항목금액
        , NON_LAST_AMT_12	    --12월_최하위아닌레벨항목금액          
        
        , ITEM_CODE	            --항목코드_계정코드
        , ACCOUNT_DR_CR         --차대구분(1-차변,2-대변)
        , SORT_SEQ	            --정렬순서
        , ITEM_LEVEL	        --금액계산레벨
        , ENABLED_FLAG	        --사용(표시)여부
        , FORM_FRAME_YN	        --보고서틀유지여부
        , REF_FORM_TYPE_ID      --관련보고서양식아이디
        , REF_ITEM_CODE         --관련항목코드
    )
    SELECT
          ITEM_NAME     --출력항목명
          
        , NULL  --함계_최하위레벨항목금액
        , NULL	--합계_최하위아닌레벨항목금액
        , NULL	--01월_최하위레벨항목금액_1분기, 상반기, 당기
        , NULL	--01월_최하위아닌레벨항목금액_1분기, 상반기, 당기
        , NULL	--02월_최하위레벨항목금액_2분기, 하반기, 전기
        , NULL	--02월_최하위아닌레벨항목금액_2분기, 하반기, 전기
        , NULL	--03월_최하위레벨항목금액_3분기
        , NULL	--03월_최하위아닌레벨항목금액_3분기
        , NULL	--04월_최하위레벨항목금액_4분기
        , NULL	--04월_최하위아닌레벨항목금액_4분기
        , NULL	--05월_최하위레벨항목금액
        , NULL	--05월_최하위아닌레벨항목금액
        , NULL	--06월_최하위레벨항목금액
        , NULL	--06월_최하위아닌레벨항목금액
        , NULL	--07월_최하위레벨항목금액
        , NULL	--07월_최하위아닌레벨항목금액
        , NULL	--08월_최하위레벨항목금액
        , NULL	--08월_최하위아닌레벨항목금액
        , NULL	--09월_최하위레벨항목금액
        , NULL	--09월_최하위아닌레벨항목금액
        , NULL	--10월_최하위레벨항목금액
        , NULL	--10월_최하위아닌레벨항목금액
        , NULL	--11월_최하위레벨항목금액
        , NULL	--11월_최하위아닌레벨항목금액
        , NULL	--12월_최하위레벨항목금액
        , NULL	--12월_최하위아닌레벨항목금액      
        
        , ITEM_CODE     --항목코드_계정코드 
        , ACCOUNT_DR_CR --차대구분(1-차변,2-대변)
        , SORT_SEQ      --정렬순서
        , ITEM_LEVEL    --금액계산레벨
        
        --N인 자료는 금액계산 시에는 사용되지만, 보고서에 보여서는 안될 항목이다.
        --즉, N인 자료는 금액계산이 레벨에 의해 이뤄지는 체계를 유지하기 위해 임으로 가져가는 항목일 뿐이다.
        , ENABLED_FLAG      --사용(표시)여부
        
        --금액의 유무를 떠나서 아래 항목이 'Y'인 항목은 보고서의 틀을 유지하기 위해 무조건 출력되어야 할 항목이다.
        , FORM_FRAME_YN	        --보고서틀유지여부
        , REF_FORM_TYPE_ID      --관련보고서양식아이디
        , REF_ITEM_CODE         --관련항목코드        
    FROM FI_FORM_MST                        --재무제표보고서양식_마스터
    WHERE SOB_ID = W_SOB_ID                 --회사아이디
        AND ORG_ID = W_ORG_ID               --사업부아이디
        AND FS_SET_ID = W_FS_SET_ID         --보고서기준세트아이디
        AND FORM_TYPE_ID = t_FORM_TYPE_ID   --보고서양식ID(공통코드)
    ORDER BY SORT_SEQ    
    ;



--2단계>최하위레벨의 금액을 구한다.
--조회 시작월의 기초상품재고액을 추출하기 위해서 아래 논리를 실행한다.
    IF W_DATA_GB = 'M' AND t_TERM_START_M <> '01' THEN                
    
        FOR REPEAT_MATERIAL IN 1..(t_TERM_START_M - 1) LOOP

            t_REPEAT := LPAD(REPEAT_MATERIAL, 2, 0);

            --당기일설정 : 당기의 시작일과 종료일 설정
            t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || t_REPEAT, 'YYYY-MM');     --당기시작일
            t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || t_REPEAT, 'YYYY-MM'));    --당기종료일 


            --기간내의 해당 계정의 금액을 분개자료에서 구한다. 
            FI_FS_SLIP_G.CREATE_FS_SLIP(
                  W_SOB_ID
                , W_ORG_ID
                , W_FS_SET_ID
                , t_FORM_TYPE_ID
                , t_LAST_ITEM_LEVEL
                , t_PERIOD_FROM
                , t_PERIOD_TO   );


            --대상항목명 : 당기상품매입액(4)
            SELECT          
                  ITEM_CODE	    --항목코드
                , ACCOUNT_DR_CR	--차대구분(1-차변,2-대변)
            INTO t_ITEM_CODE, t_ACCOUNT_DR_CR
            FROM FI_FS_IS_PARADE
            WHERE ITEM_LEVEL = t_LAST_ITEM_LEVEL AND ITEM_CODE = '4'    ;
            
            --변수 초기화
            t_THIS_LAST_LEVEL_AMT       := 0;   --당기_최하위레벨항목금액

            IF t_ACCOUNT_DR_CR = '1' THEN      --해당 계정이 차변계정이면
                SELECT SUM(DR_AMT) - SUM(CR_AMT) AS AMT
                INTO t_THIS_LAST_LEVEL_AMT
                FROM FI_FS_SLIP
                WHERE ITEM_CODE = t_ITEM_CODE
                GROUP BY ITEM_CODE;
            ELSIF t_ACCOUNT_DR_CR = '2' THEN   --해당 계정이 대변계정이면
                SELECT SUM(CR_AMT) - SUM(DR_AMT) AS AMT
                INTO t_THIS_LAST_LEVEL_AMT
                FROM FI_FS_SLIP
                WHERE ITEM_CODE = t_ITEM_CODE
                GROUP BY ITEM_CODE;                
            END IF; 

            --해당 칼럼에 값을 UPDATE한다.
            UPDATE_AMT(t_REPEAT, t_THIS_LAST_LEVEL_AMT, t_ITEM_CODE );

        END LOOP REPEAT_MATERIAL;     
    END IF;




--2단계>최하위레벨의 금액을 구한다.
--단, 기초상품재고액(3), 기말상품재고액(5), 기초제품재고액(6), 당기제품제조원가(7), 기말제품재고액(8)의 5개 항목은
--금액계산레벨을 무시하고 상세항목을 이용해서 금액을 추출하지 않는다.

--최하위레벨의 금액은 상세 계정의 합이다. 하여, 굳이 재무제표양식의 연산부호를 참조하지 않는다.
--만약, 최하위레벨 항목의 상세 항목에 대해 재무제표양식의 연산부호가 [+]가 아닌 게 있을 경우는 이를 수정해야 한다.

    --아래 IF 문[IF W_DATA_GB IS NOT NULL THEN]은 사실 무의미한데 현재의 개발 FRAMEWORK에서 
    --이 부분FOR REPEAT IN t_TERM_START_M..t_TERM_END_M LOOP]의 반영에 있어 오류가 있어 불필요하게 추가한 것이다.
    IF W_DATA_GB IS NOT NULL THEN
        FOR REPEAT IN t_TERM_START_M..t_TERM_END_M LOOP

            t_REPEAT := LPAD(REPEAT, 2, 0);
            
            
            --당기일설정 : 당기의 시작일과 종료일 설정
            IF    W_DATA_GB = 'M' THEN
                t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || t_REPEAT, 'YYYY-MM');
                t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || t_REPEAT, 'YYYY-MM'));
            ELSIF W_DATA_GB = 'Q' THEN
                IF    t_REPEAT = '01' THEN
                    t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || '01', 'YYYY-MM');
                    t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || '03', 'YYYY-MM'));
                ELSIF t_REPEAT = '02' THEN
                    t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || '04', 'YYYY-MM');
                    t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || '06', 'YYYY-MM'));
                ELSIF t_REPEAT = '03' THEN
                    t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || '07', 'YYYY-MM');
                    t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || '09', 'YYYY-MM'));
                ELSIF t_REPEAT = '04' THEN
                    t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || '10', 'YYYY-MM');
                    t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || '12', 'YYYY-MM'));
                END IF;
            ELSIF W_DATA_GB = 'H' THEN
                IF    t_REPEAT = '01' THEN
                    t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || '01', 'YYYY-MM');
                    t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || '06', 'YYYY-MM'));
                ELSIF t_REPEAT = '02' THEN
                    t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || '07', 'YYYY-MM');
                    t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || '12', 'YYYY-MM'));
                END IF;
            ELSIF W_DATA_GB = 'Y' THEN
                IF    t_REPEAT = '01' THEN
                    --t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || '01', 'YYYY-MM');
                    --t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || '12', 'YYYY-MM'));
                    
                    t_PERIOD_FROM   := TO_DATE(         W_CLOSING_START, 'YYYY-MM');
                    t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_END, 'YYYY-MM'));                     
                ELSIF t_REPEAT = '02' THEN
                    t_PERIOD_FROM   := TO_DATE(         (W_CLOSING_YEAR - 1) || '01', 'YYYY-MM');
                    t_PERIOD_TO     := LAST_DAY(TO_DATE((W_CLOSING_YEAR - 1) || '12', 'YYYY-MM'));
                END IF;        
            END IF;



            --기간내의 해당 계정의 금액을 분개자료에서 구한다. 
            FI_FS_SLIP_G.CREATE_FS_SLIP(
                  W_SOB_ID
                , W_ORG_ID
                , W_FS_SET_ID
                , t_FORM_TYPE_ID
                , t_LAST_ITEM_LEVEL
                , t_PERIOD_FROM
                , t_PERIOD_TO   );


            --3 : 기초상품재고액, 5 : 기말상품재고액, 
            --6 : 기초제품재고액, 7 : 당기제품제조원가, 8 : 기말제품재고액
            FOR LAST_LEVEL_REC IN (
                SELECT          
                      ITEM_CODE	    --항목코드
                    , ACCOUNT_DR_CR	--차대구분(1-차변,2-대변)
                FROM FI_FS_IS_PARADE
                WHERE ITEM_LEVEL = t_LAST_ITEM_LEVEL
                    AND (ITEM_CODE NOT IN ('3', '5', '6', '7', '8') )
            ) LOOP
        
                --DBMS_OUTPUT.PUT_LINE('항목코드 : ' || LAST_LEVEL_REC.ITEM_CODE);        
                
                t_THIS_LAST_LEVEL_AMT       := 0;   --당기_최하위레벨항목금액

                IF LAST_LEVEL_REC.ACCOUNT_DR_CR = '1' THEN      --해당 계정이 차변계정이면
                    BEGIN
                      SELECT SUM(DR_AMT) - SUM(CR_AMT) AS AMT
                      INTO t_THIS_LAST_LEVEL_AMT
                      FROM FI_FS_SLIP
                      WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
                      GROUP BY ITEM_CODE;
                    EXCEPTION WHEN OTHERS THEN
                      t_THIS_LAST_LEVEL_AMT := 0;
                    END;
                ELSIF LAST_LEVEL_REC.ACCOUNT_DR_CR = '2' THEN   --해당 계정이 대변계정이면
                    BEGIN
                      SELECT SUM(CR_AMT) - SUM(DR_AMT) AS AMT
                      INTO t_THIS_LAST_LEVEL_AMT
                      FROM FI_FS_SLIP
                      WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
                      GROUP BY ITEM_CODE;  
                    EXCEPTION WHEN OTHERS THEN
                      t_THIS_LAST_LEVEL_AMT := 0;
                    END;              
                END IF;              


                --해당 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_THIS_LAST_LEVEL_AMT, LAST_LEVEL_REC.ITEM_CODE );
                
            END LOOP LAST_LEVEL_REC;      

        END LOOP REPEAT; 
        
    END IF;






--2단계>기초상품재고액(3), 기말상품재고액(5), 기초제품재고액(6), 기말제품재고액(8), 당기제품제조원가(7)의 항목 금액 추출
--위 항목의 ()안에 들어있는 값은 해당 항목들에 대한 재무제표양식관리에 설정된 항목코드이다.

--아래 FOR문은 라인수만 길 뿐이지 내용은 간단하고 반복적이다. 기간별 칼럼이 틀려서 라인이 길 뿐이다.

    IF    W_DATA_GB = 'M' THEN
    
        --각월의 당기제품제조원가(9)를 추출하기 위해 제조원가명세서를 실행한다.
        FI_FS_FACTORY_COST_PARADE_G.LIST_FACTORY_COST(
              IS_TCURSOR
            , W_SOB_ID
            , W_ORG_ID
            , t_FS_SET_ID
            , W_CLOSING_YEAR
            , W_DATA_GB
            , W_CLOSING_START
            , W_CLOSING_END  );



        FOR REPEAT_INVENTORY IN 01..t_TERM_END_M LOOP

            t_REPEAT := LPAD(REPEAT_INVENTORY, 2, 0);

            IF t_REPEAT = '01' THEN               
                
                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_FORWARD_RAW_AMT, '3' );

                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');                    
            

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_FORWARD_RAW_AMT;    --당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_FORWARD_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.
                
                SELECT NVL(NON_LAST_AMT_01, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  
                
                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_FORWARD_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;                
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- 다음 월의 기초제품재고액에 이용하기 위함.
            
            ELSIF t_REPEAT = '02' THEN
                --2월 ~ 12월 까지의 기초/기말 상품금액 설정논리는 모두 같다.
                                       
                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );

                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.
                
                SELECT NVL(NON_LAST_AMT_02, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );

                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- 다음 월의 기초제품재고액에 이용하기 위함.
                
            ELSIF t_REPEAT = '03' THEN 
            
                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.
                


                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_03, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  

                --기말제품재고액(8) 칼럼에 값을 UPDATE한다.
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;                    
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- 다음 월의 기초제품재고액에 이용하기 위함.   

            ELSIF t_REPEAT = '04' THEN

                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );

                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_04, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  
                
                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --다음 월의 기초제품재고액에 이용하기 위함.                

            ELSIF t_REPEAT = '05' THEN

                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_05, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );   
                
                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --다음 월의 기초제품재고액에 이용하기 위함.                  

            ELSIF t_REPEAT = '06' THEN
            
                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.
                


                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_06, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  

                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --다음 월의 기초제품재고액에 이용하기 위함.  

            ELSIF t_REPEAT = '07' THEN

                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_07, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' ); 
                
                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --다음 월의 기초제품재고액에 이용하기 위함.                  
                
            ELSIF t_REPEAT = '08' THEN

                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_08, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );     

                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --다음 월의 기초제품재고액에 이용하기 위함.  

            ELSIF t_REPEAT = '09' THEN
            
                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_09, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );   

                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --다음 월의 기초제품재고액에 이용하기 위함.  

            ELSIF t_REPEAT = '10' THEN

                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)


                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_10, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  

                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --다음 월의 기초제품재고액에 이용하기 위함.  

            ELSIF t_REPEAT = '11' THEN

                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.


                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)
                

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_11, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );               


                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL; 
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --다음 월의 기초제품재고액에 이용하기 위함.                                                                    

            ELSIF t_REPEAT = '12' THEN
            
                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)
                
                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_12, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );                  


                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                --t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --다음 월의 기초제품재고액에 이용하기 위함.  

            END IF;

        END LOOP REPEAT_INVENTORY;


    ELSIF W_DATA_GB = 'Q' THEN
        
        --각 분기의 당기제품제조원가(9)를 추출하기 위해 제조원가명세서를 실행한다.
        FI_FS_FACTORY_COST_PARADE_G.LIST_FACTORY_COST(
              IS_TCURSOR
            , W_SOB_ID
            , W_ORG_ID
            , t_FS_SET_ID
            , W_CLOSING_YEAR
            , W_DATA_GB
            , W_CLOSING_START
            , W_CLOSING_END  );               

        FOR REPEAT_INVENTORY IN 01..t_TERM_END_M LOOP

            t_REPEAT := LPAD(REPEAT_INVENTORY, 2, 0);

            IF    t_REPEAT = '01' THEN --1/4분기
                           
                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_FORWARD_RAW_AMT, '3' );


                --기말상품재고액(5)
                t_TERM_END_AMT := t_ITEM_AMT_03;   --기말상품재고액(03월)


                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 분기의 기초상품재고액에 이용하기 위함.


                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_FORWARD_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_01, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' ); 

                --기말제품재고액(8)을 구한다.
                t_TERM_END_AMT := t_PRODUCT_AMT_03;   --기말제품재고액(03월)
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- 다음 분기의 기초제품재고액에 이용하기 위함.  
                
            ELSIF t_REPEAT = '02' THEN --2/4분기
                           
                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_AMT := t_ITEM_AMT_06;   --기말상품재고액(06월)

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 분기의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_02, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' ); 

                --기말제품재고액(8)을 구한다.
                t_TERM_END_AMT := t_PRODUCT_AMT_06;   --기말제품재고액(06월)

                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- 다음 분기의 기초제품재고액에 이용하기 위함. 
                            
            ELSIF t_REPEAT = '03' THEN --3/4분기
                           
                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_AMT := t_ITEM_AMT_09;   --기말상품재고액(09월)

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 분기의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)


                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_03, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );     

                --기말제품재고액(8)을 구한다.
                t_TERM_END_AMT := t_PRODUCT_AMT_09;   --기말제품재고액(09월)

                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- 다음 분기의 기초제품재고액에 이용하기 위함. 
                
            ELSIF t_REPEAT = '04' THEN --4/4분기
                           
                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );

                --기말상품재고액(5)
                t_TERM_END_AMT := t_ITEM_AMT_12;   --기말상품재고액(12월)

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_04, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' ); 

                --기말제품재고액(8)을 구한다.
                t_TERM_END_AMT := t_PRODUCT_AMT_12;   --기말제품재고액(12월)

                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
            
            END IF;

        END LOOP REPEAT_INVENTORY;

    ELSIF W_DATA_GB = 'H' THEN
    
        --각 반기의 당기제품제조원가(9)를 추출하기 위해 제조원가명세서를 실행한다.
        FI_FS_FACTORY_COST_PARADE_G.LIST_FACTORY_COST(
              IS_TCURSOR
            , W_SOB_ID
            , W_ORG_ID
            , t_FS_SET_ID
            , W_CLOSING_YEAR
            , W_DATA_GB
            , W_CLOSING_START
            , W_CLOSING_END  );                

        FOR REPEAT_INVENTORY IN 01..t_TERM_END_M LOOP

            t_REPEAT := LPAD(REPEAT_INVENTORY, 2, 0);

            IF    t_REPEAT = '01' THEN --상반기
                                       
                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_FORWARD_RAW_AMT, '3' );


                --기말상품재고액(5)
                t_TERM_END_AMT := t_ITEM_AMT_06;   --기말상품재고액(06월)

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 반기의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_FORWARD_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_01, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' ); 

                --기말제품재고액(8)을 구한다.
                t_TERM_END_AMT := t_PRODUCT_AMT_06;   --기말제품재고액(06월)

                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- 다음 반기의 기초제품재고액에 이용하기 위함. 
                           
            ELSIF t_REPEAT = '02' THEN --하반기
                                       
                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_AMT := t_ITEM_AMT_12;   --기말상품재고액(12월)

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_02, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' ); 

                --기말제품재고액(8)을 구한다.
                t_TERM_END_AMT := t_PRODUCT_AMT_12;   --기말제품재고액(12월)

                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
           
            END IF;
    
        END LOOP REPEAT_INVENTORY;    


    ELSIF W_DATA_GB = 'Y' THEN
    
        --년의 당기제품제조원가(9)를 추출하기 위해 제조원가명세서를 실행한다.
        FI_FS_FACTORY_COST_PARADE_G.LIST_FACTORY_COST(
              IS_TCURSOR
            , W_SOB_ID
            , W_ORG_ID
            , t_FS_SET_ID
            , W_CLOSING_YEAR
            , W_DATA_GB
            , W_CLOSING_START
            , W_CLOSING_END  );               


    --당기                  
        
        --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
        UPDATE_AMT('01', t_FORWARD_RAW_AMT, '3' );        


        --기말상품재고액(5) 
        --t_TERM_END_AMT := t_ITEM_AMT_12;   --기말상품재고액(12월)
                
        t_WORK_MM := LPAD(SUBSTR(W_CLOSING_END, 6, 2), 2, 0);
        
        IF t_WORK_MM = '01' THEN
            t_TERM_END_AMT := t_ITEM_AMT_01;
        ELSIF t_WORK_MM = '02' THEN
            t_TERM_END_AMT := t_ITEM_AMT_02;            
        ELSIF t_WORK_MM = '03' THEN
            t_TERM_END_AMT := t_ITEM_AMT_03;
        ELSIF t_WORK_MM = '04' THEN
            t_TERM_END_AMT := t_ITEM_AMT_04;
        ELSIF t_WORK_MM = '05' THEN
            t_TERM_END_AMT := t_ITEM_AMT_05;
        ELSIF t_WORK_MM = '06' THEN
            t_TERM_END_AMT := t_ITEM_AMT_06;
        ELSIF t_WORK_MM = '07' THEN
            t_TERM_END_AMT := t_ITEM_AMT_07;
        ELSIF t_WORK_MM = '08' THEN
            t_TERM_END_AMT := t_ITEM_AMT_08;
        ELSIF t_WORK_MM = '09' THEN
            t_TERM_END_AMT := t_ITEM_AMT_09;
        ELSIF t_WORK_MM = '10' THEN
            t_TERM_END_AMT := t_ITEM_AMT_10;
        ELSIF t_WORK_MM = '11' THEN
            t_TERM_END_AMT := t_ITEM_AMT_11;
        ELSIF t_WORK_MM = '12' THEN
            t_TERM_END_AMT := t_ITEM_AMT_12;            
        END IF;        
        
        

        --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
        UPDATE_AMT('01', t_TERM_END_AMT, '5' );




        --기초제품재고액(6) 값을 UPDATE한다.
        UPDATE_AMT('01', t_FORWARD_LINE_AMT, '6' );

        --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.
        SELECT NVL(NON_LAST_AMT_01, 0)
        INTO t_ITEM_COST
        FROM FI_FS_FACTORY_COST_PARADE
        WHERE ITEM_CODE = '9';  --당기제품제조원가
            
        UPDATE_AMT('01', t_ITEM_COST, '7' ); 


        --기말제품재고액(8)을 구한다.
        --t_TERM_END_LINE_AMT := t_PRODUCT_AMT_12;   --기말제품재고액(12월)       
        
        IF t_WORK_MM = '01' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_01;
        ELSIF t_WORK_MM = '02' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_02;
        ELSIF t_WORK_MM = '03' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_03;
        ELSIF t_WORK_MM = '04' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_04;
        ELSIF t_WORK_MM = '05' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_05;
        ELSIF t_WORK_MM = '06' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_06;
        ELSIF t_WORK_MM = '07' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_07;
        ELSIF t_WORK_MM = '08' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_08;
        ELSIF t_WORK_MM = '09' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_09;
        ELSIF t_WORK_MM = '10' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_10;
        ELSIF t_WORK_MM = '11' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_11;
        ELSIF t_WORK_MM = '12' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_12;
        END IF;         
        

        UPDATE_AMT('01', t_TERM_END_LINE_AMT, '8' );    --기말제품재고액(8)



    --전기
    
        --주의>전기의 경우는 년에 관련된 부분이 모두 [(W_CLOSING_YEAR - 1)] 이다.

        --전기이월된 상품금액을 추출하여 기초상품재고액에 사용한다.
        t_INVENTORY_AMOUNT := 0;
                
        SELECT NVL(SUM(GL_AMOUNT), 0)
        INTO t_INVENTORY_AMOUNT
        FROM FI_SLIP_LINE
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND SLIP_TYPE = 'BLS'   --전표유형 : '기초잔액이월-BLS'
            AND PERIOD_NAME = (W_CLOSING_YEAR - 1) || '-01'  --'2010-01'
            AND ACCOUNT_CODE IN('1120200', '1120201', '1120202', '1120203')    --1120200 : 상품
        ;
        
        --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
        UPDATE_AMT('02', t_INVENTORY_AMOUNT, '3' );                  


        --기말상품재고액(5)
        t_TERM_END_AMT := t_ITEM_AMT_12_PRE;   --전기_기말상품재고액(12월)
        
        --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
        UPDATE_AMT('02', t_TERM_END_AMT, '5' );
        



        --전기이월된 제품금액을 추출하여 기초제품재고액에 사용한다.
        t_INVENTORY_AMOUNT := 0;
         
        SELECT NVL(SUM(GL_AMOUNT), 0)
        INTO t_INVENTORY_AMOUNT
        FROM FI_SLIP_LINE
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND SLIP_TYPE = 'BLS'   --전표유형 : '기초잔액이월-BLS'
            AND PERIOD_NAME = (W_CLOSING_YEAR - 1) || '-01'  --'2010-01'
            AND ACCOUNT_CODE = '1120100'    --1120100 : 제품  
        ;
                
        --기초제품재고액(6) 값을 UPDATE한다.
        UPDATE_AMT('02', t_INVENTORY_AMOUNT, '6' );        
        
        --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.
        SELECT NVL(NON_LAST_AMT_02, 0)
        INTO t_ITEM_COST
        FROM FI_FS_FACTORY_COST_PARADE
        WHERE ITEM_CODE = '9';  --당기제품제조원가
            
        UPDATE_AMT('02', t_ITEM_COST, '7' ); 

        --기말제품재고액(8)을 구한다.        
        t_TERM_END_LINE_AMT := t_PRODUCT_AMT_12_PRE;   --전기_기말제품재고액(12월)

        UPDATE_AMT('02', t_TERM_END_LINE_AMT, '8' );
        
    END IF;









--여기부터는 만들어진 자료를 바탕으로 화면에 보여주기 위한 자료를 보정하는 절차이다.




--조회시작월이 1월이 아닌 경우 1월 부터 조회시작월 전월까지의 자료를 지운다.
--CLEAR 대상 항목 : 기초상품재고액(3), 당기상품매입액(4),기말상품재고액(5), 
--                  기초제품재고액(6), 당기제품제조원가(7), 기말제품재고액(8), 
    IF W_DATA_GB = 'M' THEN
        IF t_TERM_START_M = '01' THEN
            NULL;
        ELSE
            IF t_TERM_START_M = '02' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '03' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '04' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                    , LAST_LEVEL_AMT_03 = NULL
                    , NON_LAST_AMT_03   = NULL            
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '05' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                    , LAST_LEVEL_AMT_03 = NULL
                    , NON_LAST_AMT_03   = NULL  
                    , LAST_LEVEL_AMT_04 = NULL
                    , NON_LAST_AMT_04   = NULL              
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '06' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                    , LAST_LEVEL_AMT_03 = NULL
                    , NON_LAST_AMT_03   = NULL  
                    , LAST_LEVEL_AMT_04 = NULL
                    , NON_LAST_AMT_04   = NULL
                    , LAST_LEVEL_AMT_05 = NULL
                    , NON_LAST_AMT_05   = NULL            
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '07' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                    , LAST_LEVEL_AMT_03 = NULL
                    , NON_LAST_AMT_03   = NULL  
                    , LAST_LEVEL_AMT_04 = NULL
                    , NON_LAST_AMT_04   = NULL
                    , LAST_LEVEL_AMT_05 = NULL
                    , NON_LAST_AMT_05   = NULL
                    , LAST_LEVEL_AMT_06 = NULL
                    , NON_LAST_AMT_06   = NULL            
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '08' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                    , LAST_LEVEL_AMT_03 = NULL
                    , NON_LAST_AMT_03   = NULL  
                    , LAST_LEVEL_AMT_04 = NULL
                    , NON_LAST_AMT_04   = NULL
                    , LAST_LEVEL_AMT_05 = NULL
                    , NON_LAST_AMT_05   = NULL
                    , LAST_LEVEL_AMT_06 = NULL
                    , NON_LAST_AMT_06   = NULL 
                    , LAST_LEVEL_AMT_07 = NULL
                    , NON_LAST_AMT_07   = NULL             
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '09' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                    , LAST_LEVEL_AMT_03 = NULL
                    , NON_LAST_AMT_03   = NULL  
                    , LAST_LEVEL_AMT_04 = NULL
                    , NON_LAST_AMT_04   = NULL
                    , LAST_LEVEL_AMT_05 = NULL
                    , NON_LAST_AMT_05   = NULL
                    , LAST_LEVEL_AMT_06 = NULL
                    , NON_LAST_AMT_06   = NULL 
                    , LAST_LEVEL_AMT_07 = NULL
                    , NON_LAST_AMT_07   = NULL
                    , LAST_LEVEL_AMT_08 = NULL
                    , NON_LAST_AMT_08   = NULL            
               WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '10' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                    , LAST_LEVEL_AMT_03 = NULL
                    , NON_LAST_AMT_03   = NULL  
                    , LAST_LEVEL_AMT_04 = NULL
                    , NON_LAST_AMT_04   = NULL
                    , LAST_LEVEL_AMT_05 = NULL
                    , NON_LAST_AMT_05   = NULL
                    , LAST_LEVEL_AMT_06 = NULL
                    , NON_LAST_AMT_06   = NULL 
                    , LAST_LEVEL_AMT_07 = NULL
                    , NON_LAST_AMT_07   = NULL
                    , LAST_LEVEL_AMT_08 = NULL
                    , NON_LAST_AMT_08   = NULL 
                    , LAST_LEVEL_AMT_09 = NULL
                    , NON_LAST_AMT_09   = NULL             
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '11' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                    , LAST_LEVEL_AMT_03 = NULL
                    , NON_LAST_AMT_03   = NULL  
                    , LAST_LEVEL_AMT_04 = NULL
                    , NON_LAST_AMT_04   = NULL
                    , LAST_LEVEL_AMT_05 = NULL
                    , NON_LAST_AMT_05   = NULL
                    , LAST_LEVEL_AMT_06 = NULL
                    , NON_LAST_AMT_06   = NULL 
                    , LAST_LEVEL_AMT_07 = NULL
                    , NON_LAST_AMT_07   = NULL
                    , LAST_LEVEL_AMT_08 = NULL
                    , NON_LAST_AMT_08   = NULL 
                    , LAST_LEVEL_AMT_09 = NULL
                    , NON_LAST_AMT_09   = NULL
                    , LAST_LEVEL_AMT_10 = NULL
                    , NON_LAST_AMT_10   = NULL            
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '12' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                    , LAST_LEVEL_AMT_03 = NULL
                    , NON_LAST_AMT_03   = NULL  
                    , LAST_LEVEL_AMT_04 = NULL
                    , NON_LAST_AMT_04   = NULL
                    , LAST_LEVEL_AMT_05 = NULL
                    , NON_LAST_AMT_05   = NULL
                    , LAST_LEVEL_AMT_06 = NULL
                    , NON_LAST_AMT_06   = NULL 
                    , LAST_LEVEL_AMT_07 = NULL
                    , NON_LAST_AMT_07   = NULL
                    , LAST_LEVEL_AMT_08 = NULL
                    , NON_LAST_AMT_08   = NULL 
                    , LAST_LEVEL_AMT_09 = NULL
                    , NON_LAST_AMT_09   = NULL
                    , LAST_LEVEL_AMT_10 = NULL
                    , NON_LAST_AMT_10   = NULL 
                    , LAST_LEVEL_AMT_11 = NULL
                    , NON_LAST_AMT_11   = NULL             
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            END IF;
        END IF;
    END IF;





--4단계>최하위레벨이 아닌 항목들에 대한 금액을 구한다.
--금액계산레벨이 큰 것 부터 순차적으로 금액을 구한다. 예>2레벨 부터 1레벨 까지
    FOR NO_LAST_REC IN (
        SELECT ITEM_CODE    --항목코드
        FROM FI_FS_IS_PARADE
        WHERE ITEM_LEVEL < t_LAST_ITEM_LEVEL
        ORDER BY ITEM_LEVEL DESC
    ) LOOP

        --변수 초기화
        t_LAST_LEVEL_AMT_01         := 0;   --01월_최하위레벨항목금액
        t_LAST_LEVEL_AMT_01_CALC    := 0;   --01월_최하위레벨항목금액 집계를 위한 변수
        t_LAST_LEVEL_AMT_02         := 0;   --02월_최하위레벨항목금액
        t_LAST_LEVEL_AMT_02_CALC    := 0;   --02월_최하위레벨항목금액 집계를 위한 변수
        t_LAST_LEVEL_AMT_03         := 0;   --03월_최하위레벨항목금액
        t_LAST_LEVEL_AMT_03_CALC    := 0;   --03월_최하위레벨항목금액 집계를 위한 변수        
        t_LAST_LEVEL_AMT_04         := 0;   --04월_최하위레벨항목금액
        t_LAST_LEVEL_AMT_04_CALC    := 0;   --04월_최하위레벨항목금액 집계를 위한 변수
        t_LAST_LEVEL_AMT_05         := 0;   --05월_최하위레벨항목금액
        t_LAST_LEVEL_AMT_05_CALC    := 0;   --05월_최하위레벨항목금액 집계를 위한 변수
        t_LAST_LEVEL_AMT_06         := 0;   --06월_최하위레벨항목금액
        t_LAST_LEVEL_AMT_06_CALC    := 0;   --06월_최하위레벨항목금액 집계를 위한 변수 
        t_LAST_LEVEL_AMT_07         := 0;   --07월_최하위레벨항목금액
        t_LAST_LEVEL_AMT_07_CALC    := 0;   --07월_최하위레벨항목금액 집계를 위한 변수
        t_LAST_LEVEL_AMT_08         := 0;   --08월_최하위레벨항목금액
        t_LAST_LEVEL_AMT_08_CALC    := 0;   --08월_최하위레벨항목금액 집계를 위한 변수
        t_LAST_LEVEL_AMT_09         := 0;   --09월_최하위레벨항목금액
        t_LAST_LEVEL_AMT_09_CALC    := 0;   --09월_최하위레벨항목금액 집계를 위한 변수 
        t_LAST_LEVEL_AMT_10         := 0;   --10월_최하위레벨항목금액
        t_LAST_LEVEL_AMT_10_CALC    := 0;   --10월_최하위레벨항목금액 집계를 위한 변수
        t_LAST_LEVEL_AMT_11         := 0;   --11월_최하위레벨항목금액
        t_LAST_LEVEL_AMT_11_CALC    := 0;   --11월_최하위레벨항목금액 집계를 위한 변수
        t_LAST_LEVEL_AMT_12         := 0;   --12월_최하위레벨항목금액
        t_LAST_LEVEL_AMT_12_CALC    := 0;   --12월_최하위레벨항목금액 집계를 위한 변수         
        

        FOR CALC_REC IN (
            SELECT 
                  DET_ITEM_CODE     --상세항목코드
                , DECODE(ITEM_SIGN_SHOW, '+', 1, -1) AS ITEM_SIGN_SHOW     --연산부호(+/-) 
            FROM FI_FORM_DET
            WHERE SOB_ID = W_SOB_ID         --회사아이디
                AND ORG_ID = W_ORG_ID       --사업부아이디
                AND FS_SET_ID = W_FS_SET_ID --보고서기준세트아이디
                AND FORM_TYPE_ID = t_FORM_TYPE_ID      --보고서양식ID(공통코드)
                AND ITEM_CODE = NO_LAST_REC.ITEM_CODE
        ) LOOP
        
            SELECT NVL(LAST_LEVEL_AMT_01, 0)
                ,  NVL(LAST_LEVEL_AMT_02, 0)
                ,  NVL(LAST_LEVEL_AMT_03, 0)
                ,  NVL(LAST_LEVEL_AMT_04, 0)
                ,  NVL(LAST_LEVEL_AMT_05, 0)
                ,  NVL(LAST_LEVEL_AMT_06, 0)
                ,  NVL(LAST_LEVEL_AMT_07, 0)
                ,  NVL(LAST_LEVEL_AMT_08, 0)
                ,  NVL(LAST_LEVEL_AMT_09, 0)
                ,  NVL(LAST_LEVEL_AMT_10, 0)
                ,  NVL(LAST_LEVEL_AMT_11, 0)
                ,  NVL(LAST_LEVEL_AMT_12, 0)                
            INTO  t_LAST_LEVEL_AMT_01_CALC 
                , t_LAST_LEVEL_AMT_02_CALC 
                , t_LAST_LEVEL_AMT_03_CALC 
                , t_LAST_LEVEL_AMT_04_CALC 
                , t_LAST_LEVEL_AMT_05_CALC 
                , t_LAST_LEVEL_AMT_06_CALC 
                , t_LAST_LEVEL_AMT_07_CALC 
                , t_LAST_LEVEL_AMT_08_CALC 
                , t_LAST_LEVEL_AMT_09_CALC 
                , t_LAST_LEVEL_AMT_10_CALC 
                , t_LAST_LEVEL_AMT_11_CALC 
                , t_LAST_LEVEL_AMT_12_CALC 
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = CALC_REC.DET_ITEM_CODE
            ;
            
            t_LAST_LEVEL_AMT_01 := t_LAST_LEVEL_AMT_01 + (t_LAST_LEVEL_AMT_01_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_02 := t_LAST_LEVEL_AMT_02 + (t_LAST_LEVEL_AMT_02_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_03 := t_LAST_LEVEL_AMT_03 + (t_LAST_LEVEL_AMT_03_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_04 := t_LAST_LEVEL_AMT_04 + (t_LAST_LEVEL_AMT_04_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_05 := t_LAST_LEVEL_AMT_05 + (t_LAST_LEVEL_AMT_05_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_06 := t_LAST_LEVEL_AMT_06 + (t_LAST_LEVEL_AMT_06_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_07 := t_LAST_LEVEL_AMT_07 + (t_LAST_LEVEL_AMT_07_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_08 := t_LAST_LEVEL_AMT_08 + (t_LAST_LEVEL_AMT_08_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_09 := t_LAST_LEVEL_AMT_09 + (t_LAST_LEVEL_AMT_09_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_10 := t_LAST_LEVEL_AMT_10 + (t_LAST_LEVEL_AMT_10_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_11 := t_LAST_LEVEL_AMT_11 + (t_LAST_LEVEL_AMT_11_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_12 := t_LAST_LEVEL_AMT_12 + (t_LAST_LEVEL_AMT_12_CALC * CALC_REC.ITEM_SIGN_SHOW);

        END LOOP CALC_REC; 
        
        
        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_01 = t_LAST_LEVEL_AMT_01
            , LAST_LEVEL_AMT_02 = t_LAST_LEVEL_AMT_02
            , LAST_LEVEL_AMT_03 = t_LAST_LEVEL_AMT_03
            , LAST_LEVEL_AMT_04 = t_LAST_LEVEL_AMT_04
            , LAST_LEVEL_AMT_05 = t_LAST_LEVEL_AMT_05
            , LAST_LEVEL_AMT_06 = t_LAST_LEVEL_AMT_06
            , LAST_LEVEL_AMT_07 = t_LAST_LEVEL_AMT_07
            , LAST_LEVEL_AMT_08 = t_LAST_LEVEL_AMT_08
            , LAST_LEVEL_AMT_09 = t_LAST_LEVEL_AMT_09
            , LAST_LEVEL_AMT_10 = t_LAST_LEVEL_AMT_10
            , LAST_LEVEL_AMT_11 = t_LAST_LEVEL_AMT_11
            , LAST_LEVEL_AMT_12 = t_LAST_LEVEL_AMT_12
        WHERE ITEM_CODE = NO_LAST_REC.ITEM_CODE;         
            
    END LOOP NO_LAST_REC;







--5단계> 최하위가 아닌 항목들의 자료를 보정한다.
--최하위가 아닌 항목들은 그 값이 각 기간의 2번째 칼럼에 찍혀야 한다.

    FOR NO_LAST_REC_ADJUST IN (
        SELECT ITEM_CODE    --항목코드
        FROM FI_FS_IS_PARADE
        WHERE ITEM_LEVEL < t_LAST_ITEM_LEVEL
        ORDER BY ITEM_LEVEL DESC
    ) LOOP
        
        --각 기간의 최하위가 아닌 레벨의 값을 설정한다.
        UPDATE FI_FS_IS_PARADE
        SET   NON_LAST_AMT_01 = LAST_LEVEL_AMT_01
            , NON_LAST_AMT_02 = LAST_LEVEL_AMT_02
            , NON_LAST_AMT_03 = LAST_LEVEL_AMT_03
            , NON_LAST_AMT_04 = LAST_LEVEL_AMT_04
            , NON_LAST_AMT_05 = LAST_LEVEL_AMT_05
            , NON_LAST_AMT_06 = LAST_LEVEL_AMT_06
            , NON_LAST_AMT_07 = LAST_LEVEL_AMT_07
            , NON_LAST_AMT_08 = LAST_LEVEL_AMT_08
            , NON_LAST_AMT_09 = LAST_LEVEL_AMT_09
            , NON_LAST_AMT_10 = LAST_LEVEL_AMT_10
            , NON_LAST_AMT_11 = LAST_LEVEL_AMT_11
            , NON_LAST_AMT_12 = LAST_LEVEL_AMT_12
        WHERE ITEM_CODE = NO_LAST_REC_ADJUST.ITEM_CODE;
        
        --각 기간의 최하위가 아닌 레벨의 항목들에 대해 최하위 값을 CLEAR한다.
        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_01 = NULL
            , LAST_LEVEL_AMT_02 = NULL
            , LAST_LEVEL_AMT_03 = NULL
            , LAST_LEVEL_AMT_04 = NULL
            , LAST_LEVEL_AMT_05 = NULL
            , LAST_LEVEL_AMT_06 = NULL
            , LAST_LEVEL_AMT_07 = NULL
            , LAST_LEVEL_AMT_08 = NULL
            , LAST_LEVEL_AMT_09 = NULL
            , LAST_LEVEL_AMT_10 = NULL
            , LAST_LEVEL_AMT_11 = NULL
            , LAST_LEVEL_AMT_12 = NULL
        WHERE ITEM_CODE = NO_LAST_REC_ADJUST.ITEM_CODE;           

    END LOOP NO_LAST_REC_ADJUST;







--조회된 자료의 합계금액을 UPDATE한다.
--단, 기초상품재고액(3), 기말상품재고액(5), 기초제품재고액(6), 기말제품재고액(8)의 항목은 다르다.
    UPDATE FI_FS_IS_PARADE
    SET LAST_LEVEL_AMT_SUM = 
            (   
                  NVL(LAST_LEVEL_AMT_01, 0) + NVL(NON_LAST_AMT_01, 0)
                + NVL(LAST_LEVEL_AMT_02, 0) + NVL(NON_LAST_AMT_02, 0) 
                + NVL(LAST_LEVEL_AMT_03, 0) + NVL(NON_LAST_AMT_03, 0)
                + NVL(LAST_LEVEL_AMT_04, 0) + NVL(NON_LAST_AMT_04, 0)
                + NVL(LAST_LEVEL_AMT_05, 0) + NVL(NON_LAST_AMT_05, 0)
                + NVL(LAST_LEVEL_AMT_06, 0) + NVL(NON_LAST_AMT_06, 0)
                + NVL(LAST_LEVEL_AMT_07, 0) + NVL(NON_LAST_AMT_07, 0)
                + NVL(LAST_LEVEL_AMT_08, 0) + NVL(NON_LAST_AMT_08, 0)
                + NVL(LAST_LEVEL_AMT_09, 0) + NVL(NON_LAST_AMT_09, 0)
                + NVL(LAST_LEVEL_AMT_10, 0) + NVL(NON_LAST_AMT_10, 0)
                + NVL(LAST_LEVEL_AMT_11, 0) + NVL(NON_LAST_AMT_11, 0)
                + NVL(LAST_LEVEL_AMT_12, 0) + NVL(NON_LAST_AMT_12, 0)
            )
        , NON_LAST_AMT_SUM =
            (   
                  NVL(LAST_LEVEL_AMT_01, 0) + NVL(NON_LAST_AMT_01, 0)
                + NVL(LAST_LEVEL_AMT_02, 0) + NVL(NON_LAST_AMT_02, 0) 
                + NVL(LAST_LEVEL_AMT_03, 0) + NVL(NON_LAST_AMT_03, 0)
                + NVL(LAST_LEVEL_AMT_04, 0) + NVL(NON_LAST_AMT_04, 0)
                + NVL(LAST_LEVEL_AMT_05, 0) + NVL(NON_LAST_AMT_05, 0)
                + NVL(LAST_LEVEL_AMT_06, 0) + NVL(NON_LAST_AMT_06, 0)
                + NVL(LAST_LEVEL_AMT_07, 0) + NVL(NON_LAST_AMT_07, 0)
                + NVL(LAST_LEVEL_AMT_08, 0) + NVL(NON_LAST_AMT_08, 0)
                + NVL(LAST_LEVEL_AMT_09, 0) + NVL(NON_LAST_AMT_09, 0)
                + NVL(LAST_LEVEL_AMT_10, 0) + NVL(NON_LAST_AMT_10, 0)
                + NVL(LAST_LEVEL_AMT_11, 0) + NVL(NON_LAST_AMT_11, 0)
                + NVL(LAST_LEVEL_AMT_12, 0) + NVL(NON_LAST_AMT_12, 0)
            )
    WHERE ITEM_CODE NOT IN ('3', '5', '6', '8')
    ;


--조회된 자료의 합계금액을 UPDATE한다.    
--단, 기초상품재고액(3), 기말상품재고액(5), 기초제품재고액(6), 기말제품재고액(8)의 항목은 다르다.
--그러나, 합계는 월의 경우만 보이기 때문에 분기/반기/년의 경우는 좀 틀리는 금액이 나올 수 있는데, 알면서도 보완 안한다.

    IF W_DATA_GB = 'M' THEN 


        --기초상품재고액(3) 
        IF t_TERM_START_M = '01' THEN
            SELECT LAST_LEVEL_AMT_01
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '02' THEN    
            SELECT LAST_LEVEL_AMT_02
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '03' THEN    
            SELECT LAST_LEVEL_AMT_03
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '04' THEN    
            SELECT LAST_LEVEL_AMT_04
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '05' THEN    
            SELECT LAST_LEVEL_AMT_05
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '06' THEN    
            SELECT LAST_LEVEL_AMT_06
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '07' THEN    
            SELECT LAST_LEVEL_AMT_07
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '08' THEN    
            SELECT LAST_LEVEL_AMT_08
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '09' THEN    
            SELECT LAST_LEVEL_AMT_09
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '10' THEN    
            SELECT LAST_LEVEL_AMT_10
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '11' THEN    
            SELECT LAST_LEVEL_AMT_11
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '12' THEN    
            SELECT LAST_LEVEL_AMT_12
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        END IF;        
        
        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '3'   ;
        
        
        
        --기말상품재고액(5)
        IF t_TERM_END_M = '01' THEN
            SELECT LAST_LEVEL_AMT_01
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '02' THEN    
            SELECT LAST_LEVEL_AMT_02
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '03' THEN    
            SELECT LAST_LEVEL_AMT_03
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '04' THEN    
            SELECT LAST_LEVEL_AMT_04
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '05' THEN    
            SELECT LAST_LEVEL_AMT_05
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '06' THEN    
            SELECT LAST_LEVEL_AMT_06
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '07' THEN    
            SELECT LAST_LEVEL_AMT_07
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '08' THEN    
            SELECT LAST_LEVEL_AMT_08
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '09' THEN    
            SELECT LAST_LEVEL_AMT_09
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '10' THEN    
            SELECT LAST_LEVEL_AMT_10
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '11' THEN    
            SELECT LAST_LEVEL_AMT_11
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '12' THEN    
            SELECT LAST_LEVEL_AMT_12
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        END IF;
        
        UPDATE FI_FS_IS_PARADE
        SET LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '5'   ;
 
 
 
 
 
 
        --기초제품재고액(6)
        IF t_TERM_START_M = '01' THEN
            SELECT LAST_LEVEL_AMT_01
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '02' THEN    
            SELECT LAST_LEVEL_AMT_02
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '03' THEN    
            SELECT LAST_LEVEL_AMT_03
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '04' THEN    
            SELECT LAST_LEVEL_AMT_04
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '05' THEN    
            SELECT LAST_LEVEL_AMT_05
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '06' THEN    
            SELECT LAST_LEVEL_AMT_06
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '07' THEN    
            SELECT LAST_LEVEL_AMT_07
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '08' THEN    
            SELECT LAST_LEVEL_AMT_08
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '09' THEN    
            SELECT LAST_LEVEL_AMT_09
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '10' THEN    
            SELECT LAST_LEVEL_AMT_10
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '11' THEN    
            SELECT LAST_LEVEL_AMT_11
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '12' THEN    
            SELECT LAST_LEVEL_AMT_12
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        END IF;
        
        UPDATE FI_FS_IS_PARADE
        SET LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '6'   ;
        
 
 
 
 
        --기말제품재고액(8)
        IF t_TERM_END_M = '01' THEN
            SELECT LAST_LEVEL_AMT_01
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '02' THEN    
            SELECT LAST_LEVEL_AMT_02
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '03' THEN    
            SELECT LAST_LEVEL_AMT_03
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '04' THEN    
            SELECT LAST_LEVEL_AMT_04
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '05' THEN    
            SELECT LAST_LEVEL_AMT_05
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '06' THEN    
            SELECT LAST_LEVEL_AMT_06
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '07' THEN    
            SELECT LAST_LEVEL_AMT_07
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '08' THEN    
            SELECT LAST_LEVEL_AMT_08
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '09' THEN    
            SELECT LAST_LEVEL_AMT_09
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '10' THEN    
            SELECT LAST_LEVEL_AMT_10
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '11' THEN    
            SELECT LAST_LEVEL_AMT_11
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '12' THEN    
            SELECT LAST_LEVEL_AMT_12
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        END IF;
        
        UPDATE FI_FS_IS_PARADE
        SET LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '8'   ;

    ELSIF W_DATA_GB = 'Q' THEN
 
        --기초상품재고액(3)
        SELECT LAST_LEVEL_AMT_01
        INTO t_INVENTORY_AMOUNT
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '3'   ; 
            
        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '3'   ;
        
                
        --기말상품재고액(5)
        SELECT LAST_LEVEL_AMT_04
        INTO t_INVENTORY_AMOUNT
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '5';
        
        UPDATE FI_FS_IS_PARADE
        SET LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '5'   ;
        
             
        --기초제품재고액(6)
        SELECT NON_LAST_AMT_01
        INTO t_INVENTORY_AMOUNT
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '6';
                        
        UPDATE FI_FS_IS_PARADE
        SET LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '6'   ;
        
        
        --기말제품재고액(8)
        SELECT NON_LAST_AMT_04
        INTO t_INVENTORY_AMOUNT
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '8';
        
        UPDATE FI_FS_IS_PARADE
        SET LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '8'   ;        
    
    ELSIF W_DATA_GB = 'H' THEN
    
        --기초상품재고액(3)
        SELECT LAST_LEVEL_AMT_01
        INTO t_INVENTORY_AMOUNT
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '3'   ; 
            
        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '3'   ;
        
                
        --기말상품재고액(5)
        SELECT LAST_LEVEL_AMT_02
        INTO t_INVENTORY_AMOUNT
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '5';
        
        UPDATE FI_FS_IS_PARADE
        SET LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '5'   ;
        
        
        --기초제품재고액(6)
        SELECT NON_LAST_AMT_01
        INTO t_INVENTORY_AMOUNT
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '6';
                        
        UPDATE FI_FS_IS_PARADE
        SET LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '6'   ;
        
        
        --기말제품재고액(8)
        SELECT NON_LAST_AMT_02
        INTO t_INVENTORY_AMOUNT
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '8';
        
        UPDATE FI_FS_IS_PARADE
        SET LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '8'   ;  
    
    ELSIF W_DATA_GB = 'Y' THEN

        NULL;

    END IF;





    --합계 금액이 0 인 자료를 NULL로 보정한다.
    UPDATE FI_FS_IS_PARADE
    SET   LAST_LEVEL_AMT_SUM = DECODE(LAST_LEVEL_AMT_SUM, 0, NULL, LAST_LEVEL_AMT_SUM)
        , NON_LAST_AMT_SUM = DECODE(NON_LAST_AMT_SUM, 0, NULL, NON_LAST_AMT_SUM)        
        , LAST_LEVEL_AMT_01 = DECODE(LAST_LEVEL_AMT_01, 0, NULL, LAST_LEVEL_AMT_01)
        , NON_LAST_AMT_01 = DECODE(NON_LAST_AMT_01, 0, NULL, NON_LAST_AMT_01)
        , LAST_LEVEL_AMT_02 = DECODE(LAST_LEVEL_AMT_02, 0, NULL, LAST_LEVEL_AMT_02)
        , NON_LAST_AMT_02 = DECODE(NON_LAST_AMT_02, 0, NULL, NON_LAST_AMT_02)        
        , LAST_LEVEL_AMT_03 = DECODE(LAST_LEVEL_AMT_03, 0, NULL, LAST_LEVEL_AMT_03)
        , NON_LAST_AMT_03 = DECODE(NON_LAST_AMT_03, 0, NULL, NON_LAST_AMT_03)
        , LAST_LEVEL_AMT_04 = DECODE(LAST_LEVEL_AMT_04, 0, NULL, LAST_LEVEL_AMT_04)
        , NON_LAST_AMT_04 = DECODE(NON_LAST_AMT_04, 0, NULL, NON_LAST_AMT_04)
        , LAST_LEVEL_AMT_05 = DECODE(LAST_LEVEL_AMT_05, 0, NULL, LAST_LEVEL_AMT_05)
        , NON_LAST_AMT_05 = DECODE(NON_LAST_AMT_05, 0, NULL, NON_LAST_AMT_05)
        , LAST_LEVEL_AMT_06 = DECODE(LAST_LEVEL_AMT_06, 0, NULL, LAST_LEVEL_AMT_06)
        , NON_LAST_AMT_06 = DECODE(NON_LAST_AMT_06, 0, NULL, NON_LAST_AMT_06)
        , LAST_LEVEL_AMT_07 = DECODE(LAST_LEVEL_AMT_07, 0, NULL, LAST_LEVEL_AMT_07)
        , NON_LAST_AMT_07 = DECODE(NON_LAST_AMT_07, 0, NULL, NON_LAST_AMT_07)
        , LAST_LEVEL_AMT_08 = DECODE(LAST_LEVEL_AMT_08, 0, NULL, LAST_LEVEL_AMT_08)
        , NON_LAST_AMT_08 = DECODE(NON_LAST_AMT_08, 0, NULL, NON_LAST_AMT_08)
        , LAST_LEVEL_AMT_09 = DECODE(LAST_LEVEL_AMT_09, 0, NULL, LAST_LEVEL_AMT_09)
        , NON_LAST_AMT_09 = DECODE(NON_LAST_AMT_09, 0, NULL, NON_LAST_AMT_09)
        , LAST_LEVEL_AMT_10 = DECODE(LAST_LEVEL_AMT_10, 0, NULL, LAST_LEVEL_AMT_10)
        , NON_LAST_AMT_10 = DECODE(NON_LAST_AMT_10, 0, NULL, NON_LAST_AMT_10)
        , LAST_LEVEL_AMT_11 = DECODE(LAST_LEVEL_AMT_11, 0, NULL, LAST_LEVEL_AMT_11)
        , NON_LAST_AMT_11 = DECODE(NON_LAST_AMT_11, 0, NULL, NON_LAST_AMT_11)
        , LAST_LEVEL_AMT_12 = DECODE(LAST_LEVEL_AMT_12, 0, NULL, LAST_LEVEL_AMT_12)
        , NON_LAST_AMT_12 = DECODE(NON_LAST_AMT_12, 0, NULL, NON_LAST_AMT_12)        
    ;




--6단계> 손익계산서를 조회한다.
    OPEN P_CURSOR FOR

    SELECT
          ITEM_CODE	            --항목코드_계정코드    
        , ITEM_NAME             --계정과목;      출력항목명
          
        , LAST_LEVEL_AMT_SUM    --함계_최하위레벨항목금액
        , NON_LAST_AMT_SUM	    --합계_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_01	    --01월_최하위레벨항목금액_1분기, 상반기, 당기
        , NON_LAST_AMT_01	    --01월_최하위아닌레벨항목금액_1분기, 상반기, 당기
        , LAST_LEVEL_AMT_02	    --02월_최하위레벨항목금액_2분기, 하반기, 전기
        , NON_LAST_AMT_02	    --02월_최하위아닌레벨항목금액_2분기, 하반기, 전기
        , LAST_LEVEL_AMT_03	    --03월_최하위레벨항목금액_3분기
        , NON_LAST_AMT_03	    --03월_최하위아닌레벨항목금액_3분기
        , LAST_LEVEL_AMT_04	    --04월_최하위레벨항목금액_4분기
        , NON_LAST_AMT_04	    --04월_최하위아닌레벨항목금액_4분기
        , LAST_LEVEL_AMT_05	    --05월_최하위레벨항목금액
        , NON_LAST_AMT_05	    --05월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_06	    --06월_최하위레벨항목금액
        , NON_LAST_AMT_06	    --06월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_07	    --07월_최하위레벨항목금액
        , NON_LAST_AMT_07	    --07월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_08	    --08월_최하위레벨항목금액
        , NON_LAST_AMT_08	    --08월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_09	    --09월_최하위레벨항목금액
        , NON_LAST_AMT_09	    --09월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_10	    --10월_최하위레벨항목금액
        , NON_LAST_AMT_10	    --10월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_11	    --11월_최하위레벨항목금액
        , NON_LAST_AMT_11	    --11월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_12	    --12월_최하위레벨항목금액
        , NON_LAST_AMT_12	    --12월_최하위아닌레벨항목금액          
    FROM FI_FS_IS_PARADE
    WHERE FORM_FRAME_YN = 'Y' OR
        (ENABLED_FLAG = 'Y'    --보고서에 출렬할 항목만 나오도록 함. 
        
            --화면에 보이는 금액 항목이 모두 NULL 인 자료는 보이지 않게 하기 위함.
            AND (  LAST_LEVEL_AMT_SUM IS NOT NULL OR NON_LAST_AMT_SUM IS NOT NULL
                OR LAST_LEVEL_AMT_01 IS NOT NULL OR NON_LAST_AMT_01 IS NOT NULL
                OR LAST_LEVEL_AMT_02 IS NOT NULL OR NON_LAST_AMT_02 IS NOT NULL
                OR LAST_LEVEL_AMT_03 IS NOT NULL OR NON_LAST_AMT_03 IS NOT NULL
                OR LAST_LEVEL_AMT_04 IS NOT NULL OR NON_LAST_AMT_04 IS NOT NULL
                OR LAST_LEVEL_AMT_05 IS NOT NULL OR NON_LAST_AMT_05 IS NOT NULL
                OR LAST_LEVEL_AMT_06 IS NOT NULL OR NON_LAST_AMT_06 IS NOT NULL
                OR LAST_LEVEL_AMT_07 IS NOT NULL OR NON_LAST_AMT_07 IS NOT NULL
                OR LAST_LEVEL_AMT_08 IS NOT NULL OR NON_LAST_AMT_08 IS NOT NULL
                OR LAST_LEVEL_AMT_09 IS NOT NULL OR NON_LAST_AMT_09 IS NOT NULL
                OR LAST_LEVEL_AMT_10 IS NOT NULL OR NON_LAST_AMT_10 IS NOT NULL
                OR LAST_LEVEL_AMT_11 IS NOT NULL OR NON_LAST_AMT_11 IS NOT NULL
                OR LAST_LEVEL_AMT_12 IS NOT NULL OR NON_LAST_AMT_12 IS NOT NULL )
        )
    ORDER BY SORT_SEQ;
    
    
/*    EXCEPTION
        WHEN OTHERS THEN
           --작업중 오류가 발생하였습니다. 확인바랍니다.
           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');         
*/

END LIST_IS;






--LIST_IS PROCEDURE와 동일한 것으로 자료구분이 월이 아닌 경우
--자료구분이 월인 경우 각 월의 기말상품재고액/기말제품재고액을 구해 
--자료구분이 분기, 반기, 년 인 경우의 기말상품재고액/기말제품재고액을 구하기 위함이다.
PROCEDURE LIST_IS_M_OTHER(
      W_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE     --회사아이디
    , W_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE     --사업부아이디
    , W_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE  --보고서기준세트아이디
    , W_CLOSING_YEAR    IN  VARCHAR2                    --결산년
    , W_DATA_GB         IN  VARCHAR2                    --자료구분(M : 월)

    --종료월은 시작월보다 같거나 커야 합니다.
    , W_CLOSING_START   IN  VARCHAR2                    --조회 시작월(예> M01 : 1월인경우)
    , W_CLOSING_END     IN  VARCHAR2                    --조회 종료월(예> M12 : 12월인경우)
)

AS

t_CNT               NUMBER := 0;    --재고자산기말금액 자료존재 유무를 파악하기 위함.


t_TERM_START_M      VARCHAR2(2) := NULL;    --당기시작월
t_TERM_END_M        VARCHAR2(2) := NULL;    --당기종료월
t_REPEAT            VARCHAR2(2) := NULL;    --자료조회월
t_PERIOD_FROM       DATE;                   --당기시작일
t_PERIOD_TO         DATE;                   --당기종료일


t_REPEAT_MM        VARCHAR2(2) := NULL;    --재고자산기말금액 추출시 사용함.

t_WORK_MM           VARCHAR2(2) := NULL;    --재고자산기말금액 추출을 위한 작업월
t_RECURSIVE_CNT     NUMBER  := 0;           --재고자산기말금액 추출을 위한 LOOP문 반복 회수


--당기의 의미 : [월]탭에서는 1월, 2월 등의 각 월을 의미하고, [분기]탭에서 1분기, 2분기 등을 의미하는 이런 식이다.
t_THIS_LAST_LEVEL_AMT       NUMBER  := 0;   --당기_최하위레벨항목금액

t_LAST_LEVEL_AMT_01         NUMBER  := 0;   --01월_최하위레벨항목금액
t_LAST_LEVEL_AMT_01_CALC    NUMBER  := 0;   --01월_최하위레벨항목금액 집계를 위한 변수
t_LAST_LEVEL_AMT_02         NUMBER  := 0;   --02월_최하위레벨항목금액
t_LAST_LEVEL_AMT_02_CALC    NUMBER  := 0;   --02월_최하위레벨항목금액 집계를 위한 변수
t_LAST_LEVEL_AMT_03         NUMBER  := 0;   --03월_최하위레벨항목금액
t_LAST_LEVEL_AMT_03_CALC    NUMBER  := 0;   --03월_최하위레벨항목금액 집계를 위한 변수        
t_LAST_LEVEL_AMT_04         NUMBER  := 0;   --04월_최하위레벨항목금액
t_LAST_LEVEL_AMT_04_CALC    NUMBER  := 0;   --04월_최하위레벨항목금액 집계를 위한 변수
t_LAST_LEVEL_AMT_05         NUMBER  := 0;   --05월_최하위레벨항목금액
t_LAST_LEVEL_AMT_05_CALC    NUMBER  := 0;   --05월_최하위레벨항목금액 집계를 위한 변수
t_LAST_LEVEL_AMT_06         NUMBER  := 0;   --06월_최하위레벨항목금액
t_LAST_LEVEL_AMT_06_CALC    NUMBER  := 0;   --06월_최하위레벨항목금액 집계를 위한 변수 
t_LAST_LEVEL_AMT_07         NUMBER  := 0;   --07월_최하위레벨항목금액
t_LAST_LEVEL_AMT_07_CALC    NUMBER  := 0;   --07월_최하위레벨항목금액 집계를 위한 변수
t_LAST_LEVEL_AMT_08         NUMBER  := 0;   --08월_최하위레벨항목금액
t_LAST_LEVEL_AMT_08_CALC    NUMBER  := 0;   --08월_최하위레벨항목금액 집계를 위한 변수
t_LAST_LEVEL_AMT_09         NUMBER  := 0;   --09월_최하위레벨항목금액
t_LAST_LEVEL_AMT_09_CALC    NUMBER  := 0;   --09월_최하위레벨항목금액 집계를 위한 변수 
t_LAST_LEVEL_AMT_10         NUMBER  := 0;   --10월_최하위레벨항목금액
t_LAST_LEVEL_AMT_10_CALC    NUMBER  := 0;   --10월_최하위레벨항목금액 집계를 위한 변수
t_LAST_LEVEL_AMT_11         NUMBER  := 0;   --11월_최하위레벨항목금액
t_LAST_LEVEL_AMT_11_CALC    NUMBER  := 0;   --11월_최하위레벨항목금액 집계를 위한 변수
t_LAST_LEVEL_AMT_12         NUMBER  := 0;   --12월_최하위레벨항목금액
t_LAST_LEVEL_AMT_12_CALC    NUMBER  := 0;   --12월_최하위레벨항목금액 집계를 위한 변수 

t_INVENTORY_AMOUNT      NUMBER := 0;   --재고자산 이월금액
t_TERM_END_AMT          NUMBER := 0;   --재고자산 기간말금액
t_TERM_END_AMT_NEXT     NUMBER := 0;   --재고자산 기간말금액(차기 기초제고액으로 설절하기 위함)
t_TERM_END_LINE_AMT     NUMBER := 0;   --재고자산 기말재공품재고액
t_TERM_END_LINE_AMT_0   NUMBER := 0;   --재고자산 기말재공품재고액이 0 인경우를 대비하여 사용.
t_TERM_END_RAW_AMT      NUMBER := 0;   --재고자산 원재료금액
t_MATERIAL_AMT          NUMBER := 0;   --기말원재료재고액 임시 저장
t_ITEM_COST             NUMBER := 0;   --당기제품제조원가 임시 저장


t_ITEM_CODE     FI_FS_IS_PARADE.ITEM_CODE%TYPE;      --항목코드_계정코드
t_ACCOUNT_DR_CR FI_FS_IS_PARADE.ACCOUNT_DR_CR%TYPE;  --차대구분(1-차변,2-대변)

--제조원가명세서의 당기제품제조원가를 추출하기 위한 CURSOR임.
TYPE TCURSOR IS REF CURSOR;
IS_TCURSOR TCURSOR;

BEGIN

--1단계>기준자료 설정, 기존 자료 삭제, 기본 틀 형성

    --월설정 : 자료구분(M : 월)별 시작월과 종료월 설정
    IF    W_DATA_GB = 'M' THEN
        t_TERM_START_M  := SUBSTR(W_CLOSING_START, 2, 2);
        t_TERM_END_M    := SUBSTR(W_CLOSING_END, 2, 2);  
    END IF;        



    --기존 자료를 삭제한다.
    DELETE FI_FS_IS_PARADE;


    --손익계산서를 조회하기 위한 기본틀을 만든다.
    INSERT INTO FI_FS_IS_PARADE(
          ITEM_NAME	            --출력항목명
          
        , LAST_LEVEL_AMT_SUM    --함계_최하위레벨항목금액
        , NON_LAST_AMT_SUM	    --합계_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_01	    --01월_최하위레벨항목금액_1분기, 상반기, 당기
        , NON_LAST_AMT_01	    --01월_최하위아닌레벨항목금액_1분기, 상반기, 당기
        , LAST_LEVEL_AMT_02	    --02월_최하위레벨항목금액_2분기, 하반기, 전기
        , NON_LAST_AMT_02	    --02월_최하위아닌레벨항목금액_2분기, 하반기, 전기
        , LAST_LEVEL_AMT_03	    --03월_최하위레벨항목금액_3분기
        , NON_LAST_AMT_03	    --03월_최하위아닌레벨항목금액_3분기
        , LAST_LEVEL_AMT_04	    --04월_최하위레벨항목금액_4분기
        , NON_LAST_AMT_04	    --04월_최하위아닌레벨항목금액_4분기
        , LAST_LEVEL_AMT_05	    --05월_최하위레벨항목금액
        , NON_LAST_AMT_05	    --05월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_06	    --06월_최하위레벨항목금액
        , NON_LAST_AMT_06	    --06월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_07	    --07월_최하위레벨항목금액
        , NON_LAST_AMT_07	    --07월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_08	    --08월_최하위레벨항목금액
        , NON_LAST_AMT_08	    --08월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_09	    --09월_최하위레벨항목금액
        , NON_LAST_AMT_09	    --09월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_10	    --10월_최하위레벨항목금액
        , NON_LAST_AMT_10	    --10월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_11	    --11월_최하위레벨항목금액
        , NON_LAST_AMT_11	    --11월_최하위아닌레벨항목금액
        , LAST_LEVEL_AMT_12	    --12월_최하위레벨항목금액
        , NON_LAST_AMT_12	    --12월_최하위아닌레벨항목금액          
        
        , ITEM_CODE	            --항목코드_계정코드
        , ACCOUNT_DR_CR         --차대구분(1-차변,2-대변)
        , SORT_SEQ	            --정렬순서
        , ITEM_LEVEL	        --금액계산레벨
        , ENABLED_FLAG	        --사용(표시)여부
        , FORM_FRAME_YN	        --보고서틀유지여부
        , REF_FORM_TYPE_ID      --관련보고서양식아이디
        , REF_ITEM_CODE         --관련항목코드
    )
    SELECT
          ITEM_NAME     --출력항목명
          
        , NULL  --함계_최하위레벨항목금액
        , NULL	--합계_최하위아닌레벨항목금액
        , NULL	--01월_최하위레벨항목금액_1분기, 상반기, 당기
        , NULL	--01월_최하위아닌레벨항목금액_1분기, 상반기, 당기
        , NULL	--02월_최하위레벨항목금액_2분기, 하반기, 전기
        , NULL	--02월_최하위아닌레벨항목금액_2분기, 하반기, 전기
        , NULL	--03월_최하위레벨항목금액_3분기
        , NULL	--03월_최하위아닌레벨항목금액_3분기
        , NULL	--04월_최하위레벨항목금액_4분기
        , NULL	--04월_최하위아닌레벨항목금액_4분기
        , NULL	--05월_최하위레벨항목금액
        , NULL	--05월_최하위아닌레벨항목금액
        , NULL	--06월_최하위레벨항목금액
        , NULL	--06월_최하위아닌레벨항목금액
        , NULL	--07월_최하위레벨항목금액
        , NULL	--07월_최하위아닌레벨항목금액
        , NULL	--08월_최하위레벨항목금액
        , NULL	--08월_최하위아닌레벨항목금액
        , NULL	--09월_최하위레벨항목금액
        , NULL	--09월_최하위아닌레벨항목금액
        , NULL	--10월_최하위레벨항목금액
        , NULL	--10월_최하위아닌레벨항목금액
        , NULL	--11월_최하위레벨항목금액
        , NULL	--11월_최하위아닌레벨항목금액
        , NULL	--12월_최하위레벨항목금액
        , NULL	--12월_최하위아닌레벨항목금액      
        
        , ITEM_CODE     --항목코드_계정코드 
        , ACCOUNT_DR_CR --차대구분(1-차변,2-대변)
        , SORT_SEQ      --정렬순서
        , ITEM_LEVEL    --금액계산레벨
        
        --N인 자료는 금액계산 시에는 사용되지만, 보고서에 보여서는 안될 항목이다.
        --즉, N인 자료는 금액계산이 레벨에 의해 이뤄지는 체계를 유지하기 위해 임으로 가져가는 항목일 뿐이다.
        , ENABLED_FLAG      --사용(표시)여부
        
        --금액의 유무를 떠나서 아래 항목이 'Y'인 항목은 보고서의 틀을 유지하기 위해 무조건 출력되어야 할 항목이다.
        , FORM_FRAME_YN	        --보고서틀유지여부
        , REF_FORM_TYPE_ID      --관련보고서양식아이디
        , REF_ITEM_CODE         --관련항목코드        
    FROM FI_FORM_MST                        --재무제표보고서양식_마스터
    WHERE SOB_ID = W_SOB_ID                 --회사아이디
        AND ORG_ID = W_ORG_ID               --사업부아이디
        AND FS_SET_ID = W_FS_SET_ID         --보고서기준세트아이디
        AND FORM_TYPE_ID = t_FORM_TYPE_ID   --보고서양식ID(공통코드)
    ORDER BY SORT_SEQ    
    ;


--2단계>최하위레벨의 금액을 구한다.
--단, 기초상품재고액(3), 기말상품재고액(5), 기초제품재고액(6), 당기제품제조원가(7), 기말제품재고액(8)의 5개 항목은
--금액계산레벨을 무시하고 상세항목을 이용해서 금액을 추출하지 않는다.

    IF W_DATA_GB IS NOT NULL THEN
        FOR REPEAT IN t_TERM_START_M..t_TERM_END_M LOOP

            t_REPEAT := LPAD(REPEAT, 2, 0);
            
            
            --당기일설정 : 당기의 시작일과 종료일 설정
            IF    W_DATA_GB = 'M' THEN
                t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || t_REPEAT, 'YYYY-MM');
                t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || t_REPEAT, 'YYYY-MM'));     
            END IF;



            --기간내의 해당 계정의 금액을 분개자료에서 구한다. 
            FI_FS_SLIP_G.CREATE_FS_SLIP(
                  W_SOB_ID
                , W_ORG_ID
                , W_FS_SET_ID
                , t_FORM_TYPE_ID
                , t_LAST_ITEM_LEVEL
                , t_PERIOD_FROM
                , t_PERIOD_TO   );


            --3 : 기초상품재고액, 5 : 기말상품재고액, 
            --6 : 기초제품재고액, 7 : 당기제품제조원가, 8 : 기말제품재고액
            FOR LAST_LEVEL_REC IN (
                SELECT          
                      ITEM_CODE	    --항목코드
                    , ACCOUNT_DR_CR	--차대구분(1-차변,2-대변)
                FROM FI_FS_IS_PARADE
                WHERE ITEM_LEVEL = t_LAST_ITEM_LEVEL
                    AND (ITEM_CODE NOT IN ('3', '5', '6', '7', '8') )
            ) LOOP
        
                --DBMS_OUTPUT.PUT_LINE('항목코드 : ' || LAST_LEVEL_REC.ITEM_CODE);        
                
                t_THIS_LAST_LEVEL_AMT       := 0;   --당기_최하위레벨항목금액

                IF LAST_LEVEL_REC.ACCOUNT_DR_CR = '1' THEN      --해당 계정이 차변계정이면
                    BEGIN
                      SELECT SUM(DR_AMT) - SUM(CR_AMT) AS AMT
                      INTO t_THIS_LAST_LEVEL_AMT
                      FROM FI_FS_SLIP
                      WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
                      GROUP BY ITEM_CODE;
                    EXCEPTION WHEN OTHERS THEN
                      t_THIS_LAST_LEVEL_AMT := 0;
                    END;
                ELSIF LAST_LEVEL_REC.ACCOUNT_DR_CR = '2' THEN   --해당 계정이 대변계정이면
                    BEGIN
                      SELECT SUM(CR_AMT) - SUM(DR_AMT) AS AMT
                      INTO t_THIS_LAST_LEVEL_AMT
                      FROM FI_FS_SLIP
                      WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
                      GROUP BY ITEM_CODE;                
                    EXCEPTION WHEN OTHERS THEN
                      t_THIS_LAST_LEVEL_AMT := 0;
                    END;
                END IF;              


                --해당 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_THIS_LAST_LEVEL_AMT, LAST_LEVEL_REC.ITEM_CODE );
                
            END LOOP LAST_LEVEL_REC;      

        END LOOP REPEAT; 
        
    END IF;






--2단계>기초상품재고액(3), 기말상품재고액(5), 기초제품재고액(6), 기말제품재고액(8), 당기제품제조원가(7)의 항목 금액 추출
--위 항목의 ()안에 들어있는 값은 해당 항목들에 대한 재무제표양식관리에 설정된 항목코드이다.

    IF    W_DATA_GB = 'M' THEN
    
        --각월의 당기제품제조원가(9)를 추출하기 위해 제조원가명세서를 실행한다.
        FI_FS_FACTORY_COST_PARADE_G.LIST_FACTORY_COST(
              IS_TCURSOR
            , W_SOB_ID
            , W_ORG_ID
            , t_FS_SET_ID
            , W_CLOSING_YEAR
            , W_DATA_GB
            , W_CLOSING_START
            , W_CLOSING_END  );



        FOR REPEAT_INVENTORY IN 01..t_TERM_END_M LOOP

            t_REPEAT := LPAD(REPEAT_INVENTORY, 2, 0);

            IF t_REPEAT = '01' THEN               
                
                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_FORWARD_RAW_AMT, '3' );

                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');                    
            

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_FORWARD_RAW_AMT;    --당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_FORWARD_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.
                
                SELECT NVL(NON_LAST_AMT_01, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  
                
                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_FORWARD_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;                
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- 다음 월의 기초제품재고액에 이용하기 위함.
            
            ELSIF t_REPEAT = '02' THEN
                --2월 ~ 12월 까지의 기초/기말 상품금액 설정논리는 모두 같다.
                                       
                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );

                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.
                
                SELECT NVL(NON_LAST_AMT_02, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );

                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- 다음 월의 기초제품재고액에 이용하기 위함.
                
            ELSIF t_REPEAT = '03' THEN 
            
                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.
                


                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_03, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  

                --기말제품재고액(8) 칼럼에 값을 UPDATE한다.
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;                    
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- 다음 월의 기초제품재고액에 이용하기 위함.   

            ELSIF t_REPEAT = '04' THEN

                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );

                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_04, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  
                
                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --다음 월의 기초제품재고액에 이용하기 위함.                

            ELSIF t_REPEAT = '05' THEN

                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_05, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );   
                
                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --다음 월의 기초제품재고액에 이용하기 위함.                  

            ELSIF t_REPEAT = '06' THEN
            
                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.
                


                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_06, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  

                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --다음 월의 기초제품재고액에 이용하기 위함.  

            ELSIF t_REPEAT = '07' THEN

                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_07, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' ); 
                
                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --다음 월의 기초제품재고액에 이용하기 위함.                  
                
            ELSIF t_REPEAT = '08' THEN

                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_08, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );     

                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --다음 월의 기초제품재고액에 이용하기 위함.  

            ELSIF t_REPEAT = '09' THEN
            
                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_09, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );   

                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --다음 월의 기초제품재고액에 이용하기 위함.  

            ELSIF t_REPEAT = '10' THEN

                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)


                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_10, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  

                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --다음 월의 기초제품재고액에 이용하기 위함.  

            ELSIF t_REPEAT = '11' THEN

                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- 다음 월의 기초상품재고액에 이용하기 위함.


                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)
                

                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_11, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );               


                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL; 
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --다음 월의 기초제품재고액에 이용하기 위함.                                                                    

            ELSIF t_REPEAT = '12' THEN
            
                --기초상품재고액(3) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --기말상품재고액(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----당월입력금액이 없으면 기초상품재고액을 설정한다.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --기초상품재고액
                        +
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --당기상품매입액
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --기말상품재고액(5) 칼럼에 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );



                --기초제품재고액(6) 값을 UPDATE한다.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --기초제품재고액(6)
                
                --당기제품제조원가(7) 칼럼에 값을 UPDATE한다.

                SELECT NVL(NON_LAST_AMT_12, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --당기제품제조원가
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );                  


                --기말제품재고액(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --입력된 값이 NULL이면 값을 임의로 [99999999999999]로 넘기고 있음.
                --이 처리를 하는 것은 '0'도 의미있는 수치이기 때문에 이에 대한 처리를 해주기 위함이다.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --당월입력금액이 없으면 기초제품재고액을 설정한다.
                    
                    --기말제품재고액(8) = 기초제품재고액(6) + 당기제품제조원가(7) - 관세환급금(4300000) + 재고자산평가손실(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --기초제품재고액(6)
                        +
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --당기제품제조원가(7)
                        -
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --관세환급금(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --재고자산평가손실(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --기말제품재고액(8)
                
                --t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --다음 월의 기초제품재고액에 이용하기 위함.  

            END IF;

        END LOOP REPEAT_INVENTORY;
        
    END IF;

END LIST_IS_M_OTHER;












--해당월에 맞는 칼럼에 값을 UPDATE한다.
PROCEDURE UPDATE_AMT( 
      W_TERM        IN  VARCHAR2    --월
    , W_AMT         IN  NUMBER      --금액
    , W_ITEM_CODE   IN  FI_FS_IS_PARADE.ITEM_CODE%TYPE    --항목코드_계정코드
)

AS

BEGIN

    IF    W_TERM = '01' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_01   = W_AMT --당기_최하위레벨항목금액
        WHERE ITEM_CODE = W_ITEM_CODE;            
        
    ELSIF W_TERM = '02' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_02   = W_AMT --당기_최하위레벨항목금액
        WHERE ITEM_CODE = W_ITEM_CODE;            
                    
    ELSIF W_TERM = '03' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_03   = W_AMT --당기_최하위레벨항목금액
        WHERE ITEM_CODE = W_ITEM_CODE;            

    ELSIF W_TERM = '04' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_04   = W_AMT --당기_최하위레벨항목금액
        WHERE ITEM_CODE = W_ITEM_CODE;            

    ELSIF W_TERM = '05' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_05   = W_AMT --당기_최하위레벨항목금액
        WHERE ITEM_CODE = W_ITEM_CODE;            

    ELSIF W_TERM = '06' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_06   = W_AMT --당기_최하위레벨항목금액
        WHERE ITEM_CODE = W_ITEM_CODE;            

    ELSIF W_TERM = '07' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_07   = W_AMT --당기_최하위레벨항목금액
        WHERE ITEM_CODE = W_ITEM_CODE;            

    ELSIF W_TERM = '08' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_08   = W_AMT --당기_최하위레벨항목금액
        WHERE ITEM_CODE = W_ITEM_CODE;            

    ELSIF W_TERM = '09' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_09   = W_AMT --당기_최하위레벨항목금액
        WHERE ITEM_CODE = W_ITEM_CODE;            

    ELSIF W_TERM = '10' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_10   = W_AMT --당기_최하위레벨항목금액
        WHERE ITEM_CODE = W_ITEM_CODE;            

    ELSIF W_TERM = '11' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_11   = W_AMT --당기_최하위레벨항목금액
        WHERE ITEM_CODE = W_ITEM_CODE;            

    ELSIF W_TERM = '12' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_12   = W_AMT --당기_최하위레벨항목금액
        WHERE ITEM_CODE = W_ITEM_CODE;            

    END IF;

END UPDATE_AMT;







--재고자산기말자료를 구한다.
FUNCTION INVENTORY_DATA_F(
      W_DATA_GB IN VARCHAR2                 --C : 건수, A : 금액
    , W_SOB_ID  IN FI_FORM_MST.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID  IN FI_FORM_MST.ORG_ID%TYPE  --사업부아이디
    , W_PERIOD  IN VARCHAR2                 --조회기간(예>2011-12)
    
    --재고자산금액관리항목코드(402 : 기말상품, 302 : 기말제품)    
    , W_FORM_ITEM_TYPE_CD   IN FI_CLOSING_ENDING_AMOUNT.FORM_ITEM_TYPE_CD%TYPE
) RETURN NUMBER

AS

t_DATA NUMBER := 0;

BEGIN

    IF W_DATA_GB = 'C' THEN
    
        SELECT COUNT(*)
        INTO t_DATA
        FROM FI_CLOSING_ENDING_AMOUNT
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND PERIOD_NAME = W_PERIOD
            AND FORM_ITEM_TYPE_CD = W_FORM_ITEM_TYPE_CD ;    
    
    ELSIF W_DATA_GB = 'A' THEN
    
        SELECT NVL(ENDING_AMOUNT, 99999999999999)
        INTO t_DATA
        FROM FI_CLOSING_ENDING_AMOUNT
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND PERIOD_NAME = W_PERIOD
            AND FORM_ITEM_TYPE_CD = W_FORM_ITEM_TYPE_CD ;
    
    END IF;
                
    RETURN t_DATA;

END INVENTORY_DATA_F;









--출력시 사용; 합잔, 제조, 손익, 재무상태표 4개 양식 공통
PROCEDURE PRINT_TITLE(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  GL_FISCAL_YEAR.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN  GL_FISCAL_YEAR.ORG_ID%TYPE          --사업부아이디
    , W_PERIOD_TO       IN VARCHAR2                             --조회기간_종료  
)

AS

CURR_DATE   DATE;   -- := LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM'));  --현재일
PRE_DATE    DATE;   -- := LAST_DAY(TO_DATE( TO_CHAR(SUBSTR(W_PERIOD_TO, 1, 4) - 1) || '-12', 'YYYY-MM'));  --전기일


BEGIN

    BEGIN
        SELECT
              LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM')) --현재일
            , LAST_DAY(TO_DATE( TO_CHAR(SUBSTR(W_PERIOD_TO, 1, 4) - 1) || '-12', 'YYYY-MM'))    --전기일
        INTO CURR_DATE, PRE_DATE
        FROM DUAL;
        
        EXCEPTION WHEN OTHERS THEN NULL;
              
    END;
    
    

    OPEN P_CURSOR FOR

    SELECT
        (
            SELECT CORP_NAME   --상호(법인명)
            FROM HRM_CORP_MASTER
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND CORP_ID = 65  --법인아이디
        ) AS CORP_NAME  --상호(법인명)
        , '제 ' || FISCAL_COUNT || '(당)기   '  AS CUR_PERIOD  --제조원가, 손익계산서, 재무상태표에서 사용
        , '제 ' || (FISCAL_COUNT - 1) || '(전)기   '  AS PRE_PERIOD    --제조원가, 손익계산서, 재무상태표에서 사용
        , '제 ' || FISCAL_COUNT || ' 기   ' 
                || TO_CHAR(CURR_DATE, 'YYYY') || ' 년 '  
                || TO_NUMBER(TO_CHAR(CURR_DATE, 'MM')) || ' 월 ' 
                || TO_CHAR(CURR_DATE, 'DD') || ' 일 현재'      
            AS CUR_YEAR --당기(예>제 13기 2011년 12월 31일 현재); 재무상태표에서 사용
        , '제 ' || (FISCAL_COUNT - 1) || ' 기   ' 
                || TO_CHAR(PRE_DATE, 'YYYY') || ' 년 12 월 31 일 현재'  
                --|| TO_NUMBER(TO_CHAR(PRE_DATE, 'MM')) || '월 ' 
                --|| TO_CHAR(PRE_DATE, 'DD') || '일 현재'
            AS PRE_YEAR --전기(예>제 12기 2010년 12월 31일 현재); 재무상태표에서 사용
        , '제 ' || FISCAL_COUNT || ' 기   '
                || TO_CHAR(CURR_DATE, 'YYYY') || ' 년 1 월 1  일 부터 ' 
                || TO_CHAR(CURR_DATE, 'YYYY') || ' 년 '  
                || TO_NUMBER(TO_CHAR(CURR_DATE, 'MM')) || ' 월 ' 
                || TO_CHAR(CURR_DATE, 'DD') || ' 일 까지'      
            AS CUR_TERM --당기(예>제 13기 2011년 01월 01일 부터 2011년 12월 31일 까지); 제조원가, 손익계산서에서 사용
        , '제 ' || (FISCAL_COUNT - 1) || ' 기   '
                || TO_CHAR(PRE_DATE, 'YYYY') || ' 년 1 월 1 일 부터 ' 
                || TO_CHAR(PRE_DATE, 'YYYY') || ' 년 12 월 31 일 까지'  
                --|| TO_NUMBER(TO_CHAR(PRE_DATE, 'MM')) || '월 ' 
                --|| TO_CHAR(PRE_DATE, 'DD') || '일 까지'
            AS PRE_TERM --전기(예>제 12기 2010년 01월 01일 부터 2010년 12월 31일 까지); 제조원가, 손익계산서에서 사용
        , TO_CHAR(CURR_DATE, 'YYYY') || ' 년 '  
            || TO_NUMBER(TO_CHAR(CURR_DATE, 'MM')) || ' 월 ' 
            || TO_CHAR(CURR_DATE, 'DD') || ' 일 현재'      
            AS CUR_DATE --현재일(예>2011년 12월 31일 현재); 합잔에서 사용        
    FROM GL_FISCAL_YEAR
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FISCAL_YEAR = SUBSTR(W_PERIOD_TO, 1, 4)   ;                  

END PRINT_TITLE;






END FI_FS_IS_PARADE_G;
/
