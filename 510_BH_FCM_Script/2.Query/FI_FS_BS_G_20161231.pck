CREATE OR REPLACE PACKAGE FI_FS_BS_G
AS



/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FS_BS_G
Description  : 재무상태표 Package

Reference by : calling assmbly-program id(호출 프로그램) : FCMF0763(재무상태표)
Program History :
    1.FI_FS_BS 테이블의 값을 읽어 넘겨준다.
    2.참조1>재무상태표 출력 관련 구 테이블 : FI_BALANCE_BS
      참조2>FI_BALANCE_BS, FI_FS_BS : 2테이블 모두 GLOBAL TEMPORARY TABLE이다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-08-03   Leem Dong Ern(임동언)          
*****************************************************************************/


--Package 전역변수
t_FORM_TYPE_ID      FI_FORM_MST.FORM_TYPE_ID%TYPE   := 745;  --보고서양식ID(공통코드) : 재무상태표
t_LAST_ITEM_LEVEL   NUMBER := 0;    --조회된 자료 목록 중에서 최하위레벨을 구한다.




--재무상태표 grid에 조회되는 자료 추출
PROCEDURE LIST_BS( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_PERIOD_FROM     IN VARCHAR2                         --조회기간_시작
    , W_PERIOD_TO       IN VARCHAR2                         --조회기간_종료
);
 







--화면 그리드에 표시될 결산회기를 구한다.
PROCEDURE FISCAL_COUNT_F(
      O_FISCAL_COUNT    OUT GL_FISCAL_YEAR.FISCAL_COUNT%TYPE    --결산회기
    , W_SOB_ID          IN  GL_FISCAL_YEAR.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN  GL_FISCAL_YEAR.ORG_ID%TYPE          --사업부아이디
    , W_FISCAL_YEAR     IN  GL_FISCAL_YEAR.FISCAL_YEAR%TYPE     --회계년도   
);





--출력시 사용; 합잔, 제조, 손익, 재무상태표 4개 양식 공통
PROCEDURE PRINT_TITLE(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  GL_FISCAL_YEAR.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN  GL_FISCAL_YEAR.ORG_ID%TYPE          --사업부아이디
    , W_PERIOD_TO       IN VARCHAR2                             --조회기간_종료  
);





END FI_FS_BS_G;
/
CREATE OR REPLACE PACKAGE BODY FI_FS_BS_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FS_BS_G
Description  : 재무상태표 Package

Reference by : calling assmbly-program id(호출 프로그램) : FCMF0763(재무상태표)
Program History :
    1.FI_FS_BS 테이블의 값을 읽어 넘겨준다.
    2.참조1>재무상태표 출력 관련 구 테이블 : FI_BALANCE_BS
      참조2>FI_BALANCE_BS, FI_FS_BS : 2테이블 모두 GLOBAL TEMPORARY TABLE이다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-08-03   Leem Dong Ern(임동언)          
*****************************************************************************/



--재무상태표 grid에 조회되는 자료 추출
PROCEDURE LIST_BS( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_PERIOD_FROM     IN VARCHAR2                         --조회기간_시작(예>2011-01)
    , W_PERIOD_TO       IN VARCHAR2                         --조회기간_종료(예>2011-08)
)

AS

t_PERIOD_FROM           DATE := TO_DATE(W_PERIOD_FROM, 'YYYY-MM');          --당기의 조회기간_시작일, 2011/01/01 00:00:00
t_PERIOD_TO             DATE := LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM'));  --당기의 조회기간_종료일, 2011/08/31 00:00:00

t_FORWARD_AMOUNT        NUMBER := 0;   --이월금액

t_THIS_MNS_AMT          FI_FS_BS.THIS_MNS_AMT%TYPE := 0;    --당기_차감계정항목금액
calc_THIS_MNS_AMT       FI_FS_BS.THIS_MNS_AMT%TYPE := 0;    --당기_차감계정항목금액
t_PRE_MNS_AMT           FI_FS_BS.PRE_MNS_AMT%TYPE := 0;     --전기_차감계정항목금액
calc_PRE_MNS_AMT        FI_FS_BS.PRE_MNS_AMT%TYPE := 0;     --전기_차감계정항목금액

