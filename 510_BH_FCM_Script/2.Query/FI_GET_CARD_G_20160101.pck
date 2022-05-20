CREATE OR REPLACE PACKAGE FI_GET_CARD_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_GET_CARD_G
Description  : 신용카드등수취명세서 Package

Reference by : calling assmbly-program id(호출 프로그램) : (신용카드등수취명세서)
Program History :
    -.2개의 탭으로 구성된다. 1번째 탭 : 신용카드등수취명세서, 2번째 탭 : 현금영수증수취명세서
      1.신용카드등수취명세서 자료 도출 기준 : 거래구분-매입, 세무유형-카드매입
      2.현금영수증수취명세서 자료 도출 기준 : 거래구분-매입, 세무유형-현금영수증매입
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-27   Leem Dong Ern(임동언)
*****************************************************************************/



--상단 합계 부분 조회
PROCEDURE SUM_GET_CARD(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2 --사업장아이디(예> 110) 
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료
);





--신용카드등수취명세서 화면 조회 리스트
PROCEDURE LIST_GET_CARD(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2 --사업장아이디(예> 110) 
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료 
);







--현금영수증수취명세서 조회 리스트
PROCEDURE LIST_GET_CASH(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2 --사업장아이디(예> 110) 
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료 
);





--신용카드등수취명세서 출력 리스트
PROCEDURE LIST_GET_CARD_PRINT(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2 --사업장아이디(예> 110) 
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료 
);






--신용카드등수취명세서 상단 출력용
PROCEDURE PRINT_GET_CARD_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID              IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2 --사업장아이디(예> 110)      
    
    --아래 항목은 출력시 필수항목이다.
    , W_TAX_DATE_FR         IN  VARCHAR2    --과세기간_시작
    , W_TAX_DATE_TO         IN  VARCHAR2    --과세기간_종료
);






END FI_GET_CARD_G;
/
CREATE OR REPLACE PACKAGE BODY FI_GET_CARD_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_GET_CARD_G
Description  : 신용카드등수취명세서 Package

Reference by : calling assmbly-program id(호출 프로그램) : (신용카드등수취명세서)
Program History :
    -.2개의 탭으로 구성된다. 1번째 탭 : 신용카드등수취명세서, 2번째 탭 : 현금영수증수취명세서
      1.신용카드등수취명세서 자료 도출 기준 : 거래구분-매입, 세무유형-카드매입
      2.현금영수증수취명세서 자료 도출 기준 : 거래구분-매입, 세무유형-현금영수증매입
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-27   Leem Dong Ern(임동언)
*****************************************************************************/






