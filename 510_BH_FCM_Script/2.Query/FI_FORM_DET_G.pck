CREATE OR REPLACE PACKAGE FI_FORM_DET_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FORM_DET_G
Description  : 재무제표보고서 양식_상세 Package

Reference by : calling assmbly-program id(호출 프로그램) : (재무제표보고서양식)
Program History :
    기존 FI_FORM_LINE 테이블을 대체하여 새로이 만든 FI_FORM_DET 테이블을 기준하는 Package이다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-06-30   Leem Dong Ern(임동언)          
*****************************************************************************/



--재무제표보고서 양식 => 상세 grid에 조회되는 자료 추출
PROCEDURE LIST_FORM_DET( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_DET.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_DET.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_DET.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_FORM_TYPE_ID    IN FI_FORM_DET.FORM_TYPE_ID%TYPE    --보고서양식ID(공통코드)
    , W_ITEM_CODE	    IN FI_FORM_DET.ITEM_CODE%TYPE	    --항목코드_계정코드
);





--재무제표보고서 양식 => 상세 grid 상세항목코드 칼럼에 스이는 POPUP
PROCEDURE POP_DET_ITEM_CODE( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --보고서양식ID(공통코드)
    , W_ITEM_LEVEL      IN FI_FORM_MST.ITEM_LEVEL%TYPE      --항목레벨
);




--재무제표보고서 양식 => 상세 grid에 신규 항목 추가
PROCEDURE INSERT_FORM_DET( 
      P_SOB_ID	            IN	FI_FORM_DET.SOB_ID%TYPE	            --회사아이디
    , P_ORG_ID	            IN	FI_FORM_DET.ORG_ID%TYPE	            --사업부아이디
    , P_FS_SET_ID	        IN	FI_FORM_DET.FS_SET_ID%TYPE	        --보고서기준세트아이디
    , P_FORM_TYPE_ID	    IN	FI_FORM_DET.FORM_TYPE_ID%TYPE	    --보고서양식ID(공통코드)
    , P_ITEM_CODE	        IN	FI_FORM_DET.ITEM_CODE%TYPE	        --항목코드_계정코드    
    , P_DET_ITEM_CODE	    IN	FI_FORM_DET.DET_ITEM_CODE%TYPE	    --상세항목코드
    , P_ITEM_SIGN_SHOW	    IN	FI_FORM_DET.ITEM_SIGN_SHOW%TYPE	    --연산부호(+/-)    
    , P_ENABLED_FLAG	    IN	FI_FORM_DET.ENABLED_FLAG%TYPE	    --사용여부
    , P_REMARKS	            IN	FI_FORM_DET.REMARKS%TYPE	        --비고
    , P_CREATED_BY	        IN	FI_FORM_DET.CREATED_BY%TYPE	        --생성자
    
    , P_ITEM_LEVEL	        IN	FI_FORM_MST.ITEM_LEVEL%TYPE	        --항목레벨
    , P_FORM_SEQ	        OUT	FI_FORM_DET.FORM_SEQ%TYPE	        --재무제표보고서일련번호
);





--재무제표보고서 양식 => 상세 grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_FORM_DET( 
      W_SOB_ID              IN FI_FORM_DET.SOB_ID%TYPE              --회사아이디
    , W_ORG_ID              IN FI_FORM_DET.ORG_ID%TYPE              --사업부아이디
    , W_FS_SET_ID           IN FI_FORM_DET.FS_SET_ID%TYPE           --보고서기준세트아이디
    , W_FORM_TYPE_ID        IN FI_FORM_DET.FORM_TYPE_ID%TYPE        --보고서양식ID(공통코드)
    , W_ITEM_CODE           IN FI_FORM_DET.ITEM_CODE%TYPE           --항목코드_계정코드
    , W_FORM_SEQ            IN FI_FORM_DET.FORM_SEQ%TYPE            --재무제표보고서일련번호
    
    , P_DET_ITEM_CODE       IN FI_FORM_DET.DET_ITEM_CODE%TYPE       --상세항목코드
    , P_ITEM_SIGN_SHOW      IN FI_FORM_DET.ITEM_SIGN_SHOW%TYPE      --연산부호(+/-)    
    , P_ENABLED_FLAG        IN FI_FORM_DET.ENABLED_FLAG%TYPE        --사용여부
    , P_REMARKS             IN FI_FORM_DET.REMARKS%TYPE             --비고
    , P_LAST_UPDATED_BY     IN FI_FORM_DET.LAST_UPDATED_BY%TYPE     --수정자
    
    , P_ITEM_LEVEL	        IN	FI_FORM_MST.ITEM_LEVEL%TYPE	        --항목레벨
);




