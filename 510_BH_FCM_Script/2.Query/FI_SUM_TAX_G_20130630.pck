CREATE OR REPLACE PACKAGE FI_SUM_TAX_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_SUM_TAX_G
Description  : 계산서합계표 Package

Reference by : calling assmbly-program id(호출 프로그램) : (계산서합계표)
Program History :
    -.명세서구분 : 매입처별계산서합계표, 매출처별계산서합계표
    -.매출대상자료 :면세사업자가 아니므로 매출처별계산서합계표는 발행할 일이 없다.
    -.매입대상자료 : 면세매입(4)
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-23   Leem Dong Ern(임동언)
*****************************************************************************/






--상단 합계부분 조회
--아래의 PROCEDURE를 이용해서 거래구분값을 받아 실행하고 싶은데 C#에서 처리가 안 되어 
--하기의 2개 PROCEDURE(UP_AP_SUM_TAX, UP_AR_SUM_TAX)를 추가했다.

PROCEDURE UP_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , AP_AR_GB              IN  VARCHAR2    --매입/매출 구분(1 : 매입, 2 : 매출)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
);


--매입
PROCEDURE UP_AP_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
);



--매출
PROCEDURE UP_AR_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
);





--상세내역 자료
--아래의 PROCEDURE를 이용해서 거래구분값을 받아 실행하고 싶은데 C#에서 처리가 안 되어 
--하기의 2개 PROCEDURE(LIST_AP_SUM_TAX, LIST_AR_SUM_TAX)를 추가했다.

PROCEDURE LIST_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , AP_AR_GB              IN  VARCHAR2    --매입/매출 구분(1 : 매입, 2 : 매출)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
);



--매입
PROCEDURE LIST_AP_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
);

--매입 인쇄(전자이외 자료) 
PROCEDURE PRINT_AP_LIST_TAX(
      P_CURSOR1             OUT TYPES.TCURSOR1
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
);



--매출
PROCEDURE LIST_AR_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
);

--매출 인쇄(전자이외 자료) 
PROCEDURE PRINT_AR_LIST_TAX(
      P_CURSOR1             OUT TYPES.TCURSOR1
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
);







--세금계산서합계표 상단 출력용
PROCEDURE PRINT_SUM_TAX_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)       
    , W_DEAL_DATE_FR        IN  DATE    --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --거래기간_종료
    , W_CREATE_DATE         IN  DATE    --작성일자    
);






END FI_SUM_TAX_G;
/
CREATE OR REPLACE PACKAGE BODY FI_SUM_TAX_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_SUM_TAX_G
Description  : 계산서합계표 Package

Reference by : calling assmbly-program id(호출 프로그램) : (계산서합계표)
Program History :
    -.명세서구분 : 매입처별계산서합계표, 매출처별계산서합계표
    -.매출대상자료 :면세사업자가 아니므로 매출처별계산서합계표는 발행할 일이 없다.
    -.매입대상자료 : 면세매입(4)
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-23   Leem Dong Ern(임동언)
*****************************************************************************/



--거래구분 : 매입


--상단 합계부분 조회

PROCEDURE UP_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , AP_AR_GB              IN  VARCHAR2    --매입/매출 구분(1 : 매입, 2 : 매출)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
)

AS

