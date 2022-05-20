CREATE OR REPLACE PACKAGE FI_FORM_MST_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FORM_MST_G
Description  : 재무제표보고서 양식_마스터 Package

Reference by : calling assmbly-program id(호출 프로그램) : FCMF0710(재무제표보고서양식)
Program History :
    -.기존 FI_FORM_HEADER 테이블을 대체하여 새로이 만든 FI_FORM_MST 테이블을 기준하는 Package이다.
    -.하기의 PROCEDURE 또는 function 들에 대해 
      관련탭이라는 별도의 주석을 명기하지않은 것들은 1번재 탭인 [보고서양식관리]와 관련된 것들이다.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-06-29   Leem Dong Ern(임동언)          
*****************************************************************************/



--재무제표보고서 양식 => 계정과목관리(FI_ACCOUNT_CONTROL) 자료를 근간으로 보고서 양식의 기준이 되는 자료 일괄생성
--1단계 : FI_FORM_MST(재무제표보고서양식_마스터) 테이블에 DATA INSERT
--2단계 : FI_FORM_DET(재무제표보고서양식_상세)   테이블에 DATA INSERT
PROCEDURE CREATE_FORM_MST( 
      P_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , P_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , P_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디    
    , P_FORM_TYPE_ID    IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서양식ID    
    , P_CREATED_BY	    IN FI_FORM_MST.CREATED_BY%TYPE	    --생성자
);



 


--재무제표보고서 양식 => 마스터 grid에 조회되는 자료 추출
PROCEDURE LIST_FORM_MST( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --보고서양식ID(공통코드)
);




--재무제표보고서 양식 => 클릭한 항목과 연동될 항목을 추출한다.
--클릭한 항목과 동 레벨의 등록된 항목이 추출된다.
--이는 화면에서 팝업으로 사용되며, 연동항목은 실질적으로 [재무상태표]에서만 사용한다.
PROCEDURE POP_RELATE_ITEM( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --보고서양식ID(공통코드)
    , W_ITEM_LEVEL      IN FI_FORM_MST.ITEM_LEVEL%TYPE      --항목레벨
);






--재무제표보고서 양식 => 클릭한 항목의 값을 가져올 타 보고서양식에 등록된 항목을 보여준다.
--예>손익계산서의 당기제품제조원가 항목의 값은 제조원가명세서의 당기제품제조원가 항목의 값을 이용한다.
--이는 화면에서 팝업으로 사용되며, 관련항목은 실질적으로 [손익계산서, 재무상태표]에서만 사용한다.
PROCEDURE POP_REF_ITEM( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --보고서양식ID(공통코드)
);








--재무제표보고서 양식 => 마스터 grid에 신규 항목 추가
PROCEDURE INSERT_FORM_MST( 
      P_SOB_ID	            IN 	FI_FORM_MST.SOB_ID%TYPE	            --회사아이디
    , P_ORG_ID	            IN 	FI_FORM_MST.ORG_ID%TYPE	            --사업부아이디
    , P_FS_SET_ID	        IN 	FI_FORM_MST.FS_SET_ID%TYPE	        --보고서기준세트아이디
    , P_FORM_TYPE_ID	    IN 	FI_FORM_MST.FORM_TYPE_ID%TYPE	    --보고서양식ID(공통코드)
    , P_ITEM_CODE	        IN 	FI_FORM_MST.ITEM_CODE%TYPE	        --항목코드_계정코드
    , P_ITEM_NAME	        IN	FI_FORM_MST.ITEM_NAME%TYPE	        --항목명
    , P_ACCOUNT_DR_CR	    IN	FI_FORM_MST.ACCOUNT_DR_CR%TYPE	    --차대구분(1-차변,2-대변)
    , P_MNS_ACCOUNT_FLAG    IN	FI_FORM_MST.MNS_ACCOUNT_FLAG%TYPE	--차감계정여부
    , P_RELATE_ITEM_CODE	IN	FI_FORM_MST.RELATE_ITEM_CODE%TYPE	--연동항목코드
    , P_SORT_SEQ	        IN	FI_FORM_MST.SORT_SEQ%TYPE	        --정렬순서
    , P_ITEM_LEVEL	        IN	FI_FORM_MST.ITEM_LEVEL%TYPE	        --항목레벨
    , P_ENABLED_FLAG	    IN	FI_FORM_MST.ENABLED_FLAG%TYPE	    --사용여부
    , P_REMARKS	            IN	FI_FORM_MST.REMARKS%TYPE	        --비고
    , P_CREATED_BY	        IN	FI_FORM_MST.CREATED_BY%TYPE	        --생성자 

    , P_REF_FORM_TYPE_ID	IN	FI_FORM_MST.REF_FORM_TYPE_ID%TYPE   --관련보고서양식ID(공통코드)
    , P_REF_ITEM_CODE	    IN	FI_FORM_MST.REF_ITEM_CODE%TYPE	    --관련항목코드
    , P_SUMMARY_YN	        IN	FI_FORM_MST.SUMMARY_YN%TYPE	        --요약재무제표항목여부
    
    , P_FORM_ITEM_TYPE_CD	IN	FI_FORM_MST.FORM_ITEM_TYPE_CD%TYPE  --재고자산기말금액관리항목코드
    , P_FORM_FRAME_YN	    IN	FI_FORM_MST.FORM_FRAME_YN%TYPE	    --보고서틀유지여부
    
);





--재무제표보고서 양식 => 마스터 grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_FORM_MST( 
      W_SOB_ID              IN  FI_FORM_MST.SOB_ID%TYPE              --회사아이디
    , W_ORG_ID              IN  FI_FORM_MST.ORG_ID%TYPE              --사업부아이디
    , W_FS_SET_ID           IN  FI_FORM_MST.FS_SET_ID%TYPE           --보고서기준세트아이디
    , W_FORM_TYPE_ID        IN  FI_FORM_MST.FORM_TYPE_ID%TYPE        --보고서양식ID(공통코드)
    , W_ITEM_CODE           IN  FI_FORM_MST.ITEM_CODE%TYPE           --항목코드_계정코드
    
    , P_ITEM_NAME           IN  FI_FORM_MST.ITEM_NAME%TYPE           --항목명
    , P_ACCOUNT_DR_CR       IN  FI_FORM_MST.ACCOUNT_DR_CR%TYPE       --차대구분(1-차변,2-대변)
    , P_MNS_ACCOUNT_FLAG    IN  FI_FORM_MST.MNS_ACCOUNT_FLAG%TYPE    --차감계정여부
    , P_RELATE_ITEM_CODE    IN  FI_FORM_MST.RELATE_ITEM_CODE%TYPE    --연동항목코드
    , P_SORT_SEQ            IN  FI_FORM_MST.SORT_SEQ%TYPE            --정렬순서
    , P_ITEM_LEVEL          IN  FI_FORM_MST.ITEM_LEVEL%TYPE          --항목레벨
    , P_ENABLED_FLAG        IN  FI_FORM_MST.ENABLED_FLAG%TYPE        --사용여부
    , P_REMARKS             IN  FI_FORM_MST.REMARKS%TYPE             --비고
    , P_LAST_UPDATED_BY     IN  FI_FORM_MST.LAST_UPDATED_BY%TYPE     --수정자
    
    , P_REF_FORM_TYPE_ID	IN  FI_FORM_MST.REF_FORM_TYPE_ID%TYPE   --관련보고서양식ID(공통코드)
    , P_REF_ITEM_CODE	    IN	FI_FORM_MST.REF_ITEM_CODE%TYPE	    --관련항목코드
    , P_SUMMARY_YN	        IN	FI_FORM_MST.SUMMARY_YN%TYPE	        --요약재무제표항목여부
    
    , P_FORM_ITEM_TYPE_CD	IN	FI_FORM_MST.FORM_ITEM_TYPE_CD%TYPE  --재고자산기말금액관리항목코드
    , P_FORM_FRAME_YN	    IN	FI_FORM_MST.FORM_FRAME_YN%TYPE	    --보고서틀유지여부    
);




--재무제표보고서 양식 => 마스터 grid에 조회된 자료 삭제
PROCEDURE DELETE_FORM_MST( 
      W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --보고서양식ID(공통코드)
    , W_ITEM_CODE       IN FI_FORM_MST.ITEM_CODE%TYPE       --항목코드_계정코드
);






--관련 탭 : 누락계정조회
--취지 : 계정과목관리 프로그램에서는 임의의 계정에 대해 재무제표양식을 설정했는데
--       이 설정된 계정이 재무제표양식관리 프로그램의 해당 보고서 양식에는 포함되지 않은
--       계정들을 조회하고자 함이다.
PROCEDURE LIST_OMISSION_ACCOUNT( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --보고서양식ID(공통코드)
);