--t_CNT                   NUMBER  := 0;    --재고자산기말금액 자료존재 유무를 파악하기 위함.
--t_THIS_AMT              NUMBER  := 0;   --재고자산 당기 금액
--t_PRE_AMT               NUMBER  := 0;   --재고자산 전기 금액
t_THIS_NON_LAST_AMT     NUMBER  := 0;   --당기_최하위아닌레벨항목금액
t_PRE_NON_LAST_AMT      NUMBER  := 0;   --전기_최하위아닌레벨항목금액


t_RELATE_ITEM_CNT      NUMBER  := 0;   --1개의 계정에 연동항목이 2이상인 경우를 처리하기 위함





--제품(1120100), 상품(1120200) 계정 값을 보정한다.
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




--아래 변수들은 미처분이익잉여금 계정 값을 보정할 시에 사용한다.
TYPE TCURSOR IS REF CURSOR;
IS_TCURSOR TCURSOR;


BEGIN

--1단계>기준자료 설정, 기존 자료 삭제, 기본 틀 형성

    --기존 자료를 삭제한다.
    DELETE FI_FS_BS;

    --재무상태표를 조회하기 위한 기본틀을 만든다.
    INSERT INTO FI_FS_BS(
          ITEM_NAME	        --출력항목명
        , THIS_MNS_AMT	    --당기_차감계정항목금액
        , THIS_AMT	        --당기_계정별금액
        , PRE_MNS_AMT	    --전기_차감계정항목금액
        , PRE_AMT	        --전기_계정별금액
        , ITEM_CODE	        --항목코드_계정코드
        , ACCOUNT_DR_CR	    --차대구분(1-차변,2-대변)
        , SORT_SEQ	        --정렬순서
        , ITEM_LEVEL	    --금액계산레벨
        , ENABLED_FLAG	    --사용(표시)여부
        , FORM_FRAME_YN	    --보고서틀유지여부
        , FORM_ITEM_TYPE_CD --재고자산기말금액관리항목코드
        , MNS_ACCOUNT_FLAG	--차감계정여부(Y/N)
        , RELATE_ITEM_CODE	--(차감계정의)연동항목코드
    )
    SELECT
          ITEM_NAME         --출력항목명
        , 0 THIS_MNS_AMT	--당기_차감계정항목금액
        , 0 THIS_AMT	    --당기_계정별금액
        , 0 PRE_MNS_AMT	    --전기_차감계정항목금액
        , 0 PRE_AMT	        --전기_계정별금액        
        , ITEM_CODE         --항목코드_계정코드    
        , ACCOUNT_DR_CR     --차대구분(1-차변,2-대변)
        , SORT_SEQ          --정렬순서
        , ITEM_LEVEL        --금액계산레벨
        
        --N인 자료는 금액계산 시에는 사용되지만, 보고서에는 보여서는 안될 항목이다.
        --즉, N인 자료는 금액계산이 레벨에 의해 이뤄지는 체계를 유지하기 위해 임으로 가져가는 항목일 뿐이다.
        , ENABLED_FLAG      --사용(표시)여부
        
        --금액의 유무를 떠나서 아래 항목이 'Y'인 항목은 보고서의 틀을 유지하기 위해 무조건 출력되어야 할 항목이다.
        , FORM_FRAME_YN	        --보고서틀유지여부
        
        , FORM_ITEM_TYPE_CD	    --재고자산기말금액관리항목코드

        --재무상태계정들(자산, 부채, 자본)은 차감적평가계정들이 있다. 
        --이런 계정들에 대해 원하는 금액을 추출하기 위해 사용된다.
        , MNS_ACCOUNT_FLAG	--차감계정여부(Y/N)
        , RELATE_ITEM_CODE	--(차감계정의)연동항목코드                
    FROM FI_FORM_MST            --재무제표보고서양식_마스터
    WHERE SOB_ID = W_SOB_ID                 --회사아이디
        AND ORG_ID = W_ORG_ID               --사업부아이디
        AND FS_SET_ID = W_FS_SET_ID         --보고서기준세트아이디
        AND FORM_TYPE_ID = t_FORM_TYPE_ID   --보고서양식ID(공통코드)
    ORDER BY SORT_SEQ    
    ;    

    --재무상태표에 등록된 최하위레벨을 구한다.
    t_LAST_ITEM_LEVEL := FI_FORM_DET_G.LAST_ITEM_LEVEL_F(W_SOB_ID, W_ORG_ID, W_FS_SET_ID, t_FORM_TYPE_ID);  


