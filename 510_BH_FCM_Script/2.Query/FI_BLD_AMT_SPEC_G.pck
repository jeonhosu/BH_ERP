CREATE OR REPLACE PACKAGE FI_BLD_AMT_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_BLD_AMT_SPEC_G
Description  : 부동산임대공급가액명세서 Package

Reference by : calling assmbly-program id(호출 프로그램) : (부동산임대공급가액명세서)
Program History :
    -.참조>이 자료는 작업자가 부가가치세신고와 관련하여 직접 입력하는 자료로 전표와는 무관한다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-16   Leem Dong Ern(임동언)
*****************************************************************************/





--grid에 조회되는 자료 추출
PROCEDURE LIST_BLD_AMT_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_BLD_AMT_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID                  IN  FI_BLD_AMT_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE                IN  FI_BLD_AMT_SPEC.TAX_CODE%TYPE              --사업장아이디(예>42)    
    , W_VAT_MNG_SERIAL          IN  FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE        --부가세신고기간구분번호
);







--grid에 조회되는 자료 중 금액자료들에 대한 합계
PROCEDURE SUM_BLD_AMT_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_BLD_AMT_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID                  IN  FI_BLD_AMT_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE                IN  FI_BLD_AMT_SPEC.TAX_CODE%TYPE              --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL          IN  FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE        --부가세신고기간구분번호
);






--임대기간의 보증금이자(간주임대료), 임대기간_임대료, 임대기간_관리비를 구해서 넘김.
PROCEDURE SET_TERM_AMT(
      W_IN_DATE     IN  FI_BLD_AMT_SPEC.IN_DATE%TYPE        --입주일
    , W_OUT_DATE    IN  FI_BLD_AMT_SPEC.OUT_DATE%TYPE       --퇴거일
    , W_DEPOSIT     IN  FI_BLD_AMT_SPEC.DEPOSIT%TYPE        --보증금
    , W_MONTH_RENT  IN  FI_BLD_AMT_SPEC.MONTH_RENT%TYPE     --월임대료
    , W_MONTN_FEE   IN  FI_BLD_AMT_SPEC.MONTN_FEE%TYPE      --월관리비
    , W_REGARD_RATE IN  FI_VAT_REPORT_MNG.REGARD_RATE%TYPE  --간주임대료적용이자율
    
    , O_DEEMED_RENT OUT FI_BLD_AMT_SPEC.DEEMED_RENT%TYPE    --보증금이자_간주임대료
    , O_TERM_RENT   OUT FI_BLD_AMT_SPEC.TERM_RENT%TYPE      --임대기간_임대료
    , O_TERM_FEE    OUT FI_BLD_AMT_SPEC.TERM_FEE%TYPE       --임대기간_관리비
);










