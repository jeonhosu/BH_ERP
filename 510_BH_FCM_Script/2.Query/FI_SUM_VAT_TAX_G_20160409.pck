CREATE OR REPLACE PACKAGE FI_SUM_VAT_TAX_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_SUM_VAT_TAX_G
Description  : 세금계산서합계표 Package

Reference by : calling assmbly-program id(호출 프로그램) : (세금계산서합계표)
Program History :
매입처별세금계산서합계표, 매출처별세금계산서합계표
    -.매출대상자료 : 과세(1), 영세(2)
    -.매입대상자료 : 과세매입(1), 영세매입(2), 매입세액불공제(3), 수입(5), 과세매입매입자발행세금계산서(9)
    -.주민등록번호 발급분은 지금으로서는 고려안한다.
      혹, 이 경우가 발생되면 거래처관리에 주민번호 거래처의 구분값을 추가한 후 그를 기준으로 자료를 도출하면 된다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-22   Leem Dong Ern(임동언)
*****************************************************************************/







--상단 합계부분 조회
--아래의 PROCEDURE를 이용해서 거래구분값을 받아 실행하고 싶은데 C#에서 처리가 안 되어 
--하기의 2개 PROCEDURE(UP_AP_SUM_VAT_TAX, UP_AR_SUM_VAT_TAX)를 추가했다.

PROCEDURE UP_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2      --사업장아이디(예> 110)
    , W_AP_AR_GB            IN  VARCHAR2    --매입/매출 구분(1 : 매입, 2 : 매출)
    
    --신고기간은 화면에는 안 보인다. 신고기간구분을 선택하면 내부적으로 설정된 값을 이용할 뿐이다.
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료
);



--매입

PROCEDURE UP_AP_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    
    --신고기간은 화면에는 안 보인다. 신고기간구분을 선택하면 내부적으로 설정된 값을 이용할 뿐이다.
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료
);







--매출

PROCEDURE UP_AR_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    
    --신고기간은 화면에는 안 보인다. 신고기간구분을 선택하면 내부적으로 설정된 값을 이용할 뿐이다.
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료
);







--상세내역 자료
--아래의 PROCEDURE를 이용해서 거래구분값을 받아 실행하고 싶은데 C#에서 처리가 안 되어 
--하기의 2개 PROCEDURE(LIST_AP_SUM_VAT_TAX, LIST_AR_SUM_VAT_TAX)를 추가했다.

PROCEDURE LIST_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2      --사업장아이디(예> 110)
    , AP_AR_GB              IN  VARCHAR2    --매입/매출 구분(1 : 매입, 2 : 매출)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
    
    -- Y : 전자세금계산서분(15일이내 전송분), N : 전자세금계산서외(전자 15일경과 전송분포함)
    , ELEC_TAX_YN           IN  VARCHAR2    --전자세금계산서여부  
);





--매입

PROCEDURE LIST_AP_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
    
    -- Y : 전자세금계산서분(15일이내 전송분), N : 전자세금계산서외(전자 15일경과 전송분포함)
    , ELEC_TAX_YN           IN  VARCHAR2    --전자세금계산서여부  
);




--매출

PROCEDURE LIST_AR_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
    
    -- Y : 전자세금계산서분(15일이내 전송분), N : 전자세금계산서외(전자 15일경과 전송분포함)
    , ELEC_TAX_YN           IN  VARCHAR2    --전자세금계산서여부  
);




--세금계산서합계표 상단 출력용
PROCEDURE PRINT_SUM_VAT_TAX_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2  --사업장아이디(예>110)       
    , W_DEAL_DATE_FR        IN  DATE    --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --거래기간_종료
    , W_CREATE_DATE         IN  DATE    --작성일자 
);






END FI_SUM_VAT_TAX_G;
/
CREATE OR REPLACE PACKAGE BODY FI_SUM_VAT_TAX_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_SUM_VAT_TAX_G
Description  : 세금계산서합계표 Package

Reference by : calling assmbly-program id(호출 프로그램) : (세금계산서합계표)
Program History :
매입처별세금계산서합계표, 매출처별세금계산서합계표
    -.매출대상자료 : 과세(1), 영세(2)
    -.매입대상자료 : 과세매입(1), 영세매입(2), 매입세액불공제(3), 수입(5), 과세매입매입자발행세금계산서(9)
    -.주민등록번호 발급분은 지금으로서는 고려안한다.
      혹, 이 경우가 발생되면 거래처관리에 주민번호 거래처의 구분값을 추가한 후 그를 기준으로 자료를 도출하면 된다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-22   Leem Dong Ern(임동언)
*****************************************************************************/







--상단 합계부분 조회
PROCEDURE UP_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2      --사업장아이디(예> 110)
    , W_AP_AR_GB            IN  VARCHAR2    --매입/매출 구분(1 : 매입, 2 : 매출)
    
    --신고기간은 화면에는 안 보인다. 신고기간구분을 선택하면 내부적으로 설정된 값을 이용할 뿐이다.
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료
)

AS

