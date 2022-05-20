CREATE OR REPLACE PACKAGE FI_EXPORT_CONFIRM_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_EXPORT_CONFIRM_SPEC_G
Description  : 수출실적의 확인 및 증명발급(신청)서 Package

Reference by : calling assmbly-program id(호출 프로그램) : 수출실적의 확인 및 증명발급(신청)서
Program History :
    -.자료 추출 논리 :
      [거래구분-매출, 세무유형-영세매출]의 자료를 추출하여 화면에 보여주고, 이 근간자료를 바탕으로 작업자가 
      불필요한 자료([관세환급급등명세서] 에 기입된 자료)를 삭제하여 최종 완료된다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-30   Leem Dong Ern(임동언)
*****************************************************************************/





--기초자료생성
--메시지 : 기초자료를 생성하시겠습니까? 기 생성된 자료가 있는 경우 기존 자료가 삭제되고 (재)생성됩니다.
--FCM_10365, 해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
PROCEDURE CREATE_EXPORT_CONFIRM(
      W_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_CREATED_BY          IN  FI_EXPORT_CONFIRM_SPEC.CREATED_BY%TYPE          --생성자
    , W_REPORT_DATE_FR      IN  DATE    --신고기간_시작
    , W_REPORT_DATE_TO      IN  DATE    --신고기간_종료     
);





--조회
PROCEDURE LIST_EXPORT_CONFIRM(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --사업장아이디(예>110)        
    , W_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
);






--grid에 신규 항목 추가
PROCEDURE INSERT_EXPORT_CONFIRM(
       P_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --회사아이디
    , P_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --사업부아이디
    , P_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --사업장아이디(예>110)        
    , P_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    --, P_SPEC_SERIAL         IN  FI_EXPORT_CONFIRM_SPEC.SPEC_SERIAL%TYPE         --일련번호
    
    , P_EXPORT_DATE         IN  FI_EXPORT_CONFIRM_SPEC.EXPORT_DATE%TYPE         --수출일자
    , P_PURCHASE_NO         IN  FI_EXPORT_CONFIRM_SPEC.PURCHASE_NO%TYPE         --매입번호
    , P_ITEM_NM             IN  FI_EXPORT_CONFIRM_SPEC.ITEM_NM%TYPE             --품명
    , P_SUPPLY_AMT          IN  FI_EXPORT_CONFIRM_SPEC.SUPPLY_AMT%TYPE          --공급가액
    , P_CURRENCY_CODE       IN  FI_EXPORT_CONFIRM_SPEC.CURRENCY_CODE%TYPE       --통화코드
    , P_CURRENCY_AMT        IN  FI_EXPORT_CONFIRM_SPEC.CURRENCY_AMT%TYPE        --외화금액
    , P_REMARKS             IN  FI_EXPORT_CONFIRM_SPEC.REMARKS%TYPE             --비고

    , P_CREATED_BY	        IN	FI_EXPORT_CONFIRM_SPEC.CREATED_BY%TYPE  --생성자
);





--grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_EXPORT_CONFIRM(
      W_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --사업장아이디(예>110)        
    , W_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_SPEC_SERIAL         IN  FI_EXPORT_CONFIRM_SPEC.SPEC_SERIAL%TYPE         --일련번호
    
    , P_EXPORT_DATE         IN  FI_EXPORT_CONFIRM_SPEC.EXPORT_DATE%TYPE         --수출일자
    , P_PURCHASE_NO         IN  FI_EXPORT_CONFIRM_SPEC.PURCHASE_NO%TYPE         --매입번호
    , P_ITEM_NM             IN  FI_EXPORT_CONFIRM_SPEC.ITEM_NM%TYPE             --품명
    , P_SUPPLY_AMT          IN  FI_EXPORT_CONFIRM_SPEC.SUPPLY_AMT%TYPE          --공급가액
    , P_CURRENCY_CODE       IN  FI_EXPORT_CONFIRM_SPEC.CURRENCY_CODE%TYPE       --통화코드
    , P_CURRENCY_AMT        IN  FI_EXPORT_CONFIRM_SPEC.CURRENCY_AMT%TYPE        --외화금액
    , P_REMARKS             IN  FI_EXPORT_CONFIRM_SPEC.REMARKS%TYPE             --비고
    
    , P_LAST_UPDATED_BY     IN  FI_EXPORT_CONFIRM_SPEC.LAST_UPDATED_BY%TYPE     --수정자
);






--grid에 조회된 자료 삭제
PROCEDURE DELETE_EXPORT_CONFIRM(
      W_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --사업장아이디(예>110)        
    , W_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_SPEC_SERIAL         IN  FI_EXPORT_CONFIRM_SPEC.SPEC_SERIAL%TYPE         --일련번호
);