BEGIN    

    IF AP_AR_GB = '1' THEN  --매입
        
        OPEN P_CURSOR FOR
    
        WITH T AS(
            SELECT
                  '합  계' AS TITLE
                , COUNT(SUPPLIER_CODE) AS COMPANY_CNT --거래처 수
                , SUM(CNT) AS TOTAL_RECORD --매수
                , SUM(GL_AMOUNT) AS GL_AMOUNT --공급가액
                , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN   --출력시 사용할 목적임, 공급가액의 길이       
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                        , COUNT(*) AS CNT --매수
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
                        AND A.MANAGEMENT2 = W_TAX_CODE  --사업장
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                        AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                        AND A.REFER1 = '4'  --세무유형 
                    GROUP BY  A.MANAGEMENT1 
                ) AA      
        )
        SELECT
              '합  계' AS TITLE
            , COMPANY_CNT --거래처 수
            , TOTAL_RECORD --매수
            , GL_AMOUNT --공급가액
                
            , SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS GL_AMOUNT_1      --공급가액_조단위
            , CASE
                WHEN AMT_LEN > 12 THEN SUBSTR(GL_AMOUNT, -12, 3)
                WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
                ELSE ''
              END AS GL_AMOUNT_2      --공급가액_십억단위
            , CASE
                WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -9, 3)
                WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
                ELSE ''
              END AS GL_AMOUNT_3      --공급가액_백만단위
            , CASE
                WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -6, 3)
                WHEN AMT_LEN > 3 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
                ELSE ''
              END AS GL_AMOUNT_4      --공급가액_천단위
            , CASE
                WHEN AMT_LEN <= 3 THEN TO_CHAR(GL_AMOUNT)
                ELSE SUBSTR(GL_AMOUNT, -3, 3)
              END AS GL_AMOUNT_5      --공급가액_원단위   
        FROM T  ;
        
    ELSIF AP_AR_GB = '2' THEN   --매출
        
        OPEN P_CURSOR FOR
    
        WITH T AS(
            SELECT
                  '합  계' AS TITLE
                , COUNT(SUPPLIER_CODE) AS COMPANY_CNT --거래처 수
                , SUM(CNT) AS TOTAL_RECORD --매수
                , SUM(GL_AMOUNT) AS GL_AMOUNT --공급가액
                , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN   --출력시 사용할 목적임, 공급가액의 길이       
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                        , COUNT(*) AS CNT --매수
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '2100700'  --거래구분(매출)
                        AND A.REFER11 = W_TAX_CODE  --사업장
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                        AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                        AND A.MANAGEMENT2 = '4'  --세무유형 
                    GROUP BY  A.MANAGEMENT1 
                ) AA      
        )
        SELECT
              '합  계' AS TITLE
            , COMPANY_CNT --거래처 수
            , TOTAL_RECORD --매수
            , GL_AMOUNT --공급가액
                
            , SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS GL_AMOUNT_1      --공급가액_조단위
            , CASE
                WHEN AMT_LEN > 12 THEN SUBSTR(GL_AMOUNT, -12, 3)
                WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
                ELSE ''
              END AS GL_AMOUNT_2      --공급가액_십억단위
            , CASE
                WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -9, 3)
                WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
                ELSE ''
              END AS GL_AMOUNT_3      --공급가액_백만단위
            , CASE
                WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -6, 3)
                WHEN AMT_LEN > 3 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
                ELSE ''
              END AS GL_AMOUNT_4      --공급가액_천단위
            , CASE
                WHEN AMT_LEN <= 3 THEN TO_CHAR(GL_AMOUNT)
                ELSE SUBSTR(GL_AMOUNT, -3, 3)
              END AS GL_AMOUNT_5      --공급가액_원단위   
        FROM T  ;
                
    END IF;


END UP_SUM_TAX;







--매입
PROCEDURE UP_AP_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
)

AS

BEGIN    
    
    OPEN P_CURSOR FOR

    WITH T AS(
        SELECT
              CASE
                WHEN GROUPING(AA.ELEC_FLAG) = 1 THEN 'SUM'
                ELSE AA.ELEC_FLAG
              END AS VAT_TYPE
            , COUNT(SUPPLIER_CODE) AS COMPANY_CNT --거래처 수
            , SUM(CNT) AS TOTAL_RECORD --매수
            , SUM(GL_AMOUNT) AS GL_AMOUNT --공급가액
            , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN   --출력시 사용할 목적임, 공급가액의 길이     
            , CASE
                WHEN GROUPING(AA.ELEC_FLAG) = 1 THEN 0
                ELSE AA.ROW_NUM
              END AS ROW_NUM  
        FROM
            (
                SELECT             
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                    , NVL(A.REFER6, 'N') AS ELEC_FLAG   -- 전자여부.
                    , COUNT(*) AS CNT --매수
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''), '999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.')) AS GL_AMOUNT     --공급가액
                    , DECODE(NVL(A.REFER6, 'N'), 'Y', 1, 2) AS ROW_NUM
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '1111700'  --거래구분(매입/매출)
                    AND A.MANAGEMENT2 = W_TAX_CODE  --사업장
                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                    AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                    AND A.REFER1 = '4'  --세무유형                     
                GROUP BY  A.MANAGEMENT1 
                        , NVL(A.REFER6, 'N')
            ) AA   
  GROUP BY ROLLUP((AA.ELEC_FLAG
                  , AA.ROW_NUM))       
    )
    SELECT
          VAT_TYPE    -- 매입계산서 합계 구분 .
        , CASE
            WHEN T.VAT_TYPE = 'Y' THEN '전자계산서'
            WHEN T.VAT_TYPE = 'SUM' THEN '합  계'
            ELSE '전자계산서 외'
          END AS VAT_TITLE  
        , COMPANY_CNT --거래처 수
        , TOTAL_RECORD --매수
        , GL_AMOUNT --공급가액
            
        , SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS GL_AMOUNT_1      --공급가액_조단위
        , CASE
            WHEN AMT_LEN > 12 THEN SUBSTR(GL_AMOUNT, -12, 3)
            WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
            ELSE ''
          END AS GL_AMOUNT_2      --공급가액_십억단위
        , CASE
            WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -9, 3)
            WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
            ELSE ''
          END AS GL_AMOUNT_3      --공급가액_백만단위
        , CASE
            WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -6, 3)
            WHEN AMT_LEN > 3 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
            ELSE ''
          END AS GL_AMOUNT_4      --공급가액_천단위
        , CASE
            WHEN AMT_LEN <= 3 THEN TO_CHAR(GL_AMOUNT)
            ELSE SUBSTR(GL_AMOUNT, -3, 3)
          END AS GL_AMOUNT_5      --공급가액_원단위   
    FROM T  
  ORDER BY T.ROW_NUM    ;