--상단 합계 부분 조회
PROCEDURE SUM_GET_CARD(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2 --사업장아이디(예> 110) 
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          5 AS SEQ  --고유번호
        , '합               계' AS GUBUN  --구분
        , COUNT(*) AS CNT                 --거래건수
        , SUM(GL_AMOUNT) AS GL_AMOUNT     --공급가액
        , SUM(VAT_AMOUNT) AS VAT_AMOUNT   --세액
    FROM
    (
        SELECT
              REFER1    --세무유형  
            , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --공급가액
            , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --세액          
        FROM FI_SLIP_LINE A
            , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --거래처
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            
            --AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
            AND A.ACCOUNT_CODE IN 
                (
                    SELECT ACCOUNT_CODE
                    FROM FI_ACCOUNT_CONTROL
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CLASS_ID = '1832'   --계정타입 : 부가세대급금                        
                )  --거래구분(매입/매출)     
            
            AND A.MANAGEMENT2 = W_TAX_CODE              --사업장
            --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
            AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
            AND REFER1 IN ('6', '7')    --세무유형 : 카드매입, 현금영수증매입    
            AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
    )

    UNION ALL

    SELECT    
          DECODE(REFER1, '6', 9, '7', 6) AS SEQ  --고유번호
        , DECODE(REFER1, '6', '기타 신용카드 등', '7', '현 금  영 수 증') AS GUBUN  --구분
        , COUNT(*) AS CNT
        , SUM(GL_AMOUNT)
        , SUM(VAT_AMOUNT)
    FROM
    (
        SELECT
              REFER1    --세무유형  
            , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --공급가액
            , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --세액          
        FROM FI_SLIP_LINE A
            , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --거래처
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            
            --AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
            AND A.ACCOUNT_CODE IN 
                (
                    SELECT ACCOUNT_CODE
                    FROM FI_ACCOUNT_CONTROL
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CLASS_ID = '1832'   --계정타입 : 부가세대급금                        
                )  --거래구분(매입/매출)     
            
            AND A.MANAGEMENT2 = W_TAX_CODE              --사업장
            --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
            AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
            AND REFER1 IN ('6', '7')    --세무유형 : 카드매입, 현금영수증매입    
            AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
    )
    GROUP BY REFER1
    ORDER BY SEQ    ;

END SUM_GET_CARD;








--신용카드등수취명세서 화면 조회 리스트
PROCEDURE LIST_GET_CARD(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2 --사업장아이디(예> 110)   
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료 
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          A.REFER2 AS VAT_ISSUE_DATE    --거래일자, 신고기준일자   
        , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --공급가액
        , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --세액
        , A.MANAGEMENT1 AS SUPPLIER_CODE                --거래처코드
        , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --거래처명
        , B.TAX_REG_NO AS TAX_REG_NO                    --사업자등록번호      
        , A.REFER4 AS CREDITCARD_CODE                   --신용카드코드   
        , FI_CREDIT_CARD_G.CARD_NUM_F(A.SOB_ID, A.REFER4, A.ORG_ID) AS CARD_NUM     --신용카드번호 
        , TO_NUMBER(REPLACE(TRIM(A.REFER10), ',', '')) AS ASSET_BASE   --고정자산과표
        , TO_NUMBER(REPLACE(TRIM(A.REFER11), ',', '')) AS ASSET_TAX    --고정자산세액           
    FROM FI_SLIP_LINE A
        , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --거래처
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        
        --AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
        AND A.ACCOUNT_CODE IN 
            (
                SELECT ACCOUNT_CODE
                FROM FI_ACCOUNT_CONTROL
                WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                    AND ACCOUNT_CLASS_ID = '1832'   --계정타입 : 부가세대급금                        
            )  --거래구분(매입/매출)     
        
        AND A.MANAGEMENT2 = W_TAX_CODE              --사업장
        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
        AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
        AND REFER1 = '6'    --세무유형    
        AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
    ORDER BY VAT_ISSUE_DATE, SUPPLIER_NAME    ;
    

END LIST_GET_CARD;










--현금영수증수취명세서 조회 리스트
PROCEDURE LIST_GET_CASH(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2 --사업장아이디(예> 110)   
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료 
)

AS

BEGIN

    OPEN P_CURSOR FOR
    
    WITH T AS(
        SELECT
              A.REFER2 AS VAT_ISSUE_DATE    --거래일자, 신고기준일자   
            , 1 AS CNT  --매수
            , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --공급가액
            , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --세액
            , A.MANAGEMENT1 AS SUPPLIER_CODE        --거래처코드
            , B.SUPP_CUST_NAME AS SUPPLIER_NAME     --거래처명
            , B.TAX_REG_NO AS TAX_REG_NO            --사업자등록번호      
            , A.REFER7 AS CASH_RECEIPT_NUM          --(현금영수증)승인번호    
            , TO_NUMBER(REPLACE(TRIM(A.REFER10), ',', '')) AS ASSET_BASE   --고정자산과표
            , TO_NUMBER(REPLACE(TRIM(A.REFER11), ',', '')) AS ASSET_TAX    --고정자산세액           
        FROM FI_SLIP_LINE A
            , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --거래처
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            
            --AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
            AND A.ACCOUNT_CODE IN 
                (
                    SELECT ACCOUNT_CODE
                    FROM FI_ACCOUNT_CONTROL
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CLASS_ID = '1832'   --계정타입 : 부가세대급금                        
                )  --거래구분(매입/매출)     
            
            AND A.MANAGEMENT2 = W_TAX_CODE              --사업장
            --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
            AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
            AND REFER1 = '7'    --세무유형 : 현금영수증매입    
            AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
        ORDER BY VAT_ISSUE_DATE, SUPPLIER_NAME
    )
    SELECT ROWNUM AS SEQ, T.*
    FROM T  ;     
    

END LIST_GET_CASH;







--신용카드등수취명세서 출력 리스트
PROCEDURE LIST_GET_CARD_PRINT(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2 --사업장아이디(예> 110)   
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료 
)

AS

BEGIN

    OPEN P_CURSOR FOR

    WITH T AS(
        SELECT
              CARD_NUM
            , TAX_REG_NO
            , COUNT(*) AS CNT
            , SUM(GL_AMOUNT) AS GL_AMOUNT
            , SUM(VAT_AMOUNT) AS VAT_AMOUNT
        FROM
        (
            SELECT  
                  FI_CREDIT_CARD_G.CARD_NUM_F(A.SOB_ID, A.REFER4, A.ORG_ID) AS CARD_NUM     --신용카드번호
                , B.TAX_REG_NO AS TAX_REG_NO                    --사업자등록번호   
                , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --공급가액
                , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --세액
                
                --A.REFER4 AS CREDITCARD_CODE --신용카드코드             
                --, A.MANAGEMENT1 AS SUPPLIER_CODE                --거래처코드
                --, B.SUPP_CUST_NAME AS SUPPLIER_NAME             --거래처명            
                --, A.REFER2 AS VAT_ISSUE_DATE                    --신고기준일자            
                --, TO_NUMBER(REPLACE(TRIM(A.REFER10), ',', '')) AS ASSET_BASE   --고정자산과표
                --, TO_NUMBER(REPLACE(TRIM(A.REFER11), ',', '')) AS ASSET_TAX    --고정자산세액           
            FROM FI_SLIP_LINE A
                , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --거래처
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID 
                
                --AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
                AND A.ACCOUNT_CODE IN 
                    (
                        SELECT ACCOUNT_CODE
                        FROM FI_ACCOUNT_CONTROL
                        WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                            AND ACCOUNT_CLASS_ID = '1832'   --계정타입 : 부가세대급금                        
                    )  --거래구분(매입/매출)     
                
                AND A.MANAGEMENT2 = W_TAX_CODE              --사업장
                --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                AND REFER1 = '6'    --세무유형    
                AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
        )
        GROUP BY CARD_NUM, TAX_REG_NO
        ORDER BY CARD_NUM, TAX_REG_NO
    ) 
    SELECT 
          ROWNUM AS SEQ --일련번호
        , CARD_NUM      --카드회원번호
        , TAX_REG_NO    --사업자등록번호
        , CNT           --거래건수
        , GL_AMOUNT     --공급가액
        , VAT_AMOUNT    --세액
    FROM T  ;
    

END LIST_GET_CARD_PRINT;






--신용카드등수취명세서 상단 출력용
PROCEDURE PRINT_GET_CARD_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID              IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2 --사업장아이디(예> 110)      
    
    --아래 항목은 출력시 필수항목이다.
    , W_TAX_DATE_FR         IN  VARCHAR2    --과세기간_시작
    , W_TAX_DATE_TO         IN  VARCHAR2    --과세기간_종료
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          B.VAT_NUMBER                          --사업자등록번호
        , A.LEGAL_NUMBER                        --주민(법인)등록번호
        , A.CORP_NAME                           --상호(법인명)
        , A.PRESIDENT_NAME                      --성명(대표자)
        , B.ADDR1 || ' ' || B.ADDR2 AS LOCATION --사업장소재지
        , A.TEL_NUMBER                          --전화번호
        , B.BUSINESS_ITEM || '(' || BUSINESS_TYPE || ')' AS BUSINESS    --업태(종목)                
        , '(   ' || SUBSTR(W_TAX_DATE_TO, 1, 4) || '  년   ' ||  
          CASE
            WHEN LTRIM(SUBSTR(W_TAX_DATE_TO, 6, 2), '0') <= 6 THEN '1  기   '
            ELSE '2  기   '
          END
          ||
          CASE
            WHEN LTRIM(SUBSTR(W_TAX_DATE_TO, 6, 2), '0') <=  3 THEN '예정   )'
            WHEN LTRIM(SUBSTR(W_TAX_DATE_TO, 6, 2), '0') <=  6 THEN '확정   )'
            WHEN LTRIM(SUBSTR(W_TAX_DATE_TO, 6, 2), '0') <=  9 THEN '예정   )'
            WHEN LTRIM(SUBSTR(W_TAX_DATE_TO, 6, 2), '0') <= 12 THEN '확정   )'            
          END          
          AS FISCAL_YEAR   --부가가치세신고기수
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
        OR   ROWNUM                 <= 1);
        
END PRINT_GET_CARD_TITLE;





END FI_GET_CARD_G;
/