BEGIN


    IF W_AP_AR_GB = '1' THEN  --매입
        
        OPEN P_CURSOR FOR
    
        WITH T AS(
            --합계
            SELECT
                  '합    계' AS TITLE
                , COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --매입처수
                , SUM(CNT) AS TOT_RECORD                --매수
                , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --공급가액
                , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --세액
                
                , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --출력시 사용할 목적임, 공급가액의 길이
                , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --출력시 사용할 목적임, 세액의 길이                  
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                        , COUNT(*) AS CNT --매수
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '1111700'  --거래구분 : 매입, 부가세대급금(1111700)
                        AND A.MANAGEMENT2 = W_TAX_CODE  --사업장
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                        AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                        AND A.REFER1 IN ('1', '2', '3', '5', '9')  --세무유형 
                    GROUP BY  A.MANAGEMENT1     
                )

            UNION ALL

            --전자세금계산서분(15일이내 전송분)
            SELECT
                  '전    자' AS TITLE
                , COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --매입처수
                , SUM(CNT) AS TOT_RECORD                --매수
                , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --공급가액
                , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --세액
                
                , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --출력시 사용할 목적임, 공급가액의 길이
                , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --출력시 사용할 목적임, 세액의 길이                  
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                        , COUNT(*) AS CNT --매수
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '1111700'  --거래구분 : 매입, 부가세대급금(1111700)
                        AND A.MANAGEMENT2 = W_TAX_CODE  --사업장
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                        AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                        AND A.REFER1 IN ('1', '2', '3', '5', '9')  --세무유형 
                        AND TRIM(NVL(A.REFER6, 'N')) = 'Y'   --전자세금계산서여부
                    GROUP BY  A.MANAGEMENT1   
                )

            UNION ALL

            --전자세금계산서외(전자 15일경과 전송분포함)
            SELECT
                '전자 외' AS TITLE
                , COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --매입처수
                , SUM(CNT) AS TOT_RECORD                --매수
                , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --공급가액
                , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --세액
                
                , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --출력시 사용할 목적임, 공급가액의 길이
                , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --출력시 사용할 목적임, 세액의 길이                  
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                        , COUNT(*) AS CNT --매수
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '1111700'  --거래구분 : 매입, 부가세대급금(1111700)
                        AND A.MANAGEMENT2 = W_TAX_CODE  --사업장
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                        AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                        AND A.REFER1 IN ('1', '2', '3', '5', '9')  --세무유형 
                        AND TRIM(NVL(A.REFER6, 'N')) = 'N'   --전자세금계산서여부
                    GROUP BY  A.MANAGEMENT1  
                )
        )
        SELECT
              TITLE   
            
            --사업자등록번호 발급받은분
            , COMPANY_CNT AS COM_CNT    --매입처수
            , TOT_RECORD AS COM_REC     --매수
            , TOT_GL_AMOUNT AS COM_GL   --공급가액
            , TOT_VAT_AMOUNT AS COM_VAT --세액
                                    
            , SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS COM_GL_1      --공급가액_조단위
            , CASE
                WHEN AMT_LEN > 12 THEN SUBSTR(TOT_GL_AMOUNT, -12, 3)
                WHEN AMT_LEN > 9 THEN SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
                ELSE ''
              END AS COM_GL_2      --공급가액_십억단위
            , CASE
                WHEN AMT_LEN > 9 THEN SUBSTR(TOT_GL_AMOUNT, -9, 3)
                WHEN AMT_LEN > 6 THEN SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
                ELSE ''
              END AS COM_GL_3      --공급가액_백만단위
            , CASE
                WHEN AMT_LEN > 6 THEN SUBSTR(TOT_GL_AMOUNT, -6, 3)
                WHEN AMT_LEN > 3 THEN SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
                ELSE ''
              END AS COM_GL_4      --공급가액_천단위
            , CASE
                WHEN AMT_LEN <= 3 THEN TO_CHAR(TOT_GL_AMOUNT)
                ELSE SUBSTR(TOT_GL_AMOUNT, -3, 3)
              END AS COM_GL_5      --공급가액_원단위
                
            , SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 12) AS COM_VAT_1      --세액_조단위
            , CASE
                WHEN VAT_LEN > 12 THEN SUBSTR(TOT_VAT_AMOUNT, -12, 3)
                WHEN VAT_LEN > 9 THEN SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 9)
                ELSE ''
              END AS COM_VAT_2      --세액_십억단위
            , CASE
                WHEN VAT_LEN > 9 THEN SUBSTR(TOT_VAT_AMOUNT, -9, 3)
                WHEN VAT_LEN > 6 THEN SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 6)
                ELSE ''
              END AS COM_VAT_3      --세액_백만단위
            , CASE
                WHEN VAT_LEN > 6 THEN SUBSTR(TOT_VAT_AMOUNT, -6, 3)
                WHEN VAT_LEN > 3 THEN SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 3)
                ELSE ''
              END AS COM_VAT_4      --세액_천단위
            , CASE
                WHEN VAT_LEN <= 3 THEN TO_CHAR(TOT_VAT_AMOUNT)
                ELSE SUBSTR(TOT_VAT_AMOUNT, -3, 3)
              END AS COM_VAT_5      --세액_원단위                        
            
            --주민등록번호 발급받은분
            --주민등록번호 발급분은 지금으로서는 고려안한다.
            --혹, 이 경우가 발생되면 거래처관리에 주민번호 거래처의 구분값을 추가한 후 그를 기준으로 자료를 도출하면 된다.
            , 0 AS SN_CNT   --매입처수
            , 0 AS SN_REC   --매수
            , 0 AS SN_GL    --공급가액
            , 0 AS SN_VAT   --세액
            
            --총합계
            , COMPANY_CNT AS TOTAL_CNT      --매입처수
            , TOT_RECORD AS TOTAL_REC       --매수
            , TOT_GL_AMOUNT AS TOTAL_GL     --공급가액
            , TOT_VAT_AMOUNT AS TOTAL_VAT   --세액  
        FROM T  ;
        
    ELSIF W_AP_AR_GB = '2' THEN   --매출
        
        OPEN P_CURSOR FOR
        
        WITH T AS(
            --합계
            SELECT
                  '합    계' AS TITLE
                , COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --매입처수
                , SUM(CNT) AS TOT_RECORD                --매수
                , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --공급가액
                , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --세액
                
                , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --출력시 사용할 목적임, 공급가액의 길이
                , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --출력시 사용할 목적임, 세액의 길이                 
            FROM
                (
                SELECT             
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                    , COUNT(*) AS CNT --매수
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출, 부가세예수금(2100700)
                    AND A.REFER11 = W_TAX_CODE      --사업장
                    --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                    AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                    AND A.MANAGEMENT2 IN ('1', '2')  --세무유형 
                GROUP BY  A.MANAGEMENT1     
                )

            UNION ALL

            --전자세금계산서분(15일이내 전송분)
            SELECT
                  '전    자' AS TITLE
                , COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --매입처수
                , SUM(CNT) AS TOT_RECORD                --매수
                , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --공급가액
                , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --세액
                
                , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --출력시 사용할 목적임, 공급가액의 길이
                , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --출력시 사용할 목적임, 세액의 길이                 
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                        , COUNT(*) AS CNT --매수
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출, 부가세예수금(2100700)
                        AND A.REFER11 = W_TAX_CODE      --사업장
                        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                        AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                        AND A.MANAGEMENT2 IN ('1', '2')  --세무유형
                        AND TRIM(NVL(A.REFER7, 'N')) = 'Y'   --전자세금계산서여부
                    GROUP BY  A.MANAGEMENT1 
                )

            UNION ALL

            --전자세금계산서외(전자 15일경과 전송분포함)
            SELECT
                '전자 외' AS TITLE
                , COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --매입처수
                , SUM(CNT) AS TOT_RECORD                --매수
                , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --공급가액
                , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --세액
                
                , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --출력시 사용할 목적임, 공급가액의 길이
                , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --출력시 사용할 목적임, 세액의 길이                 
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                        , COUNT(*) AS CNT --매수
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출, 부가세예수금(2100700)
                        AND A.REFER11 = W_TAX_CODE      --사업장
                        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                        AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                        AND A.MANAGEMENT2 IN ('1', '2')  --세무유형
                        AND TRIM(NVL(A.REFER7, 'N')) = 'N'   --전자세금계산서여부
                    GROUP BY  A.MANAGEMENT1
                )
        )
        SELECT
              TITLE   
            
            --사업자등록번호 발급받은분
            , COMPANY_CNT AS COM_CNT    --매입처수
            , TOT_RECORD AS COM_REC     --매수
            , TOT_GL_AMOUNT AS COM_GL   --공급가액
            , TOT_VAT_AMOUNT AS COM_VAT --세액
            
                        
            , SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS COM_GL_1      --공급가액_조단위
            , CASE
                WHEN AMT_LEN > 12 THEN SUBSTR(TOT_GL_AMOUNT, -12, 3)
                WHEN AMT_LEN > 9 THEN SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
                ELSE ''
              END AS COM_GL_2      --공급가액_십억단위
            , CASE
                WHEN AMT_LEN > 9 THEN SUBSTR(TOT_GL_AMOUNT, -9, 3)
                WHEN AMT_LEN > 6 THEN SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
                ELSE ''
              END AS COM_GL_3      --공급가액_백만단위
            , CASE
                WHEN AMT_LEN > 6 THEN SUBSTR(TOT_GL_AMOUNT, -6, 3)
                WHEN AMT_LEN > 3 THEN SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
                ELSE ''
              END AS COM_GL_4      --공급가액_천단위
            , CASE
                WHEN AMT_LEN <= 3 THEN TO_CHAR(TOT_GL_AMOUNT)
                ELSE SUBSTR(TOT_GL_AMOUNT, -3, 3)
              END AS COM_GL_5      --공급가액_원단위
                
            , SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 12) AS COM_VAT_1      --세액_조단위
            , CASE
                WHEN VAT_LEN > 12 THEN SUBSTR(TOT_VAT_AMOUNT, -12, 3)
                WHEN VAT_LEN > 9 THEN SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 9)
                ELSE ''
              END AS COM_VAT_2      --세액_십억단위
            , CASE
                WHEN VAT_LEN > 9 THEN SUBSTR(TOT_VAT_AMOUNT, -9, 3)
                WHEN VAT_LEN > 6 THEN SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 6)
                ELSE ''
              END AS COM_VAT_3      --세액_백만단위
            , CASE
                WHEN VAT_LEN > 6 THEN SUBSTR(TOT_VAT_AMOUNT, -6, 3)
                WHEN VAT_LEN > 3 THEN SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 3)
                ELSE ''
              END AS COM_VAT_4      --세액_천단위
            , CASE
                WHEN VAT_LEN <= 3 THEN TO_CHAR(TOT_VAT_AMOUNT)
                ELSE SUBSTR(TOT_VAT_AMOUNT, -3, 3)
              END AS COM_VAT_5      --세액_원단위                        
            
            --주민등록번호 발급받은분
            --주민등록번호 발급분은 지금으로서는 고려안한다.
            --혹, 이 경우가 발생되면 거래처관리에 주민번호 거래처의 구분값을 추가한 후 그를 기준으로 자료를 도출하면 된다.
            , 0 AS SN_CNT   --매입처수
            , 0 AS SN_REC   --매수
            , 0 AS SN_GL    --공급가액
            , 0 AS SN_VAT   --세액
            
            --총합계
            , COMPANY_CNT AS TOTAL_CNT      --매입처수
            , TOT_RECORD AS TOTAL_REC       --매수
            , TOT_GL_AMOUNT AS TOTAL_GL     --공급가액
            , TOT_VAT_AMOUNT AS TOTAL_VAT   --세액  
        FROM T  ;
        
    END IF;