--grid에 신규 항목 추가
PROCEDURE INSERT_BLD_AMT_SPEC(
      P_SOB_ID	            IN 	FI_BLD_AMT_SPEC.SOB_ID%TYPE	            --회사아이디
    , P_ORG_ID	            IN 	FI_BLD_AMT_SPEC.ORG_ID%TYPE	            --사업부아이디
    , P_TAX_CODE          	IN 	FI_BLD_AMT_SPEC.TAX_CODE%TYPE           --사업장아이디
    , P_VAT_MNG_SERIAL	    IN 	FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE     --부가세신고기간구분번호
    , P_REAL_ESTATE_LOC	    IN 	FI_BLD_AMT_SPEC.REAL_ESTATE_LOC%TYPE    --부동산위치
    , P_ADDRESS	            IN 	FI_BLD_AMT_SPEC.ADDRESS%TYPE            --동
    , P_VAT_GROUND_YN	      IN 	FI_BLD_AMT_SPEC.VAT_GROUND_YN%TYPE      --지상_지하여부
    , P_BLD_FLOOR	          IN 	FI_BLD_AMT_SPEC.BLD_FLOOR%TYPE          --충
    , P_ROOM	              IN 	FI_BLD_AMT_SPEC.ROOM%TYPE               --호
    , P_LEND_AREA	          IN 	FI_BLD_AMT_SPEC.LEND_AREA%TYPE          --임대면적
    , P_PURPOSE	            IN 	FI_BLD_AMT_SPEC.PURPOSE%TYPE            --용도
    , P_CORP_NAME	          IN 	FI_BLD_AMT_SPEC.CORP_NAME%TYPE          --업체 상호
    , P_VAT_NUMBER	        IN 	FI_BLD_AMT_SPEC.VAT_NUMBER%TYPE         --사업자등록번호
    , P_IN_DATE	            IN 	FI_BLD_AMT_SPEC.IN_DATE%TYPE            --입주일
    , P_MODIFY_DATE	        IN 	FI_BLD_AMT_SPEC.MODIFY_DATE%TYPE        --갱신일
    , P_OUT_DATE	          IN 	FI_BLD_AMT_SPEC.OUT_DATE%TYPE           --퇴거일
    , P_DEPOSIT	            IN 	FI_BLD_AMT_SPEC.DEPOSIT%TYPE            --보증금
    , P_MONTH_RENT	        IN 	FI_BLD_AMT_SPEC.MONTH_RENT%TYPE         --월임대료
    , P_MONTN_FEE	          IN 	FI_BLD_AMT_SPEC.MONTN_FEE%TYPE          --월관리비
    , P_DEEMED_RENT	        IN 	FI_BLD_AMT_SPEC.DEEMED_RENT%TYPE        --보증금이자_간주임대료
    , P_TERM_RENT	          IN 	FI_BLD_AMT_SPEC.TERM_RENT%TYPE          --임대기간_임대료
    , P_TERM_FEE	          IN 	FI_BLD_AMT_SPEC.TERM_FEE%TYPE           --임대기간_관리비    
    , P_CREATED_BY	        IN	FI_BLD_AMT_SPEC.CREATED_BY%TYPE	        --생성자
);





--grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_BLD_AMT_SPEC(
      W_SOB_ID	            IN 	FI_BLD_AMT_SPEC.SOB_ID%TYPE	            --회사아이디
    , W_ORG_ID	            IN 	FI_BLD_AMT_SPEC.ORG_ID%TYPE	            --사업부아이디
    , W_TAX_CODE 	          IN  FI_BLD_AMT_SPEC.TAX_CODE%TYPE           --사업장아이디
    , W_VAT_MNG_SERIAL	    IN 	FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE     --부가세신고기간구분번호
    , W_SPEC_SERIAL	        IN 	FI_BLD_AMT_SPEC.SPEC_SERIAL%TYPE        --일련번호
    , P_REAL_ESTATE_LOC	    IN 	FI_BLD_AMT_SPEC.REAL_ESTATE_LOC%TYPE    --부동산위치
    , P_ADDRESS	            IN 	FI_BLD_AMT_SPEC.ADDRESS%TYPE            --동
    , P_VAT_GROUND_YN	      IN 	FI_BLD_AMT_SPEC.VAT_GROUND_YN%TYPE      --지상_지하여부
    , P_BLD_FLOOR	          IN 	FI_BLD_AMT_SPEC.BLD_FLOOR%TYPE          --충
    , P_ROOM	              IN 	FI_BLD_AMT_SPEC.ROOM%TYPE               --호
    , P_LEND_AREA	          IN 	FI_BLD_AMT_SPEC.LEND_AREA%TYPE          --임대면적
    , P_PURPOSE	            IN 	FI_BLD_AMT_SPEC.PURPOSE%TYPE            --용도
    , P_CORP_NAME	          IN 	FI_BLD_AMT_SPEC.CORP_NAME%TYPE          --업체 상호
    , P_VAT_NUMBER	        IN 	FI_BLD_AMT_SPEC.VAT_NUMBER%TYPE         --사업자등록번호
    , P_IN_DATE	            IN 	FI_BLD_AMT_SPEC.IN_DATE%TYPE            --입주일
    , P_MODIFY_DATE	        IN 	FI_BLD_AMT_SPEC.MODIFY_DATE%TYPE        --갱신일
    , P_OUT_DATE	          IN 	FI_BLD_AMT_SPEC.OUT_DATE%TYPE           --퇴거일
    , P_DEPOSIT	            IN 	FI_BLD_AMT_SPEC.DEPOSIT%TYPE            --보증금
    , P_MONTH_RENT	        IN 	FI_BLD_AMT_SPEC.MONTH_RENT%TYPE         --월임대료
    , P_MONTN_FEE	          IN 	FI_BLD_AMT_SPEC.MONTN_FEE%TYPE          --월관리비
    , P_DEEMED_RENT	        IN 	FI_BLD_AMT_SPEC.DEEMED_RENT%TYPE        --보증금이자_간주임대료
    , P_TERM_RENT	          IN 	FI_BLD_AMT_SPEC.TERM_RENT%TYPE          --임대기간_임대료
    , P_TERM_FEE	          IN 	FI_BLD_AMT_SPEC.TERM_FEE%TYPE           --임대기간_관리비    
    , P_LAST_UPDATED_BY     IN  FI_BLD_AMT_SPEC.LAST_UPDATED_BY%TYPE    --수정자
);






