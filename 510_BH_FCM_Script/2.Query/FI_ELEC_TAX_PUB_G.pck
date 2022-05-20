CREATE OR REPLACE PACKAGE FI_ELEC_TAX_PUB_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_ELEC_TAX_PUB_G(전자세금계산서_발금세액공제신고서)
Description  : 전자세금계산서_발금세액공제신고서 Package

Reference by : calling assmbly-program id(호출 프로그램) : 전자세금계산서_발금세액공제신고서
Program History :
    -. 이 양식은 매출처별세금계산서합계표 양식 자료를 맞춘 후 작업해야 한다. 
       사유 : 매출처별세금계산서합계표 양식의 구분이 [전자]인 행의 [사업자등록번호 발급받은 분] 열의 [매수] 항목의 값이
              이 양식의 (8)전자세금계산서 발급건수의 기본값으로 설정되기 때문이다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2012-01-02   Leem Dong Ern(임동언)
*****************************************************************************/





--기초자료생성
--메시지 : 기초자료를 생성하시겠습니까? 기 생성된 자료가 있는 경우 기존 자료가 삭제되고 (재)생성됩니다.
--FCM_10365, 해당 신고기간의 자료는 마감되어 변경할 수 없습니다.
PROCEDURE CREATE_ELEC_TAX_PUB(
      W_SOB_ID              IN  FI_ELEC_TAX_PUB.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_ELEC_TAX_PUB.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_ELEC_TAX_PUB.TAX_CODE%TYPE            --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_ELEC_TAX_PUB.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_CREATED_BY          IN  FI_ELEC_TAX_PUB.CREATED_BY%TYPE          --생성자
    
    --신고기간은 화면에는 안 보인다. 신고기간구분을 선택하면 내부적으로 설정된 값을 이용할 뿐이다.
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료    
    
    , O_MESSAGE             OUT VARCHAR2    
);





--조회
PROCEDURE LIST_ELEC_TAX_PUB(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ELEC_TAX_PUB.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_ELEC_TAX_PUB.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_ELEC_TAX_PUB.TAX_CODE%TYPE            --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_ELEC_TAX_PUB.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
);










--grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_ELEC_TAX_PUB(
      W_SOB_ID              IN  FI_ELEC_TAX_PUB.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_ELEC_TAX_PUB.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_ELEC_TAX_PUB.TAX_CODE%TYPE           --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_ELEC_TAX_PUB.VAT_MNG_SERIAL%TYPE     --부가세신고기간구분번호
    
    , P_DEDUCT_TAX          IN  FI_ELEC_TAX_PUB.DEDUCT_TAX%TYPE         --기_공제세액
    
    , P_LAST_UPDATED_BY     IN  FI_ELEC_TAX_PUB.LAST_UPDATED_BY%TYPE    --수정자
);







--메세지 : 사업장, 과세년도, 신고기간구분, 작성일자는 필수입니다.(FCM_10438)
--         출력할 자료가 없습니다.(FCM_10439)
--전자세금계산서_발금세액공제신고서 출력용
PROCEDURE PRINT_ELEC_TAX_PUB(
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  NUMBER  --회사아이디
    , W_ORG_ID      IN  NUMBER  --사업부아이디 
    , W_TAX_CODE    IN  VARCHAR2
    , W_CREATE_DATE IN  DATE    --작성일자
    --, W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    --, W_DEAL_DATE_TO        IN  DATE    --신고기간_종료    
);





END FI_ELEC_TAX_PUB_G;
/
CREATE OR REPLACE PACKAGE BODY FI_ELEC_TAX_PUB_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_ELEC_TAX_PUB_G(전자세금계산서_발금세액공제신고서)
Description  : 전자세금계산서_발금세액공제신고서 Package

