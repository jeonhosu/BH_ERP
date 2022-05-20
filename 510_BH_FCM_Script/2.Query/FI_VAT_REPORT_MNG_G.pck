CREATE OR REPLACE PACKAGE FI_VAT_REPORT_MNG_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_VAT_REPORT_MNG_G
Description  : 부가가치세마감관리 Package

Reference by : calling assmbly-program id(호출 프로그램) : FCMF0871(부가세마감관리)
Program History :
    -.부가가치세 신고기간 및 부동산임대공급가액명세서의 간주임대료이자율, 마감여부등의 자료를 관리한다.
    -.해당 신고기간이 마감되면 부가가세관리의 모든 메뉴에서 자료의 수정이 불가하다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-15   Leem Dong Ern(임동언)
*****************************************************************************/






--기본 사업장 설정; 부가가치세관리의 모든 메뉴에서 공통으로 사용한다.
PROCEDURE SET_TAX_CODE(
      W_SOB_ID              IN  NUMBER                --회사아이디
    , W_ORG_ID              IN  NUMBER                --사업부아이디
    , O_TAX_CODE            OUT VARCHAR2              --(사업장)아이디 
    , O_TAX_DESC            OUT VARCHAR2              --사업장명; 법인명 
    );






--사업장 팝업 ; 부가가치세관리의 모든 메뉴에서 공통으로 사용한다.
PROCEDURE POP_TAX_CODE(
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_VAT_REPORT_MNG.SOB_ID%TYPE   --회사아이디
    , W_ORG_ID  IN  FI_VAT_REPORT_MNG.ORG_ID%TYPE   --사업부아이디
);









--부가가치세관리의 대부분 메뉴에서 사용하는 신고기간구분 팝업 자료
PROCEDURE POP_VAT_REPORT_MNG(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_VAT_REPORT_MNG.SOB_ID%TYPE               --회사아이디
    , W_ORG_ID              IN  FI_VAT_REPORT_MNG.ORG_ID%TYPE               --사업부아이디
    , W_TAX_CODE            IN  FI_VAT_REPORT_MNG.TAX_CODE%TYPE             --사업장아이디
    , W_FY                  IN  FI_VAT_REPORT_MNG.FY%TYPE                   --회기년도
);










--grid에 조회되는 자료 추출
PROCEDURE LIST_VAT_REPORT_MNG(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_VAT_REPORT_MNG.SOB_ID%TYPE            --회사아이디
    , W_ORG_ID              IN  FI_VAT_REPORT_MNG.ORG_ID%TYPE            --사업부아이디
    , W_TAX_CODE            IN  FI_VAT_REPORT_MNG.TAX_CODE%TYPE          --사업장코드(예>110)
    , W_FY                  IN  FI_VAT_REPORT_MNG.FY%TYPE                --회기년도
);





--grid에 신규 항목 추가
PROCEDURE INSERT_VAT_REPORT_MNG(
      P_SOB_ID	            IN 	FI_VAT_REPORT_MNG.SOB_ID%TYPE	            --회사아이디
    , P_ORG_ID	            IN 	FI_VAT_REPORT_MNG.ORG_ID%TYPE	            --사업부아이디
    , P_TAX_CODE            IN 	FI_VAT_REPORT_MNG.TAX_CODE%TYPE           --사업장코드.
    , P_FY	                IN 	FI_VAT_REPORT_MNG.FY%TYPE	                --회기년도        
    , P_VAT_REPORT_TURN	    IN	FI_VAT_REPORT_MNG.VAT_REPORT_TURN%TYPE	    --신고기수코드        
    , P_VAT_REPORT_GB	      IN	FI_VAT_REPORT_MNG.VAT_REPORT_GB%TYPE	    --신고구분코드        
    , P_TAX_TERM_FR         IN	FI_VAT_REPORT_MNG.TAX_TERM_FR%TYPE	        --과세기간_시작        
    , P_TAX_TERM_TO	        IN	FI_VAT_REPORT_MNG.TAX_TERM_TO%TYPE	        --과세기간_종료        
    , P_VAT_REPORT_NM	      IN	FI_VAT_REPORT_MNG.VAT_REPORT_NM%TYPE        --부가세신고기간구분명     
    , P_REGARD_RATE	        IN	FI_VAT_REPORT_MNG.REGARD_RATE%TYPE	        --간주임대료적용이자율        
    , P_CLOSING_YN	        IN	FI_VAT_REPORT_MNG.CLOSING_YN%TYPE	        --마감여부
    , P_CREATED_BY	        IN	FI_VAT_REPORT_MNG.CREATED_BY%TYPE	        --생성자
);





--grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_VAT_REPORT_MNG(
      P_SOB_ID	            IN 	FI_VAT_REPORT_MNG.SOB_ID%TYPE	            --회사아이디
    , P_ORG_ID	            IN 	FI_VAT_REPORT_MNG.ORG_ID%TYPE	            --사업부아이디
    , P_TAX_CODE            IN 	FI_VAT_REPORT_MNG.TAX_CODE%TYPE           --사업장코드.
    , P_VAT_MNG_SERIAL      IN 	FI_VAT_REPORT_MNG.VAT_MNG_SERIAL%TYPE       --부가세신고기간구분번호
    , P_FY	                IN 	FI_VAT_REPORT_MNG.FY%TYPE	                --회기년도        
    , P_VAT_REPORT_TURN	    IN	FI_VAT_REPORT_MNG.VAT_REPORT_TURN%TYPE	    --신고기수코드        
    , P_VAT_REPORT_GB	      IN	FI_VAT_REPORT_MNG.VAT_REPORT_GB%TYPE	    --신고구분코드        
    , P_TAX_TERM_FR         IN	FI_VAT_REPORT_MNG.TAX_TERM_FR%TYPE	        --과세기간_시작        
    , P_TAX_TERM_TO	        IN	FI_VAT_REPORT_MNG.TAX_TERM_TO%TYPE	        --과세기간_종료        
    , P_VAT_REPORT_NM	      IN	FI_VAT_REPORT_MNG.VAT_REPORT_NM%TYPE        --부가세신고기간구분명     
    , P_REGARD_RATE	        IN	FI_VAT_REPORT_MNG.REGARD_RATE%TYPE	        --간주임대료적용이자율        
    , P_CLOSING_YN	        IN	FI_VAT_REPORT_MNG.CLOSING_YN%TYPE	        --마감여부
    , P_LAST_UPDATED_BY     IN  FI_VAT_REPORT_MNG.LAST_UPDATED_BY%TYPE       --수정자
);






--grid에 조회된 자료 삭제
PROCEDURE DELETE_VAT_REPORT_MNG(
      P_SOB_ID	            IN 	FI_VAT_REPORT_MNG.SOB_ID%TYPE	            --회사아이디
    , P_ORG_ID	            IN 	FI_VAT_REPORT_MNG.ORG_ID%TYPE	            --사업부아이디
    , P_TAX_CODE            IN 	FI_VAT_REPORT_MNG.TAX_CODE%TYPE           --사업장코드.    
    , P_VAT_MNG_SERIAL      IN 	FI_VAT_REPORT_MNG.VAT_MNG_SERIAL%TYPE       --부가세신고기간구분번호
);







--신고기간구분 명 반환
FUNCTION VAT_MNG_SERIAL_F(
      P_VAT_MNG_SERIAL  IN FI_VAT_REPORT_MNG.VAT_MNG_SERIAL%TYPE    --부가세신고기간구분번호  
) RETURN VARCHAR2;



--신고기간 마감여부 반환 
FUNCTION VAT_CLOSED_FLAG(
      W_SOB_ID              IN  FI_VAT_REPORT_MNG.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_VAT_REPORT_MNG.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_VAT_REPORT_MNG.TAX_CODE%TYPE            --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_VAT_REPORT_MNG.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호     
) RETURN VARCHAR2;


END FI_VAT_REPORT_MNG_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_REPORT_MNG_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_VAT_REPORT_MNG_G
Description  : 부가가치세마감관리 Package

