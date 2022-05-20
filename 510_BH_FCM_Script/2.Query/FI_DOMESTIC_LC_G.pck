CREATE OR REPLACE PACKAGE FI_DOMESTIC_LC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_DOMESTIC_LC_G(내국신용장 구매확인서 전자발급명세서)
Description  : 내국신용장 구매확인서 전자발급명세서 Package

Reference by : calling assmbly-program id(호출 프로그램) : 내국신용장 구매확인서 전자발급명세서
Program History :
    *.매입/매출장의 세무유형이 영세매출인 자료가 기준 자료이다.
    *.구분은 공통코드에 있는 값을 이용한다. VAT_DOMESTIC_LC[전자발급명세서(내국신용장)]
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2012-01-02   Leem Dong Ern(임동언)
*****************************************************************************/





--기초자료생성
--메시지 : 기초자료를 생성하시겠습니까? 기 생성된 자료가 있는 경우 기존 자료가 삭제되고 (재)생성됩니다.
--FCM_10368, 사업장, 과세년도, 신고기간구분, 작성일자, 거래기간은 필수입니다.
--FCM_10365, 해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
PROCEDURE CREATE_DOMESTIC_LC(
      W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE            --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_CREATED_BY          IN  FI_DOMESTIC_LC.CREATED_BY%TYPE          --생성자
    , W_DEAL_DATE_FR        IN  DATE    --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --거래기간_종료    
    
    , O_MESSAGE             OUT VARCHAR2
);






--상단조회
PROCEDURE LIST_UP_DOMESTIC_LC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE            --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
);






--하단조회
PROCEDURE LIST_DOWN_DOMESTIC_LC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE            --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
);






--구분 POPUP
PROCEDURE POPUP_DOMESTIC_LC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --사업부아이디
);








--grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_DOMESTIC_LC(
      W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE           --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE     --부가세신고기간구분번호
    , W_SPEC_SERIAL         IN  FI_DOMESTIC_LC.SPEC_SERIAL%TYPE        --일련번호
    
    , P_VAT_DOMESTIC_LC_CD  IN  FI_DOMESTIC_LC.VAT_DOMESTIC_LC_CD%TYPE  --구분
    , P_DOC_NO              IN  FI_DOMESTIC_LC.DOC_NO%TYPE              --서류번호
    
    , P_LAST_UPDATED_BY     IN  FI_DOMESTIC_LC.LAST_UPDATED_BY%TYPE    --수정자
);




--grid에 조회된 자료 DELETE
PROCEDURE DELETE_DOMESTIC_LC(
      W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE           --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE     --부가세신고기간구분번호
    , W_SPEC_SERIAL         IN  FI_DOMESTIC_LC.SPEC_SERIAL%TYPE        --일련번호
);







--메세지 : 사업장, 과세년도, 신고기간구분, 작성일자, 거래기간은 필수입니다.(FCM_10368)
--         출력할 자료가 없습니다.(FCM_10439)
--전자세금계산서_발금세액공제신고서 출력용
PROCEDURE PRINT_DOMESTIC_LC(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  NUMBER  --회사아이디
    , W_ORG_ID          IN  NUMBER  --사업부아이디 
    , W_TAX_CODE        IN  VARCHAR2
    , W_CREATE_DATE     IN  DATE    --작성일자 
    , W_DEAL_DATE_FR    IN  DATE    --거래기간_시작
    , W_DEAL_DATE_TO    IN  DATE    --거래기간_종료    
);





END FI_DOMESTIC_LC_G;
/
CREATE OR REPLACE PACKAGE BODY FI_DOMESTIC_LC_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_DOMESTIC_LC_G(내국신용장 구매확인서 전자발급명세서)
Description  : 내국신용장 구매확인서 전자발급명세서 Package

Reference by : calling assmbly-program id(호출 프로그램) : 내국신용장 구매확인서 전자발급명세서
Program History :
    *.매입/매출장의 세무유형이 영세매출인 자료가 기준 자료이다.
    *.구분은 공통코드에 있는 값을 이용한다. VAT_DOMESTIC_LC[전자발급명세서(내국신용장)]
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2012-01-02   Leem Dong Ern(임동언)
*****************************************************************************/