END UP_SUM_VAT_TAX;









--매입
PROCEDURE UP_AP_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    
    --신고기간은 화면에는 안 보인다. 신고기간구분을 선택하면 내부적으로 설정된 값을 이용할 뿐이다.
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료
)

AS

BEGIN
    
    OPEN P_CURSOR FOR

    WITH T AS(
        --합계
        SELECT
              '합    계' AS TITLE
            , COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --매입처수
            , SUM(CNT) AS TOT_RECORD                --매수
            , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --공급가액
            , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --세액
            
            , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --출력시 사용할 목적임, 공급가액의 길이
            , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --출력시 사용할 목적임, 세액의 길이                  
        FROM
            (
                SELECT             
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                    , COUNT(*) AS CNT --매수
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '1111700'  --거래구분 : 매입, 부가세대급금(1111700)
                    AND A.MANAGEMENT2 = W_TAX_CODE  --사업장
                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                    AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                    AND A.REFER1 IN ('1', '2', '3', '5', '9')  --세무유형 
                GROUP BY  A.MANAGEMENT1     
            ) TA

        UNION ALL

        --전자세금계산서분(15일이내 전송분)
        SELECT
              '전    자' AS TITLE
            , COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --매입처수
            , SUM(CNT) AS TOT_RECORD                --매수
            , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --공급가액
            , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --세액
            
            , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --출력시 사용할 목적임, 공급가액의 길이
            , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --출력시 사용할 목적임, 세액의 길이                  
        FROM
            (
                SELECT             
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                    , COUNT(*) AS CNT --매수
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '1111700'  --거래구분 : 매입, 부가세대급금(1111700)
                    AND A.MANAGEMENT2 = W_TAX_CODE  --사업장
                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                    AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                    AND A.REFER1 IN ('1', '2', '3', '5', '9')  --세무유형 
                    AND TRIM(NVL(A.REFER6, 'N')) = 'Y'   --전자세금계산서여부
                GROUP BY  A.MANAGEMENT1   
            ) TB

        UNION ALL

        --전자세금계산서외(전자 15일경과 전송분포함)
        SELECT
            '전자 외' AS TITLE
            , COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --매입처수
            , SUM(CNT) AS TOT_RECORD                --매수
            , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --공급가액
            , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --세액
            
            , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --출력시 사용할 목적임, 공급가액의 길이
            , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --출력시 사용할 목적임, 세액의 길이                  
        FROM
            (
                SELECT             
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                    , COUNT(*) AS CNT --매수
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '1111700'  --거래구분 : 매입, 부가세대급금(1111700)
                    AND A.MANAGEMENT2 = W_TAX_CODE  --사업장
                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                    AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                    AND A.REFER1 IN ('1', '2', '3', '5', '9')  --세무유형 
                    AND TRIM(NVL(A.REFER6, 'N')) = 'N'   --전자세금계산서여부
                GROUP BY  A.MANAGEMENT1  
            ) TC
    )              
    SELECT
          TITLE   
        
        --사업자등록번호 발급받은분
        , COMPANY_CNT AS COM_CNT    --매입처수
        , TOT_RECORD AS COM_REC     --매수
        , TOT_GL_AMOUNT AS COM_GL   --공급가액
        , TOT_VAT_AMOUNT AS COM_VAT --세액
                                
        , SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS COM_GL_1      --공급가액_조단위
        , CASE
            WHEN AMT_LEN > 12 THEN SUBSTR(TOT_GL_AMOUNT, -12, 3)
            WHEN AMT_LEN > 9 THEN SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
            ELSE ''
          END AS COM_GL_2      --공급가액_십억단위
        , CASE
            WHEN AMT_LEN > 9 THEN SUBSTR(TOT_GL_AMOUNT, -9, 3)
            WHEN AMT_LEN > 6 THEN SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
            ELSE ''
          END AS COM_GL_3      --공급가액_백만단위
        , CASE
            WHEN AMT_LEN > 6 THEN SUBSTR(TOT_GL_AMOUNT, -6, 3)
            WHEN AMT_LEN > 3 THEN SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
            ELSE ''
          END AS COM_GL_4      --공급가액_천단위
        , CASE
            WHEN AMT_LEN <= 3 THEN TO_CHAR(TOT_GL_AMOUNT)
            ELSE SUBSTR(TOT_GL_AMOUNT, -3, 3)
          END AS COM_GL_5      --공급가액_원단위
            
        , SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 12) AS COM_VAT_1      --세액_조단위
        , CASE
            WHEN VAT_LEN > 12 THEN SUBSTR(TOT_VAT_AMOUNT, -12, 3)
            WHEN VAT_LEN > 9 THEN SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 9)
            ELSE ''
          END AS COM_VAT_2      --세액_십억단위
        , CASE
            WHEN VAT_LEN > 9 THEN SUBSTR(TOT_VAT_AMOUNT, -9, 3)
            WHEN VAT_LEN > 6 THEN SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 6)
            ELSE ''
          END AS COM_VAT_3      --세액_백만단위
        , CASE
            WHEN VAT_LEN > 6 THEN SUBSTR(TOT_VAT_AMOUNT, -6, 3)
            WHEN VAT_LEN > 3 THEN SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 3)
            ELSE ''
          END AS COM_VAT_4      --세액_천단위
        , CASE
            WHEN VAT_LEN <= 3 THEN TO_CHAR(TOT_VAT_AMOUNT)
            ELSE SUBSTR(TOT_VAT_AMOUNT, -3, 3)
          END AS COM_VAT_5      --세액_원단위                        
        
        --주민등록번호 발급받은분
        --주민등록번호 발급분은 지금으로서는 고려안한다.
        --혹, 이 경우가 발생되면 거래처관리에 주민번호 거래처의 구분값을 추가한 후 그를 기준으로 자료를 도출하면 된다.
        , 0 AS SN_CNT   --매입처수
        , 0 AS SN_REC   --매수
        , 0 AS SN_GL    --공급가액
        , 0 AS SN_VAT   --세액
        
        --총합계
        , COMPANY_CNT AS TOTAL_CNT      --매입처수
        , TOT_RECORD AS TOTAL_REC       --매수
        , TOT_GL_AMOUNT AS TOTAL_GL     --공급가액
        , TOT_VAT_AMOUNT AS TOTAL_VAT   --세액
    FROM T  ;        


