CREATE OR REPLACE PACKAGE FI_VAT_AP_AR_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_VAT_AP_AR_G
Description  : 매입매출장 Package

Reference by : calling assmbly-program id(호출 프로그램) : FCMF0865(매입매출장)
Program History : 
    매입매출장 프로그램은 기존에도 있었다. 이는 FI_VAT_MASTER[세금계산서명세(매입/매출장)] 테이블을 기반으로 하였다.
    그러나, 이는 전표테이블에서 TRIGGER를 통해 생성된 자료를 바탕으로 하였는데, 이 TRIGGER 부분이 불완전하여
    정합성이 보장되지 않아 새로이 개발하게 되었다.
    
    새로 개발하면서 나는 FI_VAT_MASTER 테이블을 사용하지 않고, 전표 테이블(FI_SLIP_LINE)에서 직접 자료를 추출하였다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-06   Leem Dong Ern(임동언)          
*****************************************************************************/




/*

--부가세대급금(1111700), 부가세예수금(2100700)
--아래는 위의 2계정에 대한 관리항목을 정리한 것이다.

가.부가세대급금(1111700)
1.거래처(01)             --MANAGEMENT1
2.사업장(10)             --MANAGEMENT2
3.세무유형(14)           --REFER1
4.신고기준일자(17)       --REFER2
5.사유구분(12)           --REFER3
6.결제카드(02)           --REFER4
7.공급가액(06)           --REFER5
8.전자세금계산서여부(25) --REFER6
9.현금영수증승인번호(30) --REFER7
10.세액(15)              --REFER8
11.예정신고누락분여부(36)--REFER9
12.고정자산과표(04)      --REFER10
12.고정자산세액(05)      --REFER11


나.부가세예수금(2100700)
1.거래처(01)                         --MANAGEMENT1
2.세무유형(33)                       --MANAGEMENT2
3.신고기준일자(17)                   --REFER1
4.공급가액(06)                       --REFER2
5.통화(31)                           --REFER3
6.수출신고번호(16)                   --REFER4
7.외화금액(22)                       --REFER5
8.환율(34)                           --REFER6
9.전자세금계산서여부(25)             --REFER7
10.세액(15)                          --REFER8
11.예정신고누락분여부(36)            --REFER9
12.수정전자세금계산서사유구분(37)    --REFER10
13.사업장(10)                        --REFER11

*/



--매입/매출장_조회
--거래처코드와 세무유형코드는 과거에는 아이디로 했던건데, 직관적으로 코드로 대체했다.
--이 코드로 대체된건 문제는 없다. 그러나 혹여 이 코드로 인해 향후 원하는 값이 조회되지 않을 시
--과거 PROCEDURE를 참조해라. 과거 PROCEDURE : FI_VAT_MASTER.LIST_VAT_MASTER
PROCEDURE LIST_VAT( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_SLIP_LINE.SOB_ID%TYPE     --회사아이디
    , W_ORG_ID          IN FI_SLIP_LINE.ORG_ID%TYPE     --사업부아이디
    , W_TAX_CODE        IN VARCHAR2                     --사업장
    , W_ISSUE_DATE_FR   IN DATE                         --신고기간_시작
    , W_ISSUE_DATE_TO   IN DATE                         --신고기간_종료
    , W_SUPPLIER_CODE   IN VARCHAR2                     --거래처코드
    , W_VAT_CLASS       IN VARCHAR2                     --거래구분(1:매입, 2:매출)
    , W_VAT_TYPE        IN VARCHAR2                     --세무유형코드  
);





END FI_VAT_AP_AR_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_AP_AR_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_VAT_AP_AR_G
Description  : 매입매출장 Package

Reference by : calling assmbly-program id(호출 프로그램) : FCMF0865(매입매출장)
Program History : 
    매입매출장 프로그램은 기존에도 있었다. 이는 FI_VAT_MASTER[세금계산서명세(매입/매출장)] 테이블을 기반으로 하였다.
    그러나, 이는 전표테이블에서 TRIGGER를 통해 생성된 자료를 바탕으로 하였는데, 이 TRIGGER 부분이 불완전하여
    정합성이 보장되지 않아 새로이 개발하게 되었다.
    
    새로 개발하면서 나는 FI_VAT_MASTER 테이블을 사용하지 않고, 전표 테이블(FI_SLIP_LINE)에서 직접 자료를 추출하였다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-06   Leem Dong Ern(임동언)          