--선택한 항목의 연동항목코드에 대한 명을 구하는 공통함수.
FUNCTION RELATE_ITEM_CODE_NAME_F(
      W_SOB_ID              IN FI_FORM_MST.SOB_ID%TYPE              --회사아이디
    , W_ORG_ID              IN FI_FORM_MST.ORG_ID%TYPE              --사업부아이디
    , W_FS_SET_ID           IN FI_FORM_MST.FS_SET_ID%TYPE           --보고서기준세트아이디
    , W_FORM_TYPE_ID        IN FI_FORM_MST.FORM_TYPE_ID%TYPE        --보고서양식ID(공통코드)
    , W_RELATE_ITEM_CODE    IN FI_FORM_MST.RELATE_ITEM_CODE%TYPE    --연동항목코드
) RETURN VARCHAR2;


--재무제표보고서 양식 복사위해 기존 데이터 존재 여부 체크.
PROCEDURE GET_FORM_MST_COUNT( 
      P_SOB_ID            IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , P_ORG_ID            IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , P_FS_SET_ID         IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디    
    , P_FORM_TYPE_ID      IN FI_FORM_MST.FORM_TYPE_ID%TYPE     --보고서양식ID        
    , O_RECORD_COUNT      OUT NUMBER
);

--재무제표보고서 양식 복사 
--1단계 : FI_FORM_MST(재무제표보고서양식_마스터) 테이블에 DATA INSERT
--2단계 : FI_FORM_DET(재무제표보고서양식_상세)   테이블에 DATA INSERT
PROCEDURE COPY_FORM_MST( 
      P_SOB_ID            IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , P_ORG_ID            IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , P_FS_SET_ID         IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디    
    , P_FORM_TYPE_ID      IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서양식ID    
    , P_NEW_FS_SET_ID     IN FI_FORM_MST.FS_SET_ID%TYPE       --신규 보고서기준세트아이디    
    , P_NEW_FORM_TYPE_ID  IN FI_FORM_MST.FS_SET_ID%TYPE       --신규 보고서양식ID
    , P_USER_ID           IN FI_FORM_MST.CREATED_BY%TYPE	    --생성자
    , O_STATUS            OUT VARCHAR2
    , O_MESSAGE           OUT VARCHAR2
);



END FI_FORM_MST_G;
/
CREATE OR REPLACE PACKAGE BODY FI_FORM_MST_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FORM_MST_G
Description  : 재무제표보고서 양식_마스터 Package Body

Reference by : calling assmbly-program id(호출 프로그램) : FCMF0710(재무제표보고서양식)
Program History :
    -.기존 FI_FORM_HEADER 테이블을 대체하여 새로이 만든 FI_FORM_MST 테이블을 기준하는 Package이다.
    -.하기의 PROCEDURE 또는 function 들에 대해 
      관련탭이라는 별도의 주석을 명기하지않은 것들은 1번재 탭인 [보고서양식관리]와 관련된 것들이다.    
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-06-29   Leem Dong Ern(임동언)          
*****************************************************************************/



--재무제표보고서 양식 => 계정과목관리(FI_ACCOUNT_CONTROL) 자료를 근간으로 보고서 양식의 기준이 되는 자료 일괄생성
--1단계 : FI_FORM_MST(재무제표보고서양식_마스터) 테이블에 DATA INSERT
--2단계 : FI_FORM_DET(재무제표보고서양식_상세)   테이블에 DATA INSERT
--자료 생성은 각 양식별로 한다.

PROCEDURE CREATE_FORM_MST( 
      P_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , P_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , P_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디    
    , P_FORM_TYPE_ID    IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서양식ID    
    , P_CREATED_BY	    IN FI_FORM_MST.CREATED_BY%TYPE	    --생성자
)

AS

--t_FORM_TYPE_ID      NUMBER := 0; --보고서양식ID(공통코드)를 담기위함.
t_ACCOUNT_FS_TYPE   FI_ACCOUNT_CONTROL.ACCOUNT_FS_TYPE%TYPE; --재무제표관리 값을 담기위함.


BEGIN
    
    /*
    --기존에 존재하는 자료가 있을 경우 모두 삭제한다.
    DELETE FI_FORM_MST
    WHERE   SOB_ID          = P_SOB_ID          --회사아이디
        AND ORG_ID          = P_ORG_ID          --사업부아이디
        AND FS_SET_ID       = P_FS_SET_ID       --보고서기준세트아이디
    ;
    
    
    --기존에 존재하는 자료가 있을 경우 모두 삭제한다.
    DELETE FI_FORM_DET
    WHERE   SOB_ID          = P_SOB_ID          --회사아이디
        AND ORG_ID          = P_ORG_ID          --사업부아이디
        AND FS_SET_ID       = P_FS_SET_ID       --보고서기준세트아이디
    ;     
    */
    
    
    --기존에 존재하는 자료가 있을 경우 모두 삭제한다.
    DELETE FI_FORM_MST
    WHERE   SOB_ID          = P_SOB_ID          --회사아이디
        AND ORG_ID          = P_ORG_ID          --사업부아이디
        AND FS_SET_ID       = P_FS_SET_ID       --보고서기준세트아이디
        AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --보고서양식ID(공통코드)
    ; 

    
    
    --기존에 존재하는 자료가 있을 경우 모두 삭제한다.
    DELETE FI_FORM_DET
    WHERE   SOB_ID          = P_SOB_ID          --회사아이디
        AND ORG_ID          = P_ORG_ID          --사업부아이디
        AND FS_SET_ID       = P_FS_SET_ID       --보고서기준세트아이디
        AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --보고서양식ID(공통코드)
    ; 
    
    


    IF P_FORM_TYPE_ID = 744 THEN   --합계잔액시산표
    
        INSERT INTO FI_FORM_MST(
              SOB_ID	        --회사아이디
            , ORG_ID	        --사업부아이디
            , FS_SET_ID	        --보고서기준세트아이디
            , FORM_TYPE_ID	    --보고서양식ID(공통코드)
            , ITEM_CODE	        --항목코드_계정코드
            , ITEM_NAME	        --항목명
            , ACCOUNT_DR_CR	    --차대구분(1-차변,2-대변)
            , MNS_ACCOUNT_FLAG	--차감계정여부
            , RELATE_ITEM_CODE	--연동항목코드
            , SORT_SEQ	        --정렬순서
            , ITEM_LEVEL	    --항목레벨
            , ENABLED_FLAG	    --사용여부
            , REMARKS	        --비고
            , CREATION_DATE     --생성일
            , CREATED_BY	    --생성자
            , LAST_UPDATE_DATE  --수정일
            , LAST_UPDATED_BY	--수정자          
        )
        SELECT
              SOB_ID                    --회사아이디
            , ORG_ID                    --사업부아이디
            , P_FS_SET_ID               --보고서기준세트아이디        
            , P_FORM_TYPE_ID            --보고서양식ID            
            , ACCOUNT_CODE AS ITEM_CODE --항목코드_계정코드
            , DECODE(ACCOUNT_DESC_S, NULL, ACCOUNT_DESC, '', ACCOUNT_DESC, ACCOUNT_DESC_S) AS ITEM_NAME  --항목명
            , ACCOUNT_DR_CR             --차대구분(1-차변,2-대변)
            
            --참조>[차감계정여부, 연동항목코드]는 재무상태표만 있는게 맞다.
            --, NVL(MNS_ACCOUNT_FLAG, 'N') AS MNS_ACCOUNT_FLAG    --차감계정여부
            --, RELATE_ACCOUNT_CODE AS RELATE_ITEM_CODE           --연동항목코드
            , 'N' AS MNS_ACCOUNT_FLAG   --차감계정여부
            , NULL AS RELATE_ITEM_CODE  --연동항목코드 
            
            , ROW_NUMBER() OVER(ORDER BY ACCOUNT_CODE ASC) * 100 AS SORT_SEQ  --정렬순서
            
            --기본값으로 각 양식의 최종레벨을 설정한다.
            , (
                    SELECT VALUE1
                    FROM FI_COMMON
                    WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND COMMON_ID = P_FORM_TYPE_ID   
              ) AS ITEM_LEVEL   --항목레벨
              
            , 'Y' ENABLED_FLAG                              --사용여부
            , '' AS REMARKS                                 --비고
            , GET_LOCAL_DATE(SOB_ID) AS CREATION_DATE       --생성일
            , P_CREATED_BY                                  --생성자
            , GET_LOCAL_DATE(SOB_ID) AS LAST_UPDATE_DATE    --수정일
            , P_CREATED_BY                                  --수정자    
        FROM FI_ACCOUNT_CONTROL
        WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND ACCOUNT_SET_ID = '10'            
            AND ACCOUNT_FS_TYPE IN ('1002', '1003', '1004') --이 한문장만 아래 쿼리와 다르다.
            --AND ACCOUNT_FS_TYPE IS NOT NULL --이 한문장만 아래 쿼리와 다르다.
        ;  
        
    ELSE    --제조원가명세서, 손익계산서, 재무상태표(대차대조표)
    
    
        IF P_FORM_TYPE_ID = 747 THEN        --제조원가명세서 
            t_ACCOUNT_FS_TYPE := '1004';          
        ELSIF P_FORM_TYPE_ID = 746 THEN     --손익계산서 
            t_ACCOUNT_FS_TYPE := '1003';            
        ELSIF P_FORM_TYPE_ID = 745 THEN     --재무상태표(대차대조표)
            t_ACCOUNT_FS_TYPE := '1002';        
        END IF;        
    
    
        INSERT INTO FI_FORM_MST(
              SOB_ID	        --회사아이디
            , ORG_ID	        --사업부아이디
            , FS_SET_ID	        --보고서기준세트아이디
            , FORM_TYPE_ID	    --보고서양식ID(공통코드)
            , ITEM_CODE	        --항목코드_계정코드
            , ITEM_NAME	        --항목명
            , ACCOUNT_DR_CR	    --차대구분(1-차변,2-대변)
            , MNS_ACCOUNT_FLAG	--차감계정여부
            , RELATE_ITEM_CODE	--연동항목코드
            , SORT_SEQ	        --정렬순서
            , ITEM_LEVEL	    --항목레벨
            , ENABLED_FLAG	    --사용여부
            , REMARKS	        --비고
            , CREATION_DATE     --생성일
            , CREATED_BY	    --생성자
            , LAST_UPDATE_DATE  --수정일
            , LAST_UPDATED_BY	--수정자          
        )
        SELECT
              SOB_ID                    --회사아이디
            , ORG_ID                    --사업부아이디
            , P_FS_SET_ID               --보고서기준세트아이디        
            , P_FORM_TYPE_ID            --보고서양식ID            
            , ACCOUNT_CODE AS ITEM_CODE --항목코드_계정코드
            , DECODE(ACCOUNT_DESC_S, NULL, ACCOUNT_DESC, '', ACCOUNT_DESC, ACCOUNT_DESC_S) AS ITEM_NAME  --항목명
            , ACCOUNT_DR_CR             --차대구분(1-차변,2-대변)
            
            --참조>[차감계정여부, 연동항목코드]는 재무상태표만 있는게 맞다.
            , NVL(MNS_ACCOUNT_FLAG, 'N') AS MNS_ACCOUNT_FLAG    --차감계정여부
            , RELATE_ACCOUNT_CODE AS RELATE_ITEM_CODE           --연동항목코드
            
            , ROW_NUMBER() OVER(ORDER BY ACCOUNT_CODE ASC) * 100 AS SORT_SEQ  --정렬순서
            
            --기본값으로 각 양식의 최종레벨을 설정한다.
            , (
                    SELECT VALUE1
                    FROM FI_COMMON
                    WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND COMMON_ID = P_FORM_TYPE_ID   
              ) AS ITEM_LEVEL   --항목레벨
              
            , 'Y' ENABLED_FLAG                              --사용여부
            , '' AS REMARKS                                 --비고
            , GET_LOCAL_DATE(SOB_ID) AS CREATION_DATE       --생성일
            , P_CREATED_BY                                  --생성자
            , GET_LOCAL_DATE(SOB_ID) AS LAST_UPDATE_DATE    --수정일
            , P_CREATED_BY                                  --수정자    
        FROM FI_ACCOUNT_CONTROL
        WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND ACCOUNT_SET_ID = '10'
            AND ACCOUNT_FS_TYPE = t_ACCOUNT_FS_TYPE --이 한문장만 위 쿼리와 다르다.
        ;        
    
    END IF;



