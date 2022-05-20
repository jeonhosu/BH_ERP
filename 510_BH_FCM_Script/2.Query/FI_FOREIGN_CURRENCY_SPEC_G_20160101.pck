CREATE OR REPLACE PACKAGE FI_FOREIGN_CURRENCY_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FOREIGN_CURRENCY_SPEC_G
Description  : 외화획득명세서 Package

Reference by : calling assmbly-program id(호출 프로그램) : 외화획득명세서
Program History :
    -.자료 추출 논리 : 거래구분-매출, 세무유형-수출의 자료 중 수출신고번호가 없는 자료이다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-10-04   Leem Dong Ern(임동언)
*****************************************************************************/





--기초자료생성
--메시지 : 기초자료를 생성하시겠습니까? 기 생성된 자료가 있는 경우 기존 자료가 삭제되고 (재)생성됩니다.
--FCM_10365, 해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
PROCEDURE CREATE_FOREIGN_CURRENCY_SPEC(
      W_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_CREATED_BY          IN  FI_FOREIGN_CURRENCY_SPEC.CREATED_BY%TYPE          --생성자
    , W_REPORT_DATE_FR      IN  DATE    --신고기간_시작
    , W_REPORT_DATE_TO      IN  DATE    --신고기간_종료    
);





--조회
PROCEDURE LIST_FOREIGN_CURRENCY_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
);






--grid에 신규 항목 추가
PROCEDURE INSERT_FOREIGN_CURRENCY_SPEC(
      P_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --회사아이디
    , P_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --사업부아이디
    , P_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --사업장아이디(예>110)        
    , P_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    --, P_SPEC_SERIAL         IN  FI_FOREIGN_CURRENCY_SPEC.SPEC_SERIAL%TYPE         --일련번호
    
    , P_SUPPLY_DATE         IN  FI_FOREIGN_CURRENCY_SPEC.SUPPLY_DATE%TYPE   --공급일자
    , P_CORP_NAME           IN  FI_FOREIGN_CURRENCY_SPEC.CORP_NAME%TYPE     --상호및성명
    , P_COUNTRY_NM          IN  FI_FOREIGN_CURRENCY_SPEC.COUNTRY_NM%TYPE    --국적
    , P_GUBUN_ITEM          IN  FI_FOREIGN_CURRENCY_SPEC.GUBUN_ITEM%TYPE    --구분_재화
    , P_GUBUN_PERSON        IN  FI_FOREIGN_CURRENCY_SPEC.GUBUN_PERSON%TYPE  --구분_용역
    , P_ITEM_NM             IN  FI_FOREIGN_CURRENCY_SPEC.ITEM_NM%TYPE       --재화명칭
    , P_ITEM_CNT            IN  FI_FOREIGN_CURRENCY_SPEC.ITEM_CNT%TYPE      --수량
    , P_UNIT                IN  FI_FOREIGN_CURRENCY_SPEC.UNIT%TYPE          --단위
    , P_PRICE               IN  FI_FOREIGN_CURRENCY_SPEC.PRICE%TYPE         --단가
    , P_SUPPLY_AMT          IN  FI_FOREIGN_CURRENCY_SPEC.SUPPLY_AMT%TYPE    --공급금액

    , P_CREATED_BY	        IN	FI_FOREIGN_CURRENCY_SPEC.CREATED_BY%TYPE  --생성자
);





--grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_FOREIGN_CURRENCY_SPEC(
      W_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --사업장아이디(예>110)        
    , W_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_SPEC_SERIAL         IN  FI_FOREIGN_CURRENCY_SPEC.SPEC_SERIAL%TYPE         --일련번호
    
    , P_SUPPLY_DATE         IN  FI_FOREIGN_CURRENCY_SPEC.SUPPLY_DATE%TYPE   --공급일자
    , P_CORP_NAME           IN  FI_FOREIGN_CURRENCY_SPEC.CORP_NAME%TYPE     --상호및성명
    , P_COUNTRY_NM          IN  FI_FOREIGN_CURRENCY_SPEC.COUNTRY_NM%TYPE    --국적
    , P_GUBUN_ITEM          IN  FI_FOREIGN_CURRENCY_SPEC.GUBUN_ITEM%TYPE    --구분_재화
    , P_GUBUN_PERSON        IN  FI_FOREIGN_CURRENCY_SPEC.GUBUN_PERSON%TYPE  --구분_용역
    , P_ITEM_NM             IN  FI_FOREIGN_CURRENCY_SPEC.ITEM_NM%TYPE       --재화명칭
    , P_ITEM_CNT            IN  FI_FOREIGN_CURRENCY_SPEC.ITEM_CNT%TYPE      --수량
    , P_UNIT                IN  FI_FOREIGN_CURRENCY_SPEC.UNIT%TYPE          --단위
    , P_PRICE               IN  FI_FOREIGN_CURRENCY_SPEC.PRICE%TYPE         --단가
    , P_SUPPLY_AMT          IN  FI_FOREIGN_CURRENCY_SPEC.SUPPLY_AMT%TYPE    --공급금액
    
    , P_LAST_UPDATED_BY     IN  FI_FOREIGN_CURRENCY_SPEC.LAST_UPDATED_BY%TYPE     --수정자
);






--grid에 조회된 자료 삭제
PROCEDURE DELETE_FOREIGN_CURRENCY_SPEC(
      W_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --사업장아이디(예>110)        
    , W_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_SPEC_SERIAL         IN  FI_FOREIGN_CURRENCY_SPEC.SPEC_SERIAL%TYPE         --일련번호
);






--외화획득명세서 상단 출력용
PROCEDURE PRINT_FOREIGN_CURRENCY_SPEC(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2  --사업장아이디(예>110)         
);





END FI_FOREIGN_CURRENCY_SPEC_G;
/
CREATE OR REPLACE PACKAGE BODY FI_FOREIGN_CURRENCY_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FOREIGN_CURRENCY_SPEC_G
Description  : 외화획득명세서 Package

Reference by : calling assmbly-program id(호출 프로그램) : 외화획득명세서
Program History :
    -.자료 추출 논리 : 거래구분-매출, 세무유형-수출의 자료 중 수출신고번호가 없는 자료이다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-10-04   Leem Dong Ern(임동언)
*****************************************************************************/






--기초자료생성
PROCEDURE CREATE_FOREIGN_CURRENCY_SPEC(
      W_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_CREATED_BY          IN  FI_FOREIGN_CURRENCY_SPEC.CREATED_BY%TYPE          --생성자
    , W_REPORT_DATE_FR      IN  DATE    --신고기간_시작
    , W_REPORT_DATE_TO      IN  DATE    --신고기간_종료     
)

AS

t_CLOSING_YN    FI_VAT_REPORT_MNG.CLOSING_YN%TYPE;  --마감여부
t_SPEC_SERIAL   FI_FOREIGN_CURRENCY_SPEC.SPEC_SERIAL%TYPE;  --일련번호
V_SYSDATE       DATE := GET_LOCAL_DATE(W_SOB_ID);