*****************************************************************************/





--매입/매출장_조회
--거래처코드와 세무유형코드는 과거에는 아이디로 했던건데, 직관적으로 코드로 대체했다.
--이 코드로 대체된건 문제는 없다. 그러나 혹여 이 코드로 인해 향후 원하는 값이 조회되지 않을 시
--과거 PROCEDURE를 참조해라. 과거 PROCEDURE : FI_VAT_MASTER.LIST_VAT_MASTER
PROCEDURE LIST_VAT( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_SLIP_LINE.SOB_ID%TYPE     --회사아이디
    , W_ORG_ID          IN FI_SLIP_LINE.ORG_ID%TYPE     --사업부아이디
    , W_TAX_CODE        IN VARCHAR2                     --사업장
    , W_ISSUE_DATE_FR   IN DATE                         --신고기간_시작
    , W_ISSUE_DATE_TO   IN DATE                         --신고기간_종료
    , W_SUPPLIER_CODE   IN VARCHAR2                     --거래처코드
    , W_VAT_CLASS       IN VARCHAR2                     --거래구분(1:매입, 2:매출)
    , W_VAT_TYPE        IN VARCHAR2                     --세무유형코드  
)

AS

BEGIN

    IF    W_VAT_CLASS = '1' THEN    --매입, 부가세대급금(1111700)
    
        OPEN P_CURSOR FOR

        SELECT             
              DECODE(GROUPING(A.SOB_ID), 1, NULL, '매입') AS VAT_CLASS    --거래구분; 부가세대급금(1111700)
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, A.REFER1) AS VAT_TYPE   --세무유형코드

            --EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL) 
            -- => 이 프로젝트에서는 이런 방식을 이용하여 message를 처리하고 있다. 
            , CASE
                WHEN GROUPING(A.REFER1) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL)  --<< 총 합계 >>
                WHEN GROUPING(A.SOB_ID) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL)  --< 소 계 >
                ELSE FI_COMMON_G.CODE_NAME_F('VAT_TYPE_AP', A.REFER1, A.SOB_ID, A.ORG_ID)
              END AS VAT_TYPE_NAME   ----세무유형                           
            
            , A.REFER3 AS VAT_REASON_CODE                                                               --사유구분코드
            , FI_COMMON_G.CODE_NAME_F('VAT_REASON', A.REFER3, A.SOB_ID, A.ORG_ID) AS VAT_REASON_NAME    --사유구분
            , A.MANAGEMENT1 AS SUPPLIER_CODE                --거래처코드
            , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --거래처명
            , B.TAX_REG_NO AS TAX_REG_NO                    --사업자번호
            , A.REFER2 AS VAT_ISSUE_DATE                    --신고기준일자
            , TO_CHAR(A.GL_DATE, 'YYYY-MM-DD') AS GL_DATE   --전표일자
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, 
                        CASE
                            WHEN A.REFER2 = TO_CHAR(A.GL_DATE, 'YYYY-MM-DD') THEN 'N'
                            ELSE 'Y'
                        END    
                   ) AS DATE_CHECK   --일자확인여부(신고기준일자 VS 전표일자)
              
            --아래에서 TRIM, REPLACE를 쓴 이유는 과거 프로그램의 정합성 보장이 안되어 자료가 잘 못 입력된게 있어서이다.
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액    
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, 
                        CASE
                            WHEN ABS(ABS(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '') * 0.1) - ABS(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) > 20 THEN 'Y'
                            ELSE 'N'
                        END    
                   ) AS AMOUNT_CHECK  --오차범위(공급가액 * 0.1 VS 세액의 차이가 20이상인 경우)
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '') + REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS TOTAL_AMOUNT   --합계 = 공급가액 + 세액
            , SUM(TO_NUMBER(REPLACE(TRIM(A.REFER10), ',', ''))) AS ASSET_BASE   --고정자산과표
            , SUM(TO_NUMBER(REPLACE(TRIM(A.REFER11), ',', ''))) AS ASSET_TAX    --고정자산세액            
            , NULL AS MODIFY_REASON_CODE    --수정전자세금계산서사유구분코드
            , NULL AS MODIFY_REASON         --수정전자세금계산서사유구분
            , A.REFER4 AS CREDITCARD_CODE                                               --신용카드코드(X)    
            , FI_CREDIT_CARD_G.CARD_NUM_F(A.SOB_ID, A.REFER4, A.ORG_ID) AS CARD_NUM     --신용카드번호
            , FI_CREDIT_CARD_G.CARD_NAME_F(A.SOB_ID, A.REFER4, A.ORG_ID) AS CARD_NAME   --신용카드명(X)
            , NULL AS EXPORT_NO                                                         --수출신고번호    
            , A.REFER7 AS CASH_RECEIPT_NUM                                              --현금영수증승인번호
            , NULL AS CURRENCY_CODE                                                     --통화
            , TO_NUMBER(NULL) AS EXCHANGE_RATE                                          --환율
            , TO_NUMBER(NULL) AS CURRENCY_AMOUNT                                        --외화금액
            , A.REFER6 AS ELEC_TAX_YN                                                   --전자세금계산서여부        
            , A.REMARK                                                                  --전표적요
            , A.GL_NUM                                                                  --전표번호
            
            --아래 내용은 불필요할 듯 한데 전표조회를 할 시 기존에 이런 방식으로 한듯하여 적었다.
            , TO_NUMBER(A.SLIP_LINE_ID) AS SLIP_LINE_ID                                 --전표 라인 ID(X) 
            , TO_CHAR(A.SLIP_HEADER_ID) AS SLIP_HEADER_ID                               --전표헤더아이디(X)               
        FROM FI_SLIP_LINE A
            , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --거래처
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            
            AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
            /* 향후 계정과목관리 프로그램에서의 계정타입을 이용한 부가세 계정의 확장이 발생하면 위 문장 대신 사용하면 된다.
            AND A.ACCOUNT_CODE IN 
                (
                    SELECT ACCOUNT_CODE
                    FROM FI_ACCOUNT_CONTROL
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CLASS_ID = '1832'   --계정타입 : 부가세대급금                        
                )  --거래구분(매입/매출)              
            */
            
            AND A.MANAGEMENT2 = W_TAX_CODE                                      --사업장
            AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
            AND MANAGEMENT1 = NVL(W_SUPPLIER_CODE, MANAGEMENT1)                 --거래처
            AND REFER1 = NVL(W_VAT_TYPE, REFER1)                                --세무유형
            
            AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)      
        GROUP BY ROLLUP( A.REFER1
                , (   A.SOB_ID, A.ORG_ID, B.SUPP_CUST_NAME, TAX_REG_NO, GL_DATE, A.MANAGEMENT1, A.MANAGEMENT2 
                    , A.REFER2, A.REFER3, A.REFER4, A.REFER5, A.REFER6, A.REFER7, A.REFER8, A.REFER10, A.REFER11
                    , REMARK, GL_NUM, SLIP_LINE_ID, SLIP_HEADER_ID
                  )    )  ;
     
    ELSIF W_VAT_CLASS = '2' THEN    --매출, 부가세예수금(2100700)

        OPEN P_CURSOR FOR

        SELECT
              DECODE(GROUPING(A.SOB_ID), 1, NULL, '매출') AS VAT_CLASS          --거래구분; 부가세예수금(2100700)            
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, A.MANAGEMENT2) AS VAT_TYPE    --세무유형코드           
            , CASE
                WHEN GROUPING(A.MANAGEMENT2) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL) --<< 총 합계 >>
                WHEN GROUPING(A.SOB_ID) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL)      --< 소 계 >
                ELSE FI_COMMON_G.CODE_NAME_F('VAT_TYPE_AR', A.MANAGEMENT2, A.SOB_ID, A.ORG_ID)
              END AS VAT_TYPE_NAME   ----세무유형              
            , NULL AS VAT_REASON_CODE                       --사유구분코드
            , NULL AS VAT_REASON_NAME                       --사유구분
            , A.MANAGEMENT1 AS SUPPLIER_CODE                --거래처코드
            , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --거래처명
            , B.TAX_REG_NO AS TAX_REG_NO                    --사업자번호
            , A.REFER1 AS VAT_ISSUE_DATE                    --신고기준일자
            , TO_CHAR(A.GL_DATE, 'YYYY-MM-DD') AS GL_DATE   --전표일자            
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, 
                CASE
                    WHEN A.REFER1 = TO_CHAR(A.GL_DATE, 'YYYY-MM-DD') THEN 'N'
                    ELSE 'Y'
                END    
              ) AS DATE_CHECK   --일자확인여부(신고기준일자 VS 전표일자) 
             
            --아래에서 TRIM, REPLACE를 쓴 이유는 과거 프로그램의 정합성 보장이 안되어 자료가 잘 못 입력된게 있어서이다.
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액 
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, 
                CASE
                    WHEN ABS(ABS(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', '') * 0.1) - ABS(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) > 20 THEN 'Y'
                    ELSE 'N'
                END    
              ) AS AMOUNT_CHECK  --오차범위(공급가액 * 0.1 VS 세액의 차이가 20이상인 경우)
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', '') + REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS TOTAL_AMOUNT   --합계 = 공급가액 + 세액              

            , TO_NUMBER(NULL) AS ASSET_BASE     --고정자산과표
            , TO_NUMBER(NULL) AS ASSET_TAX      --고정자산세액
            , A.REFER10 AS MODIFY_REASON_CODE   --수정전자세금계산서사유구분코드
            , FI_COMMON_G.CODE_NAME_F('MODIFY_TAX_REASON', A.REFER10, A.SOB_ID, A.ORG_ID) AS MODIFY_REASON    --수정전자세금계산서사유구분
            , NULL AS CREDITCARD_CODE   --신용카드코드(X)    
            , NULL AS CARD_NUM          --신용카드번호
            , NULL AS CARD_NAME         --신용카드명(X)
            , A.REFER4 AS EXPORT_NO     --수출신고번호    
            , NULL AS CASH_RECEIPT_NUM  --현금영수증승인번호
            , A.REFER3 AS CURRENCY_CODE --통화
            , TO_NUMBER(DECODE(GROUPING(A.SOB_ID), 1, NULL, REPLACE(TRIM(A.REFER6), ',', ''))) AS EXCHANGE_RATE     --환율
            , TO_NUMBER(DECODE(GROUPING(A.SOB_ID), 1, NULL, REPLACE(TRIM(A.REFER5), ',', ''))) AS CURRENCY_AMOUNT   --외화금액             
            , A.REFER7 AS ELEC_TAX_YN                                                   --전자세금계산서여부        
            , A.REMARK                                                                  --전표적요
            , A.GL_NUM                                                                  --전표번호
            
            --아래 내용은 불필요할 듯 한데 전표조회를 할 시 기존에 이런 방식으로 한듯하여 적었다.
            , TO_NUMBER(A.SLIP_LINE_ID) AS SLIP_LINE_ID                                 --전표 라인 ID(X) 
            , TO_CHAR(A.SLIP_HEADER_ID) AS SLIP_HEADER_ID                               --전표헤더아이디(X)               
        FROM FI_SLIP_LINE A
            , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --거래처
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            
            AND A.ACCOUNT_CODE = '2100700'  --거래구분(매입/매출)
            /* 향후 계정과목관리 프로그램에서의 계정타입을 이용한 부가세 계정의 확장이 발생하면 위 문장 대신 사용하면 된다.
            AND A.ACCOUNT_CODE IN 
                (
                    SELECT ACCOUNT_CODE
                    FROM FI_ACCOUNT_CONTROL
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CLASS_ID = '1972'   --계정타입 : 부가세예수금
                )  --거래구분(매입/매출)             
            */
            
            AND A.REFER11 = W_TAX_CODE                                          --사업장
            AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
            AND MANAGEMENT1 = NVL(W_SUPPLIER_CODE, MANAGEMENT1)                 --거래처
            AND MANAGEMENT2 = NVL(W_VAT_TYPE, MANAGEMENT2)                      --세무유형
            
            AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)

        GROUP BY ROLLUP( A.MANAGEMENT2
                , (   A.SOB_ID, A.ORG_ID, B.SUPP_CUST_NAME, TAX_REG_NO, GL_DATE, A.MANAGEMENT1 
                    , A.REFER1, A.REFER2, A.REFER3, A.REFER4, A.REFER5, A.REFER6, A.REFER7, A.REFER8, A.REFER10 
                    , REMARK, GL_NUM, SLIP_LINE_ID, SLIP_HEADER_ID
                  )    ) ; 

    ELSE    --매입과 매출을 UNION ALL하여 보여준다.

        OPEN P_CURSOR FOR

        SELECT             
              DECODE(GROUPING(A.SOB_ID), 1, NULL, '매입') AS VAT_CLASS    --거래구분; 부가세대급금(1111700)
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, A.REFER1) AS VAT_TYPE   --세무유형코드
           
            --EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL) 
            -- => 이 프로젝트에서는 이런 방식을 이용하여 message를 처리하고 있다.
            , CASE
                WHEN GROUPING(A.REFER1) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL)  --<< 총 합계 >>
                WHEN GROUPING(A.SOB_ID) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL)  --< 소 계 >
                ELSE FI_COMMON_G.CODE_NAME_F('VAT_TYPE_AP', A.REFER1, A.SOB_ID, A.ORG_ID)
              END AS VAT_TYPE_NAME   ----세무유형              
            
            , A.REFER3 AS VAT_REASON_CODE                                                               --사유구분코드
            , FI_COMMON_G.CODE_NAME_F('VAT_REASON', A.REFER3, A.SOB_ID, A.ORG_ID) AS VAT_REASON_NAME    --사유구분
            , A.MANAGEMENT1 AS SUPPLIER_CODE                --거래처코드
            , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --거래처명
            , B.TAX_REG_NO AS TAX_REG_NO                    --사업자번호
            , A.REFER2 AS VAT_ISSUE_DATE                    --신고기준일자
            , TO_CHAR(A.GL_DATE, 'YYYY-MM-DD') AS GL_DATE   --전표일자
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, 
                        CASE
                            WHEN A.REFER2 = TO_CHAR(A.GL_DATE, 'YYYY-MM-DD') THEN 'N'
                            ELSE 'Y'
                        END    
                   ) AS DATE_CHECK   --일자확인여부(신고기준일자 VS 전표일자)
              
            --아래에서 TRIM, REPLACE를 쓴 이유는 과거 프로그램의 정합성 보장이 안되어 자료가 잘 못 입력된게 있어서이다.
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액    
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, 
                        CASE
                            WHEN ABS(ABS(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '') * 0.1) - ABS(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) > 20 THEN 'Y'
                            ELSE 'N'
                        END    
                   ) AS AMOUNT_CHECK  --오차범위(공급가액 * 0.1 VS 세액의 차이가 20이상인 경우)
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '') + REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS TOTAL_AMOUNT   --합계 = 공급가액 + 세액
            , SUM(TO_NUMBER(REPLACE(TRIM(A.REFER10), ',', ''))) AS ASSET_BASE  --고정자산과표
            , SUM(TO_NUMBER(REPLACE(TRIM(A.REFER11), ',', ''))) AS ASSET_TAX    --고정자산세액 
            , NULL AS MODIFY_REASON_CODE    --수정전자세금계산서사유구분코드
            , NULL AS MODIFY_REASON         --수정전자세금계산서사유구분
            , A.REFER4 AS CREDITCARD_CODE                                               --신용카드코드(X)    
            , FI_CREDIT_CARD_G.CARD_NUM_F(A.SOB_ID, A.REFER4, A.ORG_ID) AS CARD_NUM     --신용카드번호
            , FI_CREDIT_CARD_G.CARD_NAME_F(A.SOB_ID, A.REFER4, A.ORG_ID) AS CARD_NAME   --신용카드명(X)
            , NULL AS EXPORT_NO                                                         --수출신고번호    
            , A.REFER7 AS CASH_RECEIPT_NUM                                              --현금영수증승인번호
            , NULL AS CURRENCY_CODE                                                     --통화
            , TO_NUMBER(NULL) AS EXCHANGE_RATE                                          --환율
            , TO_NUMBER(NULL) AS CURRENCY_AMOUNT                                        --외화금액
            , A.REFER6 AS ELEC_TAX_YN                                                   --전자세금계산서여부        
            , A.REMARK                                                                  --전표적요
            , A.GL_NUM                                                                  --전표번호
            
            --아래 내용은 불필요할 듯 한데 전표조회를 할 시 기존에 이런 방식으로 한듯하여 적었다.
            , TO_NUMBER(A.SLIP_LINE_ID) AS SLIP_LINE_ID                                 --전표 라인 ID(X) 
            , TO_CHAR(A.SLIP_HEADER_ID) AS SLIP_HEADER_ID                               --전표헤더아이디(X)               
        FROM FI_SLIP_LINE A
            , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --거래처
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            
            AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
            /* 향후 계정과목관리 프로그램에서의 계정타입을 이용한 부가세 계정의 확장이 발생하면 위 문장 대신 사용하면 된다.
            AND A.ACCOUNT_CODE IN 
                (
                    SELECT ACCOUNT_CODE
                    FROM FI_ACCOUNT_CONTROL
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CLASS_ID = '1832'   --계정타입 : 부가세대급금                        
                )  --거래구분(매입/매출)              
            */            
            
            AND A.MANAGEMENT2 = W_TAX_CODE                                      --사업장
            AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
            AND MANAGEMENT1 = NVL(W_SUPPLIER_CODE, MANAGEMENT1)                 --거래처
            AND REFER1 = NVL(W_VAT_TYPE, REFER1)                                --세무유형
            
            AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)      
        GROUP BY ROLLUP( A.REFER1
                , (   A.SOB_ID, A.ORG_ID, B.SUPP_CUST_NAME, TAX_REG_NO, GL_DATE, A.MANAGEMENT1, A.MANAGEMENT2 
                    , A.REFER2, A.REFER3, A.REFER4, A.REFER5, A.REFER6, A.REFER7, A.REFER8, A.REFER10, A.REFER11
                    , REMARK, GL_NUM, SLIP_LINE_ID, SLIP_HEADER_ID
                  )    )


        UNION ALL


        SELECT
              DECODE(GROUPING(A.SOB_ID), 1, NULL, '매출') AS VAT_CLASS          --거래구분; 부가세예수금(2100700)            
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, A.MANAGEMENT2) AS VAT_TYPE    --세무유형코드            
            , CASE
                WHEN GROUPING(A.MANAGEMENT2) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL) --< 총 합계 >
                WHEN GROUPING(A.SOB_ID) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL)      --< 소 계 >
                ELSE FI_COMMON_G.CODE_NAME_F('VAT_TYPE_AR', A.MANAGEMENT2, A.SOB_ID, A.ORG_ID)
              END AS VAT_TYPE_NAME   ----세무유형                           
            , NULL AS VAT_REASON_CODE                       --사유구분코드
            , NULL AS VAT_REASON_NAME                       --사유구분
            , A.MANAGEMENT1 AS SUPPLIER_CODE                --거래처코드
            , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --거래처명
            , B.TAX_REG_NO AS TAX_REG_NO                    --사업자번호
            , A.REFER1 AS VAT_ISSUE_DATE                    --신고기준일자
            , TO_CHAR(A.GL_DATE, 'YYYY-MM-DD') AS GL_DATE   --전표일자            
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, 
                CASE
                    WHEN A.REFER1 = TO_CHAR(A.GL_DATE, 'YYYY-MM-DD') THEN 'N'
                    ELSE 'Y'
                END    
              ) AS DATE_CHECK   --일자확인여부(신고기준일자 VS 전표일자) 
             
            --아래에서 TRIM, REPLACE를 쓴 이유는 과거 프로그램의 정합성 보장이 안되어 자료가 잘 못 입력된게 있어서이다.
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액 
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, 
                CASE
                    WHEN ABS(ABS(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', '') * 0.1) - ABS(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) > 20 THEN 'Y'
                    ELSE 'N'
                END    
              ) AS AMOUNT_CHECK  --오차범위(공급가액 * 0.1 VS 세액의 차이가 20이상인 경우)
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', '') + REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS TOTAL_AMOUNT   --합계 = 공급가액 + 세액              

            , TO_NUMBER(NULL) AS ASSET_BASE     --고정자산과표
            , TO_NUMBER(NULL) AS ASSET_TAX      --고정자산세액
            , A.REFER10 AS MODIFY_REASON_CODE   --수정전자세금계산서사유구분코드
            , FI_COMMON_G.CODE_NAME_F('MODIFY_TAX_REASON', A.REFER10, A.SOB_ID, A.ORG_ID) AS MODIFY_REASON    --수정전자세금계산서사유구분
            , NULL AS CREDITCARD_CODE   --신용카드코드(X)    
            , NULL AS CARD_NUM          --신용카드번호
            , NULL AS CARD_NAME         --신용카드명(X)
            , A.REFER4 AS EXPORT_NO     --수출신고번호    
            , NULL AS CASH_RECEIPT_NUM  --현금영수증승인번호
            , A.REFER3 AS CURRENCY_CODE --통화
            , TO_NUMBER(DECODE(GROUPING(A.SOB_ID), 1, NULL, REPLACE(TRIM(A.REFER6), ',', ''))) AS EXCHANGE_RATE     --환율
            , TO_NUMBER(DECODE(GROUPING(A.SOB_ID), 1, NULL, REPLACE(TRIM(A.REFER5), ',', ''))) AS CURRENCY_AMOUNT   --외화금액             
            , A.REFER7 AS ELEC_TAX_YN                                                   --전자세금계산서여부        
            , A.REMARK                                                                  --전표적요
            , A.GL_NUM                                                                  --전표번호
            
            --아래 내용은 불필요할 듯 한데 전표조회를 할 시 기존에 이런 방식으로 한듯하여 적었다.
            , TO_NUMBER(A.SLIP_LINE_ID) AS SLIP_LINE_ID                                 --전표 라인 ID(X) 
            , TO_CHAR(A.SLIP_HEADER_ID) AS SLIP_HEADER_ID                               --전표헤더아이디(X)               
        FROM FI_SLIP_LINE A
            , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --거래처
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID
            
            AND A.ACCOUNT_CODE = '2100700'  --거래구분(매입/매출)
            /* 향후 계정과목관리 프로그램에서의 계정타입을 이용한 부가세 계정의 확장이 발생하면 위 문장 대신 사용하면 된다.
            AND A.ACCOUNT_CODE IN 
                (
                    SELECT ACCOUNT_CODE
                    FROM FI_ACCOUNT_CONTROL
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CLASS_ID = '1972'   --계정타입 : 부가세예수금
                )  --거래구분(매입/매출)             
            */            
                        
            AND A.REFER11 = W_TAX_CODE                                          --사업장
            AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --신고기준일자
            AND MANAGEMENT1 = NVL(W_SUPPLIER_CODE, MANAGEMENT1)                 --거래처
            AND MANAGEMENT2 = NVL(W_VAT_TYPE, MANAGEMENT2)                      --세무유형
            
            AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)

        GROUP BY ROLLUP( A.MANAGEMENT2
                , (   A.SOB_ID, A.ORG_ID, B.SUPP_CUST_NAME, TAX_REG_NO, GL_DATE, A.MANAGEMENT1 
                    , A.REFER1, A.REFER2, A.REFER3, A.REFER4, A.REFER5, A.REFER6, A.REFER7, A.REFER8, A.REFER10 
                    , REMARK, GL_NUM, SLIP_LINE_ID, SLIP_HEADER_ID
                  )    ) 
        ; 

    END IF;



END LIST_VAT;




END FI_VAT_AP_AR_G;
/