/*
--2단계> 최하위레벨의 금액을 구한다.
    1.전기이월금액을 구한다.
    2.해당 기(조회기간_시작일 ~ 조회기간_종료일)의 금액을 구한다.
    3.해당 기의 차감계정항목금액을 구한다.
--최하위레벨의 금액은 상세 계정의 합이다. 하여, 굳이 재무제표양식의 연산부호를 참조하지 않는다.
--만약, 최하위레벨 항목의 상세 항목에 대해 재무제표양식의 연산부호가 [+]가 아닌 게 있을 경우는 이를 수정해야 한다.
*/

    --전기이월자료 추출
    FI_FS_SLIP_G.CREATE_FS_SLIP_BLS(
          W_SOB_ID
        , W_ORG_ID
        , W_FS_SET_ID
        , t_FORM_TYPE_ID
        , t_LAST_ITEM_LEVEL
        , SUBSTR(W_PERIOD_FROM, 1, 4)   );
        
                
    --기간내의 해당 계정의 금액을 분개자료에서 구한다. 
    FI_FS_SLIP_BS_G.CREATE_FS_SLIP_BS(
          W_SOB_ID
        , W_ORG_ID
        , W_FS_SET_ID
        , t_FORM_TYPE_ID
        , t_LAST_ITEM_LEVEL
        , t_PERIOD_FROM
        , t_PERIOD_TO   );        


    FOR LAST_LEVEL_REC IN (
        SELECT          
              ITEM_CODE	    --항목코드
            , ACCOUNT_DR_CR	--차대구분(1-차변,2-대변)           
        FROM FI_FS_BS
        WHERE ITEM_LEVEL = t_LAST_ITEM_LEVEL    
    ) LOOP               
                
        --2단계-1>당기금액을 구한다. 

        --변수 초기화
        t_FORWARD_AMOUNT    := 0;   --이월금액            
        t_THIS_MNS_AMT      := 0;   --당기_차감계정항목금액
               
        --1>전기이월금액을 구한다.             
        SELECT SUM(DR_AMT) AS AMT
        INTO t_FORWARD_AMOUNT
        FROM FI_FS_SLIP
        WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
        GROUP BY ITEM_CODE;


        --2>당기(조회기간_시작일 ~ 조회기간_종료일)의 금액을 구한다.      
       
        IF LAST_LEVEL_REC.ACCOUNT_DR_CR = '1' THEN      --해당 계정이 차변계정이면
            SELECT t_FORWARD_AMOUNT + SUM(DR_AMT) - SUM(CR_AMT) AS AMT
            INTO t_THIS_MNS_AMT
            FROM FI_FS_SLIP_BS
            WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
            GROUP BY ITEM_CODE;
        ELSIF LAST_LEVEL_REC.ACCOUNT_DR_CR = '2' THEN   --해당 계정이 대변계정이면
            SELECT t_FORWARD_AMOUNT + SUM(CR_AMT) - SUM(DR_AMT) AS AMT
            INTO t_THIS_MNS_AMT
            FROM FI_FS_SLIP_BS
            WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
            GROUP BY ITEM_CODE;                
        END IF;                        
                    
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_THIS_MNS_AMT    --당기_차감계정항목금액
        WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE;
        

        --2단계-2>전기금액을 구한다.

        --변수 초기화
        t_FORWARD_AMOUNT    := 0;   --이월금액      
        t_THIS_MNS_AMT      := 0;   --당기_차감계정항목금액
               
        --1>전기이월금액을 구한다.             
        SELECT SUM(CR_AMT) AS AMT
        INTO t_FORWARD_AMOUNT
        FROM FI_FS_SLIP
        WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
        GROUP BY ITEM_CODE;


        --2>전기(조회기간_시작일 ~ 조회기간_종료일)의 금액을 구한다.

        IF LAST_LEVEL_REC.ACCOUNT_DR_CR = '1' THEN      --해당 계정이 차변계정이면
            SELECT t_FORWARD_AMOUNT + SUM(PRE_DR_AMT) - SUM(PRE_CR_AMT) AS AMT
            INTO t_THIS_MNS_AMT
            FROM FI_FS_SLIP_BS
            WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
            GROUP BY ITEM_CODE;
        ELSIF LAST_LEVEL_REC.ACCOUNT_DR_CR = '2' THEN   --해당 계정이 대변계정이면
            SELECT t_FORWARD_AMOUNT + SUM(PRE_CR_AMT) - SUM(PRE_DR_AMT) AS AMT
            INTO t_THIS_MNS_AMT
            FROM FI_FS_SLIP_BS
            WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
            GROUP BY ITEM_CODE;                
        END IF; 

        UPDATE FI_FS_BS
        SET   PRE_MNS_AMT  = t_THIS_MNS_AMT --전기_차감계정항목금액
        WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE;

    END LOOP LAST_LEVEL_REC;