END UP_AP_SUM_VAT_TAX;









--매출

PROCEDURE UP_AR_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    
    --신고기간은 화면에는 안 보인다. 신고기간구분을 선택하면 내부적으로 설정된 값을 이용할 뿐이다.
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료
)

AS

BEGIN
   
    OPEN P_CURSOR FOR
    
    WITH T AS(
        --합계
        SELECT
              '합    계' AS TITLE
            , COUNT(SUPPLIER_CODE) AS TOT_CNT   --매입처수
            , SUM(CNT) AS TOT_RECORD                --매수
            , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --공급가액
            , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --세액
            
            , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --출력시 사용할 목적임, 공급가액의 길이
            , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --출력시 사용할 목적임, 세액의 길이                 
            
            -- 사업자번호 
            , COUNT(DECODE(BUSINESS_TYPE_S, 'P', NULL, SUPPLIER_CODE)) AS C_CNT   --매입처수
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, CNT)) AS C_RECORD                --매수
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, GL_AMOUNT)) AS C_GL_AMOUNT       --공급가액
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, VAT_AMOUNT)) AS C_VAT_AMOUNT     --세액
            
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, GL_AMOUNT))) AS C_AMT_LEN     --출력시 사용할 목적임, 공급가액의 길이
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, VAT_AMOUNT))) AS C_VAT_LEN    --출력시 사용할 목적임, 세액의 길이                 
            
            -- 주민번호 -- 
            , COUNT(DECODE(BUSINESS_TYPE_S, 'P', SUPPLIER_CODE, NULL)) AS P_CNT   --매입처수
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', CNT, 0)) AS P_RECORD                --매수
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', GL_AMOUNT, 0)) AS P_GL_AMOUNT       --공급가액
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', VAT_AMOUNT, 0)) AS P_VAT_AMOUNT     --세액
            
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', GL_AMOUNT, 0))) AS P_AMT_LEN     --출력시 사용할 목적임, 공급가액의 길이
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', VAT_AMOUNT, 0))) AS P_VAT_LEN    --출력시 사용할 목적임, 세액의 길이           
        FROM
            (
            SELECT             
                  A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                , NVL((SELECT SC.BUSINESS_TYPE_S
                         FROM FI_SUPP_CUST_V SC
                        WHERE SC.SUPP_CUST_CODE   = A.MANAGEMENT1
                          AND SC.SOB_ID           = A.SOB_ID
                      ), 'C') AS BUSINESS_TYPE_S
                , COUNT(*) AS CNT --매수
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
            FROM FI_SLIP_LINE A
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID 
                AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출, 부가세예수금(2100700)
                AND A.REFER11 = W_TAX_CODE      --사업장
                --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                AND A.MANAGEMENT2 IN ('1', '2')  --세무유형 
            GROUP BY  A.MANAGEMENT1     
                    , A.SOB_ID
            ) TA

        UNION ALL

        --전자세금계산서분(15일이내 전송분)
        SELECT
              '전    자' AS TITLE
            , COUNT(SUPPLIER_CODE) AS TOT_CNT   --매입처수
            , SUM(CNT) AS TOT_RECORD                --매수
            , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --공급가액
            , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --세액
            
            , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --출력시 사용할 목적임, 공급가액의 길이
            , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --출력시 사용할 목적임, 세액의 길이    
            
            -- 사업자번호 
            , COUNT(DECODE(BUSINESS_TYPE_S, 'P', NULL, SUPPLIER_CODE)) AS C_CNT   --매입처수
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, CNT)) AS C_RECORD                --매수
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, GL_AMOUNT)) AS C_GL_AMOUNT       --공급가액
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, VAT_AMOUNT)) AS C_VAT_AMOUNT     --세액
            
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, GL_AMOUNT))) AS C_AMT_LEN     --출력시 사용할 목적임, 공급가액의 길이
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, VAT_AMOUNT))) AS C_VAT_LEN    --출력시 사용할 목적임, 세액의 길이                 
            
            -- 주민번호 -- 
            , COUNT(DECODE(BUSINESS_TYPE_S, 'P', SUPPLIER_CODE, NULL)) AS P_CNT   --매입처수
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', CNT, 0)) AS P_RECORD                --매수
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', GL_AMOUNT, 0)) AS P_GL_AMOUNT       --공급가액
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', VAT_AMOUNT, 0)) AS P_VAT_AMOUNT     --세액
            
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', GL_AMOUNT, 0))) AS P_AMT_LEN     --출력시 사용할 목적임, 공급가액의 길이
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', VAT_AMOUNT, 0))) AS P_VAT_LEN    --출력시 사용할 목적임, 세액의 길이                            
        FROM
            (
                SELECT             
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                    , NVL((SELECT SC.BUSINESS_TYPE_S
                         FROM FI_SUPP_CUST_V SC
                        WHERE SC.SUPP_CUST_CODE   = A.MANAGEMENT1
                          AND SC.SOB_ID           = A.SOB_ID
                      ), 'C') AS BUSINESS_TYPE_S
                    , COUNT(*) AS CNT --매수
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출, 부가세예수금(2100700)
                    AND A.REFER11 = W_TAX_CODE      --사업장
                    --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                    AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                    AND A.MANAGEMENT2 IN ('1', '2')  --세무유형
                    AND TRIM(NVL(A.REFER7, 'N')) = 'Y'   --전자세금계산서여부
                GROUP BY  A.MANAGEMENT1     
                        , A.SOB_ID 
            ) TB

        UNION ALL

        --전자세금계산서외(전자 15일경과 전송분포함)
        SELECT
            '전자 외' AS TITLE
            , COUNT(SUPPLIER_CODE) AS TOT_CNT   --매입처수
            , SUM(CNT) AS TOT_RECORD                --매수
            , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --공급가액
            , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --세액
            
            , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --출력시 사용할 목적임, 공급가액의 길이
            , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --출력시 사용할 목적임, 세액의 길이      
            
            -- 사업자번호 
            , COUNT(DECODE(BUSINESS_TYPE_S, 'P', NULL, SUPPLIER_CODE)) AS C_CNT   --매입처수
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, CNT)) AS C_RECORD                --매수
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, GL_AMOUNT)) AS C_GL_AMOUNT       --공급가액
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, VAT_AMOUNT)) AS C_VAT_AMOUNT     --세액
            
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, GL_AMOUNT))) AS C_AMT_LEN     --출력시 사용할 목적임, 공급가액의 길이
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, VAT_AMOUNT))) AS C_VAT_LEN    --출력시 사용할 목적임, 세액의 길이                 
            
            -- 주민번호 -- 
            , COUNT(DECODE(BUSINESS_TYPE_S, 'P', SUPPLIER_CODE, NULL)) AS P_CNT   --매입처수
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', CNT, 0)) AS P_RECORD                --매수
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', GL_AMOUNT, 0)) AS P_GL_AMOUNT       --공급가액
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', VAT_AMOUNT, 0)) AS P_VAT_AMOUNT     --세액
            
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', GL_AMOUNT, 0))) AS P_AMT_LEN     --출력시 사용할 목적임, 공급가액의 길이
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', VAT_AMOUNT, 0))) AS P_VAT_LEN    --출력시 사용할 목적임, 세액의 길이                           
        FROM
            (
                SELECT             
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                    , NVL((SELECT SC.BUSINESS_TYPE_S
                         FROM FI_SUPP_CUST_V SC
                        WHERE SC.SUPP_CUST_CODE   = A.MANAGEMENT1
                          AND SC.SOB_ID           = A.SOB_ID
                      ), 'C') AS BUSINESS_TYPE_S
                    , COUNT(*) AS CNT --매수
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출, 부가세예수금(2100700)
                    AND A.REFER11 = W_TAX_CODE      --사업장
                    --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                    AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                    AND A.MANAGEMENT2 IN ('1', '2')  --세무유형
                    AND TRIM(NVL(A.REFER7, 'N')) = 'N'   --전자세금계산서여부
                GROUP BY  A.MANAGEMENT1
                        , A.SOB_ID 
            ) TC
    )        
    SELECT
          TITLE   
        
        --사업자등록번호 발급받은분
        , C_CNT AS COM_CNT                 --매입처수
        , C_RECORD AS COM_REC              --매수
        , C_GL_AMOUNT AS COM_GL            --공급가액
        , C_VAT_AMOUNT AS COM_VAT          --세액
        
        , REPLACE(SUBSTR(LPAD(C_GL_AMOUNT, 15, '*'), -15, 3), '*', '') AS COM_GL_1
        , REPLACE(SUBSTR(LPAD(C_GL_AMOUNT, 15, '*'), -12, 3), '*', '') AS COM_GL_2
        , REPLACE(SUBSTR(LPAD(C_GL_AMOUNT, 15, '*'), -9, 3), '*', '') AS COM_GL_3
        , REPLACE(SUBSTR(LPAD(C_GL_AMOUNT, 15, '*'), -6, 3), '*', '') AS COM_GL_4
        , REPLACE(SUBSTR(LPAD(C_GL_AMOUNT, 15, '*'), -3, 3), '*', '') AS COM_GL_5
        , REPLACE(SUBSTR(LPAD(C_VAT_AMOUNT, 15, '*'), -15, 3), '*', '') AS COM_VAT_1
        , REPLACE(SUBSTR(LPAD(C_VAT_AMOUNT, 15, '*'), -12, 3), '*', '') AS COM_VAT_2
        , REPLACE(SUBSTR(LPAD(C_VAT_AMOUNT, 15, '*'), -9, 3), '*', '') AS COM_VAT_3
        , REPLACE(SUBSTR(LPAD(C_VAT_AMOUNT, 15, '*'), -6, 3), '*', '') AS COM_VAT_4
        , REPLACE(SUBSTR(LPAD(C_VAT_AMOUNT, 15, '*'), -3, 3), '*', '') AS COM_VAT_5
         
        --주민등록번호 발급받은분
        --주민등록번호 발급분은 지금으로서는 고려안한다.
        --혹, 이 경우가 발생되면 거래처관리에 주민번호 거래처의 구분값을 추가한 후 그를 기준으로 자료를 도출하면 된다.
        , P_CNT AS SN_CNT                 --매입처수
        , P_RECORD AS SN_REC              --매수
        , P_GL_AMOUNT AS SN_GL            --공급가액
        , P_VAT_AMOUNT AS SN_VAT          --세액 
        
        , REPLACE(SUBSTR(LPAD(P_GL_AMOUNT, 15, '*'), -15, 3), '*', '') AS SN_GL_1
        , REPLACE(SUBSTR(LPAD(P_GL_AMOUNT, 15, '*'), -12, 3), '*', '') AS SN_GL_2
        , REPLACE(SUBSTR(LPAD(P_GL_AMOUNT, 15, '*'), -9, 3), '*', '') AS SN_GL_3
        , REPLACE(SUBSTR(LPAD(P_GL_AMOUNT, 15, '*'), -6, 3), '*', '') AS SN_GL_4
        , REPLACE(SUBSTR(LPAD(P_GL_AMOUNT, 15, '*'), -3, 3), '*', '') AS SN_GL_5
        , REPLACE(SUBSTR(LPAD(P_VAT_AMOUNT, 15, '*'), -15, 3), '*', '') AS SN_VAT_1
        , REPLACE(SUBSTR(LPAD(P_VAT_AMOUNT, 15, '*'), -12, 3), '*', '') AS SN_VAT_2
        , REPLACE(SUBSTR(LPAD(P_VAT_AMOUNT, 15, '*'), -9, 3), '*', '') AS SN_VAT_3
        , REPLACE(SUBSTR(LPAD(P_VAT_AMOUNT, 15, '*'), -6, 3), '*', '') AS SN_VAT_4
        , REPLACE(SUBSTR(LPAD(P_VAT_AMOUNT, 15, '*'), -3, 3), '*', '') AS SN_VAT_5  
          
        --총합계
        , TOT_CNT AS TOTAL_CNT          --매입처수
        , TOT_RECORD AS TOTAL_REC       --매수
        , TOT_GL_AMOUNT AS TOTAL_GL     --공급가액
        , TOT_VAT_AMOUNT AS TOTAL_VAT   --세액  
        
        , REPLACE(SUBSTR(LPAD(TOT_GL_AMOUNT, 15, '*'), -15, 3), '*', '') AS TOTAL_GL_1
        , REPLACE(SUBSTR(LPAD(TOT_GL_AMOUNT, 15, '*'), -12, 3), '*', '') AS TOTAL_GL_2
        , REPLACE(SUBSTR(LPAD(TOT_GL_AMOUNT, 15, '*'), -9, 3), '*', '') AS TOTAL_GL_3
        , REPLACE(SUBSTR(LPAD(TOT_GL_AMOUNT, 15, '*'), -6, 3), '*', '') AS TOTAL_GL_4
        , REPLACE(SUBSTR(LPAD(TOT_GL_AMOUNT, 15, '*'), -3, 3), '*', '') AS TOTAL_GL_5
        , REPLACE(SUBSTR(LPAD(TOT_VAT_AMOUNT, 15, '*'), -15, 3), '*', '') AS TOTAL_VAT_1
        , REPLACE(SUBSTR(LPAD(TOT_VAT_AMOUNT, 15, '*'), -12, 3), '*', '') AS TOTAL_VAT_2
        , REPLACE(SUBSTR(LPAD(TOT_VAT_AMOUNT, 15, '*'), -9, 3), '*', '') AS TOTAL_VAT_3
        , REPLACE(SUBSTR(LPAD(TOT_VAT_AMOUNT, 15, '*'), -6, 3), '*', '') AS TOTAL_VAT_4
        , REPLACE(SUBSTR(LPAD(TOT_VAT_AMOUNT, 15, '*'), -3, 3), '*', '') AS TOTAL_VAT_5
    FROM T  ; 


