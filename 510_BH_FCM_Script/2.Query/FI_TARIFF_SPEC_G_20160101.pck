CREATE OR REPLACE PACKAGE FI_TARIFF_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_TARIFF_SPEC_G
Description  : 관세환급금등명세서 Package

Reference by : calling assmbly-program id(호출 프로그램) : (관세환급금등명세서)
Program History :
    -.참조>이 자료는 작업자가 부가가치세신고와 관련하여 직접 입력하는 자료로 전표와는 무관한다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-19   Leem Dong Ern(임동언)
*****************************************************************************/





--grid에 조회되는 자료 추출
PROCEDURE LIST_TARIFF_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_TARIFF_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID                  IN  FI_TARIFF_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE                IN  FI_TARIFF_SPEC.TAX_CODE%TYPE              --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL          IN  FI_TARIFF_SPEC.VAT_MNG_SERIAL%TYPE        --부가세신고기간구분번호
);







--grid에 조회되는 자료 중 금액자료들에 대한 합계
PROCEDURE SUM_TARIFF_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_TARIFF_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID                  IN  FI_TARIFF_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE                IN  FI_TARIFF_SPEC.TAX_CODE%TYPE              --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL          IN  FI_TARIFF_SPEC.VAT_MNG_SERIAL%TYPE        --부가세신고기간구분번호
);







--grid에 신규 항목 추가
PROCEDURE INSERT_TARIFF_SPEC(
      P_SOB_ID	            IN 	FI_TARIFF_SPEC.SOB_ID%TYPE	            --회사아이디
    , P_ORG_ID	            IN 	FI_TARIFF_SPEC.ORG_ID%TYPE	            --사업부아이디
    , P_TAX_CODE	          IN 	FI_TARIFF_SPEC.TAX_CODE%TYPE            --사업장아이디
    , P_VAT_MNG_SERIAL	    IN 	FI_TARIFF_SPEC.VAT_MNG_SERIAL%TYPE     --부가세신고기간구분번호
    --, P_SPEC_SERIAL	        IN 	FI_TARIFF_SPEC.SPEC_SERIAL%TYPE        --일련번호
    
    , P_SUPPLY_DATE	        IN 	FI_TARIFF_SPEC.SUPPLY_DATE%TYPE     --공급일자
    , P_SUPPLY_AMT	        IN 	FI_TARIFF_SPEC.SUPPLY_AMT%TYPE      --공급금액
    , P_CORP_NAME	          IN 	FI_TARIFF_SPEC.CORP_NAME%TYPE       --업체 상호
    , P_VAT_NUMBER	        IN 	FI_TARIFF_SPEC.VAT_NUMBER%TYPE      --사업자등록번호
    , P_LC_NO	              IN 	FI_TARIFF_SPEC.LC_NO%TYPE           --내국신용장번호    
    , P_CREATED_BY	        IN	FI_TARIFF_SPEC.CREATED_BY%TYPE	    --생성자
);





--grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_TARIFF_SPEC(
      W_SOB_ID	            IN 	FI_TARIFF_SPEC.SOB_ID%TYPE	            --회사아이디
    , W_ORG_ID	            IN 	FI_TARIFF_SPEC.ORG_ID%TYPE	            --사업부아이디
    , W_TAX_CODE	          IN 	FI_TARIFF_SPEC.TAX_CODE%TYPE            --사업장아이디
    , W_VAT_MNG_SERIAL	    IN 	FI_TARIFF_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_SPEC_SERIAL	        IN 	FI_TARIFF_SPEC.SPEC_SERIAL%TYPE         --일련번호
    
    , P_SUPPLY_DATE	        IN 	FI_TARIFF_SPEC.SUPPLY_DATE%TYPE         --공급일자
    , P_SUPPLY_AMT	        IN 	FI_TARIFF_SPEC.SUPPLY_AMT%TYPE          --공급금액
    , P_CORP_NAME	          IN 	FI_TARIFF_SPEC.CORP_NAME%TYPE           --업체 상호
    , P_VAT_NUMBER	        IN 	FI_TARIFF_SPEC.VAT_NUMBER%TYPE          --사업자등록번호
    , P_LC_NO	              IN 	FI_TARIFF_SPEC.LC_NO%TYPE               --내국신용장번호    
    , P_LAST_UPDATED_BY     IN  FI_TARIFF_SPEC.LAST_UPDATED_BY%TYPE     --수정자
);






--grid에 조회된 자료 삭제
PROCEDURE DELETE_TARIFF_SPEC(
      W_SOB_ID	            IN 	FI_BLD_AMT_SPEC.SOB_ID%TYPE	            --회사아이디
    , W_ORG_ID	            IN 	FI_BLD_AMT_SPEC.ORG_ID%TYPE	            --사업부아이디
    , W_TAX_CODE	          IN 	FI_BLD_AMT_SPEC.TAX_CODE%TYPE           --사업장아이디
    , W_VAT_MNG_SERIAL	    IN 	FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE     --부가세신고기간구분번호
    , W_SPEC_SERIAL	        IN 	FI_BLD_AMT_SPEC.SPEC_SERIAL%TYPE        --일련번호
);