--손익계산서 자료를 가져와서 
--제품(1120100), 상품(1120200), 미처분이익잉여금(3500100) 계정 값을 보정한다.
--가.당기분 보정

    --손익계산서 테이블에서 당기의 자료를 가져온다. 
    FI_FS_IS_PARADE_G.LIST_IS(
          IS_TCURSOR
        , W_SOB_ID                              --회사아이디
        , W_ORG_ID                              --사업부아이디
        , W_FS_SET_ID                           --보고서기준세트아이디
        , SUBSTR(W_PERIOD_FROM, 1, 4)           --결산년
        , 'M'                                   --자료구분(M : 월, Q : 분기, H : 반기, Y : 년)
        , 'M01'                                 --조회 시작월(예> M01 : 1월인경우)
        , 'M' || SUBSTR(W_PERIOD_TO, 6, 2)      --조회 종료월(예> M06 : 6월인경우)  
    );



    --당기의 제품(1120100), 상품(1120200) 계정 값을 보정한다.

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
        , NVL(LAST_LEVEL_AMT_12, 0) - 1073595591   -- 김대영K :: 재고자산 폐기 금액 강제 반영.... 
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



    --제품(1120100)
    --당기_차감계정항목금액 COLUMN을 UPDATE한다.
    IF SUBSTR(W_PERIOD_TO, 6, 2) = '01' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_01 
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '02' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_02
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '03' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_03
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '04' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_04
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '05' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_05
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '06' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_06
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '07' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_07
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '08' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_08
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '09' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_09
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '10' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_10
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '11' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_11
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '12' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_12
        WHERE ITEM_CODE = '1120100';        
    END IF;


    --상품(1120200)
    --당기_차감계정항목금액 COLUMN을 UPDATE한다.
    
    IF SUBSTR(W_PERIOD_TO, 6, 2) = '01' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_01 
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '02' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_02
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '03' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_03
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '04' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_04
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '05' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_05
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '06' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_06
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '07' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_07
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '08' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_08
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '09' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_09
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '10' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_10
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '11' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_11
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '12' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_12
        WHERE ITEM_CODE = '1120200';        
    END IF;  






    --미처분이익잉여금 계정 값을 보정한다.
    --이렇게 임의로 값을 보정하는 이유는 당기순이익은 미처분이익잉여금 계정으로 전표 등록을 하지 않기 때문이다.
    --같은 사유로 당기이월(매년 말에 하는 이월작업을 말한다.) 시에도 미처분이익잉여금 계정은 값을 추출해서 이월해야 한다.
       
    SELECT LAST_LEVEL_AMT_SUM
    INTO t_THIS_NON_LAST_AMT
    FROM FI_FS_IS_PARADE
    WHERE ITEM_CODE = '15';


    --재무상태표의 당기의 미처분이익잉여금 값을 설정한다.
    UPDATE FI_FS_BS
    SET   THIS_MNS_AMT = THIS_MNS_AMT + t_THIS_NON_LAST_AMT
    WHERE ITEM_CODE = '3500100';
    