--grid에 조회된 자료 삭제
PROCEDURE DELETE_BLD_AMT_SPEC(
      W_SOB_ID	            IN 	FI_BLD_AMT_SPEC.SOB_ID%TYPE	            --회사아이디
    , W_ORG_ID	            IN 	FI_BLD_AMT_SPEC.ORG_ID%TYPE	            --사업부아이디
    , W_TAX_CODE	          IN 	FI_BLD_AMT_SPEC.TAX_CODE%TYPE           --사업장아이디
    , W_VAT_MNG_SERIAL	    IN 	FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE     --부가세신고기간구분번호
    , W_SPEC_SERIAL	        IN 	FI_BLD_AMT_SPEC.SPEC_SERIAL%TYPE        --일련번호
);






--부동산임대공급가액명세서 상단 출력용
PROCEDURE PRINT_BLD_AMT_SPEC(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID              IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE            IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --사업장아이디(예>42)     
    
    --아래 항목은 출력시 필수항목이다.
    , W_TAX_DATE_FR         IN  VARCHAR2    --과세기간_시작
    , W_TAX_DATE_TO         IN  VARCHAR2    --과세기간_종료
);





END FI_BLD_AMT_SPEC_G;
/
CREATE OR REPLACE PACKAGE BODY FI_BLD_AMT_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_BLD_AMT_SPEC_G
Description  : 부동산임대공급가액명세서 Package

Reference by : calling assmbly-program id(호출 프로그램) : (부동산임대공급가액명세서)
Program History :
    -.참조>이 자료는 작업자가 부가가치세신고와 관련하여 직접 입력하는 자료로 전표와는 무관한다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-16   Leem Dong Ern(임동언)
*****************************************************************************/






