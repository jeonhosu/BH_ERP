CREATE OR REPLACE PACKAGE FI_ZERO_TAX_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_ZERO_TAX_SPEC_G
Description  : 영세율첨부서류제출명세서 Package

Reference by : calling assmbly-program id(호출 프로그램) : FCMF0873(영세율첨부서류제출명세서)
Program History :
    -.참조>이 자료는 작업자가 부가가치세신고와 관련하여 직접 입력하는 자료로 전표와는 무관한다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-14   Leem Dong Ern(임동언)
*****************************************************************************/






--제출사유 기본값 설정용
PROCEDURE SET_ZERO_TAX_RATE_REASON(
      W_SOB_ID                  IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE    --회사아이디
    , W_ORG_ID                  IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE    --사업부아이디
    , O_ZERO_TAX_RATE_REASON_CD OUT VARCHAR2    --제출사유코드
    , O_ZERO_TAX_RATE_REASON_NM OUT VARCHAR2    --제출사유  
);







--grid에 조회되는 자료 추출
PROCEDURE LIST_ZERO_TAX_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID                  IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE                IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --사업장아이디(예>42)    
    , W_VAT_MNG_SERIAL          IN  FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --부가세신고기간구분번호
    , W_ZERO_TAX_RATE_REASON    IN  FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --제출사유    
    , W_PUBLISH_DATE_FR         IN  FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE          --발급기간_시작
    , W_PUBLISH_DATE_TO         IN  FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE          --발급기간_종료
);







--grid에 조회되는 자료 중 금액자료들에 대한 합계
PROCEDURE SUM_ZERO_TAX_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID                  IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE                IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --사업장아이디(예>42)    
    , W_VAT_MNG_SERIAL          IN  FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --부가세신고기간구분번호
    , W_ZERO_TAX_RATE_REASON    IN  FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --제출사유    
    , W_PUBLISH_DATE_FR         IN  FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE          --발급기간_시작
    , W_PUBLISH_DATE_TO         IN  FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE          --발급기간_종료
);





--grid에 신규 항목 추가
PROCEDURE INSERT_ZERO_TAX_SPEC(
      P_SOB_ID	                IN 	FI_ZERO_TAX_SPEC.SOB_ID%TYPE	            --회사아이디
    , P_ORG_ID	                IN 	FI_ZERO_TAX_SPEC.ORG_ID%TYPE	            --사업부아이디
    , P_TAX_CODE                IN 	FI_ZERO_TAX_SPEC.TAX_CODE%TYPE            --사업장아이디   
    , P_VAT_MNG_SERIAL          IN 	FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --부가세신고기간구분번호
    , P_ZERO_TAX_RATE_REASON    IN 	FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --제출사유    
    , P_DOC_NAME	              IN 	FI_ZERO_TAX_SPEC.DOC_NAME%TYPE	            --서류명    
    , P_PUBLISHER	              IN 	FI_ZERO_TAX_SPEC.PUBLISHER%TYPE	            --발급자    
    , P_PUBLISH_DATE	          IN	FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE	        --발급일자    
    , P_SHIPPING_DATE	          IN	FI_ZERO_TAX_SPEC.SHIPPING_DATE%TYPE	        --선적일자    
    , P_CURRENCY_CODE           IN	FI_ZERO_TAX_SPEC.CURRENCY_CODE%TYPE	        --통화코드    
    , P_EXCHANGE_RATE	          IN	FI_ZERO_TAX_SPEC.EXCHANGE_RATE%TYPE	        --환율    
    , P_SUBMIT_FOREIGN_AMT	    IN	FI_ZERO_TAX_SPEC.SUBMIT_FOREIGN_AMT%TYPE    --당기제출외화    
    , P_SUBMIT_KOREAN_AMT	      IN	FI_ZERO_TAX_SPEC.SUBMIT_KOREAN_AMT%TYPE	    --당기제출원화    
    , P_REPORT_FOREIGN_AMT	    IN	FI_ZERO_TAX_SPEC.REPORT_FOREIGN_AMT%TYPE	--당기신고외화
    , P_REPORT_KOREAN_AMT       IN	FI_ZERO_TAX_SPEC.REPORT_KOREAN_AMT%TYPE	    --당기신고원화
    , P_CREATED_BY	            IN	FI_ZERO_TAX_SPEC.CREATED_BY%TYPE	        --생성자
);





--grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_ZERO_TAX_SPEC(
      W_SOB_ID	                IN 	FI_ZERO_TAX_SPEC.SOB_ID%TYPE	            --회사아이디
    , W_ORG_ID	                IN 	FI_ZERO_TAX_SPEC.ORG_ID%TYPE	            --사업부아이디
    , W_TAX_CODE                IN 	FI_ZERO_TAX_SPEC.TAX_CODE%TYPE     --사업장아이디
    , W_VAT_MNG_SERIAL          IN 	FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --부가세신고기간구분번호
    , W_ZERO_TAX_RATE_REASON    IN 	FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --제출사유    
    , W_SPEC_SERIAL             IN 	FI_ZERO_TAX_SPEC.SPEC_SERIAL%TYPE           --일련번호
    , P_DOC_NAME	              IN 	FI_ZERO_TAX_SPEC.DOC_NAME%TYPE	            --서류명    
    , P_PUBLISHER	              IN 	FI_ZERO_TAX_SPEC.PUBLISHER%TYPE	            --발급자    
    , P_PUBLISH_DATE	          IN	FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE	        --발급일자    
    , P_SHIPPING_DATE	          IN	FI_ZERO_TAX_SPEC.SHIPPING_DATE%TYPE	        --선적일자    
    , P_CURRENCY_CODE           IN	FI_ZERO_TAX_SPEC.CURRENCY_CODE%TYPE	        --통화코드    
    , P_EXCHANGE_RATE	          IN	FI_ZERO_TAX_SPEC.EXCHANGE_RATE%TYPE	        --환율    
    , P_SUBMIT_FOREIGN_AMT	    IN	FI_ZERO_TAX_SPEC.SUBMIT_FOREIGN_AMT%TYPE    --당기제출외화    
    , P_SUBMIT_KOREAN_AMT	      IN	FI_ZERO_TAX_SPEC.SUBMIT_KOREAN_AMT%TYPE	    --당기제출원화    
    , P_REPORT_FOREIGN_AMT	    IN	FI_ZERO_TAX_SPEC.REPORT_FOREIGN_AMT%TYPE	--당기신고외화
    , P_REPORT_KOREAN_AMT       IN	FI_ZERO_TAX_SPEC.REPORT_KOREAN_AMT%TYPE	    --당기신고원화
    , P_LAST_UPDATED_BY         IN  FI_ZERO_TAX_SPEC.LAST_UPDATED_BY%TYPE       --수정자
);






--grid에 조회된 자료 삭제
PROCEDURE DELETE_ZERO_TAX_SPEC(
      W_SOB_ID	                IN 	FI_ZERO_TAX_SPEC.SOB_ID%TYPE	            --회사아이디
    , W_ORG_ID	                IN 	FI_ZERO_TAX_SPEC.ORG_ID%TYPE	            --사업부아이디
    , W_TAX_CODE                IN 	FI_ZERO_TAX_SPEC.TAX_CODE%TYPE            --사업장아이디
    , W_VAT_MNG_SERIAL          IN 	FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --부가세신고기간구분번호
    , W_ZERO_TAX_RATE_REASON    IN 	FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --제출사유     
    , W_SPEC_SERIAL             IN 	FI_ZERO_TAX_SPEC.SPEC_SERIAL%TYPE           --일련번호
);






--영세율첨부서류제출명세서 명세서 상단 출력용
PROCEDURE PRINT_ZERO_TAX_SPEC_TITLE(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID                  IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE                IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --사업장아이디(예>42)
    , W_ZERO_TAX_RATE_REASON    IN 	FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --제출사유      
    
    --아래 항목은 출력시 필수항목이다.
    , W_DEAL_DATE_FR            IN  DATE    --거래기간_시작
    , W_DEAL_DATE_TO            IN  DATE    --거래기간_종료
    , W_CREATE_DATE             IN  DATE    --작성일자
);






END FI_ZERO_TAX_SPEC_G;
/
CREATE OR REPLACE PACKAGE BODY FI_ZERO_TAX_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_ZERO_TAX_SPEC_G
Description  : 영세율첨부서류제출명세서 Package

Reference by : calling assmbly-program id(호출 프로그램) : FCMF0873(영세율첨부서류제출명세서)
Program History :
    -.참조>이 자료는 작업자가 부가가치세신고와 관련하여 직접 입력하는 자료로 전표와는 무관한다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-14   Leem Dong Ern(임동언)
*****************************************************************************/