Reference by : calling assmbly-program id(호출 프로그램) : 전자세금계산서_발금세액공제신고서
Program History :
    -. 이 양식은 매출처별세금계산서합계표 양식 자료를 맞춘 후 작업해야 한다. 
       사유 : 매출처별세금계산서합계표 양식의 구분이 [전자]인 행의 [사업자등록번호 발급받은 분] 열의 [매수] 항목의 값이
              이 양식의 (8)전자세금계산서 발급건수의 기본값으로 설정되기 때문이다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2012-01-02   Leem Dong Ern(임동언)
*****************************************************************************/






--기초자료생성
PROCEDURE CREATE_ELEC_TAX_PUB(
      W_SOB_ID              IN  FI_ELEC_TAX_PUB.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_ELEC_TAX_PUB.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_ELEC_TAX_PUB.TAX_CODE%TYPE            --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_ELEC_TAX_PUB.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
    , W_CREATED_BY          IN  FI_ELEC_TAX_PUB.CREATED_BY%TYPE          --생성자
    
    --신고기간은 화면에는 안 보인다. 신고기간구분을 선택하면 내부적으로 설정된 값을 이용할 뿐이다.
    , W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    , W_DEAL_DATE_TO        IN  DATE    --신고기간_종료    
    
    , O_MESSAGE             OUT VARCHAR2    
)

AS

REC_CLOSING_YN  EXCEPTION;