--손익계산서 자료를 가져와서 
--제품(1120100), 상품(1120200), 미처분이익잉여금(3500100) 계정 값을 보정한다.
--가.전기분 보정
   
    --손익계산서 테이블에서 전기의 자료를 가져온다. 
    FI_FS_IS_PARADE_G.LIST_IS(
          IS_TCURSOR
        , W_SOB_ID                          --회사아이디
        , W_ORG_ID                          --사업부아이디
        , W_FS_SET_ID                       --보고서기준세트아이디
        , SUBSTR(W_PERIOD_FROM, 1, 4) - 1   --결산년
        , 'M'                               --자료구분(M : 월, Q : 분기, H : 반기, Y : 년)
        , 'M01'                             --조회 시작월(예> M01 : 01월인경우)
        , 'M12'                             --조회 종료월(예> M12 : 12월인경우)  
    );



    --전기의 제품(1120100), 상품(1120200) 계정 값을 보정한다.
    --전기자료는 당기와는 달리 무조건 12월 자료를 가져온다.

    SELECT NVL(LAST_LEVEL_AMT_12, 0)
    INTO t_ITEM_AMT_12   --기말상품재고액(12월)        
    FROM FI_FS_IS_PARADE
    WHERE ITEM_CODE = '5'; 
    

    SELECT  NVL(LAST_LEVEL_AMT_12, 0)           
    INTO t_PRODUCT_AMT_12   --기말제품재고액(12월)        
    FROM FI_FS_IS_PARADE
    WHERE ITEM_CODE = '8';



    --제품(1120100)
    --전기_차감계정항목금액 COLUMN을 UPDATE한다.
    UPDATE FI_FS_BS
    SET   PRE_MNS_AMT  = t_PRODUCT_AMT_12
    WHERE ITEM_CODE = '1120100';     


    --상품(1120200)
    --전기_차감계정항목금액 COLUMN을 UPDATE한다.
    UPDATE FI_FS_BS
    SET   PRE_MNS_AMT  = t_ITEM_AMT_12
    WHERE ITEM_CODE = '1120200';      


       
    SELECT LAST_LEVEL_AMT_SUM
    INTO t_PRE_NON_LAST_AMT
    FROM FI_FS_IS_PARADE
    WHERE ITEM_CODE = '15';


    --재무상태표의 전기의 미처분이익잉여금 값을 설정한다.
    UPDATE FI_FS_BS
    SET   PRE_MNS_AMT  = PRE_MNS_AMT  + t_PRE_NON_LAST_AMT
    WHERE ITEM_CODE = '3500100';     