--수출실적의 확인 및 증명발급(신청)서 상단 출력용
PROCEDURE PRINT_EXPORT_CONFIRM(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2 --사업장아이디(예>110)      
);





END FI_EXPORT_CONFIRM_SPEC_G;
/
CREATE OR REPLACE PACKAGE BODY FI_EXPORT_CONFIRM_SPEC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_EXPORT_CONFIRM_G
Description  : 수출실적의 확인 및 증명발급(신청)서 Package

Reference by : calling assmbly-program id(호출 프로그램) : 수출실적의 확인 및 증명발급(신청)서
Program History :
    -.자료 추출 논리 :
      [거래구분-매출, 세무유형-영세매출]의 자료를 추출하여 화면에 보여주고, 이 근간자료를 바탕으로 작업자가 
      불필요한 자료([관세환급급등명세서] 에 기입된 자료)를 삭제하여 최종 완료된다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-30   Leem Dong Ern(임동언)
*****************************************************************************/






--기초자료생성
PROCEDURE CREATE_EXPORT_CONFIRM(
      W_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_CREATED_BY          IN  FI_EXPORT_CONFIRM_SPEC.CREATED_BY%TYPE          --생성자
    , W_REPORT_DATE_FR      IN  DATE    --신고기간_시작
    , W_REPORT_DATE_TO      IN  DATE    --신고기간_종료     
)

AS

t_CLOSING_YN    FI_VAT_REPORT_MNG.CLOSING_YN%TYPE;  --마감여부
t_SPEC_SERIAL   FI_EXPORT_CONFIRM_SPEC.SPEC_SERIAL%TYPE;  --일련번호
V_SYSDATE       DATE := GET_LOCAL_DATE(W_SOB_ID);



BEGIN


    --해당 신고기간의 마감여부를 파악한다.
    SELECT CLOSING_YN
    INTO t_CLOSING_YN
    FROM FI_VAT_REPORT_MNG
    WHERE   SOB_ID  = W_SOB_ID  --회사아이디
        AND ORG_ID  = W_ORG_ID  --사업부아이디
        AND TAX_CODE = W_TAX_CODE                   --사업장아이디
        AND VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL    --부가세신고기간구분번호
    ;    
    
    --FCM_10365, 해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
    IF t_CLOSING_YN = 'Y' THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10365', NULL));
    END IF;



    --기존에 존재하는 자료가 있을 경우 모두 삭제한다.
    DELETE FI_EXPORT_CONFIRM_SPEC
    WHERE   SOB_ID  = W_SOB_ID  --회사아이디
        AND ORG_ID  = W_ORG_ID  --사업부아이디
        AND TAX_CODE = W_TAX_CODE                   --사업장아이디
        AND VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL    --부가세신고기간구분번호
    ;
    
    
    SELECT NVL(MAX(SPEC_SERIAL), 0) INTO t_SPEC_SERIAL FROM FI_EXPORT_CONFIRM_SPEC;


    INSERT INTO FI_EXPORT_CONFIRM_SPEC(
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디        
        , TAX_CODE      	--사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        , SPEC_SERIAL	    --일련번호
        , EXPORT_DATE	    --수출일자
        , PURCHASE_NO	    --매입번호
        , ITEM_NM	        --품명
        , SUPPLY_AMT	    --공급가액
        , CURRENCY_CODE	    --통화코드
        , CURRENCY_AMT	    --외화금액        
        , REMARKS	        --비고        
        , CREATION_DATE     --생성일
        , CREATED_BY	    --생성자
        , LAST_UPDATE_DATE  --수정일
        , LAST_UPDATED_BY	--수정자          
    )
    SELECT
          W_SOB_ID  --회사아이디
        , W_ORG_ID  --사업부아이디
        , W_TAX_CODE        --사업장아이디
        , W_VAT_MNG_SERIAL  --부가세신고기간구분번호
        , t_SPEC_SERIAL + ROWNUM    --일련번호
    
        , A.REFER1 AS EXPORT_DATE   --수출일자; 신고기준일자
        , '' AS PURCHASE_NO    --매입번호
        , A.REMARK AS ITEM_NM  --품명, 전표적요
        , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', '')) AS GL_AMOUNT     --공급가액
        , DECODE(A.REFER3, NULL, 'USD', A.REFER3) AS CURRENCY_CODE --통화코드
        , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS CURRENCY_AMOUNT     --외화금액    
        , B.SUPP_CUST_NAME AS REMARKS             --비고; 거래처명 
        
        , V_SYSDATE     --생성일
        , W_CREATED_BY  --생성자
        , V_SYSDATE     --수정일
        , W_CREATED_BY  --수정자
    FROM FI_SLIP_LINE A
        , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --거래처
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
        
        AND TO_DATE(A.REFER1) BETWEEN W_REPORT_DATE_FR AND W_REPORT_DATE_TO   --신고기준일자
        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401') AND TO_DATE('20110630')   --신고기준일자
        
        AND MANAGEMENT2 = '2'    --세무유형 : 영세매출    
        AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
    ;  