t_CLOSING_YN    FI_VAT_REPORT_MNG.CLOSING_YN%TYPE;  --마감여부
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
        RAISE REC_CLOSING_YN;
        --RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10365', NULL));
    END IF;



    --기존에 존재하는 자료가 있을 경우 모두 삭제한다.
    DELETE FI_ELEC_TAX_PUB
    WHERE   SOB_ID  = W_SOB_ID  --회사아이디
        AND ORG_ID  = W_ORG_ID  --사업부아이디
        AND TAX_CODE = W_TAX_CODE                   --사업장아이디
        AND VAT_MNG_SERIAL    = W_VAT_MNG_SERIAL    --부가세신고기간구분번호
    ;    


    INSERT INTO FI_ELEC_TAX_PUB(
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디        
        , TAX_CODE	      --사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        
        , ELEC_TAX_PUB_CNT  --전자세금계산서_발급건수
      
        , CREATION_DATE     --생성일
        , CREATED_BY	    --생성자
        , LAST_UPDATE_DATE  --수정일
        , LAST_UPDATED_BY	--수정자          
    )
    --아래 SELECT 문은 [FI_SUM_VAT_TAX_G.UP_SUM_VAT_TAX > ELSIF W_AP_AR_GB = '2' THEN   --매출]의 PACKAGE의 것을 
    --복사하여 본 취지에 맞게 일부 변경한 것이다.
    SELECT
          W_SOB_ID  --회사아이디
        , W_ORG_ID  --사업부아이디
        , W_TAX_CODE                --사업장아이디
        , W_VAT_MNG_SERIAL          --부가세신고기간구분번호
        
        , NVL(SUM(CNT), 0) AS ELEC_TAX_PUB_CNT  --전자세금계산서_발급건수 
        
        , V_SYSDATE     --생성일
        , W_CREATED_BY  --생성자
        , V_SYSDATE     --수정일
        , W_CREATED_BY  --수정자         
    FROM
        (
            SELECT             
                  A.MANAGEMENT1 AS SUPPLIER_CODE    --거래처코드
                , COUNT(*) AS CNT --매수
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

END CREATE_ELEC_TAX_PUB;






--조회
PROCEDURE LIST_ELEC_TAX_PUB(
      P_CURSOR                  OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ELEC_TAX_PUB.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_ELEC_TAX_PUB.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_ELEC_TAX_PUB.TAX_CODE%TYPE            --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_ELEC_TAX_PUB.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디
        , TAX_CODE      	--사업장아이디
        , VAT_MNG_SERIAL	--부가세신고기간구분번호
        
        --가.공제대상세액
        , ELEC_TAX_PUB_CNT  --전자세금계산서_발급건수
        , '200원' AS DED_AMT_PER  --건당 공제금액
        , ELEC_TAX_PUB_CNT * 200 AS DED_ALLOW_TAX   --공제 가능세액
        , CASE 
            WHEN ELEC_TAX_PUB_CNT * 200 < 1000000 - NVL(DEDUCT_TAX, 0) THEN ELEC_TAX_PUB_CNT * 200
            ELSE 1000000 - NVL(DEDUCT_TAX, 0)
          END AS MIN_AMT    --해당 공제세액
          
        --나.공제 한도액 계산
        , '100만원' AS YEAR_LIMIT   --연간 공제한도액
        , DEDUCT_TAX    --기_공제세액
        , 1000000 - NVL(DEDUCT_TAX, 0) AS PERIOD_LIMIT_AMT   --해당 과세기간 공제한도액
        
    FROM FI_ELEC_TAX_PUB
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND VAT_MNG_SERIAL = W_VAT_MNG_SERIAL
    ; 


END LIST_ELEC_TAX_PUB;








--grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_ELEC_TAX_PUB(
      W_SOB_ID              IN  FI_ELEC_TAX_PUB.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_ELEC_TAX_PUB.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_ELEC_TAX_PUB.TAX_CODE%TYPE           --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_ELEC_TAX_PUB.VAT_MNG_SERIAL%TYPE     --부가세신고기간구분번호
    
    , P_DEDUCT_TAX          IN  FI_ELEC_TAX_PUB.DEDUCT_TAX%TYPE         --기_공제세액
    
    , P_LAST_UPDATED_BY     IN  FI_ELEC_TAX_PUB.LAST_UPDATED_BY%TYPE    --수정자
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);

BEGIN

    UPDATE FI_ELEC_TAX_PUB
    SET
          DEDUCT_TAX   = P_DEDUCT_TAX     --기_공제세액    
                  
        , LAST_UPDATE_DATE  = V_SYSDATE         --수정일
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY --수정자
    WHERE   SOB_ID                  = W_SOB_ID                  --회사아이디
        AND ORG_ID                  = W_ORG_ID                  --사업부아이디
        AND TAX_CODE                = W_TAX_CODE                --사업장아이디        
        AND VAT_MNG_SERIAL          = W_VAT_MNG_SERIAL          --부가세신고기간구분번호               
    ;

END UPDATE_ELEC_TAX_PUB;







--메세지 : 사업장, 과세년도, 신고기간구분, 작성일자는 필수입니다.(FCM_10438)
--         출력할 자료가 없습니다.(FCM_10439)
--전자세금계산서_발금세액공제신고서 출력용
PROCEDURE PRINT_ELEC_TAX_PUB(
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  NUMBER  --회사아이디
    , W_ORG_ID      IN  NUMBER  --사업부아이디 
    , W_TAX_CODE    IN  VARCHAR2
    , W_CREATE_DATE IN  DATE    --작성일자
    --, W_DEAL_DATE_FR        IN  DATE    --신고기간_시작
    --, W_DEAL_DATE_TO        IN  DATE    --신고기간_종료    
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
          || TO_NUMBER(TO_CHAR(W_CREATE_DATE, 'DD')) || '일 '  AS CREATE_DATE   --작성일자 
        --, TO_CHAR(TO_DATE('20110630'), 'YYYY')  || ' 년  '
        --  || TO_NUMBER(TO_CHAR(TO_DATE('20110401'), 'MM')) || '월  ' || TO_NUMBER(TO_CHAR(TO_DATE('20110401'), 'DD'))  || '일  ~  '
        --  || TO_NUMBER(TO_CHAR(TO_DATE('20110630'), 'MM')) || '월  ' || TO_NUMBER(TO_CHAR(TO_DATE('20110630'), 'DD')) || '일 ' AS DEAL_TERM    --거레기간          
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

END PRINT_ELEC_TAX_PUB;






END FI_ELEC_TAX_PUB_G;
/