--4단계>최하위레벨이 아닌 항목들에 대한 금액을 구한다.
--금액계산레벨이 큰 것 부터 순차적으로 금액을 구한다. 예>4레벨 부터 1레벨 까지
    FOR NO_LAST_REC IN (
        SELECT           
              ITEM_CODE	    --항목코드
            , ACCOUNT_DR_CR	--차대구분(1-차변,2-대변)
        FROM FI_FS_BS
        WHERE ITEM_LEVEL < t_LAST_ITEM_LEVEL
        ORDER BY ITEM_LEVEL DESC
    ) LOOP

        --변수 초기화
        t_THIS_MNS_AMT  := 0;   --당기_차감계정항목금액
        t_PRE_MNS_AMT   := 0;   --전기_차감계정항목금액

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
        
            SELECT
                    NVL(THIS_MNS_AMT, 0)    --당기_차감계정항목금액               
                  , NVL(PRE_MNS_AMT, 0)     --전기_차감계정항목금액
            INTO
                    calc_THIS_MNS_AMT   --당기_차감계정항목금액
                  , calc_PRE_MNS_AMT    --전기_차감계정항목금액
            FROM FI_FS_BS
            WHERE ITEM_CODE = CALC_REC.DET_ITEM_CODE
            ;
                        
            t_THIS_MNS_AMT  := t_THIS_MNS_AMT + (calc_THIS_MNS_AMT * CALC_REC.ITEM_SIGN_SHOW);  --당기_차감계정항목금액 
            t_PRE_MNS_AMT   := t_PRE_MNS_AMT + (calc_PRE_MNS_AMT * CALC_REC.ITEM_SIGN_SHOW);    --당기_차감계정항목금액 
        
        END LOOP CALC_REC; 
        
        
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_THIS_MNS_AMT
            , PRE_MNS_AMT   = t_PRE_MNS_AMT
        WHERE ITEM_CODE = NO_LAST_REC.ITEM_CODE ;
    
    END LOOP NO_LAST_REC;












--5단계> 차감계정이 아닌 항목들의 자료를 보정한다.
--차감계정이 아닌 항목들은 그 값이 각 기의 2번째 칼럼에 찍혀야 한다.
--단, 차감계정은 아니지만 차감계정과 연관된 계정들은 제외한다.

    FOR NO_MNS_REC_ADJUST IN (
        SELECT           
                ITEM_CODE	    --항목코드
        FROM FI_FS_BS
        WHERE DECODE(MNS_ACCOUNT_FLAG, 'Y', 'Y', 'N') = 'N' --차감계정이 아닌 항목들의 자료
            AND ITEM_CODE NOT IN 
                (   --단, 차감계정은 아니지만 차감계정과 연관된 계정들은 제외한다.
                    SELECT RELATE_ITEM_CODE
                    FROM FI_FS_BS
                    WHERE DECODE(MNS_ACCOUNT_FLAG, 'Y', 'Y', 'N') = 'Y' --차감계정인 항목들의 자료
                        AND (THIS_MNS_AMT <> 0 OR THIS_AMT <> 0 
                            OR PRE_MNS_AMT <> 0  OR PRE_AMT <> 0 )
                ) --차감계정으로 사용되는 계정은 제외한다.
    ) LOOP
   
        UPDATE FI_FS_BS
        SET   THIS_AMT = THIS_MNS_AMT   --당기_계정별금액
            , PRE_AMT  = PRE_MNS_AMT    --전기_계정별금액
        WHERE ITEM_CODE = NO_MNS_REC_ADJUST.ITEM_CODE;
        
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT = 0  --당기_차감계정항목금액
            , PRE_MNS_AMT  = 0  --전기_차감계정항목금액
        WHERE ITEM_CODE = NO_MNS_REC_ADJUST.ITEM_CODE;           

    END LOOP NO_MNS_REC_ADJUST;