--grid에 조회되는 자료 추출
PROCEDURE LIST_BLD_AMT_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_BLD_AMT_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID                  IN  FI_BLD_AMT_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE                IN  FI_BLD_AMT_SPEC.TAX_CODE%TYPE              --사업장아이디(예>42)    
    , W_VAT_MNG_SERIAL          IN  FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE        --부가세신고기간구분번호
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디
        , TAX_CODE      	--사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        , FI_VAT_REPORT_MNG_G.VAT_MNG_SERIAL_F(VAT_MNG_SERIAL) AS VAT_REPORT_NM   --신고기간구분명
        , SPEC_SERIAL	    --일련번호
        
        --임대사항
        , ADDRESS	        --동
        , REAL_ESTATE_LOC	--부동산위치    
        , VAT_GROUND_YN	    --지상_지하여부코드
        , FI_COMMON_G.CODE_NAME_F('VAT_GROUND_YN', VAT_GROUND_YN, SOB_ID, ORG_ID) AS VAT_GROUND_YN_NM     --지상_지하여부
        , BLD_FLOOR	--충
        , ROOM	    --호
        , BLD_FLOOR || '충' AS PRINT_BLD_FLOOR   --충
        , ROOM || '호' AS PRINT_ROOM             --호        
        , LEND_AREA	--임대면적
        , PURPOSE	--용도
        
        --임차인인적사항 및 임대차계약내용
        , CORP_NAME	    --업체 상호
        , VAT_NUMBER	--사업자등록번호
        , IN_DATE	    --임대기간_입주일
        , OUT_DATE	    --임대기간_퇴거일    
        , MODIFY_DATE	--갱신일
        
        , DEPOSIT	    --보증금
        , MONTH_RENT	--월세
        , MONTN_FEE	    --월관리비
        , NVL(MONTH_RENT, 0) + NVL(MONTN_FEE, 0) AS MM_FEE --월임대료
        
        --임대료수입금액(과세표준)
        , DEEMED_RENT	--보증금이자(간주임대료)
        , TERM_RENT	    --임대기간_임대료
        , TERM_FEE	    --임대기간_관리비
        , NVL(TERM_RENT, 0) + NVL(TERM_FEE, 0) AS TAX_MM_FEE                        --월임대료(계)
        , NVL(DEEMED_RENT, 0) + NVL(TERM_RENT, 0) + NVL(TERM_FEE, 0) AS RENT_SUM    --합계
    FROM FI_BLD_AMT_SPEC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
    ORDER BY SPEC_SERIAL    ; 


END LIST_BLD_AMT_SPEC;






--grid에 조회되는 자료 중 금액자료들에 대한 합계
PROCEDURE SUM_BLD_AMT_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_BLD_AMT_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID                  IN  FI_BLD_AMT_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE                IN  FI_BLD_AMT_SPEC.TAX_CODE%TYPE              --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL          IN  FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE        --부가세신고기간구분번호
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
        --임대차계약내용 합계
          NVL(SUM(DEPOSIT), 0) AS DEPOSIT   --계약내용_보증금
        , NVL(SUM(MONTH_RENT), 0) + NVL(SUM(MONTN_FEE), 0) AS MONTH_RENT   --계약내용_월세등
        
        --과세표준 합계
        , NVL(SUM(DEEMED_RENT), 0) AS DEEMED_RENT   --수입금액_보증금이자
        , NVL(SUM(TERM_RENT), 0) + NVL(SUM(TERM_FEE), 0) AS TAX_MM_FEE  --수입금액_월세등
        , NVL(SUM(DEEMED_RENT), 0) + NVL(SUM(TERM_RENT), 0) + NVL(SUM(TERM_FEE), 0) AS RENT_SUM --수입금액_합계(과세표준)           
    FROM FI_BLD_AMT_SPEC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   ;


END SUM_BLD_AMT_SPEC;







--임대기간의 보증금이자(간주임대료), 임대기간_임대료, 임대기간_관리비를 구해서 넘김.
PROCEDURE SET_TERM_AMT(
      W_IN_DATE     IN  FI_BLD_AMT_SPEC.IN_DATE%TYPE        --입주일
    , W_OUT_DATE    IN  FI_BLD_AMT_SPEC.OUT_DATE%TYPE       --퇴거일
    , W_DEPOSIT     IN  FI_BLD_AMT_SPEC.DEPOSIT%TYPE        --보증금
    , W_MONTH_RENT  IN  FI_BLD_AMT_SPEC.MONTH_RENT%TYPE     --월임대료
    , W_MONTN_FEE   IN  FI_BLD_AMT_SPEC.MONTN_FEE%TYPE      --월관리비
    , W_REGARD_RATE IN  FI_VAT_REPORT_MNG.REGARD_RATE%TYPE  --간주임대료적용이자율
    
    , O_DEEMED_RENT OUT FI_BLD_AMT_SPEC.DEEMED_RENT%TYPE    --보증금이자_간주임대료
    , O_TERM_RENT   OUT FI_BLD_AMT_SPEC.TERM_RENT%TYPE      --임대기간_임대료
    , O_TERM_FEE    OUT FI_BLD_AMT_SPEC.TERM_FEE%TYPE       --임대기간_관리비
)