END UP_AR_SUM_VAT_TAX;







--상세내역 자료
PROCEDURE LIST_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2      --사업장아이디(예> 110)
    , AP_AR_GB              IN  VARCHAR2    --매입/매출 구분(1 : 매입, 2 : 매출)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
    
    -- Y : 전자세금계산서분(15일이내 전송분), N : 전자세금계산서외(전자 15일경과 전송분포함)
    , ELEC_TAX_YN           IN  VARCHAR2    --전자세금계산서여부  
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
                , AA.VAT_AMOUNT    --세액 
                , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --출력시 사용할 목적임, 공급가액의 길이
                , LENGTH(AA.VAT_AMOUNT) AS VAT_LEN   --출력시 사용할 목적임, 세액의 길이        
                
                , B.PRESIDENT_NAME        --대표자성명
                , B.BUSINESS_CONDITION    --업태
                , B.BUSINESS_ITEM         --종목
            FROM
                (
                SELECT
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                    , COUNT(*) AS COMPANY_CNT           --매수     
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액     
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '1111700'  --거래구분 : 매입, 부가세대급금(1111700)
                    AND A.MANAGEMENT2 = W_TAX_CODE  --사업장
                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                    AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                    AND A.REFER1 IN ('1', '2', '3', '5', '9')  --세무유형
                    AND TRIM(NVL(A.REFER6, 'N')) = ELEC_TAX_YN   --전자세금계산서여부
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
                
            , VAT_AMOUNT    --세액
            , SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 12) AS VAT_AMOUNT_1      --세액_조단위
            , CASE
                WHEN VAT_LEN > 12 THEN SUBSTR(VAT_AMOUNT, -12, 3)
                WHEN VAT_LEN > 9 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 9)
                ELSE ''
              END AS VAT_AMOUNT_2      --세액_십억단위
            , CASE
                WHEN VAT_LEN > 9 THEN SUBSTR(VAT_AMOUNT, -9, 3)
                WHEN VAT_LEN > 6 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 6)
                ELSE ''
              END AS VAT_AMOUNT_3      --세액_백만단위
            , CASE
                WHEN VAT_LEN > 6 THEN SUBSTR(VAT_AMOUNT, -6, 3)
                WHEN VAT_LEN > 3 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 3)
                ELSE ''
              END AS VAT_AMOUNT_4      --세액_천단위
            , CASE
                WHEN VAT_LEN <= 3 THEN TO_CHAR(VAT_AMOUNT)
                ELSE SUBSTR(VAT_AMOUNT, -3, 3)
              END AS VAT_AMOUNT_5      --세액_원단위

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
                , AA.VAT_AMOUNT    --세액 
                , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --출력시 사용할 목적임, 공급가액의 길이
                , LENGTH(AA.VAT_AMOUNT) AS VAT_LEN   --출력시 사용할 목적임, 세액의 길이        
                
                , B.PRESIDENT_NAME        --대표자성명
                , B.BUSINESS_CONDITION    --업태
                , B.BUSINESS_ITEM         --종목
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                        , COUNT(*) AS COMPANY_CNT --매수
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출, 부가세예수금(2100700)
                        AND A.REFER11 = W_TAX_CODE      --사업장
                        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                        AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                        AND A.MANAGEMENT2 IN ('1', '2')  --세무유형
                        AND TRIM(NVL(A.REFER7, 'N')) = ELEC_TAX_YN   --전자세금계산서여부
                    GROUP BY  A.MANAGEMENT1 
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
                
            , VAT_AMOUNT    --세액
            , SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 12) AS VAT_AMOUNT_1      --세액_조단위
            , CASE
                WHEN VAT_LEN > 12 THEN SUBSTR(VAT_AMOUNT, -12, 3)
                WHEN VAT_LEN > 9 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 9)
                ELSE ''
              END AS VAT_AMOUNT_2      --세액_십억단위
            , CASE
                WHEN VAT_LEN > 9 THEN SUBSTR(VAT_AMOUNT, -9, 3)
                WHEN VAT_LEN > 6 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 6)
                ELSE ''
              END AS VAT_AMOUNT_3      --세액_백만단위
            , CASE
                WHEN VAT_LEN > 6 THEN SUBSTR(VAT_AMOUNT, -6, 3)
                WHEN VAT_LEN > 3 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 3)
                ELSE ''
              END AS VAT_AMOUNT_4      --세액_천단위
            , CASE
                WHEN VAT_LEN <= 3 THEN TO_CHAR(VAT_AMOUNT)
                ELSE SUBSTR(VAT_AMOUNT, -3, 3)
              END AS VAT_AMOUNT_5      --세액_원단위

            , PRESIDENT_NAME        --대표자성명
            , BUSINESS_CONDITION    --업태
            , BUSINESS_ITEM         --종목    
        FROM T  ;

    END IF;