/*
    --본 주석 블럭은 지우지 마세요. 4개의 보고서 양식 개별적 생성이 아닌 일괄생성시에 사용하면 됩니다.

    --1단계 : FI_FORM_MST(재무제표보고서양식_마스터) 테이블에 DATA INSERT.    
    --BH에서 관리하는 재무제표 관련 양식은 모두 4개이다.
    FOR I IN 1..4 LOOP
        IF        I = 1 THEN    --합계잔액시산표 
                BEGIN
                    t_FORM_TYPE_ID := 744;  
                    t_ACCOUNT_FS_TYPE := NULL;  --사용안함.
                END;
            ELSIF I = 2 THEN    --제조원가명세서
                BEGIN
                    t_FORM_TYPE_ID := 747;  
                    t_ACCOUNT_FS_TYPE := '1004';
                END;            
            ELSIF I = 3 THEN    --손익계산서
                BEGIN
                    t_FORM_TYPE_ID := 746;  
                    t_ACCOUNT_FS_TYPE := '1003';
                END;             
            ELSIF I = 4 THEN    --재무상태표(대차대조표)
                BEGIN
                    t_FORM_TYPE_ID := 745;  
                    t_ACCOUNT_FS_TYPE := '1002';
                END;            
        END IF;


        --아래 IF문은 더 간결하게 할 수도 있지만 그런 수고가 필요없을 것 같아 이 상태로 종결한다.
        IF I = 1 THEN   --합계잔액시산표
        
            INSERT INTO FI_FORM_MST(
                  SOB_ID	        --회사아이디
                , ORG_ID	        --사업부아이디
                , FS_SET_ID	        --보고서기준세트아이디
                , FORM_TYPE_ID	    --보고서양식ID(공통코드)
                , ITEM_CODE	        --항목코드_계정코드
                , ITEM_NAME	        --항목명
                , ACCOUNT_DR_CR	    --차대구분(1-차변,2-대변)
                , MNS_ACCOUNT_FLAG	--차감계정여부
                , RELATE_ITEM_CODE	--연동항목코드
                , SORT_SEQ	        --정렬순서
                , ITEM_LEVEL	    --항목레벨
                , ENABLED_FLAG	    --사용여부
                , REMARKS	        --비고
                , CREATION_DATE     --생성일
                , CREATED_BY	    --생성자
                , LAST_UPDATE_DATE  --수정일
                , LAST_UPDATED_BY	--수정자          
            )
            SELECT
                  SOB_ID                    --회사아이디
                , ORG_ID                    --사업부아이디
                , P_FS_SET_ID               --보고서기준세트아이디        
                , t_FORM_TYPE_ID            --보고서양식ID            
                , ACCOUNT_CODE AS ITEM_CODE --항목코드_계정코드
                , DECODE(ACCOUNT_DESC_S, NULL, ACCOUNT_DESC, '', ACCOUNT_DESC, ACCOUNT_DESC_S) AS ITEM_NAME  --항목명
                , ACCOUNT_DR_CR             --차대구분(1-차변,2-대변)
                
                --참조>[차감계정여부, 연동항목코드]는 재무상태표만 있는게 맞다.
                --, NVL(MNS_ACCOUNT_FLAG, 'N') AS MNS_ACCOUNT_FLAG    --차감계정여부
                --, RELATE_ACCOUNT_CODE AS RELATE_ITEM_CODE           --연동항목코드
                , 'N' AS MNS_ACCOUNT_FLAG   --차감계정여부
                , NULL AS RELATE_ITEM_CODE  --연동항목코드 
                
                , ROW_NUMBER() OVER(ORDER BY ACCOUNT_CODE ASC) * 100 AS SORT_SEQ  --정렬순서
                
                --기본값으로 각 양식의 최종레벨을 설정한다.
                , (
                        SELECT VALUE1
                        FROM FI_COMMON
                        WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND COMMON_ID = t_FORM_TYPE_ID   
                  ) AS ITEM_LEVEL   --항목레벨
                  
                , 'Y' ENABLED_FLAG                              --사용여부
                , '' AS REMARKS                                 --비고
                , GET_LOCAL_DATE(SOB_ID) AS CREATION_DATE       --생성일
                , P_CREATED_BY                                  --생성자
                , GET_LOCAL_DATE(SOB_ID) AS LAST_UPDATE_DATE    --수정일
                , P_CREATED_BY                                  --수정자    
            FROM FI_ACCOUNT_CONTROL
            WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND ACCOUNT_SET_ID = '10'
                AND ACCOUNT_FS_TYPE IS NOT NULL --이 한문장만 아래 쿼리와 다르다.
            ;  
            
        ELSE    --제조원가명세서, 손익계산서, 재무상태표(대차대조표)
        
            INSERT INTO FI_FORM_MST(
                  SOB_ID	        --회사아이디
                , ORG_ID	        --사업부아이디
                , FS_SET_ID	        --보고서기준세트아이디
                , FORM_TYPE_ID	    --보고서양식ID(공통코드)
                , ITEM_CODE	        --항목코드_계정코드
                , ITEM_NAME	        --항목명
                , ACCOUNT_DR_CR	    --차대구분(1-차변,2-대변)
                , MNS_ACCOUNT_FLAG	--차감계정여부
                , RELATE_ITEM_CODE	--연동항목코드
                , SORT_SEQ	        --정렬순서
                , ITEM_LEVEL	    --항목레벨
                , ENABLED_FLAG	    --사용여부
                , REMARKS	        --비고
                , CREATION_DATE     --생성일
                , CREATED_BY	    --생성자
                , LAST_UPDATE_DATE  --수정일
                , LAST_UPDATED_BY	--수정자          
            )
            SELECT
                  SOB_ID                    --회사아이디
                , ORG_ID                    --사업부아이디
                , P_FS_SET_ID               --보고서기준세트아이디        
                , t_FORM_TYPE_ID            --보고서양식ID            
                , ACCOUNT_CODE AS ITEM_CODE --항목코드_계정코드
                , DECODE(ACCOUNT_DESC_S, NULL, ACCOUNT_DESC, '', ACCOUNT_DESC, ACCOUNT_DESC_S) AS ITEM_NAME  --항목명
                , ACCOUNT_DR_CR             --차대구분(1-차변,2-대변)
                
                --참조>[차감계정여부, 연동항목코드]는 재무상태표만 있는게 맞다.
                , NVL(MNS_ACCOUNT_FLAG, 'N') AS MNS_ACCOUNT_FLAG    --차감계정여부
                , RELATE_ACCOUNT_CODE AS RELATE_ITEM_CODE           --연동항목코드
                
                , ROW_NUMBER() OVER(ORDER BY ACCOUNT_CODE ASC) * 100 AS SORT_SEQ  --정렬순서
                
                --기본값으로 각 양식의 최종레벨을 설정한다.
                , (
                        SELECT VALUE1
                        FROM FI_COMMON
                        WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND COMMON_ID = t_FORM_TYPE_ID   
                  ) AS ITEM_LEVEL   --항목레벨
                  
                , 'Y' ENABLED_FLAG                              --사용여부
                , '' AS REMARKS                                 --비고
                , GET_LOCAL_DATE(SOB_ID) AS CREATION_DATE       --생성일
                , P_CREATED_BY                                  --생성자
                , GET_LOCAL_DATE(SOB_ID) AS LAST_UPDATE_DATE    --수정일
                , P_CREATED_BY                                  --수정자    
            FROM FI_ACCOUNT_CONTROL
            WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND ACCOUNT_SET_ID = '10'
                AND ACCOUNT_FS_TYPE = t_ACCOUNT_FS_TYPE --이 한문장만 위 쿼리와 다르다.
            ;        
        
        END IF;

        
        --DBMS_OUTPUT.PUT_LINE('------- I : ' || I || ' t_ACCOUNT_FS_TYPE : ' || t_ACCOUNT_FS_TYPE );

    END LOOP;
*/





    --2단계 : FI_FORM_DET(재무제표보고서양식_상세)   테이블에 DATA INSERT
    /*  2단계 - 1
        -.FI_FORM_MST에 생성한 자료를 그대로 FI_FORM_DET 테이블에 INSERT한다.
        -.본인 자신의 금액이 본인 자신에서 도출되는 계정일 경우 당연하고,
        -.본인이 전표입력하는 계정이 아닌 대표계정인 경우에는 본인이 본인 자신의
          하위 항목에 들어 있어도 전표로 등록된 값이 없기 때문에 또한 문제가 되지 않는다.
          혹은, 불필요 시 작업자가 프로그램을 통해 삭제하면 된다.
          
    */
            
    INSERT INTO FI_FORM_DET(
          SOB_ID	            --회사아이디
        , ORG_ID	            --사업부아이디
        , FS_SET_ID	            --보고서기준세트아이디
        , FORM_TYPE_ID	        --보고서양식ID(공통코드)
        , ITEM_CODE	            --항목코드_계정코드
        , FORM_SEQ	            --재무제표보고서일련번호
        , DET_ITEM_CODE	        --상세항목코드
        , ACCOUNT_CONTROL_ID    --계정관리아이디
        , ITEM_SIGN_SHOW        --연산부호(+/-)
        , ENABLED_FLAG	        --사용여부
        , REMARKS	            --비고
        , CREATION_DATE	        --생성일
        , CREATED_BY	        --생성자
        , LAST_UPDATE_DATE	    --수정일
        , LAST_UPDATED_BY	    --수정자    
    )
    SELECT 
          SOB_ID        --회사아이디
        , ORG_ID        --사업부아이디
        , FS_SET_ID     --보고서기준세트아이디        
        , FORM_TYPE_ID  --보고서양식ID(공통코드)            
        , ITEM_CODE     --항목코드_계정코드
        
        , ROW_NUMBER() OVER(ORDER BY ITEM_CODE ASC) AS FORM_SEQ --재무제표보고서일련번호        
        , ITEM_CODE AS DET_ITEM_CODE                            --상세항목코드
        
        , ( SELECT ACCOUNT_CONTROL_ID
            FROM FI_ACCOUNT_CONTROL
            WHERE SOB_ID = A.SOB_ID AND ORG_ID = A.ORG_ID AND ACCOUNT_SET_ID = '10' AND ACCOUNT_CODE = A.ITEM_CODE )
            AS ACCOUNT_CONTROL_ID --계정관리아이디
            
        , '+' AS ITEM_SIGN_SHOW                         --연산부호(+/-)        
        , 'Y' ENABLED_FLAG                              --사용여부
        , '' AS REMARKS                                 --비고
        , GET_LOCAL_DATE(SOB_ID) AS CREATION_DATE       --생성일
        , P_CREATED_BY                                  --생성자
        , GET_LOCAL_DATE(SOB_ID) AS LAST_UPDATE_DATE    --수정일
        , P_CREATED_BY                                  --수정자 
    FROM FI_FORM_MST A
    WHERE   SOB_ID          = P_SOB_ID          --회사아이디
        AND ORG_ID          = P_ORG_ID          --사업부아이디
        AND FS_SET_ID       = P_FS_SET_ID       --보고서기준세트아이디 
        AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --보고서양식ID(공통코드)
    ; 



    --2단계 - 2
    --FI_ACCOUNT_CONTROL 테이블을 기준으로 자기를 상위계정으로 하고 있는 계정들을 INSERT한다.

	FOR C_REC IN (
        SELECT
              FORM_TYPE_ID  --보고서양식ID(공통코드)
            , ITEM_CODE     --항목코드_계정코드
        FROM FI_FORM_DET
        WHERE   SOB_ID          = P_SOB_ID          --회사아이디
            AND ORG_ID          = P_ORG_ID          --사업부아이디
            AND FS_SET_ID       = P_FS_SET_ID       --보고서기준세트아이디
            AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --보고서양식ID(공통코드)
    ) LOOP
    
        INSERT INTO FI_FORM_DET(
              SOB_ID	            --회사아이디
            , ORG_ID	            --사업부아이디
            , FS_SET_ID	            --보고서기준세트아이디
            , FORM_TYPE_ID	        --보고서양식ID(공통코드)
            , ITEM_CODE	            --항목코드_계정코드
            , FORM_SEQ	            --재무제표보고서일련번호
            , DET_ITEM_CODE	        --상세항목코드
            , ACCOUNT_CONTROL_ID    --계정관리아이디
            , ITEM_SIGN_SHOW        --연산부호(+/-)
            , ENABLED_FLAG	        --사용여부
            , REMARKS	            --비고
            , CREATION_DATE	        --생성일
            , CREATED_BY	        --생성자
            , LAST_UPDATE_DATE	    --수정일
            , LAST_UPDATED_BY	    --수정자    
        )
        SELECT 
              SOB_ID                --회사아이디
            , ORG_ID                --사업부아이디
            , P_FS_SET_ID           --보고서기준세트아이디        
            , C_REC.FORM_TYPE_ID    --보고서양식ID(공통코드)            
            , C_REC.ITEM_CODE       --항목코드_계정코드
            
            --[+ 1000]을 한 이유는 계정과목이 1000개는 넘지않으리라 생각하고 일련번호를 채번하기 위해서이다.
            , ROW_NUMBER() OVER(ORDER BY ACCOUNT_CODE ASC) + 1000 AS FORM_SEQ --재무제표보고서일련번호
            , ACCOUNT_CODE AS DET_ITEM_CODE                 --상세항목코드 
            , ACCOUNT_CONTROL_ID                            --계정관리아이디
            , '+' AS ITEM_SIGN_SHOW                         --연산부호(+/-)            
            , 'Y' ENABLED_FLAG                              --사용여부
            , '' AS REMARKS                                 --비고
            , GET_LOCAL_DATE(SOB_ID) AS CREATION_DATE       --생성일
            , P_CREATED_BY                                  --생성자
            , GET_LOCAL_DATE(SOB_ID) AS LAST_UPDATE_DATE    --수정일
            , P_CREATED_BY                                  --수정자
        FROM FI_ACCOUNT_CONTROL
        WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND ACCOUNT_SET_ID = '10'
            AND UP_ACCOUNT_CODE = C_REC.ITEM_CODE
        ;
        
    END LOOP;
    
    EXCEPTION
        WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');  