AS
    V_YEAR_DAY          NUMBER := 0;  -- 년일수.
BEGIN
    BEGIN
      V_YEAR_DAY := HRM_COMMON_DATE_G.PERIOD_DAY_F(TRUNC(W_IN_DATE, 'YEAR'), LAST_DAY(TO_DATE(TO_CHAR(W_IN_DATE, 'YYYY') || '-12-31', 'YYYY-MM-DD')), 1);
    EXCEPTION WHEN OTHERS THEN
      V_YEAR_DAY                := 365;
    END;
    
    SELECT     
        --  W_IN_DATE AS IN_DATE	    --임대기간_입주일
        --, W_OUT_DATE AS OUT_DATE	    --임대기간_퇴거일
        --, TRUNC(W_OUT_DATE - W_IN_DATE) + 1 AS DATE_TERM    --2날짜 사이의 일자 수
        --, TRUNC(MONTHS_BETWEEN(W_OUT_DATE + 1, W_IN_DATE)) AS MM_TERM   --2날짜 사이의 개월 수
        
        --, W_DEPOSIT AS DEPOSIT	    --보증금
        --, W_MONTH_RENT AS MONTH_RENT	--월세
        --, W_MONTN_FEE  AS MONTN_FEE	    --월관리비
        
        --임대료수입금액(과세표준)
          TRUNC(W_DEPOSIT * (W_REGARD_RATE / 100) * ( (TRUNC(W_OUT_DATE - W_IN_DATE) + 1) / V_YEAR_DAY ))  AS DEEMED_RENT	--보증금이자(간주임대료)
        , W_MONTH_RENT * TRUNC(MONTHS_BETWEEN(W_OUT_DATE + 1, W_IN_DATE)) AS TERM_RENT	    --임대기간_임대료
        , W_MONTN_FEE * TRUNC(MONTHS_BETWEEN(W_OUT_DATE + 1, W_IN_DATE)) AS TERM_FEE	    --임대기간_관리비
    INTO O_DEEMED_RENT, O_TERM_RENT, O_TERM_FEE
    FROM DUAL
    ; 

END SET_TERM_AMT;