--관세환급금등명세서 상단 출력용
PROCEDURE PRINT_TARIFF_SPEC(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID              IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE            IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --사업장아이디(예>110)     
);





END FI_TARIFF_SPEC_G;
/
CREATE OR REPLACE PACKAGE BODY FI_TARIFF_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_TARIFF_SPEC_G
Description  : 관세환급금등명세서 Package

Reference by : calling assmbly-program id(호출 프로그램) : (관세환급금등명세서)
Program History :
    -.참조>이 자료는 작업자가 부가가치세신고와 관련하여 직접 입력하는 자료로 전표와는 무관한다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-19   Leem Dong Ern(임동언)
*****************************************************************************/






--grid에 조회되는 자료 추출
PROCEDURE LIST_TARIFF_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_TARIFF_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID                  IN  FI_TARIFF_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE                IN  FI_TARIFF_SPEC.TAX_CODE%TYPE              --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL          IN  FI_TARIFF_SPEC.VAT_MNG_SERIAL%TYPE        --부가세신고기간구분번호
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디
        , TAX_CODE	      --사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        , FI_VAT_REPORT_MNG_G.VAT_MNG_SERIAL_F(VAT_MNG_SERIAL) AS VAT_REPORT_NM   --신고기간구분명
        , SPEC_SERIAL	    --일련번호        
        
        , SUPPLY_DATE                               --공급일자
        , TO_CHAR(SUPPLY_DATE, 'YYYY') AS DATE_YEAR --공급일자_년
        , TO_CHAR(SUPPLY_DATE, 'MM') AS DATE_MM     --공급일자_월
        , TO_CHAR(SUPPLY_DATE, 'DD') AS DATE_DD     --공급일자_일
        , SUPPLY_AMT    --공급금액
        , CORP_NAME     --업체 상호
        , VAT_NUMBER    --사업자등록번호
        , LC_NO         --내국신용장번호       
    FROM FI_TARIFF_SPEC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE          
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
    ORDER BY SUPPLY_DATE, CORP_NAME   ; 


END LIST_TARIFF_SPEC;






--grid에 조회되는 자료 중 금액자료들에 대한 합계
PROCEDURE SUM_TARIFF_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID                  IN  FI_TARIFF_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID                  IN  FI_TARIFF_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE                IN  FI_TARIFF_SPEC.TAX_CODE%TYPE              --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL          IN  FI_TARIFF_SPEC.VAT_MNG_SERIAL%TYPE        --부가세신고기간구분번호
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          NVL(SUM(SUPPLY_AMT), 0) AS DEPOSIT   --공급금액        
    FROM FI_TARIFF_SPEC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   ;


END SUM_TARIFF_SPEC;








--grid에 신규 항목 추가
PROCEDURE INSERT_TARIFF_SPEC(
      P_SOB_ID	            IN 	FI_TARIFF_SPEC.SOB_ID%TYPE	            --회사아이디
    , P_ORG_ID	            IN 	FI_TARIFF_SPEC.ORG_ID%TYPE	            --사업부아이디
    , P_TAX_CODE	          IN 	FI_TARIFF_SPEC.TAX_CODE%TYPE            --사업장아이디
    , P_VAT_MNG_SERIAL	    IN 	FI_TARIFF_SPEC.VAT_MNG_SERIAL%TYPE     --부가세신고기간구분번호
    --, P_SPEC_SERIAL	        IN 	FI_TARIFF_SPEC.SPEC_SERIAL%TYPE        --일련번호
    
    , P_SUPPLY_DATE	        IN 	FI_TARIFF_SPEC.SUPPLY_DATE%TYPE     --공급일자
    , P_SUPPLY_AMT	        IN 	FI_TARIFF_SPEC.SUPPLY_AMT%TYPE      --공급금액
    , P_CORP_NAME	          IN 	FI_TARIFF_SPEC.CORP_NAME%TYPE       --업체 상호
    , P_VAT_NUMBER	        IN 	FI_TARIFF_SPEC.VAT_NUMBER%TYPE      --사업자등록번호
    , P_LC_NO	              IN 	FI_TARIFF_SPEC.LC_NO%TYPE           --내국신용장번호    
    , P_CREATED_BY	        IN	FI_TARIFF_SPEC.CREATED_BY%TYPE	    --생성자
)

AS

V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
t_SPEC_SERIAL   FI_TARIFF_SPEC.SPEC_SERIAL%TYPE;