END UP_AP_SUM_TAX;










--매출
PROCEDURE UP_AR_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
)

AS

BEGIN    
        
    OPEN P_CURSOR FOR

    WITH T AS(
         SELECT
              CASE
                WHEN GROUPING(AA.TAX_ELECTRO_YN) = 1 THEN 'SUM'
                WHEN GROUPING(AA.BUSINESS_TYPE_S) = 1 THEN AA.TAX_ELECTRO_YN || 'S'
                ELSE AA.TAX_ELECTRO_YN || AA.BUSINESS_TYPE_S
              END AS LINE_TYPE
            , COUNT(AA.SUPPLIER_CODE) AS COMPANY_CNT --거래처 수
            , SUM(AA.CNT) AS TOTAL_RECORD --매수
            , SUM(AA.GL_AMOUNT) AS GL_AMOUNT --공급가액
            , LENGTH(SUM(AA.GL_AMOUNT)) AS AMT_LEN   --출력시 사용할 목적임, 공급가액의 길이  
            , CASE
                WHEN GROUPING(AA.TAX_ELECTRO_YN) = 1 THEN 0
                WHEN GROUPING(AA.BUSINESS_TYPE_S) = 1 AND AA.TAX_ELECTRO_YN = 'Y' THEN 29
                WHEN GROUPING(AA.BUSINESS_TYPE_S) = 1 AND AA.TAX_ELECTRO_YN = 'N' THEN 49
                ELSE AA.ROW_NUM
              END AS ROW_NUM
        FROM 
            (
               SELECT             
                      NVL(A.REFER7, 'N') AS TAX_ELECTRO_YN
                    , DECODE(SC.BUSINESS_TYPE_S, 'P', 'P', 'C') AS BUSINESS_TYPE_S
                    , A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                    , COUNT(*) AS CNT --매수
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''), '999999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.')) AS GL_AMOUNT     --공급가액
                    , CASE
                        WHEN NVL(A.REFER7, 'N') || DECODE(SC.BUSINESS_TYPE_S, 'P', 'P', 'C') = 'YC' THEN 10
                        WHEN NVL(A.REFER7, 'N') || DECODE(SC.BUSINESS_TYPE_S, 'P', 'P', 'C') = 'YP' THEN 20
                        WHEN NVL(A.REFER7, 'N') || DECODE(SC.BUSINESS_TYPE_S, 'P', 'P', 'C') = 'NC' THEN 30
                        WHEN NVL(A.REFER7, 'N') || DECODE(SC.BUSINESS_TYPE_S, 'P', 'P', 'C') = 'NP' THEN 40  
                      END AS ROW_NUM
                FROM FI_SLIP_LINE A
                   , FI_SUPP_CUST_V SC
                WHERE A.MANAGEMENT1  = SC.SUPP_CUST_CODE
                    AND A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '2100700'  --거래구분(매입/매출)TAX_CODE  --사업장
                    AND A.REFER11 = W_TAX_CODE  --사업장
                    AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                    AND A.MANAGEMENT2 = '4'  --세무유형 
                GROUP BY A.MANAGEMENT1
                       , NVL(A.REFER7, 'N')
                       , (DECODE(SC.BUSINESS_TYPE_S, 'P', 'P', 'C'))
            ) AA  
      GROUP BY ROLLUP((AA.TAX_ELECTRO_YN)
                     , (AA.BUSINESS_TYPE_S
                     ,  AA.ROW_NUM))        
      ORDER BY ROW_NUM 
        /*SELECT
              '합  계' AS TITLE
            , COUNT(SUPPLIER_CODE) AS COMPANY_CNT --거래처 수
            , SUM(CNT) AS TOTAL_RECORD --매수
            , SUM(GL_AMOUNT) AS GL_AMOUNT --공급가액
            , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN   --출력시 사용할 목적임, 공급가액의 길이       
        FROM
            (
                SELECT             
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                    , COUNT(*) AS CNT --매수
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '2100700'  --거래구분(매입/매출)TAX_CODE  --사업장
                    AND A.REFER11 = W_TAX_CODE  --사업장
                    AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                    AND A.MANAGEMENT2 = '4'  --세무유형 
                GROUP BY  A.MANAGEMENT1 
            ) AA     */ 
    )
    SELECT T.LINE_TYPE AS VAT_TYPE 
        , CASE
            WHEN T.LINE_TYPE = 'YC' THEN '전자계산서 발급분-사업자등록번호'
            WHEN T.LINE_TYPE = 'YP' THEN '전자계산서 발급분-주민등록번호'
            WHEN T.LINE_TYPE = 'YS' THEN '전자계산서 발급분-소계'  
            WHEN T.LINE_TYPE = 'NC' THEN '전자계산서 외의 발급분-사업자등록번호'
            WHEN T.LINE_TYPE = 'NP' THEN '전자계산서 외의 발급분-주민등록번호'
            WHEN T.LINE_TYPE = 'NS' THEN '전자계산서 외의 발급분-소계'
            WHEN T.LINE_TYPE = 'SUM' THEN '합  계'
          END AS VAT_TITLE
        , COMPANY_CNT --거래처 수
        , TOTAL_RECORD --매수
        , GL_AMOUNT --공급가액
            
        , SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS GL_AMOUNT_1      --공급가액_조단위
        , CASE
            WHEN AMT_LEN > 12 THEN SUBSTR(GL_AMOUNT, -12, 3)
            WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
            ELSE ''
          END AS GL_AMOUNT_2      --공급가액_십억단위
        , CASE
            WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -9, 3)
            WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
            ELSE ''
          END AS GL_AMOUNT_3      --공급가액_백만단위
        , CASE
            WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -6, 3)
            WHEN AMT_LEN > 3 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
            ELSE ''
          END AS GL_AMOUNT_4      --공급가액_천단위
        , CASE
            WHEN AMT_LEN <= 3 THEN TO_CHAR(GL_AMOUNT)
            ELSE SUBSTR(GL_AMOUNT, -3, 3)
          END AS GL_AMOUNT_5      --공급가액_원단위   
    FROM T  ;