--6단계> 차감계정인 항목들의 자료를 보정한다.
--차감계정인 항목들은 그 값이 각 기의 2번째 칼럼에 찍혀야 한다.

    FOR MNS_REC_ADJUST IN (
        SELECT           
              ITEM_CODE	        --항목코드
            , THIS_MNS_AMT      --당기_차감계정항목금액
            , PRE_MNS_AMT       --전기_차감계정항목금액
            , RELATE_ITEM_CODE  --(차감계정의)연동항목코드
        FROM FI_FS_BS
        WHERE DECODE(MNS_ACCOUNT_FLAG, 'Y', 'Y', 'N') = 'Y' --차감계정인 항목들의 자료
    ) LOOP
    
        --변수초기화
        t_THIS_MNS_AMT  := 0;
        t_PRE_MNS_AMT   := 0;
        
                
        SELECT NVL(THIS_MNS_AMT, 0), NVL(PRE_MNS_AMT, 0)
        INTO t_THIS_MNS_AMT, t_PRE_MNS_AMT
        FROM FI_FS_BS
        WHERE ITEM_CODE = MNS_REC_ADJUST.RELATE_ITEM_CODE   ;
        
        
        --1개의 계정에 연동항목이 2이상인 경우를 처리하기 위함; 2011.09.26일 보정함.
        --보정사유 : 비유동자산 > 유형자산 > 건물등은 평가계정이 감가상각누계액과 국고보조금의 2개 계정이 있어서이다.
        SELECT COUNT(*)
        INTO t_RELATE_ITEM_CNT
        FROM FI_FS_BS
        WHERE RELATE_ITEM_CODE = MNS_REC_ADJUST.RELATE_ITEM_CODE;
        
        IF t_RELATE_ITEM_CNT > 1 THEN   --1개의 계정에 연동항목이 2이상인 경우
            --이 경우는 연동항목이 2개 이상이므로 연동항목에 자산의 현재 시점 금액을 설정하지 않고, 모계정에 설정함.
            
            --자기자신은 '0'으로 설정한다.    
            UPDATE FI_FS_BS
            SET   THIS_AMT = 0   --당기_계정별금액
                , PRE_AMT  = 0     --전기_계정별금액
            WHERE ITEM_CODE = MNS_REC_ADJUST.ITEM_CODE  ; 
            
            --모 계정의 2번째 칼럼에 모계정의 금액에서 평가계정의 금액들을 차감한 후의 금액을 설정한다.
            UPDATE FI_FS_BS
            SET   THIS_AMT = THIS_MNS_AMT - 
                        (
                            SELECT SUM(THIS_MNS_AMT)
                            FROM FI_FS_BS
                            WHERE RELATE_ITEM_CODE = MNS_REC_ADJUST.RELATE_ITEM_CODE
                        )   --당기_계정별금액
                , PRE_AMT  = PRE_MNS_AMT - 
                        (
                            SELECT SUM(PRE_MNS_AMT)
                            FROM FI_FS_BS
                            WHERE RELATE_ITEM_CODE = MNS_REC_ADJUST.RELATE_ITEM_CODE                        
                        )     --전기_계정별금액
            WHERE ITEM_CODE = MNS_REC_ADJUST.RELATE_ITEM_CODE  ;            
                
        ELSE    --1개의 계정에 연동항목이 1개인 경우
            --이 경우는 연동항목에 모 항목과의 금액의 차이인 모 자산의 현재 시점 금액을 설정함.
            UPDATE FI_FS_BS
            SET   THIS_AMT = t_THIS_MNS_AMT - MNS_REC_ADJUST.THIS_MNS_AMT   --당기_계정별금액
                , PRE_AMT  = t_PRE_MNS_AMT - MNS_REC_ADJUST.PRE_MNS_AMT     --전기_계정별금액
            WHERE ITEM_CODE = MNS_REC_ADJUST.ITEM_CODE  ;          
        END IF;                        

    END LOOP MNS_REC_ADJUST;


 



--7단계> 보고서틀유지여부 자료를 아무 값이 없는 걸로 보정한다.
    UPDATE FI_FS_BS
    SET   THIS_MNS_AMT  = DECODE(THIS_MNS_AMT,  0, NULL, THIS_MNS_AMT)
        , THIS_AMT      = DECODE(THIS_AMT,      0, NULL, THIS_AMT)
        , PRE_MNS_AMT   = DECODE(PRE_MNS_AMT,   0, NULL, PRE_MNS_AMT)
        , PRE_AMT       = DECODE(PRE_AMT,       0, NULL, PRE_AMT)
    WHERE FORM_FRAME_YN = 'Y';
    