--재무제표보고서 양식 => 상세 grid에 조회된 자료 삭제
PROCEDURE DELETE_FORM_DET( 
      W_SOB_ID          IN FI_FORM_DET.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_DET.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_DET.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_FORM_TYPE_ID    IN FI_FORM_DET.FORM_TYPE_ID%TYPE    --보고서양식ID(공통코드)
    , W_ITEM_CODE       IN FI_FORM_DET.ITEM_CODE%TYPE       --항목코드_계정코드
    , W_FORM_SEQ        IN FI_FORM_DET.FORM_SEQ%TYPE        --재무제표보고서일련번호
);





--선택한 보고서 양식에 등록된 최하위레벨을 구하는 공통함수.
FUNCTION LAST_ITEM_LEVEL_F(
      W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --보고서양식ID(공통코드)
) RETURN NUMBER;





END FI_FORM_DET_G;
/
CREATE OR REPLACE PACKAGE BODY FI_FORM_DET_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FORM_DET_G
Description  : 재무제표보고서 양식_상세 Package Body

Reference by : calling assmbly-program id(호출 프로그램) : 
Program History :
    기존 FI_FORM_LINE 테이블을 대체하여 새로이 만든 FI_FORM_DET 테이블을 기준하는 Package이다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-06-30   Leem Dong Ern(임동언)          
*****************************************************************************/





--재무제표보고서 양식 => 상세 grid에 조회되는 자료 추출