--grid에 신규 항목 추가
PROCEDURE INSERT_BLD_AMT_SPEC(
      P_SOB_ID	            IN 	FI_BLD_AMT_SPEC.SOB_ID%TYPE	            --회사아이디
    , P_ORG_ID	            IN 	FI_BLD_AMT_SPEC.ORG_ID%TYPE	            --사업부아이디
    , P_TAX_CODE          	IN 	FI_BLD_AMT_SPEC.TAX_CODE%TYPE           --사업장아이디
    , P_VAT_MNG_SERIAL	    IN 	FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE     --부가세신고기간구분번호
    , P_REAL_ESTATE_LOC	    IN 	FI_BLD_AMT_SPEC.REAL_ESTATE_LOC%TYPE    --부동산위치
    , P_ADDRESS	            IN 	FI_BLD_AMT_SPEC.ADDRESS%TYPE            --동
    , P_VAT_GROUND_YN	      IN 	FI_BLD_AMT_SPEC.VAT_GROUND_YN%TYPE      --지상_지하여부
    , P_BLD_FLOOR	          IN 	FI_BLD_AMT_SPEC.BLD_FLOOR%TYPE          --충
    , P_ROOM	              IN 	FI_BLD_AMT_SPEC.ROOM%TYPE               --호
    , P_LEND_AREA	          IN 	FI_BLD_AMT_SPEC.LEND_AREA%TYPE          --임대면적
    , P_PURPOSE	            IN 	FI_BLD_AMT_SPEC.PURPOSE%TYPE            --용도
    , P_CORP_NAME	          IN 	FI_BLD_AMT_SPEC.CORP_NAME%TYPE          --업체 상호
    , P_VAT_NUMBER	        IN 	FI_BLD_AMT_SPEC.VAT_NUMBER%TYPE         --사업자등록번호
    , P_IN_DATE	            IN 	FI_BLD_AMT_SPEC.IN_DATE%TYPE            --입주일
    , P_MODIFY_DATE	        IN 	FI_BLD_AMT_SPEC.MODIFY_DATE%TYPE        --갱신일
    , P_OUT_DATE	          IN 	FI_BLD_AMT_SPEC.OUT_DATE%TYPE           --퇴거일
    , P_DEPOSIT	            IN 	FI_BLD_AMT_SPEC.DEPOSIT%TYPE            --보증금
    , P_MONTH_RENT	        IN 	FI_BLD_AMT_SPEC.MONTH_RENT%TYPE         --월임대료
    , P_MONTN_FEE	          IN 	FI_BLD_AMT_SPEC.MONTN_FEE%TYPE          --월관리비
    , P_DEEMED_RENT	        IN 	FI_BLD_AMT_SPEC.DEEMED_RENT%TYPE        --보증금이자_간주임대료
    , P_TERM_RENT	          IN 	FI_BLD_AMT_SPEC.TERM_RENT%TYPE          --임대기간_임대료
    , P_TERM_FEE	          IN 	FI_BLD_AMT_SPEC.TERM_FEE%TYPE           --임대기간_관리비    
    , P_CREATED_BY	        IN	FI_BLD_AMT_SPEC.CREATED_BY%TYPE	        --생성자
)

AS

V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
t_SPEC_SERIAL   FI_BLD_AMT_SPEC.SPEC_SERIAL%TYPE;

BEGIN

    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO t_SPEC_SERIAL FROM FI_BLD_AMT_SPEC;   --일련번호

    INSERT INTO FI_BLD_AMT_SPEC(
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디
        , TAX_CODE	      --사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        , SPEC_SERIAL	    --일련번호
        , REAL_ESTATE_LOC	--부동산위치
        , ADDRESS	        --동
        , VAT_GROUND_YN	    --지상_지하여부
        , BLD_FLOOR	        --충
        , ROOM	            --호
        , LEND_AREA	        --임대면적
        , PURPOSE	        --용도
        , CORP_NAME	        --업체 상호
        , VAT_NUMBER	    --사업자등록번호
        , IN_DATE	        --입주일
        , MODIFY_DATE	    --갱신일
        , OUT_DATE	        --퇴거일
        , DEPOSIT	        --보증금
        , MONTH_RENT	    --월임대료
        , MONTN_FEE	        --월관리비
        , DEEMED_RENT	    --보증금이자_간주임대료
        , TERM_RENT	        --임대기간_임대료
        , TERM_FEE	        --임대기간_관리비
        , CREATION_DATE     --생성일
        , CREATED_BY	    --생성자
        , LAST_UPDATE_DATE  --수정일
        , LAST_UPDATED_BY	--수정자
    )
    VALUES(
          P_SOB_ID	            --회사아이디
        , P_ORG_ID	            --사업부아이디        
        , P_TAX_CODE            --사업장아이디
        , P_VAT_MNG_SERIAL	    --부가세신고기간구분번호
        , t_SPEC_SERIAL	        --일련번호
        , P_REAL_ESTATE_LOC	    --부동산위치
        , P_ADDRESS	            --동
        , P_VAT_GROUND_YN	    --지상_지하여부
        , P_BLD_FLOOR	        --충
        , P_ROOM	            --호
        , P_LEND_AREA	        --임대면적
        , P_PURPOSE	            --용도
        , P_CORP_NAME	        --업체 상호
        , P_VAT_NUMBER	        --사업자등록번호
        , P_IN_DATE	            --입주일
        , P_MODIFY_DATE	        --갱신일
        , P_OUT_DATE	        --퇴거일
        , P_DEPOSIT	            --보증금
        , P_MONTH_RENT	        --월임대료
        , P_MONTN_FEE	        --월관리비
        , P_DEEMED_RENT	        --보증금이자_간주임대료
        , P_TERM_RENT	        --임대기간_임대료
        , P_TERM_FEE	        --임대기간_관리비        
        , V_SYSDATE             --생성일
        , P_CREATED_BY	        --생성자
        , V_SYSDATE             --수정일
        , P_CREATED_BY	        --수정자
    );

