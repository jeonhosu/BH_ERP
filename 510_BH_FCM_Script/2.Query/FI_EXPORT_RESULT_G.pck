CREATE OR REPLACE PACKAGE FI_EXPORT_RESULT_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_EXPORT_RESULT_G
Description  : 수출실적명세서 Package

Reference by : calling assmbly-program id(호출 프로그램) : (수출실적명세서)
Program History :
    -.자료 추출 기준 : 부가세예수금 계정 자료 중 세무유형이 [수출]인 자료이다.
      이는 [매입매출장]프로그램에서 거래구분을 매출로 세무유형을 수출로 조회한 자료와 일치한다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-20   Leem Dong Ern(임동언)
*****************************************************************************/




--상단 합계 부분 조회
PROCEDURE UP_EXPORT_RESULT(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2  --사업장아이디(예> 110)
    
    --신고기간은 화면에는 안 보인다. 신고기간구분을 선택하면 내부적으로 설정된 값을 이용할 뿐이다.
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료
);





--상세 내역 자료
PROCEDURE LIST_EXPORT_RESULT(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2  --사업장아이디(예> 110)
    
    --신고기간은 화면에는 안 보인다. 신고기간구분을 선택하면 내부적으로 설정된 값을 이용할 뿐이다.
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료 
);








--수출실적명세서 상단 출력용
PROCEDURE PRINT_EXPORT_RESULT_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2  --사업장아이디(예>42)       
    , W_DEAL_DATE_FR        IN  DATE    --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --거래기간_종료
    , W_CREATE_DATE         IN  DATE    --작성일자 
);






END FI_EXPORT_RESULT_G;
/
CREATE OR REPLACE PACKAGE BODY FI_EXPORT_RESULT_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_EXPORT_RESULT_G
Description  : 수출실적명세서 Package

Reference by : calling assmbly-program id(호출 프로그램) : FCMF0873(수출실적명세서)
Program History :
    -.자료 추출 기준 : 부가세예수금 계정 자료 중 세무유형이 [수출]인 자료이다.
      이는 [매입매출장]프로그램에서 거래구분을 매출로 세무유형을 수출로 조회한 자료와 일치한다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-20   Leem Dong Ern(임동언)
*****************************************************************************/