--제출사유 기본값 설정용
PROCEDURE SET_ZERO_TAX_RATE_REASON(
      W_SOB_ID                  IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE    --회사아이디
    , W_ORG_ID                  IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE    --사업부아이디
    , O_ZERO_TAX_RATE_REASON_CD OUT VARCHAR2    --제출사유코드
    , O_ZERO_TAX_RATE_REASON_NM OUT VARCHAR2    --제출사유   
)

AS

BEGIN

    SELECT
        '02', FI_COMMON_G.CODE_NAME_F('ZERO_TAX_RATE_REASON', '02', W_SOB_ID, W_ORG_ID) AS VAT_TYPE_NAME
    INTO O_ZERO_TAX_RATE_REASON_CD, O_ZERO_TAX_RATE_REASON_NM
    FROM DUAL;

END SET_ZERO_TAX_RATE_REASON;








--grid에 조회되는 자료 추출
PROCEDURE LIST_ZERO_TAX_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID                  IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE                IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --사업장아이디(예>42)    
    , W_VAT_MNG_SERIAL          IN  FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --부가세신고기간구분번호
    , W_ZERO_TAX_RATE_REASON    IN  FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --제출사유    
    , W_PUBLISH_DATE_FR         IN  FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE          --발급기간_시작
    , W_PUBLISH_DATE_TO         IN  FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE          --발급기간_종료
)

AS

BEGIN

    OPEN P_CURSOR FOR
        
    WITH T AS(
        SELECT 
              SOB_ID            --회사아이디
            , ORG_ID            --사업부아이디
            , TAX_CODE          --사업장아이디
            , VAT_MNG_SERIAL    --부가세신고기간구분번호
            , FI_VAT_REPORT_MNG_G.VAT_MNG_SERIAL_F(VAT_MNG_SERIAL) AS VAT_REPORT_NM   --신고기간구분명
            , ZERO_TAX_RATE_REASON  --제출사유
            , SPEC_SERIAL           --일련번호
            , DOC_NAME              --서류명
            , PUBLISHER             --발급자
            , PUBLISH_DATE          --발급일자
            , SHIPPING_DATE         --선적일자        
            , TO_CHAR(PUBLISH_DATE, 'YYYY.MM.DD') AS PRINT_PUBLISH_DATE     --출력_발급일자
            , TO_CHAR(SHIPPING_DATE, 'YYYY.MM.DD') AS PRINT_SHIPPING_DATE   --출력_선적일자
            , CURRENCY_CODE         --통화
            , EXCHANGE_RATE         --환율
            , SUBMIT_FOREIGN_AMT    --당기제출외화
            , SUBMIT_KOREAN_AMT     --당기제출원화
            , REPORT_FOREIGN_AMT    --당기신고외화
            , REPORT_KOREAN_AMT     --당기신고원화
        FROM FI_ZERO_TAX_SPEC
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND TAX_CODE = W_TAX_CODE
            AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
            AND ZERO_TAX_RATE_REASON = W_ZERO_TAX_RATE_REASON
            
            --AND PUBLISH_DATE BETWEEN TO_DATE('2011-04-01') AND TO_DATE('2011-06-30')
            AND PUBLISH_DATE BETWEEN NVL(W_PUBLISH_DATE_FR, PUBLISH_DATE) AND NVL(W_PUBLISH_DATE_TO, PUBLISH_DATE)
        ORDER BY PUBLISH_DATE, SHIPPING_DATE
    )
    SELECT 
        ROWNUM AS SEQ     --출력_일련번호
        , T.* 
    FROM T  ;   

END LIST_ZERO_TAX_SPEC;






--grid에 조회되는 자료 중 금액자료들에 대한 합계
PROCEDURE SUM_ZERO_TAX_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID                  IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE                IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --사업장아이디(예>42)    
    , W_VAT_MNG_SERIAL          IN  FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --부가세신고기간구분번호
    , W_ZERO_TAX_RATE_REASON    IN  FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --제출사유    
    , W_PUBLISH_DATE_FR         IN  FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE          --발급기간_시작
    , W_PUBLISH_DATE_TO         IN  FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE          --발급기간_종료
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          NVL(SUM(SUBMIT_FOREIGN_AMT), 0) AS SUBMIT_FOREIGN_AMT --당기제출외화
        , NVL(SUM(SUBMIT_KOREAN_AMT), 0) AS SUBMIT_KOREAN_AMT   --당기제출원화
        , NVL(SUM(REPORT_FOREIGN_AMT), 0) AS REPORT_FOREIGN_AMT --당기신고외화
        , NVL(SUM(REPORT_KOREAN_AMT), 0) AS REPORT_KOREAN_AMT   --당기신고원화
    FROM FI_ZERO_TAX_SPEC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
        AND ZERO_TAX_RATE_REASON = W_ZERO_TAX_RATE_REASON
        
        --AND PUBLISH_DATE BETWEEN TO_DATE('2011-04-01') AND TO_DATE('2011-06-30')
        AND PUBLISH_DATE BETWEEN NVL(W_PUBLISH_DATE_FR, PUBLISH_DATE) AND NVL(W_PUBLISH_DATE_TO, PUBLISH_DATE)
    ORDER BY PUBLISH_DATE, SHIPPING_DATE    ;   