END INSERT_BLD_AMT_SPEC;







--grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_BLD_AMT_SPEC(
      W_SOB_ID	            IN 	FI_BLD_AMT_SPEC.SOB_ID%TYPE	            --회사아이디
    , W_ORG_ID	            IN 	FI_BLD_AMT_SPEC.ORG_ID%TYPE	            --사업부아이디
    , W_TAX_CODE 	          IN  FI_BLD_AMT_SPEC.TAX_CODE%TYPE           --사업장아이디
    , W_VAT_MNG_SERIAL	    IN 	FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE     --부가세신고기간구분번호
    , W_SPEC_SERIAL	        IN 	FI_BLD_AMT_SPEC.SPEC_SERIAL%TYPE        --일련번호
    , P_REAL_ESTATE_LOC	    IN 	FI_BLD_AMT_SPEC.REAL_ESTATE_LOC%TYPE    --부동산위치
    , P_ADDRESS	            IN 	FI_BLD_AMT_SPEC.ADDRESS%TYPE            --동
    , P_VAT_GROUND_YN	      IN 	FI_BLD_AMT_SPEC.VAT_GROUND_YN%TYPE      --지상_지하여부
    , P_BLD_FLOOR	          IN 	FI_BLD_AMT_SPEC.BLD_FLOOR%TYPE          --충
    , P_ROOM	              IN 	FI_BLD_AMT_SPEC.ROOM%TYPE               --호
    , P_LEND_AREA	          IN 	FI_BLD_AMT_SPEC.LEND_AREA%TYPE          --임대면적
    , P_PURPOSE	            IN 	FI_BLD_AMT_SPEC.PURPOSE%TYPE            --용도
    , P_CORP_NAME	          IN 	FI_BLD_AMT_SPEC.CORP_NAME%TYPE          --업체 상호
    , P_VAT_NUMBER	        IN 	FI_BLD_AMT_SPEC.VAT_NUMBER%TYPE         --사업자등록번호
    , P_IN_DATE	            IN 	FI_BLD_AMT_SPEC.IN_DATE%TYPE            --입주일
    , P_MODIFY_DATE	        IN 	FI_BLD_AMT_SPEC.MODIFY_DATE%TYPE        --갱신일
    , P_OUT_DATE	          IN 	FI_BLD_AMT_SPEC.OUT_DATE%TYPE           --퇴거일
    , P_DEPOSIT	            IN 	FI_BLD_AMT_SPEC.DEPOSIT%TYPE            --보증금
    , P_MONTH_RENT	        IN 	FI_BLD_AMT_SPEC.MONTH_RENT%TYPE         --월임대료
    , P_MONTN_FEE	          IN 	FI_BLD_AMT_SPEC.MONTN_FEE%TYPE          --월관리비
    , P_DEEMED_RENT	        IN 	FI_BLD_AMT_SPEC.DEEMED_RENT%TYPE        --보증금이자_간주임대료
    , P_TERM_RENT	          IN 	FI_BLD_AMT_SPEC.TERM_RENT%TYPE          --임대기간_임대료
    , P_TERM_FEE	          IN 	FI_BLD_AMT_SPEC.TERM_FEE%TYPE           --임대기간_관리비    
    , P_LAST_UPDATED_BY     IN  FI_BLD_AMT_SPEC.LAST_UPDATED_BY%TYPE    --수정자
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);