--상단 합계 부분 조회
PROCEDURE UP_EXPORT_RESULT(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2  --사업장아이디(예> 110)
    
    --신고기간은 화면에는 안 보인다. 신고기간구분을 선택하면 내부적으로 설정된 값을 이용할 뿐이다.
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          '9' SEQ
        , '합             계' AS GUBUN    --구분
        , COUNT(*) AS DATA_CNT            --건수
        , SUM(TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', ''))) AS CURRENCY_AMOUNT   --외화금액
        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT --원화금액
        , '' REMARKS    --비고
    FROM FI_SLIP_LINE A
    WHERE   A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출
        AND MANAGEMENT2 = '3'           --세무유형 : 수출        
        AND A.REFER11 = W_TAX_CODE      --사업장(법인/사업장의 사업장이 아닌 회계 자료에 일반적으로 사용되는 사업장임)
        
        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
        AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO --신고기준일자

    UNION ALL

    SELECT
         '10' SEQ
        , '수  출   재  화' AS GUBUN    --구분
        , COUNT(*) AS DATA_CNT          --건수
        , SUM(TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', ''))) AS CURRENCY_AMOUNT   --외화금액
        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT --원화금액
        , '' REMARKS    --비고
    FROM FI_SLIP_LINE A
    WHERE   A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출
        AND MANAGEMENT2 = '3'           --세무유형 : 수출 
        AND A.REFER4 IS NOT NULL
        AND A.REFER11 = W_TAX_CODE      --사업장(법인/사업장의 사업장이 아닌 회계 자료에 일반적으로 사용되는 사업장임)
        
        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
        AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO --신고기준일자

    UNION ALL

    SELECT
         '11' SEQ
        , '기타영세율적용' AS GUBUN    --구분
        , COUNT(*) AS DATA_CNT         --건수
        , SUM(TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', ''))) AS CURRENCY_AMOUNT   --외화금액
        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT --원화금액
        , '' REMARKS    --비고
    FROM FI_SLIP_LINE A
    WHERE   A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출
        AND MANAGEMENT2 = '3'           --세무유형 : 수출    
        AND A.REFER4 IS NULL
        AND A.REFER11 = W_TAX_CODE      --사업장(법인/사업장의 사업장이 아닌 회계 자료에 일반적으로 사용되는 사업장임)
        
        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
        AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO --신고기준일자
    ;


END UP_EXPORT_RESULT;








--상세 내역 자료
PROCEDURE LIST_EXPORT_RESULT(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2  --사업장아이디(예> 110)
    
    --신고기간은 화면에는 안 보인다. 신고기간구분을 선택하면 내부적으로 설정된 값을 이용할 뿐이다.
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료 
)

AS

BEGIN

    OPEN P_CURSOR FOR

    WITH T AS(
        SELECT
              A.REFER4 AS EXPORT_NO         --수출신고번호 
            , A.REFER1 AS VAT_ISSUE_DATE    --선(기)적일자 ; 신고기준일자        
            , A.REFER3 AS CURRENCY_CODE     --통화코드
            , TO_NUMBER(REPLACE(TRIM(A.REFER6), ',', '')) AS EXCHANGE_RATE     --환율
            , TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', '')) AS CURRENCY_AMOUNT   --외화금액
            , TO_CHAR(REPLACE(TRIM(A.REFER6), ',', ''), '9999999999.00') AS PRINT_EXCHANGE_RATE         --환율_출력용
            , TO_CHAR(REPLACE(TRIM(A.REFER5), ',', ''), '9999999999999.00') AS PRINT_CURRENCY_AMOUNT    --외화금액_출력용
            , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', '')) AS GL_AMOUNT     --원화; 공급가액
            
            --, ROUND(TO_NUMBER(REPLACE(TRIM(A.REFER6), ',', '')) * TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', '')))  AS B
            , DECODE(ROUND(TO_NUMBER(REPLACE(TRIM(A.REFER6), ',', '')) * TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', ''))) 
                        - TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0))
                    , ',', '')), 0, 'N', 'Y') AS AMT_CHECK  --금액확인 ; (환율 * 외화금액)과 원화를 비교한다.
        FROM FI_SLIP_LINE A
        WHERE   A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            AND A.ACCOUNT_CODE = '2100700'  --거래구분 : 매출
            AND MANAGEMENT2 = '3'           --세무유형 : 수출
            AND A.REFER4 IS NOT NULL
            AND A.REFER11 = W_TAX_CODE      --사업장(법인/사업장의 사업장이 아닌 회계 자료에 일반적으로 사용되는 사업장임)
            
            --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --신고기준일자
            AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO --신고기준일자        
        ORDER BY VAT_ISSUE_DATE
    )
    SELECT 
          ROWNUM SEQ
        , T.*
    FROM T;    


END LIST_EXPORT_RESULT;







--수출실적명세서 상단 출력용
PROCEDURE PRINT_EXPORT_RESULT_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2  --사업장아이디(예>42)       
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
          || TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'MM')) || ' 월 ' || TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'DD')) || ' 일'
          AS DEAL_TERM   --거래기간        
        
        , TO_CHAR(W_CREATE_DATE, 'YYYY.MM.DD') AS CREATE_DATE   --작성일자
        , '(   ' || TO_CHAR(W_DEAL_DATE_TO, 'YYYY') || '  년   ' ||  
          CASE
            WHEN TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'MM')) <= 6 THEN '1  기   )'
            ELSE '2  기   )'
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


END PRINT_EXPORT_RESULT_TITLE;






END FI_EXPORT_RESULT_G;
/