END SUM_ZERO_TAX_SPEC;





--grid에 신규 항목 추가
PROCEDURE INSERT_ZERO_TAX_SPEC(
      P_SOB_ID	                IN 	FI_ZERO_TAX_SPEC.SOB_ID%TYPE	            --회사아이디
    , P_ORG_ID	                IN 	FI_ZERO_TAX_SPEC.ORG_ID%TYPE	            --사업부아이디
    , P_TAX_CODE                IN 	FI_ZERO_TAX_SPEC.TAX_CODE%TYPE            --사업장아이디   
    , P_VAT_MNG_SERIAL          IN 	FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --부가세신고기간구분번호
    , P_ZERO_TAX_RATE_REASON    IN 	FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --제출사유    
    , P_DOC_NAME	              IN 	FI_ZERO_TAX_SPEC.DOC_NAME%TYPE	            --서류명    
    , P_PUBLISHER	              IN 	FI_ZERO_TAX_SPEC.PUBLISHER%TYPE	            --발급자    
    , P_PUBLISH_DATE	          IN	FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE	        --발급일자    
    , P_SHIPPING_DATE	          IN	FI_ZERO_TAX_SPEC.SHIPPING_DATE%TYPE	        --선적일자    
    , P_CURRENCY_CODE           IN	FI_ZERO_TAX_SPEC.CURRENCY_CODE%TYPE	        --통화코드    
    , P_EXCHANGE_RATE	          IN	FI_ZERO_TAX_SPEC.EXCHANGE_RATE%TYPE	        --환율    
    , P_SUBMIT_FOREIGN_AMT	    IN	FI_ZERO_TAX_SPEC.SUBMIT_FOREIGN_AMT%TYPE    --당기제출외화    
    , P_SUBMIT_KOREAN_AMT	      IN	FI_ZERO_TAX_SPEC.SUBMIT_KOREAN_AMT%TYPE	    --당기제출원화    
    , P_REPORT_FOREIGN_AMT	    IN	FI_ZERO_TAX_SPEC.REPORT_FOREIGN_AMT%TYPE	--당기신고외화
    , P_REPORT_KOREAN_AMT       IN	FI_ZERO_TAX_SPEC.REPORT_KOREAN_AMT%TYPE	    --당기신고원화
    , P_CREATED_BY	            IN	FI_ZERO_TAX_SPEC.CREATED_BY%TYPE	        --생성자
)

AS

V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
t_SPEC_SERIAL   FI_ZERO_TAX_SPEC.SPEC_SERIAL%TYPE;

BEGIN

    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO t_SPEC_SERIAL FROM FI_ZERO_TAX_SPEC;   --일련번호

    INSERT INTO FI_ZERO_TAX_SPEC(
          SOB_ID	            --회사아이디
        , ORG_ID	            --사업부아이디
        , TAX_CODE            --사업장아이디        
        , VAT_MNG_SERIAL        --부가세신고기간구분번호
        , ZERO_TAX_RATE_REASON  --제출사유        
        , SPEC_SERIAL           --일련번호
        , DOC_NAME	            --서류명    
        , PUBLISHER	            --발급자    
        , PUBLISH_DATE	        --발급일자    
        , SHIPPING_DATE	        --선적일자    
        , CURRENCY_CODE         --통화코드    
        , EXCHANGE_RATE	        --환율    
        , SUBMIT_FOREIGN_AMT    --당기제출외화    
        , SUBMIT_KOREAN_AMT	    --당기제출원화    
        , REPORT_FOREIGN_AMT	--당기신고외화
        , REPORT_KOREAN_AMT     --당기신고원화
        , CREATION_DATE         --생성일
        , CREATED_BY	        --생성자
        , LAST_UPDATE_DATE      --수정일
        , LAST_UPDATED_BY	    --수정자
    )
    VALUES(
          P_SOB_ID	                --회사아이디
        , P_ORG_ID	                --사업부아이디
        , P_TAX_CODE                --사업장아이디 
        , P_VAT_MNG_SERIAL          --부가세신고기간구분번호
        , P_ZERO_TAX_RATE_REASON    --제출사유        
        , t_SPEC_SERIAL             --일련번호
        , P_DOC_NAME	            --서류명    
        , P_PUBLISHER	            --발급자    
        , P_PUBLISH_DATE	        --발급일자    
        , P_SHIPPING_DATE	        --선적일자    
        , P_CURRENCY_CODE           --통화코드    
        , P_EXCHANGE_RATE	        --환율    
        , P_SUBMIT_FOREIGN_AMT	    --당기제출외화    
        , P_SUBMIT_KOREAN_AMT	    --당기제출원화    
        , P_REPORT_FOREIGN_AMT	    --당기신고외화
        , P_REPORT_KOREAN_AMT       --당기신고원화
        , V_SYSDATE                 --생성일
        , P_CREATED_BY	            --생성자
        , V_SYSDATE                 --수정일
        , P_CREATED_BY	            --수정자
    );