Reference by : calling assmbly-program id(호출 프로그램) : FCMF0871(부가세마감관리)
Program History :
    -.부가가치세 신고기간 및 부동산임대공급가액명세서의 간주임대료이자율, 마감여부등의 자료를 관리한다.
    -.해당 신고기간이 마감되면 부가가세관리의 모든 메뉴에서 자료의 수정이 불가하다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-15   Leem Dong Ern(임동언)
*****************************************************************************/


--기본 사업장 설정; 부가가치세관리의 모든 메뉴에서 공통으로 사용한다.
PROCEDURE SET_TAX_CODE(
      W_SOB_ID              IN  NUMBER                --회사아이디
    , W_ORG_ID              IN  NUMBER                --사업부아이디
    , O_TAX_CODE            OUT VARCHAR2              --(사업장)아이디
    , O_TAX_DESC            OUT VARCHAR2              --사업장명; 법인명 
)

AS
  V_ID                  NUMBER;
BEGIN
    BEGIN
      FI_COMMON_G.DEFAULT_VALUE_GROUP('TAX_CODE', W_SOB_ID, W_ORG_ID, V_ID, O_TAX_CODE, O_TAX_DESC);
      /*
      SELECT
              FC.CODE AS TAX_CODE   --(사업장)아이디
            , FC.CODE_NAME AS TAX_NAME --(실)사업장명
        INTO O_TAX_CODE
           , O_TAX_DESC
        FROM FI_COMMON FC
        WHERE FC.SOB_ID = W_SOB_ID
            AND FC.ORG_ID = W_ORG_ID
            AND FC.GROUP_CODE = 'TAX_CODE'
            AND 
            AND FC.ENABLED_FLAG   = 'Y'
            AND FC.EFFECTIVE_DATE_FR  <= V_SYSDATE
            AND (FC.EFFECTIVE_DATE_TO >= V_SYSDATE OR FC.EFFECTIVE_DATE_TO IS NULL)=
        ;*/
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
END SET_TAX_CODE;


--사업장 팝업 ; 부가가치세관리의 모든 메뉴에서 공통으로 사용한다.
PROCEDURE POP_TAX_CODE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_VAT_REPORT_MNG.SOB_ID%TYPE   --회사아이디
    , W_ORG_ID  IN  FI_VAT_REPORT_MNG.ORG_ID%TYPE   --사업부아이디
)
AS
  V_SYSDATE             DATE := GET_LOCAL_DATE(W_SOB_ID);
BEGIN

    OPEN P_CURSOR FOR
    SELECT
          FC.CODE AS TAX_CODE   --(사업장)아이디 
        , FC.CODE_NAME AS TAX_DESC --(실)사업장명 
    FROM FI_COMMON FC
    WHERE FC.SOB_ID = W_SOB_ID
        AND FC.ORG_ID = W_ORG_ID
        AND FC.GROUP_CODE = 'TAX_CODE'
        AND FC.ENABLED_FLAG   = 'Y'
        AND FC.EFFECTIVE_DATE_FR  <= V_SYSDATE
        AND (FC.EFFECTIVE_DATE_TO >= V_SYSDATE OR FC.EFFECTIVE_DATE_TO IS NULL)
    ;
END POP_TAX_CODE;