END CREATE_EXPORT_CONFIRM;






--조회
PROCEDURE LIST_EXPORT_CONFIRM(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --사업장아이디(예>110)        
    , W_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디
        , TAX_CODE      	--사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        , SPEC_SERIAL	    --일련번호
        , EXPORT_DATE	    --수출일자
        , PURCHASE_NO	    --매입번호
        , ITEM_NM	        --품명
        , SUPPLY_AMT	    --공급가액
        , CURRENCY_CODE	    --통화코드
        , CURRENCY_AMT	    --외화금액
        , REMARKS	        --비고
        , '' AS COMPANY     --거래처(화면에서 거래처 팝업처리하기 위해)
        
        --출력용
        , TO_CHAR(EXPORT_DATE, 'YYYY')  || '년 '
          || TO_NUMBER(TO_CHAR(EXPORT_DATE, 'MM')) || '월 ' 
          || TO_NUMBER(TO_CHAR(EXPORT_DATE, 'DD')) || '일' AS PRINT_EXPORT_DATE 	    --수출일자
        , '(' || DECODE(CURRENCY_CODE, 'USD', '$', 'JPY', '￥', CURRENCY_CODE) 
          || CURRENCY_AMT || ')' AS EXPORT_OUTPUT  --수출실적        
    FROM FI_EXPORT_CONFIRM_SPEC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
    ORDER BY EXPORT_DATE   ; 


END LIST_EXPORT_CONFIRM;






--grid에 신규 항목 추가
PROCEDURE INSERT_EXPORT_CONFIRM(
      P_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --회사아이디
    , P_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --사업부아이디
    , P_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --사업장아이디(예>110)        
    , P_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    --, P_SPEC_SERIAL         IN  FI_EXPORT_CONFIRM_SPEC.SPEC_SERIAL%TYPE         --일련번호
    
    , P_EXPORT_DATE         IN  FI_EXPORT_CONFIRM_SPEC.EXPORT_DATE%TYPE         --수출일자
    , P_PURCHASE_NO         IN  FI_EXPORT_CONFIRM_SPEC.PURCHASE_NO%TYPE         --매입번호
    , P_ITEM_NM             IN  FI_EXPORT_CONFIRM_SPEC.ITEM_NM%TYPE             --품명
    , P_SUPPLY_AMT          IN  FI_EXPORT_CONFIRM_SPEC.SUPPLY_AMT%TYPE          --공급가액
    , P_CURRENCY_CODE       IN  FI_EXPORT_CONFIRM_SPEC.CURRENCY_CODE%TYPE       --통화코드
    , P_CURRENCY_AMT        IN  FI_EXPORT_CONFIRM_SPEC.CURRENCY_AMT%TYPE        --외화금액
    , P_REMARKS             IN  FI_EXPORT_CONFIRM_SPEC.REMARKS%TYPE             --비고

    , P_CREATED_BY	        IN	FI_EXPORT_CONFIRM_SPEC.CREATED_BY%TYPE  --생성자
)

AS

V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
t_SPEC_SERIAL   FI_EXPORT_CONFIRM_SPEC.SPEC_SERIAL%TYPE;

BEGIN

    SELECT NVL(MAX(SPEC_SERIAL), 0) + 1 INTO t_SPEC_SERIAL FROM FI_EXPORT_CONFIRM_SPEC;   --일련번호

    INSERT INTO FI_EXPORT_CONFIRM_SPEC(
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디
        , TAX_CODE      	--사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        , SPEC_SERIAL	    --일련번호
        
        , EXPORT_DATE       --수출일자
        , PURCHASE_NO       --매입번호
        , ITEM_NM           --품명
        , SUPPLY_AMT        --공급가액
        , CURRENCY_CODE     --통화코드
        , CURRENCY_AMT      --외화금액
        , REMARKS           --비고

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

        , P_EXPORT_DATE         --수출일자
        , P_PURCHASE_NO         --매입번호
        , P_ITEM_NM             --품명
        , P_SUPPLY_AMT          --공급가액
        , P_CURRENCY_CODE       --통화코드
        , P_CURRENCY_AMT        --외화금액
        , P_REMARKS             --비고       
       
        , V_SYSDATE             --생성일
        , P_CREATED_BY	        --생성자
        , V_SYSDATE             --수정일
        , P_CREATED_BY	        --수정자
    );

END INSERT_EXPORT_CONFIRM;







--grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_EXPORT_CONFIRM(
      W_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --사업장아이디(예>110)        
    , W_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_SPEC_SERIAL         IN  FI_EXPORT_CONFIRM_SPEC.SPEC_SERIAL%TYPE         --일련번호
    
    , P_EXPORT_DATE         IN  FI_EXPORT_CONFIRM_SPEC.EXPORT_DATE%TYPE         --수출일자
    , P_PURCHASE_NO         IN  FI_EXPORT_CONFIRM_SPEC.PURCHASE_NO%TYPE         --매입번호
    , P_ITEM_NM             IN  FI_EXPORT_CONFIRM_SPEC.ITEM_NM%TYPE             --품명
    , P_SUPPLY_AMT          IN  FI_EXPORT_CONFIRM_SPEC.SUPPLY_AMT%TYPE          --공급가액
    , P_CURRENCY_CODE       IN  FI_EXPORT_CONFIRM_SPEC.CURRENCY_CODE%TYPE       --통화코드
    , P_CURRENCY_AMT        IN  FI_EXPORT_CONFIRM_SPEC.CURRENCY_AMT%TYPE        --외화금액
    , P_REMARKS             IN  FI_EXPORT_CONFIRM_SPEC.REMARKS%TYPE             --비고
    
    , P_LAST_UPDATED_BY     IN  FI_EXPORT_CONFIRM_SPEC.LAST_UPDATED_BY%TYPE     --수정자
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);

BEGIN

    UPDATE FI_EXPORT_CONFIRM_SPEC
    SET
          EXPORT_DATE   = P_EXPORT_DATE --수출일자    
        , PURCHASE_NO	= P_PURCHASE_NO	--매입번호
        , ITEM_NM	    = P_ITEM_NM	    --품명
        , SUPPLY_AMT	= P_SUPPLY_AMT	--공급가액
        , CURRENCY_CODE	= P_CURRENCY_CODE   --통화코드
        , CURRENCY_AMT	= P_CURRENCY_AMT	--외화금액
        , REMARKS	    = P_REMARKS         --비고
                   
        , LAST_UPDATE_DATE  = V_SYSDATE         --수정일
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY --수정자
    WHERE   SOB_ID                  = W_SOB_ID                  --회사아이디
        AND ORG_ID                  = W_ORG_ID                  --사업부아이디
        AND TAX_CODE                = W_TAX_CODE                --사업장아이디        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --부가세신고기간구분번호               
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --일련번호
    ;

END UPDATE_EXPORT_CONFIRM;







--grid에 조회된 자료 삭제
PROCEDURE DELETE_EXPORT_CONFIRM(
      W_SOB_ID              IN  FI_EXPORT_CONFIRM_SPEC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_EXPORT_CONFIRM_SPEC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_EXPORT_CONFIRM_SPEC.TAX_CODE%TYPE            --사업장아이디(예>110)        
    , W_VAT_MNG_SERIAL      IN  FI_EXPORT_CONFIRM_SPEC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_SPEC_SERIAL         IN  FI_EXPORT_CONFIRM_SPEC.SPEC_SERIAL%TYPE         --일련번호
)

AS

BEGIN

    DELETE FI_EXPORT_CONFIRM_SPEC
    WHERE   SOB_ID                  = W_SOB_ID                  --회사아이디
        AND ORG_ID                  = W_ORG_ID                  --사업부아이디
        AND TAX_CODE                = W_TAX_CODE                --사업장아이디        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --부가세신고기간구분번호               
        AND SPEC_SERIAL             = W_SPEC_SERIAL             --일련번호
    ;

END DELETE_EXPORT_CONFIRM;







--수출실적의 확인 및 증명발급(신청)서 상단 출력용
PROCEDURE PRINT_EXPORT_CONFIRM(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --회사아이디
    , W_ORG_ID              IN  NUMBER  --사업부아이디
    , W_TAX_CODE            IN  VARCHAR2 --사업장아이디(예>110)      
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          B.VAT_NUMBER  --사업자등록번호
        , A.CORP_NAME   --상호(법인명)
        , '대표이사  ' || A.PRESIDENT_NAME AS PRESIDENT_NAME   --성명(대표자)
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

END PRINT_EXPORT_CONFIRM;






END FI_EXPORT_CONFIRM_SPEC_G;
/