END INSERT_ZERO_TAX_SPEC;







--grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_ZERO_TAX_SPEC(
      W_SOB_ID	                IN 	FI_ZERO_TAX_SPEC.SOB_ID%TYPE	            --회사아이디
    , W_ORG_ID	                IN 	FI_ZERO_TAX_SPEC.ORG_ID%TYPE	            --사업부아이디
    , W_TAX_CODE                IN 	FI_ZERO_TAX_SPEC.TAX_CODE%TYPE     --사업장아이디
    , W_VAT_MNG_SERIAL          IN 	FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --부가세신고기간구분번호
    , W_ZERO_TAX_RATE_REASON    IN 	FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --제출사유    
    , W_SPEC_SERIAL             IN 	FI_ZERO_TAX_SPEC.SPEC_SERIAL%TYPE           --일련번호
    , P_DOC_NAME	              IN 	FI_ZERO_TAX_SPEC.DOC_NAME%TYPE	            --서류명    
    , P_PUBLISHER	              IN 	FI_ZERO_TAX_SPEC.PUBLISHER%TYPE	            --발급자    
    , P_PUBLISH_DATE	          IN	FI_ZERO_TAX_SPEC.PUBLISH_DATE%TYPE	        --발급일자    
    , P_SHIPPING_DATE	          IN	FI_ZERO_TAX_SPEC.SHIPPING_DATE%TYPE	        --선적일자    
    , P_CURRENCY_CODE           IN	FI_ZERO_TAX_SPEC.CURRENCY_CODE%TYPE	        --통화코드    
    , P_EXCHANGE_RATE	          IN	FI_ZERO_TAX_SPEC.EXCHANGE_RATE%TYPE	        --환율    
    , P_SUBMIT_FOREIGN_AMT	    IN	FI_ZERO_TAX_SPEC.SUBMIT_FOREIGN_AMT%TYPE    --당기제출외화    
    , P_SUBMIT_KOREAN_AMT	      IN	FI_ZERO_TAX_SPEC.SUBMIT_KOREAN_AMT%TYPE	    --당기제출원화    
    , P_REPORT_FOREIGN_AMT	    IN	FI_ZERO_TAX_SPEC.REPORT_FOREIGN_AMT%TYPE	--당기신고외화
    , P_REPORT_KOREAN_AMT       IN	FI_ZERO_TAX_SPEC.REPORT_KOREAN_AMT%TYPE	    --당기신고원화
    , P_LAST_UPDATED_BY         IN  FI_ZERO_TAX_SPEC.LAST_UPDATED_BY%TYPE       --수정자
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);