--기초자료생성
--메시지 : 기초자료를 생성하시겠습니까? 기 생성된 자료가 있는 경우 기존 자료가 삭제되고 (재)생성됩니다.
--FCM_10368, 사업장, 과세년도, 신고기간구분, 작성일자, 거래기간은 필수입니다.
--FCM_10365, 해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
PROCEDURE CREATE_DOMESTIC_LC(
      W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE   --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_CREATED_BY          IN  FI_DOMESTIC_LC.CREATED_BY%TYPE          --생성자
    , W_DEAL_DATE_FR        IN  DATE    --거래기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --거래기간_종료  
    
    , O_MESSAGE             OUT VARCHAR2    
)

AS

REC_CLOSING_YN  EXCEPTION;

t_CLOSING_YN    FI_VAT_REPORT_MNG.CLOSING_YN%TYPE;  --마감여부
V_SYSDATE       DATE := GET_LOCAL_DATE(W_SOB_ID);

t_SPEC_SERIAL   FI_FOREIGN_CURRENCY_SPEC.SPEC_SERIAL%TYPE;  --일련번호

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

        RAISE REC_CLOSING_YN;
        
        --RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10365', NULL));
    END IF;



    --기존에 존재하는 자료가 있을 경우 모두 삭제한다.
    DELETE FI_DOMESTIC_LC
    WHERE   SOB_ID  = W_SOB_ID  --회사아이디
        AND ORG_ID  = W_ORG_ID  --사업부아이디
        AND TAX_CODE = W_TAX_CODE                   --사업장아이디
        AND VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL    --부가세신고기간구분번호
    ;    

    SELECT NVL(MAX(SPEC_SERIAL), 0) INTO t_SPEC_SERIAL FROM FI_DOMESTIC_LC;

    INSERT INTO FI_DOMESTIC_LC(
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디        
        , TAX_CODE       	--사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        
        , SPEC_SERIAL           --일련번호
        , VAT_DOMESTIC_LC_CD    --구분
        , DOC_NO                --서류번호
        , PUB_DATE              --발급일
        , VAT_NUMBER            --사업자등록번호
        , SUPPLY_AMT            --금액
      
        , CREATION_DATE     --생성일
        , CREATED_BY	    --생성자
        , LAST_UPDATE_DATE  --수정일
        , LAST_UPDATED_BY	--수정자          
    )
    --아래 SELECT 문은 매입/매출장의 매출부분울 복사하여 본 취지에 맞게 일부 변경한 것이다.
    SELECT                     
          W_SOB_ID  --회사아이디
        , W_ORG_ID  --사업부아이디
        , W_TAX_CODE                --사업장아이디
        , W_VAT_MNG_SERIAL          --부가세신고기간구분번호
        
        , t_SPEC_SERIAL + ROWNUM        --일련번호
        , '02' AS VAT_DOMESTIC_LC_CD    --구분(01 : 내국신용장, 02:구매확인서)
        , NULL AS DOC_NO                --서류번호
        , A.REFER1 AS VAT_ISSUE_DATE    --신고기준일자     
        , B.TAX_REG_NO AS TAX_REG_NO    --사업자등록번호

        --아래에서 TRIM, REPLACE를 쓴 이유는 과거 프로그램의 정합성 보장이 안되어 자료가 잘 못 입력된게 있어서이다.
        , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', '')) AS GL_AMOUNT     --공급가액 
        
        , V_SYSDATE     --생성일
        , W_CREATED_BY  --생성자
        , V_SYSDATE     --수정일
        , W_CREATED_BY  --수정자     
    FROM FI_SLIP_LINE A
        , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --거래처
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        AND A.REFER11 = W_TAX_CODE      --사업장    
        AND A.ACCOUNT_CODE = '2100700'  --거래구분(매출)
        AND MANAGEMENT2 = 2 --세무유형(2:영세매출)    
        --AND TO_DATE(A.REFER1) BETWEEN to_date('20110401') AND to_date('20110630')   --신고기준일자
        AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --신고기준일자
        AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)        
    ;
     
    
    --FCM_10112 : 해당 작업을 정상적으로 완료하였습니다.
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
    
        
    EXCEPTION 
        WHEN REC_CLOSING_YN THEN
    
            --FCM_10365, 해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
            O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10365', NULL);     

        WHEN OTHERS THEN
            ROLLBACK;
            
            O_MESSAGE := 'ERROR : ' || SQLCODE ||  ' => ' || SQLERRM;
            --DBMS_OUTPUT.PUT_LINE('------ 수행결과코드값에 따른 message : ' || SQLERRM);           