BEGIN

    UPDATE FI_BLD_AMT_SPEC
    SET
          REAL_ESTATE_LOC   = P_REAL_ESTATE_LOC --부동산위치    
        , ADDRESS	        = P_ADDRESS	        --동    
        , VAT_GROUND_YN	    = P_VAT_GROUND_YN	--지상_지하여부    
        , BLD_FLOOR	        = P_BLD_FLOOR	    --충    
        , ROOM              = P_ROOM	        --호    
        , LEND_AREA	        = P_LEND_AREA	    --임대면적    
        , PURPOSE           = P_PURPOSE         --용도    
        , CORP_NAME	        = P_CORP_NAME	    --상호    
        , VAT_NUMBER	    = P_VAT_NUMBER      --사업자등록번호
        , IN_DATE           = P_IN_DATE	        --입주일        
        , MODIFY_DATE	    = P_MODIFY_DATE	    --갱신일    
        , OUT_DATE	        = P_OUT_DATE	    --퇴거일    
        , DEPOSIT           = P_DEPOSIT	        --보증금    
        , MONTH_RENT	    = P_MONTH_RENT	    --월임대료    
        , MONTN_FEE         = P_MONTN_FEE       --월관리비    
        , DEEMED_RENT	    = P_DEEMED_RENT	    --보증금이자_간주임대료    
        , TERM_RENT	        = P_TERM_RENT       --임대기간_임대료
        , TERM_FEE          = P_TERM_FEE	    --임대기간_관리비                
        , LAST_UPDATE_DATE  = V_SYSDATE         --수정일
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY --수정자
    WHERE   SOB_ID                  = W_SOB_ID                  --회사아이디
        AND ORG_ID                  = W_ORG_ID                  --사업부아이디
        AND TAX_CODE                = W_TAX_CODE                --사업장아이디        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --부가세신고기간구분번호               
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --일련번호
    ;

END UPDATE_BLD_AMT_SPEC;





--grid에 조회된 자료 삭제
PROCEDURE DELETE_BLD_AMT_SPEC(
      W_SOB_ID	            IN 	FI_BLD_AMT_SPEC.SOB_ID%TYPE	            --회사아이디
    , W_ORG_ID	            IN 	FI_BLD_AMT_SPEC.ORG_ID%TYPE	            --사업부아이디
    , W_TAX_CODE	          IN 	FI_BLD_AMT_SPEC.TAX_CODE%TYPE           --사업장아이디
    , W_VAT_MNG_SERIAL	    IN 	FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE     --부가세신고기간구분번호
    , W_SPEC_SERIAL	        IN 	FI_BLD_AMT_SPEC.SPEC_SERIAL%TYPE        --일련번호
)

AS

BEGIN

    DELETE FI_BLD_AMT_SPEC
    WHERE   SOB_ID                  = W_SOB_ID                  --회사아이디
        AND ORG_ID                  = W_ORG_ID                  --사업부아이디
        AND TAX_CODE                = W_TAX_CODE                --사업장아이디        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --부가세신고기간구분번호               
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --일련번호
    ;

END DELETE_BLD_AMT_SPEC;







--부동산임대공급가액명세서 상단 출력용
PROCEDURE PRINT_BLD_AMT_SPEC(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID              IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE            IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --사업장아이디(예>42)     
    
    --아래 항목은 출력시 필수항목이다.
    , W_TAX_DATE_FR         IN  VARCHAR2    --과세기간_시작
    , W_TAX_DATE_TO         IN  VARCHAR2    --과세기간_종료
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
        , LTRIM(SUBSTR(W_TAX_DATE_FR, 6, 2), '0') || ' 월  ~  ' || LTRIM(SUBSTR(W_TAX_DATE_TO, 6, 2), '0') || ' 월' AS TAX_TERM    --과세기간
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
        AND B.USABLE                = 'Y'
        AND (B.DEFAULT_FLAG         = 'Y'
        OR   ROWNUM                 <= 1)
        ;
END PRINT_BLD_AMT_SPEC;






END FI_BLD_AMT_SPEC_G;
/