END UP_AR_SUM_TAX;







--상세내역 자료
PROCEDURE LIST_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , AP_AR_GB              IN  VARCHAR2    --매입/매출 구분(1 : 매입, 2 : 매출)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
)

AS

BEGIN

    IF AP_AR_GB = '1' THEN --매입

        OPEN P_CURSOR FOR

        WITH T AS(
            SELECT
                  AA.SUPPLIER_CODE --거래처코드
                , B.TAX_REG_NO                    --사업자등록번호      
                , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --상호(법인명)      
                , AA.COMPANY_CNT  --매수     
                
                , AA.GL_AMOUNT     --공급가액
                , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --출력시 사용할 목적임, 공급가액의 길이
                        
                , B.PRESIDENT_NAME        --대표자성명
                , B.BUSINESS_CONDITION    --업태
                , B.BUSINESS_ITEM         --종목
            FROM
                (
                SELECT
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                    , COUNT(*) AS COMPANY_CNT           --매수     
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액     
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '1111700'  --거래구분 : 매입
                    AND A.MANAGEMENT2 = W_TAX_CODE  --사업장
                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                    AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                    AND A.REFER1 = '4'  --세무유형
                GROUP BY A.MANAGEMENT1
                ) AA
                , ( SELECT 
                          SUPP_CUST_CODE        --코드
                        , SUPP_CUST_NAME        --상호
                        , TAX_REG_NO            --사업자등록번호
                        , PRESIDENT_NAME        --대표자성명
                        , BUSINESS_CONDITION    --업태
                        , BUSINESS_ITEM         --종목
                    FROM FI_SUPP_CUST_V) B  --거래처    
            WHERE AA.SUPPLIER_CODE = B.SUPP_CUST_CODE(+)
            ORDER BY TAX_REG_NO
        )
        SELECT 
              ROWNUM AS SEQ
            , SUPPLIER_CODE --거래처코드
            , TAX_REG_NO                    --사업자등록번호      
            , SUPPLIER_NAME             --상호(법인명)      
            , COMPANY_CNT  --매수
            
            , GL_AMOUNT     --공급가액    
            , SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS GL_AMOUNT_1      --공급가액_조단위
            , CASE
                WHEN AMT_LEN > 12 THEN SUBSTR(GL_AMOUNT, -12, 3)
                WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
                ELSE ''
              END AS GL_AMOUNT_2      --공급가액_십억단위
            , CASE
                WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -9, 3)
                WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
                ELSE ''
              END AS GL_AMOUNT_3      --공급가액_백만단위
            , CASE
                WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -6, 3)
                WHEN AMT_LEN > 3 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
                ELSE ''
              END AS GL_AMOUNT_4      --공급가액_천단위
            , CASE
                WHEN AMT_LEN <= 3 THEN TO_CHAR(GL_AMOUNT)
                ELSE SUBSTR(GL_AMOUNT, -3, 3)
              END AS GL_AMOUNT_5      --공급가액_원단위

            , PRESIDENT_NAME        --대표자성명
            , BUSINESS_CONDITION    --업태
            , BUSINESS_ITEM         --종목    
        FROM T  ;

    ELSIF AP_AR_GB = '2' THEN --매출
        OPEN P_CURSOR FOR

        WITH T AS(
            SELECT
                  AA.SUPPLIER_CODE --거래처코드
                , B.TAX_REG_NO                    --사업자등록번호      
                , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --상호(법인명)      
                , AA.COMPANY_CNT  --매수     
                
                , AA.GL_AMOUNT     --공급가액
                , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --출력시 사용할 목적임, 공급가액의 길이
                        
                , B.PRESIDENT_NAME        --대표자성명
                , B.BUSINESS_CONDITION    --업태
                , B.BUSINESS_ITEM         --종목
            FROM
                (
                SELECT
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                    , COUNT(*) AS COMPANY_CNT           --매수     
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액     
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매입
                    AND A.REFER11 = W_TAX_CODE  --사업장
                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                    AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                    AND A.MANAGEMENT2 = '4'  --세무유형
                GROUP BY A.MANAGEMENT1
                ) AA
                , ( SELECT 
                          SUPP_CUST_CODE        --코드
                        , SUPP_CUST_NAME        --상호
                        , TAX_REG_NO            --사업자등록번호
                        , PRESIDENT_NAME        --대표자성명
                        , BUSINESS_CONDITION    --업태
                        , BUSINESS_ITEM         --종목
                    FROM FI_SUPP_CUST_V) B  --거래처    
            WHERE AA.SUPPLIER_CODE = B.SUPP_CUST_CODE(+)
            ORDER BY TAX_REG_NO
        )
        SELECT 
              ROWNUM AS SEQ
            , SUPPLIER_CODE --거래처코드
            , TAX_REG_NO                    --사업자등록번호      
            , SUPPLIER_NAME             --상호(법인명)      
            , COMPANY_CNT  --매수
            
            , GL_AMOUNT     --공급가액    
            , SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS GL_AMOUNT_1      --공급가액_조단위
            , CASE
                WHEN AMT_LEN > 12 THEN SUBSTR(GL_AMOUNT, -12, 3)
                WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
                ELSE ''
              END AS GL_AMOUNT_2      --공급가액_십억단위
            , CASE
                WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -9, 3)
                WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
                ELSE ''
              END AS GL_AMOUNT_3      --공급가액_백만단위
            , CASE
                WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -6, 3)
                WHEN AMT_LEN > 3 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
                ELSE ''
              END AS GL_AMOUNT_4      --공급가액_천단위
            , CASE
                WHEN AMT_LEN <= 3 THEN TO_CHAR(GL_AMOUNT)
                ELSE SUBSTR(GL_AMOUNT, -3, 3)
              END AS GL_AMOUNT_5      --공급가액_원단위

            , PRESIDENT_NAME        --대표자성명
            , BUSINESS_CONDITION    --업태
            , BUSINESS_ITEM         --종목    
        FROM T  ;
        
    END IF;