END CREATE_DOMESTIC_LC;









--상단조회
PROCEDURE LIST_UP_DOMESTIC_LC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE            --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          '(9) 합계 (10)+(11)'    AS GUBUN    --구분
        , DECODE(COUNT(*), 0, NULL, COUNT(*)) AS CNT   --건수
        , SUM(SUPPLY_AMT) AS TOTAL    --금액(원)
    FROM FI_DOMESTIC_LC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE               --사업장아이디
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --부가세신고기간구분번호

    UNION ALL

    SELECT
          '(10) 내 국 신 용 장'    AS GUBUN    --구분
        , DECODE(COUNT(*), 0, NULL, COUNT(*)) AS CNT   --건수
        , SUM(SUPPLY_AMT) AS TOTAL    --금액(원)
    FROM FI_DOMESTIC_LC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE               --사업장아이디
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --부가세신고기간구분번호
        AND VAT_DOMESTIC_LC_CD = '01'   --01 : 내국신용장

    UNION ALL

    SELECT
          '(11) 구 매 확 인 서'    AS GUBUN    --구분
        , DECODE(COUNT(*), 0, NULL, COUNT(*)) AS CNT   --건수
        , SUM(SUPPLY_AMT) AS TOTAL    --금액(원)
    FROM FI_DOMESTIC_LC
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE               --사업장아이디
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --부가세신고기간구분번호
        AND VAT_DOMESTIC_LC_CD = '02'   --02 : 구매확인서
    ; 

END LIST_UP_DOMESTIC_LC;








--하단조회
PROCEDURE LIST_DOWN_DOMESTIC_LC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE            --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
)

AS

BEGIN

    OPEN P_CURSOR FOR

    WITH T AS(
        SELECT
              SOB_ID	            --회사아이디
            , ORG_ID	            --사업부아이디
            , TAX_CODE	    --사업장아이디
            , VAT_MNG_SERIAL	    --부가세신고기간구분번호
            , SPEC_SERIAL	        --일련번호            
            , VAT_DOMESTIC_LC_CD    --구분코드
            , FI_COMMON_G.CODE_NAME_F('VAT_DOMESTIC_LC', VAT_DOMESTIC_LC_CD, SOB_ID, ORG_ID) AS VAT_DOMESTIC_LC_NM   --구분명            
            , DOC_NO	            --서류번호
            , PUB_DATE	            --발급일
            , VAT_NUMBER	        --사업자등록번호
            , SUPPLY_AMT	        --금액
        FROM FI_DOMESTIC_LC       
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND TAX_CODE = W_TAX_CODE               --사업장아이디
            AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL   --부가세신고기간구분번호
        ORDER BY VAT_DOMESTIC_LC_CD, PUB_DATE
    )
    SELECT
        ROWNUM AS SEQ
        , T.*
    FROM T
    ; 

END LIST_DOWN_DOMESTIC_LC;









--구분 POPUP
PROCEDURE POPUP_DOMESTIC_LC(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --사업부아이디
)

AS

BEGIN

    OPEN P_CURSOR FOR
    
    SELECT CODE, CODE_NAME
    FROM FI_COMMON
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID 
        AND GROUP_CODE = 'VAT_DOMESTIC_LC'
    ;    

END POPUP_DOMESTIC_LC;







--grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_DOMESTIC_LC(
      W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE           --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE     --부가세신고기간구분번호
    , W_SPEC_SERIAL         IN  FI_DOMESTIC_LC.SPEC_SERIAL%TYPE        --일련번호
    
    , P_VAT_DOMESTIC_LC_CD  IN  FI_DOMESTIC_LC.VAT_DOMESTIC_LC_CD%TYPE  --구분
    , P_DOC_NO              IN  FI_DOMESTIC_LC.DOC_NO%TYPE              --서류번호
    
    , P_LAST_UPDATED_BY     IN  FI_DOMESTIC_LC.LAST_UPDATED_BY%TYPE    --수정자
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);