--8단계>재무상태표를 조회한다.
    OPEN P_CURSOR FOR
    
       
    SELECT
          A.ITEM_NAME     --계정과목; 출력항목명
        , A.THIS_MNS_AMT  --당기금액; 당기_차감계정항목금액
        --, A.THIS_AMT  --당기금액; 당기_계정별금액
        , DECODE(UPPER(B.REMARKS), 'MINUS', '(' || TO_CHAR(A.THIS_AMT, 'FM999,999,999,999,999') || ')', TO_CHAR(A.THIS_AMT, 'FM999,999,999,999,999')) AS THIS_AMT      --당기금액; 당기_계정별금액
        , A.PRE_MNS_AMT   --전기금액; 전기_차감계정항목금액
        --, A.PRE_AMT       --전기금액; 전기_계정별금액
        , DECODE(UPPER(B.REMARKS), 'MINUS', '(' || TO_CHAR(A.PRE_AMT, 'FM999,999,999,999,999') || ')', TO_CHAR(A.PRE_AMT, 'FM999,999,999,999,999')) AS PRE_AMT      --전기금액; 전기_계정별금액
          
        , A.ITEM_CODE	        --항목코드_계정코드        
        , A.ACCOUNT_DR_CR	    --차대구분코드(1-차변,2-대변)
        , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', A.ACCOUNT_DR_CR, W_SOB_ID) AS ACCOUNT_DR_CR_NAME   --차대구분
        , A.SORT_SEQ          --정렬순서
        , A.ITEM_LEVEL	    --금액계산레벨; 항목레벨
        , A.ENABLED_FLAG      --사용(표시)여부
        , A.FORM_FRAME_YN     --보고서틀유지여부        
        , A.FORM_ITEM_TYPE_CD --재고자산기말금액관리항목코드
        , A.MNS_ACCOUNT_FLAG	--차감계정여부(Y/N)
        , A.RELATE_ITEM_CODE	--(차감계정의)연동항목코드                
        , A.REF_FORM_TYPE_ID	--관련보고서양식ID(공통코드)
        , A.REF_ITEM_CODE     --관련항목코드        
    FROM FI_FS_BS A
    , 
        (SELECT ITEM_CODE, REMARKS
         FROM FI_FORM_MST 
         WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND FS_SET_ID = W_FS_SET_ID
            AND FORM_TYPE_ID = t_FORM_TYPE_ID
            AND UPPER(REMARKS) = 'MINUS'
        ) B        
    WHERE (A.FORM_FRAME_YN = 'Y' OR
        (A.ENABLED_FLAG = 'Y'    --보고서에 출렬할 항목만 나오도록 함.    
            --화면에 보이는 4개의 금액 항목이 모두 0 인 자료는 보이지 않게 하기 위함.
            AND (A.THIS_MNS_AMT <> 0 OR A.THIS_AMT <> 0 
                OR A.PRE_MNS_AMT <> 0  OR A.PRE_AMT <> 0 )                
        ))
        AND A.ITEM_CODE = B.ITEM_CODE(+)
    ORDER BY SORT_SEQ;    


    EXCEPTION
        WHEN OTHERS THEN
           --작업중 오류가 발생하였습니다. 확인바랍니다.
           --RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');         
            NULL;

END LIST_BS;







--화면 그리드에 표시될 결산회기를 구한다.
PROCEDURE FISCAL_COUNT_F(
      O_FISCAL_COUNT    OUT GL_FISCAL_YEAR.FISCAL_COUNT%TYPE    --결산회기
    , W_SOB_ID          IN  GL_FISCAL_YEAR.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN  GL_FISCAL_YEAR.ORG_ID%TYPE          --사업부아이디
    , W_FISCAL_YEAR     IN  GL_FISCAL_YEAR.FISCAL_YEAR%TYPE     --회계년도   
)

AS


BEGIN
    
    SELECT FISCAL_COUNT
    INTO O_FISCAL_COUNT
    FROM GL_FISCAL_YEAR
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FISCAL_YEAR = SUBSTR(W_FISCAL_YEAR, 1, 4)   ;                 

END FISCAL_COUNT_F;








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




END FI_FS_BS_G;
/