END LIST_SUM_TAX;









--매입
PROCEDURE LIST_AP_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
)

AS

BEGIN

    OPEN P_CURSOR FOR

    WITH T AS(
        SELECT
              AA.SUPPLIER_CODE --거래처코드
            , B.TAX_REG_NO                    --사업자등록번호      
            , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --상호(법인명)      
            , AA.COMPANY_CNT  --매수     
            
            , AA.GL_AMOUNT     --공급가액
            , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --출력시 사용할 목적임, 공급가액의 길이
                    
            , B.PRESIDENT_NAME        --대표자성명
            , B.BUSINESS_CONDITION    --업태
            , B.BUSINESS_ITEM         --종목
            , AA.ELEC_FLAG
        FROM
            (
            SELECT
                  A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                , COUNT(*) AS COMPANY_CNT           --매수     
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액    
                , NVL(A.REFER6, 'N') AS ELEC_FLAG 
            FROM FI_SLIP_LINE A
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID 
                AND A.ACCOUNT_CODE = '1111700'  --거래구분 : 매입
                AND A.MANAGEMENT2 = W_TAX_CODE  --사업장
                --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                AND A.REFER1 = '4'  --세무유형
            GROUP BY A.MANAGEMENT1
                   , NVL(A.REFER6, 'N')
            ) AA
            , ( SELECT 
                      SUPP_CUST_CODE        --코드
                    , SUPP_CUST_NAME        --상호
                    , TAX_REG_NO            --사업자등록번호
                    , PRESIDENT_NAME        --대표자성명
                    , BUSINESS_CONDITION    --업태
                    , BUSINESS_ITEM         --종목
                FROM FI_SUPP_CUST_V) B  --거래처    
        WHERE AA.SUPPLIER_CODE = B.SUPP_CUST_CODE(+)
        ORDER BY TAX_REG_NO
    )
    SELECT 
          ROWNUM AS SEQ
        , SUPPLIER_CODE --거래처코드
        , TAX_REG_NO                    --사업자등록번호      
        , SUPPLIER_NAME             --상호(법인명)      
        , COMPANY_CNT  --매수
        
        , GL_AMOUNT     --공급가액    
        , SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS GL_AMOUNT_1      --공급가액_조단위
        , CASE
            WHEN AMT_LEN > 12 THEN SUBSTR(GL_AMOUNT, -12, 3)
            WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
            ELSE ''
          END AS GL_AMOUNT_2      --공급가액_십억단위
        , CASE
            WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -9, 3)
            WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
            ELSE ''
          END AS GL_AMOUNT_3      --공급가액_백만단위
        , CASE
            WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -6, 3)
            WHEN AMT_LEN > 3 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
            ELSE ''
          END AS GL_AMOUNT_4      --공급가액_천단위
        , CASE
            WHEN AMT_LEN <= 3 THEN TO_CHAR(GL_AMOUNT)
            ELSE SUBSTR(GL_AMOUNT, -3, 3)
          END AS GL_AMOUNT_5      --공급가액_원단위

        , PRESIDENT_NAME        --대표자성명
        , BUSINESS_CONDITION    --업태
        , BUSINESS_ITEM         --종목   
        , ELEC_FLAG 
    FROM T  ;