END LIST_SUM_VAT_TAX;









--매입

PROCEDURE LIST_AP_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
    
    -- Y : 전자세금계산서분(15일이내 전송분), N : 전자세금계산서외(전자 15일경과 전송분포함)
    , ELEC_TAX_YN           IN  VARCHAR2    --전자세금계산서여부  
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
            , AA.VAT_AMOUNT    --세액 
            , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --출력시 사용할 목적임, 공급가액의 길이
            , LENGTH(AA.VAT_AMOUNT) AS VAT_LEN   --출력시 사용할 목적임, 세액의 길이        
            
            , B.PRESIDENT_NAME        --대표자성명
            , B.BUSINESS_CONDITION    --업태
            , B.BUSINESS_ITEM         --종목
        FROM
            (
            SELECT
                  A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                , COUNT(*) AS COMPANY_CNT           --매수     
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액     
            FROM FI_SLIP_LINE A
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID 
                AND A.ACCOUNT_CODE = '1111700'  --거래구분 : 매입, 부가세대급금(1111700)
                AND A.MANAGEMENT2 = W_TAX_CODE  --사업장
                --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                AND A.REFER1 IN ('1', '2', '3', '5', '9')  --세무유형
                AND TRIM(NVL(A.REFER6, 'N')) = ELEC_TAX_YN   --전자세금계산서여부
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
            
        , VAT_AMOUNT    --세액
        , SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 12) AS VAT_AMOUNT_1      --세액_조단위
        , CASE
            WHEN VAT_LEN > 12 THEN SUBSTR(VAT_AMOUNT, -12, 3)
            WHEN VAT_LEN > 9 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 9)
            ELSE ''
          END AS VAT_AMOUNT_2      --세액_십억단위
        , CASE
            WHEN VAT_LEN > 9 THEN SUBSTR(VAT_AMOUNT, -9, 3)
            WHEN VAT_LEN > 6 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 6)
            ELSE ''
          END AS VAT_AMOUNT_3      --세액_백만단위
        , CASE
            WHEN VAT_LEN > 6 THEN SUBSTR(VAT_AMOUNT, -6, 3)
            WHEN VAT_LEN > 3 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 3)
            ELSE ''
          END AS VAT_AMOUNT_4      --세액_천단위
        , CASE
            WHEN VAT_LEN <= 3 THEN TO_CHAR(VAT_AMOUNT)
            ELSE SUBSTR(VAT_AMOUNT, -3, 3)
          END AS VAT_AMOUNT_5      --세액_원단위

        , PRESIDENT_NAME        --대표자성명
        , BUSINESS_CONDITION    --업태
        , BUSINESS_ITEM         --종목    
    FROM T  ;