--부가가치세관리의 대부분 메뉴에서 사용하는 신고기간구분 팝업 자료
PROCEDURE POP_VAT_REPORT_MNG(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_VAT_REPORT_MNG.SOB_ID%TYPE               --회사아이디
    , W_ORG_ID              IN  FI_VAT_REPORT_MNG.ORG_ID%TYPE               --사업부아이디
    , W_TAX_CODE            IN  FI_VAT_REPORT_MNG.TAX_CODE%TYPE             --사업장아이디
    , W_FY                  IN  FI_VAT_REPORT_MNG.FY%TYPE                   --회기년도
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          FY                --회기년도
        , VAT_MNG_SERIAL    --부가세신고기간구분번호
        , VAT_REPORT_NM     --부가세신고기간구분명
        , TAX_TERM_FR       --과세기간_시작
        , TAX_TERM_TO       --과세기간_종료
        , TO_CHAR(TAX_TERM_FR, 'YYYY.MM.DD') || ' ~ ' || TO_CHAR(TAX_TERM_TO, 'YYYY.MM.DD') AS TAX_TERM      --과세기간
        , NVL(REGARD_RATE, 0) AS REGARD_RATE   --간주임대료적용이자율
        , CLOSING_YN        --마감여부
        , TO_CHAR(TAX_TERM_FR, 'YYYY-MM') AS START_MM   --과세기간_시작월
        , TO_CHAR(TAX_TERM_TO, 'YYYY-MM') AS END_MM   --과세기간_종료월
    FROM FI_VAT_REPORT_MNG
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND TAX_CODE = W_TAX_CODE
        AND FY = W_FY
    ORDER BY VAT_REPORT_NM  ;        


END POP_VAT_REPORT_MNG;



--grid에 조회되는 자료 추출
PROCEDURE LIST_VAT_REPORT_MNG(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_VAT_REPORT_MNG.SOB_ID%TYPE            --회사아이디
    , W_ORG_ID              IN  FI_VAT_REPORT_MNG.ORG_ID%TYPE            --사업부아이디
    , W_TAX_CODE            IN  FI_VAT_REPORT_MNG.TAX_CODE%TYPE          --사업장코드(예>110)
    , W_FY                  IN  FI_VAT_REPORT_MNG.FY%TYPE                --회기년도
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID            --회사아이디
        , ORG_ID            --사업부아이디
        , TAX_CODE          --사업장아이디
        , VAT_MNG_SERIAL    --부가세신고기간구분번호
        , FY                --회기년도
        , VAT_REPORT_TURN   --신고기수코드        
        , FI_COMMON_G.CODE_NAME_F('VAT_REPORT_TURN', VAT_REPORT_TURN, SOB_ID, ORG_ID) AS VAT_REPORT_TURN_NM --신고기수
        , VAT_REPORT_GB     --신고구분코드
        , FI_COMMON_G.CODE_NAME_F('VAT_REPORT_GB', VAT_REPORT_GB, SOB_ID, ORG_ID) AS VAT_REPORT_GB_NM   --신고구분                
        , TAX_TERM_FR       --과세기간_시작
        , TAX_TERM_TO       --과세기간_종료
        , VAT_REPORT_NM     --부가세신고기간구분명
        , REGARD_RATE       --간주임대료적용이자율
        , CLOSING_YN        --마감여부
    FROM FI_VAT_REPORT_MNG
    WHERE SOB_ID = W_SOB_ID
      AND ORG_ID = W_ORG_ID
      AND TAX_CODE = W_TAX_CODE
      AND FY = NVL(W_FY, FY)
    ORDER BY FY DESC, VAT_REPORT_TURN, VAT_REPORT_GB ;   

END LIST_VAT_REPORT_MNG;


--grid에 신규 항목 추가
PROCEDURE INSERT_VAT_REPORT_MNG(
      P_SOB_ID	            IN 	FI_VAT_REPORT_MNG.SOB_ID%TYPE	            --회사아이디
    , P_ORG_ID	            IN 	FI_VAT_REPORT_MNG.ORG_ID%TYPE	            --사업부아이디
    , P_TAX_CODE            IN 	FI_VAT_REPORT_MNG.TAX_CODE%TYPE           --사업장코드.
    , P_FY	                IN 	FI_VAT_REPORT_MNG.FY%TYPE	                --회기년도        
    , P_VAT_REPORT_TURN	    IN	FI_VAT_REPORT_MNG.VAT_REPORT_TURN%TYPE	    --신고기수코드        
    , P_VAT_REPORT_GB	      IN	FI_VAT_REPORT_MNG.VAT_REPORT_GB%TYPE	    --신고구분코드        
    , P_TAX_TERM_FR         IN	FI_VAT_REPORT_MNG.TAX_TERM_FR%TYPE	        --과세기간_시작        
    , P_TAX_TERM_TO	        IN	FI_VAT_REPORT_MNG.TAX_TERM_TO%TYPE	        --과세기간_종료        
    , P_VAT_REPORT_NM	      IN	FI_VAT_REPORT_MNG.VAT_REPORT_NM%TYPE        --부가세신고기간구분명     
    , P_REGARD_RATE	        IN	FI_VAT_REPORT_MNG.REGARD_RATE%TYPE	        --간주임대료적용이자율        
    , P_CLOSING_YN	        IN	FI_VAT_REPORT_MNG.CLOSING_YN%TYPE	        --마감여부
    , P_CREATED_BY	        IN	FI_VAT_REPORT_MNG.CREATED_BY%TYPE	        --생성자
)

AS

V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
t_VAT_MNG_SERIAL    FI_VAT_REPORT_MNG.VAT_MNG_SERIAL%TYPE;

BEGIN

    SELECT NVL(MAX(VAT_MNG_SERIAL), 0) + 1 INTO t_VAT_MNG_SERIAL FROM FI_VAT_REPORT_MNG;   --일련번호

    INSERT INTO FI_VAT_REPORT_MNG(
          SOB_ID	            --회사아이디
        , ORG_ID	            --사업부아이디
        , TAX_CODE            --사업장코드   
        , VAT_MNG_SERIAL	    --부가세신고기간구분번호        
        , FY	                --회기년도        
        , VAT_REPORT_TURN	    --신고기수코드        
        , VAT_REPORT_GB	        --신고구분코드        
        , TAX_TERM_FR           --과세기간_시작        
        , TAX_TERM_TO	        --과세기간_종료        
        , VAT_REPORT_NM	        --부가세신고기간구분명     
        , REGARD_RATE	        --간주임대료적용이자율        
        , CLOSING_YN	        --마감여부
        , CREATION_DATE         --생성일
        , CREATED_BY	        --생성자
        , LAST_UPDATE_DATE      --수정일
        , LAST_UPDATED_BY	    --수정자
    )
    VALUES(
          P_SOB_ID	            --회사아이디
        , P_ORG_ID	            --사업부아이디
        , P_TAX_CODE            --사업장코드      
        , t_VAT_MNG_SERIAL	    --부가세신고기간구분번호        
        , P_FY	                --회기년도        
        , P_VAT_REPORT_TURN	    --신고기수코드        
        , P_VAT_REPORT_GB	    --신고구분코드        
        , P_TAX_TERM_FR         --과세기간_시작        
        , P_TAX_TERM_TO	        --과세기간_종료        
        , P_VAT_REPORT_NM	    --부가세신고기간구분명     
        , P_REGARD_RATE	        --간주임대료적용이자율        
        , P_CLOSING_YN	        --마감여부
        , V_SYSDATE             --생성일
        , P_CREATED_BY	        --생성자
        , V_SYSDATE             --수정일
        , P_CREATED_BY	        --수정자
    );
    
    -- 마감처리시 부가세 신고서의 마감여부 FLAG UPDATE -- 
    IF P_CLOSING_YN = 'Y' THEN
      BEGIN
        UPDATE FI_SURTAX_CARD SC
           SET SC.CLOSED_FLAG = 'Y'
         WHERE SOB_ID  = P_SOB_ID  --회사아이디
           AND ORG_ID  = P_ORG_ID  --사업부아이디
           AND TAX_CODE   = P_TAX_CODE   --사업장아이디
           AND VAT_MNG_SERIAL   = t_VAT_MNG_SERIAL      --부가세신고기간구분번호
        ;
     EXCEPTION WHEN OTHERS THEN
       NULL;
     END;
   END IF;
END INSERT_VAT_REPORT_MNG;


--grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_VAT_REPORT_MNG(
      P_SOB_ID	            IN 	FI_VAT_REPORT_MNG.SOB_ID%TYPE	            --회사아이디
    , P_ORG_ID	            IN 	FI_VAT_REPORT_MNG.ORG_ID%TYPE	            --사업부아이디
    , P_TAX_CODE            IN 	FI_VAT_REPORT_MNG.TAX_CODE%TYPE           --사업장코드.
    , P_VAT_MNG_SERIAL      IN 	FI_VAT_REPORT_MNG.VAT_MNG_SERIAL%TYPE       --부가세신고기간구분번호
    , P_FY	                IN 	FI_VAT_REPORT_MNG.FY%TYPE	                --회기년도        
    , P_VAT_REPORT_TURN	    IN	FI_VAT_REPORT_MNG.VAT_REPORT_TURN%TYPE	    --신고기수코드        
    , P_VAT_REPORT_GB	      IN	FI_VAT_REPORT_MNG.VAT_REPORT_GB%TYPE	    --신고구분코드        
    , P_TAX_TERM_FR         IN	FI_VAT_REPORT_MNG.TAX_TERM_FR%TYPE	        --과세기간_시작        
    , P_TAX_TERM_TO	        IN	FI_VAT_REPORT_MNG.TAX_TERM_TO%TYPE	        --과세기간_종료        
    , P_VAT_REPORT_NM	      IN	FI_VAT_REPORT_MNG.VAT_REPORT_NM%TYPE        --부가세신고기간구분명     
    , P_REGARD_RATE	        IN	FI_VAT_REPORT_MNG.REGARD_RATE%TYPE	        --간주임대료적용이자율        
    , P_CLOSING_YN	        IN	FI_VAT_REPORT_MNG.CLOSING_YN%TYPE	        --마감여부
    , P_LAST_UPDATED_BY     IN  FI_VAT_REPORT_MNG.LAST_UPDATED_BY%TYPE       --수정자
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);

BEGIN

    UPDATE FI_VAT_REPORT_MNG
    SET
          FY	              = P_FY	            --회기년도    
        , VAT_REPORT_TURN   = P_VAT_REPORT_TURN --신고기수코드    
        , VAT_REPORT_GB	    = P_VAT_REPORT_GB	--신고구분코드    
        , TAX_TERM_FR	      = P_TAX_TERM_FR	    --과세기간_시작    
        , TAX_TERM_TO       = P_TAX_TERM_TO	    --과세기간_종료    
        , VAT_REPORT_NM	    = P_VAT_REPORT_NM	--부가세신고기간구분명    
        , REGARD_RATE       = P_REGARD_RATE     --간주임대료적용이자율    
        , CLOSING_YN	      = P_CLOSING_YN	    --마감여부           
        , LAST_UPDATE_DATE  = V_SYSDATE         --수정일
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY --수정자
    WHERE   SOB_ID              = P_SOB_ID              --회사아이디
        AND ORG_ID              = P_ORG_ID              --사업부아이디
        AND TAX_CODE            = P_TAX_CODE            --사업장코드 
        AND VAT_MNG_SERIAL      = P_VAT_MNG_SERIAL      --부가세신고기간구분번호
    ;
   
    -- 마감처리시 부가세 신고서의 마감여부 FLAG UPDATE -- 
    IF P_CLOSING_YN = 'Y' THEN
      BEGIN
        UPDATE FI_SURTAX_CARD SC
           SET SC.CLOSED_FLAG = 'Y'
         WHERE SOB_ID  = P_SOB_ID  --회사아이디
           AND ORG_ID  = P_ORG_ID  --사업부아이디
           AND TAX_CODE   = P_TAX_CODE   --사업장아이디
           AND VAT_MNG_SERIAL   = P_VAT_MNG_SERIAL      --부가세신고기간구분번호
        ;
     EXCEPTION WHEN OTHERS THEN
       NULL;
     END;
   END IF;
   
END UPDATE_VAT_REPORT_MNG;





--grid에 조회된 자료 삭제
PROCEDURE DELETE_VAT_REPORT_MNG(
      P_SOB_ID	            IN 	FI_VAT_REPORT_MNG.SOB_ID%TYPE	            --회사아이디
    , P_ORG_ID	            IN 	FI_VAT_REPORT_MNG.ORG_ID%TYPE	            --사업부아이디
    , P_TAX_CODE            IN 	FI_VAT_REPORT_MNG.TAX_CODE%TYPE           --사업장코드.    
    , P_VAT_MNG_SERIAL      IN 	FI_VAT_REPORT_MNG.VAT_MNG_SERIAL%TYPE       --부가세신고기간구분번호구분번호
)

AS
  t_CLOSING_YN          VARCHAR2(2);
BEGIN
    t_CLOSING_YN := 'N';         
    BEGIN
      SELECT NVL(RM.CLOSING_YN, 'N') AS CLOSING_YN
        INTO t_CLOSING_YN
        FROM FI_VAT_REPORT_MNG RM
      WHERE   SOB_ID              = P_SOB_ID              --회사아이디
          AND ORG_ID              = P_ORG_ID              --사업부아이디
          AND TAX_CODE            = P_TAX_CODE            --사업장코드 
          AND VAT_MNG_SERIAL      = P_VAT_MNG_SERIAL      --부가세신고기간구분번호
      ;
    EXCEPTION WHEN OTHERS THEN
      t_CLOSING_YN := 'N';  
    END;
    
    DELETE FI_VAT_REPORT_MNG
    WHERE   SOB_ID              = P_SOB_ID              --회사아이디
        AND ORG_ID              = P_ORG_ID              --사업부아이디
        AND TAX_CODE            = P_TAX_CODE            --사업장코드 
        AND VAT_MNG_SERIAL      = P_VAT_MNG_SERIAL      --부가세신고기간구분번호
    ;
   
   -- 마감처리시 부가세 신고서의 마감여부 FLAG UPDATE -- 
   IF t_CLOSING_YN = 'Y' THEN
     BEGIN
       UPDATE FI_SURTAX_CARD SC
          SET SC.CLOSED_FLAG = 'Y'
        WHERE SOB_ID  = P_SOB_ID  --회사아이디
          AND ORG_ID  = P_ORG_ID  --사업부아이디
         AND TAX_CODE   = P_TAX_CODE   --사업장아이디
          AND VAT_MNG_SERIAL   = P_VAT_MNG_SERIAL      --부가세신고기간구분번호
       ;
     EXCEPTION WHEN OTHERS THEN
       NULL;
     END;
   END IF;
   
END DELETE_VAT_REPORT_MNG;











--신고기간구분 명 반환
FUNCTION VAT_MNG_SERIAL_F(
      P_VAT_MNG_SERIAL  IN FI_VAT_REPORT_MNG.VAT_MNG_SERIAL%TYPE    --부가세신고기간구분번호  
) RETURN VARCHAR2

AS

t_VAT_REPORT_NM     FI_VAT_REPORT_MNG.VAT_REPORT_NM%TYPE;    --부가세신고기간구분명

BEGIN

    SELECT VAT_REPORT_NM
    INTO t_VAT_REPORT_NM
    FROM FI_VAT_REPORT_MNG
    WHERE VAT_MNG_SERIAL = P_VAT_MNG_SERIAL ;
            
    RETURN t_VAT_REPORT_NM;


END VAT_MNG_SERIAL_F;



--신고기간 마감여부 반환 
FUNCTION VAT_CLOSED_FLAG(
      W_SOB_ID              IN  FI_VAT_REPORT_MNG.SOB_ID%TYPE  --회사아이디
    , W_ORG_ID              IN  FI_VAT_REPORT_MNG.ORG_ID%TYPE  --사업부아이디
    , W_TAX_CODE            IN  FI_VAT_REPORT_MNG.TAX_CODE%TYPE            --사업장아이디(예>110)    
    , W_VAT_MNG_SERIAL      IN  FI_VAT_REPORT_MNG.VAT_MNG_SERIAL%TYPE      --부가세신고기간구분번호     
) RETURN VARCHAR2
AS
  t_CLOSING_YN          VARCHAR2(2) := 'N';
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
  RETURN t_CLOSING_YN;
EXCEPTION WHEN OTHERS THEN
  t_CLOSING_YN := 'F';
  RETURN t_CLOSING_YN;
END;





END FI_VAT_REPORT_MNG_G;
/