END LIST_AP_SUM_TAX;


--매입 인쇄(전자이외 자료) 
PROCEDURE PRINT_AP_LIST_TAX(
      P_CURSOR1             OUT TYPES.TCURSOR1
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
)

AS

BEGIN

    OPEN P_CURSOR1 FOR

    WITH T AS(
        SELECT
              AA.SUPPLIER_CODE --거래처코드
            , B.TAX_REG_NO                    --사업자등록번호      
            , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --상호(법인명)      
            , AA.COMPANY_CNT  --매수     
            
            , AA.GL_AMOUNT     --공급가액
            , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --출력시 사용할 목적임, 공급가액의 길이
                    
            , B.PRESIDENT_NAME        --대표자성명
            , B.BUSINESS_CONDITION    --업태
            , B.BUSINESS_ITEM         --종목
            , AA.ELEC_FLAG
        FROM
            (
            SELECT
                  A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                , COUNT(*) AS COMPANY_CNT           --매수     
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액    
                , NVL(A.REFER6, 'N') AS ELEC_FLAG 
            FROM FI_SLIP_LINE A
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID 
                AND A.ACCOUNT_CODE = '1111700'  --거래구분 : 매입
                AND A.MANAGEMENT2 = W_TAX_CODE  --사업장
                --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                AND A.REFER1 = '4'  --세무유형
            GROUP BY A.MANAGEMENT1
                   , NVL(A.REFER6, 'N')
            ) AA
            , ( SELECT 
                      SUPP_CUST_CODE        --코드
                    , SUPP_CUST_NAME        --상호
                    , TAX_REG_NO            --사업자등록번호
                    , PRESIDENT_NAME        --대표자성명
                    , BUSINESS_CONDITION    --업태
                    , BUSINESS_ITEM         --종목
                FROM FI_SUPP_CUST_V) B  --거래처    
        WHERE AA.SUPPLIER_CODE = B.SUPP_CUST_CODE(+)
          AND AA.ELEC_FLAG     != 'Y'
        ORDER BY TAX_REG_NO
    )
    SELECT 
          ROWNUM AS SEQ
        , SUPPLIER_CODE --거래처코드
        , TAX_REG_NO                    --사업자등록번호      
        , SUPPLIER_NAME             --상호(법인명)      
        , COMPANY_CNT  --매수
        
        , GL_AMOUNT     --공급가액    
        , SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS GL_AMOUNT_1      --공급가액_조단위
        , CASE
            WHEN AMT_LEN > 12 THEN SUBSTR(GL_AMOUNT, -12, 3)
            WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
            ELSE ''
          END AS GL_AMOUNT_2      --공급가액_십억단위
        , CASE
            WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -9, 3)
            WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
            ELSE ''
          END AS GL_AMOUNT_3      --공급가액_백만단위
        , CASE
            WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -6, 3)
            WHEN AMT_LEN > 3 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
            ELSE ''
          END AS GL_AMOUNT_4      --공급가액_천단위
        , CASE
            WHEN AMT_LEN <= 3 THEN TO_CHAR(GL_AMOUNT)
            ELSE SUBSTR(GL_AMOUNT, -3, 3)
          END AS GL_AMOUNT_5      --공급가액_원단위

        , PRESIDENT_NAME        --대표자성명
        , BUSINESS_CONDITION    --업태
        , BUSINESS_ITEM         --종목   
        , ELEC_FLAG 
    FROM T  ;