BEGIN


    --해당 신고기간의 마감여부를 파악한다.
    SELECT CLOSING_YN
    INTO t_CLOSING_YN
    FROM FI_VAT_REPORT_MNG
    WHERE   SOB_ID  = W_SOB_ID  --회사아이디
        AND ORG_ID  = W_ORG_ID  --사업부아이디
        AND TAX_CODE = W_TAX_CODE             --사업장아이디
        AND VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL    --부가세신고기간구분번호
    ;    
    
    --FCM_10365, 해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
    IF t_CLOSING_YN = 'Y' THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10365', NULL));
    END IF;



    --기존에 존재하는 자료가 있을 경우 모두 삭제한다.
    DELETE FI_FOREIGN_CURRENCY_SPEC
    WHERE   SOB_ID  = W_SOB_ID  --회사아이디
        AND ORG_ID  = W_ORG_ID  --사업부아이디
        AND TAX_CODE = W_TAX_CODE --사업장아이디
        AND VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL    --부가세신고기간구분번호
    ;
    
    
    SELECT NVL(MAX(SPEC_SERIAL), 0) INTO t_SPEC_SERIAL FROM FI_FOREIGN_CURRENCY_SPEC;


    INSERT INTO FI_FOREIGN_CURRENCY_SPEC(
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디        
        , TAX_CODE	      --사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        , SPEC_SERIAL	    --일련번호        
        , SUPPLY_DATE	    --공급일자
        , CORP_NAME	        --상호및성명
        , COUNTRY_NM	    --국적
        , GUBUN_ITEM	    --구분_재화
        , GUBUN_PERSON	    --구분_용역
        , ITEM_NM	        --재화명칭
        , ITEM_CNT	        --수량
        , UNIT	            --단위
        , PRICE	            --단가
        , SUPPLY_AMT	    --공급금액        
        , CREATION_DATE     --생성일
        , CREATED_BY	    --생성자
        , LAST_UPDATE_DATE  --수정일
        , LAST_UPDATED_BY	--수정자          
    )
    SELECT
          W_SOB_ID  --회사아이디
        , W_ORG_ID  --사업부아이디
        , W_TAX_CODE       --사업장아이디
        , W_VAT_MNG_SERIAL          --부가세신고기간구분번호
        , t_SPEC_SERIAL + ROWNUM    --일련번호
        
        , A.REFER1 AS SUPPLY_DATE               --공급일자; 신고기준일자
        , B.SUPP_CUST_NAME AS CORP_NAME         --거래처
        , C.COUNTRY_SHORT_NAME AS COUNTRY_NM    --국적
        , 'Y' AS GUBUN_ITEM     --구분_재화
        , NULL AS GUBUN_PERSON  --구분_용역
        , A.REMARK AS ITEM_NM   --재화_명칭, 전표적요    
        , 0 AS ITEM_CNT         --수량
        , 'PCS' AS UNIT         --단위
        , 0.00 AS PRICE         --단가
        , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', '')) AS GL_AMOUNT     --공급가액
    
        , V_SYSDATE     --생성일
        , W_CREATED_BY  --생성자
        , V_SYSDATE     --수정일
        , W_CREATED_BY  --수정자    
    FROM FI_SLIP_LINE A
        , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO, COUNTRY_CODE FROM FI_SUPP_CUST_V) B  --거래처
        , (SELECT * FROM EAPP_COUNTRY) C
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        
        --AND A.ACCOUNT_CODE = '2100700'  --거래구분(매입/매출)
        AND A.ACCOUNT_CODE IN 
            (
                SELECT ACCOUNT_CODE
                FROM FI_ACCOUNT_CONTROL
                WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                    AND ACCOUNT_CLASS_ID = '1972'   --계정타입 : 부가세예수금
            )  --거래구분(매입/매출)             
        
        AND A.REFER11 = W_TAX_CODE                  --사업장
        
        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
        AND TO_DATE(A.REFER1) BETWEEN W_REPORT_DATE_FR AND W_REPORT_DATE_TO   --신고기준일자
        
        --거래구분-매출, 세무유형-수출의 자료 중 수출신고번호가 없는 자료이다.
        AND MANAGEMENT2 = '3'    --세무유형 : 수출    
        AND (A.REFER4 IS NULL OR TRIM(A.REFER4) = '')
        
        AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
        AND B.COUNTRY_CODE = C.COUNTRY_CODE(+) 
        ;


END CREATE_FOREIGN_CURRENCY_SPEC;






--조회
PROCEDURE LIST_FOREIGN_CURRENCY_SPEC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --사업장아이디(예>110)        
    , W_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디
        , TAX_CODE	      --사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        , SPEC_SERIAL	    --일련번호
        , SUPPLY_DATE	    --공급일자
        , CORP_NAME	        --상호및성명
        , COUNTRY_NM	    --국적
        , GUBUN_ITEM	    --구분_재화
        , GUBUN_PERSON	    --구분_용역
        , ITEM_NM	        --명칭
        , ITEM_CNT	        --수량
        , UNIT	            --단위
        , PRICE	            --단가
        , SUPPLY_AMT	    --공급가액        

        --출력용
        , TO_CHAR(SUPPLY_DATE, 'YYYY') AS PRINT_YEAR
        , TO_NUMBER(TO_CHAR(SUPPLY_DATE, 'MM')) AS PRINT_MONTH
        , TO_NUMBER(TO_CHAR(SUPPLY_DATE, 'DD')) AS PRINT_DATE       
    FROM FI_FOREIGN_CURRENCY_SPEC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
    ORDER BY SUPPLY_DATE   
    ; 


END LIST_FOREIGN_CURRENCY_SPEC;