END LIST_AP_SUM_VAT_TAX;










--매출
PROCEDURE LIST_AR_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --회사아이디
    , W_ORG_ID              IN  NUMBER      --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2    --사업장아이디(예> 110)
    , W_DEAL_DATE_FR        IN  DATE        --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE        --거래기간_종료
    
    -- Y : 전자세금계산서분(15일이내 전송분), N : 전자세금계산서외(전자 15일경과 전송분포함)
    , ELEC_TAX_YN           IN  VARCHAR2    --전자세금계산서여부  
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
            , AA.VAT_AMOUNT    --세액 
            , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --출력시 사용할 목적임, 공급가액의 길이
            , LENGTH(AA.VAT_AMOUNT) AS VAT_LEN   --출력시 사용할 목적임, 세액의 길이        
            
            , B.PRESIDENT_NAME        --대표자성명
            , B.BUSINESS_CONDITION    --업태
            , B.BUSINESS_ITEM         --종목
        FROM
            (
                SELECT             
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                    , COUNT(*) AS COMPANY_CNT --매수
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --공급가액
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --세액
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출, 부가세예수금(2100700)
                    AND A.REFER11 = W_TAX_CODE      --사업장
                    --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
                    AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
                    AND A.MANAGEMENT2 IN ('1', '2')  --세무유형
                    AND TRIM(NVL(A.REFER7, 'N')) = ELEC_TAX_YN   --전자세금계산서여부
                GROUP BY  A.MANAGEMENT1 
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
            
        , VAT_AMOUNT    --세액
        , SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 12) AS VAT_AMOUNT_1      --세액_조단위
        , CASE
            WHEN VAT_LEN > 12 THEN SUBSTR(VAT_AMOUNT, -12, 3)
            WHEN VAT_LEN > 9 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 9)
            ELSE ''
          END AS VAT_AMOUNT_2      --세액_십억단위
        , CASE
            WHEN VAT_LEN > 9 THEN SUBSTR(VAT_AMOUNT, -9, 3)
            WHEN VAT_LEN > 6 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 6)
            ELSE ''
          END AS VAT_AMOUNT_3      --세액_백만단위
        , CASE
            WHEN VAT_LEN > 6 THEN SUBSTR(VAT_AMOUNT, -6, 3)
            WHEN VAT_LEN > 3 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 3)
            ELSE ''
          END AS VAT_AMOUNT_4      --세액_천단위
        , CASE
            WHEN VAT_LEN <= 3 THEN TO_CHAR(VAT_AMOUNT)
            ELSE SUBSTR(VAT_AMOUNT, -3, 3)
          END AS VAT_AMOUNT_5      --세액_원단위

        , PRESIDENT_NAME        --대표자성명
        , BUSINESS_CONDITION    --업태
        , BUSINESS_ITEM         --종목    
    FROM T  ;

END LIST_AR_SUM_VAT_TAX;








--세금계산서합계표 상단 출력용
PROCEDURE PRINT_SUM_VAT_TAX_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2  --사업장아이디(예>110)       
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
        AND B.ENABLED_FLAG          = 'Y'
        AND (B.DEFAULT_FLAG         = 'Y'
        OR   ROWNUM                 <= 1);


END PRINT_SUM_VAT_TAX_TITLE;






END FI_SUM_VAT_TAX_G;
/