END PRINT_AP_LIST_TAX;





--매출
PROCEDURE LIST_AR_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
)

AS

BEGIN
    OPEN P_CURSOR FOR

    WITH T AS(
        SELECT
              AA.SUPPLIER_CODE --거래처코드
            , B.TAX_REG_NO                    --사업자등록번호      
            , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --상호(법인명)      
            , AA.COMPANY_CNT  --매수     
            
            , AA.GL_AMOUNT     --공급가액
            , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --출력시 사용할 목적임, 공급가액의 길이
                    
            , B.PRESIDENT_NAME        --대표자성명
            , B.BUSINESS_CONDITION    --업태
            , B.BUSINESS_ITEM         --종목
            , NVL(AA.TAX_ELECTRO_YN, 'N') AS TAX_ELECTRO_YN
        FROM
            (
            SELECT
                  A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                , COUNT(*) AS COMPANY_CNT           --매수     
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액     
                , NVL(A.REFER7, 'N') AS TAX_ELECTRO_YN
            FROM FI_SLIP_LINE A
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID 
                AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매입
                AND A.REFER11      = W_TAX_CODE  --사업장
                --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                AND A.MANAGEMENT2 = '4'  --세무유형
            GROUP BY A.MANAGEMENT1
                   , NVL(A.REFER7, 'N') 
            ) AA
            , ( SELECT 
                      SUPP_CUST_CODE        --코드
                    , SUPP_CUST_NAME        --상호
                    , TAX_REG_NO            --사업자등록번호
                    , PRESIDENT_NAME        --대표자성명
                    , BUSINESS_CONDITION    --업태
                    , BUSINESS_ITEM         --종목
                FROM FI_SUPP_CUST_V) B  --거래처    
        WHERE AA.SUPPLIER_CODE = B.SUPP_CUST_CODE(+)
        ORDER BY TAX_REG_NO
    )
    SELECT 
          ROWNUM AS SEQ
        , SUPPLIER_CODE --거래처코드
        , TAX_REG_NO                    --사업자등록번호      
        , SUPPLIER_NAME             --상호(법인명)      
        , COMPANY_CNT  --매수
        
        , GL_AMOUNT     --공급가액    
        , SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS GL_AMOUNT_1      --공급가액_조단위
        , CASE
            WHEN AMT_LEN > 12 THEN SUBSTR(GL_AMOUNT, -12, 3)
            WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
            ELSE ''
          END AS GL_AMOUNT_2      --공급가액_십억단위
        , CASE
            WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -9, 3)
            WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
            ELSE ''
          END AS GL_AMOUNT_3      --공급가액_백만단위
        , CASE
            WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -6, 3)
            WHEN AMT_LEN > 3 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
            ELSE ''
          END AS GL_AMOUNT_4      --공급가액_천단위
        , CASE
            WHEN AMT_LEN <= 3 THEN TO_CHAR(GL_AMOUNT)
            ELSE SUBSTR(GL_AMOUNT, -3, 3)
          END AS GL_AMOUNT_5      --공급가액_원단위

        , PRESIDENT_NAME        --대표자성명
        , BUSINESS_CONDITION    --업태
        , BUSINESS_ITEM         --종목  
        , TAX_ELECTRO_YN        -- 전자여부   
    FROM T  ;
    
END LIST_AR_SUM_TAX;

--매출 인쇄(전자이외 자료) 
PROCEDURE PRINT_AR_LIST_TAX(
      P_CURSOR1             OUT TYPES.TCURSOR1
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
)

AS