--grid에 신규 항목 추가
PROCEDURE INSERT_FOREIGN_CURRENCY_SPEC(
      P_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --회사아이디
    , P_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --사업부아이디
    , P_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --사업장아이디(예>110)        
    , P_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    --, P_SPEC_SERIAL         IN  FI_FOREIGN_CURRENCY_SPEC.SPEC_SERIAL%TYPE         --일련번호
    
    , P_SUPPLY_DATE         IN  FI_FOREIGN_CURRENCY_SPEC.SUPPLY_DATE%TYPE   --공급일자
    , P_CORP_NAME           IN  FI_FOREIGN_CURRENCY_SPEC.CORP_NAME%TYPE     --상호및성명
    , P_COUNTRY_NM          IN  FI_FOREIGN_CURRENCY_SPEC.COUNTRY_NM%TYPE    --국적
    , P_GUBUN_ITEM          IN  FI_FOREIGN_CURRENCY_SPEC.GUBUN_ITEM%TYPE    --구분_재화
    , P_GUBUN_PERSON        IN  FI_FOREIGN_CURRENCY_SPEC.GUBUN_PERSON%TYPE  --구분_용역
    , P_ITEM_NM             IN  FI_FOREIGN_CURRENCY_SPEC.ITEM_NM%TYPE       --재화명칭
    , P_ITEM_CNT            IN  FI_FOREIGN_CURRENCY_SPEC.ITEM_CNT%TYPE      --수량
    , P_UNIT                IN  FI_FOREIGN_CURRENCY_SPEC.UNIT%TYPE          --단위
    , P_PRICE               IN  FI_FOREIGN_CURRENCY_SPEC.PRICE%TYPE         --단가
    , P_SUPPLY_AMT          IN  FI_FOREIGN_CURRENCY_SPEC.SUPPLY_AMT%TYPE    --공급금액

    , P_CREATED_BY	        IN	FI_FOREIGN_CURRENCY_SPEC.CREATED_BY%TYPE  --생성자
)

AS

V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
t_SPEC_SERIAL   FI_FOREIGN_CURRENCY_SPEC.SPEC_SERIAL%TYPE;

BEGIN

    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO t_SPEC_SERIAL FROM FI_FOREIGN_CURRENCY_SPEC;   --일련번호

    INSERT INTO FI_FOREIGN_CURRENCY_SPEC(
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디
        , TAX_CODE       	--사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        , SPEC_SERIAL	    --일련번호
        
        , SUPPLY_DATE	    --공급일자
        , CORP_NAME	        --상호및성명
        , COUNTRY_NM	    --국적
        , GUBUN_ITEM	    --구분_재화
        , GUBUN_PERSON	    --구분_용역
        , ITEM_NM	        --명칭
        , ITEM_CNT	        --수량
        , UNIT	            --단위
        , PRICE	            --단가
        , SUPPLY_AMT	    --공급가액  

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

        , P_SUPPLY_DATE	        --공급일자
        , P_CORP_NAME	        --상호및성명
        , P_COUNTRY_NM	        --국적
        , P_GUBUN_ITEM	        --구분_재화
        , P_GUBUN_PERSON	    --구분_용역
        , P_ITEM_NM	            --명칭
        , P_ITEM_CNT	        --수량
        , P_UNIT	            --단위
        , P_PRICE	            --단가
        , P_SUPPLY_AMT	        --공급가액      
       
        , V_SYSDATE             --생성일
        , P_CREATED_BY	        --생성자
        , V_SYSDATE             --수정일
        , P_CREATED_BY	        --수정자
    );

END INSERT_FOREIGN_CURRENCY_SPEC;







--grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_FOREIGN_CURRENCY_SPEC(
      W_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --사업장아이디(예>110)        
    , W_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_SPEC_SERIAL         IN  FI_FOREIGN_CURRENCY_SPEC.SPEC_SERIAL%TYPE         --일련번호
    
    , P_SUPPLY_DATE         IN  FI_FOREIGN_CURRENCY_SPEC.SUPPLY_DATE%TYPE   --공급일자
    , P_CORP_NAME           IN  FI_FOREIGN_CURRENCY_SPEC.CORP_NAME%TYPE     --상호및성명
    , P_COUNTRY_NM          IN  FI_FOREIGN_CURRENCY_SPEC.COUNTRY_NM%TYPE    --국적
    , P_GUBUN_ITEM          IN  FI_FOREIGN_CURRENCY_SPEC.GUBUN_ITEM%TYPE    --구분_재화
    , P_GUBUN_PERSON        IN  FI_FOREIGN_CURRENCY_SPEC.GUBUN_PERSON%TYPE  --구분_용역
    , P_ITEM_NM             IN  FI_FOREIGN_CURRENCY_SPEC.ITEM_NM%TYPE       --재화명칭
    , P_ITEM_CNT            IN  FI_FOREIGN_CURRENCY_SPEC.ITEM_CNT%TYPE      --수량
    , P_UNIT                IN  FI_FOREIGN_CURRENCY_SPEC.UNIT%TYPE          --단위
    , P_PRICE               IN  FI_FOREIGN_CURRENCY_SPEC.PRICE%TYPE         --단가
    , P_SUPPLY_AMT          IN  FI_FOREIGN_CURRENCY_SPEC.SUPPLY_AMT%TYPE    --공급금액
    
    , P_LAST_UPDATED_BY     IN  FI_FOREIGN_CURRENCY_SPEC.LAST_UPDATED_BY%TYPE     --수정자
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);

BEGIN

    UPDATE FI_FOREIGN_CURRENCY_SPEC
    SET
          SUPPLY_DATE   = P_SUPPLY_DATE     --공급일자    
        , CORP_NAME	    = P_CORP_NAME	    --상호및성명
        , COUNTRY_NM	= P_COUNTRY_NM	    --국적
        , GUBUN_ITEM	= P_GUBUN_ITEM	    --구분_재화
        , GUBUN_PERSON	= P_GUBUN_PERSON    --구분_용역
        , ITEM_NM	    = P_ITEM_NM	        --재화명칭
        , ITEM_CNT	    = P_ITEM_CNT	    --수량
        , UNIT	        = P_UNIT	        --단위
        , PRICE	        = P_PRICE	        --단가
        , SUPPLY_AMT	= P_SUPPLY_AMT	    --공급금액
                  
        , LAST_UPDATE_DATE  = V_SYSDATE         --수정일
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY --수정자
    WHERE   SOB_ID                  = W_SOB_ID                  --회사아이디
        AND ORG_ID                  = W_ORG_ID                  --사업부아이디
        AND TAX_CODE                = W_TAX_CODE                --사업장아이디        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --부가세신고기간구분번호               
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --일련번호
    ;

END UPDATE_FOREIGN_CURRENCY_SPEC;







--grid에 조회된 자료 삭제
PROCEDURE DELETE_FOREIGN_CURRENCY_SPEC(
      W_SOB_ID              IN  FI_FOREIGN_CURRENCY_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_FOREIGN_CURRENCY_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_FOREIGN_CURRENCY_SPEC.TAX_CODE%TYPE   --사업장아이디(예>110)        
    , W_VAT_MNG_SERIAL      IN  FI_FOREIGN_CURRENCY_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_SPEC_SERIAL         IN  FI_FOREIGN_CURRENCY_SPEC.SPEC_SERIAL%TYPE         --일련번호
)

AS

BEGIN

    DELETE FI_FOREIGN_CURRENCY_SPEC
    WHERE   SOB_ID                  = W_SOB_ID                  --회사아이디
        AND ORG_ID                  = W_ORG_ID                  --사업부아이디
        AND TAX_CODE                = W_TAX_CODE                --사업장아이디        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --부가세신고기간구분번호               
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --일련번호
    ;

END DELETE_FOREIGN_CURRENCY_SPEC;







--외화획득명세서 상단 출력용
PROCEDURE PRINT_FOREIGN_CURRENCY_SPEC(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2  --사업장아이디(예>110)      
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          B.VAT_NUMBER  --사업자등록번호
        , A.CORP_NAME   --상호(법인명)
        , A.PRESIDENT_NAME AS PRESIDENT_NAME   --성명(대표자)
        , B.ADDR1 || ' ' || B.ADDR2 AS LOCATION     --사업장소재지
        , A.TEL_NUMBER                              --전화번호
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
        OR   ROWNUM                 <= 1)
        ;

END PRINT_FOREIGN_CURRENCY_SPEC;






END FI_FOREIGN_CURRENCY_SPEC_G;
/