BEGIN

    UPDATE FI_ZERO_TAX_SPEC
    SET
          DOC_NAME	            = P_DOC_NAME	        --서류명    
        , PUBLISHER	            = P_PUBLISHER	        --발급자    
        , PUBLISH_DATE	        = P_PUBLISH_DATE	    --발급일자    
        , SHIPPING_DATE	        = P_SHIPPING_DATE	    --선적일자    
        , CURRENCY_CODE         = P_CURRENCY_CODE	    --통화코드    
        , EXCHANGE_RATE	        = P_EXCHANGE_RATE	    --환율    
        , SUBMIT_FOREIGN_AMT    = P_SUBMIT_FOREIGN_AMT  --당기제출외화    
        , SUBMIT_KOREAN_AMT	    = P_SUBMIT_KOREAN_AMT	--당기제출원화    
        , REPORT_FOREIGN_AMT	  = P_REPORT_FOREIGN_AMT  --당기신고외화
        , REPORT_KOREAN_AMT     = P_REPORT_KOREAN_AMT	--당기신고원화        
        , LAST_UPDATE_DATE      = V_SYSDATE             --수정일
        , LAST_UPDATED_BY       = P_LAST_UPDATED_BY     --수정자
    WHERE   SOB_ID                  = W_SOB_ID                  --회사아이디
        AND ORG_ID                  = W_ORG_ID                  --사업부아이디
        AND TAX_CODE                = W_TAX_CODE                --사업장아이디        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --부가세신고기간구분번호
        AND ZERO_TAX_RATE_REASON    = W_ZERO_TAX_RATE_REASON    --제출사유                
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --일련번호
    ;

END UPDATE_ZERO_TAX_SPEC;





--grid에 조회된 자료 삭제
PROCEDURE DELETE_ZERO_TAX_SPEC(
      W_SOB_ID	                IN 	FI_ZERO_TAX_SPEC.SOB_ID%TYPE	            --회사아이디
    , W_ORG_ID	                IN 	FI_ZERO_TAX_SPEC.ORG_ID%TYPE	            --사업부아이디
    , W_TAX_CODE                IN 	FI_ZERO_TAX_SPEC.TAX_CODE%TYPE            --사업장아이디
    , W_VAT_MNG_SERIAL          IN 	FI_ZERO_TAX_SPEC.VAT_MNG_SERIAL%TYPE        --부가세신고기간구분번호
    , W_ZERO_TAX_RATE_REASON    IN 	FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --제출사유     
    , W_SPEC_SERIAL             IN 	FI_ZERO_TAX_SPEC.SPEC_SERIAL%TYPE           --일련번호
)

AS

BEGIN

    DELETE FI_ZERO_TAX_SPEC
    WHERE   SOB_ID                  = W_SOB_ID                  --회사아이디
        AND ORG_ID                  = W_ORG_ID                  --사업부아이디
        AND TAX_CODE                = W_TAX_CODE                --사업장아이디        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --부가세신고기간구분번호
        AND ZERO_TAX_RATE_REASON    = W_ZERO_TAX_RATE_REASON    --제출사유                
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --일련번호
    ;

END DELETE_ZERO_TAX_SPEC;







--영세율첨부서류제출명세서 명세서 상단 출력용
PROCEDURE PRINT_ZERO_TAX_SPEC_TITLE(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID                  IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE                IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --사업장아이디(예>42)
    , W_ZERO_TAX_RATE_REASON    IN 	FI_ZERO_TAX_SPEC.ZERO_TAX_RATE_REASON%TYPE  --제출사유      
    
    --아래 항목은 출력시 필수항목이다.
    , W_DEAL_DATE_FR            IN  DATE    --거래기간_시작
    , W_DEAL_DATE_TO            IN  DATE    --거래기간_종료
    , W_CREATE_DATE             IN  DATE    --작성일자
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
        , B.BUSINESS_ITEM || '(' || BUSINESS_TYPE || ')' AS BUSINESS    --업태(종목)
        , B.ADDR1 || ' ' || B.ADDR2 || ' (  ' || A.TEL_NUMBER || '  ) ' AS LOCATION_TEL  --사업장소재지(전화번호)
        , TO_CHAR(W_DEAL_DATE_FR, 'YYYY.MM.DD') || ' ~ ' || TO_CHAR(W_DEAL_DATE_TO, 'YYYY.MM.DD') AS DEAL_TERM    --거래기간
        , TO_CHAR(W_CREATE_DATE, 'YYYY.MM.DD') AS CREATE_DATE   --작성일자
        , FI_COMMON_G.CODE_NAME_F('ZERO_TAX_RATE_REASON', W_ZERO_TAX_RATE_REASON, A.SOB_ID, A.ORG_ID) AS VAT_TYPE_NAME     --제출사유
        , '(   ' || TO_CHAR(W_DEAL_DATE_TO, 'YYYY') || '  년   ' ||  
          CASE
            WHEN TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'MM')) <= 6 THEN '1'
            ELSE '2'
          END
          || '  기   )' AS FISCAL_YEAR   --부가가치세신고기수
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
        OR   ROWNUM                 <= 1)
        ;
END PRINT_ZERO_TAX_SPEC_TITLE;






END FI_ZERO_TAX_SPEC_G;
/