PROCEDURE LIST_FORM_DET( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_DET.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_DET.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_DET.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_FORM_TYPE_ID    IN FI_FORM_DET.FORM_TYPE_ID%TYPE    --보고서양식ID(공통코드)
    , W_ITEM_CODE	    IN	FI_FORM_DET.ITEM_CODE%TYPE	    --항목코드_계정코드
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디
        , FS_SET_ID	        --보고서기준세트아이디
        , FORM_TYPE_ID	    --보고서양식ID(공통코드)    
        , ITEM_CODE	        --항목코드_계정코드
        , FORM_SEQ	        --재무제표보고서일련번호
        , DET_ITEM_CODE     --상세항목코드
        
        , DECODE(ACCOUNT_CONTROL_ID, NULL
            , (
                SELECT ITEM_NAME
                FROM FI_FORM_MST
                WHERE   SOB_ID          = A.SOB_ID          --회사아이디
                    AND ORG_ID          = A.ORG_ID          --사업부아이디
                    AND FS_SET_ID       = A.FS_SET_ID       --보고서기준세트아이디
                    AND FORM_TYPE_ID    = A.FORM_TYPE_ID    --보고서양식ID(공통코드)
                    AND ITEM_CODE       = A.DET_ITEM_CODE   --항목코드_계정코드 
                
              )  --항목명        
            , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(ACCOUNT_CONTROL_ID, SOB_ID)  --계정명
          ) AS DET_ITEM_NAME  --상세항목명
          
        , ACCOUNT_CONTROL_ID    --계정관리아이디
        , ITEM_SIGN_SHOW    --연산부호(+/-)
        , ENABLED_FLAG	    --사용여부
        
        --입력한 설정항목이 계정코드인지 항목코드인지에 대한 구분값으로 재무제표 값 추출 시 근간이 되는 정보이다.
        , DECODE(ACCOUNT_CONTROL_ID, NULL, '항목', '계정') AS ACC_ITEM_GB   --계정/항목구분
        
        , REMARKS	        --비고
        , 0 AS ITEM_LEVEL   --마스터에서 선책한 항목의 레빌을 보기위한 임시용임.

    FROM FI_FORM_DET A
    WHERE   SOB_ID          = W_SOB_ID          --회사아이디
        AND ORG_ID          = W_ORG_ID          --사업부아이디
        AND FS_SET_ID       = W_FS_SET_ID       --보고서기준세트아이디
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --보고서양식ID(공통코드)
        AND ITEM_CODE       = W_ITEM_CODE       --항목코드_계정코드      
    ORDER BY DET_ITEM_CODE;  --상세항목코드

END LIST_FORM_DET;






--재무제표보고서 양식 => 상세 grid 상세항목코드 칼럼에 사용되는 POPUP
PROCEDURE POP_DET_ITEM_CODE( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --보고서양식ID(공통코드)
    , W_ITEM_LEVEL      IN FI_FORM_MST.ITEM_LEVEL%TYPE      --항목레벨    
)

AS

t_LAST_ITEM_LEVEL NUMBER := 0;   --조회된 자료 목록 중에서 최하위레벨을 구한다.

BEGIN
    
    t_LAST_ITEM_LEVEL := LAST_ITEM_LEVEL_F(W_SOB_ID, W_ORG_ID, W_FS_SET_ID, W_FORM_TYPE_ID);
    
    IF W_ITEM_LEVEL = t_LAST_ITEM_LEVEL THEN
        --마스터 그리드에서 선택한 항목의 레벨이 최하위이면 계정코드를 보여준다.(기준테이블 : FI_ACCOUNT_CONTROL)
        
        OPEN P_CURSOR FOR
        SELECT
              ACCOUNT_DESC AS ITEM_NAME	    --항목명; 계정명    
            , ACCOUNT_CODE AS ITEM_CODE	    --항목코드; 계정코드             
        FROM FI_ACCOUNT_CONTROL
        WHERE   SOB_ID          = W_SOB_ID  --회사아이디
            AND ORG_ID          = W_ORG_ID  --사업부아이디
            AND ACCOUNT_SET_ID  = '10'      --계정세트아이디
        ORDER BY ACCOUNT_CODE
        ;
    ELSE
        --마스터 그리드에서 선택한 항목의 레벨이 최하위가 아니면 항목코드를 보여준다.(기준테이블 : FI_FORM_MST)
    
        OPEN P_CURSOR FOR
        SELECT
              ITEM_NAME	    --항목명    
            , ITEM_CODE	    --항목코드; 항목코드_계정코드             
        FROM FI_FORM_MST
        WHERE   SOB_ID          = W_SOB_ID          --회사아이디
            AND ORG_ID          = W_ORG_ID          --사업부아이디
            AND FS_SET_ID       = W_FS_SET_ID       --보고서기준세트아이디
            AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --보고서양식ID(공통코드)
            
            --자기레벨보다 1레벨 큰 레벨의 자료를 보여준다.
            --(예>선택한 항목의 레벨이 2레벨이면 팝업에는 3레벨의 자료가 조회된다.)
            AND ITEM_LEVEL      = W_ITEM_LEVEL + 1  --항목레벨
            --AND ENABLED_FLAG    = 'Y'               --사용(표시)여부
        ORDER BY ITEM_CODE
        ;    
    END IF;

END POP_DET_ITEM_CODE;






--재무제표보고서 양식 => 상세 grid에 신규 항목 추가
PROCEDURE INSERT_FORM_DET( 
      P_SOB_ID	            IN	FI_FORM_DET.SOB_ID%TYPE	            --회사아이디
    , P_ORG_ID	            IN	FI_FORM_DET.ORG_ID%TYPE	            --사업부아이디
    , P_FS_SET_ID	        IN	FI_FORM_DET.FS_SET_ID%TYPE	        --보고서기준세트아이디
    , P_FORM_TYPE_ID	    IN	FI_FORM_DET.FORM_TYPE_ID%TYPE	    --보고서양식ID(공통코드)
    , P_ITEM_CODE	        IN	FI_FORM_DET.ITEM_CODE%TYPE	        --항목코드_계정코드
    , P_DET_ITEM_CODE	    IN	FI_FORM_DET.DET_ITEM_CODE%TYPE	    --상세항목코드
    , P_ITEM_SIGN_SHOW	    IN	FI_FORM_DET.ITEM_SIGN_SHOW%TYPE	    --연산부호(+/-)    
    , P_ENABLED_FLAG	    IN	FI_FORM_DET.ENABLED_FLAG%TYPE	    --사용여부
    , P_REMARKS	            IN	FI_FORM_DET.REMARKS%TYPE	        --비고
    , P_CREATED_BY	        IN	FI_FORM_DET.CREATED_BY%TYPE	        --생성자
    
    , P_ITEM_LEVEL	        IN	FI_FORM_MST.ITEM_LEVEL%TYPE	        --항목레벨
    , P_FORM_SEQ	        OUT	FI_FORM_DET.FORM_SEQ%TYPE	        --재무제표보고서일련번호
)

AS

t_RECORD_COUNT          NUMBER := 0;
t_LAST_ITEM_LEVEL       NUMBER := 0;   --조회된 자료 목록 중에서 최하위레벨을 구한다.
t_ACCOUNT_CONTROL_ID    FI_ACCOUNT_CONTROL.ACCOUNT_CONTROL_ID%TYPE := NULL;   --계정관리아이디
V_SYSDATE               DATE := GET_LOCAL_DATE(P_SOB_ID);

BEGIN

    --추가하려는 자료가 이미 존재하는지를 파악한다.
    SELECT COUNT(*)
    INTO t_RECORD_COUNT
    FROM FI_FORM_DET
    WHERE   SOB_ID          = P_SOB_ID          --회사아이디
        AND ORG_ID          = P_ORG_ID          --사업부아이디
        AND FS_SET_ID       = P_FS_SET_ID       --보고서기준세트아이디
        AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --보고서양식ID(공통코드)
        AND ITEM_CODE       = P_ITEM_CODE       --항목코드_계정코드
        AND DET_ITEM_CODE   = P_DET_ITEM_CODE   --상세항목코드
    ;    
    
    --FCM_10273, 동일한 코드의 자료가 존재하여 등록할 수 없습니다. 확인바랍니다.
    IF t_RECORD_COUNT > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10273', NULL));
    END IF;
   
    t_LAST_ITEM_LEVEL := LAST_ITEM_LEVEL_F(P_SOB_ID, P_ORG_ID, P_FS_SET_ID, P_FORM_TYPE_ID);
    
    IF P_ITEM_LEVEL = t_LAST_ITEM_LEVEL THEN
        --마스터 그리드에서 선택한 항목의 레벨이 최하위이면 입력한 [상세항목코드]값이 계정이므로 
        --[계정관리아이디] 값을 설정해준다.
        SELECT ACCOUNT_CONTROL_ID
        INTO t_ACCOUNT_CONTROL_ID
        FROM FI_ACCOUNT_CONTROL
        WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND ACCOUNT_SET_ID = '10'
            AND ACCOUNT_CODE = P_DET_ITEM_CODE  ;        
    END IF; 


    --재무제표보고서일련번호
    SELECT NVL(MAX(FORM_SEQ), 0) + 1
    INTO P_FORM_SEQ
    FROM FI_FORM_DET
    WHERE   SOB_ID          = P_SOB_ID          --회사아이디
        AND ORG_ID          = P_ORG_ID          --사업부아이디
        AND FS_SET_ID       = P_FS_SET_ID       --보고서기준세트아이디
        AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --보고서양식ID(공통코드)
        AND ITEM_CODE       = P_ITEM_CODE       --항목코드_계정코드  
    ;             



    INSERT INTO FI_FORM_DET(
          SOB_ID	            --회사아이디
        , ORG_ID	            --사업부아이디
        , FS_SET_ID	            --보고서기준세트아이디
        , FORM_TYPE_ID	        --보고서양식ID(공통코드)
        , ITEM_CODE	            --항목코드_계정코드        
        , FORM_SEQ	            --재무제표보고서일련번호
        , DET_ITEM_CODE	        --상세항목코드
        , ACCOUNT_CONTROL_ID    --계정관리아이디
        , ITEM_SIGN_SHOW	    --연산부호(+/-)        
        , ENABLED_FLAG	        --사용여부
        , REMARKS	            --비고
        , CREATION_DATE         --생성일
        , CREATED_BY	        --생성자
        , LAST_UPDATE_DATE      --수정일
        , LAST_UPDATED_BY	    --수정자          
    )
    VALUES(
          P_SOB_ID	            --회사아이디
        , P_ORG_ID	            --사업부아이디
        , P_FS_SET_ID	        --보고서기준세트아이디
        , P_FORM_TYPE_ID	    --보고서양식ID(공통코드)
        , P_ITEM_CODE	        --항목코드_계정코드  
        , P_FORM_SEQ            --재무제표보고서일련번호
/*        
        , (
            SELECT NVL(MAX(FORM_SEQ), 0) + 1
            FROM FI_FORM_DET
            WHERE   SOB_ID          = P_SOB_ID          --회사아이디
                AND ORG_ID          = P_ORG_ID          --사업부아이디
                AND FS_SET_ID       = P_FS_SET_ID       --보고서기준세트아이디
                AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --보고서양식ID(공통코드)
                AND ITEM_CODE       = P_ITEM_CODE       --항목코드_계정코드        
          )   --재무제표보고서일련번호
*/          
        , P_DET_ITEM_CODE	    --상세항목코드
        , t_ACCOUNT_CONTROL_ID  --계정관리아이디
        , NVL(P_ITEM_SIGN_SHOW, '+')	    --연산부호(+/-)        
        , P_ENABLED_FLAG	    --사용여부
        , P_REMARKS	            --비고
        , V_SYSDATE             --생성일
        , P_CREATED_BY	        --생성자
        , V_SYSDATE             --수정일
        , P_CREATED_BY	        --수정자    
    );

END INSERT_FORM_DET;







--재무제표보고서 양식 => 상세 grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_FORM_DET( 
      W_SOB_ID              IN FI_FORM_DET.SOB_ID%TYPE              --회사아이디
    , W_ORG_ID              IN FI_FORM_DET.ORG_ID%TYPE              --사업부아이디
    , W_FS_SET_ID           IN FI_FORM_DET.FS_SET_ID%TYPE           --보고서기준세트아이디
    , W_FORM_TYPE_ID        IN FI_FORM_DET.FORM_TYPE_ID%TYPE        --보고서양식ID(공통코드)
    , W_ITEM_CODE           IN FI_FORM_DET.ITEM_CODE%TYPE           --항목코드_계정코드
    , W_FORM_SEQ            IN FI_FORM_DET.FORM_SEQ%TYPE            --재무제표보고서일련번호
    
    , P_DET_ITEM_CODE       IN FI_FORM_DET.DET_ITEM_CODE%TYPE       --상세항목코드
    , P_ITEM_SIGN_SHOW      IN FI_FORM_DET.ITEM_SIGN_SHOW%TYPE      --연산부호(+/-)    
    , P_ENABLED_FLAG        IN FI_FORM_DET.ENABLED_FLAG%TYPE        --사용여부
    , P_REMARKS             IN FI_FORM_DET.REMARKS%TYPE             --비고
    , P_LAST_UPDATED_BY     IN FI_FORM_DET.LAST_UPDATED_BY%TYPE     --수정자
    
    , P_ITEM_LEVEL	        IN	FI_FORM_MST.ITEM_LEVEL%TYPE	        --항목레벨
)

AS

t_LAST_ITEM_LEVEL       NUMBER := 0;   --조회된 자료 목록 중에서 최하위레벨을 구한다.
t_ACCOUNT_CONTROL_ID    FI_ACCOUNT_CONTROL.ACCOUNT_CONTROL_ID%TYPE := NULL;   --계정관리아이디

BEGIN

    t_LAST_ITEM_LEVEL := LAST_ITEM_LEVEL_F(W_SOB_ID, W_ORG_ID, W_FS_SET_ID, W_FORM_TYPE_ID);
    
    IF P_ITEM_LEVEL = t_LAST_ITEM_LEVEL THEN
        --마스터 그리드에서 선택한 항목의 레벨이 최하위이면 입력한 [상세항목코드]값이 계정이므로 
        --[계정관리아이디] 값을 설정해준다.
        SELECT ACCOUNT_CONTROL_ID
        INTO t_ACCOUNT_CONTROL_ID
        FROM FI_ACCOUNT_CONTROL
        WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
            AND ACCOUNT_CODE = P_DET_ITEM_CODE  ;        
    END IF; 

    UPDATE FI_FORM_DET
    SET
          DET_ITEM_CODE         = P_DET_ITEM_CODE           --상세항목코드
        , ACCOUNT_CONTROL_ID    = t_ACCOUNT_CONTROL_ID      --계정관리아이디   
        , ITEM_SIGN_SHOW        = P_ITEM_SIGN_SHOW          --연산부호(+/-)         
        , ENABLED_FLAG          = P_ENABLED_FLAG            --사용여부    
        , REMARKS               = P_REMARKS                 --비고
        , LAST_UPDATE_DATE      = GET_LOCAL_DATE(W_SOB_ID)  --수정일
        , LAST_UPDATED_BY       = P_LAST_UPDATED_BY         --수정자
    WHERE   SOB_ID          = W_SOB_ID          --회사아이디
        AND ORG_ID          = W_ORG_ID          --사업부아이디
        AND FS_SET_ID       = W_FS_SET_ID       --보고서기준세트아이디
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --보고서양식ID(공통코드)
        AND ITEM_CODE       = W_ITEM_CODE       --항목코드_계정코드
        AND FORM_SEQ        = W_FORM_SEQ        --재무제표보고서일련번호
    ;

END UPDATE_FORM_DET;





--재무제표보고서 양식 => 상세 grid에 조회된 자료 삭제
PROCEDURE DELETE_FORM_DET( 
      W_SOB_ID          IN FI_FORM_DET.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_DET.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_DET.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_FORM_TYPE_ID    IN FI_FORM_DET.FORM_TYPE_ID%TYPE    --보고서양식ID(공통코드)
    , W_ITEM_CODE       IN FI_FORM_DET.ITEM_CODE%TYPE       --항목코드_계정코드
    , W_FORM_SEQ        IN FI_FORM_DET.FORM_SEQ%TYPE        --재무제표보고서일련번호
)

AS

BEGIN

    DELETE FI_FORM_DET
    WHERE   SOB_ID          = W_SOB_ID          --회사아이디
        AND ORG_ID          = W_ORG_ID          --사업부아이디
        AND FS_SET_ID       = W_FS_SET_ID       --보고서기준세트아이디
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --보고서양식ID(공통코드)
        AND ITEM_CODE       = W_ITEM_CODE       --항목코드_계정코드
        AND FORM_SEQ        = W_FORM_SEQ        --재무제표보고서일련번호
    ;

END DELETE_FORM_DET;





--선택한 보고서 양식에 등록된 최하위레벨을 구하는 공통함수.
FUNCTION LAST_ITEM_LEVEL_F(
      W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --보고서양식ID(공통코드)
) RETURN NUMBER

AS

t_LAST_ITEM_LEVEL NUMBER := 0;   --조회된 자료 목록 중에서 최하위레벨을 구한다.

BEGIN

    SELECT NVL(MAX(ITEM_LEVEL), 0)
    INTO t_LAST_ITEM_LEVEL
    FROM FI_FORM_MST
    WHERE   SOB_ID          = W_SOB_ID          --회사아이디
        AND ORG_ID          = W_ORG_ID          --사업부아이디
        AND FS_SET_ID       = W_FS_SET_ID       --보고서기준세트아이디
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --보고서양식ID(공통코드)
    ;
    
    RETURN t_LAST_ITEM_LEVEL;

END LAST_ITEM_LEVEL_F;





END FI_FORM_DET_G;
/