BEGIN

    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO t_SPEC_SERIAL FROM FI_TARIFF_SPEC;   --일련번호

    INSERT INTO FI_TARIFF_SPEC(
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디
        , TAX_CODE	      --사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        , SPEC_SERIAL	    --일련번호
        
        , SUPPLY_DATE       --공급일자
        , SUPPLY_AMT        --공급금액
        , CORP_NAME         --업체 상호
        , VAT_NUMBER        --사업자등록번호
        , LC_NO             --내국신용장번호

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

        , P_SUPPLY_DATE         --공급일자
        , P_SUPPLY_AMT          --공급금액
        , P_CORP_NAME           --업체 상호
        , P_VAT_NUMBER          --사업자등록번호
        , P_LC_NO               --내국신용장번호
       
        , V_SYSDATE             --생성일
        , P_CREATED_BY	        --생성자
        , V_SYSDATE             --수정일
        , P_CREATED_BY	        --수정자
    );

END INSERT_TARIFF_SPEC;







--grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_TARIFF_SPEC(
      W_SOB_ID	            IN 	FI_TARIFF_SPEC.SOB_ID%TYPE	            --회사아이디
    , W_ORG_ID	            IN 	FI_TARIFF_SPEC.ORG_ID%TYPE	            --사업부아이디
    , W_TAX_CODE	          IN 	FI_TARIFF_SPEC.TAX_CODE%TYPE            --사업장아이디
    , W_VAT_MNG_SERIAL	    IN 	FI_TARIFF_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_SPEC_SERIAL	        IN 	FI_TARIFF_SPEC.SPEC_SERIAL%TYPE         --일련번호
    
    , P_SUPPLY_DATE	        IN 	FI_TARIFF_SPEC.SUPPLY_DATE%TYPE         --공급일자
    , P_SUPPLY_AMT	        IN 	FI_TARIFF_SPEC.SUPPLY_AMT%TYPE          --공급금액
    , P_CORP_NAME	          IN 	FI_TARIFF_SPEC.CORP_NAME%TYPE           --업체 상호
    , P_VAT_NUMBER	        IN 	FI_TARIFF_SPEC.VAT_NUMBER%TYPE          --사업자등록번호
    , P_LC_NO	              IN 	FI_TARIFF_SPEC.LC_NO%TYPE               --내국신용장번호    
    , P_LAST_UPDATED_BY     IN  FI_TARIFF_SPEC.LAST_UPDATED_BY%TYPE     --수정자
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);

BEGIN

    UPDATE FI_TARIFF_SPEC
    SET
          SUPPLY_DATE   = P_SUPPLY_DATE --공급일자    
        , SUPPLY_AMT	  = P_SUPPLY_AMT	--공급금액    
        , CORP_NAME	    = P_CORP_NAME	--업체 상호    
        , VAT_NUMBER	  = P_VAT_NUMBER	--사업자등록번호    
        , LC_NO         = P_LC_NO	    --내국신용장번호      
               
        , LAST_UPDATE_DATE  = V_SYSDATE         --수정일
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY --수정자
    WHERE   SOB_ID                  = W_SOB_ID                  --회사아이디
        AND ORG_ID                  = W_ORG_ID                  --사업부아이디
        AND TAX_CODE                = W_TAX_CODE                --사업장아이디        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --부가세신고기간구분번호               
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --일련번호
    ;

END UPDATE_TARIFF_SPEC;





--grid에 조회된 자료 삭제
PROCEDURE DELETE_TARIFF_SPEC(
      W_SOB_ID	            IN 	FI_BLD_AMT_SPEC.SOB_ID%TYPE	            --회사아이디
    , W_ORG_ID	            IN 	FI_BLD_AMT_SPEC.ORG_ID%TYPE	            --사업부아이디
    , W_TAX_CODE	          IN 	FI_BLD_AMT_SPEC.TAX_CODE%TYPE           --사업장아이디
    , W_VAT_MNG_SERIAL	    IN 	FI_BLD_AMT_SPEC.VAT_MNG_SERIAL%TYPE     --부가세신고기간구분번호
    , W_SPEC_SERIAL	        IN 	FI_BLD_AMT_SPEC.SPEC_SERIAL%TYPE        --일련번호
)

AS

BEGIN

    DELETE FI_TARIFF_SPEC
    WHERE   SOB_ID                  = W_SOB_ID                  --회사아이디
        AND ORG_ID                  = W_ORG_ID                  --사업부아이디
        AND TAX_CODE                = W_TAX_CODE                --사업장아이디        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --부가세신고기간구분번호               
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --일련번호
    ;

END DELETE_TARIFF_SPEC;







--관세환급금등명세서 상단 출력용
PROCEDURE PRINT_TARIFF_SPEC(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --회사아이디
    , W_ORG_ID              IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --사업부아이디
    , W_TAX_CODE            IN  FI_ZERO_TAX_SPEC.TAX_CODE%TYPE              --사업장아이디(예>110)     
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
        , B.BUSINESS_ITEM AS BUSINESS_ITEM    --업태
        , B.BUSINESS_TYPE AS BUSINESS_TYPE    --종목
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


END PRINT_TARIFF_SPEC;






END FI_TARIFF_SPEC_G;
/