BEGIN
    OPEN P_CURSOR1 FOR

    WITH T AS(
        SELECT
              AA.SUPPLIER_CODE --거래처코드
            , B.TAX_REG_NO                    --사업자등록번호      
            , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --상호(법인명)      
            , AA.COMPANY_CNT  --매수     
            
            , AA.GL_AMOUNT     --공급가액
            , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --출력시 사용할 목적임, 공급가액의 길이
                    
            , B.PRESIDENT_NAME        --대표자성명
            , B.BUSINESS_CONDITION    --업태
            , B.BUSINESS_ITEM         --종목
        FROM
            (
            SELECT
                  A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                , COUNT(*) AS COMPANY_CNT           --매수     
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액     
            FROM FI_SLIP_LINE A
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID 
                AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매입
                AND A.REFER11      = W_TAX_CODE  --사업장
                --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                AND A.MANAGEMENT2 = '4'  --세무유형
                AND NVL(A.REFER7, 'N') != 'Y'  -- 전자계산서 외 
            GROUP BY A.MANAGEMENT1
            ) AA
            , ( SELECT 
                      SUPP_CUST_CODE        --코드
                    , SUPP_CUST_NAME        --상호
                    , TAX_REG_NO            --사업자등록번호
                    , PRESIDENT_NAME        --대표자성명
                    , BUSINESS_CONDITION    --업태
                    , BUSINESS_ITEM         --종목
                FROM FI_SUPP_CUST_V) B  --거래처    
        WHERE AA.SUPPLIER_CODE = B.SUPP_CUST_CODE(+)
        ORDER BY TAX_REG_NO
    )
    SELECT 
          ROWNUM AS SEQ
        , SUPPLIER_CODE --거래처코드
        , TAX_REG_NO                    --사업자등록번호      
        , SUPPLIER_NAME             --상호(법인명)      
        , COMPANY_CNT  --매수
        
        , GL_AMOUNT     --공급가액    
        , SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS GL_AMOUNT_1      --공급가액_조단위
        , CASE
            WHEN AMT_LEN > 12 THEN SUBSTR(GL_AMOUNT, -12, 3)
            WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
            ELSE ''
          END AS GL_AMOUNT_2      --공급가액_십억단위
        , CASE
            WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -9, 3)
            WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
            ELSE ''
          END AS GL_AMOUNT_3      --공급가액_백만단위
        , CASE
            WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -6, 3)
            WHEN AMT_LEN > 3 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
            ELSE ''
          END AS GL_AMOUNT_4      --공급가액_천단위
        , CASE
            WHEN AMT_LEN <= 3 THEN TO_CHAR(GL_AMOUNT)
            ELSE SUBSTR(GL_AMOUNT, -3, 3)
          END AS GL_AMOUNT_5      --공급가액_원단위

        , PRESIDENT_NAME        --대표자성명
        , BUSINESS_CONDITION    --업태
        , BUSINESS_ITEM         --종목    
    FROM T  ;
    
END PRINT_AR_LIST_TAX;






--세금계산서합계표 상단 출력용
PROCEDURE PRINT_SUM_TAX_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)       
    , W_DEAL_DATE_FR        IN  DATE    --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --거래기간_종료
    , W_CREATE_DATE         IN  DATE    --작성일자 
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          B.VAT_NUMBER                          --사업자등록번호
        , A.CORP_NAME                           --상호(법인명)
        , A.PRESIDENT_NAME                      --성명(대표자)
        , B.ADDR1 || ' ' || B.ADDR2 AS LOCATION --사업장소재지
        , A.TEL_NUMBER                          --전화번호
        , B.BUSINESS_ITEM   --업태
        , B.BUSINESS_TYPE   --업태(종목)
        , B.BUSINESS_ITEM || '(' || B.BUSINESS_TYPE || ')' AS BUSINESS    --업태(종목)        
        
        , TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || ' 년 '
          || TO_NUMBER(TO_CHAR(W_DEAL_DATE_FR, 'MM')) || ' 월 ' || TO_NUMBER(TO_CHAR(W_DEAL_DATE_FR, 'DD'))  || ' 일 ~ '
          || TO_CHAR(W_DEAL_DATE_TO, 'YYYY') || ' 년 '
          || TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'MM')) || ' 월 ' || TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'DD')) || ' 일'
          AS DEAL_TERM   --거래기간        
        
        , TO_CHAR(W_CREATE_DATE, 'YYYY') || '년 ' 
          || TO_NUMBER(TO_CHAR(W_CREATE_DATE, 'MM')) || '월 ' 
          || TO_NUMBER(TO_CHAR(W_CREATE_DATE, 'DD')) || '일 '  AS CREATE_DATE   --작성일자
          
        , '(   ' || TO_CHAR(W_DEAL_DATE_TO, 'YYYY') || '  년   ' ||  
          CASE
            WHEN TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'MM')) <= 6 THEN '제  1  기   )'
            ELSE '제  2  기   )'
          END FISCAL_YEAR   --부가가치세신고기수
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

END PRINT_SUM_TAX_TITLE;






END FI_SUM_TAX_G;
/