END CREATE_FORM_MST;















--재무제표보고서 양식 => 마스터 grid에 조회되는 자료 추출

PROCEDURE LIST_FORM_MST( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --보고서양식ID(공통코드)
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	    --회사아이디
        , ORG_ID	    --사업부아이디
        , FS_SET_ID	    --보고서기준세트아이디
        , FORM_TYPE_ID	--보고서양식ID(공통코드)    
        , ITEM_CODE	    --항목코드_계정코드        
        , ITEM_NAME	    --항목명
        , ACCOUNT_DR_CR	--차대구분(1-차변,2-대변)
        , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', ACCOUNT_DR_CR, SOB_ID) AS ACCOUNT_DR_CR_NAME
        , NVL(MNS_ACCOUNT_FLAG, 'N') AS MNS_ACCOUNT_FLAG    --차감계정여부
        , RELATE_ITEM_CODE                                  --연동항목코드
        , RELATE_ITEM_CODE_NAME_F(SOB_ID, ORG_ID, FS_SET_ID, FORM_TYPE_ID, RELATE_ITEM_CODE) AS RELATE_ITEM_CODE_NAME                             --연동항목코드_명
        , SORT_SEQ	                                        --정렬순서
        , ITEM_LEVEL	                                    --항목레벨
        , ENABLED_FLAG	                                    --사용여부
        , REMARKS	                                        --비고
        
        , REF_FORM_TYPE_ID                                              --관련보고서양식ID(공통코드)
        , FI_COMMON_G.ID_NAME_F(REF_FORM_TYPE_ID) AS REF_FORM_TYPE_NAME --관련보고서양식    
        , REF_ITEM_CODE                                                 --관련항목코드
        , FI_FORM_MST_G.RELATE_ITEM_CODE_NAME_F(SOB_ID, ORG_ID, FS_SET_ID, REF_FORM_TYPE_ID, REF_ITEM_CODE) AS REF_ITEM_CODE_NAME --관련항목
        , NVL(SUMMARY_YN, 'N')AS SUMMARY_YN                             --요약재무제표항목여부
        
        , FORM_ITEM_TYPE_CD --재고자산기말금액관리항목코드
        , FI_COMMON_G.CODE_NAME_F('FORM_ITEM_TYPE', FORM_ITEM_TYPE_CD, SOB_ID) AS FORM_ITEM_TYPE_NAME
        , FORM_FRAME_YN     --보고서틀유지여부        
    FROM FI_FORM_MST
    WHERE   SOB_ID          = W_SOB_ID          --회사아이디
        AND ORG_ID          = W_ORG_ID          --사업부아이디
        AND FS_SET_ID       = W_FS_SET_ID       --보고서기준세트아이디
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --보고서양식ID(공통코드)
    ORDER BY SORT_SEQ;

END LIST_FORM_MST;






--재무제표보고서 양식 => 클릭한 항목과 연동될 항목을 추출한다.
--클릭한 항목과 동 레벨의 등록된 항목이 추출된다.
--이는 화면에서 팝업으로 사용되며, 연동항목은 실질적으로 [재무상태표]에서만 사용한다.
PROCEDURE POP_RELATE_ITEM( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --보고서양식ID(공통코드)
    , W_ITEM_LEVEL      IN FI_FORM_MST.ITEM_LEVEL%TYPE      --항목레벨
)

AS

BEGIN
    OPEN P_CURSOR FOR

    SELECT
          ITEM_NAME	    --항목명    
        , ITEM_CODE	    --항목코드_계정코드        
        , ITEM_LEVEL	--항목레벨       
    FROM FI_FORM_MST
    WHERE   SOB_ID          = W_SOB_ID          --회사아이디
        AND ORG_ID          = W_ORG_ID          --사업부아이디
        AND FS_SET_ID       = W_FS_SET_ID       --보고서기준세트아이디
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --보고서양식ID(공통코드)
        AND ITEM_LEVEL      = W_ITEM_LEVEL      --항목레벨
        AND ENABLED_FLAG    = 'Y'               --사용여부
    ORDER BY SORT_SEQ;                          --정렬순서

END POP_RELATE_ITEM;






--재무제표보고서 양식 => 클릭한 항목의 값을 가져올 타 보고서양식에 등록된 항목을 보여준다.
--예>손익계산서의 당기제품제조원가 항목의 값은 제조원가명세서의 당기제품제조원가 항목의 값을 이용한다.
--이는 화면에서 팝업으로 사용되며, 관련항목은 실질적으로 [손익계산서, 재무상태표]에서만 사용한다.
PROCEDURE POP_REF_ITEM( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --보고서양식ID(공통코드)
)

AS

BEGIN
    OPEN P_CURSOR FOR

    SELECT
          ITEM_NAME	    --항목명    
        , ITEM_CODE	    --항목코드_계정코드        
        , ITEM_LEVEL	--항목레벨       
    FROM FI_FORM_MST
    WHERE   SOB_ID          = W_SOB_ID          --회사아이디
        AND ORG_ID          = W_ORG_ID          --사업부아이디
        AND FS_SET_ID       = W_FS_SET_ID       --보고서기준세트아이디
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --보고서양식ID(공통코드)
        AND ENABLED_FLAG    = 'Y'               --사용여부
    ORDER BY SORT_SEQ;                          --정렬순서

END POP_REF_ITEM;






--재무제표보고서 양식 => 마스터 grid에 신규 항목 추가
PROCEDURE INSERT_FORM_MST( 
      P_SOB_ID	            IN  FI_FORM_MST.SOB_ID%TYPE	            --회사아이디
    , P_ORG_ID	            IN  FI_FORM_MST.ORG_ID%TYPE	            --사업부아이디
    , P_FS_SET_ID	        IN  FI_FORM_MST.FS_SET_ID%TYPE	        --보고서기준세트아이디
    , P_FORM_TYPE_ID	    IN  FI_FORM_MST.FORM_TYPE_ID%TYPE	    --보고서양식ID(공통코드)
    , P_ITEM_CODE	        IN  FI_FORM_MST.ITEM_CODE%TYPE	        --항목코드_계정코드
    , P_ITEM_NAME	        IN	FI_FORM_MST.ITEM_NAME%TYPE	        --항목명
    , P_ACCOUNT_DR_CR	    IN	FI_FORM_MST.ACCOUNT_DR_CR%TYPE	    --차대구분(1-차변,2-대변)
    , P_MNS_ACCOUNT_FLAG    IN	FI_FORM_MST.MNS_ACCOUNT_FLAG%TYPE	--차감계정여부
    , P_RELATE_ITEM_CODE	IN	FI_FORM_MST.RELATE_ITEM_CODE%TYPE	--연동항목코드
    , P_SORT_SEQ	        IN	FI_FORM_MST.SORT_SEQ%TYPE	        --정렬순서
    , P_ITEM_LEVEL	        IN	FI_FORM_MST.ITEM_LEVEL%TYPE	        --항목레벨
    , P_ENABLED_FLAG	    IN	FI_FORM_MST.ENABLED_FLAG%TYPE	    --사용여부
    , P_REMARKS	            IN	FI_FORM_MST.REMARKS%TYPE	        --비고
    , P_CREATED_BY	        IN	FI_FORM_MST.CREATED_BY%TYPE	        --생성자 
    
    , P_REF_FORM_TYPE_ID	IN	FI_FORM_MST.REF_FORM_TYPE_ID%TYPE   --관련보고서양식ID(공통코드)
    , P_REF_ITEM_CODE	    IN	FI_FORM_MST.REF_ITEM_CODE%TYPE	    --관련항목코드
    , P_SUMMARY_YN	        IN	FI_FORM_MST.SUMMARY_YN%TYPE	        --요약재무제표항목여부
    
    , P_FORM_ITEM_TYPE_CD	IN	FI_FORM_MST.FORM_ITEM_TYPE_CD%TYPE  --재고자산기말금액관리항목코드
    , P_FORM_FRAME_YN	    IN	FI_FORM_MST.FORM_FRAME_YN%TYPE	    --보고서틀유지여부    
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
V_RECORD_COUNT NUMBER := 0;

BEGIN

    --추가하려는 자료가 이미 존재하는지를 파악한다.
    SELECT COUNT(*)
    INTO V_RECORD_COUNT
    FROM FI_FORM_MST
    WHERE   SOB_ID          = P_SOB_ID          --회사아이디
        AND ORG_ID          = P_ORG_ID          --사업부아이디
        AND FS_SET_ID       = P_FS_SET_ID       --보고서기준세트아이디
        AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --보고서양식ID(공통코드)
        AND ITEM_CODE       = P_ITEM_CODE       --항목코드_계정코드
    ;    
    
    --FCM_10273, 동일한 코드의 자료가 존재하여 등록할 수 없습니다. 확인바랍니다.
    IF V_RECORD_COUNT > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10273', NULL));
    END IF;

    INSERT INTO FI_FORM_MST(
          SOB_ID	        --회사아이디
        , ORG_ID	        --사업부아이디
        , FS_SET_ID	        --보고서기준세트아이디
        , FORM_TYPE_ID	    --보고서양식ID(공통코드)
        , ITEM_CODE	        --항목코드_계정코드
        , ITEM_NAME	        --항목명
        , ACCOUNT_DR_CR	    --차대구분(1-차변,2-대변)
        , MNS_ACCOUNT_FLAG	--차감계정여부
        , RELATE_ITEM_CODE	--연동항목코드
        , SORT_SEQ	        --정렬순서
        , ITEM_LEVEL	    --항목레벨
        , ENABLED_FLAG	    --사용여부        
        , REF_FORM_TYPE_ID	--관련보고서양식ID(공통코드)
        , REF_ITEM_CODE	    --관련항목코드
        , SUMMARY_YN	    --요약재무제표항목여부
        , FORM_ITEM_TYPE_CD	--재고자산기말금액관리항목코드
        , FORM_FRAME_YN	    --보고서틀유지여부
        , REMARKS	        --비고
        , CREATION_DATE     --생성일
        , CREATED_BY	    --생성자
        , LAST_UPDATE_DATE  --수정일
        , LAST_UPDATED_BY	--수정자          
    )
    VALUES(
          P_SOB_ID	            --회사아이디
        , P_ORG_ID	            --사업부아이디
        , P_FS_SET_ID	        --보고서기준세트아이디
        , P_FORM_TYPE_ID	    --보고서양식ID(공통코드)
        , P_ITEM_CODE	        --항목코드_계정코드
        , P_ITEM_NAME	        --항목명
        , P_ACCOUNT_DR_CR	    --차대구분(1-차변,2-대변)
        , P_MNS_ACCOUNT_FLAG	--차감계정여부
        , P_RELATE_ITEM_CODE	--연동항목코드
        , P_SORT_SEQ	        --정렬순서
        , P_ITEM_LEVEL	        --항목레벨
        , P_ENABLED_FLAG	    --사용여부        
        , P_REF_FORM_TYPE_ID	--관련보고서양식ID(공통코드)
        , P_REF_ITEM_CODE	    --관련항목코드
        , P_SUMMARY_YN	        --요약재무제표항목여부
        , P_FORM_ITEM_TYPE_CD	--재고자산기말금액관리항목코드
        , P_FORM_FRAME_YN	    --보고서틀유지여부        
        , P_REMARKS	            --비고
        , V_SYSDATE             --생성일
        , P_CREATED_BY	        --생성자
        , V_SYSDATE             --수정일
        , P_CREATED_BY	        --수정자    
    );

END INSERT_FORM_MST;







--재무제표보고서 양식 => 마스터 grid에 조회된 자료 UPDATE
PROCEDURE UPDATE_FORM_MST( 
      W_SOB_ID              IN  FI_FORM_MST.SOB_ID%TYPE              --회사아이디
    , W_ORG_ID              IN  FI_FORM_MST.ORG_ID%TYPE              --사업부아이디
    , W_FS_SET_ID           IN  FI_FORM_MST.FS_SET_ID%TYPE           --보고서기준세트아이디
    , W_FORM_TYPE_ID        IN  FI_FORM_MST.FORM_TYPE_ID%TYPE        --보고서양식ID(공통코드)
    , W_ITEM_CODE           IN  FI_FORM_MST.ITEM_CODE%TYPE           --항목코드_계정코드
    
    , P_ITEM_NAME           IN  FI_FORM_MST.ITEM_NAME%TYPE           --항목명
    , P_ACCOUNT_DR_CR       IN  FI_FORM_MST.ACCOUNT_DR_CR%TYPE       --차대구분(1-차변,2-대변)
    , P_MNS_ACCOUNT_FLAG    IN  FI_FORM_MST.MNS_ACCOUNT_FLAG%TYPE    --차감계정여부
    , P_RELATE_ITEM_CODE    IN  FI_FORM_MST.RELATE_ITEM_CODE%TYPE    --연동항목코드
    , P_SORT_SEQ            IN  FI_FORM_MST.SORT_SEQ%TYPE            --정렬순서
    , P_ITEM_LEVEL          IN  FI_FORM_MST.ITEM_LEVEL%TYPE          --항목레벨
    , P_ENABLED_FLAG        IN  FI_FORM_MST.ENABLED_FLAG%TYPE        --사용여부
    , P_REMARKS             IN  FI_FORM_MST.REMARKS%TYPE             --비고
    , P_LAST_UPDATED_BY     IN  FI_FORM_MST.LAST_UPDATED_BY%TYPE     --수정자
    
    , P_REF_FORM_TYPE_ID	IN  FI_FORM_MST.REF_FORM_TYPE_ID%TYPE   --관련보고서양식ID(공통코드)
    , P_REF_ITEM_CODE	    IN	FI_FORM_MST.REF_ITEM_CODE%TYPE	    --관련항목코드
    , P_SUMMARY_YN	        IN	FI_FORM_MST.SUMMARY_YN%TYPE	        --요약재무제표항목여부 
    
    , P_FORM_ITEM_TYPE_CD	IN	FI_FORM_MST.FORM_ITEM_TYPE_CD%TYPE  --재고자산기말금액관리항목코드
    , P_FORM_FRAME_YN	    IN	FI_FORM_MST.FORM_FRAME_YN%TYPE	    --보고서틀유지여부    
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);

BEGIN

    UPDATE FI_FORM_MST
    SET
          ITEM_NAME         = P_ITEM_NAME       
        , ACCOUNT_DR_CR     = P_ACCOUNT_DR_CR   
        , MNS_ACCOUNT_FLAG  = P_MNS_ACCOUNT_FLAG
        , RELATE_ITEM_CODE  = P_RELATE_ITEM_CODE
        , SORT_SEQ          = P_SORT_SEQ     
        , ITEM_LEVEL        = P_ITEM_LEVEL      
        , ENABLED_FLAG      = P_ENABLED_FLAG
        , REF_FORM_TYPE_ID  = P_REF_FORM_TYPE_ID     
        , REF_ITEM_CODE     = P_REF_ITEM_CODE      
        , SUMMARY_YN        = P_SUMMARY_YN        
        , FORM_ITEM_TYPE_CD	= P_FORM_ITEM_TYPE_CD   --재고자산기말금액관리항목코드
        , FORM_FRAME_YN	    = P_FORM_FRAME_YN       --보고서틀유지여부                
        , REMARKS           = P_REMARKS
        , LAST_UPDATE_DATE  = V_SYSDATE
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY         
    WHERE   SOB_ID          = W_SOB_ID          --회사아이디
        AND ORG_ID          = W_ORG_ID          --사업부아이디
        AND FS_SET_ID       = W_FS_SET_ID       --보고서기준세트아이디
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --보고서양식ID(공통코드)
        AND ITEM_CODE       = W_ITEM_CODE       --항목코드_계정코드
    ;

END UPDATE_FORM_MST;





--재무제표보고서 양식 => 마스터 grid에 조회된 자료 삭제
PROCEDURE DELETE_FORM_MST( 
      W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --보고서양식ID(공통코드)
    , W_ITEM_CODE       IN FI_FORM_MST.ITEM_CODE%TYPE       --항목코드_계정코드
)

AS

V_RECORD_COUNT NUMBER := 0;

BEGIN

    --삭제하려는 항목코드를 연동항목으로 연동되어있는 자료가 있는지 파악
    SELECT COUNT(*)
    INTO V_RECORD_COUNT
    FROM FI_FORM_MST
    WHERE   SOB_ID              = W_SOB_ID          --회사아이디
        AND ORG_ID              = W_ORG_ID          --사업부아이디
        AND FS_SET_ID           = W_FS_SET_ID       --보고서기준세트아이디
        AND FORM_TYPE_ID        = W_FORM_TYPE_ID    --보고서양식ID(공통코드)
        AND RELATE_ITEM_CODE    = W_ITEM_CODE       --연동항목코드
    ;    
    
    --FCM_10274, 삭제하려는 자료를 연동항목으로 사용하는 자료가 있어 삭제할 수 없습니다.
    IF V_RECORD_COUNT <> 0 THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10274', NULL));
    END IF;

    --마스터 테이블 삭제
    DELETE FI_FORM_MST
    WHERE   SOB_ID          = W_SOB_ID          --회사아이디
        AND ORG_ID          = W_ORG_ID          --사업부아이디
        AND FS_SET_ID       = W_FS_SET_ID       --보고서기준세트아이디
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --보고서양식ID(공통코드)
        AND ITEM_CODE       = W_ITEM_CODE       --항목코드_계정코드
    ;
    
    
    --상세 테이블 삭제
    DELETE FI_FORM_DET
    WHERE   SOB_ID          = W_SOB_ID          --회사아이디
        AND ORG_ID          = W_ORG_ID          --사업부아이디
        AND FS_SET_ID       = W_FS_SET_ID       --보고서기준세트아이디
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --보고서양식ID(공통코드)
        AND ITEM_CODE       = W_ITEM_CODE       --항목코드_계정코드
    ;    
    

END DELETE_FORM_MST;






--관련 탭 : 누락계정조회
--취지 : 계정과목관리 프로그램에서는 임의의 계정에 대해 재무제표양식을 설정했는데
--       이 설정된 계정이 재무제표양식관리 프로그램의 해당 보고서 양식에는 포함되지 않은
--       계정들을 조회하고자 함이다.
PROCEDURE LIST_OMISSION_ACCOUNT( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --보고서양식ID(공통코드)
)

AS

t_ACCOUNT_FS_TYPE   FI_ACCOUNT_CONTROL.ACCOUNT_FS_TYPE%TYPE; --재무제표관리 값을 담기위함.

BEGIN

    IF W_FORM_TYPE_ID = 744 THEN    --합계잔액시산표 누락계정조회
        OPEN P_CURSOR FOR

        SELECT
              ACCOUNT_CODE      --계정코드
            , ACCOUNT_DESC      --계정명
            , ACCOUNT_DR_CR     --차/대구분(1-차변,2-대변)
            , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', ACCOUNT_DR_CR, SOB_ID) AS ACCOUNT_DR_CR_NAME --차/대구분
            , ACCOUNT_FS_TYPE                                                                       --재무제표양식
            , FI_COMMON_G.CODE_NAME_F('FORM_TYPE', ACCOUNT_FS_TYPE, SOB_ID) AS ACCOUNT_FS_TYPE_NAME --재무제표양식
            , NVL(ENABLED_FLAG, 'N') AS ENABLED_FLAG                                                --전표입력여부
            , UP_ACCOUNT_CODE   --상위계정코드
            , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(
                      (SELECT ACCOUNT_CONTROL_ID
                      FROM FI_ACCOUNT_CONTROL
                      WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CODE = A.UP_ACCOUNT_CODE)
                    , SOB_ID) AS UP_ACCOUNT_NAME    --상위계정명
            , RELATE_ACCOUNT_CODE                   --연동계정코드
            , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(
                      (SELECT ACCOUNT_CONTROL_ID
                      FROM FI_ACCOUNT_CONTROL
                      WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CODE = A.RELATE_ACCOUNT_CODE)
                    , SOB_ID) AS RELATE_ACCOUNT_NAME    --연동계정명    
        FROM FI_ACCOUNT_CONTROL A
        WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
            --AND ACCOUNT_FS_TYPE IS NOT NULL
            AND ACCOUNT_FS_TYPE IN ('1002', '1003', '1004') --이 한문장만 아래 쿼리와 다르다.
            AND ACCOUNT_CODE NOT IN 
                (
                    SELECT ITEM_CODE
                    FROM FI_FORM_MST
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID
                        AND FS_SET_ID = W_FS_SET_ID
                        AND FORM_TYPE_ID = W_FORM_TYPE_ID        
                )
        ORDER BY ACCOUNT_CODE;   
        
    ELSE    --합계잔액시산표 외 누락계정조회
    
        IF W_FORM_TYPE_ID = 747 THEN        --제조원가명세서 
            t_ACCOUNT_FS_TYPE := '1004';          
        ELSIF W_FORM_TYPE_ID = 746 THEN     --손익계산서 
            t_ACCOUNT_FS_TYPE := '1003';            
        ELSIF W_FORM_TYPE_ID = 745 THEN     --재무상태표(대차대조표)
            t_ACCOUNT_FS_TYPE := '1002';        
        END IF;



        OPEN P_CURSOR FOR

        SELECT
              ACCOUNT_CODE      --계정코드
            , ACCOUNT_DESC      --계정명
            , ACCOUNT_DR_CR     --차/대구분(1-차변,2-대변)
            , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', ACCOUNT_DR_CR, SOB_ID) AS ACCOUNT_DR_CR_NAME --차/대구분
            , ACCOUNT_FS_TYPE                                                                       --재무제표양식
            , FI_COMMON_G.CODE_NAME_F('FORM_TYPE', ACCOUNT_FS_TYPE, SOB_ID) AS ACCOUNT_FS_TYPE_NAME --재무제표양식
            , NVL(ENABLED_FLAG, 'N') AS ENABLED_FLAG                                                --전표입력여부
            , UP_ACCOUNT_CODE   --상위계정코드
            , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(
                      (SELECT ACCOUNT_CONTROL_ID
                      FROM FI_ACCOUNT_CONTROL
                      WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CODE = A.UP_ACCOUNT_CODE)
                    , SOB_ID) AS UP_ACCOUNT_NAME    --상위계정명
            , RELATE_ACCOUNT_CODE                   --연동계정코드
            , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(
                      (SELECT ACCOUNT_CONTROL_ID
                      FROM FI_ACCOUNT_CONTROL
                      WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CODE = A.RELATE_ACCOUNT_CODE)
                    , SOB_ID) AS RELATE_ACCOUNT_NAME   --연동계정명    
        FROM FI_ACCOUNT_CONTROL A
        WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
            AND ACCOUNT_FS_TYPE = t_ACCOUNT_FS_TYPE --이 한문장만 위 쿼리와 다르다.
            AND ACCOUNT_CODE NOT IN 
                (
                    SELECT ITEM_CODE
                    FROM FI_FORM_MST
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID
                        AND FS_SET_ID = W_FS_SET_ID
                        AND FORM_TYPE_ID = W_FORM_TYPE_ID        
                )
        ORDER BY ACCOUNT_CODE;
        
    END IF;


END LIST_OMISSION_ACCOUNT;







--선택한 항목의 연동항목코드에 대한 명을 구하는 공통함수.
FUNCTION RELATE_ITEM_CODE_NAME_F(
      W_SOB_ID              IN FI_FORM_MST.SOB_ID%TYPE              --회사아이디
    , W_ORG_ID              IN FI_FORM_MST.ORG_ID%TYPE              --사업부아이디
    , W_FS_SET_ID           IN FI_FORM_MST.FS_SET_ID%TYPE           --보고서기준세트아이디
    , W_FORM_TYPE_ID        IN FI_FORM_MST.FORM_TYPE_ID%TYPE        --보고서양식ID(공통코드)
    , W_RELATE_ITEM_CODE    IN FI_FORM_MST.RELATE_ITEM_CODE%TYPE    --연동항목코드
) RETURN VARCHAR2

AS

t_RELATE_ITEM_CODE_NAME FI_FORM_MST.ITEM_NAME%TYPE := '';   --조회된 자료 목록 중에서 최하위레벨을 구한다.

BEGIN

    SELECT ITEM_NAME
    INTO t_RELATE_ITEM_CODE_NAME
    FROM FI_FORM_MST
    WHERE   SOB_ID          = W_SOB_ID              --회사아이디
        AND ORG_ID          = W_ORG_ID              --사업부아이디
        AND FS_SET_ID       = W_FS_SET_ID           --보고서기준세트아이디
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID        --보고서양식ID(공통코드)
        AND ITEM_CODE       = W_RELATE_ITEM_CODE    --항목코드_계정코드
    ;
    
    RETURN t_RELATE_ITEM_CODE_NAME;

END RELATE_ITEM_CODE_NAME_F;



--재무제표보고서 양식 복사위해 기존 데이터 존재 여부 체크.
PROCEDURE GET_FORM_MST_COUNT( 
      P_SOB_ID            IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , P_ORG_ID            IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , P_FS_SET_ID         IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디    
    , P_FORM_TYPE_ID      IN FI_FORM_MST.FORM_TYPE_ID%TYPE     --보고서양식ID    
    , O_RECORD_COUNT      OUT NUMBER
)
AS
BEGIN
    O_RECORD_COUNT := 0;
    BEGIN
      -- DELETE --
      SELECT COUNT(FM.FORM_TYPE_ID) AS RECORD_COUNT
        INTO O_RECORD_COUNT
        FROM FI_FORM_MST FM
       WHERE FM.FS_SET_ID         = P_FS_SET_ID 
         AND FM.FORM_TYPE_ID      = P_FORM_TYPE_ID 
         AND FM.SOB_ID            = P_SOB_ID
         AND FM.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_RECORD_COUNT := 0;
    END;
END GET_FORM_MST_COUNT;


--재무제표보고서 양식 복사 
--1단계 : FI_FORM_MST(재무제표보고서양식_마스터) 테이블에 DATA INSERT
--2단계 : FI_FORM_DET(재무제표보고서양식_상세)   테이블에 DATA INSERT
PROCEDURE COPY_FORM_MST( 
      P_SOB_ID            IN FI_FORM_MST.SOB_ID%TYPE          --회사아이디
    , P_ORG_ID            IN FI_FORM_MST.ORG_ID%TYPE          --사업부아이디
    , P_FS_SET_ID         IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서기준세트아이디    
    , P_FORM_TYPE_ID      IN FI_FORM_MST.FS_SET_ID%TYPE       --보고서양식ID    
    , P_NEW_FS_SET_ID     IN FI_FORM_MST.FS_SET_ID%TYPE       --신규 보고서기준세트아이디    
    , P_NEW_FORM_TYPE_ID  IN FI_FORM_MST.FS_SET_ID%TYPE       --신규 보고서양식ID
    , P_USER_ID           IN FI_FORM_MST.CREATED_BY%TYPE	    --생성자
    , O_STATUS            OUT VARCHAR2
    , O_MESSAGE           OUT VARCHAR2
)
AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
BEGIN
    O_STATUS := 'F';
    
    -- DELETE --
    DELETE FROM FI_FORM_MST FM
     WHERE FM.FS_SET_ID         = P_NEW_FS_SET_ID 
       AND FM.FORM_TYPE_ID      = P_NEW_FORM_TYPE_ID 
       AND FM.SOB_ID            = P_SOB_ID
       AND FM.ORG_ID            = P_ORG_ID
    ;
    DELETE FROM FI_FORM_DET FD
     WHERE FD.FS_SET_ID         = P_NEW_FS_SET_ID 
       AND FD.FORM_TYPE_ID      = P_NEW_FORM_TYPE_ID 
       AND FD.SOB_ID            = P_SOB_ID
       AND FD.ORG_ID            = P_ORG_ID
    ;
    
    -- INSERT --
    FOR C1 IN ( SELECT FFM.SOB_ID 
                     , FFM.ORG_ID 
                     , FFM.FS_SET_ID
                     , FFM.FORM_TYPE_ID
                     , P_NEW_FS_SET_ID AS NEW_FS_SET_ID 
                     , P_NEW_FORM_TYPE_ID AS NEW_FORM_TYPE_ID 
                     , FFM.ITEM_CODE 
                     , FFM.ITEM_NAME 
                     , FFM.ACCOUNT_DR_CR 
                     , FFM.MNS_ACCOUNT_FLAG 
                     , FFM.RELATE_ITEM_CODE 
                     , FFM.SORT_SEQ 
                     , FFM.ITEM_LEVEL 
                     , FFM.ENABLED_FLAG 
                     , FFM.REF_FORM_TYPE_ID 
                     , FFM.REF_ITEM_CODE 
                     , FFM.SUMMARY_YN 
                     , FFM.FORM_ITEM_TYPE_CD
                     , FFM.FORM_FRAME_YN 
                     , FFM.REMARKS 
                     , V_SYSDATE AS CREATION_DATE 
                     , P_USER_ID AS CREATED_BY 
                     , V_SYSDATE AS LAST_UPDATE_DATE 
                     , P_USER_ID AS LAST_UPDATED_BY 
                  FROM FI_FORM_MST FFM
                 WHERE FFM.FS_SET_ID      = P_FS_SET_ID
                   AND FFM.FORM_TYPE_ID   = P_FORM_TYPE_ID
                   AND FFM.SOB_ID         = P_SOB_ID
                   AND FFM.ORG_ID         = P_ORG_ID
                ORDER BY FFM.SORT_SEQ
               )
    LOOP
      FOR D1 IN ( SELECT FD.SOB_ID 
                       , FD.ORG_ID 
                       , FD.FS_SET_ID 
                       , FD.FORM_TYPE_ID 
                       , FD.ITEM_CODE 
                       , FD.FORM_SEQ 
                       , FD.DET_ITEM_CODE 
                       , FD.ACCOUNT_CONTROL_ID 
                       , FD.ITEM_SIGN_SHOW 
                       , FD.ENABLED_FLAG 
                       , FD.REMARKS 
                    FROM FI_FORM_DET FD
                   WHERE FD.FS_SET_ID     = C1.FS_SET_ID
                     AND FD.FORM_TYPE_ID  = C1.FORM_TYPE_ID
                     AND FD.ITEM_CODE     = C1.ITEM_CODE
                     AND FD.SOB_ID        = C1.SOB_ID
                     AND FD.ORG_ID        = C1.ORG_ID
                  ORDER BY FD.FORM_SEQ
                 )
      LOOP
        BEGIN
          INSERT INTO FI_FORM_DET
          ( SOB_ID 
          , ORG_ID 
          , FS_SET_ID 
          , FORM_TYPE_ID 
          , ITEM_CODE 
          , FORM_SEQ 
          , DET_ITEM_CODE 
          , ACCOUNT_CONTROL_ID 
          , ITEM_SIGN_SHOW 
          , ENABLED_FLAG 
          , REMARKS 
          , CREATION_DATE 
          , CREATED_BY 
          , LAST_UPDATE_DATE 
          , LAST_UPDATED_BY 
          ) VALUES
          ( C1.SOB_ID 
          , C1.ORG_ID 
          , C1.NEW_FS_SET_ID 
          , C1.NEW_FORM_TYPE_ID 
          , D1.ITEM_CODE 
          , D1.FORM_SEQ 
          , D1.DET_ITEM_CODE 
          , D1.ACCOUNT_CONTROL_ID 
          , D1.ITEM_SIGN_SHOW 
          , D1.ENABLED_FLAG 
          , D1.REMARKS 
          , C1.CREATION_DATE 
          , C1.CREATED_BY 
          , C1.LAST_UPDATE_DATE 
          , C1.LAST_UPDATED_BY 
          );
        EXCEPTION WHEN OTHERS THEN
          O_STATUS := 'F';
          O_MESSAGE := 'Insert Detail Error : ' || SUBSTR(SQLERRM, 1, 200);
          RETURN;
        END;
      END LOOP D1;
      
      BEGIN
        INSERT INTO FI_FORM_MST
        ( SOB_ID 
        , ORG_ID 
        , FS_SET_ID 
        , FORM_TYPE_ID 
        , ITEM_CODE 
        , ITEM_NAME 
        , ACCOUNT_DR_CR 
        , MNS_ACCOUNT_FLAG 
        , RELATE_ITEM_CODE 
        , SORT_SEQ 
        , ITEM_LEVEL 
        , ENABLED_FLAG 
        , REF_FORM_TYPE_ID 
        , REF_ITEM_CODE 
        , SUMMARY_YN 
        , FORM_ITEM_TYPE_CD 
        , FORM_FRAME_YN 
        , REMARKS 
        , CREATION_DATE 
        , CREATED_BY 
        , LAST_UPDATE_DATE 
        , LAST_UPDATED_BY 
        ) VALUES
        ( C1.SOB_ID 
        , C1.ORG_ID 
        , C1.NEW_FS_SET_ID 
        , C1.NEW_FORM_TYPE_ID 
        , C1.ITEM_CODE 
        , C1.ITEM_NAME 
        , C1.ACCOUNT_DR_CR 
        , C1.MNS_ACCOUNT_FLAG 
        , C1.RELATE_ITEM_CODE 
        , C1.SORT_SEQ 
        , C1.ITEM_LEVEL 
        , C1.ENABLED_FLAG 
        , C1.REF_FORM_TYPE_ID 
        , C1.REF_ITEM_CODE 
        , C1.SUMMARY_YN 
        , C1.FORM_ITEM_TYPE_CD 
        , C1.FORM_FRAME_YN 
        , C1.REMARKS 
        , C1.CREATION_DATE 
        , C1.CREATED_BY 
        , C1.LAST_UPDATE_DATE 
        , C1.LAST_UPDATED_BY 
        );
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := 'Insert Master Error : [' || C1.NEW_FS_SET_ID || ',' || 
                                                  C1.NEW_FORM_TYPE_ID || ',' || 
                                                  C1.ITEM_CODE || '] ' || SUBSTR(SQLERRM, 1, 200);
        RETURN;
      END;
    END LOOP C1;
    O_STATUS := 'S';
END COPY_FORM_MST;


END FI_FORM_MST_G;
/