BEGIN

    UPDATE FI_DOMESTIC_LC
    SET
          VAT_DOMESTIC_LC_CD    = P_VAT_DOMESTIC_LC_CD  --구분    
        , DOC_NO                = P_DOC_NO              --서류번호
        
        , LAST_UPDATE_DATE      = V_SYSDATE             --수정일
        , LAST_UPDATED_BY       = P_LAST_UPDATED_BY     --수정자
    WHERE   SOB_ID              = W_SOB_ID              --회사아이디
        AND ORG_ID              = W_ORG_ID              --사업부아이디
        AND TAX_CODE            = W_TAX_CODE            --사업장아이디        
        AND VAT_MNG_SERIAL      = W_VAT_MNG_SERIAL      --부가세신고기간구분번호
        AND SPEC_SERIAL         = W_SPEC_SERIAL         --일련번호
    ;

END UPDATE_DOMESTIC_LC;









--grid에 조회된 자료 DELETE
PROCEDURE DELETE_DOMESTIC_LC(
      W_SOB_ID              IN  FI_DOMESTIC_LC.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_DOMESTIC_LC.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_DOMESTIC_LC.TAX_CODE%TYPE           --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_DOMESTIC_LC.VAT_MNG_SERIAL%TYPE     --부가세신고기간구분번호
    , W_SPEC_SERIAL         IN  FI_DOMESTIC_LC.SPEC_SERIAL%TYPE        --일련번호
)

AS

BEGIN

    DELETE FI_DOMESTIC_LC
    WHERE   SOB_ID              = W_SOB_ID              --회사아이디
        AND ORG_ID              = W_ORG_ID              --사업부아이디
        AND TAX_CODE            = W_TAX_CODE            --사업장아이디        
        AND VAT_MNG_SERIAL      = W_VAT_MNG_SERIAL      --부가세신고기간구분번호
        AND SPEC_SERIAL         = W_SPEC_SERIAL         --일련번호
    ;

END DELETE_DOMESTIC_LC;







--메세지 : 사업장, 과세년도, 신고기간구분, 작성일자, 거래기간은 필수입니다.(FCM_10368)
--         출력할 자료가 없습니다.(FCM_10439)
--전자세금계산서_발금세액공제신고서 출력용
PROCEDURE PRINT_DOMESTIC_LC(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  NUMBER  --회사아이디
    , W_ORG_ID          IN  NUMBER  --사업부아이디 
    , W_TAX_CODE        IN  VARCHAR2
    , W_CREATE_DATE     IN  DATE    --작성일자 
    , W_DEAL_DATE_FR    IN  DATE    --거래기간_시작
    , W_DEAL_DATE_TO    IN  DATE    --거래기간_종료    
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          B.VAT_NUMBER  --사업자등록번호
        , A.CORP_NAME   --상호(법인명)
        , A.LEGAL_NUMBER                        --주민(법인)등록번호
        , A.PRESIDENT_NAME AS PRESIDENT_NAME   --성명(대표자)
        , B.ADDR1 || ' ' || B.ADDR2 AS LOCATION     --사업장소재지
        , A.TEL_NUMBER                              --전화번호
        , B.BUSINESS_ITEM || '(' || BUSINESS_TYPE || ')' AS BUSINESS    --업태(종목)                
        , B.BUSINESS_ITEM AS BUSINESS_ITEM    --업태
        , B.BUSINESS_TYPE AS BUSINESS_TYPE    --종목
        , B.TAX_OFFICE_NAME || ' 세무서장' AS TAX_OFFICE_NAME --관할세무서
        , TO_CHAR(W_CREATE_DATE, 'YYYY') || '년 ' 
          || TO_NUMBER(TO_CHAR(W_CREATE_DATE, 'MM')) || '월 ' 
          || TO_NUMBER(TO_CHAR(W_CREATE_DATE, 'DD')) || '일'  AS CREATE_DATE   --작성일자 
        , TO_CHAR(TO_DATE('20110630'), 'YYYY')  || ' 년  '
          || TO_NUMBER(TO_CHAR(TO_DATE('20110401'), 'MM')) || '월  ' || TO_NUMBER(TO_CHAR(TO_DATE('20110401'), 'DD'))  || '일  ~  '
          || TO_NUMBER(TO_CHAR(TO_DATE('20110630'), 'MM')) || '월  ' || TO_NUMBER(TO_CHAR(TO_DATE('20110630'), 'DD')) || '일 ' AS DEAL_TERM    --거레기간
        , '(   ' || TO_CHAR(W_DEAL_DATE_TO, 'YYYY') || '  년   제 ' ||  
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
        
END PRINT_DOMESTIC_LC;






END FI_DOMESTIC_LC_G;
/
